unit knslRPRasxDay;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;

type
  TrpRasxDay = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1ManualBuild(Page: TfrPage);
  private
    { Private declarations }
    m_ID              : integer;
    glKoef            : extended;
    glEnergMB         : array [1..4] of extended;
    glEnergME         : array [1..4] of extended;
    glEnergRazn       : array [1..4] of extended;
    glEnergRasx       : array [1..4] of extended;
    glMB              : string[15];
    glME              : string[15];

    globalTitle       : string;
    globalMeterName   : string;
    glSum             : array [1..4] of string;
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    GroupID           : integer;
    FABOID            : integer;
    SumEnergy         : array [0..3,1..4] of extended;
    globalTblMeter    : string;
    glKindEn          : string;
    globalTblDate     : string[15];
    glCountTable      : integer;
    glCountTableShow  :string;

     //formula
    Fm_nEVL            : CEvaluator;
    sExpr             : string;
    sExpr1            : array [0..3,1..4] of string;
    SumFormula        : array [0..3,1..4] of extended;
    procedure OnFormResize;
    procedure FillReport(MID : integer; var Page :TfrPage);
    procedure FillReportTtl(KindEN : byte; var Page : TfrPage);
    procedure FindValueFormula(tarif:integer;KindEn: byte;mid:string);
    function  Replace(Str, X, Y: string): string;
  public
    { Public declarations }
    WorksName   : string;
    FirstSign   : string;
    SecondSign  : string;
    ThirdSign   : string;
    DateReport  : TDateTime;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
    m_strObjCode: string;
    IsReadZerT  : boolean;
    procedure PrintPreview(Date : TDateTime;CountTable:integer);
    procedure PrepareTable;
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   :integer read GroupID write GroupID;
    property PABOID      :integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property Pm_nEVL     :CEvaluator        read fm_nEVL          write fm_nEVL;
  end;

var
  rpRasxDay: TrpRasxDay;
const
  strEnergy   : array [0..3] of string = ('��� ������� : �������� �����������',
                                          '��� ������� : �������� ����������',
                                          '��� ������� : ���������� �����������',
                                          '��� ������� : ���������� ����������');

  PageMasterDataBox   : array [0..3] of string = ('MasterData2',
                                          'MasterData3',
                                          'MasterData4',
                                          'MasterData5');
  SumEnerguMasterDataBox   : array [0..4] of string = ('MasterData7',
                                          'MasterData8',
                                          'MasterData9',
                                          'MasterData10',
                                          'Band1');
implementation

{$R *.DFM}


procedure TrpRasxDay.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
End;

procedure TrpRasxDay.PrepareTable;
var Meters : SL2TAGREPORTLIST;
    i      : integer;
begin
   if FsgGrid=Nil then exit;
   FsgGrid.ColCount      := 5;
   FsgGrid.RowCount      := 60;
   FsgGrid.Cells[0,0]    := '� �.�';
   FsgGrid.Cells[1,0]    := '������������ �����';
   FsgGrid.Cells[2,0]    := '����� ��������';
   FsgGrid.Cells[3,0]    := '�����������';
   FsgGrid.Cells[4,0]    := '��� ��������';
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

procedure TrpRasxDay.PrintPreview(Date : TDateTime;CountTable:integer);
begin
   DateReport := Date;
   glCountTable := CountTable;
   if FsgGrid.RowCount > 1 then
     frReport1.ShowReport;
end;
function TrpRasxDay.Replace(Str, X, Y: string): string;
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

procedure TrpRasxDay.FindValueFormula(tarif:integer;KindEn: byte;mid:string);
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

{glEnergMB
    glEnergME
    glEnergRazn
    glEnergRasx
    SumEnergy}

procedure TrpRasxDay.FillReport(MID : integer; var Page: TfrPage);
var Data                  : CCDatas;
    KindEn                : byte;
    Year, Month, Day, i,r : word;
    TempDate              : TDateTime;
    param                 : extended;
    nTypeID,swPLID,nMaxT: Integer;

