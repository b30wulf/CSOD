unit cstruct;

(******************************************************************)
(*                                                                *)
(*                         C S T R U C T                          *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1991..2001 H. Lohninger                    June 1996   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jul-27, 2001                                  *)
(*                                                                *)
(******************************************************************)

{Revision History:

1.0   [1991]
      first implementation (Turbo Pascal)

1.x   [1991..1996]
      many releases for Turbo Pascal

2.x   [Jun-17, 1996]
      CStruct is now internally available for Delphi 1.0 ... Delphi 4.0

5.0   [Oct-02, 1999]
      CStruct is now part of the SDL Component Suite
      available for BCB 3 and 4 and for Delphi 3, 4 and 5

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      changed event is now issued in several additional methods
      bug fix in SearchSubStruc which caused wrong results with condensed rings of integer multiples of ring members
      bug fix in SearchSubStruc: MatchedAtoms are now set correctly after Search
      WriteToMDLCTabStream, WriteToMDLMolStream, ReadFromMDLCTabStream and ReadFromMDLMolStream implemented
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

{------------------------------------------------------------------}
interface
{------------------------------------------------------------------}

uses
  SysUtils, WinTypes, WinProcs, Messages, classes, graphics, cdata, cform,
  matrix;



const
  MaxLengCTab = 63;              { maximal number of Atoms in Ctab }
  MaxConn = 10;            { maximal number of connections allowed }
  MaxConnOld = 8;          { maximal number of connections allowed }
  MaxRings = 100;          { maximal number of rings in a molecule }
  MaxRingSize = 64;              { number of atoms of largest ring }
  MaxDim = 3;                      { number of graphics dimensions }

  AttribLin = $01;        { attribute codes of atoms: linear chain }
  Attrib347R = $02;          { ring of 3 or 4 or more than 6 atoms }
  Attrib5R = $04;                                { ring of 5 atoms }
  Attrib6R = $08;                                { ring of 6 atoms }
  AttribBranch = $10;                             { branching atom }
  AttribAnyR = $20;                                     { any ring }
  AttribTerm = $40;                             { terminating atom }
  AttribCondR = $80;                         { condensed ring atom }
  AttribNone = $00;                                 { no attribute }

  btNoBond = 0;                              { bond types: no bond }
  btSingle = 1;                                      { single bond }
  btDouble = 2;                                      { double bond }
  btTriple = 3;                                      { triple bond }
  btAromatic = 4;                                  { aromatic bond }

{------------- these few lines are provisional and have been included ----}
{--- to get a quick solution to the MDL-SD-file problem ------------------}
const
  MaxProps = 20;      { PROVISIONAL !! (see below) }
type
  TPropRec = record   { physical properties as read from MDL SD file }
               ID  : string[15]; { PROVISIONAL ! clear up things concerning MDL-SD later }
               Par : double;
             end;
  TProps = array[1..MaxProps] of TPropRec;
{-------------------------------------------------------------------------}


type
  SSSMode = (smSkeleton, smAtoms, smBonds, smAtomAndBonds);  (* mode of sub structure search *)
  FrgType = (NSglBnd, (* number of single bonds in molecule, aromat. not counted *)
             NCCSgl,  (* number of C-C single bonds, aromat. not counted *)
             NDblBnd, (* number of double bonds in molecule, aromat. not counted *)
             NCCDbl,  (* number of C-C double bonds, aromat. not counted *)
             NTrplBnd,(* number of triple bonds in molecule *)
             NCCTrpl, (* number of C-C triple bonds *)
             NAroBnd, (* number of aromatic bonds *)
             NBranch, (* number of branching atoms *)
             XCnt,    (* number of halogen atoms in molecule *)
             COOH,   (* carbonic acid *)
             COO,    (* any -CO-O- group, no matter where, but not a COOH *)
             NO2,    (* any nitro group *)
             AnyCO,  (* any carbonyl group *)
             AroCl,  (* aromatic chlorine atome *)
             AroBr,  (* aromatic bromine atome *)
             AnyOH,  (* any hydroxyl group *)
             PhOH,   (* phenolic OH *)
             NH2,    (* terminal amino group - primary amine *)
             NHR,    (* secondary amine *)
             NR2,    (* tertiary amine *)
             NCON,   (* urea derivative *)
             CN,     (* nitrile *)
             CONR2,  (* amide *)
             CHO,    (* aldehyde *)
             COX,    (* halogen acid *)
             AnySO,  (* any sulfoxide group *)
             OCH3,   (* methoxy group *)
             NO,     (* nitroso group *)
             NNH2);    (* -NH-NH2 or -N=NH  *)
  AtListType = record
                 NrAtoms : integer;
                 AtList  : array [1..MaxLengCTab] of integer;
               end;
  AtFlagType = array[1..MaxLengCTab] of byte;
  BondListType = array[1..MaxConn] of byte;
  RingType = record
               RingSize : byte;           (* size of ring *)
               AtList   : array[1..MaxRingSize] of byte; (* numbers of atoms in ring *)
             end;
  RingListType = record
                   NrOfRings : integer;   (* number of valid rings in the ring list *)
                   RList     : array [1..MaxRings] of RingType;  (* list of rings *)
                 end;

  CoordUnitType = (cuUnknown, cuPixel, cuNanoM, cuPicoM, cuAngstrom);

  CTElem = record
             AtNum    : byte;                        (* atom number *)
             AtWeight : byte;                        (* atomic weight of that atom *)
             AtFlag   : byte;                        (* arbitrary working byte *)
             Attrib   : byte;                        (* attributes of atom *)
             Charge   : shortint;                    (* number of charges *)
             ConnTo   : BondListType;                (* connected atoms *)
             TypConn  : BondListType;                (* type of connection *)
             Coords   : array[1..MaxDim] of single;  (* 3D-graphics info *)
             AtDispAtb: longint;                     (* display attributes used in TChemGraph *)
           end;
                            { TypConn : 1 = single bond
                                        2 = double bond
                                        3 = tripple bond
                                        4 = aromatic bond }
                             { Attrib : Bit 0 = linear
                                        Bit 1 = 3- or 4-atom ring, or more than 6 atoms
                                        Bit 2 = 5-atom ring
                                        Bit 3 = 6-atom ring
                                        Bit 4 = branch
                                        Bit 5 = any ring atom
                                        Bit 6 = terminating atom
                                        Bit 7 = condensed ring system }
                          { AtDispAtb : Bits 0..25 .... color of atom when displayed
                                        Bits 26..27 .... reserved
                                        Bit 28 .... atom has to be displayed in bold
                                        Bit 29 .... atom has to be displayed by inverted colors
                                        Bit 30 .... atom has to be displayed in italic letters
                                        Bit 31 .... atom has to be displayed with structure default color }

  TCTab = class (TObject)
          private
            FOnChange     : TNotifyEvent;
            function  GetNBonds (AtIx: integer): integer;
            function  GetAtNum (AtIx: integer): byte;
            procedure SetAtNum (AtIx: integer; AtNum: byte);
            function  GetAtWeight (AtIx: integer): byte;
            procedure SetAtWeight (AtIx: integer; AtWeight: byte);
            function  GetCharge (AtIx: integer): shortint;
            procedure SetCharge (AtIx: integer; Charge: shortint);
            function  GetAtomEntries (AtIx: integer): CTElem;
            procedure SetAtomEntries (AtIx: integer; AE: CTElem);
            function  GetAtFlag (AtIx: integer): byte;
            procedure SetAtFlag (AtIx: integer; AtFlag: byte);
            function  GetAttrib (AtIx: integer): byte;
            procedure SetAttrib (AtIx: integer; Attrib: byte);
            function  GetCoords (AtIx, DimIx: integer): single;
            procedure SetCoords (AtIx, DimIx: integer; Coord: single);
            function  GetCoordsPresent: boolean;
            procedure SetCoordsPresent (value: boolean);
            function  GetConnTo (AtIx: integer; ConnIx: integer): byte;
            procedure SetConnTo (AtIx, ConnIx: integer; ConnTo: byte);
            function  GetTypConn (AtIx: integer; ConnIx: integer): byte;
            procedure SetTypConn (AtIx: integer; ConnIx: integer; Typ: byte);
            function  GetCASNr: string;
            procedure SetCASNr (InString: string);
            function  CheckCASNr (CASNum: longint): boolean;
          protected
            FNumValidAtoms: integer;  (* number of valid atoms *)
            FStrucName    : string;       (* name of structure *)
            FCASNr        : longint;                         { CAS registry number }
            FCoordUnit    : CoordUnitType;            { units of coordinate values }
            FAtomEntries  : array[1..MaxLengCTab] of CTElem;  (* AtomEntries in CTab *)
          public
            constructor Create;
            destructor  Destroy; override;
            function  AddAtom (AtomRec: CTElem): boolean;
            function  AtomCount (AtNum: byte): integer;
            function  CalcAttributes: integer;
            function  CalcMissingH: integer;
            function  CalcMolExtents (var MinX, MinY, MaxX, MAxY, CentX, CentY: double): double;
            procedure CalcMolCenter (var spx, spy, spz: double);
            function  CalcMolecularFormula (var BForm: TFormulaRec): boolean;
            function  CalcChemMolWeight: double;
            procedure Changed;
            function  CheckConnect (At1,At2: integer): byte;
            procedure ClearAttributes;
            procedure Clear;
            function  CompareWith (CTabSource: TCTab): word;
            procedure CopyFrom (CTabSource: TCTab);
            procedure DeleteAtom (AtomNr: integer);
            function  FindAtomInBox (x, y, z, XRange, YRange, ZRange: double): integer;
            procedure FindClosestAtom (x,y,z: double; var ClosestAtom: integer; var Dist: double);
            function  ContainsUnconnectedAtom: boolean;
            procedure EnterConn (AtIx, Connto, TypConn: integer);
            function  FindNextEndAtom (AtIx: integer): integer;
            function  FindShortestRings (AtomIx: word;
                        var RingList: RingListType): integer;
            function  FindSSSR (var RingList: RingListType): integer;
            function  FragmentCount (FrgCode: FrgType): integer;
            function  FragmentCode (AtIx: integer;
                        var NOuterBonds: integer): longint;
            procedure JoinFragment (CTabSource: TCTab);
            procedure LinkFragment (CtabSource: TCTab);
            function  MakeConnection (At1,At2: integer; CType: byte): boolean;
            procedure MakeSymmetricConnections;
            function  MaxNBonds (var AtIx: integer):integer;
            procedure MatchAtomTemplate (An, Nb: shortint; TypB: BondListType;
                          var AtomsMatched: AtListType);
            function  NrHAtoms (AtIx: integer): integer;
            function  ReadFromClearTextFile (var AFile: textFile): boolean;
            function  ReadFromClearTextFileCTABG (var AFile:TextFile): boolean;
            function  ReadFromMDLCTabFile (var AFile:TextFile): boolean;
            function  ReadFromMDLCTabStream (InStream: TStream): boolean;
            function  ReadFromMDLMolStream (InStream: TStream): boolean;
            function  ReadFromMDLMolFile (var AFile:TextFile): boolean;
            function  ReadFromMDLSDFile (var AFile:TextFile; var Props: TProps): boolean;
            function  ReadConnTabBody (var AFile:TextFile): boolean;
            procedure RemoveHydrogen;
            function  RingsInMolecule: integer;
            procedure RotateWithPCA;
            function  SearchSubStruc (CTabSmall: TCTab; var MatchedAtoms: AtFlagType;
                          CompareBonds: boolean): boolean;
            function  StripfromChains: integer;
            function  SumForContained (CTabSmall: TCTab): boolean;
            procedure WriteToClearTextFile (var AFile:TextFile);
            procedure WriteToMDLCTabFile (var TFile:TextFile);
            procedure WriteToMDLCTabStream (OutStream: TStream);
            procedure WriteToMDLMolFile (var TFile:TextFile; User: ShortString;
                                          ProgName: string; Regnum: longint;
                                          comment: string);
            procedure WriteToMDLMolStream (OutStream: TStream; User: ShortString;
                                          ProgName: string; Regnum: longint;
                                          comment: string);
            procedure WriteToMolConnXFile (IdNum: integer; var AFile:TextFile);

            property  OnChange: TNotifyEvent read FOnChange write FOnChange;

            property  AtAttrib [AtIx: integer]: byte read GetAttrib write SetAttrib;
            property  AtCharge [AtIx: integer]: shortint read GetCharge write SetCharge;
            property  AtCoords [AtIx, DimIx: integer]: single read GetCoords write SetCoords;
            property  AtConnTo [AtIx, ConnIx: integer]: byte read GetConnTo write SetConnTo;
            property  AtTypConn [AtIx, ConnIx: integer]: byte read GetTypConn write SetTypConn;
            property  AtFlag [AtIx: integer]: byte read GetAtFlag write SetAtFlag;
            property  AtNum [AtIx: integer]: byte read GetAtNum write SetAtNum;
            property  AtWeight [AtIx: integer]: byte read GetAtWeight write SetAtWeight;
            property  AtomEntries [AtIx: integer]: CTElem read GetAtomEntries write SetAtomEntries;
            property  BinCASNr: longint read FCASNr write FCASNr;
            property  CASNr: string read GetCASNr write SetCASNr;
            property  CoordinatesPresent: boolean read GetCoordsPresent write SetCoordsPresent;
            property  NAtoms: integer read FNumValidAtoms write FNumValidAtoms;
            property  NBonds [AtIx: integer]: integer read GetNBonds;
            property  StrucName: string read FStrucName write FStrucName;
            property  CoordUnits: CoordUnitType read FCoordUnit write FCoordUnit;
          end;

  procedure ClearCTElem
         (var AtomRec : CTElem);
  function  RingInRingList
                (Ring : RingType;
             RingList : RingListType)
                      : boolean;
  function FragmentStr
              (InCode : longint)
                      : string;


{------------------------------------------------------------------}
implementation
{------------------------------------------------------------------}

uses
  math1, math2, stringl, streams, vector{$IFDEF SHAREWARE}, dialogs {$ENDIF};

const
  FrgCodeAtoms : array[1..15] of integer =  (* valid atoms in fragment code *)
                 (1,   (* H *)
                  5,   (* B *)
                  6,   (* C *)
                  7,   (* N *)
                  8,   (* O *)
                  9,   (* F *)
                 14,   (* Si *)
                 15,   (* P *)
                 16,   (* S *)
                 17,   (* Cl *)
                 33,   (* As *)
                 35,   (* Br *)
                 50,   (* Sn *)
                 53,   (* I *)
                  0);  (* reserved *)
  FrgCodeSymb: array[1..15] of string[2] =  (* corresponding atom symbols *)
                 ('H', 'B', 'C', 'N', 'O', 'F', 'Si', 'P',
                  'S', 'Cl', 'As', 'Br', 'Sn', 'I', 'RR');

  MaxMissH = 13;               { list of valence bonds of most important atoms }
  MissingH : array[1..MaxMissH,1..2] of byte =
                                     ((1,1),   { H }
                                      (5,3),   { B }
                                      (6,4),   { C }
                                      (7,3),   { N }
                                      (8,2),   { O }
                                      (9,1),   { F }
                                      (14,4),  { Si }
                                      (15,3),  { P }
                                      (16,2),  { S }
                                      (17,1),  { Cl }
                                      (32,4),  { Ge }
                                      (35,1),  { Br }
                                      (53,1)); { I }

type
  EightBytes = array[1..8] of byte;

{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\cstruct_ct.inc}
{$ENDIF}

(***********************************************************************)
procedure TCTab.Changed;
(***********************************************************************)

begin
if Assigned(FOnChange) then
  FOnChange(Self);
end;



(***************************************************************)
function TCTab.CompareWith (CTabSource: TCTab): word;
(***************************************************************
  ENTRY:   connection table self
           CTabSource .... structure to be compared to self

  EXIT:    function returns a code which indicates that one ore more
           of the following items do not match:
             $0000 ... structures do match
             $0001 ... FNumValidAtoms
             $0002 ... FStrucName
             $0004 ... FCoordUnit
             $0008 ... FCASNr
             $0010 ... AtNum
             $0020 ... AtWeight
             $0040 ... AtFlag
             $0080 ... Attrib
             $0100 ... Charge
             $0200 ... Coords[1] = x-Coords
             $0400 ... Coords[2] = y-Coords
             $0800 ... Coords[3] = z-Coords
             $1000 ... ConnTo
             $2000 ... TypConn
 ***************************************************************)

var
  i,j   : integer;
  wError: word;

begin
wError:= 0;
if FNumValidAtoms <> CTabSource.FNumValidAtoms then
  wError:= (wError) or ($0001);
if (uppercase(FStrucName)) <> (uppercase(CTabSource.FStrucName)) then
  wError:= (wError) or ($0002);
if FCoordUnit <> CtabSource.FCoordUnit then
  wError:= (wError) or ($0004);
if FCASNr <> CTabSource.FCASNr then
  wError:= (wError) or ($0008);
for i:=1 to MaxLengCTab do
  begin
  if AtomEntries[i].AtNum <> CTabSource.AtomEntries[i].AtNum
    then wError:= (wError) or ($0010);
  if AtomEntries[i].AtWeight <> CTabSource.AtomEntries[i].Atweight
    then wError:= (wError) or ($0020);
  if AtomEntries[i].AtFlag <> CTabSource.AtomEntries[i].AtFlag
    then wError:= (wError) or ($0040);
  if AtomEntries[i].Attrib <> CTabSource.AtomEntries[i].Attrib
    then wError:= (wError) or ($0080);
  if AtomEntries[i].Charge <> CTabSource.AtomEntries[i].Charge
    then wError:= (wError) or ($0100);
  if AtomEntries[i].Coords[1] <> CTabSource.AtomEntries[i].Coords[1]
    then wError:= (wError) or ($0200);
  if AtomEntries[i].Coords[2] <> CTabSource.AtomEntries[i].Coords[2]
    then wError:= (wError) or ($0400);
  if AtomEntries[i].Coords[3] <> CTabSource.AtomEntries[i].Coords[3]
    then wError:= (wError) or ($0800);
  for j:=1 to MaxConn do
    begin
    if AtomEntries[i].Connto[j] <> CTabSource.AtomEntries[i].Connto[j]
      then wError:= (wError) or ($1000);
    if AtomEntries[i].TypConn[j] <> CTabSource.AtomEntries[i].TypConn[j]
      then wError:= (wError) or ($2000);
    end;
  end;
CompareWith:= wError;
end;



(***************************************************************)
function TCTab.ContainsUnconnectedAtom: boolean;
(***************************************************************
 function has been renamed (formerly "IncludesNotConnectedAtom")
 ***************************************************************)

var
  i : integer;
  nc: boolean;

begin
nc:= false;
for i:= 1 to FNumValidAtoms do
  if (NBonds [i] = 0) then
    nc:= true;
ContainsUnConnectedAtom:= nc;
end;




(***************************************************************)
procedure TCTab.RemoveHydrogen;
(***************************************************************
  EXIT:    all hydrogen atoms are removed from the structure
 ***************************************************************)

var
  AtIx : integer;

begin
AtIx := 1;
while (AtIx <= FNumValidAtoms) do
  begin
  if AtomEntries[AtIx].AtNum = 1
    then DeleteAtom(AtIx)
    else inc (AtIx);
  end;
end;



(***************************************************************)
function TCTab.GetCoordsPresent: boolean;
(***************************************************************)

var
  i, j   : integer;
  present: boolean;

begin
present:= false;
i:=0;
while (i < FNumValidAtoms) and not present do
  begin
  inc (i);
  for j:=1 to 3 do
    if FAtomEntries[i].Coords[j] <> 0 then
      present:= true;
  end;
GetCoordsPresent:= present;
end;


(***************************************************************)
procedure TCTab.SetCoordsPresent (value: boolean);
(***************************************************************)

var
  i, j   : integer;

begin
if not value then
  begin
  for i:=1 to FNumValidAtoms do
    begin
    for j:= 1 to 3 do
      FAtomEntries[i].Coords[j] := 0;
    end;
  Changed;
  end;
end;





(***************************************************************)
function TCTab.AtomCount (AtNum: byte): integer;
(***************************************************************
  ENTRY:   connection table
           AtNum ... atomic number to be searched for

  EXIT:    function returns the number of atoms having the atomic
           number 'AtNum'
 ***************************************************************)

var
  i     : integer;
  count : integer;

begin
count := 0;
for i:=1 to FNumValidAtoms do
  if (FAtomEntries[i].AtNum = AtNum) then
    inc (Count);
AtomCount := Count;
end;


(***************************************************************)
function TCTab.FragmentCode (AtIx: integer;
                            var NOuterBonds: integer): longint;
(***************************************************************
  ENTRY:   connection table
           AtIx ...... atom number of central atom

  EXIT:    NOuterBonds ... number of bonds of non-central atoms to
                           surrounding atoms
           function returns a binary fragment code if result is
           positive, or a negative value indicating an error:
              -1 ... invalid atom in structure
              -2 ... invalid bond in structure

  REMARK:  bit assignment of fragment code:
             31.............1615.....87...3..0
              ERRR-a4-b4-a3-b3-a2-b2-a1-b1cent
           E = error bit
           R = reserved
           cent = central atom
           atoms are coded according to 'FrgCodeAtoms'
           bonds are coded with ('FAtomEntries.TypConn' and 03)
 ***************************************************************)


const
  NumNbcd = 8;

var
  i, j      : integer;
  fc        : longint;
  error     : longint;
  neighbcd  : array[1..NumNbCd] of longint;
  at        : integer;
  nb        : integer;

begin
NOuterBonds := 0;
error := 0;
i := 0;
fc := 0;
At := FAtomEntries[AtIx].AtNum;    (* insert central atom *)
repeat
  inc (i);
until ((At = FrgCodeAtoms[i]) or (i >= 15));
if (At <> FrgCodeAtoms[i])
  then error := -1
  else begin
       fc := i;
       nb := NBonds[AtIx];
       for i:=1 to NumNbCd do
         neighbcd[i] := 0;
       for i:=1 to nb do                    (* calculate neighbor codes *)
         begin
         NOuterBonds := NOuterBonds + NBonds[FAtomEntries[AtIx].ConnTo[i]] - 1;
         neighbcd[i] := FAtomEntries[AtIx].TypConn[i] and $03;
         j := 0;
         At := FAtomEntries[FAtomEntries[AtIx].ConnTo[i]].AtNum;
         repeat
           inc (j);
         until ((At = FrgCodeAtoms[j]) or (j >= 15));
         if (At <> FrgCodeAtoms[j])
           then error := -1
           else neighbcd[i] := neighbcd[i] + 4*j;
         end;
       if error = 0 then
         begin
         SortArray (addr(neighbcd), NumNbCd, lnum, false);  (* sort descending *)
         if nb > 4
           then error := -2  (* too many bonds *)
           else for j:=1 to nb do                         (* insert neighbor codes *)
                  fc := fc + (neighbcd[j] shl (j*6-2));
         end;
       end;
if error = 0
  then FragmentCode := fc
  else FragmentCode := error;
end;


(***************************************************************)
function FragmentStr (InCode: longint): string;
(***************************************************************
  ENTRY:   InCode .... 32 bit fragment code (produced by TCTab.FragmentCode)

  EXIT:    function returns an ASCII string
 ***************************************************************)

const
  BcSymb : array[0..3] of char = ('4','1','2','3');

var
  hstr   : string;
  i      : integer;
  ac, bc : integer;

begin
if InCode < 0
  then hstr := 'ERROR'
  else begin
       hstr := FrgCodeSymb [InCode and $0000000F];
       Incode := Incode shr 4;
       for i:=1 to 4 do
         if Incode <> 0 then
           begin
           bc := InCode and $00000003;
           InCode := Incode shr 2;
           ac := Incode and $0000000F;
           InCode := Incode shr 4;
           hstr := hstr + BcSymb[bc] + FrgCodeSymb[ac];
           end;
       end;
FragmentStr := hstr;
end;


(***************************************************************)
function TCTab.FragmentCount (FrgCode: FrgType): integer;
(***************************************************************
  ENTRY:   connection table
           FrgCode ... code of predefined fragment to be searched

  EXIT:    function returns number of fragments of type FrgCode found
 ***************************************************************)

var
  count   : integer;
  i,j     : integer;
  found   : boolean;
  na      : integer;
  nb      : integer;
  ODblCnt : integer;
  NSglCnt : integer;
  OSglCnt : integer;  {%T.Kolber%}
  NCharge : boolean;  {%T.Kolber%}
  AtN1 : byte;  {%T.Kolber%}
  AtN2 : byte;  {%T.Kolber%}

begin
count := 0;
case FrgCode of
 NDblBnd : begin      (* number of double bonds between any atoms *)
           for i:=1 to FNumValidAtoms do
             for j:=1 to NBonds[i] do
               if FAtomEntries[i].TypConn[j] = btDouble then
                 inc (Count);
           count := count div 2;
           end;
 NSglBnd : begin      (* number of single bonds between any atoms *)
           for i:=1 to FNumValidAtoms do
             for j:=1 to NBonds[i] do
               if FAtomEntries[i].TypConn[j] = btSingle then
                 inc (Count);
           count := count div 2;
           end;
 NBranch : begin      (* number of branching atoms *)
           for i:=1 to FNumValidAtoms do
             if NBonds[i] > 2 then
               inc (Count);
           end;
 NTrplBnd: begin      (* number of triple bonds between any atoms *)
           for i:=1 to FNumValidAtoms do
             for j:=1 to NBonds[i] do
               if FAtomEntries[i].TypConn[j] = btTriple then
                 inc (Count);
           count := count div 2;
           end;
  NAroBnd: begin      (* number of aromatic bonds between any atoms *)
           for i:=1 to FNumValidAtoms do
             for j:=1 to NBonds[i] do
               if FAtomEntries[i].TypConn[j] = btAromatic then
                 inc (Count);
           count := count div 2;
           end;
  NCCSgl : begin      (* number of single bonds between C atoms *)
           for i:=1 to FNumValidAtoms do
             begin
             if FAtomEntries[i].AtNum = 6 then
               begin
               for j:=1 to NBonds[i] do
                 if (FAtomEntries[i].TypConn[j] = BtSingle) and (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 6) then
                   inc (Count);
               end;
             end;
           count := count div 2;
           end;
  NCCDbl : begin      (* number of double bonds between C atoms *)
           for i:=1 to FNumValidAtoms do
             begin
             if FAtomEntries[i].AtNum = 6 then
               begin
               for j:=1 to NBonds[i] do
                 if (FAtomEntries[i].TypConn[j] = btDouble) and (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 6) then
                   inc (Count);
               end;
             end;
           count := count div 2;
           end;
  NCCTrpl: begin      (* number of triple bonds between C atoms *)
           for i:=1 to FNumValidAtoms do
             begin
             if FAtomEntries[i].AtNum = 6 then
               begin
               for j:=1 to NBonds[i] do
                 if (FAtomEntries[i].TypConn[j] = btTriple) and (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 6) then
                   inc (Count);
               end;
             end;
           count := count div 2;
           end;
  XCnt   : begin                         (* number of Cl and Br in molecule *)
           for i:=1 to FNumValidAtoms do
             if (FAtomEntries[i].AtNum = 17) or
                (FAtomEntries[i].AtNum = 35) then
               inc (Count);
           end;
  AroCl  : begin
           for i:=1 to FNumValidAtoms do
             begin
             if (FAtomEntries[i].AtNum = 17) then
               begin
               na := FAtomEntries[i].ConnTo[1];
               j := 0;
               Found := False;
               repeat
                  inc (j);
                  if(FAtomEntries[na].Connto[j] <> 0)
                    then if FAtomEntries[na].TypConn[j] = 4
                            then Found := True;
               until (j = 10) or found;
               if Found then
                 inc (Count);
               end;
             end;
           end;
  AroBr  : begin
           for i:=1 to FNumValidAtoms do
             begin
             if (FAtomEntries[i].AtNum = 35) then
               begin
               na := FAtomEntries[i].ConnTo[1];
               j := 0;
               Found := False;
               repeat
                 inc (j);
                 if(FAtomEntries[na].Connto[j] <> 0)
                   then if FAtomEntries[na].TypConn[j] = 4
                           then Found := True;
                 until (j = 10) or Found;
               if Found then
                 inc (Count);
               end;
             end;
           end;
  COOH   : begin
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 6) and (NBonds[i] = 3)) then (* C atom, 3 neighbors ? *)
               begin
               found := false;
               for j:=1 to 3 do                               (* look for carbonyl *)
                 if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                    (FAtomEntries[i].TypConn[j] = btDouble) then
                   found := True;
               if found then
                 begin
                 found := false;
                 for j:=1 to 3 do                               (* look for hydroxyl *)
                   if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                      (FAtomEntries[i].TypConn[j] = btSingle) and
                      (NBonds[FAtomEntries[i].ConnTo[j]] = 1) then
                     found := True;
                 if found then
                   inc (count);
                 end;
               end;
             end;
           end;
  COO    : begin
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 6) and (NBonds[i] = 3)) then (* C atom, 3 neighbors ? *)
               begin
               found := false;
               for j:=1 to 3 do                               (* look for carbonyl *)
                 if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                    (FAtomEntries[i].TypConn[j] = btDouble) then
                   found := True;
               if found then
                 begin
                 found := false;
                 for j:=1 to 3 do                               (* look for hydroxyl *)
                   if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                      (FAtomEntries[i].TypConn[j] = btSingle) and
                      (NBonds[FAtomEntries[i].ConnTo[j]] > 1) then
                     found := True;
                 if found then
                   inc (count);
                 end;
               end;
             end;
           end;
  NO2    : begin   (* any nitro group *)
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 7) and (NBonds[i] = 3)) then (* N atom, 3 neighbors ? *)
               begin
               ODblCnt := 0;
               OSglCnt := 0;
               NCharge:= false;
               if (FAtomEntries[i].Charge = 3)   (* 3 means a charge of +1 *)
                 then NCharge:= true;
               for j:=1 to 3 do
                 begin                             (* look for oxygen *)
                 if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                    (FAtomEntries[i].TypConn[j] = 2) then
                   inc (ODblCnt);
                 if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                    (FAtomEntries[i].TypConn[j] = 1)  (* look for charged NO2 *)
                    then inc (OSglCnt);
                 end;
               if (ODblCnt = 2) or
                  ((OSglCnt = 1) and (ODblCnt = 1) and (NCharge = true))
                 then  inc (count);
               end;
             end;
           end;
  NCON   : begin   (* urea derivative  *)
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 6) and (NBonds[i] = 3)) then (* C atom, 3 neighbors ? *)
               begin
               OdblCnt := 0;
               for j:=1 to 3 do         (* look for CO *)
                 if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                    (FAtomEntries[i].TypConn[j] = btDouble) then
                   inc (ODblCnt);
               if ODblCnt = 1 then   (* exactly one double bond *)
                 begin
                 NSglCnt := 0;
                 for j:=1 to 3 do       (* look for N single bond *)
                   if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 7) and
                      (FAtomEntries[i].TypConn[j] = btSingle) then
                     inc (NSglCnt);
                 if NSglCnt = 2 then
                   inc (count);
                 end;
               end;
             end;
           end;
  AnyCO  : begin   (* any carbonyl group *)
           for i:=1 to FNumValidAtoms do
             begin
             nb := NBonds[i];
             if ((FAtomEntries[i].AtNum = 6) and (nb <= 3)) then (* C atom, max. 3 neighbors ? *)
               begin
               found := false;
               for j:=1 to nb do                               (* look for carbonyl *)
                 if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                    (FAtomEntries[i].TypConn[j] = btDouble) then
                   found := True;
               if found then
                 inc (count);
               end;
             end;
           end;
  PhOH   : begin
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 8) and (NBonds[i] = 1)) then (* terminal O ? *)
               begin
               Found := False;
               na := FAtomEntries[i].ConnTo[1];
               if (FAtomEntries[na].AtNum = 6) and
                  (FAtomEntries[i].TypConn[1] = btSingle) then     (* OH connected to aromatic C ? *)
                 begin
                 j := 1;
                 while ((FAtomEntries[na].Connto[j] <> 0) and (j <= MaxConn)) do
                   begin
                   if FAtomEntries[na].TypConn[j] = btAromatic then
                     found := True;
                   inc (j);
                   end;
                 end;
               if Found then
                 inc (Count);
               end;
             end;
           end;
  NH2    : begin                 {%T.Kolber% modified}         (* primary amine *)
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 7) and (NBonds[i] = 1)) (* terminal N ? *)
             then begin
                  if FAtomEntries[i].TypConn[1] = 1    (* = Single bond *)
                  then begin
                       if FAtomEntries[FAtomEntries[i].ConnTo[1]].AtNum <> 7  (* no Hydrazides *)
                       then begin
                             found := false;
                             AtN1:= FAtomEntries[i].ConnTo[1];
                             na:= NBonds [AtN1];
                             for j:=1 to na do               (* look for amide *)
                              if (FAtomEntries[AtN1].AtNum = 6) and
                                 (FAtomEntries[FAtomEntries[AtN1].ConnTo[j]].AtNum = 8) and
                                 (FAtomEntries[AtN1].TypConn[j] = 2)
                                then  found := True;
                             if not found then inc (Count);
                            end;
                       end;
                  end;
             end;
           end;
  NHR    : begin                    {%T.Kolber%}      (* secondary amine *)
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 7) and (NBonds[i] = 2)) (* N with 2 bonds *)
             then begin
                  if (FAtomEntries[i].TypConn[1] = 1) and
                     (FAtomEntries[i].TypConn[2] = 1)    (* = 2 Single bonds *)
                  then begin
                       AtN1:= FAtomEntries[i].ConnTo[1];
                       AtN2:= FAtomEntries[i].ConnTo[2];
                       if (FAtomEntries[AtN1].AtNum <> 7) and  (* no Hydrazides *)
                          (FAtomEntries[AtN2].AtNum <> 7)
                       then begin
                             found := false;
                             na:= NBonds [AtN1];
                             for j:=1 to na do               (* look for amide *)
                              if (FAtomEntries[AtN1].AtNum = 6) and
                                 (FAtomEntries[FAtomEntries[AtN1].ConnTo[j]].AtNum = 8) and
                                 (FAtomEntries[AtN1].TypConn[j] = 2)
                                then  found := True;
                             na:= NBonds [AtN2];
                             for j:= 1 to na do
                              if (FAtomEntries[AtN2].AtNum = 6) and
                                 (FAtomEntries[FAtomEntries[AtN2].ConnTo[j]].AtNum = 8) and
                                 (FAtomEntries[AtN2].TypConn[j] = 2)
                                then  found := True;
                             if (not found)
                                then inc (Count);
                            end;
                       end;
                  end;
             end;
           end;
  NR2    : begin                    {%T.Kolber%}      (* tertiary amine *)
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 7) and (NBonds[i] = 3)) (* N with 3 bonds *)
             then begin
                  if (FAtomEntries[i].TypConn[1] = 1) and
                     (FAtomEntries[i].TypConn[2] = 1) and
                     (FAtomEntries[i].TypConn[3] = 1)      (* = 3 Single bonds *)
                  then begin
                       if (FAtomEntries[FAtomEntries[i].ConnTo[1]].AtNum <> 7) and  (* no Hydrazides *)
                          (FAtomEntries[FAtomEntries[i].ConnTo[2]].AtNum <> 7) and
                          (FAtomEntries[FAtomEntries[i].ConnTo[3]].AtNum <> 7)
                       then begin
                             found := false;
                             for AtN2:= 1 to 3 do
                               begin
                               AtN1:= FAtomEntries[FAtomEntries[i].ConnTo[AtN2]].AtNum;
                               na:= NBonds[AtN1];
                               for j:=1 to na do               (* look for amides *)
                                if ((AtN1 = 6) and
                                   (FAtomEntries[FAtomEntries[AtN1].ConnTo[j]].AtNum = 8) and
                                   (FAtomEntries[AtN1].TypConn[j] = 2))
                                  then  found := True;
                               end;
                             if not found then inc (Count);
                            end;
                       end;
                  end;
             end;
           end;
  AnyOH  : begin                          (* any hydroxyl group *)
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 8) and (NBonds[i] = 1)) then (* terminal N ? *)
               if FAtomEntries[i].TypConn[1] = btSingle then
                 inc (Count);
             end;
           end;
  CN     : begin    {%T.Kolber%}
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 6) and (Nbonds[i] = 2))(* C atom, exactly 2 neighbors *)
              then begin
                    found:= false;
                    for j:=1 to 2 do                               (* look for Trpl N *)
                     if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 7) and
                        (FAtomEntries[i].TypConn[j] = 3)
                       then found := True;
                    if found then  inc (count);
                   end;
             end;
           end;
  CONR2  : begin     {%T.Kolber%}
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 6) and (NBonds[i] = 3)) then (* C atom, 3 neighbors ? *)
               begin
               OdblCnt := 0;
               for j:=1 to 3 do         (* look for CO *)
                 if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                    (FAtomEntries[i].TypConn[j] = 2) then
                   inc (ODblCnt);
               if ODblCnt = 1 then   (* exactly one double bond *)
                 begin
                 NSglCnt := 0;
                 for j:=1 to 3 do       (* look for N single bond *)
                   if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 7) and
                      (FAtomEntries[i].TypConn[j] = 1) then
                     inc (NSglCnt);
                 if NSglCnt = 1 then
                   inc (count);
                 end;
               end;
             end;
           end;
  CHO    : begin     {%T.Kolber%}
           for i:=1 to FNumValidAtoms do
             begin
             nb := NBonds[i];
             if ((FAtomEntries[i].AtNum = 6) and (nb <= 2)) then (* C atom, max. 2 neighbors *)
               begin
               found := false;
               if not((FAtomEntries[i].TypConn[1] = 2) and (FAtomEntries[i].TypConn[2] = 2))
               then begin
                    for j:=1 to nb do                               (* look for carbonyl *)
                     if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                        (FAtomEntries[i].TypConn[j] = 2)
                       then found := True;
                    if found then  inc (count);
                    end;
               end;
             end;
           end;
  COX    : begin         {%T.Kolber%}
           for i:=1 to FNumValidAtoms do
             begin
             nb := NBonds[i];
             if ((FAtomEntries[i].AtNum = 6) and (nb <= 3)) then (* C atom, max. 3 neighbors ? *)
               begin
               found := false;
               for j:=1 to nb do                               (* look for carbonyl *)
                 if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                    (FAtomEntries[i].TypConn[j] = 2)
                  then begin
                        for na:= 1 to nb do                    (* look for halogen *)
                        begin
                         if (FAtomEntries[FAtomEntries[i].ConnTo[na]].AtNum = 17) or
                            (FAtomEntries[FAtomEntries[i].ConnTo[na]].AtNum = 35) or
                            (FAtomEntries[FAtomEntries[i].ConnTo[na]].AtNum = 53)
                            then found := True;
                        end;
                       end;
               if found then inc (count);
               end;
             end;
           end;
  AnySO  : begin   {%T.Kolber%}
           for i:=1 to FNumValidAtoms do
             begin
             nb := NBonds[i];
             if ((FAtomEntries[i].AtNum = 16) and (nb <= 3)) then (* S atom, max. 3 neighbors ? *)
               begin
               found := false;
               for j:=1 to nb do                               (* look for sulfoxyl *)
                 if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                    (FAtomEntries[i].TypConn[j] = 2) then
                   found := True;
               if found then
                 inc (count);
               end;
             end;
           end;
  OCH3   : begin       {%T.Kolber%}
           for i:=1 to FNumValidAtoms do
             begin
             if ((FAtomEntries[i].AtNum = 8) and (NBonds [i] = 2)) then (* O atom with 2 neighbors *)
                       (* a C-neighbor, which has only 1 SglBond *)
               if ((FAtomEntries[FAtomEntries[i].ConnTo[1]].AtNum = 6) and
                  (NBonds[FAtomEntries[i].ConnTo[1]] = 1)) or
                  ((FAtomEntries[FAtomEntries[i].ConnTo[2]].AtNum = 6) and
                  (NBonds[FAtomEntries[i].ConnTo[2]] = 1))
                then inc (Count);
             end;
           end;
  NO     : begin           {%T.Kolber%}
           for i:=1 to FNumValidAtoms do
             begin
             nb := NBonds [i];
             if ((FAtomEntries[i].AtNum = 7) and (nb = 2))(* N atom, exactly 2 neighbors *)
              then begin
                   found := false;
                   for j:=1 to nb do                               (* look for dbl O *)
                    if (FAtomEntries[FAtomEntries[i].ConnTo[j]].AtNum = 8) and
                       (FAtomEntries[i].TypConn[j] = 2)
                      then found := True;
                   if found then
                     inc (count);
                   end;
             end;
           end;
  NNH2   : begin               {%T.Kolber%}
           for i:=1 to FNumValidAtoms do
             begin
             nb := NBonds [i];
             if ((FAtomEntries[i].AtNum = 7) and (nb = 2)) (* N atom, exactly 2 neighbors *)
             then begin
                   AtN1:= FAtomEntries[i].ConnTo[1];
                   AtN2:= FAtomEntries[i].ConnTo[2];
                  if (FAtomEntries[i].TypConn[1] = 1) and
                     (FAtomEntries[AtN2].AtNum = 7)      and
                     (NBonds [AtN2] = 1)             and
                     (FAtomEntries[AtN2].TypConn[1] < 3)
                    then inc (count);
                  if (FAtomEntries[i].TypConn[2] = 1) and
                     (FAtomEntries[AtN1].AtNum = 7)      and
                     (NBonds [AtN1] = 1)             and
                     (FAtomEntries[AtN1].TypConn[1] < 3)
                    then inc (count);
                  end;
             end;
           end;
