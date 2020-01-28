(**************************************************************************)
function Hex (innum:longint; places: byte): string;
(**************************************************************************
ENTRY: innum ..... integer number to be converted to hexadecimal
       places .... number of digits to create

EXIT:  A string containing a hexadecimal representation of innum
       is returned. The string is of length 'places', leading spaces
       are filled with zeroes
***************************************************************************)

const
  HexTab : array [0..15] of char =
                           ('0','1','2','3','4','5','6','7',
                            '8','9','A','B','C','D','E','F');

var
  i    : word;
  hstr : string[8];

begin
if places > 8 then places := 8;
if places < 1 then places := 1;
hstr[0] := chr(places);
for i:=places downto 1 do
  begin
  hstr[i] := HexTab[innum and $0000000F];
  innum := innum shr 4;
  end;
Hex := Hstr;
end;


(**************************************************************************)
function Octal (innum:longint; places: byte): string;
(**************************************************************************
ENTRY: innum ..... integer number to be converted to octal digits
       places .... number of digits to create

EXIT:  A string containing an octal representation of innum
       is returned. The string is of length 'places', leading spaces
       are filled with zeroes
***************************************************************************)


const
  OctTab : array [0..7] of char =
                           ('0','1','2','3','4','5','6','7');


var
  i    : word;
  hstr : string[8];

begin
if places > 8 then places := 8;
if places < 1 then places := 1;
hstr[0] := chr(places);
for i:=places downto 1 do
  begin
  hstr[i] := OctTab[innum and $00000007];
  innum := innum shr 3;
  end;
Octal := Hstr;
end;


(**************************************************************************)
function Bin (innum:longint; places: byte): string;
(**************************************************************************
ENTRY: innum ..... integer number to be converted to binary string
       places .... number of digits to create

EXIT:  A string containing a hexadecimal representation of 'innum'
       is returned. The string is of length 'places', leading
       spaces are filled with zeroes
***************************************************************************)

var
  i    : word;
  hstr : string[32];

begin
if places > 32 then places := 32;
if places < 1 then places := 1;
hstr[0] := chr(places);
for i:=places downto 1 do
  begin
  hstr[i] := chr($30 + (innum and $00000001));
  innum := innum shr 1;
  end;
Bin := Hstr;
end;

