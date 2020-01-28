unit CData;

(******************************************************************)
(*                                                                *)
(*                           C D A T A                            *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1991..2001 H. Lohninger                December 1991   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Oct-07, 1999                                  *)
(*                                                                *)
(******************************************************************)

{ revision history:

1.0   released Aug-12, 1997

1.1   [Apr-07, 1998]
      CDATA now available for C++Builder version 3.0

1.2   [Aug-17, 1998]
      CDATA is now available for Delphi 4.0

1.3   [Mar-27, 1999]
      CDATA is now available for c++Builder 4.0

5.0   [Oct-10, 1999]
      CDATA is now part of SDL Component Suite 5.0
      available for Delphi 5.0

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0

}

{$O+}
{$F+}
{$A-}

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

const
  MaxChemElem = 103;       { number of elements supported by CDATA }


  function  AtomicNumber
          (Symbol : string)                       { element symbol }
                  : integer;                       { atomic number }
  function  CElemName
            (AtNr : integer)                       { atomic number }
                  : string;                         { element name }
  function  CElemSymb
            (AtNr : integer)                       { atomic number }
                  : string;                       { element symbol }
  function  CheckCASNr
          (CASNum : longint)                 { CAS registry number }
                  : boolean;                { TRUE, if CASNr is OK }
  function  ChemAtWeight
            (AtNr : integer)                       { atomic number }
                  : double;           { chemical weight of element }
  function  CompressChemName (Instring: string): string;
  function  ConvertStrToCASNr
           (InString : string;
           var CASNr : longint)
                     : boolean;
  function  DeCompressChemName (instring : string): string;
  function  ExactAtWeight
            (AtNr : integer)                       { atomic number }
                  : double;  { exact weight of most abund. isotope }
  function  FormatCASNr
           (CASNr : longint)
                  : string;
  function  IntAtWeight
            (AtNr : integer)                       { atomic number }
                  : integer;  { nom. weight of most abund. isotope }
  function  NumOuterElectrons
            (AtNr : integer)                       { atomic number }
                  : integer;    { no. of outer electrons (valence) }
  procedure PerSysCoord
            (AtNr : integer;                        {atomic number }
          var x,y : integer);           { coordinates of that atom }
  function  VDWRadius
            (AtNr : integer)                       { atomic number }
                  : double;                 { van der Waals radius }


{------------------------------------------------------------------}
implementation
{------------------------------------------------------------------}

uses
  wintypes, winprocs, sysutils {$IFDEF SHAREWARE}, dialogs {$ENDIF};

