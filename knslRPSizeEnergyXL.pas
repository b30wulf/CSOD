unit knslRPSizeEnergyXL;

interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;
type
  TrpSizeEnergyXL = class(TForm)
  constructor Create;
  destructor Destroy;override;
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
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;
    FProgress         : PTProgressBar;
    FABOID            : Integer;
    procedure FormTitle;
    Function  FindAndReplace(find_,rep_:string):boolean;
    procedure BuildReport;
    function  DateOutSec(Date : TDateTime) : string;
    function  CalcCountTariffs() : byte;
    procedure LoadTarif;
    procedure ReadArchAbonent;
    procedure ReadArch;
    Function  ReturnResultTime(STarif:string):byte;
    Function  OtputTimeTarif(countTarif:byte):byte;
    procedure frReport1ManualBuild;
    procedure FillTotal;
    procedure ShowData1;
    procedure ShowFooter1;
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
    KoefTar           : single;
    GroupID           : integer;
    glCountTableShow  : string;
    glCountTable      : integer;
    function  DeleteSpaces(str :string) : string;
    procedure CreatReport(Date1, Date2 : TDateTime; CountTable:Integer;ItemIndSyzeEnergy:integer);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property TID         :integer          read FTID         write FTID;
    property PProgress   :PTProgressBar  read FProgress         write FProgress;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;

var
  rpSizeEnergyXL: TrpSizeEnergyXL;
const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт*ч)',
                                          'Вид энергии : Активная отдаваемая(кВт*ч)',
                                          'Вид энергии : Реактивная потребляемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');

implementation

constructor TrpSizeEnergyXL.Create;
Begin

End;

destructor TrpSizeEnergyXL.Destroy;
Begin
    inherited;
End;

function  TrpSizeEnergyXL.CalcCountTariffs() : byte;
var i : word;
begin
  Result := m_pTariffs.Items[0].m_swTID;
  for i := 1 to m_pTariffs.Count - 1 do
    if m_pTariffs.Items[i].m_swTID > Result then
      Result := m_pTariffs.Items[i].m_swTID;
end;

function TrpSizeEnergyXL.DateOutSec(Date : TDateTime) : string;
var str : string;
begin
   str := TimeToStr(Date);
   SetLength(str, Length(str) - 3);
   Result := str;
end;

function  TrpSizeEnergyXL.DeleteSpaces(str :string) : string;
begin
   while str[Length(str)] = ' ' do
     SetLength(str, Length(str) - 1);
   Result := str;
end;

procedure TrpSizeEnergyXL.CreatReport(Date1, Date2 : TDateTime; CountTable:Integer;ItemIndSyzeEnergy:Integer);
begin
   Page := 1;
   DateBeg     := Date1;
   DateEnd     := Date2;
   glCountTable := CountTable;
   ItemInd     := ItemIndSyzeEnergy;
   FTID        := FDB.LoadTID(QRY_SRES_ENR_EP + KindEnergy);;
   KoefTar     := StrToFloat(FsgGrid.Cells[2, ItemInd]);
   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('На компьютере отсутствует MS Office Excell или не та версия', mtWarning, [mbOK], 0);
   end;
   Excel.Application.EnableEvents := false;
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPSizeEnergy.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 1;
   Sheet := Excel.Sheets.item[Page];
   Sheet.Name := 'Объем электроэнергии';
   frReport1ManualBuild;
end;

Function TrpSizeEnergyXL.OtputTimeTarif(countTarif:byte):byte;
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

procedure TrpSizeEnergyXL.FillTotal();
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
  ShowData1;
 end;
 glSumEnergTarif := DVLEX(m_nPrecise,SumEnergTarif);
end;

procedure TrpSizeEnergyXL.ReadArch;
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


 Function TrpSizeEnergyXL.ReturnResultTime(STarif:string):byte;
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

procedure TrpSizeEnergyXL.ReadArchAbonent;
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


procedure TrpSizeEnergyXL.LoadTarif;
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

procedure TrpSizeEnergyXL.BuildReport();
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
  FillTotal();
end;

procedure TrpSizeEnergyXL.ShowData1;
begin
   a_ := a_+ 1;
   FProgress.Position := a_;
   Excel.ActiveSheet.Cells[a_,2].Value := 'c ' + glTarifBegin + 'до ' + glTarifEnd;
   Excel.ActiveSheet.Cells[a_,4].Value := glSrez;
end;

procedure TrpSizeEnergyXL.ShowFooter1;
begin
   a_ := a_+ 1;
   FProgress.Position := a_;
   Excel.ActiveSheet.Cells[a_,2].Value := 'ИТОГО по РУП "__________________"(Свод по ГПО "Брестэнерго")';
   Excel.ActiveSheet.Cells[a_,4].Value := glSumEnergTarif;
end;

Function  TrpSizeEnergyXL.FindAndReplace(find_,rep_:string):boolean;
 var range:variant;
begin
FindAndReplace:=false;
if find_<>'' then begin
   try
   range:=Excel.Range['A1:EL230'].Replace(What:=find_,Replacement:=rep_);
   FindAndReplace:=true;
   except
   FindAndReplace:=false;
   end;
   end;
End;

procedure TrpSizeEnergyXL.FormTitle();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTtlMainName);
        FindAndReplace('#CountTbl&',glCountTableShow);
        FindAndReplace('YearBegin',GlobalYearBegin);
        FindAndReplace('YearEnd',GlobalYearEnd);
        FindAndReplace('TtlNameTbl',globalTblName);
        FindAndReplace('DateTtlB',glMB);
        FindAndReplace('DateTtlE',glME);
end;

procedure TrpSizeEnergyXL.frReport1ManualBuild();
var i                : integer;
    TempDate         : TDateTime;
    Month,Year,Day : word;
begin
   FProgress.Create(Owner);
   FProgress.Visible := true;
   FProgress.Max:= 25;
   a_:= 12;
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
   glCountTableShow := 'Таблица № ' + IntToStr(glCountTable);
   FormTitle;
   BuildReport;
   ShowFooter1;

   Excel.ActiveWorkBook.WorkSheets[1].Range['A13:B'+IntToStr(a_)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle         :=1;//устанавливаем границы
//   Excel.Selection.Borders.Weight           := xlMedium;
   Excel.Selection.HorizontalAlignment       :=-4108;
   Excel.Selection.WrapText:=true;

   Excel.ActiveWorkBook.WorkSheets[1].Range['D13:E'+IntToStr(a_)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle         :=1;//устанавливаем границы
  // Excel.Selection.Borders.Weight           := xlMedium;
   Excel.Selection.HorizontalAlignment       :=-4108;
   Excel.Selection.WrapText:=true;

   Excel.ActiveWorkBook.WorkSheets[1].Range['A'+IntToStr(a_)+':E'+IntToStr(a_)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle         :=9;//устанавливаем границы
 //  Excel.Selection.Borders.Weight           := xlMedium;
   Excel.Selection.HorizontalAlignment       :=-4108;
   Excel.Selection.WrapText:=true;
   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$12 ';// при печати на каждой странице ввыводится шапка
   Excel.ActiveSheet.PageSetup.LeftFooter :='&8'+FirstSign + SecondSign + ThirdSign;
 try
      Excel.Visible := true;
    finally
     if not VarIsEmpty(Excel) then
    begin
      //Excel.Quit;
      Excel := Unassigned;
      Sheet := Unassigned;
      //FsgGrid := nil;
      FProgress.Visible := false;
      FProgress.Enabled := false;
      FProgress := nil;
     end;
end;
end;


end.
