unit knslRPGomelActive;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, utldatabase, BaseGrid, AdvGrid, utltypes, utlTimeDate, FR_DSet, utlconst, utlbox,
  FR_Desgn,utlexparcer;

type
  TRPGomelActive = class(TForm)
    frGomelActive: TfrReport;
    frDesrGomelActive: TfrDesigner;
    procedure frGomelActiveGetValue(const ParName: String;
      var ParValue: Variant);
    procedure frGomelActiveManualBuild(Page: TfrPage);
   private
    { Private declarations }
    FsgGrid           : PTAdvStringGrid;
    GroupID           : integer;
    FABOID            : integer;
    glKoef            : extended;
    MeterN            : string;
    glEnergMB         : array [1..4] of extended;
    glEnergME         : array [1..4] of extended;
    glEnergMT         : array [1..4] of extended;
    glEnergSum        : array [0..1,1..4] of extended;
    glMax             : array [0..1,1..3] of extended;
    glMB              : string[15];
    glME              : string[15];
    globalTitle       : string;
    globalMeterName   : string;
    glSum             : array [1..4] of string;
    SumEnergy         : array [0..3,1..4] of extended;
    globalTblMeter    : string;
    glKindEn          : string;
    globalTblDate     : string[15];
    PlaneName         : string;
    PlaneInd          : integer;
    glCountTable      : integer;
    glCountTableShow  : string;
    glPokEnerg        : string;
    FDB               : PCDBDynamicConn;
    AllMeter          : string;
    Fm_nEVL           : CEvaluator;
    sExpr             : string;
    sExpr1            : array [0..3,1..4] of string;
    SumFormula        : array [0..3,1..4] of extended;
    DateBeg           : TDateTime;
    DateEnd           : TDateTime;
    //////max power
    cb_index          :integer;
    FTID_P, FTID_EP,
    FTID_EM           : integer;
    VMeters           : SL3GROUPTAG;
    m_pTariffs_E      : array [0..1] of TM_TARIFFS;  //Тарифное расписание E+, E-
    m_pTariffs_P      : TM_TARIFFS;
    IsInitTar         : array of boolean;
    SumSl             : array of double;
    MaxP              : array [0..4] of Double;
    FillColorMaxDay   : array [0..3] of TColor;
    singTblMaxSl      : single;
    ItemInd           : Integer;
    globalTtlMainName : string;
    globalTtlNameTbl  : string;
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    procedure FillReportRasx(KEnerg : integer; var Page : TfrPage);
    procedure FillReportSlice(var Page : TfrPage);
    procedure FillRasx(var buf : array of double; KindEn: integer; var Page : TfrPage);
    procedure FillRasxAll(var buf : array of double);
    procedure FindMax;
    procedure FillFormula(VMID : integer; Value : Double);
    function  FindTarName(TID : integer; var TarDisc : TM_TARIFFS): string;
    function  Replace(Str, X, Y: string): string;
    procedure FindValueFormula(tarif:integer;KindEn: byte;mid:string);
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
    procedure OnFormResize;
    procedure PrintPreview(Date1, Date2 : TDateTime;CountTable:integer;ItemIndMaxCtrl:Integer);
    procedure PrepareTable;
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property Pm_nEVL     :CEvaluator       read fm_nEVL      write fm_nEVL;
    property prGroupID   :integer          read GroupID write GroupID;
    property PABOID      :integer          read FABOID       write FABOID;
  end;

var
  RPGomelActive: TRPGomelActive;
  IsFirstLoad  : boolean = true;
const
  strEnergy   : array [0..1] of string = ('1.1 Активная потребляемая(кВт*час)',
                                          '1.2 Активная отдаваемая(кВт*час)');

  IndEn       : array [0..1] of string = ('Активная потребляемая(кВт*ч)',
                                         'Активная отдаваемая(кВт*ч)');

implementation
{$R *.DFM}


