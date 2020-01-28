unit knsl3SchemLoader;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, utltypes, AdvMenus, utldatabase, menus, AdvProgressBar,
  utlexparcer, utlconst, utldynconnect,utlbox;

type
   TTShemLoader = class
     private
       mSchemInfo    : SL3SCHEMTABLES;
       SchemPointers : TList;
       m_nEVL        : CEvaluator;
       procedure AddSubMenus(var MenuItem : TMenuItem;  SubNodeNum : integer);
       procedure OnSchemMenuClick(Sender: TObject);
       procedure OnSchemClose(Sender: TObject; var Action: TCloseAction);
       procedure OnSchemResize(Sender: TObject);
       function  IsOpenForm(t_tag : integer):boolean;
       function  GetFormAddr(var Sender: TObject):integer;
       procedure LoadArrays;
       procedure FreeArrays(nID: integer);
       function  GetStrFromArr(var CMDIDList :array of integer):string;
       function  FindTangens(VMID : integer; var pTable : L3CURRENTDATAS; var blUnderline : boolean):double;
       function  GetValueFromCurrDatas(VMID, CMDID : integer; var pTable:L3CURRENTDATAS; var IsCurr : boolean):double;
       procedure LoadPrognozParameters;
       procedure RefreshPrognozForm(ListNum : integer);
       procedure WriteLimits(schNode : Pointer; PrognozA, TekRasxA, PrognozR, TekRasxR : double);
       function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
       procedure EncodeFormula(var str : string; var buf : array of integer);
       function  GetNumOfMembers(var str : string): integer;
       procedure ReadPrognozValue(schNode : Pointer;var  PrognozA, TekRasxA, PrognozR, TekRasxR : double);
//       function  FindTotalNakEnAkt(var pTable : L3CURRENTDATAS; var m_nFormula : string):double;
//       function  FindTotalNakEnRea(var pTable : L3CURRENTDATAS; var m_nFormula : string):double;
       function  FindTotalRasxDay(var  pTable : L3CURRENTDATAS; CMDID : integer):double;
//       function  FindTotalNakEnAktDay(var pTable : L3CURRENTDATAS; var m_nFormula : string):double;
//       function  FindTotalNakEnReaDay(var pTable : L3CURRENTDATAS; var m_nFormula : string):double;
       function  FindPrirAktEnDay(var pTable : L3GRAPHDATAS):double;
       function  FindPrirReaEnDay(var pTable : L3GRAPHDATAS):double;
       function  FindAktPrognoz(VMID : integer; var pTable : L3CURRENTDATAS):double;
       function  FindReaPrognoz(VMID : integer; var pTable : L3CURRENTDATAS):double;
       procedure RefreshOneForm(ID : integer);
       procedure SetLabelUnderline(var tempLabel: TLabel);
       procedure UnsetLabelUnderline(var tempLabel: TLabel);
       function  CheckDate(CMDID : integer; Time : TDateTime):boolean;
     public
       procedure Init;
       procedure GetPopupMenuInfo(var SchemMenuInfo : TAdvPopupMenu);
       procedure RefreshForms;
       destructor Destroy; override;
   end;

var
  TShemLoader : TTShemLoader;
  m_pMDB      : PCDBDynamicConn;

implementation

function TTShemLoader.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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

procedure TTShemLoader.Init;
begin
   m_pMDB := m_pDB.CreateConnect;
   SchemPointers := TList.Create;
   RegisterClasses([TForm, TLabel,TImage,TAdvProgressBar]);
   m_pMDB.GetSchemsTable(mSchemInfo);
   m_nEVL := CEvaluator.Create;
//   m_nEVL.Init;
end;

procedure TTShemLoader.GetPopupMenuInfo(var SchemMenuInfo : TAdvPopupMenu);
var MenuItem : TMenuItem;
    i        : integer;
begin
   SchemMenuInfo.Items.Clear;
   m_pMDB.GetSchemsTable(mSchemInfo);
   for i := 0 to mSchemInfo.Count - 1 do
   begin
     if (mSchemInfo.Items[i].m_swNodeNum = -1) or (mSchemInfo.Items[i].m_swSubNodeNum = -1) then
     begin
       MenuItem         := TMenuItem.Create(Application.MainForm);
       MenuItem.Caption := mSchemInfo.Items[i].m_sNodeName;
       MenuItem.Tag     := mSchemInfo.Items[i].m_swNodeNum;
       MenuItem.OnClick := OnSchemMenuClick;
       if (mSchemInfo.Items[i].m_swSubNodeNum <> -1) then
         AddSubMenus(MenuItem, mSchemInfo.Items[i].m_swSubNodeNum);
       SchemMenuInfo.Items.Add(MenuItem);
     end;
   end;
end;

