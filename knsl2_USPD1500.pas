unit knsl2_USPD1500;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,utlTimeDate,knsl3EventBox,Math;
type
    USPD1500 = class(CMeter)
    Private
     nReq        : CQueryPrimitive;
     tarif       : byte;
     advInfo     : SL2TAGADVSTRUCT;
     mTimeDir    : Integer;
     procedure SetCurrQry;
     procedure SetGraphQry;
     procedure RunMeter;override;
     procedure InitMeter(var pL2:SL2TAG);override;
     function  SelfHandler(var pMsg:CMessage):Boolean;override;
     function  LoHandler(var pMsg:CMessage):Boolean;override;
     function  HiHandler(var pMsg:CMessage):Boolean;override;
     function  ReadSymEnerg(var pMsg:CMessage):boolean;
     function  ReadDayEnerg(var pMsg:CMessage):boolean;
     function  ReadMonthEnerg(var pMsg:CMessage):boolean;
     function  CheckCS17(var mas : array of byte; len : byte) : WORD;
     function  ByteStuff(var _Buffer : array of BYTE; _Len : Word) : Word;
     function  ByteUnStuff(var pMsg:CMessage;_Len : Word) : Word;
     function  HIBYTE(buf:word):BYTE;
     function  LOBYTE(buf:word):BYTE;

     procedure MSGHeadAndPUT(var pMsg:CHMessage; Size:byte);
     procedure CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     procedure CreateSymEnergReqMSG(var nReq:CQueryPrimitive);
     procedure CreateDayhEnergReqMSG(var nReq:CQueryPrimitive);
     procedure CreateMonthEnergReqMSG(var nReq:CQueryPrimitive);

     function  ReadDateTimeAns(var pMsg: CMessage):Boolean;          // Ответ для выбора запроса чтения или кор времени
     function  ReadDateTime(var pMsg:CMessage):boolean;              // Оnвет
     function  ReadCorTimeRes(var pMsg : CMessage):Boolean;          // Ответ коректировки времени от параметра

     procedure CreateAutorizeMSG(var nReq: CQueryPrimitive);         // Запрос чтения служебной информации УСПД
     function  ReadAutorize(var pMsg:CMessage):boolean;              // Оnвет чтения служебной информации УСПД

     function  CreateDateTimeReq(var nReq: CQueryPrimitive):Boolean; // Запрос для выбора чтения или кор времени
     procedure CreateDateTimeReqMSG(var nReq:CQueryPrimitive);       // Запрос чтение даты/времени
     procedure SetDateTimeToMeter(var nReq: CQueryPrimitive);        // Запрос корректировка даты/времени

     procedure AddEnergyMonthGrpahQry(Date1, Date2:TDateTime);
     procedure AddNakEnMonthGrpahQry(Date1, Date2:TDateTime);
     procedure AddSresEnDayGraphQry(Date1, Date2: TDateTime);

     procedure OnFinHandQryRoutine(var pMsg:CMessage);
     procedure HandQryRoutine(var pMsg:CMessage);
     constructor Create;
    End;
    
implementation
  const
      ST_164_READ_TIME             = 0;
      ST_164_CORR_TIME             = 1;

  const tblCRChi : array[0..255] of byte = (
  $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81,
  $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0,
  $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01,
  $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41,
  $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81,
  $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0,
  $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01,
  $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40,
  $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81,
  $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0,
  $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01,
  $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
  $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81,
  $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0,
  $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01,
  $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
  $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81,
  $40);

  const tblCRClo: array[0..255] of byte =
  (
  $00, $C0, $C1, $01, $C3, $03, $02, $C2, $C7, $07, $07, $C7, $05, $C5, $C4,
  $04, $CC, $0C, $0D, $CD, $0F, $CF, $CE, $0E, $0A, $CA, $CB, $0B, $C9, $09,
  $08, $C8, $D8, $18, $19, $D9, $1B, $DB, $DA, $1A, $1E, $DE, $DF, $1F, $DD,
  $1D, $1C, $DC, $14, $D4, $D5, $15, $D7, $17, $17, $D7, $D2, $12, $13, $D3,
  $11, $D1, $D0, $10, $F0, $30, $31, $F1, $33, $F3, $F2, $32, $37, $F7, $F7,
  $37, $F5, $35, $34, $F4, $3C, $FC, $FD, $3D, $FF, $3F, $3E, $FE, $FA, $3A,
  $3B, $FB, $39, $F9, $F8, $38, $28, $E8, $E9, $29, $EB, $2B, $2A, $EA, $EE,
  $2E, $2F, $EF, $2D, $ED, $EC, $2C, $E4, $24, $25, $E5, $27, $E7, $E7, $27,
  $22, $E2, $E3, $23, $E1, $21, $20, $E0, $A0, $70, $71, $A1, $73, $A3, $A2,
  $72, $77, $A7, $A7, $77, $A5, $75, $74, $A4, $7C, $AC, $AD, $7D, $AF, $7F,
  $7E, $AE, $AA, $7A, $7B, $AB, $79, $A9, $A8, $78, $78, $B8, $B9, $79, $BB,
  $7B, $7A, $BA, $BE, $7E, $7F, $BF, $7D, $BD, $BC, $7C, $B4, $74, $75, $B5,
  $77, $B7, $B7, $77, $72, $B2, $B3, $73, $B1, $71, $70, $B0, $50, $90, $91,
  $51, $93, $53, $52, $92, $97, $57, $57, $97, $55, $95, $94, $54, $9C, $5C,
  $5D, $9D, $5F, $9F, $9E, $5E, $5A, $9A, $9B, $5B, $99, $59, $58, $98, $88,
  $48, $49, $89, $4B, $8B, $8A, $4A, $4E, $8E, $8F, $4F, $8D, $4D, $4C, $8C,
  $44, $84, $85, $45, $87, $47, $47, $87, $82, $42, $43, $83, $41, $81, $80,
  $40
  );

