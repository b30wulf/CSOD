unit knsl2treeloader;

interface
uses
  Windows, Classes, SysUtils,SyncObjs,stdctrls,Controls, Forms, Dialogs,comctrls,
  utltypes,utlbox,utldatabase,knsl2treehandler,knsl5tracer;
type
    CTreeLoader = class(CTreeHandler)
    private
     procedure SetHeadEditTree;
     procedure SetPTypeEditTree;
     procedure SetMTypeEditTree;
     procedure SetChannelsEditTree;
     procedure SetGroupEditTree;
     procedure SetTariffEditTree;
    public
    SaveIndex :integer;
    public
     constructor Create(pTree : PTTreeView);
     destructor Destroy;override;
     procedure  LoadTree;
     procedure  LoadGraph(Mid:integer);
     procedure  RefreshTree(Mid:integer);
  End;
  PCTreeLoader =^ CTreeLoader;
implementation
constructor CTreeLoader.Create(pTree : PTTreeView);
Begin
    inherited Create(pTree);
End;
destructor CTreeLoader.Destroy;
Begin
    inherited;
End;
procedure CTreeLoader.LoadTree;
Begin
   // TraceL(1,0,'ExecSetTree.');
    {
    SetHeadEditTree;
    SetPTypeEditTree;
    SetMTypeEditTree;
    SetChannelsEditTree;
    SetTariffEditTree;
    SetGroupEditTree;
    ExpandTree(m_strL2SelNode);
    }
End;

procedure CTreeLoader.LoadGraph(Mid:integer);
var
rtChild0 : TTreeNode;
i:integer;
begin
  {
  if (FTree <> nil) then
  begin
   for i := 0 to FTree.Items.Count - 1 do
   begin
    if i = Mid then
    begin
    FTree.SetFocus;
    FTree.Items[i].Selected;
    rtChild0 := FTree.Selected;
    SaveIndex :=rtChild0.ImageIndex;
    rtChild0.ImageIndex := 8;
    rtChild0.SelectedIndex := 8;
    end;
   end;
   end;
   }
 end;

 procedure CTreeLoader.RefreshTree(Mid:integer);
var
rtChild0 : TTreeNode;
i:integer;
begin
{
if (FTree <> nil) then
  begin
   for i := 0 to FTree.Items.Count - 1 do
   begin
    if i = Mid then
    begin
     FTree.SetFocus;
     FTree.Items[i].Selected;
     rtChild0 := FTree.Selected;
     rtChild0.ImageIndex := SaveIndex;
     rtChild0.SelectedIndex := SaveIndex;
    end;
   end;
  end;
}
end;

procedure CTreeLoader.SetHeadEditTree;
Var
    rtChild0,rtChild1,rtChild2,rtTree: TTreeNode;
Begin
    FTree.Items.Clear;
    FTree.ReadOnly := True;
    rtChild0 := FTree.Items.Add(nil,'УСПД');                          rtChild0.ImageIndex := 12;rtChild0.SelectedIndex := 12;
    rtTree   := FTree.Items.AddChild(rtChild0,'Настройки');           rtTree.ImageIndex   := 11;rtTree.SelectedIndex   := 11;
    rtChild2 := FTree.Items.AddChild(rtChild0,'Редактор параметров'); rtChild2.ImageIndex := 5; rtChild2.SelectedIndex := 5;
                FTree.Items.AddChild(rtChild2,'Параметры');
    rtChild2 := FTree.Items.AddChild(rtChild0,'Редактор запросов');   rtChild2.ImageIndex := 6; rtChild2.SelectedIndex := 6;
                FTree.Items.AddChild(rtChild2,'Типы устройств');
    rtTree   := FTree.Items.AddChild(rtChild0,'Редактор абонентов');  rtTree.ImageIndex   := 9; rtTree.SelectedIndex   := 9;
    rtTree   := FTree.Items.AddChild(rtChild0,'Редактор каналов');    rtTree.ImageIndex   := 7; rtTree.SelectedIndex   := 7;
    rtTree   := FTree.Items.AddChild(rtChild0,'Редактор групп');      rtTree.ImageIndex   := 8; rtTree.SelectedIndex   := 8;
    rtTree   := FTree.Items.AddChild(rtChild0,'Редактор тарифов');    rtTree.ImageIndex   := 9; rtTree.SelectedIndex   := 9;
End;
procedure CTreeLoader.SetPTypeEditTree;
Var
    pTbl : QM_PARAMS;
    i    : Integer;
    pSL  : PCTreeIndex;
    strCHName : String;
