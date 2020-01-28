unit knsl3addregions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, BaseGrid, AdvGrid, AdvToolBar, ExtCtrls, AdvPanel,
  ImgList, AdvAppStyler, AdvToolBarStylers,knsl3regeditor,utlbox,utldatabase,utlconst,knsl5config;

type
  TNotifyEvent = procedure(Sender: TObject) of object;
  TTAddRegions = class(TForm)
    AdvPanelStyler1: TAdvPanelStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvFormStyler1: TAdvFormStyler;
    ImageList2: TImageList;
    AdvPanel1: TAdvPanel;
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
    AdvPanel3: TAdvPanel;
    sgGrid: TAdvStringGrid;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    procedure OnFormCreate(Sender: TObject);
    procedure OnSaveGrid(Sender: TObject);
    procedure OnSetGrid(Sender: TObject);
    procedure OnAddRow(Sender: TObject);
    procedure OnCloneRow(Sender: TObject);
    procedure OnDelRow(Sender: TObject);
    procedure OnDelAllRow(Sender: TObject);
    procedure OnSetEditReg(Sender: TObject);
    procedure OnCloseRegion(Sender: TObject; var Action: TCloseAction);
    procedure OnFormResize(Sender: TObject);
    procedure OnGetType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnClockCell(Sender: TObject; ARow, ACol: Integer);
  private
    { Private declarations }
    m_nRE : CL3RegEditor;
    FOnClose : TNotifyEvent;
    procedure SetEditGrid(var blState:Boolean;var btButt:TAdvToolBarButton;var sgGrid:TAdvStringGrid;blIsRow:Boolean);
  public
    { Public declarations }
    procedure OnInit;
    destructor Destroy; override;
  property OnCloseReg : TNotifyEvent read FOnClose write FOnClose;
  end;

var
  TAddRegions: TTAddRegions;

implementation

{$R *.DFM}

procedure TTAddRegions.OnFormCreate(Sender: TObject);
begin
    m_blCL3RegiEditor := False;
    m_nRE             := CL3RegEditor.Create;
    m_nRE.PsgGrid     := @sgGrid;
    m_nCF.m_nSetColor.PRegion       := @sgGrid;
    m_nCF.m_nSetColor.PRegionStyler := @AdvFormStyler1;
    m_nRE.Init;
end;
procedure TTAddRegions.OnInit;
Begin
    m_nRE.ExecSetGrid;
End;

procedure TTAddRegions.OnSaveGrid(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnSaveGrid;
end;

procedure TTAddRegions.OnSetGrid(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnSetGrid;
end;

procedure TTAddRegions.OnAddRow(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnAddRow;
end;

procedure TTAddRegions.OnCloneRow(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnCloneRow;
end;

procedure TTAddRegions.OnDelRow(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnDelRow;
end;

procedure TTAddRegions.OnDelAllRow(Sender: TObject);
begin
    if m_blCL3RegiEditor=True then
    m_nRE.OnDelAllRow;
end;

procedure TTAddRegions.OnSetEditReg(Sender: TObject);
begin
    SetEditGrid(m_blCL3RegiEditor,cnlChngButt,sgGrid,True);
    m_nRE.SetEdit;
//    if m_blCL3ChngEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_CHANDR_ED_ON) else
//    if m_blCL3ChngEditor=False then m_pDB.FixUspdEvent(0,3,EVS_CHANDR_ED_OF);
end;
procedure TTAddRegions.SetEditGrid(var blState:Boolean;var btButt:TAdvToolBarButton;var sgGrid:TAdvStringGrid;blIsRow:Boolean);
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

procedure TTAddRegions.OnCloseRegion(Sender: TObject;
  var Action: TCloseAction);
begin
    if Assigned(FOnClose) then FOnClose(Sender);
end;

procedure TTAddRegions.OnFormResize(Sender: TObject);
begin
    if m_nRE<>Nil then m_nRE.OnFormResize;
end;

procedure TTAddRegions.OnGetType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
    m_nRE.OnGetType(Sender,ACol,ARow,AEditor);
end;

procedure TTAddRegions.OnClockCell(Sender: TObject; ARow, ACol: Integer);
begin
    m_nRE.OnClickGrid(Sender,ARow,ACol);
end;

destructor TTAddRegions.Destroy;
begin
  if m_nRE <> nil then FreeAndNil(m_nRE);
  inherited;
end;

end.
