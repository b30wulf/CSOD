unit knsl3qryschedlr;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, Grids, BaseGrid, AdvGrid, ComCtrls, ToolWin, StdCtrls, jpeg,
  ExtCtrls,utldatabase,utltypes,utlbox,knsl5tracer,utlconst,utlmtimer,knsl3setgsmtime,utlTimeDate,knsl3qwerytree;
type
     CQryScheduler = class
     private
      FsgGrid  : PTAdvStringGrid;
      FdtPick  : PTDateTimePicker;
      FcbCombo : PTComboBox;
      m_pST    : SQRYSDLTAGS;
      m_nIDIndex : Integer;
      m_strCurrentDir : String;
      m_blIsEdit      : Boolean;
      m_dwCounter     : DWord;
      FlbSExpired     : PTStaticText;
      FlbScheduler    : PTStaticText;
      FlbSchedTime    : PTStaticText;
      m_pTable        : PSGENSETTTAG;
      m_nRowIndex     : Integer;
      m_nRowIndexEx   : Integer;
      m_nColIndex     : Integer;
      m_nIndex        : Integer;
      FTreeModuleData : PTTreeView;
      cbm_nWekEN: PTAdvOfficeCheckBox;
      cbm_nPon: PTAdvOfficeCheckBox;
      cbm_nWto: PTAdvOfficeCheckBox;
      cbm_nSrd: PTAdvOfficeCheckBox;
      cbm_nCht: PTAdvOfficeCheckBox;
      cbm_nPtn: PTAdvOfficeCheckBox;
      cbm_nSub: PTAdvOfficeCheckBox;
      cbm_nVos: PTAdvOfficeCheckBox;
      cbm_nMonthEN: PTAdvOfficeCheckBox;
      cbm_nDay1: PTAdvOfficeCheckBox;
      cbm_nDay2: PTAdvOfficeCheckBox;
      cbm_nDay3: PTAdvOfficeCheckBox;
      cbm_nDay4: PTAdvOfficeCheckBox;
      cbm_nDay5: PTAdvOfficeCheckBox;
      cbm_nDay6: PTAdvOfficeCheckBox;
      cbm_nDay7: PTAdvOfficeCheckBox;
      cbm_nDay8: PTAdvOfficeCheckBox;
      cbm_nDay9: PTAdvOfficeCheckBox;
      cbm_nDay10: PTAdvOfficeCheckBox;
      cbm_nDay11: PTAdvOfficeCheckBox;
      cbm_nDay12: PTAdvOfficeCheckBox;
      cbm_nDay13: PTAdvOfficeCheckBox;
      cbm_nDay14: PTAdvOfficeCheckBox;
      cbm_nDay15: PTAdvOfficeCheckBox;
      cbm_nDay16: PTAdvOfficeCheckBox;
      cbm_nDay17: PTAdvOfficeCheckBox;
      cbm_nDay18: PTAdvOfficeCheckBox;
      cbm_nDay19: PTAdvOfficeCheckBox;
      cbm_nDay20: PTAdvOfficeCheckBox;
      cbm_nDay21: PTAdvOfficeCheckBox;
      cbm_nDay22: PTAdvOfficeCheckBox;
      cbm_nDay23: PTAdvOfficeCheckBox;
      cbm_nDay24: PTAdvOfficeCheckBox;
      cbm_nDay25: PTAdvOfficeCheckBox;
      cbm_nDay26: PTAdvOfficeCheckBox;
      cbm_nDay27: PTAdvOfficeCheckBox;
      cbm_nDay28: PTAdvOfficeCheckBox;
      cbm_nDay29: PTAdvOfficeCheckBox;
      cbm_nDay30: PTAdvOfficeCheckBox;
      cbm_nDay31: PTAdvOfficeCheckBox;
      dtPicShed: PTDateTimePicker;

      cbm_nArchEN: PTAdvOfficeCheckBox;
      cbm_nPriDayF: PTAdvOfficeCheckBox;
      cbm_nPriMonthF: PTAdvOfficeCheckBox;
      cbm_nPri30F: PTAdvOfficeCheckBox;
      cbm_nNakDayF: PTAdvOfficeCheckBox;
      cbm_nNakMonthF: PTAdvOfficeCheckBox;
      cbm_byCurrent: PTAdvOfficeCheckBox;
      cbm_bySumEn: PTAdvOfficeCheckBox;
      cbm_byMAP: PTAdvOfficeCheckBox;
      cbm_byMRAP: PTAdvOfficeCheckBox;
      cbm_byU: PTAdvOfficeCheckBox;
      cbm_byI: PTAdvOfficeCheckBox;
      cbm_byFreq: PTAdvOfficeCheckBox;
      cbm_nPar6: PTAdvOfficeCheckBox;
      cbm_byJEn: PTAdvOfficeCheckBox;
      cbm_byJ0: PTAdvOfficeCheckBox;
      cbm_byJ1: PTAdvOfficeCheckBox;
      cbm_byJ2: PTAdvOfficeCheckBox;
      cbm_byJ3: PTAdvOfficeCheckBox;
      cbm_byPNetEn: PTAdvOfficeCheckBox;
      cbm_byPNetU: PTAdvOfficeCheckBox;
      cbm_byPNetI: PTAdvOfficeCheckBox;
      cbm_byPNetFi: PTAdvOfficeCheckBox;
      cbm_byPNetCosFi: PTAdvOfficeCheckBox;
      cbm_byPNetF: PTAdvOfficeCheckBox;
      cbm_byPNetP: PTAdvOfficeCheckBox;
      cbm_byPNetQ: PTAdvOfficeCheckBox;
      cbm_byCorrTM: PTAdvOfficeCheckBox;
      FL3QweryTree : CL3QweryTree;


      procedure GetGridRecord(var pTbl:SQRYSDLTAG);
      procedure ExecSdlGrid;
      procedure AddRecordToGrid(nIndex:Integer;var pTbl:SQRYSDLTAG);
      function  GetComboTime:Double;
      function  FindTime:Byte;

     public
      m_nGST : CSetGsmTime;
      procedure Init(pTable:PSGENSETTTAG);
      procedure SetAction;
      procedure OnStartFind(nABOID,nVMID:Integer);
      procedure RunScheduler;
      procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
      procedure OnFormResize;
      procedure OnGetCellColor(Sender: TObject; ARow,
               ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
      procedure OnGetCellType(Sender: TObject; ACol,
               ARow: Integer; var AEditor: TEditorType);
      procedure OnComboChandge(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: String);
      procedure OnClickGrid(Sender: TObject; ARow, ACol: Integer);
      procedure OnSetSdl(Sender: TObject);
      procedure OnGetSdl(Sender: TObject);
      procedure OnGenSdl;
      procedure OnDelSdl;
      procedure OnSetMode;
      procedure OnResetAllState;
      procedure OnSetAll;
      procedure SchedInit;
      procedure OnClickQweryTree;
      destructor Destroy; override; 
     public
      property PlbScheduler  :PTStaticText      read FlbScheduler   write FlbScheduler;
      property PlbSchedTime  :PTStaticText      read FlbSchedTime   write FlbSchedTime;
      property PsgGrid       :PTAdvStringGrid   read FsgGrid        write FsgGrid;
      property PdtPick       :PTDateTimePicker  read FdtPick        write FdtPick;
      property PcbCombo      :PTComboBox        read FcbCombo       write FcbCombo;

      property PTreeModuleData : PTTreeView read FTreeModuleData write FTreeModuleData;

      property Pcbm_nWekEN   : PTAdvOfficeCheckBox read cbm_nWekEN write cbm_nWekEN;
      property Pcbm_nPon     : PTAdvOfficeCheckBox read cbm_nPon   write cbm_nPon;
      property Pcbm_nWto     : PTAdvOfficeCheckBox read cbm_nWto   write cbm_nWto;
      property Pcbm_nSrd     : PTAdvOfficeCheckBox read cbm_nSrd   write cbm_nSrd;
      property Pcbm_nCht     : PTAdvOfficeCheckBox read cbm_nCht   write cbm_nCht;
      property Pcbm_nPtn     : PTAdvOfficeCheckBox read cbm_nPtn   write cbm_nPtn;
      property Pcbm_nSub     : PTAdvOfficeCheckBox read cbm_nSub   write cbm_nSub;
      property Pcbm_nVos     : PTAdvOfficeCheckBox read cbm_nVos   write cbm_nVos;

      property Pcbm_nMonthEN : PTAdvOfficeCheckBox read cbm_nMonthEN write cbm_nMonthEN;
      property Pcbm_nDay1    : PTAdvOfficeCheckBox read cbm_nDay1    write cbm_nDay1;
      property Pcbm_nDay2    : PTAdvOfficeCheckBox read cbm_nDay2    write cbm_nDay2;
      property Pcbm_nDay3    : PTAdvOfficeCheckBox read cbm_nDay3    write cbm_nDay3;
      property Pcbm_nDay4    : PTAdvOfficeCheckBox read cbm_nDay4    write cbm_nDay4;
      property Pcbm_nDay5    : PTAdvOfficeCheckBox read cbm_nDay5    write cbm_nDay5;
      property Pcbm_nDay6    : PTAdvOfficeCheckBox read cbm_nDay6    write cbm_nDay6;
      property Pcbm_nDay7    : PTAdvOfficeCheckBox read cbm_nDay7    write cbm_nDay7;
      property Pcbm_nDay8    : PTAdvOfficeCheckBox read cbm_nDay8    write cbm_nDay8;
      property Pcbm_nDay9    : PTAdvOfficeCheckBox read cbm_nDay9    write cbm_nDay9;
      property Pcbm_nDay10   : PTAdvOfficeCheckBox read cbm_nDay10    write cbm_nDay10;

      property Pcbm_nDay11   : PTAdvOfficeCheckBox read cbm_nDay11    write cbm_nDay11;
      property Pcbm_nDay12   : PTAdvOfficeCheckBox read cbm_nDay12    write cbm_nDay12;
      property Pcbm_nDay13   : PTAdvOfficeCheckBox read cbm_nDay13    write cbm_nDay13;
      property Pcbm_nDay14   : PTAdvOfficeCheckBox read cbm_nDay14    write cbm_nDay14;
      property Pcbm_nDay15   : PTAdvOfficeCheckBox read cbm_nDay15    write cbm_nDay15;
      property Pcbm_nDay16   : PTAdvOfficeCheckBox read cbm_nDay16    write cbm_nDay16;
      property Pcbm_nDay17   : PTAdvOfficeCheckBox read cbm_nDay17    write cbm_nDay17;
      property Pcbm_nDay18   : PTAdvOfficeCheckBox read cbm_nDay18    write cbm_nDay18;
      property Pcbm_nDay19   : PTAdvOfficeCheckBox read cbm_nDay19    write cbm_nDay19;
      property Pcbm_nDay20   : PTAdvOfficeCheckBox read cbm_nDay20    write cbm_nDay20;

      property Pcbm_nDay21   : PTAdvOfficeCheckBox read cbm_nDay21    write cbm_nDay21;
      property Pcbm_nDay22   : PTAdvOfficeCheckBox read cbm_nDay22    write cbm_nDay22;
      property Pcbm_nDay23   : PTAdvOfficeCheckBox read cbm_nDay23    write cbm_nDay23;
      property Pcbm_nDay24   : PTAdvOfficeCheckBox read cbm_nDay24    write cbm_nDay24;
      property Pcbm_nDay25   : PTAdvOfficeCheckBox read cbm_nDay25    write cbm_nDay25;
      property Pcbm_nDay26   : PTAdvOfficeCheckBox read cbm_nDay26    write cbm_nDay26;
      property Pcbm_nDay27   : PTAdvOfficeCheckBox read cbm_nDay27    write cbm_nDay27;
      property Pcbm_nDay28   : PTAdvOfficeCheckBox read cbm_nDay28    write cbm_nDay28;
      property Pcbm_nDay29   : PTAdvOfficeCheckBox read cbm_nDay29    write cbm_nDay29;
      property Pcbm_nDay30   : PTAdvOfficeCheckBox read cbm_nDay30    write cbm_nDay30;
      property Pcbm_nDay31   : PTAdvOfficeCheckBox read cbm_nDay31    write cbm_nDay31;

      property PdtPicShed     : PTDateTimePicker   read dtPicShed     write dtPicShed;

      property Pcbm_nArchEN   : PTAdvOfficeCheckBox read cbm_nArchEN    write cbm_nArchEN;
      property Pcbm_nPriDayF  : PTAdvOfficeCheckBox read cbm_nPriDayF   write cbm_nPriDayF;
      property Pcbm_nPriMonthF: PTAdvOfficeCheckBox read cbm_nPriMonthF write cbm_nPriMonthF;
      property Pcbm_nPri30F   : PTAdvOfficeCheckBox read cbm_nPri30F    write cbm_nPri30F;
      property Pcbm_nNakDayF  : PTAdvOfficeCheckBox read cbm_nNakDayF   write cbm_nNakDayF;
      property Pcbm_nNakMonthF: PTAdvOfficeCheckBox read cbm_nNakMonthF write cbm_nNakMonthF;
      property Pcbm_byCurrent : PTAdvOfficeCheckBox read cbm_byCurrent  write cbm_byCurrent;
      property Pcbm_bySumEn   : PTAdvOfficeCheckBox read cbm_bySumEn    write cbm_bySumEn;
      property Pcbm_byMAP     : PTAdvOfficeCheckBox read cbm_byMAP      write cbm_byMAP;
      property Pcbm_byMRAP    : PTAdvOfficeCheckBox read cbm_byMRAP     write cbm_byMRAP;
      property Pcbm_byU       : PTAdvOfficeCheckBox read cbm_byU        write cbm_byU;
      property Pcbm_byI       : PTAdvOfficeCheckBox read cbm_byI        write cbm_byI;
      property Pcbm_byFreq    : PTAdvOfficeCheckBox read cbm_byFreq     write cbm_byFreq;
      property Pcbm_nPar6     : PTAdvOfficeCheckBox read cbm_nPar6      write cbm_nPar6;
      property Pcbm_byJEn     : PTAdvOfficeCheckBox read cbm_byJEn      write cbm_byJEn;
      property Pcbm_byJ0      : PTAdvOfficeCheckBox read cbm_byJ0       write cbm_byJ0;
      property Pcbm_byJ1      : PTAdvOfficeCheckBox read cbm_byJ1       write cbm_byJ1;
      property Pcbm_byJ2      : PTAdvOfficeCheckBox read cbm_byJ2       write cbm_byJ2;
      property Pcbm_byJ3      : PTAdvOfficeCheckBox read cbm_byJ3       write cbm_byJ3;
      property Pcbm_byPNetEn  : PTAdvOfficeCheckBox read cbm_byPNetEn   write cbm_byPNetEn;
      property Pcbm_byPNetU   : PTAdvOfficeCheckBox read cbm_byPNetU    write cbm_byPNetU;
      property Pcbm_byPNetI   : PTAdvOfficeCheckBox read cbm_byPNetI    write cbm_byPNetI;
      property Pcbm_byPNetFi  : PTAdvOfficeCheckBox read cbm_byPNetFi   write cbm_byPNetFi;
      property Pcbm_byPNetCosFi: PTAdvOfficeCheckBox read cbm_byPNetCosFi write cbm_byPNetCosFi;
      property Pcbm_byPNetF   : PTAdvOfficeCheckBox read cbm_byPNetF      write cbm_byPNetF;
      property Pcbm_byPNetP   : PTAdvOfficeCheckBox read cbm_byPNetP      write cbm_byPNetP;
      property Pcbm_byPNetQ   : PTAdvOfficeCheckBox read cbm_byPNetQ      write cbm_byPNetQ;
      property Pcbm_byCorrTM  : PTAdvOfficeCheckBox read cbm_byCorrTM     write cbm_byCorrTM;
      property PlbSExpired     :PTStaticText        read FlbSExpired      write FlbSExpired;
     End;
implementation
const
  DeltaFHF     : array [0..10] of integer = (1,1,2,3,5, 7, 14, 31, 62, 182, 365);
{
Var
   m_nSDL : CQryScheduler;
}
{
     function GetSdlTable(var pTable:SQRYSDLTAGS):Boolean;
     function IsSdlTag(var pTable:SQRYSDLTAG):Boolean;
     function SetSdlTable(var pTable:SQRYSDLTAG):Boolean;
     function AddSdlTable(var pTable:SQRYSDLTAG):Boolean;
     3 минуты
5 минут
10 минут
15 минут
30 минут
1 час
2 часа
3 часа
4 часа
6 часов
8 часов
12 часов
}
procedure CQryScheduler.Init(pTable:PSGENSETTTAG);
Begin
     m_pTable := pTable;
     m_nIDIndex := 1;
     m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
     FsgGrid.ColCount    := 6;
     FsgGrid.RowCount    := 80;
     FsgGrid.Cells[0,0]  := '№/T';
     FsgGrid.Cells[1,0]  := 'Дата';
     FsgGrid.Cells[2,0]  := 'Время';
     FsgGrid.Cells[3,0]  := 'Состояние';
     FsgGrid.Cells[4,0]  := 'Синхр.времени';
     FsgGrid.Cells[5,0]  := 'Активность';
     FsgGrid.ColWidths[0]:= 35;
     //SetHigthGrid(FsgGrid^,20);
     FcbCombo.ItemIndex := 1;
     FdtPick.DateTime := Now;
     FsgGrid.Options  := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goRowSelect];
     m_blIsEdit  := False;
     m_dwCounter := 0;
     SchedInit;
     ExecSdlGrid;
     //m_nWPollTimer := CTimer.Create;
     //m_nWPollTimer.SetTimer(DIR_L3TOSDL,DL_SDL_WPOLL_TMR,0,0,BOX_L3);
     FL3QweryTree := CL3QweryTree.Create(@FTreeModuleData);
     m_nGST      := CSetGsmTime.Create;
