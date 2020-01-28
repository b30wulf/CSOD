unit utlSpeedTimer;

interface
uses
  utlbox,utltypes,Windows, Messages,
  SysUtils, Classes;
type
TCallback = procedure of object;

   CSpeedTimer = class
   private
     m_wTime     : DWord;
     m_wOldTime  : DWord;
     m_blEnable  : boolean;
   public
     CallBackFNC : TCallback;
     constructor Create;
     destructor Destroy; override;
     procedure SetTimer(CallBackFNC : TCallBack);
     procedure DoAction;
     procedure RunTimer;
     procedure OnTimer(wTime : DWord);
     procedure OffTimer;
     procedure GoTimer;
     function IsProceed : boolean;
     function IsEmpty : boolean;
     function GetState : DWord;
   end;
implementation
constructor CSpeedTimer.Create;
begin
  inherited;
  m_wTime := 0;
  m_blEnable := FALSE;
end;
destructor CSpeedTimer.Destroy;
begin
  inherited;
end;
procedure CSpeedTimer.OffTimer;
begin
   m_blEnable := FALSE;
end;
procedure CSpeedTimer.GoTimer;
begin
   if (m_wTime=0) then m_wTime := m_wOldTime;
   m_blEnable := True;
end;
procedure CSpeedTimer.OnTimer(wTime : DWord);
begin
   m_blEnable := TRUE;
   m_wTime    := wTime;
   m_wOldTime := wTime;
end;
procedure CSpeedTimer.RunTimer;
begin
   if (m_blEnable=TRUE) then
   if (m_wTime>0) then m_wTime := m_wTime-1;
   IsEmpty;
   //SendDebug('RunTimer::>'+IntToStr(m_wTime));
end;
procedure CSpeedTimer.SetTimer(CallBackFNC : TCallBack);
Begin
   OffTimer;
End;
procedure CSpeedTimer.DoAction;
Begin
   if Assigned(CallBackFNC) then
     CallBackFNC;
End;
function CSpeedTimer.IsEmpty : boolean;
begin
   if (m_wTime = 0) and (m_blEnable = TRUE) then begin
    m_blEnable := FALSE;
    DoAction;
    Result := TRUE
   end
   else
   Result := FALSE;
end;
function CSpeedTimer.GetState:DWord;
Begin
   Result := m_wTime;
End;
function CSpeedTimer.IsProceed : boolean;
begin
   Result := m_blEnable;
end;
end.
