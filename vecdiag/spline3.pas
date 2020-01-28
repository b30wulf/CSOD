(*************************************************************************
Copyright (c) 2007, Sergey Bochkanov (ALGLIB project).

>>> SOURCE LICENSE >>>
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation (www.fsf.org); either version 2 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

A copy of the GNU General Public License is available at
http://www.fsf.org/licensing/licenses

>>> END OF LICENSE >>>
*************************************************************************)
Unit spline3;
Interface
Uses Math, Ap, Sysutils;

Procedure BuildLinearSpline(X : TReal1DArray;
  Y : TReal1DArray;
  N : Integer;
  Var C : TReal1DArray);

Procedure BuildCubicSpline(X : TReal1DArray;
  Y : TReal1DArray;
  N : Integer;
  BoundLType : Integer;
  BoundL : Double;
  BoundRType : Integer;
  BoundR : Double;
  Var C : TReal1DArray);

Procedure BuildHermiteSpline(X : TReal1DArray;
  Y : TReal1DArray;
  D : TReal1DArray;
  N : Integer;
  Var C : TReal1DArray);

Procedure BuildAkimaSpline(X : TReal1DArray;
  Y : TReal1DArray;
  N : Integer;
  Var C : TReal1DArray);

Function SplineInterpolation(Const C : TReal1DArray; X : Double) : Double;

Procedure SplineDifferentiation(Const C : TReal1DArray;
  X : Double;
  Var S : Double;
  Var DS : Double;
  Var D2S : Double);

Procedure SplineCopy(Const C : TReal1DArray; Var CC : TReal1DArray);

Procedure SplineUnpack(Const C : TReal1DArray;
  Var N : Integer;
  Var Tbl : TReal2DArray);

Procedure SplineLinTransX(Var C : TReal1DArray; A : Double; B : Double);

Procedure SplineLinTransY(Var C : TReal1DArray; A : Double; B : Double);

Function SplineIntegration(Const C : TReal1DArray; X : Double) : Double;

Procedure Spline3BuildTable(N : Integer;
  Const DiffN : Integer;
  x : TReal1DArray;
  y : TReal1DArray;
  Const BoundL : Double;
  Const BoundR : Double;
  Var ctbl : TReal2DArray);

Function Spline3Interpolate(N : Integer;
  Const c : TReal2DArray;
  Const X : Double) : Double;

Implementation

Procedure HeapSortPoints(Var X : TReal1DArray;
  Var Y : TReal1DArray;
  N : Integer); forward;

Procedure HeapSortDPoints(Var X : TReal1DArray;
  Var Y : TReal1DArray;
  Var D : TReal1DArray;
  N : Integer); forward;

Procedure SolveTridiagonal(A : TReal1DArray;
  B : TReal1DArray;
  C : TReal1DArray;
  D : TReal1DArray;
  N : Integer;
  Var X : TReal1DArray); forward;

Function DiffThreePoint(T : Double;
  X0 : Double;
  F0 : Double;
  X1 : Double;
  F1 : Double;
  X2 : Double;
  F2 : Double) : Double; forward;


(*************************************************************************
Построение таблицы коэффициентов кусочно-линейного сплайна

Входные параметры:
    X           -   абсциссы, массив с нумерацией элементов [0..N-1]
    Y           -   значения функции,
                    массив с нумерацией элементов [0..N-1]
    N           -   число точек, N>=2

Выходные параметры:
    C           -   таблица коэффициентов сплайна для использования в
                    подпрограмме SplineInterpolation

  -- ALGLIB PROJECT --
     Copyright 24.06.2007 by Bochkanov Sergey
*************************************************************************)

Procedure BuildLinearSpline(X : TReal1DArray;
  Y : TReal1DArray;
  N : Integer;
  Var C : TReal1DArray);
Var
  I                 : Integer;
  TblSize           : Integer;
Begin
  X := DynamicArrayCopy(X);
  Y := DynamicArrayCopy(Y);
  Assert(N >= 2, 'BuildLinearSpline: N<2!');

    //
    // Sort points
    //
  HeapSortPoints(X, Y, N);

    //
    // Fill C:
    //  C[0]            -   length(C)
    //  C[1]            -   type(C):
    //                      3 - general cubic spline
    //  C[2]            -   N
    //  C[3]...C[3+N-1] -   x[i], i = 0...N-1
    //  C[3+N]...C[3+N+(N-1)*4-1] - coefficients table
    //
  TblSize := 3 + N + (N - 1) * 4;
  SetLength(C, TblSize - 1 + 1);
  C[0] := TblSize;
  C[1] := 3;
  C[2] := N;
  I := 0;
  While I <= N - 1 Do Begin
    C[3 + I] := X[I];
    Inc(I);
  End;
  I := 0;
  While I <= N - 2 Do Begin
    C[3 + N + 4 * I + 0] := Y[I];
    C[3 + N + 4 * I + 1] := (Y[I + 1] - Y[I]) / (X[I + 1] - X[I]);
    C[3 + N + 4 * I + 2] := 0;
    C[3 + N + 4 * I + 3] := 0;
    Inc(I);
  End;