end;
FragmentCount := count;
end;


(***************************************************************)
function TCTab.CalcMolecularFormula (var BForm: TFormulaRec): boolean;
(***************************************************************
  ENTRY:   connection table

  EXIT:    BForm .... brutto formula
           function returns false if any problem ocurred

  REMARKS: The calculated brutto formula may yield a wrong number
           of hydrogen atoms for very exotic molecules.
 ***************************************************************)

const
  MaxEls = 10;
  ElemOrder : array[1..MaxEls] of byte =    (* precedence of elements in formula *)
                 (6,1,7,8,16,15,9,17,35,53);

var
  i, j     : integer;
  reslt    : boolean;
  AuxBForm : TFormulaRec;

begin
reslt := true;
AuxBForm.Fleng := 0;
i := CalcMissingH;
if i > 0 then
  begin
  inc (AuxBForm.FLeng);
  AuxBForm.AtNum[AuxBForm.FLeng] := 1;
  AuxBForm.AtWgt[AuxBForm.FLeng] := 1;
  AuxBForm.AtCnt[AuxBForm.FLeng] := i;
  end;
for i:=1 to FNumValidAtoms do
  if FAtomEntries[i].AtNum <> 1 then
    begin
    j := 0;
    repeat
      inc (j);
    until (((AuxBForm.AtNum[j] = FAtomEntries[i].AtNum) and
            (AuxBForm.AtWgt[j] = FAtomEntries[i].AtWeight)) or
            (j > AuxBForm.FLeng));
    if j > AuxBForm.FLeng
      then begin
           if AuxBForm.FLeng < FormMaxEl
             then begin
                  inc (AuxBForm.FLeng);
                  AuxBForm.AtNum[j] := FAtomEntries[i].AtNum;
                  AuxBForm.AtWgt[j] := FAtomEntries[i].AtWeight;
                  AuxBForm.AtCnt[j] := 1;
                  end
             else reslt := false;
           end
      else inc (AuxBForm.AtCnt[j]);
    end;
