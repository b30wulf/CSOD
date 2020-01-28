unit kohonen;

(******************************************************************)
(*                                                                *)
(*                          K O H O N E N                         *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1998..2001 H. Lohninger                February 1998   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jul-25, 2001                                  *)
(*                                                                *)
(******************************************************************)

{ revision history

6.0   [Aug-06, 2001]
      first release to the public
}

{$O+}
{$F+}
{$R-}

{------------------------------------------------------------------------------}
{-$DEFINE SHAREWARE}
{ This switch is only for testing during the development phase.
  It should be turned off for normal operation                                 }
{------------------------------------------------------------------------------}

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
  Vector, Matrix, classes;

type
  TKHFeedbackEvent = procedure (Sender: TObject; PercentDone: double) of object;
  TKohonenXMLTag = (xmlSizeX, xmlSizeY, xmlComment, xmlNrInsens, xmlMaxNeighb, xmlMaxSteps, xmlMaxAlpha,
             xmlCurStep, xmlCyclic, xmlCell, xmlMeanStdDev, xmlEndKohonen, xmlInvalid);
  TKohonen = class (TComponent)
            private
              FMaxNeighb  : integer;       { max. number of neighboring shells }
              FComment    : string;                  { user comment on network }
              FCurNeighb  : integer;      { current neighborhood during train. }
              FMaxSteps   : integer;           { max. number of training steps }
              FCurStep    : integer;            { current time during training }
              FMaxAlpha   : double;            { max. number of training steps }
              FCurAlpha   : double;            { current alpha during training }
              FKohMat     : TMat3D;             { 3 dimensional Kohonen amtrix }
              FSizeX      : integer;      { size of Kohonen map in x-direction }
              FSizeY      : integer;      { size of Kohonen map in x-direction }
              FNrInSens   : integer;            { nr. of layers in Kohonen map }
              FNrTrnObj   : integer;                 { nr. of training objects }
              MeanVec     : TVector;       { mean values for standardized data }
              StdDevVec   : TVector;          { std.devs for standardized data }
              FCyclic     : boolean;      { TRUE: cyclic Kohonen map effective }
              FMatsAdj    : boolean; { aux. flag for reading network from file }
              FAbort      : boolean; {flag to abort traing via callback routine}
              FReserved   : boolean;           { reserved for future extension }
              FOnFeedback : TKHFeedbackEvent;       { feedback during training }
              FDataMat    : TMatrix;                { data matrix for training }
              function  GetWeight (ix,iy,wi: integer): double;
              function  ProcessXmlTag (xmlTag: TKohonenXmlTag; attr, cont: string): integer;
              procedure SetNumInsens (nl: integer);
              procedure SetSizeX (x: integer);
              procedure SetSizeY (y: integer);
              procedure SetWeigtsToRandom;
              procedure SetDataMat (x: TMatrix);
            protected
              procedure DoFeedback (PercentDone: double);
            public
              constructor Create (AOwner: TComponent); override;
              destructor  Destroy; override;
              procedure   ApplyIt (InData: TVector; var BestIx, BestIy: integer; var Distance: double);
              procedure   AbortTraining;
              procedure   ContinueTraining;
              function    LoadFromXMLFile (FName: string; DataID: string): boolean;
              function    ReadFromXMLStream (InStream: TStream; DataID: string): boolean;
              function    ReadFromOpenXMLFile (var InFile : TextFile; DataID: string): boolean;
              procedure   SaveAsXMLFile (FName: string; DataID: string);
              procedure   StandardizeData;
              property    TrainData: TMatrix read FDataMat write SetDataMat;                { data matrix for training }
              procedure   Trainit;
              property    Weights [ix,iy,wi: integer]:double read GetWeight;
              procedure   WriteToXMLStream (OutStream: TStream; CreateHeader: boolean; DataID: string);
              procedure   WriteToOpenXMLFile (var OutFile : TextFile; CreateHeader: boolean; DataID: string);
            published
              property    Comment: string read FComment write FComment;
              property    Cyclic: boolean read FCyclic write FCyclic;
              property    InitialAlpha: double read FMaxAlpha write FMaxAlpha;
              property    InitialNeighbors: integer read FMaxNeighb write FMaxNeighb;
              property    NrOfInSens: integer read FNrInSens write SetNumInsens;
              property    NrOfTrnSteps: integer read FMaxSteps write FMaxSteps;
              property    SizeX: integer read FSizeX write SetSizeX;
              property    SizeY: integer read FSizeY write SetSizeY;
              property    OnFeedback: TKHFeedbackEvent read FOnFeedBack write FOnFeedback;
            end;


