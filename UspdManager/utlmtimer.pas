unit utlmtimer;

interface
uses
  utlbox,utltypes,Windows, Messages,
  SysUtils, Classes;
type
   CTimer = class
   private
   m_wTime   : DWord;
   m_wOldTime: DWord;
   m_blEnable: boolean;
   m_byFor   : Byte;
   m_byFrom  : Byte;
   m_byEvent : Byte;
   m_byDir   : Byte;
   m_wSens   : Word;
   m_byBox   : Byte;
   public
   constructor Create;
   destructor Destroy; override;
   procedure SetTimer(byFor:Byte;byEvent:Byte;byDir:Byte;wSens:Word;byBox:Byte);
   procedure DoAction;
   procedure RunTimer;
   procedure OnTimer(wTime : DWord);
   procedure OffTimer;
   procedure GoTimer;
   function IsProceed : boolean;
   function IsEmpty : boolean;
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
procedure CTimer.RunTimer;
begin
   if (m_blEnable=TRUE) then
   if (m_wTime>0) then m_wTime := m_wTime-1;
   IsEmpty;
   //SendDebug('RunTimer::>'+IntToStr(m_wTime));
end;
procedure CTimer.SetTimer(byFor:Byte;byEvent:Byte;byDir:Byte;wSens:Word;byBox:Byte);
Begin
    m_byFor   := byFor;
    m_byFrom  := byFor;
    m_byEvent := byEvent;
    m_byDir   := byDir;
    m_wSens   := wSens;
    m_byBox   := byBox;
    OffTimer;
End;
procedure CTimer.DoAction;
Var
    m_sMsg:CHMessage;
Begin
    with m_sMsg do
    Begin
    m_swLen        := 9;
    m_sbyFrom      := m_byFrom;
    m_sbyFor       := m_byFor;
    m_sbyTypeIntID := 0;
    m_sbyServerID  := 0;
    m_sbyDirID     := m_byDir;
    m_swObjID      := m_wSens;
    m_sbyType      := m_byEvent;
    FPUT(m_byBox,@m_sMsg);
    End;
End;
function CTimer.IsEmpty : boolean;
begin
   if (m_wTime = 0) and (m_blEnable = TRUE) then begin
    m_blEnable := FALSE;
    DoAction;
    Result := TRUE
   end
   else
   Result := FALSE;
end;
function CTimer.IsProceed : boolean;
begin
   Result := m_blEnable;
end;
end.
