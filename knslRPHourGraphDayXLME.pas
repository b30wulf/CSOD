{*******************************************************************************
 *  @unit         knslRPHourGraphDayXLME
 *  @description  Отчет график часовой мощности за сутки
 *  @autor        Ukrop
 ******************************************************************************}

unit knslRPHourGraphDayXLME;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97, ComObj, OleServer, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase,
  utlTimeDate, utlbox,utlexparcer;

type
  TRPHourGraphDayXLME = class
  private
    Excel      : Variant;
    Sheet      : Variant;

    // placeholders
    m_PH_Contract     : String; 
    m_PH_AbonentName   : String;
    m_PH_ObjectAddress : String; 
    m_PH_ObjectNumber  : String;
    m_PH_ObjectName    : String;
    m_PH_DiagramTitle  : String;
    m_PH_MeterName     : String;
    m_PH_PMT           : array [1..4] of Double;  // максимумы мощности
    m_PH_ET            : array [1..4] of Double; // расходы электроэнергии
    m_PH_PMT_HH        : array [1..4] of Integer;
    m_Precision        : Integer;
    m_Date             : TDateTime; // дата, на которую строится график
    m_KindEnergy       : Byte; // тип энергии
    FTID               : Integer;

    // Ukrop
    function  SetPlaceholderValue(_Placeholder : String; _Value : String) : Boolean;
  public
//    ItemInd      : integer;


    destructor  Destroy(); override;
    procedure   MakeReport(_Date : TDateTime);

  public
    FsgGrid   : PTAdvStringGrid;
    GroupID   : Integer;
    FABOID    : Integer;
    FDB       : PCDBDynamicConn;
    FProgress : PTProgressBar;
    FVMID     : Integer;
  published
    property NameObject   : String  read m_PH_ObjectName write m_PH_ObjectName;
    property Address      : String  read m_PH_ObjectAddress write m_PH_ObjectAddress;
    property NDogovor     : String  read m_PH_Contract write m_PH_Contract;
    property WorksName    : String  read m_PH_AbonentName write m_PH_AbonentName;
    property ObjectNumber : String  read m_PH_ObjectNumber write m_PH_ObjectNumber;
    property KindEnergy   : Byte    read m_KindEnergy write m_KindEnergy;
    property Precision    : Integer read m_Precision write m_Precision;
  end;

var
  RPHourGraphDayXLME  : TRPHourGraphDayXLME;
  //FsgGrid    : ^TAdvStringGrid;
  IsFirstLoad  : boolean = true;

implementation


destructor TRPHourGraphDayXLME.Destroy;
Begin
    inherited;
End;



{*******************************************************************************
 *  procedure TRPHourGraphDayXLME.MakeReport(_Date : TDateTime);
 *  @param _Date : TDateTime Дата на которую создается отчет
 ******************************************************************************}
procedure TRPHourGraphDayXLME.MakeReport(_Date : TDateTime);
var
  l_GraphDatasEP, l_GraphDatasRP : L3GRAPHDATAS;
  l_SEP, l_SRP : Double;
  l_HID       : Integer;
begin
  m_Date := _Date;

  if m_Precision < 0 then
    m_Precision := 0;

  m_PH_Contract := trim(m_PH_Contract);

  FVMID := -1;
  if ((FsgGrid.Row > 0) AND (FsgGrid.Cells[0, FsgGrid.Row] <> '')) then
  begin
    FVMID := StrToIntDef(FsgGrid.Cells[0, FsgGrid.Row], -1);
    m_PH_MeterName := FsgGrid.Cells[1, FsgGrid.Row]
  end;

  if (FVMID = -1) then exit;
    
  FProgress.Create(nil);
  FProgress.Visible := true;
  FProgress.Max := 6;
  FProgress.Position := 0;
  try
    Excel := CreateOleObject('Excel.Application');
  except
    MessageDlg('Отсутствует MS Office Excel', mtWarning, [mbOK], 0);
    exit;
  end;
  FProgress.Position := 1;
  m_PH_DiagramTitle := 'График часовой активной и реактивной мощности' + ' за ' + FormatDateTime('dd.mm.yyyy', m_Date);

  try
  FTID        := FDB.LoadTID(QRY_E30MIN_POW_EP + m_KindEnergy);
  Excel.Application.EnableEvents := false;
  Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPHourGraphDay.xlt');
  Excel.ActiveSheet.PageSetup.Orientation:= 1;
  Sheet := Excel.Sheets.Item[1];
  Excel.ActiveWorkBook.WorkSheets[1].Activate;
  Sheet.Name := 'График часовой мощности';
  FProgress.Position := 2;

  // заполнение шапки отчета
  SetPlaceholderValue('#abonentId', m_PH_Contract);
  SetPlaceholderValue('#abonentName', m_PH_AbonentName);
  SetPlaceholderValue('#objectAddress', m_PH_ObjectAddress);
  //SetPlaceholderValue('#objectNumber', m_PH_ObjectNumber);
