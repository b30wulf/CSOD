unit knsl1tcp;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,
    knsl1cport,utlmtimer,extctrls,knsl5tracer,WSocket,Winsock,uTMSocket;
type
     TSockState = procedure(Sender: TObject; OldState,NewState: TSocketState) of object;
     TReccData = procedure(Sender: TObject; ErrCode: Word) of object;
     PCSocket =^ CSocket;
     CTcpPort = class;
     CTcpMake = class(TThread)
     private
      m_nTcp       : CTcpPort;
      m_nWaitEvent : THandle;
      m_nConnEvent : THandle;
     destructor Destroy;override;
     public
     protected
      procedure Execute; override;
      procedure ConnectProc;
     public
      property PTcpPort:CTcpPort read m_nTcp write m_nTcp;
     end;



     CTcpPort = class(CPort)
     protected
      m_nEvent  : THandle;
      m_nMake   : CTcpMake;
      m_nSocket : CSocket;
      m_sMsg    : CMessage;
      m_nRepTimer  : CTimer;
      //pb_mBoxDoRead: array[0..10000] of Byte;
      pb_mBoxCont  : array[0..17000] of Byte;
      w_mBoxWrite  : Integer;
      w_mBoxRead   : Integer;
      w_mBoxSize   : Integer;
      w_mBoxCSize  : Integer;
      w_mBoxMesCt  : Integer;
      w_mBoxSEnd   : Integer;
      m_sSize      : Integer;
      m_blState    : Byte;
      m_blIsServer : Boolean;
      procedure MakeMessageL1;override;
      procedure RunTmr;override;
      //procedure SetDynamic(var pL1 : SL1SHTAG);override;
      //procedure SetDefaultSett;override;
     private
      procedure OnDataAvailable(Buffer:PByteArray;Len:Integer);
      procedure OnSessionAvailable(Sender: TObject; Error: Word);
      procedure OnSessionConnected(Sender: TObject; Error : word);
      procedure OnSessionClosed(Sender: TObject; Error: Word);
      procedure OnChangeState(Sender: TObject; OldState,NewState: TMSocketState);
      procedure SetUpBuffer;
      procedure CopyMessage(wLen:Word);
      procedure CopyMessage1(wLen:Word);
      procedure DeleteSock(var wSock:CSocket);
      procedure ResetSocket;
     public
      constructor Create;
      destructor Destroy; override;
      procedure  ConnectProc;
      function  EventHandler(var pMsg:CMessage):boolean;override;
      procedure Init(var pL1:SL1TAG);override;
      procedure SetDynamic(var pL1 : SL1SHTAG);override;
      procedure Close;override;
      function Send(pMsg:Pointer;nLen:Word):Boolean;override;
      function Connect(var pMsg:CMessage):Boolean;override;
      function ReConnect(var pMsg:CMessage):Boolean;override;
      function Disconnect(var pMsg:CMessage):Boolean;override;
      function FreePort(var pMsg:CMessage):Boolean;override;
      function SettPort(var pMsg:CMessage):Boolean;override;
      procedure StopPort;override;
      procedure StartPort;override;

     public
      property PMEvent:THandle read m_nEvent write m_nEvent;
      //m_nSocket
     End;
     PCTcpPort =^ CTcpPort;
implementation
const
     BSZ = $1fff;
constructor CTcpPort.Create;
Var
     v : Integer;
Begin
     v := 0;
     m_nEvent := CreateEvent(nil, False, False, nil);
End;
destructor CTcpPort.Destroy;
Begin
     inherited;
     DeleteSock(m_nSocket);
     //DeleteSock(m_nCliSocket);
End;
procedure CTcpPort.StopPort;
Begin
     //m_nSocket.Pause;
     //m_nCliSocket.Pause;
End;
procedure CTcpPort.StartPort;
Begin
     //m_nSocket.Resume;
     //m_nCliSocket.Resume;
