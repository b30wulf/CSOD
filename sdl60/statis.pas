unit statis;

(******************************************************************)
(*                                                                *)
(*                          S T A T I S                           *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1998..2001 H. Lohninger                    May  1998   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jul-14, 2001                                  *)
(*                                                                *)
(******************************************************************)

{ revision history:

1.0   Aug-08, 1998]
      released to the public (D1..D4, C1, C3]

1.1   [Mar-28, 1998]
      STATIS now available for BCB 4.0

5.0   [Oct-09, 1999]
      STATIS now available for Delphi 5.0

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      new functions implemented:
        FisherTransform, FisherTransformInv, ConfidenceInterval

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

type
  TSignifLevel = (Dot20, Dot15, Dot10, Dot05, Dot01);

function  BinomCoeff
                (n : integer;           { total number of elements }
                 k : integer)           { number of drawn elements }
                   : longint;               { binomial coefficient }
function  CalcFishQ
            (m1,m2,                     { mean values, class 1 & 2 }
             s1,s2 : double)                 { standard deviations }
                   : double;                        { Fisher ratio }
function  Chi2DistriDensity
             (chi2 : double;                 { chi square quantile }
                df : integer)                 { degrees of freedom }
                   : double;  { density of chi square distribution }
function  chi2DistriIntegral
             (chi2 : double;                 { chi square quantile }
                df : integer)                 { degrees of freedom }
                   : double;                         { probability }
function  chi2DistriQuantile
                (p : double;                         { probability }
                df : integer)                 { degrees of freedom }
                   : double;       { quantile of chi2-distribution }
function  ConfidenceInterval
            (alpha : double;               { level of significance }
            StdDev : double;                  { standard deviation }
           NumData : integer)                        { sample size }
                   : double;                 { confidence interval }
function  FDistriDensity
                (F : double;                          { F quantile }
          df1, df2 : integer)                 { degrees of freedom }
                   : double;           { density of F distribution }
function  FDistriIntegral
                (F : double;                          { F quantile }
               df1 : integer;                 { degrees of freedom }
               df2 : integer)                 { degrees of freedom }
                   : double;                         { probability }
function  FDistriQuantile
                (p : double;                         { probability }
               df1 : integer;                 { degrees of freedom }
               df2 : integer)                 { degrees of freedom }
                   : double;                            { quantile }