procedure Register;


{------------------------------------------------------------------------------}
implementation
{------------------------------------------------------------------------------}

uses
  wintypes, winprocs,  sysutils, stringl, streams, math1 {$IFDEF SHAREWARE}, dialogs {$ENDIF};


{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\kohonen_ct.inc}
{$ENDIF}


const                                   {xml tag names}
  xmlTagIds : array[xmlSizeX..xmlInValid] of string =
               ('sizex', 'sizey', 'comment', 'nrinsens', 'maxneighb',
                'maxsteps', 'maxalpha', 'currentstep', 'cyclic', 'cell',
                'meanstddev', '/kohonen', 'invalidtag');


(******************************************************************************)
constructor TKohonen.Create (AOwner: TComponent);
(******************************************************************************)

begin
inherited Create (AOwner);
FSizeX := 1;
FSizeY := 1;
FNrInSens := 1;
FNrTrnObj := 1;
FComment := '';
FKohMat := TMat3D.Create (FSizeX,FSizeY,FNrInSens); { dummy create }
MeanVec := TVector.Create (FNrInsens);  { dummy create }
StdDevVec := TVector.Create (FNrInsens); { dummy create }
FDataMat := TMatrix.Create (FNrInsens,FNrTrnObj); { dummy create }
FMaxNeighb := 2;
FMaxSteps := 200;
FMaxAlpha := 1.0;
FCyclic := false;
FReserved := true;
SetWeigtsToRandom;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
end;

(******************************************************************************)
destructor TKohonen.Destroy;
(******************************************************************************)

begin
FKohMat.Free;
FDataMat.Free;
MeanVec.Free;
StdDevVec.Free;
inherited Destroy;
end;


(******************************************************************************)
procedure TKohonen.DoFeedback (PercentDone: double);
(******************************************************************************)

begin
if Assigned(FOnFeedback) then
  FOnFeedback (self, PercentDone);
end;


(******************************************************************************)
procedure TKohonen.SetDataMat (x: TMatrix);
(******************************************************************************)

begin
FNrInSens := x.NrOfColumns;
if FDataMat <> NIL then   { copy training data into internal data matrix }
  FDataMat.Free;
FDataMat := TMatrix.Create (FNrInSens, x.NrOfRows);
FDataMat.copyfrom (x, 1, 1, FNrInSens, x.NrOfRows, 1, 1);
FNrTrnObj := x.NrOfRows;
if FKohMat <> NIL then  { now adjust kohonen map and aux. vectors to suitable size }
  FKohMat.Free;
FKohmat := TMat3D.Create (FSizeX,FSizeY,FNrInSens);
if StdDevVec <> NIL then
  StdDevVec.Free;
StdDevVec := TVector.Create (FNrInsens);
if MeanVec <> NIL then
  MeanVec.Free;
MeanVec := TVector.Create (FNrInsens);
end;


(******************************************************************************)
procedure TKohonen.StandardizeData;
(******************************************************************************)

begin
FDataMat.StandardizeColumns (MeanVec, StdDevVec);
end;


(******************************************************************************)
procedure TKohonen.SetNumInsens (nl: integer);
(******************************************************************************)

begin
if nl > 0 then
  begin
  FNrInSens := nl;
  if FKohMat <> NIL then
    FKohMat.Free;
  FKohmat := TMat3D.Create (FSizeX,FSizeY,FNrInSens);
  if FDataMat <> NIL then
    FDataMat.Free;
  FDataMat := TMatrix.Create (FNrInsens,FNrTrnObj);
  if StdDevVec <> NIL then
    StdDevVec.Free;
  StdDevVec := TVector.Create (FNrInsens);
  if MeanVec <> NIL then
    MeanVec.Free;
  MeanVec := TVector.Create (FNrInsens);
  end;
