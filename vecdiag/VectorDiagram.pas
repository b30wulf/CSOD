Unit VectorDiagram;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Math;

Const
  pi2               = 2 * pi;
Type
  TDiagramVector = Class(TPersistent)
  public
    Name : String;
    Value : Double;
    Angle : Double;
    Pen : TPen;
  End;

  TLegendModes = (lmNone, lmTop, lmLinked, lmTopLinked);

  TVectorDiagram = Class(TGraphicControl)
  private
    { Private declarations }
    FRadius : integer;
    FCentr : TPoint;
    FMax : double;
    FVectors : TList;
    FLMode : TLegendModes;
    FLHeight : integer;
    FLTextStart : TPoint;
    FGrid : TPen;
    FMaxVal : Double;
    FFixPhase : Integer;
    Procedure DrawVectors(Canv : TCanvas);
    Function getVector(index : integer) : TDiagramVector;
    Procedure setVector(index : integer; value : TDiagramVector);
    Function getVCount : integer;
    Procedure setVCount(value : integer);
    Procedure DrawVector(Canv : TCanvas; Xo, Yo, num : integer);
    Procedure SetGrid(value : TPen);
    Procedure SetLegendMode(value : TLegendModes);
    Procedure SetMaxVal(value : Double);
    Procedure SetFixPhase(value : Integer);
    Procedure DoMouseDown(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
    { Protected declarations }
  public
    { Public declarations }
    Constructor Create(AOwner : TComponent); override;
    Destructor Destroy; override;
    Procedure Draw(Sender : TObject);
    Procedure Paint; override;
    Property Vectors[index : integer] : TDiagramVector read getVector write setVector;
  published
//    Property OnMouseDown;
    Property Font;
    Property Hint;
    Property Align;
    Property Visible;
    Property ShowHint;
    Property PopupMenu;
    Property Anchors;
    Property Constraints;
    { Published declarations }
    Property VectorsCount : integer read GetVCount write SetVCount default 6;
    Property LegendMode : TLegendModes read FLMode write SetLegendMode stored True;
    Property Grid : TPen read FGrid write SetGrid stored True;
    Property MaxVal : Double read FMaxVal write SetMaxVal stored True;
    Property FixPhase : Integer read FFixPhase write SetFixPhase stored True default 0;
  End;

Procedure Register;
//=======================================================
Implementation

Const
  cminvec           = 0.3;
//=======================================================

Procedure Register;
Begin
  RegisterComponents('Utl', [TVectorDiagram]);
End;
//=======================================================
// TVectorDiagram
//=======================================================

Constructor TVectorDiagram.Create(AOwner : TComponent);
Begin                                   //
  Inherited;
  FVectors := TList.Create;
  VectorsCount := 6;
  Align := alClient;
  FGrid := TPen.Create;
  FGrid.Color := clGray;
  FGrid.Style := psDot;
  FMaxVal := 0.0;
  FFixPhase := 0;
  OnMouseDown := DoMouseDown;
End;
//-------------------------------------

Destructor TVectorDiagram.Destroy;
Begin
  FGrid.Free;
  VectorsCount := 0;
  FVectors.Destroy;
  Inherited;
End;
//=======================================================

Function TVectorDiagram.getVector(index : integer) : TDiagramVector;
Begin                                   //
  result := FVectors.Items[index];
End;
//-------------------------------------

Procedure TVectorDiagram.setVector(index : integer; value : TDiagramVector);
Begin
  TDiagramVector(FVectors.Items[index]).assign(value);
  invalidate;
End;

Procedure TVectorDiagram.SetMaxVal(value : Double);
Begin
  If (Value <> FMaxVal) And (Value >= 0) Then Begin
    FMaxVal := Value;
    invalidate;
  End;
End;

//-------------------------------------

Procedure TVectorDiagram.setGrid(value : TPen);
Begin
//  FGrid := Value;                       //.Assign(Value);
  FGrid.Assign(Value);
  invalidate;
End;

Procedure TVectorDiagram.SetLegendMode(value : TLegendModes);
Begin
  If FLMode <> Value Then Begin
    FLMode := Value;
    invalidate;
  End;
End;

Procedure TVectorDiagram.SetFixPhase(value : integer);
Begin
  If FFixPhase <> Value Then Begin
    FFixPhase := Value;
    invalidate;
  End;
End;

Function TVectorDiagram.getVCount : integer;
Begin                                   //
  result := FVectors.Count;
End;
//-------------------------------------

Procedure TVectorDiagram.setVCount(value : integer);
Var
  c                 : integer;
  tmp               : TDiagramVector;
Begin
  If (value < 0) Or (value = FVectors.Count) Then exit;
  c := FVectors.Count;
  While Value > c Do Begin
    tmp := TDiagramVector.Create;
    tmp.Pen := TPen.Create;
    tmp.Name := '';
    tmp.Value := 0;
    tmp.Angle := 0;
    tmp.Pen.Color := clBlack;
    FVectors.Add(tmp);
    inc(c);
  End;
  While Value < c Do Begin
    dec(c);
    tmp := Vectors[c];
    tmp.Pen.Free;
    FVectors.Delete(c);
    tmp.Destroy;
  End;
  Repaint;
End;
//-------------------------------------

Procedure TVectorDiagram.DrawVector(Canv : TCanvas; Xo, Yo, num : integer);
Const
  cAar              = 10 * pi / 180;
Var
  x, y              : integer;
  alpha, v, rad     : double;
  da, dl            : integer;
  s                 : String;

  Procedure dArrow(canvas : TCanvas; x, y, d : integer; a : double);
  Begin
    canvas.MoveTo(x, y);
    canvas.LineTo(x + Round(d * cos(a)), y - Round(d * sin(a)));
  End;

Begin
  If (FFixPhase > 0) And (FFixPhase <= FVectors.Count) Then
    alpha := -Vectors[num].Angle + Vectors[FFixPhase - 1].Angle + 0.5 * pi
  Else
    alpha := -Vectors[num].Angle + 0.5 * pi;

  V := Vectors[num].value;

  If V > 0 Then Begin

    rad := FRadius / FMax * v;

    x := Xo + Round(rad * COS(alpha));
    y := Yo - Round(rad * SIN(alpha));

    dl := Round(rad);

    Canv.pen := Vectors[num].pen;

    //vector
    Canv.MoveTo(Xo, Yo);
    Canv.LineTo(x, y);

    // arrow
    da := MIN(8, dl - 5);

    darrow(Canv, x, y, da, alpha + caar + pi);
    darrow(Canv, x, y, da, alpha - caar + pi);

      //label
    If FLMode In [lmLinked, lmTopLinked] Then Begin

      s := ' ' + Vectors[num].Name;     // + '= ' + FloatToStrF(Vectors[num].value, ffFixed, 8, 2) + ' ';

      If x < FCentr.x Then x := x - Canv.TextWidth(s) + 2;
      If y <= FCentr.y Then y := y - Canv.TextHeight(s) - 2;

      Canv.Font.color := Vectors[num].Pen.color;

      Canv.TextOut(x, y, s);

    End;

  End;

End;
//=======================================================

Procedure TVectorDiagram.DrawVectors(Canv : TCanvas);
Var
  i                 : integer;
Begin                                   //
  If Not Assigned(Canv) Then exit;

  If FVectors.Count > 0 Then
    For i := 0 To FVectors.Count - 1 Do
      DrawVector(canv, FCentr.x, FCentr.y, i);
End;
//-------------------------------------

Procedure TVectorDiagram.Draw(Sender : TObject);
Const
  pi2               = 2 * pi;
Var
  W, i, x, y, ofs, M : integer;
  s                 : String;
  arad, rad         : double;
  r                 : TRect;
  Canv              : TCanvas;
  Val               : double;
Begin
  canv := Nil;

  If Not Assigned(Sender) Then exit;

  Try
    If (Sender Is TBiTMap) Then Begin
      (Sender As TBiTMap).Width := ClientRect.Right - ClientRect.Left;
      (Sender As TBiTMap).Height := ClientRect.Bottom - ClientRect.Top;
      canv := (Sender As TBiTMap).Canvas;
    End Else
      If (Sender Is TCanvas) Then canv := (Sender As TCanvas);
  Except
  End;

  If (FMaxVal <= 0.0) And (FVectors.Count > 0) Then Begin
    FMax := Vectors[0].Value;
    For i := 1 To FVectors.Count - 1 Do Begin
      Val := abs(Vectors[i].Value);
      If FMax < Val Then FMax := Val;
    End;
  End Else
    FMax := FMaxVal;

  If Assigned(canv) Then Try

    If FLMode In [lmTop, lmTopLinked] Then FLHeight := 100 Else FLHeight := 0;

    W := Width - FLHeight;

    FRadius := MIN(Height, W) Div 2 - 16;

    FCentr.x := W Div 2 + FlHeight - 32;
    FCentr.y := Height Div 2;

    Canv.Font := Font;

    With Canv Do Begin

      brush.Style := bsClear;

      pen := FGrid;

      moveto(FCentr.x, FCentr.y);
      lineTo(FCentr.x, FCentr.y - FRadius - 4);

      rad := FRadius + 4;
      arad := (120 + 90) / 180 * pi;
      x := FCentr.x + Round(rad * COS(arad));
      y := FCentr.Y - Round(rad * SIN(arad));

      moveto(FCentr.x, FCentr.y);
      lineTo(x, y);

      TextOut(x - TextWidth('-120'), y - TextHeight('-120') Div 2, '-120');

      rad := FRadius + 6;
      arad := (-120 + 90) / 180 * pi;
      x := FCentr.x + Round(rad * COS(arad));
      y := FCentr.Y - Round(rad * SIN(arad));

      moveto(FCentr.x, FCentr.y);
      lineTo(x, y);

      TextOut(x + 2, y - TextHeight('120') Div 2, '120');

      For I := 1 To 5 Do Begin
        ofs := Round(FRadius / 5 * I);
        Ellipse(FCentr.x - ofs, FCentr.y - ofs, FCentr.x + ofs, FCentr.y + ofs);
        If FMax < 10 Then
          TextOut(FCentr.x + 2, FCentr.y - ofs - TextHeight('0') Div 2, FloatToStrF(FMax / 5 * I, ffFixed, 8, 2))
        Else If FMax < 100 Then
          TextOut(FCentr.x + 2, FCentr.y - ofs - TextHeight('0') Div 2, FloatToStrF(FMax / 5 * I, ffFixed, 8, 1))
        Else
          TextOut(FCentr.x + 2, FCentr.y - ofs - TextHeight('0') Div 2, FloatToStrF(FMax / 5 * I, ffFixed, 8, 0));
      End;

      pen.Style := psSolid;

      DrawVectors(canv);

      // labels
      If FLMode In [lmTop, lmTopLinked] Then Begin

        FLTextStart.x := 2;
        FLTextStart.y := 2;

        For i := 0 To VectorsCount - 1 Do Begin

          If (FFixPhase > 0) And (FFixPhase <= FVectors.Count) Then
            Val := Vectors[i].Angle - Vectors[FFixPhase - 1].Angle
          Else
            Val := Vectors[i].Angle;

          arad := (Val - pi2 * Trunc(Val / pi2)) * 180 / pi;
          If arad > 180.5 Then arad := arad - 360;
          If arad < -180.5 Then arad := arad + 360;

          s := Vectors[i].Name + ' ='
//            + FloatToStrF(Vectors[i].Value, ffFixed, 8, 2) + ' '
            + FloatToStrF(arad, ffFixed, 8, 0) + '°';

          Font.Color := Vectors[i].Pen.Color;

          TextOut(FLTextStart.x, FLTextStart.y + i * (Font.Size + 3), s);

        End;

      End;

    End;

  Except
  End;
End;

Function PointToRad(Const APoint, ACenter : TPoint) : Double;
Var
  N                 : Integer;
Begin
  N := APoint.X - ACenter.X;

  If N = 0 Then
    If APoint.Y <= ACenter.Y Then
      Result := 90
    Else
      Result := -90
  Else
    Result := -RadToDeg(ArcTan2((APoint.Y - ACenter.Y), N));
End;

Procedure TVectorDiagram.DoMouseDown(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
Var
  I                 : Integer;
  A, B, arad        : double;
Begin    (*
  A := PointToRad(Point(X, Y), FCentr);

  If A <= 90 Then a := 90 - a
  Else A := 360 + 90 - A;

  If FFixPhase > 0 Then begin
    A := A + RadToDeg(Vectors[FFixPhase - 1].Angle);
    if A > 360 then A :=  A - 360;
  end;

  For I := 1 To FVectors.Count Do Begin
    B := RadToDeg(Vectors[I - 1].Angle);
    If Abs(A - B) < 5 Then Begin
      FFixPhase := I;
      Break;
    End;
  End;

  Invalidate;
   *)
End;

Procedure TVectorDiagram.Paint;
Begin
  Inherited;
  Draw(Canvas)
End;

//=======================================================
End.

