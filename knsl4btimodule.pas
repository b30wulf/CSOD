unit knsl4btimodule;

interface
uses
Windows, Classes, SysUtils, SyncObjs, stdctrls, comctrls, utltypes, utlbox, utlconst, utlmtimer, knsl4automodule,
utldatabase, utlTimeDate, MMSystem, knsl5config,knsl3lme,knsl3module,knsl2module,knsl1module,knsl3savetime,knsl3EventBox;
type
    CBTIModule = class(CHIAutomat)
    private
     InnerFunctionPr : integer;
     InnerPDS        : CMessageData;
     procedure SetSpaces(var str : string; lenN, lenK : byte);
    public
     m_nTxMsg            : CMessage;
     USPDType            : SL2USPDTYPEEX;
     USPDDevList         : SL2USPDEVLISTEX;
     USPDCharactDevList  : SL2USPDCHARACTDEVLISTEX;
     USPDCharactKanalList: SL2USPDCHARACTKANALLISTEX;
     PhAddrAndComPrt     : SPHADRANDCOMPRTS;
     m_pDDB              : PCDBDynamicConn;
     byTimeTranz         : byte;
     wTranzPID           : Integer;
     wMeterNum           : WORD;
     dwLastTime          : DWORD;
     blIsInternal        : Boolean;
     blIsFNCFF1C         : Boolean;       
     blIsKTRout          : Byte;
     m_pKTTbl            : SL3GETL2INFOS;
     m_sTblL1            : SL1INITITAG;
     mBlAllowTranz       : boolean;
     procedure FNCTimeNow(var pMsg : CMessage);
     procedure FNCCorTime(var pMsg : CMessage);
     procedure FNCPrirDay(var pMsg : CMessage);
     procedure FNCPrirEnMonth(var pMsg : CMessage);
     procedure FNCEnMonth(var pMsg : CMessage);
     procedure FNCEnDay(var pMsg : CMessage);
     procedure FNC30SrezEnerg(var pMsg : CMessage);
     procedure FNC30SrezEnergDay(var pMsg : CMessage);
     procedure FNCReadJrnl(var pMsg : CMessage);
     procedure FNCReadJrnlEx(var pMsg : CMessage);
     procedure FNCTypeYSPD(var pMsg : CMessage);
     procedure FNCDeviceYSPD(var pMsg : CMessage);
     procedure FNCCharYSPD(var pMsg : CMessage);
     procedure FNCCharYSPDENSB(var pMSg : CMessage);
     procedure FNCCharKanalYSPD(var pMsg : CMessage);
     procedure FNCCharKanalYSPDENSB(var pMSg : CMessage);
     procedure FNCCharGroupYSPD(var pMsg : CMessage);
     procedure FNCReadCurrParam(var pMsg : CMessage);
     procedure FNCMaxDay(var pMsg : CMessage);
     procedure FNCPrirDayGroup(var pMsg : CMessage);
     procedure FNCPrirEnMonthGroup(var pMsg : CMessage);
     procedure FNC30SrezEnergGroup(var pMsg : CMessage);
     procedure FNC30SrezEnergDayGroup(var pMsg : CMessage);
     procedure FNCTranzKanal(var pMsg : CMessage);
     procedure CreateCC301TranzReq(var pMsg : CMessage);
     procedure CreateCloseTranzAns;
     procedure SendMsgToMeter(var pMsg : CMessage);
     procedure SendTranzAns(var pMsg : CMessage);
     procedure SendCC301TranzAsnw(var pMsg : CMessage);
     procedure StartTranz;
     procedure StartTranz301;
     procedure FinishTranz;
     function  FindPortID(wVMID : word) : word;
     procedure FNCCharGroup_TEST(var pMsg : CMessage);
     procedure FNCPrirDayGroup_TEST(var pMsg : CMessage);
     procedure FNCPrirMonthGroup_TEST(var pMsg : CMessage);
     procedure FNCPrir30SrezGroup_TEST(var pMsg : CMessage);
     procedure FNCPrir30SrezDayGroup_TEST(var pMsg : CMessage);
     procedure FNCReadGraphFromMeters(var pMsg : CMessage);
     procedure FNCDelArch(var pMsg : CMessage);
     procedure FNCReadAllCurrParams(var pMsg : CMessage);
     procedure FNCReadMonitorParams(var pMsg : CMessage);
     procedure FNCReadOneSliceEx(var pMsg : CMessage);
     procedure FNCReadEvents(var pMsg : CMessage);
     procedure FNCStartPool(var pMsg : CMessage);
     procedure FNCStopPool(var pMsg : CMessage);
     procedure FNCReBoot(var pMsg : CMessage);
     procedure FNCStopL3(var pMsg : CMessage);
     procedure FNCStartFH(var pMsg : CMessage);
     procedure FNCSetL2TM(var pMsg : CMessage);
     procedure FNCSetSynchro(var pMsg : CMessage);
     procedure FNCDeepBuffer(var pMsg : CMessage);
     procedure FNCBaseSize(var pMsg : CMessage);
     procedure FNCDeepData(var pMsg : CMessage);
     procedure FNCClearData(var pMsg : CMessage);
     procedure FNCExecSQL(var pMsg : CMessage);
     procedure FNCInit(var pMsg : CMessage);
     procedure FNCUnLoadHandler(var pMsg : CMessage);
     procedure FNCUnLoadAck(var pMsg : CMessage);
     procedure FNCPrirDayDbl(var pMsg : CMessage);
     procedure FNCPrirEnMonthDbl(var pMsg : CMessage);
     procedure FNC30SrezEnergDbl(var pMsg : CMessage);
     procedure FNC30SrezEnergDayDbl(var pMsg : CMessage);
     function  IsEnergy(byType:Byte;var pG:L3GRAPHDATAS;var nID:Integer):Boolean;
     procedure RES_RASH_HOR_V(var pMsg : CMessage);
     procedure RES_RASH_DAY_V(var pMsg : CMessage);
     procedure RES_RASH_MON_V(var pMsg : CMessage);
     procedure RES_CURR_RASH(var pMsg : CMessage);
     procedure FNCEnMonthDbl(var pMsg : CMessage);
     procedure FNCEnDayDbl(var pMsg : CMessage);
     function  GetBegCurrAndNumb(var PID: integer): integer;
     procedure FNCReadCurrParams(var pMsg: CMessage);
     procedure OnUpdateAllMeter;
     function  FindValueFromCCDatas(VMID, CMDID, tarif : integer; var pTable : CCDatas) : single;
     function  FindItemFromCCDatas(VMID, CMDID, tarif : integer; var pTable : CCDatas) : integer;
     function  FindValueFromCCDatasDb(VMID, CMDID, tarif : integer; var pTable : CCDatas) : Double;
     function  FindValueFromCCDatasDT(VMID, CMID : integer; Date : TDateTime; var pTable: CCDatas): integer;
     procedure UnknownFNC(var pMsg : CMessage);
     procedure CreateMSG(var pMsg : CMessage; fnc, len : word; result : boolean; Date : TDateTime);
     procedure CreateMSGHead(var pMsg : CMessage; len : word);
     procedure InitAuto(var pTable : SL1TAG);override;
     function  SelfHandler(var pMsg : CMessage):Boolean;override;
     function  LoHandler(var pMsg : CMessage):Boolean;override;
     function  HiHandler(var pMsg : CMessage):Boolean;override;
     function  GetSumMeterVMID(GrID : word): word;
     procedure EncodeFormatBTIFloat(const buf1 : PBYTEARRAY; buf2 : PBYTEARRAY);
     function  EncodeFormatBTIInt(mas : PBYTEARRAY; len : word) : dword;
     procedure EncodeUSPDType();
     procedure EncodeUSPDDevList(i : integer; NT : word);
     procedure EncodeUSPDCharactDevList(i : integer; NT : word);
     procedure EncodeUSPDCharactDevListEx(i, NT : integer; var LengthMSG : word);
     procedure EncodeCharactDevENSB(i : integer; NT : word);
     procedure EncodeCharactKanalList(i : word; NT : word);
     procedure EncodeCharactKanalListEx(i, NT : integer; var LengthMSG : word);
     procedure EncodeCharactKanalENSB(i : word; NT : word);
     procedure EncodeCharGroupList(GrID : word; sm : word; var pTable : SL2TAGREPORTLIST);
     procedure EncodeCharGroupListEx(Gm, NG : integer; var LengthMSG : word);
     procedure RunAuto;override;
     procedure ReadCurrVolt(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
     procedure ReadCurrCur(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
     procedure ReadKoefPower(var sm : word; KB, KE : word; var tDT : TDateTime);
     procedure Read3PowerEn(var sm : word; KB, KE : word; var tDT : TDateTime);
     procedure ReadCurrFreq(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
     procedure ReadCurrAktPow(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
     procedure ReadCurrReaPow(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
     procedure ReadCurrNakEn(var sm : word; KB, KE : word; var tDT : TDateTime);
     procedure ReadVzljotArch(var sm : word; MetAdr, Depth : integer);
     procedure ReadPulsar(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
     function  GetKT(nVMID:Integer):Double;
     function  IsInternalMsg(var pMsg:CMessage):Boolean;
     procedure PrepareFloat(var flValue:Double;nVMID:Integer);
     function  CRC(var buf : array of byte; count : word):boolean;
     function  GetRealPort(nPort:Integer):Integer;
    End;

const srCRCHi:array[0..255] of byte = (
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

      srCRCLo:array[0..255] of byte = (
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
     MAX_PACK_LEHGTH = 1600;
     __SetMeters : array [0..3] of byte = ($01, $04, $10, $40);
     Energ       : array [0..3] of string = ('(W+)',
                                             '(W-)',
                                             '(Q+)',
                                             '(Q-)');

implementation

procedure CBTIModule.InitAuto(var pTable : SL1TAG);
var VMeters : SL3GROUPTAG;
    i       : integer;
    //pMsg : CMessage;
Begin
   //m_pDDB := m_pDB.DynConnect(m_swAddres+1);
   blIsFNCFF1C := false;
   m_pDDB := m_pDB.CreateConnect;
   blIsKTRout := pTable.m_sbyKTRout;
   m_pDDB.GetL2Info(m_pKTTbl);
   byTimeTranz :=  0;
   wMeterNum   :=  High(WORD);
   dwLastTime  :=  0;
   m_pDDB.GetL1Table(m_sTblL1);
   if m_pDDB.GetVMetersTable(-1,-1, VMeters) then
   begin
     PhAddrAndComPrt.Count := VMeters.m_swAmVMeter;
     SetLength(PhAddrAndComPrt.Items, VMeters.m_swAmVMeter);
     for i := 0 to VMeters.m_swAmVMeter - 1 do
     begin
       PhAddrAndComPrt.Items[i].m_swPHAddres := VMeters.Item.Items[i].m_swVMID;
       PhAddrAndComPrt.Items[i].m_swPortID   := VMeters.Item.Items[i].m_sbyPortID;
     end;
   end;
   InnerFunctionPr := 0;
   mBlAllowTranz := true;
   //FNCExecSQL(pMsg);
End;

function  CBTIModule.IsInternalMsg(var pMsg:CMessage):Boolean;
Begin
   Result := (pMsg.m_sbyInfo[1] and $80) <> 0;
End;
procedure CBTIModule.PrepareFloat(var flValue:Double;nVMID:Integer);
Begin
   if (blIsInternal=True)and(blIsKTRout=1) then flValue := flValue/GetKT(nVMID);
End;
function CBTIModule.GetKT(nVMID:Integer):Double;
Var
   i : Integer;
Begin
   Result := 1.0;
   if (nVMID<m_pKTTbl.Count)and(m_pKTTbl.Count<>0) then
   Begin
    for i:=0 to m_pKTTbl.Count-1 do with m_pKTTbl.Items[i] do
    if nVMID=m_swVMID then
    Begin
     Result := m_sfKI*m_sfKU;
     if Result=0 then Result:=1.0;
     exit;
    End
   End;
End;

function  CBTIModule.FindPortID(wVMID : word) : word;
var i : integer;
begin
   Result := High(word);         
   for i := 0 to PhAddrAndComPrt.Count - 1 do
     if PhAddrAndComPrt.Items[i].m_swPHAddres = wVMID then
       Result := PhAddrAndComPrt.Items[i].m_swPortID;
end;

procedure CBTIModule.EncodeUSPDType();
var dwTemp : dword;
    wTemp  : word;
    pTable : SL3INITTAG;
begin
   with USPDType do
   begin
     move(m_sUSPDName[1], m_nTxMsg.m_sbyInfo[6], 32);
     move(m_sNameAdr[1], m_nTxMsg.m_sbyInfo[38], 32);
     dwTemp := EncodeFormatBTIInt(@(m_sdwWorkNumb), 4);   //cc
     move(dwTemp, m_nTxMsg.m_sbyInfo[70], 4);
     wTemp := EncodeFormatBTIInt(@(m_swVersPO), 2);       //cc
     move(wTemp, m_nTxMsg.m_sbyInfo[74], 2);
     wTemp := EncodeFormatBTIInt(@(m_swNumIK), 2);        //cc
     move(wTemp, m_nTxMsg.m_sbyinfo[76], 2);
     if blIsInternal then
     begin
       m_pDB.GetGroupsTable(pTable);
       m_swNumGr := pTable.Count;
     end;
     wTemp := EncodeFormatBTIInt(@(m_swNumGr), 2);        //cc
     move(wTemp, m_nTxMsg.m_sbyInfo[78], 2);
     wTemp := EncodeFormatBTIInt(@(m_swNumTZ), 2);        //cc
     move(wTemp, m_nTxMsg.m_sbyInfo[80], 2);
     wTemp := EncodeFormatBTIInt(@(m_swMaxSupMetNum), 2); //cc
     move(wTemp, m_nTxMsg.m_sbyInfo[82], 2);
     wTemp := EncodeFormatBTIInt(@(m_swNumConMet), 2);    //cc
     move(wTemp, m_nTxMsg.m_sbyInfo[84], 2);
     m_swMaxPackLen := MAX_PACK_LEHGTH;
     wTemp := EncodeFormatBTIInt(@(m_swMaxPackLen), 2);   //cc
     move(wTemp, m_nTxMsg.m_sbyInfo[86], 2);
   end;
end;

procedure CBTIModule.EncodeUSPDDevList(i : integer; NT : word);
var wTemp : word;
begin
   with USPDDevList.Items[i] do
   begin
     if (i < 0) or (i >= USPDDevList.Count) then
     begin
       FillChar(m_nTxMsg.m_sbyInfo[6 + i*18], 18, 0);  //�������� ������ �� ������� ���������
       exit;
     end;
     wTemp := EncodeFormatBTIInt(@m_swIdev, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[6 + i*18], 2);
     move(m_sName[1], m_nTxMsg.m_sbyInfo[8 + i*18], 16);
   end;
end;

procedure CBTIModule.EncodeUSPDCharactDevList(i : integer; NT : word);
var wTemp  : word;
    dwTemp : dword;
    fTemp  : single;
begin
   with USPDCharactDevList.Items[(NT + i - 1)] do
   begin
     if (NT + i - 1 < 0) or (NT + i - 1 >= USPDCharactDevList.Count) then
     begin
       FillChar(m_nTxMsg.m_sbyInfo[6 + i*64], 64, 0);  //�������� ������ �� ������� ���������
       exit;
     end;
     wTemp := EncodeFormatBTIInt(@m_swNDev, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[6 + i*64], 2);
     wTemp := EncodeFormatBTIInt(@m_swIDev, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[8 + i*64], 2);
     dwTemp := EncodeFormatBTIInt(@m_sdwWorkNumb, 4);
     move(dwTemp, m_nTxMsg.m_sbyInfo[10 + i*64], 4);
     wTemp := EncodeFormatBTIInt(@m_swANet, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[14 + i*64], 2);
     wTemp := EncodeFormatBTIInt(@m_swNK, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[16 + i*64], 2);
     wTemp := EncodeFormatBTIInt(@m_swLMax, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[18 + i*64], 2);
     fTemp := m_sfKt;
     EncodeFormatBTIFloat(@fTemp,  @(m_nTxMsg.m_sbyInfo[20 + i*64]));
     fTemp := m_sfKpr;
     EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[24 + i*64]));
     wTemp :=  EncodeFormatBTIInt(@m_swKmb, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[28 + i*64], 2);
     dwTemp := EncodeFormatBTIInt(@m_sdwMUmHi, 4);
     move(dwTemp, m_nTxMsg.m_sbyInfo[30 + i*64], 4);
     dwTemp := EncodeFormatBTIInt(@m_sdwMUmLo, 4);
     move(dwTemp, m_nTxMsg.m_sbyInfo[34 + i*64], 4);
     move(m_sStrAdr[1], m_nTxMsg.m_sbyInfo[38 + i*64], 32);
   end;
end;

procedure CBTIModule.EncodeUSPDCharactDevListEx(i, NT : integer; var LengthMSG : word);
var wTemp     : word;
    dwTemp    : dword;
    fTemp     : single;
    sm        : integer;
begin
   with USPDCharactDevList.Items[(NT + i - 1)] do
   begin
     if (NT + i - 1 < 0) or (NT + i - 1 >= USPDCharactDevList.Count) then
     begin
       exit;
       FillChar(m_nTxMsg.m_sbyInfo[6 + i*64], 64, 0);  //�������� ������ �� ������� ���������
       LengthMSG := LengthMSG + 64;
       exit;
     end;
     wTemp := EncodeFormatBTIInt(@m_swNDev, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 2);                             LengthMSG := LengthMSG + 2;
     wTemp := EncodeFormatBTIInt(@m_swIDev, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 2);                             LengthMSG := LengthMSG + 2;
     dwTemp := EncodeFormatBTIInt(@m_sdwWorkNumb, 4);
     move(dwTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 4);                            LengthMSG := LengthMSG + 4;
     wTemp := EncodeFormatBTIInt(@m_swANet, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 2);                             LengthMSG := LengthMSG + 2;
     wTemp := EncodeFormatBTIInt(@m_swNK, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 2);                             LengthMSG := LengthMSG + 2;
     wTemp := EncodeFormatBTIInt(@m_swLMax, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 2);                             LengthMSG := LengthMSG + 2;
     fTemp := m_sfKt;
     EncodeFormatBTIFloat(@fTemp,  @(m_nTxMsg.m_sbyInfo[LengthMSG]));           LengthMSG := LengthMSG + 4;
     fTemp := m_sfKpr;
     EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[LengthMSG]));            LengthMSG := LengthMSG + 4;
     wTemp :=  EncodeFormatBTIInt(@m_swKmb, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 2);                             LengthMSG := LengthMSG + 2;
     dwTemp := EncodeFormatBTIInt(@m_sdwMUmHi, 4);
     move(dwTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 4);                            LengthMSG := LengthMSG + 4;
     dwTemp := EncodeFormatBTIInt(@m_sdwMUmLo, 4);
     move(dwTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 4);                            LengthMSG := LengthMSG + 4;
     SetLength(m_sStrAdr, Length(m_sStrAdr) + 1);
     m_sStrAdr[Length(m_sStrAdr)] := #0;
     move(m_sStrAdr[1], m_nTxMsg.m_sbyInfo[LengthMSG], Length(m_sStrAdr));      LengthMSG := LengthMSG + Length(m_sStrAdr);
   end;
end;

procedure CBTIModule.EncodeCharactDevENSB(i : integer; NT : word);
var wTemp  : word;
    dwTemp : dword;
begin
   with USPDCharactDevList.Items[(NT + i - 1)] do
   begin
     wTemp := EncodeFormatBTIInt(@m_swNDev, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[6 + i*14], 2);
     wTemp := EncodeFormatBTIInt(@m_swIDev, 4);
     move(wTemp, m_nTxMsg.m_sbyInfo[8 + i*14], 2);
     dwTemp := EncodeFormatBTIInt(@m_sdwWorkNumb, 4);
     move(dwTemp, m_nTxMsg.m_sbyInfo[10 + i*14], 4);
     wTemp := EncodeFormatBTIInt(@m_swANet, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[14 + i*14], 2);
     wTemp := EncodeFormatBTIInt(@m_swNK, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[16 + i*14], 2);
     wTemp := EncodeFormatBTIInt(@m_swLMax, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[18 + i*14], 2);
   end;
end;

procedure CBTIModule.EncodeCharactKanalList(i : word; NT : word);
var wTemp   : word;
    fTemp   : single;
    Temp    : word;
begin
   with USPDCharactDevList.Items[(i + NT - 1) div 4] do
   begin
     if ((i + NT - 1) div 4 < 0) or ((i + NT - 1) div 4 >= USPDCharactDevList.Count) then
     begin
       FillChar(m_nTxMsg.m_sbyInfo[6 + i*52], 52, 0);  //�������� ������ �� ������� ���������
       exit;
     end;
     Temp  := i + NT;
     wTemp := EncodeFormatBTIInt(@Temp, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[6 + (i)*52], 2);
     wTemp := EncodeFormatBTIInt(@m_swNDev, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[8 + (i)*52], 2);
     wTemp := EncodeFormatBTIInt(@Temp, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[10 + (i)*52], 2);
     fTemp := m_sfKt;
     EncodeFormatBTIFloat(@fTemp,  @(m_nTxMsg.m_sbyInfo[12 + (i)*52]));
     fTemp := m_sfKpr;
     EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[16 + (i)*52]));
     fTemp := m_sfKp;
     EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[20 + (i)*52]));
     m_nTxMsg.m_sbyInfo[24 + i*52] := (NT + i - 1) mod 4;
     m_nTxMsg.m_sbyInfo[25 + i*52] := 2;
     move(m_sStrAdr[1], m_nTxMsg.m_sbyInfo[26 + (i)*52], 32);
   end;
