unit ChemGrph;

(******************************************************************)
(*                                                                *)
(*                         C H E M G R P H                        *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1996..2001 H. Lohninger                    July 99     *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Aug-01, 2001                                  *)
(*                                                                *)
(******************************************************************)

{ Release History:

5.0   [Oct-09, 1999]
      ChemGraph made available to the public as part of SDL Comp.Suite 5.0

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      property SuppressPaint implemented
      property DrawUnscaled implemented
      ColorBkg is now clBtnFace by default
}

{$O+}
{$F+}

{-$DEFINE SHAREWARE}
{ if this switch is turned on, the 'hint'-property is set during startup
  in order to indicate an unregistered shareware version }

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

{------------------------------------------------------------------}
interface
{------------------------------------------------------------------}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Menus,
  Graphics, Controls, Forms,  ExtCtrls,
  cstruct;

const
  vaNormal = $00;
  vaBold   = $01;
  vaInvert = $02;
  vaItalic = $04;

type
  TDirection = (diLeft, diTop, diRight, diBottom);
  TFrameStyle = (fsNone, fsSimple, fsLowered, fsRaised, fsEmbossed, fsEngraved);
  TCGDispMode = (dmSkeleton, dmHeteroOnly, dmAllAtoms, dmNumbers);
  TColorScheme = (csBWG, csSystem);
                                        { event for mouse pos. in chart coords }
  TMoveOverStructEvent = procedure (Sender: TObject; ClosestAtom: integer; Dist: double;
                                      Shift: TShiftState;
                                      rMousePosX, rMousePosY: double) of object;

  TChemGraph = class (TGraphicControl)
              private
                FColorBakG    : TColor;
                FMolColor     : TColor;                   { color of structure }
                FColBlackLine : TColor;             { colors to draw the frame }
                FColGrayLine  : TColor;                       { -"- }
                FColWhiteLine : TColor;                       { -"- }
                FColorScheme  : TColorScheme;         { color scheme of frames }
                FTransForm    : array[0..2] of double; { 0 = k, 1 = dx, 2 = dy }
                FMaxBondLeng  : integer; {max. bond length on screen (in pixel)}
                FOnMMvInChart : TMoveOverStructEvent;
                FFrameStyle   : TFrameStyle;
                FClipBounds   : array[diLeft..diBottom] of integer; { clipping boundaries }
                FDispMode     : TCGDispMode;
                FSuppressPaint: boolean;
                FDrawAsIs     : boolean;
                function  ConstructElemSymb (AtIx: integer; var ESymb: string): integer;
                procedure DrawMolRaw (DispMode: TCGDispMode; TrafoK, TrafoDx,
                             TrafoDy: double; Clip: boolean; CV: TCanvas);
                procedure DrawConnections (AtIx: integer; HighOnly: boolean; DisplayMode: TCGDispMode;
                             TrafoK, TrafoDx, TrafoDy: double; Clip: boolean; CV: TCanvas);
                procedure DispElemSymb (AtIx: integer; DispMode: TCGDispMode;
                             TrafoK, TrafoDx, TrafoDy: double; Clip: boolean; CV: TCanvas);
                function  GetClipBoundary (ix: TDirection): integer;
                function  GetAtColor(AtIx: integer): TColor;
                function  GetVisAttrib (AtIx: integer): byte;
                procedure SetClipBoundary (ix: TDirection; ClipVal: integer);
                procedure SetColorBakG (Value: TColor);
                procedure SetColorScheme (Value: TColorScheme);
                procedure SetAtColor (AtIx: integer; value: TColor);
                procedure SetDispMode (value: TCGDispMode);
                procedure SetFrameStyle (value: TFrameStyle);
                procedure SetMaxbondleng (value: integer);
                procedure SetMolColor (value: TColor);
                procedure SetSuppressPaint (supp: boolean);
                procedure SetDrawAsIs (x: boolean);
                procedure SetVisAttrib (AtIx: integer; value: byte);
                procedure ShowMoleculeInABox (DispMode: TCGDispMode;
                              llx,lly,urx,ury: integer; MaxBondLeng: integer);
                procedure StructureHasChanged (Sender: TObject);
                procedure WMMoveOverStruct(var Message: TWMMouse); message WM_MOUSEMOVE;
              protected
                procedure  Paint; override;
                procedure MoveOverStruct (ClosestAtom: integer; Dist: double; Shift: TShiftState;
                                            RMousePosX, RMousePosY: double);
              public
                Structure   : TCtab;                        { connection table }
                constructor Create(AOwner: TComponent); override;
                destructor  Destroy; override;
                property  AtColor[AtIx: integer]: TColor read GetAtColor write SetAtColor;
                property  AtVisAttrib[AtIx: integer]: byte read GetVisAttrib write SetVisAttrib;
                property  ClipBoundary [ix: TDirection]: integer read GetClipBoundary write SetClipBoundary;
                property  DrawUnscaled: boolean read FDrawAsIs write SetDrawAsIs;
                function  FindChainNexttoCursor (x,y: single;
                              var ChainAtoms: AtListType): integer;
                procedure FindRingNextToCursor (x,y: single;
                              var Ring: RingType);
                procedure OptimizeMolShape (IdealDist: integer);
                property  SuppressPaint: boolean read FSuppressPaint write SetSuppressPaint;
              published
                property Align;
                property ColorBkg: TColor read FColorBakg write SetColorBakG;
                property ColorScheme: TColorScheme read FColorScheme write SetColorScheme;
                property ColorStructure: TColor read FMolColor write SetMolColor;
                property DisplayMode: TCGDispMode read FDispMode write SetDispMode;
                property Font;
                property FrameStyle: TFrameStyle read FFrameStyle write SetFrameStyle;
                property MaxBondLeng: integer read FMaxBondLeng write SetMaxBondleng;
                property ParentFont;
                property ParentShowHint;
                property PopupMenu;
                property ShowHint;
                property Visible;
                property OnClick;
                property OnDblClick;
                property OnMouseMove;
                property OnMouseDown;
                property OnMouseUp;
                property OnMoveOverStruct: TMoveOverStructEvent read FOnMMvInChart write FOnMMvInChart;
              end;

procedure Register;


{------------------------------------------------------------------}
implementation
{------------------------------------------------------------------}

uses
  math1, cdata;

{$IFDEF SHAREWARE}
{$I sharwinc\chemgrph_ct.inc}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}


{$IFNDEF VER80}
  {$WARNINGS OFF}
  {$HINTS OFF}
{$ENDIF}

{$I clipline.inc}

(*********************************************************)
constructor TChemGraph.Create (AOwner: TComponent);
(*********************************************************)

begin
inherited Create (AOwner);
FDrawAsIs := false;
FSuppressPaint := true;
Width := 300;
Height := 200;
Canvas.Font.Name := 'Courier New';
Canvas.Font.Size := 14;
Canvas.Font.Style := [];
FColorScheme := csBWG;
FColBlackLine := clBlack;      { note: FColBlackLine is always black at the
                                            moment --> see SetColorScheme }
FTransForm [0] := 1;
FTransForm [1] := 0;
FTransForm [2] := 0;
FColGrayLine  := clGray;
FColWhiteLine := clWhite;
FMolColor := clMaroon;
FColorBakG := clBtnFace;
FClipBounds[diLeft] := 0;
FClipBounds[diTop] := 0;
FClipBounds[diRight] := 800;
FClipBounds[diBottom] := 600;
FFrameStyle := fsRaised;
FMaxBondLeng := 30;
Structure := TCTab.Create;
Structure.OnChange := StructureHasChanged;
FSuppressPaint := false;
{$IFDEF SHAREWARE}
Hint := GetVisMsgStr;
ShowHint := True;
{$ENDIF}
end;


(******************************************************************)
procedure TChemGraph.SetSuppressPaint (supp: boolean);
(******************************************************************)

begin
if FSuppressPaint <> supp then
  begin
  FSuppressPaint := supp;
  if not FSuppressPaint then
    Paint;
  end;
end;

(******************************************************************)
procedure TChemGraph.SetDrawAsIs (x: boolean);
(******************************************************************)

begin
if FDrawAsIs <> x then
  begin
  FDrawAsIs := x;
  Paint;
  end;
end;


(***********************************************************************)
procedure TChemGraph.StructureHasChanged (Sender: TObject);
(***********************************************************************)

begin
Paint;
end;


(*********************************************************)
destructor TChemGraph.Destroy;
(*********************************************************)

begin
Structure.Free;
inherited Destroy;
end;


(******************************************************************)
procedure TChemGraph.MoveOverStruct (ClosestAtom: integer; Dist: double;
               Shift: TShiftState; RMousePosX, RMousePosY: double);
(******************************************************************
  InChart: TRUE if mouse cursor is within chart area
  Shift: state of mouse buttons
  RMousePosX, RMousePosY: real world coordinates of mouse cursor
 ******************************************************************)

begin
if Assigned(FOnMMvInChart) then
  FOnMMvInChart(self, ClosestAtom, Dist, Shift, rMousePosX, rMousePosY);
end;

(******************************************************************)
procedure TChemGraph.WMMoveOverStruct(var Message: TWMMouse);
(******************************************************************)

var
  rx, ry     : double;
  ClosestAtom: integer;
  dist       : double;

begin
inherited;                        { default handling }
with Message do
  begin
  rx := (Xpos-FTransForm[1])/FTransForm[0];
  ry := (YPos-FTransForm[2])/FTransForm[0];
  Structure.FindClosestAtom (rx, ry, 0, ClosestAtom, Dist);
  end;
MoveOverStruct(ClosestAtom, Dist, KeysToShiftState(Message.Keys), rx, ry);
end;



(***********************************************************************)
procedure TChemGraph.SetColorScheme (Value: TColorScheme);
(***********************************************************************)

begin
if Value <> FColorScheme then
  begin
  FColorScheme := Value;
  if FColorScheme = csBWG
    then begin
{        FColBlackLine := clBlack;  prepared for future extension }
         FColGrayLine  := clGray;
         FColWhiteLine := clWhite;
         end
    else begin
{        FColBlackLine := clBlack;  prepared for future extension }
         FColGrayLine  := clBtnShadow;
         FColWhiteLine := clBtnHighLight;
         end;
  Paint;
  end;
end;


(*********************************************************)
procedure TChemGraph.SetAtColor (AtIx: integer; value: TColor);
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    Atribute byte of this atom
 *********************************************************)

