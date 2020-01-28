Unit testsplineinterpolationunit;
Interface
Uses Math, Ap, Sysutils, spline3,DbugIntF;

Function TestSplineInterpolation(Silent : Boolean) : Boolean;
Function testsplineinterpolationunit_test_silent() : Boolean;
Function testsplineinterpolationunit_test() : Boolean;

Implementation

Procedure LConst(A : Double;
  B : Double;
  Const C : TReal1DArray;
  LStep : Double;
  Var L0 : Double;
  Var L1 : Double;
  Var L2 : Double); forward;
Function TestUnpack(Const C : TReal1DArray;
  Const X : TReal1DArray) : Boolean; forward;


Function TestSplineInterpolation(Silent : Boolean) : Boolean;
Var
  WasErrors         : Boolean;
  CSErrors          : Boolean;
  HSErrors          : Boolean;
  ASErrors          : Boolean;
  LSErrors          : Boolean;
  DSErrors          : Boolean;
  UPErrors          : Boolean;
  CPErrors          : Boolean;
  LTErrors          : Boolean;
  IErrors           : Boolean;
  N                 : Integer;
  I                 : Integer;
  K                 : Integer;
  Pass              : Integer;
  PassCount         : Integer;
  BLType            : Integer;
  BRType            : Integer;
  X                 : TReal1DArray;
  Y                 : TReal1DArray;
  Y2                : TReal1DArray;
  D                 : TReal1DArray;
  C                 : TReal1DArray;
  C2                : TReal1DArray;
  A                 : Double;
  B                 : Double;
  BL                : Double;
  BR                : Double;
  T                 : Double;
  SA                : Double;
  SB                : Double;
  V                 : Double;
  LStep             : Double;
  H                 : Double;
  L10               : Double;
  L11               : Double;
  L12               : Double;
  L20               : Double;
  L21               : Double;
  L22               : Double;
  S                 : Double;
  DS                : Double;
  D2S               : Double;
  S2                : Double;
  DS2               : Double;
  D2S2              : Double;
  VL                : Double;
  VM                : Double;
  VR                : Double;
  Err               : Double;
