unit knslRPSummVedom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, BaseGrid, AdvGrid, IniFiles,
  utlconst, utltypes, utldatabase, utlTimeDate, utlbox, utlexparcer;

type
  TRPSummVedom = class(TForm)
    frReport: TfrReport;
    procedure frReportGetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReportManualBuild(Page: TfrPage);
  private
    { Private declarations }
    FDB                         : PCDBDynamicConn;
    FsgGrid                     : PTAdvStringGrid;
    mDate                       : TDateTime;
    IsUsePokNow                 : boolean;
    mReportName                 : string;
    mContractNumber             : string;
    mAbonentName                : string;
    mAbonentAddress             : string;
    mMeterNamePow               : string;
    mKindEnergyPow              : string;
    mTPowName                   : string;
    mEnerDtPowM                 : string;
    mEnerTmPowM                 : string;
    mMaxPower                   : string;
    mCurrentMeterName           : string;
    mCurrentMeterNumber         : string;
    mKTE                        : string;
    mKindEnergy                 : string;
    mTName                      : string;
    mEnerT1MB                   : string;
    mEnerT1ME                   : string;
    mEnerT1Sub                  : string;
    mEnerT1Rasx                 : string;
    mKindEnergyLose             : string;
    mTNameLose                  : string;
    mEnerT1RasxLose             : string;
    mBeginDate                  : TDateTime;
    mEndDate                    : TDateTime;
    mSumVedomStr                : STRPSUMMVEDOM;
    mAbonInfo                   : SL3ABONS;
    mTariffs                    : TM_TARIFFS;
    mIsPokEn                    : array [0..3] of boolean;
    mIsPowEn                    : boolean;
    m_UseZeroTariff             : Boolean;
    mMaxValuesT                 : array [0..5] of double;
    mMaxDatesT                  : array [0..5] of TDateTime;
    mBegMPok                    : array [1..9] of double;
    mEndMPok                    : array [1..9] of double;
    mRaznPok                    : array [1..9] of double;
    procedure LoadSumVedomStruct;
    procedure LoadAbonInfo;
    procedure OnFormResize;
    procedure CreateDataAbon(i: integer);
    procedure ShowBandMaxP(ABN : integer; var Page: TfrPage);
    procedure ShowPokEnBand(ABN : integer; var Page: TfrPage);
    procedure ShowPokEnBandWithoutTRET(ABN : integer; var Page: TfrPage);
    procedure ShowPokEnBandTRET(var MeterInfo : SL2TAGREPORT; KE: integer; var Page :TfrPage);
    procedure CalcTretVariables(var Page :TfrPage; VMID, KE, TID : integer);
    procedure FindPokMeter(VMID, KindEn : integer; KT: double);
    //procedure ShowTRET(var Page :TfrPage; VMID, KE : integer);
    procedure FindMaxValues(VMID, KindEn : integer);
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    function  GetPowTarifName(KindEn, k: integer): string;
    function  AllowPower(KindEn, Tar: integer): boolean;
  public
    { Public declarations }
    procedure PrintPreview(Date : TDateTime);
    procedure PrepareTable;
  public
    property PsgGrid  : PTAdvStringGrid  read FsgGrid     write FsgGrid;
    property PDB      : PCDBDynamicConn  read FDB         write FDB;
    property UseZeroTariff : Boolean read m_UseZeroTariff  write m_UseZeroTariff;
  end;

var
  RPSummVedom: TRPSummVedom;

