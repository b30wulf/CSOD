unit ntabed;

(******************************************************************)
(*                                                                *)
(*                          N T A B E D                           *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1996..2001 H. Lohninger              September 1997    *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jun-04, 2001                                  *)
(*                                                                *)
(******************************************************************)

{
revision history:

Version
1.0   [Sep-17, 1998]
      first release to a limited group of developers

1.1   [Nov-08, 1998]
      NTabEd now available for Delphi 4.0 and offered to the public
      problem with 'Free' of DataCopy solved
      DataCopy is now a common container to ALL instances of NTabEdit
      Export has now correct header flags
      Export precision is now correct
      SetNrCols now adjust the number of dec. places correctly
      Popup menus redesigned
      OnChange event implemented
      OnChangeSetup event implemented
      marking supports now two different types
      AutoColWidth implemented

1.2   [Feb-4, 1999]
      NTabEd now available for C++Builder 4.0
      CopyContentsFrom now also copies the cell state flags
      property CellState implemented
      popup menu "Extract From ClipBoard" implemented
      ASC format now extended to cope with blanks in var/obj names
      Width of row/column names extended to 50 characters (for 32 bit environments)
      FindRowIndex, FindColIndex implemented
      Default options changed (thumbtracking and colresizing TRUE)
      Sorting (SortCols & SortRows) implemented

5.0   [Sep-29, 1999]
      NTabEd now available for Delphi 5.0
      bug fix: ExportASCFile now suppresses painting during exporting
      bug fix: ImportASCFile does no longer restrict the max. number of elements for
                   BCB, and D2 or higher (was a problem originating from 16-bit days)

5.5   [May-08, 2000]
      available for C++Builder 5.0
      bug fix: OnSetTextEdit event is now generated correctly

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      bug fix: ReadFromASCFile has correct paint suppression
      ReadFromASCStream, ReadHeaderOfASCStream implemented
      ImportASCStream, ExportASCStream implemented
      ColorSelected: selected row and column is now indicated with different color in headers
      highlighted region is now displayed using the windows colors (clHighlight and clHighLightText)
}


{$O+}
{$F+}
{$R-}

{--------------------------------------------------------------------}
{-$DEFINE SHAREWARE}
{ This switch is only for testing during the development phase.
  It should be turned off for normal operation                       }
{--------------------------------------------------------------------}

{$IFNDEF SDLBATCH}
  {$IFDEF VER110}
  {$ObjExportAll On}   { this switch is necessary for C++Builder 3.0 }
  {$ENDIF}
  {$IFDEF VER125}
  {$ObjExportAll On}   { this switch is necessary for C++Builder 4.0 }
  {$ENDIF}
  {$IFDEF VER135}
  {$ObjExportAll On}   { this switch is necessary for C++Builder 5.0 }
  {$ENDIF}
{$ENDIF}


{-$DEFINE LANG_GERMAN}
{ If this switch is turned on, the popup menu items will be in German language }


{------------------------------------------------------------------}
interface
{------------------------------------------------------------------}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Menus, Forms,  Grids, StdCtrls, Matrix;

const
{$IFDEF VER80}
  NameWidth = 20;                          { maximum length of col/row names }
  TableMaxColOrRows = 65000 div (NameWidth+1); { max. number of rows or cols }
{$ELSE}
  NameWidth = 50;                          { maximum length of col/row names }
  TableMaxColOrRows = 2000000000 div (NameWidth+1);
{$ENDIF}
  csNAN = $01;           { cell states: not a number }
  csUndefined = $02;                               { undefined or empty cell }

  csMarkedA = $40;                                  { cell is marked, type 1 }
  csMarkedB = $80;                                  { cell is marked, type 2 }

  pdMarkA = $0001;              { mask values of popup commands in data area }
  pdMarkB = $0002;
  pdUnMarkA = $0004;
  pdUnMarkB = $0008;
  pdUnMarkAll = $0010;
  pdClear = $0020;
  pdCopy = $0040;
  pdPaste = $0080;
  pdEdit = $0100;
  pdExtClip = $0200;
  pdAllCmds = $7FFFFFFF;

  phEditIdentifier = $0001;
  phChangePrecision = $0002;
  phAllCmds = $7FFFFFFF;

  pmMarkRange = $0001;      { mask values of popup submenu for mark commands }
  pmMarkColumn = $0002;
  pmMarkRow = $0004;
  pmMarkAll = $0008;
  pmAllCmds = $7FFFFFFF;

  puMarkRange = $0001;    { mask values of popup submenu for unmark commands }
  puMarkColumn = $0002;
  puMarkRow = $0004;
  puMarkAll = $0008;
  puAllCmds = $7FFFFFFF;


type
  NameStrType  = string[NameWidth];                    { col/row header type }
  TVNStates = (vsStart, vs1stQuote, vsQuote, vsNormal, vsEnd);
  TNTabEd = class(TCustomGrid)
            private
              FAutoAdvance    : boolean;       { TRUE: go to next cell on CR }
              FOnChange       : TNotifyEvent;
              FOnChangeSetup  : TNotifyEvent;
              FClassColWidth  : integer;        { width of class info column }
              FComment        : string;    { comment on data, max. 255 chars }
              FRowAtt         : pointer;      { class information on objects }
              FColAtt         : pointer;     { class information on features }
              FColOffset      : integer; { =1 if row attributes are visible, else 0 }
              FRowOffset      : integer; { =1 if column attributes are visible, else 0 }
              FDecP           : pointer;             { nr. of dec. pl. shown }
              FCState         : pointer;              { array of cell states }
              FColName        : pointer;                      { column names }
              FExtMatAssigned : boolean; { if TRUE: external matrix assigned }
              FNumWidth       : integer;            { width of numeric field }
              FRowName        : pointer;                         { row names }
              FNrOfCols       : longint;  { number of columns of data matrix }
              FNrOfRows       : longint;  { number of columns of data matrix }
              FOnGetEditText  : TGetEditEvent;
              FOnSetEditText  : TSetEditEvent;
              FSortIncludeHd  : boolean;     { flag to indicate sorting mode }
              FSuppressPaint  : boolean;    { TRUE: suppress all paint calls }
              FPopupD         : TPopUpMenu;     { popup menu for right mouse
                                                          click in data area }
              FPopupDMask     : longint;  { mask for enabling popup commands }
              FPopupH         : TPopUpMenu;     { popup menu for right mouse
                                                        click in header area }
              FPopupHMask     : longint;  { mask for enabling popup commands }
              FPopupMMask     : longint;  { mask for enabling popup commands }
              FPopupUMask     : longint;  { mask for enabling popup commands }

              FColorNormal    : TColor;             { color of unmarked text }
              FColorMarked1   : TColor;             { color of marked text A }
              FColorMarked2   : TColor;             { color of marked text B }
              FColorMarkedBoth: TColor;           { color of marked text A&B }
              FColorSelected  : TColor;    { color of header of selected row }


              FNameEdActive   : boolean;  { to indicate an act. NameEd comp. }
              FNameEd         : TEdit;              { editor for identifiers }

              FCommentMMActive: boolean; { indicates an act. CommentEd comp. }
              FCommentMM      : TMemo;                  { editor for comment }
              FVNState        : TvnStates;             { state of var parser }
              FVNName         : string; { intermediary name for var. parsing }
              FLastCellX      : integer; { coordinates of last selected cell }
              FLastCellY      : integer; { coordinates of last selected cell }

              procedure CommentMemoKeyPress(Sender: TObject; var Key: Char);
              procedure ExchangeDuringSort (Sender: TObject; ExchgWhat: byte;
                                            index1, index2, first, last: longint);
              function  GetColAttVis: boolean;
              function  GetRowAttVis: boolean;
              function  GetRowAttrib (RowNr: longint): byte;
              function  GetCellState (ACol, ARow: longint): byte;
              function  GetColAttrib (ColNr: longint): byte;
              function  GetColName (ColNr: longint): NameStrType;
              function  GetColWidths(Index: Longint): Integer;
              function  GetDecPlaces (ColNr: longint): shortint;
              function  GetDefColWidth: integer;
              function  GetElem (ACol, ARow: longint): double;
              function  GetElemMarkedA (ACol, ARow: longint): boolean;
              function  GetElemMarkedB (ACol, ARow: longint): boolean;
              function  GetRowName (RowNr: longint): NameStrType;
              procedure FDataHasChanged (Sender: TObject);
              procedure NameEdKeyPress(Sender: TObject; var Key: Char);
              function  ParseVarName (cc: char; var CurrentVName: string): boolean;
              procedure SetSuppressPaint (supp: boolean);
              procedure SetRowAttrib (RowNr: longint; Attrib: byte);
              procedure SetCellState (ACol, ARow: longint; const Value: byte);
              procedure SetColAttrib (ColNr: longint; Attrib: byte);
              procedure SetColAttVis (vis: boolean);
              procedure SetRowAttVis (vis: boolean);
              procedure SetColName (ColNr: longint; HLine: NameStrType);
              procedure SetColorMarkedA (color: TColor);
              procedure SetColorMarkedB (color: TColor);
              procedure SetColorMarkedBoth (color: TColor);
              procedure SetColorNormal (color: TColor);
              procedure SetColorSelected (color: TColor);
              procedure SetColWidths(Index: Longint; Value: Integer);
              procedure SetDecPlaces (ColNr: longint; Dp: shortint);
              procedure SetDefColWidth (DefW: integer);
              procedure SetElem (ACol, ARow: longint; const Value: double);
              procedure SetElemMarkedA (ACol, ARow: longint; const Value: boolean);
              procedure SetElemMarkedB (ACol, ARow: longint; const Value: boolean);
              procedure SetFComment (cmt: string);
              procedure SetNrCols (NrCols: longint);
              procedure SetNrRows (NrRows: longint);
              procedure SetNumWidth (nw: integer);
              procedure SetPopupDMask (mask: longint);
              procedure SetPopupHMask (mask: longint);
              procedure SetRowName (RowNr: longint; HLine: NameStrType);
              procedure PopupMenuClickClear (Sender: TObject);
              procedure PopupMenuClickMarkARange (Sender: TObject);
              procedure PopupMenuClickMarkARow (Sender: TObject);
              procedure PopupMenuClickMarkAAll (Sender: TObject);
              procedure PopupMenuClickMarkAColumn (Sender: TObject);
              procedure PopupMenuClickMarkBRange (Sender: TObject);
              procedure PopupMenuClickMarkBRow (Sender: TObject);
              procedure PopupMenuClickMarkBAll (Sender: TObject);
              procedure PopupMenuClickMarkBColumn (Sender: TObject);
              procedure PopupMenuClickUnMarkARange (Sender: TObject);
              procedure PopupMenuClickUnMarkARow (Sender: TObject);
              procedure PopupMenuClickUnMarkAAll (Sender: TObject);
              procedure PopupMenuClickUnMarkAColumn (Sender: TObject);
              procedure PopupMenuClickUnMarkBRange (Sender: TObject);
              procedure PopupMenuClickUnMarkBRow (Sender: TObject);
              procedure PopupMenuClickUnMarkBAll (Sender: TObject);
              procedure PopupMenuClickUnMarkBColumn (Sender: TObject);
              procedure PopupMenuClickUnMarkAll (Sender: TObject);
              procedure PopupMenuClickCopy (Sender: TObject);
              procedure PopupMenuClickPaste (Sender: TObject);
              procedure PopupMenuClickEdit (Sender: TObject);
              procedure PopupMenuClickExtClip (Sender: TObject);
              procedure PopupMenuClickChangeID (Sender: TObject);
              procedure PopupMenuClickPrecision (Sender: TObject);
              procedure PopupMenuDLoadPopup(Sender: TObject);
            protected
              procedure Paint; override;
              procedure Keypress (var Key: char); override;
              procedure KeyDown(var Key: Word; Shift: TShiftState); override;
              function  GetEditText(ACol, ARow: Longint): string; override;
              procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
              procedure DrawCell (ACol, ARow: Longint; ARect: TRect;
                                  AState: TGridDrawState); override;
              procedure Loaded; override;
              procedure MouseDown (Button: TMouseButton;
                                   Shift: TShiftState; X, Y: Integer); override;
            public
              FData  : TMatrix;                       { data matrix }
              constructor Create(AOwner: TComponent); override;
              destructor  Destroy; override;
              procedure AssignAnotherDataMatrix (NewDMat: TMatrix);
              procedure AutoColWidth (ColNr: longint; IncludeHeader: boolean; Addon: integer);
              procedure Changed;
              procedure ChangedSetup;
              procedure Fill (value: double);
              procedure ExportASCFile (FName: string; Precision: integer);
              procedure ExportASCStream (OutStream: TStream; Precision: integer);
              function  ImportASCFile (FName: string; LastFirstPart: boolean): integer;
              function  ImportASCStream (InStream: TStream): integer;
              property  Elem[ACol, ARow: longint]: double read GetElem write SetElem; default;
              property  CellState[ACol, ARow: longint]: byte read GetCellState write SetCellState;
              property  ElemMarkedA[ACol, ARow: longint]: boolean read GetElemMarkedA write SetElemMarkedA;
              property  ElemMarkedB[ACol, ARow: longint]: boolean read GetElemMarkedB write SetElemMarkedB;
              procedure Redimension (NrCols, NrRows: longint);
              property  RowAttrib [ix: longint]: byte read GetRowAttrib write SetRowAttrib;
              property  ColAttrib [ix: longint]: byte read GetColAttrib write SetColAttrib;
              function  IfColumnMarked (col: longint): boolean;
              function  IfRowMarked (row: longint): boolean;
              procedure Clear;
              property  ColName[ix: longint]: NameStrType read GetColName write SetColName;
              property  ColWidths[Index: Longint]: Integer read GetColWidths write SetColWidths;
              procedure CopyContentsFrom (ExtTab: TNTabEd);
              property  Precision[ColNr: longint]: shortint read GetDecPlaces write SetDecPlaces;
              property  RowName[ix: longint]: NameStrType read GetRowName write SetRowName;
              property  RowHeights;
              property  Selection;
              procedure SortCols (SortRowIx: integer; Ascending: boolean;
                                  LowCol, LowRow, HighCol, HighRow: integer; IncludeHeaders: boolean);
              procedure SortRows (SortColIx: integer; Ascending: boolean;
                                  LowCol, LowRow, HighCol, HighRow: integer; IncludeHeaders: boolean);
              procedure MarkAllElemsA;
              procedure MarkAllElemsB;
              procedure UnMarkAllElems;
              function  FindColIndex (ColID: NameStrType): integer;
              function  FindRowIndex (RowID: NameStrType): integer;
              function  ReadHeaderOfASCFile (FName: string; var Comment: string;
                          var NFeat, NObj: integer; var ClInf, NamFeat,
                          NamObj: boolean): integer;
              function  ReadFromASCFile (FName: string; PosX, PosY: longint;
                                  ReplaceIDs: boolean): integer;
              function  ReadHeaderOfASCStream (InStream: TStream;
                          var Comment: string; var NFeat, NObj: integer;
                          var ClInf, NamFeat, NamObj: boolean): integer;
              function  ReadFromASCStream (InStream: TStream; PosX, PosY: longint;
                                           ReplaceIDs: boolean): integer;
              property  SuppressPaint: boolean read FSuppressPaint write SetSuppressPaint;
              property  PopupDMask: longint read FPopupDMask write SetPopupDMask;
              property  PopupHMask: longint read FPopupHMask write SetPopupHMask;
            published
              property  Align;
              property  AutoAdvance: boolean read FAutoAdvance write FAutoAdvance;
              property  AttribRowVisible: boolean read GetRowAttVis write SetRowAttVis;
              property  AttribColVisible: boolean read GetColAttVis write SetColAttVis;
              property  Comment: string read FComment write SetFComment;
              property  ColorNormal: TColor read FColorNormal write SetColorNormal;
              property  ColorSelected: TColor read FColorSelected write SetColorSelected;
              property  ColorMarkedA: TColor read FColorMarked1 write SetColorMarkedA;
              property  ColorMarkedB: TColor read FColorMarked2 write SetColorMarkedB;
              property  ColorMarkedBoth: TColor read FColorMarkedBoth write SetColorMarkedBoth;
              property  DefaultColWidth: integer read GetDefColWidth write SetDefColWidth;
              property  DefaultRowHeight;
              property  Font;
              property  ParentFont;
              property  NrOfColumns: longint read FNrOfCols write SetNrCols;
              property  NrOfRows: longint read FNrOfRows write SetNrRows;
              property  NumWidth: integer read FNumWidth write SetNumWidth;
              property  Options stored True;
              property  Visible;
              property  OnGetEditText: TGetEditEvent read FOnGetEditText write FOnGetEditText;
              property  OnSetEditText: TSetEditEvent read FOnSetEditText write FOnSetEditText;
              property  OnMouseDown;
              property  OnClick;
              property  OnChange: TNotifyEvent read FOnChange write FOnChange;
              property  OnChangeSetup: TNotifyEvent read FOnChangeSetup write FOnChangeSetup;
              property  OnDblClick;
            end;


