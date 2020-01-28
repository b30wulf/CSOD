unit knsl2ems134meter;
//{$DEFINE EMS134_DEBUG}
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer
,knsl5tracer,utlTimeDate;
type
    CEMS134Meter = class(CMeter)
    Private
     pint, whmask   : Byte;
     nReq: CQueryPrimitive;
     //IsUpdate       : Boolean;
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     //procedure   SetHandScenarioCurr;
     //procedure   SetHandScenarioGraph;
     function    GetCommand(byCommand:Byte):Integer;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     function    LoHandler(var pMsg:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     function    CalculateCRC(Buffer : Array of Byte; Count : Integer) : word;
     function    CRC16(Buffer : Array of Byte; Count : Integer;var nCrc:word) : word;
     procedure   MsgHead(var pMsg:CHMessage; Size:byte);
     procedure   MovePA64(pDst, pSrc:PByteArray);
     procedure   MoveFloatToArray(pArr, pFloat:PByteArray);
     procedure   CorrTime(c : shortint);
     function    BcdToInt(buf:array of byte;count:integer):int64;
     function    BcDToData(mas:array of byte):TDateTime;
     function    BcDToTime(mas:array of byte):TDateTime;
     function    ProcessingData(var RxData : array of byte):boolean;
     function    StrToHex(str : string):int64;
     procedure   CreateMSG(paramNo : integer; param:single; tarif : byte);
     procedure   TestMSG(var pMsg:CMessage);
     procedure   EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
     function    GetStringFromFile(FileName : string; nStr : integer) : string;
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);
     procedure   OnDisconnectComplette(var pMsg:CMessage);
     procedure   HandQryRoutine(var pMsg:CMessage);
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   AddEnergyMonthGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   WriteDate();
     constructor Create;
    End;
implementation
constructor CEMS134Meter.Create;
Begin

End;

