unit knsl5events;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Grids, BaseGrid, AdvGrid, ImgList, ToolWin, jpeg,
  ExtCtrls,utlconst,utltypes,utldatabase,utlbox, Menus,knsl4connfrm,knsl4secman,
  asgprev, AdvPanel, AdvToolBar, AdvToolBarStylers, AdvAppStyler,knsl5config,knsl5tracer,
  AdvGlowButton, AdvMenus, AdvMenuStylers, AdvSmoothCalendar, AdvSplitter,
  paramchklist, IniFiles, AdvGroupBox, AdvOfficeButtons;

type
  TTL5Events = class(TForm)
    ImageListEvent1: TImageList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    AdvPreviewDialog1: TAdvPreviewDialog;
    AdvPreviewDialog2: TAdvPreviewDialog;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    Label5: TLabel;
    AdvToolBar1: TAdvToolBar;
    EventStyler: TAdvFormStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvPopupMenu1: TAdvPopupMenu;
    AdvPopupMenu2: TAdvPopupMenu;
    AdvPopupMenu3: TAdvPopupMenu;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    AdvGlowMenuButton1: TAdvGlowMenuButton;
    AdvGlowMenuButton2: TAdvGlowMenuButton;
    AdvGlowMenuButton3: TAdvGlowMenuButton;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Excell1: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    AdvPanel3: TAdvPanel;
    FsgGrid: TAdvStringGrid;
    AdvPanel4: TAdvPanel;
    AdvSplitter1: TAdvSplitter;
    dtPic2: TAdvSmoothCalendar;
    EventCheckList: TParamCheckList;
    dtPic1: TAdvSmoothCalendar;
    rbJrnlNumb: TAdvOfficeRadioGroup;
    procedure OnFormResize(Sender: TObject);
    procedure OnFormCreate(Sender: TObject);
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
    procedure OnEditMode(Sender: TObject);
    procedure OnGetCellColorEv(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnGetCellType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnSetEvents(Sender: TObject);
    procedure OnGetAllEvents(Sender: TObject);
    procedure OnGetEv0(Sender: TObject);
    procedure OnGetEv1(Sender: TObject);
    procedure OnGetEv3(Sender: TObject);
    procedure OnDelAllEvents(Sender: TObject);
    procedure OnLoadFromF(Sender: TObject);
    procedure OnChandgeEvent(Sender: TObject);
    procedure OnFix(Sender: TObject);
    procedure OnChandgeTime(Sender: TObject);
    procedure OnChandgeTime1(Sender: TObject);
    procedure OnLoadEvents(Sender: TObject);
    procedure OnGetEv4(Sender: TObject);
    procedure EventCheckListCheckClick(Sender: TObject);
    procedure AdvSplitter1Moved(Sender: TObject);
    procedure rbJrnlNumbClick(Sender: TObject);
  private
    { Private declarations }
    m_nCurrGroup : Integer;
    m_nIDIndex   : Integer;
    m_nColSumm   : Integer;
    m_blIsEdit   : Boolean;
    m_strCurrentDir : String;
    m_strCheckEv : array [0..3] of String;
    m_nEventList : TStringList;
    FIndex       : Integer;
    FCmdIndex    : Integer;
    FABOID       : Integer;
    FMID         : Integer;
    FPRID        : Integer;
    FTID         : Integer;
    FSVStatus    : Integer;
    FCLStatus    : Integer;
    FLocation    : Integer;
    FPHAddress   : Integer;
    //m_nEV        : array[0..2] of SEVENTSETTTAGS;
    procedure LoadCombo;        
    procedure RefreshGrid;
    function  GetEventString(nGroup,nEvent:Integer):String;
    procedure LoadSettings;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure GetGridRecord(var pTbl:SEVENTSETTTAG);
    procedure ExecSetEventGrid;
    procedure ExecEventGrid;
    procedure AddRecordToEventGrid(nIndex:Integer;var pTbl:SEVENTSETTTAG{;var pTable:SEVENTTAG});
    procedure AddEventGrid(nIndex:Integer;var pTbl:SEVENTTAG);
    procedure SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
    procedure OnLoadEvents_Old;
    procedure OnLoadEvents_Find;
    procedure EncodeStrToCheckList(var str : string);
    function  DecodeCheckListToStr:string;
    procedure UpdateCheckStrState;
    procedure UpdateCheckListState;
    procedure SaveCheckStateToFile;
  public
    procedure ViewData;
  public
    property PABOID   : Integer         read FABOID    write FABOID;
    property PMID     : Integer         read FMID      write FMID;
    property PPRID    : Integer         read FPRID     write FPRID;
    property PTID     : Integer         read FTID      write FTID;
    //property PsgCGrid : PTAdvStringGrid read FsgCGrid  write FsgCGrid;
    //property PPage    : TPageControl    read FPage     write FPage;
    property PIndex   : Integer         read FIndex    write FIndex;
    //function FixEvent(nGroup,nEvent:Integer):Boolean;
    { Public declarations }
  end;

var
  TL5Events: TTL5Events;
  m_blCreateEvents  : Boolean;

implementation

{$R *.DFM}

procedure TTL5Events.OnFormCreate(Sender: TObject);
var Fl   : TINIFile;
begin
     m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
     Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\' + 'USPD_Config.ini');
       m_strCheckEv[0] := Fl.ReadString('EVENTCONFIG', 'm_nCheckEv1', '0');
       m_strCheckEv[1] := Fl.ReadString('EVENTCONFIG', 'm_nCheckEv2', '0');
       m_strCheckEv[2] := Fl.ReadString('EVENTCONFIG', 'm_nCheckEv3', '0');
       m_strCheckEv[3] := Fl.ReadString('EVENTCONFIG', 'm_nCheckEv4', '0');
       m_nCurrGroup    := Fl.ReadInteger('EVENTCONFIG', 'm_nLastGroup', 0);
     Fl.Destroy;
     m_blIsEdit   := False;
     m_nIDIndex   := 1;
     Caption      := 'События: Отображение';

     m_nEventList    := TStringList.Create;
     dtPic1.SelectedDate := Now;
     dtPic2.SelectedDate := Now;
     LoadCombo;
     LoadSettings;
     FsgGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goRowSelect];
     FsgGrid.GridLineColor := $00E5D7D0;
     //if m_blIsEdit=True  then ExecSetEventGrid else
     //if m_blIsEdit=False then ExecEventGrid;
     //
     Self.WindowState := wsMaximized;
     OnFormResize(Self);

