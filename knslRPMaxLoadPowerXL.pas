unit knslRPMaxLoadPowerXL;


interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;
type
  TRPMaxLoadPowerXL = class(TForm)
  constructor Create;
  destructor Destroy;override;

  private
    { Private declarations }
    FDB               : PCDBDynamicConn;
    FsgGrid1           : PTAdvStringGrid;
    FsgGrid2           : PTAdvStringGrid;
    globalTblTName    : array [0..4] of string;
//    m_pTariffs        : TM_TARIFFS;
    FTID              : Integer;
    globalTime        : string[20];
    globalPokazCounter: string[20];
    globalSubCounter  : string[20];
    globalRasxCounter : string[20];
    globalTimeSum     : string[20];
    globalPointName   : string;
    RasxSum           : array [0..47] of Double;
    RasxPrir          : array [0..47] of Double;
    PowerSum          : array [0..47] of Double;

    storeKoef         : array[0..99] of Double;
    globalRasxSum     : string[20];
    globalKindEnergy  : string;
    globalDate        : string[20];
    globalMaxPower    : string;
    maxSrez           : Double;
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;
    globalTitle       : string;
    prGroupID         : integer;
    FProgress         : PTProgressBar;
    FABOID            : Integer;
    function  DateOutSec(Date : TDateTime) : string;
    function  FindMaxInSrez(mas : array of Double;m_pTariffs : TM_TARIFFS) : Double;
    procedure FillReport(m_pTariffs : TM_TARIFFS);
    procedure FillReportSum(m_pTariffs : TM_TARIFFS);
    procedure FillReportMax(m_pTariffs : TM_TARIFFS);
  //  procedure LoadTariffs();
    function  IsThisTarif(Srez:byte;m_pTariffs : TM_TARIFFS):boolean;
    function  IsVMIDInTable(VMID : integer):boolean;
    procedure DeleteAll;
    procedure frReport1ManualBuild(m_pTariffs : TM_TARIFFS);
    procedure ShowHeader1();
    procedure ShowData1;
    procedure ShowHeader2;
    procedure ShowData2;
    procedure ShowData3;
    procedure FormTitle;
    Function  FindAndReplace(find_,rep_:string):boolean;
  public
    { Public declarations }
    Koef              : array [0..99] of Double;
    DateBeg           : TDateTime;
    DateEnd           : TDateTime;
    prTarifID         : integer;
    KindEnergy        : integer;
    BChecked          : boolean;
    NDogovor          : string;
    globalWorksName   : string;
    FirstSign         : string;
    ThirdSign         : string;
    SecondSign        : string;
    NameObject        : string;
    Adress            : string;
    procedure CreatReport(m_pTariffs : TM_TARIFFS);
  public
    property PDB          :PCDBDynamicConn  read FDB           write FDB;
    property PsgGrid1     :PTAdvStringGrid  read FsgGrid1      write FsgGrid1;
    property PsgGrid2     :PTAdvStringGrid  read FsgGrid2      write FsgGrid2;
    property PProgress    :PTProgressBar    read FProgress     write FProgress;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;


var
  rpMaxLoadPowerXL    : TRPMaxLoadPowerXL;
const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт)',
                                          'Вид энергии : Активная отдаваемая(кВт)',
                                          'Вид энергии : Реактивная потребляемая(кВар)',
                                          'Вид энергии : Реактивная отдаваемая(кВар)');
  strEK       : array [0..3] of string = ('кВт',
                                          'кВт',
                                          'кВар',
                                          'кВар');

implementation

constructor TRPMaxLoadPowerXL.Create;
Begin

End;

destructor TRPMaxLoadPowerXL.Destroy;
Begin
    inherited;
End;