End;


(*************************************************************************
Построение таблицы коэффициентов кубического сплайна

Входные параметры:
    X           -   абсциссы, массив с нумерацией элементов [0..N-1]
    Y           -   значения функции,
                    массив с нумерацией элементов [0..N-1]
    N           -   число точек, N>=2
    BoundLType  -   тип граничного условия (левая граница)
    BoundL      -   значение первой (или второй, в зависимости от
                    BoundType) производной сплайна на левой границе
    BoundRType  -   тип граничного условия (правая граница)
    BoundR      -   значение первой (или второй, в зависимости от
                    BoundType) производной сплайна на правой границе

Выходные параметры:
    C           -   таблица коэффициентов сплайна для использования в
                    подпрограмме SplineInterpolation

Параметры BoundLType/BoundRType задают тип граничного условия и  принимают
следующие значения:
    * 0, что соответствует граничному условию типа "сплайн, завершающийся
      параболой" (при этом значения BoundL/BoundR игнорируются).
    * 1, что соответствует граничному условию для первой производной
    * 2, что соответствует граничному условию для второй производной

  -- ALGLIB PROJECT --
     Copyright 23.06.2007 by Bochkanov Sergey
*************************************************************************)

Procedure BuildCubicSpline(X : TReal1DArray;
  Y : TReal1DArray;
  N : Integer;
  BoundLType : Integer;
  BoundL : Double;
  BoundRType : Integer;
  BoundR : Double;
  Var C : TReal1DArray);
Var
  A1                : TReal1DArray;
  A2                : TReal1DArray;
  A3                : TReal1DArray;
  B                 : TReal1DArray;
  D                 : TReal1DArray;
  I                 : Integer;
  TblSize           : Integer;
  Delta             : Double;
  Delta2            : Double;
  Delta3            : Double;
Begin
  X := DynamicArrayCopy(X);
  Y := DynamicArrayCopy(Y);
  Assert(N >= 2, 'BuildCubicSpline: N<2!');
  Assert((BoundLType = 0) Or (BoundLType = 1) Or (BoundLType = 2), 'BuildCubicSpline: incorrect BoundLType!');
  Assert((BoundRType = 0) Or (BoundRType = 1) Or (BoundRType = 2), 'BuildCubicSpline: incorrect BoundRType!');
  SetLength(A1, N - 1 + 1);
  SetLength(A2, N - 1 + 1);
  SetLength(A3, N - 1 + 1);
  SetLength(B, N - 1 + 1);

    //
    // Special case:
    // * N=2
    // * parabolic terminated boundary condition on both ends
    //
  If (N = 2) And (BoundLType = 0) And (BoundRType = 0) Then Begin

        //
        // Change task type
        //
    BoundLType := 2;
    BoundL := 0;
    BoundRType := 2;
    BoundR := 0;
  End;

    //
    //
    // Sort points
    //
  HeapSortPoints(X, Y, N);

    //
    // Left boundary conditions
    //
  If BoundLType = 0 Then Begin
    A1[0] := 0;
    A2[0] := 1;
    A3[0] := 1;
    B[0] := 2 * (Y[1] - Y[0]) / (X[1] - X[0]);
  End;
  If BoundLType = 1 Then Begin
    A1[0] := 0;
    A2[0] := 1;
    A3[0] := 0;
    B[0] := BoundL;
  End;
  If BoundLType = 2 Then Begin
    A1[0] := 0;
    A2[0] := 2;
    A3[0] := 1;
    B[0] := 3 * (Y[1] - Y[0]) / (X[1] - X[0]) - 0.5 * BoundL * (X[1] - X[0]);
  End;

    //
    // Central conditions
    //
  I := 1;
  While I <= N - 2 Do Begin
    A1[I] := X[I + 1] - X[I];
    A2[I] := 2 * (X[I + 1] - X[I - 1]);
    A3[I] := X[I] - X[I - 1];
    B[I] := 3 * (Y[I] - Y[I - 1]) / (X[I] - X[I - 1]) * (X[I + 1] - X[I]) + 3 * (Y[I + 1] - Y[I]) / (X[I + 1] - X[I]) * (X[I] - X[I - 1]);
    Inc(I);
  End;

    //
    // Right boundary conditions
    //
  If BoundRType = 0 Then Begin
    A1[N - 1] := 1;
    A2[N - 1] := 1;
    A3[N - 1] := 0;
    B[N - 1] := 2 * (Y[N - 1] - Y[N - 2]) / (X[N - 1] - X[N - 2]);
  End;
  If BoundRType = 1 Then Begin
    A1[N - 1] := 0;
    A2[N - 1] := 1;
    A3[N - 1] := 0;
    B[N - 1] := BoundR;
  End;
  If BoundRType = 2 Then Begin
    A1[N - 1] := 1;
    A2[N - 1] := 2;
    A3[N - 1] := 0;
    B[N - 1] := 3 * (Y[N - 1] - Y[N - 2]) / (X[N - 1] - X[N - 2]) + 0.5 * BoundR * (X[N - 1] - X[N - 2]);
  End;

    //
    // Solve
    //
  SolveTridiagonal(A1, A2, A3, B, N, D);

    //
    // Now problem is reduced to the cubic Hermite spline
    //
  BuildHermiteSpline(X, Y, D, N, C);
