unit knsl2meter;
//{$DEFINE METER_DEBUG}
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl5config,utlmtimer,
 knsl3observemodule,utldynconnect,knsl3querysender,utldatabase,knsl3EventBox,utlSpeedTimer,utlTimeDate;
type
    CMeter = class
    test_massiv     : PCIntBuffer;
    test_massiv_ADR : PCIntBuffer;
    protected
     m_byRep       : Byte;
     m_nRepTimer   : CTimer;
     m_nReStart    : CTimer;
     m_nRepSpTimer : CSpeedTimer;
     m_nObserver   : CObserveMOdule;
     m_nTxMsg      : CHMessage;
     m_nModemState : Byte;
     m_byMonitor   : Byte;
     m_fModel      : Double;
     m_nModelCt    : Integer;
     m_byQweryMon  : Byte;
     m_swNS        : DWORD;
     IsUpdate      : Byte;
     m_nCounter    : Integer;
     m_nCounter1   : Integer;
     m_nSvNS       : DWORD;
     m_nAutoTMR    : CTimer;
     m_nIsReset    : Boolean;
     mpMsg         : Pointer;
     mpQry         : CQueryPrimitive;
     m_sQC         : SQWERYCMDID;
     dynConnect    : CDBDynamicConn;
     function saveToDB(var pMsg:CHMessage):Boolean;
     function saveToDB_8086(fub_num:string; id_object: integer; var pMsg:CHMessage):Boolean;
     function saveToDBByt(var pMsg:CHMessage):Boolean;
     function getTypeParam(cmdID:Integer):Integer;
     function  SelfHandler(var pMsg:CMessage):Boolean;virtual; abstract;
     function  LoHandler(var pMsg:CMessage):Boolean;virtual; abstract;
     function  HiHandler(var pMsg:CMessage):Boolean;virtual; abstract;
     function  SetCommand(swParamID:Word;swSpecc0,swSpecc1,swSpecc2:Smallint;byEnable:Byte):Boolean;virtual;
     procedure SendMSG(byBox:Integer;byFor,byType:Byte);
     procedure SendQSCommEx(snAID,snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);
     procedure RestartSystem;
     procedure SetHandScenario;
     procedure SetHandScenarioGraph;
     procedure FinalAction;
     procedure SendOutStat(nLen:Integer);
     procedure OnConnectComplette(var pMsg:CMessage);virtual;
     procedure OnDisconnectComplette(var pMsg:CMessage);virtual;
     procedure OpenPhone;
     procedure StartCorrEv(DateTime : TDateTime);
     procedure FinishCorrEv(Delta : TDateTime);
     procedure ErrorCorrEv;
     procedure SendL3Event(byType:Byte;byJrnType:Byte;wEvType:Word;nMID:Word;nPrm:Double;dtDate:TDateTime);
     procedure CreateAutoBlockEv;virtual;
     procedure CreateNoAutoBlockEv;virtual;
     function  RV(fValue : Double):Double;
     function  RVK(fValue : Double):Double;
     procedure OnEnterMonAction(var pQR:CQueryPrimitive);
     procedure OnFinalMonAction(var pQR:CQueryPrimitive);
     procedure SendToL1(wBox:Integer;pMsg:Pointer);
     function  MsgOutPrepare(pMsg:Pointer;var mpMsg:CHMessage):Pointer;
     procedure MsgInPrepare(var pMsg:Cmessage);
     procedure SaveSQParam(var pQR:CQueryPrimitive);
     procedure SendL1;
    public
     m_nRxMsg    : CHMessage;
     m_nP        : SL2TAG;
     m_nT        : CMeterTag;
     m_nPortAddr : Byte;
     blIsKTRout  : Byte;
     BOX_L3_BY   : Integer;
     State_8086  : Integer;
     destructor Destroy; override;
     procedure Init(var pL2:SL2TAG);
     procedure InitMeter(var pL2:SL2TAG);virtual; abstract;
     procedure Run;
     procedure setDbConnect(vDynConnect:CDBDynamicConn);
     function getDbConnect:CDBDynamicConn;
     procedure RunSpeed;
     procedure RunMeter;virtual; abstract;
     procedure SetBox(byBox:Byte);
     function  EventHandler(var pMsg:CMessage):Boolean;
     function  SelfBaseHandler(var pMsg:CMessage):Boolean;
     function  LoBaseHandler(var pMsg:CMessage):Boolean;
     function  HiBaseHandler(var pMsg:CMessage):Boolean;
     procedure StopObserve;
     procedure StartObserve;
     procedure GoObserve;
     procedure ResumeQrySender;
     procedure SuspendQrySender;
     procedure StopQrySender;
     procedure StartQrySender;
     procedure FreeQrySender;
     procedure StopL2Observer;
     procedure StartL2Observer;
     procedure GoL2Observer;
     procedure StopChnlObserver;
     procedure StartChnlObserver;
     procedure GoChnlObserver;
     procedure SendSyncEvent;
     function  Compare(var nS0,nS1:SL2TAG):Boolean;
     function  GetType:Byte;
     function  GetPRID:Byte;
     procedure InitScenario;
     procedure OnLoadCounter;
     procedure OnFinal;
     procedure OnFree;
     function send(var outMessage:CMessage):Boolean;
     function getConnectionString:String;
     procedure getStrings(s1:String;var value:TStringList);
     procedure SetHandScenario164MMeter;
    public
    property PObserver : CObserveMOdule read m_nObserver write m_nObserver;
    End;
    PCMeter =^ CMeter;

implementation

destructor CMeter.Destroy;
Begin
    if m_nReStart<>Nil  then FreeAndNil(m_nReStart);
    if m_nAutoTMR<>Nil  then FreeAndNil(m_nAutoTMR);
    if m_nRepTimer<>Nil then FreeAndNil(m_nRepTimer);
    if m_nObserver<>Nil then FreeAndNil(m_nObserver);
    inherited;
End;
procedure CMeter.Init(var pL2:SL2TAG);
Var
    str : String;