//     m_nGST.PlbSetTmState := PlbSetTmState;
     m_nGST.PlbSExpired   := PlbSExpired;
     m_nGST.Init(m_pTable);
End;
procedure CQryScheduler.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
   // for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure CQryScheduler.OnFormResize;
Var
    i : Integer;
Begin
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-0-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
End;
procedure CQryScheduler.OnSetAll;
Var
    i : Integer;
Begin
    if m_nRowIndex<>-1 then
    Begin
     for i:=1 to FsgGrid.RowCount-1 do
     if FsgGrid.Cells[m_nIDIndex,i]<>'' then
     FsgGrid.Cells[m_nColIndex,i] := FsgGrid.Cells[m_nColIndex,m_nRowIndex];
    End;
End;
procedure CQryScheduler.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex   := -1;
    m_nRowIndexEx := -1;
    m_nColIndex   := ACol;
    if ARow>0 then Begin
     m_nRowIndex := ARow;
     m_nRowIndexEx := ARow;
     if FsgGrid.Cells[1,ARow]<>'' then
     Begin
      //m_nIndex := StrToInt(FsgGrid.Cells[1,ARow]);
      //ViewChild(m_nIndex);
     End else m_nIndex := -1;
    End;
End;
procedure CQryScheduler.OnSetSdl(Sender: TObject);
Var
    i : Integer;
    pTbl:SQRYSDLTAG;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[m_nIDIndex,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     m_pDB.AddSdlTable(pTbl);
    End;
    ExecSdlGrid;
end;
procedure CQryScheduler.OnGetSdl(Sender: TObject);
Begin
    FL3QweryTree.LoadTree;
    ExecSdlGrid;
end;
procedure CQryScheduler.ExecSdlGrid;
Var
    pTbl : SQRYSDLTAGS;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    if m_pDB.GetSdlTable(pTbl)=True then
    Begin
     for i:=0 to pTbl.Count-1 do
     Begin
      pTbl.Items[i].m_sbyState := 0;
      AddRecordToGrid(i,pTbl.Items[i]);
     End;
    End;
End;
procedure CQryScheduler.OnGenSdl;
Var
    i,nCount  : Integer;
    dtTime    : TDateTime;
    dtTimeInc : TDateTime;
    pTbl      : SQRYSDLTAG;
Begin
    FsgGrid.ClearNormalCells;
    dtTime    := FdtPick.DateTime;
    dtTimeInc := GetComboTime/(24.0*60.0);
    nCount    := trunc(1/dtTimeInc);
    for i:=0 to nCount-1 do
    Begin
     pTbl.m_sdtEventTime := dtTime;
     pTbl.m_sbySynchro   := 0;
     pTbl.m_sbyEnable    := 1;
     AddRecordToGrid(i,pTbl);
     dtTime := dtTime + dtTimeInc;
    End;
End;
procedure CQryScheduler.OnSetMode;
Begin
    if m_blIsEdit=False then
    Begin
     m_blIsEdit := True;
     FsgGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goEditing];
