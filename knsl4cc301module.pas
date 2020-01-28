unit knsl4cc301module;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,knsl4automodule
,knsl5tracer, utldatabase, knsl5config;
type
    CACC301Module = class(CHIAutomat)
    public
     m_nTxMsg, m_nRxMsg : CMessage;
     PhAddrAndComPrt    : SPHADRANDCOMPRTS;
     buf                : array [0..20] of byte;
     //m_nStopTimer       : CTimer;
     procedure InitAuto(var pTable : SL1TAG);override;
     function  SelfHandler(var pMsg : CMessage):Boolean;override;
     function  LoHandler(var pMsg : CMessage):Boolean;override;
     function  HiHandler(var pMsg : CMessage):Boolean;override;
     procedure RunAuto;override;
     function  CRC(var buf : array of byte; cnt : integer):boolean;
     procedure CreateMSGHead(var pMsg:CMessage; Size, PhAddr:byte);
     procedure CreateOutMsgHead(var pMsg : CMessage; Size : word);
     procedure SendMSGToL1();
     function  FindPortID(phAddr : byte) : byte;
     procedure StartTransmit;
     procedure FinishTransmit;
     procedure ErrorReciveMSGFromMeter(ErrC, AdvSize : byte);
     procedure CreateMSG7_1Beg;
     procedure CreateMSG7_2Beg;
     procedure CreateOutMsgPar7_1(var pMsg : CMessage);
     procedure CreateOutMsgPar7_2(var pMsg : CMessage);
     procedure CreateReq7(par, sm : shortint);
     procedure CreateOutMsg(var pMsg : CMessage);
     procedure CreateOutMSG7(Length : Word);
    End;
implementation

const Kvandrant : array[0..3] of string = ('Угол 0...90',
                                           'Угол 90...180',
                                           'Угол 180...270',
                                           'Угол 270...360');
      Tarifs    : array[0..4] of string = ('Тариф A',
                                           'Тариф B',
                                           'Тариф C',
                                           'Тариф D',
                                           'Тариф E');
      Season    : array[0..1] of string = ('Лето',
                                           'Зима');
      Resurs    : array[0..4] of string = (
                                           'Заряд 0%',
                                           'Заряд 25%',
                                           'Заряд 50%',
                                           'Заряд 75%',
                                           'Заряд 100%'
                                          );
      Jrn      : string                 = ('Нет события');
      Jrnl     : string                 = ('Проподание фазы (A, B или С)');
      Jrn2     : array[0..9] of string =  ('Аппаратная ошибка',
                                           'Сбой часов реального времени',
                                           'Поврежден файл калибровки',
                                           'Помехи в сети',
                                           'Ошибка обмена с DSP',
                                           'Ошибка DSP',
                                           'Неисправна EEPROM1',
                                           'Неисправна EEPROM2',
                                           'Неиспрано ПЗУ',
                                           'Неисправно ОЗУ');
      Jrn3     : array [0..15] of string =('Открытие крышки счетчика',
                                           'Закрытие крышки счетчика',
                                           'Корректировка времени по кнопкам',
                                           'Корректировка времени по каналам связи',
                                           'Изменение тарифного расписания',
                                           'Изменение расписания выходных дней',
                                           'Изменение даты переклчения сезонов',
                                           'Изменение констант',
                                           'Изменение параметров телеметрии',
                                           'Изменение режима',
                                           'Изменение пароля',
                                           'Обнуление энергии',
                                           'Обнулении макимальной мощности',
                                           'Обнуление срезов',
                                           'Изменение администратора',
                                           'Сканирование пароля');

procedure CACC301Module.CreateReq7(par, sm : shortint);
begin
   m_nTxMsg.m_sbyInfo[0] := buf[8];
   m_nTxMsg.m_sbyInfo[1] := 3;
   m_nTxMsg.m_sbyInfo[2] := par;
   m_nTxMsg.m_sbyInfo[3] := sm;
   m_nTxMsg.m_sbyInfo[4] := 0;
   m_nTxMsg.m_sbyInfo[5] := 0;
   CRC(m_nTxMsg.m_sbyInfo[0], 6);
   CreateMSGHead(m_nTxMsg, 11 + 6 + 2, m_nTxMsg.m_sbyInfo[0]);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure CACC301Module.CreateOutMsg(var pMsg : CMessage);
