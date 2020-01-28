unit knslRPCheckPowerSystXL;


interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;
type
  TRPCheckPowerSystXL = class(TForm)
  constructor Create;
  destructor Destroy;override;

  private
    { Private declarations }
    FDB               : PCDBDynamicConn;
    FsgGrid           : TAdvStringGrid;
    FsgGrid2           : PTAdvStringGrid;
    m_nPlaneList       : TStringList;
    globalPointName   : string;
    PowerSum          : array [0..47] of Double;

    NameMonth2        : String;
    NameMonth1        : String;
    str               : String;
    maxSrez           : Double;
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;

    FProgress         : PTProgressBar;
    FABOID            : Integer;
    DateReport        : TDateTime;
    Groups            : SL2TAGREPORTLIST;
    procedure FillReport;
    procedure ShowDataTable(MID:integer;MU,MV:Extended;Stime1,Stime2:TDateTime);
    procedure SaveTimeToHeader(MID:Integer;pTU,pTV:TM_TARIFF);
    procedure DeleteAll;
    procedure frReport1ManualBuild();
    procedure InitComboPl;
    Function  FindAndReplace(find_,rep_:string):boolean;
  public
    { Public declarations }
    Koef              : array [0..99] of Double;
    DateBeg           : TDateTime;
    DateEnd           : TDateTime;
    prTarifID         : integer;
    KindEnergy        : integer;
    BChecked          : boolean;
    NDogovor          : string;
    FirstSign         : string;
    procedure CreateReport(Date:TDateTime);
    procedure PrepareTable;
    procedure OnFormResize;
  public
    property PsgGrid      :TAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB          :PCDBDynamicConn  read FDB           write FDB;
    property PsgGrid2     :PTAdvStringGrid  read FsgGrid2      write FsgGrid2;
    property PProgress    :PTProgressBar    read FProgress     write FProgress;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;


var
  rpCheckPowerSystXL    : TRPCheckPowerSystXL;
{const
  strEnergy   : array [0..3] of string = ('¬ид энергии : јктивна€ потребл€ема€(к¬т)',
                                          '¬ид энергии : јктивна€ отдаваема€(к¬т)',
                                          '¬ид энергии : –еактивна€ потребл€ема€(к¬ар)',
                                          '¬ид энергии : –еактивна€ отдаваема€(к¬ар)');
  strEK       : array [0..3] of string = ('к¬т',
                                          'к¬т',
                                          'к¬ар',
                                          'к¬ар');  }

implementation

constructor TRPCheckPowerSystXL.Create;
Begin

End;

destructor TRPCheckPowerSystXL.Destroy;
Begin
    inherited;
End;

procedure TRPCheckPowerSystXL.InitComboPl;
Var
    pTable : TM_PLANES;
    i : Integer;
Begin
    if m_pDB.GetTPlanesTable(pTable) then
      Begin
      FsgGrid.Combobox.Items.Clear;
      m_nPlaneList.Clear;
         for i:=0 to pTable.Count-1 do
         Begin
         FsgGrid.Combobox.Items.Add(pTable.Items[i].m_sName);
         m_nPlaneList.Add(pTable.Items[i].m_sName);
         End;
      End;
End;

procedure TRPCheckPowerSystXL.DeleteAll;
  var i : integer;
begin
   for i := 1 to FsgGrid2.RowCount - 1 do
     begin
     FsgGrid2.Cells[0,i] := '';
     FsgGrid2.Cells[1,i] := '';
     end;
   FsgGrid2.RowCount := 2;
end;

procedure  TRPCheckPowerSystXL.FillReport;//(storeKoef : array [0..99] of Double;);
   var
    i                    : byte;
    MID,s_VMID           : integer;
    Data                 : CCDatas;
    m_pGrData            : L3GRAPHDATAS;
    TempDate             : TDateTime;
    pTable               : TM_TARIFFS;
    MU,MV                : extended;
    Year, Month, Day     : word;
    Hour, Min, Sec, MSec : Word;
    DateBeg1,DateEnd1,stime1,stime2: TDateTime;
