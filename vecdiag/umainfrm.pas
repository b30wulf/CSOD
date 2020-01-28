Unit umainfrm;

Interface

Uses
  WinTypes, WinProcs, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, AdvMenus, AdvToolBar, AdvToolBarStylers, AdvMenuStylers, Db,
  DBTables, Fourier, AdvAppStyler, AdvPanel, VectorDiagram, AdvTrackBar,
  rchart, AdvScrollBox, StdCtrls, AdvGlowButton, Grids, DBGridEh, Spin,
  ExtCtrls, AdvNavBar, AdvSplitter, IniFiles, GenaUtl, ap, spline3,
  BZip2, AdvOfficeButtons, Mask, AdvSpin, AdvCombo, DBGrids, propscrl,
  GridsEh;

Const
  PackLen           = 9;
  DPackLen          = 16;
  Masht             = 1.25;
//  HeaderLen         = 60;
//  HeaderLen         = $48;
//  HeaderLen         = 0;
  HeaderLen         = 0;
  LabelLen          = 50;
  Step              = 0.1;
//  NaN               = 0.0 / 1.0;

Type
  DA = Record
    Time : Integer;
    Val : Array[0..DPackLen - 1] Of Byte;
  End;
  AA = Packed Record
    Val : Array[0..PackLen - 2] Of Single;
    Time : Single;
  End;

  TForm1 = Class(TForm)
    AdvNavBar1 : TAdvNavBar;
    AdvNavBarPanel1 : TAdvNavBarPanel;
    AdvPanelStyler1 : TAdvPanelStyler;
    AdvFormStyler1 : TAdvFormStyler;
    AdvNavBarPanel2 : TAdvNavBarPanel;
    AdvSplitter5 : TAdvSplitter;
    FFT1 : TFastFourier;
    Table1 : TTable;
    DataSource1 : TDataSource;
    Table1N : TSmallintField;
    Table1NAPR : TStringField;
    AdvSplitter4 : TAdvSplitter;
    AdvMenuOfficeStyler1 : TAdvMenuOfficeStyler;
    AdvToolBarOfficeStyler1 : TAdvToolBarOfficeStyler;
    AdvPanel1 : TAdvPanel;
    AdvGlowButton1 : TAdvGlowButton;
    ListBox1 : TListBox;
    AdvGlowButton2 : TAdvGlowButton;
    AdvScrollBox1 : TAdvScrollBox;
    RChart1 : TRChart;
    AdvSplitter2 : TAdvSplitter;
    RChart2 : TRChart;
    AdvSplitter3 : TAdvSplitter;
    Panel1 : TAdvPanel;
    RangeSlider : TAdvRangeSlider;
    FFTPopMenu : TAdvPopupMenu;
    MagnitudeSpectrum1 : TMenuItem;
    PowerSpectrum1 : TMenuItem;
    PhaseAngle1 : TMenuItem;
    CosineTerms1 : TMenuItem;
    SineTerms1 : TMenuItem;
    RealPartofComplexSpectrum1 : TMenuItem;
    ImaginaryPartofComplexSpectrum1 : TMenuItem;
    N1 : TMenuItem;
    Rectangle1 : TMenuItem;
    Triangle1 : TMenuItem;
    Gaussian1 : TMenuItem;
    Hamming1 : TMenuItem;
    Blackman1 : TMenuItem;
    cos21 : TMenuItem;
    N2 : TMenuItem;
    LogYaxis1 : TMenuItem;
    AdvOfficeCheckBox2 : TAdvOfficeCheckBox;
    AdvOfficeCheckBox3 : TAdvOfficeCheckBox;
    AdvOfficeCheckBox4 : TAdvOfficeCheckBox;
    AdvOfficeCheckBox5 : TAdvOfficeCheckBox;
    AdvOfficeCheckBox6 : TAdvOfficeCheckBox;
    AdvOfficeCheckBox7 : TAdvOfficeCheckBox;
    AdvOfficeCheckBox8 : TAdvOfficeCheckBox;
    AdvOfficeCheckBox9 : TAdvOfficeCheckBox;
    AdvNavBarPanel3 : TAdvNavBarPanel;
    AdvSplitter1 : TAdvSplitter;
    AdvPanel2 : TAdvPanel;
    VectorDiagram1 : TVectorDiagram;
    AdvPanel3 : TAdvPanel;
    AdvPanel4 : TAdvPanel;
    AutoY : TAdvOfficeCheckBox;
    FFTType : TAdvComboBox;
    Label1 : TLabel;
    AdvSpinEdit1 : TAdvSpinEdit;
    VecU : TAdvOfficeCheckBox;
    MU : TAdvSpinEdit;
    VecI : TAdvOfficeCheckBox;
    MI : TAdvSpinEdit;
    RChart5 : TRChart;
    DBGrid1 : TDBGridEh;
    AdvScrollBox2 : TAdvScrollBox;
    DigScroll : TPropScrollbar;
    RChart3 : TRChart;
    CCmp : TAdvOfficeCheckBox;
    Table2 : TTable;
    Table2N_NAPR : TSmallintField;
    Table2USTR : TStringField;
    Procedure Button2Click(Sender : TObject);
    Procedure RChart1MouseDown(Sender : TObject; Button : TMouseButton;
      Shift : TShiftState; X, Y : Integer);
    Procedure RChart1DataRendered(Sender : TObject; Var Canvas : TCanvas;
      Top, Left : Integer);
    Procedure RChart1MouseUp(Sender : TObject; Button : TMouseButton;
      Shift : TShiftState; X, Y : Integer);
    Procedure RChart1CrossHairMove(Sender : TObject;
      WhichCrossHair : TCrossHair);
    Procedure AdvFormStyler1Change(Sender : TObject);
    Procedure RChart1ScalesRendered(Sender : TObject; Var Canvas : TCanvas;
      Top, Left : Integer);
    Procedure AdvGlowButton1Click(Sender : TObject);
    Procedure AdvGlowButton2Click(Sender : TObject);
    Procedure RangeSliderChange(Sender : TObject);
    Procedure FormCreate(Sender : TObject);
    Procedure DBGrid1GetCellParams(Sender : TObject; Column : TColumnEh;
      AFont : TFont; Var Background : TColor; State : TGridDrawState);
    Procedure DBGrid1CellClick(Column : TColumnEh);
    Procedure MagnitudeSpectrum1Click(Sender : TObject);
    Procedure Rectangle1Click(Sender : TObject);
    Procedure LogYaxis1Click(Sender : TObject);
    Procedure RChart1DblClick(Sender : TObject);
    Procedure RChart1ZoomPan(Sender : TObject);
    Procedure AdvSpinEdit1Change(Sender : TObject);
    Procedure CCmpClick(Sender : TObject);
    Procedure FormKeyDown(Sender : TObject; Var Key : Word;
      Shift : TShiftState);
    Procedure VecUClick(Sender : TObject);
    Procedure FFTTypeChange(Sender : TObject);
    Procedure AdvOfficeCheckBox3Click(Sender : TObject);
    Procedure DigScrollChange(Sender : TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    TBeg, ArrLen : Integer;
    X, Y : TReal1DArray;
    C : Array[0..PackLen, 0..19] Of TReal1DArray;
    A : Array[0..20000] Of AA;          //SmallInt;
    ZeroPoints : Array[0..12, 0..1000] Of Double;
    Upd : Boolean;
    FileList : TStringList;
    BasePath, ArxPath : String;
    FFT_OK : Boolean;
    DigArr : Array[0..1999] Of DA;
    DigList : TStringList;
  public
    { Public declarations }
    Procedure StartFFT;
    Procedure StartPhase(PosX : Double);
    Function GetRealVal(N : integer; X : Double) : Double;
    Procedure ShowGraph(Sender : TObject);
  End;

Var
  Form1             : TForm1;

Implementation

Uses
  printers;

Const
  DataColor         : Array[0..9] Of TColor = ($000000CE, clGreen, $0000CACA, clBlue, clAqua, clFuchsia, clGreen, clWhite, clOlive, clMaroon);

{$R *.DFM}

Function IsNAN(Const d : DOUBLE) : BOOLEAN;
Var
  Overlay           : Int64 absolute d;
Begin
  RESULT :=
    ((Overlay And $7FF0000000000000) = $7FF0000000000000) And
    ((Overlay And $000FFFFFFFFFFFFF) <> $0000000000000000)
End {IsNAN};

Procedure TForm1.FormCreate(Sender : TObject);
Var
  IniFile           : TIniFile;
Begin
  Upd := False;
  FileList := TStringList.Create;
  IniFile := TIniFile.create(ExtractFilePath(ParamStr(0)) + 'UDTERM.CFG');
  BasePath := IniFile.ReadString('Aliaces', 'CPPS_TSTI', '');
  ArxPath := IniFile.ReadString('Aliaces', 'GraphPath', '');
  IniFile.Free;
  Table1.DatabaseName := BasePath;
  Table1.Open;
  Table2.DatabaseName := BasePath;
  Table2.Open;
  FFT_OK := False;
  FFTType.ItemIndex := 0;
  DigList := TStringList.Create;
End;

Procedure TForm1.AdvGlowButton2Click(Sender : TObject);
Var
  x1, y1            : integer;
//  xpRes, ypRes      : integer;          { printer resolution }
//  xpSize, ypSize    : integer;          { printer paper size }
  Z                 : Double;
Begin
//  xpRes := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
//  ypRes := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
//  xpSize := GetDeviceCaps(Printer.Handle, HORZSIZE);
//  ypSize := GetDeviceCaps(Printer.Handle, VERTSIZE);

  Z := 0.7; //xpRes / Screen.PixelsPerInch * RChart1.Width;

  Printer.BeginDoc;
  x1 := 0;
  y1 := 0;
  Rchart1.CopyToOpenPrinterHiRes(x1, y1, Z, True);

  x1 := 0;
  y1 := trunc(Rchart1.Height * 4.5);
  Rchart2.CopyToOpenPrinterHiRes(x1, y1, Z, True);
  x1 := 80;
  y1 := Trunc((Rchart1.Height + Rchart2.Height) * 4.5) + 40;
  Rchart3.CopyToOpenPrinterHiRes(x1, y1, Z, True);
  Printer.EndDoc;
End;

Procedure TForm1.Button2Click(Sender : TObject);
//Var
//  S                 : String;
//  I, N, K           : Integer;
Begin
//  Memo1.Lines.LoadFromFile(ArxPath + '\MRZS_AN_ARR.LOG');
//  K := 0;
//  For I := 1 To Memo1.Lines.Count Do Begin
//    S := Memo1.Lines[I - 1];
//    Memo1.Lines[I - 1] := '';
//
//    If (Length(S) > 100) Then Begin
//      N := Pos(':', S);
//      If N > 0 Then Begin
//        Delete(S, 1, N + 10);
//        Memo1.Lines[K] := S;
//        Inc(K);
//      End;
//    End;
//
//  End;
End;

Function TForm1.GetRealVal(N : integer; X : Double) : Double;
Begin
  result := 0.0;
  Try
    If (N > PackLen) Or
      (N <= 0) Or
      (X < -TBeg) Or
      (X > ArrLen - TBeg) Then Exit;
    If Length(C[N - 1, Trunc(X + TBeg) Div 100]) > 0 Then
      Result := SplineInterpolation(C[N - 1, Trunc(X + TBeg) Div 100], X);
  Except
  End;
  If isNAN(Result) Then Result := 0;
End;


Procedure TForm1.ShowGraph(Sender : TObject);
Var
  I, J, N, V1    : Integer;
  Value     : Double;
  L                 : double;
  RChart            : TRChart;

  Procedure CheckG(GL : TList; Ind : Integer; CB : TAdvOfficeCheckBox);
  Begin
    If Ind < GL.Count Then Begin
      N := Integer(GL[Ind]);
      If CB.Checked Then N := N Or $8000 Else N := N And $7FFF;
      GL[Ind] := Pointer(N);
    End Else
      CB.Checked := False;
  End;

Begin

  CheckG(RChart1.GraphList, 0, AdvOfficeCheckBox2);
  CheckG(RChart1.GraphList, 1, AdvOfficeCheckBox3);
  CheckG(RChart1.GraphList, 2, AdvOfficeCheckBox4);
  CheckG(RChart1.GraphList, 3, AdvOfficeCheckBox5);

  CheckG(RChart2.GraphList, 0, AdvOfficeCheckBox6);
  CheckG(RChart2.GraphList, 1, AdvOfficeCheckBox7);
  CheckG(RChart2.GraphList, 2, AdvOfficeCheckBox8);
  CheckG(RChart2.GraphList, 3, AdvOfficeCheckBox9);

  For I := 1 To AdvScrollBox1.ControlCount Do
    If AdvScrollBox1.Controls[I - 1] Is TRChart Then Begin

      RChart := AdvScrollBox1.Controls[I - 1] As TRChart;
      RChart.ClearGraf;

      For J := 1 To RChart.GraphList.Count Do Begin
        N := Integer(RChart.GraphList[J - 1]);
        If (N And $7FFF > 0) And
          (N And $8000 > 0) Then Begin

          N := (N And $7FFF) - 1;

          RChart.DataColor := DataColor[J - 1];
          RChart.MoveTo(-TBeg * Masht, A[0].Val[N]);
          RChart.MarkAt(-TBeg * Masht, A[0].Val[N], 6);

          L := -TBeg;
          While L < ArrLen - TBeg - 1 Do Try
            L := L + Step;
            Value := GetRealVal(N + 1, L);
            RChart.DrawTo(L * Masht, Value);
          Except
            L := ArrLen + 1;
          End;

        End;
      End;

      RChart.ShowGraf;

    End;

  RChart3.ClearGraf;
  For J := 0 To DigList.Count - 1 Do Begin

    Pointer(N) := DigList.Objects[J];

    If DigArr[0].Val[N Div 8] And (1 Shl (N Mod 8)) > 0 Then V1 := 1 Else V1 := 0;
    If V1 > 0 Then RChart3.DataColor := clRed Else RChart3.DataColor := clRed;

    RChart3.MoveTo(DigArr[0].Time * Masht, -(J + 1) * 20 + V1 * 10);

    For I := 1 To 199 Do Begin

      RChart3.DrawTo(DigArr[I].Time * Masht, -(J + 1) * 20 + V1 * 10);

      If DigArr[I].Val[N Div 8] And (1 Shl (N Mod 8)) > 0 Then V1 := 1 Else V1 := 0;

      RChart3.DrawTo(DigArr[I].Time * Masht, -(J + 1) * 20 + V1 * 10);

      If V1 > 0 Then RChart3.DataColor := clRed Else RChart3.DataColor := clRed;

    End;

  End;
  RChart3.ShowGraf;

End;

Function ReCalc(Val : Single; N : Integer) : Single;
Const
  TransCoefs        : Array[0..7] Of Single = (80, 60, 1, 1, 1, 1, 1, 1);
Var
  W                 : Word;
  S                 : SmallInt absolute W;
  V                 : Single;
  K                 : Single;
Begin
//  If Not isNAN(Val) Then
  Try
    Case N Of
      0, 2, 4 : K := 5 * TransCoefs[N];
      1, 3, 5, 7 : K := 8 * TransCoefs[N];
      6 : K := TransCoefs[N] / 10;
    Else
      K := 0;
    End;

    K := K * 1.41;
    V := Val / K;
    If (V >= 0) And (Trunc(V) <= $FFFF) Then Begin
      W := Trunc(V);
      Result := S;                      // * K;
    End
    Else Result := 0;

  Except
    Result := 0;
  End;

End;

Procedure TForm1.AdvGlowButton1Click(Sender : TObject);
Var
  F, InStream       : TMemoryStream;
  I, J, N, K, M, Z  : Integer;
  Value, ZPoint     : Double;
  S                 : String;
  MinY, MaxY, L     : double;
  RChart            : TRChart;
  TSNum, V1, V2     : Integer;
//  SValue : Single;
//  TF                : TextFile;

  Procedure FChart;
  Begin
    RChart.ClearGraf;
//    RChart.RangeHiX := 500;
//    RChart.RangeLoX := -200;
//    RChart.RangeHiY := 100;
//    RChart.RangeLoY := -100;
    RChart.CrossHair2.PosX := 10;
    RChart.CrossHair3.PosX := 0;
    RChart.CrossHair3.PosY := 0;
    RChart.CrossHair4.PosX := 20;
  End;

Begin
  S := UpperCase(ExtractFileExt(FileList[ListBox1.ItemIndex]));

  RangeSlider.TickMark.ShowImageAtSteps := 700 Div RangeSlider.Width Div 40;

  FFT_OK := False;

  For I := 1 To AdvScrollBox1.ControlCount Do
    If AdvScrollBox1.Controls[I - 1] Is TRChart Then Begin
      RChart := AdvScrollBox1.Controls[I - 1] As TRChart;
      FChart;
    End;
  RChart := RChart3;
  FChart;

  If S = '.AAM' Then Begin

    ArrLen := 0;
    TBeg := -1;

    F := TMemoryStream.Create;

    If FileList.Count > ListBox1.ItemIndex Then Begin

////===================
//      F.LoadFromFile(ArxPath + '\' + FileList[ListBox1.ItemIndex]);
//      F.Position := 0;
//      F.Read(A[0], HeaderLen);
//      N := F.Size - HeaderLen;
//      If N > 30000 Then N := 30000;
//      F.Read(A[0], N);
//      ArrLen := N Div (PackLen * 4);
//
//      F.Clear;
//      For I := 0 To ArrLen - 1 Do Begin
//        For J := 0 To 7 Do Begin
//          SValue := ReCalc(A[I].Val[J], J);
//          F.Write(SValue, 4);
//        End;
//        F.Write(A[i].Time, 4);
//      End;
//
//      InStream := TMemoryStream.Create;
//      F.Position := 0;
//      Compress(F, InStream);
//      InStream.Position := 0;
//      InStream.SaveToFile(ArxPath + '\' + FileList[ListBox1.ItemIndex] + '1');
//      InStream.Clear;
//      F.CLear;
////==================

      InStream := TMemoryStream.Create;
      InStream.LoadFromFile(ArxPath + '\' + FileList[ListBox1.ItemIndex]);
      InStream.Position := 0;
      If InStream.Size > 0 Then Try
        If Not extract(InStream, F) Then F.Clear;
      Except
        F.Clear;
      End;
      InStream.Free;

      F.Position := 0;
      F.Read(A[0], HeaderLen);
      N := F.Size - HeaderLen;
      If N > 30000 Then N := 30000;
      F.Read(A[0], N);
      ArrLen := N Div (PackLen * 4);
      F.Free;

    End Else Begin
      F.Free;
      exit;
    End;

    RChart1.GraphList.Clear;
    RChart1.GraphList.Add(Pointer($8002));
    RChart1.GraphList.Add(Pointer($8004));
    RChart1.GraphList.Add(Pointer($8006));
    RChart1.GraphList.Add(Pointer($8008));

    RChart2.GraphList.Clear;
    RChart2.GraphList.Add(Pointer($8001));
    RChart2.GraphList.Add(Pointer($8003));
    RChart2.GraphList.Add(Pointer($8005));
    RChart2.GraphList.Add(Pointer($8007));

    DigScroll.Position := 0;

    Try
      For I := 0 To ArrLen - 1 Do Begin
        If Not IsNAN(A[i].Time) Then
          If (TBeg = -1) And (A[i].Time >= 0) Then Begin
            TBeg := i;
            Break;
          End;
      End;
    Except
      ArrLen := 0;
    End;

    Upd := False;

    N := Trunc((ArrLen - TBeg) * Masht);
    M := Trunc(-TBeg * Masht);
    If N <= M Then N := M + 1;

    RangeSlider.Min := M;
    RangeSlider.Max := N;

    RChart1ZoomPan(RChart1);

    RangeSlider.PositionLeft := RangeSlider.Min;
    RangeSlider.PositionRight := RangeSlider.Max;
    RangeSlider.TickMark.ShowImageAtSteps := (RangeSlider.Max - RangeSlider.Min) Div 10;

    Upd := True;

    SetLength(X, 102);
    SetLength(Y, 102);

    For N := 0 To PackLen - 2 Do Try
      I := 0;
      M := 0;
      While M < ArrLen Do Begin

        X[I] := M - TBeg;
        Y[I] := A[M].Val[N];

        inc(I);
        inc(M);

        If I = 102 Then Begin
          M := M - 2;
          If Length(C[N, M Div 100 - 1]) < 1000 Then SetLength(C[N, M Div 100 - 1], 1000);
          BuildCubicSpline(X, Y, 102, 0, 0, 0, 0, C[N, M Div 100 - 1]);
          I := 0;
        End;

      End;

      If I >= 100 Then Begin
        If Length(C[N, M Div 100 - 1]) < 1000 Then SetLength(C[N, M Div 100 - 1], 1000);
        BuildCubicSpline(X, Y, I, 0, 0, 0, 0, C[N, M Div 100 - 1]);
      End Else Begin
        If (I > 0) And (I < 10) Then I := 10;
        If Length(C[N, M Div 100]) < 1000 Then SetLength(C[N, M Div 100], 1000);
        BuildCubicSpline(X, Y, I, 0, 0, 0, 0, C[N, M Div 100]);
      End;

    Except
      RChart1.GraphList.Clear;
      RChart2.GraphList.Clear;
      ArrLen := 0;
      Upd := False;
      exit;
    End;

    For K := 0 To AdvScrollBox1.ControlCount - 1 Do Begin

      If AdvScrollBox1.Controls[K] Is TRChart Then Try

        RChart := AdvScrollBox1.Controls[K] As TRChart;

        MinY := 32767000;
        MaxY := -32767000;

        For J := 1 To RChart.GraphList.Count Do Begin

          N := Integer(RChart.GraphList[J - 1]);

          If (N And $7FFF > 0) And (N And $8000 > 0) Then Begin

            N := (N And $7FFF) - 1;

            Z := 0;
            ZPoint := 0;
            If A[0].Val[N] <> 0 Then ZPoint := A[0].Val[N];

            RChart.DataColor := DataColor[J - 1];

            RChart.MoveTo(-TBeg * Masht, A[0].Val[N]);
            RChart.MarkAt(-TBeg * Masht, A[0].Val[N], 5);

            L := -TBeg;
            While L < ArrLen - TBeg - 1 Do Try

              L := L + Step;

              Value := GetRealVal(N + 1, L);

              RChart.DrawTo(L * Masht, Value);

              If Not IsNAN(Value) Then
                If (Z < 1000) Then Begin
                  If (ZPoint <> 0) And (Value = 0) Then Begin
                    ZeroPoints[N, Z] := L * Masht;
                    ZPoint := -ZPoint;
                    inc(Z);
                  End Else If ((ZPoint > 0) And (Value < 0)) Or ((ZPoint < 0) And (Value > 0)) Then Begin
                    ZeroPoints[N, Z] := Masht * (L - Step * Value / (Value - ZPoint));
                    inc(Z);
                    ZPoint := Value;
                  End;
                  If (Value <> 0) Then ZPoint := Value;
                End;

              If MinY > Value Then MinY := Value;
              If MaxY < Value Then MaxY := Value;

            Except
              L := ArrLen + 1;
            End;

            ZeroPoints[N, 1000] := Z;

          End;

          RChart.MarkAt(L * Masht, Value, 5);

        End;

        If MinY > -100 Then MinY := -100;
        If MaxY < 100 Then MaxY := 100;

        If MinY <= MaxY Then Begin
          RChart.RangeLoY := MinY - (MaxY - MinY) * 0.1;
          RChart.RangeHiY := MaxY + (MaxY - MinY) * 0.1;
        End Else Begin
          RChart.RangeLoY := -100;
          RChart.RangeHiY := 100;
        End;

        RChart.ShowGraf;

      Except
      End;

    End;

    Upd := False;
  End;

//================================================

  If S = '.DAM' Then Begin

    Upd := True;


//    for J := 0 to 199 do begin
//      DigArr[J].Time := J * 20;
//      for I := 0 to 6 - 1 do
//        DigArr[J].Val[I] := Integer(Random(255));
//    end;

    F := TMemoryStream.Create;

    If FileList.Count > ListBox1.ItemIndex Then Begin

      F.LoadFromFile(ArxPath + '\' + FileList[ListBox1.ItemIndex]);

      F.Position := 0;
      //F.Read(A[0], HeaderLen);
      //N := F.Size - HeaderLen;
      //if N > 20000 then N := 20000;
      F.Read(DigArr[0], F.Size);
      F.Free;
    End Else Begin
      F.Free;
      exit;
    End;



    DigList.Clear;
    Table2.First;
    For I := 0 To DPackLen * 8 - 1 Do Begin
      DigList.AddObject(Table2USTR.Value, Pointer(I));
      Table2.Next;
    End;

    TSNum := 0;
    For I := 1 To 199 Do Begin
      For J := TSNum To DigList.Count - 1 Do Begin

        Pointer(N) := DigList.Objects[J];

        If DigArr[I - 1].Val[N Div 8] And (1 Shl (N Mod 8)) > 0 Then V1 := 1 Else V1 := 0;
        If DigArr[I].Val[N Div 8] And (1 Shl (N Mod 8)) > 0 Then V2 := 1 Else V2 := 0;

        If (V1 <> V2) Or (V1 > 0) Then Begin
          DigList.Move(J, TSNum);
          inc(TSNum);
        End;

      End;
    End;


    RChart3.ClearGraf;
    For J := 0 To DigList.Count - 1 Do Begin

      Pointer(N) := DigList.Objects[J];

      If DigArr[0].Val[N Div 8] And (1 Shl (N Mod 8)) > 0 Then V1 := 1 Else V1 := 0;
      If V1 > 0 Then RChart3.DataColor := clRed Else RChart3.DataColor := clRed;

      RChart3.MoveTo(DigArr[0].Time * Masht, -(J + 1) * 20 + V1 * 10);

      For I := 1 To 199 Do Begin

        RChart3.DrawTo(DigArr[I].Time * Masht, -(J + 1) * 20 + V1 * 10);

        If DigArr[I].Val[N Div 8] And (1 Shl (N Mod 8)) > 0 Then V1 := 1 Else V1 := 0;

        RChart3.DrawTo(DigArr[I].Time * Masht, -(J + 1) * 20 + V1 * 10);

        If V1 > 0 Then RChart3.DataColor := clRed Else RChart3.DataColor := clred;

      End;

    End;


  End;

  RChart3.ShowGraf;

  Upd := False;

End;

Procedure TForm1.RChart1MouseDown(Sender : TObject; Button : TMouseButton;
  Shift : TShiftState; X, Y : Integer);
Var
  RChart            : TRChart;
//  R                 : Trect;
  xout, yout        : Double;

Begin

  RChart := Sender As TRChart;

  If Shift = [ssLeft] Then RChart.MouseAction := maPan
  Else If Shift = [ssLeft, ssCtrl] Then RChart.MouseAction := maZoomDrag
  Else If Shift = [ssLeft, ssAlt] Then RChart.MouseAction := maDragCrossH
  Else If Shift = [ssLeft, ssShift] Then RChart.MouseAction := maZoomWind;

  If Shift = [ssRight, ssShift] Then
    If RChart.Tag = 3 Then Begin
      RChart3.M2R(x, y, xout, yout);
      yout := -yout / 20;
      If (yout > 0) And (yout < DigList.Count) Then
        DigList.Move(Trunc(yout), 0);
      ShowGraph(Self);
    End;

End;


Procedure TForm1.RChart1DataRendered(Sender : TObject; Var Canvas : TCanvas;
  Top, Left : Integer);
Var
  I, xout, yout     : integer;
  RChart            : TRChart;
Begin
  RChart := Sender As TRChart;

  RChart.R2M(0.0, 0.0, xout, yout);
  Canvas.Pen.Color := clBlue;
  Canvas.Pen.Style := psDot;
  Canvas.MoveTo(xout - Left, 0);
  Canvas.LineTo(xout - Left, RChart1.Width - 50);

  If RChart.Tag = 3 Then Begin
    Canvas.Font.Color := clWhite;
    Canvas.Brush.Style := bsClear;
    If DigList <> Nil Then
      For I := 0 To DigList.Count - 1 Do Begin
        RChart3.R2M(0.0, -(I + 1) * 20, xout, yout);
        Canvas.TextOut(0, yout - Top - 15, DigList[I]);
      End;
  End;


End;

Procedure TForm1.RChart1MouseUp(Sender : TObject; Button : TMouseButton;
  Shift : TShiftState; X, Y : Integer);
Begin
  (Sender As TRChart).MouseAction := maPan;
End;

Procedure TForm1.StartPhase(PosX : Double);
Var
  V                 : Double;
  I, N, K           : Integer;

  Function GetDelta(N : Integer) : Double;
  Var
    I               : integer;
  Begin
    Result := 0;
    If PosX < ZeroPoints[N, 0] Then exit;
    For I := 1 To Trunc(ZeroPoints[N, 1000]) Do
      If PosX < ZeroPoints[N, I] Then Begin
        Result := (PosX - ZeroPoints[N, I - 1]) / (ZeroPoints[N, I] - ZeroPoints[N, I - 1]) * 180;
        Break;
      End;

  End;

Begin

  VectorDiagram1.Vectors[0].Angle := 0;
  VectorDiagram1.Vectors[0].Value := 0;
  VectorDiagram1.Vectors[1].Angle := 0;
  VectorDiagram1.Vectors[1].Value := 0;
  VectorDiagram1.Vectors[2].Angle := 0;
  VectorDiagram1.Vectors[2].Value := 0;
  VectorDiagram1.Vectors[3].Angle := 0;
  VectorDiagram1.Vectors[3].Value := 0;
  VectorDiagram1.Vectors[4].Angle := 0;
  VectorDiagram1.Vectors[4].Value := 0;
  VectorDiagram1.Vectors[5].Angle := 0;
  VectorDiagram1.Vectors[5].Value := 0;

  K := RChart1.GraphList.Count;
  If K > 3 Then K := 3;
  If VecU.Checked Then
    For I := 1 To K Do Begin
      N := Integer(RChart1.GraphList[I - 1]);
      If N And $8000 > 0 Then Begin
        V := GetRealVal(N And $7FFF, PosX / Masht);
        If CCmp.Checked Then If V > 0 Then V := 1 Else V := -1;
        If V >= 0 Then
          VectorDiagram1.Vectors[I - 1].Angle := GetDelta(N And $7FFF - 1) / 180 * Pi
        Else
          VectorDiagram1.Vectors[I - 1].Angle := (GetDelta(N And $7FFF - 1) + 180) / 180 * Pi;
        VectorDiagram1.Vectors[I - 1].Value := Abs(V) * MU.Value;
      End;
    End;
//================================================

  K := RChart2.GraphList.Count;
  If K > 3 Then K := 3;
  If VecI.Checked Then
    For I := 1 To K Do Begin
      N := Integer(RChart2.GraphList[I - 1]);
      If N And $8000 > 0 Then Begin
        V := GetRealVal(N And $7FFF, PosX / Masht);
        If CCmp.Checked Then If V > 0 Then V := 0.5 Else V := -0.5;
        If V >= 0 Then
          VectorDiagram1.Vectors[I + 2].Angle := GetDelta(N And $7FFF - 1) / 180 * Pi
        Else
          VectorDiagram1.Vectors[I + 2].Angle := (GetDelta(N And $7FFF - 1) + 180) / 180 * Pi;
        VectorDiagram1.Vectors[I + 2].Value := Abs(V) * MI.Value;
      End;
    End;

  VectorDiagram1.Invalidate;

End;

Procedure TForm1.StartFFT;
Var
  I, N              : integer;
  y, MaxY, MinY     : Double;
Begin

  FFT1.ClearImag;

  If Not FFT_OK Then exit;

  For i := 1 To FFT1.SpectrumSize Do
    FFT1.RealSpec[i] :=
      A[i + Trunc((RChart1.CrossHair4.PosX - TBeg)/Masht)].Val[FFTType.ItemIndex]; { real value }

  FFT1.Transform;

  RChart5.ClearGraf;

  RChart5.DataColor := clRed;

  RChart5.MoveTo(FFT1.FreqOfLine(1, 0.00125), 0);

  N := 0;
  If MagnitudeSpectrum1.Checked Then N := 0;
  If PowerSpectrum1.Checked Then N := 1;
  If PhaseAngle1.Checked Then N := 2;
  If CosineTerms1.Checked Then N := 3;
  If SineTerms1.Checked Then N := 4;
  If RealPartofComplexSpectrum1.Checked Then N := 5;
  If ImaginaryPartofComplexSpectrum1.Checked Then N := 6;

  Case N Of
    0 : RChart5.Caption := FFTType.Text + '  Magnitude Spectrum';
    1 : rchart5.Caption := FFTType.Text + '  Power Spectrum';
    2 : rchart5.Caption := FFTType.Text + '  Phase Angle';
    3 : rchart5.Caption := FFTType.Text + '  Cosine Terms';
    4 : RChart5.Caption := FFTType.Text + '  Sine Terms';
    5 : RChart5.Caption := FFTType.Text + '  Real Part of Complex Spectrum';
    6 : RChart5.Caption := FFTType.Text + '  Imaginary Part of Complex Spectrum';
  End;

  MaxY := -1;
  MinY := 1;
  For i := 1 To (FFT1.SpectrumSize Div 2) Do Begin
    Case N Of
      0 : y := FFT1.Magnitude[i];
      1 : y := FFT1.PowerSpec[i];
      2 : y := FFT1.Phase[i];
      3 : y := FFT1.FourSerCosCoeff[i];
      4 : y := FFT1.FourSerSinCoeff[i];
      5 : y := FFT1.RealSpec[i + 1];
      6 : y := FFT1.ImagSpec[i + 1];
    Else y := 0;
    End;

    RChart5.DrawTo(FFT1.FreqOfLine(i, 0.00125), y);

    If y > MaxY Then MaxY := y;
    If y < MinY Then MinY := y;

  End;

  If AutoY.Checked Then Begin
    RChart5.RangeLoY := MinY * 1.1;
    RChart5.RangeHiY := MaxY * 1.1;
  End;

  RChart5.ShowGraf;

End;

Procedure TForm1.RChart1CrossHairMove(Sender : TObject;
  WhichCrossHair : TCrossHair);
Const
  LabelLen          = 40;
Var
  I                 : integer;
  RChart, Comp      : TRChart;

  Procedure FChart;
  Begin
    If Comp <> RChart Then Begin
      Case WhichCrossHair.Num Of
        1 : If Comp.CrossHair1.PosX <> RChart.CrossHair1.PosX Then
            Comp.CrossHair1.PosX := RChart.CrossHair1.PosX;
        2 : If Comp.CrossHair2.PosX <> RChart.CrossHair2.PosX Then
            Comp.CrossHair2.PosX := RChart.CrossHair2.PosX;
        3 : If Comp.CrossHair3.PosX <> RChart.CrossHair3.PosX Then
            Comp.CrossHair3.PosX := RChart.CrossHair3.PosX;
        4 : If Comp.CrossHair4.PosX <> RChart.CrossHair4.PosX Then
            Comp.CrossHair4.PosX := RChart.CrossHair4.PosX;
      End;
    End;
  End;

Begin
  If Upd Then Exit;
  Upd := true;

  RChart := Sender As TRChart;

  For I := 1 To AdvScrollBox1.ControlCount Do
    If AdvScrollBox1.Controls[I - 1] Is TRChart Then Begin
      Comp := AdvScrollBox1.Controls[I - 1] As TRChart;
      FChart;
    End;

  Comp := RChart3;
  FChart;

  If WhichCrossHair.Num = 4 Then Begin
    FFT_OK := True;
    StartFFT;
    StartPhase(WhichCrossHair.PosX);
  End;

  Upd := false;

End;

Procedure TForm1.RChart1ZoomPan(Sender : TObject);
Var
  I                 : integer;
  Comp              : TRChart;
  RChart            : TRChart;

  Procedure FChart;
  Begin
    If Comp.RangeLoX <> RChart.RangeLoX Then
      Comp.RangeLoX := RChart.RangeLoX;
    If Comp.RangeHiX <> RChart.RangeHiX Then
      Comp.RangeHiX := RChart.RangeHiX;
  End;

Begin
  If Upd Then Exit;
  Upd := true;

  RChart := Sender As TRChart;

  If RangeSlider.PositionLeft <> Trunc(RChart.RangeLoX) Then
    RangeSlider.PositionLeft := Trunc(RChart.RangeLoX);
  If RangeSlider.PositionRight <> Trunc(RChart.RangeHiX) Then
    RangeSlider.PositionRight := Trunc(RChart.RangeHiX);

  For I := 1 To AdvScrollBox1.ControlCount Do
    If AdvScrollBox1.Controls[I - 1] Is TRChart Then Begin
      Comp := AdvScrollBox1.Controls[I - 1] As TRChart;
      FChart;
    End;

  Comp := RChart3;
  FChart;

  If - Trunc(Comp.RangeHiY) <> DigScroll.Position Then
    DigScroll.Position := -Trunc(Comp.RangeHiY);

  Upd := False;
End;

Procedure TForm1.RangeSliderChange(Sender : TObject);
Var
  I                 : Integer;
  Comp              : TRChart;

  Procedure FChart;
  Begin
    If Trunc(Comp.RangeHiX) <> RangeSlider.PositionRight Then
      Comp.RangeHiX := RangeSlider.PositionRight;
    If Trunc(Comp.RangeLoX) <> RangeSlider.PositionLeft Then
      Comp.RangeLoX := RangeSlider.PositionLeft;
  End;

Begin

  If Upd Then Exit;
  Upd := true;

  For I := 1 To AdvScrollBox1.ControlCount Do
    If AdvScrollBox1.Controls[I - 1] Is TRChart Then Begin
      Comp := AdvScrollBox1.Controls[I - 1] As TRChart;
      FChart;
    End;

  Comp := RChart3;
  FChart;

  Upd := False;
End;

Procedure TForm1.RChart1DblClick(Sender : TObject);
Var
  I                 : Integer;
  Comp              : TRChart;

  Procedure FChart;
  Begin
    Comp.CrossHair1.PosX := Comp.RangeLoX + (Comp.RangeHiX - Comp.RangeLoX) / 4;
    Comp.CrossHair2.PosX := Comp.RangeLoX + (Comp.RangeHiX - Comp.RangeLoX) / 3;
    Comp.CrossHair3.PosX := Comp.RangeLoX + (Comp.RangeHiX - Comp.RangeLoX) / 2;
    Comp.CrossHair4.PosX := Comp.RangeLoX + (Comp.RangeHiX - Comp.RangeLoX) / 1.5;
    Comp.CrossHair3.PosY := Comp.RangeLoY + (Comp.RangeHiY - Comp.RangeLoY) / 2;
  End;

Begin
  If Upd Then Exit;
  Upd := true;

  For I := 1 To AdvScrollBox1.ControlCount Do
    If AdvScrollBox1.Controls[I - 1] Is TRChart Then Begin
      Comp := AdvScrollBox1.Controls[I - 1] As TRChart;
      FChart;
    End;

  Comp := RChart3;
  FChart;

  Upd := False;
End;

Procedure TForm1.RChart1ScalesRendered(Sender : TObject;
  Var Canvas : TCanvas; Top, Left : Integer);
Var
  I, N, P           : Integer;
  PosX, Dist        : double;
  RChart            : TRChart;
//  xout, yout        : Integer;
Begin

  Upd := true;

  RChart := Sender As TRChart;

  PosX := abs(RChart.CrossHair1.PosX - RChart.CrossHair2.PosX);
  Canvas.Font.Color := clYellow;
  Canvas.TextOut(RChart.Width - 70, RChart.TRim - 14,
    FloatToStrF(PosX, ffFixed, 12, 0) + ' ms');

  If RChart.RangeHiY - RChart.RangeLoY < 100 Then Begin
    If RChart.DecPlaceY <> 3 Then RChart.DecPlaceY := 3;
  End Else
    If RChart.DecPlaceY <> 1 Then RChart.DecPlaceY := 1;

  Canvas.Font.Color := clBlack;

  PosX := RChart.CrossHair3.PosX / Masht;
  Canvas.TextOut(RChart.LRim, RChart.TRim - 14,
    'X=' + FloatToStrF(RChart.CrossHair3.PosX, ffFixed, 12, 1) +
    ' Y=' + FloatToStrF(RChart.CrossHair3.PosY, ffFixed, 12, 1));

  If (PosX >= -TBeg) And (PosX < ArrLen) Then
    For I := 1 To RChart.GraphList.Count Do Begin
      N := Integer(RChart.GraphList[i - 1]) And $7FFF - 1;
      If N >= 0 Then Begin

        Canvas.Font.Color := DataColor[I - 1];

        Dist := GetRealVal(N + 1, PosX);

        If Abs(Dist) < 10 Then
          P := 3
        Else If Abs(Dist) < 100 Then
          P := 1
        Else P := 0;
        If Not isNAN(Dist) Then Try
          Canvas.TextOut(RChart.LRim + (i + 3) * LabelLen, RChart.TRim - 14, FloatToStrF(Dist, ffFixed, 12, P))
        Except
        End;
      End;
    End;

  Upd := False;

End;

Procedure TForm1.DBGrid1GetCellParams(Sender : TObject; Column : TColumnEh;
  AFont : TFont; Var Background : TColor; State : TGridDrawState);
Begin

//  If Column.CurCells.Y And 1 = 1 Then
//    Background := AdvPanelStyler1.Settings.Color //$00CAF9F9
//  Else
//    Background := AdvPanelStyler1.Settings.ColorTo; //$00ADF5F5;

  If (gdSelected In state) Or (gdfocused In State) Then Begin
    Background := clHighLight;
    AFont.Color := clWhite;
  End;


End;

Procedure TForm1.DBGrid1CellClick(Column : TColumnEh);
Var
  sr                : TSearchRec;
  FileAttrs         : Integer;
  Str, Head         : String;
  
  Procedure GetFileDate(St : String);
  Begin
    If WordCount(st, ['_', '.']) <> 9 Then exit;
    Try
      Str := Head + ExtractWord(3, St, ['_', '.']) + '/' +
        ExtractWord(2, St, ['_', '.']) + '/' + ExtractWord(1, St, ['_', '.'])
        + ' ' +
        ExtractWord(4, St, ['_', '.']) + ':' + ExtractWord(5, St, ['_', '.']) +
        ':' + ExtractWord(6, St, ['_', '.']);// + '  ' +
        //IntToStr(Trunc(Masht * (sr.Size - HeaderLen) / (PackLen * 4))) + ' ms';
      ListBox1.Items.Add(Str);
      FileList.Add(St);
    Except
    End;
  End;

Begin
  ListBox1.Clear;
  FileList.Clear;

  FileAttrs := faAnyFile + faArchive;
  Head := 'A ';
  If FindFirst(ArxPath + '\*_' + Table1N.AsString + '.AAM', FileAttrs, sr) = 0 Then Begin

    GetFileDate(sr.Name);
    While FindNext(sr) = 0 Do Begin
      GetFileDate(sr.Name);
    End;
    FindClose(sr);
  End;

  Head := 'Ä ';
  If FindFirst(ArxPath + '\*_' + Table1N.AsString + '.DAM', FileAttrs, sr) = 0 Then Begin

    GetFileDate(sr.Name);
    While FindNext(sr) = 0 Do Begin
      GetFileDate(sr.Name);
    End;
    FindClose(sr);
  End;

End;

Procedure TForm1.AdvFormStyler1Change(Sender : TObject);
Var
  I                 : Integer;
Begin
  RChart1.WindColor := AdvPanelStyler1.Settings.ColorTo;
  RChart2.WindColor := AdvPanelStyler1.Settings.ColorTo;
  RChart3.WindColor := AdvPanelStyler1.Settings.ColorTo;
  RChart5.WindColor := AdvPanelStyler1.Settings.ColorTo;
  AdvNavBarPanel1.Color := AdvPanelStyler1.Settings.ColorTo;
  AdvNavBarPanel1.ColorTo := AdvPanelStyler1.Settings.Color;
  AdvNavBarPanel2.Color := AdvPanelStyler1.Settings.ColorTo;
  AdvNavBarPanel2.ColorTo := AdvPanelStyler1.Settings.Color;
  DBGrid1.Color := AdvToolBarOfficeStyler1.DockColor.Color;
  DBGrid1.FixedColor := AdvToolBarOfficeStyler1.Color.ColorTo;
  ListBox1.Color := AdvToolBarOfficeStyler1.DockColor.Color;
  Color := AdvPanelStyler1.Settings.ColorTo;

  For I := 0 To 2 Do Begin
    VectorDiagram1.Vectors[I].Pen.Color := DataColor[I];
    VectorDiagram1.Vectors[I + 3].Pen.Color := DataColor[I];
  End;

  VectorDiagram1.Vectors[0].Name := 'Ua';
  VectorDiagram1.Vectors[1].Name := 'Ub';
  VectorDiagram1.Vectors[2].Name := 'Uc';

  VectorDiagram1.Vectors[3].Name := 'Ia';
  VectorDiagram1.Vectors[4].Name := 'Ib';
  VectorDiagram1.Vectors[5].Name := 'Ic';
End;

Procedure TForm1.MagnitudeSpectrum1Click(Sender : TObject);
Const
  ChartYRanges      : Array[0..6, 1..2] Of double =
    ((0, 500),                          { Magnitude }
    (0, 6500000),                       { PowerSpec }
    (-2, 2),                            { Phase }
    (-500, 500),                        { FourSerCosCoeff }
    (-500, 500),                        { FourSerSinCoeff }
    (-10000, 10000),                    { RealSpec }
    (-20000, 20000));                   { ImagSpec }
Var
  N                 : integer;
Begin
  If (Sender As TMenuItem).Checked Then exit;

  If Not AutoY.Checked Then Begin

    N := (Sender As TMenuItem).tag;

    Case N Of
      0, 1 : LogYaxis1.Enabled := true;
      2, 3, 4, 5, 6 : LogYaxis1.Enabled := false;
      else N := 0;
    End;

    RChart5.RangeLoY := ChartYRanges[N, 1];
    RChart5.RangeHiY := ChartYRanges[N, 2];

    If LogYaxis1.Checked Then Begin
      If N = 0 Then
        RChart5.RangeLoY := 1E-4
      Else
        RChart5.RangeLoY := 1E-6;
      RChart5.LogScaleY := true;
    End Else
      RChart5.LogScaleY := false;

  End;

  Rectangle1.Checked := false;
  MagnitudeSpectrum1.Checked := false;
  PowerSpectrum1.Checked := false;
  PhaseAngle1.Checked := false;
  CosineTerms1.Checked := false;
  SineTerms1.Checked := false;
  RealPartofComplexSpectrum1.Checked := false;
  ImaginaryPartofComplexSpectrum1.Checked := false;

  (Sender As TMenuItem).Checked := True;

  StartFFT;
End;

Procedure TForm1.Rectangle1Click(Sender : TObject);
Begin

  If (Sender As TMenuItem).Checked Then exit;

  Rectangle1.Checked := false;
  Triangle1.Checked := false;
  Gaussian1.Checked := false;
  Hamming1.Checked := false;
  Blackman1.Checked := false;
  cos21.Checked := false;

  (Sender As TMenuItem).Checked := True;

  If Rectangle1.Checked Then FFT1.WeightingWindow := fwRectangle;
  If Triangle1.Checked Then FFT1.WeightingWindow := fwTriangle;
  If Gaussian1.Checked Then FFT1.WeightingWindow := fwGauss;
  If Hamming1.Checked Then FFT1.WeightingWindow := fwHamming;
  If Blackman1.Checked Then FFT1.WeightingWindow := fwBlackman;
  If cos21.Checked Then FFT1.WeightingWindow := fwCos2;

  StartFFT;
End;

Procedure TForm1.LogYaxis1Click(Sender : TObject);
Begin
  LogYaxis1.Checked := Not LogYaxis1.Checked;

  StartFFT;
End;

Procedure TForm1.AdvSpinEdit1Change(Sender : TObject);
Begin
  If advSpinEdit1.Value >= 0 Then
    VectorDiagram1.MaxVal := advSpinEdit1.Value
  Else
    advSpinEdit1.Value := 0;

  StartPhase(RChart1.CrossHair4.PosX);

End;

Procedure TForm1.CCmpClick(Sender : TObject);
Begin
  StartPhase(RChart1.CrossHair4.PosX);
//  VectorDiagram1.FixPhase := 0;         //AdvOfficeCheckBox1.Checked;
End;

Procedure TForm1.FormKeyDown(Sender : TObject; Var Key : Word;
  Shift : TShiftState);
Var
  I, K              : Integer;
  RChart            : TRChart;
  DX, DY            : Double;

  Procedure FChart;
  Begin
    DX := (RChart.RangeHiX - RChart.RangeLoX) / 1000;
    DY := (RChart.RangeHiY - RChart.RangeLoY) / 1000;

    If RChart.Tag > 0 Then
      If Shift = [ssAlt] Then Begin
        Case K Of
          vk_left : RChart.CrossHair3.PosX := RChart.CrossHair3.PosX - DX;
          vk_right : RChart.CrossHair3.PosX := RChart.CrossHair3.PosX + DX;
          vk_up : RChart.CrossHair3.PosY := RChart.CrossHair3.PosY + DY;
          vk_down : RChart.CrossHair3.PosY := RChart.CrossHair3.PosY - DY;
        End;
        Key := 0;
      End Else If Shift = [ssAlt, ssShift] Then Begin
        Case K Of
          vk_left : RChart.CrossHair4.PosX := RChart.CrossHair4.PosX - DX;
          vk_right : RChart.CrossHair4.PosX := RChart.CrossHair4.PosX + DX;
        End;
        StartPhase(RChart.CrossHair4.PosX);
        Key := 0;
      End;
  End;

Begin
  If Upd Then Exit;
  Upd := true;

  K := Key;

  For I := 1 To AdvScrollBox1.ControlCount Do
    If AdvScrollBox1.Controls[I - 1] Is TRChart Then Begin
      RChart := AdvScrollBox1.Controls[I - 1] As TRChart;
      FChart;
    End;

  RChart := RChart3;
  FChart;

  Upd := False;
End;

Procedure TForm1.VecUClick(Sender : TObject);
Begin
  StartPhase(RChart1.CrossHair4.PosX);
End;

Procedure TForm1.FFTTypeChange(Sender : TObject);
Begin
  StartFFT;
End;

Procedure TForm1.AdvOfficeCheckBox3Click(Sender : TObject);
Begin
  ShowGraph(Self);
End;

Procedure TForm1.DigScrollChange(Sender : TObject);
Var
  Dlt               : Double;
Begin
  If - Trunc(RChart3.RangeHiY) <> DigScroll.Position Then Begin
    Dlt := RChart3.RangeHiY - RChart3.RangeLoY;
    RChart3.RangeHiY := -DigScroll.Position;
    RChart3.RangeLoY := -DigScroll.Position + Dlt;
  End;
End;

procedure TForm1.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DBGrid1CellClick(nil);
end;

End.