end;

procedure CBTIModule.EncodeCharactKanalListEx(i, NT : integer; var LengthMSG : word);
var wTemp   : word;
    fTemp   : single;
    Temp    : word;
begin
   with USPDCharactDevList.Items[(i + NT - 1) div 4] do
   begin
     if ((i + NT - 1) div 4 < 0) or ((i + NT - 1) div 4 >= USPDCharactDevList.Count) then
     begin
       exit;
       FillChar(m_nTxMsg.m_sbyInfo[LengthMSG], 52, 0);  //�������� ������ �� ������� ���������
       LengthMSG := LengthMSG + 52;
       exit;
     end;
     Temp  := i + NT;
     wTemp := EncodeFormatBTIInt(@Temp, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 2);                             LengthMSG := LengthMSG + 2;
     wTemp := EncodeFormatBTIInt(@m_swNDev, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 2);                             LengthMSG := LengthMSG + 2;
     wTemp := EncodeFormatBTIInt(@Temp, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[LengthMSG], 2);                             LengthMSG := LengthMSG + 2;
     fTemp := m_sfKt;
     EncodeFormatBTIFloat(@fTemp,  @(m_nTxMsg.m_sbyInfo[LengthMSG]));           LengthMSG := LengthMSG + 4;
     fTemp := m_sfKpr;
     EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[LengthMSG]));            LengthMSG := LengthMSG + 4;
     fTemp := m_sfKp;
     EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[LengthMSG]));            LengthMSG := LengthMSG + 4;
     m_nTxMsg.m_sbyInfo[LengthMSG] := (NT + i - 1) mod 4;                       LengthMSG := LengthMSG + 1;
     m_nTxMsg.m_sbyInfo[LengthMSG] := 2;                                        LengthMSG := LengthMSG + 1;
     if ((NT + i - 1) mod 4 = 0) or (m_sStrAdr[Length(m_sStrAdr)] <> #0) then
     begin
       SetLength(m_sStrAdr, Length(m_sStrAdr) + 1);
       m_sStrAdr[Length(m_sStrAdr)] := #0;
     end;
     move(m_sStrAdr[1], m_nTxMsg.m_sbyInfo[LengthMSG], Length(m_sStrAdr));      LengthMSG := LengthMSG + Length(m_sStrAdr);
   end;
end;

procedure CBTIModule.EncodeCharactKanalENSB(i : word; NT : word);
var wTemp   : word;
    fTemp   : single;
    Temp    : word;
begin
   with USPDCharactDevList.Items[(i + NT - 1) div 4] do
   begin
     Temp  := i + NT;
     wTemp := EncodeFormatBTIInt(@Temp, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[6 + (i)*19], 2);
     wTemp := EncodeFormatBTIInt(@m_swNDev, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[8 + (i)*19], 2);
     wTemp := EncodeFormatBTIInt(@Temp, 2);
     move(wTemp, m_nTxMsg.m_sbyInfo[10 + (i)*19], 2);
     fTemp := m_sfKt;
     EncodeFormatBTIFloat(@fTemp,  @(m_nTxMsg.m_sbyInfo[12 + (i)*19]));
     fTemp := m_sfKpr;
     EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[16 + (i)*19]));
     fTemp := m_sfKp;
     EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[20 + (i)*19]));
     m_nTxMsg.m_sbyInfo[24 + i*19] := (NT + i - 1) mod 4;
//     m_nTxMsg.m_sbyInfo[25 + i*52] := 2;
//     move(m_sStrAdr[1], m_nTxMsg.m_sbyInfo[26 + i*52], 32);
   end;
end;

procedure CBTIModule.EncodeCharGroupList(GrID : word; sm : word; var pTable : SL2TAGREPORTLIST);
var i    : word;
    str  : string;
begin
   FillChar(m_nTxMsg.m_sbyInfo[sm*162 + 8], 128, 0);
   if (GrID - 1 < 0) or (GrID > (pTable.Count)*4) then
   begin
     FillChar(m_nTxMsg.m_sbyInfo[sm*162 + 6], 162, 0);
     exit;
   end;
   m_nTxMsg.m_sbyInfo[sm*162 + 8 + pTable.m_sMeter[(GrID - 1) div 4].m_swVMID] := __SetMeters[(GrID - 1) mod 4];
   str := pTable.m_sMeter[(GrID - 1) div 4].m_sVMeterName + Energ[(GrID - 1) mod 4];
   SetSpaces(str, length(str), 32);
   move(str[1], m_nTxMsg.m_sbyInfo[sm*162 + 136], 32);
   m_nTxMsg.m_sbyInfo[sm*162 + 6] := (GrID{ - 1}) div $100;
   m_nTxMsg.m_sbyInfo[sm*162 + 7] := (GrID{ - 1}) mod $100;
end;

procedure CBTIModule.EncodeCharGroupListEx(Gm, NG : integer; var LengthMSG : word);
var pTableGr  : SL3INITTAG;
    pTableVM  : SL3GROUPTAG;
    i, j      : integer;
    str       : string;
begin
   m_pDB.GetGroupsTable(pTableGr);
   for i := Gm to Gm + NG - 1 do
   begin
     if pTableGr.Count - 1 >= Gm then
       m_pDB.GetVMetersTable(i, pTableVM);
     FillChar(m_nTxMsg.m_sbyInfo[LengthMSG], 129, 0);
     m_nTxMsg.m_sbyInfo[LengthMSG] := i;                                        Inc(LengthMSG);
     for j := 0 to pTableVM.m_swAmVMeter - 1 do
       m_nTxMsg.m_sbyInfo[pTableVM.Item.Items[j].m_swVMID div 8 + LengthMSG] := m_nTxMsg.m_sbyInfo[pTableVM.Item.Items[j].m_swVMID div 8 + LengthMSG]
                                                 or __SetMask[pTableVM.Item.Items[j].m_swVMID mod 8];
     LengthMSG := LengthMSG + 128;
     str := pTableGr.Items[i].m_sGroupName;
     SetLength(str, Length(str) + 1);
     str[Length(str)] := #0;
     move(str[1], m_nTxMsg.m_sbyInfo[LengthMSG], Length(str));                  LengthMSG := LengthMSG + Length(str);
   end;
end;

procedure CBTIModule.FNCTypeYSPD(var pMsg : CMessage);
var LengthMSG : word;
begin
   m_pDB.ReadUSPDCFG(USPDType);

   SetSpaces(USPDType.m_sUSPDName, length(USPDType.m_sUSPDName) , 32);
   SetSpaces(USPDType.m_sNameAdr, length(USPDType.m_sNameAdr), 32);
   EncodeUSPDType;

   LengthMSG := 82 + 16;
   CreateMSG(pMsg, $00D0, LengthMSG, true, Now);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;


procedure CBTIModule.FNCDeviceYSPD(var pMsg : CMessage);
var i                    : integer;
    LengthMSG, Tm, NT    : word;
begin
   Tm := pMsg.m_sbyInfo[6] * $100 + pMsg.m_sbyInfo[7];
   NT := pMsg.m_sbyInfo[8] * $100 + pMsg.m_sbyInfo[9];
   if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
     m_pDB.ReadUSPDDevCFG(false, USPDDevList)
   else
     m_pDB.ReadUSPDDevCFG(true, USPDDevList);
   for i := 0 to NT - 1 do
   begin
     {if i >= USPDDevList.Count then
       break; }
     SetSpaces(USPDDevList.Items[i].m_sName, length(USPDDevList.Items[i].m_sName), 16);
     EncodeUSPDDevList(i, Tm);
   end;
   LengthMsg := 16 + NT * 18;
   CreateMSG(pMsg, $00D1, LengthMSG, true, Now);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;                                    

procedure CBTIModule.FNCCharYSPD(var pMsg : CMessage);
var i                 : integer;
    LengthMSG, Tm, NT : word;
begin
   if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
     m_pDB.ReadUSPDCharDevCFG(false, USPDCharactDevList)
   else
     m_pDB.ReadUSPDCharDevCFG(true, USPDCharactDevList);
   Tm        := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NT        := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   LengthMSG := 6;
   for i := 0 to NT - 1 do
   begin
     {if (i + Tm >= USPDCharactDevList.Count - 1) then
         break;  }
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
     begin
       SetSpaces(USPDCharactDevList.Items[i + Tm - 1].m_sStrAdr, length(USPDCharactDevList.Items[i + Tm - 1].m_sStrAdr), 32);
       EncodeUSPDCharactDevList(i, Tm);
       LengthMSG := LengthMSG + 64;
     end
     else
       EncodeUSPDCharactDevListEx(i, Tm, LengthMSG);
   end;
   LengthMSG := LengthMSG + 10;
   //LengthMSG := 16 + NT*64;
   CreateMSG(pMsg, $00D2, LengthMSG, true, Now);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCCharYSPDENSB(var pMSg : CMessage);
var i                 : integer;
    LengthMSG, Tm, NT : word;
begin
   if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
     m_pDB.ReadUSPDCharDevCFG(false, USPDCharactDevList)
   else
     m_pDB.ReadUSPDCharDevCFG(true, USPDCharactDevList);
   Tm := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NT := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   for i := 0 to NT - 1 do
   begin
    { if (i + Tm >= USPDCharactDevList.Count - 1) then
         break;   }
       EncodeCharactDevENSB(i, 0);
   end;
   LengthMSG := 16 + NT*14;
   CreateMSG(pMsg, $00D5, LengthMSG, true, Now);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCCharKanalYSPD(var pMsg : CMessage);
var i                 : integer;
    LengthMSG, Tm, NT : word;
begin
   if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
     m_pDB.ReadUSPDCharDevCFG(false, USPDCharactDevList)
   else
     m_pDB.ReadUSPDCharDevCFG(true, USPDCharactDevList);
   Tm := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NT := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   LengthMSG := 6;
   for i := 0 to NT - 1 do
   begin
     {if (i + Tm) >= USPDCharactDevList.Count*4  then
         break; }
       if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
       begin
         SetSpaces(USPDCharactDevList.Items[(i + Tm - 1) div 4].m_sStrAdr, length(USPDCharactDevList.Items[(i + Tm - 1) div 4].m_sStrAdr), 32);
         EncodeCharactKanalList(i, Tm);
         LengthMSG := LengthMSG + 52;
       end
       else
         EncodeCharactKanalListEx(i, Tm, LengthMSG);
   end;
   LengthMSG := LengthMSG + 10;
   CreateMSG(pMsg, $00D3, LengthMSG, true, Now);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCCharKanalYSPDENSB(var pMSg : CMessage);
