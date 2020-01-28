unit uTMSocket;
interface
uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,winsock2;
type
    TMSocketState          = (wsmInvalidState,
                           wsmOpened,     wsmBound,
                           wsmConnecting, wsmSocksConnected, wsmConnected,
                           wsmAccepting,  wsmListening,
                           wsmClosed);
    TMDataAvailable        = procedure (Buffer:PByteArray; Len:Integer) of object;
    TMDataSent             = procedure (Sender: TObject; ErrCode: Word) of object;
    TMSendData             = procedure (Sender: TObject; BytesSent: Integer) of object;
    TMSessionClosed        = procedure (Sender: TObject; ErrCode: Word) of object;
    TMSessionAvailable     = procedure (Sender: TObject; ErrCode: Word) of object;
    TMSessionConnected     = procedure (Sender: TObject; ErrCode: Word) of object;
    TMDnsLookupDone        = procedure (Sender: TObject; ErrCode: Word) of object;
    TMChangeState          = procedure (Sender: TObject;OldState, NewState : TMSocketState) of object;

    CSocket = class
     private
      FOnSessionAvailable : TMSessionAvailable;
      FOnSessionConnected : TMSessionConnected;
      FOnSessionClosed    : TMSessionClosed;
      FOnChangeState      : TMChangeState;
      FOnDataAvailable    : TMDataAvailable;
      FOnDataSent         : TMDataSent;
      FOnSendData         : TMSendData;
      FAddr               : String;
      FPort               : String;
      FProto              : String;
      FRcvdCount          : Integer;
      FState              : TMSocketState;
      FOldState           : TMSocketState;
      m_nSocket           : TSocket;
      m_nSocketCli        : TSocket;
      m_nSockAddr         : TSockAddr;
      FBufferSize         : Integer;
      FBuffer             : Pointer;
      pb_mBoxDoRead       : array[0..10000] of Char;
      wfds                : Tfdset;
      tv                  : Ttimeval;
      on_sock             : Dword;
      off_sock            : Dword;
      inf                 : TWSADATA;
      sockaddr            : TSockAddr;
      Server              : TInaddr;
     private
      procedure ChandgeState(nNewState : TMSocketState);
      procedure ErrorRoutine;
      procedure CloseAll(var nSocket:TSocket);
     public
      constructor Create;
      destructor  Destroy;
      procedure Init;
      procedure ReceiveProc;
      function SendM(Data : PByteArray; Len : Integer) : integer;
      procedure ConnectM;
      procedure ListenM;
      procedure CloseM;
     public
      property OnDataAvailable    : TMDataAvailable    read  FOnDataAvailable    write FOnDataAvailable;
      property OnDataSent         : TMDataSent         read  FOnDataSent         write FOnDataSent;
      property OnSendData         : TMSendData         read  FOnSendData         write FOnSendData;
      property OnSessionClosed    : TMSessionClosed    read  FOnSessionClosed    write FOnSessionClosed;
      property OnSessionAvailable : TMSessionAvailable read  FOnSessionAvailable write FOnSessionAvailable;
      property OnSessionConnected : TMSessionConnected read  FOnSessionConnected write FOnSessionConnected;
      property OnChangeState      : TMChangeState      read  FOnChangeState      write FOnChangeState;
      property Addr               : String             read  FAddr               write FAddr;
      property Port               : String             read  FPort               write FPort;
      property Proto              : String             read  FProto              write FProto;
      property RcvdCount          : Integer            read  FRcvdCount          write FRcvdCount;
      property State              : TMSocketState      read  FState              write FState;
      property BufferSize         : Integer            read  FBufferSize         write FBufferSize;
      property Buffer             : Pointer            read  FBuffer             write FBuffer;
    End;

implementation
constructor CSocket.Create;
Begin
     FState       := wsmClosed;
     FOldState    := wsmClosed;
     FBufferSize  := 9000;
     on_sock      := 1;
     off_sock     := 0;
     m_nSocketCli := 0;
     m_nSocket    := 0;
End;
destructor  CSocket.Destroy;
Begin
     CloseM;
End;
procedure CSocket.Init;
Begin
     FState    := wsmClosed;
     FOldState := wsmClosed;
End;
procedure CSocket.ReceiveProc;
Var
     res : Integer;
Begin
     //if FState=wsmConnected then
     Begin
     res := recv(m_nSocket,pb_mBoxDoRead,FBufferSize,0);
     if res=SOCKET_ERROR then ErrorRoutine else
     if res=0 then ChandgeState(wsmClosed) else
     if res>0 then
      Begin
       FRcvdCount := res;
       if Assigned(OnDataAvailable) then OnDataAvailable(@pb_mBoxDoRead,res);
      End;
     End;
End;
function CSocket.SendM(Data : PByteArray; Len : Integer) : integer;
Var
     res   : Integer;
     //nSend : array[0..1000] of Char;
Begin
     res := -1;
     if FState=wsmConnected then
     Begin
      //Move(Data^,nSend,Len);
      //res := send(m_nSocket,nSend,Len,0);
      res := send(m_nSocket,Data^,Len,0);
     End;
     Result := res;
