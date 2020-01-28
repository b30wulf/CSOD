unit knsl4a2000module;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,knsl4automodule,knsl3EventBox;
type
    CA2000Module = class(CHIAutomat)
    public
     procedure InitAuto(var pTable : SL1TAG);override;
     function SelfHandler(var pMsg : CMessage):Boolean;override;
     function LoHandler(var pMsg : CMessage):Boolean;override;
     function HiHandler(var pMsg : CMessage):Boolean;override;
     procedure RunAuto;override;
    End;
implementation
procedure CA2000Module.InitAuto(var pTable : SL1TAG);
Begin

End;
function CA2000Module.SelfHandler(var pMsg : CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    if pMsg.m_sbyType=AL_REPMSG_TMR then
    if EventBox<>Nil then EventBox.FixMessage(ET_CRITICAL,'(__)CL4MD::>A2K SLF:',pMsg);
    m_nRepTimer.OnTimer(m_sbyRepTime);
    Result := res;
End;
function CA2000Module.LoHandler(var pMsg : CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    if EventBox<>Nil then EventBox.FixMessage(ET_CRITICAL,'(__)CL4MD::>A2K LOH:',pMsg);
    Result := res;
End;
function CA2000Module.HiHandler(var pMsg : CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    if EventBox<>Nil then EventBox.FixMessage(ET_CRITICAL,'(__)CL4MD::>A2K HIH:',pMsg);
    Result := res;
End;
procedure CA2000Module.RunAuto;
Begin
    //m_nRepTimer.RunTimer;
End;
end.
 