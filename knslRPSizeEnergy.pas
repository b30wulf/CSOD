unit knslRPSizeEnergy;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, utldatabase, BaseGrid, AdvGrid, utltypes, utlTimeDate, FR_DSet, utlconst, utlbox,
  FR_Desgn;

type
  TrpSizeEnergy = class(TForm)
    frReport: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1ManualBuild(Page: TfrPage);
  private
    { Private declarations }
    globalTtlMainName : string;
    globalTblName     : string;
    globalTblDate     : string[15];
    SumEnerg          : array [0..4] of single;
    globalTblTName    : array [0..3] of string;
    globalTblKoef     : array [0..4] of string[20];
    PrirDay           : array of single;
    IsData            : array of boolean;
    VMeters           : SL3GROUPTAG;
    m_pGrData         : L3GRAPHDATAS;
    m_pTariffs        : TM_TARIFFS;
    FTID              : integer;
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    GlobalYearBegin   : String[15];
    GlobalYearEnd     : String[15];
    glMB              : string[15];
    glME              : string[15];
    TarifBegin        : array[0..50] of string[200];
    TarifEnd          : array[0..50] of string[200];
    masTarifBegin     : array[0..50] of string[200];
    masTarifEnd       : array[0..50] of string[200];
    srez              : array[0..50] of single;
    glTarifBegin      : string[255];
    glTarifEnd        : string[255];
    glsrez            : string[20];
    SumEnergTarif     : single;
    glSumEnergTarif   : string[200];
    begint,endt       : byte;
    m_nAmRecords      : array[0..50] of byte;
    FABOID            : Integer;
    procedure BuildReport(var Page: TfrPage);
    function  DateOutSec(Date : TDateTime) : string;
    function  CalcCountTariffs() : byte;
    procedure LoadTarif;
    procedure ReadArchAbonent;
    procedure ReadArch;
    Function  ReturnResultTime(STarif:string):byte;
    Function  OtputTimeTarif(countTarif:byte):byte;
    procedure FillTotal(var Page: TfrPage);
  public
    { Public declarations }
    DateBeg           : TDateTime;
    DateEnd           : TDateTime;
    IsRPGroup         : boolean;
    KindEnergy        : integer;
    Tarif             : integer;
    ItemInd           : integer;
    WorksName         : string;
    FirstSign         : string;
    ThirdSign         : string;
    SecondSign        : string;
    NDogovor          : string;
    NameObject        : string;
    Adress            : string;
    m_strObjCode      : string;
    KoefTar           : single;
    GroupID           : integer;
    glCountTableShow  : string;
    glCountTable      : integer;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    function  DeleteSpaces(str :string) : string;
    procedure PrepareTable;
    procedure PrepareTableSub;
    procedure PrintPreview(Date1, Date2 : TDateTime; CountTable:Integer;ItemIndSyzeEnergy:integer);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property TID         :integer          read FTID         write FTID;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;

var
  rpSizeEnergy: TrpSizeEnergy;
const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт*ч)',
                                          'Вид энергии : Активная отдаваемая(кВт*ч)',
                                          'Вид энергии : Реактивная потребляемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');

implementation

{$R *.DFM}

function  TrpSizeEnergy.CalcCountTariffs() : byte;
var i : word;
begin
  Result := m_pTariffs.Items[0].m_swTID;
  for i := 1 to m_pTariffs.Count - 1 do
    if m_pTariffs.Items[i].m_swTID > Result then
      Result := m_pTariffs.Items[i].m_swTID;
end;

function TrpSizeEnergy.DateOutSec(Date : TDateTime) : string;
var str : string;
begin
   str := TimeToStr(Date);
   SetLength(str, Length(str) - 3);
   Result := str;
end;

function  TrpSizeEnergy.DeleteSpaces(str :string) : string;
begin
   while str[Length(str)] = ' ' do
     SetLength(str, Length(str) - 1);
   Result := str;
end;

procedure TrpSizeEnergy.PrepareTable;
var Groups    : SL3INITTAG;
    i, j      : integer;
    NumberTar : byte;
