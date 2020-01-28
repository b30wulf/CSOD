{*******************************************************************************
  Синхронизация времени от корректора FMTime 
*******************************************************************************}


unit knsl2fmtime;
//{$DEFINE FMTime_DEBUG}

interface

uses
  Windows, Classes, SysUtils, SyncObjs, stdctrls, comctrls,
  utltypes, utlbox, utlconst, utlmtimer, utlTimeDate,
  knsl2meter, knsl5tracer, knsl3observemodule;

type
    CFMTime = class(CMeter)
    Private
     m_State       : Byte;
     m_Freq        : Longword;
     m_IsFreqSaved : Boolean;
     m_Time        : TDateTime;

//     nReq        : CQueryPrimitive;
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   CreateMSGHead(var pMsg:CHMessage; Size : word);
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     function    LoHandler(var pMsg:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     function    GetCommand(byCommand:Byte):Integer;
     constructor Create;
     procedure   HandQryRoutine(var pMsg:CMessage);
     function    CRC(var buf : array of byte; cnt : byte; IsSet : Boolean) : boolean;
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
    // procedure   SetHandScenario;
    End;

implementation

constructor CFMTime.Create;
Begin
  MessageBox(0, 'FMTime  CFMTime.Create','(__)CL2MD::>',MB_OK);
  m_Freq := 0;
  m_IsFreqSaved := true;
End;
      {
procedure CFMTime.SetHandScenario;
Begin
  m_nObserver.ClearCurrQry;
  m_nObserver.AddCurrParam(QRY_DATA_TIME, 0, 0, 0, 1);
End;    }

procedure CFMTime.InitMeter(var pL2:SL2TAG);
Begin
  TraceLR(2,0,'(__)CL2MD::>FMTime  CFMTime.InitMeter(var pL2:SL2TAG)');

     SetHandScenario;
     SetHandScenarioGraph;
    TraceL(2,0,'(__)CL2MD::>FMTime Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;

procedure CFMTime.CreateMSGHead(var pMsg:CHMessage; Size : word);
begin
    pMsg.m_swLen       := Size;
    pMsg.m_swObjID     := m_nP.m_swMID;    //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;      //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ;   //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID:= DEV_COM;       //DEF_COM
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_RDKORR;      //Указать тип счетчика
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;


procedure CFMTime.SetCurrQry;
Begin
  TraceLR(2,0,'(__)CL2MD::>FMTime  CFMTime.SetCurrQry');
    with m_nObserver do
    Begin
     ClearCurrQry;
     SetHandScenario;
     SetHandScenarioGraph;
//     AddCurrParam(QRY_DATA_TIME, 0, 0, 0, 1);
//     AddCurrParam(QRY_FMT_SET_FREQ, 0, 0, 0, 1);
//     AddCurrParam(QRY_FMT_SET_FREQEE, 0, 0, 0, 1);
//     AddCurrParam(QRY_FMT_SET_TIME, 0, 0, 0, 1);
    End;
End;


procedure CFMTime.SetGraphQry;
begin
 { TraceLR(2,0,'(__)CL2MD::>FMTime  CFMTime.SetGraphQry');
       m_nObserver.AddGraphParam(QRY_DATA_TIME, 0, 0, 0, 1);    }
end;


function CFMTime.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
  TraceLR(2,0,'(__)CL2MD::>FMTime  CFMTime.SelfHandler(var pMsg:CMessage):Boolean');
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;


function CFMTime.LoHandler(var pMsg:CMessage):Boolean;
Var
  Hour, Min, Sec   : word;
  Year, Month, Day : word;
  res              : Boolean;
  cmd              : Integer;
Begin
    TraceLR(2,0,'(__)CL2MD::>FMTime  CFMTime.LoHandler(var pMsg:CMessage):Boolean');
    res := False;
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
        TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>FMTime  DIN:',@pMsg);

        cmd := pMsg.m_sbyInfo[1];
        // отсутствует маркер начала пакета
        // или установлен старший бит поля "комманда"
        if (pMsg.m_sbyInfo[0] <> $53) or ((pMsg.m_sbyInfo[0] and $80)<>0) then
           //or (pMsg.m_sbyInfo[0] and $69 <> 0) then
        begin
          Result := false;
          exit;
        end;

        case cmd of
          $0F : // текущее состояние
          begin
            Sec     := (pMsg.m_sbyInfo[3] shr 4)*10 + (pMsg.m_sbyInfo[3] and $0F);
            Min     := (pMsg.m_sbyInfo[4] shr 4)*10 + (pMsg.m_sbyInfo[4] and $0F);
            Hour    := (pMsg.m_sbyInfo[5] shr 4)*10 + (pMsg.m_sbyInfo[5] and $0F);
            m_Time  := 0;
            DecodeDate(Now, Year, Month, Day);
            m_Time  := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Min, Sec, 0);
            cDateTimeR.SetTimeToPC(m_Time);
            {m_Freq  := (pMsg.m_sbyInfo[6] or (pMsg.m_sbyInfo[7] shl 8))*50 - 10700;
            m_State :=  pMsg.m_sbyInfo[8];}
          end;
          $12, // установка частоты
          $22, // установка частоты с сохранением в eeprom
          $21 : // установка времени в FMTime
            ;
        End;

        //m_byRep        := m_nP.m_sbyRepMsg;
        m_nRepTimer.OffTimer;
        FinalAction;
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    End;
    Result := res;
End;


procedure CFMTime.HandQryRoutine(var pMsg:CMessage);
Var
  Hour, Min, Sec, mSec   : word;
  param                  : word;
  pDS                    : CMessageData;
  nReq                   : CQueryPrimitive;
begin
    TraceLR(2,0,'(__)CL2MD::>FMTime  CFMTime.HandQryRoutine(var pMsg:CMessage)');
    m_nObserver.ClearGraphQry;
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    exit;  //Ничего не делаем (пока!!!)
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    param    := pDS.m_swData1;


      //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
      //TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>FMTime  DRQ:',@pMsg);
      Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));

      if nReq.m_swParamID=QM_ENT_MTR_IND   then Begin OnEnterAction;exit;End;
      if nReq.m_swParamID=QM_FIN_MTR_IND   then Begin OnFinalAction;exit;End;

      m_nTxMsg.m_sbyInfo[0] := $53;                         // маркер
      m_nTxMsg.m_sbyInfo[1] := $0F;//GetCommand(nReq.m_swParamID);// функция

      case m_nTxMsg.m_sbyInfo[1] of
      $0F : // чтение состояния
        m_nTxMsg.m_sbyInfo[2] := 0;
      $12,  // установить частоту
      $22 : // установить частоту и записать ее в eeprom 
        begin
          m_Freq := nReq.m_swSpecc0;
          m_nTxMsg.m_sbyInfo[2] := 2;
          m_nTxMsg.m_sbyInfo[3] := (m_Freq and $000000FF);
          m_nTxMsg.m_sbyInfo[4] := (m_Freq and $0000FF00) shr 8;
        end;
        $21 : // установить время в устройстве
        begin
          m_nTxMsg.m_sbyInfo[2] := 3;
          m_nTxMsg.m_sbyInfo[3] := ((nReq.m_swSpecc0 div 10) shl 4) or (nReq.m_swSpecc0 mod 10);
          m_nTxMsg.m_sbyInfo[4] := ((nReq.m_swSpecc1 div 10) shl 4) or (nReq.m_swSpecc1 mod 10);
          m_nTxMsg.m_sbyInfo[5] := ((nReq.m_swSpecc2 div 10) shl 4) or (nReq.m_swSpecc2 mod 10);
        end;
      End;

      if (m_nTxMsg.m_sbyInfo[2] > 0) then
        CRC(m_nTxMsg.m_sbyInfo, m_nTxMsg.m_sbyInfo[2] + 4, True);
      SendOutStat(m_nTxMsg.m_swLen);
      FPUT(BOX_L1 ,@m_nTxMsg);

