unit replist;

(******************************************************************)
(*                                                                *)
(*                         R E P L I S T                          *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1999..2001 H. Lohninger                  Feb.  1999    *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jul-09, 2001                                  *)
(*                                                                *)
(******************************************************************)

{
Version  Changes
--------------------------------------------------------------------
1.0   Apr-11, 1999
      first version to be released

5.0   Oct-09, 1999
      REPLIST is now available for Delphi 5.0
      PopupMenu is now available
      ScrollBars are now available
      properties ColorHigh, ColorHighText,
             HighLightRow, and HighLightColumn implemented
      property HighLightBold implemented
      property AsNumber implemented
      bug fix: property NrOfRows cannot be set to zero any more,
      property LastSortColumn implemented
      property LastSortOrder implemented
      property TopRow, LeftCol, VisibleColCount, and VisibleRowCount are now available
      array property RowSelected implemented
      selection of multiple rows implemented (property RowSelectMode)
      properties ColorSelected, ColorSelectedText implemented
      method DeselectAllRows implemented
      TReportListView is now decendant of TDrawGrid ---> drag is now available
      bug fix: RemoveRow now works correctly with sorted string arrays
      InsertRow implemented
      DblClick event is no longer triggered if clicked into column header section

5.5   Jun-01, 2000
      Arrows, Home, End and Page Up/Dwn keys move now selection AND highlighted row
      Highlighting is now adjusted in MouseUp event
      Sorting by mouse click on header now displays an hourglass cursor
      inherited OnDrawCell event is now executed
      property IsCheckedColumn introduced
      property ElemChecked implemented
      event OnCheckedChange implemented
      property ColumnEditable implemented
      selection of rows is now possible only with left mouse button
      InPlaceEditor is now publicly available
      selection of multiple columns implemented (array property ColumnSelected)
      properties ColorSelectedRow, ColorSelectedRowText replace ColorSelected and COlorSelectedText
      properties ColorSelectedCol, ColorSelectedColText implemented
      properties ColorSelectedBoth, ColorSelectedBothText implemented
      method DeselectAllColumns implemented
      functions FirstSelectedColumn and FirstSelectedRow implemented
      all Colors are set to clInActiveCaption if Enabled = False
      methods SelectAllColumns and SelectAllRows implemented
      event OnSelectedChange implemented
      available for C++Builder 5.0
      new methods SaveAsXMLFile, WriteToOpenXMLFile, LoadFromXMLFile and ReadFromOpenXMLFile
      bug fix: Scrollbars are now correctly spelled (and thus available in C++Builder without
          modification of the hpp file)

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      RemoveRow now clears all elements of row if called with last row in RepList
      NumSelectedRows, NumSelectedColumns implemented
      bug fix: invalid selection does no longer create "grid out of range" error
      ExpandColWidth implemented
      Assign method implemented
      new methods ReadFromXMLStream and WriteToXMLStream implemented
      new property ColumnIsPwd implemented
      new property Comment implemented
      bug fix: LoadfromXMLFile does not crash if file is not available
      bug fix: OnSetEditText and OnGetEditText are now triggered correctly
}


{$R-}

{-$DEFINE SHAREWARE}
{ If this switch is turned on, the 'hint'-property is set during startup
  in order to indicate an unregistered shareware version. In addition, an
  indication of the shareware status is given in the chart area if the
  Delphi IDE is not up and running }

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

{------------------------------------------------------------------}
interface
{------------------------------------------------------------------}

uses
  sysutils, WinTypes, WinProcs, Messages, Classes, Graphics, controls, grids,
  dstruct;


const
  NameWidth = 50;                        { maximum length of col/row names }


type
  TNameStrType  = string[NameWidth];                    { col/row header type }
  TRepListXmlTag = (xmlNumCols, xmlNumRows, xmlColName, xmlCheckedColumn, xmlCell,
                    xmlComment, xmlEndReplist, xmlInvalid);
  TCheckStateChangeEvent = procedure (Sender: TObject; State: boolean;
                                         Col, Row: longint) of object;
  TReportListView = class(TDrawGrid)
            private
              FAutoAdvance      : boolean;         { TRUE: go to next cell on CR }
              FComment          : string;              { user comment on network }
              FLastMousePosX    : integer;   { mouse position - triggered by MouseMove event }
              FLastMousePosY    : integer;
              FOnChange         : TNotifyEvent;
              FOnChangeSetup    : TNotifyEvent;
              FOnSelectedChange : TNotifyEvent;
              FColName          : pointer;                        { column names }
              FColChecked       : pointer; { indicates whether column is checked }
              FColumnEditable   : pointer; {indicates whether column is read-only}
              FColumnIsPwd      : pointer;{indicates whether column contains pwds}
              FNrOfCols         : longint;    { number of columns of data matrix }
              FNrOfRows         : longint;    { number of columns of data matrix }
              FSelectAnchor     : longint;        { index of last row ckicked on }
              FRowSelectMode    : integer;{ no/single/multiple selection of rows }
              FSortEnabled      : boolean;                { is sorting allowed ? }
              FSortColumn       : longint;
              FSortOrder        : boolean;
              FOnChkStChange    : TCheckStateChangeEvent;
              FOnGetEditText    : TGetEditEvent;
              FOnSetEditText    : TSetEditEvent;
              FSelRowColor      : TColor;                { color of selected row }
              FSelRowTextColor  : TColor;           { color of selected row text }
              FSelColColor      : TColor;             { color of selected column }
              FSelColTextColor  : TColor;        { color of selected column text }
              FSelBothColor     : TColor;     { color of selected row and column }
              FSelBothTextColor : TColor;{color of selected row and column text }
              FHiLgtColor       : TColor;
              FHiLgtTextColor   : TColor;
              FHiLgtBold        : boolean;
              FHiLgtRow         : longint;
              FHiLgtColumn      : longint;
              FSuppressPaint    : boolean;      { TRUE: suppress all paint calls }
              FSortToggle       : boolean;           { toggle switch for sorting }
              FColorNormal      : TColor;               { color of unmarked text }
              FRColorNormal     : TColor;       { color of normal row background }
              FRColorShaded     : TColor;       { color of shaded row background }
              FRowColPattern    : integer;                     { shading pattern }

              function  GetAsNumber (ACol, ARow: longint): double;
              function  GetColName (ColNr: longint): TNameStrType;
              function  GetCheckedCol (ColNr: longint): boolean;
              function  GetColWidths(Index: Longint): Integer;
              function  GetDefColWidth: integer;
              function  GetDefRowHeight: integer;
              function  GetElem (ACol, ARow: longint): ShortString;
              function  GetElemChecked (ACol, ARow: longint): boolean;
              function  GetColumnEditable (ColNr: longint): boolean;
              function  GetColumnIsPwd (ColNr: longint): boolean;
              function  GetColSelect (c: longint): boolean;
              function  GetRowSelect (r: longint): boolean;
              function  ProcessXmlTag (xmlTag: TRepListXmlTag; attr, cont: string): integer;
              procedure StringsHasChanged (Sender: TObject);
              procedure SetSuppressPaint (supp: boolean);
              procedure SetColName (ColNr: longint; HLine: TNameStrType);
              procedure SetCheckedCol (ColNr: longint; Value: boolean);
              procedure SetColorNormal (color: TColor);
              procedure SetColWidths(Index: Longint; Value: Integer);
              procedure SetDefColWidth (DefW: integer);
              procedure SetDefRowHeight (DefH: integer);
              procedure SetColPattern (colpat: integer);
              procedure SetElem (ACol, ARow: longint; const Value: ShortString);
              procedure SetElemChecked (ACol, ARow: longint; const Value: boolean);
              procedure SetNrCols (NrCols: longint);
              procedure SetNrRows (NrRows: longint);
              procedure SetRColorNormal (color: TColor);
              procedure SetRColorShaded (color: TColor);
              procedure SetColumnEditable (ColNr: longint; Value: boolean);
              procedure SetColumnIsPwd (ColNr: longint; Value: boolean);
              procedure SetColSelect (c: longint; value: boolean);
              procedure SetRowSelect (r: longint; value: boolean);
              procedure SetRowSelectMode (mode: integer);
              procedure SetColorSelectedRow (color: TColor);
              procedure SetColorSelectedRowText (color: TColor);
              procedure SetColorSelectedCol (color: TColor);
              procedure SetColorSelectedColText (color: TColor);
              procedure SetColorSelectedBoth (color: TColor);
              procedure SetColorSelectedBothText (color: TColor);
              procedure SetColorHi (color: TColor);
              procedure SetColorHiText (color: TColor);
              procedure SetHighLightBold (Bold: boolean);
              procedure SetHighLightRow (ARow: longint);
              procedure SetHighLightColumn (ACol: longint);
            protected
              procedure AssignTo (Dest: TPersistent); override;
              procedure Paint; override;
              procedure Keypress (var Key: char); override;
              procedure KeyDown(var Key: Word; Shift: TShiftState); override;
              function  GetEditText(ACol, ARow: Longint): string; override;
              procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
              procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
              procedure CheckStateHasChanged (State: boolean; col, row: longint);
              procedure DblClick; override;
              function  SelectCell(ACol, ARow: longint): boolean; override;
              procedure MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
              procedure MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
              procedure DrawCell (ACol, ARow: Longint; ARect: TRect;
                                  AState: TGridDrawState); override;
            public
              Strings   : TStringArray;
              constructor Create(AOwner: TComponent); override;
              destructor  Destroy; override;
              function  AddRow: longint;
              property  AsNumber [ACol, ARow: longint]: double read GetAsNumber;
              procedure Assign (Source: TPersistent); override;
              procedure AutoColWidth (ColNr: longint; IncludeHeader: boolean; Addon: integer);
              procedure Changed;
              procedure ChangedSetup;
              procedure ChangedSelection;
              property  Comment: string read FComment write FComment;
              procedure DeselectAllRows;
              procedure DeselectAllColumns;
              property  Elem[ACol, ARow: longint]: ShortString read GetElem write SetElem; default;
              property  ElemChecked[ACol, ARow: longint]: boolean read GetElemChecked write SetElemChecked;
              procedure Fill (s: ShortString);
              function  FirstSelectedColumn: longint;
              function  FirstSelectedRow: longint;
              procedure Clear;
              property  ColWidths[Index: Longint]: Integer read GetColWidths write SetColWidths;
              property  ColumnSelected[r: longint]: boolean read GetColSelect write SetColSelect;
              procedure ExpandColWidth (ColIx: longint);
              property  Header[ColNr: longint]: TNameStrType read GetColName write SetColName;
              procedure InsertRow (r: longint);
              property  IsCheckedColumn[ColNr: longint]: boolean read GetCheckedCol write SetCheckedCol;
              property  ColumnEditable[ColNr: longint]: boolean read GetColumnEditable write SetColumnEditable;
              property  ColumnIsPwd[ColNr: longint]: boolean read GetColumnIsPwd write SetColumnIsPwd;
              property  LastSortColumn: longint read FSortColumn;
              property  LastSortOrder: boolean read FSortOrder;
              function  LoadFromXMLFile (FName: string; DataID: string): boolean;
              function  NumSelectedRows: longint;
              function  NumSelectedColumns: longint;
              function  ReadFromXMLStream (InStream: TStream; DataID: string): boolean;
              function  ReadFromOpenXMLFile (var InFile : TextFile; DataID: string): boolean;
              procedure RemoveRow (r: longint);
              property  RowSelected[r: longint]: boolean read GetRowSelect write SetRowSelect;
              procedure SaveAsXMLFile (FName: string; DataID: string);
              procedure SelectAllColumns;
              procedure SelectAllRows;
              property  Selection;
              property  InplaceEditor;
              procedure Sort (Col: longint; Ascending: boolean);
              procedure UnSort;
              property  SuppressPaint: boolean read FSuppressPaint write SetSuppressPaint;
              procedure WriteToOpenXMLFile (var OutFile: TextFile; CreateHeader: boolean; DataID: string);
              procedure WriteToXMLStream (OutStream: TStream; CreateHeader: boolean; DataID: string);
            published
              property  Align;
              property  AutoAdvance: boolean read FAutoAdvance write FAutoAdvance;
              property  ColorText: TColor read FColorNormal write SetColorNormal;
              property  ColorBkgdNormal: TColor read FRColorNormal write SetRColorNormal;
              property  ColorBkgdShaded: TColor read FRColorShaded write SetRColorShaded;
              property  DefaultColWidth: integer read GetDefColWidth write SetDefColWidth;
              property  DefaultRowHeight: integer read GetDefRowHeight write SetDefRowHeight;
              property  ColorHigh: TColor read FHiLgtColor write SetColorHi;
              property  ColorHighText: TColor read FHiLgtTextColor write SetColorHiText;
              property  ColorSelectedRow: TColor read FSelRowColor write SetColorSelectedRow;
              property  ColorSelectedRowText: TColor read FSelRowTextColor write SetColorSelectedRowText;
              property  ColorSelectedCol: TColor read FSelColColor write SetColorSelectedCol;
              property  ColorSelectedColText: TColor read FSelColTextColor write SetColorSelectedColText;
              property  ColorSelectedBoth: TColor read FSelBothColor write SetColorSelectedBoth;
              property  ColorSelectedBothText: TColor read FSelBothTextColor write SetColorSelectedBothText;
              property  HighLightBold: boolean read FHiLgtBold write SetHighLightBold;
              property  HighLightRow: longint read FHiLgtRow write SetHighLightRow;
              property  HighLightColumn: longint read FHiLgtColumn write SetHighLightColumn;
              property  LeftCol;
              property  RowColPattern: integer read FRowColPattern write SetColPattern;
              property  Font;
              property  ParentFont;
              property  PopupMenu;
              property  RowSelectMode: integer read FRowSelectMode write SetRowSelectMode;
              property  NrOfColumns: longint read FNrOfCols write SetNrCols;
              property  NrOfRows: longint read FNrOfRows write SetNrRows;
              property  ScrollBars;
              property  SortEnabled: boolean read FSortEnabled write FSortEnabled;
              property  TopRow;
              property  Options;
              property  Visible;
              property  VisibleColCount;
              property  VisibleRowCount;
              property  OnGetEditText: TGetEditEvent read FOnGetEditText write FOnGetEditText;
              property  OnSetEditText: TSetEditEvent read FOnSetEditText write FOnSetEditText;
              property  OnMouseDown;
              property  OnMouseUp;
              property  OnMouseMove;
              property  OnClick;
              property  OnCheckedChange: TCheckStateChangeEvent read FOnChkStChange write FOnChkStChange;
              property  OnSelectedChange: TNotifyEvent read FOnSelectedChange write FOnSelectedChange;
              property  OnChange: TNotifyEvent read FOnChange write FOnChange;
              property  OnChangeSetup: TNotifyEvent read FOnChangeSetup write FOnChangeSetup;
              property  OnDblClick;
            end;

