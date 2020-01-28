unit Meter;

(******************************************************************)
(*                                                                *)
(*                            M E T E R                           *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1997..2001 H. Lohninger               September 1999   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jul-03, 2001                                  *)
(*                                                                *)
(******************************************************************)

{Revision History:

1.0   [May-16, 1997]
      Release of first version

1.6   [Apr-07, 1998]
      METER now available for C++Builder version 3.0
      Bug fixed: FNeedleLayout has not been freed on destroy - this caused
        memory leaks which may crash the application if TMeter is created
        and destroyed several (100) times.
      correction: TColorScheme = (csBWG, csSystem); (not csSytem anymore)

1.7   [Aug-17, 1998]
      METER is now available for Delphi 4.0

1.8   [Mar-27, 1999]
      METER is now available for C++Builder 4.0
      additonal layouts implemented (mlCirc270, mlCirc300, mlCirc360)
      positioning of labels improved
      colored scale background implemented (properties ColorSclBkLow,
          ColorSclBkNorm, and ColorSclBkHigh, ThresholdLow, ThresholdHigh,
          ScaleBkWidth, ScaleBkVisible)
      Overflow and Underflow indicators are now switched when ThresholdLow
          or ThresholdHigh is crossed
      FontCaption implemented
      OnUnderFlow, OnOverFlow, OnNormalRange events implemented

5.0   [Sep-28, 1999]
      METER is now available for Delphi 5.0

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      bug fix: TMeter has no memory leak anymore
      ColorCover is now clBtnFace by default
}


{$O+}
{$F+}

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

{------------------------------------------------------------------------------}
interface
{------------------------------------------------------------------------------}


uses
  SysUtils, WinTypes, WinProcs, Messages, Classes,
  Graphics, Controls, Forms, ExtCtrls;


const
  defWidth = 10.0;

