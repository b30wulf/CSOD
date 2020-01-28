unit knsl3addregion;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AdvToolBar, StdCtrls, ExtCtrls, AdvPanel, ImgList, AdvToolBarStylers,
  AdvAppStyler, Grids, BaseGrid, AdvGrid,knsl3regeditor,utlbox,utldatabase,utlconst,knsl5config;
type
  TNotifyEvent = procedure(Sender: TObject) of object;
  TTAddRegion = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    AdvPanel3: TAdvPanel;
    sgGrid: TAdvStringGrid;
    AdvFormStyler1: TAdvFormStyler;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    ImageList2: TImageList;
    AdvToolBar2: TAdvToolBar;
    AdvToolBarButton1: TAdvToolBarButton;
    AdvToolBarButton2: TAdvToolBarButton;
    AdvToolBarButton3: TAdvToolBarButton;
    AdvToolBarButton4: TAdvToolBarButton;
    AdvToolBarButton6: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvToolBarSeparator2: TAdvToolBarSeparator;
    AdvToolBarSeparator4: TAdvToolBarSeparator;
    cnlChngButt: TAdvToolBarButton;
    AdvToolBarButton5: TAdvToolBarButton;
    Label1: TLabel;
    procedure OnFormCreate(Sender: TObject);
    procedure OnSaveGrid(Sender: TObject);
    procedure OnSetGrid(Sender: TObject);
    procedure OnAddRow(Sender: TObject);
    procedure OnCloneRow(Sender: TObject);
    procedure OnDelRow(Sender: TObject);
    procedure OnDelAllRow(Sender: TObject);
    procedure OnSetEditReg(Sender: TObject);
    procedure OnFormResize(Sender: TObject);
    procedure OnClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure OnGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnCloseRegion(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    m_nRE : CL3RegEditor;
    FOnClose : TNotifyEvent;
    procedure SetEditGrid(var blState:Boolean;var btButt:TAdvToolBarButton;var sgGrid:TAdvStringGrid;blIsRow:Boolean);
  public
    { Public declarations }
    procedure OnInit;
  property OnCloseReg : TNotifyEvent read FOnClose write FOnClose;
  end;

var
    TAddRegion: TTAddRegion;

implementation

{$R *.DFM}

procedure TTAddRegion.OnFormCreate(Sender: TObject);
begin
    m_blCL3RegiEditor := False;
    m_nRE             := CL3RegEditor.Create;
    m_nRE.PsgGrid     := @sgGrid;
    m_nCF.m_nSetColor.PRegion       := @sgGrid;
    m_nCF.m_nSetColor.PRegionStyler := @AdvFormStyler1;
    m_nRE.Init;
end;
procedure TTAddRegion.OnInit;
Begin
    m_nRE.ExecSetGrid;
End;

procedure TTAddRegion.OnSaveGrid(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnSaveGrid;
end;

procedure TTAddRegion.OnSetGrid(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnSetGrid;
end;

procedure TTAddRegion.OnAddRow(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnAddRow;
end;

procedure TTAddRegion.OnCloneRow(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnCloneRow;
end;

procedure TTAddRegion.OnDelRow(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnDelRow;
end;

procedure TTAddRegion.OnDelAllRow(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnDelAllRow;
end;

procedure TTAddRegion.OnSetEditReg(Sender: TObject);
begin
    SetEditGrid(m_blCL3RegiEditor,cnlChngButt,sgGrid,True);
    m_nRE.SetEdit;
    if m_blCL3ChngEditor=True  then m_pDB.FixUspdEvent(0,0,EVU_CHANDR_ED_ON) else
    if m_blCL3ChngEditor=False then m_pDB.FixUspdEvent(0,0,EVU_CHANDR_ED_OF);
end;
procedure TTAddRegion.SetEditGrid(var blState:Boolean;var btButt:TAdvToolBarButton;var sgGrid:TAdvStringGrid;blIsRow:Boolean);
begin
    if blState=False then //Open
    Begin
     btButt.ImageIndex := 7;
     btButt.Hint       := 'Редактирование';
     blState           := True;
     sgGrid.Options    := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goEditing];
    End else
    if blState=True then //Close
    Begin
     btButt.ImageIndex := 6;
     btButt.Hint       := 'Отображение';
     blState           := False;
     if blIsRow=True  then sgGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goRowSelect{goEditing}] else
     if blIsRow=False then sgGrid.Options    := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goDrawFocusSelected,goColSizing];
    End;
end;

procedure TTAddRegion.OnFormResize(Sender: TObject);
begin
    if m_nRE<>Nil then m_nRE.OnFormResize;
end;

procedure TTAddRegion.OnClickCell(Sender: TObject; ARow, ACol: Integer);
begin
    m_nRE.OnClickGrid(Sender,ARow,ACol);
end;

procedure TTAddRegion.OnGetEditorType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
    m_nRE.OnGetType(Sender,ACol, ARow,AEditor);
end;

procedure TTAddRegion.OnCloseRegion(Sender: TObject;
  var Action: TCloseAction);
begin
    if Assigned(FOnClose) then FOnClose(Sender);
end;

end.