var
  ElemRec : CTElem;

begin
if ((AtIx > 0) and (AtIx <= Structure.NAtoms)) then
  begin
  ElemRec := Structure.AtomEntries[AtIx];
  ElemRec.AtDispAtb := (ElemRec.AtDispAtb and $70000000) + (value and $03FFFFFF);
  Structure.AtomEntries[AtIx] := ElemRec;
  Paint;
  end;
end;



(*********************************************************)
function TChemGraph.GetAtColor (AtIx: integer): TColor;
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    color of this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= Structure.NAtoms))
  then GetAtColor := Structure.AtomEntries[AtIx].AtDispAtb and $03FFFFFF
  else GetAtColor := 0;
end;


(*********************************************************)
procedure TChemGraph.SetVisAttrib (AtIx: integer; value: byte);
(*********************************************************
  ENTRY:   AtIx ... number of atom
           value .. visual attribute of this atom
 *********************************************************)

var
  ElemRec : CTElem;

begin
if ((AtIx > 0) and (AtIx <= Structure.NAtoms)) then
  begin
  ElemRec := Structure.AtomEntries[AtIx];
  ElemRec.AtDispAtb := (ElemRec.AtDispAtb and $8FFFFFFF) or (value shl 28);
  Structure.AtomEntries[AtIx] := ElemRec;
  Paint;
  end;
