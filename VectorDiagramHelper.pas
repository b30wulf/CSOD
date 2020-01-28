{**
 * Project:     Konus-2000E
 * File:        VectorDiagramHelper.pas
 * Description: Хелпер для отрисовки векторной диаграммы на TCanvas
 *
 * Delphi version 5
 *
 * Category    Helpers
 * Package     Utils
 * Author      Petrushevitch Roman <ukrop.gs@gmail.com>
 * Author:     $Author: Ukrop $
 * Copyright   2008-2012 Automation-2000, LLC
 *
 * License     Private Licence
 * Version:    2.3.33.764 SVN: $Id: VectorDiagramHelper.pas 46 2012-06-03 15:23:23Z Ukrop $
 * Link        Helpers/VectorDiagramHelper
 *}

 unit VectorDiagramHelper;


interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Math;

type
  TOneVector = record
    Name          : String;  // название
    SubName       : String;  // индекс
    Value         : Double;  // значение
    Angle         : Double;  // угол
    Linked        : Integer; // связванный вектор, для построения угла
    NormalizeGroup: Integer; // группа нормализации
    Pen           : TPen;    // карандаш
  End;

  TLegendModes = (lmNone, lmTop, lmLinked, lmTopLinked);

  TVectorDiagramHelper = class
  private
    m_LabelsFont       : TFont;
    m_IsDrawingEnabled : Boolean;

    //m_Vectors          : array of TOneVector;
    m_VectorsCount     : BYTE;
    m_Surface          : TCanvas;
    m_SideLenght       : Integer;
    m_Circles          : Integer;
    m_DrawDecartCross  : Boolean;
    m_DrawCirclesRadius: Boolean;
    m_DrawUIAngles     : Boolean;
    m_Draw30Angles     : Boolean;
    m_30AnglesCount    : Integer;
    m_Normalize        : Boolean;
    m_NormalizeGroupsCount : Integer;
    m_NormalizeGroupsMax : array of Double;

    m_Radius : integer;
    m_O : TPoint;

    m_LMode : TLegendModes;
    m_LHeight : integer;
    m_LTextStart : TPoint;
    m_GridPen : TPen;
    m_FixPhase : Integer;

    // methods +
    function  GetVector(_Index : Integer) : TOneVector;
    procedure SetVector(_Index : Integer; _Value : TOneVector);
    procedure SetVectorsCount(_VectorsCount : BYTE);

    procedure DrawVectors(Canv : TCanvas);
    procedure DrawAngles(_Canvas : TCanvas);


    procedure DrawVector(Canv : TCanvas; Xo, Yo, num : integer);
    procedure SetGrid(value : TPen);
    procedure SetLegendMode(value : TLegendModes);
    procedure SetFixPhase(value : Integer);
  public
    m_Vectors          : array of TOneVector;
    constructor Create();
    destructor  Destroy; override;
    procedure   UseBitmap(_BitMap : TCanvas);
    function    GetMult(_Angle: Integer): TPoint;
    procedure   Draw(Sender : TObject);
    procedure   Paint;

//    property Vectors[_Index : Integer] : TOneVector read GetVector       write SetVector;
    property VectorsCount              : BYTE    read m_VectorsCount write SetVectorsCount;
    property Font : TFont read m_LabelsFont write m_LabelsFont;
    property Enabled : Boolean read m_IsDrawingEnabled write m_IsDrawingEnabled;
    property LegendMode : TLegendModes read m_LMode write SetLegendMode;
    property Grid : TPen read m_GridPen write SetGrid stored True;
    property FixPhase : Integer read m_FixPhase write SetFixPhase;
    property SideLenght : Integer read m_SideLenght write m_SideLenght;
    property Circles : Integer read m_Circles write m_Circles;
    property DrawDecartCross : Boolean read m_DrawDecartCross write m_DrawDecartCross;
    property DrawCirclesRadius : Boolean read m_DrawCirclesRadius write m_DrawCirclesRadius;
    property Draw30Angles : Boolean read m_Draw30Angles write m_Draw30Angles;
    property DrawUIAngles : Boolean read m_DrawUIAngles write m_DrawUIAngles;    
    property Normalize : Boolean read m_Normalize write m_Normalize;
  End;

const
  pi2  = 2 * pi;
  cAar = 15/180 * pi;

implementation

(**
 *  Конструктор
 *)
