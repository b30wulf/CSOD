unit plot3d;

(******************************************************************)
(*                                                                *)
(*                           P L O T 3 D                          *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 2000..2001 H. Lohninger                November 2000   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: May-12, 2001                                  *)
(*                                                                *)
(******************************************************************)

{ Revision history:

6.0   [Aug-06, 2001]
      first release to the public

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



{------------------------------------------------------------------------------}
interface
{------------------------------------------------------------------------------}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes,
  Graphics, Controls, Forms,  ExtCtrls, matrix;

const
  defFrameCol   = clBlack;                         { default frame color }
  defBakGndCol  = clWhite;                    { default background color }
  defFillCol  = clYellow;                      { default mesh fill color }
  defMeshCol  = clBlack;                      { default mesh lines color }
  defHeight     = 500;
  defWidth      = 650;

type
  TColorScheme = (csBWG, csSystem);
  TFrameStyle = (fsNone, fsSimple, fsLowered, fsRaised, fsEmbossed, fsEngraved);
  TColorCodingMode = (ccmTwoColors, ccmThreeColors);
  MouseActMode = (maNone, maRotate, maZoom, maRotAndZoom, maPan, maRotXOnly, maRotZOnly);
  TMouseActionEvent = procedure (Sender: TObject; var CenterX, CenterY: integer; var RotXAngle, RotZAngle, Magnification: double; Shift: TShiftState) of object;
  TPlot3D = class(TGraphicControl)
            private
              GrafBmp         : TBitmap;          { off-screen graphics bitmap }
              RcFrameCol      : TColor;                       { color of frame }
              FMouseAction    : MouseActMode;   { type of allowed mouse action }
              FColorBakGnd    : TColor;                     { background color }
              FColorMesh      : TColor;                  { color of mesh lines }
              FColorFillHigh  : TColor;                   { fill color of mesh }
              FColorFillMid   : TColor;                   { fill color of mesh }
              FColorFillLow   : TColor;                   { fill color of mesh }
              FColorScaleLow  : double;          { lower border of color scale }
              FColorScaleHigh : double;          { upper border of color scale }
              FColorCodingMode: TColorCodingMode;        { color encoding mode }
              FColBlackLine   : TColor;             { colors to draw the frame }
              FColGrayLine    : TColor;                       { -"- }
              FColWhiteLine   : TColor;                       { -"- }
              FColorScheme    : TColorScheme;         { color scheme of frames }
              FFrameStyle     : TFrameStyle;                  { style of frame }
              FViewAngle      : array[1..3] of double;    { view point of data }
              FMagnify        : double;             { 1 / magnification factor }
              FMagAnchor      : double;   { magnification anchor for rel. zoom }
              FMeshVisible    : boolean;{TRUE: mesh is visible using ColorMesh }
              FOnMouseAction  : TMouseActionEvent;
              FCentX          : integer;                     { center of chart }
              FCentY          : integer;
              FCentXAnchor    : integer;
              FCentYAnchor    : integer;
              FAngleAnchor    : array[1..3] of double;
              FMinZ           : double;      { minimum and maximum data values }
              FMaxZ           : double;
              FSclXIntern     : double;            { internal scaling factor X }
              FSclYIntern     : double;            { internal scaling factor Y }
              FSclZIntern     : double;            { internal scaling factor Z }
              RotMat          : array[1..3,1..3] of double;  { rotation matrix }
              MouseAnchorX    : integer;      { anchor for relative mouse move }
              MouseAnchorY    : integer;

              procedure ConstructDataBmp (cv: TCanvas; BlkWhite: boolean);
              procedure InitGraf (cv: TCanvas);
              procedure ConstructFrame (cv: TCanvas);
              procedure CalcRotMatrix;
              function  CalcColorCoding (value: double): TColor;
              function  GetMagnify: double;
              procedure SetCentX (value: integer);
              procedure SetCentY (value: integer);
              procedure SetColorScheme (Value: TColorScheme);
              procedure SetColorCodingMode (Value: TColorCodingMode);
              procedure SetFrameCol (c: TColor);
              procedure SetColorBakGnd (c: TColor);
              procedure SetColorFillHigh (c: TColor);
              procedure SetColorFillMid (c: TColor);
              procedure SetColorFillLow (c: TColor);
              procedure SetColorMesh (c: TColor);
              function  GetColorScaleHigh: double;
              procedure SetColorScaleHigh (Level: double);
              function  GetColorScaleLow: double;
              procedure SetColorScaleLow (Level: double);
              procedure SetFrameStyle (value: TFrameStyle);
              procedure SetMagnify (mag: double);
              procedure SetMeshVisible (meshvis: boolean);
              procedure SetSclX (fact: double);
              procedure SetSclY (fact: double);
              procedure SetSclZ (fact: double);
              procedure SetViewAngleX (value: double);
              procedure SetViewAngleZ (value: double);
            protected
              procedure Paint; override;
              procedure GridMatChanged(Sender: TObject);
              procedure MouseMove (Shift: TShiftState; X,Y: integer); override;
              procedure MouseActionMove (var CenterX, CenterY: integer; var RotXAngle, RotZAngle, Magnification: double; Shift: TShiftState);
            public
              GridMat : TMatrix;                      { grid of estimated 3D points }
              constructor Create(AOwner: TComponent); override;
              destructor Destroy; override;
                                                           { various basic routines }
              procedure AutoScale;
              procedure Clear;
              procedure CopyToBMP (FName: string);
              procedure CopyToWMF (FName: string);
              procedure CopyToClipboard;
              procedure CopyToClipboardWMF;
              procedure Reset;
              procedure SetViewAngles (vax, vaz: double);
            published
              property Align;
              property Visible;
              property ShowHint;
              property PopupMenu;
              property ParentShowHint;
              property CentX: integer read FCentX write SetCentX;
              property CentY: integer read FCentY write SetCentY;
              property ColorFrame: TColor read RcFrameCol write SetFrameCol default DefFrameCol;
              property ColorBakGnd: TColor read FColorBakGnd write SetColorBakGnd;
              property ColorMesh: TColor read FColorMesh write SetColorMesh;
              property ColorHigh: TColor read FColorFillHigh write SetColorFillHigh;
              property ColorMid: TColor read FColorFillMid write SetColorFillMid;
              property ColorLow: TColor read FColorFillLow write SetColorFillLow;
              property ColorScaleHigh: double read GetColorScaleHigh write SetColorScaleHigh;
              property ColorScaleLow: double read GetColorScaleLow write SetColorScaleLow;
              property ColorCodingMode: TColorCodingMode read FColorCodingMode write SetColorCodingMode;
              property ColorScheme: TColorScheme read FColorScheme write SetColorScheme;
              property FrameStyle: TFrameStyle read FFrameStyle write SetFrameStyle;
              property MeshVisible: boolean read FMeshVisible write SetMeshVisible;
              property Magnification: double read GetMagnify write SetMagnify;
              property MouseAction: MouseActMode read FMouseAction write FMouseAction;
              property ScaleFactX: double read FSclXIntern write SetSclX;
              property ScaleFactY: double read FSclYIntern write SetSclY;
              property ScaleFactZ: double read FSclZIntern write SetSclZ;
              property ViewAngleX: double read FViewAngle[1] write SetViewAngleX;
              property ViewAngleZ: double read FViewAngle[3] write SetViewAngleZ;
              property OnMouseAction: TMouseActionEvent read FOnMouseAction write FOnMouseAction;
              property OnClick;
              property OnDblClick;
              property OnMouseMove;
              property OnMouseDown;
              property OnMouseUp;
            end;

procedure Register;


{------------------------------------------------------------------------------}
implementation
{------------------------------------------------------------------------------}


uses
  printers, ClipBrd;

const
  AngleScl    : double = 1/180.0;   { scaling of angle-mouse dependence }
  MaxMagnify  : double = 3.0;                      { max. magnification }
  MinMagnify  : double = 0.001;                    { min. magnification }

{$IFDEF SHAREWARE}
{$I sharwinc\Plot3D_CT.INC}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}

(******************************************************************************)
procedure Tplot3D.GridMatChanged(Sender: TObject);
(******************************************************************************)

begin
GridMat.MinMax (1,1,GridMat.NrOfColumns,GridMat.NrOfRows, FMinZ, FMaxZ);
end;


(******************************************************************************)
constructor TPlot3D.Create(AOwner: TComponent);
(******************************************************************************)

begin
inherited Create(AOwner);          { Inherit original constructor }
Height := DefHeight;                    { Add new initializations }
Width := defWidth;
RcFrameCol := defFrameCol;
FColorBakGnd := defBakGndCol;
FColorMesh := defMeshCol;
FColorFillHigh := defFillCol;
FColorFillMid := clBlue;
FColorFillLow := clBlack;
FColorScaleLow := 0;
FColorScaleHigh := 100;
FColorCodingMode := ccmTwoColors;
GrafBmp := TBitmap.Create;  { create the working bitmap and set its width and height }
GrafBmp.Width := Width-2;
GrafBmp.Height := Height-2;
GridMat := TMatrix.Create (1, 1);
GridMat.OnChange := GridMatChanged;
FMouseAction := maRotate;
FCentX := Width div 2;
FCentY := Height div 2;
FSclXIntern := 1.0;
FSclYIntern := 1.0;
FSclZIntern := 1.0;
FViewAngle[1] := 60;
FViewAngle[2] := 0;
FViewAngle[3] := 15;
FMagnify := 1;
FMeshVisible := true;
FOnMouseAction := nil;
CalcRotMatrix;

FFrameStyle := fsLowered;
FColorScheme := csSystem;
FColBlackLine := clBlack;      { note: FColBlackLine is alwas black at the
                                            moment --> see SetColorScheme }
FColGrayLine  := clGray;
FColWhiteLine := clWhite;
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;


(******************************************************************************)
destructor TPlot3D.Destroy;
(******************************************************************************)

begin
GrafBmp.Free;                                    { destroy the graphics bitmap }
GridMat.Free;
inherited Destroy;                               { inherit original destructor }
end;

(******************************************************************************)
procedure TPlot3D.MouseActionMove (var CenterX, CenterY: integer; var RotXAngle, RotZAngle, Magnification: double; Shift: TShiftState);
(******************************************************************************)

begin
if Assigned(FOnMouseAction) then
  begin
  FOnMouseAction (self, CenterX, CenterY, RotXAngle, RotZAngle, Magnification, Shift);
  end;
end;


(******************************************************************************)
procedure TPlot3D.MouseMove (Shift: TShiftState; X,Y: integer);
(******************************************************************************)

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
  FMagAnchor := FMagnify;
  FAngleAnchor[1] := FViewAngle[1];
  FAngleAnchor[3] := FViewAngle[3];
  end;
if FMouseAction = maRotate then
  if ssLeft in Shift then                       { rotate by mouse move }
    begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
      begin
      FViewAngle[3] := FAngleAnchor[3] + longint(360)*(MouseAnchorX-x)/Width;
      if FViewAngle[3] > 360 then
        FViewAngle[3] := FViewAngle[3]-360;
      if FViewAngle[3] < 0 then
        FViewAngle[3] := 360+FViewAngle[3];
      FViewAngle[1] := FAngleAnchor[1] + longint(360)*(MouseAnchorY-y)/Height;
      if FViewAngle[1] > 360 then
        FViewAngle[1] := FViewAngle[1]-360;
      if FViewAngle[1] < 0 then
        FViewAngle[1] := 360+FViewAngle[1];
      FViewAngle[2] := 0;
      MouseActionMove (FCentX, FCentY, FViewAngle[1], FViewAngle[3], FMagnify, Shift);
      CalcRotMatrix;
      Paint;
      end;
    end;
if FMouseAction = maRotXOnly then
  if ssLeft in Shift then                       { rotate across x axis }
    begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
      begin
      FViewAngle[1] := FAngleAnchor[1] + longint(360)*(-MouseAnchorY+y)/Height;
      FViewAngle[2] := 0;
      if FViewAngle[1] > 360 then
        FViewAngle[1] := FViewAngle[1]-360;
      if FViewAngle[1] < 0 then
        FViewAngle[1] := 360+FViewAngle[1];
      MouseActionMove (FCentX, FCentY, FViewAngle[1], FViewAngle[3], FMagnify, Shift);
      CalcRotMatrix;
      Paint;
      end;
    end;
if FMouseAction = maRotZOnly then
  if ssLeft in Shift then                       { rotate across z axis }
    begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
      begin
      FViewAngle[3] := FAngleAnchor[3] + longint(360)*(MouseAnchorX-x)/Width;
      FViewAngle[2] := 0;
      if FViewAngle[3] > 360 then
        FViewAngle[3] := FViewAngle[3]-360;
      if FViewAngle[3] < 0 then
        FViewAngle[3] := 360+FViewAngle[3];
      MouseActionMove (FCentX, FCentY, FViewAngle[1], FViewAngle[3], FMagnify, Shift);
      CalcRotMatrix;
      Paint;
      end;
    end;
if FMouseAction = maZoom then
  if ssLeft in Shift then                       { zoom by mouse move }
    begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
      begin
      RelMag := (MaxMagnify-MinMagnify)*(MouseAnchorY-y)/Height/2;
      if (RelMag+FMagAnchor) > MaxMagnify then
        RelMag := MaxMagnify-FMagAnchor;
      if (RelMag+FMagAnchor) < MinMagnify then
        RelMag := MinMagnify-FMagAnchor;
      FMagnify := FMagAnchor + RelMag;
      MouseActionMove (FCentX, FCentY, FViewAngle[1], FViewAngle[3], FMagnify, Shift);
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
      MouseActionMove (FCentX, FCentY, FViewAngle[1], FViewAngle[3], FMagnify, Shift);
      Paint;
      end;
    end;
if FMouseAction = maRotAndZoom then
  begin
  if ssLeft in Shift then                       { rotate and zoom by mouse move }
    begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
      begin
      FViewAngle[3] := FAngleAnchor[3] + longint(360)*(MouseAnchorX-x)/Width;
      if FViewAngle[3] > 360 then
        FViewAngle[3] := FViewAngle[3]-360;
      if FViewAngle[3] < 0 then
        FViewAngle[3] := 360+FViewAngle[3];
      FViewAngle[1] := FAngleAnchor[1] + longint(360)*(MouseAnchorY-y)/Height;
      if FViewAngle[1] > 360 then
        FViewAngle[1] := FViewAngle[1]-360;
      if FViewAngle[1] < 0 then
        FViewAngle[1] := 360+FViewAngle[1];
      FViewAngle[2] := 0;
      MouseActionMove (FCentX, FCentY, FViewAngle[1], FViewAngle[3], FMagnify, Shift);
      CalcRotMatrix;
      Paint;
      end;
    end;
  if ssRight in Shift then                       { zoom by mouse move }
    begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
      begin
      RelMag := (MaxMagnify-MinMagnify)*(MouseAnchorY-y)/Height/2;
      if (RelMag+FMagAnchor) > MaxMagnify then
        RelMag := MaxMagnify-FMagAnchor;
      if (RelMag+FMagAnchor) < MinMagnify then
        RelMag := MinMagnify-FMagAnchor;
      FMagnify := FMagAnchor + RelMag;
      MouseActionMove (FCentX, FCentY, FViewAngle[1], FViewAngle[3], FMagnify, Shift);
      Paint;
      end;
    end;
  end;
end;


(******************************************************************************)
procedure TPlot3D.CalcRotMatrix;
(******************************************************************************)

{
successive rotation around z and x axis (in this order; s=sin, c=cos):

              | 1      0     0     |
              |                    |
              | 0      cx     sx   |
              |                    |
              | 0      -sx    cx   |
--------------+--------------------+
cz   sz   0   | cz    sz*cx  sx*sz |
              |                    |
              |                    |
-sz  cz   0   | -sz   cz*cx  cz*sx |
              |                    |
              |                    |
0    0    1   | 0      -sx     cx  |
              |                    |
}

begin
RotMat[1,1] := round(500*cos(AngleScl*Pi*FViewAngle[3]));
RotMat[1,2] := round(500*(-sin(AngleScl*Pi*FViewAngle[3])));
RotMat[1,3] := 0;
RotMat[2,1] := round(500*(cos(AngleScl*Pi*FViewAngle[1]))*
                          sin(AngleScl*Pi*FViewAngle[3]));
RotMat[2,2] := round(500*(cos(AngleScl*Pi*FViewAngle[3])*
                          cos(AngleScl*Pi*FViewAngle[1])));
RotMat[2,3] := round(500*(-sin(AngleScl*Pi*FViewAngle[1])));
RotMat[3,1] := round(500* sin(AngleScl*Pi*FViewAngle[1])*
                          sin(AngleScl*Pi*FViewAngle[3]));
RotMat[3,2] := round(500* sin(AngleScl*Pi*FViewAngle[1])*
                          cos(AngleScl*Pi*FViewAngle[3]));
RotMat[3,3] := round(500* cos(AngleScl*Pi*FViewAngle[1]));
end;


(******************************************************************************)
procedure TPlot3D.SetViewAngles (vax, vaz: double);
(******************************************************************************)

begin
if (vax <> FViewAngle[1]) or (vaz <> FViewAngle[3]) then
  begin
  if (vax > 360) then
    vax := 360*frac(vax/360);
  if (vax < 0) then
    vax := 360*frac(vax/360) + 360;
  FViewAngle[1] := vax;
  if (vaz > 360) then
    vaz := 360*frac(vaz/360);
  if (vaz < 0) then
    vaz := 360*frac(vaz/360) + 360;
  FViewAngle[3] := vaz;
  CalcRotMatrix;
  Paint;
  end;
end;


(******************************************************************************)
procedure TPlot3D.SetViewAngleX (value: double);
(******************************************************************************)

begin
if Value <> FViewAngle[1] then
  begin
  if (Value > 360) then
    value := 360*frac(value/360);
  if (value < 0) then
    value := 360*frac(value/360) + 360;
  FViewAngle[1] := Value;
  CalcRotMatrix;
  Paint;
  end;
end;


(******************************************************************************)
procedure TPlot3D.SetViewAngleZ (value: double);
(******************************************************************************)

begin
if Value <> FViewAngle[3] then
  begin
  if (Value > 360) then
    value := 360*frac(value/360);
  if (value < 0) then
    value := 360*frac(value/360) + 360;
  FViewAngle[3] := Value;
  CalcRotMatrix;
  Paint;
  end;
end;


(******************************************************************************)
procedure TPlot3D.SetCentX (value: integer);
(******************************************************************************)

begin
if Value <> FCentX then
  begin
  if Value < -Width then
    Value := -Width;
  if Value > 2*Width then
    Value := 2*Width ;
  FCentX := Value;
  Paint;
  end;
end;

(******************************************************************************)
procedure TPlot3D.SetCentY (value: integer);
(******************************************************************************)

begin
if Value <> FCentY then
  begin
  if Value < -Height then
    Value := -Height;
  if Value > 2*Height then
    Value := 2*Height;
  FCentY := Value;
  Paint;
  end;
end;


(******************************************************************************)
procedure TPlot3D.Paint;
(******************************************************************************)

begin
if Visible then
  begin
  InitGraf (GrafBmp.Canvas);
  if not (csDesigning in ComponentState) then
    ConstructDataBmp (GrafBmp.Canvas, false);                                  { create data image }
  ConstructFrame (GrafBmp.Canvas);
  Canvas.Draw(0, 0, GrafBmp);      { copy the working bitmap to the main canvas }
  {$IFDEF SHAREWARE}
  Hint := GetHintStr;
  ShowHint := True;
  {$ENDIF}
  end;
end;


(******************************************************************************)
procedure TPlot3D.ConstructFrame (cv: TCanvas);
(******************************************************************************
ENTRY:  none (only system parameters)

EXIT:   The selected frame is displayed
*******************************************************************************)


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

(******************************************************************************)
procedure TPlot3D.InitGraf (cv: TCanvas);
(******************************************************************************
ENTRY:  none (only system parameters)

EXIT:   The graphics bitmap is cleared and set up with the
        appropriate colors. The linked list of the graphics
        elements is not changed.
***********************^*******************************************************)

var
  Brightness : double;

begin
GrafBmp.Width := Width;
GrafBmp.Height := Height;
cv.Pen.Style := psSolid;
cv.Pen.Mode := pmCopy;
if (csDesigning in ComponentState)
  then begin
       cv.Brush.Color := FColorBakGnd;
       cv.Pen.Color := FColorBakGnd;
       cv.Rectangle (0,0,GrafBmp.Width,GrafBmp.Height);
       brightness := sqr(1.0*GetGValue(FColorBakGnd))+
                     sqr(1.0*GetRValue(FColorBakGnd))+
                     sqr(1.0*GetBValue(FColorBakGnd));
       if BrightNess > 50000
         then cv.Font.Color := clBlack
         else cv.Font.Color := clWhite;
       cv.TextOut (10,10,'Plot3D');
       end
  else begin
       cv.Brush.Color := FColorBakGnd;
       cv.Pen.Color := FColorBakGnd;
       cv.Rectangle (0,0,GrafBmp.Width,GrafBmp.Height);
       end;
end;

(******************************************************************************)
procedure PrintBitmap(Bitmap: TBitmap; X, Y: integer);
(******************************************************************************
 The Draw method on the printer canvas does not work properly.
 Borland suggests to use some Windows API calls instead (see file
 MANUALS.TXT somewhere on the Delphi-CD). The procedure PrintBitmap
 is based on this suggestion, but improved as far as the memory
 allocation is concerned.

 ENTRY: BitMap ..... arbitrary TBitmap
        X,Y ........ location where to copy to

 EXIT:  BitMap is copied to the printer canvas
 ******************************************************************************)

var
  Info      : PBitmapInfo;
  InfoSize  : dword;
  Image     : Pointer;
  hImage    : THandle;
{$IFDEF VER80}
  ImageSize : longint;
{$ELSE}
  ImageSize : dword;
{$ENDIF}

begin
with Bitmap do
  begin
  GetDIBSizes (Handle, InfoSize, ImageSize);
  GetMem (Info, InfoSize);
    try
    hImage := GlobalAlloc(GMEM_FIXED, ImageSize);
    Image := GlobalLock (hImage);
      try
      GetDIB(Handle, Palette, Info^, Image^);
      with Info^.bmiHeader do
        StretchDIBits(Printer.Canvas.Handle, X, Y, Width,
            Height, 0, 0, biWidth, biHeight, Image, Info^,
            DIB_RGB_COLORS, SRCCOPY);
      finally
      GlobalUnLock (hImage);
      GlobalFree (hImage);
      end;
    finally
    FreeMem(Info, InfoSize);
    end;
  end;
end;


(******************************************************************************)
function TPlot3D.CalcColorCoding (value: double): TColor;
(******************************************************************************)

var
  BlueLow  : integer;
  BlueHigh : integer;
  RedLow   : integer;
  RedHigh  : integer;
  GreenLow : integer;
  GreenHigh: integer;

begin
if value < FColorScaleLow then
  value := FColorScaleLow;
if value > FColorScaleHigh then
  value := FColorScaleHigh;
value := (value-FColorScaleLow)/(FColorScaleHigh-FColorScaleLow);
case FColorCodingMode of
    ccmTwoColors: begin
                  blueLow := (FColorFillLow shr 16) and $FF;
                  GreenLow := (FColorFillLow shr 8) and $FF;
                  RedLow := FColorFillLow and $000000FF;
                  blueHigh := (FColorFillHigh shr 16) and $FF;
                  GreenHigh := (FColorFillHigh shr 8) and $FF;
                  RedHigh := FColorFillHigh and $FF;
                  value := value/2;
                  end;
  ccmThreeColors: begin
                  if value < 0.5
                    then begin
                         blueLow := (FColorFillLow shr 16) and $FF;
                         blueHigh := (FColorFillMid shr 16) and $FF;
                         GreenLow := (FColorFillLow shr 8) and $FF;
                         GreenHigh := (FColorFillMid shr 8) and $FF;
                         RedLow := FColorFillLow and $000000FF;
                         RedHigh := FColorFillMid and $000000FF;
                         end
                    else begin
                         value := value-0.5;
                         blueLow := (FColorFillMid shr 16) and $FF;
                         blueHigh := (FColorFillHigh shr 16) and $FF;
                         GreenLow := (FColorFillMid shr 8) and $FF;
                         GreenHigh := (FColorFillHigh shr 8) and $FF;
                         RedLow := FColorFillMid and $FF;
                         RedHigh := FColorFillHigh and $FF;
                         end;
                  end;
             else begin
                  blueLow := (FColorFillLow shr 16) and $FF;
                  GreenLow := (FColorFillLow shr 8) and $FF;
                  RedLow := FColorFillLow and $000000FF;
                  blueHigh := (FColorFillHigh shr 16) and $FF;
                  GreenHigh := (FColorFillHigh shr 8) and $FF;
                  RedHigh := FColorFillHigh and $FF;
                  value := value/2;
                  end;
end;
CalcColorCoding := rgb (round(RedLow+2*value*(RedHigh-RedLow)),
                        round(GreenLow+2*value*(GreenHigh-GreenLow)),
                        round(BlueLow+2*value*(BlueHigh-BlueLow)));
end;


(******************************************************************************)
procedure TPlot3D.ConstructDataBmp (cv: TCanvas; BlkWhite: boolean);
(******************************************************************************
  This routine creates the bitmap image of the data area; The data
  colors are automatically set to black, if BlkWhite is TRUE.
 ******************************************************************************)

const
  AXZLeng = 20;
  AxYLeng = 40;
  AxXLeng = 40;

var
  i, j    : integer;
  quad    : array[1..4] of TPoint;
  xx,yy   : longint;
  ii,jj   : integer;
  ix,iy   : integer;
  MaxZ    : double;
  xup     : boolean;
  yup     : boolean;
  MagFact : double;
  ColVal  : TColor;
{$IFDEF SHAREWARE}
  astr       : string;
{$ENDIF}

//  Xpos, YPos, ZPos : integer;

begin
i := GridMat.NrOfColumns;     // scale the surface image
if GridMat.NrOfRows > i then
  i := GridMat.NrOfRows;
MagFact := FMagnify/i;

(*
// draw axes
cv.Pen.Color := FColorMesh;
YPos := 0;
XPos := 0;
ZPos := -10;
quad[1].x := round((FSclXIntern*Xpos*RotMat[1,1] + FSclYIntern*YPos*RotMat[1,2] + FSclZIntern*ZPos*RotMat[1,3]) * MagFact + FCentX);
quad[1].y := round((FSclXIntern*XPos*RotMat[2,1] + FSclYIntern*YPos*RotMat[2,2] + FSclZIntern*ZPos*RotMat[2,3]) * MagFact + FCentY);
xx := round((FSclXIntern*Xpos*RotMat[1,1] + FSclYIntern*YPos*RotMat[1,2] + FSclZIntern*(ZPos+AxZLeng)*RotMat[1,3]) * MagFact + FCentX);
yy := round((FSclXIntern*XPos*RotMat[2,1] + FSclYIntern*YPos*RotMat[2,2] + FSclZIntern*(ZPos+AxZLeng)*RotMat[2,3]) * MagFact + FCentY);
cv.MoveTo (quad[1].x, quad[1].y);
cv.LineTo (xx,yy);
xx := round((FSclXIntern*Xpos*RotMat[1,1] + FSclYIntern*(Ypos+AxYLeng)*RotMat[1,2] + FSclZIntern*(ZPos)*RotMat[1,3]) * MagFact + FCentX);
yy := round((FSclXIntern*XPos*RotMat[2,1] + FSclYIntern*(YPos+AxYLeng)*RotMat[2,2] + FSclZIntern*(ZPos)*RotMat[2,3]) * MagFact + FCentY);
cv.MoveTo (quad[1].x, quad[1].y);
cv.LineTo (xx,yy);
xx := round((FSclXIntern*(XPos+AxXLeng)*RotMat[1,1] + FSclYIntern*YPos*RotMat[1,2] + FSclZIntern*(ZPos)*RotMat[1,3]) * MagFact + FCentX);
yy := round((FSclXIntern*(XPos+AxXLeng)*RotMat[2,1] + FSclYIntern*YPos*RotMat[2,2] + FSclZIntern*(ZPos)*RotMat[2,3]) * MagFact + FCentY);
cv.MoveTo (quad[1].x, quad[1].y);
cv.LineTo (xx,yy);
*)

//draw surface
cv.Brush.color := FColorFillHigh;
cv.Pen.Color := FColorMesh;
yup := ((FViewAngle[1] > 180) xor ((FViewAngle[3] < 90) or (FViewAngle[3] > 270)));
xup := not ((FViewAngle[1] > 180) xor (FViewAngle[3] > 180));
for i:=1 to GridMat.NrOfRows-1 do
  begin
  if yup
      then iy := i
      else iy := GridMat.NrOfRows-i;
  jj := iy-(GridMat.NrOfRows div 2);
  for j:=1 to GridMat.NrOfColumns-1 do
    begin
    if xup
      then ix := j
      else ix := GridMat.NrOfColumns-j;
    ii := ix-(GridMat.NrOfColumns div 2);
    xx := round((FSclXIntern*ii*RotMat[1,1] + FSclYIntern*jj*RotMat[1,2] + FSclZIntern*GridMat.Elem[ix,iy]*RotMat[1,3]) * MagFact + FCentX);
    yy := round((FSclXIntern*ii*RotMat[2,1] + FSclYIntern*jj*RotMat[2,2] + FSclZIntern*GridMat.Elem[ix,iy]*RotMat[2,3]) * MagFact + FCentY);
    MaxZ := GridMat.Elem[ix,iy];
    quad[1].x := xx;   quad[1].y := yy;
    xx := round((FSclXIntern*(ii+1)*RotMat[1,1] + FSclYIntern*jj*RotMat[1,2] + FSclZIntern*GridMat.Elem[ix+1,iy]*RotMat[1,3]) * MagFact + FCentX);
    yy := round((FSclXIntern*(ii+1)*RotMat[2,1] + FSclYIntern*jj*RotMat[2,2] + FSclZIntern*GridMat.Elem[ix+1,iy]*RotMat[2,3]) * MagFact + FCentY);
    if GridMat.Elem[ix+1,iy] > MaxZ
      then MaxZ := GridMat.Elem[ix+1,iy];
    quad[2].x := xx;   quad[2].y := yy;
    xx := round((FSclXIntern*(ii+1)*RotMat[1,1] + FSclYIntern*(jj+1)*RotMat[1,2] + FSclZIntern*GridMat.Elem[ix+1,iy+1]*RotMat[1,3]) * MagFact + FCentX);
    yy := round((FSclXIntern*(ii+1)*RotMat[2,1] + FSclYIntern*(jj+1)*RotMat[2,2] + FSclZIntern*GridMat.Elem[ix+1,iy+1]*RotMat[2,3]) * MagFact + FCentY);
    if GridMat.Elem[ix+1,iy+1] > MaxZ
      then MaxZ := GridMat.Elem[ix+1,iy+1];
    quad[3].x := xx;   quad[3].y := yy;
    xx := round((FSclXIntern*ii*RotMat[1,1] + FSclYIntern*(jj+1)*RotMat[1,2] + FSclZIntern*GridMat.Elem[ix,iy+1]*RotMat[1,3]) * MagFact + FCentX);
    yy := round((FSclXIntern*ii*RotMat[2,1] + FSclYIntern*(jj+1)*RotMat[2,2] + FSclZIntern*GridMat.Elem[ix,iy+1]*RotMat[2,3]) * MagFact + FCentY);
    if GridMat.Elem[ix,iy+1] > MaxZ
      then MaxZ := GridMat.Elem[ix,iy+1];
    quad[4].x := xx;   quad[4].y := yy;
    Colval := CalcColorCoding (MaxZ);
    cv.Brush.color := ColVal;
    if not FMeshVisible then
      cv.Pen.Color := ColVal;
    cv.Polygon (quad);
    end;
  end;

{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  cv.Font.Color := clWhite;
  cv.Font.Name := 'MS Sans Serif';
  cv.Brush.Color := clNavy;
  cv.Brush.Style := bsSolid;
  cv.Font.Size := 8;
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

(******************************************************************************)
procedure TPlot3D.CopyToClipboard;
(******************************************************************************)

begin
InitGraf (GrafBmp.Canvas);
ConstructDataBmp (GrafBmp.Canvas, false);     { create data image }
ConstructFrame (GrafBmp.Canvas);
Clipboard.Assign (GrafBmp);
end;


(******************************************************************************)
procedure TPlot3D.CopyToBMP (FName: string);
(******************************************************************************
  ENTRY:   FName ..... name of bitmap file to be created
  EXIT:    bit map file contains BMP copy of Plot3D
 ******************************************************************************)

var
  astr1, astr2  : string;
  i             : integer;

begin
InitGraf (GrafBmp.Canvas);
ConstructDataBmp (GrafBmp.Canvas, false);                      { create data image }
ConstructFrame (GrafBmp.Canvas);
astr1 := ExtractFilepath(FName);             { force BMP extension }
astr2 := ExtractFileName(Fname);
i := pos ('.', astr2);
if i > 0 then
  delete (astr2,i,255);
GrafBmp.SaveToFile (astr1+astr2+'.bmp');
end;


(******************************************************************************)
procedure TPlot3D.CopyToWMF (FName: string);
(******************************************************************************
  ENTRY:   FName ..... name of metafile file to be created
  EXIT:    file contains metafile copy of Plot3D
 ******************************************************************************)

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
WMFCanvas.Handle := CreateEnhMetafile(0, NIL, @Rect, NIL);
InitGraf (WMFCanvas);
ConstructDataBmp (WMFCanvas, false);         { create data image }
ConstructFrame (WMFCanvas);
astr1 := ExtractFilepath(FName);             { force WMF extension }
astr2 := ExtractFileName(Fname);
i := pos ('.', astr2);
if i > 0 then
  delete (astr2,i,255);
AuxWMF := TMetaFile.Create;
AuxWMF.Handle := closeEnhMetafile(WMFCanvas.handle);
AuxWMF.SaveToFile(astr1+astr2+'.wmf');
AuxWMF.Free;
end;


(******************************************************************************)
procedure TPlot3D.CopyToClipboardWMF;
(******************************************************************************)

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
WMFCanvas.Handle := CreateEnhMetafile(0, NIL, @Rect, NIL);
InitGraf (WMFCanvas);                      { create data image }
ConstructDataBmp (WMFCanvas, false);
ConstructFrame (WMFCanvas);
AuxWMF := TMetaFile.Create;
AuxWMF.Inch := Screen.PixelsPerInch;
AuxWMF.Handle := closeEnhMetafile(WMFCanvas.handle);
Clipboard.Assign (AuxWMF);
AuxWMF.Free;
end;

(******************************************************************************)
procedure TPlot3D.SetMagnify (mag: double);
(******************************************************************************)

begin
if mag < MinMagnify then
  mag := MinMagnify;
if mag > MaxMagnify then
  mag := MaxMagnify;
FMagnify := mag;
Paint;
end;

(******************************************************************************)
procedure TPlot3D.SetSclX (fact: double);
(******************************************************************************)

begin
FSclXIntern := fact;
Paint;
end;

(******************************************************************************)
procedure TPlot3D.SetSclY (fact: double);
(******************************************************************************)

begin
FSclYIntern := fact;
Paint;
end;


(******************************************************************************)
procedure TPlot3D.SetSclZ (fact: double);
(******************************************************************************)

begin
FSclZIntern := fact;
Paint;
end;


(******************************************************************************)
function TPlot3D.GetMagnify: double;
(******************************************************************************)

begin
GetMagnify := FMagnify;
end;

(******************************************************************************)
procedure TPlot3D.SetColorScaleHigh (Level: double);
(******************************************************************************)

begin
if Level > FColorScaleLow then
  begin
  FColorScaleHigh := Level;
  Paint;
  end;
end;

(******************************************************************************)
function TPlot3D.GetColorScaleHigh: double;
(******************************************************************************)

begin
GetColorScaleHigh := FColorScaleHigh;
end;

(******************************************************************************)
procedure TPlot3D.SetColorScaleLow (Level: double);
(******************************************************************************)

begin
if Level < FColorScaleHigh then
  begin
  FColorScaleLow := Level;
  Paint;
  end;
end;

(******************************************************************************)
function TPlot3D.GetColorScaleLow: double;
(******************************************************************************)

begin
GetColorScaleLow := FColorScaleLow;
end;



(******************************************************************************)
procedure TPlot3D.AutoScale;
(******************************************************************************)

var
  Maxi : double;

begin
Maxi := GridMat.NrOfColumns;
if Maxi < GridMat.NrOfRows then
  Maxi := GridMat.NrOfRows;
FSclXIntern := Maxi/GridMat.NrOfColumns;
FSclYIntern := Maxi/GridMat.NrOfRows;
if FMaxZ <> FMinZ
  then FSclZIntern := Maxi/(FMaxZ - FMinZ)
  else FSclZIntern := 1.0;
Paint;
end;


(******************************************************************************)
procedure TPlot3D.SetMeshVisible (meshvis: boolean);
(******************************************************************************)

begin
if FMeshVisible <> meshvis then
  begin
  FMeshVisible := meshvis;
  Paint;
  end;
end;


(******************************************************************************)
procedure TPlot3D.SetFrameCol (c: TColor);
(******************************************************************************)

begin
RCFrameCol := c;
Paint;
end;

(******************************************************************************)
procedure TPlot3D.SetColorBakGnd (c: TColor);
(******************************************************************************)

begin
FColorBakGnd := c;
Paint;
end;

(******************************************************************************)
procedure TPlot3D.SetColorFillHigh (c: TColor);
(******************************************************************************)

begin
FColorFillHigh := c;
Paint;
end;

(******************************************************************************)
procedure TPlot3D.SetColorFillLow (c: TColor);
(******************************************************************************)

begin
FColorFillLow := c;
Paint;
end;

(******************************************************************************)
procedure TPlot3D.SetColorFillMid (c: TColor);
(******************************************************************************)

begin
FColorFillMid := c;
Paint;
end;


(******************************************************************************)
procedure TPlot3D.SetColorMesh (c: TColor);
(******************************************************************************)

begin
FColorMesh := c;
Paint;
end;


(******************************************************************************)
procedure TPlot3D.SetColorScheme (Value: TColorScheme);
(******************************************************************************)

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

(******************************************************************************)
procedure TPlot3D.SetColorCodingMode (Value: TColorCodingMode);
(******************************************************************************)

begin
if Value <> FColorCodingMode then
  begin
  FColorCodingMode := Value;
  Paint;
  end;
end;



(******************************************************************************)
procedure TPlot3D.Clear;
(******************************************************************************)

begin
GridMat.Fill (0);
Paint;
end;

(******************************************************************************)
procedure TPlot3D.Reset;
(******************************************************************************)

begin
FCentX := Width div 2;
FCentY := Height div 2;
FSclXIntern := 1.0;
FSclYIntern := 1.0;
FSclZIntern := 1.0;
FViewAngle[1] := 66;
FViewAngle[2] := 0;
FViewAngle[3] := 135;
FMagnify := 1;
CalcRotMatrix;
Paint;
end;


(******************************************************************************)
procedure TPlot3D.SetFrameStyle (value: TFrameStyle);
(******************************************************************************)

begin
if Value <> FFrameStyle then
  begin
  FFrameStyle := Value;
  Paint;
  end;
end;

(******************************************************************************)
procedure Register;
(******************************************************************************)

begin
RegisterComponents ('SDL', [TPlot3D]);
end;


end.