procedure Register;


{------------------------------------------------------------------}
implementation
{------------------------------------------------------------------}

uses
  forms, streams;

{$IFDEF SHAREWARE}
{$I sharwinc\replist_ct.inc}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}

const
  LeftSpace = 3;            { distance between cell border and its text }
  TopSpace = 2;
  RightSpace = 3;
  NoActRim = 4;  // pixels around cell borders where no mouse action is accepted
                 // this ensures column resizing
  DefaultRowAlloc = 10;   // default AllocRowsBy for TStringArray

type
  ESDLRepListError = class(Exception); { exception type to indicate errors }
  NameArray = Array [1..1] of TNameStrType;        { col identifiers }
  BoolArray = Array [1..1] of boolean;

const                                   {xml tag names}
  xmlTagIds : array[xmlNumCols..xmlInValid] of string =
               ('numcols', 'numrows', 'colname', 'checkedcolumn', 'cell',
                'comment', '/replist', 'invalidtag');


(******************************************************************************)
constructor TReportListView.Create(AOwner: TComponent);
(******************************************************************************)

var
  success  : boolean;
  i        : integer;


begin
inherited Create(AOwner);    { Inherit original constructor }
FSuppressPaint := true;
FixedCols := 0;
FNrOfCOls := ColCount;
FNrOfRows := RowCount-1;
FComment := '';
FColorNormal := $002000;
FRColorNormal := clWhite;          { color of normal row background }
FRColorShaded := $F0E0D0;          { color of shaded row background }
FRowColPattern := 1;
FHiLgtColor := $CC9966;
FHiLgtTextColor := clWhite;
FHiLgtBold := false;
FHiLgtRow   := 0;
FHiLgtColumn := 0;
FSelRowColor := $0094BAED;                      { color of selected rows }
FSelRowTextColor := clNavy;
FAutoAdvance := False;
FSortToggle := true;
FRowSelectMode := 1;
FSortEnabled := true;
FSelectAnchor := 1;
FSortColumn := -1;
FSortOrder := true;
success := false;
Strings:= TStringArray.Create (FNrOfCols,FNrOfRows,DefaultRowAlloc);
if Strings <> NIL then
  begin
  success := True;
  Strings.Clear;
  GetMem (FColName, sizeof(TNameStrType)*FNrOfCols);
  if FColName = NIL
    then success := False
    else begin
         for i:=1 to FNrOfCols do
           NameArray(FColName^)[i] := 'C-'+IntToStr(i);
         end;
  GetMem (FColChecked, sizeof(boolean)*FNrOfCols);
  if FColChecked = NIL
    then success := False
    else begin
         for i:=1 to FNrOfCols do
           BoolArray(FColChecked^)[i] := false;
         end;
  GetMem (FColumnEditable, sizeof(boolean)*FNrOfCols);
  if FColumnEditable = NIL
    then success := False
    else begin
         for i:=1 to FNrOfCols do
           BoolArray(FColumnEditable^)[i] := false;
         end;
  GetMem (FColumnIsPwd, sizeof(boolean)*FNrOfCols);
  if FColumnIsPwd = NIL
    then success := False
    else begin
         for i:=1 to FNrOfCols do
           BoolArray(FColumnIsPwd^)[i] := false;
         end;
  end;
if not success
  then begin
       Fail;
       raise ESDLRepListError.Create ('ReportListView: failed to initialize table editor (out of memory)')
       end
  else begin
       Strings.OnChange := StringsHasChanged;
       Options := [goColSizing, goFixedVertLine, goFixedHorzLine, goRowSelect, goThumbTracking];
       end;
FSuppressPaint := false;
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;


(******************************************************************************)
destructor TReportListView.Destroy;
(******************************************************************************)


begin
if FColName <> NIL then
  FreeMem (FColName, sizeof(TNameStrType)*FNrOfCols);
FColName := NIL;
if FColChecked <> NIL then
  FreeMem (FColChecked, sizeof(boolean)*FNrOfCols);
FColChecked := NIL;
if FColumnEditable <> NIL then
  FreeMem (FColumnEditable, sizeof(boolean)*FNrOfCols);