end;


(*********************************************************)
function TChemGraph.GetVisAttrib (AtIx: integer): byte;
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    visual attribute of this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= Structure.NAtoms))
  then GetVisAttrib := (Structure.AtomEntries[AtIx].AtDispAtb and $70000000) shr 28
  else GetVisAttrib := 0;
end;



(**************************************************************)
procedure TChemGraph.Paint;
(**************************************************************)

const
  NOSTRCTMSG = 'no structure loaded';
  Rim = 8;

var
  AuxStr     : string;
  twAux      : integer;
  LabRect    : TRect;
  AuxInt     : integer;
  GrafBmp    : TBitMap;
  i          : integer;
  mllx, mlly : double;
  murx, mury : double;
  centx,
  centy      : double;
  avgBl      : double;
  fs         : integer;
  tw, th     : integer;
  f1, f2     : double;
  dx, dy     : double;
  llx,lly,
  urx,ury    : integer;
{$IFDEF SHAREWARE}
  astr       : string;
  j          : integer;
{$ENDIF}

begin
if not FSuppressPaint then
  begin
  if Visible or (csDesigning in ComponentState) then
    begin
    Canvas.Font := Font;
    GrafBmp := TBitMap.Create;      { create working bitmap for flickerfree }
    GrafBmp.Width := Width;          { display and set its width and height }
    GrafBmp.Height := Height;
    with GrafBmp do
      begin
      Canvas.Font := Font;
      Canvas.Brush.Color := FColorBakG;
      Canvas.Pen.Color := FColorBakG;
      Canvas.Rectangle (0, 0, Width, Height);        { background of structure }

      Canvas.Brush.Color := FColorBakG;
      Canvas.Font.Color := FMolColor;

      if FFrameStyle = fsNone
        then Canvas.Pen.Color := FColorBakG
        else begin
             if FFrameStyle = fsEmbossed
               then Canvas.Pen.Color := FColWhiteLine
               else Canvas.Pen.Color := FColGrayLine;
             end;

      Canvas.Brush.Color := FColorBakG;         { label background color }
      if ((FFrameStyle = fsNone) or (FFrameStyle = fsSimple))
        then begin
             Canvas.Rectangle (0, 0, Width, height);
             end
        else begin
             Canvas.Rectangle (0, 0, Width-1, height-1);
             Canvas.Pen.Color := FColWhiteLine;
             case FFrameStyle of
               fsRaised : begin
                          Canvas.Pen.Color := FColWhiteLine;
                          Canvas.MoveTo (1, Height-3);
                          Canvas.LineTo (1, 1);
                          Canvas.LineTo (Width-2, 1);
                          Canvas.Pen.Color := FColBlackLine;
                          Canvas.MoveTo (1, Height-1);
                          Canvas.LineTo (Width-1, Height-1);
                          Canvas.LineTo (Width-1, 0);
                          end;
              fsLowered : begin
                          Canvas.Pen.Color := FColBlackLine;
                          Canvas.MoveTo (1, Height-3);
                          Canvas.LineTo (1, 1);
                          Canvas.LineTo (Width-2, 1);
                          Canvas.Pen.Color := FColWhiteLine;
                          Canvas.MoveTo (1, Height-1);
                          Canvas.LineTo (Width-1, Height-1);
                          Canvas.LineTo (Width-1, 0);
                          end;
             fsEngraved : begin
                          Canvas.Pen.Color := FColWhiteLine;
                          Canvas.MoveTo (1, height-3);
                          Canvas.LineTo (1, 1);
                          Canvas.LineTo (Width-2, 1);
                          Canvas.MoveTo (1, Height-1);
                          Canvas.LineTo (Width-1, Height-1);
                          Canvas.LineTo (Width-1, 0);
                          end;
             fsEmbossed : begin
                          Canvas.Pen.Color := FColGrayLine;
                          Canvas.MoveTo (1, Height-3);
                          Canvas.LineTo (1, 1);
                          Canvas.LineTo (Width-2, 1);
                          Canvas.MoveTo (1, Height-1);
                          Canvas.LineTo (Width-1, Height-1);
                          Canvas.LineTo (Width-1, 0);
                          end;
             end;
             end;


  //    if not FEmpty then                                             { structure }
        begin
        if Structure.NAtoms = 0
          then begin
               tw := Canvas.TextWidth (NOSTRCTMSG);
               th := Canvas.TextHeight (NOSTRCTMSG);
               Canvas.TextOut ({0}+2+(Width-tw) div 2, (Height-th) div 2, NOSTRCTMSG);
               end
          else begin
               if FDrawAsIs
                 then DrawMolRaw (FDispMode, 1.0, 0, 0, false, GrafBmp.Canvas)
                 else begin
                      AvgBL := Structure.CalcMolExtents (mllx,mlly,murx,mury,centx,Centy);
                      Centx := (mllx+murx)/2;
                      Centy := (mlly+mury)/2;
                      llx := rim;
                      urx := width-rim;
                      lly := rim;
                      ury := height-rim;
                      if murx = mllx
                        then f1 := urx-llx
                        else f1 := (urx-llx)/(murx-mllx);
                      if mury = mlly
                        then f2 := ury-lly
                        else f2 := (ury-lly)/(mury-mlly);
                      if f1 > f2 then
                        f1 := f2;
                      if FMaxBondLeng > 0 then
                        begin
                        if AvgBL > 0
                          then f2 := FMaxBondLeng/AvgBL
                          else f2 := FMaxBondLeng;
                        if f2 < f1 then
                          f1 := f2;
                        end;
                      dx:= (urx+llx) div 2 - f1*centx;
                      dy:= (ury+lly) div 2 - f1*centy;
                      fs := 4+round(AvgBl/5*f1);   { calc. font size }
                      if fs < 8 then
                        fs := 8;
                      if fs > 20 then
                        fs := 20;
                      Canvas.Font.Size := fs;
                      DrawMolRaw (FDispMode, f1, dx, dy, false, GrafBmp.Canvas);
                      end;
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
    Canvas.Draw (0,0,GrafBmp);
    GrafBmp.Free;                             { destroy the graphics bitmap }
    end;
  end;