end;
procedure TTL5Events.LoadSettings;
var
      mCL                    :  SCOLORSETTTAG;
Begin
    m_pDB.GetMeterLocation(FMID,FLocation,FPHAddress);
    m_pDB.GetEventsTable(0,m_nEV[0]);
    m_pDB.GetEventsTable(1,m_nEV[1]);
    m_pDB.GetEventsTable(2,m_nEV[2]);
  {  m_pDB.GetUspdEventALL(0,m_nEVS[0]);
    m_pDB.GetUspdEventALL(1,m_nEVS[1]);
    m_pDB.GetUspdEventALL(2,m_nEVS[2]); }
    //FsgGrid.Color       := KNS_NCOLOR;
    //FCmdIndex           := -1;
    FsgGrid.ColCount    := 9;
    FsgGrid.RowCount    := 40;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'Активность';
    FsgGrid.Cells[2,0]  := 'Дата';
    FsgGrid.Cells[3,0]  := 'Время';
    FsgGrid.Cells[4,0]  := 'Группа';
    FsgGrid.Cells[5,0]  := 'Код ';
    FsgGrid.Cells[6,0]  := 'Пользователь';
    FsgGrid.Cells[7,0]  := 'Название';
    FsgGrid.Cells[8,0]  := 'Описание';
    FsgGrid.ColWidths[0]:= 35;
    if m_blIsEdit=False Then
     Begin
      FsgGrid.ColWidths[1] := 0;
      m_nColSumm := 0;
     End else
     Begin
      FsgGrid.ColWidths[1] := 45;
      m_nColSumm := 45;
     End;
     FsgGrid.ColWidths[2]:= 70;
     FsgGrid.ColWidths[3]:= 70;
     FsgGrid.ColWidths[4]:= 45;
     FsgGrid.ColWidths[5]:= 35;
     FsgGrid.ColWidths[6]:= 100;
     //FsgGrid.ColWidths[7]:= 80;
     FsgGrid.ColWidths[8]:= 40;
     m_nColSumm := m_nColSumm + 2*70+45+35+100;
    // SetHigthGrid(FsgGrid,19);
     //   init graph
    mCL.m_swCtrlID := CL_TREE_CONF;
    m_pDB.GetColorTable(mCL);
    nSizeFont := mCL.m_swFontSize;
    SetHigthGrid(FsgGrid,nSizeFont+17);
    m_nCF.m_nSetColor.PEventStyler       := @EventStyler;
    m_nCF.m_nSetColor.SetAllStyle(m_nCF.StyleForm.ItemIndex{+1});
    OnFormResize(self);
End;
procedure TTL5Events.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
    for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TTL5Events.OnFormResize(Sender: TObject);
Var
     i : Integer;
begin
   AdvPanel3.Width   := trunc(Self.Width * 0.65);
   dtPic1.Left       := 0;
   dtPic1.Width      := AdvPanel4.Width div 2;
   dtPic2.Width      := AdvPanel4.Width div 2;
   dtPic2.Left       := dtPic1.Left + dtPic1.Width;
   rbJrnlNumb.Left   := 0;
   rbJrnlNumb.Width  := AdvPanel4.Width;
   rbJrnlNumb.Top    := dtPic1.Height;
   EventCheckList.Left := 0;
   EventCheckList.Top := dtPic1.Height + rbJrnlNumb.Height;
   EventCheckList.Width := AdvPanel4.Width;
   EventCheckList.Height := AdvPanel4.Height - dtPic1.Height - rbJrnlNumb.Height;
   FsgGrid.ColWidths[0]  := trunc(FsgGrid.Width*0.05);
   FsgGrid.ColWidths[1]  := trunc(FsgGrid.Width*0.0);
   FsgGrid.ColWidths[2]  := trunc(FsgGrid.Width*0.1);
   FsgGrid.ColWidths[3]  := trunc(FsgGrid.Width*0.1);
   FsgGrid.ColWidths[4]  := trunc(FsgGrid.Width*0.0);
   FsgGrid.ColWidths[5]  := trunc(FsgGrid.Width*0.0);
   FsgGrid.ColWidths[6]  := trunc(FsgGrid.Width*0.1);
   FsgGrid.ColWidths[7]  := trunc(FsgGrid.Width*0.35);
   FsgGrid.ColWidths[8]  := trunc(FsgGrid.Width*0.28);

     //for i:=7 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-m_nColSumm-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-6));