End;


(*************************************************************************
Построение таблицы коэффициентов сплайна Эрмита

Входные параметры:
    X           -   абсциссы, массив с нумерацией элементов [0..N-1]
    Y           -   значения функции,
                    массив с нумерацией элементов [0..N-1]
    D           -   значения производной,
                    массив с нумерацией элементов [0..N-1]
    N           -   число точек, N>=2

Выходные параметры:
    C           -   таблица коэффициентов сплайна для использования в
                    подпрограмме SplineInterpolation

  -- ALGLIB PROJECT --
     Copyright 23.06.2007 by Bochkanov Sergey
*************************************************************************)

Procedure BuildHermiteSpline(X : TReal1DArray;
  Y : TReal1DArray;
  D : TReal1DArray;
  N : Integer;
  Var C : TReal1DArray);
Var
  I                 : Integer;
  TblSize           : Integer;
  Delta             : Double;
  Delta2            : Double;
  Delta3            : Double;
Begin
  X := DynamicArrayCopy(X);
  Y := DynamicArrayCopy(Y);
  D := DynamicArrayCopy(D);
  Assert(N >= 2, 'BuildHermiteSpline: N<2!');

    //
    // Sort points
    //
  HeapSortDPoints(X, Y, D, N);

    //
    // Fill C:
    //  C[0]            -   length(C)
    //  C[1]            -   type(C):
    //                      3 - general cubic spline
    //  C[2]            -   N
    //  C[3]...C[3+N-1] -   x[i], i = 0...N-1
    //  C[3+N]...C[3+N+(N-1)*4-1] - coefficients table
    //
  TblSize := 3 + N + (N - 1) * 4;
  SetLength(C, TblSize - 1 + 1);
  C[0] := TblSize;
  C[1] := 3;
  C[2] := N;
  I := 0;
  While I <= N - 1 Do Begin
    C[3 + I] := X[I];
    Inc(I);
  End;
  I := 0;
  While I <= N - 2 Do Begin
    Delta := X[I + 1] - X[I];
    Delta2 := Sqr(Delta);
    Delta3 := Delta * Delta2;
    C[3 + N + 4 * I + 0] := Y[I];
    C[3 + N + 4 * I + 1] := D[I];
    C[3 + N + 4 * I + 2] := (3 * (Y[I + 1] - Y[I]) - 2 * D[I] * Delta - D[I + 1] * Delta) / Delta2;
    C[3 + N + 4 * I + 3] := (2 * (Y[I] - Y[I + 1]) + D[I] * Delta + D[I + 1] * Delta) / Delta3;
    Inc(I);
  End;
End;


(*************************************************************************
Построение таблицы коэффициентов сплайна Акимы

Входные параметры:
    X           -   абсциссы, массив с нумерацией элементов [0..N-1]
    Y           -   значения функции,
                    массив с нумерацией элементов [0..N-1]
    N           -   число точек, N>=5

Выходные параметры:
    C           -   таблица коэффициентов сплайна для использования в
                    подпрограмме SplineInterpolation

  -- ALGLIB PROJECT --
     Copyright 24.06.2007 by Bochkanov Sergey
*************************************************************************)

Procedure BuildAkimaSpline(X : TReal1DArray;
  Y : TReal1DArray;
  N : Integer;
  Var C : TReal1DArray);
Var
  I                 : Integer;
  D                 : TReal1DArray;
  W                 : TReal1DArray;
  Diff              : TReal1DArray;
