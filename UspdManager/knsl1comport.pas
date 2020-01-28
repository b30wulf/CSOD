{***************************************************************
 *
 * Unit Name: uComPort
 * Purpose  : Serial port control
 * Author   : ��� "������������� 2000"
 * History  :
 *
 ****************************************************************}

unit knsl1comport;

interface

uses
  Windows, Classes, SysUtils,utlbox,utltypes,utlconst,SyncObjs,inifiles,StdCtrls,
  comctrls,knsl1cport,utlmtimer,extctrls,knsl5tracer{,knsl5config};

type
  {Basic types}
  TStBaudRates = (brManual, br50, br110, br300, br600, br1200, br2400, br4800,
                  br9600, br14400, br19200, br28800, br38400, br56000, br57600,
                  br115200, br128000, br230400, br256000, br460800, br921600);
  TDatabits = (db5, db6, db7, db8);
  TStopbits = (sb1, sb1half, sb2);
  //TParity = (pNone, pOdd, pEven, pMark, pSpace);
  TStDCBFlag = (flBinary, flParity, flOutxCTSFlow, flOutxDSRFlow, flDTRControlEnable,
                 flDTRControlHandshake, flDSRSensivity, flTXContinueOnXoff, flOutX, flInX,
                 flErrorChar, flNil, flRTSControlEnable, flRTSControlHandshake, flAbortOnError);
  TStDCBFlags = Set of TStDCBFlag;
  TStByteSize = (bs_5_Bits, bs_6_Bits, bs_7_Bits, bs_8_Bits);
  TStParity   = (pNone, pOdd, pEven, pMark, pSpace);
  TStStopBits = (sbOne, sbOneHalf, sbTwo);

const
  {Errors}
  BufferFull    = $01;
  BufferEmpty   = $02;
  OutOfRange    = $03;
  LineStatusErr = $04;
  Error         = $05;
  CONN_COUNT    = 2;
  //BaudValues: array[TBaudRate] of Dword = (110, 300, 600, 1200, 2400, 4800, 9600, 14400, 19200, 38400, 57600, 115200);
  //EVENT_MASK = EV_BREAK	or EV_CTS	or EV_DSR or EV_ERR or EV_RING or EV_RLSD or EV_RXCHAR or EV_RXFLAG or EV_TXEMPTY;
  EVENT_MASK = EV_RXCHAR;