end;

(***********************************************************************)
procedure TChemGraph.SetFrameStyle (value: TFrameStyle);
(***********************************************************************)

begin
if Value <> FFrameStyle then
  begin
  FFrameStyle := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TChemGraph.SetMaxbondleng (value: integer);
(***********************************************************************)

begin
if Value <> FMaxBondLeng then
  begin
  FMaxBondLeng := Value;
  Paint;
  end;
end;

(***********************************************************************)
procedure TChemGraph.SetDispMode (value: TCGDispMode);
(***********************************************************************)

begin
if Value <> FDispMode then
  begin
  FDispMode := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TChemGraph.SetMolColor (value: TColor);
(***********************************************************************)

begin
if Value <> FMolColor then
  begin
  FMolColor := Value;
  Paint;
  end;
end;


(***********************************************************************)
procedure TChemGraph.SetColorBakG (Value: TColor);
(***********************************************************************)

begin
if Value <> FColorBakG then
  begin
  FColorBakG := Value;
  Paint;
  end;
end;




(*********************************************************)
procedure TChemGraph.FindRingNexttoCursor (x,y: single;
                                     var Ring: RingType);
(*********************************************************
  ENTRY:   Ctab ... connection table
           x,y .... coordinates of cursor
  EXIT:    Searches smallest ring(s) which hold(s) the atom next
           to the cursor point. Function returns the ring found.
 *********************************************************)

const
  Fleng = 6; (* max. length of sorted array *)

var
  i, j, at   : integer;
  ix         : integer;
  MinDist    : double;
  DistNear   : array[1..FLeng] of double;
  NearAtoms  : array[1..FLeng] of integer;
  ShortList  : RingListType;
  LongList   : RingListType;
  h, sum     : double;

begin
for i := 1 to FLeng do
  begin
  DistNear [i] := 2000000000;
  NearAtoms [i] := 0;
  end;
for i:=1 to Structure.NAtoms do    (* search nearest atom *)
  begin
  MinDist := Structure.AtomEntries[i].Coords[1] - x;
  h := Structure.AtomEntries[i].Coords[2] - y;
  MinDist := sqr(MinDist) + sqr(h);
  ix := SortIntoArray (@DistNear,FLeng,lnum,@MinDist,TRUE,TRUE);
  if ix > 0 then
    InsertIntoArray (@NearAtoms,FLeng,inum,@i,ix);
  end;
LongList.NrOfRings := 0;
if Structure.FindShortestRings (NearAtoms[1], ShortList) > 1
  then begin                     (* if atom is not unique to one ring *)
       for i:=1 to FLeng do      (*-- accumulate all rings of the found atoms *)
         begin
         ix := Structure.FindShortestRings (NearAtoms[i], ShortList);
         for j:=1 to ix do
           begin
           if not RingInRingList (ShortList.RList[j],LongList) then
             begin
             inc (LongList.NrOfRings);
             LongList.RList[LongList.NrOfRings] := ShortList.RList[j];
             end;
           end;
         end;
           (* find the one ring which has the smallest distance to the cursor *)

       MinDist := 2000000000;
       ix := 0;
       for i:=1 to LongList.NrOfRings do
         begin
         sum := 0;
         for j:=1 to LongList.RList[i].RingSize do
           begin
           at := LongList.RList[i].Atlist[j];
           sum := sum + abs(Structure.AtomEntries[at].Coords[1]-x) + abs(Structure.AtomEntries[at].Coords[2]-y);
           end;
         if sum < MinDist then
           begin
           MinDist := sum;
           ix := i;
           end;
         end;
       Ring := LongList.RList[ix];
       end
  else begin     (* atom is unique or not a ring atom at all*)
       if Shortlist.NrOfRings = 0
         then Ring.RingSize := 0
         else Ring := ShortList.RList[1];
       end;

end;



(**************************************************************)
function TChemGraph.ConstructElemSymb (AtIx: integer;
                           var ESymb: string): integer;
(**************************************************************)

var
  HAtoms  : string;
  SumCOnn : integer;
  j       : integer;
  ccc     : integer;

begin
HAtoms := '';
ccc := Structure.AtCharge[AtIx];
sumConn := 10*ccc;
for j:=1 to Structure.NBonds[AtIx] do
  sumConn := SumConn + Structure.AtTypConn[AtIx,j];