Begin
    m_nIsReset := False;
    if GetParceString(0,pL2.m_sAdvDiscL2Tag)='reset' then
    m_nIsReset := True;
    if Compare(pL2,m_nP)=False then
    Begin
     if m_nObserver=Nil then m_nObserver := CObserveModule.Create;
     m_nObserver.setDbConnect(dynConnect);
     m_nObserver.SetBox(BOX_L2);
     m_nObserver.Init(pL2);
     Move(pL2,m_nP,sizeof(m_nP));
     if m_nRepTimer=Nil then m_nRepTimer := CTimer.Create;
     m_nRepTimer.SetTimer(DIR_L2TOL2,DL_REPMSG_TMR,0,m_nP.m_swMID,BOX_L2);
     if m_nAutoTMR=Nil then m_nAutoTMR := CTimer.Create;
     m_nAutoTMR.SetTimer(DIR_L2TOL2,DL_AUTORIZED_TM_REQ,0,m_nP.m_swMID,BOX_L2);
     if m_nReStart=Nil then m_nReStart := CTimer.Create;
     m_nReStart.SetTimer(DIR_L2TOL2,DL_RESTART_TM_REQ,0,m_nP.m_swMID,BOX_L2);
     InitMeter(pL2);
     m_byRep                 := m_nP.m_sbyRepMsg;
     m_nRxMsg.m_swObjID      := m_nP.m_swMID;
     m_nRxMsg.m_sbyFrom      := DIR_L2TOL3;
     m_nRxMsg.m_sbyFor       := DIR_L2TOL3;
     m_nRxMsg.m_sbyType      := DL_DATARD_IND;
     //m_nRxMsg.m_sbyTypeIntID := m_nP.m_byPortType;
     m_nRxMsg.m_sbyIntID     := m_nP.m_sbyPortID;
     m_nRxMsg.m_sbyServerID  := 0;
     m_nRxMsg.m_sbyDirID     := m_nP.m_sbyGroupID;
    End;
    if m_nP.m_sbyEnable=1 then
    Begin
      //m_pDB.UpdateBlStateMeter(m_nP.m_swMID, ST_L2_NO_AUTO_BLOCK);
      //m_nP.m_sbyStBlock := (m_nP.m_sbyStBlock and ST_L2_NO_AUTO_BLOCK) or ST_L2_NO_AUTO_BLOCK;
    End else
    if m_nP.m_sbyEnable=0 then
    Begin
      //m_pDB.UpdateBlStateMeter(m_nP.m_swMID, ST_L2_AUTO_BLOCK);
      //m_nP.m_sbyStBlock := (m_nP.m_sbyStBlock and ST_L2_AUTO_BLOCK) or ST_L2_AUTO_BLOCK;
    End;
    m_swNS := 0;
    m_byMonitor   := 0;
    m_nModemState := 1;
    if m_nP.m_sbyModem=1 then m_nModemState := 0;
    m_nP.m_blOneSynchro := False;
    //StartQrySender;
End;
procedure CMeter.setDbConnect(vDynConnect:CDBDynamicConn);
Begin
    dynConnect := vDynConnect;
End;
function CMeter.getDbConnect:CDBDynamicConn;
Begin
    Result := dynConnect;
End;
function CMeter.send(var outMessage:CMessage):Boolean;
Var
    msg  : CMessage;
    outLongMessage : CMessage;
Begin
    FillChar(m_nTxMsg,sizeof(CHMessage),0);
    FillChar(outMessage,sizeof(CMessage),0);
    if(m_nObserver.box.FCHECK()>0) then
    Begin
     m_nObserver.box.FGET(@mpQry);
     msg.m_swLen    := sizeof(CQueryPrimitive)+11;
     msg.m_sbyFor   := DIR_L3TOL2;
     msg.m_sbyType  := QL_DATARD_REQ;
     msg.m_swObjID  := m_nP.m_swMID;
     Move(mpQry,msg.m_sbyInfo[0],sizeof(CQueryPrimitive));
     HiBaseHandler(msg);
     Move(m_nTxMsg,outMessage,m_nTxMsg.m_swLen);
     outMessage.m_sbyDirID := mpQry.m_swParamID;
     Result         := true;
     exit;
    End;
    Result := false;
End;
function CMeter.saveToDB(var pMsg:CHMessage):Boolean;
Var
     data : L3CURRENTDATA;
     dDT  : CDTTime;
     SQL_LOG:string;
Begin
     data.m_swVMID  := pMsg.m_swObjID;
     data.m_swCMDID := pMsg.m_sbyInfo[1];
     data.m_swTID   := pMsg.m_sbyInfo[8];
     data.m_swSID   := pMsg.m_sbyServerID;
     Move(pMsg.m_sbyInfo[2],dDT,sizeof(CDTTime));
     if (dDT.Year=0)or(dDT.Month=0)or(dDT.Day=0)or(dDT.Month>12)or(dDT.Hour>23)or(dDT.Month>12)or(dDT.Day>31)or(dDT.Sec>59) then exit else
     data.m_sTime   := EncodeDate(2000+dDT.Year,dDT.Month,dDT.Day)+EncodeTime(dDT.Hour,dDT.Min,dDT.Sec,0);
     Move(pMsg.m_sbyInfo[9],data.m_sfValue,sizeof(Double));
     case getTypeParam(data.m_swCMDID) of
          SV_CURR_ST:
          Begin
            dynConnect.SetCurrentParamNoBlock(data);
           // if not ((data.m_swCMDID>=QRY_ENERGY_SUM_EP) and (data.m_swCMDID<=QRY_ENERGY_SUM_EP)) then
           // dynConnect.UpdatePDTFilds_48(data);
          End;
          SV_ARCH_ST:
          Begin
          // dynConnect.AddArchDataNoBlock(data,SQL_LOG);
           dynConnect.AddArchDataNoBlock(data);
           //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(SQL= '+SQL_LOG+')');
          End;
          SV_GRPH_ST:
          begin
          data.m_sMaskRead:=281474976710655;     //В дальнейшем надо высчитать
          data.m_sMaskReRead:=281474976710655;   //В дальнейшем надо высчитать
          dynConnect.UpdateGD48(data);
          end;
     End;
End;

function CMeter.saveToDB_8086(fub_num: string; id_object: integer; var pMsg:CHMessage):Boolean;
Var
     data : L3CURRENTDATA;
     dDT  : CDTTime;
     SQL_LOG:string;
Begin
     data.m_swVMID  := pMsg.m_swObjID;
     data.m_swCMDID := pMsg.m_sbyInfo[1];
     data.m_swTID   := pMsg.m_sbyInfo[8];
     data.m_swSID   := pMsg.m_sbyServerID;
     Move(pMsg.m_sbyInfo[2],dDT,sizeof(CDTTime));
     if (dDT.Year=0)or(dDT.Month=0)or(dDT.Day=0)or(dDT.Month>12)or(dDT.Hour>23)or(dDT.Month>12)or(dDT.Day>31)or(dDT.Sec>59) then exit else
     data.m_sTime   := EncodeDate(2000+dDT.Year,dDT.Month,dDT.Day)+EncodeTime(dDT.Hour,dDT.Min,dDT.Sec,0);
     Move(pMsg.m_sbyInfo[9],data.m_sfValue,sizeof(Double));
     case getTypeParam(data.m_swCMDID) of
          SV_CURR_ST:
          Begin
            //dynConnect.SetCurrentParamNoBlock(data);
            dynConnect.SetCurrentParamNoBlock_8086(fub_num, id_object, data);
            if not ((data.m_swCMDID>=QRY_ENERGY_SUM_EP) and (data.m_swCMDID<=QRY_ENERGY_SUM_EP)) then
            dynConnect.UpdatePDTFilds_48_8086(fub_num, id_object, data);
          End;
          SV_ARCH_ST:
          Begin
           //if isTrueValue(data) then
           dynConnect.AddArchDataNoBlock_8086(fub_num, id_object, data{,SQL_LOG});
           //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(SQL= '+SQL_LOG+')');
          End;
          SV_GRPH_ST: dynConnect.UpdateGD48_8086(fub_num, id_object, data);
     End;
End;

function CMeter.saveToDBByt(var pMsg:CHMessage):Boolean;
Var
     data : L3CURRENTDATA;
     dDT  : CDTTime;
     strSql :string;
