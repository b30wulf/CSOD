//{$define READ_ARCH_NAK_EN}
//{$define STANDART_CRC}
unit knsl4EKOMmodule;
//B1..B4   *(VMID + 1)   - энергия
//G1       *(VMID + 1)   - частота
//G2..G4   *(VMID + 1)   - напряжение по фазам
//G5..G7   *(VMID + 1)   - ток по фазам
//G8..G11  *(VMID + 1)   - мощность активная сумма и по фазам
//G12..G15 *(VMID + 1)   - мощность реактивная сумма и по фазам
//G16..G18 *(VMID + 1)   - коэффициенты мощности по фазам
//V                      - каналы суммирующих и груповых счетчиков
//J                      - журнал событий
Interface

Uses
  Windows, SysUtils, MMSystem, utlTimeDate,
  utltypes, utlbox, utlconst, utldatabase,
  knsl4automodule, knsl5tracer, knsl5config,knsl3lme,knsl3module,knsl2module,knsl1module,knsl3savetime;

type
  CArrayOfReal48 = packed record
    nCount  : integer;
    dt_Date : TDateTime;
    buf     : array of real48;
    ErrMask : array of integer;
  end;
  CEKOMModule = Class(CHIAutomat)
  private
    InnerFunctionPr : integer;
    InnerPDS        : CMessageData;
    DateFrRArchNak  : array [1..1024] of TDateTime;
  public
    m_nTxMsg        : CMessage;
    PhAddrAndComPrt : SPHADRANDCOMPRTS;
    m_pDDB          : PCDBDynamicConn;
    wMeterNum       : WORD;
    dwLastTime      : DWORD;
    dwTrCloseTonn   : DWORD;
    dwTRBClodeTonn  : DWORD;
    dwTonnLastTime  : DWORD;
    dwTonnBLastTime : DWORD;
    TonnelPort      : integer;
    uTimeOut        : word;
    Addr            : integer;
    password        : string;
    m_sTblL1        : SL1INITITAG;
    Procedure CreateMSGHead(Var pMsg : CMessage; len : word);
    function  EncPascStrToStr866(str : string) : string;
    procedure GetTypeAndNumberKanal(par : word; var KanType : Char; var KanNumb : integer);
    procedure Mirror(mas1, mas2 : PBYTEARRAY; Length : integer);
    procedure moveTime3(dt_DateTime : TDateTime; var mas : array of byte);
    procedure EncodeKanToVMAndCMDID(KT : char; NK : integer; var VM, CMDID : integer);
    function  DecodeRusCharToEn(ch : Char) : string;
    function  DecRusStrToEng(str : string) : string;
    function  EncodeEventToECOM(_PTable : SEVENTTAG; var Code : WORD) : string;
    function  EncodeFormatT1(var buf : array of byte) : TDateTime;
    function  EncodeFormatT3(var buf : array of byte) : TDateTime;
    function  GetPascalString(var buf : array of byte) : string;
    procedure MovePascalString(str : string; var buf : array of byte);
    procedure ErrData(var buf : array of byte; err : byte);
    Procedure FNCTimeNow(Var buf : array of byte);
    procedure FNCVersPO(Var pMsg : CMessage);
    function  GetCurrValueForEKOM(fValue:double; CMDID : integer):double;
    procedure FNCReadCurrParKanal(var pMsg : CMessage);
    procedure FNCOpenSession(Var pMsg : CMessage);
    procedure FNCReadJrnlStrFromDate(Var pMsg : CMessage);
    procedure FNCCloseSession(Var pMsg : CMessage);
    procedure FNCTimeAnswer(var pMsg : CMessage);
    function  FindValueFromTableSl(VMID, CMDID, SN : integer; Date : TDateTime; var pData : L3GRAPHDATASEKOM; var ErrMask : integer):real48;
    function  FindValueFromTableArch(VMID, CMDID : integer; Date : TDateTime; var pData : CCDatasEkom; var ErrMask : integer):real48;
    procedure FNC127ReadAndWriteSlices(Date : TDateTime; N, KanBeg, KanEnd : integer; var pData : CArrayOfReal48);
    procedure FNC127ReadAndWriteArchsNak(Date : TDateTime; N, KanBeg, KanEnd, ParT : integer; var pData : CArrayOfReal48);
    procedure FNC127ReadAndWriteArchsPrir(Date : TDateTime; N, KanBeg, KanEnd, ParT : integer; var pData : CArrayOfReal48);
    procedure FNCReadArchs(Var pMsg : CMessage);
    procedure FNCReadCurrParams(Var pMsg : CMessage);
    procedure FNCNakParams(Var pMsg : CMessage);
    procedure FNCNakParWithTime(Var pMsg : CMessage);
    procedure FNCEvents(Var pMsg : CMessage);
    procedure FNCEventsYSPD(Var pMsg : CMessage);
    procedure FNCEventsWithTime(Var pMsg : CMessage);
    procedure FNCSerialNumb(Var pMsg : CMessage);
    procedure FNCReadEvJrnl114(Var pMsg : CMessage);
    procedure FNCSetTimeYSPD(Var pMsg : CMessage);
    function  ReadEquipInfo : string;
    function  ReadDeviceInfo(DevN : integer) : string;
    function  ReadKanalInfo(KanType : Char; KanN : integer) : string;
    procedure FNCInformBlock(Var pMsg : CMessage);
    procedure FNCSetValue(Var pMsg : CMessage);
    function  Get30Interval115(var Time : TDateTime; KanNumb : integer) : double;
    function  GetDayInterval115(var Time : TDateTime; KanNumb : integer) : double;
    function  GetMonthInterval115(var Time : TDateTime; KanNumb : integer) : double;
    function  GetNow115(var Time : TDateTime; KanNumb : integer) : double;
    procedure FNCReadNakEn115(var pMsg : CMessage);
    procedure FNCSetTimeReadArch(var pMsg : CMessage);
    procedure FNCPreTonnelMsg(var pMsg: CMessage);
    procedure SendMsgToMeter(var pMsg : CMessage); //Отправка сообщения напрямую в счетчик
    procedure SendTranzAns(var pMsg : CMessage);
    procedure StartTranz;
    procedure FinishTranz;
    function  FindPortToOpenTonnel(portNum : integer) : integer; //return PortID
    procedure FNCOpenTonnelMsg(var pMsg: CMessage);
    procedure FNCUnknown(Var pMsg : CMessage);
    Procedure InitAuto(Var pTable : SL1TAG); override;
    Function  LoHandler(Var pMsg : CMessage) : Boolean; override;
    Function  HiHandler(Var pMsg : CMessage) : Boolean; override;
    function  SelfHandler(var pMsg: CMessage):Boolean; override;
    Procedure RunAuto; override;
    Function  CRC(var buf : Array Of byte; count : integer) : word;
    function  GetRealPort(nPort:Integer; var m_sTblL1 : SL1INITITAG):Integer;
    procedure FNCReadGraphFromMeters(var pMsg : CMessage);
    procedure FNCReadEvents(var pMsg : CMessage);
    procedure FNCStartPool(var pMsg : CMessage);
    procedure FNCStopPool(var pMsg : CMessage);
    procedure FNCReBoot(var pMsg : CMessage);
    procedure FNCStartFH(var pMsg : CMessage);
    procedure FNCSetL2TM(var pMsg : CMessage);
    procedure FNCSetSynchro(var pMsg : CMessage);
    procedure FNCDeepBuffer(var pMsg : CMessage);
    procedure FNCBaseSize(var pMsg : CMessage);
    procedure FNCDeepData(var pMsg : CMessage);
    procedure FNCClearData(var pMsg : CMessage);
    procedure FNCExecSQL(var pMsg : CMessage);
    procedure FNCInit(var pMsg : CMessage);
    procedure FNCDelArch(var pMsg : CMessage);
  End;
const

//G1       *(VMID + 1)   - частота
//G2..G4   *(VMID + 1)   - напряжение по фазам
//G5..G7   *(VMID + 1)   - ток по фазам
//G8..G11  *(VMID + 1)   - мощность активная сумма и по фазам
//G12..G15 *(VMID + 1)   - мощность реактивная сумма и по фазам
//V                      - каналы суммирующих и груповых счетчиков
  MAX_PACK_LEN      = 1024;
  PAR_NAMES_CURR   : array [0..14, 0..1] of string =       ( ('Частота', 'Гц'),
                                                             ('Напряжение по фазе 1', 'В'),
                                                             ('Напряжение по фазе 2', 'В'),
                                                             ('Напряжение по фазе 3', 'В'),
                                                             ('Ток по фазе 1', 'А'),
                                                             ('Ток по фазе 2', 'А'),
                                                             ('Ток по фазе 3', 'А'),
                                                             ('Активная мощность по сумме фаз', 'кВт'),
                                                             ('Активная мощность по фазе 1', 'кВт'),
                                                             ('Активная мощность по фазе 2', 'кВт'),
                                                             ('Активная мощность по фазе 3', 'кВт'),
                                                             ('Реактивная мощность по сумме фаз', 'кВар'),
                                                             ('Реактивная мощность по фазе 1', 'кВар'),
                                                             ('Реактивная мощность по фазе 2', 'кВар'),
                                                             ('Реактивная мощность по фазе 3', 'кВар')
                                                           );
  PAR_NAMES_KVNA   : array [0..3, 0..1] of string =        ( ('Энергия A+', 'кВт ч'),
                                                             ('Энергия A-', 'кВт ч'),
                                                             ('Энергия R+', 'кВар ч'),
                                                             ('Энергия R-', 'кВар ч')
                                                           );
  TONNEL_ANSWER    : string = #$00 + #$4F + #$00 + #$4E + #$61 + #$6D + #$65 + #$3D + #$0D + #$0A + #$55 + #$73 +
                       #$65 + #$72 + #$73 + #$3D + #$52 + #$57 + #$0D + #$0A + #$49 + #$6E + #$69 + #$3D + #$52 +
                       #$57 + #$0D + #$0A + #$54 + #$61 + #$72 + #$69 + #$66 + #$73 + #$3D + #$52 + #$57 + #$0D +
                       #$0A + #$57 + #$65 + #$62 + #$3D + #$52 + #$57 + #$0D + #$0A + #$54 + #$69 + #$6D + #$65 +
                       #$3D + #$52 + #$57 + #$0D + #$0A + #$52 + #$65 + #$61 + #$64 + #$43 + #$68 + #$61 + #$6E +
                       #$73 + #$3D + #$2A + #$0D + #$0A + #$57 + #$72 + #$69 + #$74 + #$65 + #$43 + #$68 + #$61 +
                       #$6E + #$73 + #$3D + #$2A + #$0D;
  srCRCHi: Array[0..255] Of byte = (
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
        $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
        $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
        $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40);

   srCRCLo: Array[0..255] Of byte = (
        $00, $C0, $C1, $01, $C3, $03, $02, $C2, $C6, $06, $07, $C7, $05, $C5, $C4, $04, $CC, $0C, $0D, $CD,
        $0F, $CF, $CE, $0E, $0A, $CA, $CB, $0B, $C9, $09, $08, $C8, $D8, $18, $19, $D9, $1B, $DB, $DA, $1A,
        $1E, $DE, $DF, $1F, $DD, $1D, $1C, $DC, $14, $D4, $D5, $15, $D7, $17, $16, $D6, $D2, $12, $13, $D3,
        $11, $D1, $D0, $10, $F0, $30, $31, $F1, $33, $F3, $F2, $32, $36, $F6, $F7, $37, $F5, $35, $34, $F4,
        $3C, $FC, $FD, $3D, $FF, $3F, $3E, $FE, $FA, $3A, $3B, $FB, $39, $F9, $F8, $38, $28, $E8, $E9, $29,
        $EB, $2B, $2A, $EA, $EE, $2E, $2F, $EF, $2D, $ED, $EC, $2C, $E4, $24, $25, $E5, $27, $E7, $E6, $26,
        $22, $E2, $E3, $23, $E1, $21, $20, $E0, $A0, $60, $61, $A1, $63, $A3, $A2, $62, $66, $A6, $A7, $67,
        $A5, $65, $64, $A4, $6C, $AC, $AD, $6D, $AF, $6F, $6E, $AE, $AA, $6A, $6B, $AB, $69, $A9, $A8, $68,
        $78, $B8, $B9, $79, $BB, $7B, $7A, $BA, $BE, $7E, $7F, $BF, $7D, $BD, $BC, $7C, $B4, $74, $75, $B5,
        $77, $B7, $B6, $76, $72, $B2, $B3, $73, $B1, $71, $70, $B0, $50, $90, $91, $51, $93, $53, $52, $92,
        $96, $56, $57, $97, $55, $95, $94, $54, $9C, $5C, $5D, $9D, $5F, $9F, $9E, $5E, $5A, $9A, $9B, $5B,
        $99, $59, $58, $98, $88, $48, $49, $89, $4B, $8B, $8A, $4A, $4E, $8E, $8F, $4F, $8D, $4D, $4C, $8C,
        $44, $84, $85, $45, $87, $47, $46, $86, $82, $42, $43, $83, $41, $81, $80, $40);

   ERR_NO_DATA = 0;                     //Ошбка нет данных
   ERR_L_STEP_OUT = 1;                  //Ошибка выход за верхний лимит
   ERR_L_STEP_DOWN = 2;                 //Ошибка выход за нижний лимит
   ERR_THIS_KANAL = 3;                  //Ошибка нет такого канала
   ERR_TRANS_FORMULA_SLICE = 4;         //Ошибка в формуле
   ERR_NO_ERROR = 5;

Implementation

Procedure CEKOMModule.InitAuto(Var pTable : SL1TAG);
Var
   i        : integer;