procedure TTShemLoader.AddSubMenus(var MenuItem : TMenuItem; SubNodeNum : integer);
var i           : integer;
    SubMenuItem : TMenuItem;
begin
   for i := 0 to mSchemInfo.Count - 1 do
   begin
     if (mSchemInfo.Items[i].m_swSubNodeNum = SubNodeNum) and (mSchemInfo.Items[i].m_swNodeNum <> -1) then
     begin
       SubMenuItem         := TMenuItem.Create(Application.MainForm);
       SubMenuItem.Caption := mSchemInfo.Items[i].m_sNodeName;
       SubMenuItem.Tag     := mSchemInfo.Items[i].m_swNodeNum;
       SubMenuItem.OnClick := OnSchemMenuClick;
       MenuItem.Add(SubMenuItem);
     end;
   end;
end;
//SchemPointers
procedure TTShemLoader.OnSchemMenuClick(Sender: TObject);
var i          : integer;
    t_tag      : integer;
    fs         : TFileStream;
    ms         : TMemoryStream;
    pSchemNode : ^SL3SCHEMPOINTER;
begin
   try
   if Sender is TMenuItem then
   begin
     t_tag := TMenuItem(Sender).Tag;
     if (t_tag <> - 1) and (not IsOpenForm(t_tag)) then
     begin
       New(pSchemNode);
       for i := 0 to mSchemInfo.Count - 1 do
         if mSchemInfo.Items[i].m_swNodeNum = t_tag then
         begin
         try
             fs := TFileStream.Create(mSchemInfo.Items[i].m_sPathToFile, fmOpenRead);
             ms := TMemoryStream.Create;
             ObjectTextToBinary(fs,ms);
             ms.Position := 0;
             pSchemNode.m_nFormPointer := TForm.CreateNew(Application);
             ms.ReadComponent(pSchemNode.m_nFormPointer);
             pSchemNode.m_nFormPointer.OnClose := OnSchemClose;
             pSchemNode.m_nFormPointer.OnResize := OnSchemResize;
             pSchemNode.m_nSchemID := t_tag;
             pSchemNode.m_nFormPointer.Tag := t_tag;
             SchemPointers.Add(pSchemNode);
             LoadArrays;
             RefreshOneForm(SchemPointers.Count - 1);
             //OnSchemResize(pSchemNode.m_nFormPointer);
           finally
            ms.free;
            fs.free;
           end;
         end;

     end;
   end;
   except
     m_nQweryReboot := 1;
   end;
end;

procedure TTShemLoader.OnSchemClose(Sender: TObject; var Action: TCloseAction);
var nID : integer;
begin
   try
   Action := caFree;
   nID := GetFormAddr(Sender);
   if (nID >= 0) and (nID < SchemPointers.Count) then
   begin
     //FreeNodes(nID);
     FreeArrays(nID);
     SchemPointers.Delete(nID);
   end;
   except
     m_nQweryReboot := 1;
   end;
end;

procedure TTShemLoader.OnSchemResize(Sender: TObject);
var i         : integer;
    KH, KW    : double;
    IH, IW    : integer;
    nID       : integer;
    mControl  : TControl;
    SchemNode : ^SL3SCHEMPOINTER;
begin
   try
   nID := GetFormAddr(Sender);
   KW  := 1;
   KH  := 1;
   if (Sender is TForm) and (nID >= 0) and (nID < SchemPointers.Count) then
   begin
     SchemNode := SchemPointers.Items[nID];
     for i := 0 to SchemNode.m_nFormPointer.ComponentCount - 1 do
       if TForm(Sender).Components[i] is TImage then
       begin
         IW := TControl(TForm(Sender).Components[i]).Width;
         IH := TControl(TForm(Sender).Components[i]).Height;
         KW := IW / TImage(TForm(Sender).Components[i]).Picture.Width;
         KH := IH /TImage(TForm(Sender).Components[i]).Picture.Height;
         break;
       end;

     for i := 0 to SchemNode.m_nFormPointer.ComponentCount - 1 do
       if not (TForm(Sender).Components[i] is TImage) then
       begin
         mControl := TControl(TForm(Sender).Components[i]);
         mControl.Left := trunc(SchemNode.m_nCompSizes[i].X * KW);
         mControl.Top := trunc(SchemNode.m_nCompSizes[i].Y * KH);
         mControl.Width := trunc(SchemNode.m_nCompSizes[i].Width * KW);
         mControl.Height := trunc(SchemNode.m_nCompSizes[i].Height * KH);
         if mControl is TLabel then
         begin
           TLabel(mControl).Font.Size := mControl.Height - 5;
           mControl.Height := TLabel(mControl).Font.Size + 10;
         end;
       end;
   end;
   except
     m_nQweryReboot := 1;
   end;
end;

function TTShemLoader.IsOpenForm(t_tag : integer):boolean;
var i          : integer;
    pSchemNode : ^SL3SCHEMPOINTER;