const
  ESy : array[1..MaxChemElem] of string[3] =
           (      'H','He','Li','Be', 'B', 'C', 'N', 'O', 'F',
            'Ne','Na','Mg','Al','Si', 'P', 'S','Cl','Ar', 'K',
            'Ca','Sc','Ti', 'V','Cr','Mn','Fe','Co','Ni','Cu',
            'Zn','Ga','Ge','As','Se','Br','Kr','Rb','Sr', 'Y',
            'Zr','Nb','Mo','Tc','Ru','Rh','Pd','Ag','Cd','In',
            'Sn','Sb','Te', 'I','Xe','Cs','Ba','La','Ce','Pr',
            'Nd','Pm','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm',
            'Yb','Lu','Hf','Ta', 'W','Re','Os','Ir','Pt','Au',
            'Hg','Tl','Pb','Bi','Po','At','Rn','Fr','Ra','Ac',
            'Th','Pa', 'U','Np','Pu','Am','Cm','Bk','Cf','Es',
            'Fm','Md','No','Lr');

  EName : array[1..MaxChemElem] of string[12] =
           (      'hydrogen','helium','litium','beryllium',
            'boron', 'carbon', 'nitrogen', 'oxygen', 'flourine',
            'neon','sodium','magnesium','aluminum','silicon',
            'phosphorus', 'sulfur','chlorine','argon', 'potassium',
            'calcium','scandium','titanium', 'vanadin','chromium',
            'manganese','iron','cobalt','nickel','copper',
            'zinc','gallium','germanium','arsenic','selenium',
            'bromine','krypton','rubidium','strontium', 'yttrium',
            'zirconium','niobium','molybdenum','technetium','ruthenium',
            'rhodium','palladium','silver','cadmium','indium',
            'tin','antimony','tellurium', 'iodine','xenon','cesium',
            'barium','lanthanum','cerium','praseodymium',
            'neodymium','prometium','samarium','europium','gadolinium',
            'terbium','dysprosium','holmium','erbium','thulium',
            'ytterbium','lutetium','hafnium','tantalum', 'tungsten',
            'rhenium','osmium','iridium','platinum','gold',
            'mercury','thallium','lead','bismuth','polonium','astatine',
            'radon','francium','radium','actinum',
            'thorium','protactinium', 'uranium','neptunium','plutonium',
            'americium','curium','berkelium','californium','einsteinium',
            'fermium','mendelevium','nobelium','lawrencium');


  KuerzLeng = 128;           { Laenge der Kuerzeltabelle }
  Kuerzel   : array[1..KuerzLeng] of string[7] =
          ('benzoyl','deutero','methoxy','hydroxy','bicyclo',
           'aldehyd','phospho','carboxy','mercapt','salicyl',
           'benzyl','methyl','propyl','naphth','ethoxy','sulfid',
           'phenyl','acetyl','formyl','anthra','chinon','pentyl',
           'heptyl','saeure','nitril','nitrid','phosph','sulfon',
           'pyrrol','phthal','styrol','erythr','butyl','ethyl',
           'indol','nitro','amino','chlor','ether','fluor',
           'allyl','tetra','penta','hepta','furan','hydro',
           'cyano','hexyl','octyl','epoxy','cyclo','ester',
           'inden','pyren','lacto','menth','silic','quino',
           'piper','malon','stear','xanth','xylol','vinyl',
           'ortho','ammon','thren','alpha','gamma','gluc',
           'brom','imid','mono','hexa','octa','nona','deca',
           'glyc','thio','carb','oxim','dien','semi','acid',
           'tolu','tert','anil','para','meta','acet','pyri',
           'oxid','amid','amin','phen','benz','oxal','keto',
           'prop','tere','prog','terp','quin','meth','imin',
           'fruc','ilid','hydr','beta','oxy','per','ose','oyl',
           'iod','lin','sil','tri','iso','oxo','bis','azo','yl',
           'on','en','an','ol','di','in');


{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\cdata_ct.inc}
{$ENDIF}


(**********************************************************)
function CompressChemName (Instring: string): string;
(**********************************************************
  ENTRY:   Instring .... holds chemical substance name

  EXIT:    CompressChemName compresses the string 'Instring' and
           returns the result in 'Outstring'                                  }

  REMARKS: Substrings are replaced by tokens which are marked by a
           leading bit 7. The input string is converted to lower
                   case letters. In order to be most effective the token
                   list has to be ordered by decreasing size of the tokens.
 **********************************************************)

var
  i           : integer;
  j           : integer;

begin
InString := lowerCase(instring);
for i:=1 to KuerzLeng do
  begin
  j := pos(Kuerzel[i],InString);
  while j <> 0 do
    begin
    delete(InString,j+1,length(Kuerzel[i])-1);
    InString[j] := chr(127 + i);
    j := pos(Kuerzel[i],InString);
    end;
  end;
CompressChemName := InString;
end;

(**********************************************************)
function DeCompressChemName (instring : string): string;
(**********************************************************
  ENTRY:  Instring contains the compressed string

  EXIT:   function returns unpacked string
 **********************************************************)

var
  EndOfConv   : boolean;           { signals end of conversion process }
  i           : integer;
  k           : integer;

begin
EndOfConv := false;
while not EndOfConv do
  begin
  i := 0;
  repeat
    i := i + 1;
  until (ord(InString[i]) >= 128) or (i > length(InString));
  if i <= length(InString)
    then begin
         k := ord(InString[i]) - 127;
         delete(InString,i,1);
         insert(Kuerzel[k],InString,i);
         end
    else EndOfConv := true;
  end;
DeCompressChemName := InString;
end;


(******************************************************************)
procedure PerSysCoord (AtNr: integer; var x,y: integer);
(******************************************************************
  ENTRY:      AtNr .... number of atom

  EXIT:       Routine returns coordinates of that atom. Upper left
              corner (hydrogen) has coords [0,0].
 ******************************************************************)