case Structure.AtNum[AtIx] of
  8,16 : begin                (* oxygen, sulphur *)
         case SumConn of
          -9   : HAtoms := '-';
          -8   : HAtoms := '-';
           1   : HAtoms := 'H';
           2   : HAtoms := '';
          11   : HAtoms := 'H2+';
          12   : HAtoms := 'H+';
         end;
         end;
  7,15 : begin                (* nitrogen, phosphorus *)
         case SumConn of
           0   : HAtoms := 'H3';
           1   : HAtoms := 'H2';
           2   : HAtoms := 'H';
           3   : HAtoms := '';
          10   : HAtoms := 'H4+';
          11   : HAtoms := 'H3+';
          12   : HAtoms := 'H2+';
          13   : HAtoms := 'H+';
          14   : HAtoms := '+';
          -9   : HAtoms := 'H-';
          -8   : HAtoms := '-';
          -7   : HAtoms := '-';
         end;
         end;
    else begin                    (* F, Cl, Br, I *)
         case ccc of
          -1   : HAtoms := '-';
           0   : HAtoms := '';
           1   : HAtoms := '+';
         end;
         end;
end;
ESymb := CElemSymb(Structure.AtNum[AtIx]) + HAtoms;
ConstructElemSymb := length (ESymb);
end;


(**************************************************************)
procedure TChemGraph.DrawConnections
            (AtIx: integer; HighOnly: boolean; DisplayMode: TCGDispMode;
             TrafoK, TrafoDx, TrafoDy: double; Clip: boolean;
             CV: TCanvas);
(**************************************************************)

var
  i,c            : integer;
  Space1, Space2 : integer;
  hstr           : string;
  deltax         : integer;  (* determines free room for atom symbol *)
  deltay         : integer;


procedure DrawCType (CAt1X, CAt1Y, CAt2X, CAt2Y: longint;
                     BondType: integer;
                     Space1, Space2: integer; Clip: boolean);
(*---------------------------------------------------------*)

const
  MultiBondDist = 3;        { distance between multiple bond lines }

var
  dx, dy   : longint;
  dummy    : longint;
  BLeng    : single;
  dx1, dy1 : longint;
  dx2, dy2 : longint;

begin
if (Cat2X-Cat1X <> 0) or (Cat2Y-Cat1Y <> 0) then
  begin
  dx1 := Space1 * deltax;
  if Space1 = 0
    then dy1 := 0
    else dy1 := deltay;
  dx2 := Space2 * deltax;
  if Space2 = 0
    then dy2 := 0
    else dy2 := deltay;
  ClipLineEndPointBox (Cat1X, Cat1Y, Cat2X, Cat2Y, dx1, dy1, dx2, dy2);
  end;
if Clip then   (* clip molecule ? *)
  begin
  if CAt1X >= FClipBounds[diRight]-4 then CAt1X := FClipBounds[diRight]-4;
  if CAt2X >= FClipBounds[diRight]-4 then CAt2X := FClipBounds[diRight]-4;
  if CAt1Y >= FClipBounds[diBottom]-4 then CAt1Y := FClipBounds[diBottom]-4;
  if CAt2Y >= FClipBounds[diBottom]-4 then CAt2Y := FClipBounds[diBottom]-4;
  if CAt1X <= FClipBounds[diLeft]+4 then CAt1X := FClipBounds[diLeft]+4;
  if CAt2X <= FClipBounds[diLeft]+4 then CAt2X := FClipBounds[diLeft]+4;
  if CAt1Y <= FClipBounds[diTop]+4 then CAt1Y := FClipBounds[diTop]+4;
  if CAt2Y <= FClipBounds[diTop]+4 then CAt2Y := FClipBounds[diTop]+4;
  end;
case BondType of
   1 : begin
       CV.MoveTo (CAt1X, CAt1Y);             (* single bond *)
       CV.LineTo (CAt2X, CAt2Y);
       end;
   2 : begin                                 (* double bond *)
       dx := Cat2X - Cat1X;
       dy := Cat2Y - Cat1Y;
       if dx*dy >= 0
         then dx := -dx
         else dy := -dy;
       BLeng := sqrt(dx*dx+dy*dy);
       if BLeng = 0
         then begin
              dummy := 0;
              dy := 0;
              end
         else begin
              dummy := round (0.55*MultiBondDist*dy/BLeng);
              dy := round (0.55*MultiBondDist*dx/BLeng);
              end;
       dx := dummy;
       CV.MoveTo (CAt1X+dx, CAt1Y+dy);
       CV.LineTo (CAt2X+dx, CAt2Y+dy);
       CV.MoveTo (CAt1X-dx, CAt1Y-dy);
       CV.LineTo (CAt2X-dx, CAt2Y-dy);
       end;
   3 : begin                                 (* tripple bond *)
       dx := Cat2X - Cat1X;
       dy := Cat2Y - Cat1Y;
       if dx*dy >= 0
         then dx := -dx
         else dy := -dy;
       BLeng := sqrt(dx*dx+dy*dy);
       if BLeng = 0
         then begin
              dummy := 0;
              dy := 0;
              end
         else begin
              dummy := round (MultiBondDist*dy/BLeng);
              dy := round (MultiBondDist*dx/BLeng);
              end;
       dx := dummy;
       CV.MoveTo (CAt1X, CAt1Y);
       CV.LineTo (CAt2X, CAt2Y);
       CV.MoveTo (CAt1X+dx, CAt1Y+dy);
       CV.LineTo (CAt2X+dx, CAt2Y+dy);
       CV.MOveTo (CAt1X-dx, CAt1Y-dy);
       CV.LineTo (CAt2X-dx, CAt2Y-dy);
       end;
   4 : begin                                 (* aromatic bond *)
       CV.Pen.Width := 1;
       CV.Pen.Style := psDash;
       CV.Moveto (CAt1X, CAt1Y);
       CV.LineTo (CAt2X, CAt2Y);
       CV.Pen.Style := psSolid;
       CV.Pen.Width := 1;
       end;
  end;
end;