begin
   Result := false;
   for i := 0 to SchemPointers.Count - 1 do
   begin
     pSchemNode := SchemPointers.Items[i];
     if pSchemNode.m_nSchemID = t_tag then
       Result := true;
   end;
end;

function TTShemLoader.GetFormAddr(var Sender: TObject):integer;
var i          : integer;
    pSchemNode : ^SL3SCHEMPOINTER;
begin
   Result := -1;
   if Sender is TForm then
   begin
     for i := 0 to SchemPointers.Count - 1 do
     begin
       pSchemNode := SchemPointers.Items[i];
       if pSchemNode.m_nFormPointer.Tag = TForm(Sender).Tag then
         Result := i;
     end;
   end;
end;

procedure TTShemLoader.FreeArrays(nID: integer);
var pSchemNode : ^SL3SCHEMPOINTER;
    i          : integer;
begin
   pSchemNode := SchemPointers.Items[nID];

   if pSchemNode.m_nCMDIDList <> nil then
     Finalize(pSchemNode.m_nCMDIDList);
   if pSchemNode.m_nVMIDList <> nil then
     Finalize(pSchemNode.m_nVMIDList);
   for i := 0 to Length(pSchemNode.m_nLabelPoint) - 1 do
     pSchemNode.m_nLabelPoint[i].Free;
   if pSchemNode.m_nLabelPoint <> nil then
     Finalize(pSchemNode.m_nLabelPoint);
   if pSchemNode.m_nVMIDSum <> nil then
     Finalize(pSchemNode.m_nVMIDSum);
   if pSchemNode.m_nPrBars <> nil then
   begin
     for i := 0 to Length(pSchemNode.m_nPrBars) - 1 do
       pSchemNode.m_nPrBars[i].Free;
     Finalize(pSchemNode.m_nPrBars);
   end;
   if pSchemNode.m_nCompSizes <> nil then
     Finalize(pSchemNode.m_nCompSizes);
end;

procedure TTShemLoader.LoadArrays;
var pSchemNode   : ^SL3SCHEMPOINTER;
    i            : integer;
    arrayLbLen   : integer;
    arraySBLen   : integer;
begin
   pSchemNode := SchemPointers.Items[SchemPointers.Count - 1];

   pSchemNode.m_nVMIDSum := nil;
   pSchemNode.m_nPrBars  := nil;
   pSchemNode.m_nVMIDSum := nil;
   arrayLbLen   := 0;
   arraySBLen   := 0;
   SetLength(pSchemNode.m_nCompSizes, pSchemNode.m_nFormPointer.ComponentCount);

   for i := 0 to pSchemNode.m_nFormPointer.ComponentCount - 1 do
   begin
     if pSchemNode.m_nFormPointer.Components[i] is TImage then
     begin
       pSchemNode.m_nBFWidth := TImage(pSchemNode.m_nFormPointer.Components[i]).Picture.Width;
       pSchemNode.m_nBFHeight := TImage(pSchemNode.m_nFormPointer.Components[i]).Picture.Height;
     end;
     pSchemNode.m_nCompSizes[i].X := TControl(pSchemNode.m_nFormPointer.Components[i]).Left;
     pSchemNode.m_nCompSizes[i].Y := TControl(pSchemNode.m_nFormPointer.Components[i]).Top;
     pSchemNode.m_nCompSizes[i].Width := TControl(pSchemNode.m_nFormPointer.Components[i]).Width;
     pSchemNode.m_nCompSizes[i].Height := TControl(pSchemNode.m_nFormPointer.Components[i]).Height;
     if pSchemNode.m_nFormPointer.Components[i] is TLabel then
       if pSchemNode.m_nFormPointer.Components[i].Tag <> -1 then
         arrayLbLen := arrayLbLen + 1;
     if pSchemNode.m_nFormPointer.Components[i] is TAdvProgressBar then
       arraySBLen := arraySBLen + 1;
   end;

   SetLength(pSchemNode.m_nCMDIDList, arrayLbLen);
   SetLength(pSchemNode.m_nVMIDList, arrayLbLen);
   SetLength(pSchemNode.m_nLabelPoint, arrayLbLen);
   SetLength(pSchemNode.m_nPrBars, arraySBLen);

   arrayLbLen := 0;
   arraySBLen := 0;

   for i := 0 to pSchemNode.m_nFormPointer.ComponentCount - 1 do
   begin
     if (pSchemNode.m_nFormPointer.Components[i] is TLabel) and (pSchemNode.m_nFormPointer.Components[i].Tag <> -1) then
     begin
       pSchemNode.m_nCMDIDList[arrayLbLen] := pSchemNode.m_nFormPointer.Components[i].Tag mod 1000;
       pSchemNode.m_nVMIDList[arrayLbLen] := pSchemNode.m_nFormPointer.Components[i].Tag div 1000;
       pSchemNode.m_nLabelPoint[arrayLbLen] := TLabel(pSchemNode.m_nFormPointer.Components[i]);
       arrayLbLen := arrayLbLen + 1;
     end;
     if (pSchemNode.m_nFormPointer.Components[i] is TAdvProgressBar) then
     begin
       pSchemNode.m_nPrBars[arraySBLen] := TAdvProgressBar(pSchemNode.m_nFormPointer.Components[i]);
       arraySBLen := arraySBLen + 1;
       if pSchemNode.m_nVMIDSum = nil then
         LoadPrognozParameters;
     end;
   end;