const
  MaxPerField = 162;          { number of fields in periodic table }
  ElemOz : array[1..MaxPerField] of byte =
                { correspondence of mask element and atomic number }
                     (1,  0,  0,  0,  0,  0,  0,  0,  0,
                      0,  0,  0,  0,  0,  0,  0,  0,  2,
                      3,  4,  0,  0,  0,  0,  0,  0,  0,
                      0,  0,  0,  5,  6,  7,  8,  9, 10,
                     11, 12,  0,  0,  0,  0,  0,  0,  0,
                      0,  0,  0, 13, 14, 15, 16, 17, 18,
                     19, 20, 21, 22, 23, 24, 25, 26, 27,
                     28, 29, 30, 31, 32, 33, 34, 35, 36,
                     37, 38, 39, 40, 41, 42, 43, 44, 45,
                     46, 47, 48, 49, 50, 51, 52, 53, 54,
                     55, 56, 57, 72, 73, 74, 75, 76, 77,
                     78, 79, 80, 81, 82, 83, 84, 85, 86,
                     87, 88, 89,  0,  0,  0,  0,  0,  0,
                      0,  0,  0,  0,  0,  0,  0,  0,  0,
                      0,  0,  0,  0, 58, 59, 60, 61, 62,
                     63, 64, 65, 66, 67, 68, 69, 70, 71,
                      0,  0,  0,  0, 90, 91, 92, 93, 94,
                     95, 96, 97, 98, 99,100,101,102,103);

var
  i : integer;

begin
x := 0;
y := 0;
if (AtNr >= 1) and (AtNr <= MaxChemElem) then
  begin
  i:= 1;
  while ElemOz[i] <> AtNr do
    inc (i);
  x := (i-1) mod 18;
  y := (i-1) div 18;
  end;
end;



(******************************************************************)
function CElemSymb (AtNr: integer): string;
(******************************************************************
  ENTRY:      AtNr .... number of atom

  EXIT:       Function returns element symbol of that atom. An empty
              string is returned if AtNr is invalid.
 ******************************************************************)


begin
if (AtNr < 1) or (AtNr > MaxChemElem)
  then CElemSymb := ''
  else CElemSymb := ESy[AtNr];
end;



(******************************************************************)
function CElemName (AtNr: integer): string;
(******************************************************************
  ENTRY:      AtNr .... number of atom

  EXIT:       Function returns element name of that atom. An empty
              string is returned if AtNr is invalid.
 ******************************************************************)


begin
if (AtNr < 1) or (AtNr > MaxChemElem)
  then CElemName := ''
  else CElemName := EName[AtNr];
end;



(******************************************************************)
function AtomicNumber (Symbol: string): integer;
(******************************************************************
  ENTRY:      Symbol .... atomic symbol

  EXIT:       Function returns the atomic number of the element
              referenced by 'Symbol'. A value of zero is returned
              if 'Symbol' is invalid;
 ******************************************************************)

var
  i : integer;

begin
i := 1;
while (ESy[i] <> Symbol) and (i < MaxChemElem) do
  inc (i);
if ESy[i] = Symbol
  then AtomicNumber := i
  else AtomicNumber := 0;
end;


(******************************************************************)
function IntAtWeight (AtNr: integer): integer;
(******************************************************************
  ENTRY:      AtNr .... number of atom

  EXIT:       Function returns the nominal mass of the isotope which
              has the largest natural abundance or which has the
              longest half decay time.
 ******************************************************************)

const
  IntAtWgt : array[1..MaxChemElem] of integer =
                     { integer atomic weights of the most abundant
                       isotope of each element }
               (1,   4,   7,   9,  11,  12,  14,  16,  19,  20,
               23,  24,  27,  28,  31,  32,  35,  40,  39,  40,
               45,  48,  51,  52,  55,  56,  59,  58,  63,  64,
               69,  74,  75,  80,  79,  84,  85,  88,  89,  90,
               93,  98,  97, 102, 103, 106, 107, 114, 115, 120,
              121, 130, 127, 132, 133, 138, 139, 140, 141, 142,
              145, 152, 153, 158, 159, 164, 165, 166, 169, 174,
              175, 180, 181, 184, 187, 192, 193, 195, 197, 202,
              205, 208, 209, 209, 211, 222, 223, 226, 227, 232,
              230, 238, 237, 244, 243, 247, 247, 251, 254, 257,
              257, 255, 256);

