unit knsl2a2000meter;

//{$DEFINE SS301_DEBUG}
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule,utlTimeDate,knsl3EventBox;
type
    CA2000Meter = class(CMeter)
    Private
     IsUpdate    : boolean;
     LastTimeS   : TDateTime;
     TimeReq     : TDateTime;
     m_nCounter  : Integer;
     m_nCounter1 : Integer;
     nReq        : CQueryPrimitive;
     Ke          : double;
     StateAutor,
     StateSlice  : byte;
     GraphBegin  : Integer;
     procedure   Val(const str : string; var num : integer; var err : integer);
     function    IsInteger(const Value : string) : Boolean;
     function    IsFloat(Const Value: String): Boolean;
     function    WordPosition(const N : Integer; const S : string;
                            const WordDelims : TSysCharSet) : Integer;
     function    ExtractWord(N : Integer; const S : string;
                           const WordDelims : TSysCharSet) : string;
     function    WordCount(const S : string; const WordDelims : TSysCharSet) : Integer;
     function    NormIntToStr(V : Integer; L : integer; ToLeft : boolean) : string;
     function    ConvertDate(s : string) : double;
     function    GetKascadValue(data : array of byte) : Single;
     procedure   CreteMeterReq;
     procedure   CreateMeterNumbReq;
     procedure   CreatePasswReq;
     procedure   CreateBegSliceReq;
     procedure   CreateSliceReq(nReq : CQueryPrimitive);
     procedure   CreateTimeReq;
     procedure   CreateKorrTimeReq;
     procedure   CreateSumEnReq;

     procedure   ReadSliceAns(var pMsg : CMessage);
     procedure   ReadDateTimeAns(var pMsg : CMessage);
     procedure   ReadSumEnAns(var pMsg : CMessage);
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     function    LoHandler(var pMsg:CMessage):Boolean;override;        //Обработка ответа от счетчика
     function    HiHandler(var pMsg:CMessage):Boolean;override;        //Формирование ответа от счетчика
     function    GetCommand(byCommand:Byte):Integer;
     constructor Create;
     procedure   HandQryRoutine(var pMsg:CMessage);
     procedure   MsgHead(var pMsg:CHMessage; Size:byte);
     function    Calculate_CRC(buf : array of byte; m_swLen : word):word;
     procedure   AddSresEnergGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   GetTimeValue(var nReq: CQueryPrimitive);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     //procedure   SetGraphParam(dt_Date1, dt_Date2:TDateTime; param : word);override;
    End;

const
  CRCTbl            : Array[0..255] Of byte = (
    0, 94, 188, 226, 97, 63, 221, 131, 194, 156, 126, 32, 163, 253, 31, 65,
    157, 195, 33, 127, 252, 162, 64, 30, 95, 1, 227, 189, 62, 96, 130, 220,
    35, 125, 159, 193, 66, 28, 254, 160, 225, 191, 93, 3, 128, 222, 60, 98,
    190, 224, 2, 92, 223, 129, 99, 61, 124, 34, 192, 158, 29, 67, 161, 255,
    70, 24, 250, 164, 39, 121, 155, 197, 132, 218, 56, 102, 229, 187, 89, 7,
    219, 133, 103, 57, 186, 228, 6, 88, 25, 71, 165, 251, 120, 38, 196, 154,
    101, 59, 217, 135, 4, 90, 184, 230, 167, 249, 27, 69, 198, 152, 122, 36,
    248, 166, 68, 26, 153, 199, 37, 123, 58, 100, 134, 216, 91, 5, 231, 185,
    140, 210, 48, 110, 237, 179, 81, 15, 78, 16, 242, 172, 47, 113, 147, 205,
    17, 79, 173, 243, 112, 46, 204, 146, 211, 141, 111, 49, 178, 236, 14, 80,
    175, 241, 19, 77, 206, 144, 114, 44, 109, 51, 209, 143, 12, 82, 176, 238,
    50, 108, 142, 208, 83, 13, 239, 177, 240, 174, 76, 18, 145, 207, 45, 115,
    202, 148, 118, 40, 171, 245, 23, 73, 8, 86, 180, 234, 105, 55, 213, 139,
    87, 9, 235, 181, 54, 104, 138, 212, 149, 203, 41, 119, 244, 170, 72, 22,
    233, 183, 85, 11, 136, 214, 52, 106, 43, 117, 151, 201, 74, 20, 246, 168,
    116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53);