constructor TVectorDiagramHelper.Create();
begin
  m_SideLenght := 800;
  m_SideLenght := 800;
  m_30AnglesCount := 12;
  SetVectorsCount(6);
  m_LabelsFont := TFont.Create();
  m_LabelsFont.Color := clBlack;
  m_LabelsFont.Size := 16;
  m_LabelsFont.Name := 'Arial Cyr';
  m_Circles := 1;
  SetLegendMode(lmLinked);

  m_GridPen := TPen.Create();
  m_GridPen.Width := 2;
  m_GridPen.Color := clBlack;
  m_GridPen.Style := psSolid;

  m_FixPhase := 0;
end;

(**
 *  Деструктор
 *)
destructor TVectorDiagramHelper.Destroy();
begin
  m_GridPen.Free();
  m_LabelsFont.Free();
  SetVectorsCount(0);
end;

(**
 *  Задание поверхности рисования
 *
 *  @param _BitMap : TCanvas Поверхность рисования
 *)
procedure TVectorDiagramHelper.UseBitmap(_BitMap : TCanvas);
begin
  m_Surface := _BitMap;
end;

(**
 *  Получение струкуры вектора по его номеру
 *
 *  @param  _Index : Integer Индекс вектора на диаграмме
 *
 *  @return TOneVector Вектор
 *)
function TVectorDiagramHelper.GetVector(_Index : Integer) : TOneVector;
begin
  Result := m_Vectors[_Index];
end;

(**
 *  Установка нового значения вектора по его номеру
 *
 *  @param  _Index : Integer Индекс вектора на диаграмме
 *  @param  _Value : TOneVector Новое значение вектора
 *
 *  @return void
 *)
procedure TVectorDiagramHelper.SetVector(_Index : Integer; _Value : TOneVector);
begin
  m_Vectors[_Index] := _Value;
end;

(*
 *
 *)
procedure TVectorDiagramHelper.setGrid(value : TPen);
Begin
  m_GridPen.Assign(Value);
End;

(*
 *
 *)
procedure TVectorDiagramHelper.SetLegendMode(value : TLegendModes);
Begin
  If m_LMode <> Value Then Begin
    m_LMode := Value;
  End;
End;

(*
 *
 *)
procedure TVectorDiagramHelper.SetFixPhase(value : integer);
Begin
  If m_FixPhase <> Value Then Begin
    m_FixPhase := Value;
  End;
End;


procedure TVectorDiagramHelper.SetVectorsCount(_VectorsCount : BYTE);
var
  l_VectorID : Byte;
begin
  m_NormalizeGroupsCount := _VectorsCount;
  SetLength(m_NormalizeGroupsMax, m_NormalizeGroupsCount);
  if (_VectorsCount > m_VectorsCount) then
  begin
    SetLength(m_Vectors, _VectorsCount);
    for l_VectorID:=m_VectorsCount to _VectorsCount-1 do
    begin
      m_Vectors[l_VectorID].Name := '';
      m_Vectors[l_VectorID].Value := 0;
      m_Vectors[l_VectorID].Angle := 0;
      m_Vectors[l_VectorID].Pen := TPen.Create();
      m_Vectors[l_VectorID].Pen.Color := clBlack;
      m_Vectors[l_VectorID].Pen.Width := 3;
    end;
    m_VectorsCount := _VectorsCount;
  end else if (_VectorsCount < m_VectorsCount) then
  begin
    for l_VectorID:=m_VectorsCount downto _VectorsCount-1 do
      m_Vectors[l_VectorID].Pen.Free();
    SetLength(m_Vectors, _VectorsCount);
    m_VectorsCount := _VectorsCount;
  end;
End;

(**
 *
 *)
procedure TVectorDiagramHelper.DrawVector(Canv : TCanvas; Xo, Yo, num : integer);
var
  x, y          : integer;
  alpha, v, rad : double;
  l_LastFontSize : Integer;
  procedure dArrow(canvas : TCanvas; x, y, d : integer; a : double);
  begin
    canvas.MoveTo(x, y);
    canvas.LineTo(x + Round(d * cos(a)), y - Round(d * sin(a)));
  end;
