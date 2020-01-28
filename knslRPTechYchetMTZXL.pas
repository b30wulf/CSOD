unit knslRPTechYchetMTZXL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;


type
  TRPTechYchetMTZXL = class
  private
    { Private declarations }
    mVMetersInfo      : array of Integer;
    mPercentInfo      : array of Double;
    mExpressionsInfo  : SL3PARAMSS;
    mVmetersNames     : SL3ARRAYOFSTRING;
    mAdditInfo        : SL3TECHMTZREPORTSDATAS;
    mSliceInfo        : L3GRAPHDATAS;
    FDB               : PCDBDynamicConn;
    FABOID            : Integer;
    FsgGrid           : PTAdvStringGrid;
    Page              : integer;
    Excel             : variant;
    Sheet             : variant;
    exWorkBook        : Variant;
    FProgress         : PTProgressBar;
    mGroupName        : string;
    mIsSilChast       : boolean;
    mCurrSumA         : Double;
    mGroupSumA        : Double;
    mGroupSilSumA     : Double;
    mGroupPecSumA     : Double;
    mTotalSumA        : Double;
    mCurrSumR         : Double;
    mGroupSumR        : Double;
    mGroupSilSumR     : Double;
    mGroupPecSumR     : Double;
    mTotalSumR        : Double;
    posToWrite        : Integer;
    procedure BuildReport;
    procedure FillReport(GrID: Integer);
    procedure FillReportTtl;
    procedure SetExcelVisible;
    procedure EncodeExpression;
    procedure GetVMIDFromExpress(i: integer);
    procedure GetPercentFromExpress(i: integer);
    procedure GetAdditInfo;
    procedure FindPrirEnergy(VMItem, KindEn: integer);
    procedure FillDateInfo;
    procedure SendOneMeterToExcel(VMID,posInMS:Integer);
    procedure SendGroupSumToExcel;
    procedure SendSilPecGroupSumToExcel;
    function  GetPosFromAdditInfo(VMID : integer): integer;
    function  IsGPP(var str : string) : boolean;
    function  FindAndReplace(find,rep:string):boolean;
    procedure SetStringsArrays(var VMIDStr, CMDIDStr : string);
    procedure SetZeroToGroupSum;
    procedure CheckSilOrPech(Node, KindEn : Integer);
  public
    { Public declarations }
    WorksName         : string;
    FirstSign         : string;
    ThirdSign         : string;
    SecondSign        : string;
    NDogovor          : string;
    NameObject        : string;
    Adress            : string;
    m_strObjCode      : string;
    mAllowString      : string;
    dt_DateBeg        : TDateTime;
    dt_DateEnd        : TDateTime;
    procedure OnFormResize;
    procedure PrepareTable;
    procedure CreateReport;
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PABOID      :Integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PProgress   :PTProgressBar    read FProgress    write FProgress;
  end;

var
  RPTechYchetMTZXL : TRPTechYchetMTZXL;
  
implementation


procedure TRPTechYchetMTZXL.PrepareTable;
var Groups : SL3INITTAG;
    i      : integer;
begin
   if FsgGrid=Nil then
     exit;
   FsgGrid.ColCount   := 3;
   FsgGrid.Cells[0,0] := '№ п.п';
   FsgGrid.Cells[1,0] := 'Наименование группы';
   FsgGrid.ColWidths[0]  := 30;
   if not FDB.GetAbonGroupsTable(FABOID,Groups) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Groups.Count + 1;
     for i := 0 to Groups.Count - 1 do
     begin
       FsgGrid.Cells[0, i + 1] := IntToStr(Groups.Items[i].m_sbyGroupID);
       FsgGrid.Cells[1, i + 1] := Groups.Items[i].m_sGroupName;
     end;
   end;
   OnFormResize;
end;