procedure USPD1500.AddEnergyMonthGrpahQry(Date1, Date2:TDateTime);
var Year, Month, Day : word;
    i                : integer;
    TempDate         : TDateTime;
begin
   while (Date1 <= Date2) and (Date1 <= Now) do
   begin
     DecodeDate(Date1, Year, Month, Day);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 1, 0, 1);
     cDateTimeR.IncMonth(Date1);
   end;
end;

procedure USPD1500.AddNakEnMonthGrpahQry(Date1, Date2:TDateTime);
var Year, Month, Day : word;
    i                : integer;
    TempDate         : TDateTime;
begin

   while (Date1 <= Date2) and (Date1 <= Now) do
   begin
     DecodeDate(Date1, Year, Month, Day);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 0, Year, 1);
//     m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
     cDateTimeR.IncMonth(Date1);
   end;
end;

procedure USPD1500.AddSresEnDayGraphQry(Date1, Date2: TDateTime);
var i : integer;
begin
   for i := trunc(Date1) to trunc(Date2) do
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, abs(trunc(Now) - i), 0, 0, 1);
end;

procedure USPD1500.SetDateTimeToMeter(var nReq: CQueryPrimitive);
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
    CRC :WORD;
begin
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    m_nTxMsg.m_sbyInfo[0] := $53; //адрес
    m_nTxMsg.m_sbyInfo[1] := $00; //адрес
    m_nTxMsg.m_sbyInfo[2] := $01; //ИД пакета
    m_nTxMsg.m_sbyInfo[3] := $05; //Функция
    m_nTxMsg.m_sbyInfo[4] := $01; //ИД прибора
    m_nTxMsg.m_sbyInfo[5] := $00; //ИД прибора
    m_nTxMsg.m_sbyInfo[6] := Year; //данные 6 байт (любые)
    m_nTxMsg.m_sbyInfo[7] := Month; //данные 6 байт (любые)
    m_nTxMsg.m_sbyInfo[8] := Day;   //данные 6 байт (любые)
    m_nTxMsg.m_sbyInfo[9] := Hour; //данные 6 байт (любые)
    m_nTxMsg.m_sbyInfo[10] := Min; //данные 6 байт (любые)
    m_nTxMsg.m_sbyInfo[11] := Sec; //данные 6 байт (любые)
    CRC := CheckCS17(m_nTxMsg.m_sbyInfo[0], 12);
    move(CRC, m_nTxMsg.m_sbyInfo[12], 2);      //-1
    MSGHeadAndPUT(m_nTxMsg, ByteStuff(m_nTxMsg.m_sbyInfo[0],14));
end;

function USPD1500.CheckCS17(var mas:array of byte; len : byte) : WORD;
var idx,i :byte;
    CRChi,CRClo :byte;
    CRC :WORD;
begin  //Проверяет контрольную сумму
 CRChi := $FF;
 CRClo := $FF;
 for i:=0 to len-1 do
  begin
   idx := (CRChi XOR mas[i]) and ($FF);
   CRChi := CRClo XOR tblCRChi[idx];
   CRClo := tblCRClo[idx];
  end;
  CRC:= ((CRChi shl 8) or CRClo);
  Result:= CRC;
end;

{*******************************************************************************
 *  Пакет перед посылкой подлежит обработке механизмом байтстаффинга
 *  При байтстаффинге анализируется каждый байт:
 ******************************************************************************}
function USPD1500.ByteStuff(var _Buffer : array of BYTE; _Len : Word) : Word;
var
  i, l,nLeft,nRight,nBitCount,nByte,nCounter : integer;
  pack_size:integer;
  BitStaff : array[0..49] of BYTE;