const
  c_EnergyTitles : array [0..3] of String = (
    'Активная принимаемая (кВт·ч)',
    'Активная выдаваемая (кВт·ч)',
    'Реактивная принимаемая (квар·ч)',
    'Реактивная выдаваемая (квар·ч)'
  );

  c_PowerTitles : array [0..3] of String = (
    'Активная принимаемая (кВт)',
    'Активная выдаваемая (кВт)',
    'Реактивная принимаемая (квар)',
    'Реактивная выдаваемая (квар)'
  );

  c_LEnergyTitles : array [0..3] of String = (
    'Потери ТРЭТ (активная принимаемая) (кВт·ч)',
    '',
    'Потери ТРЭТ (реактивная принимаемая) (квар·ч)',
    ''
  );

  c_TariffsNamesE : array [0..4] of String = (
    'Максимум из тарифов',
    'Утренний максимум',
    'Вечерний максимум',
    'День',
    'Ночь'
  );

  c_TariffsNamesR : array [0..4] of String = (
    'Максимум из тарифов',
    'Утренний максимум',
    'Вечерний максимум',
    'День',
    'Ночь'
  );
  c_PokTarNames : array [1..9] of String = (
    'Т1 (A) Полупиковая',
    'Т2 (B) Ночная',
    'Т3 (C) Пиковая',
    'Т4 (D)',
    'Т5 (E)',
    'Т6 (F)',
    'Т7 (G)',
    'Т8 (H)',
    'Тсум Сумма'
  );

implementation

{$R *.DFM}

procedure TRPSummVedom.OnFormResize;
var
    i : Integer;
begin
    if PsgGrid=nil then exit;
    for i:=1 to PsgGrid.ColCount-1 do
      PsgGrid.ColWidths[i] := trunc((PsgGrid.Width-2*PsgGrid.ColWidths[0])/(PsgGrid.ColCount-1));
end;

procedure TRPSummVedom.PrepareTable;
var Abons  : SL3ABONS;
    i      : integer;
begin
   if FsgGrid=Nil then
     exit;
   FsgGrid.ColCount   := 3;
   FsgGrid.Cells[0,0] := '№ п.п';
   FsgGrid.Cells[1,0] := 'Наименование абонента';
   FsgGrid.Cells[2,0] := 'Выбор абонентов';
   FsgGrid.ColWidths[0]  := 30;
   if not FDB.GetAbonsTable(Abons) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Abons.Count + 1;
     for i := 0 to Abons.Count - 1 do
     begin
       FsgGrid.Cells[0, i + 1] := IntToStr(Abons.Items[i].m_swABOID);
       FsgGrid.Cells[1, i + 1] := Abons.Items[i].m_sName;

     end;
   end;
   OnFormResize;
end;

procedure TRPSummVedom.LoadSumVedomStruct;
var Fl           : TINIFile;
    AllowAbonStr : string;
    i, tmp       : integer;
    tBool        : boolean;
