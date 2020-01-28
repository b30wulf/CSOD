unit knsl2ce6850meter;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer;
type
    CTempData = record
      byDay       : byte;
      byMonth     : byte;
      byYear      : byte;
      byHour      : byte;
      byMin       : byte;
      bySec       : byte;
      byPDMON     : byte; //Значение указателя текущего месяца
      byPDDAY     : byte; //Значение указателя текущего дня
      byPDGRA     : byte; //Значение указателя на текущий график мощности
      byDirectNow : byte; //подкоманда
    end;

    CCE6850Meter = class(CMeter)
    Private
     TempData     : CTempData;
     State        : byte;
     ReadParamID  : byte;
     procedure SetCurrQry;
     procedure SetGraphQry;
     //procedure SetHandScenarioCurr;
     //procedure SetHandScenarioGraph;
     procedure RunMeter;override;
     procedure InitMeter(var pL2:SL2TAG);override;
     procedure CreateAskAdrReqMSG;
     procedure CreateAskIndReqMSG;
     procedure CreateAskSetReqMSG;
     procedure CreateAskDataReqMSG;
     procedure CreateSymEnergReqMSG;
     procedure Create30MinPowerReqMSG;
     procedure CreateAktPowerReqMSG;
     procedure CreateReaktPowerReqMSG;
     procedure CreateVoltageReqMSG;
     procedure CreateCurrReqMSG;
     procedure CreateFreqReqMSG;
     procedure CreateDateTimeReqMSG;
     procedure CreateEnergSrezReqMsg;
     procedure CreateDayEnergReqMSG;
     procedure CreateMonthEnergReqMSG;
     procedure MSGHeadAndPUT(var pMsg:CHMessage; Size:byte);
     procedure CreateMSG(com:string; size:byte);
     procedure CreateMSGWithCommand(com1 : string; com2:string; size : byte);
     procedure CreateOutputMSG(paramNo : integer; Param:single; tarif : byte);
     procedure KorrectionDate();
     procedure KorrectionTime();
     function  IntToStrWith0(ch : byte) : string;
     function  SelfHandler(var pMsg:CMessage):Boolean;override;
     function  LoHandler(var pMsg:CMessage):Boolean;override;
     function  HiHandler(var pMsg:CMessage):Boolean;override;
     function  CalculateCRC(var data : array of byte; count : byte):byte;
     function  ReadAnsAdr(var pMsg:CMessage):boolean;
     function  ReadAnsInd(var pMsg:CMessage):boolean;
     function  ReadAnsSet(var pMsg:CMessage):boolean;
     function  ReadAnsData(var pMsg:CMessage):byte;
     function  ReadSymEnerg(var pMsg:CMessage):byte;
     function  Read30MinPower(var pMsg:CMessage):byte;
     function  ReadAktPower(var pMsg:CMessage):byte;
     function  ReadReaktPower(var pMsg:CMessage):byte;
     function  ReadVoltage(var pMsg:CMessage):byte;
     function  ReadCurr(var pMsg:CMessage):byte;
     function  ReadFreq(var pMsg:CMessage):byte;
     function  ReadDateTime(var pMsg:CMessage):byte;
     function  ReadEnergSrez(var pMsg:CMessage):byte;
     function  ReadDayEnerg(var pMsg:CMessage):byte;
     function  ReadMonthEnerg(var pMsg:CMessage):byte;
     function  FindAndReadData(substr:string; var str:string; var Flag : boolean):single;
     function  FindAndReadDate(var str:string; var Flag:boolean):TDateTime;
     function  FindAndReadTime(var str:string; var Flag:boolean):TDateTime;
     constructor Create;
    End;

const ST_NULL           = 0;
      ST_WAIT_ASK_ADR   = 1;
      ST_IND            = 2;
      ST_WAIT_ASK_IND   = 3;
      ST_SET            = 4;
      ST_WAIT_ASK_SET   = 5;
      ST_DATA           = 6;
      ST_WAIT_ASK_DATA  = 7;

const SOH               = $01;
      STX               = $02;
      ETX               = $03;
      EOT               = $04;
      ACK               = $06;
      NAK               = $15;
      CR                = $0D;
      LF                = $0A;
      R1                = 'R1';
implementation

procedure CCE6850Meter.KorrectionDate();
var str                     : string;
Year, Month, Day, DayNumber : word;
begin
    str := '(';
    str := str + m_nP.m_sddPHAddres;
    str := str + ')';
    CreateMsgWithCommand('P0', str, Length(str));
    Sleep(250);
    str := '(';
    str := str + m_nP.m_schPassword;
    str := str + ')';
    CreateMsgWithCommand('P1', str, Length(str));
    Sleep(250);
    str := str + 'DATE_(';
    DecodeDate(Now, Year, Month, Day);
    DayNumber := DayOfWeek(Now);
    Dec(DayNumber);
    Year := Year - 2000;
    str := str + IntToStrWith0(DayNumber)+'.';
    str := str + IntToStrWith0(Day) + '.';
    str := Str + intToStrWith0(Month) + '.';
    str := str + intToStrWith0(Year) + ')';
    CreateMSGWithCommand('W1', str, Length(str));
    Sleep(100);