procedure TRPTechYchetMTZXL.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPTechYchetMTZXL.CreateReport;
begin
   Page := 1;
   mTotalSumA := 0;
   mTotalSumR := 0;
   posToWrite := 5;
   try
   Excel := CreateOleObject('Excel.Application');
   except
     MessageDlg('На компьютере отсутствует MS Office Excel или не та версия', mtWarning, [mbOK], 0);
     exit;
   end;
   Excel.Application.EnableEvents := false;
   exWorkBook  := Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPTechYchetMTZ.xls');
   Excel.ActiveSheet.PageSetup.Orientation:= 1;
   Sheet      := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
   BuildReport;
end;

procedure TRPTechYchetMTZXL.BuildReport;
var i : integer;
begin
   FProgress.Visible := true;
   FProgress.Max:=FsgGrid.RowCount;
   FProgress.Position:=0;
   FillDateInfo;
   for i := 1 to FsgGrid.RowCount - 1 do
   begin
     FProgress.Position := i;
     if (FsgGrid.Cells[0, i] <> '') and (FsgGrid.IsChecked(2, i)) then
     begin
       mGroupName := FsgGrid.Cells[1, i];
       FillReport(StrToInt(FsgGrid.Cells[0, i]));
     end;
   end;
   FillReportTtl;
   SetExcelVisible;
end;

procedure TRPTechYchetMTZXL.FillReport(GrID: Integer);
var i                 : integer;
    VMIDStr, CMDIDStr : string;
begin
   SetZeroToGroupSum;
   PDB.GetParamTableForGroup(GrID, mExpressionsInfo, mVmetersNames);
   EncodeExpression;
   GetAdditInfo;
   SetStringsArrays(VMIDStr, CMDIDStr);
//   mExpressionsInfo.Items[VMItem].m_swVMID, QRY_SRES_ENR_EP + KindEn, mSliceInfo);
   PDB.GetGraphDatasFromSomeVMIDs(dt_DateEnd, dt_DateBeg, VMIDStr, CMDIDStr, mSliceInfo);
   for i := 0 to Length(mVMetersInfo) - 1 do
   begin
     FindPrirEnergy(i, 0);
     FindPrirEnergy(i, 2);
     SendOneMeterToExcel(mExpressionsInfo.Items[i].m_swVMID, i);
   end;
   if mIsSilChast then
     SendSilPecGroupSumToExcel;
   SendGroupSumToExcel;
end;

procedure TRPTechYchetMTZXL.EncodeExpression;
var i : integer;
begin
   SetLength(mVMetersInfo, mExpressionsInfo.Count);
   SetLength(mPercentInfo, mExpressionsInfo.Count);
   for i := 0 to mExpressionsInfo.Count - 1 do
   begin
     GetVMIDFromExpress(i);
     GetPercentFromExpress(i);
   end;
end;

procedure TRPTechYchetMTZXL.GetVMIDFromExpress(i: integer);
var pos1, pos2 : integer;
    tStr       : string;
begin
   pos1 := Pos('v', mExpressionsInfo.Items[i].m_sParamExpress);
   pos2 := Pos('_E30', mExpressionsInfo.Items[i].m_sParamExpress);
   if (pos1 <> 0) and (pos2 <> 0) then
   begin
     tStr := Copy(mExpressionsInfo.Items[i].m_sParamExpress, pos1 + 1, pos2 - pos1 - 1);
     mVMetersInfo[i] := StrToInt(tStr);
   end
   else
     mVMetersInfo[i] := -1;
end;

procedure TRPTechYchetMTZXL.GetPercentFromExpress(i: integer);
var pos1, pos2 : integer;
    tStr       : String;
begin
   pos1 := 1;
   pos2 := Pos('*', mExpressionsInfo.Items[i].m_sParamExpress);
   if (pos2 > pos1) then
   begin
     tStr := Copy(mExpressionsInfo.Items[i].m_sParamExpress, pos1, pos2 - pos1 - 1);
     mPercentInfo[i] := StrToFloat(tStr);
   end
   else
     mPercentInfo[i] := 1;
end;

procedure TRPTechYchetMTZXL.GetAdditInfo;
var tstr : string;
    i    : integer;