end;
procedure TTL5Events.OnCloseForm(Sender: TObject;
  var Action: TCloseAction);
begin
     //m_blCreateEvents  := False;
     if m_nEventList<>Nil then FreeAndNil(m_nEventList);
     Action := caFree;
     m_nCF.m_nSetColor.PEventStyler :=nil;
     //Action := caFree;
end;
procedure TTL5Events.ViewData;
Begin
     if FIndex=$ffff then
     begin
       case m_nCurrGroup of
         0 : OnGetEv0(self);
         3 : OnGetEv4(self);
         else
           OnGetEv0(self);
       end;
     end
     else
     begin
       case m_nCurrGroup of
         1 : OnGetEv1(self);
         2 : OnGetEv3(self);
         else
           OnGetEv3(self);
       end;
     end;
End;
procedure TTL5Events.OnEditMode(Sender: TObject);
begin
    if m_blIsEdit=False then
    Begin
     m_blIsEdit := True;
     //tbSaveButt.Visible := True;
     //Caption := ':Редактирование';
     FsgGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goEditing];
     LoadSettings;
    End else
    if m_blIsEdit=True then
    Begin
     //tbSaveButt.Visible := False;
     //lbDataCaption.Caption := 'Отображение данных';
     //Caption := 'События: Отображение';
     FsgGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goRowSelect];
     m_blIsEdit := False;
     LoadSettings;
    End;
    if m_blIsEdit=True  then ExecSetEventGrid else
    if m_blIsEdit=False then ExecEventGrid;
end;
{
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'Активность';
    FsgGrid.Cells[2,0]  := 'Дата';
    FsgGrid.Cells[3,0]  := 'Время';
    FsgGrid.Cells[4,0]  := 'Группа';
    FsgGrid.Cells[5,0]  := 'Код ';
    FsgGrid.Cells[6,0]  := 'Пользователь';
    FsgGrid.Cells[7,0]  := 'Название';
    FsgGrid.Cells[8,0]  := 'Описание';
}

