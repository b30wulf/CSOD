(******************************************************************)
function WeibullDensity (x, alpha, beta: double): double;
(******************************************************************
  this function returns the Weibull density for a given x, alpha,
  and beta.
 ******************************************************************)

var
  r1,r2,r3 : double;

begin
if (x > 0) and (beta > 0)
  then begin
       r1 := -exp(alpha*ln(x/beta));
       r2 := alpha*exp((alpha-1)*ln(x));
       r3 := exp(alpha*ln(Beta));
       WeibullDensity := r2/r3*exp(r1);
       end
  else WeibullDensity := 0.0;
end;