end;

(******************************************************************************)
function TKohonen.GetWeight (ix,iy,wi: integer): double;
(******************************************************************************)

begin
GetWeight := FKohMat.Elem[ix,iy,wi]*StdDevVec.Elem[wi] + MeanVec.Elem[wi];
end;


(******************************************************************************)
procedure TKohonen.SetSizeX (x: integer);
(******************************************************************************)

begin
if x > 0 then
  begin
  FSizeX := x;
  if FKohMat <> NIL then
    FKohMat.Free;
  FKohmat := TMat3D.Create (FSizeX,FSizeY,FNrInSens);
  end;
end;


(******************************************************************************)
procedure TKohonen.SetSizeY (y: integer);
(******************************************************************************)

begin
if y > 0 then
  begin
  FSizeY := y;
  if FKohMat <> NIL then
    FKohMat.Free;
  FKohmat := TMat3D.Create (FSizeX,FSizeY,FNrInSens);
  end;
end;



(******************************************************************************)
procedure TKohonen.AbortTraining;
(******************************************************************************)

begin
FAbort := true;
end;


(******************************************************************************)
procedure TKohonen.ApplyIt (InData: TVector; var BestIx, BestIy: integer;
                               var Distance: double);
(******************************************************************************)

var
  i,j,k  : integer;
  Dist   : double;
  stddev : double;

begin
Distance := MaxDouble;
for i:=1 to FKohMat.NrOfColumns do
  for j:=1 to FKohMat.NrOfRows do
    begin
    Dist := 0;
    for k:=1 to FKohMat.NrOfLayers do
      begin
      StdDev := StdDevVec.Elem[k];
      if StdDev <> 0
        then Dist := Dist + sqr(FKohMat.Elem[i,j,k]-(InData.Elem[k]-MeanVec.Elem[k])/StdDev)
        else Dist := Dist + sqr(FKohMat.Elem[i,j,k]-(InData.Elem[k]-MeanVec.Elem[k]));
      end;
    if Dist < Distance then
      begin
      Distance := Dist;
      BestIx := i;
      BestIy := j;
      end;
    end;
end;


(******************************************************************************)
procedure TKohonen.SetWeigtsToRandom;
(******************************************************************************)

var
  i, j, k: integer;

begin
for i:=1 to FKohMat.NrOfColumns do   (* init to random value *)
  for j:=1 to FKohMat.NrOfRows do
    for k:=1 to FKohMat.NrOfLayers do
      FKohMat.Elem[i,j,k] := 0.2*(random-0.5);
end;


(******************************************************************************)
procedure TKohonen.Trainit;
(******************************************************************************)

begin
FCurStep := 1;
SetWeigtsToRandom;

ContinueTraining;
end;


(******************************************************************************)
procedure TKohonen.ContinueTraining;
(******************************************************************************)

var
  BestIx       : integer;
  BestIy       : integer;
  MinDist      : double;
  i, j, k, obj : integer;
  Dist, nb     : double;
  ix1,ix2      : integer;
  iy1,iy2      : integer;
  ix, iy       : integer;
  delta        : integer;