Begin
  WasErrors := False;
  PassCount := 20;
  LStep := 0.005;
  H := 0.00001;
  LSErrors := False;
  CSErrors := False;
  HSErrors := False;
  ASErrors := False;
  DSErrors := False;
  CPErrors := False;
  UPErrors := False;
  LTErrors := False;
  IErrors := False;

    //
    // General test: linear, cubic, Hermite, Akima
    //
  N := 2;
  While N <= 8 Do Begin
    SetLength(X, N - 1 + 1);
    SetLength(Y, N - 1 + 1);
    SetLength(D, N - 1 + 1);
    Pass := 1;
    While Pass <= PassCount Do Begin

            //
            // Prepare task
            //
      A := -1 - RandomReal;
      B := +1 + RandomReal;
      BL := 2 * RandomReal - 1;
      BR := 2 * RandomReal - 1;
      I := 0;
      While I <= N - 1 Do Begin
        X[I] := 0.5 * (B + A) + 0.5 * (B - A) * Cos(PI * (2 * i + 1) / (2 * n));
        If I = 0 Then Begin
          X[I] := A;
        End;
        If I = N - 1 Then Begin
          X[I] := B;
        End;
        Y[I] := Cos(1.3 * Pi * X[I] + 0.4);
        D[I] := -1.3 * Pi * Sin(1.3 * Pi * X[I] + 0.4);
        Inc(I);
      End;
      I := 0;
      While I <= N - 1 Do Begin
        K := RandomInteger(N);
        If K <> I Then Begin
          T := X[I];
          X[I] := X[K];
          X[K] := T;
          T := Y[I];
          Y[I] := Y[K];
          Y[K] := T;
          T := D[I];
          D[I] := D[K];
          D[K] := T;
        End;
        Inc(I);
      End;

            //
            // Build linear spline
            // Test for general interpolation scheme properties:
            // * values at nodes
            // * continuous function
            // Test for specific properties is implemented below.
            //
      BuildLinearSpline(X, Y, N, C);
      Err := 0;
      I := 0;
      While I <= N - 1 Do Begin
        Err := Max(Err, AbsReal(Y[I] - SplineInterpolation(C, X[I])));
        Inc(I);
      End;
      LSErrors := LSErrors Or (Err > 100 * MachineEpsilon);
      LConst(A, B, C, LStep, L10, L11, L12);
      LConst(A, B, C, LStep / 3, L20, L21, L22);
      LSErrors := LSErrors Or (L20 / L10 > 1.2);

            //
            // Build cubic spline.
            // Test for interpolation scheme properties:
            // * values at nodes
            // * boundary conditions
            // * continuous function
            // * continuous first derivative
            // * continuous second derivative
            //
      BLType := 0;
      While BLType <= 2 Do Begin
        BRType := 0;
        While BRType <= 2 Do Begin
          BuildCubicSpline(X, Y, N, BLType, BL, BRType, BR, C);
          Err := 0;
          I := 0;
          While I <= N - 1 Do Begin
            Err := Max(Err, AbsReal(Y[I] - SplineInterpolation(C, X[I])));
            Inc(I);
          End;
          CSErrors := CSErrors Or (Err > 100 * MachineEpsilon);
          Err := 0;
          If BLType = 0 Then Begin
            SplineDifferentiation(C, A - H, S, DS, D2S);
            SplineDifferentiation(C, A + H, S2, DS2, D2S2);
            T := (D2S2 - D2S) / (2 * H);
            Err := Max(Err, AbsReal(T));
          End;
          If BLType = 1 Then Begin
            T := (SplineInterpolation(C, A + H) - SplineInterpolation(C, A - H)) / (2 * H);
            Err := Max(Err, AbsReal(BL - T));
          End;
          If BLType = 2 Then Begin
            T := (SplineInterpolation(C, A + H) - 2 * SplineInterpolation(C, A) + SplineInterpolation(C, A - H)) / Sqr(H);
            Err := Max(Err, AbsReal(BL - T));
          End;
          If BRType = 0 Then Begin
            SplineDifferentiation(C, B - H, S, DS, D2S);
            SplineDifferentiation(C, B + H, S2, DS2, D2S2);
            T := (D2S2 - D2S) / (2 * H);
            Err := Max(Err, AbsReal(T));
          End;
          If BRType = 1 Then Begin
            T := (SplineInterpolation(C, B + H) - SplineInterpolation(C, B - H)) / (2 * H);
            Err := Max(Err, AbsReal(BR - T));
          End;
          If BRType = 2 Then Begin
            T := (SplineInterpolation(C, B + H) - 2 * SplineInterpolation(C, B) + SplineInterpolation(C, B - H)) / Sqr(H);
            Err := Max(Err, AbsReal(BR - T));
          End;
          CSErrors := CSErrors Or (Err > 1.0E-3);
          LConst(A, B, C, LStep, L10, L11, L12);
          LConst(A, B, C, LStep / 3, L20, L21, L22);
          CSErrors := CSErrors Or (L20 / L10 > 1.2) And (L10 > 1.0E-6);
          CSErrors := CSErrors Or (L21 / L11 > 1.2) And (L11 > 1.0E-6);
          CSErrors := CSErrors Or (L22 / L12 > 1.2) And (L12 > 1.0E-6);
          Inc(BRType);
        End;
        Inc(BLType);
      End;

            //
            // Build Hermite spline.
            // Test for interpolation scheme properties:
            // * values and derivatives at nodes
            // * continuous function
            // * continuous first derivative
            //
      BuildHermiteSpline(X, Y, D, N, C);
      Err := 0;
      I := 0;
      While I <= N - 1 Do Begin
        Err := Max(Err, AbsReal(Y[I] - SplineInterpolation(C, X[I])));
        Inc(I);
      End;
      HSErrors := HSErrors Or (Err > 100 * MachineEpsilon);
      Err := 0;
      I := 0;
      While I <= N - 1 Do Begin
        T := (SplineInterpolation(C, X[I] + H) - SplineInterpolation(C, X[I] - H)) / (2 * H);
        Err := Max(Err, AbsReal(D[I] - T));
        Inc(I);
      End;
      HSErrors := HSErrors Or (Err > 1.0E-3);
      LConst(A, B, C, LStep, L10, L11, L12);
      LConst(A, B, C, LStep / 3, L20, L21, L22);
      HSErrors := HSErrors Or (L20 / L10 > 1.2);
      HSErrors := HSErrors Or (L21 / L11 > 1.2);

            //
            // Build Akima spline
            // Test for general interpolation scheme properties:
            // * values at nodes
            // * continuous function
            // * continuous first derivative
            // Test for specific properties is implemented below.
            //
      If N >= 5 Then Begin
        BuildAkimaSpline(X, Y, N, C);
        Err := 0;
        I := 0;
        While I <= N - 1 Do Begin
          Err := Max(Err, AbsReal(Y[I] - SplineInterpolation(C, X[I])));
          Inc(I);
        End;
        ASErrors := ASErrors Or (Err > 100 * MachineEpsilon);
        LConst(A, B, C, LStep, L10, L11, L12);
        LConst(A, B, C, LStep / 3, L20, L21, L22);
        HSErrors := HSErrors Or (L20 / L10 > 1.2);
        HSErrors := HSErrors Or (L21 / L11 > 1.2);
      End;
      Inc(Pass);
    End;
    Inc(N);
  End;

    //
    // Special linear spline test:
    // test for linearity between x[i] and x[i+1]
    //
  N := 2;
  While N <= 10 Do Begin
    SetLength(X, N - 1 + 1);
    SetLength(Y, N - 1 + 1);

        //
        // Prepare task
        //
    A := -1;
    B := +1;
    I := 0;
    While I <= N - 1 Do Begin
      X[I] := A + (B - A) * I / (N - 1);
      Y[I] := 2 * RandomReal - 1;
      Inc(I);
    End;
    BuildLinearSpline(X, Y, N, C);

        //
        // Test
        //
    Err := 0;
    K := 0;
    While K <= N - 2 Do Begin
      A := X[K];
      B := X[K + 1];
      Pass := 1;
      While Pass <= PassCount Do Begin
        T := A + (B - A) * RandomReal;
        V := Y[K] + (T - A) / (B - A) * (Y[K + 1] - Y[K]);
        Err := Max(Err, AbsReal(SplineInterpolation(C, T) - V));
        Inc(Pass);
      End;
      Inc(K);
    End;
    LSErrors := LSErrors Or (Err > 100 * MachineEpsilon);
    Inc(N);
  End;

    //
    // Special Akima test: test outlier sensitivity
    // Spline value at (x[i], x[i+1]) should depend from
    // f[i-2], f[i-1], f[i], f[i+1], f[i+2], f[i+3] only.
    //
  N := 5;
  While N <= 10 Do Begin
    SetLength(X, N - 1 + 1);
    SetLength(Y, N - 1 + 1);
    SetLength(Y2, N - 1 + 1);

        //
        // Prepare unperturbed Akima spline
        //
    A := -1;
    B := +1;
    I := 0;
    While I <= N - 1 Do Begin
      X[I] := A + (B - A) * I / (N - 1);
      Y[I] := Cos(1.3 * Pi * X[I] + 0.4);
      Inc(I);
    End;
    BuildAkimaSpline(X, Y, N, C);

        //
        // Process perturbed tasks
        //
    Err := 0;
    K := 0;
    While K <= N - 1 Do Begin
      APVMove(@Y2[0], 0, N - 1, @Y[0], 0, N - 1);
      Y2[K] := 5;
      BuildAkimaSpline(X, Y2, N, C2);

            //
            // Test left part independence
            //
      If K - 3 >= 1 Then Begin
        A := -1;
        B := X[K - 3];
        Pass := 1;
        While Pass <= PassCount Do Begin
          T := A + (B - A) * RandomReal;
          Err := Max(Err, AbsReal(SplineInterpolation(C, T) - SplineInterpolation(C2, T)));
          Inc(Pass);
        End;
      End;

            //
            // Test right part independence
            //
      If K + 3 <= N - 2 Then Begin
        A := X[K + 3];
        B := +1;
        Pass := 1;
        While Pass <= PassCount Do Begin
          T := A + (B - A) * RandomReal;
          Err := Max(Err, AbsReal(SplineInterpolation(C, T) - SplineInterpolation(C2, T)));
          Inc(Pass);
        End;
      End;
      Inc(K);
    End;
    ASErrors := ASErrors Or (Err > 100 * MachineEpsilon);
    Inc(N);
  End;

    //
    // Differentiation, unpack test
    //
  N := 2;
  While N <= 10 Do Begin
    SetLength(X, N - 1 + 1);
    SetLength(Y, N - 1 + 1);

        //
        // Prepare cubic spline
        //
    A := -1 - RandomReal;
    B := +1 + RandomReal;
    I := 0;
    While I <= N - 1 Do Begin
      X[I] := A + (B - A) * I / (N - 1);
      Y[I] := Cos(1.3 * Pi * X[I] + 0.4);
      Inc(I);
    End;
    BuildCubicSpline(X, Y, N, 2, 0.0, 2, 0.0, C);

        //
        // Test diff
        //
    Err := 0;
    Pass := 1;
    While Pass <= PassCount Do Begin
      T := A + (B - A) * RandomReal;
      SplineDifferentiation(C, T, S, DS, D2S);
      VL := SplineInterpolation(C, T - H);
      VM := SplineInterpolation(C, T);
      VR := SplineInterpolation(C, T + H);
      Err := Max(Err, AbsReal(S - VM));
      Err := Max(Err, AbsReal(DS - (VR - VL) / (2 * H)));
      Err := Max(Err, AbsReal(D2S - (VR - 2 * VM + VL) / Sqr(H)));
      Inc(Pass);
    End;
    DSErrors := DSErrors Or (Err > 0.001);

        //
        // Test copy
        //
    SplineCopy(C, C2);
    Err := 0;
    Pass := 1;
    While Pass <= PassCount Do Begin
      T := A + (B - A) * RandomReal;
      Err := Max(Err, AbsReal(SplineInterpolation(C, T) - SplineInterpolation(C2, T)));
      Inc(Pass);
    End;
    CPErrors := CPErrors Or (Err > 100 * MachineEpsilon);

        //
        // Test unpack
        //
    UPErrors := UPErrors Or Not TestUnpack(C, X);

        //
        // Test lin.trans.
        //
    Err := 0;
    Pass := 1;
    While Pass <= PassCount Do Begin

            //
            // LinTransX, general A
            //
      SA := 4 * RandomReal - 2;
      SB := 2 * RandomReal - 1;
      T := A + (B - A) * RandomReal;
      SplineCopy(C, C2);
      SplineLinTransX(C2, SA, SB);
      Err := Max(Err, AbsReal(SplineInterpolation(C, T) - SplineInterpolation(C2, (T - SB) / SA)));

            //
            // LinTransX, special case: A=0
            //
      SB := 2 * RandomReal - 1;
      T := A + (B - A) * RandomReal;
      SplineCopy(C, C2);
      SplineLinTransX(C2, 0, SB);
      Err := Max(Err, AbsReal(SplineInterpolation(C, SB) - SplineInterpolation(C2, T)));

            //
            // LinTransY
            //
      SA := 2 * RandomReal - 1;
      SB := 2 * RandomReal - 1;
      T := A + (B - A) * RandomReal;
      SplineCopy(C, C2);
      SplineLinTransY(C2, SA, SB);
      Err := Max(Err, AbsReal(SA * SplineInterpolation(C, T) + SB - SplineInterpolation(C2, T)));
      Inc(Pass);
    End;
    LTErrors := LTErrors Or (Err > 100 * MachineEpsilon);
    Inc(N);
  End;

    //
    // Testing integration
    //
  Err := 0;
  N := 20;
  While N <= 35 Do Begin
    SetLength(X, N - 1 + 1);
    SetLength(Y, N - 1 + 1);
    Pass := 1;
    While Pass <= PassCount Do Begin

            //
            // Prepare cubic spline
            //
      A := -1 - 0.2 * RandomReal;
      B := +1 + 0.2 * RandomReal;
      I := 0;
      While I <= N - 1 Do Begin
        X[I] := A + (B - A) * I / (N - 1);
        Y[I] := Sin(Pi * X[I] + 0.4) + Exp(X[I]);
        Inc(I);
      End;
      BL := Pi * Cos(Pi * A + 0.4) + Exp(A);
      BR := Pi * Cos(Pi * B + 0.4) + Exp(B);
      BuildCubicSpline(X, Y, N, 1, BL, 1, BR, C);

            //
            // Test
            //
      T := A + (B - A) * RandomReal;
      V := -Cos(Pi * A + 0.4) / Pi + Exp(A);
      V := -Cos(Pi * T + 0.4) / Pi + Exp(T) - V;
      V := V - SplineIntegration(C, T);
      Err := Max(Err, AbsReal(V));
      Inc(Pass);
    End;
    Inc(N);
  End;
  IErrors := IErrors Or (Err > 0.001);

    //
    // report
    //
  WasErrors := LSErrors Or CSErrors Or HSErrors Or ASErrors Or DSErrors Or CPErrors Or UPErrors Or LTErrors Or IErrors;
  If Not Silent Then Begin
    SendDebug(Format('TESTING SPLINE INTERPOLATION', []));

        //
        // Normal tests
        //
    SendDebug(Format('LINEAR SPLINE TEST:                      ', []));
    If LSErrors Then Begin
      SendDebug(Format('FAILED', []));
    End
    Else Begin
      SendDebug(Format('OK', []));
    End;
    SendDebug(Format('CUBIC SPLINE TEST:                       ', []));
    If CSErrors Then Begin
      SendDebug(Format('FAILED', []));
    End
    Else Begin
      SendDebug(Format('OK', []));
    End;
    SendDebug(Format('HERMITE SPLINE TEST:                     ', []));
    If HSErrors Then Begin
      SendDebug(Format('FAILED', []));
    End
    Else Begin
      SendDebug(Format('OK', []));
    End;
    SendDebug(Format('AKIMA SPLINE TEST:                       ', []));
    If ASErrors Then Begin
      SendDebug(Format('FAILED', []));
    End
    Else Begin
    SendDebug(Format('OK', []));
    End;
    SendDebug(Format('DIFFERENTIATION TEST:                    ', []));
    If DSErrors Then Begin
      SendDebug(Format('FAILED', []));
    End
    Else Begin
      SendDebug(Format('OK', []));
    End;
    SendDebug(Format('COPY TEST:                               ', []));
    If CPErrors Then Begin
      SendDebug(Format('FAILED', []));
    End
    Else Begin
      SendDebug(Format('OK', []));
    End;
    SendDebug(Format('UNPACK TEST:                             ', []));
    If UPErrors Then Begin
      SendDebug(Format('FAILED', []));
    End
    Else Begin
      SendDebug(Format('OK', []));
    End;
    SendDebug(Format('LIN.TRANS. TEST:                         ', []));
    If LTErrors Then Begin
      SendDebug(Format('FAILED', []));
    End
    Else Begin
      SendDebug(Format('OK', []));
    End;
    SendDebug(Format('INTEGRATION TEST:                        ', []));
    If IErrors Then Begin
      SendDebug(Format('FAILED', []));
    End
    Else Begin
      SendDebug(Format('OK', []));
    End;
    If WasErrors Then Begin
      SendDebug(Format('TEST FAILED', []));
    End
    Else Begin
      SendDebug(Format('TEST PASSED', []));
    End;
  End;

    //
    // end
    //
  Result := Not WasErrors;
