unit cform;

(******************************************************************)
(*                                                                *)
(*                           C F O R M                            *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1996..2001 H. Lohninger                 August  1997   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Aug-01, 2001                                  *)
(*                                                                *)
(******************************************************************)

{Revision History:

1.0   [Oct-15, 1997]
         first release to the public

1.1   [Apr-08, 1998]
      CFORM now available for C++Builder version 3.0

1.2   [Aug-17, 1998]
      CFORM is now available for Delphi 4.0

1.3   [Mar-26, 1999]
      CFORM is now available for C++Builder 4.0

5.0   [Oct-10, 1999]
      CFORM is now part of SDL Component Suite 5.0
      available for Delphi 5.0

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      ColorBkg is now clBtnFace by default
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


{-------------------------------------------------------------------------}
interface
{-------------------------------------------------------------------------}


uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls;

const
  FormMaxEl = 20;          { max. number of elements in molecular formula }

type
  TIsotVisib = (ivNone, ivSpecial, ivAlways);
  TFormulaRec = record
                  FLeng : integer;
                  AtNum : array[1..FormMaxEl] of byte;    { atomic number }
                  AtWgt : array[1..FormMaxEl] of byte;  { isotopic weight }
                  AtCnt : array[1..FormMaxEl] of byte;       { atom count }
                end;
  TMolForm =
       class (TGraphicControl)
       private
         FAlignment    : TAlignment;     { alignment of molecular formula }
         FColorBkg     : TColor;              { color of panel background }
         FColorTxt     : TColor;                  { color of formula text }
         FBFLeng       : integer;            { number of valid atom types }
         FPermutCnt    : array[1..FormMaxEl] of longint;
                    { permutation count for molecular formula calculation }
         FMassBForm    : double;              { mass of molecular formula }
         FTolBForm     : double;         { tolerance of molecular formula }
         FUseDeuterium : boolean;             { true: use D instead of 2H }
         FShowAsText   : boolean;      { true: label is displayed as text }
         FTransparent  : boolean;          { true: transparent background }
         FFormulStr    : string;{string which contains the formula as text}
         FAtNum        : array[1..FormMaxEl] of byte;    { atomic number }
         FAtWgt        : array[1..FormMaxEl] of byte;  { isotopic weight }
         FAtCnt        : array[1..FormMaxEl] of byte;       { atom count }
         FIsotVis      : TIsotVisib;  { visibility of isotope information }
         FLowBForm     : TFormulaRec;  { lowest allowed indices of molecular formula }
         FHighBForm    : TFormulaRec;  { highest allowed indices of molecular formula }

         function  ChemElem (AtNr, AtWt, AtNum: integer; Format: byte): string;
         function  FindFormulaIntern(IntMass, CheckPlausibility: boolean): boolean;
         function  GetMolFormula: string;
         function  GetAtNum (idx: integer): integer;
         procedure SetAtNum (idx: integer; value: integer);
         function  GetAtWgt (idx: integer): integer;
         procedure SetAtWgt (idx: integer; value: integer);
         function  GetAtCnt (idx: integer): integer;
         procedure SetAtCnt (idx: integer; value: integer);
         procedure SetAlignment (value: TAlignment);
         procedure SetColorBkg (Value: TColor);
         procedure SetColorTxt (Value: TColor);
         procedure SetNumAtoms (Value: integer);
         function  GetNumAtoms: integer;
         procedure SetIsotVis (x: TIsotVisib);
         procedure SetMolFormula (x: string);
         procedure SetShowAsText (x: boolean);
         procedure SetTransparent (x: boolean);
         procedure SetUseDeuter (x: boolean);
       protected
         procedure Paint; override;
         procedure AssignTo (Dest: TPersistent); override;
       public
         constructor Create(AOwner: TComponent); override;
         destructor  Destroy; override;
         procedure Assign(Source: TPersistent); override;
         function  AsString (fmt: integer): string;
         function  ChemMolWgt: double;
         procedure Clear;
         function  NominalMolWgt: integer;
         function  ScanNextFormPart (Instring: string;
                       var index, AtNr, AtWt, AtNum: integer): boolean;
         property  AtNum[ix: integer]: integer read GetAtNum write SetAtNum;
         property  AtWgt[ix: integer]: integer read GetAtWgt write SetAtWgt;
         property  AtCnt[ix: integer]: integer read GetAtCnt write SetAtCnt;
         property  NumAtoms: integer read GetNumAtoms write SetNumAtoms;
         procedure ShowIt;
         procedure ReadFromString (Instring: string);
         function  CompareTo (OtherFormula: TMolForm): integer;
         function  FindFormulaNominalMass (CheckPlausibility: boolean): boolean;
         function  FindFormulaExactMass (CheckPlausibility: boolean): boolean;
         function  InitFindFormula (mass, tol: double; LowF, HighF: TFormulaRec): boolean;
       published
         property ColorBkg: TColor read FColorBkg write SetColorBkg;
         property ColorTxt: TColor read FColorTxt write SetColorTxt;
         property Font;
         property IsotopeVis: TIsotVisib read FIsotVis write SetIsotVis;
         property MolFormula: string read GetMolFormula write SetMolFormula;
         property ParentFont;
         property ParentShowHint;
         property ShowAsText: boolean read FShowAsText write SetShowAsText;
         property ShowHint;
         property Transparent: boolean read FTransparent write SetTransparent;
         property UseDeuterium: boolean read FUseDeuterium write SetUseDeuter;
         property Visible;
         property Alignment: TAlignment read FAlignment write SetALignment;
         property OnClick;
         property OnDblClick;
         property OnMouseMove;
         property OnMouseDown;
         property OnMouseUp;
       end;


procedure Register;


{-----------------------------------------------------------------------}
implementation
{-----------------------------------------------------------------------}

uses
  cdata;

{$IFDEF SHAREWARE}
{$I sharwinc\cform_ct.inc}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}