begin
    FProgress.Max:= FsgGrid.RowCount;
      if not FDB.GetMeterGLVRashcet(-1,Groups) then
      FsgGrid.RowCount := 1
      else
         begin
           for i:=0 to Groups.Count-1 do
              begin
              MID:=i;
              TempDate := DateReport;
     //globalPointName := FsgGrid.Cells[1, MID+1];
              s_VMID := StrToInt(FsgGrid.Cells[1, MID+1]);
     //RasxSum[0] := 0;
              DecodeDate(DateReport, Year, Month, Day);
              Day := 1;
              DateBeg := EncodeDate(Year, Month, Day);
              Day := cDateTimeR.DayPerMonth(Month, Year);
              DateEnd := EncodeDate(Year, Month, Day);

                if FDB.GetGraphDatas(DateEnd, DateBeg, s_VMID,QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
                begin
                FDB.GetTMTarPeriodsCmdTable(Now,s_VMID,QRY_SRES_ENR_EP,4,pTable);
                  if (MID=1) then
                  SaveTimeToHeader(MID,GetTar(3,pTable),GetTar(4,pTable));
                  MU := RVLPr(GetMaxTZoneMax(GetTAllMask(3,pTable),m_pGrData,stime1)*2,3);
                  MV := RVLPr(GetMaxTZoneMax(GetTAllMask(4,pTable),m_pGrData,stime2)*2,3);
                  ShowDataTable(MID,MU,MV,stime1,stime2);
                  FProgress.Position := MID;
                end;
              end;
         end;
end;

procedure  TRPCheckPowerSystXL.SaveTimeToHeader(MID:Integer;pTU,pTV:TM_TARIFF);
VAr
    sTimeU,sTimeV : String;
    Hour, Min, Sec, MSec: Word;
    Hour1, Min1, Sec1, MSec1: Word;
begin
    if (pTU.m_swID=-1)or(pTV.m_swID=-1) then
       Begin
       sTimeU := 'c 08:00 по 11:00';
       sTimeV := 'c 17:00 по 20:00';
       FindAndReplace('#Time1&',sTimeU);
       FindAndReplace('#Time2&',sTimeV);
       FindAndReplace('#Name&',rpCheckPowerSystXL.FirstSign);
       //if rpCheckPowerSystXL.FirstSign='' then
       // FindAndReplace('#Name&',Groups.m_sMeter[MID].m_sGroupName) else
       //  FindAndReplace('#Name&',rpCheckPowerSystXL.FirstSign);
       exit;
       End;
    DecodeTime(pTU.m_dtTime0, Hour, Min, Sec, MSec);
    DecodeTime(pTU.m_dtTime1, Hour1, Min1, Sec1, MSec1);
    sTimeU := Format('с %.2d : %.2d до %.2d : %.2d ',[Hour, Min, Hour1, Min1]);
    DecodeTime(pTV.m_dtTime0, Hour, Min, Sec, MSec);
    DecodeTime(pTV.m_dtTime1, Hour1, Min1, Sec1, MSec1);
    sTimeV := Format('с %.2d : %.2d до %.2d : %.2d ',[Hour, Min, Hour1, Min1]);

    FindAndReplace('#Name&',rpCheckPowerSystXL.FirstSign);
    FindAndReplace('#Time1&',sTimeU);
    FindAndReplace('#Time2&',sTimeV);
end;


Function  TRPCheckPowerSystXL.FindAndReplace(find_,rep_:string):boolean;
   var range:variant;
begin
   FindAndReplace:=false;
    if find_<>'' then
      begin
      try
      range:=Excel.Range['A1:EL230'].Replace(What:=find_,Replacement:=rep_);
      FindAndReplace:=true;
      except
      FindAndReplace:=false;
      end;
end;
End;

procedure TRPCheckPowerSystXL.ShowDataTable(MID:integer;MU,MV:Extended;Stime1,Stime2:TDateTime);
 begin
   Excel.ActiveSheet.Cells[a_,1].Value := Groups.m_sMeter[MID].M_SDOGNUM;
   Excel.ActiveSheet.Cells[a_,2].Value := Groups.m_sMeter[MID].m_sName;
   //Excel.ActiveSheet.Cells[a_,4].Value := 'все';
   Excel.ActiveSheet.Cells[a_,3].Value := Groups.m_sMeter[MID].M_SMAXPOWER;

   if (MU>MV) then
    begin
    Excel.ActiveSheet.Cells[a_,4].Value :=MU;
      if (Groups.m_sMeter[MID].M_SMAXPOWER<MU) then
       Excel.ActiveSheet.Cells[a_,6].Value :=MU-Groups.m_sMeter[MID].M_SMAXPOWER;
       Excel.ActiveSheet.Cells[a_,5].Value := DateTimeToStr(Stime1);
     end
   else
     begin
     Excel.ActiveSheet.Cells[a_,4].Value :=MV;
       if (Groups.m_sMeter[MID].M_SMAXPOWER<MV) then
       Excel.ActiveSheet.Cells[a_,6].Value :=MV-Groups.m_sMeter[MID].M_SMAXPOWER;
       Excel.ActiveSheet.Cells[a_,5].Value := DateTimeToStr(Stime2);
      end;

   Excel.ActiveSheet.Cells[a_,7].Value :='по '+ m_nPlaneList.Strings[Groups.m_sMeter[MID].M_SWPLID];
   a_:=a_+1;
 end;

procedure TRPCheckPowerSystXL.frReport1ManualBuild();
var
   i      : integer;

begin
   a_:=7;
   FProgress.Create(Owner);
   FProgress.Visible := true;
      for i := 0 to 47 do
      PowerSum[i] := 0;
   maxSrez := 0;
  //FormTitle();
   FillReport;
   Excel.ActiveWorkBook.WorkSheets[1].Range['A7:H'+IntToStr(a_-1)].Select;//выдел€ем всю таблицу
   Excel.Selection.Borders.LineStyle         :=1;//устанавливаем стиль границы
   Excel.Selection.Borders.Weight            := xlThin;//<-это тонка€;
   Excel.Selection.HorizontalAlignment       :=-4108;
   Excel.Selection.WrapText:=true;
   Excel.ActiveWorkBook.WorkSheets[1].Range['B7:B'+IntToStr(a_-1)].Select;
   Excel.Selection.HorizontalAlignment       :=xlLeft;
   Excel.ActiveWorkBook.WorkSheets[1].Range['H7:H'+IntToStr(a_-1)].Select;
   Excel.Selection.HorizontalAlignment       :=xlLeft;

   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$6';// при печати на каждой странице ввыводитс€ шапка

   Excel.ActiveWorkBook.WorkSheets[1].Range['A5:H5'].Characters(start:=89, Length:=Length(NameMonth2)).Font.bold:=true;
   Excel.ActiveWorkBook.WorkSheets[1].Range['A5:H5'].Characters(start:=89+Length(NameMonth2)+1+Length(str)+1, Length:=Length(NameMonth1)).Font.bold:=true;
end;

procedure TRPCheckPowerSystXL.CreateReport(Date:TDateTime);
   var
    Data      : CCDatas;
    m_pGrData : L3GRAPHDATAS;
    TempDate  : TDateTime;
    NameMonth :String;
    Year, Month, Day,Year1, Month1, Day1: word;
begin
    Page := 1;
    DateReport := Date;
    try
    Excel := CreateOleObject('Excel.Application');
    except
       MessageDlg('Ќа компьютере отсутствует MS Office Excell или не та верси€', mtWarning, [mbOK], 0);
       exit;
    end;
    Excel.Application.EnableEvents := false;
    Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPCheckPowerSystXL.xls');
    Excel.ActiveSheet.PageSetup.Orientation:= 2;
    Sheet:= Excel.Sheets.item[Page];
    Excel.ActiveWorkBook.worksheets[Page].activate;
    Sheet.Name := 'ѕроверка в часы максимума';
    DecodeDate(Now, Year, Month, Day);
    NameMonth:=cDateTimeR.GetNameMonth1(Month);
    NameMonth2:= FloatToStr(Day)+' '+NameMonth+' '+FloatToStr(Year);
    FindAndReplace('#TblDate&',NameMonth2);

    DecodeDate (DateReport, Year1, Month1, Day1);
    NameMonth1:=cDateTimeR.GetNameMonth0(Month1);
    FindAndReplace('#mes&',NameMonth1+' ');
    str:='(за';
    FindAndReplace('#dlina&',str);
    InitComboPl;
    frReport1ManualBuild(); //(storeKoef);
         try
      FProgress.Position:=0;
      Excel.Visible := true;
     finally
       if not VarIsEmpty(Excel) then
       begin
       //Excel.Quit;
       Excel := Unassigned;
       Sheet := Unassigned;
       //exWorkBook:=Unassigned;
       //FsgGrid := nil;
       FProgress.Visible :=false;
       FProgress.Enabled  := false;
       FProgress := nil;
       //fm_nEVL.free;
       end;
       end;
end;

procedure TRPCheckPowerSystXL.PrepareTable;                                                     
   var i      : integer;
begin

     if FsgGrid=Nil then
     exit;
   if m_nPlaneList=nil then m_nPlaneList:=TStringList.Create; 
   FsgGrid.ColCount   := 5;
   FsgGrid.Cells[0,0] := 'є п.п';
   FsgGrid.Cells[1,0] := 'VMID';
   FsgGrid.Cells[2,0] := 'јбонент';
   FsgGrid.Cells[3,0] := 'є договора';
   FsgGrid.Cells[4,0] := '“очка учета';
   FsgGrid.ColWidths[1] := 40;
   FsgGrid.ColWidths[0] := 30;
         if not FDB.GetMeterGLVRashcet(-1,Groups) then
         FsgGrid.RowCount := 1
         else
           begin
           FsgGrid.RowCount := Groups.Count + 1;
             for i := 0 to Groups.Count - 1 do
             begin
             FsgGrid.Cells[0, i + 1] := IntToStr(i);
             FsgGrid.Cells[1, i + 1] := IntToStr(Groups.m_sMeter[i].m_swVMID);
             FsgGrid.Cells[2, i + 1] := Groups.m_sMeter[i].m_sName;
             FsgGrid.Cells[3, i + 1] := Groups.m_sMeter[i].M_SDOGNUM;
             FsgGrid.Cells[4, i + 1] := Groups.m_sMeter[i].m_sVMeterName;
             end;
           end;
   OnFormResize;
end;

procedure TRPCheckPowerSystXL.OnFormResize;
    Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
      for i:=2 to FsgGrid.ColCount-1  do
      FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-1));
      //PChild.OnFormResize;
End;

end.