end;

procedure CCE6850Meter.KorrectionTime();
var Hour, Min, Sec, MS : word;
str                    : string;
begin
    str := '(';
    str := str + m_nP.m_sddPHAddres;
    str := str + ')';
    CreateMsgWithCommand('P0', str, Length(str));
    Sleep(250);
    str := '(';
    str := str + m_nP.m_schPassword;
    str := str + ')';
    CreateMsgWithCommand('P1', str, Length(str));
    Sleep(250);
    DecodeTime(Now, Hour, Min, Sec, MS);
    str := 'TIME_(';
    str := str + IntToStrWith0(hour) + ':';
    str := str + IntToStrWith0(min) + ':';
    str := str + IntToStrWith0(sec) + ')';
    CreateMSGWithCommand('W1', str, Length(str));
    Sleep(100);
end;

function  CCE6850Meter.IntToStrWith0(ch : byte) : string;
begin
    if ch >= 10  then
      Result := IntToStr(ch)
    else
      Result := '0' + IntToStr(ch);
end;

function CCE6850Meter.CalculateCRC(var data : array of byte; count : byte):byte;
var i, crc : byte;
begin
    crc := 0;
    for i := 0 to count-1 do
      crc := crc + data[i];
    Result := crc and $7F;
end;

procedure CCE6850Meter.MSGHeadAndPUT(var pMsg:CHMessage; Size : byte);
begin
    pMsg.m_swLen        := Size + 11;
    pMsg.m_swObjID      := m_nP.m_swMID;       //Сетевой адрес счётчика
    pMsg.m_sbyFrom      := DIR_L2TOL1;
    pMsg.m_sbyFor       := DIR_L2TOL1;    //DIR_L2toL1
    pMsg.m_sbyType      := PH_DATARD_REQ; //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID := DEV_COM;       //DEF_COM
    pMsg.m_sbyIntID     := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID  := MET_CE6850;     //Указать тип счетчика
    pMsg.m_sbyDirID     := m_nP.m_sbyPortID;
    FPUT(BOX_L1, @pMsg);
end;

procedure CCE6850Meter.CreateOutputMSG(paramNo : integer; Param:single; tarif : byte);
var
    Hour, Min, Sec, mSec   : word;
    Year, Month, Day       : word;
begin
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    m_nRxMsg.m_swLen      := 13+11;
    m_nRxMsg.m_sbyInfo[0] := 13;
    m_nRxMsg.m_sbyInfo[1] := paramNo;
    m_nRxMsg.m_sbyInfo[2] := Year;
    m_nRxMsg.m_sbyInfo[3] := Month;
    m_nRxMsg.m_sbyInfo[4] := Day;
    m_nRxMsg.m_sbyInfo[5] := Hour;
    m_nRxMsg.m_sbyInfo[6] := Min;
    m_nRxMsg.m_sbyInfo[7] := Sec;
    m_nRxMsg.m_sbyInfo[8] := tarif;
    move(param, m_nRxMsg.m_sbyInfo[9], 4);
    m_nRxMsg.m_swLen      := 11 + m_nRxMsg.m_sbyInfo[0];
end;

function  CCE6850Meter.FindAndReadData(substr:string; var str:string; var Flag:boolean):single;
var pos1, pos2 : integer;
ReadValue : string;
begin
    Flag := true;
    pos1 := Pos(substr, str);
    if pos1 = 0 then
    begin
      Flag := false;
      exit;
    end;
    pos2 := Pos(')', str);
    if pos2 = 0 then
    begin
      Flag := false;
      exit;
    end;
    ReadValue := copy(str, pos1 + length(substr), pos2 - pos1 - length(substr));
    Delete(str, pos1, pos2 - pos1 + 1);
    try
      Result    := StrToFloat(ReadValue);
    except
      Result    := 0;
      Flag      := false;
    end;
end;

function  CCE6850Meter.FindAndReadDate(var str:string; var Flag:boolean):TDateTime;
var pos1, pos2    : integer;
ReadValue         : string;
Day , Year, Month : word;
begin
    Flag := true;
    pos1 := Pos('DATE_(', str);
    if pos1 = 0 then
    begin
      Flag := false;
      exit;
    end;
    pos2 := Pos(')', str);
    if pos2 = 0 then
    begin
      Flag := false;
      exit;
    end;
    try
      ReadValue := copy(str, pos1 + length('_DATE('), pos2 - pos1 - length('DATE('));
      Day       := StrToIntDef(ReadValue[4], 0)*10 + StrToIntDef(ReadValue[5],0);
      Month     := StrToIntDef(ReadValue[7], 0)*10 + StrToIntDef(ReadValue[8],0);
      Year      := StrToIntDef(ReadValue[10], 0)*10 + StrToIntDef(ReadValue[11],0);
      Delete(str, pos1, pos2 - pos1 + 1);
      Result    := EncodeDate(Year, Month, Day);
    except
      Result    := 0;
      Flag      := false;
    end;
