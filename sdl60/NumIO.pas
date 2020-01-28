unit NumIO;

(******************************************************************)
(*                                                                *)
(*                            N U M I O                           *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1998..2001 H. Lohninger                   July 1998    *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: May-01, 2000                                  *)
(*                                                                *)
(******************************************************************)

{revision history

1.0   [Oct-30, 1998]
      first released (D1..D4, C1, C3)

1.1   [Apr-04, 1999]
      NUMIO is now available for C++Builder 4.0
      Anchors published
      bug fixed which caused zero return value when 'e' of exponent is entered
          but numeric exponent is still missing.
      bug fix: spaces are not accepted anymore
      bug fix: RangeLow=0 and RangeHigh=0 are now handled correctly
          (was caused by a Delphi bug ('stored' keyword does not work properly) )
      bug fix: '-23.' is now handled correctly (another bug in Delphi
          ('val' procedure has bug) )

5.0   [Oct-09, 1999]
      NUMIO now available for Delphi 5.0

5.5   [May-01, 2000]
      available for C++Builder 5.0
      Text property may now contain leading blanks

6.0   [Aug-06, 2001]
      available for Delphi 6.0
}



{-$DEFINE SHAREWARE}
{ if this switch is turned on, the 'hint'-property is set during startup
  in order to indicate an unregistered shareware version  }

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

uses
  WinProcs, WinTypes, Messages, SysUtils, Classes, Graphics, Controls,
  Forms,  Menus, StdCtrls;

type
  TInFormat =(itExp,itFloat,itInt,itHex,itOct,itBin,itDynamic);
  TDecPSep = (dsDot, dsComma, dsBoth);
  TNumIO = class(TCustomEdit)
           private
             FInFormat      : TInFormat;     { type of display as set by user: dec, hex,... }
             OldText        : String;   { caches the input string to handle input errors }
             FBeep          : boolean;                         { beep on illegal inputs? }
             FMinimum       : double;                            { minimum allowed value }
             FMaximum       : double;                            { maximum allowed value }
             FDecPSep       : TDecPSep;
             procedure   SetInputFormat (value: TInFormat);
             procedure   SetRangeLow (value: double);
             procedure   SetRangeHigh (value: double);
             procedure   SetLabValue (x: double);
             function    GetLabValue: double;
             procedure   SetDecPSep (Value: TDecPSep);
           protected
             procedure   AssignTo (Dest: TPersistent); override;
             function    ConvertNumString (Instring: String; var DReslt: double): boolean;
             procedure   Change; override;
           public
             constructor Create (AOwner: TComponent); override;
             destructor  Destroy; override;
             procedure   Assign (Source: TPersistent); override;
             property    Value: double read GetLabValue write SetLabValue;
           published
{$IFNDEF VER110}             // CBuilder 3.0 does not know about anchors
  {$IFNDEF VER100}             // Delphi 3.0 does not know about anchors
             property Anchors;
  {$ENDIF}
{$ENDIF}
             property AutoSelect;
             property AutoSize;
             property Beep: boolean read FBeep write FBeep;
             property BorderStyle;
             property Color;
             property Ctl3D;
             property Cursor;
             property DecPlaceSep: TDecPSep read FDecPSep write SetDecPSep;
             property Enabled;
             property Font;
             property Height;
             property HelpContext;
             property HideSelection;
             property Hint;
             property InputFormat: TInFormat read FInFormat write SetInputFormat;
             property Left;
             property RangeHigh: double read FMaximum write SetRangeHigh stored TRUE;
             property RangeLow: double read FMinimum write SetRangeLow stored TRUE;
             property Name;
             property ParentColor;
             property ParentCtl3D;
             property ParentFont;
             property ParentShowHint;
             property PopupMenu;
             property ShowHint;
             property TabOrder;
             property TabStop;
             property Tag;
             property Text;
             property Top;
             property Visible;
             property Width;
             property OnChange;
             property OnClick;
             property OnDblClick;
             property OnEnter;
             property OnExit;
             property OnKeyDown;
             property OnKeyPress;
             property OnKeyUp;
             property OnMouseDown;
             property OnMouseMove;
             property OnMouseUp;
           end;

procedure Register;


{------------------------------------------------------------------------------}
implementation
{------------------------------------------------------------------------------}

uses
  dialogs;
  
