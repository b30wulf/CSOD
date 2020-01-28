unit frmRepCorrect;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, frmTreeDataModule, utlconst;

type
  TfRepCorrect = class(TFrame)
    rgTarif: TRadioGroup;
    Panel1: TPanel;
    grp2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cbbMonth: TComboBox;
    cbbYear: TComboBox;
    btnRun: TBitBtn;
    grp1: TGroupBox;
    chk0: TCheckBox;
    chkMinus: TCheckBox;
    chkEqually: TCheckBox;
    chkMax: TCheckBox;
    edtMax: TEdit;
    chkNULL: TCheckBox;
    rgEnergy: TRadioGroup;
    ProgressBar1: TProgressBar;
    procedure btnRunClick(Sender: TObject);
  private
    ID : Integer;
    { Private declarations }
  public
    NameRES : string;
    procedure init;
//    procedure PreRun;
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses knsl5module, utlDB,
   ShellApi,
   XLSFile,
   XLSFormat,
   XLSWorkbook;

{ TfRepCorrect }

procedure TfRepCorrect.init;
var i : Integer;
    y, m, d : word;
    Node : TTreeNode;
    NodeData : TNodeData;
begin
  edtMax.text := '3000';
  DecodeDate(Now, y, m, d);
  for i := y downto y - 5 do
    cbbYear.Items.Add(IntToStr(i));
  cbbMonth.ItemIndex := m-1;
  cbbYear.ItemIndex := 0;
  rgTarif.ItemIndex := 0;
  rgEnergy.ItemIndex:= 0;
  Node := TKnsForm.frameTreeDataModule.TreeList.Selected;
  NodeData := Node.Data;
  case NodeData.Code of
    0 : begin  // абонент
      NodeData := Node.Parent.Parent.Parent.Parent.Data;
      NameRES := Node.Parent.Parent.Parent.Parent.Text;
      ID := NodeData.ID;
    end;
    8 : begin
      // Район - пока не делал
    end;
    10 : begin
      ID := NodeData.ID;
      NameRES := Node.Text;
    end;
    11 : begin // town
      NodeData := Node.Parent.Data;
      NameRES := Node.Parent.Text;
      ID := NodeData.ID;
    end;
    12 : begin // street
      NodeData := Node.Parent.Parent.Parent.Data;
      NameRES := Node.Parent.Parent.Parent.Text;
      ID := NodeData.ID;
    end;
    18 : begin // TP
      NodeData := Node.Parent.Parent.Data;
      NameRES := Node.Parent.Parent.Text;
      ID := NodeData.ID;
    end;
    // Нужно доделывать дальше по квартирам, отчетам, лимитам и прочей ебуде. Вообще лучше эту функцию вынести в ТриМодуль, чтобы в дальнейшем не заморачиваться
  end;

end;

procedure TfRepCorrect.btnRunClick(Sender: TObject);
var DATEEND : TDate;
    DATEBEG : TDate;
    EDITMAX : Extended;
    TARIF   : Integer;
    CMD, i  : Integer;
    aCHK0   : Integer;
    aCHKMINUS : Integer;
    aCHKEQUALLY : Integer;
    aCHKMAX : Integer;
    aCHKNULL: Integer;
    d, m, y : Word;
    strSQL  : string;
    FDir, s : string;
    xf      : TXLSFile;
    WB      : TSheet;
    xnFirstRow : Integer;
    R       : TRange;
    DT, TM  : string;
    Hour, Min, Sec, MSec: Word;
    xnLineNumber : integer;
    xnAdress     : integer;
    xnPersonalAccount : Integer;
    xnFullName : Integer;
    xnCounterNumber : Integer;
    xnCurrentReadings : Integer;
    xnPreviousReadings : Integer;
    xnConsumption : Integer;
    xnError : Integer;
    nCount : Integer;
    VAL1, VAL2 : Double;