begin
   for i := 0 to Length(mVMetersInfo) do
   begin
     tstr := tstr + IntToStr(mVMetersInfo[i]) + ',';
   end;
   if (tstr[Length(tstr)] = ',') then
     tstr[Length(tstr)] := ' ';
   PDB.GetAdditInfoForMTZTex(tstr, mAdditInfo);
end;

procedure TRPTechYchetMTZXL.SetExcelVisible;
begin
   try
     Excel.Visible := true;
   finally
     if not VarIsEmpty(Excel) then
     begin
       //Excel.Quit;
       Excel := Unassigned;
       Sheet := Unassigned;
       exWorkBook:=Unassigned;
     end;
   end;
end;

procedure TRPTechYchetMTZXL.FindPrirEnergy(VMItem, KindEn: integer);
var i, j       : integer;
begin
    if KindEn = 0 then
      mCurrSumA  := 0
    else
      mCurrSumR  := 0;
    //PDB.GetGraphDatas(dt_DateEnd, dt_DateBeg, mExpressionsInfo.Items[VMItem].m_swVMID, QRY_SRES_ENR_EP + KindEn, mSliceInfo);
    for i := 0 to mSliceInfo.Count - 1 do
    begin
      if (mSliceInfo.Items[i].m_swVMID = mExpressionsInfo.Items[VMItem].m_swVMID)
          and (mSliceInfo.Items[i].m_swCMDID = QRY_SRES_ENR_EP + KindEn) then
        for j := 0 to 47 do
          if KindEn = 0 then
            mCurrSumA := mCurrSumA + mSliceInfo.Items[i].v[j]
          else
            mCurrSumR := mCurrSumR + mSliceInfo.Items[i].v[j];
    end;
    CheckSilOrPech(VMItem, KindEn);
    if KindEn = 0 then
    begin
      mGroupSumA := mGroupSumA + mCurrSumA;
      mTotalSumA := mTotalSumA + mCurrSumA;
    end else
    begin
      mGroupSumR := mGroupSumR + mCurrSumR;
      mTotalSumR := mTotalSumR + mCurrSumR;
    end;
end;

procedure TRPTechYchetMTZXL.FillDateInfo;
begin
   FindAndReplace('#BeginDate', DateToStr(dt_DateBeg));
   FindAndReplace('#EndDate', DateToStr(dt_DateEnd));
end;

procedure TRPTechYchetMTZXL.SendOneMeterToExcel(VMID, posInMS:Integer);
var posInAdditInfo : integer;
begin
   posInAdditInfo := GetPosFromAdditInfo(mVMetersInfo[posInMS]);
   Excel.ActiveSheet.Range['A'+IntToStr(posToWrite+1)+':J'+IntToStr(posToWrite+1)].Select;
   Excel.Selection.Borders.LineStyle:=1;

   //Excel.ActiveSheet.Range['A'+IntToStr(posToWrite)+':J'+IntToStr(posToWrite)].Merge;
   Excel.ActiveSheet.Cells[posToWrite+1,1].Value := mGroupName;
   Excel.ActiveSheet.Cells[posToWrite+1,2].Value := mAdditInfo.Items[posInAdditInfo].m_sTpNum;
   Excel.ActiveSheet.Cells[posToWrite+1,3].Value := mAdditInfo.Items[posInAdditInfo].m_nFiderName;
   if IsGPP(mAdditInfo.Items[posInAdditInfo].m_nKPName) then
   begin
     Excel.ActiveSheet.Cells[posToWrite+1,4].Value := RVLPrStr(mAdditInfo.Items[posInAdditInfo].m_nKTransform, 0);
     Excel.ActiveSheet.Cells[posToWrite+1,7].Value := RVLPrStr(mAdditInfo.Items[posInAdditInfo].m_nKTransform, 0);
   end
   else
   begin
     Excel.ActiveSheet.Cells[posToWrite+1,4].Value := RVLPrStr(mAdditInfo.Items[posInAdditInfo].m_nKTransform / 10, 1);
     Excel.ActiveSheet.Cells[posToWrite+1,7].Value := RVLPrStr(mAdditInfo.Items[posInAdditInfo].m_nKTransform / 10, 1);
   end;
   Excel.ActiveSheet.Cells[posToWrite+1,5].Value := RVLPrStr(mPercentInfo[posInMS] * 100, 2) + '%';
   Excel.ActiveSheet.Cells[posToWrite+1,6].Value := RVLPrStr(mCurrSumA, 0);
   Excel.ActiveSheet.Cells[posToWrite+1,8].Value := RVLPrStr(mPercentInfo[posInMS] * 100, 2) + '%';
   Excel.ActiveSheet.Cells[posToWrite+1,9].Value := RVLPrStr(mCurrSumR, 0);
   if (mCurrSumA <> 0) then
     Excel.ActiveSheet.Cells[posToWrite+1,10].Value := RVLPrStr(mCurrSumR / mCurrSumA, 4)
   else
     Excel.ActiveSheet.Cells[posToWrite+1,10].Value := 'Дел. на 0';
   posToWrite := posToWrite + 1;