//     m_pDB.FixUspdEvent(0,3,EVS_TSHEDL_ED_ON);
    End else
    if m_blIsEdit=True then
    Begin
     FsgGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goRowSelect];
//     m_pDB.FixUspdEvent(0,3,EVS_TSHEDL_ED_OF);
     m_blIsEdit := False;
    End;
End;
procedure CQryScheduler.OnClickQweryTree;
Begin
    
End;
{
3 минуты
5 минут
10 минут
15 минут
30 минут
1 час
2 часа
3 часа
4 часа
6 часов
8 часов
12 часов
}
function CQryScheduler.GetComboTime:Double;
Begin
     case FcbCombo.ItemIndex of
       0:  Result := 3.0;
       1:  Result := 5.0;
       2:  Result := 6.0;
       3:  Result := 10.0;
       4:  Result := 15.0;
       5:  Result := 30.0;
       6:  Result := 1*60.0;
       7:  Result := 2*60.0;
       8:  Result := 3*60.0;
       9:  Result := 4*60.0;
       10: Result := 6*60.0;
       11: Result := 8*60.0;
       12: Result := 12*60.0;
       13: Result := 1.0;
       14: Result := 1.5;
       //24: Result := 24*60.0;
       else
           Result := 5.0;
     End;
End;
procedure CQryScheduler.OnDelSdl;
Begin
    //if MessageDlg('Удалить весь список?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     m_pDB.DelSdlTable;
     ExecSdlGrid;
    End;
