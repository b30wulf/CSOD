unit utlmtimer;

interface
uses
  utlbox,utltypes,Windows, Messages,
  SysUtils, Classes,utlconst, knsl3EventBox;
type
   TTmrEvent = procedure(byEvent : Byte) of object;
   CTimer = class
   private
   m_wTime   : DWord;
   m_wOldTime: DWord;
   m_blEnable: boolean;
  // m_byForAID: Byte;
   m_byFor   : Byte;
   m_byFrom  : Byte;
   m_byEvent : Byte;
   m_byDir   : Byte;
   //m_wSens   : Word;
   m_byBox   : Integer;
   FTmrEV    : TTmrEvent;
   public
   m_wSens   : Word;
   m_byForAID: Byte;
   constructor Create;
   destructor Destroy; override;
   procedure SetTimer(byFor:Byte;byEvent:Byte;byDir:Byte;wSens:Word;byBox:Integer);
   procedure SetTimerAID(byForAID:Byte;byFor:Byte;byEvent:Byte;byDir:Byte;wSens:Word;byBox:Integer);
   procedure DoAction;
   procedure RunTimer;
   procedure OnTimer(wTime : DWord);
   procedure ReRunTimer;
   procedure OffTimer;
   procedure GoTimer;
   function IsProceed : boolean;
   function IsEmpty : boolean;
   function GetState : DWord;
   procedure OnTimerEx(wTime : DWord);
   public
   property PTmrEV : TTmrEvent read FTmrEV write FTmrEV;
   end;
implementation
constructor CTimer.Create;
begin
  inherited;
  m_wTime := 0;
  m_blEnable := FALSE;
end;
destructor CTimer.Destroy;
begin
  inherited;
end;
procedure CTimer.OffTimer;
begin
   m_blEnable := FALSE;
end;
procedure CTimer.GoTimer;
begin
   if (m_wTime=0) then m_wTime := m_wOldTime;
   m_blEnable := True;
end;
procedure CTimer.OnTimer(wTime : DWord);
begin
   m_blEnable := TRUE;
   m_wTime    := wTime;
   m_wOldTime := wTime;
end;
procedure CTimer.OnTimerEx(wTime : DWord);
begin
  try
   if m_blEnable=False then
   OnTimer(wTime);
  except
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка выполнения с компонентом ' + CTimer.ClassName);
  end;
end;
procedure CTimer.ReRunTimer;
begin
  try
   m_blEnable := TRUE;
   m_wTime    := m_wOldTime;
  except
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка выполнения с компонентом ' + CTimer.ClassName);
  end;
end;
procedure CTimer.RunTimer;
begin
  try
   if (m_blEnable=TRUE) then
   if (m_wTime>0) then m_wTime := m_wTime-1;
   IsEmpty;
   //SendDebug('RunTimer::>'+IntToStr(m_wTime));
  except
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка выполнения с компонентом ' + CTimer.ClassName);
  end;
end;
procedure CTimer.SetTimer(byFor:Byte;byEvent:Byte;byDir:Byte;wSens:Word;byBox:Integer);
Begin
  try
    m_byFor   := byFor;
    m_byFrom  := byFor;
    m_byEvent := byEvent;
    m_byDir   := byDir;
    m_wSens   := wSens;
    m_byBox   := byBox;
    OffTimer;
  except
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка выполнения с компонентом ' + CTimer.ClassName);
  end;
End;
procedure CTimer.SetTimerAID(byForAID:Byte;byFor:Byte;byEvent:Byte;byDir:Byte;wSens:Word;byBox:Integer);
Begin
  try
    m_byForAID:= byForAID;
    m_byFor   := byFor;
    m_byFrom  := byFor;
    m_byEvent := byEvent;
    m_byDir   := byDir;
    m_wSens   := wSens;
    m_byBox   := byBox;
    OffTimer;
  except
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка выполнения с компонентом ' + CTimer.ClassName);
  end;
End;
procedure CTimer.DoAction;
Var
    m_sMsg:CHMessage;
Begin
  try
    with m_sMsg do
    Begin
    m_swLen        := 11;
    m_sbyFrom      := m_byFrom;
    m_sbyFor       := m_byFor;
    m_sbyTypeIntID := 0;
    m_sbyServerID  := 0;
    m_sbyDirID     := m_byDir;
    m_swObjID      := m_wSens;
    m_sbyType      := m_byEvent;
    if Assigned(PTmrEV) then PTmrEV(m_byEvent) else
    FPUT(m_byBox,@m_sMsg);
    End;
  except
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка выполнения с компонентом ' + CTimer.ClassName);
  end;
End;
function CTimer.IsEmpty : boolean;
begin
  try
   if (m_wTime = 0) and (m_blEnable = TRUE) then begin
    m_blEnable := FALSE;
    DoAction;
    Result := TRUE
   end else Result := FALSE;
  except
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка выполнения с компонентом ' + CTimer.ClassName);
  end;
end;
function CTimer.GetState:DWord;
Begin
   Result := m_wTime;
End;
function CTimer.IsProceed : boolean;
begin
   Result := m_blEnable;
end;
end.