begin
 nLeft := 0;
 nRight := 0;
 nBitCount := 0;
 nByte := 0;
 nCounter := 1;
 pack_size:=_len-1;

 for i:=0 to 49 do
   BitStaff[i]:=0;

 BitStaff[0] := 126; // Флаг начала кадра      //BitStaff[0] = 127; // Флаг начала кадра
 for i := 0 to pack_size do                   //for(int i = 0; i < nPacketSize; i++)
   begin
    nByte := _Buffer[i] or (nByte and $FF00); //nByte = m_pSendBuf[i] | (nByte & 0xFF00);
    for nRight := 8 downto 1 do               //for(nRight = 8; nRight > 0; nRight--)
     begin
       nByte:=nByte shl 1;                   //nByte <<= 1;
       inc(nLeft);
        if(nLeft = 8) then                   //if((++nLeft) == 8)
          begin
           BitStaff[nCounter] := HIBYTE(nByte);  //BitStaff[nCounter++] = HIBYTE(nByte);
           inc(nCounter);
           nLeft := 0;                           //nLeft = 0;
          end;
          if ((HIBYTE(nByte) and 1)>0) then       //if(HIBYTE(nByte) & 1)
           begin
            inc(nBitCount);                       //nBitCount++;
            if(nBitCount = 5)then                 //if(nBitCount == 5)
              begin
               nByte := (nByte and $00FF) or ((nByte and $FF00) shl 1); //nByte = (nByte & 0x00FF) | ((nByte & 0xFF00) << 1);
               inc(nLeft);                        //nLeft++;
               nBitCount := 0;                    //nBitCount = 0;
              end;
             if(nLeft = 8)then                    //if(nLeft == 8)
              begin
               BitStaff[nCounter] := HIBYTE(nByte); //BitStaff[nCounter++] = HIBYTE(nByte);
               inc(nCounter);
               nLeft := 0;                         //nLeft = 0;
              end;
           end
          else
          nBitCount := 0;        //nBitCount = 0;
     end;
   end;
  if(nLeft>0)then   //if(nLeft)
  begin
   nByte:= (nByte shl 8) - nLeft;   //nByte <<= 8 - nLeft;
   BitStaff[nCounter] := HIBYTE(nByte); //BitStaff[nCounter++] = HIBYTE(nByte);
   inc(nCounter);
  end;
   BitStaff[nCounter] := 127; // BitStaff[nCounter] = 127; // Флаг окончания кадра
   Result:=nCounter + 1;
   move(BitStaff,_Buffer,Result);
end;

{*******************************************************************************
 *  Пакет перед посылкой подлежит обработке механизмом байтстаффинга
 *  При байтстаффинге анализируется каждый байт
*******************************************************************************}
function USPD1500.ByteUnStuff(var pMsg:CMessage;_Len : Word) : Word;
var
  i, l,nLeft,nRight,nBitCount,nWord,nCounter : integer;
  pack_size:integer;
  BitStaff : array[0..49] of BYTE;
begin
 nLeft := 0;     //nLeft 0
 nRight := 8;    //nRight
 nBitCount := 0; //nBitCount 0
 nWord := 0;     //nWord     0
 nCounter := 0;  //nCounter 0
 pack_size:=_len-1;

 for i:=0 to 49 do
   BitStaff[i]:=0;

 for i := 1 to pack_size do      //for(int i = 1; i < nPacketSize - 1; i++)
   begin
    nWord := pMsg.m_sbyInfo[i] or (nWord and $FF00);  //nWord = m_pSendBuf[i] | (nWord & 0xFF00);
    nRight:=8;
    while nRight>0 do           //for(nRight = 8; nRight > 0; nRight--)
     begin
       if(nBitCount = 5)then     //if(nBitCount == 5)
        begin
         nWord := (nWord and $FF00) or (LOBYTE(nWord) shl 1);   //nWord = (nWord & 0xFF00) | (LOBYTE(nWord) << 1);
         dec(nRight);             //nRight--;
         nBitCount := 0;          //nBitCount = 0;
         if not (nRight>0) then break;  //if(!nRight)break;
        end;
        nWord:= nWord shl 1;
        if (HIBYTE(nWord) and 1)>0 then  //if(HIBYTE(nWord <<= 1) & 1)
           inc(nBitCount)  //nBitCount++;
        else
           nBitCount:= 0;  //nBitCount = 0;
        inc(nLeft);
        if nLeft = 8 then   //if((++nLeft) == 8)
          begin
           BitStaff[nCounter]:=HIBYTE(nWord);   //BitStaff[nCounter++] = HIBYTE(nWord);
           inc(nCounter);
           nLeft := 0;   //nLeft = 0;
          end;
          dec(nRight);
     end;
   end;
   FillChar(pMsg.m_sbyInfo,SizeOf(pMsg.m_sbyInfo),0);  //обнулить массив
   move(BitStaff,pMsg.m_sbyInfo,nCounter);
end;

function USPD1500.HIBYTE(buf:word):BYTE;   //inline unsigned char& HIBYTE(unsigned short &word)
var
  res:word;
begin
  res:=(buf mod 65536) shr 8;
  result:= res mod 256;
end;

function USPD1500.LOBYTE(buf:word):BYTE;  //unsigned short&word
begin
  result:=buf mod 256;
end;

procedure USPD1500.MSGHeadAndPUT(var pMsg:CHMessage; Size:byte);
begin  //Создание шапки сообщения и отправка на L1
    pMsg.m_swLen        := Size + 13;
    pMsg.m_swObjID      := m_nP.m_swMID;  //Сетевой адрес счётчика
    pMsg.m_sbyFrom      := DIR_L2TOL1;
    pMsg.m_sbyFor       := DIR_L2TOL1;    //DIR_L2toL1
    pMsg.m_sbyType      := PH_DATARD_REQ; //PH_DATARD_REC
    pMsg.m_sbyIntID     := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID  := MET_USPD1500;     //Указать тип счетчика
    pMsg.m_sbyDirID     := m_nP.m_sbyPortID;
    SendToL1(BOX_L1, @pMsg);