end;

procedure TRPTechYchetMTZXL.SendGroupSumToExcel;
begin
   //Excel.ActiveSheet.Range['A'+IntToStr(posToWrite)+':J'+IntToStr(posToWrite)].Select;
   //Excel.Selection.Borders.LineStyle:=1;
   //Excel.ActiveSheet.Range['A'+IntToStr(posToWrite)+':J'+IntToStr(posToWrite)].Merge;
   Excel.ActiveSheet.Cells[posToWrite+1,5].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+1,6].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+1,9].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+1,10].Font.Bold := true;
   
   Excel.ActiveSheet.Cells[posToWrite+1,5].Value := 'Сумма';
   Excel.ActiveSheet.Cells[posToWrite+1,6].Value := RVLPrStr(mGroupSumA, 0);
   Excel.ActiveSheet.Cells[posToWrite+1,9].Value := RVLPrStr(mGroupSumR, 0);
   if (mGroupSumA <> 0) then
     Excel.ActiveSheet.Cells[posToWrite+1,10].Value := RVLPrStr(mGroupSumR / mGroupSumA, 4)
   else
     Excel.ActiveSheet.Cells[posToWrite+1,10].Value := 'Дел. на 0';
   posToWrite := posToWrite + 1;
end;
          //Font.Bold
procedure TRPTechYchetMTZXL.SendSilPecGroupSumToExcel;
begin
   Excel.ActiveSheet.Cells[posToWrite+1,5].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+1,6].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+1,9].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+1,10].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+2,5].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+2,6].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+2,9].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+2,10].Font.Bold := true;

   Excel.ActiveSheet.Cells[posToWrite+1,5].Value := 'Силовая';
   Excel.ActiveSheet.Cells[posToWrite+1,6].Value := RVLPrStr(mGroupSilSumA, 0);
   Excel.ActiveSheet.Cells[posToWrite+1,9].Value := RVLPrStr(mGroupSilSumR, 0);
   if (mGroupSilSumA <> 0) then
     Excel.ActiveSheet.Cells[posToWrite+1,10].Value := RVLPrStr(mGroupSilSumR / mGroupSilSumA, 4)
   else
     Excel.ActiveSheet.Cells[posToWrite+1,10].Value := 'Дел. на 0';
   posToWrite := posToWrite + 1;


   Excel.ActiveSheet.Cells[posToWrite+1,5].Value := 'Печная';
   Excel.ActiveSheet.Cells[posToWrite+1,6].Value := RVLPrStr(mGroupPecSumA, 0);
   Excel.ActiveSheet.Cells[posToWrite+1,9].Value := RVLPrStr(mGroupPecSumR, 0);
   if (mGroupPecSumA <> 0) then
     Excel.ActiveSheet.Cells[posToWrite+1,10].Value := RVLPrStr(mGroupPecSumR / mGroupPecSumA, 4)
   else
     Excel.ActiveSheet.Cells[posToWrite+1,10].Value := 'Дел. на 0';
   posToWrite := posToWrite + 1;
