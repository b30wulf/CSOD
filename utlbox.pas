unit utlbox;
{$define DEBUG_SPEED}
//{$define DEB_METROL}
interface
uses
  Windows, Classes, SysUtils,SyncObjs,stdctrls,Controls, Forms, Dialogs,comctrls,
  utltypes,Grids, BaseGrid, AdvGrid,utlconst,inifiles,AdvOfficeStatusBar,NB30,knsl5crypt;
type
    //Format::>Word,array[xxx] of byte;
    TCreateNode = procedure(Sender : TObject) of object;
    SL2KTM = packed record
      m_blEnable : Boolean;
      m_tmTime   : TDateTime;
    End;
    TVBase = packed record
     State        : Word;
     Messages     : Integer;
     wAmTI        : Word;
     wAmTS        : Word;
     blDirtyBit   : Boolean;
     nObject      : array of Integer;
     wState       : array of Word;
     tmChangeTime : array of TDateTime;
     tmDChangeTime : TDateTime;
    End;
    PVBase = ^TVBase;
    TVCommand = packed record
     blState     : Boolean;
     blValue     : Boolean;
     nValue      : Integer;
     tmDCommTime : TDateTime;
    End;
    CTBox = record
     pb_mBoxCont : array of Byte;
     w_mEvent    : THandle;
     sCS : TCriticalSection;
     w_mBoxWrite : DWord;
     w_mBoxRead  : DWord;
     w_mBoxSize  : DWord;
     w_mBoxCSize : DWord;
     w_mBoxMesCt : DWord;
     m_byIsEvent : Boolean;
     w_blSynchro : Boolean;
    End;
    procedure SetTexSB(byIndex:Byte;str:String);
    procedure Moves(pS,pD:Pointer;nLen:Integer);
    procedure FDEFINE(nIndex:Integer;w_lBoxSize:DWord;blSynch:Boolean);
    procedure FFDEFINE(nIndex:Integer;w_lBoxSize:DWord;w_lunBoxSize:DWord;blSynch:Boolean);
    function  FPUT(nIndex:Integer;pb_lInBox:Pointer):Integer;
    function  FPUT1(nIndex:Integer;pb_lInBox:Pointer):Integer;
    function  FGET(nIndex:Integer;pb_lInBox:Pointer):Integer;
    function  FGETEX(nIndex:Integer;pb_lInBox:Pointer):Integer;
    function  FPEEK(nIndex:Integer;pb_lInBox:Pointer):Integer;
    function  FCHECK(nIndex:Integer):Integer;
    function  FSIZE(nIndex:Integer):Dword;
    function  FABSSIZE(nIndex:Integer):Dword;
    function  FNABSSIZE(nIndex:Integer):Dword;
    procedure FDELETE(nIndex:Integer);
    procedure FFREE(nIndex:Integer);
    procedure FCLRSYN(nIndex:Integer);
    procedure FSETSYN(nIndex:Integer);
    procedure FSTOP(nIndex:Integer);
    procedure FSTART(nIndex:Integer);
    procedure FSET(nIndex:Integer);
    procedure FREM(nIndex:Integer);
    procedure FRES(nIndex:Integer);
    procedure FWAIT(nIndex:Integer);
    procedure FINIT;
    procedure SlepEx(nTime:Integer);
    //Define OpcBase

    procedure FDEFINE_VA(nDirID,nTI,nTS:Word);
    procedure FDELETE_VA(nDirID:Word);
    procedure FPUTTI_VA(nDirID,nTI:Word;ChangeTime:TDateTime;OPCState:Word;nValue:Integer);
    procedure FPUTTS_VA(nDirID,nTS:Word;ChangeTime:TDateTime;OPCState:Word;nValue:Integer);
    function  FGETTI_VA(nDirID,nTI:Word;var ChangeTime:TDateTime;var OPCState:Word):Integer;
    function  FGETTS_VA(nDirID,nTS:Word;var ChangeTime:TDateTime;var OPCState:Word):Integer;
    procedure FSETSTATE_VA(nDirID:Word;ChangeTime:TDateTime;OPCState:Byte);
    procedure FSETMSG_VA(nDirID:Word;ChangeTime:TDateTime;nMessages:Integer);
    function  FGETSTATE_VA(nDirID:Word):Word;
    function  FGETMSG_VA(nDirID:Word):Integer;
    procedure SendMsg(byBox:Integer;byIndex,byFor,byType:Byte);
    procedure SendPTMSG(byBox:Integer;byPort,byIndex,byFor,byType:Byte);
    procedure SendMsgData(byBox:Integer;byIndex:Integer;byFor,byType:Byte;var pDS:CMessageData);
    procedure SendMsgIData(byBox:Integer;byIndex:Integer;byInt,byFor,byType:Byte;var pDS:CMessageData);
    procedure SendData(byBox:Integer;byIndex:Integer;byFor,byType,nLen:Byte;pDS:Pointer);
    procedure SendPData(byBox:Integer;byIndex:Integer;byPIndex,byFor,byType,nLen:Byte;pDS:Pointer);
    procedure SendPMSG(byBox:Integer;byIndex,byFor,byType:Byte);
    procedure SendMsgLData(byBox,nVMID:Integer;byFor,byType,bySType:Byte;wLen:Word;ppMsg:Pointer);
    procedure SendRemMsg(var plMsg:CMessage);
    procedure SendRemSHMsg(byBox:Integer;byIndex:Integer;byFor,byType:Byte;var plMsg:CHMessage);
    procedure SendRMsg(var plMsg:CMessage);
    procedure SendRSMsg(plMsg:CHMessage);
    procedure SendRSMsgM(plMsg:CHMessage);
    function  FracEx(par : single; nIV : integer) : string;
    function  TVLS(fVal:Single;nT:integer):String;
    function  DVLSEx(fVal:Double; Koef:Double):String;
