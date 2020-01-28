unit knsl5crypt;
interface
uses
Windows,u_Crypt,inifiles,Sysutils,Forms,u_iButTMEX;
type
    CCrypt = class
    private
     gep:GOSEXECPARAM;
    public
     constructor Create;
     destructor Destroy;override;
     procedure Init;
     function DecodeStrCrypt(const str: string): string;
     function EncodeStrCrypt(const str: string): string;
    End;
implementation
constructor CCrypt.Create;
Begin

End;
destructor CCrypt.Destroy;
Begin

End;
procedure CCrypt.Init;
Var
     strSrc,strSrc1 : String;
    // TempKey : TKey;
begin
     InitCrypt(@gep);
     //gep.bKey[0] := $12;
     PrepareGEBlock(@gep);
     GOSGenKey(@gep.bKey);
     strSrc  := EncodeStrCrypt('12345678');
     strSrc1 := DecodeStrCrypt(strSrc);
     strSrc  := strSrc1;
end;
{
procedure InitCrypt(pgep:LPGOSEXECPARAM);
procedure PrepareGEBlock(pgep:LPGOSEXECPARAM);

function EnCrypt(pBlock:pointer;BlkSize:DWORD;pgep:LPGOSEXECPARAM):DWORD;
function EnCryptText(s:string;pgep:LPGOSEXECPARAM):string;
function DeCrypt(pBlock:pointer;BlkSize:DWORD;pgep:LPGOSEXECPARAM):DWORD;
function DeCryptText(s:string;pgep:LPGOSEXECPARAM):string;
}
function CCrypt.DecodeStrCrypt(const str: string): string;
Var
     strSrc1,strSrc2 : String;
     i : Integer;
     //str1 :string;
Begin
    // str1:='угрчгрцгрхгрфгуыгртгрсгрргуугуугуугуугрыгуугуугу';
     Result := '';
     for i := 1 to Length(str) do
     strSrc1 := strSrc1 + Char(Byte(str[i]) xor $c3);
     SetLength(strSrc2, Length(strSrc1));
     ReadCKLBuff(@strSrc1[1],@strSrc2[1], Length(strSrc1),1);
     Result := DeCryptText(strSrc2,@gep);
    { for i := 1 to Length(str1) do
     strSrc1 := strSrc1 + Char(Byte(str1[i]) xor $c3);
     SetLength(strSrc2, Length(strSrc1));
     ReadCKLBuff(@strSrc1[1],@strSrc2[1], Length(strSrc1),1);
     Result := DeCryptText(strSrc2,@gep);}
End;
function CCrypt.EncodeStrCrypt(const str: string): string;
Var
     strSrc1,strSrc0 : String;
     i : Integer;
Begin
     strSrc1 := '';
     strSrc0 := EnCryptText(str,@gep);
     SetLength(strSrc1, Length(strSrc0));
     WriteCKLBuff(@strSrc0[1],@strSrc1[1], Length(strSrc0),1);
     for i := 1 to Length(strSrc1) do
     Result := Result + Char(Byte(strSrc1[i]) xor $c3);
End;

End.