{$IFDEF SHAREWARE}
{$I sharwinc\numio_ct.inc}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}

{$I SCANBIN.INC}
{$I SCANHEX.INC}
{$I SCANOCT.INC}
{$I SCANDEC.INC}
{$I SCANFPN.INC}
{$I strff.inc}
{$I hxoctbin.inc}
{$I ntminmax.inc}


(******************************************************************************)
constructor TNumIO.Create(AOwner:TComponent);
(******************************************************************************)

begin
inherited Create(AOwner);
Parent:=TWinControl(AOwner);
FInFormat:=itDynamic;
Text:='';
OldText:=Text;
FBeep:=FALSE;
                   { The following lines have been included as a work-around for
                     a Delphi bug: Delphi (2.0) does not store a property if its
                     value is zero, even if the 'stored' keyword is specified.
                     This causes troubles if the default value is not zero. }
if csDesigning in ComponentState
  then begin
       FMinimum := -MaxDouble;
       FMaximum := +MaxDouble;
       end
  else begin
       FMinimum := 0;
       FMaximum := 0;
       end;

{$IFDEF SHAREWARE}
Hint:=GetHintStr;
ShowHint:=TRUE;
{$ENDIF}
end;



(******************************************************************************)
destructor TNumIO.Destroy;
(******************************************************************************)

begin
inherited Destroy;                               { Inherit original destructor }
end;


(******************************************************************************)
procedure TNumIO.SetInputFormat (Value: TInFormat);
(* Set "InputFormat" property                                                 *)
(* Value: New value for "InputFormat"                                         *)
(******************************************************************************)

begin
if (Value <> FInFormat) then
  begin
  FInFormat:=Value;
  OldText := '';
  Change;
  end;
end;

(******************************************************************************)
procedure TNumIO.SetRangeLow (value: double);
(******************************************************************************)

begin
if value < FMaximum
  then FMinimum := value
  else begin
       FMinimum := FMaximum;
       FMaximum := value;
       end;
OldText := '';
Change;
end;

(******************************************************************************)
procedure TNumIO.SetRangeHigh (value: double);
(******************************************************************************)

begin
if value > FMinimum
  then FMaximum := value
  else begin
       FMaximum := FMinimum;
       FMinimum := value;
       end;
OldText := '';
Change;
end;


(******************************************************************************)
procedure TNumIO.SetDecPSep (Value:TDecPSep);
(******************************************************************************)

begin
if (Value <> FDecPSep) then
  begin
  FDecPSep := Value;
  OldText := '';
  Change;
  end;
end;


(******************************************************************************)
procedure TNumIO.AssignTo(Dest:TPersistent);
(* Assign a TNumIO object to another TPersistent object                       *)
(* Dest: Object to assign this object to                                      *)
(******************************************************************************)

begin
if (self is Dest.ClassType)
  then Dest.Assign(self)
  else inherited AssignTo(Dest);
end;

(******************************************************************************)
procedure TNumIO.Assign(Source:TPersistent);
(* Assign a TPersistent object to the TNumIO object                           *)
(* Source: Object to get the data from                                        *)
(******************************************************************************)

begin
if (Source is TNumIO)
  then begin
       FInFormat := TNumIO(Source).FInFormat;
       FBeep := TNumIO(Source).FBeep;
       FMinimum := TNumIO(Source).FMinimum;
       FMaximum := TNumIO(Source).FMaximum;
       FDecPSep := TNumIO(Source).FDecPSep;
       end
  else inherited Assign(Source);
end;

(******************************************************************************)
function TNumIO.ConvertNumString (Instring: String; var DReslt: double): boolean;
(******************************************************************************
 ENTRY: Instring ... String to be checked

 EXIT:  DReslt ..... numeric value of string
        function returns TRUE if DReslt is valid
 ******************************************************************************)

var
  reslt          : boolean;
  ix             : integer;
  decp           : integer;
  FCurrentFormat : TInFormat;
  leng           : integer;

begin
DReslt := 0.0;
decp := 3;
case FDecPSep of
  dsDot   : decp := 1;
  dsComma : decp := 2;
end;
if length(Instring) > 0 then
  while (length(Instring) > 0) and (Instring[1] = ' ') do
    delete (Instring, 1, 1);