end;
//RVLPr

procedure TTShemLoader.RefreshOneForm(ID : integer);
var j              : integer;
    pSchemNode        : ^SL3SCHEMPOINTER;
    CMDIDStr, VMIDStr : string;
    pTable            : L3CURRENTDATAS;
    IsCurr            : boolean;
begin
   try
   pSchemNode := SchemPointers.Items[ID];
   if pSchemNode.m_nPrBars <> nil then
     exit;

   CMDIDStr := GetStrFromArr(pSchemNode.m_nCMDIDList);
   VMIDStr := GetStrFromArr(pSchemNode.m_nVMIDList);
   m_pMDB.GetCurrentDataForSchems(CMDIDStr, VMIDStr, pTable);

   for j := 0 to Length(pSchemNode.m_nCMDIDList) - 1 do
   begin

     if pSchemNode.m_nCMDIDList[j] <> QRY_TANGENS then
       pSchemNode.m_nLabelPoint[j].Caption := FloatToStr(
                        RVLPr(GetValueFromCurrDatas(pSchemNode.m_nVMIDList[j], pSchemNode.m_nCMDIDList[j], pTable, IsCurr),
                        0))

     else
       pSchemNode.m_nLabelPoint[j].Caption := FloatToStr(
                        RVLPr(GetValueFromCurrDatas(pSchemNode.m_nVMIDList[j], pSchemNode.m_nCMDIDList[j], pTable, IsCurr),
                        3));

     if IsCurr then
       UnsetLabelUnderline(pSchemNode.m_nLabelPoint[j])
     else
       SetLabelUnderline(pSchemNode.m_nLabelPoint[j]);
   end;
   except
     m_nQweryReboot := 1;
   end;
end;

procedure TTShemLoader.RefreshForms;
var i, j              : integer;
    pSchemNode        : ^SL3SCHEMPOINTER;
    CMDIDStr, VMIDStr : string;
    pTable            : L3CURRENTDATAS;
    IsCurr            : boolean;
begin
   try
   for i := 0 to SchemPointers.Count - 1 do
   begin
     pSchemNode := SchemPointers.Items[i];
     if pSchemNode.m_nPrBars <> nil then
     begin
       RefreshPrognozForm(i);
       continue;
     end;
     CMDIDStr := GetStrFromArr(pSchemNode.m_nCMDIDList);
     VMIDStr := GetStrFromArr(pSchemNode.m_nVMIDList);
     m_pMDB.GetCurrentDataForSchems(CMDIDStr, VMIDStr, pTable);
     for j := 0 to Length(pSchemNode.m_nCMDIDList) - 1 do
     begin
       if pSchemNode.m_nCMDIDList[j] <> QRY_TANGENS then
         pSchemNode.m_nLabelPoint[j].Caption := FloatToStr(
                          RVLPr(GetValueFromCurrDatas(pSchemNode.m_nVMIDList[j], pSchemNode.m_nCMDIDList[j], pTable, IsCurr),
                          0))
       else
         pSchemNode.m_nLabelPoint[j].Caption := FloatToStr(
                          RVLPr(GetValueFromCurrDatas(pSchemNode.m_nVMIDList[j], pSchemNode.m_nCMDIDList[j], pTable, IsCurr),
                          3));
       if IsCurr then
         UnsetLabelUnderline(pSchemNode.m_nLabelPoint[j])
       else
         SetLabelUnderline(pSchemNode.m_nLabelPoint[j]);
     end;
   end;
   except
     m_nQweryReboot := 1;
   end;
end;

function TTShemLoader.GetStrFromArr(var CMDIDList :array of integer):string;
var i : integer;
begin
   Result := '(';
   for i := 0 to Length(CMDIDList) - 1 do
   begin
     if (CMDIDList[i] = QRY_U_PARAM_S) then
     begin
       Result := Result + IntToStr(CMDIDList[i]) + ',';
       Result := Result + IntToStr(CMDIDList[i] + 1) + ',';
     end else
       Result := Result + IntToStr(CMDIDList[i]) + ',';
   end;
   if Result[Length(Result)] = ',' then
     Result[Length(Result)] := ' ';
   Result := Result + ')';