begin   (* KohTrain *)
FAbort := False;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  FCurStep := FMaxSteps;   { no training is possible for unregistered component }
{$ENDIF}
repeat
  FCurNeighb := round(1.0 + (FMaxNeighb-1)*sqr((FMaxSteps-FCurStep)/FMaxSteps));
  FCurAlpha := FMaxAlpha*sqr((FMaxSteps-FCurStep)/FMaxSteps);
  BestIx := 1;
  BestIy := 1;
  for Obj:=1 to FDataMat.NrOfRows do   (* for all data objects *)
    begin
    MinDist := MaxDouble;
    for i:=1 to FKohMat.NrofColumns do   (* find best match between Network and input vector *)
      for j:=1 to FKohMat.NrofRows do
        begin
        Dist := 0;
        for k:=1 to FKohMat.NrofLayers do
          Dist := Dist + sqr(FKohMat.Elem[i,j,k]-FDataMat.Elem[k,obj]);
        if Dist < MinDist then
          begin
          MinDist := Dist;
          BestIx := i;
          BestIy := j;
          end;
        end;
    delta := FCurNeighb;
    if FCyclic then
      begin
      if delta >= FKohMat.NrOfColumns div 2
        then delta := FKohMat.NrOfColumns div 2 - 1;
      if delta < 0 then
        delta := 0;
      end;
    Ix1 := BestIx - delta;                 (* adjust weights of Kohonen matrix *)
    Ix2 := BestIx + delta;
    delta := FCurNeighb;
    if FCyclic then
      begin
      if delta >= FKohMat.NrOfRows div 2
        then delta := FKohMat.NrOfRows div 2 - 1;
      if delta < 0 then
        delta := 0;
      end;
    Iy1 := BestIy - delta;
    Iy2 := BestIy + delta;
    if not FCyclic then
      begin
      if Ix1 < 1 then
        Ix1 := 1;
      if Ix2 > FKohMat.NrOfColumns  then
        Ix2 := FKohMat.NrOfColumns;
      if Iy1 < 1 then
        Iy1 := 1;
      if Iy2 > FKohMat.NrOfRows then
        Iy2 := FKohMat.NrOfRows;
      end;
    for i:=ix1 to ix2 do
      for j:=iy1 to iy2 do
        begin
        ix := i;
        iy := j;
        if FCyclic then
          begin
          if ix < 1 then
            ix := FKohMat.NrOfColumns+ix;
          if ix > FKohMat.NrOfColumns  then
            ix := ix-FKohMat.NrOfColumns;
          if iy < 1 then
            iy := FKohMat.NrOfRows+iy;
          if iy > FKohMat.NrOfRows then
            iy := iy-FKohMat.NrOfRows;
          end;
        Dist := 0;
        for k:= 1 to FKohMat.NrOfLayers do
          dist := dist + sqr(FKohMat.Elem[ix,iy,k]-FDataMat.Elem[k,obj]);
        dist := 1/(1+sqrt(dist-MinDist));
        nb := FCurAlpha*Dist;
        for k:=1 to FKohMat.NrOfLayers do
          FKohMat.Elem [ix,iy,k] := FKohMat.Elem[ix,iy,k] + nb*(FDataMat.Elem[k,obj]-FKohMat.Elem[ix,iy,k]);
        end;
    end;
  DoFeedback (100.0*FCurStep/FMaxSteps);
  inc (FCurStep);
until (FAbort or (FCurStep >= FMaxSteps));
FAbort := false;
end;


(******************************************************************************)
procedure TKohonen.WriteToOpenXMLFile (var OutFile : TextFile;
                  CreateHeader: boolean; DataID: string);
(******************************************************************************
  ENTRY: OutFile ........ text file to be written (must be already open)
         CreateHeader ... TRUE: simple XML header is created
         DataID ......... ID of Kohonen component

  EXIT:  Data of TKohonen is exported to the text file OutFile
 ******************************************************************************)


var
  i,j,k  : integer;

begin
if CreateHeader then
  begin
  writeln (OutFile, '<?xml version="1.0"?>');
  end;
writeln (OutFile);
writeln (OutFile, '<!-- TKohonen / SDL Component Suite -->');
writeln (OutFile, '<kohonen sig="SDLCSuite" vers="6.0" id="'+DataID+'">');
writeln (OutFile, '<',xmlTagIds[xmlComment],'>',FComment,'</',xmlTagIds[xmlComment],'>');
writeln (OutFile, '<',xmlTagIds[xmlSizeX],'>',FSizeX,'</',xmlTagIds[xmlSizeX],'>');
writeln (OutFile, '<',xmlTagIds[xmlSizeY],'>',FSizeY,'</',xmlTagIds[xmlSizeY],'>');
writeln (OutFile, '<',xmlTagIds[xmlNrInSens],'>',FNrInSens,'</',xmlTagIds[xmlNrInSens],'>');
writeln (OutFile, '<',xmlTagIds[xmlMaxNeighb],'>',FMaxNeighb,'</',xmlTagIds[xmlMaxNeighb],'>');
writeln (OutFile, '<',xmlTagIds[xmlMaxSteps],'>',FMaxSteps,'</',xmlTagIds[xmlMaxSteps],'>');
writeln (OutFile, '<',xmlTagIds[xmlMaxAlpha],'>',FMaxAlpha,'</',xmlTagIds[xmlMaxAlpha],'>');
writeln (OutFile, '<',xmlTagIds[xmlCurStep]+'>',FCurStep,'</',xmlTagIds[xmlCurStep],'>');
writeln (OutFile, '<',xmlTagIds[xmlCyclic],'>',stringl.BoolToStr(FCyclic,0),'</',xmlTagIds[xmlCyclic],'>');
for i:=1 to FNrInsens do
  begin
  write (OutFile, '<',xmlTagIds[xmlMeanStdDev],' ix="',i,'">');
  write (OutFile, MeanVec.Elem[i],' ',StdDevVec.Elem[i]);
  writeln (OutFile, '</',xmlTagIds[xmlMeanStdDev],'>');
  end;