begin
   if pMsg.m_sbyInfo[3] <> 0 then
   begin  //Произошла ошибка в принятом сообщении
     move(pMsg.m_sbyInfo[0], m_nRxMsg.m_sbyInfo[8], pMsg.m_swLen - 11 - 2);
     ErrorReciveMSGFromMeter(pMsg.m_sbyInfo[4], pMsg.m_swLen - 11 - 2);
     exit;
   end;
   move(buf[0], m_nRxMsg.m_sbyInfo[0], 8);
   move(pMsg.m_sbyInfo[0], m_nRxMsg.m_sbyInfo[8], pMsg.m_swLen - 11 - 2);
   m_nRxMsg.m_sbyInfo[2] := (pMsg.m_swLen - 11 + 8) mod $100;
   m_nRxMsg.m_sbyInfo[3] := (pMsg.m_swLen - 11 + 8) div $100;
   m_nRxMsg.m_sbyInfo[5] := 1;
   TraceM(4, pMsg.m_swObjID, '(__)CL4MD::>SS301: Out MSG:', @pMsg);
   CRC(m_nRxMsg.m_sbyInfo[0], pMsg.m_swLen - 11 - 2 + 8);
   CreateOutMsgHead(m_nRxMsg, pMsg.m_swLen + 8);
   FPUT(BOX_L1, @m_nRxMsg);
   FinishTransmit;
end;

procedure CACC301Module.CreateOutMSG7(Length : Word);
begin
   move(buf[0], m_nRxMsg.m_sbyInfo[0], 11);
   m_nRxMsg.m_sbyInfo[2] := (Length) mod $100;
   m_nRxMsg.m_sbyInfo[3] := (Length) div $100;
   m_nRxMsg.m_sbyInfo[5] := 1;
   m_nRxMsg.m_sbyInfo[11]:= 0;
   CRC(m_nRxMsg.m_sbyInfo[0], Length - 2);
   CreateOutMsgHead(m_nRxMsg, Length + 11);
   FPUT(BOX_L1, @m_nRxMsg);
   FinishTransmit;
end;

procedure CACC301Module.CreateMSG7_1Beg;
var sec, min, hour, ms  : word;
    day, month, year    : word;
begin
   move(buf[8], m_nRxMsg.m_sbyInfo[0], 3);
   m_nRxMsg.m_sbyInfo[12] := buf[0]; FillChar(m_nRxMsg.m_sbyInfo[13], 3, 0);
   m_nRxMsg.m_sbyInfo[16] := buf[8]; FillChar(m_nRxMsg.m_sbyInfo[17], 3, 0);
   DecodeDate(Now, year, month, day);
   DecodeTime(Now, hour, min, sec, ms);
   m_nRxMsg.m_sbyInfo[20]  := sec;
   m_nRxMsg.m_sbyInfo[21]  := min;
   m_nRxMsg.m_sbyInfo[22] := hour;
   m_nRxMsg.m_sbyInfo[23] := day;
   m_nRxMsg.m_sbyInfo[24] := month;
   m_nRxMsg.m_sbyInfo[25] := year - 2000;
end;

procedure CACC301Module.CreateMSG7_2Beg;
begin
  { move(buf[8], m_nRxMsg.m_sbyInfo[0], 3);
   m_nRxMsg.m_sbyInfo[3] := 0;       }
end;