End;
{
 FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'Активность';
    FsgGrid.Cells[2,0]  := 'Дата';
    FsgGrid.Cells[3,0]  := 'Время';
    FsgGrid.Cells[4,0]  := 'Группа';
    FsgGrid.Cells[5,0]  := 'Код ';
    FsgGrid.Cells[6,0]  := 'Пользователь';
    FsgGrid.Cells[7,0]  := 'Название';
    m_swID         : Integer;
    m_sdtEventTime : TDateTIme;
    m_sbyEnable    : Byte;
}
procedure CQryScheduler.GetGridRecord(var pTbl:SQRYSDLTAG);
Var
    i : Integer;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i] := DateToStr(Now);
     if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[2,i] := TimeToStr(Now);
     if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i] := 'Исходное';
     if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i] := m_nEsNoList.Strings[0];
     if FsgGrid.Cells[5,i]='' then FsgGrid.Cells[5,i] := m_nEsNoList.Strings[1];
     m_sdtEventTime := StrToDate(FsgGrid.Cells[1,i])+StrToTime(FsgGrid.Cells[2,i]);
     m_sbySynchro   := m_nEsNoList.IndexOf(FsgGrid.Cells[4,i]);
     m_sbyEnable    := m_nEsNoList.IndexOf(FsgGrid.Cells[5,i]);
    End;
