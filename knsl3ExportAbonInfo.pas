unit knsl3ExportAbonInfo;

interface

uses Windows, utldynconnect,FileCtrl, utldatabase, utltypes, utlconst, classes, Sysutils, Forms, knsl5config, Dialogs;

type
  set_char = set of char;
  TExportAbonInfo = class
  private
    FABOID       : integer;
    FDB          : CDBDynamicConn;
    pAbons       : SL3ABONS;
    pGroups      : SL3INITTAG;
    pVMIDs       : SL3VMETERTAGS;
    pL2Tag       : SL2INITITAG;
    mAbonSize    : integer;
    mGroupsSize  : integer;
    mVMIDsSize   : integer;
    mL2TagSize   : integer;
    Stream       : TMemoryStream;
    procedure LoadGroupsData;
    procedure LoadVMetersData;
    procedure LoadL2MetersData;
    procedure LoadL2MetersDataSrv;
    procedure SaveAbonDataToFile(blSrv:Boolean);
    procedure SaveSizeInfo;
    procedure SaveSizeInfoSrv;
    procedure SaveAbonInfo;
    procedure SaveGroupsInfo;
    procedure SaveVMInfo;
    procedure SaveL2Info;
    //procedure SaveL2InfoSrv;
    procedure DeleteSymbols(var str: string);
    procedure DeleteSymbol(var str: string; ch: set_char);
    procedure RecalcPhysAddress;
  public
    constructor Create;
    procedure ExportData;
    procedure ExportDataSrv;
  public
    property PABOID : integer read FABOID write FABOID;
  end;



implementation

constructor TExportAbonInfo.Create;
begin
   FDB := CDBDynamicConn.Create(m_pDB.m_strProvider);
end;