type

  TErrorEvent = procedure(Sender : TObject; ErrorCode : Byte) of object;
  //TNotifyReceiveEvent = procedure(DataBuf: array of Byte; Count : DWord;wRD:Word;wWR:Word;wSZ:Word;b0:Byte;b1:Byte) of object;
  TNotifyReceiveEvent = procedure(DataBuf: array of Byte; Count : DWord) of object;
  TComPort = class;

  {Basic thread that's created on opening port. It fulfils continuous reading of port}
  TComThread = class(TThread)
  private
    FComPort: TComPort;
    destructor Destroy;override;
  protected
    procedure Execute; override;
  end;
  TComPort = class(CPort)
  private
    { Public declarations }
    //CriticalSection : TCriticalSection;
    FTimer          : TTimer;
    m_nDiscCtr      : Integer;
    m_sOldPhone     : String;
    m_sNewPhone     : String[50];
    m_nCallTime     : Integer;
    //m_sOldPhone     : String;
    m_blRemConnect  : Boolean;
    m_byModemState  : Byte;
    m_byWaitState   : Byte;
    m_byState       : Word;
    m_byConnCount   : Word;
    m_swSvDelayTime : Word;
    m_byPortType    : Byte;
    m_wCurrMtrType  : Word;
    m_wCurrMtrID    : Word;
    m_nWaitOkTimer  : CTimer;
    m_nConnTimer    : CTimer;
    m_nDiscTimer    : CTimer;
    m_nCallOffTimer    : CTimer;

    m_swDelayTime  : Word;
    m_sbyProtoType : Byte;
    m_swPID     : Word;
    m_sbyBoxID  : Byte;
    m_strNumber : String;
    FOutMonitor : TListView;
    FOnPause    : TCheckBox;
    FEventThread: TComThread;
    //FReadThread : TReadThread;
    FHandle: THandle;
    FPortNum: Byte;

    FBaudRate   : TStBaudRates;
    FManualRate : DWord;
    FDCBFlag    : TStDCBFlags;
    FXonLim     : Word;
    FXoffLim    : Word;
    FByteSize   : TStByteSize;
    FParity     : TStParity;
    FStopBits   : TStStopBits;
    FXonChar    : Char;
    FXoffChar   : Char;
    FErrorChar  : Char;
    FEofChar    : Char;
    FEvtChar    : Char;

    FReadIntervalTimeout         : DWord;
    FReadTotalTimeoutMultiplier  : DWord;
    FReadTotalTimeoutConstant    : DWord;
    FWriteTotalTimeoutMultiplier : DWord;
    FWriteTotalTimeoutConstant   : DWord;


    FActive: Boolean;
    FInBuffer: array of Byte;
    FSndBuffer: array[0..1000] of Byte;
    FData: array[0..1000] of Byte;
    FNextPosToWrite : Word;
    FNextPosToRead : Word;
    FMask: DWORD;
    FHandleEvents: Integer;
    FBufferUsed: Boolean;
    FBufferFull: Boolean;
    FBlTxEmpty : Boolean;
    FRTS: Boolean;
    FDTR: Boolean;
    FDSR: Boolean;
    FCTS: Boolean;
    FRLSD: Boolean;
    FRING: Boolean;
    FRTUInterval: DWORD;
    FOnRTUPacket: TNotifyReceiveEvent;
    FOnOpen : TNotifyEvent;
    FOnClose : TNotifyEvent;
    FOnTxEmpty : TNotifyEvent;
    FOnRing : TNotifyEvent;
    FOnRxFlag : TNotifyEvent;
    FOnError : TErrorEvent;
    FOnChangeCTS: TNotifyEvent;
    FOnChangeDSR: TNotifyEvent;
    FOnChangeRLSD: TNotifyEvent;
    FOnChangeRING: TNotifyEvent;
    FOnBreak: TNotifyEvent;
    FOnReceive: TNotifyReceiveEvent;
    pB:CTBox;
    mCurLen:Word;
    //Buffer Section
    procedure CallRxChar;
    procedure CallTxEmpty;
    procedure CallBreak;
    procedure CallRxFlag;
    procedure CallRing;
    procedure CallModemStatusChange;

    procedure DoRTUPacket;
    procedure DoEvents;
    procedure DoOnError(Error: Byte);
    procedure DoOnByteReceived(Data : Byte);

    function GetInBufferSize: Word;
    function GetBufferUsed : Word;
    procedure SetInBufferSize(Value : Word);
    //procedure SetComPortSettings;
    //procedure GetComPortSettings;
    procedure SetPort(Value : Byte);
    procedure SetFDTR(const Value: Boolean);
    procedure SetFRTS(const Value: Boolean);

    function ImportDCB : TDCB;
    procedure ExportDCB(const PortDCB: TDCB);
    function GetPortDCB(PortHandle: THandle): Boolean;
    function SetPortDCB(PortHandle: THandle): Boolean;



    {
    procedure SetBaudRate(Value : TBaudRate);
    procedure SetManualRate(Value: Integer);
    procedure SetParity(Value : TParity);
    procedure SetDatabits(Value : TDatabits);
    procedure SetStopbits(Value : TStopbits);
    }

    procedure SetBaudRate(const Value: TStBaudRates);
    procedure SetManualRate(const Value: DWord);
    procedure SetDCBFlags(const Value: TStDCBFlags);
    procedure SetByteSize(const Value: TStByteSize);
    procedure SetParity(const Value: TStParity);
    procedure SetStopBits(const Value: TStStopBits);
    procedure AssignTo(Dest: TPersistent); override;

    //procedure AssignTo(Dest: TPersistent); override;
    function ImportCommTimeOuts : TCommTimeOuts;
    procedure ExportCommTimeOuts(const PortTimeOuts: TCommTimeOuts);
    function GetPortTimeOuts(PortHandle: THandle): Boolean;
    function SetPortTimeOuts(PortHandle: THandle): Boolean;


    function  GetRTUInterval: DWORD;
    procedure SetRTUInterval(const Value: DWORD);
    procedure SetActive(const Value: Boolean);
    procedure MakeMessage;
    procedure MakeTextMessage;
    procedure CopyMessage(wLen:Word);
    function  CalckKS(Buffer: PByteArray;wLen: Integer): Byte;
    procedure TextHandler(var pbyText : array of Byte;lLen : Word);
    procedure ATHandler(var pbyText : array of Byte;lLen : Word);
    procedure SendCommand(strCommand : String);
    procedure SendNullCommand(strCommand : String);
    procedure SetUpBuffer;
    procedure SendToL1(byType : Byte);
    procedure SendToL2(byType : Byte);
    //Buffer Sectin
    function SendMesage1:Boolean;
    //Override from CPort
    procedure Close;override;
    function Send(pMsg:Pointer;nLen:Word): Boolean;override;
    procedure Init(var pL1 : SL1TAG);override;
    procedure SetDynamic(var pL1 : SL1SHTAG);override;
    procedure SetDefaultSett;override;
    //procedure SaveDCB;
    //procedure LoadDCB;
    function DiscProc:Boolean;
    function Connect(var pMsg:CMessage):Boolean;override;
    function ReConnect(var pMsg:CMessage):Boolean;override;
    procedure QueryConnect(var pMsg:CMessage);override;
    function Disconnect(var pMsg:CMessage):Boolean;override;
    function FreePort(var pMsg:CMessage):Boolean;override;
    function SettPort(var pMsg:CMessage):Boolean;override;
    function EventHandler(var pMsg:CMessage):boolean;override;

  public
    //Red Buffer Section
     m_svDCB           : TDCB;
     SndBuffer         : array[0..2500] of Byte;
     pb_mBoxDoRead     : array[0..5000] of Byte;
     pb_mBoxDoTextRead : array[0..5000] of Byte;
     pb_mBoxCont       : array[0..17000] of Byte;
     m_sMsg            : CMessage;
     InByteCount_DATA  : Word;
     FoundSTART_DATA   : Word;
     SaveRead          : Word;
     w_nTextLen        : Word;
     SB0,SB1           : byte;
     w_mBoxWrite       : Integer;
     w_mBoxRead        : Integer;
     w_mBoxSize        : Integer;
     w_mBoxCSize       : Integer;
     w_mBoxMesCt       : Integer;
     w_mBoxSEnd        : Integer;
     m_sSize           : Integer;
     m_byMType         : Byte;
    //Red Buffer Section
    procedure Reset;
    procedure RunTmr;override;
    procedure MakeMessageL1;override;
    procedure LoadFromCFG(nPortNum,nSpeed:Integer;strParity,strDataBit,strStopBit:String);
    procedure SendToProc(byLen,byFor,byType,byBox:Byte;pValue:PByteArray);
    procedure FindNumber(strString : String);
    procedure FindStation(strString : String);
    procedure LoadINI(FileName: String);

    constructor Create;
    destructor Destroy; override;
    {Port handle}
    procedure ResetCom;
    property Handle : THandle read FHandle;
    {Clears the input buffer}
    procedure ResetBuffer;
    {Opens serial port. Returns True on success}
    function OpenPort: Boolean;
    {Closes serial port}
    {Number of serial port}
    property PortNum : Byte read FPortNum write SetPort default 1;
     {Shows serial port settigs dialog}
    function PortSettingsDialog(WinHandle : THandle): Boolean;
    {Send byte to serial port. Returns True on success}
    function SendByte(B : Byte) : Boolean;
    {Sends array of bytes to serial port}
    function SendArray(pMsg:Pointer;nLen:Word): Boolean;
    {Sends string to serial port}
    function SendStr(S : String) : Boolean;
    {True if port is open}
//    property IsOpened: Boolean read FIsOpened;
    property Active: Boolean read FActive write SetActive;
    {Size of input buffer}
    property InBufferSize : Word read GetInBufferSize write SetInBufferSize default 4096;
    {Contains current buffer size, that means how many bytes in input buffer}
    property BufferUsed: Word read GetBufferUsed;
    {Port settings}
    {
    property ManualRate:Integer read FManualRate write SetManualRate default 9600;
    property BaudRate : TBaudRate read FBaudrate write SetBaudRate default br9600;
    property Parity : TParity read FParity write SetParity default pNone;
    property Databits : TDatabits read FDatabits write SetDatabits default db8;
    property Stopbits : TStopbits read FStopbits write SetStopbits default sb1;
    }
    property BaudRate    : TStBaudRates read FBaudRate   write SetBaudRate;
    property ManualRate  : DWord        read FManualRate write SetManualRate;
    property DCBFlag     : TStDCBFlags  read FDCBFlag    write SetDCBFlags;
    property XonLim      : Word         read FXonLim     write FXonLim;
    property XoffLim     : Word         read FXoffLim    write FXoffLim;
    property ByteSize    : TStByteSize  read FByteSize   write SetByteSize;
    property Parity      : TStParity    read FParity     write SetParity;
    property StopBits    : TStStopBits  read FStopBits   write SetStopBits;
    property XonChar     : Char         read FXonChar    write FXonChar;
    property XoffChar    : Char         read FXoffChar   write FXoffChar;
    property ErrorChar   : Char         read FErrorChar  write FErrorChar;
    property EofChar     : Char         read FEofChar    write FEofChar;
    property EvtChar     : Char         read FEvtChar    write FEvtChar;

    property ReadIntervalTimeout         : DWord read FReadIntervalTimeout         write FReadIntervalTimeout;
    property ReadTotalTimeoutMultiplier  : DWord read FReadTotalTimeoutMultiplier  write FReadTotalTimeoutMultiplier;
    property ReadTotalTimeoutConstant    : DWord read FReadTotalTimeoutConstant    write FReadTotalTimeoutConstant;
    property WriteTotalTimeoutMultiplier : DWord read FWriteTotalTimeoutMultiplier write FWriteTotalTimeoutMultiplier;
    property WriteTotalTimeoutConstant   : DWord read FWriteTotalTimeoutConstant   write FWriteTotalTimeoutConstant;

    {Reads byte from serial port and removes it from buffer}
    function GetByte : Byte;
    function GetBytes(var OutBuf : array of Byte; Count : Word): Word;
     {Gte byte from the buffer at specified position. That byte remains in buffer}
    function Peekbyte(No: Word): Byte;

   {When True that means to use RTS signal on transmition}
    property RTS : Boolean read FRTS write SetFRTS default False;
   {When True that means to use DTR signal on transmition}
    property DTR : Boolean read FDTR write SetFDTR default False;
    property CTS : Boolean read FCTS;
    property DSR : Boolean read FDSR;
    property RLSD: Boolean read FRLSD;
    { RTU properties }
    property RTUInterval: DWORD read GetRTUInterval write SetRTUInterval;
    property OnRTUPacket: TNotifyReceiveEvent read FOnRTUPacket write FOnRTUPacket;

    { Notifications }
    property OnChangeCTS : TNotifyEvent read FOnChangeCTS write FOnChangeCTS;
    property OnChangeDSR : TNotifyEvent read FOnChangeDSR write FOnChangeDSR;
    property OnChangeRLSD : TNotifyEvent read FOnChangeRLSD write FOnChangeRLSD;
    property OnChangeRING : TNotifyEvent read FOnChangeRING write FOnChangeRING;
    property OnBreak : TNotifyEvent read FOnBreak write FOnBreak;
    property OnTxEmpty : TNotifyEvent read FOnTxEmpty write FOnTxEmpty;
    property OnRxFlag : TNotifyEvent read FOnRxFlag write FOnRxFlag;
    property OnReceive : TNotifyReceiveEvent read FOnReceive write FOnReceive;
    property OnError : TErrorEvent read FOnError write FOnError;
    property OutMonitor   : TListView     read FOutMonitor write FOutMonitor;
    property OnGoTrace    : TCheckBox read FOnPause    write FOnPause;

  end;
  PTComPort =^ TComPort;


implementation
Var
   hRxEvent   : THandle;
   //nPortIndex : Integer;
const
   StBaudRate : Array[TStBaudRates] of DWord =
               (0, 50, CBR_110, CBR_300, CBR_600, CBR_1200, CBR_2400, CBR_4800,
                CBR_9600, CBR_14400, CBR_19200, 28800, CBR_38400, CBR_56000, CBR_57600,
                CBR_115200, CBR_128000, 230400, CBR_256000, 460800, 921600);

   StByteSize : Array[TStByteSize] of Byte = (5, 6, 7, 8);
   StParity   : Array[TStParity]   of Byte = (NOPARITY, ODDPARITY, EVENPARITY, MARKPARITY, SPACEPARITY);
   StStopBits : Array[TStStopBits] of Byte = (ONESTOPBIT, ONE5STOPBITS, TWOSTOPBITS);
   BSZ = $fff;
   WAIT_NUL = 0;
   WAIT_PLS = 1;
   WAIT_ATH = 2;
   WAIT_CON = 3;
   DISC_CTR  = 3;
{ TComPort }
procedure TComPort.CallBreak;
begin
  if assigned(FOnBreak) then FOnBreak(Self);
end;



procedure TComPort.CallModemStatusChange;
var
  b: Boolean;
  w: DWORD;
begin
  GetCommModemStatus(FHandle, w);
  b := (w and MS_CTS_ON) <> 0;
  if FCTS <> b then begin
    FCTS := b;
    if Assigned(FOnChangeCTS) then FOnChangeCTS(Self);
    end;

  b := (w and MS_DSR_ON) <> 0;
  if FDSR <> b then begin
    FDSR := b;
    if Assigned(FOnChangeDSR) then FOnChangeDSR(Self);
    end;

  b := (w and MS_RLSD_ON) <> 0;
  if FRLSD <> b then begin
    FRLSD := b;
    if Assigned(FOnChangeRLSD) then FOnChangeRLSD(Self);
    end;

  b := (w and MS_RING_ON) <> 0;
  if FRING <> b then begin
    FRING := b;
    if Assigned(FOnChangeRING) then FOnChangeRING(Self);
    end;
end;


procedure TComPort.CallRing;
begin
  if Assigned(FOnRing) then FOnRing(Self);
end;

constructor TComPort.Create;
begin
  inherited;

  //CriticalSection:=TCriticalSection.Create;
  FHandle   := INVALID_HANDLE_VALUE;
  FPortNum  := 2;
  FRTS      := False;
  FDTR      := False;
  FActive   := False;

  FBaudRate    := br57600;
  FManualRate  := CBR_57600;
  FDCBFlag     := [flBinary];
  FXonLim      := 2048;
  FXoffLim     := 512;
  FByteSize    := bs_8_Bits;
  FParity      := pEven;
  FStopBits    := sbOne;
  FXonChar     := #17;
  FXoffChar    := #19;
  FErrorChar   := #0;
  FEofChar     := #0;
  FEvtChar     := #0;



  FReadIntervalTimeout         := MaxDWord;
  FReadTotalTimeoutMultiplier  := 0;
  FReadTotalTimeoutConstant    := 0;
  FWriteTotalTimeoutMultiplier := 0;
  FWriteTotalTimeoutConstant   := 0;


  InBufferSize := 4096;
  ResetBuffer;
  FHandleEvents := CreateEvent(nil, True, True, nil);
  FRTUInterval  := INFINITE;
  FBlTxEmpty    := True;
  SetUpBuffer;
  ResetEvent(hRxEvent);

end;
procedure TComPort.SetUpBuffer;
Begin
  w_mBoxSize  := BSZ;
  w_mBoxCSize := BSZ;
  w_mBoxWrite := 0;
  w_mBoxRead  := 0;
  w_mBoxMesCt := 0;
  m_sSize     := 0;
  SaveRead    := 0;
End;
procedure TComPort.ResetCom;
Begin
  w_mBoxSize  := BSZ;
  w_mBoxCSize := BSZ;
  w_mBoxWrite := 0;
  w_mBoxRead  := 0;
  w_mBoxMesCt := 0;
  m_sSize:=0;
  FBlTxEmpty := True;
  ResetEvent(hRxEvent);
End;
destructor TComPort.Destroy;
begin
  //CriticalSection.Destroy;
  CloseHandle(FHandleEvents);
  Close;
  InBufferSize := 0;
  inherited;
end;
{
procedure TComPort.DoHalfTime(Sender:TObject);
Begin
  TraceL(1,0,'(__)DoHalfTime.');
End;
}
{
  ST_DISC_L1      = 0;
  ST_WAIT_CONN_L1 = 1;
  ST_CONN_L1      = 2;
}
procedure TComPort.MakeMessageL1;
Begin
   if m_sSize<>0 then
   Begin
    //TraceL(1,PortNum,'(__)DoHalfTime.');
    //Sleep(50);
    //if (m_byModemState=0)and(m_byState=ST_CONN_L1) then
    if m_byModemState=0 then
     CopyMessage(m_sSize);
    if m_byModemState=1 then
     MakeTextMessage;
   End;
End;
procedure TComPort.CallRxChar;
var
  w_lLength,i: Integer;
  n,BytesTrans: DWORD;
  CS: ComStat;
  Success: Boolean;
  Ov: TOverlapped;
  byBuff : CMessage;
  byByte : Byte;
begin
  ClearCommError(FHandle, n, @CS);
  w_lLength := CS.cbInQue;
  if w_lLength <= 0 then Exit;
  Ov.hEvent := FHandleEvents;
  Success := ReadFile(FHandle, pb_mBoxDoRead, w_lLength, BytesTrans, @Ov);
  for i:=0 to w_lLength-1 do
  Begin
   pb_mBoxCont[w_mBoxWrite]:=pb_mBoxDoRead[i];
   w_mBoxWrite := (w_mBoxWrite + 1) and BSZ;
   //TraceL(1,0,IntToHex(pb_mBoxDoRead[i],2));
   //TraceL(1,0,Char(pb_mBoxDoRead[i])+'-'+IntToHex(pb_mBoxDoRead[i],2));
   if (pb_mBoxCont[w_mBoxRead]=13)and(pb_mBoxCont[w_mBoxRead+1]=10) then
   Begin
    byByte := pb_mBoxCont[w_mBoxRead+2];
    if (w_lLength=2)or(byByte=$2b)or(byByte=$42)or(byByte=$43)or(byByte=$4e)or(byByte=$4f) then
    m_byModemState := 1;
   End;
  End;
  w_mBoxSize  := w_mBoxSize   - w_lLength;
  m_sSize     := w_mBoxCSize  - w_mBoxSize;
  //TraceL(1,0,IntToHex(m_sSize,2));
End;
procedure TComPort.MakeTextMessage;
Var
   byInByte  : Byte;
   byInByte1 : Byte;
   wLen,wRD : Word;
   //w_lLength,i:integer;
   strText : String;
Begin
  //SendDebug('(__)Text::>WR:'+IntToStr(w_mBoxWrite)+':RD:'+IntToStr(w_mBoxRead));
  //wRD        := w_mBoxRead + SaveRead;
  //m_byModemState := 0;
  while (w_mBoxWrite<>w_mBoxRead)  do
  begin
   byInByte := pb_mBoxCont[w_mBoxRead];
   //SendDebug('(__)Text::>WR:'+IntToStr(w_nTextLen)+':I:'+IntToStr(wRD)+':C:'+Char(byInByte));
   w_mBoxRead      := (w_mBoxRead+1) and BSZ;
   //byInByte1:= pb_mBoxCont[w_mBoxRead];
   //w_mBoxRead := (w_mBoxRead+1) and BSZ;
   if w_mBoxSize>w_mBoxCSize then Begin SetUpBuffer;exit;End;
   Inc(w_mBoxSize);
   {
   if  FoundSTART_DATA=0 then
   begin
    //if not((byInByte=SB0)or(byInByte1=SB1)) then
    begin
     TraceL(0,0,'(__)CL1MD::>Start');
     FoundSTART_DATA  := 1;
     InByteCount_DATA := 0;
    end;
   end
  else
  }
  begin
   //if (byInByte=SB0)and(byInByte1=SB1) then
   //if (byInByte=SB0) or (byInByte=$7e) then
   if (byInByte=SB0) then
   Begin
    if InByteCount_DATA>1 then Begin
     if (byInByte=SB0) then ATHandler(pb_mBoxDoTextRead,InByteCount_DATA-1);
     //if (byInByte=$7e) then TextHandler(pb_mBoxDoTextRead,InByteCount_DATA-1);
     //TraceL(0,0,'(__)CL1MD::>Found Command! '+IntToStr(InByteCount_DATA));
    End;
    InByteCount_DATA := 0;
   End
   else
   Begin
    pb_mBoxDoTextRead[InByteCount_DATA] := byInByte;
    if InByteCount_DATA>300 then Begin InByteCount_DATA := 0;SetUpBuffer; End;
    Inc(InByteCount_DATA);
   End;
  end;
 end;
End;

{
  PH_MCREG_IND     = 19;
  PH_MCONN_IND     = 20;
  PH_MRING_IND     = 21;
  PH_MNOCA_IND     = 22;
  PH_MBUSY_IND     = 23;
  PH_MNDLT_IND     = 24;
  PH_MNANS_IND     = 25;
}
{
  ST_DISC_L1      = 0;
  ST_WAIT_CONN_L1 = 1;
  ST_CONN_L1      = 2;
}
procedure TComPort.ATHandler(var pbyText : array of Byte;lLen : Word);
Var
   strText : String;
   i       : Integer;
   pMsg    : CMessage;
Begin
   strText := '';
   for i:=0 to lLen-1 do strText := strText + Char(pbyText[i+1]);
   if lLen>=2 then Begin
   TraceL(1,0,'(__)CL1MD::>CMD>'+strText);
  if Pos('+CLIP:',strText)>0   then
   Begin
    FindNumber(strText);
    SetUpBuffer;
    m_byModemState := 0;
   End;
  if Pos('OK',strText)>0      then
   Begin
    m_nDiscCtr := DISC_CTR;
    m_nWaitOkTimer.OffTimer;
    if m_byWaitState = WAIT_ATH then
    Begin
     SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_DISC_IND);
     if m_byState = ST_CONN_L1 then
     SendToL1(PH_MDISCSCMPL_IND);
    End;
    if m_byWaitState = WAIT_CON then
      m_nCallOffTimer.OnTimer(5);
    if m_byWaitState <> WAIT_PLS then
      m_byState   := ST_DISC_L1;
    m_byWaitState := WAIT_NUL;
    SetUpBuffer;
    m_byModemState := 0;
   End;
  if Pos('+CREG:',strText)>0      then
   Begin
    FindStation(strText);
    SetUpBuffer;
    m_byModemState := 0;
   End;
   if Pos('CONNECT',strText)>0     then
   Begin
    SendToL1(PH_MCONN_IND);
    m_nConnTimer.OffTimer;
    m_byState     := ST_CONN_L1;
    m_byConnCount := CONN_COUNT;
    m_nDiscCtr    := DISC_CTR;
    SetUpBuffer;
    m_byModemState := 0;
   End;
   if Pos('RING',strText)>0        then
   Begin
    DTR := True;
    SendToL1(PH_MRING_IND);
    SetUpBuffer;
    m_byModemState := 0;
    m_blRemConnect := True;
    if m_nL1.m_sblReaddres=0 then
    Begin
     m_wCurrMtrID   := m_nL1.m_swAddres;
     m_sbyProtoType := DEV_BTI_CLI;
    End;
   End;
   if Pos('NO CARRIER',strText)>0  then
   Begin
    m_byState  := ST_DISC_L1;
    m_nDiscCtr := DISC_CTR;
    SendToL1(PH_MNOCA_IND);
    SetUpBuffer;
    m_byModemState := 0;
    m_blRemConnect := False;
    //if (m_byWaitState<>WAIT_PLS)and(m_sbyProtoType<>DEV_BTI_CLI) then m_nCF.SchedSetAction;
    //pMsg.m_swLen := 11;
    //QueryConnect(pMsg);
   End;
   if Pos('BUSY',strText)>0        then
   Begin
    DiscProc;
    SendToL1(PH_MBUSY_IND);
    SetUpBuffer;
    m_byModemState := 0;
    m_blRemConnect := False;
    //if (m_byWaitState<>WAIT_PLS)and(m_sbyProtoType<>DEV_BTI_CLI) then m_nCF.SchedSetAction;
   End;
   if Pos('NO DIALTONE',strText)>0 then
   Begin
    SendToL1(PH_MNDLT_IND);
    SetUpBuffer;
    m_byModemState := 0;
    End;
   if Pos('NO ANSWER',strText)>0   then
   Begin
    m_byState := ST_DISC_L1;
    SendToL1(PH_MNANS_IND);
    SetUpBuffer;
    m_byModemState := 0;
    m_blRemConnect := False;
    //if (m_byWaitState<>WAIT_PLS)and(m_sbyProtoType<>DEV_BTI_CLI) then m_nCF.SchedSetAction;
    //m_nCF.SchedGo;
   End;
   End;
