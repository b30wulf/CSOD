unit Colsel;

(******************************************************************)
(*                                                                *)
(*                           C O L S E L                          *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1998..2001 H. Lohninger                 August  1996   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Oct-09, 1999                                  *)
(*                                                                *)
(******************************************************************)

{
Release notes:

1.00  [Aug-10,1996]
      first version released

1.01  [Feb-12, 1997]
      user defined color which does not match predfined colors is
      now indicated as "user defined"

1.5   [May-28, 1998]
      ColSel is now available for C++Builder 1.0

1.6   [Apr-08, 1998]
      primary (EGA) system colors are now displayed instead of
        Windows colors, if several color identifiers can be mapped
        to a selected color.
      ColSel is now available for C++Builder 3.0

1.7   [Aug-17, 1998]
      ColSel is now available for Delphi 4.0

1.8   [Mar-19, 1999]
      ColSel is now available for C++Builder 4.0

5.0   [Oct-09, 1999]
      ColSel is now available for Delphi 5.0

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
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


{----------------------------------------------------------------}
interface
{----------------------------------------------------------------}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms,  StdCtrls;

type
  TColSel = class(TCustomComboBox)
            private
              FColorBarWidth : Integer;
              FSelColor      : TColor;
              FUserDefCol    : TColor;
              function  GetSelColorID: string;
              procedure SetSelColor(Color: TColor);
              procedure SetColorBarWidth (W: Integer);
            protected
              procedure Click; override;
              procedure DrawItem (ix: Integer; Rect: TRect; State: TOwnerDrawState); override;
              procedure GetColor (ix: Integer; var Color: TColor; var ColorID: string);
              procedure Loaded; override;
              procedure LoadColors;
            public
              constructor Create(AOwner : TComponent); override;
              property  SelColorID: string read GetSelColorID;
            published
              property Color;
              property ColorBarWidth: Integer read FColorBarWidth write SetColorBarWidth;
              property DropDownCount;
              property Enabled;
              property Font;
              property ParentColor;
              property ParentFont;
              property ParentShowHint;
              property SelColor: TColor read FSelColor write SetSelColor;
              property ShowHint;
              property TabOrder;
              property TabStop;
              property Visible;
              property OnChange;
              property OnClick;
              property OnDblClick;
              property OnDropDown;
              property OnEnter;
              property OnExit;
            end;


procedure Register;

{----------------------------------------------------------------}
implementation
{----------------------------------------------------------------}

uses
  dialogs;
  
{$IFDEF SHAREWARE}
{$I sharwinc\colsel_ct.inc}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}

const
  MaxPreDefColors = {$IFDEF VER90} 41 {$ELSE} 37 {$ENDIF};     { all basic VGA colors and the system colors }
  PredefinedColors : array [0..MaxPreDefColors] of TColor =
              ($98AADD, clBlack, clMaroon, clGreen, clOlive, clNavy,
               clPurple, clTeal, clGray, clSilver, clRed,
               clLime, clYellow, clBlue, clFuchsia, clAqua,
               clWhite, clScrollBar, clBackground, clActiveCaption, clInactiveCaption,
               clMenu, clWindow, clWindowFrame, clMenuText, clWindowText,
               clCaptionText, clActiveBorder, clInactiveBorder, clAppWorkSpace, clHighLight,
               clHighLightText, clBtnFace, clBtnShadow, clGrayText, clBtnText,
               clInactiveCaptionText, clBtnHighlight {$IFDEF VER90},
               cl3DDkShadow, cl3DLight, clInfoText, clInfoBk {$ENDIF});


(****************************************************************)
constructor TColSel.Create(AOwner : TComponent);
(****************************************************************)

begin
inherited Create(AOwner);
Sorted := False;
FColorBarWidth := 30;
FUserDefCol := PredefinedColors[0];
Style := csOwnerDrawFixed;
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;

(****************************************************************)
procedure TColSel.Loaded;
(****************************************************************)

begin
inherited Loaded;
LoadColors;
end;

(****************************************************************)
procedure TColSel.LoadColors;
(****************************************************************)

var
  i          : Integer;
  ColorID    : string;
  Color      : TColor;
  selectedIx : Integer;

