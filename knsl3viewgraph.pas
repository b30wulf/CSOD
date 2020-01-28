unit knsl3viewgraph;
interface
uses
Windows, Classes, forms, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,
knsl2graphframe,Grids, BaseGrid, AdvGrid,graphics,knsl5config,AdvOfficePager;
type
     CGraphView = class
     private
      FForm       : TForm;
      m_nCFrame   : TGraphFrame;
      m_nMaxHView : Integer;
      m_nMaxVView : Integer;
      nVIndex     : Integer;
      nHIndex     : Integer;
      FPage       : TAdvOfficePager;
      FsgPGrid    : PTAdvStringGrid;
      FsgEGrid    : PTAdvStringGrid;
     public
      constructor Create(pForm:TForm);
      destructor Destroy;override;
      procedure  Init;
     private
      procedure ViewData(nIndex:Integer);
      procedure LoadSettings;

     public
      procedure OnGetCellColorGV(Sender: TObject; ARow, ACol: Integer;
                AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
      procedure OnGetCellColorGV4(Sender: TObject; ARow, ACol: Integer;
                AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
      procedure OnFormResize(Sender: TObject);
      function  CreateNew(pDS:PCGDataSource):TForm;
      function  View(nIndex:Integer):TForm;
      function  CreateView(pDS:PCGDataSource):TForm;
      function  getView(pDS:PCGDataSource):TForm;
      procedure PlacedView(pDS:PCGDataSource);
      procedure ReplacedView(nW,nH:Integer);
      function  FindView(FKey,PKey:Integer):Integer;
      procedure Update(FKey,PKey:Integer);
      procedure UpdateAll;
      procedure UpdateSlice(FKey,PKey:Integer);
      procedure ViewSlice(nIndex:Integer);
      procedure UpdateArchive(FKey,PKey:Integer);
      procedure ViewArchive(nIndex:Integer);
      function  GetActiveCaption:String;
     public
      property PForm    : TForm            read FForm     write FForm;
      property PPage    : TAdvOfficePager     read FPage     write FPage;
      property PsgPGrid : PTAdvStringGrid  read FsgPGrid write FsgPGrid;
      property PsgEGrid : PTAdvStringGrid  read FsgEGrid write FsgEGrid;
     End;
implementation
constructor CGraphView.Create(pForm:TForm);
Begin
     FForm := pForm;
     m_nMaxHView := 2;
     m_nMaxVView := 2;
     nHIndex     := 0;
     nVIndex     := 0;
End;
destructor CGraphView.Destroy;
Begin
End;
procedure CGraphView.Init;
Begin
     LoadSettings;
End;
procedure CGraphView.LoadSettings;
Begin
     FsgPGrid.Color       := KNS_NCOLOR;                      // BO 29/10/18  здесь и далее настраиваются наименования и ширина полей
     FsgPGrid.ColCount    := 12;                              // для вывода данных о тарифах
     FsgPGrid.RowCount    := 50;
     FsgPGrid.Cells[0,0]  := '№/T';
     FsgPGrid.Cells[1,0]  := 'Дата';
     FsgPGrid.Cells[2,0]  := 'Время';
     FsgPGrid.Cells[3,0]  := 'Параметр';
//     FsgPGrid.Cells[4,0]  := 'Сокращение';
     FsgPGrid.Cells[4,0]  := 'Тариф 0';
     FsgPGrid.Cells[5,0]  := 'Тариф 1';
     FsgPGrid.Cells[6,0]  := 'Тариф 2';
     FsgPGrid.Cells[7,0]  := 'Тариф 3';
     FsgPGrid.Cells[8,0]  := 'Тариф 4';
     FsgPGrid.Cells[9,0]  := 'Единица измерения';
     FsgPGrid.Cells[10,0]  := 'Достоверность';

     FsgPGrid.ColWidths[0]:= 35;
     FsgPGrid.ColWidths[1]:= 80;
     FsgPGrid.ColWidths[2]:= 150;
     FsgPGrid.ColWidths[3]:= 80;
     FsgPGrid.ColWidths[4]:= 80;
     FsgPGrid.ColWidths[5]:= 80;
     FsgPGrid.ColWidths[6]:= 80;
     FsgPGrid.ColWidths[7]:= 80;
     FsgPGrid.ColWidths[8]:= 80;
     FsgPGrid.ColWidths[9]:= 80;
     FsgPGrid.ColWidths[10]:= 80;
     FsgPGrid.ColWidths[11]:= 80;


     FsgEGrid.Color       := KNS_NCOLOR;
     FsgEGrid.ColCount    := 10;
     FsgEGrid.RowCount    := 40;
     FsgEGrid.Cells[0,0]  := '№/T';
     FsgEGrid.Cells[1,0]  := 'Дата';
     FsgEGrid.Cells[2,0]  := 'Время';
     FsgEGrid.Cells[3,0]  := 'Параметр';
     FsgEGrid.Cells[4,0]  := 'Показание Wp+';
     FsgEGrid.Cells[5,0]  := 'Показание Wp-';
     FsgEGrid.Cells[6,0]  := 'Показание Wq+';
     FsgEGrid.Cells[7,0]  := 'Показание Wq-';
     FsgEGrid.Cells[8,0]  := 'Единица измерения';
     FsgEGrid.Cells[9,0]  := 'Достоверность';
     FsgEGrid.ColWidths[0]:= 35;
     FsgEGrid.ColWidths[1]:= 120;
     FsgEGrid.ColWidths[2]:= 120;
     m_dtTime1 := Now;
     m_dtTime2 := Now;
     //OnFormResize(self);
End;

procedure CGraphView.OnFormResize(Sender: TObject);
Var
     i : Integer;
Begin
     for i:=3 to FsgPGrid.ColCount-1  do FsgPGrid.ColWidths[i]  := trunc((FsgPGrid.Width-240-2*FsgPGrid.ColWidths[0])/(FsgPGrid.ColCount-1-2));
     for i:=3 to FsgEGrid.ColCount-1  do FsgEGrid.ColWidths[i]  := trunc((FsgEGrid.Width-240-2*FsgEGrid.ColWidths[0])/(FsgEGrid.ColCount-1-2));
End;
function CGraphView.CreateView(pDS:PCGDataSource):TForm;
Begin
     pDS.nViewID := FindView(pDS.trTRI.PVID,pDS.trTRI.PCID);
     if pDS.nViewID =-1 then Result := CreateNew(pDS);              // breakpoint
     if pDS.nViewID<>-1 then Result := View(pDS.nViewID);
End;
function CGraphView.getView(pDS:PCGDataSource):TForm;
Begin
     Result := nil;
     pDS.nViewID := FindView(pDS.trTRI.PVID,pDS.trTRI.PCID);
     if pDS.nViewID<>-1 then
     Begin
      FForm.MDIChildren[pDS.nViewID].Show;
      Result := FForm.MDIChildren[pDS.nViewID];
     End;
End;
function CGraphView.CreateNew(pDS:PCGDataSource):TForm;
Begin
     m_nCFrame              := TGraphFrame.Create(pDS.pOwner);
     m_nCFrame.PPage        := PPage;
     m_nCFrame.PABOID       := pDS.trTRI.PAID;
     m_nCFrame.PIndex       := pDS.trTRI.PCID;
     m_nCFrame.PMasterIndex := pDS.trTRI.PVID;
     m_nCFrame.PMID         := pDS.trTRI.PMID;
     m_nCFrame.PPRID        := pDS.trTRI.PPID;
     m_nCFrame.PTID         := pDS.trTRI.PTID;
     m_nCFrame.PSVStatus    := pDS.trTRI.PSID;
     m_nCFrame.PCLStatus    := pDS.trTRI.PDID;
     m_nCFrame.PsgPGrid     := FsgPGrid;
     m_nCFrame.PsgEGrid     := FsgEGrid;
     m_nCFrame.Caption      := pDS.strCaption;
     m_nCFrame.Init;
     m_nCFrame.ViewData;                                 // breakpoint
     Result := m_nCFrame;
End;
function CGraphView.View(nIndex:Integer):TForm;
Begin
     Result := nil;                                        // breakpoint
     if nIndex<>-1 then
     Begin
      ViewData(nIndex);
      FForm.MDIChildren[nIndex].Show;
      Result := FForm.MDIChildren[nIndex];
     End;
End;
procedure CGraphView.ViewData(nIndex:Integer);
Begin
     if nIndex<>-1 then                                             // breakpoint
     if FForm.MDIChildren[nIndex].ClassName='TGraphFrame' then
     (FForm.MDIChildren[nIndex] as TGraphFrame).ViewData;
End;
procedure CGraphView.Update(FKey,PKey:Integer);
Begin
     ViewData(FindView(FKey,PKey));
End;

procedure CGraphView.UpdateSlice(FKey,PKey:Integer);
Begin
     ViewSlice(FindView(FKey,PKey));
End;
procedure CGraphView.ViewSlice(nIndex:Integer);
Begin
     if nIndex<>-1 then
     if FForm.MDIChildren[nIndex].ClassName='TGraphFrame' then
     (FForm.MDIChildren[nIndex] as TGraphFrame).ViewSlice;
End;
procedure CGraphView.UpdateArchive(FKey,PKey:Integer);
Begin
     if (PKey>=QRY_U_PARAM_A) and (PKey<=QRY_U_PARAM_C) then
     exit;

     ViewArchive(FindView(FKey,PKey));
End;
procedure CGraphView.ViewArchive(nIndex:Integer);
Begin
     if nIndex<>-1 then
     if FForm.MDIChildren[nIndex].ClassName='TGraphFrame' then
     (FForm.MDIChildren[nIndex] as TGraphFrame).ViewArchive;
End;
procedure CGraphView.UpdateAll;
Var
     i,res : Integer;
Begin
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[i].ClassName='TGraphFrame' then
      (FForm.MDIChildren[i] as TGraphFrame).ViewData;
     End;
End;
procedure CGraphView.PlacedView(pDS:PCGDataSource);
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
function CGraphView.FindView(FKey,PKey:Integer):Integer;
Var
     i,res : Integer;
Begin
     res := -1;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[i].ClassName='TGraphFrame' then
      if((FForm.MDIChildren[i] as TGraphFrame).PMasterIndex=FKey)and
        ((FForm.MDIChildren[i] as TGraphFrame).PIndex=PKey) then
      Begin
       (FForm.MDIChildren[i] as TGraphFrame).PActive := (FForm.MDIChildren[i] as TGraphFrame).Active;
       res := i;
       break;
      End;
     End;
     Result := res;
End;
procedure CGraphView.ReplacedView(nW,nH:Integer);
Var
     i : Integer;
Begin
     nVIndex := 0;
     nHIndex := 0;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      FForm.MDIChildren[i].Width  := round(nW/m_nMaxHView);
      FForm.MDIChildren[i].Height := round(nH/m_nMaxVView);
      FForm.MDIChildren[i].Left   := FForm.MDIChildren[i].Width*nHIndex;
      FForm.MDIChildren[i].Top    := FForm.MDIChildren[i].Height*nVIndex;
      nHIndex  := nHIndex + 1;
      if ((i+1) mod m_nMaxHView)=0 then
      Begin
       nHIndex := 0;
       nVIndex := nVIndex + 1;
      End;
     End;
End;
function  CGraphView.GetActiveCaption:String;
Var
     i     : Integer;
     mForm : TForm;
     strCaption : String;
Begin
     mForm      := FForm.ActiveMDIChild;
     strCaption := mForm.Caption;
     Result     := strCaption;
End;
procedure CGraphView.OnGetCellColorGV(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    with (Sender AS TAdvStringGrid)  do Begin
    if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and
     (not(gdSelected in AState) or (gdFocused in AState)) then
    begin
   //   if (ACol<>0)and(ARow<>0) then ABrush.Color := clTeal;
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
       if (ACol=1) or (ACol=2) or (ACol=6) then AFont.Color := clBlack;{clAqua; }
       if (ACol=3) or (ACol=4) or (ACol=5) then AFont.Color := clBlack;{clWhite; }
      End;
     End;
    End;
end;
procedure CGraphView.OnGetCellColorGV4(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin

    with (Sender AS TAdvStringGrid)  do Begin
    if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and
     (not(gdSelected in AState) or (gdFocused in AState)) then
    begin
   //  if (ACol<>0)and(ARow<>0) then ABrush.Color := clTeal;
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
       if (ACol=1) or (ACol=2) or (ACol=8) then AFont.Color := clBlack;{clAqua;}
       if (ACol=3) or (ACol=4)or (ACol=5)or (ACol=6)or (ACol=7) then AFont.Color := clBlack;{clWhite;}
      End;
     End;
    End;
end;
end.
