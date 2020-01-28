unit u_iButTMEX;
//=====================================================
//      Модуль для работы с НСИ
//      uses TMEXButton component 
//=====================================================
interface
uses Windows,u_crypt,inifiles,Sysutils;
//=====================================================
//      ТИПЫ
//=====================================================
//=====================================================
//    WORK  Classes&FUNCs&PROCs
//=====================================================
const
USERCOUNT=7;
type
TiUserName = array[0..11] of byte;
TUSER   = packed record
    F:byte;
    N:TiUserName;
    h:THash;//32
    L:byte;
end;
TiButtonMemBlock = record
    bKey        :       TKey;  //36
    pswSpace    :       THash; //32
    LicenseStart:       TDateTime; //8
    LicenseType:        WORD;     //4
    Tabl        :       TbBlk;     //64
    users       :       array [0..USERCOUNT-1] of TUser; //46*8= 368
    comment: array[0..29] of byte;
end;

Procedure ReadCKLBuff(pSrc,pDest:PByteArray;count,ofs:WORD);
Procedure WriteCKLBuff(pSrc,pDest:PByteArray;count,ofs:WORD);

//=====================================================
//    GLOBAL VARs & CONSTs
//=====================================================

implementation
//uses complex_test;

Procedure ReadCKLBuff(pSrc,pDest:PByteArray;count,ofs:WORD);
var i,a:integer;
begin
    for i:= 0 to count-1 do begin
       a:= (ofs+i) mod count;
       pDest^[i]:=pSrc^[a];
    end;
end;

Procedure WriteCKLBuff(pSrc,pDest:PByteArray;count,ofs:WORD);
var i,a:integer;
begin
    for i:= 0 to count-1 do begin
       a:= (ofs+i) mod count;
       pDest^[a]:=pSrc^[i];
    end;
end;




end.
