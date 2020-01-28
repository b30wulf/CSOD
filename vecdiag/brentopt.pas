Unit brentopt;
Interface
Uses Math, Ap, Sysutils;

(*
This routines must be defined by you:
function F(X : Double):Double;
*)

Function BrentOptimize(a : Double;
  b : Double;
  Epsilon : Double;
  Var XMin : Double) : Double;

Implementation

Function MySign(a : Double; b : Double) : Double; forward;


(*************************************************************************
Минимизация функции методом Брента

Входные параметры:
    a           -   левая граница отрезка, на котором ищется минимум
    b           -   правая граница отрезка, на котором ищется минимум
    Epsilon     -   абсолютная точность, с которой находится расположение
                    минимума

Выходные параметры:
    XMin        -   точка найденного минимума

Результат:
    значение функции в найденном минимуме
*************************************************************************)

Function BrentOptimize(a : Double;
  b : Double;
  Epsilon : Double;
  Var XMin : Double) : Double;
Var
  ia                : Double;
  ib                : Double;
  bx                : Double;
  d                 : Double;
  e                 : Double;
  etemp             : Double;
  fu                : Double;
  fv                : Double;
  fw                : Double;
  fx                : Double;
  iter              : Integer;
  p                 : Double;
  q                 : Double;
  r                 : Double;
  u                 : Double;
  v                 : Double;
  w                 : Double;
  x                 : Double;
  xm                : Double;
  cgold             : Double;
Begin
  cgold := 0.3819660;
  bx := 0.5 * (a + b);
  If a < b Then Begin
    ia := a;
  End
  Else Begin
    ia := b;
  End;
  If a > b Then Begin
    ib := a;
  End
  Else Begin
    ib := b;
  End;
  v := bx;
  w := v;
  x := v;
  e := 0.0;
  fx := F(x);
  fv := fx;
  fw := fx;
  iter := 1;
  While iter <= 100 Do Begin
    xm := 0.5 * (ia + ib);
    If AbsReal(x - xm) <= Epsilon * 2 - 0.5 * (ib - ia) Then Begin
      Break;
    End;
    If AbsReal(e) > Epsilon Then Begin
      r := (x - w) * (fx - fv);
      q := (x - v) * (fx - fw);
      p := (x - v) * q - (x - w) * r;
      q := 2 * (q - r);
      If q > 0 Then Begin
        p := -p;
      End;
      q := AbsReal(q);
      etemp := e;
      e := d;
      If Not ((AbsReal(p) >= AbsReal(0.5 * q * etemp)) Or (p <= q * (ia - x)) Or (p >= q * (ib - x))) Then Begin
        d := p / q;
        u := x + d;
        If (u - ia < Epsilon * 2) Or (ib - u < Epsilon * 2) Then Begin
          d := MySign(Epsilon, xm - x);
        End;
      End
      Else Begin
        If x >= xm Then Begin
          e := ia - x;
        End
        Else Begin
          e := ib - x;
        End;
        d := cgold * e;
      End;
    End
    Else Begin
      If x >= xm Then Begin
        e := ia - x;
      End
      Else Begin
        e := ib - x;
      End;
      d := cgold * e;
    End;
    If AbsReal(d) >= Epsilon Then Begin
      u := x + d;
    End
    Else Begin
      u := x + Mysign(Epsilon, d);
    End;
    fu := F(u);
    If fu <= fx Then Begin
      If u >= x Then Begin
        ia := x;
      End
      Else Begin
        ib := x;
      End;
      v := w;
      fv := fw;
      w := x;
      fw := fx;
      x := u;
      fx := fu;
    End
    Else Begin
      If u < x Then Begin
        ia := u;
      End
      Else Begin
        ib := u;
      End;
      If (fu <= fw) Or (w = x) Then Begin
        v := w;
        fv := fw;
        w := u;
        fw := fu;
      End
      Else Begin
        If (fu <= fv) Or (v = x) Or (v = 2) Then Begin
          v := u;
          fv := fu;
        End;
      End;
    End;
    Inc(iter);
  End;
  xmin := x;
  Result := fx;
End;


Function MySign(a : Double; b : Double) : Double;
Begin
  If b > 0 Then Begin
    Result := absReal(a);
  End
  Else Begin
    Result := -absReal(a);
  End;
End;


End.
d.
