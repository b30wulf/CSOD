unit knsl4Unloader;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer
,knsl5tracer, utldatabase, AdvProgressBar, AdvOfficeStatusBar, utlTimeDate,knsl3EventBox,
utlThread;
type
    CUnloader = class(CThread)
    private
     m_nState    : Integer;
     m_nPortID   : Integer;
     m_nPortEn   : Boolean;
     m_nLostQry  : Boolean;
     m_strPhone  : String;
     m_nRepTimer : CTimer;
     m_nRepUnld  : CTimer;
     m_nMsg      : CMessage;
     m_nRpMsg    : CMessage;
     m_nRepCtr   : Integer;
     procedure OnHandler;
     procedure OpenPhone(strPhone:String);
     function  SendUNMessage:Boolean;
     procedure RepeatUNMessage;
     procedure UnLoadHandler(var pMsg:CMessage);
     procedure Next;
     procedure CheckState;
     procedure ReadLimitMsg(var pMsg: CMessage);
     procedure Execute; override;
    public
     function  GetState:Integer;
     function  SetState(nNevState:Integer):Integer;
     procedure Init(nPortID:Integer);
     procedure Connect(strPhone:String);
     procedure Disconnect;
     function  Add(var pMsg:CMessage):Integer;
     procedure Clear;
     function  Count:Integer;
     procedure Stop;
     procedure Pause;
     procedure Run;
     procedure StartSend(strPhone:String);
     function  EventHandler(var pMsg:CMessage):Boolean;
     destructor Destroy; override;
    End;
var
    m_nUNL : CUnloader = nil;
const
    MAX_DIAL_TIME = 40;
    MAX_REP_TIME  = 10;
    MAX_REP_COUNT = 5;
implementation

procedure CUnloader.OnHandler;
Begin
     EventHandler(m_nMsg);
End;

destructor CUnloader.Destroy;
begin
  Suspend;
  if m_nRepTimer<>Nil then FreeAndNil(m_nRepTimer);
  if m_nRepUnld<>Nil then FreeAndNil(m_nRepUnld);
  inherited;
end;

procedure CUnloader.Execute;
Begin
     m_nUNL := self;
     m_nRepTimer := CTimer.Create;
     m_nRepUnld  := CTimer.Create;
     FDEFINE(BOX_UNLD,BOX_UNLD_SZ,False);
     FDEFINE(BOX_UN_LOAD,BOX_UNLOAD_SZ,True);
     while not Terminated do
     Begin
      FGET(BOX_UN_LOAD,@m_nMsg);
      Synchronize(OnHandler);
     End;
End;

procedure CUnloader.ReadLimitMsg(var pMsg: CMessage);
var str : string;
begin
   SetLength(str, pMsg.m_swLen - 11);
   move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen - 11);
   EventBox.FixEvents(ET_CRITICAL, str);
   //SoundBox.Play;
end;

procedure CUnloader.Init(nPortID:Integer);
Begin
    m_nUNL      := self;
    m_nRepCtr   := MAX_REP_COUNT;
    m_nPortID   := nPortID;
    m_nPortEn   := True;
    m_strPhone  := '6885271';
    m_nLostQry  := False;
    m_nState    := UNL_DISC_STATE;
    m_nRepTimer := CTimer.Create;
    m_nRepTimer.SetTimer(DIR_ULTOUL,UNL_DIAL_TM,0,0,BOX_UN_LOAD);
    m_nRepUnld  := CTimer.Create;
    m_nRepUnld.SetTimer(DIR_ULTOUL,UNL_REP_TM,0,0,BOX_UN_LOAD);
    Priority    := tpNormal;
    Resume;
End;
procedure CUnloader.OpenPhone(strPhone:String);
Var
    pDS  : CMessageData;
    nLen : Integer;
    i    : Integer;