Begin
     data.m_swVMID  := pMsg.m_swObjID;
     data.m_swCMDID := pMsg.m_sbyInfo[1];
     data.m_swTID   := pMsg.m_sbyInfo[8];
     data.m_swSID   := pMsg.m_sbyServerID;
     Move(pMsg.m_sbyInfo[2],dDT,sizeof(CDTTime));
     if (dDT.Year=0)or(dDT.Month=0)or(dDT.Day=0)or(dDT.Month>12)or(dDT.Hour>23)or(dDT.Month>12)or(dDT.Day>31)or(dDT.Sec>59) then exit else
     data.m_sTime   := EncodeDate(2000+dDT.Year,dDT.Month,dDT.Day)+EncodeTime(dDT.Hour,dDT.Min,dDT.Sec,0);
     Move(pMsg.m_sbyInfo[9],data.m_sfValue,sizeof(Double));
     case getTypeParam(data.m_swCMDID) of
          SV_CURR_ST:
          Begin
            dynConnect.SetCurrentParamNoBlock(data);
            if not ((data.m_swCMDID>=QRY_ENERGY_SUM_EP) and (data.m_swCMDID<=QRY_ENERGY_SUM_EP)) then
            dynConnect.UpdatePDTFilds_48(data);
          End;
          SV_ARCH_ST:
          Begin
           //if isTrueValue(data) then
           dynConnect.AddArchDataNoBlockByt(data,strSql);
//           m_nT.ListBD.Add(strSql);
          End;
          SV_GRPH_ST: dynConnect.UpdateGD48(data);
     End;
End;



function CMeter.getTypeParam(cmdID:Integer):Integer;
Begin
     if (((cmdID>=QRY_ENERGY_DAY_EP) and (cmdID<=QRY_ENERGY_DAY_RM)) or
        ((cmdID>=QRY_NAK_EN_DAY_EP) and (cmdID<=QRY_NAK_EN_DAY_RM))) or
        (((cmdID>=QRY_ENERGY_MON_EP) and (cmdID<=QRY_ENERGY_MON_RM)) or
        ((cmdID>=QRY_NAK_EN_MONTH_EP) and (cmdID<=QRY_NAK_EN_MONTH_RM))) then
     Begin
       Result := SV_ARCH_ST;
       exit;
     End else
     if((cmdID>=QRY_SRES_ENR_EP)and(cmdID<=QRY_SRES_ENR_RM)) then
     Begin
       Result := SV_GRPH_ST;
       exit;
     End else
     if(((cmdID>=QRY_ENERGY_SUM_EP) and (cmdID<=QRY_ENERGY_SUM_EP)) or
        ((cmdID>=QRY_MGAKT_POW_S) and (cmdID<=QRY_FREQ_NET))) then
     Begin
       Result := SV_CURR_ST;
       exit;
     End else
     Begin
       Result := SV_CURR_ST;
       exit;
     End;
End;
procedure CMeter.getStrings(s1:String;var value:TStringList);
Var
    i,j:Integer;
    s2,separator : string;
    index : Integer;
Begin
    separator := ';';
    while pos(separator, s1)<>0 do
    begin
     index := pos(separator, s1);
     s2 := copy(s1,1,index-1);
     j := j + 1;
     delete (s1, 1, pos(separator, S1));
     value.Add(s2);
    end;
    if pos (separator, s1)=0 then
    begin
     j := j + 1;
     value.Add(s1);
    end;
End;
function CMeter.getConnectionString:String;
Begin
    Result := m_nP.m_sPhone;
End;
procedure CMeter.OnFinal;
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     IsUpdate   := 0;
     m_nCounter := 0;                            
     m_nCounter1:= 0;
     m_nQrySender[m_nP.m_sbyPortID].DiscSender;
     m_byRep := m_nP.m_sbyRepMsg;
     //TraceL(2,m_nTxMsg.m_swObjID,'(__)CL2MD::>StopL2TM (OnFinal):'+IntToStr(m_nP.m_swRepTime));
     m_nRepTimer.OffTimer;
     SendSyncEvent;
    End;
end;
procedure CMeter.OnFree;
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     IsUpdate   := 0;
     m_nCounter := 0;
     m_nCounter1:= 0;
     m_nQrySender[m_nP.m_sbyPortID].FreeSender;
     m_byRep := m_nP.m_sbyRepMsg;
     //TraceL(2,m_nTxMsg.m_swObjID,'(__)CL2MD::>StopL2TM (OnFree):'+IntToStr(m_nP.m_swRepTime));
     m_nRepTimer.OffTimer;
     SendSyncEvent;
    End;
end;
procedure CMeter.SendToL1(wBox:Integer;pMsg:Pointer);
Var
    mpMsg : CHMessage;
Begin
    if m_nP.m_sAD.m_sbyNSEnable=0 then
    Begin
     //FPUT(wBox,pMsg)
    End
    else
    if m_nP.m_sAD.m_sbyNSEnable=1 then
    Begin
     MsgOutPrepare(pMsg,mpMsg);
     FPUT(wBox,@mpMsg);
    End;
End;
{
CMSDS = packed record
     m_sdwFMark    : DWORD;
     m_swLen       : Word;
     m_swType      : Word;
     m_swNS        : DWORD;
     m_sdwRetrans  : DWORD;
     m_sdwKommut   : DWORD;
     m_sdwDevice   : DWORD;
     m_sbySpeed    : Byte;
     m_sbyParity   : Byte;
     m_sbyStop     : Byte;
     m_sbyKBit     : Byte;
     m_sbyPause    : Byte;
     m_sbyReserv0  : Byte;
     m_sbyReserv1  : array [0..9] of Byte;
     m_sbyInfo     : array [0..2000] of Byte;
     //m_sdwEMark    : DWORD;
    End;
}
function CMeter.MsgOutPrepare(pMsg:Pointer;var mpMsg:CHMessage):Pointer;
Var
    nMS   : CMSDS;
    mMS   : PCMessage;
Begin
    mMS := pMsg;
    if mMS.m_swLen>150 then exit;
    Move(pMsg^,mpMsg,mMS.m_swLen);
    nMS.m_sdwFMark := m_nP.m_sAD.m_sdwFMark;

    nMS.m_swType   := $0001;
    nMS.m_swNS     := m_swNS;
    m_nSvNS        := m_swNS;
    Inc(m_swNS);


    nMS.m_sdwRetrans := m_nP.m_sAD.m_sdwRetrans;
    nMS.m_sdwKommut  := m_nP.m_sAD.m_sdwKommut;
    nMS.m_sdwDevice  := m_nP.m_sAD.m_sdwDevice;

    nMS.m_sbySpeed   := m_nP.m_sAD.m_sbySpeed;
    nMS.m_sbyParity  := m_nP.m_sAD.m_sbyParity;
    nMS.m_sbyStop    := m_nP.m_sAD.m_sbyStop;
    nMS.m_sbyKBit    := m_nP.m_sAD.m_sbyKBit;
    nMS.m_sbyPause   := m_nP.m_sAD.m_sbyPause;
    nMS.m_nB0Timer   := m_nP.m_sAD.m_nB0Timer;

    //nMS.m_sbyReserv0 := 0;
    FillChar(nMS.m_sbyReserv1[0],10,0);
    Move(mpMsg.m_sbyInfo[0],nMS.m_sbyInfo[0],mpMsg.m_swLen-11);
    nMS.m_swLen := 36+(mpMsg.m_swLen-11);

    Move(m_nP.m_sAD.m_sdwEMark,nMS.m_sbyInfo[mpMsg.m_swLen-11],sizeof(DWORD));
    Move(nMS,mpMsg.m_sbyInfo[0],nMS.m_swLen+2*sizeof(DWORD));
    mpMsg.m_swLen := 13+nMS.m_swLen+2*sizeof(DWORD);

