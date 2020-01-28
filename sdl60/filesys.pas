unit filesys;

(******************************************************************)
(*                                                                *)
(*                          F I L E S Y S                         *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1999..2001 H. Lohninger                 August 2000    *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jun-18, 2001                                  *)
(*                                                                *)
(******************************************************************)


{
Revision history
================

5.5   [September 2000]
      first released in September 2000

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      bug fixed in DirExists: created a range check error if passing an empty directory path to it
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

uses
  classes;

type
  TScanFilesFeedback = procedure (CurrentDir: string);  { procedure type for callback routine of ScanFilesToStringList}
  TFileCopyFeedBack = procedure (BytesCopied, SizeOfFile: longint);  { procedure type for callback routine during filecopy }
  TTreeCopyFeedBack = procedure (BytesCopied, SizeOfCurrentFile: longint; NameOfCurrentFile: string;
                                 NrOfFilesCopiedSoFar: longint);  { procedure type for callback routine during filecopy }


  procedure AbortAnyFileCopying;
  procedure CopyFileTree
             (source,                            { path to root of source tree }
                dest : string;                      { path to destination tree }
      RemoveReadOnly : boolean;                  { TRUE: remove readonly flags }
            FeedBack : TTreeCopyFeedback);      { feedback during copy process }
  function DelDirTree
               (path : string)                            { path to be deleted }
                     : string;  { empty if OK, else path which caused problems }
  function DeleteFiles
           (FileMask : string)                       { mask for file selection }
                     : integer;                      { number of deleted files }
  function DirEmpty
            (DirName : string)                  { directory name to be checked }
                     : boolean;   { TRUE if directory is empty or non-existing }
  function DirExists
            (DirName : string)                  { directory name to be checked }
                     : Boolean;                     { TRUE is directory exists }
  function DirIsReadOnly
                (Dir : string)                        { directory to be tested }
                     : boolean;              { returns true if dir is readonly }
  function DiskFreeExtended
              (Drive : Byte)       { drive to be tested; 0=A:, 1=B:, 2=C:, ... }
                     : comp;                            { number of free bytes }
  function DiskIsReadOnly
              (Drive : byte)       { drive to be tested; 0=A:, 1=B:, 2=C:, ... }
                     : boolean;       { returns TRUE if disk cannot be written }
  function ExtractDrive
               (Path : string)                            { path to be checked }
                     : integer;                                 { drive number }
  function DOSToWinPath
            (DOSPath : string)                             { DOS 8.3 path name }
                     : string;                          { long Win32 path name }
  function FileCopyFeedBk
         (SourceName,                                    { name of source file }
            DestName : string;                         { destination file name }
      RemoveReadOnly : boolean;                  { TRUE: remove readonly flags }
        FeedbackProc : TFileCopyFeedBack)       { feedback during copy process }
                     : integer;                                 { error number }
  function FileDetect
           (FileMask : string)                                   { search name }
                     : string;                                { full file name }
  function GetDiskDriveType
              (Drive : byte)       { drive to be tested; 0=A:, 1=B:, 2=C:, ... }
                     : integer;                       { status of tested drive }
  function GetEnviroVar
            (VarName : string)                          { environment variable }
                     : string;                 { value of environment variable }
  function GetFileSize
           (FileName : string)                       { file name to be checked }
                     : Longint;                           { file size in bytes }
  function GetSystemDir
                     : string;                      { returns system directory }
  function GetTempDir
                     : string;                   { returns temporary directory }
  function GetWindowsDir
                     : string;                     { returns windows directory }
  function InventPassword
            (NrChars : integer)             { number of characters of password }
                     : string;                      { easily readable password }
  function IsRootDir
               (path : string)                        { directory to be tested }
                     : boolean;       { returns TRUE is path is root directory }
  function MoveToRecycleBin
           (FileMask : String)      { filemask of files to move to recycle bin }
                     : integer;                        { number of moved files }
  procedure ScanFilesToStrList
           (FileMask : string;              { filemask of files to be included }
             SubDirs : boolean;     { TRUE: recursive search in subdirectories }
                  SL : TStringList;                 { string list to be filled }
            Feedback : TScanFilesFeedback);     { feedback during scan process }
  procedure SetAllFilenameCase
           (FileMask : string;                  { filemask of files to process }
                 Upc : boolean);                            { upper/lower case }
  function StripExtension
              (FName : string)                                     { file name }
                     : string;                        { name without extension }
  function StripPath
              (FName : string)                                     { file name }
                     : string;                             { name without path }


{------------------------------------------------------------------------------}
implementation
{------------------------------------------------------------------------------}

uses
  windows, ShellApi, SysUtils, FileCtrl {$IFDEF SHAREWARE}, dialogs {$ENDIF};

{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\filesys_ct.inc}
{$ENDIF}

{$I stripblk.inc}
{$I stripext.inc}

var
  CopyFileAbort     : boolean;
  FTCopyFeedBack    : TTreeCopyFeedback; { needed for feedback routine of filetree copy }
  FTCopyName        : string;
  FTCopyFileCnt     : longint;
  FTCopyBytesCopied : longint;
  FTCopyFSize       : longint;



(******************************************************************************)
procedure AbortAnyFileCopying;
(******************************************************************************)

begin
CopyFileAbort := true;
end;


(******************************************************************************)
function FileCopyFeedBk (SourceName, DestName: string;
                         RemoveReadOnly: boolean;
                         FeedbackProc: TFileCopyFeedBack): integer;
(******************************************************************************
  ENTRY: SourceName .... name of source file (full file spec incl. path)
         DestName ...... name of destination file, path must be existent
         FeedBackProc .. feedback procedure during file copying; is called every 8 kB
                         and at the start and at the end of the copying process
                         should be set to nil if not used

  EXIT:   file is copied
          function returns error code:
                0 .... no error
               -1 .... no such sources file
               -2 .... cannot create destination file
               -3 .... write error during copying
               -4 .... read error during copying
 ******************************************************************************)

const
  BlockSize = 8192;

var
  CopyBuffer   : Pointer;
  Source, Dest : Integer;
  CopiedSoFar  : Longint;
  NumBytes     : longint;
  ec           : integer;
  AnyFile      : File of byte;
  fs           : longint;
  FModeBak     : integer;

begin
CopyFileAbort := false;
ec := 0;
GetMem(CopyBuffer, BlockSize);
try
  FModeBak := FileMode;  // dirty trick to deal with read-only files
  FileMode := 0;
  AssignFile (AnyFile, SourceName);
  reset (Anyfile);
  fs := FileSize(AnyFile);  // get file size
  closeFile (anyFile);
  FileMode := FModeBak;
  CopiedSoFar := 0;
  if Addr(FeedbackProc) <> nil then
    feedBackproc (CopiedSoFar, fs);
  Source := FileOpen(SourceName, fmShareDenyWrite);
  if Source < 0 then
    ec := -1;
  try
    Dest := FileCreate(DestName);
    if Dest < 0 then
      ec := -2;
    try
      if ec = 0 then
        repeat
          NumBytes := FileRead(Source, CopyBuffer^, BlockSize);
          if NumBytes = -1 then
            ec := -4;
          if Addr(FeedbackProc) <> nil then
            feedBackproc (CopiedSoFar, fs);
          CopiedSoFar := CopiedSoFar + NumBytes;
          if NumBytes > 0 then
            begin
            if FileWrite(Dest, CopyBuffer^, NumBytes) = -1 then
              ec := -3;
            end;
        until (NumBytes < BlockSize) or (ec <> 0) or CopyFileAbort;
      if ec = 0 then
        begin
        FileSetDate(Dest, FileGetDate(Source));
        if RemoveReadOnly then
          FileSetAttr (DestName, FileGetAttr(SourceName) and not faReadOnly);
        end;
      if Addr(FeedbackProc) <> nil then
        feedBackproc (CopiedSoFar, fs);
    finally
      FileClose(Dest);
    end;
  finally
    FileClose(Source);
  end;
finally
  FreeMem(CopyBuffer, BlockSize);
end;
FileCopyFeedBk := ec;
end;


(******************************************************************************)
procedure FeedBackOfFileCopy (BytCop, FSize: longint); far
(******************************************************************************
  this routine is used for feeback purposes only
 ******************************************************************************)

begin
FTCopyBytesCopied := BytCop;
FTCopyFSize := FSize;
if addr(FTCopyFeedBack) <> nil then
  FTCopyFeedback (FTCopyBytesCopied, FTCopyFSize, FTCopyName, FTCopyFileCnt);
end;


(******************************************************************************)
procedure CopyFileTree (source, dest: string;
                        RemoveReadOnly: boolean;
                        FeedBack: TTreeCopyFeedback);
(******************************************************************************
  ENTRY:  source ....... source directroy path
          dest ......... destination path
          feedback ..... call back routine for feedback on copy process
  EXIT:   procedure recursively copies all files in directory
          tree 'source' to directory tree 'destination' (including
          all subdirectories)
 ******************************************************************************)



procedure CopyFileTreeIntern (source, dest: string);
(*------------------------------------------------*)

var
  Doserr    : integer;
  SearchRec : TSearchRec;

begin
ForceDirectories (dest);
DosErr := FindFirst (source+'*.*', faAnyFile, SearchRec);
while (DosErr=0) and not CopyFileAbort do
  begin
  if (SearchRec.Attr and faDirectory <> faDirectory)
    then begin
         FTCopyName := dest+SearchRec.Name;
         inc (FTCopyFileCnt);
         FileCopyFeedBk (source+SearchRec.Name, FTCopyName, RemoveReadOnly, FeedBackOfFileCopy);
         if addr(FeedBack) <> nil then
           Feedback (FTCopyBytesCopied, FTCopyFSize, FTCopyName, FTCopyFileCnt);
         end
    else if ((SearchRec.Name<>'.') and (SearchRec.Name<>'..')) then
           CopyFileTreeIntern (source+SearchRec.Name+'\', dest+SearchRec.Name+'\');
  DosErr := Findnext(SearchRec);
end;
FindClose (SearchRec);
end;


begin
FTCopyFeedback := FeedBack;
FTCopyName := '';
FTCopyFileCnt     := 0;
FTCopyBytesCopied := 0;
FTCopyFSize       := 0;
CopyFileAbort := false;
if length(source) > 0 then
  if source[length(source)] <> '\' then
    source := source + '\';
if length(dest) > 0 then
  if dest[length(dest)] <> '\' then
    dest := dest + '\';
if lowercase (source) <> lowercase (dest) then
  CopyFileTreeIntern (source, dest);
end;


(******************************************************************************)
function GetFileSize (FileName: string): Longint;
(******************************************************************************)

var
  SRec : TSearchRec;

begin
if FindFirst(ExpandFileName(FileName), faAnyFile, SRec) = 0
  then Result := SRec.Size
  else Result := -1;
FindClose(SRec);
end;


(******************************************************************************)
function MoveToRecycleBin (FileMask: string): integer;
(******************************************************************************)

var
  FName      : string;
  ShellStruc : TSHFileOpStruct;
  SearchRec  : TSearchRec;
  P1         : array [0..256] of char;
  success    : boolean;

begin
result := 0;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
try
  if FindFirst(ExpandFileName(FileMask), faAnyFile, SearchRec) = 0 then
    repeat
      if (SearchRec.Name[1] <> '.') and
         (SearchRec.Attr and faVolumeID <> faVolumeID) and
         (SearchRec.Attr and faDirectory <> faDirectory) then
        begin
        success := False;
        FName := ExtractFilePath(FileMask) + SearchRec.Name;
        if FileExists(FName) then
          begin
          FillChar(P1, sizeof(P1), 0);
          StrPcopy(P1, ExpandFileName(FName)+#0#0);      
          ShellStruc.wnd := 0;
          ShellStruc.wFunc := FO_DELETE;
          ShellStruc.pFrom := P1;
          ShellStruc.pTo   := nil;
          ShellStruc.fAnyOperationsAborted := false;
          ShellStruc.hNameMappings := nil;
          ShellStruc.fFlags:= FOF_ALLOWUNDO or FOF_NOCONFIRMATION;
          if ShFileOperation(ShellStruc) = 0 then
            success := true;
          end;
        if success then
          inc (Result);
        end;
    until FindNext(SearchRec) <> 0;
finally
  FindClose(SearchRec);
end;
end;



(******************************************************************************)
function DelDirTree (path: string): string;
(******************************************************************************
 ENTRY: path ... full path specification of directory to be removed

 EXIT:  the directory specified by "path" plus all subdirectories are removed
        the function returns an empty string on success, or the file spec
        of the file/directory which could not be removed

 REEMARK: directories need not need to be empty
 ******************************************************************************)

var
  Searchrec : TSearchRec;
  ok        : integer;
  f         : File;
  IOTest    : integer;

begin
if length(path) > 0 then
  begin
  if path[length(path)] <> '\' then
    path:=path+'\';
  Result := '';
  ok := FindFirst(path+'*.*',faAnyFile,Searchrec);
  while ((ok=0) and (Result='')) do
    begin
    if (Searchrec.Attr and faDirectory) = faDirectory
      then begin
           if((Searchrec.Name <> '.') and (Searchrec.Name <> '..')) then
             Result := DelDirTree(path+Searchrec.Name+'\');
           end
      else begin
           {$I-}
           AssignFile (f,path+Searchrec.Name);
           Erase(f);
           {$I+}
           if (IOResult<>0) then
             Result:=path+Searchrec.Name;
           end;
    ok:=FindNext(Searchrec);
    end;
  FindClose (Searchrec);
  if(Result='') then
    begin
    {$I-}
    RmDir(path);
    {$I+}
    IOTest := IOResult;
    if IOTest<>0 then
      Result:=path;
    end;
  end;
end;


(******************************************************************************)
function DiskIsReadOnly (Drive: byte): boolean;
(******************************************************************************)

var
  TFile : TextFile;

begin
assignFile (TFile, chr(ord('A')+Drive)+':\$%$LO%$.$$$');
{$I-} rewrite (TFile); {$I+}
if IOResult = 0
  then begin
       closeFile(TFile);
       erase (TFile);
       DiskIsReadOnly := false;
       end
  else DiskIsReadOnly := true;
end;


(******************************************************************************)
function DirIsReadOnly (Dir: string): boolean;
(******************************************************************************)

var
  TFile : TextFile;

begin
if dir[length(dir)] <> '\' then
  dir := dir + '\';
assignFile (TFile, dir+'$%$LO%$.$$$');
{$I-} rewrite (TFile); {$I+}
if IOResult = 0
  then begin
       closeFile(TFile);
       erase (TFile);
       DirIsReadOnly := false;
       end
  else DirIsReadOnly := true;
end;



(******************************************************************************)
function GetDiskDriveType (Drive: byte): integer;
(******************************************************************************
  ENTRY: Drive ..... drive number (0=A, 1=B, ... 25=Z)

  EXIT:  function returns the type of the specified drive:
           0                The drive type cannot be determined.
           DRIVE_REMOVABLE  removable disk
           DRIVE_FIXED      harddisk
           DRIVE_REMOTE     remote (network) drive.
           DRIVE_CDROM      CD-ROM drive.
           DRIVE_RAMDISK    RAM disk
(******************************************************************************)

var
  RootPath : array[0..4] of Char;
  RootPtr  : PChar;

begin
if Drive > 25
  then GetDiskDriveType := 0
  else begin
       StrCopy(RootPath, 'A:\');
       RootPath[0] := Char(Drive + $41);
       RootPtr := RootPath;
       GetDiskDriveType := GetDriveType (RootPtr);
       end;
end;


(******************************************************************************)
function IsRootDir (path: string): boolean;
(******************************************************************************
  ENTRY: path .... directory path to be checked

  EYIT:  function returns TRUE if path is a root directory of any drive
 ******************************************************************************)

begin
result := false;
path := StripLtBlanks(lowercase(path));
if length(path) <= 3 then
  begin
  if pos(':\', path) = 2 then
    result := true;
  end;
end;


(******************************************************************************)
function StripPath (FName : string): string;
(******************************************************************************
  ENTRY: FName .... filename

  EXIT:  function returns filename without path
 ******************************************************************************)

begin
StripPath := ExtractFileName(FName);
end;



(******************************************************************************)
function DeleteFiles(FileMask: string): integer;
(******************************************************************************)

var
  SearchRec: TSearchRec;

begin
result := 0;
try
  if FindFirst(ExpandFileName(FileMask), faAnyFile, SearchRec) = 0 then
    repeat
      if (SearchRec.Name[1] <> '.') and
         (SearchRec.Attr and faVolumeID <> faVolumeID) and
         (SearchRec.Attr and faDirectory <> faDirectory) then
        begin
        if DeleteFile(ExtractFilePath(FileMask) + SearchRec.Name) then
          inc (Result);
        end;
    until FindNext(SearchRec) <> 0;
finally
  FindClose(SearchRec);
end;
end;


(******************************************************************************)
function InventPassword (NrChars: integer): string;
(******************************************************************************)
(* ENTRY: NrChars ..... number of characters, password should have
   EXIT:  function returns a password which is easy to read
(******************************************************************************)

const
  vocals : array [1..6] of char = ('a','e','i','o','u','y');
  conson : array [1..20] of char = ('b','c','d','f','g',
                                    'h','j','k','l','m',
                                    'n','p','q','r','s',
                                    't','v','w','x','z');
var
  nn   : integer;
  astr : string;
  bstr : string;
  nc   : integer;
  i    : integer;

begin
nc := NrChars;
if nc > 14 then
  nc := 14;
if nc < 4 then
  nc := 4;
if (nc mod 2) = 1
  then astr := vocals[1+random(6)]
  else astr := '';
for i:=1 to (nc div 2)-1 do
  begin
  nn := 1+random(20);
  astr := astr + conson[nn];
  nn := 1+random(6);
  astr := astr + vocals[nn];
  end;
nn := random(100);
bstr := IntToStr(nn);
if nn < 10 then
  bstr := '0' + bstr;
Insert (bstr, astr, 7);
InventPassword := astr;
end;



(******************************************************************************)
function FileDetect (FileMask: string): string;
(******************************************************************************
  ENTRY:   FName .... filename to be searched for (including optional
                      path and wildcards)
  EXIT:    function returns empty string if no such file exists or
           full filename specification of first matched entry
 ******************************************************************************)


var
  DirInfo : TSearchRec;
  dir     : string;
  nam     : string;
  resultS : string;
  DosErr  : integer;

begin
resultS := '';
FileMask := uppercase(FileMask);
nam := ExtractFileName (FileMask);
dir := ExtractFilePath (FileMask);
DosErr := FindFirst (FileMask,faArchive,DirInfo);
if DosErr = 0
  then resultS := dir+DirInfo.Name
  else begin
       DosErr := FindFirst (dir+'*.*',faDirectory,DirInfo);
       while ((DosErr = 0) and (length(resultS) = 0)) do
         begin
         if ((DirInfo.Attr = faDirectory) and (DirInfo.Name <> '.') and
             (DirInfo.Name <> '..')) then
           resultS := FileDetect (dir+DirInfo.Name+'\'+nam);
         DosErr := FindNext (DirInfo);
         end;
       end;
FileDetect := resultS;
end;

(******************************************************************************)
function DOSToWinPath (DOSPath: string): string;
(******************************************************************************)

var
  Searchrec : TSearchRec;
  SepPos    : Integer;

begin
DOSPath := ExpandFileName (DOSPath);
SepPos := Pos (':', DOSPath);
Result := Copy (DOSPath, 1, SepPos);
delete (DOSPath, 1, SepPos+1);
repeat
  SepPos:=Pos ('\', DOSPath);
  if (SepPos<>0)
    then begin
         if (FindFirst (Result+'\'+Copy (DOSPath, 1, SepPos-1) , faDirectory, Searchrec)<>0) then
           begin
           Result:=DOSPath;
           Exit;
           end;
         end
    else begin
         if (FindFirst (Result+'\'+DOSPath, faDirectory, Searchrec) <>0)  then
           begin
           Result:=DOSPath;
           Exit;
           end;
         end;
  Result:=Result+'\'+Searchrec.FindData.cFileName;
  DOSPath:=Copy (DOSPath, SepPos+1, Length (DOSPath));
until (SepPos=0);
end;



(******************************************************************************)
function ExtractDrive (Path: string): integer;
(******************************************************************************
  ENTRY: Path .... path to be checked

  EXIT:  function returns Drive number of path:
         -1 ... current (is returned if second character in Path is not a colon
         0 ... A
         1 ... B
         2 ... C
         and so on
 ******************************************************************************)

var
  cc : char;

begin
if Path[2] = ':'
  then ExtractDrive := -1
  else begin
       cc := upcase(Path[1]);
       if not (cc in ['A'..'Z'])
         then ExtractDrive := 0
         else ExtractDrive := ord(cc)-ord('A');
       end;
end;

(******************************************************************************)
function DiskFreeExtended (Drive: Byte): comp;
(******************************************************************************
  this function is an extended version of the classical DiskFree
  routine, which fails if the disk exceeds more than 4 GB
 ******************************************************************************)

var
  RootPath: array[0..4] of Char;
  RootPtr: PChar;
  SectorsPerCluster,
  BytesPerSector,
  FreeClusters,
  TotalClusters: dword;
  reslt        : comp;

begin
StrCopy(RootPath, 'A:\');
RootPath[0] := Char(Drive + $41);
RootPtr := RootPath;
if GetDiskFreeSpace(RootPtr, SectorsPerCluster, BytesPerSector, FreeClusters, TotalClusters)
  then begin
       reslt := SectorsPerCluster;
       reslt := reslt * BytesPerSector * FreeClusters;
       end
  else reslt := -1;
DiskFreeExtended := reslt;
end;


(******************************************************************************)
procedure SetAllFilenameCase (FileMask: string; Upc: boolean);
(******************************************************************************
  ENTRY:   FileMask ... filename to be searched for (including optional
                        path and wildcards)
           Upc ........ TRUE: all filenames are set to uppercases
                        FALSE : all filenames are set to lowercase
 ******************************************************************************)


var
  DirInfo : TSearchRec;
  dir     : string;
  nam     : string;
  resultS : string;
  DosErr  : integer;
  AFile   : file;

begin
resultS := '';
FileMask := lowercase (FileMask);
nam := ExtractFileName (FileMask);
dir := ExtractFilePath (FileMask);
DosErr := FindFirst (FileMask,faAnyFile,DirInfo);
while (DosErr = 0) do
  begin
  if ((DirInfo.Name <> '.') and (DirInfo.Name <> '..')) then
    begin
    assign (AFile, dir+DirInfo.Name);
    if upc
      then rename (AFile, uppercase(dir+DirInfo.Name))
      else rename (AFile, lowercase(dir+DirInfo.Name));
    if ((DirInfo.Attr = faDirectory) and (DirInfo.Name <> '.') and
        (DirInfo.Name <> '..')) then
      SetAllFileNameCase (dir+DirInfo.Name+'\'+nam, Upc);
    end;
  DosErr := FindNext (DirInfo);
  end;
FindClose (DirInfo);
end;


(******************************************************************************)
function DirEmpty (DirName: string): boolean;
(*****************************************************************************
  ENTRY:   DirName .... directory path
  EXIT:    function returns true, if directory is empty or does not
           exist
 ******************************************************************************)

var
  DirInfo    : TSearchRec;
  DosErr     : integer;
  DirIsEmpty : boolean;

begin
DirIsEmpty := true;
if length(DirName) > 0 then
  if DirName[length(DirName)] <> '\' then
    DirName := DirName + '\';
DosErr := FindFirst (DirName+'*.*',faAnyFile,DirInfo);
while (DosErr = 0) and DirIsEmpty do
  begin
  if (length(DirInfo.Name) > 0) and
     (DirInfo.Name <> '.') and (DirInfo.Name <> '..') then
    DirIsEmpty := false;
  DosErr := FindNext (DirInfo);
  end;
FindClose (DirInfo);
DirEmpty := DirIsEmpty;
end;


(******************************************************************************)
function DirExists (DirName: string): Boolean;
(******************************************************************************)

var
  status: integer;

begin
result := false;
if DirName <> '' then
  begin
  status := GetFileAttributes(PChar(DirName));
  Result := (status <> -1) and (FILE_ATTRIBUTE_DIRECTORY and status <> 0);
  end;
end;


(******************************************************************************)
procedure ScanFilesToStrList (FileMask: string; SubDirs: boolean; SL: TStringList;
                              Feedback: TScanFilesFeedback);
(******************************************************************************
 ENTRY: FSpec ........... file spec to be searched for
        SubDirs.......... TRUE: recursive search into subdirectories
        FeedBackProc .... callback routine during scanning for files

 EXIT:  SL ....... string list is cleared and then filled with all
                   filenames matching the search criterion FSpec. The
                   filenames contain pathes relative to FSpec. If Fspec
                   is a full path, the filenames in the string list contain
                   also a full path.
 ******************************************************************************)

var
  DosErr  : integer;

procedure DoTheJob (FSpec: string);
(*-------------------------------*)

var
  DirInfo : TSearchRec;
  dir     : string;
  nam     : string;

begin
FSpec := uppercase(FSpec);
nam := ExtractFileName (FSpec);
dir := ExtractFilePath (FSpec);
if Addr(Feedback) <> nil then
  FeedBack (dir);
DosErr := FindFirst (FSpec, faAnyFile, DirInfo);
while DosErr = 0 do
  begin
  if (DirInfo.Attr and faDirectory) <> faDirectory then
    SL.Add (dir+DirInfo.Name);
  DosErr := FindNext (DirInfo);
  end;
FindClose (DirInfo);
if SubDirs then
  begin
  DosErr := FindFirst (dir+'*.*', faDirectory, DirInfo);  // now recurse into directory tree
  while DosErr = 0 do
    begin
    if (((DirInfo.Attr and faDirectory) = faDirectory) and (DirInfo.Name <> '.') and
        (DirInfo.Name <> '..')) then
      DoTheJob (dir+DirInfo.Name+'\'+nam);
    DosErr := FindNext (DirInfo);
    end;
  FindClose (DirInfo);
  end;
end;


begin
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
if SL <> nil then
  begin
  SL.Clear;
  DoTheJob (FileMask);
  end;
end;



(******************************************************************************)
function GetTempDir: string;
(******************************************************************************)

var
  Buffer: array[0..1023] of Char;

begin
SetString(Result, Buffer, GetTempPath(SizeOf(Buffer), Buffer));
end;


(******************************************************************************)
function GetWindowsDir: string;
(******************************************************************************)

var
  Buffer: array[0..1023] of Char;

begin
SetString(Result, Buffer, GetWindowsDirectory(Buffer, SizeOf(Buffer)));
end;


(******************************************************************************)
function GetSystemDir: string;
(******************************************************************************)

var
  Buffer: array[0..1023] of Char;

begin
SetString(Result, Buffer, GetSystemDirectory(Buffer, SizeOf(Buffer)));
end;


(******************************************************************************)
function GetEnviroVar(VarName: string): string;
(******************************************************************************)

var
  Leng  : Cardinal;
  EvStr : PChar;

begin
Leng := Length(VarName);
EvStr := GetEnvironmentStrings;
result := '';
while (EvStr^ <> #0) do
  begin
  if (AnsiStrLiComp(EvStr, PChar(VarName), Leng)=0) and (EvStr[Leng]='=') then
    Result := StrPas(EvStr+Leng+1);
  Inc(EvStr, StrLen(EvStr) + 1);
  end;
FreeEnvironmentStrings (EvStr);
end;


begin
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
end.