const
  defCFormWidth = 120;                   { default width of formula panel }

type
{$IFNDEF VER80}
  ShortStr = ShortString;
{$ELSE}
  ShortStr = string;
{$ENDIF}


(***********************************************************************)
constructor TMolForm.Create(AOwner: TComponent);
(***********************************************************************)

begin
inherited Create (AOwner);
Width := defCFormWidth;
Height := 28;
FAlignment := taCenter;
FColorTxt := clBlack;
FColorBkg := clBtnFace;
FMassBForm := 0.0;
FTolBForm := 0.05;
FBFLeng := 2;
FAtNum [1] := 1;  { default formula is that of water }
FAtWgt [1] := 1;
FAtCnt [1] := 2;
FAtNum [2] := 8;
FAtWgt [2] := 16;
FAtCnt [2] := 1;
FIsotVis := ivSpecial;
FUseDeuterium := true;
FFormulStr := 'H2O';
FShowAsText := false;
FTransparent := false;
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;


(***********************************************************************)
destructor TMolForm.Destroy;
(***********************************************************************)

begin
inherited Destroy;    { Inherit original constructor }
end;


(***********************************************************************)
function TMolForm.GetAtNum (idx: integer): integer;
(***********************************************************************)

begin
if (idx >= 1) and (idx <= FBFLeng)
  then GetAtnum := FAtNum[idx]
  else getAtNum := 0;
end;

(***********************************************************************)
procedure TMolForm.SetAtNum (idx: integer; value: integer);
(***********************************************************************)

begin
if (idx >= 1) and (idx <= FBFLeng) and
  (value >=1) and (value <= MaxChemElem) then
  FAtNum[idx] := value;
end;

(***********************************************************************)
function TMolForm.GetAtCnt (idx: integer): integer;
(***********************************************************************)

begin
if (idx >= 1) and (idx <= FBFLeng)
  then GetAtCnt := FAtCnt[idx]
  else getAtCnt := 0;
end;

(***********************************************************************)
procedure TMolForm.SetAtCnt (idx: integer; value: integer);
(***********************************************************************)

begin
if (idx >= 1) and (idx <= FBFLeng) then
  FAtCnt[idx] := value;
end;

(***********************************************************************)
function TMolForm.GetAtWgt (idx: integer): integer;
(***********************************************************************)

begin
if (idx >= 1) and (idx <= FBFLeng)
  then GetAtWgt := FAtWgt[idx]
  else getAtWgt := 0;
end;

(***********************************************************************)
procedure TMolForm.SetAtWgt (idx: integer; value: integer);
(***********************************************************************)

begin
if (idx >= 1) and (idx <= FBFLeng) then
  FAtWgt[idx] := value;
end;


(***********************************************************************)
procedure TMolForm.SetNumAtoms (Value: integer);
(***********************************************************************)

begin
if (Value <= FormMaxEl) and (Value >=1) then
  FBFleng := Value;
end;

(***********************************************************************)
function TMolForm.GetNumAtoms: integer;
(***********************************************************************)

begin
GetNumAtoms := FBFleng;
end;


