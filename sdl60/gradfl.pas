unit gradfl;

(******************************************************************)
(*                                                                *)
(*                         G R A D F L                            *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1999..2001 H. Lohninger                  February 99   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Oct-09, 1999                                  *)
(*                                                                *)
(******************************************************************)

{ Release History:

5.0   [Oct-09, 1999]
      GRADFL made available to the public as part of SDL Comp.Suite 5.0

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
}

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

{-------------------------------------------------------------------}
interface
{-------------------------------------------------------------------}


uses
  SysUtils, WinTypes, WinProcs, Messages, Classes,
  Graphics, Controls, Forms, ExtCtrls;

type
  TGradType = (gtHoriz, gtVert, gtEllipticFull, gtEllipticFit,
               gtMidBandHoriz, gtMidBandVert, gtRadial, gtDiagGrid);
  TGradFill = class(TGraphicControl)
                  private
                    FNrColors   : integer;
                    FGradType   : TGradType;
                    FColorFirst : TColor;
                    FColorLast  : TColor;
                    FColorsFlipped : boolean;
                    procedure SetColorLast(Value: TColor);
                    procedure SetColorFirst(Value: TColor);
                    procedure SeTGradType(Value: TGradType);
                    procedure SetNrColors(Value: integer);
                    procedure SetColorFlipped (Value: boolean);
                  protected
                    procedure Paint; override;
                  public
                    constructor Create(AOwner: TComponent); override;
                  published
                    property ColorFlipped: boolean read FColorsFlipped write SetColorFlipped;
                    property ColorFirst: TColor read FColorFirst write SetColorFirst;
                    property ColorLast: TColor read FColorLast write SetColorLast;
                    property FillType: TGradType read FGradType write SeTGradType default gtHoriz;
                    property NrColors: integer read FNrColors write SetNrColors default 16;
                    property Align;
                    property ParentShowHint;
                    property ShowHint;
                    property Visible;
                    property OnClick;
                    property OnDblClick;
                    property OnMouseDown;
                    property OnMouseMove;
                    property OnMouseUp;
                  end;

procedure Register;


{-------------------------------------------------------------------}
implementation
{-------------------------------------------------------------------}

{$IFDEF SHAREWARE}
{$I sharwinc\gradfl_ct.INC}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}


(*******************************************************************)
constructor TGradFill.Create(AOwner: TComponent);
(*******************************************************************)

begin
inherited Create(AOwner);
Height := 121;
Width := 121;
FColorsFlipped := false;
FColorFirst := clMaroon;
FColorLast := clYellow;
FGradType := gtHoriz;
FNrColors := 16;
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;

(*******************************************************************)
procedure TGradFill.SetColorFirst(Value: TColor);
(*******************************************************************)

begin
FColorFirst := Value;
Invalidate;
end;

(*******************************************************************)
procedure TGradFill.SetColorFlipped (Value: boolean);
(*******************************************************************)

var
  dummyCol : TColor;

begin
FColorsFlipped := Value;
DummyCol := FColorFirst;
FColorFirst := FColorLast;
FColorLast := DummyCOl;
Invalidate;
end;


(*******************************************************************)
procedure TGradFill.SetColorLast(Value: TColor);
(*******************************************************************)

begin
FColorLast := Value;
Invalidate;
end;


(*******************************************************************)
procedure TGradFill.SetNrColors(Value: integer);
(*******************************************************************)

begin
if Value < 1 then
  Value := 1;
if Value > 255 then
  Value := 255;
FNrColors := Value;
Invalidate;
end;



(*******************************************************************)
procedure TGradFill.Paint;
(*******************************************************************)

var
  WorkBmp      : TBitmap;
  Rectang      : TRect;
  rgbFirst     : array[1..3] of Byte;    { Begin RGB values }
  rgbDelta     : array[1..3] of integer; { Difference between begin and end }
  i            : integer;
  R, G, B      : byte;
  CentX, CentY : longint;
  diagX, diagY : integer;
  ddx, ddy     : integer;
  p1x, p1y     : integer;
  p2x, p2y     : integer;
  hheight      : integer;
{$IFDEF SHAREWARE}
  astr         : string;
  j            : integer;
{$ENDIF}