//    with nMS do TraceL(2,m_nP.m_swMID,'(__)CL2MD::>OTDS LEN:'+IntToStr(m_swLen)+' TPE:'+IntToStr(m_swType)+' NS:'+IntToStr(m_swNS)+' RET:'+IntToStr(m_sdwRetrans)+
//                       ' KOM:'+IntToStr(m_sdwKommut)+' DEV:'+IntToStr(m_sdwDevice)+' SPD:'+IntToStr(m_sbySpeed)+' PRT:'+IntToStr(m_sbyParity)+
//                       ' STP:'+IntToStr(m_sbyStop)+' KBT:'+IntToStr(m_sbyKBit)+' TMS:'+IntToStr(m_sbyPause)+' TB0:'+IntToStr(m_nB0Timer));
//    TraceM(2,mpMsg.m_swObjID,'(__)CL2MD::>OUTM :',@mpMsg);
    Result := @mpMsg;
End;
procedure CMeter.MsgInPrepare(var pMsg:CMessage);
Var
    nMS : CMSDS;
    nLen,i : Word;
Begin
    Move(pMsg.m_sbyInfo[0],nMS,40);
    if nMS.m_swLen>2000 then exit;
    if nMS.m_swNS<>m_nSvNS then
    Begin
//     TraceL(2,m_nP.m_swMID,'(__)CL2MD::>Error!!!: Out NS:'+IntToStr(m_nSvNS)+'<> In NS:'+IntToStr(nMS.m_swNS));
     if m_byNSCompare=1 then
     exit;
    End;
    //m_swNS
    //Move(pMsg.m_sbyInfo[36+4],pMsg.m_sbyInfo[0],nMS.m_swLen-36);
    for i:=0 to nMS.m_swLen-36-1 do pMsg.m_sbyInfo[i] := pMsg.m_sbyInfo[36+4+i];
    pMsg.m_swLen := 13+nMS.m_swLen-36;
    if m_nP.m_sAD.m_sbyNSEnable=1 then
    Begin
//     with nMS do TraceL(2,m_nP.m_swMID,'(__)CL2MD::>INDS LEN:'+IntToStr(m_swLen)+' TPE:'+IntToStr(m_swType)+' NS:'+IntToStr(m_swNS)+' RET:'+IntToStr(m_sdwRetrans)+
//                       ' KOM:'+IntToStr(m_sdwKommut)+' DEV:'+IntToStr(m_sdwDevice)+' SPD:'+IntToStr(m_sbySpeed)+' PRT:'+IntToStr(m_sbyParity)+
//                       ' STP:'+IntToStr(m_sbyStop)+' KBT:'+IntToStr(m_sbyKBit)+' TMS:'+IntToStr(m_sbyPause)+' TB0:'+IntToStr(m_nB0Timer));
//    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>INME :',@pMsg);

    End;
End;
procedure CMeter.OnConnectComplette(var pMsg:CMessage);
Begin
End;

procedure CMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
End;
procedure CMeter.OpenPhone;
Var
    pDS  : CMessageData;
    nLen : Integer;
    i : Integer;