if reslt then
  begin    (* rearrange elements in standard order *)
  BForm.FLeng := 0;
  for i:=1 to MaxEls do
    begin
    j:=0;
    repeat
      inc (j);
      if AuxBForm.AtNum[j] = ElemOrder[i] then
        begin
        inc (BForm.FLeng);
        BForm.AtNum[BForm.FLeng] := AuxBForm.AtNum[j];
        BForm.AtWgt[BForm.FLeng] := AuxBForm.AtWgt[j];
        BForm.AtCnt[BForm.FLeng] := AuxBForm.AtCnt[j];
        AuxBForm.AtNum[j] := 0;
        end;
    until j=AuxBForm.FLeng;
    end;
  for j:=1 to AuxBForm.FLeng do
    begin
    if AuxBForm.AtNum[j] <> 0 then
      begin
      inc (BForm.FLeng);
      BForm.AtNum[BForm.FLeng] := AuxBForm.AtNum[j];
      BForm.AtWgt[BForm.FLeng] := AuxBForm.AtWgt[j];
      BForm.AtCnt[BForm.FLeng] := AuxBForm.AtCnt[j];
      end;
    end;
  end;
CalcMolecularFormula := reslt;
end;


(***************************************************************)
function TCTab.CalcChemMolWeight: double;
(***************************************************************
  ENTRY:   connection table

  EXIT:    chemical molecular weight

  REMARKS: the routine calculates the molecular weight by first
           inserting the missing H-atoms and then summing up the
           chemical atomic weights. This procedure may fail for
           exotic molecules ! (confer to 'CalcMissingH')
 ***************************************************************)

var
  i      : integer;
  sum    : double;

begin
sum := ChemAtWeight(1)*CalcMissingH;
for i:=1 to FNumValidAtoms do
  begin
  if FAtomEntries[i].AtNum <> 1 then
    sum := sum + ChemAtWeight(FAtomEntries[i].AtNum);
  end;
CalcChemMolWeight := sum;
end;


(***************************************************************)
function TCTab.CalcMissingH: integer;
(***************************************************************
  ENTRY:   connection table

  EXIT:    number of H atoms in molecule

  REMARKS: the routine calculates the number of hydrogen atoms
           in a given hydrogen-supressed structure. This procedure
           may fail for exotic molecules !!!!.
 ***************************************************************)


var
  i      : integer;
  sum    : integer;

begin
sum := 0;
for i:=1 to FNumValidAtoms do
  sum := sum + NrHAtoms (i);
CalcMissingH := sum;
end;



(***************************************************************)
function TCTab.NrHAtoms (AtIx: integer): integer;
(***************************************************************
  ENTRY:   connection table
           AtIx .... number of atom

  EXIT:    number of H atoms bonded to atom 'AtIx'

  REMARKS: the routine calculates the number of hydrogen atoms
           in a given hydrogen-supressed structure. This procedure
           may fail for exotic molecules !!!!.
 ***************************************************************)

var
  j,k    : integer;
  HAtoms : integer;
  nb     : integer;
  AtNum     : integer;
  MissH  : integer;
  sp3    : integer;
  IsoCyano : boolean;

begin
HAtoms := 0;
if FAtomEntries[AtIx].AtNum <> 1 then
  begin
  Nb := 0;
  sp3 := 0;
  for j:=1 to NBonds[AtIx] do
    begin
    if FAtomEntries[FAtomEntries[AtIx].ConnTo[j]].AtNum = 1 then
      inc (HAtoms);
    if FAtomEntries[AtIx].TypConn[j] = btAromatic        (* sp3 hybride ? *)
      then begin
           sp3 := 1;
           nb := nb + 1;
           end
      else nb := nb + FAtomEntries[AtIx].TypConn[j];
    end;
  AtNum := FAtomEntries[AtIx].AtNum;
  MissH := 0;
  for k:=1 to MaxMissH do
    if MissingH[k,1] = AtNum then
      MissH := MissingH[k,2];
  if MissH > sp3+nb
    then HAtoms := MissH - sp3 - nb + HAtoms + FAtomEntries[AtIx].Charge
    else begin
         IsoCyano := False;              (* check for isocyanate *)
         for k:=1 to NBonds[AtIx] do
           if FAtomEntries[AtIx].TypCOnn[k] = btTriple then
             if (FAtomEntries[FAtomEntries[AtIx].ConnTo[k]].AtNum = 6) and
                (NBonds[FAtomEntries[AtIx].ConnTo[k]] = 1) then
               IsoCyano := true;
         if (AtNum <> 7) then
           IsoCyano := False;
         if IsoCyano then
           HAtoms := -1;
         if (AtNum = 15) and (nb = 4) then       { check for phosphorous with 4 bonds }
           inc(HAtoms)
         end;
  end;
NrHAtoms := HAtoms;
end;


(***************************************************************)
procedure ClearCTElem (var AtomRec: CTElem);
(***************************************************************
  ENTRY:  AtomRec ..... record containing all parameters of one atom
  EXIT:   AtomRec ..... this record is initialized
 ***************************************************************)

var
  i : integer;

begin
AtomRec.AtNum := 0;
AtomRec.AtFlag := 0;
AtomRec.Atweight := 0;
AtomRec.Attrib := 0;
AtomRec.Charge := 0;
AtomRec.Coords[1] := 0;
AtomRec.Coords[2] := 0;
AtomRec.Coords[3] := 0;
for i:=1 to MaxConn do
  begin
  AtomRec.Connto[i] := 0;
  AtomRec.TypConn[i] := btNoBond;
  end;
AtomRec.AtDispAtb := longint($80000000);    // switch off individual color
end;



(*********************************************************)
constructor TCTab.Create;
(*********************************************************)

var
  i : integer;

begin
inherited Create;
FNumValidAtoms := 0;
FStrucName := '';
FCoordUnit := cuUnknown;
FCASNr := 0;
for i:=1 to MaxLengCTab do
  ClearCTElem (FAtomEntries[i]);
end;


(*********************************************************)
destructor TCTab.Destroy;
(*********************************************************)

begin
inherited Destroy;
end;


(*********************************************************)
function  TCTab.GetNBonds (AtIx: integer): integer;
(*********************************************************
  ENTRY:   AtIx ... number of interesting atom
  EXIT:    number of bonds of that atom
 *********************************************************)

var
  i, j: integer;

begin
j := 0;
if AtIx <= FNumValidAtoms then
  begin
  for i:=1 to MaxConn do
    if FAtomEntries[AtIx].ConnTo[i] <> 0 then
      inc (j);
  end;
GetNBonds := j;
end;

(*********************************************************)
function  TCTab.MaxNBonds (var AtIx: integer):integer;
(*********************************************************
  ENTRY:   -
  EXIT:    function finds the atom with the maximum number
           of bonds. The number of bonds of this atom is
           returned as function value, the index of this atom
           is returned with the variable parameter AtIx.
 *********************************************************)

var
  i, j  : integer;
  k     : integer;
  max   : integer;

begin
Max := 0;
for k:=1 to FNumValidAtoms do
  begin
  j := 0;
  for i:=1 to MaxConn do
    if FAtomEntries[k].ConnTo[i] <> 0 then
      inc (j);
  if j > Max then
    begin
    Max := j;
    AtIx := k;
    end;
  end;
MaxNBonds := Max;
end;


(*********************************************************)
function  TCTab.GetAtNum (AtIx: integer): byte;
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    AtNum of that atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms))
  then GetAtNum := FAtomEntries[AtIx].AtNum
  else GetAtNum := 0;
end;


(*********************************************************)
function TCTab.GetAtFlag (AtIx: integer): byte;
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    Flag of this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms))
  then GetAtFlag := FAtomEntries[AtIx].AtFlag
  else GetAtFlag := 0;
end;

(*********************************************************)
function TCTab.GetAtomEntries (AtIx: integer): CTElem;
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    atom record holding all properties of atom AtIx
 *********************************************************)

var
  AtomRec : CTElem;

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms))
  then GetAtomEntries := FAtomEntries[AtIx]
  else begin
       ClearCTElem (AtomRec);
       GetAtomEntries := AtomRec;
       end;
end;



(*********************************************************)
function TCTab.GetAtWeight (AtIx: integer): byte;
(*********************************************************
  ENTRY:   AtIx ....... number of atom
  EXIT:    atomic weight of that atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms))
  then GetAtWeight := FAtomEntries[AtIx].AtWeight
  else GetAtWeight := 0;
end;


(*********************************************************)
function TCTab.GetAttrib (AtIx: integer): byte;
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    Atribute byte of this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms))
  then GetAttrib := FAtomEntries[AtIx].Attrib
  else GetAttrib := 0;
end;


