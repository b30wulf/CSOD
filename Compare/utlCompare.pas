unit utlCompare;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AdvPanel, AdvSplitter, AdvToolBtn, Menus, AdvMenus, AdvToolBar,
  ToolPanels, ImgList, AdvMenuStylers, AdvToolBarStylers, Grids, BaseGrid,
  AdvGrid, StdCtrls, ColListb, ComCtrls;

type
  TFileType = (fOBH, fCSV);
  TSL = array [0..9] of string;

  TForm1 = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvSplitter1: TAdvSplitter;
    AdvPanel2: TAdvPanel;
    AdvSplitter2: TAdvSplitter;
    AdvPanel3: TAdvPanel;
    AdvPanel4: TAdvPanel;
    AdvPanel5: TAdvPanel;
    AdvPanel6: TAdvPanel;
    AdvToolBar1: TAdvToolBar;
    AdvMainMenu1: TAdvMainMenu;
    N1: TMenuItem;
    OpenButtonRS: TAdvToolBarButton;
    AdvToolBarButton2: TAdvToolBarButton;
    ImageList: TImageList;
    StringGridRS: TAdvStringGrid;
    StringGridSS: TAdvStringGrid;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    OpenDialog: TOpenDialog;
    AdvToolBar2: TAdvToolBar;
    OpenButtonSS: TAdvToolBarButton;
    AdvToolBarButton3: TAdvToolBarButton;
    AdvToolBar3: TAdvToolBar;
    RunButton: TAdvToolBarButton;
    AdvToolBarButton4: TAdvToolBarButton;
    RichEdit: TRichEdit;
    procedure OpenButtonSSClick(Sender: TObject);
    procedure RunButtonClick(Sender: TObject);
  private
    FileName : string;

    procedure ParseFile(fileName : string; SG : TAdvStringGrid);
  public
    { Public declarations }
  end;

//  ReferenceSource RS
// SoftwareSource SS

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.OpenButtonSSClick(Sender: TObject);
var  FName : string;
begin
  if Sender = OpenButtonRS then OpenDialog.Filter := 'CSV|*.csv';
  if Sender = OpenButtonSS then OpenDialog.Filter := 'OBH|*.obh';
  FName := ExtractFilePath(Application.ExeName);
  OpenDialog.InitialDir := FName;
  if OpenDialog.Execute then begin
    FileName := OpenDialog.FileName;
    if Sender = OpenButtonRS then ParseFile(FileName, StringGridRS);
    if Sender = OpenButtonSS then ParseFile(FileName, StringGridSS);
  end;
end;

procedure ParseSTR(s : string; var SL : TSL);
var i : integer;
begin
  for i := 0 to 9 do begin
    if (i = 8) and (pos(';', s) = 0) then SL[i] := s
    else
    if (i = 9) and (pos(';', s) = 0) then SL[i] := s
    else begin
      SL[i]:=copy(s, 1, pos(';', s)-1);
      delete(s, 1, pos(';', s));
    end;
  end;
end;

procedure ClearSL(SL : TSL);
var i : integer;
begin
  for i := 0 to 9 do
    SL[i] := '';
end;

procedure TForm1.ParseFile(fileName: string; SG: TAdvStringGrid);
var F    : Textfile;
    FT   : TFileType;
    s    : string;
    SL   : TSL;
    i, j : integer;
    fa   : double;
    h    : integer;
begin
  s:=ExtractFileExt(FileName);
  if s = '.obh' then FT := fOBH;
  if s = '.csv' then FT := fCSV;
  AssignFile(F, FileName);
  Reset(F);
  ClearSL(SL);
  case FT of
    fOBH : SG.ColCount := 11;
    fCSV : SG.ColCount := 11;
  end;
  if FT = fCSV then begin
    Readln(F, S);
    delete(s, 1, pos(';', s));    
    ParseSTR(s, SL);
    for i := 0 to 9 do
      SG.cells[i+1,0] := SL[i];
  end;
  j := 1;
  while not eof(f) do begin
    Readln(F, S);
    if FT = fCSV then delete(s, 1, 1);
     ParseSTR(s, SL);
     SG.cells[0,j] := IntToStr(j);
     for i := 0 to 9 do begin
       if (FT = fCSV) and (i > 4) then begin
         fa := StrToFloat(SL[i]);
         h:=round(fa);
         SL[i]:= IntToStr(h);
       end;
       SG.cells[i+1,j] := SL[i];
     end;
     inc(j);
  end;
  CloseFile(F);
  case FT of
    fOBH : StringGridSS.RowCount:=j;
    fCSV : StringGridRS.RowCount:=j;
  end;
 
end;

procedure TForm1.RunButtonClick(Sender: TObject);
var i, j   : integer;
    sa, sb : string;
    h : integer;
begin
  h:=0;
  for i:= 1 to StringGridRS.RowCount-1 do begin
    sa := StringGridRS.Cells[2,i];
    for j := 1 to StringGridSS.RowCount-1 do begin
      sb := StringGridSS.Cells[4,j];
      if sa = sb then begin
        if StringGridRS.Cells[4,i] = '070' then
          h:=h+1;
        if (StringGridRS.Cells[7,i] = StringGridSS.Cells[7,j]) and
           (StringGridRS.Cells[8,i] = StringGridSS.Cells[8,j]) and
           (StringGridRS.Cells[9,i] = StringGridSS.Cells[9,j]) and
           (StringGridRS.Cells[10,i] = StringGridSS.Cells[10,j]) then begin
              // все параметры равны
  //           StringGridRS.SelectRange(0,9,i,i);
             RichEdit.Lines.BeginUpdate;
             RichEdit.SelStart := RichEdit.GetTextLen;
             RichEdit.SelAttributes.Color := clGreen;
             RichEdit.Lines.Add(sa + '[' + IntToStr(i) + ']' + '[' + IntToStr(j) + ']' + ' показания равны ');
             RichEdit.Lines.EndUpdate;
             StringGridRS.RowColor[i] := RGB(192, 220, 192); //clMoneyGreen;
             StringGridSS.RowColor[j] := RGB(192, 220, 192); //clMoneyGreen;
           end else begin
             StringGridRS.RowColor[i] := RGB(255, 70, 70); //clHtmPlum1;
             StringGridSS.RowColor[j] := RGB(255, 70, 70); //clHtmPlum1;
             RichEdit.Lines.BeginUpdate;
             RichEdit.SelStart := RichEdit.GetTextLen;
             RichEdit.SelAttributes.Color := clRed;
             RichEdit.Lines.Add(sa + '[' + IntToStr(i) + ']' + '[' + IntToStr(j) + ']' + ' показания НЕ равны ');
             RichEdit.Lines.EndUpdate;
           end;
      end;
    end;
  end;
end;

end.