End;
function CTcpPort.FreePort(var pMsg:CMessage):Boolean;
Begin
End;
function CTcpPort.SettPort(var pMsg:CMessage):Boolean;
Begin
End;
procedure CTcpPort.DeleteSock(var wSock:CSocket);
Begin
     if wSock<>Nil then
     Begin
      wSock.Destroy;
      wSock:=Nil;
      //TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>Delete Socket:');
     End;
End;
procedure CTcpPort.ResetSocket;
Begin
     DeleteSock(m_nSocket);
     //DeleteSock(m_nCliSocket);
     m_nSocket    := CSocket.Create;
     //m_nCliSocket := CSocket.Create(nil);
End;
procedure CTcpPort.Init(var pL1:SL1TAG);
Begin
     Move(pL1,m_nL1,sizeof(SL1TAG));
     SetUpBuffer;
     DeleteSock(m_nSocket);
     m_nSocket        := CSocket.Create;
     //m_nSocket.BufferSize := 9000;
     //m_nSocket.Buffer     := @pb_mBoxDoRead[0];
     //m_nCliSocket := CSocket.Create(nil);
     m_nRepTimer  := CTimer.Create;
     m_nRepTimer.SetTimer(DIR_L1TOL1, DL_REPMSG_TMR, 0, m_nL1.m_sbyPortID, BOX_L1);
     m_nRepTimer.OnTimer(5);
     m_byIsControl  := pL1.m_sbyControl;
     m_sbyProtoType := pL1.m_sbyProtID;
     if m_nL1.m_sbyType=DEV_TCP_SRV  then Begin m_blIsServer := True;  m_nSocket.Proto := 'tcp';End else
     if m_nL1.m_sbyType=DEV_TCP_CLI  then Begin m_blIsServer := False; m_nSocket.Proto := 'tcp';End else
     if m_nL1.m_sbyType=DEV_UDP_SRV  then Begin m_blIsServer := True;  m_nSocket.Proto := 'udp';End else
     if m_nL1.m_sbyType=DEV_UDP_CLI  then Begin m_blIsServer := False; m_nSocket.Proto := 'udp';End;
     m_nSocket.OnDataAvailable    := OnDataAvailable;
     m_nSocket.OnSessionClosed    := OnSessionClosed;
     m_nSocket.OnSessionConnected := OnSessionConnected;
     m_nSocket.OnChangeState      := OnChangeState;
     m_nSocket.Addr               := m_nL1.m_schIPAddr;
     m_nSocket.Port               := m_nL1.m_swIPPort;
     {
     if m_nL1.m_sbyType=m_nPortTypeList.IndexOf('TCP_SRV') then
     Begin
      m_blIsServer     := True;
      m_nSocket.OnSessionAvailable := OnSessionAvailable;
      m_nCliSocket.OnDataAvailable := OnDataAvailable;
      m_nCliSocket.OnSessionClosed := OnSessionClosed;
      m_nCliSocket.OnChangeState   := OnChangeState;
      m_nSocket.Addr   := m_nL1.m_schIPAddr;//'0.0.0.0';
      m_nSocket.Port   := m_nL1.m_swIPPort;
      m_nSocket.Proto  := 'tcp';
      //m_nSocket.Listen;
     End;
     if m_nL1.m_sbyType=m_nPortTypeList.IndexOf('TCP_CLI') then
     Begin
      m_blIsServer        := False;
      m_nSocket.OnDataAvailable    := OnDataAvailable;
      m_nSocket.OnSessionClosed    := OnSessionClosed;
      m_nSocket.OnSessionConnected := OnSessionConnected;
      m_nSocket.OnChangeState      := OnChangeState;
      m_nSocket.Addr   := m_nL1.m_schIPAddr;
      m_nSocket.Port   := m_nL1.m_swIPPort;
      m_nSocket.Proto  := 'tcp';
      //m_nSocket.Connect;
     End;
     if m_nL1.m_sbyType=m_nPortTypeList.IndexOf('UDP_SRV') then
     Begin
      m_blIsServer     := True;
      m_nSocket.OnSessionAvailable := OnSessionAvailable;
      m_nCliSocket.OnDataAvailable := OnDataAvailable;
      m_nCliSocket.OnSessionClosed := OnSessionClosed;
      m_nCliSocket.OnChangeState   := OnChangeState;
      m_nSocket.Addr   := m_nL1.m_schIPAddr;//'0.0.0.0';
      m_nSocket.Port   := m_nL1.m_swIPPort;
      m_nSocket.Proto  := 'udp';
      //m_nSocket.Listen;
     End;
     if m_nL1.m_sbyType=m_nPortTypeList.IndexOf('UDP_CLI') then
     Begin
      m_blIsServer        := False;
      m_nSocket.OnDataAvailable    := OnDataAvailable;
      m_nSocket.OnSessionClosed    := OnSessionClosed;
      m_nSocket.OnSessionConnected := OnSessionConnected;
      m_nSocket.OnChangeState      := OnChangeState;
      m_nSocket.Addr   := m_nL1.m_schIPAddr;
      m_nSocket.Port   := m_nL1.m_swIPPort;
      m_nSocket.Proto  := 'udp';
      //m_nSocket.Connect;
     End;
     }
     m_blState := 0;
     ResetEvent(m_nEvent);
     m_nMake := CTcpMake.Create(True);
     m_nMake.PTcpPort := self;
     m_nMake.Priority := tpNormal;
     m_nMake.Resume;
