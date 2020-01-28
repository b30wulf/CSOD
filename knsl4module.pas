unit knsl4module;

interface
uses
    Windows, Classes, SysUtils, Forms, SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,extctrls,
    utldatabase,
    knsl4automodule,
    knsl4a2000module,
    knsl4c12module,
    knsl4btimodule,
    knsl4cc301module,
    knsl4ConfMeterModule,
    knsl4EKOMmodule,
    knsl3EventBox,
//    knsl5tracer,
    knsl4ECOMcrqsrv,
    knsl4transit,
    utlThread;
type
    CL4Module = class(CThread)
    private
     m_nLID         : Byte;
     m_sbyAmArm     : Byte;
     m_byLayerState : Byte;
     m_pHiAutomat   : array[0..30] of CHIAutomat;
     m_sIniTbl      : SL1INITITAG;
     m_nMsg         : CMessage;
     FTimer         : TTimer;
     crq            : Array[0..50] of CEcomCrqSrv;
    public
     procedure CreateECOMcrqsrv;
     procedure Init;
     procedure DoHalfTime(Sender:TObject);
     procedure OnHandler;
    private
     //procedure DoHalfTime(Sender:TObject);dynamic;
     procedure Execute; override;
     function EventHandler(var pMsg : CMessage):Boolean;
    End;
var
    mL4Module : CL4Module = nil;
implementation
procedure CL4Module.OnHandler;
Begin
     EventHandler(m_nMsg);
End;
procedure CL4Module.Execute;
Begin
    FDEFINE(BOX_L4,BOX_L4_SZ,True);
    while not Terminated do
    Begin
     FGET(BOX_L4,@m_nMsg);
      if m_nL4Synchronize=1  then Synchronize(OnHandler) else
      if m_nL4Synchronize<>1 then EventHandler(m_nMsg);
     //TraceM(4,m_nMsg.m_swObjID,'(__)CL4MD::>MSG::>',@m_nMsg)
     //EventHandler(m_nMsg);
     //Synchronize(OnHandler);
    End;
End;
{
  HIP_A2K = 0;
  HIP_C12 = 1;
  HIP_BTI = 2;
}

procedure CL4Module.CreateECOMcrqsrv;
Var
    i    : Integer;
    pTable : SL3ABONS;
Begin
    m_pDB.GetAbonsTableNS(pTable);
    for i := 0 to pTable.Count - 1 do
      Begin
        if pTable.Items[i].m_strOBJCODE<>'' then
          if StrToInt(pTable.Items[i].m_strOBJCODE) < 65536 then
            Begin
              crq[i] :=  CEcomCrqSrv.Create;
              crq[i].Init(StrToInt(pTable.Items[i].m_strOBJCODE));
              crq[i].Run;
            end;
      end;
end;

procedure CL4Module.Init;
Var
    i,j : Integer;