End;
procedure TComPort.FindNumber(strString : String);
Var
   nInd0,nInd1,nLen,i,nSumm,j: Integer;
   strChar : array[0..30] of Char;
   pL4CT : PSL4CONNTAG;
Begin
   TraceL(1,0,'(__)CL1MD::>CMD>Find Number:'+strString);
   nInd0 := Pos('"+',strString);
   nInd1 := Pos('",',strString);
   nLen  := nInd1 - nInd0;
   nSumm := 0;
   j := 0;
   m_strNumber := '';
   for i:=1 to nLen-1 do
   Begin
    m_strNumber := m_strNumber + strString[nInd0+i];
    nSumm := nSumm + Byte(strString[nInd0+i])+j;
    //TraceL(1,0,'(__)CL1MD::>Summ>:'+strString[nInd0+i]+'-'+IntToStr(nSumm)+'-'+IntToStr(j));
    Inc(j);
   End;

   //m_wCurrMtrID := FindClient(m_strNumber).;
   pL4CT := FindClient(m_strNumber);
   if pL4CT<>Nil then
   Begin
    m_wCurrMtrID   := pL4CT.m_sbyCliID;
    m_sbyProtoType := pL4CT.m_sbyProtID;
    SendMsg(BOX_L3_LME,m_wCurrMtrID,DIR_LLTOLM3,PH_RCONN_IND);
   End else m_wCurrMtrID := m_wCurrMtrID + 1;
   SendToProc(2,DIR_L1TOL3,PH_PHONEKEY_REQ,BOX_L4,@nSumm);