begin
   Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\' + 'reprot_Config.ini');
   AllowAbonStr := Fl.ReadString('SUMMVEDOM', 'm_nAllowAbon', '');
   SetLength(mSumVedomStr.m_nAbons, Length(AllowAbonStr) div 2 + 10);
   GetIntArrayFromStr(AllowAbonStr, mSumVedomStr.m_nAbons);

   tmp := Fl.ReadInteger('SUMMVEDOM', 'm_nAllKEn', 0);
   for i := 0 to 3 do
     if (tmp and (1 shl i)) > 0 then
       mSumVedomStr.m_nAllKEn[i] := true else mSumVedomStr.m_nAllKEn[i] := false;

   tmp := Fl.ReadInteger('SUMMVEDOM', 'm_nAllEP', 0);
   for i := 0 to 7 do
     if (tmp and (1 shl i)) > 0 then
       mSumVedomStr.m_nAllEP[i] := true else mSumVedomStr.m_nAllEP[i] := false;

   tmp := Fl.ReadInteger('SUMMVEDOM', 'm_nAllEM', 0);
   for i := 0 to 7 do
     if (tmp and (1 shl i)) > 0 then
       mSumVedomStr.m_nAllEM[i] := true else mSumVedomStr.m_nAllEM[i] := false;

   tmp := Fl.ReadInteger('SUMMVEDOM', 'm_nAllRP', 0);
   for i := 0 to 7 do
     if (tmp and (1 shl i)) > 0 then
       mSumVedomStr.m_nAllRP[i] := true else mSumVedomStr.m_nAllRP[i] := false;

   tmp := Fl.ReadInteger('SUMMVEDOM', 'm_nAllRM', 0);
   for i := 0 to 7 do
     if (tmp and (1 shl i)) > 0 then
       mSumVedomStr.m_nAllRM[i] := true else mSumVedomStr.m_nAllRM[i] := false;

   tmp := Fl.ReadInteger('SUMMVEDOM', 'm_nAllPowEP', 0);
   for i := 0 to 5 do
     if (tmp and (1 shl i)) > 0 then
       mSumVedomStr.m_nAllPowEP[i] := true else mSumVedomStr.m_nAllPowEP[i] := false;

   tmp := Fl.ReadInteger('SUMMVEDOM', 'm_nAllPowEM', 0);
   for i := 0 to 5 do
     if (tmp and (1 shl i)) > 0 then
       mSumVedomStr.m_nAllPowEM[i] := true else mSumVedomStr.m_nAllPowEM[i] := false;

   tmp := Fl.ReadInteger('SUMMVEDOM', 'm_nAllPowRP', 0);
   for i := 0 to 5 do
     if (tmp and (1 shl i)) > 0 then
       mSumVedomStr.m_nAllPowRP[i] := true else mSumVedomStr.m_nAllPowRP[i] := false;

   tmp := Fl.ReadInteger('SUMMVEDOM', 'm_nAllPowRM', 0);
   for i := 0 to 5 do
     if (tmp and (1 shl i)) > 0 then
       mSumVedomStr.m_nAllPowRM[i] := true else mSumVedomStr.m_nAllPowRM[i] := false;

   tBool := false;
   for i := 0 to 7 do
     if mSumVedomStr.m_nAllEP[i] then tBool := true;
   if (not tBool) and (mSumVedomStr.m_nAllKEn[0]) then
     mIsPokEn[0] := false else mIsPokEn[0] := true;

   tBool := false;
   for i := 0 to 7 do
     if mSumVedomStr.m_nAllEM[i] then tBool := true;
   if (not tBool) and (mSumVedomStr.m_nAllKEn[1]) then
     mIsPokEn[1] := false else mIsPokEn[1] := true;

   tBool := false;
   for i := 0 to 7 do
     if mSumVedomStr.m_nAllRP[i] then tBool := true;
   if (not tBool) and (mSumVedomStr.m_nAllKEn[2]) then
     mIsPokEn[2] := false else mIsPokEn[2] := true;

   tBool := false;
   for i := 0 to 7 do
     if mSumVedomStr.m_nAllRM[i] then tBool := true;
   if (not tBool) and (mSumVedomStr.m_nAllKEn[3]) then
     mIsPokEn[3] := false else mIsPokEn[3] := true;

   mIsPowEn := false;
   for i := 0 to 3 do
     if mSumVedomStr.m_nAllKEn[i] then mIsPowEn := true;
end;

procedure TRPSummVedom.LoadAbonInfo;
var tstr   : string;
    i      : integer;
begin
   tstr := '(-1,';
   for i := 0 to Length(mSumVedomStr.m_nAbons) - 1 do
     if mSumVedomStr.m_nAbons[i] <> -100 then
       tstr := tstr + IntToStr(mSumVedomStr.m_nAbons[i]) + ',';
   if (tstr[length(tstr)] = ',') then
     tstr[length(tstr)] := ' ';
   tstr := tstr + ')';
   PDB.GetAbonTableS(tstr, mAbonInfo);
end;

procedure TRPSummVedom.PrintPreview(Date : TDateTime);
begin
   mDate := Date;
   LoadSumVedomStruct;
   LoadAbonInfo;
   frReport.ShowReport;
end;

procedure TRPSummVedom.frReportManualBuild(Page: TfrPage);
var Year, Month, Day : word;
    i                : integer;