Begin
   if m_pDB.GetParamsTypeTable(pTbl)=True then
    Begin
     for i:=0 to pTbl.Count-1 do
     Begin
      New(pSL);
      pSL.PKey  := pTbl.Items[i].m_swType;
      strCHName := pTbl.Items[i].m_sName;
      SetHardTreeL2(pSL,'Редактор параметров','Параметры',strCHName,False,0);
      m_blPTypeIndex[pSL.PKey] := False;
     End;
    End;
End;

procedure CTreeLoader.SetMTypeEditTree;
Var
    pTbl : QM_METERS;
    i    : Integer;
    pSL  : PCTreeIndex;
    strCHName : String;
Begin
   if m_pDB.GetMetersTypeTable(pTbl)=True then
    Begin
     for i:=0 to pTbl.m_swAmMeterType-1 do
     Begin
      New(pSL);
      pSL.PKey  := pTbl.m_sMeterType[i].m_swType;
      strCHName := pTbl.m_sMeterType[i].m_sName;
      SetHardTreeL2(pSL,'Редактор запросов','Типы устройств',strCHName,False,0);
      m_blMTypeIndex[pSL.PKey] := False;
     End;
    End;
End;

procedure CTreeLoader.SetChannelsEditTree;
Var
    pTbl1    : SL1INITITAG;
    pTbl2    : SL2INITITAG;
    pSL,pSLF : PCTreeIndex;
    i,j   : Integer;
    strCHName,strMtrName : String;
Begin
    if m_pDB.GetL1Table(pTbl1)=True then
    Begin
     for i:=0 to pTbl1.Count-1 do
     Begin
      New(pSL);
      pSL.PKey  := pTbl1.Items[i].m_sbyPortID;
      m_blPortIndex[pSL.PKey] := False;
      strCHName := pTbl1.Items[i].m_schName;
      SetHardTreeL2(pSL,'УСПД','Редактор каналов',strCHName,False,0);
      if m_pDB.GetMetersTable(pSL.PKey,pTbl2)=True then
      Begin
       for j:=0 to pTbl2.m_swAmMeter-1 do
       Begin
        New(pSLF);
        pSLF.PKey := pTbl2.m_sMeter[j].m_swMID;
        pSLF.FKey := pSL.PKey;
        //m_blMeterIndex[pSLF.PKey] := False;
        strMtrName := pTbl2.m_sMeter[j].m_schName;
        SetHardTreeL2(pSLF,'Редактор каналов',strCHName,strMtrName,False,0);
        SetHardTreeL2(pSLF,strCHName,strMtrName,'Команды',False,0);
       End;
      End;
     End;
    //ExpandTree(FTree^,m_strL2SelNode);
    End;
End;

procedure CTreeLoader.SetGroupEditTree;
Var
    pTblG    : SL3INITTAG;
    pTbl3    : SL3GROUPTAG;
    i,j      : Integer;
    pSL,pSLF : PCTreeIndex;
    strCHName,strMtrName : String;
Begin
    if m_pDB.GetGroupsTable(pTblG)=True then
    Begin
     for i:=0 to pTblG.Count-1 do
     Begin
      New(pSL);
      pSL.PKey  := pTblG.Items[i].m_sbyGroupID;
      m_blGroupIndex[pSL.PKey] := False;
      strCHName := pTblG.Items[i].m_sGroupName;
      SetHardTreeL2(pSL,'УСПД','Редактор групп',strCHName,False,0);
      if m_pDB.GetVMetersTable(pSL.PKey,pTbl3)=True then
      Begin
       for j:=0 to pTbl3.m_swAmVMeter-1 do
       Begin
        New(pSLF);
        pSLF.PKey := pTbl3.Item.Items[j].m_swVMID;
        pSLF.FKey := pSL.PKey;
        m_blVMeterIndex[pSLF.PKey] := False;
        strMtrName := pTbl3.Item.Items[j].m_sVMeterName;
        SetHardTreeL2(pSLF,'Редактор групп',strCHName,strMtrName,False,0);
        SetHardTreeL2(pSLF,strCHName,strMtrName,'Параметры',False,0);
       End;
      End;
     End;
    //ExpandTree(FTree^,m_strL3SelNode);
    End;
End;
procedure CTreeLoader.SetTariffEditTree;
Var
    pTbl : TM_TARIFFSS;
    i    : Integer;
    pSL  : PCTreeIndex;
    strCHName : String;
Begin
   if m_pDB.GetTMTarifsTable(0,0,0,pTbl)=True then
    Begin
     for i:=0 to pTbl.Count-1 do
     Begin
      New(pSL);
      pSL.PKey  := pTbl.Items[i].m_swTTID;
      strCHName := pTbl.Items[i].m_sName;
      SetHardTreeL2(pSL,'УСПД','Редактор тарифов',strCHName,False,0);
      m_blTarTypeIndex[0,0,0,pSL.PKey] := False;
     End;
    End;
End;
end.
