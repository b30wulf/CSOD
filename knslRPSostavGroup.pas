unit knslRPSostavGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utltypes, utldatabase, utlTimeDate, utlconst;

type
  TrpSostavGroup = class(TForm)
    frReport1   : TfrReport;
    frDesigner1 : TfrDesigner;
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
    globalGroupName   : string;
    globalAbonentInfo : string;
    globalExpression  : string;
    FsgGrid           : PTAdvStringGrid;
    VMeters           : SL3GROUPTAG;
    FDB               : PCDBDynamicConn;
    FABOID            : Integer;
  public
    { Public declarations }
    WorksName   : string;
    FirstSign   : string;
    ThirdSign   : string;
    SecondSign  : string;
    NameObject  : string;
    Adress      : string;
    m_strObjCode: string;
    procedure PrepareTable;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure PrintPreview();
    procedure OnFormResize;
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;

var
  rpSostavGroup: TrpSostavGroup;

implementation

{$R *.DFM}

procedure TrpSostavGroup.PrepareTable;
var Groups : SL3INITTAG;
    i      : integer;
begin
   if FsgGrid=Nil then
     exit;
   FsgGrid.ColCount   := 2;
   FsgGrid.Cells[0,0] := '№ п.п';
   FsgGrid.Cells[1,0] := 'Наименование группы';
   FsgGrid.ColWidths[0]  := 30;
   SetHigthGrid(FsgGrid^,20);
   if not FDB.GetAbonGroupsTable(FABOID,Groups) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Groups.Count + 1;
     for i := 0 to Groups.Count - 1 do
     begin
       FsgGrid.Cells[0, i + 1] := IntToStr(Groups.Items[i].m_sbyGroupID);
       FsgGrid.Cells[1, i + 1] := Groups.Items[i].m_sGroupName;
     end;
   end;
   OnFormResize;
end;

procedure TrpSostavGroup.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
   for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TrpSostavGroup.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TrpSostavGroup.PrintPreview();
begin
   frReport1.ShowReport;
end;

procedure TrpSostavGroup.frReport1ManualBuild(Page: TfrPage);
var i, j      : word;
    Groups    : SL3INITTAG;
begin
   Page.ShowBandByType(btReportTitle);
   FDB.GetAbonGroupsTable(FABOID,Groups);
   for i := 0 to Groups.Count - 1 do
   begin
     FDB.GetVMetersTable(FABOID,Groups.Items[i].m_sbyGroupID, VMeters);
     globalGroupName   := Groups.Items[i].m_sGroupName;
     globalExpression  := Groups.Items[i].m_sGroupExpress;
     Page.SHowBandByName('MasterData1');
     for j := 0 to VMeters.m_swAmVMeter - 1 do
     begin
       {if VMeters.Item.Items[j].m_sbyType = MET_SUMM then
         continue;    }
       globalAbonentInfo := '[' + IntToStr(VMeters.Item.Items[j].m_swVMID) + ']:' + VMeters.Item.Items[j].m_sVMeterName;
       Page.ShowBandByName('MasterData2');
     end;
   end;
   Page.ShowBandByName('PageFooter1');
end;

procedure TrpSostavGroup.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'WorksName'   then ParValue := WorksName;
   if ParName = 'FirstSign'   then ParValue := FirstSign;
   if ParName = 'SecondSign'  then ParValue := SecondSign;
   if ParName = 'ThirdSign'   then ParValue := ThirdSign;
   if ParName = 'GroupName'   then ParValue := globalGroupName;
   if ParName = 'AbonentInfo' then ParValue := globalAbonentInfo;
   if ParName = 'Expression'  then ParValue := globalExpression;
   if ParName = 'm_strObjCode'then Parvalue := m_strObjCode;
   if ParName = 'NameObject'  then begin ParValue := NameObject; exit; end;
   if ParName = 'Adress'      then begin ParValue := Adress; exit; end;

end;

end.