begin
DeltaX := 1 + CV.Font.Size div 2;
DeltaY := 1 + CV.Font.Size div 2;
for i:=1 to MaxConn do
  begin
  c := Structure.AtConnTo[AtIx,i];
  if c <> 0 then
    begin
    case DisplayMode of
      dmSkeleton : begin
                   if Structure.AtCharge[AtIx] <> 0
                     then Space1 := ConstructElemSymb (AtIx, hstr)
                     else Space1 := 0;
                   if Structure.AtCharge[c] <> 0
                     then Space2 := ConstructElemSymb (c, hstr)
                     else Space2 := 0;
                   end;
    dmHeteroOnly : begin
                   if (Structure.AtNum[AtIx] <> 6) or (Structure.AtCharge[AtIx] <> 0)
                     then Space1 := ConstructElemSymb (AtIx, hstr)
                     else Space1 := 0;
                   if (Structure.AtNum[c] <> 6) or (Structure.AtCharge[c] <> 0)
                     then Space2 := ConstructElemSymb (c, hstr)
                     else Space2 := 0;
                   end;
    dmAllAtoms   : begin
                   Space1 := ConstructElemSymb (AtIx, hstr);
                   Space2 := ConstructElemSymb (c, hstr);
                   end;
    dmNumbers    : begin
                   if AtIx > 9
                     then Space1 := 2
                     else Space1 := 1;
                   if c > 9
                     then Space2 := 2
                     else Space2 := 1;
                   end;
    end;
    if not HighOnly
      then DrawCType (round(TrafoK*Structure.AtCoords[AtIx,1]+TrafoDx),
                      round(TrafoK*Structure.AtCoords[AtIx,2]+TrafoDy),
                      round(TrafoK*Structure.AtCoords[c,1]+TrafoDx),
                      round(TrafoK*Structure.AtCoords[c,2]+TrafoDy),
                      Structure.AtTypConn[AtIx,i],
                      Space1,Space2,Clip)
      else if c > AtIx then
             DrawCType (round(TrafoK*Structure.AtCoords[AtIx,1]+TrafoDx),
                       round(TrafoK*Structure.AtCoords[AtIx,2]+TrafoDy),
                       round(TrafoK*Structure.AtCoords[c,1]+TrafoDx),
                       round(TrafoK*Structure.AtCoords[c,2]+TrafoDy),
                       Structure.AtTypConn[AtIx,i],
                       Space1,Space2,Clip);
    end;
  end;
end;


(**************************************************************)
procedure TChemGraph.DispElemSymb (AtIx: integer; DispMode: TCGDispMode;
          TrafoK, TrafoDx, TrafoDy: double; Clip: boolean; CV: TCanvas);
(**************************************************************)

var
  hstr     : string;
  SHowIt   : boolean;
  xc, yc   : integer;
  th, tw   : integer;

begin
xc := round(TrafoK*Structure.AtCoords[AtIx,1]+TrafoDx);
yc := round(TrafoK*Structure.AtCoords[AtIx,2]+TrafoDy);
ShowIt := True;
if Clip then
  begin
  if xc >= FClipBounds[diRight]-40 then ShowIt := False;
  if xc <= FClipBounds[diLeft]+40 then ShowIt := False;
  if yc >= FClipBounds[diBottom]-40 then ShowIt := False;
  if yc <= FClipBounds[diTop]+40 then ShowIt := False;
  end;
if SHowIt then
  begin
  ConstructElemSymb (AtIx, hstr);
  if DispMode = dmNumbers then
    str(AtIx:1,hstr);
  th := CV.TextHeight (hstr) div 2;
  tw := CV.TextWidth (hstr) div 2;
  if (Structure.AtomEntries[AtIx].AtDispAtb and $80000000) = 0
    then CV.Font.Color := Structure.AtomEntries[AtIx].AtDispAtb and $03FFFFFF
    else CV.Font.Color := FMolColor;
  if (Structure.AtomEntries[AtIx].AtDispAtb and $10000000) = 0
    then CV.Font.Style := []
    else CV.Font.Style := [fsBold];
  if (Structure.AtomEntries[AtIx].AtDispAtb and $40000000) = 0
    then CV.Font.Style := CV.Font.Style - [fsItalic]
    else CV.Font.Style := CV.Font.Style + [fsItalic];
  if (Structure.AtomEntries[AtIx].AtDispAtb and $20000000) <> 0
    then begin
         CV.Brush.Color := CV.Font.Color;
         CV.Font.Color := FColorBakg;
         CV.Brush.Style := bsSolid;
         end
    else begin
         CV.Brush.Style := bsClear;
         end;
  case DispMode of
        dmSkeleton : begin
                     end;
      dmHeteroOnly : if Structure.AtNum[AtIx] <> 6 then
                     CV.TextOut (xc-tw,yc-th, hstr);
      dmAllAtoms   : CV.TextOut (xc-tw,yc-th, hstr);
      dmNumbers    : CV.TextOut (xc-tw,yc-th, hstr);
  end;
  end;
end;


(**************************************************************)
procedure TChemGraph.DrawMolRaw (DispMode: TCGDispMode;
                TrafoK, TrafoDx, TrafoDy: double; Clip: boolean;
                CV: TCanvas);
(**************************************************************)

var
  i       : integer;
  bsBAK   : TBrushStyle;
  pcBAK   : TColor;
  fcBAK   : TColor;
  bcBAK   : TColor;
  pmBAK   : TPenMode;

