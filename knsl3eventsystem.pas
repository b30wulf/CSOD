unit knsl3eventsystem;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
controls,utldatabase,knsl5tracer,knsl3EventBox,utlTimeDate,knsl3datamatrix,knsl3jointable;
type
     CEventSystem = class
     private
      m_pMX : PCDataMatrix;
      m_sQS : SQWERYCMDID;
      procedure SaveJrnlEvents(var pMsg:CMessage);
      procedure SaveKorrMonth(var pMsg:CMessage);
      procedure SaveLimKorr(var pMsg:CMessage);
      procedure SaveEventsDB(var pMsg:CMessage);
      procedure SendToL2(wEvType:Word;var pMsg:CMessage);
      procedure SendLockMX(snVMID:Integer);
      procedure SendUnLockMX(snVMID:Integer);
      procedure ReadJrnl1_BTI(var pMsg:CMessage);
      procedure ReadJrnl2_BTI(var pMsg:CMessage);
      procedure ReadJrnl3_BTI(var pMsg:CMessage);
      function  IsGroupUnlock(snVMID:Integer):Boolean;
      function  FindTokenGR(var str:String;var nVMID:Integer):Boolean;
     public
      constructor Create(pMX:PCDataMatrix);
      destructor Destroy;override;
      procedure Run;
      function EventHandler(var pMsg:CMessage):Boolean;
      function ExtractData(var pMsg:CMessage):Boolean;
     End;
implementation
//CEventSystem
constructor CEventSystem.Create(pMX:PCDataMatrix);
Begin
     m_pMX := pMX;
     //SendLockMX(2);
     //SendLockMX(3);
     //SendUnLockMX(2);
     //SendUnLockMX(3);
End;
destructor CEventSystem.Destroy;
Begin
End;
function CEventSystem.EventHandler(var pMsg:CMessage):Boolean;
Begin
End;
function CEventSystem.ExtractData(var pMsg:CMessage):Boolean;
Begin
     case pMsg.m_sbyType of
          PH_EVENTS_INT:SaveJrnlEvents(pMsg);
     End;
End;
{
procedure CEventSystem.SaveJrnlEvents(var pMsg:CMessage);
begin
     case pMsg.m_sbyInfo[1] of
          QRY_JRNL_T1,       // : ReadPhaseJrnl(pMsg);
          QRY_JRNL_T2,       // : ReadStateJrnl(pMsg);
          QRY_JRNL_T3        : SaveEventsDB(pMsg);//ReadKorrJrnl(pMsg);
          QRY_SUM_KORR_MONTH : SaveKorrMonth(pMsg);
          QRY_LIM_TIME_KORR  : SaveLimKorr(pMsg);
     end;
end;
}
procedure CEventSystem.SaveJrnlEvents(var pMsg:CMessage);
begin
     if pMsg.m_sbyServerID <> DEV_BTI_SRV then
     begin
      case pMsg.m_sbyInfo[1] of
           QRY_JRNL_T1,       // : ReadPhaseJrnl(pMsg);
           QRY_JRNL_T2,       // : ReadStateJrnl(pMsg);
           QRY_JRNL_T3        : SaveEventsDB(pMsg);//ReadKorrJrnl(pMsg);
           QRY_SUM_KORR_MONTH : SaveKorrMonth(pMsg);
           QRY_LIM_TIME_KORR  : SaveLimKorr(pMsg);
      end;
     end else
     begin
      case pMsg.m_sbyInfo[1] of
           QRY_JRNL_T1,
           QRY_JRNL_T4 : ReadJrnl1_BTI(pMsg);
           QRY_JRNL_T2 : ReadJrnl2_BTI(pMsg);
           QRY_JRNL_T3 : ReadJrnl3_BTI(pMsg);
      end;
     end;
end;
procedure CEventSystem.ReadJrnl1_BTI(var pMsg:CMessage);
var
     Date : TDateTime;
     m_swVMID : Integer;
begin
     m_swVMID := pMsg.m_swObjID;
     if (pMsg.m_sbyInfo[3] <> 0) and (pMsg.m_sbyInfo[4] <> 0) then
     begin
      Date := EncodeDate(pMsg.m_sbyInfo[2] + 2000, pMsg.m_sbyInfo[3], pMsg.m_sbyInfo[4]) +
              EncodeTime(pMsg.m_sbyInfo[5], pMsg.m_sbyInfo[6], pMsg.m_sbyInfo[7], 0);