{procedure TRPMaxLoadPowerXL.OnGetCellColorEvent(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    AFont.Name := 'Times New Roman';
    with (Sender AS TAdvStringGrid)  do
    Begin
     if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and (not(gdSelected in AState) or (gdFocused in AState)) then
     begin
      if (ACol<>0)and(ARow<>0) then ABrush.Color := clTeal;
     end;
    if (ARow=0)or(ACol=0) then
    Begin
     AFont.Size  := 9;
     AFont.Style := [fsBold];
     AFont.Color := clBlack;
    End;
     if (ARow<>0) and (ACol<>0)then
      Begin
        AFont.Size  := 10;
        AFont.Style := [fsItalic];
        case ACol of
         1,3,2,4      : AFont.Color := clAqua;
         //3          : AFont.Color := clLime;
         {
          4      : AFont.Color := clRed;
          2,5,10 : AFont.Color := clLime;
          6,7    : AFont.Color := clAqua;
          8      : AFont.Color := clWhite;
         }
 {       End;
      End;
    End;
end;}

procedure TRPMaxLoadPowerXL.DeleteAll;
var i : integer;
begin
   for i := 1 to FsgGrid2.RowCount - 1 do
   begin
     FsgGrid2.Cells[0,i] := '';
     FsgGrid2.Cells[1,i] := '';
   end;
   FsgGrid2.RowCount := 2;
end;

function TRPMaxLoadPowerXL.FindMaxInSrez(mas : array of Double;m_pTariffs : TM_TARIFFS) : Double;
var i      : byte;
    res    : Double;
    IsInit : boolean;
begin
   IsInit := false;
   for i := 0 to 47 do
     if (mas[i] > res) and (IsThisTarif(i,m_pTariffs)) then
       if IsInit then
         res := mas[i]
       else
                       begin
         res    := mas[i];
         IsInit := true;
       end;
   Result := res;
end;

function TRPMaxLoadPowerXL.DateOutSec(Date : TDateTime) : string;
var str : string;
begin
   str := TimeToStr(Date);
   SetLength(str, Length(str) - 3);
   Result := str;
end;

function TRPMaxLoadPowerXL.IsThisTarif(Srez:byte;m_pTariffs : TM_TARIFFS):boolean;
var SumS                         : word;
    Hour0, Min0, Sec0, ms0, Sum0 : word;
    Hour1, Min1, Sec1, ms1, Sum1 : word;
    i                            : byte;
begin
    SumS   := 30 * Srez;
    for i := 1 to m_pTariffs.Count - 1 do
    begin
      DecodeTime(m_pTariffs.Items[prTarifID].m_dtTime0, Hour0, Min0, Sec0, ms0);
      DecodeTime(m_pTariffs.Items[prTarifID].m_dtTime1, Hour1, Min1, Sec1, ms1);
      Sum0 := Hour0*60 + Min0;
      Sum1 := Hour1*60 + Min1;
      if Hour0 < Hour1 then
      begin
        if (SumS >= Sum0) and (SumS < Sum1) then
        begin
          result := true;
          exit;
        end;
      end
      else
      begin
        if SumS >= Sum0 then
        begin
          result := true;
          exit;
        end;
        if SumS < Sum1 then
        begin
          result :=true;
          exit;
        end;
      end;
    end;
    result := false;
end;

{procedure TRPMaxLoadPowerXL.LoadTariffs();
var i : integer;
begin
  cbTariff.Items.Clear;
  FDB.GetTMTarPeriodsTable(FTID + cbKindEnerg.ItemIndex, m_pTariffs);
  for i := 0 to m_pTariffs.Count - 1 do
 //   cbTariff.Items.Add(m_pTariffs.Items[i].m_sName + '(' + DateOutSec(m_pTariffs.Items[i].m_dtTime0) +
  //                      ' - ' + DateOutSec(m_pTariffs.Items[i].m_dtTime1) + ')');
 // cbTariff.ItemIndex := 1;
end; }

{procedure TRPMaxLoadPowerXL.Button2Click(Sender: TObject);
begin
   DeleteAll;
end; }

function  TRPMaxLoadPowerXL.IsVMIDInTable(VMID : integer):boolean;
var i : integer;
begin
   Result := false;
   for i := 1 to FsgGrid2.RowCount - 2  do
    if VMID = StrToInt(FsgGrid2.Cells[0, i]) then
      Result := true;
end;

procedure  TRPMaxLoadPowerXL.FillReport(m_pTariffs : TM_TARIFFS);//(storeKoef : array [0..99] of Double;);
var i         : byte;
    MID       : integer;
    Data      : CCDatas;
    m_pGrData : L3GRAPHDATAS;
    TempDate  : TDateTime;
begin
   FProgress.Max:= FsgGrid2.RowCount;
   for MID := 1 to FsgGrid2.RowCount - 2 do
   begin
     TempDate := DateBeg;
     globalPointName := FsgGrid2.Cells[1, MID];
     ShowHeader1;
     RasxSum[0] := 0;
     cDateTimeR.DecDate(TempDate);
     if FDB.GetGData(TempDate, TempDate, StrToInt(FsgGrid2.Cells[0, MID]),
                         QRY_NAK_EN_DAY_EP + KindEnergy, 0, Data) then
     begin
       for i := 0 to Data.Count - 1 do
        if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <> 4) then
          RasxSum[0]    := RasxSum[0] + Data.Items[i].m_sfValue;
     end;

     if not FDB.GetGraphDatas(DateBeg, DateBeg, StrToInt(FsgGrid2.Cells[0, MID]),
                              QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
     begin
       SetLength(m_pGrData.Items, 1);
       FillChar(m_pGrData.Items[0].v, 192, 0);
     end;

     if FindMaxInSrez(m_pGrData.Items[0].v,m_pTariffs)*2 > maxSrez then
       maxSrez := FindMaxInSrez(m_pGrData.Items[0].v,m_pTariffs)*2;
     for i := 0 to 47 do
     begin
       globalPokazCounter := DVLS(RasxSum[i]/Koef[MID]);
       globalSubCounter   := DVLS(m_pGrData.Items[0].v[i]/Koef[MID]);
       globalRasxCounter  := DVLS(m_pGrData.Items[0].v[i]*2);
       PowerSum[i]        := PowerSum[i] + m_pGrData.Items[0].v[i]*2;
       if i <> 47 then
         RasxSum[i + 1]     := RasxSum[i] + m_pGrData.Items[0].v[i];
       if i mod 2 = 0 then
         globalTime := IntToStr(i div 2) + ':' + '00' + ' - ' + IntToStr((i + 1) div 2) + ':' + IntToStr(((i + 1) mod 2)*30)
       else
         globalTime := IntToStr(i div 2) + ':' + IntToStr((i mod 2)*30) + ' - ' + IntToStr((i + 1) div 2) + ':' + '00';
       if IsThisTarif(i,m_pTariffs) then
       ShowData1;
      end;
      FProgress.Position := MID;
   end;
end;   

procedure TRPMaxLoadPowerXL.FillReportSum(m_pTariffs : TM_TARIFFS);
var i : byte;
begin
  ShowHeader2;
  for i := 0 to 47 do
  begin
    if i mod 2 = 0 then
      globalTimeSum := IntToStr(i div 2) + ':' + '00' + ' - ' + IntToStr((i + 1) div 2) + ':' + IntToStr(((i + 1) mod 2)*30)
    else
      globalTimeSum := IntToStr(i div 2) + ':' + IntToStr((i mod 2)*30) + ' - ' + IntToStr((i + 1) div 2) + ':' + '00';
    globalRasxSum := DVLS(PowerSum[i]);
    if IsThisTarif(i,m_pTariffs) then
    ShowData2;
  end;
end;

procedure TRPMaxLoadPowerXL.FillReportMax(m_pTariffs : TM_TARIFFS);
begin
   if BChecked then
     maxSrez := FindMaxInSrez(PowerSum,m_pTariffs);
   globalMaxPower := 'Максимальная мощность равна: ' + DVLS(maxSrez);
   ShowData3;
end;

Function  TRPMaxLoadPowerXL.FindAndReplace(find_,rep_:string):boolean;
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

procedure TRPMaxLoadPowerXL.FormTitle();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',globalWorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTitle);
        FindAndReplace('KindEnergy',strEnergy[KindEnergy]);
        FindAndReplace('Date',DateToStr(DateBeg));
end;

procedure TRPMaxLoadPowerXL.ShowData1();
begin
      a_:=a_+1;
      Excel.ActiveSheet.Cells[a_,1].Value := globalTime;
      Excel.ActiveSheet.Cells[a_,2].Value := globalPokazCounter;
      Excel.ActiveSheet.Cells[a_,3].Value := globalSubCounter;
      Excel.ActiveSheet.Cells[a_,4].Value := globalRasxCounter;
end;
procedure TRPMaxLoadPowerXL.ShowHeader1();
begin
       a_:=a_+1;
       Excel.ActiveSheet.Cells[a_,1].Value := 'Точка учета: ' + globalPointName;
       a_:=a_+1;
       Excel.ActiveSheet.Cells[a_,1].Value := 'Время';
       Excel.ActiveSheet.Cells[a_,2].Value := 'Показание счетчика';
       Excel.ActiveSheet.Cells[a_,3].Value := 'Разность';
       Excel.ActiveSheet.Cells[a_,4].Value := 'Расход';

end;
procedure TRPMaxLoadPowerXL.ShowHeader2();
begin
      a_:=a_+1;
       Excel.ActiveSheet.Cells[a_,1].Value := 'Время';
       Excel.ActiveSheet.Cells[a_,2].Value := 'Суммарный расход';
end;
procedure TRPMaxLoadPowerXL.ShowData2();
begin
      a_:=a_+1;
      Excel.ActiveSheet.Cells[a_,1].Value := globalTimeSum;
      Excel.ActiveSheet.Cells[a_,2].Value := globalRasxSum;

end;
procedure TRPMaxLoadPowerXL.ShowData3();
begin
      a_:=a_+1;
      Excel.ActiveSheet.Range['A'+IntToStr(a_)+':D'+IntToStr(a_)].Select;
      Excel.ActiveSheet.Range['A'+IntToStr(a_)+':D'+IntToStr(a_)].Merge;
      Excel.ActiveSheet.Cells[a_,1].Value := globalMaxPower + ' ' + strEK[KindEnergy];
end;

procedure TRPMaxLoadPowerXL.frReport1ManualBuild(m_pTariffs : TM_TARIFFS);
var i : integer;
begin
  FProgress.Create(Owner);
  FProgress.Visible := true;
  a_:= 7;
  for i := 0 to 47 do
    PowerSum[i] := 0;
  maxSrez := 0;
  globalTitle :='Акт проверки нагрузки энергосистемы';
  FormTitle;
  FillReport(m_pTariffs);
  if BChecked then
  FillReportSum(m_pTariffs);
  FillReportMax(m_pTariffs);
   Excel.ActiveWorkBook.WorkSheets[1].Range['A8:D'+IntToStr(a_)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle         :=1;//устанавливаем границы
  // Excel.Selection.Borders.Weight           := xlMedium;
   Excel.Selection.HorizontalAlignment       :=-4108;
   Excel.Selection.WrapText:=true;
   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$7 ';// при печати на каждой странице ввыводится шапка
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
      FsgGrid1 := nil;
      FsgGrid2 := nil;
      FProgress.Visible := false;
      FProgress.Enabled := false;
      FProgress := nil;
     end;
end;
end;

procedure TRPMaxLoadPowerXL.CreatReport(m_pTariffs : TM_TARIFFS);

begin
   Page := 1;
   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('На компьютере отсутствует MS Office Excell или не та версия', mtWarning, [mbOK], 0);
   end;
   Excel.Application.EnableEvents := false;
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPMaxLoadPowerXL.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 1;
   Sheet := Excel.Sheets.item[Page];
   Sheet.Name := 'Нагрузка';
   frReport1ManualBuild(m_pTariffs);//(storeKoef);
end;


end.
