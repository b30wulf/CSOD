(******************************************************************)
function ClipLine (var x1, y1, x2, y2: longint;
                   bllx, blly, burx, bury: longint): boolean;
(******************************************************************
ENTRY:  x1, y1, x2, y2 ............ coors of line to be clipped
        bllx, blly, burx, bury .... coords of boundary points

EXIT:  The coordinates (x1,y1) and (x2,y2) of the given line are
       checked against the defined boundary and clipped if necessary.
       Function returns true if part of line is inside boundaries.
*******************************************************************)

var
  PCode1, pcode2 : byte;
  LineInWindow   : boolean;
  kx, ky         : real;
  x1bak, y1bak   : longint;
  x2bak, y2bak   : longint;


function CalcPCode (x,y: longint): byte;
(*------------------------------------*)

var
  pc : byte;

begin
if x < bllx
  then pc := $01
  else pc := $00;
if x > burx then
  pc := pc or $02;
if y < blly then
  pc := pc or $04;
if y > bury then
  pc := pc or $08;
CalcPCode := pc;
end;

procedure DoCLip (var x1, y1, x2, y2: longint);
(*-------------------------------------------*)

var
  dummy : real;

begin
if Pcode1 and $01 = $01 then
  begin
  dummy := y1+kx*(bllx-x1);
  if dummy > MaxLongInt then
    dummy := MaxLongInt;
  if dummy < -MaxLongInt then
    dummy := -MaxLongInt;
  y1 := round(dummy);
  x1 := bllx;
  end;
if Pcode1 and $02 = $02 then
  begin
  dummy := y1+kx*(burx-x1);
  if dummy > MaxLongInt then
    dummy := MaxLongInt;
  if dummy < -MaxLongInt then
    dummy := -MaxLongInt;
  y1 := round(dummy);
  x1 := burx;
  end;
if Pcode1 and $04 = $04 then
  begin
  dummy := x1+ky*(blly-y1);
  if dummy > MaxLongInt then
    dummy := MaxLongInt;
  if dummy < -MaxLongInt then
    dummy := -MaxLongInt;
  x1 := round(dummy);
  y1 := blly;
  end;
if Pcode1 and $08 = $08 then
  begin
  dummy := x1+ky*(bury-y1);
  if dummy > MaxLongInt then
    dummy := MaxLongInt;
  if dummy < -MaxLongInt then
    dummy := -MaxLongInt;
  x1 := round(dummy);
  y1 := bury;
  end;
if Pcode2 and $01 = $01 then
  begin
  dummy := y2+kx*(bllx-x2);
  if dummy > MaxLongInt then
    dummy := MaxLongInt;
  if dummy < -MaxLongInt then
    dummy := -MaxLongInt;
  y2 := round(dummy);
  x2 := bllx;
  end;
if Pcode2 and $02 = $02 then
  begin
  dummy := y2+kx*(burx-x2);
  if dummy > MaxLongInt then
    dummy := MaxLongInt;
  if dummy < -MaxLongInt then
    dummy := -MaxLongInt;
  y2 := round(dummy);
  x2 := burx;
  end;
if Pcode2 and $04 = $04 then
  begin
  dummy := x2+ky*(blly-y2);
  if dummy > MaxLongInt then
    dummy := MaxLongInt;
  if dummy < -MaxLongInt then
    dummy := -MaxLongInt;
  x2 := round(dummy);
  y2 := blly;
  end;
if Pcode2 and $08 = $08 then
  begin
  dummy := x2+ky*(bury-y2);
  if dummy > MaxLongInt then
    dummy := MaxLongInt;
  if dummy < -MaxLongInt then
    dummy := -MaxLongInt;
  x2 := round(dummy);
  y2 := bury;
  end;
end;


begin                                  (* clipline *)
x1bak := x1;
y1bak := y1;
x2bak := x2;
y2bak := y2;
if bllx > burx then
  ExChange (bllx, burx, sizeof(bllx));
if blly > bury then
  ExChange (blly, bury, sizeof(blly));
if x2 <> x1
  then kx := (y2-y1)/(x2-x1)
  else kx := 1e20;
if y1 <> y2
  then ky := (x2-x1)/(y2-y1)
  else ky := 1e20;
LineInWindow := False;
PCode1 := CalcPCode (x1,y1);
PCode2 := CalcPCode (x2,y2);
if ((PCode1 or PCode2) = $00)
  then LineInWindow := True
  else begin
       if (Pcode1 and Pcode2) = $00 then
         begin
         DoClip (x1,y1,x2,y2);
         PCode1 := CalcPCode (x1,y1);
         PCode2 := CalcPCode (x2,y2);
         if ((PCode1 or PCode2) = $00)
           then LineInWindow := True
           else begin
                DoClip (x1,y1,x2,y2);
                PCode1 := CalcPCode (x1,y1);
                PCode2 := CalcPCode (x2,y2);
                if ((PCode1 or PCode2) = $00)
                  then LineInWindow := True;
                end;
         end;
       end;
if not LineInWindow then
  begin
  x1 := x1bak;
  y1 := y1bak;
  x2 := x2bak;
  y2 := y2bak;
  end;
ClipLine := LineInWindow;
end;


(******************************************************************)
procedure ClipLineEndPointBox (var x1, y1, x2, y2: longint; dx1, dy1,
                               dx2, dy2: longint);
(******************************************************************
  ENTRY:      x1, y1 ..... starting point of line
              x2, y2 ..... end point of line
              dx1, dy1 ... dx, dy of box at starting point
              dx2, dy2 ... dx, dy of box at end point

  EXIT:       x1, y1 ..... new coordinates of starting point
              x2, y2 ..... new coordinates of end point
 ******************************************************************)

var
  k   : double;
  d   : double;

begin
if x2-x1 > 0
  then dx1 := -dx1
  else dx2 := -dx2;
if y2-y1 > 0
  then dy1 := -dy1
  else dy2 := -dy2;
if x2 = x1        (* vertical line ? *)
  then begin
       y1 := y1 - dy1;
       y2 := y2 - dy2;
       end
  else begin
       if y1 = y2    (* horizontal line *)
         then begin
              x1 := x1 - dx1;
              x2 := x2 - dx2;
              end
         else begin  (* any other direction *)
              if ((dx1 <> 0) or (dy1 <> 0) or (dx2 <> 0) or (dy2 <> 0)) then
                begin
                if abs(dy1*(x2-x1)) >= abs(dx1*(y2-y1))
                  then begin
                       k := (y2-y1)/(x2-x1);
                       d := y1-k*x1;
                       y1 := round(k*(x1-dx1)+d);
                       x1 := x1-dx1;
                       end
                  else begin
                       k := (x2-x1)/(y2-y1);
                       d := x1-k*y1;
                       x1 := round(k*(y1-dy1)+d);
                       y1 := y1-dy1;
                       end;
                if abs(dy2*(x2-x1)) >= abs(dx2*(y2-y1))
                  then begin
                       if x2 <> x1 then
                         begin
                         k := (y2-y1)/(x2-x1);
                         d := y2-k*x2;
                         y2 := round(k*(x2-dx2)+d);
                         x2 := x2-dx2;
                         end;
                       end
                  else begin
                       if y2 <> y1 then
                         begin
                         k := (x2-x1)/(y2-y1);
                         d := x2-k*y2;
                         x2 := round(k*(y2-dy2)+d);
                         y2 := y2-dy2;
                         end;
                       end;
                end;
              end;
       end;
end;