begin

   globalMeterName := '' + FsgGrid.Cells[1, MID];
   globalTblMeter  := '��. � :' +FsgGrid.Cells[2, MID];
   Page.ShowBandByName('MasterData1');
   m_ID            := StrToInt(FsgGrid.Cells[0, MID]);

    nMaxT  := 3;
    swPLID := 0;
    FDB.GetMeterType(m_ID,nTypeID,swPLID);
    if swPLID=1 then nMaxT:=2;

   for KindEn := 0 to 3 do
   begin
     glKindEn := strEnergy[KindEn];
     glKoef   := StrToFloat(FsgGrid.Cells[3, MID]);
     TempDate := DateReport;
     cDateTimeR.IncDate(TempDate);
    for i := 1 to 4 do
     begin
       glEnergMB[i]   := 0;
       glEnergME[i]   := 0;
       glEnergRazn[i] := 0;
       glEnergRasx[i] := 0;
     end;
     if not FDB.GetGData(TempDate, TempDate, StrToInt(FsgGrid.Cells[0, MID]),
                         QRY_NAK_EN_DAY_EP + KindEn, 0, Data) then
     begin
       FindValueFormula(6,KindEn,FsgGrid.Cells[0, MID]);
       Page.ShowBandByName(PageMasterDataBox[KindEn]);
       continue;
     end;
     for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin
         glEnergME[Data.Items[i].m_swTID] := Data.Items[i].m_sfValue/glKoef;
         if (IsReadZerT){ or (swPLID=1)} then
           glEnergME[4] := glEnergME[4] + glEnergME[Data.Items[i].m_swTID];
       end
       else
         if (not IsReadZerT) and (Data.Items[i].m_swTID = 0) then //������ �������� ������ �� ��
           glEnergME[4] :=  RVLPr(Data.Items[i].m_sfValue/glKoef, MeterPrecision[m_ID]);
     cDateTimeR.DecDate(TempDate);
     if not FDB.GetGData(TempDate, TempDate, StrToInt(FsgGrid.Cells[0, MID]),
                         QRY_NAK_EN_DAY_EP + KindEn, 0, Data) then
     begin
       FindValueFormula(6,KindEn,FsgGrid.Cells[0, MID]);
       Page.ShowBandByName(PageMasterDataBox[KindEn]);
       continue;
     end;
     for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin
         glEnergMB[Data.Items[i].m_swTID] := Data.Items[i].m_sfValue/glKoef;
         if (IsReadZerT){ or (swPLID=1)} then
           glEnergMB[4] := glEnergMB[4] + glEnergMB[Data.Items[i].m_swTID];
       end
       else
         if (not IsReadZerT) and (Data.Items[i].m_swTID = 0) then //������ �������� ������ �� ��
           glEnergMB[4] := RVLPr(Data.Items[i].m_sfValue/glKoef, MeterPrecision[m_ID]);
     for i := 1 to 4 do
     begin
       glEnergRazn[i] := glEnergME[i] - glEnergMB[i];
       glEnergRasx[i] := RVLPr(glEnergRazn[i],MeterPrecision[m_ID])*glKoef;
       SumEnergy[KindEn][i] := SumEnergy[KindEn][i] + glEnergRasx[i];
       SumFormula[KindEn][i] := glEnergRasx[i];
       FindValueFormula(i,KindEn,FsgGrid.Cells[0, MID]);
     end;
      Page.ShowBandByName(PageMasterDataBox[KindEn]);
   end;
end;

procedure TrpRasxDay.FillReportTtl(KindEN : byte; var Page : TfrPage);
var i : byte;
begin
   //if GroupID=-1 then Begin glSum[4]:='�/�';Page.ShowBandByName(SumEnerguMasterDataBox[KindEn]);exit;End;
   if KindEn<4 then
   if  sExpr <> '[x]' then
   begin
   try
       fm_nEVL.Expression :=  sExpr1[KindEn][4];  //�������
       if fm_nEVL.Value < 0 then glSum[4] := '�/�' else
       glSum[4] := FloatToStr(RVLPr(fm_nEVL.Value, MaxPrecision));
    except
        MessageDlg('������ � �����������',mtWarning,[mbOk,mbCancel],0);
        exit;
    end;
   end
   else  
   begin
   if SumEnergy[KindEn][4] < 0 then glSum[4] := '�/�' else
   glSum[4] := FloatToStr(RVLPr(SumEnergy[KindEn][4], MaxPrecision));
   end;
   Page.ShowBandByName(SumEnerguMasterDataBox[KindEn]);
end;

procedure TrpRasxDay.frReport1ManualBuild(Page: TfrPage);
var i, j             : integer;
    Month,Month1, Year,Year1, Day : word;
    TempDate         : TDateTime;
    pGT              : SL3GROUPTAG;
