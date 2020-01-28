unit knsl3viewcdata;
interface
uses
Windows, Classes, forms, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,
utldatabase,knsl3dataframe,knsl3EventBox,{knsl3FrmMonitor,}knsl2graphframe,Grids, BaseGrid, AdvGrid,graphics,knsl5events,knsl5config,knsl3report,AdvOfficePager,

   AdvStyleIF,
   knsl3VectorFrame,
   knsl2ControlFrame;
type
     SQWCLSS = packed record
      Count : Integer;
      Items : array of Integer;
     End;
     SL3FRM = packed record
      m_swWID   : Integer;
      m_swVMID  : Integer;
      m_swCMDID : Integer;
      m_strType : String[20];
     end;
     PSL3FRM =^ SL3FRM;
     SL3FRMS = packed record
      Count     : Integer;
      Items     : array[0..100] of SL3FRM;
     end;
     SL3VMID = packed record
      m_swVMID  : Integer;
     end;
     PSL3VMID =^ SL3VMID;
     SL3VMIDS = packed record
      Count     : Integer;
      Items     : array[0..100] of SL3VMID;
     end;
     CCDataView = class
     private
      FForm       : TForm;
      m_nCFrame   : TDataFrame;
      m_nEvFrame  : TTL5Events;
      m_nVectorFrame : TVectorFrame;
      m_nControlFrame : TControlFrame;