FColumnEditable := NIL;
if FColumnIsPwd <> NIL then
  FreeMem (FColumnIsPwd, sizeof(boolean)*FNrOfCols);
FColumnIsPwd := NIL;
if Strings <> NIL then
  Strings.Free;
Strings := NIL;
inherited Destroy;    { Inherit original destructor }
end;


(******************************************************************************)
procedure TReportListView.CheckStateHasChanged (State: boolean; col, row: longint);
(******************************************************************************
  State    : check state
  col, row : coordinates of clicked cell
 ******************************************************************************)

begin
if Assigned(FOnChkStChange) then
  FOnChkStChange(self, State, col, row);
end;



(******************************************************************************)
procedure TReportListView.StringsHasChanged (Sender: TObject);
(******************************************************************************)

begin
Changed;
Paint;
end;


{$I replchar.inc}
{$I stripblk.inc}
{$I scandec.inc}


(******************************************************************************)
function TReportListView.ProcessXmlTag (xmlTag: TRepListXmlTag; attr, cont: string): integer;
(******************************************************************************
  ProcessXMLTag processes the tag xmlTag;
    return codes: 0 .... tag was OK, processed
                  1 .... end of report list found
                 -1 .... invalid XML tag
 ******************************************************************************)

var
  nr, nc : longint;
  ix, iy : longint;

begin
result := 0;
case xmltag of
  xmlEndReplist : begin
                  result := 1;
                  end;
     xmlInvalid : begin
                  result := -1;
                  end;
     xmlComment : begin
                  FComment := cont;
                  end;
     xmlNumCols : begin
                  ix := 1;
                  nc := ScanDecimal(cont, ix);
                  if nc > 0 then
                    SetNrCols (nc);
                  end;
     xmlNumRows : begin
                  ix := 1;
                  nr := ScanDecimal(cont, ix);
                  if nr > 0 then
                    SetNrRows (nr);
                  end;
     xmlColName : begin
                  ix := pos ('ix="', attr)+4;
                  nc := ScanDecimal(attr, ix);
                  if nc > 0 then
                    SetColname (nc, cont);
                  end;
xmlCheckedColumn: begin
                  ix := pos ('ix="', attr)+4;
                  nc := ScanDecimal(attr, ix);
                  if nc > 0 then
                    SetCheckedCol (nc, true);
                  end;
        xmlCell : begin
                  ix := pos ('ix="', attr)+4;
                  nc := ScanDecimal(attr, ix);
                  iy := pos ('iy="', attr)+4;
                  nr := ScanDecimal(attr, iy);
                  SetElem (nc, nr, cont);
                  if pos('checked=""', attr) > 0 then
                    SetElemChecked (nc, nr, true);
                  end;
end;
end;