for i:=1 to FSizeX do  { store the weight matrix }
  for j:=1 to FSizeY do
    for k:=1 to FNrInSens do
      begin
      writeln (OutFile, '<',xmlTagIds[xmlCell],' ix="',i,'" iy="',j,'" is="',k,'">',FKohMat.Elem[i,j,k],'</',xmlTagIds[xmlCell],'>');
      end;
writeln (OutFile, '</kohonen>');
end;


(******************************************************************************)
procedure TKohonen.WriteToXMLStream (OutStream: TStream;
                  CreateHeader: boolean; DataID: string);
(******************************************************************************
  ENTRY: OutStream ...... stream to be written to
         CreateHeader ... TRUE: simple XML header is created
         DataID ......... ID of Kohonen component

  EXIT:  Data of TKohonen is exported to the stream OutStream
 ******************************************************************************)


var
  i,j,k  : integer;

begin
if CreateHeader then
  writelnStream (OutStream, '<?xml version="1.0"?>');
writelnStream (OutStream, '');
writelnStream (OutStream, '<!-- TKohonen / SDL Component Suite -->');
writelnStream (OutStream, '<kohonen sig="SDLCSuite" vers="6.0" id="'+DataID+'">');
writelnStream (OutStream, '<'+xmlTagIds[xmlComment]+'>'+FComment+'</'+xmlTagIds[xmlComment]+'>');
writelnStream (OutStream, '<'+xmlTagIds[xmlSizeX]+'>'+IntToStr(FSizeX)+'</'+xmlTagIds[xmlSizeX]+'>');
writelnStream (OutStream, '<'+xmlTagIds[xmlSizeY]+'>'+IntToStr(FSizeY)+'</'+xmlTagIds[xmlSizeY]+'>');
writelnStream (OutStream, '<'+xmlTagIds[xmlNrInSens]+'>'+IntToStr(FNrInSens)+'</'+xmlTagIds[xmlNrInSens]+'>');
writelnStream (OutStream, '<'+xmlTagIds[xmlMaxNeighb]+'>'+IntToStr(FMaxNeighb)+'</'+xmlTagIds[xmlMaxNeighb]+'>');
writelnStream (OutStream, '<'+xmlTagIds[xmlMaxSteps]+'>'+IntToStr(FMaxSteps)+'</'+xmlTagIds[xmlMaxSteps]+'>');
writelnStream (OutStream, '<'+xmlTagIds[xmlMaxAlpha]+'>'+strff(FMaxAlpha,23,-1)+'</'+xmlTagIds[xmlMaxAlpha]+'>');
writelnStream (OutStream, '<'+xmlTagIds[xmlCurStep]+'>'+IntToStr(FCurStep)+'</'+xmlTagIds[xmlCurStep]+'>');
writelnStream (OutStream, '<'+xmlTagIds[xmlCyclic]+'>'+stringl.BoolToStr(FCyclic,0)+'</'+xmlTagIds[xmlCyclic]+'>');
for i:=1 to FNrInsens do
  begin
  writeStringStream (OutStream, '<'+xmlTagIds[xmlMeanStdDev]+' ix="'+IntToStr(i)+'">');
  writeStringStream (OutStream, strff(MeanVec.Elem[i],23,-1)+' '+strff(StdDevVec.Elem[i],23,-1));
  writelnStream (OutStream, '</'+xmlTagIds[xmlMeanStdDev]+'>');
  end;