//      m_pDB.FixMeterEvent(pMsg.m_sbyInfo[8] - 1, pMsg.m_sbyInfo[9], 0, pMsg.m_sbyInfo[12]*$100 + pMsg.m_sbyInfo[13], Date);
     end;
end;
procedure CEventSystem.ReadJrnl2_BTI(var pMsg:CMessage);
var
     Date : TDateTime;
     m_swVMID : Integer;
begin
     m_swVMID := pMsg.m_swObjID;
     if (pMsg.m_sbyInfo[3] <> 0) and (pMsg.m_sbyInfo[4] <> 0) then
     begin
      Date := EncodeDate(pMsg.m_sbyInfo[2] + 2000, pMsg.m_sbyInfo[3], pMsg.m_sbyInfo[4]) +
              EncodeTime(pMsg.m_sbyInfo[5], pMsg.m_sbyInfo[6], pMsg.m_sbyInfo[7], 0);
//      m_pDB.FixMeterEvent(pMsg.m_sbyInfo[8] - 1, pMsg.m_sbyInfo[9], m_swVMID, pMsg.m_sbyInfo[12]*$100 + pMsg.m_sbyInfo[13], Date);
     end;
end;
procedure CEventSystem.ReadJrnl3_BTI(var pMsg:CMessage);
var
     Date : TDateTime;
     m_swVMID : Integer;
begin
     m_swVMID := pMsg.m_swObjID;
     if (pMsg.m_sbyInfo[3] <> 0) and (pMsg.m_sbyInfo[4] <> 0) then
     begin
      Date := EncodeDate(pMsg.m_sbyInfo[2] + 2000, pMsg.m_sbyInfo[3], pMsg.m_sbyInfo[4]) +
              EncodeTime(pMsg.m_sbyInfo[5], pMsg.m_sbyInfo[6], pMsg.m_sbyInfo[7], 0);
//      m_pDB.FixMeterEvent(pMsg.m_sbyInfo[8] - 1, pMsg.m_sbyInfo[9], m_swVMID, pMsg.m_sbyInfo[12]*$100 + pMsg.m_sbyInfo[13], Date);
     end;
end;
procedure CEventSystem.SaveKorrMonth(var pMsg:CMessage);
var
     Value : WORD;
begin
     move(pMsg.m_sbyInfo[9], Value, 2);
     TraceL(3, 0, '(__)CL3MD::>CVMTR: EVT: Суммарное время коррекции = ' + IntToStr(Value));
//     m_pDB.FixUSPDCorrMonth(Value, Now);
end;
procedure CEventSystem.SaveLimKorr(var pMsg:CMessage);
begin
//     m_pDB.FixMeterEvent(2, EVM_ERR_KORR, pMsg.m_swObjID ,  0,Now);
     TraceL(3, 0, '(__)CL3MD::>CVMTR: EVT: Выход за пределы коррекции');
end;
procedure CEventSystem.SaveEventsDB(var pMsg:CMessage);
Var
     wEvType : Word;
     nPrm    : Double;
     Date  : TDateTime;
     byJrnType : Byte;
Begin
     byJrnType := pMsg.m_sbyFrom;
     Move(pMsg.m_sbyInfo[2],wEvType,sizeof(Word));
     Move(pMsg.m_sbyInfo[4],nPrm,sizeof(Double));
     Move(pMsg.m_sbyInfo[12],Date,sizeof(TDateTime));
     Move(pMsg.m_sbyInfo[21],m_sQS,sizeof(SQWERYCMDID));
     m_sQS.m_snVMID := pMsg.m_swObjID;
//     m_pDB.FixMeterEvent(byJrnType, wEvType, pMsg.m_swObjID, nPrm, Date);
     if (wEvType=EVA_METER_NO_ANSWER) then
     Begin
      SendToL2(wEvType,pMsg);
      SendLockMX(pMsg.m_swObjID);
     End else
     if (wEvType=EVA_METER_ANSWER) then
     Begin
      SendToL2(wEvType,pMsg);
      SendUnLockMX(pMsg.m_swObjID);
     End;
