unit knslRPPokMetersXL;

interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox, ShellAPI, utlDB,
   { ---------------------------------------------------------------------------
   Use required TXLSFile library units
   --------------------------------------------------------------------------- }
   XLSFile, XLSFormat, XLSWorkbook;


type
  TrpPokMetersXL = class(TForm)
  constructor Create;
  destructor Destroy;override;
   private
    { Private declarations }
    GroupID        : integer;
    FProgress      : PTProgressBar;
    FABOID         : Integer;
    procedure frReport1ManualBuild;
    function SetCellByName(WB : TSheet; name, value : string): TSheet;
  public
    { Public declarations }
    KindEnergy   : integer;
    FirstSign    : string;
    ThirdSign    : string;
    SecondSign   : string;
    WorksName    : string;
    Telephon     : string;
    EMail        : string;
    NameObject   : string;
    Adress       : string;
    KodObj       : string;
    procedure CreatReport(Date : TDateTime);
  public
    property prGroupID   :integer read GroupID write GroupID;
    property PABOID      :Integer          read FABOID       write FABOID;
    property PProgress   :PTProgressBar  read FProgress         write FProgress;
  end;

var
  rpPokMetersXL: TrpPokMetersXL;

const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт*ч)',
                                          'Вид энергии : Активная генерируемая(кВт*ч)',
                                          'Вид энергии : Реактивная потребляемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');
implementation

uses knsl3report;

constructor TrpPokMetersXL.Create;
Begin

End;

destructor TrpPokMetersXL.Destroy;
Begin
    inherited;
End;


procedure TrpPokMetersXL.CreatReport(Date : TDateTime);
begin
  frReport1ManualBuild;
end;

function TrpPokMetersXL.SetCellByName(WB : TSheet; name, value : string): TSheet;
var R        : TRange;
    col, row : Integer;
begin
  R:= WB.Ranges.RangeByName[name];
  col:=R.Rect[0].ColumnFrom;
  row:=R.Rect[0].RowFrom;
  WB.Cells[row, col].Value := Value;
  Result := WB;
end;


procedure TrpPokMetersXL.frReport1ManualBuild();
var i                : integer;
    nCount, VMID     : Integer;
    Month, Year, Day : word;
    WB               : TSheet;
    xf               : TXLSFile;
    Range            : TRange;
    globalTitleKPD   : string;
    FDir, strSQL     : string;
    RowInTable       : Integer;
    Koef             : extended;
    nDayCount        : Integer;
    m_blTrueDate     : boolean;

  function SetValue(val : Double): Double;
  begin
    val := RVLPr(val/Koef, MeterPrecision[VMID]);
    Result := val;
  end;

