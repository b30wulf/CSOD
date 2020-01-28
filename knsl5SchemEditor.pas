unit knsl5SchemEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, paramtreeview, utldatabase, knsL5setcolor, AdvPanel,
  AdvAppStyler, ExtCtrls, knsl5config, AdvMenus, AdvMenuStylers, utltypes,
  AdvGlowButton, StdCtrls, Menus;

type
  TTSchemEditor = class(TForm)
    AdvPanel4: TAdvPanel;
    SchemView: TParamTreeview;
    SchemStyler: TAdvFormStyler;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    edFormName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edPathToFile: TEdit;
    edFormID: TEdit;
    Label3: TLabel;
    AdvGlowButton1: TAdvGlowButton;
    OpenDialog1: TOpenDialog;
    btnSaveNode: TAdvGlowButton;
    pmSchemEdit: TAdvPopupMenu;
    miAddMenu: TMenuItem;
    miAddForm: TMenuItem;
    miDelete: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SchemViewClick(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure miAddMenuClick(Sender: TObject);
    procedure miDeleteClick(Sender: TObject);
    procedure btnSaveNodeClick(Sender: TObject);
    procedure miAddFormClick(Sender: TObject);
  private
    { Private declarations }
    mSchemTable : SL3SCHEMTABLES;
    IndexArr    : array of integer;
    procedure LoadTreeView;
    procedure FindSubMenu(var TreeNode : TTreeNode; SubNodeNum : integer);
    function  GenerateNewIndex:integer;
    function  GenerateSubNewIndex:integer;
  public
    { Public declarations }
  end;                         

var
  TSchemEditor: TTSchemEditor;

implementation

{$R *.DFM}

procedure TTSchemEditor.FormShow(Sender: TObject);
begin
   LoadTreeView;
end;

procedure TTSchemEditor.LoadTreeView;
var i    : integer;
    Node : TTreeNode;
begin
   SchemView.Items.Clear;
   m_pDB.GetSchemsTable(mSchemTable);
   SetLength(IndexArr, mSchemTable.Count);
   for i := 0 to mSchemTable.Count - 1 do
   begin
     if (mSchemTable.Items[i].m_swNodeNum = -1) or (mSchemTable.Items[i].m_swSubNodeNum = -1) then
     begin
       Node := SchemView.Items.Add(nil, mSchemTable.Items[i].m_sNodeName);
       Node.ImageIndex := i;
       if (mSchemTable.Items[i].m_swSubNodeNum <> -1) then
         FindSubMenu(Node, mSchemTable.Items[i].m_swSubNodeNum);
     end;
   end;
   SchemView.Selected := SchemView.Items.GetFirstNode;
   SchemViewClick(Self);
end;

procedure TTSchemEditor.FindSubMenu(var TreeNode : TTreeNode; SubNodeNum : integer);
var i           : integer;
begin
   for i := 0 to mSchemTable.Count - 1 do
     if (mSchemTable.Items[i].m_swSubNodeNum = SubNodeNum) and (mSchemTable.Items[i].m_swNodeNum <> -1) then
        SchemView.Items.AddChild(TreeNode, mSchemTable.Items[i].m_sNodeName).ImageIndex := i;
end;

procedure TTSchemEditor.FormCreate(Sender: TObject);
begin
   m_nCF.m_nSetColor.PSchemEditor := @SchemStyler;
end;

procedure TTSchemEditor.SchemViewClick(Sender: TObject);
begin
   if SchemView.Selected <> nil then
   begin
     edFormName.Text   := mSchemTable.Items[SchemView.Selected.ImageIndex].m_sNodeName;
     edPathToFile.Text := mSchemTable.Items[SchemView.Selected.ImageIndex].m_sPathToFile;
     edFormID.Text     := IntToStr(mSchemTable.Items[SchemView.Selected.ImageIndex].m_swNodeNum);
   end
   else
   begin
     edFormName.Text   := '';
     edPathToFile.Text := '';
     edFormID.Text     := '';
   end;
end;

procedure TTSchemEditor.AdvGlowButton1Click(Sender: TObject);
var PathToFile : String;
    PathToExe  : String;
    Posit      : integer;
begin
   if OpenDialog1.Execute then
   begin
     PathToFile := OpenDialog1.FileName;
     PathToExe  := ExtractFilePath(Application.ExeName);
     Posit := pos(PathToExe, PathToFile);
     if Posit > 0 then Delete(PathToFile, Posit, Length(PathToExe));
     edPathToFile.Text := PathToFile;
   end;
end;

procedure TTSchemEditor.miAddMenuClick(Sender: TObject);
var pTable : SL3SCHEMTABLE;
begin
   pTable.m_swNodeNum := -1;
   pTable.m_swSubNodeNum := GenerateSubNewIndex;
   pTable.m_sNodeName := '----';
   pTable.m_sPathToFile := '';
   m_pDB.AddSchemTable(pTable);
   LoadTreeView;
end;

procedure TTSchemEditor.miDeleteClick(Sender: TObject);
var Node : TTreeNode;
begin
   Node := SchemView.Selected;
   if Node <> nil then
   begin
     while Node.Count > 0 do
     begin
       m_pDB.DeleteSchemTable(mSchemTable.Items[Node.Item[0].ImageIndex].m_swID);
       Node.Item[0].Delete;
     end;
     m_pDB.DeleteSchemTable(mSchemTable.Items[Node.ImageIndex].m_swID);
     Node.Delete;
   end;
   LoadTreeView;
end;

procedure TTSchemEditor.miAddFormClick(Sender: TObject);
var Node   : TTreeNode;
    pTable : SL3SCHEMTABLE;
begin
   Node := SchemView.Selected;
   if (Node <> nil) and (Node.Parent = nil) then
   begin
     pTable.m_swNodeNum := GenerateNewIndex;
     pTable.m_swSubNodeNum := mSchemTable.Items[Node.ImageIndex].m_swSubNodeNum;
     pTable.m_sNodeName := '----';
     pTable.m_sPathToFile := '';
     m_pDB.AddSchemTable(pTable);
     LoadTreeView;
   end;
end;

procedure TTSchemEditor.btnSaveNodeClick(Sender: TObject);
var Node   : TTreeNode;
    pTable : SL3SCHEMTABLE;
begin
   Node := SchemView.Selected;
   if (Node <> nil) then
   begin
     pTable.m_swNodeNum    := StrToInt(edFormID.Text);
     pTable.m_swSubNodeNum := mSchemTable.Items[Node.ImageIndex].m_swSubNodeNum;
     pTable.m_sNodeName    := edFormName.Text;
     pTable.m_sPathToFile  := edPathToFile.Text;

     if (Node.Parent = nil) then
       if Length(edPathToFile.Text) > 0 then
       begin
         pTable.m_swSubNodeNum := -1;
         if StrToInt(edFormID.Text) = -1 then
           pTable.m_swNodeNum := GenerateNewIndex;
       end;
     m_PDB.UpdateSchemTable(mSchemTable.Items[Node.ImageIndex].m_swID, pTable);
     LoadTreeView;
   end;
end;

function TTSchemEditor.GenerateNewIndex:integer;
var max, i : integer;
begin
   if mSchemTable.Count = 0 then
     Result := 0
   else
   begin
     max := mSchemTable.Items[0].m_swNodeNum;
     for i := 0 to mSchemTable.Count - 1 do
       if max < mSchemTable.Items[i].m_swNodeNum then
         max := mSchemTable.Items[i].m_swNodeNum;
     Result := max + 1;
   end;
end;

function TTSchemEditor.GenerateSubNewIndex:integer;
var max, i : integer;
begin
   if mSchemTable.Count = 0 then
     Result := 0
   else
   begin
     max := mSchemTable.Items[0].m_swSubNodeNum;
     for i := 0 to mSchemTable.Count - 1 do
       if max < mSchemTable.Items[i].m_swSubNodeNum then
         max := mSchemTable.Items[i].m_swSubNodeNum;
     Result := max + 1;
   end;
end;

end.
