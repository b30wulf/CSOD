unit knslRPRasxMonthPeriod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdVCL,
  StdCtrls, ExtCtrls, ComCtrls, UtlDB, Buttons, utlconst, utlTimeDate, utlbox,
  IBExternals, IB, IBHeader, IBDatabase, IBSQL, Db, IBUtils, IBBlob, IBIntf, IBQuery
  ;

type
  TXY = record
    X : integer;
    Y : integer;
  end;

  TXLSPointerHomeBalanse = class
    xnReportName              : TXY;
    xnDogovor                 : TXY;
    xnAddress                 : TXY;
    xnPrimaryIndications      : TXY;
    xnSecondaryIndications    : TXY;
    xnNumberHouse             : Integer;
    xnConsumerLS              : Integer;
    xnConsumerName            : Integer;
    xnEnergy                  : Integer;
    xnMeterNumb               : Integer;
    xnRatio                   : Integer;
    xnPrimaryIndicationsT     : array[0..4] of integer;
    xnSecondaryIndicationsT   : array[0..4] of integer;
    xnDifferenceIndicationT   : array[0..4] of integer;
    xnPowerConsumptionT       : array[0..4] of integer;
    xnFirstRow                : Integer;
    xnTotalSummHomeT          : array[0..4] of TXY;
    xnTotalSummBalanceT       : array[0..4] of TXY;
    xnTotalSummNoBalanceT     : array[0..4] of TXY;    
  end;


  TRasxMonthPeriod = class(TForm)
    Panel1: TPanel;
    gbDailyReport: TGroupBox;
    gbPeriodReport: TGroupBox;
    rbDailyReport: TRadioButton;
    rbPeriodReport: TRadioButton;
    dtpBeginDaily: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    gbTarif: TGroupBox;
    chkTarif1: TCheckBox;
    chkTarif2: TCheckBox;
    chkTarif3: TCheckBox;
    chkTarif4: TCheckBox;
    chkTarifS: TCheckBox;
    btnCreateReport: TBitBtn;
    Label4: TLabel;
    dtpEndDaily: TDateTimePicker;
    cbbMonth: TComboBox;
    cbbYear: TComboBox;
    chkActPlus: TCheckBox;
    chkActMinus: TCheckBox;
    chkReactPlus: TCheckBox;
    chkReactMinus: TCheckBox;
    PgBar: TProgressBar;
    procedure rbReportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCreateReportClick(Sender: TObject);
  private
    TotalPowerConsumptionT  : array[0..4] of double;
    TotalPowerBalanceT      : array[0..4] of double;
    TotalPowerNoBalanceT    : array[0..4] of double;
    checkDaily  : Boolean;
    checkPeriod : Boolean;
    procedure SetEnabledGB;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RasxMonthPeriod: TRasxMonthPeriod;
  cDateTimeR : CDTRouting;

implementation

{$R *.DFM}

uses 
   { ---------------------------------------------------------------------------
   Use required TXLSFile library units
   --------------------------------------------------------------------------- }
   ShellApi,
   XLSFile,
   XLSFormat,
   XLSWorkbook, knslRPHomeBalance;

const
  EnergyTitles : array [0..3] of String = (
    'A+(кВт·ч)',
    'A-(кВт·ч)',
    'R+(кВа·ч)',
    'R-(кВа·ч)'
  );

procedure TRasxMonthPeriod.FormCreate(Sender: TObject);
var i       : Integer;
    y, m, d : Word;
begin
  DecodeDate(Now, y, m, d);
  for i := y-5 to y do
    cbbYear.Items.Add(IntToStr(i));
  cbbMonth.ItemIndex := m-1;
  cbbYear.ItemIndex := 5;
  rbReportClick(rbDailyReport);
end;

procedure TRasxMonthPeriod.rbReportClick(Sender: TObject);
begin
  if Sender = rbDailyReport then begin
    checkDaily := True;
    checkPeriod := False;
    gbDailyReport.Enabled := True;
    gbPeriodReport.Enabled:= False;
  end;
  if Sender = rbPeriodReport then begin
    checkDaily := False;
    checkPeriod := True;
    gbDailyReport.Enabled := False;
    gbPeriodReport.Enabled:= True;
  end;
  SetEnabledGB;
