unit utldatabase;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlconst,inifiles,Db,ADODB
    ,knsl5tracer, Dates,utlbox, utlTimeDate,utldynconnect,dbtables;
type
    PCDBDynamicConn = ^CDBDynamicConn;
    CDBase = class
     m_strProvider  : String;
     m_strFileName  : String;
     m_strSvCString : String;
     m_nSvConnLevel : Integer;
     m_nDynCount    : Integer;
     m_blDynConn    : array[0..MAX_DYNCONN] of Boolean;
    public
     //procedure Init(strFileName:String);
     function Init(strFileName:String):Boolean;
     function FullDisconnect:Boolean;
     //function  GetLocalConnString
     procedure SaveConnection;
     function Connect:Boolean;
     function Disconnect:Boolean;
     function LightConnect(str:String):Boolean;
     function FullConnect(str:String):Boolean;
     function SFullConnect(str:String):Boolean;
     function SaveParam(wMetID:Word;tTime:TDateTime;byParamType:Byte;pbyData:PByte):Boolean;
     function ReadParam(wMetID:Word;tTime:TDateTime;byParamType:Byte;pbyData:PByte):Boolean;

     function GetL1Table(var pTable:SL1INITITAG):Boolean;
     function GetCtrConnTable(var pTable:SL1INITITAG):Boolean;
     function IsPort(var pTable:SL1TAG):Boolean;
     function GetPortTable(var pTable:SL1TAG):Boolean;
     function SetPortTable(var pTable:SL1TAG):Boolean;
     function AddPortTable(var pTable:SL1TAG):Boolean;
     function DelPortTable(nIndex:Integer):Boolean;

     function GetMetersTable(nChannel:Integer;var pTable:SL2INITITAG):Boolean;
     function GetMetersIniTable(var pTable:SL2INITITAG):Boolean;
     function GetMeterLocation(FMID:Integer;var FLocation:Integer):Boolean;
     function IsMeter(var pTable:SL2TAG):Boolean;
     function GetMeterTable(var pTable:SL2TAG):Boolean;
     function GetMeterTableForReport(GroupID : integer;var pTable : SL2TAGREPORTLIST) : boolean;
     function SetMeterTable(var pTable:SL2TAG):Boolean;
     function AddMeterTable(var pTable:SL2TAG):Boolean;
     function DelMeterTable(nMasterIndex,nIndex:Integer):Boolean;

     function GetCommandsTable(nChannel:Integer;var pTable:CCOMMANDs):Boolean;
     function GetCommandTable(var pTable:CCOMMAND):Boolean;
     function SetCommandTable(var pTable:CCOMMAND):Boolean;
     function AddCommandTable(var pTable:CCOMMAND):Boolean;
     function DelCommandTable(nIndex:Integer;nCmdIndex:Integer):Boolean;
     function InsertCommand(nIndex,nMeterType:Integer):Boolean;
     function LoadCommand(nIndex,nMeterType:Integer):Boolean;
     function IsCommands(nIndex:Integer):Boolean;


     function GetParamsTypeTable(var pTable:QM_PARAMS):Boolean;
     function GetParamTypeTable(var pTable:QM_PARAM):Boolean;
     function SetParamTypeTable(var pTable:QM_PARAM):Boolean;
     function AddParamTypeTable(var pTable:QM_PARAM):Boolean;
     function DelParamTypeTable(nIndex:Integer):Boolean;

     function GetConnTable(var pTable:SL3CONNTBLS):Boolean;
     function GetConnTableSA(var pTable:SL3CONNTBLS):Boolean;
     function IsConnTable(var pTable:SL3CONNTBL):Boolean;
     function IsLocalConn(nIndex:Integer):Boolean;
     function IsLocalConnSA(nIndex:Integer):Boolean;
     function IsSlaveConn(nIndex:Integer):Boolean;
     function IsSlaveConnSA(nIndex:Integer):Boolean;
     function SetConnTable(var pTable:SL3CONNTBL):Boolean;
     function AddConnTable(var pTable:SL3CONNTBL):Boolean;
     function DelConnTable(nIndex:Integer):Boolean;


     function GetMetersAll(var pTable:SL2INITITAG):Boolean;
     function GetMetersTypeTable(var pTable:QM_METERS):Boolean;
     function GetMeterTypeTable(var pTable:QM_METER):Boolean;
     function IsMeterTypeTable(var pTable:QM_METER):Boolean;
     function SetMeterTypeTable(var pTable:QM_METER):Boolean;
     function AddMeterTypeTable(var pTable:QM_METER):Boolean;
     function DelMeterTypeTable(nIndex:Integer):Boolean;




     function GetQMCommandsTable(nIndex:Integer;var pTable:QM_COMMANDS):Boolean;
     function GetQMCommandTable(var pTable:QM_COMMAND):Boolean;
     function SetQMCommandTable(var pTable:QM_COMMAND):Boolean;
     function AddQMCommandTable(var pTable:QM_COMMAND):Boolean;
     function DelQMCommandTable(nIndex:Integer;nCmdIndex:Integer):Boolean;

     function GetTMTarifsTable(var pTable:TM_TARIFFSS):Boolean;
     function IsTMTarifTable(var pTable:TM_TARIFFS):Boolean;
     function SetTMTarifTable(var pTable:TM_TARIFFS):Boolean;
     function AddTMTarifTable(var pTable:TM_TARIFFS):Boolean;
     function DelTMTarifTable(nIndex:Integer):Boolean;

     function GetTMTarPeriodsTable(nIndex:Integer;var pTable:TM_TARIFFS):Boolean;
     function IsTMTarPeriodTable(var pTable:TM_TARIFF):Boolean;
     function SetTMTarPeriodTable(var pTable:TM_TARIFF):Boolean;
     function AddTMTarPeriodTable(var pTable:TM_TARIFF):Boolean;
     function DelTMTarPeriodTable(nIndex:Integer;nCmdIndex:Integer):Boolean;

     function GetGroupsTable(var pTable:SL3INITTAG):Boolean;
     function GetGroupTbl(var pTable:SL3GROUPTAG):Boolean;
     function GetGroupTable(var pTable:SL3GROUPTAG):Boolean;
     function SetGroupTable(var pTable:SL3GROUPTAG):Boolean;
     function AddGroupTable(var pTable:SL3GROUPTAG):Boolean;
     function DelGroupTable(nIndex:Integer):Boolean;


     function GetVMetersFullTable(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetVMetersTable(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetVMetersTypeTable(nChannel,nType:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetVMeterTbl(var pTable:SL3VMETERTAG):Boolean;
     function GetVMeterTable(var pTable:SL3VMETERTAG):Boolean;
     function SetVMeterTable(var pTable:SL3VMETERTAG):Boolean;
     function AddVMeterTable(var pTable:SL3VMETERTAG):Boolean;
     function DelVMeterTable(nMIndex,nIndex:Integer):Boolean;


     function GetVParamsTable(nChannel:Integer;var pTable:SL3VMETERTAG):Boolean;
     function GetVParamsGrTable(nGroup,nChannel,nType:Integer;var pTable:SL3VMETERTAG):Boolean;
     function GetVParamTbl(var pTable:SL3PARAMS):Boolean;
     function GetVParamTable(var pTable:SL3PARAMS):Boolean;
     function SetVParamTable(var pTable:SL3PARAMS):Boolean;
     function AddVParamTable(var pTable:SL3PARAMS):Boolean;
     function DelVParamTable(nMasterIndex,nIndex:Integer):Boolean;
     function InsertVParams(nMeterType,nIndex:Integer):Boolean;
     function ReplaceVParams(nMType,nIndex:Integer):Boolean;
     function GetVKeyParamsTable(nChannel,nSVType:Integer;var pTable:SL3VMETERTAG):Boolean;
     function VParamTSynchronize:Boolean;

     //Data Routing

     function AddCurrentParam(var pTable:L3CURRENTDATA):Boolean;
     function SetCurrentParam(var pTable:L3CURRENTDATA):Boolean;
     function SetArchParam(var pTable:L3CURRENTDATA):Boolean;
     function DeleteCurrentParam(nIndex:Integer):Boolean;
     function IsCurrentParam(var pTable:L3CURRENTDATA):Boolean;

     function AddArchData(var pTable:L3CURRENTDATA):Boolean;
     function IsArchData(var pTable:L3CURRENTDATA):Boolean;
     function UpdateArchData(var pTable:L3CURRENTDATA):Boolean;
     function DelArchData(Date1, Date2 : TDateTime; var Data :L3CURRENTDATA):Boolean;
     function AddPdtData(var pTable:L3CURRENTDATA):Boolean;
     function DelPdtData(Date1, Date2 : TDateTime; var Data :L3CURRENTDATA):Boolean;

     function GetMetaData(nIndex,nDataType:Integer;var pTable:CGMetaDatas):Boolean;
     function SetMetaData(nIndex:Integer;var pTable:CGMetaData):Boolean;
     function GetTariffData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetTariffDataBTI(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetCurrentData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetCurrentDataBTI(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetCData(nIndex,nDataType:Integer;var pTable:CCDatas):Boolean;
     function GetGDPData(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:CCDatas):Boolean;
     function GetGData(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
     function GetGDataEnergo(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
     function GetGDataBTI(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
     function GetGMetaData(nIndex:Integer;var pTable:CGRMetaData):Boolean;
     function UpateLastTime(nVMID,nCMDID:Integer;dtTime:TDateTime):Boolean;
     function UpdateLastParam(nVMID,nCMDID:Integer;fValue:Double):Boolean;
     function UpdateLastParamTime(nVMID,nCMDID:Integer;fValue:Double;dtTime:TDateTime):Boolean;
     function UpdateMaxParam(nVMID,nCMDID:Integer;fValue:Double):Boolean;
     function UpdateMinParam(nVMID,nCMDID:Integer;fValue:Double):Boolean;
     function UpdateExpression(nVMID,nCMDID:Integer;str:String):Boolean;


     function GetGraphDatas(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetGraphDatasEnergo(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetGraphDatasBTI(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function AddGraphData(var pTable:L3GRAPHDATA):Boolean;
     function UpdateGraphData(var pTable:L3GRAPHDATA):Boolean;
     function UpdateGraphFilds(var pTable:L3CURRENTDATA):Boolean;
     function IsGraphData(var pTable:L3GRAPHDATA):Boolean;
     function GetLastTime:TDateTime;
     function DelGraphData(Date1, Date2 : TDateTime;var Data :L3GRAPHDATA):Boolean;
     function DelSlices(MonthN : integer):Boolean;

         //brest_енерготелеком
     function AddArchUspdTable(var pTable:Arch_uspd; nGroup,nEvent:Integer):Boolean;
     function IsArchUspd(var pTable:Arch_uspd):Boolean;
     function AddArchDataEnergo(var pTable:VAl):Boolean;
     function IsArchDataEnergo(var pTable:val):Boolean;
     function UpdateArchDataEnergo(var pTable:VAL):Boolean;
     function DelArchEnergoData(Date1, Date2 : TDateTime; var Data :VAL):Boolean;
     function DelArchUspdTable(nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime):Boolean;



     //L3GRAPHDATA

     //BELTI
     function DeleteBTIMeters(var PortID : integer):boolean;
     function DelUSPDData(AdrUSPD : byte):Boolean;
     function AddUSPDTypeData(var pTable : SL2USPDTYPE):Boolean;
     function AddUSPDDev(var pTable : SL2USPDEV):Boolean;
     function AddUSPDCharDev(var pTable : SL2USPDCHARACTDEV):Boolean;
     function AddUSPDCharKan(var pTable : SL2USPDCHARACTKANAL):Boolean;
     function IsUSPDTypeData(var pTable : SL2USPDTYPE):Boolean;
     function IsUSPDDev(var pTable : SL2USPDEV):Boolean;
     function IsUSPDCharDev(var pTable : SL2USPDCHARACTDEV):Boolean;
     function IsUSPDCharKan(var pTable : SL2USPDCHARACTKANAL):Boolean;
     function UpdateUSPDTypeData(var pTable : SL2USPDTYPE):Boolean;
     function UpdateUSPDDev(var pTable : SL2USPDEV):Boolean;
     function UpdateUSPDCharDev(var pTable : SL2USPDCHARACTDEV):Boolean;
     function UpdateUSPDCharKan(var pTable : SL2USPDCHARACTKANAL):Boolean;
     function ReadUSPDTypeData():Boolean;
     function ReadUSPDDev():Boolean;
     function ReadUSPDCharDev(AdrUSPD : byte;var pTable:SL2USPDCHARACTDEVLIST):Boolean;
     function ReadUSPDCharKan(AdrUSPD, MeterID : word;var pTable :SL2USPDCHARACTKANALLIST):Boolean;
     function AddMeterUSPD(var pTable:SL2TAG):Boolean;
     function IsMeterUSPD(var pTable:SL2TAG):Boolean;
     function UpdateMeterUSPD(var pTable:SL2Tag):Boolean;

     //BELTI CONFIGURATION
     function ReadUSPDCFG(var pTable : SL2USPDTYPEEX) : boolean;
     function GetVMFromEnerg(var pTable : SL2TAGREPORTLIST) : boolean;
     function ReadUSPDDevCFG(var pTable : SL2USPDEVLISTEX) : boolean;
     function ReadUSPDCharDevCFG(var pTable : SL2USPDCHARACTDEVLISTEX) : boolean;

     function LoadReportParams(var pTable : REPORT_F1):boolean;
     function SaveReportParams(var pTable : REPORT_F1):boolean;
     //function


     //Settings
     function GetGenSettTable(var pTable:SGENSETTTAG):Boolean;
     function IsGenSett:Boolean;
     function AddGenSettTable(var pTable:SGENSETTTAG):Boolean;
     function SetGenSettTable(var pTable:SGENSETTTAG):Boolean;

     function GetEventsTable(nIndex:Integer;var pTable:SEVENTSETTTAGS):Boolean;
     function SetEventTable(var pTable:SEVENTSETTTAG):Boolean;
     function IsEvent(var pTable:SEVENTSETTTAG):Boolean;
     function AddEventTable(var pTable:SEVENTSETTTAG):Boolean;
     function DelEventsTable(nIndex:Integer):Boolean;

     function GetFixEventsTable(nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime;var pTable:SEVENTTAGS):Boolean;
     function IsFixEvent(var pTable:SEVENTTAG):Boolean;
     function AddFixEventTable(var pTable:SEVENTTAG):Boolean;
     function DelFixEventsTable(nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime):Boolean;
     function FixUspdEvent(nEvent:Integer):Boolean;
     function FixMeterEvent(nGroup,nEvent,nVMID:Integer;Date : TDateTime):Boolean;


     function GetConnectsTable(var pTable:SCONNSETTTAGS):Boolean;
     function SetConnectTable(var pTable:SCONNSETTTAG):Boolean;
     function IsConnect(nIndex:Integer):Boolean;
     function AddConnectTable(var pTable:SCONNSETTTAG):Boolean;
     function DelConnectsTable(nIndex:Integer):Boolean;

     function GetColorsTable(var pTable:SCOLORSETTTAGS):Boolean;
     function GetColorTable(var pTable:SCOLORSETTTAG):Boolean;
     function GetNameFont(var pTable:SCOLORSETTTAG):Boolean;
     function GetColorTablePanel(var pTable:SCOLORSETTTAG):Boolean;
     function IsColor(nIndex:Integer):Boolean;
     function SetColorTable(var pTable:SCOLORSETTTAG):Boolean;
     function SetColorPanel(var pTable:SCOLORSETTTAG):Boolean;
     function AddColorTable(var pTable:SCOLORSETTTAG):Boolean;
     function AddColorPanel(var pTable:SCOLORSETTTAG):Boolean;
     function DelColorsTable(nIndex:Integer):Boolean;

     function GetUsersTable(var pTable:SUSERTAGS):Boolean;
     function GetUserTable(var pTable:SUSERTAG):Boolean;
     function SetUserTable(var pTable:SUSERTAG):Boolean;
     function AddUserTable(var pTable:SUSERTAG):Boolean;
     function IsUserTag(var pTable:SUSERTAG):Boolean;
     function DelUserTable(swUID:Integer):Boolean;
     function CheckLevelAccess(strUser,strPassword:String;nLevel:Integer):Boolean;
     function GetSecurityAttributes(var pTable:SUSERTAG):Boolean;
     procedure SetPhotoTable(var pTable:SUSERTAG;var MemoryStream : TMemoryStream);
     function GetPhotoTable(var pTable:SUSERTAG;var MemoryStream : TMemoryStream):boolean;

     function GetSkinsTable(var pTable:SSKINSETTTAGS):Boolean;
     function IsSkin(nIndex:Integer):Boolean;
     function SetSkinTable(var pTable:SSKINSETTTAG):Boolean;
     function AddSkinTable(var pTable:SSKINSETTTAG):Boolean;
     function DelSkinsTable(nIndex:Integer):Boolean;

     function GetSdlTable(var pTable:SQRYSDLTAGS):Boolean;
     function IsSdlTag(var pTable:SQRYSDLTAG):Boolean;
     function SetSdlTable(var pTable:SQRYSDLTAG):Boolean;
     function AddSdlTable(var pTable:SQRYSDLTAG):Boolean;
     function DelSdlTable:Boolean;

     function GetHkeySettTable(var pTable:SHKEYSETTTAG):Boolean;
     function SetHkeySettTable(var pTable:SHKEYSETTTAG):Boolean;


     function PADOQryR1:PTADOQuery;
     function PADOQryR2:PTADOQuery;

     function GetL3Table(var pTable:SL3INITTAG):Boolean;
     function GetL4Table(var pTable:SL4INITITAG):Boolean;
     function GetL5Table(var pTable:SL5INITITAG):Boolean;

     function SetL1Table(var pTable:SL1INITITAG):Boolean;
     function SetL2Table(var pTable:SL2INITITAG):Boolean;
     function SetL3Table(var pTable:SL3INITTAG):Boolean;
     function SetL4Table(var pTable:SL4INITITAG):Boolean;
     function SetL5Table(var pTable:SL5INITITAG):Boolean;


     procedure DEFAULT(var pTable : SL1TAG);overload;
     procedure DEFAULT(var pTable : SL2TAG);overload;

      
	      //for Reports
     function  ClearTable (TableName : String): Boolean;
     function  ExecQryR(strSQL:String):Boolean;
     function  OpenQryR(strSQL:String;var nCount:Integer):Boolean;

     function  EvalTar(tTimeON,tTimeOFF : TDateTime) : Real;
     function  SetReport(dDate : TDateTime; RepType : Integer) : Boolean;



     function  CreateRepF1(RCNFG :RepCONFIG) : Boolean;
     function  CreateRepF2(RCNFG :RepCONFIG) : Boolean;
     function  CreateRepF3(RCNFG :RepCONFIG) : Boolean;
     function  CreateRepF4(RCNFG :RepCONFIG) : Boolean;
     function  CreateRepF5(RCNFG :RepCONFIG) : Boolean;

     function  CreateQryF1() : Boolean;
     function  SetSumEnergy(RCNFG : RepCONFIG) : Boolean;
     function  SetL2HHEnergy(RCNFG :RepCONFIG) : Boolean;
     procedure DoMerge(strTblName : String; var strSQL_SELECT,strSQL_ON,strSQL_MATCHED,strSQL_N_MATCHED: String);
     procedure GetSummaryF1(var Tbl : SUMMARY_F1);


     procedure ConnectDynAll;
     procedure DisconnectDynAll;
     function DynConnect(nIndex:Integer):PCDBDynamicConn;
     function DynDisconnect(nIndex:Integer):Boolean;
    private
     procedure CreateConnection(var vConn:TADOConnection;var vQry:TADOQuery);
     procedure DestroyConnection(var vConn:TADOConnection;var vQry:TADOQuery);
     function  ExecQry(strSQL:String):Boolean;
     function  ExecQryD(strSQL:String):Boolean;
     function  ExecQryD1(strSQL:String):Boolean;
     function  ExecQryD2(strSQL:String):Boolean;
     function  ExecQrySA(strSQL:String):Boolean;
     function  ExecQryBTI(strSQL:String):Boolean;
     function  OpenQry(strSQL:String;var nCount:Integer):Boolean;
     function  OpenQryD(strSQL:String;var nCount:Integer):Boolean;
     function  OpenQryD1(strSQL:String;var nCount:Integer):Boolean;
     function  OpenQryD2(strSQL:String;var nCount:Integer):Boolean;
     function  OpenQrySA(strSQL:String;var nCount:Integer):Boolean;
     function  OpenQryBTI(strSQL:String;var nCount:Integer):Boolean;
     procedure CloseQry;
     procedure CloseQryD;
     procedure CloseQryD1;
     procedure CloseQryD2;
     procedure CloseQrySA;
     procedure CloseQryBTI;
     procedure UpdateL1PortCount;
     procedure UpdateL2MeterCount;
    private
     m_byConnectionLevel: Byte;
     sCS             : TCriticalSection;
     FADOConnection  : TADOConnection;
     FADOConnectionD : TADOConnection;
     FADOConnectionD1: TADOConnection;
     FADOConnectionD2: TADOConnection;
     FADOConnectionSA: TADOConnection;
     FADOConnectionBTI: TADOConnection;
     FADOConnectionR1: TADOConnection;
     FADOConnectionR2: TADOConnection;
     FconReport      : TADOConnection;
     FADOQuery       : TADOQuery;
     FADOQueryD      : TADOQuery;
     FADOQueryD1     : TADOQuery;
     FADOQueryD2     : TADOQuery;
     FADOQuerySA     : TADOQuery;
     FADOQueryBTI     : TADOQuery;
     FqryReport      : TADOQuery;
     FqryReport1     : TADOQuery;
     FqryReport2     : TADOQuery;
    public
     property PADOConnection   : TADOConnection  read FADOConnection  write FADOConnection;
     property PADOQuery        : TADOQuery       read FADOQuery       write FADOQuery;
    End;
var
    m_pDB           : CDBase;
    m_nLocalConnStr : String;
    m_pDBC          : array[0..MAX_DYNCONN] of CDBDynamicConn;
implementation

function CDBase.PADOQryR1:PTADOQuery;
Begin
    CreateConnection(FADOConnectionR1,FqryReport1);
    Result := @FqryReport1;
End;
function CDBase.PADOQryR2:PTADOQuery;
Begin
    CreateConnection(FADOConnectionR2,FqryReport2);
    Result := @FqryReport2;
End;
{
procedure CDBase.Init(strFileName:String);
var
    Fl: TINIFile;
    i : Integer;
Begin
    m_nDynCount := 0;
    for i:=0 to MAX_DYNCONN do m_blDynConn[i] := False;
    m_strFileName := strFileName;
    Fl := TINIFile.Create(strFileName);
    sCS:=TCriticalSection.Create;
    m_strProvider        := Fl.ReadString('DBCONFIG', 'DBProvider', '');
    m_nCurrentConnection := Fl.ReadInteger('DBCONFIG','CurrentConnection', 0);
    FFileIndex           := Fl.ReadInteger('DBCONFIG','FFileIndex', 0);
    // m_nPrecise           := Fl.ReadInteger('DBCONFIG','m_nPrecise', 0);
    m_nOnAutorization    := Fl.ReadInteger('DBCONFIG','m_nOnAutorization', 0);
    m_byConnectionLevel  := 1;
    Fl.Destroy;
End;
}

function CDBase.Init(strFileName:String):Boolean;
var
    Fl   : TINIFile;
    i    : Integer;
    sDbPlacement       : String;
    m_strDefConnection : String;
Begin
    m_blIsBackUp          := False;
    m_nDynCount           := 0;
    m_strDefConnection    := 'Driver=Firebird/InterBase(r) driver;Uid=SYSDBA;Pwd=masterkey;DbName=m_sDbPlacement';
    for i:=0 to MAX_DYNCONN do m_blDynConn[i] := False;
    m_strFileName := strFileName;
    Fl := TINIFile.Create(strFileName);
     sCS:=TCriticalSection.Create;
     sDbPlacement         := Fl.ReadString('DBCONFIG', 'DBProvider', '');
     m_strProvider        := StringReplace(m_strDefConnection,'m_sDbPlacement',sDbPlacement,[rfReplaceAll]);
     m_nCurrentConnection := Fl.ReadInteger('DBCONFIG','CurrentConnection', 0);
     FFileIndex           := Fl.ReadInteger('DBCONFIG','FFileIndex', 0);
     m_nValue             := Fl.ReadInteger('DBCONFIG','m_nValue', 0);
     m_nOnAutorization    := Fl.ReadInteger('DBCONFIG','m_nOnAutorization', 0);
     m_byConnectionLevel  := 1;
    Fl.Destroy;
    Result := FileExists(sDbPlacement);
End;

function CDBase.DynConnect(nIndex:Integer):PCDBDynamicConn;
Begin
    Result := Nil;
    if nIndex>10 then exit;
    if m_pDBC[nIndex]=Nil then m_pDBC[nIndex] := CDBDynamicConn.Create;
    m_blDynConn[nIndex] := True;
    m_pDBC[nIndex].Init(m_strProvider);
    m_pDBC[nIndex].Connect;
    Result := @m_pDBC[nIndex];
End;
function CDBase.DynDisconnect(nIndex:Integer):Boolean;
Begin
    Result := False;
    if nIndex>10 then exit;
    if m_pDBC[nIndex]=Nil then exit;
    //m_blDynConn[nIndex] := False;
    m_pDBC[nIndex].Disconnect;
    Result := True;
End;
procedure CDBase.ConnectDynAll;
Var
    i : Integer;
Begin
    for i:=0 to MAX_DYNCONN do
    if m_blDynConn[i]=True then DynConnect(i);
End;
procedure CDBase.DisconnectDynAll;
Var
    i : Integer;
Begin
    for i:=0 to MAX_DYNCONN do
    if m_blDynConn[i]=True then DynDisconnect(i);
End;
procedure CDBase.SaveConnection;
var
    Fl: TINIFile;
Begin
    Fl := TINIFile.Create(m_strFileName);
    Fl.WriteString('DBCONFIG', 'FFileIndex', IntToStr(FFileIndex));
    //Fl.WriteString('DBCONFIG', 'DBProvider', m_strProvider);
    //Fl.WriteString('DBCONFIG', 'm_nLocalConnStr', m_nLocalConnStr);
    //Fl.WriteString('DBCONFIG', 'CurrentConnection', IntToStr(m_nCurrentConnection));
    Fl.Destroy;
    //ConnectToLocal;
End;
function CDBase.FullDisconnect;
Begin
     try
     m_blIsBackUp         := True;
     m_strSvCString       := m_strProvider;
     m_nSvConnLevel       := m_byConnectionLevel;
     DestroyConnection(FADOConnection,FADOQuery);
     DestroyConnection(FADOConnectionD,FADOQueryD);
     DestroyConnection(FADOConnectionD1,FADOQueryD1);
     DestroyConnection(FADOConnectionD2,FADOQueryD2);
     DestroyConnection(FconReport,FqryReport);
     DestroyConnection(FADOConnectionSA,FADOQuerySA);
     //DestroyConnection(FADOConnectionBTI,FADOQueryBTI);
     DisconnectDynAll;
     m_strProvider        := m_strSvCString;
     m_byConnectionLevel  := m_nSvConnLevel;
     except
     end;
End;
function CDBase.LightConnect(str:String):Boolean;
Begin
    try
    m_strProvider        := str;
    m_byConnectionLevel  := 2;
    Disconnect;
    Connect;
    except
     TraceER('(__)CERMD::>Error In CDBase.LightConnect!!!');
    end;
End;
function CDBase.FullConnect(str:String):Boolean;
Begin
    try
    m_strProvider        := str;
    m_byConnectionLevel  := 1;
    Disconnect;
    Connect;
    except
     TraceER('(__)CERMD::>Error In CDBase.FullConnect!!!');
    end;
End;
function CDBase.SFullConnect(str:String):Boolean;
Begin
    try
    m_strProvider        := str;
    m_byConnectionLevel  := 0;
    Disconnect;
    Connect;
    except
     TraceER('(__)CERMD::>Error In CDBase.SFullConnect!!!');
    end;
End;
function CDBase.Connect:Boolean;
Var
    pTbl   : SL3CONNTBLS;
Begin
    Result := True;
    //FADOConnection.ConnectionString := 'Provider=MSDASQL.1;Password=masterkey;Persist Security Info=True;User ID=SYSDBA;Data Source=Firebird';
    try
    m_blIsBackUp         := False;
    case m_byConnectionLevel of
     0:
     Begin
      ConnectDynAll;
      CreateConnection(FADOConnection,FADOQuery);
      CreateConnection(FADOConnectionD,FADOQueryD);
      CreateConnection(FADOConnectionD1,FADOQueryD1);
      CreateConnection(FADOConnectionD2,FADOQueryD2);
      CreateConnection(FconReport,FqryReport);
      //CreateConnection(FADOConnectionBTI,FADOQueryBTI);
      //CreateConnection(FADOConnectionSA,FADOQuerySA);
     End;
     1:
     Begin
      ConnectDynAll;
      CreateConnection(FADOConnection,FADOQuery);
      CreateConnection(FADOConnectionD,FADOQueryD);
      CreateConnection(FADOConnectionD1,FADOQueryD1);
      CreateConnection(FADOConnectionD2,FADOQueryD2);
      CreateConnection(FconReport,FqryReport);
      CreateConnection(FADOConnectionSA,FADOQuerySA);
      //CreateConnection(FADOConnectionBTI,FADOQueryBTI);
     End;
     2:
     Begin
      ConnectDynAll;
      CreateConnection(FADOConnectionD1,FADOQueryD1);
      CreateConnection(FADOConnectionD2,FADOQueryD2);
      //CreateConnection(FADOConnectionBTI,FADOQueryBTI);
      CreateConnection(FconReport,FqryReport);
      CreateConnection(FADOConnectionSA,FADOQuerySA);
     End;
    End;
    if GetConnTable(pTbl)=True then
    Begin
     pTbl.Items[0].m_sConnString := m_strProvider;
     m_pDB.AddConnTable(pTbl.Items[0]);
    End;
    except
     Result := False;
    End
End;
function CDBase.Disconnect:Boolean;
Begin
    Result := True;
    try
    case m_byConnectionLevel of
     0:
     Begin
      DestroyConnection(FADOConnection,FADOQuery);
      DestroyConnection(FADOConnectionD,FADOQueryD);
      DestroyConnection(FADOConnectionD1,FADOQueryD1);
      DestroyConnection(FADOConnectionD2,FADOQueryD2);
      DestroyConnection(FconReport,FqryReport);
      //DestroyConnection(FADOConnectionBTI,FADOQueryBTI);
      //DestroyConnection(FADOConnectionSA,FADOQuerySA);
      DisconnectDynAll;
     End;
     1:
     Begin
      DestroyConnection(FADOConnection,FADOQuery);
      DestroyConnection(FADOConnectionD,FADOQueryD);
      DestroyConnection(FADOConnectionD1,FADOQueryD1);
      DestroyConnection(FADOConnectionD2,FADOQueryD2);
      DestroyConnection(FconReport,FqryReport);
      //DestroyConnection(FADOConnectionBTI,FADOQueryBTI);
      //DestroyConnection(FADOConnectionSA,FADOQuerySA);
      DisconnectDynAll;
     End;
     2:
     Begin
      DestroyConnection(FADOConnectionD1,FADOQueryD1);
      DestroyConnection(FADOConnectionD2,FADOQueryD2);
      DestroyConnection(FconReport,FqryReport);
      //DestroyConnection(FADOConnectionBTI,FADOQueryBTI);
      DisconnectDynAll;
     End;
    End;
    except
     Result := False;
    End
End;
procedure CDBase.CreateConnection(var vConn:TADOConnection;var vQry:TADOQuery);
Begin
    if vConn=Nil then
    Begin
     vConn := TADOConnection.Create(Nil);
     vConn.ConnectionString := m_strProvider;
     vConn.LoginPrompt      := False;
     vConn.Connected        := true;
     if vQry=Nil then
     Begin
      vQry := TADOQuery.Create(Nil);
      vQry.ConnectionString := m_strProvider;
     End;
    End;
End;
procedure CDBase.DestroyConnection(var vConn:TADOConnection;var vQry:TADOQuery);
Begin
    if vConn<>Nil then
    Begin
     vConn.Destroy;
     vConn := Nil;
     if vQry<>Nil then
     Begin
      vQry.Destroy;
      vQry := Nil;
     End;
    End;
End;
function CDBase.SaveParam(wMetID:Word;tTime:TDateTime;byParamType:Byte;pbyData:PByte):Boolean;
Begin
    Result := True;
End;
function CDBase.ReadParam(wMetID:Word;tTime:TDateTime;byParamType:Byte;pbyData:PByte):Boolean;
Begin
    Result := True;
End;
//Ports Routine

function CDBase.GetL1Table(var pTable:SL1INITITAG):Boolean;
Var
    i,nCount : Integer;
    res      : Boolean;
    strSQL   : String;
Begin
    strSQL := 'SELECT * FROM L1INITTAG';res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do
     Begin
      m_sbyLayerID := FieldByName('m_sbyLayerID').AsInteger;
      Count := FieldByName('M_SBYAMPORTS').AsInteger;
     End;
    CloseQry;

    strSQL := 'SELECT * FROM L1TAG ORDER BY m_sbyPortID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      m_sbyID       := FieldByName('m_sbyID').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      m_schName     := FieldByName('m_schName').AsString;
      m_sbyPortNum  := FieldByName('m_sbyPortNum').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      m_sbyProtID   := FieldByName('m_sbyProtID').AsInteger;
      m_sbyControl  := FieldByName('m_sbyControl').AsInteger;
      m_sbySpeed    := FieldByName('m_sbySpeed').AsInteger;
      m_sbyParity   := FieldByName('m_sbyParity').AsInteger;
      m_sbyData     := FieldByName('m_sbyData').AsInteger;
      m_sbyStop     := FieldByName('m_sbyStop').AsInteger;
      m_swDelayTime := FieldByName('m_swDelayTime').AsInteger;
      m_swAddres    := FieldByName('m_swAddres').AsInteger;
      m_sblReaddres := FieldByName('m_sblReaddres').AsInteger;
      m_schPhone    := FieldByName('m_schPhone').AsString;
      m_swIPPort    := FieldByName('m_swIPPort').AsString;
      m_schIPAddr   := FieldByName('m_schIPAddr').AsString;
      Inc(i);
      Next;
     End;
     End;
    res := True;
    End;
    CloseQry;
   Result := res;
   End;
End;
function CDBase.GetCtrConnTable(var pTable:SL1INITITAG):Boolean;
Var
    i,nCount : Integer;
    res      : Boolean;
    strSQL   : String;
Begin
    res := False;
    strSQL := 'SELECT * FROM L1TAG WHERE m_sbyControl=1 ORDER BY m_sbyPortID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      m_sbyID       := FieldByName('m_sbyID').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      m_schName     := FieldByName('m_schName').AsString;
      m_sbyPortNum  := FieldByName('m_sbyPortNum').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      m_sbyProtID   := FieldByName('m_sbyProtID').AsInteger;
      m_sbyControl  := FieldByName('m_sbyControl').AsInteger;
      m_sbySpeed    := FieldByName('m_sbySpeed').AsInteger;
      m_sbyParity   := FieldByName('m_sbyParity').AsInteger;
      m_sbyData     := FieldByName('m_sbyData').AsInteger;
      m_sbyStop     := FieldByName('m_sbyStop').AsInteger;
      m_swDelayTime := FieldByName('m_swDelayTime').AsInteger;
      m_swAddres    := FieldByName('m_swAddres').AsInteger;
      m_sblReaddres := FieldByName('m_sblReaddres').AsInteger;
      m_schPhone    := FieldByName('m_schPhone').AsString;
      m_swIPPort    := FieldByName('m_swIPPort').AsString;
      m_schIPAddr   := FieldByName('m_schIPAddr').AsString;
      Inc(i);
      Next;
     End;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetPortTable(var pTable:SL1TAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT * FROM L1TAG WHERE m_sbyPortID='+IntToStr(pTable.m_sbyPortID);res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do
     Begin
      m_sbyID       := FieldByName('m_sbyID').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      m_schName     := FieldByName('m_schName').AsString;
      m_sbyPortNum  := FieldByName('m_sbyPortNum').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      m_sbyProtID   := FieldByName('m_sbyProtID').AsInteger;
      m_sbyControl  := FieldByName('m_sbyControl').AsInteger;
      m_sbySpeed    := FieldByName('m_sbySpeed').AsInteger;
      m_sbyParity   := FieldByName('m_sbyParity').AsInteger;
      m_sbyData     := FieldByName('m_sbyData').AsInteger;
      m_sbyStop     := FieldByName('m_sbyStop').AsInteger;
      m_swDelayTime := FieldByName('m_swDelayTime').AsInteger;
      m_swAddres    := FieldByName('m_swAddres').AsInteger;
      m_sblReaddres := FieldByName('m_sblReaddres').AsInteger;
      m_schPhone    := FieldByName('m_schPhone').AsString;
      m_swIPPort    := FieldByName('m_swIPPort').AsString;
      m_schIPAddr   := FieldByName('m_schIPAddr').AsString;
     End;
    res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsPort(var pTable:SL1TAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM L1TAG WHERE m_sbyPortID='+IntToStr(pTable.m_sbyPortID);res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetPortTable(var pTable : SL1TAG):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE L1TAG SET '+
              ' m_schName='    +''''+m_schName+''''+
              ',m_sbyPortNum=' +IntToStr(m_sbyPortNum)+
              ',m_sbyType='    +IntToStr(m_sbyType)+
              ',m_sbyProtID='  +IntToStr(m_sbyProtID)+
              ',m_sbyControl=' +IntToStr(m_sbyControl)+
              ',m_sbySpeed='   +IntToStr(m_sbySpeed)+
              ',m_sbyParity='  +IntToStr(m_sbyParity)+
              ',m_sbyData='    +IntToStr(m_sbyData)+
              ',m_sbyStop='    +IntToStr(m_sbyStop)+
              ',m_swDelayTime='+IntToStr(m_swDelayTime)+
              ',m_swAddres='   +IntToStr(m_swAddres)+
              ',m_sblReaddres='+IntToStr(m_sblReaddres)+
              ',m_schPhone='   +''''+m_schPhone+''''+
              ',m_swIPPort='   +''''+m_swIPPort+''''+
              ',m_schIPAddr='  +''''+m_schIPAddr+''''+
              ' WHERE m_sbyPortID='+IntToStr(m_sbyPortID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddPortTable(var pTable:SL1TAG):Boolean;
Var
    strSQL   : String;
Begin
    //DecimalSeparator := '.';
    if IsPort(pTable)=True then Begin SetPortTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO L1TAG'+
              '(m_sbyPortID,m_schName,m_sbyPortNum,m_sbyType,m_sbyProtID,m_sbyControl,'+
              'm_sbySpeed,m_sbyParity,m_sbyData,m_sbyStop,'+
              'm_swDelayTime,m_swAddres,m_sblReaddres,m_schPhone,m_swIPPort,m_schIPAddr)'+
              ' VALUES('+
              IntToStr(m_sbyPortID)  +','+
              ''''+m_schName   +'''' +','+
              IntToStr(m_sbyPortNum) +','+
              IntToStr(m_sbyType)    +','+
              IntToStr(m_sbyProtID)  +','+
              IntToStr(m_sbyControl) +','+
              IntToStr(m_sbySpeed)   +','+
              IntToStr(m_sbyParity)  +','+
              IntToStr(m_sbyData)    +','+
              IntToStr(m_sbyStop)    +','+
              IntToStr(m_swDelayTime)+','+
              IntToStr(m_swAddres)   +','+
              IntToStr(m_sblReaddres)+','+
              ''''+m_schPhone   +''''+','+
              ''''+m_swIPPort   +''''+','+
              ''''+m_schIPAddr  +''''+')'
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelPortTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    strSQL := 'DELETE FROM L1TAG WHERE m_sbyPortID='+IntToStr(nIndex);
    Result := ExecQry(strSQL);
End;
//Meters Routine

function CDBase.GetMetersIniTable(var pTable:SL2INITITAG):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM L2TAG ORDER BY m_swMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;
     res := True;
     pTable.m_swAmMeter := nCount;
     SetLength(pTable.m_sMeter,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sMeter[i] do  Begin
      m_sbyID        := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID   := FieldByName('m_sbyGroupID').AsInteger;
      m_swMID        := FieldByName('m_swMID').AsInteger;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_sbyType      := FieldByName('m_sbyType').AsInteger;
      m_sbyLocation  := FieldByName('m_sbyLocation').AsInteger;
      m_sddFabNum    := FieldByName('m_sddFabNum').AsString;
      m_schPassword  := FieldByName('m_schPassword').AsString;
      m_sddPHAddres  := FieldByName('m_sddPHAddres').AsString;
      m_schName      := FieldByName('m_schName').AsString;
      m_sbyPortID    := FieldByName('m_sbyPortID').AsInteger;
      m_sbyRepMsg    := FieldByName('m_sbyRepMsg').AsInteger;
      m_swRepTime    := FieldByName('m_swRepTime').AsInteger;
      m_sfKI         := FieldByName('m_sfKI').asFloat;
      m_sfKU         := FieldByName('m_sfKU').asFloat;
      m_sfMeterKoeff := FieldByName('m_sfMeterKoeff').asFloat;
      m_swCurrQryTm  := FieldByName('m_swCurrQryTm').AsInteger;
      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sbyModem     := FieldByName('m_sbyModem').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_swMinNKan    := FieldByName('m_swMinNKan').AsInteger;
      m_swMaxNKan    := FieldByName('m_swMaxNKan').AsInteger;
      Next;
      Inc(i);
      End;
     End;           
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetMetersAll(var pTable:SL2INITITAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM L2TAG ORDER BY m_swMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmMeter := nCount;
     SetLength(pTable.m_sMeter,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sMeter[i] do  Begin
      m_sbyID        := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID   := FieldByName('m_sbyGroupID').AsInteger;
      m_swMID        := FieldByName('m_swMID').AsInteger;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_sbyType      := FieldByName('m_sbyType').AsInteger;
      m_sbyLocation  := FieldByName('m_sbyLocation').AsInteger;
      m_sddFabNum    := FieldByName('m_sddFabNum').AsString;
      m_schPassword  := FieldByName('m_schPassword').AsString;
      m_sddPHAddres  := FieldByName('m_sddPHAddres').AsString;
      m_schName      := FieldByName('m_schName').AsString;
      m_sbyPortID    := FieldByName('m_sbyPortID').AsInteger;
      m_sbyRepMsg    := FieldByName('m_sbyRepMsg').AsInteger;
      m_swRepTime    := FieldByName('m_swRepTime').AsInteger;
      m_sfKI         := FieldByName('m_sfKI').asFloat;
      m_sfKU         := FieldByName('m_sfKU').asFloat;
      m_sfMeterKoeff := FieldByName('m_sfMeterKoeff').asFloat;
      m_swCurrQryTm  := FieldByName('m_swCurrQryTm').AsInteger;
      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sbyModem     := FieldByName('m_sbyModem').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_swMinNKan    := FieldByName('m_swMinNKan').AsInteger;
      m_swMaxNKan    := FieldByName('m_swMaxNKan').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.GetMetersTable(nChannel:Integer;var pTable:SL2INITITAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM L2TAG WHERE m_sbyPortID='+IntToStr(nChannel)+ ' ORDER BY m_swMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmMeter := nCount;
     SetLength(pTable.m_sMeter,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sMeter[i] do  Begin
      m_sbyID        := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID   := FieldByName('m_sbyGroupID').AsInteger;
      m_swMID        := FieldByName('m_swMID').AsInteger;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_sbyType      := FieldByName('m_sbyType').AsInteger;
      m_sbyLocation  := FieldByName('m_sbyLocation').AsInteger;
      m_sddFabNum    := FieldByName('m_sddFabNum').AsString;
      m_schPassword  := FieldByName('m_schPassword').AsString;
      m_sddPHAddres  := FieldByName('m_sddPHAddres').AsString;
      m_schName      := FieldByName('m_schName').AsString;
      m_sbyPortID    := FieldByName('m_sbyPortID').AsInteger;
      m_sbyRepMsg    := FieldByName('m_sbyRepMsg').AsInteger;
      m_swRepTime    := FieldByName('m_swRepTime').AsInteger;
      m_sfKI         := FieldByName('m_sfKI').asFloat;
      m_sfKU         := FieldByName('m_sfKU').asFloat;
      m_sfMeterKoeff := FieldByName('m_sfMeterKoeff').asFloat;
      m_swCurrQryTm  := FieldByName('m_swCurrQryTm').AsInteger;
      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sbyModem     := FieldByName('m_sbyModem').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_swMinNKan    := FieldByName('m_swMinNKan').AsInteger;
      m_swMaxNKan    := FieldByName('m_swMaxNKan').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.GetMeterTable(var pTable:SL2TAG):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    strSQL := 'SELECT * FROM L2TAG'+
    ' WHERE m_sbyPortID='+IntToStr(pTable.m_sbyPortID)+' and '+'m_swMID='+IntToStr(pTable.m_swMID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do  Begin
      m_sbyID        := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID   := FieldByName('m_sbyGroupID').AsInteger;
      m_swMID        := FieldByName('m_swMID').AsInteger;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_sbyType      := FieldByName('m_sbyType').AsInteger;
      m_sbyLocation  := FieldByName('m_sbyLocation').AsInteger;
      m_sddFabNum    := FieldByName('m_sddFabNum').AsString;
      m_schPassword  := FieldByName('m_schPassword').AsString;
      m_sddPHAddres  := FieldByName('m_sddPHAddres').AsString;
      m_schName      := FieldByName('m_schName').AsString;
      m_sbyPortID    := FieldByName('m_sbyPortID').AsInteger;
      m_sbyRepMsg    := FieldByName('m_sbyRepMsg').AsInteger;
      m_swRepTime    := FieldByName('m_swRepTime').AsInteger;
      m_sfKI         := FieldByName('m_sfKI').asFloat;
      m_sfKU         := FieldByName('m_sfKU').asFloat;
      m_sfMeterKoeff := FieldByName('m_sfMeterKoeff').asFloat;
      m_swCurrQryTm  := FieldByName('m_swCurrQryTm').AsInteger;
      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sbyModem     := FieldByName('m_sbyModem').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_swMinNKan    := FieldByName('m_swMinNKan').AsInteger;
      m_swMaxNKan    := FieldByName('m_swMaxNKan').AsInteger;
     End;
     res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetMeterTableForReport(GroupID : integer;var pTable : SL2TAGREPORTLIST) : boolean;
Var
    nCount,i : Integer;
    res      : Boolean;
    strSQL   : String;
begin
    res := False;
    if GroupID <> - 1 then
      strSQL := 'SELECT SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM, SL3VMETERTAG.m_swvmid, '+
                'L2TAG.M_SWMID, M_SFKI, M_SFKU, m_sname ' +
                'from SL3VMETERTAG, L2TAG, QM_METERS ' +
                'where l2tag.m_swmid = SL3VMETERTAG.m_swmid and QM_METERS.m_swtype = SL3VMETERTAG.m_sbytype' +
                ' and  SL3VMETERTAG.M_SBYGROUPID = ' + IntToStr(GroupID)
    else
      strSQL := 'SELECT SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM, SL3VMETERTAG.m_swvmid, '+
                'L2TAG.M_SWMID, M_SFKI, M_SFKU, m_sname ' +
                'from SL3VMETERTAG, L2TAG, QM_METERS ' +
                'where l2tag.m_swmid = SL3VMETERTAG.m_swmid and QM_METERS.m_swtype = SL3VMETERTAG.m_sbytype';
    i := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     pTable.Count := nCount;
     SetLength(pTable.m_sMeter, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery,pTable.m_sMeter[i] do
       Begin
         m_sVMeterName := FieldByName('m_svmetername').AsString;
         m_sddPHAddres := FieldByName('M_SDDFABNUM').AsString;
         m_swVMID      := FieldByName('m_swvmid').AsInteger;
         m_swMID       := FieldByName('M_SWMID').AsInteger;
         m_sfKI        := FieldByName('M_SFKI').AsFloat;
         m_sfKU        := FieldByName('M_SFKU').AsFloat;
         m_sName       := FieldByName('m_sname').AsString;
         Inc(i);
         Next;
       End;
     end;
     res := True;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.GetMeterLocation(FMID:Integer;var FLocation:Integer):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    strSQL := 'SELECT m_sbyLocation FROM L2TAG WHERE m_swMID='+IntToStr(FMID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     FLocation := FADOQuery.FieldByName('m_sbyLocation').AsInteger;
     res := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsMeter(var pTable:SL2TAG):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    //if pTable.m_sbyType <> MET_BTI then
      strSQL := 'SELECT 0 FROM L2TAG'+
      ' WHERE m_sbyPortID='+IntToStr(pTable.m_sbyPortID)+' and '+'m_swMID='+IntToStr(pTable.m_swMID);
    {else
      strSQL := 'SELECT 0 FROM L2TAG'+
      ' WHERE m_sbyPortID='+IntToStr(pTable.m_sbyPortID)+' and '+'m_sddPHAddres='+''''+pTable.m_sddPHAddres+'''';}
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetMeterTable(var pTable:SL2TAG):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE L2TAG SET '+
              ' m_sbyGroupID='  +IntToStr(m_sbyGroupID)+
              ',m_swMID='       +IntToStr(m_swMID)+
              ',m_swVMID='      +IntToStr(m_swVMID)+
              ',m_sbyType='     +IntToStr(m_sbyType)+
              ',m_sbyLocation=' +IntToStr(m_sbyLocation)+
              ',m_sddFabNum='   +''''+m_sddFabNum+''''+
              ',m_schPassword=' +''''+m_schPassword+''''+
              ',m_sddPHAddres=' +''''+m_sddPHAddres+''''+
              ',m_schName='     +''''+m_schName+''''+
              ',m_sbyPortID='   +IntToStr(m_sbyPortID)+
              ',m_sbyRepMsg='   +IntToStr(m_sbyRepMsg)+
              ',m_swRepTime='   +IntToStr(m_swRepTime)+
              ',m_sfKI='        +FloatToStr(m_sfKI)+
              ',m_sfKU='        +FloatToStr(m_sfKU)+
              ',m_sfMeterKoeff='+FloatToStr(m_sfMeterKoeff)+
              ',m_swCurrQryTm=' +IntToStr(m_swCurrQryTm)+
              ',m_sPhone='      +''''+m_sPhone+''''+
              ',m_sbyModem='    +IntToStr(m_sbyModem)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ',m_swMinNKan='   +IntToStr(m_swMinNKan) +
              ',m_swMaxNKan='   +IntToStr(m_swMaxNKan) +
              ' WHERE m_swMID='+IntToStr(m_swMID);
              //' WHERE m_sbyPortID='+IntToStr(m_sbyPortID)+' and '+'m_swMID='+IntToStr(m_swMID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddMeterTable(var pTable:SL2TAG):Boolean;
Var
    strSQL   : String;
Begin
    //DecimalSeparator := '.';
    if IsMeter(pTable)=True then Begin SetMeterTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO L2TAG'+
              '(m_sbyGroupID,m_swMID,m_swVMID,m_sbyType,m_sbyLocation,m_sddFabNum,'+
              'm_schPassword,m_sddPHAddres,m_schName,m_sbyPortID,'+
              'm_sbyRepMsg,m_swRepTime,m_sfKI,m_sfKU,m_sfMeterKoeff,'+
              'm_swCurrQryTm,m_sPhone,m_sbyModem,m_sbyEnable,' +
              'm_swMinNKan, m_swMaxNKan)'+
              ' VALUES('+
              IntToStr(m_sbyGroupID)+ ','+
              IntToStr(m_swMID)+ ','+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_sbyType)+ ','+
              IntToStr(m_sbyLocation)+ ','+
              ''''+m_sddFabNum +''''+','+
              ''''+m_schPassword +''''+','+
              ''''+m_sddPHAddres +''''+','+
              ''''+m_schName     +''''+','+
              IntToStr(m_sbyPortID)+ ','+
              IntToStr(m_sbyRepMsg)+ ','+
              IntToStr(m_swRepTime)+ ','+
              FloatToStr(m_sfKI)+ ','+
              FloatToStr(m_sfKU)+ ','+
              FloatToStr(m_sfMeterKoeff)+ ','+
              IntToStr(m_swCurrQryTm)+ ','+
              ''''+m_sPhone +''''+ ','+
              IntToStr(m_sbyModem)+ ',' +
              IntToStr(m_sbyEnable)+ ',' +
              IntToStr(m_swMinNKan) + ',' +
              IntToStr(m_swMaxNKan) + ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelMeterTable(nMasterIndex,nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM L2TAG WHERE m_sbyPortID='+IntToStr(nMasterIndex)+' and m_swMID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM L2TAG WHERE m_sbyPortID='+IntToStr(nMasterIndex);
    Result := ExecQry(strSQL);
End;

function CDBase.GetCommandsTable(nChannel:Integer;var pTable:CCOMMANDS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM CCOMMAND WHERE m_swMID='+IntToStr(nChannel)+'ORDER BY m_swCmdID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmCommand := nCount;
     SetLength(pTable.m_sCommand,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sCommand[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swMID     := FieldByName('m_swMID').AsInteger;
      m_swCmdID   := FieldByName('m_swCmdID').AsInteger;
      m_swSpecc0  := FieldByName('m_swSpecc0').AsInteger;
      m_swSpecc1  := FieldByName('m_swSpecc1').AsInteger;
      m_swSpecc2  := FieldByName('m_swSpecc2').AsInteger;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetCommandTable(var pTable:CCOMMAND):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM CCOMMAND WHERE m_swID='+IntToStr(pTable.m_swID)+
              ' and m_swMID='+IntToStr(pTable.m_swMID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsCommands(nIndex:Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM CCOMMAND WHERE m_swMID='+IntToStr(nIndex);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetCommandTable(var pTable:CCOMMAND):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE CCOMMAND SET '+
              ' m_swMID='       +IntToStr(m_swMID)+
              ',m_swCmdID='     +IntToStr(m_swCmdID)+
              ',m_swSpecc0='    +IntToStr(m_swSpecc0)+
              ',m_swSpecc1='    +IntToStr(m_swSpecc1)+
              ',m_swSpecc2='    +IntToStr(m_swSpecc2)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ' WHERE m_swMID=' +IntToStr(m_swMID)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
{
     m_swID       : Word;
     m_swMID      : Word;
     m_swCmdID    : Word;
     m_swSpecc0   : Word;
     m_swSpecc1   : Word;
     m_swSpecc2   : Word;
     m_sbyEnable  : Byte;
}
function CDBase.AddCommandTable(var pTable:CCOMMAND):Boolean;
Var
    strSQL   : String;
Begin
    //DecimalSeparator := '.';
    if GetCommandTable(pTable)=True then Begin Result := SetCommandTable(pTable);exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO CCOMMAND'+
              '(m_swMID,m_swCmdID,m_sExpress,m_swSpecc1,m_swSpecc2,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swMID)+ ','+
              IntToStr(m_swCmdID)+ ','+
              IntToStr(m_swSpecc0)+ ','+
              IntToStr(m_swSpecc1)+ ','+
              IntToStr(m_swSpecc2)+ ','+
              IntToStr(m_sbyEnable)+')';
    End;
    Result := ExecQry(strSQL);
End;
{
QM_COMMAND = packed record
     m_swID      : Word;
     m_swType    : Word;
     m_swCMDID   : Word;
     m_sName     : string[40];
     m_swSpec0   : Integer;
     m_swSpec1   : Integer;
     m_swSpec2   : Integer;
     m_sblSaved  : Byte;
     m_sbyEnable : Byte;
     m_sbyDirect : Byte;
    end;
}
function CDBase.InsertCommand(nIndex,nMeterType:Integer):Boolean;
Var
    strSQL   : String;
    nCount   : Integer;
    res      : Boolean;
    pTable   : CCOMMAND;
Begin
    if IsCommands(nIndex)=False then
    Begin
     strSQL := 'INSERT INTO CCOMMAND(m_swMID,m_swCmdID,m_swSpecc0,m_swSpecc1,m_swSpecc2,m_sblSaved,m_sbyEnable)'+
               ' SELECT '+IntToStr(nIndex)+',m_swCMDID,m_swSpec0,m_swSpec1,m_swSpec2,m_sblSaved,m_sbyEnable'+
               ' FROM QM_COMMANDS WHERE m_swType='+IntToStr(nMeterType)+
               ' and QM_COMMANDS.m_sbyDirect=1 and QM_COMMANDS.m_sbyEnable=1';
     Result := ExecQry(strSQL);
    End;
End;
function CDBase.LoadCommand(nIndex,nMeterType:Integer):Boolean;
Var
    strSQL   : String;
    nCount   : Integer;
    res      : Boolean;
    pTable   : CCOMMAND;
Begin
    strSQL := 'DELETE FROM CCOMMAND WHERE m_swMID='+IntToStr(nIndex);
    Result := ExecQry(strSQL);
    strSQL := 'INSERT INTO CCOMMAND(m_swMID,m_swCmdID,m_swSpecc0,m_swSpecc1,m_swSpecc2,m_sblSaved,m_sbyEnable)'+
              ' SELECT '+IntToStr(nIndex)+',m_swCMDID,m_swSpec0,m_swSpec1,m_swSpec2,m_sblSaved,m_sbyEnable'+
              ' FROM QM_COMMANDS WHERE m_swType='+IntToStr(nMeterType)+
              ' and (QM_COMMANDS.m_sbyDirect=0 or QM_COMMANDS.m_sbyDirect=1) and QM_COMMANDS.m_sbyEnable=1';
    Result := ExecQry(strSQL);
End;
function CDBase.DelCommandTable(nIndex:Integer;nCmdIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    strSQL := 'DELETE FROM CCOMMAND WHERE m_swMID='+IntToStr(nIndex)+' and m_swID='+IntToStr(nCmdIndex);
    if nCmdIndex=-1 then
    strSQL := 'DELETE FROM CCOMMAND WHERE m_swMID='+IntToStr(nIndex);
    Result := ExecQry(strSQL);
End;

function CDBase.GetGroupsTable(var pTable:SL3INITTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT * FROM SL3INITTAG';res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do
     Begin
      m_sbyLayerID := FieldByName('m_sbyLayerID').AsInteger;
      m_swAmGroup  := FieldByName('m_swAmGroup').AsInteger;
     End;
    CloseQry;
    strSQL := 'SELECT * FROM SL3GROUPTAG ORDER BY m_sbyGroupID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     SetLength(pTable.m_sGroups,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sGroups[i] do Begin
      m_sbyID         := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      m_sGroupName    := FieldByName('m_sGroupName').AsString;
      m_sGroupExpress := FieldByName('m_sGroupExpress').AsString;
      m_sbyEnable     := FieldByName('m_sbyEnable').AsInteger;
      Inc(i);
      Next;
     End;
     End;
    res := True;
    End;
    CloseQry;
   Result := res;
   End;
End;
function CDBase.GetGroupTbl(var pTable:SL3GROUPTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3GROUPTAG WHERE m_sbyGroupID='+IntToStr(pTable.m_sbyGroupID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    with FADOQuery,pTable do
     Begin
     res   := True;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetGroupTable(var pTable:SL3GROUPTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT * FROM SL3GROUPTAG WHERE m_sbyGroupID='+IntToStr(pTable.m_sbyGroupID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    with FADOQuery,pTable do
     Begin
      m_sbyID         := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      m_sGroupName    := FieldByName('m_sGroupName').AsString;
      m_sGroupExpress := FieldByName('m_sGroupExpress').AsString;
      m_sbyEnable     := FieldByName('m_sbyEnable').AsInteger;
     res   := True;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetGroupTable(var pTable:SL3GROUPTAG):Boolean;
Var
    strSQL : String;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3GROUPTAG SET '+
              'm_sGroupName='    +''''+m_sGroupName+''''+
              ',m_sGroupExpress=' +''''+m_sGroupExpress+''''+
              ',m_sbyEnable=' +IntToStr(m_sbyEnable)+
              ' WHERE m_sbyGroupID=' +IntToStr(m_sbyGroupID);
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AddGroupTable(var pTable:SL3GROUPTAG):Boolean;
Var
    strSQL : String;
Begin
    if GetGroupTbl(pTable)=True then Begin Result := SetGroupTable(pTable);exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3GROUPTAG'+
              '(m_sbyGroupID,m_sGroupName,m_sGroupExpress,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_sbyGroupID)+ ','+
              ''''+m_sGroupName+''''+ ','+
              ''''+m_sGroupExpress+''''+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelGroupTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then strSQL := 'DELETE FROM SL3GROUPTAG WHERE m_sbyGroupID='+IntToStr(nIndex);
    if nIndex=-1  then strSQL := 'DELETE FROM SL3GROUPTAG ';
    Result := ExecQry(strSQL);
End;
function CDBase.GetVMetersTable(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nChannel<>-1 then strSQL := 'SELECT * FROM SL3VMETERTAG WHERE m_sbyGroupID='+IntToStr(nChannel)+ ' ORDER BY m_swVMID';
    if nChannel=-1  then strSQL := 'SELECT * FROM SL3VMETERTAG ORDER BY m_swVMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     SetLength(pTable.m_sVMeters,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sVMeters[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swMID       := FieldByName('m_swMID').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      m_sbyGroupID  := FieldByName('m_sbyGroupID').AsInteger;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_sddPHAddres := FieldByName('m_sddPHAddres').AsString;
      m_sMeterName  := FieldByName('m_sMeterName').AsString;
      m_sVMeterName := FieldByName('m_sVMeterName').AsString;
      m_sbyExport   := FieldByName('m_sbyExport').AsInteger;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetVMetersTypeTable(nChannel,nType:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nType=-1 then
    Begin
     if nChannel<>-1 then strSQL := 'SELECT * FROM SL3VMETERTAG WHERE m_sbyGroupID='+IntToStr(nChannel)+' ORDER BY m_swVMID';
     if nChannel=-1  then strSQL := 'SELECT * FROM SL3VMETERTAG ORDER BY m_swVMID';
    End else
    if nType<>-1 then
    Begin
     if nChannel<>-1 then strSQL := 'SELECT * FROM SL3VMETERTAG WHERE m_sbyGroupID='+IntToStr(nChannel)+' and m_sbyType='+IntToStr(nType)+' ORDER BY m_swVMID';
     if nChannel=-1  then strSQL := 'SELECT * FROM SL3VMETERTAG WHERE m_sbyType='+IntToStr(nType)+ ' ORDER BY m_swVMID';
    End;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     SetLength(pTable.m_sVMeters,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sVMeters[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swMID       := FieldByName('m_swMID').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      m_sbyGroupID  := FieldByName('m_sbyGroupID').AsInteger;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_sddPHAddres := FieldByName('m_sddPHAddres').AsString;
      m_sMeterName  := FieldByName('m_sMeterName').AsString;
      m_sVMeterName := FieldByName('m_sVMeterName').AsString;
      m_sbyExport   := FieldByName('m_sbyExport').AsInteger;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetVMetersFullTable(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if GetVMetersTable(nChannel,pTable) then
    Begin
     for i:=0 to pTable.m_swAmVMeter-1 do
     Begin
      if GetVParamsTable(pTable.m_sVMeters[i].m_swVMID,pTable.m_sVMeters[i])=True then
      res := True;;
     End;
    End;
    Result := res;
End;
{
     m_swID          : Word;
     m_swMID         : WORD;
     m_sbyGroupID    : Byte;
     m_swVMID        : WORD;
     m_sMeterName    : String[30];
     m_sVMeterName   : String[30];
}
function CDBase.GetVMeterTbl(var pTable:SL3VMETERTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3VMETERTAG WHERE m_swVMID='+IntToStr(pTable.m_swVMID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    with FADOQuery,pTable do
    Begin
     res   := True;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetVMeterTable(var pTable:SL3VMETERTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT * FROM SL3VMETERTAG WHERE m_swVMID='+IntToStr(pTable.m_swVMID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    with FADOQuery,pTable do
     Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swMID       := FieldByName('m_swMID').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      m_sbyGroupID  := FieldByName('m_sbyGroupID').AsInteger;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_sddPHAddres := FieldByName('m_sddPHAddres').AsString;
      m_sMeterName  := FieldByName('m_sMeterName').AsString;
      m_sVMeterName := FieldByName('m_sVMeterName').AsString;
      m_sbyExport   := FieldByName('m_sbyExport').AsInteger;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
     res   := True;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetVMeterTable(var pTable:SL3VMETERTAG):Boolean;
Var
    strSQL : String;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3VMETERTAG SET '+
              'm_swMID='         +IntToStr(m_swMID)+
              ',m_sbyPortID='    +IntToStr(m_sbyPortID)+
              ',m_sbyType='      +IntToStr(m_sbyType)+
              ',m_sbyGroupID='   +IntToStr(m_sbyGroupID)+
              ',m_sddPHAddres='  +''''+m_sddPHAddres+''''+
              ',m_sMeterName='   +''''+m_sMeterName+''''+
              ',m_sVMeterName='  +''''+m_sVMeterName+''''+
              ',m_sbyExport='    +IntToStr(m_sbyExport)+
              ',m_sbyEnable='    +IntToStr(m_sbyEnable)+
              ' WHERE m_swVMID=' +IntToStr(m_swVMID);
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AddVMeterTable(var pTable:SL3VMETERTAG):Boolean;
Var
    strSQL : String;
Begin
    if GetVMeterTbl(pTable)=True then Begin Result := SetVMeterTable(pTable);exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3VMETERTAG'+
              '(m_swMID,m_sbyPortID,m_sbyType,m_sbyGroupID,m_swVMID,m_sddPHAddres,m_sMeterName,m_sVMeterName,m_sbyExport,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swMID)+ ','+
              IntToStr(m_sbyPortID)+ ','+
              IntToStr(m_sbyType)+ ','+
              IntToStr(m_sbyGroupID)+ ','+
              IntToStr(m_swVMID)+ ','+
              ''''+m_sddPHAddres+''''+ ','+
              ''''+m_sMeterName+''''+ ','+
              ''''+m_sVMeterName+''''+','+
              IntToStr(m_sbyExport)+ ','+
              IntToStr(m_sbyEnable)+ ')';

    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelVMeterTable(nMIndex,nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then strSQL := 'DELETE FROM SL3VMETERTAG WHERE m_sbyGroupID='+IntToStr(nMIndex)+' and m_swVMID='+IntToStr(nIndex);
    if nIndex=-1  then strSQL := 'DELETE FROM SL3VMETERTAG WHERE m_sbyGroupID='+IntToStr(nMIndex);
    Result := ExecQry(strSQL);
End;

//Meters Type Routine
{
     m_swID     : Word;
     m_swType   : Word;
     m_sName    : String[40];
     m_sComment : String[40];
}
function CDBase.GetMetersTypeTable(var pTable:QM_METERS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM QM_METERS ORDER BY m_swType';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmMeterType := nCount;
     SetLength(pTable.m_sMeterType,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sMeterType[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swType   := FieldByName('m_swType').AsInteger;
      m_sName    := FieldByName('m_sName').AsString;
      m_sComment := FieldByName('m_sComment').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetMeterTypeTable(var pTable:QM_METER):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT * FROM QM_METERS WHERE m_swType='+IntToStr(pTable.m_swType);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     pTable.m_sName := FADOQuery.FieldByName('m_sName').AsString;
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsMeterTypeTable(var pTable:QM_METER):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT * FROM QM_METERS WHERE m_swType='+IntToStr(pTable.m_swType);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetMeterTypeTable(var pTable:QM_METER):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE QM_METERS SET '+
              ' m_swType='      +IntToStr(m_swType)+
              ',m_sName='       +''''+m_sName+''''+
              ',m_sComment='    +''''+m_sComment+''''+
              ' WHERE m_swType=' +IntToStr(m_swType)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddMeterTypeTable(var pTable:QM_METER):Boolean;
Var
    strSQL   : String;
Begin
    if IsMeterTypeTable(pTable)=True then Begin SetMeterTypeTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO QM_METERS'+
              '(m_swType,m_sName,m_sComment)'+
              ' VALUES('+
              IntToStr(m_swType)+ ','+
              ''''+m_sName+''''+ ','+
              ''''+m_sComment+''''+')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelMeterTypeTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM QM_METERS WHERE m_swType='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM QM_METERS';
    Result := ExecQry(strSQL);
End;
{
QM_PARAM = packed record
     m_swID      : Word;
     m_swType    : Word;
     m_sName     : String[40];
     m_sShName   : String[40];
     m_sEName    : String[40];
     m_swActive  : Byte;
     m_swStatus  : Byte;
     m_swIsGraph : Byte;
    end;
    PQM_PARAM =^ QM_PARAM;
    QM_PARAMS = packed record
     m_swAmParamType : Word;
     m_sParamType    : array of QM_PARAM;
    end;
}
function CDBase.GetParamsTypeTable(var pTable:QM_PARAMS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM QM_PARAMS ORDER BY m_swType';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID         := FieldByName('m_swID').AsInteger;
      m_swType       := FieldByName('m_swType').AsInteger;
      m_sName        := FieldByName('m_sName').AsString;
      //m_sShName     := FieldByName('m_sShName').AsString;
      m_sEName       := FieldByName('m_sEName').AsString;
      m_sEMet        := FieldByName('m_sEMet').AsString;
      m_swSvPeriod   := FieldByName('m_swSvPeriod').AsInteger;
      m_sblTarif     := FieldByName('m_sblTarif').AsInteger;
      m_swActive     := FieldByName('m_swActive').AsInteger;
      m_swStatus     := FieldByName('m_swStatus').AsInteger;
      m_swIsGraph    := FieldByName('m_swIsGraph').AsInteger;
      m_sbyDataGroup := FieldByName('m_sbyDataGroup').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetParamTypeTable(var pTable:QM_PARAM):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM QM_PARAMS WHERE m_swType='+IntToStr(pTable.m_swType);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
{
     m_swID      : Word;
     m_swType    : Word;
     m_sName     : String[40];
     m_sShName   : String[40];
     m_sEName    : String[40];
     m_swActive  : Byte;
     m_swStatus  : Byte;
     m_swIsGraph : Byte;
}
function CDBase.SetParamTypeTable(var pTable:QM_PARAM):Boolean;
Var
    strSQL : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE QM_PARAMS SET '+
              ' m_swType='      +IntToStr(m_swType)+
              ',m_sName='       +''''+m_sName+''''+
              //',m_sShName='     +''''+m_sShName+''''+
              ',m_sEName='      +''''+m_sEName+''''+
              ',m_sEMet='       +''''+m_sEMet+''''+
              ',m_swSvPeriod='  +IntToStr(m_swSvPeriod)+
              ',m_sblTarif='    +IntToStr(m_sblTarif)+
              ',m_swActive='    +IntToStr(m_swActive)+
              ',m_swStatus='    +IntToStr(m_swStatus)+
              ',m_swIsGraph='   +IntToStr(m_swIsGraph)+
              ',m_sbyDataGroup='+IntToStr(m_sbyDataGroup)+
              ' WHERE m_swType='+IntToStr(m_swType)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddParamTypeTable(var pTable:QM_PARAM):Boolean;
Var
    strSQL   : String;
Begin
    if GetParamTypeTable(pTable)=True then Begin SetParamTypeTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO QM_PARAMS'+
              '(m_swType,m_sName,m_sEName,m_sEMet,m_swSvPeriod,m_sblTarif,m_swActive,m_swStatus,m_swIsGraph,m_sbyDataGroup)'+
              ' VALUES('+
              IntToStr(m_swType)+ ','+
              ''''+m_sName+''''+ ','+
              ''''+m_sEName+''''+ ','+
              ''''+m_sEMet+''''+ ','+
              IntToStr(m_swSvPeriod)+ ','+
              IntToStr(m_sblTarif)+ ','+
              IntToStr(m_swActive)+ ','+
              IntToStr(m_swStatus)+ ','+
              IntToStr(m_swIsGraph)+ ','+
              IntToStr(m_sbyDataGroup)+')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelParamTypeTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM QM_PARAMS WHERE m_swType='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM QM_PARAMS';
    Result := ExecQry(strSQL);
End;
function CDBase.GetConnTable(var pTable:SL3CONNTBLS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if (m_byConnectionLevel=1)or(m_byConnectionLevel=2) then res:=GetConnTableSA(pTable) else
    Begin
    strSQL := 'SELECT * FROM SL3CONNTBL ORDER BY m_swCNID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swCNID      := FieldByName('m_swCNID').AsInteger;
      m_swCPortID   := FieldByName('m_swCPortID').AsInteger;
      m_swLocation  := FieldByName('m_swLocation').AsInteger;
      m_swNetMode   := FieldByName('m_swNetMode').AsInteger;
      m_sName       := FieldByName('m_sName').AsString;
      m_sConnString := FieldByName('m_sConnString').AsString;
      m_sLogin      := FieldByName('m_sLogin').AsString;
      m_sPassword   := FieldByName('m_sPassword').AsString;
      m_sPasswordL2 := FieldByName('m_sPasswordL2').AsString;
      m_sPasswordL3 := FieldByName('m_sPasswordL3').AsString;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    End;
    Result := res;
End;
function CDBase.GetConnTableSA(var pTable:SL3CONNTBLS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3CONNTBL ORDER BY m_swCNID';
    if OpenQrySA(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuerySA.Eof do Begin
     with FADOQuerySA,pTable.Items[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swCNID      := FieldByName('m_swCNID').AsInteger;
      m_swCPortID   := FieldByName('m_swCPortID').AsInteger;
      m_swLocation  := FieldByName('m_swLocation').AsInteger;
      m_swNetMode   := FieldByName('m_swNetMode').AsInteger;
      m_sName       := FieldByName('m_sName').AsString;
      m_sConnString := FieldByName('m_sConnString').AsString;
      m_sLogin      := FieldByName('m_sLogin').AsString;
      m_sPassword   := FieldByName('m_sPassword').AsString;
      m_sPasswordL2 := FieldByName('m_sPasswordL2').AsString;
      m_sPasswordL3 := FieldByName('m_sPasswordL3').AsString;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQrySA;
    Result := res;
End;
function CDBase.IsSlaveConn(nIndex:Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    if (m_byConnectionLevel=1)or(m_byConnectionLevel=2) then res:=IsSlaveConnSA(nIndex) else
    Begin
     strSQL := 'SELECT 0 FROM SL3CONNTBL WHERE m_swCPortID='+IntToStr(nIndex)+' and m_swNetMode=0';
     res := False;
     if OpenQry(strSQL,nCount)=True then
     Begin
      res   := True;
     End;
     CloseQry;
    End;
    Result := res;
End;
function CDBase.IsSlaveConnSA(nIndex:Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3CONNTBL WHERE m_swCPortID='+IntToStr(nIndex)+' and m_swNetMode=0';
    res := False;
    if OpenQrySA(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQrySA;
    Result := res;
End;
function CDBase.IsLocalConn(nIndex:Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    if (m_byConnectionLevel=1)or(m_byConnectionLevel=2) then res:=IsLocalConnSA(nIndex) else
    Begin
     strSQL := 'SELECT 0 FROM SL3CONNTBL WHERE m_swCPortID='+IntToStr(nIndex)+' and m_swLocation=0';
     res := False;
     if OpenQrySA(strSQL,nCount)=True then
     Begin
      res   := True;
     End;
     CloseQrySA;
    End;
    Result := res;
End;
function CDBase.IsLocalConnSA(nIndex:Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3CONNTBL WHERE m_swCPortID='+IntToStr(nIndex)+' and m_swLocation=0';
    res := False;
    if OpenQrySA(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQrySA;
    Result := res;
End;
function CDBase.IsConnTable(var pTable:SL3CONNTBL):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3CONNTBL WHERE m_swCNID='+IntToStr(pTable.m_swCNID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetConnTable(var pTable:SL3CONNTBL):Boolean;
Var
    strSQL : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3CONNTBL SET '+
              ' m_swID='       +IntToStr(m_swID)+
              ',m_swCNID='     +IntToStr(m_swCNID)+
              ',m_swCPortID='  +IntToStr(m_swCPortID)+
              ',m_swLocation=' +IntToStr(m_swLocation)+
              ',m_swNetMode='   +IntToStr(m_swNetMode)+
              ',m_sName='      +''''+m_sName+''''+
              ',m_sConnString='+''''+m_sConnString+''''+
              ',m_sLogin='     +''''+m_sLogin+''''+
              ',m_sPassword='  +''''+m_sPassword+''''+
              ',m_sPasswordL2='+''''+m_sPasswordL2+''''+
              ',m_sPasswordL3='+''''+m_sPasswordL3+''''+
              ',m_sbyEnable='  +IntToStr(m_sbyEnable)+
              ' WHERE m_swCNID='+IntToStr(m_swCNID)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddConnTable(var pTable:SL3CONNTBL):Boolean;
Var
    strSQL   : String;
Begin
    Result:=False;
    //if m_byConnectionLevel=0 then Begin
    if IsConnTable(pTable)=True then Begin SetConnTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3CONNTBL'+
              '(m_swCNID,m_swCPortID,m_swLocation,m_swNetMode,m_sName,m_sConnString,m_sLogin,m_sPassword,m_sPasswordL2,m_sPasswordL3,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swCNID)+ ','+
              IntToStr(m_swCPortID)+ ','+
              IntToStr(m_swLocation)+ ','+
              IntToStr(m_swNetMode)+ ','+
              ''''+m_sName+''''+ ','+
              ''''+m_sConnString+''''+ ','+
              ''''+m_sLogin+''''+ ','+
              ''''+m_sPassword+''''+ ','+
              ''''+m_sPasswordL2+''''+ ','+
              ''''+m_sPasswordL3+''''+ ','+
              IntToStr(m_sbyEnable)+')';
    End;
    Result := ExecQry(strSQL);
    //End;
End;
function CDBase.DelConnTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM SL3CONNTBL WHERE m_swCNID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM SL3CONNTBL';
    Result := ExecQry(strSQL);
End;


//QManager Commands Routine
{
     m_swID      : Word;
     m_swType    : Word;
     m_swCMDID   : Word;
     m_sName     : String[40];
     m_swSpec0   : Word;
     m_swSpec1   : Word;
     m_swSpec2   : Word;
     m_sbyEnable : Byte;
     m_sComment  : String[40];
}
function CDBase.GetQMCommandsTable(nIndex:Integer;var pTable:QM_COMMANDS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    //if nIndex=-1 then  strSQL := 'SELECT DISTINCT * FROM QM_COMMANDS ORDER BY m_swCMDID';
    //if nIndex<>-1 then
    strSQL := 'SELECT * FROM QM_COMMANDS WHERE m_swType='+IntToStr(nIndex)+'ORDER BY m_swCMDID';
    //strSQL := 'SELECT * FROM QM_COMMANDS WHERE m_swType='+IntToStr(nIndex)+' ORDER BY m_swID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmCommandType := nCount;
     SetLength(pTable.m_sCommandType,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sCommandType[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swType   := FieldByName('m_swType').AsInteger;
      m_swCMDID  := FieldByName('m_swCMDID').AsInteger;
      m_sName    := FieldByName('m_sName').AsString;
      m_swSpec0  := FieldByName('m_swSpec0').AsInteger;
      m_swSpec1  := FieldByName('m_swSpec1').AsInteger;
      m_swSpec2  := FieldByName('m_swSpec2').AsInteger;
      m_sblSaved := FieldByName('m_sblSaved').AsInteger;
      m_sbyEnable:= FieldByName('m_sbyEnable').AsInteger;
      m_sbyDirect:= FieldByName('m_sbyDirect').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetQMCommandTable(var pTable:QM_COMMAND):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT * FROM QM_COMMANDS WHERE m_swType='+IntToStr(pTable.m_swType)+
              ' and m_swCMDID='+IntToStr(pTable.m_swCMDID);
    //strSQL := 'SELECT 0 FROM QM_COMMANDS WHERE m_swID='+IntToStr(pTable.m_swID)+
    //          ' and m_swType='+IntToStr(pTable.m_swType);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
{
     m_swID      : Word;
     m_swType    : Word;
     m_swCMDID   : Word;
     m_sName     : String[40];
     m_swSpec0   : Word;
     m_swSpec1   : Word;
     m_swSpec2   : Word;
     m_sbyEnable : Byte;
     m_sComment  : String[40];
}
function CDBase.SetQMCommandTable(var pTable:QM_COMMAND):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE QM_COMMANDS SET '+
              ' m_swType='      +IntToStr(m_swType)+
              ',m_swCMDID='     +IntToStr(m_swCMDID)+
              ',m_sName='       +''''+m_sName+''''+
              ',m_swSpec0='     +IntToStr(m_swSpec0)+
              ',m_swSpec1='     +IntToStr(m_swSpec1)+
              ',m_swSpec2='     +IntToStr(m_swSpec2)+
              ',m_sblSaved='    +IntToStr(m_sblSaved)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ',m_sbyDirect='   +IntToStr(m_sbyDirect)+
              ' WHERE m_swType=' +IntToStr(m_swType)+' and m_swCMDID='+IntToStr(m_swCMDID);
              //' WHERE m_swType=' +IntToStr(m_swType)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddQMCommandTable(var pTable:QM_COMMAND):Boolean;
Var
    strSQL   : String;
Begin
    if GetQMCommandTable(pTable)=True then Begin SetQMCommandTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO QM_COMMANDS'+
              '(m_swType,m_swCMDID,m_sName,m_swSpec0,m_swSpec1,m_swSpec2,m_sblSaved,m_sbyEnable,m_sbyDirect)'+
              ' VALUES('+
              IntToStr(m_swType)+ ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+m_sName+''''+ ','+
              IntToStr(m_swSpec0)+ ','+
              IntToStr(m_swSpec1)+ ','+
              IntToStr(m_swSpec2)+ ','+
              IntToStr(m_sblSaved)+ ','+
              IntToStr(m_sbyEnable)+ ','+
              IntToStr(m_sbyDirect)+')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelQMCommandTable(nIndex:Integer;nCmdIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nCmdIndex<>-1 then
    strSQL := 'DELETE FROM QM_COMMANDS WHERE m_swID='+IntToStr(nCmdIndex);
    if nCmdIndex=-1 then
    strSQL := 'DELETE FROM QM_COMMANDS WHERE m_swType='+IntToStr(nIndex);
    Result := ExecQry(strSQL);
End;
function CDBase.GetTMTarifsTable(var pTable:TM_TARIFFSS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM TM_TARIFFS ORDER BY m_swID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swTTID   := FieldByName('m_swTTID').AsInteger;
      m_sName    := FieldByName('m_sName').AsString;
      m_swCMDID  := FieldByName('m_swCMDID').AsInteger;
      m_dtTime0  := FieldByName('m_dtTime0').AsDateTime;
      m_dtTime1  := FieldByName('m_dtTime1').AsDateTime;
      m_sbyEnable:= FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsTMTarifTable(var pTable:TM_TARIFFS):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM TM_TARIFFS WHERE m_swID='+IntToStr(pTable.m_swID)+
              ' and m_swTTID='+IntToStr(pTable.m_swTTID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetTMTarifTable(var pTable:TM_TARIFFS):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE TM_TARIFFS SET '+
              ' m_swTTID='      +IntToStr(m_swTTID)+
              ',m_sName='       +''''+m_sName+''''+
              ',m_swCMDID='     +IntToStr(m_swCMDID)+
              ',m_dtTime0='     +''''+DateTimeToStr(m_dtTime0)+''''+
              ',m_dtTime1='     +''''+DateTimeToStr(m_dtTime1)+''''+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ' WHERE m_swTTID='+IntToStr(m_swTTID)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddTMTarifTable(var pTable:TM_TARIFFS):Boolean;
Var
    strSQL   : String;
Begin
    if IsTMTarifTable(pTable)=True then Begin SetTMTarifTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO TM_TARIFFS'+
              '(m_swTTID,m_sName,m_swCMDID,m_dtTime0,m_dtTime1,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swTTID)+ ','+
              ''''+m_sName+''''+ ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_dtTime0)+''''+ ','+
              ''''+DateTimeToStr(m_dtTime1)+''''+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelTMTarifTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM TM_TARIFFS WHERE m_swTTID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM TM_TARIFFS';
    Result := ExecQry(strSQL);
End;
{
TM_TARIFF = packed record
     m_swID    : Word;
     m_swTID   : Word;
     m_swTTID  : Word;
     m_dtTime0 : TDateTime;
     m_dtTime1 : TDateTime;
     m_sName   : String[100];
    End;
    TM_TARIFFS = packed record
     m_swID       : Word;
     m_swTTID     : Word;
     m_sName      : String[100];
     m_swCMDID    : Word;
     m_dtTime0    : TDateTime;
     m_dtTime1    : TDateTime;
     m_sbyEnable  : Byte;
     Count     : Word;
     Items     : array of TM_TARIFF;
    End;
    PTM_TARIFFS =^ TM_TARIFFS;
    TM_TARIFFSS = packed record
     Count     : Word;
     Items     : array of TM_TARIFFS;
    End;
}
function CDBase.GetTMTarPeriodsTable(nIndex:Integer;var pTable:TM_TARIFFS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM TM_TARIFF WHERE m_swTTID='+IntToStr(nIndex)+' ORDER BY m_swPTID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swPTID   := FieldByName('m_swPTID').AsInteger;
      m_swTTID   := FieldByName('m_swTTID').AsInteger;
      m_swTID    := FieldByName('m_swTID').AsInteger;
      m_sName    := FieldByName('m_sName').AsString;
      m_dtTime0  := FieldByName('m_dtTime0').AsDateTime;
      m_dtTime1  := FieldByName('m_dtTime1').AsDateTime;
      m_sfKoeff  := FieldByName('m_sfKoeff').AsFloat;
      m_sbyEnable:= FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsTMTarPeriodTable(var pTable:TM_TARIFF):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM TM_TARIFF WHERE m_swID='+IntToStr(pTable.m_swID)+
              ' and m_swTTID='+IntToStr(pTable.m_swTTID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetTMTarPeriodTable(var pTable:TM_TARIFF):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE TM_TARIFF SET '+
              ' m_swPTID='      +IntToStr(m_swPTID)+
              ',m_swTTID='      +IntToStr(m_swTTID)+
              ',m_swTID='       +IntToStr(m_swTID)+
              ',m_sName='       +''''+m_sName+''''+
              ',m_dtTime0='     +''''+DateTimeToStr(m_dtTime0)+''''+
              ',m_dtTime1='     +''''+DateTimeToStr(m_dtTime1)+''''+
              ',m_sfKoeff='       +FloatToStr(m_sfKoeff)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ' WHERE m_swID='+IntToStr(m_swID);
              //' WHERE m_swTID='+IntToStr(m_swTID)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddTMTarPeriodTable(var pTable:TM_TARIFF):Boolean;
Var
    strSQL   : String;
Begin
    if IsTMTarPeriodTable(pTable)=True then Begin SetTMTarPeriodTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO TM_TARIFF'+
              '(m_swPTID,m_swTTID,m_swTID,m_sName,m_dtTime0,m_dtTime1,m_sfKoeff,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swPTID)+ ','+
              IntToStr(m_swTTID)+ ','+
              IntToStr(m_swTID)+ ','+
              ''''+m_sName+''''+ ','+
              ''''+DateTimeToStr(m_dtTime0)+''''+ ','+
              ''''+DateTimeToStr(m_dtTime1)+''''+ ','+
              FloatToStr(m_sfKoeff)+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelTMTarPeriodTable(nIndex:Integer;nCmdIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nCmdIndex<>-1 then
    strSQL := 'DELETE FROM TM_TARIFF WHERE m_swID='+IntToStr(nCmdIndex);
    if nCmdIndex=-1 then
    strSQL := 'DELETE FROM TM_TARIFF WHERE m_swTTID='+IntToStr(nIndex);
    Result := ExecQry(strSQL);
End;

procedure SetNullDate(var pTable:TM_TARIFFS; CMDID:integer);
var h, m, s, ms : word;
begin
    pTable.m_swID     := 0;
    pTable.m_swTTID   := 0;
    pTable.m_sName    := 'NULL DATE';
    pTable.m_swCMDID  := CMDID;
    pTable.Count      := 1;
    SetLength(pTable.Items, 1);
    h := 0; m := 0; s := 0; ms := 0;
    pTable.Items[0].m_dtTime0 := EncodeTime(h, m, s, ms);
    h := 24; m := 59; s := 59; ms := 999;
    pTable.Items[0].m_dtTime1 := EncodeTime(h, m, s, ms);
end;

{
//Таблица параметров вычислителя
    SL3PARAMS = packed record
     m_swID          : Word;
     m_swVMID        : WORD;
     m_swParamID     : WORD;
     m_sParamExpress : String[30];
     m_fValue        : Double;
     m_fMin          : Double;
     m_fMax          : Double;
     m_dtDateTime    : TDateTime;
     m_sblCalculate  : Boolean;
     m_sblEnable     : Boolean;
    end;
    PSL3PARAMS =^ SL3PARAMS;

    //Таблица вычислителя
    SL3VMETERTAG = packed record
     m_swID          : Word;
     m_swMID         : WORD;
     m_sbyGroupID    : Byte;
     m_swVMID        : WORD;
     m_swAmParams    : WORD;
     m_sMeterName    : String[30];
     m_sVMeterName   : String[30];
     m_sParams       : array of SL3PARAMS;
     m_sbyEnable     : Byte;
    end;
    PL3VMETERTAG =^ SL3VMETERTAG;
}
function CDBase.GetVParamsTable(nChannel:Integer;var pTable:SL3VMETERTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nChannel<>-1 then strSQL := 'SELECT * FROM SL3PARAMS WHERE m_swVMID='+IntToStr(nChannel)+' ORDER BY m_swParamID';
    if nChannel=-1  then strSQL := 'SELECT * FROM SL3PARAMS';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmParams := nCount;
     SetLength(pTable.m_sParams,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sParams[i] do  Begin
      m_swID          := FieldByName('m_swID').AsInteger;
      m_swVMID        := FieldByName('m_swVMID').AsInteger;
      m_swParamID     := FieldByName('m_swParamID').AsInteger;
      m_sParamExpress := FieldByName('m_sParamExpress').AsString;
      m_sParam        := FieldByName('m_sParam').AsString;
      //m_fValue        := FieldByName('m_fValue').AsFloat;
      m_fMin          := FieldByName('m_fMin').AsFloat;
      m_fMax          := FieldByName('m_fMax').AsFloat;
      m_fDiffer       := FieldByName('m_fDiffer').AsFloat;
      m_dtLastTime    := FieldByName('m_dtLastTime').AsDateTime;
      m_stSvPeriod    := FieldByName('m_stSvPeriod').AsInteger;
      m_sblTarif      := FieldByName('m_sblTarif').AsInteger;
      m_sblCalculate  := FieldByName('m_sblCalculate').AsInteger;
      m_sblSaved      := FieldByName('m_sblSaved').AsInteger;
      m_swStatus      := FieldByName('m_swStatus').AsInteger;
      m_sblEnable     := FieldByName('m_sblEnable').AsInteger;
      m_sbyDataGroup  := FieldByName('m_sbyDataGroup').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetVParamsGrTable(nGroup,nChannel,nType:Integer;var pTable:SL3VMETERTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nType=-1 then
    Begin
     if (nChannel<>-1)then strSQL := 'SELECT * FROM SL3PARAMS WHERE m_swVMID='+IntToStr(nChannel)+' ORDER BY m_swParamID';
     if (nChannel=-1) and(nGroup=-1)  then strSQL := 'SELECT * FROM SL3PARAMS ORDER BY m_swParamID';
     if (nChannel=-1) and(nGroup<>-1) then
     strSQL := 'SELECT * FROM SL3PARAMS WHERE SL3PARAMS.m_swVMID IN '+
     ' (SELECT SL3VMETERTAG.m_swVMID FROM SL3GROUPTAG,SL3VMETERTAG '+
     ' WHERE SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID '+
     ' and SL3GROUPTAG.M_SBYGROUPID='+IntToStr(nGroup)+' ) ORDER BY m_swVMID';
    End else
    if nType<>-1 then
    Begin
     if (nChannel=-1)and(nGroup<>-1) then
     strSQL := 'SELECT * FROM SL3PARAMS WHERE SL3PARAMS.m_swVMID IN '+
     ' (SELECT SL3VMETERTAG.m_swVMID FROM SL3GROUPTAG,SL3VMETERTAG '+
     ' WHERE SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID '+
     ' and SL3GROUPTAG.M_SBYGROUPID='+IntToStr(nGroup)+
     ' and SL3VMETERTAG.M_SBYTYPE='+IntToStr(nType)+' ) ORDER BY m_swParamID' else
     if (nGroup=-1) then
     strSQL := 'SELECT * FROM SL3PARAMS WHERE SL3PARAMS.m_swVMID IN '+
     ' (SELECT SL3VMETERTAG.m_swVMID FROM SL3GROUPTAG,SL3VMETERTAG '+
     ' WHERE SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID '+
     ' and SL3VMETERTAG.M_SBYTYPE='+IntToStr(nType)+' ) ORDER BY m_swParamID';
    End;
    if strSQL<>'' then
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmParams := nCount;
     SetLength(pTable.m_sParams,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sParams[i] do  Begin
      m_swID          := FieldByName('m_swID').AsInteger;
      m_swVMID        := FieldByName('m_swVMID').AsInteger;
      m_swParamID     := FieldByName('m_swParamID').AsInteger;
      m_sParamExpress := FieldByName('m_sParamExpress').AsString;
      m_sParam        := FieldByName('m_sParam').AsString;
      //m_fValue        := FieldByName('m_fValue').AsFloat;
      m_fMin          := FieldByName('m_fMin').AsFloat;
      m_fMax          := FieldByName('m_fMax').AsFloat;
      m_fDiffer       := FieldByName('m_fDiffer').AsFloat;
      m_dtLastTime    := FieldByName('m_dtLastTime').AsDateTime;
      m_stSvPeriod    := FieldByName('m_stSvPeriod').AsInteger;
      m_sblTarif      := FieldByName('m_sblTarif').AsInteger;
      m_sblCalculate  := FieldByName('m_sblCalculate').AsInteger;
      m_sblSaved      := FieldByName('m_sblSaved').AsInteger;
      m_swStatus      := FieldByName('m_swStatus').AsInteger;
      m_sblEnable     := FieldByName('m_sblEnable').AsInteger;
      m_sbyDataGroup  := FieldByName('m_sbyDataGroup').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetVKeyParamsTable(nChannel,nSVType:Integer;var pTable:SL3VMETERTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nSVType=-1  then strSQL := 'SELECT m_swParamID FROM SL3PARAMS WHERE m_swVMID='+IntToStr(nChannel)+'ORDER BY m_swParamID';
    if nSVType<>-1 then strSQL := 'SELECT m_swParamID,m_sblTarif,m_swStatus FROM SL3PARAMS'+
    ' WHERE m_swVMID='+IntToStr(nChannel)+
    ' and m_sblSaved='+IntToStr(nSVType)+
    ' ORDER BY m_swParamID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmParams := nCount;
     SetLength(pTable.m_sParams,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sParams[i] do  Begin
      m_swParamID     := FieldByName('m_swParamID').AsInteger;
      m_sblTarif      := FieldByName('m_sblTarif').AsInteger;
      m_swStatus      := FieldByName('m_swStatus').AsInteger;
      //m_sblEnable     := FieldByName('m_sblEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetVParamTbl(var pTable:SL3PARAMS):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3PARAMS WHERE m_swID='+IntToStr(pTable.m_swID)+
    ' and m_swParamID='+IntToStr(pTable.m_swParamID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    with FADOQuery,pTable do
    Begin
     res   := True;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetVParamTable(var pTable:SL3PARAMS):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT * FROM SL3PARAMS WHERE m_swVMID='+IntToStr(pTable.m_swVMID)+' ORDER BY m_swParamID';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    with FADOQuery,pTable do
    Begin
      m_swID          := FieldByName('m_swID').AsInteger;
      m_swVMID        := FieldByName('m_swVMID').AsInteger;
      m_swParamID     := FieldByName('m_swParamID').AsInteger;
      m_sParamExpress := FieldByName('m_sParamExpress').AsString;
      //m_fValue        := FieldByName('m_fValue').AsFloat;
      m_fMin          := FieldByName('m_fMin').AsFloat;
      m_fLimit        := FieldByName('m_fLimit').AsFloat;
      m_fMax          := FieldByName('m_fMax').AsFloat;
      m_fDiffer       := FieldByName('m_fDiffer').AsFloat;
      m_dtLastTime    := FieldByName('m_dtLastTime').AsDateTime;
      m_stSvPeriod    := FieldByName('m_stSvPeriod').AsInteger;
      m_sblTarif      := FieldByName('m_sblTarif').AsInteger;
      m_sblCalculate  := FieldByName('m_sblCalculate').AsInteger;
      m_sblSaved      := FieldByName('m_sblSaved').AsInteger;
      m_swStatus      := FieldByName('m_swStatus').AsInteger;
      m_sblEnable     := FieldByName('m_sblEnable').AsInteger;
      m_sbyDataGroup  := FieldByName('m_sbyDataGroup').AsInteger;
     res   := True;
    End;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.SetVParamTable(var pTable:SL3PARAMS):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3PARAMS SET '+
              ' m_swVMID='       +IntToStr(m_swVMID)+
              ',m_swParamID='    +IntToStr(m_swParamID)+
              ',m_sParamExpress='+''''+m_sParamExpress+''''+
              //',m_fValue='       +FloatToStrF(m_fValue,ffFixed,3,3)+
              ',m_fMin='         +FloatToStrF(m_fMin,ffFixed,3,3)+
              ',m_fLimit='       +FloatToStrF(m_fLimit,ffFixed,3,3)+
              ',m_fMax='         +FloatToStrF(m_fMax,ffFixed,3,3)+
              ',m_fDiffer='      +FloatToStrF(m_fDiffer,ffFixed,3,3)+
              ',m_dtLastTime='   +''''+DateTimeToStr(m_dtLastTime)+''''+
              ',m_stSvPeriod='   +IntToStr(m_stSvPeriod)+
              ',m_sblTarif='     +IntToStr(m_sblTarif)+
              ',m_sblCalculate=' +IntToStr(m_sblCalculate)+
              ',m_sblSaved='     +IntToStr(m_sblSaved)+
              ',m_swStatus='     +IntToStr(m_swStatus)+
              ',m_sblEnable='    +IntToStr(m_sblEnable)+
              ',m_sbyDataGroup=' +IntToStr(m_sbyDataGroup)+
              ' WHERE m_swParamID=' +IntToStr(m_swParamID)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddVParamTable(var pTable:SL3PARAMS):Boolean;
Var
    strSQL   : String;
Begin
    if GetVParamTbl(pTable)=True then Begin SetVParamTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3PARAMS'+
              '(m_swVMID,m_swParamID,m_sParamExpress,m_fMin,m_fLimit,m_fMax,m_fDiffer,m_dtLastTime,m_stSvPeriod,m_sblTarif,m_sblCalculate,m_sblSaved,m_swStatus,m_sblEnable,m_sbyDataGroup)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swParamID)+ ','+
              ''''+m_sParamExpress+''''+ ','+
              //FloatToStrF(m_fValue,ffFixed,3,3)+ ','+
              FloatToStrF(m_fMin,ffFixed,3,3)+ ','+
              FloatToStrF(m_fLimit,ffFixed,3,3)+ ','+
              FloatToStrF(m_fMax,ffFixed,3,3)+ ','+
              FloatToStrF(m_fDiffer,ffFixed,3,3)+ ','+
              ''''+DateTimeToStr(m_dtLastTime)+''''+ ','+
              IntToStr(m_stSvPeriod)+ ','+
              IntToStr(m_sblTarif)+ ','+
              IntToStr(m_sblCalculate)+ ','+
              IntToStr(m_sblSaved)+ ','+
              IntToStr(m_swStatus)+ ','+
              IntToStr(m_sblEnable)+ ','+
              IntToStr(m_sbyDataGroup)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelVParamTable(nMasterIndex,nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM SL3PARAMS WHERE m_swID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM SL3PARAMS WHERE m_swVMID='+IntToStr(nMasterIndex);
    Result := ExecQry(strSQL);
End;
{
m_swID      : Word;
     m_swType    : Word;
     m_swCMDID   : Word;
     m_sName     : String[40];
     m_sExpress  : String[40];
     m_swSpec0   : Word;
     m_swSpec1   : Word;
     m_swSpec2   : Word;
     m_sbyEnable : Byte;
     m_sComment  : String[40];
}
function CDBase.ReplaceVParams(nMType,nIndex:Integer):Boolean;
Var
    strSQL   : String;
    nCount,i : Integer;
    m_swVMID : array[0..100] of Integer;
    res      : Boolean;
Begin
    res := False;
    strSQL := 'SELECT m_swVMID FROM SL3VMETERTAG WHERE m_swMID='+IntToStr(nIndex);
    if OpenQry(strSQL,nCount)=True then
    Begin
    //SetLength(m_swVMID,nCount);
    i:=0;
    while not FADOQuery.Eof do
     Begin
      m_swVMID[i] := FADOQuery.FieldByName('m_swVMID').AsInteger;
      FADOQuery.Next;
      Inc(i);
     End;
    End;
    CloseQry;
    for i:=0 to nCount-1 do res:=InsertVParams(nMType,m_swVMID[i]);
    Result := res;
End;


{
QM_COMMAND = packed record
     m_swID      : Word;
     m_swType    : Word;
     m_swCMDID   : Word;
     m_sName     : string[40];
     m_swSpec0   : Integer;
     m_swSpec1   : Integer;
     m_swSpec2   : Integer;
     m_sblSaved  : Byte;
     m_sbyEnable : Byte;
     m_sbyDirect : Byte;
    end;
QM_PARAM = packed record
     m_swID      : Word;
     m_swType    : Word;
     m_sName     : String[40];
     m_sShName   : String[30];
     m_sEName    : String[10];
     m_sEMet     : String[10];
     m_swSvPeriod: Integer;
     m_sblTarif  : Byte;
     m_swActive  : Byte;
     m_swStatus  : Byte;
     m_swIsGraph : Byte;
    end;
}
function CDBase.InsertVParams(nMeterType,nIndex:Integer):Boolean;
Var
    strSQL   : AnsiString;
    nCount,i : Integer;
    res      : Boolean;
    str : AnsiString;
Begin
    res := False;
    strSQL := 'DELETE FROM SL3PARAMS WHERE m_swVMID='+IntToStr(nIndex);
    Result := ExecQry(strSQL);
    strSQL := 'INSERT INTO SL3PARAMS('+
              '          m_swVMID,m_swParamID,m_sParamExpress,m_sParam,m_fMin,m_fLimit,m_fMax,m_fDiffer,m_dtLastTime,m_stSvPeriod,m_sblTarif,m_sblCalculate,m_sblSaved,m_swStatus,m_sblEnable,m_sbyDataGroup)'+
              ' SELECT '+IntToStr(nIndex)+',m_swCMDID,m_sEName,m_sEName,0,0,0,0,'+''''+DateTimeToStr(Now)+''''+',m_swSvPeriod,m_sblTarif,1,m_swIsGraph,m_swStatus,1,QM_PARAMS.m_sbyDataGroup'+
              ' FROM QM_COMMANDS,QM_PARAMS WHERE QM_COMMANDS.m_swType='+IntToStr(nMeterType)+
              ' and QM_COMMANDS.m_swCMDID=QM_PARAMS.m_swType and (m_sbyDirect=1 or m_sbyDirect=2)'+
              ' and QM_COMMANDS.m_sbyEnable=1';
    Result := ExecQry(strSQL);

    strSQL := 'SELECT m_sParamExpress,m_swParamID FROM SL3PARAMS WHERE m_swVMID='+IntToStr(nIndex);
    if OpenQry(strSQL,nCount)=True then
    Begin
    i:=0;
    while not FADOQuery.Eof do
     Begin
      str := 'v'+IntToStr(nIndex)+'_'+FADOQuery.FieldByName('m_sParamExpress').AsString;
      UpdateExpression(nIndex,FADOQuery.FieldByName('m_swParamID').AsInteger,str);
      FADOQuery.Next;
      Inc(i);
     End;
    End;
    CloseQry;
End;
{
    //General Settings
    SGENSETTTAG = packed record
     m_sInterSet    : Byte;
     m_sMdmJoinName : String[50];
     m_sUseModem    : Byte;
     m_sInterDelay  : Double;
    end;
}
function CDBase.GetGenSettTable(var pTable:SGENSETTTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT * FROM SGENSETTTAG';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    with FADOQuery,pTable do
    Begin
      m_sbyMode       := FieldByName('m_sbyMode').AsInteger;
      m_sbyLocation   := FieldByName('m_sbyLocation').AsInteger;
      m_sbyAutoPack   := FieldByName('m_sbyAutoPack').AsInteger;
      m_swAddres      := FieldByName('m_swAddres').AsInteger;
      m_sStorePeriod  := FieldByName('m_sStorePeriod').AsInteger;
      m_sStoreClrTime := FieldByName('m_sStoreClrTime').AsInteger;
      m_sStoreProto   := FieldByName('m_sStoreProto').AsInteger;
      m_sPoolPeriod   := FieldByName('m_sPoolPeriod').AsInteger;
      m_sProjectName  := FieldByName('m_sProjectName').AsString;
      m_sPrePoolGraph := FieldByName('m_sPrePoolGraph').AsInteger;
      m_sQryScheduler := FieldByName('m_sQryScheduler').AsInteger;
      m_sPowerLimit   := FieldByName('m_sPowerLimit').AsFloat;
      m_sPowerPrc     := FieldByName('m_sPowerPrc').AsInteger;
      m_sAutoTray     := FieldByName('m_sAutoTray').AsInteger;
      m_sPrecise      := FieldByName('m_sPrecise').AsInteger;
      m_sPreciseExpense:= FieldByName('m_sPreciseExpense').AsInteger;
      m_sCorrDir      := FieldByName('m_sCorrDir').AsInteger;
      m_sBaseLocation := FieldByName('m_sBaseLocation').AsInteger;
      m_sKorrDelay    := FieldByName('m_sKorrDelay').AsFloat;
      m_sSetForETelecom := FieldByName('m_sSetForETelecom').AsInteger;
      m_sInterSet     := FieldByName('m_sInterSet').AsInteger;
      m_sMdmJoinName  := FieldByName('m_sMdmJoinName').AsString;
      m_sUseModem     := FieldByName('m_sUseModem').AsInteger;
      m_sInterDelay   := FieldByName('m_sInterDelay').AsFloat;
      m_sChannSyn     := FieldByName('m_sChannSyn').AsInteger;
     res   := True;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsGenSett:Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SGENSETTTAG';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.AddGenSettTable(var pTable:SGENSETTTAG):Boolean;
Var
    strSQL   : String;
Begin
    if IsGenSett=True then Begin SetGenSettTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SGENSETTTAG'+
              '(m_sbyMode,m_sbyLocation,m_sbyAutoPack,m_swAddres,m_sStorePeriod,m_sStoreClrTime,m_sStoreProto,m_sPoolPeriod,m_sProjectName'+
              ',m_sPrePoolGraph,m_sQryScheduler,m_sPowerLimit,m_sPowerPrc,m_sAutoTray,m_sPrecise,m_sPreciseExpense,m_sBaseLocation, m_sKorrDelay,m_sSetForETelecom'+
              ',m_sInterSet,m_sMdmJoinName,m_sUseModem,m_sInterDelay,m_sChannSyn)'+
              ' VALUES('+
              IntToStr(m_sbyMode)+ ','+
              IntToStr(m_sbyLocation)+ ','+
              IntToStr(m_sbyAutoPack)+ ','+
              IntToStr(m_swAddres)+ ','+
              IntToStr(m_sStorePeriod)+ ','+
              IntToStr(m_sStoreClrTime)+ ','+
              IntToStr(m_sStoreProto)+ ','+
              IntToStr(m_sPoolPeriod)+ ','+
              ''''+m_sProjectName+''''+ ','+
              IntToStr(m_sPrePoolGraph)+ ','+
              IntToStr(m_sQryScheduler)+ ','+
              FloatToStr(m_sPowerLimit)+ ','+
              IntToStr(m_sPowerPrc)+ ','+
              IntToStr(m_sAutoTray)+ ','+
              IntToStr(m_sPrecise)+ ','+
              IntToStr(m_sPreciseExpense)+','+
              IntToStr(m_sCorrDir)+','+
              IntToStr(m_sBaseLocation)+ ','+
              FloatToStr(m_sKorrDelay) + ','+
              IntToStr(m_sSetForETelecom)+ ','+
              IntToStr(m_sInterSet)+','+
              ''''+m_sMdmJoinName+''''+ ','+
              IntToStr(m_sUseModem)+','+
              FloatToStr(m_sInterDelay) + '+'+
              IntToStr(m_sChannSyn)+')';
    End;
    Result := ExecQry(strSQL);
End;
{
     m_sInterSet    : Byte;
     m_sMdmJoinName : String[50];
     m_sUseModem    : Byte;
     m_sInterDelay  : Double;
}
function CDBase.SetGenSettTable(var pTable:SGENSETTTAG):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SGENSETTTAG SET '+
              ' m_sbyMode='  +IntToStr(m_sbyMode)+
              ',m_sbyLocation='  +IntToStr(m_sbyLocation)+
              ',m_sbyAutoPack='  +IntToStr(m_sbyAutoPack)+
              ',m_swAddres='  +IntToStr(m_swAddres)+
              ',m_sStorePeriod='  +IntToStr(m_sStorePeriod)+
              ',m_sStoreClrTime=' +IntToStr(m_sStoreClrTime)+
              ',m_sStoreProto=' +IntToStr(m_sStoreProto)+
              ',m_sPoolPeriod=' +IntToStr(m_sPoolPeriod)+
              ',m_sProjectName='+''''+m_sProjectName+''''+
              ',m_sPrePoolGraph=' +IntToStr(m_sPrePoolGraph)+
              ',m_sQryScheduler=' +IntToStr(m_sQryScheduler)+
              ',m_sPowerLimit=' +FloatToStr(m_sPowerLimit)+
              ',m_sPowerPrc='  +IntToStr(m_sPowerPrc)+
              ',m_sAutoTray=' +IntToStr(m_sAutoTray)+
              ',m_sPrecise=' +IntToStr(m_sPrecise)+
              ',m_sPreciseExpense=' +IntToStr(m_sPreciseExpense)+
              ',m_sCorrDir=' + IntToStr(m_sCorrDir)+
              ',m_sBaseLocation=' +IntToStr(m_sBaseLocation)+
              ',m_sKorrDelay='+FloatToStr(m_sKorrDelay)+
              ',m_sSetForETelecom='+IntToStr(m_sSetForETelecom)+
              ',m_sInterSet='+IntToStr(m_sInterSet)+
              ',m_sMdmJoinName='+''''+m_sMdmJoinName+''''+
              ',m_sUseModem=' + IntToStr(m_sUseModem)+
              ',m_sInterDelay='+FloatToStr(m_sInterDelay)+
              ',m_sChannSyn=' + IntToStr(m_sChannSyn);
    End;
    Result := ExecQry(strSQL);
End;

{
//Event Settings
    SEVENTSETTTAG = packed record
     m_swID         : Integer;
     m_swEventID    : Word;
     m_sdtEventTime : TDateTIme;
     m_schEventName : String[50];
     m_sbyEnable    : Byte;
    end;
    SEVENTSETTTAGS = packed record
     Count         : Integer;
     Items         : array of SEVENTSETTTAG;
    end;
}
function CDBase.GetEventsTable(nIndex:Integer;var pTable:SEVENTSETTTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nIndex=-1 then  strSQL := 'SELECT * FROM SEVENTSETTTAGS ORDER BY m_swEventID';
    if nIndex<>-1 then strSQL := 'SELECT * FROM SEVENTSETTTAGS WHERE m_swGroupID='+IntToStr(nIndex)+' ORDER BY m_swEventID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID         := FieldByName('m_swID').AsInteger;
      m_swGroupID    := FieldByName('m_swGroupID').AsInteger;
      m_swEventID    := FieldByName('m_swEventID').AsInteger;
      //m_sdtEventTime := FieldByName('m_sdtEventTime').AsDateTime;
      m_schEventName := FieldByName('m_schEventName').AsString;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsEvent(var pTable:SEVENTSETTTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SEVENTSETTTAGS WHERE m_swEventID='+IntToStr(pTable.m_swEventID)+' and m_swGroupID='+IntToStr(pTable.m_swGroupID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetEventTable(var pTable:SEVENTSETTTAG):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SEVENTSETTTAGS SET '+
              //' m_sdtEventTime='+''''+DateTimeToStr(m_sdtEventTime)+''''+
              ' m_schEventName='+''''+m_schEventName+''''+
              ',m_sbyEnable='+IntToStr(m_sbyEnable)+
              ' WHERE m_swEventID=' +IntToStr(m_swEventID)+' and m_swGroupID='+IntToStr(m_swGroupID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddEventTable(var pTable:SEVENTSETTTAG):Boolean;
Var
    strSQL   : String;
Begin
    if IsEvent(pTable)=True then Begin SetEventTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SEVENTSETTTAGS'+
              '(m_swGroupID,m_swEventID,m_schEventName,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swGroupID)+ ','+
              IntToStr(m_swEventID)+ ','+
              //''''+DateTimeToStr(m_sdtEventTime)+''''+ ','+
              ''''+m_schEventName+''''+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelEventsTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM SEVENTSETTTAGS WHERE m_swGroupID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM SEVENTSETTTAGS';
    Result := ExecQry(strSQL);
End;

{
     m_swID         : Integer;
     m_swGroupID    : Word;
     m_swEventID    : Word;
     m_sdtEventTime : TDateTIme;
     m_nEvent       : Word;
     m_sUser        : String[10];
     m_sbyEnable    : Byte;
}

function CDBase.GetFixEventsTable(nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime;var pTable:SEVENTTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nVMID=-1 then nVMID := 0; 
    if (nGroup=-1)and(nEvents=-1) then  strSQL := 'SELECT * FROM SEVENTTTAG WHERE'+
    ' m_swVMID='+IntToStr(nVMID)+
    ' and CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + ''''+
    ' ORDER BY m_sdtEventTime' else
    if (nGroup<>-1)and(nEvents=-1) then  strSQL := 'SELECT * FROM SEVENTTTAG WHERE'+
    ' m_swVMID='+IntToStr(nVMID)+
    ' and m_swGroupID='+IntToStr(nGroup)+
    ' and CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + ''''+
    ' ORDER BY m_sdtEventTime' else
    if (nGroup<>-1)and(nEvents<>-1) then  strSQL := 'SELECT * FROM SEVENTTTAG WHERE'+
    ' m_swVMID='+IntToStr(nVMID)+
    ' and m_swGroupID='+IntToStr(nGroup)+
    ' and m_swEventID='+IntToStr(nEvents)+
    ' and CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + ''''+
    ' ORDER BY m_sdtEventTime';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID         := FieldByName('m_swID').AsInteger;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_swGroupID    := FieldByName('m_swGroupID').AsInteger;
      m_swEventID    := FieldByName('m_swEventID').AsInteger;
      m_sdtEventTime := FieldByName('m_sdtEventTime').AsDateTime;
      m_sUser        := FieldByName('m_sUser').AsString;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
{
     m_swID         : Integer;
     m_swGroupID    : Word;
     m_swEventID    : Word;
     m_sdtEventTime : TDateTIme;
     m_nEvent       : Word;
     m_sUser        : String[10];
     m_sbyEnable    : Byte;
}
function CDBase.FixUspdEvent(nEvent:Integer):Boolean;
Var
    pTable:SEVENTTAG;
Begin
    Result := False;
    if (nEvent=-1) then exit;
    pTable.m_swVMID       := 0;
    pTable.m_swGroupID    := 0;
    pTable.m_swEventID    := nEvent;
    pTable.m_sdtEventTime := Now;
    pTable.m_sUser        := m_strCurrUser;
    pTable.m_sbyEnable    := 1;
    if m_nEV[0].Items[nEvent].m_sbyEnable=1 then
    Begin
     m_pDB.AddFixEventTable(pTable);
     Result := True;
    End else
    Result := True;
End;
function CDBase.FixMeterEvent(nGroup,nEvent,nVMID:Integer; Date : TDateTime):Boolean;
Var
    pTable:SEVENTTAG;
    m_nobj:ARCH_USPD;
Begin
    Result := False;
    if nEvent<m_nJrnlN3.Count then
    Begin
     TraceL(3, nVMID, '(__)CL3MD::>CVMTR: EVT:' + m_nJrnlN3.Strings[nEvent]);
     Result := False;
     if (nGroup=-1) or (nGroup>2) then exit;
     pTable.m_swVMID       := nVMID;
     pTable.m_swGroupID    := nGroup;
     pTable.m_swEventID    := nEvent;
     pTable.m_sdtEventTime := Date;
     pTable.m_sUser        := m_strCurrUser;
     pTable.m_sbyEnable    := 1;
     ///////////energo///////////////
     m_nobj.n_obj := nVMID;
     m_nobj.on_date_time := Date;
     m_nobj.n_ri := 0;
     ///////////////////////////
     if m_nEV[nGroup].Items[nEvent].m_sbyEnable=1 then
     Begin
      m_pDB.AddFixEventTable(pTable);
      if m_blIsEEnergo=True then m_pDB.AddArchUspdTable(m_nobj,nGroup,nEvent);
      Result := True;
     End else
     Result := True;
    End else
     TraceL(3, nVMID, '(__)CL3MD::>CVMTR: EVT:Unknow Code:' + IntToStr(nEvent)+' ?');
End;
function CDBase.IsFixEvent(var pTable:SEVENTTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SEVENTTTAG WHERE'+
    ' m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and m_swGroupID='+IntToStr(pTable.m_swGroupID)+
    ' and m_swEventID='+IntToStr(pTable.m_swEventID)+
    ' and m_sdtEventTime='+''''+DateTimeToStr(pTable.m_sdtEventTime)+'''';
    //' and CAST(m_sdtEventTime as DATE)='+''''+DateToStr(pTable.m_sdtEventTime)+'''';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.AddFixEventTable(var pTable:SEVENTTAG):Boolean;
Var
    strSQL   : String;
Begin
    Result := False;
    if IsFixEvent(pTable)<>True then
    Begin
    with pTable do
    Begin
    strSQL := 'INSERT INTO SEVENTTTAG'+
              '(m_swVMID,m_swGroupID,m_swEventID,m_sdtEventTime,m_sUser,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swGroupID)+ ','+
              IntToStr(m_swEventID)+ ','+
              ''''+DateTimeToStr(m_sdtEventTime)+''''+ ','+
              ''''+m_sUser+''''+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
    End;
End;
function CDBase.DelFixEventsTable(nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime):Boolean;
Var
    strSQL : String;
Begin
    if nVMID=-1 then nVMID := 0;
    if (nGroup=-1)and(nEvents=-1) then  strSQL := 'DELETE FROM SEVENTTTAG WHERE'+
    ' m_swVMID='+IntToStr(nVMID)+
    ' and CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + ''''
    else
    if (nGroup<>-1)and(nEvents=-1) then  strSQL := 'DELETE FROM SEVENTTTAG WHERE'+
    ' m_swVMID='+IntToStr(nVMID)+
    ' and m_swGroupID='+IntToStr(nGroup)+
    ' and CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + ''''
    else
    if (nGroup<>-1)and(nEvents<>-1) then  strSQL := 'DELETE FROM SEVENTTTAG WHERE'+
    ' m_swVMID='+IntToStr(nVMID)+
    ' and m_swGroupID='+IntToStr(nGroup)+
    ' and m_swEventID='+IntToStr(nEvents)+
    ' and CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + '''';
    Result := ExecQry(strSQL);
End;
















//Connection Settings
{
    SCONNSETTTAG = packed record
     m_swID        : Integer;
     m_swConnID    : Word;
     m_schConnName : String[50];
     m_sbyEnable   : Byte;
    end;
    SCONNSETTTAGS = packed record
     Count         : Integer;
     Items         : array of SCONNSETTTAG;
    end;
}
function CDBase.GetConnectsTable(var pTable:SCONNSETTTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SCONNSETTTAGS ORDER BY m_swConnID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swConnID    := FieldByName('m_swConnID').AsInteger;
      m_schConnName := FieldByName('m_schConnName').AsString;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsConnect(nIndex:Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SCONNSETTTAGS WHERE m_swConnID='+IntToStr(nIndex);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetConnectTable(var pTable:SCONNSETTTAG):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SCONNSETTTAGS SET '+
              ',m_schConnName='+''''+m_schConnName+''''+
              ',m_sbyEnable='+IntToStr(m_sbyEnable)+
              ' WHERE m_swConnID=' +IntToStr(m_swConnID)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddConnectTable(var pTable:SCONNSETTTAG):Boolean;
Var
    strSQL   : String;
Begin
    if IsConnect(pTable.m_swConnID)=True then Begin SetConnectTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SCONNSETTTAGS'+
              '(m_swConnID,m_schConnName,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swConnID)+ ','+
              ''''+m_schConnName+''''+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelConnectsTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM SCONNSETTTAGS WHERE m_swConnID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM SCONNSETTTAGS';
    Result := ExecQry(strSQL);
End;







{
    //Sheduler Table
    SQRYSDLTAG = packed record
     m_swID         : Integer;
     m_sdtEventTime : TDateTIme;
     m_sbyEnable    : Byte;
    end;
    SQRYSDLTAGS = packed record
     Count         : Integer;
     Items         : array of SQRYSDLTAG;
    end;
}
function CDBase.GetSdlTable(var pTable:SQRYSDLTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SQRYSDLTAG ORDER BY m_sdtEventTime';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID         := FieldByName('m_swID').AsInteger;
      m_sdtEventTime := FieldByName('m_sdtEventTime').AsDateTime;
      m_sbySynchro   := FieldByName('m_sbySynchro').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsSdlTag(var pTable:SQRYSDLTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SQRYSDLTAG WHERE CAST(m_sdtEventTime as TIME)='+''''+TimeToStr(pTable.m_sdtEventTime)+'''';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetSdlTable(var pTable:SQRYSDLTAG):Boolean;
Var
    strSQL : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SQRYSDLTAG SET '+
              ' m_sbySynchro='+IntToStr(m_sbySynchro)+
              ',m_sbyEnable='+IntToStr(m_sbyEnable)+
              ' WHERE CAST(m_sdtEventTime as TIME)='+''''+TimeToStr(m_sdtEventTime)+'''';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AddSdlTable(var pTable:SQRYSDLTAG):Boolean;
Var
    strSQL   : String;
Begin
    if IsSdlTag(pTable)=True then Begin SetSdlTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SQRYSDLTAG'+
              '(m_sdtEventTime,m_sbySynchro,m_sbyEnable)'+
              ' VALUES('+
              ''''+DateTimeToStr(m_sdtEventTime)+''''+ ','+
              IntToStr(m_sbySynchro)+  ','+
              IntToStr(m_sbyEnable)+  ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelSdlTable:Boolean;
Var
    strSQL : String;
Begin
    strSQL := 'DELETE FROM SQRYSDLTAG';
    Result := ExecQry(strSQL);
End;
{
//User Settings
    SUSERTAG = packed record
     m_swID        : Integer;
     m_swUID       : Integer;
     m_swSLID      : Integer;
     m_sdtRegDate  : TDateTime;
     m_strShName   : String[50];
     m_strPassword : String[50];
     m_strFam      : String[50];
     m_strImya     : String[50];
     m_strOtch     : String[50];
     m_strDolgn    : String[50];
     m_strHomeAddr : String[50];
     m_strTel      : String[50];
     m_strEMail    : String[50];
     m_sbyPrmPE    : Byte;
     m_sbyPrmQE    : Byte;
     m_sbyPrmCE    : Byte;
     m_sbyPrmGE    : Byte;
     m_sbyPrmTE    : Byte;
     m_sbyPrmCNE   : Byte;
     m_sbyPrmPRE   : Byte;
     m_sbyEnable   : Byte;
    end;
    SUSERTAGS = packed record
     Count         : Integer;
     Items         : array of SUSERTAG;
    end;
}
function CDBase.GetUsersTable(var pTable:SUSERTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SUSERTAG ORDER BY m_swUID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID         := FieldByName('m_swID').AsInteger;
      m_swUID        := FieldByName('m_swUID').AsInteger;
      m_swSLID       := FieldByName('m_swSLID').AsInteger;
      m_sdtRegDate   := FieldByName('m_sdtRegDate').AsDateTime;
      m_strShName    := FieldByName('m_strShName').AsString;
      m_strPassword  := FieldByName('m_strPassword').AsString;
      m_strFam       := FieldByName('m_strFam').AsString;
      m_strImya      := FieldByName('m_strImya').AsString;
      m_strOtch      := FieldByName('m_strOtch').AsString;
      m_strDolgn     := FieldByName('m_strDolgn').AsString;
      m_strHomeAddr  := FieldByName('m_strHomeAddr').AsString;
      m_strTel       := FieldByName('m_strTel').AsString;
      m_strEMail     := FieldByName('m_strEMail').AsString;

      m_sbyPrmDE     := FieldByName('m_sbyPrmDE').AsInteger;
      m_sbyPrmPE     := FieldByName('m_sbyPrmPE').AsInteger;
      m_sbyPrmQE     := FieldByName('m_sbyPrmQE').AsInteger;
      m_sbyPrmCE     := FieldByName('m_sbyPrmCE').AsInteger;
      m_sbyPrmGE     := FieldByName('m_sbyPrmGE').AsInteger;
      m_sbyPrmTE     := FieldByName('m_sbyPrmTE').AsInteger;
      m_sbyPrmCNE    := FieldByName('m_sbyPrmCNE').AsInteger;
      m_sbyPrmPRE    := FieldByName('m_sbyPrmPRE').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetUserTable(var pTable:SUSERTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SUSERTAG WHERE m_swUID='+IntToStr(pTable.m_swUID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
     with FADOQuery,pTable do
     Begin
      m_swID         := FieldByName('m_swID').AsInteger;
      m_swUID        := FieldByName('m_swUID').AsInteger;
      m_swSLID       := FieldByName('m_swSLID').AsInteger;
      m_sdtRegDate   := FieldByName('m_sdtRegDate').AsDateTime;

      m_strShName    := FieldByName('m_strShName').AsString;
      m_strPassword  := FieldByName('m_strPassword').AsString;
      m_strFam       := FieldByName('m_strFam').AsString;
      m_strImya      := FieldByName('m_strImya').AsString;
      m_strOtch      := FieldByName('m_strOtch').AsString;
      m_strDolgn     := FieldByName('m_strDolgn').AsString;
      m_strHomeAddr  := FieldByName('m_strHomeAddr').AsString;
      m_strTel       := FieldByName('m_strTel').AsString;
      m_strEMail     := FieldByName('m_strEMail').AsString;

      m_sbyPrmDE     := FieldByName('m_sbyPrmDE').AsInteger;
      m_sbyPrmPE     := FieldByName('m_sbyPrmPE').AsInteger;
      m_sbyPrmQE     := FieldByName('m_sbyPrmQE').AsInteger;
      m_sbyPrmCE     := FieldByName('m_sbyPrmCE').AsInteger;
      m_sbyPrmGE     := FieldByName('m_sbyPrmGE').AsInteger;
      m_sbyPrmTE     := FieldByName('m_sbyPrmTE').AsInteger;
      m_sbyPrmCNE    := FieldByName('m_sbyPrmCNE').AsInteger;
      m_sbyPrmPRE    := FieldByName('m_sbyPrmPRE').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      End;
    End;
    CloseQry;
    Result := res;
End;

procedure CDBase.SetPhotoTable(var pTable:SUSERTAG;var MemoryStream : TMemoryStream);
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SUSERTAG WHERE m_swUID='+IntToStr(pTable.m_swUID);
    if OpenQry(strSQL,nCount)=True then
   Begin
       FADOQuery.Edit;
       TBlobField(FADOQuery.FieldByName('m_sPhoto')).LoadFromStream(MemoryStream);
       ptable.m_sPhoto := TBlobField(FADOQuery.FieldByName('m_sPhoto')).Asstring;
       FADOQuery.Post;
    End;
    CloseQry;
End;

function CDBase.GetPhotoTable(var pTable:SUSERTAG;var MemoryStream : TMemoryStream):boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
     strSQL := 'SELECT * FROM SUSERTAG WHERE m_swUID='+IntToStr(pTable.m_swUID);
    if OpenQry(strSQL,nCount)=True then
    Begin
      FADOQuery.Edit;
      if TBlobField(FADOQuery.FieldByName('m_sPhoto')).Isnull <> true then
      begin
      TBlobField(FADOQuery.FieldByName('m_sPhoto')).SaveToStream(MemoryStream);
       res := true;
      end
       else res := false;
      FADOQuery.Post;
    End;
    CloseQry;

    Result :=res;
End;

function CDBase.IsUserTag(var pTable:SUSERTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SUSERTAG WHERE m_swUID='+IntToStr(pTable.m_swUID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
{
     m_swID        : Integer;
     m_swUID       : Integer;
     m_swSLID      : Integer;
     m_sdtRegDate  : TDateTime;
     m_strShName   : String[50];
     m_strFam      : String[50];
     m_strImya     : String[50];
     m_strOtch     : String[50];
     m_strDolgn    : String[50];
     m_strHomeAddr : String[50];
     m_strTel      : String[50];
     m_strEMail    : String[50];

     m_sbyPrmPE    : Byte;
     m_sbyPrmQE    : Byte;
     m_sbyPrmCE    : Byte;
     m_sbyPrmGE    : Byte;
     m_sbyPrmTE    : Byte;
     m_sbyPrmCNE   : Byte;
     m_sbyPrmPRE   : Byte;
     m_sbyEnable   : Byte;
}
function CDBase.SetUserTable(var pTable:SUSERTAG):Boolean;
Var
    strSQL : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SUSERTAG SET '+
              ' m_swUID='+IntToStr(m_swUID)+
              ',m_swSLID='+IntToStr(m_swSLID)+
              ',m_sdtRegDate='+''''+DateTimeToStr(m_sdtRegDate)+''''+
              ',m_strShName='+''''+m_strShName+''''+
              ',m_strPassword='+''''+m_strPassword+''''+
              ',m_strFam='+''''+m_strFam+''''+
              ',m_strImya='+''''+m_strImya+''''+
              ',m_strOtch='+''''+m_strOtch+''''+
              ',m_strDolgn='+''''+m_strDolgn+''''+
              ',m_strHomeAddr='+''''+m_strHomeAddr+''''+
              ',m_strTel='+''''+m_strTel+''''+
              ',m_strEMail='+''''+m_strEMail+''''+
              ',m_sbyPrmDE='+IntToStr(m_sbyPrmDE)+
              ',m_sbyPrmPE='+IntToStr(m_sbyPrmPE)+
              ',m_sbyPrmQE='+IntToStr(m_sbyPrmQE)+
              ',m_sbyPrmCE='+IntToStr(m_sbyPrmCE)+
              ',m_sbyPrmGE='+IntToStr(m_sbyPrmGE)+
              ',m_sbyPrmTE='+IntToStr(m_sbyPrmTE)+
              ',m_sbyPrmCNE='+IntToStr(m_sbyPrmCNE)+
              ',m_sbyPrmPRE='+IntToStr(m_sbyPrmPRE)+
              ',m_sbyEnable='+IntToStr(m_sbyEnable)+
          //    ',m_sPhoto='+''''+m_sPhoto+''''+
              ' WHERE m_swUID='+IntToStr(pTable.m_swUID);
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AddUserTable(var pTable:SUSERTAG):Boolean;
Var
    strSQL : String;
    res    : Boolean;
Begin
    res := True;
    if IsUserTag(pTable)=True then Begin SetUserTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SUSERTAG'+
              '(m_swUID,m_swSLID,m_sdtRegDate,m_strShName,m_strPassword,m_strFam,m_strImya,m_strOtch,m_strDolgn,m_strHomeAddr,m_strTel,m_strEMail'+
              ',m_sbyPrmDE,m_sbyPrmPE,m_sbyPrmQE,m_sbyPrmCE,m_sbyPrmGE,m_sbyPrmTE,m_sbyPrmCNE,m_sbyPrmPRE,m_sbyEnable)'+
               ' VALUES('+
              IntToStr(m_swUID)+ ','+
              IntToStr(m_swSLID)+ ','+
              ''''+DateTimeToStr(m_sdtRegDate)+''''+ ','+
              ''''+m_strShName+''''+ ','+
              ''''+m_strPassword+''''+ ','+
              ''''+m_strFam+''''+ ','+
              ''''+m_strImya+''''+ ','+
              ''''+m_strOtch+''''+ ','+
              ''''+m_strDolgn+''''+ ','+
              ''''+m_strHomeAddr+''''+ ','+
              ''''+m_strTel+''''+ ','+
              ''''+m_strEMail+''''+ ','+
              IntToStr(m_sbyPrmDE)+ ','+
              IntToStr(m_sbyPrmPE)+ ','+
              IntToStr(m_sbyPrmQE)+ ','+
              IntToStr(m_sbyPrmCE)+ ','+
              IntToStr(m_sbyPrmGE)+ ','+
              IntToStr(m_sbyPrmTE)+ ','+
              IntToStr(m_sbyPrmCNE)+ ','+
              IntToStr(m_sbyPrmPRE)+ ','+
              IntToStr(m_sbyEnable)+')';
             // IntToStr(m_sbyEnable)+ '')';
             // ''''+m_sPhoto+''''+ ')';
    End;
    ExecQry(strSQL);
    Result := res;
End;
function CDBase.DelUserTable(swUID:Integer):Boolean;
Var
    strSQL : String;
Begin
    strSQL := 'DELETE FROM SUSERTAG WHERE m_swUID='+IntToStr(swUID);
    Result := ExecQry(strSQL);
End;
function CDBase.CheckLevelAccess(strUser,strPassword:String;nLevel:Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    m_swSLID : Integer;
Begin
    res := False;
    m_swSLID := -1;
    strSQL := 'SELECT m_swSLID FROM SUSERTAG WHERE m_strShName='+''''+strUser+''''+
    ' and m_strPassword='+''''+strPassword+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
     res      := True;
     m_swSLID := FADOQuery.FieldByName('m_swSLID').AsInteger;
    End;
    CloseQry;
    if m_swSLID=nLevel then
    res := True
     else
    res := False;
    Result := res;
End;
function CDBase.GetSecurityAttributes(var pTable:SUSERTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if m_nValue=0 then
    strSQL := 'SELECT * FROM SUSERTAG WHERE m_strShName='+''''+pTable.m_strShName+''''+
    ' and m_strPassword='+''''+pTable.m_strPassword+''''+
    ' and m_swSLID='+IntToStr(pTable.m_swSLID)
    else
    if m_nValue=1 then
    strSQL := 'SELECT * FROM SUSERTAG WHERE m_strShName='+''''+pTable.m_strShName+''''+
    ' and m_strPassword='+''''+pTable.m_strPassword+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
     with FADOQuery,pTable do
     Begin
      m_swID         := FieldByName('m_swID').AsInteger;
      m_swUID        := FieldByName('m_swUID').AsInteger;
      m_swSLID       := FieldByName('m_swSLID').AsInteger;
      m_sdtRegDate   := FieldByName('m_sdtRegDate').AsDateTime;

      m_strShName    := FieldByName('m_strShName').AsString;
      m_strPassword  := FieldByName('m_strPassword').AsString;
      m_strFam       := FieldByName('m_strFam').AsString;
      m_strImya      := FieldByName('m_strImya').AsString;
      m_strOtch      := FieldByName('m_strOtch').AsString;
      m_strDolgn     := FieldByName('m_strDolgn').AsString;
      m_strHomeAddr  := FieldByName('m_strHomeAddr').AsString;
      m_strTel       := FieldByName('m_strTel').AsString;
      m_strEMail     := FieldByName('m_strEMail').AsString;

      m_sbyPrmDE     := FieldByName('m_sbyPrmDE').AsInteger;
      m_sbyPrmPE     := FieldByName('m_sbyPrmPE').AsInteger;
      m_sbyPrmQE     := FieldByName('m_sbyPrmQE').AsInteger;
      m_sbyPrmCE     := FieldByName('m_sbyPrmCE').AsInteger;
      m_sbyPrmGE     := FieldByName('m_sbyPrmGE').AsInteger;
      m_sbyPrmTE     := FieldByName('m_sbyPrmTE').AsInteger;
      m_sbyPrmCNE    := FieldByName('m_sbyPrmCNE').AsInteger;
      m_sbyPrmPRE    := FieldByName('m_sbyPrmPRE').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
     // m_sPhoto       := FieldByName('m_sPhoto').AsString;
     End;
    End;
    CloseQry;
    Result := res;
End;



{
    //Color Settings
    SCOLORSETTTAG = packed record
     m_swID        : Integer;
     m_swCtrlID    : Integer;
     m_swColor     : Integer;
     m_sstrFontName:String;
     m_swFontSize  :Integer;
     m_swColorPanel : Integer;
    end;
    SCOLORSETTTAGS = packed record
     Count         : Integer;
     Items         : array of SCOLORSETTTAG;
    end;
}

function CDBase.GetColorsTable(var pTable:SCOLORSETTTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SCOLORSETTTAGS ORDER BY m_swCtrlID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swCtrlID    := FieldByName('m_swCtrlID').AsInteger;
      m_swColor     := FieldByName('m_swColor').AsInteger;
      m_sstrFontName:= FieldByName('m_sstrFontName').AsString;
      m_swFontSize  := FieldByName('m_swFontSize').AsInteger;
      m_swColorPanel:= FieldByName('m_swColorPanel').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetColorTable(var pTable:SCOLORSETTTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SCOLORSETTTAGS WHERE m_swCtrlID='+IntToStr(pTable.m_swCtrlID)+' ORDER BY m_swCtrlID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
     with FADOQuery,pTable do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swCtrlID    := FieldByName('m_swCtrlID').AsInteger;
      m_swColor     := FieldByName('m_swColor').AsInteger;
      m_sstrFontName:= FieldByName('m_sstrFontName').AsString;
      m_swFontSize  := FieldByName('m_swFontSize').AsInteger;
      End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetNameFont(var pTable:SCOLORSETTTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SCOLORSETTTAGS WHERE m_swCtrlID='+IntToStr(pTable.m_swCtrlID)+' ORDER BY m_swCtrlID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
     with FADOQuery,pTable do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swCtrlID    := FieldByName('m_swCtrlID').AsInteger;
      m_sstrFontName:= FieldByName('m_sstrFontName').AsString;
      End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetColorTablePanel(var pTable:SCOLORSETTTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SCOLORSETTTAGS WHERE m_swCtrlID='+IntToStr(pTable.m_swCtrlID)+' ORDER BY m_swCtrlID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
     with FADOQuery,pTable do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swColorPanel:= FieldByName('m_swColorPanel').AsInteger;
      End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsColor(nIndex:Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SCOLORSETTTAGS WHERE m_swCtrlID='+IntToStr(nIndex);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetColorTable(var pTable:SCOLORSETTTAG):Boolean;
Var
    strSQL : String;
BEgin
    with pTable do
    Begin
   strSQL := 'UPDATE SCOLORSETTTAGS SET '+
              ' m_swColor='+IntToStr(m_swColor)+
              ',m_sstrFontName='+''''+m_sstrFontName+''''+
              ',m_swFontSize='+IntToStr(m_swFontSize)+
              ' WHERE m_swCtrlID='+IntToStr(m_swCtrlID);
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AddColorTable(var pTable:SCOLORSETTTAG):Boolean;
Var
    strSQL   : String;
Begin
    if IsColor(pTable.m_swCtrlID)=True then Begin SetColorTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
   strSQL := 'INSERT INTO SCOLORSETTTAGS'+
              '(m_swCtrlID,m_swColor,m_sstrFontName,m_swFontSize)'+
              ' VALUES('+
              IntToStr(m_swCtrlID)+ ','+
              IntToStr(m_swColor)+ ','+
              ''''+m_sstrFontName+''''+ ','+
              IntToStr(m_swFontSize)+')';

    End;
    Result := ExecQry(strSQL);
End;
function CDBase.SetColorPanel(var pTable:SCOLORSETTTAG):Boolean;
Var
    strSQL : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SCOLORSETTTAGS SET '+
              ' m_swColorPanel='+IntToStr(m_swColorPanel)+
              ' WHERE m_swCtrlID='+IntToStr(m_swCtrlID);
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AddColorPanel(var pTable:SCOLORSETTTAG):Boolean;
Var
    strSQL   : String;
Begin
    if IsColor(pTable.m_swCtrlID)=True then Begin SetColorPanel(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SCOLORSETTTAGS'+
              '(m_swCtrlID,m_swColorPanel)'+
              ' VALUES('+
              IntToStr(m_swCtrlID)+ ','+
              IntToStr(m_swColorPanel)+ ')';

    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelColorsTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM SCONNSETTTAGS WHERE m_swCtrlID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM SCONNSETTTAGS';
    Result := ExecQry(strSQL);
End;
{
    //Scins Settings
    SSKINSETTTAG = packed record
     m_swID        : Integer;
     m_swSkinID    : Integer;
     m_schSkinName : String[50];
     m_byIsCurrent : Byte;
    end;
    STEMSSETTTAGS = packed record
     Count         : Integer;
     Items         : array of SSKINSETTTAG;
    end;
}
function CDBase.GetSkinsTable(var pTable:SSKINSETTTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SSKINSETTTAGS ORDER BY m_swSkinID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swSkinID    := FieldByName('m_swSkinID').AsInteger;
      m_schSkinName := FieldByName('m_schSkinName').AsString;
      m_byIsCurrent := FieldByName('m_byIsCurrent').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsSkin(nIndex:Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SSKINSETTTAGS WHERE m_swSkinID='+IntToStr(nIndex);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
{
 m_swSkinID    : Integer;
     m_schSkinName : String[50];
     m_byIsCurrent : Byte;
}
function CDBase.SetSkinTable(var pTable:SSKINSETTTAG):Boolean;
Var
    strSQL : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SSKINSETTTAGS SET '+
              ' m_schSkinName='+''''+m_schSkinName+''''+
              ',m_byIsCurrent='+IntToStr(m_byIsCurrent)+
              ' WHERE m_swSkinID=' +IntToStr(m_swSkinID);
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AddSkinTable(var pTable:SSKINSETTTAG):Boolean;
Var
    strSQL   : String;
Begin
    if IsSkin(pTable.m_swSkinID)=True then Begin SetSkinTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SSKINSETTTAGS'+
              '(m_swSkinID,m_schSkinName,m_byIsCurrent)'+
              ' VALUES('+
              IntToStr(m_swSkinID)+ ','+
              ''''+m_schSkinName+''''+ ','+
              IntToStr(m_byIsCurrent)+  ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelSkinsTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM SSKINSETTTAGS WHERE m_swSkinID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM SSKINSETTTAGS';
    Result := ExecQry(strSQL);
End;
{
    //Hard Key Settings
    SHKEYSETTTAG = packed record
     m_swID         : Integer;
     m_swPortID     : Integer;
     m_swPortTypeID : Integer;
    end;
}
//function CDBase.GetHkeySettTable(var pTable:SHKEYSETTTAG):Boolean;
//function CDBase.SetGenSettTable(var pTable:SHKEYSETTTAG):Boolean;
function CDBase.GetHkeySettTable(var pTable:SHKEYSETTTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT * FROM SHKEYSETTTAG';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    with FADOQuery,pTable do
    Begin
      m_swPortID     := FieldByName('m_swPortID').AsInteger;
      m_swPortTypeID := FieldByName('m_swPortTypeID').AsInteger;
     res   := True;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetHkeySettTable(var pTable:SHKEYSETTTAG):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SHKEYSETTTAG SET '+
              ' m_swPortID='  +IntToStr(m_swPortID)+
              ',m_swPortTypeID=' +IntToStr(m_swPortTypeID);
    End;
    Result := ExecQry(strSQL);
End;

//Data Routing
//L3CURRENTDATA
{
L3CURRENTDATA = packed record
     m_swID    : Word;
     m_swVMID  : WORD;
     m_swCMDID : Word;
     m_sTime   : TDateTime;
     m_sfValue : Double;
    end;
}
function CDBase.IsCurrentParam(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and m_swCMDID='+IntToStr(pTable.m_swCMDID)+
    ' and m_swTID='+IntToStr(pTable.m_swTID);
    res := False;
    if OpenQryD(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQryD;
    Result := res;
End;
function CDBase.DeleteCurrentParam(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex=-1 then
    strSQL := 'DELETE FROM L3CURRENTDATA';
    if nIndex<>-1 then
    strSQL := 'DELETE FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(nIndex);
    Result := ExecQryD(strSQL);
End;
{
L3CURRENTDATA = packed record
     m_swID    : Word;
     m_swVMID  : Word;
     m_swTID   : Word;
     m_swCMDID : Word;
     m_swSID   : Word;
     m_sTime   : TDateTime;
     m_sfValue : Double;
    end;
}
function CDBase.AddCurrentParam(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL   : String;
Begin
    if IsCurrentParam(pTable)=True then Begin {SetCurrentParam(pTable);}Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO L3CURRENTDATA'+
              '(m_swVMID,m_swCMDID,m_swTID,m_sTime,m_sfValue,m_byOutState,m_byInState)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              IntToStr(m_swTID)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              FloatToStr(m_sfValue)+','+
              IntToStr(m_byOutState)+ ','+
              IntToStr(m_byInState)+  ')';
    End;
    Result := ExecQryD(strSQL);
End;

function CDBase.SetCurrentParam(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL   : String;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE L3CURRENTDATA SET '+
              ' m_sTime='+''''+DateTimeToStr(m_sTime)+''''+
              ',m_sfValue='+FloatToStr(m_sfValue)+
              ',m_byOutState='+IntToStr(m_byOutState)+
              ',m_byInState='+IntToStr(m_byInState)+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+
              ' and m_swVMID='+IntToStr(m_swVMID)+
              ' and m_swTID='+IntToStr(m_swTID);
    End;
    Result := ExecQryD(strSQL);
End;
function CDBase.SetArchParam(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL   : String;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE L3CURRENTDATA SET '+
              ' m_sTime='+''''+DateTimeToStr(m_sTime)+''''+
              ',m_sfValue='+FloatToStr(m_sfValue)+
              ',m_byOutState='+IntToStr(m_byOutState)+
              ',m_byInState='+IntToStr(m_byInState)+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+' and m_swVMID='+IntToStr(m_swVMID);
    End;
    Result := ExecQryD(strSQL);
End;
function CDBase.UpateLastTime(nVMID,nCMDID:Integer;dtTime:TDateTime):Boolean;
Var
    strSQL   : String;
Begin
    Begin
    strSQL := 'UPDATE SL3PARAMS SET '+
              ' m_dtLastTime='+''''+DateTimeToStr(dtTime)+''''+
              ' WHERE m_swParamID=' +IntToStr(nCMDID)+' and m_swVMID='+IntToStr(nVMID);
    End;
    Result := ExecQryD(strSQL);
End;
function CDBase.VParamTSynchronize;
Var
    strSQL : String;
    tmTime : TDateTime;
Begin
    tmTime := Now;
    tmTime := cDateTimeR.DecDate(tmTime);
    strSQL := 'UPDATE SL3PARAMS SET m_dtLastTime='+''''+DateTimeToStr(tmTime)+'''';
    Result := ExecQryD(strSQL);
End;
function CDBase.UpdateLastParam(nVMID,nCMDID:Integer;fValue:Double):Boolean;
Var
    strSQL   : String;
Begin
    Begin
    strSQL := 'UPDATE SL3PARAMS SET '+
              ' m_fValue='+FloatToStr(fValue)+
              ' WHERE m_swParamID=' +IntToStr(nCMDID)+' and m_swVMID='+IntToStr(nVMID);
    End;
    Result := ExecQryD(strSQL);
End;
function CDBase.UpdateLastParamTime(nVMID,nCMDID:Integer;fValue:Double;dtTime:TDateTime):Boolean;
Var
    strSQL   : String;
Begin
    Begin
    strSQL := 'UPDATE SL3PARAMS SET '+
              ' m_fValue='+FloatToStr(fValue)+
              ',m_dtLastTime='+''''+DateTimeToStr(dtTime)+''''+
              ' WHERE m_swParamID=' +IntToStr(nCMDID)+' and m_swVMID='+IntToStr(nVMID);
    End;
    Result := ExecQryD(strSQL);
End;
function CDBase.UpdateExpression(nVMID,nCMDID:Integer;str:String):Boolean;
Var
    strSQL   : String;
Begin
    Begin
    strSQL := 'UPDATE SL3PARAMS SET '+
              ' m_sParamExpress='+''''+str+''''+
              ' WHERE m_swParamID=' +IntToStr(nCMDID)+' and m_swVMID='+IntToStr(nVMID);
    End;
    Result := ExecQryD(strSQL);
End;
function CDBase.UpdateMaxParam(nVMID,nCMDID:Integer;fValue:Double):Boolean;
Var
    strSQL   : String;
Begin
    Begin
    strSQL := 'UPDATE SL3PARAMS SET '+
              ' m_fMax='+FloatToStr(fValue)+
              ' WHERE m_swParamID=' +IntToStr(nCMDID)+' and m_swVMID='+IntToStr(nVMID);
    End;
    Result := ExecQryD(strSQL);
End;
function CDBase.UpdateMinParam(nVMID,nCMDID:Integer;fValue:Double):Boolean;
Var
    strSQL   : String;
Begin
    Begin
    strSQL := 'UPDATE SL3PARAMS SET '+
              ' m_fMin='+FloatToStr(fValue)+
              ' WHERE m_swParamID=' +IntToStr(nCMDID)+' and m_swVMID='+IntToStr(nVMID);
    End;
    Result := ExecQryD(strSQL);
End;

{
    SL3PARAMS = packed record
     m_swID          : Word;
     m_swVMID        : WORD;
     m_swParamID     : WORD;
     m_sParamExpress : String[30];
     m_fValue        : Double;
     m_fMin          : Double;
     m_fMax          : Double;
     m_fLimit        : Double;
     m_dtDateTime    : TDateTime;
     m_sblCalculate  : Byte;
     m_sblSaved      : Byte;
     m_sblEnable     : Byte;
    end;
    PSL3PARAMS =^ SL3PARAMS;
    QM_PARAM = packed record
     m_swID      : Word;
     m_swType    : Word;
     m_sName     : String[40];
     m_sShName   : String[30];
     m_sEName    : String[10];
     m_sEMet     : String[10];
     m_swSvPeriod: Word;
     m_swActive  : Byte;
     m_swStatus  : Byte;
     m_swIsGraph : Byte;
    end;
    PQM_PARAM =^ QM_PARAM;
    CGMetaData = packed record
     m_swID       : Integer;
     m_dtDateTime : TDateTime;
     m_sName    : String;
     m_fMin      : Double;
     m_fMax      : Double;
     m_fLimit      : Double;
     m_sEMet   : String;
    End;
    PCGMetaData =^ CGMetaData;
}
function CDBase.SetMetaData(nIndex:Integer;var pTable:CGMetaData):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3PARAMS SET '+
              ' m_fMin='         +FloatToStrF(m_fMin,ffFixed,3,3)+
              ',m_fLimit='       +FloatToStrF(m_fLimit,ffFixed,3,3)+
              ',m_fMax='         +FloatToStrF(m_fMax,ffFixed,3,3)+
              ',m_sbyDataGroup=' +IntToStr(m_sbyDataGroup)+
              ' WHERE m_swVMID=' +IntToStr(nIndex)+' and m_swParamID='+IntToStr(pTable.m_swType);
   End;
   Result := ExecQryD1(strSQL);
End;
function CDBase.GetMetaData(nIndex,nDataType:Integer;var pTable:CGMetaDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
    pMD      : CGMetaData;
Begin
    if nDataType<>-1 then
    strSQL := 'SELECT m_swType,QM_PARAMS.m_sblTarif,SL3PARAMS.m_swStatus,QM_PARAMS.m_sName,SL3PARAMS.m_fMin,SL3PARAMS.m_fMax,SL3PARAMS.m_fLimit,QM_PARAMS.m_sEMet,SL3PARAMS.m_sbyDataGroup'+
    ' FROM SL3PARAMS,QM_PARAMS WHERE m_sblCalculate=1 and SL3PARAMS.m_swVMID='+IntToStr(nIndex)+
    ' and m_swParamID=m_swType and SL3PARAMS.m_sbyDataGroup='+IntToStr(nDataType)+' ORDER BY m_swParamID' else
    strSQL := 'SELECT m_swType,QM_PARAMS.m_sblTarif,SL3PARAMS.m_swStatus,QM_PARAMS.m_sName,SL3PARAMS.m_fMin,SL3PARAMS.m_fMax,SL3PARAMS.m_fLimit,QM_PARAMS.m_sEMet,SL3PARAMS.m_sbyDataGroup'+
    ' FROM SL3PARAMS,QM_PARAMS WHERE m_sblCalculate=1 and SL3PARAMS.m_swVMID='+IntToStr(nIndex)+
    ' and m_swParamID=m_swType ORDER BY m_swParamID';
    res := False;
    if OpenQryD2(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryD2.Eof do Begin
     with FADOQueryD2,pTable.Items[i] do  Begin
      m_swID         := i;
      //m_dtLastTime := FieldByName('m_dtLastTime').AsDateTime;
      m_swType       := FieldByName('m_swType').AsInteger;
      m_sblTarif     := FieldByName('m_sblTarif').AsInteger;
      m_swStatus     := FieldByName('m_swStatus').AsInteger;
      m_sName        := FieldByName('m_sName').AsString;
      m_fMin         := FieldByName('m_fMin').AsFloat;
      m_fMax         := FieldByName('m_fMax').AsFloat;
      m_fLimit       := FieldByName('m_fLimit').AsFloat;
      m_sEMet        := FieldByName('m_sEMet').AsString;
      m_sbyDataGroup := FieldByName('m_sbyDataGroup').AsInteger;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;
{
m_swID    : Word;
     m_swVMID  : Word;
     m_swTID   : Word;
     m_swCMDID : Word;
     m_swSID   : Word;
     m_sTime   : TDateTime;
     m_sfValue : Double;
}
function CDBase.GetTariffData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT *'+
    ' FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(FIndex)+
    ' and m_swCMDID='+IntToStr(FCmdIndex)+' and m_swTID<>0 ORDER BY m_swTID';
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryD1.Eof do Begin
     with FADOQueryD1,pTable.Items[i] do  Begin
      m_swID    := i;
      m_swVMID  := FieldByName('m_swVMID').AsInteger;
      m_swTID   := FieldByName('m_swTID').AsInteger;
      m_swCMDID := FieldByName('m_swCMDID').AsInteger;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      m_sfValue := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD1;
    Result := res;
End;
function CDBase.GetCurrentData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT *'+
    ' FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(FIndex)+
    ' and m_swCMDID='+IntToStr(FCmdIndex);
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryD1.Eof do Begin
     with FADOQueryD1,pTable.Items[i] do  Begin
      m_swID    := i;
      m_swVMID  := FieldByName('m_swVMID').AsInteger;
      m_swTID   := FieldByName('m_swTID').AsInteger;
      m_swCMDID := FieldByName('m_swCMDID').AsInteger;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      m_sfValue := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD1;
    Result := res;
End;
function CDBase.GetGMetaData(nIndex:Integer;var pTable:CGRMetaData):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
Begin
    strSQL := 'SELECT m_sName,m_sEName,m_sEMet FROM QM_PARAMS WHERE m_swType='+IntToStr(nIndex);
    res := False;
    if OpenQryD2(strSQL,nCount)=True then
    Begin
     res := True;
     with FADOQueryD2,pTable do
     Begin
      m_sName   := FieldByName('m_sName').AsString;
      m_sShName := FieldByName('m_sEName').AsString;
      m_sEMet   := FieldByName('m_sEMet').AsString;
     End;
    End;
    CloseQryD2;
    Result := res;
End;
{
L3CURRENTDATA = packed record
     m_swID    : Word;
     m_swVMID  : WORD;
     m_swCMDID : Word;
     m_sTime   : TDateTime;
     m_sfValue : Double;
    end;
    PL3CURRENTDATA =^ L3CURRENTDATA;
    CCData = packed record
     m_swID       : Integer;
     m_sTime      : TDateTime;
     m_sfValue      : Double;
    End;
    PCData=^ CData;

}
function CDBase.GetCData(nIndex,nDataType:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    if nDataType<>-1 then
    strSQL := 'SELECT m_swParamID,m_sTime,m_byOutState,m_byInState,m_sfValue FROM SL3PARAMS,L3CURRENTDATA'+
    ' WHERE SL3PARAMS.m_swVMID=L3CURRENTDATA.m_swVMID and M_SWCMDID=m_swParamID and m_sbyDataGroup='+IntToStr(nDataType)+
    ' and SL3PARAMS.m_swVMID='+IntToStr(nIndex)+' and L3CURRENTDATA.m_swTID=0 and m_sblCalculate=1 ORDER BY m_swParamID' else
    strSQL := 'SELECT m_swParamID,m_sTime,m_byOutState,m_byInState,m_sfValue FROM SL3PARAMS,L3CURRENTDATA'+
    ' WHERE SL3PARAMS.m_swVMID=L3CURRENTDATA.m_swVMID and M_SWCMDID=m_swParamID and m_sblCalculate=1'+
    ' and SL3PARAMS.m_swVMID='+IntToStr(nIndex)+' and L3CURRENTDATA.m_swTID=0 ORDER BY m_swParamID';
    {
    if nDataType<>-1 then
    strSQL := 'SELECT m_swParamID,m_sTime,m_fMin,m_fMax,m_sfValue FROM SL3PARAMS,L3CURRENTDATA'+
    ' WHERE SL3PARAMS.m_swVMID=L3CURRENTDATA.m_swVMID and M_SWCMDID=m_swParamID and m_sbyDataGroup='+IntToStr(nDataType)+
    ' and SL3PARAMS.m_swVMID='+IntToStr(nIndex)+' and L3CURRENTDATA.m_swTID=0 ORDER BY m_swParamID' else
    strSQL := 'SELECT m_swParamID,m_sTime,m_fMin,m_fMax,m_sfValue FROM SL3PARAMS,L3CURRENTDATA'+
    ' WHERE SL3PARAMS.m_swVMID=L3CURRENTDATA.m_swVMID and M_SWCMDID=m_swParamID'+
    ' and SL3PARAMS.m_swVMID='+IntToStr(nIndex)+' and L3CURRENTDATA.m_swTID=0 ORDER BY m_swParamID';
    }
    res := False;
    if OpenQryD2(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryD2.Eof do Begin
     with FADOQueryD2,pTable.Items[i] do  Begin
      m_swID    := i;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      //m_sfMin   := FieldByName('m_fMin').AsFloat;
      //m_sfMax   := FieldByName('m_fMax').AsFloat;
      m_byOutState := FieldByName('m_byOutState').AsInteger;
      m_byInState  := FieldByName('m_byInState').AsInteger;
      m_sfValue    := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;
function CDBase.GetGData(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
     if TID = 0 then
       strSQL := 'SELECT m_sTime,sum(m_sfValue) as m_sfValue'+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swTID<>0 and m_swTID<>4 and m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' GROUP BY m_sTime ORDER BY m_sTime '
     else
       strSQL := 'SELECT m_sTime,m_sfValue,m_swTID'+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 'm_swTID='+IntToStr(TID)+ ' and ' +
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime';
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryD1.Eof do Begin
     with FADOQueryD1,pTable.Items[i] do  Begin
      m_swID       := i;
      m_swTID      := TID;
      //m_swTID      := FieldByName('m_swTID').AsInteger;
      m_sTime      := FieldByName('m_sTime').AsDateTime;
      m_sfValue    := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD1;
    Result := res;
End;
function CDBase.GetGDataEnergo(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT m_swCMDID,m_sTime,m_sfValue,m_swTID'+
              ' FROM L3ARCHDATA'+
              ' WHERE m_swVMID='+IntToStr(FKey)+' and '+
              ' m_swCMDID BETWEEN '+ IntToStr(PKey) + ' and ' + IntToStr(PKey+4)+
              ' and m_swTID BETWEEN 0 and 3'+
              ' and CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_swCMDID';
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryD1.Eof do Begin
     with FADOQueryD1,pTable.Items[i] do  Begin
      m_swID       := i;
      m_swCMDID    := FieldByName('m_swCMDID').AsInteger;
      m_swTID      := FieldByName('m_swTID').AsInteger;
      m_sTime      := FieldByName('m_sTime').AsDateTime;
      m_sfValue    := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD1;
    Result := res;
End;
function CDBase.GetGDPData(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT m_sTime,m_sfValue'+
              ' FROM L3PDTDATA'+
              ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
              ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime';
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryD1.Eof do Begin
     with FADOQueryD1,pTable.Items[i] do  Begin
      m_swID       := i;
      m_sTime      := FieldByName('m_sTime').AsDateTime;
      m_sfValue    := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD1;
    Result := res;
End;

function CDBase.DelPdtData(Date1, Date2 : TDateTime; var Data :L3CURRENTDATA):Boolean;
Var
    strSQL : String;
Begin
    if Data.m_swVMID=$fffe then
    strSQL := 'DELETE FROM L3PDTDATA WHERE '+
    ' m_swCMDID=' + IntToStr(Data.m_swCMDID) else
    if Data.m_swVMID=$ffff then
    strSQL := 'DELETE FROM L3PDTDATA WHERE '+
    ' m_swCMDID=' + IntToStr(Data.m_swCMDID) +
    ' and CAST(m_sTime as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''' else
    if Data.m_swVMID<$fffe then
    strSQL := 'DELETE FROM L3PDTDATA WHERE m_swVMID='+
    IntToStr(Data.m_swVMID) + ' AND m_swCMDID=' + IntToStr(Data.m_swCMDID) +
    ' and CAST(m_sTime as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''';
    Result := ExecQryD1(strSQL);
End;
function CDBase.AddPdtData(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
Begin
    with pTable do
    Begin
    strSQL := 'INSERT INTO L3PDTDATA'+
              '(m_swVMID,m_swCMDID,m_sTime,m_sfValue,m_swTID)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              FloatToStr(m_sfValue)+ ',' + IntToStr(pTable.m_swTID) +')';
    End;
    Result := ExecQryD1(strSQL);
End;

function CDBase.DelArchData(Date1, Date2 : TDateTime; var Data :L3CURRENTDATA):Boolean;
Var
    strSQL                 : String;
    FirstCMDID,LastCMDID   : Integer;
Begin
    FirstCMDID := Data.m_swCMDID - (Data.m_swCMDID - 1) mod 4;
    LastCMDID  := FirstCMDID + 4;
    if Data.m_swVMID=$fffe then
    strSQL := 'DELETE FROM L3ARCHDATA WHERE '+
    ' m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) else
    if Data.m_swVMID=$ffff then
    strSQL := 'DELETE FROM L3ARCHDATA WHERE '+
    ' m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sTime as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''' else
    if Data.m_swVMID<$fffe then
    strSQL := 'DELETE FROM L3ARCHDATA WHERE m_swVMID='+
    IntToStr(Data.m_swVMID) + ' AND m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sTime as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''';
    Result := ExecQryD1(strSQL);
End;
function CDBase.AddArchData(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
Begin
    if IsArchData(pTable)=True then
    Begin
      UpdateArchData(pTable);
      Result:=False;
      exit;
    End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO L3ARCHDATA'+
              '(m_swVMID,m_swCMDID,m_sTime,m_sfValue,m_swTID)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              FloatToStr(m_sfValue)+ ',' + IntToStr(pTable.m_swTID) +')';
    End;
    Result := ExecQryD1(strSQL);
End;

function CDBase.UpdateArchData(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
begin
    with pTable do
    Begin
    strSQL := 'UPDATE L3ARCHDATA SET ' +
              'm_sfValue=' + FloatToStr(m_sfValue) +
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+' and m_swVMID='+IntToStr(m_swVMID) +
              ' and m_swTID=' + IntToStr(pTable.m_swTID) +
              ' AND CAST(m_sTime as Date)='+''''+DateToStr(m_sTime)+'''';
    End;
    Result := ExecQryD1(strSQL);
end;

function CDBase.IsArchData(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM L3ARCHDATA WHERE'+
    ' m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and m_swCMDID='+IntToStr(pTable.m_swCMDID)+
    ' and m_swVMID=' + IntToStr(pTable.m_swVMID)+
    ' and m_swTID=' + IntToStr(pTable.m_swTID) +
    ' and CAST(m_sTime as Date)='+''''+DateToStr(pTable.m_sTime)+'''';
    //' and m_sdtDate='+''''+DateTimeToStr(pTable.m_sdtDate)+'''';
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQryD1;
    Result := res;
end;

function CDBase.GetGraphDatas(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin
    strSQL := 'SELECT *' +
     ' FROM L2HALF_HOURLY_ENERGY'+
     ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and'+
     ' CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sdtDate';
    res := False;
    if OpenQryD2(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    
    SetLength(pTable.Items,nCount);




    while not FADOQueryD2.Eof do Begin
     with FADOQueryD2,pTable.Items[i] do  Begin
      m_swID       := i;
      //m_sdtLastTime  := FieldByName('m_sdtLastTime').AsDateTime;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      for j:=0 to 47 do v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;
function CDBase.GetGraphDatasEnergo(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin
    strSQL := 'SELECT *' +
     ' FROM L2HALF_HOURLY_ENERGY'+
     ' WHERE m_swVMID='+IntToStr(FKey)+' and '+
     ' m_swCMDID BETWEEN '+IntToStr(PKey)+' and '+IntToStr(PKey+4)+
     ' and CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sdtDate';
    res := False;
    if OpenQryD2(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryD2.Eof do Begin
     with FADOQueryD2,pTable.Items[i] do  Begin
      m_swID       := i;
      //m_sdtLastTime  := FieldByName('m_sdtLastTime').AsDateTime;
      m_swCMDID      := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      for j:=0 to 47 do v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;
function CDBase.GetLastTime:TDateTime;
Var
    strSQL : AnsiString;
    nCount : Integer;
Begin
    strSQL := 'SELECT max(m_sdtDate) as m_sdtDate FROM L2HALF_HOURLY_ENERGY';
    Result := Now;
    if OpenQryD2(strSQL,nCount)=True then
    Result := FADOQueryD2.FieldByName('m_sdtDate').AsDateTime;
    CloseQryD2;
End;
function CDBase.AddGraphData(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL,strV,strD : AnsiString;
    i,nLen : Integer;
Begin
    if IsGraphData(pTable)=True then
    Begin
      UpdateGraphData(pTable);
      Result:=False;
      exit;
    End;
    for i:=0 to 47 do strD := strD + ','+FloatToStr(pTable.v[i]);
    for i:=0 to 47 do strV := strV + ',v'+IntToStr(i);
    with pTable do
    Begin
    strSQL := 'INSERT INTO L2HALF_HOURLY_ENERGY'+
              '(m_swVMID,m_swCMDID,m_swSumm,m_sdtLastTime,m_sdtDate'+strV+')'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              FloatToStr(m_swSumm)+ ','+
              ''''+DateTimeToStr(m_sdtLastTime)+''''+ ','+
              ''''+DateTimeToStr(m_sdtDate)+''''+strD+')';
    End;
    //TraceL(4,0,'(__)CLDBD::>CVPRM INS LEN : '+IntToStr(Length(strSQL)));
    Result := ExecQryD1(strSQL);
End;
/////////////////BRESTENERGO/////////////////////////////
function CDBase.IsArchUspd(var pTable:Arch_uspd):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin

    strSQL := 'SELECT 0 FROM Arch_uspd WHERE'+
    ' n_obj='+IntToStr(pTable.n_obj)+
    ' and Link_adr='+IntToStr(pTable.Link_adr)+
    ' and event_text = ' +''''+ pTable.event_text +''''+
    ' and on_date_time=' +''''+DateTimeToStr(pTable.on_date_time)+'''';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.AddArchUspdTable(var pTable:Arch_uspd; nGroup,nEvent:Integer):Boolean;
Var
    strSQL   : String;
    nCount   : integer;
    m_nobj   :SL3VMETERTAG;
    m_nevent : SEVENTSETTTAG;
Begin

    strSQL := 'SELECT  SEVENTSETTTAGS.M_SCHEVENTNAME FROM SEVENTSETTTAGS,SEVENTTTAG WHERE '+
    ' SEVENTTTAG.M_SWVMID = '+ IntToStr(pTable.n_obj) +
    ' AND  SEVENTSETTTAGS.M_SWGROUPID =' + IntToStr(nGroup) +
    ' AND  SEVENTSETTTAGS.M_SWEVENTID =' + IntToStr(nEvent);
    if OpenQry(strSQL,nCount)=True then
    m_nevent.m_schEventName   := FADOQuery.FieldByName('M_SCHEVENTNAME').AsString;
    CloseQry;
    strSQL := 'SELECT  m_sbyPortID,m_sddPHAddres From SL3VMETERTAG WHERE SL3VMETERTAG.m_swVMID = '+IntToStr(pTable.n_obj) ;
    if OpenQry(strSQL,nCount)=true then
    Begin
     m_nobj.m_sbyPortID   := FADOQuery.FieldByName('m_sbyPortID').AsInteger;
     m_nobj.m_sddPHAddres := FADOQuery.FieldbyName('m_sddPHAddres').AsString;
    End;
    CloseQry;
    pTable.link_adr :=  pTable.n_obj;
    pTable.n_obj    :=  m_nobj.m_sbyPortID;
    //pTable.link_adr :=  StrToInt(m_nobj.m_sddPHAddres);
    pTable.event_text :=  m_nevent.M_SCHEVENTNAME;

    Result := False;
    if IsArchUspd(pTable)<>True then
    Begin
    with pTable do
    Begin
    strSQL := 'INSERT INTO Arch_uspd'+
              '(n_obj,Link_adr,n_ri,on_date_time,event_text)'+
              ' VALUES('+
              IntToStr(n_obj)+ ','+
              IntToStr(Link_adr)+ ','+
              IntToStr(n_ri)+ ','+
             ''''+DateTimeToStr(on_date_time)+''''+ ','+
             ''''+event_text  +''''+')'

    end;
    End;
   Result := ExecQryD1(strSQL);
End;

function CDBase.DelArchUspdTable(nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime):Boolean;
Var
    strSQL : String;
    pTable : ARCH_USPD;
    nCount   : integer;
    m_nobj   : SL3VMETERTAG;
    m_nevent : SEVENTSETTTAG;
Begin
     strSQL := 'SELECT  SEVENTSETTTAGS.M_SCHEVENTNAME FROM SEVENTSETTTAGS,SEVENTTTAG WHERE '+
    ' SEVENTTTAG.M_SWVMID = '+IntToStr(nVMID)+
    ' AND  SEVENTSETTTAGS.M_SWGROUPID =' + IntToStr(nGroup); //+
    OpenQry(strSQL,nCount);
    m_nevent.m_schEventName   := FADOQuery.FieldByName('M_SCHEVENTNAME').AsString;
    CloseQry;
    strSQL := 'SELECT  m_sbyPortID,m_sddPHAddres From SL3VMETERTAG WHERE SL3VMETERTAG.m_swVMID = '+IntToStr(nVMID) ;
    OpenQry(strSQL,nCount);
    m_nobj.m_sbyPortID   := FADOQuery.FieldByName('m_sbyPortID').AsInteger;
    m_nobj.m_sddPHAddres := FADOQuery.FieldbyName('m_sddPHAddres').AsString;
    CloseQry;
    pTable.n_obj    :=  m_nobj.m_sbyPortID;
    pTable.link_adr :=  nVMID;
    //pTable.link_adr :=  StrToInt(m_nobj.m_sddPHAddres);
    pTable.event_text :=  m_nevent.M_SCHEVENTNAME;

    if nVMID=-1 then nVMID := 0;
    if (nGroup=-1)and(nEvents=-1) then  strSQL := 'DELETE FROM Arch_uspd WHERE'+
    ' n_obj='+ IntToStr(pTable.n_obj) +
    ' and Link_adr =' + IntToStr(pTable.link_adr) +
    ' and CAST(on_date_time AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + ''''
    else
    if (nGroup<>-1)and(nEvents=-1) then  strSQL := 'DELETE FROM Arch_uspd WHERE'+
    ' n_obj='+ IntToStr(pTable.n_obj) +
    ' and Link_adr =' + IntToStr(pTable.link_adr) +
    ' and CAST(on_date_time AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + ''''
    else
    if (nGroup<>-1)and(nEvents<>-1) then  strSQL := 'DELETE FROM Arch_uspd WHERE'+
    ' n_obj='+ IntToStr(pTable.n_obj) +
    ' and Link_adr =' + IntToStr(pTable.link_adr) +
    ' and event_text = ' +''''+ pTable.event_text +''''+
    ' and CAST(on_date_time AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + '''';
    Result := ExecQry(strSQL);
End;
////////////valgraphic////////////////////
{
   VAl = packed record
     n_obj       : Word;
     link_adr    : Word;
     n_ri        : Word;
     izm_type    : Word;
     data        : TDateTime;
     inter_val   : Word;
     n_zone      : Word;
     znach       : Double;
     flag        : string[10];
    end;
}
////////////valpokazania////////////////////
function CDBase.IsArchDataenergo(var pTable:val):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM val WHERE'+
    ' n_obj='+IntToStr(pTable.n_obj)+
    ' and link_adr='+IntToStr(pTable.link_adr)+
    ' and izm_type='+IntToStr(pTable.izm_type)+
    ' and n_zone='+IntToStr(pTable.n_zone)+
    ' and inter_val='+IntToStr(pTable.inter_val)+
    ' and Data='+''''+DateToStr(pTable.Data)+'''';
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQryD1;
    Result := res;
end;
function CDBase.UpdateArchDataEnergo(var pTable:val):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    i,nLen : Integer;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE val SET '+
              ' znach='+FloatToStr(znach)+
              ',Data='   +''''+DateToStr(Data)+''''+
              ' WHERE n_obj=' +IntToStr(n_obj)+' and link_adr='+IntToStr(link_adr) +
              ' AND IZM_TYPE = ' +IntToStr(IZM_TYPE)+
              ' AND n_zone = ' +IntToStr(n_zone)+
              ' AND inter_val = ' +IntToStr(inter_val)+
              ' AND Data = ' + '''' + DateToStr(pTable.Data) + '''';
    nLen := Length(strSQL);
    End;
    Result := ExecQryD1(strSQL);
End;

function CDBase.AddArchDataEnergo(var pTable:VAl):Boolean;
Var
    strSQL : AnsiString;
Begin
    {
    if IsArchDataEnergo(pTable)=True then
    Begin
     UpdateArchDataEnergo(pTable);
     Result:=False;
     exit;
    End;
    }
    with pTable do
    Begin
    strSQL := 'INSERT INTO VAL'+
              '(n_obj,link_adr,n_ri,izm_type,inter_val,n_zone,znach,flag,Data)'+
              ' VALUES('+
              IntToStr(n_obj)+ ','+
              IntToStr(link_adr)+ ','+
              IntToStr(n_ri)+ ','+
              IntToStr(izm_type)+ ','+
              IntToStr(inter_val)+ ','+
              IntToStr(n_zone)+ ','+
              FloatToStr(znach)+ ','+
              ''''+flag   +'''' +','+
              ''''+DateToStr(Data)+''''+')';
     End;
     Result := ExecQryD1(strSQL);
End;
function CDBase.DelArchEnergoData(Date1, Date2 : TDateTime; var Data :VAL):Boolean;
Var
    strSQL                 : String;
    FirstCMDID,LastCMDID,nCount   : Integer;
    m_nobj:SL3VMETERTAG;
Begin
    FirstCMDID := Data.izm_type - (Data.izm_type - 1) mod 4;
    LastCMDID  := FirstCMDID + 4;
    if Data.n_obj=$fffe then
    strSQL := 'DELETE FROM VAL WHERE '+
    ' izm_type BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) else
    if Data.n_obj=$ffff then
    strSQL := 'DELETE FROM VAL WHERE '+
    ' izm_type BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and DATA BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''' else
    if Data.n_obj<$fffe then
    begin
     strSQL := 'SELECT  * From SL3VMETERTAG WHERE SL3VMETERTAG.m_swVMID = '+IntToStr(Data.n_obj) ;
     if OpenQry(strSQL,nCount)=True then
     Begin
      m_nobj.m_sbyPortID   := FADOQuery.FieldByName('m_sbyPortID').AsInteger;
      //m_nobj.m_sddPHAddres := FADOQuery.FieldbyName('m_sddPHAddres').AsString;
      Data.link_adr :=  Data.n_obj;
      Data.n_obj    :=  m_nobj.m_sbyPortID;
     end;
     CloseQry;
     strSQL := 'DELETE FROM VAL WHERE n_obj= '+
     IntToStr(Data.n_obj) + 'AND link_adr = '+IntToStr(Data.link_adr)+
     ' AND izm_type BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
     ' and DATA BETWEEN '+''''+DateToStr(Date1)+'''' +
     ' and ' + '''' + DateToStr(Date2) + '''';
    end;
    Result := ExecQryD1(strSQL);
End;
//////////////////////////////////////////////////////////////////////////////

{
//Data Routing
    L3GRAPHDATA = packed record
     m_swID        : Word;
     m_swVMID      : Word;
     m_swCMDID     : Word;
     m_swSumm      : Double;
     m_sdtLastTime : TDateTime;
     m_sdtDate     : TDateTime;
     v0            : array[0..47] of Double;
    end;
    PL3GRAPHDATA =^ L3GRAPHDATA;
    L3GRAPHDATAS = packed record
     Count : Integer;
     Items         : array of L3GRAPHDATA;
    end;
}
function CDBase.UpdateGraphFilds(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL,strD,strV : AnsiString;
    i,nLen : Integer;
    pTab   : L3GRAPHDATA;
Begin
    pTab.m_swVMID      := pTable.m_swVMID;
    pTab.m_swCMDID     := pTable.m_swCMDID;
    pTab.m_sdtDate     := pTable.m_sTime;
    pTab.m_sdtLastTime := pTable.m_sTime;
    if pTable.m_swSID>47 then exit;

    if IsGraphData(pTab)=False then
    Begin
     for i:=0 to 47 do strD := strD + ','+FloatToStr(0);
     for i:=0 to 47 do strV := strV + ',v'+IntToStr(i);
     with pTab do
     Begin
      strSQL := 'INSERT INTO L2HALF_HOURLY_ENERGY'+
                '(m_swVMID,m_swCMDID,m_swSumm,m_sdtLastTime,m_sdtDate'+strV+')'+
                ' VALUES('+
                IntToStr(m_swVMID)+ ','+
                IntToStr(m_swCMDID)+ ','+
                FloatToStr(m_swSumm)+ ','+
                ''''+DateTimeToStr(m_sdtLastTime)+''''+ ','+
                ''''+DateTimeToStr(m_sdtDate)+''''+strD+')';
     End;
     ExecQryD1(strSQL);
    End;

    strV := ' ,v'+IntToStr(pTable.m_swSID)+'='+FloatToStr(pTable.m_sfValue);
    with pTable do
    Begin
    strSQL := 'UPDATE L2HALF_HOURLY_ENERGY SET '+
              ' m_sdtDate='   +''''+DateTimeToStr(m_sTime)+''''+
              strV+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+' and m_swVMID='+IntToStr(m_swVMID) +
              ' AND CAST(m_sdtDate as Date) = ' + '''' + DateToStr(pTable.m_sTime) + '''';
    nLen := Length(strSQL);
    //TraceL(4,0,'(__)CLDBD::>CVPRM UPD LEN : '+IntToStr(nLen));
    End;
    Result := ExecQryD1(strSQL);
End;
function CDBase.UpdateGraphData(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL,strD : AnsiString;
    i,nLen : Integer;
Begin
    for i:=0 to 47 do
    Begin
     if (pTable.v[i]<0.000001) then
      pTable.v[i]:=0;
     strD := strD + ',v'+IntToStr(i)+'='+FloatToStr(pTable.v[i]);
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE L2HALF_HOURLY_ENERGY SET '+
              ' m_swSumm='+FloatToStr(m_swSumm)+
              ',m_sdtLastTime='+''''+DateTimeToStr(m_sdtLastTime)+''''+
              ',m_sdtDate='   +''''+DateTimeToStr(m_sdtDate)+''''+
              strD+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+' and m_swVMID='+IntToStr(m_swVMID) +
              ' AND CAST(m_sdtDate as Date) = ' + '''' + DateToStr(pTable.m_sdtDate) + '''';
    nLen := Length(strSQL);
    //TraceL(4,0,'(__)CLDBD::>CVPRM UPD LEN : '+IntToStr(nLen));
    //nLen := Length(strSQL);
    //nLen := Length(strSQL);
    //nLen := Length(strSQL);
    End;
    Result := ExecQryD1(strSQL);
End;
function CDBase.IsGraphData(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM L2HALF_HOURLY_ENERGY WHERE'+
    ' m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and m_swCMDID='+IntToStr(pTable.m_swCMDID)+
    ' and CAST(m_sdtDate as DATE)='+''''+DateToStr(pTable.m_sdtDate)+'''';
    //' and m_sdtDate='+''''+DateTimeToStr(pTable.m_sdtDate)+'''';
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQryD1;
    Result := res;
End;
//CAST(m_sTime AS DATE)
function CDBase.DelGraphData(Date1, Date2 : TDateTime;var Data :L3GRAPHDATA):Boolean;
Var
    strSQL                 : String;
    FirstCMDID,LastCMDID   : Integer;
Begin
    FirstCMDID := Data.m_swCMDID - (Data.m_swCMDID - 1) mod 4;
    LastCMDID  := FirstCMDID + 4;
    if Data.m_swVMID=$fffe then
    strSQL := 'DELETE FROM L2HALF_HOURLY_ENERGY WHERE '+
    ' m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) else
    if Data.m_swVMID=$ffff then
    strSQL := 'DELETE FROM L2HALF_HOURLY_ENERGY WHERE '+
    ' m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sdtDate as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''' else
    if Data.m_swVMID<$fffe then
    strSQL := 'DELETE FROM L2HALF_HOURLY_ENERGY WHERE m_swVMID= '+
    IntToStr(Data.m_swVMID) + ' AND m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sdtDate as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''';
    Result := ExecQryD1(strSQL);
End;
function CDBase.DelSlices(MonthN : integer):Boolean;
Var
    strSQL                 : String;
    FirstCMDID,LastCMDID   : Integer;
    TempDate               : TDateTime;
    i                      : integer;
Begin
    TempDate := Now;
    for i := 0 to MonthN * 31 do
      cDateTimeR.DecDate(TempDate);
    strSQL := 'DELETE FROM L2HALF_HOURLY_ENERGY WHERE '+
    ' CAST(m_sdtDate AS DATE) <= ' + '''' + DateToStr(TempDate) + '''';
    Result := ExecQryD1(strSQL);

    strSQL := 'DELETE FROM L3ARCHDATA WHERE '+
    ' ( m_swCMDID='+IntToStr(QRY_ENERGY_DAY_EP)+
    ' or m_swCMDID='+IntToStr(QRY_ENERGY_DAY_EM)+
    ' or m_swCMDID='+IntToStr(QRY_ENERGY_DAY_RP)+
    ' or m_swCMDID='+IntToStr(QRY_ENERGY_DAY_RM)+
    ' or m_swCMDID='+IntToStr(QRY_NAK_EN_DAY_EP)+
    ' or m_swCMDID='+IntToStr(QRY_NAK_EN_DAY_EM)+
    ' or m_swCMDID='+IntToStr(QRY_NAK_EN_DAY_RP)+
    ' or m_swCMDID='+IntToStr(QRY_NAK_EN_DAY_RM)+' )'+
    ' and (CAST(m_sTime AS DATE) <= ' + '''' + DateToStr(TempDate) + ''''+')';
    Result := ExecQryD1(strSQL);
    
    strSQL := 'DELETE FROM VAL WHERE CAST(data AS DATE) <= ' + '''' + DateToStr(TempDate) + '''';
    Result := ExecQryD1(strSQL);
End;

{
function UpdateGraphData(var pTable:L3GRAPHDATA):Boolean;
function IsGraphData(var pTable:L3GRAPHDATA):Boolean;
function DelGraphData(var pTable:L3GRAPHDATA):Boolean;
}
function CDBase.DelUSPDData(AdrUSPD:byte):Boolean;
var strSQL  : string;
begin
   strSQL := 'execute block as begin ' +
             'DELETE FROM SL2USPDTYPE where m_swUSPDID =' + IntToStr(AdrUSPD) + ';' +
             'delete  from sl2uspdev where m_swUSPDID =' + IntToStr(AdrUSPD) + ';' +
             'delete  from sl2uspdcharactdev where m_swUSPDID =' + IntToStr(AdrUSPD) + ';' +
             'delete  from sl2uspdcharactkanal where m_swUSPDID =' + IntToStr(AdrUSPD) + ';end';
   Result := ExecQry(strSQL);
   //CloseQry;
end;

function CDBase.AddUSPDTypeData(var pTable : SL2USPDTYPE):boolean;
var strSQL : string;
begin
   strSQL   := '';
   if not ISUSPDTypeData(pTable) then
   begin
     with pTable do
     strSQL := 'INSERT INTO SL2USPDTYPE'+
               '(M_SWUSPDID,M_SNAMEUSPD,M_SNAMEADR,M_SDWWORKNUMB,M_SWVERSPO,M_SWNUMIK,M_SWNUMGR,'
               + 'M_SWNUMTZ,M_SWMAXSUPMETNUM,M_SWNUMCONMET,M_SWMAXPACKLEN)'+
               ' VALUES('+IntToStr(m_swUSPDID)+ ',' + '''' + m_sUSPDName + '''' + ',' + '''' + m_sNameAdr + '''' +
               ',' + IntToStr(m_sdwWorkNumb) + ',' + IntToStr(m_swVersPO) + ','
                + IntToStr(m_swNumIK) + ',' + IntToStr(m_swNumGr) + ',' +  IntToStr(m_swNumTZ) + ','
                + IntToStr(m_swMaxSupMetNum) + ',' + IntToStr(m_swNumConMet) + ',' + IntToStr(m_swMaxPackLen)+')';
     Result := ExecQry(strSQL);
   end
   else
     Result := UpdateUSPDTypeData(pTable);
   //CloseQry;
end;

function CDBase.AddUSPDDev(var pTable : SL2USPDEV):Boolean;
var strSQL : string;
begin
   if not IsUSPDDev(pTable) then
   begin
     with pTable do
     strSQL := 'INSERT INTO SL2USPDEV'+
               '(m_swUSPDID, m_swBMID, m_swIDev, m_sName)'+
               ' VALUES(' + IntToStr(m_swUSPDID) + ',' + IntToStr(m_swBMID) + ',' +
               IntToStr(m_swIDev) + ',' + '''' + m_sName + '''' + ')';
     Result := ExecQry(strSQL);
   end
   else
     Result := UpdateUSPDDev(pTable);
   //CloseQry;
end;


function CDBase.AddUSPDCharDev(var pTable : SL2USPDCHARACTDEV):Boolean;
var strSQL : String;
begin
   if not IsUSPDCharDev(pTable) then
   begin
     with pTable do
     strSQL := 'INSERT INTO SL2USPDCHARACTDEV'+
               '(m_swUSPDID, m_swBMID, m_swMID, m_swNDev, m_swIDev, m_sdwWorkNumb, m_swANet, m_swNK, m_swLMax,' +
               'm_sfKt, m_sfKpr,m_swKmb, m_sdwMUmHi, m_sdwMUmLo,m_sStrAdr)'+ ' VALUES(' +
               IntToStr(m_swUSPDID) + ',' + IntToStr(m_swBMID) + ',' + IntToStr(m_swMID) + ',' + IntToStr(m_swNDev) + ','+
               IntToStr(m_swIDev) + ',' + IntToStr(m_sdwWorkNumb) + ',' + IntToStr(m_swANet) + ',' +
               IntToStr(m_swNK) + ',' + IntToStr(m_swLMax) + ',' + FloatToStr(m_sfKt) + ',' +
               FloatToStr(m_sfKpr) + ',' + IntToStr(m_swKmb) + ',' +
               '''' + IntToStr(m_sdwMUmHi)+'''' + ',' + ''''+ IntToStr(m_sdwMUmLo)+'''' + ',' +
               '''' + m_sStrAdr + '''' + ')';
     Result := ExecQry(strSQL);
   end
   else
     Result := UpdateUSPDCharDev(pTable);
   //CloseQry;
end;

function CDBase.AddUSPDCharKan(var pTable : SL2USPDCHARACTKANAL):Boolean;
var strSQL : string;
begin
   if not IsUSPDCharKan(pTable) then
   begin
     with pTable do
     strSQL := 'INSERT INTO SL2USPDCHARACTKANAL '+
               '(m_swUSPDID, m_swBMID, m_swMID, m_swNk, m_swNDev, m_swIk, m_sfKtr, m_sfKpr, m_sfKp,' +
               'm_sbyPm, m_sbyKmb, m_sNameKanal)'+ ' VALUES(' +
               IntToStr(m_swUSPDID) + ',' + IntToStr(m_swBMID) + ',' + IntToStr(m_swMID) + ',' +
               IntToStr(m_swNk) + ',' + IntToStr(m_swNDev) + ',' + IntToStr(m_swIk) +',' +
               FloatToStr(m_sfKtr) + ',' + FloatToStr(m_sfKpr) + ',' + FloatToStr(m_sfKp) + ',' +
               IntToStr(m_sbyPm) + ',' + IntToStr(m_sbyKmb)+ ',' +
               '''' + m_sNameKanal + '''' + ')';

     Result := ExecQry(strSQL);
   end
   else
     Result := UpdateUSPDCharKan(pTable);
   //CloseQry;
end;

function CDBase.IsUSPDTypeData(var pTable : SL2USPDTYPE):Boolean;
var strSQL : string;
    nCount : integer;
begin
   strSQL := 'SELECT 0 FROM SL2USPDTYPE WHERE m_swUSPDID = ' + IntToStr(pTable.m_swUSPDID);
   Result := OpenQry(strSQL, nCount);
   CloseQry;
end;

function CDBase.IsUSPDDev(var pTable : SL2USPDEV):Boolean;
var strSQL : string;
    nCount : integer;
begin
   strSQL := 'SELECT 0 FROM SL2USPDEV WHERE m_swBMID = ' + IntToStr(pTable.m_swBMID) +
              ' AND m_swUSPDID = ' + IntToStr(pTable.m_swUSPDID);
   Result := OpenQry(strSQL, nCount);
   CloseQry;
end;

function CDBase.IsUSPDCharDev(var pTable : SL2USPDCHARACTDEV):Boolean;
var strSQL : string;
    nCount : integer;
begin
   strSQL := 'SELECT 0 FROM SL2USPDCHARACTDEV WHERE m_swMID = ' + IntToStr(pTable.m_swMID) +
              ' AND m_swUSPDID = ' + IntToStr(pTable.m_swUSPDID) +
              ' and m_swBMID=' + IntToStr(pTable.m_swBMID);
   Result := OpenQry(strSQL, nCount);
   CloseQry;
end;

function CDBase.IsUSPDCharKan(var pTable : SL2USPDCHARACTKANAL):Boolean;
var strSQL : string;
    nCount : integer;
begin
   strSQL := 'SELECT 0 FROM SL2USPDCHARACTKANAL WHERE m_swNk = ' + IntToStr(pTable.m_swNk) +
              ' AND m_swUSPDID = ' + IntToStr(pTable.m_swUSPDID) +
              ' and m_swMID=' + IntToStr(pTable.m_swMID);
   Result := OpenQry(strSQL, nCount);
   CloseQry;
end;

function CDBase.UpdateUSPDTypeData(var pTable : SL2USPDTYPE):Boolean;
var strSQL : string;
begin
   with pTable do
   begin
     strSQL :=   'UPDATE SL2USPDTYPE SET M_SNAMEUSPD='+ '''' +  m_sUSPDName + '''' +
                 ' , M_SNAMEADR=' + '''' + m_sNameAdr + '''' + ' , M_SDWWORKNUMB='+
                 IntToStr(m_sdwWorkNumb) + ' , M_SWVERSPO=' + IntToStr(m_swVersPO) +
                 ' , M_SWNUMIK=' + IntToStr(m_swNumIK) + ' , M_SWNUMGR=' +
                 IntToStr(m_swNumGr) + ' , M_SWNUMTZ=' + IntToStr(m_swNumTZ) +
                 ' , M_SWMAXSUPMETNUM=' + IntToStr(m_swMaxSupMetNum) + ' , M_SWNUMCONMET=' +
                 IntToStr(m_swNumConMet) + ' , M_SWMAXPACKLEN=' + IntToStr(m_swMaxPackLen) +
                 ' WHERE m_swUSPDID = ' + IntToStr(m_swUSPDID);
   end;
   Result := ExecQry(strSQL);
   //CloseQry;
end;

function CDBase.UpdateUSPDDev(var pTable : SL2USPDEV):Boolean;
var strSQL : string;
begin
   strSQL :=  'UPDATE SL2USPDEV SET m_swIDev = ' + IntToStr(pTable.m_swUSPDID) +
              ' , m_sName=' + '''' + pTable.m_sName + '''' + ' where ' +
              'm_swBMID = ' + IntToStr(pTable.m_swBMID) +
              ' AND m_swUSPDID = ' + IntToStr(pTable.m_swUSPDID);
   Result := ExecQry(strSQL);
   //CloseQry;
end;

function CDBase.UpdateUSPDCharDev(var pTable : SL2USPDCHARACTDEV):Boolean;
var strSQL : string;
begin
   with pTable do
   begin
     strSQL := 'UPDATE SL2USPDCHARACTDEV SET m_swBMID=' + IntToStr(m_swBMID) +
               ' , m_swNDev=' + IntToStr(m_swNDev) + ' , m_swIDev = ' + IntToStr(m_swIDev) +
               ' , m_sdwWorkNumb=' + IntToStr(m_sdwWorkNumb) + ' , m_swANet=' +
               IntToStr(m_swANet) + ' , m_swNK=' + IntToStr(m_swNK) + ' , m_swLMax=' +
               IntToStr(m_swLMax) + ' , m_sfKt=' + FloatToStr(m_sfKt) + ' , m_sfKpr=' +
               FloatToStr(m_sfKpr) + ' , m_swKmb=' + IntToStr(m_swKmb) +
               ' , m_sdwMUmHi=' + '''' + IntToStr(m_sdwMUmHi)+'''' + ' , m_sdwMUmLo=' +
               ''''+ IntToStr(m_sdwMUmLo)+'''' + ' , m_sStrAdr=' + '''' + m_sStrAdr + '''' +
               ' WHERE m_swMID = ' + IntToStr(m_swMID) +
              ' AND m_swUSPDID = ' + IntToStr(m_swUSPDID) +
              ' and m_swBMID=' + IntToStr(m_swBMID);
     end;
     Result := ExecQry(strSQL);
     //CloseQry;
end;

function CDBase.UpdateUSPDCharKan(var pTable : SL2USPDCHARACTKANAL):Boolean;
var strSQL : string;
begin
   with pTable do
   begin
     strSQL := 'UPDATE SL2USPDCHARACTKANAL SET m_swBMID=' + IntToStr(m_swBMID) +
               ' , m_swNk=' + IntToStr(m_swNk) + ' , m_swNDev=' + IntToStr(m_swNDev) +
               ' , m_swIk=' + IntToStr(m_swIk) +
               ' , m_sfKtr=' + FloatToStr(m_sfKtr) + ' , m_sfKpr=' + FloatToStr(m_sfKpr) +
               ' , m_sfKp=' + FloatToStr(m_sfKp) + ' , m_sbyPm=' + IntToStr(m_sbyPm) +
               ' , m_sbyKmb=' + IntToStr(m_sbyKmb) + ' , m_sNameKanal=' + '''' + m_sNameKanal + '''' +
               ' where m_swNk = ' + IntToStr(m_swNk) +
               ' and m_swUSPDID = ' + IntToStr(m_swUSPDID) +
               ' and m_swMID=' + IntToStr(m_swMID);
   end;
   Result := ExecQry(strSQL);
   //CloseQry;
end;

function CDBase.ReadUSPDTypeData():Boolean;
begin

   Result := true;
end;

function CDBase.ReadUSPDDev():Boolean;
begin
   Result := true;
end;

function CDBase.ReadUSPDCharDev(AdrUSPD : byte;var pTable:SL2USPDCHARACTDEVLIST):Boolean;
var strSQL    : string;
    nCount, i : integer;
    res       : boolean;
begin
   strSQL := 'SELECT * FROM SL2USPDCHARACTDEV WHERE M_SWUSPDID=' +
              IntToStr(AdrUSPD) + 'ORDER BY M_SWMID';
   res := False;
   if OpenQry(strSQL,nCount)=True then
   Begin
     i := 0;
     res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
       with FADOQuery,pTable.Items[i] do  Begin
         m_swID        := i;
         m_swBMID      := FieldByName('m_swBMID').AsInteger;
         m_swNDev      := FieldByName('m_swNDev').AsInteger;
         m_swANet      := FieldByName('m_swANet').AsInteger;
         m_swNK        := FieldByName('m_swNK').AsInteger;
         m_sStrAdr     := FieldByName('m_sStrAdr').AsString;
         m_sdwWorkNumb := FieldByName('m_sdwWorkNumb').AsInteger;
         Next;
         Inc(i);
       End;
     End;
   End;
   CloseQry;
   Result := res;
end;

function CDBase.ReadUSPDCharKan(AdrUSPD, MeterID : word;var pTable :SL2USPDCHARACTKANALLIST):Boolean;
var strSQL    : string;
    nCount, i : integer;
    res       : boolean;
    //pTable1    :SL2USPDCHARACTKANALLIST;
begin
   strSQL := 'SELECT * FROM SL2USPDCHARACTKANAL WHERE M_SWUSPDID=' +
              IntToStr(AdrUSPD) + ' AND m_swMID=' + IntTOStr(MeterID)
               + ' ORDER BY m_swNK';
   res := False;
   if OpenQry(strSQL,nCount)=True then
   Begin
     i := 0;
     res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do
     Begin
       pTable.Items[i].m_swID        := i;
       pTable.Items[i].m_swNDev      := FADOQuery.FieldByName('m_swNDev').AsInteger;
       pTable.Items[i].m_sbyPM       := FADOQuery.FieldByName('m_sbyPM').AsInteger;
       pTable.Items[i].m_swNK        := FADOQuery.FieldByName('m_swNK').AsInteger;
       FADOQuery.Next;
       Inc(i);
     End;
   End;
   CloseQry;
   Result := res;
end;


function CDBase.AddMeterUSPD(var pTable:SL2TAG):Boolean;
Var
    strSQL   : String;
Begin
    //DecimalSeparator := '.';
    if IsMeterUSPD(pTable) then
    begin
      UpdateMeterUSPD(pTable);
      Result := false;
      exit;
    end;
    with pTable do
    Begin
    strSQL := 'INSERT INTO L2TAG'+
              '(m_sbyGroupID,m_swMID,m_swVMID,m_sbyType,m_sbyLocation,m_sddFabNum,'+
              'm_schPassword,m_sddPHAddres,m_schName,m_sbyPortID,'+
              'm_sbyRepMsg,m_swRepTime,m_sfKI,m_sfKU,m_sfMeterKoeff,'+
              'm_swCurrQryTm,m_sPhone,m_sbyModem,m_sbyEnable,' +
              'm_swMinNKan, m_swMaxNKan)'+
              ' VALUES('+
              IntToStr(m_sbyGroupID)+ ','+
              IntToStr(m_swMID)+ ','+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_sbyType)+ ','+
              IntToStr(m_sbyLocation)+ ','+
              ''''+m_sddFabNum +''''+','+
              ''''+m_schPassword +''''+','+
              ''''+m_sddPHAddres +''''+','+
              ''''+m_schName     +''''+','+
              IntToStr(m_sbyPortID)+ ','+
              IntToStr(m_sbyRepMsg)+ ','+
              IntToStr(m_swRepTime)+ ','+
              FloatToStr(m_sfKI)+ ','+
              FloatToStr(m_sfKU)+ ','+
              FloatToStr(m_sfMeterKoeff)+ ','+
              IntToStr(m_swCurrQryTm)+ ','+
              ''''+m_sPhone +''''+ ','+
              IntToStr(m_sbyModem)+ ',' +
              IntToStr(m_sbyEnable)+ ',' +
              IntToStr(m_swMinNKan) + ',' +
              IntToStr(m_swMaxNKan) + ')';
    End;
    Result := ExecQry(strSQL);
End;

function CDBase.IsMeterUSPD(var pTable:SL2TAG):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    //if pTable.m_sbyType <> MET_BTI then
      strSQL := 'SELECT 0 FROM L2TAG'+
      ' WHERE m_sbyPortID='+IntToStr(pTable.m_sbyPortID) + ' and m_swMID=' + IntToStr(pTable.m_swMID);
    {else
      strSQL := 'SELECT 0 FROM L2TAG'+
      ' WHERE m_sbyPortID='+IntToStr(pTable.m_sbyPortID)+' and '+'m_sddPHAddres='+''''+pTable.m_sddPHAddres+'''';}
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.DeleteBTIMeters(var PortID : integer):boolean;
var strSQL : string;
begin
    strSQL := 'delete from L2TAG WHERE m_sbyPortID='+IntToStr(PortID);
    Result := ExecQry(strSQL);
End;

function CDBase.UpdateMeterUSPD(var pTable:SL2Tag):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE L2TAG SET '+
              ' m_sbyGroupID='  +IntToStr(m_sbyGroupID)+
              ',m_swMID='       +IntToStr(m_swMID)+
              ',m_swVMID='      +IntToStr(m_swVMID)+
              ',m_sbyType='     +IntToStr(m_sbyType)+
              ',m_sbyLocation=' +IntToStr(m_sbyLocation)+
              ',m_sddFabNum='   +''''+m_sddFabNum+''''+
              ',m_schPassword=' +''''+m_schPassword+''''+
              ',m_sddPHAddres=' +''''+m_sddPHAddres+''''+
              ',m_schName='     +''''+m_schName+''''+
              ',m_sbyPortID='   +IntToStr(m_sbyPortID)+
              ',m_sbyRepMsg='   +IntToStr(m_sbyRepMsg)+
              ',m_swRepTime='   +IntToStr(m_swRepTime)+
              ',m_sfKI='        +FloatToStr(m_sfKI)+
              ',m_sfKU='        +FloatToStr(m_sfKU)+
              ',m_sfMeterKoeff='+FloatToStr(m_sfMeterKoeff)+
              ',m_swCurrQryTm=' +IntToStr(m_swCurrQryTm)+
              ',m_sPhone='      +''''+m_sPhone+''''+
              ',m_sbyModem='    +IntToStr(m_sbyModem)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ',m_swMinNKan='   +IntToStr(m_swMinNKan) +
              ',m_swMaxNKan='   +IntToStr(m_swMaxNKan) +
              ' WHERE m_sddPHAddres=' +''''+m_sddPHAddres+'''';
              //' WHERE m_sbyPortID='+IntToStr(m_sbyPortID)+' and '+'m_swMID='+IntToStr(m_swMID);
   End;
   Result := ExecQry(strSQL);
end;


function CDBase.ReadUSPDCFG(var pTable : SL2USPDTYPEEX) : boolean;
var strSQL : string;
    nCount : integer;
    res    : boolean;
    Groups : SL2TAGREPORTLIST;
begin
   res := false;
   strSQL := 'SELECT  MAX(QM_METERS.m_swtype) AS MAX_TYPE_COUNTERS,' +
             ' MAX(SL3GROUPTAG.m_swamvmeter) AS max_count_counters' +
             ' FROM qm_meters, SL3GROUPTAG';
   if OpenQry(strSQL,nCount)=True then
   begin
     with  FADOQuery do
     begin
       res := true;
       pTable.m_sUSPDName      :=  'KONUS-E';
       pTable.m_sNameAdr       :=  'Ул. Буденного, д. 11';
       pTable.m_sdwWorkNumb    := 1;
       pTable.m_swVersPO       := 1;
       pTable.m_swNumIK        := FieldByName('max_count_counters').AsInteger*4;
       pTable.m_swNumGr        := 0;
       pTable.m_swNumTZ        := 4;
       pTable.m_swMaxSupMetNum := FieldByName('MAX_TYPE_COUNTERS').AsInteger + 1;
       pTable.m_swNumConMet    := FieldByName('max_count_counters').AsInteger;
       pTable.m_swMaxPackLen   := 256;
     end;
   end;
   CloseQry;
   GetVMFromEnerg(Groups);
   pTable.m_swNumGr  := Groups.Count*4;
   Result := res;
end;

function CDBase.GetVMFromEnerg(var pTable : SL2TAGREPORTLIST) : boolean;
var strSQL    : AnsiString;
    nCount, i : integer;
    res       : boolean;
begin
   res    := false;
   strSQL := 'SELECT m_swVMID, m_sVMeterName FROM SL3VMETERTAG, SL3GROUPTAG' +
             ' WHERE m_sGroupName =' + '''' + 'Энергосбыт' + ''''+
             ' AND SL3VMETERTAG.m_sbygroupid = SL3GROUPTAG.m_sbygroupid ORDER BY m_swVMID';
   if OpenQry(strSQL,nCount)=True then
   begin
     i := 0;
     res := True;
     pTable.Count := nCount;
     SetLength(pTable.m_sMeter,nCount);
     while not FADOQuery.Eof do Begin
       with FADOQuery, pTable.m_sMeter[i] do  Begin
        m_swVMID      := FieldByName('m_swVMID').AsInteger;
        m_sVMeterName := FieldByName('m_sVMeterName').AsString;
        Next;
        Inc(i);
       End;
     End;
   end;
   CloseQry;
   Result := res;
end;

function CDBase.ReadUSPDDevCFG(var pTable : SL2USPDEVLISTEX) : boolean;
var strSQL    : string;
    nCount, i : integer;
    res       : boolean;
begin
   res    := false;
   i      := 0;
   strSQL := 'SELECT m_swType, m_sName FROM QM_Meters ORDER BY m_swType ';
   if OpenQry(strSQL, nCount) then
   begin
     res := true;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
       with FADOQuery, pTable.Items[i] do
       begin
         m_swIdev := FieldByName('m_swType').AsInteger;
         m_sName  := FieldByName('m_sName').AsString;
         Inc(i);
         Next;
       end;
   end;
   CloseQry();
   Result := res;
end;

function CDBase.ReadUSPDCharDevCFG(var pTable : SL2USPDCHARACTDEVLISTEX) : boolean;
var strSQL    : string;
    nCount, i : integer;
    res       : boolean;
begin
   res    := false;
   i      := 0;
   strSQL := 'SELECT sl3vmetertag.m_sbyType, sl3vmetertag.m_swVMID, sl3vmetertag.m_sddPHAddres,' +
             ' sl3vmetertag.m_svMeterName, l2tag.m_sfki, l2tag.m_sfku, l2tag.m_sddfabnum' +
             ' FROM sl3vmetertag, l2tag' +
             ' where l2tag.m_swmid = sl3vmetertag.m_swmid';
   if OpenQry(strSQL, nCount) then
   begin
     res := true;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
       with FADOQuery, pTable.Items[i] do
       begin
         m_swNDev      := FieldByName('m_swVMID').AsInteger;
         m_swIDev      := FieldByName('m_sbyType').AsInteger;
         try
           m_sdwWorkNumb := FieldByName('m_sddfabnum').AsInteger;
           m_swANet      := FieldByName('m_sddPHAddres').AsInteger;
         except
           m_sdwWorkNumb := 0;
           m_swANet      := 0;
         end;
         m_swNK        := 4;
         m_swLMax      := 62;
         m_sfKt        := FieldByName('m_sfki').AsFloat * FieldByName('m_sfku').AsFloat;
         m_sfKpr       := 1;
         m_sfKp        := 0;
         m_swKmb       := $0007;
         m_sdwMUmHi    := $FF003F00;
         m_sdwMUmLo    := 0;
         m_sStrAdr     := FieldByName('m_svMeterName').AsString;
         Next;
         Inc(i);
       end;
   end;
   CloseQry();
   Result := res;
end;

function CDBase.LoadReportParams(var pTable : REPORT_F1):boolean;
Var
    strSQL   : String;
    nCount   : integer;
    res      : boolean;
begin
   strSQL := 'SELECT * FROM REPORT_F1';
   if OpenQry(strSQL,nCount)=True then
   Begin
    pTable.m_swID         := FADOQuery.FieldByName('m_swID').AsInteger;
    pTable.m_sWorkName    := FADOQuery.FieldByName('m_sWorkName').AsString;
    pTable.m_sFirstSign   := FADOQuery.FieldByName('m_sFirstSign').AsString;
    pTable.m_sSecondSign  := FADOQuery.FieldByName('m_sSecondSign').AsString;
    pTable.m_sThirdSign   := FADOQuery.FieldByName('m_sThirdSign').AsString;
    pTable.m_swColorCol   := FADOQuery.FieldByName('m_swColorCol').AsInteger;
    pTable.m_swColorRow   := FADOQuery.FieldByName('m_swColorRow').AsInteger;
    pTable.m_sTelephon    := FADOQuery.FieldByName('M_STELEPHON').AsString;
    pTable.m_sEMail       := FADOQuery.FieldByName('M_SEMAIL').AsString;
    pTable.m_sNDogovor    := FADOQuery.FieldByName('m_sNDogovor').AsString;
   End;
   CloseQry;
   Result := res;
end;

function CDBase.SaveReportParams(var pTable : REPORT_F1):boolean;
Var
    strSQL   : String;
begin
   with pTable do
    Begin
       strSQL := 'UPDATE REPORT_F1 SET ' +
                 ' m_sWorkName = ' + '''' + m_sWorkName + '''' +
                 ' ,m_sFirstSign = ' + '''' + m_sFirstSign + '''' +
                 ' ,m_sSecondSign = ' + '''' + m_sSecondSign + '''' +
                 ' ,m_sThirdSign = ' + '''' + m_sThirdSign + '''' +
                 ' ,m_swColorCol = ' + IntToStr(m_swColorCol) +
                 ' ,m_swColorRow = ' + IntToStr(m_swColorRow) +
                 ' ,M_STELEPHON = ' + '''' + m_sTelephon + '''' +
                 ' ,M_SEMAIL = ' + '''' + m_sEMail + ''''+
                 ' ,m_sNDogovor = ' + '''' + m_sNDogovor + '''' +
                 ' WHERE 1=1';
    end;
    Result := ExecQry(strSQL);
end;


function CDBase.OpenQry(strSQL:String;var nCount:Integer):Boolean;
Var
    res : Boolean;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
    try
     FADOQuery.SQL.Clear;
     FADOQuery.SQL.Add(strSQL);
     FADOQuery.Open;
     if FADOQuery.RecordCount>0 then  Begin nCount := FADOQuery.RecordCount; res := True;End;
    except
     res := False;
    end;
    Result := res;
End;
function CDBase.OpenQryD(strSQL:String;var nCount:Integer):Boolean;
Var
    res : Boolean;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
    try
     FADOQueryD.SQL.Clear;
     FADOQueryD.SQL.Add(strSQL);
     FADOQueryD.Open;
     if FADOQueryD.RecordCount>0 then  Begin nCount := FADOQueryD.RecordCount; res := True;End;
    except
     res := False;
    end;
    Result := res;
End;
function CDBase.OpenQryD1(strSQL:String;var nCount:Integer):Boolean;
Var
    res : Boolean;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
    try
     FADOQueryD1.SQL.Clear;
     FADOQueryD1.SQL.Add(strSQL);
     FADOQueryD1.Open;
     if FADOQueryD1.RecordCount>0 then  Begin nCount := FADOQueryD1.RecordCount; res := True;End;
    except
     res := False;
    end;
    Result := res;
End;
function CDBase.OpenQryD2(strSQL:String;var nCount:Integer):Boolean;
Var
    res : Boolean;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
    try
     FADOQueryD2.SQL.Clear;
     FADOQueryD2.SQL.Add(strSQL);
     FADOQueryD2.Open;
     if FADOQueryD2.RecordCount>0 then  Begin nCount := FADOQueryD2.RecordCount; res := True;End;
    except
     res := False;
    end;
    Result := res;
End;
function CDBase.OpenQrySA(strSQL:String;var nCount:Integer):Boolean;
Var
    res : Boolean;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
    try
     FADOQuerySA.SQL.Clear;
     FADOQuerySA.SQL.Add(strSQL);
     FADOQuerySA.Open;
     if FADOQuerySA.RecordCount>0 then  Begin nCount := FADOQuerySA.RecordCount; res := True;End;
    except
     res := False;
    end;
    Result := res;
End;
function CDBase.OpenQryBTI(strSQL:String;var nCount:Integer):Boolean;
Var
    res : Boolean;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
    try
     FADOQueryBTI.SQL.Clear;
     FADOQueryBTI.SQL.Add(strSQL);
     FADOQueryBTI.Open;
     if FADOQueryBTI.RecordCount>0 then  Begin nCount := FADOQueryBTI.RecordCount; res := True;End;
    except
     res := False;
    end;
    Result := res;
End;
procedure CDBase.CloseQry;
Begin
    if m_blIsBackUp=True then exit;
    FADOQuery.Close;
End;
procedure CDBase.CloseQryD;
Begin
    if m_blIsBackUp=True then exit;
    FADOQueryD.Close;
End;
procedure CDBase.CloseQryD1;
Begin
    if m_blIsBackUp=True then exit;
    FADOQueryD1.Close;
End;
procedure CDBase.CloseQryD2;
Begin
    if m_blIsBackUp=True then exit;
    FADOQueryD2.Close;
End;
procedure CDBase.CloseQrySA;
Begin
    if m_blIsBackUp=True then exit;
    FADOQuerySA.Close;
End;
procedure CDBase.CloseQryBTI;
Begin
    if m_blIsBackUp=True then exit;
    FADOQueryBTI.Close;
End;
function CDBase.ExecQry(strSQL:String):Boolean;
Var
    res : Boolean;
Begin
    if m_blIsBackUp=True then exit;
    res := True;
    try
    FADOConnection.BeginTrans;
    FADOQuery.Close;
    FADOQuery.SQL.Clear;
    FADOQuery.SQL.Add(strSQL);
    FADOQuery.ExecSQL;
    FADOQuery.Close;
    FADOConnection.CommitTrans;
    sCS.Leave;
   except
    FADOConnection.RollbackTrans;
    res := False;
   end;
   Result := res;
End;
function CDBase.ExecQryD(strSQL:String):Boolean;
Var
    res : Boolean;
Begin
    if m_blIsBackUp=True then exit;
    res := True;
    try
    //sCS.Enter;
    FADOConnectionD.BeginTrans;
     FADOQueryD.Close;
     FADOQueryD.SQL.Clear;
     FADOQueryD.SQL.Add(strSQL);
     FADOQueryD.ExecSQL;
     FADOQueryD.Close;
    FADOConnectionD.CommitTrans;
    //sCS.Leave;
   except
    FADOConnectionD.RollbackTrans;
    //sCS.Leave;
    res := False;
   end;
   Result := res;
End;
function CDBase.ExecQryD1(strSQL:String):Boolean;
Var
    res : Boolean;
Begin
    if m_blIsBackUp=True then exit;
    res := True;
    try
    //sCS.Enter;
    FADOConnectionD1.BeginTrans;
     FADOQueryD1.Close;
     FADOQueryD1.SQL.Clear;
     FADOQueryD1.SQL.Add(strSQL);
     FADOQueryD1.ExecSQL;
     FADOQueryD1.Close;
    FADOConnectionD1.CommitTrans;
    //sCS.Leave;
   except
    FADOConnectionD1.RollbackTrans;
    //sCS.Leave;
    res := False;
   end;
   Result := res;
End;
function CDBase.ExecQryD2(strSQL:String):Boolean;
Var
    res : Boolean;
Begin
    if m_blIsBackUp=True then exit;
    res := True;
    try
    //sCS.Enter;
    FADOConnectionD2.BeginTrans;
     FADOQueryD2.Close;
     FADOQueryD2.SQL.Clear;
     FADOQueryD2.SQL.Add(strSQL);
     FADOQueryD2.ExecSQL;
     FADOQueryD2.Close;
    FADOConnectionD2.CommitTrans;
    //sCS.Leave;
   except
    FADOConnectionD2.RollbackTrans;
    //sCS.Leave;
    res := False;
   end;
   Result := res;
End;
function CDBase.ExecQrySA(strSQL:String):Boolean;
Var
    res : Boolean;
Begin
    if m_blIsBackUp=True then exit;
    res := True;
    try
    //sCS.Enter;
    FADOConnectionSA.BeginTrans;
     FADOQuerySA.Close;
     FADOQuerySA.SQL.Clear;
     FADOQuerySA.SQL.Add(strSQL);
     FADOQuerySA.ExecSQL;
     FADOQuerySA.Close;
    FADOConnectionSA.CommitTrans;
    //sCS.Leave;
   except
    FADOConnectionSA.RollbackTrans;
    //sCS.Leave;
    res := False;
   end;
   Result := res;
End;
function CDBase.ExecQryBTI(strSQL:String):Boolean;
Var
    res : Boolean;
Begin
    if m_blIsBackUp=True then exit;
    res := True;
    try
    //sCS.Enter;
    FADOConnectionBTI.BeginTrans;
     FADOQueryBTI.Close;
     FADOQueryBTI.SQL.Clear;
     FADOQueryBTI.SQL.Add(strSQL);
     FADOQueryBTI.ExecSQL;
     FADOQueryBTI.Close;
    FADOConnectionBTI.CommitTrans;
    //sCS.Leave;
   except
    FADOConnectionBTI.RollbackTrans;
    //sCS.Leave;
    res := False;
   end;
   Result := res;
End;




function CDBase.GetL3Table(var pTable:SL3INITTAG):Boolean;
Var
     j,i : Integer;
Begin
     //Объекты наблюдения
     pTable.m_sbyLayerID := 3;
     pTable.m_swAmGroup  := 8;
     //pTable.m_sbyBox     := BOX_L3;
     //pTable.m_sbyBoxSz   := BOX_L3_SZ;
     //pTable.m_swQsTime   := 100;
     //pTable.m_sbyQsBox   := BOX_L3_QS;
     //pTable.m_swQsBoxSz  := BOX_L3_QS_SZ;
     Result := True;
End;
function CDBase.GetL4Table(var pTable:SL4INITITAG):Boolean;
Begin
     pTable.m_sbyLayerID := 4;
     pTable.m_sbyAmArm   := 1;
     //pTable.m_sbyBox     := BOX_L4;
     //pTable.m_sbyBoxSz   := BOX_L4_SZ;
     with pTable.m_sArmModule[0] do
     Begin
      m_sbyID        := 0;
      m_swAddr       := 0;
      m_sbyArmType   := HIP_BTI;
      m_sbyPortTypeID:= DEV_COM_LOC;
      m_sbyPortID    := 1;
      m_sbyRepMsg    := 3;
      m_sbyRepTime   := 3;
     End;
     {with pTable.m_sArmModule[1] do
     Begin
      m_sbyID        := 0;
      m_swAddr       := 1;
      m_sbyArmType   := HIP_BTI;
      m_sbyPortTypeID:= DEV_COM_L2;
      m_sbyPortID    := 2;
      m_sbyRepMsg    := 3;
      m_sbyRepTime   := 3;
     End; }
     Result := True;
End;
function CDBase.GetL5Table(var pTable:SL5INITITAG):Boolean;
Begin
     Result := True;
End;

function CDBase.SetL1Table(var pTable:SL1INITITAG):Boolean;
Begin
     Result := True;
End;
function CDBase.SetL2Table(var pTable:SL2INITITAG):Boolean;
Begin
     Result := True;
End;
function CDBase.SetL3Table(var pTable:SL3INITTAG):Boolean;
Begin
     Result := True;
End;
function CDBase.SetL4Table(var pTable:SL4INITITAG):Boolean;
Begin
     Result := True;
End;
function CDBase.SetL5Table(var pTable:SL5INITITAG):Boolean;
Begin
     Result := True;
End;
//Обновление кол-ва портов
procedure CDBase.UpdateL1PortCount;
Var
byPortCount : Byte;
Begin
     with FADOQuery do Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(ID) FROM L1TAG');
      Open;
      byPortCount := FieldByName('COUNT').AsInteger;
      Close;
      SQL.Clear;
      SQL.Add('UPDATE L1INITTAG SET M_SBYAMPORTS = '+IntToStr(byPortCount));
      ExecSQL;
      Close;
    End;
End;
//Обновление кол-ва счетчиков
procedure CDBase.UpdateL2MeterCount;
Var
byMeterCount : Byte;
Begin
     with FADOQuery do Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(ID) FROM L2TAG');
      Open;
      byMeterCount := FieldByName('COUNT').AsInteger;
      Close;
      SQL.Clear;
      SQL.Add('UPDATE L2INITTAG SET M_SWAMMETER = '+IntToStr(byMeterCount));
      ExecSQL;
      Close;
    End;
End;
procedure CDBase.DEFAULT(var pTable:SL1TAG);
Begin
    {
    with pTable do Begin
     //m_sbyID       := GetL1LastPortID;
     m_sbyPortID   := 0;
     m_sbyType     := 0;
     //m_sbyReccBoxID:= 10;
     m_sbySpeed    := 0;
     m_sbyParity   := 0;
     m_sbyData     := 1;
     m_sbyStop     := 0;
     m_swDelayTime := 100;
     m_swIPPort    := 400;
     m_schIPAddr   := '192.168.15';
    End;
    }
End;
procedure CDBase.DEFAULT(var pTable:SL2TAG);
Begin
    with pTable do Begin
     //m_sbyID        := GetL2LastMeterID;
     m_swMID        := 0;
     m_sbyType      := 0;
     //m_sbyPortTypeID:= 0;
     m_sbyPortID    := 0;
     m_sbyRepMsg    := 100;
     m_sbyGroupID   := 1;
     m_swRepTime    := 100;
     //m_swCurrQryTm  := 100;
     //m_swGraphQryTm := 100;
     m_schPassword  := 'olimpiumishka';
     m_sddPHAddres  := '1111111';
     m_sfKI         := 1.2;
     m_sfKU         := 1.3;
     m_sbyEnable    := 0;
   End;
End;
//for Reports
function CDBase.ClearTable (TableName : String): Boolean;
var strSQL : String;
Begin
   strSQL := 'delete from '+ TableName;
   ExecQryR(strSQL);
   Result := True;
End;

function  CDBase.ExecQryR(strSQL:String):Boolean;
var res : Boolean;
Begin
    res := True;
    try
     sCS.Enter;
     FconReport.BeginTrans;
      FqryReport.Close;
      FqryReport.SQL.Text := strSQL;
      FqryReport.ExecSQL;
      FqryReport.Close;
     FconReport.CommitTrans;
    except
     FconReport.RollbackTrans;
     res := False;
    end;
    Result := res;

End;

function  CDBase.OpenQryR(strSQL:String;var nCount:Integer):Boolean;
Var
    res : Boolean;
begin
    res    := False;
    nCount := 0;
   // FconReport.BeginTrans;
    try
     FqryReport.SQL.Clear;
     FqryReport.SQL.Add(strSQL);
     FqryReport.Open;
     if FqryReport.RecordCount>0 then Begin
        nCount := FqryReport.RecordCount;
        res := True;
        End;
    except
    begin
     res := False;
    // FconReport.RollbackTrans;
     end;
    end;
   // FconReport.CommitTrans;
    Result := res;
End;

function  CDBase.EvalTar(tTimeON,tTimeOFF : TDateTime) : Real;
Begin
Result := 1.23;
End;

function  CDBase.SetReport(dDate : TDateTime; RepType : Integer) : Boolean;
Begin
Result := True;
End;

function  CDBase.CreateRepF1(RCNFG :RepCONFIG) : Boolean;
var pTbl   : TM_TARIFFS;
Begin
  ClearTable('report_f1');
  SetSumEnergy(RCNFG);
  SetL2HHEnergy(RCNFG);
  Result := True;
End;

function  CDBase.CreateRepF2(RCNFG :RepCONFIG) : Boolean;
Begin
Result := True;
End;

function  CDBase.CreateRepF3(RCNFG :RepCONFIG) : Boolean;
Begin
Result := True;
End;

function  CDBase.CreateRepF4(RCNFG :RepCONFIG) : Boolean;
Begin
Result := True;
End;

function  CDBase.CreateRepF5(RCNFG :RepCONFIG) : Boolean;
Begin
Result := True;
End;

function  CDBase.CreateQryF1() : Boolean;
Begin
Result := True;
End;
///
function  CDBase.SetSumEnergy(RCNFG : RepCONFIG) : Boolean;
var strSQL_ON,strSQL_SELECT,strSQL_MATCHED,strSQL_N_MATCHED : String;
Begin
   strSQL_SELECT := ' SELECT  m_swvmid,m_swcmdid,m_swtid,m_sfvalue' +
                    ' FROM l3archdata'+
                    ' WHERE EXTRACT(YEAR FROM m_stime) =' + IntToStr(RCNFG.Year) +
                         ' AND EXTRACT(MONTH FROM m_stime) =' + IntToStr(RCNFG.Month) +
                         ' AND m_swcmdid BETWEEN 21 AND 24 ' +
                         ' AND m_swtid = 0';
   strSQL_ON :=  ' t1.pnts_name  = t2.m_swvmid    AND' +
                 ' t1.val_type   = t2.m_swcmdid   AND' +
                 ' t1.tar_name   = t2.m_swtid';
   strSQL_MATCHED := ' UPDATE SET t1.prev_val  = t2.m_sfvalue';
   strSQL_N_MATCHED := ' INSERT (t1.pnts_name, t1.val_type, t1.tar_name , t1.prev_val)' +
                       ' VALUES (t2.m_swvmid, t2.m_swcmdid, t2.m_swtid,  t2.m_sfvalue)';
   DoMerge('report_f1',strSQL_SELECT,strSQL_ON,strSQL_MATCHED,strSQL_N_MATCHED);
   strSQL_SELECT := ' SELECT  m_swvmid,m_swcmdid,m_swtid,m_sfvalue' +
                    ' FROM l3archdata'+
                    ' WHERE EXTRACT(YEAR FROM m_stime) =' + IntToStr(RCNFG.Year2) +
                         ' AND EXTRACT(MONTH FROM m_stime) =' + IntToStr(RCNFG.Month2) +
                         ' AND m_swcmdid BETWEEN 21 AND 24 ' +
                         ' AND m_swtid = 0';
   strSQL_MATCHED := ' UPDATE SET t1.new_val  = t2.m_sfvalue';
   strSQL_N_MATCHED := ' INSERT (t1.pnts_name, t1.val_type, t1.tar_name , t1.new_val)' +
                       ' VALUES (t2.m_swvmid, t2.m_swcmdid, t2.m_swtid,  t2.m_sfvalue)';
   DoMerge('report_f1',strSQL_SELECT,strSQL_ON,strSQL_MATCHED,strSQL_N_MATCHED);
   Result := True;
End;


function  CDBase.SetL2HHEnergy(RCNFG : RepCONFIG) : Boolean;
var h0,m0,s0,ms0,
    h1,m1,s1,ms1,
    i, zoneIndex, tarIndex, res0,res1,
    tarON,tarOFF,fieldID : Word;
    pTable : TM_TARIFFSS;
    TarifTable : TM_TARIFFS;
    strTarFilter,strSQL_SELECT,strSQL_ON,strSQL_MATCHED,strSQL_N_MATCHED :  String;
Begin
    GetTMTarifsTable(pTable);
    for zoneIndex := 0 to pTable.Count-1 do begin
       with pTable do begin
          GetTMTarPeriodsTable(Items[zoneIndex].m_swTTID,TarifTable);
          for tarIndex := 1 to TarifTable.Count-1 do begin
             DecodeTime(TarifTable.Items[tarIndex].m_dtTime0,h0,m0,s0,ms0);
             DecodeTime(TarifTable.Items[tarIndex].m_dtTime1,h1,m1,s1,ms1);
             tarON  := (h0*60 + m0) div 30;
             tarOFF := (h1*60 + m1) div 30;
             for fieldID := tarON to tarOFF-1 do begin
                strTarFilter :=  strTarFilter +'sum(V' + IntToStr(fieldID) + ')+'  ;
             end;
             //месяц за который потребовали отчет
             strTarFilter  :=  strTarFilter + 'sum(V' + IntToStr(tarOFF) + ')' + ' as T';
             strSQL_SELECT :=  ' select m_swvmid, m_swcmdid, ' + strTarFilter + ' from l2half_hourly_energy' +
                               ' where extract (month from m_sdtdate) =' + IntToStr(RCNFG.Month) +
                               ' and extract (year from m_sdtdate) ='   + IntToStr(RCNFG.Year) +
                               ' group by m_swvmid, m_swcmdid';
             strSQL_ON :=  ' t1.pnts_name = t2.m_swvmid  and' +
                           ' t1.val_type  = t2.m_swcmdid + 8 and' +
                           ' t1.tar_name  = ' + IntToStr(tarIndex);
             strSQL_MATCHED :=  'update set t1.prev_val = t2.T';
             strSQL_N_MATCHED   := ' INSERT (t1.pnts_name, t1.val_type, t1.tar_name, t1.prev_val)' +
                                   ' VALUES(t2.m_swvmid,t2.m_swcmdid + 8,'+IntToStr(tarIndex)+',t2.T)';
             DoMerge('REPORT_F1',strSQL_SELECT,strSQL_ON,strSQL_MATCHED,strSQL_N_MATCHED);
             //месяц+1 за который потребовали отчет
             strSQL_SELECT :=  ' select m_swvmid, m_swcmdid, ' + strTarFilter + ' from l2half_hourly_energy' +
                               ' where extract (month from m_sdtdate) =' + IntToStr(RCNFG.Month2) +
                               ' and extract (year from m_sdtdate) ='   + IntToStr(RCNFG.Year2) +
                               ' group by m_swvmid, m_swcmdid';
             strSQL_ON :=  ' t1.pnts_name = t2.m_swvmid  and' +
                           ' t1.val_type  = t2.m_swcmdid + 8 and' +
                           ' t1.tar_name  = ' + IntToStr(tarIndex);
             strSQL_MATCHED  :=  'update set t1.new_val = t2.T';
             strSQL_N_MATCHED   := ' INSERT (t1.pnts_name, t1.val_type, t1.tar_name, t1.new_val)' +
                                   ' VALUES(t2.m_swvmid,t2.m_swcmdid + 8,'+IntToStr(tarIndex)+',t2.T)';
             DoMerge('REPORT_F1',strSQL_SELECT,strSQL_ON,strSQL_MATCHED,strSQL_N_MATCHED);
             strTarFilter := '';
             strSQL_N_MATCHED  := '';
          end;
       end;
    end;
end;

procedure  CDBase.DoMerge(strTblName : String; var strSQL_SELECT,strSQL_ON,strSQL_MATCHED,strSQL_N_MATCHED: String);
var strExSQL : String;
begin
strExSQL := ' MERGE INTO '+ strTblName +' AS t1' +
            ' USING (' +strSQL_SELECT +') AS t2' +
            ' ON (' +strSQL_ON +')' +
            ' WHEN MATCHED THEN ' + strSQL_MATCHED +
            ' WHEN NOT MATCHED THEN ' + strSQL_N_MATCHED;
ExecQryR(strExSQL);
end;

procedure CDBase.GetSummaryF1(var Tbl : SUMMARY_F1);
var strSQL : String;
i : Integer;
begin
   i := 1;
strSQL := ' SELECT VAL_TYPE,'+
                 ' TAR_NAME,'+
                 ' sum((NEW_VAL - PREV_VAL)*l2tag.m_sfki*l2tag.m_sfku) as Val'+
          ' FROM report_f1 inner join l2tag on l2tag.m_swmid = report_f1.pnts_name'+
          ' group BY VAL_TYPE, TAR_NAME';
   OpenQryR(strSQL,Tbl.m_sbyCount);
   with FqryReport do
      while not Eof do Begin
         Tbl.Item[i].m_sEnergyType := FieldByName('Val_Type').asInteger;
         Tbl.Item[i].m_sTarType    := FieldByName('Tar_Name').asInteger;
         Tbl.Item[i].m_sfValue     := FieldByName('Val').AsFloat;
         Inc(i);
         Next;
      end;
end;
{
GetGData
GetGraphDatas
GetCurrentData
GetTariffData
}
function CDBase.GetGDataBTI(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
     if TID = 0 then
       strSQL := 'SELECT m_sTime,m_sfValue,m_swTID'+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime'
     else
       strSQL := 'SELECT m_sTime,m_sfValue,m_swTID'+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 'm_swTID='+IntToStr(TID)+ ' and ' +
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime';
    res := False;
    if OpenQryBTI(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryBTI.Eof do Begin
     with FADOQueryBTI,pTable.Items[i] do  Begin
      m_swID       := i;
      m_swTID      := FieldByName('m_swTID').AsInteger;
      m_sTime      := FieldByName('m_sTime').AsDateTime;
      m_sfValue    := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryBTI;
    Result := res;
End;
function CDBase.GetGraphDatasBTI(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin
     strSQL := 'SELECT *' +
     ' FROM L2HALF_HOURLY_ENERGY'+
     ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and'+
     ' CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sdtDate';
    res := False;
    if OpenQryBTI(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryBTI.Eof do Begin
     with FADOQueryBTI,pTable.Items[i] do  Begin
      m_swID       := i;
      //m_sdtLastTime  := FieldByName('m_sdtLastTime').AsDateTime;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      for j:=0 to 47 do v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryBTI;
    Result := res;
End;
function CDBase.GetCurrentDataBTI(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT *'+
    ' FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(FIndex)+
    ' and m_swCMDID='+IntToStr(FCmdIndex);
    res := False;
    if OpenQryBTI(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryBTI.Eof do Begin
     with FADOQueryBTI,pTable.Items[i] do  Begin
      m_swID    := i;
      m_swVMID  := FieldByName('m_swVMID').AsInteger;
      m_swTID   := FieldByName('m_swTID').AsInteger;
      m_swCMDID := FieldByName('m_swCMDID').AsInteger;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      m_sfValue := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryBTI;
    Result := res;
End;
function CDBase.GetTariffDataBTI(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT *'+
    ' FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(FIndex)+
    ' and m_swCMDID='+IntToStr(FCmdIndex)+' and m_swTID<>0 ORDER BY m_swTID';
    res := False;
    if OpenQryBTI(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryBTI.Eof do Begin
     with FADOQueryBTI,pTable.Items[i] do  Begin
      m_swID    := i;
      m_swVMID  := FieldByName('m_swVMID').AsInteger;
      m_swTID   := FieldByName('m_swTID').AsInteger;
      m_swCMDID := FieldByName('m_swCMDID').AsInteger;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      m_sfValue := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryBTI;
    Result := res;
End;
end.