(***********************************************************************)
procedure TMolForm.SetColorTxt (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorTxt then
  begin
  FColorTxt := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TMolForm.SetUseDeuter (x: boolean);
(***********************************************************************)

begin
if x <> FUseDeuterium then
  begin
  FUseDeuterium := x;
  if FTransparent
    then Invalidate
    else Paint;
  end;
end;


(***********************************************************************)
procedure TMolForm.SetShowAsText (x: boolean);
(***********************************************************************)

begin
if x <> FShowAsText then
  begin
  FShowAsText := x;
  if FTransparent
    then Invalidate
    else Paint;
  end;
end;

(***********************************************************************)
procedure TMolForm.SetTransparent (x: boolean);
(***********************************************************************)

begin
if x <> FTransparent then
  begin
  FTransparent := x;
  if FTransparent
    then Invalidate
    else Paint;
  end;
end;



(***********************************************************************)
procedure TMolForm.SetIsotVis (x: TIsotVisib);
(***********************************************************************)

begin
if x <> FIsotVis then
  begin
  FIsotVis := x;
  if FTransparent
    then Invalidate
    else Paint;
  end;
end;

(***********************************************************************)
procedure TMolForm.SetMolFormula (x: string);
(***********************************************************************)

var
  ix   : integer;
  AtNr : integer;
  AtWt : integer;
  AtCt : integer;

begin
FFormulStr := x;
ix := 1;
FBFLeng := 0;
while ScanNextFormPart (x,ix,AtNr,AtWt,AtCt) do
  begin
  inc (FBFLeng);
  FAtNum[FBFLeng] := AtNr;
  FAtWgt[FBFLeng] := AtWt;
  FAtCnt[FBFLeng] := AtCt;
  end;
if FTransparent
  then Invalidate
  else Paint;
end;


(***********************************************************************)
function TMolForm.GetMolFormula: string;
(***********************************************************************)

begin
GetMolFormula := AsString(1);
end;



(***********************************************************************)
procedure TMolForm.SetColorBkg (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorBkg then
  begin
  FColorBkg := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TMolForm.SetAlignment (value: TAlignment);
(***********************************************************************)

begin
if Value <> FAlignment then
  begin
  FAlignment := Value;
  if FTransparent
    then Invalidate
    else Paint;
  end;
end;


(***********************************************************************)
procedure TMolForm.AssignTo (Dest: TPersistent);
(***********************************************************************)


begin
if self is Dest.ClassType
  then Dest.Assign (self)
  else inherited AssignTo (Dest);
end;

(***********************************************************************)
procedure TMolForm.Assign(Source: TPersistent);
(***********************************************************************
  REMARK: Only those fields are copied which are defined with the
          TMolForm declaration !!
 ***********************************************************************)

var
  i : integer;

begin
if Source is TMolForm
  then begin
       FAlignment    := TMolForm(Source).FAlignment;
       FColorBkg     := TMolForm(Source).FColorBkg;
       FColorTxt     := TMolForm(Source).FColorTxt;
       FBFLeng       := TMolForm(Source).FBFLeng;
       for i:=1 to FormMaxEl do
         FPermutCnt[i] := TMolForm(Source).FPermutCnt[i];
       FMassBForm    := TMolForm(Source).FMassBForm;
       FTolBForm     := TMolForm(Source).FTolBForm;
       FUseDeuterium := TMolForm(Source).FUseDeuterium;
       FShowAsText   := TMolForm(Source).FShowAsText;
       FTransparent  := TMolForm(Source).FTransparent;
       FFormulStr    := TMolForm(Source).FFormulStr;
       for i:=1 to FormMaxEl do
         FAtNum[i]   := TMolForm(Source).FAtNum[i];
       for i:=1 to FormMaxEl do
         FAtWgt[i]   := TMolForm(Source).FAtWgt[i];
       for i:=1 to FormMaxEl do
         FAtCnt[i]   := TMolForm(Source).FAtCnt[i];
       FIsotVis      := TMolForm(Source).FIsotVis;
       FLowBForm     := TMolForm(Source).FLowBForm;
       FHighBForm    := TMolForm(Source).FHighBForm;
       if FTransparent
         then Invalidate
         else Paint;
       end
  else inherited Assign(Source);
end;


(***********************************************************************)
procedure TMolForm.Paint;
(***********************************************************************)

var
  GrafBmp    : TBitMap;
  AuxBmp     : TBitMap;
  MaskBmp    : TBitMap;
  xpoi       : integer;
  i          : integer;
  SmlFntSize : integer;
  LrgFntSize : integer;
  SrcRect    : TRect;
  DestRect   : TRect;
  cc         : string;
  BakColor   : TColor;
{$IFDEF SHAREWARE}
  astr       : string;
  j          : integer;
{$ENDIF}

begin
if Visible or (csDesigning in ComponentState) then
  begin
  Canvas.Font := Font;
  LrgFntSize := Canvas.Font.Size;
  SmlFntSize := 1+round(0.8*LrgFntSize);
  Canvas.Font.Size := SmlFntSize;
  Height := 2*Canvas.TextHeight ('M');   { trick to get height of font }
  Canvas.Font.Size := LrgFntSize;
  GrafBmp := TBitmap.Create;      { create working bitmap for flickerfree }
  GrafBmp.Width := Width;          { display and set its width and height }
  GrafBmp.Height := Height;
  AuxBmp := TBitmap.Create;                     { create auxiliary bitmap }
  AuxBmp.Width := 2*Width;
  AuxBmp.Height := Height;
  MaskBmp := TBitmap.Create;                         { create mask bitmap }
  MaskBmp.Width := 2*Width;
  MaskBmp.Height := Height;
  if FTransparent
    then BakCOlor := clBlack
    else BakColor := FColorBkg;
  with GrafBmp do
    begin
    Canvas.Font := Font;
    Canvas.Brush.Color := BakCOlor;
    Canvas.Pen.Color := BakColor;
    Canvas.Rectangle (0, 0, Width, Height);       { background of MolForm }
    AuxBmp.Canvas.Font := Font;
    AuxBmp.Canvas.Brush.Color := BakColor;
    AuxBmp.Canvas.Pen.Color := BakColor;
    AuxBmp.Canvas.Rectangle (0, 0, 2*Width, Height); { background of MolForm }
    AuxBmp.Canvas.Font.Color := FColorTxt;
    MaskBmp.Canvas.Font := Font;
    MaskBmp.Canvas.Brush.Color := clWhite;
    MaskBmp.Canvas.Pen.Color := clWhite;
    MaskBmp.Canvas.Rectangle (0, 0, 2*Width, Height); { background of MolForm }
    MaskBmp.Canvas.Font.Color := clBlack;
    xpoi := 1;                  { draw the formula left aligned on AuxBMP }
    if FShowAsText
      then begin
           AuxBmp.Canvas.TextOut (xpoi, Height div 5, FFormulStr);  { atom symbol }
           MaskBmp.Canvas.TextOut (xpoi, Height div 5, FFormulStr);
           xpoi := xpoi + AuxBmp.Canvas.Textwidth (FFormulStr);
           end
      else begin
           for i:=1 to FBFLeng do
             if FAtCnt[i] > 0 then
               begin
               if not (FUseDeuterium and (FAtWgt[i] = 2) and (FAtNum[i] = 1)) then
               case FIsotVis of                         { isotopic number }
                 ivAlways : begin
                            AuxBmp.Canvas.Font.Size := SmlFntSize;
                            AuxBmp.Canvas.TextOut (xpoi, 0, IntToStr(FAtWgt[i]));
                            MaskBmp.Canvas.Font.Size := SmlFntSize;
                            MaskBmp.Canvas.TextOut (xpoi, 0, IntToStr(FAtWgt[i]));
                            MaskBmp.Canvas.Font.Size := LrgFntSize;
                            xpoi := xpoi + AuxBmp.Canvas.Textwidth (IntToStr (FAtWgt[i]));
                            AuxBmp.Canvas.Font.Size := LrgFntSize;
                            end;
                 ivSpecial: begin
                            if FAtWgt [i] <> IntAtWeight(FAtNum[i]) then
                              begin
                              AuxBmp.Canvas.Font.Size := SmlFntSize;
                              AuxBmp.Canvas.TextOut (xpoi, 0, IntToStr(FAtWgt[i]));
                              MaskBmp.Canvas.Font.Size := SmlFntSize;
                              MaskBmp.Canvas.TextOut (xpoi, 0, IntToStr(FAtWgt[i]));
                              MaskBmp.Canvas.Font.Size := LrgFntSize;
                              xpoi := xpoi + AuxBmp.Canvas.Textwidth (IntToStr (FAtWgt[i]));
                              AuxBmp.Canvas.Font.Size := LrgFntSize;
                              end;
                            end;
               end;
               if (FUseDeuterium and (FAtWgt[i] = 2) and (FAtNum[i] = 1))
                 then cc := 'D'
                 else cc := CElemSymb (FAtNum[i]);

               AuxBmp.Canvas.TextOut (xpoi, Height div 5, cc); { atom symbol }
               MaskBmp.Canvas.TextOut (xpoi, Height div 5, cc);
               xpoi := xpoi + AuxBmp.Canvas.Textwidth (cc);
               if FAtCnt[i] > 1 then   { atom count }
                 begin
                 AuxBmp.Canvas.Font.Size := SmlFntSize;
                 AuxBmp.Canvas.TextOut (xpoi, Height div 4+SmlFntSize, IntToStr(FAtCnt[i]));
                 MaskBmp.Canvas.Font.Size := SmlFntSize;
                 MaskBmp.Canvas.TextOut (xpoi, Height div 4+SmlFntSize, IntToStr(FAtCnt[i]));
                 MaskBmp.Canvas.Font.Size := LrgFntSize;
                 xpoi := xpoi + AuxBmp.Canvas.Textwidth (IntToStr (FAtCnt[i]));
                 AuxBmp.Canvas.Font.Size := LrgFntSize;
                 end;
               end;
           end;

    SrcRect.Left := 1;
    SrcRect.Top := 1;
    SrcRect.Right := xpoi;
    SrcRect.Bottom := height;
    DestRect.Left := 1;
    DestRect.Top := 1;
    DestRect.Right := xpoi;
    DestRect.Bottom := height;

    case FAlignment of             { now copy AuxBmp to proper position }
       taLeftJustify : begin
                       Canvas.CopyRect (DestRect, AuxBmp.Canvas, SrcRect);
                       end;
            taCenter : begin
                       if xpoi > Width then
                         begin
                         SrcRect.Left := (xpoi-Width) div 2;
                         SrcRect.Right := SrcRect.Left+Width;
                         xpoi := width;
                         end;
                       DestRect.Left := (Width-xPoi) div 2;
                       DestRect.Top := 1;
                       DestRect.Right := DestRect.Left + xpoi;
                       DestRect.Bottom := height;
                       Canvas.CopyRect (DestRect, AuxBmp.Canvas, SrcRect);
                       end;
      taRightJustify : begin
                       if xpoi > Width then
                         begin
                         SrcRect.Left := xpoi-Width;
                         SrcRect.Right := xpoi;
                         xpoi := width;
                         end;
                       DestRect.Left := Width-xPoi;
                       DestRect.Top := 1;
                       DestRect.Right := Width;
                       DestRect.Bottom := height;
                       Canvas.CopyRect (DestRect, AuxBmp.Canvas, SrcRect);
                       end;
    end;

    {$IFDEF SHAREWARE}
    Hint := GetHintStr;
    ShowHint := True;
    if not DelphiIsRunning then
      begin
      Canvas.Font.Color := clWhite;
      Canvas.Font.Name := 'MS Sans Serif';
      Canvas.Brush.Color := clNavy;
      Canvas.Brush.Style := bsSolid;
      Canvas.Font.Size := 8;
      astr := GetVisMsgStr;
      j := 0;
      while length(astr) > 0 do
        begin
        i := pos (#10, astr);
        if i = 0 then
          i := length(astr);
        Canvas.TextOut (10,10+20*j, ' '+copy (astr,1,i-1)+' ');
        inc(j);
        delete (astr,1,i);
        end;
      end;
    {$ENDIF}

    end;
  if FTransparent
    then begin
         Canvas.CopyMode := cmSrcAnd;
         Canvas.CopyRect (DestRect, MaskBmp.Canvas, SrcRect);
         Canvas.CopyMode := cmSrcPaint;
         Canvas.Draw (0,0,GrafBmp);
         Canvas.CopyMode := cmSrcCopy;
         end
    else begin
         Canvas.CopyMode := cmSrcCopy;
         Canvas.Draw (0,0,GrafBmp);
         end;
  GrafBmp.Free;                             { destroy the graphics bitmap }
  AuxBmp.Free;
  MaskBmp.Free;
  end;
end;



(******************************************************************)
function TMolForm.InitFindFormula (mass, tol: double; LowF, HighF: TFormulaRec): boolean;
(******************************************************************
  ENTRY:  mass ... mass of molecule
          tol .... tolerance of mass comparison, if tol=0.0 then integer
                   calculation takes place
          LowF ... lowest allowed indices of resulting molecular formula
          HighF .. highest allowed indices of resulting molecular formula

  EXIT:   function returns TRUE if initialisation has been performed successfully
 ******************************************************************)

var
  i : integer;

begin
FMassBForm := Mass;
FTolBForm := tol;
FLowBForm := LowF;
FHighBForm := HighF;
for i:=1 to FHighBForm.FLeng do
  FPermutCnt[i] := FHighBForm.AtCnt[i];
InitFindFormula := true; { provisional - function value is for later extensions }
end;


(******************************************************************)
function TMolForm.FindFormulaIntern(IntMass, CheckPlausibility: boolean): boolean;
(******************************************************************
  ENTRY:  IntMass .. TRUE: nominal mass processing, else "real"
                     isotopic weights
          CheckPlausibility .. TRUE: formulas are checked for chemical
                     plausibility
          none (entry parameters are setup by 'InitFindFormula')

  EXIT:   molecular formula, which fulfills restrictions specified
          by 'InitFindFormula'. Function returns TRUE if valid molecular
          formula found, and returns FALSE if no more valid formulae
          can be found.
 ******************************************************************)

var
  FFound, Fend : boolean;
  imass        : integer;
  imw          : double;
  i            : integer;

function CheckChemPlausib: boolean;
{---------------------------------}

var
  ccnt, fcnt, icnt,
  clcnt, brcnt,
  ncnt, hcnt  : integer;
  reslt       : boolean;
  i           : integer;

begin                             { plausibility check }
if not CheckPlausibility
  then CheckChemPlausib := true   { no check }
  else begin                      { do the check }
       reslt := true;
       hcnt := 0;
       ccnt := 0;
       clcnt := 0;
       fcnt := 0;
       ncnt := 0;
       brcnt := 0;
       icnt := 0;
       for i:=1 to FHighBForm.FLeng do
         case FHighBForm.AtNum[i] of
           1 : hcnt := FPermutCnt[i];
           6 : ccnt := FPermutCnt[i];
           7 : ncnt := FPermutCnt[i];
           9 : fcnt := FPermutCnt[i];
          17 : clcnt := FPermutCnt[i];
          35 : brcnt := FPermutCnt[i];
          53 : icnt := FPermutCnt[i];
         end;
       if hcnt+fcnt+clcnt+brcnt+icnt > 2*ccnt+ncnt+2 then
         reslt := false;
       CheckChemPlausib := reslt;
       end;
end;


function DecrementPermutCnt: boolean;
{-----------------------------------}

var
  k : integer;
  NoUbertrag : boolean;

begin
k := FHighBForm.Fleng;
repeat
  NoUbertrag := True;
  dec (FPermutCnt[k]);
  if FpermutCnt[k] < FLowBForm.AtCnt[k] then
    begin
    FpermutCnt[k] := FHighBForm.AtCnt[k];
    dec (k);
    NoUbertrag := False;
    end;
until ((k=0) or (NoUbertrag));
if k=0
  then DecrementPermutCnt := False
  else DecrementPermutCnt := True;
end;


begin
if IntMass
  then begin           { integer mass processing }
       FFound := false;
       imass := round(FmassBForm);
       repeat
         imw := 0;
         for i:=1 to FHighBForm.FLeng do
           imw := imw + FHighBForm.AtWgt[i]*FpermutCnt[i];
         if imw = imass then
           begin
           if CheckChemPlausib then
             begin
             Ffound := true;
             FBFLeng := FHighBForm.FLeng;
             for i:=1 to FHighBForm.FLeng do
               begin
               FAtNum[i] := FHighBForm.AtNum[i];
               FAtWgt[i] := FHighBForm.AtWgt[i];
               FAtCnt[i] := FPermutCnt[i];
               end;
             end;
           end;
         FEnd := not DecrementPermutCnt;
       until FFound or FEnd;
       FindFormulaIntern := FFound;
       end
  else begin             { real mass processing }
       FFound := false;
       repeat
         imw := 0;
         for i:=1 to FHighBForm.FLeng do
           imw := imw + ExactAtWeight(FHighBForm.AtNum[i])*FpermutCnt[i];
         if abs(imw - FMassBForm) < FTolBForm then
           begin
           if CheckChemPlausib then
             begin
             Ffound := true;
             FBFLeng := FHighBForm.FLeng;
             for i:=1 to FHighBForm.FLeng do
               begin
               FAtNum[i] := FHighBForm.AtNum[i];
               FAtWgt[i] := FHighBForm.AtWgt[i];
               FAtCnt[i] := FPermutCnt[i];
               end;
             end;
           end;
         FEnd := not DecrementPermutCnt;
       until FFound or FEnd;
       FindFormulaIntern := FFound;
       end;
if FTransparent
  then Invalidate
  else Paint;
end;

(******************************************************************)
function TMolForm.FindFormulaNominalMass (CheckPlausibility: boolean): boolean;
(******************************************************************
  ENTRY:  none (entry parameters are setup by 'InitFindFormula')
          Formula search is performed with nominal atomic weights.

  EXIT:   molecular formula, which fulfills restrictions specified
          by 'InitFindFormula'. Function returns TRUE if valid molecular
          formula found, and returns FALSE if no more valid formulae
          can be found.
 ******************************************************************)

begin
FindFormulaNominalMass := FindFormulaIntern(true, CheckPlausibility);
end;


(******************************************************************)
function TMolForm.FindFormulaExactMass (CheckPlausibility: boolean): boolean;
(******************************************************************
  ENTRY:  none (entry parameters are setup by 'InitFindFormula')
          Formula search is performed with exact atomic weights.

  EXIT:   molecular formula, which fulfills restrictions specified
          by 'InitFindFormula'. Function returns TRUE if valid molecular
          formula found, and returns FALSE if no more valid formulae
          can be found.
 ******************************************************************)

begin
FindFormulaExactMass := FindFormulaIntern(false, CheckPlausibility);
end;


(**********************************************************)
function TMolForm.ScanNextFormPart
            (Instring : string;                    { string to analyze }
            var index : integer;      { index where to start in string }
             var AtNr : integer; { atomic number of next element found }
             var AtWt : integer;      { atomic weighth of that element }
            var AtNum : integer)                     { number of atoms }
                      : boolean;               { TRUE if valid returns }
(**********************************************************)

(* ScanNextFormPart scans a string which contains a molecular formula.
   The starting point of scanning is at position 'index'. If
   any valid element contained is found, the paramters 'AtNr',
   'AtWt', and 'AtNum' are returned and the function value is
   set TRUE. The value of 'index' is set to the next unscanned
   part of 'Instring'. If no number is found before the symbol,
   'AtWt' is set to the default value for that element. If no
   number is found  after the symbol ´AtNum´ is set to 1.

   valid entries:   C12H22O N
                    C12H22O1N
                    C12 H22 O N
                    c12 h22 o n
                    C12 H22 O1 N1
                    13C4 H 8 O  (* 4 C-13 atoms !!)

   invalid entries: C12H22ON


     phase                 cc  dg  ic  EOS
-------------------------------------------
ReadLeadingChars   0        3   1   0   6
ReadFirstNum       1        3   1   2   6
SkipIntermedChars  2        3   6   2   6
ReadATSymbol       3        3   5   4   6
SkipIntermedChars  4        6   5   4   6
ReadSecndNum       5        6   5   6   6
End                6
-------------------------------------------


cc = character ['A' .. 'Z']
dg = digit ['0' ..'9']
ic = any other character
EOS = end of string
*)

type
  TPhase = (phLeadC, ph1stNum, ph1stInter,
            phAtSymb, ph2ndInter, ph2ndNum, phEnd);

var
  EleFound : boolean;
  FirstNum : integer;
  SecndNum : integer;
  AtSymb   : string;
  Phase    : TPhase;
  NextPhase: TPhase;
  cc       : char;

function GetNextChar: char;
(*-----------------------*)

begin
inc (index);
if index > length (Instring)
  then GetNextChar := #0
  else GetNextChar := upcase(Instring[index]);
end;


begin
Phase := phLeadC;
NextPhase := phLeadC;
AtSymb := '';
FirstNum := 0;
SecndNum := 0;
dec(index);
repeat
  cc := GetNextChar;
  if cc = #0 then
    begin
    phase := phEnd;
    NextPhase := phEnd;
    end;
  case phase of
     phLeadC : begin
               if cc in ['0' .. '9'] then
                 begin
                 FirstNum := 10 * FirstNum + ord(cc) - 48;
                 NextPhase := ph1stNum;
                 end;
               if cc in ['A' .. 'Z'] then
                 begin
                 AtSymb := AtSymb + cc;
                 NextPhase := phAtSymb;
                 end;
               end;
    ph1stNum : begin
               if cc in ['A' .. 'Z'] then
                 begin
                 NextPhase := phAtSymb;
                 AtSymb := AtSymb + cc;
                 end;
               if cc in ['0' .. '9'] then
                 FirstNum := 10 * FirstNum + ord(cc) - 48;
               if cc in [' ',',','.'] then
                 NextPhase := ph1stInter;
               end;
  ph1stInter : begin
               if cc in ['A' .. 'Z'] then
                 begin
                 NextPhase := phAtSymb;
                 AtSymb := AtSymb + cc;
                 end;
               if cc in ['0' .. '9'] then
                 NextPhase := phEnd;
               end;
    phAtSymb : begin
               if cc in ['A' .. 'Z'] then
                 AtSymb := AtSymb + cc;
               if cc in ['0' .. '9'] then
                 begin
                 SecndNum := 10 * SecndNum + ord(cc) - 48;
                 NextPhase := ph2ndNum;
                 end;
               if cc in [' ',',','.'] then
                 NextPhase := ph2ndInter;
               end;
  ph2ndInter : begin
               if cc in ['A' .. 'Z'] then
                 NextPhase := phEnd;
               if cc in ['0' .. '9'] then
                 begin
                 SecndNum := 10 * SecndNum + ord(cc) - 48;
                 NextPhase := ph2ndNum;
                 end;
               end;
    ph2ndNum : begin
               if cc in ['A' .. 'Z'] then
                 NextPhase := phEnd;
               if cc in ['0' .. '9'] then
                 SecndNum := 10 * SecndNum + ord(cc) - 48;
               if cc in [' ',',','.'] then
                 NextPhase := phEnd;
               end;
  end;
  Phase := NextPhase;
until Phase = phEnd;

EleFound := false;
AtNr := 0;
if (length(ATSymb) > 0) then
  begin
  if AtSymb = 'D'
    then begin
         EleFOund := True;
         AtNr := 1;
         end
    else begin
         repeat
           inc (AtNr);
           if uppercase(ATSymb) = upperCase (CElemSymb (AtNr))
             then EleFound := TRUE;
         until (Elefound or (AtNr >= 103));
         end;
  if EleFound then
    begin
    if FirstNum = 0
      then begin
           if AtSymb = 'D'
             then AtWt := 2
             else AtWt := IntAtWeight (AtNr);
           end
      else AtWt := FirstNum;
    if SecndNum = 0
      then AtNum := 1
      else AtNum := SecndNum;
    end;
  end;
ScanNextFormPart := EleFound;
end;


(******************************************************************)
procedure TMolForm.ReadFromString (Instring: string);
(******************************************************************)

var
  index      : integer;
  AtNr       : integer;
  AtWt       : integer;
  AtNum      : integer;
  scanResult : boolean;

begin
index := 1;
FBFLeng := 0;
repeat
  ScanResult := ScanNextFormPart (Instring, index, AtNr, AtWt, AtNum);
  if (ScanResult and (AtNum > 0)) then
    begin
    inc (FBFLeng);
    FAtNum [FBFLeng] := AtNr;
    FAtWgt [FBFLeng] := AtWt;
    FAtCnt [FBFLeng] := AtNum;
    end;
until not ScanResult;
if FTransparent
  then Invalidate
  else Paint;
end;


(******************************************************************)
function TMolForm.AsString (fmt: integer): string;
(******************************************************************)


var
  astr   : string;
  i      : integer;

begin
astr := '';
if (FBFLeng > 0) and (FBFLeng <= FormMaxEl) then
  begin
  for i:=1 to FBFLeng do
    astr := astr + ChemElem(FAtNum[i],FAtWgt[i],FAtCnt[i],fmt)+' ';
  end;
AsString := astr;
end;


(******************************************************************)
function TMolForm.CompareTo (OtherFormula: TMolForm): integer;
(******************************************************************
  ENTRY:    OtherFormula .... molecular formula to compare to

  EXIT:     function returns 2, if self is contained in OtherFormula
                             1, if OtherFormula is contained in self
                             0, if OtherFormula equals self
                            -1, if OtherFormula and self are neither equal nor contained
                            -2, if either OtherFormula or self is empty

  REMARK:   the formulas to be compared must not contain multiple entries
            of the same atoms (e.g. C4 H10 C O  should be C5 H10 O)
 ******************************************************************)

type
  AuxFormType = record      { note: this record differs from TFormulaRec ! }
                  FLeng : integer;            { number of valid atom types }
                  AtNum : array[1..FormMaxEl] of integer;  { atomic number }
                  AtWgt : array[1..FormMaxEl] of integer;{ isotopic weight }
                  AtCnt : array[1..FormMaxEl] of integer;     { atom count }
                end;

var
  reslt             : integer;
  AuxF              : AuxFormType;
  eqfg,
  f1GTOtherFormula,
  OtherFormulaGTf1  : boolean;
  i,j               : integer;

begin
if ((FBFLeng = 0) or (OtherFormula.NumAtoms = 0))
  then reslt := -2
  else begin                                         { compare formulas }
       for i:=1 to FormMaxEl do
         begin
         AuxF.AtNum[i] := 0;
         AuxF.AtWgt[i] := 0;
         AuxF.AtCnt[i] := 0;
         end;
       AuxF.FLeng := 0;  { copy formula from self and sum up equal isotopes }
       for i:=1 to FBFLeng do
         begin
         j := 1;
         while ((j < FormMaxEl) and (AuxF.AtNum[j] > 0) and
                (AuxF.AtNum[j] <> FAtNum[i]) and (AuxF.AtWgt[j] <> FAtWgt[i])) do
           inc (j);
         if AuxF.AtNum[j] <> 0
           then begin
                AuxF.AtCnt[j] := AuxF.AtCnt[j] + FAtCnt[i];
                end
           else begin
                inc (AuxF.FLeng);
                AuxF.AtNum[j] := FAtNum[i];
                AuxF.AtWgt[j] := FAtWgt[i];
                AuxF.AtCnt[j] := FAtCnt[i];
                end
         end;
       for i:=1 to OtherFormula.NumAtoms do   { now compare atoms }
         begin
         j:=0;
         repeat
           inc (j);
         until (j = AuxF.FLeng) or ((AuxF.AtNum[j] = OtherFormula.AtNum[i]) and
                                    (AuxF.AtWgt[j] = OtherFormula.AtWgt[i]));
         if (AuxF.AtNum[j] = OtherFormula.AtNum[i]) and (AuxF.AtWgt[j] = OtherFormula.AtWgt[i])
           then AuxF.AtCnt[j] := AuxF.AtCnt[j]-OtherFormula.AtCnt[i]
           else begin
                inc(AuxF.FLeng);
                AuxF.AtNum[AuxF.FLeng] := OtherFormula.AtNum[i];
                AuxF.AtWgt[AuxF.FLeng] := OtherFormula.AtWgt[i];
                AuxF.AtCnt[AuxF.FLeng] := -OtherFormula.AtCnt[i];
                end;
         end;

       eqfg := true;                 { encode result of comparison }
       f1gtOtherFormula := true;
       OtherFormulagtf1 := true;
       for i:=1 to AuxF.FLeng do
         begin
         if AuxF.AtCnt[i] <> 0 then
           eqfg := false;
         if AuxF.AtCnt[i] < 0 then
           f1gtOtherFormula := false;
         if AuxF.AtCnt[i] > 0 then
           OtherFormulagtf1 := false;
         end;
       reslt := -1;
       if f1gtOtherFormula then
         reslt := 1;
       if OtherFormulagtf1 then
         reslt := 2;
       if eqfg then
         reslt := 0;
       end;
CompareTo := reslt;
end;


(******************************************************************)
procedure TMolForm.Clear;
(******************************************************************)

var
  i   : integer;

begin
FFormulStr := '';
FBFLeng := 0;
for i:=1 to FormMaxEl do
  begin
  FAtNum[i] := 0;
  FAtWgt[i] := 0;
  FAtCnt[i] := 0;
  end;
if FTransparent
  then Invalidate
  else Paint;
end;

(******************************************************************)
procedure TMolForm.ShowIt;
(******************************************************************)

begin
if FTransparent
  then Invalidate
  else Paint;
end;



(******************************************************************)
function TMolForm.ChemMolWgt: double;
(******************************************************************)

var
  mw : double;
  i  : integer;

begin
mw := 0;
for i:=1 to FBFLeng do
  mw := mw + ChemAtWeight(FAtNum[i])*FAtCnt[i];
ChemMolWgt := mw;
end;

(******************************************************************)
function TMolForm.NominalMolWgt: integer;
(******************************************************************)

var
  mw : integer;
  i  : integer;

begin
mw := 0;
for i:=1 to FBFLeng do
  mw := mw + FAtWgt[i]*FAtCnt[i];
NominalMolWgt := mw;
end;

(**********************************************************)
function TMolForm.ChemElem (AtNr, AtWt, AtNum: integer; Format: byte): string;
(**********************************************************
 **********************************************************)
(* returns element symbol and number of atoms as string *)

var
  astr1 : string[10];
  astr2 : string[10];
  astr3 : string[10];

begin
astr1 := '';
astr2 := '';
astr3 := '';
if (AtNr >= 1) and (AtNr <= 103) and (AtNum >= 1) then
  begin
  astr1 := CElemSymb (AtNr);
  if ((AtNr = 1) and (AtWt = 2)) then
    astr1 := 'D';
  if (AtNum > 1) then
    str(AtNum:1,astr2);
  str (AtWt:1, astr3);
  end;
case Format of
  0 : ChemElem := astr1+astr2;
  1 : begin
      ChemElem := astr3+astr1+astr2;
      end;
else ChemElem := astr1+astr2;
end;
end;




(***********************************************************************)
procedure Register;
(***********************************************************************)

begin
RegisterComponents ('SDL', [TMolForm]);
end;


end.