//      m_nRepTimer.OnTimer(m_nP.m_swRepTime);


    case param of
      QRY_DATA_TIME      :
        m_nObserver.AddCurrParam(QRY_DATA_TIME, 0, 0, 0, 1);
{
      QRY_FMT_SET_FREQ   :
        m_nObserver.AddGraphParam(QRY_FMT_SET_FREQ, (m_Freq + 10700) div 50, 0, 0, 0);

      QRY_FMT_SET_FREQEE :
        m_nObserver.AddGraphParam(QRY_FMT_SET_FREQ, 0, 0, 0, 0);

      QRY_FMT_SET_TIME   :
      begin
        DecodeTime(Now(), Hour, Min, Sec, mSec);
        m_nObserver.AddGraphParam(QRY_FMT_SET_FREQ, Hour, Min, Sec, 0);
      end;
      }
    end;
end;

{*******************************************************************************
  @todo: предусмотреть запись частоты из системной конфигурации
*******************************************************************************}
function CFMTime.HiHandler(var pMsg:CMessage):Boolean;
Var
    res          : Boolean;
    nReq         : CQueryPrimitive;
    dLen         : Smallint;
Begin
  TraceLR(2,0,'(__)CL2MD::>FMTime  CFMTime.HiHandler(var pMsg:CMessage):Boolean');
  res := False;
  //Обработчик для L3
  case pMsg.m_sbyType of
    QL_DATARD_REQ:
    Begin

      //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
      //TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>FMTime  DRQ:',@pMsg);
      Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));

      if nReq.m_swParamID=QM_ENT_MTR_IND   then Begin OnEnterAction;exit;End;
      if nReq.m_swParamID=QM_FIN_MTR_IND   then Begin OnFinalAction;exit;End;
      if (nReq.m_swParamID = QRY_KPRTEL_KE) or (nReq.m_swParamID = QRY_AUTORIZATION) then
        FinalAction;  
      m_nTxMsg.m_sbyInfo[0] := $53;                         // маркер
      m_nTxMsg.m_sbyInfo[1] := GetCommand(nReq.m_swParamID);// функция
      if m_nTxMsg.m_sbyInfo[1] <> $0F then
        exit;
      case m_nTxMsg.m_sbyInfo[1] of
      $0F : // чтение состояния
           begin
             m_nTxMsg.m_sbyInfo[2] := 0;
             dLen  := 3;
           end;
      $12,  // установить частоту
      $22 : // установить частоту и записать ее в eeprom 
        begin
          m_Freq := nReq.m_swSpecc0;
          m_nTxMsg.m_sbyInfo[2] := 2;
          m_nTxMsg.m_sbyInfo[3] := (m_Freq and $000000FF);
          m_nTxMsg.m_sbyInfo[4] := (m_Freq and $0000FF00) shr 8;
        end;
        $21 : // установить время в устройстве
        begin
          m_nTxMsg.m_sbyInfo[2] := 3;
          m_nTxMsg.m_sbyInfo[3] := ((nReq.m_swSpecc0 div 10) shl 4) or (nReq.m_swSpecc0 mod 10);
          m_nTxMsg.m_sbyInfo[4] := ((nReq.m_swSpecc1 div 10) shl 4) or (nReq.m_swSpecc1 mod 10);
          m_nTxMsg.m_sbyInfo[5] := ((nReq.m_swSpecc2 div 10) shl 4) or (nReq.m_swSpecc2 mod 10);
        end;
      End;

      CRC(m_nTxMsg.m_sbyInfo, dLen, True);
      CreateMSGHead(m_nTxMsg, dLen + 11);
      //SendOutStat(m_nTxMsg.m_swLen);
      FPUT(BOX_L1 ,@m_nTxMsg);

      m_nRepTimer.OnTimer(m_nP.m_swRepTime);
   End;
      QL_DATA_GRAPH_REQ: HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    End;
    Result := res;