Begin
    //SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_RESET_PORT_IND);
    nLen := Length(m_nP.m_sPhone)+1;
    pDS.m_swData0 := nLen-1;
    pDS.m_swData1 := m_nP.m_swCurrQryTm;
    if nLen<50 then
    Begin
     for i:=0 to nLen-1 do pDS.m_sbyInfo[i] := Byte(m_nP.m_sPhone[i+1]);
     pDS.m_sbyInfo[nLen] := Byte(#0);
     SendMsgIData(BOX_L1,m_nP.m_swMID,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND,pDS);
    End;
    m_byRep := m_nP.m_sbyRepMsg;
    //TraceL(2,m_nTxMsg.m_swObjID,'(__)CL2MD::>StopL2TM (OpenPhone):'+IntToStr(m_nP.m_swRepTime));
    m_nRepTimer.OffTimer;
End;

//m_pDB.FixMeterEvent(2, EVH_START_CORR, m_nP.m_swVMID, 0, Date);
//m_pDB.FixMeterEvent(2, EVH_FINISH_CORR, m_nP.m_swVMID, 0, Date);

procedure CMeter.StartCorrEv(DateTime : TDateTime);
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
    Mask               : word;
begin
   Mask := $4000;
   DecodeDate(Now, Year, Month, Day);
   DecodeTime(Now, Hour, Min, Sec, ms);
   m_nRxMsg.m_swLen      := 11 + 9 + 3 + sizeof(Double);
   m_nRxMsg.m_sbyType    := PH_EVENTS_INT;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_sbyServerID:= DEV_MASTER;
   m_nRxMsg.m_sbyInfo[0] := 9 + 3 + sizeof(Double);
   m_nRxMsg.m_sbyInfo[1] := QRY_JRNL_T3;
   m_nRxMsg.m_sbyInfo[2] := Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := Month;
   m_nRxMsg.m_sbyInfo[4] := Day;
   m_nRxMsg.m_sbyInfo[5] := Hour;
   m_nRxMsg.m_sbyInfo[6] := Min;
   m_nRxMsg.m_sbyInfo[7] := Sec;
   m_nRxMsg.m_sbyInfo[8] := StrToInt(m_nP.m_sddPHAddres);
   move(Mask, m_nRxMsg.m_sbyInfo[9], 2);
   m_nRxMsg.m_sbyInfo[11]:= 10;
   move(DateTime, m_nRxMsg.m_sbyInfo[12], sizeof(Double));
   SendL3Event(QRY_JRNL_T3,2, EVM_START_CORR, m_nP.m_swMID, 0, Now);
end;

procedure CMeter.FinishCorrEv(Delta : TDateTime);
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
    Mask               : word;
    f_Temp             : Double;
    tDate              : TDateTime;
begin
   Mask := $4000;
   tDate := Now + cDateTimeR.GetSecInDTFormat;
   DecodeDate(tDate, Year, Month, Day);
   DecodeTime(tDate, Hour, Min, Sec, ms);
   m_nRxMsg.m_swLen      := 13 + 9 + 3 + sizeof(Double); //11
   m_nRxMsg.m_sbyType    := PH_EVENTS_INT;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_sbyServerID:= DEV_MASTER;
   m_nRxMsg.m_sbyInfo[0] := 9 + 3 + sizeof(Double);
   m_nRxMsg.m_sbyInfo[1] := QRY_JRNL_T3;
   m_nRxMsg.m_sbyInfo[2] := Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := Month;
   m_nRxMsg.m_sbyInfo[4] := Day;
   m_nRxMsg.m_sbyInfo[5] := Hour;
   m_nRxMsg.m_sbyInfo[6] := Min;
   m_nRxMsg.m_sbyInfo[7] := Sec;
   m_nRxMsg.m_sbyInfo[8] := StrToInt(m_nP.m_sddPHAddres);
   move(Mask, m_nRxMsg.m_sbyInfo[9], 2);
   m_nRxMsg.m_sbyInfo[11]:= 11;
   f_Temp := Delta / EncodeTime(0, 0, 1, 0);
   move(f_Temp, m_nRxMsg.m_sbyInfo[12], sizeof(Double));
   SendL3Event(QRY_JRNL_T3,2, EVM_FINISH_CORR, m_nP.m_swMID,f_Temp, Now);
end;

procedure CMeter.ErrorCorrEv;
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
    Mask               : word;
begin
   Mask := $4000;
   DecodeDate(Now, Year, Month, Day);
   DecodeTime(Now, Hour, Min, Sec, ms);
   m_nRxMsg.m_swLen      := 11 + 9 + 3;
   m_nRxMsg.m_sbyType    := PH_EVENTS_INT;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_sbyServerID:= DEV_MASTER;
   m_nRxMsg.m_sbyInfo[0] := 9 + 3;
   m_nRxMsg.m_sbyInfo[1] := QRY_JRNL_T3;
   m_nRxMsg.m_sbyInfo[2] := Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := Month;
   m_nRxMsg.m_sbyInfo[4] := Day;
   m_nRxMsg.m_sbyInfo[5] := Hour;
   m_nRxMsg.m_sbyInfo[6] := Min;
   m_nRxMsg.m_sbyInfo[7] := Sec;
   m_nRxMsg.m_sbyInfo[8] := StrToInt(m_nP.m_sddPHAddres);
   move(Mask, m_nRxMsg.m_sbyInfo[9], 2);
   m_nRxMsg.m_sbyInfo[11]:= 12;
   SendL3Event(QRY_JRNL_T3,2, EVM_ERROR_CORR, m_nP.m_swMID,0, Now);
end;

procedure CMeter.CreateAutoBlockEv;
var Year, Month, Day,
    Hour, Min, Sec, ms  : word;
    Mask                : word;
begin
   Mask := $4000;
   DecodeDate(Now, Year, Month, Day);
   DecodeTime(Now, Hour, Min, Sec, ms);
   m_nRxMsg.m_swLen      := 11 + 9 + 3;
   m_nRxMsg.m_sbyType    := PH_EVENTS_INT;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_sbyServerID:= DEV_MASTER;
   m_nRxMsg.m_sbyInfo[0] := 9 + 3;
   m_nRxMsg.m_sbyInfo[1] := QRY_JRNL_T2;
   m_nRxMsg.m_sbyInfo[2] := Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := Month;
   m_nRxMsg.m_sbyInfo[4] := Day;
   m_nRxMsg.m_sbyInfo[5] := Hour;
   m_nRxMsg.m_sbyInfo[6] := Min;
   m_nRxMsg.m_sbyInfo[7] := Sec;
   m_nRxMsg.m_sbyInfo[8] := StrToInt(m_nP.m_sddPHAddres);
   move(Mask, m_nRxMsg.m_sbyInfo[9], 2);
   m_nRxMsg.m_sbyInfo[11]:= 13;
   SendL3Event(QRY_JRNL_T2,1, EVA_METER_NO_ANSWER, m_nP.m_swMID, 0, Now);

end;

procedure CMeter.CreateNoAutoBlockEv;
var Year, Month, Day,
    Hour, Min, Sec, ms  : word;
    Mask                : word;
begin
   Mask := $4000;
   DecodeDate(Now, Year, Month, Day);
   DecodeTime(Now, Hour, Min, Sec, ms);
   m_nRxMsg.m_swLen      := 11 + 9 + 3;
   m_nRxMsg.m_sbyType    := PH_EVENTS_INT;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_sbyServerID:= DEV_MASTER;
   m_nRxMsg.m_sbyInfo[0] := 9 + 3;
   m_nRxMsg.m_sbyInfo[1] := QRY_JRNL_T2;
   m_nRxMsg.m_sbyInfo[2] := Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := Month;
   m_nRxMsg.m_sbyInfo[4] := Day;
   m_nRxMsg.m_sbyInfo[5] := Hour;
   m_nRxMsg.m_sbyInfo[6] := Min;
   m_nRxMsg.m_sbyInfo[7] := Sec;
   m_nRxMsg.m_sbyInfo[8] := StrToInt(m_nP.m_sddPHAddres);
   move(Mask, m_nRxMsg.m_sbyInfo[9], 2);
   m_nRxMsg.m_sbyInfo[11]:= 14;
   SendL3Event(QRY_JRNL_T2,1, EVA_METER_ANSWER, m_nP.m_swMID, 0, Now);
end;
procedure CMeter.SendL3Event(byType:Byte;byJrnType:Byte;wEvType:Word;nMID:Word;nPrm:Double;dtDate:TDateTime);
Var
   pMsg : CHMessage;
Begin
   pMsg.m_swLen      := 13+30;
   pMsg.m_swObjID    := nMID;
   pMsg.m_sbyType    := PH_EVENTS_INT;
   pMsg.m_sbyFor     := DIR_L2TOL3;
   pMsg.m_sbyFrom    := byJrnType;
   pMsg.m_sbyInfo[1] := byType;
   Move(wEvType,pMsg.m_sbyInfo[2],sizeof(Word));
   Move(nPrm,pMsg.m_sbyInfo[4],sizeof(Double));
   Move(dtDate,pMsg.m_sbyInfo[12],sizeof(TDateTime));
   if m_nCF.QueryType= QWR_QWERY_SRV then
   Begin
    pMsg.m_swLen      := pMsg.m_swLen+sizeof(SQWERYCMDID);
    Move(m_sQC,pMsg.m_sbyInfo[21],sizeof(SQWERYCMDID));
   End;
   FPUT(BOX_L3_BY,@pMsg);
End;

function CMeter.RVK(fValue : Double):Double;
Var
     nDiv : Double;
Begin
     case (m_nPrecise+1) of
     1 : nDiv := 10;
     2 : nDiv := 100;
     3 : nDiv := 1000;
     4 : nDiv := 10000;
     5 : nDiv := 100000;
     6 : nDiv := 1000000;
     7 : nDiv := 10000000;
     else
         nDiv := 1000;
     End;
       Result := fValue;
     //Result := round(fValue*1000)/1000;
     //Result := fValue;
     //Result := round(fValue*nDiv*m_nP.m_sfMeterKoeff)/nDiv;
     //Result := round(fValue*10000*m_nP.m_sfMeterKoeff)/10000;
End;
function CMeter.RV(fValue : Double):Double;
Var
     nDiv : Double;
Begin
     case (m_nPrecise+1) of
     1 : nDiv := 10;
     2 : nDiv := 100;
     3 : nDiv := 1000;
     4 : nDiv := 10000;
     5 : nDiv := 100000;
     6 : nDiv := 1000000;
     7 : nDiv := 10000000;
     else
         nDiv := 1000;
     End;
     //Result := round(fValue*10000)/10000;
     //Result := round(fValue*nDiv)/nDiv;
     Result := fValue;
End;
procedure CMeter.InitScenario;
Begin
    m_nObserver.Init(m_nP);
    InitMeter(m_nP);
End;
function CMeter.GetType:Byte;
Begin
    Result := m_nP.m_sbyType;
End;
function CMeter.GetPRID:Byte;
Begin
    Result := m_nP.m_sbyPortID;
End;
{
m_sbyGroupID   : Byte;
     m_swVMID       : WORD;
     m_sbyPortID    : Byte;
     m_swMID        : WORD;
     m_sbyType      : Byte;
     m_sbyLocation  : Byte;
     m_sddFabNum    : string[26];
     m_sddPHAddres  : string[26];
     m_schPassword  : String[16];
     m_schName      : String[100];
     m_sbyRepMsg    : Byte;
     m_swRepTime    : Word;
     m_sfKI         : Double;
     m_sfKU         : Double;
     m_sfMeterKoeff : Double;
     m_sbyPrecision : Byte;
     m_swCurrQryTm  : Word;
     m_sbyTSlice    : Byte;
     m_sPhone       : String[30];
     m_sbyModem     : Byte;

     m_sbyEnable    : Byte;
     m_swMinNKan    : Word;
     m_swMaxNKan    : Word;
     m_sdtSumKor    : TDateTime;
     m_sdtLimKor    : TDateTime;
     m_sdtPhLimKor  : TDateTime;
}
function CMeter.Compare(var nS0,nS1:SL2TAG):Boolean;
Begin
    if nS0.m_sbyID<>nS1.m_sbyID               then Begin Result := False;Exit;End;
    if nS0.m_sbyGroupID<>nS1.m_sbyGroupID     then Begin Result := False;Exit;End;
    if nS0.m_swVMID<>nS1.m_swVMID             then Begin Result := False;Exit;End;
    if nS0.m_sbyPortID<>nS1.m_sbyPortID       then Begin Result := False;Exit;End;
    if nS0.m_swMID<>nS1.m_swMID               then Begin Result := False;Exit;End;
    if nS0.m_sbyType<>nS1.m_sbyType           then Begin Result := False;Exit;End;
    if nS0.m_sbyLocation<>nS1.m_sbyLocation   then Begin Result := False;Exit;End;
    if nS0.m_sddFabNum<>nS1.m_sddFabNum       then Begin Result := False;Exit;End;
    if nS0.m_sddPHAddres<>nS1.m_sddPHAddres   then Begin Result := False;Exit;End;
    if nS0.m_schPassword<>nS1.m_schPassword   then Begin Result := False;Exit;End;
    if nS0.m_schName<>nS1.m_schName           then Begin Result := False;Exit;End;
    if nS0.m_sbyRepMsg<>nS1.m_sbyRepMsg       then Begin Result := False;Exit;End;
    if nS0.m_swRepTime<>nS1.m_swRepTime       then Begin Result := False;Exit;End;
    if nS0.m_sfKI<>nS1.m_sfKI                 then Begin Result := False;Exit;End;
    if nS0.m_sfKU<>nS1.m_sfKU                 then Begin Result := False;Exit;End;
    if nS0.m_sfMeterKoeff<>nS1.m_sfMeterKoeff then Begin Result := False;Exit;End;
    if nS0.m_swCurrQryTm<>nS1.m_swCurrQryTm   then Begin Result := False;Exit;End;
    if nS0.m_sPhone<>nS1.m_sPhone             then Begin Result := False;Exit;End;
    if nS0.m_sbyModem<>nS1.m_sbyModem         then Begin Result := False;Exit;End;
    if nS0.m_sbyEnable<>nS1.m_sbyEnable       then Begin Result := False;Exit;End;
    if nS0.m_sdtSumKor<>nS1.m_sdtSumKor       then Begin Result := False;Exit;End;
    if nS0.m_sdtLimKor<>nS1.m_sdtLimKor       then Begin Result := False;Exit;End;
    if nS0.m_sbyTSlice<>nS1.m_sbyTSlice       then Begin Result := False;Exit;End;
    if nS0.m_bySynchro<>nS1.m_bySynchro       then Begin Result := False;Exit;End;
    if nS0.m_sbyStBlock<>nS1.m_sbyStBlock     then Begin Result := False;Exit;End;

    if nS0.m_sAD.m_sbyNSEnable<>nS1.m_sAD.m_sbyNSEnable then Begin Result := False;Exit;End;
    if nS0.m_sAD.m_sdwFMark<>nS1.m_sAD.m_sdwFMark       then Begin Result := False;Exit;End;
    if nS0.m_sAD.m_sdwEMark<>nS1.m_sAD.m_sdwEMark       then Begin Result := False;Exit;End;
    if nS0.m_sAD.m_sdwRetrans<>nS1.m_sAD.m_sdwRetrans   then Begin Result := False;Exit;End;
    if nS0.m_sAD.m_sdwKommut<>nS1.m_sAD.m_sdwKommut     then Begin Result := False;Exit;End;
    if nS0.m_sAD.m_sdwDevice<>nS1.m_sAD.m_sdwDevice     then Begin Result := False;Exit;End;
    if nS0.m_sAD.m_sbySpeed<>nS1.m_sAD.m_sbySpeed       then Begin Result := False;Exit;End;
    if nS0.m_sAD.m_sbyParity<>nS1.m_sAD.m_sbyParity     then Begin Result := False;Exit;End;
    if nS0.m_sAD.m_sbyStop<>nS1.m_sAD.m_sbyStop         then Begin Result := False;Exit;End;
    if nS0.m_sAD.m_sbyKBit<>nS1.m_sAD.m_sbyKBit         then Begin Result := False;Exit;End;
    if nS0.m_sAD.m_sbyPause<>nS1.m_sAD.m_sbyPause       then Begin Result := False;Exit;End;
    if nS0.m_sAD.m_nB0Timer<>nS1.m_sAD.m_nB0Timer       then Begin Result := False;Exit;End;
    Result := True;
End;
function CMeter.EventHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    case pMsg.m_sbyFor of
     DIR_L1TOL2: res := LoBaseHandler(pMsg);
     //DIR_L2TOL2: if not m_sIsTranzOpen.m_sbIsTrasnBeg then res := SelfBaseHandler(pMsg);
     DIR_L2TOL2: res := SelfBaseHandler(pMsg);
     DIR_L3TOL2: res := HiBaseHandler(pMsg);
    End;
    Result := res;
End;
function CMeter.SelfBaseHandler(var pMsg:CMessage):Boolean;
Var
    res: Boolean;
Begin
    res := False;
    case pMsg.m_sbyType of
      DL_AUTORIZED_TM_REQ : SelfHandler(pMsg);
      DL_RESTART_TM_REQ: RestartSystem;
      DL_REPMSG_TMR:
      Begin
        //Повторить передачу на L1
        //TraceL(2,m_nP.m_swMID,'(__)CL2MD::>DL_REPMSG_TMR:'+IntToStr(m_byRep));
        if m_byRep<=0 then
        Begin
//         TraceL(3,m_nP.m_swMID,'(__)CL2MD::>STOP:'+IntToStr(m_byRep));
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка связи! '+m_nP.m_schName);
         SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR_IND);
         m_byRep        := m_nP.m_sbyRepMsg;
         m_nRepTimer.OffTimer;
         //TraceL(2,m_nTxMsg.m_swObjID,'(__)CL2MD::>StopL2TM (SelfBaseHandler):'+IntToStr(m_nP.m_swRepTime));
         if (m_nP.m_sbyStBlock and ST_L2_AUTO_BLOCK) = 0 then
         begin
           m_nP.m_sbyStBlock := ST_L2_AUTO_BLOCK;
           m_pDB.UpdateBlStateMeter(m_nP.m_swMID, m_nP.m_sbyStBlock);
           CreateAutoBlockEv;
         end;
        End else
        Begin