//    function  DVLSTF(_Value:Double; _TruncTo:Integer; _FracTo:Integer) : String;
//    function  DVLSTP(_Value:Double; _TruncTo:Integer) : Double;
    function  DVLEX(nPrecise:Integer;fVal:Double):String;
    function  DVLS(fVal:Double):String;
    function  DVLS5(fVal:Double):String;
    function  DVLS1(fVal:Double):String;
    function  RVL(fVal:Double):Double;
    function  RVLEx(fVal:Double; Koef:Double):Double;
    function  RVLPr(fVal:Double; Prec:Integer):Double;
    function  RVLPrStr(fVal:Double; Prec:Integer):String;

    function GetCMD(nCMD:Integer):String;
    function GetCMDFromName(strCMD:String):Integer;
    function GetCLSID(nCLSID:Integer):String;
    function GetVNAME(nVMID:Integer):String;
    function GetSRVNAME(nSRV:Integer):String;
    function GetCode(var nCode:Integer;var str:String):Boolean;
    function TarIndexGen(nPlane,nSZone,nTDay,nZone:Integer):Dword;
    function GetTMask(dtTime0,dtTime1:TDateTime):int64;
    function GetTAllMask(nPTID:Integer;var pTable:TM_TARIFFS):int64;
    function GetTar(nPTID:Integer;var pTable:TM_TARIFFS):TM_TARIFF;
    function GetMaxTZone(nTMask:int64;nTable:L3GRAPHDATAS):Double;
    function GetMaxTZoneMax(nTMask:int64;nTable:L3GRAPHDATAS;var time1:TDateTime):Double;
    function Get1Count(nMask: int64):integer;
    procedure ClearDMX(nAID,nVMID,nCmdID:Integer);
    procedure SendQSComm(snABOID,snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);
    procedure SendQSDataGEx(nCommand,snAID,snSRVID,snCLID,nCLSID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
    procedure SendQSCommGEx(snAID,snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);
    procedure ClearAbon(snAID,snSRVID,snPrmID:Integer);
    function DateTimeToStrCrypt(DateTime : TDateTime) : String;
    function StrToDateTimeCrypt(tstr : string) : TDateTime;
    function DecodeStrCrypt(const str: string): string;
    function EncodeStrCrypt(const str: string): string;
    function GetGrKoeffVal(num : integer) : double;
    function GetTrabVolt(num : integer) : double;
    function IsNan(const AValue: Double): Boolean;
    function IsInfinite(const AValue: Double): Boolean;
    function GetParceString(nID:Integer;sAdvDiscL2Tag:String):String;
    function GetCodeFromDep(strDepTag:String):Integer;

    procedure OnDisconnectAction;

    function CreateMSG(byBox:Integer;byIndex,byFor,byType:Byte):CHMessage;
    function CreateMSGD(byBox:Integer;byIndex,byFor,byType:Byte;var pDS:CMessageData):CHMessage;
    procedure CreateMSGDL(var pMsg:CMessage;byBox:Integer;byIndex,byFor,byType:Byte;var pDS:CMessageData);
    function FindClient(str:String):PSL4CONNTAG;
    function roundEx(fVal:extended):int64;
    function CalcCRCDB(pArray : PBYTEARRAY; len : integer):WORD;
    
    procedure SetByteMask(var sByteMask : int64; nSrez : byte);
    procedure RemByteMask(var sByteMask : int64; nSrez : byte);
    function  IsBitInMask(sByteMask : int64; nSrez : byte) : boolean;
    function  FindMax(var Arr : array of Integer; Size : integer) : byte;
    function  FileVersion(AFileName: string): string;

    procedure CreateMSGHeadCrcRem(byPortID:Byte;var pMsg : CHMessage; length : word);
    procedure CreateMSGHeadCrcRem_0(byPortID:Byte;var pMsg : CMessage; length : word);
    procedure CreateLMSGHeadCrcRem(byPortID:Byte;var pMsg : CMessage; length : word);
    procedure CreateMSGHeadCrcL(byPortID:Byte;var pMsg:CMessage;length:word);
    procedure CreateMSGCrcRem(var buffer : array of byte; length : word; fnc : word);
    function  CRCRem(var buf : array of byte; count : word):boolean;
    Function  CRCEco(var buf : Array Of byte; count : integer) : word;
    function  CRC_C12(var _Buff : array of BYTE; _Count : Integer) : Boolean;
    function IsCurrent(nCmdID:Integer):Boolean;
    function GetAdapterInfo(Lana: Char;var byBuffer:array of Byte): string;
    function GetMACAddress(var byBuffer:array of Byte): string;
    procedure GetL2AdvStructFromStr(str: string; var pTable: SL2TAGADVSTRUCT);
    function  GetL2AdrFromRead(str: string):integer;
    procedure GetIntArrayFromStr(var str : string; var buf : array of integer);
    function GetVMName(nVMID:Integer):String;
    function GetMTName(nMID:Integer):String;
    function SendTrace(_Type : Integer; _Message : String) : Boolean;
    function IsDb(nSH : Integer):Boolean;
    procedure saveSetBaseProp;
    procedure saveRemBaseProp;
    function getSaveBaseProp:integer;
    function getSaveBasePropPath(stpPath:String): integer;

Var
    mC : CCrypt = nil;
    w_mSleepEvent   : THandle;
    //m_nOutState     : TStringList = nil;
    //m_nInState      : TStringList = nil;
    m_nTypeProt     : TStringList = nil;
    m_nDataGroup    : TStringList = nil;
    m_nNetMode      : TStringList = nil;
    m_nSaveList     : TStringList = nil;
    m_nActiveList   : TStringList = nil;
    m_nActiveExList : TStringList = nil;
    m_nMeterLocation: TStringList = nil;
    m_nStatusList   : TStringList = nil;
    m_nCmdDirect    : TStringList = nil;
    m_nCommandList  : TStringList = nil;
    m_nParamList    : TStringList = nil;
    m_nPTariffList  : TStringList = nil;
    m_nMeterList    : TStringList = nil;

    m_nSpeedList    : TStringList = nil;
    m_nParityList   : TStringList = nil;
    m_nDataList     : TStringList = nil;
    m_nStopList     : TStringList = nil;

    m_nSpeedListA    : TStringList = nil;
    m_nParityListA   : TStringList = nil;
    m_nDataListA     : TStringList = nil;
    m_nStopListA     : TStringList = nil;

    m_nPortTypeList : TStringList = nil;
    m_nSvPeriodList : TStringList = nil;
    m_nEsNoList     : TStringList = nil;
    m_nJrnlN1       : TStringList = nil;
    m_nJrnlN2       : TStringList = nil;
    m_nJrnlN3       : TStringList = nil;
    m_nJrnlN4       : TStringList = nil;
    m_nUserLayer    : TStringList = nil;
    m_nStateProc    : TStringList = nil;
    m_nTestName     : TStringList = nil;
    m_nWorkDay      : TStringList = nil;
    m_nKTRout       : TStringList = nil;
    m_nDataType     : TStringList = nil;
    m_nMeterName    : TStringList = nil;
    m_nSrvName      : TStringList = nil;
    //m_nNameMeters   : String;

    FTreeEditor     : PTTreeView;
    //m_pDS           : CGDataSource;
    m_nParams       : QM_PARAMS;
    pHiBuff         : array[0..MAX_METER_PLUS]  of CTBox;
    m_blChngIndex   : array[0..MAX_CHNG]  of Boolean;
    m_blPortIndex   : array[0..MAX_PORT]  of Boolean;
    m_blMeterIndex  : array[0..MAX_METER] of Boolean;
    m_blGprsIndex   : array[0..MAX_GPRS] of Boolean;
    m_blMTypeIndex  : array[0..50]  of Boolean;
    m_blPTypeIndex  : array[0..200] of Boolean;
    m_blTarTypeIndex  : array[0..30,0..5,0..10,0..30] of Boolean;
    m_blTPlaneIndex   : array[0..50] of Boolean;
    m_blConnTypeIndex : array[0..50] of Boolean;
    m_blSznTypeIndex  : array[0..50] of Boolean;
    m_blTransIndex    : array[0..50] of Boolean;


    m_blGroupIndex  : array[0..MAX_GROUP]  of Boolean;
    m_blVMeterIndex : array[0..MAX_VMETER] of Boolean;
    m_blUserIndex   : array[0..100] of Boolean;
    m_blAbonIndex   : array[0..100] of Boolean;
    m_blRegionIndex : array[0..MAX_REGION] of Boolean;
    m_blQServer     : array[0..MAX_QSERVER] of Boolean;
    m_blQCell       : array[0..MAX_QWCELL] of Boolean;

    //m_pB          : PTOpcBase;
    m_pVirtualBase  : array[0..1] of PVBase;
    strSB           : array[0..10] of String;
    m_strL2SelNode  : String;
    m_strL3SelNode  : String;
    m_strCurrUser   : String;
    m_csOut         : TCriticalSection = nil;
    FStatBar        : TAdvOfficeStatusBar;
    w_mGEvent       : THandle;
    w_mTcpEvent     : THandle;
    m_nMasterPort0  : Integer;
    m_nCurrentConnection : Integer;
    m_blIsLocal     : Boolean;
    m_blIsRemCrc    : Boolean;
    m_blIsRemEco    : Boolean;
    m_blIsRemC12    : Boolean;
    m_blIsSlave     : Boolean;
    m_blIsConnect   : Boolean;
    m_blIsEEnergo   : Boolean;
    m_dwIN          : DWord;
    m_dwOut         : DWord;
    m_nValue        : integer;
    m_nPrecise      : integer; //точность после запятой показания
    m_nPreciseExpense : integer; //точность после запятой расход
    m_nOnAutorization : integer;//Запуск после перепрограммирования
    m_nReStartEvent : integer;
    m_nSynchronize  : integer;
    m_blConnectST   : Boolean;
    m_sCurrentUser  : String;
    m_blNoCheckPass : Boolean;
    m_blMinimized   : Boolean;
    m_sL4ConTag     : SL4CONNTAGS;
    m_nEV           : array[0..3] of SEVENTSETTTAGS;
    gsCS            : TCriticalSection = nil;
    m_blGridDataFontColor : Integer;
    m_blGridDataFontSize  : Integer;
    m_blGridDataFontName  : String;
    nSizeFont:integer;
    ReportFormCrete:boolean;
    m_blIsBackUp    : Boolean;
    //m_blGridDataClick     : boolean;
    m_sIsTranzOpen  : SENRGOTELCOM;
    m_nL4Synchronize: integer;
    m_nL2Synchronize: integer;
    m_nWPollTime    : integer;
    m_blIsalc       : Byte;
    m_blHandInit    : Boolean;
    m_nCtrPort      : SCTRPORT;
    MeterPrecision  : array [0..MAX_METER] of Integer;
    MaxPrecision    : byte;
    m_blIsTest      : Boolean;
    m_nFatalError   : Dword;
    m_nCurrReport   : Byte;
    //Состояния редакторов
    m_blCL2ArchEditor     : Boolean;
    m_blCL2DataEditor     : Boolean;
    m_blCL2ParEditor      : Boolean;
    m_blCL2QmCEditor      : Boolean;
    m_blCL2QmEditor       : Boolean;
    m_blCL2ChannEditor    : Boolean;
    m_blCL2PullsDsEditor  : Boolean;
    m_blCL2PullsPlEditor  : Boolean;
    m_blCL2MetrEditor     : Boolean;
    m_blCL2ScenEditor     : Boolean;
    m_blCL3GroupEditor    : Boolean;
    m_blCL3VMetEditor     : Boolean;
    m_blCL3VParEditor     : Boolean;
    m_blCL3SznEditor      : Boolean;
    m_blCL3SznTDayEditor  : Boolean;
    m_blCL3TarPlaneEditor : Boolean;
    m_blCL3TarTypeEditor  : Boolean;
    m_blCL3TariffEditor   : Boolean;
    m_blTransTimeEditor   : Boolean;
    m_blShedlEditor       : Boolean;
    m_blCL3AbonEditor     : Boolean;
    m_blCL3ChngEditor     : Boolean;
    m_blCL3ChngDTEditor   : Boolean;
    m_blCL3RegiEditor     : Boolean;
    //
    m_dwSort              : Dword;
    m_dwTree              : Dword;
    m_nStopL3             : Byte;
    m_nStateLr            : Byte;
    m_nIsServer           : Byte;
    m_nDataFinder         : Boolean;
    m_nPauseCM            : Boolean;
    m_nQweryTime          : Integer;
    DBAddFieldEn          : Integer;
    m_nMaxSpaceDB         : Integer;
    m_nIsRam              : Byte;
    m_nUpdateTime         : Integer;
    m_nMaxKorrTime        : Integer;
    m_nIsOneSynchro       : Byte;
    m_nMaxDayNetParam     : Integer;
    m_nTimeCluster        : String;
    m_nIsTimeSV           : Byte;
    m_nTimeDlt            : Integer;
    m_nSmartFinder        : Byte;
    m_nQweryReboot        : Byte;
    m_nInterSpeed         : Byte;
    m_nUpdateFunction     : Byte;
    m_blMDMPrep           : Byte;
    m_nCheckPins          : Byte;
    m_nWDTTime            : Integer;
    m_nTimeToBan          : Integer;
    m_nAutoKorrDay        : Integer;
    m_nLastCorrTime       : TDateTime;
    m_byCoverState        : Byte;
    m_nCountOfEvents      : Integer;
    m_nIsUspd             : Byte;
    m_nLockMeter             : Byte;
    m_nIsLightControl     : Byte;
    m_byNSCompare         : Byte;
    m_stTimeBSave         : TDateTime;
    m_byEvents            : Byte;

    m_nCtrlPortID         : Integer;
    m_nCtrlObjID          : Integer;
    m_nIsInitOk           : Boolean;
    m_dwDB                : Dword;

    m_strMDMPrep          : String;
    m_strMDReset          : String;
    m_strExePath          : String;
    blAutoKorr            : Boolean;
    m_sVMName             : SL3VMNAMETAGS;
    m_sMTName             : SL3VMNAMETAGS;
    killToken             : threadKillToken;

    m_nMSynchKorr : SL2KTM;
    m_dtTime1 : TDateTime;
    m_dtTime2 : TDateTime;
    TarTable  : TM_TARIFFSS;
    m_nLightInfo : SL3LIGHTSTRUCT;
const
  c_PrecMult : array[0..6] of Integer = (1, 10, 100, 1000, 10000, 100000, 1000000);
implementation

procedure SlepEx(nTime:Integer);
Begin
    WaitForSingleObject(w_mSleepEvent,nTime);
End;
procedure FINIT;
Begin
    mC := CCrypt.Create;
    mC.Init;
    gsCS:=TCriticalSection.Create;
    w_mGEvent    := CreateEvent(nil, False, False, nil);
    w_mSleepEvent:= CreateEvent(nil, False, False, nil);
End;

function FindClient(str:String):PSL4CONNTAG;
Var
    i : Integer;
Begin
    for i:=0 to m_sL4ConTag.Count-1 do
    Begin
     if m_sL4ConTag.Items[i].m_schPhone=str then
     Begin
      Result := @m_sL4ConTag.Items[i];
      Exit;
     End;
    End;
    Result := Nil;
End;
function FracEx(par : single; nIV : integer) : string;
begin
   Result := IntToStr(abs(round(Frac(par)*nIV)));
   while Length(Result) < m_nPrecise do
     Result := Result + '0';
end;

{**
 * Форматирование с отчечкой
 * @var _Value:Double Значение
 * @var _TruncTo:Integer Множитель отчечки (1, 10, 100, 1000 и т.д.)
 * @var _FracTo:Integer Количество знаковпосле запятой в результате
 * @return String Результат в текстовой форме
 *
function DVLSTF(_Value:Double; _TruncTo:Integer; _FracTo:Integer) : String;
begin
  Result := FloatToStrF(DVLSTP(_Value, _TruncTo), ffFixed, 18, _FracTo);
end;

{**
 * Форматирование с отчечкой
 * @var _Value:Double Значение
 * @var _TruncTo:Integer Количество знаков после запятой для отсечки
 * @return Double Результат в текстовой форме
 *
function DVLSTP(_Value:Double; _TruncTo:Integer) : Double;
var
  l_M : Integer;
begin
  if (0 < _TruncTo) and (_TruncTo < 7) then
    Result := Trunc(_Value*c_PrecMult[_TruncTo])/c_PrecMult[_TruncTo]
  else
    Result := Trunc(_Value);
end;
}

function DVLSEx(fVal:Double; Koef:Double):String;
begin
   if round(Koef) = 1 then
     Result := DVLS1(fVal)
   else
     Result := DVLS(fVal);
end;

function DVLS(fVal:Double):String;
Var                           
    nIV     : Integer;
Begin
    case m_nPrecise of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;
    if fVal=0 then Result := '0' else
    Begin
     if m_nPrecise<>0 then
     Result := FloatToStr(Int(fVal)+roundEx(Frac(fVal)*nIV)/nIV) else
     Result := IntToStr(trunc(fVal));
    End;
End;
function  DVLS1(fVal:Double):String;
Var
    nIV     : Integer;
Begin
    {
    case m_nPrecise of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;
    }
    nIV := 10;
    //if m_nPrecise<>0 then Result := IntToStr(trunc(fVal))+'.'+{IntToStr(trunc(Frac(fVal)*nIV))}FracEx(abs(fVal), nIV) else
    //              Result := IntToStr(trunc(fVal));
   //if m_nPrecise<>0 then Result := IntToStr(trunc(fVal))+'.'+IntToStr(round(Frac(fVa  al)*nIV)) else
   //              Result := IntToStr(trunc(fVal));

     Result := FloatToStr(trunc(fVal)+roundEx(Frac(fVal)*nIV)/nIV);
     //Result := IntToStr(trunc(fVal));
End;
function DVLS5(fVal:Double):String;
Var
    nIV        : Integer;
    nPrecise   : Integer;
Begin
    nPrecise := 5;
    case nPrecise of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;
    if fVal=0 then Result := '0' else
    Begin
     if nPrecise<>0 then
     Result := FloatToStr(Int(fVal)+roundEx(Frac(fVal)*nIV)/nIV) else
     Result := IntToStr(trunc(fVal));
    End;
End;
function DVLEX(nPrecise:Integer;fVal:Double):String;
Var
    nIV     : Integer;
Begin
    {case nPrecise of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;} nIV := 10000;
    if fVal=0 then Result := '0' else
    Begin
     if nPrecise>0 then
     Result := FloatToStr(Int(fVal)+roundEx(Frac(fVal)*nIV)/nIV) else
     Result := IntToStr(trunc(fVal));
    End;
End;
function  RVLEx(fVal:Double; Koef:Double):Double;
var nIV : integer;
begin
  if Koef = 1 then
    nIV := 10
  else
    case m_nPrecise of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    end;
    //nIV := 100000;
  {$IFNDEF DEB_METROL}
    if m_nPrecise<>0 then
    Result := Int(fVal)+roundEx(Frac(fVal)*nIV)/nIV else
    Result := Int(fVal);
    {$ELSE}
    Result := fVal;
    {$ENDIF}
end;
function RVL(fVal:Double):Double;
Var
    nIV     : Integer;
Begin
    case m_nPrecise of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;
    {$IFNDEF DEB_METROL}
    if m_nPrecise<>0 then
    Result := Int(fVal)+roundEx(Frac(fVal)*nIV)/nIV else
    Result := Int(fVal);
    {$ELSE}
    Result := fVal;
    {$ENDIF}
End;

function RVLPr(fVal:Double; Prec:Integer):Double;
Var
    nIV     : Integer;
Begin
    case Prec of
     0 : nIV := 1;
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;
    {$IFNDEF DEB_METROL}
    if Prec<>0 then
    Result := Int(fVal)+roundEx(Frac(fVal)*nIV)/nIV else
    Result := Int(fVal);
    {$ELSE}
    Result := fVal;
    {$ENDIF}
end;

function RVLPrStr(fVal:Double; Prec:Integer):String;
begin
   Result := FloatToStr(RVLPr(fVal, Prec));
end;

function TVLS(fVal:Single;nT:integer):String;
Var
    nIV     : Integer;
Begin
    case nT of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;
    if nT<>0 then Result := IntToStr(trunc(fVal))+'.'+IntToStr(abs(trunc(Frac(fVal)*nIV))) else
                  Result := IntToStr(trunc(fVal));
End;
procedure FDEFINE(nIndex:Integer;w_lBoxSize:DWord;blSynch:Boolean);
Begin
   try
    with pHiBuff[nIndex] do
    begin
    if sCS=Nil then
    Begin
     sCS:=TCriticalSection.Create;
     SetLength(pb_mBoxCont,w_lBoxSize+3000);
     w_mEvent    := CreateEvent(nil, False, False, nil);
     w_mBoxSize  := w_lBoxSize;
     w_mBoxCSize := w_lBoxSize;
     w_mBoxWrite := 0;
     w_mBoxRead  := 0;
     w_mBoxMesCt := 0;
     w_blSynchro := blSynch;
     m_byIsEvent := False;
     ResetEvent(w_mEvent);
    end;
    end;
   except
    //if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_VZEP TASK KILLED!!!');
   end;
End;
procedure FFDEFINE(nIndex:Integer;w_lBoxSize:DWord;w_lunBoxSize:DWord;blSynch:Boolean);
Begin
    with pHiBuff[nIndex] do
    begin
    if sCS=Nil then
    Begin
     if w_lunBoxSize=0 then w_lunBoxSize:=3000;
     sCS:=TCriticalSection.Create;
     SetLength(pb_mBoxCont,w_lBoxSize+w_lunBoxSize);
     w_mEvent    := CreateEvent(nil, False, False, nil);
     w_mBoxSize  := w_lBoxSize;
     w_mBoxCSize := w_lBoxSize;
     w_mBoxWrite := 0;
     w_mBoxRead  := 0;
     w_mBoxMesCt := 0;
     w_blSynchro := blSynch;
     m_byIsEvent := False;
     ResetEvent(w_mEvent);
    end;
    end;
End;
procedure FFREE(nIndex:Integer);
Begin
    with pHiBuff[nIndex] do
    begin
    w_mBoxSize  := w_mBoxCSize;
    w_mBoxWrite := 0;
    w_mBoxRead  := 0;
    w_mBoxMesCt := 0;
    m_byIsEvent := False;
    ResetEvent(w_mEvent);
    //EventBox.FixEvents(ET_CRITICAL,'Переполнение:'+IntToStr(nIndex));
    End;
End;
function FPUT(nIndex:Integer;pb_lInBox:Pointer):Integer;
Var
    w_lLength:Word;
Begin
   Result := 0;
   try
    gsCS.Enter;
    if pHiBuff[nIndex].sCS=Nil then exit;
    with pHiBuff[nIndex] do
    begin
     Move(pb_lInBox^,w_lLength,2);
     if (w_lLength>w_mBoxSize) or (w_lLength<2) then Begin result:=0;FFREE(nIndex);{SendTrace(ET_CRITICAL,'Переполнение:'+IntToStr(nIndex))};Exit; End;
     Move(pb_lInBox^,pb_mBoxCont[w_mBoxWrite],w_lLength);
     w_mBoxWrite := w_mBoxWrite + w_lLength;
     w_mBoxSize  := w_mBoxSize  - w_lLength;
     w_mBoxMesCt := w_mBoxMesCt + 1;
     if(w_mBoxWrite>w_mBoxCSize) then w_mBoxWrite := 0;
     if w_blSynchro=True then SetEvent(w_mEvent);
    result := 1;
    End;
    finally
      gsCS.Leave;
    end;
End;
function FGET(nIndex:Integer;pb_lInBox:Pointer):Integer;
Var
    wLng:Word;
Begin
    try
    //gsCS.Enter;
    with pHiBuff[nIndex] do
    begin
    if w_blSynchro then WaitForSingleObject(w_mEvent,INFINITE);
     Move(pb_mBoxCont[w_mBoxRead],wLng,2);
     //if wLng=0 then Begin gsCS.Leave;result:=0;FFREE(nIndex);Exit;End;
     Move(pb_mBoxCont[w_mBoxRead],pb_lInBox^,wLng);
     w_mBoxRead  := w_mBoxRead + wLng;
     w_mBoxSize  := w_mBoxSize + wLng;
     w_mBoxMesCt := w_mBoxMesCt - 1;
     if(w_mBoxRead>w_mBoxCSize) then w_mBoxRead := 0;
     if w_mBoxMesCt=0 then ResetEvent(w_mEvent) else SetEvent(w_mEvent);
    result := wLng;
    End;
    finally
     //gsCS.Leave;
    end;
End;
function FGETEX(nIndex:Integer;pb_lInBox:Pointer):Integer;
Var
    wLng:Word;
Begin
    with pHiBuff[nIndex] do
    begin
    if w_blSynchro then WaitForSingleObject(w_mEvent,INFINITE);
    gsCS.Enter;
     Move(pb_mBoxCont[w_mBoxRead],wLng,2);
     Move(pb_mBoxCont[w_mBoxRead],pb_lInBox^,wLng);
     w_mBoxRead  := w_mBoxRead + wLng;
     //w_mBoxSize  := w_mBoxSize + wLng;
     //w_mBoxMesCt := w_mBoxMesCt - 1;
     if(w_mBoxRead>w_mBoxCSize) then w_mBoxRead := 0;
     if w_mBoxMesCt=0 then ResetEvent(w_mEvent) else SetEvent(w_mEvent);
    gsCS.Leave;
    result := wLng;
    End;
End;
procedure FSET(nIndex:Integer);
Begin
   with pHiBuff[nIndex] do
   if(w_blSynchro=True) then
   Begin
   if (w_mBoxMesCt<>0)and(m_byIsEvent=False) Then
   Begin
    SetEvent(w_mEvent);
    //m_byIsEvent := True;
   End else
   if(w_mBoxMesCt=0) then FRES(nIndex);
   End;
End;
procedure FREM(nIndex:Integer);
Begin
   with pHiBuff[nIndex] do
   if(w_mBoxMesCt<>0) then m_byIsEvent := False else m_byIsEvent := True;
End;
procedure FRES(nIndex:Integer);
Begin
   with pHiBuff[nIndex] do
   Begin
    m_byIsEvent := True;;
    ReSetEvent(w_mEvent);
   End;
End;
procedure FWAIT(nIndex:Integer);
Begin
   with pHiBuff[nIndex] do
   if w_blSynchro then WaitForSingleObject(w_mEvent,INFINITE);
End;

procedure Moves(pS,pD:Pointer;nLen:Integer);
Var
    pSB,pDB : PByteArray;
    i : Integer;
Begin
    pSB := pS;
    pDB := pD;
    for i:=0 to nLen-1 do pDB[i]:=pSB[i];
End;
function FPUT1(nIndex:Integer;pb_lInBox:Pointer):Integer;
Var
    w_lLength:Word;
Begin
   Result := 0;
    //pHiBuff[nIndex].sCS.Enter;
    //pHiBuff[nIndex].w_mBoxSize := pHiBuff[nIndex].w_mBoxSize;
    //sCS.Enter;
    if pHiBuff[nIndex].sCS=Nil then exit;
    with pHiBuff[nIndex] do
    begin
    sCS.Enter;
    Move(pb_lInBox^,w_lLength,2);
    if (w_lLength>w_mBoxSize) or (w_lLength<2) then
    Begin
     result:=0;
     //SendDebug('Free Buffer.');
     //SetEvent(w_mEvent);
     FFREE(nIndex);
     sCS.Leave;
     Exit;
    End;
    Move(pb_lInBox^,pb_mBoxCont[w_mBoxWrite],w_lLength);
    w_mBoxWrite := w_mBoxWrite + w_lLength;
    w_mBoxSize  := w_mBoxSize  - w_lLength;
    w_mBoxMesCt := w_mBoxMesCt + 1;
    if(w_mBoxWrite>w_mBoxCSize) then w_mBoxWrite := 0;
    //if w_blSynchro then WaitForSingleObject(w_mGEvent,1);
    sCS.Leave;
    if w_blSynchro then
     if w_mBoxMesCt=1 then
     Begin
      SetEvent(w_mEvent);
     End;
    result := 1;
    End;
    if pHiBuff[nIndex].w_blSynchro then WaitForSingleObject(w_mGEvent,1);
End;
function FPEEK(nIndex:Integer;pb_lInBox:Pointer):Integer;
Var
    w_lLength:Word;
Begin
    with pHiBuff[nIndex] do
    begin
    sCS.Enter;
    Move(pb_lInBox^,w_lLength,2);
    if(w_mBoxRead-w_lLength)<=0 then Begin FPUT(nIndex,pb_lInBox);sCS.Leave;result := 0;exit;End;
    w_mBoxRead  := w_mBoxRead - w_lLength;
    w_mBoxSize  := w_mBoxSize - w_lLength;
    w_mBoxMesCt := w_mBoxMesCt + 1;
    Move(pb_lInBox^,pb_mBoxCont[w_mBoxRead],w_lLength);
    SetEvent(w_mEvent);
    sCS.Leave;
    result := 1;
    End;
End;
procedure FCLRSYN(nIndex:Integer);
Begin
    pHiBuff[nIndex].w_blSynchro := False;
End;
procedure FSETSYN(nIndex:Integer);
Begin
    pHiBuff[nIndex].w_blSynchro := True;
    FSTART(nIndex);
End;
procedure FSTOP(nIndex:Integer);
Begin
    ReSetEvent(pHiBuff[nIndex].w_mEvent);
End;
procedure FSTART(nIndex:Integer);
Begin
    if(pHiBuff[nIndex].w_mBoxMesCt<>0) then
    SetEvent(pHiBuff[nIndex].w_mEvent);
End;
function FCHECK(nIndex:Integer):Integer;
Begin
    result := pHiBuff[nIndex].w_mBoxMesCt;
End;
function FSIZE(nIndex:Integer):Dword;
Begin
    result := pHiBuff[nIndex].w_mBoxSize;
End;
function FABSSIZE(nIndex:Integer):Dword;
Var
    d0,d1:Double;
Begin
    with pHiBuff[nIndex] do
    Begin
     d0 := w_mBoxSize;
     d1 := w_mBoxCSize;
     result := round(100*d0/d1);
    End;
End;
function FNABSSIZE(nIndex:Integer):Dword;
Begin
    result := 100-FABSSIZE(nIndex);
End;
procedure FDELETE(nIndex:Integer);
Begin
    with pHiBuff[nIndex] do
    if sCS <> nil then
      FreeAndNil(sCS);
End;

//VBase For Opc Interface
procedure FDEFINE_VA(nDirID,nTI,nTS:Word);
Var
    i : Integer;
Begin
    if(Assigned(m_pVirtualBase[nDirID])=False) then
    Begin
    New(m_pVirtualBase[nDirID]);
    with m_pVirtualBase[nDirID]^ do
    Begin
     wAmTI        := nTI;
     wAmTS        := nTS;
     blDirtyBit   := False;
     tmDChangeTime := Now;
     SetLength(tmChangeTime ,wAmTI+wAmTS);
     SetLength(wState ,wAmTI+wAmTS);
     SetLength(nObject,wAmTI+wAmTS);
     for i:=0 to (wAmTI+wAmTS-1) do
     Begin
       tmChangeTime[i] := Now;
       wState[i]       := $C0;
       nObject[i]      := 0;
     end;
    End;
    End;
End;
procedure FDELETE_VA(nDirID:Word);
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     SetLength(m_pVirtualBase[nDirID]^.wState ,0);
     SetLength(m_pVirtualBase[nDirID]^.nObject,0);
     Dispose(m_pVirtualBase[nDirID]);
    End;
End;
procedure FPUTTI_VA(nDirID,nTI:Word;ChangeTime:TDateTime;OPCState:Word;nValue:Integer);
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     with m_pVirtualBase[nDirID]^ do
     Begin
      if (nTI<=(wAmTI+wAmTS)) then
      Begin
       nObject[nTI]      := nValue;
       wState[nTI]       := OPCState;
       blDirtyBit        := True;
       tmChangeTime[nTI] := ChangeTime;
       State             := OPCState;
      End;
     End;
    End;
End;
procedure FPUTTS_VA(nDirID,nTS:Word;ChangeTime:TDateTime;OPCState:Word;nValue:Integer);
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     with m_pVirtualBase[nDirID]^ do
     Begin
      if (nTS<=wAmTS) then
      Begin
       nObject[wAmTI+nTS]      := nValue;
       wState[wAmTI+nTS]       := OPCState;
       blDirtyBit              := True;
       tmChangeTime[wAmTI+nTS] := ChangeTime;
       State                   := OPCState;
      End;
     End;
    End;
End;
function FGETTI_VA(nDirID,nTI:Word;var ChangeTime:TDateTime;var OPCState:Word):Integer;
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     with m_pVirtualBase[nDirID]^ do
     Begin
      if (nTI<=(wAmTI+wAmTS)) then
      Begin
       blDirtyBit := True;
       ChangeTime := tmChangeTime[nTI];
       OPCState   := wState[nTI];
       Result     := nObject[nTI];
       exit;
      End;
     End;
    End;
    Result := -1;
End;
function FGETTS_VA(nDirID,nTS:Word;var ChangeTime:TDateTime;var OPCState:Word):Integer;
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     with m_pVirtualBase[nDirID]^ do
     Begin
      if (nTS<=wAmTS) then
      Begin
       blDirtyBit := True;
       ChangeTime := tmChangeTime[wAmTI+nTS];
       OPCState   := wState[wAmTI+nTS];
       Result     := nObject[wAmTI+nTS];
       exit;
      End;
     End;
    End;
    Result := -1;
End;
procedure FSETSTATE_VA(nDirID:Word;ChangeTime:TDateTime;OPCState:Byte);
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     m_pVirtualBase[nDirID]^.tmDChangeTime := ChangeTime;
     m_pVirtualBase[nDirID]^.State        := OPCState;
    End;
End;
procedure FSETMSG_VA(nDirID:Word;ChangeTime:TDateTime;nMessages:Integer);
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     m_pVirtualBase[nDirID]^.tmDChangeTime := ChangeTime;
     m_pVirtualBase[nDirID]^.Messages      := nMessages;
    End;
End;
function FGETSTATE_VA(nDirID:Word):Word;
Begin
    Result := 0;
    if(Assigned(m_pVirtualBase[nDirID])) then
    Result := m_pVirtualBase[nDirID]^.State;
End;
function FGETMSG_VA(nDirID:Word):Integer;
Begin
    Result := 0;
    if(Assigned(m_pVirtualBase[nDirID])) then
    Result := m_pVirtualBase[nDirID]^.Messages;
End;
procedure SendRMsg(var plMsg:CMessage);
Var
    pMsg : CMessage;
    i    : Integer;
Begin
    for i:=0 to m_nCtrPort.Count-1 do Begin
    With pMsg do
    Begin
     m_swLen       := 13+plMsg.m_swLen;
     m_swObjID     := 0;
     m_sbyFrom     := DIR_LMETOL1;
     m_sbyFor      := DIR_LMETOL1;
     m_sbyType     := PH_DATARD_REQ;
     m_sbyTypeIntID:= 0;
     //m_sbyIntID    := m_nMasterPort0;
     m_sbyIntID    := m_nCtrPort.Items[i];
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
    end;
    Move(plMsg,pMsg.m_sbyInfo[0],plMsg.m_swLen);
    //if m_nCtrPort.SType[i]=
    FPUT(BOX_L1,@pMsg);
    End;
End;
procedure SendRSMsg(plMsg:CHMessage);
Var
    pMsg : CMessage;
    i    : Integer;
Begin
    for i:=0 to m_nCtrPort.Count-1 do Begin
    With pMsg do
    Begin
     m_swLen       := 13+plMsg.m_swLen;
     m_swObjID     := 0;
     m_sbyFrom     := DIR_LMETOL1;
     m_sbyFor      := DIR_LMETOL1;
     m_sbyType     := PH_DATARD_REQ;
     m_sbyTypeIntID:= 0;
     //m_sbyIntID    := m_nMasterPort0;
     m_sbyIntID    := m_nCtrPort.Items[i];
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
    end;
    Move(plMsg,pMsg.m_sbyInfo[0],plMsg.m_swLen);
    FPUT(BOX_L1,@pMsg);
    End;
End;
procedure SendRSMsgM(plMsg:CHMessage);
Var
    pMsg : CMessage;
    i    : Integer;
Begin
    for i:=0 to m_nCtrPort.Count-1 do Begin
    With pMsg do
    Begin
     m_swLen       := 13+plMsg.m_swLen;
     m_swObjID     := 0;
     m_sbyFrom     := DIR_LMETOL1;
     m_sbyFor      := DIR_LMETOL1;
     m_sbyType     := PH_DATARD_REQ;
     m_sbyTypeIntID:= 0;
     //m_sbyIntID    := m_nMasterPort0;
     m_sbyIntID    := m_nCtrPort.Items[i];
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
    end;
    Move(plMsg,pMsg.m_sbyInfo[0],plMsg.m_swLen);
    if m_nCtrPort.SType[i]=SND_MASTER then
    FPUT(BOX_L1,@pMsg);
    End;
End;
procedure SendRemMsg(var plMsg:CMessage);
Var
    pMsg : CMessage;
    i    : Integer;
Begin
    for i:=0 to m_nCtrPort.Count-1 do Begin
    With pMsg do
    Begin
     m_swLen       := 13+plMsg.m_swLen;
     m_swObjID     := 0;
     m_sbyFrom     := DIR_LMETOL1;
     m_sbyFor      := DIR_LMETOL1;
     m_sbyType     := PH_DATARD_REQ;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := m_nCtrPort.Items[i];
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
    End;
    Move(plMsg,pMsg.m_sbyInfo[0],plMsg.m_swLen);
    FPUT(BOX_L1,@pMsg);
    End;
End;
procedure SendRemSHMsg(byBox:Integer;byIndex:Integer;byFor,byType:Byte;var plMsg:CHMessage);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
     m_swLen       := 13+plMsg.m_swLen;
     m_swObjID     := 0;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := byIndex;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
    end;
    Move(plMsg,pMsg.m_sbyInfo[0],plMsg.m_swLen);
    FPUT(byBox,@pMsg);
End;
procedure SendMSG(byBox:Integer;byIndex,byFor,byType:Byte);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 13;
    m_swObjID     := byIndex;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := byIndex;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    end;
    FPUT(byBox,@pMsg);
End;
procedure SendPTMSG(byBox:Integer;byPort,byIndex,byFor,byType:Byte);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 13;
    m_swObjID     := byIndex;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := byPort;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    end;
    FPUT(byBox,@pMsg);
End;
function CreateMSG(byBox:Integer;byIndex,byFor,byType:Byte):CHMessage;
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 13;
    m_swObjID     := byIndex;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := 0;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    end;
    //FPUT(byBox,@pMsg);
    Result := pMsg;
End;
function CreateMSGD(byBox:Integer;byIndex,byFor,byType:Byte;var pDS:CMessageData):CHMessage;
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 13;
    m_swObjID     := byIndex;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := 0;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    Move(pDS,m_sbyInfo[0],sizeof(pDS));
    m_swLen       := 13 + sizeof(pDS);
    end;
    Result := pMsg;
End;
procedure CreateMSGDL(var pMsg:CMessage;byBox:Integer;byIndex,byFor,byType:Byte;var pDS:CMessageData);
Begin
    With pMsg do
    Begin
     m_swObjID     := byIndex;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := 0;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     Move(pDS,m_sbyInfo[0],sizeof(pDS));
     m_swLen       := 13 + sizeof(pDS);
    end;
End;
procedure SendPMSG(byBox:Integer;byIndex,byFor,byType:Byte);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 13;
    m_swObjID     := 0;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := byIndex;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    end;
    FPUT(byBox,@pMsg);
End;
procedure SendMsgLData(byBox,nVMID:Integer;byFor,byType,bySType:Byte;wLen:Word;ppMsg:Pointer);
Var
    pMsg : CMessage;
Begin
    With pMsg do
    Begin
     m_swObjID     := nVMID;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= bySType;
     m_sbyIntID    := 0;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     Move(ppMsg^,m_sbyInfo[0],wLen);
     m_swLen       := 13 + wLen;
    end;
    FPUT(byBox,@pMsg);
End;
procedure SendMsgData(byBox:Integer;byIndex:Integer;byFor,byType:Byte;var pDS:CMessageData);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
     m_swObjID     := byIndex;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := 0;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     Move(pDS,m_sbyInfo[0],sizeof(pDS));
     m_swLen       := 13 + sizeof(pDS);
    end;
    FPUT(byBox,@pMsg);
End;
procedure SendMsgIData(byBox:Integer;byIndex:Integer;byInt,byFor,byType:Byte;var pDS:CMessageData);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
     m_swObjID     := byIndex;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := byInt;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     Move(pDS,m_sbyInfo[0],sizeof(pDS));
     m_swLen       := 13 + sizeof(pDS);
    end;
    FPUT(byBox,@pMsg);
End;
procedure SendData(byBox:Integer;byIndex:Integer;byFor,byType,nLen:Byte;pDS:Pointer);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
     m_swObjID     := byIndex;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := 0;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     Move(pDS^,m_sbyInfo[0],nLen);
     m_swLen       := 13 + nLen;
    end;
    FPUT(byBox,@pMsg);
End;
procedure SendPData(byBox:Integer;byIndex:Integer;byPIndex,byFor,byType,nLen:Byte;pDS:Pointer);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
     m_swObjID     := byIndex;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := byPIndex;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     Move(pDS^,m_sbyInfo[0],nLen);
     m_swLen       := 13 + nLen;
    end;
    FPUT(byBox,@pMsg);
End;
procedure OnDisconnectAction;
Var
    pDS : CMessageData;
Begin
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
End;
procedure SetTexSB(byIndex:Byte;str:String);
Begin
    strSB[byIndex] := str;
    FStatBar.Invalidate;
    {
    if byIndex=0 then
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,str);
    }
End;
function roundEx(fVal:extended):int64;
var
   fr : extended;
begin
   try
   Result:=0;
   fr := abs(Frac(fVal)) - 0.5;//Alex_2012
   if fr < -0.00000001 then
     Result := trunc(fVal)
   else
   Begin
     if fVal<0  then Result := trunc(fVal) - 1;
     if fVal>=0 then Result := trunc(fVal) + 1;
   End;
   except
     Result:=0;
   end;
end;
function CalcCRCDB(pArray : PBYTEARRAY; len : integer):WORD;
var
    CRChiEl             : byte;
    CRCloEl             : byte;
    i                   : integer;
    cmp                 : byte;
    idx                 : byte;
begin
    CRChiEl := $FF;
    CRCloEl := $FF;
    for i:=0 to len - 1 do
    begin
     idx       := (CRChiEl Xor pArray[i]) And $FF;
     CRChiEl   := (CRCloEl Xor CRCHI[idx]);
  //   CRCloEl   := CRCLO[        ];
    end;
    Result := (CRChiEl shl 8) + CRCloEl;
end;

procedure SetByteMask(var sByteMask : int64; nSrez : byte);
var
//    ByteSet, BitSet : byte;
//    pArray          : PBYTEARRAY;
    sBI : int64;
begin
   //pArray  := @sByteMask;
   //ByteSet := nSrez div 8;
   //BitSet  := nSrez mod 8;
   //pArray[ByteSet] := pArray[ByteSet] or __SetMask[BitSet];
   sBI := 1;
   sByteMask := sByteMask or (sBI shl nSrez);
end;
procedure RemByteMask(var sByteMask : int64; nSrez : byte);
var
//    ByteSet, BitSet : byte;
//    pArray          : PBYTEARRAY;
    sBI : int64;
begin
   //pArray  := @sByteMask;
   //ByteSet := nSrez div 8;
   //BitSet  := nSrez mod 8;
   //pArray[ByteSet] := pArray[ByteSet] or __SetMask[BitSet];
   sBI := 1;
   sByteMask := sByteMask and (not (sBI shl nSrez));
end;

function IsBitInMask(sByteMask : int64; nSrez : byte) : boolean;
var
//    ByteSet, BitSet : byte;
//    pArray          : PBYTEARRAY;
   sBI : int64;
begin
   //pArray  := @sByteMask;
   //ByteSet := nSrez div 8;
   //BitSet  := nSrez mod 8;
   //if (pArray[ByteSet] and __SetMask[BitSet]) <> 0 then
   //  Result := true
   //else
   //  Result := false;
   sBI := 1;
   Result := (sByteMask and (sBI shl nSrez))<>0;
end;

function  FindMax(var Arr : array of Integer; Size : integer) : byte;
var i : integer;
begin
  if Size = 0 then
  begin
    Result := 0;
    exit;
  end;
  Result := Arr[0];
  for i := 1 to Size - 1 do
    if Result < Arr[i] then
      Result := Arr[i];
end;

function FileVersion(AFileName: string): string;
var
  szName: array[0..255] of Char;
  P: Pointer;
  Value: Pointer;
  Len: UINT;
  GetTranslationString: string;
  FFileName: PChar;
  FValid: boolean;
  FSize: DWORD;
  FHandle: DWORD;
  FBuffer: PChar;
begin
  try
    FFileName := StrPCopy(StrAlloc(Length(AFileName) + 1), AFileName);
    FValid := False;
    FSize := GetFileVersionInfoSize(FFileName, FHandle);
    if FSize > 0 then
    try
      GetMem(FBuffer, FSize);
      FValid := GetFileVersionInfo(FFileName, FHandle, FSize, FBuffer);
    except
      FValid := False;
      raise;
    end;
    Result := '';
    if FValid then
      VerQueryValue(FBuffer, '\VarFileInfo\Translation', p, Len)
    else
      p := nil;
    if P <> nil then
      GetTranslationString := IntToHex(MakeLong(HiWord(Longint(P^)),
        LoWord(Longint(P^))), 8);
    if FValid then
    begin
      StrPCopy(szName, '\StringFileInfo\' + GetTranslationString +
        '\FileVersion');
      if VerQueryValue(FBuffer, szName, Value, Len) then
        Result := StrPas(PChar(Value));
    end;
  finally
    try
      if FBuffer <> nil then
        FreeMem(FBuffer, FSize);
    except
    end;
    try
      StrDispose(FFileName);
    except
    end;
  end;
end;
procedure CreateMSGHeadCrcL(byPortID:Byte;var pMsg:CMessage;length:word);
begin
   pMsg.m_swLen         := length + 13;
   pMsg.m_swObjID       := 0;
   pMsg.m_sbyFrom       := DIR_BTITOL1;
   pMsg.m_sbyFor        := DIR_BTITOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := byPortID;
   pMsg.m_sbyIntID      := byPortID;
   pMsg.m_sbyServerID   := HIP_BTI;
   pMsg.m_sbyDirID      := 0;
   pMsg.m_sbyServerID   := 0;
end;
procedure CreateMSGHeadCrcRem_0(byPortID:Byte;var pMsg : CMessage; length : word);
begin

   pMsg.m_swLen         := length + 13;
   pMsg.m_swObjID       := m_nCtrlObjID;
   pMsg.m_sbyFrom       := DIR_BTITOL1;
   pMsg.m_sbyFor        := DIR_BTITOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nCtrlPortID;
   pMsg.m_sbyIntID      := byPortID;
   pMsg.m_sbyServerID   := HIP_BTI;
   pMsg.m_sbyDirID      := 0;
   pMsg.m_sbyServerID   := 0;

   {
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := 0;
   pMsg.m_sbyFrom       := DIR_BTITOL1;
   pMsg.m_sbyFor        := DIR_L1TOL2;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := byPortID;
   pMsg.m_sbyIntID      := byPortID;
   pMsg.m_sbyServerID   := HIP_BTI;
   pMsg.m_sbyDirID      := 0;
   pMsg.m_sbyServerID   := 0;
   }
end;
procedure CreateMSGHeadCrcRem(byPortID:Byte;var pMsg : CHMessage; length : word);
begin

   pMsg.m_swLen         := length + 13;
   pMsg.m_swObjID       := m_nCtrlObjID;
   pMsg.m_sbyFrom       := DIR_BTITOL1;
   pMsg.m_sbyFor        := DIR_BTITOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nCtrlPortID;
   pMsg.m_sbyIntID      := m_nCtrlPortID;
   pMsg.m_sbyServerID   := HIP_BTI;
   pMsg.m_sbyDirID      := 0;
   pMsg.m_sbyServerID   := 0;

   {
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := 0;
   pMsg.m_sbyFrom       := DIR_BTITOL1;
   pMsg.m_sbyFor        := DIR_L1TOL2;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := byPortID;
   pMsg.m_sbyIntID      := byPortID;
   pMsg.m_sbyServerID   := HIP_BTI;
   pMsg.m_sbyDirID      := 0;
   pMsg.m_sbyServerID   := 0;
   }
end;
procedure CreateLMSGHeadCrcRem(byPortID:Byte;var pMsg : CMessage; length : word);
begin

   pMsg.m_swLen         := length + 13;
   pMsg.m_swObjID       := 0;
   pMsg.m_sbyFrom       := DIR_BTITOL1;
   pMsg.m_sbyFor        := DIR_BTITOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := byPortID;
   pMsg.m_sbyIntID      := byPortID;
   pMsg.m_sbyServerID   := HIP_BTI;
   pMsg.m_sbyDirID      := 0;
   pMsg.m_sbyServerID   := 0;

   {
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := 0;
   pMsg.m_sbyFrom       := DIR_BTITOL1;
   pMsg.m_sbyFor        := DIR_L1TOL2;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := byPortID;
   pMsg.m_sbyIntID      := byPortID;
   pMsg.m_sbyServerID   := HIP_BTI;
   pMsg.m_sbyDirID      := 0;
   pMsg.m_sbyServerID   := 0;
   }
end;
procedure CreateMSGCrcRem(var buffer : array of byte; length : word; fnc : word);
Var
   OldCodeHi,OldCodeLo,Addr:Byte;
begin
   Addr               := 1;
   buffer[0]          := $55;
   buffer[1]          := Addr or $80;                //Adr YSPD
   buffer[2]          := length div $100;
   buffer[3]          := length mod $100;
   buffer[4]          := fnc div $100;
   buffer[5]          := fnc mod $100;
   buffer[length - 4] := 0;  //random(255);    //CODE HI
   OldCodeHi          := buffer[length - 4];
   buffer[length - 3] := 12; //random(255);    //CODE LO
   OldCodeLo          := buffer[length - 3];
   CRCRem(buffer, length - 2);
end;
function  CRCRem(var buf : array of byte; count : word):boolean;
var
   i                 : integer;
   CRCHi, CRCLo, ind : byte;
begin
   CRCHi   := $FF;
   CRCLo   := $FF;
   Result  := true;
   for i := 0 to count - 1 do
   begin
     ind:= CRCHi xor buf[i];
     CRCHi:= CRCLo xor srCRCHi[ind];
     CRCLo:= srCRCLo[ind];
   end;
   if (buf[count] <> CRCHi) and (buf[count] <> CRCLo) then
     Result := false;
   buf[count]   := CRCHi;
   buf[count+1] := CRCLo;
end;
Function CRCEco(var buf : Array Of byte; count : integer) : word;
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
End;
function CRC_C12(var _Buff : array of BYTE; _Count : Integer) : Boolean;
var
    i       : integer;
    CRCHi,
    CRCLo,
    ind     : byte;
begin
    Result  := true;
    CRCHi   := $FF;
    CRCLo   := $FF;

    for i := 0 to _Count - 3 do
    begin
        ind:= CRCHi xor _Buff[i];
        CRCHi:= CRCLo xor srCRCHi[ind];
        CRCLo:= srCRCLo[ind];
    end;

    if (_Buff[_Count - 2] <> CRCLo) and (_Buff[_Count - 1] <> CRCHi) then
        Result := false;

    _Buff[_Count - 2] := CRCLo;
    _Buff[_Count - 1] := CRCHi;
end;


function IsCurrent(nCmdID:Integer):Boolean;
Begin
     Result:=False;
     case nCmdID of
       QRY_ENERGY_SUM_EP  :   Result:=True;//= 38;
       QRY_MGAKT_POW_S    :   Result:=True;//= 38;
       QRY_MGREA_POW_S    :   Result:=True;//= 38;
       QRY_U_PARAM_A      :   Result:=True;//= 38;
       QRY_I_PARAM_A      :   Result:=True;//= 38;
       QRY_FREQ_NET       :   Result:=True;//= 38;
       QRY_KOEF_POW_A     :   Result:=True;//= 38;
       QRY_DATA_TIME      :   Result:=True;//= 38;
     End;
End;
function GetAdapterInfo(Lana: Char;var byBuffer:array of Byte): string;
var
  Adapter: TAdapterStatus;
  NCB: TNCB;
begin
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBRESET);
  NCB.ncb_lana_num := Lana;
  if Netbios(@NCB) <> Char(NRC_GOODRET) then
  begin
    Result := 'mac not found';
    Exit;
  end;

  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBASTAT);
  NCB.ncb_lana_num := Lana;
  NCB.ncb_callname := '*';

  FillChar(Adapter, SizeOf(Adapter), 0);
  NCB.ncb_buffer := @Adapter;
  NCB.ncb_length := SizeOf(Adapter);
  if Netbios(@NCB) <> Char(NRC_GOODRET) then
  begin
    Result := 'mac not found';
    Exit;
  end;
  //byArray[] :=
  Move(Adapter.adapter_address[0],byBuffer[0],6);
  Result :=
  IntToHex(Byte(Adapter.adapter_address[0]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[1]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[2]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[3]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[4]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[5]), 2);