Begin
  X := DynamicArrayCopy(X);
  Y := DynamicArrayCopy(Y);
  Assert(N >= 5, 'BuildAkimaSpline: N<5!');

    //
    // Sort points
    //
  HeapSortPoints(X, Y, N);

    //
    // Prepare W (weights), Diff (divided differences)
    //
  SetLength(W, N - 2 + 1);
  SetLength(Diff, N - 2 + 1);
  I := 0;
  While I <= N - 2 Do Begin
    Diff[I] := (Y[I + 1] - Y[I]) / (X[I + 1] - X[I]);
    Inc(I);
  End;
  I := 1;
  While I <= N - 2 Do Begin
    W[I] := AbsReal(Diff[I] - Diff[I - 1]);
    Inc(I);
  End;

    //
    // Prepare Hermite interpolation scheme
    //
  SetLength(D, N - 1 + 1);
  I := 2;
  While I <= N - 3 Do Begin
    If AbsReal(W[I - 1]) + AbsReal(W[I + 1]) <> 0 Then Begin
      D[I] := (W[I + 1] * Diff[I - 1] + W[I - 1] * Diff[I]) / (W[I + 1] + W[I - 1]);
    End
    Else Begin
      D[I] := ((X[I + 1] - X[I]) * Diff[I - 1] + (X[I] - X[I - 1]) * Diff[I]) / (X[I + 1] - X[I - 1]);
    End;
    Inc(I);
  End;
  D[0] := DiffThreePoint(X[0], X[0], Y[0], X[1], Y[1], X[2], Y[2]);
  D[1] := DiffThreePoint(X[1], X[0], Y[0], X[1], Y[1], X[2], Y[2]);
  D[N - 2] := DiffThreePoint(X[N - 2], X[N - 3], Y[N - 3], X[N - 2], Y[N - 2], X[N - 1], Y[N - 1]);
  D[N - 1] := DiffThreePoint(X[N - 1], X[N - 3], Y[N - 3], X[N - 2], Y[N - 2], X[N - 1], Y[N - 1]);

    //
    // Build Akima spline using Hermite interpolation scheme
    //
  BuildHermiteSpline(X, Y, D, N, C);
End;


(*************************************************************************
Вычисление интерполирующего сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна.
    X   -   точка, в которой вычисляется значение сплайна

Результат:
    значение сплайна в точке X

  -- ALGLIB PROJECT --
     Copyright 23.06.2007 by Bochkanov Sergey
*************************************************************************)

Function SplineInterpolation(Const C : TReal1DArray; X : Double) : Double;
Var
  N                 : Integer;
  L                 : Integer;
  R                 : Integer;
  M                 : Integer;
Begin
  Assert(Round(C[1]) = 3, 'SplineInterpolation: incorrect C!');
  N := Round(C[2]);

  if N = 0 then begin
    Result := 0;
    exit;
  end;

  //
  // Binary search in the [ x[0], ..., x[n-2] ] (x[n-1] is not included)
  //
  L := 3;
  R := 3 + N - 2 + 1;
  While L <> R - 1 Do Begin
    M := (L + R) Div 2;
    If C[M] >= X Then Begin
      R := M;
    End
    Else Begin
      L := M;
    End;
  End;

    //
    // Interpolation
    //
  X := X - C[L];
  M := 3 + N + 4 * (L - 3);
  Result := C[M] + X * (C[M + 1] + X * (C[M + 2] + X * C[M + 3]));
End;


(*************************************************************************
Дифференцирование сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна.
    X   -   точка, в которой вычисляется значение сплайна

Выходные параметры:
    S   -   значение сплайна в точке X
    DS  -   первая производная в точке X
    D2S -   вторая производная в точке X

  -- ALGLIB PROJECT --
     Copyright 24.06.2007 by Bochkanov Sergey
*************************************************************************)

Procedure SplineDifferentiation(Const C : TReal1DArray;
  X : Double;
  Var S : Double;
  Var DS : Double;
  Var D2S : Double);
Var
  N                 : Integer;
  L                 : Integer;
  R                 : Integer;
  M                 : Integer;
Begin
  Assert(Round(C[1]) = 3, 'SplineInterpolation: incorrect C!');
  N := Round(C[2]);

    //
    // Binary search
    //
  L := 3;
  R := 3 + N - 2 + 1;
  While L <> R - 1 Do Begin
    M := (L + R) Div 2;
    If C[M] >= X Then Begin
      R := M;
    End
    Else Begin
      L := M;
    End;
  End;

    //
    // Differentiation
    //
  X := X - C[L];
  M := 3 + N + 4 * (L - 3);
  S := C[M] + X * (C[M + 1] + X * (C[M + 2] + X * C[M + 3]));
  DS := C[M + 1] + 2 * X * C[M + 2] + 3 * Sqr(X) * C[M + 3];
  D2S := 2 * C[M + 2] + 6 * X * C[M + 3];
End;


(*************************************************************************
Копирование

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна.

Выходные параметры:
    CC  -   копия сплайна


  -- ALGLIB PROJECT --
     Copyright 29.06.2007 by Bochkanov Sergey
*************************************************************************)

Procedure SplineCopy(Const C : TReal1DArray; Var CC : TReal1DArray);
Var
  S                 : Integer;
Begin
  S := Round(C[0]);
  SetLength(CC, S - 1 + 1);
  APVMove(@CC[0], 0, S - 1, @C[0], 0, S - 1);
End;