//         TraceL(3,m_nP.m_swMID,'(__)CL2MD::>REJ :'+IntToStr(m_byRep));
         //if m_nAutoTMR<>Nil then m_nAutoTMR.OnTimer(10);
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Повторная передача '+IntToStr(m_nP.m_sbyRepMsg-m_byRep+1)+' для:'+m_nP.m_schName);
         //TL2Statistic.SetRej(m_nP.m_swMID,m_nTxMsg.m_swLen);
         if (m_nP.m_sbyRepMsg-m_byRep)=4 then
           SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_RECONN_L1_IND);
         SelfHandler(pMsg);

         if not m_sIsTranzOpen.m_sbIsTrasnBeg then
         Begin
          SendToL1(BOX_L1 ,@m_nTxMsg);
          Dec(m_byRep);
         End else begin end;//TraceL(3,m_nP.m_swMID,'(__)CL2MD::>REJECT Not Enable! Active Tranzaction!');
         m_nRepTimer.OnTimer(m_nP.m_swRepTime);

         //m_nRepTimer.ReRunTimer;
        End;
      End;
      QL_CQRYMSG_TMR,QL_GQRYMSG_TMR:
      m_nObserver.EventHandler(pMsg);
    End;
    //SelfHandler(pMsg);
    Result := res;