begin
   DecodeDate(mDate, Year, Month, Day);
   mReportName := 'Сводная ведомость электроэнергии по предприятиям за ' + cDateTimeR.GetNameMonth0(Month)
                  + ' месяц ' + IntToStr(Year) + ' года';
   Page.ShowBandByType(btReportTitle);
   Page.ShowBandByName('btReportTitle');

   mBeginDate := cDateTimeR.GetBeginMonth(mDate);
   mEndDate   := cDateTimeR.fIncMonth(mDate);
   IsUsePokNow := cDateTimeR.IsDateInMonthNow(mDate);
   if IsUsePokNow then
     mEndDate := trunc(Now);

   for i := 0 to mAbonInfo.Count - 1 do
   begin
     if i <> 0 then
       Page.NewPage;
     CreateDataAbon(i);
     Page.ShowBandByName('MasterDataAbon');

     ShowBandMaxP(i, Page);

     if mIsPowEn then
     begin
       Page.ShowBandByName('MasterDataPokHead');
       ShowPokEnBand(i, Page);
     end;

   end;
   Page.ShowBandByName('PageFooter1');
end;

procedure TRPSummVedom.CreateDataAbon(i: integer);
begin
   mContractNumber := mAbonInfo.Items[i].m_sDogNum;
   mAbonentName := mAbonInfo.Items[i].m_sName;
   mAbonentAddress := mAbonInfo.Items[i].m_sAddress;
end;

procedure TRPSummVedom.ShowPokEnBand(ABN : integer; var Page: TfrPage);
begin
   ShowPokEnBandWithoutTRET(ABN, Page)
end;

procedure TRPSummVedom.ShowPokEnBandWithoutTRET(ABN : integer; var Page: TfrPage);
var i, j, KindEn     : integer;
    pRepTbl          : SL2TAGREPORTLIST;
    trVal            : double;
begin
   PDB.GetMeterTableForReportWithCode(mAbonInfo.Items[ABN].m_swABOID, -1, '', pRepTbl);
   for i := 0 to pRepTbl.Count - 1 do
   begin
      mCurrentMeterName   := 'Точка учета: ' + pRepTbl.m_sMeter[i].m_sVMeterName;
      mCurrentMeterNumber := 'Счетчик №' + pRepTbl.m_sMeter[i].m_sddPHAddres;
      mKTE  := RVLPrStr(pRepTbl.m_sMeter[i].m_sfKI * pRepTbl.m_sMeter[i].m_sfKU, 0);
      trVal := FDB.CalcTRET(mDate, pRepTbl.m_sMeter[i].m_swVMID, QRY_SRES_ENR_EP, 0);



      Page.ShowBandByName('MasterHeaderPok');
      for KindEn := 0 to 3 do
      begin
        if (trVal <> -1.0) and (KindEn <> 1) and (KindEn <> 3) then
        begin
          ShowPokEnBandTRET(pRepTbl.m_sMeter[i], KindEn, Page);
          continue;
        end;
        FindPokMeter(pRepTbl.m_sMeter[i].m_swVMID, KindEn, pRepTbl.m_sMeter[i].m_sfKI * pRepTbl.m_sMeter[i].m_sfKU);
        if not mSumVedomStr.m_nAllKEn[KindEn] then
          continue;
        mKindEnergy := c_EnergyTitles[KindEn];
        Page.ShowBandByName('MasterData1');
        for j := 1 to 9 do
        begin
          case KindEn of
            0 : if (not mSumVedomStr.m_nAllEP[j - 1]) and (j <> 9) then continue;
            1 : if (not mSumVedomStr.m_nAllEM[j - 1]) and (j <> 9) then continue;
            2 : if (not mSumVedomStr.m_nAllRP[j - 1]) and (j <> 9) then continue;
            3 : if (not mSumVedomStr.m_nAllRM[j - 1]) and (j <> 9) then continue;
          end;
          mTName := c_PokTarNames[j];
          mEnerT1MB := RVLPrStr(mBegMPok[j], MeterPrecision[pRepTbl.m_sMeter[i].m_swVMID]);
          mEnerT1ME := RVLPrStr(mEndMPok[j], MeterPrecision[pRepTbl.m_sMeter[i].m_swVMID]);
          if (mRaznPok[j] >= 0.0) then
          begin
            mEnerT1Sub := RVLPrStr(mRaznPok[j], MeterPrecision[pRepTbl.m_sMeter[i].m_swVMID]);
            mEnerT1Rasx := RVLPrStr(mRaznPok[j] * pRepTbl.m_sMeter[i].m_sfKI * pRepTbl.m_sMeter[i].m_sfKU, MeterPrecision[pRepTbl.m_sMeter[i].m_swVMID]);
          end
          else
          begin
            mEnerT1Sub := 'Н/Д';
            mEnerT1Rasx := 'Н/Д';
          end;
          Page.ShowBandByName('MasterDataTf');
        end;
      end;
   end;