(*************************************************************************
Распаковка сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна.

Выходные параметры:
    N   -   число точек, на основе которых был построен сплайн
    Tbl -   таблица коэффициентов сплайна. Массив с нумерацией элементов
            [0..N-2, 0..5].
            Для I = 0..N-2:
                Tbl[I,0] = X[i]
                Tbl[I,1] = X[i+1]
                Tbl[I,2] = C0
                Tbl[I,3] = C1
                Tbl[I,4] = C2
                Tbl[I,5] = C3
            Сплайн имеет вид:
                t = x-x[i]
                S(x) = C0 + C1*t + C2*t^2 + C3*t^3

  -- ALGLIB PROJECT --
     Copyright 29.06.2007 by Bochkanov Sergey
*************************************************************************)

Procedure SplineUnpack(Const C : TReal1DArray;
  Var N : Integer;
  Var Tbl : TReal2DArray);
Var
  I                 : Integer;
Begin
  Assert(Round(C[1]) = 3, 'SplineUnpack: incorrect C!');
  N := Round(C[2]);
  SetLength(Tbl, N - 2 + 1, 5 + 1);

    //
    // Fill
    //
  I := 0;
  While I <= N - 2 Do Begin
    Tbl[I, 0] := C[3 + I];
    Tbl[I, 1] := C[3 + I + 1];
    Tbl[I, 2] := C[3 + N + 4 * I];
    Tbl[I, 3] := C[3 + N + 4 * I + 1];
    Tbl[I, 4] := C[3 + N + 4 * I + 2];
    Tbl[I, 5] := C[3 + N + 4 * I + 3];
    Inc(I);
  End;
End;


(*************************************************************************
Линейная замена аргумента сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна S(x).
    A, B-   коэффициенты преобразования x = A*t + B

Выходные параметры:
    C   -   преобразованный сплайн

  -- ALGLIB PROJECT --
     Copyright 30.06.2007 by Bochkanov Sergey
*************************************************************************)

Procedure SplineLinTransX(Var C : TReal1DArray; A : Double; B : Double);
Var
  I                 : Integer;
  N                 : Integer;
  V                 : Double;
  DV                : Double;
  D2V               : Double;
  X                 : TReal1DArray;
  Y                 : TReal1DArray;
  D                 : TReal1DArray;
Begin
  Assert(Round(C[1]) = 3, 'SplineLinTransX: incorrect C!');
  N := Round(C[2]);

    //
    // Special case: A=0
    //
  If A = 0 Then Begin
    V := SplineInterpolation(C, B);
    I := 0;
    While I <= N - 2 Do Begin
      C[3 + N + 4 * I] := V;
      C[3 + N + 4 * I + 1] := 0;
      C[3 + N + 4 * I + 2] := 0;
      C[3 + N + 4 * I + 3] := 0;
      Inc(I);
    End;
    Exit;
  End;

    //
    // General case: A<>0.
    // Unpack, X, Y, dY/dX.
    // Scale and pack again.
    //
  SetLength(X, N - 1 + 1);
  SetLength(Y, N - 1 + 1);
  SetLength(D, N - 1 + 1);
  I := 0;
  While I <= N - 1 Do Begin
    X[I] := C[3 + I];
    SplineDifferentiation(C, X[I], V, DV, D2V);
    X[I] := (X[I] - B) / A;
    Y[I] := V;
    D[I] := A * DV;
    Inc(I);
  End;
  BuildHermiteSpline(X, Y, D, N, C);
End;


(*************************************************************************
Линейное преобразование сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна S(x).
    A, B-   коэффициенты преобразования S2(x) = A*S(x) + B

Выходные параметры:
    C   -   преобразованный сплайн

  -- ALGLIB PROJECT --
     Copyright 30.06.2007 by Bochkanov Sergey
*************************************************************************)

Procedure SplineLinTransY(Var C : TReal1DArray; A : Double; B : Double);
Var
  I                 : Integer;
  N                 : Integer;
  V                 : Double;
  DV                : Double;
  D2V               : Double;
  X                 : TReal1DArray;
  Y                 : TReal1DArray;
  D                 : TReal1DArray;
Begin
  Assert(Round(C[1]) = 3, 'SplineLinTransX: incorrect C!');
  N := Round(C[2]);

    //
    // Special case: A=0
    //
  I := 0;
  While I <= N - 2 Do Begin
    C[3 + N + 4 * I] := A * C[3 + N + 4 * I] + B;
    C[3 + N + 4 * I + 1] := A * C[3 + N + 4 * I + 1];
    C[3 + N + 4 * I + 2] := A * C[3 + N + 4 * I + 2];
    C[3 + N + 4 * I + 3] := A * C[3 + N + 4 * I + 3];
    Inc(I);
  End;
End;


(*************************************************************************
Вычисление определенного интеграла от сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна.
    X   -   точка, в которой вычисляется интеграл

Результат:
    значение интеграла на отрезке [A, X], где A - левая граница интервала,
    на котором построен сплайн.

  -- ALGLIB PROJECT --
     Copyright 23.06.2007 by Bochkanov Sergey
*************************************************************************)