var i                 : integer;
    LengthMSG, Tm, NT : word;
begin
   if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
     m_pDB.ReadUSPDCharDevCFG(false, USPDCharactDevList)
   else
     m_pDB.ReadUSPDCharDevCFG(true, USPDCharactDevList);
   Tm := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NT := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   for i := 1 to NT do
   begin
    { if i >= USPDCharactDevList.Count then
         break;}
       //SetSpaces(USPDCharactDevList.Items[(i + Tm) div 4].m_sStrAdr, length(USPDCharactDevList.Items[(i + Tm) div 4].m_sStrAdr), 32);
       EncodeCharactKanalENSB(i, 0);
   end;
   LengthMSG := 16 + NT*19;
   CreateMSG(pMsg, $00D6, LengthMSG, true, Now);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCCharGroupYSPD(var pMsg : CMessage);
var Gm, NG, i  : word;
    Meters     : SL2TAGREPORTLIST;
    LengthMSG  : word;
begin
   Gm        := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NG        := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   LengthMSG := 6;
   for i := Gm to NG + Gm - 1 do
   begin
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
     begin
       m_pDDB.GetVMFromEnerg(Meters);
       EncodeCharGroupList(i, i - Gm, Meters);
       LengthMSG := LengthMSG + 162;
     end
     else
     begin
       EncodeCharGroupListEx(Gm, NG, LengthMSG);
       break;
     end;
   end;
   LengthMSG := LengthMSG + 10;
   CreateMSG(pMsg,  $00D4, LengthMSG, true, Now);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.SetSpaces(var str : string; lenN, lenK : byte);
var i : byte;
begin
   SetLength(str, lenK);
   for i := lenN + 1 to lenK - 1 do
     str[i] := ' ';
   str[lenK] := #0;
end;

procedure CBTIModule.EncodeFormatBTIFloat(const buf1 : PBYTEARRAY; buf2 : PBYTEARRAY);
begin
   buf2[3] := buf1[0];
   buf2[2] := buf1[1];
   buf2[1] := buf1[2];
   buf2[0] := buf1[3];
end;

function CBTIModule.EncodeFormatBTIInt(mas : PBYTEARRAY; len : word) : dword;
var i      : word;
    res    : dword;
begin
   res := 0;
   for i := 0 to len - 1 do
   begin
     res := res shl 8;
     res := res + mas[i];
   end;
   Result := res;
end;

function CBTIModule.SelfHandler(var pMsg : CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    if EventBox<>Nil then EventBox.FixMessage(ET_CRITICAL,'(__)CL4MD::>BTI SLF:',pMsg);
    case pMsg.m_sbyType of
         AL_REPMSG_TMR:
         begin
          case InnerFunctionPr of
               14 :
               begin
                m_nCF.m_nSDL.m_nGST.OpenSession(InnerPDS.m_swData1,InnerPDS.m_swData2);
                m_nRepTimer.OffTimer;
               end else
               begin
                m_sIsTranzOpen.m_sbIsTrasnBeg := false;
                m_nCF.SchedGo;
                blIsFNCFF1C := false;
               end;
          end;
         end;
         AL_TROPEN_TMR : SendMSG(BOX_L4,0,DIR_L1TOL4,QL_START_TRANS_REQ);
         AL_WATCH_TMR  : OpenSystem;
    end;

    InnerFunctionPr := 0;
    Result := res;
end;

procedure CBTIModule.CreateMSGHead(var pMsg : CMessage; len : word);
begin
    pMsg.m_swLen         := len + 11;
    pMsg.m_swObjID       := m_swAddres;
    pMsg.m_sbyFrom       := DIR_BTITOL1;
    pMsg.m_sbyFor        := DIR_BTITOL1;
    pMsg.m_sbyType       := PH_DATARD_REQ;
    pMsg.m_sbyTypeIntID  := m_sbyPortID;
    pMsg.m_sbyIntID      := m_sbyPortID;
end;

procedure CBTIModule.CreateMSG(var pMsg : CMessage; fnc, len : word; result : boolean; Date : TDateTime);
var year, month, day     : word;
    hour, min, sec, ms   : word;
begin
   result := true;
   DecodeDate(Date, year, month, day);
   DecodeTime(Date, hour, min, sec, ms);
   m_nTxMsg.m_sbyInfo[0] := $C3;
   m_nTxMsg.m_sbyInfo[1] := pMsg.m_sbyInfo[1];
   m_nTxMsg.m_sbyInfo[2] := (len and $FF00) shr 8;
   m_nTxMsg.m_sbyInfo[3] := len and $00FF;
   m_nTxMsg.m_sbyInfo[4] := (fnc and $FF00) shr 8;
   m_nTxMsg.m_sbyInfo[5] := fnc and $00FF;
   if result then
     m_nTxMsg.m_sbyInfo[len - 10] := 0
   else
     m_nTxMsg.m_sbyInfo[len - 10] := 1;
   m_nTxMsg.m_sbyInfo[len - 9] := min;
   m_nTxMsg.m_sbyInfo[len - 8] := hour;
   m_nTxMsg.m_sbyInfo[len - 7] := day;
   m_nTxMsg.m_sbyInfo[len - 6] := month;
   m_nTxMsg.m_sbyInfo[len - 5] := year - 2000;
   m_nTxMsg.m_sbyInfo[len - 4] := pMsg.m_sbyInfo[pMsg.m_sbyInfo[3] - 4];
   m_nTxMsg.m_sbyInfo[len - 3] := pMsg.m_sbyInfo[pMsg.m_sbyInfo[3] - 3];
   CRC(m_nTxMsg.m_sbyInfo[0], len - 2);
end;

procedure CBTIModule.FNCTimeNow(var pMsg : CMessage);
var year, month, day   : word;
    hour, min, sec, ms : word;
begin
   DecodeDate(Now, year, month, day);
   DecodeTime(Now, hour, min, sec, ms);

   m_nTxMsg.m_sbyInfo[6]  := sec;
   //m_nTxMsg.m_sbyInfo[6]  := 0;
   m_nTxMsg.m_sbyInfo[7]  := min;
   m_nTxMsg.m_sbyInfo[8]  := hour;
   m_nTxMsg.m_sbyInfo[9]  := day;
   m_nTxMsg.m_sbyInfo[10] := month;
   m_nTxMsg.m_sbyInfo[11] := year - 2000;

   CreateMSG(pMsg, $0001, 22, true, Now);
   CreateMSGHead(m_nTxMsg, 22);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCCorTime(var pMsg : CMessage);
var Time             : _SYSTEMTIME;
    Date             : TDateTime;
    Delta            : TDateTime;
begin
   Time.wMilliseconds := 0;
   Time.wSecond    := pMsg.m_sbyInfo[6];  m_nTxMsg.m_sbyInfo[6]  := pMsg.m_sbyInfo[6];
   Time.wMinute    := pMsg.m_sbyInfo[7];  m_nTxMsg.m_sbyInfo[7]  := pMsg.m_sbyInfo[7];
   Time.wHour      := pMsg.m_sbyInfo[8];  m_nTxMsg.m_sbyInfo[8]  := pMsg.m_sbyInfo[8];
   Time.wDay       := pMsg.m_sbyInfo[9];  m_nTxMsg.m_sbyInfo[9]  := pMsg.m_sbyInfo[9];
   Time.wMonth     := pMsg.m_sbyInfo[10]; m_nTxMsg.m_sbyInfo[10] := pMsg.m_sbyInfo[10];
   Time.wYear      := 2000+pMsg.m_sbyInfo[11]; m_nTxMsg.m_sbyInfo[11] := pMsg.m_sbyInfo[11];
   Date            := EncodeDate(Time.wYear, Time.wMonth, Time.wDay) +
                      EncodeTime(Time.wHour, Time.wMinute, Time.wSecond, 0);
   Delta           := abs(Now - Date);
   Time.wDayOfWeek := DayOfWeek(Date);
  // m_pDDB.FixUspdEvent(0,0,EVH_START_CORR);
   m_pDB.EventFlagCorrector := EVH_COR_TIME_DEVICE;
   if SetLocalTime(Time) then
   Begin
    m_nMSynchKorr.m_blEnable := True;
    //mL2Module.PrepareSynchro;
    SendMsg(BOX_L2,0,DIR_LMTOL2,DL_SYSCHPREPARE_IND);
    CreateMSG(pMsg, $0002, 22, true, Now);
    CreateMSGHead(m_nTxMsg, 22);
    FPUT(BOX_L1, @m_nTxMsg);
    //m_pDDB.UpdateKorrMonth(Delta);
    //m_pDDB.FixUspdEvent(0,0,EVH_FINISH_CORR);
   End;
end;

function  CBTIModule.FindValueFromCCDatas(VMID, CMDID, tarif : integer; var pTable : CCDatas) : single;
var i : integer;
begin
   Result := 0;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swVMID = VMID) and (pTable.Items[i].m_swCMDID = CMDID)
         and (pTable.Items[i].m_swTID = tarif) then
     begin
       Result := {round}(pTable.Items[i].m_sfValue);
       break;
     end;
end;
function  CBTIModule.FindValueFromCCDatasDb(VMID, CMDID, tarif : integer; var pTable : CCDatas) : Double;
var i : integer;
begin
   Result := 0;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swVMID = VMID) and (pTable.Items[i].m_swCMDID = CMDID)
         and (pTable.Items[i].m_swTID = tarif) then
     begin
       Result := {round}(pTable.Items[i].m_sfValue);
       break;
     end;
end;

function  CBTIModule.FindValueFromCCDatasDT(VMID, CMID : integer; Date : TDateTime; var pTable: CCDatas): integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swVMID = VMID) and (pTable.Items[i].m_swCMDID = CMID)
         and (pTable.Items[i].m_sTime = Date) then
     begin
       Result := i;
       break;
     end;
end;

function  CBTIModule.FindItemFromCCDatas(VMID, CMDID, tarif : integer; var pTable : CCDatas) : integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swVMID = VMID) and (pTable.Items[i].m_swCMDID = CMDID)
         and (pTable.Items[i].m_swTID = tarif) then
     begin
       Result := i;
       break;
     end;
end;

procedure CBTIModule.FNCEnMonth(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTemp                        : single;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   TempDate := cDateTimeR.NowFirstDayMonth;
   for cnt := 0 to S - 1 do
     cDateTimeR.DecMonth(TempDate);
   result := m_pDDB.GetArchTableForBTI(Km, Km + NK - 1, QRY_NAK_EN_MONTH_EP, TempDate, TempDate, m_pGrData);
   if result then
     TempDate := m_pGrData.Items[0].m_sTime;
   if (Ti = 0) then
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
       NT := 1;     //�� ��������� ���������� �������, ���� ����� �� ���
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       fTempD := FindValueFromCCDatasDb(MeterAdr, QRY_NAK_EN_MONTH_EP + KindEn, tar, m_pGrData);
       PrepareFloat(fTempD,MeterAdr);
       fTemp := fTempD;
       EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*4 + (cnt - Km) * NT * 4]));
     end;
   end;
   LengthMSG := 6 + NK * NT * 4 + 10;
   CreateMSG(pMsg, $0080, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCEnDay(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTemp                        : single;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   TempDate := Now;
   for cnt := 0 to S - 1 do
     cDateTimeR.DecDate(TempDate);
   result := m_pDDB.GetArchTableForBTI(Km, Km + NK - 1, QRY_NAK_EN_DAY_EP, TempDate, TempDate, m_pGrData);
   if result then
     TempDate := m_pGrData.Items[0].m_sTime;
   if (Ti = 0) then
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
       NT := 1;     //�� ��������� ���������� �������, ���� ����� �� ���
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       fTempD := FindValueFromCCDatasDb(MeterAdr, QRY_NAK_EN_DAY_EP + KindEn, tar, m_pGrData);;
       PrepareFloat(fTempD,MeterAdr);
       fTemp := fTempD;
       EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*4 + (cnt - Km) * NT * 4]));
     end;
   end;
   LengthMSG := 6 + NK * NT * 4 + 10;
   CreateMSG(pMsg, $0081, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCPrirEnMonth(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTemp                        : single;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   TempDate := Now;
   cDateTimeR.IncMonth(TempDate);
   for cnt := 0 to S - 1 do
     cDateTimeR.DecMonth(TempDate);
   result := m_pDDB.GetArchTableForBTI(Km, Km + NK - 1, QRY_ENERGY_MON_EP, TempDate, TempDate, m_pGrData);
   if result then
     TempDate := m_pGrData.Items[0].m_sTime;
   if (Ti = 0) then
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
       NT := 1;     //�� ��������� ���������� �������, ���� ����� �� ���
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       fTempD := FindValueFromCCDatasDb(MeterAdr, QRY_ENERGY_MON_EP + KindEn, tar, m_pGrData);
       PrepareFloat(fTempD,MeterAdr);
       fTemp := fTempD;
       EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*4 + (cnt - Km) * NT * 4]));
     end;
   end;
   LengthMSG := 6 + NK * NT * 4 + 10;
   CreateMSG(pMsg, $0042, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCPrirDay(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTemp                        : single;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   TempDate := Now;
   cDateTimeR.IncDate(TempDate);
   for cnt := 0 to S - 1 do
     cDateTimeR.DecDate(TempDate);
   result := m_pDDB.GetArchTableForBTI(Km, Km + NK - 1, QRY_ENERGY_DAY_EP, TempDate, TempDate, m_pGrData);
   if result then
     TempDate := m_pGrData.Items[0].m_sTime;
   if (Ti = 0) then
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
       NT := 1;     //�� ��������� ���������� �������, ���� ����� �� ���
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       fTempD := FindValueFromCCDatasDb(MeterAdr, QRY_ENERGY_DAY_EP + KindEn, tar, m_pGrData);
       PrepareFloat(fTempD,MeterAdr);
       fTemp := fTempD;
       EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*4 + (cnt - Km) * NT * 4]));
     end;
   end;
   LengthMSG := 6 + NK * NT * 4 + 10;
   CreateMSG(pMsg, $0040, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCMaxDay(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG, i : integer;
    MeterAdr, KindEn, tar, cnt      : integer;
    result                          : boolean;
    TempDate1, TempDate2            : TDateTime;
    m_pGrData                       : CCDatas;
    fTemp                           : single;
    Year, Month, Day                : word;
    Hour, Min, Sec, ms              : word;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   TempDate1 := cDateTimeR.NowFirstDayMonth;
   for cnt := 0 to S - 1 do
     cDateTimeR.DecMonth(TempDate1);
   TempDate2 := 0;
   DecodeDate(TempDate1, Year, Month, Day);
   Day := cDateTimeR.DayPerMonth(Month, Year); Hour := 23; Min := 59; Sec := 59; ms := 0;
   TempDate2 := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Min, Sec, ms);
   result := m_pDDB.GetArchTableForBTI(Km, Km + NK - 1, QRY_MAX_POWER_EP, TempDate2, TempDate1, m_pGrData);
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       i := FindItemFromCCDatas(MeterAdr, QRY_MAX_POWER_EP + KindEn, tar, m_pGrData);
       if i = -1 then
       begin
         fTemp := 0;
         m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*6 + (cnt - Km) * NT * 6 + 4] := 1;
         m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*6 + (cnt - Km) * NT * 6 + 5] := $FF;
       end
       else
       begin
         fTemp := m_pGrData.Items[i].m_sfValue;
         DecodeDate(m_pGrData.Items[i].m_sTime, Year, Month, Day);
         DecodeTime(m_pGrData.Items[i].m_sTime, Hour, Min, Sec, ms);
         m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*6 + (cnt - Km) * NT * 6 + 4] := Day;
         m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*6 + (cnt - Km) * NT * 6 + 5] := Hour*2 + Min div 30;
       end;
       //PrepareFloat(fTemp,MeterAdr);
       EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*6 + (cnt - Km) * NT * 6]));
     end;
   end;
   LengthMSG := 6 + NK * NT * 6 + 10;
   CreateMSG(pMsg, $00A2, LengthMSG, result, TempDate1);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNC30SrezEnerg(var pMsg : CMessage);