procedure TRPGomelActive.PrepareTable;
var Meters : SL2TAGREPORTLIST;
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
   if not FDB.GetMeterGLVTableForReport(FABOID,GroupID,0, Meters) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       FsgGrid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       FsgGrid.Cells[2,i+1] := Meters.m_sMeter[i].m_sddPHAddres;
       FsgGrid.Cells[3,i+1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       FsgGrid.Cells[4,i+1] := Meters.m_sMeter[i].m_sName;
     end;

   end;
   OnFormResize;
end;

procedure TRPGomelActive.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
End;

procedure TRPGomelActive.PrintPreview(Date1, Date2 : TDateTime;CountTable:integer;ItemIndMaxCtrl:Integer);
begin
   if FsgGrid.RowCount = 1 then
     exit;
   DateBeg      := Date1;
   DateEnd      := Date2;
   glCountTable := 1;
   cb_index     := ItemIndMaxCtrl;
   frGomelActive.ShowReport;
end;

function TRPGomelActive.FindTarName(TID : integer; var TarDisc : TM_TARIFFS): string;
var i: integer;
begin
   Result := 'Тариф не определен';
   for i := 0 to TarDisc.Count - 1 do
     if TarDisc.Items[i].m_swTID = TID then
     begin
       Result := TarDisc.Items[i].m_sName;
       exit;
     end;
end;

function TRPGomelActive.Replace(Str, X, Y: string): string;
var
  buf1, buf2, buffer : string;
  i                  : Integer;
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

procedure TRPGomelActive.FindValueFormula(tarif:integer;KindEn: byte;mid:string);
var
   stReplace : string;
   i         : byte;
begin
   stReplace := 'v'+mid + '_P';
   if tarif <> 6 then
     sExpr1[KindEn][tarif] := replace(sExpr1[KindEn][tarif],stReplace,FloatTostr(abs(SumFormula[KindEn][tarif])))
   else
     for i :=1 to 4 do
       sExpr1[KindEn][i] := replace(sExpr1[KindEn][i],stReplace,'0');
end;

function TRPGomelActive.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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

procedure TRPGomelActive.FillFormula(VMID : integer; Value : Double);
begin
   Fm_nEVL.Variable['v' + IntToStr(VMID) + '_P'] := Value;
end;

procedure TRPGomelActive.FillReportRasx(KEnerg : integer; var Page : TfrPage);
var i, j          : integer;
    Data          : CCDatas;
    PokB, PokE    : array of Double;
    IVB, IVE      : boolean;
begin
   glKindEn := strEnergy[KEnerg];
   Page.ShowBandByName('MasterHeader1');
   SetLength(PokB, (StrToInt(FsgGrid.Cells[0, FsgGrid.RowCount - 1]) + 1)*4);
   SetLength(PokE, (StrToInt(FsgGrid.Cells[0, FsgGrid.RowCount - 1]) + 1)*4);
   for i := 0 to Length(PokB) - 1 do
   begin
     PokB[i] := 0;
     PokE[i] := 0;
   end;
   for i := 1 to FsgGrid.RowCount - 1 do
   begin
     globalMeterName := FsgGrid.Cells[1, i];
     MeterN          := FsgGrid.Cells[2, i];
     glKoef          := StrToFloat(FsgGrid.Cells[3, i]);
     IVB := false;
     IVE := false;
     if not FDB.GetGData(DateEnd, DateBeg, StrToInt(FSGGrid.Cells[0, i]),
                         QRY_NAK_EN_DAY_EP + KEnerg, 0, Data) then
       glPokEnerg := 'Н/Д'
     else
     begin
       for j := 0 to Data.Count - 1 do
       begin
         if (trunc(Data.Items[j].m_sTime) = trunc(DateBeg)) and (Data.Items[j].m_swTID <= 3) then
         begin
           IVB := true;
           PokB[Data.Items[j].m_swVMID*4 + Data.Items[j].m_swTID] := RVLEx(Data.Items[j].m_sfValue, glKoef);
         end;
         if (trunc(Data.Items[j].m_sTime) = trunc(DateEnd)) and (Data.Items[j].m_swTID <= 3) then
         begin
           IVE := true;
           PokE[Data.Items[j].m_swVMID*4 + Data.Items[j].m_swTID] := RVLEx(Data.Items[j].m_sfValue, glKoef);
         end;
       end;
     end;
     glPokEnerg   := DVLSEx(PokB[StrToInt(FSGGrid.Cells[0, i])*4] / round(glKoef), glKoef);
     glEnergMB[1] := PokE[StrToInt(FSGGrid.Cells[0, i])*4 + 1] - PokB[StrToInt(FSGGrid.Cells[0, i])*4 + 1];
     glEnergMB[2] := PokE[StrToInt(FSGGrid.Cells[0, i])*4 + 2] - PokB[StrToInt(FSGGrid.Cells[0, i])*4 + 2];
     glEnergMB[3] := PokE[StrToInt(FSGGrid.Cells[0, i])*4 + 3] - PokB[StrToInt(FSGGrid.Cells[0, i])*4 + 3];
     glEnergMB[4] := (glEnergMB[1] + glEnergMB[2] + glEnergMB[3]) ;
     if (not IVB) or (not IVE) then
     begin
       glEnergMB[1] := 0;
       glEnergMB[2] := 0;
       glEnergMB[3] := 0;
       glEnergMB[4] := 0;
     end;
     Page.ShowBandByName('MasterData1');
   end;
   if KEnerg = 0 then
   begin
     for j := 1 to 3 do
     begin
       Fm_nEVL.Expression := sExpr;
       for i := 1 to FsgGrid.RowCount - 1 do
         FillFormula(StrToInt(FSGGrid.Cells[0, i]), PokE[StrToInt(FSGGrid.Cells[0, i])*4 + j] - PokB[StrToInt(FSGGrid.Cells[0, i])*4 + j]);
       glEnergSum[0][j] := Fm_nEVL.Value;
       if (not IVB) or (not IVE) or (glEnergSum[0][j] < 0)  then
         glEnergSum[0][j] := 0;
     end;
     glEnergSum[0][4] := glEnergSum[0][1] + glEnergSum[0][2] + glEnergSum[0][3];
   end;
end;
{
Инфа для
DayCount := trunc(DateEnd) - trunc(DateBeg) + 1;
i - Номер счетчика
j - Дни
k - Номер среза
for j := 0 to DayCount - 1 do
for k := 0 to 47 do
for i := 1 to FsgGrid.RowCount - 1 do
SlBuf[(i-1)*(DayCount)*48 + j*48 + k]
Index := GetColorFromTariffs(j, m_pTariffs) - 1; //Номер тарифа
}
procedure TRPGomelActive.FillRasx(var buf : array of double; KindEn: integer; var Page : TfrPage);
var i, j, k, Index   : integer;
    DayCount, res    : integer;
    pTable           : CCDatasEkom;
begin
   glKindEn := strEnergy[KindEn];
   Page.ShowBandByName('MasterHeader1');
   DayCount := trunc(DateEnd) - trunc(DateBeg) + 1;
   for i := 1 to FSGGrid.RowCount - 1 do
   begin
     globalMeterName := FsgGrid.Cells[1, i];
     MeterN          := FsgGrid.Cells[2, i];
     glKoef          := StrToFloat(FsgGrid.Cells[3, i]);
     for res := 1 to 4 do
       glEnergMB[res] := 0;
     for j := 0 to DayCount - 1 do
       for k := 0 to 47 do
       begin
         Index := GetColorFromTariffs(k, m_pTariffs_E[KindEn]);
         glEnergMB[Index] := glEnergMB[Index] + buf[(i-1)*(DayCount)*48 + j*48 + k];
       end;
     glEnergMB[4] := (glEnergMB[1] + glEnergMB[2] + glEnergMB[3]) ;
     PDB.GetEKOM3000GData(DateEnd, DateBeg, StrToInt(FsgGrid.Cells[0, i]),  StrToInt(FsgGrid.Cells[0, i]),
                        QRY_NAK_EN_DAY_EP + KindEn, QRY_NAK_EN_DAY_EP + KindEn, pTable);
     if (pTable.Count > 0) and (trunc(pTable.Items[0].m_sTime) = trunc(DateBeg)) then
       glPokEnerg := FloatToStr(RVLPr(pTable.Items[0].m_sfValue/StrToFloat(FsgGrid.Cells[3, i]), MeterPrecision[StrToInt(FsgGrid.Cells[0, i])]))
     else
       glPokEnerg := '0';
     Page.ShowBandByName('MasterData1');    //Данные о потреблении
   end;
end;

procedure TRPGomelActive.FillRasxAll(var buf : array of double);
var i, j, k, Index   : integer;
    DayCount, res    : integer;
begin
   for i := 1 to 4 do
     glEnergSum[0][i] := 0;
   for i := 0 to Length(buf) - 1 do
   begin
     Index := GetColorFromTariffs(i mod 48, m_pTariffs_E[0]);
     glEnergSum[0][Index] := glEnergSum[0][Index] + buf[i];
   end;
   glEnergSum[0][4] := glEnergSum[0][1] + glEnergSum[0][2] + glEnergSum[0][3];
end;

procedure TRPGomelActive.FindMax;
var i     : integer;
    Index : integer;
begin
   for i := 0 to 4 do
     MaxP[i] := 0;
   for i := 0 to Length(SumSl) - 1 do
   begin
     Index := GetColorFromTariffs(i mod 48, m_pTariffs_P);
     if SumSl[i]*2 > MaxP[Index] then
       MaxP[Index] := SumSl[i]*2;
   end;
   for i := 1 to 4 do
     if MaxP[i] > MaxP[0] then
       MaxP[0] := MaxP[i];
end;

procedure TRPGomelActive.FillReportSlice(var Page : TfrPage);
var i, j, k      : integer;
    m_pGrData    : L3GRAPHDATAS;
    DayCount     : integer;
    SlBuf        : array of Double;
    KindEn       : integer;
begin
   DayCount := trunc(DateEnd) - trunc(DateBeg) + 1;
   SetLength(SlBuf, DayCount*(FsgGrid.RowCount - 1)*48);
   for KindEn := 0 to 1 do
   begin
     for i := 0 to Length(SlBuf) - 1 do
       SlBuf[i] := 0;
     for i := 1 to FsgGrid.RowCount - 1 do
     begin
       if not FDB.GetGraphDatas(DateEnd, DateBeg, StrToInt(FSGGrid.Cells[0, i]),
                                  QRY_SRES_ENR_EP + KindEn, m_pGrData) then
         continue
       else
       begin
         for j := 0 to m_pGrData.Count - 1 do
           for k := 0 to 47 do
             SlBuf[(i-1)*(DayCount)*48 + (trunc(m_pGrData.Items[j].m_sdtDate) - trunc(DateBeg))*48 + k] := m_pGrData.Items[j].v[k];
       end;
     end;
//
//   Page.ShowBandByName('MasterHeader2');
//   Page.ShowBandByName('MasterData2');    //Данные суммарном потреблении
//   Page.ShowBandByName('MasterHeader3');
//   Page.ShowBandByName('MasterData3');    //Данные максимуме
     FillRasx(SlBuf, KindEn, Page);
     if KindEn = 0 then
     begin
       SetLength(SumSl, DayCount*48);
       for i := 0 to Length(SumSl) - 1 do
         SumSl[i] := 0;
       for j := 0 to DayCount - 1 do
         for k := 0 to 47 do
         begin
           Fm_nEVL.Expression := sExpr;
           for i := 1 to FsgGrid.RowCount - 1 do
             FillFormula(StrToInt(FSGGrid.Cells[0, i]), SlBuf[(i-1)*(DayCount)*48 + j*48 + k]);
           SumSl[j*48 + k] := Fm_nEVL.Value;
         end;
       FindMax;
       FillRasxAll(SumSl);
     end;
  end;
end;

procedure TRPGomelActive.frGomelActiveManualBuild(Page: TfrPage);
var  i,j,r                         : integer;
     Month,Month1, Year,Year1, Day : word;
     TempDate                      : TDateTime;
     pGT                           : SL3GROUPTAG;
     KindEn                        : byte;
begin
 ////инициализация формулы
   sExpr := m_pDB.GetMSGROUPEXPRESS(FABOID,GroupID,pGT);
   if (sExpr = '[x]') or (sExpr = '') then
   begin
     sExpr := '';
     sExpr := 'v' + FsgGrid.Cells[0, 1] + '_P';
     for i := 2 to FsgGrid.RowCount - 1 do
       sExpr := sExpr + ' + ' + 'v' + FsgGrid.Cells[0, i] + '_P';
   end;
   fm_nEVL.Expression := sExpr;
   for i:=1 to 4 do
     for j:=0 to 3 do
       sExpr1[j][i] := sExpr;
   TempDate  := DateBeg;
   DecodeDate(DateBeg, Year, Month, Day);
   globalTitle :='АКТИВНАЯ ЭЛЕКТРОЭНЕРГИЯ И МОЩНОСТЬ';
   glMB := DateToStr(DateBeg);
   glME := DateToStr(DateEnd);
   glCountTableShow := 'Таблица № 1';
   Page.ShowBandByType(btReportTitle);
   {for KindEn := 0 to 1 do       !!!   Закоментирована из-за расчета расхода по срезам
     FillReportRasx(KindEn, Page);
   Page.ShowBandByName('MasterHeader2');
   Page.ShowBandByName('MasterData2');
   ////max power//////////////////////////////
   Page.ShowBandByName('MasterHeader3');   }
   FTID_EP   := FDB.LoadTID(QRY_SRES_ENR_EP);
   FTID_EM   := FDB.LoadTID(QRY_SRES_ENR_EM);
   FTID_P    := FDB.LoadTID(QRY_E30MIN_POW_EP);
   PlaneInd := FDB.GetTMTarPeriodsTableGr(GroupID, FTID_EP, m_pTariffs_E[0]);
   FDB.GetTMTarPeriodsTableGr(GroupID, FTID_EM, m_pTariffs_E[1]);
   FDB.GetTMTarPeriodsTableGr(GroupID, FTID_P, m_pTariffs_P);
   PlaneName := FDB.GetPlaneName(PlaneInd);
   FillReportSlice(Page);
   Page.ShowBandByName('MasterHeader2');
   Page.ShowBandByName('MasterData2');    //Данные суммарном потреблении
   Page.ShowBandByName('MasterHeader3');
   Page.ShowBandByName('MasterData3');    //Данные максимуме
   ////////////////////////////
   Page.ShowBandByName('PageFooter1');
   //FsgGrid := nil;
   fm_nEVL := nil;
end;

procedure TRPGomelActive.frGomelActiveGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'CountTbl'       then ParValue := glCountTableShow;
   if ParName = 'TblDate'        then ParValue := globalTblDate;
   if ParName = 'WorksName'      then ParValue := WorksName;
   if ParName = 'TtlMainName'    then ParValue := globalTitle;
   if ParName = 'DateB'          then ParValue := glMB;
   if ParName = 'DateE'          then ParValue := glME;
   if ParName = 'MDNameCounter'  then ParValue := globalMeterName;
   if ParName = 'KindEn'         then ParValue := glKindEn;
   if ParName = 'TblMeter'       then ParValue := globalTblMeter;
   if ParName = 'MeterN'         then ParValue := MeterN;
   if ParName = 'PokEnerg'       then ParValue := glPokEnerg;

   if ParName = 'EnerT1SumP'     then ParValue := DVLS(glEnergSum[0][1]);
   if ParName = 'EnerT2SumP'     then ParValue := DVLS(glEnergSum[0][2]);
   if ParName = 'EnerT3SumP'     then ParValue := DVLS(glEnergSum[0][3]);
   if ParName = 'EnerT4SumP'     then ParValue := DVLS(glEnergSum[0][4]);

   if ParName = 'EnerT1SumR'     then ParValue := DVLSEx(glEnergSum[1][1], glKoef);
   if ParName = 'EnerT2SumR'     then ParValue := DVLSEx(glEnergSum[1][2], glKoef);
   if ParName = 'EnerT3SumR'     then ParValue := DVLSEx(glEnergSum[1][3], glKoef);
   if ParName = 'EnerT4SumR'     then ParValue := DVLSEx(glEnergSum[1][4], glKoef);

   if ParName = 'MaxP1'          then ParValue := DVLS(maxP[0]);
   if ParName = 'MaxP2'          then ParValue := DVLS(maxP[1]);
   if ParName = 'MaxP3'          then ParValue := DVLS(maxP[2]);
   if ParName = 'MaxPA'          then ParValue := DVLS(0);

   if ParName = 'MaxR1'          then ParValue := DVLS(maxP[0]);
   if ParName = 'MaxR2'          then ParValue := DVLS(maxP[1]);
   if ParName = 'MaxR3'          then ParValue := DVLS(maxP[2]);

  // glKoef
   if ParName = 'EnerT1MB'       then ParValue := DVLSEx(glEnergMB[1], glKoef);
   if ParName = 'EnerT2MB'       then ParValue := DVLSEx(glEnergMB[2], glKoef);
   if ParName = 'EnerT3MB'       then ParValue := DVLSEx(glEnergMB[3], glKoef);
   if ParName = 'EnerTsMB'       then ParValue := DVLSEx(glEnergMB[4], glKoef);
   if ParName = 'KoefT1'         then ParValue := DVLSEx(glKoef, glKoef);

   if ParName = 'FirstSign'      then ParValue := FirstSign;
   if ParName = 'SecondSign'     then ParValue := SecondSign;
   if ParName = 'ThirdSign'      then ParValue := ThirdSign;
   if ParName = 'KindEnTtl'      then ParValue := glKindEn;
   if ParName = 'EnergT1Ttl'     then ParValue := glSum[1];
   if ParName = 'EnergT2Ttl'     then ParValue := glSum[2];
   if ParName = 'EnergT3Ttl'     then ParValue := glSum[3];
   if ParName = 'EnergTsTtl'     then ParValue := glSum[4];
   if ParName = 'NDogovor'       then ParValue := NDogovor;
   if ParName = 'NameObject'     then begin ParValue := NameObject; exit; end;
   if ParName = 'Adress'         then begin ParValue := Adress; exit; end;
   if ParName = 'AllMeter'       then ParValue := AllMeter;

   if ParName = 'TarName1'       then ParValue := FindTarName(1, m_pTariffs_E[0]);
   if ParName = 'TarName2'       then ParValue := FindTarName(2, m_pTariffs_E[0]);
   if ParName = 'TarName3'       then ParValue := FindTarName(3, m_pTariffs_E[0]);
   if ParName = 'PTarName1'      then ParValue := FindTarName(1, m_pTariffs_P);
   if ParName = 'PTarName2'      then ParValue := FindTarName(2, m_pTariffs_P);
   if ParName = 'TarifPlane'     then ParValue := PlaneName;
end;
{m_pTariffs_E      : array [0..1] of TM_TARIFFS;  //Тарифное расписание E+, E-
    m_pTariffs_P      : TM_TARIFFS;            FindTarName           }
end.