(*********************************************************)
function TCTab.GetCharge (AtIx: integer): shortint;
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    Charge of this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms))
  then GetCharge := FAtomEntries[AtIx].Charge
  else GetCharge := 0;
end;


(*********************************************************)
function TCTab.GetConnTo (AtIx: integer; ConnIx: integer): byte;
(*********************************************************
  ENTRY:   AtIx ..... number of atom
           ConnIx ... index of connection entry
  EXIT:    atom number connected to this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms))
  then GetConnTo := FAtomEntries[AtIx].ConnTo[ConnIx]
  else GetConnto := 0;
end;


(*********************************************************)
function TCTab.GetTypConn (AtIx: integer; ConnIx: integer): byte;
(*********************************************************
  ENTRY:   AtIx ..... number of atom
           ConnIx ... index of connection entry
  EXIT:    Type of connection to this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms))
  then GetTypConn := FAtomEntries[AtIx].TypConn[ConnIx]
  else GetTypConn := btNoBond;
end;


(*********************************************************)
function TCTab.GetCoords (AtIx, DimIx: integer): single;
(*********************************************************
  ENTRY:   AtIx ... number of atom
           Dim .... dimension index (1=x, 2=y, 3=z)
  EXIT:    coordinate of this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms))
  then GetCoords := FAtomEntries[AtIx].Coords[DimIx]
  else GetCoords := 0;
end;

(*********************************************************)
function TCTab.CheckConnect (At1,At2: integer): byte;
(*********************************************************
  ENTRY:   At1, At1 ..... entry number of atoms

  EXIT:    result ....... 0 if bond does not exist
                          1..4 type of connection
 *********************************************************)

var
  reslt : integer;
  nb     : integer;
  i      : integer;

begin
reslt := 0;
nb := NBonds [At1];
for i:=1 to nb do
  begin
  if FAtomEntries[At1].ConnTo[i] = At2 then
    reslt := FAtomEntries[At1].TypConn[i];
  end;
CheckConnect := reslt;
end;


(*********************************************************)
function TCTab.MakeConnection (At1,At2: integer; CType: byte): boolean;
(*********************************************************
  ENTRY:   At1, At1 ..... entry number of atoms to (dis)connect
           CType ........ connection type (0..4)
                          if CType=0 then connection is broken
                          else connection is set to this type
                          'MakeConnection' creates a new connection
                          if necessary.

  EXIT:    connection type is set (created, deleted) accordingly
           result = TRUE if everything OK
           result = FALSE if connection cannot be set
                    (no room for another entry or invalid atom numbers)
 *********************************************************)

var
  ix       : integer;
  iy1, iy2 : integer;
  reslt    : boolean;

begin
reslt := False;
if (At1 <= FNumValidAtoms) and (At1 > 0) and
   (At2 <= FNumValidAtoms) and (At2 > 0) then
  begin
  if CType = 0
    then begin                        (* disconnect two atoms *)
         ix := 1;
         iy1 := 1;
         iy2 := 1;
         while (ix <= MaxConn) do
           begin
           if FAtomEntries[At1].ConnTo[ix] = At2
             then begin
                  FAtomEntries[At1].ConnTo[ix] := 0;
                  FAtomEntries[At1].TypConn[ix] := btNoBond;
                  reslt := True;
                  end
             else begin
                  FAtomEntries[At1].ConnTo[iy1] := FAtomEntries[At1].COnnTo[ix];
                  FAtomEntries[At1].TypConn[iy1] := FAtomEntries[At1].TypConn[ix];
                  inc (iy1);
                  end;
           if FAtomEntries[At2].ConnTo[ix] = At1
             then begin
                  FAtomEntries[At2].ConnTo[ix] := 0;
                  FAtomEntries[At2].TypConn[ix] := btNoBond;
                  reslt := True;
                  end
             else begin
                  FAtomEntries[At2].ConnTo[iy2] := FAtomEntries[At2].COnnTo[ix];
                  FAtomEntries[At2].TypConn[iy2] := FAtomEntries[At2].TypConn[ix];
                  inc (iy2);
                  end;
           inc (ix);
           end;
         end
    else begin
         EnterConn (At1, At2, CType);
         EnterConn (At2, At1, CType);
         reslt := True;
         end;
  end;
MakeConnection := reslt;
end;



(******************************************************************)
function TCTab.CheckCASNr (CASNum: longint): boolean;
(******************************************************************
   ENTRY:   CASNum ... CAS reg. number to be checked

   EXIT:    TRUE if CAS number is ok, else FALSE
 ******************************************************************)

var
  R       : integer;
  i, sum  : integer;

begin
R := CASNum mod 10;
CASNum := CASNum div 10;
sum := 0;
i := 1;
repeat
  sum := sum + i*(CASNum mod 10);
  inc (i);
  CASNum := CASNum div 10;
until CASNum = 0;
if sum mod 10 = R
  then CheckCASNr := true
  else CheckCASNr := false;
end;


(******************************************************************)
function TCTab.GetCASNr: string;
(******************************************************************)

var
  hstr1  : string;

begin
str (FCASNr,hstr1);
while length(hstr1) < 4 do
  hstr1 := '0'+hstr1;
insert ('-',hstr1,length(hstr1)-2);
insert ('-',hstr1,length(hstr1));
GetCASNr := hstr1;
end;


(******************************************************************)
procedure TCTab.SetCASNr (InString: string);
(******************************************************************
 ENTRY: Instring .... string which holds CAS Reg.Nr.
 EXIT:  CASNr ....... CAS-Reg. number is set if valid string
 ******************************************************************)

var
  reslt   : boolean;
  i       : integer;
  Status  : integer;
  HyphCnt : integer;
  fst,sec : integer;
  CASNr   : longint;

begin
Instring := StripLTBlanks (Instring);
fst := 0;
sec := 0;
HyphCnt := 0;
CASNr := 0;
for i:=1 to length(Instring) do
  if Instring[i] = '-' then
    begin
    inc (HyphCnt);
    if fst = 0
      then fst := i
      else begin
           if sec = 0 then
             sec := i
           end;
    end;
if ((HyphCnt <> 2) or (sec-fst <> 3) or (sec+1 <> length(Instring)))
  then reslt := false
  else begin
       if sec <> 0 then
         delete (Instring, sec, 1);
       if fst <> 0 then
         delete (Instring, fst, 1);
       val (Instring, CASNr, status);
       if Status <> 0
         then reslt := false
         else reslt := CheckCASNr (CASNr);
       end;
if reslt then
  FCasNr := CASNr;
Changed;
end;


(*********************************************************)
procedure  TCTab.SetAtNum (AtIx: integer; AtNum: byte);
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    AtNum of that atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms) and
    (AtNum > 0) and (AtNum <= MaxChemElem)) then
  begin
  FAtomEntries[AtIx].AtNum := AtNum;
  Changed;
  end;
end;

(*********************************************************)
procedure TCTab.SetAtFlag (AtIx: integer; AtFlag: byte);
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    Flag of this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms)) then
  begin
  FAtomEntries[AtIx].AtFlag := AtFlag;
  Changed;
  end;
end;

(*********************************************************)
procedure TCTab.SetAtomEntries (AtIx: integer; AE: CTElem);
(*********************************************************
  ENTRY:   AtIx ... number of atom
           AE ..... atom information
  EXIT:    Atom entry is set
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms)) then
  begin
  FAtomEntries[AtIx] := AE;
  Changed;
  end;
end;


(*********************************************************)
procedure TCTab.SetAtWeight (AtIx: integer; AtWeight: byte);
(*********************************************************
  ENTRY:   AtIx ....... number of atom
           AtWeight ... atomic weight of that atom
  EXIT:    atomic weight is set
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms)) then
  begin
  FAtomEntries[AtIx].AtWeight := AtWeight;
  Changed;
  end;
end;


(*********************************************************)
procedure TCTab.SetAttrib (AtIx: integer; Attrib: byte);
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    Atribute byte of this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms)) then
  begin
  FAtomEntries[AtIx].Attrib := Attrib;
  Changed;
  end;
end;


(*********************************************************)
procedure TCTab.SetCharge (AtIx: integer; Charge: shortint);
(*********************************************************
  ENTRY:   AtIx ... number of atom
  EXIT:    Charge of this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms)) then
  begin
  FAtomEntries[AtIx].Charge := Charge;
  Changed;
  end;
end;


(*********************************************************)
procedure TCTab.SetConnTo (AtIx: integer; ConnIx: integer;
                         ConnTo: byte);
(*********************************************************
  ENTRY:   AtIx ..... number of atom
           ConnIx ... index of connection entry
  EXIT:    atom number connected to this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms)) then
  begin
  FAtomEntries[AtIx].ConnTo[ConnIx] := ConnTo;
  Changed;
  end;
end;


(*********************************************************)
procedure TCTab.SetTypConn (AtIx: integer; ConnIx: integer; Typ: byte);
(*********************************************************
  ENTRY:   AtIx ..... number of atom
           ConnIx ... index of connection entry
  EXIT:    Type of connection to this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms)) then
  begin
  FAtomEntries[AtIx].TypConn[ConnIx] := Typ;
  Changed;
  end;
end;


(*********************************************************)
procedure TCTab.SetCoords (AtIx, DimIx: integer; Coord: single);
(*********************************************************
  ENTRY:   AtIx ... number of atom
           Dim .... dimension index (1=x, 2=y, 3=z)
  EXIT:    coordinate of this atom
 *********************************************************)

begin
if ((AtIx > 0) and (AtIx <= FNumValidAtoms)) then
  begin
  FAtomEntries[AtIx].Coords[DimIx] := Coord;
  Changed;
  end;
end;


(**************************************************************)
procedure TCTab.CalcMolCenter (var spx, spy, spz: double);
(**************************************************************)

var
  i          : integer;
  lx, ly, lz : double;

begin
lx := 0;  ly := 0;  lz := 0;
spx := 0; spy := 0; spz := 0;
if FNumValidAtoms > 0 then
  begin
  for i:=1 to FNumValidAtoms do
    begin
    lx := lx + FAtomEntries[i].Coords[1];
    ly := ly + FAtomEntries[i].Coords[2];
    lz := lz + FAtomEntries[i].Coords[2];
    end;
  spx := lx/FNumValidAtoms;
  spy := ly/FNumValidAtoms;
  spz := lz/FNumValidAtoms;
  end;
end;


(**************************************************************)
function TCTab.FindAtomInBox (x, y, z, XRange, YRange, ZRange: double): integer;
(**************************************************************
  ENTRY:    x,y,z ............ coordinates of an atom
            XRange..ZRange ... Range to search for the atom
  EXIT:     number of that atom
            -1 if no atom in neighbourhood of [x,y]
 **************************************************************)

var
  AtomFound : integer;
  i         : integer;

begin
AtomFound := -1;
if FNumValidAtoms > 0 then
  begin
  for i:=1 to FNumValidAtoms do
    begin
    if ((abs(AtomEntries[i].Coords[1] - x) <= XRange) and
        (abs(AtomEntries[i].Coords[2] - y) <= YRange) and
        (abs(AtomEntries[i].Coords[3] - z) <= ZRange)) then
      AtomFound := i;
    end;
  end;
FindAtomInBox := AtomFound;
end;


(******************************************************************************)
procedure TCTab.FindClosestAtom (x,y,z: double; var ClosestAtom: integer;
                                 var Dist: double);
(******************************************************************************)

var
  i   : integer;
  d   : double;

begin
Dist := MaxDouble;
ClosestAtom := 0;
for i:=1 to FNumValidAtoms do
  begin
  d := sqrt(sqr(x-FAtomEntries[i].Coords[1])+sqr(y-FAtomEntries[i].Coords[2])+sqr(z-FAtomEntries[i].Coords[3]));
  if d < Dist then
    begin
    Dist := d;
    ClosestAtom := i;
    end;
  end;
end;


(**************************************************************)
function TCTab.CalcMolExtents (var MinX, MinY, MaxX, MAxY,
                              CentX, CentY: double): double;
(**************************************************************
  ENTRY:   CTab holds connection table
  EXIT:    MinX .. MaxY: minimum and maximum X- and Y-coordinates
           CentX, CentY: coordinates of center of molecule
           function returns average bondlength
 **************************************************************)

var
  i,j    : integer;
  AvgBL  : double;
  nb     : integer;
  XCoord : single;
  YCoord : single;
  BndCnt : integer;
  cx, cy : single;

begin
AvgBL := 0;
BndCnt := 0;
MinX := 10000; MaxX := 0;
MinY := 7000;  MaxY := 0;
CX := 0;
CY := 0;
if FNumValidAtoms > 1
  then begin
       for i:=1 to FNumValidAtoms do
         begin
         Xcoord := FAtomEntries[i].Coords[1];
         Ycoord := FAtomEntries[i].Coords[2];
         CX := CX + XCoord;
         Cy := Cy + YCoord;
         if MinX > XCoord then
           MinX := XCoord;
         if MaxX < XCoord then
           MaxX := XCoord;
         if MinY > YCoord then
           MinY := YCoord;
         if MaxY < YCoord then
           MaxY := YCoord;
         nb := NBonds[i];
         for j:=1 to nb do
           begin
           AvgBL := AvgBL + sqrt(sqr(Xcoord - FAtomEntries[FAtomEntries[i].Connto[j]].Coords[1])+
                                 sqr(Ycoord - FAtomEntries[FAtomEntries[i].Connto[j]].Coords[2]));
           inc (BndCnt);
           end;
         end;
       if BndCnt > 0
         then AvgBL := avgBL/BndCnt
         else AvgBL := 0;
       CentX := cx/FNumValidAtoms;
       CentY := cy/FNumValidAtoms;
       end
  else begin
       MinX := 1;  MaxX := 10000;
       MinY := 1;  MaxY := 7000;
       CentX := 5000;
       CentY := 3500;
       end;
CalcMolExtents := AvgBL;
end;


(***************************************************************)
function TCTab.AddAtom (AtomRec: CTElem): boolean;
(***************************************************************)

var
  i : integer;

begin
if FNumValidAtoms >= MaxLengCTab
  then AddAtom := false
  else begin
       inc (FNumValidAtoms);
       FAtomEntries[FNumValidAtoms].AtNum := AtomRec.AtNum;
       FAtomEntries[FNumValidAtoms].Coords[1] := AtomRec.Coords[1];
       FAtomEntries[FNumValidAtoms].Coords[2] := AtomRec.Coords[2];
       FAtomEntries[FNumValidAtoms].Coords[3] := AtomRec.Coords[3];
       FAtomEntries[FNumValidAtoms].Charge := AtomRec.Charge;
       FAtomEntries[FNumValidAtoms].AtWeight := AtomRec.AtWeight;
       FAtomEntries[FNumValidAtoms].AtFlag := AtomRec.AtFlag;
       FAtomEntries[FNumValidAtoms].Attrib := AtomRec.Attrib;
       for i:=1 to MaxConn do
         if Atomrec.ConnTo[i] <> 0 then
           EnterConn (FNumValidAtoms, AtomRec.ConnTo[i], AtomRec.TypConn[i]);
       AddAtom := True;
       end;
end;


(***************************************************************)
function RingInRingList (Ring: RingType; RingList: RingListType): boolean;
(***************************************************************
  ENTRY: Ring ...... ring to be looked for
         RingList .. ringlist to be searched in

  Exit:  function returns TRUE if 'Ring' is contained in 'RingList'
 ***************************************************************)

var
  AF     : array[1..MaxLengCTab] of boolean;
  j,k    : integer;
  Found  : boolean;

begin
Found := False;
if RingList.NrOfRings > 0 then
  begin
  j := 1;
  repeat
    for k:=1 to MaxLengCTab do
      AF[k] := False;
    for k:=1 to RingList.RList[j].RingSize do
      AF[RingList.RList[j].Atlist[k]] := True;
    Found := True;
    for k:=1 to Ring.RingSize do
      Found := AF[Ring.AtList[k]] and Found;
    inc (j);
  until ((j > RingList.NrOfRings) or Found);
  end;
RingInRingList := Found;
end;

(***************************************************************)
procedure TCTab.Clear;
(***************************************************************)

var
  i   : integer;

begin
FNumValidAtoms := 0;
FStrucName := '';
FCASNr := 0;
FCoordUnit := cuUnknown;
for i:=1 to MaxLengCTab do
  ClearCTElem (FAtomEntries[i]);
Changed;
end;

(***************************************************************)
procedure TCTab.ClearAttributes;
(***************************************************************)

var
  i   : integer;

begin
for i:=1 to FNumValidAtoms do
  FAtomEntries[i].Attrib := 0;
end;


(**********************************************************)
procedure TCTab.DeleteAtom (AtomNr: integer);
(**********************************************************
  ENTRY:  AtIx ... number fo atom to be deleted in CTab
  EXIT:   ATom ist removed from CTab, other references are
          reordered in order to maintain contiguous CTab;
          TCTab.FNumValidAtoms is decremented.
 **********************************************************)

var
  i,j,k,l : integer;

begin
if (AtomNr > 0) and (AtomNr <= FNumValidAtoms) then
  for i:=1 to FNumValidAtoms do
    for j:=1 to MaxConn do
      if (FAtomEntries[i].ConnTo[j] = AtomNr) then
        begin
        FAtomEntries[i].ConnTo[j] := 0;
        FAtomEntries[i].TypConn[j] := btNoBond;
        for k:=1 to MaxConn do
          if (FAtomEntries[AtomNr].ConnTo[k] <> i) then
            begin
            l := 0;
            repeat
              inc (l);
            until (FAtomEntries[i].ConnTo[l] = 0);
            FAtomEntries[i].ConnTo[l] := FAtomEntries[AtomNr].ConnTo[k];
            FAtomEntries[i].TypConn[l] := FAtomEntries[AtomNr].TypConn[k];
            end;
        end;