begin
if (AtNr < 1) or (AtNr > MaxChemElem)
  then IntAtWeight := 0
  else IntAtWeight := IntAtWgt[AtNr];
end;


(******************************************************************)
function ExactAtWeight (AtNr: integer): double;
(******************************************************************
  ENTRY:      AtNr .... number of atom

  EXIT:       Function returns the exact mass of the isotope which
              has the largest natural abundance or which has the
              longest half decay time.
 ******************************************************************)

const
  ExactAtWgt : array[1..MaxChemElem] of double  =
                     { atomic weights of the most abundant isotopes of all
                       chemical elements, C12 = 12.000 }
                (1.007825,   4.002603,   7.016005,   9.012183,
                11.009305,  12.000000,  14.003074,  15.994915,
                18.998405,  19.992440,  22.989770,  23.985044,
                26.981541,  27.976929,  30.973763,  31.972073,
                34.968854,  39.962384,  38.963709,  39.962592,
                44.955917,  47.947949,  50.943964,  51.940510,
                54.938046,  55.934934,  58.933188,  57.935336,
                62.929590,  63.929140,  68.925580,  73.921179,
                74.921600,  79.916525,  78.918332,  83.911505,
                84.911799,  87.905628,  88.905867,  89.904711,
                92.906380,  97.905410,  96.905000, 101.904348,
               102.905512, 105.903487, 106.905091, 113.903367,
               114.903875, 119.902207, 120.903822, 129.906232,
               126.904476, 131.904157, 132.905436, 137.905235,
               138.906403, 139.905484, 140.907698, 141.907766,
               144.907000, 151.919755, 152.921260, 157.924123,
               158.925386, 163.929218, 164.930357, 165.930324,
               168.934245, 173.938881, 174.940796, 179.946575,
               180.948028, 183.950975, 186.955791, 191.961514,
               192.962964, 194.964804, 196.966548, 201.970643,
               204.974438, 207.976658, 208.980401, 208.982500,
               210.987500, 222.017500, 223.019800, 226.025400,
               227.027800, 232.038074, 230.000000, 238.050816,
               237.048000, 244.060000, 243.061400, 247.070000,
               247.070200, 251.079000, 254.088100, 257.093000,
               257.094000, 255.020000, 256.020000);


begin
if (AtNr < 1) or (AtNr > MaxChemElem)
  then ExactAtWeight := 0.0
  else ExactAtWeight := ExactAtWgt[AtNr];
end;



(******************************************************************)
function ChemAtWeight (AtNr: integer): double;
(******************************************************************
  ENTRY:      AtNr .... number of atom

  EXIT:       Function returns the chemical mass of the atom with
              atom number AtNr
 ******************************************************************)

const
  ChemAtWgt : array[1..MaxChemElem] of double =
                     { atomic weights of chemical elements, according to
                       their natural isotopic distribution, C12 = 12.000 }
                (1.007970,   4.002600,   6.939000,   9.012200,
                10.811000,  12.011150,  14.006700,  15.999400,
                18.998400,  20.183000,  22.989800,  24.312000,
                26.981500,  28.086000,  30.973800,  32.064000,
                35.453000,  39.948000,  39.102000,  40.080000,
                44.956000,  47.900000,  50.942000,  51.996000,
                54.938000,  55.847000,  58.933200,  58.710000,
                63.540000,  65.370000,  69.720000,  72.590000,
                74.921600,  78.960000,  79.909000,  83.800000,
                85.470000,  87.620000,  88.905000,  91.220000,
                92.906000,  95.940000,   0.000000, 101.070000,
               102.905000, 106.400000, 107.870000, 112.400000,
               114.820000, 118.690000, 121.750000, 127.600000,
               126.904400, 131.300000, 132.905000, 137.340000,
               138.910000, 140.120000, 140.907000, 144.240000,
                 0.000000, 150.350000, 151.960000, 157.250000,
               158.924000, 162.500000, 164.930000, 167.260000,
               168.934000, 173.040000, 174.970000, 178.490000,
               180.948000, 183.850000, 186.200000, 190.200000,
               192.200000, 195.090000, 196.967000, 200.590000,
               204.370000, 207.190000, 208.980000,   0.000000,
                 0.000000,   0.000000,   0.000000,   0.000000,
                 0.000000, 232.038000,   0.000000, 238.030000,
                 0.000000,   0.000000,   0.000000,   0.000000,
                 0.000000,   0.000000,   0.000000,   0.000000,
                 0.000000,   0.000000,   0.000000);



