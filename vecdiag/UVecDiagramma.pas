unit UVecDiagramma;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;
  //, DsgnIntf,{ $IFDEF GDEBUG} DbugIntF, { $ENDIF}
  //UExporter, UClassManager, KanList;//, GenaUtl;
const
  c_Max_Limit = 120;
type
  //TVecDiagramma = class;

  TVector = record
    Value: Double;//Модуль вектора
    Angle: Double;//Угол от 0 до Pi
    Color: TColor;
  end;

  TPolyLine = class
    private
      FPoints: TList;
      FOnGetPolyLine: TNotifyEvent;
      function GetPoint( AIndex: Integer ): TPoint;
      procedure SetPoint( AIndex: Integer; APoint: TPoint );
      function GetCount: Integer;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Clear;
      property Count: Integer read GetCount;
      property Points[Index: Integer]: TPoint read GetPoint write SetPoint;
      property OnGetPolyLine: TNotifyEvent read FOnGetPolyLine write FOnGetPolyLine;
  end;

  TVecPanel = class( TGraphicControl )
  private
    //FAddrX: TAddr;
    //FAddrY: TAddr;
    FX: Integer;
    FY: Integer;
    Ox: Integer;//Длина оси Ox
    Oy: Integer;//Длина оси Oy
    FMasX: Integer;//Масштаб по X
    FMasY: Integer;//Масштаб по Y
    FZeroX: Integer;//Ноль по X
    FZeroY: Integer;//Ноль по Y
    FhStep: Integer;//Горизнотальное смещение
    FvStep: Integer;//Вертикальное смещение
    FVec: TPoint;//Координата вектора
    FVecColor: TColor;
    FArrowRight: TPoint;//Правое ребро стрелки
    FArrowLeft: TPoint;//Левое ребро стрелки
    FTmpDiag: TBitMap;
    FFone: TBitMap;
    FNeedRecount: Boolean;
    FPaintAtributs: Boolean;
    FFirstPaint: Boolean;
    FGridColor: TColor;
    FArcColor: TColor;
    FPolyLine: TPolyLine;
    FLimit: Integer;
    //FVector: TVector;
    FSelIndex: Integer;
    FPolyLineStr: TStrings;
    //FOnGetValue: TGetImgData;
    //FOnShowValue: TNotifyEvent;
    //FOnGethint: TGetHint;
    FLimitColor: TColor;
    FPolyLineColor: TColor;
    FHRuleColor: TColor;
    FVRuleColor: TColor;
    procedure Recount;
    procedure PaintVector( var AChart: TBitMap );
    procedure PaintLimitLine( var AChart: TBitMap; AColor: TColor );
    procedure PaintPolyLine( var AChart: TBitMap; AColor: TColor );
    procedure PaintPowerFactor( var AChart: TBitMap; AColor: TColor );
    procedure PaintRules( const AChart: TBitMap; HRulColor, VRulColor: TColor );
    procedure PaintGrid( var AChart: TBitMap; AColor: TColor );
    procedure PaintArc( var AChart: TBitMap; AColor: TColor );
    procedure SetGridColor(const Value: TColor);
    procedure SetArcColor(const Value: TColor);
    procedure DoOnPolyLine( Sender: TObject );
    procedure SetLimit(const Value: Integer);
    function GetSelIndex: Integer;
    procedure SetSelIndex(const Value: Integer);
    procedure ResizeVecPanel( Sender: TObject );
    procedure SetX(const Value: Integer);
    procedure SetY(const Value: Integer);
    procedure SetVecColor(const Value: TColor);
    procedure SetPolyLine( AValue: TStrings );
//    function GetHint( Value: String ): String;
    procedure SetLimitColor(const Value: TColor);
    procedure SetPolyLineColor(const Value: TColor);
    procedure SetHRuleColor(const Value: TColor);
    procedure SetVRuleColor(const Value: TColor);
  protected
    procedure Click; override;
    procedure Paint; override;
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    procedure MouseToCoord( X, Y: Integer; var APoint: TPoint );
    property X: Integer read FX write SetX;
    property Y: Integer read FY write SetY;
    //SelIndex = (-1) - ничего не выбрано
    property SelIndex: Integer read GetSelIndex write SetSelIndex;
  published