for i:=1 to MaxConn do   (* copy  last CTAB entry on free position *)
  begin
  FAtomEntries[AtomNr].ConnTo[i] := FAtomEntries[FNumValidAtoms].ConnTo[i];
  FAtomEntries[AtomNr].TypConn[i] := FAtomEntries[FNumValidAtoms].TypConn[i];
  end;
FAtomEntries[AtomNr].AtNum := FAtomEntries[FNumValidAtoms].AtNum;
FAtomEntries[AtomNr].AtWeight := FAtomEntries[FNumValidAtoms].AtWeight;
FAtomEntries[AtomNr].Charge := FAtomEntries[FNumValidAtoms].Charge;
FAtomEntries[AtomNr].AtFlag := FAtomEntries[FNumValidAtoms].AtFlag;
FAtomEntries[AtomNr].Attrib := FAtomEntries[FNumValidAtoms].Attrib;
FAtomEntries[AtomNr].Coords[1] := FAtomEntries[FNumValidAtoms].Coords[1];
FAtomEntries[AtomNr].Coords[2] := FAtomEntries[FNumValidAtoms].Coords[2];
dec (FNumValidAtoms);

for i:=1 to FNumValidAtoms do
  for j:=1 to MaxConn do
    if (FAtomEntries[i].Connto[j] = FNumValidAtoms+1) then
      FAtomEntries[i].Connto[j] := AtomNr;

ClearCTElem (FAtomEntries[FNumValidAtoms+1]);  (* clear unused CTAB-Entry *)

for i:=1 to FNumValidAtoms do       (* clear double references *)
  for j:= 1 to MaxConn-1 do
    begin
    if FAtomEntries[i].Connto[j] <> 0 then
      begin
      for k:=j+1 to MaxConn do
        if FAtomEntries[i].Connto[k] = FAtomEntries[i].Connto[j] then
          begin
          FAtomEntries[i].Connto[k] := 0;
          FAtomEntries[i].TypConn[k] := btNoBond;
          end;
      end;
    if FAtomEntries[i].Connto[j] = 0 then
      begin
      for k:=j+1 to MaxConn do
        begin
        FAtomEntries[i].Connto[k-1] := FAtomEntries[i].Connto[k];
        FAtomEntries[i].TypCOnn[k-1] := FAtomEntries[i].TypConn[k];
        end;
      FAtomEntries[i].Connto[MaxConn] := 0;
      FAtomEntries[i].TypConn[MaxConn] := btNoBond;
      end;
    end;
end;

(***************************************************************)
function TCTab.RingsInMolecule: integer;
(***************************************************************
 ENTRY:    CTab
 EXIT:     number of smallest rings (Frerejacque number)
 WARNING:  routine fails if connection table holds more than one
           molecule (e.g. several unconnected fragments)
 ***************************************************************)

var
  i,nb  : integer;

begin
nb := 0;
for i:=1 to FNumValidAtoms do
  nb := nb + NBonds [i];
RingsInMolecule := (nb div 2)-FNumValidAtoms+1;
end;

(*********************************************************)
function TCTab.FindShortestRings (AtomIx: word;
            var RingList: RingListType): integer;
(*********************************************************
  ENTRY:  CTab .... Connection Table
          AtomIx .. Number of atom which belongs to that ring

  EXIT:   procedure searches shortest ring(s) which hold atom
          'AtomIx' as a member. The result is returned as a
          list of rings in the array 'RingList'. The number of
          the rings is returned as function value. If this value
          equals zero, the indicated atom does not belong to a
          ring.
          RingList ...... table of atoms belonging to detected ring
 *********************************************************)

var
  MaxPleng  : integer;         (* length of current ring *)
  reslt     : ShortString;     (* contains all possible pathways *)
  FirstAtom : word;
  Ring      : RingType;

procedure FindShortestRingIntern (Last, AtomIx: word);
(*--------------------------------------------------------
  ENTRY:  CTab .... Connection Table
          Last .... Variable for use in recursive calls, must
                    be set to zero by user calls
          AtomIx .. Number of atom which belongs to that ring
  EXIT:   procedure searches shortest ring which holds atom
          'AtomIx' as a member. The result is returned as
          list of atom numbers in array 'AtList'
 --------------------------------------------------------*)

var
  i : word;
  ix : word;

begin
if Last = 0 then
  begin
  reslt := '';
  MaxPLeng := MaxRingSize;
  for i:=1 to FNumValidAtoms do
    FAtomEntries[i].AtFlag := 0;
  FirstATom := AtomIx;
  end;
reslt := reslt+chr(AtomIx);
i:=0;
repeat
  inc (i);
  ix := FAtomEntries[AtomIx].Connto[i];
  if ((ix <> Last) and (ix <> 0)) then
    if (FAtomEntries[ix].AtFlag = 0) and (length(reslt) <= MaxPLeng) then
      begin   (* call next recursion level only if atom not used and path length less than minimum ring size so far *)
      FAtomEntries[AtomIx].AtFlag := 1;
      FindShortestRingIntern (AtomIx, ix);
      end;
until ((i = MaxConn) or ((ix = FirstAtom) and (ix <> Last)) or (ix = 0));
if ix = FirstAtom then
  if length(reslt) < MaxPLeng
    then begin
         RingList.NrOfRings := 1;
         RingList.RList[RingList.NrOfRings].RingSize := length(reslt);
         for i:=1 to length(reslt) do
           RingList.RList[RingList.NrOfRings].AtList[i] := ord(reslt[i]);
         MaxPLeng := length (reslt);
         end
    else if (length(reslt) = MaxPLeng) then
           begin
           Ring.RingSize := length(reslt);
           for i:=1 to length(reslt) do
             Ring.AtList[i] := ord(reslt[i]);
           if not RingInRingList (Ring,Ringlist) then
             begin
             inc (RingList.NrOfRings);
             RingList.RList[RingList.NrOfRings] := Ring;
             end;
           end;
{$IFDEF VER80}
dec (reslt[0]);
{$ELSE}
length(reslt) := length(reslt)-1;
{$ENDIF}
FAtomEntries[AtomIx].AtFlag := 0;
end;


begin
RingList.NrOfRings := 0;
if (AtomIx > 0) and (AtomIx <= FNumValidAtoms) then
  FindShortestRingIntern (0, AtomIx);
FindShortestRings := RingList.NrOfRings;
end;


(*********************************************************)
function TCTab.FindSSSR (var RingList: RingListType):integer;
(*********************************************************
  ENTRY:   CTab ....... connection table to process

  EXIT:    RingList ... list of smallest set of smallest
                        rings (SSSR)
           function returns number of rings in SSSR
 *********************************************************)

var
  AtomIsRing   : array[1..MaxLengCTab] of boolean;
  i,j, k       : integer;
  ShRings      : RingListType;

begin
RingList.NrOfRings := 0;
for k:=1 to MaxLengCTab do
  AtomIsRing[k] := False;
for i:=1 to FNumValidAtoms do   (* test for all atoms in structure *)
  if not AtomIsRing[i] then  (* which are not part of an already found ring *)
    begin
    if FindShortestRings (i, ShRings) > 0 then (* search the smallest ring *)
      for j:=1 to Shrings.NrOfRings do
        begin
        if not RingInRingList (Shrings.RList[j],Ringlist) then
          begin
          inc (RingList.NrOfRings);
          RingList.RList[RingList.NrOfRings] := ShRings.RList[j];
          for k:=1 to ShRings.RList[j].RingSize do
            if NBonds [ShRings.RList[j].AtList[k]] <= 2 then (* do not search for atoms which are already part of a ring *)
              AtomIsRing[ShRings.RList[j].AtList[k]] := True;  (*-- and have only a maximum of two bonds *)
          end;
        end;
    end;
FindSSSR := RingList.NrOfRings;
end;


(***************************************************************)
function TCTab.CalcAttributes: integer;
(***************************************************************
  This routine calculates the attributes of all atoms of a given
  molecule. Each attribute is said to be present if the
  corresponding bit in the attribute byte ('Attrib') is set
  equal one. The following attributes are defined:
        Bit 0 = atom belongs to linear part of molecule
        Bit 1 = atom belongs to 3- or 4-atom ring or a ring with 7 or
                more atoms
        Bit 2 = atom belongs to 5-atom ring
        Bit 3 = atom belongs to 6-atom ring
        Bit 4 = branching atom
        Bit 5 = atom is part of a ring system (logical or of
                Bits 1..3)
        Bit 6 = atom is the last of a chain
        Bit 7 = condensed ring system
  The function returns the number of rings in the molecule and
  sets the attribute bits in TCTab.
 ***************************************************************)

var
  i,j      : integer;
  RingList : RingListType;
  Mask     : byte;
  NrRings  : integer;

begin
for i:=1 to MaxLengCtab do
  FAtomEntries[i].Attrib := 0;
NrRings := FindSSSR (RingList);
Mask := 0;
if NrRings > 0 then
  begin
  for i:=1 to NrRings do
    begin
    case RingList.RList[i].RingSize of
      2,3,4 : Mask := $22;
      5     : Mask := $24;
      6     : Mask := $28;
    end;
    if RingList.RList[i].RingSize > 6 then
      Mask := $22;
    for j:=1 to RingList.RList[i].RingSize do
      begin
      if (FAtomEntries[RingList.RList[i].Atlist[j]].Attrib and $2E) = 0
        then FAtomEntries[RingList.RList[i].Atlist[j]].Attrib :=
             FAtomEntries[RingList.RList[i].Atlist[j]].Attrib or Mask
        else FAtomEntries[RingList.RList[i].Atlist[j]].Attrib :=
             FAtomEntries[RingList.RList[i].Atlist[j]].Attrib or (Mask or $80);
      end;
    end;
  end;
for i:=1 to FNumValidAtoms do
  begin
  if FAtomEntries[i].Attrib = 0 then
    if NBonds[i] = 1
      then FAtomEntries[i].Attrib := $41
      else FAtomEntries[i].Attrib := $01;
  if NBonds[i] > 2 then
    FAtomEntries[i].Attrib := FAtomEntries[i].Attrib or AttribBranch;
  end;
CalcAttributes := NrRings;
end;


(*********************************************************)
procedure TCTab.CopyFrom (CTabSource: TCTab);
(*********************************************************
  ENTRY:   CtabSource ... source connection table
           self ......... destination conn tab
  EXIT:    CTabSource is copied to self
 *********************************************************)

var
  i,j: integer;

begin
FNumValidAtoms := CTabSource.FNumValidAtoms;
FStrucName := CTabSource.FStrucName;
FCoordUnit := CtabSource.FCoordUnit;
FCASNr := CTabSource.FCASNr;
for i:=1 to MaxLengCTab do
  begin
  FAtomEntries[i].AtNum := CTabSource.FAtomEntries[i].AtNum;
  FAtomEntries[i].AtWeight := CTabSource.FAtomEntries[i].Atweight;
  FAtomEntries[i].AtFlag := CTabSource.FAtomEntries[i].AtFlag;
  FAtomEntries[i].Attrib := CTabSource.FAtomEntries[i].Attrib;
  FAtomEntries[i].Charge := CTabSource.FAtomEntries[i].Charge;
  FAtomEntries[i].Coords[1] := CTabSource.FAtomEntries[i].Coords[1];
  FAtomEntries[i].Coords[2] := CTabSource.FAtomEntries[i].Coords[2];
  FAtomEntries[i].Coords[3] := CTabSource.FAtomEntries[i].Coords[3];
  for j:=1 to MaxConn do
    begin
    FAtomEntries[i].Connto[j] := CTabSource.FAtomEntries[i].Connto[j];
    FAtomEntries[i].TypConn[j] := CTabSource.FAtomEntries[i].TypConn[j];
    end;
  end;
Changed;
end;

(*********************************************************)
procedure TCTab.JoinFragment (CtabSource: TCTab);
(*********************************************************
  ENTRY:   CtabSource ... source connection table
           self ......... destination conn tab
  EXIT:    CTabSource is joined to self using the variable
           AtFlag. Atoms having the same value of Atflag
           are unified during joining. The atomic parameters
           of CTabSource have a higher weight and overwrite
           the atomic parameters of the joint atoms of the
           'self'-structure.
 *********************************************************)

var
  i,j      : integer;
  NAtLarge : integer;
  NewAtNum : array[1..MaxLengCTab] of integer;
  CTabBak  : TCTab;

begin
CTabBak := TCTab.create;
CTabBak.Clear;
CTabBak.CopyFrom (CTabSource);
NAtLarge := FNumValidAtoms;
for i:=1 to MaxLengCTab do
  NewAtNum[i] := 0;
for i:=1 to CTabBak.NAtoms do    (* determine common atoms *)
  begin
  if CTabBak.FAtomEntries[i].AtFlag =  0
    then begin
         inc (NatLarge);
         NewAtNum[i] := NAtLarge;
         end
    else begin
         for j:=1 to FNumValidAtoms do
           if FAtomEntries[j].AtFlag = CTabBak.FAtomEntries[i].AtFlag then
             NewAtNum[i] := j;
         end;
  end;
for i:=1 to CTabBak.NAtoms do   (* create new numbers *)
  for j:=1 to MaxConn do
    if CTabBak.FAtomEntries[i].ConnTo[j] <> 0 then
      CTabBak.FAtomEntries[i].ConnTo[j] :=
                  NewAtNum[CTabBak.FAtomEntries[i].ConnTo[j]];
for i:=1 to CTabBak.NAtoms do   (* incorporate source into working CTab *)
  begin
  if NewAtNum[i] > FNumValidAtoms
    then AddAtom (CTabBak.FAtomEntries[i])
    else begin
         FAtomEntries[NewAtNum[i]].AtNum := CTabBak.FAtomEntries[i].AtNum;
         FAtomEntries[NewAtNum[i]].AtWeight := CTabBak.FAtomEntries[i].AtWeight;
         FAtomEntries[NewAtNum[i]].Charge := CTabBak.FAtomEntries[i].Charge;
         for j:=1 to MaxConn do
           if CTabBak.FAtomEntries[i].ConnTo[j] <> 0 then
             EnterConn (NewAtNum[i],
                        CTabBak.FAtomEntries[i].ConnTo[j],
                        CTabBak.FAtomEntries[i].TypConn[j]);
         end;
  end;
CTabBak.Free;
end;

(*********************************************************)
procedure TCTab.LinkFragment (CtabSource: TCTab);
(*********************************************************
  ENTRY:   CtabSource ... source connection table
           self ......... destination conn tab
  EXIT:    CTabSource is linked to self using the variable
           AtFlag. Atoms having the same value of Atflag
           are connected during linking (cf. JoinFragment).
 *********************************************************)

var
  i,j      : integer;
  NAtLarge : integer;

begin
NAtLarge := FNumValidAtoms;
if NAtLarge + CTabSource.Natoms <= MaxlengCTab then
  begin
  FNumValidAtoms := FNumValidAtoms + CtabSource.NAtoms;
  for i:=1 to CTabSource.NAtoms do
    begin
    for j:=1 to MaxConn do
      begin
      if CTabSource.FAtomEntries[i].Connto[j] <> 0 then
        CTabSource.FAtomEntries[i].Connto[j] :=
             CTabSource.FAtomEntries[i].Connto[j] + NAtLarge;
      end;
    FAtomEntries[NAtLarge+i] := CTabSource.FAtomEntries[i];
    end;
  for i:=1 to NAtLarge do
    if FAtomEntries[i].AtFlag <> 0 then
      begin
      for j:=NAtLarge+1 to FNumValidAtoms do
        if FAtomEntries[i].AtFlag = FAtomEntries[j].AtFlag then
          begin
          EnterConn (i,j,1);
          EnterConn (j,i,1);
          end;
      end;
  end;
end;


(**************************************************************)
procedure TCTab.EnterConn (AtIx, Connto, TypConn: integer);
(**************************************************************)

var
  i       : integer;

begin
if ((AtIx > 0) and (ConnTo > 0)) then
  begin
  i:=0;
  repeat
    inc (i);
  until ((FAtomEntries[AtIx].Connto[i] = 0) or (i >= MaxConn) or
         (FAtomEntries[AtIx].Connto[i] = ConnTo));
  if FAtomEntries[AtIx].Connto[i] = ConnTo
    then FAtomEntries[AtIx].TypConn[i] := TypConn
    else if FAtomEntries[AtIx].Connto[i] = 0 then
           begin
           FAtomEntries[AtIx].Connto[i] := Connto;
           FAtomEntries[AtIx].TypConn[i] := TypConn;
           end;
  end;
end;


(**************************************************************)
procedure TCTab.MakeSymmetricConnections;
(**************************************************************)

var
  i,j : integer;

begin
if FNumValidAtoms > 0 then
  for i:=1 to FNumValidAtoms do
    begin
    for j:=1 to MaxConn do
      if FAtomEntries[i].ConnTo[j] <> 0 then
        EnterConn (FAtomEntries[i].ConnTo[j], i, FAtomEntries[i].TypConn[j]);
    end;
end;





(*********************************************************)
function TCTab.FindNextEndAtom (AtIx: integer): integer;
(*********************************************************
  ENTRY:   Ctab ... connection table
           AtIx ... index where to start search
  EXIT:    number of the next atom in CTAB (starting at ix
           and including ix) which constitutes the end of
           a chain. A value of zero is returned if no such
           end exists.
 *********************************************************)