var Km, NK, S, LengthMSG,time   : integer;
    year, month, day            : word;
    hour, min, sec, ms          : word;
    cnt, MeterAdr, KindEn, Srez : integer;
    result                      : boolean;
    TempDate                    : TDateTime;
    m_pGrData                   : L3GRAPHDATAS;
    fTemp                       : single;
begin
   Km := pMsg.m_sbyInfo[6] * $100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8] * $100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]* $100 + pMsg.m_sbyInfo[11];
   TempDate := Now;  result := true;
   DecodeDate(Now, year, month, day);
   DecodeTime(Now, hour, min, sec, ms);
   time     := (hour * 60 + min);
   Srez := time div 30;
     Srez := Srez - S;
     while Srez < 0 do
     begin
       cDateTimeR.DecDate(TempDate);
       Srez := Srez + 48;
     end;
   for cnt := km to km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;

     if not m_pDDB.GetGraphDatas(TempDate, TempDate, MeterAdr, QRY_SRES_ENR_EP + KindEn, m_pGrData) then
     begin                 // m_pGrData.Items[0].v[Srez];
       result := false;
       //FillChar(m_nTxMsg.m_sbyInfo[6 + (cnt - km) *4], 4, 0);
       SetLength(m_pGrData.Items, 1);
       m_pGrData.Items[0].v[Srez] := 0;
     end else TempDate := m_pGrData.Items[0].m_sdtDate;
     fTemp := m_pGrData.Items[0].v[Srez]*2;
     //PrepareFloat(fTemp,MeterAdr);
     EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[6 + (cnt - Km) * 4]));
   end;
   LengthMSG := 6 + NK * 4 + 10;
   CreateMSG(pMsg, $0052, LengthMSG, result, TempDate);
   DecodeDate(TempDate, year, month, day);
   m_nTxMsg.m_sbyInfo[LengthMSG - 9] := (Srez mod 2) *30;
   m_nTxMsg.m_sbyInfo[LengthMSG - 8] := Srez div 2;
   m_nTxMsg.m_sbyInfo[LengthMsg - 7] := day;
   m_nTxMsg.m_sbyInfo[LengthMsg - 6] := month;
   m_nTxMsg.m_sbyInfo[LengthMsg - 5] := year - 2000;
   CRC(m_nTxMsg.m_sbyInfo[0], LengthMSG - 2);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNC30SrezEnergDay(var pMsg : CMessage);
var Km, NK, S, LengthMSG, i      : integer;
    cnt, MeterAdr, KindEn, Srez  : integer;
    TempDate                     : TDateTime;
    m_pGrData                    : L3GRAPHDATAS;
    result                       : boolean;
    year, month, day             : word;
    fTemp                        : single;
begin
   Km := pMsg.m_sbyInfo[6]*$100  + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100  + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   TempDate := Now; result := true;
   for cnt := 0 to S - 1 do
     cDateTimeR.DecDate(TempDate);
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     if not m_pDDB.GetGraphDatas(TempDate, TempDate, MeterAdr, QRY_SRES_ENR_EP + KindEn, m_pGrData) then
     begin
       result := false;
       SetLength(m_pGrData.Items, 1);
       FillChar(m_pGrData.Items[0].v, 192, 0);
       m_pGrData.Items[0].m_sMaskRead := 0;
     end else TempDate := m_pGrData.Items[0].m_sdtDate;
     for i := 0 to 47 do
     begin
       if IsBitInMask(m_pGrData.Items[0].m_sMaskRead, i) then
         fTemp := m_pGrData.Items[0].v[i]*2
       else
         FillChar(fTemp, sizeof(fTemp), $FF);
       //PrepareFloat(fTemp,MeterAdr);
       EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[6 + (cnt - Km) * 192 + i*4]));
     end;
   end;
   LengthMSG := 16 + NK * 192;
   CreateMSG(pMsg, $0054, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;

{Meters     : SL2TAGREPORTLIST;
m_pDB.GetMeterTableForReport(i div 4, Meters);}
                                     
function  CBTIModule.GetSumMeterVMID(GrID : word): word;
var i      : word;
    meters : SL2TAGREPORTLIST;
begin
   Result := 0;
   m_pDDB.GetVMFromEnerg(meters);
   if GrID <=  meters.Count*4 - 1 then
     Result := Meters.m_sMeter[GrID div 4].m_swVMID;
end;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
procedure CBTIModule.FNCPrirEnMonthGroup(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTemp                        : single;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   result := true;
   TempDate := Now;
   cDateTimeR.IncMonth(TempDate);
   for cnt := 0 to S - 1 do
     cDateTimeR.DecMonth(TempDate);
   if Ti = 0 then
     NT := 1;
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       if not m_pDDB.GetGData(TempDate, TempDate, GetSumMeterVMID((cnt - 1)), QRY_ENERGY_MON_EP + KindEn, tar, m_pGrData) then
       begin
         result := false;
         SetLength(m_pGrData.Items, 1);
         m_pGrData.Items[0].m_sfValue := 0;
       end else TempDate := m_pGrData.Items[0].m_sTime;
       fTempD := m_pGrData.Items[0].m_sfValue;
       PrepareFloat(fTempD,MeterAdr);
       fTemp := fTempD;
       EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*4 + (cnt - Km) * NT * 4]));
     end;
   end;
   LengthMSG := 6 + NK * NT * 4 + 10;
   CreateMSG(pMsg, $0043, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCPrirDayGroup(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTemp                        : single;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   result := true;
   TempDate := Now;
   cDateTimeR.IncDate(TempDate);
   for cnt := 0 to S - 1 do
     cDateTimeR.DecDate(TempDate);
   if Ti = 0 then
     NT := 1;
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       if not m_pDDB.GetGData(TempDate, TempDate, GetSumMeterVMID((cnt - 1)), QRY_ENERGY_DAY_EP + KindEn, tar, m_pGrData) then
       begin
         result := false;
         SetLength(m_pGrData.Items, 1);
         m_pGrData.Items[0].m_sfValue := 0;
       end else TempDate := m_pGrData.Items[0].m_sTime;
       fTempD := m_pGrData.Items[0].m_sfValue;
       PrepareFloat(fTempD,MeterAdr);
       fTemp := fTempD;
       EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*4 + (cnt - Km) * NT * 4]));
     end;
   end;
   LengthMSG := 6 + NK * NT * 4 + 10;
   CreateMSG(pMsg, $0041, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNC30SrezEnergGroup(var pMsg : CMessage);
var Km, NK, S, LengthMSG,time   : integer;
    year, month, day            : word;
    hour, min, sec, ms          : word;
    cnt, MeterAdr, KindEn, Srez : integer;
    result                      : boolean;
    TempDate                    : TDateTime;
    m_pGrData                   : L3GRAPHDATAS;
    fTemp                       : single;
begin
   Km := pMsg.m_sbyInfo[6] * $100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8] * $100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]* $100 + pMsg.m_sbyInfo[11];
   TempDate := Now;  result := true;
   DecodeDate(Now, year, month, day);
   DecodeTime(Now, hour, min, sec, ms);
   time     := (hour * 60 + min);
   Srez := time div 30;
     Srez := Srez - S;
     while Srez < 0 do
     begin
       cDateTimeR.DecDate(TempDate);
       Srez := Srez + 48;
     end;
   for cnt := km to km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;

     if not m_pDDB.GetGraphDatas(TempDate, TempDate, GetSumMeterVMID((cnt - 1)), QRY_SRES_ENR_EP + KindEn, m_pGrData) then
     begin
       result := false;
       SetLength(m_pGrData.Items, 1);
       m_pGrData.Items[0].v[Srez] := 0;
     end;
     fTemp := m_pGrData.Items[0].v[Srez]*2;
     //PrepareFloat(fTemp,MeterAdr);
     EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[6 + (cnt - Km) * 4]));
   end;
   LengthMSG := 6 + NK * 4 + 10;
   CreateMSG(pMsg, $0053, LengthMSG, result, TempDate);
   DecodeDate(TempDate, year, month, day);
   m_nTxMsg.m_sbyInfo[LengthMSG - 9] := (Srez mod 2) *30;
   m_nTxMsg.m_sbyInfo[LengthMSG - 8] := Srez div 2;
   m_nTxMsg.m_sbyInfo[LengthMsg - 7] := day;
   m_nTxMsg.m_sbyInfo[LengthMsg - 6] := month;
   m_nTxMsg.m_sbyInfo[LengthMsg - 5] := year - 2000;
   CRC(m_nTxMsg.m_sbyInfo[0], LengthMSG - 2);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNC30SrezEnergDayGroup(var pMsg : CMessage);
var Km, NK, S, LengthMSG, i      : integer;
    cnt, MeterAdr, KindEn, Srez  : integer;
    TempDate                     : TDateTime;
    m_pGrData                    : L3GRAPHDATAS;
    result                       : boolean;
    year, month, day             : word;
    fTemp                        : single;
begin
   Km := pMsg.m_sbyInfo[6]*$100  + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100  + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   TempDate := Now;  result := true;
   for cnt := 0 to S - 1 do
     cDateTimeR.DecDate(TempDate);

   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     if not m_pDDB.GetGraphDatas(TempDate, TempDate, GetSumMeterVMID((cnt - 1)), QRY_SRES_ENR_EP + KindEn, m_pGrData) then
     begin
       result := false;
       SetLength(m_pGrData.Items, 1);
       FillChar(m_pGrData.Items[0].v, 192, 0);
     end else TempDate := m_pGrData.Items[0].m_sdtDate;
     for i := 0 to 47 do
     begin
       fTemp := m_pGrData.Items[0].v[i]*2;
       //PrepareFloat(fTemp,MeterAdr);
       EncodeFormatBTIFloat(@fTemp, @(m_nTxMsg.m_sbyInfo[6 + (cnt - Km) * 192 + i*4]));
     end;
   end;
   LengthMSG := 16 + NK * 192;
   CreateMSG(pMsg, $0055, LengthMSG, result, TempDate);
   DecodeDate(TempDate, year, month, day);
   m_nTxMsg.m_sbyInfo[LengthMsg - 7] := day;
   m_nTxMsg.m_sbyInfo[LengthMsg - 6] := month;
   m_nTxMsg.m_sbyInfo[LengthMsg - 5] := year - 2000;
   CRC(m_nTxMsg.m_sbyInfo[0], LengthMSG - 2);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCReadJrnl(var pMsg : CMessage);
var TempDate                      : TDateTime;
    Nd                            : byte;
    Rm                            : byte;
    NR                            : byte;
    Year, Month, Day, i           : word;
    Hour, Min, Sec, ms, LengthMSG : word;
    res                           : boolean;
    pTable                        : SEVENTTAGS;
begin
   try
   TempDate := 0; LengthMSG := 0;
   DecodeDate(Now, Year, Month, Day);
   Nd    := pMsg.m_sbyInfo[6];
   Hour  := pMsg.m_sbyInfo[7];
   Day   := pMsg.m_sbyInfo[8];
   Month := pMsg.m_sbyInfo[9];
   Rm    := pMsg.m_sbyInfo[10] - 1;
   NR    := pMsg.m_sbyInfo[11];
   TempDate := EncodeDate(Year, Month, Day) + EncodeTime(Hour, 0, 0, 0);
//   res := m_pDDB.ReadJrnl(Nd - 1, TempDate, pTable);
   for i := Rm to NR + Rm do
   begin
     if i >= pTable.Count then
     begin
       break;
     end
     else
     begin
       DecodeDate(pTable.Items[i].m_sdtEventTime, Year, Month, Day);
       DecodeTime(pTable.Items[i].m_sdtEventTime, Hour, Min, Sec, ms);
       m_nTxMsg.m_sbyInfo[6 + (i - Rm)*10]      := pTable.Items[i].m_swEventID;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm)*10 + 1]  := pTable.Items[i].m_swVMID div $100;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm)*10 + 2]  := pTable.Items[i].m_swVMID mod $100;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm)*10 + 3]  := trunc(pTable.Items[i].m_swDescription) div $100;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm)*10 + 4]  := trunc(pTable.Items[i].m_swDescription) mod $100;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm)*10 + 5]  := Min;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm)*10 + 6]  := Hour;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm)*10 + 7]  := Day;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm)*10 + 8]  := Month;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm)*10 + 9]  := Year - 2000;
     end;
   end;
   LengthMsg := 6 + (i - Rm)*10 + 10;
   CreateMSG(pMsg, $00C0, LengthMSG, res, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
   except
   end
end;

procedure CBTIModule.FNCReadJrnlEx(var pMsg : CMessage);
   var TempDate                     : TDateTime;
    Nd                              : byte;
    Rm                              : byte;
    NR                              : byte;
    Year, Month, Day, i, vmid, DecP : word;
    Hour, Min, Sec, ms, LengthMSG   : word;
    res                             : boolean;
    pTable                          : SEVENTTAGS;
begin
   try
   TempDate := 0; LengthMSG := 0;
   DecodeDate(Now, Year, Month, Day);
   Nd    := pMsg.m_sbyInfo[6];
   VMID  := pMsg.m_sbyInfo[7]*$100 + pMsg.m_sbyInfo[8];
   Hour  := pMsg.m_sbyInfo[9];
   Day   := pMsg.m_sbyInfo[10];
   Month := pMsg.m_sbyInfo[11];
   Rm    := pMsg.m_sbyInfo[12] - 1;
   NR    := pMsg.m_sbyInfo[13];
   DecP  := 0;
   TempDate := EncodeDate(Year, Month, Day) + EncodeTime(Hour, 0, 0, 0);
{   if (Nd = 1) or (Nd = 4) then
//     res := m_pDDB.ReadJrnl(Nd - 1, TempDate, pTable)
   else
     res := m_pDDB.ReadJrnlEx(Nd - 1, VMID, TempDate, Now, pTable);  }
   for i := Rm to NR + Rm do
   begin
     if i >= pTable.Count then
     begin
       break;
     end
     else
     begin
       DecodeDate(pTable.Items[i].m_sdtEventTime, Year, Month, Day);
       DecodeTime(pTable.Items[i].m_sdtEventTime, Hour, Min, Sec, ms);
       {if (pTable.Items[i].m_swVMID <> VMID) and ((Nd = 2) or (Nd = 3)) then
        begin
          Inc(DecP);
          continue;
        end;}
       m_nTxMsg.m_sbyInfo[6 + (i - Rm{ - DecP})*11]      := pTable.Items[i].m_swEventID;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm{ - DecP})*11 + 1]  := pTable.Items[i].m_swVMID div $100;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm{ - DecP})*11 + 2]  := pTable.Items[i].m_swVMID mod $100;
       pTable.Items[i].m_swDescription := 0;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm{- DecP})*11 + 3]  := trunc(pTable.Items[i].m_swDescription) div $100;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm{ - DecP})*11 + 4]  := trunc(pTable.Items[i].m_swDescription) mod $100;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm{ - DecP})*11 + 5]  := Sec;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm{ - DecP})*11 + 6]  := Min;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm{ - DecP})*11 + 7]  := Hour;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm{ - DecP})*11 + 8]  := Day;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm{ - DecP})*11 + 9]  := Month;
       m_nTxMsg.m_sbyInfo[6 + (i - Rm{ - DecP})*11 + 10] := Year - 2000;
       if 6 + (i - Rm{ - DecP})*11 + 10 >= MAX_PACK_LEHGTH then
         break;
     end;
   end;
   LengthMsg := 6 + (i - Rm{ - DecP})*11 + 10;
   CreateMSG(pMsg, $FF09, LengthMSG, res, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
   except
   end
end;

procedure CBTIModule.FNCReadGraphFromMeters(var pMsg : CMessage);
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
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff02, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
end;
procedure CBTIModule.FNCDelArch(var pMsg : CMessage);
Var
   szDT : Integer;
   pDS  : CMessageData;
   dtDate2,dtDate1 : TDateTime;
   DataGraph   : L3GRAPHDATA;
   DataCurrent : L3CURRENTDATA;
begin
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
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff19, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCReadAllCurrParams(var pMsg : CMessage);
var pData    : L3CURRENTDATAS;
    VMID, i  : integer;
    fValue   : single;
begin
   VMID := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7] - 1;
   m_pDDB.GetAllCurrentData(VMID, pData);
   FillChar(m_nTxMsg.m_sbyInfo[6], 136, 0);
   for i := 0 to pData.Count - 1 do
   begin
     fValue := pData.Items[i].m_sfValue;
     case pData.Items[i].m_swCMDID of
       QRY_ENERGY_SUM_EP     : if pData.Items[i].m_swTID <> 0 then move(fValue, m_nTxMsg.m_sbyInfo[6 + (pData.Items[i].m_swTID - 1)*4], 4);
       QRY_ENERGY_SUM_EM     : if pData.Items[i].m_swTID <> 0 then move(fValue, m_nTxMsg.m_sbyInfo[22 + (pData.Items[i].m_swTID - 1)*4], 4);
       QRY_ENERGY_SUM_RP     : if pData.Items[i].m_swTID <> 0 then move(fValue, m_nTxMsg.m_sbyInfo[38 + (pData.Items[i].m_swTID - 1)*4], 4);
       QRY_ENERGY_SUM_RM     : if pData.Items[i].m_swTID <> 0 then move(fValue, m_nTxMsg.m_sbyInfo[54 + (pData.Items[i].m_swTID - 1)*4], 4);
       QRY_MGAKT_POW_S       : move(fValue, m_nTxMsg.m_sbyInfo[70], 4);
       QRY_MGAKT_POW_A       : move(fValue, m_nTxMsg.m_sbyInfo[74], 4);
       QRY_MGAKT_POW_B       : move(fValue, m_nTxMsg.m_sbyInfo[78], 4);
       QRY_MGAKT_POW_C       : move(fValue, m_nTxMsg.m_sbyInfo[82], 4);
       QRY_MGREA_POW_S       : move(fValue, m_nTxMsg.m_sbyInfo[86], 4);
       QRY_MGREA_POW_A       : move(fValue, m_nTxMsg.m_sbyInfo[90], 4);
       QRY_MGREA_POW_B       : move(fValue, m_nTxMsg.m_sbyInfo[94], 4);
       QRY_MGREA_POW_C       : move(fValue, m_nTxMsg.m_sbyInfo[98], 4);
       QRY_U_PARAM_A         : move(fValue, m_nTxMsg.m_sbyInfo[102], 4);
       QRY_U_PARAM_B         : move(fValue, m_nTxMsg.m_sbyInfo[106], 4);
       QRY_U_PARAM_C         : move(fValue, m_nTxMsg.m_sbyInfo[110], 4);
       QRY_I_PARAM_A         : move(fValue, m_nTxMsg.m_sbyInfo[114], 4);
       QRY_I_PARAM_B         : move(fValue, m_nTxMsg.m_sbyInfo[118], 4);
       QRY_I_PARAM_C         : move(fValue, m_nTxMsg.m_sbyInfo[122], 4);
       QRY_FREQ_NET          : move(fValue, m_nTxMsg.m_sbyInfo[126], 4);
       QRY_KOEF_POW_A        : move(fValue, m_nTxMsg.m_sbyInfo[130], 4);
       QRY_KOEF_POW_B        : move(fValue, m_nTxMsg.m_sbyInfo[134], 4);
       QRY_KOEF_POW_C        : move(fValue, m_nTxMsg.m_sbyInfo[138], 4);
     end;
   end;
   CreateMSG(pMsg, $FF1A, 16+136, True, Now);
   CreateMSGHead(m_nTxMsg, 16+136);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCReadMonitorParams(var pMsg : CMessage);