Function SplineIntegration(Const C : TReal1DArray; X : Double) : Double;
Var
  N                 : Integer;
  I                 : Integer;
  L                 : Integer;
  R                 : Integer;
  M                 : Integer;
  W                 : Double;
Begin
  Assert(Round(C[1]) = 3, 'SplineIntegration: incorrect C!');
  N := Round(C[2]);

    //
    // Binary search in the [ x[0], ..., x[n-2] ] (x[n-1] is not included)
    //
  L := 3;
  R := 3 + N - 2 + 1;
  While L <> R - 1 Do Begin
    M := (L + R) Div 2;
    If C[M] >= X Then Begin
      R := M;
    End
    Else Begin
      L := M;
    End;
  End;

    //
    // Integration
    //
  Result := 0;
  I := 3;
  While I <= L - 1 Do Begin
    W := C[I + 1] - C[I];
    M := 3 + N + 4 * (I - 3);
    Result := Result + C[M] * W;
    Result := Result + C[M + 1] * Sqr(W) / 2;
    Result := Result + C[M + 2] * Sqr(W) * W / 3;
    Result := Result + C[M + 3] * Sqr(Sqr(W)) / 4;
    Inc(I);
  End;
  W := X - C[L];
  M := 3 + N + 4 * (L - 3);
  Result := Result + C[M] * W;
  Result := Result + C[M + 1] * Sqr(W) / 2;
  Result := Result + C[M + 2] * Sqr(W) * W / 3;
  Result := Result + C[M + 3] * Sqr(Sqr(W)) / 4;
End;


(*************************************************************************
Obsolete subroutine, left for backward compatibility.
*************************************************************************)

Procedure Spline3BuildTable(N : Integer;
  Const DiffN : Integer;
  x : TReal1DArray;
  y : TReal1DArray;
  Const BoundL : Double;
  Const BoundR : Double;
  Var ctbl : TReal2DArray);
Var
  C                 : Boolean;
  E                 : Integer;
  G                 : Integer;
  Tmp               : Double;
  nxm1              : Integer;
  I                 : Integer;
  J                 : Integer;
  DX                : Double;
  DXJ               : Double;
  DYJ               : Double;
  DXJP1             : Double;
  DYJP1             : Double;
  DXP               : Double;
  DYP               : Double;
  YPPA              : Double;
  YPPB              : Double;
  PJ                : Double;
  b1                : Double;
  b2                : Double;
  b3                : Double;
  b4                : Double;
Begin
  x := DynamicArrayCopy(x);
  y := DynamicArrayCopy(y);
  N := N - 1;
  g := (n + 1) Div 2;
  Repeat
    i := g;
    Repeat
      j := i - g;
      c := True;
      Repeat
        If x[j] <= x[j + g] Then Begin
          c := False;
        End
        Else Begin
          Tmp := x[j];
          x[j] := x[j + g];
          x[j + g] := Tmp;
          Tmp := y[j];
          y[j] := y[j + g];
          y[j + g] := Tmp;
        End;
        j := j - 1;
      Until Not ((j >= 0) And C);
      i := i + 1;
    Until Not (i <= n);
    g := g Div 2;
  Until Not (g > 0);
  SetLength(ctbl, 4 + 1, N + 1);
  N := N + 1;
  If DiffN = 1 Then Begin
    b1 := 1;
    b2 := 6 / (x[1] - x[0]) * ((y[1] - y[0]) / (x[1] - x[0]) - BoundL);
    b3 := 1;
    b4 := 6 / (x[n - 1] - x[n - 2]) * (BoundR - (y[n - 1] - y[n - 2]) / (x[n - 1] - x[n - 2]));
  End
  Else Begin
    b1 := 0;
    b2 := 2 * BoundL;
    b3 := 0;
    b4 := 2 * BoundR;
  End;
  nxm1 := n - 1;
  If n >= 2 Then Begin
    If n > 2 Then Begin
      dxj := x[1] - x[0];
      dyj := y[1] - y[0];
      j := 2;
      While j <= nxm1 Do Begin
        dxjp1 := x[j] - x[j - 1];
        dyjp1 := y[j] - y[j - 1];
        dxp := dxj + dxjp1;
        ctbl[1, j - 1] := dxjp1 / dxp;
        ctbl[2, j - 1] := 1 - ctbl[1, j - 1];
        ctbl[3, j - 1] := 6 * (dyjp1 / dxjp1 - dyj / dxj) / dxp;
        dxj := dxjp1;
        dyj := dyjp1;
        j := j + 1;
      End;
    End;
    ctbl[1, 0] := -b1 / 2;
    ctbl[2, 0] := b2 / 2;
    If n <> 2 Then Begin
      j := 2;
      While j <= nxm1 Do Begin
        pj := ctbl[2, j - 1] * ctbl[1, j - 2] + 2;
        ctbl[1, j - 1] := -ctbl[1, j - 1] / pj;
        ctbl[2, j - 1] := (ctbl[3, j - 1] - ctbl[2, j - 1] * ctbl[2, J - 2]) / pj;
        j := j + 1;
      End;
    End;
    yppb := (b4 - b3 * ctbl[2, nxm1 - 1]) / (b3 * ctbl[1, nxm1 - 1] + 2);
    i := 1;
    While i <= nxm1 Do Begin
      j := n - i;
      yppa := ctbl[1, j - 1] * yppb + ctbl[2, j - 1];
      dx := x[j] - x[j - 1];
      ctbl[3, j - 1] := (yppb - yppa) / dx / 6;
      ctbl[2, j - 1] := yppa / 2;
      ctbl[1, j - 1] := (y[j] - y[j - 1]) / dx - (ctbl[2, j - 1] + ctbl[3, j - 1] * dx) * dx;
      yppb := yppa;
      i := i + 1;
    End;
    i := 1;
    While i <= n Do Begin
      ctbl[0, i - 1] := y[i - 1];
      ctbl[4, i - 1] := x[i - 1];
      Inc(i);
    End;
  End;