var
  found : boolean;
  j, k  : word;

begin
found := false;
if Atix <= FNumValidAtoms then
  repeat
    k := 0;
    for j := 1 to MaxConn do
      if FAtomEntries[Atix].ConnTo[j] <> 0 then inc(k);
    if k=1
      then found := true
      else inc (Atix);
  until ((Atix > FNumValidAtoms) or Found);
if found
  then FindNextEndAtom := Atix
  else FindNextEndAtom := 0;
end;


(*********************************************************)
function TCTab.StripfromChains: integer;
(*********************************************************
  StripFromChains eliminates all sidechains and returns the
  number of atoms occupied by any ring system. That means if
  StripFromChains yields a result > 0 then the structure
  contains at least one ring
 *********************************************************)

var
  i             : word;
  NoSingleBonds : boolean;

begin
repeat
  NoSingleBonds := true;
  i:=1;
  repeat
    if NBonds[i] = 1 then
      begin
      NoSingleBonds := false;
      DeleteAtom (i);
      end;
    inc (i);
  until i > FNumValidAtoms;
until NoSingleBonds;
if FNumValidAtoms = 1 then
  FNumValidAtoms := 0;
StripFromChains := FNumValidAtoms;
end;


(*********************************************************)
function TCTab.SumForContained
                (CTabSmall: TCTab): boolean;
(*********************************************************
  ENTRY:   self ......... connection table to search in
           CTabSmall .... connection table to be searched

  EXIT:    TRUE if the brutto formula of CTabSmall is
           contained in the brutto formula of self
 *********************************************************)

const
  MaxAtType = 30;

var
  Contained : boolean;
  i, j      : integer;
  SumFor    : array[1..MaxAtType,1..2] of integer;

begin
Contained := False;
if CTabSmall.FNumValidAtoms <= FNumValidAtoms then
  begin
  for i:=1 to MaxAtType do
    begin
    SumFor[i,1] := 0;
    SumFor[i,2] := 0;
    end;
  for i:=1 to FNumValidAtoms do
    begin
    j := 0;
    repeat
      inc (j);
    until ((j >= MaxAtType) or (SumFor[j,1] = FAtomEntries[i].AtNum) or
          (SumFor[j,1] = 0));
    if ((SumFor[j,1] = FAtomEntries[i].AtNum) or (SumFor[j,1] = 0)) then
      begin
      inc (SumFor[j,2]);
      SumFor[j,1] := FAtomEntries[i].AtNum;
      end;
    end;
  for i:=1 to CTabSmall.FNumValidAtoms do
    begin
    j := 0;
    repeat
      inc (j);
    until ((j >= MaxAtType) or (SumFor[j,1] = CTabSmall.FAtomEntries[i].AtNum) or
          (SumFor[j,1] = 0));
    if ((SumFor[j,1] = CTabSmall.FAtomEntries[i].AtNum) or (SumFor[j,1] = 0)) then
      begin
      dec (SumFor[j,2]);
      SumFor[j,1] := CTabSmall.FAtomEntries[i].AtNum;
      end;
    end;
  Contained := True;
  for j:=1 to MaxAtType do
    if SumFor[j,2] < 0 then Contained := False;
  end;
SumForContained := ConTained;
end;


(******************************************************************)
procedure NextCombination (var ByteArray: EightBytes; iSm,iLg: integer);
(******************************************************************)


function ValueUSed (Ism: integer): boolean;
(*---------------------------------------*)

var
  OK : boolean;
  i  : integer;

begin
ok := True;
for i:=1 to ISm-1 do
  if ByteArray[i] = ByteArray[ism] then ok := False;
ValueUsed := OK;
end;


begin
if ism > 0 then
  begin
  repeat
    inc (ByteArray[iSm]);
  until ValueUsed(Ism);
  if ByteArray[iSm] > ILg
    then begin
         ByteArray[iSm] := 1;
         NextCombination (ByteArray,ism-1,ilg);
         while not ValueUsed(iSm) do
           inc(ByteArray[iSm]);
         end;
  end;
end;



(**************************************************************)
function TCTab.SearchSubStruc (CTabSmall: TCTab;
                         var MatchedAtoms: AtFlagType;
                         CompareBonds: boolean): boolean;
(**************************************************************
  CompBonds : TRUE if bonds are to be compared

  Attention:  the attributes of both molecules must be set
              properly prior to calling this routine !
 **************************************************************)


var
  NrRingsSmall   : integer;   (* number of rings in small molecule *)
  NrRingsLarge   : integer;   (* number of rings in large molecule *)
  AtomUsedSmall,
  AtomUsedLarge  : AtFlagType;  (* Flags for cycle recognition *)
  ResultLarge,
  ResultSmall    : AtListType;  (* List to track corresponding
                                atoms in small and large molecules *)
  Level          : integer;       (* depth of graph tree *)



function Compare (LastLg, LastSm, LargeAtIx,SmallAtIx: byte;
                  var RingClosed: boolean): boolean;
(*---------------------------------------------------------*)

var
  reslt      : boolean;
  found      : boolean;
  i,j        : integer;
  SmallNext,
  LargeNext  : integer;
  ConnTypSmall : integer;

begin
reslt := True;
RingClosed := False;
if (CTabSmall.FAtomEntries[SmallAtIx].AtNum <> FAtomEntries[LargeAtIx].AtNum) then
  reslt := false;
if (CTabSmall.FAtomEntries[SmallAtIx].Attrib <> 0) then
  if (CTabSmall.FAtomEntries[SmallAtIx].Attrib and FAtomEntries[LargeAtIx].Attrib) <>
     CTabSmall.FAtomEntries[SmallAtIx].Attrib then
    reslt := false;
if (CTabSmall.NBonds[SmallAtIx] > NBonds[LargeAtIx]) then
  reslt := false;
if (CompareBonds and (LastSm > 0)) then
  begin
  i := 1;
  j := CTabSmall.NBonds[LastSm];
  while ((i <= j) and (CTabSmall.FAtomEntries[LastSm].Connto[i] <> SmallAtIx)) do
    inc (i);
  ConnTypSmall := CTabSmall.FAtomEntries[LastSm].TypConn[i];
  i := 1;
  j := NBonds[LastLg];
  while ((i <= j) and (FAtomEntries[LastLg].Connto[i] <> LargeAtIx)) do
    inc (i);
  if ConnTypSmall <> FAtomEntries[LastLg].TypConn[i] then
    reslt := False;
  end;
if reslt then  // check ring closure
  begin
  for i:=1 to CTabSmall.NBonds[SmallAtIx] do   // check small structure
    begin
    SmallNext := CTabSmall.FAtomEntries[SmallAtIx].Connto[i];
    if ((LastSm <> SmallNext) and (AtomUsedSmall[SmallNext] = 1)) then
      begin
      RingClosed := True;
      j := 0;
      repeat
        inc (j);
      until (ResultSmall.AtList[j] = SmallNext);
      LargeNext := ResultLarge.AtList[j];
      found := false;
      for j:=1 to NBonds[LargeAtIx] do
        if FAtomEntries[LargeAtIx].ConnTo[j] = LargeNext then
          found := true;
      if not found then
        reslt := False;
      end;
    end;
(*
  for i:=1 to NBonds[LargeAtIx] do   // check large structure
    begin
    LargeNext := FAtomEntries[LargeAtIx].Connto[i];
    if ((LastSm <> LargeNext) and (AtomUsedLarge[LargeNext] = 1)) then
      begin
      RingClosed := True;
      j := 0;
      repeat
        inc (j);
      until ResultLarge.AtList[j] = LargeNext;
      SmallNext := ResultSmall.AtList[j];
      found := false;
      for j:=1 to NBonds[SmallAtIx] do
        if FAtomEntries[SmallAtIx].ConnTo[j] = SmallNext then
          found := true;
      if not found then
        reslt := False;
      end;
    end;
*)

//  RingClosed := false;
  end;
Compare := reslt;
end;


function CheckValidity (LastLg, LastSm, LargeAtIx, SmallAtIx: byte): boolean;
(*----------------------------------------------------------------*)

var
  i,j        : integer;
  k,n        : integer;
  nz         : longint;
  reslt      : boolean;
  ZuOrd      : EightBytes;
  SmallList  : EightBytes;
  LargeList  : EightBytes;
  RingClosed : boolean;

begin
if LastLg = 0 then
  begin
  Level := 0;
  for i:=1 to MaxLengCTab do
    begin
    ResultSmall.AtList[i] := 0;
    ResultLarge.AtList[i] := 0;
    AtomUsedLarge[i] := 0;
    AtomUsedSmall[i] := 0;
    end;
  end;

//**** bug fix by HL (recursion re-used atoms)

reslt := (AtomUsedLarge[LargeAtIx] = 0);
if reslt then
  reslt := (AtomUsedSmall[SmallAtIx] = 0);
if reslt then
//**** end of bug fix
  reslt := Compare(LastLg, LastSm, LargeAtIx,SmallAtIx, RingClosed);

if reslt then
  begin
  AtomUsedSmall[SmallAtIx] := 1;
  AtomUsedLarge[LargeAtIx] := 1;
  inc (level);
  ResultSmall.AtList [Level] := SmallAtIx;
  ResultLarge.AtList [Level] := LargeAtIx;
  n := NBonds[LargeAtIx]-1;
  if LastLg = 0 then
    inc(n);
  k := CTabSmall.NBonds[SmallAtIx]-1;
  if LastSm = 0 then
    inc (k);
  MatchedAtoms[LargeAtIx] := 1;
  if ((k > 0) and not RingClosed) then
    begin
    nz := 1;
    for i:=n downto n-k+1 do
      nz := nz * i;
    j := 1;
    for i:=1 to k+1 do
      if CTabSmall.FAtomEntries[SmallAtIx].Connto[i] <> LastSm then
        begin
        SmallList[j] := CTabSmall.FAtomEntries[SmallAtIx].Connto[i];
        inc (j);
        end;
    j := 1;
    for i:=1 to n+1 do
      if FAtomEntries[LargeAtIx].Connto[i] <> LastLg then
        begin
        LargeList[j] := FAtomEntries[LargeAtIx].Connto[i];
        inc (j);
        end;
    j := 1;
    for i:=1 to 8 do
      ZuOrd [i] := i;
    repeat
      NextCombination (Zuord,k,n);
      if not reslt then
        begin
(*
        for i:=1 to MaxlengCTab do
          begin
          MatchedAtoms[i] := 0;
          AtomUsedSmall[i] := 0;
          AtomUsedLarge[i] := 0;
          end;
        for i:=1 to Level do
          begin
          MatchedAtoms[ResultLarge.AtList[i]] := 1;
          AtomUsedLarge[ResultLarge.AtList[i]] := 1;
          AtomUsedSmall[ResultSmall.AtList[i]] := 1;
          end;
*)
        end;
      reslt := true;
      i:=0;
      while (i<k) and reslt do
        begin
        inc (i);
        reslt := reslt and CheckValidity (LargeAtIx, SmallAtIx, LargeList[ZuOrd[i]],SmallList[i]);
        end;
      if not reslt then  // restore usd flags
        begin
        for i:=1 to MaxlengCTab do
          begin
          AtomUsedSmall[i] := 0;
          AtomUsedLarge[i] := 0;
          end;
        for i:=1 to Level do
          begin
          AtomUsedLarge[ResultLarge.AtList[i]] := 1;
          AtomUsedSmall[ResultSmall.AtList[i]] := 1;
          end;
        end;
      inc (j);
    until ((j > nz) or reslt);
    end;
  ResultSmall.AtList [Level] := 0;
  ResultLarge.AtList [Level] := 0;
  dec(level);
  if not reslt then
    begin
    for i:=1 to MaxlengCTab do
      begin
      AtomUsedSmall[i] := 0;
      AtomUsedLarge[i] := 0;
      end;
    for i:=1 to Level do
      begin
      AtomUsedLarge[ResultLarge.AtList[i]] := 1;
      AtomUsedSmall[ResultSmall.AtList[i]] := 1;
      end;
//    AtomUsedSmall[SmallAtIx] := 0;
//    AtomUsedLarge[LargeAtIx] := 0;
    end;
  end;
CheckValidity := reslt;
end;


(*----------------------------------------------------------------*)
(*  SearchSubStruc                                                *)
(*----------------------------------------------------------------*)

var
  i,j      : integer;
  reslt    : boolean;

begin
reslt := False;
if SumForContained (CTabSmall) then
  begin
  NrRingsLarge := RingsInMolecule;
  NrRingsSmall := CTabSmall.RingsInMolecule;
  if NrRingsSmall <= NrRingsLarge then
    begin
    i:=0;
    repeat  (* search for hetero atoms *)
      inc (i);
    until ((i = CTabSmall.FNumValidAtoms) or (CTabSmall.FAtomEntries[i].AtNum <> 6));
    if (CTabSmall.FAtomEntries[i].AtNum = 6)
      then begin         (* no hetero atoms found *)
           j := 1;
           repeat
             reslt := CheckValidity (0,0,j,1);
             inc (j);
           until ((j > FNumValidAtoms) or reslt);
           end
      else begin
           j:=0;
           reslt := False;
           repeat  (* search for hetero atoms *)
             inc (j);
             if (FAtomEntries[j].AtNum = CTabSmall.FAtomEntries[i].AtNum) then
               reslt := CheckValidity (0,0,j,i);
           until ((j = FNumValidAtoms) or (reslt = True));
           end;
    end;
  end;
MatchedAtoms := AtomUsedLarge;
SearchSubStruc := reslt;
end;

(**************************************************************)
procedure  TCTab.WriteToMDLCTabFile (var TFile:TextFile);
(**************************************************************
  writes information contained in CTab onto a MDL file;
  this file must be open, the new connection table is appended

  ATTENTION: This routine only creates the connection table, not
             a MolFile or SDF format !!
 **************************************************************)

var
  nb         : integer;
  i,j        : integer;
  BondArray  : array[1..MaxLengCTab, 1..MaxConn] of byte;
  at1, at2   : integer;

begin
nb := 0;                        { prepare and write the counts line }
for i:=1 to NAtoms do
  nb := nb + NBonds[i];