begin
  ////������������� //�������
 sExpr := m_pDB.GetMSGROUPEXPRESS(FABOID,GroupID,pGT);
 if GroupID=-1 then //Meters : SL2TAGREPORTLIST;
 Begin
  sExpr := '';
  sExpr := 'v'+FsgGrid.Cells[0, 1]+'_P';
  for i := 2 to FsgGrid.RowCount - 1 do
  sExpr :=sExpr + ' + v'+FsgGrid.Cells[0, i]+'_P';
 End;
 fm_nEVL.Expression := sExpr;
 for i:=1 to 4 do
    for j:=0 to 3 do
       sExpr1[j][i] := sExpr;
 //////////////

  for i := 0 to 3 do
     for j := 1 to 4 do
      SumEnergy[i][j] := 0;
   TempDate  := DateReport;
   DecodeDate(DateReport, Year, Month, Day);
   globalTitle := '�������� � ������� �������������� �� ������ ����� � ' +
                                            cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' ����';
   
   cDateTimeR.IncDate(DateReport);
   glME := DateToStr(DateReport);
   cDateTimeR.DecDate(DateReport);
   glMB := DateToStr(DateReport);
   Page.ShowBandByType(btReportTitle);
   glCountTableShow := '������� � ' + IntToStr(glCountTable);
   for i := 1 to FsgGrid.RowCount - 1 do
   begin
   FillReport(i, Page);
   glCountTableShow := '������� � ' + IntToStr(glCountTable) + '(�����������)';
   end;
   //Page.ShowBandByName('MasterHeader1');
   Page.ShowBandByName('MasterHeader2');
   for i := 0 to 4 do
   FillReportTtl(i, Page);
   Page.ShowBandByName('PageFooter1');
end;

procedure TrpRasxDay.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'CountTbl'      then ParValue := glCountTableShow;
   if ParName = 'TblDate'       then ParValue := globalTblDate;
   if ParName = 'WorksName'     then ParValue := WorksName;
   if ParName = 'TtlMainName'   then ParValue := globalTitle;
   if ParName = 'DateTtlB'      then ParValue := glMB;
   if ParName = 'DateTtlE'      then ParValue := glME;
   if ParName = 'MDNameCounter' then ParValue := globalMeterName;
   if ParName = 'KindEn'        then ParValue := glKindEn;
   if ParName = 'TblMeter'      then ParValue := globalTblMeter;
  // glKoef
   if ParName = 'EnerT1MB'      then ParValue := RVLPr(glEnergMB[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2MB'      then ParValue := RVLPr(glEnergMB[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3MB'      then ParValue := RVLPr(glEnergMB[3], MeterPrecision[m_ID]);
   if ParName = 'EnerTsMB'      then ParValue := RVLPr(glEnergMB[4], MeterPrecision[m_ID]);
   if ParName = 'EnerT1ME'      then ParValue := RVLPr(glEnergME[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2ME'      then ParValue := RVLPr(glEnergME[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3ME'      then ParValue := RVLPr(glEnergME[3], MeterPrecision[m_ID]);
   if ParName = 'EnerTsME'      then ParValue := RVLPr(glEnergME[4], MeterPrecision[m_ID]);
   if ParName = 'EnerT1Sub'     then ParValue := RVLPr(glEnergRazn[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2Sub'     then ParValue := RVLPr(glEnergRazn[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3Sub'     then ParValue := RVLPr(glEnergRazn[3], MeterPrecision[m_ID]);
   if ParName = 'EnerTsSub'     then ParValue := RVLPr(glEnergRazn[4], MeterPrecision[m_ID]);
   if ParName = 'KoefT1'        then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'KoefT2'        then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'KoefT3'        then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'KoefTs'        then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'EnerT1Rasx'    then ParValue := RVLPr(glEnergRasx[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2Rasx'    then ParValue := RVLPr(glEnergRasx[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3Rasx'    then ParValue := RVLPr(glEnergRasx[3], MeterPrecision[m_ID]);
   if ParName = 'EnerTsRasx'    then ParValue := RVLPr(glEnergRasx[4], MeterPrecision[m_ID]);
   if ParName = 'FirstSign'     then ParValue := FirstSign;
   if ParName = 'SecondSign'    then ParValue := SecondSign;
   if ParName = 'ThirdSign'     then ParValue := ThirdSign;
   if ParName = 'KindEnTtl'     then ParValue := glKindEn;
   if ParName = 'EnergT1Ttl'    then ParValue := glSum[1];
   if ParName = 'EnergT2Ttl'    then ParValue := glSum[2];
   if ParName = 'EnergT3Ttl'    then ParValue := glSum[3];
   if ParName = 'EnergTsTtl'    then ParValue := glSum[4];
   if ParName = 'NDogovor'      then ParValue := NDogovor;
   if ParName = 'm_strObjCode'  then Parvalue := m_strObjCode;
   if ParName = 'NameObject'    then begin ParValue := NameObject; exit; end;
   if ParName = 'Adress'        then begin ParValue := Adress; exit; end;
end;

end.