end;

function  CCE6850Meter.FindAndReadTime(var str:string; var Flag:boolean):TDateTime;
var pos1, pos2    : integer;
ReadValue         : string;
Day , Year, Month : word;
begin
    Flag := true;
    pos1 := Pos('TIME_(', str);
    if pos1 = 0 then
    begin
      Flag := false;
      exit;
    end;
    pos2 := Pos(')', str);
    if pos2 = 0 then
    begin
      Flag := false;
      exit;
    end;
    ReadValue := copy(str, pos1 + length('TIME_('), pos2 - pos1 - length('TIME_('));
    Delete(str, pos1, pos2 - pos1 + 1);
    try
      Result    := StrToTime(ReadValue);
    except
      Result    := 0;
      Flag      := false;
    end;
end;

function  CCE6850Meter.ReadSymEnerg(var pMsg:CMessage):byte;
var FlagRead : boolean; // Если есть данные true иначе false
param        : TDateTime;
str          : string;
i            : byte;
begin
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen-11);
    i := 0;
    case TempData.byDirectNow of
      0:
        begin
          param  := FindAndReadData('ET0PE(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          while FlagRead do
          begin
            if (i>=1) and (i<=4) then
              CreateOutputMSG(QRY_ENERGY_SUM_EP, param, i);
            saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
            param := FindAndReadData('ET0PE(', str, FlagRead);
            i := i + 1;
          end;
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      1:
        begin
          param  := FindAndReadData('ET0PI(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          while FlagRead do
          begin
            if (i>=1) and (i<=4) then
              CreateOutputMSG(QRY_ENERGY_SUM_EM, param, i);
            saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
            param := FindAndReadData('ET0PI(', str, FlagRead);
            i := i + 1;
          end;
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      2:
        begin
          param  := FindAndReadData('ET0QE(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          while FlagRead do
          begin
            if (i>=1) and (i<=4) then
              CreateOutputMSG(QRY_ENERGY_SUM_RP, param, i);
            saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
            param := FindAndReadData('ET0QE(', str, FlagRead);
            i := i + 1;
          end;
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      3:
        begin
          param  := FindAndReadData('ET0QI(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          while FlagRead do
          begin
            if (i>=1) and (i<=4) then
              CreateOutputMSG(QRY_ENERGY_SUM_RM, param, i);
            saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
            param := FindAndReadData('ET0QI(', str, FlagRead);
            i := i + 1;
          end;
          TempData.byDirectNow := 0;
          Result := 0;
          SendSyncEvent;
        end;
    end;
end;

function  CCE6850Meter.Read30MinPower(var pMsg:CMessage):byte;
var FlagRead : boolean; // Если есть данные true иначе false
param        : TDateTime;
str          : string;
i            : byte;
begin
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen-11);
    i := 0;
    case TempData.byDirectNow of
      0:
        begin
          param := FindAndReadData('PDGRA(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          TempData.byPDGRA := trunc(param);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      1:
        begin
          param := FindAndReadData('GRAPE(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_E30MIN_POW_EP, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      2:
        begin
          param := FindAndReadData('GRAPI(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_E30MIN_POW_EM, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      3:
        begin
          param := FindAndReadData('GRAQE(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_E30MIN_POW_RP, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      4:
        begin
          param := FindAndReadData('GRAQI(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_E30MIN_POW_RM, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Result := 0;
          SendSyncEvent;
        end;
    end;
end;

function  CCE6850Meter.ReadAktPower(var pMsg:CMessage):byte;
var FlagRead : boolean; // Если есть данные true иначе false
param        : single;
str          : string;
i            : byte;
begin
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen-11);
    param  := FindAndReadData('POWEP(', str, FlagRead);
    i      := 0;
    if not FlagRead then
    begin
      Result := 2;
      exit;
    end;
    while FlagRead do
    begin
      if i <> 3 then
        CreateOutputMSG(QRY_MGAKT_POW_S + i + 1, param, 0)
      else
        CreateOutputMSG(QRY_MGAKT_POW_S, param, 0);
      saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
      param := FindAndReadData('POWEP(', str, FlagRead);
      i:=i+1;
    end;
    if i = 4 then
    begin
      Result := 0;
      SendSyncEvent;
    end
    else
      Result := 2;
end;

function  CCE6850Meter.ReadReaktPower(var pMsg:CMessage):byte;
var FlagRead : boolean; // Если есть данные true иначе false
param        : single;
str          : string;
i            : byte;
begin
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen-11);
    param  := FindAndReadData('POWEQ(', str, FlagRead);
    i      := 0;
    if not FlagRead then
    begin
      Result := 2;
      exit;
    end;
    while FlagRead do
    begin
      if i <> 3 then
        CreateOutputMSG(QRY_MGREA_POW_S + i + 1, param, 0)
      else
        CreateOutputMSG(QRY_MGREA_POW_S, param, 0);
      saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
      param := FindAndReadData('POWEQ(', str, FlagRead);
      i:=i+1;
    end;
    if i = 4 then
    begin
      Result := 0;
      SendSyncEvent;
    end
    else
      Result := 2;
end;

function  CCE6850Meter.ReadVoltage(var pMsg:CMessage):byte;
var FlagRead : boolean; // Если есть данные true иначе false
param        : single;
str          : string;
i            : byte;
begin
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen-11);
    param  := FindAndReadData('VOLTA(', str, FlagRead);
    i      := 0;
    if not FlagRead then
    begin
      Result := 2;
      exit;
    end;
    while FlagRead do
    begin
      CreateOutputMSG(QRY_U_PARAM_A + i, param, 0);
      saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
      param := FindAndReadData('VOLTA(', str, FlagRead);
      i:=i+1;
    end;
    if i = 3 then
    begin
      Result := 0;
      SendSyncEvent;
    end
    else
      Result := 2;
end;

function  CCE6850Meter.ReadCurr(var pMsg:CMessage):byte;
var FlagRead : boolean; // Если есть данные true иначе false
param        : single;
str          : string;
i            : byte;
begin
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen-11);
    param  := FindAndReadData('CURRE(', str, FlagRead);
    i      := 0;
    if not FlagRead then
    begin
      Result := 2;
      exit;
    end;
    while FlagRead do
    begin
      CreateOutputMSG(QRY_I_PARAM_A + i, param, 0);
      saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
      param := FindAndReadData('CURRE(', str, FlagRead);
      i:=i+1;
    end;
    if i = 3 then
    begin
      Result := 0;
      SendSyncEvent;
    end
    else
      Result := 2;
end;

function  CCE6850Meter.ReadFreq(var pMsg:CMessage):byte;
var FlagRead : boolean; // Если есть данные true иначе false
param        : single;
str          : string;
begin
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen-11);
    param  := FindAndReadData('FREQU(', str, FlagRead);
    if not FlagRead then
    begin
      Result := 2;
      exit;
    end;
    CreateOutputMSG(QRY_FREQ_NET, param, 0);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
    SendSyncEvent;
    Result := 0;
end;

function  CCE6850Meter.ReadDateTime(var pMsg:CMessage):byte;
var FlagRead : boolean; // Если есть данные true иначе false
param        : TDateTime;
str          : string;
h, m, s, ms  : word;
y, mn, d     : word;
hNow, mNow, sNow, msNow : word;
yNow, mnNow, dNow        : word;
begin
    DecodeTime(Now, hNow, mNow, sNow, msNow);
    DecodeDate(Now, yNow, mnNow, dNow);
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen-11);
    case TempData.byDirectNow of
      0: //Обработка времени
        begin
          param := FindAndReadTime(str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          DecodeTime(param, h, m, s, ms);
          TempData.bySec := s;
          TempData.byMin := m;
          TempData.byHour:= h;
          if (hNow <> h) or (mNow <> m) or (abs(sNow - s) >=5) then
            KorrectionTime;
          Result         := 1;
          Inc(TempData.byDirectNow);
          exit;
        end;
      1: //Обработка даты
        begin
          param := FindAndReadDate(str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          DecodeDate(param, y, mn, d);
          y := y - 2000;
          if (y <> yNow) or (mn <> mnNow) or (d <> dNow) then
            KorrectionDate;
          m_nRxMsg.m_sbyInfo[0] := 8;
          m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
          m_nRxMsg.m_sbyInfo[2] := y;
          m_nRxMsg.m_sbyInfo[3] := mn;
          m_nRxMsg.m_sbyInfo[4] := d;
          m_nRxMsg.m_sbyInfo[5] := TempData.byHour;
          m_nRxMsg.m_sbyInfo[6] := TempData.byMin;
          m_nRxMsg.m_sbyInfo[7] := TempData.bySec;
          m_nRxMsg.m_swLen      := 11 + m_nRxMsg.m_sbyInfo[0];
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          SendSyncEvent;
          Result := 0;
          TempData.byDirectNow := 0;
        end;
    end;
end;

function  CCE6850Meter.ReadEnergSrez(var pMsg:CMessage):byte;
var FlagRead : boolean; // Если есть данные true иначе false
param        : single;
str          : string;
i            : byte;
begin
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen-11);
    param  := FindAndReadData('ENAVE(', str, FlagRead);
    i      := 0;
    if not FlagRead then
    begin
      Result := 2;
      exit;
    end;
    while FlagRead do
    begin
      CreateOutputMSG(QRY_SRES_ENR_EP + i, param, 0);
      saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
      param := FindAndReadData('ENAVE(', str, FlagRead);
      i:=i+1;
    end;
    if i = 4 then
    begin
      Result := 0;
      SendSyncEvent;
    end
    else
      Result := 2;
end;

function  CCE6850Meter.ReadDayEnerg(var pMsg:CMessage):byte;
var FlagRead : boolean; // Если есть данные true иначе false
param        : TDateTime;
str          : string;
i            : byte;
begin
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen-11);
    i := 0;
    case TempData.byDirectNow of
      0:
        begin
          param := FindAndReadData('PDDAY(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          TempData.byPDDAY := trunc(param);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      1:
        begin
          param := FindAndReadData('ED'+IntToStr(TempData.byPDDAY)+'PE(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_NAK_EN_DAY_EP, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      2:
        begin
          param := FindAndReadData('ED'+IntToStr(TempData.byPDDAY)+'PI(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_NAK_EN_DAY_EM, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      3:
        begin
          param := FindAndReadData('ED'+IntToStr(TempData.byPDDAY)+'QE(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_NAK_EN_DAY_RP, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      4:
        begin
          param := FindAndReadData('ED'+IntToStr(TempData.byPDDAY)+'QI(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_NAK_EN_DAY_RP, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Result := 0;
          SendSyncEvent;
        end;
    end;
end;

function  CCE6850Meter.ReadMonthEnerg(var pMsg:CMessage):byte;
var FlagRead : boolean; // Если есть данные true иначе false
param        : TDateTime;
str          : string;
i            : byte;
begin
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen-11);
    i := 0;
    case TempData.byDirectNow of
      0:
        begin
          param := FindAndReadData('PDMON(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          TempData.byPDMON := trunc(param);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      1:
        begin
          param := FindAndReadData('EM'+IntToStr(TempData.byPDMON)+'PE(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_NAK_EN_MONTH_EP, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      2:
        begin
          param := FindAndReadData('EM'+IntToStr(TempData.byPDMON)+'PI(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_NAK_EN_MONTH_EM, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      3:
        begin
          param := FindAndReadData('EM'+IntToStr(TempData.byPDMON)+'QE(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_NAK_EN_MONTH_RP, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Inc(TempData.byDirectNow);
          Result := 1;
        end;
      4:
        begin
          param := FindAndReadData('EM'+IntToStr(TempData.byPDMON)+'QI(', str, FlagRead);
          if not FlagRead then
          begin
            Result := 2;
            exit;
          end;
          CreateOutputMSG(QRY_NAK_EN_MONTH_RP, param, 0);
          saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
          Result := 0;
          SendSyncEvent;
        end;
    end;
end;

function  CCE6850Meter.ReadAnsAdr(var pMsg:CMessage):boolean;
var str : string;
begin
    SetLength(str, pMsg.m_swLen - 11);
    move(pMsg.m_sbyInfo[0], str[1], pMsg.m_swLen - 11);

    if StrPos(PChar(str), PChar('CE6850')) = nil then
    begin //Если в принятом пакете нету строки CE6850 то ошибка
      Result := false;
      exit;
    end;
    State := ST_SET;
    CreateAskSetReqMSG;
    Result := true;
end;

function  CCE6850Meter.ReadAnsInd(var pMsg:CMessage):boolean;
begin  //Формируется только при изменении параметров
    Result := true;
end;

function  CCE6850Meter.ReadAnsSet(var pMsg:CMessage):boolean;
begin
    State  := ST_DATA;
    CreateAskDataReqMSG();
    Result := true;
end;

function  CCE6850Meter.ReadAnsData(var pMsg:CMessage):byte;
begin
//Если Result = 0 то переходим на новую группу параметров
//Если Result = 1 то читаем новый параметр данных
//Усли Result = 2 то в струтуре принятых данных есть ошибка
    Result := 0;
    //Здесь обрабытваются принятые данные
    case ReadParamID of
      QRY_ENERGY_SUM_EP  : Result := ReadSymEnerg(pMsg);    //  +общая накопленная энергия
      QRY_E30MIN_POW_EP  : Result := Read30MinPower(pMsg);  //  +срезы мощностей
      QRY_MGAKT_POW_S    : Result := ReadAktPower(pMsg);    //  +активная мгновенная мощность
      QRY_MGREA_POW_S    : Result := ReadReaktPower(pMsg);  //  +реактивная мгновенная мощность
      QRY_U_PARAM_A      : Result := ReadVoltage(pMsg);     //  +напряжение
      QRY_I_PARAM_A      : Result := ReadCurr(pMsg);        //  +ток
      QRY_FREQ_NET       : Result := ReadFreq(pMsg);        //  +частота сети
      QRY_DATA_TIME      : Result := ReadDateTime(pMsg);    //  +время и дата
      QRY_SRES_ENR_EP    : Result := ReadEnergSrez(pMsg);   //  +последний срез энергии
      QRY_NAK_EN_DAY_EP  : Result := ReadDayEnerg(pMsg);    //  +накопленная энергия за пред сутки
      QRY_NAK_EN_MONTH_EP: Result := ReadMonthEnerg(pMsg);  //  +на начало месяца
    end;
    //--------------------------------
    case Result of
      0: State := ST_DATA;
      1: begin CreateAskDataReqMSG(); m_nRepTimer.OnTimer(m_nP.m_swRepTime); end;
    end;
end;

procedure CCE6850Meter.CreateMSGWithCommand(com1 : string; com2:string; size : byte);
begin
    m_nTxMsg.m_sbyInfo[0]  := SOH;
    move(R1, m_nTxMsg.m_sbyInfo[1], 2);
    m_nTxMsg.m_sbyInfo[3]  := STX;
    move(com1[1], m_nTxMsg.m_sbyInfo[4], 2);
    move(com2[1], m_nTxMsg.m_sbyInfo[6], size);
    m_nTxMsg.m_sbyInfo[6+size] := ETX;
    m_nTxMsg.m_sbyInfo[7+size] := CalculateCRC(m_nTxMsg.m_sbyInfo[1], 6 + size);
    MSGHeadAndPUT(m_nTxMsg, 7 + size);
end;

procedure CCE6850Meter.CreateMSG(com:string; size:byte);
begin      //Созжает сообщение по пост команде и ложит в ящик на 1 level
    m_nTxMsg.m_sbyInfo[0]  := SOH;
    move(R1, m_nTxMsg.m_sbyInfo[1], 2);
    m_nTxMsg.m_sbyInfo[3]  := STX;
    move(com[1], m_nTxMsg.m_sbyInfo[4], size);
    m_nTxMsg.m_sbyInfo[4+size] := ETX;
    m_nTxMsg.m_sbyInfo[5+size] := CalculateCRC(m_nTxMsg.m_sbyInfo[1], 4 + size);
    MSGHeadAndPUT(m_nTxMsg, 6+size);
end;

procedure CCE6850Meter.CreateSymEnergReqMSG();
begin
    case TempData.byDirectNow of
      0 : CreateMSG('ET0PE()',7);
      1 : CreateMSG('ET0PI()',7);
      2 : CreateMSG('ET0QE()',7);
      3 : CreateMSG('ET0QI()',7);
    end;
end;

procedure CCE6850Meter.Create30MinPowerReqMSG();
var Date : string;
str      : string[5];
begin
    if TempData.byPDGRA = 0 then
      TempData.byPDGRA := 1;
    str  := IntToStr(TempData.byPDGRA);
    while (Length(str) <> 4) do
      Insert('0', str, 1);
    Date := DateToStr(Now);
    SetLength(Date,  6);
    case TempData.byDirectNow of
      0 : CreateMSG('PDGRA()',7);
      1 : CreateMSG('GRAPE('+Date+str+')', 17);
      2 : CreateMSG('GRAPI('+Date+str+')', 17);
      3 : CreateMSG('GRAQE('+Date+str+')', 17);
      4 : CreateMSG('GRAQI('+Date+str+')', 17);
    end;

end;

procedure CCE6850Meter.CreateAktPowerReqMSG();
begin
    CreateMSG('POWEP()', 7);
end;

procedure CCE6850Meter.CreateReaktPowerReqMSG();
begin
    CreateMSG('POWEQ()', 7);
end;

procedure CCE6850Meter.CreateVoltageReqMSG();
begin
    CreateMSG('VOLTA()', 7);
end;

procedure CCE6850Meter.CreateCurrReqMSG();
begin
    CreateMSG('CURRE()', 7);
end;

procedure CCE6850Meter.CreateFreqReqMSG();
begin
    CreateMSG('FREQU()', 7);
end;

procedure CCE6850Meter.CreateDateTimeReqMSG();
begin
    case TempData.byDirectNow of
      0: CreateMSG('TIME_()', 7); //Запрос на время
      1: CreateMSG('DATE_()', 7); //Запрос на дату
    end;
end;

procedure CCE6850Meter.CreateEnergSrezReqMsg();
begin
    CreateMSG('ENAVE()', 7);
end;

procedure CCE6850Meter.CreateDayEnergReqMSG();
begin
    if (TempData.byPDDAY = 0) then
      TempData.byPDDAY := 3
    else
      TempData.byPDDAY:=TempData.byPDDAY - 1;
    case TempData.byDirectNow of
      0: CreateMSG('PDDAY()', 7);
      1: CreateMSG('ED'+IntToStr(TempData.byPDDAY)+'PE()', 7);
      2: CreateMSG('ED'+IntToStr(TempData.byPDDAY)+'PI()', 7);
      3: CreateMSG('ED'+IntToStr(TempData.byPDDAY)+'QE()', 7);
      4: CreateMSG('ED'+IntToStr(TempData.byPDDAY)+'QI()', 7);
    end;
end;

procedure CCE6850Meter.CreateMonthEnergReqMSG();
begin
   if (TempData.byPDMON = 0) then
      TempData.byPDMON := 3
    else
      TempData.byPDMON:=TempData.byPDMON - 1;
    case TempData.byDirectNow of
      0: CreateMSG('PDMON()', 7);
      1: CreateMSG('EM'+IntToStr(TempData.byPDMON)+'PE()', 7);
      2: CreateMSG('EM'+IntToStr(TempData.byPDMON)+'PI()', 7);
      3: CreateMSG('EM'+IntToStr(TempData.byPDMON)+'QE()', 7);
      4: CreateMSG('EM'+IntToStr(TempData.byPDMON)+'QI()', 7);
    end;
end;

procedure CCE6850Meter.CreateAskAdrReqMSG;
var LengthPA : byte;
begin
    State := ST_WAIT_ASK_ADR;
    m_nTxMsg.m_sbyInfo[0]          := $2F; //  /
    m_nTxMsg.m_sbyInfo[1]          := $3F; //  ?
    LengthPA                       := Length(m_nP.m_sddPHAddres);
    move(m_nP.m_sddPHAddres[1], m_nTxMsg.m_sbyInfo[2], LengthPA);
    m_nTxMsg.m_sbyInfo[2+LengthPA] := $21; //  !
    m_nTxMsg.m_sbyInfo[3+LengthPA] := CR;
    m_nTxMsg.m_sbyInfo[4+LengthPA] := LF;
    MSGHeadAndPut(m_nTxMsg, 5 + LengthPA);
end;

procedure CCE6850Meter.CreateAskIndReqMSG;
begin  //Формируется только при изменении параметров
    State := ST_WAIT_ASK_IND;
end;

procedure CCE6850Meter.CreateAskSetReqMSG;
begin
    State := ST_WAIT_ASK_SET;
    m_nTxMsg.m_sbyInfo[0] := ACK;
    m_nTxMsg.m_sbyInfo[1] := $30;
    m_nTxMsg.m_sbyInfo[2] := $35;
    m_nTxMsg.m_sbyInfo[3] := $31;
    m_nTxMsg.m_sbyInfo[4] := CR;
    m_nTxMsg.m_sbyInfo[5] := LF;
    MSGHeadAndPut(m_nTxMsg, 6);
end;
procedure CCE6850Meter.CreateAskDataReqMSG;
begin
    State := ST_WAIT_ASK_DATA;
    case ReadParamID of
      QRY_ENERGY_SUM_EP  : CreateSymEnergReqMSG();
      QRY_E30MIN_POW_EP  : Create30MinPowerReqMSG();
      QRY_MGAKT_POW_S    : CreateAktPowerReqMSG();
      QRY_MGREA_POW_S    : CreateReaktPowerReqMSG();
      QRY_U_PARAM_A      : CreateVoltageReqMSG();
      QRY_I_PARAM_A      : CreateCurrReqMSG();
      QRY_FREQ_NET       : CreateFreqReqMSG();
      QRY_DATA_TIME      : CreateDateTimeReqMSG();
      QRY_SRES_ENR_EP    : CreateEnergSrezReqMsg();
      QRY_NAK_EN_DAY_EP  : CreateDayEnergReqMSG();
      QRY_NAK_EN_MONTH_EP: CreateMonthEnergReqMSG();
    end;
end;

constructor CCE6850Meter.Create;
Begin

End;

procedure CCE6850Meter.InitMeter(var pL2:SL2TAG);
Begin
    State                 := ST_NULL;
    TempData.byDirectNow  := 0;
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
End;
{
      QRY_ENERGY_SUM_EP  : CreateSymEnergReqMSG();
      QRY_E30MIN_POW_EP  : Create30MinPowerReqMSG();
      QRY_MGAKT_POW_S    : CreateAktPowerReqMSG();
      QRY_MGREA_POW_S    : CreateReaktPowerReqMSG();
      QRY_U_PARAM_A      : CreateVoltageReqMSG();
      QRY_I_PARAM_A      : CreateCurrReqMSG();
      QRY_FREQ_NET       : CreateFreqReqMSG();
      QRY_DATA_TIME      : CreateDateTimeReqMSG();
      QRY_SRES_ENR_EP    : CreateEnergSrezReqMsg();
      QRY_NAK_EN_DAY_EP  : CreateDayEnergReqMSG();
      QRY_NAK_EN_MONTH_EP: CreateMonthEnergReqMSG();
}
procedure CCE6850Meter.SetCurrQry;
Begin
    with m_nObserver do
    Begin
     ClearCurrQry;
     AddCurrParam(QRY_ENERGY_SUM_EP,0,0,0,1);    //Чтение общей накопленной энергии
     AddCurrParam(QRY_E30MIN_POW_EP,0,0,0,1);    //Чтение графиков мощности
     AddCurrParam(QRY_MGAKT_POW_S,0,0,0,1);      //Активная потребляемая мощность
     AddCurrParam(QRY_MGREA_POW_S,0,0,0,1);      //Реактивная потребляемая мощность
     AddCurrParam(QRY_U_PARAM_A,0,0,0,1);        //Значения напряжений по фазам
     AddCurrParam(QRY_I_PARAM_A,0,0,0,1);        //Значения токов по фазам
     AddCurrParam(QRY_FREQ_NET,0,0,0,1);         //Значения частоты
     AddCurrParam(QRY_DATA_TIME,0,0,0,1);        //Чтение даты и времени
     AddCurrParam(QRY_SRES_ENR_EP,0,0,0,1);      //Срезы энергии
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,0,0,1);    //Накопленная энергия сутки
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,0,0,1);  //Накопленная энергия месяц
    End;
End;

procedure CCE6850Meter.SetGraphQry;
Begin
End;
{
procedure CCE6850Meter.SetHandScenarioCurr;
Var
    pQry   : PCQueryPrimitive;
Begin
    while(m_nObserver.GetCommand(pQry)=True) do
    Begin
     with m_nObserver do Begin
     ClearCurrQry;
     if pQry.m_swParamID<15 then TraceL(2,pQry.m_swMtrID,'(__)CL2MD::>CE6850 CMD INIT:'+IntToStr(pQry.m_swParamID)+':'+chQryType[pQry.m_swParamID]);
     case pQry.m_swParamID of
      EN_QRY_SUM:        //Енергия: суммарная накопленная
      Begin
        AddCurrParam(1,0,0,0,1);
      End;
      EN_QRY_INC_DAY:    //Енергия: Приращение за день
      Begin
      End;
      EN_QRY_INC_MON:    //Енергия: Приращение за месяц
      Begin
      End;
      EN_QRY_SRS_30M:    //Енергия: Cрез 30 мин
      Begin
        AddCurrParam(36,0,0,0,1);
      End;
      EN_QRY_ALL_DAY:    //Енергия: Начало суток
      Begin
        AddCurrParam(42,0,0,0,1);
      End;
      EN_QRY_ALL_MON:    //Енергия: Начало месяца
      Begin
        AddCurrParam(43,0,0,0,1);
      End;
      PW_QRY_SRS_3M:     //Мощность:Срез 3 мин
      Begin
      End;
      PW_QRY_SRS_30M:    //Мощность:Срез 30 мин
      Begin
        AddCurrParam(6,0,0,0,1);
      End;
      PW_QRY_MGACT:      //Мощность:Мгновенная активная
      Begin
        AddCurrParam(8,0,0,0,1);
      End;
      PW_QRY_MGRCT:      //Мощность:Мгновенная реактивная
      Begin
        AddCurrParam(9,0,0,0,1);
      End;
      U_QRY:             //Напряжение
      Begin
        AddCurrParam(10,0,0,0,1);
      End;
      I_QRY:             //Ток
      Begin
        AddCurrParam(11,0,0,0,1);
      End;
      F_QRY:             //Частота
      Begin
        AddCurrParam(13,0,0,0,1);
      End;
      KM_QRY:            //Коэффициент можности
      Begin
      End;
      DATE_QRY:          //Дата-время
      Begin
        AddCurrParam(32,0,0,0,1);
      End;
     End;
     End;//With
    End;
End;
procedure CCE6850Meter.SetHandScenarioGraph;
Begin
End;
}
function CCE6850Meter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res     : Boolean;
    LengthPA : byte;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    State                          := ST_NULL;
    m_nTxMsg.m_sbyInfo[0]          := $2F; //  /
    m_nTxMsg.m_sbyInfo[1]          := $3F; //  ?
    LengthPA                       := Length(m_nP.m_sddPHAddres);
    move(m_nP.m_sddPHAddres[1], m_nTxMsg.m_sbyInfo[2], LengthPA);
    m_nTxMsg.m_sbyInfo[2+LengthPA] := $21; //  !
    m_nTxMsg.m_sbyInfo[3+LengthPA] := CR;
    m_nTxMsg.m_sbyInfo[4+LengthPA] := LF;
    pMsg.m_swLen                   := 5 + LengthPA + 11;
    pMsg.m_swObjID                 := m_nP.m_swMID;
    pMsg.m_sbyFrom                 := DIR_L2TOL1;
    pMsg.m_sbyFor                  := DIR_L2TOL1;
    pMsg.m_sbyType                 := PH_DATARD_REQ;
    //pMsg.m_sbyTypeIntID            := DEV_COM;
    pMsg.m_sbyIntID                := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID             := MET_CE6850;
    Result := res;
End;

function CCE6850Meter.LoHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
        //Переслать в L3 только значение и остановить таймер ожидания подтверждения
        case State of
          ST_WAIT_ASK_ADR  : if ReadAnsAdr(pMsg)  then  m_nRepTimer.OffTimer;
          ST_WAIT_ASK_IND  : if ReadAnsInd(pMsg)  then  m_nRepTimer.OffTimer;
          ST_WAIT_ASK_SET  : if ReadAnsSet(pMsg)  then  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
          ST_WAIT_ASK_DATA : if ReadAnsData(pMsg) = 0 then  m_nRepTimer.OffTimer;
        end;
      End;
    End;
    Result := res;
End;
function CCE6850Meter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
    nReq: CQueryPrimitive;
Begin
    res := False;
    //Обработчик для L3
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
        //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
        case State of
          ST_NULL :
                   begin
                     Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
                     ReadParamID := nReq.m_swParamID;
                     CreateAskAdrReqMSG;
                   end;
          ST_IND  : CreateAskIndReqMSG;  //По ходу не будет исползоваться
          ST_SET  : CreateAskSetReqMSG;  //-----------------------------
          ST_DATA :
                   begin
                     Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
                     ReadParamID := nReq.m_swParamID;
                     CreateAskDataReqMSG;
                   end;
        end;
      End;
    End;
    Result := res;
End;

procedure CCE6850Meter.RunMeter;
Begin
    //m_nRepTimer.RunTimer;
    //m_nObserver.Run;
End;

end.