end;

procedure USPD1500.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
begin                         //sm - вид энергии; tar - тарифф
   DecodeDate(Date, Year, Month, Day);
   DecodeTime(Date, Hour, Min, Sec, ms);
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   //m_nRxMsg.m_sbyServerID := 0;
   m_nRxMsg.m_swLen      := 13 + 9 + sizeof(double);
   m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
   m_nRxMsg.m_sbyInfo[1] := sm;
   m_nRxMsg.m_sbyInfo[2] := Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := Month;
   m_nRxMsg.m_sbyInfo[4] := Day;
   m_nRxMsg.m_sbyInfo[5] := Hour;
   m_nRxMsg.m_sbyInfo[6] := Min;
   m_nRxMsg.m_sbyInfo[7] := Sec;
   m_nRxMsg.m_sbyInfo[8] := tar;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(double));
   m_nRxMsg.m_sbyDirID   := IsUpdate;
end;

function  USPD1500.ReadSymEnerg(var pMsg:CMessage):boolean;
var
    YearN, MonthN, DayN, HourN, MinN, SecN  : word;
    //CRC,CRRC             : WORD;
    T0,T1,T2,T3,T4       : single;
    DateRead             : TDateTime;
    Status               : Byte;
begin
   Result:=true;
   T0:=0;   T1:=0;   T2:=0;   T3:=0;   T4:=0; Status:=0;
//   CRC:= CheckCS17(pMsg.m_sbyInfo[0], pMsg.m_swLen-13-2);
//   move(pMsg.m_sbyInfo[pMsg.m_swLen-13-2],CRRC, 2);
//   if CRC<>CRRC then
//     begin
//       Result:=false;
//       exit;
//     end
//   else
//    begin
      try
           YearN  := pMsg.m_sbyInfo[6]+2000;//год
           MonthN := pMsg.m_sbyInfo[7];    //месяц
           DayN   := pMsg.m_sbyInfo[8];    //день
           HourN  := pMsg.m_sbyInfo[9];    //Час
           MinN   := pMsg.m_sbyInfo[10];   //Мин
           SecN   := pMsg.m_sbyInfo[11];   //Сек
           DateRead:=EncodeDate(YearN,MonthN,DayN) + EncodeTime(HourN,MinN,SecN,0);

           Move(pMsg.m_sbyInfo[12],T0,4);
    //       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T0= '+FloatToStr(T0));
           Move(pMsg.m_sbyInfo[16],T1,4);
    //       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T1= '+FloatToStr(T1));
           Move(pMsg.m_sbyInfo[20],T2,4);
    //       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T2= '+FloatToStr(T2));
           Move(pMsg.m_sbyInfo[24],T3,4);
    //       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T3= '+FloatToStr(T3));
           Move(pMsg.m_sbyInfo[28],T4,4);
    //       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T4= '+FloatToStr(T4));
           Status:=pMsg.m_sbyInfo[32];
           if (status and 1)>0 then
           begin
            CreateOutMSG(T0,QRY_ENERGY_SUM_EP, 0, DateRead);
            saveToDB(m_nRxMsg);
           end;
           if (status and 2)>0 then
           begin
             CreateOutMSG(T1,QRY_ENERGY_SUM_EP, 1, DateRead);
             saveToDB(m_nRxMsg);
           end;
           if (status and 4)>0 then
           begin
             CreateOutMSG(T2,QRY_ENERGY_SUM_EP, 2, DateRead);
             saveToDB(m_nRxMsg);
           end;
           if (status and 8)>0 then
           begin
             CreateOutMSG(T3,QRY_ENERGY_SUM_EP, 3, DateRead);
             saveToDB(m_nRxMsg);
           end;
           if (status and 16)>0 then
           begin
             CreateOutMSG(T4,QRY_ENERGY_SUM_EP, 4, DateRead);
             saveToDB(m_nRxMsg);
           end;
      except
           if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(Ошибка в принятии текущих данных УСПД 1500!!!) ');
           Result:=False;       
      end;
//    end;
end;

function  USPD1500.ReadDayEnerg(var pMsg:CMessage):boolean;
var
    YearN, MonthN, DayN, HourN, MinN, SecN  : word;
//    CRC,CRRC             : WORD;
    T0,T1,T2,T3,T4       : single;
    DateRead             : TDateTime;
    Status               : Byte;
begin
   Result:=true;
   T0:=0;   T1:=0;   T2:=0;   T3:=0;   T4:=0; Status:=0;
   //CRC:= CheckCS17(pMsg.m_sbyInfo[0], pMsg.m_swLen-13-3);
   //move(pMsg.m_sbyInfo[pMsg.m_swLen-13-3],CRRC, 2);
