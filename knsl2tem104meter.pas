unit knsl2tem104Meter;
//{$DEFINE TEM_DEBUG}
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule
,knsl5tracer, utlTimeDate;
type
    //Идентификация устройства (команда 0000)
    SIDREQ = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     CS    : Byte;
    End;
    SIDRES = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     DATA  : array[0..31] of Byte;
    End;
    //Чтение памяти таймера 128 байт (команды 0F02 и 8F02#)
    S128REQ = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     TADDR : Byte;
     TLEN  : Byte;
     CS    : Byte;
    End;
    S128RES = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     DATA  : array[0..70] of Byte;
    End;
    //Чтение памяти таймера 2К байт (команды 0F01 и 8F01#)
    S2KREQ = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     TADRH : Byte;
     TADRL : Byte;
     TLEN  : Byte;
     CS    : Byte;
    End;
    S2KRES = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     DATA  : array[0..300] of Byte;
    End;
    //Чтение памяти Flash 512К байт (команды 0F03 и 8F03#)
    SF512REQ = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     TLEN  : Byte;
     FADR3 : Byte;
     FADR2 : Byte;
     FADR1 : Byte;
     FADR0 : Byte;
     CS    : Byte;
    End;
    SF512RES = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     DATA  : array[0..300] of Byte;
    End;
    //Чтение оперативной памяти (команды 0C01h и 8C01h)
    SRAMREQ = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     TADRH : Byte;
     TADRL : Byte;
     TLEN  : Byte;
     CS    : Byte;
    End;
    SRAMRES = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     DATA  : array[0..70] of Byte;
    End;
 //Поиск записи по дате (команды 0D11# и 8D11#)
    SFINDREQ = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     STAT_TYPE : Byte;
     HOUR  : Byte;
     DAY   : Byte;
     MONTH : Byte;
     YEAR  : Byte;
     CS    : Byte;
    End;
    SFINDRES = packed record
     SIG   : Byte;
     ADDR  : Byte;
     NADDR : Byte;
     CGRP  : Byte;
     CMD   : Byte;
     LEN   : Byte;
     NUMH  : Byte;
     NUML  : Byte;
     CS    : Byte;
    End;
{
Примечания: а) Все числа, занимающие более 1 байта, хранятся в памяти
теплосчетчика в формате Motorola (MSB->LSB), то есть для преобразования
этих чисел в формат Intel, применя-емый в PC-совместимых компьютерах,
необходимо поменять порядок байт на обрат-ный;
б) Типы данных: F – float (4 байта); L – long (4 байта);
I – Int (2 байта); C – Char (1 байт);
BCD – число в двоично-десятичном коде.в) Для получения адреса записи
(часовой, суточной или на отчетную дату) в памяти Flash, которая будет
записана следующей, необходимо вычесть из соответствующего значения
адреса (next_hour, next_day или next_month) 200000h(шестнадцатиричное!!!)
}
    SSysCon = packed record
     SysType : Byte;
     Gprog : array[0..3] of Byte;
     Gchan : array[0..3] of Byte;
     Tprog : array[0..3] of Byte;
     Tchan : array[0..3] of Byte;
     Pprog : array[0..3] of Byte;
     Pchan : array[0..3] of Byte;
    End;
    SSysInt = packed record
     tek_dat  : array[0..3] of Byte;//BCD
     prev_dat : array[0..3] of Byte;//BCD
     l_IntV   : array[0..3] of Single;
     l_IntM   : array[0..3] of Single;
     l_IntQ   : array[0..3] of Single;
     h_IntV   : array[0..3] of DWord;
     h_IntM   : array[0..3] of DWord;
     h_IntQ   : array[0..3] of DWord;
     TRab     : DWord;
     TNar     : array[0..3] of DWord;
     Tmin     : array[0..3] of DWord;
     Tmax     : array[0..3] of DWord;
     Tdt      : array[0..3] of DWord;
     Ttn      : array[0..3] of DWord;
     tekerr   : array[0..3] of Byte;
     teherr   : array[0..3] of Word;
     t        : array[0..3,0..2] of Word;
     p        : array[0..3,0..2] of Byte;
     fT       : array[0..3,0..2] of Single;
     fP       : array[0..3,0..2] of Single;
     rshv     : array[0..3] of Single;
     check    : Byte;
    End;

    S2KDATA = packed record
     systems      : Byte;
     type_g       : Byte;
     type_t       : Byte;
     net_num      : Dword;
     number       : Dword;
     diam         : array[0..3] of Word;
     g_max        : array[0..3] of Single;
     g_pcnt_max   : array[0..3] of Byte;
     g_pcnt_min   : array[0..3] of Byte;
     f_max        : array[0..1] of Single;
     weight       : array[0..1] of Single;
     next_hour    : Dword;
     next_day     : Dword;
     next_month   : Dword;
     SysInt_copy1 : SSysInt;
     SysInt_copy2 : SSysInt;
     SysCon       : array[0..3] of SSysCon;
    End;
    STIMERDATA = packed record
     t_ss : Byte;
     t_mm : Byte;
     t_hh : Byte;
     t_dm : Byte;
     t_my : Byte;
     t_yy : Byte;
    End;
    SRAMDATA = packed record
     tmp    : array[0..3] of Single;
     prs    : array[0..3] of Single;
     ro     : array[0..3] of Single;
     hent   : array[0..3] of Single;
     rshv   : array[0..3] of Single;
     rshm   : array[0..3] of Single;
     pwr    : array[0..3] of Single;
     tekerr : Byte;
     teherr : Word;
     res    : array[0..3] of Byte;
    End;
{
0-1535 00000000 – 0005FFFF Часовые записи
(1536) 1536-1919 00060000 – 00076FFF Суточные записи
(368) 1920-2047 00078000 – 0007FFFF Записи на отчетную дату (144)
}
    CTem104Meter = class(CMeter)
    Private
     m_nCounter     : Integer;
     m_nCounter1    : Integer;
     //IsUpdate       : boolean;
     TempNReq       : CQueryPrimitive;
     nReq           : CQueryPrimitive;
     DataBuf        : array [0..300] of byte;
     n2KData        : S2KRES;
     //m_n2KData      : S2KDATA;
     IsPackRecieved : boolean;
     m_nNextHour    : DWord;
     m_nNextDay     : DWord;
     m_nNextMon     : DWord;
     m_nID          : Integer;
     sDY,sDM         : SF512RES;
     procedure   Extract2KData(var sD:SF512RES;nType:Integer);
     procedure   CreateMsg(pP:Pointer;nLen:Integer);
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     procedure   AddGraphParams(DateBeg, DateEnd : TDateTime; parType : integer);
     procedure   SwapDW(pP:Pointer);
     function    BCDToByte(hexNumb:byte):byte;
     procedure   SwapW(pP:Pointer);
     procedure   SetPointer(var pMsg:CMessage);
     procedure   SetConfig(var pMsg:CMessage);
     procedure   ReadAutorAns(var pMsg:CMessage);
     procedure   Read2KRES(var pMsg:CMessage);
     procedure   ReadDataRes(var pMsg:CMessage);
     procedure   ReadDataMonRes(var pMsg:CMessage);
     procedure   CreateAutoReq(var nReq : CQueryPrimitive);
     procedure   CreateDataReq(dwBase:Dword;var nReq : CQueryPrimitive);
     procedure   Create2KREQ(var nReq : CQueryPrimitive);
     procedure   TestMSG(var pMsg:CMessage);
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     function    LoHandler(var pMsg:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     constructor Create;
     procedure   HandQryRoutine(var pMsg:CMessage);
     procedure   MsgHead(var pMsg:CHMessage; Size:byte);
     procedure   CreateOutMsgHead(parType:integer;dbParam:Double;dt_Date:TDateTime);
     function    CRC(var buf : array of byte; cnt : byte):boolean;
     procedure   KorrTime();
     procedure   SetTime();
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     function    GetStringFromFile(FileName : string; nStr : integer) : string;
     procedure   EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
     //procedure   SetGraphParam(dt_Date1, dt_Date2:TDateTime; param : word);override;
    End;
implementation

constructor CTem104Meter.Create;
Begin
End;

procedure CTem104Meter.InitMeter(var pL2:SL2TAG);
Begin
    m_nCounter := 0;
    m_nCounter1:= 0;
    IsUpdate   := 0;
    SetHandScenario;
    SetHandScenarioGraph;
    TraceL(2,m_nP.m_swMID,'(__)CTM104::>CTM104  Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;
procedure CTem104Meter.MsgHead(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := Size;                 //pMsg.m_sbyInfo
    pMsg.m_swObjID     := m_nP.m_swMID;         //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;           //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ;        //PH_DATARD_REC
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_TEM104;           //Указать тип счетчика
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

procedure CTem104Meter.CreateOutMsgHead(parType:integer;dbParam:Double;dt_Date:TDateTime);
var year, month, day,
    hour, min, sec, ms : word;
begin
   DecodeDate(dt_Date, Year, Month, Day);
   DecodeTime(dt_Date, Hour, Min, Sec, ms);
   m_nRxMsg.m_swLen      := 13+4+11;
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_sbyIntID   := 0;
   m_nRxMsg.m_sbyDirID   := Byte(IsUpdate);
   m_nRxMsg.m_sbyInfo[0] := m_nRxMsg.m_swLen - 11;
   m_nRxMsg.m_sbyInfo[1] := parType;
   m_nRxMsg.m_sbyInfo[2] := Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := Month;
   m_nRxMsg.m_sbyInfo[4] := Day;
   m_nRxMsg.m_sbyInfo[5] := Hour;
   m_nRxMsg.m_sbyInfo[6] := Min;
   m_nRxMsg.m_sbyInfo[7] := Sec;
   m_nRxMsg.m_sbyInfo[8] := 1;
   move(dbParam, m_nRxMsg.m_sbyInfo[9], sizeof(dbParam));
   FPUT(BOX_L3_BY, @m_nRxMsg);
end;

procedure CTem104Meter.SetCurrQry;
Begin
    with m_nObserver do
    Begin
     ClearCurrQry;
     AddCurrParam(QRY_ENERGY_SUM_EP,0,1,0,1);
     AddCurrParam(QRY_ENERGY_SUM_EP,0,2,0,1);
     AddCurrParam(QRY_ENERGY_SUM_EP,0,3,0,1);
     AddCurrParam(QRY_ENERGY_SUM_EP,0,4,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,1,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,2,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,3,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,4,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,1,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,2,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,3,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,4,0,1);
     AddCurrParam(QRY_E3MIN_POW_EP,0,0,0,1);
     AddCurrParam(QRY_E30MIN_POW_EP,0,0,0,1);
     AddCurrParam(QRY_MGAKT_POW_S,0,0,0,1);
     AddCurrParam(QRY_MGREA_POW_S,0,0,0,1);
     AddCurrParam(QRY_U_PARAM_A,0,0,0,1);
     AddCurrParam(QRY_I_PARAM_A,0,0,0,1);
     AddCurrParam(QRY_KOEF_POW_A,0,0,0,1);
     AddCurrParam(QRY_FREQ_NET,0,0,0,1);
     AddCurrParam(QRY_KPRTEL_KPR,0,0,0,1);
     AddCurrParam(QRY_DATA_TIME,0,0,0,1);
     AddCurrParam(QRY_SRES_ENR_EP,0,0,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,1,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,2,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,3,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,4,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,1,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,2,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,3,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,4,0,1);
    End;
End;

procedure CTem104Meter.SetGraphQry;
begin
end;

procedure CTem104Meter.AddGraphParams(DateBeg, DateEnd : TDateTime; parType : integer);
var
    sm : integer;
    spec1, spec2 : integer;
    TempDate     : TDateTime;
begin
   if (parType=QRY_POD_TRYB_HEAT) then sm := trunc(Now-DateEnd) else
   if (parType=QRY_NACKM_POD_TRYB_HEAT) then
   Begin
    sm := 0;
    TempDate := trunc(Now);
    if (DateBeg>trunc(Now)) then DateBeg := trunc(Now);
    while (cDateTimeR.CompareMonth(DateBeg, TempDate) <> 0) do
    begin
      cDateTimeR.DecMonth(TempDate);
      Inc(sm);
      if sm>12 then break;
    end;
   End;
   m_nObserver.AddGraphParam(QRY_NULL_COMM, 0, 0, 0, 1);
   m_nObserver.AddGraphParam(parType, 0, sm, 0, 1);
end;
procedure CTem104Meter.ReadAutorAns(var pMsg:CMessage);
Var
   sDD : SIDRES;
   str : string;
   i : Integer;
begin
   str := '';
   move(pMsg.m_sbyInfo,sDD,pMsg.m_swLen-11);
   for i:=0 to sDD.LEN-1 do
   str := str + Char(sDD.DATA[i]);
   TraceL(2, m_nP.m_swMID, '(__)CTM104::>Autorization Complite! Meter:'+str);
   FinalAction;
end;
procedure CTem104Meter.Read2KRES(var pMsg:CMessage);
begin

   if (nReq.m_swSpecc1<$600) then move(pMsg.m_sbyInfo[6],n2KData.DATA[$40*m_nID],$40);
   if (nReq.m_swSpecc1>=$600)then move(pMsg.m_sbyInfo[6],n2KData.DATA[$40*(m_nID-1)],$40);


   if (m_nID=2)and(nReq.m_swSpecc1<$600) then
   Begin
    m_nID := 0;
    SetPointer(pMsg);
    nReq.m_swSpecc1 := $600;
   End;

   if (m_nID=4)and(nReq.m_swSpecc1>=$600) then
   Begin
    m_nID := 0;
    SetConfig(pMsg);
    FinalAction;
    exit;
   End;
   m_nID := m_nID + 1;
   
   if (nReq.m_swSpecc1<$600)  then nReq.m_swSpecc1 := nReq.m_swSpecc1 + $40 ;
   Create2KREQ(nReq);
   if (nReq.m_swSpecc1>=$600) then nReq.m_swSpecc1 := nReq.m_swSpecc1 + $40 ;

   m_byRep := m_nP.m_sbyRepMsg;

end;
procedure CTem104Meter.SetPointer(var pMsg:CMessage);
Var
   sD : S2KRES;
   nNumber : Dword;
Begin
   //move(pMsg.m_sbyInfo,sD,pMsg.m_swLen-11);
   move(n2KData,sD,sizeof(S2KRES));
   move(sD.DATA[0],nNumber,4);
   move(sD.DATA[$78+0],m_nNextHour,4);
   move(sD.DATA[$78+4],m_nNextDay,4);
   move(sD.DATA[$78+8],m_nNextMon,4);
   SwapDW(@nNumber);
   SwapDW(@m_nNextHour);
   SwapDW(@m_nNextDay);
   SwapDW(@m_nNextMon);
   m_nNextHour := m_nNextHour-$200000;
   m_nNextDay  := m_nNextDay-$200000;
   m_nNextMon  := m_nNextMon-$200000;
   TraceL(2, m_nP.m_swMID, '(__)CTM104::>Заводской номер: '+IntToStr(nNumber));
   TraceL(2, m_nP.m_swMID, '(__)CTM104::>Next_hour:'+IntToHex(m_nNextHour,5));
   TraceL(2, m_nP.m_swMID, '(__)CTM104::>Next_day:'+IntToHex(m_nNextDay,5));
   TraceL(2, m_nP.m_swMID, '(__)CTM104::>Next_month:'+IntToHex(m_nNextMon,5));
end;
{
SSysCon = packed record
     SysType : Byte;
     Gprog : array[0..3] of Byte;
     Gchan : array[0..3] of Byte;
     Tprog : array[0..3] of Byte;
     Tchan : array[0..3] of Byte;
     Pprog : array[0..3] of Byte;
     Pchan : array[0..3] of Byte;
    End;
}
procedure CTem104Meter.SetConfig(var pMsg:CMessage);
Var
   sDD : S2KRES;
   nD : S2KDATA;
   sGprog,sGchan,sTprog,sTchan,sPprog,sPchan:String;
   i,k: Integer;
Begin
   //move(pMsg.m_sbyInfo,sDD,pMsg.m_swLen-11);
   move(n2KData,sDD,sizeof(S2KRES));

   move(sDD.DATA,nD.SysCon,sizeof(nD.SysCon));

    for k:=0 to 3 do
    Begin
     sGprog := '';
     sGchan := '';
     sTprog := '';
     sTchan := '';
     sPprog := '';
     sPchan := '';
     TraceL(2, m_nP.m_swMID,'('+IntTostr(k)+')CTM104::>тип системы SysType:'+IntToStr(nD.SysCon[k].SysType));

     for i:=0 to 3 do sGprog:=sGprog+IntToStr(nD.SysCon[k].Gprog[i])+' ';
     TraceL(2, m_nP.m_swMID,'('+IntTostr(k)+')CTM104::>Расход по каналам: Gprog:'+sGprog);

     for i:=0 to 3 do sGchan:=sGchan+IntToStr(nD.SysCon[k].Gchan[i])+' ';
     TraceL(2, m_nP.m_swMID,'('+IntTostr(k)+')CTM104::>Расход по каналам: Gchan:'+sGchan);

     for i:=0 to 3 do sTprog:=sTprog+IntToStr(nD.SysCon[k].Tprog[i])+' ';
     TraceL(2, m_nP.m_swMID,'('+IntTostr(k)+')CTM104::>Расход по каналам: Tprog:'+sTprog);

     for i:=0 to 3 do sTchan:=sTchan+IntToStr(nD.SysCon[k].Tchan[i])+' ';
     TraceL(2, m_nP.m_swMID,'('+IntTostr(k)+')CTM104::>Расход по каналам: Tchan:'+sTchan);

     for i:=0 to 3 do sPprog:=sPprog+IntToStr(nD.SysCon[k].Pprog[i])+' ';
     TraceL(2, m_nP.m_swMID,'('+IntTostr(k)+')CTM104::>Расход по каналам: Pprog:'+sPprog);

     for i:=0 to 3 do sPchan:=sPchan+IntToStr(nD.SysCon[k].Pchan[i])+' ';
     TraceL(2, m_nP.m_swMID,'('+IntTostr(k)+')CTM104::>Расход по каналам: Pchan:'+sPchan);
    End;

End;
procedure  CTem104Meter.ReadDataRes(var pMsg:CMessage);
Var
    snD : SF512RES;
    i,j  : Integer;
begin
    move(pMsg.m_sbyInfo,snD,pMsg.m_swLen-11);
    m_nID := m_nID + 1;
    move(snD.DATA,sDY.DATA[snD.LEN*(m_nID-1)],snD.LEN);
    sDY.LEN := sDY.LEN + snD.LEN;
    if m_nID>3 then
    Begin
     Extract2KData(sDY,nReq.m_swParamID);
     FinalAction;
    End else
    Begin
     //nReq.m_swSpecc1 := m_nID;
     CreateDataREQ(m_nNextDay,nReq);
     m_byRep := m_nP.m_sbyRepMsg;
    End;
End;
procedure  CTem104Meter.ReadDataMonRes(var pMsg:CMessage);
Var
    snD : SF512RES;
    i,j  : Integer;
begin
    move(pMsg.m_sbyInfo[6],snD.DATA,pMsg.m_swLen-11);
    m_nID := m_nID + 1;
    snD.LEN := $40;
    move(snD.DATA,sDM.DATA[snD.LEN*(m_nID-1)],snD.LEN);
    sDM.LEN := sDM.LEN + snD.LEN;
    if m_nID>3 then
    Begin
     Extract2KData(sDM,nReq.m_swParamID);
     FinalAction;
    End else
    Begin
     //nReq.m_swSpecc1 := m_nID;
     CreateDataREQ(m_nNextMon,nReq);
     m_byRep := m_nP.m_sbyRepMsg;
    End;
End;
procedure CTem104Meter.Extract2KData(var sD:SF512RES;nType:Integer);
Var
    i,j,k : Integer;
    sP : SSysInt;
    dt_Date:TDateTime;
    Year,Month,Day:Word;
Begin
    move(sD.DATA[$0],sP.tek_dat,sizeof(sP.tek_dat));
    move(sD.DATA[$4],sP.prev_dat,sizeof(sP.prev_dat));
    move(sD.DATA[$8],sP.l_IntV,sizeof(sP.l_IntV));
    move(sD.DATA[$18],sP.l_IntM,sizeof(sP.l_IntM));
    move(sD.DATA[$28],sP.l_IntQ,sizeof(sP.l_IntQ));
    move(sD.DATA[$38],sP.h_IntV,sizeof(sP.h_IntV));
    move(sD.DATA[$48],sP.h_IntM,sizeof(sP.h_IntM));
    move(sD.DATA[$58],sP.h_IntQ,sizeof(sP.h_IntQ));
    move(sD.DATA[$68],sP.TRab,sizeof(sP.TRab));
    move(sD.DATA[$6c],sP.TNar,sizeof(sP.TNar));
    move(sD.DATA[$7c],sP.Tmin,sizeof(sP.Tmin));
    move(sD.DATA[$8c],sP.Tmax,sizeof(sP.Tmax));
    move(sD.DATA[$9c],sP.Tdt,sizeof(sP.Tdt));
    move(sD.DATA[$ac],sP.Ttn,sizeof(sP.Ttn));
    move(sD.DATA[$bc],sP.tekerr,sizeof(sP.tekerr));
    move(sD.DATA[$c0],sP.teherr,sizeof(sP.teherr));
    move(sD.DATA[$c8],sP.t,sizeof(sP.t));
    move(sD.DATA[$e0],sP.p,sizeof(sP.p));
    move(sD.DATA[$ec],sP.rshv,sizeof(sP.rshv));
    for i:=0 to 3 do
    Begin
     SwapDW(@sP.l_IntV[i]);
     SwapDW(@sP.l_IntM[i]);
     SwapDW(@sP.l_IntQ[i]);
     SwapDW(@sP.h_IntV[i]);
     SwapDW(@sP.h_IntM[i]);
     SwapDW(@sP.h_IntQ[i]);
     SwapDW(@sP.TNar[i]);
     //sP.TNar[i] := sP.TNar[i];

     SwapDW(@sP.Tmin[i]);
     SwapDW(@sP.Tmax[i]);
     SwapDW(@sP.Tdt[i]);
     SwapDW(@sP.Ttn[i]);
     SwapW(@sP.teherr[i]);
     SwapDW(@sP.rshv[i]);
     sP.l_IntV[i] := sP.l_IntV[i] + sP.h_IntV[i];
     sP.l_IntM[i] := sP.l_IntM[i] + sP.h_IntM[i];
     sP.l_IntQ[i] := sP.l_IntQ[i] + sP.h_IntQ[i];
    End;

    SwapDW(@sP.TRab);
    for i:=0 to 3 do
    for j:=0 to 2 do
    Begin
     SwapW(@sP.t[i,j]);
     sP.fT[i,j] := (sP.t[i,j]/100);
    End;
    for i:=0 to 3 do
    for j:=0 to 2 do
    sP.fP[i,j] := (sP.p[i,j]/100);

    for i:=0 to 4 do
    Begin
     sP.tek_dat[i]  := BCDToByte(sP.tek_dat[i]);
     sP.prev_dat[i] := BCDToByte(sP.prev_dat[i]);
    End;
    TraceL(2, m_nP.m_swMID, '(__)CTM104::>YY:MM:DD:HH(n  ):'+IntToStr(2000+sP.tek_dat[3])+':'+IntToStr(sP.tek_dat[2])+' '+IntToStr(sP.tek_dat[1])+':'+IntToStr(sP.tek_dat[0]));
    TraceL(2, m_nP.m_swMID, '(__)CTM104::>YY:MM:DD:HH(n-1):'+IntToStr(2000+sP.prev_dat[3])+':'+IntToStr(sP.prev_dat[2])+' '+IntToStr(sP.prev_dat[1])+':'+IntToStr(sP.prev_dat[0]));

    for i:=0 to 1 do
    Begin
     TraceL(2, m_nP.m_swMID,'('+IntTostr(i)+')CTM104::>Интегратор объема l_IntV          :'+FloatToStr(sP.l_IntV[i]));
     TraceL(2, m_nP.m_swMID,'('+IntTostr(i)+')CTM104::>Интегратор массы l_IntM           :'+FloatToStr(sP.l_IntM[i]));
     TraceL(2, m_nP.m_swMID,'('+IntTostr(i)+')CTM104::>Интегратор энергии  l_IntQ        :'+FloatToStr(sP.l_IntQ[i]));
     TraceL(2, m_nP.m_swMID,'('+IntTostr(i)+')CTM104::>время работы систем без  TNar     :'+FloatToStr(sP.TNar[i]/3600));
     TraceL(2, m_nP.m_swMID,'('+IntTostr(i)+')CTM104::>расход меньше минималь-ного  Tmin :'+IntToStr(sP.Tmin[i]));
     TraceL(2, m_nP.m_swMID,'('+IntTostr(i)+')CTM104::>расход больше макси-мального  Tmax:'+IntToStr(sP.Tmax[i]));
     TraceL(2, m_nP.m_swMID,'('+IntTostr(i)+')CTM104::>разность температур  Tdt          :'+IntToStr(sP.Tdt[i]));
     TraceL(2, m_nP.m_swMID,'('+IntTostr(i)+')CTM104::>Интеграторы объемного  rshv       :'+FloatToStr(sP.rshv[i]));
    End;
    TraceL(2, m_nP.m_swMID, '(__)CTM104::>время работы прибора TRab:'+IntToStr(sP.TRab));
    for i:=0 to 3 do
    for j:=0 to 2 do
     TraceL(2, m_nP.m_swMID,'('+IntTostr(i)+')CTM104::>Температура по системам  T        :'+FloatToStr(sP.fT[i,j]));
    for i:=0 to 3 do
    for j:=0 to 2 do
     TraceL(2, m_nP.m_swMID,'('+IntTostr(i)+')CTM104::>Давление по системам  T           :'+FloatToStr(sP.fP[i,j]));
{
  QRY_POD_TRYB_HEAT     = 75;   //Расход тепла в подающем трубопроводе (Гкал)
  QRY_POD_TRYB_RASX     = 76;   //Расход воды в подающем трубопроводе  (т)
  QRY_POD_TRYB_TEMP     = 77;   //Температура воды в подающем трубопроводе  (°C)
  QRY_POD_TRYB_V        = 78;   //Расход воды (объем) в подающем водопроводе (м3)
  QRY_OBR_TRYB_HEAT     = 79;   //Расход тепла в обратном трубопроводе (Гкал)
  QRY_OBR_TRYB_RASX     = 80;   //Расход воды в обратном трубопроводе (т)
  QRY_OBR_TRYB_TEMP     = 81;   //Температура воды в обратном трубопроводе (°C)
  QRY_OBR_TRYB_V        = 82;   //Расход воды (объем) в обратном трубопроводе (м3)
  QRY_TEMP_COLD_WAT_DAY = 83;   //Температура холодной воды  (°C)
  QRY_POD_TRYB_RUN_TIME = 84;   //Время наработки в подающем трубопроводе (ч)
  QRY_WORK_TIME_ERR     = 85;   //Время работы c каждой ошибкой (ч)
}

   Year  := 2000+sP.tek_dat[3];
   Month := sP.tek_dat[2];
   Day   := sP.tek_dat[1];

   if (Month>12)or(Month=0)or(Day>31)or(Day=0) then
   Begin
    DecodeDate(Now-nReq.m_swSpecc1,Year,Month,Day);
    FillChar(sP,sizeof(sP),0);
   End;

   dt_Date := EncodeDate(Year,Month,Day)+EncodeTime(0,0,0,0);
   if(nType=QRY_POD_TRYB_HEAT) then
   Begin
    CreateOutMsgHead(QRY_POD_TRYB_HEAT,sP.l_IntQ[0],dt_Date);
    CreateOutMsgHead(QRY_OBR_TRYB_HEAT,sP.l_IntQ[1],dt_Date);
    CreateOutMsgHead(QRY_POD_TRYB_RASX,sP.l_IntM[0],dt_Date);
    CreateOutMsgHead(QRY_OBR_TRYB_RASX,sP.l_IntM[1],dt_Date);
    CreateOutMsgHead(QRY_POD_TRYB_TEMP,sP.fT[0,0],dt_Date);
    CreateOutMsgHead(QRY_OBR_TRYB_TEMP,sP.fT[0,1],dt_Date);
    CreateOutMsgHead(QRY_POD_TRYB_V,sP.l_IntV[0],dt_Date);
    CreateOutMsgHead(QRY_OBR_TRYB_V,sP.l_IntV[1],dt_Date);
    CreateOutMsgHead(QRY_POD_TRYB_RUN_TIME,sP.TNar[0]/3600,dt_Date);
    CreateOutMsgHead(QRY_WORK_TIME_ERR,sP.TNar[0]/3600,dt_Date);
    CreateOutMsgHead(QRY_TEMP_COLD_WAT_DAY,4,dt_Date);
    End else
   if(nType=QRY_NACKM_POD_TRYB_HEAT) then
   Begin
    CreateOutMsgHead(QRY_NACKM_POD_TRYB_HEAT,sP.l_IntQ[0],dt_Date);
    CreateOutMsgHead(QRY_NACKM_OBR_TRYB_HEAT,sP.l_IntQ[1],dt_Date);
    CreateOutMsgHead(QRY_NACKM_POD_TRYB_RASX,sP.l_IntM[0],dt_Date);
    CreateOutMsgHead(QRY_NACKM_OBR_TRYB_RASX,sP.l_IntM[1],dt_Date);
    CreateOutMsgHead(QRY_NACKM_POD_TRYB_TEMP,sP.fT[0,0],dt_Date);
    CreateOutMsgHead(QRY_NACKM_OBR_TRYB_TEMP,sP.fT[0,1],dt_Date);
    CreateOutMsgHead(QRY_NACKM_POD_TRYB_V,sP.l_IntV[0],dt_Date);
    CreateOutMsgHead(QRY_NACKM_OBR_TRYB_V,sP.l_IntV[1],dt_Date);
    CreateOutMsgHead(QRY_NACKM_POD_TRYB_RUN_TIME,sP.TNar[0]/3600,dt_Date);
    CreateOutMsgHead(QRY_NACKM_WORK_TIME_ERR,sP.TNar[0]/3600,dt_Date);
    CreateOutMsgHead(QRY_NACKM_TEMP_COLD_WAT_DAY,4,dt_Date);
    End;
End;
function  CTem104Meter.BCDToByte(hexNumb:byte):byte;
begin //Преобразование BCD в байт
    Result := (hexNumb shr 4)*10 + (hexNumb and $0F);
end;
procedure CTem104Meter.SwapDW(pP:Pointer);
Var
    nDW : Dword;
    pDW,pB : PByteArray;
Begin
    pB     := PByteArray(pP);
    pDW    := @nDW;
    pDW[0] := pB[3];
    pDW[1] := pB[2];
    pDW[2] := pB[1];
    pDW[3] := pB[0];
    move(pDW^,pB^,4);
End;
procedure CTem104Meter.SwapW(pP:Pointer);
Var
    nDW : word;
    pDW,pB : PByteArray;
Begin
    pB     := PByteArray(pP);
    pDW    := @nDW;
    pDW[0] := pB[1];
    pDW[1] := pB[0];
    move(pDW^,pB^,2);
End;
procedure CTem104Meter.CreateMsg(pP:Pointer;nLen:Integer);
Begin
   move(pP^,m_nTxMsg.m_sbyInfo[0],nLen-1);
   CRC(m_nTxMsg.m_sbyInfo[0],nLen-1);
   MsgHead(m_nTxMsg, 11+nLen);
    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
    SendOutStat(m_nTxMsg.m_swLen);
    FPUT(BOX_L1 ,@m_nTxMsg);
   TraceM(2, m_nP.m_swMID, '(__)CTM104::>Out:',@m_nTxMsg);
End;
procedure CTem104Meter.CreateAutoReq(var nReq : CQueryPrimitive);
Var
   sD : SIDREQ;
begin
   sD.SIG   := $55;
   sD.ADDR  := StrToInt(m_nP.m_sddPHAddres);
   sD.NADDR := not sD.ADDR;
   sD.CGRP  := 0;
   sD.CMD   := 0;
   sD.LEN   := 0;
   CreateMsg(@sD,sizeof(sD));
end;
procedure CTem104Meter.Create2KREQ(var nReq : CQueryPrimitive);
Var
   sD : S2KREQ;
   m_n2KAddr : Word;
begin
   m_n2KAddr := nReq.m_swSpecc1;
   //sD.TLEN   := $90;
   sD.TLEN   := $40;
   sD.SIG    := $55;
   sD.ADDR   := StrToInt(m_nP.m_sddPHAddres);
   sD.NADDR  := not sD.ADDR;
   //sD.CGRP   := $8f;
   sD.CGRP   := $0f;
   sD.CMD    := $01;
   sD.LEN    := 3;
   sD.TADRH  := Hi(m_n2KAddr);
   sD.TADRL  := Lo(m_n2KAddr);
   CreateMsg(@sD,sizeof(sD));
   TraceL(2, m_nP.m_swMID, '(__)CTM104::>Qwery 2K! ID:'+IntToStr(nReq.m_swSpecc1)+' MPTR:'+IntToStr(m_n2KAddr));
end;
procedure CTem104Meter.CreateDataReq(dwBase:Dword;var nReq : CQueryPrimitive);
Var
   sD : SF512REQ;
   m_n2KAddr : DWord;
   pA : PByteArray;
   nID : Integer;
begin
   sD.TLEN   := $40;
   pA        := @m_n2KAddr;
   if m_nID=0 then nID := 0 else
   if m_nID=1 then nID := 3 else
   if m_nID=2 then nID := 2 else
   if m_nID=3 then nID := 1;

   m_n2KAddr := dwBase-((256*(nReq.m_swSpecc1+1))+nID*sD.TLEN);
   sD.SIG    := $55;
   sD.ADDR   := StrToInt(m_nP.m_sddPHAddres);
   sD.NADDR  := not sD.ADDR;
   sD.CGRP   := $0f;
   sD.CMD    := $03;
   sD.LEN    := 5;
   sD.FADR3  := pA[3];
   sD.FADR2  := pA[2];
   sD.FADR1  := pA[1];
   sD.FADR0  := pA[0];
   CreateMsg(@sD,sizeof(sD));
   TraceL(2, m_nP.m_swMID, '(__)CTM104::>Qwery 2K! SP1:'+IntToStr(nReq.m_swSpecc1)+' ID:'+IntToStr(nID)+' BASE:'+IntToHex(dwBase,5)+' MPTR:'+IntToHex(m_n2KAddr,5));
end;

function CTem104Meter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;

procedure CTem104Meter.SetTime();
begin
end;
procedure CTem104Meter.KorrTime();
begin
end;
procedure CTem104Meter.TestMSG(var pMsg:CMessage);
var tempStr : string;
    cnt     : integer;
begin
   case nReq.m_swParamID of
     QRY_AUTORIZATION :
       begin
         tempStr := GetStringFromFile('d:\Kon2\TraceForDebug\ForTest.txt', 1);
         EncodeStrToBufArr(tempStr, pMsg.m_sbyInfo[0], cnt);
         pMsg.m_swLen := cnt + 11;
       end;
     else
       begin
         tempStr := GetStringFromFile('d:\Kon2\TraceForDebug\ForTest.txt', 3);
         EncodeStrToBufArr(tempStr, pMsg.m_sbyInfo[0], cnt);
         pMsg.m_swLen := cnt + 11;
       end;
   end;
end;

function CTem104Meter.LoHandler(var pMsg:CMessage):Boolean;
Var
    res    : Boolean;
    fValue : Single;
Begin
    res := False;
    //Обработчик для L1
    {$ifdef TEM_DEBUG}
       TestMSG(pMsg);
    {$endif}
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
        if not CRC(pMsg.m_sbyInfo[0], pMsg.m_swLen-11-1) then
        begin
         TraceL(2,pMsg.m_swObjID,'(__)CTM104::>TEM CRC ERROR:');
         exit;
        end;
        IsPackRecieved := true;
        //move(pMsg.m_sbyInfo[0], DataBuf[0], pMsg.m_swLen - 11);
        TraceM(2,pMsg.m_swObjID,'(__)CTM104::>TEM  DIN:',@pMsg);
        case nReq.m_swParamID of
          QRY_AUTORIZATION       : begin ReadAutorAns(pMsg); IsPackRecieved := false; end;
          QRY_NULL_COMM          : Read2KRES(pMsg);
          QRY_POD_TRYB_HEAT      : ReadDataRes(pMsg);
          QRY_NACKM_POD_TRYB_HEAT: ReadDataMonRes(pMsg);
        end;
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    End;
    Result := res;
End;

procedure CTem104Meter.HandQryRoutine(var pMsg:CMessage);
Var
    Date1, Date2 : TDateTime;
    param        : word;
    wPrecize     : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate       := 1;
    IsPackRecieved := false;
    m_nCounter     := 0;
    m_nCounter1    := 0;
    //FinalAction;
    m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param    := pDS.m_swData1;
    wPrecize := pDS.m_swData2;
    AddGraphParams(Date1, Date2, param);
end;

function CTem104Meter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res          : Boolean;
    //nReq         : CQueryPrimitive;
    tempP        : ShortInt;
Begin
    res := False;
    //Обработчик для L3
    m_nRxMsg.m_sbyServerID := 0;
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       //TraceM(2,pMsg.m_swObjID,'(__)CTM104::>TEM  DRQ:',@pMsg);
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));         //Specc0 - номер канала (теплосистемы)
         case nReq.m_swParamID of
           QM_ENT_MTR_IND         : begin OnEnterAction; exit; end;
           QM_FIN_MTR_IND         : begin OnFinalAction; exit; end;
           QRY_AUTORIZATION       : CreateAutoReq(nReq);
           QRY_NULL_COMM          : Begin m_nID:=0;nReq.m_swSpecc1:=$7c;Create2KREQ(nReq);End;
           QRY_POD_TRYB_HEAT      : Begin FillChar(sDY,sizeof(sDY),0);m_nID:=0;CreateDataReq(m_nNextDay,nReq);End;
           QRY_NACKM_POD_TRYB_HEAT: Begin FillChar(sDM,sizeof(sDM),0);m_nID:=0;CreateDataReq(m_nNextMon,nReq);End;
         end;
      End;
      QL_DATA_GRAPH_REQ     : HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ : OnFinHandQryRoutine(pMsg);
    End;
    Result := res;
End;
procedure CTem104Meter.OnEnterAction;
Begin
    IsPackRecieved := false;
    TraceL(2,m_nP.m_swMID,'(__)CTM104::>TEM OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
    //FinalAction;
End;
procedure CTem104Meter.OnFinalAction;
Begin
    IsPackRecieved := false;
    TraceL(2,m_nP.m_swMID,'(__)CTM104::>TEM OnFinalAction');
    FinalAction;
End;
procedure CTem104Meter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CTM104::>TEM OnConnectComplette');
    m_nModemState := 1;
    FinalAction;
End;
procedure CTem104Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CTM104::>TEM OnDisconnectComplette');
    m_nModemState := 0;
End;
procedure CTem104Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     //if m_nModemState=1 then
     OnFinalAction;
     TraceM(2,pMsg.m_swObjID,'(__)CTM104::>TEM OnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := 0;
     m_nCounter := 0;
     m_nCounter1:= 0;
    End;
end;

function CTem104Meter.CRC(var buf : array of byte; cnt : byte):boolean;
var
    ind,CRCHi : byte;
    i         : integer;
begin
   Result  := true;
   ind := 0;
   for i:=0 to cnt-1 do
   ind := ind + buf[i];
   CRCHi := not ind;
   if (buf[cnt]<>CRCHi) then
   Result := false;
   buf[cnt] := CRCHi;
end;

procedure CTem104Meter.RunMeter;
Begin

End;

function CTem104Meter.GetStringFromFile(FileName : string; nStr : integer) : string;
var f :TStringList;
begin
   f := TStringList.Create();
   f.LoadFromFile(FileName);
   Result := f.Strings[nStr];
   f.Free;
end;

procedure CTem104Meter.EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
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

end.