begin
WorkBmp := TBitmap.Create; { Create the working bitmap and set its width and height }
WorkBmp.Width := Width;
WorkBmp.Height := Height;
rgbFirst[1] := GetRValue(ColorToRGB(FColorFirst));
rgbFirst[2] := GetGValue(ColorToRGB(FColorFirst));
rgbFirst[3] := GetBValue(ColorToRGB(FColorFirst));
rgbDelta[1] := GetRValue(ColorToRGB(FColorLast))-rgbFirst[1];
rgbDelta[2] := GetGValue(ColorToRGB(FColorLast))-rgbFirst[2];
rgbDelta[3] := GetBValue(ColorToRGB(FColorLast))-rgbFirst[3];
Canvas.Pen.Style := psSolid;
Canvas.Pen.Mode := pmCopy;
case FGradType of
  gtEllipticFit,
  gtEllipticFull : begin
                   with WorkBmp do
                     begin
                     CentX := Width div 2;
                     CentY := Height div 2;
                     DiagX := CentX;
                     DiagY := CentY;
                     if FGradType = gtEllipticFit
                       then begin
                            R := GetRValue(ColorToRGB(FColorLast));
                            G := GetGValue(ColorToRGB(FColorLast));
                            B := GetBValue(ColorToRGB(FColorLast));
                            Canvas.Brush.Color := RGB (R, G, B);
                            Canvas.Pen.Color := RGB (R, G, B);
                            Canvas.Rectangle (0,0,Width,Height);
                            end
                       else begin
                            diagX := 1+round(sqrt(2)*DiagX);
                            diagY := 1+round(sqrt(2)*DiagY);
                            end;
                     for i:=FNrColors-1 downto 0 do
                       begin
                       R := rgbFirst[1] + MulDiv (i, rgbDelta[1], FNrColors);
                       G := rgbFirst[2] + MulDiv (i, rgbDelta[2], FNrColors);
                       B := rgbFirst[3] + MulDiv (i, rgbDelta[3], FNrColors);
                       Canvas.Brush.Color := RGB (R, G, B);
                       Canvas.Pen.Color := RGB (R, G, B);
                       ddx := MulDiv (i, DiagX, FNrColors-1);
                       ddy := MulDiv (i, DiagY, FNrColors-1);
                       Canvas.Ellipse (CentX-ddx,CentY-ddy,CentX+ddx,CentY+ddy);
                       end;
                     end;
                   end;
        gtRadial : begin
                   with WorkBmp do
                     begin
                     CentX := Width div 2;
                     CentY := Height div 2;
                     DiagX := round (0.5*sqrt(1.0*Width*Width+1.0*Height*Height));
                     for i:=0 to FNrColors-1 do
                       begin
                       R := rgbFirst[1] + MulDiv (i, rgbDelta[1], FNrColors);
                       G := rgbFirst[2] + MulDiv (i, rgbDelta[2], FNrColors);
                       B := rgbFirst[3] + MulDiv (i, rgbDelta[3], FNrColors);
                       Canvas.Brush.Color := RGB (R, G, B);
                       Canvas.Pen.Color := RGB (R, G, B);
                       p1x := round(DiagX*sin(pi/FNrColors*i));
                       p1y := centY+round(DiagX*cos(pi/FNrColors*i));
                       p2x := round(DiagX*sin(pi/FNrColors*(i+1)));
                       p2y := centY+round(DiagX*cos(pi/FNrColors*(i+1)));
                       Canvas.Polygon ([Point(CentX,CentY),
                                        Point(CentX+p1x, p1y),
                                        Point(CentX+p2x, p2y)]);
                       Canvas.Polygon ([Point(CentX,CentY),
                                        Point(CentX-p1x, p1y),
                                        Point(CentX-p2x, p2y)]);
                       end;
                     end;
                   end;
      gtDiagGrid : begin
                   with WorkBmp do
                     begin
                     Rectang.Left := 0;
                     Rectang.Right := Width;
                     Rectang.Top := 0;
                     Rectang.Bottom := Height div 2;
                     R := rgbFirst[1];
                     G := rgbFirst[2];
                     B := rgbFirst[3];
                     Canvas.Brush.Color := RGB (R, G, B);
                     Canvas.FillRect (Rectang);
                     Rectang.Left := 0;
                     Rectang.Right := Width;
                     Rectang.Top := Height div 2;
                     Rectang.Bottom := Height;
                     R := GetRValue(ColorToRGB(FColorLast));
                     G := GetGValue(ColorToRGB(FColorLast));
                     B := GetBValue(ColorToRGB(FColorLast));
                     Canvas.Brush.Color := RGB (R, G, B);
                     Canvas.FillRect (Rectang);
                     hheight := Height div 4;
                     for i:=0 to hHeight do
                       begin
                       R := rgbFirst[1] + MulDiv (i, rgbDelta[1], hHeight);
                       G := rgbFirst[2] + MulDiv (i, rgbDelta[2], hHeight);
                       B := rgbFirst[3] + MulDiv (i, rgbDelta[3], hHeight);

                       Canvas.pen.color := RGB (R, G, B);
                       Canvas.MoveTo (0,i*2);
                       Canvas.LineTo (Width,i*2);
                       end;
                     for i:=0 to hHeight do
                       begin
                       R := rgbFirst[1] + MulDiv (i, rgbDelta[1], hHeight);
                       G := rgbFirst[2] + MulDiv (i, rgbDelta[2], hHeight);
                       B := rgbFirst[3] + MulDiv (i, rgbDelta[3], hHeight);

                       Canvas.pen.color := RGB (R, G, B);
                       Canvas.MoveTo (0,i*2+2*hheight-1);
                       Canvas.LineTo (Width,i*2+2*hheight-1);
                       end;
                     hheight := Width div 2;
                     for i:=0 to hheight do
                       begin
                       R := rgbFirst[1] + MulDiv (i, rgbDelta[1], hHeight);
                       G := rgbFirst[2] + MulDiv (i, rgbDelta[2], hHeight);
                       B := rgbFirst[3] + MulDiv (i, rgbDelta[3], hHeight);

                       Canvas.pen.color := RGB (R, G, B);
                       Canvas.MoveTo (i*2,0);
                       Canvas.LineTo (i*2,Height);
                       end;
                     end;
                   end;
         gtHoriz,
          gtVert : begin
                   with WorkBmp do
                     begin
                     Rectang.Left := 0;
                     Rectang.Right := Width;
                     Rectang.Top := 0;
                     Rectang.Bottom := Height;
                     for i := 0 to FNrColors-1 do
                       begin
                       case FGradType of
                         gtHoriz : begin
                                   Rectang.Top := MulDiv (i, Height, FNrColors);
                                   Rectang.Bottom := MulDiv (i+1, Height, FNrColors);
                                   end;
                          gtVert : begin
                                   Rectang.Left := MulDiv (i, Width, FNrColors);
                                   Rectang.Right := MulDiv (i+1, Width, FNrColors);
                                   end;
                       end;
                       if FNrColors > 1
                         then begin
                              R := rgbFirst[1] + MulDiv (i, rgbDelta[1], FNrColors);
                              G := rgbFirst[2] + MulDiv (i, rgbDelta[2], FNrColors);
                              B := rgbFirst[3] + MulDiv (i, rgbDelta[3], FNrColors);
                              end
                         else begin
                              R := rgbFirst[1];
                              G := rgbFirst[2];
                              B := rgbFirst[3];
                              end;
                       Canvas.Brush.Color := RGB (R, G, B);
                       Canvas.FillRect (Rectang);
                       end;
                     end;
                   end;
  gtMidBandHoriz,
   gtMidBandVert : begin
                   with WorkBmp do
                     begin
                     Rectang.Left := 0;
                     Rectang.Right := Width;
                     Rectang.Top := 0;
                     Rectang.Bottom := Height;
                     for i := 0 to FNrColors-1 do
                       begin
                       case FGradType of
                         gtMidBandHoriz : begin
                                          Rectang.Top := MulDiv (i, Height, FNrColors);
                                          Rectang.Bottom := MulDiv (i+1, Height, FNrColors);
                                          end;
                          gtMidBandVert : begin
                                          Rectang.Left := MulDiv (i, Width, FNrColors);
                                          Rectang.Right := MulDiv (i+1, Width, fnrcolors);
                                          end;
                       end;
                       if i <= (FNrColors div 2)
                         then begin
                              R := rgbFirst[1] + MulDiv (i, rgbDelta[1], FNrColors div 2);
                              G := rgbFirst[2] + MulDiv (i, rgbDelta[2], FNrColors div 2);
                              B := rgbFirst[3] + MulDiv (i, rgbDelta[3], FNrColors div 2);
                              end
                         else begin
                              R := rgbFirst[1] + MulDiv (FNrColors-i-1, rgbDelta[1], FNrColors div 2);
                              G := rgbFirst[2] + MulDiv (FNrColors-i-1, rgbDelta[2], FNrColors div 2);
                              B := rgbFirst[3] + MulDiv (FNrColors-i-1, rgbDelta[3], FNrColors div 2);
                              end;
                       Canvas.Brush.Color := RGB (R, G, B);
                       Canvas.FillRect (Rectang);
                       end;
                     end;
                   end;
end;

Canvas.Draw(0, 0, WorkBmp);
WorkBmp.Free;
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


(*******************************************************************)
procedure TGradFill.SeTGradType(Value: TGradType);
(*******************************************************************)

begin
if Value <> FGradType then
  begin
  FGradType := Value;
  Invalidate;
  end;
end;


(*******************************************************************)
procedure Register;
(*******************************************************************)

begin
RegisterComponents('SDL', [TGradFill]);
end;

end.