//   if CRC<>CRRC then
//     begin
//       Result:=false;
//       exit;
//     end
//   else
//    begin
  try
       YearN  := pMsg.m_sbyInfo[6]+2000;//год
       MonthN := pMsg.m_sbyInfo[7];    //месяц
       DayN   := pMsg.m_sbyInfo[8];    //день
       HourN  := pMsg.m_sbyInfo[9];    //Час
       MinN   := pMsg.m_sbyInfo[10];   //Мин
       SecN   := pMsg.m_sbyInfo[11];   //Сек
       DateRead:=EncodeDate(YearN,MonthN,DayN) + EncodeTime(HourN,MinN,SecN,0);

       Move(pMsg.m_sbyInfo[12],T0,4);
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T0= '+FloatToStr(T0));
       Move(pMsg.m_sbyInfo[16],T1,4);
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T1= '+FloatToStr(T1));
       Move(pMsg.m_sbyInfo[20],T2,4);
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T2= '+FloatToStr(T2));
       Move(pMsg.m_sbyInfo[24],T3,4);
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T3= '+FloatToStr(T3));
       Move(pMsg.m_sbyInfo[28],T4,4);
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T4= '+FloatToStr(T4));
       Status:=pMsg.m_sbyInfo[32];
       if (status and 1)>0 then
       begin
        CreateOutMSG(T0,QRY_NAK_EN_MONTH_EP, 0, DateRead);
        saveToDB(m_nRxMsg);
       end;
       if (status and 2)>0 then
       begin
         CreateOutMSG(T1,QRY_NAK_EN_MONTH_EP, 1, DateRead);
         saveToDB(m_nRxMsg);
       end;
       if (status and 4)>0 then
       begin
         CreateOutMSG(T2,QRY_NAK_EN_MONTH_EP, 2, DateRead);
         saveToDB(m_nRxMsg);
       end;
       if (status and 8)>0 then
       begin
         CreateOutMSG(T3,QRY_NAK_EN_MONTH_EP, 3, DateRead);
         saveToDB(m_nRxMsg);
       end;
       if (status and 16)>0 then
       begin
         CreateOutMSG(T4,QRY_NAK_EN_MONTH_EP, 4, DateRead);
         saveToDB(m_nRxMsg);
       end;
  except
       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(Ошибка в принятии месячных данных УСПД 1500!!!) ');
       Result:=False;       
  end;
end;

function  USPD1500.ReadMonthEnerg(var pMsg:CMessage):boolean;
var
    YearN, MonthN, DayN, HourN, MinN, SecN  : word;
    T0,T1,T2,T3,T4       : single;
    DateRead             : TDateTime;
    Status               : Byte;
begin
   Result:=true;
   T0:=0;   T1:=0;   T2:=0;   T3:=0;   T4:=0; Status:=0;
   //CRC:= CheckCS17(pMsg.m_sbyInfo[0], pMsg.m_swLen-13-3);
   //move(pMsg.m_sbyInfo[pMsg.m_swLen-13-3],CRRC, 2);
//   if CRC<>CRRC then
//     begin
//       Result:=false;
//       exit;
//     end
//   else
//    begin
  try
       YearN  := pMsg.m_sbyInfo[6]+2000;//год
       MonthN := pMsg.m_sbyInfo[7];    //месяц
       DayN   := pMsg.m_sbyInfo[8];    //день
       HourN  := pMsg.m_sbyInfo[9];    //Час
       MinN   := pMsg.m_sbyInfo[10];   //Мин
       SecN   := pMsg.m_sbyInfo[11];   //Сек
       DateRead:=EncodeDate(YearN,MonthN,DayN) + EncodeTime(HourN,MinN,SecN,0);

       Move(pMsg.m_sbyInfo[12],T0,4);
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T0= '+FloatToStr(T0));
       Move(pMsg.m_sbyInfo[16],T1,4);
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T1= '+FloatToStr(T1));
       Move(pMsg.m_sbyInfo[20],T2,4);
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T2= '+FloatToStr(T2));
       Move(pMsg.m_sbyInfo[24],T3,4);
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T3= '+FloatToStr(T3));
       Move(pMsg.m_sbyInfo[28],T4,4);
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'T4= '+FloatToStr(T4));
       Status:=pMsg.m_sbyInfo[32];
       if (status and 1)>0 then
       begin
        CreateOutMSG(T0,QRY_NAK_EN_MONTH_EP, 0, DateRead);
        saveToDB(m_nRxMsg);
       end;
       if (status and 2)>0 then
       begin
         CreateOutMSG(T1,QRY_NAK_EN_MONTH_EP, 1, DateRead);
         saveToDB(m_nRxMsg);
       end;
       if (status and 4)>0 then
       begin
         CreateOutMSG(T2,QRY_NAK_EN_MONTH_EP, 2, DateRead);
         saveToDB(m_nRxMsg);
       end;
       if (status and 8)>0 then
       begin
         CreateOutMSG(T3,QRY_NAK_EN_MONTH_EP, 3, DateRead);
         saveToDB(m_nRxMsg);
       end;
       if (status and 16)>0 then
       begin
         CreateOutMSG(T4,QRY_NAK_EN_MONTH_EP, 4, DateRead);
         saveToDB(m_nRxMsg);
       end;
  except
       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(Ошибка в принятии месячных данных УСПД 1500!!!) ');
       Result:=False;       
  end;