procedure Register;


{-----------------------------------------------------------------------}
implementation
{-----------------------------------------------------------------------}

uses
  math1, streams, clipbrd;

{$R *.RES}

{$IFDEF SHAREWARE}
{$I sharwinc\ntabed_ct.inc}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}

const
{$IFDEF VER80}
  TableMaxElem = 8000;       { max. number of elements for D1.0 version }
{$ENDIF}
  defNumWidth = 1;                        { default width of one column }
  LeftSpace = 3;            { distance between cell border and its text }
  TopSpace = 2;
  RightSpace = 3;
  MaxPopupDCmds = 10;      { number of commands in data area popup menu }
                           { NOTE: if order of the following commands is
                             changed, the mask bits 'pdXXXX' have to be
                             adjusted as well }

{$IFDEF LANG_GERMAN}
  PopUpDCmds : array[1..MaxPopupDCmds] of string[30] =
                ('Als Typ A markieren','Als Typ B markieren','Markierung Typ A entfernen',
                 'Markierung Typ B entfernen', 'Alle Markierungen entfernen', 'Löschen',
                 'Kopieren', 'Einfügen', 'Editieren Ein/Aus', 'Aus Clipboard extrahieren');
{$ELSE}
  PopUpDCmds : array[1..MaxPopupDCmds] of string[25] =
                ('Mark as type A','Mark as type B','Unmark type A', 'Unmark type B', 'Unmark All', 'Clear',
                 'Copy', 'Paste', 'Edit on/off', 'Extract from Clipboard');
{$ENDIF}
  PasteIdx = 8;     { this is the index of the paste command; it has to be
                        adjusted if the order of the popup command changes }

  MaxPopupMCmds = 4;       { number of commands in mark submenu }
                           { NOTE: if order of the following commands is
                             changed, the mask bits 'pmXXXX' have to be
                             adjusted as well }
{$IFDEF LANG_GERMAN}
  PopUpMCmds : array[1..MaxPopupMCmds] of string[20] =
                ('Bereich', 'Spalte', 'Zeile', 'Alle');
{$ELSE}
  PopUpMCmds : array[1..MaxPopupMCmds] of string[20] =
                ('Range', 'Column', 'Row', 'All');
{$ENDIF}
  MaxPopupUCmds = 4;       { number of commands in unmark submenu }
                           { NOTE: if order of the following commands is
                             changed, the mask bits 'puXXXX' have to be
                             adjusted as well }
{$IFDEF LANG_GERMAN}
  PopUpUCmds : array[1..MaxPopupUCmds] of string[20] =
                ('Bereich', 'Spalte', 'Zeile', 'Alle');
{$ELSE}
  PopupUCmds : array[1..MaxPopupUCmds] of string[20] =
                ('Range', 'Column', 'Row', 'All');
{$ENDIF}


  MaxPopupHCmds = 2;       { number of commands in header area popup menu }
{$IFDEF LANG_GERMAN}
  PopUpHCmds : array[1..MaxPopupHCmds] of string[20] =
                ('Bezeichner editieren', 'Kommastellen ändern');
{$ELSE}
  PopUpHCmds : array[1..MaxPopupHCmds] of string[20] =
                ('Edit Identifier', 'Change Precision');
{$ENDIF}