End;
procedure CTcpPort.SetDynamic(var pL1 : SL1SHTAG);
Begin
End;
procedure CTcpPort.Close;
Begin
End;
function CTcpPort.Send(pMsg:Pointer;nLen:Word):Boolean;
Var
     res   : Boolean;
     pnMsg : PCMessage;
Begin
     res   := True;
     pnMsg := pMsg;
     try
     m_wCurrMtrType := pnMsg.m_sbyServerID;
     m_wCurrMtrID   := pnMsg.m_swObjID;
     if m_nSocket<>Nil then
     if m_nSocket.State=wsmConnected then m_nSocket.SendM(@pnMsg.m_sbyInfo[0],nLen-11);
     Result := res;
     except
      TraceER('(__)CERMD::>Error In CTcpPort.Send!!!');
      Init(m_nL1);
     end
End;
{
TSocketState          = (wsInvalidState,
                           wsOpened,     wsBound,
                           wsConnecting, wsSocksConnected, wsConnected,
                           wsAccepting,  wsListening,
                           wsClosed);
}
function CTcpPort.Connect(var pMsg:CMessage):Boolean;
Begin
     //ConnectProc;
     //m_blState := 0;
End;
procedure CTcpPort.ConnectProc;
Begin
     try
     if m_blIsServer=False then
     Begin
      if m_nSocket.State<>wsmConnected then
      Begin
       TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>QRY Client Connect Addr:'+m_nL1.m_schIPAddr);
       SetUpBuffer;
       m_nSocket.ConnectM;
      End;
     End;
     if m_blIsServer=True then
     Begin
      if m_nSocket.State<>wsmConnected then
      Begin
       TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>QRY Server Listen Addr:'+m_nL1.m_schIPAddr+' Port:'+m_nL1.m_swIPPort);
       SetUpBuffer;
       m_nSocket.ListenM;
      End;
     End;
     except
      TraceER('(__)CERMD::>Error In CTcpPort.Connect!!!');
      Init(m_nL1);
     End;
End;
function CTcpPort.ReConnect(var pMsg:CMessage):Boolean;
Begin
     Result := True;
End;
function CTcpPort.Disconnect(var pMsg:CMessage):Boolean;
Var
     res : Boolean;
Begin
     res := False;
     SetUpBuffer;
     try
     if m_blIsServer=False then
     if (m_nSocket.State<>wsmClosed) then
     Begin
      m_nSocket.CloseM;
      res := True;
      TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>QRY Disconnect Client');
     End;
     if m_blIsServer=True then
     if (m_nSocket.State<>wsmClosed) then
     Begin
      m_nSocket.CloseM;
      res := True;
      TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>QRY Disconnect Server');
     End;
     Result := res;
     except
      Init(m_nL1);
      TraceER('(__)CERMD::>Error In CTcpPort.Disconnect!!!');
     end
