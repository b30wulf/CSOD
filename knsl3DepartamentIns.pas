unit knsl3DepartamentIns;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AdvToolBar, AdvToolBarStylers, ImgList, AdvAppStyler, StdCtrls, ExtCtrls,
  AdvPanel, GradientLabel, jpeg, RbDrawCore, RbButton, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers,utlconst,utlbox,utltypes,utldatabase,knsl5config,
  AdvProgressBar, AdvOfficeButtons, AdvOfficePager, Grids, BaseGrid, AdvGrid, AdvOfficePagerStylers,
  AdvSmoothButton, Spin, AdvGroupBox, ComCtrls, AdvGlowButton,utldynconnect, Menus,
  rtflabel;

type
  Tknsl3DepartamenIns = class(TForm)
    aop_AbonPages: TAdvOfficePager;
    aop_AbonAttributes: TAdvOfficePage;
    AdvPanel3: TAdvPanel;
    Label1: TLabel;
    RTFLabel1: TRTFLabel;
    btn_DepartamentDel: TRbButton;
    GroupBox1: TGroupBox;
    Label14: TLabel;
    btn_DepartamentAdd: TRbButton;
    DepartamEsName: TEdit;
    AdvRegionES: TAdvStringGrid;
    AdvProgressBar1: TAdvProgressBar;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    cmbPullAbon: TComboBox;
    AdvDepartamentES: TAdvStringGrid;
    Label2: TLabel;
    Label3: TLabel;
    Code: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure btn_DepartamentAddClick(Sender: TObject);
    procedure btn_DepartamentDelClick(Sender: TObject);
    procedure AdvRegionESClickCell(Sender: TObject; ARow, ACol: Integer);

  private
    { Private declarations }
     m_treeID        : CTreeIndex;
     FTreeModuleData : TTreeView;
     RegID           : Integer; //ID ������� ��� �������
     procedure RefreshDepTable;
  public
    { Public declarations }
  procedure ClearTable;
  procedure ClearTableDep;
  procedure setTreeIndex(index:CTreeIndex);
  procedure setTreeData(value:TTreeView);
  procedure OnAddDepartament;

  end;

var
  knsl3DepartamenIns: Tknsl3DepartamenIns;

implementation

{$R *.DFM}
procedure Tknsl3DepartamenIns.setTreeIndex(index:CTreeIndex);
Begin
     m_treeID := index;
End;


procedure Tknsl3DepartamenIns.setTreeData(value:TTreeView);
Begin
     FTreeModuleData := value;
End;


procedure Tknsl3DepartamenIns.OnAddDepartament;
Begin
    // OnCreateAbonSettings(self);
End;

///���������� ������� ������������� ��������� �� ��/////////
procedure Tknsl3DepartamenIns.FormActivate(Sender: TObject);
var
pTable:SL3REGIONS;
i:Integer;
res:boolean;
begin
res:=false;
RegID:=-1; //��� �������� �� ����������
 m_pDB.GetRegionsTable(pTable);
 if (pTable.Count=0) then exit;
 ClearTable;
  for i := 0 to pTable.Count-1 do
    begin
      if pTable.Items[i].m_nRegionID=500 then res:=true; //�� ���������� 500 ������ (�� �����������)
    end;

   if res=true then
      AdvRegionES.RowCount:= pTable.Count// ���� 500 ������ ���� �� �� ���� +1
   else
      AdvRegionES.RowCount:= pTable.Count+1;

   for i := 0 to pTable.Count-1 do
    begin
      if pTable.Items[i].m_nRegionID=500 then begin continue;end; //�� ���������� 500 ������ (�� �����������)
      AdvRegionES.Cells[0,i+1]:=IntToStr(i+1);
      AdvRegionES.Cells[1,i+1]:= pTable.Items[i].m_nRegNM;
    end;
end;
///////////////////////////////////////////////////////////////

////////������� ������� ��������////////////////////////////////////////
procedure Tknsl3DepartamenIns.ClearTable;
var i, j: Integer;
begin
with AdvRegionES do
  for i:=FixedCols to ColCount-1 do
  for j:=FixedRows to RowCount-1 do
    Cells[i, j]:='';
end;
///////////////////////////////////////////////////////////////