Begin
    mL4Module := self;
    FreeOnTerminate := True;
    {j := 0;
    if m_pDB.GetL1Table(m_sIniTbl)=True then
    Begin
     CreateECOMcrqsrv;
     i := 0;
     m_sbyAmArm := m_sIniTbl.Count + 1;
     for i:=0 to m_sIniTbl.Count-1 do
     Begin
      case m_sIniTbl.Items[i].m_sbyProtID of
        //HIP_ACC: m_pHiAutomat[i]^ := CACC301Module.Create;
        //HIP_A2K: m_pHiAutomat[i]^ := CA2000Module.Create;
        DEV_C12_SRV:
         Begin
           if not Assigned(m_pHiAutomat[j]) then m_pHiAutomat[j] := CC12Module.Create;
           m_pHiAutomat[j].SetBox(BOX_L4);
           m_sIniTbl.Items[i].m_sbyPortNum := j;
           m_pHiAutomat[j].m_sbyID         := j;
           m_pHiAutomat[j].Init(m_sIniTbl.Items[i]);

           m_sL4ConTag.Items[j].m_sbyID    := j;
           m_sL4ConTag.Items[j].m_sbyCliID := j;
           m_sL4ConTag.Items[j].m_schName  := m_sIniTbl.Items[i].m_schName;
           m_sL4ConTag.Items[j].m_sbyPortID:= m_sIniTbl.Items[i].m_sbyPortID;
           m_sL4ConTag.Items[j].m_sbyProtID:= m_sIniTbl.Items[i].m_sbyProtID;
           m_sL4ConTag.Items[j].m_schPhone := m_sIniTbl.Items[i].m_schPhone;

           Inc(j);
           m_sL4ConTag.Count := j;
         End;
        DEV_TRANSIT:
        Begin
          if not Assigned(m_pHiAutomat[j]) then m_pHiAutomat[j] := CTransitModule.Create;
          m_pHiAutomat[j].SetBox(BOX_L4);
          m_sIniTbl.Items[i].m_sbyPortNum := j;
          m_pHiAutomat[j].m_sbyID         := j;
          m_pHiAutomat[j].Init(m_sIniTbl.Items[i]);

          m_sL4ConTag.Items[j].m_sbyID    := j;
          m_sL4ConTag.Items[j].m_sbyCliID := j;
          m_sL4ConTag.Items[j].m_schName  := m_sIniTbl.Items[i].m_schName;
          m_sL4ConTag.Items[j].m_sbyPortID:= m_sIniTbl.Items[i].m_sbyPortID;
          m_sL4ConTag.Items[j].m_sbyProtID:= m_sIniTbl.Items[i].m_sbyProtID;
          m_sL4ConTag.Items[j].m_schPhone := m_sIniTbl.Items[i].m_schPhone;

          Inc(j);
          m_sL4ConTag.Count := j;
        End;
        DEV_BTI_CLI:
         Begin
          if not Assigned(m_pHiAutomat[j]) then m_pHiAutomat[j] := CBTIModule.Create;
           m_pHiAutomat[j].SetBox(BOX_L4);
           m_sIniTbl.Items[i].m_sbyPortNum := j;
           m_pHiAutomat[j].m_sbyID          := j;
           m_pHiAutomat[j].Init(m_sIniTbl.Items[i]);

           m_sL4ConTag.Items[j].m_sbyID     := j;
           m_sL4ConTag.Items[j].m_sbyCliID  := j;
           m_sL4ConTag.Items[j].m_schName   := m_sIniTbl.Items[i].m_schName;
           m_sL4ConTag.Items[j].m_sbyPortID := m_sIniTbl.Items[i].m_sbyPortID;
           m_sL4ConTag.Items[j].m_sbyProtID := m_sIniTbl.Items[i].m_sbyProtID;
           m_sL4ConTag.Items[j].m_schPhone  := m_sIniTbl.Items[i].m_schPhone;


           //if m_sIniTbl.Items[i].m_sbyProtID=DEV_ECOM_SRV_CRQ then
           //Begin
           // if not Assigned(m_nCRQ) then m_nCRQ := CEcomCrqSrv.Create;
           // m_nCRQ.Init(m_sIniTbl.Items[i]);
           // m_nCRQ.Run;
           //End;


           Inc(j);
           m_sL4ConTag.Count := j;
         End;
         DEV_UDP_CC301:
          Begin
           if not Assigned(m_pHiAutomat[j]) then m_pHiAutomat[j] := CACC301Module.Create;
           m_pHiAutomat[j].SetBox(BOX_L4);
           m_sIniTbl.Items[i].m_sbyPortNum := j;
           m_pHiAutomat[j].m_sbyID         := j;
           m_pHiAutomat[j].Init(m_sIniTbl.Items[i]);
           m_sL4ConTag.Items[j].m_sbyID     := j;
           m_sL4ConTag.Items[j].m_sbyCliID  := j;
           m_sL4ConTag.Items[j].m_schName   := m_sIniTbl.Items[i].m_schName;
           m_sL4ConTag.Items[j].m_sbyPortID := m_sIniTbl.Items[i].m_sbyPortID;
           m_sL4ConTag.Items[j].m_sbyProtID := m_sIniTbl.Items[i].m_sbyProtID;
           m_sL4ConTag.Items[j].m_schPhone  := m_sIniTbl.Items[i].m_schPhone;
           Inc(j);
           m_sL4ConTag.Count := j;
          End;
         DEV_ECOM_SRV :
          Begin
           If Not Assigned(m_pHiAutomat[j]) Then m_pHiAutomat[j] := CEKOMModule.Create;
           m_pHiAutomat[j].SetBox(BOX_L4);
           m_sIniTbl.Items[i].m_sbyPortNum := j;
           m_pHiAutomat[j].m_sbyID := j;
           m_pHiAutomat[j].Init(m_sIniTbl.Items[i]);
           m_sL4ConTag.Items[j].m_sbyID := j;
           m_sL4ConTag.Items[j].m_sbyCliID := j;
           m_sL4ConTag.Items[j].m_schName := m_sIniTbl.Items[i].m_schName;
           m_sL4ConTag.Items[j].m_sbyPortID := m_sIniTbl.Items[i].m_sbyPortID;
           m_sL4ConTag.Items[j].m_sbyProtID := m_sIniTbl.Items[i].m_sbyProtID;
           m_sL4ConTag.Items[j].m_schPhone := m_sIniTbl.Items[i].m_schPhone;
           Inc(j);
           m_sL4ConTag.Count := j;
          End;
      End;
          End;
     if not Assigned(m_pHiAutomat[j]) then m_pHiAutomat[j] := TConfMeterAuto.Create;
     m_pHiAutomat[j].SetBox(BOX_L4);
     m_pHiAutomat[j].m_sbyID          := j;
     m_pHiAutomat[j].Init(m_sIniTbl.Items[i-1]);
     m_sL4ConTag.Items[j].m_sbyID     := j;
     m_sL4ConTag.Items[j].m_sbyCliID  := j;
     Inc(j);
     m_sL4ConTag.Count := j;
      End;
      m_sbyAmArm := j; }
    Priority := tpHigher;
    Resume;