End;
procedure TComPort.FindStation(strString : String);
Var
   nInd0 : Integer;
   strFindString : String;
Begin
   //TraceL(0,0,'(__)CL1MD::>CMD>Find Station:'+strString);
   //nInd0 := Pos(',',strString);
   //m_strNumber := strString[nInd0+1];
   if strString[Pos(',',strString)+1]='1' then
   Begin
    SendToL1(PH_STATIONON_REQ);
   //SendToProc(0,DIR_L1TOAT,PH_STATIONON_REQ,BOX_L2,Nil);
   //SendToProc(0,DIR_L1TOL3,PH_STATIONON_REQ,BOX_L4,Nil);
   End
   else
   Begin
    SendToL1(PH_STATIONOF_REQ);
   //SendToProc(0,DIR_L1TOAT,PH_STATIONOF_REQ,BOX_L2,Nil);
   //SendToProc(0,DIR_L1TOL3,PH_STATIONOF_REQ,BOX_L4,Nil);
   End;
End;
procedure TComPort.SendToL1(byType : Byte);
Begin
   //SendDebug('(__)CLML1::>Text');
   with m_sMsg do begin
   m_swLen        := 11;
   m_sbyFrom      := DIR_L1TOL1;
   m_sbyFor       := DIR_L1TOL1;
   m_sbyTypeIntID := m_sbyProtoType;
   m_sbyServerID  := 0;
   m_sbyDirID     := m_nL1.m_sbyPortID;
   m_swObjID      := m_wCurrMtrID;
   m_sbyType      := byType;
   FPUT(BOX_L1,@m_sMsg);
   End;
End;
procedure TComPort.SendToL2(byType : Byte);
Begin
   //SendDebug('(__)CLML1::>Text');
   with m_sMsg do begin
   m_swLen        := 11;
   m_sbyFrom      := DIR_L1TOL2;
   m_sbyFor       := DIR_L1TOL2;
   m_sbyTypeIntID := 0;
   m_sbyServerID  := 0;
   m_sbyDirID     := 0;
   m_swObjID      := m_wCurrMtrID;
   m_sbyType      := byType;
   FPUT(BOX_L2,@m_sMsg);
   End;
End;
procedure TComPort.SendToProc(byLen,byFor,byType,byBox:Byte;pValue:PByteArray);
Begin
   //SendDebug('(__)CLML1::>Text');
   with m_sMsg do begin
   m_sbyFrom      := DIR_L1TOL2;
   m_sbyFor       := byFor;
   m_sbyTypeIntID := 0;
   m_sbyServerID  := 0;
   m_sbyDirID     := 0;
   m_swObjID      := 0;
   m_sbyType      := byType;
   m_sbyInfo[0]   := byLen;
   move(pValue^,m_sbyInfo[1],byLen);
   m_swLen        := 11+byLen;
   FPUT(byBox,@m_sMsg);
   End;
End;
procedure TComPort.TextHandler(var pbyText : array of Byte;lLen : Word);
Begin
   //SendDebug('(__)CLML1::>Text');
   Move(pbyText[1],m_sMsg.m_sbyInfo,lLen);
   with m_sMsg do begin
   m_swLen        := 11+lLen;
   m_sbyFrom      := DIR_L1TOTXT;
   m_sbyFor       := DIR_L1TOTXT;
   m_sbyTypeIntID := 0;
   m_sbyServerID  := 0;
   m_sbyDirID     := 0;
   m_swObjID      := 0;
   m_sbyType      := PH_TEXT_IND;
   FPUT(BOX_L2,@m_sMsg);
   End;
End;

procedure TComPort.MakeMessage;
Var
   lLen : Byte;
Begin
   lLen := pb_mBoxCont[(w_mBoxRead+1) and BSZ]+6;
   while((m_sSize>=lLen)and(pb_mBoxCont[w_mBoxRead]=$68)) do CopyMessage(lLen);
   lLen := 5;
   while((m_sSize>=lLen)and(pb_mBoxCont[w_mBoxRead]=$10)) do CopyMessage(lLen);
End;

procedure TComPort.CopyMessage(wLen:Word);
Var
   i:Integer;
   byCRC,byLen:Byte;
   blCRC : Boolean;
Begin
   //TraceL(1,0,IntToHex(m_sSize,2));
   if wLen>2100 then
   Begin
   SetUpBuffer;
   exit;
   End;
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
   {
   DEV_NUL_L2   = 0;
   DEV_BTI_CLI  = 1;
   DEV_BTI_SRV  = 2;
   }
   //if m_byState=ST_CONN_L1 then
   if m_sEnrgoTelCom.m_sbIsTrasnBeg then
   begin
     m_sMsg.m_sbyFor  := DIR_L1TOL2;
     m_sMsg.m_swObjID := m_sEnrgoTelCom.m_swObjID;
     FPUT(BOX_L4,@m_sMsg);
   end
   else
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
   {
   if m_byType=DEV_COM_L2 then FPUT(BOX_L2,@m_sMsg) else
   if m_byType=DEV_COM_USPD then
   Begin
    m_sMsg.m_sbyFor       := DIR_L1TOBTI;
    FPUT(BOX_L2,@m_sMsg);
   End;
   }
   //if m_byType=DEV_COM_L4 then FPUT(BOX_L4,@m_sMsg);
   {
   byCRC := m_sbyInfo[m_swLen-9-2];
   //SendDebug('(__)COM::>CRC::>'+IntToHex(byCRC,2));

   blCRC := False;
   if (m_sbyInfo[0]=MSG_LONG_CODE)then
   Begin
    byLen := m_sbyInfo[1];
    if (byCRC=CalckKS(@m_sbyInfo[4],byLen)) then blCRC := True
   End;
   if (m_sbyInfo[0]=MSG_SHRT_CODE) then
   if (byCRC=CalckKS(@m_sbyInfo[1],2)) then blCRC := True;

   if blCRC then
   FPUT(BOX_L2,@m_sMsg) else Begin
   TraceL(0,0,'(__)CL1MD::>COM::>CRC Error!');SetUpBuffer;ResetBuffer;End;
   //if assigned(FOnReceive) then FOnReceive(m_sbyInfo,i);
   End;
   }
End;

function TComPort.CalckKS(Buffer: PByteArray;wLen: Integer): Byte;
var
  i: Integer;
begin
  Result := 0;
  //SendDebug('CRC:>');
  for i:= 0 to wLen-1 do
  Begin
  Result := Result + Buffer^[i];
  //SendDebug(' '+IntToHex(Buffer^[i],2));
  End;
  //SendDebug('CC'+IntToHex(Result,2));