end;

procedure TRPSummVedom.ShowPokEnBandTRET(var MeterInfo : SL2TAGREPORT; KE: integer; var Page :TfrPage);
var j : integer;
begin
   //mCurrentMeterName   := 'Точка учета: ' + MeterInfo.m_sVMeterName;
   //mCurrentMeterNumber := 'Счетчик №' + MeterInfo.m_sddPHAddres;
   //mKTE  := RVLPrStr(MeterInfo.m_sfKI * MeterInfo.m_sfKU, 0);
   //Page.ShowBandByName('MasterHeaderPok');
   //for KindEn := 0 to 3 do
   //begin
   FindPokMeter(MeterInfo.m_swVMID, KE, MeterInfo.m_sfKI * MeterInfo.m_sfKU);
   mKindEnergy := c_EnergyTitles[KE];
   Page.ShowBandByName('MasterHeaderLose');
   for j := 1 to 9 do
   begin
     case KE of
       0 : if (not mSumVedomStr.m_nAllEP[j - 1]) and (j <> 9) then continue;
       1 : if (not mSumVedomStr.m_nAllEM[j - 1]) and (j <> 9) then continue;
       2 : if (not mSumVedomStr.m_nAllRP[j - 1]) and (j <> 9) then continue;
       3 : if (not mSumVedomStr.m_nAllRM[j - 1]) and (j <> 9) then continue;
     end;
     mTName := c_PokTarNames[j];
     mEnerT1MB := RVLPrStr(mBegMPok[j], MeterPrecision[MeterInfo.m_swVMID]);
     mEnerT1ME := RVLPrStr(mEndMPok[j], MeterPrecision[MeterInfo.m_swVMID]);
     if (mRaznPok[j] >= 0.0) then
     begin
       mEnerT1Sub := RVLPrStr(mRaznPok[j], MeterPrecision[MeterInfo.m_swVMID]);
       mEnerT1Rasx := RVLPrStr(mRaznPok[j] * MeterInfo.m_sfKI * MeterInfo.m_sfKU, MeterPrecision[MeterInfo.m_swVMID]);
     end
     else
     begin
       mEnerT1Sub := 'Н/Д';
       mEnerT1Rasx := 'Н/Д';
     end;
     CalcTretVariables(Page,  MeterInfo.m_swVMID, KE, j);
     Page.ShowBandByName('MasterDataLose');
   end;
  // end;
end;

procedure TRPSummVedom.CalcTretVariables(var Page :TfrPage; VMID, KE, TID : integer);
var trVal : double;
begin
   if (KE = 1) or (KE = 3) then exit;
   if TID = 9 then TID := 0;
   trVal := FDB.CalcTRET(mDate, VMID, QRY_SRES_ENR_EP + KE, TID);
   mEnerT1RasxLose := RVLPrStr(trVal, MeterPrecision[VMID]);
end;