begin
  if (m_FixPhase > 0) And (m_FixPhase <= m_VectorsCount) then
    alpha := -m_Vectors[num].Angle + m_Vectors[m_FixPhase - 1].Angle + 0.5 * pi
  else
    alpha := -m_Vectors[num].Angle + 0.5 * pi;

  V := m_Vectors[num].value;

  if (V > 0) then
  begin
    rad := 0.5*m_Radius*(1-0.1*m_Vectors[num].NormalizeGroup)*(1+ v);
    x := Xo + Round(rad * COS(alpha));
    y := Yo - Round(rad * SIN(alpha));

    Canv.Pen.Assign(m_Vectors[num].Pen);

    //vector
    Canv.MoveTo(Xo, Yo);
    Canv.LineTo(x, y);

    // arrow
    darrow(Canv, x, y, 15, alpha + caar + pi);
    darrow(Canv, x, y, 15, alpha - caar + pi);

    //label
    if (m_LMode In [lmLinked, lmTopLinked]) then
    begin
      // координаты середины текста
      x := Xo + Round(3*rad/4 * COS(alpha));
      y := Yo - Round(3*rad/4 * SIN(alpha));
      if (x < m_O.x)  then     x := Xo + Round(3*rad/4 * COS(alpha)); //x := x - Canv.TextWidth(s) + 2;
      if (y <= m_O.y) then     y := Yo - Round(3*rad/4 * SIN(alpha)); //y := y - Canv.TextHeight(s) + 2;

//      TextOut(x1, y1, IntToStr(i*30)+'°');
     Canv.MoveTo(Xo, Yo);
      // координаты верхнего левого угла текста
      Xo := x - Canv.TextWidth(m_Vectors[num].Name) div 2;
      Yo := y - Canv.TextHeight(m_Vectors[num].Name) div 2;

      Canv.Font.Color := m_Vectors[num].Pen.Color;
      Canv.Brush.Color:=clWhite;
      Canv.TextOut(Xo, Yo, m_Vectors[num].Name);
      if (m_Vectors[num].SubName <> '') then
      begin
        l_LastFontSize := Canv.Font.Size;
        Canv.Font.Size := m_LabelsFont.Size - 2;
        Canv.TextOut(Canv.PenPos.x, Canv.PenPos.y + Canv.TextHeight(m_Vectors[num].Name) div 2, m_Vectors[num].SubName);
        Canv.Font.Size := l_LastFontSize;
      end;
    end;
  end;
end;

(**
 *  Рисование векторов на канвасе
 *
 *  @param Canv : TCanvas Канвас
 *)
procedure TVectorDiagramHelper.DrawVectors(Canv : TCanvas);
var
  i,c : Integer;
  l_LinkedWith  : Integer; // номер связанного вектора
  l_Mults,l_Mults2 : TPoint;
  l_LastFontSize, m : Integer;
  l_DeltaAngle: Double;
  l_DeltaAngleStr: String[10];
