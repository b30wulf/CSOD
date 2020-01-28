unit knsl1editor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knseditnd,knsl1module,
  knsl2module;
type
    CL1Editor = class
    Private
     FTreeModule : PTTreeView;
     m_byTrState : Byte;
     constructor Create;
     procedure OnExecute(Sender: TObject);
    Protected
     m_nPageIndex : Integer;
     procedure OnClickTree;
     procedure OnEditNode;
     procedure OnAddNode;
     procedure OnDeleteNode;
    Public
     property PTreeModule  :PTTreeView  read FTreeModule  write FTreeModule;
     property PPageI       :Integer     read FTreeModule  write FTreeModule;
    End;
implementation
constructor CL1Editor.Create;
Begin

End;
procedure CL1Editor.OnClickTree;
var
    nNode   : TTreeNode;
Begin
    nNode := FTreeModule.Selected;
    if (nNode<>Nil) then
    Begin
     if nNode.Text='Уровень №1' then
     Begin
      frmEditNode.pcEditNode.ActivePageIndex := m_nPageIndex;
      m_byTrState := LID_L1;
     End;
    End;
end;
procedure CL1Editor.OnEditNode;
begin
    m_byTrEditMode                  := ND_EDIT;
    frmEditNode.POnCreateNode       := OnExecute;
    frmEditNode.clbEditNode.Caption := 'Редактирование канала';
    Show;
end;
procedure CL1Editor.OnAddNode;
begin
    m_byTrEditMode                  := ND_ADD;
    frmEditNode.POnCreateNode       := OnExecute;
    frmEditNode.clbEditNode.Caption := 'Создание канала';
    Show;
end;
procedure CL1Editor.OnDeleteNode;
Begin
    m_byTrEditMode                  := ND_DEL;
    frmEditNode.POnCreateNode       := OnExecute;
    frmEditNode.clbEditNode.Caption := 'Удаление канала';
    Show;
End;
{
Var
   pL1:SL1TAG;
   pSL:PSL1TAG;
   strNodeName : String;
Begin
   //Заполнить структуру SL1TAG из формы
   strNodeName := 'COM1';


   if frmEditNode.m_byTrEditMode=ND_EDIT then mL1Module.EditNodeLv(pL1);
   if frmEditNode.m_byTrEditMode=ND_ADD  then
   Begin
    //New(pSL);Move(pL1,pSL^,sizeof(SL1TAG));
    //SetHardTreeL2(pSL,'УСПД','Уровень №1',strNodeName,False);
    //pL1Module.AddNodeLv(pL1);
   End;
   //pL1Module.Init;
   //if frmEditNode.m_byTrEditMode=ND_ADD  then SetTree;
End;
}
procedure CL1Editor.ExecEditData;
Begin
    TraceL(1,0,'ExecEditData.');

End;
procedure CL1Editor.ExecAddData;
Begin
    TraceL(1,0,'ExecAddData.');

End;
procedure CL1Editor.ExecDelData;
Begin
    TraceL(1,0,'ExecDelData.');

End;
procedure CL1Editor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');

End;
procedure CL1Editor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');

End;
procedure CL1Editor.OnExecute(Sender: TObject);
Begin
    //TraceL(5,0,'OnExecute.');
    case m_byTrEditMode of
     ND_EDIT : ExecEditData;
     ND_ADD  : ExecAddData;
     ND_DEL  : ExecDelData;
    end;
    ExecSetTree;
    ExecInitLayer;
End;
end.