end;

function GetMACAddress(var byBuffer:array of Byte): string;
var
  AdapterList: TLanaEnum;
  NCB: TNCB;
begin
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBENUM);
  NCB.ncb_buffer := @AdapterList;
  NCB.ncb_length := SizeOf(AdapterList);
  Netbios(@NCB);
  if Byte(AdapterList.length) > 0 then
    Result := GetAdapterInfo(AdapterList.lana[0],byBuffer)
  else
    Result := 'mac not found';
end;

procedure GetL2AdvStructFromStr(str: string; var pTable: SL2TAGADVSTRUCT);
var i, j  : integer;
    ts    : string;
begin
   pTable.m_sKoncFubNum  := '';
   pTable.m_sKoncPassw   := '';
   pTable.m_sKoncRazName := '';
   pTable.m_sKoncRazNumb := '';
   pTable.m_sKoncNumTar  := '';
   pTable.m_sNaprVvoda   := '';
   pTable.m_sTypeTI      := '';
   pTable.m_sTypeTU      := '';
   pTable.m_sDateInst    := trunc(Now);
   j  := 0;
   ts := '';
   for i := 1 to Length(str) do
   begin
     if str[i] = ';' then
     begin
       case j of
         0 : begin pTable.m_sKoncFubNum   := ts; j := j + 1; end;
         1 : begin pTable.m_sKoncPassw    := ts; j := j + 1; end;
         2 : begin pTable.m_sKoncRazName  := ts; j := j + 1; end;
         3 : begin pTable.m_sKoncRazNumb  := ts; j := j + 1; end;
         4 : begin pTable.m_sKoncNumTar   := ts; j := j + 1; end;
         5 : begin pTable.m_sNaprVvoda    := ts; j := j + 1; end;
         6 : begin pTable.m_sTypeTI       := ts; j := j + 1; end;
         7 : begin pTable.m_sTypeTU       := ts; j := j + 1; end;
         8 : begin pTable.m_sDateInst     := StrToDate(ts); j := j + 1; end;
       end;
       ts := '';
       continue;
     end;
     ts := ts + str[i];
   end;