begin
if (AtNr < 1) or (AtNr > MaxChemElem)
  then ChemAtWeight := 0
  else ChemAtWeight := ChemAtWgt[AtNr];
end;


(******************************************************************)
function VDWRadius (AtNr: integer): double;
(******************************************************************
  ENTRY:      AtNr .... number of atom

  EXIT:       Function returns the van der Waals radius of the atom
              (in Angstroem). A value of zero means that no
              information is available.
 ******************************************************************)

const
  MaxVDW = 53;
  VDW  : array [1..MaxVDW] of integer =     (* VDW radii *100 *)
             (120,0,0,0,98,180,150,140,135,0,              (* H..Ne *)
              0,0,0,138,190,185,180,0,                    (* Na..Ar *)
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,200,200,195,0,   (* K..Kr *)
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,220,220,215);    (* Rb..I *)

begin
if ((AtNr > 0) and (AtNr <= MaxVDW))
  then VDWRadius := 0.01*VDW[AtNr]
  else VDWRadius := 0.0;
end;


(******************************************************************)
function CheckCASNr (CASNum: longint): boolean;
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
function FormatCASNr (CASNr: longint): string;
(******************************************************************)

var
  astr1  : string;

begin
str (CASNr,astr1);
while length(astr1) < 4 do
  astr1 := '0'+astr1;
insert ('-',astr1,length(astr1)-2);
insert ('-',astr1,length(astr1));
FormatCASNr := astr1;
end;


(******************************************************************)
function LocalStripLTBlanks (Instring: string): string;
(******************************************************************
ENTRY: Instring ... string to be processed

EXIT:  Function returns the string 'Instring' which has stripped the
       leading and trailing blanks off.

REMARK: this is a local copy of StripLTBlanks in order to keep
        interdependency between units low
*******************************************************************)

var
  astr : string;
  i,k  : integer;

begin
astr := '';
if length(Instring) > 0 then
  begin
  i := 1;
  while (i < length(Instring)) and (Instring[i] = ' ') do
    inc (i);
  k := length(Instring);
  while (k > 1) and (Instring[k] = ' ') do
    dec (k);
  if k < i
    then astr := ''
    else astr := copy (Instring,i,k-i+1);
  end;
LocalStripLTBlanks := astr;
end;



(******************************************************************)
function ConvertStrToCASNr (InString: string; var CASNr: longint): boolean;
(******************************************************************
 ENTRY: Instring .... string which holds CAS Reg.Nr.
 EXIT:  CASNr ....... CAS-Reg. number
        function returns TRUE if Instring held a correct CAS-Reg.Nr.
 ******************************************************************)

var
  reslt   : boolean;
  i       : integer;
  Status  : integer;
  HyphCnt : integer;
  fst,sec : integer;

begin
Instring := LocalStripLTBlanks (Instring);
fst := 0;
sec := 0;
HyphCnt := 0;
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
ConvertStrToCASNr := reslt;
end;


(******************************************************************)
function NumOuterElectrons (AtNr: integer): integer;
(******************************************************************
 ENTRY: AtNr ...... atomic number of interesting atom
 EXIT:  function returns number of outer electrons; a value of zero
        is returned if 'AtNr' is invalid
 ******************************************************************)

const
  OutElectrons : array[1..MaxChemElem] of byte =
                         (1, 2, 1, 2, 3, 4, 5, 6, 7,
                       8, 1, 2, 3, 4, 5, 6, 7, 8, 1,
                       2, 2, 2, 2, 1, 2, 2, 2, 2, 1,
                       2, 3, 4, 5, 6, 7, 8, 1, 2, 2,
                       2, 1, 1, 2, 1, 1, 0, 1, 2, 3,
                       4, 5, 6, 7, 8, 1, 2, 2, 2, 2,
                       2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
                       2, 2, 2, 2, 2, 2, 2, 2, 1, 1,
                       2, 3, 4, 5, 6, 7, 8, 1, 2, 2,
                       2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
                       2, 2, 2, 2);

begin
if (AtNr < 1) or (AtNr > MaxChemElem)
  then NumOuterElectrons := 0
  else NumOuterElectrons := OutElectrons [AtNr];
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