procedure TExportAbonInfo.ExportData;
begin
   FDB.GetAbonTable(FABOID, pAbons);
   if DirectoryExists(ExtractFilePath(Application.ExeName) + '\ExportConfig\')=False then
       MkDir(ExtractFilePath(Application.ExeName) + '\ExportConfig\');
   LoadGroupsData;
   LoadVMetersData;
   LoadL2MetersData;
   SaveAbonDataToFile(False);
end;
procedure TExportAbonInfo.ExportDataSrv;
begin
   FDB.GetAbonTable(FABOID, pAbons);
   if DirectoryExists(ExtractFilePath(Application.ExeName) + '\ExportConfig\')=False then
       MkDir(ExtractFilePath(Application.ExeName) + '\ExportConfig\');
   LoadGroupsData;
   LoadVMetersData;
   LoadL2MetersDataSrv;
   SaveAbonDataToFile(True);
end;

procedure TExportAbonInfo.LoadGroupsData;
begin
   if pAbons.Count > 0 then
     FDB.GetAllAbonGroupsTable(FABOID, pGroups)
   else
     pGroups.Count := 0;
end;

procedure TExportAbonInfo.LoadVMetersData;
begin
   if (pAbons.Count > 0) and (pGroups.Count > 0) then
     FDB.GetVMsTableABON(FABOID, pVMIDs)
   else
     pVMIDs.Count := 0;
end;

procedure TExportAbonInfo.LoadL2MetersData;
begin
   pL2Tag.m_sbyLayerID := 0;
   FDB.GetL2MtrsABON(FABOID, pL2Tag);
end;
procedure TExportAbonInfo.LoadL2MetersDataSrv;
Var
   i,j : Integer;
   pTbl : SL2TAG;
begin
   j := 0;
   pL2Tag.m_sbyLayerID := 2;
   FDB.GetL2MtrsABON(FABOID, pL2Tag);
   move(pL2Tag.m_sMeter[0],pTbl,sizeof(pTbl));
   SetLength(pL2Tag.m_sMeter,pVMIDs.Count);
   for i:=0 to pVMIDs.Count-1 do
   Begin
    if (pVMIDs.Items[i].m_sbyType=MET_SUMM)or(pVMIDs.Items[i].m_sbyType=MET_GSUMM) then
    Begin
     move(pTbl,pL2Tag.m_sMeter[pL2Tag.m_swAmMeter],sizeof(SL2TAG));
     pL2Tag.m_sMeter[pL2Tag.m_swAmMeter].m_sfKI        := 1;
     pL2Tag.m_sMeter[pL2Tag.m_swAmMeter].m_sfKU        := 1;
     pL2Tag.m_sMeter[pL2Tag.m_swAmMeter].m_schName     := pVMIDs.Items[i].m_sVMeterName;
     pL2Tag.m_sMeter[pL2Tag.m_swAmMeter].m_sbyType     := pVMIDs.Items[i].m_sbyType;
     pL2Tag.m_sMeter[pL2Tag.m_swAmMeter].m_sddPHAddres := IntToStr(pVMIDs.Items[i].m_swVMID);
     Inc(pL2Tag.m_swAmMeter);
    End else
    Begin
     for j:=0 to pL2Tag.m_swAmMeter-1 do
     Begin
      if (pVMIDs.Items[i].m_swMID = pL2Tag.m_sMeter[j].m_swMID) and
         (pVMIDs.Items[i].m_swVMID = pL2Tag.m_sMeter[j].m_swVMID) then
      pL2Tag.m_sMeter[j].m_sddPHAddres := IntToStr(pVMIDs.Items[i].m_swVMID);
     End;
    End;
   End;
end;
{
function TExportAbonInfo.FindL3Tag(var nIndex:Integer):Boolean;
Var
   i,j:Integer;
Begin
   Result := False;
   for i:=0 to pVMIDs.Count-1 do
   Begin
    for j:=0 to pL2Tag.Count-1 do
    Begin
     if (pVMIDs.Items[i].m_swMID=pL2Tag.m_sMeter[i].m_swMID) then
     Begin
      nIndex := j;
      Result := True;
      exit;
     End;
    End;
   End;
End;
}
procedure TExportAbonInfo.SaveAbonDataToFile(blSrv:Boolean);
var ADFileName : string;
begin
   if pAbons.Count > 0 then
     ADFileName := pAbons.Items[0].m_sName
   else
     ADFileName := 'temp';
   DeleteSymbols(ADFileName);
   if not FileExists(ExtractFilePath(Application.ExeName) + '\ExportConfig\' + ADFileName + '.a2k') then
      TFileStream.Create(ExtractFilePath(Application.ExeName) + '\ExportConfig\' + ADFileName + '.a2k', fmCreate).Free;

   Stream := TMemoryStream.Create;
   Stream.Clear;
   if blSrv=False then SaveSizeInfo;
   if blSrv=True  then SaveSizeInfoSrv;

   SaveAbonInfo;
   SaveGroupsInfo;
   SaveVMInfo;
   SaveL2Info;
   //if blSrv=True  then SaveL2InfoSrv;

   Stream.SaveToFile(ExtractFilePath(Application.ExeName) + '\ExportConfig\' + ADFileName + '.a2k');
   Stream.Free;
   MessageDlg('Данные экспортированы в файл ' + ADFileName,mtWarning,[mbOk],0)
end;

procedure TExportAbonInfo.SaveSizeInfo;
begin
   mAbonSize := pAbons.Count * sizeof(SL3ABON);
   mGroupsSize := pGroups.Count * sizeof(SL3GROUPTAG);
   mVMIDsSize := pVMIDs.Count * sizeof(SL3VMETERTAG);
   mL2TagSize := pL2Tag.m_swAmMeter * sizeof(SL2TAG);
   Stream.Write(mAbonSize, sizeof(Integer));
   Stream.Write(mGroupsSize, sizeof(Integer));
   Stream.Write(mVMIDsSize, sizeof(Integer));
   Stream.Write(mL2TagSize, sizeof(Integer));
end;
procedure TExportAbonInfo.SaveSizeInfoSrv;
begin
   mAbonSize := pAbons.Count * sizeof(SL3ABON);
   mGroupsSize := pGroups.Count * sizeof(SL3GROUPTAG);
   mVMIDsSize := pVMIDs.Count * sizeof(SL3VMETERTAG);
   mL2TagSize := pVMIDs.Count * sizeof(SL2TAG);
   //mL2TagSize := pL2Tag.m_swAmMeter * sizeof(SL2TAG);
   //mL2TagSize := pL2Tag.m_swAmMeter * sizeof(SL2TAG);
   Stream.Write(mAbonSize, sizeof(Integer));
   Stream.Write(mGroupsSize, sizeof(Integer));
   Stream.Write(mVMIDsSize, sizeof(Integer));
   Stream.Write(mL2TagSize, sizeof(Integer));
end;

procedure TExportAbonInfo.SaveAbonInfo;
var i : integer;
begin
   for i := 0 to pAbons.Count - 1 do
     Stream.Write(pAbons.Items[i], sizeof(SL3ABON));
end;

procedure TExportAbonInfo.SaveGroupsInfo;
var i : integer;
begin
   for i := 0 to pGroups.Count - 1 do
     Stream.Write(pGroups.Items[i], sizeof(SL3GROUPTAG));
end;

procedure TExportAbonInfo.SaveVMInfo;
var i : integer;
begin
   for i := 0 to pVMIDs.Count - 1 do
     Stream.Write(pVMIDs.Items[i], sizeof(SL3VMETERTAG));
end;

procedure TExportAbonInfo.SaveL2Info;
var i : integer;
begin
   //RecalcPhysAddress;
   for i := 0 to pL2Tag.m_swAmMeter - 1 do
     Stream.Write(pL2Tag.m_sMeter[i], sizeof(SL2TAG));
end;

procedure TExportAbonInfo.DeleteSymbols(var str: string);
begin
   DeleteSymbol(str, ['/', '\', ':', '*', '?', '"', '|', '<', '>']);
end;

procedure TExportAbonInfo.DeleteSymbol(var str: string; ch: set_char);
var i: integer;
begin
   for i := 1 to Length(str) do
     if (str[i] in ch) then
       delete(str, i, 1);
end;

procedure TExportAbonInfo.RecalcPhysAddress;
var i, j: integer;
begin
   for i := 0 to pVMIDs.Count - 1 do
     for j := 0 to pL2Tag.m_swAmMeter - 1 do
       //if pVMIDs.Items[i].m_swMID = pL2Tag.m_sMeter[j].m_swMID then
       if pVMIDs.Items[i].m_sVMeterName = pL2Tag.m_sMeter[j].m_schName then
       begin
         pL2Tag.m_sMeter[j].m_sddPHAddres := IntToStr(pVMIDs.Items[i].m_swVMID);
         break;
       end;
end;

end.