begin
 try
  d := 1;
  m := cbbMonth.ItemIndex+1;
  y := StrToInt(cbbYear.text);
  DATEEND := EncodeDate(y, m, d);
  DT := IntToStr(y) + '.' + IntToStr(m) + '.' + IntToStr(d);
  if m = 1 then begin
    m:=12;
    dec(y);
  end else dec(m);
  DATEBEG := EncodeDate(y, m, d);
  EDITMAX := StrToFloat(edtMax.Text);
  TARIF := rgTarif.ItemIndex;
  case rgEnergy.ItemIndex of
    0 : CMD := QRY_NAK_EN_MONTH_EP;  // 21
    1 : CMD := QRY_NAK_EN_MONTH_EM;  // 22
    2 : CMD := QRY_NAK_EN_MONTH_RP;  // 23
    3 : CMD := QRY_NAK_EN_MONTH_RM;  // 24
    else CMD := QRY_NAK_EN_MONTH_EP; // 21
  end;
  if CHK0.Checked then aCHK0 := 1  else aCHK0 := 0;
  if CHKMINUS.Checked then aCHKMINUS := 1  else aCHKMINUS :=0;
  if CHKEQUALLY.Checked then aCHKEQUALLY := 1  else aCHKEQUALLY :=0;
  if CHKMAX.Checked then aCHKMAX := 1  else aCHKMAX :=0;
  if CHKNULL.Checked then aCHKNULL := 1  else aCHKNULL :=0;

  strSQL:='SELECT * FROM GET_A_REPORT_ON_TAG(' +
              '''' +  DateToStr(DATEEND) + ''',' +
              '''' +  DateToStr(DATEBEG) + ''',' +
              FloatToStr(EDITMAX) + ', ' +  IntToStr(TARIF) + ', ' +
              IntToStr(CMD) + ', ' + IntToStr(ID) + ', ' + IntToStr(aCHK0) + ', ' +
              IntToStr(aCHKMINUS) + ', ' +  IntToStr(aCHKEQUALLY) + ', ' +
              IntToStr(aCHKMAX) + ', ' +  IntToStr(aCHKNULL) + ')';

  FDir := ExtractFilePath(Application.ExeName) + 'Report\RepOfError.xls';
  xf:= TXLSFile.Create;
  xf.OpenFile(FDir);
  WB:= XF.Workbook.Sheets[0];
  R:= WB.Ranges.RangeByName['xnReportName'];
  s :=WB.Cells[R.Rect[0].RowFrom, R.Rect[0].ColumnFrom].Value;
  s := s + ' ' + DateToStr(DATEBEG) + ' - ' + DateToStr(DATEEND);
  WB.Cells[R.Rect[0].RowFrom, R.Rect[0].ColumnFrom].Value := s;
  DecodeTime(Now, Hour, Min, Sec, MSec);
  TM := IntToStr(Hour) + '.' +  IntToStr(Min);
  FDir := ExtractFilePath(Application.ExeName) + 'ExportData\';
  NameRES := trim(NameRES);

  FDir:=FDir + 'Ошибки счетчиков электроэнергии ' + NameRES + DT + '.' + TM + '.xls';

  R:= WB.Ranges.RangeByName['xnLineNumber'];
  xnFirstRow:=R.Rect[0].RowFrom;
  xnLineNumber:=R.Rect[0].ColumnFrom;
  R:= WB.Ranges.RangeByName['xnAdress'];
  xnAdress:=R.Rect[0].ColumnFrom;
  R:= WB.Ranges.RangeByName['xnPersonalAccount'];
  xnPersonalAccount:=R.Rect[0].ColumnFrom;
  R:= WB.Ranges.RangeByName['xnFullName'];
  xnFullName:=R.Rect[0].ColumnFrom;
  R:= WB.Ranges.RangeByName['xnCounterNumber'];
  xnCounterNumber:=R.Rect[0].ColumnFrom;
  R:= WB.Ranges.RangeByName['xnCurrentReadings'];
  xnCurrentReadings:=R.Rect[0].ColumnFrom;
  R:= WB.Ranges.RangeByName['xnPreviousReadings'];
  xnPreviousReadings:=R.Rect[0].ColumnFrom;
  R:= WB.Ranges.RangeByName['xnConsumption'];
  xnConsumption:=R.Rect[0].ColumnFrom;
  R:= WB.Ranges.RangeByName['xnError'];
  xnError:=R.Rect[0].ColumnFrom;

  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    if nCount=0 then begin
     MessageDlg('При заданных условиях отсутствуют данные' ,mtWarning,[mbYes], 0);
     exit;
    end;
    for i := 0 to nCount-1 do begin
      ProgressBar1.Position:=(i+1)*99 div nCount-1;
      WB.Cells[xnFirstRow,xnLineNumber].Value:=IntToStr(i+1);
      s := utlDB.DBase.IBQuery.FieldByName('METNAME').AsString;
      Delete(s, 1, pos('№',s));
      WB.Cells[xnFirstRow,xnAdress].Value:=utlDB.DBase.IBQuery.FieldByName('ADDRS').AsString + '-' + copy(s, 1, pos('/',s)-1);
      Delete(s, 1, pos('№',s));
      WB.Cells[xnFirstRow,xnPersonalAccount].Value:= copy(s, 1, pos(')',s)-1);
      Delete(s, 1, pos(')',s));
      WB.Cells[xnFirstRow,xnFullName].Value:= s;
      WB.Cells[xnFirstRow,xnCounterNumber].Value:= utlDB.DBase.IBQuery.FieldByName('FABNUM').AsString;

      VAL1 := utlDB.DBase.IBQuery.FieldByName('VAL1').AsFloat;
      VAL2 := utlDB.DBase.IBQuery.FieldByName('VAL2').AsFloat;
      if (VAL1 >= 0) AND (VAL2 >= 0) then begin
        WB.Cells[xnFirstRow,xnCurrentReadings].Value:= VAL1;
        WB.Cells[xnFirstRow,xnPreviousReadings].Value:= VAL2;
        WB.Cells[xnFirstRow,xnConsumption].Value:= VAL1 - VAL2;
      end
      else if (Val1 >= 0) AND (VAL2 < 0) then begin
        WB.Cells[xnFirstRow,xnCurrentReadings].Value:= VAL1;
        WB.Cells[xnFirstRow,xnPreviousReadings].Value:= 'н/о';
        WB.Cells[xnFirstRow,xnConsumption].Value:= VAL1;
      end
      else if (Val1 < 0) AND (VAL2 >= 0) then begin
        WB.Cells[xnFirstRow,xnCurrentReadings].Value:= 'н/о';
        WB.Cells[xnFirstRow,xnPreviousReadings].Value:= VAL2;
        WB.Cells[xnFirstRow,xnConsumption].Value:= 'н/о';
      end else begin
        WB.Cells[xnFirstRow,xnCurrentReadings].Value:= 'н/о';
        WB.Cells[xnFirstRow,xnPreviousReadings].Value:= 'н/о';
        WB.Cells[xnFirstRow,xnConsumption].Value:= 'н/о';
      end;

      case utlDB.DBase.IBQuery.FieldByName('CODE').AsInteger of
        0 : WB.Cells[xnFirstRow,xnError].Value:= 'Показания счетчика равно нулю';
        1 : WB.Cells[xnFirstRow,xnError].Value:= 'Показания текущего месяца равно показанию предыдущего месяца';
        2 : WB.Cells[xnFirstRow,xnError].Value:= 'Показания текущего месяца меньше показания предыдущего месяца';
        3 : WB.Cells[xnFirstRow,xnError].Value:= 'Показания счетчика больше заданного значения (' + FloatToStr(EDITMAX) + ')';
        4 : WB.Cells[xnFirstRow,xnError].Value:= 'Счетчик не опрашивался';
      end;

      utlDB.DBase.IBQuery.Next;
      WB.Rows.InsertRows(xnFirstRow,1);
      WB.Rows.CopyRows(xnFirstRow,xnFirstRow+1,xnFirstRow+1);
      inc(xnFirstRow);
    end;
    WB.Rows.DeleteRows(xnFirstRow,xnFirstRow);

    try
      xf.SaveAs(FDir);
    except
      MessageDlg('В данный момент отчет с текущим именем открыт в другой сессии' + #13#10 +
                 '       закройте открытый файл и повторите попытку' ,mtWarning,[mbYes], 0);
    end;
    ShellExecute(0, 'open', PChar(FDir), nil, nil, SW_SHOW);
  end;
 finally
  ProgressBar1.Position:= 0; 
  if xf<>Nil then FreeAndNil(xf);
 end; 
end;

end.