for i:=1 to FSizeX do  { store the weight matrix }
  for j:=1 to FSizeY do
    for k:=1 to FNrInSens do
      begin
      writelnStream (OutStream, '<'+xmlTagIds[xmlCell]+' ix="'+IntToStr(i)+'" iy="'+IntToStr(j)+'" is="'+IntToStr(k)+'">'+
                                    strff(FKohMat.Elem[i,j,k],23,-1)+'</'+xmlTagIds[xmlCell]+'>');
      end;
writelnStream (OutStream, '</kohonen>');
end;


(******************************************************************************)
procedure TKohonen.SaveAsXMLFile (FName: string; DataID: string);
(******************************************************************************
  ENTRY: FName .......... name of text file to be written
         DataID ......... ID of ReportList component

  EXIT:  Data of TKohonen is exported to the XML file FName
 ******************************************************************************)

var
  OutFile : TextFile;

begin
assignFile (OutFile, FName);
rewrite (OutFile);
WriteToOpenXMLFile (OutFile, true, DataID);
closeFile (OutFile);
end;

(******************************************************************************)
function TKohonen.ProcessXmlTag (xmlTag: TKohonenXmlTag; attr, cont: string): integer;
(******************************************************************************
  ProcessXMLTag processes the tag xmlTag;
    return codes: 0 .... tag was OK, processed
                  1 .... end of report list found
                 -1 .... invalid XML tag
 ******************************************************************************)


procedure AdjustMatrices;
(*---------------------*)

begin
if not FMatsAdj then
  begin
  FKohMat.Resize (FSizeX,FSizeY,FNrInSens);
  MeanVec.Resize (FNrInsens);
  StdDevVec.Resize (FNrInsens);
  FMatsAdj := true;
  end;
end;


var
  ix, iy : longint;
  iz     : longint;
  lx, ly : longint;
  lz     : longint;


begin
result := 0;
case xmltag of
  xmlEndKohonen : begin
                  result := 1;
                  end;
     xmlInvalid : begin
                  result := -1;
                  end;
       xmlSizeX : begin
                  ix := 1;
                  FSizeX := ScanDecimal(cont, ix);
                  end;
       xmlSizeY : begin
                  ix := 1;
                  FSizeY := ScanDecimal(cont, ix);
                  end;
     xmlComment : begin
                  FComment := cont;
                  end;
    xmlNrInsens : begin
                  ix := 1;
                  FNrInsens := ScanDecimal(cont, ix);
                  end;
   xmlMaxNeighb : begin
                  ix := 1;
                  FMaxNeighb := ScanDecimal(cont, ix);
                  end;
    xmlMaxSteps : begin
                  ix := 1;
                  FMaxSteps := ScanDecimal(cont, ix);
                  end;
     xmlCurStep : begin
                  ix := 1;
                  FCurStep := ScanDecimal(cont, ix);
                  end;
    xmlMaxAlpha : begin
                  ix := 1;
                  FMaxAlpha := ScanFPNum (cont, true, 3, ix);
                  end;
      xmlCyclic : begin
                  FCyclic := (lowercase(cont) = 'true');
                  end;
  xmlMeanStdDev : begin
                  AdjustMatrices;
                  ix := pos ('ix="', attr)+4;
                  lx := ScanDecimal(attr, ix);
                  ix := 1;
                  Meanvec.Elem[lx] := ScanFPNum (cont, true, 3, ix);
                  StdDevVec.Elem[lx] := ScanFPNum (cont, true, 3, ix);
                  end;
        xmlCell : begin
                  AdjustMatrices;
                  ix := pos ('ix="', attr)+4;
                  lx := ScanDecimal(attr, ix);
                  iy := pos ('iy="', attr)+4;
                  ly := ScanDecimal(attr, iy);
                  iz := pos ('is="', attr)+4;
                  lz := ScanDecimal(attr, iz);
                  ix := 1;
                  FKohMat.Elem[lx, ly, lz] := ScanFPNum (cont, true, 3, ix);
                  end;
end;
end;


