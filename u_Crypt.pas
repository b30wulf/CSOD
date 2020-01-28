unit u_Crypt;

interface
uses Windows,Sysutils;
//------------------------------------------------------
//      КОНСТАНТЫ
//------------------------------------------------------
const

EFL_ISREADY  =  1; // Blk prepared by GOSPrepareBlock
EFL_TIMING   =  2; // Process Data Time Calc is ON

GOS_HASHSIZE  =  32;
GOS_KEYSIZE   =  36;
GOS_BLOCKSIZE =  68;
GOS_SYNCSIZE  =  12;
GOS_IMITSIZE  =  8;
//------------------------------------------------------
//      ТИПЫ ДАННЫХ
//------------------------------------------------------
TYPE
  TbBlk = array [0..7,0..7] of BYTE;
  THASH = array [0..GOS_HASHSIZE-1] of BYTE;
  TpHash= ^THash;
  // Блок подстановки с зарезервированным пространством для подготовки
  // блока к шифрованию данных функцией GOSPrepareBlock
  LPSUBSTITUTIONBLOCKEX=^SUBSTITUTIONBLOCKEX;
  SUBSTITUTIONBLOCKEX=record
    dwSize   : DWORD;                    // Размер блока подстановки
    bBlk     : TbBlk;// Исходное компактное
                                         // заполнение блока подстановки
                                         // (до обработки блока функцией
                                         // GOSPrepareBlock)
    bReserved : array [0..959] of BYTE;  // Место, зарезервированное для
                                         // расширения блока подстановки
                                         // функцией GOSPrepareBlock
  end;

  // Структура для передачи параметров в функции GOSHash и GOSHashComplete
  LPGOSHASHPARAM=^GOSHASHPARAM;
  GOSHASHPARAM=record
    nSize        : word;                 // Размер структуры в байтах
    Blk          : SUBSTITUTIONBLOCKEX;  // Блок подстановки
    dwFlags      : DWORD;                // Опции: EFL_TIMING
                                         //        EFL_ISREADY
    // Выработанная хэш-функция (готова после вызова функции GOSHashComplete())
    bHash        : THASH;

    unCallCnt    : word;                 // Общее количество вызовов функции
    dwSumSize    : DWORD;                // Объем обработанных данных в байтах
    dwDuration   : DWORD;                // Продолжительность работы функции в секундах
                                         // (заполняется при установленном флаге EFL_TIMING)
    fEntryFlag   : boolean;              // Признак первого вызова функции GOSHash
    dwSum     : array [0..7] of DWORD;   // Поле контрольной суммы
    dwSize    : array [0..7] of DWORD;   // Поле длины данных, обработанных на предыдущих итерациях
    qwDuration   : int64;                // Продолжительность работы функции в в 100-ых наносекунд
  end;
  COMMAND=(CMD_NONE, CMD_ENCRYPT , CMD_DECRYPT, CMD_MKIMIT , CMD_MKHASH );
  GOSENCRYPTMODE=( GOS_MD_NONE,
               GOS_MD_SIMPLYREPLACEMENT ,
               GOS_MD_GAMMING           ,
               GOS_MD_FEEDBACKGAMMING   );
  TKey=array[0..GOS_KEYSIZE-1] of byte;
  LPGOSEXECPARAM=^GOSEXECPARAM;
  GOSEXECPARAM=record
     nSize      : integer;
     bKey       : TKey;
     Blk        : SUBSTITUTIONBLOCKEX;  // Блок подстановки
     bSync      : array[0..GOS_SYNCSIZE-1] of byte;
     Cmd        : byte;//COMMAND;
     Mode       : byte;//GOSENCRYPTMODE;
     dwFlags    : DWORD;
     bImit      : array[0..GOS_IMITSIZE-1] of byte;
     unCallCnt  : WORD;
     dwSumSize  : DWORD;                // Объем обработанных данных в байтах
     dwDuration : DWORD;                // Продолжительность работы функции в секундах
                                        // (заполняется при установленном флаге EFL_TIMING)
     fEntryFlag : boolean;              // Признак первого вызова функции GOSHash
     qwDuration : int64;                // Продолжительность работы функции в в 100-ых наносекунд
  end;