procedure TRPSummVedom.FindPokMeter(VMID, KindEn : integer; KT: double);
var Data                : CCDatas;
    i                   : integer;
begin
   for i := 1 to 9 do
   begin
     mBegMPok[i] := 0;
     mEndMPok[i] := 0;
     mRaznPok[i] := 0;
   end;

    if not IsUsePokNow then
    begin
      if not FDB.GetGData(mEndDate, mEndDate, VMID, QRY_NAK_EN_MONTH_EP + KindEn, 0, Data) then
      if not FDB.GetGData(mEndDate, mEndDate, VMID, QRY_NAK_EN_DAY_EP + KindEn, 0, Data) then
        exit;
    end
    else
    begin
      if not FDB.GetCurrentDataInCCDatas(VMID, QRY_ENERGY_SUM_EP + KindEn, Data) then
        exit;
    end;

    for i := 0 to Data.Count - 1 do
    begin
      if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= 3) then
      begin
        mEndMPok[Data.Items[i].m_swTID] := RVLPr(Data.Items[i].m_sfValue/KT, MeterPrecision[VMID]);
        if m_UseZeroTariff then                                           //Суммирование по тарифам
          mEndMPok[9] := mEndMPok[9] + mEndMPok[Data.Items[i].m_swTID];
      end
      else if (not m_UseZeroTariff) and (Data.Items[i].m_swTID = 0) then //Чтение нулевого тарифа из БД
        mEndMPok[9] :=  RVLPr(Data.Items[i].m_sfValue/KT, MeterPrecision[VMID]);
    end;

    if not FDB.GetGData(mBeginDate, mBeginDate, VMID, QRY_NAK_EN_MONTH_EP + KindEn, 0, Data) then
    if not FDB.GetGData(mBeginDate, mBeginDate, VMID, QRY_NAK_EN_DAY_EP + KindEn, 0, Data) then
      exit;

    for i := 0 to Data.Count - 1 do
    begin
      if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= 3) then
      begin
        mBegMPok[Data.Items[i].m_swTID] := RVLPr(Data.Items[i].m_sfValue/KT, MeterPrecision[VMID]);
        if m_UseZeroTariff then
          mBegMPok[9] := mBegMPok[9] + mBegMPok[Data.Items[i].m_swTID];
      end
      else if (not m_UseZeroTariff) and (Data.Items[i].m_swTID = 0) then //Чтение нулевого тарифа из БД
        mBegMPok[9] := RVLPr(Data.Items[i].m_sfValue/KT, MeterPrecision[VMID]);
    end;

    for i := 1 to 9 do
      mRaznPok[i] := (mEndMPok[i] - mBegMPok[i]);
end;

procedure TRPSummVedom.ShowBandMaxP(ABN : integer; var Page: TfrPage);
var i, j, k, KindEn     : integer;
    pRepTbl             : SL2TAGREPORTLIST;
    MaxV                : double;
    mFShow              : boolean;