End;
{
    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Выполнить перезагрузку приложения. Уверенны?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Выполнить перезагрузку удаленного приложения. Уверенны?';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SendRemCrcReBoot(pDS);exit; End;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RBOOT_DATA_REQ,pDS);
    End;

}
procedure CMeter.RestartSystem;
Var
    pDS : CMessageData;
Begin
    if (m_nIsReset=True) then
    Begin
     pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_CLOSE_USPD_REQ,pDS);
     pDS.m_swData4 := MTR_LOCAL;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RBOOT_DATA_REQ,pDS);
    End;
End;
procedure CMeter.SetHandScenario;
Var
    pQry      : PCQueryPrimitive;
    i,j,bt    : Integer;
    k         : Integer;
    m_sl1Tbl  : SL1TAG;
Begin
    m_nObserver.ClearCurrQry;
    //m_sl1Tbl.m_sbyPortID := m_nP.m_sbyPortID;
    m_sl1Tbl.m_sbyPortID := m_nPortAddr;
    dynConnect.GetPortTable(m_sl1Tbl);
    if (m_nOnAutorization = 1) and (m_sl1Tbl.m_sbyProtID <> DEV_BTI_SRV) then
      m_nObserver.AddCurrParam(QRY_AUTORIZATION, 0, 0, 0, 1);
    if ((m_sl1Tbl.m_sbyProtID <> DEV_BTI_SRV) and (m_nP.m_sbyType = MET_SS301F3)) then
      m_nObserver.AddCurrParam(QRY_KPRTEL_KE, 0, 0, 0, 1);    //Считыв Ke для CC-301(FNC=3)
    if ((m_sl1Tbl.m_sbyProtID = DEV_C12_SRV) and (m_nP.m_sbyType = MET_C12)) then
    begin
      m_nObserver.AddCurrParam(QRY_AUTORIZATION, 0, 0, 0, 1);

      while (m_nObserver.GetCommand(pQry)=True) do
      begin
         if (pQry.m_sbyEnable = 1) AND (StrToInt(pQry.m_swChannel) = 0) then
         begin
            m_nObserver.AddCurrParam(QRY_KPRTEL_KE, 0, 0, 0, 1);    //Считыв Ke для CC-301(FNC=3)
         end;
      end;
    end;
    if (m_sl1Tbl.m_sbyProtID = DEV_BTI_SRV)or(m_sl1Tbl.m_sbyProtID = DEV_K2000B_CLI) then
    begin
      while(m_nObserver.GetCommand(pQry)=True) do
      begin
        m_nObserver.AddCurrParam(pQry.m_swParamID,pQry.m_swSpecc0,pQry.m_swSpecc1,pQry.m_swSpecc2,pQry.m_sbyEnable);
      end;

      exit;
    end;

    while(m_nObserver.GetCommand(pQry)=True) do
    Begin
     if pQry.m_sbyEnable=1 then
     Begin
      if (pQry.m_swSpecc1=-1) then begin j:=4; bt:=0; end else begin j:=0; bt:=0; end;
        for i:=bt to j do
          if (pQry.m_swSpecc2 = -1) and (pQry.m_swParamID = QRY_MAX_POWER_EP) then
          begin
            for k := 1 to 4 do
              m_nObserver.AddCurrParam(pQry.m_swParamID,pQry.m_swSpecc0,i,k,pQry.m_sbyEnable);
          end
          else
          Begin
           if SetCommand(pQry.m_swParamID,pQry.m_swSpecc0,i,pQry.m_swSpecc2,pQry.m_sbyEnable)=True then
           m_nObserver.AddCurrParam(pQry.m_swParamID,pQry.m_swSpecc0,i,pQry.m_swSpecc2,pQry.m_sbyEnable);
          End;
        end;

      //TraceL(2,pQry.m_swMtrID,'(__)CL2MD::>MTR:'+m_nMeterList.Strings[m_nP.m_sbyType]+' CMD:'+IntToStr(pQry.m_swParamID)+':'+m_nCommandList.Strings[pQry.m_swParamID]);
    End;
End;
procedure CMeter.SetHandScenario164MMeter;
begin
 m_nObserver.AddCurrParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;
function CMeter.SetCommand(swParamID:Word;swSpecc0,swSpecc1,swSpecc2:Smallint;byEnable:Byte):Boolean;
Begin
    Result := True;
end;
procedure CMeter.OnLoadCounter;
Var
    szDT : Integer;
    pDS  : CMessageData;
    tmTime0,tmTime1 : TDateTime;
begin
    szDT := sizeof(TDateTime);
    tmTime1 := Now;
    tmTime0 := Now;
    pDS.m_swData0 := 0;
    pDS.m_swData1 := QRY_SRES_ENR_EP;
    pDS.m_swData2 := m_nP.m_swMID;
    pDS.m_swData3 := m_nP.m_sbyPortID;
    pDS.m_swData4 := MTR_LOCAL;
    Move(tmTime1,pDS.m_sbyInfo[0]   ,szDT);
    Move(tmTime0,pDS.m_sbyInfo[szDT],szDT);
    //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_DATA_GRAPH_REQ,pDS);
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_GRAPH_POLL_REQ,pDS);
end;
procedure CMeter.SetHandScenarioGraph;
Begin
End;
procedure CMeter.StopObserve;
Begin
    m_nObserver.StopObserve;
    //SuspendQrySender;
    //StopQrySender;
End;
procedure CMeter.StartObserve;
Begin
    m_nObserver.StartObserve;
    //ResumeQrySender;
    //StartQrySender
End;
procedure CMeter.GoObserve;
Begin
    m_nObserver.GoObserve;
    //StartQrySender;
    //ResumeQrySender;
    StartQrySender;