nb := nb div 2;
writeln (TFile, NAtoms:3,      { # of atoms }
                nb:3,          { # of bonds }
                '  0  0',      { # of atom lists, obsolete value }
                '  0',         { chiral flag }
                '  0',         { stext }
                '  0',         { # of reaction components }
                '  0',         { # of reactants }
                '  0',         { # of products }
                '  0',         { # of intermediates }
                '  0',         { # of additional properties -- provisional ! }
                '     ');      { version of connection table format }

for i:=1 to NAtoms do          { create the atom block }
  writeln (TFile, FAtomEntries[i].Coords[1]/1000:10:4,       { x }
                  FAtomEntries[i].Coords[2]/1000:10:4,       { y }
                  FAtomEntries[i].Coords[3]/1000:10:4,' ',   { z }
                  LeftString (CElemSymb(FAtomEntries[i].AtNum),3), { atomic symbol }
                  ' 0',                          { mass diff (isotopes) -- prov. }
                  FAtomEntries[i].Charge:3,       { charge }
                  '  0');                        { stereo center }
                 {'  0',}                        { hydrogen count - provis. }
                 {'  0',}                        { stereo care box }
                 {'  0',}                        { # of valences }
                 {'  0',}                        { H0 designator }
                 {'  0',}                        { reaction component type }
                 {'  0',}                        { reaction componnet number }
                 {'  0',}                        { atom-atom mapping }
                 {'  0',}                        { inversion flag }
                 {'  0',}                        { exact change flag }


for i:=1 to NAtoms do          { create the bond block }
  for j:=1 to MaxConn do
    BondArray[i,j] := FAtomEntries[i].Connto[j];
for i:=1 to NAtoms do
  repeat
    at1 := i;
    j := 0;
    repeat
      inc (j);
      at2 := BondArray[i,j];
    until ((j = MaxConn) or (at2 <> 0));
    if at2 <> 0 then
      begin
      writeln (TFile, at1:3,                            { first atom }
                      at2:3,                            { second atom }
                      FAtomEntries[at1].TypConn[j]:3);   { type of bond }
      BondArray[at1,j] := 0;                      { delete that bond }
      j := 0;
      repeat
        inc (j);
      until ((j = MaxConn) or (BondArray[at2,j]=At1));
      if BondArray[at2,j]=At1 then
        BondArray[at2,j]:=0;
      end;
  until (at2 = 0);
end;



(**************************************************************)
procedure  TCTab.WriteToMDLCTabStream (OutStream: TStream);
(**************************************************************
  writes information contained in CTab onto a stream in MDL format;
  the new connection table is written to the current stream position

  ATTENTION: This routine only creates the connection table, not
             a MolFile or SDF format !!
 **************************************************************)

var
  nb         : integer;
  i,j        : integer;
  BondArray  : array[1..MaxLengCTab, 1..MaxConn] of byte;
  at1, at2   : integer;

begin
nb := 0;                        { prepare and write the counts line }
for i:=1 to NAtoms do
  nb := nb + NBonds[i];
nb := nb div 2;
WritelnStream (OutStream, strff(NAtoms,3,0)+   { # of atoms }
               strff(nb,3,0)+                 { # of bonds }
               '  0  0'+      { # of atom lists, obsolete value }
               '  0'+         { chiral flag }
               '  0'+         { stext }
               '  0'+         { # of reaction components }
               '  0'+         { # of reactants }
               '  0'+         { # of products }
               '  0'+         { # of intermediates }
               '  0'+         { # of additional properties -- provisional ! }
               '     ');      { version of connection table format }

for i:=1 to NAtoms do          { create the atom block }
  WritelnStream (OutStream,
                 strff(FAtomEntries[i].Coords[1]/1000,10,4)+       { x }
                 strff(FAtomEntries[i].Coords[2]/1000,10,4)+       { y }
                 strff(FAtomEntries[i].Coords[3]/1000,10,4)+' '+   { z }
                 LeftString (CElemSymb(FAtomEntries[i].AtNum),3)+ { atomic symbol }
                 ' 0'+                          { mass diff (isotopes) -- prov. }
                 strff(FAtomEntries[i].Charge,3,0)+       { charge }
                 '  0');                        { stereo center }
                {'  0',}                        { hydrogen count - provis. }
                {'  0',}                        { stereo care box }
                {'  0',}                        { # of valences }
                {'  0',}                        { H0 designator }
                {'  0',}                        { reaction component type }
                {'  0',}                        { reaction componnet number }
                {'  0',}                        { atom-atom mapping }
                {'  0',}                        { inversion flag }
                {'  0',}                        { exact change flag }

for i:=1 to NAtoms do          { create the bond block }
  for j:=1 to MaxConn do
    BondArray[i,j] := FAtomEntries[i].Connto[j];
for i:=1 to NAtoms do
  repeat
    at1 := i;
    j := 0;
    repeat
      inc (j);
      at2 := BondArray[i,j];
    until ((j = MaxConn) or (at2 <> 0));
    if at2 <> 0 then
      begin
      WritelnStream (OutStream,
                     strff(at1,3,0)+                            { first atom }
                     strff(at2,3,0)+                            { second atom }
                     strff(FAtomEntries[at1].TypConn[j],3,0));   { type of bond }
      BondArray[at1,j] := 0;                      { delete that bond }
      j := 0;
      repeat
        inc (j);
      until ((j = MaxConn) or (BondArray[at2,j]=At1));
      if BondArray[at2,j]=At1 then
        BondArray[at2,j]:=0;
      end;
  until (at2 = 0);
end;



(**************************************************************)
function TCTab.ReadFromMDLSDFile (var AFile:TextFile;
                                  var Props: TProps): boolean;
(**************************************************************
  ENTRY:  AFile ... MDL connection table file to read from
  EXIT:   Props ... list of available physical properties
          function returns true if CTab is valid, the graphics
          coordinates are scaled to fit the area 10000x7000 (x,y only)
 ******************************************************************)

var
  i,j         : integer;
  fak, fy     : double;
  minx,miny,
  minz,maxx,
  maxy,maxz   : double;
  reslt       : boolean;
  hstr, xstr  : string;
  na,nb       : integer;  {%T.Kolber% nl wird nicht mehr benötigt }
  idummy      : integer;
  AtomSymb    : string[3];
  DiffM       : integer;
  fa, sa, bt  : integer;
  cx, cy, cz  : double;
  AtomCoords  : array [1..MaxLengCTab,1..3] of double;
  bEnd        : boolean;  {%T.Kolber%}
  code        : integer;  {%T.Kolber%}
  vv          : double;
  hstr1       : string;


{$I qsppdef.inc}       { PROVISIONAL !! get the property definitions from QSAR/PC }

begin
readln (Afile, hstr1);  { name of structure }
readln (Afile, hstr);   (* dummy read for header lines *)
readln (Afile, hstr);
reslt := false;
readln (AFile, hstr);
val (copy (hstr, 1,3), na, code);    {%T.Kolber%  wichtig, da bei 3-stelligen Zahlen kein }
val (copy (hstr, 4,3), nb, code);    { Zwischenraum zwischen na und nb entsteht !!
statt readln (Afile, na, nb, nl);  (* rest of count paramters are discarded *)}
if (na > 0) and (na < 64) then    { %T.Kolber% na<64 von mir }
  begin
  reslt := True;
  Clear;
  StrucName := hstr1;
  FNumValidAtoms := na;
  bEnd:= false;              {%T.Kolber%}
  i:= 0;
  repeat                    {%T.Kolber% Abbruch bei unvollständigem File }
    inc (i);
    readln (Afile, cx,cy,cz, AtomSymb, DiffM, FAtomEntries[i].Charge);
    AtomCoords[i,1] := cx;
    AtomCoords[i,2] := cy;
    AtomCoords[i,3] := cz;
    while AtomSymb[1] = ' ' do
      delete (atomsymb,1,1);
    while AtomSymb[length(AtomSymb)] = ' ' do
      delete (atomsymb,length(ATomSymb),1);
    FAtomEntries[i].AtNum := AtomicNumber(AtomSymb);
    FAtomEntries[i].AtWeight := IntAtWeight(FAtomEntries[i].AtNum)+DiffM;
    if eof(Afile) then bEnd:= true;
    if (i = na)   then bEnd:= true;
  until bEnd;
  if nb = 0
    then bEnd:= true
    else bEnd:= false;
  i:=0;
  while (not eof(AFile)) and (not bEnd) do
  begin
    inc (i);
    readln (Afile, fa, sa, bt);
    if bt > 4 then
      begin
      reslt := false;
      bt := 1;
      end;
    EnterConn (fa,sa,bt);
    if i = nb then bEnd:= true;
  end;
  if (not eof(AFile))
  then begin
  MakeSymmetricConnections;
  maxx := -1e10; minx := +1e10;
  maxy := -1e10; miny := +1e10;
  maxz := -1e10; minz := +1e10;
  for i:=1 to na do
    begin
    if AtomCoords[i,1] < minx then
      minx := AtomCoords[i,1];
    if AtomCoords[i,1] > maxx then
      maxx := AtomCoords[i,1];
    if AtomCoords[i,2] < miny then    {%T.Kolber% vorher bezog sich y auf AtomCoords[i,1]}
      miny := AtomCoords[i,2];
    if AtomCoords[i,2] > maxy then
      maxy := AtomCoords[i,2];
    if AtomCoords[i,3] < minz then    {%T.Kolber% vorher bezog sich z auf AtomCoords[i,1]}
      minz := AtomCoords[i,3];
    if AtomCoords[i,3] > maxz then
      maxz := AtomCoords[i,3];
    end;
  fak := 0;
  fy := 0;
  if (Maxx-minx) > 1e-6 then    { scale molecule to 800x600 area }
    fak := 800/(maxx-minx);
  if (MaxY-MinY) > 1e-6 then
    fy := 600/(maxy-miny);
  if fy > fak then
    fak := fy;
  for i:=1 to na do     {%T.Kolber% Begrenzung der Werte auf integer-Dimension}
    begin
      if (fak*(AtomCoords[i,1]-minx) > 32767) then fak:= 32767/(AtomCoords[i,1]-minx);
      if (fak*(AtomCoords[i,2]-miny) > 32767) then fak:= 32767/(AtomCoords[i,2]-miny);
      if (fak*(AtomCoords[i,3]-minz) > 32767) then fak:= 32767/(AtomCoords[i,3]-minz);
    end;
  for i:=1 to na do
    begin
    FAtomEntries[i].Coords[1] := round(fak*(AtomCoords[i,1]-minx));
    FAtomEntries[i].Coords[2] := round(fak*(AtomCoords[i,2]-miny));
    FAtomEntries[i].Coords[3] := round(fak*(AtomCoords[i,3]-minz));
    end;
  end;
  end;


  for i:=1 to MaxProps do              {D!HACK to get quick access to SDF properties }
    Props[i].ID := '';
  while not eof(AFile) and (hstr <> '$$$$') do { read physical properties }
    begin
    readln (AFile, hstr);
    uppercase(StripLTBlanks (hstr));
    if (hstr = '> <CAS_RN>') or (hstr = '> <CASREGNR>')
      then begin
           readln (AFile, hstr);
           CASNr:= hstr;
           end
      else begin
           for i:=1 to PPDefined do
             begin
             xstr := StripLTBlanks(PPLabel[i]);
             if hstr = '> <'+xstr+'>' then   { known property ? }
               begin
               readln (AFile, vv);  { read property }
               j:=0;
               repeat   { enter into property list }
                 inc (j);
               until ((j=MaxProps) or (Props[j].ID=''));
               if Props[j].ID='' then
                 begin
                 Props[j].ID := xstr;
                 Props[j].Par := vv;
                 end;
               end
             end;
           end;
    end;                        {END OF D!HACK}

(*
if eof(AFile) then
  reslt:= false;
*)
Changed;
ReadFromMDLSDFile := reslt;
end;

(**************************************************************)
procedure TCTab.WriteToClearTextFile (var AFile:TextFile);
(**************************************************************
  writes information contained in CTab onto a clear text file;
  this file must be already open, the new CTab is appended.

  Keyword '/CONTAB x y'  .... x  number of lines following
                              y  number of atoms in CTab
          This keyword specifies an ASCII version of the
          information contained in the connection table.
          The name of the structure is stored first and uses
          x-y lines; if x equals y then no name is stored.
          Following the name comes the structural information,
          one line per atom. Each line contains the following
          data: ID, atomic number, atomic weight, attribute,
                charge, x-coords, y-coords, z-coords, nr. of
                neighbors, atoms connected to, type of connections.
 **************************************************************)

var
  i,j       : integer;
  NameLines : integer;
  nb        : integer;

begin
if length(StrucName) > 0
  then NameLines := (length(StrucName)-1) div 70 + 1
  else NameLines := 0;
if NAtoms > 0 then          (* Connection Table *)
  begin
  writeln (AFile,'/CONTAB ',NameLines+2*NAtoms:4,' ',NAtoms:4);
  if NameLines > 0 then
    begin
    i := 1;
    repeat
      writeln (AFile,' ',copy(StrucName,i,70));
      inc (i,70);
    until i > length(StrucName);
    end;
  for i:=1 to NAtoms do
    begin
    writeln (AFile,' ',i:3,
                 ' ',GetAtNum(i):3,
                 ' ',GetAtWeight (i):3,
                 ' ',GetAttrib (i):3,
                 ' ',GetCharge (i):2,
                 ' ',MakeEFormat (GetCoords(i,1), 12, 5),
                 ' ',MakeEFormat (GetCoords(i,2), 12, 5),
                 ' ',MakeEFormat (GetCoords(i,3), 12, 5));
    nb := NBonds[i];
    write (AFile, ' ',nb:2);
    for j:=1 to nb do
      write (AFile,' ',GetConnTo (i,j):2);
    for j:=1 to nb do
      write (AFile,' ',GetTypConn (i,j):1);
    writeln (AFile);
    end;
  end;
end;




(**************************************************************)
function TCTab.ReadConnTabBody (var AFile:TextFile): boolean;
(**************************************************************
  ENTRY:   Afile .... open file containing data in CTB format;
                      identifier "CONTAB" has to have been read
                      just before calling ReadConnTabBody

  EXIT:    CTab is filled according to information on file,
           function return TRUE if read values are valid

  REMARKS: This routine is designed for special purposes, when
           reading a CTB file. Do not use it on a regular basis
 **************************************************************)

var
  cc          : char;
  AtIx        : integer;
  i,j         : integer;
  reslt       : boolean;
  AtomRec     : CTElem;
  Par1        : integer;
  Par2        : integer;
  hstr1       : string;
  nnb         : integer;

begin
reslt := False;
if not eof(Afile) then
  begin
  readln (AFile,Par1,Par2);  (* Par2 ... number of atoms in CTab *)
  if Par1 > 0 then
    begin
    reslt := True;
    Clear;
    for i:=1 to Par1-2*Par2 do  (* read structure name *)
      begin
      read (AFile, cc);
      readln (AFile, hstr1);
      StrucName := StrucName + hstr1;
      end;
    for i:=1 to Par2 do     (* read atom infos *)
      begin
      ClearCTElem (AtomRec);
      read (AFile, AtIx, AtomRec.AtNum, AtomRec.AtWeight, AtomRec.Attrib,
            AtomRec.Charge);
      read (AFile,AtomRec.Coords[1], AtomRec.Coords[2], AtomRec.Coords[3]);
      read (AFile, nnb);
      for j:=1 to nnb do
        read (AFile,AtomRec.ConnTo[j]);
      for j:=1 to nnb do
        read (AFile,AtomRec.TypConn[j]);
      if not AddAtom (AtomRec) then
        reslt := False;
      end;
    end;
  end;
Changed;
ReadConnTabBody := reslt;
end;


(**************************************************************)
function TCTab.ReadFromClearTextFile (var AFile:TextFile): boolean;
(**************************************************************
  ENTRY:  AFile ... ASCII text file to read from (this file has to
                    be open for read access

  EXIT:   function returns true if CTab is valid
 ******************************************************************)

var
  cc          : char;
  reslt       : boolean;
  Identi      : string[8];

begin
repeat
  repeat
    read (AFile,cc);
  until ((cc = '/') or (eof(AFile)));
  if not eof(AFile) then
    begin
    Identi := '';
    repeat
      read (AFile,cc);
      Identi := Identi + cc;
    until ((cc = ' ') or eof(AFile));
    end;
until ((pos('CONTAB',Identi) <> 0) or eof(Afile));
reslt := ReadConnTabBody (AFile);
Changed;
ReadFromClearTextFile := reslt;
end;



(**************************************************************)
function TCTab.ReadFromClearTextFileCTABG (var AFile:TextFile): boolean;
(**************************************************************
  ENTRY:  AFile ... ASCII text file to read from (this file has to
                    be open for read access

  EXIT:   function returns true if CTab is valid

  REMARK: this is the old version of reading a connection table
          (using the keyword CTABG)
 ******************************************************************)


var
  cc          : char;
  i,j         : integer;
  reslt       : boolean;
  AtomRec     : CTElem;
  Identi      : string[8];
  Par1        : integer;
  Par2        : integer;
  hstr1       : string;

begin
repeat
  repeat
    read (AFile,cc);
  until ((cc = '/') or (eof(AFile)));
  if not eof(AFile) then
    begin
    Identi := '';
    repeat
      read (AFile,cc);
      Identi := Identi + cc;
    until ((cc = ' ') or eof(AFile));
    end;
until ((pos('CTABG',Identi) <> 0) or eof(Afile));
reslt := False;
if not eof(Afile) then
  begin
  readln (AFile,Par1,Par2);  { Par2 ... number of atoms in CTab }
  if Par1 > 0 then
    begin
    reslt := True;
    Clear;
    ClearCTElem (AtomRec);
    for i:=1 to Par1-Par2 do
      begin
      read (AFile, cc);
      readln (AFile, hstr1);
      StrucName := StrucName + hstr1;
      end;
    for i:=1 to Par2 do
      begin
      read (AFile,AtomRec.AtNum,AtomRec.AtWeight, AtomRec.Attrib, AtomRec.Charge);
      read (AFile,AtomRec.Coords[1], AtomRec.Coords[2]);
      for j:=1 to MaxConnOld do
        read (AFile,AtomRec.ConnTo[j]);
      for j:=1 to MaxConnOld do
        read (AFile,AtomRec.TypConn[j]);
      if not AddAtom (AtomRec) then
        reslt := False;
      end;
    end;
  end;
Changed;
ReadFromClearTextFileCTABG := reslt;
end;


(**************************************************************)
procedure  TCTab.WriteToMDLMolFile (var TFile:TextFile; User: ShortString;
                  ProgName: string; Regnum: longint; comment: string);
(**************************************************************
  writes information contained in CTab onto a MDL Molfile;
  this file must be open, the new connection table is appended

  ENTRY:  User ...... 2 character user code
          Progname .. 8 character program name
          regnum .... internal registry number
          comment ... any comment, up to 80 characters
 **************************************************************)

var
  hstr     : string;

begin
if length(StrucName) > 80
  then writeln (TFile, '.!/', Leftstring(StrucName,77))
  else writeln (TFile, StrucName);
hstr := FormatDateTime ('mmddyyhhmm', now);
case length(User) of
    0 : User := '  ';
    1 : User := User + ' ';
  else length(user) := 2;
end;
writeln (TFile, User,                         { user code }
                LeftString(ProgName,8),       { program name }
                LeftString(hstr,10),          { date + time }
                '2D',                         { dimension code }
                ' 1',                         { scaling factor A }
                '   1.00000',                 { scaling factor B }
                '     0.00000',               { energy }
                Regnum:6);                    { internal reg. number }
writeln (TFile, Leftstring(Comment,80));
WriteToMDLCTabFile (TFile);
end;


(**************************************************************)
procedure  TCTab.WriteToMDLMolStream (OutStream: TStream; User: ShortString;
                  ProgName: string; Regnum: longint; comment: string);
(**************************************************************
  writes information contained in CTab onto a MDL Molfile stream;
  the new connection table is written to the current stream position

  ENTRY:  User ...... 2 character user code
          Progname .. 8 character program name
          regnum .... internal registry number
          comment ... any comment, up to 80 characters
 **************************************************************)

var
  hstr     : string;

begin
if length(StrucName) > 80
  then WritelnStream (OutStream, '.!/'+Leftstring(StrucName,77))
  else WritelnStream (OutStream, StrucName);
hstr := FormatDateTime ('mmddyyhhmm', now);
case length(User) of
    0 : User := '  ';
    1 : User := User + ' ';
  else length(user) := 2;
end;
WritelnStream (OutStream, User+                         { user code }
                LeftString(ProgName,8)+       { program name }
                LeftString(hstr,10)+          { date + time }
                '2D'+                         { dimension code }
                ' 1'+                         { scaling factor A }
                '   1.00000'+                 { scaling factor B }
                '     0.00000'+               { energy }
                strff(Regnum,6,0));                    { internal reg. number }
WritelnStream (OutStream, Leftstring(Comment,80));
WriteToMDLCTabStream (OutStream);
end;


(**************************************************************)
function TCTab.ReadFromMDLCTabFile (var AFile:TextFile): boolean;
(**************************************************************
  ENTRY:  AFile ... MDL connection table file to read from
  EXIT:   function returns true if CTab is valid, the graphics
          coordinates are scaled to fit the area 10000x7000 (x,y only)
 ******************************************************************)

var
  i,j         : integer;
  fak, fy     : double;
  minx,miny,
  minz,maxx,
  maxy,maxz   : double;
  reslt       : boolean;
  hstr        : string;
  na,nb       : integer;
  idummy      : integer;
  AtomSymb    : string[3];
  DiffM       : integer;
  fa, sa, bt  : integer;
  cx, cy, cz  : double;
  AtomCoords  : array [1..MaxLengCTab,1..3] of double;
  bEnd        : boolean;
  code        : integer;
  complete    : boolean;

begin
reslt := false;
readln (AFile, hstr);
val (copy (hstr, 1,3), na, code);    {%T.Kolber%  wichtig, da bei 3-stelligen Zahlen kein }
val (copy (hstr, 4,3), nb, code);    { Zwischenraum zwischen na und nb entsteht !! }
if (na > 0) and (na < 64) then
  begin
  reslt := True;
  Clear;
  FNumValidAtoms := na;
  i:= 0;
  complete := false;
  while not eof(AFile) and not complete do
    begin
    inc (i);
    readln (Afile, hstr);
    val (copy (hstr, 1, 10), cx, code);
    val (copy (hstr, 11, 10), cy, code);
    val (copy (hstr, 21, 10), cz, code);
    AtomCoords[i,1] := cx;
    AtomCoords[i,2] := cy;
    AtomCoords[i,3] := cz;
    AtomSymb := copy (hstr, 32, 3);
    while AtomSymb[1] = ' ' do
      delete (atomsymb,1,1);
    while AtomSymb[length(AtomSymb)] = ' ' do
      delete (atomsymb,length(ATomSymb),1);
    val (copy (hstr, 35, 2), DiffM, code);
    val (copy (hstr, 37, 3), FAtomEntries[i].Charge, code);
    FAtomEntries[i].AtNum := AtomicNumber(AtomSymb);
    FAtomEntries[i].AtWeight := IntAtWeight(FAtomEntries[i].AtNum)+DiffM;
    if (i = na) then
      complete := true;
    end;
  if nb = 0
    then bEnd:= true
    else bEnd:= false;
  i:=0;
  while (not eof(AFile)) and (not bEnd) do
    begin
    inc (i);
    readln (AFile, hstr);
    val (copy (hstr, 1, 3), fa, code);
    val (copy (hstr, 4, 3), sa, code);
    val (copy (hstr, 7, 3), bt, code);
    if bt > 4 then
      begin
      reslt := false;
      bt := 1;
      end;
    EnterConn (fa,sa,bt);
    if i = nb then
      bEnd:= true;
    end;
  if bEnd then
    begin
    MakeSymmetricConnections;
    maxx := -1e10; minx := +1e10;
    maxy := -1e10; miny := +1e10;
    maxz := -1e10; minz := +1e10;
    for i:=1 to na do
      begin
      if AtomCoords[i,1] < minx then
        minx := AtomCoords[i,1];
      if AtomCoords[i,1] > maxx then
        maxx := AtomCoords[i,1];
      if AtomCoords[i,2] < miny then    {%T.Kolber% vorher bezog sich y auf AtomCoords[i,1]}
        miny := AtomCoords[i,2];
      if AtomCoords[i,2] > maxy then
        maxy := AtomCoords[i,2];
      if AtomCoords[i,3] < minz then    {%T.Kolber% vorher bezog sich z auf AtomCoords[i,1]}
        minz := AtomCoords[i,3];
      if AtomCoords[i,3] > maxz then
        maxz := AtomCoords[i,3];
      end;
    fak := 0;
    fy := 0;
    if (Maxx-minx) > 1e-6 then    { scale molecule to 800x600 area }
      fak := 800/(maxx-minx);
    if (MaxY-MinY) > 1e-6 then
      fy := 600/(maxy-miny);
    if fy > fak then
      fak := fy;
    for i:=1 to na do     {%T.Kolber% Begrenzung der Werte auf integer-Dimension}
      begin
        if (fak*(AtomCoords[i,1]-minx) > 32767) then fak:= 32767/(AtomCoords[i,1]-minx);
        if (fak*(AtomCoords[i,2]-miny) > 32767) then fak:= 32767/(AtomCoords[i,2]-miny);
        if (fak*(AtomCoords[i,3]-minz) > 32767) then fak:= 32767/(AtomCoords[i,3]-minz);
      end;
    for i:=1 to na do
      begin
      FAtomEntries[i].Coords[1] := round(fak*(AtomCoords[i,1]-minx));
      FAtomEntries[i].Coords[2] := round(fak*(AtomCoords[i,2]-miny));
      FAtomEntries[i].Coords[3] := round(fak*(AtomCoords[i,3]-minz));
      end;
    end;
  end;
{  if (na > 63) then inc (TooLarge);    %T.Kolber% Fehlerzaehler}
(*
  repeat  { %T.Kolber%, 21.05.96 damit ans Ende eines Strukturobjektes kommt}
    readln (AFile, hstr);
    if hstr = '> <CAS_RN>'
      then begin
            readln (AFile, hstr);
            CASNr:= hstr;
           end;
  until (hstr = '$$$$') or eof(AFile);
  if eof(AFile) then reslt:= false;
*)
ReadFromMDLCTabFile := reslt;
end;


(**************************************************************)
function TCTab.ReadFromMDLMolFile (var AFile:TextFile): boolean;
(**************************************************************
  ENTRY:  AFile ... MDL mol file to read from
  EXIT:   function returns true if CTab is valid
 ******************************************************************)

var
  hstr        : string;
  hstr1       : string;

begin
readln (Afile, hstr1);  { name of structure }
readln (Afile, hstr);   (* dummy read for header lines *)
readln (Afile, hstr);
ReadFromMDLMolFile := ReadFromMDLCTabFile (AFile);
StrucName := hstr1;
end;


(**************************************************************)
function TCTab.ReadFromMDLCTabStream (InStream: TStream): boolean;
(**************************************************************
  ENTRY:  InStream ... stream containing MDL connection table to read from
  EXIT:   function returns true if CTab is valid, the graphics
          coordinates are scaled to fit the area 10000x7000 (x,y only)
 ******************************************************************)

var
  i,j         : integer;
  fak, fy     : double;
  minx,miny,
  minz,maxx,
  maxy,maxz   : double;
  reslt       : boolean;
  astr        : string;
  na,nb       : integer;
  idummy      : integer;
  AtomSymb    : string[3];
  DiffM       : integer;
  fa, sa, bt  : integer;
  cx, cy, cz  : double;
  AtomCoords  : array [1..MaxLengCTab,1..3] of double;
  bEnd        : boolean;
  code        : integer;
  complete    : boolean;
  eos         : boolean;

begin
reslt := false;
astr := ReadLnStream (Instream, eos, 0);
val (copy (astr, 1,3), na, code);    {%T.Kolber%  wichtig, da bei 3-stelligen Zahlen kein }
val (copy (astr, 4,3), nb, code);    { Zwischenraum zwischen na und nb entsteht !! }
if (na > 0) and (na < 64) then
  begin
  reslt := True;
  Clear;
  FNumValidAtoms := na;
  i:= 0;
  complete := false;
  while not eos and not complete do
    begin
    inc (i);
    astr := ReadLnStream (Instream, eos, 0);
    val (copy (astr, 1, 10), cx, code);
    val (copy (astr, 11, 10), cy, code);
    val (copy (astr, 21, 10), cz, code);
    AtomCoords[i,1] := cx;
    AtomCoords[i,2] := cy;
    AtomCoords[i,3] := cz;
    AtomSymb := copy (astr, 32, 3);
    while AtomSymb[1] = ' ' do
      delete (atomsymb,1,1);
    while AtomSymb[length(AtomSymb)] = ' ' do
      delete (atomsymb,length(ATomSymb),1);
    val (copy (astr, 35, 2), DiffM, code);
    val (copy (astr, 37, 3), FAtomEntries[i].Charge, code);
    FAtomEntries[i].AtNum := AtomicNumber(AtomSymb);
    FAtomEntries[i].AtWeight := IntAtWeight(FAtomEntries[i].AtNum)+DiffM;
    if (i = na) then
      complete := true;
    end;
  if nb = 0
    then bEnd:= true
    else bEnd:= false;
  i:=0;
  while (not eos) and (not bEnd) do
    begin
    inc (i);
    astr := ReadLnStream (Instream, eos, 0);
    val (copy (astr, 1, 3), fa, code);
    val (copy (astr, 4, 3), sa, code);
    val (copy (astr, 7, 3), bt, code);
    if bt > 4 then
      begin
      reslt := false;
      bt := 1;
      end;
    EnterConn (fa,sa,bt);
    if i = nb then
      bEnd:= true;
    end;
  if bEnd then
    begin
    MakeSymmetricConnections;
    maxx := -1e10; minx := +1e10;
    maxy := -1e10; miny := +1e10;
    maxz := -1e10; minz := +1e10;
    for i:=1 to na do
      begin
      if AtomCoords[i,1] < minx then
        minx := AtomCoords[i,1];
      if AtomCoords[i,1] > maxx then
        maxx := AtomCoords[i,1];
      if AtomCoords[i,2] < miny then    {%T.Kolber% vorher bezog sich y auf AtomCoords[i,1]}
        miny := AtomCoords[i,2];
      if AtomCoords[i,2] > maxy then
        maxy := AtomCoords[i,2];
      if AtomCoords[i,3] < minz then    {%T.Kolber% vorher bezog sich z auf AtomCoords[i,1]}
        minz := AtomCoords[i,3];
      if AtomCoords[i,3] > maxz then
        maxz := AtomCoords[i,3];
      end;
    fak := 0;
    fy := 0;
    if (Maxx-minx) > 1e-6 then    { scale molecule to 800x600 area }
      fak := 800/(maxx-minx);
    if (MaxY-MinY) > 1e-6 then
      fy := 600/(maxy-miny);
    if fy > fak then
      fak := fy;
    for i:=1 to na do     {%T.Kolber% Begrenzung der Werte auf integer-Dimension}
      begin
        if (fak*(AtomCoords[i,1]-minx) > 32767) then fak:= 32767/(AtomCoords[i,1]-minx);
        if (fak*(AtomCoords[i,2]-miny) > 32767) then fak:= 32767/(AtomCoords[i,2]-miny);
        if (fak*(AtomCoords[i,3]-minz) > 32767) then fak:= 32767/(AtomCoords[i,3]-minz);
      end;
    for i:=1 to na do
      begin
      FAtomEntries[i].Coords[1] := round(fak*(AtomCoords[i,1]-minx));
      FAtomEntries[i].Coords[2] := round(fak*(AtomCoords[i,2]-miny));
      FAtomEntries[i].Coords[3] := round(fak*(AtomCoords[i,3]-minz));
      end;
    end;
  end;
{  if (na > 63) then inc (TooLarge);    %T.Kolber% Fehlerzaehler}
(*
  repeat  { %T.Kolber%, 21.05.96 damit ans Ende eines Strukturobjektes kommt}
    astr := ReadLnStream (Instream, eos, 0);
    if astr = '> <CAS_RN>'
      then begin
           astr := ReadLnStream (Instream, eos, 0);
           CASNr:= astr;
           end;
  until (astr = '$$$$') or eof(AFile);
  if eof(AFile) then reslt:= false;
*)
ReadFromMDLCTabStream := reslt;
end;



(**************************************************************)
function TCTab.ReadFromMDLMolStream (InStream: TStream): boolean;
(**************************************************************
  ENTRY:  InStream ... stream containing MDL mol file to read from
  EXIT:   function returns true if CTab is valid
 ******************************************************************)

var
  astr        : string;
  astr1       : string;
  eos         : boolean;

begin
astr1 := ReadLnStream (Instream, eos, 0);    { name of structure }
astr := ReadLnStream (Instream, eos, 0); { dummy read for header lines }
astr := ReadLnStream (Instream, eos, 0);
ReadFromMDLMolStream := ReadFromMDLCTabStream (InStream);
StrucName := astr1;
end;



(**************************************************************)
procedure TCTab.WriteToMolConnXFile (IdNum: integer; var AFile:TextFile);
(**************************************************************
  writes information contained in CTab onto a MolConnX standard file;
  this file must be already open.
 **************************************************************)


var
  i, j : integer;

begin
if StrucName = ''
  then writeln (AFile, IdNum,',NoName')
  else writeln (AFile, IdNum,',',LeftString (StrucName,60));
for i:=1 to NAtoms do
  begin
  write (AFile, i,',',NrHAtoms(i),',',CElemSymb(GetAtNum(i)));
  for j:=1 to NBonds[i] do
    write (AFile, ',',GetConnTo(i,j));
  writeln (AFile);
  end;
writeln (AFile,'-1');
end;







(*********************************************************************)
procedure  TCTab.RotateWithPCA;
(*********************************************************************
  rotates the structure in a way that the 1st PC is equal to the x-axis,
  the 2nd is equal to the y-axis, and the 3rd equals the z-axis.
 *********************************************************************)

var
  AtPosMat : TMatrix;
  i,j      : integer;
  EigV     : integer;
  sum      : double;

begin
AtPosMat := TMatrix.Create (3, FNumValidAtoms);
for i:=1 to FNumValidAtoms do    { copy the atomic coordinates }
  begin
  for j:=1 to 3 do
    AtPosMat.Elem[j,i] := FAtomEntries[i].Coords[j];
  AtPosMat.Elem[3,i] := 0;
  end;
if CalcPrincComp (AtPosMat, 1, 3, 1, FNumValidAtoms, 1) then   { calc. PCA }
  begin
  for EigV:=1 to 3 do
    begin
    for i:=1 to FNumValidAtoms do    { copy the PC atomic coordinates back }
      begin
      sum := 0;
      for j:=1 to 3 do
        begin
        sum := sum + AtPosMat.Elem [j,i]*GetEigenResult(EigV,j);
        end;
      FAtomEntries[i].Coords[EigV] := round(sum);
      end;
    end;
  end;
AtPosMat.Free;
end;


(*********************************************************************)
procedure TCTab.MatchAtomTemplate (An, Nb: shortint; TypB: BondListType;
                                  var AtomsMatched: AtListType);
(*********************************************************************
(* this routine is NOT tested !!!

  ENTRY: connection table CTab
         An ....... atomic number to be matched
                    An < 0 .... atom must not have that atomic number
                    An = 0 .... atomic number is not considered at all
                    An > 0 .... atom must have that atomic number
         Nb ....... number of bonds
                    Bn < 0 .... atom must not have that number of bonds
                    Bn = 0 .... number of bonds is not considered at all
                    Bn > 0 .... atom must have that number of bonds
         TypB ..... list of bondtypes
                    must not contain negative values !

  EXIT:  AtomsMatched .... list of atoms which match the given restrictions
 *********************************************************************)

var
  i,j,k   : integer;
  Flag    : array[1..MaxLengCTab] of boolean;

begin
for i:=1 to MaxLengCTab do
  begin
  AtomsMatched.AtList[i] := 0;
  Flag[i] := true;
  end;
if An > 0                (* atomic number must be present *)
  then begin
       for i:=1 to FNumValidAtoms do  (* filter all atoms which match 'An' *)
         begin
         if (shortint(FAtomEntries[i].AtNum) <> An) then
           Flag[i] := false;
         end;
       end
  else begin             (* atomic number must NOT be present *)
       if An < 0 then
         begin
         an := -An;
         for i:=1 to FNumValidAtoms do
           begin
           if (shortint(FAtomEntries[i].AtNum) = An) then
             Flag[i] := false;
           end;
         end;
       end;

if Nb > 0                (* number of bonds are considered *)
  then begin
       for i:=1 to FNumValidAtoms do
         begin
         if (NBonds[i] <> Nb) then
           Flag[i] := false;
         end;
       end
  else begin             (* number of bonds must NOT match *)
       if Nb < 0 then
         begin
         Nb := -Nb;
         for i:=1 to FNumValidAtoms do
           begin
           if (NBonds[i] = Nb) then
             Flag[i] := false;
           end;
         end;
       end;

for i:=1 to FNumValidAtoms do   (* check type list *)
  begin
  for j:=1 to MaxConn do
    if FAtomEntries[i].TypConn[j] > btNoBond then
      begin
      for k:=1 to MaxConn do
        if FAtomEntries[i].TypConn[k] = TypB[j] then
          TypB[k] := 0;
      end;
  for j:=1 to MaxConn do
    if TypB[j] <> 0 then
      Flag[i] := false;
  end;

with AtomsMatched do
  begin
  NrAtoms := 0;
  for i:=1 to FNumValidAtoms do  (* create atom list from flags *)
    begin
    if Flag[i] then
      begin
      inc (NrAtoms);
      AtList[NrAtoms] := i;
      end;
    end;
  end;
end;


(**************************************************************************)
(*                              INIT                                      *)
(**************************************************************************)

begin
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  ShowMessagePos (GetVisMsgStr, 100,100);
{$ENDIF}
end.