end;

function GetL2AdrFromRead(str: string):integer;
var i, j   : integer;
    ts     : string;
    pTable : SL2TAGADVSTRUCT;
begin
   pTable.m_sKoncFubNum  := '';
   pTable.m_sKoncPassw   := '';
   pTable.m_sKoncRazName := '';
   pTable.m_sKoncRazNumb := '';
   pTable.m_sKoncNumTar  := '';
   pTable.m_sNaprVvoda   := '';
   pTable.m_sTypeTI      := '';
   pTable.m_sTypeTU      := '';
   pTable.m_sDateInst    := trunc(Now);
   j  := 0;
   ts := '';
   for i := 1 to Length(str) do
   begin
     if str[i] = ';' then
     begin
       case j of
         0 : begin pTable.m_sKoncFubNum   := ts; j := j + 1; end;
         1 : begin pTable.m_sKoncPassw    := ts; j := j + 1; end;
         2 : begin pTable.m_sKoncRazName  := ts; j := j + 1; end;
         3 : begin pTable.m_sKoncRazNumb  := ts; j := j + 1; end;
         4 : begin pTable.m_sKoncNumTar   := ts; j := j + 1; end;
         5 : begin pTable.m_sNaprVvoda    := ts; j := j + 1; end;
         6 : begin pTable.m_sTypeTI       := ts; j := j + 1; end;
         7 : begin pTable.m_sTypeTU       := ts; j := j + 1; end;
         8 : begin pTable.m_sDateInst     := StrToDate(ts); j := j + 1; end;
       end;
       ts := '';
       continue;
     end;
     ts := ts + str[i];
   end;
   Result := StrToIntDef(pTable.m_sKoncRazName, -1);