begin
selectedIx  := -1;
Clear;
for i := MaxPreDefColors downto 0 do
  begin
  GetColor(i, Color, ColorID);
  Items.Add (ColorID);
  if ColorToRGB(Color) = ColorToRGB(FSelColor) then
    selectedIx  := i;
  end;
ItemIndex := selectedIx;
end;


(****************************************************************)
procedure TColSel.DrawItem (Ix: Integer;
                     Rect: TRect; State: TOwnerDrawState);
(****************************************************************)

{$IFDEF SHAREWARE}
const
  MaxSWMsg = 7;
  SharewareMsg : array[0..MaxSwMsg] of string[20] =
                            ('----------','Unregistered','shareware:',
                             'COLSEL is','not running','without the',
                             'Delphi IDE.','----------');
{$ENDIF}

var
  BakColor    : TColor;
  Color       : TColor;
  ColorID     : string;

begin
GetColor(Ix, Color, ColorID);
with Canvas do
  begin
  if ColorBarWidth > 0 then
    begin
    Brush.Style := bsSolid;
    BakColor := Brush.Color;                          { colored rectangle }
    Brush.Color := Color;
    Rectangle(Rect.Left+3, Rect.Top+2, Rect.Left+3+ColorBarWidth, Rect.Bottom-2);
    Brush.Color := BakColor;
    end;
  Rect.Left := Rect.Left+3+ColorBarWidth;               { name of color }
  {$IFDEF SHAREWARE}
  if not DelphiIsRunning
    then begin
         if ix <= MaxSWMsg
           then TextRect (Rect, Rect.Left+3,
                          Rect.Top + (Rect.Bottom - Rect.Top - TextHeight(ColorID)) div 2,
                          ShareWareMsg[ix])
           else TextRect (Rect, Rect.Left+3,
                          Rect.Top + (Rect.Bottom - Rect.Top - TextHeight(ColorID)) div 2,
                          ColorID);
         end
    else
  {$ENDIF}
  TextRect (Rect, Rect.Left+3,
            Rect.Top + (Rect.Bottom - Rect.Top - TextHeight(ColorID)) div 2,
            ColorID);
  end;
end;



(****************************************************************)
procedure TColSel.Click;
(****************************************************************)

var
   ColorID : string;

begin
if ItemIndex >= 0 then
  GetColor (ItemIndex, FSelColor, ColorID);
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
inherited Click;
end;


(****************************************************************)
procedure TColSel.GetColor (Ix: Integer; var Color: TColor;
                            var ColorID: string);
(****************************************************************)

begin
if (Ix >= 1) and (Ix <= MaxPreDefColors)
  then begin
       Color := PredefinedColors[Ix];
       ColorID := ColorToString(PredefinedColors[Ix]); { strip ColorID from leading 'cl' }
       if pos ('cl', ColorID) = 1 then
         delete (ColorID,1,2);
       end
  else if (ix = 0) then
         begin
         Color := FUserDefCol;
         ColorID := 'user defined';
         end;
end;



(****************************************************************)
function  TColSel.GetSelColorID : string;
(****************************************************************)

begin
GetSelColorID := '';
if ItemIndex >= 0 then
  GetSelColorID := Items.Strings[ItemIndex];
end;


(****************************************************************)
procedure TColSel.SetSelColor(Color : TColor);
(****************************************************************)

var
  ColorID : string;
  i       : Integer;
  fColor  : TColor;

begin
FSelColor := Color;
i := 0;     { browse combo list }
repeat
  inc(i);
  GetColor(i, fColor, ColorID);
until (i = MaxPreDefColors) or (ColorToRGB(fColor) = ColorToRGB(Color));
if ColorToRGB(fColor) = ColorToRGB(Color)
  then ItemIndex := i
  else begin
       ItemIndex := 0;
       FUserDefCol := Color;
       Refresh;
       end;
end;


(****************************************************************)
procedure TColSel.SetColorBarWidth (W: Integer);
(****************************************************************)

begin
if (FColorBarWidth <> w) and (w > 0) then
  begin
  FColorBarWidth := w;
  Refresh;
  end;
end;



(****************************************************************)
procedure Register;
(****************************************************************)

begin
RegisterComponents('SDL', [TColSel]);
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

