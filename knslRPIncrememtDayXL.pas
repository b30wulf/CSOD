unit knslRPIncrememtDayXL;

interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;
type
  TrpIncrementDayXL = class(TForm)
  constructor Create;
  destructor Destroy;override;
 private
    { Private declarations }
    m_ID              : integer;
    FsgGrid           : PTAdvStringGrid;
    GroupID           : integer;
    FABOID            : integer;
    glKoef            : extended;
    MeterN            : string;
    glEnergMB         : array [1..4] of extended;
    glEnergME         : array [1..4] of extended;
    glEnergRazn       : array [1..4] of extended;
    glEnergRasx       : array [1..4] of extended;
    glMB              : string[15];
    glME              : string[15];
    globalTitle       : string;
    globalMeterName   : string;
    glSum             : array [1..4] of string;
    SumEnergy         : array [0..3,1..4] of extended;
    globalTblMeter    : string;
    glKindEn          : string;
    globalTblDate     : string[15];
    glCountTable      : integer;
    glCountTableShow  : string;
    DateReport        : TDateTime;
    FDB               : PCDBDynamicConn;
    IsLastPage        : boolean;
    AllMeter          : string;
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;
    FProgress         : PTProgressBar;
    Fm_nEVL            : CEvaluator;
    sExpr             : string;
    sExpr1            : array [0..3,1..4] of string;
    SumFormula        : array [0..3,1..4] of extended;
    procedure FormTitle;
    Function  FindAndReplace(find_,rep_:string):boolean;
    procedure ShowData1;
    procedure ShowData2;
    procedure ShowHeader1;
    procedure FillReport(MID : integer);
    procedure FillReportTtl(KindEN : byte);
    procedure frReport1ManualBuild;
    function  Replace(Str, X, Y: string): string;
    procedure FindValueFormula(tarif:integer;KindEn: byte;mid:string);
    procedure FormTitle2;
  public
    { Public declarations }
    KindEnergy   : byte;
    FirstSign    : string;
    SecondSign   : string;
    ThirdSign    : string;
    WorksName    : string;
    Telephon     : string;
    EMail        : string;
    NDogovor     : string;
    NameObject   : string;
    Adress       : string;
    IsReadZerT   : boolean;
    procedure CreatReport(Date : TDateTime;CountTable:integer);

  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   :integer read GroupID write GroupID;
    property PABOID      :integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PProgress   :PTProgressBar  read FProgress         write FProgress;
    property Pm_nEVL      :CEvaluator        read fm_nEVL          write fm_nEVL;
  end;

var
  rpIncrementDayXL: TrpIncrementDayXL;
  IsFirstLoad  : boolean = true;
const
  strEnergy   : array [0..3] of string = ('��� ������� : �������� ������������(���*�)',
                                          '��� ������� : �������� ����������(���*�)',
                                          '��� ������� : ���������� ������������(����*�)',
                                          '��� ������� : ���������� ����������(����*�)');

 IndEn       : array [0..3] of string = ('�������� ������������(���*�)',
                                          '�������� ����������(���*�)',
                                          '���������� ������������(����*�)',
                                          '���������� ����������(����*�)');

implementation

constructor TrpIncrementDayXL.Create;
Begin

End;

destructor TrpIncrementDayXL.Destroy;
Begin
    inherited;
End;


procedure TrpIncrementDayXL.CreatReport(Date : TDateTime;CountTable:integer);
begin
   Page := 1;
   DateReport := Date;
   glCountTable := CountTable;
   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('�� ���������� ����������� MS Office Excell ��� �� �� ������', mtWarning, [mbOK], 0);
   end;
   Excel.Application.EnableEvents := false;
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPIncrememtDay.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 1;
   Sheet := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
   Sheet.Name := '���������� �� ����';
   frReport1ManualBuild;
end;

function TrpIncrementDayXL.Replace(Str, X, Y: string): string;
var
  buf1, buf2, buffer: string;
  i: Integer;

begin
  buf1 := '';
  buf2 := Str;
  Buffer := Str;
  while Pos(X, buf2) > 0 do
  begin
    buf2 := Copy(buf2, Pos(X, buf2), (Length(buf2) - Pos(X, buf2)) + 1);
    buf1 := Copy(Buffer, 1, Length(Buffer) - Length(buf2)) + Y;
    Delete(buf2, Pos(X, buf2), Length(X));
    Buffer := buf1 + buf2;
  end;
  Replace := Buffer;
end;

Function  TrpIncrementDayXL.FindAndReplace(find_,rep_:string):boolean;
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

procedure TrpIncrementDayXL.FormTitle();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTitle);
        FindAndReplace('#CountTbl&',glCountTableShow);
        FindAndReplace('DateTtlB',glMB);