//------------------------------------------------------
//      ЗНАЧЕНИЯ ДЛЯ ИНИЦИАЛИЗАЦИИ
//------------------------------------------------------

const
bBlkSrc:TbBlk=
(($4A, $92, $D8, $0E, $6B, $1C, $7F, $53),
( $EB, $4C, $6D, $FA, $23, $81, $07, $59),
( $58, $1D, $A3, $42, $EF, $C7, $60, $9B),
( $7D, $A1, $08, $9F, $E4, $6C, $B2, $53),
( $6C, $71, $5F, $D8, $4A, $9E, $03, $B2),
( $4B, $A0, $72, $1D, $36, $85, $9C, $FE),
( $DB, $41, $3F, $59, $0A, $E7, $68, $2C),
( $1F, $D0, $57, $A4, $92, $3E, $6B, $8C));

bKeySrc:TKey=
( $08, $00, $00, $00, $75, $3B,
  $65, $44, $62, $A8, $26, $83,
  $EA, $02, $71, $D4, $05, $3D,
  $88, $BA, $41, $D9, $C1, $11,
  $5C, $50, $20, $83, $57, $0F,
  $C5, $E8, $81, $C2, $8D, $2D);

//=====================================================
//    EXTERNAL  FUNCs&PROCs
//=====================================================
  procedure GOSPrepareBlock(lpBlock: LPSUBSTITUTIONBLOCKEX); STDcall; external 'SaDEMO32.dll';
  function GOSHash(pvMem: pointer; nMemSize: dword; lpParam: LPGOSHASHPARAM):word; STDcall; external 'SaDEMO32.dll';
  procedure GOSHashComplete(lpParam: LPGOSHASHPARAM); STDcall; external 'SaDEMO32.dll';

  procedure GOSGenKey(pvKey: pointer); STDcall; external 'SaDEMO32.dll';
  function GOSExec(pvMem: pointer; nMemSize: dword; lpParam: LPGOSEXECPARAM):word; STDcall; external 'SaDEMO32.dll';
  function GOSSimplyReplacement(pvMem: pointer; nMemSize: dword;pvKey:pointer;lpBlock: LPSUBSTITUTIONBLOCKEX;Cmd:word):dword;STDcall; external 'SaDEMO32.dll';
//=====================================================
//    GLOBAL VARs & CONSTs
//=====================================================
var
            ghp:GOSHASHPARAM;
            gep:GOSEXECPARAM;
//=====================================================
//    WORK  Classes&FUNCs&PROCs
//=====================================================
procedure InitHash(pghp:LPGOSHASHPARAM);
procedure PrepareGHBlock(pghp:LPGOSHASHPARAM);
function  CheckHash(pBlock:pointer;BlkSize:DWORD;pHash:TpHash):boolean;

procedure InitCrypt(pgep:LPGOSEXECPARAM);
procedure PrepareGEBlock(pgep:LPGOSEXECPARAM);

function EnCrypt(pBlock:pointer;BlkSize:DWORD;pgep:LPGOSEXECPARAM):DWORD;
function EnCryptText(s:string;pgep:LPGOSEXECPARAM):string;
function DeCrypt(pBlock:pointer;BlkSize:DWORD;pgep:LPGOSEXECPARAM):DWORD;
function DeCryptText(s:string;pgep:LPGOSEXECPARAM):string;

function HexStr2Array(s:string;var a:array of byte):integer;
function Array2HexStr(a:pbyteArray;c:integer;var s:string):integer;
//=====================================================
implementation
//uses u_iButTMEX;
//=====================================================
function HexStr2Array(s:string;var a:array of byte):integer;
const
    HexChars:string='0123456789ABCDEFabcdef';
var i,j,c:integer;
    b:byte; ss:string;
begin
try
    i:=1;j:=0;ss:=''; c:=0;
    while ((i<=length(s)) and (c<=length(a))) do begin
        if pos(s[i],HexChars)>0 then begin
           inc(j); ss:=ss+s[i];
           if j>=2 then begin
               b:= StrToInt('0x'+ss);
               a[c]:=b; inc(c);
           j:=0;ss:='';
           end;
        end;
        inc(i);
    end;
    result:=c;