end;

function TTShemLoader.FindTangens(VMID : integer; var pTable : L3CURRENTDATAS; var blUnderline : boolean):double;
var p3A, p3R    : Double;
begin
   p3A := GetValueFromCurrDatas(VMID, QRY_E3MIN_POW_EP, pTable, blUnderline);
   p3R := GetValueFromCurrDatas(VMID, QRY_E3MIN_POW_RP, pTable, blUnderline);
   if p3A <> 0 then
     Result := p3R / p3A
   else
     Result := 0;
end;                     

function TTShemLoader.GetValueFromCurrDatas(VMID, CMDID : integer; var pTable:L3CURRENTDATAS; var IsCurr : boolean):double;
var i : integer;
begin
   Result := 0;
   IsCurr := false;
   if CMDID = QRY_U_PARAM_S then
     Result := GetValueFromCurrDatas(VMID, QRY_U_PARAM_A, pTable, IsCurr) * sqrt(3)
   else if CMDID = QRY_TANGENS then
     Result := FindTangens(VMID, pTable, IsCurr)
   else
     for i := 0 to pTable.Count - 1 do
       if (pTable.Items[i].m_swVMID = VMID) and (pTable.Items[i].m_swCMDID = CMDID) then
       begin
         Result := pTable.Items[i].m_sfValue;
         IsCurr := CheckDate(CMDID, pTable.Items[i].m_sTime);
       end;
end;

function TTShemLoader.GetNumOfMembers(var str : string): integer;
var i : integer;
begin
   Result := 0;
   for i := 1 to Length(str) do
     if str[i] = '_' then
       Result := Result + 1;
end;

procedure TTShemLoader.EncodeFormula(var str : string; var buf : array of integer);
var i         : integer;
    VMIDCount : integer;
    tstr      : string;
begin
   tstr := '';
   VMIDCount := 0;
   for i := 1 to Length(str) do
     if (str[i] >= '0') and (str[i] <= '9') then
       tstr := tstr + str[i]
     else if length(tstr) > 0 then
     begin
       buf[VMIDCount] := StrToInt(tstr);
       tstr := '';
       VMIDCount := VMIDCount + 1;
     end;
   if length(tstr) > 0 then
     buf[VMIDCount] := StrToInt(tstr);
end;

procedure TTShemLoader.LoadPrognozParameters;
var pSchemNode                 : ^SL3SCHEMPOINTER;
    VMID, FTID, TID_P, TID_Q   : integer;
    m_pTariffs                 : TM_TARIFFS;
begin
   pSchemNode := SchemPointers.Items[SchemPointers.Count - 1];
   VMID := pSchemNode.m_nPrBars[0].Tag div 1000;
   pSchemNode.m_nFormula := m_pMDB.GetFormulaForVMID(VMID);
   SetLength(pSchemNode.m_nVMIDSum, GetNumOfMembers(pSchemNode.m_nFormula));
   EncodeFormula(pSchemNode.m_nFormula, pSchemNode.m_nVMIDSum);
   if Length(pSchemNode.m_nVMIDSum) = 0 then
   begin
     pSchemNode.m_nFormula := 'v' + IntToStr(VMID) + '_P';
     SetLength(pSchemNode.m_nVMIDSum, 1);
     pSchemNode.m_nVMIDSum[0] := VMID;
   end;
   FTID := m_pMDB.LoadTID(QRY_SRES_ENR_EP);
   m_pMDB.GetTMTarPeriodsTable(VMID,FTID, m_pTariffs);
   TID_P := GetColorFromTariffs(trunc(frac(Now) / EncodeTime(0, 30, 0, 0)), m_pTariffs);
   FTID := m_pMDB.LoadTID(QRY_SRES_ENR_RP);
   m_pMDB.GetTMTarPeriodsTable(VMID,FTID, m_pTariffs);
   TID_Q := GetColorFromTariffs(trunc(frac(Now) / EncodeTime(0, 30, 0, 0)), m_pTariffs);
   pSchemNode.m_nAktLimit := m_pMDB.GetCurrLimitValue(VMID, QRY_SRES_ENR_EP, TID_P);
   pSchemNode.m_nReaLimit := m_pMDB.GetCurrLimitValue(VMID, QRY_SRES_ENR_RP, TID_Q);
end;

procedure TTShemLoader.RefreshPrognozForm(ListNum : integer);
var pSchemNode        : ^SL3SCHEMPOINTER;
    PrognozA, TekRasxA,
    PrognozR, TekRasxR: double;
   // NumSl             : integer;
   // tdt               : TDateTime;