End;
procedure CQryScheduler.SchedInit;
Var
    i : Integer;
Begin
    m_pDB.GetSdlTable(m_pST);
    for i:=0 to m_pST.Count-1 do m_pST.Items[i].m_sbyState := 0;
End;
procedure CQryScheduler.AddRecordToGrid(nIndex:Integer;var pTbl:SQRYSDLTAG);
Var
    nY : Integer;
    nVisible : Integer;
Begin
    nY := nIndex+1;
    nVisible := round(FsgGrid.Height/21);
    if nY>FsgGrid.RowCount then FsgGrid.RowCount := FsgGrid.RowCount+50;
    with pTbl do Begin
     FsgGrid.Cells[0,nY] := IntToStr(nY);
     FsgGrid.Cells[1,nY] := DateToStr(Now);
     FsgGrid.Cells[2,nY] := TimeToStr(m_sdtEventTime);
     FsgGrid.Cells[3,nY] := 'Исходное';
     FsgGrid.Cells[4,nY] := m_nEsNoList.Strings[m_sbySynchro];
     FsgGrid.Cells[5,nY] := m_nEsNoList.Strings[m_sbyEnable];
    End;
End;
procedure CQryScheduler.OnGetCellColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin

    with (Sender AS TAdvStringGrid)  do
    Begin
     if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and (not(gdSelected in AState) or (gdFocused in AState)) then
     begin
     // if (ACol<>0)and(ARow<>0) then ABrush.Color := clTeal;
     end;
    if (ARow=0)or(ACol=0) then
    Begin
     AFont.Size  := 9;
     AFont.Style := [fsBold];
     AFont.Color := clBlack;
    End;
     if (ARow<>0) and (ACol<>0)then
      Begin
      AFont.Color :=  m_blGridDataFontColor;
      AFont.Size  :=  m_blGridDataFontSize;
      AFont.Name  :=  m_blGridDataFontName;
        case ACol of
         2,3       : AFont.Color := clBlack;{clLime;}
         1,4,5     : AFont.Color := clBlack;{clAqua;}
        End;
      End;
    End;