end;

procedure TrpIncrementDayXL.FormTitle2();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTitle);
end;

procedure TrpIncrementDayXL.ShowData1;
begin
   a_ := a_+ 1;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':D'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':D'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,1].Value := glKindEn;

   Excel.ActiveSheet.Cells[a_+1,1].Value := 'T1';
   Excel.ActiveSheet.Cells[a_+1,2].Value := RVLPr(glEnergMB[1], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+1,3].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+1,4].Value := RVLPr(glEnergRazn[1], MeterPrecision[m_ID]);
   //
   Excel.ActiveSheet.Cells[a_+2,1].Value := 'T2';
   Excel.ActiveSheet.Cells[a_+2,2].Value := RVLPr(glEnergMB[2], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+2,3].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+2,4].Value := RVLPr(glEnergRazn[2], MeterPrecision[m_ID]);
   //
   Excel.ActiveSheet.Cells[a_+3,1].Value := 'T3';
   Excel.ActiveSheet.Cells[a_+3,2].Value := RVLPr(glEnergMB[3], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+3,3].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+3,4].Value := RVLPr(glEnergRazn[3], MeterPrecision[m_ID]);
   //
   Excel.ActiveSheet.Cells[a_+4,1].Value := '����� �� �������';
   Excel.ActiveSheet.Cells[a_+4,2].Value := RVLPr(glEnergMB[4], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+4,3].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+4,4].Value := RVLPr(glEnergRazn[4], MeterPrecision[m_ID]);
   a_:= a_+ 4;
end;