End;
procedure CEventSystem.SendToL2(wEvType:Word;var pMsg:CMessage);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     sQC.m_snABOID := m_sQS.m_snABOID;
     sQC.m_snSRVID := m_sQS.m_snSRVID;
     sQC.m_snCLID  := m_sQS.m_snCLID;
     sQC.m_snCLSID := m_sQS.m_snCLSID;
     sQC.m_snVMID  := pMsg.m_swObjID;
     sQC.m_snMID   := m_sQS.m_snMID;
     sQC.m_snResult:= m_sQS.m_snResult; //PortID
     sQC.m_snCmdID := QS_ERL2_SR;
     sQC.m_snPrmID := m_sQS.m_snPrmID;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     Move(pDS,pMsg.m_sbyInfo[0],sizeof(CMessageData));
     SendMsgData(BOX_QSRV,wEvType,DIR_CSTOQS,QSRV_ERR_L2_REQ,pDS);
End;
procedure CEventSystem.SendLockMX(snVMID:Integer);
Var
     nJN : CJoinTable;
     i : Integer;
Begin
     m_pMX.SetAllLockState(snVMID,SA_LOCK);
     nJN := CJoinTable.Create(m_pMX);
     nJN.GetTopLMatrix(snVMID,QRY_SRES_ENR_EP);
     if nJN.m_pQSMD.Count=0 then ClearDMX(m_sQS.m_snABOID,m_sQS.m_snVMID,-1);
     for i:=0 to nJN.m_pQSMD.Count-1 do
     Begin
      m_pMX.SetAllLockState(nJN.m_pQSMD.Items[i],SA_LOCK);
      ClearDMX(m_sQS.m_snABOID,nJN.m_pQSMD.Items[i],-1);
     End;
     nJN.Destroy;
End;
procedure CEventSystem.SendUnLockMX(snVMID:Integer);
Var
     nJN : CJoinTable;
     i : Integer;
Begin
     m_pMX.SetAllLockState(snVMID,SA_UNLK);
     nJN := CJoinTable.Create(m_pMX);
     nJN.GetTopLMatrix(snVMID,QRY_SRES_ENR_EP);
     for i:=0 to nJN.m_pQSMD.Count-1 do if IsGroupUnlock(nJN.m_pQSMD.Items[i])=True then m_pMX.SetAllLockState(nJN.m_pQSMD.Items[i],SA_UNLK);
     nJN.Destroy;
End;
function CEventSystem.IsGroupUnlock(snVMID:Integer):Boolean;
Var
     nAID,nGID : Word;
     i,nVMID : Integer;
     strExpr : String;
Begin
     Result := True;
     if not Assigned(m_pMX.m_nDMX[snVMID,QRY_SRES_ENR_EP]) then exit;
     strExpr := m_pMX.m_nDMX[snVMID,QRY_SRES_ENR_EP].Express;
     while FindTokenGR(strExpr,nVMID)=True do
     Begin
      if Assigned(m_pMX.m_nDMX[nVMID,QRY_SRES_ENR_EP]) then
      Begin
       if m_pMX.m_nDMX[nVMID,QRY_SRES_ENR_EP].m_sbyLockState=SA_LOCK then
       Begin
        Result := False;
        Exit;
       End else
       if (m_pMX.m_nDMX[nVMID,QRY_SRES_ENR_EP].m_sbyLevel<>0)and(nVMID<>snVMID) then
          Result := IsGroupUnlock(nVMID);
      End;
     End;
End;
function CEventSystem.FindTokenGR(var str:String;var nVMID:Integer):Boolean;
Var
     res : Boolean;
     sV  : String;
     i,j : Integer;
Begin
     Result := False;
      //Find VMID
     i := Pos('v',str)+1;
     if i=1 then exit;
     if i>2 then Begin Delete(str,1,i-2);i:=Pos('v',str)+1;End;
     j := Pos('_',str);
     if j<=i then Begin {pTN.blError:=True;}exit;End;
     sV := Copy(str,i,j-i);
     Delete(str,1,(j+2)-i);
     nVMID := StrToInt(sV);
     Result := True;
End;
procedure CEventSystem.Run;
Begin

End;

end.