(******************************************************************************)
function TReportListView.ReadFromXMLStream (InStream: TStream; DataID: string): boolean;
(******************************************************************************
  ENTRY: InStream ....... text stream to be read (reads from current position)
         DataID ......... if not empty: InStream is read until "id" attribute of <kohonen>
                                tag matches DataID
                          if empty: next <kohonen> of InStream is read (disregarding
                                the "id" attribute

  EXIT:  report list view is configured and filled according to the data stored
         as <kohonen> XML tag. The function returns TRUE if a valid <kohonen>
         tag has been found.
 ******************************************************************************)

var
  astr   : string;
  id     : string;
  found  : boolean;
  ix, iy : longint;
  iz     : longint;
  done   : integer;
  xmltag : TRepListXmlTag;
  cont   : string;
  attr   : string;
  eos    : boolean;


begin
FSuppressPaint := true;
result := false;
DataID := lowercase(DataID);
eos := false;

repeat
  astr := readlnStream (InStream, eos, 0);
  astr := lowercase(astr);
  ix := pos ('<replist', astr);
  found := (ix > 0);
  if found then
    found := (pos('sdlcsuite', astr) > 0);
  if found and (DataID <> '') then
    begin
    id := '';
    iy := pos ('id="', astr);
    if iy > 0 then
      begin
      iz := NumberedPos ('"', astr, iy, 2, false);
      id := StripLtBlanks(copy(astr, iy+4, iz-iy-4));
      end;
    if (id <> DataId) then
      found := false;
    end;
until found or eos;

if found then
  begin
  for ix:=1 to FNrOfCols do         // reset checked columns
    BoolArray(FColChecked^)[ix] := false;
  for ix:=1 to FNrOfCols do         // reset password columns
    BoolArray(FColumnIsPwd^)[ix] := false;
  Strings.Clear;
  done := 0;
  Unsort;
  while (done = 0) do
    begin
    xmltag := TRepListXmlTag(ReadNextTagInStream (InStream, xmlTagIds, attr, cont));
    done := ProcessXmlTag (xmlTag, attr, cont);
    end;
  if done = 1 then
    result := true;
  Changed;
  end;
SuppressPaint := false;
end;


(******************************************************************************)
function TReportListView.ReadFromOpenXMLFile (var InFile: TextFile; DataID: string): boolean;
(******************************************************************************
  ENTRY: InFile ......... text file to be read (must be already open)
         DataID ......... if not empty: InFile is read until "id" attribute of <replist>
                                tag matches DataID
                          if empty: next <replist> of InFile is read (disregarding
                                the "id" attribute

  EXIT:  report list view is configured and filled according to the data stored
         as <replist> XML tag. The function returns TRUE if a valid <replist>
         tag has been found.
 ******************************************************************************)


var
  astr   : string;
  id     : string;
  found  : boolean;
  ix, iy : longint;
  iz     : longint;
  done   : integer;
  xmltag : TRepListXmlTag;
  cont   : string;
  attr   : string;

begin
FSuppressPaint := true;
result := false;
DataID := lowercase(DataID);
repeat
  readln (InFile, astr);
  astr := lowercase(astr);
  ix := pos ('<replist', astr);
  found := (ix > 0);
  if found then
    found := (pos('sdlcsuite', astr) > 0);
  if found and (DataID <> '') then
    begin
    id := '';
    iy := pos ('id="', astr);
    if iy > 0 then
      begin
      iz := NumberedPos ('"', astr, iy, 2, false);
      id := StripLtBlanks(copy(astr, iy+4, iz-iy-4));
      end;
    if (id <> DataId) then
      found := false;
    end;
until found or eof(InFile);

if found then
  begin
  for ix:=1 to FNrOfCols do         // reset checked columns
    BoolArray(FColChecked^)[ix] := false;
  for ix:=1 to FNrOfCols do         // reset password columns
    BoolArray(FColumnIsPwd^)[ix] := false;
  Strings.Clear;
  done := 0;
  Unsort;
  while (done = 0) do
    begin
    xmltag := TRepListXMLTag(ReadNextTagInTextfile (InFile, xmlTagIds, attr, cont));
    done := ProcessXmlTag (xmlTag, attr, cont);
    end;
  if done = 1 then
    result := true;
  Changed;
  end;
SuppressPaint := false;
end;


(******************************************************************************)
function TReportListView.LoadFromXMLFile (FName: string; DataID: string): boolean;
(******************************************************************************
  ENTRY: FName .......... name of file to be read
         DataID ......... if not empty: InFile is read until "id" attribute of <replist>
                                tag matches DataID
                          if empty: next <replist> of InFile is read (disregarding
                                the "id" attribute

  EXIT:  report list view is configured and filled according to the data stored
         as <replist> XML tag. The function returns TRUE if a valid <replist>
         tag has been found.
 ******************************************************************************)

var
  TFile : TextFile;

begin
result := false;
assignfile (TFile, FName);
{$I-}reset (TFile);{$I+}
if IOResult = 0 then
  begin
  result := ReadFromOpenXMLFile (TFile, DataID);
  closeFile (TFile);
  end;
end;


(******************************************************************************)
procedure TReportListView.WriteToOpenXMLFile (var OutFile : TextFile;
                  CreateHeader: boolean; DataID: string);
(******************************************************************************
  ENTRY: OutFile .......... text file to be written (must be already open)
         CreateHeader ... TRUE: simple XML header is created
         DataID ......... ID of ReportList component

  EXIT:  Data of TReportListView is exported to the text file OutFile
 ******************************************************************************)


var
  i,j   : integer;
  astr  : string;

begin
if CreateHeader then
  begin
  writeln (OutFile, '<?xml version="1.0"?>');
  end;
writeln (OutFile);
writeln (OutFile, '<!-- TReportListView / SDL Component Suite -->');
writeln (OutFile, '<replist sig="SDLCSuite" vers="6.0" id="'+DataID+'">');
writeln (OutFile, '<',xmlTagIds[xmlComment],'>',FComment,'</',xmlTagIds[xmlComment],'>');
writeln (OutFile, '<',xmlTagIds[xmlnumcols],'>',FNrOfCols,'</',xmlTagIds[xmlnumcols],'>');
writeln (OutFile, '<',xmlTagIds[xmlnumrows],'>',FNrOfRows,'</',xmlTagIds[xmlnumrows],'>');
for i:=1 to FNrOfCols do
  begin
  write (OutFile, '<',xmlTagIds[xmlcolname],' ix="',i,'">');
  write (OutFile, GetColName(i));
  writeln (OutFile, '</',xmlTagIds[xmlcolname],'>');
  end;
for i:=1 to FNrOfCols do
  begin
  if GetCheckedCol (i) then
    writeln (OutFile, '<',xmlTagIds[xmlcheckedcolumn],' ix="',i,'" />'); // </checkedcolumn>');
  end;
for j:=1 to FNrOfRows do
  for i:=0 to FNrOfCols do
    begin
    astr := Strings[i,j];
    if (astr <> '') and not (GetCheckedCol (i) and (astr = ' ')) then
      begin
      write (OutFile, '<',xmlTagIds[xmlCell],' ix="',i,'" iy="',j,'"');
      if GetElemChecked(i,j) then
        write (OutFile, ' checked=""');
      if GetCheckedCol (i) then
        delete (astr,1,1);
      write (OutFile, '>',astr);
      writeln (OutFile, '</',xmlTagIds[xmlCell],'>');  //all nonzero elements: x,y,string
      end;
    end;
writeln (OutFile, '</replist>');
end;


(******************************************************************************)
procedure TReportListView.WriteToXMLStream (OutStream: TStream;
                  CreateHeader: boolean; DataID: string);
(******************************************************************************
  ENTRY: OutStream ...... stream to be written to
         CreateHeader ... TRUE: simple XML header is created
         DataID ......... ID of ReportList component

  EXIT:  Data of TReportListView is exported to the stream OutStream
 ******************************************************************************)


var
  i,j   : integer;
  astr  : string;

begin
if CreateHeader then
  begin
  writelnStream (OutStream, '<?xml version="1.0"?>');
  end;
writelnStream (OutStream, '');
writelnStream (OutStream, '<!-- TReportListView / SDL Component Suite -->');
writelnStream (OutStream, '<replist sig="SDLCSuite" vers="6.0" id="'+DataID+'">');
writelnStream (OutStream, '<'+xmlTagIds[xmlComment]+'>'+FComment+'</'+xmlTagIds[xmlComment]+'>');
writelnStream (OutStream, '<'+xmlTagIds[xmlnumcols]+'>'+IntToStr(FNrOfCols)+'</'+xmlTagIds[xmlnumcols]+'>');
writelnStream (OutStream, '<'+xmlTagIds[xmlnumrows]+'>'+IntToStr(FNrOfRows)+'</'+xmlTagIds[xmlnumrows]+'>');
for i:=1 to FNrOfCols do
  begin
  writeStringStream (OutStream, '<'+xmlTagIds[xmlcolname]+' ix="'+IntToStr(i)+'">');
  writeStringStream (OutStream, GetColName(i));
  writelnStream (OutStream, '</'+xmlTagIds[xmlcolname]+'>');
  end;
for i:=1 to FNrOfCols do
  begin
  if GetCheckedCol (i) then
    writelnStream (OutStream, '<'+xmlTagIds[xmlcheckedcolumn]+' ix="'+IntToStr(i)+'" />'); // </checkedcolumn>');
  end;
for j:=1 to FNrOfRows do
  for i:=0 to FNrOfCols do
    begin
    astr := Strings[i,j];
    if (astr <> '') and not (GetCheckedCol (i) and (astr = ' ')) then
      begin
      writeStringStream (OutStream, '<'+xmlTagIds[xmlCell]+' ix="'+IntToStr(i)+'" iy="'+IntToStr(j)+'"');
      if GetElemChecked(i,j) then
        writeStringStream (OutStream, ' checked=""');
      if GetCheckedCol (i) then
        delete (astr,1,1);
      writeStringStream (OutStream, '>'+astr);
      writelnStream (OutStream, '</'+xmlTagIds[xmlCell]+'>');  //all nonzero elements: x,y,string
      end;
    end;
writelnStream (OutStream, '</replist>');
end;



(******************************************************************************)
procedure TReportListView.SaveAsXMLFile (FName: string; DataID: string);
(******************************************************************************
  ENTRY: FName .......... name of text file to be written
         DataID ......... ID of ReportList component

  EXIT:  Data of TReportListView is exported to the XML file FName
 ******************************************************************************)

var
  OutFile : TextFile;

begin
assignFile (OutFile, FName);
rewrite (OutFile);
WriteToOpenXMLFile (OutFile, true, DataID);
closeFile (OutFile);
end;




(******************************************************************************)
procedure TReportListView.SetRowSelectMode (mode: integer);
(******************************************************************************)

var
  i       : integer;
  GridRct : TGridrect;


begin
if mode < 0 then
  mode := 0;
if mode > 2 then
  mode := 2;
FRowSelectMode := mode;
if mode <> 2 then
  begin
  FSuppressPaint := true;
  for i:=1 to FNrOfRows do
    Strings.RowAttrib[i] := Strings.RowAttrib[i] and $7F;
  if mode = 0 then
    begin
    GridRct.Left := FNrOfCols+1;
    GridRct.Top := FNrOfRows+1;
    GridRct.Bottom := FNrOfRows+1;
    GridRct.Right := FNrOfCols+1;
    Selection := GridRct;
    end;
  SuppressPaint := false;  //triggers paint method as intended side effect
  ChangedSelection;
  end;
end;

(******************************************************************************)
function TReportListView.FirstSelectedColumn: longint;
(******************************************************************************)

var
  i  : longint;

begin
i := 1;
while ((Strings.ColAttrib[i] and $80) = 0) and (i < FNrOfCols) do
  inc(i);
if (Strings.ColAttrib[i] and $80) = 0
  then FirstSelectedColumn := 0
  else FirstSelectedColumn := i;
end;


(******************************************************************************)
function TReportListView.FirstSelectedRow: longint;
(******************************************************************************)

var
  i  : longint;

begin
i := 1;
while ((Strings.RowAttrib[i] and $80) = 0) and (i < FNrOfRows) do
  inc(i);
if (Strings.RowAttrib[i] and $80) = 0
  then FirstSelectedRow := 0
  else FirstSelectedRow := i;
end;


(******************************************************************************)
function TReportListView.NumSelectedRows: longint;
(******************************************************************************)

var
  i  : longint;

begin
result := 0;
for i:=1 to FNrOfRows do
  if ((Strings.RowAttrib[i] and $80) <> 0) then
    inc(result);
end;


(******************************************************************************)
function TReportListView.NumSelectedColumns: longint;
(******************************************************************************)

var
  i  : longint;

begin
result := 0;
for i:=1 to FNrOfCols do
  if ((Strings.ColAttrib[i] and $80) <> 0) then
    inc(result);
end;




(******************************************************************************)
procedure TReportListView.DeselectAllRows;
(******************************************************************************)

var
  i : integer;

begin
FSuppressPaint := true;
for i:=1 to FNrOfRows do
  Strings.RowAttrib[i] := Strings.RowAttrib[i] and $7F;
SuppressPaint := false;  //triggers paint method as intended side effect
ChangedSelection;
end;


(******************************************************************************)
procedure TReportListView.DeselectAllColumns;
(******************************************************************************)

var
  i : integer;

begin
FSuppressPaint := true;
for i:=1 to FNrOfCols do
  Strings.ColAttrib[i] := Strings.ColAttrib[i] and $7F;
SuppressPaint := false;  //triggers paint method as intended side effect
ChangedSelection;
end;


(******************************************************************************)
procedure TReportListView.SelectAllRows;
(******************************************************************************)

var
  i : integer;

begin
FSuppressPaint := true;
for i:=1 to FNrOfRows do
  Strings.RowAttrib[i] := Strings.RowAttrib[i] or $80;
SuppressPaint := false;  //triggers paint method as intended side effect
ChangedSelection;
end;


(******************************************************************************)
procedure TReportListView.SelectAllColumns;
(******************************************************************************)

var
  i : integer;

begin
FSuppressPaint := true;
for i:=1 to FNrOfCols do
  Strings.ColAttrib[i] := Strings.ColAttrib[i] or $80;
SuppressPaint := false;  //triggers paint method as intended side effect
ChangedSelection;
end;




(******************************************************************************)
procedure TReportListView.DblClick;
(******************************************************************************)


var
  GridCell   : TGridCoord;
  ARect      : TRect;
  column     : integer;

begin
GridCell := MouseCoord (FLastMousePosX, FLastMousePosY);
if (GridCell.Y = 0)
  then begin        { click into headers }
       ARect := CellRect (GridCell.x, GridCell.y);
       if (abs(FLastMousePosX-ARect.Left) <= NoActRim) or (abs(FLastMousePosX-Arect.Right) <= NoActRim) then
         begin
         column := GridCell.X+1;
         if abs(FLastMousePosX) < ((ARect.Right+ARect.Left) div 2) then
           dec(column);
         while (ColWidths[column] <= 0) and (column > 1) do  { don't resize hidden columns }
           dec (column);
         AutoColWidth (column, true, 0);
         end;
       end
  else inherited DblClick;
end;


(******************************************************************************)
procedure TReportListView.MouseMove(Shift: TShiftState; X, Y: Integer);
(******************************************************************************)

begin
inherited MouseMove (Shift, X, Y);
FLastMousePosX := X;
FLastMousePosY := Y;
end;


(******************************************************************************)
function TReportListView.SelectCell(ACol, ARow: longint): boolean;
(******************************************************************************)

begin
if ACol = 0
  then Options := Options - [goEditing]
  else Options := Options + [goEditing];
SelectCell := true;
end;


(******************************************************************************)
procedure TReportListView.MouseDown (Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
(******************************************************************************)

begin
if (Selection.Left < FNrOfCols) and
   (Selection.Top <= FNrOfRows) and
   (Selection.Right < FNrOfCols) and
   (Selection.Bottom <= FNrOfRows) and
   (Selection.Left >= 0) and
   (Selection.Top > 0) and
   (Selection.Right >= 0) and
   (Selection.Bottom > 0) then
  inherited MouseDown (button, shift, x, y);
end;

(******************************************************************************)
procedure TReportListView.MouseUp (Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
(******************************************************************************)

var
  GridCell   : TGridCoord;
  ARect      : TRect;
  i          : longint;
  SelBak     : TGridRect;
  OrgNum     : longint;
  CurBak     : TCursor;
  found      : boolean;
  s          : string;
  Checked    : boolean;

begin
inherited MouseUp (button, shift, x, y);
if (X > 0) and (Y > 0) and
   (X < GridWidth) and (Y < GridHeight) and (button = mbLeft) then
  begin                        { process click only if within grid area }
  GridCell := MouseCoord (X, Y);
  if (GridCell.Y = 0)
    then begin      { click into headers }
         if FSortEnabled then
           begin
           ARect := CellRect (GridCell.x, GridCell.y);
           if (abs(x-ARect.Left) > NoActRim) and (abs(x-Arect.Right) > NoActRim) then
             begin
             CurBak := Screen.Cursor;
             Screen.Cursor := crHourGlass;
             SelBak := Selection;
             OrgNum := Strings.SortOrder[Selection.Top];
             FSortToggle := not FSortToggle;
             Sort (GridCell.X+1, FSortToggle);          // sort data
             i:=0;
             found := false;                            // adjust selection
             while (i < FNrOfRows) and not found do
               begin
               inc (i);
               if Strings.SortOrder[i] = OrgNum then
                 begin
                 SelBak.Top := i;
                 SelBak.Bottom := i;
                 found := true;
                 end;
               end;
             Selection := SelBak;
             Screen.Cursor := CurBak;
             end;
           end;
         end
    else begin
         SuppressPaint := true;
         if BoolArray(FColumnEditable^)[GridCell.X+1]
           then Options := Options + [goEditing]
           else Options := Options - [goEditing];
         ARect := CellRect (GridCell.x, GridCell.y);
         if Boolarray(FColChecked^)[GridCell.X+1] and (x-ARect.Left < 18) then
           begin
           s := Strings[GridCell.X+1, GridCell.Y];
           Checked := false;
           if length(S) > 0 then
             if S[1] <> ' ' then
               Checked := true;
           if Checked
             then s[1] := ' '
             else begin
                  if length(s) = 0
                    then s := 'X'
                    else s[1] := 'X';
                  end;
           Strings[GridCell.X+1, GridCell.Y] := s;
           CheckStateHasChanged (not Checked, GridCell.X+1, GridCell.Y);
           end;
         GridCell.X := Selection.Left;
         GridCell.Y := Selection.Top;
         case FRowSelectMode of
            0 : begin                                   { no selection allowed }
                end;
            1 : begin                      { only single selected rows allowed }
                for i:=1 to FNrOfRows do
                  Strings.RowAttrib[i] := Strings.RowAttrib[i] and $7F;
                Strings.RowAttrib[GridCell.Y] := Strings.RowAttrib[GridCell.Y] or $80;
                ChangedSelection;
                end;
            2 : begin                                    { multiple selections }
                if ssShift in Shift
                  then begin                                { select row range }
                       for i:=1 to FNrOfRows do
                         Strings.RowAttrib[i] := Strings.RowAttrib[i] and $7F;
                       if FSelectAnchor > GridCell.Y
                         then for i:=GridCell.Y to FSelectAnchor do
                                Strings.RowAttrib[i] := Strings.RowAttrib[i] or $80
                         else for i:=FSelectAnchor to GridCell.Y do
                                Strings.RowAttrib[i] := Strings.RowAttrib[i] or $80;
                       end
                  else begin
                       FSelectAnchor := GridCell.Y;
                       if ssCtrl in Shift
                         then begin                      { select multiple row }
                              Strings.RowAttrib[GridCell.Y] := Strings.RowAttrib[GridCell.Y] xor $80;
                              end
                         else begin                        { select single row }
                              for i:=1 to FNrOfRows do
                                Strings.RowAttrib[i] := Strings.RowAttrib[i] and $7F;
                              Strings.RowAttrib[GridCell.Y] := Strings.RowAttrib[GridCell.Y] or $80;
                              end;
                       end;
                ChangedSelection;
                end;
         end;
         SuppressPaint := false;  //triggers paint method as intended side effect
         end;
  end;
end;


(******************************************************************************)
function TReportListView.GetRowSelect (r: longint): boolean;
(******************************************************************************
 ENTRY: r ......... number of row

 EXIT:  function returns true is row r is selected
 ******************************************************************************)

begin
if (r >= 1) and (r <= FNrOfRows)
  then GetRowSelect := ((Strings.RowAttrib[r] and $80) = $80)
  else GetRowSelect := false;
end;


(******************************************************************************)
procedure TReportListView.SetRowSelect (r: longint; value: boolean);
(******************************************************************************
 ENTRY: r ......... number of row
        value ..... selected = TRUE

 EXIT:  selection state of row r is changed accordingly
 ******************************************************************************)

begin
if (r >= 1) and (r <= FNrOfRows) then
  begin
  if value
    then Strings.RowAttrib[r] := Strings.RowAttrib[r] or $80
    else Strings.RowAttrib[r] := Strings.RowAttrib[r] and $7F;
  ChangedSelection;
  Paint;
  end
end;


(******************************************************************************)
function TReportListView.GetColSelect (c: longint): boolean;
(******************************************************************************
 ENTRY: c ......... number of Col

 EXIT:  function returns true is Col c is selected
 ******************************************************************************)

begin
if (c >= 1) and (c <= FNrOfCols)
  then GetColSelect := ((Strings.ColAttrib[c] and $80) = $80)
  else GetColSelect := false;
end;


(******************************************************************************)
procedure TReportListView.SetColSelect (c: longint; value: boolean);
(******************************************************************************
ENTRY: c ......... number of Col
       value ..... selected = TRUE

EXIT:  selection state of Col c is changed accordingly
 ******************************************************************************)

begin
if (c >= 1) and (c <= FNrOfCols) then
  begin
  if value
    then Strings.ColAttrib[c] := Strings.ColAttrib[c] or $80
    else Strings.ColAttrib[c] := Strings.ColAttrib[c] and $7F;
  ChangedSelection;
  Paint;
  end
end;



(******************************************************************************)
function TReportListView.GetColName (ColNr: longint): TNameStrType;
(******************************************************************************
ENTRY: ColNr ..... number of column

EXIT:  function returns text of column header
 ******************************************************************************)

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols)
  then GetColName := NameArray(FColName^)[ColNr]
  else GetColName := '';
end;




(******************************************************************************)
procedure TReportListView.SetColName (ColNr: longint; HLine: TNameStrType);
(******************************************************************************
ENTRY: ColNr ..... number of column
       HLine ..... text of header

EXIT:  Header 'Hline' is associated with the specified column
 ******************************************************************************)

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols) then
  begin
  NameArray(FColName^)[ColNr] := HLine;
  Changed;
  Paint;
  end
end;


(******************************************************************************)
function TReportListView.GetCheckedCol (ColNr: longint): boolean;
(******************************************************************************
ENTRY: ColNr ..... number of column

EXIT:  function returns TRUE if column contains checkboxes
 ******************************************************************************)

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols)
  then GetCheckedCol := BoolArray(FColChecked^)[ColNr]
  else GetCheckedCol := false;
end;




(******************************************************************************)
procedure TReportListView.SetCheckedCol (ColNr: longint; Value: boolean);
(******************************************************************************
ENTRY: ColNr ..... number of column
       Value ..... TRUE displays a checkbox left to the text

EXIT:
 ******************************************************************************)

var
  i         : integer;
  s         : string;
  supppaint : boolean;

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols) then
  begin
  if BoolArray(FColChecked^)[ColNr] <> Value then
    begin
    supppaint := FSuppressPaint;
    FSuppressPaint := true;
    BoolArray(FColChecked^)[ColNr] := Value;
    for i:=1 to FNrOfRows do
      begin
      s := Strings[ColNr,i];
      if length(s) > 0 then
        begin
        if Value
          then begin
               Strings[ColNr,i] := ' '+s;
               end
          else begin
               Strings[ColNr,i] := copy (s, 2, length(s)-1);
               end;
        end;
      end;
    FSuppressPaint := supppaint;
    Changed;
    Paint;
    end;
  end
end;


(******************************************************************************)
function TReportListView.GetColumnEditable (ColNr: longint): boolean;
(******************************************************************************
ENTRY: ColNr ..... number of column

EXIT:  function returns true if column is readonly
 ******************************************************************************)

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols)
  then GetColumnEditable := BoolArray(FColumnEditable^)[ColNr]
  else GetColumnEditable := false;
end;




(******************************************************************************)
procedure TReportListView.SetColumnEditable (ColNr: longint; Value: boolean);
(******************************************************************************
 ENTRY: ColNr ..... number of column
        Value ..... TRUE if column should be read-only

 EXIT:  indicated column is set to read-only mode
 ******************************************************************************)

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols) then
  begin
  if BoolArray(FColumnEditable^)[ColNr] <> Value then
    BoolArray(FColumnEditable^)[ColNr] := Value;
  end