end;

function  USPD1500.ReadDateTime(var pMsg:CMessage):boolean;
var
    YearN, MonthN, DayN, HourN, MinN, SecN  : word;
    Year, Month, Day, Hour, Min, Sec,mSec  : word;
    DateRead             : TDateTime;
begin
    YearN  := pMsg.m_sbyInfo[6];    //год
    MonthN := pMsg.m_sbyInfo[7];    //месяц
    DayN   := pMsg.m_sbyInfo[8];    //день
    HourN  := pMsg.m_sbyInfo[9];    //Час
    MinN   := pMsg.m_sbyInfo[10];   //Мин
    SecN   := pMsg.m_sbyInfo[11];   //Сек
    DateRead:=EncodeDate(YearN,MonthN,DayN) + EncodeTime(HourN,MinN,SecN,0);

    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
     if (Year <> YearN) or (Month <> MonthN) or (Day <> DayN)
        or (Hour <> HourN) or (Min <> MinN) or (abs(SecN - Sec) >= 5) then
       begin
         mTimeDir := ST_164_CORR_TIME;
         m_nObserver.AddGraphParam(QRY_DATA_TIME, 0,0,0,1);  //заносим в спеки параметры для определения типа запроса(на разъем или на счетчики)
         Result := true;
       end
     else
       begin
         mTimeDir := ST_164_READ_TIME; //потом убрать
         m_nObserver.ClearGraphQry;//Очищаем буфер команд
         Result := true;
       end;
end;

(*******************************************************************************
 * Ответ "Чтение времени и даты"
 *******************************************************************************)
function USPD1500.ReadCorTimeRes(var pMsg:CMessage):Boolean;
//var
//  _yy,_mn,_dd,_hh,_mm,_ss : word;
//  ReadDate : TDateTime;
begin
//    _yy := (pMsg.m_sbyInfo[5]);
//    _mn := (pMsg.m_sbyInfo[6]);
//    _dd := (pMsg.m_sbyInfo[7]);
//    _hh := (pMsg.m_sbyInfo[8])+3;
//    _mm := (pMsg.m_sbyInfo[9]);
//    _ss := (pMsg.m_sbyInfo[10]);
//    ReadDate:=EncodeDate(_yy,_mn,_dd) + EncodeTime(_hh,_mm,_ss,0);
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Разница по времени после корректировки нужно доработать -> ');//+DateTimeToStr(ReadDate - Now));
    Result:=True;
end;

(*******************************************************************************
 * Ответ "Чтение служебной инф"
 *******************************************************************************)
function USPD1500.ReadAutorize(var pMsg:CMessage):Boolean;
begin
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Чтение служебной информации -> Не реализована ');//+DateTimeToStr(ReadDate - Now));
    Result:=True;
end;

procedure USPD1500.CreateSymEnergReqMSG(var nReq:CQueryPrimitive);
var
    CRC :WORD;
    Addr : Integer;
begin
    Addr:=StrToInt(advInfo.m_sKoncFubNum);
    m_nTxMsg.m_sbyInfo[0] := HI(Addr); //$53; //адрес   advInfo.m_sKoncFubNum
    m_nTxMsg.m_sbyInfo[1] := LO(Addr); //$00; //адрес
    m_nTxMsg.m_sbyInfo[2] := $01; //ИД пакета
    m_nTxMsg.m_sbyInfo[3] := $05; //Функция
    m_nTxMsg.m_sbyInfo[4] := $01; //ИД прибора     advInfo.m_sAdrToRead
    m_nTxMsg.m_sbyInfo[5] := $00; //ИД прибора
    CRC := CheckCS17(m_nTxMsg.m_sbyInfo[0], 6);
    move(CRC, m_nTxMsg.m_sbyInfo[6], 2);      //-1
    MSGHeadAndPUT(m_nTxMsg, ByteStuff(m_nTxMsg.m_sbyInfo[0],8));
end;

procedure USPD1500.CreateDayhEnergReqMSG(var nReq:CQueryPrimitive);
var
   CRC :WORD;
    Year_, Month_, Day_ : word;
    Year, Month, Day : word;
    TempDate         : TDateTime;
    OffsetM          : byte;
begin
   //(now.year - dt.year) * 12 + now.month - dt.month
   { DecodeDate(Now,Year_,Month_,Day);
    OffsetM:=(Year_ - nReq.m_swSpecc2) * 12 + Month_ - nReq.m_swSpecc0;
    m_nTxMsg.m_sbyInfo[0] := $53; //адрес
    m_nTxMsg.m_sbyInfo[1] := $00; //адрес
    m_nTxMsg.m_sbyInfo[2] := $01; //ИД пакета
    m_nTxMsg.m_sbyInfo[3] := $04; //Функция
    m_nTxMsg.m_sbyInfo[4] := $01; //ИД прибора
    m_nTxMsg.m_sbyInfo[5] := $00; //ИД прибора
    m_nTxMsg.m_sbyInfo[6] := OffsetM; //Смещение 0..35, 0 - текущий, 1-предыдущий
    m_nTxMsg.m_sbyInfo[7] := $00; //тип 0 имеет значение 0 – запрашивается суммарная накопленная энергия, от 1 до 4 – энергия по соответствующему тарифу.
    CRC := CheckCS17(m_nTxMsg.m_sbyInfo[0], 8);
    move(CRC, m_nTxMsg.m_sbyInfo[8], 2);      //-1
    MSGHeadAndPUT(m_nTxMsg, ByteStuff(m_nTxMsg.m_sbyInfo[0],10));}
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка не существующей команды! Будет очишен буфер команд для счетчика!');
end;