begin
  //if FProgress <> nil then FreeAndNil(FProgress);
  //FProgress.Create(Owner);
  FProgress.Visible := true;

  DecodeDate(Now, Year, Month, Day);
  globalTitleKPD := 'Отчет о фактической потребленой электроэнергии на ' + DateTimeToStr(Now);

  FDir := ExtractFileDir(application.ExeName)+'\report\RPPokMeters.xls';

  xf:= TXLSFile.Create;
  xf.OpenFile(FDir);
  WB:= XF.Workbook.Sheets[0];

  WB := SetCellByName(WB, 'xnWorksName', WorksName);
  WB := SetCellByName(WB, 'xnNameObject', NameObject);
  WB := SetCellByName(WB, 'xnAdress', Adress);
  WB := SetCellByName(WB, 'xnTelephon', Telephon);
  WB := SetCellByName(WB, 'xnEmail', Email);
  WB := SetCellByName(WB, 'xnGlobalTitle', globalTitleKPD);
  WB := SetCellByName(WB, 'xnKindEnergy', strEnergy[KindEnergy]);

  Range:= WB.Ranges.RangeByName['xnBeginTable'];
  RowInTable:=Range.Rect[0].RowFrom;

  strSQL:='SELECT L3MT.M_SVMETERNAME, L2T.M_SDDFABNUM, L3MT.M_SWVMID, L2T.M_SWMID, L3MT.M_SWPLID, ' +
          '       L2T.M_SFKI, L2T.M_SFKU, QM.M_SCOMMENT, L3MT.M_SBYTYPE, L2T.M_SBYPRECISION, ' +
          '  (SELECT M_SFVALUE FROM L3CURRENTDATA WHERE L3MT.M_SWVMID = M_SWVMID AND M_SWTID = 0) VAL0, ' +
          '  (SELECT M_SFVALUE FROM L3CURRENTDATA WHERE L3MT.M_SWVMID = M_SWVMID AND M_SWTID = 1) VAL1, ' +
          '  (SELECT M_SFVALUE FROM L3CURRENTDATA WHERE L3MT.M_SWVMID = M_SWVMID AND M_SWTID = 2) VAL2, ' +
          '  (SELECT M_SFVALUE FROM L3CURRENTDATA WHERE L3MT.M_SWVMID = M_SWVMID AND M_SWTID = 3) VAL3, ' +
          '  (SELECT M_SFVALUE FROM L3CURRENTDATA WHERE L3MT.M_SWVMID = M_SWVMID AND M_SWTID = 4) VAL4, ' +
          '  (SELECT M_STIME FROM L3CURRENTDATA WHERE L3MT.M_SWVMID = M_SWVMID AND M_SWTID = 0) M_STIME ' +
          'FROM SL3VMETERTAG L3MT, L2TAG L2T, QM_METERS QM, SL3GROUPTAG L3GT ' +
          'WHERE L2T.M_SWMID = L3MT.M_SWMID ' +
          '  AND QM.M_SWTYPE = L3MT.M_SBYTYPE ' +
          '  AND L3GT.M_SBYGROUPID = L3MT.M_SBYGROUPID ' +
          '  AND L3GT.M_SBYENABLE = 1 ' +
          '  AND L3GT.M_NGROUPLV = 0 ' +
          '  AND L3GT.M_SWABOID = ' + IntToStr(FABOID) + ' ' +
          'ORDER BY L2T.M_SWMID ';
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    for i := 0 to utlDB.DBase.IBQuery.RecordCount-1 do begin

      Koef := utlDB.DBase.IBQuery.FieldByName('M_SFKI').AsInteger * utlDB.DBase.IBQuery.FieldByName('M_SFKU').AsInteger;
      Koef := StrToFloat(DVLS(Koef));
      VMID := utlDB.DBase.IBQuery.FieldByName('M_SWVMID').AsInteger;
      m_blTrueDate := True;
      nDayCount := abs(trunc(now - utlDB.DBase.IBQuery.FieldByName('M_STIME').AsDateTime));
      DecodeDate(utlDB.DBase.IBQuery.FieldByName('M_STIME').AsDateTime, Year, Month, Day);
      if (Year = 2012) and (Month = 12) and (Day = 12) then m_blTrueDate := False;

        WB.Rows.InsertRows(RowInTable,1);
        WB.Rows.CopyRows(RowInTable,RowInTable+1,RowInTable+1);

        WB.Cells[RowInTable,0].Value:=utlDB.DBase.IBQuery.FieldByName('M_SVMETERNAME').AsString;
        WB.Cells[RowInTable,1].Value:=utlDB.DBase.IBQuery.FieldByName('M_SDDFABNUM').AsString;

        WB.Cells[RowInTable,6].Value := SetValue(utlDB.DBase.IBQuery.FieldByName('VAL0').AsFloat);
        WB.Cells[RowInTable,2].Value := SetValue(utlDB.DBase.IBQuery.FieldByName('VAL1').AsFloat);
        WB.Cells[RowInTable,3].Value := SetValue(utlDB.DBase.IBQuery.FieldByName('VAL2').AsFloat);
        WB.Cells[RowInTable,4].Value := SetValue(utlDB.DBase.IBQuery.FieldByName('VAL3').AsFloat);
        WB.Cells[RowInTable,5].Value := SetValue(utlDB.DBase.IBQuery.FieldByName('VAL4').AsFloat);

        WB.Cells[RowInTable,7].Value:=FloatToStr(Koef);

        WB.Rows[RowInTable].AutoFit;

        Range := WB.Ranges.Add;
        Range.AddRect(RowInTable,RowInTable,0,7);
        Range.FillPattern := xlPatternSolid;
        Range.FillPatternBGColorRGB := clBlue;
        if nDayCount = 0 then Range.FillPatternBGColorRGB := clWhite
        else if (nDayCount >= 1) and (nDayCount <= 3) then Range.FillPatternBGColorRGB := clYellow
        else if (nDayCount > 3) or (m_blTrueDate = False) then Range.FillPatternBGColorRGB := $0000FF;
        Range.Wrap := true;

        inc(RowInTable);

        utlDB.DBase.IBQuery.Next;
    end;
  end;

  WB.Rows.DeleteRows(RowInTable, RowInTable);

  WB := SetCellByName(WB, 'xnAgent1', FirstSign);
  WB := SetCellByName(WB, 'xnAgent2', SecondSign);
  WB := SetCellByName(WB, 'xnAgent3', ThirdSign);

  FDir := ExtractFilePath(Application.ExeName) + 'ExportData\';
  FDir:=FDir + 'Отчет о фактической потребленой электроэнергии по абоненту ' + KodObj + '.xls';

  try
    xf.SaveAs(FDir);
  except
    MessageDlg('В данный момент отчет с текущим именем открыт в другой сессии' + #13#10 +
               '       закройте открытый файл и повторите попытку' ,mtWarning,[mbYes], 0);
  end;
  ShellExecute(0, 'open', PChar(FDir), nil, nil, SW_SHOW);

  FProgress.Visible := False;
  if xf<>Nil then FreeAndNil(xf); // xf.Destroy;
end;

end.