end;

procedure TRasxMonthPeriod.SetEnabledGB;
begin
  Label1.Enabled := gbDailyReport.Enabled;
  Label4.Enabled := gbDailyReport.Enabled;
  dtpBeginDaily.Enabled := gbDailyReport.Enabled;
  dtpEndDaily.Enabled := gbDailyReport.Enabled;

  Label2.Enabled := gbPeriodReport.Enabled;
  Label3.Enabled := gbPeriodReport.Enabled;
  cbbMonth.Enabled := gbPeriodReport.Enabled;
  cbbYear.Enabled := gbPeriodReport.Enabled;
end;



procedure TRasxMonthPeriod.btnCreateReportClick(Sender: TObject);
label ExitLabel;
var s, sKE   : string;
    i, j, iKE: integer;
    KindEn, h: integer;
    KiEn     : array[0..3] of Boolean;
    KiEnCnt  : Byte;
    TfEn     : array[0..4] of Boolean;
    TfEnCnt  : Byte;
    res      : Boolean;
    TempDate : TDateTime;
    SList    : TStringList;
    WB       : TSheet;
    xf       : TXLSFile;
    FDir     : String;
    R        : TRange;
    XLSPoint : TXLSPointerHomeBalanse;
    l_Year, l_Month, l_Day : Word;
    Date1, Date2 : string;
    IsUsePokNow : Boolean;
    m_ReportDate : TDateTime;
    m_ReportSvDate : TDateTime;
    Year, Month, Day : word;
    PH_ReportName : String;
    aboidList : TList;
    aboid     : Integer;
    CMDID     : Integer;
    TMP, x    : Integer;
    StrSQL    : string;
    nCount    : Integer;
    DateR     : array [1..4] of TDate;
    DateV     : array [1..4] of TDate;
    DC, DD, DM: TDate;
    SUMMCURR  : string;
    SUMMDAY   : string;
    DATEDAY   : string;
    DATECURR  : string;
    BeginData : TDate;
    EndDate   : TDate;
    MID, g    : integer;
    fa, fb    : double;
    Loc       : byte;
    dt        : TDate;
    sa, sb    : string;
    V_TARIFS, R_TARIFS : string;
    V_TARIF, R_TARIF   : Double;