end;

function GetCMD(nCMD:Integer):String;
Begin
   Result := 'Неизвестный параметр';
   if nCMD<m_nCommandList.Count then
   Result := m_nCommandList.Strings[nCMD];
End;
function GetCMDFromName(strCMD:String):Integer;
Begin
   Result := m_nCommandList.IndexOf(strCMD);
End;
function GetCLSID(nCLSID:Integer):String;
Begin
   Result := 'Неизвестный параметр';
   if nCLSID<m_nSvPeriodList.Count then
   Result := m_nSvPeriodList.Strings[nCLSID];
End;
function GetVNAME(nVMID:Integer):String;
Begin
   Result := 'Неизвестный параметр';
   if nVMID<m_nMeterName.Count then
   Result := m_nMeterName.Strings[nVMID];
End;
function GetSRVNAME(nSRV:Integer):String;
Begin
   Result := 'Неизвестный параметр';
   if nSRV<m_nSrvName.Count then
   Result := m_nSrvName.Strings[nSRV];
End;
procedure GetIntArrayFromStr(var str : string; var buf : array of integer);
var i, Ind, yk   : Integer;
    tstr         : string;
begin
   tstr := '';
   yk   := 0;
   for i := 1 to Length(str) do
   begin
     if str[i] = ',' then
       if (tstr <> '') then
       begin
         Ind  := StrToInt(tstr);
         buf[yk] := Ind;
         yk := yk + 1;
         tstr := '';
       end;
     if ((str[i] >= '0') and (str[i] <= '9')) or (str[i] = '-') then
       tstr := tstr + str[i];
   end;
   if (tstr <> '') then
   begin
     Ind  := StrToInt(tstr);
     buf[yk] := Ind;
     tstr := '';
     yk := yk + 1;
   end;
   for i := yk to Length(buf) - 1 do
     buf[i] := -100;
