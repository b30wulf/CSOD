unit knslRPMaxLoadPower;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, StdCtrls, utldatabase, utlTimeDate, utltypes, utlconst,
  Grids, BaseGrid, AdvGrid, ComCtrls, Menus, ToolWin, ExtCtrls, jpeg,
  ImgList, utlbox,knslRPMaxLoadPowerXL,knsl5config, AdvToolBar,
  AdvSplitter, AdvPanel;

type
  TrpMaxPowerLoad = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    ImageList1: TImageList;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    AdvPanel3: TAdvPanel;
    AdvPanel4: TAdvPanel;
    AdvPanel5: TAdvPanel;
    AdvPanel6: TAdvPanel;
    ProgressBar1: TProgressBar;
    Label6: TLabel;
    AdvSplitter1: TAdvSplitter;
    AdvStringGrid1: TAdvStringGrid;
    AdvStringGrid2: TAdvStringGrid;
    lbGenSettings: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    cbGroup: TComboBox;
    cbTariff: TComboBox;
    dtDate: TDateTimePicker;
    cbKindEnerg: TComboBox;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarButton1: TAdvToolBarButton;
    AdvToolBarButton2: TAdvToolBarButton;
    AdvToolBarButton3: TAdvToolBarButton;
    procedure Button2Click(Sender: TObject);
    procedure AdvStringGrid1DblClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure FormShow(Sender: TObject);
    procedure cbGroupChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure cbKindEnergChange(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure OnGetCellColorEvent(Sender: TObject; ARow, ACol: Integer;
              AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnFormResize(Sender: TObject);
    procedure ToolButtonOnXLReport(Sender: TObject);
  private
    { Private declarations }
    FDB               : PCDBDynamicConn;
    globalTblTName    : array [0..4] of string;
    m_pTariffs        : TM_TARIFFS;
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
    Koef              : array [0..99] of Double;
    storeKoef         : array [0..99] of Double;
    globalRasxSum     : string[20];
    globalKindEnergy  : string;
    globalDate        : string[20];
    globalMaxPower    : string;
    maxSrez           : Double;
    FABOID            : Integer;
    function  DateOutSec(Date : TDateTime) : string;
    function  FindMaxInSrez(mas : array of Double) : Double;
    procedure FillReport(var Page: TfrPage);
    procedure FillReportSum(var Page: TfrPage);
    procedure FillReportMax(var Page: TfrPage);
    procedure LoadTariffs();
    function  IsThisTarif(Srez:byte):boolean;
    function  IsVMIDInTable(VMID : integer):boolean;
    procedure DeleteAll;
  public
    { Public declarations }

    globalWorksName   : string;
    FirstSign         : string;
    ThirdSign         : string;
    SecondSign        : string;
    NameObject        : string;
    Adress            : string;
    m_strObjCode      : string;
    NDogovor          : string;
  public
    property PDB      : PCDBDynamicConn  read FDB          write FDB;
    property PABOID   :Integer           read FABOID       write FABOID;

  end;

var
  rpMaxPowerLoad: TrpMaxPowerLoad;
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

{$R *.DFM}

procedure TrpMaxPowerLoad.OnGetCellColorEvent(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    AFont.Name := 'Times New Roman';
    with (Sender AS TAdvStringGrid)  do
    Begin
     if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and (not(gdSelected in AState) or (gdFocused in AState)) then
     begin
     // if (ACol<>0)and(ARow<>0) then ABrush.Color := clTeal;
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
        //AFont.Style := [fsItalic];
        case ACol of
         1,3,2,4      : AFont.Color := clBlack;{clAqua;}
         //3          : AFont.Color := clLime;
         {
          4      : AFont.Color := clRed;
          2,5,10 : AFont.Color := clLime;
          6,7    : AFont.Color := clAqua;
          8      : AFont.Color := clWhite;
         }
        End;
      End;
    End;
end;

procedure TrpMaxPowerLoad.DeleteAll;
var i : integer;
begin
   for i := 1 to AdvStringGrid2.RowCount - 1 do
   begin
     AdvStringGrid2.Cells[0,i] := '';
     AdvStringGrid2.Cells[1,i] := '';
   end;
   AdvStringGrid2.RowCount := 2;
end;

function TrpMaxPowerLoad.FindMaxInSrez(mas : array of Double) : Double;
var i      : byte;
    res    : Double;
    IsInit : boolean;
begin
   IsInit := false;
   for i := 0 to 47 do
     if (mas[i] > res) and (IsThisTarif(i)) then
       if IsInit then
         res := mas[i]
       else
                       begin
         res    := mas[i];
         IsInit := true;
       end;
   Result := res;
end;

function TrpMaxPowerLoad.DateOutSec(Date : TDateTime) : string;
var str : string;
begin
   str := TimeToStr(Date);
   SetLength(str, Length(str) - 3);
   Result := str;
end;

function TrpMaxPowerLoad.IsThisTarif(Srez:byte):boolean;
var SumS                         : word;
    Hour0, Min0, Sec0, ms0, Sum0 : word;
    Hour1, Min1, Sec1, ms1, Sum1 : word;
    i                            : byte;
begin
    SumS   := 30 * Srez;
    for i := 1 to m_pTariffs.Count - 1 do
    begin
      DecodeTime(m_pTariffs.Items[cbTariff.ItemIndex].m_dtTime0, Hour0, Min0, Sec0, ms0);
      DecodeTime(m_pTariffs.Items[cbTariff.ItemIndex].m_dtTime1, Hour1, Min1, Sec1, ms1);
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

procedure TrpMaxPowerLoad.LoadTariffs();
var i : integer;
begin
  cbTariff.Items.Clear;
  FDB.GetTMTarPeriodsTable(-1, FTID + cbKindEnerg.ItemIndex, m_pTariffs);
  for i := 0 to m_pTariffs.Count - 1 do
    cbTariff.Items.Add(m_pTariffs.Items[i].m_sName + '(' + DateOutSec(m_pTariffs.Items[i].m_dtTime0) +
                        ' - ' + DateOutSec(m_pTariffs.Items[i].m_dtTime1) + ')');
  cbTariff.ItemIndex := 1;
end;

procedure TrpMaxPowerLoad.Button2Click(Sender: TObject);
begin
   DeleteAll;
end;

function  TrpMaxPowerLoad.IsVMIDInTable(VMID : integer):boolean;
var i : integer;
begin
   Result := false;
   for i := 1 to AdvStringGrid2.RowCount - 2  do
    if VMID = StrToInt(AdvStringGrid2.Cells[0, i]) then
      Result := true;
end;

procedure TrpMaxPowerLoad.AdvStringGrid1DblClickCell(Sender: TObject; ARow,
  ACol: Integer);
var Meters : SL2TAGREPORTLIST;
         i : integer;
    VMID   : integer;
begin
   if ARow <= 0  then
     exit;
   //if ARow = AdvStringGrid1.RowCount - 1 then
   //  exit;
   if cbGroup.ItemIndex = 1 then
   begin
     VMID := StrToInt(AdvStringGrid1.Cells[0, ARow]);
     if IsVMIDInTable(VMID) then
       exit;
     AdvStringGrid2.Cells[0, AdvStringGrid2.RowCount - 1] := AdvStringGrid1.Cells[0, ARow];
     AdvStringGrid2.Cells[1, AdvStringGrid2.RowCount - 1] := AdvStringGrid1.Cells[1, ARow];
     Koef[AdvStringGrid2.RowCount - 1]                    := storeKoef[VMID];
     AdvStringGrid2.RowCount := AdvStringGrid2.RowCount + 1;
   end
   else
   begin
     if not FDB.GetMeterTableForReport(FABOID,StrToInt(AdvStringGrid1.Cells[0, ARow]), Meters) then
       exit
     else
     begin
       for i := 0 to Meters.Count - 1 do
       begin
         if IsVMIDInTable(Meters.m_sMeter[i].m_swVMID) then
           continue;
         //if Meters.m_sMeter[i].m_sbyType = MET_SUMM then
         //  continue;
         AdvStringGrid2.Cells[1,AdvStringGrid2.RowCount - 1] := Meters.m_sMeter[i].m_sVMeterName;
         AdvStringGrid2.Cells[0,AdvStringGrid2.RowCount - 1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
         Koef[AdvStringGrid2.RowCount - 1]                   := Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU;
         AdvStringGrid2.RowCount := AdvStringGrid2.RowCount + 1;
       end;
     end;
   end;
end;

procedure TrpMaxPowerLoad.FormShow(Sender: TObject);
var Meters : SL2TAGREPORTLIST;
    Groups : SL3INITTAG;
         i : integer;
begin
  FTID := FDB.LoadTID(QRY_E30MIN_POW_EP{ + cbKindEnerg.ItemIndex});

  AdvStringGrid1.ColCount    := 2;
  AdvStringGrid2.ColCount    := 2;
  AdvStringGrid1.Cells[1, 0] := 'Наименование точки учета';
  AdvStringGrid1.Cells[0, 0] := 'VMID';
  AdvStringGrid2.Cells[1, 0] := 'Наименование точки учета';
  AdvStringGrid2.Cells[0, 0] := 'VMID';
  AdvStringGrid1.ColWidths[0]:= 30;
  AdvStringGrid2.ColWidths[0]:= 30;
  //FsgGrid.ColWidths[1]:= 40;
  //FsgGrid.ColWidths[2]:= 50;
  //sgGrid.ColWidths[3]:= 400;
  if cbGroup.ItemIndex = 1 then
  begin
    if not FDB.GetMeterTableForReport(FABOID,-1, Meters) then
      AdvStringGrid1.RowCount := 1
    else
    begin
      AdvStringGrid1.RowCount := 1;
      for i := 0 to Meters.Count - 1 do
       begin
         //if Meters.m_sMeter[i].m_sbyType = MET_SUMM then
         //  continue;
         if Meters.m_sMeter[i].m_sbyType = MET_VZLJOT then
           continue;
         AdvStringGrid1.Cells[0,AdvStringGrid1.RowCount] := IntToStr(Meters.m_sMeter[i].m_swVMID);
         AdvStringGrid1.Cells[1,AdvStringGrid1.RowCount] := Meters.m_sMeter[i].m_sVMeterName;
         AdvStringGrid1.RowCount := AdvStringGrid1.RowCount + 1;
         storeKoef[Meters.m_sMeter[i].m_swVMID] := Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU;
       end;
    end;
  end
  else
  begin
    if not FDB.GetAbonGroupsTable(FABOID,Groups) then
      exit
    else
    begin
      AdvStringGrid1.RowCount := Groups.Count + 1;
      for i := 0 to Groups.Count - 1 do
      begin
        AdvStringGrid1.Cells[0, i + 1] := IntToStr(Groups.Items[i].m_sbyGroupID);
        AdvStringGrid1.Cells[1, i + 1] := Groups.Items[i].m_sGroupName;
      end;
    end;
  end;
  cbKindEnerg.ItemIndex := 0;
  dtDate.DateTime       := Now;
  cbGroup.ItemIndex     := 0;
  LoadTariffs;
  DeleteAll;
end;

procedure TrpMaxPowerLoad.cbGroupChange(Sender: TObject);
var Meters : SL2TAGREPORTLIST;
    Groups : SL3INITTAG;
         i : integer;
begin
  DeleteAll;
   if cbGroup.ItemIndex = 1 then
  begin
    if not FDB.GetMeterTableForReport(FABOID,-1, Meters) then
      AdvStringGrid1.RowCount := 1
    else
    begin
      AdvStringGrid1.RowCount := 1;
      for i := 0 to Meters.Count - 1 do
       begin
         //if Meters.m_sMeter[i].m_sbyType = MET_SUMM then
         //  continue;
         AdvStringGrid1.Cells[0,AdvStringGrid1.RowCount] := IntToStr(Meters.m_sMeter[i].m_swVMID);
         AdvStringGrid1.Cells[1,AdvStringGrid1.RowCount] := Meters.m_sMeter[i].m_sVMeterName;
         AdvStringGrid1.RowCount := AdvStringGrid1.RowCount + 1;
         storeKoef[Meters.m_sMeter[i].m_swVMID] := Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU;
       end;
    end;
  end
  else
  begin
    if not FDB.GetAbonGroupsTable(FABOID,Groups) then
      exit
    else
    begin
      AdvStringGrid1.RowCount := Groups.Count + 1;
      for i := 0 to Groups.Count - 1 do
      begin
        AdvStringGrid1.Cells[0, i + 1] := IntToStr(Groups.Items[i].m_sbyGroupID);
        AdvStringGrid1.Cells[1, i + 1] := Groups.Items[i].m_sGroupName;
      end;
    end;
  end;
end;

procedure TrpMaxPowerLoad.Button1Click(Sender: TObject);
begin
   frReport1.ShowReport;
   Close;
end;

procedure  TrpMaxPowerLoad.FillReport(var Page: TfrPage);
var i         : byte;
    MID       : integer;
    Data      : CCDatas;
    m_pGrData : L3GRAPHDATAS; 
    TempDate  : TDateTime;
begin
   for MID := 1 to AdvStringGrid2.RowCount - 2 do
   begin
     TempDate := dtDate.DateTime;
     globalPointName := AdvStringGrid2.Cells[1, MID];
     Page.ShowBandByName('MasterHeader1');
     RasxSum[0] := 0;
     cDateTimeR.DecDate(TempDate);
     if FDB.GetGData(TempDate, TempDate, StrToInt(AdvStringGrid2.Cells[0, MID]),
                         QRY_NAK_EN_DAY_EP + cbKindEnerg.ItemIndex, 0, Data) then
     begin
       for i := 0 to Data.Count - 1 do
        if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <> 4) then
          RasxSum[0]    := RasxSum[0] + Data.Items[i].m_sfValue;
     end;

     if not FDB.GetGraphDatas(dtDate.DateTime, dtDate.DateTime, StrToInt(AdvStringGrid2.Cells[0, MID]),
                              QRY_SRES_ENR_EP + cbKindEnerg.ItemIndex, m_pGrData) then
     begin
       SetLength(m_pGrData.Items, 1);
       FillChar(m_pGrData.Items[0].v, 192, 0);
     end;
     if FindMaxInSrez(m_pGrData.Items[0].v)*2 > maxSrez then
       maxSrez := FindMaxInSrez(m_pGrData.Items[0].v)*2;
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
       if IsThisTarif(i) then
         Page.ShowBandByName('MasterData1');
     end;
   end;
end;

procedure TrpMaxPowerLoad.FillReportSum(var Page: TfrPage);
var i : byte;
begin
  Page.ShowBandByName('MasterHeader2');
  for i := 0 to 47 do
  begin
    if i mod 2 = 0 then
      globalTimeSum := IntToStr(i div 2) + ':' + '00' + ' - ' + IntToStr((i + 1) div 2) + ':' + IntToStr(((i + 1) mod 2)*30)
    else
      globalTimeSum := IntToStr(i div 2) + ':' + IntToStr((i mod 2)*30) + ' - ' + IntToStr((i + 1) div 2) + ':' + '00';
    globalRasxSum := DVLS(PowerSum[i]);
    if IsThisTarif(i) then
      Page.ShowBandByName('MasterData2');
  end;
end;

procedure TrpMaxPowerLoad.FillReportMax(var Page: TfrPage);
begin
   if CheckBox1.Checked then
     maxSrez := FindMaxInSrez(PowerSum);
   globalMaxPower := 'Максимальная мощность равна: ' + DVLS(maxSrez);
   Page.ShowBandByName('MasterData3');
end;

procedure TrpMaxPowerLoad.frReport1ManualBuild(Page: TfrPage);
var i : integer;
begin
  for i := 0 to 47 do
    PowerSum[i] := 0;
  maxSrez := 0;
  Page.ShowBandByType(btReportTitle);
  FillReport(Page);
  if CheckBox1.Checked then
    FillReportSum(Page);
  FillReportMax(Page);
  Page.ShowBandByName('PageFooter1');
end;

procedure TrpMaxPowerLoad.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'WorksName'     then ParValue := globalWorksName;
   if ParName = 'KindEnergy'    then ParValue := strEnergy[cbKindEnerg.ItemIndex];
   if ParName = 'Date'          then ParValue := DateToStr(dtDate.DateTime);
   if ParName = 'PointName'     then ParValue := 'Точка учета: ' + globalPointName;
   if ParName = 'Time'          then ParValue := globalTime;
   if ParName = 'PokazCounter'  then ParValue := globalPokazCounter;
   if ParName = 'SubCounter'    then ParValue := globalSubCounter;
   if ParName = 'RasxCounter'   then ParValue := globalRasxCounter;
   if ParName = 'TimeSum'       then ParValue := globalTimeSum;
   if ParName = 'RasxSum'       then ParValue := globalRasxSum;
   if ParName = 'FirstSign'     then ParValue := FirstSign;
   if ParName = 'ThirdSign'     then ParValue := ThirdSign;
   if ParName = 'SecondSign'    then ParValue := SecondSign;
   if ParName = 'MaxPower'      then ParValue := globalMaxPower + ' ' + strEK[cbKindEnerg.ItemIndex];
   if ParName = 'NameObject'    then begin ParValue := NameObject; exit; end;
   if ParName = 'Adress'        then begin ParValue := Adress; exit; end;
end;

procedure TrpMaxPowerLoad.cbKindEnergChange(Sender: TObject);
begin
   LoadTariffs;
end;

procedure TrpMaxPowerLoad.N2Click(Sender: TObject);
begin
  DeleteAll;
end;

procedure TrpMaxPowerLoad.OnFormResize(Sender: TObject);
Var
    i : Integer;
Begin
    for i:=1 to AdvStringGrid1.ColCount-1  do AdvStringGrid1.ColWidths[i]  := trunc((AdvStringGrid1.Width-(0)-2*AdvStringGrid1.ColWidths[0])/(AdvStringGrid1.ColCount-1));
    for i:=1 to AdvStringGrid2.ColCount-1  do AdvStringGrid2.ColWidths[i]  := trunc((AdvStringGrid2.Width-(0)-2*AdvStringGrid2.ColWidths[0])/(AdvStringGrid2.ColCount-1));
end;

procedure TrpMaxPowerLoad.ToolButtonOnXLReport(Sender: TObject);
var
i:byte;
begin
  RPMaxLoadPowerXL                 := TRPMaxLoadPowerXL.Create;
  ProgressBar1.Enabled := true;
  ProgressBar1.Visible := true;
  ProgressBar1.Align   := AlClient;
  rpMaxLoadPowerXL.globalWorksName := globalWorksName;
  rpMaxLoadPowerXL.NDogovor        := NDogovor;
  rpMaxLoadPowerXL.FirstSign       := FirstSign;
  rpMaxLoadPowerXL.SecondSign      := SecondSign;
  rpMaxLoadPowerXL.ThirdSign       := ThirdSign;
  rpMaxLoadPowerXL.NameObject      := NameObject;
  rpMaxLoadPowerXL.Adress          := Adress;
  RPMaxLoadPowerXL.PsgGrid1    := @AdvStringGrid1;
  RPMaxLoadPowerXL.PsgGrid2    := @AdvStringGrid2;
  RPMaxLoadPowerXL.KindEnergy  := cbKindEnerg.ItemIndex;
  RPMaxLoadPowerXL.DateBeg     := dtDate.DateTime;
  RPMaxLoadPowerXL.BChecked    := CheckBox1.Checked;
  RPMaxLoadPowerXL.prTarifID   := cbTariff.ItemIndex;
  RPMaxLoadPowerXL.PDB         := rpMaxPowerLoad.PDB;
  RPMaxLoadPowerXL.PProgress   := @ProgressBar1;
  for i := 0 to 99 do
    RPMaxLoadPowerXL.Koef[i] := Koef[i];
  // RPMaxLoadPowerXL.prGroupID  := GroupsIndexes[cbGroup.ItemIndex];
  RPMaxLoadPowerXL.CreatReport(m_pTariffs);
end;

end.