End;


(*************************************************************************
Lipschitz constants for spline inself, first and second derivatives.
*************************************************************************)

Procedure LConst(A : Double;
  B : Double;
  Const C : TReal1DArray;
  LStep : Double;
  Var L0 : Double;
  Var L1 : Double;
  Var L2 : Double);
Var
  T                 : Double;
  VL                : Double;
  VM                : Double;
  VR                : Double;
  PrevF             : Double;
  PrevD             : Double;
  PrevD2            : Double;
  F                 : Double;
  D                 : Double;
  D2                : Double;
Begin
  L0 := 0;
  L1 := 0;
  L2 := 0;
  T := A - 0.1;
  VL := SplineInterpolation(C, T - 2 * LStep);
  VM := SplineInterpolation(C, T - LStep);
  VR := SplineInterpolation(C, T);
  F := VM;
  D := (VR - VL) / (2 * LStep);
  D2 := (VR - 2 * VM + VL) / Sqr(LStep);
  While T <= B + 0.1 Do Begin
    PrevF := F;
    PrevD := D;
    PrevD2 := D2;
    VL := VM;
    VM := VR;
    VR := SplineInterpolation(C, T + LStep);
    F := VM;
    D := (VR - VL) / (2 * LStep);
    D2 := (VR - 2 * VM + VL) / Sqr(LStep);
    L0 := Max(L0, AbsReal((F - PrevF) / LStep));
    L1 := Max(L1, AbsReal((D - PrevD) / LStep));
    L2 := Max(L2, AbsReal((D2 - PrevD2) / LStep));
    T := T + LStep;
  End;