var VMID, CMDID         : integer;
    DateBeg             : TDateTime;
    StartPoz, NumToRead : integer;
    pTable              : SMONITORDATAS;
    BufferSize          : integer;
begin
   VMID    := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   CMDID   := pMsg.m_sbyInfo[8];
   DateBeg := Now - pMsg.m_sbyInfo[9];
   move(pMsg.m_sbyInfo[10], StartPoz, 4);
   NumToRead := pMsg.m_sbyInfo[14] + pMsg.m_sbyInfo[15]*$100;
   m_pDDB.GetMonitorTable(VMID, CMDID, DateBeg, pTable);
   if pTable.Count = 0 then
     m_nTxMsg.m_sbyInfo[6] := 2
   else
   begin
     pTable.Items[0].m_nData.Position := StartPoz;
     if (StartPoz + NumToRead < pTable.Items[0].m_nData.Size) then
       m_nTxMsg.m_sbyInfo[6] := 0
     else
     begin
       m_nTxMsg.m_sbyInfo[6] := 1;
       NumToRead := pTable.Items[0].m_nData.Size - StartPoz;
     end;
     move(StartPoz, m_nTxMsg.m_sbyInfo[7], 4);
     m_nTxMsg.m_sbyInfo[11] := NumToRead mod $100;
     m_nTxMsg.m_sbyInfo[12] := NumToRead div $100;
     BufferSize := pTable.Items[0].m_nData.Size;
     move(BufferSize, m_nTxMsg.m_sbyInfo[13], 4);
     pTable.Items[0].m_nData.Read(m_nTxMsg.m_sbyInfo[17], NumToRead);
     if Assigned(pTable.Items[0].m_nData) then pTable.Items[0].m_nData.Free;
     pTable.Items[0].m_nData := nil;
   end;
   CreateMSG(pMsg, $FF1B, 16 + 1 + 4 + 2 + 4 + NumToRead, True, Now);
   CreateMsgHead(m_nTxMsg, 16 + 1 + 4 + 2 + 4 + NumToRead);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCReadOneSliceEx(var pMsg : CMessage);
var VMID, slID, i: integer;
    rDate        : TDateTime;
    grData       : L3GRAPHDATAS;
begin
   VMID := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   move(pMsg.m_sbyInfo[8], rDate, sizeof(TDateTime));
   slID := pMsg.m_sbyInfo[8 + sizeof(TDateTime)];
   m_pDDB.GetOneSliceData(rDate, VMID, slID, grData);
   move(rDate, m_nTxMsg.m_sbyInfo[6], sizeof(TDateTime));
   m_nTxMsg.m_sbyInfo[6 + sizeof(TDateTime)] := slID;
   for i := 0 to 3 do
   begin
     move(grData.Items[i].v[0], m_nTxMsg.m_sbyInfo[6 + sizeof(TDateTime) + 1 + i*(sizeof(Double) + 1)], sizeof(Double));
     m_nTxMsg.m_sbyInfo[6 + sizeof(TDateTime) + 1 + i*(sizeof(Double) + 1) + sizeof(Double)] := grData.Items[i].m_sMaskRead;
   end;
   CreateMSG(pMsg, $FF20, 16 + sizeof(TDateTime) + 1 + 4*(sizeof(Double) + 1), True, Now);
   CreateMsgHead(m_nTxMsg, 16 + sizeof(TDateTime) + 1 + 4*(sizeof(Double) + 1));
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCReadEvents(var pMsg : CMessage);
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
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff04, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CBTIModule.FNCStartPool(var pMsg : CMessage);
Var
   pDS  : CMessageData;
Begin
   m_nCF.SchedGo;
   mL3LmeMoule.m_sALD.Reset;
   pDS.m_swData0 := -1;
   pDS.m_swData1 := -1;
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $FF00, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CBTIModule.FNCStopPool(var pMsg : CMessage);
Var
   pDS  : CMessageData;
Begin
   m_nCF.SchedPause;
   mL3LmeMoule.m_sALD.Reset;
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff01, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CBTIModule.FNCReBoot(var pMsg : CMessage);
Var
   pDS  : CMessageData;
Begin
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RBOOT_DATA_REQ,pDS);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff03, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CBTIModule.FNCStopL3(var pMsg : CMessage);
Var
   pDS  : CMessageData;
Begin
   FillChar(m_nTxMsg,30,0);
   if (pMsg.m_sbyInfo[6] and 1)<>0 then
   Begin
    //if pMsg.m_sbyInfo[7]=0 then Begin m_nCF.SchedPause;mL2Module.Suspend;End else
    //if pMsg.m_sbyInfo[7]=1 then Begin m_nCF.SchedGo;   mL2Module.Resume; End;
     m_nCF.SchedGo;
     m_nPauseCM := False;
     OnUpdateAllMeter;
   End;
   if (pMsg.m_sbyInfo[6] and 2)<>0 then
   Begin
    //if pMsg.m_sbyInfo[7]=0 then Begin m_nCF.SchedPause;mL3Module.Suspend;End else
    //if pMsg.m_sbyInfo[7]=1 then Begin m_nCF.SchedGo;   mL3Module.Resume; End;
    if pMsg.m_sbyInfo[7]=0 then
    Begin
      m_nCF.SchedPause;
      m_nPauseCM := True;
    End else
    if pMsg.m_sbyInfo[7]=1 then
    Begin
     m_nCF.SchedGo;
     m_nPauseCM := False;
     //OnUpdateAllMeter;
    End;
   End;

   m_nStateLr := pMsg.m_sbyInfo[7];
   m_nTxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[6];
   m_nTxMsg.m_sbyInfo[7] := pMsg.m_sbyInfo[7];
   CreateMSG(pMsg, $ff05, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CBTIModule.OnUpdateAllMeter;
Var
     tmTime0,tmTime1 : TDateTime;
     szDT : Integer;
     pDS  : CMessageData;
begin
     FillChar(pDS,sizeof(CMessageData),0);
     szDT := sizeof(TDateTime);
     pDS.m_swData0 := 0;
     pDS.m_swData1 := QRY_SRES_ENR_EP;
     pDS.m_swData2 := 0;
     pDS.m_swData3 := 0;
     pDS.m_swData4 := MTR_LOCAL;
     tmTime1       := Now;
     tmTime0       := Now;
     if tmTime0 = 0 then tmTime0 := Now - 31;
     Move(tmTime0,pDS.m_sbyInfo[0]   ,szDT);
     Move(tmTime1,pDS.m_sbyInfo[szDT],szDT);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_DATA_ALLGRAPH_REQ,pDS);
end;
procedure CBTIModule.FNCStartFH(var pMsg : CMessage);
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
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff06, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
End;
{
     FsgGrid.Cells[16,nY] := IntToStr(cDateTimeR.DateTimeToSec(m_sdtSumKor));
     FsgGrid.Cells[17,nY] := IntToStr(cDateTimeR.DateTimeToSec(m_sdtLimKor));
     FsgGrid.Cells[18,nY] := IntToStr(cDateTimeR.DateTimeToSec(m_sdtPhLimKor));
}
procedure CBTIModule.FNCSetL2TM(var pMsg : CMessage);
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
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff07, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
   except

   end;
End;
procedure CBTIModule.FNCSetSynchro(var pMsg : CMessage);
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
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff12, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
   except

   end;
End;
procedure CBTIModule.FNCDeepBuffer(var pMsg : CMessage);
begin
   try
   m_nMaxDayNetParam := pMsg.m_sbyInfo[6];

   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := m_nMaxDayNetParam;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff13, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
   except

   end;
End;
procedure CBTIModule.FNCBaseSize(var pMsg : CMessage);
Var
   nSizeDB : Integer;
begin
   try
   if pMsg.m_sbyInfo[7]=1 then m_nMaxSpaceDB := pMsg.m_sbyInfo[6];

   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := m_nMaxSpaceDB;
   nSizeDB               := m_pDB.GetSizeDB;
   Move(nSizeDB,m_nTxMsg.m_sbyInfo[7],4);
   CreateMSG(pMsg, $ff14, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
   except

   end;
End;
procedure CBTIModule.FNCDeepData(var pMsg : CMessage);
begin
   try
   m_nCF.m_pGenTable.m_sStoreClrTime := pMsg.m_sbyInfo[6]+1;
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := m_nCF.m_pGenTable.m_sStoreClrTime;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff15, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
   except

   end;
End;
procedure CBTIModule.FNCClearData(var pMsg : CMessage);
Var
   nClearMonth : Integer;
begin
   try
   nClearMonth := pMsg.m_sbyInfo[6];
   m_pDB.FreeBase(nClearMonth);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := nClearMonth;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff16, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
   except

   end;
End;
procedure CBTIModule.FNCExecSQL(var pMsg : CMessage);
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
    str  := '';
    nLen := 0;
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
    m_nTxMsg.m_sbyInfo[6] := 0;
    m_nTxMsg.m_sbyInfo[7] := 0;
    CreateMSG(pMsg, $ff17, 16+2, True, Now);
    CreateMSGHead(m_nTxMsg, 16+2);
    FPUT(BOX_L1, @m_nTxMsg);
    except
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL3MD::>Error In CBTIModule.FNCExecSQL!!!');
    End;
End;
procedure CBTIModule.FNCInit(var pMsg : CMessage);
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
        12 : m_nQweryReboot := 1; //������ ������������
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
        16 : Begin
              if pMsg.m_sbyInfo[7]=0 then pDS.m_swData4 := MTR_LOCAL else
              if pMsg.m_sbyInfo[7]=1 then pDS.m_swData4 := MTR_REMOTE;
              SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RELOAD_USPRO_REQ,pDS);
             End;
        17 : Begin
              move(pMsg.m_sbyInfo[7], m_nCountOfEvents, 4);
              m_nCF.SetSettIntValue('m_nCountOfEvents',m_nCountOfEvents);
             End;

        20 : Begin
              m_nLockMeter := pMsg.m_sbyInfo[7];
              m_nCF.SetSettIntValue('m_nLockMeter',pMsg.m_sbyInfo[7]);
             End;

        23 : if pMsg.m_sbyInfo[7]=0 then SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ) else
             if pMsg.m_sbyInfo[7]=1 then SendMSG(BOX_L4,0,DIR_L1TOL4,QL_START_TRANS_REQ);
   End;
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[6];
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff18, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
   except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL3MD::>Error In CBTIModule.FNCInit!!!');
   end;
End;
procedure CBTIModule.FNCUnLoadHandler(var pMsg : CMessage);
Var
   plMsg : CMessage;
Begin
   plMsg.m_swLen   := pMsg.m_swLen-6-4;
   plMsg.m_sbyFrom := DIR_ULTOUL;
   plMsg.m_sbyFor  := DIR_ULTOUL;
   plMsg.m_sbyType := UNL_REM_DATA;
   Move(pMsg.m_sbyInfo[6],plMsg.m_sbyInfo[0],pMsg.m_swLen-11-6-4);
   FPUT(BOX_UN_LOAD, @plMsg);

   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff0B, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CBTIModule.FNCUnLoadAck(var pMsg : CMessage);
Begin
   pMsg.m_swLen   := 11;
   pMsg.m_sbyFrom := DIR_ULTOUL;
   pMsg.m_sbyFor  := DIR_ULTOUL;
   pMsg.m_sbyType := UNL_SEND_ACK;
   FPUT(BOX_UN_LOAD, @pMsg);
End;