End;
function CL4Module.EventHandler(var pMsg : CMessage):Boolean;
var i : integer;
Begin
    try
    case pMsg.m_sbyFor of
      DIR_L3TOL4,DIR_L4TOL4,DIR_ARTOL4,DIR_L4TOAR,DIR_L1TOL2:
       if pMsg.m_swObjID<m_sbyAmArm then
         m_pHiAutomat[pMsg.m_swObjID].EventHandler(pMsg);
      DIR_LMETOL4:
       begin
        if pMsg.m_sbyType = AL_STOPL2_IND then
          for i:=0 to m_sbyAmArm-1 do
            m_pHiAutomat[i].EventHandler(pMsg);
       end;
      DIR_L1TOL4:
       begin
        case pMsg.m_sbyType of
             QL_START_TRANS_REQ,
             QL_STOP_TRANS_REQ : for i:=0 to m_sbyAmArm-1 do m_pHiAutomat[i].EventHandler(pMsg);
        End;
       end;
    End;
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL4MD::>Error In CL4Module.EventHandler!!!');
    End;
End;
procedure CL4Module.DoHalfTime(Sender:TObject);
Var
    i : Integer;
Begin
    //FTimer.Interval := 1000;
    //TraceL(4,0,'(__)CL4MD::>Timer Routing.');
    try
     for i:=0 to m_sbyAmArm-1 do
       if m_pHiAutomat[i] <> nil then
         m_pHiAutomat[i].Run;
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL4MD::>Error In CL4Module.DoHalfTime!!!');
    End
End;
end.