procedure CEMS134Meter.AddEnergyMonthGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   if (cDateTimeR.CompareMonth(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareMonth(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -12 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, abs(i + 1), 1, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, abs(i + 1), 2, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, abs(i + 1), 3, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, abs(i + 1), 4, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;

function  CEMS134Meter.StrToHex(str : string):int64;
var i    : byte;
    razr : byte;
begin
    Result := $00;
    i:=1;
    while i<=Length(str) do
    begin
      razr   := StrToInt(str[i]);
      Result := Result * $10 + razr;
      i:=i+1;
    end;
end;

procedure CEMS134Meter.MovePA64(pDst, pSrc:PByteArray);
begin
    pDst[1] := pSrc[0];
    pDst[2] := pSrc[1];
    pDst[3] := pSrc[2];
    pDst[4] := pSrc[3];
    pDst[5] := pSrc[4];
    pDst[6] := pSrc[5];
end;

procedure CEMS134Meter.MoveFloatToArray(pArr, pFloat:PByteArray);
begin
    pArr[0] := pFloat[0];
    pArr[1] := pFloat[1];
    pArr[2] := pFloat[2];
    pArr[3] := pFloat[3];
end;
procedure CEMS134Meter.MsgHead(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := Size;
    pMsg.m_swObjID     := m_nP.m_swMID;       //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;    //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ; //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID:= DEV_COM;       //DEF_COM
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_EMS134;     //Указать тип счетчика
    if IsUpdate=1 then
      pMsg.m_sbyDirID := 1
    else
      pMsg.m_sbyDirID := 0;
end;
procedure CEMS134Meter.InitMeter(var pL2:SL2TAG);
Begin
    pint   := 0;
    whmask := 0;
    //if m_nP.m_sbyHandScenr=0 then
    //Begin
    // SetCurrQry;
    // SetGraphQry;
    //end;
    //if m_nP.m_sbyHandScenr=1 then
    //Begin
     SetHandScenario;
     SetHandScenarioGraph;
    //end;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EMS134  Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;
procedure CEMS134Meter.SetCurrQry;
Begin
    with m_nObserver do
    Begin
     ClearCurrQry;
     //AddCurrParam(1, 0, 0, 0, 1);
     AddCurrParam(QRY_ENERGY_MON_EP, 0, 0, 0, 1);
     AddCurrParam(QRY_ENERGY_MON_EP, 0, 1, 0, 1);
     AddCurrParam(QRY_ENERGY_MON_EP, 0, 2, 0, 1);
     AddCurrParam(QRY_ENERGY_MON_EP, 0, 3, 0, 1);
     AddCurrParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
     AddCurrParam(QRY_ENERGY_SUM_EP, 0, 1, 0, 1);
     AddCurrParam(QRY_ENERGY_SUM_EP, 0, 2, 0, 1);
     AddCurrParam(QRY_ENERGY_SUM_EP, 0, 3, 0, 1);
     //Ask graphiks----------
     {AddCurrParam(2, 1, 4, 0, 1);
     AddCurrParam(3, 1, 4, 0, 1);
     AddCurrParam(4, 1, 4, 0, 1);
     AddCurrParam(5, 1, 4, 0, 1);}
     //----------------------
    End;
End;
procedure CEMS134Meter.SetGraphQry;
Begin

End;
{
procedure CEMS134Meter.SetHandScenarioCurr;
Var
    pQry   : PCQueryPrimitive;
Begin
    while(m_nObserver.GetCommand(pQry)=True) do
    Begin
     with m_nObserver do Begin
     ClearCurrQry;
     if pQry.m_swParamID<15 then TraceL(2,pQry.m_swMtrID,'(__)CL2MD::>EMS134 CMD INIT:'+IntToStr(pQry.m_swParamID)+':'+chQryType[pQry.m_swParamID]);
     case pQry.m_swParamID of
      EN_QRY_SUM:        //Енергия: суммарная накопленная
      Begin
       AddCurrParam(8, 0, 0, 0, 1);
       AddCurrParam(8, 0, 1, 0, 1);
       AddCurrParam(8, 0, 2, 0, 1);
       AddCurrParam(8, 0, 3, 0, 1);
      End;
      EN_QRY_INC_DAY:    //Енергия: Приращение за день
      Begin
      End;
      EN_QRY_INC_MON:    //Енергия: Приращение за месяц
      Begin
      End;
      EN_QRY_SRS_30M:    //Енергия: Cрез 30 мин
      Begin
      End;
      EN_QRY_ALL_DAY:    //Енергия: Начало суток
      Begin
      End;
      EN_QRY_ALL_MON:    //Енергия: Начало месяца
      Begin
       AddCurrParam(7, 0, 0, 0, 1);
       AddCurrParam(7, 0, 1, 0, 1);
       AddCurrParam(7, 0, 2, 0, 1);
       AddCurrParam(7, 0, 3, 0, 1);
      End;
      PW_QRY_SRS_3M:     //Мощность:Срез 3 мин
      Begin
      End;
      PW_QRY_SRS_30M:    //Мощность:Срез 30 мин
      Begin
      End;
      PW_QRY_MGACT:      //Мощность:Мгновенная активная
      Begin
      End;
      PW_QRY_MGRCT:      //Мощность:Мгновенная реактивная
      Begin
      End;
      U_QRY:             //Напряжение
      Begin
      End;
      I_QRY:             //Ток
      Begin
      End;
      F_QRY:             //Частота
      Begin
      End;
      KM_QRY:            //Коэффициент можности
      Begin
      End;
      DATE_QRY:          //Дата-время
      Begin
      End;
     End;
     End;//With
    End;
End;
procedure CEMS134Meter.SetHandScenarioGraph;
Begin
End;
}
function CEMS134Meter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;

procedure CEMS134Meter.WriteDate();
var i       : integer;
    m, d, y : word;
    TempDate: TDateTime;
begin
     TempDate := Now;
     for i := m_nTxMsg.m_sbyInfo[10] downto 1 do
       cDateTimeR.DecMonth(TempDate);
     cDateTimeR.IncMonth(TempDate);
     DecodeDate(TempDate, Y, M, D);
     m_nRxMsg.m_sbyInfo[2] := Y - 2000;
     m_nRxMsg.m_sbyInfo[3] := M;
     m_nRxMsg.m_sbyInfo[4] := D;
     m_nRxMsg.m_sbyInfo[5] := 00;
     m_nRxMsg.m_sbyInfo[6] := 00;
     m_nRxMsg.m_sbyInfo[7] := 00;

end;

procedure CEMS134Meter.CreateMSG(paramNo : integer; Param:single; tarif : byte);
var
    Hour, Min, Sec, mSec   : word;
    Year, Month, Day       : word;
    fParam                 : Double;
begin
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    //Year := Year - 2000;
    m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
    m_nRxMsg.m_swObjID    := m_nP.m_swMID;
    m_nRxMsg.m_sbyServerID:= 0;
    m_nRxMsg.m_sbyInfo[0] := 13+4;
    m_nRxMsg.m_sbyInfo[1] := paramNo;
    m_nRxMsg.m_sbyInfo[2] := Year - 2000;
    m_nRxMsg.m_sbyInfo[3] := Month;
    m_nRxMsg.m_sbyInfo[4] := Day;
    m_nRxMsg.m_sbyInfo[5] := Hour;
    m_nRxMsg.m_sbyInfo[6] := Min;
    m_nRxMsg.m_sbyInfo[7] := Sec;
    m_nRxMsg.m_sbyInfo[8] := tarif;
    if (paramNo>=QRY_ENERGY_MON_EP)and(paramNo<=QRY_ENERGY_MON_RM) then WriteDate;
    TraceL(2,2,FloatTOStr(param));
    fParam := Param;
    Move( fParam, m_nRxMsg.m_sbyInfo[9], sizeof(fParam));
    m_nRxMsg.m_swLen      := 11 + m_nRxMsg.m_sbyInfo[0];
    if IsUpdate=1 then
      m_nRxMsg.m_sbyDirID := 1
    else
      m_nRxMsg.m_sbyDirID := 0;
end;

function CEMS134Meter.ProcessingData(var RxData : array of byte):Boolean;
Var
    buf:array [1..8] of   byte;
    d                               : single;
    i, c                            : byte;
    w, timeForKor                   : word;
    min                             : single;
    data                            : longint;
    m, s, h, ms, mN, sN, hN, msN    : word;
    time                            : TDateTime;
    IsCorr                          : boolean;
begin
    if (m_nTxMsg.m_sbyInfo[9] = 1) then    //Date,Time,P+,P-,Q+,Q-,En тек/прошл
    begin     //Здесь производится коррекция времени
      IsCorr := false;
      move(RxData[9], buf, 5);
      time := BCDToTime(buf);
      DecodeTime(time, h, m, s, ms);
      DecodeTime(Now, hN, mN, sN, msN);
      timeForKor := (mN - m)*60 + sN - s;
      {if abs(lo(timeForKor)) >= 4 then
      begin
        IsCorr := true;
        CorrTime(timeForKor);
      end;}
      move(RxData[9], data, 4);
      min  := lo(lo(data shr 5 and $3f))+lo(data and $1f)/30;
      pint :=RxData[9+4];
      whmask:=bcdtoint(RxData[9+5],1);
      for i:=0 to 5 do
      begin
        move(RxData[9+6 + i*2], w, 2);
        if (i>2) or (min=pint) then
          d := w*6*whmask/pint
        else
          d := w*6*whmask/(min-trunc(min/pint)*pint);
          //CreateMSG();
          //TraceL(1, 1, FloatToStr(d));
      end;
      if (not IsCorr) then
        FinalAction;
    end;

    if (m_nTxMsg.m_sbyInfo[9] = 8) then //Суммарная энергия
    begin      //14+8
      d:=0;
      c:=trunc((RxData[0]-11)/4);
      if ((RxData[0]-11)<0)or(c>8) then
      Begin
       TraceL(3,m_nP.m_swMID,'(__)CL2MD::>EMS Error Data Len8!!!');
       FinalAction;
       exit;
      End;
      //c:=6;
      for i:=0 to 3 do
      begin
        move(RxData[9 + i*c], buf, c);
        d := bcdtoint(buf,c)/10000;
        //TraceL(2, 1, FloatToStr(d));
        case (m_nTxMsg.m_sbyInfo[11]) of
          0: CreateMsg(QRY_ENERGY_SUM_EP, d, i+1);
          1: CreateMsg(QRY_ENERGY_SUM_EM, d, i+1);
          2: CreateMsg(QRY_ENERGY_SUM_RP, d, i+1);
          3: CreateMsg(QRY_ENERGY_SUM_RM, d, i+1);
        end;
        FPUT(BOX_L3_BY,@m_nRxMsg);
      end;
      FinalAction;
    end;

    if (m_nTxMsg.m_sbyInfo[9] = 7) then //Месячная энергия
    begin
      d:=0;
      c:=trunc((RxData[0]-11)/4);

      if ((RxData[0]-11)<0)or(c>8) then
      Begin
       TraceL(3,m_nP.m_swMID,'(__)CL2MD::>EMS Error Data Len9!!!');
       FinalAction;
       exit;
      End;

      for i:=0 to 3 do
      begin
        move(RxData[9 + i*c], buf, c);
        d := bcdtoint(buf,4)/100;
        //TraceL(2, 1, FloatToStr(d));
        case (m_nTxMsg.m_sbyInfo[11]) of
          0: CreateMsg(QRY_ENERGY_MON_EP, d, i+1);
          1: CreateMsg(QRY_ENERGY_MON_EM, d, i+1);
          2: CreateMsg(QRY_ENERGY_MON_RP, d, i+1);
          3: CreateMsg(QRY_ENERGY_MON_RM, d, i+1);
        end;
        FPUT(BOX_L3_BY,@m_nRxMsg);
      end;
      FinalAction;
    end;

    {if (m_nTxMsg.m_sbyInfo[9] = 2) then //Срез мощности в прямом направлении
    begin
      TraceL(1, 1, 'Срез мощности в прямом направлении');
      SendSyncEvent;
    end;

    if (m_nTxMsg.m_sbyInfo[9] = 3) then //Срез мощности в обратном направлении
    begin
      TraceL(1, 1, 'Срез мощности в обратном направлении');
      SendSyncEvent;
    end;

    if (m_nTxMsg.m_sbyInfo[9] = 4) then //Срез энергии в прямом направлении
    begin
      TraceL(1, 1, 'Срез энергии в прямом направлении');
      SendSyncEvent;
    end;

    if (m_nTxMsg.m_sbyInfo[9] = 5) then //Срез энергии в обратном направлении
    begin
      TraceL(1, 1, 'Срез энергии в обратном направлении');
      SendSyncEvent;
    end;}
end;

function CEMS134Meter.LoHandler(var pMsg:CMessage):Boolean;
var crc,smToRead : word;
Begin
    //Обработчик для L1
    smToRead := 0;
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
       {$IFDEF EMS134_DEBUG}
         TestMsg(pMsg);
       {$ENDIF}
        //CRC16(pMsg.m_sbyInfo[0 + smToRead], pMsg.m_sbyInfo[0 + smToRead] - 2);
        crc :=  CalculateCRC(pMsg.m_sbyInfo, pMsg.m_sbyInfo[0]-2);
        if (pMsg.m_sbyInfo[0]<2)or(crc<>pMsg.m_sbyInfo[pMsg.m_sbyInfo[0]-2]+pMsg.m_sbyInfo[pMsg.m_sbyInfo[0]-1]*$100) then
        begin
          TraceL(3,pMsg.m_swObjID,'(__)CL2MD::>EMS  CRC Error!!!');
          {$IFDEF EMS134_DEBUG}
           OnFinalAction;
           exit;
          {$ELSE}
           exit;
          {$ENDIF}
        end;
        if (pMsg.m_sbyInfo[8] = 3) then
        begin
          SendSyncEvent;
          m_nRepTimer.OffTimer;
          exit; //Ответ от коррекции времени(пропускаю)
        end;
        if (pMsg.m_swLen < 30) then
          exit;
        TraceM(3,pMsg.m_swObjID,'(__)CL2MD::>EMS134  DIN:',@pMsg);
        if (pMsg.m_sbyInfo[0]=$0e) then ProcessingData(pMsg.m_sbyInfo[14]) else
        if (pMsg.m_sbyInfo[0]<>$0e) then ProcessingData(pMsg.m_sbyInfo[0]);
        //m_nRepTimer.OffTimer;
      End;
    End;
End;

procedure CEMS134Meter.HandQryRoutine(var pMsg:CMessage);
Var
    Date1, Date2 : TDateTime;
    param        : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := 1;
    OnEnterAction;
    m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param := pDS.m_swData1;
    case param of
      QRY_ENERGY_MON_EP   :
       Begin
        //m_nObserver.AddGraphParam(QM_ENT_MTR_IND, 0, 0, 0, 1);//Enter
        AddEnergyMonthGrpahQry(Date1, Date2);
        //m_nObserver.AddGraphParam(QM_FIN_MTR_IND, 0, 0, 0, 1);//Final
       End;
    end;
end;
function CEMS134Meter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
    //nReq: CQueryPrimitive;
    crc : word;
    Adr : int64;
Begin
    res := False;
    //Обработчик для L3
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
       if nReq.m_swParamID=QM_ENT_MTR_IND then Begin OnEnterAction;exit;End;
       if nReq.m_swParamID=QM_FIN_MTR_IND then Begin OnFinalAction;exit;End;
       if nReq.m_swParamID=QRY_KPRTEL_KE  then begin SendSyncEvent;exit;end;
       if nReq.m_swSpecc1=3               then begin OnFinalAction;exit;End;
       if nReq.m_swSpecc1=4               then begin OnFinalAction;exit;End;
       m_nTxMsg.m_sbyInfo[0]  := 14;                           //size
       Adr                    := StrToHex(m_nP.m_sddPHAddres);
       Move(Adr, m_nTxMsg.m_sbyInfo[1], 6);                    //ads
       m_nTxMsg.m_sbyInfo[7]  := 1;                            //adp
       m_nTxMsg.m_sbyInfo[8]  := 1;                            //com
       m_nTxMsg.m_sbyInfo[9]  := GetCommand(nReq.m_swParamID); //tab
       m_nTxMsg.m_sbyInfo[10] := nReq.m_swSpecc0;              //indx1
       m_nTxMsg.m_sbyInfo[11] := nReq.m_swSpecc1 - 0;          //indx2
       crc                    := CalculateCRC(m_nTxMsg.m_sbyInfo, 12);
       m_nTxMsg.m_sbyInfo[12] := (crc and $ff);
       m_nTxMsg.m_sbyInfo[13] := (crc and $ff00) shr 8;
       MSGHead(m_nTxMsg, 11 + 12 + 2);
       SendToL1(BOX_L1 ,@m_nTxMsg);
       TraceM(3,pMsg.m_swObjID,'(__)CL2MD::>EMS134 DRQ:',@m_nTxMsg);
       m_nRepTimer.OnTimer(m_nP.m_swRepTime);
      End;
      QL_DATA_GRAPH_REQ: HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    End;
    Result := res;
End;
procedure CEMS134Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    TraceM(4,pMsg.m_swObjID,'(__)CL2MD::>SS301OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := 0;
    OnFinalAction;
end;
procedure CEMS134Meter.OnEnterAction;
Begin
    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>EMS134 OnEnterAction');
    //FinalAction;
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
End;
procedure CEMS134Meter.OnFinalAction;
Begin
    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>EMS134 OnFinalAction');
    FinalAction;
End;
procedure CEMS134Meter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EMS134 OnFinalAction');
    m_nModemState := 1;
    FinalAction;
End;
procedure CEMS134Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EMS134 OnFinalAction');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;


{
procedure CSS301F3Meter.OnEnterAction;
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SS301 OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
    //FinalAction;
End;
procedure CSS301F3Meter.OnFinalAction;
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SS301 OnFinalAction');
    //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
    //if m_nP.m_sbyModem=0 then FinalAction;
    //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
    FinalAction;
End;
procedure CSS301F3Meter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SS301 OnConnectComplette');
    m_nModemState := 1;
    FinalAction;
End;
procedure CSS301F3Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SS301 OnDisconnectComplette');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;
}
procedure CEMS134Meter.TestMSG(var pMsg:CMessage);
var tempStr     : string;
    cnt, strNum : integer;
begin
   case nReq.m_swParamID+nReq.m_swSpecc1 of
     QRY_ENERGY_SUM_EP     : strNum := 1;
     QRY_ENERGY_SUM_EM     : strNum := 3;
     QRY_ENERGY_SUM_RP     : strNum := 5;
     QRY_ENERGY_SUM_RM     : strNum := 7;
     //QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
     //QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM     : strNum := 5;
     //QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
     //QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM : strNum := 7;
     else strNum := 1;
   end;
   tempStr := GetStringFromFile('d:\Kon2\TraceForDebug\TestEMS.txt', strNum);
   EncodeStrToBufArr(tempStr, pMsg.m_sbyInfo[0], cnt);
   pMsg.m_swLen := cnt + 11;
end;
function CEMS134Meter.GetStringFromFile(FileName : string; nStr : integer) : string;
var f :TStringList;
begin
   f := TStringList.Create();
   f.LoadFromFile(FileName);
   Result := f.Strings[nStr];
   f.Free;
end;
procedure CEMS134Meter.EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
var i       : integer;
    ts      : string;
begin
   ts      := '';
   nCount  := 0;
   for i := 1 to Length(str) do
     if str[i] <> ' ' then
     begin
       if ts = '' then ts := '$';
       ts := ts + str[i];
     end
     else
     begin
       if ts <> '' then
       begin
         buf[nCount] := StrToInt(ts);
         Inc(nCount);
         ts := '';
       end;
       continue;
     end;
   if str <> '' then
   begin
     buf[nCount] := StrToInt(ts);
     Inc(nCount);
   end;
end;
function CEMS134Meter.GetCommand(byCommand:Byte):Integer;
Var
    res : Integer;
Begin
    case byCommand of
     QRY_NULL_COMM      :  res:=0;// = 0
     QRY_ENERGY_SUM_EP  :  res:=8;//= 1;//1
     QRY_ENERGY_SUM_EM  :  res:=8;//= 2;
     QRY_ENERGY_SUM_RP  :  res:=8;//= 3;
     QRY_ENERGY_SUM_RM  :  res:=8;//= 4;
     //QRY_ENERGY_DAY_EP  :  res:=2;//= 5;//2
     //QRY_ENERGY_DAY_EM  :  res:=2;//= 6;
     //QRY_ENERGY_DAY_RP  :  res:=2;//= 7;
     //QRY_ENERGY_DAY_RM  :  res:=2;//= 8;
     QRY_ENERGY_MON_EP  :  res:=7;//= 9;//3
     QRY_ENERGY_MON_EM  :  res:=7;//= 10;
     QRY_ENERGY_MON_RP  :  res:=7;//= 11;
     QRY_ENERGY_MON_RM  :  res:=7;//= 12;
     //QRY_SRES_ENR_EP    :  res:=36;//= 13;//36
     //QRY_SRES_ENR_EM    :  res:=36;//= 14;
     //QRY_SRES_ENR_RP    :  res:=36;//= 15;
     //QRY_SRES_ENR_RM    :  res:=36;//= 16;
     //QRY_NAK_EN_DAY_EP  :  res:=42;//= 17;//42
     //QRY_NAK_EN_DAY_EM  :  res:=42;//= 18;
     //QRY_NAK_EN_DAY_RP  :  res:=42;//= 19;
     //QRY_NAK_EN_DAY_RM  :  res:=42;//= 20;
     //QRY_NAK_EN_MONTH_EP:   res:=7;//= 21;//43
     //QRY_NAK_EN_MONTH_EM : res:=43;//= 22;
     //QRY_NAK_EN_MONTH_RP : res:=43;//= 23;
     //QRY_NAK_EN_MONTH_RM : res:=43;//= 24;

     //QRY_NAK_EN_YEAR_EP  : res:=0;//= 25;
     //QRY_NAK_EN_YEAR_EM  : res:=0;//= 26;
     //QRY_NAK_EN_YEAR_RP  : res:=0;//= 27;
     //QRY_NAK_EN_YEAR_RM  : res:=0;//= 28;
     //QRY_E3MIN_POW_EP    : res:=5;//= 29;//5
     //QRY_E3MIN_POW_EM    : res:=5;//= 30;
     //QRY_E3MIN_POW_RP    : res:=5;//= 31;
     //QRY_E3MIN_POW_RM    : res:=5;//= 32;
     //QRY_E30MIN_POW_EP   : res:=6;//= 33;//6
     //QRY_E30MIN_POW_EM   : res:=6;//= 34;
     //QRY_E30MIN_POW_RP   : res:=6;//= 35;
     //QRY_E30MIN_POW_RM   : res:=6;//= 36;
     //QRY_MGAKT_POW_S     : res:=8;//= 37;//8
     //QRY_MGAKT_POW_A     : res:=8;//= 38;
     //QRY_MGAKT_POW_B     : res:=8;//= 39;
     //QRY_MGAKT_POW_C     : res:=8;//= 40;
     //QRY_MGREA_POW_S     : res:=9;//= 41;//9
     //QRY_MGREA_POW_A     : res:=9;//= 42;
     //QRY_MGREA_POW_B     : res:=9;//= 43;
     //QRY_MGREA_POW_C     : res:=9;//= 44;
     //QRY_U_PARAM_A       : res:=10;//= 45;//10
     //QRY_U_PARAM_B       : res:=10;//= 46;
     //QRY_U_PARAM_C       : res:=10;//= 47;
     //QRY_I_PARAM_A       : res:=11;//= 48;//11
     //QRY_I_PARAM_B       : res:=11;//= 49;
     //QRY_I_PARAM_C       : res:=11;//= 50;
     //QRY_KOEF_POW_A      : res:=12;//= 51;//12
     //QRY_KOEF_POW_B      : res:=12;//= 52;
     //QRY_KOEF_POW_C      : res:=12;//= 53;
     //QRY_FREQ_NET        : res:=13;//= 54;//13
     //QRY_KPRTEL_A        : res:=0;//= 55;//24
     //QRY_KPRTEL_R        : res:=0;//= 56;
     //QRY_DATA_TIME       : res:=32;//= 57;//32
     else
     res:=0;
    End;
    Result := res;
End;
procedure CEMS134Meter.RunMeter;
Begin
    //m_nRepTimer.RunTimer;
    //m_nObserver.Run;
End;

function CEMS134Meter.CalculateCRC(Buffer : Array of Byte; Count : Integer) : word;
var crc,lcb:word;
    i,j:Integer;
begin
    crc:=$0000;
    for i:=0 to count-1 do
    begin
      crc:=(crc and $ff00) or (buffer[i] xor Lo(crc));
      for j:=0 to 7 do
      begin
        lcb:=crc and 1;
        crc:= crc shr 1;
        if lcb=1 then
          crc:=crc xor $a001;
      end;
    end;
    Result:=crc;
end;
function CEMS134Meter.CRC16(Buffer : Array of Byte; Count : Integer;var nCrc:word) : word;
var crc,lcb:word;
    i,j:Integer;
begin
    crc:=$0000;
    for i:=0 to count-1 do
    begin
      crc:=(crc and $ff00) or (buffer[i] xor Lo(crc));
      for j:=0 to 7 do
      begin
        lcb:=crc and 1;
        crc:= crc shr 1;
        if lcb=1 then
          crc:=crc xor $a001;
      end;
    end;
    nCrc := crc;
    Result:=crc;
end;


function CEMS134Meter.BcdToInt(buf:array of byte;count:integer):int64;
var i,b    :byte;
    d0,res :int64;
begin
   res:=0;
   d0:=1;
   if count>6 then count:=6;
   for i:=0 to count-1 do begin
     b:=buf[i];
     if ((b shr 4)>9) or ((b and $0f)>9) then begin
       result:=0;
       exit
     end;
     res:=res+(b shr 4)*d0*10+(b and $0f)*d0;
     d0:=d0*100;
   end;
   Result:=res;
end;

function CEMS134Meter.BcDToData(mas:array of byte):TDateTime;
var Day, Month, Year : word;
begin
   Day   := (mas[2] and $0F);
   Month := (mas[2] shr 5) + (mas[3] and $01)*8;
   Year  := (mas[3] shr 1);
   result:=EncodeDate(Year,Month,Day);
end;

function CEMS134Meter.BcDToTime(mas:array of byte):TDateTime;
var Sec, Min, Hour : word;
begin
   Sec   := (mas[0] and $1F)*2;
   Min   := (mas[0] shr 5) + (mas[1] and $07)*8;
   Hour  := (mas[1] shr 3);
   result:=EncodeTime(Hour,Min,Sec,0);
    {Sec   := (mas[0] and $1F)*2;
    Min   := (mas[0] shr 5) + (mas[1] and $07)*8;
    Hour  := (mas[1] shr 3);
    Day   := (mas[2] and $0F);
    Month := (mas[2] shr 5) + (mas[3] and $01)*8;
    Year  := (mas[3] shr 1);}
end;

procedure CEMS134Meter.CorrTime(c : shortint);
var i    :byte;
    crc  :word;
begin
   TraceL(2,m_nRxMsg.m_swObjID,'(__)CL2MD::>   Korrection Time');
   m_nTxMsg.m_sbyInfo[0] :=  $1D;
   MovePA64(@m_nTxMsg.m_sbyInfo,@m_nP.m_sddPHAddres);
   m_nTxMsg.m_sbyInfo[7]  := $01;
   m_nTxMsg.m_sbyInfo[8]  := $03;
   for i:=9 to 24 do
     m_nTxMsg.m_sbyInfo[i]:= $FF;
   m_nTxMsg.m_sbyInfo[25] := $06;
   {if c<0 then
     c:=$FF-abs(c)+1;}
   if (c >5) then c := 5;
   if (c < -5) then c:= -5;
   c := c or $40;
   m_nTxMsg.m_sbyInfo[26] := c;
   crc  := CalculateCRC(m_nTxMsg.m_sbyInfo, 27);
   m_nTxMsg.m_sbyInfo[27] := (crc and $ff);
   m_nTxMsg.m_sbyInfo[28] := (crc and $ff00) shr 8;
   MSGHead(m_nTxMsg, 11 + 29);
   SendToL1(BOX_L1, @m_nTxMsg);
   Sleep(300);
end;

end.