begin
   if FsgGrid=Nil then
     exit;
   FDB.GetTMTarPeriodsTable(-1, FTID + KindEnergy, m_pTariffs);
   NumberTar := CalcCountTariffs;
   FsgGrid.ColCount   := 3 + NumberTar;
   FsgGrid.Cells[0,0] := '№ п.п';
   FsgGrid.Cells[1,0] := 'Наименование группы';
   for i := 0 to m_pTariffs.Count - 1 do
     FsgGrid.Cells[2 + m_pTariffs.Items[i].m_swTID,0] :=  m_pTariffs.Items[i].m_sName;
   FsgGrid.ColWidths[0]  := 30;
   SetHigthGrid(FsgGrid^,20);

   if not FDB.GetAbonGroupsLVTable(FABOID,1,Groups) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Groups.Count + 1;
     for i := 0 to Groups.Count - 1 do
     begin
       FsgGrid.Cells[0, i + 1] := IntToStr(Groups.Items[i].m_sbyGroupID);
       FsgGrid.Cells[1, i + 1] := Groups.Items[i].m_sGroupName;
       for j := 0 to m_pTariffs.Count - 1 do
         FsgGrid.Cells[2 + m_pTariffs.Items[j].m_swTID, i + 1] := DVLS(m_pTariffs.Items[j].m_sfKoeff);
     end;
   end;
   OnFormResize;
end;

procedure TrpSizeEnergy.PrepareTableSub;
var Meters   : SL2TAGREPORTLIST;
    i, j     : integer;
    NumberTar: word;
begin
   if FsgGrid=Nil then exit;
   FDB.GetTMTarPeriodsTable(-1, FTID + KindEnergy, m_pTariffs);
   NumberTar := CalcCountTariffs;
   FsgGrid.ColCount   := 3 + NumberTar;
   FsgGrid.RowCount      := 60;
   FsgGrid.Cells[0,0]    := '№ п.п';
   FsgGrid.Cells[1,0]    := 'Наименование учета';
   for i := 0 to m_pTariffs.Count - 1 do
     FsgGrid.Cells[2 + m_pTariffs.Items[i].m_swTID,0] := m_pTariffs.Items[i].m_sName;

   FsgGrid.ColWidths[0]  := 30;
   SetHigthGrid(FsgGrid^,20);
   if not FDB.GetMeterGLVTableForReport(FABOID,-1,0, Meters) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       FsgGrid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       for j := 0 to m_pTariffs.Count - 1 do
         FsgGrid.Cells[2 + m_pTariffs.Items[j].m_swTID, FsgGrid.RowCount] := DVLS(m_pTariffs.Items[j].m_sfKoeff);
     end;
   end;
   OnFormResize;
end;

procedure TrpSizeEnergy.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
    for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TrpSizeEnergy.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TrpSizeEnergy.PrintPreview(Date1, Date2 : TDateTime; CountTable:Integer;ItemIndSyzeEnergy:Integer);
begin
   DateBeg     := Date1;
   DateEnd     := Date2;
   glCountTable := CountTable;
   ItemInd     := ItemIndSyzeEnergy;
   FTID        := FDB.LoadTID(QRY_SRES_ENR_EP + KindEnergy);;
   if (FsgGrid.RowCount > 1) then
   begin
     KoefTar     := StrToFloat(FsgGrid.Cells[2, ItemInd]);
     frReport.ShowReport;
   end;
end;

Function TrpSizeEnergy.OtputTimeTarif(countTarif:byte):byte;
var
 TempDate         : TDateTime;
begin
    countTarif             := countTarif + 1;
    TarifBegin[countTarif] := (copy(masTarifBegin[tarif],1,pos(',',masTarifBegin[tarif])-1));
    beginT                 := ReturnResultTime(TarifBegin[countTarif]);
    TarifEnd[countTarif]   := (copy(masTarifEnd[tarif],1,pos(',',masTarifEnd[tarif])-1));
    endT                   := ReturnResultTime(TarifEnd[countTarif]);
    delete(masTarifBegin[tarif],1,pos(',',masTarifBegin[tarif]));
    delete(masTarifEnd[tarif],1,pos(',',masTarifEnd[tarif]));
    result :=  countTarif;
end;

procedure TrpSizeEnergy.FillTotal(var Page: TfrPage);
var i:integer;
begin
 for i := 1 to  m_nAmRecords[tarif] do
 begin
 glsrez       := DVLS(srez[i]);
 if  StrToFloat(glsrez) <=0 then  glsrez := 'Н/Д';
 glTarifBegin := TarifBegin[i];
 glTarifEnd   := TarifEnd[i];
 SumEnergTarif := SumEnergTarif + srez[i];
 //glSumEnergTarif := DVLS(SumEnergTarif);

 if  SumEnergTarif <=0 then  glSumEnergTarif := 'Н/Д';
 Page.ShowBandByName('MasterData1');
 end;
 glSumEnergTarif := DVLEX(m_nPrecise,SumEnergTarif);
end;