End;
procedure CTcpPort.MakeMessageL1;
Begin
     if m_sSize<>0 then
     Begin
      //TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>MakeMessageL1.');
      if m_byIsControl=0 then CopyMessage(m_sSize);
      if m_byIsControl=1 then CopyMessage1(m_sSize);
     End;
End;
procedure CTcpPort.CopyMessage(wLen:Word);
Var
     i,m_nLen : integer;
Begin
     m_nLen := 0;
     while m_sSize<>0 do
     Begin
      case m_sbyProtoType of
      DEV_UDP_CC301:
                   Move(pb_mBoxCont[w_mBoxRead+2],m_nLen,2);
      DEV_BTI_CLI, DEV_BTI_SRV:
                 begin
                   m_nLen := pb_mBoxCont[w_mBoxRead+3];
                   m_nLen := m_nLen or ((pb_mBoxCont[w_mBoxRead+2]) shl 8);
                 end;
      end;
      if (m_nLen>3000)or(m_nLen=0) then
      Begin
        SetUpBuffer;exit;
      End;
      if wLen>9000 then
      Begin
        SetUpBuffer;exit;
      End;
      with m_sMsg do begin
      for i:=0 to m_nLen-1 do
      Begin
       m_sbyInfo[i]:=pb_mBoxCont[w_mBoxRead];
       Inc(w_mBoxSize);
       w_mBoxRead:=(w_mBoxRead+1)and BSZ;
      End;
      m_sSize := (w_mBoxCSize-w_mBoxSize) and BSZ;
      if m_sSize<0 then
      Begin
      SetUpBuffer;exit;
      End;

      m_swLen        := 11+i;
      m_sbyFrom      := DIR_L1TOL2;
      m_sbyFor       := DIR_L1TOL2;
      m_sbyTypeIntID := 0;
      m_sbyDirID     := 0;
      m_sbyIntID     := m_nL1.m_sbyPortID;
      m_swObjID      := m_wCurrMtrID;
      m_sbyServerID  := 0;
      m_sbyType      := PH_DATA_IND;
     End;
     case m_sbyProtoType of
      //DEV_MASTER : FPUT(BOX_L2,@m_sMsg);
      DEV_UDP_CC301:
                   Begin
                    m_sMsg.m_swObjID := m_sIsTranzOpen.m_swObjID; //!!!!!!Тестовая хня!!!!! Нужно сделать поиск обйекта!!!!!!!!
                    m_sMsg.m_sbyFor  := DIR_L4TOAR;
                    FPUT(BOX_L4,@m_sMsg);
                   End;
      DEV_BTI_CLI: Begin
                    m_sMsg.m_sbyFor := DIR_ARTOL4;
                    FPUT(BOX_L4,@m_sMsg);
                   End;
      DEV_BTI_SRV: Begin
                    m_sMsg.m_sbyFor := DIR_L1TOBTI;
                    FPUT(BOX_L2,@m_sMsg);
                   End;
     End;
     End;//While
