unit knsl4automodule;

interface
uses
Windows, Classes,knsl5config, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer;
type
    CHIAutomat = class
    protected
     m_swAddres     : Word;
     m_sbyPortTypeID: Byte;
     m_sbyPortID    : Byte;
     m_sbyRepMsg    : Byte;
     m_sbyRepTime   : Byte;
     m_sbyBoxID     : Byte;
     m_schPhone     : String;

     m_nRepTimer    : CTimer;
     m_nTranzTimer  : CTimer;
     m_nTrOpenTimer : CTimer;
     m_nWatchTimer  : CTimer;
     function SelfHandler(var pMsg:CMessage):Boolean;virtual; abstract;
     function LoHandler(var pMsg:CMessage):Boolean;virtual; abstract;
     function HiHandler(var pMsg:CMessage):Boolean;virtual; abstract;
     procedure PauseSystem;
     procedure OpenSystem;
    public
     m_sbyID        : Byte;
     procedure Init(var pTable:SL1TAG);
     procedure InitAuto(var pTable:SL1TAG);virtual; abstract;
     procedure SetBox(byBox:Integer);
     //function EventHandler(var pMsg : CMessage):Boolean;virtual;abstract;
     function EventHandler(var pMsg:CMessage):Boolean;
     function SelfBaseHandler(var pMsg:CMessage):Boolean;
     function LoBaseHandler(var pMsg:CMessage):Boolean;
     function HiBaseHandler(var pMsg:CMessage):Boolean;
     procedure Run;
     procedure RunAuto;virtual; abstract;
    End;
    PCHIAutomat =^ CHIAutomat;
implementation
procedure CHIAutomat.Init(var pTable:SL1TAG);
Begin
     m_swAddres     := pTable.m_sbyPortNum;
     m_schPhone     := pTable.m_schPhone;
     m_sbyPortTypeID:= pTable.m_sbyType;
     if pTable.m_sblReaddres=0 then
       m_sbyPortID    := pTable.m_sbyPortID
     else
     m_sbyPortID    := pTable.m_swAddres;
     m_sbyRepMsg    := 10;
     m_sbyRepTime   := 7;
     if m_nRepTimer=Nil then m_nRepTimer    := CTimer.Create;
     if m_nTranzTimer=Nil then m_nTranzTimer  := CTimer.Create;
     if m_nTrOpenTimer=Nil then m_nTrOpenTimer := CTimer.Create;
     if m_nWatchTimer=Nil then m_nWatchTimer := CTimer.Create;
  //   if m_sbyID = 0 then
  //     m_nRepTimer.SetTimer(DIR_L4TOL4,AL_REPMSG_TMR,0,0,m_sbyBoxID)
  //   else
     m_nRepTimer.SetTimer(DIR_L4TOL4,AL_REPMSG_TMR,0,m_sbyID,BOX_L4);
     m_nTranzTimer.SetTimer(DIR_L4TOL4,AL_TRANZTIM_IND,0,m_sbyID,BOX_L4);
     m_nTrOpenTimer.SetTimer(DIR_L4TOL4,AL_TROPEN_TMR,0,m_sbyID,BOX_L4);
     m_nWatchTimer.SetTimer(DIR_L4TOL4,AL_WATCH_TMR,0,m_sbyID,BOX_L4);
     SendPData(BOX_L1,m_swAddres,m_sbyPortID,DIR_BTITOL1,PH_DATARD_REQ,1,@m_swAddres);
     InitAuto(pTable);
End;
procedure CHIAutomat.SetBox(byBox:Integer);
Begin
    m_sbyBoxID := byBox;
End;
function CHIAutomat.EventHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    case pMsg.m_sbyFor of
     DIR_L1TOL2,DIR_ARTOL4  : res := LoBaseHandler(pMsg);
     DIR_L4TOL4             : res := SelfBaseHandler(pMsg);
     DIR_L4TOAR, DIR_LMETOL4,DIR_L1TOL4: res := HiBaseHandler(pMsg);
    End;
    Result := res;;
End;
function CHIAutomat.SelfBaseHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
                         
    SelfHandler(pMsg);
    Result := res;
End;
function CHIAutomat.LoBaseHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;

    LoHandler(pMsg);
    Result := res;
End;
function CHIAutomat.HiBaseHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;

    HiHandler(pMsg);
    Result := res;
End;
procedure CHIAutomat.PauseSystem;
Begin
     m_nPauseCM := True;
     m_nWatchTimer.OnTimer(30);
     m_nCF.SchedPause;
     SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ);
     //TraceL(4,m_sbyPortID, '(__)L4MDL PORT:'+IntToStr(m_sbyPortID)+' PauseSystem!');
End;
procedure CHIAutomat.OpenSystem;
Begin
     m_nPauseCM := False;
     m_nCF.SchedGo;
     SendMSG(BOX_L4,0,DIR_L1TOL4,QL_START_TRANS_REQ);
     //TraceL(4,m_sbyPortID, '(__)L4MDL PORT:'+IntToStr(m_sbyPortID)+' OpenSystem!');
End;
procedure CHIAutomat.Run;
Begin
    if m_nRepTimer <> nil then
      m_nRepTimer.RunTimer;
    if m_nTranzTimer <> nil then
      m_nTranzTimer.RunTimer;
    if m_nTrOpenTimer <> nil then
      m_nTrOpenTimer.RunTimer;
    if m_nWatchTimer <> nil then
      m_nWatchTimer.RunTimer;
    RunAuto;
End;
end.