procedure TrpSizeEnergy.ReadArch;
var i, j, k          : word;
    Day              : integer;
    Index            : word;
    DateReads        : TDateTime;
    IsNothing        : boolean;
    countTarif       : byte;
begin
 DateReads := DateBeg;
 IsNothing := true;
 countTarif := 0;
  try
  for i := 0 to VMeters.m_swAmVMeter - 1 do
  begin
  if not FDB.GetGraphDatas(DateEnd, DateBeg, VMeters.Item.Items[i].m_swVMID,
                                QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
       continue
   else
   begin
   countTarif := 0;
   LoadTarif;
   while pos(',',masTarifBegin[tarif])>0 do
    begin
   countTarif := OtputTimeTarif(countTarif);
       IsNothing := false;
       if  ((endt = 1) and  (begint = 47)) then endt:=48;
       for k := 0 to m_pGrData.Count - 1 do
       begin
       Day := cDateTimeR.DifDays(DateBeg, m_pGrData.Items[k].m_sdtDate);
       Dec(Day);
           for j := begint to endt-1 do
           begin
           if  ((endt = 48) and  (begint = 47)) then  srez[countTarif] := srez[countTarif]  + m_pGrData.Items[k].v[j] + m_pGrData.Items[k].v[0]
           else
            srez[countTarif] := srez[countTarif] + m_pGrData.Items[k].v[j];
           end;
       end;
    end;
   end;
 end;
 except
 end;
 LoadTarif;
 while pos(',',masTarifBegin[tarif])>0 do
   begin
    countTarif := OtputTimeTarif(countTarif);
   end;
end;


 Function TrpSizeEnergy.ReturnResultTime(STarif:string):byte;
var
 s:string;
begin
  s:= '00:00:0000:30:0001:00:0001:30:0002:00:0002:30:0003:00:0003:30:0004:00:00'+
      '04:30:0005:00:0005:30:0006:00:0006:30:0007:00:0007:30:0008:00:0008:30:00'+
      '09:00:0009:30:0010:00:0010:30:0011:00:0011:30:0012:00:0012:30:0013:00:00'+
      '13:30:0014:00:0014:30:0015:00:0015:30:0016:00:0016:30:0017:00:0017:30:00'+
      '18:00:0018:30:0019:00:0019:30:0020:00:0020:30:0021:00:0021:30:0022:00:00'+
      '22:30:0023:00:0023:30:00';
  if pos(STarif,s)<> 0 then result := pos(STarif,s) div 8+1;
end;

procedure TrpSizeEnergy.ReadArchAbonent;
var j, k             : word;
    Day              : integer;
    Index            : word;
    countTarif       : byte;
begin
 countTarif := 0;
 if FDB.GetGraphDatas(DateEnd, DateBeg, StrToInt(FsgGrid.Cells[0, ItemInd]),
                           QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
 begin
 countTarif := 0;
 LoadTarif;
 while pos(',',masTarifBegin[tarif])>0 do  begin
 countTarif := OtputTimeTarif(countTarif);
 if  ((endt = 1) and  (begint = 47)) then endt:=48;
     for k := 0 to m_pGrData.Count - 1 do
     begin
       Day := cDateTimeR.DifDays(DateBeg, m_pGrData.Items[k].m_sdtDate);
       Dec(Day);
       for j := begint to endt-1 do
           begin
           if  ((endt = 48) and  (begint = 47)) then  srez[countTarif] := srez[countTarif]  + m_pGrData.Items[k].v[j] + m_pGrData.Items[k].v[0]
           else
            srez[countTarif] := srez[countTarif] + m_pGrData.Items[k].v[j];
           end;
     end;
  end;
end;
 LoadTarif;
 while pos(',',masTarifBegin[tarif])>0 do
   begin
    countTarif := OtputTimeTarif(countTarif);
   end;
end;


procedure TrpSizeEnergy.LoadTarif;
var        i,j               : integer;
           m_pTariffs        : TM_TARIFFSS;
           pTbl              : TM_TARIFFS;
           m_nMasterIndex    : integer;
begin
   for i:= 0 to 10 do
        masTarifBegin[i] :='';
   for i:= 0 to 10 do
        masTarifEnd[i]   :='';
   for i:= 0 to 10 do
        m_nAmRecords[i]  := 0;
   if m_pDB.GetTMTarifsTable(0,0,0,m_pTariffs) then
   begin
     for i := 0 to m_pTariffs.Count-1  do
     begin
        m_nMasterIndex := m_pTariffs.Items[i].m_swTTID;
         if m_pDB.GetTMTarPeriodsTable(0,m_nMasterIndex,pTbl)=True then
          Begin
           m_nAmRecords[i] := pTbl.Count;
           for j:=0 to pTbl.Count-1 do
           Begin
           masTarifBegin[i] := masTarifBegin[i] + TimeToStr(pTbl.Items[j].m_dtTime0)+ ',';
           masTarifEnd[i]   := masTarifEnd[i] + TimeToStr(pTbl.Items[j].m_dtTime1)+',';
           End;
          End;
     end;
end;
end;

procedure TrpSizeEnergy.BuildReport(var Page: TfrPage);
var i : integer;
    TempDate         : TDateTime;
    begint,endt      :byte;
begin
 if IsRPGroup then
   begin
     if FDB.GetVMetersTable(FABOID,StrToInt(FsgGrid.Cells[0, ItemInd]), VMeters) then
       ReadArch;
   end
   else
     ReadArchAbonent;
  FillTotal(Page);
end;

procedure TrpSizeEnergy.frReport1ManualBuild(Page: TfrPage);
var i                : integer;
    TempDate         : TDateTime;
    Month,Year,Day : word;
begin
   TempDate := DateBeg;
   srez[0]     := 0;
   SumEnergTarif := 0;
   DecodeDate(DateBeg, Year, Month, Day);
   GlobalYearBegin :=  IntToStr(Year);
   glMB := DateToStr(DateBeg);
   Inc(Year);
   GlobalYearEnd :=  IntToStr(Year);
   Dec(Year);
   glME := DateToStr(DateEnd);
   globalTtlMainName := 'Информация об объёмах покупной электроэнергии от блок-станций по '
                           +' РУП"_______"(свод по ГПО "Белэнерго") за  ' +
                            GlobalYearBegin + ' - ' + GlobalYearEnd + 'гг.';
   FDB.GetTMTarPeriodsTable(-1, FTID, m_pTariffs);
   globalTblName  :=  FsgGrid.Cells[1, ItemInd];
   Page.ShowBandByType(btReportTitle);
   glCountTableShow := 'Таблица № ' + IntToStr(glCountTable);
   Page.ShowBandByName('MasterHeader1');
   BuildReport(Page);
   Page.ShowBandByName('MasterFooter1');
   Page.ShowBandByName('PageFooter1');
   //FsgGrid := nil;
end;

procedure TrpSizeEnergy.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'CountTbl'       then ParValue := glCountTableShow;
   if ParName = 'YearBegin'      then ParValue := GlobalYearBegin;
   if ParName = 'YearEnd'        then ParValue := GlobalYearEnd;
   if ParName = 'DateTtlB'       then ParValue := glMB;
   if ParName = 'DateTtlE'       then ParValue := glME;
   if ParName = 'TarifB'         then ParValue := glTarifBegin;
   if ParName = 'TarifE'         then ParValue := glTarifEnd;
   if ParName = 'TarifSrez'      then ParValue := glSrez;
   if ParName = 'SumTarifSrez'   then ParValue := glSumEnergTarif;
   if ParName = 'TblT1Name'      then begin ParValue := globalTblTName[0]; exit; end;
   if ParName = 'TblT2Name'      then begin ParValue := globalTblTName[1]; exit; end;
   if ParName = 'TblT3Name'      then begin ParValue := globalTblTName[2]; exit; end;
   if ParName = 'TblT4Name'      then begin ParValue := globalTblTName[3]; exit; end;
   if ParName = 'NDogovor'       then begin ParValue := NDogovor; exit; end;
   if ParName = 'NameObject'     then begin ParValue := NameObject; exit; end;
   if ParName = 'Adress'         then begin ParValue := Adress; exit; end;
   if ParName = 'WorksName'      then begin ParValue := WorksName; exit; end;
   if ParName = 'TtlMainName'    then begin ParValue := globalTtlMainName; exit; end;
   if ParName = 'TtlNameTbl'     then begin ParValue := globalTblName; exit; end;
   if ParName = 'KindEnergy'     then begin ParValue := strEnergy[KindEnergy]; exit; end;
   if ParName = 'FirstSign'      then begin ParValue := FirstSign; exit; end;
   if ParName = 'ThirdSign'      then begin ParValue := ThirdSign;exit;end;
   if ParName = 'SecondSign'     then begin ParValue := SecondSign; exit; end;
   if ParName = 'KoefMax'        then begin ParValue := DVLS(m_pTariffs.Items[0].m_sfKoeff); exit; end;
end;

end.
