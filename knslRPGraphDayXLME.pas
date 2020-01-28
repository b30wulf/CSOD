{*******************************************************************************
 *  @unit         knslRPGraphDayXLME
 *  @description  Отчет график мощности за сутки
 *  @autor        Ukrop
 ******************************************************************************}

unit knslRPGraphDayXLME;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97, ComObj, OleServer, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase,
  utlTimeDate, utlbox,utlexparcer;

type
  TRPGraphDayXLME = class
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

    // хуитахуитахуитахуитахуитахуитахуитахуита
    procedure OnFormResize;
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;


    // Ukrop
    function  SetPlaceholderValue(_Placeholder : String; _Value : String) : Boolean;
    procedure CalcPMaxAndDeltaE(_L3Graph: L3GRAPHDATA);
    function  FindNumOfGroups(var str: string):integer;
    function  GetGrStartPos(var str: string; stFP: integer):integer;
    procedure GetGrPos(var str:string; stFindPos:integer; var BP, EP : integer);
    function  GetGrStringArr(var str : string; maxSymbInStr : integer) : string;
  public
//    ItemInd      : integer;


    destructor  Destroy(); override;
    procedure   PrepareTable();
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
  RPGraphDayXLME  : TRPGraphDayXLME;
  //FsgGrid    : ^TAdvStringGrid;
  IsFirstLoad  : boolean = true;
const

 FileNames       : array [0..3] of string = ('RPGraphDayMEEP.xlt',
                                             'RPGraphDayMEEM.xlt',
                                             'RPGraphDayMERP.xlt',
                                             'RPGraphDayMERM.xlt');

 KindPow       : array [0..3] of string = ('принимаемой активной',
                                           'отдаваемой активной',
                                           'принимаемой реактивной',
                                           'отдаваемой реактивной');
                                           
const MAX_STR_CONFIG_LEN : integer = 100;
const strNewLine         : string  = #10;

implementation


destructor TRPGraphDayXLME.Destroy;
Begin
    inherited;
End;

function TRPGraphDayXLME.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
var SumS                         : word;
    Hour0, Min0, Sec0, ms0, Sum0 : word;
    Hour1, Min1, Sec1, ms1, Sum1 : word;
    i                            : byte;
begin
    Result := 0;
    SumS   := 30 * Srez;
    for i := 1 to pTable.Count - 1 do
    begin
      DecodeTime(pTable.Items[i].m_dtTime0, Hour0, Min0, Sec0, ms0);
      DecodeTime(pTable.Items[i].m_dtTime1, Hour1, Min1, Sec1, ms1);
      Sum0 := Hour0*60 + Min0;
      Sum1 := Hour1*60 + Min1;
      if Hour0 < Hour1 then
      begin
        if (SumS >= Sum0) and (SumS < Sum1) then
          Result := pTable.Items[i].m_swTID;
      end
      else
      begin
        if SumS >= Sum0 then
          Result := pTable.Items[i].m_swTID;
        if SumS < Sum1 then
          Result := pTable.Items[i].m_swTID;
      end;
    end;
end;

procedure TRPGraphDayXLME.PrepareTable;
var
  Meters : SL2TAGREPORTLIST;
  i      : integer;
