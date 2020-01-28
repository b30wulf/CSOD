From demos!dnews!news.demos.su!L-relcom Wed Jan 26 16:21:25 2000
Received: by infolink.tver.su (UUPC/@ v6.20, 03Nov96) with UUCP
          id AA10575; Wed, 26 Jan 2000 16:21:25 +0300 (MSK)
Received: by kremvax.demos.su (uumail v3.2.4/D) for vot;
	  Tue, 25 Jan 2000 11:59:15 +0300
Received: by news.demos.su (uumail v3.2.6/D) for vot@infolink.tver.su;
	  Tue, 25 Jan 2000 11:58:06 +0300
X-Class: Slow
Precedence: junk
To: netters
Sender: L-relcom@news.demos.su
From: "Serge Perevoznyk" <insuranc@mail.cn.ua>
Newsgroups: relcom.comp.lang.pascal
Subject: [NEWS] Re: Перекодировка писем
Date: Tue, 25 Jan 2000 10:57:01 +0200
Organization: "CINET NNTP-service"
Message-ID: <86joe5$6uq$1@elit.ci.net.ua>
References: <KCRZ711662674@kcrz.dp.ua>
NNTP-Posting-Host: ppp00-11-204.ci.net.ua
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.00.2417.2000
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Xref: demos relcom.comp.lang.pascal:20858
Lines: 203
MIME-Version: 1.0
Content-Type: text/plain; charset=x-cp866
Content-Transfer-Encoding: 8bit
Content-Length: 5879
Status: RO

{Автоматическая перекодировка русского текста из любой кодировки в Win1251
Serg Perevoznyk, 1999}

Unit Coder;
Interface

Uses SysUtils;

Const
  win = 0;
  koi8= 1;
  dos = 2;
  iso = 3;

Function AutoTrans(Const S : string) : string;

function win2n(c : char; n: byte) : char;
function n2win(c: char; n : byte) : char;
function n2m(c : char; n, m: byte): char;
function TransformString(s_in : string; n, m : byte) : string;

Implementation

Const
  EVAL_MAX = 40;
  EVAL_MIN = 5;
  CODE_MAX = 4;
  ideal_freq: array[1..128] of integer =
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,9,1,61,13,0,5,14,0
,59,4,2,8,10,10,6,30,12,12,0,1,0,7,0,1,0,3,5,0,0,1,742,166,385,157,287,869,8
2,131,961,85,279,451,365,648,1069,303,460,433,660,202,19,71,42,130,22,52,0,1
80,130,21,95,188);

Var
  cur_freq : Array[1..128] of real;

table: array[1..3,1..128] of byte = (
{koi8}
(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,2
8,29,30,31,32,33,34,35,36,37,38,39,51,41,42,43,44,45,46,47,48,49,50,51,52,53
,54,55,35,57,58,59,60,61,62,63,97,98,119,103,100,101,118,122,105,106,107,108
,109,110,111,112,114,115,116,117,102,104,99,126,123,125,127,121,120,124,96,1
13,65,66,87,71,68,69,86,90,73,74,75,76,77,78,79,80,82,83,84,85,70,72,67,94,9
1,93,95,89,88,92,64,81),
{dos}
(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,68,24,25,26,27,2
8,29,30,31,32,33,34,35,36,37,38,39,112,127,42,43,44,45,46,47,48,49,50,51,52,
53,54,55,113,57,58,59,60,61,62,63,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,1
7,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42
,43,44,45,46,47,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111)
,
{iso}
(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,2
8,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,112,113,114,115,1
16,117,118,119,120,121,122,123,124,125,126,127,48,49,50,51,52,53,54,55,56,57
,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,
83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,1
06,107,108,109,110,111));

{Back transform}
table_b: Array[1..3,1..128] of byte = (
{koi8}
(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,2
8,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53
,54,55,56,57,58,59,60,61,62,63,126,96,97,118,100,101,116,99,117,104,105,106,
107,108,109,110,111,127,112,113,114,115,102,98,124,123,103,120,125,121,119,1
22,94,64,65,86,68,69,84,67,85,72,73,74,75,76,77,78,79,95,80,81,82,83,70,66,9
2,91,71,88,93,89,87,90),
{dos}
(64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,
89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110
,111,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,23,69,70,71
,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,112
,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,40,56,114,115,1
16,117,118,119,120,121,122,123,124,125,126,41),
{iso}
(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,2
8,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,64,65,66,67,68,69
,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,
95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,1
15,116,117,118,119,120,121,122,123,124,125,126,127,48,49,50,51,52,53,54,55,5
6,57,58,59,60,61,62,63));

{transforms a character from win to n}
function win2n(c : char; n: byte) : char;
begin
  if( (ord(c) > 127) and (n>0)) then
   result := chr(128+table[ n ][ ord(c) -127 ] )
     else
       result :=  c;
end;

{transforms a character from n to win}
function n2win(c: char; n : byte):char;
begin
 if( (ord(c)> 127) and (n>0)) then
  result := chr(128+table_b[ n ][ ord(c)-127] )
    else
      result :=  c;
end;

{transforms a character from n to m}
function n2m(c : char; n, m: byte): char;
begin
  result := win2n( n2win(c, n), m );
end;

{Transforms a string from n to m}
function TransformString(s_in : string; n, m : byte) : string;
var ret : string;
    I   : integer;
    c_in, c_out: char;

begin
  ret := '';
  for i:=1 to length(s_in) do begin
  c_in := s_in[i];
  if( (c_in = #10) or (s_in[i] = #13)) then
    begin
      Ret := Ret + c_in;
    end
      else
        begin
          c_out := n2m(c_in, n, m);
          ret := ret+c_out;
      end;
  end;
result := ret;
end;


function GetString( str : string ) : string;
begin
  if Length(Str) < EVAL_MIN then
    begin
      Result := '';
      Exit;
    end
      else
        result := Copy(Str,1,EVAL_MAX);
end;

{function counts the distance of the characters set from the ideal}
function norm( str : string): real;
var ret  : real;
    incr : real;
    I    : integer;

begin
  ret := 0;
  incr := 10000/length(str);
  for i := 1 to 128 do
   cur_freq[i] := 0;
  for i := 1 to length(str) do
   cur_freq[ ord(str[i]) -127] :=  cur_freq[ ord(str[i])-127 ] + incr;
  for i := 1 to 128 do
   ret := ret + abs(cur_freq[i] - ideal_freq[i]);
  result := ret;
end;

{Function of auto Transform}
Function AutoTrans(Const S : string) : string;
var min_norm : real;
    eval_str : string;
    cur_norm : real;
    cur_str  : string;
    f2r : integer;
    F2 : integer;
begin
  f2r := 0;
  min_norm := 30000;

  if S = EmptyStr then
    begin
      result := '';
      exit;
    end;

  eval_str := GetString(S);
  if eval_str = '' then
    begin
      result := '';
      exit;
    end;

    for F2 := 0 to CODE_MAX-1 do
     begin
       cur_str  := TransformString(eval_str, f2, 0);
       cur_norm := norm(cur_str);
        if (cur_norm  < min_norm) then
          begin
            min_norm := cur_norm;
            f2r := f2;
          end;
      end;

      result := TransformString(S,f2r,0);
end;

end.