end;
procedure CQryScheduler.OnGetCellType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     4,5:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;
procedure CQryScheduler.OnComboChandge(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: String);
begin
    if (ACol=4)and(ARow<>0) then
    Begin
     if AItemIndex=1 then FsgGrid.Cells[5,ARow]:=m_nEsNoList.Strings[0];
    End;
end;
{
    FsgGrid.SelectRows(FindRow(IntToStr(m_nIndex)),1);
    FsgGrid.Refresh;
}
function CQryScheduler.FindTime:Byte;
Var
    i : Integer;
    h0,m0,s0,ms0 : Word;
    h1,m1,s1,ms1 : Word;
Begin
    try
    Result := 0;
    for i:=0 to m_pST.Count-1 do
    Begin
     with m_pST.Items[i] do
     Begin
      if m_sbyState = 0 then
      Begin
       DecodeTime(m_sdtEventTime,h0,m0,s0,ms0);
       DecodeTime(Now,h1,m1,s1,ms1);
       if (h0=h1)and(m0=m1) then
       Begin

        if h0=0 then
        Begin
         m_dtTime1 := Now;
         m_dtTime2 := Now;
        End;

        m_sbyState := 1;
        FsgGrid.SelectRows(i+1,1);
        if (i-FsgGrid.VisibleRowCount)>0  then FsgGrid.TopRow := i-FsgGrid.VisibleRowCount+2 else FsgGrid.TopRow := 1;
        FdtPick.DateTime := m_sdtEventTime;
        if i>0 then
        Begin
         m_pST.Items[i-1].m_sbyState := 0;
         FsgGrid.Cells[3,i]   := 'Выполнено';
         FsgGrid.Cells[3,i+1] := 'Выполняется';
         if (i+1)<=m_pST.Count-1 then FlbSchedTime.Caption := 'Следующий опрос в '+TimeToStr(m_pST.Items[i+1].m_sdtEventTime) else
         if (i+1)>m_pST.Count-1  then FlbSchedTime.Caption := 'Следующий опрос в '+TimeToStr(m_pST.Items[0].m_sdtEventTime);
        End;
        if i=0 then
        Begin
         m_pST.Items[m_pST.Count-1].m_sbyState := 0;
         FlbSchedTime.Caption := 'Следующий опрос в '+TimeToStr(m_pST.Items[0].m_sdtEventTime);
        End;
        if i=m_pST.Count-1 then
        Begin
         OnResetAllState;
         FlbSchedTime.Caption := 'Следующий опрос в '+TimeToStr(m_pST.Items[0].m_sdtEventTime);
        End;
        if m_sbySynchro=1 then Result := 2 else
        if m_sbyEnable=1  then Result := 1 else
        if m_sbyEnable=0  then Result := 0;
        exit;
       End;
      End;
     End;
    End;
    except
     Result := 0;
    End;
     //Result := 0;
