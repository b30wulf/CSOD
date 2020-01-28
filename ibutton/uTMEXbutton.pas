unit uTMEXbutton;

interface
uses classes, Windows, iBTMEXPW, Sysutils;

type
  TibItem = record
    NUM : integer;
    ID : array[0..8] of SmallInt;
  end;
  pTibItem = ^TibItem;

  TibList = class(TComponent)
  private
    FList : TList;
    FSetup : boolean;
    FPort : Smallint;
    FSessionActive : boolean;
    SHandle : Longint;
    FExclusive : boolean;
    FOnSession : TNotifyEvent;
    HMutex : THandle;
    FPortType : Smallint;
    function GetItems(index : integer) : pTibItem;
    procedure SetItems(index : integer; const Value : pTibItem);
    procedure SetPort(const Value : Smallint);
    procedure SetOnSession(const Value : TNotifyEvent);
    function GetCount : integer;
    procedure SetPortType(const Value : Smallint);
  public
    PortTypes : array[0..15] of SmallInt;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function Init : boolean;
    function ScanDevices(FullScan : boolean) : integer;
    function DeviceGetData(channel : integer; addr, cnt : integer; var data : array of byte) : integer;
    function DeviceSetData(channel : integer; addr, cnt : integer; data : array of byte) : integer;
    function StartSession(TOT : integer) : boolean;
    function StopSession : boolean;
    function DeviceName(channel : integer) : string;
    property Setup : boolean read FSetup;
    property Devices[index : integer] : pTibItem read GetItems write SetItems;
    property SessionActive : boolean read FSessionActive;
    property Exclusive : boolean read FExclusive;
    property Count : integer read GetCount;
  published
    property Port : Smallint read FPort write SetPort;
    property PortType : Smallint read FPortType write SetPortType;
    property OnSession : TNotifyEvent read FOnSession write SetOnSession;
  end;
procedure Register;
//======================================================
implementation
//======================================================

procedure Register;
begin
  RegisterComponents('System', [TibList]);
end;

{ TibList }

constructor TibList.Create(AOwner : TComponent);
var
  MutexName         : string;
  i, cnt            : integer;
  buf               : array[0..200] of Char;
begin
   { dynamically label the available drivers }
  cnt := 0;
  for i := 0 to 15 do begin
    if (TMGetTypeVersion(i, @buf) > 0) then begin
         //DeviceTab.Tabs.Add(' ' + getToken(StrPas(buf),TOKEN_DEV) + ' ');
      PortTypes[cnt] := i;
      Inc(cnt);
    end;
  end;

  FList := TList.Create;
  MutexName := 'TMEX_SESSION_ACTIVE';
  HMutex := CreateMutex(nil, false, PChar(MutexName));
  FSessionActive := false;
  FSetUp := false;
  FPort := 1;
  inherited;
  //Init;
end;

destructor TibList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TibList.DeviceGetData(channel : integer; addr, cnt : integer; var data : array of byte) : integer;
var
  pgs, adrs, PgSize, j, a : SmallInt;
  b                 : byte;
begin // read from iButton
  result := -1;
  // test init
  if FSetup or Init then begin
  // test channel
    if channel < FList.count then begin
   //SHandle := TMExtendedStartSession(FPort,1,nil);
      if StartSession(150) then begin
        TMRom(SHandle, @StateBuf, @Devices[channel].ID[0]);
        if (TMStrongAccess(SHandle, @StateBuf) > 0) then begin
          PgSize := 32;
          pgs := addr div PgSize;
          adrs := addr mod PgSize;
          TMTouchByte(SHandle, $F0); //read CMD
          TMTouchByte(SHandle, (pgs shl 5) and $FF);
          TMTouchByte(SHandle, (pgs shr 3) and $FF);
          a := 0;
          for j := 0 to cnt + Adrs - 1 do begin
            b := Byte(TMTouchByte(SHandle, $FF));
            if (j >= adrs) then begin
              data[a] := b;
              inc(a);
            end;
          end;
          result := a;
        end;
        if not FExclusive then StopSession;
      end;
    end;
  end;
end;

function TibList.DeviceName(channel : integer) : string;
var
  i                 : integer;
  s                 : string;
begin
  s := '';
  if (channel < FList.Count) then begin
    for i := 0 to 7 do s := s + IntToHex(Devices[channel].ID[i], 2);
  end;
  result := s;
end;

function TibList.DeviceSetData(channel : integer; addr, cnt : integer;
  data : array of byte) : integer;
var
  i, a, p, pgs, pge, sa, ea : smallint;