End;

procedure CMeter.SendSyncEvent;
begin
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_SYNC_EVENT_IND);
    if m_nQrySender[m_nP.m_sbyPortID]<>Nil then
    m_nQrySender[m_nP.m_sbyPortID].Go;
    //mL3Module.m_nQrySender[m_nP.m_sbyPortID].Go;
end;
procedure CMeter.FinalAction;
Begin
    m_byRep := m_nP.m_sbyRepMsg;
    //TraceL(2,m_nTxMsg.m_swObjID,'(__)CL2MD::>StopL2TM (FinalAction):'+IntToStr(m_nP.m_swRepTime));
    m_nRepTimer.OffTimer;
    SendSyncEvent;
End;
//For All Channels
procedure CMeter.StopL2Observer;
Begin
    SendMSG(BOX_L2,DIR_LMTOL2,DL_STOPL2OBS_IND);
End;
procedure CMeter.StartL2Observer;
Begin
    SendMSG(BOX_L2,DIR_LMTOL2,DL_STARTL2OBS_IND);
End;
procedure CMeter.GoL2Observer;
Begin
    SendMSG(BOX_L2,DIR_LMTOL2,DL_GOL2OBS_IND);
End;
//For One Channel
procedure CMeter.StopChnlObserver;
Begin
    //SendMSG(BOX_L2,DIR_LMTOL2,DL_STOPCHLOBS_IND);
End;
procedure CMeter.StartChnlObserver;
Begin
    SendMSG(BOX_L2,DIR_LMTOL2,DL_STARTCHLOBS_IND);
End;
procedure CMeter.GoChnlObserver;
Begin
    SendMSG(BOX_L2,DIR_LMTOL2,DL_GOCHLOBS_IND);
End;
//Qry Sender
procedure CMeter.ResumeQrySender;
Begin
    SendMSG(BOX_L2,DIR_QMTOL2,DL_GOSNDR_IND);
End;
procedure CMeter.SuspendQrySender;
Begin
    SendMSG(BOX_L2,DIR_QMTOL2,DL_PAUSESNDR_IND);
End;
procedure CMeter.StopQrySender;
Begin
    SendMSG(BOX_L2,DIR_QMTOL2,DL_STOPSNDR_IND);
End;
procedure CMeter.StartQrySender;
Begin
    SendMSG(BOX_L2,DIR_QMTOL2,DL_STARTSNDR_IND);
End;
procedure CMeter.FreeQrySender;
Begin
    SendMSG(BOX_L2,DIR_QMTOL2,DL_FREESNDR_IND);
End;
procedure CMeter.SendQSCommEx(snAID,snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snABOID := snAID;
     sQC.m_snSRVID := snSRVID;
     sQC.m_snCLID  := snCLID;
     sQC.m_snCLSID := snCLSID;
     sQC.m_snPrmID := snPrmID;
     sQC.m_snCmdID := nCommand;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     pDS.m_swData4 := MTR_LOCAL;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure CMeter.SendMSG(byBox:Integer;byFor,byType:Byte);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 11;
    m_swObjID     := m_nP.m_swMID;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := m_nP.m_sbyPortID;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    end;
    FPUT(byBox,@pMsg);
End;
function CMeter.LoBaseHandler(var pMsg:CMessage):Boolean;
Begin
    //Для предварительной обработки
    if pMsg.m_sbyType=PH_DATA_IND then
    if (m_nP.m_sbyStBlock and ST_L2_AUTO_BLOCK) <> 0 then
    begin
      m_nP.m_sbyStBlock := (m_nP.m_sbyStBlock xor ST_L2_AUTO_BLOCK) or ST_L2_NO_AUTO_BLOCK;
      m_pDB.UpdateBlStateMeter(m_nP.m_swMID, m_nP.m_sbyStBlock);
      CreateNoAutoBlockEv;
    end;
    if m_nP.m_sAD.m_sbyNSEnable=1 then MsgInPrepare(pMsg);
    Result := LoHandler(pMsg);
    if (m_nIsReset=True) then m_nReStart.OnTimer(10*3600+15*60);
    //TL2Statistic.SetIn(m_nP.m_swMID,pMsg.m_swLen);
End;
function CMeter.HiBaseHandler(var pMsg:CMessage):Boolean;
Var
    nReq : CQueryPrimitive;
Begin
    //Для предварительной обработки
    FillChar(m_nRxMsg,sizeof(CHMessage),0);
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
       if nReq.m_swParamID=QM_ENT_MON_IND   then Begin OnEnterMonAction(nReq);exit;End;
       if nReq.m_swParamID=QM_FIN_MON_IND   then Begin OnFinalMonAction(nReq);exit;End;
      End;
    End;
    HiHandler(pMsg);
End;
procedure CMeter.OnEnterMonAction(var pQR:CQueryPrimitive);
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SS301 OnEnterMonAction');
    SaveSQParam(pQR);
    IsUpdate := pQR.m_swCmdID;
    FinalAction;
End;
procedure CMeter.OnFinalMonAction(var pQR:CQueryPrimitive);
Var
    pDS : CMessageData;
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SS301 OnFinalMonAction');
    IsUpdate := 0;
    Move(pQR,pDS.m_sbyInfo[0],sizeof(CQueryPrimitive));
    SendMsgData(BOX_QSRV,0,DIR_L2TOQS,QSRV_LOAD_COMPL_REQ,pDS);
    FinalAction;
End;
procedure CMeter.SaveSQParam(var pQR:CQueryPrimitive);
Begin
    with m_sQC do
    Begin
     m_snABOID := HiByte(pQR.m_swSpecc2);
     m_snSRVID := LoByte(pQR.m_swSpecc2);
     m_snCLID  := pQR.m_swSpecc1;
     m_snCLSID := HiByte(pQR.m_swSpecc0);
     m_snPrmID := LoByte(pQR.m_swSpecc0);
     m_snMID   := m_nP.m_swMID;
     m_snResult:= m_nP.m_sbyPortID;
     m_snCmdID := CS_CRT_JOB;
    End;
End;
procedure CMeter.SendOutStat(nLen:Integer);
Begin
    //TL2Statistic.SetOut(m_nP.m_swMID,nLen);
End;
procedure CMeter.SetBox(byBox:Byte);
Begin
    //m_byBoxID := byBox;
End;
procedure CMeter.SendL1;
Begin
    //SendOutStat(m_nTxMsg.m_swLen);
    SendToL1(BOX_L1 ,@m_nTxMsg);
    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
End;
procedure CMeter.Run;
Begin
    m_nRepTimer.RunTimer;
    m_nReStart.RunTimer;
    if m_nP.m_sbyEnable=1 then
    m_nObserver.Run;
    RunMeter;
    {$IFDEF METER_DEBUG}
    m_fModel   := sin(m_nModelCt*2*3.14/180);
    m_nModelCt := m_nModelCt + 1;
    {$ENDIF}
End;
procedure CMeter.RunSpeed;
Begin
    if m_nRepSpTimer<>Nil then m_nRepSpTimer.RunTimer;
    {$IFDEF METER_DEBUG}
    m_fModel   := sin(m_nModelCt*2*3.14/180);
    m_nModelCt := m_nModelCt + 1;
    {$ENDIF}
End;
end.