End;
procedure CQryScheduler.OnResetAllState;
Var
   i : Integer;
Begin
    for i:=0 to m_pST.Count-2 do
    Begin
     m_pST.Items[i].m_sbyState := 0;
     FsgGrid.Cells[3,i+1] := 'Исходное';
    End;
End;
{
procedure TTL5Config.OnStartFh(Sender: TObject);
Var
   dwLoMask : int64;
   dwOne    : int64;
   ldtFTime,ldtETime : TDateTime;
   pDS      : CMessageData;
   szDT     : Integer;
   str      : String;
begin
   dwLoMask := 0;
   dwOne    := 1;
   szDT     := sizeof(TDateTime);
   if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Запустить поиск данных?';End;
   if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Запустить поиск данных удаленно?';End;
   if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
   Begin

    if cbm_nPriDay.Checked=True   then dwLoMask := dwLoMask or (dwOne shl 0);
    if cbm_nPriMonth.Checked=True then dwLoMask := dwLoMask or (dwOne shl 1);
    if cbm_nPri30.Checked=True    then dwLoMask := dwLoMask or (dwOne shl 2);
    if cbm_nNakDay.Checked=True   then dwLoMask := dwLoMask or (dwOne shl 3);
    if cbm_nNakMonth.Checked=True then dwLoMask := dwLoMask or (dwOne shl 4);
    ldtFTime := dtFTime.DateTime;
    ldtETime := dtETime.DateTime;
    move(ldtFTime,pDS.m_sbyInfo[0], szDT);
    move(ldtETime,pDS.m_sbyInfo[szDT], szDT);
    move(dwLoMask,pDS.m_sbyInfo[2*szDT], sizeof(int64));
    if m_blIsRemCrc=True then Begin SendRemCrcFind(pDS);exit; End;
    SendMsgData(BOX_L3_LME, 0, DIR_LHTOLM3, QL_START_FH_REQ, pDS);
   End;
end;
}
procedure CQryScheduler.SetAction;
Var
    pDS  : CMessageData;
