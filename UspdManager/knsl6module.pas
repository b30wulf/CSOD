unit knsl6module;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,extctrls,
    knsl6shellmodule,
    knsl5tracer;

type
    CL6Module = class(TThread)
    private
     m_nLID         : Byte;
     m_sbyAmArm     : Byte;
     m_byLayerState : Byte;
     m_pShellAutomat: CShellAutomat;
     m_nMsg         : CMessage;
     FTimer         : TTimer;
    public
     procedure Init;
     procedure DoHalfTime(Sender:TObject);
     procedure OnHandler;
    private
     procedure Execute; override;
     function EventHandler(var pMsg : CMessage):Boolean;
    End;
var
    mL6Module : CL6Module;
implementation
procedure CL6Module.OnHandler;
Begin
     EventHandler(m_nMsg);
End;
procedure CL6Module.Execute;
Begin
    FDEFINE(BOX_L4,BOX_L4_SZ,True);
    while true do
    Begin
     FGET(BOX_L4,@m_nMsg);
     OnHandler;
     //TraceM(4,m_nMsg.m_swObjID,'(__)CL4MD::>MSG::>',@m_nMsg)
     //TraceL(4,0,'(__)CL4MD::>MSG::>');
     //Synchronize(OnHandler);
     //Sleep(1000);
    End;
End;
procedure CL6Module.Init;
Var
    i,j : Integer;
Begin
    mL6Module := self;
    m_pShellAutomat := CShellAutomat.Create;
    Priority := tpNormal;
    Resume;
End;
function CL6Module.EventHandler(var pMsg : CMessage):Boolean;
var i : integer;
Begin
    try
    case pMsg.m_sbyFor of
      DIR_L1TOL6,DIR_L6TOL6,DIR_ULTOL6:
      m_pShellAutomat.EventHandler(pMsg);
    End;
    except
     TraceER('(__)CL4MD::>Error In CL6Module.EventHandler!!!');
    End;
End;
procedure CL6Module.DoHalfTime(Sender:TObject);
Var
    i : Integer;
Begin
    try
     m_pShellAutomat.Run;
    except
     TraceER('(__)CL4MD::>Error In CL6Module.DoHalfTime!!!');
    End
End;
end.
 