type
  DecPArray    = Array [1..1] of shortint;           { # of decimal points }
  StateArray   = array [1..1] of byte;                       { cell states }
  AttribArray  = array [1..1] of byte;             { attribute information }
  NameArray    = Array [1..1] of NameStrType;        { col/row identifiers }
  ESDLNTabedError = class(Exception);  { exception type to indicate errors }

var
  DataCopy      : TMatrix;              { backup matrix for copy and paste }
  DataCopyAvail : boolean;   { TRUE if data in copy/paste container are available }
  PopupDItems   : array [1..MaxPopUpDCmds] of TMenuItem; { data popup menu }
  PopupHItems   : array [1..MaxPopUpHCmds] of TMenuItem;    { header popup }
  PopupM1Items  : array [1..MaxPopUpMCmds] of TMenuItem;    { mark submenu }
  PopupM2Items  : array [1..MaxPopUpMCmds] of TMenuItem;    { mark submenu }
  PopupU1Items  : array [1..MaxPopUpUCmds] of TMenuItem;  { unmark submenu }
  PopupU2Items  : array [1..MaxPopUpUCmds] of TMenuItem;  { unmark submenu }
  GridCell      : TGridCoord; { coordinates of grid cell clicked on lastly }
  LastMouseClkX : integer;            { coordinates of last mouse click }
  LastMouseClkY : integer;


{$I strff.inc}
{$I replchar.inc}
{$I stripblk.inc}
{$I frmtdata.inc}

(***********************************************************************)
procedure TNTabEd.FDataHasChanged (Sender: TObject);
(***********************************************************************)

begin
Changed;
Paint;
end;


(***********************************************************************)
procedure TNTabEd.Loaded;
(***********************************************************************)

begin
FLastCellX := 1+FColOffset;
FLastCellY := 1+FRowOffset;
end;

(***********************************************************************)
constructor TNTabEd.Create(AOwner: TComponent);
(***********************************************************************)


var
  success  : boolean;
  i        : integer;
  BitMask  : longint;
  enabl    : boolean;


begin
inherited Create(AOwner);    { Inherit original constructor }
FSuppressPaint := true;
FixedCols := 2;                           { show class info }
FColOffset := 1;
FRowOffset := 0;
FNrOfCOls := ColCount-2;
FNrOfRows := RowCount-1;
FClassColWidth := 32;
FColorMarked1 := clRed;
FColorMarked2 := clBlue;
FColorMarkedBoth := $CC00BB;
FColorNormal := $002000;
FColorSelected := clWhite;
FNameEdActive := false;
FCommentMMActive := false;

if not (csDesigning in ComponentState) then
  begin
  FNameEd := TEdit.Create (self);
  FNameEd.Parent := self;
  FNameEd.OnKEyPress := NameEdKeyPress;
  FNameEd.Hide;
  FCommentMM := TMemo.Create (self);
  FCommentMM.Parent := self;
  FCommentMM.OnKEyPress := CommentMemoKeyPress;
  FCommentMM.Hide;
  end;
inherited ColWidths[1] := FClassColWidth;
inherited ColWidths[0] := 80;
FNumWidth := defNumWidth;
FAutoAdvance := False;
success := false;
DataCopy := TMatrix.Create (1,1);
DataCopyAvail := false;
FData := TMatrix.Create (FNrOfCols,FNrOfRows);
FExtMatAssigned := false;
if FData <> NIL then
  begin
  success := True;
  FData.Fill (0);
  GetMem (FDecP, sizeof(shortint)*FNrOfCols);
  if FDecP = NIL
    then success := False
    else begin
         for i:=1 to FNrOfCols do
           DecPArray(FDecP^)[i] := 3;
         GetMem (FCState, FNrOfCols*FNrOfRows);
         if FCState = NIL
           then success := False
           else begin
                FillChar (FCState^, FNrOfRows*FNrOfCols, 0);
                GetMem (FColName, sizeof(NameStrType)*FNrOfCols);
                if FColName = NIL
                  then success := False
                  else begin
                       for i:=1 to FNrOfCols do
                         NameArray(FColName^)[i] := 'C-'+strff(i,1,0);
                       GetMem (FRowName, sizeof(NameStrType)*FNrOfRows);
                       if FRowName = NIL
                         then success := False
                         else begin
                              for i:=1 to FNrOfRows do
                                NameArray(FRowName^)[i] := 'R-'+strff(i,1,0);
                              GetMem (FRowAtt, sizeof(byte)*FNrOfRows);
                              if FRowAtt = NIL
                                then success := False
                                else begin
                                     for i:=1 to FNrOfRows do
                                       AttribArray(FRowAtt^)[i] := 0;
                                       GetMem (FColAtt, sizeof(byte)*FNrOfCols);
                                       if FColAtt = NIL
                                         then success := False
                                         else begin
                                              for i:=1 to FNrOfCols do
                                                AttribArray(FColAtt^)[i] := 0;
                                              end;
                                     end;
                              end;
                       end;
                end
         end;
  end;
if not success
  then begin
       if FDecP <> NIL then
         FreeMem (FDecP, sizeof(shortint)*FNrOfCols);
       if FCState <> NIL then
         FreeMem (FCState, FNrOfCols*FNrOfRows);
       if FColName <> NIL then
         FreeMem (FColName, sizeof(NameStrType)*FNrOfCols);
       if FRowName <> NIL then
         FreeMem (FRowName, sizeof(NameStrType)*FNrOfRows);
       if FRowAtt <> NIL then
         FreeMem (FRowAtt, sizeof(byte)*FNrOfRows);
       if FColAtt <> NIL then
         FreeMem (FColAtt, sizeof(byte)*FNrOfCols);
       if not FExtMatAssigned then
         FData.Free;
       Fail;
       raise ESDLNTabedError.Create ('NTABED: failed to initialize table editor (out of memory)')
       end
  else begin
       FData.OnChange := FDataHasChanged;
       FData.OnSortExchange := ExchangeDuringSort;
//       Options := Options + [goColSizing, goFixedVertLine, goFixedHorzLine,
//                   goThumbTracking, goVertLine, goHorzLine];
       FPopupMMask := phAllCmds;       { enable all commands }
       for i:=1 to MaxPopupMCmds do    { create mark popup submenu }
         PopupM1Items[i] := NewItem (PopupMCmds[i],   {Caption}
                                    0,               {ShortCut}
                                    false,            {Checked}
                                    true,             {Enabled}
                                    nil,              {OnClick}
                                    0,           {help context}
                                    'M1It'+IntToStr(i)); {Name}
       PopupM1Items[1].OnClick := PopupMenuClickMarkARange;
       PopupM1Items[2].OnClick := PopupMenuClickMarkAColumn;
       PopupM1Items[3].OnClick := PopupMenuClickMarkARow;
       PopupM1Items[4].OnClick := PopupMenuClickMarkAAll;
       for i:=1 to MaxPopupMCmds do    { create mark popup submenu }
         PopupM2Items[i] := NewItem (PopupMCmds[i],   {Caption}
                                    0,               {ShortCut}
                                    false,            {Checked}
                                    true,             {Enabled}
                                    nil,              {OnClick}
                                    0,           {help context}
                                    'M2It'+IntToStr(i)); {Name}
       PopupM2Items[1].OnClick := PopupMenuClickMarkBRange;
       PopupM2Items[2].OnClick := PopupMenuClickMarkBColumn;
       PopupM2Items[3].OnClick := PopupMenuClickMarkBRow;
       PopupM2Items[4].OnClick := PopupMenuClickMarkBAll;

       FPopupUMask := phAllCmds;       { enable all commands }
       for i:=1 to MaxPopupUCmds do    { create mark popup submenu }
         PopupU1Items[i] := NewItem (PopupUCmds[i],   {Caption}
                                    0,               {ShortCut}
                                    false,            {Checked}
                                    true,             {Enabled}
                                    nil,              {OnClick}
                                    0,           {help context}
                                    'U1It'+IntToStr(i)); {Name}
       PopupU1Items[1].OnClick := PopupMenuClickUnMarkARange;
       PopupU1Items[2].OnClick := PopupMenuClickUnMarkAColumn;
       PopupU1Items[3].OnClick := PopupMenuClickUnMarkARow;
       PopupU1Items[4].OnClick := PopupMenuClickUnMarkAAll;
       for i:=1 to MaxPopupUCmds do    { create mark popup submenu }
         PopupU2Items[i] := NewItem (PopupUCmds[i],   {Caption}
                                    0,               {ShortCut}
                                    false,            {Checked}
                                    true,             {Enabled}
                                    nil,              {OnClick}
                                    0,           {help context}
                                    'U2It'+IntToStr(i)); {Name}
       PopupU2Items[1].OnClick := PopupMenuClickUnMarkBRange;
       PopupU2Items[2].OnClick := PopupMenuClickUnMarkBColumn;
       PopupU2Items[3].OnClick := PopupMenuClickUnMarkBRow;
       PopupU2Items[4].OnClick := PopupMenuClickUnMarkBAll;

       FPopupDMask := pdAllCmds and not pdPaste;   { enable all but "Paste" commands }
       BitMask := $00000001;
       for i:=1 to MaxPopupDCmds do    { create data area popup menu }
         begin
         case BitMask of
           pdMarkA : PopupDItems[i] := NewSubMenu (PopUpDCmds[i],   {Caption}
                                                  0,                { help context }
                                                  'DIt'+IntToStr(i),{Name}
                                                  PopupM1Items);
           pdMarkB : PopupDItems[i] := NewSubMenu (PopUpDCmds[i],   {Caption}
                                                  0,                { help context }
                                                  'DIt'+IntToStr(i),{Name}
                                                  PopupM2Items);
         pdUnMarkA : PopupDItems[i] := NewSubMenu (PopUpDCmds[i],   {Caption}
                                                  0,                { help context }
                                                  'DIt'+IntToStr(i),{Name}
                                                  PopupU1Items);
         pdUnMarkB : PopupDItems[i] := NewSubMenu (PopUpDCmds[i],   {Caption}
                                                  0,                { help context }
                                                  'DIt'+IntToStr(i),{Name}
                                                  PopupU2Items);
         else begin
              enabl := (FPopupDMask and BitMask <> 0);
              PopupDItems[i] := NewItem (PopUpDCmds[i],   {Caption}
                                              0,               {ShortCut}
                                              false,            {Checked}
                                              enabl,            {Enabled}
                                              nil,              {OnClick}
                                              0,           {help context}
                                              'DIt'+IntToStr(i));  {Name}
              end;
         end;
         BitMask := BitMask shl 1;
         end;
       PopupDItems[5].OnClick := PopupMenuClickUnMarkAll;
       PopupDItems[6].OnClick := PopupMenuClickClear;
       PopupDItems[7].OnClick := PopupMenuClickCopy;
       PopupDItems[8].OnClick := PopupMenuClickPaste;
       PopupDItems[9].OnClick := PopupMenuClickEdit;
       PopupDItems[10].OnClick := PopupMenuClickExtClip;
       FPopupD := NewPopupMenu (self,                  {owner}
                               'PopupDTAction',         {name}
                               paLeft,             {alignment}
                               true,               {autopopup}
                               PopupDItems);    {menu entries}
       FPopupD.Onpopup := PopupMenuDLoadPopup;

       FPopupHMask := phAllCmds;       { enable all commands }
       for i:=1 to MaxPopupHCmds do    { create header popup menu }
         PopupHItems[i] := NewItem (PopupHCmds[i],   {Caption}
                                   0,               {ShortCut}
                                   false,            {Checked}
                                   true,             {Enabled}
                                   nil,              {OnClick}
                                   0,           {help context}
                                   'HIt'+IntToStr(i));  {Name}

       PopupHItems[1].OnClick := PopupMenuClickChangeID;
       PopupHItems[2].OnClick := PopupMenuClickPrecision;

       FPopupH := NewPopupMenu (self,                  {owner}
                               'PopupHTAction',         {name}
                               paLeft,             {alignment}
                               true,               {autopopup}
                               PopupHItems);    {menu entries}
       end;
FSuppressPaint := false;
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;


(***********************************************************************)
destructor TNTabEd.Destroy;
(***********************************************************************)


begin
if FDecP <> NIL then
  FreeMem (FDecP, sizeof(shortint)*FNrOfCols);
FDecP := NIL;
if FCState <> NIL then
  FreeMem (FCState, FNrOfCols*FNrOfRows);
FCState := NIL;
if FColName <> NIL then
  FreeMem (FColName, sizeof(NameStrType)*FNrOfCols);
FColName := NIL;
if FRowName <> NIL then
  FreeMem (FRowName, sizeof(NameStrType)*FNrOfRows);
FRowName := NIL;
if FRowAtt <> NIL then
  FreeMem (FRowAtt, sizeof(byte)*FNrOfRows);
FRowAtt := NIL;
if FColAtt <> NIL then
  FreeMem (FColAtt, sizeof(byte)*FNrOfCols);
FColAtt := NIL;
if not FExtMatAssigned and (FData <> NIL)
  then begin
       FData.Free;
       FData := NIL;
       end
  else FData.OnChange := nil;
FPopupD.Free;
FPopupH.Free;
if not (csDesigning in ComponentState) then
  FNameEd.Free;
if not (csDesigning in ComponentState) then
  FCommentMM.Free;
if DataCopy <> NIL then
  DataCopy.Free;
DataCopy := NIL;
inherited Destroy;    { Inherit original destructor }
end;


(***********************************************************************)
procedure TNTabEd.ExchangeDuringSort (Sender: TObject;
          ExchgWhat: byte; index1, index2, first, last: longint);
(***********************************************************************)

var
  byteDummy : byte;
  NameDummy : NameStrType;
  ShintDummy: shortint;
  I         : integer;

begin
if ExchgWhat = 1
  then begin                                                { exchange columns }
       if FSortIncludeHd then
         begin
         ShintDummy := DecPArray(FDecP^)[index1];                 { dec places }
         DecPArray(FDecP^)[index1] := DecPArray(FDecP^)[index2];
         DecPArray(FDecP^)[index2] := ShintDummy;
         bytedummy := AttribArray(FColAtt^)[index1];          { col attributes }
         AttribArray(FColAtt^)[index1] := AttribArray(FColAtt^)[index2];
         AttribArray(FColAtt^)[index2] := byteDummy;
         NameDummy := NameArray(FColName^)[index1];                { Col names }
         NameArray(FColName^)[index1] := NameArray(FColName^)[index2];
         NameArray(FColName^)[index2] := NameDummy;
         end;
       for i:=First to Last do                                   { cell states }
         begin
         byteDummy := StateArray(FCState^)[(i-1)*FNrOfCols+index1];
         StateArray(FCState^)[(i-1)*FNrOfCols+index1] :=
            StateArray(FCState^)[(i-1)*FNrOfCols+index2];
         StateArray(FCState^)[(i-1)*FNrOfCols+index2] := byteDummy;
         end;
       end
  else begin                                                   { exchange rows }
       if FSortIncludeHd then
         begin
         bytedummy := AttribArray(FRowAtt^)[index1];          { row attributes }
         AttribArray(FRowAtt^)[index1] := AttribArray(FRowAtt^)[index2];
         AttribArray(FRowAtt^)[index2] := byteDummy;
         NameDummy := NameArray(FRowName^)[index1];                { row names }
         NameArray(FRowName^)[index1] := NameArray(FRowName^)[index2];
         NameArray(FRowName^)[index2] := NameDummy;
         end;
       for i:=First to Last do                                   { cell states }
         begin
         byteDummy := StateArray(FCState^)[(index1-1)*FNrOfCols+i];
         StateArray(FCState^)[(index1-1)*FNrOfCols+i] :=
            StateArray(FCState^)[(index2-1)*FNrOfCols+i];
         StateArray(FCState^)[(index2-1)*FNrOfCols+i] := byteDummy;
         end;
       end;
end;


(***********************************************************************)
procedure TNTabEd.SortCols (SortRowIx: integer; Ascending: boolean;
             LowCol, LowRow, HighCol, HighRow: integer; IncludeHeaders: boolean);
(***********************************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
         SortRowIx ......... index of row to be taken as
                             sorting criterion
         Ascending ......... type of sorting (FALSE = descending,
                             TRUE ascending)
         IncludeHeaders .... TRUE: column names and attributes are exchanged
                             according to the sort order
                             FALSE: column names and attributes are left unchanged

  EXIT:  array sorted according to column 'SortColIx' within
         range (LowCol..HighRow). Column 'SortColIx' is sorted
         too, regardless whether 'SortRowIx' lies within range
         (LowCol..HighCol) or not.
 ***********************************************************************)

begin
FSortIncludeHd := IncludeHeaders;
FData.SortCols (SortRowIx, Ascending, LowCol, LowRow, HighCol, HighRow);
end;


(***********************************************************************)
procedure TNTabEd.SortRows (SortColIx: integer; Ascending: boolean;
             LowCol, LowRow, HighCol, HighRow: integer; IncludeHeaders: boolean);
(***********************************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
         SortColIx ......... index of column to be taken as
                             sorting criterion
         Ascending ......... type of sorting (FALSE = descending,
                             TRUE ascending)
         IncludeHeaders .... TRUE: row names and attributes are exchanged
                             according to the sort order
                             FALSE: row names and attributes are left unchanged

  EXIT:  array sorted according to column 'SortColIx' within
         range (LowCol..HighRow). Column 'SortColIx' is sorted
         too, regardless whether 'SortRowIx' lies within range
         (LowCol..HighCol) or not.
 ***********************************************************************)

begin
FSortIncludeHd := IncludeHeaders;
FData.SortRows (SortColIx, Ascending, LowCol, LowRow, HighCol, HighRow);
end;


(***********************************************************************)
function TNTabEd.FindColIndex (ColID: NameStrType): integer;
(***********************************************************************
  ENTRY: ColID .... column identifier (name of column)

  EXIT:  function returns index of the corresponding column, or 0 if
         no such column is available. In case of several columns having
         the same name, the column with the lowest index is returned.
         Lower and upper cases may be mixed (however mind the umlauts of
         foreign languages).
 ***********************************************************************)

var
  i     : integer;
  found : boolean;

begin
ColID := uppercase (StripLTBlanks(ColID));
i:=0;
found := false;
while not found and (i < FNrOfCols) do
  begin
  inc (i);
  if uppercase(StripLTBlanks(GetColName(i))) = ColID then
    Found := True;
  end;
if found
  then FindColIndex := i
  else FindColIndex := 0;
end;


(***********************************************************************)
function TNTabEd.FindRowIndex (RowID: NameStrType): integer;
(***********************************************************************
  ENTRY: RowID .... row identifier (name of row)

  EXIT:  function returns index of the corresponding row, or 0 if
         no such row is available. In case of several rows having
         the same name, the row with the lowest index is returned.
         Lower and upper cases may be mixed (however mind the umlauts of
         foreign languages).
 ***********************************************************************)

var
  i     : integer;
  found : boolean;

begin
RowID := uppercase (StripLTBlanks(RowID));
i:=0;
found := false;
while not found and (i < FNrOfRows) do
  begin
  inc (i);
  if uppercase(StripLTBlanks(GetRowName(i))) = RowID then
    Found := True;
  end;
if found
  then FindRowIndex := i
  else FindRowIndex := 0;
end;


(***********************************************************************)
procedure TNTabEd.Changed;
(***********************************************************************)

begin
if Assigned(FOnChange) then
  FOnChange(Self);
end;


(***********************************************************************)
procedure TNTabEd.ChangedSetup;
(***********************************************************************)

begin
FLastCellX := Selection.Left;
FLastCellY := Selection.Top;
if Assigned(FOnChangeSetup) then
  FOnChangeSetup(Self);
end;



(***********************************************************************)
procedure TNTabEd.Paint;
(***********************************************************************)

{$IFDEF SHAREWARE}
var
  astr       : string;
  i,j        : integer;
{$ENDIF}

begin
if not FSuppressPaint then
  begin
  inherited Paint;
  {$IFDEF SHAREWARE}
  Hint := GetHintStr;
  ShowHint := True;
  if not DelphiIsRunning then
    begin
    Canvas.Font.Color := clWhite;
    Canvas.Font.Name := 'MS Sans Serif';
    Canvas.Brush.Color := clNavy;
    Canvas.Brush.Style := bsSolid;
    Canvas.Font.Size := 8;
    astr := GetVisMsgStr;
    j := 0;
    while length(astr) > 0 do
      begin
      i := pos (#10, astr);
      if i = 0 then
        i := length(astr);
      Canvas.TextOut (10,10+20*j, ' '+copy (astr,1,i-1)+' ');
      inc(j);
      delete (astr,1,i);
      end;
    end;
  {$ENDIF}
  end;
end;

(***********************************************************************)
procedure TNTabEd.PopupMenuClickChangeID (Sender: TObject);
(***********************************************************************)

var
  Arect : TRect;

begin
if (GridCell.X > FColOffset) or (GridCell.Y > FRowOffset) then
  begin
  ARect := Cellrect (GridCell.X,GridCell.Y);
  Canvas.Pen.mode := pmNot;
  Canvas.Rectangle (ARect.Left, Arect.Top, ARect.Right+1, ARect.Bottom+1);
  Canvas.Pen.mode := pmCopy;
  FNameEd.Left := ARect.Left+30;
  FNameEd.Top := ARect.Bottom+5;
  if GridCell.X > FColOffset
    then begin                             { column id or column attribute}
         if GridCell.Y = 0
           then FNameEd.Text := ColName[GridCell.X-FColOffset] { column ID }
           else FNameEd.Text := strff(ColAttrib[GridCell.X-FColOffset],1,0); { column attrib }
         end
    else begin                             { row id or row attribute}
         if GridCell.X = 0
           then FNameEd.Text := RowName[GridCell.Y-FRowOffset]    { rows }
           else FNameEd.Text := strff(RowAttrib[GridCell.Y-FRowOffset],1,0);   { rows }
         end;
  FNameEd.Show;
  FNameEd.SetFocus;
  FNameEdActive := true;
  end;
end;


(***********************************************************************)
procedure TNTabEd.Clear;
(***********************************************************************)

var
  i : integer;

begin
for i:=1 to FNrOfCols do
  NameArray(FColName^)[i] := 'C-'+strff(i,1,0);
for i:=1 to FNrOfRows do
  NameArray(FRowName^)[i] := 'R-'+strff(i,1,0);
for i:=1 to FNrOfCols do
  DecPArray(FDecP^)[i] := 3;
FillChar (FCState^, FNrOfRows*FNrOfCols, 0);
for i:=1 to FNrOfRows do                 { set class number to zero }
  AttribArray(FRowAtt^)[i] := 0;
for i:=1 to FNrOfCols do           { set column attributes to zero }
  AttribArray(FColAtt^)[i] := 0;
FComment := '';
FData.Fill (0);  { call to paint is not necessary, since Fill triggers OnChange event }
end;


(***********************************************************************)
procedure TNTabEd.NameEdKeyPress(Sender: TObject; var Key: Char);
(***********************************************************************)

var
  Arect  : TRect;
  rdummy : double;
  status : integer;

begin
if (Key = #13) or (Key = #27) then
  begin
  FNameEd.Hide;
  FNameEdActive := false;
  ARect := Cellrect (GridCell.X,GridCell.Y);
  Canvas.Pen.mode := pmNot;
  Canvas.Rectangle (ARect.Left, Arect.Top, ARect.Right+1, ARect.Bottom+1);
  Canvas.Pen.mode := pmCopy;
  if Key = #13 then
    begin
    if GridCell.X > FColOffset
      then begin                             { column id or column attribute}
           if GridCell.Y = 0
             then ColName[GridCell.X-FColOffset] := FNameEd.Text { column ID }
             else begin
                  val (FNameEd.Text, rdummy, status);
                  if status = 0 then
                    begin
                    ColAttrib[GridCell.X-FColOffset] := round(rdummy); { column attrib }
                    Changed;
                    end;
                  end;
           end
      else begin                             { row id or row attribute}
           if GridCell.X = 0
             then RowName[GridCell.Y-FRowOffset] := FNameEd.Text  { rows }
             else begin
                  val (FNameEd.Text, rdummy, status);
                  if status = 0 then
                    begin
                    RowAttrib[GridCell.Y-FRowOffset] := round(rdummy); { row attrib }
                    Changed;
                    end;
                  end;
           end;
    end;
  end;
end;


(***********************************************************************)
procedure TNTabEd.CommentMemoKeyPress(Sender: TObject; var Key: Char);
(***********************************************************************)

var
  ARect : TRect;

begin
if (Key = #13) or (Key = #27) then
  begin
  FCommentMM.Hide;
  FCommentMMActive := false;
  if Key = #13 then
    begin
    FComment := FCommentMM.Text;
    changed;
    end;
  ARect := Cellrect (0,0);
  Canvas.Brush.Color := clWindow;
  Canvas.Font.Color := FColorNormal;
  Canvas.textRect (ARect, ARect.Left+LeftSpace, ARect.Top+TopSpace,
                   IntToStr(Selection.Left-FColOffset)+':'+
                   IntToStr(Selection.Top-FRowOffset)); { col/row index }
  end;
end;



(***********************************************************************)
procedure TNTabEd.PopupMenuClickPrecision (Sender: TObject);
(***********************************************************************)

var
  pr    : shortint;
  Arect : TRect;

begin
pr := Precision[GridCell.X-FColOffset];
dec (pr);
if pr < -1 then
  pr := 8;
Precision[GridCell.X-FColOffset] := pr;
ARect := Cellrect (GridCell.X,GridCell.Y);
Canvas.Pen.mode := pmNot;
Canvas.Rectangle (ARect.Left, Arect.Top, ARect.Right+1, ARect.Bottom+1);
Canvas.Pen.mode := pmCopy;
FPopupH.popup (ARect.Left+Left+parent.Left+30,ARect.Bottom+top+parent.top+25);
Canvas.Pen.mode := pmNot;
Canvas.Rectangle (ARect.Left, Arect.Top, ARect.Right+1, ARect.Bottom+1);
Canvas.Pen.mode := pmCopy;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickClear (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
SuppressPaint := true;
FData.OnChange := nil;             { trick to prevent multiple OnChange events }
for i:=Selection.Left-FColOffset to Selection.Right-FColOffset do
  for j:=Selection.Top-FRowOffset to Selection.Bottom-FRowOffset do
    FData.Elem[i,j] := 0;
FData.OnChange := FDataHasChanged;          { switch on event processing again }
SuppressPaint := false;
changed;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuDLoadPopup (Sender: TObject);
(***********************************************************************)

begin
if DataCopyAvail then
  FPopupD.Items[PasteIdx-1].Enabled := true;               { paste allowed now }
end;



(***********************************************************************)
procedure TNTabEd.PopupMenuClickCopy (Sender: TObject);
(***********************************************************************)

var
  i,j : longint;

begin
DataCopy.Resize (Selection.Right-Selection.Left+1,Selection.Bottom-Selection.Top+1);
for i:=Selection.Left-FColOffset to Selection.Right-FColOffset do
  for j:=Selection.Top-FRowOffset to Selection.Bottom-FRowOffset do
    DataCopy.Elem[i-Selection.Left+FColOffset+1,j-Selection.Top+FRowOffset+1] := FData.Elem[i,j];
DataCopyAvail := true;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickPaste (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;
  gr   : TGridRect;

begin
SuppressPaint := true;
FData.OnChange := nil;             { trick to prevent multiple OnChange events }
for i:=1 to DataCopy.NrOfColumns do
  for j:=1 to DataCopy.NrOfRows do
    FData.Elem[Selection.Left-FColOffset-1+i,Selection.Top-FRowOffset-1+j] := DataCopy.Elem[i,j];
gr.Right := DataCopy.NrOfColumns+Selection.Left-1;
gr.Bottom := DataCopy.NrOfRows+Selection.Top-1;
gr.Left := Selection.Left;
gr.Top := Selection.Top;
FData.OnChange := FDataHasChanged;          { switch on event processing again }
SuppressPaint := false;
changed;
Selection := gr;
end;

(***********************************************************************)
procedure TNTabEd.PopupMenuClickExtClip (Sender: TObject);
(***********************************************************************)

var
  gr   : TGridRect;
  astr : string;
  ix, iy  : integer;
  stridx  : integer;
  nextnum : double;

begin
if ClipBoard.HasFormat (CF_Text) then
  begin
  SuppressPaint := true;
  FData.OnChange := nil;           { trick to prevent multiple OnChange events }
  astr := ReplaceCharInString (ClipBoard.Astext, #9, ' ');
  astr := ReplaceCharInString (astr, #13, ' ');
  astr := astr + ' ';          { append dummy blank to avoid range check error }
  ix := 0;
  iy := 0;
  stridx := 1;
  while not (astr[stridx] in ['0'..'9','.','+','-']) do    { find first number }
    inc (stridx);
  while stridx <= length(astr) do
    begin
    nextnum := ScanFPNum (astr, true, 1, stridx);
    FData.Elem[Selection.Left-FColOffset+ix,Selection.Top-FRowOffset+iy] := nextnum;
    inc (ix);
    repeat                                                  { find next number }
      if stridx < length(astr) then
        inc(stridx);
      if astr[stridx] = #10 then
        begin                                                       { new line }
        if stridx < length(astr) then
          inc (stridx);
        ix := 0;
        inc (iy);
        end;
    until ((stridx >= length(astr)) or
           (astr[stridx] in ['0'..'9','.','+','-']));
    end;
  gr.Right := DataCopy.NrOfColumns+Selection.Left-1;
  gr.Bottom := DataCopy.NrOfRows+Selection.Top-1;
  gr.Left := Selection.Left;
  gr.Top := Selection.Top;
  FData.OnChange := FDataHasChanged;          { switch on event processing again }
  SuppressPaint := false;
  changed;
  Selection := gr;
  end;
end;



(***********************************************************************)
procedure TNTabEd.PopupMenuClickEdit (Sender: TObject);
(***********************************************************************)

begin
if goEditing in Options
  then Options := Options - [goEditing]
  else Options := Options + [goEditing];
ChangedSetup;
end;



(***********************************************************************)
procedure TNTabEd.PopupMenuClickUnMarkARange (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=Selection.Left-FColOffset to Selection.Right-FColOffset do
  for j:=Selection.Top-FRowOffset to Selection.Bottom-FRowOffset do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] and not csMarkedA;
Paint;
ChangedSetup;
end;

(***********************************************************************)
procedure TNTabEd.PopupMenuClickUnMarkBRange (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=Selection.Left-FColOffset to Selection.Right-FColOffset do
  for j:=Selection.Top-FRowOffset to Selection.Bottom-FRowOffset do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] and not csMarkedB;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickUnMarkAColumn (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=Selection.Left-FColOffset to Selection.Right-FColOffset do
  for j:=1 to FNrOfRows do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] and not csMarkedA;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickUnMarkARow (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=1 to FNrOfCOls do
  for j:=Selection.Top-FRowOffset to Selection.Bottom-FRowOffset do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] and not csMarkedA;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickUnMarkAAll (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=1 to FNrOfCOls do
  for j:=1 to FNrOfRows do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] and not csMarkedA;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickUnMarkBColumn (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=Selection.Left-FColOffset to Selection.Right-FColOffset do
  for j:=1 to FNrOfRows do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] and not csMarkedB;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickUnMarkBRow (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=1 to FNrOfCOls do
  for j:=Selection.Top-FRowOffset to Selection.Bottom-FRowOffset do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] and not csMarkedB;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickUnMarkBAll (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=1 to FNrOfCOls do
  for j:=1 to FNrOfRows do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] and not csMarkedB;
Paint;
ChangedSetup;
end;



(***********************************************************************)
procedure TNTabEd.PopupMenuClickUnMarkAll (Sender: TObject);
(***********************************************************************)

begin
FillChar (FCState^, FNrOfRows*FNrOfCols, 0);
Paint;
ChangedSetup;
end;



(***********************************************************************)
procedure TNTabEd.PopupMenuClickMarkARange (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=Selection.Left-FColOffset to Selection.Right-FColOffset do
  for j:=Selection.Top-FRowOffset to Selection.Bottom-FRowOffset do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i]or csMarkedA;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickMarkAColumn (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=Selection.Left-FColOffset to Selection.Right-FColOffset do
  for j:=1 to FNrOfRows do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] or csMarkedA;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickMarkARow (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=1 to FNrOfCOls do
  for j:=Selection.Top-FRowOffset to Selection.Bottom-FRowOffset do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] or csMarkedA;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickMarkAAll (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=1 to FNrOfCOls do
  for j:=1 to FNrOfRows do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] or csMarkedA;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickMarkBRange (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=Selection.Left-FColOffset to Selection.Right-FColOffset do
  for j:=Selection.Top-FRowOffset to Selection.Bottom-FRowOffset do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i]or csMarkedB;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickMarkBColumn (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=Selection.Left-FColOffset to Selection.Right-FColOffset do
  for j:=1 to FNrOfRows do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] or csMarkedB;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickMarkBRow (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=1 to FNrOfCOls do
  for j:=Selection.Top-FRowOffset to Selection.Bottom-FRowOffset do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] or csMarkedB;
Paint;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.PopupMenuClickMarkBAll (Sender: TObject);
(***********************************************************************)

var
  i, j : longint;

begin
for i:=1 to FNrOfCOls do
  for j:=1 to FNrOfRows do
    StateArray(FCState^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*FNrOfCols+i] or csMarkedB;
Paint;
ChangedSetup;
end;


(******************************************************************)
function TNTabEd.GetColWidths(Index: Longint): Integer;
(******************************************************************
  ENTRY:    Index ..... index of column: 1..n = data columns
                                            0 = row names
                                           -1 = class names

  EXIT:     width of indicated column is returned
******************************************************************)

begin
if Index > 0
  then result := inherited ColWidths[Index+FColOffset] { data columns }
  else begin
       if index = 0
         then result := inherited COlWidths[0]            { row names }
         else begin
              if FColOffset = 0                          { class info }
                then result := 0
                else result := inherited ColWidths[1];
              end;
       end;
end;


(******************************************************************)
procedure TNTabEd.SetSuppressPaint (supp: boolean);
(******************************************************************)

begin
if FSuppressPaint <> supp then
  begin
  FSuppressPaint := supp;
  if not FSuppressPaint then
    Paint;
  end;
end;

(******************************************************************)
procedure TNTabed.SetColorNormal (color: TColor);
(******************************************************************)

begin
FColorNormal := color;
Paint;
ChangedSetup;
end;

(******************************************************************)
procedure TNTabed.SetColorSelected (color: TColor);
(******************************************************************)

begin
FColorSelected := color;
Paint;
ChangedSetup;
end;


(******************************************************************)
procedure TNTabed.SetColorMarkedA (color: TColor);
(******************************************************************)

begin
FColorMarked1 := color;
Paint;
ChangedSetup;
end;

(******************************************************************)
procedure TNTabed.SetColorMarkedB (color: TColor);
(******************************************************************)

begin
FColorMarked2 := color;
Paint;
ChangedSetup;
end;

(******************************************************************)
procedure TNTabed.SetColorMarkedBoth (color: TColor);
(******************************************************************)

begin
FColorMarkedBoth := color;
Paint;
ChangedSetup;
end;


(******************************************************************)
procedure TNTabed.SetDecPlaces (ColNr: longint; Dp: shortint);
(******************************************************************
ENTRY: column ..... column number
       dp ......... number of decimal places desired

EXIT:  The data stored in the specified column are displayed with
       'dp' decimal places.
*******************************************************************)

begin
if (ColNr >= 1) and (ColNr <= NrOfColumns) then
  begin
  if dp < 0 then dp := -1;
  if dp > 8 then dp := 8;
  DecPArray(FDecP^)[ColNr] := dp;
  Paint;
  ChangedSetup;
  end;
end;


(******************************************************************)
procedure TNTabed.SetPopupDMask (mask: longint);
(******************************************************************
ENTRY: mask ..... mask of popup commands to be enabled (disabled)

EXIT:  The masked popup commands of the data area popup menu are
       enabled/disabled.
 ******************************************************************)

var
  BitMask : longint;
  i       : integer;

begin
FPopupDMask := mask;
BitMask := $00000001;
for i:=1 to MaxPopupDCmds do    { data area popup menu }
  begin
  PopupDItems[i].Enabled := (FPopupDMask and BitMask <> 0);
  BitMask := BitMask shl 1;
  end;
ChangedSetup;
end;

(******************************************************************)
procedure TNTabed.SetPopupHMask (mask: longint);
(******************************************************************
ENTRY: mask ..... mask of popup commands to be enabled (disabled)

EXIT:  The masked popup commands of the header popup menu are
       enabled/disabled
 ******************************************************************)

var
  BitMask : longint;
  i       : integer;

begin
FPopupHMask := mask;
BitMask := $00000001;
for i:=1 to MaxPopupHCmds do    { header area popup menu }
  begin
  PopupHItems[i].Enabled := (FPopupHMask and BitMask <> 0);
  BitMask := BitMask shl 1;
  end;
ChangedSetup;
end;


(******************************************************************)
function TNTabEd.GetDecPlaces (ColNr: longint): shortint;
(******************************************************************
ENTRY: ColNr ..... number of column

EXIT:  function returns the number of decimal places set for the
       specified column
*******************************************************************)

begin
if (ColNr >= 1) and (ColNr <= NrOfColumns)
  then GetDecPLaces := DecPArray(FDecP^)[ColNr]
  else GetDecPlaces := 0;
end;


(******************************************************************)
procedure TNTabEd.AutoColWidth (ColNr: longint; IncludeHeader: boolean;
                                Addon: integer);
(******************************************************************
  ENTRY: ColNr ........... number of column to be adjusted
                             1..n = data columns
                                0 = row names
                               -1 = class attributes
         IncludeHeader ... TRUE: width is header is included
         AddOn ........... number of pixels to add to optimum width

  EXIT:  width of specified column is adjusted such that all data are
         available (including the header, if IncludeHeader eq. TRUE).
 ******************************************************************)

var
  MinWidth : integer;
  i        : integer;
  s        : string;
  ix       : integer;

begin
MinWidth := 0;
case colnr of
   0 : begin
       MinWidth := Canvas.TextWidth ('999:9999');  { cursor cell width }
       for i:=1 to FNrOfRows do
         begin
         ix := Canvas.TextWidth (NameArray(FRowName^)[i]);
         if (ix > MinWidth) then
           MinWidth := ix;
         end;
       end;
  -1 : begin
       if IncludeHeader
         then MinWidth := Canvas.TextWidth ('Attrib')  { 'Attrib' is min. width }
         else MinWidth := Canvas.textWidth ('255');
       end;
  else begin
       if (colNr > 0) and (colNr <= FNrOfCols) then
         begin
         if IncludeHeader
           then MinWidth := Canvas.TextWidth (NameArray(FColName^)[ColNr])
           else MinWidth := 0;
         ix := Canvas.TextWidth (strff(GetColAttrib(ColNr),1,0));
         if (ix > MinWidth) then
           MinWidth := ix;
         for i:=1 to FNrOfRows do
           begin
           S := FormatData (FData.Elem[ColNr{-FColOffset}, i-FRowOffset], FNumWidth, DecpArray(FDecP^)[ColNr{-FColOffset}]);
           ix := Canvas.TextWidth (S);
           if (ix > MinWidth) then
             MinWidth := ix;
           end;
         end;
       end;
end;
MinWidth := 8+MinWidth+Addon;
if MinWidth < 4 then
 MinWidth := 4;
SetColWidths (ColNr, MinWidth);
FLastCellX := Selection.Left;
FLastCellY := Selection.Top;
end;


(******************************************************************)
procedure TNTabEd.SetColWidths(Index: Longint; Value: Integer);
(******************************************************************
  ENTRY:    Index ..... index of column: 1..n = data columns
                                            0 = row names
                                           -1 = class names

  EXIT:     width of indicated column is set
******************************************************************)

begin
if Index > 0                               (*&&*)
  then inherited ColWidths[Index+FColOffset] := value { data columns }
  else begin
       if index = 0
         then inherited COlWidths[0] := value            { row names }
         else begin
              if FColOffset > 0 then                    { class info }
                begin
                inherited ColWidths[1] := value;
                FClassColWidth := value;
                end;
              end;
       end;
ChangedSetup;
end;

(******************************************************************)
procedure TNTabEd.AssignAnotherDataMatrix (NewDMat: TMatrix);
(******************************************************************)

begin
Redimension (NewDMat.NrOfColumns, NewDMat.NrOfRows);
if not FExtMatAssigned then
  FData.Free;   { destroy native matrix and assign the external matrix }
FData := NewDMat;
FData.OnChange := FDataHasChanged;
FExtMatAssigned := true;
end;

(******************************************************************)
procedure TNTabEd.CopyContentsFrom (ExtTab: TNTabEd);
(******************************************************************)

var
  i, j  : integer;

begin
FSuppressPaint := true;
Redimension (ExtTab.NrOfColumns, ExtTab.NrOfRows);
for i:=1 to NrOfColumns do
  begin
  ColName[i] := ExtTab.ColName[i];
  ColAttrib[i] := ExtTab.ColAttrib[i];
  for j:=1 to NrOfRows do
    Elem[i,j] := ExtTab.elem[i,j];
  end;
for i:=1 to NrOfRows do
  begin
  RowName[i] := ExtTab.RowName[i];
  RowAttrib[i] := ExtTab.RowAttrib[i];
  end;
for i:=1 to NrOfColumns do
  for j:=1 to NrOfRows do
    CellState[i,j] := ExtTab.CellState[i,j];
FSuppressPaint := false;
end;


(***********************************************************************)
procedure TNTabEd.SetNrCols (NrCols: longint);
(***********************************************************************)

var
  PDummy         : pointer;
  OldCol         : longint;
  OldRow         : longint;
  i,j            : longint;
  MinCols        : longint;
  WidthOfLastCol : integer;
  LastColDecP    : shortint;

begin
WidthOfLastCol := inherited ColWidths[ColCount-1];
OldCol := FNrOfCols;
OldRow := FNrOfRows;
FNrOfCols := NrCols;
ColCount := NrCols + FColOffset + 1;
for i:=OldCol to FNrOfCols do
  inherited ColWidths[i + FColOffset] := WidthOfLastCol;
FData.Resize (FNrOfCols, FNrOfRows);

GetMem (PDummy, FNrOfCols*FNrOfRows);   { adjust list of Marked elements }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       FillChar (PDummy^, FNrOfRows*FNrOfCols, 0);
       for i:=1 to MinCols do
         for j:=1 to OldRow do
           StateArray(PDummy^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*OldCol+i];
       FreeMem (FCState, OldCol*OldRow);
       FCState := PDummy;
       end;

GetMem (PDummy, sizeof(NameStrType)*FNrOfCols);    { adjust size of header list }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       for i:=1 to MinCols do
         NameArray(PDummy^)[i] := NameArray(FColName^)[i];
       for i:=MinCols+1 to FNrOfCols do
         NameArray(PDummy^)[i] := 'C-'+strff(i,1,0);
       FreeMem (FColName, sizeof(NameStrType)*OldCol);
       FColName := PDummy;
       end;

GetMem (PDummy, sizeof(byte)*FNrOfCols);    { adjust size of attribute info }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       for i:=1 to MinCols do
         AttribArray(PDummy^)[i] := AttribArray(FColAtt^)[i];
       for i:=MinCols+1 to FNrOfCols do
         AttribArray(PDummy^)[i] := 0;
       FreeMem (FColAtt, sizeof(byte)*OldCol);
       FColAtt := PDummy;
       end;

GetMem (PDummy, sizeof(shortint)*FNrOfCols);    { adjust decimal places }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       LastColDecP := DecPArray(FDecP^)[OldCol];
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       for i:=1 to MinCols do
         DecPArray(PDummy^)[i] := DecPArray(FDecP^)[i];
       for i:=MinCols+1 to FNrOfCols do
         DecPArray(PDummy^)[i] := LastColDecP;
       FreeMem (FDecP, sizeof(byte)*OldCol);
       FDecP := PDummy;
       end;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.SetNrRows (NrRows: longint);
(***********************************************************************)

var
  PDummy          : pointer;
  OldCol          : longint;
  OldRow          : longint;
  i,j             : longint;
  MinRows         : longint;
  HeightOfLastRow : integer;

begin
HeightOfLastRow := RowHeights[RowCount-1];
OldCol := FNrOfCols;
OldRow := FNrOfRows;
FNrOfRows := NrRows;
RowCount := NrRows + FRowOffset + 1;
for i:=OldRow to FNrOfRows do
  RowHeights[i+FRowOffset] := HeightOfLastRow;
FData.Resize (FNrOfCols, FNrOfRows);

GetMem (PDummy, FNrOfCols*FNrOfRows);   { adjust list of Marked elements }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       MinRows := FNrOfRows;
       if OldRow < MinRows then
         MinRows := OldRow;
       FillChar (PDummy^, FNrOfRows*FNrOfCols, 0);
       for i:=1 to OldCol do
         for j:=1 to MinRows do
           StateArray(PDummy^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*OldCol+i];
       FreeMem (FCState, OldCol*OldRow);
       FCState := PDummy;
       end;

GetMem (PDummy, sizeof(NameStrType)*FNrOfRows);    { adjust size of header list }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       MinRows := FNrOfRows;
       if OldRow < MinRows then
         MinRows := OldRow;
       for i:=1 to MinRows do
         NameArray(PDummy^)[i] := NameArray(FRowName^)[i];
       for i:=MinRows+1 to FNrOfRows do
         NameArray(PDummy^)[i] := 'R-'+strff(i,1,0);
       FreeMem (FRowName, sizeof(NameStrType)*OldRow);
       FRowName := PDummy;
       end;

GetMem (PDummy, sizeof(byte)*FNrOfRows);    { adjust size of class info }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       MinRows := FNrOfRows;
       if OldRow < MinRows then
         MinRows := OldRow;
       for i:=1 to MinRows do
         AttribArray(PDummy^)[i] := AttribArray(FRowAtt^)[i];
       for i:=MinRows+1 to FNrOfRows do
         AttribArray(PDummy^)[i] := 0;
       FreeMem (FRowAtt, sizeof(byte)*OldRow);
       FRowAtt := PDummy;
       end;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.Redimension (NrCols, NrRows: longint);
(***********************************************************************)

var
  PDummy          : pointer;
  OldCol          : longint;
  OldRow          : longint;
  i,j             : longint;
  MinCols         : longint;
  MinRows         : longint;
  WidthOfLastCol  : integer;
  HeightOfLastRow : integer;
  LastColDecP     : shortint;

begin
WidthOfLastCol := inherited ColWidths[ColCount-1];
OldCol := FNrOfCols;
OldRow := FNrOfRows;
FNrOfCols := NrCols;
FNrOfRows := NrRows;
ColCount := NrCols + FColOffset + 1;
for i:=OldCol to FNrOfCols do
  inherited ColWidths[i + FColOffset] := WidthOfLastCol;
HeightOfLastRow := RowHeights[RowCount-1];
RowCount := NrRows + FRowOffset + 1;
for i:=OldRow to FNrOfRows do
  RowHeights[i+FRowOffset] := HeightOfLastRow;
FData.Resize (FNrOfCols, FNrOfRows);

GetMem (PDummy, FNrOfCols*FNrOfRows);   { adjust list of Marked elements }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       MinRows := FNrOfRows;
       if OldRow < MinRows then
         MinRows := OldRow;
       FillChar (PDummy^, FNrOfRows*FNrOfCols, 0);
       for i:=1 to MinCols do
         for j:=1 to MinRows do
           StateArray(PDummy^)[(j-1)*FNrOfCols+i] := StateArray(FCState^)[(j-1)*OldCol+i];
       FreeMem (FCState, OldCol*OldRow);
       FCState := PDummy;
       end;

GetMem (PDummy, sizeof(NameStrType)*FNrOfCols);    { adjust size of header list }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       for i:=1 to MinCols do
         NameArray(PDummy^)[i] := NameArray(FColName^)[i];
       for i:=MinCols+1 to FNrOfCols do
         NameArray(PDummy^)[i] := 'C-'+strff(i,1,0);
       FreeMem (FColName, sizeof(NameStrType)*OldCol);
       FColName := PDummy;
       end;

GetMem (PDummy, sizeof(NameStrType)*FNrOfRows);    { adjust size of header list }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       MinRows := FNrOfRows;
       if OldRow < MinRows then
         MinRows := OldRow;
       for i:=1 to MinRows do
         NameArray(PDummy^)[i] := NameArray(FRowName^)[i];
       for i:=MinRows+1 to FNrOfRows do
         NameArray(PDummy^)[i] := 'R-'+strff(i,1,0);
       FreeMem (FRowName, sizeof(NameStrType)*OldRow);
       FRowName := PDummy;
       end;

GetMem (PDummy, sizeof(byte)*FNrOfRows);    { adjust size of row attribute info }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       MinRows := FNrOfRows;
       if OldRow < MinRows then
         MinRows := OldRow;
       for i:=1 to MinRows do
         AttribArray(PDummy^)[i] := AttribArray(FRowAtt^)[i];
       for i:=MinRows+1 to FNrOfRows do
         AttribArray(PDummy^)[i] := 0;
       FreeMem (FRowAtt, sizeof(byte)*OldRow);
       FRowAtt := PDummy;
       end;

GetMem (PDummy, sizeof(byte)*FNrOfCols);    { adjust size of column attribute info }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       for i:=1 to MinCols do
         AttribArray(PDummy^)[i] := AttribArray(FColAtt^)[i];
       for i:=MinCols+1 to FNrOfCols do
         AttribArray(PDummy^)[i] := 0;
       FreeMem (FColAtt, sizeof(byte)*OldCol);
       FColAtt := PDummy;
       end;

GetMem (PDummy, sizeof(shortint)*FNrOfCols);    { adjust decimal places }
if PDummy = NIL
  then raise ESDLNTabedError.Create ('NTABED: not enough memory on heap')
  else begin
       LastColDecP := DecPArray(FDecP^)[OldCol];
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       for i:=1 to MinCols do
         DecPArray(PDummy^)[i] := DecPArray(FDecP^)[i];
       for i:=MinCols+1 to FNrOfCols do
         DecPArray(PDummy^)[i] := LastColDecP;
       FreeMem (FDecP, sizeof(byte)*OldCol);
       FDecP := PDummy;
       end;
ChangedSetup;
end;



(***********************************************************************)
function TNTabEd.GetRowAttVis: boolean;
(***********************************************************************)

begin
if FColOffset > 0
  then GetRowAttVis := true
  else GetRowAttVis := false;
end;

(***********************************************************************)
function TNTabEd.GetColAttVis: boolean;
(***********************************************************************)

begin
if FRowOffset > 0
  then GetColAttVis := true
  else GetColAttVis := false;
end;



(***********************************************************************)
procedure TNTabEd.SetNumWidth (nw: integer);
(***********************************************************************)

begin
if (nw > 0) and (nw <= 20) then
  begin
  FNumWidth := nw;
  Paint;
  end;
ChangedSetup;
end;


(***********************************************************************)
procedure TNTabEd.SetRowAttVis (vis: boolean);
(***********************************************************************)


var
  i : integer;

begin
if (vis and (FColOffset = 0)) or (not vis and (FColOffset = 1)) then
  begin
  if vis
    then begin          { class info visible }
         FixedCols := 2;
         FColOffset := 1;
         ColCount := FNrOfCols + FColOffset + 1;
         for i:=ColCount-1 downto 2 do
           inherited ColWidths[i] := inherited ColWidths[i-1];
         inherited ColWidths[1] := FClassCOlWidth;
         end
    else begin          { class info not visible }
         FixedCols := 1;
         FColOffset := 0;
         for i:=1 to ColCount-2 do
           inherited ColWidths[i] := inherited ColWidths[i+1];
         ColCount := FNrOfCols + FColOffset + 1;
         end;
  ChangedSetup;
  end;
end;


(***********************************************************************)
procedure TNTabEd.SetColAttVis (vis: boolean);
(***********************************************************************)


var
  i : integer;

begin
if (vis and (FRowOffset = 0)) or (not vis and (FRowOffset = 1)) then
  begin
  if vis
    then begin          { class info visible }
         FixedRows := 2;
         FRowOffset := 1;
         RowCount := FNrOfRows + FRowOffset + 1;
         for i:=RowCount-1 downto 2 do
           inherited RowHeights[i] := inherited RowHeights[i-1];
         inherited RowHeights[1] := inherited RowHeights[0];
         end
    else begin          { class info not visible }
         FixedRows := 1;
         FRowOffset := 0;
         for i:=1 to RowCount-2 do
           inherited RowHeights[i] := inherited RowHeights[i+1];
         RowCount := FNrOfRows + FRowOffset + 1;
         end;
  ChangedSetup;
  end;
end;



(***********************************************************************)
procedure TNTabEd.DrawCell(ACol, ARow: Longint; ARect: TRect;
                               AState: TGridDrawState);
(***********************************************************************)

const
  LeftSpace = 3;     { distance between cell border and its text }
  TopSpace = 2;
  RightSpace = 3;

var
  S     : string;
  cs    : byte;
  BRect : TRect;
  astr  : string;

begin
dec(ARect.Right,RightSpace);
inc(ARect.Left,LeftSpace);
inc(ARect.Top,TopSPace);
if (ACol > FColOffset) and (Arow > FRowOffset)
  then begin                                         { data matrix values }
       cs := StateArray(FCState^)[(ARow-1-FRowOffset)*FNrOfCols+ACol-FColOffset];
       if cs and not (csMarkedA+csMarkedB) = 0
         then S := FormatData (FData.Elem[ACol-FColOffset, ARow-FRowOffset], FNumWidth, DecpArray(FDecP^)[ACol-FColOffset])
         else begin
              if (cs and csNAN) = 1                        { not a number }
                then S := 'NAN'
                else S := '';                                { empty cell }
              end;
       case cs and (csMarkedA+csMarkedB) of
         csMarkedA           : Canvas.Font.Color := FColorMarked1;
         csMarkedB           : Canvas.Font.Color := FColorMarked2;
         csMarkedA+csMarkedB : Canvas.Font.Color := FColorMarkedBoth;
         $0                  : begin
                               if not(gdSelected in AState) then
                                 Canvas.Font.Color := FColorNormal;
                               end;
       end;
       Canvas.textRect(ARect, ARect.Left, ARect.Top, s);
       end
  else begin
       if Arow <= FRowOffset
         then begin           { cell is either in header or attribute row }
              if ARow = 0
                then begin                        { cell is in header row }
                     if ACol > FColOffset
                       then begin                { cell is column headers }
                            if Acol = Selection.Left
                              then Canvas.Font.Color := FColorSelected
                              else Canvas.Font.Color := FColorNormal;
                            Canvas.textRect (ARect, ARect.Left, ARect.Top, NameArray(FColName^)[ACol-FColOffset]);
                            end
                       else begin
                            if ACol = 0
                              then begin  { cell is in pointer area [0,0] }
                                   if FCommentMMActive
                                     then begin
                                          Canvas.Brush.Color := clTeal;
                                          Canvas.Font.Color := clWhite;
                                          end
                                     else begin
                                          Canvas.Font.Color := FColorNormal;
                                          Canvas.Brush.Color := clWindow;
                                          end;
                                   BRect := Arect;
                                   inc(BRect.Right,RightSpace);
                                   dec(BRect.Left,LeftSpace);
                                   dec(BRect.Top,TopSPace);
                                   if not FCommentMMActive
                                     then Canvas.textRect (BRect, ARect.Left, ARect.Top,    { col/row index }
                                                    IntToStr(Selection.Left-FColOffset)+':'+
                                                    IntToStr(Selection.Top-FRowOffset))
                                     else begin
                                        {$IFDEF LANG_GERMAN}
                                          astr := 'Kommentar:';
                                        {$ELSE}
                                          astr := 'Comment:';
                                        {$ENDIF}
                                          Canvas.textRect (BRect, ARect.Left, ARect.Top, astr);
                                          end;
                                   end
                              else begin           { cell is class header }
                                   Canvas.textRect (ARect, ARect.Left, ARect.Top, 'Attrib');
                                   end;
                            end;
                     end
                else begin                     { cell is in attribute row }
                     if ACol > FColOffset
                       then begin              { cell is column attribute }
                            if Acol = Selection.Left
                              then Canvas.Font.Color := FColorSelected
                              else Canvas.Font.Color := FColorNormal;
                            Canvas.textRect (ARect, ARect.Left, ARect.Top,
                                      strff(AttribArray(FColAtt^)[ACol-FColOffset],1,0));
                            end
                       else begin              { cell is attribute header }
                            if ACol = 0 then
                              Canvas.textRect (ARect, ARect.Left, ARect.Top, 'Attribute');
                            end;
                     end;
              end
         else begin                                 { cell is in data row }
              if ACol = 0
                then begin                   { row name }
                     if ARow = Selection.Top
                       then Canvas.Font.Color := FColorSelected
                       else Canvas.Font.Color := FColorNormal;
                     Canvas.textRect (ARect, ARect.Left, ARect.Top, NameArray(FRowName^)[ARow-FRowOffset]);
                     end
                else begin
                     if FColOffset <> 0 then { class number }
                       begin
                       if ARow = Selection.Top
                         then Canvas.Font.Color := FColorSelected
                         else Canvas.Font.Color := FColorNormal;
                       Canvas.textRect (ARect, ARect.Left, ARect.Top,
                                        strff(AttribArray(FRowAtt^)[ARow-FRowOffset],1,0));
                       end;
                     end;

              end;
       end;
end;



(******************************************************************)
function TNTabEd.GetEditText(ACol, ARow: Longint): string;
(******************************************************************)

begin
Result := FormatData (FData.Elem[ACol-FColOffset, ARow-FRowOffset], FNumWidth, DecpArray(FDecP^)[ACol-FColOffset]);
if Assigned(FOnGetEditText) then FOnGetEditText(Self, ACol, ARow, Result);
end;

(******************************************************************)
procedure TNTabEd.SetEditText(ACol, ARow: Longint; const Value: string);
(******************************************************************)

var
  auxNum : double;
  status : integer;
  astr   : string;

begin
astr := ReplaceCharInString (value, ',', '.');
val (astr, AuxNum, status);
if status = 0 then
  FData.Elem[ACol-FColOffset, ARow-FRowOffset] := AuxNum;
inherited SetEditText(ACol, ARow, Value);
if Assigned(FOnSetEditText) then FOnSetEditText(Self, ACol, ARow, Value);
end;


(******************************************************************)
procedure TNTabEd.Keypress (var Key: char);
(******************************************************************)

var
  KeyDum : word;

begin
inherited Keypress (Key);
if FAutoAdvance and ((Key = #0) or (Key = #13)) then
  begin
  KeyDum := VK_DOWN;
  KeyDown (KeyDum, []);
  end;
end;


(******************************************************************)
procedure TNTabEd.KeyDown(var Key: Word; Shift: TShiftState);
(******************************************************************)

var
  ARect  : TRect;

begin
inherited KeyDown (Key, Shift);
ARect := Cellrect (0,0);                      { show col/row index }
Canvas.Font.Color := FColorNormal;
Canvas.Brush.Color := clWindow;
Canvas.textRect (ARect, ARect.Left+LeftSpace, ARect.Top+TopSpace,
                 IntToStr(Selection.Left-FColOffset)+':'+
                 IntToStr(Selection.Top-FRowOffset));
end;


(******************************************************************)
procedure TNTabEd.SetColName (ColNr: longint; HLine: NameStrType);
(******************************************************************
ENTRY: ColNr ..... number of column
       HLine ..... text of header

EXIT:  Header 'Hline' is associated with the specified column
*******************************************************************)

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols) then
  begin
  NameArray(FColName^)[ColNr] := HLine;
  Changed;
  Paint;
  end;
end;


(******************************************************************)
procedure TNTabEd.SetRowName (RowNr: longint; HLine: NameStrType);
(******************************************************************
ENTRY: RowNr ..... number of row
       HLine ..... text of row identifier

EXIT:  Header 'Hline' is associated with the specified row
*******************************************************************)

begin
if (RowNr >= 1) and (RowNr <= FNrOfRows) then
  begin
  NameArray(FRowName^)[RowNr] := HLine;
  Changed;
  Paint;
  end;
end;


(******************************************************************)
function TNTabEd.GetColName (ColNr: longint): NameStrType;
(******************************************************************
ENTRY: ColNr ..... number of column

EXIT:  function returns text of column header
*******************************************************************)

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols)
  then GetColName := NameArray(FColName^)[ColNr]
  else GetColName := '';
end;


(******************************************************************)
function TNTabEd.GetRowName (RowNr: longint): NameStrType;
(******************************************************************
ENTRY: RowNr ..... number of row

EXIT:  function returns text of row identifier
*******************************************************************)

begin
if (RowNr >= 1) and (RowNr <= FNrOfRows)
  then GetRowName := NameArray(FRowName^)[RowNr]
  else GetRowName := '';
end;

(******************************************************************)
function TNTabEd.GetRowAttrib (RowNr: longint): byte;
(******************************************************************
ENTRY: RowNr ..... number of row

EXIT:  function returns the class number of the specified row
*******************************************************************)

begin
if (RowNr >= 1) and (RowNr <= FNrOfRows)
  then GetRowAttrib := AttribArray(FRowAtt^)[RowNr]
  else GetRowAttrib := 0;
end;


(******************************************************************)
procedure TNTabEd.SetRowAttrib (RowNr: longint; Attrib: byte);
(******************************************************************
ENTRY: RowNr ..... number of row
       Attrib .... class information

EXIT:  Class information is set
*******************************************************************)

begin
if (RowNr >= 1) and (RowNr <= FNrOfRows) then
  begin
  AttribArray(FRowAtt^)[RowNr] := Attrib;
  Paint;
  Changed;
  end;
end;


(******************************************************************)
function TNTabEd.GetColAttrib (ColNr: longint): byte;
(******************************************************************
ENTRY: ColNr ..... number of column

EXIT:  function returns the attribute number of the specified column
*******************************************************************)

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols)
  then GetColAttrib := AttribArray(FColAtt^)[ColNr]
  else GetColAttrib := 0;
end;


(******************************************************************)
procedure TNTabEd.SetColAttrib (ColNr: longint; Attrib: byte);
(******************************************************************
ENTRY: ColNr ..... number of column
       Attrib .... attribute

EXIT:  Attribute is set
*******************************************************************)

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols) then
  begin
  AttribArray(FColAtt^)[ColNr] := Attrib;
  Paint;
  Changed;
  end;
end;


(******************************************************************)
procedure TNTabEd.SetDefColWidth (DefW: integer);
(******************************************************************)

begin
inherited DefaultColWidth := DefW;
inherited ColWidths[0] := 80;
if FColOffset = 1 then
  inherited ColWidths[1] := FClassColWidth;
ChangedSetup;
end;

(******************************************************************)
function TNTabEd.GetDefColWidth: integer;
(******************************************************************)

begin
GetDefColWidth := inherited DefaultColWidth;
end;

(******************************************************************)
procedure TNTabEd.Fill (value: double);
(******************************************************************)

begin
FData.Fill (Value);
end;

(******************************************************************)
procedure TNTabEd.ExportASCFile (FName: string; Precision: integer);
(******************************************************************)

var
  TFile : TextFile;
  i,j   : integer;

begin
SuppressPaint := true;
assignFile (TFile, FName);
rewrite (TFile);
FComment := ReplaceCharInString (FComment, #10, ' ');
if length (FComment) > 0
  then writeln (TFile, FComment)
  else writeln (TFile, 'Exported by NTabED component: ',FName);
writeln (TFile, NrOfColumns, #9, ';nr. of columns');
writeln (TFile, NrOfRows, #9, ';nr. of rows');
writeln (TFile, 'TRUE TRUE TRUE', #9, ';row attributes, column names, row names');
for i:=1 to NrOfColumns do   { save name of columns }
  begin
  ColName[i] := StripLTBlanks(ColName[i]);
  if pos (' ', ColName[i]) > 0
    then write (TFile, #9, '"'+ReplaceStringInString(ColName[i], '"', '""', true)+'"')
    else write (TFile, #9, ReplaceStringInString(ColName[i],'"','""', true));
  end;
writeln (TFile);
for i:=1 to NrOfRows do
  begin
  RowName[i] := StripLTBlanks(RowName[i]);
  if pos (' ', RowName[i]) > 0
    then write (TFile, RowAttrib[i], #9, '"'+ReplaceStringInString(RowName[i],'"','""', true)+'"')
    else write (TFile, RowAttrib[i], #9, ReplaceStringInString(RowName[i],'"','""', true));
  for j:=1 to NrOfColumns do
//    write (TFile, #9, Elem[j,i]:Precision+8);
    write (TFile, #9, strff(Elem[j,i],1,Precision));
  writeln (TFile);
  end;
closeFile (TFile);
SuppressPaint := false;
end;


(******************************************************************)
procedure TNTabEd.ExportASCStream (OutStream: TStream; Precision: integer);
(******************************************************************)

var
  i,j   : integer;
  astr  : string;

begin
SuppressPaint := true;
if length (FComment) > 0
  then writelnStream (OutStream, FComment)
  else writelnStream (OutStream, 'Exported by NTabED component');
writelnStream (OutStream, IntToStr(NrOfColumns)+#9+';nr. of columns');
writelnStream (OutStream, IntToStr(NrOfRows)+#9+';nr. of rows');
writelnStream (OutStream, 'TRUE TRUE TRUE'+#9+';row attributes, column names, row names');
astr := '';
for i:=1 to NrOfColumns do   { save name of columns }
  begin
  ColName[i] := StripLTBlanks(ColName[i]);
  if pos (' ', ColName[i]) > 0
    then astr := astr + #9 + '"'+ReplaceStringInString(ColName[i],'"','""', true)+'"'
    else astr := astr + #9 + ReplaceStringInString(ColName[i],'"','""', true);
  end;
writelnStream (OutStream, astr);
for i:=1 to NrOfRows do
  begin
  astr := '';
  RowName[i] := StripLTBlanks(RowName[i]);
  if pos (' ', RowName[i]) > 0
    then astr := astr + IntToStr(RowAttrib[i])+#9+'"'+ReplaceStringInString(RowName[i],'"','""', true)+'"'
    else astr := astr + IntToStr(RowAttrib[i])+#9+ReplaceStringInString(RowName[i],'"','""', true);
  for j:=1 to NrOfColumns do
    astr := astr + #9 + strff(Elem[j,i],1,Precision);
  writelnStream (OutStream, astr);
  end;
SuppressPaint := false;
end;


(******************************************************************)
function TNTabed.ParseVarName (cc: char; var CurrentVName: string): boolean;
(******************************************************************
  finite state machine to read variable names
  ENTRY: cc ......... next character to be entered

  EXIT:  CurrentVName .. variable name built up so far
         function returns true if var name is complete
 ******************************************************************)


var
  NextState : TvnStates;

begin
NextState := vsStart;
case FVNState of
     vsStart : begin
               case cc of
                 #0..' ': begin   { do nothing }
                          NextState := vsStart;
                          end;
                     '"': begin
                          NextState := vs1stQuote;
                          end;
               else begin
                    NextState := vsNormal;
                    FVNName := FVNName + cc;
                    end;
               end;
               end;
  vs1stQuote : begin
               case cc of
                 #0..' ': begin
                          NextState := vsEnd;
                          end;
                     '"': begin
                          NextState := vsNormal;
                          FVNName := FVNName + cc;
                          end;
               else begin
                    NextState := vsQuote;
                    FVNName := FVNName + cc;
                    end;
               end;
               end;
     vsQuote : begin
               case cc of
                 #0..' ': begin
                          NextState := vsQuote;
                          FVNName := FVNName + cc;
                          end;
                     '"': begin
                          NextState := vsNormal;
                          end;
               else begin
                    NextState := vsQuote;
                    FVNName := FVNName + cc;
                    end;
               end;
               end;
    vsNormal : begin
               case cc of
                 #0..' ': begin
                          NextState := vsEnd;
                          end;
                     '"': begin
                          NextState := vs1stQuote;
                          end;
               else begin
                    NextState := vsNormal;
                    FVNName := FVNName + cc;
                    end;
               end;
               end;
end;
CurrentVName := FVNName;
if NextState = vsEnd
  then begin
       FVNState := vsStart;
       FVNName := '';
       end
  else FVNState := NextState;
ParseVarName := (NextState = vsEnd);
end;


(******************************************************************)
function TNTabEd.ImportASCFile (FName: string; LastFirstPart: boolean): integer;
(******************************************************************
  ENTRY:  FName ............ name of ASC file
          LastFirstPart .... this flag provides information on how to
                             process the data in case of too large a
                             data matrix;
                             TRUE:  last part of data is used to read
                                    into max. table,
                             FALSE: first part of data is read

  EXIT:   function codes returned indicate error condition:
               0 .... no error
              -1 .... error in specification of number of features
              -2 .... error in specification of number of objects
              -3 .... error in ClInf/NamFeat/NamObj flags
              -4 .... out of memory
              -5 .... invalid class information
              -6 .... invalid numeric data
 ******************************************************************)

(*&& column attributes *)

var
  error       : integer;
  dcomment    : string;
  NFeat, NObj : integer;
  ClInf,
  NamFeat,
  NamObj      : boolean;
  InFile      : TextFile;
  MaxLengObjName : integer;

function readOneObject (ObjNum: integer): integer;
(*----------------------------------------------*)

var
  rdummy      : real;
  cc          : char;
  j           : integer;
  error       : integer;
  astr        : string;

begin
error := 0;
if CLInf then
  begin
  {$I-} read (Infile, rdummy); {$I+}
  if IOResult = 0
    then AttribArray(FRowAtt^)[ObjNum] := lo(round(rdummy)) { byte ! }
    else error := -5;
  end;
if ((error = 0) and NamObj) then
  begin
  FVNState := vsStart;
  FVNName := '';
  repeat
    read (Infile, cc);
  until ParseVarName (cc, astr);
  NameArray(FRowName^)[ObjNum] := astr;
  if Canvas.TextWidth(astr) > MaxLengObjName then
    MaxLengObjName := Canvas.TextWidth(astr);
  end;
if error = 0 then
  begin
  j := 0;
  while ((j < FNrOfCols) and (error = 0)) do
    begin
    inc (j);
    {$I-} read (Infile, rdummy); {$I+}
    if IOResult = 0
      then FData.Elem [j,ObjNum] := rdummy
      else error := -6;
    end;
  end;
ReadOneObject := error;
Changed;
end;



var
  i, k      : integer;
  hstr      : string;
  nrowfirst : integer;
  cc        : char;
  astr      : string;

begin
MaxLengObjName := 80;
SuppressPaint := true;
FData.OnChange := nil;             { trick to prevent multiple OnChange events }
error := ReadHeaderOfASCFile (FName, dComment, NFeat, NObj,
                              ClInf, NamFeat, NamObj);
if error = 0 then
  begin
  FComment := dComment;
  assignFile (Infile, FName);
  reset (Infile);
  for i:= 1 to 4 do     (* overread header *)
    readln (Infile, hstr);
  NRowFirst := 0;
{$IFDEF VER80}
  if 1.0*NFeat*NObj > TableMaxElem then  (* check if table size ok *)
    begin
    if LastFirstPart
      then begin
           i := TableMaxElem div NFeat;
           nrowfirst := NObj-i;   (* namenskonflikt nrow !! *)
           nObj := i;
           end
      else begin
           nObj := TableMaxElem div NFeat;
           nrowfirst := 0;
           end;
    end;
{$ENDIF}
  if FDecP <> NIL then
    FreeMem (FDecP, sizeof(shortint)*FNrOfCols);
  if FCState <> NIL then
    FreeMem (FCState, FNrOfCols*FNrOfRows);
  if FRowAtt <> NIL then
    FreeMem (FRowAtt, FNrOfRows);
  if FColAtt <> NIL then
    FreeMem (FColAtt, FNrOfCols);
  if FColName <> NIL then
    FreeMem (FColName, sizeof(NameStrType)*FNrOfCols);
  if FRowName <> NIL then
    FreeMem (FRowName, sizeof(NameStrType)*FNrOfRows);
  FData.Free;
  FNrOfCols := NFeat;
  FNrOfRows := NObj;
  FData := TMatrix.Create (NFeat, NObj);
  GetMem (FColName, sizeof(NameStrType)*FNrOfCols);
  if FColName <> NIL then
    for i:=1 to FNrOfCols do
      NameArray(FColName^)[i] := 'C-'+strff(i,1,0);
  GetMem (FRowName, sizeof(NameStrType)*FNrOfRows);
  if FRowName <> NIL then
    for i:=1 to FNrOfRows do
      NameArray(FRowName^)[i] := 'R-'+strff(i,1,0);
  GetMem (FDecP, sizeof(shortint)*NFeat);
  if FDecP <> NIL then
    for i:=1 to NFeat do
      DecPArray(FDecP^)[i] := 3;
  GetMem (FCState, NFeat*NObj);
  if FCState <> NIL then
    FillChar (FCState^, NObj*NFeat, 0);
  GetMem (FRowAtt, sizeof(byte)*NObj);
  if FRowAtt <> NIL then
    for i:=1 to NObj do                 { set class number to zero }
      AttribArray(FRowAtt^)[i] := 0;
  GetMem (FColAtt, sizeof(byte)*NFeat);
  if FColAtt <> NIL then
    for i:=1 to NFeat do           { set column attributes to zero }
      AttribArray(FColAtt^)[i] := 0;
  if (FData = NIL) or (FDecP = NIL) or (FCState = NIL) or
     (FRowAtt = NIL) or (FColName = NIL) or (FRowName = NIL)
    then error := -4                        { error: out of memory }
    else begin
         if NamFeat then
           begin
           k:=1;                                  { feature names }
           FVNState := vsStart;
           FVNName := '';
           repeat
             repeat
               read (Infile, cc);
             until ParseVarName (cc, astr);
             if (k <= FNrOfCols) then
               NameArray(FColName^)[k] := astr;
             inc (k);
           until (k > NFeat);
           end;
         if NRowFirst > 0 then
           begin
           i := 0;
           while ((error = 0) and (i < NRowFirst)) do            { overread data }
             begin
             inc (i);
             error := ReadOneObject (i);
             end;
           end;
         i:=0;
         while ((error = 0) and (i < NObj)) do            { data }
           begin
           inc (i);
           error := ReadOneObject (i);
           end;
         SetNrRows (NObj);
         SetNrCols (NFeat);
         end;
  closeFile (Infile);
  Colwidths[0] := MaxLengObjName;
  end;
FData.OnChange := FDataHasChanged;          { switch on event processing again }
FData.OnSortExchange := ExchangeDuringSort;
SuppressPaint := false;
changed;
ImportASCFile := error;
end;


(******************************************************************)
function TNTabEd.ImportASCStream (InStream: TStream): integer;
(******************************************************************
  ENTRY:  InStream ......... stream of ASC data

  EXIT:   function codes returned indicate error condition:
               0 .... no error
              -1 .... error in specification of number of features
              -2 .... error in specification of number of objects
              -3 .... error in ClInf/NamFeat/NamObj flags
              -4 .... out of memory
              -5 .... invalid class information
 ******************************************************************)

(*&& column attributes *)

var
  error       : integer;
  dcomment    : string;
  NFeat, NObj : integer;
  ClInf,
  NamFeat,
  NamObj      : boolean;
  MaxLengObjName : integer;

function readOneObject (ObjNum: integer): integer;
(*----------------------------------------------*)

var
  rdummy      : real;
  cc          : char;
  j           : integer;
  error       : integer;
  astr        : string;

begin
error := 0;
if CLInf then
  begin
  rdummy := ScanStreamFPNum (Instream, true, 3);
  if IOResult = 0
    then AttribArray(FRowAtt^)[ObjNum] := lo(round(rdummy)) { byte ! }
    else error := -5;
  end;
if ((error = 0) and NamObj) then
  begin
  FVNState := vsStart;
  FVNName := '';
  repeat
    Instream.read (cc, 1);
  until ParseVarName (cc, astr);
  NameArray(FRowName^)[ObjNum] := astr;
  if Canvas.TextWidth(astr) > MaxLengObjName then
    MaxLengObjName := Canvas.TextWidth(astr);
  end;
if error = 0 then
  begin
  j := 0;
  while ((j < FNrOfCols) and (error = 0)) do
    begin
    inc (j);
    rdummy := ScanStreamFPNum (Instream, true, 3);
    FData.Elem [j,ObjNum] := rdummy
    end;
  end;
ReadOneObject := error;
Changed;
end;



var
  i, k      : integer;
  nrowfirst : integer;
  cc        : char;
  astr      : string;

begin
MaxLengObjName := 80;
SuppressPaint := true;
FData.OnChange := nil;             { trick to prevent multiple OnChange events }
error := ReadHeaderOfASCStream (InStream, dComment, NFeat, NObj, ClInf, NamFeat, NamObj);
if error = 0 then
  begin
  FComment := dComment;
  NRowFirst := 0;
  if FDecP <> NIL then
    FreeMem (FDecP, sizeof(shortint)*FNrOfCols);
  if FCState <> NIL then
    FreeMem (FCState, FNrOfCols*FNrOfRows);
  if FRowAtt <> NIL then
    FreeMem (FRowAtt, FNrOfRows);
  if FColAtt <> NIL then
    FreeMem (FColAtt, FNrOfCols);
  if FColName <> NIL then
    FreeMem (FColName, sizeof(NameStrType)*FNrOfCols);
  if FRowName <> NIL then
    FreeMem (FRowName, sizeof(NameStrType)*FNrOfRows);
  FData.Free;
  FNrOfCols := NFeat;
  FNrOfRows := NObj;
  FData := TMatrix.Create (NFeat, NObj);
  GetMem (FColName, sizeof(NameStrType)*FNrOfCols);
  if FColName <> NIL then
    for i:=1 to FNrOfCols do
      NameArray(FColName^)[i] := 'C-'+strff(i,1,0);
  GetMem (FRowName, sizeof(NameStrType)*FNrOfRows);
  if FRowName <> NIL then
    for i:=1 to FNrOfRows do
      NameArray(FRowName^)[i] := 'R-'+strff(i,1,0);
  GetMem (FDecP, sizeof(shortint)*NFeat);
  if FDecP <> NIL then
    for i:=1 to NFeat do
      DecPArray(FDecP^)[i] := 3;
  GetMem (FCState, NFeat*NObj);
  if FCState <> NIL then
    FillChar (FCState^, NObj*NFeat, 0);
  GetMem (FRowAtt, sizeof(byte)*NObj);
  if FRowAtt <> NIL then
    for i:=1 to NObj do                 { set class number to zero }
      AttribArray(FRowAtt^)[i] := 0;
  GetMem (FColAtt, sizeof(byte)*NFeat);
  if FColAtt <> NIL then
    for i:=1 to NFeat do           { set column attributes to zero }
      AttribArray(FColAtt^)[i] := 0;
  if (FData = NIL) or (FDecP = NIL) or (FCState = NIL) or
     (FRowAtt = NIL) or (FColName = NIL) or (FRowName = NIL)
    then error := -4                        { error: out of memory }
    else begin
         if NamFeat then
           begin
           k:=1;                                  { feature names }
           FVNState := vsStart;
           FVNName := '';
           repeat
             repeat
               Instream.read (cc, 1);
             until ParseVarName (cc, astr);
             if (k <= FNrOfCols) then
               NameArray(FColName^)[k] := astr;
             inc (k);
           until (k > NFeat);
           end;
         if NRowFirst > 0 then
           begin
           i := 0;
           while ((error = 0) and (i < NRowFirst)) do            { overread data }
             begin
             inc (i);
             error := ReadOneObject (i);
             end;
           end;
         i:=0;
         while ((error = 0) and (i < NObj)) do            { data }
           begin
           inc (i);
           error := ReadOneObject (i);
           end;
         SetNrRows (NObj);
         SetNrCols (NFeat);
         end;
  Colwidths[0] := MaxLengObjName;
  end;
FData.OnChange := FDataHasChanged;          { switch on event processing again }
FData.OnSortExchange := ExchangeDuringSort;
SuppressPaint := false;
changed;
ImportASCStream := error;
end;


(******************************************************************)
function TNTabEd.ReadFromASCFile (FName: string; PosX, PosY: longint;
                                  ReplaceIDs: boolean): integer;
(******************************************************************
  ENTRY:  FName ............ name of ASC file
          PosX, PosY ....... position of read Table (upper left corner)
          ReplaceIDs ....... TRUE: original object and feature names are replaced

  EXIT:   function codes returned indicate error condition:
               0 .... no error
              -1 .... error in specification of number of features
              -2 .... error in specification of number of objects
              -3 .... error in ClInf/NamFeat/NamObj flags
              -5 .... invalid class information
              -6 .... invalid numeric data
 ******************************************************************)

var
  error       : integer;
  comment     : string;
  NFeat, NObj : integer;
  ClInf,
  NamFeat,
  NamObj      : boolean;
  InFile      : TextFile;

function readOneObject (ObjNum: integer): integer;
(*----------------------------------------------*)

var
  rdummy      : real;
  cc          : char;
  j           : integer;
  error       : integer;
  astr        : string;

begin
error := 0;
if CLInf then
  begin
  {$I-} read (Infile, rdummy); {$I+}
  if IOResult = 0
    then begin
         if (ObjNum+PosY-1 <= FNrOfRows) then
           AttribArray(FRowAtt^)[ObjNum+PosY-1] := lo(round(rdummy)); { byte ! }
         end
    else error := -5;
  end;
if ((error = 0) and NamObj) then
  begin
  FVNState := vsStart;
  FVNName := '';
  repeat
    read (Infile, cc);
  until ParseVarName (cc, astr);
  if ReplaceIDs and (ObjNum+PosY-1 <= FNrOfRows) then
    NameArray(FRowName^)[ObjNum+PosY-1] := astr;
  end;
if error = 0 then
  begin
  j := 0;
  while ((j < NFeat) and (error = 0)) do
    begin
    inc (j);
    {$I-} read (Infile, rdummy); {$I+}
    if IOResult = 0
      then begin
           if (ObjNum+PosY-1 <= FNrOfRows) and (j+PosX-1 <= FNrOfCols) then
             FData.Elem [j+PosX-1,ObjNum+PosY-1] := rdummy;
           end
      else error := -6;
    end;
  end;
ReadOneObject := error;
end;



var
  i, k      : integer;
  astr      : string;
  cc        : char;

begin
SuppressPaint := True;
FData.OnChange := nil;             { trick to prevent multiple OnChange events }
error := ReadHeaderOfASCFile (FName, Comment, NFeat, NObj,
                              ClInf, NamFeat, NamObj);
if error = 0 then
  begin
  assignFile (Infile, FName);
  reset (Infile);
  for i:= 1 to 4 do     (* overread header *)
    readln (Infile, astr);
  if NamFeat then
    begin
    k:=1;                         { features names }
    FVNState := vsStart;
    FVNName := '';
    repeat
      repeat
        read (Infile, cc);
      until ParseVarName (cc, astr);
      if ReplaceIDs and (k+PosX-1 <= FNrOfCols) then
        NameArray(FColName^)[k+PosX-1] := astr;
      inc (k);
    until (k > NFeat);
    end;
  i:=0;
  while ((error = 0) and (i < NObj)) do            { data }
    begin
    inc (i);
    error := ReadOneObject (i);
    end;
  closeFile (Infile);
  end;
FData.OnChange := FDataHasChanged;          { switch on event processing again }
SuppressPaint := false;
changed;
ReadFromASCFile := error;
end;



(******************************************************************)
function TNTabEd.ReadHeaderOfASCFile (FName: string;
               var Comment: string; var NFeat, NObj: integer;
               var ClInf, NamFeat, NamObj: boolean): integer;
(******************************************************************
  ENTRY:  FName ..... name of ASC file to be read

  EXIT:   Comment ... comment line of header
          NFeat ..... number of features
          NObj ...... number of objects
          ClInf ..... TRUE if class info is included
          NamFeat ... TRUE if names are included
          NamObj .... TRUE if object names are included

  This method reads the ASC file specified by 'FName' and returns the
  above mentioned parameters. In addition, an error number is returned
  as function result with the following meaning:
       0 .... no error
      -1 .... error in specification of number of features
      -2 .... error in specification of number of objects
      -3 .... error in ClInf/NamFeat/NamObj flags
      -4 .... file stored probably in UNIX format
 ******************************************************************)

var
  error   : integer;
  hstr    : string;
  Infile  : TextFile;

begin
error := 0;
assignFile (InFile, FName);
reset (InFile);
readln (InFile,Comment);                      (* head line *)
if pos(#10, comment) > 0 then
  error := -4;
{$I-} readln (Infile, NFeat); {$I+}       (* number of features *)
if IOResult <> 0 then
  error := -1;
if error = 0 then
  begin
  {$I-} readln (Infile, NObj); {$I+}           (* number of rows *)
  if IOResult <> 0 then
    error := -2;
  end;
if error = 0 then
  begin
  ClInf := False;
  NamFeat := False;
  NamObj := False;
  readln (Infile,hstr);   (* flags: class info, feat names, obj names *)
  hstr := StripLTBlanks(upperCase(hstr));
  if copy (hstr,1,4) = 'TRUE'
    then CLInf := TRUE
    else begin
         if copy (hstr,1,5) = 'FALSE'
           then CLInf := FALSE
           else error := -3;
         end;
  if error = 0 then
    begin
    if ClInf
      then delete (hstr,1,4)
      else delete (hstr,1,5);
    hstr := StripLTBlanks(hstr);
    if copy (hstr,1,4) = 'TRUE'
      then NamFeat := TRUE
      else begin
           if copy (hstr,1,5) = 'FALSE'
             then NamFeat := FALSE
             else error := -3;
           end;
    if error = 0 then
      begin
      if NamFeat
        then delete (hstr,1,4)
        else delete (hstr,1,5);
      hstr := StripLTBlanks(hstr);
      if copy (hstr,1,4) = 'TRUE'
        then NamObj := TRUE
        else begin
             if copy (hstr,1,5) = 'FALSE'
               then NamObj := FALSE
               else error := -3;
             end;
      end;
    end;
  end;
closeFile (Infile);
ReadHeaderOfASCFile := error;
end;


(******************************************************************)
function TNTabEd.ReadHeaderOfASCStream (InStream: TStream;
               var Comment: string; var NFeat, NObj: integer;
               var ClInf, NamFeat, NamObj: boolean): integer;
(******************************************************************
  ENTRY:  InStream .. stream containing the ASC data file

  EXIT:   Comment ... comment line of header
          NFeat ..... number of features
          NObj ...... number of objects
          ClInf ..... TRUE if class info is included
          NamFeat ... TRUE if names are included
          NamObj .... TRUE if object names are included

  This method reads the ASC data file contained in 'InStream' and returns the
  above mentioned parameters. In addition, an error number is returned
  as function result with the following meaning:
       0 .... no error
      -1 .... error in specification of number of features
      -2 .... error in specification of number of objects
      -3 .... error in ClInf/NamFeat/NamObj flags
      -4 .... file stored probably in UNIX format
 ******************************************************************)

var
  error   : integer;
  astr    : string;
  eos     : boolean;

begin
error := 0;
Comment := readlnStream (InStream, eos, 0);                      (* head line *)
if pos(#10, comment) > 0 then
  error := -4;
NFeat := ScanStreamDecimal (InStream);                  (* number of features *)
astr := readlnStream (InStream, eos, 0);                      (* rest of line *)
if IOResult <> 0 then
  error := -1;
if error = 0 then
  begin
  NObj := ScanStreamDecimal (InStream);                     (* number of rows *)
  astr := readlnStream (InStream, eos, 0);                    (* rest of line *)
  if IOResult <> 0 then
    error := -2;
  end;
if error = 0 then
  begin
  ClInf := False;
  NamFeat := False;
  NamObj := False;
  astr := readlnStream (InStream, eos, 0); (* flags: class info, feat names, obj names *)
  astr := StripLTBlanks(upperCase(astr));
  if copy (astr,1,4) = 'TRUE'
    then CLInf := TRUE
    else begin
         if copy (astr,1,5) = 'FALSE'
           then CLInf := FALSE
           else error := -3;
         end;
  if error = 0 then
    begin
    if ClInf
      then delete (astr,1,4)
      else delete (astr,1,5);
    astr := StripLTBlanks(astr);
    if copy (astr,1,4) = 'TRUE'
      then NamFeat := TRUE
      else begin
           if copy (astr,1,5) = 'FALSE'
             then NamFeat := FALSE
             else error := -3;
           end;
    if error = 0 then
      begin
      if NamFeat
        then delete (astr,1,4)
        else delete (astr,1,5);
      astr := StripLTBlanks(astr);
      if copy (astr,1,4) = 'TRUE'
        then NamObj := TRUE
        else begin
             if copy (astr,1,5) = 'FALSE'
               then NamObj := FALSE
               else error := -3;
             end;
      end;
    end;
  end;
ReadHeaderOfASCStream := error;
end;

(******************************************************************)
function TNTabEd.ReadFromASCStream (InStream: TStream; PosX, PosY: longint;
                                    ReplaceIDs: boolean): integer;
(******************************************************************
  ENTRY:  Instream ......... stream containing ASC file
          PosX, PosY ....... position of read Table (upper left corner)
          ReplaceIDs ....... TRUE: original object and feature names are replaced

  EXIT:   function codes returned indicate error condition:
               0 .... no error
              -1 .... error in specification of number of features
              -2 .... error in specification of number of objects
              -3 .... error in ClInf/NamFeat/NamObj flags
 ******************************************************************)

var
  error       : integer;
  comment     : string;
  NFeat, NObj : integer;
  ClInf,
  NamFeat,
  NamObj      : boolean;

function readOneObject (ObjNum: integer): integer;
(*----------------------------------------------*)

var
  rdummy      : real;
  cc          : char;
  j           : integer;
  error       : integer;
  astr        : string;

begin
error := 0;
if CLInf then
  begin
  rdummy := ScanStreamFPNum (Instream, true, 3);
  if (ObjNum+PosY-1 <= FNrOfRows) then
    AttribArray(FRowAtt^)[ObjNum+PosY-1] := lo(round(rdummy)); { byte ! }
  end;
if ((error = 0) and NamObj) then
  begin
  FVNState := vsStart;
  FVNName := '';
  repeat
    Instream.read (cc, 1);
  until ParseVarName (cc, astr);
  if ReplaceIDs and (ObjNum+PosY-1 <= FNrOfRows) then
    NameArray(FRowName^)[ObjNum+PosY-1] := astr;
  end;
if error = 0 then
  begin
  j := 0;
  while ((j < NFeat) and (error = 0)) do
    begin
    inc (j);
    rdummy := ScanStreamFPNum (Instream, true, 3);
    if (ObjNum+PosY-1 <= FNrOfRows) and (j+PosX-1 <= FNrOfCols) then
      FData.Elem [j+PosX-1,ObjNum+PosY-1] := rdummy;
    end;
  end;
ReadOneObject := error;
end;


var
  i, k      : integer;
  astr      : string;
  cc        : char;
  eos       : boolean;

begin
SuppressPaint := True;
FData.OnChange := nil;             { trick to prevent multiple OnChange events }
error := ReadHeaderOfASCStream (InStream, Comment, NFeat, NObj,
                              ClInf, NamFeat, NamObj);
if error = 0 then
  begin
  if NamFeat then
    begin
    k:=1;                         { features names }
    FVNState := vsStart;
    FVNName := '';
    repeat
      repeat
        Instream.read (cc, 1);
      until ParseVarName (cc, astr);
      if ReplaceIDs and (k+PosX-1 <= FNrOfCols) then
        NameArray(FColName^)[k+PosX-1] := astr;
      inc (k);
    until (k > NFeat);
    astr := readlnStream (InStream, eos, 0);                     (* rest of line *)
    end;
  i:=0;
  while ((error = 0) and (i < NObj)) do                                 { data }
    begin
    inc (i);
    error := ReadOneObject (i);
    end;
  end;
FData.OnChange := FDataHasChanged;          { switch on event processing again }
SuppressPaint := false;
changed;
ReadFromASCStream := error;
end;


(******************************************************************)
procedure TNTabEd.SetFComment (cmt: string);
(******************************************************************)

var
  i : integer;

begin
for i:=1 to length(cmt) do
  if ord(cmt[i]) < $20 then
    delete (cmt, i, 1);
FComment := cmt;
Changed;
end;

(******************************************************************)
function TNTabEd.GetElem (ACol, ARow: longint): double;
(******************************************************************)

begin
Result := FData.Elem [ACol,ARow];
end;


(******************************************************************)
procedure TNTabEd.SetElem (ACol, ARow: longint; const Value: double);
(******************************************************************)

begin
FData.Elem[ACol,ARow] := value;
end;

(******************************************************************)
function TNTabEd.GetElemMarkedA (ACol, ARow: longint): boolean;
(******************************************************************)

begin
Result := (StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] and csMarkedA) = csMarkedA;
end;

(******************************************************************)
function TNTabEd.GetElemMarkedB (ACol, ARow: longint): boolean;
(******************************************************************)

begin
Result := (StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] and csMarkedB) = csMarkedB;
end;

(******************************************************************)
function TNTabEd.GetCellState (ACol, ARow: longint): byte;
(******************************************************************)

begin
Result := StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol];
end;



(******************************************************************)
procedure TNTabEd.SetElemMarkedA (ACol, ARow: longint;
                                  const Value: boolean);
(******************************************************************)

begin
if (ACol >= 1) and (Acol <= FNrOfCols) and
   (ARow >= 1) and (ARow <= FNrOfRows) then
  begin
  if value
    then StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] := StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] or csMarkedA
    else StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] := StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] and not csMarkedA;
  end;
Paint;
ChangedSetup;
end;

(******************************************************************)
procedure TNTabEd.SetElemMarkedB (ACol, ARow: longint;
                                  const Value: boolean);
(******************************************************************)

begin
if (ACol >= 1) and (Acol <= FNrOfCols) and
   (ARow >= 1) and (ARow <= FNrOfRows) then
  begin
  if value
    then StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] := StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] or csMarkedB
    else StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] := StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] and not csMarkedB;
  end;
Paint;
ChangedSetup;
end;

(******************************************************************)
procedure TNTabEd.SetCellState (ACol, ARow: longint; const Value: byte);
(******************************************************************)

begin
if (ACol >= 1) and (Acol <= FNrOfCols) and
   (ARow >= 1) and (ARow <= FNrOfRows) then
  begin
  if StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] <> value then
    StateArray(FCState^)[(ARow-1)*FNrOfCols+ACol] := value;
  end;
Paint;
ChangedSetup;
end;


(******************************************************************)
function TNTabEd.IfRowMarked (row: longint): boolean;
(******************************************************************
ENTRY: row  ... row of data to be checked

EXIT:  TRUE if any element in specified row is marked
*******************************************************************)

var
  AnySelect : byte;
  i         : integer;

begin
if (Row >= 1) and (Row <= NrOfRows)
  then begin
       AnySelect := 0;
       for i:=1 to NrOfColumns do
         AnySelect := AnySelect or StateArray(FCState^)[(Row-1)*NrOfColumns+i];
       IfRowMarked := (AnySelect and (csMarkedA+csMarkedB)) <> 0;
       end
  else IfRowMarked := FALSE;
end;



(******************************************************************)
function TNTabEd.IfColumnMarked (col: longint): boolean;
(******************************************************************
ENTRY: col  ... column of data to be checked

EXIT:  TRUE if any element in specified column is marked
*******************************************************************)

var
  AnySelect : byte;
  i         : integer;

begin
if (Col >= 1) and (Col <= NrOfColumns)
  then begin
       AnySelect := 0;
       for i:=1 to NrOfRows do
         AnySelect := AnySelect or StateArray(FCState^)[(i-1)*NrOfColumns+col];
       IfColumnMarked := (AnySelect and (csMarkedA+csMarkedB)) <> 0;
       end
  else IfColumnMarked := FALSE;
end;


(******************************************************************)
procedure TNTabEd.UnMarkAllElems;
(******************************************************************
ENTRY: -

EXIT:  all data are deselected
*******************************************************************)

var
  i,j : integer;

begin
for i:=1 to NrOfColumns do
  for j:=1 to NrOfRows do
    StateArray(FCState^)[(j-1)*NrOfColumns+i] := StateArray(FCState^)[(j-1)*NrOfColumns+i] and not (csMarkedA+csMarkedB);
ChangedSetup;
end;

(******************************************************************)
procedure TNTabEd.MarkAllElemsA;
(******************************************************************
ENTRY: -

EXIT:  all data are selected
*******************************************************************)

var
  i,j : integer;

begin
for i:=1 to NrOfColumns do
  for j:=1 to NrOfRows do
    StateArray(FCState^)[(j-1)*NrOfColumns+i] := csMarkedA or StateArray(FCState^)[(j-1)*NrOfColumns+i];
ChangedSetup;
end;

(******************************************************************)
procedure TNTabEd.MarkAllElemsB;
(******************************************************************
ENTRY: -

EXIT:  all data are selected
*******************************************************************)

var
  i,j : integer;

begin
for i:=1 to NrOfColumns do
  for j:=1 to NrOfRows do
    StateArray(FCState^)[(j-1)*NrOfColumns+i] := csMarkedB or StateArray(FCState^)[(j-1)*NrOfColumns+i];
ChangedSetup;
end;


(******************************************************************)
procedure TNTabEd.MouseDown (Button: TMouseButton; Shift: TShiftState;
                             X, Y: Integer);
(******************************************************************)

var
  ARect      : TRect;
  cc         : char;
  astr       : string;

procedure HighLightSelCell (cx, cy: integer);
(*-----------------------------------------*)

begin
Canvas.Brush.Color := clBtnFace;

ARect := Cellrect (cx,0);
ARect.Bottom := ARect.Bottom-2;
DrawCell (cx, 0, ARect, [gdFixed]);
if FRowOffset > 0 then
  begin
  ARect := Cellrect (cx,1);
  ARect.Bottom := ARect.Bottom-2;
  DrawCell (cx, 1, ARect, [gdFixed]);
  end;

ARect := Cellrect (0, cy);
ARect.Bottom := ARect.Bottom-2;
DrawCell (0, cy, ARect, [gdFixed]);
if FColOffset > 0 then
  begin
  ARect := Cellrect (1, cy);
  ARect.Bottom := ARect.Bottom-2;
  DrawCell (1, cy, ARect, [gdFixed]);
  end;
end;


begin
if FCommentMMActive
  then begin
       inherited MouseDown (Button, Shift, X, Y);
       GridCell := MouseCoord (X,Y);
       if (GridCell.X = 0) and (GridCell.Y = 0) then
         begin
         cc := #27;
         CommentMemoKeyPress (self, cc);
         end;
       end
  else begin
       if not FNameEdActive then {don't process mouse click if ID editor is active}
         begin
         inherited MouseDown (Button, Shift, X, Y);
         if (X > 0) and (Y > 0) and (X < GridWidth) and (Y < GridHeight) then
           begin                        { process click only if within grid area }
           GridCell := MouseCoord (X,Y);
           LastMouseClkX := X;
           LastMouseClkY := Y;
           if (GridCell.X > FColOffset) and (GridCell.Y > FRowOffset)
             then begin                                      { process data area }
                  if Button = mbRight then       { right click = popup menu }
                    begin
                    if goEditing in Options
                      then begin
                           FPopupD.Items[8].Caption := 'Disable Editing';
                           {$IFDEF VER120}
                           FPopupD.Items[8].BitMap.LoadFromResourceName (hinstance, 'CROSS');
                           {$ENDIF}
                           end
                      else begin
                           FPopupD.Items[8].Caption := 'Enable Editing';
                           {$IFDEF VER120}
                           FPopupD.Items[8].BitMap.LoadFromResourceName (hinstance, 'CHECKMRK');
                           {$ENDIF}
                           end;
                    FPopupD.popup (x+Left+parent.Left,y+Top+parent.top+30);
                    end;
                  if Button = mbLeft then    { left click = change selection index }
                    begin
                    if (FLastCellX > -1) or (FLastCellY > -1) then  // highlight selection column
                      begin
                      HighLightSelCell (FLastCellX, FLastCellY);
                      end;
                    FLastCellX := GridCell.X;
                    FLastCellY := GridCell.Y;
                    HighLightSelCell (FLastCellX, FLastCellY);

                    ARect := Cellrect (0,0);           { display coordinates }
                    Canvas.Brush.Color := clWindow;
                    Canvas.Font.Color := FColorNormal;
                    Canvas.textRect (ARect, ARect.Left+LeftSpace, ARect.Top+TopSpace,
                                     IntToStr(Selection.Left-FColOffset)+':'+
                                     IntToStr(Selection.Top-FRowOffset)); { col/row index }
                    end;
                  end
             else begin                                    { process header area }
                  if (GridCell.X = 0) and (GridCell.Y = 0) and (button = mbRight) then
                    begin                    { edit comment only }
                    ARect := Cellrect (0,0);
                    Canvas.Brush.Color := clTeal;
                    Canvas.Font.Color := clWhite;
                  {$IFDEF LANG_GERMAN}
                    astr := 'Kommentar:';
                  {$ELSE}
                    astr := 'Comment:';
                  {$ENDIF}
                    Canvas.textRect (ARect, ARect.Left+LeftSpace, ARect.Top+TopSpace, astr);
                    FCommentMM.Left := ColWidths[0];
                    FCommentMM.Top := 0;
                    FCommentMM.Width := Width-ColWidths[0]-20;
                    FCommentMM.Height := 80;
                    FCommentMM.Text := FComment;
                    FCommentMM.Color := clTeal;
                    FCommentMM.Font.Color := clWhite;
                    FCommentMM.Show;
                    FCommentMM.SetFocus;
                    FCommentMMActive := true;
                    end;
                  if (GridCell.X > FColOffset) or (GridCell.Y > FRowOffset) then { click into headers }
                    begin
                    if button = mbRight then         { only right clicks are valid }
                      begin
                      FPopupH.Items[0].Enabled := true;
                      if GridCell.X <= FColOffset     { precision only for columns }
                        then FPopupH.Items[2-1].Enabled := false
                        else FPopupH.Items[2-1].Enabled := true;
                      ARect := Cellrect (GridCell.X,GridCell.Y);
                      Canvas.Pen.mode := pmNot;
                      Canvas.Rectangle (ARect.Left, Arect.Top, ARect.Right+1, ARect.Bottom+1);
                      Canvas.Pen.mode := pmCopy;
                      FPopupH.popup (ARect.Left+Left+parent.Left+30,ARect.Bottom+top+parent.top+25);
                      Canvas.Pen.mode := pmNot;
                      Canvas.Rectangle (ARect.Left, Arect.Top, ARect.Right+1, ARect.Bottom+1);
                      Canvas.Pen.mode := pmCopy;
                      end;
                    end;
                  end;
           end;
         end;
       end;
end;



(******************************************************************)
procedure Register;
(******************************************************************)

begin
RegisterComponents ('SDL', [TNTabEd]);
end;


end.