procedure TrpIncrementDayXL.ShowHeader1;
begin
   a_ := a_+1;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':B'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['B'+IntToStr(a_)+':B'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,1].Value := globalMeterName;

   Excel.ActiveSheet.Range['C'+IntToStr(a_)+':D'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['C'+IntToStr(a_)+':D'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,3].Value := MeterN;
end;

procedure TrpIncrementDayXL.FindValueFormula(tarif:integer;KindEn: byte;mid:string);
var
 stReplace : string;
 i:byte;
begin
 stReplace := 'v'+mid + '_P';
 if tarif <> 6 then
 begin
   sExpr1[KindEn][tarif] := replace(sExpr1[KindEn][tarif],stReplace,FloatTostr(abs(SumFormula[KindEn][tarif])));
 end
 else
 begin
 for i :=1 to 4 do
   sExpr1[KindEn][i] := replace(sExpr1[KindEn][i],stReplace,'0');
 end;
end;

procedure TrpIncrementDayXL.FillReport(MID : integer);
var Data                : CCDatas;
    KindEn              : byte;
    Year, Month, Day, i,r : word;
    TempDate            : TDateTime;
    param               : extended;
    nTypeID,swPLID,nMaxT: Integer;

begin
   TempDate := DateReport;
    globalMeterName := '����� ����� :' + FsgGrid.Cells[1, MID];
    MeterN          := '��. ��. �' + FsgGrid.Cells[2, MID];
    AllMeter        :=  AllMeter + FsgGrid.Cells[1, MID] + ',';
    AllMeter        :=  replace(AllMeter,'  ', '');
    m_ID            := StrToInt(FsgGrid.Cells[0, MID]);
    nMaxT  := 3;
    swPLID := 0;
    FDB.GetMeterType(m_ID,nTypeID,swPLID);
    if swPLID=1 then nMaxT:=2;
    ShowHeader1;

for KindEn := 0 to 3 do
   begin

     glKindEn := strEnergy[KindEn];
     glKoef   := StrToFloat(FsgGrid.Cells[3, MID]);

    for i := 1 to 4 do
     begin
       glEnergMB[i]   := 0;
       glEnergRazn[i] := 0;
     end;

     if not FDB.GetGData(TempDate, TempDate, StrToInt(FsgGrid.Cells[0, MID]),
                         QRY_ENERGY_DAY_EP + KindEn, 0, Data) then
     begin
       FindValueFormula(6,KindEn,FsgGrid.Cells[0, MID]);
       ShowData1;
       continue;
     end;
    for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin
         glEnergMB[Data.Items[i].m_swTID] := RVLPr(Data.Items[i].m_sfValue/glKoef, MeterPrecision[m_ID]);
         if (IsReadZerT){ or (swPLID=1)} then
           glEnergMB[4] := glEnergMB[4] + glEnergMB[Data.Items[i].m_swTID];
       end
       else
         if (not IsReadZerT) and (Data.Items[i].m_swTID = 0) then //������ �������� ������ �� ��
           glEnergMB[4] := RVLEx(Data.Items[i].m_sfValue/glKoef, glKoef);
      {   glEnergMB[4] := glEnergMB[4] + glEnergMB[Data.Items[i].m_swTID];
       end;}

     for i := 1 to 4 do
     begin
       glEnergRazn[i] := RVLPr(glEnergMB[i], MeterPrecision[m_ID])*glKoef;
       SumEnergy[KindEn][i] := SumEnergy[KindEn][i] + glEnergRazn[i];
       SumFormula[KindEn][i] := glEnergRazn[i];
       FindValueFormula(i,KindEn,FsgGrid.Cells[0, MID]);
     end;
     ShowData1;
   end;
end;

procedure TrpIncrementDayXL.FillReportTtl(KindEN : byte);
var i : byte;
begin
 glKindEn := IndEn[KindEn];
   for i := 1 to 4 do
   begin
   if  sExpr <> '[x]' then
   begin
   try
       fm_nEVL.Expression :=  sExpr1[KindEn][i];  //�������
       if fm_nEVL.Value < 0 then glSum[i] := '�/�' else
       glSum[i] := FloatToStr(RVLPr(fm_nEVL.Value, MaxPrecision));
   except
        MessageDlg('������ � �����������',mtWarning,[mbOk,mbCancel],0);
        exit;
   end;
   end
   else
   if SumEnergy[KindEn][i] < 0 then glSum[i] := '�/�' else
   glSum[i] := FloatToStr(RVLPr(SumEnergy[KindEn][i], MaxPrecision));
   end;
     ShowData2;
end;

procedure  TrpIncrementDayXL.ShowData2;
begin
   a_ :=a_ + 1;
    Excel.ActiveSheet.Cells[a_,3].Value := glSum[1];
   a_ :=a_ + 1;
    Excel.ActiveSheet.Cells[a_,3].Value := glSum[2];
   a_ :=a_ + 1;
    Excel.ActiveSheet.Cells[a_,3].Value := glSum[3];
   a_ :=a_ + 1;
    Excel.ActiveSheet.Cells[a_,3].Value := glSum[4];
end;

procedure TrpIncrementDayXL.frReport1ManualBuild;
var i,j                : integer;
    Month,Month1, Year,Year1, Day : word;
    TempDate         : TDateTime;
    pGT : SL3GROUPTAG;
begin
 ////������������� //�������
 sExpr := m_pDB.GetMSGROUPEXPRESS(FABOID,GroupID,pGT);
 fm_nEVL.Expression := sExpr;
 for i:=1 to 4 do
    for j:=0 to 3 do
       sExpr1[j][i] := sExpr;
 //////////////
   FProgress.Create(Owner);
   FProgress.Visible := true;
   a_ := 11;
   AllMeter :='';
   IsLastPage := false;
    for i := 0 to 3 do
     for j := 1 to 4 do
      SumEnergy[i][j] := 0;
   TempDate  := DateReport;
   DecodeDate(DateReport, Year, Month, Day);
   globalTitle := '�������� � �����������/������ ������� � ' +
                                            cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' ����';

   glMB := DateToStr(DateReport);
   glCountTableShow := '������� � ' + IntToStr(glCountTable);
   FormTitle();
   FProgress.Max:= FsgGrid.RowCount;
   for i := 1 to FsgGrid.RowCount - 1 do
   begin
   FProgress.Position := i;
   FillReport(i);
   glCountTableShow := '������� � ' + IntToStr(glCountTable) + '(�����������)';
   end;
   delete(AllMeter, length(AllMeter), 1);
   AllMeter := AllMeter + '.';

   Excel.ActiveWorkBook.WorkSheets[1].Range['c12:D'+IntToStr(a_)].Select;//�������� ��� �������
   Excel.Selection.Borders.LineStyle         :=1;//������������� �������
  // Excel.Selection.Borders.Weight           := xlMedium;
   Excel.Selection.HorizontalAlignment       :=-4108;
   Excel.Selection.WrapText:=true;
   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$11 ';// ��� ������ �� ������ �������� ���������� �����
   Excel.ActiveSheet.PageSetup.LeftFooter :='&8'+FirstSign + SecondSign + ThirdSign;
   Page := Page + 1;
   Sheet := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
   Sheet.Name := '��������� ������' + IntToStr(Page);
   FormTitle2;
   SetLength(AllMeter,(length(AllMeter)-1));
   Excel.ActiveSheet.Cells[8,1].Value := AllMeter;
   a_:= 11;
    for i := 0 to 3 do
     FillReportTtl(i);
   Excel.ActiveSheet.PageSetup.LeftFooter :='&8'+FirstSign + SecondSign + ThirdSign;
 try
      FProgress.Position :=0;
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
      //fm_nEVL.Free;
     end;
end;
end;


end.