End;


(*************************************************************************
Obsolete subroutine, left for backward compatibility.
*************************************************************************)

Function Spline3Interpolate(N : Integer;
  Const c : TReal2DArray;
  Const X : Double) : Double;
Var
  I                 : Integer;
  L                 : Integer;
  Half              : Integer;
  First             : Integer;
  Middle            : Integer;
Begin
  N := N - 1;
  L := N;
  First := 0;
  While L > 0 Do Begin
    Half := L Div 2;
    Middle := First + Half;
    If C[4, Middle] < X Then Begin
      First := Middle + 1;
      L := L - Half - 1;
    End
    Else Begin
      L := Half;
    End;
  End;
  I := First - 1;
  If I < 0 Then Begin
    I := 0;
  End;
  Result := c[0, I] + (X - c[4, i]) * (C[1, I] + (X - c[4, i]) * (C[2, I] + C[3, i] * (X - c[4, i])));
End;


(*************************************************************************
Internal subroutine. Heap sort.
*************************************************************************)

Procedure HeapSortPoints(Var X : TReal1DArray;
  Var Y : TReal1DArray;
  N : Integer);
Var
  I                 : Integer;
  J                 : Integer;
  K                 : Integer;
  T                 : Integer;
  Tmp               : Double;
  IsAscending       : Boolean;
  IsDescending      : Boolean;
Begin

    //
    // Test for already sorted set
    //
  IsAscending := True;
  IsDescending := True;
  I := 1;
  While I <= N - 1 Do Begin
    IsAscending := IsAscending And (X[I] > X[I - 1]);
    IsDescending := IsDescending And (X[I] < X[I - 1]);
    Inc(I);
  End;
  If IsAscending Then Begin
    Exit;
  End;
  If IsDescending Then Begin
    I := 0;
    While I <= N - 1 Do Begin
      J := N - 1 - I;
      If J <= I Then Begin
        Break;
      End;
      Tmp := X[I];
      X[I] := X[J];
      X[J] := Tmp;
      Tmp := Y[I];
      Y[I] := Y[J];
      Y[J] := Tmp;
      Inc(I);
    End;
    Exit;
  End;

    //
    // Special case: N=1
    //
  If N = 1 Then Begin
    Exit;
  End;

    //
    // General case
    //
  i := 2;
  Repeat
    t := i;
    While t <> 1 Do Begin
      k := t Div 2;
      If X[k - 1] >= X[t - 1] Then Begin
        t := 1;
      End
      Else Begin
        Tmp := X[k - 1];
        X[k - 1] := X[t - 1];
        X[t - 1] := Tmp;
        Tmp := Y[k - 1];
        Y[k - 1] := Y[t - 1];
        Y[t - 1] := Tmp;
        t := k;
      End;
    End;
    i := i + 1;
  Until Not (i <= n);
  i := n - 1;
  Repeat
    Tmp := X[i];
    X[i] := X[0];
    X[0] := Tmp;
    Tmp := Y[i];
    Y[i] := Y[0];
    Y[0] := Tmp;
    t := 1;
    While t <> 0 Do Begin
      k := 2 * t;
      If k > i Then Begin
        t := 0;
      End
      Else Begin
        If k < i Then Begin
          If X[k] > X[k - 1] Then Begin
            k := k + 1;
          End;
        End;
        If X[t - 1] >= X[k - 1] Then Begin
          t := 0;
        End
        Else Begin
          Tmp := X[k - 1];
          X[k - 1] := X[t - 1];
          X[t - 1] := Tmp;
          Tmp := Y[k - 1];
          Y[k - 1] := Y[t - 1];
          Y[t - 1] := Tmp;
          t := k;
        End;
      End;
    End;
    i := i - 1;
  Until Not (i >= 1);
End;


(*************************************************************************
Internal subroutine. Heap sort.
*************************************************************************)