//  r : integer;
begin
{
procedure TForm1.FormPaint(Sender: TObject);
var
  lbrush : LOGBRUSH;
  userstyle : array of DWORD;
begin
with canvas do
begin
lbrush.lbStyle := BS_SOLID;
lbrush.lbColor := 255;
lbrush.lbHatch := 0;

setlength(userstyle,2);
userstyle[0] := 5;
userstyle[1] := 5;

Canvas.Pen.Handle := ExtCreatePen(PS_GEOMETRIC or PS_USERSTYLE or PS_ENDCAP_FLAT, 5, lbrush, 2, userstyle);
Canvas.MoveTo(50, 50);
Canvas.LineTo(50, 100);
Canvas.LineTo(100, 100);
Canvas.LineTo(100, 50);
Canvas.LineTo(50, 50);
end;
end;
}
  if not Assigned(Canv) then exit;

  if m_VectorsCount > 0 then
  begin
    for i:=0 to m_VectorsCount-1 do
      DrawVector(canv, m_O.x, m_O.y, i);
    m_Radius := m_SideLenght div 2 - 100;


    Canv.Pen.Width := 2;
    Canv.Pen.Color := clBlack;
    Canv.Pen.Style := psDot;
    Canv.Pen.Mode:= pmWhite;

    c:=10;
    for i:=0 to m_VectorsCount-1 do
    begin
      m :=trunc(m_Radius/30*c);//trunc(m_Radius*c*2/(m_VectorsCount));
      inc(c,2);
      l_LinkedWith := m_Vectors[i].Linked;
      l_Mults := GetMult(trunc(m_Vectors[i].Angle));
      if (l_LinkedWith >0) then
      begin
        l_Mults2:= GetMult(trunc(m_Vectors[l_LinkedWith].Angle));
        Canv.Pen.Assign(m_Vectors[i].Pen);
        Canv.Font.Color := m_Vectors[i].Pen.Color;
        if (m_Vectors[l_LinkedWith].Angle < m_Vectors[i].Angle) then
          Canv.Arc(
            m_O.x-m, m_O.y-m, m_O.x+m,m_O.y+m,
            trunc(m_O.x+l_Mults.x*m*sin(m_Vectors[i].Angle)), m_O.y+l_Mults.y*trunc(m*cos(m_Vectors[i].Angle)),
            trunc(m_O.x+l_Mults2.x*m*sin(m_Vectors[l_LinkedWith].Angle)), m_O.y+l_Mults2.y*trunc(m*cos(m_Vectors[l_LinkedWith].Angle))
            )
        else
          Canv.Arc(
            m_O.x-m, m_O.y-m, m_O.x+m,m_O.y+m,
            trunc(m_O.x+l_Mults2.x*m*sin(m_Vectors[l_LinkedWith].Angle)), m_O.y+l_Mults2.y*trunc(m*cos(m_Vectors[l_LinkedWith].Angle)),
            trunc(m_O.x+l_Mults.x*m*sin(m_Vectors[i].Angle)), m_O.y+l_Mults.y*trunc(m*cos(m_Vectors[i].Angle))
            );
      l_LastFontSize := Canv.Font.Size;
      Canv.Font.Size := m_LabelsFont.Size;
      l_DeltaAngle :=m_Vectors[i].Angle - m_Vectors[l_LinkedWith].Angle;
      l_DeltaAngleStr := FloatToStrF(abs(l_DeltaAngle*180/pi), ffFixed, 18, 0)+'°';
      Canv.TextOut(
        m_O.x+l_Mults.x*trunc(m*sin(m_Vectors[l_LinkedWith].Angle+l_DeltaAngle/2) -l_Mults.x*(Canv.TextWidth(l_DeltaAngleStr) div 2)),
        m_O.y+l_Mults.y*trunc(m*cos(m_Vectors[l_LinkedWith].Angle+l_DeltaAngle/2) - l_Mults.y*(Canv.TextHeight(l_DeltaAngleStr) div 2)),
        l_DeltaAngleStr
      );
      Canv.Font.Size := l_LastFontSize;
    end;      
    end;

    Canv.Pen.Width := 3;
    Canv.Pen.Color := clPurple;
//        x := Xo + Round(rad * COS(alpha));
  //  y := Yo - Round(rad * SIN(alpha));
  {
  !!!!!!!!!!!
  Canv.Rectangle(m_O.x-m_Radius, m_O.y-m_Radius, m_O.x+m_Radius,m_O.y+m_Radius);
  Canv.Ellipse(m_O.x-m_Radius+3, m_O.y-m_Radius+3, m_O.x+m_Radius-3,m_O.y+m_Radius-3);
  Canv.MoveTo(m_O.x,m_O.y);
  Canv.LineTo(trunc(m_O.x+m_Radius*sin(m_Vectors[0].Angle)), m_O.y-trunc(m_Radius*cos(m_Vectors[0].Angle)));
  Canv.LineTo(trunc(m_O.x+m_Radius*sin(m_Vectors[3].Angle)), m_O.y-trunc(m_Radius*cos(m_Vectors[3].Angle)));
  }
//    Canv.Arc(m_O.x-m_Radius, m_O.y-m_Radius, m_O.x+m_Radius,m_O.y+m_Radius, round(m_O.x+300*cos(Vectors[1].Angle)), round(m_O.x+300*sin(Vectors[1].Angle)), round(m_O.x+300*cos(Vectors[3].Angle)), round(m_O.x+300*sin(Vectors[3].Angle)));
  end;


end;


(**
 *  Рисование векторов на канвасе
 *
 *  @param Sender : TObject Канвас или Bitmap
 *)
procedure TVectorDiagramHelper.Draw(Sender : TObject);
var
  W, i, x, y,ofs : integer;
  s          : String;
  arad, rad  : double;
  Canv       : TCanvas;
  Val        : double;