End;
procedure CSocket.ConnectM;
begin
     case FState of
     wsmClosed:
     Begin
        //if m_nSocket<>0 then Begin CloseM;exit; End;
        FillChar(m_nSockAddr,sizeof(m_nSockAddr),0);
        if FAddr='' then exit;
        Server.s_addr:=inet_addr(PChar(FAddr));
        WSAStartup(MAKEWORD(2,0),inf);
        if FPort='' then exit;
        if FProto='tcp' then m_nSocket := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP) else
        if FProto='udp' then m_nSocket := socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
        ioctlsocket(m_nSocket,FIONBIO,off_sock);
        m_nSockAddr.sin_family := AF_INET;
        m_nSockAddr.sin_port   := htons(StrToInt(FPort));
        m_nSockAddr.sin_addr   := Server;
        //Sleep(1000);
        if connect(m_nSocket,@m_nSockAddr,sizeof(m_nSockAddr))<>-1 then        // Если подключение прошло успешно то...
        Begin
         ChandgeState(wsmConnected);
         ioctlsocket(m_nSocket,FIONBIO,off_sock);
        End;// else Begin CloseM;End;
     End;
     End;
end;
procedure CSocket.ListenM;
Var
     szSockAddr,i,res : Integer;
     on1 : Byte;
begin
     case FState of
     wsmClosed:
     Begin
        //if (m_nSocket=0)and(m_nSocketCli=0) then
        //Begin
        FillChar(m_nSockAddr,sizeof(m_nSockAddr),0);
        WSAStartup(MAKEWORD(2,0),inf);
        if FPort='' then exit;
        if FProto='tcp' then m_nSocketCli := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP) else
        if FProto='udp' then m_nSocketCli := socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
        on1 := 1;
        //if setsockopt( m_nSocketCli, SOL_SOCKET, SO_LINGER, @on1,sizeof(on1))<>0 then
        res := 1;
        m_nSockAddr.sin_family      := AF_INET;
        m_nSockAddr.sin_port        := htons(StrToInt(FPort));
        m_nSockAddr.sin_addr.S_addr := htonl(INADDR_ANY);
        ioctlsocket(m_nSocketCli,FIONBIO,on_sock);
        if bind(m_nSocketCli,@m_nSockAddr,16)<>0 then
        res := 1;
        ChandgeState(wsmListening);
        if listen(m_nSocketCli,3)<>0 then
        res := 1;
        ChandgeState(wsmAccepting);
        //End else CloseM;
     End;
     wsmAccepting:
     Begin
        if bind(m_nSocketCli,@m_nSockAddr,16)=0 then
        szSockAddr:=sizeof(m_nSockAddr) else
        Begin
         res := WSAGetLastError;
         szSockAddr := res;
        End;


        szSockAddr:=sizeof(m_nSockAddr);
        listen(m_nSocketCli,3);
        m_nSocket := accept(m_nSocketCli,m_nSockAddr,szSockAddr);
        if m_nSocket<>INVALID_SOCKET then
        Begin

         ChandgeState(wsmConnected);
         ioctlsocket(m_nSocket,FIONBIO,off_sock);
        End else// else Begin m_nSocket:=0; CloseM;End;
        Begin
         res := WSAGetLastError;
         if res=10022 then
           if listen(m_nSocketCli,3)=0 then
             res:=res+1 else
             Begin
                res := WSAGetLastError;
                FState := wsmClosed;
                CloseAll(m_nSocketCli);
                i := res;
             End;
         //szSockAddr := res;
        End;
     End;
     End;
end;
{
WSANOTINITIALISED	A successful WSAStartup must occur before using this FUNCTION.
WSAENETDOWN	The network subsystem has failed.
WSAEFAULT	The addrlen argument is too small or addr is not a valid part of the user address space.
WSAEINTR	The (blocking) call was canceled through WSACancelBlockingCall.
WSAEINPROGRESS	A blocking Windows Sockets 1.1 call is in progress, or the service provider is still processing a callback function.
WSAEINVAL	listen was not invoked prior to accept.
WSAEMFILE	The queue is nonempty upon entry to accept and there are no descriptors available.
WSAENOBUFS	No buffer space is available.
WSAENOTSOCK	The descriptor is not a socket.
WSAEOPNOTSUPP	The referenced socket is not a type that supports connection-oriented service.
WSAEWOULDBLOCK
}
procedure CSocket.CloseM;
Begin
     //ChandgeState(wsmClosed);
     FState := wsmClosed;
     CloseAll(m_nSocketCli);
     CloseAll(m_nSocket);
End;
procedure CSocket.CloseAll(var nSocket:TSocket);
Begin
     //ChandgeState(wsmClosed);
     if nSocket<>0 then
     Begin
      ioctlsocket(nSocket,FIONBIO,off_sock);
      //shutdown(nSocket, SD_RECEIVE);
      //shutdown(nSocket, SD_SEND);
      shutdown(nSocket, 1);
      //Begin
       closesocket(nSocket);
       nSocket := 0;
      //End;
     End;
End;
procedure CSocket.ChandgeState(nNewState : TMSocketState);
Begin
     FState    := nNewState;
     if Assigned(OnChangeState) then OnChangeState(self,FOldState,FState);
     FOldState := FState;
End;
procedure CSocket.ErrorRoutine;
Var
     res : Integer;
Begin
     res := WSAGetLastError;
     case res of

      WSANOTINITIALISED,WSAENOTCONN,WSAENETDOWN,
      WSAENETRESET,WSAENOTSOCK,WSAEFAULT,
      {WSAESHUTDOWN,}WSAECONNABORTED,WSAETIMEDOUT,
      WSAECONNRESET,
      WSAEINTR : ChandgeState(wsmClosed);


      //WSAETIMEDOUT,WSAENETRESET	 : ChandgeState(wsmClosed);
     End;
End;
end.