end;
function GetCode(var nCode:Integer;var str:String):Boolean;
Var
     nPos : Integer;
     strF : String;
Begin
     try
     nPos := Pos(',',str);
     nCode := 0;
     if nPos<>0 then
     Begin
      strF := Copy(str,0,nPos-1);
      Delete(str,1,nPos);
      nCode := StrToInt(strF);
      Result := True;
     End else Result := False;
     except
       Result := False;
     end;
End;
function  TarIndexGen(nPlane,nSZone,nTDay,nZone:Integer):Dword;
Begin
    Result := (nPlane shl 24)+(nSZone shl 16)+(nTDay shl 8)+nZone;
End;
function GetTMask(dtTime0,dtTime1:TDateTime):int64;
var
    nMask,nSH : int64;
    i,nB,nE : Integer;
Begin
    nMask := 0;
    nSH   := 1;
    i     := 0;
    nB := trunc(dtTime0/EncodeTime(0,30,0,0));
    nE := round(dtTime1/EncodeTime(0,30,0,0));
    if dtTime1=0 then nE := 48;
    for i:=nB to nE-1 do
    Begin
     nMask := nMask or (nSH shl i);
     //EventBox.FixEvents(ET_RELEASE,' i:'+IntToStr(i)+' M:'+IntToHex(nMask,8));
    End;
    Result := nMask;