implementation

constructor CA2000Meter.Create;
Begin

End;

procedure CA2000Meter.InitMeter(var pL2:SL2TAG);
Begin
    m_nCounter := 0;
    m_nCounter1:= 0;
    IsUpdate   := false;
    //if m_nP.m_sbyHandScenr=0 then
    //Begin
    // SetCurrQry;
    // SetGraphQry;
    //end;
    //if m_nP.m_sbyHandScenr=1 then
    //Begin
     SetHandScenario;
     SetHandScenarioGraph;
    //end;
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CA2000  Meter Created:'+
//    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
//    ' Rep:'+IntToStr(m_byRep)+
//    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;

procedure CA2000Meter.AddSresEnergGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var
    TempDate         : TDateTime;
    i, Srez,DeepSrez : integer;
    h0, m0, s0, ms0  : word;
    y0, d0, mn0      : word;
begin
    if m_nOnAutorization = 1 then
     m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    DeepSrez := 0;
    if (dt_Date2 >= dt_Date1) then
    Begin
     TempDate := dt_Date2;
     if (cDateTimeR.CompareDay(TempDate, Now) = 0 ) then TempDate := Now;
     while TempDate>=dt_Date1 do
     Begin
      if (DeepSrez > 47) then exit;
      DecodeDate(TempDate,y0,mn0,d0);
      DecodeTime(TempDate,h0,m0,s0,ms0);
      Srez := (h0*60+m0) div 30;
//      TraceL(3,m_nP.m_swMID,'(__)CL2MD::>SRZ: Mnt:'+IntToStr(mn0)+' Day:'+IntToStr(d0)+' Srz:'+IntToStr(Srez));
      m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, mn0, d0, Srez, 1);
      TempDate := TempDate - 1/48;
      Inc(DeepSrez);
     End;
    End;
end;

procedure CA2000Meter.Val(const str : string; var num : integer; var err : integer);
var i   : integer;
    zn  : integer;
begin
   num := 0;
   err := 0;
   for i := 1 to Length(str) do
   begin
     zn := Byte(str[i]) - $30;
     if (zn < 10) and (zn >= 0) then
       num := num*10 + zn
     else
     begin
       err := i;
       exit;
     end;
   end;
end;

function CA2000Meter.IsInteger(const Value : string) : Boolean;
var
   I, E              : Integer;
begin
   Val(Value, I, E);
   Result := E = 0;
end;

function CA2000Meter.IsFloat(Const Value: String): Boolean;
Var
   Res               : Extended;
Begin
   Try
     Result := TextToFloat(PChar(Value), Res, fvExtended);
   Except

   End;
End;

function CA2000Meter.WordPosition(const N : Integer; const S : string;
                                   const WordDelims : TSysCharSet) : Integer;
var
   Count, I          : Integer;
begin
   Count := 0;
   I := 1;
   Result := 0;
   while (I <= Length(S)) and (Count <> N) do begin
     { skip over delimiters }
     while (I <= Length(S)) and (S[I] in WordDelims) do Inc(I);
     { if we're not beyond end of S, we're at the start of a word }
     if I <= Length(S) then Inc(Count);
     { if not finished, find the end of the current word }
     if Count <> N then
       while (I <= Length(S)) and not (S[I] in WordDelims) do Inc(I)
     else Result := I;
   end;
end;

function CA2000Meter.ExtractWord(N : Integer; const S : string;
                                  const WordDelims : TSysCharSet) : string;
var
   I                 : Integer;
   Len               : Integer;