begin
FTransForm [0] := TrafoK;
FTransForm [1] := TrafoDx;
FTransForm [2] := TrafoDy;
bsBAK := Canvas.Brush.Style;
pcBAK := Canvas.Pen.Color;
bcBAK := Canvas.Brush.Color;
fcBAK := Canvas.Font.Color;
pmBAK := Canvas.Pen.Mode;
CV.Pen.Color := FMolColor;
CV.Pen.Mode := pmCopy;
CV.Brush.Style := bsClear;
CV.Font.Color := FMolColor;
case DispMode of
  dmSkeleton : begin
               for i:=1 to Structure.NAtoms do
                 if (Structure.NBonds[i] = 0) or (Structure.AtCharge[i] <> 0)
                   then DrawConnections (i,true,dmHeteroOnly,TrafoK,TrafoDx,TrafoDy,Clip,CV)
                   else DrawConnections (i,true,DispMode,TrafoK,TrafoDx,TrafoDy,Clip,CV);
               for i:=1 to Structure.NAtoms do
                 if (Structure.NBonds[i] = 0) or (Structure.AtCharge[i] <> 0) then
                   DispElemSymb (i,dmAllAtoms,TrafoK,TrafoDx,TrafoDy,Clip,CV);
               end;
 dmHeteroOnly: begin
               for i:=1 to Structure.NAtoms do
                 DrawConnections (i,true,DispMode,TrafoK,TrafoDx,TrafoDy,Clip,CV);
               for i:=1 to Structure.NAtoms do
                 if (Structure.AtNum[i] <> 6) or (Structure.NBonds[i] = 0) or (Structure.AtCharge[i] <> 0) then
                   DispElemSymb(i,dmAllAtoms,TrafoK,TrafoDx,TrafoDy,Clip,CV);
               end;
  dmAllAtoms,
  dmNumbers  : begin
               for i:=1 to Structure.NAtoms do
                 DrawConnections (i,true,DispMode,TrafoK,TrafoDx,TrafoDy,Clip,CV);
               for i:=1 to Structure.NAtoms do
                 DispElemSymb (i,DispMode,TrafoK,TrafoDx,TrafoDy,Clip,CV);
               end;
end;
CV.Brush.Style := bsBAK;
CV.Pen.Color := pcBAK;
CV.Brush.Color := bcBAK;
CV.Font.Color := fcBAK;
CV.Pen.Mode := pmBAK;
end;


(**************************************************************)
procedure TChemGraph.SHowMoleculeInABox (DispMode: TCGDispMode;
           llx,lly,urx,ury: integer; MaxBondLeng: integer);
(**************************************************************)

var
  mllx, mlly : double;
  murx, mury : double;
  centx,
  centy      : double;
  f1, f2     : double;
  dx, dy     : double;
  avgBl      : double;
  fs         : integer;

begin
AvgBL := Structure.CalcMolExtents (mllx,mlly,murx,mury,centx,Centy);
Centx := (mllx+murx)/2;
Centy := (mlly+mury)/2;
if murx = mllx
  then f1 := urx-llx
  else f1 := (urx-llx)/(murx-mllx);
if mury = mlly
  then f2 := ury-lly
  else f2 := (ury-lly)/(mury-mlly);
if f1 > f2 then
  f1 := f2;
if MaxBondLeng > 0 then
  begin
  if AvgBL > 0
    then f2 := MaxBondLeng/AvgBL
    else f2 := MaxBondLeng;
  if f2 < f1 then
    f1 := f2;
  end;
dx:= (urx+llx) div 2 - f1*centx;
dy:= (ury+lly) div 2 - f1*centy;
fs := 4+round(AvgBl/5*f1);   { calc. font size }
if fs < 8 then
  fs := 8;
if fs > 20 then
  fs := 20;
Canvas.Font.Name := 'Courier New';
Canvas.Font.Size := fs;
DrawMolRaw (DispMode, f1, dx, dy, false, canvas);
end;

(**************************************************************)
procedure TChemGraph.SetClipBoundary (ix: TDirection; ClipVal: integer);
(**************************************************************
  ENTRY:   ix      : index into clipping boundaries
           ClipVal : value to set
 **************************************************************)

begin
FClipBounds[ix] := ClipVal;
end;

(**************************************************************)
function TChemGraph.GetClipBoundary (ix: TDirection): integer;
(**************************************************************
  ENTRY:   ix      : index into clipping boundaries
 **************************************************************)

begin
GetClipBoundary := FClipBounds[ix];
end;


(*********************************************************)
function TChemGraph.FindChainNextToCursor (x,y: single;
                   var ChainAtoms: AtListType): integer;
(*********************************************************
  ENTRY:   Ctab ... connection table
           x,y .... coordinates of cursor
  EXIT:    Searches straight chain which holds the atom next
           to the cursor point. Function returns the size of
           the found chain and the list of associated chain
           atoms. The atom numbers in list ChainAtoms is
           ordered from left atoms to right atoms.
 *********************************************************)

var
  i, j       : integer;
  DistAtI    : double;
  DistNear   : double;
  NearestAtom: integer;
  h          : double;
  LeftEnd    : integer;
  RightEnd   : integer;
  Dummy      : integer;
  TabPoi     : integer;

procedure FindNextAtomUNtilEnd (var ThisATom: integer;
              LastAtom: integer; Reverse: boolean);
(*-------------------------------------------------------*)


begin
repeat
  if Structure.AtomEntries[ThisAtom].Connto[1] <> LastATom
    then begin
         ChainAtoms.AtList[TabPoi] := ThisAtom;
         if Reverse
           then dec (TabPoi)
           else inc (TabPoi);
         LastAtom := ThisAtom;
         ThisAtom := Structure.AtomEntries[ThisAtom].Connto[1];
         end
    else begin
         ChainAtoms.AtList[TabPoi] := ThisAtom;
         if Reverse
           then dec (TabPoi)
           else inc (TabPoi);
         LastAtom := ThisAtom;
         ThisAtom := Structure.AtomEntries[ThisAtom].Connto[2];
         end;
until (Structure.NBonds[LastAtom] <> 2);
ThisAtom := LastATom;
end;