End;
function GetTAllMask(nPTID:Integer;var pTable:TM_TARIFFS):int64;
var
    nMask : int64;
    i : Integer;
Begin
    nMask := 0;
    for i:=0 to pTable.Count-1 do
    if nPTID=pTable.Items[i].m_swPTID then
    with pTable.Items[i] do
    Begin
     if frac(m_dtTime0)>frac(m_dtTime1) then
     Begin
      nMask := nMask or GetTMask(frac(m_dtTime0),0);
      nMask := nMask or GetTMask(frac(EncodeTime(0,0,0,0)),frac(m_dtTime1));
     End else
      nMask := nMask or GetTMask(frac(m_dtTime0),frac(m_dtTime1));
    End;
    Result := nMask;
End;
function GetTar(nPTID:Integer;var pTable:TM_TARIFFS):TM_TARIFF;
var
    i : Integer;
Begin
    Result.m_swID:=-1;
    for i:=0 to pTable.Count-1 do
    if nPTID=pTable.Items[i].m_swPTID then
    Result := pTable.Items[i];
End;

function  GetMaxTZone(nTMask:int64;nTable:L3GRAPHDATAS):Double;
Var
    i,j : Integer;
    dbValue : Double;
    nSH : int64;
Begin
    dbValue := 0;
    nSH     := 1;
    if nTMask=0 then Begin Result:=0;exit;End;
    for i:=0 to nTable.Count-1 do
    for j:=0 to 48-1 do
    Begin
     if (nTMask and (nSH shl j))<>0 then
     Begin
      if nTable.Items[i].v[j]>=dbValue then
      dbValue := nTable.Items[i].v[j];
     End;
    End;
    Result := dbValue;
End;

function GetMaxTZoneMax(nTMask:int64;nTable:L3GRAPHDATAS;var time1:TDateTime):Double;
Var
    i,j,j1 : Integer;
    dbValue : Double;
    nSH : int64;
    stime: TDateTime;
Begin
    j1:=0;
    stime:=Now;
    dbValue := 0;
    nSH     := 1;
    if nTMask=0 then Begin Result:=0;exit;End;
    for i:=0 to nTable.Count-1 do
    for j:=0 to 48-1 do
    Begin
     if (nTMask and (nSH shl j))<>0 then
     Begin
      if nTable.Items[i].v[j]>=dbValue then
      Begin
      dbValue := nTable.Items[i].v[j];
      stime:=nTable.Items[i].m_sdtDate;
      j1:= j;
       End;
     End;
    End;
    time1:=trunc(stime)+j1*EncodeTime(0,30,0,0);
    Result := dbValue;
End;

function Get1Count(nMask: int64):integer;
var i  : integer;
    _1 : int64;
begin
   _1 := 1;
   Result := 0;
   for i := 0 to 63 do
     if (nMask and (_1 shl i)) > 0 then
       Result := Result + 1;
end;
procedure ClearDMX(nAID,nVMID,nCmdID:Integer);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     sQC.m_snABOID := nAID;
     sQC.m_snSRVID := -1;
     sQC.m_snCLID  := -1;
     sQC.m_snCLSID := -1;
     sQC.m_snCmdID := CSRV_CLEAR_DMTX;
     sQC.m_snVMID  := nVMID;
     sQC.m_snPrmID := nCmdID;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
    // SendMsgData(BOX_CSRV,0,DIR_QSTOCS,CSRV_CLEAR_DMTX,pDS);