(******************************************************************************)
function TKohonen.ReadFromXMLStream (InStream: TStream; DataID: string): boolean;
(******************************************************************************
  ENTRY: InStream ....... text stream to be read (reads from current position)
         DataID ......... if not empty: InStream is read until "id" attribute of <kohonen>
                                tag matches DataID
                          if empty: next <kohonen> of InStream is read (disregarding
                                the "id" attribute

  EXIT:  report list view is configured and filled according to the data stored
         as <kohonen> XML tag. The function returns TRUE if a valid <kohonen>
         tag has been found.
 ******************************************************************************)

var
  astr   : string;
  id     : string;
  found  : boolean;
  ix, iy : longint;
  iz     : longint;
  done   : integer;
  xmltag : TKohonenXMLTag;
  cont   : string;
  attr   : string;
  eos    : boolean;


begin
FMatsAdj := false;
result := false;
DataID := lowercase(DataID);
eos := false;
repeat
  astr := readlnStream (InStream, eos, 0);
  astr := lowercase(astr);
  ix := pos ('<kohonen', astr);
  found := (ix > 0);
  if found then
    found := (pos('sdlcsuite', astr) > 0);
  if found and (DataID <> '') then
    begin
    id := '';
    iy := pos ('id="', astr);
    if iy > 0 then
      begin
      iz := NumberedPos ('"', astr, iy, 2, false);
      id := StripLtBlanks(copy(astr, iy+4, iz-iy-4));
      end;
    if (id <> DataId) then
      found := false;
    end;
until found or eos;
if found then
  begin
  done := 0;
  while (done = 0) do
    begin
    xmltag := TKohonenXMLTag(ReadNextTagInStream (InStream, xmlTagIds, attr, cont));
    done := ProcessXmlTag (xmlTag, attr, cont);
    end;
  if done = 1 then
    result := true;
  end;
end;


(******************************************************************************)
function TKohonen.ReadFromOpenXMLFile (var InFile: TextFile; DataID: string): boolean;
(******************************************************************************
  ENTRY: InFile ......... text file to be read (must be already open)
         DataID ......... if not empty: InFile is read until "id" attribute of <kohonen>
                                tag matches DataID
                          if empty: next <kohonen> of InFile is read (disregarding
                                the "id" attribute

  EXIT:  report list view is configured and filled according to the data stored
         as <kohonen> XML tag. The function returns TRUE if a valid <kohonen>
         tag has been found.
 ******************************************************************************)


var
  astr   : string;
  id     : string;
  found  : boolean;
  ix, iy : longint;
  iz     : longint;
  done   : integer;
  xmltag : TKohonenXmlTag;
  cont   : string;
  attr   : string;

begin
result := false;
DataID := lowercase(DataID);
repeat
  readln (InFile, astr);
  astr := lowercase(astr);
  ix := pos ('<kohonen', astr);
  found := (ix > 0);
  if found then
    found := (pos('sdlcsuite', astr) > 0);
  if found and (DataID <> '') then
    begin
    id := '';
    iy := pos ('id="', astr);
    if iy > 0 then
      begin
      iz := NumberedPos ('"', astr, iy, 2, false);
      id := StripLtBlanks(copy(astr, iy+4, iz-iy-4));
      end;
    if (id <> DataId) then
      found := false;
    end;
until found or eof(InFile);

if found then
  begin
  done := 0;
  while (done = 0) do
    begin
    xmltag := TKohonenXMLTag(ReadNextTagInTextfile (InFile, xmlTagIds, attr, cont));
    done := ProcessXmlTag (xmlTag, attr, cont);
    end;
  if done = 1 then
    result := true;
  end;
end;


(******************************************************************************)
function TKohonen.LoadFromXMLFile (FName: string; DataID: string): boolean;
(******************************************************************************)

var
  TFile : TextFile;

begin
result := false;
assignfile (TFile, FName);
{$I-}reset (TFile);{$I+}
if IOResult = 0 then
  begin
  result := ReadFromOpenXMLFile (TFile, DataID);
  closeFile (TFile);
  end;
end;



(******************************************************************************)
procedure Register;
(******************************************************************************)

begin
RegisterComponents ('SDL', [TKohonen]);
end;

end.