begin
  result := -1;
  // test init
  if FSetup or Init then begin
  // test channel
    if (channel < FList.count) and StartSession(100) then begin
   //SHandle := TMExtendedStartSession(FPort,1,nil);

      pgs := addr div 32;
      pge := (addr + cnt - 1) div 32;
      a := 0;
      for p := pgs to pge do begin
        if p = pgs then sa := addr mod 32 else sa := 0;
        if p = pge then ea := (addr + cnt - 1) mod 32 else ea := 31;

        TMRom(SHandle, @StateBuf, @Devices[channel].ID[0]);
        if (TMStrongAccess(SHandle, @StateBuf) > 0) then begin
          TMTouchByte(SHandle, $0F); //WRITE
         { addr 1 }
          TMTouchByte(SHandle, (p * 32 + sa) and $FF);
         { addr 2 }
          TMTouchByte(SHandle, ((p * 32 + sa) shr 8) and $FF);
          for i := sa to ea do begin
            if (TMTouchByte(SHandle, SmallInt(data[a])) < 0) then Break;
            inc(a);
          end;
          result := a;
        end;
        TMRom(SHandle, @StateBuf, @Devices[channel].ID[0]);
        if (TMStrongAccess(SHandle, @StateBuf) > 0) then begin
         { copy scratch command }
          TMTouchByte(SHandle, $55);
         { address 1 }
          TMTouchByte(SHandle, (p * 32 + sa) and $FF);
         { address 2 }
          TMTouchByte(SHandle, ((p * 32 + sa) shr 8) and $FF);
         { send offset }
          TMTouchByte(SHandle, (ea mod 32));
         { get the result of the copy }
          i := TMTouchByte(SHandle, $FF);
          if ((i and $F0) <> $00) then
            result := 0
          else
            result := a;
        end;
      end;
      if not FExclusive then StopSession;
    end;
  end;
end;

function TibList.GetCount : integer;
begin
  result := FList.Count;
end;

function TibList.GetItems(index : integer) : pTibItem;
begin //
  if index < FList.Count then
    result := pTibItem(FList.Items[index])
  else result := nil;
end;

function TibList.Init : boolean;
begin
   //SHandle := TMExtendedStartSession(FPort,1,nil);
  StartSession(1000);
  FSetUp := (TMSetup(SHandle) > 0);
   //TMEndSession(SHandle);
  if not FExclusive then StopSession;
  result := FSetUp;
end;

function TibList.ScanDevices(FullScan : boolean) : integer;
var
  i                 : integer;
  p                 : pTibItem;
begin //
  if (not FSetup) then begin
    Init;
  end;
//SHandle := TMExtendedStartSession(FPort,1,nil);
// If (SHandle > 0) Then Begin
  if (StartSession(1000)) then begin
    FullScan := (FullScan or (FList.Count = 0));
    if FullScan then begin
      for I := 1 to FList.Count do begin
        p := FList[I - 1];
        dispose(p);
      end;
      FList.Clear;
      i := 0;
      while ((i = 0) and (TMFirst(SHandle, @StateBuf) > 0)) or (TMNext(SHandle, @StateBuf) > 0) do begin
        new(p);
        p^.NUM := i;
        p^.ID[0] := 0;
        TMRom(SHandle, @StateBuf, @p^.ID);
        FList.Add(p);
        inc(i);
      end;
    end else begin // test list
      for i := FList.Count - 1 downto 0 do begin
        TMRom(SHandle, @StateBuf, @Devices[i].ID[0]);
        if (TMStrongAccess(SHandle, @StateBuf) <= 0) then begin
          FList.Delete(i);
        end;
      end;
    end;
    if not FExclusive then StopSession;
  end;
  result := FList.count;
end;

procedure TibList.SetItems(index : integer; const Value : pTibItem);
begin //
  if index in [0..FList.Count] then FList.Items[index] := Value;
end;

procedure TibList.SetOnSession(const Value : TNotifyEvent);
begin
  FOnSession := Value;
end;

procedure TibList.SetPort(const Value : Smallint);
begin
  FPort := Value;
  FSetup := false;
  ScanDevices(true);
end;

procedure TibList.SetPortType(const Value : Smallint);
begin
  FPortType := Value;
  FSetup := false;
  ScanDevices(true);
end;

function TibList.StartSession(TOT : integer) : boolean;
var
  wsa               : boolean;
begin
  Result := false;      
  if FSessionActive then exit;
  wsa := FSessionActive;
  FExclusive := (TOT <= 0);
  TOT := abs(TOT);
  FSessionActive := (WaitForSingleObject(HMutex, TOT) <> Wait_TimeOut);
  if FSessionActive then begin
    SHandle := TMExtendedStartSession(FPort, FPortType, nil);
    FSessionActive := (SHandle > 0);
    if (not FSessionActive) and (HMutex = 0) then begin
      ReleaseMutex(HMutex);
      HMutex := 0;
    end;
  end;
  if assigned(OnSession) and (wsa <> FSessionActive) then OnSession(self);
  result := FSessionActive;
end;

function TibList.StopSession : boolean;
var
  wsa               : boolean;
begin
  wsa := FSessionActive;
  TMEndSession(SHandle);
  if HMutex <> 0 then begin
    ReleaseMutex(HMutex);
    HMutex := 0;
  end;
  FSessionActive := false;
  if assigned(OnSession) and (wsa <> FSessionActive) then OnSession(self);
  result := not FSessionActive;
end;


end.