procedure TTL5Events.OnGetCellColorEv(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    //AFont.Name := 'Times New Roman';
    with (Sender AS TAdvStringGrid)  do
    Begin
     if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and (not(gdSelected in AState) or (gdFocused in AState)) then
     begin
    //  if (ACol<>0)and(ARow<>0) then ABrush.Color := clTeal;
     end;
    if (ARow=0)or(ACol=0) then
    Begin
     AFont.Size  := 9;
     AFont.Style := [fsBold];
     AFont.Color := clBlack;
    End;
     if (ARow<>0) and (ACol<>0)then
      Begin
        //ABrush.Color := $00E5D7D0; 
        AFont.Size  := 10;
        //AFont.Style := [fsItalic];
        case ACol of
         1          : AFont.Color := clBlack;{clLime; }
         2,3        : AFont.Color := clBlack;{clAqua;}
         4,5        : AFont.Color := clBlack;{clLime;}
         6          : AFont.Color := clBlack;{clYellow;}
         7          : AFont.Color := clBlack;
        End;
      End;
    End;
end;

procedure TTL5Events.OnGetCellType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
with FsgGrid do
    case ACol of
     1:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;

procedure TTL5Events.OnSetEvents(Sender: TObject);
Var
    i : Integer;
    pTbl:SEVENTSETTTAG;
Begin
    if m_blIsEdit=True then
    Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[m_nIDIndex,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     m_pDB.AddEventTable(pTbl);
    End;
    ExecSetEventGrid;
    End;
end;
{
 FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'Активность';
    FsgGrid.Cells[2,0]  := 'Дата';
    FsgGrid.Cells[3,0]  := 'Время';
    FsgGrid.Cells[4,0]  := 'Группа';
    FsgGrid.Cells[5,0]  := 'Код ';
    FsgGrid.Cells[6,0]  := 'Пользователь';
    FsgGrid.Cells[7,0]  := 'Название';
}
procedure TTL5Events.GetGridRecord(var pTbl:SEVENTSETTTAG);
Var
    i : Integer;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[4,i] := '0';
     if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[5,i] := '0';
     if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[7,i] := 'Event '+IntToStr(i);
     if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[1,i] := 'Да';
     m_swGroupID    := StrToInt(FsgGrid.Cells[4,i]);
     m_swEventID    := StrToInt(FsgGrid.Cells[5,i]);
     m_schEventName := FsgGrid.Cells[7,i];
     m_sbyEnable    := m_nEsNoList.IndexOf(FsgGrid.Cells[1,i]);
    End;
End;
procedure TTL5Events.ExecEventGrid;
Var
    pTbl : SEVENTTAGS;
    i    : Integer;
    res  : boolean;
Begin
    res := false;
    FsgGrid.ClearNormalCells;
    if EventCheckList.Checked[0] then
//      res := m_pDB.GetFixEventsTable(FABOID,m_nCurrGroup,-1,FIndex,dtPic1.SelectedDate,dtPic2.SelectedDate,pTbl)
    else
      res := true; //m_pDB.GetFixEventsTableFromStr(m_nCurrGroup,FIndex,m_strCheckEv[m_nCurrGroup],dtPic1.SelectedDate,dtPic2.SelectedDate,pTbl);
    if res then
    Begin
     FsgGrid.RowCount := pTbl.Count+1;
     for i:=0 to pTbl.Count-1 do
     AddEventGrid(i,pTbl.Items[i]);
    End;
End;
procedure TTL5Events.ExecSetEventGrid;
Var
    pTbl : SEVENTSETTTAGS;
    pTable :  SEVENTTAGS;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    if (m_nCurrGroup<>-1)and(m_nCurrGroup<4) then m_pDB.GetEventsTable(m_nCurrGroup,m_nEV[m_nCurrGroup]);
 //   if (m_nCurrGroup<>-1)and(m_nCurrGroup<3) then m_pDB.GetUspdEventALL(m_nCurrGroup,m_nEVS[m_nCurrGroup]);
    if m_pDB.GetEventsTable(m_nCurrGroup,pTbl)=True then
    Begin
     FsgGrid.RowCount := pTbl.Count+1;
 //    if m_pDB.GetUspdEventALL(m_nCurrGroup,pTable)=True then
//     begin
     for i:=0 to pTbl.Count-1 do
     AddRecordToEventGrid(i,pTbl.Items[i]{,pTable.Items[i]});
    // end;
    End;
End;
procedure TTL5Events.AddRecordToEventGrid(nIndex:Integer;var pTbl:SEVENTSETTTAG{;var pTable:SEVENTTAG});
Var
    nY : Integer;
    nVisible : Integer;
Begin
    nY := nIndex+1;
    nVisible := round(FsgGrid.Height/21);
    if nY>FsgGrid.RowCount then FsgGrid.RowCount := FsgGrid.RowCount+50;
    with pTbl do Begin
     FsgGrid.Cells[0,nY] := IntToStr(nY);
     FsgGrid.Cells[1,nY] := m_nEsNoList.Strings[m_sbyEnable];
     FsgGrid.Cells[2,nY] := DateToStr(Now);
     FsgGrid.Cells[3,nY] := TimeToStr(Now);
     FsgGrid.Cells[4,nY] := IntToStr(m_swGroupID);
     FsgGrid.Cells[5,nY] := IntToStr(m_swEventID);
     FsgGrid.Cells[6,nY] := ConnForm.GetUser;
     FsgGrid.Cells[7,nY] := m_schEventName;
    End;
     {with pTable do Begin
     FsgGrid.Cells[8,nY] := FloatToStr(m_swDescription);
     end; }
End;
procedure TTL5Events.AddEventGrid(nIndex:Integer;var pTbl:SEVENTTAG);
Var
    nY : Integer;
    nVisible : Integer;
Begin
    nY := nIndex+1;
    nVisible := round(FsgGrid.Height/21);
    if nY>FsgGrid.RowCount then FsgGrid.RowCount := FsgGrid.RowCount+50;
    with pTbl do Begin
     FsgGrid.Cells[0,nY] := IntToStr(nY);
     FsgGrid.Cells[1,nY] := m_nEsNoList.Strings[m_sbyEnable];
     FsgGrid.Cells[2,nY] := DateToStr(m_sdtEventTime);
     FsgGrid.Cells[3,nY] := TimeToStr(m_sdtEventTime);
     FsgGrid.Cells[4,nY] := IntToStr(m_swGroupID);
     FsgGrid.Cells[5,nY] := IntToStr(m_swEventID);
     FsgGrid.Cells[6,nY] := m_sUser;
     FsgGrid.Cells[7,nY] := GetEventString(m_swGroupID,m_swEventID);
     if ((m_swEventID = EVM_START_CORR) and (m_swGroupID = 2)) and (m_swDescription <> 0) then
       FsgGrid.Cells[8,nY] := 'Время счетчика: ' + DateTimeToStr(m_swDescription)
     else if ((m_swEventID = EVM_FINISH_CORR) and (m_swGroupID = 2)) or ((m_swEventID = EVH_CORR_MONTH) and (m_swGroupID = 0))  then
       FsgGrid.Cells[8,nY] := 'Общая коррекция: ' + FloatToStr(trunc(abs(m_swDescription))) + ' сек.'
     else if ((m_swEventID = EVH_FINISH_CORR) and (m_swGroupID = 0))  then
       FsgGrid.Cells[8,nY] := 'Коррекция на ' + FloatToStr(trunc(abs(m_swDescription/1000))) + ' сек. ' +
                              FloatToStr(trunc(frac(abs(m_swDescription)/1000)*1000)) + ' мс'
     else
       FsgGrid.Cells[8,nY] := FloatToStr(trunc(abs(m_swDescription)));
    End;
End;

procedure TTL5Events.OnGetAllEvents(Sender: TObject);
begin
    if m_blIsEdit=True then m_nCurrGroup := -1 else
    if FIndex=$ffff then m_nCurrGroup := 0;
    RefreshGrid
end;
{var Fl   : TINIFile;
begin

     m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
     Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\' + 'USPD_Config.ini');
       m_strCheckEv[0] := Fl.ReadString('EVENTCONFIG', 'm_nCheckEv1', '0');
       m_strCheckEv[1] := Fl.ReadString('EVENTCONFIG', 'm_nCheckEv2', '0');
       m_strCheckEv[2] := Fl.ReadString('EVENTCONFIG', 'm_nCheckEv3', '0');
       m_strCheckEv[3] := Fl.ReadString('EVENTCONFIG', 'm_nCheckEv4', '0');
       m_LastGroup     := Fl.ReadInteger('EVENTCONFIG', 'm_nLastGroup', 0);
     Fl.Destroy;     }
procedure TTL5Events.OnGetEv0(Sender: TObject);
var Fl   : TINIFile;
begin
   // if FIndex=$ffff then
    Begin
     rbJrnlNumb.ItemIndex := 0;
     rbJrnlNumb.Controls[0].Enabled := true;
     rbJrnlNumb.Controls[1].Enabled := false;
     rbJrnlNumb.Controls[2].Enabled := false;
     rbJrnlNumb.Controls[3].Enabled := true;
     AdvPopupMenu3.Items[0].Enabled := true;
     AdvPopupMenu3.Items[1].Enabled := false;
     AdvPopupMenu3.Items[2].Enabled := false;
     AdvPopupMenu3.Items[3].Enabled := true;

     Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\' + 'USPD_Config.ini');
     Fl.WriteInteger('EVENTCONFIG', 'm_nLastGroup', 0);
     Fl.Destroy;
     m_nCurrGroup := 0;
     LoadCombo;
     RefreshGrid
    End;
end;

procedure TTL5Events.OnGetEv1(Sender: TObject);
var Fl   : TINIFile;
begin
  //  if FIndex<>$ffff then
    Begin
     rbJrnlNumb.Controls[0].Enabled := false;
     rbJrnlNumb.Controls[1].Enabled := true;
     rbJrnlNumb.Controls[2].Enabled := true;
     rbJrnlNumb.Controls[3].Enabled := false;
     AdvPopupMenu3.Items[0].Enabled := false;
     AdvPopupMenu3.Items[1].Enabled := true;
     AdvPopupMenu3.Items[2].Enabled := true;
     AdvPopupMenu3.Items[3].Enabled := false;
     rbJrnlNumb.ItemIndex := 1;
     Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\' + 'USPD_Config.ini');
     Fl.WriteInteger('EVENTCONFIG', 'm_nLastGroup', 1);
     Fl.Destroy;
     m_nCurrGroup := 1;
     LoadCombo;
     RefreshGrid
    End;
end;

procedure TTL5Events.OnGetEv3(Sender: TObject);
var Fl   : TINIFile;
begin
  //  if FIndex<>$ffff then
    Begin
     rbJrnlNumb.ItemIndex := 2;
     rbJrnlNumb.Controls[0].Enabled := false;
     rbJrnlNumb.Controls[1].Enabled := true;
     rbJrnlNumb.Controls[2].Enabled := true;
     rbJrnlNumb.Controls[3].Enabled := false;
     AdvPopupMenu3.Items[0].Enabled := false;
     AdvPopupMenu3.Items[1].Enabled := true;
     AdvPopupMenu3.Items[2].Enabled := true;
     AdvPopupMenu3.Items[3].Enabled := false;

     Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\' + 'USPD_Config.ini');
     Fl.WriteInteger('EVENTCONFIG', 'm_nLastGroup', 2);
     Fl.Destroy;
     m_nCurrGroup := 2;
     LoadCombo;
     RefreshGrid
    End;
end;

procedure TTL5Events.OnGetEv4(Sender: TObject);
var Fl   : TINIFile;
Begin
    //if FIndex=$ffff then
    Begin
     rbJrnlNumb.ItemIndex := 3;
     rbJrnlNumb.Controls[0].Enabled := true;
     rbJrnlNumb.Controls[1].Enabled := false;
     rbJrnlNumb.Controls[2].Enabled := false;
     rbJrnlNumb.Controls[3].Enabled := true;
     AdvPopupMenu3.Items[0].Enabled := true;
     AdvPopupMenu3.Items[1].Enabled := false;
     AdvPopupMenu3.Items[2].Enabled := false;
     AdvPopupMenu3.Items[3].Enabled := true;

     Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\' + 'USPD_Config.ini');
     Fl.WriteInteger('EVENTCONFIG', 'm_nLastGroup', 3);
     Fl.Destroy;
     m_nCurrGroup := 3;
     LoadCombo;
     RefreshGrid;
    End;
End;

procedure TTL5Events.OnDelAllEvents(Sender: TObject);
begin
{    if not m_pDB.IsCoverOpen then
    begin
      MessageDlg('Крышка УСПД закрыта. Данные не могут быть удалены!', mtWarning,[mbOk, mbCancel],0);
      exit;
    end;   }
    if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
    Begin
    if m_nCurrGroup=-1 then
    Begin
     if MessageDlg('Удалить все события?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
//         m_pDB.DelFixEvents(dtPic1.SelectedDate, dtPic2.SelectedDate, m_nCurrGroup);
//         m_pDB.FixUspdEvent(0,3,EVS_DEL_EVENT_JRNL);
     End;
    End
     else
    if MessageDlg('Удалить события группы:'+IntToStr(m_nCurrGroup)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
{        if (m_nCurrGroup = 0) or (m_nCurrGroup = 3) then
//          m_pDB.DelFixEvents(dtPic1.SelectedDate, dtPic2.SelectedDate, m_nCurrGroup)
        else
                               m_pDB.DelFixEventsTable(m_nCurrGroup,-1,FIndex,dtPic1.SelectedDate, dtPic2.SelectedDate);
//        m_pDB.FixUSPDEvent(0,3,EVS_DEL_EVENT_JRNL); }
    End;
    RefreshGrid;
    End;
end;

procedure TTL5Events.OnLoadFromF(Sender: TObject);
Var
    i : Integer;
Begin
    if m_blIsEdit=True then
    Begin
    m_nEventList.Clear;
    if m_nCurrGroup=-1 then exit;
    if m_nCurrGroup=0 then m_nEventList.LoadFromFile(m_strCurrentDir+'SettEvent0.dat');
    if m_nCurrGroup=1 then m_nEventList.LoadFromFile(m_strCurrentDir+'SettEvent1.dat');
    if m_nCurrGroup=2 then m_nEventList.LoadFromFile(m_strCurrentDir+'SettEvent2.dat');
    if m_nCurrGroup=3 then m_nEventList.LoadFromFile(m_strCurrentDir+'SettEvent3.dat');
    for i:=0 to m_nEventList.Count-1 do
    Begin
     FsgGrid.RowCount := m_nEventList.Count+1;
     FsgGrid.Cells[1,i+1] := 'Да';
     FsgGrid.Cells[2,i+1] := DateToStr(Now);
     FsgGrid.Cells[3,i+1] := TimeToStr(Now);
     FsgGrid.Cells[4,i+1] := IntToStr(m_nCurrGroup);
     FsgGrid.Cells[5,i+1] := IntToStr(i);
     FsgGrid.Cells[6,i+1] := ConnForm.GetUser;
     FsgGrid.Cells[7,i+1] := m_nEventList.Strings[i];
    End;
    End;
end;
procedure TTL5Events.LoadCombo;
Var
    i : Integer;
Begin
//    cbEvents.Items.Clear;
//    cbEvents.Items.Add('Все');
//    if (m_nCurrGroup<>-1)and(m_nCurrGroup<4) then
//    for i:=0 to m_nEV[m_nCurrGroup].Count-1 do
//    cbEvents.Items.Add(m_nEV[m_nCurrGroup].Items[i].m_schEventName);
//    cbEvents.ItemIndex := 0;

    EventCheckList.Items.Clear;
    EventCheckList.Items.Add('Все');
    if (m_nCurrGroup<>-1)and(m_nCurrGroup<4) then
      for i:=0 to m_nEV[m_nCurrGroup].Count-1 do
      begin
        EventCheckList.Items.Add(m_nEV[m_nCurrGroup].Items[i].m_schEventName);
      end;
    UpdateCheckListState;
End;


function TTL5Events.GetEventString(nGroup,nEvent:Integer):String;
Var
    nEV : Integer;
    i:integer;
Begin
    if (nGroup<>-1)and(nGroup<4) then
    Begin
for i := 0 to m_nEV[nGroup].Count -1 do
   begin
   if ((m_nEV[nGroup].Items[i].m_swGroupID = nGroup)and(m_nEV[nGroup].Items[i].m_swEventID = nEvent)and(m_nEV[nGroup].Items[i].m_sbyEnable=1)) then
   Result := m_nEV[nGroup].Items[i].m_schEventName;
   end;
    End else
    Result := 'Unknown Event';
End;
procedure TTL5Events.OnChandgeEvent(Sender: TObject);
begin
    ExecEventGrid;
end;
{
function TTL5Events.FixEvent(nGroup,nEvent:Integer):Boolean;
Var
    pTable:SEVENTTAG;
Begin
    Result := False;
    if (nGroup=-1) or (nGroup>3) or (nEvent=-1) then exit;
    pTable.m_swGroupID    := nGroup;
    pTable.m_swEventID    := nEvent;
    pTable.m_sdtEventTime := Now;
    pTable.m_sUser        := ConnForm.GetUser;
    pTable.m_sbyEnable    := 1;
    if m_nEV[nGroup].Items[nEvent].m_sbyEnable=1 then
    Begin
     m_pDB.AddFixEventTable(pTable);
     Result := True;
    End else
    Result := True;
End;
}
procedure TTL5Events.RefreshGrid;
Begin
    if m_blIsEdit=True  then ExecSetEventGrid else
    if m_blIsEdit=False then ExecEventGrid;
End;
procedure TTL5Events.OnFix(Sender: TObject);
Var
    str,strCaption : String;
begin
    strCaption := Caption;
    if strCaption<>'' then
    Begin
     strCaption := StringReplace(strCaption,':','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'.','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'"','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'-','_',[rfReplaceAll]);
     str := ExtractFilePath(Application.ExeName)+'ExportData\События_'+strCaption+'.xls';
     FsgGrid.SaveToXLS(str,false);
     SetTexSB(0,'Экспорт в Excel: '+str);
    End;
    //if FIndex=$ffff then
    //m_pDB.FixUspdEvent(0,0,GetEventCode) else
    //m_pDB.FixMeterEvent(m_nCurrGroup,GetEventCode,FIndex, 0, Now);
    //RefreshGrid;
    {
    FsgGrid.PrintSettings.Centered    := true;
    FsgGrid.PrintSettings.Borders     := pbSingle;
    AdvPreviewDialog1.Grid := FsgGrid;
    AdvPreviewDialog1.PreviewTop := 140;
    AdvPreviewDialog1.Execute;
    }
end;

procedure TTL5Events.OnChandgeTime(Sender: TObject);
begin
    dtPic1.SelectedDate := dtPic2.SelectedDate;
    ExecEventGrid;
    //OnGetAllEvents(self);
end;

procedure TTL5Events.OnChandgeTime1(Sender: TObject);
begin
    if dtPic1.SelectedDate > dtPic2.SelectedDate then
    dtPic2.SelectedDate := dtPic1.SelectedDate;
    ExecEventGrid;
    //OnGetAllEvents(self);
end;

{
    Date          := Now;
    szDT          := sizeof(TDateTime);
    pDS.m_swData0 := ABOID;
    pDS.m_swData1 := VMID;
    pDS.m_swData2 := MID;
    pDS.m_swData3 := GetRealPort(PRID);
    pDS.m_swData4 := MTR_LOCAL;
    move(dt_DateBegin, pDS.m_sbyInfo[0], szDT);
    move(dt_DateEnd, pDS.m_sbyInfo[szDT], szDT);
    SendMsgData(BOX_LOAD, pDS.m_swData2, DIR_LHTOLM3, QL_LOAD_EVENT_ONE_REQ, pDS);
    FIndex       : Integer;
    FCmdIndex    : Integer;
    FMID         : Integer;
    FPRID        : Integer;
    FTID         : Integer;

  QFH_JUR_EN                   = $0000000000008000;
  QFH_JUR_0                    = $0000000000010000;
  QFH_JUR_1                    = $0000000000020000;
  QFH_JUR_2                    = $0000000000040000;
  QFH_JUR_3                    = $0000000000080000;

}
procedure TTL5Events.OnLoadEvents(Sender: TObject);
begin
    if MessageDlg('Запросить события из устройства?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
    case m_nCF.QueryType of
          QWR_EQL_TIME,QWR_QWERY_SHED : OnLoadEvents_Old;
          QWR_FIND_SHED               : OnLoadEvents_Find;
          QWR_QWERY_SRV               : OnLoadEvents_Find;
    End;
    End;
end;
procedure TTL5Events.OnLoadEvents_Find;
Var
    szDT : Integer;
    pDS  : CMessageData;
    nJIM : int64;
begin
    nJIM := 0;
    case m_nCurrGroup of
         0 : nJIM := (QFH_JUR_EN)or(QFH_JUR_0);
         1 : nJIM := (QFH_JUR_EN)or(QFH_JUR_1);
         2 : nJIM := (QFH_JUR_EN)or(QFH_JUR_2);
         3 : nJIM := (QFH_JUR_EN)or(QFH_JUR_3);
     End;
     szDT := sizeof(TDateTime);
     pDS.m_swData0 := FABOID;
     pDS.m_swData1 := FIndex;
     pDS.m_swData2 := FMID;
     pDS.m_swData3 := FPRID;
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     Move(dtPic2.SelectedDate,pDS.m_sbyInfo[0]   ,szDT);
     Move(dtPic1.SelectedDate,pDS.m_sbyInfo[szDT],szDT);
     Move(nJIM,pDS.m_sbyInfo[2*szDT],sizeof(int64));
     //if m_blIsRemCrc=True then Begin SendRemCrcQry(FPRID,pDS);exit; End;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_START_FH_REQ,pDS);
end;
procedure TTL5Events.OnLoadEvents_Old;
Var
     szDT : Integer;
     pDS  : CMessageData;
     nJIM : int64;
     nSH  : Integer;
begin
     szDT := sizeof(TDateTime);
     nJIM := 0;
     nSH  := 0;
     case m_nCurrGroup of
         0 : nJIM := (QFH_JUR_EN)or(QFH_JUR_0);
         1 : nJIM := (QFH_JUR_EN)or(QFH_JUR_1);
         2 : nJIM := (QFH_JUR_EN)or(QFH_JUR_2);
         3 : nJIM := (QFH_JUR_EN)or(QFH_JUR_3);
     End;
     pDS.m_swData0 := m_nCurrGroup;
     pDS.m_swData1 := FIndex;
     pDS.m_swData3 := 0;
     if (m_blIsLocal=True)and(m_blIsSlave=True) then FLocation := MTR_LOCAL;
     if (m_blIsLocal=False)then FLocation := MTR_REMOTE else FLocation := MTR_LOCAL;
     pDS.m_swData4 := FLocation;
     pDS.m_swData2 := pDS.m_swData4;
     Move(dtPic1.SelectedDate,pDS.m_sbyInfo[0]   ,szDT);
     Move(dtPic2.SelectedDate,pDS.m_sbyInfo[szDT],szDT);
     Move(nJIM,pDS.m_sbyInfo[2*szDT],sizeof(int64));
     if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SendRemCrcQry(FPRID,pDS);exit; End;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
     SendMsgData(BOX_L3_LME,FMID,DIR_LHTOLM3,QL_LOAD_EVENTS_REQ,pDS);
end;
procedure TTL5Events.SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
Begin
    FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
    pDS.m_swData0 := 0;
    pDS.m_swData1 := -1;
    move(pDS.m_swData0,m_nTxMsg.m_sbyInfo[6], 4);
    move(pDS.m_swData1,m_nTxMsg.m_sbyInfo[10],4);
    move(pDS.m_swData2,m_nTxMsg.m_sbyInfo[14],4);
    move(pDS.m_swData3,m_nTxMsg.m_sbyInfo[18],4);
    move(pDS.m_sbyInfo[0],m_nTxMsg.m_sbyInfo[26],sizeof(TDateTime)*2);
    move(pDS.m_sbyInfo[sizeof(TDateTime)*2],m_nTxMsg.m_sbyInfo[26+sizeof(TDateTime)*2],sizeof(int64));
    //CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (34+16+1)+4, $FF04);
    //CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (34+16+1)+4);
    if m_blIsRemCrc=True then
    Begin
     CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (36+16+1)+4, $FF04);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (36+16+1)+4);
    End else
    if m_blIsRemEco=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := 204;
     wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 36+16);
     m_nTxMsg.m_sbyInfo[36+16] := Lo(wCRC);
     m_nTxMsg.m_sbyInfo[36+16+1] := Hi(wCRC);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (36+16+2));
    End;
    if m_blIsRemC12=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := $FA;
     m_nTxMsg.m_sbyInfo[2] := 1;
     CRC_C12(m_nTxMsg.m_sbyInfo[0], 36+16+2);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (36+16+2));
    End;
    {
    if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
    begin
      //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
      exit;
    end;
    fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
    }
    TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:',@m_nTxMsg);
    FPUT(BOX_L1, @m_nTxMsg);
End;

procedure TTL5Events.EventCheckListCheckClick(Sender: TObject);
begin
   UpdateCheckStrState;
   SaveCheckStateToFile;
   ExecEventGrid;
end;

procedure TTL5Events.AdvSplitter1Moved(Sender: TObject);
begin
   OnFormResize(Self);
end;

procedure TTL5Events.rbJrnlNumbClick(Sender: TObject);
begin
   case rbJrnlNumb.ItemIndex of
     0 : OnGetEv0(Sender);
     1 : OnGetEv1(Sender);
     2 : OnGetEv3(Sender);
     3 : OnGetEv4(Sender);
   end;
end;

procedure TTL5Events.EncodeStrToCheckList(var str : string);
var i, Ind : integer;
    tstr   : string;
begin
   EventCheckList.Visible := false;
   tstr := '';
   for i := 1 to Length(str) do
   begin
     if str[i] = ',' then
       if (tstr <> '') then
       begin
         Ind  := StrToInt(tstr) + 1;

         if (Ind >= 0) and (Ind < EventCheckList.Items.Count) then
           EventCheckList.Checked[Ind] := true;

         tstr := '';
       end;
     if ((str[i] >= '0') and (str[i] <= '9')) or (str[i] = '-') then
       tstr := tstr + str[i];
   end;
   if (tstr <> '') then
   begin
     Ind  := StrToInt(tstr) + 1;
     if (Ind >= 0) and (Ind < EventCheckList.Items.Count) then
       EventCheckList.Checked[Ind] := true;
     tstr := '';
   end;
   EventCheckList.Visible := true;
end;

function TTL5Events.DecodeCheckListToStr:string;
var i    : integer;
begin
   Result := '';
   for i := 0 to EventCheckList.Items.Count - 1 do
     if EventCheckList.Checked[i] then
        Result := Result + IntToStr(i-1) + ',';
end;

procedure TTL5Events.UpdateCheckStrState;
begin
   m_strCheckEv[m_nCurrGroup] := DecodeCheckListToStr;
end;

procedure TTL5Events.UpdateCheckListState;
begin
   EncodeStrToCheckList(m_strCheckEv[m_nCurrGroup]);
end;

procedure TTL5Events.SaveCheckStateToFile;
var Fl   : TINIFile;
begin
   Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\' + 'USPD_Config.ini');
     Fl.WriteString('EVENTCONFIG','m_nCheckEv1', m_strCheckEv[0]);
     Fl.WriteString('EVENTCONFIG','m_nCheckEv2', m_strCheckEv[1]);
     Fl.WriteString('EVENTCONFIG','m_nCheckEv3', m_strCheckEv[2]);
     Fl.WriteString('EVENTCONFIG','m_nCheckEv4', m_strCheckEv[3]);
   Fl.Destroy;
end;

end.