except
result:=-1;
end;
end;

function Array2HexStr(a:pbyteArray;c:integer;var s:string):integer;
var i:integer;
begin
    s:='';
    for i:= 1 to c do s:=s+intToHex(a^[i-1],2)+' ';
    result:=c;
end;

//--------------------------------------------------------
//              HASH
//--------------------------------------------------------

procedure InitHash(pghp:LPGOSHASHPARAM);
var    i:integer;
begin
       pghp^.unCallCnt:=0; pghp^.dwSumSize:=0;
       pghp^.fEntryFlag:=false;
       pghp^.nSize:=sizeof(GOSHASHPARAM);
       for i:= 0 to 31 do pghp^.bHash[i]:=0;
       pghp^.Blk.dwSize:=256;
       for i:= 0 to 959 do pghp^.Blk.bReserved[i]:=0;
move(bBlkSrc,pghp^.Blk.bBlk,sizeOf(TbBlk));
       pghp^.dwFlags:=0;
end;

procedure PrepareGHBlock(pghp:LPGOSHASHPARAM);
begin
if (pghp^.dwFlags and EFL_ISREADY <>0) then exit;
       pghp^.dwFlags:=0;
move(bBlkSrc,pghp^.Blk.bBlk,sizeOf(TbBlk));
       GOSPrepareBlock(@pghp^.Blk);
       pghp^.dwFlags:=pghp^.dwFlags or EFL_ISREADY;
end;

function  CheckHash(pBlock:pointer;BlkSize:DWORD;pHash:TpHash):boolean;
var i:integer;
  //  ghp:GOSHASHPARAM;
begin
     InitHash(@ghp); // PrepareGHBlock(@ghp);
     GOSHash(pBlock,BlkSize,@ghp);
     GOSHashComplete(@ghp);
     result:= (ghp.bHash[0]=pHash^[0]);
     for i:= 1 to SizeOf(THASH)-1 do result:= result and (ghp.bHash[i]=pHash^[i]);
end;
//--------------------------------------------------------
//              CRYPT
//--------------------------------------------------------
procedure InitCrypt(pgep:LPGOSEXECPARAM);
begin
       pgep^.Blk.dwSize:=256;
       pgep^.fEntryFlag:=false;
       pgep^.Mode:=1;//GOSENCRYPTMODE(1);//SimplyReplacement
       pgep^.unCallCnt:=0; pgep^.dwSumSize:=0;
       pgep^.nSize:=sizeof(GOSEXECPARAM);
end;

procedure PrepareGEBlock(pgep:LPGOSEXECPARAM);
begin
       pgep^.dwFlags:=0;
       GOSPrepareBlock(@pgep^.Blk);
       pgep^.dwFlags:=pgep^.dwFlags or EFL_ISREADY;
end;

function EnCrypt(pBlock:pointer;BlkSize:DWORD;pgep:LPGOSEXECPARAM):DWORD;
begin
   result:= GOSSimplyReplacement(pBlock,BlkSize,@pgep^.bKey,@pgep^.blk,1);
end;

function EnCryptText(s:string;pgep:LPGOSEXECPARAM):string;
 var b:array of byte;
     i,j:integer;
begin
     i:=(trunc((Length(s)+1)/8)+1)*8;
     setLength(b,i);
     b[0]:=Length(s);
     move(s[1],b[1],Length(s)+1);
     EnCrypt(@b[0],i,pgep);
     result:='';
     for j:= 0 to i-1 do result:=result+' '+IntToHex(b[j],2);
end;

function DeCrypt(pBlock:pointer;BlkSize:DWORD;pgep:LPGOSEXECPARAM):DWORD;
begin
   result:= GOSSimplyReplacement(pBlock,BlkSize,@pgep^.bKey,@pgep^.blk,2);
end;

function DeCryptText(s:string;pgep:LPGOSEXECPARAM):string;
 var b:array [0..1000] of byte;
     i,j:integer;
begin
     i:=HexStr2Array(s,b);
     DeCrypt(@b[0],i,pgep);
     result:='';
     for j:= 1 to b[0] do result:= result+chr(b[j]);
end;


end.
