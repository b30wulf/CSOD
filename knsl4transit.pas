unit knsl4transit;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,knsl4automodule
,knsl5tracer,utldatabase,utlTimeDate,knsl5config,knsl3lme,knsl2module,knsl1module,knsl3module,knsl3savetime;
type
    CTransitModule = class(CHIAutomat)
    private
     m_nTxMsg            : CMessage;
     m_pDDB              : PCDBDynamicConn;
     mPassword           : string;
     mIsOpenSession      : boolean;
     TonnelPort          : integer;
     mTranzBuf           : array [0..7] of byte;
     m_sTblL1            : SL1INITITAG;
     PhAddrAndComPrt     : SPHADRANDCOMPRTS;
     InnerPDS            : CMessageData;
     InnerFunctionPr     : Integer;
     procedure StartTranz;
     procedure FinishTranz;
     procedure SendMsgToMeter(var pMsg : CMessage); //Отправка сообщения напрямую в счетчик
     function  FindPortToOpenTonnel(portID : integer) : integer; //return PortID
     function  FindPortID : word;
     procedure SendTranzAns(var pMsg : CMessage);
     Procedure CreateMSGHead(Var pMsg : CMessage; len : word);
    public
     procedure InitAuto(var pTable : SL1TAG);override;
     function LoHandler(var pMsg : CMessage):Boolean;override;
     function HiHandler(var pMsg : CMessage):Boolean;override;
     procedure RunAuto;override;
     function  SelfHandler(var pMsg: CMessage):Boolean; override;
    End;
implementation

Procedure CTransitModule.CreateMSGHead(Var pMsg : CMessage; len : word);
Begin
   pMsg.m_swLen := len + 11;
   pMsg.m_swObjID := m_swAddres;
   pMsg.m_sbyFrom := DIR_EKOMTOL1;
   pMsg.m_sbyFor := DIR_EKOMTOL1;
   pMsg.m_sbyType := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID := m_sbyPortID;
   pMsg.m_sbyIntID := m_sbyPortID;
End;

procedure CTransitModule.StartTranz;
Var
    pDS : CMessageData;
begin
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   m_nCF.SchedPause;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
   m_sIsTranzOpen.m_sbIsTrasnBeg := true;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
end;

procedure CTransitModule.FinishTranz;
begin
   m_nRepTimer.OffTimer;
   m_sIsTranzOpen.m_sbIsTrasnBeg := false;
   m_nCF.SchedGo;
end;

procedure CTransitModule.SendMsgToMeter(var pMsg : CMessage); //Отправка сообщения напрямую в счетчик
begin
   StartTranz;
   m_sIsTranzOpen.m_sbIsTrasnBeg := true;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], pMsg.m_swLen - 11);
   m_nTxMsg.m_swLen       := pMsg.m_swLen;
   m_nTxMsg.m_swObjID     := m_sbyID;             //Сетевой адрес счётчика
   m_nTxMsg.m_sbyFrom     := DIR_L2TOL1;
   m_nTxMsg.m_sbyFor      := DIR_L2TOL1;         //DIR_L2toL1
   m_nTxMsg.m_sbyType     := PH_DATARD_REQ;      //PH_DATARD_REC
   m_nTxMsg.m_sbyIntID    := TonnelPort;
   m_nTxMsg.m_sbyServerID := MET_SS301F3;          //Указать тип счетчика
   m_nTxMsg.m_sbyDirID    := TonnelPort;
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure CTransitModule.InitAuto(var pTable : SL1TAG);
var i       : integer;
    VMeters : SL3GROUPTAG;
Begin
   m_pDDB := m_pDB.CreateConnect;
   mPassword := pTable.m_schPhone;
   TonnelPort := -1;
   m_pDDB.GetL1Table(m_sTblL1);
   if m_pDDB.GetVMetersTable(-1,-1, VMeters) then
   begin
     PhAddrAndComPrt.Count := VMeters.m_swAmVMeter;
     SetLength(PhAddrAndComPrt.Items, VMeters.m_swAmVMeter);
     for i := 0 to VMeters.m_swAmVMeter - 1 do
     begin
       PhAddrAndComPrt.Items[i].m_swPHAddres := StrToInt(VMeters.Item.Items[i].m_sddPHAddres) ;
       PhAddrAndComPrt.Items[i].m_swPortID   := VMeters.Item.Items[i].m_sbyPortID;
     end;
   end;
   mIsOpenSession := false;
End;

procedure CTransitModule.SendTranzAns(var pMsg : CMessage);
begin
   FinishTranz;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], pMsg.m_swLen - 11);
   CreateMSGHead(m_nTxMsg, pMsg.m_swLen-11);
   FPUT(BOX_L1, @m_nTxMsg);
end;

function CTransitModule.LoHandler(var pMsg : CMessage):Boolean;
Var
  fnc : integer;
Begin
    Result := True;
    try
      TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>C12 LOH:',@pMsg);
      if m_nRepTimer.IsProceed and (pMsg.m_sbyIntID = TonnelPort) then
      begin
        SendTranzAns(pMsg);
        exit;
      end;
      TonnelPort := FindPortID;
      SendMsgToMeter(pMsg);
    except
    end;
End;
function CTransitModule.HiHandler(var pMsg : CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>C12 HIH:',@pMsg);
    Result := res;
End;
procedure CTransitModule.RunAuto;
Begin

End;

function CTransitModule.SelfHandler(var pMsg: CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;

    m_sIsTranzOpen.m_sbIsTrasnBeg := false;
    m_nCF.SchedGo;

    InnerFunctionPr := 0;
    Result := res;
end;

function CTransitModule.FindPortToOpenTonnel(portID : integer) : integer; //return PortID
var i : integer;
begin
   Result := -1;
   for i := 0 to m_sTblL1.Count - 1 do
     if m_sTblL1.Items[i].m_sbyPortID = portID then
     begin
       Result := m_sTblL1.Items[i].m_sbyPortID;
       break;
     end;
end;

function  CTransitModule.FindPortID : word;
var i : integer;
begin
   Result := High(word);
   if PhAddrAndComPrt.Count > 0 then
     Result := PhAddrAndComPrt.Items[0].m_swPortID;
end;

end.