procedure CBTIModule.FNCPrirDayDbl(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   TempDate := Now;
   cDateTimeR.IncDate(TempDate);
   for cnt := 0 to S - 1 do
     cDateTimeR.DecDate(TempDate);
   result := m_pDDB.GetArchTableForBTI(Km, Km + NK - 1, QRY_ENERGY_DAY_EP, TempDate, TempDate, m_pGrData);
   if result then
     TempDate := m_pGrData.Items[0].m_sTime;
   if (Ti = 0) then
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
       NT := 1;     //�� ��������� ���������� �������, ���� ����� �� ���
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       fTempD := FindValueFromCCDatasDb(MeterAdr, QRY_ENERGY_DAY_EP + KindEn, tar, m_pGrData);
       move(fTempD, m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*8 + (cnt - Km) * NT * 8], 8);
     end;
   end;
   LengthMSG := 6 + NK * NT * 8 + 10;
   CreateMSG(pMsg, $FF0C, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCPrirEnMonthDbl(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   TempDate := Now;
   cDateTimeR.IncMonth(TempDate);
   for cnt := 0 to S - 1 do
     cDateTimeR.DecMonth(TempDate);
   result := m_pDDB.GetArchTableForBTI(Km, Km + NK - 1, QRY_ENERGY_MON_EP, TempDate, TempDate, m_pGrData);
   if result then
     TempDate := m_pGrData.Items[0].m_sTime;
   if (Ti = 0) then
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
       NT := 1;     //�� ��������� ���������� �������, ���� ����� �� ���
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       fTempD := FindValueFromCCDatasDb(MeterAdr, QRY_ENERGY_MON_EP + KindEn, tar, m_pGrData);
       move(fTempD, m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*8 + (cnt - Km) * NT * 8], 8);
     end;
   end;
   LengthMSG := 6 + NK * NT * 8 + 10;
   CreateMSG(pMsg, $FF0D, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNC30SrezEnergDbl(var pMsg : CMessage);
var Km, NK, S, LengthMSG,time   : integer;
    year, month, day            : word;
    hour, min, sec, ms          : word;
    cnt, MeterAdr, KindEn, Srez : integer;
    result                      : boolean;
    TempDate                    : TDateTime;
    m_pGrData                   : L3GRAPHDATAS;
    fTemp                       : Double;
begin
   Km := pMsg.m_sbyInfo[6] * $100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8] * $100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]* $100 + pMsg.m_sbyInfo[11];
   TempDate := Now;  result := true;
   DecodeDate(Now, year, month, day);
   DecodeTime(Now, hour, min, sec, ms);
   time     := (hour * 60 + min);
   Srez := time div 30;
     Srez := Srez - S;
     while Srez < 0 do
     begin
       cDateTimeR.DecDate(TempDate);
       Srez := Srez + 48;
     end;
   for cnt := km to km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;

     if not m_pDDB.GetGraphDatas(TempDate, TempDate, MeterAdr, QRY_SRES_ENR_EP + KindEn, m_pGrData) then
     begin                 // m_pGrData.Items[0].v[Srez];
       result := false;
       //FillChar(m_nTxMsg.m_sbyInfo[6 + (cnt - km) *4], 4, 0);
       SetLength(m_pGrData.Items, 1);
       m_pGrData.Items[0].v[Srez] := 0;
     end else TempDate := m_pGrData.Items[0].m_sdtDate;
     fTemp := m_pGrData.Items[0].v[Srez]*2;
     move(fTemp, m_nTxMsg.m_sbyInfo[6 + (cnt - Km) * 8], 8);
   end;
   LengthMSG := 6 + NK * 8 + 10;
   CreateMSG(pMsg, $FF0E, LengthMSG, result, TempDate);
   DecodeDate(TempDate, year, month, day);
   m_nTxMsg.m_sbyInfo[LengthMSG - 9] := (Srez mod 2) *30;
   m_nTxMsg.m_sbyInfo[LengthMSG - 8] := Srez div 2;
   m_nTxMsg.m_sbyInfo[LengthMsg - 7] := day;
   m_nTxMsg.m_sbyInfo[LengthMsg - 6] := month;
   m_nTxMsg.m_sbyInfo[LengthMsg - 5] := year - 2000;
   CRC(m_nTxMsg.m_sbyInfo[0], LengthMSG - 2);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNC30SrezEnergDayDbl(var pMsg : CMessage);
var Km, NK, S, LengthMSG, i      : integer;
    cnt, MeterAdr, KindEn, Srez  : integer;
    TempDate                     : TDateTime;
    m_pGrData                    : L3GRAPHDATAS;
    m_pGrData4                   : L3GRAPHDATAS;
    result                       : boolean;
    year, month, day             : word;
    fTemp                        : real48;
    nID                          : Integer;
begin
   Km := pMsg.m_sbyInfo[6]*$100  + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100  + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   TempDate := Now; result := true;
   for cnt := 0 to S - 1 do
     cDateTimeR.DecDate(TempDate);

   MeterAdr := (Km - 1) shr 2;
   m_pDDB.GetGraphDatas4(TempDate, TempDate, MeterAdr, QRY_SRES_ENR_EP, m_pGrData4);

   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     SetLength(m_pGrData.Items,1);
     m_pGrData.Count := 0;
     m_pGrData.Items[0].m_sMaskRead := 0;
     if IsEnergy(KindEn,m_pGrData4,nID)=True then
     Begin
      m_pGrData.Items[0] := m_pGrData4.Items[nID];
      m_pGrData.Count    :=1;
     End
      else
        m_pGrData.Count:=0;
     //if not m_pDDB.GetGraphDatas(TempDate, TempDate, MeterAdr, QRY_SRES_ENR_EP + KindEn, m_pGrData) then
     if (m_pGrData.Count=0) then
     begin
       result := false;
       //SetLength(m_pGrData.Items, 1);
       for i := 0 to 47 do
         m_pGrData.Items[0].v[i] := 0;
       m_pGrData.Items[0].m_sMaskRead := 0;
     end else TempDate := m_pGrData.Items[0].m_sdtDate;
     for i := 0 to 47 do
     begin
       if IsBitInMask(m_pGrData.Items[0].m_sMaskRead, i) then
         fTemp := m_pGrData.Items[0].v[i]*2
       else
         FillChar(fTemp, sizeof(fTemp), $FF);
       move(fTemp, m_nTxMsg.m_sbyInfo[6 + (cnt - Km) * 288 + i*6], 6);
     end;
   end;
   LengthMSG := 16 + NK * 288;
   CreateMSG(pMsg, $FF0F, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;
function CBTIModule.IsEnergy(byType:Byte;var pG:L3GRAPHDATAS;var nID:Integer):Boolean;
Var
   res : Boolean;
   i : Integer;
Begin
   res := False;
   nID := -1;
   for i:=0 to pG.Count-1 do
   Begin
    if byType=(pG.Items[i].m_swCMDID-QRY_SRES_ENR_EP) then
    Begin
     nID := i;
     res := True;
     break;
    End;
   End;
   Result := res;
end;
procedure CBTIModule.RES_RASH_HOR_V(var pMsg : CMessage);
var Km, NK, S, LengthMSG, i      : integer;
    cnt, MeterAdr, KindEn, Srez  : integer;
    TempDate                     : TDateTime;
    m_pGrData                    : L3GRAPHDATAS;
    result                       : boolean;
    year, month, day             : word;
    fTemp                        : real48;
begin
   Km := pMsg.m_sbyInfo[6]*$100  + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100  + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   TempDate := Now; result := true;
   for cnt := 0 to S - 1 do
     cDateTimeR.DecDate(TempDate);
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     if not m_pDDB.GetGraphDatas(TempDate, TempDate, MeterAdr, QRY_RASH_HOR_V + KindEn, m_pGrData) then
     begin
       result := false;
       SetLength(m_pGrData.Items, 1);
       for i := 0 to 47 do
         m_pGrData.Items[0].v[i] := 0;
       m_pGrData.Items[0].m_sMaskRead := 0;
     end else TempDate := m_pGrData.Items[0].m_sdtDate;
     for i := 0 to 47 do
     begin
       if IsBitInMask(m_pGrData.Items[0].m_sMaskRead, i) then
         fTemp := m_pGrData.Items[0].v[i]*2
       else
         FillChar(fTemp, sizeof(fTemp), $FF);
       move(fTemp, m_nTxMsg.m_sbyInfo[6 + (cnt - Km) * 288 + i*6], 6);
     end;
   end;
   LengthMSG := 16 + NK * 288;
   CreateMSG(pMsg, $FF21, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCEnMonthDbl(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   TempDate := cDateTimeR.NowFirstDayMonth;
   for cnt := 0 to S - 1 do
     cDateTimeR.DecMonth(TempDate);
   result := m_pDDB.GetArchTableForBTI(Km, Km + NK - 1, QRY_NAK_EN_MONTH_EP, TempDate, TempDate, m_pGrData);
   if result then
     TempDate := m_pGrData.Items[0].m_sTime;
   if (Ti = 0) then
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
       NT := 1;     //�� ��������� ���������� �������, ���� ����� �� ���
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       fTempD := FindValueFromCCDatasDb(MeterAdr, QRY_NAK_EN_MONTH_EP + KindEn, tar, m_pGrData);
       move(fTempD, m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*8 + (cnt - Km) * NT * 8], 8);
     end;
   end;
   LengthMSG := 6 + NK * NT * 8 + 10;
   CreateMSG(pMsg, $FF10, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;
procedure CBTIModule.FNCEnDayDbl(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   TempDate := Now;
   for cnt := 0 to S - 1 do
     cDateTimeR.DecDate(TempDate);
   result := m_pDDB.GetArchTableForBTI(Km, Km + NK - 1, QRY_NAK_EN_DAY_EP, TempDate, TempDate, m_pGrData);
   if result then
     TempDate := m_pGrData.Items[0].m_sTime;
   if (Ti = 0) then
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
       NT := 1;     //�� ��������� ���������� �������, ���� ����� �� ���
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       fTempD := FindValueFromCCDatasDb(MeterAdr, QRY_NAK_EN_DAY_EP + KindEn, tar, m_pGrData);
       move(fTempD, m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*8 + (cnt - Km) * NT * 8], 8);
     end;
   end;
   LengthMSG := 6 + NK * NT * 8 + 10;
   CreateMSG(pMsg, $FF11, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;
procedure CBTIModule.RES_RASH_DAY_V(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   TempDate := Now;
   for cnt := 0 to S - 1 do
     cDateTimeR.DecDate(TempDate);
   result := m_pDDB.GetArchTableForBTIPuls(Km, Km + NK - 1, QRY_RASH_DAY_V, TempDate, TempDate, m_pGrData);
   if result then
     TempDate := m_pGrData.Items[0].m_sTime;
   if (Ti = 0) then
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
       NT := 1;     //�� ��������� ���������� �������, ���� ����� �� ���
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       fTempD := FindValueFromCCDatasDb(MeterAdr, QRY_RASH_DAY_V + KindEn, tar, m_pGrData);
       move(fTempD, m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*8 + (cnt - Km) * NT * 8], 8);
     end;
   end;
   LengthMSG := 6 + NK * NT * 8 + 10;
   CreateMSG(pMsg, $FF22, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;
{
  QRY_SUM_RASH_V              = 129;   //������ ����� (�3)
  QRY_RASH_HOR_V              = 130;   //������ � ��� (�3)
  QRY_RASH_DAY_V              = 131;   //������ � ����� (�3)
  QRY_RASH_MON_V              = 132;   //������ � ����� (�3)
  QRY_RASH_AVE_V              = 133;   //������ ������� (�3/�)
}
procedure CBTIModule.RES_CURR_RASH(var pMsg : CMessage);
var pData    : L3CURRENTDATAS;
    VMID,i,k : integer;
    fValue   : single;
begin
   k := 0;
   VMID := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7] - 1;
   m_pDDB.GetAllCurrentData(VMID, pData);
   FillChar(m_nTxMsg.m_sbyInfo[6], 80, 0);
   for i := 0 to pData.Count - 1 do
   begin
     fValue := pData.Items[i].m_sfValue;
     if ((pData.Items[i].m_swCMDID=QRY_SUM_RASH_V)or
         (pData.Items[i].m_swCMDID=QRY_RASH_DAY_V)or
         (pData.Items[i].m_swCMDID=QRY_RASH_MON_V)or
         (pData.Items[i].m_swCMDID=QRY_RASH_AVE_V)) then
     Begin
      move(fValue,m_nTxMsg.m_sbyInfo[6+k*4],4);
      Inc(k);
     End;
   end;
   CreateMSG(pMsg, $FF24, 16+80, True, Now);
   CreateMSGHead(m_nTxMsg, 16+80);
   FPUT(BOX_L1, @m_nTxMsg);
end;
procedure CBTIModule.RES_RASH_MON_V(var pMsg : CMessage);
var KM, NK, S, Ti, NT, LengthMSG : integer;
    MeterAdr, KindEn, tar, cnt   : integer;
    result                       : boolean;
    TempDate                     : TDateTime;
    m_pGrData                    : CCDatas;
    fTempD                       : Double;
begin
   Km := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   NK := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   S  := pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11];
   Ti := pMsg.m_sbyInfo[12];
   NT := pMsg.m_sbyInfo[13];
   TempDate := cDateTimeR.NowFirstDayMonth;
   for cnt := 0 to S - 1 do
     cDateTimeR.DecMonth(TempDate);
   result := m_pDDB.GetArchTableForBTIPuls(Km, Km + NK - 1, QRY_RASH_MON_V, TempDate, TempDate, m_pGrData);
   if result then
     TempDate := m_pGrData.Items[0].m_sTime;
   if (Ti = 0) then
     if (pMsg.m_sbyInfo[1] and $80 = 0) or (pMsg.m_sbyInfo[pMsg.m_swLen - 11 - 3] <> 12) then
       NT := 1;     //�� ��������� ���������� �������, ���� ����� �� ���
   for cnt := Km to Km + NK - 1 do
   begin
     MeterAdr := (cnt - 1) shr 2;
     KindEn   := (cnt - 1) mod 4;
     for tar := Ti to Ti + NT - 1 do
     begin
       fTempD := FindValueFromCCDatasDb(MeterAdr, QRY_RASH_MON_V + KindEn, tar, m_pGrData);
       move(fTempD, m_nTxMsg.m_sbyInfo[6 + (tar - Ti)*8 + (cnt - Km) * NT * 8], 8);
     end;
   end;
   LengthMSG := 6 + NK * NT * 8 + 10;
   CreateMSG(pMsg, $FF23, LengthMSG, result, TempDate);
   CreateMSGHead(m_nTxMsg, LengthMsg);
   FPUT(BOX_L1, @m_nTxMsg);
end;




function  CBTIModule.GetBegCurrAndNumb(var PID: integer): integer;
begin
   Result := -1;
   case PID of
     QRY_U_PARAM_A, QRY_U_PARAM_B, QRY_U_PARAM_C :
     begin
       PID    := QRY_U_PARAM_S;
       Result := 3;
     end;
     QRY_I_PARAM_A, QRY_I_PARAM_B, QRY_I_PARAM_C :
     begin
       PID    := QRY_I_PARAM_S;
       Result := 3;
     end;
     QRY_ANET_FI :
       Result := 0;
     QRY_KOEF_POW_A, QRY_KOEF_POW_B, QRY_KOEF_POW_C :
     begin
       PID    := QRY_KOEF_POW_A;
       Result := 2;
     end;
     QRY_FREQ_NET :
       Result := 0;
     QRY_MGAKT_POW_S, QRY_MGAKT_POW_A, QRY_MGAKT_POW_B, QRY_MGAKT_POW_C :
     begin
       PID    := QRY_MGAKT_POW_S;
       Result := 3;
     end;
     QRY_MGREA_POW_S, QRY_MGREA_POW_A, QRY_MGREA_POW_B, QRY_MGREA_POW_C :
     begin
       PID    := QRY_MGREA_POW_S;
       Result := 3;
     end;
     QRY_SUM_RASH_V :
     begin
       PID    := QRY_SUM_RASH_V;
       Result := 5;
     end;
   end;
end;
//FindValueFromCCDatasDT(VMID, CMID : integer; Date : TDateTime; var pTable: CCDatas): Double;
procedure CBTIModule.FNCReadCurrParams(var pMsg: CMessage);
var  PIDB, PIDE, i, j, it   : integer;
     VMID                   : word;
     Depth                  : SmallInt;
     pTable                 : CCDatas;
     fValue                 : single;
     TempDate               : TDateTime;
begin
   VMID     := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];
   PIDB     := pMsg.m_sbyInfo[8];
   PIDE     := GetBegCurrAndNumb(PIDB);
   move(pMsg.m_sbyInfo[9], Depth, 2);
   TempDate := trunc(Now) - Depth;
   m_pDDB.GetGDPData_48(TempDate, TempDate + EncodeTime(23, 59, 59, 0), VMID,
                        PIDB, PIDB + PIDE, pTable);
   if pTable.Count > 0 then
     TempDate := pTable.Items[0].m_sTime;
   for i := PIDB to PIDB + PIDE do
   begin
     m_nTxMsg.m_sbyInfo[6 + (i - PIDB)*199] := i;
     it := FindValueFromCCDatasDT(VMID, i, TempDate, pTable);
     if it = -1 then
       FillChar(m_nTxMsg.m_sbyInfo[7 + (i - PIDB)*199], 198, 0)
     else
     begin
       move(pTable.Items[it].m_sbyMaskRead, m_nTxMsg.m_sbyInfo[6 + (i - PIDB)*199 + 193], 6);
       for j := 0 to 47 do
       begin
         fValue := 0;
         it := FindValueFromCCDatasDT(VMID, i, TempDate + EncodeTime(0, 30, 0, 0)*j, pTable);
         if it  <> - 1 then
           fValue := pTable.Items[it].m_sfValue;
         move(fValue, m_nTxMsg.m_sbyInfo[6 + (i - PIDB)*199 + 1 + j*4], 4);
       end;
     end;
   end;
   CreateMSG(pMsg, $FF08, 16 + (PIDE + 1)*199 , true, TempDate);
   CreateMSGHead(m_nTxMsg, 16 + (PIDE + 1)*199);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.FNCTranzKanal(var pMsg : CMessage);
var wTemp  : WORD;
    Kode   : BYTE;
    byPort : Word;
begin
   Kode := 0;
   wTemp       := pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7];                    //m_swVMID
   if (wMeterNum = wTemp) and (abs(dwLastTime - timeGetTime) < byTimeTranz) then //����� ���������� �� ���������
     Kode := 9;
   wMeterNum   :=  wTemp;
   byPort := GetRealPort(FindPortID(wMeterNum));
   //if m_sTblL1.Items[byPort].m_nFreePort=1 then SendPMSG(BOX_L1,byPort,DIR_L2TOL1,PH_RESET_PORT_IND);
   byTimeTranz := pMsg.m_sbyInfo[9];                                             //����� ����������
   dwLastTime  := timeGetTime;
   CreateMSG(pMsg, $00F8, 16, true, Now);
   m_nTxMsg.m_sbyInfo[6] := Kode;
   CRC(m_nTxMsg.m_sbyInfo[0], 14);
   CreateMSGHead(m_nTxMsg, 16);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.CreateCC301TranzReq(var pMsg : CMessage);
begin
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL4MD::>BTI CreateCC301TranzReq 0');
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL3MD::>Error In CBTIModule.FNCInit!!!');
   wMeterNum := pMsg.m_sbyInfo[14]*$100 + pMsg.m_sbyInfo[15];
   if FindPortID(wMeterNum) = High(word) then             //���� ����� �� ���������� ����. �����.
     exit;
   StartTranz301;
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL4MD::>BTI CreateCC301TranzReq 0');
   move(pMsg.m_sbyInfo[6], m_nTxMsg.m_sbyInfo[0], pMsg.m_swLen - 11 - 16 - 2);
   m_nTxMsg.m_swLen       := pMsg.m_swLen - 16 - 2;
   m_nTxMsg.m_swObjID     := m_sbyID;             //������� ����� ��������
   m_nTxMsg.m_sbyFrom     := DIR_L2TOL1;
   m_nTxMsg.m_sbyFor      := DIR_L2TOL1;         //DIR_L2toL1
   m_nTxMsg.m_sbyType     := PH_DATARD_REQ;      //PH_DATARD_REC
   m_nTxMsg.m_sbyIntID    := GetRealPort(FindPortID(wMeterNum));
   m_nTxMsg.m_sbyServerID := MET_SS301F3;          //������� ��� ��������
   m_nTxMsg.m_sbyDirID    := GetRealPort(FindPortID(wMeterNum));
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(2);
   blIsFNCFF1C := true;
   wTranzPID := m_nTxMsg.m_sbyIntID;
end;

procedure CBTIModule.CreateCloseTranzAns;
begin
   CreateMSG(m_nTxMsg, $FF1D, 16, true, Now);
   CreateMSGHead(m_nTxMsg, 16);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.SendMsgToMeter(var pMsg : CMessage); //�������� ��������� �������� � �������
begin
   if FindPortID(wMeterNum) = High(word) then             //���� ����� �� ���������� ����. �����.
     exit;
   StartTranz;
   m_sIsTranzOpen.m_sbIsTrasnBeg := true;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], pMsg.m_swLen - 11);
   m_nTxMsg.m_swLen       := pMsg.m_swLen;
   m_nTxMsg.m_swObjID     := m_sbyID;             //������� ����� ��������
   m_nTxMsg.m_sbyFrom     := DIR_L2TOL1;
   m_nTxMsg.m_sbyFor      := DIR_L2TOL1;         //DIR_L2toL1
   m_nTxMsg.m_sbyType     := PH_DATARD_REQ;      //PH_DATARD_REC
   m_nTxMsg.m_sbyIntID    := GetRealPort(FindPortID(wMeterNum));
   m_nTxMsg.m_sbyServerID := MET_SS301F3;          //������� ��� ��������
   m_nTxMsg.m_sbyDirID    := GetRealPort(FindPortID(wMeterNum));
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
   wTranzPID := m_nTxMsg.m_sbyIntID;