begin
   PDB.GetMeterTableForReportWithCode(mAbonInfo.Items[ABN].m_swABOID, -1, 'Raschet', pRepTbl);
   mTariffs.Count := 0;

   for i := 0 to pRepTbl.Count - 1 do
   begin

     mMeterNamePow := 'Точка учета: ' + pRepTbl.m_sMeter[i].m_sVMeterName;
     Page.ShowBandByName('MasterDataPowerHead');


     for KindEn := 0 to 3 do
     begin
       case KindEn of
         0 :
         begin
           if not mSumVedomStr.m_nAllPowEP[0] then continue;
           mKindEnergyPow := c_PowerTitles[0];
         end;
         1 :
         begin
           if not mSumVedomStr.m_nAllPowEM[0] then continue;
           mKindEnergyPow := c_PowerTitles[1];
         end;
         2 :
         begin
           if not mSumVedomStr.m_nAllPowRP[0] then continue;
           mKindEnergyPow := c_PowerTitles[2];
         end;
         3 :
         begin
           if not mSumVedomStr.m_nAllPowRM[0] then continue;
           mKindEnergyPow := c_PowerTitles[3];
         end;
       end;

       PDB.GetTMTarPeriodsCmdTable(0,pRepTbl.m_sMeter[i].m_swVMID, QRY_SRES_ENR_EP + KindEn, 4,mTariffs);
       FindMaxValues(pRepTbl.m_sMeter[i].m_swVMID, KindEn);

       Page.ShowBandByName('MasterHeaderMaxP');
       
       for j := 0 to 4 do
       begin
         if (j = 0) and (AllowPower(KindEn, j)) then
         begin
           mFShow := false;
           MaxV := 0;
           for k := 1 to 4 do
             if (MaxV < mMaxValuesT[k]) and (AllowPower(KindEn, k)) then
               MaxV := mMaxValuesT[k];
            for k := 1 to 4 do
            begin
             //if (KindEn >= 2) and (k >= 3) then continue;
             if (AllowPower(KindEn, k)) and (MaxV = mMaxValuesT[k]) and (not mFShow) then
             begin
               mFShow := true;
               mTPowName := GetPowTarifName(KindEn, k);
               mEnerDtPowM := DateToStr(mMaxDatesT[k]);
               mEnerTmPowM := FormatDateTime('hh:nn', mMaxDatesT[k]) + '-' + FormatDateTime('hh:nn', mMaxDatesT[k] + EncodeTime(0, 30, 0, 0));
               mMaxPower   := RVLPrStr(mMaxValuesT[k] * 2, MeterPrecision[pRepTbl.m_sMeter[i].m_swVMID]);
              Page.ShowBandByName('MasterDataMaxP');
             end
             else
             begin
               //mTPowName   := GetPowTarifName(KindEn, k);
               //mEnerDtPowM := '--';
               //mEnerTmPowM := '--';
               //mMaxPower   := '--';
               //Page.ShowBandByName('MasterDataMaxP');
             end;
           end;
           break;
         end;
         //if (KindEn >= 2) and (j >= 3) then continue;
         if (AllowPower(KindEn, j)) then
         begin
           mTPowName := GetPowTarifName(KindEn, j);
           mEnerDtPowM := DateToStr(mMaxDatesT[j]);
           mEnerTmPowM := FormatDateTime('hh:nn', mMaxDatesT[j]) + '-' + FormatDateTime('hh:nn', mMaxDatesT[j] + EncodeTime(0, 30, 0, 0));
           mMaxPower   := RVLPrStr(mMaxValuesT[j] * 2, MeterPrecision[pRepTbl.m_sMeter[i].m_swVMID]);
           Page.ShowBandByName('MasterDataMaxP');
         end
         else if j <> 0 then
         begin
           //mTPowName   := GetPowTarifName(KindEn, j);
           //mEnerDtPowM := '--';
           //mEnerTmPowM := '--';
           //mMaxPower   := '--';
           //Page.ShowBandByName('MasterDataMaxP');
         end;
       end;
     end;

   end;
end;

procedure TRPSummVedom.FindMaxValues(VMID, KindEn : integer);
var i, j, TID  : integer;
    pTable     : L3GRAPHDATAS;
begin
   for i := 0 to 5 do
   begin
     mMaxValuesT[i] := 0;
     mMaxDatesT[i] := cDateTimeR.GetBeginMonth(mDate);
   end;
   PDB.GetGraphDatas(cDateTimeR.EndMonth(mDate), cDateTimeR.GetBeginMonth(mDate), VMID, QRY_SRES_ENR_EP + KindEn, pTable);
   for i := 0 to pTable.Count - 1 do
     for j := 0 to 47 do
     begin
       TID := GetColorFromTariffs(j, mTariffs);
       if TID <> 0 then
       begin
         if mMaxValuesT[TID] < pTable.Items[i].v[j] then
         begin
           mMaxValuesT[TID] := pTable.Items[i].v[j];
           mMaxDatesT[TID] := trunc(pTable.Items[i].m_sdtDate) + EncodeTime(0, 30, 0, 0) * j;
         end;
       end;
       if mMaxValuesT[0] < pTable.Items[i].v[j] then
       begin
         mMaxValuesT[0] := pTable.Items[i].v[j];
         mMaxDatesT[0] := trunc(pTable.Items[i].m_sdtDate) + EncodeTime(0, 30, 0, 0) * j;
       end;
     end;