procedure CACC301Module.CreateOutMsgPar7_1(var pMsg : CMessage);
var i : byte;
begin
   if pMsg.m_sbyInfo[3] <> 0 then
   begin  //Произошла ошибка в принятом сообщении
     {m_nRxMsg.m_sbyInfo[8]  := buf[8];          //Берется начало запрашиваемого сообщения
     m_nRxMsg.m_sbyInfo[9]  := buf[9] or $80;
     m_nRxMsg.m_sbyInfo[10] := buf[10];
     move(pMsg.m_sbyInfo[3], m_nRxMsg.m_sbyInfo[11], pMsg.m_swLen - 11 - 2 - 3); //И код ошибки принятого сообщения}
     ErrorReciveMSGFromMeter(pMsg.m_sbyInfo[3], pMsg.m_swLen - 11 - 2);
     exit;
   end;
   case pMsg.m_sbyInfo[2] of
     13 : begin            // F
            move(pMsg.m_sbyInfo[4], m_nRxMsg.m_sbyInfo[26], 4);
            //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение частоты + запрос мощности');
            CreateReq7(8, 0);
          end;
     8  : begin            // P, Pa, Pb, Pc
            move(pMsg.m_sbyInfo[4], m_nRxMsg.m_sbyInfo[30], 4*4);
            //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение мошности + запрос реактивной мощности');
            CreateReq7(9, 0);
          end;
     9  : begin            // Q, Qa, Qb, Qc
            move(pMsg.m_sbyInfo[4], m_nRxMsg.m_sbyInfo[46], 4*4);
            //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение реактивной мошности + запрос напряжения');
            CreateReq7(10, 0);
          end;
     10 : begin            // Ua, Ub, Uc
            move(pMsg.m_sbyInfo[4], m_nRxMsg.m_sbyInfo[62], 4*3);
            //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение напряжения + запрос токов');
            CreateReq7(11, 0);
          end;
     11 : begin            // Ia, Ib, Ic
            move(pMsg.m_sbyInfo[4], m_nRxMsg.m_sbyInfo[74], 4*3);
            //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение напряжения + запрос коэффициентов мощности');
            CreateReq7(12, 0);
          end;
     12 : begin            // KPa, KPb, KPc
            move(pMsg.m_sbyInfo[4], m_nRxMsg.m_sbyInfo[86], 4*3);
            //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение коэффициентов мощности + запрос коэффициентов');
            CreateReq7(24, 0);
          end;
     24 : begin            // KE, KU, KI
            m_nRxMsg.m_sbyInfo[98] := pMsg.m_sbyInfo[8]; FillChar(m_nRxMsg.m_sbyInfo[99], 3, 0);
            m_nRxMsg.m_sbyInfo[102] := 1; FillChar(m_nRxMsg.m_sbyInfo[103], 3, 0);
            m_nRxMsg.m_sbyInfo[106] := 1; FillChar(m_nRxMsg.m_sbyInfo[107], 3, 0);
            TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение коэффициентов + запрос типа счетчика');
            CreateReq7(17, 0);
          end;
     17 : begin            // meter_type, meter_adr
            FillChar(m_nRxMsg.m_sbyInfo[110], 20, 0);
            move(pMsg.m_sbyInfo[4], m_nRxMsg.m_sbyInfo[110], 16);
            m_nRxMsg.m_sbyInfo[130] := pMsg.m_sbyInfo[0]; FillChar(m_nRxMsg.m_sbyInfo[131], 3, 0);
            //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение типа счетчика + запрос заводского номера');
            CreateReq7(18, 0);
          end;
     18 : begin            // ZN
            FillChar(m_nRxMsg.m_sbyInfo[134], 20, 0);
            move(pMsg.m_sbyInfo[4], m_nRxMsg.m_sbyInfo[134], 10);
            //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение заводского номера + запрос дат');
            CreateReq7(19, 0);
          end;
     19 : begin            // Date-issue, meter-time
            move(pMsg.m_sbyInfo[4], m_nRxMsg.m_sbyInfo[154], 6);
            move(m_nRxMsg.m_sbyInfo[20], m_nRxMsg.m_sbyInfo[160], 6);
            //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение дат + запрос состояния');
            CreateReq7(33, 0);
          end;
     33 : begin            //meter-quadr, meter-tarif, meter-season
            FillChar(m_nRxMsg.m_sbyInfo[166], 80, 0);
            move(Kvandrant[pMsg.m_sbyInfo[4]][1], m_nRxMsg.m_sbyInfo[166], Length(Kvandrant[pMsg.m_sbyInfo[4]]));
            i := 0;
            while pMsg.m_sbyInfo[4] div 2 <> 0 do begin pMsg.m_sbyInfo[4] := pMsg.m_sbyInfo[4] div 2; Inc(i); end;
            move(Tarifs[i][1],m_nRxMsg.m_sbyInfo[186],Length(Tarifs[i]));
            move(Season[pMsg.m_sbyInfo[6]][1], m_nRxMsg.m_sbyInfo[206], length(Season[pMsg.m_sbyInfo[6]]));
            move(Resurs[pMsg.m_sbyInfo[7]][1], m_nRxMsg.m_sbyInfo[226], length(Resurs[pMsg.m_sbyInfo[7]]));
            TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение состояния + запрос версии ПО');
            CreateReq7(20, 0);
          end;
     20 : begin            // Vers
            FillChar(m_nRxMsg.m_sbyInfo[246], 20, 0);
            move(pMsg.m_sbyInfo[4], m_nRxMsg.m_sbyInfo[246], 4);
            TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Отправка сообщения в энергосбыт: ');
            CreateOutMSG7(268);
          end;//The End
   end;
end;

procedure CACC301Module.CreateOutMsgPar7_2(var pMsg : CMessage);
var Mask : WORD;
    Deep : shortint;
begin
   if pMsg.m_sbyInfo[3] <> 0 then
   begin                                        //Произошла ошибка в принятом сообщении
{     m_nRxMsg.m_sbyInfo[8]  := buf[8];          //Берется начало запрашиваемого сообщения
     m_nRxMsg.m_sbyInfo[9]  := buf[9] or $80;
     m_nRxMsg.m_sbyInfo[10] := buf[10];
     move(pMsg.m_sbyInfo[3], m_nRxMsg.m_sbyInfo[11], pMsg.m_swLen - 11 - 2 - 3); //И код ошибки принятого сообщения}
     ErrorReciveMSGFromMeter(pMsg.m_sbyInfo[3], pMsg.m_swLen - 11 - 2);
     exit;
   end;
   Mask := pMsg.m_sbyInfo[9]  + pMsg.m_sbyInfo[10] shl 8;
   Deep := m_nTxMsg.m_sbyInfo[3];                 //Глубина чтения события
   FillChar(m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 12], 90, 0);
   move(pMsg.m_sbyInfo[4], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 12], 6);
   if Mask = 0 then
   begin
     move(Jrn[1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrnl));
     //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn);
     exit;
   end;
   case pMsg.m_sbyInfo[2] of
     14 : begin
          if ((Mask and $0001) = 1) or ((Mask and $0002) = 2)
              or ((Mask and $0004) = 4) then
          begin
            move(Jrnl[1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrnl));
            //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrnl);
          end;
          end;
     15 : begin
            if (Mask and $0001) = $0001 then
            begin
              move(Jrn2[0][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn2[0]));
              //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn2[0]);
            end;
            if (Mask and $0002) = $0002 then
            begin
              move(Jrn2[1][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn2[1]));
              //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn2[1]);
            end;
            if (Mask and $0008) = $0008 then
            begin
              move(Jrn2[2][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn2[2]));
              //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn2[2]);
            end;
            if (Mask and $0010) = $0010 then
            begin
              move(Jrn2[3][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn2[3]));
              //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn2[3]);
            end;
            if (Mask and $0100) = $0100 then
            begin
              move(Jrn2[4][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn2[4]));
              //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn2[4]);
            end;
            if (Mask and $0200) = $0200 then
            begin
              move(Jrn2[5][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn2[5]));
              //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn2[5]);
            end;
            if ((Mask and $0800) = $0800) then
            begin
              move(Jrn2[6][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn2[6]));
              //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn2[6]);
            end;
            if ((Mask and $1000) = $1000) then
            begin
              move(Jrn2[7][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn2[7]));
              //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn2[7]);
            end;
            if ((Mask and $4000) = $4000) then
            begin
              move(Jrn2[8][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn2[8]));
              //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn2[8]);
            end;
            if ((Mask and $8000) = $8000) then
            begin
              move(Jrn2[9][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn2[9]));
              //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn2[9]);
            end;
          end;
     16 : begin
            if (Mask and $0001) = $0001 then
            begin
              move(Jrn3[0][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[0]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[0]);
            end;
            if (Mask and $0002) = $0002 then
            begin
              move(Jrn3[1][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[1]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[1]);
            end;
            if (Mask and $0004) = $0004 then
            begin
              move(Jrn3[2][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[2]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[2]);
            end;
            if (Mask and $0008) = $0008 then
            begin
              move(Jrn3[3][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[3]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[3]);
            end;
            if (Mask and $0010) = $0010 then
            begin
              move(Jrn3[4][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[4]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[4]);
            end;
            if (Mask and $0020) = $0020 then
            begin
              move(Jrn3[5][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[5]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[5]);
            end;
            if (Mask and $0040) = $0040 then
            begin
              move(Jrn3[6][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[6]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[6]);
            end;
            if (Mask and $0080) = $0080 then
            begin
              move(Jrn3[7][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[7]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[7]);
            end;
            if (Mask and $0100) = $0100 then
            begin
              move(Jrn3[8][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[8]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[8]);
            end;
            if (Mask and $0200) = $0200 then
            begin
              move(Jrn3[9][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[9]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[9]);
            end;
            if (Mask and $0400) = $0400 then
            begin
              move(Jrn3[10][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[10]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[10]);
            end;
            if (Mask and $0800) = $0800 then
            begin
              move(Jrn3[11][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[11]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[11]);
            end;
            if (Mask and $1000) = $1000 then
            begin
              move(Jrn3[12][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[12]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[12]);
            end;
            if (Mask and $2000) = $2000 then
            begin
              move(Jrn3[13][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[13]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[13]);
            end;
            if (Mask and $4000) = $4000 then
            begin
              move(Jrn3[14][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[14]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[14]);
            end;
            if (Mask and $8000) = $8000 then
            begin
              move(Jrn3[15][1], m_nRxMsg.m_sbyInfo[(abs(Deep) - 1)*90 + 22], Length(Jrn3[15]));
              TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Чтение журнала : ' + Jrn3[15]);
            end;
          end;
   end;
   if (Deep = -32) then
     CreateOutMSG7(2894)
   else
     CreateReq7(m_nTxMsg.m_sbyInfo[2], Deep - 1);
end;

procedure CACC301Module.ErrorReciveMSGFromMeter(ErrC, AdvSize : byte);
begin
   TraceL(4,m_nRxMsg.m_swObjID,'(__)CL4MD::>SS301: Ошибка принятия сообщения, Код ошибки : ' + IntToStr(ErrC));
   move(buf[0], m_nRxMsg.m_sbyInfo[0], 12);
   m_nRxMsg.m_sbyInfo[1]  := $82;
   m_nRxMsg.m_sbyInfo[5]  := 1;
   m_nRxMsg.m_sbyInfo[9]  := buf[9] or $80;
   m_nRxMsg.m_sbyInfo[11] := Errc;
   CRC(m_nRxMsg.m_sbyInfo[0], 12);
   CreateOutMsgHead(m_nRxMsg, 11 + 12 + 2);
   FPUT(BOX_L1, @m_nRxMsg);
   FinishTransmit;
end;

procedure CACC301Module.StartTransmit;
Var
    pDS : CMessageData;
begin
   //TraceL(4, 0,'(__)CL4MD::>SS301:  : Начало опроса Энергосбытом. Основной опрос остановлен');
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   m_nCF.SchedPause;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
   m_sIsTranzOpen.m_sbIsTrasnBeg := true;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
end;

procedure CACC301Module.FinishTransmit;
Var
    pDS : CMessageData;
begin
   {TraceL(4, 0,'(__)CL4MD::>SS301:  : Окончание опроса Энергосбытом. Основной опрос запущен');   }
   m_nRepTimer.OffTimer;
   m_sIsTranzOpen.m_sbIsTrasnBeg := false;
   m_nCF.SchedGo;
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
end;

function  CACC301Module.FindPortID(phAddr : byte) : byte;
var i : integer;
begin
   Result := 0;
   for i := 0 to PhAddrAndComPrt.Count - 1 do
     if PhAddrAndComPrt.Items[i].m_swPHAddres = phAddr then
       Result := PhAddrAndComPrt.Items[i].m_swPortID;
end;

procedure CACC301Module.CreateMSGHead(var pMsg:CMessage; Size, PhAddr:byte);
begin
   pMsg.m_swLen       := Size;
   pMsg.m_swObjID     := m_sbyID;             //Сетевой адрес счётчика
   pMsg.m_sbyFrom     := DIR_L2TOL1;
   pMsg.m_sbyFor      := DIR_L2TOL1;         //DIR_L2toL1
   pMsg.m_sbyType     := PH_DATARD_REQ;      //PH_DATARD_REC
   pMsg.m_sbyIntID    := FindPortID(PhAddr);
   pMsg.m_sbyServerID := MET_SS301F3;          //Указать тип счетчика
   pMsg.m_sbyDirID    := FindPortID(PhAddr);
end;

procedure CACC301Module.CreateOutMsgHead(var pMsg : CMessage; Size : word);
begin
   pMsg.m_swLen       := Size;
   pMsg.m_swObjID     := m_sbyPortID;        //Сетевой адрес счётчика
   pMsg.m_sbyFrom     := DIR_L2TOL1;
   pMsg.m_sbyFor      := DIR_L2TOL1;         //DIR_L2toL1
   pMsg.m_sbyType     := PH_DATARD_REQ;      //PH_DATARD_REC
   pMsg.m_sbyIntID    := m_sbyPortID;
   pMsg.m_sbyServerID := MET_SS301F3;          //Указать тип счетчика
   pMsg.m_sbyDirID    := m_sbyPortID;
   pMsg.m_sbyIntID    := m_sbyPortID;
end;

procedure CACC301Module.SendMSGToL1();
begin
   move(buf[8], m_nTxMsg.m_sbyInfo[0], 6);
   CRC(m_nTxMsg.m_sbyInfo[0], 6);
   CreateMSGHead(m_nTxMsg, 11 + 6 + 2, m_nTxMsg.m_sbyInfo[0]);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure CACC301Module.InitAuto(var pTable : SL1TAG);
var Meters : SL2INITITAG;
    i      : integer;
Begin
   m_sIsTranzOpen.m_sbIsTrasnBeg := false;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
   if m_pDB.GetMetersIniTable(Meters) then
   begin
     PhAddrAndComPrt.Count := Meters.m_swAmMeter;
     SetLength(PhAddrAndComPrt.Items, Meters.m_swAmMeter);
     for i := 0 to Meters.m_swAmMeter - 1 do
     begin
       PhAddrAndComPrt.Items[i].m_swPHAddres := StrToInt(Meters.m_sMeter[i].m_sddPHAddres);
       PhAddrAndComPrt.Items[i].m_swPortID   := Meters.m_sMeter[i].m_sbyPortID;
     end;
   end;
End;

function CACC301Module.SelfHandler(var pMsg : CMessage):Boolean;
Var
   res : Boolean;
Begin
   res := True;
   if pMsg.m_sbyType=AL_REPMSG_TMR then
   begin
     //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Нет ответа от счетчика', @pMsg);
     ErrorReciveMSGFromMeter(100, 0);
   end;
   Result := res;
End;

function CACC301Module.LoHandler(var pMsg : CMessage):Boolean;
var
   res : boolean;
Begin
   res := True;
   if pMsg.m_swLen <= 11 then //Нулевое сообщение
     exit;
   //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>SS301:',@pMsg);
   if m_nTxMsg.m_sbyInfo[2] <> pMsg.m_sbyInfo[2] then
     exit;                   //Принят не запрашиваемый параметр
   if CRC(pMsg.m_sbyInfo[0], pMsg.m_swLen - 11 - 2) <> true then
   begin
     //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>SS301: Ошибка контрольной суммы',@pMsg);
     ErrorReciveMSGFromMeter(101, 0);
     exit;
   end;
   if buf[9] <> 7 then
     CreateOutMsg(pMsg)
   else
     if buf[10] = 1 then
       CreateOutMsgPar7_1(pMsg)
     else
       CreateOutMsgPar7_2(pMsg);
   Result := res;
End;

function CACC301Module.HiHandler(var pMsg : CMessage):Boolean;
Var
   res          : Boolean;
   LengthMSG    : word;
   fnc, par     : byte;
Begin
    res := True;
    if pMsg.m_sbyType = AL_STOPL2_IND then
    begin
      if not m_sIsTranzOpen.m_sbIsTrasnBeg then
        exit;
      fnc := buf[9];
      par := buf[10];
      if fnc = 7 then
        case par of
          1 : begin CreateMSG7_1Beg; CreateReq7(13, 0); end;
          2 : begin CreateMSG7_2Beg; CreateReq7(14 + buf[11] - 1, -1); end;
        end
      else begin SendMSGToL1() end;
        exit;
    end;

    if pMsg.m_swLen <= 11 then //Нулевое сообщение
      exit;
    TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>CC301:', @pMsg);
    move(pMsg.m_sbyInfo[2], LengthMSG, 2);
    move(pMsg.m_sbyInfo[0], buf[0], 14);
    if CRC(pMsg.m_sbyInfo[0], LengthMSG - 2) <> true then
    begin
      //TraceL(4,pMsg.m_swObjID,'(__)CL4MD::>CC301  CRC Error!!!');
      exit;
    end;
    StartTransmit;
    Result := res;
End;

procedure CACC301Module.RunAuto;
Begin

End;

function CACC301Module.CRC(var buf : array of byte; cnt : integer):boolean;
var
    CRChiEl             : byte;
    CRCloEl             : byte;
    i                   : integer;
    idx                 : byte;
begin
    Result  := true;
    CRChiEl := $FF;
    CRCloEl := $FF;
    for i:=0 to cnt - 1 do
    begin
     idx       := (CRChiEl Xor buf[i]) And $FF;
     CRChiEl   := (CRCloEl Xor CRCHI[idx]);
     CRCloEl   := CRCLO[idx];
    end;
    if (CRCloEl <> buf[cnt]) and (CRChiEl <> buf[cnt+1]) then
      Result := false;
    buf[cnt]    := CRCloEl;
    buf[cnt+1]  := CRChiEl;
end;

end.