type
  TMeterLayout = (mlCirc90, mlCirc120, mlCirc180,
                  mlCirc270, mlCirc300, mlCirc360);  { meter layout }
  TFrameStyle = (fsNone, fsSimple, fsLowered, fsRaised, fsEmbossed, fsEngraved);
  TColorScheme = (csBWG, csSystem);
  TLabelStr = string[10];

  TNeedleLayout = class (TPersistent)       { parameters of needle layout }
           private
             FAnchorCovrd  : boolean;             { True: anchor visible }
             FColorFill    : TColor;                    { color of arrow }
             FColorLine    : TColor;              { color of arrow frame }
             FSize1        : integer;               { size of arrow head }
             FSizeAnchor   : integer;            { size of needle anchor }
             FThickness    : integer;         { thickness of arrow shaft }
             FAngle1       : integer;              { angle of arrow head }
             FBackShift1   : integer;      { flatness of arrow head base }
             FShadowDx     : integer;               { x-shift for shadow }
             FShadowDy     : integer;               { y-shift for shadow }
             FShadowColor  : TColor;                   { color of shadow }
             FOnChange     : TNotifyEvent;
             procedure SetAnchorCovrd (Value: boolean);
             procedure SetArrowSize1 (Value: integer);
             procedure SetArrowSizeAnchor (Value: integer);
             procedure SetBackShift1 (Value: integer);
             procedure SetArrowThick (Value: integer);
             procedure SetArrowAngle1 (Value: integer);
             procedure SetColorFill (Value: TColor);
             procedure SetColorLine (Value: TColor);
             procedure SetShadowDx (Value: integer);
             procedure SetShadowDy (Value: integer);
             procedure SetShadowColor (Value: TColor);
           protected
           public
             procedure   Changed;
           published
             property HeadSize: integer read FSize1 write SetArrowSize1;
             property HeadAngle: integer read FAngle1 write SetArrowAngle1;
             property HeadMidLeng: integer read FBackShift1 write SetBackShift1;
             property AnchorSize: integer read FSizeAnchor write SetArrowSizeAnchor;
             property AnchorCovered: boolean read FAnchorCovrd write SetAnchorCovrd;
             property Thickness: integer read FThickness write SetArrowThick;
             property ColorBody: TColor read FColorFill write SetColorFill;
             property ColorOutline: TColor read FColorLine write SetColorLine;
             property ShadowDx: integer read FShadowDx write SetShadowDx;
             property ShadowDy: integer read FShadowDy write SetShadowDy;
             property ShadowColor: TColor read FShadowColor write SetShadowColor;
             property OnChange: TNotifyEvent read FOnChange write FOnChange;
           end;


  TMeter = class (TGraphicControl)
           private
             FLimWatHighOn : boolean;    { TRUE: overflow limit watch on }
             FLimWatLowOn  : boolean;     { TRUE: underflow indicator on }
             FLimWatActCol : TColor;       { active color of limit watch }
             FLimWatPsvCol : TColor;      { passive color of limit watch }
             FOFL          : boolean;           { TRUE: overflow occured }
             FUFL          : boolean;          { TRUE: underflow occured }
             FColorScale   : TColor;                    { color of scale }
             FCaption      : TLabelStr;                        { unit ID }
             FFrameStyle   : TFrameStyle;               { style of frame }
             FDecPlaces    : integer;            { nr. of decimal places }
             FNrTicks      : integer;            { number of scale ticks }
             FBRim         : integer;                       { bottom rim }
             FSRim         : integer;                         { side rim }
             FTRim         : integer;                          { top rim }
             FShortTicks   : boolean;      { TRUE: short ticks are drawn }
             FScaleLine    : boolean;        { TRUE: scale line is drawn }
             FColorBakG    : TColor;         { color of meter background }
             FColorCover   : TColor;              { color of cover metal }
             FColBlackLine : TColor;          { colors to draw the frame }
             FColGrayLine  : TColor;                       { -"- }
             FColWhiteLine : TColor;                       { -"- }
             FColorScheme  : TColorScheme;      { color scheme of frames }
             FColorBakGLow : TColor;    { scale background, "low" region }
             FColorBakGNorm: TColor; { scale background, "normal" region }
             FColorBakGHigh: TColor;   { scale background, "high" region }
             FFontCaption  : TFont;                    { font of caption }
             FScaleBakWidth: double;    { width of scale background ring }
             FScaleBkVis   : boolean; { colored scale background visible }
             FLowThreshold : double;      { upper border of "low" region }
             FHighThreshold: double;     { lower border of "high" region }
             FNeedleLayout : TNeedleLayout;    { layout params of needle }
             FMeterLayout  : TMeterLayout;             { layout of meter }
             FValue        : double;             { value of meter needle }
             FMinValue     : double;            { minimum value of meter }
             FMaxValue     : double;            { maximum value of meter }
             FOnOverFlow   : TNotifyEvent;
             FOnUnderFlow  : TNotifyEvent;
             FOnNormalRange: TNotifyEvent;
             procedure SetColorScale (Value: TColor);
             procedure SetColorBakG (Value: TColor);
             procedure SetColorCover (Value: TColor);
             procedure SetColorScheme (Value: TColorScheme);
             procedure SetColorBakgLow (Value: TColor);
             procedure SetColorBakgNorm (Value: TColor);
             procedure SetColorBakgHigh (Value: TColor);
             procedure SetFrameStyle (value: TFrameStyle);
             procedure SetDecPlaces (Value: integer);
             procedure SetNrTicks (Value: integer);
             procedure SetBRim (Value: integer);
             procedure SetTRim (Value: integer);
             procedure SetSRim (Value: integer);
             procedure SetValue (Value: double);
             procedure SetFontCaption (Value: TFont);
             procedure SetMeterLayout (Value: TMeterLayout);
             procedure SetMinValue (Value: double);
             procedure SetMaxValue (Value: double);
             procedure SetLowThreshold (Value: double);
             procedure SetHighThreshold (Value: double);
             procedure SetLimWatHighOn (Value: boolean);
             procedure SetLimWatLowOn (Value: boolean);
             procedure SetLimWatActCol (Value: TColor);
             procedure SetLimWatPsvCol (Value: TColor);
             procedure SetNeedleLayout (x: TNeedleLayout);
             procedure SetShortTicks (Value: boolean);
             procedure SetScaleLine (Value: boolean);
             procedure SetScaleBkWidth (Value: double);
             procedure SetScaleBkVis (Value: boolean);
             procedure SetUnitLabel (astr: TLabelStr);
             function  CalcM (DecPlaces: integer; lo, hi: double):integer;
           protected
             procedure Paint; override;
             procedure StyleChanged (Sender: TObject);
             procedure Loaded; override;
             procedure DoOverFlowEvent;
             procedure DoUnderFlowEvent;
             procedure DoNormalRangeEvent;
           public
             constructor Create(AOwner: TComponent); override;
             destructor  Destroy; override;
           published
             property Align;
             property Caption: TLabelStr read FCaption write SetUnitLabel;
             property ColorBakG: TColor read FColorBakG write SetColorBakG;
             property ColorCover: TColor read FColorCover write SetColorCover;
             property ColorScale: TColor read FColorScale write SetColorScale;
             property ColorScheme: TColorScheme read FColorScheme write SetColorScheme;
             property ColorSclBkLow: TColor read FColorBakGLow write SetColorBakGLow;
             property ColorSclBkNorm: TColor read FColorBakGNorm write SetColorBakGNorm;
             property ColorSclBkHigh: TColor read FColorBakGHigh write SetColorBakGHigh;
             property Font;
             property FontCaption: TFont read FFontCaption write SetFontCaption;
             property FrameStyle: TFrameStyle read FFrameStyle write SetFrameStyle;
             property Hint;
             property LimWatchHighOn: boolean read FLimWatHighOn write SetLimWatHighOn;
             property LimWatchLowOn: boolean read FLimWatLowOn write SetLimWatLowOn;
             property LimWatchActColor: TColor read FLimWatActCol write SetLimWatActCol;
             property LimWatchPsvColor: TColor read FLimWatPsvCol write SetLimWatPsvCol;
             property ThresholdLow: double read FLowThreshold write SetLowThreshold;
             property ThresholdHigh: double read FHighThreshold write SetHighThreshold;
             property MeterMinValue: double read FMinValue write SetMinValue;
             property MeterMaxValue: double read FMaxValue write SetMaxValue;
             property MeterDecPlaces: integer read FDecPlaces write SetDecPlaces;
             property MeterNrTicks: integer read FNrTicks write SetNrTicks;
             property MeterLayout: TMeterLayout read FMeterLayout write SetMeterLayout;
             property MeterShortTicks: boolean read FShortTicks write SetShortTicks;
             property MeterScaleLine: boolean read FScaleLine write SetScaleLine;
             property NeedleLayout: TNeedleLayout read FNeedleLayout write SetNeedleLayout;
             property ParentFont;
             property ParentShowHint;
             property RimBottom: integer read FBRim write SetBrim;
             property RimTop: integer read FTRim write SetTRim;
             property RimSide: integer read FSRim write SetSRim;
             property ScaleBkWidth: double read FScaleBakWidth write SetScaleBkWidth;
             property ScaleBkVisible: boolean read FScaleBkVis write SetScaleBkVis;
             property ShowHint;
             property Value: double read FValue write SetValue;
             property Visible;
             property OnClick;
             property OnDblClick;
             property OnMouseMove;
             property OnMouseDown;
             property OnMouseUp;
             property OnUnderFlow: TNotifyEvent read FOnUnderFlow write FOnUnderFlow;
             property OnOverFlow: TNotifyEvent read FOnOverFlow write FOnOverFlow;
             property OnNormalRange: TNotifyEvent read FOnNormalRange write FOnNormalRange;
           end;


procedure Register;


{-----------------------------------------------------------------------}
implementation
{-----------------------------------------------------------------------}

{$IFDEF SHAREWARE}
{$I sharwinc\meter_ct.inc}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}


type
{$IFDEF VER90}
  ShortStr = ShortString;
{$ELSE}
  ShortStr = string;
{$ENDIF}

{$I calcscp.inc}
{$I strff.inc}



(***********************************************************************)
constructor TMeter.Create(AOwner: TComponent);
(***********************************************************************)

begin
inherited Create (AOwner);
Width := 297;
Height := 209;
FOnUnderFlow := nil;
FOnOverFlow := nil;
FOnNormalRange := nil;
FShortTicks := true;
FScaleLine := true;
FLimWatHighOn := true;
FOFL := false;
FLimWatLowOn := true;
FUFL := false;
FColorScale := clNavy;
FMeterLayout := mlCirc90;
FFrameStyle := fsRaised;
FLimWatPsvCol := clGray;
FLimWatActCol := clRed;
FColorBakG := clWhite;
FColorCover := clBtnFace;
FColorScheme := csBWG;
FColorBakGLow := clLime;
FColorBakGNorm:= $000080FF;
FColorBakGHigh:= clRed;
FLowThreshold := 0;
FHighThreshold := 1;
FScaleBakWidth := 0;
FScaleBkVis := false;
FNrTicks := 3;
FColBlackLine := clBlack;      { note: FColBlackLine is alwas black at the
                                            moment --> see SetColorScheme }
FNeedleLayout := TNeedleLayout.Create;
with FNeedleLayout do
  begin
  FColorLine := clBlack;
  FColorFill := clSilver;
  FShadowColor := clGray;
  FAnchorCovrd := true;
  FSize1 := 20;
  FSizeAnchor := 24;
  FBackShift1 := 20;
  FThickNess := 0;
  FAngle1 := 30;
  FShadowDx := 0;
  FShadowDy := 0;
  OnChange := StyleChanged;
  end;

FFontCaption := TFont.Create;
FFontCaption.Assign(Font);
FColGrayLine  := clGray;
FColWhiteLine := clWhite;
FDecPlaces := 1;
FTRim := 8;
FBRim := 10;
FSRim := 10;
FValue := 0.0;
FMinValue := 0.0;
FMaxValue := 1.0;
FCaption := 'V';
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;


(***********************************************************************)
destructor TMeter.Destroy;
(***********************************************************************)

begin
FNeedleLayout.Destroy;
FFontCaption.Free;
inherited Destroy;    { Inherit original constructor }
end;

(******************************************************************)
procedure TMeter.Loaded;
(******************************************************************)

begin
inherited Loaded;
if Value > FMaxValue
  then FValue := FMaxValue
  else if Value < FMinValue then
         FValue := fMinValue;
Paint;
end;


(******************************************************************)
procedure TMeter.DoUnderFlowEvent;
(******************************************************************)

begin
if Assigned(FOnUnderFlow) then
  FOnUnderFlow (self);
end;


(******************************************************************)
procedure TMeter.DoOverFlowEvent;
(******************************************************************)

begin
if Assigned(FOnOverFlow) then
  FOnOverFlow (self);
end;


(******************************************************************)
procedure TMeter.DoNormalRangeEvent;
(******************************************************************)

begin
if Assigned(FOnNormalRange) then
  FOnNormalRange (self);
end;


(******************************************************************)
function TMeter.CalcM (DecPlaces: integer; lo, hi: double):integer;
(******************************************************************
ENTRY: lo ........ low value
       hi ........ high value

EXIT:  CalcM returns the number of decimal places needed for a
       sufficiently precise labeling of the indicated range.
*******************************************************************)

var
  h : double;

begin
if DecPlaces = -2
  then begin
       h := abs(Hi-Lo);
       if (h >= 1e6) or (h <= 1e-4)
         then CalcM := -1
         else if h >= 100
                then CalcM := 0
                else CalcM := 2-round(ln(abs(Hi-Lo))/2.5);
       end
  else CalcM := DecPlaces;
end;




(***********************************************************************)
procedure TMeter.SetFrameStyle (value: TFrameStyle);
(***********************************************************************)

begin
if Value <> FFrameStyle then
  begin
  FFrameStyle := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TMeter.SetFontCaption (Value: TFont);
(***********************************************************************)

begin
FFontCaption.Assign(value);
Paint;
end;

(***********************************************************************)
procedure TMeter.SetMeterLayout (value: TMeterLayout);
(***********************************************************************)

begin
if Value <> FMeterLayout then
  begin
  FMeterLayout := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TMeter.SetColorBakG (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorBakG then
  begin
  FColorBakG := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TMeter.SetColorCover (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorCover then
  begin
  FColorCover := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TMeter.SetColorScheme (Value: TColorScheme);
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
procedure TNeedleLayout.SetShadowColor (Value: TColor);
(***********************************************************************)

begin
if Value <> FShadowColor then
  begin
  FShadowColor := Value;
  Changed;
  end;
end;

(***********************************************************************)
procedure TNeedleLayout.SetColorLine (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorLine then
  begin
  FColorLine := Value;
  Changed;
  end;
end;

(***********************************************************************)
procedure TMeter.SetColorScale (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorScale then
  begin
  FColorScale := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TMeter.SetColorBakGLow (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorBakGLow then
  begin
  FColorBakGLow := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TMeter.SetColorBakGNorm (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorBakGNorm then
  begin
  FColorBakGNorm := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TMeter.SetColorBakGHigh (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorBakGHigh then
  begin
  FColorBakGHigh := Value;
  Paint;
  end;
end;



(***********************************************************************)
procedure TNeedleLayout.SetColorFill (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorFill then
  begin
  FColorFill := Value;
  Changed;
  end;
end;

(***********************************************************************)
procedure TMeter.SetDecPlaces (Value: integer);
(***********************************************************************)

begin
if Value <> FDecPlaces then
  begin
  if Value < 0 then
    value := 0;
  if Value > 4 then
    value := 4;
  FDecPlaces := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TMeter.SetNrTicks (Value: integer);
(***********************************************************************)

begin
if Value <> FNrTicks then
  begin
  if Value < 2 then
    value := 2;
  if Value > 21 then
    value := 21;
  FNrTicks := Value;
  Paint;
  end;
end;



(***********************************************************************)
procedure TMeter.SetBRim (Value: integer);
(***********************************************************************)

begin
if Value <> FBrim then
  begin
  FBRim := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TMeter.SetSRim (Value: integer);
(***********************************************************************)

begin
if Value <> FSrim then
  begin
  FSRim := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TMeter.SetTRim (Value: integer);
(***********************************************************************)

begin
if Value <> FTrim then
  begin
  FTRim := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNeedleLayout.SetArrowSize1 (Value: integer);
(***********************************************************************)

begin
if Value <> FSize1 then
  begin
  FSize1 := Value;
  Changed;
  end;
end;



(***********************************************************************)
procedure TNeedleLayout.SetArrowSizeAnchor (Value: integer);
(***********************************************************************)

begin
if Value <> FSizeAnchor then
  begin
  FSizeAnchor := Value;
  Changed;
  end;
end;



(***********************************************************************)
procedure TNeedleLayout.SetShadowDx (Value: integer);
(***********************************************************************)

begin
if Value <> FShadowdx then
  begin
  FShadowDx := Value;
  Changed;
  end;
end;

(***********************************************************************)
procedure TNeedleLayout.SetShadowdy (Value: integer);
(***********************************************************************)

begin
if Value <> FShadowdy then
  begin
  FShadowdy := Value;
  Changed;
  end;
end;



(***********************************************************************)
procedure TNeedleLayout.SetBackShift1 (Value: integer);
(***********************************************************************)

begin
if Value <> FBackShift1 then
  begin
  FBackShift1 := Value;
  Changed;
  end;
end;



(***********************************************************************)
procedure TNeedleLayout.SetArrowThick (Value: integer);
(***********************************************************************)

begin
if Value <> FThickNess then
  begin
  FThickNess := Value;
  Changed;
  end;
end;

(***********************************************************************)
procedure TNeedleLayout.SetArrowAngle1 (Value: integer);
(***********************************************************************)

begin
if Value > 180 then
  Value := 180;
if Value < 0 then
  Value := 0;
if Value <> FAngle1 then
  begin
  FAngle1 := Value;
  Changed;
  end;
end;



(***********************************************************************)
procedure TMeter.SetScaleBkWidth (Value: double);
(***********************************************************************)

begin
if Value < 0 then
  Value := 0;
if Value > 100 then
  Value := 100;
FScaleBakWidth := value;
Paint;
end;

(***********************************************************************)
procedure TMeter.SetScaleBkVis (Value: boolean);
(***********************************************************************)

begin
FScaleBkVis := value;
Paint;
end;


(***********************************************************************)
procedure TMeter.SetValue (Value: double);
(***********************************************************************)

begin
if (csLoading in ComponentState)
  then FValue := value
  else begin
       if Value <> FValue then
         begin
         if Value > FMaxValue
           then FValue := FMaxValue
           else begin
                if Value < FMinValue
                  then FValue := fMinValue
                  else FValue := Value;
                end;
         FOFL := false;
         FUFL := false;
         if FValue >= FHighThreshold
           then begin
                FOFL := true;
                DoOverFlowEvent;
                end
           else if FValue <= FLowThreshold
                  then begin
                       FUFL := true;
                       DoUnderFlowEvent;
                       end
                  else begin
                       DoNormalRangeEvent;
                       end;
         Paint;
         end;
       end;
end;


(***********************************************************************)
procedure TMeter.SetMinValue (Value: double);
(***********************************************************************)

begin
if (csLoading in ComponentState)
  then FMinValue := Value
  else begin
       if (Value <> FMinValue) then
         begin
         FMinValue := Value;
         if FMaxValue <= FMinValue then
           FMaxValue := FMinValue+1;
         if FValue < FMinValue then
           FValue := FMinValue;
         if FLowThreshold < FMinValue then
           FLowThreshold := FMinValue;
         if FHighThreshold < FMinValue then
           FHighThreshold := FMinValue;
         Paint;
         end;
       end;
end;

(***********************************************************************)
procedure TMeter.SetMaxValue (Value: double);
(***********************************************************************)

begin
if (csLoading in ComponentState)
  then FMaxValue := Value
  else begin
       if (Value <> FMaxValue) then
         begin
         FMaxValue := Value;
         if FMinValue >= FMaxValue then
           FMinValue := FMaxValue-1;
         if FValue > FMaxValue then
           FValue := FMaxValue;
         if FLowThreshold > FMaxValue then
           FLowThreshold := FMaxValue;
         if FHighThreshold > FMaxValue then
           FHighThreshold := FMaxValue;
         Paint;
         end;
       end;
end;

(***********************************************************************)
procedure TMeter.SetLowThreshold (Value: double);
(***********************************************************************)

begin
if (csLoading in ComponentState)
  then FLowThreshold := Value
  else begin
       if (Value <> FLowThreshold) then
         begin
         FLowThreshold := Value;
         if FLowThreshold < FMinValue then
           FLowThreshold := FMinValue;
         if FLowThreshold > FMaxValue then
           FLowThreshold := FMaxValue;
         if FLowThreshold > FHighThreshold then
           FHighThreshold := FLowThreshold;
         FUFL := false;
         if FValue <= FLowThreshold then
           begin
           FUFL := true;
           DoUnderFlowEvent;
           end;
         Paint;
         end;
       end;
end;


(***********************************************************************)
procedure TMeter.SetHighThreshold (Value: double);
(***********************************************************************)

begin
if (csLoading in ComponentState)
  then FHighThreshold := Value
  else begin
       if (Value <> FHighThreshold) then
         begin
         FHighThreshold := Value;
         if FHighThreshold < FMinValue then
           FHighThreshold := FMinValue;
         if FHighThreshold > FMaxValue then
           FHighThreshold := FMaxValue;
         if FHighThreshold < FLowThreshold then
           FLowThreshold := FHighThreshold;
         FOFL := false;
         if FValue >= FHighThreshold then
           begin
           FOFL := true;
           DoOverFlowEvent;
           end;
         Paint;
         end;
       end;
end;



(***********************************************************************)
procedure TNeedleLayout.SetAnchorCovrd (Value: boolean);
(***********************************************************************)

begin
if Value <> FAnchorCovrd then
  begin
  FAnchorCovrd := Value;
  Changed;
  end;
end;


(***********************************************************************)
procedure TMeter.SetShortTicks (Value: boolean);
(***********************************************************************)

begin
if Value <> FShortTicks then
  begin
  FShortTicks := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TMeter.SetScaleLine (Value: boolean);
(***********************************************************************)

begin
if Value <> FScaleLine then
  begin
  FScaleLine := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TMeter.SetLimWatHighOn (Value: boolean);
(***********************************************************************)

begin
if Value <> FLimWatHighOn then
  begin
  FLimWatHighOn := Value;
  Paint;
  end;
end;



(***********************************************************************)
procedure TMeter.SetLimWatLowOn (Value: boolean);
(***********************************************************************)

begin
if Value <> FLimWatLowOn then
  begin
  FLimWatLowOn := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TMeter.SetLimWatActCol (Value: TColor);
(***********************************************************************)

begin
if Value <> FLimWatActCol then
  begin
  FLimWatActCol := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TMeter.SetLimWatPsvCol (Value: TColor);
(***********************************************************************)

begin
if Value <> FLimWatPsvCol then
  begin
  FLimWatPsvCol := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TMeter.StyleChanged(Sender: TObject);
(***********************************************************************)

begin
Paint;
end;



(***********************************************************************)
procedure TNeedleLayout.Changed;
(***********************************************************************)

begin
if Assigned(FOnChange) then
  FOnChange(Self);
end;


(***********************************************************************)
procedure TMeter.SetUnitLabel (astr: TLabelStr);
(***********************************************************************)

begin
FCaption := astr;
Paint;
end;


(***********************************************************************)
procedure TMeter.SetNeedleLayout (x: TNeedleLayout);
(***********************************************************************)

begin
FNeedleLayout.Assign(x);
Paint;
end;


(***********************************************************************)
procedure TMeter.Paint;
(***********************************************************************)

const
  OFLSize = 10;
  Dist = 8;
  LongTick = 8;                           { length of long tick on scale }
  ShortTick = 4;                         { length of short tick on scale }
  TextDist = 15;                    { distance of labels from scale line }

var
  Beta1       : double;
  leng        : double;
  lengi       : integer;
  x1,x2,y1,y2 : longint;
  sept        : array[1..7] of TPoint;
  astr        : string;
  dx, dy      : double;
  i           : integer;
  GrafBmp     : TBitMap;
  FDir        : double;
  Ang1, Ang2,
  Ang3, Ang4  : double;
  MeterAngle  : double;
  Disti       : double;
  LoX         : double;
  LowT        : double;
  Divisor     : word;
  TTSpace     : double;
  m           : integer;
  TDir        : double;
  MaxTW       : double;
  MaxTH       : double;
  leng1, leng2: integer;
{$IFDEF SHAREWARE}
  j          : integer;
{$ENDIF}

begin
x1 := Width div 2;
y1 := Height-FBRim-Dist;
MeterAngle := 90;
leng := Height-FBRim-FTRim-2*Dist;
case FMeterLAyout of
   mlCirc90 : begin
              MeterAngle := 90;
              y1 := Height-FBRim-Dist;
              leng := Height-FBRim-FTRim-2*Dist;
              if leng > (Width/2-FSRim-Dist)*1.414 then
                leng := (Width/2-FSRim-Dist)*1.414;
              end;
  mlCirc120 : begin
              MeterAngle := 120;
              y1 := Height-FBRim-Dist;
              leng := Height-FBRim-FTRim-2*Dist;
              if leng > (Width/2-FSRim-Dist)*1.1547 then
                leng := (Width/2-FSRim-Dist)*1.1547;
              end;
  mlCirc180 : begin
              MeterAngle := 180;
              y1 := Height-FBRim-Dist;
              leng := width div 2 - FSRim-Dist;
              if leng > Height-FTRim-FBRim-2*Dist then
                leng := Height-FTRim-FBRim-2*Dist;
              end;
  mlCirc270 : begin
              MeterAngle := 270;
              leng := width div 2 - FSRim-Dist;
              if leng > (Height-FTRim-FBRim-2*Dist) / 1.7071 then
                leng := (Height-FTRim-FBRim-2*Dist) / 1.7071;
              y1 := round(FTRim+Dist+leng);
              end;
  mlCirc300 : begin
              MeterAngle := 300;
              leng := width div 2 - FSRim-Dist;
              if leng > (Height-FTRim-FBRim-2*Dist) / 1.8660 then
                leng := (Height-FTRim-FBRim-2*Dist) / 1.8660;
              y1 := round(FTRim+Dist+leng);
              end;
  mlCirc360 : begin
              MeterAngle := 360;
              leng := width div 2 - FSRim-Dist;
              if leng > (Height-FTRim-FBRim-2*Dist)/2 then
                leng := (Height-FTRim-FBRim-2*Dist)/2;
              y1 := round(FTRim+Dist+leng);
              end;
end;
FDir := 90+MeterAngle/2-(FValue-FMinValue)/(FMaxValue-FMinValue)*MeterAngle;
Ang1 := (90+MeterAngle/2)/180*pi;
Ang2 := (90+MeterAngle/2-(FLowThreshold-FMinValue)/(FMaxValue-FMinValue)*MeterAngle)/180*Pi;
Ang3 := (90+MeterAngle/2-(FHighThreshold-FMinValue)/(FMaxValue-FMinValue)*MeterAngle)/180*Pi;
Ang4 := (90-MeterAngle/2)/180*pi;
lengi := round(leng);

if leng > 0 then
  begin
  GrafBmp := TBitmap.Create;           { create working bitmap for flickerfree }
  GrafBmp.Width := Width;               { display and set its width and height }
  GrafBmp.Height := Height;
  with GrafBmp do
    begin
    Canvas.Font.Assign(Font);                                     { background }
    Canvas.Brush.Color := FColorBakG;
    Canvas.Pen.Color := FColorBakG;
    Canvas.Rectangle (0, 0, Width, Height);

    if FScaleBkVis then
      begin
      leng1 := round(leng + Dist div 2);         { draw colored scale background }
      leng2 := round((100-FScaleBakWidth)*leng/100);
      Canvas.Brush.Color := FColorBakGLow;
      Canvas.Pen.Color := FColorBakGLow;
      if abs(Ang2-Ang1) > 1e-6 then
        Canvas.Pie (x1-leng1, y1-leng1,
                    x1+leng1+1, y1+leng1,
                    x1+round(leng*cos(Ang2)), y1-round(leng*sin(Ang2)),
                    x1+round(leng*cos(Ang1)), y1-round(leng*sin(Ang1)));
      Canvas.Brush.Color := FColorBakGNorm;
      Canvas.Pen.Color := FColorBakGNorm;
      if abs(Ang3-Ang2) > 1e-6 then
        Canvas.Pie (x1-leng1, y1-leng1,
                    x1+leng1+1, y1+leng1,
                    x1+round(leng*cos(Ang3)), y1-round(leng*sin(Ang3)),
                    x1+round(leng*cos(Ang2)), y1-round(leng*sin(Ang2)));
      Canvas.Brush.Color := FColorBakGHigh;
      Canvas.Pen.Color := FColorBakGHigh;
      if abs(Ang4-Ang3) > 1e-6 then
        Canvas.Pie (x1-leng1, y1-leng1,
                    x1+leng1+1, y1+leng1,
                    x1+round(leng*cos(Ang4)), y1-round(leng*sin(Ang4)),
                    x1+round(leng*cos(Ang3)), y1-round(leng*sin(Ang3)));
      Canvas.Brush.Color := FColorBakG;
      Canvas.Pen.Color := FColorBakG;
      Canvas.Ellipse (x1-leng2, y1-leng2, x1+leng2+1, y1+leng2);
      end;

    Canvas.Pen.Color := FColorScale;                         { draw scale }
    Canvas.Brush.Style := bsClear;
    if FScaleLine then
      Canvas.Arc (x1-lengi, y1-lengi,
                  x1+lengi+1, y1+lengi,
                  x1+round(leng*cos(Ang4)), y1-round(leng*sin(Ang4)),
                  x1+round(leng*cos(Ang1)), y1-round(leng*sin(Ang1)));
    CalcScalePars (FNrTicks, FMinValue, FMaxValue, LoX, Disti, Divisor);
    TTSpace := Disti/Divisor;

    if FShortTicks then
      begin
      lowT := LoX-Disti;
      i:=0;
      repeat                                       { short scale ticks }
        if (abs(frac((LowT+i*TTSpace-LoX)/Disti)) > 0.00001) and
           ((LowT+i*TTSpace) >= FMinValue) then
          begin
          TDir := 90+MeterAngle/2-(LowT+i*TTSpace-FMinValue)/(FMaxValue-FMinValue)*MeterAngle;
          x2 := round(x1 + leng*cos(Pi*TDir/180));
          y2 := round(y1 - leng*sin(Pi*TDir/180));
          Canvas.MoveTo (x2,y2);
          x2 := round(x1 + (leng-ShortTick)*cos(Pi*TDir/180));
          y2 := round(y1 - (leng-ShortTick)*sin(Pi*TDir/180));
          Canvas.LineTo (x2,y2);
          end;
        inc(i);
      until (LowT + i*TTSpace - FMaxValue) > 0.001*TTSpace;
      end;
    m := CalcM (FDecPlaces,FMinValue,FMaxValue);
    i:=0;
    MaxTW := Canvas.TextWidth(strff(FMaxValue,1,m))/2+TextDist;
    MaxTH := Canvas.TextHeight(strff(FMaxValue,1,m))/2+TextDist;
    Canvas.Brush.Style := bsClear;
    repeat                        { long scale ticks + inscription }
      TDir := 90+MeterAngle/2-(LoX+i*Disti-FMinValue)/(FMaxValue-FMinValue)*MeterAngle;
      x2 := round(x1 + leng*cos(Pi*TDir/180));
      y2 := round(y1 - leng*sin(Pi*TDir/180));
      Canvas.MoveTo (x2,y2);
      x2 := round(x1 + (leng-LongTick)*cos(Pi*TDir/180));
      y2 := round(y1 - (leng-LongTick)*sin(Pi*TDir/180));
      Canvas.LineTo (x2,y2);
      x2 := round(x1 + (leng-MaxTW)*cos(Pi*TDir/180));
      y2 := round(y1 - (leng-MaxTH)*sin(Pi*TDir/180));
      astr := strff(LoX+i*DIsti,1,m);
      Canvas.TextOut (x2-Canvas.TextWidth(astr) div 2,
                      y2-Canvas.TextHeight(astr) div 2,astr);
      inc(i);
    until (LoX + i*Disti - FMaxValue) > 0.001*Disti;

    Canvas.Font.Assign(FFontCaption);                             { unit label }
    Canvas.TextOut (x1 - Canvas.TextWidth(FCaption) div 2,
                    y1-round(leng/3)-Canvas.TextHeight(FCaption) div 2, FCaption);

    leng := leng-4;
    x2 := round(x1 + leng*cos(Pi*FDir/180));                     { draw needle }
    y2 := round(y1 - leng*sin(Pi*FDir/180));
    Beta1 := Pi*FNeedleLayout.FAngle1/180;
    dx := FNeedleLayout.FThickness/2*sin(Pi*FDir/180);
    dy := FNeedleLayout.FThickness/2*cos(Pi*FDir/180);
    Sept[1].x := round (x2 - FNeedleLayout.FSize1*cos(Beta1/2+Pi*FDir/180)) - FNeedleLayout.FShadowDx;
    Sept[1].y := round (y2 + FNeedleLayout.FSize1*sin(Beta1/2+Pi*FDir/180)) - FNeedleLayout.FShadowDy;
    Sept[2].x := x2 - FNeedleLayout.FShadowDx;
    Sept[2].y := y2 - FNeedleLayout.FShadowDy;
    Sept[3].x := round (x2 - FNeedleLayout.FSize1*cos(-Beta1/2+Pi*FDir/180)) - FNeedleLayout.FShadowDx;
    Sept[3].y := round (y2 + FNeedleLayout.FSize1*sin(-Beta1/2+Pi*FDir/180)) - FNeedleLayout.FShadowDy;
    Sept[6].x := round(x1+dx) - FNeedleLayout.FShadowDx;
    Sept[6].y := round(y1+dy) - FNeedleLayout.FShadowDy;
    Sept[5].x := round(x1-dx) - FNeedleLayout.FShadowDx;
    Sept[5].y := round(y1-dy) - FNeedleLayout.FShadowDy;
    Sept[4].x := round(x2-dx-FNeedleLayout.FBackShift1*cos(Pi*FDir/180)) - FNeedleLayout.FShadowDx;
    Sept[4].y := round(y2-dy+FNeedleLayout.FBackShift1*sin(Pi*FDir/180)) - FNeedleLayout.FShadowDy;
    Sept[7].x := round(x2+dx-FNeedleLayout.FBackShift1*cos(Pi*FDir/180)) - FNeedleLayout.FShadowDx;
    Sept[7].y := round(y2+dy+FNeedleLayout.FBackShift1*sin(Pi*FDir/180)) - FNeedleLayout.FShadowDy;
    if (FNeedleLayout.FShadowDx <> 0) or (FNeedleLayout.FShadowDy <> 0) then
      begin
      Canvas.Pen.Color := FNeedleLayout.FShadowColor;
      Canvas.Brush.Color := FNeedleLayout.FShadowColor;
      Canvas.Polygon (Sept);
      for i:=1 to 7 do
        begin
        Sept[i].x := Sept[i].x+FNeedleLayout.FShadowDx;
        Sept[i].y := Sept[i].y+FNeedleLayout.FShadowDy;
        end;
      end;
    Canvas.Pen.Color := FNeedleLayout.FColorLine;
    Canvas.Brush.Color := FNeedleLayout.FColorFill;
    Canvas.Polygon (Sept);

    Canvas.Pen.Color := FColorCover;                  { metal cover sheet }
    Canvas.Brush.color := FColorCover;
    Canvas.Rectangle (0,0,FSRim-1,Height);
    Canvas.Rectangle (0,0,Width,FTRim);
    Canvas.Rectangle (Width-FSRim,0,Width,Height);
    Canvas.Rectangle (0,Height-FBRim,Width,Height);
    if FNeedleLayout.FAnchorCovrd                                 { draw Anchor if TRUE }
      then begin
           if (FMeterLayout = mlCirc270) or (FMeterLayout = mlCirc300) or (FMeterLayout = mlCirc360)
             then begin
                  Canvas.Ellipse (x1-FNeedleLayout.FSizeAnchor, y1-FNeedleLayout.FSizeAnchor,
                                  x1+FNeedleLayout.FSizeAnchor,y1+FNeedleLayout.FSizeAnchor);
                  Canvas.Pen.Color := clWhite;
                  Canvas.Moveto (FSRim-1,Height-FBrim);
                  Canvas.Lineto (Width-FSRim,Height-FBrim);
                  Canvas.Lineto (Width-FSRim,FTrim);
                  Canvas.Pen.Color := clGray;
                  Canvas.Lineto (FSRim-1,FTrim);
                  Canvas.Lineto (FSRim-1,Height-FBrim);
                  Canvas.Pen.Color := clWhite;
                  Canvas.Arc (x1-FNeedleLayout.FSizeAnchor,y1-FNeedleLayout.FSizeAnchor,
                              x1+FNeedleLayout.FSizeAnchor,y1+FNeedleLayout.FSizeAnchor,
                              x1+FNeedleLayout.FSizeAnchor,y1-FNeedleLayout.FSizeAnchor,
                              x1-FNeedleLayout.FSizeAnchor,y1+FNeedleLayout.FSizeAnchor);
                  Canvas.Pen.Color := clGray;
                  Canvas.Arc (x1-FNeedleLayout.FSizeAnchor,y1-FNeedleLayout.FSizeAnchor,
                              x1+FNeedleLayout.FSizeAnchor,y1+FNeedleLayout.FSizeAnchor,
                              x1-FNeedleLayout.FSizeAnchor,y1+FNeedleLayout.FSizeAnchor,
                              x1+FNeedleLayout.FSizeAnchor,y1-FNeedleLayout.FSizeAnchor);
                  end
             else begin
                  Canvas.Pie (x1-FNeedleLayout.FSizeAnchor,y1-FNeedleLayout.FSizeAnchor,
                              x1+FNeedleLayout.FSizeAnchor,y1+FNeedleLayout.FSizeAnchor,
                              Width, y1, 0, y1);
                  Canvas.Rectangle (x1-FNeedleLayout.FSizeAnchor,Height-FBRim,
                                    x1+FNeedleLayout.FSizeAnchor,y1);
                  Canvas.Pen.Color := clGray;
                  Canvas.Moveto (x1+FNeedleLayout.FSizeAnchor-1,y1);
                  Canvas.Lineto (x1+FNeedleLayout.FSizeAnchor-1,Height-FBrim);
                  Canvas.Pen.Color := clWhite;
                  Canvas.Lineto (Width-FSRim,Height-FBrim);
                  Canvas.Lineto (Width-FSRim,FTrim);
                  Canvas.Pen.Color := clGray;
                  Canvas.Lineto (FSRim-1,FTrim);
                  Canvas.Lineto (FSRim-1,Height-FBrim);
                  Canvas.Pen.Color := clWhite;
                  Canvas.Lineto (x1-FNeedleLayout.FSizeAnchor,Height-FBrim);
                  Canvas.Lineto (x1-FNeedleLayout.FSizeAnchor,y1-1);
                  Canvas.Arc (x1-FNeedleLayout.FSizeAnchor,y1-FNeedleLayout.FSizeAnchor,
                              x1+FNeedleLayout.FSizeAnchor,y1+FNeedleLayout.FSizeAnchor,
                              Width, y1, 0, y1);
                  Canvas.Pen.Color := clGray;
                  Canvas.Arc (x1-FNeedleLayout.FSizeAnchor,y1-FNeedleLayout.FSizeAnchor,
                              x1+FNeedleLayout.FSizeAnchor,y1+FNeedleLayout.FSizeAnchor,
                              x1+FNeedleLayout.FSizeAnchor,y1,
                              x1+FNeedleLayout.FSizeAnchor,y1-FNeedleLayout.FSizeAnchor);
                  end;
           end
      else begin
           Canvas.Pen.Color := clWhite;
           Canvas.Moveto (FSRim-1,Height-FBrim);
           Canvas.Lineto (Width-FSRim,Height-FBrim);
           Canvas.Lineto (Width-FSRim,FTrim);
           Canvas.Pen.Color := clGray;
           Canvas.Lineto (FSRim-1,FTrim);
           Canvas.Lineto (FSRim-1,Height-FBrim);
           end;

    if FLimWatHighOn then                       { draw overflow indicator }
      begin
      if FOFL
        then Canvas.Brush.Color := FLimWatActCol
        else Canvas.Brush.Color := FLimWatPsvCol;
      Canvas.Pen.Color := clBlack;
      Canvas.Rectangle (Width-OFLSize-FSRim-Dist, FTRim+Dist+OFLSize,
                        Width-FSRim-Dist, FTRim+Dist);
      Canvas.Pen.Color := clWhite;
      Canvas.MoveTo (Width-OFLSize-FSRim-Dist+1, FTRim+Dist+OFLSize-1);
      Canvas.LineTo (Width-FSRim-Dist-1, FTRim+Dist+OFLSize-1);
      Canvas.LineTo (Width-FSRim-Dist-1, FTRim+Dist);
      Canvas.Pen.Color := clSilver;
      Canvas.MoveTo (Width-OFLSize-FSRim-Dist+2, FTRim+Dist+OFLSize-2);
      Canvas.LineTo (Width-FSRim-Dist-2, FTRim+Dist+OFLSize-2);
      Canvas.LineTo (Width-FSRim-Dist-2, FTRim+Dist+1);
      Canvas.Pen.Color := clGray;
      Canvas.MoveTo (Width-OFLSize-FSRim-Dist+1, FTRim+Dist+OFLSize-2);
      Canvas.LineTo (Width-OFLSize-FSRim-Dist+1, FTRim+Dist+1);
      Canvas.LineTo (Width-FSRim-Dist-1, FTRim+Dist+1);
      end;
    if FLimWatLowOn then
      begin
      if FUFL
        then Canvas.Brush.Color := FLimWatActCol
        else Canvas.Brush.Color := FLimWatPsvCol;
      Canvas.Pen.Color := clBlack;
      Canvas.Rectangle (FSRim+Dist, FTRim+Dist+OFLSize,
                        FSRim+Dist+OFLSize, FTRim+Dist);
      Canvas.Pen.Color := clWhite;
      Canvas.MoveTo (FSRim+Dist+1, FTRim+Dist+OFLSize-1);
      Canvas.LineTo (FSRim+Dist+OFLSize-1, FTRim+Dist+OFLSize-1);
      Canvas.LineTo (FSRim+Dist+OFLSize-1, FTRim+Dist);
      Canvas.Pen.Color := clSilver;
      Canvas.MoveTo (FSRim+Dist+2, FTRim+Dist+OFLSize-2);
      Canvas.LineTo (FSRim+Dist+OFLSize-2, FTRim+Dist+OFLSize-2);
      Canvas.LineTo (FSRim+Dist+OFLSize-2, FTRim+Dist+1);
      Canvas.Pen.Color := clGray;
      Canvas.MoveTo (FSRim+Dist+1, FTRim+Dist+OFLSize-2);
      Canvas.LineTo (FSRim+Dist+1, FTRim+Dist+1);
      Canvas.LineTo (FSRim+Dist+OFLSize-1, FTRim+Dist+1);
      end;


    if FFrameStyle = fsEmbossed                              { draw frame }
      then Canvas.Pen.Color := FColWhiteLine
      else Canvas.Pen.Color := FColGrayLine;
    case FFrameStyle of
      fsRaised : begin
                 Canvas.Pen.Color := FColWhiteLine;
                 Canvas.MoveTo (0, Height-1);
                 Canvas.LineTo (0, 0);
                 Canvas.LineTo (Width-1, 0);
                 Canvas.Pen.Color := FColGrayLine;
                 Canvas.LineTo (Width-1, Height-1);
                 Canvas.LineTo (0, Height-1);
                 end;
    fsEngraved : begin
                 Canvas.MoveTo (0, 0);
                 Canvas.LineTo (Width-2, 0);
                 Canvas.LineTo (Width-2, Height-2);
                 Canvas.LineTo (0, Height-2);
                 Canvas.LineTo (0, 0);
                 Canvas.Pen.Color := FColWhiteLine;
                 Canvas.MoveTo (1, Height-3);
                 Canvas.LineTo (1, 1);
                 Canvas.LineTo (Width-2, 1);
                 Canvas.MoveTo (1, Height-1);
                 Canvas.LineTo (Width-1, Height-1);
                 Canvas.LineTo (Width-1, 0);
                 end;
    fsEmbossed : begin
                 Canvas.MoveTo (0, 0);
                 Canvas.LineTo (Width-2, 0);
                 Canvas.LineTo (Width-2, Height-2);
                 Canvas.LineTo (0, Height-2);
                 Canvas.LineTo (0, 0);
                 Canvas.Pen.Color := FColGrayLine;
                 Canvas.MoveTo (1, Height-3);
                 Canvas.LineTo (1, 1);
                 Canvas.LineTo (Width-2, 1);
                 Canvas.MoveTo (1, Height-1);
                 Canvas.LineTo (Width-1, Height-1);
                 Canvas.LineTo (Width-1, 0);
                 end;
     fsLowered : begin
                 Canvas.Pen.Color := FColGrayLine;
                 Canvas.MoveTo (0, Height-1);
                 Canvas.LineTo (0, 0);
                 Canvas.LineTo (Width-1, 0);
                 Canvas.Pen.Color := FColWhiteLine;
                 Canvas.LineTo (Width-1, Height-1);
                 Canvas.LineTo (0, Height-1);
                 end;
      fsSimple : begin
                 Canvas.Pen.Color := FColorBakg;
                 Canvas.MoveTo (0, Height-1);
                 Canvas.LineTo (0, 0);
                 Canvas.LineTo (Width-1, 0);
                 Canvas.LineTo (Width-1, Height-1);
                 Canvas.LineTo (0, Height-1);
                 end;
    end;
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
  Canvas.Draw (0,0,GrafBmp);
  GrafBmp.Free;                             { destroy the graphics bitmap }
  end;
end;



(***********************************************************************)
procedure Register;
(***********************************************************************)

begin
RegisterComponents ('SDL', [TMeter]);
end;



end.




