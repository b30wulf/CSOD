unit SimpleMemTest;

interface

implementation

uses
  Windows;

var
  S, S1 :String;

initialization

finalization
  if (AllocMemCount > 0) or (AllocMemSize > 0) then begin
    Str(AllocMemCount, S); Str(AllocMemSize, S1);
    S := S + ' heap blocks left' + ^M + S1 + ' heap byte left';
    MessageBox(0, PChar(S), 'Memory Leak', MB_OK or MB_ICONWARNING);
  end;
end.