Begin
    nLen := Length(strPhone)+1;
    pDS.m_swData0 := nLen-1;
    pDS.m_swData1 := MAX_DIAL_TIME;
    if nLen<50 then
    Begin
     for i:=0 to nLen-1 do pDS.m_sbyInfo[i] := Byte(strPhone[i+1]);
     pDS.m_sbyInfo[nLen] := Byte(#0);
     SendMsgIData(BOX_L1,0,m_nPortID,DIR_L2TOL1,PH_CONN_IND,pDS);
    End;
    m_nRepTimer.OffTimer;
End;
procedure CUnloader.StartSend(strPhone:String);
Begin
    m_strPhone := strPhone;
    Next;
    //SendUNMessage;
End;
procedure CUnloader.Connect(strPhone:String);
Begin
    //SendPMSG(BOX_UN_LOAD,m_nPortID,DIR_ULTOUL,UNL_DIAL_CONN);
End;
procedure CUnloader.Disconnect;
Begin
    //SendPMSG(BOX_UN_LOAD,m_nPortID,DIR_ULTOUL,UNL_DIAL_DISC);
End;
function CUnloader.GetState:Integer;
Begin
    Result := m_nState;
End;
function CUnloader.SetState(nNevState:Integer):Integer;
Begin
    m_nState := nNevState;
    Result   := m_nState;
end;
function CUnloader.Add(var pMsg:CMessage):Integer;
Begin
    FPUT(BOX_UNLD,@pMsg);
    Result := FCHECK(BOX_UNLD);
End;
procedure CUnloader.Clear;
Begin
    FFREE(BOX_UNLD);
End;
function  CUnloader.Count:Integer;
Begin
    Result := FCHECK(BOX_UNLD);
End;
procedure CUnloader.Next;
Begin
    SendPMSG(BOX_UN_LOAD,m_nPortID,DIR_ULTOUL,UNL_GET_MSG);
End;
function CUnloader.SendUNMessage:Boolean;
Var
    pMsg,plMsg : CMessage;
    nLen : Integer;
Begin
    Result := False;
    if Count<>0 then
    Begin
     FGET(BOX_UNLD,@pMsg);
     Move(pMsg,plMsg.m_sbyInfo[6],pMsg.m_swLen);
     nLen := pMsg.m_swLen+6;
     CreateMsgCrcRem(plMsg.m_sbyInfo[0],nLen+4, $FF0A);
     CreateMSGHeadCrcL(m_nPortID,plMsg,nLen+4);
     //m_nTxMsg.m_sbyInfo[2] := (len and $FF00) shr 8;
     //m_nTxMsg.m_sbyInfo[3] := len and $00FF;
     //if not CRCRem(plMsg.m_sbyInfo[0], (Word(plMsg.m_sbyInfo[2]) shl 8)or(Word(plMsg.m_sbyInfo[3])) - 2) then
     //begin
     // TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
     // exit;
     //end;
     FPUT(BOX_L1,@plMsg);
     Move(plMsg,m_nRpMsg,plMsg.m_swLen);
     Result := True;
    End;
    //SendUNMessage;
End;
procedure CUnloader.CheckState;
Begin
    if((m_nPortEn=True)and(m_nLostQry=True)and(GetState=UNL_DISC_STATE))then
    Next;
End;
procedure CUnloader.RepeatUNMessage;
Begin
    FPUT(BOX_L1,@m_nRpMsg);
End;
procedure CUnloader.Stop;
Begin
    Clear;
    m_nRepTimer.OffTimer;
    if GetState<>UNL_DISC_STATE then
    Begin
     if GetState=UNL_CONN_STATE then SendPMSG(BOX_UN_LOAD,m_nPortID,DIR_ULTOUL,UNL_DISC) else
     if GetState=UNL_CONN_STATE then SetState(UNL_DISC_STATE);
    End;
end;
procedure CUnloader.Pause;
Begin
    SetState(UNL_CONN_PAUSE_STATE);
end;
{
  UNL_DIAL_TM                  = 0;
  UNL_REP_TM                   = 1;
  UNL_GET_MSG
           = 2;
  UNL_DATA                     = 3;
  UNL_GO_SEND                  = 4;
}
function CUnloader.EventHandler(var pMsg:CMessage):Boolean;
Var
    plMsg : CMessage;
Begin
     if pMsg.m_sbyType=UNL_CLER then Begin Clear;SetState(UNL_DISC_STATE);End;
     case GetState of
      UNL_DISC_STATE:
      Begin
        case pMsg.m_sbyType of
             UNL_GET_MSG:
             Begin
              if (Count<>0) then
              Begin
               if m_nPortEn<>True then Begin m_nLostQry:=True;exit;End else m_nLostQry:=False;
               if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������ ���������� ��� ��������');
               OpenPhone(m_strPhone);
               m_nRepTimer.OnTimer(MAX_DIAL_TIME);
               SetState(UNL_WAIT_CONN_STATE);
              End;
             End;
             UNL_REM_DATA:
             Begin
              Move(pMsg.m_sbyInfo[0],plMsg,pMsg.m_swLen-11);
              UnLoadHandler(plMsg);
             End;
             UNL_DIAL_CONN:
             Begin
              m_nPortEn := False;
             End;
             UNL_DIAL_DISC:
             Begin
              m_nPortEn := True;
             End;
        End;
      End;
      UNL_WAIT_CONN_STATE:
      Begin
        case pMsg.m_sbyType of
             UNL_DIAL_TM:
             Begin
              if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'����� ������� ���������!');
              SetState(UNL_WAIT_CONN_STATE);
             End;
             UNL_DIAL_CONN:
             Begin
              if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'����� �����������');
              SetState(UNL_CONN_STATE);
              Next;
             end;
        End;
      End;
      UNL_CONN_STATE:
      Begin
        case pMsg.m_sbyType of
             UNL_GET_MSG, UNL_SEND_ACK:
             Begin
              if SendUNMessage=True then
              Begin
               m_nRepCtr := MAX_REP_COUNT;
               m_nRepUnld.OnTimer(MAX_REP_TIME);
               if pMsg.m_sbyType=UNL_SEND_ACK then if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'C�������� ��������.��������:'+IntTostr(FCHECK(BOX_UNLD))+'.');
              End else
              Begin
               if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'��� ��������� ��������.');
               m_nRepTimer.OnTimer(MAX_DIAL_TIME);
               SendPMSG(BOX_L1,m_nPortID,DIR_L2TOL1,PH_DISC_IND);
               SetState(UNL_WAIT_DISC_STATE);
              End;
             End;
             UNL_REP_TM:
             Begin
              if m_nRepCtr<>0 then
              Begin
               RepeatUNMessage;
               m_nRepCtr := m_nRepCtr - 1;
               m_nRepUnld.OnTimer(MAX_REP_TIME);
               if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'��������� ��������:'+IntToStr(m_nRepCtr));
              End else
              Begin
               m_nRepCtr:=MAX_REP_COUNT;
               Clear;
               if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������ ������������!');
               SendPMSG(BOX_L1,m_nPortID,DIR_L2TOL1,PH_DISC_IND);
               SetState(UNL_WAIT_DISC_STATE);
               if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'��������� ��������!');
              End;
             End;
             UNL_DISC:
             Begin
              Clear;
              if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������ ������������!');
              SendPMSG(BOX_L1,m_nPortID,DIR_L2TOL1,PH_DISC_IND);
              SetState(UNL_WAIT_DISC_STATE);
             End;
        End;
      End;
      UNL_WAIT_DISC_STATE:
      Begin
        case pMsg.m_sbyType of
             UNL_DIAL_TM:
             Begin
              if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'������� ������� ���������� ��������!');
              //SendPMSG(BOX_L1,m_nPortID,DIR_L2TOL1,PH_DISC_IND);
              SetState(UNL_DISC_STATE);
              m_nRepTimer.OffTimer;
              m_nPortEn := True;
             End;
             UNL_DIAL_DISC:
             Begin
              if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'���������� ���������!');
              SetState(UNL_DISC_STATE);
              m_nRepTimer.OffTimer;
              m_nPortEn := True;
             End;
        End;
      End;
      UNL_CONN_PAUSE_STATE:
      Begin
      End;
      UNL_CONN_UNLOD_STATE:
      Begin
      End;
     End;
End;
procedure CUnloader.UnLoadHandler(var pMsg:CMessage);
Begin
     case pMsg.m_sbyFor of
          DIR_L3TOL3:
          Begin
            case pMsg.m_sbyType of
                 DL_DATARD_REQ:
                 Begin
                  TraceM(3,3,'(__)CL2MD::>UNLOD UNMSG:',@pMsg);
                 End;
              DL_LIMIT_IND:
              begin
                ReadLimitMsg(pMsg);
              end;
            End;
          End;
     End;
End;
procedure CUnloader.Run;
Begin
     CheckState;
     if m_nRepTimer<>Nil then m_nRepTimer.RunTimer;
     if m_nRepUnld<>Nil then m_nRepUnld.RunTimer;
end;

initialization

finalization
  if m_nUNL <> nil then FreeAndNil(m_nUNL);

end.