begin
   Len := 0;
   I := WordPosition(N, S, WordDelims);
   if I <> 0 then
     { find the end of the current word }
     while (I <= Length(S)) and not (S[I] in WordDelims) do begin
       { add the I'th character to result }
       Inc(Len);
       SetLength(Result, Len);
       Result[Len] := S[I];
       Inc(I);
     end;
   SetLength(Result, Len);
end;

function CA2000Meter.WordCount(const S : string; const WordDelims : TSysCharSet) : Integer;
var
   SLen, I           : Cardinal;
begin
   Result := 0;
   I := 1;
   SLen := Length(S);
   while I <= SLen do begin
     while (I <= SLen) and (S[I] in WordDelims) do Inc(I);
     if I <= SLen then Inc(Result);
     while (I <= SLen) and not (S[I] in WordDelims) do Inc(I);
   end;
end;

function CA2000Meter.NormIntToStr(V : Integer; L : integer; ToLeft : boolean) : string;
var
   I                 : Integer;
   s                 : Shortstring;
begin
   S := Inttostr(V);
   while length(S) > L do delete(s, L, 100);
   if ToLeft then begin
     while length(S) < L do S := '0' + S;
   end else begin
     while length(S) < L do S := S + '0';
   end;
   Result := S;
end;

function CA2000Meter.ConvertDate(s : string) : double;
var
  a                 : array[0..6] of word;
  i, j, c           : integer;
  s1                : string;
begin
  Result := 0;
  try
    i := 0;
    while (i < 7) and (s <> '') do begin
      s1 := Copy(s, 1, 2);
      Delete(s, 1, 2);
      val(s1, j, c);
      a[i] := j;
      inc(i);
    end;
    a[3] := 0;
    Result := Double(EncodeDate(a[6] + 2000, a[5], a[4])) +
      Double(EncodeTime(a[2], a[1], a[0], a[3]));
  except end;
end;

function CA2000Meter.GetKascadValue(data : array of byte) : Single;
var s1 : ShortString;
begin
  Result := 0;
  try
    s1[0] := #20;
    move(Data[1], s1[1], 20);
    s1 := ExtractWord(2, s1, ['(', ')']);
    if IsFloat(s1) then
      result := StrToFloat(s1)
    else
      if IsInteger(s1) then
        result := StrToInt(s1)
      else
        Result := StrToInt('$' + Char(Data[12]) + Char(Data[13]) + Char(Data[10]) + Char(Data[11]));
    except
  end;
end;

procedure CA2000Meter.MsgHead(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := Size;                 //pMsg.m_sbyInfo[] :=
    pMsg.m_swObjID     := m_nP.m_swMID;       //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;    //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ; //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID:= DEV_COM;       //DEF_COM
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_A2000;     //Указать тип счетчика
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

procedure CA2000Meter.CreteMeterReq;
begin
   StateAutor            := 0;
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := $42;
   m_nTxMsg.m_sbyInfo[2] := $30;
   m_nTxMsg.m_sbyInfo[3] := $03;
   MsgHead(m_nTxMsg, 11 + 4);
end;

procedure CA2000Meter.CreateMeterNumbReq;
var str : string;
begin
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := $42;
   m_nTxMsg.m_sbyInfo[2] := $30;
   m_nTxMsg.m_sbyInfo[3] := $03;
   str := '/?0000000000000000' + NormIntToStr(810, 3, true) + 'KASKAD10' +
           NormIntToStr(StrToInt(m_nP.m_sddPHAddres), 5, true)+ '!' + #13 + #10;
   move(str[1], m_nTxMsg.m_sbyInfo[0], Length(str));
   MsgHead(m_nTxMsg, 11 + Length(str));
end;

procedure CA2000Meter.CreatePasswReq;
var str : string;
    KE  : double;
begin
   KE                    := 2;
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := $50;
   m_nTxMsg.m_sbyInfo[2] := $31;
   m_nTxMsg.m_sbyInfo[3] := $02;
   str := NormIntToStr(trunc(KE), 16, false);
   str := '(' + str + ')';
   move(str[1], m_nTxMsg.m_sbyInfo[4], 18);
   m_nTxMsg.m_sbyInfo[22] := $03;
   MsgHead(m_nTxMsg, 11 + 23);
end;

procedure CA2000Meter.CreateBegSliceReq;
var str : string;
begin
   str :='.R1.0003724B(02).';
   move(str[1], m_nTxMsg.m_sbyInfo[0], Length(str));
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := $02;
   m_nTxMsg.m_sbyInfo[2] := $03;
   MsgHead(m_nTxMsg, 11 + 17);
end;

procedure CA2000Meter.CreateSliceReq(nReq : CQueryPrimitive);
var j              : integer;
    yy, mm, dd     : word;
    hh, nn, ss, zz : word;
    d1             : TDateTime;
    s              : string;
begin
   DecodeDate(LastTimeS, yy, mm, dd);
   d1 := EncodeDate(yy, nReq.m_swSpecc0, nReq.m_swSpecc1) +
         EncodeTime(nReq.m_swSpecc2 div 2, (nReq.m_swSpecc2 mod 2) * 30, 0, 0);
   if d1 > LastTimeS then
     d1 := EncodeDate(yy - 1, nReq.m_swSpecc0, nReq.m_swSpecc1) +
           EncodeTime(nReq.m_swSpecc2 div 2, (nReq.m_swSpecc2 mod 2) * 30, 0, 0);
   TimeReq := d1;
   d1 := LastTimeS - d1;
   j  := trunc(d1);
   if j > 0 then
     j := j * 48;
   DecodeTime(d1, hh, nn, ss, zz);
   j := j + (hh * 2 + nn div 30);
   j := GraphBegin - j - 1;
   if j < 0 then
     j :=  8190 + j;
//   s := IntToHex(j div cKanConst, 4) +
//        IntToHex((j mod cKanConst) * 12, 4) +
        //        '(' + IntToHex(cKanCount * cKanLen div 2, 2) + ')';
   s := '.R1.' + s + '.';
   move(s[1], m_nTxMsg.m_sbyInfo[0], 18);
   m_nTxMsg.m_sbyInfo[1] := $01;
   m_nTxMsg.m_sbyInfo[2] := $02;
   m_nTxMsg.m_sbyInfo[3] := $03;
   MsgHead(m_nTxMsg, 11 + 17);
end;

procedure CA2000Meter.CreateTimeReq;
var str : string;
begin
   str  := '.R1.00037258(07).';
   move(str[1], m_nTxMsg.m_sbyInfo[0], 18);
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[3] := $02;
   m_nTxMsg.m_sbyInfo[16]:= $03;
   MsgHead(m_nTxMsg, 11 + 17);
end;

procedure CA2000Meter.CreateKorrTimeReq;
begin

end;

procedure CA2000Meter.CreateSumEnReq;
var s : string;
begin
   s := '.R1.0101' + NormIntToStr(nReq.m_swSpecc0, 2, true) + NormIntToStr(nReq.m_swSpecc1, 2, true) + '(01).';
   move(s[1], m_nTxMsg.m_sbyInfo[0], 18);
   m_nTxMsg.m_sbyInfo[0]  := $01;
   m_nTxMsg.m_sbyInfo[3]  := $02;
   m_nTxMsg.m_sbyInfo[16] := $03;
   MsgHead(m_nTxMsg, 11 + 17);
end;

procedure CA2000Meter.ReadSliceAns(var pMsg : CMessage);
var y, m, d       : word;
    h, min, s, ms : word;
    dt            : TDateTime;
    str           : string;
    j, i, k       : integer;
    vd            : double;
    SlN           : integer;
begin
   DecodeDate(TimeReq, y, m, d);
   DecodeTime(TimeReq, h, min, s, ms);
   m_nRxMsg.m_sbyInfo[0] := 11;
   for i := 0 to 3 do
   begin
     k := i * 6;
     try
       str := '$' +  Char(pMsg.m_sbyInfo[k + 14]) + Char(pMsg.m_sbyInfo[k + 15])
                     + Char(pMsg.m_sbyInfo[k + 12]) + Char(pMsg.m_sbyInfo[k + 13]) +
                     Char(pMsg.m_sbyInfo[k + 10]) + Char(pMsg.m_sbyInfo[k + 11]);
       vd  := StrToFloat(str);
       vd  := vd * 0.2;
     except
     end;
     m_nRxMsg.m_sbyInfo[0] := 13+4;
     m_nRxMsg.m_sbyInfo[1] := QRY_SRES_ENR_EP    + i;
     m_nRxMsg.m_sbyInfo[2] := y - 2000;
     m_nRxMsg.m_sbyInfo[3] := m;
     m_nRxMsg.m_sbyInfo[4] := d;
     m_nRxMsg.m_sbyInfo[5] := h;
     m_nRxMsg.m_sbyInfo[6] := Min;
     m_nRxMsg.m_sbyInfo[7] := s;
     m_nRxMsg.m_sbyInfo[8] := 0;
     move(vd, m_nRxMsg.m_sbyInfo[9], sizeof(vd));
     SlN                   := h*2 + min div 30;
     m_nRxMsg.m_sbyServerID:= SlN;
     m_nRxMsg.m_sbyType    := DL_DATARD_IND;
     m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
     m_nRxMsg.m_swObjID    := m_nP.m_swMID;
     if IsUpdate then
       m_nRxMsg.m_sbyDirID := 1
     else
       m_nRxMsg.m_sbyDirID := 0;
     FPUT(BOX_L3, @m_nRxMsg);
   end;
end;

procedure CA2000Meter.ReadDateTimeAns(var pMsg : CMessage);
var str                  : ShortString;
    dt                   : TDateTime;
    yn, mtn, dn,
    hn, mn, sn           : word;
    y, mt, d,
    h, m, s, ms, razn    : word;
begin
    move(pMsg.m_sbyInfo[10], str[1], 14);
    str[0] := #14;
    dt   := ConvertDate(str);
    DecodeDate(Now, yn, mtn, dn);
    DecodeTime(Now, hn, mn, sn, ms);
    DecodeDate(dt, y, mt, d);
    DecodeTime(dt, h, m, s, ms);
    razn := abs((hn*3600 - h*3600) + (mn*60 - m) + (sn - s));
    if (yn <> y) or (mtn <> mt) or (dn <> d) or
     (razn > 3) then
      CreateKorrTimeReq;
end;

procedure CA2000Meter.ReadSumEnAns(var pMsg : CMessage);
var y, m, d, h, mn, s, ms : word;
    vs                    : single;
begin
    vs := GetKascadValue(pMsg.m_sbyInfo);
    m_nRxMsg.m_sbyInfo[0] := 13+4;
    m_nRxMsg.m_sbyInfo[1] := QRY_ENERGY_SUM_EP;
    m_nRxMsg.m_sbyInfo[2] := y - 2000;
    m_nRxMsg.m_sbyInfo[3] := m;
    m_nRxMsg.m_sbyInfo[4] := d;
    m_nRxMsg.m_sbyInfo[5] := h;
    m_nRxMsg.m_sbyInfo[6] := mn;
    m_nRxMsg.m_sbyInfo[7] := s;
    m_nRxMsg.m_sbyInfo[8] := 0;  //Тариф
    m_nRxMsg.m_sbyType    := DL_DATARD_IND;
    m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
    m_nRxMsg.m_swObjID    := m_nP.m_swMID;
    if IsUpdate then
      m_nRxMsg.m_sbyDirID := 1
    else
      m_nRxMsg.m_sbyDirID := 0;
    FPUT(BOX_L3, @m_nRxMsg);
end;

procedure CA2000Meter.SetCurrQry;
Begin
    with m_nObserver do
    Begin
     ClearCurrQry;
     AddCurrParam(QRY_ENERGY_SUM_EP,0,1,0,1);
     AddCurrParam(QRY_ENERGY_SUM_EP,0,2,0,1);
     AddCurrParam(QRY_ENERGY_SUM_EP,0,3,0,1);
     AddCurrParam(QRY_ENERGY_SUM_EP,0,4,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,1,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,2,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,3,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,4,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,1,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,2,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,3,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,4,0,1);
     AddCurrParam(QRY_E3MIN_POW_EP,0,0,0,1);
     AddCurrParam(QRY_E30MIN_POW_EP,0,0,0,1);
     AddCurrParam(QRY_MGAKT_POW_S,0,0,0,1);
     AddCurrParam(QRY_MGREA_POW_S,0,0,0,1);
     AddCurrParam(QRY_U_PARAM_A,0,0,0,1);
     AddCurrParam(QRY_I_PARAM_A,0,0,0,1);
     AddCurrParam(QRY_KOEF_POW_A,0,0,0,1);
     AddCurrParam(QRY_FREQ_NET,0,0,0,1);
     AddCurrParam(QRY_KPRTEL_KPR,0,0,0,1);
     AddCurrParam(QRY_DATA_TIME,0,0,0,1);
     AddCurrParam(QRY_SRES_ENR_EP,0,0,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,1,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,2,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,3,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,4,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,1,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,2,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,3,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,4,0,1);
    End;
End;

procedure CA2000Meter.SetGraphQry;
begin

end;

function CA2000Meter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)

    Result := res;
End;
                //Отправка данных в COM-PORT

function CA2000Meter.LoHandler(var pMsg:CMessage):Boolean;
Var
    res    : Boolean;
    fValue : Single;
    crc    : Byte;
Begin
    res := False;
   if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(CA2000Meter/LoHandler ON;');
   try
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
//         TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>Kaskad  DIn:',@pMsg);
        //Проверка принятого сообщения
         if (pMsg.m_swLen = 11 + 1) and (pMsg.m_sbyInfo[0] <> $06) then
         begin
//           TraceL(2,pMsg.m_swObjID,'(__)CL2MD::>Error!!!');
           exit;
         end;
         if (pMsg.m_swLen - 11 < 32) and (pMsg.m_swLen - 11 <> 1) then
         begin
            crc := Calculate_CRC(pMsg.m_sbyInfo, pMsg.m_swLen - 11);
            if crc <> pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 1] then
            begin
//              TraceL(2,pMsg.m_swObjID,'(__)CL2MD::>CRC Error!!!');
              exit;
            end;
         end;
      //----------------------------
        case nReq.m_swParamID of
          QRY_AUTORIZATION :
            case StateAutor of
              0 : begin
                    CreateMeterNumbReq;
                    FPUT(BOX_L1 ,@m_nTxMsg);
                    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
                    Inc(StateAutor);
                  end;
              1 : begin
                    CreatePasswReq;
                    FPUT(BOX_L1 ,@m_nTxMsg);
                    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
                    Inc(StateAutor);
                  end;
              2 : FinalAction;
            end;
          QRY_SRES_ENR_EP :
            case StateSlice of
              0 : begin
                    LastTimeS := Now;
                    CreateSliceReq(nReq);
                    Inc(StateSlice);
                  end;
              1 : ReadSliceAns(pMsg);
            end;
          QRY_DATA_TIME  :
            ReadDateTimeAns(pMsg);
          QRY_ENERGY_SUM_EP :
            ReadSumEnAns(pMsg);
        end;
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    End;
  except
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(CA2000Meter/LoHandler ERROR;');
  end;
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(CA2000Meter/LoHandler EXIT;');
    Result := res;
End;

procedure CA2000Meter.HandQryRoutine(var pMsg:CMessage);
Var
    Date1, Date2 : TDateTime;
    param        : word;
    wPrecize     : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := true;
    m_nCounter := 0;
    m_nCounter1:= 0;
    //FinalAction;
    m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param    := pDS.m_swData1;
    wPrecize := pDS.m_swData2;
    //m_nObserver.AddGraphParam(QM_ENT_MTR_IND, 0, 0, 0, 1);//Enter
    case param of
     QRY_SRES_ENR_EP,QRY_SRES_ENR_EM,
     QRY_SRES_ENR_RP,QRY_SRES_ENR_RM
                         :  AddSresEnergGrpahQry(Date1, Date2);
    end;
    //m_nObserver.AddGraphParam(QM_FIN_MTR_IND, 0, 0, 0, 1);//Final
end;

function CA2000Meter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res          : Boolean;
    tempP        : ShortInt;
    crc          : word;
Begin
    res := False;
  if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(CA2000Meter/HiHandler ON;');
  try
    //Обработчик для L3
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       //IsUpdate := false;
       //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
//       TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>Kaskad  DRQ:',@pMsg);
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));

       if nReq.m_swParamID=QM_ENT_MTR_IND   then Begin OnEnterAction;exit;End;
       if nReq.m_swParamID=QM_FIN_MTR_IND   then Begin OnFinalAction;exit;End;

       case nReq.m_swParamID of
         QRY_AUTORIZATION : begin
                              CreteMeterReq;
                              WaitForSingleObject(w_mGEvent, 500);
                              Inc(StateAutor);
                              CreateMeterNumbReq;
                            end;
         QRY_SRES_ENR_EP  : begin
                              if StateSlice = 0 then
                                CreateBegSliceReq
                              else
                              begin
                                if (nReq.m_swSpecc0 = 0) and (nReq.m_swSpecc0 = 1) and (nReq.m_swSpecc0 = 2) then
                                  GetTimeValue(nReq);
                                CreateSliceReq(nReq);
                              end;
                            end;
         QRY_DATA_TIME     : CreateTimeReq;
         QRY_ENERGY_SUM_EP : CreateSumEnReq;        //Не реализована!!!!!!
       else
         exit;
       end;
       if m_nTxMsg.m_swLen - 11 < 32 then
       begin
         crc := Calculate_CRC(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_swLen - 11);
         m_nTxMsg.m_sbyInfo[m_nTxMsg.m_swLen - 11] := crc;
         Inc(m_nTxMsg.m_swLen);
       end;
       FPUT(BOX_L1 ,@m_nTxMsg);                  //Отправка данных в COM-PORT
       m_nRepTimer.OnTimer(m_nP.m_swRepTime);    //Запуск таймера
      End;
      QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    End;
  except
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(CA2000Meter/HiHandler ERROR;');  
  end;
  if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(CA2000Meter/HiHandler EXIT;');
  Result := res;
End;
//QRY_ENERGY_SUM_EP
//QRY_ENERGY_DAY_EP
//QRY_ENERGY_MON_EP
//
//QRY_NAK_EN_DAY_EP
//QRY_NAK_EN_MONTH_EP
//QRY_MGAKT_POW_S
//QRY_MGREA_POW_S
//QRY_U_PARAM_S
//QRY_I_PARAM_S
//QRY_AUTORIZATION
//QRY_DATA_TIME
procedure CA2000Meter.GetTimeValue(var nReq: CQueryPrimitive);
var Year, Month, Day       : word;
Min, Hour, Sec, ms         : word;
DateLast                   : TDateTime;
begin
   DecodeDate(Now, Year, Month, Day);
   DecodeTime(Now, Hour, Min, Sec, ms);
   nReq.m_swSpecc0 := Month;
   {nReq.m_swSpecc1 := 14;
   nReq.m_swSpecc2 := 20;}
   nReq.m_swSpecc1 := Day;
   if (Hour*60 + Min) > 30 then
     nReq.m_swSpecc2 := trunc((Hour*60 + Min)/30)-1
   else
   begin
     DateLast := Now;
     cDateTimeR.DecDate(DateLast);
     DecodeDate(DateLast, Year, Month, Day);
     nReq.m_swSpecc0 := Month;
     nReq.m_swSpecc1 := Day;
     nReq.m_swSpecc2 := 47;
   end;
   nReq.m_swSpecc2 := nReq.m_swSpecc2;
end;

procedure CA2000Meter.OnEnterAction;
Begin
    StateAutor := 0;
    StateSlice := 0;
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CA2000 OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
    //FinalAction;
End;

procedure CA2000Meter.OnFinalAction;
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CA2000 OnFinalAction');
    //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
    //if m_nP.m_sbyModem=0 then FinalAction;
    //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
    FinalAction;
End;

procedure CA2000Meter.OnConnectComplette(var pMsg:CMessage);
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CA2000 OnConnectComplette');
    m_nModemState := 1;
    FinalAction;
End;

procedure CA2000Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CA2000 OnDisconnectComplette');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;

procedure CA2000Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     //if m_nModemState=1 then
     OnFinalAction;
//     TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CA2000OnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := false;
     m_nCounter := 0;
     m_nCounter1:= 0;
    End;
end;

function CA2000Meter.GetCommand(byCommand:Byte):Integer;
Var
    res : Integer;
Begin
    case byCommand of
     QRY_NULL_COMM      :   res:=0;// = 0
     QRY_ENERGY_SUM_EP  :   res:=1;//= 1;//1
     QRY_ENERGY_SUM_EM  :   res:=1;//= 2;
     QRY_ENERGY_SUM_RP  :   res:=1;//= 3;
     QRY_ENERGY_SUM_RM  :   res:=1;//= 4;
     QRY_ENERGY_DAY_EP  :   res:=2;//= 5;//2
     QRY_ENERGY_DAY_EM  :   res:=2;//= 6;
     QRY_ENERGY_DAY_RP  :   res:=2;//= 7;
     QRY_ENERGY_DAY_RM  :   res:=2;//= 8;
     QRY_ENERGY_MON_EP  :   res:=3;//= 9;//3
     QRY_ENERGY_MON_EM  :   res:=3;//= 10;
     QRY_ENERGY_MON_RP  :   res:=3;//= 11;
     QRY_ENERGY_MON_RM  :   res:=3;//= 12;
     QRY_SRES_ENR_EP    :   res:=36;//= 13;//36
     QRY_SRES_ENR_EM    :   res:=36;//= 14;
     QRY_SRES_ENR_RP    :   res:=36;//= 15;
     QRY_SRES_ENR_RM    :   res:=36;//= 16;
     QRY_NAK_EN_DAY_EP  :   res:=42;//= 17;//42
     QRY_NAK_EN_DAY_EM  :   res:=42;//= 18;
     QRY_NAK_EN_DAY_RP  :   res:=42;//= 19;
     QRY_NAK_EN_DAY_RM  :   res:=42;//= 20;
     QRY_NAK_EN_MONTH_EP:   res:=43;//= 21;//43
     QRY_NAK_EN_MONTH_EM:   res:=43;//= 22;
     QRY_NAK_EN_MONTH_RP:   res:=43;//= 23;
     QRY_NAK_EN_MONTH_RM:   res:=43;//= 24;
     //QRY_NAK_EN_YEAR_EP    res:=0;//= 25;
     //QRY_NAK_EN_YEAR_EM    res:=0;//= 26;
     //QRY_NAK_EN_YEAR_RP    res:=0;//= 27;
     //QRY_NAK_EN_YEAR_RM    res:=0;//= 28;
     QRY_E3MIN_POW_EP   :   res:=5;//= 29;//5
     QRY_E3MIN_POW_EM   :   res:=5;//= 30;
     QRY_E3MIN_POW_RP   :   res:=5;//= 31;
     QRY_E3MIN_POW_RM   :   res:=5;//= 32;
     QRY_E30MIN_POW_EP  :   res:=6;//= 33;//6
     QRY_E30MIN_POW_EM  :   res:=6;//= 34;
     QRY_E30MIN_POW_RP  :   res:=6;//= 35;
     QRY_E30MIN_POW_RM  :   res:=6;//= 36;
     QRY_MGAKT_POW_S    :   res:=8;//= 37;//8
     QRY_MGAKT_POW_A    :   res:=8;//= 38;
     QRY_MGAKT_POW_B    :   res:=8;//= 39;
     QRY_MGAKT_POW_C    :   res:=8;//= 40;
     QRY_MGREA_POW_S    :   res:=9;//= 41;//9
     QRY_MGREA_POW_A    :   res:=9;//= 42;
     QRY_MGREA_POW_B    :   res:=9;//= 43;
     QRY_MGREA_POW_C    :   res:=9;//= 44;
     QRY_U_PARAM_A      :   res:=10;//= 45;//10
     QRY_U_PARAM_B      :   res:=10;//= 46;
     QRY_U_PARAM_C      :   res:=10;//= 47;
     QRY_I_PARAM_A      :   res:=11;//= 48;//11
     QRY_I_PARAM_B      :   res:=11;//= 49;
     QRY_I_PARAM_C      :   res:=11;//= 50;
     QRY_FREQ_NET       :   res:=13;//= 54;//13
     QRY_KOEF_POW_A     :   res:=12;//= 51;//12
     QRY_KOEF_POW_B     :   res:=12;//= 52;
     QRY_KOEF_POW_C     :   res:=12;//= 53;
     QRY_KPRTEL_KPR     :   res:=24;//= 55;//24
     QRY_KPRTEL_KE      :   res:=24;//= 55;//24
     //QRY_KPRTEL_R          res:=0;//= 56;
     QRY_DATA_TIME      :   res:=32;//= 57;//
     QRY_MAX_POWER_EP   :   res:=7;
     QRY_JRNL_T1        :   res:=14;
     QRY_JRNL_T2        :   res:=15;
     QRY_JRNL_T3        :   res:=16;
     QRY_SUM_KORR_MONTH :   res:=45;
     else
     res:=-1;
    End;
    Result := res;
End;

function CA2000Meter.Calculate_CRC(buf : array of byte; m_swLen : word):word;
var
   CRC    : byte;
   i      : integer;
begin
   CRC := 0;
   for i := 0 to m_swLen - 1 do
     CRC := CRCTbl[CRC xor buf[i]];
   Result := crc;

end;

procedure CA2000Meter.RunMeter;
Begin
    //m_nRepTimer.RunTimer;
    //m_nObserver.Run;
End;

end.
