unit dirtree;

(******************************************************************)
(*                                                                *)
(*                          D I R T R E E                         *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1996..2001 H. Lohninger                 January 1996   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Oct-09, 1999                                  *)
(*                                                                *)
(******************************************************************)

{ Revision history :

1.00  [May 1996]
      first version released to the public

1.01  [Oct-8, 1996]
      MaxDirNames is now set to 1900
      bug in "LoadDirNamesAndSort" fixed, which prohibited
        the correct reading of read-only directories
      bug fixed which discarded the warning message, if the number of
        directories exceeded the limit MaxDirNames

1.5   [May-28, 1997]
      DIRTREE now available for C++Builder version 1.0

1.6   [Feb-09, 1998]
      DCOMMON no longer needed
      DIRTREE now available for C++Builder version 3.0

1.7   [Aug-17, 1998]
      DIRTREE is now available for Delphi 4.0

1.8   [Apr-01, 1999]
      DIRTREE is now available for C++Builder 4.0

5.0   [Oct-09, 1999]
      DIRTREE is now available for Delphi 5.0

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



{----------------------------------------------------------------------}
interface
{----------------------------------------------------------------------}

uses
  Classes, Forms, Controls, Outline, SysUtils, Graphics,
  StdCtrls, WinTypes, WinProcs;

const
  MaxDirNames = 1900;         { max. number of dir. names to be handled }
  MaxDirNamLeng = 32;   { max. number of characters of a directory name }

type
  DirNameType = array[1..MaxDirNames] of string[32];
  TTxtCase = (tcNochange, tcLower, tcUpper);
  TDirTree = class(TCustomOutLine)
               private
                 XDrive          : Char;
                 XDirectory      : TFileName;
                 XOnChange       : TNotifyEvent;
                 XTxtCase        : TTxtCase;
                 DirNamesP       : ^DirNameType;  { buffer for directory names }
                 NumDNames       : integer;       { number of names in 'DirNamesP' }
               protected
                 procedure BuildMainTree;
                 procedure Change; virtual;
                 procedure Click; override;
                 procedure CreateWnd; override;
                 procedure Expand(Index: Longint); override;
                 procedure Loaded; override;
                 procedure SetDrive (drv: char);
                 procedure SetTextCase (TC: TTxtCase);
                 procedure LoadDirNamesAndSort (CurrentDir: string);
                 procedure InitialSetup;
               public
                 constructor Create(AOwner: TComponent); override;
                 destructor Destroy; override;
                 property  Directory: TFileName  read XDirectory;
                 procedure ReloadRootTree;
               published
                 property Align;
                 property Drive: Char  read XDrive write SetDrive;
                 property Options default [ooStretchBitmaps, ooDrawFocusRect];
                 property Font;
                 property OutlineStyle;
                 property ParentShowHint;
                 property PicturePlus;
                 property PictureMinus;
                 property PictureOpen;
                 property PictureClosed;
                 property PictureLeaf;
                 property ShowHint;
                 property TabOrder;
                 property TabStop;
                 property TxtCase: TTxtCase  read XTxtCase write SetTextCase default tcLower;
                 property OnChange: TNotifyEvent  read XOnChange write XOnChange;
                 property OnCollapse;
                 property OnDragDrop;
                 property OnDragOver;
                 property OnEnter;
                 property OnExit;
                 property OnExpand;
             end;


procedure Register;

{----------------------------------------------------------------------}
implementation
{----------------------------------------------------------------------}

uses
  dialogs;

{$IFDEF SHAREWARE}
{$I SHARWINC\dirtree_ct.inc}
{$I SHARWINC\Delfrun.INC}
{$ENDIF}

const
  touched = $A5F016ED;  { flag to indicate expansion of subdirectories }

type
  ESDLDirtreeError = class(Exception);     { exception type to indicate errors }


(**********************************************************************)
constructor TDirTree.Create(AOwner: TComponent);
(**********************************************************************)

begin
inherited Create(AOwner);
PictureLeaf := PictureClosed;
Options := Options - [ooDrawTreeRoot] + [ooStretchBitmaps];
OutLineStyle := osTreePictureText;
XTxtCase := tcLower;
XDrive := #0;
New (DirNamesP);
end;


(**********************************************************************)
procedure TDirTree.InitialSetup;
(**********************************************************************)

var
  CurrentPath: TFileName;

begin
if XDrive = #0 then
  begin
  GetDir(0, CurrentPath);
  if XTxtCase = tcLower
    then XDrive := AnsiLowerCase(CurrentPath)[1]
    else begin
         if XTxtCase = tcUpper
           then XDrive := AnsiUpperCase(CurrentPath)[1]
           else XDrive := CurrentPath[1];
         end;
  XDirectory := XDrive+':\';
  end;
BuildMainTree;
FullExpand;
end;


(**********************************************************************)
procedure TDirTree.ReloadRootTree;
(**********************************************************************)

begin
XDirectory := XDrive+':\';
BuildMainTree;
FullExpand;
end;


(**********************************************************************)
procedure TDirTree.CreateWnd;
(**********************************************************************)

begin
inherited CreateWnd;
InitialSetup;
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;

(**********************************************************************)
destructor TDirTree.Destroy;
(**********************************************************************)

begin
Dispose (DirNamesP);
inherited Destroy;
end;


(**********************************************************************)
procedure TDirTree.Loaded;
(**********************************************************************)

begin
inherited Loaded;
InitialSetup;
end;


(**********************************************************************)
procedure TDirTree.Click;
(**********************************************************************)

var
  hstr : string;

begin
inherited Click;
hstr := Items[SelectedItem].FullPath;
  if length(hstr) = 2 then       { append backslash for root dir }
    if hstr[2] = ':' then
      hstr := hstr + '\';
XDirectory := hstr;
Change;
end;


(**********************************************************************)
procedure TDirTree.SetTextCase (TC: TTxtCase);
(**********************************************************************)

var
  i   : integer;

begin
if tc <> XTxtCase then
  begin
  XTxtCase := tc;
  if XtxtCase = tcLower
    then begin
         BeginUpDate;
         for i:=1 to ItemCount do
           Items[i].Text := AnsiLowerCase (Items[i].text);
         EndUpDate;
         end
    else if XTxtCase = tcUpper then
           begin
           BeginUpDate;
           for i:=1 to ItemCount do
             Items[i].Text := AnsiUpperCase (Items[i].text);
           EndUpDate;
           end;
  end;
end;



(**********************************************************************)
procedure TDirTree.LoadDirNamesAndSort (CurrentDir: string);
(**********************************************************************)

var
  SortOK        : boolean;
  i             : integer;
  hstr          : string[32];
  DirScanRes    : TSearchRec;
  DosError      : integer;

begin
NumDNames := 0;                   (* search for all directory names *)
if CurrentDir[length(CurrentDir)] = '\'
  then DosError := FindFirst (CurrentDir+'*.*', faDirectory, DirScanRes)
  else DosError := FindFirst (CurrentDir+'\*.*', faDirectory, DirScanRes);
if DosError = 0 then
  begin
  while ((DosError = 0) and (NumDNames < MaxDirNames)) do
    begin
    if (((DirScanRes.Attr and faDirectory) = faDirectory) and (DirScanRes.Name[1] <> '.')) then
      begin
      inc (NumDNames);
      if XTxtCase = tcLower
        then DirNamesP^[NumDNames] := AnsiLowerCase (DirScanRes.Name)
        else begin
             if XTxtCase = tcUpper then
               DirNamesP^[NumDNames] := AnsiUpperCase (DirScanRes.Name);
             end;
      end;
    DosError := FindNext (DirScanRes);
    end;
  if NumDNames >= MaxDirNames then
    raise ESDLDirTreeError.Create ('DIRTREE: too many directories in tree');
  repeat         { sort directory names }
    SOrtOk := True;
    for i:=1 to NumDNames-1 do
      begin
      if DirNamesP^[i] > DirNamesP^[i+1] then
        begin
        SortOK := False;
        hstr := DirNamesP^[i];
        DirNamesP^[i] := DirNamesP^[i+1];
        DirNamesP^[i+1] := hstr;
        end;
      end;
  until SortOk;
  {$IFDEF SHAREWARE}
  if (NumDNames > 6) and not DelphiIsRunning then
    begin
    DirNamesP^[2] := '**Unregistered';
    DirNamesP^[3] := '**Shareware';
    DirNamesP^[4] := '**TDirTree';
    DirNamesP^[5] := '**(c) 2001';
    DirNamesP^[6] := '**H. Lohninger';
    end;
  {$ENDIF}
  end;
end;



(**********************************************************************)
procedure TDirTree.BuildMainTree;
(**********************************************************************)

var
  FirstChild : integer;
  i          : integer;

begin
LoadDirNamesAndSort (XDrive+':');
Clear;
Add(0, XDrive + ':');
Items[1].Data := pointer (touched);
if NumDNames > 0 then
  begin
  FirstChild := AddChild (1, DirNamesP^[1]);
  for i:=2 to NumDNames do
    Add (FirstChild, DirNamesP^[i]);
  end;
Change;
end;


(**********************************************************************)
procedure TDirTree.Change;
(**********************************************************************)

begin
if Assigned(XOnChange) then
  XOnChange(Self);
{$IFDEF SHAREWARE}
Hint := GetHintStr;
ShowHint := True;
{$ENDIF}
end;

(**********************************************************************)
procedure TDirTree.Expand(Index: Longint);
(**********************************************************************)

var
  FirstChild   : longint;
  i            : integer;

begin
if Items[Index].Data <> pointer(touched) then     { expansion already loaded ? }
  begin
  LoadDirNamesAndSort (Items[Index].FullPath);
  if NumDNames > 0 then
    begin
    Items[Index].Data := Pointer (touched);          { mark item for sub path }
    FirstChild := AddChild (Index, DirNamesP^[1]);
    for i:=2 to NumDNames do
      Add (FirstChild, DirNamesP^[i]);
    end;
  end;
inherited Expand(Index);                          { call the event handler }
end;


(**********************************************************************)
procedure TDirTree.SetDrive (drv: char);
(**********************************************************************)

var
  ucdrv : char;

begin
ucdrv := UpCase(drv);
if (ucdrv >= 'A') and (ucdrv <= 'Z') then
  begin
  if (XDrive = #0) or (ucdrv <> UpCase(xDrive)) or
     (ucdrv = 'A') or (ucdrv = 'B') then
    begin
    if XTxtCase = tcLower
      then XDrive := AnsiLowerCase (drv)[1]
      else begin
           if XTxtCase = tcUpper
             then XDrive := ucdrv
             else XDrive := drv;
           end;
    ChDir(XDrive + ':');
    XDirectory := XDrive+':\';
    BuildMainTree;
    FullExpand;
    end;
  end;
end;



(**********************************************************************)
procedure Register;
(**********************************************************************)

begin
RegisterComponents('SDL', [TDirTree]);
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