End;
{
procedure TComPort.CopyMessage(wLen:Word);
Var
   i:Integer;
   byCRC,byLen:Byte;
   blCRC : Boolean;
Begin
   //TraceL(1,0,IntToHex(m_sSize,2));
   if wLen>200 then Begin SetUpBuffer;exit;End;
   with m_sMsg do begin
   for i:=0 to wLen-1 do
   Begin
    m_sbyInfo[i]:=pb_mBoxCont[w_mBoxRead];
    Inc(w_mBoxSize);
    w_mBoxRead:=(w_mBoxRead+1)and BSZ;
   End;
   m_sSize := (w_mBoxCSize-w_mBoxSize) and BSZ;
   m_swLen        := 11+i;
   m_sbyFrom      := DIR_L1TOL2;
   m_sbyFor       := DIR_L1TOL2;
   m_sbyTypeIntID := 0;
   m_sbyDirID     := 0;
   m_sbyIntID     := m_swPID;
   m_swObjID      := m_wCurrMtrID;
   m_sbyServerID  := m_wCurrMtrType;
   m_sbyType      := PH_DATA_IND;
   End;
   case m_sbyProtoType of
    DEV_MASTER : FPUT(BOX_L2,@m_sMsg);
    DEV_BTI_CLI: Begin
                  m_sMsg.m_sbyFor := DIR_ARTOL4;
                  FPUT(BOX_L4,@m_sMsg);
                 End;
    DEV_BTI_SRV: Begin
                  m_sMsg.m_sbyFor := DIR_L1TOBTI;
                  FPUT(BOX_L2,@m_sMsg);
                 End;
   End;
End;
}
procedure CTcpPort.CopyMessage1(wLen:Word);
Var
     i,m_nLen : Integer;
Begin
     m_nLen := 0;
     if wLen>9000 then Begin SetUpBuffer;exit; End;

     while m_sSize<>0 do
     Begin
      Move(pb_mBoxCont[w_mBoxRead],m_nLen,2);
      if (m_nLen>800)or(m_nLen=0) then Begin SetUpBuffer;exit;End;
      for i:=0 to m_nLen-1 do
      Begin
       m_sMsg.m_sbyInfo[i]:=pb_mBoxCont[w_mBoxRead];
       Inc(w_mBoxSize);
       w_mBoxRead:=(w_mBoxRead+1)and BSZ;
      End;
      m_sSize := (w_mBoxCSize-w_mBoxSize) and BSZ;
      if m_sSize<0 then Begin SetUpBuffer;exit;End;
      m_sMsg.m_swLen        := 11+i;
      m_sMsg.m_sbyFrom      := DIR_LLTOLM3;
      m_sMsg.m_sbyFor       := DIR_LLTOLM3;
      m_sMsg.m_sbyTypeIntID := 0;
      m_sMsg.m_sbyDirID     := 0;
      m_sMsg.m_sbyIntID     := m_nL1.m_sbyPortID;
      m_sMsg.m_swObjID      := 0;
      m_sMsg.m_sbyServerID  := 0;
      m_sMsg.m_sbyType      := PH_DATA_IND;
      FPUT(BOX_L3_LME,@m_sMsg)
     End;

End;
function CTcpPort.EventHandler(var pMsg:CMessage):boolean;
Begin
     if pMsg.m_sbyType=DL_REPMSG_TMR then
     Begin
      Connect(pMsg);
      //m_blState := 0;
      m_nRepTimer.OnTimer(5);
     End;
End;
procedure CTcpPort.SetUpBuffer;
Begin
     w_mBoxSize  := BSZ;
     w_mBoxCSize := BSZ;
     w_mBoxWrite := 0;
     w_mBoxRead  := 0;
     w_mBoxMesCt := 0;
     m_sSize     := 0;
End;
procedure CTcpPort.RunTmr;
Begin
     m_nRepTimer.RunTimer;
End;
procedure CTcpPort.OnDataAvailable(Buffer:PByteArray;Len:Integer);
var
     i : Integer;