Begin
  canv := Nil;

  if not Assigned(Sender) then exit;

  try
    if (Sender is TBitmap) then
    begin
      (Sender As TBitmap).Width  := m_SideLenght;
      (Sender As TBitmap).Height := m_SideLenght;
      canv := (Sender As TBitmap).Canvas;
    end else if (Sender is TCanvas) then
      canv := (Sender As TCanvas);
  except
  end;

  if Assigned(canv) then
    try
      if (m_LMode In [lmTop, lmTopLinked]) then
        m_LHeight := 100
      else
        m_LHeight := 0;
  Canv.Font.Assign(m_LabelsFont);
  
  W := m_SideLenght - m_LHeight;
  //Canv.TextOut(0,0,'360°');
  m_Radius := (MIN(m_SideLenght, W)) Div 2- Canv.TextWidth('360°') - 5;

  m_O.x := m_SideLenght Div 2;
  m_O.y := m_SideLenght Div 2;

  // рисовать декартовые координаты +90
  if (m_DrawDecartCross) then
  begin
    Canv.pen.Style := psSolid;
    Canv.pen.Color := clBlack;
    Canv.pen.Width := 1;
    Canv.MoveTo(m_O.x - m_Radius - 5, m_O.y);
    Canv.LineTo(m_O.x + m_Radius + 5, m_O.y);

    Canv.MoveTo(m_O.x, m_O.y - m_Radius - 5);
    Canv.LineTo(m_O.x, m_O.y + m_Radius + 5);
  end;

  with Canv do
  begin
    DrawAngles(Canv);    
    Brush.Style := bsClear;
    Pen := m_GridPen;
    MoveTo(m_O.x, m_O.y);
    LineTo(m_O.x, m_O.y - m_Radius - 5);
    //TextOut(m_O.x, m_O.y - m_Radius - 5 - TextHeight('0°'), '0°');

    rad := m_Radius + 4;
    arad := (120 + 90) / 180 * pi;
    x := m_O.x + Round(rad * COS(arad));
    y := m_O.Y - Round(rad * SIN(arad));

    MoveTo(m_O.x, m_O.y);
    LineTo(x, y);
    //TextOut(x - TextWidth('-120°') - 5, y + TextHeight('-120°'), '-120°');

    rad := m_Radius + 6;
    arad := (-120 + 90) / 180 * pi;
    x := m_O.x + Round(rad * COS(arad));
    y := m_O.Y - Round(rad * SIN(arad));

    MoveTo(m_O.x, m_O.y);
    LineTo(x, y);
    //TextOut(x + 5, y + TextHeight('120°'), '120°');


    if (m_Circles > 0) then
      for i:=m_Circles downto 1 do
      begin
        ofs := Round(m_Radius / m_Circles * i);
        Ellipse(m_O.x - ofs, m_O.y - ofs, m_O.x + ofs, m_O.y + ofs);
        if (m_DrawCirclesRadius) then
          TextOut(m_O.x + 2, m_O.y - ofs - TextHeight('0') Div 2, FloatToStrF(m_Radius / m_Circles * I, ffFixed, 8, 2));
        {
        Else If m_Max < 100 Then
          TextOut(m_O.x + 2, m_O.y - ofs - TextHeight('0') Div 2, FloatToStrF(m_Max / 5 * I, ffFixed, 8, 1))
        Else
          TextOut(m_O.x + 2, m_O.y - ofs - TextHeight('0') Div 2, FloatToStrF(m_Max / 5 * I, ffFixed, 8, 0));
        }
      end;


    Pen.Style := psSolid;
    DrawVectors(canv);

    // labels
    if (m_LMode in [lmTop, lmTopLinked]) then
    begin
      m_LTextStart.x := 2;
      m_LTextStart.y := 2;

      for i:=0 to m_VectorsCount-1 do
      begin
        if (m_FixPhase > 0) and (m_FixPhase <= m_VectorsCount) then
          Val := m_Vectors[i].Angle - m_Vectors[m_FixPhase - 1].Angle
        else
          Val := m_Vectors[i].Angle;

        arad := (Val - pi2 * Trunc(Val / pi2)) * 180 / pi;
        if arad > 180.5  then arad := arad - 360;
        if arad < -180.5 then arad := arad + 360;
        s := m_Vectors[i].Name + ' = ' + FloatToStrF(arad, ffFixed, 8, 0) + '°'; // + FloatToStrF(Vectors[i].Value, ffFixed, 8, 2) + ' '

        m_LabelsFont.Color := m_Vectors[i].Pen.Color;
        TextOut(m_LTextStart.x, m_LTextStart.y + i * (m_LabelsFont.Size + 2), s);
      end;
    end;
  end;
  except
  end;
End;

function PointToRad(Const APoint, ACenter : TPoint) : Double;
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


procedure TVectorDiagramHelper.Paint;
var
  i,n : Integer;
  r : TRect;