end;

(******************************************************************************)
function TReportListView.GetColumnIsPwd (ColNr: longint): boolean;
(******************************************************************************
ENTRY: ColNr ..... number of column

EXIT:  function returns true if column is readonly
 ******************************************************************************)

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols)
  then GetColumnIsPwd := BoolArray(FColumnIsPwd^)[ColNr]
  else GetColumnIsPwd := false;
end;




(******************************************************************************)
procedure TReportListView.SetColumnIsPwd (ColNr: longint; Value: boolean);
(******************************************************************************
 ENTRY: ColNr ..... number of column
        Value ..... TRUE if column should be read-only

 EXIT:  indicated column is set to read-only mode
 ******************************************************************************)

begin
if (ColNr >= 1) and (ColNr <= FNrOfCols) then
  begin
  if BoolArray(FColumnIsPwd^)[ColNr] <> Value then
    BoolArray(FColumnIsPwd^)[ColNr] := Value;
  end
end;




(******************************************************************************)
function TReportListView.GetColWidths(Index: Longint): Integer;
(******************************************************************************
  ENTRY:    Index ..... index of column: 1..n = data columns

  EXIT:     width of indicated column is returned
 ******************************************************************************)

begin
if Index > 0
  then result := inherited ColWidths[Index-1] { data columns }
  else result := 0;