end;


procedure TRPTechYchetMTZXL.FillReportTtl;
begin
   //Excel.ActiveSheet.Range['A'+IntToStr(posToWrite)+':J'+IntToStr(posToWrite)].Select;
  // Excel.Selection.Borders.LineStyle:=1;
  // Excel.ActiveSheet.Range['A'+IntToStr(posToWrite)+':J'+IntToStr(posToWrite)].Merge;
  Excel.ActiveSheet.Cells[posToWrite+1,5].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+1,6].Font.Bold := true;
   Excel.ActiveSheet.Cells[posToWrite+1,9].Font.Bold := true;

   Excel.ActiveSheet.Cells[posToWrite+1,5].Value := 'Общая сумма';
   Excel.ActiveSheet.Cells[posToWrite+1,6].Value := RVLPrStr(mTotalSumA, 0);
   Excel.ActiveSheet.Cells[posToWrite+1,9].Value := RVLPrStr(mTotalSumR, 0);
end;

function TRPTechYchetMTZXL.GetPosFromAdditInfo(VMID : integer): integer;
var i : integer;
begin
   Result := 0;
   for i := 0 to mAdditInfo.Count - 1 do
     if mAdditInfo.Items[i].m_nVMID = VMID then
     begin
       Result := i;
       exit;
     end;
end;

function TRPTechYchetMTZXL.IsGPP(var str : string) : boolean;
begin
   if Pos('ГПП', str) > 0 then
     Result := true
   else
     Result := false;
end;

function  TRPTechYchetMTZXL.FindAndReplace(find,rep:string):boolean;
var range : variant;
begin
   FindAndReplace := false;
   if find<>'' then
   begin
     try
       range:=Excel.Range['A1:EL230'].Replace(What := find,Replacement := rep);
       FindAndReplace:=true;
     except
       FindAndReplace:=false;
     end;
   end;
end;

procedure TRPTechYchetMTZXL.SetStringsArrays(var VMIDStr, CMDIDStr : string);
var i : integer;
begin
   VMIDStr := '-1,';
   CMDIDStr := '13, 15';
   for i := 0 to mExpressionsInfo.Count - 1 do
     VMIDStr := VMIDStr + IntToStr(mExpressionsInfo.Items[i].m_swVMID) + ',';
   if VMIDStr[Length(VMIDStr)] = ',' then
     VMIDStr[Length(VMIDStr)] := ' ';
end;

procedure TRPTechYchetMTZXL.SetZeroToGroupSum;
begin
   mGroupSumA := 0;
   mGroupSilSumA := 0;
   mGroupPecSumA := 0;
   mGroupSumR := 0;
   mGroupSilSumR := 0;
   mGroupPecSumR := 0;
   mIsSilChast := false;
end;

procedure TRPTechYchetMTZXL.CheckSilOrPech(Node, KindEn : Integer);
var FindSilPos, FindPecPos : Integer;
begin
   FindSilPos := Pos('(с)', mVmetersNames.Items[Node].m_nString) or Pos('(c)', mVmetersNames.Items[Node].m_nString);
   FindPecPos := Pos('(п)', mVmetersNames.Items[Node].m_nString);
   if FindSilPos > 0 then
   begin
     mIsSilChast := true;
     if KindEn = 0 then
       mGroupSilSumA := mGroupSilSumA + mCurrSumA
     else
       mGroupSilSumR := mGroupSilSumR + mCurrSumR;
   end;
   if FindPecPos > 0 then
   begin
     mIsSilChast := true;
     if KindEn = 0 then
       mGroupPecSumA := mGroupPecSumA + mCurrSumA
     else
       mGroupPecSumR := mGroupPecSumR + mCurrSumR;
   end;
end;

end.