Begin
   //m_pDDB     := m_pDB.DynConnect(m_swAddres + 1);
   m_pDDB         := m_pDB.CreateConnect;
   wMeterNum      := High(WORD);
   uTimeOut       := 0;
   dwLastTime     := 0;
   password       := '12321';
   Addr           := 1;
   TonnelPort     := -1;
   dwTrCloseTonn  := 0;
   dwTRBClodeTonn := 0;
   dwTonnLastTime := 0;
   InnerFunctionPr:= 0;
   m_pDDB.GetL1Table(m_sTblL1);
   for i := 0 to m_sTblL1.Count - 1 do
     if (m_sTblL1.Items[i].m_sbyType = DEV_COM_LOC) and (m_sTblL1.Items[i].m_sbyProtID = DEV_MASTER) then
     begin
       TonnelPort := GetRealPort(m_sTblL1.Items[i].m_sbyPortID, m_sTblL1);
       break;
     end;
   FillChar(DateFrRArchNak, 1024*sizeof(TDateTime), 0);
End;

Procedure CEKOMModule.CreateMSGHead(Var pMsg : CMessage; len : word);
Begin
   pMsg.m_swLen := len + 11;
   pMsg.m_swObjID := m_swAddres;
   pMsg.m_sbyFrom := DIR_EKOMTOL1;
   pMsg.m_sbyFor := DIR_EKOMTOL1;
   pMsg.m_sbyType := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID := m_sbyPortID;
   pMsg.m_sbyIntID := m_sbyPortID;
End;

function CEKOMModule.EncPascStrToStr866(str : string) : string;
var i               : integer;
    cASCII, c866    : Byte;
begin
   for i := 1 to length(str) do
   begin
     cASCII := Byte(str[i]);
     c866   := Byte(str[i]);
     if (cASCII >= 192) and (cASCII <= 223) then
       c866 := $80 + cASCII - 192;
     if (cASCII >= 224) and (cASCII <= 239) then
       c866 := $A0 + cASCII - 224;
     if (cASCII >= 240) and (cASCII <= 255) then
       c866 := $E0 + cASCII - 240;
     if (cASCII = 168) then
       c866 := $F0;
     if (cASCII = 184) then
       c866 := $F1;
     str[i] := Char(c866);
   end;
   Result := str;
end;

procedure CEKOMModule.GetTypeAndNumberKanal(par : word; var KanType : Char; var KanNumb : integer);
var k, n : integer;
    t    : integer;
begin
   k := Par mod $100;
   n := Par div $100;
   if (k >= 1) and (k <= 26) then
     t := 6;
   if (k >= 33) and (k <= 58) then
     t := 7;
   for t := 0 to 5 do
     if (k >= 65 + 32*t) and (k <= 90 + 32*t) then
       break;
   KanNumb := 255*t + n;
   if t >=6 then
     KanType := Char(k - (t - 8)*32)
   else
     KanType := Char(k - t*32);
end;

procedure CEKOMModule.Mirror(mas1, mas2 : PBYTEARRAY; Length : integer);
var i : integer;
begin
   for i := 0 to Length - 1 do
     mas1[i] := mas2[Length - i - 1]; 
end;

