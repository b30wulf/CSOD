unit knsl2cmplgrid;
interface
uses
    Windows, SysUtils, Forms, ShellAPI, Classes,
    inifiles,knsl3EventBox,Grids, BaseGrid, AdvGrid,Graphics,
    utltypes, utlbox, utlconst, utldatabase, utltimedate, stdctrls,comctrls,knsl3HolesFinder;
type
    CCmplGrid = class
    private
     m_pHF  : CHolesFinder;
     FGrid  : TAdvStringGrid;
     m_nDescDB : Integer;
     m_nDT  : CDTRouting;
     m_nGM  : SCMPLTAG;
     m_nDeep: Integer;
     procedure FindGraph48(nVMID,nCMDID,nPHDeep:Integer);
     procedure FindPGraph48(nVMID,nCMDID,nPHDeep:Integer);
     procedure FindDay(nVMID,nCMDID,nPHDeep:Integer);
     procedure FindMonth(nVMID,nCMDID,nPHDeep:Integer);
     procedure CreateGraph48TBL(nRowCount:Integer);
     procedure CreateDayTBL(nRowCount:Integer);
     procedure CreateMontTBL(nRowCount:Integer);
     procedure InitGridBuffer(nCount:Integer);
     procedure CreateDateWindow(nDeep:Integer;var dtBegin,dtEnd:TDateTime);
     function  GetPHDeep(nCLSID:Integer;dtBegin,dtEnd:TDateTime):Integer;
     function  GetRowCount(nCLSID,nDeep:Integer):Integer;
    public
     constructor Create(var fcGrid:TAdvStringGrid);
     destructor Destroy;override;
     procedure OnGetCellColor(Sender: TObject; ARow,ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
     procedure PaintGrid(nCLSID,nVMID,nCMDID,nDeep:Integer);
    public
    property PGrid : TAdvStringGrid read FGrid write FGrid;
    End;
implementation
constructor CCmplGrid.Create(var fcGrid:TAdvStringGrid);
Begin
    FGrid := fcGrid;
    m_pHF := CHolesFinder.Create(m_pDB.CreateConnectEx(m_nDescDB)^);
    m_nDT := CDTRouting.Create;
    CreateGraph48TBL(10);
End;
destructor CCmplGrid.Destroy;
Begin
    m_pDB.DynDisconnectEx(m_nDescDB);
    if m_pHF <> nil then FreeAndNil(m_pHF);
    if m_nDT <> nil then FreeAndNil(m_nDT);
    inherited;
End;
procedure CCmplGrid.PaintGrid(nCLSID,nVMID,nCMDID,nDeep:Integer);
Var
    nPHDeep : Integer;
Begin
    m_nDeep := nDeep;
    nPHDeep := GetRowCount(nCLSID,nDeep);
    case nCLSID of
         CLS_GRAPH48 :
         Begin
          CreateGraph48TBL(nPHDeep);
          FindGraph48(nVMID,nCMDID,nPHDeep);
         End;
         CLS_DAY     :
         Begin
          CreateDayTBL(nPHDeep);
          FindDay(nVMID,nCMDID,nPHDeep);
         End;
         CLS_MONT    :
         Begin
          CreateMontTBL(nPHDeep);
          FindMonth(nVMID,nCMDID,nPHDeep);
         End;
         CLS_PNET   :
         Begin
          CreateGraph48TBL(nPHDeep);
          FindPGraph48(nVMID,nCMDID,nPHDeep);
         End;
    End;
    FGrid.Refresh;
End;
procedure CCmplGrid.CreateGraph48TBL(nRowCount:Integer);
Var
    i : Integer;
    de : TDateTime;
Begin
    de := Now;
    with FGrid do
    Begin
     Color       := KNS_NCOLOR;
     ColCount    := 1+48;
     RowCount    := nRowCount+1;
     Cells[0,0]  := '�/�';
     ColWidths[0]:= 30;
     for i:=1 to ColCount-1 do
     Begin
      Cells[i,0] := IntToStr(i);
      ColWidths[i]:= trunc((Width-ColWidths[0])/(ColCount-1));
     End;
     for i:=1 to nRowCount do
     Begin
      Cells[0,i] := FormatDateTime('mm:dd', de);
      de := de - 1;
     End;
    End;
    InitGridBuffer(nRowCount);
End;
procedure CCmplGrid.CreateDayTBL(nRowCount:Integer);
Var
    i : Integer;
    de : TDateTime;
Begin
    de := Now;
    with FGrid do
    Begin
     Color       := KNS_NCOLOR;
     ColCount    := 1+31;
     RowCount    := nRowCount+1;
     Cells[0,0]  := '�/�';
     ColWidths[0]:= 30;
     for i:=1 to ColCount-1 do
     Begin
      Cells[i,0] := IntToStr(i);
      ColWidths[i]:= trunc((Width-ColWidths[0])/(ColCount-1));
     End;
     for i:=1 to nRowCount do
     Begin
      Cells[0,i] := FormatDateTime('yy:mm', de);
      m_nDT.DecMonth(de);
     End;
    End;
    InitGridBuffer(nRowCount);
End;
procedure CCmplGrid.CreateMontTBL(nRowCount:Integer);
Var
    i : Integer;
    de : TDateTime;
Begin
    de := Now;
    with FGrid do
    Begin
     Color       := KNS_NCOLOR;
     ColCount    := 1+1;
     RowCount    := nRowCount+1;
     Cells[0,0]  := '�/�';
     ColWidths[0]:= 30;
     for i:=1 to ColCount-1 do
     Begin
      Cells[i,0] := IntToStr(i);
      ColWidths[i]:= trunc((Width-ColWidths[0])/(ColCount-1));
     End;
     for i:=1 to nRowCount do
     Begin
      Cells[0,i] := FormatDateTime('yy:mm', de);
      m_nDT.DecMonth(de);
     End;
    End;
    InitGridBuffer(nRowCount);
End;
procedure CCmplGrid.InitGridBuffer(nCount:Integer);
Var
    i : Integer;
Begin
    m_nGM.Count := nCount;
    SetLength(m_nGM.Items,nCount);
    for i:=0 to nCount-1 do m_nGM.Items[i] := 0;
End;
procedure CCmplGrid.CreateDateWindow(nDeep:Integer;var dtBegin,dtEnd:TDateTime);
Var
    year,month,day : Word;
Begin
    dtBegin:= Now;
    dtEnd  := Now;
    if nDeep=0 then
    Begin
     DecodeDate(dtEnd,year,month,day);
     dtEnd := EncodeDate(year,month,1);
    End else
    if nDeep<>0 then dtEnd := dtEnd - DeltaFHF[nDeep];
    //EventBox.FixEvents(ET_NORMAL,'�����. ������:'+IntToStr(m_nTbl.m_snVMID)+' �����: '+DateTimeToStr(dtEnd)+' �������:'+IntToStr(m_nTbl.m_snCLSID));
End;
function CCmplGrid.GetPHDeep(nCLSID:Integer;dtBegin,dtEnd:TDateTime):Integer;
Begin
    case nCLSID of
         CLS_GRAPH48 :
         Begin
          Result := trunc(abs(dtBegin-dtEnd))+1;
         End;
         CLS_DAY     :
         Begin
          //Result := trunc(abs(dtBegin-dtEnd)/30)+1;
          Result := 3;
         End;
         CLS_MONT    :
         Begin
          //Result := trunc(abs(dtBegin-dtEnd)/30)+1;
          Result := 3;
         End;
         CLS_PNET  :
         Begin
          Result := trunc(abs(dtBegin-dtEnd))+1;
         End;
    End;
End;
function CCmplGrid.GetRowCount(nCLSID,nDeep:Integer):Integer;
Var
    dtBegin,dtEnd:TDateTime;
Begin
    CreateDateWindow(nDeep,dtBegin,dtEnd);
    Result := GetPHDeep(nCLSID,dtBegin,dtEnd);
End;
procedure CCmplGrid.FindGraph48(nVMID,nCMDID,nPHDeep:Integer);
Var
    dt : TDateTime;
Begin
    dt := Now;
    m_pHF.FindHallMask(CLS_GRAPH48,dt,dt-nPHDeep,nVMID,nCMDID,m_nGM);
End;
procedure CCmplGrid.FindPGraph48(nVMID,nCMDID,nPHDeep:Integer);
Var
    dt : TDateTime;
Begin
    dt := Now;
    m_pHF.FindHallMask(CLS_PNET,dt,dt-nPHDeep,nVMID,nCMDID,m_nGM);
End;
procedure CCmplGrid.FindDay(nVMID,nCMDID,nPHDeep:Integer);
Var
    dt : TDateTime;
Begin
    dt := Now;
    m_pHF.FindHallMask(CLS_DAY,dt,m_nDT.DecMonthEx(nPHDeep,dt),nVMID,nCMDID,m_nGM);
End;
procedure CCmplGrid.FindMonth(nVMID,nCMDID,nPHDeep:Integer);
Var
    dt : TDateTime;
Begin
    dt := Now;
    m_pHF.FindHallMask(CLS_MONT,dt,m_nDT.DecMonthEx(nPHDeep,dt),nVMID,nCMDID,m_nGM);
End;
procedure CCmplGrid.OnGetCellColor(Sender: TObject; ARow,ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
Var
    sh : int64;
begin
    sh := 1;
    with (Sender AS TAdvStringGrid)  do
    Begin
     if (m_nGM.Count<>0)and(ARow<=m_nGM.Count)and(ACol <> 0) and (ARow<>0) and (ARow < RowCount) and
     (not(gdSelected in AState) or (gdFocused in AState)) then
     begin
      if (m_nGM.Items[(ARow-1)] and (sh shl (ACol-1)))<>0 then ABrush.Color := $0080FF00 else
      if (m_nGM.Items[(ARow-1)] and (sh shl (ACol-1)))= 0 then ABrush.Color := $008080ff;
     end;
    End;
end;



end.