if pos (' ', Instring) > 0   { no spaces allowed }
  then Reslt := false
  else begin
       Reslt := true;
       Instring := lowercase(Instring);
       FCurrentFormat := FInFormat;
       if length(Instring) > 0 then
         begin
         if FCurrentFormat = itDynamic then
           begin
           case Instring[1] of
             '$' : FCurrentFormat := itHex;
             '&' : FCurrentFormat := itOct;
             '%' : FCurrentFormat := itBin;
           else FCurrentFormat := itExp;
           end;
           end;
         case FCurrentFormat of
              itExp : begin
                      leng := length(Instring);
                      if leng > 0 then
                        begin        { process trailing 'e' without exponent }
                        ix := pos ('e', Instring);
                        if (ix = leng) or ((ix = leng-1) and ((Instring[leng] = '-') or (Instring[leng] = '+'))) then
                          delete (Instring, ix, 255);
                        end;
                      ix := 1;
                      DReslt := ScanFPNum (Instring, true, decp, ix);
                      if ix <> length(Instring)+1 then
                        reslt := false;
                      end;
            itFloat : begin
                      ix := 1;
                      DReslt := ScanFPNum (Instring, false, decp, ix);
                      if ix <> length(Instring)+1 then
                        reslt := false;
                      end;
              itInt : begin
                      ix := 1;
                      DReslt := ScanDecimal (Instring, ix);
                      if ix <> length(Instring)+1 then
                        reslt := false;
                      end;
              itHex : begin
                      if Instring[1] = '$' then
                        delete (Instring,1,1);
                      ix := 1;
                      DReslt := ScanHex (Instring, ix);
                      if ix <> length(Instring)+1 then
                        reslt := false;
                      end;
              itOct : begin
                      if Instring[1] = '&' then
                        delete (Instring,1,1);
                      ix := 1;
                      DReslt := ScanOctal (Instring, ix);
                      if ix <> length(Instring)+1 then
                        reslt := false;
                      end;
              itBin : begin
                      if Instring[1] = '%' then
                        delete (Instring,1,1);
                      ix := 1;
                      DReslt := ScanBin (Instring, ix);
                      if ix <> length(Instring)+1 then
                        reslt := false;
                      end;
         end;
         end;
       end;
ConvertNumString := reslt;
end;


(******************************************************************************)
procedure TNumIO.Change;
(* Check if new input is valid                                                *)
(******************************************************************************)

var
  ss         : integer;
  OK         : boolean;
  CurrentVal : double;

begin
{$IFDEF SHAREWARE}
If not DelphiIsRunning then
  Text := 'component not registered';
{$ENDIF}
OK := ConvertNumString (Text, CurrentVal);
if OK then
  begin
  if (CurrentVal >= FMinimum) and (CurrentVal <= FMaximum)
    then begin
         OldText := Text;
         inherited Change;
         end
    else OK := false;
  end;
if {$IFDEF SHAREWARE} DelphiIsRunning and {$ENDIF} not OK then
  begin
  ss:=SelStart;
  Text:=OldText;
  SelStart:=ss-1;
  Update;
  if (FBeep)
    then MessageBeep(MB_OK);
  end;
end;


(******************************************************************************)
procedure TNumIO.SetLabValue (x: double);
(******************************************************************************)

var
  astr : string;

begin
astr := '';
case FInFormat of
  itDynamic,
       itExp : astr := strff (x, 12, -2);
       itInt : astr := strff (x,1,0);
     itFloat : astr := strff (x,1,8);
       itHex : Hex (round(x),8);
       itOct : Octal (round(x),8);
       itBin : Bin (round(x),8);
end;
Text := astr;
end;


(******************************************************************************)
function TNumIO.GetLabValue: double;
(* Return the numberic representation of the entered text                     *)
(* Result : Value as double                                                   *)
(******************************************************************************)

var
  i    : longint;
  d    : double;
  astr : string;

begin
astr := Text;
i := pos(',',astr);
d := i;
if (i>0) then
  astr[i]:='.';
if (astr<>'') then
  if (astr[length(astr)]='.') then
    astr:=astr+'0';
if not ConvertNumString (astr, d) then
  d := 0;
GetLabValue := d;
end;


(******************************************************************************)
procedure Register;
(******************************************************************************)

begin
RegisterComponents ('SDL', [TNumIO]);
end;


(**************************************************************************)
(*                              INIT                                      *)
(**************************************************************************)

begin
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
end.


