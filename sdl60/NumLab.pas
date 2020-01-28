unit NumLab;

(******************************************************************)
(*                                                                *)
(*                           N U M L A B                          *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1996..2001 H. Lohninger                 August  1996   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Aug-01, 2001                                  *)
(*                                                                *)
(******************************************************************)


{ revision history:

1.5   [May-28,1997]
      NumLab now for C++Builder 1.0 available

1.6   [Apr-09,1998]
      NUMLAB now available for C++Builder 3.0
      bug fix: Visible = false does no more have any effect during design state
      correction: TColorScheme = (csBWG, csSystem); (not csSytem anymore)

1.7   [Aug-17, 1998]
      NUMLAB is now available for Delphi 4.0

2.0   [Mar-19, 1999]
      NUMLAB is now also available for C++Builder 4.0
      properties LeftTextAlignment and RightTextAlignment implemented
      property PopupMenu included
      property MouseAreaCode implemented
      NUMLAB can now display also date and time strings
      property DTFormat implemented
      property Comma implemented
      property ForcePlusSign implemented
      bug fix: empty LeftText does not create 'X:' any more
      bug fix: bottom border of fsSimple and fsNone frames were shifted up by one pixel
      property Align implemented

5.0   [Oct-09, 1999]
      NUMLAB is now part of SDL Comp.Suite 5.0
      NUMLAB available also for Delphi 5.0

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      input range for hexadecimal representation extended to -2^31 to +2^32-1
      property Anchors is now published
      ColorLabBakG and ColorOutBakG are now clBtnFace by default
}

{-$DEFINE SHAREWARE}
{ if this switch is turned on, the 'hint'-property is set during startup
  in order to indicate an unregistered shareware version }

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

{-------------------------------------------------------------------------}
interface
{-------------------------------------------------------------------------}


uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Menus,
  Graphics, Controls, Forms, ExtCtrls;

const
  defLeftSpace = 35;                                 { default left space }
  defPrecision = 2;                            { number of decimal places }
  defLabelWidth = 80;                            { default width of label }