//      m_nMonFRM   : TTFrmMonitor;
      m_nMaxHView : Integer;
      m_nMaxVView : Integer;
      nVIndex     : Integer;
      nHIndex     : Integer;
      m_strClassName : String;
      FPage       : TAdvOfficePager;
      FsgCGrid    : PTAdvStringGrid;
      FsgVGrid    : PTAdvStringGrid;
      m_pF        : SL3FRMS;
      m_nFCount   : Integer;
      m_nVM       : SL3VMIDS;
      m_pQSMD     : SQWCLSS;
      m_nCMD      : array[0..3] of Integer;
     public
      constructor Create(pForm:TForm);
      destructor Destroy;override;
     private
      procedure ViewData(nIndex:Integer);
      procedure LoadSettings;
      procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
      procedure FindWindowVMID(nVMID:Integer);
      function  PrepareFullCommand(nCMD:Integer):Boolean;
      procedure AddOX(nCMD,nCMD1:Integer;var nHIndex:Integer);
      procedure AddOY(nOCMD,nCMD,nCMD1:Integer;var nVIndex:Integer);
      procedure SortWindowVMID;
      procedure SortWindowCMDID(nVMID:Integer);
      procedure FindAllVMID;
      function  AddFBuffer(nVMID:Integer):Boolean;
     public
      procedure OnGetCellColorDV(Sender: TObject; ARow, ACol: Integer;
                AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
      procedure Init;
      procedure OnFormResize(Sender: TObject);
      procedure CreateNew(pDS:PCGDataSource);
      procedure CreateEvNew(pDS:PCGDataSource);
//      procedure CreateMonNew(pDS:PCGDataSource);
      procedure CreateVectorNew(pDS:PCGDataSource);
      procedure CreateControlNew(pDS:PCGDataSource);

            
      procedure View(nIndex:Integer);
      procedure ViewMetaData(nIndex:Integer);
      procedure CreateView(pDS:PCGDataSource);
      function  getView(pDS:PCGDataSource):TForm;
      procedure PlacedView(pDS:PCGDataSource);
      procedure ReplacedView(nW,nH:Integer);
      procedure ReplacedViewClass(mH,mV,nW,nH:Integer;strName:String;var nHIndex,nVIndex:Integer);
      procedure ReplacedViewClassEx(mH,mV,nW,nH:Integer;strName:String;var nHIndex,nVIndex:Integer);
      function  ReplacedWindowVMID(mH,mV,nW,nH:Integer;nVMID,nCMDID:Integer;strName:String;var nHIndex,nVIndex:Integer):Boolean;
      procedure AddPlaceIndex(mH:Integer;var nHIndex,nVIndex:Integer);
      procedure AddPlaceIndexEx(nCMD,nOCMD,mH:Integer;var nHIndex,nVIndex:Integer);
      function  FindView(nIndex:Integer):Integer;
      function  FindEvView(nIndex:Integer):Integer;
      function  FindVectorView(nIndex:Integer):Integer;
      function  FindControlView(nIndex:Integer):Integer; // Управление
      function  FindMonitorView(nIndex:Integer):Integer;
      procedure Update(PKey:Integer);
      procedure UpdateMeta(PKey:Integer);
      procedure UpdateAll;
      procedure ViewTarifData(nIndex:Integer);
      procedure UpdateTarifData(PKey:Integer);
      procedure UpdateVectorData(PKey:Integer);
      procedure RefreshAll;
      function  GetActiveCaption:String;
     public
      property PForm    : TForm           read FForm    write FForm;
      property PPage    : TAdvOfficePager    read FPage    write FPage;
      property PsgCGrid : PTAdvStringGrid read FsgCGrid write FsgCGrid;
      property PsgVGrid : PTAdvStringGrid read FsgVGrid write FsgVGrid;
     End;
implementation
constructor CCDataView.Create(pForm:TForm);
Begin
     FForm := pForm;
     m_nMaxHView := 2;
     m_nMaxVView := 2;
     nHIndex     := 0;
     nVIndex     := 0;
End;
destructor CCDataView.Destroy;
Begin
End;
procedure CCDataView.Init;
Begin
     LoadSettings;
End;
{
L3CURRENTDATA = packed record
     m_swID    : Word;
     m_swVMID  : Word;
     m_swTID   : Word;
     m_swCMDID : Word;
     m_swSID   : Word;
     m_sTime   : TDateTime;
     m_sfValue : Single;
    end;
}
procedure CCDataView.LoadSettings;
Begin
     FsgCGrid.ColCount    := 8;
     FsgCGrid.RowCount    := 50;
     FsgCGrid.Cells[0,0]  := '№/T';
     FsgCGrid.Cells[1,0]  := 'Дата';
     FsgCGrid.Cells[2,0]  := 'Время';
     FsgCGrid.Cells[3,0]  := 'Параметр';
     FsgCGrid.Cells[4,0]  := 'Сокращение';
     FsgCGrid.Cells[5,0]  := 'Тариф';
     FsgCGrid.Cells[6,0]  := 'Показание';
     FsgCGrid.Cells[7,0]  := 'Единица измерения';
     FsgCGrid.ColWidths[0]:= 35;
     FsgCGrid.ColWidths[1]:= 120;
     FsgCGrid.ColWidths[2]:= 120;
    // SetHigthGrid(FsgCGrid^,19);

    FsgVGrid.Color       := KNS_NCOLOR;

    FsgVGrid.ColCount    := 23;
    FsgVGrid.FixedCols   := 1;
    FsgVGrid.RowCount    := 50;
    FsgVGrid.FixedRows   := 1;

    FsgVGrid.Cells[0,0]  := '№';
    FsgVGrid.Cells[1,0]  := 'Дата';
    FsgVGrid.Cells[2,0]  := 'Время';

    FsgVGrid.Cells[3,0]  := 'Us';
    FsgVGrid.Cells[4,0]  := 'Ua';
    FsgVGrid.Cells[5,0]  := 'Ub';
    FsgVGrid.Cells[6,0]  := 'Uc';

    FsgVGrid.Cells[7,0]  := 'Is';
    FsgVGrid.Cells[8,0]  := 'Ia';
    FsgVGrid.Cells[9,0]  := 'Ib';
    FsgVGrid.Cells[10,0]  := 'Ic';

    FsgVGrid.Cells[11,0]  := 'Cos(Фa)';
    FsgVGrid.Cells[12,0]  := 'Cos(Фb)';
    FsgVGrid.Cells[13,0]  := 'Cos(Фc)';

    FsgVGrid.Cells[14,0]  := 'Ps';
    FsgVGrid.Cells[15,0]  := 'Pa';
    FsgVGrid.Cells[16,0]  := 'Pb';
    FsgVGrid.Cells[17,0]  := 'Pc';

    FsgVGrid.Cells[18,0]  := 'Qs';
    FsgVGrid.Cells[19,0]  := 'Qa';
    FsgVGrid.Cells[20,0]  := 'Qb';
    FsgVGrid.Cells[21,0]  := 'Qc';

    FsgVGrid.Cells[22,0]  := 'F';

    FsgVGrid.ColWidths[0] := 35;
    FsgVGrid.ColWidths[1] := 80;
    FsgVGrid.ColWidths[2] := 80;
End;
procedure CCDataView.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
     i : Integer;
Begin
    // for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure CCDataView.OnFormResize(Sender: TObject);
Var
     i : Integer;
Begin
     for i:=3 to FsgCGrid.ColCount-1  do FsgCGrid.ColWidths[i]  := trunc((FsgCGrid.Width-240-2*FsgCGrid.ColWidths[0])/(FsgCGrid.ColCount-1-2));
     for i:=3 to FsgVGrid.ColCount-1  do FsgVGrid.ColWidths[i]  := trunc((FsgVGrid.Width-160-2*FsgVGrid.ColWidths[0])/(FsgVGrid.ColCount-1-2));
End;
function CCDataView.getView(pDS:PCGDataSource):TForm;
Begin
     Result := nil;
     pDS.nViewID := FindView(pDS.trTRI.PVID);
     if pDS.nViewID<>-1 then
     Begin
      FForm.MDIChildren[pDS.nViewID].Show;
      Result := FForm.MDIChildren[pDS.nViewID];
     End;
End;
procedure CCDataView.CreateView(pDS:PCGDataSource);
Begin
     m_strClassName := pDS.strClassName;
     if m_strClassName='TDataFrame' then
     Begin
      pDS.nViewID    := FindView(pDS.trTRI.PVID);
      if pDS.nViewID =-1 then CreateNew(pDS);
      if pDS.nViewID<>-1 then View(pDS.nViewID);
     End
     else if m_strClassName='TTL5Events' then
     Begin
      pDS.nViewID    := FindEvView(pDS.trTRI.PVID);
      if pDS.nViewID =-1 then CreateEvNew(pDS);
      if pDS.nViewID<>-1 then View(pDS.nViewID);
     End
     else if m_strClassName='TVectorFrame' then
     Begin
      pDS.nViewID    := FindVectorView(pDS.trTRI.PVID);
      if pDS.nViewID =-1 then CreateVectorNew(pDS);
      if pDS.nViewID<>-1 then View(pDS.nViewID);
     End
     else if m_strClassName='TControlFrame' then
     Begin
      pDS.nViewID    := FindControlView(pDS.trTRI.PVID);
      if pDS.nViewID =-1 then CreateControlNew(pDS);
      if pDS.nViewID<>-1 then View(pDS.nViewID);
     End;
{     else if m_strClassName='TTFrmMonitor' then
     Begin
      pDS.nViewID    := FindMonitorView(pDS.trTRI.PVID);
      if pDS.nViewID =-1 then CreateMonNew(pDS);
      if pDS.nViewID<>-1 then View(pDS.nViewID);
     End;   }
End;
procedure CCDataView.CreateNew(pDS:PCGDataSource);
Begin
     m_nCFrame          := TDataFrame.Create(pDS.pOwner);
     m_nCFrame.DataStyler.Style := tsOffice2007Obsidian;
     m_nCFrame.PPage    := PPage;
     m_nCFrame.PsgCGrid := FsgCGrid;
     m_nCFrame.PABOID   := pDS.trTRI.PAID;
     m_nCFrame.PIndex   := pDS.trTRI.PVID;
     m_nCFrame.PMID     := pDS.trTRI.PMID;
     m_nCFrame.PPRID    := pDS.trTRI.PPID;
     m_nCFrame.PTID     := pDS.trTRI.PTID;
     m_nCFrame.PSVStatus:= pDS.trTRI.PSID;
     m_nCFrame.PCLStatus:= pDS.trTRI.PDID;
     m_nCFrame.Caption  := pDS.strCaption;
     m_nCFrame.ViewMetaData;
     m_nCFrame.ViewData;
End;
procedure CCDataView.CreateEvNew(pDS:PCGDataSource);
Begin
     m_nEvFrame          := TTL5Events.Create(pDS.pOwner);
     m_nEvFrame.PABOID   := pDS.trTRI.PAID;
     m_nEvFrame.PIndex   := pDS.trTRI.PVID;
     m_nEvFrame.PMID     := pDS.trTRI.PMID;
     m_nEvFrame.PPRID    := pDS.trTRI.PPID;
     m_nEvFrame.PTID     := pDS.trTRI.PTID;
     m_nEvFrame.Caption  := pDS.strCaption;
     m_nEvFrame.ViewData;
End;
procedure CCDataView.CreateVectorNew(pDS:PCGDataSource);
Begin
     m_nVectorFrame        := TVectorFrame.Create(pDS.pOwner);
     m_nVectorFrame.PVMID  := pDS.trTRI.PVID;
     m_nVectorFrame.PMID   := pDS.trTRI.PMID;
     m_nVectorFrame.PPRID  := pDS.trTRI.PPID;
     m_nVectorFrame.PABOID := pDS.trTRI.PAID;
     m_nVectorFrame.Caption:= pDS.strCaption;
     m_nVectorFrame.PTID   := pDS.trTRI.PTID;
     m_nVectorFrame.PsgVGrid := PsgVGrid;
     m_nVectorFrame.PPage    := PPage;
End;
{procedure CCDataView.CreateMonNew(pDS:PCGDataSource);
Begin
     m_nMonFRM          := TTFrmMonitor.Create(pDS.pOwner);
     m_nMonFRM.PABOID   := pDS.trTRI.PAID;
     m_nMonFRM.PVMID    := pDS.trTRI.PVID;
     m_nMonFRM.PMID     := pDS.trTRI.PMID;
     m_nMonFRM.PPRID    := pDS.trTRI.PPID;
     m_nMonFRM.Caption  := pDS.strCaption;
     m_nMonFRM.PsgVGrid := PsgVGrid;
     m_nMonFRM.PPage    := PPage;
     m_nMonFRM.Init;
     //m_nMonFRM.ViewData;
End;     }
procedure CCDataView.CreateControlNew(pDS:PCGDataSource);
Begin
     m_nControlFrame         := TControlFrame.Create(pDS.pOwner);
     m_nControlFrame.m_VMID  := pDS.trTRI.PVID;
     m_nControlFrame.m_MID   := pDS.trTRI.PMID;
     m_nControlFrame.m_PRID  := pDS.trTRI.PPID;
     m_nControlFrame.m_ABOID := pDS.trTRI.PAID;
     m_nControlFrame.Caption := pDS.strCaption;
     m_nControlFrame.m_TID   := pDS.trTRI.PTIM;
     m_nControlFrame.InitModule();
End;
procedure CCDataView.View(nIndex:Integer);
Begin
     if nIndex<>-1 then
     Begin
      ViewData(nIndex);
      FForm.MDIChildren[nIndex].Show();
     End;
End;
procedure CCDataView.ViewData(nIndex:Integer);
Begin
     if nIndex<>-1 then
     begin
      if FForm.MDIChildren[nIndex].ClassName='TDataFrame' then
      (FForm.MDIChildren[nIndex] as TDataFrame).ViewData;
      if FForm.MDIChildren[nIndex].ClassName='TTL5Events' then
      (FForm.MDIChildren[nIndex] as TTL5Events).ViewData;
      //if FForm.MDIChildren[nIndex].ClassName='TTFrmMonitor' then
      //(FForm.MDIChildren[nIndex] as TTFrmMonitor).ViewData;
      //if FForm.MDIChildren[nIndex].ClassName='TVectorView' then
      ////(FForm.MDIChildren[nIndex] as TVectorFrame).ViewData();
      if FForm.MDIChildren[nIndex].ClassName='TControlFrame' then
      (FForm.MDIChildren[nIndex] as TControlFrame).InitModule();
   end;
End;
procedure CCDataView.ViewMetaData(nIndex:Integer);
Begin
     if nIndex<>-1 then
     if FForm.MDIChildren[nIndex].ClassName='TDataFrame' then
     (FForm.MDIChildren[nIndex] as TDataFrame).ViewMetaData;
End;
procedure CCDataView.ViewTarifData(nIndex:Integer);
Begin
     if nIndex<>-1 then
     if FForm.MDIChildren[nIndex].ClassName='TDataFrame' then
     (FForm.MDIChildren[nIndex] as TDataFrame).ViewTarifData;
End;
procedure CCDataView.UpdateTarifData(PKey:Integer);
Begin
     ViewTarifData(FindView(PKey));
End;
procedure CCDataView.UpdateVectorData(PKey:Integer);
var
   nIndex:Integer;
Begin
   nIndex := FindView(PKey);
   if nIndex<>-1 then
      if FForm.MDIChildren[nIndex].ClassName='TVectorFrame' then
         (FForm.MDIChildren[nIndex] as TVectorFrame).ViewData();
End;
procedure CCDataView.Update(PKey:Integer);
Begin
     ViewData(FindView(PKey));
End;
procedure CCDataView.UpdateAll;
Var
     i,res : Integer;
Begin
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[i].ClassName='TDataFrame' then
      (FForm.MDIChildren[i] as TDataFrame).ViewData;
      if FForm.MDIChildren[i].ClassName='TTL5Events' then
      (FForm.MDIChildren[i] as TTL5Events).ViewData;
     End;
End;
procedure CCDataView.RefreshAll;
Var
     i : Integer;
Begin
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
     if FForm.MDIChildren[i].ClassName='TDataFrame' then
     (FForm.MDIChildren[i] as TDataFrame).RefreshHigthGrid(nSizeFont+17);
     if FForm.MDIChildren[i].ClassName='TTRepPower' then
     (FForm.MDIChildren[i] as TTRepPower).RefreshHigthGrid(nSizeFont+17);
     End;
End;
procedure CCDataView.UpdateMeta(PKey:Integer);
Begin
     ViewMetaData(FindView(PKey));
End;
procedure CCDataView.PlacedView(pDS:PCGDataSource);
Begin
     m_nCFrame.Width  := round(pDS.nWidth/m_nMaxHView);
     m_nCFrame.Height := round(pDS.nHeight/m_nMaxVView);
     m_nCFrame.Left   := m_nCFrame.Width*nHIndex;
     m_nCFrame.Top    := m_nCFrame.Height*nVIndex;
     nHIndex  := nHIndex + 1;
     if (FForm.MDIChildCount mod m_nMaxHView)=0 then
     Begin
      nHIndex := 0;
      nVIndex := nVIndex + 1;
     End;
End;
function CCDataView.FindView(nIndex:Integer):Integer;
Var
     i,res : Integer;
     cl : String;
Begin
     res := -1;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[i].ClassName='TDataFrame' then
      if (FForm.MDIChildren[i] as TDataFrame).PIndex = nIndex then
       Begin
        res := i;
        break;
       End;
     End;
     Result := res;
End;
function CCDataView.FindEvView(nIndex:Integer):Integer;
Var
     i,res : Integer;
     cl : String;
Begin
     res := -1;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[i].ClassName='TTL5Events' then
      if (FForm.MDIChildren[i] as TTL5Events).PIndex = nIndex then
       Begin
        res := i;
        break;
       End;
     End;
     Result := res;
End;
function CCDataView.FindVectorView(nIndex:Integer):Integer;
Var
     i,res : Integer;
     cl : String;
Begin
     res := -1;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[i].ClassName='TVectorFrame' then
      if (FForm.MDIChildren[i] as TVectorFrame).PVMID = nIndex then
       Begin
        res := i;
        break;
       End;
     End;
     Result := res;
End;
function CCDataView.FindControlView(nIndex:Integer):Integer;
Var
     i,res : Integer;
     cl : String;
Begin
     res := -1;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[i].ClassName='TControlFrame' then
      if (FForm.MDIChildren[i] as TControlFrame).m_VMID = nIndex then
       Begin
        res := i;
        break;
       End;
     End;
     Result := res;
End;
function CCDataView.FindMonitorView(nIndex:Integer):Integer;
Var
     i,res : Integer;
     cl : String;
Begin
    res := -1;
    { for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[i].ClassName='TTFrmMonitor' then
      if (FForm.MDIChildren[i] as TTFrmMonitor).PVMID = nIndex then
       Begin
        res := i;
        break;
       End;
     End;  }
     Result := res;
End;
procedure CCDataView.ReplacedView(nW,nH:Integer);
Begin
     try
     nVIndex := 0;
     nHIndex := 0;
     //FindWindowVMID;
     ReplacedViewClass(1,2,nW,nH,'TTFrmMonitor',nHIndex,nVIndex); nHIndex:=0;
     ReplacedViewClass(m_nMaxHView,m_nMaxVView,nW,nH,'TTRepPower',nHIndex,nVIndex);if nHIndex=1 then Begin nHIndex:=0;nVIndex:=nVIndex+1;End;

     ReplacedViewClassEx(m_nMaxHView,m_nMaxVView,nW,nH,'TGraphFrame',nHIndex,nVIndex);

     ReplacedViewClass(m_nMaxHView,m_nMaxVView,nW,nH,'TDataFrame',nHIndex,nVIndex);
     ReplacedViewClass(m_nMaxHView,m_nMaxVView,nW,nH,'TVectorFrame',nHIndex,nVIndex);
     ReplacedViewClass(m_nMaxHView,m_nMaxVView,nW,nH,'TTL5Events',nHIndex,nVIndex);
     ReplacedViewClass(m_nMaxHView,m_nMaxVView,nW,nH,'TControlFrame',nHIndex,nVIndex);
     except
     end;
End;
procedure CCDataView.ReplacedViewClass(mH,mV,nW,nH:Integer;strName:String;var nHIndex,nVIndex:Integer);
Var
     ID : Integer;
Begin
     for ID:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[ID].ClassName=strName then
      Begin
       FForm.MDIChildren[ID].WindowState := wsNormal;
       FForm.MDIChildren[ID].Width  := round(nW/mH);
       FForm.MDIChildren[ID].Height := round(nH/mV);
       FForm.MDIChildren[ID].Left   := FForm.MDIChildren[ID].Width*nHIndex;
       FForm.MDIChildren[ID].Top    := FForm.MDIChildren[ID].Height*nVIndex;
       AddPlaceIndex(mH,nHIndex,nVIndex);
      End;
     End;
End;
function CCDataView.ReplacedWindowVMID(mH,mV,nW,nH:Integer;nVMID,nCMDID:Integer;strName:String;var nHIndex,nVIndex:Integer):Boolean;
Var
     i : Integer;
Begin
     Result := False;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if (FForm.MDIChildren[i].ClassName=strName) then
      Begin
       if ((FForm.MDIChildren[i] as TGraphFrame).PMasterIndex=nVMID)and((FForm.MDIChildren[i] as TGraphFrame).PIndex=nCMDID) then
       Begin
        FForm.MDIChildren[i].WindowState := wsNormal;
        FForm.MDIChildren[i].Width  := round(nW/mH);
        FForm.MDIChildren[i].Height := round(nH/mV);
        FForm.MDIChildren[i].Left   := FForm.MDIChildren[i].Width*nHIndex;
        FForm.MDIChildren[i].Top    := FForm.MDIChildren[i].Height*nVIndex;
        //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'VIEW: '+'nHIndex:'+IntToStr(nHIndex)+'nVIndex:'+IntToStr(nVIndex)+'LEFT:'+IntToStr(FForm.MDIChildren[i].Left)+' TOP:'+IntToStr(FForm.MDIChildren[i].Top)+' Width:'+IntToStr(FForm.MDIChildren[i].Width)+' Height:'+IntToStr(FForm.MDIChildren[i].Height));//AAV
        //AddPlaceIndex(mH,nHIndex,nVIndex);
        Result := True;
        exit;
       End;
      End;
     End;
     //AddPlaceIndex(mH,nHIndex,nVIndex);
End;
procedure CCDataView.AddPlaceIndex(mH:Integer;var nHIndex,nVIndex:Integer);
Begin
     nHIndex := nHIndex + 1;
     if ((nHIndex) mod mH)=0 then
     Begin
      nHIndex := 0;
      nVIndex := nVIndex + 1;
     End;
End;

procedure CCDataView.AddPlaceIndexEx(nCMD,nOCMD,mH:Integer;var nHIndex,nVIndex:Integer);
Begin
     AddOY(nOCMD,nCMD,QRY_SRES_ENR_EP,nVIndex);
End;
procedure CCDataView.ReplacedViewClassEx(mH,mV,nW,nH:Integer;strName:String;var nHIndex,nVIndex:Integer);
Var
     i,j,k,nCMD,nOCMD,nOCMD1 : Integer;
     res,res1,res2 : Boolean;
Begin
     SetLength(m_pQSMD.Items,MAX_VMETER);
     FindAllVMID;
     j:=0;
     for i:=0 to m_pQSMD.Count-1 do
     Begin
      FindWindowVMID(m_pQSMD.Items[i]);
      SortWindowCMDID(m_pQSMD.Items[i]);
      nOCMD := -1;
      for j:=0 to m_pF.Count-1 do
      Begin
       nCMD := m_pF.Items[j].m_swCMDID;
       res := PrepareFullCommand(nCMD);
       res1:= PrepareFullCommand(nOCMD);
       res2:= PrepareFullCommand(nOCMD1);
       if res=False then
       Begin
        if res1=True then  Begin nHIndex:=0;nVIndex:=nVIndex+1; End;
        if (nOCMD1=QRY_SRES_ENR_RP) then Begin nOCMD1:=-1;nHIndex:=0;nVIndex:=nVIndex+1;End;
        nOCMD := nCMD;
        if ReplacedWindowVMID(mH,mV,nW,nH,m_pQSMD.Items[i],m_pF.Items[j].m_swCMDID,strName,nHIndex,nVIndex)=True then
        AddPlaceIndex(mH,nHIndex,nVIndex);
       End else
       if res=True then
       Begin
        if (res1=False)and(nOCMD<>-1) then Begin if(nHIndex=1)then nVIndex:=nVIndex+1;nHIndex:=0;End;
        //if (res1=False)and(nOCMD=-1)then Begin nHIndex:=0;nVIndex:=nVIndex+1;End;
        if (res1=False)and(nOCMD=-1)and(nOCMD1=QRY_SRES_ENR_RP) then  Begin nOCMD1:=-1;nHIndex:=0;nVIndex:=nVIndex+1;End;
        //AddOX(nCMD,QRY_SRES_ENR_EP,nHIndex);
        if (nCMD=QRY_SRES_ENR_EP)or(nCMD=QRY_SRES_ENR_EM)then nHIndex := 0 else
        if (nCMD=QRY_SRES_ENR_RP)or(nCMD=QRY_SRES_ENR_RM)then nHIndex := 1;

        if ((nOCMD=QRY_SRES_ENR_EP)or(nOCMD=QRY_SRES_ENR_RP))and
           ((nCMD=QRY_SRES_ENR_EM)or(nCMD=QRY_SRES_ENR_RM))then  nVIndex:=nVIndex+1;

        if ((nOCMD=-1))and
           ((nCMD=QRY_SRES_ENR_EM)or(nCMD=QRY_SRES_ENR_RM))then  nVIndex:=nVIndex+1;

        if ((nOCMD=QRY_SRES_ENR_EM))and((nCMD=QRY_SRES_ENR_RP))then  nVIndex:=nVIndex-1;

        ReplacedWindowVMID(mH,mV,nW,nH,m_pQSMD.Items[i],m_pF.Items[j].m_swCMDID,strName,nHIndex,nVIndex);
        nOCMD := m_pF.Items[j].m_swCMDID;
        nOCMD1:= nOCMD;
       End;
      End;
      if res=True then nVIndex := nVIndex + 1;
     End;
     nHIndex:=0;
     SetLength(m_pQSMD.Items,0);
End;

function CCDataView.PrepareFullCommand(nCMD:Integer):Boolean;
var
      i : Integer;
Begin
      Result := False;
      if (nCMD>=QRY_SRES_ENR_EP)and(nCMD<=QRY_SRES_ENR_RM)         then Begin Result := True;End else
End;
procedure CCDataView.AddOX(nCMD,nCMD1:Integer;var nHIndex:Integer);
Begin
      if (nCMD=nCMD1)or(nCMD=nCMD1+2)then nHIndex := 0 else if (nCMD=nCMD1+1)or(nCMD=nCMD1+3)then nHIndex := 1;
End;
procedure CCDataView.AddOY(nOCMD,nCMD,nCMD1:Integer;var nVIndex:Integer);
Begin
      if ((nOCMD=nCMD1)or(nOCMD=nCMD1+1))and((nCMD=nCMD1+2)or(nCMD=nCMD1+3)) then  nVIndex:=nVIndex+1 else
End;
procedure CCDataView.FindWindowVMID(nVMID:Integer);
Var
     i,j : Integer;
Begin
     j:=0;m_pF.Count := 0;
     if FForm.MDIChildCount>=300 then exit;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if (FForm.MDIChildren[i].ClassName='TGraphFrame') then
      Begin
       if ((FForm.MDIChildren[i] as TGraphFrame).PMasterIndex=nVMID) then
       Begin
        m_pF.Items[j].m_swWID   := i;
        m_pF.Items[j].m_strType := FForm.MDIChildren[i].ClassName;
        m_pF.Items[j].m_swVMID  := (FForm.MDIChildren[i] as TGraphFrame).PMasterIndex;
        m_pF.Items[j].m_swCMDID := (FForm.MDIChildren[i] as TGraphFrame).PIndex;
        //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'PRESORT: ID:'+IntToStr(j)+' WID:'+IntToStr(m_pF.Items[j].m_swWID)+' VMID:'+IntToStr(m_pF.Items[j].m_swVMID)+' CMDID:'+IntToStr(m_pF.Items[j].m_swCMDID));//AAV
        j := j + 1;
       End;
      End;
     End;
     m_pF.Count := j;
End;
procedure CCDataView.SortWindowVMID;
Var
     i,j  : Integer;
     nTmp : Integer;
Begin
     for i:=0 to m_pQSMD.Count-1 do
     for j:=1 to m_pQSMD.Count-1-i do
     if m_pQSMD.Items[j-1]>m_pQSMD.Items[j] then
     Begin
      nTmp:= m_pQSMD.Items[j-1];
      m_pQSMD.Items[j-1] := m_pQSMD.Items[j];
      m_pQSMD.Items[j] := nTmp;
     End;
     //for i:=0 to m_pF.Count-1  do
     //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'SORT VM '+' ID:'+IntToStr(i)+' WID:'+IntToStr(m_pF.Items[i].m_swWID)+' VMID:'+IntToStr(m_pF.Items[i].m_swVMID)+' CMDID:'+IntToStr(m_pF.Items[i].m_swCMDID));//AAV
End;
procedure CCDataView.FindAllVMID;
Var
     i : Integer;
Begin
     m_pQSMD.Count := 0;
     for i:=0 to MAX_VMETER-1 do m_pQSMD.Items[i] := -1;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if (FForm.MDIChildren[i].ClassName='TGraphFrame') then
      AddFBuffer((FForm.MDIChildren[i] as TGraphFrame).PMasterIndex);
     End;
     SortWindowVMID;
End;
function  CCDataView.AddFBuffer(nVMID:Integer):Boolean;
Var
     i : Integer;
Begin
     Result := False;
     for i:=0 to MAX_VMETER do
     Begin
      if (m_pQSMD.Items[i]=nVMID) then exit;
      if (m_pQSMD.Items[i]=-1) then
      Begin
       m_pQSMD.Items[i]:=nVMID;
       m_pQSMD.Count := m_pQSMD.Count + 1;
       Result := True;
       exit;
      End;
     End;
End;
procedure CCDataView.SortWindowCMDID(nVMID:Integer);
Var
     i,j  : Integer;
     nTmp : SL3FRM;
Begin
     for i:=0 to m_pF.Count-1 do
     for j:=1 to m_pF.Count-1-i do
     if (m_pF.Items[j-1].m_swVMID=nVMID) then
     Begin
      if m_pF.Items[j-1].m_swCMDID>m_pF.Items[j].m_swCMDID then
      Begin
       Move( m_pF.Items[j-1].m_swWID,nTmp,sizeof(SL3FRM));
       Move(m_pF.Items[j].m_swWID,m_pF.Items[j-1].m_swWID,sizeof(SL3FRM));
       Move(nTmp,m_pF.Items[j].m_swWID,sizeof(SL3FRM));
      End;
     End;
End;
function  CCDataView.GetActiveCaption:String;
Var
     i     : Integer;
     mForm : TForm;
     strCaption : String;
Begin
     mForm      := FForm.ActiveMDIChild;
     strCaption := mForm.Caption;
     Result     := strCaption;
End;
procedure CCDataView.OnGetCellColorDV(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    with (Sender AS TAdvStringGrid)  do Begin
    if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and
     (not(gdSelected in AState) or (gdFocused in AState)) then
    begin
    // if (ACol<>0)and(ARow<>0) then ABrush.Color := clTeal;
    end;

    if (ARow=0)or(ACol=0) then
    Begin
     AFont.Size  := 8;
     AFont.Style := [fsBold];
     AFont.Color := clBlack;
    End;
    if (ARow<>0) and (ACol<>0)then
     Begin
      if ACol<>0 then
      Begin
       AFont.Color :=  m_blGridDataFontColor;//clAqua;
       AFont.Size  :=  m_blGridDataFontSize;
       AFont.Name  :=  m_blGridDataFontName;
       if (ACol=1) or (ACol=2) or (ACol=7) then AFont.Color := clBlack;
       if (ACol>=3) and (ACol<=6) then AFont.Color := clBlack;
      End;
     End;
    End;
end;
end.