Procedure HeapSortDPoints(Var X : TReal1DArray;
  Var Y : TReal1DArray;
  Var D : TReal1DArray;
  N : Integer);
Var
  I                 : Integer;
  J                 : Integer;
  K                 : Integer;
  T                 : Integer;
  Tmp               : Double;
  IsAscending       : Boolean;
  IsDescending      : Boolean;
Begin

    //
    // Test for already sorted set
    //
  IsAscending := True;
  IsDescending := True;
  I := 1;
  While I <= N - 1 Do Begin
    IsAscending := IsAscending And (X[I] > X[I - 1]);
    IsDescending := IsDescending And (X[I] < X[I - 1]);
    Inc(I);
  End;
  If IsAscending Then Begin
    Exit;
  End;
  If IsDescending Then Begin
    I := 0;
    While I <= N - 1 Do Begin
      J := N - 1 - I;
      If J <= I Then Begin
        Break;
      End;
      Tmp := X[I];
      X[I] := X[J];
      X[J] := Tmp;
      Tmp := Y[I];
      Y[I] := Y[J];
      Y[J] := Tmp;
      Tmp := D[I];
      D[I] := D[J];
      D[J] := Tmp;
      Inc(I);
    End;
    Exit;
  End;

    //
    // Special case: N=1
    //
  If N = 1 Then Begin
    Exit;
  End;

    //
    // General case
    //
  i := 2;
  Repeat
    t := i;
    While t <> 1 Do Begin
      k := t Div 2;
      If X[k - 1] >= X[t - 1] Then Begin
        t := 1;
      End
      Else Begin
        Tmp := X[k - 1];
        X[k - 1] := X[t - 1];
        X[t - 1] := Tmp;
        Tmp := Y[k - 1];
        Y[k - 1] := Y[t - 1];
        Y[t - 1] := Tmp;
        Tmp := D[k - 1];
        D[k - 1] := D[t - 1];
        D[t - 1] := Tmp;
        t := k;
      End;
    End;
    i := i + 1;
  Until Not (i <= n);
  i := n - 1;
  Repeat
    Tmp := X[i];
    X[i] := X[0];
    X[0] := Tmp;
    Tmp := Y[i];
    Y[i] := Y[0];
    Y[0] := Tmp;
    Tmp := D[i];
    D[i] := D[0];
    D[0] := Tmp;
    t := 1;
    While t <> 0 Do Begin
      k := 2 * t;
      If k > i Then Begin
        t := 0;
      End
      Else Begin
        If k < i Then Begin
          If X[k] > X[k - 1] Then Begin
            k := k + 1;
          End;
        End;
        If X[t - 1] >= X[k - 1] Then Begin
          t := 0;
        End
        Else Begin
          Tmp := X[k - 1];
          X[k - 1] := X[t - 1];
          X[t - 1] := Tmp;
          Tmp := Y[k - 1];
          Y[k - 1] := Y[t - 1];
          Y[t - 1] := Tmp;
          Tmp := D[k - 1];
          D[k - 1] := D[t - 1];
          D[t - 1] := Tmp;
          t := k;
        End;
      End;
    End;
    i := i - 1;
  Until Not (i >= 1);
End;


(*************************************************************************
Internal subroutine. Tridiagonal solver.
*************************************************************************)

Procedure SolveTridiagonal(A : TReal1DArray;
  B : TReal1DArray;
  C : TReal1DArray;
  D : TReal1DArray;
  N : Integer;
  Var X : TReal1DArray);
Var
  K                 : Integer;
  T                 : Double;
Begin
  A := DynamicArrayCopy(A);
  B := DynamicArrayCopy(B);
  C := DynamicArrayCopy(C);
  D := DynamicArrayCopy(D);
  SetLength(X, N - 1 + 1);
  A[0] := 0;
  C[N - 1] := 0;
  K := 1;
  While K <= N - 1 Do Begin
    T := A[K] / B[K - 1];
    B[K] := B[K] - T * C[K - 1];
    D[K] := D[K] - T * D[K - 1];
    Inc(K);
  End;
  X[N - 1] := D[N - 1] / B[N - 1];
  K := N - 2;
  While K >= 0 Do Begin
    X[K] := (D[K] - C[K] * X[K + 1]) / B[K];
    Dec(K);
  End;
End;


(*************************************************************************
Internal subroutine. Three-point differentiation
*************************************************************************)

Function DiffThreePoint(T : Double;
  X0 : Double;
  F0 : Double;
  X1 : Double;
  F1 : Double;
  X2 : Double;
  F2 : Double) : Double;
Var
  A                 : Double;
  B                 : Double;
Begin
  T := T - X0;
  X1 := X1 - X0;
  X2 := X2 - X0;
  A := (F2 - F0 - X2 / X1 * (F1 - F0)) / (Sqr(X2) - X1 * X2);
  B := (F1 - F0 - A * Sqr(X1)) / X1;
  Result := 2 * A * T + B;
End;


End.