type
  LabelStr = string[80];
  TFrameStyle = (fsNone, fsSimple, fsLowered, fsRaised, fsEmbossed, fsEngraved);
  TDisplay = (dtFloat, dtFixP, dtExp, dtHex, dtZeroInt, dtInt, dtDateTime);
  TColorScheme = (csBWG, csSystem);
  TNumLab = class (TGraphicControl)
            private
              FLeftSpace  : integer;   { space for text left to the label }
              FEmpty      : boolean;                { TRUE if empyt label }
              FLabWidth   : integer;             { width of numeric field }
              FDecP       : integer;           { number of decimal places }
              FComma      : boolean; { TRUE=comma, FALSE=dot as dec. sep. }
              FPlusSign   : boolean; { TRUE=leading '+' sign for pos.nums }
              FLeftText   : LabelStr;             { text at left of label }
              FRightText  : LabelStr;            { text at right of label }
              FFrameStyle   : TFrameStyle;               { style of frame }
              FAlignment    : TAlignment;       { alignment of num. label }
              FLTAlignment  : TAlignment;        { alignment of left text }
              FRTAlignment  : TAlignment;      { alignment of right label }
              FMouseAreaCode: integer;           { mouse pos. - area code }
              FOverFlowIndi : LabelStr;              { overflow indicator }
              FLabValue     : double;            { numeric value of label }
              FColorLabBakG : TColor;         { color of label background }
              FColorLabText : TColor;               { color of label text }
              FColorOutBakG : TColor;         { color of outer background }
              FColorOutText : TColor;               { color of outer text }
              FColBlackLine : TColor;          { colors to draw the frame }
              FColGrayLine  : TColor;                       { -"- }
              FColWhiteLine : TColor;                       { -"- }
              FColorScheme  : TColorScheme;      { color scheme of frames }
              FDisplayType  : TDisplay;  { type of display: dec., hex,... }
              FDtFormat     : string;   { formatting string for date/time }

              procedure SetLeftSpace (Value: integer);
              procedure SetColorLabBakG (Value: TColor);
              procedure SetColorLabText (Value: TColor);
              procedure SetColorOutBakG (Value: TColor);
              procedure SetColorOutText (Value: TColor);
              procedure SetColorScheme (Value: TColorScheme);
              procedure SetFrameStyle (value: TFrameStyle);
              procedure SetFComma (value: boolean);
              procedure SetFPlusSign (value: boolean);
              procedure SetAlignment (value: TAlignment);
              procedure SetLTAlignment (value: TAlignment);
              procedure SetRTAlignment (value: TAlignment);
              procedure SetLabWidth (value: integer);
              procedure SetLabValue (value: double);
              procedure SetEmpty (value: boolean);
              procedure SetDecP (value: integer);
              procedure SetDtFormat (value: string);
              procedure SetLeftText (value: LabelStr);
              procedure SetRightText (value: LabelStr);
              procedure SetOverFlowIndi (value: LabelStr);
              procedure SetDisplayType (value: TDisplay);
            protected
              procedure AssignTo (Dest: TPersistent); override;
              procedure MouseMove (Shift: TShiftState; X,Y: integer); override;
              procedure Paint; override;
            public
              procedure   Assign(Source: TPersistent); override;
              constructor Create(AOwner: TComponent); override;
              destructor  Destroy; override;
              property Enabled;
              property    MouseAreaCode: integer read FMouseAreaCode;
            published
              property Align;
              property Alignment: TAlignMent read FAlignment write SetALignment;
{$IFNDEF VER110}               // CBuilder 3.0 does not know about anchors
  {$IFNDEF VER100}             // Delphi 3.0 does not know about anchors
              property Anchors;
  {$ENDIF}
{$ENDIF}
              property ColorLabBakG: TColor read FColorLabBakG write SetColorLabBakG;
              property ColorLabText: TColor read FColorLabText write SetColorLabText;
              property ColorOutBakG: TColor read FColorOutBakG write SetColorOutBakG;
              property ColorOutText: TColor read FColorOutText write SetColorOutText;
              property ColorScheme: TColorScheme read FColorScheme write SetColorScheme;
              property Comma: boolean read FComma write SetFComma;
              property DisplayType: TDisplay read FDisplayType write SetDisplayType;
              property DTFormat: string read FDTFormat write SetDtFormat;
              property Empty: boolean read FEmpty write SetEmpty;
              property Font;
              property ForcePlusSign: boolean read FPlusSign write SetFPlusSign;
              property FrameStyle: TFrameStyle read FFrameStyle write SetFrameStyle;
              property LabelWidth: integer read FLabWidth write SetLabWidth;
              property LeftSpace: integer read FLeftSpace write SetLeftSpace;
              property LeftText: LabelStr read FLeftText write SetLefttext;
              property LeftTextAlignment: TAlignMent read FLTAlignment write SetLTAlignment;
              property OverflowIndicator: LabelStr read FOverFlowIndi write SetOverFlowIndi;
              property ParentFont;
              property ParentShowHint;
              property PopupMenu;
              property Precision: integer read FDecP write SetDecP;
              property RightText: LabelStr read FRightText write SetRightText;
              property RightTextAlignment: TAlignMent read FRTAlignment write SetRTAlignment;
              property ShowHint;
              property Value: double read FLabValue write SetLabValue;
              property Visible;
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
  dialogs;
  
{$IFDEF SHAREWARE}
{$I sharwinc\numlab_ct.inc}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}

type
{$IFNDEF VER80}
  ShortStr = ShortString;
{$ELSE}
  ShortStr = string;
{$ENDIF}



(***********************************************************************)
constructor TNumLab.Create(AOwner: TComponent);
(***********************************************************************)

begin
inherited Create (AOwner);
Width := 2*defLabelWidth;
Height := 28;
FLeftText := '';
FRightText := '';
FLeftSpace := defLeftSpace;
FFrameStyle := fsLowered;
FEmpty := false;
FComma := false;
FPlusSign := false;
FMouseAreaCode := 0;
FLabWidth := defLabelWidth;
FDecP := defPrecision;
FDisplayType := dtFixP;
FDtFormat := 'mmm-dd, yyyy';
FColorLabText := clBlack;
FColorOutText := clBlack;
FColorLabBakG := clBtnFace;
FColorOutBakG := clBtnFace;
FColorScheme := csBWG;
FColBlackLine := clBlack;      { note: FColBlackLine is always black at the
                                            moment --> see SetColorScheme }
FColGrayLine  := clGray;
FColWhiteLine := clWhite;
FOverFlowIndi := '*********';
FAlignment := taCenter;
FLTAlignment := taRightJustify;
FRTAlignment := taLeftJustify;
FLabValue := 0.0;
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;


(***********************************************************************)
destructor TNumLab.Destroy;
(***********************************************************************)

begin
inherited Destroy;    { Inherit original constructor }
end;


(***********************************************************************)
procedure TNumLab.SetLeftSpace (Value: Integer);
(***********************************************************************)

begin
if (Value <> FLeftSpace) and (Value >= 0) then
  begin
  FLeftSpace := Value;
  if FLeftSpace > Width then
    FLeftSpace := Width;
  Paint;
  end;
end;



(***********************************************************************)
procedure TNumLab.SetColorLabText (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorLabText then
  begin
  FColorLabText := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetColorOutText (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorOutText then
  begin
  FColorOutText := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetColorLabBakG (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorLabBakG then
  begin
  FColorLabBakG := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetColorOutBakG (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorOutBakG then
  begin
  FColorOutBakG := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetFComma (value: boolean);
(***********************************************************************)

begin
if value <> FComma then
  begin
  FComma := value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetFPlusSign (value: boolean);
(***********************************************************************)

begin
if value <> FPlusSign then
  begin
  FPlusSign := value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetEmpty (Value: boolean);
(***********************************************************************)

begin
if Value <> FEmpty then
  begin
  FEmpty := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetLabWidth (Value: Integer);
(***********************************************************************)

begin
if Value <> FLabWidth then
  begin
  FLabWidth := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetDtFormat (value: string);
(***********************************************************************)

begin
if (Value <> FDtFormat) then
  begin
  FDTFormat := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetDecP (Value: Integer);
(***********************************************************************)

begin
if (Value <> FDecP) and (Value >= 0) then
  begin
  if Value > 15 then
    Value := 15;
  FDecP := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TNumLab.SetLeftText (Value: LabelStr);
(***********************************************************************)

begin
if Value <> FLeftText then
  begin
  FLeftText := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetRightText (Value: LabelStr);
(***********************************************************************)

begin
if Value <> FRightText then
  begin
  FRightText := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TNumLab.SetOverFlowIndi (Value: LabelStr);
(***********************************************************************)

begin
if Value <> FOverFlowIndi then
  begin
  FOverFlowIndi := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetDisplayType (value: TDisplay);
(***********************************************************************)

begin
if Value <> FDisplayType then
  begin
  FDisplayType := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetFrameStyle (value: TFrameStyle);
(***********************************************************************)

begin
if Value <> FFrameStyle then
  begin
  FFrameStyle := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetAlignment (value: TAlignment);
(***********************************************************************)

begin
if Value <> FAlignment then
  begin
  FAlignment := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetRTAlignment (value: TAlignment);
(***********************************************************************)

begin
if Value <> FRTAlignment then
  begin
  FRTAlignment := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TNumLab.SetLTAlignment (value: TAlignment);
(***********************************************************************)

begin
if Value <> FLTAlignment then
  begin
  FLTAlignment := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TNumLab.SetLabValue (value: double);
(***********************************************************************)

begin
if Value <> FLabValue then
  begin
  FLabValue := Value;
  Paint;
  end;
end;



(***********************************************************************)
procedure TNumLab.SetColorScheme (Value: TColorScheme);
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
procedure TNumLab.AssignTo (Dest: TPersistent);
(***********************************************************************)


begin
if self is Dest.ClassType
  then Dest.Assign (self)
  else inherited AssignTo (Dest);
end;

(***********************************************************************)
procedure TNumLab.Assign(Source: TPersistent);
(***********************************************************************
  REMARK: Only those fields are copied which are defined with the
          TNumLab declaration !!
 ***********************************************************************)

begin
if Source is TNumLab
  then begin
       FLeftSpace    := TNumLab(Source).FLeftSpace;
       FEmpty        := TNumLab(Source).FEmpty;
       FLabWidth     := TNumLab(Source).FLabWidth;
       FDecP         := TNumLab(Source).FDecP;
       FLeftText     := TNumLab(Source).FLeftText;
       FRightText    := TNumLab(Source).FRightText;
       FFrameStyle   := TNumLab(Source).FFrameStyle;
       FAlignment    := TNumLab(Source).FAlignment;
       FRTAlignment  := TNumLab(Source).FRTAlignment;
       FLTAlignment  := TNumLab(Source).FLTAlignment;
       FOverFlowIndi := TNumLab(Source).FOverFlowIndi;
       FLabValue     := TNumLab(Source).FLabValue;
       FColorLabBakG := TNumLab(Source).FColorLabBakG;
       FColorLabText := TNumLab(Source).FColorLabText;
       FColorOutBakG := TNumLab(Source).FColorOutBakG;
       FColorOutText := TNumLab(Source).FColorOutText;
       FColBlackLine := TNumLab(Source).FColBlackLine;
       FColGrayLine  := TNumLab(Source).FColGrayLine;
       FColWhiteLine := TNumLab(Source).FColWhiteLine;
       FColorScheme  := TNumLab(Source).FColorScheme;
       FDisplayType  := TNumLab(Source).FDisplayType;
       Paint;
       end
  else inherited Assign(Source);
end;


(**********************************************************************)
procedure TNumLab.MouseMove (Shift: TShiftState; X,Y: integer);
(**********************************************************************)

begin
FMouseAreaCode := 0;
if (X > FLeftSpace) then
  FMouseAreaCode := 1;
if (X > FLeftSpace+FLabWidth) then
  FMouseAreaCode := 2;
inherited MouseMove (Shift, X, Y);
end;



(***********************************************************************)
procedure TNumLab.Paint;
(***********************************************************************)

const
  Rim = 8;

var
  AuxStr  : string;
  th, th2 : integer;
  twAux   : integer;
  LabRect : TRect;
  AuxInt  : integer;
  GrafBmp : TBitMap;
  i       : integer;

begin
if Visible or (csDesigning in ComponentState) then
  begin
  Canvas.Font := Font;
  th2 := Canvas.TextHeight ('(8g]}ÜÄ§');   { trick to get height of font }
  th := Height-4;

  GrafBmp := TBitmap.Create;      { create working bitmap for flickerfree }
  GrafBmp.Width := Width;          { display and set its width and height }
  GrafBmp.Height := Height;
  with GrafBmp do
    begin
    Canvas.Font := Font;
    Canvas.Pen.Color := FColorOutBakG;
    Canvas.Brush.Color := FColorOutBakG;
    Canvas.Rectangle (0, 0, Width, Height);        { background of NumLab }

    Canvas.Font.Color := FColorOutText;
    twAux := Canvas.TextWidth(FLeftText);           { left text }
    case FLTAlignment of
            taCenter : Canvas.TextOut ((FLeftSpace-twAux) div 2, (Height-th2) div 2, FLeftText);
       taLeftJustify : Canvas.TextOut (Rim-1, (Height-th2) div 2, FLeftText);
      taRightJustify : Canvas.TextOut (FLeftSpace-Rim-twAux+3, (Height-th2) div 2, FLeftText);
    end;

    twAux := Canvas.TextWidth(FRightText);          { right text }
    case FRTAlignment of
            taCenter : Canvas.TextOut (1+FLeftSpace+FLabWidth+(Width-FLeftSpace-FLabWidth-twAux) div 2,
                                       (Height-th2) div 2, FRightText);
       taLeftJustify : Canvas.TextOut (FLeftSpace+FLabWidth+Rim-1, (Height-th2) div 2, FRightText);
      taRightJustify : Canvas.TextOut (Width-Rim-twAux+2, (Height-th2) div 2, FRightText);
    end;

    if FFrameStyle = fsNone
      then Canvas.Pen.Color := FColorLabBakG
      else begin
           if FFrameStyle = fsEmbossed
             then Canvas.Pen.Color := FColWhiteLine
             else Canvas.Pen.Color := FColGrayLine;
           end;

    Canvas.Brush.Color := FColorLabBakG;         { label background color }
    if ((FFrameStyle = fsNone) or (FFrameStyle = fsSimple))
      then begin
           Canvas.Rectangle (FLeftSpace, 0,
                             FLeftSpace+FLabWidth+2, height);
           end
      else begin
           Canvas.Rectangle (FLeftSpace, 0,
                             FLeftSpace+FLabWidth+2, height-1);
           Canvas.Pen.Color := FColWhiteLine;
           if FFrameStyle = fsRaised then
             begin
             Canvas.Pen.Color := FColWhiteLine;
             Canvas.MoveTo (FLeftSpace+1, th+1);
             Canvas.LineTo (FLeftSpace+1, 1);
             Canvas.LineTo (FLeftSpace+FLabWidth+1, 1);
             Canvas.Pen.Color := FColBlackLine;
             Canvas.MoveTo (FLeftSpace+1, th+3);
             Canvas.LineTo (FLeftSpace+FLabWidth+2, th+3);
             Canvas.LineTo (FLeftSpace+FLabWidth+2, 0);
             end;
           if FFrameStyle = fsEngraved then
             begin
             Canvas.Pen.Color := FColWhiteLine;
             Canvas.MoveTo (FLeftSpace+1, th+1);
             Canvas.LineTo (FLeftSpace+1, 1);
             Canvas.LineTo (FLeftSpace+FLabWidth+1, 1);
             Canvas.MoveTo (FLeftSpace+1, th+3);
             Canvas.LineTo (FLeftSpace+FLabWidth+2, th+3);
             Canvas.LineTo (FLeftSpace+FLabWidth+2, 0);
             end;
           if FFrameStyle = fsEmbossed then
             begin
             Canvas.Pen.Color := FColGrayLine;
             Canvas.MoveTo (FLeftSpace+1, th+1);
             Canvas.LineTo (FLeftSpace+1, 1);
             Canvas.LineTo (FLeftSpace+FLabWidth+1, 1);
             Canvas.MoveTo (FLeftSpace+1, th+3);
             Canvas.LineTo (FLeftSpace+FLabWidth+2, th+3);
             Canvas.LineTo (FLeftSpace+FLabWidth+2, 0);
             end;
           if FFrameStyle = fsLowered then
             begin
             Canvas.Pen.Color := FColBlackLine;
             Canvas.MoveTo (FLeftSpace+1, th+1);
             Canvas.LineTo (FLeftSpace+1, 1);
             Canvas.LineTo (FLeftSpace+FLabWidth+1, 1);
             Canvas.Pen.Color := FColWhiteLine;
             Canvas.MoveTo (FLeftSpace+1, th+3);
             Canvas.LineTo (FLeftSpace+FLabWidth+2, th+3);
             Canvas.LineTo (FLeftSpace+FLabWidth+2, 0);
             end;
           end;


    if not FEmpty then                        { numeric text inside label }
      begin
      case DisplayType of
          dtHex : begin
                  AuxInt := FDecP;
                  if AuxInt > 8 then
                    AuxInt := 8;
                  if (FLabValue > 2.0*MaxLongInt+1) or (FLabValue < -MaxLongInt-1)
                    then AuxStr := FOverFlowIndi
                    else begin
                         AuxStr := Format ('%*.*x',[1,AuxInt,round(FLabValue)]);
                         if length (AuxStr) > AuxInt then
                           delete (AuxStr, 1, length(AuxStr)-AuxInt);
                         end;
                  end;
        dtFloat : AuxStr := Format ('%*.*g',[1,FDecP,FLabValue]);
         dtFixP : AuxStr := Format ('%*.*f',[1,FDecP,FLabValue]);
          dtExp : AuxSTr := Format ('%*.*e',[1,FDecP,FLabValue]);
     dtDateTime : begin
                  AuxStr := FormatDateTime (fDtFormat, FLabValue);
                  end;
      dtZeroInt : begin
                  if (FLabValue > MaxLongInt) or (FLabValue < -MaxLongInt-1)
                    then AuxStr := FOverFlowIndi
                    else AuxStr := Format ('%*.*d',[1,FDecP,round(FLabValue)]);
                  end;
          dtInt : AuxStr := Format ('%*.*f',[1,0,FLabValue]);
      end;
      if (DisplayType <> dtDateTime) and (DisplayType <> dtHex) then
        begin
        if FComma
          then begin
               for i:=1 to length(AuxStr) do
                 if AuxStr[i] = '.' then
                   AuxStr[i] := ','
               end
          else begin
               for i:=1 to length(AuxStr) do
                 if AuxStr[i] = ',' then
                   AuxStr[i] := '.'
               end;
        if FPlusSign then
          if FLabValue > 0 then
            AuxStr := '+'+AuxStr;
        end;
      twAux := Canvas.TextWidth (AuxStr);
      if twAux > FLabWidth-6 then
        begin
        AuxStr := FOverFlowIndi;
        twAux := Canvas.TextWidth (AuxStr);
        end;
      Canvas.Font.Color := FColorLabText;
      LabRect.Left := LeftSpace+3;
      LabRect.Right := LeftSpace+FLabWidth-1;
      LabRect.Top := 2;
      LabRect.Bottom := th+1;
      case FAlignment of
              taCenter : Canvas.TextRect (LabRect, FLeftSpace+2+(FLabWidth-twAux) div 2, (Height-th2) div 2, AuxStr);
         taLeftJustify : Canvas.TextRect (LabRect, FLeftSpace+4, (Height-th2) div 2, AuxStr);
        taRightJustify : Canvas.TextRect (LabRect, FLeftSpace+FLabWidth-2-twAux, (Height-th2) div 2, AuxStr);
      end;
      end;

    {$IFDEF SHAREWARE}
    if not DelphiIsRunning then
      begin
      Canvas.Font.Color := clBlack;
      Canvas.Brush.Color := clWhite;
      Canvas.TextOut (2, 2, ' TNumLab not registered ');
      end;
    Hint := GetHintStr;
    ShowHint := True;
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
RegisterComponents ('SDL', [TNumLab]);
end;



(**************************************************************************)
(*                              INIT                                      *)
(**************************************************************************)

begin
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
end.