end;

procedure CBTIModule.SendCC301TranzAsnw(var pMsg : CMessage);
var Year, Month, Day,
    Hour, Min, Sec, ms       : word;
    CC301MsgLen              : integer;
begin
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL4MD::>BTI SendCC301TranzAsnw');
   DecodeDate(Now, Year, Month, Day);
   DecodeTime(Now, Hour, Min, Sec, ms);
   CC301MsgLen := pMsg.m_swLen - 11;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[6], CC301MsgLen);
   m_nTxMsg.m_sbyInfo[6 + CC301MsgLen]  := Year - 2000;
   m_nTxMsg.m_sbyInfo[7 + CC301MsgLen]  := Month;
   m_nTxMsg.m_sbyInfo[8 + CC301MsgLen]  := Day;
   m_nTxMsg.m_sbyInfo[9 + CC301MsgLen]  := Hour;
   m_nTxMsg.m_sbyInfo[10 + CC301MsgLen] := Min;
   m_nTxMsg.m_sbyInfo[11 + CC301MsgLen] := Sec;
   CreateMSG(pMsg, $FF1C, 16 + 6 + CC301MsgLen, true, Now);
   CreateMSGHead(m_nTxMsg, 16 + 6 + CC301MsgLen);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.SendTranzAns(var pMsg : CMessage);
begin
   FinishTranz;
   if blIsFNCFF1C then
   begin
     blIsFNCFF1C := false;
     SendCC301TranzAsnw(pMsg);
     exit;
   end;
   blIsFNCFF1C := false;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], pMsg.m_swLen - 11);
   CreateMSGHead(m_nTxMsg, pMsg.m_swLen-11);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CBTIModule.StartTranz;
Var
    pDS : CMessageData;
begin
   //TraceL(4, 0,'(__)CL4MD::>SS301:  : ������ ������ ������������. �������� ����� ����������');
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   m_nCF.SchedPause;
   //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
   m_sIsTranzOpen.m_sbIsTrasnBeg := true;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
end;
procedure CBTIModule.StartTranz301;
Var
    pDS : CMessageData;
begin
   //TraceL(4, 0,'(__)CL4MD::>SS301:  : ������ ������ ������������. �������� ����� ����������');
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   //m_nCF.SchedPause;
   //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
   //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
   m_sIsTranzOpen.m_sbIsTrasnBeg := true;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
end;

procedure CBTIModule.FinishTranz;
Var
    pDS : CMessageData;
begin
   m_nRepTimer.OffTimer;
   m_sIsTranzOpen.m_sbIsTrasnBeg := false;
   m_nCF.SchedGo;
   {
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
   }
end;

procedure CBTIModule.FNCReadCurrParam(var pMsg : CMessage);
var   Um, NU, LengthMSG, i      : word;
      WriteDate                 : TDateTime;
const MaskActPow = $0F; MaskReaPow = $F0;
      MaskVol = $07; MaskCur = $38; MaskFreq = $40;
begin
   Um  := (pMsg.m_sbyInfo[6]*$100 + pMsg.m_sbyInfo[7]) - 1;
   NU  := pMsg.m_sbyInfo[8]*$100 + pMsg.m_sbyInfo[9];
   i   := 0;
   WriteDate := Now;
   try
   if (pMsg.m_sbyInfo[12] and $0F) <> 0 then
     ReadCurrAktPow(i, pMsg.m_sbyInfo[12], Um, Um + NU - 1, WriteDate);
   if (pMsg.m_sbyInfo[12] and $F0) <> 0 then
     ReadCurrReaPow(i, pMsg.m_sbyInfo[12], Um, Um + NU - 1, WriteDate);
   if (pMsg.m_sbyInfo[14] and $07) <> 0 then
     ReadCurrVolt(i, pMsg.m_sbyInfo[14], Um, Um + NU - 1, WriteDate);
   if (pMsg.m_sbyInfo[14] and $38) <> 0 then
     ReadCurrCur(i, pMsg.m_sbyInfo[14], Um, Um + NU - 1, WriteDate);
   if (pMsg.m_sbyInfo[14] and $40) <> 0 then
     ReadCurrFreq(i, pMsg.m_sbyInfo[14], Um, Um + NU - 1, WriteDate);
   if (pMsg.m_sbyInfo[15] <> 0) then
     ReadCurrNakEn(i, Um, Um + NU - 1, WriteDate);
   if pMsg.m_sbyInfo[17] = 1 then
     ReadVzljotArch(i, Um, pMsg.m_sbyInfo[10]*$100 + pMsg.m_sbyInfo[11]);
   if pMsg.m_sbyInfo[17] = 2 then
     ReadKoefPower(i, Um, Um + NU - 1, WriteDate);
   if pMsg.m_sbyInfo[17] = 4 then
     Read3PowerEn(i, Um, Um + NU - 1, WriteDate);
   if pMsg.m_sbyInfo[17] = 5 then
     ReadPulsar(i, pMsg.m_sbyInfo[14], Um, Um + NU - 1, WriteDate);
   LengthMSG := 16 + 4*i;
   CreateMSG(pMsg, $00F1, LengthMSG, true, WriteDate);
   CreateMSGHead(m_nTxMSG, lengthMSG);
   FPUT(BOX_L1, @m_nTxMsg);
   except
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CBTIM::>Error In CBTIModule.FNCReadCurrParam!!!');
   end
end;