end;
procedure TComPort.CallRxFlag;
begin
 if Assigned(FOnRxFlag) then FOnRxFlag(Self);
end;
procedure TComPort.CallTxEmpty;
begin
  //if Assigned(FOnTxEmpty) then FOnTxEmpty(Self);
  //FBlTxEmpty := True;
  //SendDebug('SendMessage! TxEmpty.');
  //Sleep(5);
  //SendMesage;
end;
procedure TComPort.Close;
begin
  if not FActive then Exit;
  try
    SetCommMask(Fhandle, 0);
    ResetBuffer;
    FEventThread.Terminate;
    //FReadThread.Terminate;
    if not CloseHandle(FHandle) then DoOnError(Error);
    FHandle := INVALID_HANDLE_VALUE;
    FActive := False;
    if Assigned(FOnClose) then FOnClose(Self);
    FEventThread := Nil;
    //FReadThread  := Nil;
    TraceL(1,0,'(__)CL1MD::>Close:'+IntToStr(PortNum));
  except
  end;
end;
procedure TComPort.DoEvents;
begin
  if (EV_ERR and FMask) <> 0 then DoOnError(LineStatusErr);
  if (EV_RXCHAR and FMask) <> 0 then CallRxChar;
  if (EV_TXEMPTY and FMask) <> 0 then CallTxEmpty;
  if (EV_BREAK and FMask) <> 0 then CallBreak;
  if ((EV_CTS and FMask) <> 0) or ((EV_DSR and FMask) <> 0) or ((EV_RLSD and FMask) <> 0) or ((EV_RING and FMask) <> 0) then CallModemStatusChange;
  if (EV_RXFLAG and FMask) <> 0 then CallRxFlag;
  if (EV_RING and FMask) <> 0 then CallRing;
end;
procedure TComPort.DoOnByteReceived(Data: Byte);
begin
  if FBufferFull then Exit;
  FBufferUsed := True;
  FInBuffer[FNextPosToWrite] := Data;
  Inc(FNextPosToWrite);
  if FNextPosToWrite>=InBufferSize then FNextPosToWrite := 0;
  if FNextPosToWrite=FNextPosToRead then begin
    FBufferFull := True;
    DoOnError(BufferFull);
    end;
end;
procedure TComPort.DoOnError(Error: Byte);
begin
 if Assigned(FOnError) then FOnError(Self, Error);
end;
procedure TComPort.DoRTUPacket;
var
  FData: array of Byte;
begin
  SetLength(FData, BufferUsed);
  move(FInBuffer[FNextPosToRead], FData[0], BufferUsed);
  //if assigned(FOnRTUPacket) then FOnRTUPacket(FData, BufferUsed);
end;
function TComPort.GetBufferUsed: Word;
var
 psize: Integer;
begin
 psize := FNextPosToWrite - FNextPosToRead;
 if psize < 0
  then Result := InBufferSize + psize
  else Result := psize;
end;
function TComPort.GetByte: Byte;
begin
  Result:=0;
  if not FBufferUsed then begin
    DoOnError(BufferEmpty);
    Exit;
    end;

  Result := FInBuffer[FNextPosToRead];
  Inc(FNextPosToRead);
  if FNextPosToRead > InBufferSize then FNextPosToRead:=0;
  if (FNextPosToWrite=FNextPosToRead) then FBufferUsed:=False;
end;
function TComPort.GetBytes(var OutBuf: array of Byte; Count: Word): Word;
var
  i: Word;
begin
  if Count > BufferUsed
    then Result := BufferUsed
    else Result := Count;
  for i := 0 to Result - 1 do
    OutBuf[i] := GetByte;
end;
{
procedure TComPort.GetComPortSettings;
var
 ComConfig: TCommConfig;
 BufSize: Cardinal;
begin
  BufSize := SizeOf(TCommConfig);
  //ComConfig.dwProviderSubType := PST_RS232;
  GetCommConfig(Handle, ComConfig, BufSize);
  with comconfig.dcb do begin
   FBaudRate := br110;
   while ((BaudValues[FBaudRate] <> BaudRate) and (FBaudRate < br115200)) do inc(FBaudRate);
   FParity := TParity(Parity);
   FDatabits := TDatabits(ByteSize - 5);
   FStopbits := TStopbits(Stopbits);
  end;
end;
}

function TComPort.GetInBufferSize: Word;
begin
  Result := length(FInBuffer);
end;


function TComPort.GetRTUInterval: DWORD;
begin
  if FRTUInterval = INFINITE
    then Result := 0
    else Result := FRTUInterval;
end;
{
function TComPort.OpenPort: Boolean;
var
  SetErr: Boolean;
begin
 SetErr:=false;
 if Not Active then begin
    FHandle:=CreateFile(PChar('\\.\Com'+IntToStr(FPortNum)),GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,FILE_FLAG_OVERLAPPED,0);
    SendDebug('Open COM:'+IntToStr(FPortNum));
 end;
 if Active then begin
  if Not SetPortDCB(FHandle) then begin
    //DoSetDCBError;
    SendDebug('Error DCB!');
    SetErr:=true;
  end;
  if Not SetPortTimeOuts(FHandle) then begin
     SendDebug('Error TMR!');
    //DoSetTimeOutsError;
    SetErr:=true;
  end;
  if SetErr then begin
    SendDebug('Close HAND!');
    CloseHandle(FHandle);
    FHandle:=INVALID_HANDLE_VALUE;
  end;
  //FCommUART.Handle := FHandle;

    FEventThread := TComThread.Create(True);
    FEventThread.FComPort := Self;
    FEventThread.FreeOnTerminate := True;
    SetCommMask(Fhandle, EVENT_MASK);
    FEventThread.Resume;

    FReadThread := TReadThread.Create(True);
    FReadThread.FComPort := Self;
    FReadThread.FreeOnTerminate := True;
    FReadThread.Resume;
    ResetBuffer;
    CallModemStatusChange;
 //end;
 //Result:=Active;
 Result:=True;
end;
}

procedure TComPort.LoadINI(FileName: String);
var
  Fl: TINIFile;
  strParity,strDataBit,strStopBit:String;
begin
  Fl         := TINIFile.Create(FileName);
  PortNum    := Fl.ReadInteger('PORTSETT', 'Port', 1);
  ManualRate := Fl.ReadInteger('PORTSETT', 'Baud', 9600);
  strParity  := Fl.ReadString('PORTSETT', 'Parity', 'None');
  strDataBit := Fl.ReadString('PORTSETT', 'DataBit', '8');
  strStopBit := Fl.ReadString('PORTSETT', 'StopBit', '1');

  if strParity='None' then Parity := pNone;
  if strParity='Even' then Parity := pEven;
  if strParity='Odd'  then Parity := pOdd;

  if strDataBit='7' then ByteSize := bs_7_Bits;
  if strDataBit='8' then ByteSize := bs_8_Bits;

  if strStopBit='1'   then StopBits := sbOne;
  if strStopBit='1.5' then StopBits := sbOneHalf;
  if strStopBit='2'   then StopBits := sbTwo;

  if OpenPort then TraceL(1,0,'(__)CL1MD::>��� ���� ��::'+IntToStr(PortNum)+':'+IntToStr(ManualRate))
  else TraceL(1,0,'(__)CL1MD::>������ �������� ��� �����:'+IntToStr(PortNum));
  Fl.Destroy;
End;

procedure TComPort.Init(var pL1 : SL1TAG);
Begin
  Move(pL1,m_nL1,sizeof(SL1TAG));
  Reset;
End;
procedure TComPort.Reset;
Begin
  PortNum        := m_nL1.m_sbyPortNum;
  ManualRate     := StrToInt(m_nSpeedList.Strings[m_nL1.m_sbySpeed]);
  m_swPID        := m_nL1.m_sbyPortID;
  m_sbyProtoType := m_nL1.m_sbyProtID;
  m_byConnCount  := CONN_COUNT;;


   {
  DTR := False; //Sleep(50);
  DTR := True;  //Sleep(50);
  DTR := False; //Sleep(50);
  DTR := True;
  RTS := True;
    }
  m_byModemState := 0;
  SB0            := 13;
  m_byState      := ST_DISC_L1;
  m_nDiscCtr     := DISC_CTR;
  m_byWaitState  := WAIT_NUL;
  m_blRemConnect := False;
  m_blIsPause    := False;
  //if pL1.m_sbyType=DEV_COM_LOC then m_byState := ST_CONN_L1;

  if (m_nWaitOkTimer=Nil) then m_nWaitOkTimer := CTimer.Create;
  m_nWaitOkTimer.SetTimer(DIR_L1TOL1,PH_WTOKTMR_IND,0,m_nL1.m_sbyPortID,BOX_L1);

  if (m_nConnTimer=Nil) then m_nConnTimer := CTimer.Create;
  m_nConnTimer.SetTimer(DIR_L1TOL1,PH_CONNTMR_IND,0,m_nL1.m_sbyPortID,BOX_L1);

  if (m_nDiscTimer=Nil) then m_nDiscTimer := CTimer.Create;
  m_nDiscTimer.SetTimer(DIR_L1TOL1,PH_DISCTMR_IND,0,m_nL1.m_sbyPortID,BOX_L1);

  if (m_nCallOffTimer=Nil) then m_nCallOffTimer := CTimer.Create;
  m_nCallOffTimer.SetTimer(DIR_L1TOL1,PH_CALLOFFTMR_IND,0,m_nL1.m_sbyPortID,BOX_L1);

  if m_nL1.m_sbyParity=m_nParityList.IndexOf('NO')     then Parity   := pNone;
  if m_nL1.m_sbyParity=m_nParityList.IndexOf('EVEN')   then Parity   := pEven;
  if m_nL1.m_sbyParity=m_nParityList.IndexOf('ODD')    then Parity   := pOdd;

  if m_nL1.m_sbyData=m_nDataList.IndexOf('7')          then ByteSize := bs_7_Bits;
  if m_nL1.m_sbyData=m_nDataList.IndexOf('8')          then ByteSize := bs_8_Bits;

  if m_nL1.m_sbyStop=m_nStopList.IndexOf('1')          then StopBits := sbOne;
  if m_nL1.m_sbyStop=m_nStopList.IndexOf('1.5')        then StopBits := sbOneHalf;
  if m_nL1.m_sbyStop=m_nStopList.IndexOf('2')          then StopBits := sbTwo;

  m_swDelayTime := m_nL1.m_swDelayTime;

  if OpenPort then TraceL(1,0,'(__)CL1MD::>��� ���� ��::'+IntToStr(PortNum)+':'+IntToStr(ManualRate))
  else TraceL(1,PortNum,'(__)CL1MD::>������ �������� ��� �����: '+IntToStr(PortNum));