begin
  if checkDaily then
    if dtpEndDaily.DateTime = dtpBeginDaily.DateTime then IsUsePokNow := True      //  report for Daily
    else IsUsePokNow := False;

  Year     := StrToInt(cbbYear.Items[cbbYear.ItemIndex]);
  Month    := cbbMonth.ItemIndex + 1;
  Day      := cDateTimeR.DayPerMonth(Month, Year);
  TempDate := EncodeDate(Year, Month, Day);

  m_ReportDate := now;
  if checkPeriod then m_ReportDate := TempDate
  else TempDate:= dtpEndDaily.DateTime;

  DecodeDate(m_ReportDate, l_Year, l_Month, l_Day);
  m_ReportSvDate := m_ReportDate;
  PH_ReportName := cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';

  // m_AbonentID
  XLSPoint := TXLSPointerHomeBalanse.Create;
  m_ReportDate   := Date;
  if checkPeriod then IsUsePokNow := cDateTimeR.IsDateInMonthNow(m_ReportDate);

  aboidList := TList.Create;
  aboidList.Add(Pointer(3760));
  aboidList.Add(Pointer(5262));
  aboidList.Add(Pointer(5263));
  aboidList.Add(Pointer(5266));
  aboidList.Add(Pointer(5271));

  FDir := ExtractFilePath(Application.ExeName) + 'Report\HomeBallansGroupRep.xls';
  xf:= TXLSFile.Create;
  xf.OpenFile(FDir);
  WB:= XF.Workbook.Sheets[0];


  R:= WB.Ranges.RangeByName['xnReportName'];   XLSPoint.xnReportName.X:=R.Rect[0].ColumnFrom; XLSPoint.xnReportName.Y:=R.Rect[0].RowFrom;
  R:= WB.Ranges.RangeByName['xnDogovor'];   XLSPoint.xnDogovor.X:=R.Rect[0].ColumnFrom; XLSPoint.xnDogovor.Y:=R.Rect[0].RowFrom;
  R:= WB.Ranges.RangeByName['xnAddress'];   XLSPoint.xnAddress.X:=R.Rect[0].ColumnFrom; XLSPoint.xnAddress.Y:=R.Rect[0].RowFrom;
  R:= WB.Ranges.RangeByName['xnPrimaryIndications'];   XLSPoint.xnPrimaryIndications.X:=R.Rect[0].ColumnFrom; XLSPoint.xnPrimaryIndications.Y:=R.Rect[0].RowFrom;
  R:= WB.Ranges.RangeByName['xnSecondaryIndications'];   XLSPoint.xnSecondaryIndications.X:=R.Rect[0].ColumnFrom; XLSPoint.xnSecondaryIndications.Y:=R.Rect[0].RowFrom;

  if checkPeriod then begin
    s :=WB.Cells[XLSPoint.xnReportName.Y,XLSPoint.xnReportName.X].Value;
    s := s + ' ' + PH_ReportName;
    WB.Cells[XLSPoint.xnReportName.Y,XLSPoint.xnReportName.X].Value := s;
  end else begin
    s :=WB.Cells[XLSPoint.xnReportName.Y,XLSPoint.xnReportName.X].Value;
    Delete(s,Length(s)-1,1);
    s := s + ' на ' + Date1;
    WB.Cells[XLSPoint.xnReportName.Y,XLSPoint.xnReportName.X].Value := s;
  end;


  WB.Cells[XLSPoint.xnAddress.Y,XLSPoint.xnAddress.X].Value := 'По группе абонентов';


  s:= WB.Cells[XLSPoint.xnPrimaryIndications.Y,XLSPoint.xnPrimaryIndications.X].Value;
  s := s + ' ' + date1;
  WB.Cells[XLSPoint.xnPrimaryIndications.Y,XLSPoint.xnPrimaryIndications.X].Value :=s;

  // добавить текущие дату ++
  if not IsUsePokNow then begin
    s:= WB.Cells[XLSPoint.xnSecondaryIndications.Y,XLSPoint.xnSecondaryIndications.X].Value;
    s := s + ' ' + date2;
    WB.Cells[XLSPoint.xnSecondaryIndications.Y,XLSPoint.xnSecondaryIndications.X].Value :=s;
  end;

  R:= WB.Ranges.RangeByName['xnNumberHouse']; XLSPoint.xnNumberHouse:=R.Rect[0].ColumnFrom;   // номер квартиры
  XLSPoint.xnFirstRow:=R.Rect[0].RowFrom;        // первая строка ввода

  R:= WB.Ranges.RangeByName['xnConsumerLS'];  XLSPoint.xnConsumerLS:=R.Rect[0].ColumnFrom;   // потребитель Лс

  R:= WB.Ranges.RangeByName['xnConsumerName'];  XLSPoint.xnConsumerName:=R.Rect[0].ColumnFrom;   // потребитель ФИО

  R:= WB.Ranges.RangeByName['xnEnergy'];  XLSPoint.xnEnergy:=R.Rect[0].ColumnFrom;   // Энергия (A+ A- R+ R-)

  R:= WB.Ranges.RangeByName['xnMeterNumb'];  XLSPoint.xnMeterNumb:=R.Rect[0].ColumnFrom;   // Фабричный номер счетчика

  R:= WB.Ranges.RangeByName['xnRatio'];   XLSPoint.xnRatio:=R.Rect[0].ColumnFrom;   // Коэфициент

  for i := 0 to 4 do begin
    R:= WB.Ranges.RangeByName['xnPrimaryIndicationsT'+IntToStr(i)];   XLSPoint.xnPrimaryIndicationsT[i]:=R.Rect[0].ColumnFrom;   // Первичный счетчик
    R:= WB.Ranges.RangeByName['xnSecondaryIndicationsT'+IntToStr(i)];   XLSPoint.xnSecondaryIndicationsT[i]:=R.Rect[0].ColumnFrom;  // Вторичный счетчик
    R:= WB.Ranges.RangeByName['xnDifferenceIndicationT'+IntToStr(i)];   XLSPoint.xnDifferenceIndicationT[i]:=R.Rect[0].ColumnFrom;   // Разница показаний
    R:= WB.Ranges.RangeByName['xnPowerConsumptionT'+IntToStr(i)];   XLSPoint.xnPowerConsumptionT[i]:=R.Rect[0].ColumnFrom;   // Расход энергии
  end;

                                                           // Суммарное значение
  FDir := ExtractFilePath(Application.ExeName) + 'ExportData\';
  s := DateTimeToStr(now);
  s := StringReplace(s, '/', '.', [rfReplaceAll, rfIgnoreCase]);
  s := StringReplace(s, '\', '.', [rfReplaceAll, rfIgnoreCase]);
  s := StringReplace(s, ':', '.', [rfReplaceAll, rfIgnoreCase]);
  FDir:=FDir + 'Показания счетчиков электроэнергии ' + 'по группе абонентов на ' + s + '.xls';

  PgBar.Max := aboidList.Count-1;

  KindEn := 0;
  if chkActPlus.Checked    then begin
    KindEn := KindEn + 1;
    KiEn[0] := True;
  end else KiEn[0] := False;
  if chkActMinus.Checked   then begin
    KindEn := KindEn + 2;
    KiEn[1] := True;
  end else KiEn[1] := False;
  if chkReactPlus.Checked  then begin
    KindEn := KindEn + 4;
    KiEn[2] := True;
  end else KiEn[2] := False;
  if chkReactMinus.Checked then begin
    KindEn := KindEn + 8;
    KiEn[3] := True;
  end else KiEn[3] := False;

  KiEnCnt := 0;
  for i := 0 to 3 do
    if KiEn[i] then inc(KiEnCnt);

  if KiEnCnt = 0 then begin
    MessageDlg('Ошибка!'+ #13#10 +'Не выбранно ни один вид электроэнергии', mtWarning, [mbYes], 0);
    goto ExitLabel;
  end;

  if chkTarif1.Checked then TfEn[1] := True else TfEn[1] := False;
  if chkTarif2.Checked then TfEn[2] := True else TfEn[2] := False;
  if chkTarif3.Checked then TfEn[3] := True else TfEn[3] := False;
  if chkTarif4.Checked then TfEn[4] := True else TfEn[4] := False;
  if chkTarifS.Checked then TfEn[0] := True else TfEn[0] := False;

  TfEnCnt := 0;
  for i := 0 to 3 do
    if TfEn[i] then inc(TfEnCnt);

  if TfEnCnt = 0 then begin
    MessageDlg('Ошибка!'+ #13#10 +'Не выбранно ни один тариф электроэнергии', mtWarning, [mbYes], 0);
    goto ExitLabel;
  end;

  for j := 0 to 4 do begin    // Для суммирования, нужно предполагать что будет 4 вида энергии
    rpHomeBalanse.TotalPowerConsumptionT[j] := 0;
    rpHomeBalanse.TotalPowerBalanceT[j] := 0;
    rpHomeBalanse.TotalPowerNoBalanceT[j] := 0;
  end;

  h := XLSPoint.xnFirstRow;
  x := 1;

  for i := 0 to aboidList.Count-1 do begin

    for j := 1 to 4 do DateR[j] := 0;
    aboid := Integer(aboidList.Items[i]);

    if checkPeriod then CMDID := QRY_NAK_EN_MONTH_EP  // отчет за месяц
    else CMDID := QRY_NAK_EN_DAY_EP;                   // отчет за день

    StrSQL := 'SELECT * FROM GET_VMETERS_DATA_PRELOAD(' + IntToStr(aboid) + ')';

    if utlDB.DBase.OpenQry(StrSQL,nCount) = True then begin
      if checkDaily then begin    // отчет суточный
        TempDate := trunc(Now);
          for j := 1 to 4 do begin
            SUMMCURR := 'SUMMCURR' + IntToStr(j);
            DATEDAY := 'DATEDAY' + IntToStr(j);
            DATECURR := 'DATECURR' + IntToStr(j);
            SUMMDAY := 'SUMMDAY' + IntToStr(j);
            if (utlDB.DBase.IBQuery.FieldByName(SUMMCURR).AsFloat > 0) then begin
              if (utlDB.DBase.IBQuery.FieldByName(DATECURR).AsDateTime >= utlDB.DBase.IBQuery.FieldByName(DATEDAY).AsDateTime) then begin
                  DateR[j] := utlDB.DBase.IBQuery.FieldByName(DATECURR).AsDateTime;
                  CMDID := 1;  // в случае если значение текущего больше чем суточные
                end else DateR[j] := utlDB.DBase.IBQuery.FieldByName(DATEDAY).AsDateTime;
            end else
            if (utlDB.DBase.IBQuery.FieldByName(SUMMDAY).AsFloat > 0) then
              DateR[j] := utlDB.DBase.IBQuery.FieldByName(DATEDAY).AsDateTime;
          end;
        BeginData := dtpBeginDaily.Date;
        EndDate := dtpEndDaily.Date;

      end else begin  // отчет месячный
        for j := 1 to 4 do begin   // decision wrong  это еще не делалось
            SUMMCURR := 'SUMMCURR' + IntToStr(j);
            DATEDAY  := 'DATEDAY' + IntToStr(j);
            DATECURR := 'DATECURR' + IntToStr(j);
            SUMMDAY  := 'SUMMDAY' + IntToStr(j);
          if (utlDB.DBase.IBQuery.FieldByName(SUMMDAY).AsFloat > 0) then begin
            if (utlDB.DBase.IBQuery.FieldByName(DATEDAY).AsDateTime >= utlDB.DBase.IBQuery.FieldByName(DATEDAY).AsDateTime) then begin
                DateR[j] := utlDB.DBase.IBQuery.FieldByName(DATECURR).AsDateTime;
              end else DateR[j] := utlDB.DBase.IBQuery.FieldByName(DATEDAY).AsDateTime;
          end else
          if (utlDB.DBase.IBQuery.FieldByName(SUMMDAY).AsFloat > 0) then
              DateR[j] := utlDB.DBase.IBQuery.FieldByName(DATEDAY).AsDateTime;
        end;
      end;

    end;

    utlDB.DBase.IBQuery.Close;

    StrSQL := 'SELECT * FROM GET_VMETERS_DATA(' + IntToStr(aboid) + ', ' + IntToStr(CMDID) + ', ' +
              '''' + DateToStr(BeginData) + ''', ' + '''' + DateToStr(EndDate) + ''', ' + IntToStr(KindEn) + ')';


    if utlDB.DBase.OpenQry(StrSQL,nCount) = True then begin
      while not utlDB.DBase.IBQuery.Eof do begin
        MID := utlDB.DBase.IBQuery.FieldByName('MID').AsInteger;
        Loc := utlDB.DBase.IBQuery.FieldByName('LOC').AsInteger;
        s := utlDB.DBase.IBQuery.FieldByName('M_SCHNAME').AsString;
        delete(s, 1, 5);
        WB.Cells[h,XLSPoint.xnNumberHouse].Value:=x;  //copy(s,1,pos('/', s)-1);
        delete(s, 1, pos('/', s));
        delete(s, 1, 4);
        WB.Cells[h,XLSPoint.xnConsumerLS].Value:=copy(s,1,pos(')', s)-1);
        delete(s, 1, pos(')', s));
        WB.Cells[h,XLSPoint.xnConsumerName].Value:= s;
        WB.Cells[h,XLSPoint.xnMeterNumb].Value:= utlDB.DBase.IBQuery.FieldByName('FABNUM').AsString;
        WB.Cells[h,XLSPoint.xnRatio].Value:= utlDB.DBase.IBQuery.FieldByName('KE').AsInteger;

        for g := 0 to 3 do begin
          // певичные значения счетчика
          if not KiEn[g] then Continue;
          WB.Cells[h,XLSPoint.xnEnergy].Value:= EnergyTitles[g];
          for j := 0 to 4 do begin
            case g of
              0 : begin
                V_TARIFS := utlDB.DBase.IBQuery.FieldByName('V_TARIF' + IntToStr(j) + '_VAL_APLUS').AsString;
                V_TARIF := utlDB.DBase.IBQuery.FieldByName('V_TARIF' + IntToStr(j) + '_VAL_APLUS').AsFloat;
              end;
              1 : begin
                V_TARIFS := utlDB.DBase.IBQuery.FieldByName('V_TARIF' + IntToStr(j) + '_VAL_AMINUS').AsString;
                V_TARIF := utlDB.DBase.IBQuery.FieldByName('V_TARIF' + IntToStr(j) + '_VAL_AMINUS').AsFloat;
              end;
              2 : begin
                V_TARIFS := utlDB.DBase.IBQuery.FieldByName('V_TARIF' + IntToStr(j) + '_VAL_RPLUS').AsString;
                V_TARIF := utlDB.DBase.IBQuery.FieldByName('V_TARIF' + IntToStr(j) + '_VAL_RPLUS').AsFloat;
              end;
              3 : begin
                V_TARIFS := utlDB.DBase.IBQuery.FieldByName('V_TARIF' + IntToStr(j) + '_VAL_RMINUS').AsString;
                V_TARIF := utlDB.DBase.IBQuery.FieldByName('V_TARIF' + IntToStr(j) + '_VAL_RMINUS').AsFloat;
              end;
            end;
            if V_TARIFS = '' then begin
              WB.Cells[h,XLSPoint.xnPrimaryIndicationsT[j]].Value :='н/д';
              WB.Cells[h,XLSPoint.xnPrimaryIndicationsT[j]].FillPattern:= xlPatternSolid;
              WB.Cells[h,XLSPoint.xnPrimaryIndicationsT[j]].FillPatternBGColorIndex:= xlColorRose;
            end else begin                           // FADOQuery.FieldByName('V_TARIF0_VAL_APLUS').AsFloat;
              WB.Cells[h,XLSPoint.xnPrimaryIndicationsT[j]].Value:= RVLPr(V_TARIF/utlDB.DBase.IBQuery.FieldByName('KE').AsFloat, MeterPrecision[MID]);
              WB.Cells[h,XLSPoint.xnPrimaryIndicationsT[j]].FillPattern:= xlPatternSolid;
              WB.Cells[h,XLSPoint.xnPrimaryIndicationsT[j]].FillPatternBGColorIndex:= xlColorWhite;
            end;
          end;


          // вторичные значения счетчика
          for j := 0 to 4 do begin
            case g of
              0 : begin
                R_TARIFS := utlDB.DBase.IBQuery.FieldByName('R_TARIF' + IntToStr(j) + '_VAL_APLUS').AsString;
                R_TARIF := utlDB.DBase.IBQuery.FieldByName('R_TARIF' + IntToStr(j) + '_VAL_APLUS').AsFloat;
              end;
              1 : begin
                R_TARIFS := utlDB.DBase.IBQuery.FieldByName('R_TARIF' + IntToStr(j) + '_VAL_AMINUS').AsString;
                R_TARIF := utlDB.DBase.IBQuery.FieldByName('R_TARIF' + IntToStr(j) + '_VAL_AMINUS').AsFloat;
              end;
              2 : begin
                R_TARIFS := utlDB.DBase.IBQuery.FieldByName('R_TARIF' + IntToStr(j) + '_VAL_RPLUS').AsString;
                R_TARIF := utlDB.DBase.IBQuery.FieldByName('R_TARIF' + IntToStr(j) + '_VAL_RPLUS').AsFloat;
              end;
              3 : begin
                R_TARIFS := utlDB.DBase.IBQuery.FieldByName('R_TARIF' + IntToStr(j) + '_VAL_RMINUS').AsString;
                R_TARIF := utlDB.DBase.IBQuery.FieldByName('R_TARIF' + IntToStr(j) + '_VAL_RMINUS').AsFloat;
              end;
            end;
            if R_TARIFS = '' then begin
              WB.Cells[h,XLSPoint.xnSecondaryIndicationsT[j]].Value :='н/д';
              WB.Cells[h,XLSPoint.xnSecondaryIndicationsT[j]].FillPattern:= xlPatternSolid;
              WB.Cells[h,XLSPoint.xnSecondaryIndicationsT[j]].FillPatternBGColorIndex:= xlColorRose;
            end else begin                           // FADOQuery.FieldByName('V_TARIF0_VAL_APLUS').AsFloat;
              WB.Cells[h,XLSPoint.xnSecondaryIndicationsT[j]].Value:= RVLPr(R_TARIF/utlDB.DBase.IBQuery.FieldByName('KE').AsFloat, MeterPrecision[MID]);
              WB.Cells[h,XLSPoint.xnSecondaryIndicationsT[j]].FillPattern:= xlPatternSolid;
              WB.Cells[h,XLSPoint.xnSecondaryIndicationsT[j]].FillPatternBGColorIndex:= xlColorWhite;
            end;
          end;



          if dt = 0 then begin
            dt := utlDB.DBase.IBQuery.FieldByName('V_TARIF_TIME_APLUS').AsDateTime;

          end;

          // Разница показаний
          for j := 0 to 4 do begin
            sa := WB.Cells[h,XLSPoint.xnSecondaryIndicationsT[j]].Value;
            sb := WB.Cells[h,XLSPoint.xnPrimaryIndicationsT[j]].Value;
            if (sa = 'н/д') or (sb = 'н/д') then begin
              WB.Cells[h,XLSPoint.xnDifferenceIndicationT[j]].Value :='н/д';
              WB.Cells[h,XLSPoint.xnDifferenceIndicationT[j]].FillPattern:= xlPatternSolid;
              WB.Cells[h,XLSPoint.xnDifferenceIndicationT[j]].FillPatternBGColorIndex:= xlColorRose;
            end else begin
              fa := WB.Cells[h,XLSPoint.xnSecondaryIndicationsT[j]].Value;
              fb := WB.Cells[h,XLSPoint.xnPrimaryIndicationsT[j]].Value;
              WB.Cells[h,XLSPoint.xnDifferenceIndicationT[j]].Value:= fa - fb;
              WB.Cells[h,XLSPoint.xnDifferenceIndicationT[j]].FillPattern:= xlPatternSolid;
              WB.Cells[h,XLSPoint.xnDifferenceIndicationT[j]].FillPatternBGColorIndex:= xlColorWhite;
            end;
          end;


          // Расход энергии
          for j := 0 to 4 do begin
            sa := WB.Cells[h,XLSPoint.xnDifferenceIndicationT[j]].Value;
            if sa = 'н/д' then begin
              WB.Cells[h,XLSPoint.xnPowerConsumptionT[j]].Value :='н/д';
              WB.Cells[h,XLSPoint.xnPowerConsumptionT[j]].FillPattern:= xlPatternSolid;
              WB.Cells[h,XLSPoint.xnPowerConsumptionT[j]].FillPatternBGColorIndex:= xlColorRose;
            end else begin
              fa := WB.Cells[h,XLSPoint.xnDifferenceIndicationT[j]].Value;
              WB.Cells[h,XLSPoint.xnPowerConsumptionT[j]].Value:= fa * utlDB.DBase.IBQuery.FieldByName('KE').AsFloat;
              WB.Cells[h,XLSPoint.xnPowerConsumptionT[j]].FillPattern:= xlPatternSolid;
              WB.Cells[h,XLSPoint.xnPowerConsumptionT[j]].FillPatternBGColorIndex:= xlColorWhite;
              if Loc = 5 then rpHomeBalanse.TotalPowerConsumptionT[j] := rpHomeBalanse.TotalPowerConsumptionT[j] + fa;
              if Loc = 6 then rpHomeBalanse.TotalPowerBalanceT[j] := rpHomeBalanse.TotalPowerBalanceT[j] + fa;
            end;
          end;



          // вставляем строчку
          WB.Rows.InsertRows(h,1);
          WB.Rows.CopyRows(h,h+1,h+1);

          inc(h);


        end;
        if KiEnCnt > 1 then begin
          // группировки: по фамилиё
          R := xf.Workbook.Sheets[0].Ranges.Add;
          R.AddRect(h-KiEnCnt,h-1,XLSPoint.xnConsumerName,XLSPoint.xnConsumerName);
          R.MergeCells;
          R.HAlign:= xlHAlignCenter;
          R.Valign:= xlVAlignCenter;
          // по № кв
          R := xf.Workbook.Sheets[0].Ranges.Add;
          R.AddRect(h-KiEnCnt,h-1,XLSPoint.xnNumberHouse,XLSPoint.xnNumberHouse);
          R.MergeCells;
          R.HAlign:= xlHAlignCenter;
          R.Valign:= xlVAlignCenter;
          // по № счётчика
          R := xf.Workbook.Sheets[0].Ranges.Add;
          R.AddRect(h-KiEnCnt,h-1,XLSPoint.xnMeterNumb,XLSPoint.xnMeterNumb);
          R.MergeCells;
          R.HAlign:= xlHAlignCenter;
          R.Valign:= xlVAlignCenter;
          // по коэфичиенту
          R := xf.Workbook.Sheets[0].Ranges.Add;
          R.AddRect(h-KiEnCnt,h-1,XLSPoint.xnRatio,XLSPoint.xnRatio);
          R.MergeCells;
          R.HAlign:= xlHAlignCenter;
          R.Valign:= xlVAlignCenter;
         end;
        utlDB.DBase.IBQuery.next;
        inc(x);
      end;

      for j := 0 to 4 do begin
        if not TfEn[j] then begin
          WB.Columns[XLSPoint.xnPrimaryIndicationsT[j]].Width := 0;
          WB.Columns[XLSPoint.xnSecondaryIndicationsT[j]].Width := 0;
          WB.Columns[XLSPoint.xnDifferenceIndicationT[j]].Width := 0;
          WB.Columns[XLSPoint.xnPowerConsumptionT[j]].Width := 0;
        end;
      end;

    end;
    PgBar.Position := i;
    Application.ProcessMessages;
  end;
  WB.Rows.DeleteRows(h,h);
  
  // **************************************************
  if IsUsePokNow then begin
    s:= WB.Cells[XLSPoint.xnSecondaryIndications.Y,XLSPoint.xnSecondaryIndications.X].Value;
    s := s + ' ' + DateToStr(dt);
    WB.Cells[XLSPoint.xnSecondaryIndications.Y,XLSPoint.xnSecondaryIndications.X].Value :=s;
  end;




  for h := 0 to 4 do begin
    R:= WB.Ranges.RangeByName['xnTotalSummHomeT'+IntToStr(h)];   XLSPoint.xnTotalSummHomeT[h].X:=R.Rect[0].ColumnFrom; XLSPoint.xnTotalSummHomeT[h].Y:=R.Rect[0].RowFrom;
    R:= WB.Ranges.RangeByName['xnTotalSummBalanceT'+IntToStr(h)];   XLSPoint.xnTotalSummBalanceT[h].X:=R.Rect[0].ColumnFrom; XLSPoint.xnTotalSummBalanceT[h].Y:=R.Rect[0].RowFrom;
    R:= WB.Ranges.RangeByName['xnTotalSummNoBalanceT'+IntToStr(h)];   XLSPoint.xnTotalSummNoBalanceT[h].X:=R.Rect[0].ColumnFrom; XLSPoint.xnTotalSummNoBalanceT[h].Y:=R.Rect[0].RowFrom;
  end;



  for h := 0 to 4 do begin
    WB.Cells[XLSPoint.xnTotalSummHomeT[h].Y,XLSPoint.xnTotalSummHomeT[h].X].Value := TotalPowerConsumptionT[h];
    WB.Cells[XLSPoint.xnTotalSummBalanceT[h].Y,XLSPoint.xnTotalSummBalanceT[h].X].Value := TotalPowerBalanceT[h];
    if TotalPowerBalanceT[h] > 0 then
      TotalPowerNoBalanceT[h] := (TotalPowerConsumptionT[h] / TotalPowerBalanceT[h]) * 100;
    WB.Cells[XLSPoint.xnTotalSummNoBalanceT[h].Y,XLSPoint.xnTotalSummNoBalanceT[h].X].Value := TotalPowerNoBalanceT[h];
  end;

  try
    xf.SaveAs(FDir);
  except
    MessageDlg('В данный момент отчет с текущим именем открыт в другой сессии' + #13#10 +
               '       закройте открытый файл и повторите попытку' ,mtWarning,[mbYes], 0);
  end;
  ShellExecute(0, 'open', PChar(FDir), nil, nil, SW_SHOW);


ExitLabel:
  aboidList.Destroy;
  if XLSPoint <> nil then FreeAndNil(XLSPoint);
  If xf <> nil then FreeAndNil(xf);
end;



end.
