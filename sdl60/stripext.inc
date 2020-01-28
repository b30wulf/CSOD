
(**************************************************************)
function StripExtension (FName : string): string;
(**************************************************************
  ENTRY: FName .... filename

  EXIT:  function returns filename without extension
 **************************************************************)

var
  hstr1, hstr2  : string;
  i             : integer;

begin
hstr1 := ExtractFilepath(FName);
hstr2 := ExtractFileName(Fname);
i := pos ('.', hstr2);
if i > 0 then
  delete (hstr2,i,255);
StripExtension := hstr1+hstr2;
end;