begin
  if FsgGrid=Nil then exit;

  FsgGrid.ColCount      := 5;
  FsgGrid.RowCount      := 60;
  FsgGrid.Cells[0,0]    := '№ п.п';
  FsgGrid.Cells[1,0]    := 'Наименование учета';
  FsgGrid.Cells[2,0]    := 'Номер счетчика';
  FsgGrid.Cells[3,0]    := 'Коэффициент';
  FsgGrid.Cells[4,0]    := 'Тип счетчика';
  FsgGrid.ColWidths[0]  := 30;

  if not FDB.GetMeterTableForReport(FABOID,GroupID, Meters) then
    FsgGrid.RowCount := 1
  else
  begin
    FsgGrid.RowCount := Meters.Count+1;
    for i := 0 to Meters.Count - 1 do
    begin
      if (Meters.m_sMeter[i].m_sbyType = MET_VZLJOT) then
        continue;
      FsgGrid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
      FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
      FsgGrid.Cells[2,i+1] := Meters.m_sMeter[i].m_sddPHAddres;
      FsgGrid.Cells[3,i+1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
      FsgGrid.Cells[4,i+1] := Meters.m_sMeter[i].m_sName;
    end;
  end;
  OnFormResize;
end;



procedure TRPGraphDayXLME.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
End;



{*******************************************************************************
 *  procedure TRPGraphDayXLME.MakeReport(_Date : TDateTime);
 *  @param _Date : TDateTime Дата на которую создается отчет
 ******************************************************************************}
procedure TRPGraphDayXLME.MakeReport(_Date : TDateTime);
var
  l_GraphDatas : L3GRAPHDATAS;
  l_HHID       : Integer;
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
  m_PH_DiagramTitle := 'График получасовой '+ KindPow[m_KindEnergy] + ' мощности' + ' за ' + FormatDateTime('dd.mm.yyyy', m_Date);

  try  
  FTID        := FDB.LoadTID(QRY_E30MIN_POW_EP + m_KindEnergy);
  Excel.Application.EnableEvents := false;
  Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\'+FileNames[m_KindEnergy]);
  Excel.ActiveSheet.PageSetup.Orientation:= 1;
  Sheet := Excel.Sheets.Item[1];
  Excel.ActiveWorkBook.WorkSheets[1].Activate;
  Sheet.Name := 'График мощности за сутки';
  FProgress.Position := 2;

  // заполнение шапки отчета
  SetPlaceholderValue('#abonentId', m_PH_Contract);
  SetPlaceholderValue('#abonentName', m_PH_AbonentName);
  SetPlaceholderValue('#objectAddress', m_PH_ObjectAddress);
  //SetPlaceholderValue('#objectNumber', m_PH_ObjectNumber);
//  SetPlaceholderValue('#objectName', m_PH_ObjectName);
  SetPlaceholderValue('#meterName', GetGrStringArr(m_PH_MeterName, MAX_STR_CONFIG_LEN));
  SetPlaceholderValue('#graphDescription', m_PH_DiagramTitle);
  FProgress.Position := 3;

  // заполнение получасовых данных
  if (true = FDB.GetGraphDatas(m_Date, m_Date, FVMID, QRY_SRES_ENR_EP + m_KindEnergy,l_GraphDatas)) then
  begin
    Sheet := Excel.Sheets.Item[2];
    Excel.ActiveWorkBook.WorkSheets[2].Activate;
    for l_HHID := 0 to 47 do
    begin
      Excel.ActiveSheet.Range['B'+IntToStr(l_HHID+1)+':B'+IntToStr(l_HHID+1)].Select;
      Excel.ActiveSheet.Range['B'+IntToStr(l_HHID+1)+':B'+IntToStr(l_HHID+1)].Merge;
      Excel.ActiveSheet.Cells[l_HHID+1,2].Value := FloatToStrF(l_GraphDatas.Items[0].v[l_HHID]*2, ffFixed, 18, m_Precision);
    end;
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


function TRPGraphDayXLME.SetPlaceholderValue(_Placeholder : String; _Value : String) : Boolean;
var
  l_Range : Variant;
begin
  Result := false;
  
  if (_Placeholder<>'') then
  begin
    try
      l_Range := Excel.Range['A1:H49'].Replace(What := _Placeholder, Replacement := _Value);
      Result := true;
    except
    end;
  end;
end;


procedure TRPGraphDayXLME.CalcPMaxAndDeltaE(_L3Graph: L3GRAPHDATA);
var
  m_pTariffs        : TM_TARIFFS;
  i     : integer;
  Index : integer;
begin
  for i := 1 to 4 do
  begin
    m_PH_PMT[i]    := 0;
    m_PH_ET[i]     := 0;
    m_PH_PMT_HH[i] := 0;
  end;

  FDB.GetTMTarPeriodsTable(FVMID, FTID + m_KindEnergy, m_pTariffs);
   for i := 0 to 47 do
   begin
     Index := GetColorFromTariffs(i, m_pTariffs);
     if _L3Graph.v[i]*2 > m_PH_PMT[Index] then
       m_PH_PMT[Index] := _L3Graph.v[i]*2;
     Inc(m_PH_PMT_HH[Index]);
     m_PH_ET[Index] := m_PH_ET[Index] + _L3Graph.v[i];
   end;
end;

function TRPGraphDayXLME.FindNumOfGroups(var str: string):integer;
var i, j : integer;
begin
   Result := 1;
   for i := 1 to Length(str) do
   begin
     if (str[i] = '+') or (str[i] = '-') or (str[i] = ':') then
       for j := i + 1 to i + 5 do
         if ((str[j] = 'Г') and (str[j + 1] = 'р')) or (str[j - 1] = ':') then
         begin
           Result := Result + 1;
           break;
         end;
   end;
end;

function TRPGraphDayXLME.GetGrStartPos(var str: string; stFP: integer):integer;
var i, j : integer;
begin
   Result := Length(str);
   for i := stFP to Length(str) do
   begin
     if (str[i] = '+') or (str[i] = '-') or (str[i] = ':') then
       for j := i + 1 to i + 5 do
         if ((str[j] = 'Г') and (str[j + 1] = 'р')) or (str[j - 1] = ':') then
         begin
            Result := j - 1;
            exit;
         end;
   end;
end;

procedure TRPGraphDayXLME.GetGrPos(var str:string; stFindPos:integer; var BP, EP : integer);
begin
   BP := 0;
   EP := 0;
   BP := GetGrStartPos(str, stFindPos);
   EP := GetGrStartPos(str, BP);
end;

function TRPGraphDayXLME.GetGrStringArr(var str : string; maxSymbInStr : integer) : string;
var nCount, tLen    : integer;
    strArr          : array of string;
    i,stP, eP, iP   : integer;
begin
   Result := '';
   iP     := 1;

   nCount := FindNumOfGroups(str);
   SetLength(strArr, nCount);

   for i := 0 to nCount - 1 do
   begin
      GetGrPos(str, iP, stP, eP);
      strArr[i] := Copy(str, iP, stP - iP + 1);
      iP := stP + 1;
   end;

   Result := strArr[0];
   tLen   := Length(strArr[0]);

   for i := 1 to nCount - 1 do
   begin
      tLen := Length(strArr[i]) + tLen;
      if (tLen > maxSymbInStr) then
      begin
        Result := Result + strNewLine;
        tLen   := 0;
      end;
      Result := Result + strArr[i];
   end;
end;


{function TRPGraphDayXLME.CreateReport(_MID : Integer; _Date : TDateTime; ) : Boolean;
begin

end;
 }
end.