procedure CBTIModule.ReadCurrVolt(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
var DataCurr            : L3CURRENTDATAS;
    KindEn, i,MeterAdr  : integer;
    param               : single;
begin
   if m_pDDB.GetCurrTableForBTI(KB, KE, QRY_U_PARAM_S, DataCurr)=False then exit;
   for MeterAdr := KB to KE do
     for KindEn := 0 to 2 do
     begin
       param := 0;
       //if (byMask and __SetMask[i]) <> 0 then
       if (byMask and __SetMask[KindEn]) <> 0 then
         for i := 0 to DataCurr.Count - 1 do  
           if (DataCurr.Items[i].m_swVMID = MeterAdr) and (DataCurr.Items[i].m_swCMDID = QRY_U_PARAM_A + KindEn) then
           begin
             param := DataCurr.Items[i].m_sfValue;
             tDT   := DataCurr.Items[i].m_sTime;
             break;
           end;
       EncodeFormatBTIFloat(@param, @(m_nTxMsg.m_sbyInfo[6 + sm*4]));
       Inc(sm);
     end;
end;

procedure CBTIModule.ReadCurrCur(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
var DataCurr            : L3CURRENTDATAS;
    KindEn, i,MeterAdr  : integer;
    param               : single;
begin
   if m_pDDB.GetCurrTableForBTI(KB, KE, QRY_I_PARAM_S, DataCurr)=False then exit;
   for MeterAdr := KB to KE do
     for KindEn := 0 to 2 do
     begin
       param := 0;
       //if (byMask and __SetMask[i + 3]) <> 0 then
       if (byMask and __SetMask[KindEn + 3]) <> 0 then
         for i := 0 to DataCurr.Count - 1 do
           if (DataCurr.Items[i].m_swVMID = MeterAdr) and (DataCurr.Items[i].m_swCMDID = QRY_I_PARAM_A + KindEn) then
           begin
             param := DataCurr.Items[i].m_sfValue;
             tDT   := DataCurr.Items[i].m_sTime;
             break;
           end;
       EncodeFormatBTIFloat(@param, @(m_nTxMsg.m_sbyInfo[6 + sm*4]));
       Inc(sm);
     end;
end;

procedure CBTIModule.ReadKoefPower(var sm : word; KB, KE : word; var tDT : TDateTime);
var DataCurr            : L3CURRENTDATAS;
    KindEn, i,MeterAdr  : integer;
    param               : single;
begin
   if m_pDDB.GetCurrTableForBTI(KB, KE, QRY_KOEF_POW_A, DataCurr)=False then exit;
   for MeterAdr := KB to KE do
     for KindEn := 0 to 2 do
     begin
       param := 0;
       for i := 0 to DataCurr.Count - 1 do
         if (DataCurr.Items[i].m_swVMID = MeterAdr) and (DataCurr.Items[i].m_swCMDID = QRY_KOEF_POW_A + KindEn) then
         begin
           param := DataCurr.Items[i].m_sfValue;
           tDT   := DataCurr.Items[i].m_sTime;
           break;
         end;
       EncodeFormatBTIFloat(@param, @(m_nTxMsg.m_sbyInfo[6 + sm*4]));
       Inc(sm);
     end;
end;

procedure CBTIModule.Read3PowerEn(var sm : word; KB, KE : word; var tDT : TDateTime);
var DataCurr            : L3CURRENTDATAS;
    KindEn, i,MeterAdr  : integer;
    param               : single;
begin
   if m_pDDB.GetCurrTableForBTI(KB, KE, QRY_E3MIN_POW_EP, DataCurr)=False then exit;
   for MeterAdr := KB to KE do
     for KindEn := 0 to 3 do
     begin
       param := 0;
       for i := 0 to DataCurr.Count - 1 do
         if (DataCurr.Items[i].m_swVMID = MeterAdr) and (DataCurr.Items[i].m_swCMDID = QRY_E3MIN_POW_EP + KindEn) then
         begin
           param := DataCurr.Items[i].m_sfValue;
           tDT   := DataCurr.Items[i].m_sTime;
           break;
         end;
       EncodeFormatBTIFloat(@param, @(m_nTxMsg.m_sbyInfo[6 + sm*4]));
       Inc(sm);
     end;
end;

procedure CBTIModule.ReadCurrFreq(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
var DataCurr            : L3CURRENTDATAS;
    param               : single;
    MeterAdr            : word;
begin
   for MeterAdr := KB to KE do
   begin
     if m_pDDB.GetCurrentData(KB, QRY_FREQ_NET, DataCurr) then
     begin
       param := DataCurr.Items[0].m_sfValue;
       tDT   := DataCurr.Items[0].m_sTime;
     end
     else
       param := 0;
     EncodeFormatBTIFloat(@param, @(m_nTxMsg.m_sbyInfo[6 + sm*4]));
     Inc(sm);
   end;
end;

procedure CBTIModule.ReadCurrAktPow(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
var DataCurr                : L3CURRENTDATAS;
    KindEn, i,MeterAdr, KEn : integer;
    param                   : single;
begin
   if m_pDDB.GetCurrTableForBTI(KB, KE, QRY_MGAKT_POW_S, DataCurr)=False then exit;
   for MeterAdr := KB to KE do
     for KindEn := 0 to 3 do
     begin
       param := 0;
       if KindEn <> 3 then
         KEn := KindEn + 1
       else
         KEn := 0;
       //if (byMask and __SetMask[i + 3]) <> 0 then
       if (byMask and __SetMask[KindEn]) <> 0 then
         for i := 0 to DataCurr.Count - 1 do
           if (DataCurr.Items[i].m_swVMID = MeterAdr) and (DataCurr.Items[i].m_swCMDID = QRY_MGAKT_POW_S + KEn) then
           begin
             param := DataCurr.Items[i].m_sfValue;
             tDT   := DataCurr.Items[i].m_sTime;
             break;
           end;
       EncodeFormatBTIFloat(@param, @(m_nTxMsg.m_sbyInfo[6 + sm*4]));
       Inc(sm);
     end;
end;

procedure CBTIModule.ReadCurrReaPow(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
var DataCurr                : L3CURRENTDATAS;
    KindEn, i,MeterAdr, KEn : integer;
    param                   : single;
begin
   if m_pDDB.GetCurrTableForBTI(KB, KE, QRY_MGREA_POW_S, DataCurr)=False then exit;
   for MeterAdr := KB to KE do
     for KindEn := 0 to 3 do
     begin
       param := 0;
       if KindEn <> 3 then
         KEn := KindEn + 1
       else
         KEn := 0;
       //if (byMask and __SetMask[i + 3]) <> 0 then
       if (byMask and __SetMask[KindEn+4]) <> 0 then
         for i := 0 to DataCurr.Count - 1 do
           if (DataCurr.Items[i].m_swVMID = MeterAdr) and (DataCurr.Items[i].m_swCMDID = QRY_MGREA_POW_S + KEn) then
           begin
             param := DataCurr.Items[i].m_sfValue;
             tDT   := DataCurr.Items[i].m_sTime;
             break;
           end;
       EncodeFormatBTIFloat(@param, @(m_nTxMsg.m_sbyInfo[6 + sm*4]));
       Inc(sm);
     end;
end;

procedure CBTIModule.ReadCurrNakEn(var sm : word; KB, KE : word; var tDT : TDateTime);
var DataCurr                 : L3CURRENTDATAS;
    MeterAdr, tar, KindEN, i : integer;
    param                    : single;
begin
   if m_pDDB.GetTariffTableForBTI(KB, KE, DataCurr)=False then exit;
   for MeterAdr := KB to KE do
   begin
     for KindEn := 0 to 3 do
       for tar := 1 to 4 do
       begin
         param := 0;
         for i := 0 to DataCurr.Count - 1 do
           if (DataCurr.Items[i].m_swVMID = MeterAdr) and (DataCurr.Items[i].m_swCMDID = QRY_ENERGY_SUM_EP + KindEN)
              and (DataCurr.Items[i].m_swTID = tar) then
           begin
             param := (DataCurr.Items[i].m_sfValue);
             tDT   := DataCurr.Items[i].m_sTime;
             break;
           end;
         EncodeFormatBTIFloat(@param, @(m_nTxMsg.m_sbyInfo[6 + sm*4]));
         Inc(sm);
       end;
   end;
end;

procedure CBTIModule.ReadVzljotArch(var sm : word; MetAdr, Depth : integer);
var TempDate : TDateTime;
    i        : integer;
    pTable   : CCDatas;
    param    : single;
begin
  sm       := 0;
  TempDate := Now;
  for i := 0 to Depth - 1 do
    cDateTimeR.DecDate(TempDate);
  for i := QRY_POD_TRYB_HEAT to QRY_WORK_TIME_ERR  do
  begin
    m_pDDB.GetGData(TempDate, TempDate, MetAdr, i, 1, pTable);
    if pTable.Count = 0 then
      param := 0
    else
      param := pTable.Items[0].m_sfValue;
    move(param, m_nTxMsg.m_sbyInfo[6 + (i - QRY_POD_TRYB_HEAT)*4], 4);
    Inc(sm);
  end;
end;
procedure CBTIModule.ReadPulsar(var sm : word; byMask : byte; KB, KE : word; var tDT : TDateTime);
var DataCurr                : L3CURRENTDATAS;
    KindEn, i,MeterAdr, KEn : integer;
    param                   : single;
begin
   if m_pDDB.GetCurrTableForBTI(KB, KE, QRY_SUM_RASH_V, DataCurr)=False then exit;
   for MeterAdr := KB to KE do
     for KindEn := 0 to 3 do
     begin
       param := 0;
       if KindEn <> 3 then
         KEn := KindEn + 1
       else
         KEn := 0;
       //if (byMask and __SetMask[i + 3]) <> 0 then
       if (byMask and __SetMask[KindEn+4]) <> 0 then
         for i := 0 to DataCurr.Count - 1 do
           if (DataCurr.Items[i].m_swVMID = MeterAdr) and (DataCurr.Items[i].m_swCMDID = QRY_MGREA_POW_S + KEn) then
           begin
             param := DataCurr.Items[i].m_sfValue;
             tDT   := DataCurr.Items[i].m_sTime;
             break;
           end;
       EncodeFormatBTIFloat(@param, @(m_nTxMsg.m_sbyInfo[6 + sm*4]));
       Inc(sm);
     end;
end;
procedure CBTIModule.FNCCharGroup_TEST(var pMsg : CMessage);
var cntL, i, j, bm   : word;
begin
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::>!!!!!!!!!!!!!!BEGIN!!!!!!!!!!!!');
   cntL := (pMsg.m_swLen - 11 - 16) div 130;
   for i := 0 to cntL - 1 do
   begin
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::> GroupID = ' + IntToStr(i));
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::> KANALS IN GROUP: ');
      for j := 0 to 127 do
      begin
         for bm := 0 to 3 do
           if (bm and __SetMask[bm*2] = 1) then
              if (bm and __SetMask[bm*2 + 1] = 1 ) then
              begin
                if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::> KANAL: ' + IntToStr(j*4 + bm) + ' - ');
              end
              else
                if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::> KANAL: ' + IntToStr(j*4 + bm) + ' + ');
      end;
   end;
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::>!!!!!!!!!!!!END!!!!!!!!!!!!');
end;

procedure CBTIModule.FNCPrirDayGroup_TEST(var pMsg : CMessage);
var fParam       : single;
    cntL, i      : word;
begin
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::>!!!!!!!!!!!!!!BEGIN!!!!!!!!!!!!');
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::> PRIR DAY ');
   cntL := (pMsg.m_swLen - 11 - 16) div 4;
   for i := 0 to cntL - 1 do
   begin
     EncodeFormatBTIFloat(@fParam, @(pMsg.m_sbyInfo[i * 4 + 6]));
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::> TID = ' + IntToStr(i mod 4 + 1) + ' KindEn = ' +
                             Energ[i div 4] + ' Value = ' + DVLS(fParam));
   end;
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::>!!!!!!!!!!!!END!!!!!!!!!!!!');
end;

procedure CBTIModule.FNCPrirMonthGroup_TEST(var pMsg : CMessage);
var fParam       : single;
    cntL, i      : word;
begin
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::>!!!!!!!!!!!!!!BEGIN!!!!!!!!!!!!');
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::> PRIR DAY ');
   cntL := (pMsg.m_swLen - 11 - 16) div 4;
   for i := 0 to cntL - 1 do
   begin
     EncodeFormatBTIFloat(@fParam, @(pMsg.m_sbyInfo[i * 4 + 6]));
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::> TID = ' + IntToStr(i mod 4 + 1) + ' KindEn = ' +
                             Energ[i div 4] + ' Value = ' + DVLS(fParam));
   end;
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)BELTI_TEST::>!!!!!!!!!!!!END!!!!!!!!!!!!');
end;

procedure CBTIModule.FNCPrir30SrezGroup_TEST(var pMsg : CMessage);
begin

end;

procedure CBTIModule.FNCPrir30SrezDayGroup_TEST(var pMsg : CMessage);
begin

end;

procedure CBTIModule.UnknownFNC(var pMsg : CMessage);
begin
   CreateMSG(pMsg, pMsg.m_sbyInfo[5], 16, true, Now);
   m_nTxMsg.m_sbyInfo[6] := 3;
   CRC(m_nTxMsg.m_sbyInfo[0], 16 - 2);
   CreateMSGHead(m_nTxMsg, 16);
   FPUT(BOX_L1, @m_nTxMsg);
end;

function CBTIModule.LoHandler(var pMsg : CMessage):Boolean;
Var
    res     : Boolean;
    fnc     : word;
Begin
    res    := True;
    try                   
    blIsInternal := False;
    if pMsg.m_sbyType = QL_CONNCOMPL_REQ then
    begin
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL4MD::>Connect Complette');
     exit;
    end;
    if EventBox<>Nil then EventBox.FixMessage(ET_CRITICAL,'(__)CL4MD::>DebugInfo : byTeimTranz: ' + IntToStr(byTimeTranz) + '; abs(timeGetTime - dwLastTime):'  +
                               IntToStr(abs(timeGetTime - dwLastTime)) + ' '  , pMsg);
    if (pMsg.m_sbyInfo[4]*$100 + pMsg.m_sbyInfo[5] = $FF1C) and CRC(pMsg.m_sbyInfo[0], (Word(pMsg.m_sbyInfo[2]) shl 8)or(Word(pMsg.m_sbyInfo[3]))- 2) then
    begin
      if mBlAllowTranz then
        CreateCC301TranzReq(pMsg)
      else
        CreateCloseTranzAns;
      exit;
    end;
    if m_nRepTimer.IsProceed and m_sIsTranzOpen.m_sbIsTrasnBeg and (wTranzPID = pMsg.m_sbyIntID) then
    begin
      SendTranzAns(pMsg);
      exit;
    end;
    if (byTimeTranz > abs(timeGetTime - dwLastTime)/1000) then //���������� ������� ???
    begin
      dwLastTime := timeGetTime;
      SendMsgToMeter(pMsg);                             //�������� ��������� ��������
      exit;
    end;

    if not CRC(pMsg.m_sbyInfo[0], (Word(pMsg.m_sbyInfo[2]) shl 8)or(Word(pMsg.m_sbyInfo[3]))- 2) then
    begin
      if EventBox<>Nil then EventBox.FixMessage(ET_CRITICAL,'(__)CL4MD::>BTI CRC ERROR!!!:',pMsg);
      exit;
    end;

    if (mBlAllowTranz=False){and(m_sbyPortTypeID=DEV_TCP_SRV)} then
    Begin
       CreateCloseTranzAns;
       exit;
    End;
    fnc    := pMsg.m_sbyInfo[4]*$100 + pMsg.m_sbyInfo[5];
    blIsInternal := IsInternalMsg(pMsg);
    //if (m_schPhone<>'CLOSED') then  SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ);
    if (m_schPhone='GPRSHI') then  PauseSystem;
    case fnc of     
      $0000 : exit;
      $0001 : FNCTimeNow(pMsg);
      $0002 : FNCCorTime(pMsg);
      $0040 : FNCPrirDay(pMsg);
      $0041 : FNCPrirDayGroup(pMsg);
      $0042 : FNCPrirEnMonth(pMsg);
      $0043 : FNCPrirEnMonthGroup(pMsg);
      $0052 : FNC30SrezEnerg(pMsg);
      $0053 : FNC30SrezEnergGroup(pMsg);
      $0054 : FNC30SrezEnergDay(pMsg);
      $0055 : FNC30SrezEnergDayGroup(pMsg);
      $0080 : FNCEnMonth(pMsg);
      $0081 : FNCEnDay(pMsg);
      $00C0 : FNCReadJrnl(pMsg);
      $00D0 : FNCTypeYSPD(pMsg);
      $00D1 : FNCDeviceYSPD(pMsg);
      $00D2 : FNCCharYSPD(pMsg);
      $00D5 : FNCCharYSPDENSB(pMsg);
      $00D6 : FNCCharKanalYSPDENSB(pMsg);
      $00D3 : FNCCharKanalYSPD(pMsg);
      $00D4 : FNCCharGroupYSPD(pMsg);
      $00F1 : FNCReadCurrParam(pMsg);
      $00F8 : FNCTranzKanal(pMsg);
      $00A2 : FNCMaxDay(pMsg);
      $FF00 : FNCStartPool(pMsg);                            //��������� ������
      $FF01 : FNCStopPool(pMsg);                             //���������� ������
      $FF02 : FNCReadGraphFromMeters(pMsg);                  //��������� �������/������ �� ���������
      $FF03 : FNCReBoot(pMsg);                               //������������
      $FF04 : FNCReadEvents(pMsg);                           //����� �������
      $FF05 : FNCStopL3(pMsg);                               //������� L3
      $FF06 : FNCStartFH(pMsg);                              //������� L3
      $FF07 : FNCSetL2TM(pMsg);                              //��������� ����������� ��������� �������
      $FF08 : FNCReadCurrParams(pMsg);
      $FF09 : FNCReadJrnlEx(pMsg);
      $FF0A : FNCUnLoadHandler(pMsg);
      $FF0B : FNCUnLoadAck(pMsg);
      $FF0C : FNCPrirDayDbl(pMsg);
      $FF0D : FNCPrirEnMonthDbl(pMsg);
      $FF0E : FNC30SrezEnergDbl(pMsg);
      $FF0F : FNC30SrezEnergDayDbl(pMsg);
      $FF10 : FNCEnMonthDbl(pMsg);
      $FF11 : FNCEnDayDbl(pMsg);
      $FF12 : FNCSetSynchro(pMsg);                            //��������� ��������� �������������
      $FF13 : FNCDeepBuffer(pMsg);                            //��������� ������� ������ ���������� ����
      $FF14 : FNCBaseSize(pMsg);                              //��������� ������������� ������� ����
      $FF15 : FNCDeepData(pMsg);                              //��������� ������� �������� ������
      $FF16 : FNCClearData(pMsg);                             //��������  ������
      $FF17 : FNCExecSQL(pMsg);                               //���������� �������
      $FF18 : FNCInit(pMsg);                                  //�������������
      $FF19 : FNCDelArch(pMsg);                               //�������� �������
      $FF1A : FNCReadAllCurrParams(pMsg);                     //������ ���� ������� ���������� ����� ��������
      $FF1B : FNCReadMonitorParams(pMsg);
      $FF20 : FNCReadOneSliceEx(pMsg);
      $FF21 : RES_RASH_HOR_V(pMsg);
      $FF22 : RES_RASH_DAY_V(pMsg);
      $FF23 : RES_RASH_MON_V(pMsg);
      $FF24 : RES_CURR_RASH(pMsg);

      else
        UnknownFNC(pMsg);
    end;
    if EventBox<>Nil then EventBox.FixMessage(ET_CRITICAL,'(__)CL4MD::>BTI LOH:',pMsg);
    Result := res;
    except
    end;
End;

function CBTIModule.HiHandler(var pMsg : CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI HIH:',@pMsg);
    if pMsg.m_sbyType=QL_STOP_TRANS_REQ then
    begin
     if (m_schPhone='CLOSED') then
     Begin
      m_nTrOpenTimer.OnTimer(5*60);
      mBlAllowTranz := false;
      //TraceL(4,m_sbyPortID, '(__)L4BTI PORT:'+IntToStr(m_sbyPortID)+' CLOSED!');
     End;
     exit;
    end;
    if pMsg.m_sbyType=QL_START_TRANS_REQ then
    begin
     if (m_schPhone='CLOSED') then
     Begin
      m_nTrOpenTimer.OffTimer;
      mBlAllowTranz := true;
      //TraceL(4,m_sbyPortID, '(__)L4BTI PORT:'+IntToStr(m_sbyPortID)+' OPENED!');
     End;
     exit;
    end;
    Result := res;
End;

procedure CBTIModule.RunAuto;
Begin

End;
function  CBTIModule.CRC(var buf : array of byte; count : word):boolean;
var ind          : byte;
    CRCHi, CRCLo : byte;
    i            : integer;
begin
   CRCHi   := $FF;
   CRCLo   := $FF;
   Result  := true;
   if count>2900 then Begin Result:=False;exit;End;
   for i := 0 to count - 1 do
   begin
     ind  := CRCHi xor buf[i];
     CRCHi:= CRCLo xor srCRCHi[ind];
     CRCLo:= srCRCLo[ind];
   end;
   if (buf[count] <> CRCHi) or (buf[count+1] <> CRCLo) then
     Result := false;
   buf[count]   := CRCHi;
   buf[count+1] := CRCLo;
end;

function CBTIModule.GetRealPort(nPort:Integer):Integer;
Var
    i : Integer;
Begin
    Result := nPort;
    for i:=0 to m_sTblL1.Count-1 do
    Begin
     with m_sTblL1.Items[i] do
     Begin
      if m_sbyPortID=nPort then
      Begin
       Result := m_sbyPortID;
       if m_sblReaddres=1 then Result := m_swAddres;
       exit;
      End;
     End;
    End;
end;

end.