begin
  r.Top := 0;
  r.Left := 0;
  r.Bottom:= m_SideLenght;
  r.Right:= m_SideLenght;
  
  m_Surface.Rectangle(r);

  for n := 0 to m_NormalizeGroupsCount-1 do
  begin
    m_NormalizeGroupsMax[n] := 0;
    for i := 0 to m_VectorsCount-1 do
    begin
      if (m_Vectors[i].NormalizeGroup = n) AND (m_Vectors[i].Value> m_NormalizeGroupsMax[n]) then
        m_NormalizeGroupsMax[n] := m_Vectors[i].Value;
    end;
  end;

  if (m_Normalize) then
    for n := 0 to m_NormalizeGroupsCount-1 do
    for i := 0 to m_VectorsCount-1 do
    begin
      if (m_Vectors[i].NormalizeGroup = n) then
      if (m_NormalizeGroupsMax[n] <> 0) then
        m_Vectors[i].Value := m_Vectors[i].Value / m_NormalizeGroupsMax[n]
      else
        m_Vectors[i].Value := 1;

    end;

  Draw(m_Surface);
end;

function TVectorDiagramHelper.GetMult(_Angle: Integer): TPoint;
begin
  Result.x := 1;
  Result.y := 1;
  
  if (-90 <= _Angle) and (_Angle<0) then
  begin
    Result.x := 1;
    Result.y := -1;
  end
  else if (0<=_Angle) and (_Angle<=90) then
  begin
    Result.x := 1;
    Result.y := -1;
  end
  else if (90<=_Angle) and (_Angle<=180) then
  begin
    Result.x := 1;
    Result.y := 1;
  end
  else if (180<=_Angle) and (_Angle<=270) then
  begin
    Result.x := -1;
    Result.y := 1;
  end
  else if ((270<=_Angle) and (_Angle<=360)) then
  begin
    Result.x := -1;
    Result.y := -1;
  end;
end;


procedure TVectorDiagramHelper.DrawAngles(_Canvas : TCanvas);
var
  i: Integer;
  x0, y0, x1, y1 ,w,h, r:Integer;
  mults : TPoint;
  co, si : double;
  l_Angle : Single;
begin
  w := _Canvas.TextWidth('360°');
  h := _Canvas.TextHeight('360°');
  r := trunc(sqrt(w*w+h*h)) div 2;

  co := 0;
  si := 0;
  with _Canvas do
  if (m_Draw30Angles) then
    for i:=0 to m_30AnglesCount-1 do
    begin
      l_Angle := 360/m_30AnglesCount*i;
      if (0<=l_Angle) AND (l_Angle <= 90) then
      begin
        co := cos(l_Angle/180*pi);
        si := sin(l_Angle/180*pi);
      end else if(90<l_Angle) AND (l_Angle <= 180) then
      begin
        co := sin((l_Angle-90)/180*pi);
        si := cos((l_Angle-90)/180*pi);
      end else if(180<l_Angle) AND (l_Angle <= 270) then
      begin
        co := cos(-(180-l_Angle)/180*pi);
        si := sin(-(180-l_Angle)/180*pi);
      end else if(270<l_Angle) AND (l_Angle < 360) then
      begin
        co := -sin(-(90-l_Angle)/180*pi);
        si := -cos(-(90-l_Angle)/180*pi);
      end;

      mults := GetMult(trunc(l_Angle));
      x0 := round(m_O.x + mults.x*(m_Radius-7)*si);
      y0 := round(m_O.y + mults.y*(m_Radius-7)*co);
      x1 := round(m_O.x + mults.x*(m_Radius+6)*si);
      y1 := round(m_O.y + mults.y*(m_Radius+6)*co);

      moveTo(x0, y0); // перемещаемся к окружности
      LineTo(x1, y1); // рисуем лини, пересекающую окружность

      // координаты середины текста
      x1 := round(m_O.x + mults.x*(m_Radius+2 + r)*si);
      y1 := round(m_O.y + mults.y*(m_Radius+2 + r)*co);

//      TextOut(x1, y1, IntToStr(i*30)+'°');

      // координаты верхнего левого угла текста
      x0 := x1 - (w) div 2 + (w-TextWidth(IntToStr(i*30)+'°')) div 2;
      y0 := y1 - (h) div 2;

      if (l_Angle = 0) then
        TextOut(x0, y0, FloatToStrF(l_Angle,ffFixed, 18,0)+'° cosФ=1')
      else if (l_Angle = 180) then
        TextOut(x0, y0, FloatToStrF(l_Angle,ffFixed, 18,0)+'° cosФ=-1')
      else
        TextOut(x0, y0, FloatToStrF(l_Angle,ffFixed, 18,0)+'°');
     // LineTo(x1, y1); // рисуем дальше
    end;
end;



End.