begin
  // NumSl := trunc(frac(Now) / EncodeTime(0, 30, 0, 0));
  // tdt   := frac(Now) - NumSl * EncodeTime(0, 30, 0, 0);
   //if (tdt < EncodeTime(0, 6, 0, 0)) then exit;
   pSchemNode := SchemPointers.Items[ListNum];
   ReadPrognozValue(pSchemNode, PrognozA, TekRasxA, PrognozR, TekRasxR);
   WriteLimits(pSchemNode, PrognozA, TekRasxA, PrognozR, TekRasxR);
end;

procedure TTShemLoader.ReadPrognozValue(schNode : Pointer;var  PrognozA, TekRasxA, PrognozR, TekRasxR : double);
var pSchemNode           : ^SL3SCHEMPOINTER;
    CMDIDStr, VMIDStr    : string;
    pTable               : L3CURRENTDATAS;
    pGrTable             : L3GRAPHDATAS;
    tPrognozA, tPrognozR : double;
    i                    : integer;
begin
   pSchemNode := schNode;
   VMIDStr  := '(' + IntToStr(pSchemNode.m_nPrBars[0].Tag div 1000) + ')';
   CMDIDStr := '(5,7)';

   m_pMDB.GetCurrentDataForSchems(CMDIDStr, VMIDStr, pTable);
   TekRasxA := FindTotalRasxDay(pTable, QRY_ENERGY_DAY_EP);
   TekRasxR := FindTotalRasxDay(pTable, QRY_ENERGY_DAY_RP);

   m_pMDB.GetGraphDatasEnergo(Now, Now, pSchemNode.m_nPrBars[0].Tag div 1000, QRY_SRES_ENR_EP, pGrTable);

   TekRasxA := TekRasxA - FindPrirAktEnDay(pGrTable);
   TekRasxR := TekRasxR - FindPrirReaEnDay(pGrTable);
   VMIDStr := '(';
   for i := 0 to Length(pSchemNode.m_nVMIDSum) - 1 do
     VMIDStr := VMIDStr + IntToStr(pSchemNode.m_nVMIDSum[i]) + ',';
   VMIDStr[Length(VMIDStr)] := ')';
   CMDIDStr   := '(29, 31)';
   m_pMDB.GetCurrentDataForSchems(CMDIDStr, VMIDStr, pTable);

   m_nEVL.Expression := pSchemNode.m_nFormula;


   for i := 0 to Length(pSchemNode.m_nVMIDSum) - 1 do
   m_nEVL.Variable['v' + IntToStr(pSchemNode.m_nVMIDSum[i])+'_P'] := FindAktPrognoz(pSchemNode.m_nVMIDSum[i], pTable);
   tPrognozA := m_nEVL.Value;


   m_nEVL.Expression := pSchemNode.m_nFormula;
   for i := 0 to Length(pSchemNode.m_nVMIDSum) - 1 do

   m_nEVL.Variable['v' + IntToStr(pSchemNode.m_nVMIDSum[i])+'_P'] := FindReaPrognoz(pSchemNode.m_nVMIDSum[i], pTable);
   tPrognozR := m_nEVL.Value;

  // VMIDStr    := '(' + IntToStr(pSchemNode.m_nPrBars[0].Tag div 1000) + ')';

  //
  // m_pMDB.GetCurrentDataForSchems(CMDIDStr, VMIDStr, pTable);

   PrognozA := TekRasxA + tPrognozA / 2;
   PrognozR := TekRasxR + tPrognozR / 2;

   TekRasxA := TekRasxA * 2;
   TekRasxR := TekRasxR * 2;



   PrognozA := PrognozA * 2;
   PrognozR := PrognozR * 2;

   if (TekRasxA < 0) then TekRasxA := 0;
   if (TekRasxR < 0) then TekRasxR := 0;
   if (PrognozA < 0) then PrognozA := 0;
   if (PrognozR < 0) then PrognozR := 0;
end;

function TTShemLoader.FindTotalRasxDay(var  pTable : L3CURRENTDATAS; CMDID : integer):double;
var i : integer;
begin
   Result := 0;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swCMDID = CMDID) then
         Result := pTable.Items[i].m_sfValue;
end;

{
function TTShemLoader.FindTotalNakEnAkt(var pTable : L3CURRENTDATAS; var m_nFormula : string):double;
var i : integer;
begin
   Result := 0;
   m_nEVL.Expression := m_nFormula;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swCMDID = QRY_ENERGY_SUM_EP) then
       if (trunc(pTable.Items[i].m_sTime) = trunc(Now)) then
         m_nEVL.Variable['v' + IntToStr(pTable.Items[i].m_swVMID)+'_P'] := pTable.Items[i].m_sfValue
       else
         m_nEVL.Variable['v' + IntToStr(pTable.Items[i].m_swVMID)+'_P'] := 0;
   try
     Result := m_nEVL.Value;
   except
     Result := 0;
   end;
end;