begin
     try
     for i:=0 to Len-1 do
     Begin
      pb_mBoxCont[w_mBoxWrite]:=Buffer[i];
      w_mBoxWrite := (w_mBoxWrite + 1) and BSZ;
      //TraceL(1,0,IntToHex(pb_mBoxDoRead[i],2));
      //TraceL(0,0,Char(pb_mBoxDoRead[i])+'-'+IntToHex(pb_mBoxDoRead[i],2));
     End;
     w_mBoxSize  := w_mBoxSize   - Len;
     m_sSize     := w_mBoxCSize  - w_mBoxSize;
     MakeMessageL1;
     {
     WS := Sender as CSocket;
     w_lLength := WS.RcvdCount;
     if (w_lLength<=0)or(w_lLength>9000)then
     Begin
      WS.ReceiveM(@pb_mBoxDoRead, w_lLength);
      SetUpBuffer;
      exit;
     End;
     WS.Receive(@pb_mBoxDoRead, w_lLength);
     for i:=0 to w_lLength-1 do
     Begin
      pb_mBoxCont[w_mBoxWrite]:=pb_mBoxDoRead[i];
      w_mBoxWrite := (w_mBoxWrite + 1) and BSZ;
      //TraceL(1,0,IntToHex(pb_mBoxDoRead[i],2));
      //TraceL(0,0,Char(pb_mBoxDoRead[i])+'-'+IntToHex(pb_mBoxDoRead[i],2));
     End;
     w_mBoxSize  := w_mBoxSize   - w_lLength;
     m_sSize     := w_mBoxCSize  - w_mBoxSize;
     //SetEvent(m_nEvent);
     MakeMessageL1;
     }
     except
      Init(m_nL1);
      TraceER('(__)CERMD::>Error In CTcpPort.OnDataAvailable!!!');
     end;
end;
procedure CTcpPort.OnChangeState(Sender: TObject; OldState,NewState: TMSocketState);
Begin
      SetUpBuffer;
      try
      case NewState of
       //wsmListening: TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>Server Listening...');
       //wsmAccepting: TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>Server Accepting...');
       wsmConnected:
       begin
        SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_CONN_IND);
        TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>Connect.');
        m_blState := 1;
       end;
       wsmClosed:
       begin
        m_nSocket.CloseM;
        SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_DISC_IND);
        TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>Closed.');
        m_blState := 0;
        SetEvent(m_nEvent);
       end;
      end;
      SetUpBuffer;
      except
       Init(m_nL1);
       TraceER('(__)CERMD::>Error In CTcpPort.OnChangeState!!!');
      end
End;
procedure CTcpPort.OnSessionAvailable(Sender: TObject; Error: Word);
{var      NewHSocket : TSocket;      PeerName : TSockAddrIn;      Peer : String;}begin      {      SetUpBuffer;      m_blState := 1;      NewHSocket := m_nSocket.Accept;      m_nCliSocket.Dup(NewHSocket);      m_nCliSocket.GetPeerName(PeerName, Sizeof(PeerName));      Peer := IntToStr(ord(PeerName.sin_addr.S_un_b.s_b1)) + '.' +       IntToStr(ord(PeerName.sin_addr.S_un_b.s_b2)) + '.' +       IntToStr(ord(PeerName.sin_addr.S_un_b.s_b3)) + '.' +       IntToStr(ord(PeerName.sin_addr.S_un_b.s_b4));      TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>OnSessionAvailable Addr:'+Peer);      }end;procedure CTcpPort.OnSessionClosed(Sender: TObject; Error: Word);
Begin
     m_blState := 0;
     //TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>OnSessionClosed.');
     //SetEvent(m_nEvent);
End;
procedure CTcpPort.OnSessionConnected(Sender: TObject; Error : word);
Begin
     m_blState := 1;
     //TraceL(1,m_nL1.m_sbyPortID,'(__)CTCMD::>OnSessionConnected.');
End;
procedure CTcpMake.Execute;
Begin
     m_nWaitEvent := CreateEvent(nil, False, False, nil);
     m_nConnEvent := CreateEvent(nil, False, False, nil);
     while not terminated do
     Begin
      if PTcpPort.m_blState=1 then Begin PTcpPort.m_nSocket.ReceiveProc;{WaitForSingleObject(m_nConnEvent,10);} End else
      if PTcpPort.m_blState=0 then ConnectProc;
      //if PTcpPort.m_blState=1 then PTcpPort.m_nSocket.ReceiveProc else
      //if PTcpPort.m_blState=0 then WaitForSingleObject(m_nConnEvent,100);
     End;
End;
procedure CTcpMake.ConnectProc;
Begin
     //Synchronize(PTcpPort.ConnectProc);
     PTcpPort.ConnectProc;
     WaitForSingleObject(m_nConnEvent,5000);
End;
destructor CTcpMake.Destroy;
Begin

End;
end.