//    procedure ShowValue( Sender: TObject);
    property Visible;
    property PopupMenu;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property Enabled;
    property Constraints;
    property ParentShowHint;
    property ShowHint;
    property Align;
    property Font;
    //Линия придела задаетя чилом от ( 0 до 120% ) * 1000 по оси Y
    property Limit: Integer read FLimit write SetLimit default 120;
    property GridColor: TColor read FGridColor write SetGridColor;
    property ArcColor: TColor read FArcColor write SetArcColor;
    property VectorColor: TColor read FVecColor write SetVecColor;
    property LimitColor: TColor read FLimitColor write SetLimitColor;
    property PolyLineColor: TColor read FPolyLineColor write SetPolyLineColor;
    property HRuleColor: TColor read FHRuleColor write SetHRuleColor;
    property VRuleColor: TColor read FVRuleColor write SetVRuleColor;
    //Точки полилинии имеют координаты ( от -100 до 100% ) * 1000 по соответсвующей оси
    property PolyLine: TStrings read FPolyLineStr write SetPolyLine;
    //property AddrX: TAddr read FAddrX write FAddrX;
    //property AddrY: TAddr read FAddrY write FAddrY;
    //property OnShowValue : TNotifyEvent read FOnShowValue write FOnShowValue;
    //property OnGetValue : TGetImgData read FOnGetValue write FOnGetValue;
    //property OnGetHint : TGetHint read FOnGethint write FOnGetHint;
  end;

//  TVectorDiag = class( TExporter )
//  public
//    constructor Create;
//    destructor Destroy; override;
//    class function Name: String; override;
//    class function PlType: TPlType; override;
//    function RunPlugin( Sender: TObject ): TObject; override;
//    function StopPlugin: Boolean; override;
//  end;

procedure register;

implementation

{$R VecRes.res}

uses
  Math;

{ TVecDiagramma }

const
  //Стандартные отступы
  c_LeftMargine = 40;
  c_RightMargine = 10;
  c_TopMargine = 10;
  c_BottomMargine = 40;

  //Параметры сетки
  c_hRules = 25;
  c_vRules = 11;
  c_Mas = 1;

  //Параметры пера
  c_Thin = 1;
  c_Normal = 3;
  c_Thick = 5;


procedure Register;
begin
  RegisterComponents('Samples', [TVecPanel]);
end;