End;
function TComPort.FreePort(var pMsg:CMessage):Boolean;
Begin
    m_blIsPause := True;
    FActive     := False;
    if FEventThread<>Nil then FEventThread.Suspend;
    ResetBuffer;
    CloseHandle(FHandle);
    TraceL(1,0,'(__)CL1MD::>Close:'+IntToStr(PortNum));
    FHandle := INVALID_HANDLE_VALUE;
End;
function TComPort.SettPort(var pMsg:CMessage):Boolean;
Begin
    m_blIsPause := False;
    Reset;
    if m_nL1.m_sbyType=DEV_COM_GSM then
    Begin
     //SendCommand('AT+IPR='+m_nSpeedList.Strings[m_nL1.m_sbySpeed]);
     SendCommand('ATZ');
     //SendCommand('AT&D0');
     //SendCommand('ATS0=2');
     //SendCommand('ATS7=60\Q0');
    End;
End;
procedure TComPort.SetDynamic(var pL1 : SL1SHTAG);
Begin
  //m_svDCB := ImportDCB;
  GetCommState(FHandle, m_svDCB);
  ManualRate    := StrToInt(m_nSpeedList.Strings[pL1.m_sbySpeed]);
  if pL1.m_sbyParity=m_nParityList.IndexOf('NO')     then Parity   := pNone;
  if pL1.m_sbyParity=m_nParityList.IndexOf('EVEN')   then Parity   := pEven;
  if pL1.m_sbyParity=m_nParityList.IndexOf('ODD')    then Parity   := pOdd;
  if pL1.m_sbyData=m_nDataList.IndexOf('7')          then ByteSize := bs_7_Bits;
  if pL1.m_sbyData=m_nDataList.IndexOf('8')          then ByteSize := bs_8_Bits;
  if pL1.m_sbyStop=m_nStopList.IndexOf('1')          then StopBits := sbOne;
  if pL1.m_sbyStop=m_nStopList.IndexOf('1.5')        then StopBits := sbOneHalf;
  if pL1.m_sbyStop=m_nStopList.IndexOf('2')          then StopBits := sbTwo;
  m_swSvDelayTime := m_swDelayTime;
  m_swDelayTime   := pL1.m_swDelayTime;
  SetPortDCB(FHandle);
End;
procedure TComPort.SetDefaultSett;
Begin
  m_swDelayTime := m_swSvDelayTime;
  SetCommState(FHandle, m_svDCB);
End;
procedure TComPort.LoadFromCFG(nPortNum,nSpeed:Integer;strParity,strDataBit,strStopBit:String);
begin
  PortNum    := nPortNum;
  ManualRate := nSpeed;

  if strParity='None' then Parity := pNone;
  if strParity='Even' then Parity := pEven;
  if strParity='Odd'  then Parity := pOdd;

  if strDataBit='7' then ByteSize := bs_7_Bits;
  if strDataBit='8' then ByteSize := bs_8_Bits;

  if strStopBit='1'   then StopBits := sbOne;
  if strStopBit='1.5' then StopBits := sbOneHalf;
  if strStopBit='2'   then StopBits := sbTwo;

  if OpenPort then TraceL(1,0,'(__)CL1MD::>��� ���� ��::'+IntToStr(PortNum)+':'+IntToStr(ManualRate))
  else TraceL(1,0,'(__)CL1MD::>������ �������� ��� �����');
  //Fl.Destroy;
End;



function TComPort.OpenPort: Boolean;
var
  TimeOuts: CommTimeOuts;