end;

(******************************************************************************)
function TReportListView.GetDefColWidth: integer;
(******************************************************************************)

begin
GetDefColWidth := inherited DefaultColWidth;
end;

(******************************************************************************)
function TReportListView.GetDefRowHeight: integer;
(******************************************************************************)

begin
GetDefRowHeight := inherited DefaultRowHeight;
end;



(******************************************************************************)
function TReportListview.GetElem (ACol, ARow: longint): ShortString;
(******************************************************************************)

var
  s : string;

begin
if BoolArray(FColChecked^)[ACol]
  then begin
       s := Strings[ACol,ARow];
       Result := copy (s, 2, length(s)-1);
       end
  else Result := Strings[ACol,ARow];
end;


(******************************************************************************)
procedure TReportListView.SetElem (ACol, ARow: longint; const Value: ShortString);
(******************************************************************************)

var
  s : string;

begin
if BoolArray(FColChecked^)[ACol]
  then begin
       s := Strings[ACol,ARow];
       if length(s) = 0
         then s := ' '
         else delete (s,2,length(s)-1);
       Strings[ACol,ARow] := s+value;
       end
  else Strings[ACol,ARow] := value;
end;

(******************************************************************************)
function TReportListview.GetElemChecked (ACol, ARow: longint): boolean;
(******************************************************************************)

var
  s       : string;
  Checked : boolean;

begin
Checked := false;
if BoolArray(FColChecked^)[ACol] then
  begin
  s := Strings[ACol,ARow];
  if length(s) > 0 then
    if s[1] <> ' ' then
      Checked := true;
  end;
Result := Checked;
end;


(******************************************************************************)
procedure TReportListView.SetElemChecked (ACol, ARow: longint; const Value: boolean);
(******************************************************************************)

var
  s : string;

begin
if BoolArray(FColChecked^)[ACol] then
  begin
  s := Strings[ACol,ARow];
  if Value
    then begin
         if length(s) = 0
           then s := 'X'
           else s[1] := 'X';
         end
    else begin
         if length(s) = 0
           then s := ' '
           else s[1] := ' ';
         end;
  Strings[ACol,ARow] := s;
  end
end;


(******************************************************************************)
function TReportListview.GetAsNumber (ACol, ARow: longint): double;
(******************************************************************************)

begin
GetAsNumber := Strings.AsNumber[ACol, ARow];
end;


(******************************************************************************)
procedure TReportListView.SetSuppressPaint (supp: boolean);
(******************************************************************************)

begin
if FSuppressPaint <> supp then
  begin
  FSuppressPaint := supp;
  if not FSuppressPaint then
    Paint;
  end;
end;


(******************************************************************************)
procedure TReportListView.SetColorNormal (color: TColor);
(******************************************************************************)

begin
FColorNormal := color;
Paint;
ChangedSetup;
end;

(******************************************************************************)
procedure TReportListView.SetRColorNormal (color: TColor);
(******************************************************************************)

begin
FRColorNormal := color;
Paint;
ChangedSetup;
end;

(******************************************************************************)
procedure TReportListView.SetRColorShaded (color: TColor);
(******************************************************************************)

begin
FRColorShaded := color;
Paint;
ChangedSetup;
end;

(******************************************************************************)
procedure TReportListView.SetColorHi (color: TColor);
(******************************************************************************)

begin
FHiLgtColor := color;
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetColorHiText (color: TColor);
(******************************************************************************)

begin
FHiLgtTextColor := color;
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetColorSelectedRow (color: TColor);
(******************************************************************************)

begin
FSelRowColor := color;
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetColorSelectedRowText (color: TColor);
(******************************************************************************)

begin
FSelRowTextColor := color;
Paint;
ChangedSetup;
end;

(******************************************************************************)
procedure TReportListView.SetColorSelectedCol (color: TColor);
(******************************************************************************)

begin
FSelColColor := color;
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetColorSelectedColText (color: TColor);
(******************************************************************************)

begin
FSelColTextColor := color;
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetColorSelectedBoth (color: TColor);
(******************************************************************************)

begin
FSelBothColor := color;
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetColorSelectedBothText (color: TColor);
(******************************************************************************)

begin
FSelBothTextColor := color;
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetHighLightRow (ARow: longint);
(******************************************************************************)

begin
FHiLgtRow := Arow;
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetHighLightBold (Bold: boolean);
(******************************************************************************)

begin
FHiLgtBold := Bold;
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetHighLightColumn (ACol: longint);
(******************************************************************************)

begin
FHiLgtColumn := Acol;
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.ExpandColWidth (Colix: longint);
(******************************************************************************
 ENTRY:    ColIx ..... index of column: 1..n = data columns

 EXIT:     width of indicated column is set
 ******************************************************************************)

var
  i, sum : integer;

begin
if (ColIx > 0) and (ColIx <= FNrOfCOls) then
  begin
  sum := 0;
  for i:=1 to FNrOfCols do
    if i <> ColIx then
      sum := sum + inherited ColWidths[i-1];
  sum := width-sum-8;
  if sum < 16 then
    sum := 16;
  inherited ColWidths[ColIx-1] := sum; { data columns }
  end;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetColWidths(Index: Longint; Value: Integer);
(******************************************************************************
 ENTRY:    Index ..... index of column: 1..n = data columns

 EXIT:     width of indicated column is set
 ******************************************************************************)

begin
if Index > 0 then
  inherited ColWidths[Index-1] := value; { data columns }
ChangedSetup;
end;

(******************************************************************************)
procedure TReportListView.Changed;
(******************************************************************************)

begin
if Assigned(FOnChange) then
  FOnChange(Self);
end;


(******************************************************************************)
procedure TReportListView.ChangedSetup;
(******************************************************************************)

begin
if Assigned(FOnChangeSetup) then
  FOnChangeSetup(Self);
end;

(******************************************************************************)
procedure TReportListView.ChangedSelection;
(******************************************************************************)

begin
if Assigned(FOnSelectedChange) then
  FOnSelectedChange(Self);
end;


(******************************************************************************)
procedure TReportListview.SetColPattern (colpat: integer);
(******************************************************************************)

begin
FRowColPattern := colpat;
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetDefColWidth (DefW: integer);
(******************************************************************************)

begin
inherited DefaultColWidth := DefW;
Paint;
ChangedSetup;
end;

(******************************************************************************)
procedure TReportListView.SetDefRowHeight (DefH: integer);
(******************************************************************************)

begin
inherited DefaultRowHeight := DefH;
RowHeights[0] := 2*TopSpace+Canvas.TextHeight ('gM');
Paint;
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetNrCols (NrCols: longint);
(******************************************************************************)

var
  PDummy         : pointer;
  i              : longint;
  MinCols        : longint;
  WidthOfLastCol : integer;
  OldCol          : longint;

begin
WidthOfLastCol := inherited ColWidths[ColCount-1];
OldCol := FNrOfCols;
FNrOfCols := NrCols;
ColCount := FNrOfCols;
for i:=OldCol to FNrOfCols do
  inherited ColWidths[i-1] := WidthOfLastCol;
Strings.Resize (FNrOfCols, FNrOfRows);

GetMem (PDummy, sizeof(TNameStrType)*FNrOfCols);    { adjust size of header list }
if PDummy = NIL
  then raise ESDLRepListError.Create ('ReportListView: not enough memory on heap')
  else begin
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       for i:=1 to MinCols do
         NameArray(PDummy^)[i] := NameArray(FColName^)[i];
       for i:=MinCols+1 to FNrOfCols do
         NameArray(PDummy^)[i] := 'C-'+IntToStr(i);
       FreeMem (FColName, sizeof(TNameStrType)*OldCol);
       FColName := PDummy;
       end;
GetMem (PDummy, sizeof(boolean)*FNrOfCols);    { adjust size of IsColChecked list }
if PDummy = NIL
  then raise ESDLRepListError.Create ('ReportListView: not enough memory on heap')
  else begin
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       for i:=1 to MinCols do
         BoolArray(PDummy^)[i] := BoolArray(FColChecked^)[i];
       for i:=MinCols+1 to FNrOfCols do
         BoolArray(PDummy^)[i] := false;
       FreeMem (FColChecked, sizeof(boolean)*OldCol);
       FColChecked := PDummy;
       end;
GetMem (PDummy, sizeof(boolean)*FNrOfCols);    { adjust size of ColumnIsPwd list }
if PDummy = NIL
  then raise ESDLRepListError.Create ('ReportListView: not enough memory on heap')
  else begin
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       for i:=1 to MinCols do
         BoolArray(PDummy^)[i] := BoolArray(FColumnIsPwd^)[i];
       for i:=MinCols+1 to FNrOfCols do
         BoolArray(PDummy^)[i] := false;
       FreeMem (FColumnIsPwd, sizeof(boolean)*OldCol);
       FColumnIsPwd := PDummy;
       end;