end;

procedure TRPSummVedom.frReportGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'ContractNumber' then begin ParValue := mContractNumber; exit; end;
   if ParName = 'ReportName' then begin ParValue := mReportName; exit; end;
   if ParName = 'AbonentName' then begin ParValue := mAbonentName; exit; end;
   if ParName = 'AbonentAddress' then begin ParValue := mAbonentAddress; exit; end;
   if ParName = 'MeterNamePow' then begin ParValue := mMeterNamePow; exit; end;
   if ParName = 'KindEnergyPow' then begin ParValue := mKindEnergyPow; exit; end;
   if ParName = 'TPowName' then begin ParValue := mTPowName; exit; end;
   if ParName = 'EnerDtPowM' then begin ParValue := mEnerDtPowM; exit; end;
   if ParName = 'EnerTmPowM' then begin ParValue := mEnerTmPowM; exit; end;
   if ParName = 'MaxPower' then begin ParValue := mMaxPower; exit; end;
   if ParName = 'KindEnergy' then begin ParValue := mKindEnergy; exit; end;
   if ParName = 'BeginDate' then begin ParValue := DateToStr(mBeginDate); exit; end;
   if ParName = 'EndDate' then begin ParValue := DateToStr(mEndDate); exit; end;
   if ParName = 'CurrentMeterName' then begin ParValue := mCurrentMeterName; exit; end;
   if ParName = 'CurrentMeterNumber' then begin ParValue := mCurrentMeterNumber; exit; end;
   if ParName = 'KTE' then begin ParValue := mKTE; exit; end;
   if ParName = 'TName' then begin ParValue := mTName; exit; end;
   if ParName = 'EnerT1MB' then begin ParValue := mEnerT1MB; exit; end;
   if ParName = 'EnerT1ME' then begin ParValue := mEnerT1ME; exit; end;
   if ParName = 'EnerT1Sub' then begin ParValue := mEnerT1Sub; exit; end;
   if ParName = 'EnerT1Rasx' then begin ParValue := mEnerT1Rasx; exit; end;
   if ParName = 'EnerTsMB' then begin ParValue := ''; exit; end;
   if ParName = 'EnerTsME' then begin ParValue := ''; exit; end;
   if ParName = 'EnerTsSub' then begin ParValue := ''; exit; end;
   if ParName = 'EnerTsRasx' then begin ParValue := ''; exit; end;
   if ParName = 'KindEnergyLose' then begin ParValue := mKindEnergyLose; exit; end;
   if ParName = 'TNameLose' then begin ParValue := mTNameLose; exit; end;
   if ParName = 'EnerT1RasxLose' then begin ParValue := mEnerT1RasxLose; exit; end;
end;

function TRPSummVedom.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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

function TRPSummVedom.GetPowTarifName(KindEn, k: integer): string;
begin
   case KindEn of
     0, 1 : Result := c_TariffsNamesE[k];
     2, 3 : Result := c_TariffsNamesR[k];
   end;
end;

function TRPSummVedom.AllowPower(KindEn, Tar: integer): boolean;
begin
   case KindEn of
     0 : Result := mSumVedomStr.m_nAllPowEP[Tar + 1];
     1 : Result := mSumVedomStr.m_nAllPowEM[Tar + 1];
     2 : Result := mSumVedomStr.m_nAllPowRP[Tar + 1];
     3 : Result := mSumVedomStr.m_nAllPowRM[Tar + 1];
     else Result := false;
   end;
end;

end.