function TTShemLoader.FindTotalNakEnRea(var pTable : L3CURRENTDATAS; var m_nFormula : string):double;
var i : integer;
begin
   Result := 0;
   m_nEVL.Expression := m_nFormula;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swCMDID = QRY_ENERGY_SUM_RP) then
       if (trunc(pTable.Items[i].m_sTime) = trunc(Now)) then
         m_nEVL.Variable['v' + IntToStr(pTable.Items[i].m_swVMID)+'_P'] := pTable.Items[i].m_sfValue
       else
         m_nEVL.Variable['v' + IntToStr(pTable.Items[i].m_swVMID)+'_P'] := 0;
   try
     Result := m_nEVL.Value;
   except
     Result := 0;
   end;
end;

function TTShemLoader.FindTotalNakEnAktDay(var pTable : L3CURRENTDATAS; var m_nFormula : string):double;
var i : integer;
begin
   Result := 0;
   m_nEVL.Expression := m_nFormula;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swCMDID = QRY_NAK_EN_DAY_EP) then
       if (trunc(pTable.Items[i].m_sTime) = trunc(Now)) then
         m_nEVL.Variable['v' + IntToStr(pTable.Items[i].m_swVMID)+'_P'] := pTable.Items[i].m_sfValue
       else
         m_nEVL.Variable['v' + IntToStr(pTable.Items[i].m_swVMID)+'_P'] := 0;
   try
     Result := m_nEVL.Value;
   except
     Result := 0;
   end;
end;

function TTShemLoader.FindTotalNakEnReaDay(var pTable : L3CURRENTDATAS; var m_nFormula : string):double;
var i : integer;
begin
   Result := 0;
   m_nEVL.Expression := m_nFormula;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swCMDID = QRY_NAK_EN_DAY_RP) then
       if (trunc(pTable.Items[i].m_sTime) = trunc(Now)) then
         m_nEVL.Variable['v' + IntToStr(pTable.Items[i].m_swVMID)+'_P'] := pTable.Items[i].m_sfValue
       else
         m_nEVL.Variable['v' + IntToStr(pTable.Items[i].m_swVMID)+'_P'] := 0;
   try
     Result := m_nEVL.Value;
   except
     Result := 0;
   end;
end;     }

function TTShemLoader.FindPrirAktEnDay(var pTable : L3GRAPHDATAS):double;
var i, j : integer;
begin
   Result := 0;
   for i := 0 to pTable.Count - 1  do
     if (pTable.Items[i].m_swCMDID = QRY_SRES_ENR_EP) then
       if (trunc(pTable.Items[i].m_sdtDate) = trunc(Now))  then
         for j := 0 to 47 do
           Result := Result + pTable.Items[i].v[j]
       else
         Result := 0;
end;

function TTShemLoader.FindPrirReaEnDay(var pTable : L3GRAPHDATAS):double;
var i, j : integer;
begin
   Result := 0;
   for i := 0 to pTable.Count - 1  do
     if (pTable.Items[i].m_swCMDID = QRY_SRES_ENR_RP) then
       if (trunc(pTable.Items[i].m_sdtDate) = trunc(Now))  then
         for j := 0 to 47 do
           Result := Result + pTable.Items[i].v[j]
       else
         Result := 0;
end;

function TTShemLoader.FindAktPrognoz(VMID : integer; var pTable : L3CURRENTDATAS):double;
var i            : integer;
    NumSl        : integer;
    tdt          : TDateTime;
    NumOf_3Discr : double;
begin
   Result := 0;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swCMDID = QRY_E3MIN_POW_EP) and (pTable.Items[i].m_swVMID = VMID) then
       if (trunc(pTable.Items[i].m_sTime) = trunc(Now)) then
       begin
         NumSl := trunc(frac(pTable.Items[i].m_sTime) / EncodeTime(0, 30, 0, 0));
         tdt   := (NumSl + 1) * EncodeTime(0, 30, 0, 0) - frac(pTable.Items[i].m_sTime);
         NumOf_3Discr := tdt / EncodeTime(0, 30, 0, 0);
         Result := NumOf_3Discr * pTable.Items[i].m_sfValue;
       end
       else
         Result := 0;
end;

function TTShemLoader.FindReaPrognoz(VMID : integer; var pTable : L3CURRENTDATAS):double;
var i            : integer;
    NumSl        : integer;
    tdt          : TDateTime;
    NumOf_3Discr : double;
begin
   Result := 0;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swCMDID = QRY_E3MIN_POW_RP) and (pTable.Items[i].m_swVMID = VMID) then
       if (trunc(pTable.Items[i].m_sTime) = trunc(Now)) then
       begin
         NumSl := trunc(frac(pTable.Items[i].m_sTime) / EncodeTime(0, 30, 0, 0));
         tdt   := (NumSl + 1) * EncodeTime(0, 30, 0, 0) - frac(pTable.Items[i].m_sTime);
         NumOf_3Discr := tdt / EncodeTime(0, 30, 0, 0);
         Result := NumOf_3Discr * pTable.Items[i].m_sfValue;
       end
       else
         Result := 0;