GetMem (PDummy, sizeof(boolean)*FNrOfCols);    { adjust size of ColumnEditable list }
if PDummy = NIL
  then raise ESDLRepListError.Create ('ReportListView: not enough memory on heap')
  else begin
       MinCols := FNrOfCols;
       if OldCol < MinCols then
         MinCols := OldCol;
       for i:=1 to MinCols do
         BoolArray(PDummy^)[i] := BoolArray(FColumnEditable^)[i];
       for i:=MinCols+1 to FNrOfCols do
         BoolArray(PDummy^)[i] := false;
       FreeMem (FColumnEditable, sizeof(boolean)*OldCol);
       FColumnEditable := PDummy;
       end;

ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.SetNrRows (NrRows: longint);
(******************************************************************************)

var
  sel : TGridRect;

begin
if NrRows < 1 then
  NrRows := 1;
if (Selection.Top > NrRows) then
  begin
  Sel.Left := 0;
  Sel.Top := NrRows;
  Sel.Right := FNrOfCols-1;
  Sel.Bottom := NrRows;
  Selection := sel;
  end;
FNrOfRows := NrRows;
RowCount := NrRows + 1;
Strings.Resize (FNrOfCols, FNrOfRows);
ChangedSetup;
end;


(******************************************************************************)
procedure TReportListView.Paint;
(******************************************************************************)

{$IFDEF SHAREWARE}
var
  astr : string;
  i,j  : integer;
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
    Canvas.Font.Name := 'System';
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


(******************************************************************************)
procedure TReportListView.KeyDown(var Key: Word; Shift: TShiftState);
(******************************************************************************)

var
  i      : integer;

begin
inherited KeyDown (Key, Shift);
if (Key = VK_DOWN) or (Key = VK_UP) or (Key = VK_RIGHT) or (Key = VK_LEFT) or
   (Key = VK_END) or (Key = VK_HOME) or (Key = VK_NEXT) or (Key = VK_PRIOR) then
  begin
  FSuppressPaint := true;
  for i:=1 to FNrOfRows do
    Strings.RowAttrib[i] := Strings.RowAttrib[i] and $7F;
  Strings.RowAttrib[Selection.Top] := Strings.RowAttrib[Selection.Top] or $80;
  SuppressPaint := false;  //triggers paint method as intended side effect
  ChangedSelection;
  end;
end;


(******************************************************************************)
procedure TReportListView.Keypress (var Key: char);
(******************************************************************************)

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

(******************************************************************************)
function TReportListView.GetEditText(ACol, ARow: Longint): string;
(******************************************************************************)

begin
Result := Strings.Elem [ACol+1, ARow];
if Assigned(FOnGetEditText) then FOnGetEditText(Self, ACol, ARow, Result);
end;


(******************************************************************************)
procedure TReportListView.SetEditText(ACol, ARow: Longint; const Value: string);
(******************************************************************************)

begin
Strings.Elem[ACol+1, ARow] := value;
inherited SetEditText(ACol+1, ARow, Value);
if Assigned(FOnSetEditText) then FOnSetEditText(Self, ACol, ARow, value);
end;

(******************************************************************************)
procedure TReportListView.DrawCell(ACol, ARow: Longint; ARect: TRect;
                                   AState: TGridDrawState);
(******************************************************************************)

var
  S       : string;
  BRect   : TRect;
  tw      : integer;
  sleng   : integer;
  Checked : boolean;
  i       : integer;

begin
BRect := ARect;
if not (goVertLine in Options) then
  inc(BRect.Right,1);
if not (goHorzLine in Options) then
  inc(BRect.Bottom,1);
dec(ARect.Right,RightSpace);
inc(ARect.Left,LeftSpace);
inc(ARect.Top,TopSPace);
if (ACol >= 0) and (Arow > 0)
  then begin                                         { data matrix values }
       s := Strings[Acol+1, arow];
       if BoolArray(FColumnIsPwd^)[ACol+1] then
         s := '******';
       Canvas.Font.Color := FColorNormal;
       if FRowColPattern <= 0
         then begin
              Canvas.Brush.Color := FRColorNormal;
              Canvas.Pen.Color := FRColorNormal;
              end
         else begin
              if ((ARow-1) div FRowColPattern) mod 2 = 1
                then begin
                     Canvas.Brush.Color := FRColorNormal;
                     Canvas.Pen.Color := FRColorNormal;
                     end
                else begin
                     Canvas.Brush.Color := FRColorShaded;
                     Canvas.Pen.Color := FRColorShaded;
                     end;
              end;
                                                        { set selection colors }
       if (Strings.ColAttrib[ACol+1] and $80 <> 0) and (Strings.RowAttrib[ARow] and $80 <> 0)
         then begin
              Canvas.Brush.Color := FSelBothColor;
              Canvas.Pen.Color := FSelBothColor;
              Canvas.Font.Color := FSelBothTextColor;
              end
         else
       if Strings.ColAttrib[ACol+1] and $80 <> 0
         then begin
              Canvas.Brush.Color := FSelColColor;
              Canvas.Pen.Color := FSelColColor;
              Canvas.Font.Color := FSelColTextColor;
              end
         else
       if Strings.RowAttrib[Arow] and $80 <> 0
         then begin
              Canvas.Brush.Color := FSelRowColor;
              Canvas.Pen.Color := FSelRowColor;
              Canvas.Font.Color := FSelRowTextColor;
              end;

       if (FHiLgtRow = ARow)                         { set high lighted colors }
         then begin
              Canvas.Brush.Color := FHiLgtColor;
              Canvas.Pen.Color := FHiLgtColor;
              Canvas.Font.Color := FHiLgtTextColor;
              if FHiLgtBold then
                Canvas.Font.Style := [fsBold];
              end
         else
       if FHiLgtColumn = ACol+1
         then begin
              Canvas.Brush.Color := FHiLgtColor;
              Canvas.Pen.Color := FHiLgtColor;
              Canvas.Font.Color := FHiLgtTextColor;
              if FHiLgtBold then
                Canvas.Font.Style := [fsBold];
              end;
       if not Enabled then
         begin                      { override colors if component is disabled }
         Canvas.Font.Color := clInActiveCaption;
         end;
       tw := Canvas.TextWidth (s);
       if (tw > (ColWidths[ACol+1]-LeftSpace-RightSpace)) and (tw > 0) then
         begin
         sleng := round((ColWidths[ACol+1]-LeftSpace-RightSpace)/tw*length(s)-3);
         if sleng < 1 then
           sleng := 1;
         s := copy (s,1,sleng)+'...';
         end;
       Canvas.Pen.Width := 1;
       Canvas.Rectangle (BRect.Left, BRect.Top, BRect.Right, BRect.Bottom);
       if BoolArray(FColChecked^)[ACol+1]
         then begin
              Checked := false;
              if length(s) > 0 then
                if s[1] <> ' ' then
                  Checked := true;
              delete (s, 1, 1);
              Canvas.textRect(ARect, ARect.Left+16, ARect.Top-1, s);
              Canvas.Pen.Color := clBtnShadow;
              Canvas.Rectangle (BRect.Left+4, BRect.Top+4, BRect.Left+15, BRect.Top+15);
              Canvas.Pen.Color := clBlack;
              if Checked then
                begin
                for i:=0 to 2 do
                  begin
                  Canvas.MoveTo (BRect.Left+6, BRect.Top+8+i);
                  Canvas.LineTo (BRect.Left+9, BRect.Top+11+i);
                  end;
                for i:=0 to 2 do
                  begin
                  Canvas.MoveTo (BRect.Left+8, BRect.Top+10+i);
                  Canvas.LineTo (BRect.Left+13, BRect.Top+5+i);
                  end;
                end;
              end
         else Canvas.textRect(ARect, ARect.Left, ARect.Top-1, s);
       end
  else begin                  { column headers }
       s := NameArray(FColName^)[ACol+1];
       tw := Canvas.TextWidth (s);
       if tw > (ColWidths[ACol+1]-LeftSpace-RightSpace) then
         begin
         sleng := round((ColWidths[ACol+1]-LeftSpace-RightSpace)/tw*length(s)-3);
         if sleng < 1 then
           sleng := 1;
         s := copy (s,1,sleng)+'...';
         end;
       Canvas.textRect(ARect, ARect.Left, ARect.Top, s);
       end;
inherited;
end;

(******************************************************************************)
procedure TReportListView.Sort (Col: longint; Ascending: boolean);
(******************************************************************************
  ENTRY: Col ........ index of column to be taken as
                      sorting criterion
         Ascending .. type of sorting (FALSE = descending,
                                       TRUE ascending)

  EXIT:  array sorted according to column 'Col'.
 ******************************************************************************)

begin
FSortColumn := col;
FSortOrder := ascending;
Strings.Sort (col, ascending);
Paint;
end;

(******************************************************************************)
procedure TReportListView.UnSort;
(******************************************************************************
  EXIT:  row order is arranged in original unsorted manner
 ******************************************************************************)

begin
FSortColumn := -1;
Strings.UnSort;
Paint;
end;


(******************************************************************************)
procedure TReportListView.RemoveRow (r: longint);
(******************************************************************************
  ENTRY: r ... index of row to be removed
  EXIT:  row r is removed, length of report list is
         decreased by one row
 ******************************************************************************)

var
  SupPaintBak : boolean;
  j           : integer;