function IsFloat(const Value: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  if Value <> '' then
  begin
    for I := 1 to Length(Value) do
      if not (Value[I] in [DecimalSeparator, '0'..'9']) then Exit;
    Result := True;
  end;
end;

{ TVecPanel }

procedure TVecPanel.Click;
begin
//  CallClick( Self );
  Inherited Click;;
end;

constructor TVecPanel.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

  //На FTmpDiag рисуется фон диаграммы
  FX := 0;
  FY := 0;
  //FVector.Color := clRed;
  FPolyLineStr := TStringList.Create;
  FPolyLine := TPolyLine.Create;
  FPolyLine.OnGetPolyLine := DoOnPolyLine;
  FPaintAtributs := True;
  FNeedRecount := True;
  FFirstPaint := True;
  FSelIndex := -1;
//  OnShowValue := ShowValue;
//  OnGetHint := GetHint;
  FFone := TBitMap.Create;
  FFone.Canvas.Brush.Style := bsClear;
  FTmpDiag := TBitMap.Create;
  FTmpDiag.Canvas.Brush.Style := bsClear;
  Constraints.MinHeight := 50;
  Constraints.MinWidth := 50;
  OnResize := ResizeVecPanel;
  Resize;
end;

destructor TVecPanel.Destroy;
begin
  FPolyLineStr.Free;
  FPolyLine.Free;
  FFone.FreeImage;
  FFone.Free;
  FTmpDiag.FreeImage;
  FTmpDiag.Free;
  inherited;
end;

procedure TVecPanel.DoOnPolyLine(Sender: TObject);
begin
  Paint;
end;
(*
function TVecPanel.GetHint(Value: String): String;
begin
  if ( Value = 'Address' ) then begin
    Result := 'Адрес сигнала (ТИ) = [Номер направления]*1000 + [Номер канала]';
  end
  else if ( Value = 'AddrX' ) then begin
    Result := 'Адрес сигнала (ТИ) для координаты X вектора = [Номер направления]*1000 + [Номер канала]';
  end
  else if ( Value = 'AddrY' ) then begin
    Result := 'Адрес сигнала (ТИ) для координаты Y вектора = [Номер направления]*1000 + [Номер канала]';
  end
  else if ( Value = 'VRuleColor' ) then begin
    Result := 'Цвет вертикальной линейки';
  end
  else if ( Value = 'HRuleColor' ) then begin
    Result := 'Цвет горизонтальной линейки';
  end
  else if ( Value = 'PolyLine' ) then begin
    Result := 'Список точек формата [X|Y], которые составляют полилинию';
  end
  else if ( Value = 'PolyLineColor' ) then begin
    Result := 'Цвет полилинии';
  end
  else if ( Value = 'Limit' ) then begin
    Result := 'Положение ограничительной линии в процентах по оси Y';
  end
  else if ( Value = 'LimitColor' ) then begin
    Result := 'Цвет ограничительной линии';
  end
  else if ( Value = 'GridColor' ) then begin
    Result := 'Цвет сетки';
  end
  else if ( Value = 'ArcColor' ) then begin
    Result := 'Цвет Концентрических дуг';
  end
  else if ( Value = 'VectorColor' ) then begin
    Result := 'Цвет вектора';
  end
  else if ( Value = 'AddrList' ) then begin
    Result := 'Вводится список адресов ТИ (по формуле из Addres), для отображения в подсказке при наведении курсора на элемент';
  end
  else if ( Value = 'Angle' ) then begin
    Result := 'Вводится угол поворота текста.';
  end
  else if ( Value = 'ColorHighlight' ) then begin
    Result := 'Вводится цвет эфекта подсветки текста.';
  end
  else if ( Value = 'ColorHShadow' ) then begin
    Result := 'Вводится цвет эфекта тени текста.';
  end
  else if ( Value = 'Precision' ) then begin
    Result := 'Вводится количество знаков после запятой.';
  end
  else if ( Value = 'ShadowDepth' ) then begin
    Result := 'Вводится смешение эфекта тени от основного текста.';
  end
  else if ( Value = 'Layout' ) then begin
    Result := 'Центровка текста по горизонтали.';
  end
  else begin
    Result := '';
  end;
end;
*)
function TVecPanel.GetSelIndex: Integer;
begin
  if ( FSelIndex > ( FPolyLine.Count - 1 ) ) then begin
    Result := -1;
  end
  else begin
    Result := FSelIndex;
  end;
end;

procedure TVecPanel.MouseToCoord(X, Y: Integer; var APoint: TPoint);
var
  Xc, Yc: Integer;
begin
  Xc := ( X - c_LeftMargine - FZeroX )*100 div FMasX;
  Yc := -1*( Y - c_TopMargine - FZeroY )*100 div FMasY;
  if ( Yc > 120 ) then begin
    Yc := 120;
  end;
  if ( Yc < 0 ) then begin
    Yc := 0;
  end;
  if ( Xc > 100 ) then begin
    Xc := 100;
  end;
  if ( Xc < -100 ) then begin
    Xc := -100;
  end;
  APoint := Point( Xc, Yc );

end;

procedure TVecPanel.Paint;
begin
  if ( not Assigned( Parent ) ) then begin
    Exit;
  end;
  if ( ( ClientHeight = 0 ) or ( ClientWidth = 0 ) ) then begin
    Exit;
  end;
  if ( FFirstPaint ) then begin
    OnResize( Self );
  end;
  //FNeedRecount := True;
  if ( FNeedRecount ) then begin
    Canvas.Brush.Color := Parent.Brush.Color;
    FFone.Height := ( ClientHeight div ( c_hRules + 1 ) )*( c_hRules + 1 ) - c_LeftMargine - c_RightMargine;
//    FFone.Width := 50;//( ClientWidth div ( c_vRules + 1 ) )*( c_vRules + 1 ) - c_TopMargine - c_BottomMargine;

    //Создаем белый лист
    FFone.Canvas.Brush.Color := clWhite;
    FFone.Canvas.FillRect( FFone.Canvas.ClipRect );
    FFone.Canvas.Brush.Style := bsClear;

    Recount;

    //Рисуем сетку
    PaintGrid( FFone, FGridColor );

    //Рисуем полуокружности
    PaintArc( FFone, FArcColor );

    //Рисуем PowerFactor
    PaintPowerFactor( FFone, FArcColor );

    FNeedRecount := False;
    FPaintAtributs := True;
  end;

  if ( ( FPaintAtributs ) and Assigned( FFone ) ) then begin
    FTmpDiag.Assign( FFone );

    //Рисуем полилинию
    PaintPolyLine( FTmpDiag, FPolyLineColor );

    //Рисуем вектор
    PaintVector( FTmpDiag );

    //Рисуем линию придела
    PaintLimitLine( FTmpDiag, FLimitColor );

    //Рисуем линейки:
    PaintRules( FTmpDiag, FHRuleColor, FVRuleColor );

    FPaintAtributs := False;
  end;

  //Выводим FTmpDiag на канву VecPanel
  if ( Assigned( FTmpDiag ) ) then begin
    Canvas.StretchDraw( Rect( c_LeftMargine, c_TopMargine, ( FTmpDiag.Width + c_LeftMargine ), ( FTmpDiag.Height + c_TopMargine ) ), FTmpDiag );
  end;
end;

procedure TVecPanel.PaintArc(var AChart: TBitMap; AColor: TColor);
var
  i: Integer;
  RadiusNx: Integer;
  RadiusNy: Integer;
  Nx: Integer;
  Ny: Integer;
begin
//Рисуется, только если есть линия центра, то есть если вертикальных линий нечетное число
  if ( ( c_vRules mod 2 ) = 0 ) then begin
    Exit;
  end;
  if ( AChart.Canvas.Font <> Font ) then begin
    AChart.Canvas.Font := Font;
  end;
  AChart.Canvas.Pen.Color := AColor;
  AChart.Canvas.Pen.Width := c_Thin;
  Nx := AChart.Width div ( c_vRules*2 );
  Ny := ( AChart.Height div ( c_hRules ) )*2;
  RadiusNx := c_vRules*Nx + Nx;
  RadiusNy := ( c_vRules div 2 )*2*Ny + 2*Ny;
  for i := 0 to 1 do begin
    AChart.Canvas.TextOut( FZeroX - 16, FZeroY - RadiusNy - 12, FormatFloat( '0.0', ( ( c_vRules div 2 )*2 + 2 - i )/10 ) );
    Dec( RadiusNx, Nx);
    Dec( RadiusNy, Ny);
  end;
  for i := 0 to ( ( c_vRules div 2 )*2 - 1 ) do begin
    AChart.Canvas.Chord( ( FZeroX - RadiusNx ), ( FZeroY - RadiusNy ), ( FZeroX + RadiusNx ), ( FZeroY + RadiusNy), AChart.Width, AChart.Height, 0, AChart.Height );
    AChart.Canvas.TextOut( FZeroX - 16, FZeroY - RadiusNy - 12, FormatFloat( '0.0', ( ( c_vRules div 2 )*2 - i )/10 ) );
    Dec( RadiusNx, Nx);
    Dec( RadiusNy, Ny);
  end;
  AChart.Canvas.Chord( ( FZeroX - RadiusNx ), ( FZeroY - RadiusNy ), ( FZeroX + RadiusNx ), ( FZeroY + RadiusNy), AChart.Width, AChart.Height, 0, AChart.Height );
end;

procedure TVecPanel.PaintGrid( var AChart: TBitMap; AColor: TColor );
var
  i: Integer;
  Pos: Integer;
begin
  AChart.Canvas.Pen.Color := AColor;
  AChart.Canvas.Pen.Width := c_Thin;
  AChart.Canvas.Pen.Style := psDot;
  //Рисуем горизонтальные линии
  Pos := AChart.Height - FvStep;
  for i := 1 to c_hRules do begin
    AChart.Canvas.MoveTo( 0, Pos );
    AChart.Canvas.LineTo( AChart.Width, Pos );
    Dec( Pos, FvStep );
  end;


  //Рисуем линию центра
  if ( ( c_vRules mod 2 ) <> 0 ) then begin
    AChart.Canvas.MoveTo( FZeroX, 0 );
    AChart.Canvas.LineTo( FZeroX, FZeroY );
  end;
  Pos := FhStep;
  //Рисуем вертикальные линии
  for i := 1 to ( c_vRules div 2 ) do begin
    AChart.Canvas.MoveTo( FZeroX + Pos, 0 );
    AChart.Canvas.LineTo( FZeroX + Pos, FZeroY );
    AChart.Canvas.MoveTo( FZeroX - Pos, 0 );
    AChart.Canvas.LineTo( FZeroX - Pos, FZeroY );
    Inc( Pos, FhStep );
  end;
  AChart.Canvas.Pen.Style := psSolid;
end;

procedure TVecPanel.PaintLimitLine(var AChart: TBitMap; AColor: TColor);
var
  Limit: Integer;
begin
  AChart.Canvas.Pen.Color := AColor;
  AChart.Canvas.Pen.Width := c_Normal;
  Limit := AChart.Height - Round( ( FLimit / c_Max_Limit )*( c_hRules - 1 )*(AChart.Height div  c_hRules ) );
  AChart.Canvas.MoveTo( ( AChart.Width div 2 ) - ( AChart.Width div ( c_vRules ) ) * ( c_vRules div 2 ), Limit );
  AChart.Canvas.LineTo( ( AChart.Width div 2 ) + ( AChart.Width div ( c_vRules ) ) * ( c_vRules div 2 ), Limit );
end;

procedure TVecPanel.PaintPolyLine(var AChart: TBitMap; AColor: TColor);
var
  i, j: Integer;
  PosSep: Integer;
  Xn, Yn: String;
begin
  if ( Assigned( FPolyLineStr ) ) then begin
    if ( ( FPolyLineStr.Count > 0 ) and ( FPolyLine.Count <= 0 ) ) then begin
      i := 0;
      j := 0;
      while ( j < FPolyLineStr.Count ) do begin
        PosSep := Pos( '|', FPolyLineStr.Strings[ j ] );
        if ( PosSep <> 0 ) then begin
          Xn := Copy( FPolyLineStr.Strings[ j ], 1, ( PosSep - 1 ) );
          Xn := Trim( Xn );
          Yn := Copy( FPolyLineStr.Strings[ j ], ( PosSep + 1 ), ( Length( FPolyLineStr.Strings[ j ] ) - PosSep ) );
          Yn := Trim( Yn );
        end;
        if ( ( Xn <> '' ) and ( Yn <> '' ) ) then begin
          FPolyLine.Points[ i ] := Point( StrToInt( Xn )*c_Mas, StrToInt( Yn )*c_Mas );
          Inc( i );
        end;
        Inc( j );
      end;
    end;
  end;

  if ( FPolyLine.Count <= 0 ) then begin
    Exit;
  end;
  AChart.Canvas.Pen.Color := AColor;
  AChart.Canvas.Pen.Width := c_Normal;
  AChart.Canvas.MoveTo( ( FZeroX + ( FPolyLine.Points[ 0 ].x*FMasX div 100 ) ), ( FZeroY - ( FPolyLine.Points[ 0 ].y*FMasY div 100 ) ) );
  if ( 0 = FSelIndex ) then begin
    AChart.Canvas.Pen.Color := clRed;
    AChart.Canvas.Ellipse( ( FZeroX + ( FPolyLine.Points[ 0 ].x*FMasX div 100 ) - 5 ), ( FZeroY - ( FPolyLine.Points[ 0 ].y*FMasY div 100 ) - 5 ),  ( FZeroX + ( FPolyLine.Points[ 0 ].x*FMasX div 100 ) + 5 ), ( FZeroY - ( FPolyLine.Points[ 0 ].y*FMasY div 100 ) + 5 )  );
    AChart.Canvas.Pen.Color := AColor;
  end;
  for i := 1 to ( FPolyLine.Count - 1 )do begin
    AChart.Canvas.LineTo( ( FZeroX + ( FPolyLine.Points[ i ].x*FMasX div 100 ) ), ( FZeroY - ( FPolyLine.Points[ i ].y*FMasY div 100 ) ) );
    if ( i = FSelIndex ) then begin
      AChart.Canvas.Pen.Color := clRed;
      AChart.Canvas.Ellipse( ( FZeroX + ( FPolyLine.Points[ i ].x*FMasX div 100 ) - 5 ), ( FZeroY - ( FPolyLine.Points[ i ].y*FMasY div 100 ) - 5 ),  ( FZeroX + ( FPolyLine.Points[ i ].x*FMasX div 100 ) + 5 ), ( FZeroY - ( FPolyLine.Points[ i ].y*FMasY div 100 ) + 5 )  );
      AChart.Canvas.Pen.Color := AColor;
    end;
  end;
end;

procedure TVecPanel.PaintPowerFactor(var AChart: TBitMap; AColor: TColor);
var
  //Дополнительные координаты
  Xn, Yn: Integer;
  //Синус угла смещения Power Factor
  SinAngle: Double;
  //Счетчики
  i: Integer;
  Count: Integer;
begin
  AChart.Canvas.Pen.Color := AColor;
  AChart.Canvas.Pen.Width := c_Thin;

  SinAngle := 0.1;
  //Рисуем линию центра
  if ( ( c_vRules mod 2 ) <> 0 ) then begin
    AChart.Canvas.MoveTo( FZeroX, ( FZeroY - Oy ) );
    AChart.Canvas.LineTo( FZeroX, FZeroY );
  end;

  {До тех пор покуда тангенс угла меньше чем тангенс соотношения осей, то есть 1.2
  рисовать линии до границы, определенной максимальным значением по оси X}
  Count := 0;
  while ( Round( ( Tan( ArcSin( SinAngle ) ) - 1.2 ) * 100 ) <= 0 ) do begin
    Yn := FZeroY - Round( Tan ( ArcSin( SinAngle ) ) * FMasY );
    AChart.Canvas.MoveTo( FZeroX + Ox, Yn );
    AChart.Canvas.LineTo( FZeroX, FZeroY );
    AChart.Canvas.LineTo( FZeroX - Ox, Yn );
    SinAngle := SinAngle + 0.1;
    Inc( Count );
  end;
  {Оставшиеся линии рисовать до до верхней границы оси Y}
  Yn := FZeroY - Oy;
  for i := Count to ( ( c_vRules div 2 )*2 - 2 ) do begin
   Xn := Round(1.2*Tan(Pi/2 - ArcSin(SinAngle)) * Ox);
    AChart.Canvas.MoveTo( FZeroX - Xn, Yn);
    AChart.Canvas.LineTo( FZeroX, FZeroY);
    AChart.Canvas.LineTo( FZeroX + Xn, Yn);
    SinAngle := SinAngle + 0.1;
  end;
end;

procedure TVecPanel.PaintRules(const AChart: TBitMap; HRulColor, VRulColor: TColor);
var
  i: Integer;
  Pos: Integer;
  RulVal: Double;//Значение на шклае
begin
  if ( Canvas.Font <> Font ) then begin
    Canvas.Font := Font;
  end;
  Canvas.Pen.Color := HRulColor;
  //Горизонтальная линейка
  Canvas.Pen.Width := c_Normal;
  Canvas.MoveTo( c_LeftMargine, ( c_TopMargine + AChart.Height ) );
  Canvas.LineTo( ( c_LeftMargine + AChart.Width ), ( c_TopMargine + AChart.Height ) );


  //Насечки на горизонтальной линейке
  Canvas.Pen.Width := c_Thin;
  RulVal := 0;
  //Рисуем линию центра
  if ( ( c_vRules mod 2 ) <> 0 ) then begin
    Canvas.TextOut( c_LeftMargine + FZeroX - 2, ( FZeroY + c_TopMargine + 8 ), FormatFloat( '0', RulVal ) );
    Canvas.MoveTo( c_LeftMargine + FZeroX, ( FZeroY + c_TopMargine + 7 ) );
    Canvas.LineTo( c_LeftMargine + FZeroX, ( FZeroY + c_TopMargine ) );
  end;
  Pos := FhStep;
  for i := 1 to ( c_vRules div 2 ) do begin
    RulVal := RulVal + 0.2;
    Canvas.TextOut( c_LeftMargine + FZeroX+ Pos - 4, ( FZeroY + c_TopMargine + 8 ), FormatFloat( '0.0', RulVal ) );
    Canvas.MoveTo( c_LeftMargine + FZeroX + Pos, ( FZeroY + c_TopMargine + 5) );
    Canvas.LineTo( c_LeftMargine + FZeroX + Pos, ( FZeroY + c_TopMargine ) );
    Canvas.TextOut( c_LeftMargine + FZeroX- Pos - 6, ( FZeroY + c_TopMargine + 8 ), FormatFloat( '0.0', ( RulVal*( -1 ) ) ) );
    Canvas.MoveTo( c_LeftMargine + FZeroX - Pos, ( FZeroY + c_TopMargine + 5) );
    Canvas.LineTo( c_LeftMargine + FZeroX - Pos, ( FZeroY + c_TopMargine ) );
    Inc( Pos, FhStep );
  end;

  Canvas.Pen.Color := VRulColor;
  //Вертикальная линейка
  Canvas.Pen.Width := c_Normal;
  Canvas.MoveTo( c_LeftMargine, c_TopMargine );
  Canvas.LineTo( c_LeftMargine, ( c_TopMargine + AChart.Height ) );

  //Насечки на вертикальной линейке
  Canvas.Pen.Width := c_Thin;
  Pos := FZeroY + c_TopMargine;
  for i := 0 to ( c_hRules + 1 ) do begin
    Canvas.MoveTo( c_LeftMargine - 5, Pos );
    Canvas.LineTo( c_LeftMargine, Pos );
    Dec( Pos, FvStep );
  end;
end;

procedure TVecPanel.PaintVector( var AChart: TBitMap );
var
  VecVal: Integer;
  ArrowLen: Integer;
  Angle: Double;
begin
  if ( ( FX = 0 ) and ( FY = 0 ) ) then begin
    Exit;
  end;

  AChart.Canvas.Pen.Color := FVecColor;
  AChart.Canvas.Pen.Width := c_Normal;

  if ( ( FX = 0 ) or ( FMasX = 0 ) ) then begin
    Angle := Pi / 2;
  end
  else if ( FX < 0 ) then begin
    Angle := Pi - ArcTan( ( FY * FMasY ) / Abs( FX * FMasX ) );
  end
  else begin
    Angle := ArcTan( ( FY * FMasY ) / ( FX * FMasX ) );
  end;

  VecVal := Round( Sqrt( Power( FX, 2 ) + Power( FY, 2 ) )*100 );
  ArrowLen := Min( 14, ( VecVal div 32 ) );

  FVec.x := FZeroX + ( FX*FMasX div 100 );
  FVec.y := FZeroY - ( FY*FMasY div 100 );
  FArrowRight.x := FVec.x - Round( ArrowLen*Sin( ( 80*Pi / 180) + Angle ) );
  FArrowRight.y := FVec.y - Round( ArrowLen*Cos( ( 80*Pi / 180) + Angle ) );
  FArrowLeft.x := FVec.x - Round( ArrowLen*Cos( ( -10*Pi / 180) - Angle ) );
  FArrowLeft.y := FVec.y - Round( ArrowLen*Sin( ( -10*Pi / 180) - Angle ) );

  //Рисуем сам вектор
  AChart.Canvas.MoveTo( FZeroX, FZeroY );//Центер
  AChart.Canvas.LineTo( FVec.x, FVec.y );

  //Рисуем стрелочку
  AChart.Canvas.Polygon( [ FVec, FArrowRight, FArrowLeft ] );
end;

procedure TVecPanel.Recount;
begin
  if ( not Assigned( FFone ) ) then begin
    Exit;
  end;

  FhStep := FFone.Width div ( c_vRules );
  FvStep := FFone.Height div ( c_hRules );
  FMasX := ( FFone.Width div ( c_vRules ) )*( c_vRules div 2 );
  FMasY := ( c_vRules div 2 )*4*FvStep;
  FZeroX := FFone.Width div 2;
  FZeroY := FFone.Height;
  Ox := FhStep*( c_vRules div 2 );
  Oy := ( c_hRules - 1 )*FvStep;
end;

procedure TVecPanel.ResizeVecPanel(Sender: TObject);
begin
  FNeedRecount := True;
  Recount;
end;

procedure TVecPanel.SetArcColor(const Value: TColor);
begin
  if ( FArcColor <> Value ) then begin
    FArcColor := Value;
    RePaint;
  end;
end;

procedure TVecPanel.SetGridColor(const Value: TColor);
begin
  if ( FGridColor <> Value ) then begin
    FGridColor := Value;
    RePaint;
  end;
end;

procedure TVecPanel.SetHRuleColor(const Value: TColor);
begin
  if ( FHRuleColor <> Value ) then begin
    FHRuleColor := Value;
    FPaintAtributs := True;
    RePaint;
  end;
end;

procedure TVecPanel.SetLimit(const Value: Integer);
begin
  if ( ( FLimit <> Value ) and ( Value >= 0 ) and ( Value <= c_Max_Limit ) ) then begin
    FLimit := Value;
    FPaintAtributs := True;
    RePaint;
  end;
end;

procedure TVecPanel.SetLimitColor(const Value: TColor);
begin
  if ( FLimitColor <> Value ) then begin
    FLimitColor := Value;
    FPaintAtributs := True;
    RePaint;
  end;
end;

procedure TVecPanel.SetPolyLine(AValue: TStrings);
var
  i, j: Integer;
  PosSep: Integer;
  Xn, Yn: String;
begin
  FPolyLineStr.Clear;
  FPolyLineStr.Assign( AValue );
  FPolyLine.Clear;
  i := 0;
  j := 0;
  while ( j < AValue.Count ) do begin
    PosSep := Pos( '|', AValue.Strings[ j ] );
    if ( PosSep <> 0 ) then begin
      Xn := Copy( AValue.Strings[ j ], 1,( PosSep - 1 ) );
      Xn := Trim( Xn );
      Yn := Copy( AValue.Strings[ j ], ( PosSep + 1 ), ( Length( AValue.Strings[ j ] ) - PosSep ) );
      Yn := Trim( Yn );
    end;
    if ( ( Xn <> '' ) and ( Yn <> '' ) ) then begin
      FPolyLine.Points[ i ] := Point( StrToInt( Xn )*c_Mas, StrToInt( Yn )*c_Mas );
      Inc( i );
    end;
    Inc( j );
  end;
  FPaintAtributs := True;
  Paint;
end;

procedure TVecPanel.SetPolyLineColor(const Value: TColor);
begin
  if ( FPolyLineColor <> Value ) then begin
    FPolyLineColor := Value;
    FPaintAtributs := True;
    RePaint;
  end;
end;

procedure TVecPanel.SetSelIndex(const Value: Integer);
begin
  if ( Value > ( FPolyLine.Count - 1 ) ) then begin
    FSelIndex := -1;
  end
  else begin
    FSelIndex := Value;
  end;
  FPaintAtributs := True;
  RePaint;
end;

procedure TVecPanel.SetVecColor(const Value: TColor);
begin
  if ( FVecColor <> Value ) then begin
    FVecColor := Value;
    FPaintAtributs := True;
    RePaint;
  end;
end;

procedure TVecPanel.SetVRuleColor(const Value: TColor);
begin
  if ( FVRuleColor <> Value ) then begin
    FVRuleColor := Value;
    FPaintAtributs := True;
    RePaint;
  end;
end;

procedure TVecPanel.SetX(const Value: Integer);
begin
  if ( FX <> Value ) then begin
    FX := Value;
    FPaintAtributs := True;
    RePaint;
  end;
end;

procedure TVecPanel.SetY(const Value: Integer);
begin
  if ( FY <> Value ) then begin
    FY := Value;
    FPaintAtributs := True;
    RePaint;
  end;
end;
(*
procedure TVecPanel.ShowValue(Sender: TObject);
var
  ImgParams: TImgParams;
begin
  if Assigned( OnGetValue ) then begin
    // X
    if ( AddrX > 0 ) then begin
      OnGetValue( AddrX, ImgParams );
      if IsFloat( ImgParams.AVel ) then begin
        X := Trunc( StrToFloat( ImgParams.AVel ) );
      end;
    end
    else begin
      X := 0;
    end;
    // Y
    if ( AddrY > 0 ) then begin
      OnGetValue( AddrY, ImgParams );
      if IsFloat( ImgParams.AVel ) then begin
        Y := Trunc( StrToFloat( ImgParams.AVel ) );
      end;
    end
    else begin
      Y := 0;
    end;
  end
  else begin
    X := 0;
    Y := 0;
  end;
end;
*)
{ TPolyLine }

procedure TPolyLine.Clear;
var
  i: Integer;
  Tmp: ^TPoint;
begin
  for i := 0 to ( FPoints.Count - 1 ) do begin
    Tmp := FPoints.Items[ i ];
    Dispose( Tmp );
  end;
  FPoints.Clear;
end;

constructor TPolyLine.Create;
begin
  FPoints := TList.Create;
end;

destructor TPolyLine.Destroy;
begin
  Clear;
  FPoints.Free;
  inherited;
end;

function TPolyLine.GetCount: Integer;
begin
  Result := FPoints.Count;
end;

function TPolyLine.GetPoint(AIndex: Integer): TPoint;
begin
  if ( AIndex > ( FPoints.Count - 1 ) ) then begin
    Result := Point( 0, 0 );
    Exit;
  end;
  Result := TPoint( FPoints.Items[ AIndex ]^ );
end;

procedure TPolyLine.SetPoint(AIndex: Integer; APoint: TPoint);
var
 Tmp: ^TPoint;
begin
  New( Tmp );
  Tmp^.x := APoint.x;
  Tmp^.y := APoint.y;
  FPoints.Insert( AIndex, Tmp );
  if Assigned( FOnGetPolyLine ) then begin
    FOnGetPolyLine( Self );
  end;
end;

{ TVectorDiag }
//
//constructor TVectorDiag.Create;
//begin
//  inherited;
//end;
//
//destructor TVectorDiag.Destroy;
//begin
//  inherited;
//end;
//
//class function TVectorDiag.Name: String;
//begin
//  Result := 'Vectors Diagramma';
//end;
//
//class function TVectorDiag.PlType: TPlType;
//begin
//  Result := PlNIL;
//end;
//
//function TVectorDiag.RunPlugin(Sender: TObject): TObject;
//begin
//  Result := Self;
//  RegClasses( HInstance, 'VecDiag', [ TVecPanel ] );
//end;
//
//function TVectorDiag.StopPlugin: Boolean;
//begin
//  Result := False;
//end;

initialization
//  Manager.Add( TVectorDiag );
finalization

end.
