unit Rot3D;

(******************************************************************)
(*                                                                *)
(*                           R O T 3 D                            *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1997..2001 H. Lohninger                 October 1997   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Aug-02, 2001                                  *)
(*                                                                *)
(******************************************************************)


{ revision history

1.0   [Oct-20, 1997]
      first release to the public

1.1   [Dec-2, 1997]
      bug fix : method "Line" now works properly
      property IsoMetric implemented
      property AutoOrigin implemented
      properties OriginX, OriginY, and OriginZ implemented
      method SetOrigins implemented

1.2   [Feb-10, 1998]
      FindNearestItemScreen redesigned (interface changed)
      FindNearestItemReal - bug fix: z-coordinates are now included into distance calculation
      CopyToClipBoardWMF implemented
      CopyToWMFFile implemented
      bug fixed: Font for "MarkAt" is now taken from Font property of Rot3D
      MarkAt redesigned to speed up display and enable WMF export
      interactive rotate improved - rotations are coupled to relative mouse motion
      property DataTag implemented
      property AxNameX,AxNameY, and AxNameZ implemented
      method PrintIt implemented

1.2b  [Feb-13, 1998]
      AutoScale property implemented
      ScaleFactX, ScaleFactY, ScaleFactZ implemented
      method SetScaleFactors implemented

1.3   [Apr-08, 1998]
      ROT3D is now available for C++Builder 3.0

1.4   [Aug-08, 1998]
      Rot3D now available for Delphi 4.0
      bug fix: destructor did not free all allocated memory
      the public constants DefHeight and DefWidth are now renamed to DefR3Height and
        DefR3Width in order to avoid naming conflicts with other components

1.5   [Apr-03, 1999]
      Bug fix: Rot3d does not crash anymore if no printers are installed

5.0   [Oct-02, 1999]
      Rot3D now available for Delphi 5.0

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      bug fix: wrong z angle processing caused abrupt initial rotation when
          rotating the data interactively
      bug fix: OriginX, OriginY, OriginZ are now set properly when AutoOrigin is TRUE
      bug fix: ScaleFactX...Z are now set properly when AutoScale is TRUE
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

{-----------------------------------------------------------------------}
interface
{-----------------------------------------------------------------------}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Menus,
  Graphics, Controls, Forms, ExtCtrls;

const
  defDataCol    = clblack;                          { default data color }
  defFrameCol   = clBlack;                         { default frame color }
  defChartCol   = clWhite;              { default chart background color }
  defR3Height   = 300;
  defR3Width    = 450;
  MaxItemColors = 31;                  { number of different item colors }
  MaxR3Marks    = 25;                              { max number of marks }


type
  TColorScheme = (csBWG, csSystem);
  TAxName = string[25];
  TFrameStyle = (fsNone, fsSimple, fsLowered, fsRaised, fsEmbossed, fsEngraved);
  ItemType = (tkNone, tkMarkAt, tkLineto, tkLine, tkMoveto, tkEverything);
  TBoundingBox = (bbNone, bbFrame, bbFaces);
  PDrawCan = ^TDrawCan;
  TDrawCan = record
               Next       : PDrawCan;         { pointer to next Item }
               x,y,z      : double;            { coordinates of Item }
               color      : TColor;                  { color of Item }
               tag        : longint;              { user defined tag }
               case Element: ItemType of
                 tkLine   : (x2,y2,z2: double);               { line }
                 tkMarkAt : (mark    : byte);                 { mark }
             end;

  MouseActMode = (maNone, maRotate, maZoom, maRotAndZoom, maPan);

  TRot3D = class(TGraphicControl)
            private
              CubeCorners     : array [0..7,1..3] of longint;  { coords of cube corners }
              FViewAngle      : array[1..3] of double;    { view point of data }
              GrafBmp         : TBitmap;          { off-screen graphics bitmap }
              FMouseAction    : MouseActMode;   { type of allowed mouse action }
              RcFrstCan       : PDrawCan;         { buffer of drawing elements }
              RcLastCan       : PDrawCan;           { pointer to last drw. can }
              RcDataCol       : TColor;                        { color of data }
              FDataTag        : longint;                    { user defined tag }
              RcFrameCol      : TColor;                       { color of frame }
              RcChartCol      : TColor;            { color of chart background }
              FColBlackLine   : TColor;             { colors to draw the frame }
              FColGrayLine    : TColor;                       { -"- }
              FColWhiteLine   : TColor;                       { -"- }
              FColorScheme    : TColorScheme;         { color scheme of frames }
              FColorCubeFrame : TColor;
              FColorCubeHidLin: TColor;
              FColorCubeFaceHi: TColor;
              FColorCubeFaceLo: TColor;
              FBoundBox       : TBoundingBox;               { surrounding cube }
              FBBSize         : integer;                { size of bounding box }
              FAxSize         : integer;                      { length of axes }
              FShowAxes       : boolean;                     { TRUE: show axes }
              FFrameStyle     : TFrameStyle;                  { style of frame }
              FIsoMetric      : boolean;           { isometric display if TRUE }
              FAutoOrigin     : boolean;{TRUE: calculate origin automatrically }
              FAutoScale      : boolean;     { TRUE: scale data automatrically }
              FOrigin         : array[1..3] of double;  { origin of coord.syst.}
              FAxName         : array[1..3] of TAxName;         { name of axes }
              FMagnify        : integer;            { 1 / magnification factor }
              FMagAnchor      : double;   { magnification anchor for rel. zoom }
              FMinCoord       : array[1..3] of integer;
              FMaxCoord       : array[1..3] of integer;
              FAngleAnchor    : array[1..2] of double;
              FScaleFact      : array[1..3] of double;{factor for fixed scaling}
              FItemColors     : array[0..MaxItemColors] of TColor; { loadable item colors }
              FCentX          : integer;                     { center of chart }
              FCentY          : integer;
              FCentXAnchor    : integer;
              FCentYAnchor    : integer;
              RotMat          : array[1..3,1..3] of longint; { rotation matrix }
              NRotObj         : integer;     { number of objects to be rotated }
              FRotDataX       : pointer;     { data to be processed - x values }
              FRotDataY       : pointer;     { data to be processed - y values }
              FRotDataZ       : pointer;     { data to be processed - z values }
              FBackLink       : pointer; { array of pointers to graphics items }
              FRotProp        : pointer;     { bit 0..4 = color,
                                               bit 5..7 = action: $20 ... MoveTo
                                                                  $40 ... LineTo
                                                                  $60 ... MarkAt }
              FRotMark        : pointer;                           { mark type }
              FTextFontStyle  : TFontStyles;       { font style of text labels }
              FTextMarkSize   : byte;                { size of character marks }
              MouseAnchorX    : integer;      { anchor for relative mouse move }
              MouseAnchorY    : integer;

              procedure ConstructDataBmp (cv: TCanvas; BlkWhite: boolean);
              procedure InitGraf (cv: TCanvas; BlkWhite: boolean);
              procedure ConstructFrame (cv: TCanvas);
              procedure SetDataCol (c: TColor);
              procedure SetDataTag (tag: longint);
              procedure SetFrameCol (c: TColor);
              procedure SetChartCol (c: TColor);
              procedure SetColCubeFrame (c: TColor);
              procedure SetColCubeHidLin (c: TColor);
              procedure SetColCubeFaceLow (c: TColor);
              procedure SetColCubeFaceHigh (c: TColor);
              procedure SetMagnify (mag: double);
              function  GetAxNameX: TAxName;
              function  GetAxNameY: TAxName;
              function  GetAxNameZ: TAxName;
              function  GetMagnify: double;
              function  GetFirstItemLL: PDrawCan;
              function  GetTypeOfFirstItem: ItemType;
              function  GetTypeOfLastItem: ItemType;
              function  GetViewAngleX: double;
              function  GetViewAngleY: double;
              function  GetViewAngleZ: double;
              function  GetOriginX: double;
              function  GetOriginY: double;
              function  GetOriginZ: double;
              function  GetScaleFactX: double;
              function  GetScaleFactY: double;
              function  GetScaleFactZ: double;
              procedure SetColorScheme (Value: TColorScheme);
              procedure SetCubeCorners;
              procedure SetFrameStyle (value: TFrameStyle);
              procedure SetBoundBoxStyle (value: TBoundingBox);
              procedure SetBoundBoxSize (value: integer);
              function  GetBoundBoxSize: integer;
              procedure SetAxSize (value: integer);
              procedure SetCentX (value: integer);
              procedure SetCentY (value: integer);
              procedure SetIsoMetric (value: boolean);
              procedure SetAutoOrigin (value: boolean);
              procedure SetAutoScale (value: boolean);
              procedure SetShowAxes (value: boolean);
              procedure SetTextFontStyle (tfs: TFontStyles);
              procedure SetTextMarkSize (tms: byte);
              procedure SetViewAngleX (value: double);
              procedure SetViewAngleY (value: double);
              procedure SetViewAngleZ (value: double);
              procedure SetOriginX (value: double);
              procedure SetOriginY (value: double);
              procedure SetOriginZ (value: double);
              procedure SetScaleFactX (value: double);
              procedure SetScaleFactY (value: double);
              procedure SetScaleFactZ (value: double);
              procedure SetAxNameX (value: TAxName);
              procedure SetAxNameY (value: TAxName);
              procedure SetAxNameZ (value: TAxName);
            protected
              procedure MouseMove (Shift: TShiftState; X,Y: integer); override;
              procedure CalcRotMatrix; virtual;
              procedure Paint; override;
            public
              constructor Create(AOwner: TComponent); override;
              destructor Destroy; override;
                                                           { various basic routines }
              procedure Clear;
              property  ColorData: TColor read RcDataCol write SetDataCol default DefDataCol;
              procedure CopyToBMP (FName: string);
              procedure CopyToWMF (FName: string);
              procedure CopyToClipboard;
              procedure CopyToClipboardWMF;
              property  DataTag: longint read FDataTag write SetDataTag;
              procedure MakeVisible;
              procedure Drawto (x,y,z: double);
              function  FindNearestItemScreen (mx, my: integer;
                            ItemID: ItemType; var dist: double): PDrawCan;
              function  FindNearestItemReal (mx, my, mz: double;
                            ItemID: ItemType; var dist: double): PDrawCan;
              function  GetItemParams (Item: PDrawCan): TDrawCan;
              procedure SetItemParams (Item: PDrawCan; ItParams: TDrawCan);
              procedure Line (x1,y1,z1, x2,y2,z2: double);
              procedure Moveto (x,y,z: double);
              procedure MarkAt (x,y,z: double; mk: byte);
              procedure Printit (ScaleF: double; BlkWhite: boolean);
              procedure RemoveLastItem;
              procedure RemoveFirstItem;
              procedure SetViewAngles (vax, vay, vaz: double);
              procedure SetOrigins (vax, vay, vaz: double);
              procedure SetScaleFactors (sfx, sfy, sfz: double);
              property  FirstItemOfLinkedList: PDrawCan read GetFirstItemLL;
              property  TypeOfLastItem: ItemType read GetTypeOfLastItem;
              property  TypeOfFirstItem: ItemType read GetTypeOfFirstItem;
              property  ScaleFactX: double read GetScaleFactX write SetScaleFactX;
              property  ScaleFactY: double read GetScaleFactY write SetScaleFactY;
              property  ScaleFactZ: double read GetScaleFactZ write SetScaleFactZ;
            published
              property Font;
              property Align;
              property Visible;
              property ShowHint;
              property PopupMenu;
              property CentX: integer read FCentX write SetCentX;
              property CentY: integer read FCentY write SetCentY;
              property ColorFrame: TColor read RcFrameCol write SetFrameCol default DefFrameCol;
              property ColorChart: TColor read RcChartCol write SetChartCol default DefChartCol;
              property ColorScheme: TColorScheme read FColorScheme write SetColorScheme;
              property ColorCubeFrame: TColor read FColorCubeFrame write setColCubeFrame;
              property ColorCubeHidLin: TColor read FColorCubeHidLin write SetColCubeHidLin;
              property ColorCubeFaceLow: TColor read FColorCubeFaceLo write SetColCubeFaceLow;
              property ColorCubeFaceHigh: TColor read FColorCubeFaceHi write SetColCubeFaceHigh;
              property IsoMetric: boolean read FIsoMetric write SetIsometric;
              property AutoOrigin: boolean read FAutoOrigin write SetAutoOrigin;
              property AutoScale: boolean read FAutoScale write SetAutoScale;
              property FrameStyle: TFrameStyle read FFrameStyle write SetFrameStyle;
              property Magnification: double read GetMagnify write SetMagnify;
              property MouseAction: MouseActMode read FMouseAction write FMouseAction;
              property BoundBoxStyle: TBoundingBox read FBoundBox write SetBoundboxStyle;
              property BoundBoxSize: integer read GetBoundBoxSize write SetBoundBoxSize;
              property AxSize: integer read FAxSize write SetAxSize;
              property AxNameX: TAxName read GetAxNameX write SetAxNameX;
              property AxNameY: TAxName read GetAxNameY write SetAxNameY;
              property AxNameZ: TAxName read GetAxNameZ write SetAxNameZ;
              property ShowAxes: boolean read FShowAxes write SetShowAxes;
              property TextFontStyle: TFontStyles read FTextFontStyle write SetTextFontStyle;
              property TextMarkSize: byte read FTextMarkSize write SetTextMarkSize;
              property ViewAngleX: double read GetViewAngleX write SetViewAngleX;
              property ViewAngleY: double read GetViewAngleY write SetViewAngleY;
              property ViewAngleZ: double read GetViewAngleZ write SetViewAngleZ;
              property OriginX: double read GetOriginX write SetOriginX;
              property OriginY: double read GetOriginY write SetOriginY;
              property OriginZ: double read GetOriginZ write SetOriginZ;
              property OnClick;
              property OnDblClick;
              property OnMouseMove;
              property OnMouseDown;
              property OnMouseUp;
            end;


procedure Register;


{-----------------------------------------------------------------------}
implementation
{-----------------------------------------------------------------------}


uses
  printers, ClipBrd;

{$IFDEF SHAREWARE}
{$I sharwinc\rot3d_ct.inc}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}

const
  R3MaxDouble : extended = 1.7e308;
  SmallPosNum : double = 1e-30;       { lower limit of logarithmic scales }
  MaxMagnify  : double = 5.0;                        { max. magnification }
  MinMagnify  : double = 0.1;                        { min. magnification }
  AngleScl    : double = 1/180.0;     { scaling of angle-mouse dependence }
  DefltItemColors : array [0..MaxItemColors] of TColor =       { default item colors }
                   (clBlack, clMaroon, clGreen, clOlive, clNavy,
                    clPurple, clTeal, clGray, clSilver, clRed,
                    clLime, clYellow, clBlue, clFuchsia, clAqua,
                    clWhite,
                    clBlack, clBlack, clBlack, clBlack, clBlack, { user definable colors }
                    clBlack, clBlack, clBlack, clBlack, clBlack,
                    clBlack, clBlack, clBlack, clBlack, clBlack,
                    clBlack);


type
  Array1DI = array[1..1] of integer;
  Array1DB = array[1..1] of byte;
  Array1DP = array[1..1] of pointer;



(***********************************************************************)
procedure TRot3D.CalcRotMatrix;
(***********************************************************************)

{
successive rotation around x,y, and z axis (in this order; s=sin, c=cos):

              | cy     0    -sy    | cz        sz        0
              |                    |
              | 0      1      0    | -sz       cz        0
              |                    |
              | sy     0     cy    | 0         0         1
--------------+--------------------+---------------------------
1    0    0   | cy     0     -sy   | cy*cz     cy*sz     -sy
              |                    |
              |                    |
0    cx   sx  | sx*sy  cx    sx*cy | sx*sy*cz  sx*sy*sz  sx*cy
              |                    | -cx*sz    +cx*cz
              |                    |
0    -sx  cx  | cx*sy  -sx   cx*cy | cx*sy*cz  cx*sy*sz  cx*cy
              |                    | +sx*sz    -sx*cz
}

begin
RotMat[1,1] := round(500*cos(AngleScl*Pi*FViewAngle[2])*
                         cos(AngleScl*Pi*FViewAngle[3]));
RotMat[1,2] := round(500*(sin(AngleScl*Pi*FViewAngle[1])*
                          sin(AngleScl*Pi*FViewAngle[2])*
                          cos(AngleScl*Pi*FViewAngle[3])-
                          cos(AngleScl*Pi*FViewAngle[1])*
                          sin(AngleScl*Pi*FViewAngle[3])));
RotMat[1,3] := round(500*(cos(AngleScl*Pi*FViewAngle[1])*
                          sin(AngleScl*Pi*FViewAngle[2])*
                          cos(AngleScl*Pi*FViewAngle[3])+
                          sin(AngleScl*Pi*FViewAngle[1])*
                          sin(AngleScl*Pi*FViewAngle[3])));
RotMat[2,1] := round(500*(cos(AngleScl*Pi*FViewAngle[2]))*
                          sin(AngleScl*Pi*FViewAngle[3]));
RotMat[2,2] := round(500*(sin(AngleScl*Pi*FViewAngle[1])*
                          sin(AngleScl*Pi*FViewAngle[2])*
                          sin(AngleScl*Pi*FViewAngle[3])+
                          cos(AngleScl*Pi*FViewAngle[1])*
                          cos(AngleScl*Pi*FViewAngle[3])));
RotMat[2,3] := round(500*(cos(AngleScl*Pi*FViewAngle[1])*
                          sin(AngleScl*Pi*FViewAngle[2])*
                          sin(AngleScl*Pi*FViewAngle[3])-
                          sin(AngleScl*Pi*FViewAngle[1])*
                          cos(AngleScl*Pi*FViewAngle[3])));
RotMat[3,1] := round(500*-sin(AngleScl*Pi*FViewAngle[2]));
RotMat[3,2] := round(500* sin(AngleScl*Pi*FViewAngle[1])*
                          cos(AngleScl*Pi*FViewAngle[2]));
RotMat[3,3] := round(500* cos(AngleScl*Pi*FViewAngle[1])*
                          cos(AngleScl*Pi*FViewAngle[2]));
end;


(***********************************************************************)
procedure TRot3D.SetCubeCorners;
(***********************************************************************)

var
  i : integer;

begin
for i:=0 to 7 do
  begin
  CubeCorners [i,1] := FBBSize*(2*((i and $04) shr 2)-1);
  CubeCorners [i,2] := FBBSize*(2*((i and $02) shr 1)-1);
  CubeCorners [i,3] := FBBSize*(2*(i and $01)-1);
  end;
end;


(***********************************************************************)
procedure LimitToInteger (var x1, x2: longint);
(***********************************************************************)

const
  MinInt16 = -30000;  { this has left some space for RcLrim, RcTrim, etc. }
  MaxInt16 = 30000;

begin
if x1 < MinInt16 then
  x1 := MinInt16;
if x2 < MinInt16 then
  x2 := MinInt16;
if x1 > MaxInt16 then
  x1 := MaxInt16;
if x2 > MaxInt16 then
  x2 := MaxInt16;
end;

(******************************************************************)
function TRot3D.GetFirstItemLL: PDrawCan;
(******************************************************************
ENTRY: ---

EXIT:  The function returns the pointer to first item in the linked
       list
 ******************************************************************)

begin
GetFirstItemLL := RcFrstCan;
end;

(******************************************************************)
function TRot3D.GetTypeOfFirstItem: ItemType;
(******************************************************************
ENTRY: none

EXIT:  The type of the first item is returned
*******************************************************************)

begin
if RcFrstCan <> RcLastCan
  then GetTypeOfFirstItem := RcFrstCan^.Element
  else GetTypeOfFirstItem := tkNone;
end;


(******************************************************************)
function TRot3D.GetTypeOfLastItem: ItemType;
(******************************************************************
ENTRY: none

EXIT:  The type of the last item in the linked list is returned
*******************************************************************)

var
  np   : PDrawCan;
  ltype: ItemType;

begin
np := RcFrstCan;
ltype := np^.Element;
while np^.Element <> tkNone do
  begin
  ltype := np^.Element;
  np := np^.Next;
  end;
GetTypeOfLastItem := ltype;
end;

(******************************************************************)
procedure TRot3D.RemoveLastItem;
(******************************************************************
ENTRY: none

EXIT:  The last Item stored with the graphics is removed from it
*******************************************************************)

var
  np   : PDrawCan;
  Last : PDrawCan;

begin
Last := NIL;
np := RcFrstCan;
while np^.Element <> tkNone do
  begin
  Last := np;
  np := np^.Next;
  end;
if Last <> NIL then
  begin                   { remove last entry }
  Dispose (np);
  RcLastCan := Last;
  RcLastCan^.Element := tkNone;
  end;
end;


(******************************************************************)
procedure TRot3D.RemoveFirstItem;
(******************************************************************
ENTRY: none

EXIT:  The firs item stored with the graphics is removed from it
*******************************************************************)

var
  np   : PDrawCan;

begin
if RcFrstCan <> RcLastCan then
  begin
  np := RcFrstCan;
  RcFrstCan := RcFrstCan^.Next;      { change1 pointer to first can }
  Dispose (np);                               { remove first entry }
  end;
end;



(***********************************************************************)
constructor TRot3D.Create(AOwner: TComponent);
(***********************************************************************)

var
  i : integer;

begin
inherited Create(AOwner);    { Inherit original constructor }
Height := DefR3Height;               { Add new initializations }
Width := defR3Width;
FCentX := Width div 2;
FCentY := Height div 2;
RcLastCan := New (PDrawCan);
RcFrstCan := RcLastCan;
RcLastCan^.Element := tkNone;
RcDataCol := defDataCol;
RcFrameCol := defFrameCol;
RcChartCol := defChartCol;
FDataTag := 0;
FViewAngle[1] := 60;
FViewAngle[2] := 45;
FViewAngle[3] := 90;
FOrigin[1] := 0;
FOrigin[2] := 0;
FOrigin[3] := 0;
FAxName[1] := 'X';
FAxName[2] := 'Y';
FAxName[3] := 'Z';
FScaleFact[1] := 1.0;
FScaleFact[2] := 1.0;
FScaleFact[3] := 1.0;
FAutoScale := true;
FIsoMetric := false;
FAutoOrigin := true;
for i:=0 to MaxItemColors do
  FItemColors[i] := DefltItemColors[i];
GrafBmp := TBitmap.Create;  { Create the working bitmap and set its width and height }
GrafBmp.Width := Width-2;
GrafBmp.Height := Height-2;
FMouseAction := maRotate;
MouseAnchorX := 0;
MouseAnchorY := 0;
FMagnify := 3000;
FBoundBox := bbFaces;
FBBSize := 400;
SetCubeCorners;
FAxSize := 900;
FShowAxes := true;
FFrameStyle := fsLowered;
FColorScheme := csSystem;
FColBlackLine := clBlack;      { note: FColBlackLine is alwas black at the
                                            moment --> see SetColorScheme }
FColGrayLine  := clGray;
FColWhiteLine := clWhite;
FColorCubeFrame := $404040;
FColorCubeHidLin:= $b0b0b0;
FColorCubeFaceHi:= $EEEEEE;
FColorCubeFaceLo:= $C0C0C0;
FTextFontStyle := [];
FTextMarkSize := 8;
NRotObj := 0;
GetMem (FRotProp, 1);         { dummy allocation to get a valid pointer }
GetMem (FRotMark, 1);         { dummy allocation to get a valid pointer }
GetMem (FRotDataX, 4);        { dummy allocation to get a valid pointer }
GetMem (FBackLink, 4);        { dummy allocation to get a valid pointer }
GetMem (FRotDataY, 4);        { dummy allocation to get a valid pointer }
GetMem (FRotDataZ, 4);        { dummy allocation to get a valid pointer }
CalcRotMatrix;
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;


(***********************************************************************)
destructor TRot3D.Destroy;
(***********************************************************************)

var
  np   : PDrawCan;
  this : PDrawCan;

begin
this := RcFrstCan;
while this^.Element <> tkNone do
  begin
  np := this^.Next;
  Dispose (this);
  this := np;
  end;
Dispose (this);
GrafBmp.Free;                                    { destroy the graphics bitmap }
if FRotProp <> NIL then
  FreeMem (FRotProp, NRotObj*sizeof(byte));
if FBackLink <> NIL then
  FreeMem (FBackLink, NRotObj*sizeof(PDrawCan));
if FRotMark <> NIL then
  FreeMem (FRotMark, NRotObj*sizeof(byte));
if FRotDataX <> NIL then
  FreeMem (FRotDataX, NRotObj*sizeof(integer));
if FRotDataY <> NIL then
  FreeMem (FRotDataY, NRotObj*sizeof(integer));
if FRotDataZ <> NIL then
  FreeMem (FRotDataZ, NRotObj*sizeof(integer));
inherited Destroy;                               { inherit original destructor }
end;



(***********************************************************************)
procedure TRot3D.Paint;
(***********************************************************************)

begin
InitGraf (GrafBmp.Canvas, false);
ConstructDataBmp (GrafBmp.Canvas, false);                                  { create data image }
ConstructFrame (GrafBmp.Canvas);
Canvas.Draw(0, 0, GrafBmp);      { copy the working bitmap to the main canvas }

{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;



(**********************************************************************)
procedure TRot3D.MouseMove (Shift: TShiftState; X,Y: integer);
(**********************************************************************)

var
  RelMag: double;

begin
inherited MouseMove (Shift, X, Y);
if not (ssLeft in Shift) and not (ssRight in Shift) then
  begin
  MouseAnchorX := x;
  MouseAnchorY := y;
  FCentXAnchor := FCentX;
  FCentYAnchor := FCentY;
  FMagAnchor := 2000.0/FMagnify;
  FAngleAnchor[1] := FViewAngle[1];
  FAngleAnchor[2] := FViewAngle[2];
  end;
if FMouseAction = maRotate then
  if ssLeft in Shift then                       { rotate by mouse move }
    begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
      begin
      FViewAngle[1] := FAngleAnchor[1] + longint(360)*(MouseAnchorX-x)/Width(*-180*);
      FViewAngle[2] := FAngleAnchor[2] + longint(360)*(Height-MouseAnchorY+y)/Height;
      CalcRotMatrix;
      Paint;
      end;
    end;
if FMouseAction = maZoom then
  if ssLeft in Shift then                       { zoom by mouse move }
    begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
      begin
      RelMag := (MaxMagnify-MinMagnify)*(MouseAnchorY-y)/Height;
      if (RelMag+FMagAnchor) > MaxMagnify then
        RelMag := MaxMagnify-FMagAnchor;
      if (RelMag+FMagAnchor) < MinMagnify then
        RelMag := MinMagnify-FMagAnchor;
      FMagnify := round(2000.0/(FMagAnchor + RelMag));
      Paint;
      end;
    end;
if FMouseAction = maPan then
  if ssLeft in Shift then                       { pan by mouse move }
    begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
      begin
      FCentX := FCentXAnchor - (MouseAnchorX-x);
      FCentY := FCentYAnchor - (MouseAnchorY-y);
      Paint;
      end;
    end;
if FMouseAction = maRotAndZoom then
  begin
  if ssLeft in Shift then                       { rotate by mouse move }
    begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
      begin
      FViewAngle[1] := FAngleAnchor[1] + longint(360)*(MouseAnchorX-x)/Width(*-180*);
      FViewAngle[2] := FAngleAnchor[2] + longint(360)*(Height-MouseAnchorY+y)/Height;
(*
      FViewAngle[1] := longint(360)*x/Width-180;
      FViewAngle[2] := longint(360)*(Height-y)/Height;
*)
      CalcRotMatrix;
      Paint;
      end;
    end;
  if ssRight in Shift then                       { zoom by mouse move }
    begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
      begin
      RelMag := (MaxMagnify-MinMagnify)*(MouseAnchorY-y)/Height;
      if (RelMag+FMagAnchor) > MaxMagnify then
        RelMag := MaxMagnify-FMagAnchor;
      if (RelMag+FMagAnchor) < MinMagnify then
        RelMag := MinMagnify-FMagAnchor;
      FMagnify := round(2000.0/(FMagAnchor + RelMag));
      Paint;
      end;
    end;
  end;
end;


(******************************************************************)
function TRot3D.GetItemParams (Item: PDrawCan): TDrawCan;
(******************************************************************
ENTRY: Item .... pointer to Item to be retrieved

EXIT:  The function returns the parameters of the indicated Item
 ******************************************************************)

begin
GetItemParams := Item^;
end;


(******************************************************************)
procedure TRot3D.SetItemParams (Item: PDrawCan; ItParams: TDrawCan);
(*******************************************************************
ENTRY: Item ...... pointer to Item to be changed
       ItParams .. new set of parameters (set 'next' to NIL)

EXIT:  The function sets the parameters of the indicated Item

REMARK: The next entry of the item is not changed
*******************************************************************)

begin
if (ItParams.Element <> tkNone) and (ItParams.Element <> tkEverything) then
  begin
  ItParams.Next := Item^.next;
  Item^ := ItParams;
  end;
end;


(******************************************************************)
procedure TRot3D.ConstructFrame (cv: TCanvas);
(******************************************************************
ENTRY:  none (only system parameters)

EXIT:   The selected frame is displayed
********************************************************************)


begin
case FFrameStyle of
    fsSimple : begin
               cv.Pen.Color := RcFrameCol;
               cv.MoveTo (0,0);
               cv.LineTo (0,GrafBmp.Height-1);
               cv.LineTo (GrafBmp.Width-1,GrafBmp.Height-1);
               cv.LineTo (GrafBmp.Width-1,0);
               cv.LineTo (0,0);
               end;
  fsEmbossed : begin
               cv.Pen.Color := FColGrayLine;
               cv.MoveTo (1,1);
               cv.LineTo (1,GrafBmp.Height-1);
               cv.LineTo (GrafBmp.Width-1,GrafBmp.Height-1);
               cv.LineTo (GrafBmp.Width-1,1);
               cv.LineTo (1,1);
               cv.Pen.Color := FColWhiteLine;
               cv.MoveTo (0,0);
               cv.LineTo (0,GrafBmp.Height-2);
               cv.LineTo (GrafBmp.Width-2,GrafBmp.Height-2);
               cv.LineTo (GrafBmp.Width-2,0);
               cv.LineTo (0,0);
               end;
  fsEngraved : begin
               cv.Pen.Color := FColWhiteLine;
               cv.MoveTo (1,1);
               cv.LineTo (1,GrafBmp.Height-1);
               cv.LineTo (GrafBmp.Width-1,GrafBmp.Height-1);
               cv.LineTo (GrafBmp.Width-1,1);
               cv.LineTo (1,1);
               cv.Pen.Color := FColGrayLine;
               cv.MoveTo (0,0);
               cv.LineTo (0,GrafBmp.Height-2);
               cv.LineTo (GrafBmp.Width-2,GrafBmp.Height-2);
               cv.LineTo (GrafBmp.Width-2,0);
               cv.LineTo (0,0);
               end;
   fsLowered : begin
               cv.Pen.Color := FColGrayLine;
               cv.MoveTo (0,0);
               cv.LineTo (0,GrafBmp.Height-2);
               cv.LineTo (GrafBmp.Width-2,GrafBmp.Height-2);
               cv.LineTo (GrafBmp.Width-2,0);
               cv.LineTo (0,0);
               cv.Pen.Color := FColBlackLine;
               cv.MoveTo (1,GrafBmp.Height-3);
               cv.LineTo (1,1);
               cv.LineTo (GrafBmp.Width-2,1);
               cv.Pen.Color := FColWhiteLine;
               cv.MoveTo (1,GrafBmp.Height-1);
               cv.LineTo (GrafBmp.Width-1,GrafBmp.Height-1);
               cv.LineTo (GrafBmp.Width-1,0);
               end;
    fsRaised : begin
               cv.Pen.Color := FColGrayLine;
               cv.MoveTo (0,0);
               cv.LineTo (0,GrafBmp.Height-2);
               cv.LineTo (GrafBmp.Width-2,GrafBmp.Height-2);
               cv.LineTo (GrafBmp.Width-2,0);
               cv.LineTo (0,0);
               cv.Pen.Color := FColWhiteLine;
               cv.MoveTo (1,GrafBmp.Height-3);
               cv.LineTo (1,1);
               cv.LineTo (GrafBmp.Width-2,1);
               cv.Pen.Color := FColBlackLine;
               cv.MoveTo (1,GrafBmp.Height-1);
               cv.LineTo (GrafBmp.Width-1,GrafBmp.Height-1);
               cv.LineTo (GrafBmp.Width-1,0);
               end;
end;
end;

(******************************************************************)
procedure TRot3D.InitGraf (cv: TCanvas; BlkWhite: boolean);
(******************************************************************
ENTRY:  none (only system parameters)

EXIT:   The graphics bitmap is cleared and set up with the
        appropriate colors. The linked list of the graphics
        elements is not changed.
*******************************************************************)


begin
GrafBmp.Width := Width;
GrafBmp.Height := Height;
cv.Pen.Style := psSolid;
cv.Pen.Mode := pmCopy;
if BlkWhite
  then begin
       cv.Brush.Color := clWhite;
       cv.Pen.Color := clWhite;
       end
  else begin
       cv.Brush.Color := RcChartCol;
       cv.Pen.Color := RcChartCol;
       end;
cv.Rectangle (0,0,GrafBmp.Width,GrafBmp.Height);   { background chart area }
end;

(******************************************************************)
procedure TRot3D.Clear;
(******************************************************************
ENTRY: none (only system parameters)

EXIT:  The graphics bitmap is cleaned with the appropriate colors
*******************************************************************)

var
  np   : PDrawCan;
  this : PDrawCan;


begin
InitGraf (GrafBmp.Canvas, false);
this := RcFrstCan;
while this^.Element <> tkNone do
  begin
  np := this^.Next;
  dispose (this);
  this := np;
  end;
Dispose (this);
RcLastCan := New (PDrawCan);
RcFrstCan := RcLastCan;
RcLastCan^.Element := tkNone;
end;




(******************************************************************)
procedure TRot3D.ConstructDataBmp (cv: TCanvas; BlkWhite: boolean);
(******************************************************************
  This routine creates the bitmap image of the data area; The data
  colors are automatically set to black, if BlkWhite is TRUE.
 ******************************************************************)


const
  AxNameDist = 50;        { distance between axis endpoint and name }
  PointBmp : array [1..MaxR3Marks,1..7] of byte =
                 (($00,$00,$08,$1C,$08,$00,$00),      { 1:  small plus }
                  ($00,$08,$08,$3E,$08,$08,$00),      { 2:  medium plus }
                  ($08,$08,$08,$7F,$08,$08,$08),      { 3:  large plus }
                  ($00,$00,$14,$08,$14,$00,$00),      { 4:  small cross }
                  ($00,$22,$14,$08,$14,$22,$00),      { 5:  medium cross }
                  ($41,$22,$14,$08,$14,$22,$41),      { 6:  large cross }
                  ($00,$00,$1C,$1C,$1C,$00,$00),      { 7:  small block }
                  ($00,$3E,$3E,$3E,$3E,$3E,$00),      { 8:  medium block }
                  ($7F,$7F,$7F,$7F,$7F,$7F,$7F),      { 9:  large block }
                  ($00,$00,$1C,$14,$1C,$00,$00),      { 10: small empty block }
                  ($00,$3E,$22,$22,$22,$3E,$00),      { 11: medium empty block }
                  ($7F,$41,$41,$41,$41,$41,$7F),      { 12: large empty block }
                  ($00,$00,$08,$1C,$08,$00,$00),      { 13: small spade }
                  ($00,$08,$1C,$3E,$1C,$08,$00),      { 14: medium spade }
                  ($08,$1C,$3E,$7F,$3E,$1C,$08),      { 15: large spade }
                  ($00,$1C,$22,$22,$22,$1C,$00),      { 16: medium circle }
                  ($1C,$22,$41,$41,$41,$22,$1C),      { 17: large circle }
                  ($55,$2A,$55,$2A,$55,$2A,$55),      { 18: large shaded block }
                  ($08,$14,$22,$41,$22,$14,$08),      { 19: empty large spade }
                  ($00,$08,$14,$22,$00,$00,$00),      { 20: small hat }
                  ($08,$14,$22,$41,$00,$00,$00),      { 21: large hat }
                  ($00,$22,$14,$08,$00,$00,$00),      { 22: small inverse hat }
                  ($41,$22,$14,$08,$00,$00,$00),      { 23: large inverse hat }
                  ($1C,$3E,$7F,$7F,$7F,$3E,$1C),      { 24: large filled circle }
                  ($63,$77,$3E,$1C,$3E,$77,$63));     { 25: large bold cross }

  CubeNeighbors : array [0..7,1..3] of integer = { neighboring corners for each cube corner }
                ((1,2,4),    { neighbors are stored as index into "CubeCorners" }
                 (0,3,5),
                 (0,3,6),
                 (1,2,7),
                 (0,5,6),
                 (1,4,7),
                 (2,4,7),
                 (3,5,6));
  CubeFaces : array[0..5,1..4] of integer =  { face planes of cube }
                ((1,5,7,3),   { each face is defined by its corner index into "CubeCorners" }
                 (2,3,7,6),
                 (2,6,4,0),
                 (0,4,5,1),
                 (4,5,7,6),
                 (0,1,3,2));
  CubeNbFaces : array [0..7,1..3] of integer = { neighboring faces of the corners of the cube }
                ((5,3,2), { each face is stored as index into "CubeFaces" }
                 (0,3,5),
                 (1,2,5),
                 (0,1,5),
                 (3,4,2),
                 (0,3,4),
                 (1,2,4),
                 (0,4,1));

var
  x1, y1     : longint;
  i,j        : integer;
  obj        : integer;
  tw, th     : integer;
  Dcolor     : TColor;
  Action     : byte;
  Mark       : byte;
  z          : array[0..7] of integer;
  zminix     : integer;
  zmin       : integer;
  zmaxix     : integer;
  FaceCol    : longint;
  k,l        : integer;
  r,g,b      : longint;
  HidAxSize  : integer;
  quad       : array[1..4] of TPoint;
{$IFDEF SHAREWARE}
  astr       : string;
{$ENDIF}


procedure DisplayMarkAsBitMap (Mark: integer);
(*------------------------------------------*)

var
  i,j  : integer;
  by   : byte;

begin                               { bit maps }
for i:=1 to 7 do
  begin
  by := PointBmp[Mark,i];
  if by <> 0 then
    begin
    for j:=1 to 7 do
      begin
      if by and $01 = $01 then
        cv.Pixels [x1+4-j,y1-4+i] := DColor;
      by := by shr 1;
      end;
    end;
  end;
end;


begin
zMinix := 0;
zmaxix := 7;
if FBoundBox <> bbNone then
  begin
  z[0] := -RotMat[3,1]-RotMat[3,2]-RotMat[3,3];  { find corners with lowest and highest z-coords }
  z[1] := -RotMat[3,1]-RotMat[3,2]+RotMat[3,3];
  z[2] := -RotMat[3,1]+RotMat[3,2]-RotMat[3,3];
  z[3] := -RotMat[3,1]+RotMat[3,2]+RotMat[3,3];
  z[4] :=  RotMat[3,1]-RotMat[3,2]-RotMat[3,3];
  z[5] :=  RotMat[3,1]-RotMat[3,2]+RotMat[3,3];
  z[6] :=  RotMat[3,1]+RotMat[3,2]-RotMat[3,3];
  z[7] :=  RotMat[3,1]+RotMat[3,2]+RotMat[3,3];
  zmin := MaxInt;
  for i:=0 to 7 do
    begin
    if z[i] < zmin then
      begin
      zmin := z[i];
      zminix := i;
      end;
    end;
  zmaxix := 7-zMinIx;
  end;
if FBoundBox <> bbNone then
  begin
  cv.Pen.Color := FColorCubeFrame;
  for k:=1 to 3 do     { for all neighboring faces }
    begin
    FaceCol := 0;
    for l:=1 to 4 do
      begin
      quad[l].x := (CubeCorners[CubeFaces[CubeNBFaces[zMinix,k],l],1]*RotMat[1,1]+
                    CubeCorners[CubeFaces[CubeNBFaces[zMinix,k],l],2]*RotMat[1,2]+
                    CubeCorners[CubeFaces[CubeNBFaces[zMinix,k],l],3]*RotMat[1,3]) div FMagnify + FCentX;
      quad[l].y := (CubeCorners[CubeFaces[CubeNBFaces[zMinix,k],l],1]*RotMat[2,1]+
                    CubeCorners[CubeFaces[CubeNBFaces[zMinix,k],l],2]*RotMat[2,2]+
                    CubeCorners[CubeFaces[CubeNBFaces[zMinix,k],l],3]*RotMat[2,3]) div FMagnify + FCentY;
      FaceCol := FaceCol + z[CubeFaces[CubeNBFaces[zMinix,k],l]];
      end;
    FaceCol := -FaceCol div 10;
    r := (FColorCubeFaceLo and $0000FF) + ((FColorCubeFaceHi-FColorCubeFaceLo) and $0000FF)*FaceCol div 200;
    g := ((FColorCubeFaceHi-FColorCubeFaceLo) shr 8) and $0000FF;
    g := ((FColorCubeFaceLo shr 8) and $0000FF)+g*FaceCol div 200;
    b := ((FColorCubeFaceHi-FColorCubeFaceLo) shr 16) and $0000FF;
    b := ((FColorCubeFaceLo shr 16) and $0000FF)+b*FaceCol div 200;
    cv.Brush.Color := r+256*g+65536*b;
    if FBoundBox = bbFrame
      then cv.brush.Style := bsClear
      else cv.brush.Style := bsSolid;
    cv.polygon (Quad);
    end;
  end;

if FShowAxes then
  begin
  if FBBSize > FAxSize
    then HidAxSize := FAxSize
    else HidAxSize := FBBSize;
  cv.Pen.Color := FColorCubeHidLin;   { axes }
  cv.MoveTo (FCentX, FCentY);
  cv.LineTo ((0*RotMat[1,1]+0*RotMat[1,2]+HidAxSize*RotMat[1,3]) div FMagnify + FCentX,
             (0*RotMat[2,1]+0*RotMat[2,2]+HidAxSize*RotMat[2,3]) div FMagnify + FCentY);
  cv.Pen.Color := FColorCubeFrame;
  cv.LineTo ((0*RotMat[1,1]+0*RotMat[1,2]+FAxSize*RotMat[1,3]) div FMagnify + FCentX,
             (0*RotMat[2,1]+0*RotMat[2,2]+FAxSize*RotMat[2,3]) div FMagnify + FCentY);
  cv.Pen.Color := FColorCubeHidLin;
  cv.MoveTo (FCentX, FCentY);
  cv.LineTo ((0*RotMat[1,1]+HidAxSize*RotMat[1,2]+0*RotMat[1,3]) div FMagnify + FCentX,
             (0*RotMat[2,1]+HidAxSize*RotMat[2,2]+0*RotMat[2,3]) div FMagnify + FCentY);
  cv.Pen.Color := FColorCubeFrame;
  cv.LineTo ((0*RotMat[1,1]+FAxSize*RotMat[1,2]+0*RotMat[1,3]) div FMagnify + FCentX,
             (0*RotMat[2,1]+FAxSize*RotMat[2,2]+0*RotMat[2,3]) div FMagnify + FCentY);
  cv.Pen.Color := FColorCubeHidLin;
  cv.MoveTo (FCentX, FCentY);
  cv.LineTo ((HidAxSize*RotMat[1,1]+0*RotMat[1,2]+0*RotMat[1,3]) div FMagnify + FCentX,
             (HidAxSize*RotMat[2,1]+0*RotMat[2,2]+0*RotMat[2,3]) div FMagnify + FCentY);
  cv.Pen.Color := FColorCubeFrame;
  cv.LineTo ((FAxSize*RotMat[1,1]+0*RotMat[1,2]+0*RotMat[1,3]) div FMagnify + FCentX,
             (FAxSize*RotMat[2,1]+0*RotMat[2,2]+0*RotMat[2,3]) div FMagnify + FCentY);
  end;

if FBoundBox <> bbNone then
  begin
  cv.Pen.Color := FColorCubeHidLin;  { now draw hidden cube boundaries }
  for j:=1 to 3 do
    begin
    cv.MoveTo ((CubeCorners[zmaxix,1]*RotMat[1,1]+
                            CubeCorners[zmaxix,2]*RotMat[1,2]+
                            CubeCorners[zmaxix,3]*RotMat[1,3]) div FMagnify + FCentX,
                           (CubeCorners[zmaxix,1]*RotMat[2,1]+
                            CubeCorners[zmaxix,2]*RotMat[2,2]+
                            CubeCorners[zmaxix,3]*RotMat[2,3]) div FMagnify + FCentY);
    cv.LineTo ((CubeCorners[CubeNeighbors[zmaxix,j],1]*RotMat[1,1]+
                            CubeCorners[CubeNeighbors[zmaxix,j],2]*RotMat[1,2]+
                            CubeCorners[CubeNeighbors[zmaxix,j],3]*RotMat[1,3]) div FMagnify + FCentX,
                           (CubeCorners[CubeNeighbors[zmaxix,j],1]*RotMat[2,1]+
                            CubeCorners[CubeNeighbors[zmaxix,j],2]*RotMat[2,2]+
                            CubeCorners[CubeNeighbors[zmaxix,j],3]*RotMat[2,3]) div FMagnify + FCentY);
    end;
  end;

cv.brush.Style := bsSolid;
for obj:=1 to NRotObj do                { draw the graphics objects  }
  begin
  if BlkWhite
    then DColor := clblack
    else DColor := FItemColors[Array1DB(FRotProp^)[obj] and $1F];
  Action := Array1DB(FRotProp^)[obj] and $E0;
  Mark := Array1DB(FRotMark^)[obj];
  case Action of
         $20 : begin  { moveto }
               x1 := (Array1DI(FRotDataX^)[obj]*RotMat[1,1] +
                      Array1DI(FRotDataY^)[obj]*RotMat[1,2] +
                      Array1DI(FRotDataZ^)[obj]*RotMat[1,3])
                     div FMagnify + FCentX;
               y1 := (Array1DI(FRotDataX^)[obj]*RotMat[2,1] +
                      Array1DI(FRotDataY^)[obj]*RotMat[2,2] +
                      Array1DI(FRotDataZ^)[obj]*RotMat[2,3])
                     div FMagnify + FCentY;
               LimitToInteger (x1, y1);
               cv.MoveTo (x1,y1);
               end;
         $40 : begin   { LineTo }
               cv.Pen.Color := DColor;
               x1 := (Array1DI(FRotDataX^)[obj]*RotMat[1,1] +
                      Array1DI(FRotDataY^)[obj]*RotMat[1,2] +
                      Array1DI(FRotDataZ^)[obj]*RotMat[1,3])
                     div FMagnify + FCentX;
               y1 := (Array1DI(FRotDataX^)[obj]*RotMat[2,1] +
                      Array1DI(FRotDataY^)[obj]*RotMat[2,2] +
                      Array1DI(FRotDataZ^)[obj]*RotMat[2,3])
                     div FMagnify + FCentY;
               LimitToInteger (x1, y1);
               cv.LineTo (x1,y1);
               end;
         $60 : begin   { Mark }
               x1 := (Array1DI(FRotDataX^)[obj]*RotMat[1,1] +
                      Array1DI(FRotDataY^)[obj]*RotMat[1,2] +
                      Array1DI(FRotDataZ^)[obj]*RotMat[1,3])
                     div FMagnify + FCentX;
               y1 := (Array1DI(FRotDataX^)[obj]*RotMat[2,1] +
                      Array1DI(FRotDataY^)[obj]*RotMat[2,2] +
                      Array1DI(FRotDataZ^)[obj]*RotMat[2,3])
                     div FMagnify + FCentY;
               cv.Pen.Color := DColor;
               cv.Brush.Color := DColor;
               LimitToInteger (x1, y1);
               if Mark > $20
                 then begin
                      tw := cv.TextWidth (chr(Mark));
                      th := cv.TextHeight (chr(Mark));
                      cv.Font.Name := Font.Name;
                      cv.Font.Style := FTextFontStyle;

                         { the following three lines are a work around for a nasty Windows bug
                           which causes the printer fonts to be scaled improperly (sometimes);
                           following the motto: beat dirty bugs with dirty tricks - sorry }
                      cv.Font.PixelsPerInch := Screen.PixelsPerInch;
                      cv.Font.Size := FTextMarkSize;
                      if Printer.Printers.Count > 0
                        then cv.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY)
                        else cv.Font.PixelsPerInch := Screen.PixelsPerInch;

                      cv.Font.Color := DColor;
                      cv.Brush.Style := bsClear;
                      cv.TextOut (x1-tw div 2,y1-th div 2, chr(Mark));
                      end
                 else begin
                      case Mark of
                        0 : begin                               { pixel }
                            cv.Pixels [x1,y1] := Dcolor;
                            end;
                        1 : begin       { small plus }
                            cv.MoveTo (x1-1,y1);
                            cv.LineTo (x1+2,y1);
                            cv.MoveTo (x1,y1-1);
                            cv.LineTo (x1,y1+2);
                            end;
                        2 : begin       { medium plus }
                            cv.MoveTo (x1-2,y1);
                            cv.LineTo (x1+3,y1);
                            cv.MoveTo (x1,y1-2);
                            cv.LineTo (x1,y1+3);
                            end;
                        3 : begin       { large plus }
                            cv.MoveTo (x1-3,y1);
                            cv.LineTo (x1+4,y1);
                            cv.MoveTo (x1,y1-3);
                            cv.LineTo (x1,y1+4);
                            end;
                        4 : begin       { small cross }
                            cv.MoveTo (x1-1,y1-1);
                            cv.LineTo (x1+2,y1+2);
                            cv.MoveTo (x1-1,y1+1);
                            cv.LineTo (x1+2,y1-2);
                            end;
                        5 : begin       { medium cross }
                            cv.MoveTo (x1-2,y1-2);
                            cv.LineTo (x1+3,y1+3);
                            cv.MoveTo (x1-2,y1+2);
                            cv.LineTo (x1+3,y1-3);
                            end;
                        6 : begin       { large cross }
                            cv.MoveTo (x1-3,y1-3);
                            cv.LineTo (x1+4,y1+4);
                            cv.MoveTo (x1-3,y1+3);
                            cv.LineTo (x1+4,y1-4);
                            end;
                        7 : begin       { small block }
                            cv.Brush.Color := DColor;
                            cv.Rectangle (x1-1,y1-1,x1+2,y1+2);
                            end;
                        8 : begin       { medium block }
                            cv.Brush.Color := DColor;
                            cv.Rectangle (x1-2,y1-2,x1+3,y1+3);
                            end;
                        9 : begin       { large block }
                            cv.Brush.Color := DColor;
                            cv.Rectangle (x1-3,y1-3,x1+4,y1+4);
                            end;
                       10 : begin       { small empty block }
                            cv.MoveTo (x1-1,y1-1);
                            cv.LineTo (x1-1,y1+1);
                            cv.LineTo (x1+1,y1+1);
                            cv.LineTo (x1+1,y1-1);
                            cv.LineTo (x1-1,y1-1);
                            end;
                       11 : begin       { medium empty block }
                            cv.MoveTo (x1-2,y1-2);
                            cv.LineTo (x1-2,y1+2);
                            cv.LineTo (x1+2,y1+2);
                            cv.LineTo (x1+2,y1-2);
                            cv.LineTo (x1-2,y1-2);
                            end;
                       12 : begin       { large empty block }
                            cv.MoveTo (x1-3,y1-3);
                            cv.LineTo (x1-3,y1+3);
                            cv.LineTo (x1+3,y1+3);
                            cv.LineTo (x1+3,y1-3);
                            cv.LineTo (x1-3,y1-3);
                            end;
                       13 : begin       { small spade }
                            quad[1].x := x1-1;
                            quad[1].y := y1;
                            quad[2].x := x1;
                            quad[2].y := y1+1;
                            quad[3].x := x1+1;
                            quad[3].y := y1;
                            quad[4].x := x1;
                            quad[4].y := y1-1;
                            cv.polygon (quad);
                            end;
                       14 : begin       { medium spade }
                            quad[1].x := x1-2;
                            quad[1].y := y1;
                            quad[2].x := x1;
                            quad[2].y := y1+2;
                            quad[3].x := x1+2;
                            quad[3].y := y1;
                            quad[4].x := x1;
                            quad[4].y := y1-2;
                            cv.polygon (quad);
                            end;
                       15 : begin       { large spade }
                            quad[1].x := x1-3;
                            quad[1].y := y1;
                            quad[2].x := x1;
                            quad[2].y := y1+3;
                            quad[3].x := x1+3;
                            quad[3].y := y1;
                            quad[4].x := x1;
                            quad[4].y := y1-3;
                            cv.polygon (quad);
                            end;
                       16 : begin       { medium circle }
                            cv.brush.Style := bsClear;
                            cv.Ellipse (x1-2,y1-2,x1+3,y1+3);
                            cv.brush.Style := bsSolid;
                            end;
                       17 : begin       { large circle }
                            cv.brush.Style := bsClear;
                            cv.Ellipse (x1-3,y1-3,x1+4,y1+4);
                            cv.brush.Style := bsSolid;
                            end;
                       18 : begin       { large shaded block }
                            DisplayMarkAsBitMap (18);
                            end;
                       19 : begin       { empty large spade }
                            cv.MoveTo (x1-3, y1);
                            cv.LineTo (x1, y1+3);
                            cv.LineTo (x1+3, y1);
                            cv.LineTo (x1, y1-3);
                            cv.LineTo (x1-3, y1);
                            end;
                       20 : begin       { small hat }
                            cv.MoveTo (x1,y1);
                            cv.LineTo (x1-3,y1+3);
                            cv.MoveTo (x1,y1);
                            cv.LineTo (x1+3,y1+3);
                            end;
                       21 : begin       { large hat }
                            cv.MoveTo (x1,y1);
                            cv.LineTo (x1-4,y1+4);
                            cv.MoveTo (x1,y1);
                            cv.LineTo (x1+4,y1+4);
                            end;
                       22 : begin       { small inverse hat }
                            cv.MoveTo (x1,y1);
                            cv.LineTo (x1-3,y1-3);
                            cv.MoveTo (x1,y1);
                            cv.LineTo (x1+3,y1-3);
                            end;
                       23 : begin       { large inverse hat }
                            cv.MoveTo (x1,y1);
                            cv.LineTo (x1-4,y1-4);
                            cv.MoveTo (x1,y1);
                            cv.LineTo (x1+4,y1-4);
                            end;
                       24 : begin       { large filled circle }
                            cv.Brush.Color := DColor;
                            cv.Ellipse (x1-3,y1-3,x1+4,y1+4);
                            end;
                       25 : begin       { large bold cross }
                            cv.MoveTo (x1-3,y1-3);
                            cv.LineTo (x1+4,y1+4);
                            cv.MoveTo (x1-3,y1-2);
                            cv.LineTo (x1+3,y1+4);
                            cv.MoveTo (x1-2,y1-3);
                            cv.LineTo (x1+4,y1+3);
                            cv.MoveTo (x1-3,y1+3);
                            cv.LineTo (x1+4,y1-4);
                            cv.MoveTo (x1-3,y1+2);
                            cv.LineTo (x1+3,y1-4);
                            cv.MoveTo (x1-2,y1+3);
                            cv.LineTo (x1+4,y1-3);
                            end;
                      else
                        cv.Pixels [x1,y1] := DColor;
                      end;
                      end;
               end;
  end;
  end;

if FBoundBox <> bbNone then
  begin
  cv.Pen.Color  := FColorCubeFrame;  { now redraw visible cube boundaries }
  for j:=1 to 3 do
    begin
    cv.MoveTo ((CubeCorners[zminix,1]*RotMat[1,1]+
                            CubeCorners[zminix,2]*RotMat[1,2]+
                            CubeCorners[zminix,3]*RotMat[1,3]) div FMagnify + FCentX,
                           (CubeCorners[zminix,1]*RotMat[2,1]+
                            CubeCorners[zminix,2]*RotMat[2,2]+
                            CubeCorners[zminix,3]*RotMat[2,3]) div FMagnify + FCentY);
    cv.LineTo ((CubeCorners[CubeNeighbors[zminix,j],1]*RotMat[1,1]+
                            CubeCorners[CubeNeighbors[zminix,j],2]*RotMat[1,2]+
                            CubeCorners[CubeNeighbors[zminix,j],3]*RotMat[1,3]) div FMagnify + FCentX,
                           (CubeCorners[CubeNeighbors[zminix,j],1]*RotMat[2,1]+
                            CubeCorners[CubeNeighbors[zminix,j],2]*RotMat[2,2]+
                            CubeCorners[CubeNeighbors[zminix,j],3]*RotMat[2,3]) div FMagnify + FCentY);
    end;
  end;

if FShowAxes then  { now display ax names }
  begin
  cv.Font.Name := Font.Name;
  cv.Font.Style := Font.Style;
                         { the following three lines are a work around for a nasty Windows bug
                           which causes the printer fonts to be scaled improperly (sometimes);
                           following the motto: beat dirty bugs with dirty tricks - sorry }
  cv.Font.PixelsPerInch := Screen.PixelsPerInch;
  cv.Font.Size := Font.Size;
  if Printer.Printers.Count > 0
    then cv.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY)
    else cv.Font.PixelsPerInch := Screen.PixelsPerInch;


  cv.Font.Color  := Font.Color;
  cv.Brush.Style := bsClear;
  tw := cv.TextWidth (FAxName[3]) div 2;
  th := cv.TextHeight (FAxName[3]) div 2;
  cv.TextOut ((0*RotMat[1,1]+0*RotMat[1,2]+(FAxSize+AxNameDist)*RotMat[1,3]) div FMagnify + FCentX - tw,
              (0*RotMat[2,1]+0*RotMat[2,2]+(FAxSize+AxNameDist)*RotMat[2,3]) div FMagnify + FCentY - th,
              FaxName[3]);
  tw := cv.TextWidth (FAxName[2]) div 2;
  th := cv.TextHeight (FAxName[2]) div 2;
  cv.TextOut ((0*RotMat[1,1]+(FAxSize+AxNameDist)*RotMat[1,2]+0*RotMat[1,3]) div FMagnify + FCentX - tw,
              (0*RotMat[2,1]+(FAxSize+AxNameDist)*RotMat[2,2]+0*RotMat[2,3]) div FMagnify + FCentY - th,
              FAxName[2]);
  tw := cv.TextWidth (FAxName[1]) div 2;
  th := cv.TextHeight (FAxName[1]) div 2;
  cv.TextOut (((FAxSize+AxNameDist)*RotMat[1,1]+0*RotMat[1,2]+0*RotMat[1,3]) div FMagnify + FCentX - tw,
              ((FAxSize+AxNameDist)*RotMat[2,1]+0*RotMat[2,2]+0*RotMat[2,3]) div FMagnify + FCentY - th,
              FAxName[1]);
  end;


{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
if not DelphiIsRunning then
  begin
  cv.Font.Color := clWhite;
  cv.Font.Name := 'MS Sans Serif';
  cv.Brush.Color := clNavy;
  cv.Brush.Style := bsSolid;
  cv.Font.Size := 1;
  astr := GetVisMsgStr;
  j := 0;
  while length(astr) > 0 do
    begin
    i := pos (#10, astr);
    if i = 0 then
      i := length(astr);
    cv.TextOut (10,10+20*j, ' '+copy (astr,1,i-1)+' ');
    inc(j);
    delete (astr,1,i);
    end;
  end;
{$ENDIF}
end;




(******************************************************************)
procedure TRot3D.CopyToClipboard;
(******************************************************************)

begin
InitGraf (GrafBmp.Canvas, false);
ConstructDataBmp (GrafBmp.Canvas, false);                      { create data image }
ConstructFrame (GrafBmp.Canvas);
Clipboard.Assign (GrafBmp);
end;


(******************************************************************)
procedure TRot3D.CopyToBMP (FName: string);
(******************************************************************
  ENTRY:   FName ..... name of bitmap file to be created
  EXIT:    bit map file contains BMP copy of Rot3D
 ******************************************************************)

var
  astr1, astr2  : string;
  i             : integer;

begin
InitGraf (GrafBmp.Canvas, false);
ConstructDataBmp (GrafBmp.Canvas, false);                      { create data image }
ConstructFrame (GrafBmp.Canvas);
astr1 := ExtractFilepath(FName);             { force BMP extension }
astr2 := ExtractFileName(Fname);
i := pos ('.', astr2);
if i > 0 then
  delete (astr2,i,255);
GrafBmp.SaveToFile (astr1+astr2+'.bmp');
end;


(******************************************************************)
procedure TRot3D.CopyToWMF (FName: string);
(******************************************************************
  ENTRY:   FName ..... name of metafile file to be created
  EXIT:    file contains metafile copy of Rot3D
 ******************************************************************)

var
  astr1, astr2  : string;
  i             : integer;
  WMFCanvas     : TCanvas;
  AuxWMF        : TMetaFile;
  Rect          : TRect;

begin
WMFCanvas := TCanvas.Create;
Rect.Left := 0;
Rect.Top := 0;
Rect.Right := round(2540.0*(Width-1)/Screen.PixelsPerInch);
Rect.Bottom := round(2540.0*(Height-1)/Screen.PixelsPerInch);
{$IFNDEF VER80}
WMFCanvas.Handle := CreateEnhMetafile(0, NIL, @Rect, NIL);
{$ELSE}
WMFCanvas.Handle := CreateMetafile(NIL);
{$ENDIF}
InitGraf (WMFCanvas, false);
ConstructDataBmp (WMFCanvas, false);         { create data image }
ConstructFrame (WMFCanvas);
astr1 := ExtractFilepath(FName);             { force WMF extension }
astr2 := ExtractFileName(Fname);
i := pos ('.', astr2);
if i > 0 then
  delete (astr2,i,255);
AuxWMF := TMetaFile.Create;
{$IFNDEF VER80}
AuxWMF.Handle := closeEnhMetafile(WMFCanvas.handle);
{$ELSE}
AuxWMF.Handle := closeMetafile(WMFCanvas.handle);
{$ENDIF}
AuxWMF.SaveToFile(astr1+astr2+'.wmf');
AuxWMF.Free;
end;


(******************************************************************)
procedure TRot3D.Printit (ScaleF: double; BlkWhite: boolean);
(******************************************************************
  ENTRY:   BlkWhite ... graphic is printed in black and white if TRUE
  EXIT:    Rot3D graphic is printed
 ******************************************************************)

var
  xpix, ypix     : integer;

begin
Printer.BeginDoc;
xpix := GetDeviceCaps (Printer.Handle, LOGPIXELSX);
ypix := GetDeviceCaps (Printer.Handle, LOGPIXELSY);
SetMapMode (Printer.Handle, mm_isotropic);      { use mapping to adjust size }
{$IFDEF VER80}
  SetWindowExt (Printer.Handle, Screen.PixelsPerInch, Screen.PixelsPerInch);     { 16-Bit version }
  SetViewportExt (Printer.Handle, round(ScaleF*xpix), round(ScaleF*ypix));
{$ELSE}
  SetWindowExtEx (Printer.Handle, Screen.PixelsPerInch, Screen.PixelsPerInch, nil);    { 32-Bit version }
  SetViewportExtEx (Printer.Handle, round(ScaleF*xpix), round(ScaleF*ypix), nil);
{$ENDIF}
InitGraf (Printer.Canvas, BlkWhite);
ConstructDataBmp (Printer.Canvas, BlkWhite);         { create data image }
ConstructFrame (Printer.Canvas);
Printer.EndDoc;
end;


(******************************************************************)
procedure TRot3D.CopyToClipboardWMF;
(******************************************************************)

var
  WMFCanvas     : TCanvas;
  AuxWMF        : TMetaFile;
  Rect          : TRect;

begin
WMFCanvas := TCanvas.Create;
Rect.Left := 0;
Rect.Top := 0;
Rect.Right := round(2540.0*(Width-1)/Screen.PixelsPerInch);
Rect.Bottom := round(2540.0*(Height-1)/Screen.PixelsPerInch);
{$IFNDEF VER80}
WMFCanvas.Handle := CreateEnhMetafile(0, NIL, @Rect, NIL);
{$ELSE}
WMFCanvas.Handle := CreateMetafile(NIL);
{$ENDIF}
InitGraf (WMFCanvas, false);                      { create data image }
ConstructDataBmp (WMFCanvas, false);
ConstructFrame (WMFCanvas);
AuxWMF := TMetaFile.Create;
AuxWMF.Inch := Screen.PixelsPerInch;
{$IFNDEF VER80}
AuxWMF.Handle := closeEnhMetafile(WMFCanvas.handle);
{$ELSE}
AuxWMF.Handle := closeMetafile(WMFCanvas.handle);
{$ENDIF}
Clipboard.Assign (AuxWMF);
AuxWMF.Free;
end;



(***********************************************************************)
procedure TRot3D.SetTextFontStyle (tfs: TFontStyles);
(***********************************************************************)

begin
FTextFontStyle := tfs;
Paint;
end;

(***********************************************************************)
procedure TRot3D.SetTextMarkSize (tms: byte);
(***********************************************************************)

begin
FTextMarkSize := tms;
Paint;
end;


(***********************************************************************)
procedure TRot3D.SetFrameCol (c: TColor);
(***********************************************************************)

begin
RCFrameCol := c;
Paint;
end;

(***********************************************************************)
procedure TRot3D.SetDataCol (c: TColor);
(***********************************************************************)

begin
RcDataCol := c;
end;

(***********************************************************************)
procedure TRot3D.SetDataTag (tag: longint);
(***********************************************************************)

begin
FDataTag := tag;
end;


(***********************************************************************)
procedure TRot3D.SetChartCol (c: TColor);
(***********************************************************************)

begin
RcChartCol := c;
Paint;
end;

(***********************************************************************)
procedure TRot3D.SetColCubeFrame (c: TColor);
(***********************************************************************)

begin
FColorCubeFrame := c;
Paint;
end;

(***********************************************************************)
procedure TRot3D.SetColCubeHidLin (c: TColor);
(***********************************************************************)

begin
FColorCubeHidLin := c;
Paint;
end;

(***********************************************************************)
procedure TRot3D.SetColCubeFaceLow (c: TColor);
(***********************************************************************)

begin
FColorCubeFaceLo := c;
Paint;
end;

(***********************************************************************)
procedure TRot3D.SetColCubeFaceHigh (c: TColor);
(***********************************************************************)

begin
FColorCubeFaceHi := c;
Paint;
end;


(******************************************************************)
procedure TRot3D.MarkAt (x,y,z: double; mk: byte);
(******************************************************************
ENTRY: x,y ....... location where to place point (mark)
       mk  ....... type of mark

EXIT:  A mark is drawn at the location (x,y).
*******************************************************************)

begin
RcLastCan^.Element := TkMarkAt;
RcLastCan^.x := x;
RcLastCan^.y := y;
RcLastCan^.z := z;
RcLastCan^.Color := RcDataCol;
RcLastCan^.Tag := FDataTag;
RcLastCan^.mark := mk;

RcLastCan^.Next := new (PDrawCan); (* create new empty entry in item chain *)
RcLastCan := RcLastCan^.Next;
RcLastCan^.Element := tkNone;
end;


(******************************************************************)
procedure TRot3D.MoveTo (x,y,z: double);
(******************************************************************
ENTRY: x,y ....... point where cursor to move to

EXIT:  drawing cursor is moved to [x,y]
*******************************************************************)

begin
RcLastCan^.Element := TkMoveto;
RcLastCan^.Color := RcDataCol;
RcLastCan^.Tag := FDataTag;
RcLastCan^.x := x;
RcLastCan^.y := y;
RcLastCan^.z := z;
RcLastCan^.Next := new (PDrawCan); (* create new entry in item chain *)
RcLastCan := RcLastCan^.Next;
RcLastCan^.Element := tkNone;
end;


(******************************************************************)
procedure TRot3D.DrawTo (x,y,z: double);
(******************************************************************
ENTRY: x,y ....... point where to draw to

EXIT:  line is drawn from current cursor location to [x,y]
*******************************************************************)

begin
RcLastCan^.Element := TkLineto;
RcLastCan^.x := x;
RcLastCan^.y := y;
RcLastCan^.z := z;
RcLastCan^.Color := RcDataCol;
RcLastCan^.Tag := FDataTag;
RcLastCan^.Next := new (PDrawCan); (* create new entry in item chain *)
RcLastCan := RcLastCan^.Next;
RcLastCan^.Element := tkNone;
end;



(******************************************************************)
procedure TRot3D.Line (x1,y1,z1, x2, y2,z2: double);
(******************************************************************
ENTRY: x1,y1 ....... starting point of line
       x2,y2 ....... end point of line

EXIT:  line is drawn between [x1,y1] and [x2,y2]
*******************************************************************)

begin
RcLastCan^.Element := TkLine;
RcLastCan^.x := x1;
RcLastCan^.y := y1;
RcLastCan^.z := z1;
RcLastCan^.x2 := x2;
RcLastCan^.y2 := y2;
RcLastCan^.z2 := z2;
RcLastCan^.Color := RcDataCol;
RcLastCan^.Tag := FDataTag;
RcLastCan^.Next := new (PDrawCan); (* create new entry in item chain *)
RcLastCan := RcLastCan^.Next;
RcLastCan^.Element := tkNone;
end;


(***********************************************************************)
procedure TRot3D.SetColorScheme (Value: TColorScheme);
(***********************************************************************)

begin
if Value <> FColorScheme then
  begin
  FColorScheme := Value;
  if FColorScheme = csBWG
    then begin
{        FColBlackLine := clBlack;  prepared for future extension }
         FColGrayLine  := clGray;
         FColWhiteLine := clWhite;
         end
    else begin
{        FColBlackLine := clBlack;  prepared for future extension }
         FColGrayLine  := clBtnShadow;
         FColWhiteLine := clBtnHighLight;
         end;
  Paint;
  end;
end;


(***********************************************************************)
procedure TRot3D.SetFrameStyle (value: TFrameStyle);
(***********************************************************************)

begin
if Value <> FFrameStyle then
  begin
  FFrameStyle := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TRot3D.SetBoundBoxStyle (value: TBoundingBox);
(***********************************************************************)

begin
if Value <> FBoundbox then
  begin
  FBoundBox := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TRot3D.SetBoundBoxSize (value: integer);
(***********************************************************************)

begin
if Value <> 2*FBBSize then
  begin
  if value < 0 then
    value := 0;
  if value > 2000 then
    value := 2000;
  FBBSize := Value div 2;
  SetCubeCorners;
  Paint;
  end;
end;

(***********************************************************************)
function TRot3D.GetBoundBoxSize: integer;
(***********************************************************************)

begin
GetBoundBoxSize := 2*FBBSize;
end;



(***********************************************************************)
procedure TRot3D.SetAxSize (value: integer);
(***********************************************************************)

begin
if Value <> FAxSize then
  begin
  if Value < 0 then
    Value := 0;
  if Value > 2000 then
    Value := 2000;
  FAxSize := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TRot3D.SetCentX (value: integer);
(***********************************************************************)

begin
if Value <> FCentX then
  begin
  if Value < 0 then
    Value := 0;
  if Value > Width then
    Value := Width ;
  FCentX := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TRot3D.SetCentY (value: integer);
(***********************************************************************)

begin
if Value <> FCentY then
  begin
  if Value < 0 then
    Value := 0;
  if Value > Height then
    Value := Height;
  FCentY := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TRot3D.SetShowAxes (value: boolean);
(***********************************************************************)

begin
if Value <> FShowAxes then
  begin
  FShowAxes := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TRot3D.SetIsoMetric (value: boolean);
(***********************************************************************)

begin
if Value <> FIsoMetric then
  begin
  FIsoMetric := Value;
  MakeVisible;
  end;
end;

(***********************************************************************)
procedure TRot3D.SetAutoOrigin (value: boolean);
(***********************************************************************)

begin
if Value <> FAutoOrigin then
  begin
  FAutoOrigin := Value;
  MakeVisible;
  end;
end;

(***********************************************************************)
procedure TRot3D.SetAutoScale (value: boolean);
(***********************************************************************)

begin
if Value <> FAutoScale then
  begin
  FAutoScale := Value;
  MakeVisible;
  end;
end;


(***********************************************************************)
function TRot3D.GetViewAngleX: double;
(***********************************************************************)

begin
GetViewAngleX := FViewAngle[1];
end;

(***********************************************************************)
function TRot3D.GetViewAngleY: double;
(***********************************************************************)

begin
GetViewAngleY := FViewAngle[2];
end;

(***********************************************************************)
function TRot3D.GetViewAngleZ: double;
(***********************************************************************)

begin
GetViewAngleZ := FViewAngle[3];
end;


(***********************************************************************)
procedure TRot3D.SetViewAngles (vax, vay, vaz: double);
(***********************************************************************)

begin
if (vax <> FViewAngle[1]) or (vay <> FViewAngle[2]) or (vaz <> FViewAngle[3]) then
  begin
  FViewAngle[1] := vax;
  FViewAngle[2] := vay;
  FViewAngle[3] := vaz;
  FAngleAnchor[1] := FViewAngle[1];
  FAngleAnchor[2] := FViewAngle[2];
  CalcRotMatrix;
  Paint;
  end;
end;



(***********************************************************************)
procedure TRot3D.SetViewAngleX (value: double);
(***********************************************************************)

begin
if Value <> FViewAngle[1] then
  begin
  FAngleAnchor[1] := Value; //##
  FViewAngle[1] := Value;
  CalcRotMatrix;
  Paint;
  end;
end;


(***********************************************************************)
procedure TRot3D.SetViewAngleY (value: double);
(***********************************************************************)

begin
if Value <> FViewAngle[2] then
  begin
  FAngleAnchor[2] := Value; //##
  FViewAngle[2] := Value;
  CalcRotMatrix;
  Paint;
  end;
end;


(***********************************************************************)
procedure TRot3D.SetViewAngleZ (value: double);
(***********************************************************************)

begin
if Value <> FViewAngle[3] then
  begin
  FViewAngle[3] := Value;
  CalcRotMatrix;
  Paint;
  end;
end;


(***********************************************************************)
function TRot3D.GetScaleFactX: double;
(***********************************************************************)

begin
GetScaleFactX := FScaleFact[1];
end;

(***********************************************************************)
function TRot3D.GetScaleFactY: double;
(***********************************************************************)

begin
GetScaleFactY := FScaleFact[2];
end;

(***********************************************************************)
function TRot3D.GetScaleFactZ: double;
(***********************************************************************)

begin
GetScaleFactZ := FScaleFact[3];
end;


(***********************************************************************)
function TRot3D.GetOriginX: double;
(***********************************************************************)

begin
GetOriginX := FOrigin[1];
end;

(***********************************************************************)
function TRot3D.GetOriginY: double;
(***********************************************************************)

begin
GetOriginY := FOrigin[2];
end;

(***********************************************************************)
function TRot3D.GetOriginZ: double;
(***********************************************************************)

begin
GetOriginZ := FOrigin[3];
end;



(***********************************************************************)
procedure TRot3D.SetOrigins (vax, vay, vaz: double);
(***********************************************************************)

begin
if (vax <> FOrigin[1]) or (vay <> FOrigin[2]) or (vaz <> FOrigin[3]) then
  begin
  FOrigin[1] := vax;
  FOrigin[2] := vay;
  FOrigin[3] := vaz;
  Paint;
  end;
end;


(***********************************************************************)
procedure TRot3D.SetScaleFactors (sfx, sfy, sfz: double);
(***********************************************************************)

begin
if (sfx <> FScaleFact[1]) or (sfy <> FScaleFact[2]) or (sfz <> FScaleFact[3]) then
  begin
  FScaleFact[1] := sfx;
  FScaleFact[2] := sfy;
  FScaleFact[3] := sfz;
  Paint;
  end;
end;



(***********************************************************************)
procedure TRot3D.SetOriginX (value: double);
(***********************************************************************)

begin
if Value <> FOrigin[1] then
  begin
  FOrigin[1] := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TRot3D.SetOriginY (value: double);
(***********************************************************************)

begin
if Value <> FOrigin[2] then
  begin
  FOrigin[2] := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TRot3D.SetOriginZ (value: double);
(***********************************************************************)

begin
if Value <> FOrigin[3] then
  begin
  FOrigin[3] := Value;
  Paint;
  end;
end;



(***********************************************************************)
procedure TRot3D.SetScaleFactX (value: double);
(***********************************************************************)

begin
if Value <> FScaleFact[1] then
  begin
  FScaleFact[1] := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TRot3D.SetScaleFactY (value: double);
(***********************************************************************)

begin
if Value <> FScaleFact[2] then
  begin
  FScaleFact[2] := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TRot3D.SetScaleFactZ (value: double);
(***********************************************************************)

begin
if Value <> FScaleFact[3] then
  begin
  FScaleFact[3] := Value;
  Paint;
  end;
end;



(***********************************************************************)
function TRot3D.GetAxNameX: TAxName;
(***********************************************************************)

begin
GetAxNameX := FAxName[1];
end;

(***********************************************************************)
function TRot3D.GetAxNameY: TAxName;
(***********************************************************************)

begin
GetAxNameY := FAxName[2];
end;

(***********************************************************************)
function TRot3D.GetAxNameZ: TAxName;
(***********************************************************************)

begin
GetAxNameZ := FAxName[3];
end;


(***********************************************************************)
procedure TRot3D.SetAxNameX (value: TAxName);
(***********************************************************************)

begin
if Value <> FAxName[1] then
  begin
  FAxName[1] := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TRot3D.SetAxNameY (value: TAxName);
(***********************************************************************)

begin
if Value <> FAxName[2] then
  begin
  FAxName[2] := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TRot3D.SetAxNameZ (value: TAxName);
(***********************************************************************)

begin
if Value <> FAxName[3] then
  begin
  FAxName[3] := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TRot3D.SetMagnify (mag: double);
(***********************************************************************)

begin
if mag < MinMagnify then
  mag := MinMagnify;
if mag > MaxMagnify then
  mag := MaxMagnify;
FMagnify := round(2000.0/mag);
Paint;
end;

(***********************************************************************)
function TRot3D.GetMagnify: double;
(***********************************************************************)

begin
GetMagnify := 2000.0/FMagnify;
end;


(***********************************************************************)
procedure TRot3D.MakeVisible;
(***********************************************************************)

var
  np       : PDrawCan;
  MinCoord : array[1..3] of double;
  MaxCoord : array[1..3] of double;
  sclfx    : double;
  sclfy    : double;
  sclfz    : double;
  sclMin   : double;
  sum      : array[1..3] of double;
  i        : integer;
  OldNrotObj : integer;
  NDefColors : integer;
  found      : boolean;

begin
OldNrotObj := NRotObj;
NRotObj := 0;
for i:=1 to 3 do
  begin
  sum[i] := 0;
  MinCoord[i] := R3MaxDouble;
  MaxCoord[i] := -R3MaxDouble;
  end;
np := RcFrstCan;
while np^.Element <> tkNone do   { find minimum and maximum coords }
  begin
  inc (NRotObj);
  if np^.Element = tkLine then  { line results in 2 objects - tkmove and tklineto }
    inc (NRotObj);
  sum[1] := sum[1] + np^.x;
  sum[2] := sum[2] + np^.y;
  sum[3] := sum[3] + np^.z;
  if np^.x < MinCoord[1] then
    MinCoord[1] := np^.x;
  if np^.x > MaxCoord[1] then
    MaxCoord[1] := np^.x;
  if np^.y < MinCoord[2] then
    MinCoord[2] := np^.y;
  if np^.y > MaxCoord[2] then
    MaxCoord[2] := np^.y;
  if np^.z < MinCoord[3] then
    MinCoord[3] := np^.z;
  if np^.z > MaxCoord[3] then
    MaxCoord[3] := np^.z;
  if (np^.Element = tkLine) then
    begin
    if np^.x2 < MinCoord[1] then
      MinCoord[1] := np^.x2;
    if np^.x2 > MaxCoord[1] then
      MaxCoord[1] := np^.x2;
    if np^.y2 < MinCoord[2] then
      MinCoord[2] := np^.y2;
    if np^.y2 > MaxCoord[2] then
      MaxCoord[2] := np^.y2;
    if np^.z2 < MinCoord[3] then
      MinCoord[3] := np^.z2;
    if np^.z2 > MaxCoord[3] then
      MaxCoord[3] := np^.z2;
    end;
  np := np^.Next;
  end;
if NRotObj > 0 then    { calculate center of data cloud }
  begin
  for i:=1 to 3 do
    sum[i] := sum[i]/NRotObj;
  if FAutoOrigin
    then begin
         FOrigin[1] := sum[1];
         FOrigin[2] := sum[2];
         FOrigin[3] := sum[3];
         end
    else begin
         sum[1] := FOrigin[1];
         sum[2] := FOrigin[2];
         sum[3] := FOrigin[3];
         end;
  if FRotProp <> NIL then
    FreeMem (FRotProp, OldNRotObj*sizeof(byte));
  GetMem (FRotProp, NRotObj*sizeof(Byte));
  if FBackLink <> NIL then
    FreeMem (FBackLink, OldNRotObj*sizeof(PDrawCan));
  GetMem (FBackLink, NRotObj*sizeof(PDrawCan));
  if FRotMark <> NIL then
    FreeMem (FRotMark, OldNRotObj*sizeof(byte));
  GetMem (FRotMark, NRotObj*sizeof(Byte));
  if FRotDataX <> NIL then
    FreeMem (FRotDataX, OldNRotObj*sizeof(integer));
  GetMem (FRotDataX, NRotObj*sizeof(integer));
  if FRotDataY <> NIL then
    FreeMem (FRotDataY, OldNRotObj*sizeof(integer));
  GetMem (FRotDataY, NRotObj*sizeof(integer));
  if FRotDataZ <> NIL then
    FreeMem (FRotDataZ, OldNRotObj*sizeof(integer));
  GetMem (FRotDataZ, NRotObj*sizeof(integer));

  if abs(MaxCoord[1]-MinCoord[1]) > smallPosNum
    then sclfx := 1000/abs(MaxCoord[1]-MinCoord[1])
    else sclfx := 1.0;
  if abs(MaxCoord[2]-MinCoord[2]) > smallPosNum
    then sclfy := 1000/abs(MaxCoord[2]-MinCoord[2])
    else sclfy := 1.0;
  if abs(MaxCoord[3]-MinCoord[3]) > smallPosNum
    then sclfz := 1000/abs(MaxCoord[3]-MinCoord[3])
    else sclfz := 1.0;
  if FIsometric then
    begin
    sclMin := sclfx;
    if sclfy < sclMin
      then sclMin := sclfy;
    if sclfz < sclMin
      then sclMin := sclfz;
    sclfx := sclMin;
    sclfy := sclMin;
    sclfz := sclMin;
    end;
  if not FAutoScale then
    begin
    sclfx := FScaleFact[1];
    sclfy := FScaleFact[2];
    sclfz := FScaleFact[3];
    if FIsoMetric then
      begin
      sclfy := sclfx;
      sclfz := sclfx;
      end;
    end;
  FScaleFact[1] := sclfx;
  FScaleFact[2] := sclfy;
  FScaleFact[3] := sclfz;
  FMaxCoord[1] := round((MaxCoord[1]-sum[1])*sclfx);
  FMinCoord[1] := round((MinCoord[1]-sum[1])*sclfx);
  FMaxCoord[2] := round((MaxCoord[2]-sum[2])*sclfy);
  FMinCoord[2] := round((MinCoord[2]-sum[2])*sclfy);
  FMaxCoord[3] := round((MaxCoord[3]-sum[3])*sclfz);
  FMinCoord[3] := round((MinCoord[3]-sum[3])*sclfz);
  NRotObj := 0;           { now create object buffer }
  NdefColors := 15;  { number of defined item colors; default is 15+1 system colors }
  np := RcFrstCan;
  while np^.Element <> tkNone do
    begin
    inc (NRotObj);
    Array1DI(FRotDataX^)[NRotObj] := round((np^.x-sum[1])*sclfx);
    Array1DI(FRotDataY^)[NRotObj] := round((np^.y-sum[2])*sclfy);
    Array1DI(FRotDataZ^)[NRotObj] := round((np^.z-sum[3])*sclfz);
    Array1DB(FRotProp^)[NRotObj] := 0;
    Array1DP(FBackLink^)[NRotObj] := np;

    found := false;   { assign color from color lookup table }
    for i:=0 to NDefColors do
      if np^.color = FItemColors[i] then
        begin
        Array1DB(FRotProp^)[NRotObj] := i;
        found := true;
        end;
    if not found then
      begin
      if (NDefColors < MaxItemColors) then
        begin           { color not found; enter into table if space available }
        inc (NDefColors);
        FItemColors[NDefColors] := np^.color;
        end;
      Array1DB(FRotProp^)[NRotObj] := NDefColors;
      end;
    case np^.Element of
      tkMarkAt : begin
                 Array1DB(FRotProp^)[NRotObj] := Array1DB(FRotProp^)[NRotObj] or $60;
                 Array1DB(FRotMark^)[NRotObj] := np^.mark;
                 end;
      tkMoveto : begin
                 Array1DB(FRotProp^)[NRotObj] := Array1DB(FRotProp^)[NRotObj] or $20;
                 end;
      tkLineto : begin
                 Array1DB(FRotProp^)[NRotObj] := Array1DB(FRotProp^)[NRotObj] or $40;
                 end;
        tkLine : begin   { line is resolved into Moveto/LineTo combination }
                 Array1DB(FRotProp^)[NRotObj] := Array1DB(FRotProp^)[NRotObj] or $20;
                 inc (NRotObj);
                 Array1DB(FRotProp^)[NRotObj] := Array1DB(FRotProp^)[NRotObj-1] and $0F;
                 Array1DB(FRotProp^)[NRotObj] := Array1DB(FRotProp^)[NRotObj] or $40;
                 Array1DI(FRotDataX^)[NRotObj] := round((np^.x2-sum[1])*sclfx);
                 Array1DI(FRotDataY^)[NRotObj] := round((np^.y2-sum[2])*sclfy);
                 Array1DI(FRotDataZ^)[NRotObj] := round((np^.z2-sum[3])*sclfz);
                 Array1DP(FBackLink^)[NRotObj] := np;
                 end;
    end;
    np := np^.Next;
    end;
  Paint;
  end;
end;


(******************************************************************)
function TRot3d.FindNearestItemReal (mx, my, mz: double;
          ItemID: ItemType; var dist: double): PDrawCan;
(******************************************************************
ENTRY: mx, my, mz ... real-world coords of search position
       ItemID ....... type of Item to be searched for

EXIT:  The pointer to the Item which is nearest to the position [mx,my,mz]
       is returned. The distance is calulated from the real-world
       coordinates. A NIL value indicates that no Item of this type
       is present in the linked list. The distance of the closest item
       is returned in variable 'dist'.
*******************************************************************)

var
  idx      : PDrawCan;
  d        : double;
  np       : PDrawCan;

begin
idx := NIL;
dist := R3MaxDouble;
np := RcFrstCan;
if ItemID <> tkNone then            { search only if ItemID is not tkNone }
  begin
  while (np^.Element <> tkNone) do
    begin
    if ((ItemID = TkEverything) or (np^.Element = ItemID)) then
      begin
      d := sqr(np^.x - mx) + sqr(np^.y-my) + sqr(np^.z-mz);
      if d < dist then
        begin
        dist := d;
        idx := np;
        end;
      end;
    np := np^.Next;
    end;
  end;
dist := sqrt(dist);
FindNearestItemReal := idx;
end;


(******************************************************************)
function TRot3D.FindNearestItemScreen (mx, my: integer;
          ItemID: ItemType; var dist: double): PDrawCan;
(******************************************************************
ENTRY: mx, my ....... screen coords of search position
       ItemID ....... type of Item to be searched for

EXIT:  The pointer to the Item which is nearest to the screen position
       [mx,my] is returned. The distance is calculated from the screen
       coordinates. A NIL value indicates that no Item of this type
       is present in the linked list. The distance of the closest item
       is returned in variable 'dist'.
*******************************************************************)

var
  idx      : integer;
  d        : double;
  mxscr    : double;
  myscr    : double;
  txscr    : double;
  tyscr    : double;
  obj      : integer;

begin
idx := 0;
dist := R3MaxDouble;
mxscr := mx;
myscr := my;
for obj:=1 to NRotObj do                { search the graphics objects  }
  begin
  txscr := (Array1DI(FRotDataX^)[obj]*RotMat[1,1] +
            Array1DI(FRotDataY^)[obj]*RotMat[1,2] +
            Array1DI(FRotDataZ^)[obj]*RotMat[1,3])
            div FMagnify + FCentX;
  tyscr := (Array1DI(FRotDataX^)[obj]*RotMat[2,1] +
            Array1DI(FRotDataY^)[obj]*RotMat[2,2] +
            Array1DI(FRotDataZ^)[obj]*RotMat[2,3])
            div FMagnify + FCentY;
  d := sqr(txscr-mxscr) + sqr(tyscr-myscr);
  if (d < dist) then
    if (PDrawCan(Array1DP(FBackLink^)[obj])^.Element = ItemID) or
       (ItemID = tkEverything) then
      begin
      dist := d;
      idx := obj;
      end;
  end;
dist := sqrt(dist);
if idx = 0
  then FindNearestItemScreen := NIL
  else FindNearestItemScreen := Array1DP(FBackLink^)[idx];
end;



(***********************************************************************)
procedure Register;
(***********************************************************************)

begin
RegisterComponents ('SDL', [TRot3D]);
end;


end.