begin
if (r >= 1) and (r <= FNrOfRows) then
  begin
  if (FNrOfRows > 1)
    then begin
         SupPaintBak := FSuppressPaint;
         FSuppressPaint := true;
         Strings.RemoveRow(r);
         FNrOfRows := FNrOfRows-1;
         RowCount := FNrOfRows+1;
         SuppressPaint := SupPaintBak;
         ChangedSetup;
         end
    else begin // clear last row but don't delete it
         SupPaintBak := FSuppressPaint;
         FSuppressPaint := true;
         for j := 0 to FNrOfCols do
           Strings.Elem [j, r] := '';
         SuppressPaint := SupPaintBak;
         end;
  end;
end;

(******************************************************************************)
procedure TReportListView.InsertRow (r: longint);
(******************************************************************************
  ENTRY: r ... index of row at insertion point
  EXIT:  row r is inserted, length of report list is
         increased by one row
 ******************************************************************************)

var
  SupPaintBak : boolean;

begin
if (r>=1) and (r <= FNrOfRows) then
  begin
  SupPaintBak := FSuppressPaint;
  SuppressPaint := true;
  Strings.InsertRow(r);
  FNrOfRows := FNrOfRows+1;
  RowCount := FNrOfRows+1;
  SuppressPaint := SupPaintBak;
  ChangedSetup;
  end;
end;


(******************************************************************************)
procedure TReportListView.Fill (s: ShortString);
(******************************************************************************
  ENTRY: s ... string to be filled into string array
  EXIT:  all elements are set to string s
 ******************************************************************************)

begin
SuppressPaint := true;
Strings.Fill (s);
SuppressPaint := false;
end;


(******************************************************************************)
procedure TReportListView.Clear;
(******************************************************************************
  ENTRY: -
  EXIT:  all elements (including the invisible column) are
         cleared, column headers are reset to default headers
 ******************************************************************************)

var
  i : integer;

begin
Strings.Clear;
for i:=1 to FNrOfCols do
  NameArray(FColName^)[i] := 'C-'+IntToStr(i);
for i:=1 to FNrOfCols do
  BoolArray(FColChecked^)[i] := false;
for i:=1 to FNrOfCols do
  BoolArray(FColumnIsPwd^)[i] := false;
for i:=1 to FNrOfCols do
  BoolArray(FColumnEditable^)[i] := false;
Paint;
end;


(******************************************************************************)
function TReportListView.AddRow: longint;
(******************************************************************************)

begin
SetNrRows (FNrOfRows+1);
AddRow := FNrOfRows;      // the new row count
end;


(******************************************************************************)
procedure TReportListView.AutoColWidth (ColNr: longint;
              IncludeHeader: boolean; Addon: integer);
(******************************************************************************
  ENTRY: ColNr ........... number of column to be adjusted
                             1..n = data columns
         IncludeHeader ... TRUE: width of header is included
         AddOn ........... number of pixels to add to optimum width

  EXIT:  width of specified column is adjusted such that all data are
         available (including the header, if IncludeHeader eq. TRUE).
 ******************************************************************************)

var
  MinWidth : integer;
  i        : integer;
  ix       : integer;

begin
MinWidth := 0;
if (colNr > 0) and (colNr <= FNrOfCols) then
  begin
  if IncludeHeader
    then MinWidth := Canvas.TextWidth (NameArray(FColName^)[ColNr])
    else MinWidth := 0;
  for i:=1 to FNrOfRows do
    begin
    ix := Canvas.TextWidth (Strings[colNr,i]);
    if (ix > MinWidth) then
      MinWidth := ix;
    end;
  end;
MinWidth := 8+MinWidth+Addon;
if MinWidth < 4 then
 MinWidth := 4;
SetColWidths (ColNr, MinWidth);
end;


(***********************************************************************)
procedure TReportListView.AssignTo (Dest: TPersistent);
(***********************************************************************)


begin
if self is Dest.ClassType
  then Dest.Assign (self)
  else inherited AssignTo (Dest);
end;

(***********************************************************************)
procedure TReportListView.Assign(Source: TPersistent);
(***********************************************************************
  REMARK: Only those fields are copied which are defined with the
          TReportListView declaration !!
 ***********************************************************************)

var
  i, j    : integer;

begin
if Source is TReportListView
  then begin
       if FColName <> NIL then
         FreeMem (FColName, sizeof(TNameStrType)*FNrOfCols);
       if FColChecked <> NIL then
         FreeMem (FColChecked, sizeof(boolean)*FNrOfCols);
       if FColumnIsPwd <> NIL then
         FreeMem (FColumnIsPwd, sizeof(boolean)*FNrOfCols);
       if FColumnEditable <> NIL then
         FreeMem (FColumnEditable, sizeof(boolean)*FNrOfCols);
       if Strings <> NIL then
         Strings.Free;
       FAutoAdvance      := TReportListView(Source).FAutoAdvance;
       FLastMousePosX    := TReportListView(Source).FLastMousePosX;
       FLastMousePosY    := TReportListView(Source).FLastMousePosY;
       FOnChange         := TReportListView(Source).FOnChange;
       FOnChangeSetup    := TReportListView(Source).FOnChangeSetup;
       FOnSelectedChange := TReportListView(Source).FOnSelectedChange;
       FNrOfCols         := TReportListView(Source).FNrOfCols;
       FNrOfRows         := TReportListView(Source).FNrOfRows;
       FSelectAnchor     := TReportListView(Source).FSelectAnchor;
       FRowSelectMode    := TReportListView(Source).FRowSelectMode;
       FSortEnabled      := TReportListView(Source).FSortEnabled;
       FSortColumn       := TReportListView(Source).FSortColumn;
       FSortOrder        := TReportListView(Source).FSortOrder;
       FOnChkStChange    := TReportListView(Source).FOnChkStChange;
       FOnGetEditText    := TReportListView(Source).FOnGetEditText;
       FOnSetEditText    := TReportListView(Source).FOnSetEditText;
       FSelRowColor      := TReportListView(Source).FSelRowColor;
       FSelRowTextColor  := TReportListView(Source).FSelRowTextColor;
       FSelColColor      := TReportListView(Source).FSelColColor;
       FSelColTextColor  := TReportListView(Source).FSelColTextColor;
       FSelBothColor     := TReportListView(Source).FSelBothColor;
       FSelBothTextColor := TReportListView(Source).FSelBothTextColor;
       FHiLgtColor       := TReportListView(Source).FHiLgtColor;
       FHiLgtTextColor   := TReportListView(Source).FHiLgtTextColor;
       FHiLgtBold        := TReportListView(Source).FHiLgtBold;
       FHiLgtRow         := TReportListView(Source).FHiLgtRow;
       FHiLgtColumn      := TReportListView(Source).FHiLgtColumn;
       FSuppressPaint    := TReportListView(Source).FSuppressPaint;
       FSortToggle       := TReportListView(Source).FSortToggle;
       FColorNormal      := TReportListView(Source).FColorNormal;
       FRColorNormal     := TReportListView(Source).FRColorNormal;
       FRColorShaded     := TReportListView(Source).FRColorShaded;
       FRowColPattern    := TReportListView(Source).FRowColPattern;
       Strings:= TStringArray.Create (FNrOfCols,FNrOfRows,TReportListView(Source).Strings.AllocRowsBy);
       if Strings <> NIL then
         begin
         RowCount := FNrOfRows + 1;
         ColCount := FNrOfCols;

         if TReportListView(Source).Strings <> nil then
           begin
           for i:=1 to FNrOfCols do
             Strings.ColAttrib[i] := TReportListView(Source).Strings.ColAttrib[i];
           for i:=1 to FNrOfRows do
             Strings.RowAttrib[i] := TReportListView(Source).Strings.RowAttrib[i];
           for i:=1 to FNrOfCols do
             for j:=1 to FNrOfRows do
               Strings[i,TReportListView(Source).Strings.SortOrder[j]] := TReportListView(Source).Strings[i,j];
           for i:=1 to FNrOfRows do
             Strings.SortOrder[i] := TReportListView(Source).Strings.SortOrder[i];
           end;

         GetMem (FColName, sizeof(TNameStrType)*FNrOfCols);
         if FColName = NIL
           then raise ESDLRepListError.Create ('ReportListView: not enough memory on heap')
           else begin
                for i:=1 to FNrOfCols do
                  NameArray(FColName^)[i] := TReportListView(Source).GetColName(i);
                end;
         GetMem (FColChecked, sizeof(boolean)*FNrOfCols);
         if FColChecked = NIL
           then raise ESDLRepListError.Create ('ReportListView: not enough memory on heap')
           else begin
                for i:=1 to FNrOfCols do
                  BoolArray(FColChecked^)[i] := TReportListView(Source).GetCheckedCol(i);
                end;
         GetMem (FColumnIsPwd, sizeof(boolean)*FNrOfCols);
         if FColumnIsPwd = NIL
           then raise ESDLRepListError.Create ('ReportListView: not enough memory on heap')
           else begin
                for i:=1 to FNrOfCols do
                  BoolArray(FColumnIsPwd^)[i] := TReportListView(Source).GetColumnIsPwd(i);
                end;
         GetMem (FColumnEditable, sizeof(boolean)*FNrOfCols);
         if FColumnEditable = NIL
           then raise ESDLRepListError.Create ('ReportListView: not enough memory on heap')
           else begin
                for i:=1 to FNrOfCols do
                  BoolArray(FColumnEditable^)[i] := TReportListView(Source).GetColumnEditable (i);
                end;
         end;
       Paint;
       end
  else inherited Assign(Source);
end;


(******************************************************************************)
procedure Register;
(******************************************************************************)

begin
RegisterComponents ('SDL', [TReportListView]);
end;


end.