//////���������� ������ ������� � �� //////////////////////////
procedure Tknsl3DepartamenIns.btn_DepartamentAddClick(Sender: TObject);
var
res:boolean;
begin
if (RegID<>-1) then
 begin
   if (DepartamEsName.Text<>'')and(Code.Text<>'')then
    begin
     res:=m_pDB.SetDepTable(RegID,StrToInt(Code.Text),DepartamEsName.Text);
       if (res=false)then
          MessageDlg('������������� ������� ���������!', mtInformation, [mbOk], 0)
       else
          MessageDlg('������������� ��� ����������!', mtInformation, [mbOk], 0);
     RefreshDepTable;
     DepartamEsName.Text:='';
     Code.Text:='';
    end
   else MessageDlg('��������� ��� ���� ��� ����������!', mtInformation, [mbOk], 0);
 end
else MessageDlg('�������� ����� � ������� ����� �������� �������������!', mtInformation, [mbOk], 0);
end;
///////////////////////////////////////////////////////////////

//////////�������� ������� �� �������/////////////////////////
procedure Tknsl3DepartamenIns.btn_DepartamentDelClick(Sender: TObject);
var
res:boolean;
begin
if MessageDlg('�� ������������� ������ ������� �������������?! ����� � ���������� ��������� ����� ���� �������� ��� ������� ����� ���� �������!!!', mtInformation, [mbYes, mbNo], 0)= mrYes then
  begin
  if (AdvDepartamentES.Row=0)then
     begin
       MessageDlg('��� ������������� ��� ��������!', mtInformation, [mbOk], 0);
       exit;
     end;
    res:=m_pDB.DelDepTable(AdvDepartamentES.Cells[1,AdvDepartamentES.Row]);
    RefreshDepTable;
      if(res=true) then
        MessageDlg('������������� ������� �������!', mtInformation, [mbOk], 0)
      else MessageDlg('������������� �� �������!', mtInformation, [mbOk], 0);
  end;
end;

///////////////////////////////////////////////////////////////



///���������� ������� ������������� ��������� �� ��/////////
procedure Tknsl3DepartamenIns.RefreshDepTable;
var
pTable:SL3DEPARTAMENTS;
i:Integer;
res:boolean;
begin
  res:=m_pDB.GetDepartamentsTable(RegID, pTable);
  ClearTableDep;
  if (pTable.Count=0) then
  begin
  AdvDepartamentES.RowCount:= pTable.Count+2;
  exit;
  end;
  AdvDepartamentES.RowCount:= pTable.Count+1;  //+1
   for i := 0 to pTable.Count-1 do
    begin
      AdvDepartamentES.Cells[0,i+1]:= IntToStr(i+1);
      AdvDepartamentES.Cells[1,i+1]:= pTable.Items[i].m_sName;
      AdvDepartamentES.Cells[2,i+1]:= pTable.Items[i].code;
    end;


end;
///////////////////////////////////////////////////////////////

////////������� ������� �������������////////////////////////////////////////
procedure Tknsl3DepartamenIns.ClearTableDep;
var i, j: Integer;
begin
with AdvDepartamentES do
  for i:=FixedCols to ColCount-1 do
  for j:=FixedRows to RowCount-1 do
    Cells[i, j]:='';
end;
///////////////////////////////////////////////////////////////


procedure Tknsl3DepartamenIns.AdvRegionESClickCell(Sender: TObject; ARow,
  ACol: Integer);
var
pTable:SL3DEPARTAMENTS;

res:boolean;
i, j: Integer;
begin
  //res:=m_pDB.DelRegTable(AdvRegionES.Cells[1,AdvRegionES.Row]);

  m_pDB.GetIdRegTable(RegID,AdvRegionES.Cells[1,ARow]);
  if (RegID=-1)then  MessageDlg('������������� �� ������� ��� �� ����������!!', mtInformation, [mbOk], 0)
  else
  begin
    res:=m_pDB.GetDepartamentsTable(RegID, pTable);
    if (pTable.Count=0) then
    begin
    MessageDlg('��� ������������� � ������!!!', mtInformation, [mbOk], 0);
    AdvDepartamentES.RowCount:= pTable.Count+2; //+1
    RefreshDepTable;
    exit;
    end;
    AdvDepartamentES.RowCount:= pTable.Count+1; //+1
     for i := 0 to pTable.Count-1 do
      begin
      AdvDepartamentES.Cells[0,i+1]:= IntToStr(i+1);
      AdvDepartamentES.Cells[1,i+1]:= pTable.Items[i].m_sName;
      AdvDepartamentES.Cells[2,i+1]:= pTable.Items[i].code;
      end;
  end;
end;
                
end.