End;
procedure SendQSComm(snABOID,snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     sQC.m_snABOID := snABOID;
     sQC.m_snSRVID := snSRVID;
     sQC.m_snCLID  := snCLID;
     sQC.m_snCLSID := snCLSID;
     sQC.m_snPrmID := snPrmID;
     sQC.m_snCmdID := nCommand;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     pDS.m_swData4 := MTR_LOCAL;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
//SendQSCommEx(-1,-1,-1,-1,-1,QS_STOP_SR);
procedure SendQSDataGEx(nCommand,snAID,snSRVID,snCLID,nCLSID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     //Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snCmdID  := nCommand;
     sQC.m_sdtBegin := sdtBegin;
     sQC.m_sdtEnd   := sdtEnd;
     sQC.m_snABOID  := snAID;
     sQC.m_snSRVID  := snSRVID;
     sQC.m_snCLID   := snCLID;
     sQC.m_snCLSID  := nCLSID;
     sQC.m_snPrmID  := nCMDID;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure SendQSCommGEx(snAID,snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     //Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snABOID := snAID;
     sQC.m_snSRVID := snSRVID;
     sQC.m_snCLID  := snCLID;
     sQC.m_snCLSID := snCLSID;
     sQC.m_snPrmID := snPrmID;
     sQC.m_snCmdID := nCommand;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     pDS.m_swData4 := MTR_LOCAL;
     //if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     //if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure ClearAbon(snAID,snSRVID,snPrmID:Integer);
Begin
     SendQSCommGEx(snAID,snSRVID,-1,-1,-1,QS_STP1_SR);
     ClearDMX(snAID,-1,snPrmID);
End;


function DateTimeToStrCrypt(DateTime : TDateTime) : String;
var tstr : string;
    i    : integer;
begin
   try
     tstr := DateTimeToStr(DateTime);
   except
     tstr := DateTimeToStr(Now);
   end;
   for i := 1 to Length(tstr) do
     tstr[i] := Char(Byte(tstr[i]) xor $FF);
   Result := tstr;
end;

function StrToDateTimeCrypt(tstr : string) : TDateTime;
var i    : integer;
begin
   for i := 1 to Length(tstr) do
     tstr[i] := Char(Byte(tstr[i]) xor $FF);
   Result := StrToDateTime(tstr);
end;

function DecodeStrCrypt(const str: string): string;
begin
   Result := mC.DecodeStrCrypt(str);
end;
function EncodeStrCrypt(const str: string): string;
begin
   Result := mC.EncodeStrCrypt(str);
end;

function GetGrKoeffVal(num : integer) : double;
begin
   case num of
     0 : result := 1.33;
     1 : result := 1.271;
     2 : result := 1.107;
     3 : result := 1.002;
     else result := 1;
   end;
end;
function GetTrabVolt(num : integer) : double;
begin
   case num of
     0 : result := 110*1000;
     1 : result := 10.000*1000;
     2 : result := 10.500*1000;
     3 : result := 11.000*1000;
     4 : result := 6.000*1000;
     5 : result := 6.300*1000;
     6 : result := 0.38*1000;
     else result := 1*1000;
   end;
end;
{
Real48	2.9 x 10^–39 .. 1.7 x 10^38	11–12	6
Single	1.5 x 10^–45 .. 3.4 x 10^38	7–8	4
Double	5.0 x 10^–324 .. 1.7 x 10^308	15–16	8
Extended	3.6 x 10^–4951 .. 1.1 x 10^4932	19–20	10
Comp	–2^63+1 .. 2^63 –1	19–20	8
Currency	–922337203685477.5808.. 922337203685477.5807	19–20	8
The generic type Real, in its current implementation, is equivalent to Double.
}
function IsNan(const AValue: Double): Boolean;
begin
  Result := ((PInt64(@AValue)^ and $7FF0000000000000)  = $7FF0000000000000) and
            ((PInt64(@AValue)^ and $000FFFFFFFFFFFFF) <> $0000000000000000)
end;
function IsInfinite(const AValue: Double): Boolean;
begin
  Result := ((PInt64(@AValue)^ and $7FF0000000000000) = $7FF0000000000000) and
            ((PInt64(@AValue)^ and $000FFFFFFFFFFFFF) = $0000000000000000)
end;
function GetParceString(nID:Integer;sAdvDiscL2Tag:String):String;
var
    i, j  : integer;
    ts: string;
begin
   j  := 0;
   ts := '';
   for i := 1 to Length(sAdvDiscL2Tag) do
   begin
     if sAdvDiscL2Tag[i] = ';' then
     begin
      if (j=nID) then
      Begin
       Result := ts;
       exit;
      End;
      ts := '';
      Inc(j);
      continue;
       {
       case j of
         0 : begin ed_L2KoncFubNum.Text   := ts; j := j + 1; end;
         1 : begin ed_L2KoncPassw.Text    := ts; j := j + 1; end;
         2 : begin ed_L2KoncAdrToRead.Text  := ts; j := j + 1; end;
         3 : begin ed_L2KoncRazNum.Text   := ts; j := j + 1; end;
         4 : begin ed_L2KoncNumTar.Text   := ts; j := j + 1; end;
         5 : begin ed_L2NaprVvoda.Text    := ts; j := j + 1; end;
         6 : begin ed_L2TypeTI.Text       := ts; j := j + 1; end;
         7 : begin ed_L2TypeTU.Text       := ts; j := j + 1; end;
         8 : begin dt_L2DateInst.Date     := StrToDate(ts); j := j + 1; end;
       end;
       ts := '';
       continue;
       }
     end;
     ts := ts + sAdvDiscL2Tag[i];
   end;
end;
function GetCodeFromDep(strDepTag:String):Integer;
Begin
    Result := 0;
    if (strDepTag='г.Могилев') then Result := 20 else
    if (strDepTag='Могилевский район') then Result := 24 else
    if (strDepTag='Белыничский район') then Result := 31 else
    if (strDepTag='Быховский район') then Result := 32 else
    if (strDepTag='Горецкий район') then Result := 33 else
    if (strDepTag='Круглянский район') then Result := 34 else
    if (strDepTag='Чаусский район') then Result := 35 else
    if (strDepTag='Шкловский район') then Result := 36 else
    if (strDepTag='Дрибинский район') then Result := 37 else
    if (strDepTag='г.Бобруйск') then Result := 40 else
    if (strDepTag='Бобруйский район') then Result := 43 else
    if (strDepTag='Глусский район') then Result := 51 else
    if (strDepTag='Кировский район') then Result := 52 else
    if (strDepTag='Кличевский район') then Result := 53 else
    if (strDepTag='Осиповичский район') then Result := 54 else
    if (strDepTag='Климовичский район') then Result := 60 else
    if (strDepTag='Костюковичский район') then Result := 62 else
    if (strDepTag='Хотимский район') then Result := 63 else
    if (strDepTag='Кричевский район') then Result := 80 else
    if (strDepTag='Краснопольский район') then Result := 84 else
    if (strDepTag='Мстиславский район') then Result := 85 else
    if (strDepTag='Славгородский район') then Result := 86 else
    if (strDepTag='Чериковский район') then Result := 87;
End;
function GetVMName(nVMID:Integer):String;
Var
    i : Integer;
Begin
    Result := '';
    for i:=0 to m_sVMName.Count-1 do
    Begin
     if nVMID=m_sVMName.Items[i].m_swVMID then
     Begin
      Result := m_sVMName.Items[i].m_sMeterName;
      exit;
     End;
    End;
End;
function GetMTName(nMID:Integer):String;
Var
    i : Integer;
Begin
    Result := '';
    for i:=0 to m_sMTName.Count-1 do
    Begin
     if nMID=m_sMTName.Items[i].m_swVMID then
     Begin
      Result := m_sMTName.Items[i].m_sMeterName;
      exit;
     End;
    End;
End;
function SendTrace(_Type : Integer; _Message : String) : Boolean;
Var
    m_nMsg : CMessage;
    i,nLen : Integer;
Begin
    Result:=False;
    try
    nLen                 := Length(_Message);
    m_nMsg.m_swLen       := 13+nLen;
    m_nMsg.m_sbyServerID := _Type;
    for i:=0 to nLen-1 do m_nMsg.m_sbyInfo[i] := Byte(_Message[i+1]);
    FPUT(BOX_L5_TC,@m_nMsg);
    except
      Result:=True;
    end;
End;
function IsDb(nSH : Integer):Boolean;
Var
    dwO : Dword;
Begin
    dwO := 1;
    result := ((m_dwDB and (dwO shl nSH))<>0);
End;
procedure saveSetBaseProp;
Var
    Fl : TIniFile;
Begin
    try
     Fl  := TINIFile.Create(ExtractFilePath(Application.ExeName)+'\\Settings\\USPD_Config.ini');
     Fl.WriteInteger('DBCONFIG','m_nDBSave', 1);
     Fl.Destroy;
    except
    end;
End;
procedure saveRemBaseProp;
Var
    Fl : TIniFile;
Begin
    try
     Fl  := TINIFile.Create(ExtractFilePath(Application.ExeName)+'\\Settings\\USPD_Config.ini');
     Fl.WriteInteger('DBCONFIG','m_nDBSave', 0);
     Fl.Destroy;
    except
    end;
End;
function getSaveBaseProp: integer;
Var
    Fl : TIniFile;
Begin
    result := 0;
    try
     Fl  := TINIFile.Create(ExtractFilePath(Application.ExeName)+'\\Settings\\USPD_Config.ini');
     result := Fl.ReadInteger('DBCONFIG','m_nDBSave', 0);
     Fl.Destroy;
    except
    end;
End;
function getSaveBasePropPath(stpPath:String): integer;
Var
    Fl : TIniFile;
Begin
    result := 0;
    try
     Fl  := TINIFile.Create(stpPath);
     //Fl  := TINIFile.Create(ExtractFilePath(Application.ExeName)+'\\Settings\\USPD_Config.ini');
     result := Fl.ReadInteger('DBCONFIG','m_nDBSave', 0);
     Fl.Destroy;
    except
    end;
End;

procedure FinalizModule;
var
  I :Integer;
begin
  //if m_nOutState <> nil then FreeAndNil(m_nOutState);
  //if m_nInState <> nil then FreeAndNil(m_nInState);
  if m_nTypeProt <> nil then FreeAndNil(m_nTypeProt);
  if m_nDataGroup <> nil then FreeAndNil(m_nDataGroup);
  if m_nNetMode <> nil then FreeAndNil(m_nNetMode);
  if m_nSaveList <> nil then FreeAndNil(m_nSaveList);
  if m_nActiveList <> nil then FreeAndNil(m_nActiveList);
  if m_nActiveExList <> nil then FreeAndNil(m_nActiveExList);
  if m_nMeterLocation <> nil then FreeAndNil(m_nMeterLocation);
  if m_nStatusList <> nil then FreeAndNil(m_nStatusList);
  if m_nCmdDirect <> nil then FreeAndNil(m_nCmdDirect);
  if m_nCommandList <> nil then FreeAndNil(m_nCommandList);
  if m_nParamList <> nil then FreeAndNil(m_nParamList);
  if m_nPTariffList <> nil then FreeAndNil(m_nPTariffList);
  if m_nMeterList <> nil then FreeAndNil(m_nMeterList);

  if m_nSpeedList <> nil then FreeAndNil(m_nSpeedList);
  if m_nParityList <> nil then FreeAndNil(m_nParityList);
  if m_nDataList <> nil then FreeAndNil(m_nDataList);
  if m_nStopList <> nil then FreeAndNil(m_nStopList);

  if m_nSpeedListA <> nil then FreeAndNil(m_nSpeedListA);
  if m_nParityListA <> nil then FreeAndNil(m_nParityListA);
  if m_nDataListA <> nil then FreeAndNil(m_nDataListA);
  if m_nStopListA <> nil then FreeAndNil(m_nStopListA);

  if m_nPortTypeList <> nil then FreeAndNil(m_nPortTypeList);
  if m_nSvPeriodList <> nil then FreeAndNil(m_nSvPeriodList);
  if m_nEsNoList <> nil then FreeAndNil(m_nEsNoList);
  if m_nJrnlN1 <> nil then FreeAndNil(m_nJrnlN1);
  if m_nJrnlN2 <> nil then FreeAndNil(m_nJrnlN2);
  if m_nJrnlN3 <> nil then FreeAndNil(m_nJrnlN3);
  if m_nJrnlN4 <> nil then FreeAndNil(m_nJrnlN4);
  if m_nUserLayer <> nil then FreeAndNil(m_nUserLayer);
  if m_nStateProc <> nil then FreeAndNil(m_nStateProc);
  if m_nTestName <> nil then FreeAndNil(m_nTestName);
  if m_nWorkDay <> nil then FreeAndNil(m_nWorkDay);
  if m_nKTRout <> nil then FreeAndNil(m_nKTRout);
  if m_nDataType <> nil then FreeAndNil(m_nDataType);
  if m_nMeterName <> nil then FreeAndNil(m_nMeterName);
  if m_nSrvName <> nil then FreeAndNil(m_nSrvName);

  for I := Low(pHiBuff) to High(pHiBuff) do
    with pHiBuff[I] do
      if sCS <> nil then
        FreeAndNil(sCS);
        
  if mC <> nil then FreeAndNil(mC);
  if m_csOut <> nil then FreeAndNil(m_csOut);
  if gsCS <> nil then FreeAndNil(gsCS);
end;

initialization

finalization
  FinalizModule();
end.