Begin
    //if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    //if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    case m_pTable.m_sQryScheduler of
         1: Begin
             pDS.m_swData4 := MTR_LOCAL;
             m_nDataFinder := False;
             FFREE(BOX_LOAD);
             SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ);
             SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
             SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
            End;
         2: OnStartFind(-1,-1);
    End;
End;
procedure CQryScheduler.OnStartFind(nABOID,nVMID:Integer);
Var
    pDS  : CMessageData;
    ldtFTime,ldtETime,dltTime : TDateTime;
    szDT : Integer;
    year,month,day:Word;
    FSVMID : int64;
Begin
    try
     szDT          := sizeof(TDateTime);
     pDS.m_swData0 := nABOID;
     pDS.m_swData1 := nVMID;
     pDS.m_swData2 := 0;
     pDS.m_swData3 := 0;
     pDS.m_swData4 := MTR_LOCAL;
     ldtFTime      := Now;
     FSVMID        := nVMID;
     if m_pTable.m_sbyDeltaFH>10 then m_pTable.m_sbyDeltaFH := 1;
     if m_pTable.m_sbyDeltaFH=0 then
     Begin
      DecodeDate(Now,year,month,day);
      ldtETime := EncodeDate(year,month,1);
     End else
     if m_pTable.m_sbyDeltaFH<>0 then ldtETime := ldtFTime - DeltaFHF[m_pTable.m_sbyDeltaFH];
     move(ldtFTime,pDS.m_sbyInfo[0], szDT);
     move(ldtETime,pDS.m_sbyInfo[szDT], szDT);
     move(m_pTable.M_SQUERYMASK,pDS.m_sbyInfo[2*szDT], sizeof(int64));
     move(FSVMID,pDS.m_sbyInfo[2*szDT+sizeof(int64)], sizeof(int64));
     SendMsgData(BOX_L3_LME, 0, DIR_LHTOLM3, QL_START_FH_REQ, pDS);
    except
    end;
End;

procedure CQryScheduler.RunScheduler;
Begin
    if (m_dwCounter mod 10)=0 then
    Begin
     case FindTime of
       1 : if m_pTable.m_sQryScheduler<>QWR_QWERY_SRV then SetAction;
       2 : m_nGST.SettTime;
     End;
    End;
    m_dwCounter := m_dwCounter + 1;
    //m_nWPollTimer.Run;
End;
destructor CQryScheduler.Destroy;
begin
  if FL3QweryTree <> nil then FreeAndNil(FL3QweryTree);
  if m_nGST <> nil then FreeAndNil(m_nGST);
  inherited;
end;

end.
 