function  CEKOMModule.DecodeRusCharToEn(ch : Char) : string;
begin
   case ch of
     'А', 'а' : Result := 'a';
     'Б', 'б' : Result := 'b';
     'В', 'в' : Result := 'v';
     'Г', 'г' : Result := 'g';
     'Д', 'д' : Result := 'd';
     'Е', 'е' : Result := 'e';
     'Ё', 'ё' : Result := 'io';
     'Ж', 'ж' : Result := 'j';
     'З', 'з' : Result := 'z';
     'И', 'и', 'Й', 'й' : Result := 'i';
     'К', 'к' : Result := 'k';
     'Л', 'л' : Result := 'l';
     'М', 'м' : Result := 'm';
     'Н', 'н' : Result := 'n';
     'О', 'о' : Result := 'o';
     'П', 'п' : Result := 'p';
     'Р', 'р' : Result := 'r';
     'С', 'с' : Result := 's';
     'Т', 'т' : Result := 't';
     'У', 'у' : Result := 'y';
     'Ф', 'ф' : Result := 'f';
     'Х', 'х' : Result := 'x';
     'Ц', 'ц' : Result := 'c';
     'Ч', 'ч' : Result := 'ch';
     'Ш', 'ш' : Result := 'sh';
     'Щ', 'щ' : Result := 'sch';
     'Ъ', 'ъ' : Result := '';
     'Ы', 'ы' : Result := 'i';
     'Ь', 'ь' : Result := '''';
     'Э', 'э' : Result := 'e';
     'Ю', 'ю' : Result := 'y';
     'Я', 'я' : Result := 'a';
     else       Result := ch;
   end;
   if (Byte(Ch) >= $C0) and (Byte(Ch) <= $DF) then
     Result[1] := UpperCase(Result)[1];
end;

function CEKOMModule.DecRusStrToEng(str : string) : string;
var i : integer;
begin
   Result := '';
   for i := 1 to Length(str) do
     Result := Result + DecodeRusCharToEn(str[i]);
end;

procedure CEKOMModule.moveTime3(dt_DateTime : TDateTime; var mas : array of byte);
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
begin
   DecodeDate(dt_DateTime, Year, Month, Day);
   DecodeTime(dt_DateTime, Hour, Min, Sec, ms);
   mas[0] := ms mod $100;
   mas[1] := (ms div $100) and $03;
   mas[2] := Sec;
   mas[3] := Min;
   mas[4] := Hour;
   mas[5] := Day;
   mas[6] := Month;
   mas[7] := Year mod $100;
   mas[8] := (Year div $100) and $0F;
   mas[9] := (cDateTimeR.GetSeason(dt_DateTime) and $01);
end;

//B1..B4   *(VMID)   - энергия
//G1       *(VMID)   - частота
//G2..G4   *(VMID)   - напряжение по фазам
//G5..G7   *(VMID)   - ток по фазам
//G8..G11  *(VMID)   - мощность активная сумма и по фазам
//G12..G15 *(VMID)   - мощность реактивная сумма и по фазам
//V                      - каналы суммирующих и груповых счетчиков
//J                      - журнал событий

procedure CEKOMModule.EncodeKanToVMAndCMDID(KT : char; NK : integer; var VM, CMDID : integer);
var remain : integer;
begin
   VM     := -1;
   CMDID  := -1;
   case KT of
     'G' : begin            //Текущие параметры
             VM     := (NK - 1) div 15;
             remain := (NK - 1) mod 15;
             case remain of
               0              : CMDID := QRY_FREQ_NET;
               1, 2, 3        : CMDID := QRY_U_PARAM_A + remain - 1;
               4, 5, 6        : CMDID := QRY_I_PARAM_A + remain - 4;
               7, 8, 9, 10    : CMDID := QRY_MGAKT_POW_S + remain - 7;
               11, 12, 13, 14 : CMDID := QRY_MGREA_POW_S + remain - 11;
 //              15, 16, 17     : CMDID := QRY_KOEF_POW_A + remain - 15
             end;
           end;
     'V' : begin            //Расчетные параметры

           end;
     'B' : begin            //Накопительные параметры (только накопленная энергия)
             VM    := (NK - 1) div 4;
             CMDID := QRY_ENERGY_SUM_EP + (NK - 1) mod 4;
           end;
     'S' : begin
             VM    := (NK - 1) div 4;
             CMDID := QRY_ENERGY_SUM_EP + (NK - 1) mod 4;
           end;
     'J' : begin            //Журнал событий
             VM     := NK;
             if (VM = 0) then
               CMDID  := 0
             else
             begin
               CMDID  := 2;
               VM     := VM - 1;
             end;
           end;
     end;
end;

function  CEKOMModule.EncodeFormatT1(var buf : array of byte) : TDateTime;
var year, month, day,
    hour, min, sec     : word;
begin
   Result := 0;
   sec    := buf[0];
   min    := buf[1];
   hour   := buf[2];
   day    := buf[3];
   month  := buf[4];
   year   := buf[5] + (buf[6] and $0F)*$100;
   try
     Result := EncodeDate(year, month, day) + EncodeTime(hour, min, sec, 0);
   except
     Result := 0;
   end;
end;

function  CEKOMModule.EncodeFormatT3(var buf : array of byte) : TDateTime;
var year, month, day,
    hour, min, sec, ms     : word;
begin
   Result := 0;
   ms     := buf[0] + (buf[1] and $03)*$100;
   sec    := buf[2];
   min    := buf[3];
   hour   := buf[4];
   day    := buf[5];
   month  := buf[6];
   year   := buf[7] + (buf[8] and $0F)*$100;
   try
     Result := EncodeDate(year, month, day) + EncodeTime(hour, min, sec, ms);
   except
     Result := 0;
   end;
end;

function  CEKOMModule.GetPascalString(var buf : array of byte) : string;
var outStr : string;
begin
   SetLength(outStr, buf[0]);
   move(buf[1], outStr[1], buf[0]);
   Result := outStr;
end;

procedure CEKOMModule.MovePascalString(str : string; var buf : array of byte);
begin
   buf[0] := Length(str);
   move(str[1], buf[1], Length(str)); 
end;


procedure CEKOMModule.ErrData(var buf : array of byte; err : byte);
begin
   //
   case err of
     ERR_NO_DATA             : begin buf[0] := $40; buf[1] := $00; end;              //Данные не готовы
     ERR_L_STEP_OUT          : begin buf[0] := $00; buf[1] := $08; end;              //Выход за верхний предел
     ERR_L_STEP_DOWN         : begin buf[0] := $00; buf[1] := $10; end;              //Выход за нижний предел
     ERR_THIS_KANAL          : begin buf[0] := $80; buf[1] := $00; end;              //Ошибка канал не описан
     ERR_TRANS_FORMULA_SLICE : begin buf[0] := $04; buf[1] := $00; end;              //Ошибка в формуле
     ERR_NO_ERROR            : begin buf[0] := $00; buf[1] := $00; end;              //Нет ошибки
   end;
end;

function  CEKOMModule.EncodeEventToECOM(_PTable : SEVENTTAG; var Code : WORD) : string;
var
   GrID : integer;
   EvID : integer;
   CMDID : integer;
   TID : integer;
begin
   GrID := _PTable.m_swGroupID;
   EvID := _PTable.m_swEventID;
   CMDID:= _PTable.m_swAdvDescription;
   TID  := trunc(_PTable.m_swDescription);
   
   Code := $0000; Result := 'Нет события';
   if GrID = 0 then
   begin
     case EvID of
       EVH_POW_ON :
          begin Code := 1; Result := 'включение' end;
       EVH_POW_OF :
          begin Code := 2; Result := 'аварийное выключение' end;
       EVH_PROG_RESTART :
          begin Code := 3; Result := 'перезагрузка по команде' end;
       EVH_MOD_SPEED, EVH_MOD_ADRES_USPD, EVH_MOD_PASSWORD, EVH_MOD_DATA :
          begin Code := 5; Result := 'изменение конфигурации' end;
       EVH_COR_TIME_KYEBD, EVH_COR_TIME_DEVICE, EVH_COR_TIME_AUTO :
          begin Code := 6; Result := 'коррекция времени' end;
       EVH_CORR_BEG :
          begin Code := 15; Result := 'коррекция времени/перед' end;
       EVH_CORR_END :
          begin Code := 16; Result := 'коррекция времени/после' end;
       EVH_STEST_PS :
          begin Code := 32; Result := 'самодиагностика успешно' end;
       EVH_STEST_FL :
          begin Code := 33; Result := 'самодиагностика неуспешно' end;
       EVH_MOD_TARIFF :
          begin Code := 129; Result := 'изм.тарифного расписания' end;
       EVH_DEL_BASE :
          begin Code := 130; Result := 'сброс показаний' end;
       EVH_OPN_COVER :
          begin Code := 137; Result := 'Открытие крышки'; end;
       EVH_CLS_COVER :
          begin Code := 138; Result := 'Закрытие крышки'; end;
       EVH_AUTO_GO_TIME :
       begin
         Code := 158;
         Result := 'переход на летнее время';
         if (cDateTimeR.GetSeason(_PTable.m_sdtEventTime) > 0) then
            Code := 157; Result := 'переход на зимнее время';
       end;
     end;
   end
   else if grID = 3 then
   begin
     case EvID of
       EVS_CHNG_OPZONE, EVS_CHNG_SBPARAM, EVS_CHNG_TPMETER, EVS_CHNG_PHCHANN,
       EVS_CHNG_PHMETER, EVS_CHNG_PARAM_ED, EVS_CHNG_GROUP, EVS_CHNG_POINT,
       EVS_CHNG_PARAM, EVS_CHNG_T_ZONE, EVS_CHNG_TPLANE, EVS_CHNG_SYZONE,
       EVS_CHNG_SZTDAY :
          begin Code := 5; Result := 'изменение конфигурации' end;
       EVS_AUTORIZ :
          begin Code := 21; Result := 'открыта сессия' end;
       EVS_END_AUTORIZ :
          begin Code := 22; Result := 'закрыта сессия' end;
       EVS_DEL_EVENT_JRNL :
          begin Code := 157; Result := 'сброс журнала' end;
       EVS_STRT_USPD :
          begin Code := 162; Result := 'пуск' end;
       EVS_STOP_USPD :
          begin Code := 163; Result := 'стоп' end;
       EVS_STSTOP :
          begin Code := 155; Result := 'выкл. Теста'; end;
       EVS_STSTART :
          begin Code := 156; Result := 'вкл. Теста'; end;
       EVS_TZONE_ED_OF :
          begin Code := 129; Result := 'изм. тарифного расписания'; end;
     end;
   end
   else
   begin
     if grID = 2 then
     begin
   case EvID of
         EVM_CHG_SPEED, EVM_CHG_CONST, EVM_CHG_PASSW :
            begin Code := 5; Result := 'Изменение конфигурации' end;
//         EVM_CORR_BUTN, EVM_CORR_INTER :
//            begin Code := 6; Result := 'Коррекция времени'; end;
         EVM_CHG_FREEDAY :
            begin Code := 128; Result := 'изм.расписания праздников'; end;
         EVM_CHG_TARIFF:
            begin Code := 129; Result := 'изм.тарифного расписания'; end;
         EVM_EXCL_PH_A :
            begin Code := 131; Result := 'выкл. Фазы 1'; end;
         EVM_INCL_PH_A :
            begin Code := 132; Result := 'вкл. Фазы 1'; end;
         EVM_EXCL_PH_B :
            begin Code := 133; Result := 'выкл. Фазы 2'; end;
         EVM_INCL_PH_B :
            begin Code := 134; Result := 'вкл. Фазы 2'; end;
         EVM_EXCL_PH_C :
            begin Code := 135; Result := 'выкл. Фазы 3'; end;
         EVM_INCL_PH_C :
            begin Code := 136; Result := 'вкл. Фазы 3'; end;
         EVM_START_CORR, EVM_CORR_BUTN, EVM_CORR_INTER:
            begin Code := 15;  Result := 'коррекция времени/перед'; end;
         EVM_FINISH_CORR:
            begin Code := 16;  Result := 'коррекция времени/после'; end;


       EVM_OPN_COVER :
          begin Code := 137; Result := 'откр.крышки' end;
       EVM_CLS_COVER :
          begin Code := 138; Result := 'закр.крышки' end;


       EVM_LSTEP_DOWN :
       begin
         case (CMDID) of // m_swTID
         QRY_FREQ_NET:
            begin Code := 139; Result := 'вых. по ниж.пред.частоты'; end;
         QRY_U_PARAM_A:
            begin Code := 143; Result := 'вых. по ниж.пред.напр. по фазе 1'; end;
         QRY_U_PARAM_B:
            begin Code := 147; Result := 'вых. по ниж.пред.напр. по фазе 2'; end;
         QRY_U_PARAM_C:
            begin Code := 151; Result := 'вых. по ниж.пред.напр. по фазе 3'; end;
         end;
       end;

       EVM_L_NORMAL :
       begin
         case (CMDID) of // m_swTID
         QRY_FREQ_NET:
            begin Code := 140; Result := 'возврат по ниж.пред.частоты'; end;
         QRY_U_PARAM_A:
            begin Code := 144; Result := 'возврат по ниж.пред.напр. по фазе 1'; end;
         QRY_U_PARAM_B:
            begin Code := 148; Result := 'возврат по ниж.пред.напр. по фазе 2'; end;
         QRY_U_PARAM_C:
            begin Code := 152; Result := 'возврат по ниж.пред.напр. по фазе 3'; end;
         QRY_SRES_ENR_EP, QRY_SRES_ENR_EM, QRY_SRES_ENR_RP, QRY_SRES_ENR_RM :
            begin Code := 175; Result := 'возврат в предел мощности'; end;
         end;
       end;

       EVM_LSTEP_UP :
       begin
         case (CMDID) of
         QRY_FREQ_NET :
            begin Code := 141; Result := 'вых. по верх.пред.частоты'; end;
         QRY_U_PARAM_A :
            begin Code := 145; Result := 'вых. по верх.пред.напр. по фазе 1'; end;
         QRY_U_PARAM_B :
            begin Code := 149; Result := 'вых. по верх.пред.напр. по фазе 2'; end;
         QRY_U_PARAM_C :
            begin Code := 153; Result := 'вых. по верх.пред.напр. по фазе 3'; end;

         QRY_MGAKT_POW_S,QRY_MGAKT_POW_A,QRY_MGAKT_POW_B,QRY_MGAKT_POW_C,
         QRY_MGREA_POW_S,QRY_MGREA_POW_A,QRY_MGREA_POW_B,QRY_MGREA_POW_C :
            begin Code := 174; Result := 'выход за предел мощности' end;

         QRY_ENERGY_DAY_EP,QRY_ENERGY_DAY_EM,QRY_ENERGY_DAY_RP,QRY_ENERGY_DAY_RM,
         QRY_ENERGY_MON_EP,QRY_ENERGY_MON_EM,QRY_ENERGY_MON_RP,QRY_ENERGY_MON_RM :
         begin
            case (TID) of
            1: begin
               Code := 176;
               Result := 'выход за предел энергии по тарифу 1';
            end;
            2: begin
               Code := 177;
               Result := 'выход за предел энергии по тарифу 2';
            end;
            3: begin
               Code := 178;
               Result := 'выход за предел энергии по тарифу 3';
            end;
            4: begin
               Code := 179;
               Result := 'выход за предел энергии по тарифу 4';
            end;
         end;
         end;
         QRY_SRES_ENR_EP :
            begin Code := 430; Result := 'выход за предел активной прямой мощности' end;
         QRY_SRES_ENR_EM:
            begin Code := 686; Result := 'выход за предел активной обратной мощности' end;
         else
            begin Code := 188; Result := 'превышение лимита' end;          	 
       end;
      end;
       end;
end;
     if GrID = 1 then
     begin
       case EvID of   
         EVA_METER_NO_ANSWER :
           begin Code := 28; Result := 'Пропала связь с модулем'; end;
         EVA_METER_ANSWER    :
           begin Code := 29; Result := 'Восстановлена связь с модлем'; end;
       end;
     end;
   end;
end;

Procedure CEKOMModule.FNCTimeNow(Var buf : array of byte);
Var
  year, month, day   : word;
  hour, min, sec, ms : word;
  fnc                : byte;
Begin
   DecodeDate(Now, year, month, day);
   DecodeTime(Now, hour, min, sec, ms);
   buf[0]  := ms Mod 256;
   buf[1]  := ms Div 256;
   buf[2]  := sec;
   buf[3]  := min;
   buf[4]  := hour;
   buf[5]  := day;
   buf[6]  := month;
   buf[7]  := year Mod 256;
   buf[8]  := year Div 256;
   buf[9]  := cDateTimeR.GetSeason(Now);
End;

function CEKOMModule.GetCurrValueForEKOM(fValue:double; CMDID : integer):double;
begin
   case CMDID of
     QRY_MGAKT_POW_S,
     QRY_MGAKT_POW_A,
     QRY_MGAKT_POW_B,
     QRY_MGAKT_POW_C : Result := fValue*1000;
     QRY_MGREA_POW_S,
     QRY_MGREA_POW_A,
     QRY_MGREA_POW_B,
     QRY_MGREA_POW_C : Result := fValue*1000;
     QRY_U_PARAM_S,
     QRY_U_PARAM_A,
     QRY_U_PARAM_B,
     QRY_U_PARAM_C   : Result := fValue;
     QRY_I_PARAM_S,
     QRY_I_PARAM_A,
     QRY_I_PARAM_B,
     QRY_I_PARAM_C   : Result := fValue*1000;
     QRY_FREQ_NET    : Result := fValue;
     QRY_KOEF_POW_A,
     QRY_KOEF_POW_B,
     QRY_KOEF_POW_C  : Result := fValue;
     else Result := fValue;
   end;
end;

procedure CEKOMModule.FNCReadCurrParKanal(var pMsg : CMessage);
var  KT                     : Char;
     NK, KolKan, i, j, NKE  : integer;
     VM, CMDID              : integer;
     pTable                 : L3CURRENTDATAS;
     fValue                 : single;
     rValue                 : real48;
     ValueSize              : byte;
begin
   case pMsg.m_sbyInfo[1] of
     3, 4 : begin
              GetTypeAndNumberKanal(pMsg.m_sbyInfo[2]*$100 + pMsg.m_sbyInfo[3], KT, NK);
              KolKan    := pMsg.m_sbyInfo[4] div 2;                                     //Количество запрашиваемых каналов
              ValueSize := 4;
            end;
     118  : begin
              GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100, KT, NK);
              GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[4]*$100, KT, NKE);
              KolKan    := NKE - NK + 1;
              ValueSize := 6;
            end;
   end;
   if (KolKan > 62) or not ((Char(KT) = 'G') or (Char(KT) = 'B') {or (Char(KT) = 'V')}) then
     FNCUnknown(pMsg);
   for i := NK to NK + KolKan - 1 do
   begin
      EncodeKanToVMAndCMDID(Char(KT), i, VM, CMDID);
      m_pDDB.GetCurrentData(VM, CMDID, pTable);
      if pTable.Count = 0 then
        fValue := 0
      else
        for j := 0 to pTable.Count - 1 do
          if pTable.Items[j].m_swTID = 0 then
          begin
            fValue := pTable.Items[j].m_sfValue;
            rValue := pTable.Items[j].m_sfValue;
          end;
         fValue := GetCurrValueForEKOM(fValue, CMDID);
         rValue := GetCurrValueForEKOM(rValue, CMDID);
         if ValueSize = 4 then
           move(fValue, m_nTxMsg.m_sbyInfo[3 + (i - NK)*4], 4)
         else
         begin
           if pTable.Count <> 0 then
           begin
             FillChar(m_nTxMsg.m_sbyInfo[6 + (i - NK)*8], 2, 0);
             move(rValue, m_nTxMsg.m_sbyInfo[8 + (i - NK)*8], 6);
           end
           else
             ErrData(m_nTxMsg.m_sbyInfo[3 + (i - NK)*8], ERR_NO_DATA);
         end;
   end;
   if ValueSize = 4 then
   begin
     m_nTxMsg.m_swLen      := 3 + KolKan*4 + 2;
     m_nTxMsg.m_sbyInfo[2] := KolKan*4;
   end
   else
   begin
     m_nTxMsg.m_swLen :=  6 + KolKan*8 + 2;
     move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], 6);
   end;
end;

procedure CEKOMModule.FNCVersPO(Var pMsg : CMessage);
//var Year, Month, Day,
//    Hour, Min, Sec, ms : word;
begin
//версия прибора 5.79 записана 22.06.2006 12.09.55
//DecodeDate(Now, Year, Month, Day);
//DecodeTime(Now, Hour, Min, Sec, ms);
   m_nTxMsg.m_swLen       := 13;
   m_nTxMsg.m_sbyInfo[2]  := 5;
   m_nTxMsg.m_sbyInfo[3]  := 30;
   m_nTxMsg.m_sbyInfo[4]  := 55; //sec;
   m_nTxMsg.m_sbyInfo[5]  := 09; //min;
   m_nTxMsg.m_sbyInfo[6]  := 12; //hour;
   m_nTxMsg.m_sbyInfo[7]  := 22; //day;
   m_nTxMsg.m_sbyInfo[8]  := 06; //month;
   m_nTxMsg.m_sbyInfo[9]  := 214;//year mod $100;
   m_nTxMsg.m_sbyInfo[10] := 7;  //year div $100;
end;

procedure CEKOMModule.FNCOpenSession(Var pMsg : CMessage);
var uS                : ShortString;
begin
   move(pMsg.m_sbyInfo[2], uTimeOut, 2); // таймаут сессии
   move(pMsg.m_sbyInfo[4], uS, pMsg.m_sbyInfo[4] + 1); // пароль
   if Us <> password then
   begin
     dwLastTime := 0;
     FNCUnknown(pMsg);
     exit;
   end;
   m_nTxMsg.m_swLen := 4;
   dwLastTime       := timeGetTime;
end;

procedure CEKOMModule.FNCCloseSession(Var pMsg : CMessage);
begin
   m_nTxMsg.m_swLen := 4;
   dwLastTime       := 0;
end;

procedure CEKOMModule.FNCReadJrnlStrFromDate(var pMsg : CMessage);
var KT                    : Char;
    KN, VM, CMDID, sm, i  : Integer;
    DateBegin             : TDateTime;
    pTable                : SEVENTTAGS;
    EvName                : string;
    Code, MSGLen          : WORD;
begin
   GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100, KT, KN);
   case pMsg.m_sbyInfo[1] of
     80, 114 : DateBegin := EncodeFormatT3(pMsg.m_sbyInfo[4]);
   end;
   if (KT <> 'J') then
   begin
     FNCUnknown(pMsg);
     exit;
   end;
   EncodeKanToVMAndCMDID(KT, KN, VM, CMDID);
{   if CMDID = 0 then
     m_pDDB.ReadJrnl(CMDID, DateBegin, pTable);
   if CMDID = 2 then
     m_pDDB.ReadJrnlVM(CMDID, VM, DateBegin, pTable);  }
   sm := 7;
   m_nTxMsg.m_sbyInfo[4] := 1;
   m_nTxMsg.m_sbyInfo[5] := Byte(pMsg.m_sbyInfo[2]);
   m_nTxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[3];
   for i := 0 to pTable.Count - 1 do
   begin
     EvName := EncodeEventToECOM(pTable.Items[i], Code);
     EvName := (EvName);
     if Code = $0000 then continue;
     if (KN = 0) and ((pTable.Items[i].m_swGroupID <> 0) and (pTable.Items[i].m_swGroupID <> 3)) then continue;
     if (KN <> 0) and ((pTable.Items[i].m_swGroupID <> 1) and (pTable.Items[i].m_swGroupID <> 2)) then continue;
     if 23 + sm + Length(EvName) + 2 > MAX_PACK_LEN then
     begin
       m_nTxMsg.m_sbyInfo[4] := 0;
       break;
     end;
     moveTime3(pTable.Items[i].m_sdtEventTime, m_nTxMsg.m_sbyInfo[sm]);
     move(Code, m_nTxMsg.m_sbyInfo[10 + sm], 2);
     FillChar(m_nTxMsg.m_sbyInfo[12 + sm], 10, 0);
     m_nTxMsg.m_sbyInfo[22 + sm] := Length(EvName);
     move(EvName[1], m_nTxMsg.m_sbyInfo[23 + sm], Length(EvName));
     sm := sm + 23 + Length(EvName);
   end;
   MSGLen := sm - 4;
   move(MSGLen, m_nTxMsg.m_sbyInfo[2], 2);
   m_nTxMsg.m_sbyInfo[5] := pMsg.m_sbyInfo[2];
   m_nTxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[3];
   m_nTxMsg.m_swLen := sm + 2;
end;

procedure CEKOMModule.FNCTimeAnswer(Var pMsg : CMessage);
var TempArray  : array [0..9] of byte;
begin
   case pMsg.m_sbyInfo[1] of
   110:
     begin
       m_nTxMsg.m_swLen := 14;
       FNCTimeNow(TempArray);
       move(TempArray[0], m_nTxMsg.m_sbyInfo[2], 10);
     end;
   104 :
     begin
       m_nTxMsg.m_swLen := 13;
       FNCTimeNow(TempArray);
       move(TempArray[0], m_nTxMsg.m_sbyInfo[2], 9)
     end;
   82 :
     begin
       m_nTxMsg.m_swLen := 11;
       FNCTimeNow(TempArray);
       move(TempArray[2], m_nTxMsg.m_sbyInfo[2], 7);
     end;
   end;
end;

function  CEKOMModule.FindValueFromTableSl(VMID, CMDID, SN : integer;
                                           Date : TDateTime;
                                           var pData : L3GRAPHDATASEKOM;
                                           var ErrMask : integer):real48;
var i : integer;
begin
    Result  := 0;
    ErrMask := ERR_NO_DATA;
    for i := 0 to pData.Count - 1 do
      if (pData.Items[i].m_swVMID = VMID) and (pData.Items[i].m_swCMDID = CMDID) and (trunc(pData.Items[i].m_sdtDate) = Date) then
      begin
        ErrMask := ERR_NO_ERROR;
        if (pData.Items[i].m_sbyType = MET_SUMM) or (pData.Items[i].m_sbyType = MET_GSUMM) then
        begin
          if not IsBitInMask(pData.Items[i].m_sMaskReRead, SN) then
            ErrMask := ERR_NO_DATA;
        end else
          if not IsBitInMask(pData.Items[i].m_sMaskRead, SN) then
            ErrMask := ERR_NO_DATA;
        Result  := pData.Items[i].v[SN];
        break;
      end;
end;

function  CEKOMModule.FindValueFromTableArch(VMID, CMDID : integer;
                                             Date : TDateTime;
                                             var pData : CCDatasEkom;
                                             var ErrMask : integer):real48;
var i : integer;
begin
    Result := 0;
    ErrMask := ERR_NO_DATA;
    for i := 0 to pData.Count - 1 do
      if (pData.Items[i].m_swVMID = VMID) and (pData.Items[i].m_swCMDID = CMDID) and (trunc(pData.Items[i].m_sTime) = Date) then
      begin
        ErrMask := ERR_NO_ERROR;
        if (pData.Items[i].m_sbyType = MET_SUMM) or (pData.Items[i].m_sbyType = MET_GSUMM) then
          if pData.Items[i].m_sbyMaskReRead = 0 then
            ErrMask := ERR_NO_DATA;
        Result := pData.Items[i].m_sfValue;
        break;
      end;
end;

procedure CEKOMModule.FNC127ReadAndWriteSlices(Date : TDateTime; N, KanBeg, KanEnd : integer; var pData : CArrayOfReal48);
var dt_Date30min, DateE     : TDateTime;
    pTable                  : L3GRAPHDATASEKOM;
    i, NS, j                : integer;
    VMIDBeg, VMIDEnd, CMDID : integer;
    TempDate                : TDateTime;
begin
   SetLength(pData.buf, N*(KanEnd - KanBeg + 1));
   SetLength(pData.ErrMask, N*(KanEnd - KanBeg + 1));
   pData.nCount := N*(KanEnd - KanBeg + 1);
   dt_Date30min := EncodeTime(0, 30, 0, 0);
   DateE := Date + N*dt_Date30min;
   EncodeKanToVMAndCMDID('B', KanBeg, VMIDBeg, CMDID);
   EncodeKanToVMAndCMDID('B', KanEnd, VMIDEnd, CMDID);
   m_pDDB.GetEKOM3000GraphDatas(DateE, Date, VMIDBeg, VMIDEnd, QRY_SRES_ENR_EP, QRY_SRES_ENR_RM, pTable);
   NS    := round(frac(Date)/dt_Date30min);
   pData.dt_Date := trunc(Date) + dt_Date30min*NS;
   for i := NS to NS + N - 1 do
   begin
     TempDate := trunc(trunc(Date) + i*dt_Date30min);
     for j := KanBeg to KanEnd do
     begin
       EncodeKanToVMAndCMDID('B', j, VMIDBeg, CMDID);
       pData.buf[(i - NS)*(KanEnd - KanBeg + 1) + (j - KanBeg)] := FindValueFromTableSl(VMIDBeg,
                                        QRY_SRES_ENR_EP + (CMDID - QRY_ENERGY_SUM_EP),
                                        i mod 48,
                                        TempDate,
                                        pTable,
                                        pData.ErrMask[(i - NS)*(KanEnd - KanBeg + 1) + (j - KanBeg)]);
     end;
   end;
end;

procedure CEKOMModule.FNC127ReadAndWriteArchsNak(Date : TDateTime; N, KanBeg, KanEnd, ParT : integer; var pData : CArrayOfReal48);
var DateE                   : TDateTime;
    pTable                  : CCDatasEkom;
    i, NS, j                : integer;
    VMIDBeg, VMIDEnd, CMDID : integer;
    TempDate                : TDateTime;
begin
   SetLength(pData.buf, N*(KanEnd - KanBeg + 1));
   SetLength(pData.ErrMask, N*(KanEnd - KanBeg + 1));
   pData.nCount := N*(KanEnd - KanBeg + 1);
   EncodeKanToVMAndCMDID('B', KanBeg, VMIDBeg, CMDID);
   EncodeKanToVMAndCMDID('B', KanEnd, VMIDEnd, CMDID);
   if ParT = QRY_NAK_EN_MONTH_EP then
   begin
     Date  := cDateTimeR.GetBeginMonth(Date);
     DateE := Date;
     for i := 0 to N - 1 do cDateTimeR.IncMonth(DateE);
   end else DateE := Date + N;
   pData.dt_Date := Date;
   m_pDDB.GetEKOM3000GData(DateE, Date, VMIDBeg, VMIDEnd, ParT, ParT + 4, pTable);
   TempDate := Date;
   for i := 0 to N - 1 do
   begin
     if ParT = QRY_NAK_EN_DAY_EP then
       TempDate := Date + i;
     for j := KanBeg to KanEnd do
     begin
       EncodeKanTOVMAndCMDID('B', j, VMIDBeg, CMDID);
       pData.buf[i*(KanEnd - KanBeg + 1) + (j - KanBeg)] := FindValueFromTableArch(VMIDBeg,
                                                            ParT + (CMDID - QRY_ENERGY_SUM_EP),
                                                            TempDate,
                                                            pTable,
                                                            pData.ErrMask[i*(KanEnd - KanBeg + 1) + (j - KanBeg)]);
     end;
     if  ParT = QRY_NAK_EN_MONTH_EP then
       cDateTimeR.IncMonth(TempDate);
   end;
end;

procedure CEKOMModule.FNC127ReadAndWriteArchsPrir(Date : TDateTime; N, KanBeg, KanEnd, ParT : integer; var pData : CArrayOfReal48);
var DateE                   : TDateTime;
    pTable                  : CCDatasEkom;
    i, NS, j                : integer;
    VMIDBeg, VMIDEnd, CMDID : integer;
    TempDate                : TDateTime;
begin
   SetLength(pData.buf, N*(KanEnd - KanBeg + 1));
   SetLength(pData.ErrMask, N*(KanEnd - KanBeg + 1));
   pData.nCount := N*(KanEnd - KanBeg + 1);
   EncodeKanToVMAndCMDID('B', KanBeg, VMIDBeg, CMDID);
   EncodeKanToVMAndCMDID('B', KanEnd, VMIDEnd, CMDID);
   if ParT = QRY_ENERGY_MON_EP then
   begin
     Date  := cDateTimeR.GetBeginMonth(Date);
     DateE := Date;
     for i := 0 to N - 1 do cDateTimeR.IncMonth(DateE);
   end else DateE := Date + N;
   pData.dt_Date := Date;
   m_pDDB.GetEKOM3000GData(DateE, Date, VMIDBeg, VMIDEnd, ParT, ParT + 4, pTable);
   TempDate := Date;
   for i := 0 to N - 1 do
   begin
     if ParT = QRY_ENERGY_DAY_EP then
       TempDate := Date + i;
     for j := KanBeg to KanEnd do
     begin
       EncodeKanTOVMAndCMDID('B', j, VMIDBeg, CMDID);
       pData.buf[i*(KanEnd - KanBeg + 1) + (j - KanBeg)] := FindValueFromTableArch(VMIDBeg,
                                                                                   ParT + (CMDID - QRY_ENERGY_SUM_EP),
                                                                                   TempDate,
                                                                                   pTable,
                                                                                   pData.ErrMask[i*(KanEnd - KanBeg + 1) + (j - KanBeg)]);
     end;
     if  ParT = QRY_ENERGY_MON_EP then
       cDateTimeR.IncMonth(TempDate);
   end;
end;

procedure CEKOMModule.FNCReadArchs(Var pMsg : CMessage);
var KanType                 : Char;
    NBeg, NEnd, Int, K      : integer;
    Time                    : TDateTime;
    DataLength, i, j        : integer;
    CMDID, VMID             : integer;
    pData                   : CArrayOfReal48;
begin
   GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100, KanType, NBeg);
   GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[4]*$100, KanType, NEnd);
   Time       := EncodeFormatT3(pMsg.m_sbyInfo[5]);                   //Время начала опроса
   Int        := pMsg.m_sbyInfo[15];                                  //Интервал времени
   K          := pMsg.m_sbyInfo[16];                                  //Количество интервалов
   DataLength := 8*K*(NEnd - NBeg + 1) + 21;                          //Размер сообщения
   if (NEnd >= NBeg + 124) or (DataLength > MAX_PACK_LEN) then
   begin
     FNCUnknown(pMsg);
     exit;
   end;
   if (KanType <> 'B') and (KanType <> 'S') then
   begin
     for i := 0 to (NEnd - NBeg + 1)*K - 1 do
       ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], ERR_THIS_KANAL);
     if (Int = 0) or (Int = 1) then
       m_nTxMsg.m_sbyInfo[17] := Int*30 + 3*(Int xor $01) else m_nTxMsg.m_sbyInfo[17] := 0;
     Int := 8;
   end;
   case Int of
     0 : begin
           pData.dt_Date := Time;
           m_nTxMsg.m_sbyInfo[17] := 3;
           for i := 0 to (NEnd - NBeg + 1)*K - 1 do ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], ERR_NO_DATA);
         end;
     1 : begin  //30 минут
           m_nTxMsg.m_sbyInfo[17] := 30;
           FNC127ReadAndWriteSlices(Time, K, NBeg, NEnd, pData);
           for i := 0 to pData.nCount - 1 do
           begin
             FillChar(m_nTxMsg.m_sbyInfo[19 + i*8], 2, 0);
             move(pData.buf[i], m_nTxMsg.m_sbyInfo[21 + i*8], 6);
             ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], pData.ErrMask[i]);
           end;
         end;
     2 : begin  //сутки
           m_nTxMsg.m_sbyInfo[17] := 0;
           {$IFDEF READ_ARCH_NAK_EN}
           FNC127ReadAndWriteArchsNak(trunc(Time), K, NBeg, NEnd, QRY_NAK_EN_DAY_EP, pData);
           {$ELSE}
           FNC127ReadAndWriteArchsPrir(trunc(Time), K, NBeg, NEnd, QRY_ENERGY_DAY_EP, pData);
           {$ENDIF}
           for i := 0 to pData.nCount - 1 do
           begin
             FillChar(m_nTxMsg.m_sbyInfo[19 + i*8], 2, 0);
             move(pData.buf[i], m_nTxMsg.m_sbyInfo[21 + i*8], 6);
             ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], pData.ErrMask[i]);
           end;
         end;
     3 : begin //месяцы
           m_nTxMsg.m_sbyInfo[17] := 0;
           {$IFDEF READ_ARCH_NAK_EN}
           FNC127ReadAndWriteArchsNak(trunc(Time), K, NBeg, NEnd, QRY_NAK_EN_MONTH_EP, pData);
           {$ELSE}
           FNC127ReadAndWriteArchsPrir(trunc(Time), K, NBeg, NEnd, QRY_ENERGY_MON_EP, pData);
           {$ENDIF}
           for i := 0 to pData.nCount - 1 do
           if pData.buf[i] <= $FFFFFFFFFF00 then
           begin
             FillChar(m_nTxMsg.m_sbyInfo[19 + i*8], 2, 0);
             move(pData.buf[i], m_nTxMsg.m_sbyInfo[21 + i*8], 6);
             ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], pData.ErrMask[i]);
           end;
         end;
     4 : begin
           pData.dt_Date := Time;
           m_nTxMsg.m_sbyInfo[17] := 0;
           for i := 0 to (NEnd - NBeg)*K do ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], ERR_NO_DATA);
         end;
   end;
   m_nTxMsg.m_swLen := DataLength;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], 17);
   moveTime3(pData.dt_Date, m_nTxMsg.m_sbyInfo[5]);
   m_nTxMsg.m_sbyInfo[18] := 0;
end;

procedure CEKOMModule.FNCReadCurrParams(Var pMsg : CMessage);
begin
end;

procedure CEKOMModule.FNCNakParams(Var pMsg : CMessage);
var  KT                     : Char;
     NK, KolKan, i, j, NKE  : integer;
     VM, CMDID              : integer;
     pTable                 : L3CURRENTDATAS;
     fValue                 : single;
     rValue                 : real48;
     ValueSize              : byte;
begin
   GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100, KT, NK);
   GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[4]*$100, KT, NKE);
   KolKan    := NKE - NK + 1;
   for i := NK to NK + KolKan - 1 do
   begin
      EncodeKanToVMAndCMDID(Char(KT), i, VM, CMDID);
      m_pDDB.GetCurrentData(VM, CMDID, pTable);
      if pTable.Count = 0 then
        rValue := 0
      else
        for j := 0 to pTable.Count - 1 do
          if pTable.Items[j].m_swTID = 0 then
            rValue := pTable.Items[j].m_sfValue;
        FillChar(m_nTxMsg.m_sbyInfo[5 + (i - NK)*8], 2, 0);
        move(rValue, m_nTxMsg.m_sbyInfo[7 + (i - NK)*8], 6);

    end;
    m_nTxMsg.m_swLen :=  5 + KolKan*8 + 2;
    move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], 5);
end;

procedure CEKOMModule.FNCNakParWithTime(Var pMsg : CMessage);
{var KanType                 : Char;
    NBeg, NEnd, Int, K      : integer;
    Time                    : TDateTime;
    DataLength, i, j        : integer;
    CMDID, VMID             : integer;
    pData                   : CArrayOfReal48;  }
begin
 {  GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100, KanType, NBeg);
   GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[4]*$100, KanType, NEnd);
   Time       := EncodeFormatT3(pMsg.m_sbyInfo[5]);                   //Время начала опроса
   Int        := pMsg.m_sbyInfo[15];                                  //Интервал времени
   K          := pMsg.m_sbyInfo[16];                                  //Количество интервалов
   DataLength := 8*K*(NEnd - NBeg + 1) + 21;                          //Размер сообщения
   if (NEnd >= NBeg + 124) or (DataLength > MAX_PACK_LEN) then
   begin
     FNCUnknown(pMsg);
     exit;
   end;
   if (KanType <> 'B') and (KanType <> 'S') then
   begin
     for i := 0 to (NEnd - NBeg + 1)*K - 1 do
       ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], ERR_THIS_KANAL);
     if (Int = 0) or (Int = 1) then
       m_nTxMsg.m_sbyInfo[17] := Int*30 + 3*(Int xor $01) else m_nTxMsg.m_sbyInfo[17] := 0;
     Int := 8;
   end;
   case Int of
     0 : begin
           pData.dt_Date := Time;
           m_nTxMsg.m_sbyInfo[17] := 3;
           for i := 0 to (NEnd - NBeg + 1)*K - 1 do ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], ERR_NO_DATA);
         end;
     1 : begin  //30 минут
           m_nTxMsg.m_sbyInfo[17] := 30;
           FNC127ReadAndWriteSlices(Time, K, NBeg, NEnd, pData);
           for i := 0 to pData.nCount - 1 do
           begin
             FillChar(m_nTxMsg.m_sbyInfo[19 + i*8], 2, 0);
             move(pData.buf[i], m_nTxMsg.m_sbyInfo[21 + i*8], 6);
             ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], pData.ErrMask[i]);
           end;
         end;
     2 : begin  //сутки
           m_nTxMsg.m_sbyInfo[17] := 0;
           FNC127ReadAndWriteArchsNak(trunc(Time), K, NBeg, NEnd, QRY_NAK_EN_DAY_EP, pData);
           FNC127ReadAndWriteArchsPrir(trunc(Time), K, NBeg, NEnd, QRY_ENERGY_DAY_EP, pData);
           for i := 0 to pData.nCount - 1 do
           begin
             FillChar(m_nTxMsg.m_sbyInfo[19 + i*8], 2, 0);
             move(pData.buf[i], m_nTxMsg.m_sbyInfo[21 + i*8], 6);
             ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], pData.ErrMask[i]);
           end;
         end;
     3 : begin //месяцы
           m_nTxMsg.m_sbyInfo[17] := 0;
           FNC127ReadAndWriteArchsNak(trunc(Time), K, NBeg, NEnd, QRY_NAK_EN_MONTH_EP, pData);
           FNC127ReadAndWriteArchsPrir(trunc(Time), K, NBeg, NEnd, QRY_ENERGY_MON_EP, pData);
           for i := 0 to pData.nCount - 1 do
           if pData.buf[i] <= $FFFFFFFFFF00 then
           begin
             FillChar(m_nTxMsg.m_sbyInfo[19 + i*8], 2, 0);
             move(pData.buf[i], m_nTxMsg.m_sbyInfo[21 + i*8], 6);
             ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], pData.ErrMask[i]);
           end;
         end;
     4 : begin
           pData.dt_Date := Time;
           m_nTxMsg.m_sbyInfo[17] := 0;
           for i := 0 to (NEnd - NBeg)*K do ErrData(m_nTxMsg.m_sbyInfo[19 + i*8], ERR_NO_DATA);
         end;
   end;
   m_nTxMsg.m_swLen := DataLength;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], 17);
   moveTime3(pData.dt_Date, m_nTxMsg.m_sbyInfo[5]);
   m_nTxMsg.m_sbyInfo[18] := 0; }
end;

procedure CEKOMModule.FNCEvents(Var pMsg : CMessage);
begin
end;

procedure CEKOMModule.FNCEventsYSPD(Var pMsg : CMessage);
begin
end;

procedure CEKOMModule.FNCEventsWithTime(Var pMsg : CMessage);
begin

end;

procedure CEKOMModule.FNCSerialNumb(Var pMsg : CMessage);
begin
   m_nTxMsg.m_swLen := 8;
   m_nTxMsg.m_sbyInfo[2] := $1;
   m_nTxMsg.m_sbyInfo[3] := $2;
   m_nTxMsg.m_sbyInfo[4] := $3;
   m_nTxMsg.m_sbyInfo[5] := $4;
end;

procedure CEKOMModule.FNCReadEvJrnl114(Var pMsg : CMessage);
var KanType             : Char;
    DateBegin           : TDateTime;
    KN, VM, CMDID, i    : Integer;
    pTable              : SEVENTTAGS;
    Code, sm            : WORD;
begin
   GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100, KanType, KN);
   EncodeKanToVMAndCMDID(KanType, KN, VM, CMDID);
   m_nTxMsg.m_sbyInfo[4] := 1;
   DateBegin := EncodeFormatT3(pMsg.m_sbyInfo[4]);
 {  if CMDID = 0 then
     m_pDDB.ReadJrnl(CMDID, DateBegin, pTable);
   if CMDID = 2 then
     m_pDDB.ReadJrnlVM(CMDID, VM, DateBegin, pTable);  }
   sm := 7;
   if (KanType <> 'J') then
   begin
     FNCUnknown(pMsg);
     exit;
   end;
   for i := 0 to pTable.Count - 1 do
   begin
     EncodeEventToECOM(pTable.Items[i], Code);
     if Code = $0000 then continue;
     if (KN = 0) and ((pTable.Items[i].m_swGroupID <> 0) and (pTable.Items[i].m_swGroupID <> 3)) then continue;
     if (KN <> 0) and ((pTable.Items[i].m_swGroupID <> 1) and (pTable.Items[i].m_swGroupID <> 2)) then continue;
     if sm + 11 + 2 > MAX_PACK_LEN then
     begin
       m_nTxMsg.m_sbyInfo[4] := 0;
       break;
     end;
     moveTime3(pTable.Items[i].m_sdtEventTime, m_nTxMsg.m_sbyInfo[sm]);
     if (pMsg.m_sbyInfo[1]=114)then
     begin
     m_nTxMsg.m_sbyInfo[sm + 10] := Lo(Code);
     sm := sm + 10 + 1;
   end;
     if (pMsg.m_sbyInfo[1]=112)then
     begin
       //m_nTxMsg.m_sbyInfo[sm + 10] := Lo(Code);
       move(Code, m_nTxMsg.m_sbyInfo[sm+10], 2);
       sm := sm + 10 + 2;
     end;
   end;
   m_nTxMsg.m_sbyInfo[2] := (sm - 4) mod $100;
   m_nTxMsg.m_sbyInfo[3] := (sm - 4) div $100;
   m_nTxMsg.m_sbyInfo[5] := pMsg.m_sbyInfo[2];
   m_nTxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[3];
   m_nTxMsg.m_swLen := sm + 2;
end;

procedure CEKOMModule.FNCSetTimeYSPD(Var pMsg : CMessage);
var dt_Date   : TDateTime;
    dt_Delta  : TDateTime;
    strPassw  : string;
begin
   strPassw := password;
   case pMsg.m_sbyInfo[1] of
     81  : dt_Date  := EncodeFormatT1(pMsg.m_sbyInfo[2]);
     111 :
         begin
           dt_Date  := EncodeFormatT3(pMsg.m_sbyInfo[2]);
           strPassw := GetPascalString(pMsg.m_sbyInfo[12]);
         end;
   end;
   if (dt_Date = 0) or (strPassw <> password) then
   begin
     FNCUnknown(pMsg);
     exit;
   end;
  // m_pDDB.FixUspdEvent(0,0,EVH_START_CORR);
   m_pDB.EventFlagCorrector := EVH_COR_TIME_DEVICE;
   cDateTimeR.SetTimeToPC(dt_Date);
   //dt_Delta := abs(Now - dt_Date);
   //
   //m_pDDB.UpdateKorrMonth(dt_Delta);
   //m_pDDB.FixUspdEvent(0,0,EVH_FINISH_CORR);
   m_nTxMsg.m_swLen := 4;
end;

function CEKOMModule.ReadEquipInfo : string;
var SerNum           : string;
    SoftVer          : string;
    MaxModule        : string;
    BMax, GMax, JMax : integer;
    pTable           : SL2USPDCHARACTDEVLISTEX;
begin
   m_pDDB.ReadUSPDCharDevCFG(true, pTable);
   SerNum    := '1231421';
   SoftVer   := FileVersion(ParamStr(0));
   MaxModule := IntToStr(pTable.Count);
   GMax      := pTable.Count*15;
   BMax      := pTable.Count*4;
   JMax      := pTable.Count;
   Result       := 'SerNum=' + SerNum + #10 + 'SoftVer=' + SoftVer + #10 + 'MaxModule='
                + MaxModule + #10 + 'B=' + IntToStr(BMax) + #10 + 'G=' + IntToStr(GMax) + #10 + 'J=' + IntToStr(JMax) + #10;
end;

function CEKOMModule.ReadDeviceInfo(DevN : integer) : string;
var Module     : string;
    Port       : string;
    Addr       : string;
    SerNum     : string;
    Name       : string;
    State      : string;
    pPortTable : SL1TAG;
    pTable     : SL2USPDCHARACTDEVLISTEX;
begin
   m_pDDB.ReadUSPDCharDevCFG(true, pTable);
   pPortTable.m_sbyPortID := pTable.Items[DevN - 1].m_sbyPortID;
   m_pDDB.GetPortTable(pPortTable);
   Module  := IntToStr(DevN);
   Port    := '-';
   Addr    := '-';
   SerNum  := '-';
   Name    := '-';
   State   := '-';
   if DevN - 1 < pTable.Count then
   begin
     if DevN = 0 then
     begin
       Addr    := IntToStr(Self.Addr);
       SerNum  := '1231421';
       Name    := 'УСПД Конус-Е';
     end
     else
     begin
       Port    := 'COM' + IntToStr(pPortTable.m_sbyPortNum);
       Addr    := IntToStr(pTable.Items[DevN - 1].m_swANet);
       SerNum  := IntToStr(pTable.Items[DevN - 1].m_sdwWorkNumb);
       Name    := pTable.Items[DevN - 1].m_sStrAdr;
       State   := '1';
     end;
   end else Name := 'Модуль не описан';
   Result := 'Port=' + Port + #10 +  'Addr=' + Addr + #10 + 'SerNum=' + SerNum + #10 +
             'Name=' + Name + #10 + 'State=' + State + #10;
end;

function CEKOMModule.ReadKanalInfo(KanType : Char; KanN : integer) : string;
var
   Name, Units, Module, Number, AddSumm,
   MinLimit, MaxLimit, Coeff          : string;
   pTable                             : SL2USPDCHARACTDEVLISTEX;
begin
   Name     := '-';
   Units    := '-';
   Module   := '-';
   Number   := '-';
   AddSumm  := '-';
   MinLimit := '-';
   MaxLimit := '-';
   Coeff    := '-';
   m_pDDB.ReadUSPDCharDevCFG(true, pTable);
   case KanType of
     'J' : if KanN = 0 then
           begin
             Name    := 'Журнал событий УСПД';
             Module  := '0';
           end
           else
             if KanN - 1 < pTable.Count then
             begin
               Name   := 'Журнал событий точки учета ' + pTable.Items[KanN - 1].m_sStrAdr;
               Module := IntToStr(KanN);
             end
               else Name := 'Журнал не описан';
     'G' : if (KanN = 0) or (KanN <= pTable.Count*15) then
           begin
             if KanN = 0 then begin Name := 'УСПД Конус-Е'; Module := '0'; end else
             begin
               Name     := PAR_NAMES_CURR[(KanN - 1) mod 15, 0];
               Units    := PAR_NAMES_CURR[(KanN - 1) mod 15, 1];
               Module   := IntToStr((KanN - 1) div 15 + 1);
               Number   := IntToStr((KanN - 1) mod 15 + 1);
               Coeff    := FloatToStr(pTable.Items[(KanN - 1) div 15].m_sfKt);
             end;
           end
           else Name := 'Канал не описан';
     'B' : if (KanN = 0) or (KanN <= pTable.Count*4) then
           begin
             if KanN = 0 then begin Name := 'УСПД Конус-Е'; Module := '0'; end
             else
             begin
               Name     := PAR_NAMES_KVNA[(KanN - 1) mod 4, 0];
               Units    := PAR_NAMES_KVNA[(KanN - 1) mod 4, 1];
               Module   := IntToStr((KanN - 1) div 4 + 1);
               Number   := IntToStr((KanN - 1) mod 4 + 1);
               Coeff    := FloatToStr(pTable.Items[(KanN - 1) div 4].m_sfKt);
               AddSumm  := '0';
             end;
           end
           else Name := 'Канал не описан';
     else begin Name := 'Канал не описан';  end;
   end;
   Result := 'Name=' + Name + #10 + 'Units=' + Units + #10 + 'Module=' + Module + #10 +
             'Number=' + Number + #10 + 'AddSumm=' + AddSumm + #10 +
             'MinLimit=' + MinLimit + #10 + 'MaxLimit=' + MaxLimit + #10 + 'Coeff=' + Coeff + #10;
end;

procedure CEKOMModule.FNCInformBlock(Var pMsg : CMessage);
var BlType         : byte;
    AdrBl          : WORD;
    str            : string;
    i, KanN        : integer;
    pTable         : SL2USPDCHARACTDEVLISTEX;
    K              : word;
    KanType        : Char;
begin
   BlType  := pMsg.m_sbyInfo[2];
   move(pMsg.m_sbyInfo[3], AdrBl, 2);
   case BlType of
     0 : begin
           if AdrBl = 0 then
             str := ReadEquipInfo;
         end;
     1 :
         begin
             str := ReadDeviceInfo(AdrBl);
         end;
     2 :
         begin
           GetTypeAndNumberKanal(pMsg.m_sbyInfo[3] + pMsg.m_sbyInfo[4]*$100, KanType, KanN);
           str := ReadKanalInfo(KanType, KanN);
         end;
   end;
   str := EncPascStrToStr866(str);
   move(str[1], m_nTxMsg.m_sbyInfo[7], Length(str));
   K := Length(str);
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], 5);
   move(K, m_nTxMsg.m_sbyInfo[5], 2);
   m_nTxMsg.m_sbyInfo[7 + K] := 0;
   m_nTxMsg.m_swLen := 10 + K;
end;

procedure CEKOMModule.FNCSetValue(var pMsg : CMessage);
begin
   m_nTxMsg.m_swLen := 4;
end;

function CEKOMModule.Get30Interval115(var Time : TDateTime; KanNumb : integer) : double;
var m_pGrData    : L3GRAPHDATAS;
    m_pArData    : CCDatas;
    NSrez, i     : integer;
begin
    NSrez := trunc(frac(Time) / EncodeTime(0, 30, 0, 0));
    NSrez := NSrez - 1;
    if NSrez < 0 then
    begin
      NSrez := 47;
      Time := Time - 1;
    end;
    Time  := trunc(Time) + NSrez * EncodeTime(0, 30, 0, 0);
    m_pDDB.GetGraphDatas(Time, Time, (KanNumb - 1) div 4, QRY_SRES_ENR_EP + (KanNumb - 1) mod 4, m_pGrData);
    m_pDDB.GetGData(Time, Time, (KanNumb - 1) div 4, QRY_NAK_EN_DAY_EP + (KanNumb - 1) mod 4, 0, m_pArData);
    if m_pGrData.Count = 0 then
      SetLength(m_pGrData.Items, 1);
    if (m_pArData.Count = 0) then
    begin
      SetLength(m_pArData.Items, 1);
      m_pArData.Items[0].m_sfValue := 0;
    end;
    for i := 0 to NSrez do
      if i <> 0 then
        m_pGrData.Items[0].v[i] := m_pGrData.Items[0].v[i - 1] + m_pGrData.Items[0].v[i]
      else
        m_pGrData.Items[0].v[i] := m_pArData.Items[0].m_sfValue;
    Result := m_pGrData.Items[0].v[NSrez];
end;

function CEKOMModule.GetDayInterval115(var Time : TDateTime; KanNumb : integer) : double;
var m_pArData  : CCDatas;
begin
   Time := trunc(Time);
   m_pDDB.GetGData(Time, Time, (KanNumb - 1) div 4, QRY_NAK_EN_DAY_EP + (KanNumb - 1) mod 4, 0, m_pArData);
   if (m_pArData.Count = 0) then
   begin
     SetLength(m_pArData.Items, 1);
     m_pArData.Items[0].m_sfValue := 0;
   end;
   Result := m_pArData.Items[0].m_sfValue;
end;

function CEKOMModule.GetMonthInterval115(var Time : TDateTime; KanNumb : integer) : double;
var m_pArData  : CCDatas;
begin
   Time := cDateTimeR.GetBeginMonth(Time);
   m_pDDB.GetGData(Time, Time, (KanNumb - 1) div 4, QRY_NAK_EN_MONTH_EP + (KanNumb - 1) mod 4, 0, m_pArData);
   if (m_pArData.Count = 0) then
   begin
     SetLength(m_pArData.Items, 1);
     m_pArData.Items[0].m_sfValue := 0;
   end;
   Result := m_pArData.Items[0].m_sfValue;
end;

function CEKOMModule.GetNow115(var Time : TDateTime; KanNumb : integer) : double;
var m_pCurData  : L3CURRENTDATAS;
begin
   m_pDDB.GetCurrentData((KanNumb - 1) div 4, QRY_ENERGY_SUM_EP + (KanNumb - 1) mod 4, m_pCurData);
   if m_pCurData.Count = 0 then
   begin
      SetLength(m_pCurData.Items, 1);
      m_pCurData.Items[0].m_sfValue := 0;
      m_pCurData.Items[0].m_sTime   := Now;
   end;
   Time := m_pCurData.Items[0].m_sTime;
   Result := m_pCurData.Items[0].m_sfValue;
end;

procedure CEKOMModule.FNCReadNakEn115(var pMsg : CMessage);
var KanType           : Char;
    NBeg, NEnd, i     : integer;
    Interval          : byte;
    Time              : TDateTime;
    DataLength        : integer;
    tValue            : real48;
begin

   GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100, KanType, NBeg);
   GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[4]*$100, KanType, NEnd);

   DataLength := 5 + (10 + 6)*(NEnd - NBeg + 1) + 2;

   Interval := pMsg.m_sbyInfo[5];

   if (NEnd >= NBeg + 62) or (DataLength > MAX_PACK_LEN) or (KanType <> 'B') then
   begin
     FNCUnknown(pMsg);
     exit;
   end;

   for i := NBeg to NEnd do
   begin

     //Time := DateFrRArchNak[i];
     Time := 0;
     if Time = 0 then Time := Now;

     case Interval of
        0   : begin
                tValue := 0;
                moveTime3(Time, m_nTxMsg.m_sbyInfo[6 + (i - NBeg)*16]);
                move(tValue, m_nTxMsg.m_sbyInfo[16 + (i - NBeg)*16], sizeof(real48));
              end;
        1   : begin
                tValue := Get30Interval115(Time, i);
                moveTime3(Time, m_nTxMsg.m_sbyInfo[6 + (i - NBeg)*16]);
                move(tValue, m_nTxMsg.m_sbyInfo[16 + (i - NBeg)*16], sizeof(real48));
              end;
        2   : begin
                tValue := GetDayInterval115(Time, i);
                moveTime3(Time, m_nTxMsg.m_sbyInfo[6 + (i - NBeg)*16]);
                move(tValue, m_nTxMsg.m_sbyInfo[16 + (i - NBeg)*16], sizeof(real48));
              end;
        3   : begin
                tValue := GetMonthInterval115(Time, i);
                moveTime3(Time, m_nTxMsg.m_sbyInfo[6 + (i - NBeg)*16]);
                move(tValue, m_nTxMsg.m_sbyInfo[16 + (i - NBeg)*16], sizeof(real48));
              end;
        4   : begin
                tValue := 0;
                moveTime3(Time, m_nTxMsg.m_sbyInfo[6 + (i - NBeg)*16]);
                move(tValue, m_nTxMsg.m_sbyInfo[16 + (i - NBeg)*16], sizeof(real48));
              end;
        255 : begin
                tValue := GetNow115(Time, i);
                moveTime3(Time, m_nTxMsg.m_sbyInfo[6 + (i - NBeg)*16]);
                move(tValue, m_nTxMsg.m_sbyInfo[16 + (i - NBeg)*16], sizeof(real48));
              end;
        else  begin
                 tValue := 0;
                 moveTime3(Time, m_nTxMsg.m_sbyInfo[6 + (i - NBeg)*16]);
                 move(tValue, m_nTxMsg.m_sbyInfo[16 + (i - NBeg)*16], sizeof(real48));
               end;
     end;
   end;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], 6);
   m_nTxMsg.m_swLen := 6 + (10 + 6)*(NEnd - NBeg + 1) + 2;
end;

procedure CEKOMModule.FNCSetTimeReadArch(var pMsg : CMessage);
var KanType          : Char;
    NBeg, NEnd, i    : integer;
    uS               : ShortString;
    TempDate         : TDateTime;
begin
   move(pMsg.m_sbyInfo[15], uS, pMsg.m_sbyInfo[15] + 1);
   if uS <> password then
   begin
      FNCUnknown(pMsg);
      exit;
   end;

   GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100, KanType, NBeg);
   GetTypeAndNumberKanal(pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[4]*$100, KanType, NEnd);

   if KanType <> 'B' then
   begin
     FNCUnknown(pMsg);
     exit;
   end;
   TempDate := EncodeFormatT3(pMsg.m_sbyInfo[5]);
   for i := NBeg to NEnd do
     DateFrRArchNak[i] := TempDate;

   m_nTxMsg.m_swLen := 4;
end;

procedure CEKOMModule.FNCPreTonnelMsg(var pMsg : CMessage);
begin
   move(TONNEL_ANSWER[1], m_nTxMsg.m_sbyInfo[2], Length(TONNEL_ANSWER));
   m_nTxMsg.m_swLen := 4 + Length(TONNEL_ANSWER);
end;


procedure CEKOMModule.FNCReadGraphFromMeters(var pMsg : CMessage);
Var
   szDT : Integer;
   pDS  : CMessageData;
begin
   move(pMsg.m_sbyInfo[6], pDS.m_swData0, 4);
   move(pMsg.m_sbyInfo[10], pDS.m_swData1, 4);
   move(pMsg.m_sbyInfo[14], pDS.m_swData2, 4);
   move(pMsg.m_sbyInfo[18], pDS.m_swData3, 4);
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   move(pMsg.m_sbyInfo[26], pDS.m_sbyInfo[0], sizeof(TDateTime)*2);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_DATA_ALLGRAPH_REQ,pDS);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 202;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   //FillChar(m_nTxMsg,30,0);
   //m_nTxMsg.m_sbyInfo[6] := 0;
   //m_nTxMsg.m_sbyInfo[7] := 0;
   //CreateMSG(pMsg, $ff02, 16+2, True, Now);
   //CreateMSGHead(m_nTxMsg, 16+2);
   //FPUT(BOX_L1, @m_nTxMsg);
end;
procedure CEKOMModule.FNCReadEvents(var pMsg : CMessage);
Var
   szDT : Integer;
   pDS  : CMessageData;
begin
   move(pMsg.m_sbyInfo[6], pDS.m_swData0, 4);
   move(pMsg.m_sbyInfo[10], pDS.m_swData1, 4);
   move(pMsg.m_sbyInfo[14], pDS.m_swData2, 4);
   move(pMsg.m_sbyInfo[18], pDS.m_swData3, 4);
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   move(pMsg.m_sbyInfo[26], pDS.m_sbyInfo[0], sizeof(TDateTime)*2);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_LOAD_EVENTS_REQ,pDS);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 204;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   //m_nTxMsg.m_sbyInfo[6] := 0;
   //m_nTxMsg.m_sbyInfo[7] := 0;
   //CreateMSG(pMsg, $ff04, 16+2, True, Now);
   //CreateMSGHead(m_nTxMsg, 16+2);
   //FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CEKOMModule.FNCStartPool(var pMsg : CMessage);
Var
   pDS  : CMessageData;
Begin
   m_nCF.SchedGo;
   mL3LmeMoule.m_sALD.Reset;
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 200;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   //CreateMSG(pMsg, $FF00, 16+2, True, Now);
   //CreateMSGHead(m_nTxMsg, 16+2);
   //FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CEKOMModule.FNCStopPool(var pMsg : CMessage);
Var
   pDS  : CMessageData;
Begin
   m_nCF.SchedPause;
   mL3LmeMoule.m_sALD.Reset;
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 201;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   //FillChar(m_nTxMsg,30,0);
   //m_nTxMsg.m_sbyInfo[6] := 0;
   //m_nTxMsg.m_sbyInfo[7] := 0;
   //CreateMSG(pMsg, $ff01, 16+2, True, Now);
   //CreateMSGHead(m_nTxMsg, 16+2);
   //FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CEKOMModule.FNCReBoot(var pMsg : CMessage);
Var
   pDS  : CMessageData;
Begin
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RBOOT_DATA_REQ,pDS);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 203;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   //FillChar(m_nTxMsg,30,0);
   //m_nTxMsg.m_sbyInfo[6] := 0;
   //m_nTxMsg.m_sbyInfo[7] := 0;
   //CreateMSG(pMsg, $ff03, 16+2, True, Now);
   //CreateMSGHead(m_nTxMsg, 16+2);
   //FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CEKOMModule.FNCStartFH(var pMsg : CMessage);
Var
   szDT : Integer;
   pDS  : CMessageData;
begin
   szDT  := sizeof(TDateTime);
   m_nDataFinder  := True;
   move(pMsg.m_sbyInfo[6],pDS.m_sbyInfo[0],szDT);
   move(pMsg.m_sbyInfo[6+szDT],pDS.m_sbyInfo[szDT],szDT);
   move(pMsg.m_sbyInfo[6+2*szDT],pDS.m_sbyInfo[2*szDT],sizeof(int64));
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME, 0, DIR_LHTOLM3, QL_START_FH_REQ, pDS);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 205;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   {
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff06, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
   }
End;
procedure CEKOMModule.FNCSetL2TM(var pMsg : CMessage);
Var
   szDT,szI,i : Integer;
   pDS        : CMessageData;
   nVMID,nMID : Integer;
   m_sdtSumKor,m_sdtLimKor,m_sdtPhLimKor:TDateTime;
   VMeters    : SL3GROUPTAG;
begin
   try
   szDT  := sizeof(TDateTime);
   szI   := sizeof(Integer);
   move(pMsg.m_sbyInfo[6],nVMID,szI);
   move(pMsg.m_sbyInfo[6+szI],m_sdtSumKor,szDT);
   move(pMsg.m_sbyInfo[6+szI+szDT],m_sdtLimKor,szDT);
   move(pMsg.m_sbyInfo[6+szI+2*szDT],m_sdtPhLimKor,szDT);

   nMID := 0;
   if m_pDDB.GetVMetersTable(-1,-1, VMeters) then
   Begin
    for i := 0 to VMeters.m_swAmVMeter - 1 do
    if nVMID=VMeters.Item.Items[i].m_swVMID then
    Begin
     nMID := VMeters.Item.Items[i].m_swMID;
     m_pDB.SetTimeLimit(nMID,m_sdtSumKor,m_sdtLimKor,m_sdtPhLimKor);
     mL2Module.InitMeter(nMID);
     break;
    End;
   End;
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 206;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   except

   end;
End;
procedure CEKOMModule.FNCSetSynchro(var pMsg : CMessage);
Var
   szDT,szI,i : Integer;
   pDS        : CMessageData;
   nVMID,nMID : Integer;
   m_nSynchro : Byte;
   VMeters    : SL3GROUPTAG;
begin
   try
   szDT  := sizeof(TDateTime);
   szI   := sizeof(Integer);
   move(pMsg.m_sbyInfo[6],nVMID,szI);
   m_nSynchro := pMsg.m_sbyInfo[6+szI];
   //move(pMsg.m_sbyInfo[6+szI],m_sdtSumKor,szDT);
   //move(pMsg.m_sbyInfo[6+szI+szDT],m_sdtLimKor,szDT);
   //move(pMsg.m_sbyInfo[6+szI+2*szDT],m_sdtPhLimKor,szDT);

   nMID := 0;
   if m_pDDB.GetVMetersTable(-1,-1, VMeters) then
   Begin
    for i := 0 to VMeters.m_swAmVMeter - 1 do
    if nVMID=VMeters.Item.Items[i].m_swVMID then
    Begin
     nMID := VMeters.Item.Items[i].m_swMID;
     m_pDB.SetSynchroChnl(nMID,m_nSynchro);
     mL2Module.InitMeter(nMID);
     break;
    End;
   End;

   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 207;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   except

   end;
End;
procedure CEKOMModule.FNCDeepBuffer(var pMsg : CMessage);
begin
   try
   m_nMaxDayNetParam := pMsg.m_sbyInfo[6];
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 208;
   m_nTxMsg.m_sbyInfo[6] := m_nMaxDayNetParam;;
   m_nTxMsg.m_sbyInfo[7] := 0;
   except

   end;
End;
procedure CEKOMModule.FNCBaseSize(var pMsg : CMessage);
Var
   nSizeDB : Integer;
begin
   try
   if pMsg.m_sbyInfo[7]=1 then m_nMaxSpaceDB := pMsg.m_sbyInfo[6];
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 209;
   m_nTxMsg.m_sbyInfo[6] := m_nMaxSpaceDB;
   nSizeDB               := m_pDB.GetSizeDB;
   Move(nSizeDB,m_nTxMsg.m_sbyInfo[7],4);
   except

   end;
End;
procedure CEKOMModule.FNCDeepData(var pMsg : CMessage);
begin
   try
   m_nCF.m_pGenTable.m_sStoreClrTime := pMsg.m_sbyInfo[6]+1;
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 210;
   m_nTxMsg.m_sbyInfo[6] := m_nCF.m_pGenTable.m_sStoreClrTime;
   m_nTxMsg.m_sbyInfo[7] := 0;
   except

   end;
End;
procedure CEKOMModule.FNCClearData(var pMsg : CMessage);
Var
   nClearMonth : Integer;
begin
   try
   nClearMonth := pMsg.m_sbyInfo[6];
   m_pDB.FreeBase(nClearMonth);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 211;
   m_nTxMsg.m_sbyInfo[6] := nClearMonth;
   m_nTxMsg.m_sbyInfo[7] := 0;
   except

   end;
End;
procedure CEKOMModule.FNCExecSQL(var pMsg : CMessage);
Var
    str,strF : String;
    i,nLen,nPos:Integer;
Begin
    try
    {
    str := 'UPDATE SL3ABON SET m_sbyEnable=0 WHERE m_swABOID=0:::'+
           'UPDATE L2TAG SET M_SFKU=25.45,M_SFKI=22.12 WHERE M_SWMID=2:::'+
           'UPDATE L2TAG SET M_SFKU=11.11,M_SFKI=33.33 WHERE M_SWMID=3:::';
    nLen := Length(str);
    Move(nLen,pMsg.m_sbyInfo[6],2);
    for i:=0 to nLen do pMsg.m_sbyInfo[8+i] := Byte(str[i+1]);
    }
    str := '';
    Move(pMsg.m_sbyInfo[6],nLen,2);
    if nLen>5000 then exit;
    SetLength(str,nLen);
    for i:=0 to nLen-1 do str[i+1] := Char(pMsg.m_sbyInfo[8+i]);
    nPos := Pos(':::',str);
    while nPos<>0 do
    Begin
     strF := Copy(str,0,nPos-1);
     Delete(str,1,nPos+2);
     nPos := Pos(':::',str);
     m_pDB.ExecQry(strF);
    End;

    FillChar(m_nTxMsg,30,0);
    m_nTxMsg.m_swLen      := 13+8+2;
    m_nTxMsg.m_sbyInfo[0] := 1;
    m_nTxMsg.m_sbyInfo[1] := 212;
    m_nTxMsg.m_sbyInfo[6] := 0;
    m_nTxMsg.m_sbyInfo[7] := 0;
    except
      TraceER('(__)CL3MD::>Error In CBTIModule.FNCExecSQL!!!');
    End;
End;
procedure CEKOMModule.FNCInit(var pMsg : CMessage);
Var
    pDS : CMessageData;
begin
   try
   pDS.m_swData4 := MTR_LOCAL;
   case pMsg.m_sbyInfo[6] of
        0 : mL1Module.Init;         //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL1_REQ,pDS);
        1 : mL2Module.Init;         //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL2_REQ,pDS);
        2 : mL3Module.OnLoadVMeters;//SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL3_REQ,pDS);
        3 : m_nCF.SetGenSettings;
        4 : SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_SAVE_DB_REQ,pDS);
        5 : m_nCF.SchedInit;
        6 : m_nCF.SchedGo;
        7 : m_nCF.SchedPause;
        8 : Begin Move(pMsg.m_sbyInfo[7],pDS.m_swData1,4); m_nST.SetDTime(pDS.m_swData1);End;
        9 : m_nST.SetState(pMsg.m_sbyInfo[7]);
        10 : Begin
              m_nSmartFinder := pMsg.m_sbyInfo[7];
              m_nCF.SetSettIntValue('m_nSmartFinder',pMsg.m_sbyInfo[7]);
             End;
        11 : Begin
              m_nIsOneSynchro := pMsg.m_sbyInfo[7];
              m_nCF.SetSettIntValue('m_nIsOneSynchro',pMsg.m_sbyInfo[7]);
             End;
        12 : m_nQweryReboot := 1; //Запрос перезагрузки
        13 : m_nCF.SelfStop;
        14 : Begin
              Move(pMsg.m_sbyInfo[10],InnerPDS.m_swData1,4);//Time
              Move(pMsg.m_sbyInfo[14],InnerPDS.m_swData2,4);//Speed
              InnerFunctionPr := 14;
              m_nRepTimer.OnTimer(45);
             End;
        15 : Begin
              m_nUpdateFunction := pMsg.m_sbyInfo[7];
              m_nCF.SetSettIntValue('m_nUpdateFunction',pMsg.m_sbyInfo[7]);
             End;
        16:  Begin
              if pMsg.m_sbyInfo[7]=0 then pDS.m_swData4 := MTR_LOCAL else
              if pMsg.m_sbyInfo[7]=1 then pDS.m_swData4 := MTR_REMOTE;
              SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RELOAD_USPRO_REQ,pDS);
             End;
        17 : Begin
              move(pMsg.m_sbyInfo[7], m_nCountOfEvents, 4);
              m_nCF.SetSettIntValue('m_nCountOfEvents',m_nCountOfEvents);
             End;
   End;
    FillChar(m_nTxMsg,30,0);
    m_nTxMsg.m_swLen      := 13+8+2;
    m_nTxMsg.m_sbyInfo[0] := 1;
    m_nTxMsg.m_sbyInfo[1] := 213;
    m_nTxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[6];
    m_nTxMsg.m_sbyInfo[7] := pMsg.m_sbyInfo[7];
   except
     TraceER('(__)CL3MD::>Error In CEKOMModule.FNCInit!!!');
   end;
End;
procedure CEKOMModule.FNCDelArch(var pMsg : CMessage);
Var
   szDT : Integer;
   pDS  : CMessageData;
   dtDate2,dtDate1 : TDateTime;
   DataGraph   : L3GRAPHDATA;
   DataCurrent : L3CURRENTDATA;
begin
   try
   move(pMsg.m_sbyInfo[6],  pDS.m_swData0, 4); //FCID
   move(pMsg.m_sbyInfo[10], pDS.m_swData1, 4); //VMID
   move(pMsg.m_sbyInfo[14], pDS.m_swData2, 4); //CMDID
   move(pMsg.m_sbyInfo[18], pDS.m_swData3, 4);
   move(pMsg.m_sbyInfo[26], dtDate2, sizeof(TDateTime));
   move(pMsg.m_sbyInfo[26+sizeof(TDateTime)], dtDate1, sizeof(TDateTime));
   DataGraph.m_swVMID    := pDS.m_swData1;
   DataGraph.m_swCMDID   := pDS.m_swData2;
   DataCurrent.m_swVMID  := pDS.m_swData1;
   DataCurrent.m_swCMDID := pDS.m_swData2;
   case pDS.m_swData0 of
        SV_GRPH_ST : m_pDB.DelGraphData(dtDate2, dtDate1, DataGraph);
        SV_ARCH_ST : m_pDB.DelArchData(dtDate2, dtDate1, DataCurrent);
        SV_PDPH_ST : m_pDB.DelPdtData(dtDate2, dtDate1, DataCurrent);
   end;
   //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_DATA_ALLGRAPH_REQ,pDS);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 214;
   m_nTxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[6];
   m_nTxMsg.m_sbyInfo[7] := pMsg.m_sbyInfo[7];
   except
     TraceER('(__)CL3MD::>Error In CEKOMModule.FNCDelArch!!!');
   end;
end;
procedure CEKOMModule.SendMsgToMeter(var pMsg : CMessage); //Отправка сообщения напрямую в счетчик
begin
   StartTranz;
   m_sIsTranzOpen.m_sbIsTrasnBeg := true;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], pMsg.m_swLen - 11);
   m_nTxMsg.m_swLen       := pMsg.m_swLen;
   m_nTxMsg.m_swObjID     := m_sbyID;             //Сетевой адрес счётчика
   m_nTxMsg.m_sbyFrom     := DIR_L2TOL1;
   m_nTxMsg.m_sbyFor      := DIR_L2TOL1;         //DIR_L2toL1
   m_nTxMsg.m_sbyType     := PH_DATARD_REQ;      //PH_DATARD_REC
   m_nTxMsg.m_sbyIntID    := TonnelPort;
   m_nTxMsg.m_sbyServerID := MET_SS301F3;          //Указать тип счетчика
   m_nTxMsg.m_sbyDirID    := TonnelPort;
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure CEKOMModule.SendTranzAns(var pMsg : CMessage);
begin
   FinishTranz;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], pMsg.m_swLen - 11);
   CreateMSGHead(m_nTxMsg, pMsg.m_swLen-11);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CEKOMModule.StartTranz;
Var
    pDS : CMessageData;
begin
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   m_nCF.SchedPause;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
   m_sIsTranzOpen.m_sbIsTrasnBeg := true;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
end;

procedure CEKOMModule.FinishTranz;
Var
    pDS : CMessageData;
begin
   m_nRepTimer.OffTimer;
   m_sIsTranzOpen.m_sbIsTrasnBeg := false;
   m_nCF.SchedGo;
end;

function CEKOMModule.FindPortToOpenTonnel(portNum : integer) : integer; //return PortID
var i : integer;
begin
   Result := -1;
   for i := 0 to m_sTblL1.Count - 1 do
     if m_sTblL1.Items[i].m_sbyPortNum = portNum then
     begin
       Result := m_sTblL1.Items[i].m_sbyPortID;
       break;
     end;
end;


procedure CEKOMModule.FNCOpenTonnelMsg(var pMsg: CMessage);
begin
   TonnelPort := FindPortToOpenTonnel(pMsg.m_sbyInfo[4]);
   if TonnelPort = -1 then
   begin
     FNCUnknown(pMsg);
     exit;
   end
   else
   begin
     dwTRBClodeTonn  := (pMsg.m_sbyInfo[17] + pMsg.m_sbyInfo[18]*$100)*1000;
     dwTrCloseTonn   := (pMsg.m_sbyInfo[19] + pMsg.m_sbyInfo[20]*$100)*1000;
     dwTonnLastTime  := timeGetTime;
     dwTonnBLastTime := timeGetTime;
   end;
   m_nTxMsg.m_swLen := 4;
end;

procedure CEKOMModule.FNCUnknown(var pMsg : CMessage);
begin
   pMsg.m_sbyInfo[1]     := pMsg.m_sbyInfo[1] or $80;
   m_nTxMsg.m_sbyInfo[1] := pMsg.m_sbyInfo[1];
   m_nTxMsg.m_swLen      := 4;
end;

Function CEKOMModule.LoHandler(Var pMsg : CMessage) : Boolean;

Var
  res                   : Boolean;
  fnc, wCRC             : word;
Begin
  res := True;
  Result := False;
  Try
    If pMsg.m_sbyType = QL_CONNCOMPL_REQ Then Begin
      TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>Connect Complette');
      exit;
    End;
    if m_nRepTimer.IsProceed and m_sIsTranzOpen.m_sbIsTrasnBeg and (pMsg.m_sbyIntID = TonnelPort) then
    begin
      SendTranzAns(pMsg);
      exit;
    end;
    if (abs(dwTonnLastTime - timeGetTime) <= dwTrCloseTonn) and (abs(dwTonnBLastTime - timeGetTime) <= dwTRBClodeTonn) then //Транзакция открыта ???
    begin
      dwTonnLastTime := timeGetTime;
      SendMsgToMeter(pMsg);                                    //Отправка сообщения счетчику
      exit;
    end;
    wCRC := CRC(pMsg.m_sbyInfo, pMsg.m_swLen - 13);
    if (wCRC <> word(pMsg.m_sbyInfo[pMsg.m_swLen - 12]) Shl 8 + word(pMsg.m_sbyInfo[pMsg.m_swLen - 13])) and
       (wCRC <> word(pMsg.m_sbyInfo[pMsg.m_swLen - 13]) Shl 8 + word(pMsg.m_sbyInfo[pMsg.m_swLen - 12])) then
    begin
        TraceM(4, pMsg.m_swObjID, '(__)CL4MD::>EKOM CRC ERROR!!!:', @pMsg);
        exit;
    end;
    if pMsg.m_sbyInfo[0] <> Addr then
      exit;
    m_nTxMsg.m_sbyInfo[0] := pMsg.m_sbyInfo[0];
    m_nTxMsg.m_sbyInfo[1] := pMsg.m_sbyInfo[1];

    fnc := pMsg.m_sbyInfo[1];

    if (abs(dwLastTime - timeGetTime) / 1000 > uTimeOut)//Проверка открыта сессия или нет
      and (fnc <> 78) and (fnc <> 96)and(fnc <> 200)and(fnc <> 201)and(fnc <> 202)and(fnc <> 203)and(fnc <> 204)
                                     and(fnc <> 205)and(fnc <> 206)and(fnc <> 207)and(fnc <> 208)and(fnc <> 209)
                                     and(fnc <> 210)and(fnc <> 211)and(fnc <> 212)and(fnc <> 213)and(fnc <> 214)
       {and (fnc <> 110) and (fnc <> 104) and (fnc <> 82)} then
      exit else dwLastTime := timeGetTime;



    TraceM(4, pMsg.m_swObjID, '(__)CL4MD::>EKOM Запрос : ', @pMsg);

    Case pMsg.m_sbyInfo[1] Of
      3, 4, 118     : FNCReadCurrParKanal(pMsg);        // Чтение текущих параметров по каналам
      77            : FNCCloseSession(pMsg);            // закрыть сессию
      78            : FNCOpenSession(pMsg);             // Открыть сессию
      80            : FNCReadJrnlStrFromDate(pMsg);     // чтение журнала по строка с даты
      81, 111       : FNCSetTimeYSPD(pMsg);             // установить время в УСПД
      82, 104, 110  : FNCTimeAnswer(pMsg);              // Время в УСПД
      90            : FNCReadCurrParams(pMsg);          // Текущие значения
      91, 119       : FNCNakParams(pMsg);               // Накопительные значения по нескольким каналам
      93            : FNCEventsYSPD(pMsg);              // журнал событий УСПД
      96            : FNCVersPO(pMsg);                  // версия ПО
      97, 113       : FNCEvents(pMsg);                  // События (может не надо)
      100           : FNCSetValue(pMsg);                // установить значение
      115           : FNCReadNakEn115(pMsg);            // Чтение отсечек накопительных итогов
      116           : FNCSetTimeReadArch(pMsg);         // Установка времени чтения
      109           : FNCSerialNumb(pMsg);              // серийный номер (зарезирвировано)
      114, 112      : FNCReadEvJrnl114(pMsg);           // Журнал событий
      124           : FNCInformBlock(pMsg);             // блок информации
      126           : FNCPreTonnelMsg(pMsg);            // Посыл перед транзакцией
      79            : FNCOpenTonnelMsg(pMsg);           // открытие транзакции
      127           : FNCReadArchs(pMsg);               // Чтение архивов за несколько интервалов времени
      200           : FNCStartPool(pMsg);                            //Запустить сервер
      201           : FNCStopPool(pMsg);                             //Остановить сервер
      202           : FNCReadGraphFromMeters(pMsg);                  //Прочитать графики/архивы из устройств
      203           : FNCReBoot(pMsg);                               //Перезагрузка
      204           : FNCReadEvents(pMsg);                           //Запрс событий
      205           : FNCStartFH(pMsg);                              //Запуск поиска
      206           : FNCSetL2TM(pMsg);                              //Установка ограничения коррекции
      207           : FNCSetSynchro(pMsg);                            //Установка источника синхронизации
      208           : FNCDeepBuffer(pMsg);                            //Установка глубины буфера параметров сети
      209           : FNCBaseSize(pMsg);                              //Установка максимального размера базы
      210           : FNCDeepData(pMsg);                              //Установка глубины хранения данных
      211           : FNCClearData(pMsg);                             //Удаление  данных
      212           : FNCExecSQL(pMsg);                               //Выполнение запроса
      213           : FNCInit(pMsg);                                  //Инициализация
      214           : FNCDelArch(pMsg);                               //Удаление архивов
    Else
      FNCUnknown(pMsg);                                 // Функция неизвестна
    End;
    wCRC := CRC(m_nTxMsg.m_sbyInfo, m_nTxMsg.m_swLen - 2);
    {$IFDEF STANDART_CRC}
    //CRC CALCULATE FOR ARCH
    m_nTxMsg.m_sbyInfo[m_nTxMsg.m_swLen - 2] := wCRC Mod 256;
    m_nTxMsg.m_sbyInfo[m_nTxMsg.m_swLen - 1] := wCRC Div 256;
    {$ELSE}
    //EMCOS-CORPORATE CRC CALCULATE
    m_nTxMsg.m_sbyInfo[m_nTxMsg.m_swLen - 2] := wCRC Div 256;
    m_nTxMsg.m_sbyInfo[m_nTxMsg.m_swLen - 1] := wCRC Mod 256;
    {$ENDIF}
    CreateMSGHead(m_nTxMsg, m_nTxMsg.m_swLen);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>EKOM LOH:',@m_nTxMsg);
    Result := res;
  Except
  End;
End;

Function CEKOMModule.HiHandler(Var pMsg : CMessage) : Boolean;
Var
  res               : Boolean;
Begin
  res := True;
   //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>EKOM HIH:',@pMsg);
  Result := res;
End;

function CEKOMModule.SelfHandler(var pMsg: CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    if pMsg.m_sbyType=AL_REPMSG_TMR then
    begin
      TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>EKON SLF:',@pMsg);
      case InnerFunctionPr of
        14 :
          begin
            m_nCF.m_nSDL.m_nGST.OpenSession(InnerPDS.m_swData1,InnerPDS.m_swData2);
            m_nRepTimer.OffTimer;
          end;
        else
        begin
          m_sIsTranzOpen.m_sbIsTrasnBeg := false;
          m_nCF.SchedGo;
        end;
      end;
    end;
    InnerFunctionPr := 0;
    Result := res;
end;

Procedure CEKOMModule.RunAuto;
Begin

End;
 
function CEKOMModule.crc(var buf: array of byte; count : integer): word;
var lb, hb, b : Byte;
    i         : Integer;
begin
   lb := $FF;
   hb := $FF;
   if count>2900 then Begin result := (lb shl 8) + hb;exit;End;
   for i := 0 to count - 1 do
   begin
     b  := lb xor buf[i];
     lb := hb xor srCRCHi[b];
     hb := srCRCLo[b];
   end;
   Result := (lb shl 8) + hb;
end;

{
   unsigned char lb = $FF;
   unsigned char hb = $FF;
   unsigned char b;
   int i;
 
   for( i = 0; i < n; i++ )
   {
      b  = lb ^ buf[i];
      lb = hb ^ srCRCHi[b];
      hb = srCRCLo[b];

 {  return( ( lb << 8 ) + hb ); }




{Function CEKOMModule.CRC(var buf : Array Of byte; count : integer) : word;
Const
  srCRCHi           : Array[0..255] Of byte = (
    $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
    $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
    $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
    $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
    $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
    $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
    $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40);
  srCRCLo           : Array[0..255] Of byte = (
    $00, $C0, $C1, $01, $C3, $03, $02, $C2, $C6, $06, $07, $C7, $05, $C5, $C4, $04, $CC, $0C, $0D, $CD,
    $0F, $CF, $CE, $0E, $0A, $CA, $CB, $0B, $C9, $09, $08, $C8, $D8, $18, $19, $D9, $1B, $DB, $DA, $1A,
    $1E, $DE, $DF, $1F, $DD, $1D, $1C, $DC, $14, $D4, $D5, $15, $D7, $17, $16, $D6, $D2, $12, $13, $D3,
    $11, $D1, $D0, $10, $F0, $30, $31, $F1, $33, $F3, $F2, $32, $36, $F6, $F7, $37, $F5, $35, $34, $F4,
    $3C, $FC, $FD, $3D, $FF, $3F, $3E, $FE, $FA, $3A, $3B, $FB, $39, $F9, $F8, $38, $28, $E8, $E9, $29,
    $EB, $2B, $2A, $EA, $EE, $2E, $2F, $EF, $2D, $ED, $EC, $2C, $E4, $24, $25, $E5, $27, $E7, $E6, $26,
    $22, $E2, $E3, $23, $E1, $21, $20, $E0, $A0, $60, $61, $A1, $63, $A3, $A2, $62, $66, $A6, $A7, $67,
    $A5, $65, $64, $A4, $6C, $AC, $AD, $6D, $AF, $6F, $6E, $AE, $AA, $6A, $6B, $AB, $69, $A9, $A8, $68,
    $78, $B8, $B9, $79, $BB, $7B, $7A, $BA, $BE, $7E, $7F, $BF, $7D, $BD, $BC, $7C, $B4, $74, $75, $B5,
    $77, $B7, $B6, $76, $72, $B2, $B3, $73, $B1, $71, $70, $B0, $50, $90, $91, $51, $93, $53, $52, $92,
    $96, $56, $57, $97, $55, $95, $94, $54, $9C, $5C, $5D, $9D, $5F, $9F, $9E, $5E, $5A, $9A, $9B, $5B,
    $99, $59, $58, $98, $88, $48, $49, $89, $4B, $8B, $8A, $4A, $4E, $8E, $8F, $4F, $8D, $4D, $4C, $8C,
    $44, $84, $85, $45, $87, $47, $46, $86, $82, $42, $43, $83, $41, $81, $80, $40);

  InitCRC           : word = $FFFF;
Function UpdCRC(C : byte; oldCRC : word) : word;
Var
  i               : byte;
  arrCRC          : Array[0..1] Of byte absolute oldCRC;
begin
   i := arrCRC[1] Xor C;
   arrCRC[1] := arrCRC[0] Xor srCRCHi[i];
   arrCRC[0] := srCRCLo[i];
   UpdCRC := oldCRC;
End;
Var
  I                 : integer;
  uCRC              : word;
Begin
  uCrc := InitCRC;
  For I := 0 To Count - 1 Do uCrc := UpdCRC(Buf[I], uCrc);
  result := uCRC;
End;        }

function CEKOMModule.GetRealPort(nPort:Integer; var m_sTblL1 : SL1INITITAG):Integer;
Var
    i : Integer;
Begin
    Result := nPort;
    for i:=0 to m_sTblL1.Count-1 do
    begin
      if m_sTblL1.Items[i].m_sbyPortID=nPort then
      begin
        Result := m_sTblL1.Items[i].m_sbyPortID;
        if m_sTblL1.Items[i].m_sblReaddres=1 then Result := m_sTblL1.Items[i].m_swAddres;
        exit;
      end;
    end;
end;

End.