begin
  Result:=True;
  if FActive then Exit;
  try
    FHandle := CreateFile(PChar('\\.\Com' + IntToStr(PortNum)), GENERIC_READ or GENERIC_WRITE, 0 , nil, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
    if (FHandle = INVALID_HANDLE_VALUE) then begin
    Result := False;
    Exit;
    end;
    FActive := True;
    if not GetPortTimeOuts(FHandle) then TraceL(1,0,'(__)CL1MD::>ERR::>GetPortTimeOuts!');
    if not SetPortTimeOuts(FHandle) then TraceL(1,0,'(__)CL1MD::>ERR::>SetPortTimeOuts!');
    if not SetPortDCB(FHandle) then TraceL(1,0,'(__)CL1MD::>ERR::>SetPortDCB!');
    if FEventThread=Nil then FEventThread := TComThread.Create(True);
    FEventThread.FComPort := Self;
    FEventThread.FreeOnTerminate := True;
    SetCommMask(Fhandle, EVENT_MASK);
    FEventThread.Resume;
    FEventThread.Priority := tpHighest;
    DTR := True;
    RTS := True;
    ResetBuffer;
    //DTR := True;
    //RTS := True;
    CallModemStatusChange;
    if Assigned(FOnOpen) then FOnOpen(Self);
  except
  end;
end;
function TComPort.Peekbyte(No: Word): Byte;
begin
  Result := 0;
  if No + 1 > BufferUsed
    then DoOnError(OutOfRange)
    else Result := FInBuffer[(FNextPosToRead + No) mod InBufferSize];
end;
function TComPort.PortSettingsDialog(WinHandle: THandle): Boolean;
var
  ComConfig : TCommConfig;
  BufSize : cardinal;
begin
  Result := False;
  if not FActive then Exit;
  BufSize := SizeOf(TCommConfig);
  //ComConfig.dwProviderSubType := PST_RS232;
  GetCommConfig(FHandle, ComConfig, BufSize);
  if CommConfigDialog(PChar('COM' + IntToStr(PortNum)), WinHandle, ComConfig) then
    SetCommConfig(Handle, ComConfig, BufSize);
  //GetComPortSettings;
  Result := True;
end;
procedure TComPort.ResetBuffer;
begin
  FNextPosToWrite := 0;
  FNextPosToRead := 0;
  FBufferUsed := False;
  FBufferFull := False;
  FBlTxEmpty  := True;
  PurgeComm(FHandle, PURGE_RXCLEAR or PURGE_TXCLEAR);
end;
function TComPort.SendMesage1:Boolean;
var
  BytesTrans: DWORD;
  Ov : TOverlapped;
  wL : Word;
Begin
  //if not FActive then Exit;

  wL :=FGET(BOX_L1+m_byID,@SndBuffer[0]);
  if wL<>0 then
  Begin

  //Sleep(5);

  //SndBuffer[9+0] := 0;
  //SndBuffer[9+1] := 1;
  //SndBuffer[9+2] := 2;
  //SndBuffer[9+3] := 3;
  //SndBuffer[9+4] := 0;

  //wL := 9+5;
  //SendDebug('Send With Buffer.'+IntToStr(wL));

  FBlTxEmpty := False;
  FillChar(Ov, SizeOf(TOverlapped), 0);
  Ov.hEvent := FHandleEvents;
  Result := WriteFile(FHandle, SndBuffer[9], wL-9, BytesTrans, @Ov) or (GetLastError = ERROR_IO_PENDING);
  //Result := WriteFile(FHandle, FSndBuffer[0], 16, BytesTrans, @Ov) or (GetLastError = ERROR_IO_PENDING);
  WaitForSingleObject(Ov.hEvent, INFINITE);
  Result := Result and GetOverlappedResult(FHandle, Ov, BytesTrans, False);
  //FillChar(Ov, SizeOf(TOverlapped), 0);
  End else FBlTxEmpty := True;
End;
function TComPort.SendArray(pMsg:Pointer;nLen:Word): Boolean;
var
  BytesTrans: DWORD;
  Ov : TOverlapped;
  wL : Word;
  ppMsg : PByteArray;
  ppMsg1 : PCMessage;
  //pM : CMessage;
begin
  ppMsg := pMsg;
  ppMsg1:= pMsg;
  //Move(pMsg^,pM,sizeof(CMessage));
  FillChar(Ov, SizeOf(TOverlapped), 0);
  Ov.hEvent := FHandleEvents;
  Result := WriteFile(FHandle, ppMsg[11], nLen-11, BytesTrans, @Ov) or (GetLastError = ERROR_IO_PENDING);
  WaitForSingleObject(Ov.hEvent, INFINITE);
  Result := Result and GetOverlappedResult(FHandle, Ov, BytesTrans, False);

  Result := True;
end;
function TComPort.Send(pMsg:Pointer;nLen:Word): Boolean;
var
  BytesTrans: DWORD;
  Ov : TOverlapped;
  wL : Word;
  ppMsg : PByteArray;
  ppMsg1 : PCMessage;
  //pM : CMessage;
begin
  if m_blIsPause=True then exit;
  ppMsg := pMsg;
  ppMsg1:= pMsg;
  //Move(pMsg^,pM,sizeof(CMessage));
  m_wCurrMtrType := ppMsg1.m_sbyServerID;
  m_wCurrMtrID   := ppMsg1.m_swObjID;
  FillChar(Ov, SizeOf(TOverlapped), 0);
  Ov.hEvent := FHandleEvents;
  Result := WriteFile(FHandle, ppMsg[11], nLen-11, BytesTrans, @Ov) or (GetLastError = ERROR_IO_PENDING);
  WaitForSingleObject(Ov.hEvent, INFINITE);
  Result := Result and GetOverlappedResult(FHandle, Ov, BytesTrans, False);

  Result := True;
end;
function TComPort.EventHandler(var pMsg:CMessage):boolean;
Begin
  if pMsg.m_sbyFor=DIR_L1TOL1 then
  Begin
    case pMsg.m_sbyType of
         PH_WTOKTMR_IND:
         Begin
          TraceL(1,0,'(__)CL1MD::>ReDisconnect.');
          if m_nDiscCtr<>0 then
          Begin
           Disconnect(pMsg);
           m_nDiscCtr:=m_nDiscCtr-1;
          End else Begin {Reset;m_nCF.SchedGo;}End;
         End;
         PH_DISCTMR_IND:
         Begin
          m_blRemConnect := False;
          SendCommand('ATH');
          m_byWaitState  := WAIT_ATH;
          m_nWaitOkTimer.OnTimer(3);
          if m_byState=ST_WAIT_CONN_L1 then
           Begin
            m_byState     := ST_DISC_L1;
            m_byWaitState := WAIT_CON;
           End;
         End;
         PH_CALLOFFTMR_IND:QueryConnect(pMsg);
    End;
  End;
End;
function TComPort.Disconnect(var pMsg:CMessage):Boolean;
Begin
    {
    //m_byState := 0;
    //DTR := True;
    //DTR := False;
    if m_nL1.m_sbyType=DEV_COM_GSM then
    if m_nDiscTimer.IsProceed=False then
    Begin
     SendNullCommand('+');//Sleep(200);
     for i:=0 to 10000000 do j:=i;
     SendNullCommand('+');//Sleep(200);
     for i:=0 to 10000000 do j:=i;
     SendNullCommand('+');//Sleep(200);
     for i:=0 to 10000000 do j:=i;
     m_byWaitState := WAIT_PLS;
     //m_nWaitOkTimer.OnTimer(3);
     m_nDiscTimer.OnTimer(5);
     m_nConnTimer.OffTimer;
    End;
    }
    if m_nL1.m_sblReaddres=0 then
    DiscProc;
End;
function TComPort.DiscProc:Boolean;
Var
    i,j : Integer;
Begin
    //m_byState := 0;
    //DTR := True;
    //DTR := False;
    if m_nL1.m_sbyType=DEV_COM_GSM then
    if m_nDiscTimer.IsProceed=False then
    Begin
     SendNullCommand('+');//Sleep(200);
     for i:=0 to 10000000 do j:=i;
     SendNullCommand('+');//Sleep(200);
     for i:=0 to 10000000 do j:=i;
     SendNullCommand('+');//Sleep(200);
     for i:=0 to 10000000 do j:=i;
     m_byWaitState := WAIT_PLS;
     //m_nWaitOkTimer.OnTimer(3);
     m_nDiscTimer.OnTimer(5);
     m_nConnTimer.OffTimer;
    End;
End;
function TComPort.ReConnect(var pMsg:CMessage):Boolean;
Begin
     //m_byConnCount := 0;
     //m_byState := ST_DISC_L1;
     //DiscProc;
     m_sOldPhone := '';
     Result := True;
End;
function TComPort.Connect(var pMsg:CMessage):Boolean;
Var
    pDS : CMessageData;
    i   : Integer;
    chPhone : array[0..50] of Char;
Begin
    if m_nL1.m_sblReaddres=0 then
    if m_blRemConnect=False then
    Begin
     m_sbyProtoType := m_nL1.m_sbyProtID;
     m_wCurrMtrID   := pMsg.m_swObjID;
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
     Move(pDS.m_sbyInfo[0],chPhone,pDS.m_swData0);
     m_sNewPhone := chPhone;
     m_nCallTime := pDS.m_swData1;
     if m_sNewPhone<>'' then
     if m_sOldPhone=m_sNewPhone then QueryConnect(pMsg) else
     Begin
      Disconnect(pMsg);
      m_byState := ST_WAIT_CONN_L1;
     End;
     Result := True;
    End;
End;
procedure TComPort.QueryConnect(var pMsg:CMessage);
Begin
    if m_byState=ST_DISC_L1 then
    Begin
     //DTR := True;
     //RTS := True;
     //SendCommand('AT+IPR=57600');
     //SendCommand('AT&C0');
     //SendCommand('AT&D0');
     if m_byConnCount=0 then
     Begin
      m_byConnCount := CONN_COUNT;
      m_nConnTimer.OffTimer;
      SendToL1(PH_MDISC_IND);
      //DTR := True;
      //DTR := False;
      Disconnect(pMsg);
      m_byState := ST_WAIT_CONN_L1;
      Exit;
     End;
     Dec(m_byConnCount);
     //SendCommand('AT+IPR=57600');
     //SendCommand('AT&C0');
     //SendCommand('AT&D0');
     //SendCommand('AT+ICF=2,0');
     //SendCommand('AT+IFC=0,0');
     SendCommand('ATD'+m_sNewPhone);
     m_nConnTimer.OnTimer(m_nCallTime);
     m_sOldPhone := m_sNewPhone;
    End else
    Begin
     if m_nDiscTimer.IsProceed=True then
     Begin
       m_byConnCount := CONN_COUNT;
       m_nConnTimer.OffTimer;
       //SendToL1(PH_MDISC_IND);
       ////DTR := True;
       ////DTR := False;
       Disconnect(pMsg);
       m_byState := ST_WAIT_CONN_L1;
       Exit;
     End else
     SendToL1(PH_MCONN_IND);
    End;
End;
procedure TComPort.SendCommand(strCommand : String);
Var
    strConnect : String;
    nLen,i     : Integer;
    nMsg       : CHMessage;
Begin
    strConnect     := strCommand+ #13#10;
    nLen := Length(strConnect);
    nMsg.m_swLen := 11 + nLen;
    for i:=0 to nLen-1 do nMsg.m_sbyInfo[i] := Byte(strConnect[i+1]);
    TraceL(1,0,'(__)CL2MD::>COMM::'+strConnect);
    SendArray(@nMsg,nMsg.m_swLen);
End;
procedure TComPort.SendNullCommand(strCommand : String);
Var
    strConnect : String;
    nLen,i     : Integer;
    nMsg       : CHMessage;
Begin
    strConnect     := strCommand;
    nLen := Length(strConnect);
    nMsg.m_swLen := 11 + nLen;
    for i:=0 to nLen-1 do nMsg.m_sbyInfo[i] := Byte(strConnect[i+1]);
    TraceL(1,0,'(__)CL2MD::>COMM::'+strConnect);
    SendArray(@nMsg,nMsg.m_swLen);
End;

function TComPort.SendByte(B: Byte): Boolean;
begin
  //Result := SendArray(B, 1);
end;
function TComPort.SendStr(S: String): Boolean;
var
  StrArr: array of Byte;
begin
  SetLength(StrArr, length(S));
  Move(S[1], StrArr[0], length(S));
  Result := SendArray(StrArr, length(S));
end;
procedure TComPort.SetActive(const Value: Boolean);
begin
  if Value = FActive then Exit;
  if Value
    then OpenPort
    else Close;
end;
procedure TComPort.AssignTo(Dest: TPersistent);
begin
  if Dest is TComPort then with TComPort(Dest) do begin
    FBaudRate    := self.FBaudRate;
    FManualRate  := self.FManualRate;
    FDCBFlag     := self.FDCBFlag;
    FXonLim      := self.FXonLim;
    FXoffLim     := self.FXoffLim;
    FByteSize    := self.FByteSize;
    FParity      := self.FParity;
    FStopBits    := self.FStopBits;
    FXonChar     := self.FXonChar;
    FXoffChar    := self.FXoffChar;
    FErrorChar   := self.FErrorChar;
    FEofChar     := self.FEofChar;
    FEvtChar     := self.FEvtChar;

    FReadIntervalTimeout         := self.FReadIntervalTimeout;
    FReadTotalTimeoutMultiplier  := self.FReadTotalTimeoutMultiplier;
    FReadTotalTimeoutConstant    := self.FReadTotalTimeoutConstant;
    FWriteTotalTimeoutMultiplier := self.FWriteTotalTimeoutMultiplier;
    FWriteTotalTimeoutConstant   := self.FWriteTotalTimeoutConstant;
  end else inherited AssignTo(Dest);
end;
procedure TComPort.SetBaudRate(const Value: TStBaudRates);
begin
  if Value <> brManual then FManualRate := StBaudRate[Value];
  FBaudRate:=Value;
end;
procedure TComPort.SetManualRate(const Value: DWord);
var
  i: Byte;
begin
  FManualRate:=Value;
  FBaudRate:=brManual;
  try
    for i:=1 to 20 do begin
       if StBaudRate[TStBaudRates(i)] = Value then begin
          FBaudRate:=TStBaudRates(i);
          Break;
       end;
    end;
  except
  end;
end;
procedure TComPort.SetDCBFlags(const Value: TStDCBFlags);
begin
  if (flDTRControlHandshake in Value) and (flDTRControlEnable in Value) then begin
     if (flDTRControlEnable in FDCBFlag) then FDCBFlag := Value - [flDTRControlEnable]
     else FDCBFlag := Value - [flDTRControlHandshake];
  end else FDCBFlag := Value;
  if FParity <> pNone then begin
    if Not (flParity in Value) then FDCBFlag := FDCBFlag + [flParity];
  end;
end;
procedure TComPort.SetByteSize(const Value: TStByteSize);
begin
  FByteSize := Value;
  if Value = bs_5_Bits then begin
    if FStopBits = sbTwo then FStopBits := sbOneHalf;
  end else begin
    if FStopBits = sbOneHalf then FStopBits := sbOne;
  end;
end;
procedure TComPort.SetParity(const Value: TStParity);
begin
  FParity := Value;
  if Value <> pNone then begin
    if Not (flParity in FDCBFlag) then FDCBFlag := FDCBFlag + [flParity];
  end else if (flParity in FDCBFlag) then FDCBFlag := FDCBFlag - [flParity];;
end;
procedure TComPort.SetStopBits(const Value: TStStopBits);
begin
  FStopBits := Value;
  if Value = sbOneHalf then FByteSize := bs_5_Bits;
  if Value = sbTwo then if FByteSize = bs_5_Bits then FByteSize := bs_8_Bits;
end;
function TComPort.ImportDCB : TDCB;
begin
  BuildCommDCB('', Result);
  Result.BaudRate  := FManualRate;
  Result.Flags     := Word(FDCBFlag);
  Result.XonLim    := FXonLim;
  Result.XoffLim   := FXoffLim;
  Result.ByteSize  := StByteSize[FByteSize];
  Result.Parity    := StParity[FParity];
  Result.StopBits  := StStopBits[FStopBits];
  Result.XonChar   := FXonChar;
  Result.XoffChar  := FXoffChar;
  Result.ErrorChar := FErrorChar;
  Result.EofChar   := FEofChar;
  Result.EvtChar   := FEvtChar;
end;
procedure TComPort.ExportDCB(const PortDCB: TDCB);
begin
  ManualRate := PortDCB.BaudRate;
  DCBFlag    := TStDCBFlags(Word(PortDCB.Flags));
  XonLim     := PortDCB.XonLim;
  XoffLim    := PortDCB.XoffLim;
  FByteSize  := TStByteSize(PortDCB.ByteSize-5);
  FParity    := TStParity(PortDCB.Parity);
  FStopBits  := TStStopBits(PortDCB.StopBits);
  XonChar    := PortDCB.XonChar;
  XoffChar   := PortDCB.XoffChar;
  ErrorChar  := PortDCB.ErrorChar;
  EofChar    := PortDCB.EofChar;
  EvtChar    := PortDCB.EvtChar;
end;
function TComPort.GetPortDCB(PortHandle: THandle): Boolean;
var
  CurDCB: TDCB;
begin
  if PortHandle <> INVALID_HANDLE_VALUE then begin
    Result := GetCommState(PortHandle, CurDCB);
    if Result then ExportDCB(CurDCB);
  end else Result := false;
end;
function TComPort.SetPortDCB(PortHandle: THandle): Boolean;
var
  CurDCB: TDCB;
begin
  if PortHandle <> INVALID_HANDLE_VALUE then begin
    CurDCB := ImportDCB;
    Result := SetCommState(PortHandle, CurDCB);
    if Not Result then GetPortDCB(PortHandle);
  end else Result := false;
end;


function TComPort.ImportCommTimeOuts : TCommTimeOuts;
begin
  Result.ReadIntervalTimeout         := FReadIntervalTimeout;
  Result.ReadTotalTimeoutMultiplier  := FReadTotalTimeoutMultiplier;
  Result.ReadTotalTimeoutConstant    := FReadTotalTimeoutConstant;
  Result.WriteTotalTimeoutMultiplier := FWriteTotalTimeoutMultiplier;
  Result.WriteTotalTimeoutConstant   := FWriteTotalTimeoutConstant;
end;

procedure TComPort.ExportCommTimeOuts(const PortTimeOuts: TCommTimeOuts);
begin
  FReadIntervalTimeout         := PortTimeOuts.ReadIntervalTimeout;
  FReadTotalTimeoutMultiplier  := PortTimeOuts.ReadTotalTimeoutMultiplier;
  FReadTotalTimeoutConstant    := PortTimeOuts.ReadTotalTimeoutConstant;
  FWriteTotalTimeoutMultiplier := PortTimeOuts.WriteTotalTimeoutMultiplier;
  FWriteTotalTimeoutConstant   := PortTimeOuts.WriteTotalTimeoutConstant;
end;

function TComPort.GetPortTimeOuts(PortHandle: THandle): Boolean;
var
  CurTimeOuts: TCommTimeOuts;
begin
  if PortHandle <> INVALID_HANDLE_VALUE then begin
    Result := GetCommTimeOuts(PortHandle, CurTimeOuts);
    if Result then ExportCommTimeOuts(CurTimeOuts);
  end else Result := false;
end;

function TComPort.SetPortTimeOuts(PortHandle: THandle): Boolean;
var
  CurTimeOuts: TCommTimeOuts;
begin
  if PortHandle <> INVALID_HANDLE_VALUE then begin
    CurTimeOuts := ImportCommTimeOuts;
    Result := SetCommTimeOuts(PortHandle, CurTimeOuts);
    if Not Result then GetPortTimeOuts(PortHandle);
  end else Result := false;
end;

procedure TComPort.SetFDTR(const Value: Boolean);
begin
  EscapeCommFunction(Handle,SETDTR*ord(Value)+CLRDTR*ord(not Value));
  FDTR := Value;
end;
procedure TComPort.SetFRTS(const Value: Boolean);
begin
  EscapeCommFunction(Handle,SETRTS*ord(Value)+CLRRTS*ord(not Value));
  FRTS := Value;
end;
procedure TComPort.SetInBufferSize(Value: Word);
begin
  if GetInBufferSize = Value then Exit;
  SetLength(FInBuffer, Value);
  ResetBuffer;
end;
procedure TComPort.SetPort(Value: Byte);
var
  temp: Boolean;
begin
  if FPortNum = Value then Exit;
  temp := FActive;
  if temp then Close;
  FPortNum := Value;
  if temp then OpenPort;
end;
procedure TComPort.SetRTUInterval(const Value: DWORD);
begin
  if Value = 0
    then FRTUInterval := INFINITE
    else FRTUInterval := Value;
end;

procedure TComPort.RunTmr;
Begin
    m_nConnTimer.RunTimer;
    m_nDiscTimer.RunTimer;
    m_nCallOffTimer.RunTimer;
    m_nWaitOkTimer.RunTimer;
End;

{ TComThread }
destructor TComThread.Destroy;
Begin
End;
procedure TComThread.Execute;
var
  Overlapped: TOverlapped;
  BytesTrans: DWORD;

  RxCharTicks: DWORD;
  RTU_TO: DWord;
begin
  FillChar(Overlapped, SizeOf(Overlapped), 0);
  Overlapped.hEvent := CreateEvent(nil, True, True, nil);
  //RTU_TO := INFINITE;
  RTU_TO := FComPort.m_swDelayTime;
  RxCharTicks := 0;
  //Priority := tpHighest;
  while not Terminated do begin
    WaitCommEvent(FComPort.Handle, FComPort.FMask, @Overlapped);
    case WaitForSingleObject(Overlapped.hEvent, FComPort.m_swDelayTime) of
    //case WaitForSingleObject(Overlapped.hEvent, RTU_TO) of
      WAIT_OBJECT_0:
      begin
      if GetOverlappedResult(FComPort.Handle, Overlapped, BytesTrans, False) then FComPort.DoEvents else
        { RTU mode }
        {if FComPort.m_swDelayTime <> INFINITE then begin
          if (EV_RXCHAR and FComPort.FMask) <> 0 then begin
            RxCharTicks := GetTickCount;
            RTU_TO := FComPort.m_swDelayTime;
            end else
          if (RTU_TO <> INFINITE) and (GetTickCount - RxCharTicks > FComPort.m_swDelayTime) then begin
            RTU_TO := INFINITE;
            FComPort.MakeMessageL1;
            end;
          end;
          }
          Sleep(10);
      end;
      WAIT_TIMEOUT:
      begin
        //RTU_TO := INFINITE;
        //Synchronize(FComPort.DoRTUPacket);
        //if (EV_RXCHAR and FComPort.FMask)<>0 then
        //Sleep(1);
        Synchronize(FComPort.MakeMessageL1);
        //FComPort.MakeMessageL1;
      end;
      end;
    end;
  CloseHandle(Overlapped.hEvent);
end;


end.  *
