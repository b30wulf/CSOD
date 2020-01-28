unit knslRPSostavGroupXL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;

type
  TRPSostavGroupXL = class(TForm)
  constructor Create;
  destructor Destroy;override;
   private
    { Private declarations }
    globalGroupName   : string;
    globalAbonentInfo : string;
    globalExpression  : string;
    FsgGrid           : PTAdvStringGrid;
    VMeters           : SL3GROUPTAG;
    FDB               : PCDBDynamicConn;
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;
    FProgress         : PTProgressBar;
    FABOID            : Integer;
    procedure frReport1ManualBuild;
    procedure FormTitle;
    procedure ShowData1;
    procedure ShowData2;
    Function  FindAndReplace(find_,rep_:string):boolean;
  public
    { Public declarations }
    WorksName   : string;
    FirstSign   : string;
    ThirdSign   : string;
    SecondSign  : string;
    NameObject  : string;
    Adress      : string;
    procedure CreatReport();
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PProgress   :PTProgressBar  read FProgress         write FProgress;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;

var
  rpSostavGroupXL: TRPSostavGroupXL;

implementation

constructor TRPSostavGroupXL.Create;
Begin

End;

destructor TRPSostavGroupXL.Destroy;
Begin
    inherited;
End;

procedure TRPSostavGroupXL.CreatReport;
begin
   Page := 1;
   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('На компьютере отсутствует MS Office Excell или не та версия', mtWarning, [mbOK], 0);
   end;
   Excel.Application.EnableEvents := false;
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPSostavGroup.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 1;
   Sheet := Excel.Sheets.item[Page];
   Sheet.Name := 'Состав групп';
   frReport1ManualBuild;
end;

Function  TRPSostavGroupXL.FindAndReplace(find_,rep_:string):boolean;
 var range:variant;
begin
FindAndReplace:=false;
if find_<>'' then begin
   try
   range:=Excel.Range['A1:EL230'].Replace(What:=find_,Replacement:=rep_);
   FindAndReplace:=true;
   except
   FindAndReplace:=false;
   end;
   end;
End;

procedure TRPSostavGroupXL.FormTitle();
begin
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);

end;
procedure TRPSostavGroupXL.ShowData1;
begin
   a_ := a_+ 1;
   Excel.ActiveSheet.Cells[a_,1].Value := globalGroupName;
   Excel.ActiveSheet.Cells[a_,2].Value := globalExpression;
end;

procedure TRPSostavGroupXL.ShowData2;
begin
   a_ := a_+ 1;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':B'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':B'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,1].Value := globalAbonentInfo;
end;

procedure TRPSostavGroupXL.frReport1ManualBuild();
var i, j      : word;
    Groups    : SL3INITTAG;
begin
   FProgress.Create(Owner);
   FProgress.Visible := true;
   a_:=5;
   FormTitle;
   FDB.GetAbonGroupsTable(FABOID,Groups);
   FProgress.Max:= Groups.Count;
   for i := 0 to Groups.Count - 1 do
   begin
     FProgress.Position := i;
     FDB.GetVMetersTable(FABOID,Groups.Items[i].m_sbyGroupID, VMeters);
     globalGroupName   := Groups.Items[i].m_sGroupName;
     globalExpression  := Groups.Items[i].m_sGroupExpress;
     ShowData1;
     for j := 0 to VMeters.m_swAmVMeter - 1 do
     begin
       if VMeters.Item.Items[j].m_sbyType = MET_SUMM then
         continue;
       globalAbonentInfo := VMeters.Item.Items[j].m_sVMeterName;
       ShowData2;
     end;
   end;
   Excel.ActiveWorkBook.WorkSheets[1].Range['A6:B'+IntToStr(a_)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle         :=1;//устанавливаем границы
//   Excel.Selection.Borders.Weight           := xlMedium;
   Excel.Selection.WrapText:=true;
   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$5 ';// при печати на каждой странице ввыводится шапка
   Excel.ActiveSheet.PageSetup.LeftFooter :='&8'+FirstSign + SecondSign + ThirdSign;
 try
      FProgress.Position:=0;
      Excel.Visible := true;
    finally
     if not VarIsEmpty(Excel) then
    begin
      //Excel.Quit;
      Excel := Unassigned;
      Sheet := Unassigned;
      //FsgGrid := nil;
      FProgress.Visible := false;
      FProgress.Enabled := false;
      FProgress := nil;
     end;
end;
end;

end.