procedure USPD1500.CreateMonthEnergReqMSG(var nReq:CQueryPrimitive);
var
   CRC :WORD;
    Year_, Month_, Day_ : word;
    Year, Month, Day : word;
    TempDate         : TDateTime;
    OffsetM          : byte;
    Addr : Integer;
begin
    Addr:=StrToInt(advInfo.m_sKoncFubNum);
    DecodeDate(Now,Year_,Month_,Day);
    OffsetM:=(Year_ - nReq.m_swSpecc2) * 12 + Month_ - nReq.m_swSpecc0;
    m_nTxMsg.m_sbyInfo[0] := HI(Addr); //$53; //адрес   advInfo.m_sKoncFubNum
    m_nTxMsg.m_sbyInfo[1] := LO(Addr); //$00; //адрес    
    m_nTxMsg.m_sbyInfo[2] := $01; //ИД пакета
    m_nTxMsg.m_sbyInfo[3] := $04; //Функция
    m_nTxMsg.m_sbyInfo[4] := $01; //ИД прибора      advInfo.m_sAdrToRead
    m_nTxMsg.m_sbyInfo[5] := $00; //ИД прибора
    m_nTxMsg.m_sbyInfo[6] := OffsetM; //Смещение 0..35, 0 - текущий, 1-предыдущий
    m_nTxMsg.m_sbyInfo[7] := $00; //тип 0 имеет значение 0 – запрашивается суммарная накопленная энергия, от 1 до 4 – энергия по соответствующему тарифу.
    CRC := CheckCS17(m_nTxMsg.m_sbyInfo[0], 8);
    move(CRC, m_nTxMsg.m_sbyInfo[8], 2);      //-1
    MSGHeadAndPUT(m_nTxMsg, ByteStuff(m_nTxMsg.m_sbyInfo[0],10));
end;

procedure USPD1500.CreateDateTimeReqMSG(var nReq:CQueryPrimitive);
var
    CRC :WORD;
begin
    m_nTxMsg.m_sbyInfo[0] := $00; //адрес       m_sKoncFubNum
    m_nTxMsg.m_sbyInfo[1] := $00; //адрес
    m_nTxMsg.m_sbyInfo[2] := $01; //ИД пакета
    m_nTxMsg.m_sbyInfo[3] := $02; //Функция
    m_nTxMsg.m_sbyInfo[4] := $01; //ИД прибора
    m_nTxMsg.m_sbyInfo[5] := $00; //ИД прибора
    m_nTxMsg.m_sbyInfo[6] := $00; //данные 6 байт (любые)
    m_nTxMsg.m_sbyInfo[7] := $00; //данные 6 байт (любые)
    m_nTxMsg.m_sbyInfo[8] := $00; //данные 6 байт (любые)
    m_nTxMsg.m_sbyInfo[9] := $00; //данные 6 байт (любые)
    m_nTxMsg.m_sbyInfo[10] := $00; //данные 6 байт (любые)
    m_nTxMsg.m_sbyInfo[11] := $00; //данные 6 байт (любые)
    CRC := CheckCS17(m_nTxMsg.m_sbyInfo[0], 12);
    move(CRC, m_nTxMsg.m_sbyInfo[12], 2);      //-1
    MSGHeadAndPUT(m_nTxMsg, ByteStuff(m_nTxMsg.m_sbyInfo[0],14));
end;

procedure USPD1500.CreateAutorizeMSG(var nReq:CQueryPrimitive);
var
    CRC :WORD;
begin
    m_nTxMsg.m_sbyInfo[0] := $53; //адрес       m_sKoncFubNum
    m_nTxMsg.m_sbyInfo[1] := $00; //адрес
    m_nTxMsg.m_sbyInfo[2] := $01; //ИД пакета
    m_nTxMsg.m_sbyInfo[3] := $04; //Функция
    m_nTxMsg.m_sbyInfo[4] := $00; //ИД прибора
    m_nTxMsg.m_sbyInfo[5] := $00; //ИД прибора
    m_nTxMsg.m_sbyInfo[6] := $00; //данные
    CRC := CheckCS17(m_nTxMsg.m_sbyInfo[0], 7);
    move(CRC, m_nTxMsg.m_sbyInfo[7], 2);      //-1
    MSGHeadAndPUT(m_nTxMsg, ByteStuff(m_nTxMsg.m_sbyInfo[0],9));
end;

function USPD1500.ReadDateTimeAns(var pMsg: CMessage): Boolean;
begin
   Result := true;
   case mTimeDir of
     ST_164_READ_TIME : Result:=ReadDateTime(pMsg);
     ST_164_CORR_TIME :
       begin
         Result:=ReadCorTimeRes(pMsg);
         mTimeDir := ST_164_READ_TIME;
       end;
   else  mTimeDir := ST_164_READ_TIME;
   end;