end;

procedure TTShemLoader.WriteLimits(schNode : Pointer; PrognozA, TekRasxA, PrognozR, TekRasxR : double);
var i                 : integer;
    pSchemNode        : ^SL3SCHEMPOINTER;
    Modul             : integer;
begin
   pSchemNode := schNode;
   for i := 0 to Length(pSchemNode.m_nPrBars) - 1 do
   begin
     Modul := pSchemNode.m_nPrBars[i].Tag mod 1000;
     case Modul of
       0 : pSchemNode.m_nPrBars[i].Position := 100;
       1 : if (pSchemNode.m_nAktLimit <> 0) and (PrognozA / pSchemNode.m_nAktLimit <= 1) then
             pSchemNode.m_nPrBars[i].Position := trunc(PrognozA / pSchemNode.m_nAktLimit*100)
           else
             pSchemNode.m_nPrBars[i].Position := 100;
       2 : if (pSchemNode.m_nAktLimit <> 0) and (TekRasxA / pSchemNode.m_nAktLimit <= 1) then
             pSchemNode.m_nPrBars[i].Position := trunc(TekRasxA / pSchemNode.m_nAktLimit*100)
           else
             pSchemNode.m_nPrBars[i].Position := 100;
       3 : pSchemNode.m_nPrBars[i].Position := 100;
       4 : if (pSchemNode.m_nAktLimit <> 0) and (PrognozR / pSchemNode.m_nAktLimit <= 1) then
             pSchemNode.m_nPrBars[i].Position := trunc(PrognozR / pSchemNode.m_nReaLimit*100)
           else
             pSchemNode.m_nPrBars[i].Position := 100;
       5 : if (pSchemNode.m_nAktLimit <> 0) and (TekRasxR / pSchemNode.m_nAktLimit <= 1) then
             pSchemNode.m_nPrBars[i].Position := trunc(TekRasxR / pSchemNode.m_nReaLimit*100)
           else
             pSchemNode.m_nPrBars[i].Position := 100;
     end;
   end;
   for i := 0 to Length(pSchemNode.m_nLabelPoint) - 1 do
   begin
     Modul := pSchemNode.m_nLabelPoint[i].Tag mod 1000;
     case Modul of
       0 : pSchemNode.m_nLabelPoint[i].Caption := FloatToStr(RVLPr(pSchemNode.m_nAktLimit, 0));
       1 : pSchemNode.m_nLabelPoint[i].Caption := FloatToStr(RVLPr(PrognozA, 0));
       2 : pSchemNode.m_nLabelPoint[i].Caption := FloatToStr(RVLPr(TekRasxA, 0));
       3 : pSchemNode.m_nLabelPoint[i].Caption := FloatToStr(RVLPr(pSchemNode.m_nReaLimit, 0));
       4 : pSchemNode.m_nLabelPoint[i].Caption := FloatToStr(RVLPr(PrognozR, 0));
       5 : pSchemNode.m_nLabelPoint[i].Caption := FloatToStr(RVLPr(TekRasxR, 0));
     end;
   end;
end;
// TFontStyle = (fsBold, fsItalic, fsUnderline, fsStrikeOut);
procedure TTShemLoader.SetLabelUnderline(var tempLabel: TLabel);
var fT1 : boolean ;
begin
   fT1 := false;
   if fsBold in tempLabel.Font.Style then
     fT1 := true;
   if fT1 then
     tempLabel.Font.Style := [fsBold, fsStrikeOut]
   else
     tempLabel.Font.Style := [fsStrikeOut]
end;

procedure TTShemLoader.UnsetLabelUnderline(var tempLabel: TLabel);
var fT1 : boolean;
begin
   fT1 := false;
   if fsBold in tempLabel.Font.Style then
     fT1 := true;
   if fT1 then
     tempLabel.Font.Style := [fsBold]
   else
     tempLabel.Font.Style := [];
end;

function TTShemLoader.CheckDate(CMDID : integer; Time : TDateTime):boolean;
var Delta : TDateTime;
begin
   case CMDID of
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
     QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM,
     QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM,
     QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM : Delta := 1;
     QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
     QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM,
     QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
     QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM : Delta := 31;
     else Delta := EncodeTime(0, 30, 0, 0);
   end;
   if abs(Now - Time) > Delta then
     Result := false
   else
     Result := true;
end;

destructor TTShemLoader.Destroy;
begin
  if SchemPointers <> nil then FreeAndNil(SchemPointers);
  if m_nEVL <> nil then FreeAndNil(m_nEVL);
  inherited;
end;

end.