function FisherTransform
                (x : double)                            { argument }
                   : double;                  { Fisher's transform }
function FisherTransformInv
                (x: double)                             { argument }
                  : double;             { inverse Fisher transform }
function  IncompleteBeta
                (x : double;                            { quantile }
              a, b : double)                          { parameters }
                   : double;                     { function result }
function  KolmogSmir1SampleTestStat
       (SampleSize : integer;        { size of sample to be tested }
             alpha : TSignifLevel)         { level of significance }
                   : double;                   { critical KS value }
function  LnBeta
              (z,w : double)          { arguments of beta function }
                   : double;                           { Beta(z,w) }
function  LnBinomCoeff
                (n : integer;           { total number of elements }
                 k : integer)           { number of drawn elements }
                   : double;   { logarithm of binomial coefficient }
function  LnGamma
                (x : double)          { argument of gamma function }
                   : double;                        { ln(gamma(x)) }
function  nDistriDensity
                (u : double)                      { critical value }
                   : double;      { density of normal distribution }
function  nDistriIntegral
                (u : double)                            { argument }
                   : double;          {integral of norm.dens.funct.}
function  nDistriQuantile
                (p : double)                         { probability }
                   : double;                 { normal distribution }
function  tDistriDensity
                (t : double;                             { t value }
                df : integer)                 { degrees of freedom }
                   : double;           { density of t distribution }
function  tDistriIntegral
                (t : double;                             { t value }
                df : integer)                 { degrees of freedom }
                   : double;                         { probability }
function  tDistriQuantile
                (p : double;                         { probability }
                df : integer)                 { degrees of freedom }
                   : double;          { quantile of t-distribution }
function WeibullDensity
                (x : double;                            { argument }
             alpha : double;  { parameters of Weibull distribution }
              beta : double)
                   : double;                             { density }


{------------------------------------------------------------------------------}
implementation
{------------------------------------------------------------------------------}

{$R-}

uses
  sysutils, wintypes, winprocs {$IFDEF SHAREWARE}, dialogs {$ENDIF};

type
  ESDLStatisError = class(Exception);     { exception type to indicate errors }


{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\statis_ct.inc}
{$ENDIF}

{$I weibull.inc}


(******************************************************************)
function KolmogSmir1SampleTestStat (SampleSize: integer; alpha: TSignifLevel): double;
(******************************************************************
  ENTRY: SampleSize .... size of sample to be processed
         alpha ......... level of significance

  EXIT:  function returns test statistic for Kolmogorov-Smirnov one
         sample test, or -1 if error occured (sample size <= 1)

  REMARKS: Numbers below are from simulations of Pearsons et al. (1972)
 ******************************************************************)

const
  TableLeng = 20;
  KSCrit : array[1..TableLeng, TSignifLevel] of double =
       ((0.900, 0.925, 0.950, 0.975, 0.995),
        (0.684, 0.726, 0.776, 0.842, 0.929),
        (0.565, 0.597, 0.642, 0.708, 0.828),
        (0.494, 0.525, 0.564, 0.624, 0.733),
        (0.446, 0.474, 0.510, 0.565, 0.669),
        (0.410, 0.436, 0.470, 0.521, 0.618),
        (0.381, 0.405, 0.438, 0.486, 0.577),
        (0.358, 0.381, 0.411, 0.457, 0.543),
        (0.339, 0.360, 0.388, 0.432, 0.514),
        (0.322, 0.342, 0.368, 0.410, 0.490),
        (0.307, 0.326, 0.352, 0.391, 0.468),
        (0.295, 0.313, 0.338, 0.375, 0.450),
        (0.284, 0.302, 0.325, 0.361, 0.433),
        (0.274, 0.292, 0.314, 0.349, 0.418),
        (0.266, 0.283, 0.304, 0.338, 0.404),
        (0.258, 0.274, 0.295, 0.328, 0.392),
        (0.250, 0.266, 0.286, 0.318, 0.381),
        (0.244, 0.259, 0.278, 0.309, 0.371),
        (0.237, 0.252, 0.272, 0.301, 0.363),
        (0.231, 0.246, 0.264, 0.294, 0.356));


begin
result := -1;  { error }
if (SampleSize >= 1) and (SampleSize <= TableLeng)
         then result := KSCrit[SampleSize, alpha]
         else begin
              case alpha of
                Dot20 : result := 1.07/sqrt(SampleSize);
                Dot15 : result := 1.14/sqrt(SampleSize);
                Dot10 : result := 1.22/sqrt(SampleSize);
                Dot05 : result := 1.36/sqrt(SampleSize);
                Dot01 : result := 1.63/sqrt(SampleSize);
              end;
              end;
end;

(******************************************************************)
function nDistriQuantileHastings (p: double): double;
(******************************************************************
 ENTRY:   p ........ quantile (0 < p < 1.0)

 EXIT:    function returns the Quantiles of the standard normal
          distribution, approximated by a formula given by Hastings.
          Attention ! for any invalid argument this function returns
          a value of 0.0
 ******************************************************************)

const
  a0 = 2.515517;
  a1 = 0.802853;
  a2 = 0.010328;
  b1 = 1.432788;
  b2 = 0.189269;
  b3 = 0.001308;

var
  Sign    : integer;
  t,tq    : double;

begin
if ((p > 0) and (p < 1.0))
  then begin
       Sign := 1;
       if p < 0.5 then
         begin
         p := 1-p;
         Sign := -1;
         end;
       tq := -2*ln(1-p);
       t := sqrt(tq);
       nDistriQuantileHastings := Sign*(t - (a0+a1*t+a2*tq)/(1+b1*t+tq*(b2+b3*t)));
       end
  else nDistriQuantileHastings := 0.0;
end;



(******************************************************************)
function nDistriQuantile (p: double): double;
(******************************************************************
  ENTRY:  p ......... probability (0..1)

  EXIT:   function returns the quantile of the normal distribution for
          a given probability and a given degree of freedom

  REMARK: the calculation of the quantile is performed via an
          iterative approximation using the formula given by Hastings
          as a starting point. The approximation is carried out by
          the bisection method. The accuracy of the result is defined
          by the constant eps.
 ******************************************************************)

const
  eps = 1e-8;

var
  np          : double;
  lowbracket  : double;
  highbracket : double;
  gammaest    : double;
  diff        : double;

begin
if ((p > 0) and (p < 1.0))
  then begin
       np := ndistriQuantileHastings (p);  { first, calculate the starting point }
       diff := abs(np);
       if diff < 0.1 then
         diff := 0.1;
       lowbracket := np-0.1*diff;                { now, find the brackets }
       highbracket := np+0.1*diff;
       repeat   { now find the exact quantile by successive approximation }
         np := (HighBracket+LowBracket)/2;
         gammaest := ndistriIntegral (np);
         if gammaest > p
           then HighBracket := np
           else LowBracket := np;
       until abs(gammaest-p)/p < eps;
       ndistriQuantile := np;
       end
  else ndistriQuantile := 0;
end;




(******************************************************************)
function IncompleteGamma (x, a: double): double;
(******************************************************************
  ENTRY:   x, a ..... parameters of incomplete gamma function

  EXIT:    function returns the incomplete gamma function for x > 0

  REMARK:  This function is calculated by a series expansion, or
           a continued fraction (depending on a). This double approach
           is done because of convergence speed.
 ******************************************************************)


function ContFract (x, a: double): double;
(*-----------------------------------------*)
(* calculate by a continued fraction
   [1/x+((1-a)/(1+/((2-a)/(x+....))] *)

const
  eps = 1e-8;      { accuracy }
  MaxIter = 100;   { max. number of iterations }

var
  olda    : double;
  auxa    : double;
  a0, a1  : double;
  b0, b1  : double;
  f       : double;
  ready   : boolean;
  n       : integer;

begin
f := 1;
a0 := 1;
b0 := 0;
a1 := x;
b1 := 1;
olda := 0;
auxa := 0;
n := 1;
ready := false;
while (n < MaxIter) and not ready do
  begin
  a0 := (a1+a0*(n-a))*f;
  a1 := x*a0+n*f*a1;
  b0 := (b1+b0*(n-a))*f;
  b1 := x*b0+n*f*b1;
  if (a1 <> 0) then
    begin
    f := 1/a1;
    auxa := b1*f;
    if (abs((auxa-olda)/auxa) < eps) then
      ready := true;
    olda := auxa;
    end;
  inc (n);
  end;
ContFract := auxa;
end;


function SerExpans (x, a: double): double;
(*-----------------------------------------*)
(* calculate part of incomplete gamma by a series expansion:
   sum(1/Gamma(1+n)*x^n) *)

const
  eps = 1e-8;      { accuracy }
  MaxIter = 100;   { max. number of iterations }

var
  delta   : double;
  sum     : double;
  ready   : boolean;
  n       : integer;

begin
delta := 1/a;
sum := delta;
n := 1;
ready := false;
while (n < MaxIter) and not ready do
  begin
  a := a+1;
  delta := x*delta/a;
  sum := sum + delta;
  if (abs(delta) < abs(sum)*eps) then
    ready := true;
  end;
SerExpans := sum;
end;



begin
if (x <= 0) or (a <= 0)
  then IncompleteGamma := 0   { in fact, incompleteGamma is not defined below x=0 and a=0 }
  else if x < a+1
         then IncompleteGamma := exp(-x+a*ln(x)-LnGamma(a)) * Serexpans(x,a)
         else IncompleteGamma := 1-exp(-x+a*ln(x)-LnGamma(a)) * ContFract(x,a);
end;


(******************************************************************)
function  nDistriDensity (u: double): double;
(******************************************************************
  ENTRY:  u ... argument

  EXIT:   function returns density of normal distribution at x
 ******************************************************************)

const
  sqrt2pitom1 : extended = 0.3989422804014326779399;

begin
nDistriDensity := sqrt2pitom1 * exp (-0.5*sqr(u));
end;


(******************************************************************)
function  nDistriIntegral (u: double): double;
(******************************************************************
  ENTRY:  u .... argument

  EXIT:   function returns integral of normal density function from
          minus infinity to x.
 ******************************************************************)

begin
if u > 0
  then nDistriIntegral := 0.5*(1+IncompleteGamma (0.5*sqr(u),0.5))
  else nDistriIntegral := 0.5*(1-IncompleteGamma (0.5*sqr(u),0.5));
end;


(******************************************************************)
function chi2DistriIntegral (chi2: double; df: integer): double;
(******************************************************************
  ENTRY:  chi2 .... argument
          df ..... degrees of freedom

  EXIT:   function returns integral of chi-square-distribution
          density function of a predefined number of degrees of freedom
 ******************************************************************)


begin
Chi2DistriIntegral := IncompleteGamma (chi2/2,df/2);
end;




(******************************************************************)
function chi2DistriQuantileWilson (p: double; ndata: integer): double;
(******************************************************************
 ENTRY:   p ........ probability (0 < p < 1.0)

 EXIT:    function returns quantile of chi-square distribution, approximated
          by a formula given by Wilson and Hilferty. Attention ! for any invalid
          argument this function returns a value of 0.0
 ******************************************************************)

var
  u   : double;
  aux : double;

begin
if ((p > 0) and (p < 1.0) and (ndata > 0))
  then begin
       u := nDistriQuantile(p);
       aux := 1 - 2.0/9/ndata + u*sqrt(2.0/9/ndata);
       u := ndata*aux*aux*aux;
       if u < 0 then
         u := 0;
       chi2DistriQuantileWilson := u;
       end
  else chi2DistriQuantileWilson := 0.0;
end;


(******************************************************************)
function chi2DistriDensity (chi2: double; df: integer): double;
(******************************************************************
 ENTRY:   chi2 ........ argument (chi2 > 0)

 EXIT:    function returns the density of the chi-square distribution
 ******************************************************************)

begin
Chi2DistriDensity := exp((df/2-1)*ln(chi2)-chi2/2-df/2*ln(2)-lnGamma(df/2));
end;


(******************************************************************)
function LnGamma (x: double): double;
(******************************************************************
  ENTRY:   x ...... argument of gamma function, x > 0
  EXIT:    function returns ln(gamma(x))
  REMARK:  approximation according to formula of Lanczos
 ******************************************************************)

const
  sqrt2Pi = 2.5066282746310005;
  coeff : array[1..6] of double =
              (76.18009173, -86.50532033,    24.01409822,
               -1.231739516,  0.00120858003, -5.36382e-6);

var
  sum : double;
  j   : integer;

begin
if x <= 0
  then LnGamma := 0
  else begin
       sum := 1;
       for j:=1 to 6 do
         sum := sum + coeff[j]/(j+x-1);
       LnGamma := (x-0.5)*ln(x+4.5)-x-4.5+ln(sum*sqrt2Pi);
       end;
end;


(******************************************************************)
function CalcFishQ (m1,m2,s1,s2: double): double;
(******************************************************************
  ENTRY:  m1, m2 ..... mean values of class 1 and class 2
          s1, s2 ..... standard deviations of class 1 & 2

  EXIT:   function returns Fisher ratio
 ******************************************************************)

var
  sum : double;

begin
sum := sqr(s1) + sqr(s2);
if sum < 1e-6 then
  sum := 1e-6;
CalcFishQ := sqr(m1-m2)/sum;
end;


(******************************************************************)
function BinomCoeff (n,k: integer): longint;
(******************************************************************
  ENTRY:   n ...... total number of elements
           k ...... number of drawn elements
  EXIT:    function returns the binomial coefficient
 ******************************************************************)

begin
if (n >= 0) and (k >= 0) and (n >= k)
  then BinomCoeff := round(exp(LnGamma(n+1)-LnGamma(k+1)-LnGamma(n-k+1)))
  else BinomCoeff := 0;
end;


(******************************************************************)
function LnBinomCoeff (n,k: integer): double;
(******************************************************************
  ENTRY:   n ...... total number of elements
           k ...... number of drawn elements
  EXIT:    function returns the binomial coefficient
 ******************************************************************)

begin
if (n >= 0) and (k >= 0) and (n >= k)
  then LnBinomCoeff := LnGamma(n+1)-LnGamma(k+1)-LnGamma(n-k+1)
  else LnBinomCoeff := 0;
end;


(******************************************************************)
function LnBeta (z,w: double): double;
(******************************************************************
  ENTRY:   z, w ..... parameters of beta function
  EXIT:    function returns the common logarithm of beta(z,w)
 ******************************************************************)

begin
if (z >= 0) and (w >= 0)
  then LnBeta := LnGamma(z)+LnGamma(w)-LnGamma(z+w)
  else LnBeta := 0;
end;


(******************************************************************)
function IncompleteBeta (x, a, b: double): double;
(******************************************************************
  ENTRY:   a, b ..... parameters of beta function
           x ........ argument
  EXIT:    function returns the incomplete beta function for 0 <= x <= 1.0
  REMARK:  this function is calculated by a series expansion via
           a continued fraction
 ******************************************************************)


function ContFract (x, a, b: double): double;
(*-----------------------------------------*)
(* calculate the series expansion by a continued fraction
   1/1+(d1/(1+d2/(1+d3/(1+....)) *)

const
  eps = 1e-8;    { accuracy }
  MaxIter = 100;   { max. number of iterations }

var
  aodd   : double;
  bodd   : double;
  aeven  : double;
  beven  : double;
  auxa   : double;
  auxb   : double;
  ready  : boolean;
  j      : integer;
  d      : double;
  aold   : double;

begin
aodd := 1;
bodd := 1;
auxa := 1;
auxb := 1-(a+b)*x/(a+1);
ready := false;
j:=0;
while not ready and (j < MaxIter) do
  begin
  inc (j);
  d := j*(b-j)*x/(a+2*j-1)/(a+2*j);        { d is different for odd and even j }
  aeven := auxa+d*aodd;
  beven := auxb+d*bodd;
  d := -(a+j)*(a+b+j)*x/(a+2*j)/(a+2*j+1); { d is different for odd and even j }
  aodd := aeven/(beven+d*auxb);
  bodd := beven/(beven+d*auxb);
  aold := auxa;
  auxa := (aeven+d*auxa)/(beven+d*auxb);
  auxb := 1;
  if abs(auxa-aold) < eps*abs(auxa) then
    ready := true;
  end;
contFract := auxa;
end;


var
  coeff : double;

begin
if x < 0
  then IncompleteBeta := 0   { in fact, incompleteBeta is not defined outside [0,1] }
  else if x > 1
         then IncompleteBeta := 1
         else begin
              if (x=0.0) or (x=1.0)   { coeff = (x^a(1-x)^b)/(a*Beta(a,b)) }
                then coeff := 0
                else coeff := exp(lngamma(a+b)-lngamma(a)-lngamma(b)+
                               a*ln(x)+b*ln(1-x));
              if (x < (a+1)/(a+b+2))  { use symmetry relation for better results at the limiting values }
                then IncompleteBeta := coeff*ContFract(x,a,b)/a
                else IncompleteBeta := 1-coeff*ContFract(1-x,b,a)/b;
              end;
end;



(******************************************************************)
function FDistriDensity (F: double; df1, df2: integer): double;
(******************************************************************
  ENTRY:  F ......... argument
          df1, df2 .... degrees of freedom

  EXIT:   function returns density F-distribution at a predefined
          number of degrees of freedom
 ******************************************************************)


begin
FDistriDensity := exp(lnGamma((df1+df2)/2)-lnGamma(df1/2)-lnGamma(df2/2)+
                      df1/2*ln(df1/df2)+(df1/2-1)*ln(F)-(df1+df2)/2*ln(1+df1*f/df2));
end;


(******************************************************************)
function tDistriIntegral (t: double; df: integer): double;
(******************************************************************
  ENTRY:  t ........ argument
          df ...... degree of freedom

  EXIT:   function returns integral of t-distribution density function of
          a predefined degree of freedom
 ******************************************************************)


begin
if t > 0
  then tDistriIntegral := 1-0.5*IncompleteBeta (df/(df+sqr(t)), df/2, 0.5)
  else tDistriIntegral := 0.5*IncompleteBeta (df/(df+sqr(t)), df/2, 0.5);
end;


(******************************************************************)
function tDistriDensity (t: double; df: integer): double;
(******************************************************************
  ENTRY:  t ........ argument
          df ....... degree of freedom

  EXIT:   function returns density function of t-distribution of
          a predefined degree of freedom
 ******************************************************************)


var
  f1 : double;

begin
f1 := -(df+1)/2*ln(sqr(t)/df + 1);
tDistriDensity := exp(lnGamma((df+1)/2)-ln(sqrt(df*pi))-lnGamma(df/2)+f1);
end;


(******************************************************************)
function FDistriIntegral (F: double; df1, df2: integer): double;
(******************************************************************
  ENTRY:  F ........... argument
          df1, df2 .... degrees of freedom

  EXIT:   function returns integral of F-distribution density function of
          predefined degrees of freedom
 ******************************************************************)


begin
FDistriIntegral := 1 - IncompleteBeta (df2/(df2+df1*F),df2/2,df1/2);
end;



(******************************************************************)
function FDistriQuantile (p: double; df1, df2: integer): double;
(******************************************************************
  ENTRY:  p ........... probability (0..1)
          df1, df2 .... degrees of freedom

  EXIT:   function returns quantile of F-distribution for a given
          pobability and predefined degrees of freedom;

  REMARK: the calculation of the quantile is performed via an
          iterative approximation using the (poor) formula given
          in Abramowitz, p.945, as a starting point. The approximation
          is carried out by the bisection method. The accuracy of the
          result is defined by the constant eps.
 ******************************************************************)

const
  eps = 1e-8;

var
  usesymm     : boolean;
  up, h,
  lambda, w   : double;
  Fp          : double;
  FestLow     : double;
  FestHigh    : double;
  lowbracket  : double;
  highbracket : double;
  gammaest    : double;
  lastLowB    : double;
  LastHighB   : double;

begin
usesymm := false;    { first, calculate the starting point }
if p < 0.5 then
  begin
  p := 1-p;
  usesymm := true;
  end;
up := nDistriQuantile(p);
h := 2/(1/(df2{-1})+1/(df1{-1}));
lambda := (sqr(up)-3)/6;
w := up*sqrt(h+lambda)/h-(1/(df1{-1})-1/(df2{-1}))*(lambda+5/6-2/3/h);
Fp := exp(2*w);
if usesymm then
  Fp := 1/Fp;

lowbracket := Fp-0.1*Fp;    { now, find the brackets }
highbracket := Fp+0.1*Fp;
LastLowB := 0;
LastHighB := 0;
if lowbracket < 0 then
  lowbracket := 0;
repeat
  FestLow := FdistriIntegral (LowBracket, df1, df2);
  FestHigh := FdistriIntegral (HighBracket, df1, df2);
  if Festlow >= p then
    begin
    lastLowB := LowBracket;
    LowBracket := LowBracket - 0.5*abs(highbracket-lowbracket);
    end;
  if FestHigh <= p then
    begin
    lastHighB := HighBracket;
    HighBracket := HighBracket + 0.5*abs(highbracket-lowbracket);
    end;
until ((FestLow < p) and (FestHigh > p));
if LastLowB <> 0 then
  HighBracket := LastLowB;
if LastHighB <> 0 then
  LowBracket := LastHighB;

repeat   { now find the exact quantile by successive approximation }
  fp := (HighBracket+LowBracket)/2;
  gammaest := FDistriIntegral (fp, df1, df2);
  if gammaest > p
    then HighBracket := fp
    else LowBracket := fp;
until abs(gammaest-p) < eps;
if usesymm then
  Fp := 1/Fp;
FDistriQuantile := fp;
end;



(******************************************************************)
function tDistriQuantileHastings (p: double; ndata: integer): double;
(******************************************************************
 ENTRY:   p ............ quantile (0 < p < 1.0)

 EXIT:    function returns t distribution, approximated
          by a formula given by Hastings. Attention ! for any invalid
          argument this function returns a value of 0.0
 ******************************************************************)

var
  u, uq    : double;
  c1,c3,c5 : double;
  usesymm  : boolean;

begin
if ((p > 0) and (p < 1.0) and (ndata > 0))
  then begin
       usesymm := false;
       if p < 0.5 then
         begin
         p := 1-p;
         usesymm := true;
         end;
       u := nDistriQuantile(p);
       uq := sqr(u);
       c5 := 4800.0*sqr(ndata) + 4560.0*ndata + 1482.0;
       c3 := (23040.0*ndata + 15360.0)*sqr(ndata) + 4080.0*ndata - 1920;
       c1 := (92160.0*sqr(ndata)+23040.0*ndata+2880.0)*sqr(ndata) - 3600*ndata - 945;
       u := (((((79.0*uq+(720.0*ndata+776))*uq+c5)*uq+c3)*uq+c1)*u)/92160.0/sqr(ndata)/sqr(ndata);
       if usesymm then
         u := -u;
       tDistriQuantileHastings := u;
       end
  else tDistriQuantileHastings := 0.0;
end;



(******************************************************************)
function tDistriQuantile (p: double; df: integer): double;
(******************************************************************
  ENTRY:  p ......... probability (0..1)
          df ........ degrees of freedom

  EXIT:   function returns the quantile of the t-distribution for a given
          probability and a given degree of freedom

  REMARK: the calculation of the quantile is performed via an
          iterative approximation using the formula given by Hastings
          as a starting point. The approximation is carried out by
          the bisection method. The accuracy of the result is defined
          by the constant eps.
 ******************************************************************)

const
  eps = 1e-8;

var
  tp          : double;
  lowbracket  : double;
  highbracket : double;
  gammaest    : double;
  diff        : double;
  lastLowB    : double;
  LastHighB   : double;
  FestLow     : double;
  FestHigh    : double;



begin
if ((p > 0) and (p < 1.0) and (df > 0))
  then begin
       tp := tDistriQuantileHastings (p, df);  { calculate the starting point }
       diff := abs(tp);
       if diff < 0.1 then
         diff := 0.1;
       lowbracket := tp-0.1*diff;                { find the brackets }
       highbracket := tp+0.1*diff;
       LastLowB := 0;
       LastHighB := 0;
       repeat
         FestLow := tdistriIntegral (LowBracket, df);
         FestHigh := tdistriIntegral (HighBracket, df);
         if Festlow > p then
           begin
           lastLowB := LowBracket;
           LowBracket := LowBracket - 0.5*abs(highbracket-lowbracket);
           end;
         if FestHigh < p then
           begin
           lastHighB := HighBracket;
           HighBracket := HighBracket + 0.5*abs(highbracket-lowbracket);
           end;
       until ((FestLow < p) and (FestHigh > p));
       if LastLowB <> 0 then
         HighBracket := LastLowB;
       if LastHighB <> 0 then
         LowBracket := LastHighB;
       repeat   { now find the exact quantile by successive approximation }
         tp := (HighBracket+LowBracket)/2;
         gammaest := tDistriIntegral (tp, df);
         if gammaest > p
           then HighBracket := tp
           else LowBracket := tp;
       until abs(gammaest-p) < eps;
       tDistriQuantile := tp;
       end
  else tDistriQuantile := 0;
end;



(******************************************************************)
function Chi2DistriQuantile (p: double; df: integer): double;
(******************************************************************
  ENTRY:  p ......... probability (0..1)
          df ........ degrees of freedom

  EXIT:   function returns the quantile of the chi-sqare-distribution
          for a given probability and a given degree of freedom

  REMARK: the calculation of the quantile is performed via an
          iterative approximation using the formula given by Hastings
          as a starting point. The approximation is carried out by
          the bisection method. The accuracy of the result is defined
          by the constant eps.
 ******************************************************************)

const
  eps = 1e-8;

var
  chi2p       : double;
  lowbracket  : double;
  highbracket : double;
  gammaest    : double;
  diff        : double;
  lastLowB    : double;
  LastHighB   : double;
  FestLow     : double;
  FestHigh    : double;


begin
if ((p > 0) and (p < 1.0) and (df > 0))
  then begin
       chi2p := Chi2DistriQuantileWilson (p, df);  { first, calculate the starting point }
       diff := abs(chi2p);
       if diff < 0.1 then
         diff := 0.1;
       lowbracket := chi2p-0.2*diff;                { now, find the brackets }
       highbracket := chi2p+0.2*diff;

       LastLowB := 0;
       LastHighB := 0;
       repeat
         FestLow := chi2distriIntegral (LowBracket, df);
         FestHigh := Chi2DistriIntegral (HighBracket, df);
         if Festlow > p then
           begin
           lastLowB := LowBracket;
           LowBracket := LowBracket - 0.5*abs(highbracket-lowbracket);
           end;
         if FestHigh < p then
           begin
           lastHighB := HighBracket;
           HighBracket := HighBracket + 0.5*abs(highbracket-lowbracket);
           end;
       until ((FestLow < p) and (FestHigh > p));
       if LastLowB <> 0 then
         HighBracket := LastLowB;
       if LastHighB <> 0 then
         LowBracket := LastHighB;

       repeat   { now find the exact quantile by successive approximation }
         chi2p := (HighBracket+LowBracket)/2;
         gammaest := Chi2DistriIntegral (chi2p, df);
         if gammaest > p
           then HighBracket := chi2p
           else LowBracket := chi2p;
       until abs(gammaest-p) < eps;
       chi2DistriQuantile := chi2p;
       end
  else chi2DistriQuantile := 0;
end;


(******************************************************************)
function FisherTransform (x: double): double;
(******************************************************************)

begin
if (x <= 1.0) or (x >= 1.0)
  then raise ESDLStatisError.Create ('FisherTransform: argument out of range')
  else FisherTransform := 0.5*ln((1+x)/(1-x));
end;

(******************************************************************)
function FisherTransformInv (x: double): double;
(******************************************************************)

begin
FisherTransformInv := (exp(2*x)-1)/(exp(2*x)+1);
end;


(******************************************************************)
function ConfidenceInterval (alpha, StdDev: double; NumData: integer): double;
(******************************************************************
 ENTRY: alpha ........ level of significance
        StdDev ....... standard deviation
        NumData ...... sample size

 EXIT:  function return confidence interval of the population mean
 ******************************************************************)

begin
result := nDistriQUantile(1-0.5*alpha)*StdDev/sqrt(NumData);
end;




(******************************************************************)
(*                              INIT                              *)
(******************************************************************)

begin
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Halt;
  end;
{$ENDIF}
end.