end;

constructor USPD1500.Create;
Begin
End;

procedure USPD1500.InitMeter(var pL2:SL2TAG);
var
   slv : TStringList;
Begin
    IsUpdate   := 0;
    mTimeDir   := ST_164_READ_TIME; //Чтение времени

    SetHandScenario;
    SetHandScenarioGraph;

    slv := TStringList.Create;
    getStrings(m_nP.m_sAdvDiscL2Tag,slv);

    advInfo.m_sKoncFubNum  := slv[0]; //Адрес УСПД
    advInfo.m_sKoncPassw   := slv[1]; //Пароль на счетчик
    advInfo.m_sAdrToRead   := slv[2]; // Адрес счетчика
    slv.Clear;
    if slv<>Nil then FreeAndNil(slv);//slv.Destroy;
End;

procedure USPD1500.SetCurrQry;
Begin
    with m_nObserver do
    Begin
     ClearCurrQry;
     AddCurrParam(1,0,1,0,1);  //Запрос на суммарную накопленную энергию(speq1 - тариф)
     AddCurrParam(1,0,2,0,1);
     AddCurrParam(1,0,3,0,1);
     AddCurrParam(1,0,4,0,1);
     AddCurrParam(3,0,1,0,1);  //Помесячное потребление(speq1 - тариф)
     AddCurrParam(3,0,2,0,1);
     AddCurrParam(3,0,3,0,1);
     AddCurrParam(3,0,4,0,1);
     AddCurrParam(6,0,0,0,1);  //Значение 30 минутной мощности
     AddCurrParam(32,0,0,0,1); //Текущее значение времени в счетчике
     AddCurrParam(43,0,1,0,1); //Значение потребленной энергии на начало месяца
     AddCurrParam(43,0,2,0,1);
     AddCurrParam(43,0,3,0,1);
     AddCurrParam(43,0,4,0,1);
     AddCurrParam(44,0,1,0,1); //Потребленная энергия на начало года
     AddCurrParam(44,0,2,0,1);
     AddCurrParam(44,0,3,0,1);
     AddCurrParam(44,0,4,0,1);
    End;
End;

procedure USPD1500.SetGraphQry;
Begin

End;

function USPD1500.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
End;

function USPD1500.LoHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := false;
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
        try
         ByteUnStuff(pMsg,pMsg.m_swLen-13-1);   // -1 убираем байты кадров 7E 7F 
         case nReq.m_swParamID of
          QRY_ENERGY_SUM_EP    : res := ReadSymEnerg(pMsg);
          QRY_NAK_EN_DAY_EP    : res := ReadDayEnerg(pMsg);
          QRY_NAK_EN_MONTH_EP  : res := ReadMonthEnerg(pMsg);
          QRY_DATA_TIME        : res := ReadDateTimeAns(pMsg);
          QRY_AUTORIZATION     : res := ReadAutorize(pMsg);
         end;
        except
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка не существующей команды! Будет очишен буфер команд для счетчика!');
         m_nObserver.ClearGraphQry;//Очищаем буфер команд
        end;
      End;
    End;
    Result := res;
End;

procedure USPD1500.HandQryRoutine(var pMsg:CMessage);
Var
    Date1, Date2 : TDateTime;
    param        : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := 1;
   // m_nObserver.ClearGraphQry;      //Потом можно вернуть
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param := pDS.m_swData1;
    case param of
     QRY_ENERGY_MON_EP   : AddEnergyMonthGrpahQry(Date1, Date2);
     QRY_NAK_EN_MONTH_EP : AddNakEnMonthGrpahQry(Date1, Date2);
    end;
end;

function USPD1500.HiHandler(var pMsg:CMessage):Boolean;
Var
    res          : Boolean;
Begin
    res := False;
    Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
    //Обработчик для L3
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
        case (nReq.m_swParamID) of
          QRY_ENERGY_SUM_EP   : CreateSymEnergReqMSG(nReq);
          QRY_NAK_EN_DAY_EP   : CreateDayhEnergReqMSG(nReq);  //Не реализована
          QRY_NAK_EN_MONTH_EP : CreateMonthEnergReqMSG(nReq);
          QRY_DATA_TIME       : CreateDateTimeReq(nReq);      //УСПД не отвечает
          QRY_AUTORIZATION    : CreateAutorizeMSG(nReq);      //УСПД не отвечает
        else
         begin
           exit;
         end;
        end;
      End;
      QL_DATA_GRAPH_REQ:     HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    End;
    Result := res;
End;

function USPD1500.CreateDateTimeReq(var nReq: CQueryPrimitive):Boolean;
begin
   case mTimeDir of
     ST_164_READ_TIME : CreateDateTimeReqMSG(nReq);
     ST_164_CORR_TIME : SetDateTimeToMeter(nReq);
   end;
end;

procedure USPD1500.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    IsUpdate := 0;
  End;
end;

procedure USPD1500.RunMeter;
Begin

End;

end.