End;

procedure CFMTime.OnEnterAction;
Begin
    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>FMTime OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
    //FinalAction;
End;

procedure CFMTime.OnFinalAction;
Begin
    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>FMTime OnFinalAction');
    //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
    //if m_nP.m_sbyModem=0 then FinalAction;
    //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
    FinalAction;

//    m_byRep := m_nP.m_sbyRepMsg;
//    m_nRepTimer.OffTimer;
    SendSyncEvent;
End;

procedure CFMTime.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>FMTime OnConnectComplette');
    m_nModemState := 1;
    FinalAction;
End;

procedure CFMTime.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>FMTime OnDisconnectComplette');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;

procedure CFMTime.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  TraceLR(2,0,'(__)CL2MD::>FMTime  CFMTime.OnFinHandQryRoutine(var pMsg:CMessage)');
    if m_nP.m_sbyEnable=1 then
    Begin
     //if m_nModemState=1 then
     OnFinalAction;
     TraceM(4,0,'(__)CL2MD::>FMTime OnFinHandQryRoutine  DRQ:',@pMsg);
    End;
end;

function CFMTime.GetCommand(byCommand:Byte):Integer;
Var
    res : Integer;
Begin
    case byCommand of
     QRY_DATA_TIME      :   res := $0F;
//     QRY_FMT_SET_FREQ   :   res := $12;
//     QRY_FMT_SET_FREQEE :   res := $22;
//     QRY_FMT_SET_TIME   :   res := $21;
     else
     res:=-1;
    End;
    Result := res;
End;


function CFMTime.CRC(var buf : array of byte; cnt : byte; IsSet : Boolean) : boolean;
var
    CRC : byte;
    i   : byte;
begin
    Result  := true;
    CRC     := $00;
    for i := 3 to cnt - 1 do
     CRC := (CRC + buf[i]);

    if(IsSet = true) then
      buf[cnt] := CRC;
    if (CRC <> buf[cnt]) then
      Result := false;
end;

procedure CFMTime.RunMeter;
Begin
    //m_nRepTimer.RunTimer;
    //m_nObserver.Run;
End;
end.