begin
DistNear := MaxDouble;
for i:=1 to Structure.NAtoms do         (* search nearest atom *)
  if Structure.NBonds[i] <= 2 then        (* take only atoms of chain *)
    begin
    DistAtI := Structure.AtomEntries[i].Coords[1] - x;
    h := Structure.AtomEntries[i].Coords[2] - y;
    DistAtI := sqr(DistAtI) + sqr(h);
    if DistAti < DistNear then
      begin
      DistNear := DistAti;
      NearestAtom := i;
      end;
    end;
LeftEnd := Structure.AtomEntries[NearestAtom].Connto[1];
RightEnd := Structure.AtomEntries[NearestAtom].Connto[2];
TabPoi := MaxLengCTab;
ChainAtoms.AtList[TabPoi] := NearestATom;
dec (TabPoi);
if LeftEnd = 0
  then LeftEnd := NearestAtom
  else FindNExtAtomUntilEnd (LeftEnd, NearestATom, True);
j := 1;
for i:=TabPoi+1 to MaxLengCTab do
  begin
  ChainAtoms.AtList[j] := ChainAtoms.AtList[i];
  inc (j);
  end;
TabPoi := MaxLengCTab - TabPoi + 1;
if RightEnd = 0
  then RightEnd := NearestAtom
  else FindNExtAtomUntilEnd (RightEnd, NearestATom, false);
if Structure.AtomEntries[LeftEnd].Coords[1] >
   Structure.AtomEntries[RightEnd].Coords[1] then
  begin
  Dummy := LeftEnd;
  LeftEnd := RightEnd;
  RightEnd := Dummy;
  for i:=1 to ((TabPoi-1) div 2) do
    begin
    dummy := ChainAtoms.AtList[i];
    ChainAtoms.AtList[i] := ChainAtoms.AtList[TabPoi-i];
    ChainAtoms.AtList[TabPoi-i] := dummy;
    end;
  end;
ChainAtoms.NrAtoms := TabPoi-1;
FindChainNextToCursor := TabPoi-1;
end;




(*********************************************************************)
procedure TChemGraph.OptimizeMolShape (IdealDist: integer);
(*********************************************************************)

const
  NStep = 100;

var
  OldFit, F  : double;
  ix         : integer;
  dx, dy     : double;
  i          : integer;
  CTabBak    : TCTab;


function Fitness: double;
(*---------------------*)

var
  d, dist : double;
  i,j,k   : integer;

begin
d := 0;
for i:=1 to Structure.Natoms do
  for j:=i+1 to Structure.Natoms do
    begin
    dist := sqrt(sqr(Structure.AtCoords[i,1]-Structure.AtCoords[j,1])+
                 sqr(Structure.AtCoords[i,2]-Structure.AtCoords[j,2])+
                 sqr(Structure.AtCoords[i,3]-Structure.AtCoords[j,3]));
    if Structure.Checkconnect (i,j) = 0
      then d := d + dist  { overall distance between atoms not connected directly }
      else begin
           d := d - 0.5*sqr(dist-idealDist); { bond length }
           for k:=1 to Structure.NBonds[i] do    { angle between two bonds = 120 deg }
             if Structure.AtConnTo[i,k] <> j then
               begin
               dist := sqrt(sqr(Structure.AtCoords[j,1]-Structure.AtCoords[Structure.AtConnTo[i,k],1])+
                            sqr(Structure.AtCoords[j,2]-Structure.AtCoords[Structure.AtConnTo[i,k],2])+
                            sqr(Structure.AtCoords[j,3]-Structure.AtCoords[Structure.AtConnTo[i,k],3]));
               d := d - 0.5*sqr(dist-1.732*idealDist);
               end;
           for k:=1 to Structure.NBonds[j] do
             if Structure.AtConnTo[j,k] <> i then
               begin
               dist := sqrt(sqr(Structure.AtCoords[i,1]-Structure.AtCoords[Structure.AtConnTo[j,k],1])+
                            sqr(Structure.AtCoords[i,2]-Structure.AtCoords[Structure.AtConnTo[j,k],2])+
                            sqr(Structure.AtCoords[i,3]-Structure.AtCoords[Structure.AtConnTo[j,k],3]));
               d := d - 0.5*sqr(dist-1.732*idealDist);
               end;
           end;

    end;
Fitness := d;
end;


begin
CTabBak := TCTab.create;
CTabBak.CopyFrom (Structure);
OldFit := Fitness;
for i:=1 to NStep*Structure.NAtoms do
  begin
  ix := 1+random(Structure.Natoms);
  dx := (NStep-i+10)/Nstep*(random(2*IdealDist) - IdealDist);
  dy := (NStep-i+10)/Nstep*(random(2*IdealDist) - IdealDist);
  Structure.AtCoords[ix,1] := Structure.AtCoords[ix,1] + dx;
  Structure.AtCoords[ix,2] := Structure.AtCoords[ix,2] + dy;
  if i mod 2 = 0 then    { change two atom positions every second time }
    begin
    ix := 1+random(Structure.Natoms);
    dx := (NStep-i+10)/Nstep*(random(2*IdealDist) - IdealDist);
    dy := (NStep-i+10)/Nstep*(random(2*IdealDist) - IdealDist);
    Structure.AtCoords[ix,1] := Structure.AtCoords[ix,1] + dx;
    Structure.AtCoords[ix,2] := Structure.AtCoords[ix,2] + dy;
    end;
  F := Fitness;
  if F < OldFit
    then begin
         Structure.CopyFrom (CTabBak);
         end
    else begin
         Oldfit := F;
         CTabBak.CopyFrom (Structure);
         end;
  end;
CTabBak.Free;
end;



(***********************************************************************)
procedure Register;
(***********************************************************************)

begin
RegisterComponents ('SDL', [TChemGraph]);
end;



end.