//  SetPlaceholderValue('#objectName', m_PH_ObjectName);
  SetPlaceholderValue('#meterName', m_PH_MeterName);
  SetPlaceholderValue('#graphDescription', m_PH_DiagramTitle);
  FProgress.Position := 3;

  // заполнение получасовых данных
  if (FDB.GetGraphDatas(m_Date, m_Date, FVMID, QRY_SRES_ENR_EP,l_GraphDatasEP)
      AND FDB.GetGraphDatas(m_Date, m_Date, FVMID, QRY_SRES_ENR_RP,l_GraphDatasRP)) then
  begin
    for l_HID := 0 to 23 do
    begin
      Excel.ActiveSheet.Range['D'+IntToStr(l_HID+9)+':D'+IntToStr(l_HID+9)].Select;
      Excel.ActiveSheet.Range['D'+IntToStr(l_HID+9)+':D'+IntToStr(l_HID+9)].Merge;
      Excel.ActiveSheet.Cells[l_HID+9,4].Value := FloatToStrF((l_GraphDatasEP.Items[0].v[l_HID*2] +l_GraphDatasEP.Items[0].v[l_HID*2 + 1]), ffFixed, 18, m_Precision);
      l_SEP := l_SEP + l_GraphDatasEP.Items[0].v[l_HID*2] +l_GraphDatasEP.Items[0].v[l_HID*2 + 1];

      Excel.ActiveSheet.Range['F'+IntToStr(l_HID+9)+':F'+IntToStr(l_HID+9)].Select;
      Excel.ActiveSheet.Range['F'+IntToStr(l_HID+9)+':F'+IntToStr(l_HID+9)].Merge;
      Excel.ActiveSheet.Cells[l_HID+9,6].Value := FloatToStrF((l_GraphDatasRP.Items[0].v[l_HID*2] +l_GraphDatasRP.Items[0].v[l_HID*2 + 1]), ffFixed, 18, m_Precision);
      l_SRP := l_SRP + l_GraphDatasRP.Items[0].v[l_HID*2] +l_GraphDatasRP.Items[0].v[l_HID*2 + 1];
    end;

    SetPlaceholderValue('#EPR', FloatToStrF(l_SEP, ffFixed, 18, m_Precision));
    SetPlaceholderValue('#RPR', FloatToStrF(l_SRP, ffFixed, 18, m_Precision));
    // CalcPMaxAndDeltaE(l_GraphDatas.Items[0]);
  end
  else
  begin
     MessageDlg('Данные отсутствуют', mtWarning, [mbOK], 0);
    //exit;
  end;
  FProgress.Position := 4;
  // заполнение максимумов мощности и расходов электроэнергии

  Sheet := Excel.Sheets.Item[1];
  Excel.ActiveWorkBook.WorkSheets[1].Activate;
  {
  SetPlaceholderValue('#PMT0', DVLS(m_PH_PMT[1]));
  SetPlaceholderValue('#PMT1', DVLS(m_PH_PMT[2]));
  SetPlaceholderValue('#PMT2', DVLS(m_PH_PMT[3]));
  SetPlaceholderValue('#PMT3', DVLS(m_PH_PMT[4]));
  SetPlaceholderValue('#ET0',  DVLS(m_PH_ET[1]));
  SetPlaceholderValue('#ET1',  DVLS(m_PH_ET[2]));
  SetPlaceholderValue('#ET2',  DVLS(m_PH_ET[3]));
  SetPlaceholderValue('#ET3',  DVLS(m_PH_ET[4]));
  }
  FProgress.Position := 5;

    Excel.Visible := true;
    FProgress.Position:=6;
  except
    if not VarIsEmpty(Excel) then
    begin
      //Excel.Quit;
      Excel := Unassigned;
      Sheet := Unassigned;
    end;
    FProgress.Visible :=false;
    FProgress.Enabled  := false;
    FProgress := nil;
  end;
  if not VarIsEmpty(Excel) then
  begin
    //Excel.Quit;
    Excel := Unassigned;
    Sheet := Unassigned;
  end;
  FProgress.Visible :=false;
  FProgress.Enabled  := false;
  FProgress := nil;
end;


function TRPHourGraphDayXLME.SetPlaceholderValue(_Placeholder : String; _Value : String) : Boolean;
var
  l_Range : Variant;
begin
  Result := false;
  
  if (_Placeholder<>'') then
  begin
    try
      l_Range := Excel.Range['A1:F44'].Replace(What := _Placeholder, Replacement := _Value);
      Result := true;
    except
    end;
  end;
end;

end.