End;


(*************************************************************************
Lipschitz constants for spline inself, first and second derivatives.
*************************************************************************)

Function TestUnpack(Const C : TReal1DArray; Const X : TReal1DArray) : Boolean;
Var
  I                 : Integer;
  N                 : Integer;
  Err               : Double;
  T                 : Double;
  V1                : Double;
  V2                : Double;
  Pass              : Integer;
  PassCount         : Integer;
  Tbl               : TReal2DArray;
Begin
  PassCount := 20;
  Err := 0;
  SplineUnpack(C, N, Tbl);
  I := 0;
  While I <= N - 2 Do Begin
    Pass := 1;
    While Pass <= PassCount Do Begin
      T := RandomReal * (Tbl[I, 1] - Tbl[I, 0]);
      V1 := Tbl[I, 2] + T * Tbl[I, 3] + Sqr(T) * Tbl[I, 4] + T * Sqr(T) * Tbl[I, 5];
      V2 := SplineInterpolation(C, Tbl[I, 0] + T);
      Err := Max(Err, AbsReal(V1 - V2));
      Inc(Pass);
    End;
    Inc(I);
  End;
  I := 0;
  While I <= N - 2 Do Begin
    Err := Max(Err, AbsReal(X[I] - Tbl[I, 0]));
    Inc(I);
  End;
  I := 0;
  While I <= N - 2 Do Begin
    Err := Max(Err, AbsReal(X[I + 1] - Tbl[I, 1]));
    Inc(I);
  End;
  Result := Err < 100 * MachineEpsilon;
End;


(*************************************************************************
Silent unit test
*************************************************************************)

Function testsplineinterpolationunit_test_silent() : Boolean;
Begin
  Result := TestSplineInterpolation(True);
End;


(*************************************************************************
Unit test
*************************************************************************)

Function testsplineinterpolationunit_test() : Boolean;
Begin
  Result := TestSplineInterpolation(False);
End;


End.

