unit utldatabase;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlconst,
    inifiles,Db,ADODB, Dates,utlbox, utlTimeDate,utldynconnect,
    dbtables,knsl3EventBox, Math,IBDataBase,IBQuery, Controls, Forms, Dialogs,
    fLogTypeCommand, treelist, AdvProgr, XLSWorkbook,checklst, utlSendRecive;
type
    PCDBDynamicConn = ^CDBDynamicConn;
    TZoneHand = function (dtDate:TDateTime;nPlane,nSZone,nTDay,nZone:Integer):Dword of object;
    CDBase = class
     m_strProvider  : String;
     m_strProvider_0: String;
     m_strFileName  : String;
     m_strSvCString : String;
     m_nSvConnLevel : Integer;
     m_nDynCount    : Integer;
     m_blDynConn    : array[0..MAX_DYNCONN] of Boolean;
     EventFlagCorrector : integer;
     m_blIsConnect  : Boolean;
    public
     {MySQL}
     constructor Create;
     destructor Destroy; override;
     function GetNodeToExcel(Id, level:Integer; var WB:TSheet; var sNode : string):Boolean;
     function GetNodeToQueryGrop(Id, level:Integer; var List : TList):Boolean;
     function SetGroupRefresh(GID,STATE:Integer;_Date:TDateTime):Boolean; //Обновление состояния группы (0-опрос завершен, 1- опрос, 2-ожидание опроса(руч), 3-ожидание опроса(авт))
     function GetPulls_L1(IP,IPPORT,DESCRIPTION:String; Check:Integer;var ID:Integer):Integer;
     function GetPathNameByID(IdRes:Integer; var sName:String):Boolean;
     function GetQueryGroups(groupID:Integer; var pTable:TThreadList):Boolean;
     function addQueryGroup(pTable:QueryGroup):Integer;
     function delQueryGroup(groupID:Integer):Boolean;
     function delQueryGroupParams(groupID:Integer):Boolean;
     function setQueryGroupAbonsState(groupID,aboid,state:Integer):Boolean;
     function setQueryGroupAbonsStateProg(groupID,aboid,state:Integer):Boolean;
     function setQueryState(aid,mid,qState:Integer):Boolean;
     function delQueryGroupAbons(groupID,aboid:Integer):Boolean;
     function SetQueryGroupAbonsNoGSM(aboid:Integer):Boolean;
     function GetQueryGroupAbons(groupID,aboid:Integer; var str:string):Boolean;
     function SetQueryGroupAbons(AbonID: integer;str:string):Boolean;
     function GetEnable(gGroup:integer;var pTable:TThreadList):Boolean;
     function GetAbonGroup(gGroup:integer;var pTable:TThreadList):Boolean;
     function setQueryQroupState(id:Integer;state:Integer):Integer;
     function getQueryGroupsParam(groupID,paramID:Integer; var pTable:TThreadList):Boolean;
     function GetQueryAbons(groupID:Integer; var pTable:TThreadList):Boolean;
     function addQueryGroupParam(pTable:QGPARAM):Integer;
     function updateGQParams(groupID,qgParamID:Integer;field:String):Integer;
     function addQueryGroupAbon(pTable:QGABONS):Integer;
     function addQueryGroupAbonReject(pTable:QGABONS):Integer;
     function GroupIdToName(groupID:Integer):string;
     function InitMySQL(strDSN : String) : Boolean; // инициализация подключения строкой DSN
     function getConnection:CDBDynamicConn;
     procedure DiscDynConnect(var pDD:CDBDynamicConn);
     function ConnectMySQL:Boolean; // подключение к MySQL
     function DisconnectMySQL:Boolean;  // отключение от MySQL
     function OpenQryMy(strSQL:String;var nCount:Integer):Boolean;
     function OpenQryM2F(strSQL:String;var nCount:Integer):Boolean;
     procedure CloseQryM2F;
     function OpenQryMySQL(strSQL:String;var nCount:Integer):Boolean;
     procedure CloseQryMySQL;
     function UpdateTextField(PID:integer;strText:String):boolean;
     function UpdateTextFieldAID(AID:integer;strText:String):boolean;
     function MyDeleteABON(abon : Integer): Boolean;
     function MyDeleteTUCH(abon, tuch : Integer): Boolean;
     function SetTuchTable(_AboID, _Tuch : Integer; _ZNom,_Name : String; _KTR : Integer):Boolean;
     function MyAddTUCH(_AboID, _Tuch : Integer; _ZNom,_Name : String; _KTR : Integer): Integer;
     function MyDeleteValues(ds, de : TDateTime; abon, tuch : Integer) : Boolean;
     function MyGetAbonVMetersTable(nAbon,nChannel:Integer;var pTable:SL3MYGROUPTAG):Boolean;

     function GetExtParam(QGID : Integer; var LB:TCheckListBox):Boolean;
     function SetExtParam(QGID : Integer; var LB:TCheckListBox):Boolean;
     function MySQLStat(var res : TStringList) : Boolean; // состояние сервера MySQL
     function MyPing(var d : TDateTime) : Boolean;
     function MyInsertABO(_AboID : Integer; _Name,_KSP,_DogNum : String): Integer;
     function MyInsertTUCH(_AboID, _Tuch : Integer; _ZNom,_Name : String; _KTR : Integer): Integer;
     function IsTuchTable(_AboID, _Tuch : Integer):Boolean;
     function GetGraphDataValidity(dt : TDateTime; VMID, ET : Integer; var _Mask:int64) : Boolean;
     function GetGraphDatasMyExport(dtP0,dtP1:TDateTime;VMID:Integer;var pTable:L3GRAPHDATASMY):Boolean;
     function GetBytDatasMyExport(nDIndex,nABOID:Integer;dtP0,dtP1:TDateTime;var pTable:asbyt_enrgs):Boolean;
     function GetTplMyExport(nABOID:Integer;dtP0:TDateTime;var pTable:L3DATASAVT_EXPS):Boolean;
     function ChandgrMarchNumber(nABOID,nPID:Integer;strKSP,strMNumber,strOldMN:String):Boolean;
     function ChandgeKSPNumber(nABOID,nPID:Integer;strKSP,strOldKSP:String):Boolean;
     function ChandgeKVName(nABOID,nPID:Integer;strKV:String):Boolean;
     function GetArchDataMyExport(dt:TDateTime;VMID:Integer; var pTable:L3ARCHDATASMY):Boolean;
     function GetArchTplMyExport(dt:TDateTime;VMID:Integer; var pTable:L3ARCHDATASMY):Boolean;
     function GetConfDataMyExport(_VMID : Integer; var pTable:L3DATASAVT_EXP):Boolean;

     function SetEnTransTime(sTransTime:Byte):Boolean;     
     function MyPrepareMultiExec(): Integer;
     function MyMultiExec(): Integer;
     function MyMakeInsertBUF_V_INT(nAbon,nTuch, _CMDID : Integer; _sdtDate : TDateTime; it : INteger; val, _valDS, val1 : Double): Integer;
     function MyMakeDeleteBUF_V_FAIL(nAbon,nTuch, _CMDID : Integer; _sdtDate : TDateTime; it : INteger): Integer;
     function MyMakeInsertAVT_EXP(_Table : L3DATASAVT_EXP): Integer;

     function MyMakeDeleteBYT(ds,de:TDateTime):Integer;
     function MyMakeDeleteBYT_Ex(ds,de:TDateTime;strDom,strKorp,strStrt:String):Integer;
     function MyMakeInsertBYT(var pTbl:asbyt_enrg):Integer;

//     function MyInsertBUF_V_INT(nAbon,nTuch, _CMDID : Integer; _sdtDate : TDateTime; it : INteger; val, _valDS, val1 : Double): Integer;
     function MyGetInvalidData(var pTable:L3VALIDATASMY):Boolean;
     function SetMyGenSettTable(var pTable:SGENSETTTAG):Boolean;
     function SetMySqlConfTable(var pTable:SGENSETTTAG):Boolean;
     function MyGetHalfHours(var pTable:L3VALIDATAMY):Boolean;

     { DBF }
     function SaveDBFSettTable(var pTable:SGENSETTTAG):Boolean;
     function GetArchDataDBFExport(dt:TDateTime;VMID:Integer; var pTable:L3ARCHDATASMY):Boolean;
     function GetAtomArchDataDBFExport(_dt:TDateTime; _VMID:Integer; _tar, _CMD : WORD; var pTable:L3ARCHDATAMY):Boolean;


     function GetVectorsTable(_dt : TDateTime; VMID : WORD; var _Table : SL3Vectors): Boolean;
     function GetVectorsTable_48(_dt : TDateTime; VMID : WORD; var _Table : SL3Vectors_48): Boolean;
//     function IsCoverOpen : boolean;
     function GetFirstObjFromPort(PortID:integer):integer;
     function IsMonitorTag(var pTable:SMONITORDATA):Boolean;
     function AddMonTable(var pTable:SMONITORDATA):Boolean;
     function SetMonTable(var pTable:SMONITORDATA):Boolean;


     function GetQweryFullSRVTable(snAID,snSRVID,snCLID:Integer;var pTable:SQWERYSRVS):Boolean;
     function GetQwerySRVTable(snAID,snSRVID:Integer;var pTable:SQWERYSRVS):Boolean;
     function IsQwerySRVTable(var pTable:SQWERYSRV):Boolean;
     function SetQwerySRVTable(var pTable:SQWERYSRV):Boolean;
     function AddQwerySRVTable(var pTable:SQWERYSRV):Boolean;
     function SetSrvParam(snAID,snSRVID:Integer;str:String):Boolean;
     function DelQwerySRVTable(snAID,snSRVID:Integer):Boolean;

     function GetEntasJoin(nMID:Integer;var pTable:SQWERYVMS):Boolean;
     function GetQweryVMTable(snSRVID,snCLID:Integer;var pTable:SQWERYVMS):Boolean;
     function GetQweryVM(snSRVID,snCLID:Integer;var pTable:SQWERYVM):Boolean;
     function IsQweryVMTable(var pTable:SQWERYVM):Boolean;
     function SetQweryVMTable(var pTable:SQWERYVM):Boolean;
     function AddQweryVMTable(var pTable:SQWERYVM):Boolean;
     function DelQweryVMTable(snSRVID,snCLID:Integer):Boolean;

     function GetQweryMDLTable(snCLID:Integer;var pTable:SQWERYMDLS):Boolean;
     function GetQweryMDLOneTable(snCLID,snCLSID:Integer;var pTable:SQWERYMDLS):Boolean;
     function GetQweryMaskMDLTable(sVMID:Integer;sSRVID:String;var pTable:SQWERYMDLS):Boolean;
     function GetCluster(snCLID,snCLSID:Integer):String;
     function IsQweryMDLTable(var pTable:SQWERYMDL):Boolean;
     function SetQweryMDLTable(var pTable:SQWERYMDL):Boolean;
     function SetQweryMDLTableEx(var pTable:SQWERYMDL):Boolean;
     function SetMdlParam(snAID,snSRVID,snCLID,snCLSID:Integer;str:String):Boolean;
     function SetMdlParamEx(snAID,snSRVID,snCLID,snCLSID:Integer;str:String):Boolean;
     function AddQweryMDLTable(var pTable:SQWERYMDL):Boolean;
     function AddMDLTable(var pTable:SQWERYMDL):Boolean;
     function DelQweryMDLVMIDTable(nCLID:Integer):Boolean;
     function DelQweryMDLCMDIDTable(nSRVID,nCLID:Integer;snCLSID:Integer):Boolean;
     function GetQweryStruct(sVMID,sFilter:String;var pTable:SQWERYMDLCOMMS):Boolean;

     function GetSchemsTable(var pTable: SL3SCHEMTABLES):boolean;
     function UpdateSchemTable(ID : integer; var pTable : SL3SCHEMTABLE):boolean;
     function DeleteSchemTable(ID : integer):boolean;
     function AddSchemTable(var pTable : SL3SCHEMTABLE):boolean;
     function GetCurrentDataForSchems(var CMDIDStr, VMIDStr : String;var pTable:L3CURRENTDATAS):Boolean;
     function GetFormulaForVMID(VMID : integer):string;
     function LoadTID(ParamID : word) : word;
     //procedure CopyCommandsToQwery(var pTable: SQWERYMDLSEx);


     //procedure Init(strFileName:String);
     function  Init(strFileName,strExePath:String):Boolean;
     procedure WriteReStartEvent(strFileName:String);
     function GetConnString(str:String):String;

     function FullDisconnect:Boolean;
     //function  GetLocalConnString
     procedure SaveConnection;
     function IsConnectDB:Boolean;
     function Connect:Boolean;
     function Disconnect:Boolean;
     function StartProcess(strPath:String;blWait:Boolean):Boolean;
     procedure ReBootPrg;
     function LightConnect(str:String):Boolean;
     function FullConnect(str:String):Boolean;
     function SFullConnect(str:String):Boolean;
     function SaveParam(wMetID:Word;tTime:TDateTime;byParamType:Byte;pbyData:PByte):Boolean;
     function ReadParam(wMetID:Word;tTime:TDateTime;byParamType:Byte;pbyData:PByte):Boolean;

     function GetSL2PULLDS(var pTable:SL2PULLDSS):Boolean;
     function addSL2PULLDS(pTable:SL2PULLDS):Integer;
     function delSL2PULLDS(id:Integer):Boolean;
     function addSL2PULL(pTable:SL2PULL):Integer;
     function delSL2PULL(idpk,idfk:Integer):Boolean;
     function GetSL2PULL(pullID:Integer; var pTable:SL2PULLS):Boolean;

     function GetL1Table(var pTable:SL1INITITAG):Boolean;
     function GetL1TableIndex(var pTable:SL1INITITAG;Index:Integer):Boolean;
     function GetCtrConnTable(var pTable:SL1INITITAG):Boolean;
     function IsPort(var pTable:SL1TAG):Boolean;
     function isL2Init(nPortID : Integer):Boolean;
     function setL2Init(nPortID,value : Integer):Boolean;

     function GetPortTable(var pTable:SL1TAG):Boolean;
     function SetPortTable(var pTable:SL1TAG):Boolean;
     function AddPortTable(var pTable:SL1TAG):Boolean;
     function DelPortTable(nIndex:Integer):Boolean;

     function GetMetersTableLC(nChannel,nLocation:Integer;var pTable:SL2INITITAG):Boolean;
     function GetMetersTable(nChannel:Integer;var pTable:SL2INITITAG):Boolean;
     function GetMetersIniTable(var pTable:SL2INITITAG):Boolean;
     function GetMeterLocation(FMID:Integer;var FLocation,PHAddres:Integer):Boolean;
     function GetMeterType(FVMID:Integer;var nTypeID,swPLID:Integer):Boolean;
     function GetMeterPortID(FMID:Integer;var sbyPortID:Integer):Boolean;
     function IsMeter(var pTable:SL2TAG):Boolean;
     function GetMeterTable(var pTable:SL2TAG):Boolean;
     function GetMMeterTable(nIndex:Integer;var pTable:SL2TAG):Boolean;
     function GetMeterTableForReport(GroupID : integer;var pTable : SL2TAGREPORTLIST) : boolean;
     function SetMeterTable(var pTable:SL2TAG):Boolean;
     function SetTimeLimit(nMID:Integer;m_sdtSumKor,m_sdtLimKor,m_sdtPhLimKor:TDateTime):Boolean;
     function SetMeterType(nAID,nPID:Integer;nType:Byte):Boolean;
     function SetSynchroChnl(nMID:Integer;bySynchro:Byte):Boolean;
     function SetL2TAG_FN_AD_KI_KU(swMID:Integer;sddFabNum,sddPHAddres:String;sfKI,sfKU:Double):Boolean;
     function AddMeterTable(var pTable:SL2TAG):Boolean;
     function AddMConfig(pTable:CLoadEntity):Boolean;
     function getMConfig(offs,sz:Integer;var pTable:TList):Boolean;
     function DelMeterTable(nMasterIndex,nIndex:Integer):Boolean;
     function Exclude_VMeter(nMID,nVMID:integer):Boolean; //исключение из опроса
     function Include_VMeter(nMID,nVMID:integer):Boolean; //включение счетчика в опрос
     function AutoBlock_VMeter(nVMID:integer):Boolean;
     function AutoUnBlock_VMeter(nVMID:integer):Boolean;
     function CheckValidMeters(strMeters:String):Boolean;
     function Exclude_Abon(nAID:Integer):Boolean;
     function Include_Abon(nAID:Integer):Boolean;
     function UpdateTimeKorr(MID : integer; TimeKorr : TDateTime):boolean;
     function SaveNakEnMonth(MID,CMDID,TID : integer; Date:TDateTime; Value :Double):boolean;
     function UpdateBlStateMeter(MID, BlState : integer):boolean;

     function GetCommandsTable(nChannel:Integer;var pTable:CCOMMANDs):Boolean;
     function GetCommandsFTable(nChannel:Integer;sFilter:String;var pTable:CCOMMANDS):Boolean;
     function GetCmdMidTbl(sCMDID:Integer;var strMID:String):Boolean;
     function GetCommandsTableOBS(nChannel:Integer;var pTable:CCOMMANDS):Boolean;
     function GetCommandsTableCTRL(nChannel:Integer;var pTable:CTRLCOMMANDS):Boolean;
     function GetCommandTable(var pTable:CCOMMAND):Boolean;
     function SetCommandTable(var pTable:CCOMMAND):Boolean;
     function OpenCommand(cmdID,byEnable:Integer):Boolean;
     function OpenPortCommand(nPortID,cmdID,byEnable:Integer):Boolean;
     function OpenPortCommandStr(strCMD:String;cmdID,nPortID:Integer):Boolean;
     function AddCommandTable(var pTable:CCOMMAND):Boolean;
     function DelCommandTable(nIndex:Integer;nCmdIndex:Integer):Boolean;
     function InsertCommand(nIndex,nMeterType:Integer):Boolean;
     function InsertCommandUSPD164Profile(nIndex,IndexKV:Integer):Boolean;
     function InsertCommandUSPD164v4Profile(nIndex,IndexKV:Integer):Boolean;
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
     function GetMeterPort(FMID:Integer;var FPortType,FPortID:Byte):Boolean;
     function GetDistTag(FMID:Integer):String;



     function GetQMCmdDirTable(nType,nMID:Integer;var pTable:QM_COMMANDS):Boolean;
     function GetQMCommandsTable(nIndex:Integer;var pTable:QM_COMMANDS):Boolean;
     function IsCommandInQMTable(nIndex:Integer):Byte;
     function GetQMCommandTable(var pTable:QM_COMMAND):Boolean;
     function SetQMCommandTable(var pTable:QM_COMMAND):Boolean;
     function AddQMCommandTable(var pTable:QM_COMMAND):Boolean;
     function DelQMCommandTable(nIndex:Integer;nCmdIndex:Integer):Boolean;


     function GetTPlanesTable(var pTable:TM_PLANES):Boolean;
     function IsTPlaneTable(var pTable:TM_PLANE):Boolean;
     function SetTPlaneTable(var pTable:TM_PLANE):Boolean;
     function AddTPlaneTable(var pTable:TM_PLANE):Boolean;
     function DelTPlaneTable(nIndex:Integer):Boolean;

     function GetTMTarifsTable(swPLID,swSZNID,swTDayID:Integer;var pTable:TM_TARIFFSS):Boolean;
     function GetTMTarifsTableEx(swPLID,swSZNID,swTDayID:Integer;var pTable:TM_TARIFFSS):Boolean;
     function IsTMTarifTable(var pTable:TM_TARIFFS):Boolean;
     function SetTMTarifTable(var pTable:TM_TARIFFS):Boolean;
     function AddTMTarifTable(var pTable:TM_TARIFFS):Boolean;
     function DelTMTarifTable(swPLID,swSZNID,swTDayID,nIndex:Integer):Boolean;

     function GetTMTarPeriodsTable(VMID,nIndex:Integer;var pTable:TM_TARIFFS):Boolean;
     function GetTMTarPeriodsCmdTable(dtDate:TDateTime;nVMID,nCMDID,nTSHift:Integer;var pTable:TM_TARIFFS):Boolean;
     function GetRealTMTarPeriodsPlaneTable(dtDate:TDateTime;nVMID,nCMDID:Integer;var pTable:TM_TARIFFS):Integer;
     function IsTMTarPeriodTable(var pTable:TM_TARIFF):Boolean;
     function SetTMTarPeriodTable(var pTable:TM_TARIFF):Boolean;
     function AddTMTarPeriodTable(var pTable:TM_TARIFF):Boolean;
     function DelTMTarPeriodTable(nIndex:Integer;nCmdIndex:Integer):Boolean;

     function GetSZTarifsTable(var pTable:TM_SZNTARIFFS):Boolean;
     function GetSZFullTarifsTable(var pTable:TM_SZNTARIFFS):Boolean;
     function IsSZTarifTable(var pTable:TM_SZNTARIFF):Boolean;
     function SetSZTarifTable(var pTable:TM_SZNTARIFF):Boolean;
     function AddSZTarifTable(var pTable:TM_SZNTARIFF):Boolean;
     function DelSZTarifTable(nIndex:Integer):Boolean;

     function GetSZDayTable(swSZNID:Integer;var pTable:TM_SZNDAYS):Boolean;
     function IsSZDayTable(var pTable:TM_SZNDAY):Boolean;
     function SetSZDayTable(var pTable:TM_SZNDAY):Boolean;
     function AddSZDayTable(var pTable:TM_SZNDAY):Boolean;
     function DelSZDayTable(swSZNID,swMntID,swDayID:Integer):Boolean;

     function GetGroupsTable(var pTable:SL3INITTAG):Boolean;
     function GetGroupsAbonTable(nABOID:Integer;var pTable:SL3INITTAG1):Boolean;
     function GetMSGROUPEXPRESS(nAbon,nChannel:Integer;var pTable:SL3GROUPTAG):string;
     function GetGroupExpress(nChannel:Integer):string;
     function GetVMIDExpress(nChannel,nCMDID:Integer):string;
     function GetGroupTbl(var pTable:SL3GROUPTAG):Boolean;
     function GetGroupTable(var pTable:SL3GROUPTAG):Boolean;
     function SetGroupTable(var pTable:SL3GROUPTAG):Boolean;
     function AddGroupTable(var pTable:SL3GROUPTAG):Boolean;
     function DelGroupTable(nAbon,nIndex:Integer):Boolean;

     function GetRegionsTable(var pTable:SL3REGIONS):Boolean;overload;
     function GetRegionsTable(nIndex:Integer; var pTable:SL3REGIONS):Boolean;overload;
     function GetRegionsTableUN(var pTable:SL3REGIONS):Boolean;
     function AddRegionTable(var pTable:SL3REGION):Boolean;
     function addRegionId(var pTable:SL3REGION):Integer;
     function addDepartamentId(var pTable:SL3DEPARTAMENT):Integer;
     function addTownId(var pTable:SL3TOWN):Integer;
     function CheckDepId(IdRayCode:Integer;var IdRegion:integer):Integer;
     function addStreetId(var pTable:SL3STREET):Integer;
     function addAbonId(pTable:SL3ABON):Integer;
     function addAbonId_SaveL3Abon(pTable:SL3ABON):Integer;
     function addTpId(pTable:SL3TP):Integer;
     function addGroupId(pTable:SL3GROUPTAG):Integer;
     function addMeterId(pTable:SL2TAG):Integer;
     function addMeterId2(aAddrecc, aFIO : string; pTable:SL2TAG):Integer;
     function addVMeterId(pTable:SL3VMETERTAG):Integer;
     function IsRegTable(var pTable:SL3REGION):Boolean;
     function SetRegionTable(var pTable:SL3REGION):Boolean;
     function DelRegionTable(nIndex:Integer):Boolean;
     function GetRegTable(var pTable:SL3REGIONS):Boolean;

     function GetAllDepartamentsTable(var pTable:SL3DEPARTAMENTS):Boolean;
     function GetDepartamentsTable(RegID: integer;var pTable:SL3DEPARTAMENTS):Boolean;

     function GetDepartamentsTableALL(var pTable:SL3DEPARTAMENTS):Boolean;

     function AddDepartamentTable(var pTable:SL3DEPARTAMENT):Boolean;
     function IsDepartamentTable(var pTable:SL3DEPARTAMENT):Boolean;
     function IsDepartamentTableCode(_code:String):Boolean;
     function SetDepartamentTable(var pTable:SL3DEPARTAMENT):Boolean;
     function DelDepartamentTable(nIndex:Integer):Boolean;

     function GetAllTownsTable(var pTable:SL3TOWNS):Boolean;
     function GetTownsTable(DepID: integer;var pTable:SL3TOWNS):Boolean;
     function AddTownTable(var pTable:SL3TOWN):Boolean;
     function IsTownTable(var pTable:SL3TOWN):Boolean;
     function SetTownTable(var pTable:SL3TOWN):Boolean;
     function DelTownTable(nIndex:Integer):Boolean;

     function GetAllTPTable(var pTable:SL3TPS):Boolean;
     function AddTPTable(var pTable:SL3TP):Boolean;
     function IsTPTable(var pTable:SL3TP):Boolean;
     function SetTPTable(var pTable:SL3TP):Boolean;
     function DelSL3TPTable(nIndex:Integer):Boolean;

     function GetAllStreetsTable(var pTable:SL3STREETS):Boolean;
     function GetStreetsTable(TownID: integer; var pTable:SL3STREETS):Boolean;
     function GetPodsTable(TownID: integer; var pTable:SL3TPS):Boolean;
     function GetStreetByTpTable(tpID: integer; var pTable:SL3STREETS):Boolean;
     function AddStreetTable(var pTable:SL3STREET):Boolean;
     function IsStreetTable(var pTable:SL3STREET):Boolean;
     function SetStreetTable(var pTable:SL3STREET):Boolean;
     function DelStreetTable(nIndex:Integer):Boolean;
     function GetAbonLabel(nABOID: integer;var pTable:SL3ABONLB):Boolean;
     function GetAbonRegTable(nRegionID:Integer;var pTable:SL3ABONS):Boolean;
     function GetAbonRegTableByAddr(reg,ray,tow,tpid,str:Integer;var pTable:SL3ABONS):Boolean;
     function GetFiltAbonRegTable(nRegionID:Integer;MinF,MaxF:int64;var pTable:SL3ABONS):Boolean;
     function GetFiltAbonRegTable_N(nRegionID,nDepID,nTownID,nStreetID:Integer;var pTable:SL3ABONS):Boolean;
     function GetFiltAbonRegTable_N_TP(nRegionID,nDepID,nTownID,nTpID:Integer;var pTable:SL3ABONS):Boolean;


     function GetAbonsTable(var pTable:SL3ABONS):Boolean;
     function GetAbonsNamesTable(var pTable:SL3ABONSNAMES):Boolean;
     function GetAbonsTableNS(var pTable:SL3ABONS):Boolean;
     function GetAbonTable(swABOID:Integer;var pTable:SL3ABONS):Boolean;
     function IsAbonTable(var pTable:SL3ABON):Boolean;
     function SetAbonTable(var pTable:SL3ABON):Boolean;
     function SetAbonNmTable(var pTable:SL3ABON):Boolean;
     function AddAbonTable(var pTable:SL3ABON):Boolean;
     function SetAbonParam(swABOID:Integer;str:String):Boolean;
     function DelAbonTable(swABOID:Integer):Boolean;
     function DelTpTable(swTPID:Integer):Boolean;
     function AbonTpId(swTPID:Integer):String;
     function AbonDepCode(DepName:string):String;

     function GetAbonGroupsTable(swABOID:Integer;var pTable:SL3INITTAG):Boolean;
     function GetAbonGroupsTableNS(swABOID:Integer;var pTable:SL3INITTAG):Boolean;
     function GetAbonTag(nAbon:Integer;var pTable:SL3INITTAG):Boolean;
     function GetGroup(nGID:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetGroupTreeSett(nGID:Integer):int64;
     function GetAddressSett(nABOID:Integer):int64;

     // Статистика
     function GetAbonsForStatistic(var pTable:SL3ABONS_STAT):Boolean;
     function GetMetersByAbonForStatistic(var pTable:SL3ABON_STAT):Boolean;
     
     //Замена счетчика
     function GetChandgeTable(nIndex:Integer;blType:Boolean;var pTable:SL3CHANDGES):Boolean;
     function AddChandgeTable(nIndex:Integer;var pTable:SL3CHANDGE):Boolean;
     function IsChandgeTable(var pTable:SL3CHANDGE):Boolean;
     function SetChandgeTable(var pTable:SL3CHANDGE):Boolean;
     function DelChandgeTable(nVMID,nIndex:Integer):Boolean;
     function AddChandgeDTTable(nVMID,nCHID,nCmdID,nType:Integer):Boolean;
     function GetPrecision(nVMID:Integer;var m_sbyPrecision:Integer):Boolean;
     function GetKiKU(nVMID:Integer;var nPR:Integer;var dKI,dKU:Double;var sddFabNum,sddPHAddres:String):Boolean;
     function LoadChandgeTable(nVMID:Integer;blType:Boolean;var pTable:SL3CHANDGES):Boolean;

     //Замена счетчика таблица коррекции
     function GetChandgeDTTable(nIndex:Integer;var pTable:SL3CHANDTS):Boolean;
     function AddChnDTTable(nIndex:Integer;var pTable:SL3CHANDT):Boolean;
     function IsChandgeDTTable(var pTable:SL3CHANDT):Boolean;
     function SetChandgeDTTable(var pTable:SL3CHANDT):Boolean;
     function DelChandgeDTTable(nIndex,nType:Integer):Boolean;
     function getChangeData(nIndex,nCmdID,nTid:Integer;var pTable:CCDatas):boolean;
     function GetChngData(nIndex,nCmdID,nTid:Integer;var pTable:CCDatas):Boolean;
     function GetChngDataArch(nIndex,nCmdID,nTid:Integer;var pTable:CCDatas):Boolean;
     function AddChnDTLoadTable(nType:Integer;var pTable:SL3CHANDT):Boolean;
     function IsChandgeDTLoadTable(var pTable:SL3CHANDT):Boolean;
     function SetChandgeDTLoadTable(nType:Integer;var pTable:SL3CHANDT):Boolean;


     function GetVMetersFullTable(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetVMetersAbonFTable(nAbon:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetVMetersAbonVMidFTable(nAbon,nVMid:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetAbonVMetersFullTable(nAbon:Integer;var pTable:SL3GROUPTAG):Boolean;
    // function GetVMetersOneData(nChannel:Integer; pTable:SL3GROUPTAG):Boolean;

     function GetVMetersTable(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetVMetersTableWithParams(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetPHAddrL3(nVMID:Integer;var sPHAddr:String):Boolean;
     function GetPHAddrL2(nVMID:Integer;var nPHAddr:Integer):Boolean;
     function GetVmidJoin(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetAbonVMetersTable(nAbon,nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetAbonVMetersTable1(nAbon,nChannel:Integer;var pTable:SL3GROUPTAG1):Boolean;
     function GetAbonVMeterTable(nAbon,nVMid:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetAbonMetersTable(nAbon:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetAbonMetersLocTable(nAbon:Integer;strType:String;var pTable:SL3GROUPTAG):Boolean;
     function GetAbonPortMetersTable(nAbon:Integer;var pTable:SABONPORTMETER):Boolean;
     function GetPortMeterTable(nAbon,nPort:Integer;var pTable:SPORTMETERS):Boolean;
     function GetAbonPortsTable(nAbon:Integer;var pTable:SABONPORTMETER):Boolean;
     function GetAbonVMIDTable(nAbon:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetVMNameTable(var pTable:SL3VMNAMETAGS):Boolean;
     function GetMetNameTable(var pTable:SL3VMNAMETAGS):Boolean;
     function GetVMetersTypeTable(nChannel,nType:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetVMeterTbl(var pTable:SL3VMETERTAG):Boolean;
     function GetVMeterTable(var pTable:SL3VMETERTAG):Boolean;
     function SetVMeterTable(var pTable:SL3VMETERTAG):Boolean;
     function AddVMeterTable(var pTable:SL3VMETERTAG):Boolean;
     function DelVMeterTable(nMIndex,nIndex:Integer):Boolean;
     function UpdateGROUPLV(GrID, GROUPLV : integer):Boolean;
     function GetVL2tagTable(nChannel:Integer;var pTable:SL2InitImgIndex):Boolean; //imageIndex tree

     function SetGroupParamAll(nAbon,nGroup,nCmd:Integer;strCmd:String):Boolean;
     function GetVParamsTable(nChannel:Integer;var pTable:SL3VMETERTAG):Boolean;
     function GetVPMatrix(nAID,nVMID:Integer;var pTable:SL3VMETERTAG):Boolean;
     function GetVParamsGrTable(nAbon,nGroup,nChannel,nType:Integer;var pTable:SL3VMETERTAG):Boolean;
   //function GetVParamTbl(var pTable:SL3PARAMS):Boolean;
     function GetVParamTbl(nIndex:Integer;var pTable:SL3PARAMS):Boolean;
     function GetVParamTable(var pTable:SL3PARAMS):Boolean;
     function SetVParamTable(var pTable:SL3PARAMS):Boolean;
    // function AddVParamTable(var pTable:SL3PARAMS):Boolean;
     function AddVParamTable(nIndex:Integer;var pTable:SL3PARAMS):Boolean;
     function DelVParamTable(nMasterIndex,nIndex:Integer):Boolean;
     function InsertVParams(nMeterType,nIndex:Integer):Boolean;
     function ReplaceVParams(nMType,nIndex:Integer):Boolean;
     function GetVKeyParamsTable(nChannel,nSVType:Integer;var pTable:SL3VMETERTAG):Boolean;
     function VParamTSynchronize:Boolean;
     function GET_QUERYSTATE(nChannel:Integer):integer;
     function SetRegTable(sName:String):Boolean;
     function DelRegTable(sName:String):Boolean;
     function GetIdRegTable(var IdRes:Integer;sName:String):Boolean;
     function DelDepTable(sName:String):Boolean;
     function SetDepTable(Reg_ID,_Code:Integer;sName:String):Boolean;     

     function DelAbonVMID(m_VMID:Integer):Boolean;


    procedure GetRegion;
    procedure GetDepartament;
     //Data Routing

     function AddCurrentParam(var pTable:L3CURRENTDATA):Boolean;
     function CurrentPrepare:Boolean;
     function CurrentExecute:Boolean;
     function CurrentFlush(swVMID:Integer):Boolean;
     function SetCurrentParam(var pTable:L3CURRENTDATA):Boolean;
     function SetArchParam(var pTable:L3CURRENTDATA):Boolean;
     function DeleteCurrentParam(nIndex:Integer):Boolean;
     function IsCurrentParam(var pTable:L3CURRENTDATA):Boolean;

     function AddArchData(var pTable:L3CURRENTDATA):Boolean;
     function AddArchDataNoBlock(var pTable:L3CURRENTDATA):Boolean;
     function setCurrentParamEx(var pTable:L3CURRENTDATA):Boolean;
     function IsArchData(var pTable:L3CURRENTDATA):Boolean;
     function UpdateArchData(var pTable:L3CURRENTDATA):Boolean;
     function DelArchData(Date1, Date2 : TDateTime; var Data :L3CURRENTDATA):Boolean;
     function AddPdtData(var pTable:L3CURRENTDATA):Boolean;
     function DelPdtData(Date1, Date2 : TDateTime; var Data :L3CURRENTDATA):Boolean;

     function UpdatePdtData(var pTable:L3CURRENTDATA):Boolean;
     function IsPdtParam(var pTable:L3CURRENTDATA):Boolean;
     function AddPdtDataEx(var pTable:L3CURRENTDATA):Boolean;
     function GetGraphDatasPD48(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function AddPDTData_48(var pTable:L3GRAPHDATA):Boolean;
     function UpdatePDTFilds_48(var pTable:L3CURRENTDATA):Boolean;
     function UpdatePDTData_48(var pTable:L3GRAPHDATA):Boolean;
     function IsPDTData_48(var pTable:L3GRAPHDATA):Boolean;

     function GetMetaData(nIndex,nDataType:Integer;var pTable:CGMetaDatas):Boolean;
     function SetMetaData(nIndex:Integer;var pTable:CGMetaData):Boolean;
     function GetTariffData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetTariffDataBTI(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetCurrentData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetCurrentDataBTI(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetCData(nIndex,nDataType:Integer;var pTable:CCDatas):Boolean;
     function GetGDPData(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:CCDatasWithTarif):Boolean;
     function GetGData(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatasWithTarif):Boolean;
     function GetGDataFMAK(strOBJCODE:String;dtP0,dtP1:TDateTime;PKey:Integer;var pTable:CCDataMCs):Boolean;
     function GetGRData(var pTable:L3CURRENTDATA):Boolean;
     function GetCRDataT(var pTable:L3CURRENTDATA):Boolean;
     function GetCRData(var pTable:L3CURRENTDATA):Boolean;
     function GetGDataEnergo(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
     function GetGDataBTI(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
     function GetGMetaData(nIndex:Integer;var pTable:CGRMetaData):Boolean;
     function UpateLastTime(nVMID,nCMDID:Integer;dtTime:TDateTime):Boolean;
     function UpdateLockStParam(nVMID,nCMDID,nLockState:Integer):Boolean;
     function UpdateLastParam(nVMID,nCMDID:Integer;fValue:Double):Boolean;
     function UpdateLastParamTime(nVMID,nCMDID:Integer;fValue:Double;dtTime:TDateTime):Boolean;
     function UpdateMaxParam(nVMID,nCMDID:Integer;fValue:Double):Boolean;
     function UpdateMinParam(nVMID,nCMDID:Integer;fValue:Double):Boolean;
     function UpdateExpression(nVMID,nCMDID:Integer;str:String):Boolean;

     function GetKI_KU(nAVMid : integer;var pTable : SL2TAGREPORTLIST) : boolean;
     function GetGraphDatas(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetGraphDatasFMAK(strOBJCODE:String;dtP0,dtP1:TDateTime;var pTable:L3GRAPHDATAMCS):Boolean;
     function GetGraphDatasST(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetGraphDatasEnergo(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetGraphDatasBTI(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function AddGraphData(var pTable:L3GRAPHDATA):Boolean;
     function AddIfExGraphData(var pTable:L3GRAPHDATA):Boolean;
     function UpdateGraphData(var pTable:L3GRAPHDATA):Boolean;
     function UpdateIfExGraphData(var pTable:L3GRAPHDATA;sUpdMask,sValidMask:int64):Boolean;
     function UpdateGraphFilds(var pTable:L3CURRENTDATA):Boolean;
     function UpdateGD48(var pTable:L3CURRENTDATA):Boolean;
     function IsGraphData(var pTable:L3GRAPHDATA):Boolean;
     function GetLastTime:TDateTime;
     function DelGraphData(Date1, Date2 : TDateTime;var Data :L3GRAPHDATA):Boolean;
     function SetValidSlice(DateTime:TDateTime;FMasterIndex,FIndex,m_nValIndex:Integer;nValid:Boolean):Boolean;
     function SetSliceToRead(DateTime:TDateTime;FMasterIndex,FIndex,m_nValIndex:Integer;nValid:Boolean):Boolean;
     function SetSlice(DateTime:TDateTime;FMasterIndex,FIndex,m_nValIndex:Integer;dValue:Double;nValid,nState:Boolean):Boolean;
     function SetDPSlice(DateTime:TDateTime;FMasterIndex,FIndex,m_nValIndex:Integer;dValue:Double;nValid,nState:Boolean):Boolean;
     function SetArchSlice(DateTime:TDateTime;FMasterIndex,FIndex,nTID:Integer;dValue:Double;nValid,nState:Boolean):Boolean;
     function delArchSlice(DateTime:TDateTime;FMasterIndex,FIndex,nTID:Integer;dValue:Double;nValid,nState:Boolean):Boolean;
//     procedure DeleteEventsSl(Count:integer);
     function DelSlices(MonthN : integer):Boolean;
     procedure FreeBase(MonthN : integer);
     function ReturnCRC(m_sfValue:array of double):word;//CRC
     function SaveGraphData:Boolean;
     function AddGraphData_save(var pTable:L3GRAPHDATA):Boolean;//optimiz

     //brest_енерготелеком
//     function AddArchUspdTable(var pTable:Arch_uspd; nGroup,nEvent:Integer):Boolean;
     function IsArchUspd(var pTable:Arch_uspd):Boolean;
     function AddArchDataEnergo(var pTable:VAl):Boolean;
     function IsArchDataEnergo(var pTable:val):Boolean;
     function UpdateArchDataEnergo(var pTable:VAL):Boolean;
     function DelArchEnergoData(Date1, Date2 : TDateTime; var Data :VAL):Boolean;
     function DelArchUspdTable(nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime):Boolean;


     function LoadForTUCHParams(var pTable:SLTUCH;n_abo:integer):Boolean;
     function GetGDataGomelEnergo(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
     //gomel'_енерготелеком
     function IsAbon(var pTable:Abon):Boolean;
     function IsTUCH(var pTable:TUCH):Boolean;
     function IsBUF_V_INT(var pTable:BUF_V_INT):Boolean;
     function IsAVT_EXP(var pTable:AVT_EXP):Boolean;
     function AddAbon(var pTable:Abon):Boolean;
     function AddTUCH(var pTable:TUCH):Boolean;
     function AddBUF_V_INT(var pTable:BUF_V_INT):Boolean;
     function AddAVT_EXP(var pTable:AVT_EXP):Boolean;
     function UpdateAbon(var pTable:Abon):Boolean;
     function UpdateTUCH(var pTable:TUCH):Boolean;
     function UpdateBUF_V_INT(var pTable:BUF_V_INT):Boolean;
     function UpdateAVT_EXP(var pTable:AVT_EXP):Boolean;
     function DelAbon(Date1, Date2 : TDateTime; var Data :Abon):Boolean;
     function DelTUCH(Date1, Date2 : TDateTime; var Data :TUCH):Boolean;
     function DelBUF_V_INT(Date1, Date2 : TDateTime; var Data :BUF_V_INT;M_pABON:integer):Boolean;
     function DelAVT_EXP(Date1, Date2 : TDateTime; var Data :L3DATASAVT_EXP):Boolean;
     //L3GRAPHDATA

     //BELTI
     function DeleteBTIMeters(var PortID : integer):boolean;
     function DelUSPDData(AdrUSPD : byte):Boolean;
     function AddUSPDTypeData(var pTable : SL2USPDTYPE):Boolean;
     function AddUSPDDev(var pTable : SL2USPDEV):Boolean;
     function AddUSPDCharDev(var pTable : SL2USPDCHARACTDEV):Boolean;
     function AddUSPDCharKan(var pTable : SL2USPDCHARACTKANAL):Boolean;
     function AddUSPDCharGr(var pTable : SL2USPDCHARACTGR):Boolean;
     function IsUSPDTypeData(var pTable : SL2USPDTYPE):Boolean;
     function IsUSPDDev(var pTable : SL2USPDEV):Boolean;
     function IsUSPDCharDev(var pTable : SL2USPDCHARACTDEV):Boolean;
     function IsUSPDCharKan(var pTable : SL2USPDCHARACTKANAL):Boolean;
     function IsUSPDCharGr(var pTable : SL2USPDCHARACTGR):Boolean;
     function UpdateUSPDTypeData(var pTable : SL2USPDTYPE):Boolean;
     function UpdateUSPDDev(var pTable : SL2USPDEV):Boolean;
     function UpdateUSPDCharDev(var pTable : SL2USPDCHARACTDEV):Boolean;
     function UpdateUSPDCharKan(var pTable : SL2USPDCHARACTKANAL):Boolean;
     function UpdateUSPDCharGr(var pTable : SL2USPDCHARACTGR):Boolean;
     function ReadUSPDTypeData():Boolean;
     function ReadUSPDDev():Boolean;
     function ReadUSPDCharDev(AdrUSPD : byte;var pTable:SL2USPDCHARACTDEVLIST):Boolean;
     function ReadUSPDCharKan(AdrUSPD, MeterID : word;var pTable :SL2USPDCHARACTKANALLIST):Boolean;
     function ReadUSPDCharGr(var pTable:SL2USPDCHARACTGRLIST): boolean;
     function AddMeterUSPD(var pTable:SL2TAG):Boolean;
     function IsMeterUSPD(var pTable:SL2TAG):Boolean;
     function UpdateMeterUSPD(var pTable:SL2Tag):Boolean;

     //BELTI CONFIGURATION
     function ReadUSPDCFG(var pTable : SL2USPDTYPEEX) : boolean;
     function GetVMFromEnerg(var pTable : SL2TAGREPORTLIST) : boolean;
     function ReadUSPDDevCFG(IsMSGOur :boolean;var pTable : SL2USPDEVLISTEX) : boolean;
     function ReadUSPDCharDevCFG(IsMSGOur :boolean;var pTable : SL2USPDCHARACTDEVLISTEX) : boolean;

     function LoadReportParams(nAbon:Integer;var pTable : REPORT_F1):boolean;
     function AddReportParams(var pTable : REPORT_F1):boolean;
     function IsReprtParm(var pTable:REPORT_F1):Boolean;
     function UpdateReportParams(var pTable : REPORT_F1):boolean;
     //function


     //Settings
     function GetGenSettTable(var pTable:SGENSETTTAG):Boolean;
     function IsGenSett:Boolean;
     function AddGenSettTable(var pTable:SGENSETTTAG):Boolean;
     function SetGenSettTable(var pTable:SGENSETTTAG):Boolean;
     function SetLastExportDate(dtLast:TDateTime):Boolean;

//     function GetUspdEventALL(nIndex:Integer;var pTable:SEVENTTAGS):Boolean;
//     function GetUspdEventCorrector(nEvent:Integer):Boolean;
     function FixUspdEventCorrector(nEvent:Integer;m_swDescription:extended):Boolean;
     function FixUspdEventCorrectorEx(dtOldTime:TDateTIme;nEvent:Integer;m_swDescription:extended):Boolean;
     function GetEventsTable(nIndex:Integer;var pTable:SEVENTSETTTAGS):Boolean;
     function SetEventTable(var pTable:SEVENTSETTTAG):Boolean;
     function IsEvent(var pTable:SEVENTSETTTAG):Boolean;
     function AddEventTable(var pTable:SEVENTSETTTAG):Boolean;
     function DelEventsTable(nIndex:Integer):Boolean;
//     function DelFixEvents(dt0, dt1 : TDateTime; nIndex:Integer):Boolean;

//     function GetFixEventsTable(nABOID,nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime;var pTable:SEVENTTAGS):Boolean;
//     function GetFixEventsTableFromStr(nGroup,nVMID:Integer;var nEvents:string;tm0,tm1:TDateTime;var pTable:SEVENTTAGS):Boolean;
//     function IsFixEvent(var pTable:SEVENTTAG):Boolean;
//     function AddFixEventTable(var pTable:SEVENTTAG):Boolean;
//     function UpdateFixEventTable(var pTable:SEVENTTAG):Boolean;
//     function DelFixEventsTable(nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime):Boolean;
//     function FixUspdDescEvent(PKey,Group,nEvent:Integer;swDescription:Extended):Boolean;
//     function FixUspdEvent(PKey,Group,nEvent:Integer):Boolean;
//     function FixMeterEvent(nGroup,nEvent,nVMID:Integer;Descr:Double;Date : TDateTime):Boolean;
//     function FixUSPDCorrMonth(Value : integer; Time : TDateTime) : boolean;
//     function UpdateKorrMonth(Delta: TDateTime):boolean;

     function FixLimitEvent(VMID, CMDID, TID, EvID : integer; Time : TDateTime) : boolean;
//     function IsLimitEvent(VMID, CMDID, TID, EvID : integer; Time : TDateTime) : boolean;
//     function AddLimitEvent(VMID, CMDID, TID, EvID : integer; Time : TDateTime) : boolean;
     function UpdateLimitEvent(VMID, CMDID, TID, EvID : integer) : boolean;
//     function GetLimitEventTbl(VMID, CMDID, TID : integer; var pTable : SEVENTTAGS) : boolean;
//     function DelLimitEvent(var pTable : SEVENTTAG) : boolean;

     function GetConnectsTable(var pTable:SCONNSETTTAGS):Boolean;
     function SetConnectTable(var pTable:SCONNSETTTAG):Boolean;
     function IsConnect(nIndex:Integer):Boolean;
     function AddConnectTable(var pTable:SCONNSETTTAG):Boolean;
     function DelConnectsTable(nIndex:Integer):Boolean;

     function GetColorsTable(var pTable:SCOLORSETTTAGS):Boolean;
     function GetColorTable(var pTable:SCOLORSETTTAG):Boolean;


     function  IsColor(nIndex:Integer):Boolean;
     function  AddColorTable(var pTable:SCOLORSETTTAG):Boolean;
     function  AddColorPanel(var pTable:SCOLORSETTTAG):Boolean;
     function  SetColorTable(var pTable:SCOLORSETTTAG):Boolean;
     function  SetColorPanel(var pTable:SCOLORSETTTAG):Boolean;
     function  SetStyle(style:Integer):Boolean;
     function  SaveStyle(style:Integer):Boolean;
     function  DelColorsTable(nIndex:Integer):Boolean;

     function GetUsersTable(var pTable:SUSERTAGS):Boolean;
     function GetUserTable(var pTable:SUSERTAG):Boolean;
     function SetUserTable(var pTable:SUSERTAG):Boolean;
     function AddUserTable(var pTable:SUSERTAG):Boolean;
     function IsUserTag(var pTable:SUSERTAG):Boolean;
     function DelUserTable(swUID:Integer):Boolean;

     function GetUserID(name : string):integer;
     function GetUserNameFromID(ID : integer):string;

     function GetGroupQueryName(GroupQueryID : integer):string;
     function UpdateGroupQuery(GroupQueryID : integer; DATEQUERY : TDate; ERRORQUERY:byte):boolean;

     function CheckLevelAccess(strUser,strPassword:String;nLevel:Integer):Boolean;
     function GetSecurityAttributes(var pTable:SUSERTAG):Boolean;
     function GetAllowAbonStr(UID : integer) : string;
     procedure SetPhotoTable(var pTable:SUSERTAG;var MemoryStream : TMemoryStream);
     function GetPhotoTable(var pTable:SUSERTAG;var MemoryStream : TMemoryStream):boolean;

     function AddLimitData(var pTable: SL3LIMITTAG):boolean;
     function GetLimitDatas(VMID, CMDID, TID : integer; var pTable: SL3LIMITTAGS):boolean;
     function GetLimitDatasFromDate(dt_Date : TDateTime; var pTable: SL3LIMITTAGS):boolean;
     function GetAllLimitDatas(var pTable: SL3LIMITTAGS):boolean;
     function DeleteLimitData(var pTable: SL3LIMITTAG):boolean;
     function GetCurrLimitValue(VMID, CMDID, TID : integer):double;
     function GetFirstEntasNetPIDAndMID(var PID, MID : integer):boolean;

     function GetTransTimeTable(var pTable:SL3TRANSTIMES):Boolean;
     function IsTransTime(nIndex:Integer):Boolean;
     function SetTransTimeTable(var pTable:SL3TRANSTIME):Boolean;
     function AddTransTimeTable(var pTable:SL3TRANSTIME):Boolean;
     function DelTransTimeTable(nIndex:Integer):Boolean;

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


//     function PADOQryR1:PTADOQuery;
//     function PADOQryR2:PTADOQuery;

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
     function CreateConnect:PCDBDynamicConn;
     function CreateConnectEx(var nDesc:Integer):PCDBDynamicConn;
     function DynConnect(nIndex:Integer):PCDBDynamicConn;
     function DynDisconnect(nIndex:Integer):Boolean;
     function DynDisconnectEx(nIndex:Integer):Boolean;

     function ExecQryMySql(strSQL:String):Boolean;
     function GetSizeDB:Integer;
     procedure AddToBase;
     procedure AddToBaseM(dsTIME:TDateTime;nVMID,nTID,nCMDID:Integer;dValue:Double);

     function SetVMeterTableCode(m_swVMID:Integer; code:String):Boolean;
     procedure ConnectDBF(strConnect:String);
     procedure DisconnectDBF;
     procedure CreateUPDBF(strTable:String);
     procedure CreateUPDBFVIT(strTable:String);
     procedure InsertUPDBF(strTable:String;var pTable:SL3ExportDBF);
     procedure InsertUPDBFVIT(strTable:String;var pTbl:SL3ExportVIT);
     procedure DeleteUPDBF(strTable:String);
     function  GetAbonPortID(nIndex: Integer): integer;
     function  GetAbonMax: integer;
     function  DelAbonTbl(nIndex, nPID:Integer):Boolean;
     procedure saveToDefData(wCMDID,wWMID:Word);
     procedure saveToCurrent(wCMDID,wTID,wWMID:Word);
     function SetCurrentParamNoBlock(var pTable:L3CURRENTDATA):Boolean;
     function  ExecQry(strSQL:String):Boolean;
    private
     procedure CreateConnectionStr(strProvider:String;var vConn:TIBDataBase;var vQry:TIBQuery);
     procedure CreateConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
     procedure CreateConnection_0(var vConn:TIBDataBase;var vQry:TIBQuery);
     procedure DestroyConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
     //function  ExecQry(strSQL:String):Boolean;

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
     function  OpenQryDBF(strSQL:String;var nCount:Integer):Boolean;
     procedure CloseQry;
     procedure CloseQryD;
     procedure CloseQryD1;
     procedure CloseQryD2;
     procedure CloseQrySA;
     procedure CloseQryBTI;
     procedure CloseQryDBF;
     procedure UpdateL1PortCount;
     procedure UpdateL2MeterCount;
    public
     function  ExecQryDBF(strSQL:String):Boolean;
     function GetDepartGroupID(GroupQueryID : integer; var SB : TStringList):Boolean;     
     procedure SendEventBox(aType : Byte; aMessage : String);          
    private
     {MySQL}
     bl0,bl1 : Boolean;
     FTZoneHand          : TZoneHand;
     m_strExePath        : String;
     w_mGEvent0          : THandle;
     m_nQRYs             : Integer;
     m_nBLOs             : Integer;
     strBSQL             : AnsiString;
     m_nWriteTAG         : SL3WRITETAGS;
     m_sMySQLConnStr     : String; // строка DSN подключения для MySQL
     m_sMySQLqStr        : String;

     m_sDBFConnStr       : String; // строка DSN подключения для MySQL
     FADOConnectionMySQL : TIBDataBase;
     FADOQueryMySQL      : TIBQuery;

     //FADOConnectionDBF   : TIBDataBase;
     //FADOQueryDBF        : TADOQuery;
     //m_sDBFqStr          : String;

     FADOConnectionM2F   : TIBDataBase;
     FADOQueryM2F        : TIBQuery;
     m_byConnectionLevel : Byte;

     sCS             : TCriticalSection;
     FADOConnection  : TIBDataBase;
     FADOConnectionD : TIBDataBase;
     FADOConnectionD1: TIBDataBase;
     FADOConnectionD2: TIBDataBase;
     FADOConnectionSA: TIBDataBase;
     FADOConnectionBTI: TIBDataBase;
     FADOConnectionR1: TIBDataBase;
     FADOConnectionDBF: TIBDataBase;
     FconReport      : TIBDataBase;
     FADOQuery       : TIBQuery;
     FADOQueryD      : TIBQuery;
     FADOQueryD1     : TIBQuery;
     FADOQueryD2     : TIBQuery;
     FADOQuerySA     : TIBQuery;
     FADOQueryBTI     : TIBQuery;
     FqryReport      : TIBQuery;
     FqryReport1     : TIBQuery;
     FADOQueryDBF    : TIBQuery;
     m_sDbPlacement  : String;
     SenderClass     : TSenderClass;     
    public
     m_strDbUser     : String;
     m_strDbPassw    : String;
     property PADOConnection   : TIBDataBase  read FADOConnection  write FADOConnection;
     property PADOQuery        : TIBQuery       read FADOQuery       write FADOQuery;
     property PTZoneHand       : TZoneHand       read FTZoneHand       write FTZoneHand;
    End;
var
    m_pDB              : CDBase = nil;
    m_nLocalConnStr    : String;
    m_pDBC             : array[0..MAX_DYNCONN] of CDBDynamicConn;
    strSQL_INTO        : string;
const
    MAX_BLOCK_QRY = 50;


function ParseADVDISCL(DVDISCL : string; level : byte):string; // level - c нуля (0 - 1-е значение)    
implementation

uses fLogFile,knsl5module;

{function CDBase.PADOQryR1:PTADOQuery;
Begin
    CreateConnection(FADOConnectionR1,FqryReport1);
    Result := @FqryReport1;
End; }
{
function CDBase.PADOQryR2:PTADOQuery;
Begin
    //CreateConnection(FADOConnectionR2,FqryReport2);
    //Result := @FqryReport2;
End;         }
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

procedure CDBase.SendEventBox(aType : Byte; aMessage : String);
Var s  : string;
    ID : Integer;
Begin
  ID := 0;
  s := SenderClass.ToStringBox(aType, aMessage);
  ID := GetCurrentThreadID;
  SenderClass.Send(QL_QWERYBOXEVENT, EventBoxHandle, ID, s);
End;

function ParseADVDISCL(DVDISCL : string; level : byte):string; // level - c нуля (0 - 1-е значение)
var i, h : Integer;
begin
  i:=0;
  while i <> level do begin
    h := Pos(';', DVDISCL);
    delete(DVDISCL,1,pos(';', DVDISCL));
    inc(i);
  end;
  Result := Copy(DVDISCL,1,Pos(';', DVDISCL)-1);
end;

constructor CDBase.Create;
Begin
  if SenderClass = Nil then SenderClass := TSenderClass.Create;
    m_strDbUser           := 'SYSDBA';
    //m_strDbPassw          := '1a2l3e4x';
    m_strDbPassw          := 'masterkey';
End;
function CDBase.Init(strFileName,strExePath:String):Boolean;
var
    Fl   : TINIFile;
    i    : Integer;
    //sDbPlacement       : String;
    sDBLockProvider    : String;
    m_strDefConnection : String;
Begin
    m_blIsConnect         := False;
    m_blIsBackUp          := False;
    m_nDynCount           := 0;
    m_nQRYs               := 0;
    m_nBLOs               := 0;
    //DBProvider=c:\a2000\ascue\SYSINFOAUTO.fdb
    m_strExePath     := strExePath;
    DecimalSeparator := '.';
    w_mGEvent0            := CreateEvent(nil, False, False, nil);
    m_strDefConnection    := 'Driver=Firebird/InterBase(r) driver;Uid='+m_strDbUser+';Pwd='+m_strDBPassw+';DbName=m_sDbPlacement';
    for i:=0 to MAX_DYNCONN do m_blDynConn[i] := False;
    m_strFileName := strFileName;
    Fl := TINIFile.Create(strFileName);
     sCS:=TCriticalSection.Create;
     m_sDbPlacement       := Fl.ReadString('DBCONFIG', 'DBProvider', '');
     sDBLockProvider      := Fl.ReadString('DBCONFIG', 'DBLockProvider', '');
     //m_strProvider        := StringReplace(m_strDefConnection,'m_sDbPlacement',m_sDbPlacement,[rfReplaceAll]);
     //m_strProvider_0      := StringReplace(m_strDefConnection,'m_sDbPlacement',sDBLockProvider,[rfReplaceAll]);
     m_strProvider        := m_sDbPlacement;
     m_strProvider_0      := m_sDbPlacement;
     m_nCurrentConnection := Fl.ReadInteger('DBCONFIG','CurrentConnection', 0);
//     FFileIndex           := Fl.ReadInteger('DBCONFIG','FFileIndex', 0);
     //Fl.WriteInteger('DBCONFIG','FFileIndex', 1);
     m_nValue             := Fl.ReadInteger('DBCONFIG','m_nValue', 0);
     m_nOnAutorization    := Fl.ReadInteger('DBCONFIG','m_nOnAutorization', 0);
     m_nReStartEvent      := Fl.ReadInteger('DBCONFIG','m_nReStartEvent', 0);
     m_nSynchronize       := Fl.ReadInteger('DBCONFIG','m_nSynchronize', 0);
     m_nL4Synchronize     := Fl.ReadInteger('DBCONFIG','m_nL4Synchronize', 0);
     m_nL2Synchronize     := Fl.ReadInteger('DBCONFIG','m_nL2Synchronize', 0);
     m_nWPollTime         := Fl.ReadInteger('DBCONFIG','m_nWPollTime', 0);
     m_dwSort             := Fl.ReadInteger('DBCONFIG','m_dwSort', 0);
     m_dwTree             := Fl.ReadInteger('DBCONFIG','m_dwTree', 0);
     m_nStopL3            := Fl.ReadInteger('DBCONFIG','m_nStopL3', 0);
     m_nIsServer          := Fl.ReadInteger('DBCONFIG','m_nIsServer', 0);
     m_nQweryTime         := Fl.ReadInteger('DBCONFIG','m_nQweryTime', 15);
     DBAddFieldEn         := Fl.ReadInteger('DBCONFIG','DBAddFieldEn',0);
     m_nMaxSpaceDB        := Fl.ReadInteger('DBCONFIG','m_nMaxSpaceDB',-1);
     m_nUpdateTime        := Fl.ReadInteger('DBCONFIG','m_nUpdateTime',5);
     m_nMaxKorrTime       := Fl.ReadInteger('DBCONFIG','m_nMaxKorrTime',60);
     m_nIsOneSynchro      := Fl.ReadInteger('DBCONFIG','m_nIsOneSynchro',1);
     m_nMaxDayNetParam    := Fl.ReadInteger('DBCONFIG','m_nMaxDayNetParam',30);
     m_nSmartFinder       := Fl.ReadInteger('DBCONFIG','m_nSmartFinder',0);
     m_nInterSpeed        := Fl.ReadInteger('DBCONFIG','m_nInterSpeed',2);
     m_nUpdateFunction    := Fl.ReadInteger('DBCONFIG','m_nUpdateFunction',1);
     m_blMDMPrep          := Fl.ReadInteger('DBCONFIG','m_blMDMPrep',1);
     m_strMDMPrep         := Fl.ReadString('DBCONFIG','m_strMDMPrep','AT');
     m_strMDReset         := Fl.ReadString('DBCONFIG','m_strMDReset','ATZ&D0&C0Q0S0=2');
     m_nCheckPins         := Fl.ReadInteger('DBCONFIG','m_nCheckPins',0);
     m_nWDTTime           := Fl.ReadInteger('DBCONFIG','m_nWDTTime',0);
     m_nTimeToBan         := Fl.ReadInteger('DBCONFIG','m_nTimeToBan',0);
     m_nAutoKorrDay       := Fl.ReadInteger('TIMECONFIG','m_nAutoKorrDay',0);
     m_byCoverState       := Fl.ReadInteger('TIMECONFIG','m_byCoverState',1);
     m_nLastCorrTime      := StrToDateTime(Fl.ReadString('TIMECONFIG','m_nLastCorrTime',DateTimeToStr(Now)));
     m_nCountOfEvents     := Fl.ReadInteger('DBCONFIG', 'm_nCountOfEvents', 5000);
     m_nIsUspd            := Fl.ReadInteger('DBCONFIG', 'm_nIsUspd', 0);
     m_nLockMeter         := Fl.ReadInteger('DBCONFIG', 'm_nLockMeter', 0);
     m_nIsLightControl    := Fl.ReadInteger('DBCONFIG', 'm_nIsLightControl', 0);
     m_byNSCompare        := Fl.ReadInteger('DBCONFIG', 'm_byNSCompare', 0);
     m_byEvents           := Fl.ReadInteger('DBCONFIG', 'm_byEvents', 1);
     m_stTimeBSave        := StrToTime(Fl.ReadString('DBCONFIG', 'm_stTimeBSave', '1:20:00'));
     m_byConnectionLevel  := 1;
    Fl.Destroy;
    Result := FileExists(m_sDbPlacement);
End;
function CDBase.GetConnString(str:String):String;
//Var
//    strConn : String;
Begin
    //strConn := 'Driver=Firebird/InterBase(r) driver;Uid='+m_strDbUser+';Pwd='+m_strDBPassw+';DbName=m_sDbPlacement';
    //Result  := StringReplace(strConn,'m_sDbPlacement',str,[rfReplaceAll]);
    Result := str;//m_sDbPlacement;
End;
procedure CDBase.WriteReStartEvent(strFileName:String);
var
    Fl   : TINIFile;
    //i    : Integer;
    //sDbPlacement       : String;
    //m_strDefConnection : String;
Begin
    //m_blIsBackUp          := False;
    //m_nDynCount           := 0;
    //m_strDefConnection    := 'Driver=Firebird/InterBase(r) driver;Uid=SYSDBA;Pwd=masterkey;DbName=m_sDbPlacement';
    //for i:=0 to MAX_DYNCONN do m_blDynConn[i] := False;
    m_strFileName := strFileName;
    Fl := TINIFile.Create(strFileName);
    if sCS <> nil then FreeAndNil(sCS);
    sCS:=TCriticalSection.Create;
    Fl.WriteInteger('DBCONFIG','m_nReStartEvent', m_nReStartEvent);
    Fl.UpdateFile;
    Fl.Destroy;
End;
function CDBase.CreateConnect:PCDBDynamicConn;
Var
    i : Integer;
Begin
    Result := Nil;
    for i:=1 to MAX_DYNCONN do
    if m_blDynConn[i]=False then
    Begin
     Result := DynConnect(i);
     exit;
    End;
End;
function CDBase.CreateConnectEx(var nDesc:Integer):PCDBDynamicConn;
Var
    i : Integer;
Begin
    Result := Nil;
    for i:=1 to MAX_DYNCONN do
    if m_blDynConn[i]=False then
    Begin
     nDesc  := i;
     Result := DynConnect(i);
     exit;
    End;
End;

function CDBase.getConnection:CDBDynamicConn;
Var
    pDD : CDBDynamicConn;
Begin
    sCS.Enter;
    pDD := CDBDynamicConn.Create;
    pDD.Init(m_strProvider);
    pDD.Connect;
    pDD.PTZoneHand := FTZoneHand;
    Result := pDD;
    sCS.Leave;
End;

procedure CDBase.DiscDynConnect(var pDD:CDBDynamicConn);
Begin
   if pDD = nil then exit;
    sCS.Enter;
    pDD.Disconnect;
    FreeAndNil(pDD);
    sCS.Leave;
End;

function CDBase.DynConnect(nIndex:Integer):PCDBDynamicConn;
Begin
    Result := Nil;
    if nIndex>MAX_DYNCONN then exit;
    if m_pDBC[nIndex]=Nil then m_pDBC[nIndex] := CDBDynamicConn.Create;
    m_blDynConn[nIndex] := True;
    m_pDBC[nIndex].Init(m_strProvider);
    m_pDBC[nIndex].Connect;
    m_pDBC[nIndex].PTZoneHand := FTZoneHand;
    Result := @m_pDBC[nIndex];
End;
function CDBase.DynDisconnect(nIndex:Integer):Boolean;
Begin
    Result := False;
    if nIndex>MAX_DYNCONN then exit;
    if m_pDBC[nIndex]=Nil then exit;
    //m_blDynConn[nIndex] := False;
    m_pDBC[nIndex].Disconnect;
    Result := True;
End;
function CDBase.DynDisconnectEx(nIndex:Integer):Boolean;
Begin
    Result := False;
    if nIndex>MAX_DYNCONN then exit;
    if m_pDBC[nIndex]=Nil then exit;
    //m_blDynConn[nIndex] := False;
    m_pDBC[nIndex].Disconnect;
    m_blDynConn[nIndex] := False;
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
//var
//    Fl: TINIFile;
Begin
//    Fl := TINIFile.Create(m_strFileName);
//    Fl.WriteString('DBCONFIG', 'FFileIndex', IntToStr(FFileIndex));
    //Fl.WriteString('DBCONFIG', 'DBProvider', m_strProvider);
    //Fl.WriteString('DBCONFIG', 'm_nLocalConnStr', m_nLocalConnStr);
    //Fl.WriteString('DBCONFIG', 'CurrentConnection', IntToStr(m_nCurrentConnection));
//    Fl.Destroy;
    //ConnectToLocal;
End;
procedure CDBase.ConnectDBF(strConnect:String);
Begin
     CreateConnectionStr(strConnect,FADOConnectionDBF,FADOQueryDBF);
End;
procedure CDBase.DisconnectDBF;
Begin
     DestroyConnection(FADOConnectionDBF,FADOQueryDBF);
End;
function CDBase.FullDisconnect;
Begin
     try
     m_blIsConnect        := False;
     m_blIsBackUp         := True;
     m_strSvCString       := m_strProvider;
     m_nSvConnLevel       := m_byConnectionLevel;
     DestroyConnection(FADOConnection,FADOQuery);
     DestroyConnection(FADOConnectionD,FADOQueryD);
     DestroyConnection(FADOConnectionD1,FADOQueryD1);
     DestroyConnection(FADOConnectionD2,FADOQueryD2);
     DestroyConnection(FconReport,FqryReport);
     DestroyConnection(FADOConnectionSA,FADOQuerySA);
     DestroyConnection(FADOConnectionM2F,FADOQueryM2F);
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
    m_strProvider        := GetConnString(str);
    m_byConnectionLevel  := 2;
    Disconnect;
    Connect;
    except
//     TraceER('(__)CERMD::>Error In CDBase.LightConnect!!!');
    end;
End;
function CDBase.FullConnect(str:String):Boolean;
Begin
    try
    m_strProvider        := GetConnString(str);
    m_byConnectionLevel  := 1;
    Disconnect;
    Connect;
    except
//     TraceER('(__)CERMD::>Error In CDBase.FullConnect!!!');
    end;
End;
function CDBase.SFullConnect(str:String):Boolean;
Begin
    try
    m_strProvider        := GetConnString(str);
    m_byConnectionLevel  := 0;
    Disconnect;
    Connect;
    except
//     TraceER('(__)CERMD::>Error In CDBase.SFullConnect!!!');
    end;
End;
function CDBase.IsConnectDB:Boolean;
Begin
    Result := m_blIsConnect;
End;
function CDBase.Connect:Boolean;
Var
    pTbl   : SL3CONNTBLS;
Begin
    Result := True;
    //FADOConnection.ConnectionString := 'Provider=MSDASQL.1;Password=masterkey;Persist Security Info=True;User ID=SYSDBA;Data Source=Firebird';
    try
    m_blIsConnect        := True;
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
      CreateConnection_0(FADOConnectionSA,FADOQuerySA);
      CreateConnection(FADOConnectionM2F,FADOQueryM2F);
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
     pTbl.Items[0].m_sConnString := m_sDbPlacement;
     m_pDB.AddConnTable(pTbl.Items[0]);
     //strDefConn := 'Driver=Firebird/InterBase(r) driver;Uid='+m_strDbUser+';Pwd='+m_strDBPassw+';DbName=m_sDbPlacement';
     //m_sConnString := StringReplace(strDefConn,'m_sDbPlacement',m_sConnString,[rfReplaceAll]);
     //m_strProvider_0 := pTbl.Items[0].m_sConnString;
    End;
    except
     StartProcess(m_strExePath+'restore.bat',TRUE);
     m_nQweryReboot:=1;
     //ReBootPrg;
     Result := False;
    End
End;
function CDBase.Disconnect:Boolean;
Begin
    Result := True;
    m_blIsBackUp         := True;
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

procedure CDBase.CreateConnectionStr(strProvider:String;var vConn:TIBDataBase;var vQry:TIBQuery);
Var IBTr : TIBTransaction;
Begin
      DestroyConnection(vConn, vQry);
      //if vConn=Nil then Begin
      vConn := TIBDataBase.Create(nil);
      IBTr := TIBTransaction.Create(nil);
      IBTr.Params.Add('read_committed');
      IBTr.Params.Add('rec_version');
      IBTr.Params.Add('wait');
      with vConn do begin
       SQLDialect := 3;
       DatabaseName := strProvider;
       Params.Add('user_name=sysdba');
       Params.Add('password=masterkey');
       Params.Add('lc_ctype=WIN1251');
       LoginPrompt := False;
       DefaultTransaction := IBTr;
      end;
      vConn.Connected := True;
  //if vQry=Nil then Begin
   vQry := TIBQuery.Create(Nil);
   vQry.Transaction:=IBTr;
   vQry.Database:=vConn;
  //End;
  //End;
    End;

procedure CDBase.CreateConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
Var IBTr : TIBTransaction;
Begin
  DestroyConnection(vConn, vQry);
  //if vConn=Nil then Begin
  vConn := TIBDataBase.Create(nil);
  IBTr := TIBTransaction.Create(nil);
  IBTr.Params.Add('read_committed');
  IBTr.Params.Add('rec_version');
  IBTr.Params.Add('wait');
      with vConn do begin
       SQLDialect := 3;
       DatabaseName := m_strProvider;
       Params.Add('user_name=sysdba');
       Params.Add('password=masterkey');
       Params.Add('lc_ctype=WIN1251');
       LoginPrompt := False;
       DefaultTransaction := IBTr;
      end;
      vConn.Connected := True;
  //if vQry=Nil then Begin
   vQry := TIBQuery.Create(Nil);
   vQry.Transaction:=IBTr;
   vQry.Database:=vConn;
  //End;
  //End;
    End;

procedure CDBase.CreateConnection_0(var vConn:TIBDataBase;var vQry:TIBQuery);
Var IBTr : TIBTransaction;
Begin
  DestroyConnection(vConn, vQry);
  //if vConn=Nil then Begin
  vConn := TIBDataBase.Create(nil);
  IBTr := TIBTransaction.Create(nil);
  IBTr.Params.Add('read_committed');
  IBTr.Params.Add('rec_version');
  IBTr.Params.Add('wait');
      with vConn do begin
       SQLDialect := 3;
       DatabaseName := m_strProvider;
       Params.Add('user_name=sysdba');
       Params.Add('password=masterkey');
       Params.Add('lc_ctype=WIN1251');
       LoginPrompt := False;
       DefaultTransaction := IBTr;
      end;
      vConn.Connected := True;
  //if vQry=Nil then Begin
   vQry := TIBQuery.Create(Nil);
   vQry.Transaction:=IBTr;
   vQry.Database:=vConn;
  //End;
  //End;
    End;

procedure CDBase.DestroyConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
Var IBTr : TIBTransaction;
Begin
  if vConn <> Nil then Begin         { TODO -oBO -cИнф : Входит сюда в момент загрузки программы }
    IBTr := vQry.Transaction;
    if vConn.DefaultTransaction <> nil then
      vConn.DefaultTransaction := nil;
    FreeAndNil(vConn);
    if vQry <> Nil then FreeAndNil(vQry);
    if IBTr <> Nil then FreeAndNil(IBTr);
    End;
End;
function CDBase.StartProcess(strPath:String;blWait:Boolean):Boolean;
Var
     si : STARTUPINFO;
     pi : PROCESS_INFORMATION;
     iRes : Boolean;
     dwRes: LongWord;
begin
     FillChar(si,sizeof(si),0);
     FillChar(pi,sizeof(pi),0);
     si.cb := sizeof(si);
     si.wShowWindow:=SW_HIDE;
     si.dwFlags:= STARTF_USESHOWWINDOW;
     iRes := CreateProcess(Nil, PChar(strPath), Nil, Nil, FALSE, NORMAL_PRIORITY_CLASS, Nil, Nil, si, pi);
     if(iRes=False) then
     begin
//      TraceL(4,0,':Process is not created');
      result := FALSE;
     end;
     if(blWait) then
     begin
      dwRes := WaitForSingleObject(pi.hProcess,10*60*1000);
      if(dwRes=WAIT_ABANDONED) then begin end;//TraceL(4,0,':Process is abandoned!');
     end;
     CloseHandle( pi.hProcess );
     CloseHandle( pi.hThread );
     result := True;
end;
procedure CDBase.ReBootPrg;
var
    hproc, htoken: THandle;
    ht      : cardinal;
    luid    : int64;
    luidattr: LUID_AND_ATTRIBUTES;
    priv    : Token_Privileges;
    r   : DWORD;
    res : BOOL;
    dal : LongBool;
    buf : PChar;
begin

    hProc:=GetCurrentProcess;
    hToken:=0;
    OpenProcessToken(hProc, TOKEN_ADJUST_PRIVILEGES, hToken);
    LookupPrivilegeValue(nil, 'SeShutDownPrivilege', luid);
    luidattr.Luid       := luid;
    luidattr.Attributes := SE_PRIVILEGE_ENABLED;
    priv.PrivilegeCount := 1;
    priv.Privileges[0]  := luidattr;
    r:=0;
    res:=AdjustTokenPrivileges(hToken, false, priv, 0, nil, r);
    ExitWindowsEx(EWX_REBOOT+EWX_FORCE,0);

    //ExitWindowsEx(EWX_REBOOT,0);
end;
{
  select (MON$PAGE_SIZE * MON$PAGES) SIZE_MB
  from MON$DATABASE
}
function CDBase.GetSizeDB:Integer;
Var
    i,nCount,nSize : Integer;
    strSQL   : String;
Begin
    strSQL := 'SELECT (MON$PAGE_SIZE * MON$PAGES) as nSize FROM MON$DATABASE';
    nSize  := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     nSize := FADOQuery.FieldByName('nSize').AsInteger;
    End;
    CloseQry;
    Result := nSize;
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

{
insert into L3ARCHDATA(M_SWVMID,M_SWTID,M_SWCMDID,M_STIME,M_SFVALUE,M_SBYMASKREAD,M_SBYMASKREREAD)
values(0,3,5,'29.02.2012',0.0,1,1)
}
procedure CDBase.AddToBase;
Var
    strSQL:String;
    nVMID,nTID,nCMDID:Integer;
Begin
    for nVMID:=0 to 17 do
    Begin
    for nTID:=0 to 3 do
    Begin
    for nCMDID:=5 to 8 do
    Begin
    strSQL := 'INSERT INTO L3ARCHDATA'+
              '(M_SWVMID,M_SWTID,M_SWCMDID,M_STIME,M_SFVALUE,M_SBYMASKREAD,M_SBYMASKREREAD)'+
              ' VALUES('+
              IntToStr(nVMID)+','+
              IntToStr(nTID)+','+
              IntToStr(nCMDID)+','+
              ''''+'29.02.2012'+''''+','+
              IntToStr(0)+','+
              IntToStr(1)+','+
              IntToStr(1)+')';
              ExecQry(strSQL);
    End;
    End;
    End;
End;
procedure CDBase.AddToBaseM(dsTIME:TDateTime;nVMID,nTID,nCMDID:Integer;dValue:Double);
Var
    strSQL:String;
Begin
    strSQL := 'INSERT INTO L3ARCHDATA'+
              '(M_SWVMID,M_SWTID,M_SWCMDID,M_STIME,M_SFVALUE,M_SBYMASKREAD,M_SBYMASKREREAD)'+
              ' VALUES('+
              IntToStr(nVMID)+','+
              IntToStr(nTID)+','+
              IntToStr(nCMDID)+','+
              ''''+DateTimeToStr(dsTIME)+''''+','+
              FloatToStr(dValue)+','+
              IntToStr(1)+','+
              IntToStr(1)+')';
              ExecQry(strSQL);
End;

function CDBase.GetL1Table(var pTable:SL1INITITAG):Boolean;
Var
    i,nCount : Integer;
    res      : Boolean;
    strSQL   : String;
Begin
    strSQL := 'SELECT * FROM L1TAG ORDER BY m_sbyPortID';
    pTable.Count := 0;
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
      m_sbyKTRout   := FieldByName('m_sbyKTRout').AsInteger;
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
      m_nFreePort   := FieldByName('m_nFreePort').AsInteger;
      Inc(i);
      Next;
     End;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;


function CDBase.GetL1TableIndex(var pTable:SL1INITITAG;Index:Integer):Boolean;
Var
    i,nCount : Integer;
    res      : Boolean;
    strSQL   : String;
Begin
    strSQL := 'SELECT * FROM L1TAG where m_sbyPortID = ' + IntToStr(Index) + ' ORDER BY m_sbyPortID';
    pTable.Count := 0;
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
      m_sbyKTRout   := FieldByName('m_sbyKTRout').AsInteger;
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
      m_nFreePort   := FieldByName('m_nFreePort').AsInteger;
      Inc(i);
      Next;
     End;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetSL2PULLDS(var pTable:SL2PULLDSS):Boolean;
Var
    i,nCount : Integer;
    res      : Boolean;
    strSQL   : String;
Begin
    strSQL := 'SELECT * FROM L2PULLS ORDER BY ID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      ID          := FieldByName('ID').AsInteger;
      PULLTYPE    := FieldByName('PULLTYPE').AsString;
      DESCRIPTION := FieldByName('DESCRIPTION').AsString;
      Inc(i);
      Next;
     End;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.addSL2PULLDS(pTable:SL2PULLDS):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
    id := -1;
    if(pTable.ID=-1) then strMatch := 'matching (PULLTYPE,DESCRIPTION)' else
    Begin
     keyField := 'ID,';
     keyData  := IntToStr(pTable.ID)+',';
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L2PULLS'+
              '('+keyField+'PULLTYPE,DESCRIPTION)'+
              ' VALUES('+keyData+
              ''''+PULLTYPE+''''+ ','+
              ''''+DESCRIPTION+''''+ ') '+strMatch;
    End;
    ExecQry(strSQL);
    Result := id;
End;
function CDBase.delSL2PULLDS(id:Integer):Boolean;
Var
    strSQL,sqlQ : String;
Begin
    if (id<>-1) then sqlQ := ' WHERE ID='+IntToStr(id);
    strSQL := 'DELETE FROM L2PULLS'+sqlQ;
    Result := ExecQry(strSQL);
End;
function CDBase.addSL2PULL(pTable:SL2PULL):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
    id := -1;
    if(pTable.ID=-1) then strMatch := 'matching (PULLID,PORTID)' else
    Begin
     keyField := 'ID,';
     keyData  := IntToStr(pTable.ID)+',';
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L2PULL'+
              '('+keyField+'PULLID,PORTID,CONNECTIONTIMEOUT,RECONNECTIONS,CONNSTRING,STATE)'+
              ' VALUES('+keyData+
              IntToStr(PULLID)+','+
              IntToStr(PORTID)+','+
              IntToStr(CONNECTIONTIMEOUT)+','+
              IntToStr(RECONNECTIONS)+','+
              ''''+CONNSTRING+''''+ ','+
              IntToStr(STATE)+ ') '+strMatch;
    End;
    ExecQry(strSQL);
    Result := id;
End;
function CDBase.delSL2PULL(idpk,idfk:Integer):Boolean;
Var
    strSQL : String;
Begin
    if(idpk<>-1) then strSQL := 'DELETE FROM L2PULL WHERE ID='+IntToStr(idpk);
    if(idpk=-1)  then strSQL := 'DELETE FROM L2PULL WHERE PULLID='+IntToStr(idfk);
    Result := ExecQry(strSQL);
End;
function CDBase.GetSL2PULL(pullID:Integer; var pTable:SL2PULLS):Boolean;
Var
    i,nCount : Integer;
    res      : Boolean;
    strSQL   : String;
Begin
    res:=false;
    strSQL := 'SELECT * FROM L2PULL where PULLID='+IntToStr(pullID);
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      ID               := FieldByName('ID').AsInteger;
      PULLID           := FieldByName('PULLID').AsInteger;
      PORTID           := FieldByName('PORTID').AsInteger;
      CONNECTIONTIMEOUT:= FieldByName('CONNECTIONTIMEOUT').AsInteger;
      CONNSTRING       := FieldByName('CONNSTRING').AsString;
      RECONNECTIONS    := FieldByName('RECONNECTIONS').AsInteger;
      STATE            := FieldByName('STATE').AsInteger;
      Inc(i);
      Next;
     End;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;
{
SL2PULLDS = packed record
     ID             : INTEGER;
     PULLTYPE       : String[20];
     DESCRIPTION    : String[50];
    end;
    SL2PULLDSS = packed record
     count          : Integer;
     items          : array of SL2PULLDS;
    end;

    SL2PULL = packed record
     ID                : INTEGER;
     PULLID            : INTEGER;
     CONNECTIONTIMEOUT : INTEGER;
     CONNSTRING        : String[50];
     RECONNECTIONS     : INTEGER;
     STATE             : SMALLINT;
    end;
    SL2PULLS = packed record
     count             : Integer;
     items             : array of SL2PULL;
    end;
function CDBDynamicConn.getPulls(var pull:TThreadList):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    pullList : TThreadList;
    pl       : CL2Pulls;
    pList    : TList;
Begin
    res := False;
    strSQL := 'SELECT * FROM L2PULLS';
    if OpenQry(strSQL,nCount)=True then
    Begin
     pullList := TThreadList.Create;
     res := True;
     while not FADOQuery.Eof do Begin
      pl := CL2Pulls.Create;
     with FADOQuery do  Begin
      pl.ID          := FieldByName('ID').AsInteger;
      pl.PULLTYPE    := FieldByName('PULLTYPE').AsString;
      pl.DESCRIPTION := FieldByName('DESCRIPTION').AsString;
      Next;
      pullList.LockList.Add(pl);
      pullList.UnLockList;
      End;
     End;
    End;
    CloseQry;
    pList := pullList.LockList;
    try
    for i:=0 to pList.Count-1 do
    Begin
     CL2Pulls(pList[i]).item := TThreadList.Create;
     getPullByID((CL2Pulls(pList[i])).id,CL2Pulls(pList[i]).item);
     pull.LockList.add(pList[i]);
     pull.UnLockList;
    End;
    finally
     pullList.UnLockList;
    end;
    Result := res;
End;
{
    ID                 INTEGER NOT NULL,
    PULLID             INTEGER NOT NULL,
    CONNECTIONTIMEOUT  INTEGER,
    CONNSTRING         VARCHAR(50),
    RECONNECTIONS      INTEGER,
    STATE              SMALLINT
}


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
      m_sbyKTRout   := FieldByName('m_sbyKTRout').AsInteger;
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
      m_nFreePort   := FieldByName('m_nFreePort').AsInteger;
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
      m_sbyKTRout   := FieldByName('m_sbyKTRout').AsInteger;
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
      m_nFreePort   := FieldByName('m_nFreePort').AsInteger;
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

function CDBase.isL2Init(nPortID : Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM L1TAG'+
    ' WHERE m_sbyPortID='+IntToStr(nPortID)+
    ' AND M_ISL2INIT=1';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.setL2Init(nPortID,value : Integer):Boolean;
Var
    strSQL   : String;
Begin
    if(nPortID<>-1) then
    strSQL := 'UPDATE L1TAG SET M_ISL2INIT='+IntToStr(value)+' WHERE m_sbyPortID='+IntToStr(nPortID) else
    strSQL := 'UPDATE L1TAG SET M_ISL2INIT='+IntToStr(value);
    Result := ExecQry(strSQL);
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
              ',m_sbyKTRout=' +IntToStr(m_sbyKTRout)+
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
              ',m_nFreePort='+IntToStr(m_nFreePort)+
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
              '(m_sbyPortID,m_schName,m_sbyPortNum,m_sbyType,m_sbyProtID,m_sbyControl,m_sbyKTRout,'+
              'm_sbySpeed,m_sbyParity,m_sbyData,m_sbyStop,'+
              'm_swDelayTime,m_swAddres,m_sblReaddres,m_nFreePort,m_schPhone,m_swIPPort,m_schIPAddr)'+
              ' VALUES('+
              IntToStr(m_sbyPortID)  +','+
              ''''+m_schName   +'''' +','+
              IntToStr(m_sbyPortNum) +','+
              IntToStr(m_sbyType)    +','+
              IntToStr(m_sbyProtID)  +','+
              IntToStr(m_sbyControl) +','+
              IntToStr(m_sbyKTRout) +','+
              IntToStr(m_sbySpeed)   +','+
              IntToStr(m_sbyParity)  +','+
              IntToStr(m_sbyData)    +','+
              IntToStr(m_sbyStop)    +','+
              IntToStr(m_swDelayTime)+','+
              IntToStr(m_swAddres)   +','+
              IntToStr(m_sblReaddres)+','+
              IntToStr(m_nFreePort)+','+
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
      m_sbyTSlice    := FieldByName('m_sbyTSlice').AsInteger;
      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sbyModem     := FieldByName('m_sbyModem').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_swMinNKan    := FieldByName('m_swMinNKan').AsInteger;
      m_swMaxNKan    := FieldByName('m_swMaxNKan').AsInteger;
      m_sdtSumKor    := FieldByName('m_sdtSumKor').AsDateTime;
      m_sdtLimKor    := FieldByName('m_sdtLimKor').AsDateTime;
      m_sdtPhLimKor  := FieldByName('m_sdtPhLimKor').AsDateTime;
      m_sAdvDiscL2Tag:= FieldByName('m_sAdvDiscL2Tag').AsString;
      m_sbyStBlock   := FieldByName('m_sbyStBlock').AsInteger;
      m_sTariffs     := FieldByName('m_sTariffs').AsString;
      m_bySynchro    := FieldByName('m_bySynchro').AsInteger;
      m_swKE         := FieldByName('m_swKE').AsInteger;
      m_sAD.m_sbyNSEnable := FieldByName('m_sbyNSEnable').AsInteger;
      m_sAD.m_sdwFMark    := FieldByName('m_sdwFMark').AsInteger;
      m_sAD.m_sdwEMark    := FieldByName('m_sdwEMark').AsInteger;
      m_sAD.m_sdwRetrans  := FieldByName('m_sdwRetrans').AsInteger;
      m_sAD.m_sdwKommut   := FieldByName('m_sdwKommut').AsInteger;
      m_sAD.m_sdwDevice   := FieldByName('m_sdwDevice').AsInteger;
      m_sAD.m_sbySpeed    := FieldByName('m_sbySpeed').AsInteger;
      m_sAD.m_sbyParity   := FieldByName('m_sbyParity').AsInteger;
      m_sAD.m_sbyStop     := FieldByName('m_sbyStop').AsInteger;
      m_sAD.m_sbyKBit     := FieldByName('m_sbyKBit').AsInteger;
      m_sAD.m_sbyPause    := FieldByName('m_sbyPause').AsInteger;
      m_sAD.m_nB0Timer    := FieldByName('m_nB0Timer').AsInteger;
      m_sAktEnLose   := FieldByName('m_sAktEnLose').AsFloat;
      m_sReaEnLose   := FieldByName('m_sReaEnLose').AsFloat;
      m_sTranAktRes  := FieldByName('m_sTranAktRes').AsFloat;
      m_sTranReaRes  := FieldByName('m_sTranReaRes').AsFloat;
      m_sGrKoeff     := FieldByName('m_sGrKoeff').AsInteger;
      m_sTranVolt    := FieldByName('m_sTranVolt').AsInteger;
      m_sTpNum       := FieldByName('m_sTpNum').AsString;
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
      m_sbyTSlice    := FieldByName('m_sbyTSlice').AsInteger;
      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sbyModem     := FieldByName('m_sbyModem').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_swMinNKan    := FieldByName('m_swMinNKan').AsInteger;
      m_swMaxNKan    := FieldByName('m_swMaxNKan').AsInteger;
      m_sdtSumKor    := FieldByName('m_sdtSumKor').AsDateTime;
      m_sdtLimKor    := FieldByName('m_sdtLimKor').AsDateTime;
      m_sdtPhLimKor  := FieldByName('m_sdtPhLimKor').AsDateTime;
      m_sAdvDiscL2Tag:= FieldByName('m_sAdvDiscL2Tag').AsString;
      m_sbyStBlock   := FieldByName('m_sbyStBlock').AsInteger;
      m_sTariffs     := FieldByName('m_sTariffs').AsString;
      m_bySynchro    := FieldByName('m_bySynchro').AsInteger;
      m_swKE         := FieldByName('m_swKE').AsInteger;
      m_sAktEnLose   := FieldByName('m_sAktEnLose').AsFloat;
      m_sReaEnLose   := FieldByName('m_sReaEnLose').AsFloat;
      m_sTranAktRes  := FieldByName('m_sTranAktRes').AsFloat;
      m_sTranReaRes  := FieldByName('m_sTranReaRes').AsFloat;
      m_sGrKoeff     := FieldByName('m_sGrKoeff').AsInteger;
      m_sTranVolt    := FieldByName('m_sTranVolt').AsInteger;
      m_sTpNum       := FieldByName('m_sTpNum').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;
{
' m_schName='    +''''+m_schName+''''+
              ',m_sbyPortNum=' +IntToStr(m_sbyPortNum)+
              ',m_sbyType='    +IntToStr(m_sbyType)+
              ',m_sbyProtID='  +IntToStr(m_sbyProtID)+
              ',m_sbyControl=' +IntToStr(m_sbyControl)+
              ',m_sbyKTRout=' +IntToStr(m_sbyKTRout)+
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
              ',m_nFreePort='+IntToStr(m_nFreePort)+
}
function CDBase.GetMetersTable(nChannel:Integer;var pTable:SL2INITITAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nChannel<>-1 then strSQL := 'SELECT * FROM L2TAG WHERE M_SWABOID='+IntToStr(nChannel)+ ' ORDER BY cast(m_swMID as int)';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmMeter := nCount;
     SetLength(pTable.m_sMeter,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sMeter[i] do  Begin
      //m_sbyID        := FieldByName('m_sbyProtID').AsInteger;
      //m_sbyGroupID   := FieldByName('m_swAddres').AsInteger;
      m_swMID        := FieldByName('m_swMID').AsInteger;
      //m_swVMID       := FieldByName('m_sblReaddres').AsInteger;
      //m_sbyKTRout    := FieldByName('m_sbyKTRout').AsInteger;
      pullid         := FieldByName('pullid').AsInteger;
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
      m_sbyPrecision := FieldByName('m_sbyPrecision').AsInteger;
      m_swCurrQryTm  := FieldByName('m_swCurrQryTm').AsInteger;
      m_sbyTSlice    := FieldByName('m_sbyTSlice').AsInteger;
      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sbyModem     := FieldByName('m_sbyModem').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_swMinNKan    := FieldByName('m_swMinNKan').AsInteger;
      m_swMaxNKan    := FieldByName('m_swMaxNKan').AsInteger;
      m_sdtSumKor    := FieldByName('m_sdtSumKor').AsDateTime;
      m_sdtLimKor    := FieldByName('m_sdtLimKor').AsDateTime;
      m_sdtPhLimKor  := FieldByName('m_sdtPhLimKor').AsDateTime;
      m_sAdvDiscL2Tag:= FieldByName('m_sAdvDiscL2Tag').AsString;
      m_sbyStBlock   := FieldByName('m_sbyStBlock').AsInteger;
      m_sTariffs     := FieldByName('m_sTariffs').AsString;
      m_bySynchro    := FieldByName('m_bySynchro').AsInteger;
      m_swKE         := FieldByName('m_swKE').AsInteger;
      m_sAD.m_sbyNSEnable := FieldByName('m_sbyNSEnable').AsInteger;
      m_sAD.m_sdwFMark    := FieldByName('m_sdwFMark').AsInteger;
      m_sAD.m_sdwEMark    := FieldByName('m_sdwEMark').AsInteger;
      m_sAD.m_sdwRetrans  := FieldByName('m_sdwRetrans').AsInteger;
      m_sAD.m_sdwKommut   := FieldByName('m_sdwKommut').AsInteger;
      m_sAD.m_sdwDevice   := FieldByName('m_sdwDevice').AsInteger;
      m_sAD.m_sbySpeed    := FieldByName('m_sbySpeed').AsInteger;
      m_sAD.m_sbyParity   := FieldByName('m_sbyParity').AsInteger;
      m_sAD.m_sbyStop     := FieldByName('m_sbyStop').AsInteger;
      m_sAD.m_sbyKBit     := FieldByName('m_sbyKBit').AsInteger;
      m_sAD.m_sbyPause    := FieldByName('m_sbyPause').AsInteger;
      m_sAD.m_nB0Timer    := FieldByName('m_nB0Timer').AsInteger;
      m_sAktEnLose   := FieldByName('m_sAktEnLose').AsFloat;
      m_sReaEnLose   := FieldByName('m_sReaEnLose').AsFloat;
      m_sTranAktRes  := FieldByName('m_sTranAktRes').AsFloat;
      m_sTranReaRes  := FieldByName('m_sTranReaRes').AsFloat;
      m_sGrKoeff     := FieldByName('m_sGrKoeff').AsInteger;
      m_sTranVolt    := FieldByName('m_sTranVolt').AsInteger;
      m_sTpNum       := FieldByName('m_sTpNum').AsString;
      TYPEPU         := FieldByName('TYPEPU').AsInteger;
      TYPEZVAZ       := FieldByName('TYPEZVAZ').AsString;
      TYPEABO        := FieldByName('TYPEABO').AsString;
      m_aid_channel  := FieldByName('M_SWABOID_CHANNEL').AsInteger;
      m_aid_tariff   := FieldByName('M_SWABOID_TARIFF').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;
function CDBase.GetMetersTableLC(nChannel,nLocation:Integer;var pTable:SL2INITITAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM L2TAG WHERE m_sbyPortID='+IntToStr(nChannel)+
    ' AND m_sbyLocation='+IntToStr(nLocation)+
    ' AND m_sbyEnable=1'+
    ' ORDER BY m_swMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmMeter := nCount;
     SetLength(pTable.m_sMeter,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sMeter[i] do  Begin
      m_swMID        := FieldByName('m_swMID').AsInteger;       //
      m_sbyType      := FieldByName('m_sbyType').AsInteger;     //
      m_sbyLocation  := FieldByName('m_sbyLocation').AsInteger; //
      m_sddFabNum    := FieldByName('m_sddFabNum').AsString;    //
      m_schPassword  := FieldByName('m_schPassword').AsString;  //
      m_sddPHAddres  := FieldByName('m_sddPHAddres').AsString;  //
      m_schName      := FieldByName('m_schName').AsString;      //
      m_sbyPortID    := FieldByName('m_sbyPortID').AsInteger;   //
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
      m_sbyPrecision := FieldByName('m_sbyPrecision').AsInteger;
      m_swCurrQryTm  := FieldByName('m_swCurrQryTm').AsInteger;
      m_sbyTSlice    := FieldByName('m_sbyTSlice').AsInteger;
      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sbyModem     := FieldByName('m_sbyModem').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_swMinNKan    := FieldByName('m_swMinNKan').AsInteger;
      m_swMaxNKan    := FieldByName('m_swMaxNKan').AsInteger;
      m_sdtSumKor    := FieldByName('m_sdtSumKor').AsDateTime;
      m_sdtLimKor    := FieldByName('m_sdtLimKor').AsDateTime;
      m_sdtPhLimKor  := FieldByName('m_sdtPhLimKor').AsDateTime;
      m_sAdvDiscL2Tag:= FieldByName('m_sAdvDiscL2Tag').AsString;
      m_sbyStBlock   := FieldByName('m_sbyStBlock').AsInteger;
      m_sTariffs     := FieldByName('m_sTariffs').AsString;
      m_bySynchro    := FieldByName('m_bySynchro').AsInteger;
      m_swKE         := FieldByName('m_swKE').AsInteger;
      m_sAD.m_sbyNSEnable := FieldByName('m_sbyNSEnable').AsInteger;
      m_sAD.m_sdwFMark    := FieldByName('m_sdwFMark').AsInteger;
      m_sAD.m_sdwEMark    := FieldByName('m_sdwEMark').AsInteger;
      m_sAD.m_sdwRetrans  := FieldByName('m_sdwRetrans').AsInteger;
      m_sAD.m_sdwKommut   := FieldByName('m_sdwKommut').AsInteger;
      m_sAD.m_sdwDevice   := FieldByName('m_sdwDevice').AsInteger;
      m_sAD.m_sbySpeed    := FieldByName('m_sbySpeed').AsInteger;
      m_sAD.m_sbyParity   := FieldByName('m_sbyParity').AsInteger;
      m_sAD.m_sbyStop     := FieldByName('m_sbyStop').AsInteger;
      m_sAD.m_sbyKBit     := FieldByName('m_sbyKBit').AsInteger;
      m_sAD.m_sbyPause    := FieldByName('m_sbyPause').AsInteger;
      m_sAD.m_nB0Timer    := FieldByName('m_nB0Timer').AsInteger;
      m_sAktEnLose   := FieldByName('m_sAktEnLose').AsFloat;
      m_sReaEnLose   := FieldByName('m_sReaEnLose').AsFloat;
      m_sTranAktRes  := FieldByName('m_sTranAktRes').AsFloat;
      m_sTranReaRes  := FieldByName('m_sTranReaRes').AsFloat;
      m_sGrKoeff     := FieldByName('m_sGrKoeff').AsInteger;
      m_sTranVolt    := FieldByName('m_sTranVolt').AsInteger;
      m_sTpNum       := FieldByName('m_sTpNum').AsString;
     End;
     res := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetMMeterTable(nIndex:Integer;var pTable:SL2TAG):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    strSQL := 'SELECT * FROM L2TAG WHERE m_swMID='+IntToStr(nIndex);
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do  Begin
      m_sbyID        := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID   := FieldByName('m_sbyGroupID').AsInteger;
      m_swMID        := FieldByName('m_swMID').AsInteger;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_sbyPortID    := FieldByName('m_sbyPortID').AsInteger;
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
      m_sbyPrecision := FieldByName('m_sbyPrecision').AsInteger;
      m_swCurrQryTm  := FieldByName('m_swCurrQryTm').AsInteger;
      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sbyTSlice    := FieldByName('m_sbyTSlice').AsInteger;
      m_sbyModem     := FieldByName('m_sbyModem').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_swMinNKan    := FieldByName('m_swMinNKan').AsInteger;
      m_swMaxNKan    := FieldByName('m_swMaxNKan').AsInteger;
      m_sdtSumKor    := FieldByName('m_sdtSumKor').AsDateTime;
      m_sdtLimKor    := FieldByName('m_sdtLimKor').AsDateTime;
      m_sdtPhLimKor  := FieldByName('m_sdtPhLimKor').AsDateTime;
      m_sAdvDiscL2Tag:= FieldByName('m_sAdvDiscL2Tag').AsString;
      m_sbyStBlock   := FieldByName('m_sbyStBlock').AsInteger;
      m_sTariffs     := FieldByName('m_sTariffs').AsString;
      m_bySynchro    := FieldByName('m_bySynchro').AsInteger;
      m_swKE         := FieldByName('m_swKE').AsInteger;
      m_sAD.m_sbyNSEnable := FieldByName('m_sbyNSEnable').AsInteger;
      m_sAD.m_sdwFMark    := FieldByName('m_sdwFMark').AsInteger;
      m_sAD.m_sdwEMark    := FieldByName('m_sdwEMark').AsInteger;
      m_sAD.m_sdwRetrans  := FieldByName('m_sdwRetrans').AsInteger;
      m_sAD.m_sdwKommut   := FieldByName('m_sdwKommut').AsInteger;
      m_sAD.m_sdwDevice   := FieldByName('m_sdwDevice').AsInteger;
      m_sAD.m_sbySpeed    := FieldByName('m_sbySpeed').AsInteger;
      m_sAD.m_sbyParity   := FieldByName('m_sbyParity').AsInteger;
      m_sAD.m_sbyStop     := FieldByName('m_sbyStop').AsInteger;
      m_sAD.m_sbyKBit     := FieldByName('m_sbyKBit').AsInteger;
      m_sAD.m_sbyPause    := FieldByName('m_sbyPause').AsInteger;
      m_sAD.m_nB0Timer    := FieldByName('m_nB0Timer').AsInteger;
      m_sAktEnLose   := FieldByName('m_sAktEnLose').AsFloat;
      m_sReaEnLose   := FieldByName('m_sReaEnLose').AsFloat;
      m_sTranAktRes  := FieldByName('m_sTranAktRes').AsFloat;
      m_sTranReaRes  := FieldByName('m_sTranReaRes').AsFloat;
      m_sGrKoeff     := FieldByName('m_sGrKoeff').AsInteger;
      m_sTranVolt    := FieldByName('m_sTranVolt').AsInteger;
      m_sTpNum       := FieldByName('m_sTpNum').AsString;
      m_aid_channel  := FieldByName('M_SWABOID_CHANNEL').AsInteger;
      m_aid_tariff   := FieldByName('M_SWABOID_TARIFF').AsInteger;
      m_sddHOUSE     := FieldByName('M_SDDHADR_HOUSE').AsString;
      m_sddKV        := FieldByName('M_SDDHADR_KV').AsString;
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

function CDBase.GetMeterLocation(FMID:Integer;var FLocation,PHAddres:Integer):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL,str : String;
Begin
    res := False;
    strSQL := 'SELECT m_sbyLocation,m_sddPHAddres FROM L2TAG WHERE m_swMID='+IntToStr(FMID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     PHAddres  := 0;
     FLocation := FADOQuery.FieldByName('m_sbyLocation').AsInteger;
     str       := FADOQuery.FieldByName('m_sddPHAddres').AsString;
     if (str<>'') and (Length(str) < 12) then PHAddres := StrToInt(str);
     res := True;
    End;
    CloseQry;
    Result := res;
End;
{
SL3VMETERTAG = packed record
     m_swID          : Word;
     m_swMID         : WORD;
     m_sbyPortID     : WORD;
     m_sbyType       : WORD;
     m_sbyGroupID    : Byte;
     m_swVMID        : WORD;
     m_swAmParams    : WORD;
     m_sbyExport     : Byte;
     m_sbyEnable     : Byte;
     m_sddPHAddres   : string[30];
     m_sMeterName    : String[100];
     m_sVMeterName   : String[100];
     ItemCh          : SL3CHANDGES;
     Item            : SL3PARAMSS;
    end;
}
function CDBase.GetMeterType(FVMID:Integer;var nTypeID,swPLID:Integer):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT m_sbyType,m_swPLID FROM SL3VMETERTAG WHERE m_swVMID='+IntToStr(FVMID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     nTypeID := FADOQuery.FieldByName('m_sbyType').AsInteger;
     swPLID  := FADOQuery.FieldByName('m_swPLID').AsInteger;
     res := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetMeterPortID(FMID:Integer;var sbyPortID:Integer):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT m_sbyPortID FROM L2TAG WHERE m_swMID='+IntToStr(FMID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     sbyPortID := FADOQuery.FieldByName('m_sbyPortID').AsInteger;
     res := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetDistTag(FMID:Integer):String;
Var
    nCount : Integer;
    strSQL : String;
Begin
    result := '';
    strSQL := 'SELECT m_sAdvDiscL2Tag FROM L2TAG WHERE m_swMID='+IntToStr(FMID);
    if OpenQry(strSQL,nCount)=True then
    result := FADOQuery.FieldByName('m_sAdvDiscL2Tag').AsString;
    CloseQry;
End;
function CDBase.GetMeterPort(FMID:Integer;var FPortType,FPortID:Byte):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    strSQL := 'SELECT m_sbyType,m_sbyPortID FROM L1TAG WHERE L1TAG.m_sbyPortID=(SELECT L2TAG.m_sbyPortID FROM L2TAG WHERE L2TAG.m_swMID='+IntToStr(FMID)+')';
    if OpenQry(strSQL,nCount)=True then
    Begin
     FPortType := FADOQuery.FieldByName('m_sbyType').AsInteger;
     FPortID   := FADOQuery.FieldByName('m_sbyPortID').AsInteger;
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
              ',m_sbyPrecision='+IntToStr(m_sbyPrecision)+
              ',m_swCurrQryTm=' +IntToStr(m_swCurrQryTm)+
              ',m_sbyTSlice='   +IntToStr(m_sbyTSlice)+
              ',m_sPhone='      +''''+m_sPhone+''''+
              ',m_sbyModem='    +IntToStr(m_sbyModem)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ',m_swMinNKan='   +IntToStr(m_swMinNKan) +
              ',m_swMaxNKan='   +IntToStr(m_swMaxNKan) +
              ',m_sdtSumKor='   + '''' + DateTimeToStr(m_sdtSumKor) + '''' +
              ',m_sdtLimKor='   + '''' + DateTimeToStr(m_sdtLimKor) + '''' +
              ',m_sdtPhLimKor='  + '''' + DateTimeToStr(m_sdtPhLimKor) + '''' +
              ',m_sAdvDiscL2Tag=' + '''' + m_sAdvDiscL2Tag + '''' +
              ',m_sbyStBlock='  +IntToStr(m_sbyStBlock) +
              ',m_sTariffs='    + '''' + m_sTariffs + '''' +
              ',m_bySynchro='   +IntToStr(m_bySynchro) +
              ',m_swKE='        +IntToStr(m_swKE) +
              ',m_sbyNSEnable=' +IntToStr(m_sAD.m_sbyNSEnable) +
              ',m_sdwFMark='    +IntToStr(m_sAD.m_sdwFMark) +
              ',m_sdwEMark='    +IntToStr(m_sAD.m_sdwEMark) +
              ',m_sdwRetrans='  +IntToStr(m_sAD.m_sdwRetrans) +
              ',m_sdwKommut='   +IntToStr(m_sAD.m_sdwKommut) +
              ',m_sdwDevice='   +IntToStr(m_sAD.m_sdwDevice) +
              ',m_sbySpeed='    +IntToStr(m_sAD.m_sbySpeed) +
              ',m_sbyParity='   +IntToStr(m_sAD.m_sbyParity) +
              ',m_sbyStop='     +IntToStr(m_sAD.m_sbyStop) +
              ',m_sbyKBit='     +IntToStr(m_sAD.m_sbyKBit) +
              ',m_sbyPause='    +IntToStr(m_sAD.m_sbyPause) +
              ',m_nB0Timer='    +IntToStr(m_sAD.m_nB0Timer) +
              ',m_sAktEnLose='  +FloatToStr(m_sAktEnLose) +
              ',m_sReaEnLose='  +FloatToStr(m_sReaEnLose) +
              ',m_sTranAktRes=' +FloatToStr(m_sTranAktRes) +
              ',m_sTranReaRes=' +FloatToStr(m_sTranReaRes) +
              ',m_sGrKoeff='    +IntToStr(m_sGrKoeff) +
              ',m_sTranVolt='   +IntToStr(m_sTranVolt) +
              ',m_sTpNum='      +'''' + m_sTpNum + '''' +
              ',M_SWABOID_CHANNEL='   +IntToStr(m_aid_channel) +
              ',M_SWABOID_TARIFF='   +IntToStr(m_aid_tariff) +
              ',M_SDDHADR_HOUSE=' +''''+m_sddHOUSE+''''+
              ',M_SDDHADR_KV='    +''''+m_sddKV+''''+
              ' WHERE m_swMID='+IntToStr(m_swMID);
              //' WHERE m_sbyPortID='+IntToStr(m_sbyPortID)+' and '+'m_swMID='+IntToStr(m_swMID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.SetTimeLimit(nMID:Integer;m_sdtSumKor,m_sdtLimKor,m_sdtPhLimKor:TDateTime):Boolean;
Var
    strSQL   : String;
BEgin
    strSQL := 'UPDATE L2TAG SET '+
              ' m_sdtSumKor='   + '''' + DateTimeToStr(m_sdtSumKor) + '''' +
              ',m_sdtLimKor='   + '''' + DateTimeToStr(m_sdtLimKor) + '''' +
              ',m_sdtPhLimKor='  + '''' + DateTimeToStr(m_sdtPhLimKor) + '''' +
              ' WHERE m_swMID='+IntToStr(nMID);
   Result := ExecQry(strSQL);
End;
{
    strSQL := 'select * from l2tag where (not(m_sbyType=8 or m_sbyType=9)) and m_swMID in (select m_swMID from sl3vmetertag where m_sbyGroupID in ' +
              ' (select M_SBYGROUPID from sl3grouptag where m_swABOID = ' + IntToStr(ABOID) + '))';

}
function CDBase.SetMeterType(nAID,nPID:Integer;nType:Byte):Boolean;
Var
    strSQL   : String;
BEgin
    strSQL := 'UPDATE L2TAG SET '+
              ' m_sbyType='   + IntToStr(nType) +
              ' WHERE m_sbyPortID='+IntToStr(nPID);
    Result := ExecQry(strSQL);
    strSQL := 'UPDATE sl3vmetertag SET '+
              ' m_sbyType='   + IntToStr(nType) +
              ' WHERE m_swVMID in (select m_swVMID from sl3vmetertag where m_sbyGroupID in ' +
              ' (select M_SBYGROUPID from sl3grouptag where m_swABOID = ' + IntToStr(nAID) + '))';
    Result := ExecQry(strSQL);
End;
function CDBase.SetSynchroChnl(nMID:Integer;bySynchro:Byte):Boolean;
Var
    strSQL   : String;
BEgin
    strSQL := 'UPDATE L2TAG SET '+
              ' m_bySynchro='  +IntToStr(bySynchro) +
              ' WHERE m_swMID='+IntToStr(nMID);
   Result := ExecQry(strSQL);
End;
function CDBase.SetL2TAG_FN_AD_KI_KU(swMID:Integer;sddFabNum,sddPHAddres:String;sfKI,sfKU:Double):Boolean;
Var
    strSQL   : String;
BEgin
    strSQL := 'UPDATE L2TAG SET '+
              ' m_sddFabNum='   +''''+sddFabNum+''''+
              ',m_sddPHAddres=' +''''+sddPHAddres+''''+
              ',m_sfKI='        +FloatToStr(sfKI)+
              ',m_sfKU='        +FloatToStr(sfKU)+
              ' WHERE m_swMID='+IntToStr(swMID);
    Result := ExecQry(strSQL);
End;

function CDBase.Exclude_VMeter(nMID,nVMID:integer):Boolean;
var
    m_sbyEnable,m_sbyModem:Byte;
    strSQL   : String;
Begin
    m_sbyEnable := 0;
    m_sbyModem  := 0;
    strSQL := 'execute block as begin' +
              ' UPDATE L2TAG SET'+
              ' m_sbyModem='    +IntToStr(m_sbyModem)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ' WHERE m_swMID=' +IntToStr(nMID)+
              ' and not (m_sbyType=8 or m_sbyType=9 or m_sbyType=23);'+
              ' UPDATE SL3VMETERTAG SET '+
              ' M_SBYENABLE='   +IntToStr(m_sbyEnable)+
              ' WHERE M_SWMID=' +IntToStr(nMID)+
              ' and M_SWVMID=' +IntToStr(nVMID)+';end;';
   Result := ExecQry(strSQL);
End;

function CDBase.Include_VMeter(nMID,nVMID:integer):Boolean;
var
    byPortID,byPortType,m_sbyEnable,m_sbyModem:Byte;
    strSQL : String;
BEgin
    m_sbyEnable := 1;
    m_sbyModem  := 0;
    if GetMeterPort(nMID,byPortType,byPortID)=True then
    Begin
    if byPortType=DEV_COM_GSM then m_sbyModem:=1;
    strSQL := 'execute block as begin' +
              ' UPDATE L2TAG SET'+
              ' m_sbyModem='    +IntToStr(m_sbyModem)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ' WHERE m_swMID=' +IntToStr(nMID)+
              ' and not (m_sbyType=8 or m_sbyType=9 or m_sbyType=23);'+
              ' UPDATE SL3VMETERTAG SET '+
              ' M_SBYENABLE='   +IntToStr(m_sbyEnable)+
              ' WHERE M_SWMID=' +IntToStr(nMID)+
              ' and M_SWVMID=' +IntToStr(nVMID)+';end;';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AutoBlock_VMeter(nVMID:integer):Boolean;
var
    strSQL      : String;
Begin
    {
    strSQL := 'execute block as begin' +
              ' UPDATE SL3PARAMS SET'+
              ' M_SBYLOCKSTATE='+IntToStr(PR_FAIL)+
              ' WHERE M_SWVMID='+IntToStr(nVMID)+
              ' and (M_SWPARAMID>='+IntToStr(QRY_ENERGY_DAY_EP)+' and M_SWPARAMID<=' +IntToStr(QRY_SRES_ENR_RM)+');'+
              ' UPDATE SL3VMETERTAG SET M_SBYEXPORT='+IntToStr(SA_LOCK)+
              ' WHERE M_SWVMID=' +IntToStr(nVMID)+';end;';
    Result := ExecQry(strSQL);
    }
    strSQL := ' UPDATE SL3PARAMS SET'+
              ' M_SBYLOCKSTATE='+IntToStr(PR_FAIL)+
              ' WHERE M_SWVMID='+IntToStr(nVMID)+
              ' and (M_SWPARAMID>='+IntToStr(QRY_ENERGY_DAY_EP)+' and M_SWPARAMID<=' +IntToStr(QRY_SRES_ENR_RM)+')';
    Result := ExecQry(strSQL);
    strSQL := ' UPDATE SL3VMETERTAG SET M_SBYEXPORT='+IntToStr(SA_LOCK)+
              ' WHERE M_SWVMID=' +IntToStr(nVMID);
    Result := ExecQry(strSQL);
End;
function CDBase.AutoUnBlock_VMeter(nVMID:integer):Boolean;
var
    strSQL      : String;
Begin
    {
    strSQL := 'execute block as begin' +
              ' UPDATE SL3PARAMS SET'+
              ' M_SBYLOCKSTATE='+IntToStr(PR_TRUE)+
              ' WHERE M_SWVMID='+IntToStr(nVMID)+
              ' and (M_SWPARAMID>='+IntToStr(QRY_ENERGY_DAY_EP)+' and M_SWPARAMID<=' +IntToStr(QRY_SRES_ENR_RM)+');'+
              ' UPDATE SL3VMETERTAG SET M_SBYEXPORT='+IntToStr(SA_UNLK)+
              ' WHERE M_SWVMID=' +IntToStr(nVMID)+';end;';
    Result := ExecQry(strSQL);
    }
    strSQL := ' UPDATE SL3PARAMS SET'+
              ' M_SBYLOCKSTATE='+IntToStr(PR_TRUE)+
              ' WHERE M_SWVMID='+IntToStr(nVMID)+
              ' and (M_SWPARAMID>='+IntToStr(QRY_ENERGY_DAY_EP)+' and M_SWPARAMID<=' +IntToStr(QRY_SRES_ENR_RM)+')';
    Result := ExecQry(strSQL);
    strSQL := ' UPDATE SL3VMETERTAG SET M_SBYEXPORT='+IntToStr(SA_UNLK)+
              ' WHERE M_SWVMID=' +IntToStr(nVMID);
    Result := ExecQry(strSQL);
End;
function CDBase.CheckValidMeters(strMeters:String):Boolean;
var
    strSQL       : String;
    m_sum,nCount,m_count : Integer;
    res          : Boolean;
Begin
    Result := False;
    strSQL := 'SELECT sum(M_SBYEXPORT) as m_sum, count(1) as m_count'+
              ' FROM SL3VMETERTAG WHERE M_SWVMID IN '+strMeters;
    if OpenQry(strSQL,nCount)=True then
    Begin
     m_sum   := FADOQuery.FieldByName('m_sum').AsInteger;
     m_count := FADOQuery.FieldByName('m_count').AsInteger;
     Result  := (m_sum=m_count);
    End;
    CloseQry;
End;
function CDBase.Exclude_Abon(nAID:Integer):Boolean;
var
    pTable : SL3GROUPTAG;
    i : Integer;
Begin
    Result := ExecQry('UPDATE SL3ABON SET m_sbyEnable=0 WHERE m_swABOID='+IntToStr(nAID));
    if GetAbonMetersTable(nAID,pTable)=True then
    Begin
     with pTable.Item do
     for i:=0 to Count-1 do
     Exclude_VMeter(Items[i].m_swMID,Items[i].m_swVMID);
    End;
End;
function CDBase.Include_Abon(nAID:Integer):Boolean;
var
    pTable : SL3GROUPTAG;
    i : Integer;
Begin
    Result := ExecQry('UPDATE SL3ABON SET m_sbyEnable=1 WHERE m_swABOID='+IntToStr(nAID));
    if GetAbonMetersTable(nAID,pTable)=True then
    Begin
     with pTable.Item do
     for i:=0 to Count-1 do
     Include_VMeter(Items[i].m_swMID,Items[i].m_swVMID);
    End;
End;

function CDBase.UpdateTimeKorr(MID : integer; TimeKorr : TDateTime):boolean;
   var strSQL : string;
begin
   Result := ExecQry('UPDATE L2TAG SET m_sdtSumKor=' + '''' + DateTimeToStr(TimeKorr) + '''' +
                     ' WHERE m_swMID=' + IntToStr(MID));
end;
function CDBase.UpdateTextField(PID:integer;strText:String):boolean;
   var strSQL : string;
begin
   Result := ExecQry('UPDATE L2TAG SET M_SADVDISCL2TAG=' + '''' + strText + '''' +
                     ' WHERE M_SBYPORTID=' + IntToStr(PID));
end;
function CDBase.UpdateTextFieldAID(AID:integer;strText:String):boolean;
   var strSQL : string;
begin
   Result := ExecQry('UPDATE L2TAG SET M_SADVDISCL2TAG=' + '''' + strText + '''' +
                     ' WHERE M_SWABOID=' + IntToStr(AID));
end;
{strSQL := 'SELECT m_swCMDID,m_sTime,m_sfValue,m_swTID,m_CRC '+
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
      m_CRC        := FieldByName('m_CRC').AsInteger;}
function CDBase.SaveNakEnMonth(MID,CMDID,TID : integer; Date:TDateTime; Value :Double):boolean;
var  strSQL         : string;
     nCount, t_VMID : integer;
     res            : boolean;
begin
   strSQL := 'SELECT m_swVMID FROM SL3VMETERTAG WHERE m_swMID='+IntToStr(MID);
   res := false;
   if OpenQryD(strSQL, nCount) then
   begin
     res := true;
     t_VMID := FADOQueryD.FieldByName('m_swVMID').AsInteger;
   end;
   CloseQryD;
   if res then
   begin
      strSQL := 'SELECT * FROM L3ARCHDATA WHERE m_swVMID=' + IntToStr(t_VMID)+
                ' and m_swCMDID='+IntToStr(CMDID)+
                ' and m_swTID='+IntToStr(TID)+
                ' and CAST(m_sTime AS DATE)='+ ''''+DateToStr(Date)+'''';
      res:=false;
      if OpenQryD(strSQL,nCount) then
        if nCount >=1 then
          res := true;
      CloseQryD;
      if not res then
      begin
        strSQL := 'INSERT INTO L3ARCHDATA (m_swVMID,m_swCMDID,m_swTID,m_sTime,m_sfValue)'+
                  'VALUES('+
                  IntToStr(t_VMID)+','+
                  IntToStr(CMDID)+','+
                  IntToStr(TID)+','+
                  ''''+DateTimeToStr(Date)+''''+','+
                  FloatToStr(Value)+')';
        res := ExecQryD(strSQL);
      end;
   end;
   Result := res;
end;

function CDBase.UpdateBlStateMeter(MID, BlState : integer):boolean;
var strSQL : string;
begin
   Result := ExecQry('UPDATE L2TAG SET m_sbyStBlock=' + IntToStr(BlState) +
                     ' WHERE m_swMID=' + IntToStr(MID));
end;
{
m_sbyNSEnable : Byte;
     m_sdwFMark    : DWORD;
     m_sdwEMark    : DWORD;
     m_sdwRetrans  : DWORD;
     m_sdwKommut   : DWORD;
     m_sdwDevice   : DWORD;
     m_sbySpeed    : Byte;
     m_sbyParity   : Byte;
     m_sbyStop     : Byte;
     m_sbyKBit     : Byte;
     m_sbyPause    : Byte;
}
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
              'm_sbyRepMsg,m_swRepTime,m_sfKI,m_sfKU,m_sfMeterKoeff,m_sbyPrecision,'+
              'm_swCurrQryTm,m_sbyTSlice,m_sPhone,m_sbyModem,m_sbyEnable,' +
              'm_swMinNKan, m_swMaxNKan,m_sdtSumKor,m_sdtLimKor,m_sdtPhLimKor,m_bySynchro,m_swKE,'+
              'm_sbyNSEnable,m_sdwFMark,m_sdwEMark,m_sdwRetrans,m_sdwKommut,m_sdwDevice,'+
              'm_sbySpeed,m_sbyParity,m_sbyStop,m_sbyKBit,m_nB0Timer,m_sbyPause,'+
              'm_sAktEnLose,m_sReaEnLose,m_sTranAktRes,m_sTranReaRes,m_sGrKoeff,m_sTranVolt,m_sTpNum)'+
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
              IntToStr(m_sbyPrecision) + ',' +
              IntToStr(m_swCurrQryTm)+ ','+
              IntToStr(m_sbyTSlice) + ',' +
              ''''+m_sPhone +''''+ ','+
              IntToStr(m_sbyModem)+ ',' +
              IntToStr(m_sbyEnable)+ ',' +
              IntToStr(m_swMinNKan) + ',' +
              IntToStr(m_swMaxNKan) + ',' +
              '''' + DateTimeToStr(m_sdtSumKor) + '''' + ',' +
              '''' + DateTimeToStr(m_sdtLimKor) + '''' +  ',' +
              '''' + DateTimeToStr(m_sdtPhLimKor) + '''' + ','+
              IntToStr(m_bySynchro) + ',' +
              IntToStr(m_swKE) + ','+
              IntToStr(m_sAD.m_sbyNSEnable)+ ',' +
              IntToStr(m_sAD.m_sdwFMark)+ ',' +
              IntToStr(m_sAD.m_sdwEMark)+ ',' +
              IntToStr(m_sAD.m_sdwRetrans)+ ',' +
              IntToStr(m_sAD.m_sdwKommut)+ ',' +
              IntToStr(m_sAD.m_sdwDevice)+ ',' +
              IntToStr(m_sAD.m_sbySpeed)+ ',' +
              IntToStr(m_sAD.m_sbyParity)+ ',' +
              IntToStr(m_sAD.m_sbyStop)+ ',' +
              IntToStr(m_sAD.m_sbyKBit)+ ',' +
              IntToStr(m_sAD.m_nB0Timer)+ ',' +
              IntToStr(m_sAD.m_sbyPause)+ ',' +
              FloatToStr(m_sAktEnLose)+ ',' +
              FloatToStr(m_sReaEnLose)+ ',' +
              FloatToStr(m_sTranAktRes)+ ',' +
              FloatToStr(m_sTranReaRes)+ ',' +
              IntToStr(m_sGrKoeff)+ ',' +
              IntToStr(m_sTranVolt) + ',' +
              '''' + m_sTpNum + '''' +
              ')'
    End;
    Result := ExecQry(strSQL);
End;
{
CREATE TABLE MGCONFIG (
    ID        INTEGER,
    RES       VARCHAR(10),
    NASP      VARCHAR(20),
    GORS      VARCHAR(3),
    ULICA     VARCHAR(20),
    DOM       VARCHAR(10),
    KORP      VARCHAR(5),
    KVAR      VARCHAR(5),
    LICS      VARCHAR(15),
    FAM       VARCHAR(15),
    IMYA      VARCHAR(15),
    OTCH      VARCHAR(15),
    ZAVNO     VARCHAR(15),
    TYPEPU    VARCHAR(15),
    TYPEUSPD  VARCHAR(15),
    TYPEZVAZ  VARCHAR(5),
    NOMERDOZ  VARCHAR(20),
    NOMERTU   VARCHAR(5),
    TYPEABO   VARCHAR(10)
);
      res   : String;    //0
      nasp  : String;    //1
      gors  : String;    //2
      ulica : String;    //3
      dom   : String;    //4
      korp  : String;    //5
      kvar  : String;    //6
      lics  : String;    //7
      fam   : String;    //8
      imya  : String;    //9
      otch  : String;    //10
      zavno :  String;   //11
      typepu   : String; //12
      typeuspd : String; //13
      typezvaz : String; //14
      nomerdoz : String; //15
      typeabo  : String; //16
      nomertu : String;  //17
}
function CDBase.getMConfig(offs,sz:Integer;var pTable:TList):Boolean;
Var
    strSQL   : String;
    resl      : Boolean;
    nCount   : Integer;
    pD       : CLoadEntity;
Begin
    resl := False;
    strSQL := 'select * from MGCONFIG '+
    //' where id>='+IntToStr(offs)+' and id<='+IntToStr(offs+sz)+
    ' order by mes,res,NASP,ULICA,dom,KVAR';
    if OpenQryD(strSQL,nCount)=True then
    Begin
     resl := True;
     while not FADOQueryD.Eof do Begin
     pD := CLoadEntity.Create;
     with FADOQueryD,pD do  Begin
      id   := FieldByName('id').AsInteger;
      mes   := FieldByName('mes').AsString;
      res   := FieldByName('res').AsString;
      nasp   := FieldByName('nasp').AsString;
      gors   := FieldByName('gors').AsString;
      ulica   := FieldByName('ulica').AsString;
      dom   := FieldByName('dom').AsString;
      korp   := FieldByName('korp').AsString;
      kvar   := FieldByName('kvar').AsString;
      lics   := FieldByName('lics').AsString;
      fam   := FieldByName('fam').AsString;
      imya   := FieldByName('imya').AsString;
      otch   := FieldByName('otch').AsString;
      zavno   := FieldByName('zavno').AsString;
      typepu   := FieldByName('typepu').AsString;
      typeuspd   := FieldByName('typeuspd').AsString;
      typezvaz   := FieldByName('typezvaz').AsString;
      nomerdoz   := FieldByName('nomerdoz').AsString;
      typeabo   := FieldByName('typeabo').AsString;
      nomertu   := FieldByName('nomertu').AsString;
      Next;
      End;
      pTable.Add(pD);
     End;
    End;
    CloseQryD;
    Result := resl;
End;


function CDBase.AddMConfig(pTable:CLoadEntity):Boolean;
Var
    strSQL   : String;
Begin
    with pTable do
    Begin
    strSQL := 'INSERT INTO MGCONFIG (MES,RES,NASP,GORS,ULICA,DOM,KORP,KVAR,LICS,FAM,IMYA,'+
              'OTCH,ZAVNO,TYPEPU,TYPEUSPD,TYPEZVAZ,NOMERDOZ,NOMERTU,TYPEABO)'+
              ' VALUES('+
              ''''+MES +''''+','+
              ''''+RES +''''+','+
              ''''+NASP +''''+','+
              ''''+GORS +''''+','+
              ''''+ULICA +''''+','+
              ''''+DOM +''''+','+
              ''''+KORP +''''+','+
              ''''+KVAR +''''+','+
              ''''+LICS +''''+','+
              ''''+FAM +''''+','+
              ''''+IMYA +''''+','+
              ''''+OTCH +''''+','+
              ''''+ZAVNO +''''+','+
              ''''+TYPEPU +''''+','+
              ''''+TYPEUSPD +''''+','+
              ''''+TYPEZVAZ +''''+','+
              ''''+NOMERDOZ +''''+','+
              ''''+NOMERTU +''''+','+
              ''''+TYPEABO     +''''+
              ')'
    End;
    Result := ExecQry(strSQL);
End;

function CDBase.DelMeterTable(nMasterIndex,nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM L2TAG WHERE M_SWABOID='+IntToStr(nMasterIndex)+' and m_swMID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM L2TAG WHERE M_SWABOID='+IntToStr(nMasterIndex);
    Result := ExecQry(strSQL);
End;
function CDBase.GetCmdMidTbl(sCMDID:Integer;var strMID:String):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    pTable   : CCOMMANDS;
Begin
    res := False;
    strMID := '';
    strSQL := 'SELECT distinct m_swMID '+
    ' FROM CCOMMAND,SQWERYMDL'+
    ' WHERE M_SWCMDID='+IntToStr(sCMDID)+
    ' and m_snMID=m_swMID'+
    ' and m_sbyEnable=1'+
    ' ORDER BY m_swMID';
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmCommand := nCount;
     SetLength(pTable.m_sCommand,nCount);
     while not FADOQueryD1.Eof do Begin
     with FADOQueryD1,pTable.m_sCommand[i] do  Begin
      strMID     := strMID + IntToStr(FieldByName('m_swMID').AsInteger)+',';
      Next;
      Inc(i);
      End;
     End;
    End;
    strMID := strMID + '-1';
    CloseQryD1;
    Result := res;
End;

function CDBase.GetCommandsFTable(nChannel:Integer;sFilter:String;var pTable:CCOMMANDS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT distinct M_SBYDELTAPER,M_SWSTATUS,CCOMMAND.* '+
    ' FROM CCOMMAND,QM_PARAMS'+
    ' WHERE M_SWTYPE=M_SWCMDID'+
    ' and M_SBYDELTAPER IN ('+sFilter+')'+
    ' and m_swMID='+IntToStr(nChannel)+
    ' and CCOMMAND.m_sbyEnable=1'+
    ' ORDER BY m_swCmdID';
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmCommand := nCount;
     SetLength(pTable.m_sCommand,nCount);
     while not FADOQueryD1.Eof do Begin
     with FADOQueryD1,pTable.m_sCommand[i] do  Begin
      m_swID      := FieldByName('M_SWSTATUS').AsInteger;
      m_swMID     := FieldByName('m_swMID').AsInteger;
      m_swCmdID   := FieldByName('m_swCmdID').AsInteger;
      m_swChannel := FieldByName('m_swChannel').AsString;
      m_swSpecc0  := FieldByName('m_swSpecc0').AsInteger;
      m_swSpecc1  := FieldByName('m_swSpecc1').AsInteger;
      m_swSpecc2  := FieldByName('m_swSpecc2').AsInteger;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyDirect :=  FieldByName('M_SBYDELTAPER').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQryD1;
    Result := res;
End;

function CDBase.GetCommandsTable(nChannel:Integer;var pTable:CCOMMANDS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;              
Begin
    res := False;
    strSQL := 'SELECT s0.*,s1.M_SNAME FROM CCOMMAND as s0,QM_PARAMS as s1'+
    ' WHERE s0.m_swMID='+IntToStr(nChannel)+
    ' AND s0.m_swCmdID=s1.m_swtype'+
    ' ORDER BY s0.m_swCmdID';
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmCommand := nCount;
     SetLength(pTable.m_sCommand,nCount);
     while not FADOQueryD1.Eof do Begin
     with FADOQueryD1,pTable.m_sCommand[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swMID     := FieldByName('m_swMID').AsInteger;
      m_swCmdID   := FieldByName('m_swCmdID').AsInteger;
      m_swChannel := FieldByName('m_swChannel').AsString;
      m_swSpecc0  := FieldByName('m_swSpecc0').AsInteger;
      m_swSpecc1  := FieldByName('m_swSpecc1').AsInteger;
      m_swSpecc2  := FieldByName('m_swSpecc2').AsInteger;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_snDataType:= FieldByName('m_snDataType').AsInteger;
      m_swCommandNm := FieldByName('M_SNAME').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQryD1;
    Result := res;
End;

function CDBase.GetCommandsTableOBS(nChannel:Integer;var pTable:CCOMMANDS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
{ TODO 5 -oUkrop -cFIXME : Получение списка команд управения }
    res := False;
    strSQL :=
    ' SELECT ' +
      ' CCOMMAND.m_swID,' +
      ' CCOMMAND.m_swMID,' +
      ' CCOMMAND.m_swCmdID,' +
      ' CCOMMAND.m_swChannel,' +
      ' CCOMMAND.m_swSpecc0,' +
      ' CCOMMAND.m_swSpecc1,' +
      ' CCOMMAND.m_swSpecc2,' +
      ' CCOMMAND.m_sbyEnable,' +
      ' qm_commands.m_sbyDirect' +
    ' from CCOMMAND' +
    ' right join qm_commands on (qm_commands.m_swcmdid=CCOMMAND.m_swcmdid AND qm_commands.m_swtype=(select m_sbytype from l2tag where m_swMID='+IntToStr(nChannel)+'))' +
    ' where CCOMMAND.m_swMID='+IntToStr(nChannel)+' ORDER BY m_swCmdID';

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
      m_swChannel := FieldByName('m_swChannel').AsString;
      m_swSpecc0  := FieldByName('m_swSpecc0').AsInteger;
      m_swSpecc1  := FieldByName('m_swSpecc1').AsInteger;
      m_swSpecc2  := FieldByName('m_swSpecc2').AsInteger;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyDirect := FieldByName('m_sbyDirect').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetCommandsTableCTRL(nChannel:Integer;var pTable:CTRLCOMMANDS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
{ TODO 5 -oUkrop -cFIXME : Получение списка команд управения }
    res := False;
    strSQL := 
    ' SELECT ' +
      ' qm_commands.m_sname,' +
      ' CCOMMAND.m_swcmdid,' +
      ' CCOMMAND.m_swspecc0,' +
      ' CCOMMAND.m_swspecc1,' +
      ' CCOMMAND.m_swspecc2' +
    ' from CCOMMAND' +
    ' right join qm_commands on (qm_commands.m_swcmdid=CCOMMAND.m_swcmdid AND qm_commands.m_swtype=(select m_sbytype from l2tag where m_swMID='+IntToStr(nChannel)+'))' +
    ' where CCOMMAND.m_swMID='+IntToStr(nChannel)+' and CCOMMAND.m_sbyenable=1 AND qm_commands.m_sbydirect=3';

    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmCommand := nCount;
     SetLength(pTable.m_sCommand,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sCommand[i] do  Begin
      m_swCmdID   := FieldByName('m_swCmdID').AsInteger;
      m_sParamName:= FieldByName('m_sname').AsString;
      m_swSpecc0  := FieldByName('m_swSpecc0').AsInteger;
      m_swSpecc1  := FieldByName('m_swSpecc1').AsInteger;
      m_swSpecc2  := FieldByName('m_swSpecc2').AsInteger;
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
              ',m_swChannel='   + '''' + m_swChannel + '''' +
              ',m_swSpecc0='    +IntToStr(m_swSpecc0)+
              ',m_swSpecc1='    +IntToStr(m_swSpecc1)+
              ',m_swSpecc2='    +IntToStr(m_swSpecc2)+
              ',m_snDataType='  +IntToStr(m_snDataType)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ' WHERE m_swMID=' +IntToStr(m_swMID)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.OpenCommand(cmdID,byEnable:Integer):Boolean;
Var
    strSQL   : String;
BEgin
    strSQL := 'UPDATE CCOMMAND SET '+
              ' m_sbyEnable='   +IntToStr(byEnable)+
              ' WHERE m_swCmdID=' +IntToStr(cmdID);
   Result := ExecQry(strSQL);
End;
function CDBase.OpenPortCommand(nPortID,cmdID,byEnable:Integer):Boolean;
Var
    strSQL   : String;
BEgin
    strSQL := 'UPDATE CCOMMAND SET '+
              ' m_sbyEnable='   +IntToStr(byEnable)+
              ' WHERE M_SWCMDID='+IntToStr(cmdID)+
              ' AND M_SWMID IN '+
              ' (SELECT L2TAG.M_SWMID FROM CCOMMAND,L2TAG'+
              ' WHERE L2TAG.M_SWMID=CCOMMAND.M_SWMID'+
              ' AND M_SBYPORTID='+IntToStr(nPortID)+')';
   Result := ExecQry(strSQL);
End;
function CDBase.OpenPortCommandStr(strCMD:String;cmdID,nPortID:Integer):Boolean;
Var
    strSQL   : String;
BEgin
    strSQL := 'UPDATE CCOMMAND SET '+strCMD+
              ' WHERE M_SWCMDID='+IntToStr(cmdID)+
              ' AND M_SWMID IN '+
              ' (SELECT L2TAG.M_SWMID FROM CCOMMAND,L2TAG'+
              ' WHERE L2TAG.M_SWMID=CCOMMAND.M_SWMID'+
              ' AND M_SBYPORTID='+IntToStr(nPortID)+')';
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
              '(m_swMID,m_swCmdID,m_swChannel,m_swSpecc0,m_swSpecc1,m_swSpecc2,m_snDataType,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swMID)+ ','+
              IntToStr(m_swCmdID)+ ','+
              '''' + m_swChannel + '''' + ','+
              IntToStr(m_swSpecc0)+ ','+
              IntToStr(m_swSpecc1)+ ','+
              IntToStr(m_swSpecc2)+ ','+
              IntToStr(m_snDataType)+ ','+
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
     strSQL := 'INSERT INTO CCOMMAND(m_swMID,m_swCmdID,m_swSpecc0,m_swSpecc1,m_swSpecc2,m_sblSaved,m_snDataType,m_sbyEnable)'+
               ' SELECT '+IntToStr(nIndex)+',m_swCMDID,m_swSpec0,m_swSpec1,m_swSpec2,m_sblSaved,m_snDataType,m_sbyEnable'+
               ' FROM QM_COMMANDS WHERE m_swType='+IntToStr(nMeterType)+
               ' and (QM_COMMANDS.m_sbyDirect=0 or QM_COMMANDS.m_sbyDirect=1) and QM_COMMANDS.m_sbyEnable=1';
     Result := ExecQry(strSQL);
    End;
End;
function CDBase.InsertCommandUSPD164Profile(nIndex,IndexKV:Integer):Boolean;
Var
    strSQL   : String;
    nCount   : Integer;
    res      : Boolean;
    pTable   : CCOMMAND;
Begin
     strSQL := 'UPDATE CCOMMAND SET '+
              'm_swChannel='+'''F1;8;'+IntToStr(IndexKV)+';'''+
              ' WHERE m_swMID=' +IntToStr(nIndex)+' and M_SWCMDID=21';
     Result := ExecQry(strSQL);

     strSQL := 'UPDATE CCOMMAND SET '+
               'm_swChannel='+'''F1;7;'+IntToStr(IndexKV)+';'''+
              ' WHERE m_swMID=' +IntToStr(nIndex)+' and M_SWCMDID=17';
     Result := ExecQry(strSQL);
End;

function CDBase.InsertCommandUSPD164v4Profile(nIndex,IndexKV:Integer):Boolean;
Var
    strSQL   : String;
    nCount   : Integer;
    res      : Boolean;
    pTable   : CCOMMAND;
Begin
     strSQL := 'UPDATE CCOMMAND SET '+
              'm_swChannel='+'''F0;0;'+IntToStr(IndexKV)+';'''+
              ' WHERE m_swMID=' +IntToStr(nIndex)+' and M_SWCMDID=21';
     Result := ExecQry(strSQL);

     strSQL := 'UPDATE CCOMMAND SET '+
               'm_swChannel='+'''F0;2;'+IntToStr(IndexKV)+';'''+
              ' WHERE m_swMID=' +IntToStr(nIndex)+' and M_SWCMDID=17';
     Result := ExecQry(strSQL);
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
    strSQL := 'INSERT INTO CCOMMAND(m_swMID,m_swCmdID,m_swSpecc0,m_swSpecc1,m_swSpecc2,m_sblSaved,m_snDataType,m_sbyEnable)'+
              ' SELECT '+IntToStr(nIndex)+',m_swCMDID,m_swSpec0,m_swSpec1,m_swSpec2,m_sblSaved,m_snDataType,m_sbyEnable'+
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
{
    //Таблица абонента
    SL3ABON = packed record
     m_swID      : Integer;
     m_swABOID   : Integer;
     m_swPortID  : Integer;
     m_sName     : string[100];
     m_sObject   : string[100];
     m_sKSP      : string[5];
     m_sDogNum   : string[25];
     m_sPhone    : string[25];
     m_sAddress  : string[75];
     m_sEAddress : string[55];
     m_sShemaPath: string[55];
     m_sComment  : string[200];
     m_sbyEnable: Byte;
     //Схема электроснабжения
    End;

    SL3REGION = packed record
     m_swID      : Integer;
     m_nRegionID : Integer;
     m_nRegNM    : string[100];
     m_sKSP      : string[5];
     Items       : array of SL3ABONS;
    End;
}
function CDBase.GetRegionsTable(var pTable:SL3REGIONS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3REGION';
    if (m_dwSort and SRT_REGI)<>0 then strSQL := 'SELECT * FROM SL3REGION ORDER BY m_nRegNM';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
      m_nRegNM    := FieldByName('m_nRegNM').AsString;
      m_sKSP      := FieldByName('m_sKSP').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetRegionsTable(nIndex:Integer; var pTable:SL3REGIONS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3REGION';
    if (m_dwSort and SRT_REGI)<>0 then strSQL := 'SELECT * FROM SL3REGION where M_NREGIONID='+ IntToStr(nIndex)+' ORDER BY m_nRegNM';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
      m_nRegNM    := FieldByName('m_nRegNM').AsString;
      m_sKSP      := FieldByName('m_sKSP').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetRegionsTableUN(var pTable:SL3REGIONS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3REGION ORDER BY m_nRegionID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
      m_nRegNM    := FieldByName('m_nRegNM').AsString;
      m_sKSP      := FieldByName('m_sKSP').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsRegTable(var pTable:SL3REGION):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3REGION WHERE m_nRegionID='+IntToStr(pTable.m_nRegionID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetRegionTable(var pTable:SL3REGION):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3REGION SET '+
              ' m_nRegionID='       +IntToStr(m_nRegionID)+
              ',m_nRegNM='     +''''+m_nRegNM+''''+
              ',m_sKSP='     +''''+m_sKSP+''''+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ' WHERE m_nRegionID=' +IntToStr(m_nRegionID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddRegionTable(var pTable:SL3REGION):Boolean;
Var
    strSQL : String;
Begin
    //DecimalSeparator := '.';
    if IsRegTable(pTable)=True then Begin Result := SetRegionTable(pTable);exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3REGION'+
              '(m_nRegionID,m_nRegNM,m_sKSP,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_nRegionID)+ ','+
              ''''+m_nRegNM+''''+ ','+
              ''''+m_sKSP+''''+ ','+
              IntToStr(m_sbyEnable)+')';
    End;
    Result := ExecQry(strSQL);
End;

function CDBase.addRegionId(var pTable:SL3REGION):Integer;
Var
    strSQL   : String;
    strMatch : String;
    nCount   : Integer;
    id       : Integer;
Begin
    id := -1;
    if(pTable.M_NREGIONID=-1) then strMatch := 'matching (m_nRegNM)' else
                                   strMatch := ' ';
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO SL3REGION'+
              '(m_nRegNM,m_sKSP,m_sbyEnable)'+
              ' VALUES('+
              ''''+m_nRegNM+''''+ ','+
              ''''+m_sKSP+''''+ ','+
              IntToStr(m_sbyEnable)+') '+strMatch;
    End;
    ExecQry(strSQL);
    strSQL := 'select max(M_NREGIONID) as M_NREGIONID from SL3REGION where M_NREGIONID<>500';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id := FADOQuery.FieldByName('M_NREGIONID').AsInteger;
      FADOQuery.Next;
     End;
    End;
    Result := id;
End;
function CDBase.addDepartamentId(var pTable:SL3DEPARTAMENT):Integer;
Var
    strSQL   : String;
    strMatch : String;
    nCount   : Integer;
    id       : Integer;
Begin
    id := -1;
    if(pTable.m_swDepID=-1) then strMatch := 'matching (m_swRegion,m_sName)' else
                                 strMatch := 'matching (m_swRegion)';
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO SL3DEPARTAMENT'+
              '(m_swRegion,m_sName)'+
              ' VALUES('+
              IntToStr(m_swRegion)+','+
              ''''+m_sName+''''+') '+strMatch;
    End;
    ExecQry(strSQL);
    //strSQL := 'select max(m_swDepID) as swDepID from SL3DEPARTAMENT';
    strSQL := 'select m_swDepID from SL3DEPARTAMENT'+
              ' where m_swRegion='+intToStr(pTable.m_swRegion)+
              ' and m_sName='+''''+pTable.m_sName+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id := FADOQuery.FieldByName('m_swDepID').AsInteger;
      FADOQuery.Next;
     End;
    End;
    Result := id;
End;

function CDBase.addTownId(var pTable:SL3TOWN):Integer;
Var
    strSQL : String;
    strMatch : String;
    nCount : Integer;
    id     : Integer;
Begin
    id := -1;
    if(pTable.m_swTownID=-1) then strMatch := 'matching (m_swDepID,m_sName)' else
                                  strMatch := 'matching (m_swDepID)';
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO SL3TOWN'+
              '(m_swDepID,m_sName)'+
              ' VALUES('+
              IntToStr(m_swDepID)+','+
              ''''+m_sName+''''+') '+strMatch;
    End;
    ExecQry(strSQL);
    //strSQL := 'select max(m_swTownID) as m_swTownID from SL3TOWN';
    strSQL := 'select m_swTownID from SL3TOWN'+
              ' where m_swDepID='+IntToStr(pTable.m_swDepID)+
              ' and m_sName='+''''+pTable.m_sName+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id := FADOQuery.FieldByName('m_swTownID').AsInteger;
      FADOQuery.Next;
     End;
    End;
    Result := id;
End;


function CDBase.CheckDepId(IdRayCode:Integer;var IdRegion:integer):Integer;
Var
    strSQL : String;
    strMatch : String;
    nCount : Integer;
    id     : Integer;
    //RegId  : Integer;
Begin
   id:=-1;
    strSQL := 'select M_SWDEPID,M_SWREGION from SL3DEPARTAMENT'+
              ' where CODE='+IntToStr(IdRayCode);
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id    := FADOQuery.FieldByName('M_SWDEPID').AsInteger;
      IdRegion := FADOQuery.FieldByName('M_SWREGION').AsInteger;
      FADOQuery.Next;
     End;
    End;
    Result := id;
End;


function CDBase.addStreetId(var pTable:SL3STREET):Integer;
Var
    strSQL   : String;
    strMatch : String;
    nCount   : Integer;
    id       : Integer;
Begin
    id := -1;
    if(pTable.m_swStreetID=-1) then strMatch := 'matching (m_swTownID,m_sName,m_swTPID)' else
                                    strMatch := 'matching (m_swTownID,m_swTPID)';
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO SL3STREET'+          // BO 11.06.19
              '(m_swTownID,m_swTPID,m_sName)'+
              ' VALUES('+
              IntToStr(m_swTownID)+','+
              IntToStr(m_swTPID)+','+
              ''''+m_sName+''''+') '+strMatch;
    End;
    ExecQry(strSQL);

    strSQL := 'select m_swStreetID from SL3STREET'+
              ' where m_swTownID='+IntToStr(pTable.m_swTownID)+
              ' and m_swTPID=' + IntToStr(pTable.m_swTPID)+              
              ' and m_sName='+''''+pTable.m_sName+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id := FADOQuery.FieldByName('m_swStreetID').AsInteger;
      FADOQuery.Next;
     End;
    End;
    Result := id;
End;
function CDBase.addAbonId(pTable:SL3ABON):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
    id := -1;
    keyField := '';
    keyData  := '';
    if(pTable.m_swABOID=-1) then strMatch := 'matching (m_nRegionID,M_SWDEPID,M_SWSTREETID,M_SWTOWNID,TPID,m_sName)' else
    Begin
     keyField := 'm_swABOID,';
     keyData  := IntToStr(pTable.m_swABOID)+',';
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO SL3ABON'+
              '('+keyField+'m_nRegionID,M_SWDEPID,M_SWSTREETID,M_SWTOWNID,TPID,m_swPortID,m_sdtRegDate,m_sName,m_sAddress,m_sTelRing,m_sbyVisible,m_sReportVS' +
              ',m_sbyEnable,m_sTreeSettings,M_SHOUSENUMBER,M_SKORPUSNUMBER,gors,m_sAddrSettings)'+
              ' VALUES('+keyData+
              IntToStr(m_nRegionID)+ ','+
              IntToStr(M_SWDEPID)+ ','+
              IntToStr(M_SWSTREETID)+ ','+
              IntToStr(M_SWTOWNID)+ ','+
              IntToStr(TPID)+ ','+
              IntToStr(m_swPortID)+ ','+
              ''''+DateTimeToStr(m_sdtRegDate)+''''+','+
              ''''+m_sName+''''+ ','+
              ''''+m_sAddress+''''+ ','+
              ''''+m_sTelRing+''''+ ','+
              IntToStr(m_sbyVisible)+ ','+
              IntToStr(m_sReportVS)+','+
              IntToStr(m_sbyEnable)+','+
              IntToStr(m_sTreeSettings)+','+
              ''''+M_SHOUSENUMBER+''''+ ','+
              ''''+M_SKORPUSNUMBER+''''+ ','+
              ''''+gors+''''+','+
              IntToStr(m_sAddrSettings)+') '+strMatch;
    End;
    ExecQry(strSQL);
    //strSQL := 'select max(m_swABOID) as m_swABOID from SL3ABON';
    strSQL := 'select m_swABOID from SL3ABON'+
              ' where m_nRegionID='+IntToStr(pTable.m_nRegionID)+
              ' and M_SWDEPID='+IntToStr(pTable.M_SWDEPID)+
              ' and M_SWSTREETID='+IntToStr(pTable.M_SWSTREETID)+
              ' and M_SWTOWNID='+IntToStr(pTable.M_SWTOWNID)+
              ' and TPID='+IntToStr(pTable.TPID)+
              ' and m_sName='+''''+pTable.m_sName+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id := FADOQuery.FieldByName('m_swABOID').AsInteger;
      FADOQuery.Next;
     End;
    End;
    Result := id;
End;

function CDBase.addAbonId_SaveL3Abon(pTable:SL3ABON):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
    id := -1;
    keyField := '';
    keyData  := '';
    if(pTable.m_swABOID=-1) then strMatch := 'matching (m_nRegionID,M_SWDEPID,M_SWSTREETID,M_SWTOWNID,TPID,m_sName)' else
    Begin
     keyField := 'm_swABOID,';
     keyData  := IntToStr(pTable.m_swABOID)+',';
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO SL3ABON'+
              '('+keyField+'m_swPortID,m_sdtRegDate,m_sName,m_sAddress,m_sTelRing,m_sbyVisible,m_sReportVS' +
              ',m_sbyEnable,m_sTreeSettings,M_SHOUSENUMBER,M_SKORPUSNUMBER,gors,m_sAddrSettings)'+
              ' VALUES('+keyData+
              IntToStr(m_swPortID)+ ','+
              ''''+DateTimeToStr(m_sdtRegDate)+''''+','+
              ''''+m_sName+''''+ ','+
              ''''+m_sAddress+''''+ ','+
              ''''+m_sTelRing+''''+ ','+
              IntToStr(m_sbyVisible)+ ','+
              IntToStr(m_sReportVS)+','+
              IntToStr(m_sbyEnable)+','+
              IntToStr(m_sTreeSettings)+','+
              ''''+M_SHOUSENUMBER+''''+ ','+
              ''''+M_SKORPUSNUMBER+''''+ ','+
              ''''+gors+''''+','+
              IntToStr(m_sAddrSettings)+') '+strMatch;
    End;
    ExecQry(strSQL);
    strSQL := 'select m_swABOID from SL3ABON'+
              ' where m_nRegionID='+IntToStr(pTable.m_nRegionID)+
              ' and M_SWDEPID='+IntToStr(pTable.M_SWDEPID)+
              ' and M_SWSTREETID='+IntToStr(pTable.M_SWSTREETID)+
              ' and M_SWTOWNID='+IntToStr(pTable.M_SWTOWNID)+
              ' and TPID='+IntToStr(pTable.TPID)+
              ' and m_sName='+''''+pTable.m_sName+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id := FADOQuery.FieldByName('m_swABOID').AsInteger;
      FADOQuery.Next;
     End;
    End;
    Result := id;
End;

function CDBase.addTpId(pTable:SL3TP):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
    id := -1;
    if(pTable.ID=-1) then strMatch := 'matching (M_SWTOWNID,NAME)' else
    Begin
     keyField := 'ID,';
     keyData  := IntToStr(pTable.ID)+',';
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO SL3TP'+
              '('+keyField+'M_SWTOWNID,TPTYPE,NAME)'+
              ' VALUES('+keyData+
              IntToStr(M_SWTOWNID)+ ','+
              IntToStr(TPTYPE)+ ','+
              ''''+NAME+''''+ ')'+strMatch;
    End;
    ExecQry(strSQL);
    strSQL := 'select ID from SL3TP'+
              ' where M_SWTOWNID='+IntToStr(pTable.M_SWTOWNID)+
              ' and NAME='+''''+pTable.NAME+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id := FADOQuery.FieldByName('ID').AsInteger;
      FADOQuery.Next;
     End;
    End;
    Result := id;
End;
function CDBase.addGroupId(pTable:SL3GROUPTAG):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
    id := -1;
    if(pTable.m_sbyGroupID=-1) then strMatch := 'matching (m_swABOID,m_sGroupName)' else
    Begin
     keyField := 'm_sbyGroupID,';
     keyData  := IntToStr(pTable.m_sbyGroupID)+',';
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO SL3GROUPTAG'+
              '('+keyField+'m_swABOID,M_NGROUPLV,m_swPosition,m_sGroupName,m_sGroupExpress,m_swPLID,m_sbyEnable)'+
              ' VALUES('+keyData+
              IntToStr(m_swABOID)+ ','+
              IntToStr(M_NGROUPLV)+ ','+
              IntToStr(m_swPosition)+ ','+
              ''''+m_sGroupName+''''+ ','+
              ''''+m_sGroupExpress+''''+ ','+
              IntToStr(m_swPLID)+ ','+
              IntToStr(m_sbyEnable)+ ') '+strMatch;
    End;
    ExecQry(strSQL);
    //strSQL := 'select max(m_sbyGroupID) as m_sbyGroupID from SL3GROUPTAG';
    strSQL := 'select m_sbyGroupID from SL3GROUPTAG'+
              ' where m_swABOID='+IntToStr(pTable.m_swABOID)+
              ' and m_sGroupName='+''''+pTable.m_sGroupName+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id := FADOQuery.FieldByName('m_sbyGroupID').AsInteger;
      FADOQuery.Next;
     End;
    End;
    Result := id;
End;

function CDBase.addMeterId(pTable:SL2TAG):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
    id := -1;
    keyField := '';                     
    keyData  := '';
   // if(pTable.m_swMID=-1) then Begin strMatch := 'matching (m_swABOID,m_sddFabNum,m_schName)';End else  //БЫЛО
    if(pTable.m_swMID=-1) then Begin strMatch := 'matching (m_swABOID,M_SDDPHADDRES)';End else
    begin
     keyField := 'm_swMID,';
     keyData  := IntToStr(pTable.m_swMID)+',';
    end;
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L2TAG'+
              '('+keyField+'m_swABOID,pullid,m_sbyGroupID,m_swVMID,m_sbyType,m_sbyLocation,m_sddFabNum,'+
              'm_schPassword,m_sddPHAddres,m_schName,m_sbyPortID,'+
              'm_sbyRepMsg,m_swRepTime,m_sfKI,m_sfKU,m_sfMeterKoeff,m_sbyPrecision,'+
              'm_swCurrQryTm,m_sbyTSlice,m_sPhone,m_sbyModem,m_sbyEnable,' +
              'm_swMinNKan, m_swMaxNKan,m_sdtSumKor,m_sdtLimKor,m_sdtPhLimKor,m_bySynchro,m_swKE,'+
              'm_sbyNSEnable,m_sdwFMark,m_sdwEMark,m_sdwRetrans,m_sdwKommut,m_sdwDevice,'+
              'm_sbySpeed,m_sbyParity,m_sbyStop,m_sbyKBit,m_nB0Timer,m_sbyPause,'+
              'm_sAktEnLose,m_sReaEnLose,m_sTranAktRes,m_sTranReaRes,m_sGrKoeff,m_sTranVolt,m_sTpNum,'+
              'typepu,typezvaz,typeabo,M_SDDHADR_HOUSE,M_SDDHADR_KV,M_SWABOID_CHANNEL,M_SWABOID_TARIFF,M_SADVDISCL2TAG)'+
              ' VALUES('+keyData+
              IntToStr(m_swABOID)+ ','+
              IntToStr(pullid)+ ','+
              IntToStr(m_sbyGroupID)+ ','+
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
              IntToStr(m_sbyPrecision) + ',' +
              IntToStr(m_swCurrQryTm)+ ','+
              IntToStr(m_sbyTSlice) + ',' +
              ''''+m_sPhone +''''+ ','+
              IntToStr(m_sbyModem)+ ',' +
              IntToStr(m_sbyEnable)+ ',' +
              IntToStr(m_swMinNKan) + ',' +
              IntToStr(m_swMaxNKan) + ',' +
              '''' + DateTimeToStr(m_sdtSumKor) + '''' + ',' +
              '''' + DateTimeToStr(m_sdtLimKor) + '''' +  ',' +
              '''' + DateTimeToStr(m_sdtPhLimKor) + '''' + ','+
              IntToStr(m_bySynchro) + ',' +
              IntToStr(m_swKE) + ','+
              IntToStr(m_sAD.m_sbyNSEnable)+ ',' +
              IntToStr(m_sAD.m_sdwFMark)+ ',' +
              IntToStr(m_sAD.m_sdwEMark)+ ',' +
              IntToStr(m_sAD.m_sdwRetrans)+ ',' +
              IntToStr(m_sAD.m_sdwKommut)+ ',' +
              IntToStr(m_sAD.m_sdwDevice)+ ',' +
              IntToStr(m_sAD.m_sbySpeed)+ ',' +
              IntToStr(m_sAD.m_sbyParity)+ ',' +
              IntToStr(m_sAD.m_sbyStop)+ ',' +
              IntToStr(m_sAD.m_sbyKBit)+ ',' +
              IntToStr(m_sAD.m_nB0Timer)+ ',' +
              IntToStr(m_sAD.m_sbyPause)+ ',' +
              FloatToStr(m_sAktEnLose)+ ',' +
              FloatToStr(m_sReaEnLose)+ ',' +
              FloatToStr(m_sTranAktRes)+ ',' +
              FloatToStr(m_sTranReaRes)+ ',' +
              IntToStr(m_sGrKoeff)+ ',' +
              IntToStr(m_sTranVolt) + ',' +
              '''' + m_sTpNum + '''' + ',' +
              IntToStr(typepu) + ',' +
              '''' + typezvaz+ '''' + ',' +
              '''' + typeabo + '''' + ',' +
              '''' + m_sddHOUSE+ '''' + ',' +
              '''' + m_sddKV + '''' + ',' +
              IntToStr(m_aid_channel) + ',' +
              IntToStr(m_aid_tariff) + ',' +
              '''' + M_SADVDISCL2TAG + '''' +
              ') '+strMatch;
    End;
    ExecQry(strSQL);
    //strSQL := 'select max(m_swMID) as m_swMID from L2TAG';
    strSQL := 'select m_swMID from L2TAG'+
              ' where m_swABOID='+IntToStr(pTable.m_swABOID)+
              ' and m_sddFabNum='+''''+pTable.m_sddFabNum+''''+
              ' and m_schName='+''''+pTable.m_schName+'''';

    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id := FADOQuery.FieldByName('m_swMID').AsInteger;
      FADOQuery.Next;
     End;
    End;
    Result := id;
End;

function CDBase.addMeterId2(aAddrecc, aFIO : string; pTable:SL2TAG):Integer;
Var
    strSQL   : String;
    strSQLa  : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
    i1, i2   : integer;
    s1 , s2  : string;
    strFIO   : string;
Begin
    id := -1;
    keyField := '';
    keyData  := '';
   // if(pTable.m_swMID=-1) then Begin strMatch := 'matching (m_swABOID,m_sddFabNum,m_schName)';End else  //БЫЛО
   // BO 29.11.2018

   s1 := pTable.M_SDDFABNUM;
   s2 := pTable.M_STPNUM;

   strSQLa := 'SELECT L2T.M_SDDFABNUM, L2T.M_STPNUM, L2T.M_SWMID, L2T.M_SWABOID, L2T.M_SCHNAME, L3A.TPID, L3P.NAME, ' +
             '       L3Da.m_sname || '', '' || L3Ta.m_sname || '', '' || L3Sa.m_sname || '', '' || L3A.M_SHOUSENUMBER  || ''/'' || L3A.M_SKORPUSNUMBER  || '', '' || M_SDDPHADDRES Addr ' +
             'FROM L2TAG L2T, SL3ABON L3A, SL3TP L3P, SL3DEPARTAMENT L3Da, SL3TOWN L3Ta, SL3STREET L3Sa ' +
             'WHERE L2T.M_SWABOID = L3A.M_SWABOID ' +
             '  AND L3A.TPID = L3P.ID ' +
             '  AND L3A.M_SWDEPID = L3Da.M_SWDEPID ' +
             '  AND L3A.M_SWTOWNID = L3Ta.M_SWTOWNID ' +
             '  AND L3A.M_SWSTREETID = L3Sa.M_SWSTREETID ' +
             '  AND (SELECT L3D.CODE || '', '' || L3T.M_SWTOWNID || '', '' || L3S.M_SWSTREETID || '', '' || L3A.M_SHOUSENUMBER || '', '' || L3A.M_SKORPUSNUMBER || '', '' || M_SDDPHADDRES TSA ' +
             '       FROM SL3DEPARTAMENT L3D, SL3TOWN L3T, SL3STREET L3S ' +
             '       WHERE L3A.M_SWDEPID = L3D.M_SWDEPID ' +
             '  AND L3A.M_SWTOWNID = L3T.M_SWTOWNID ' +
             '         AND L3A.M_SWSTREETID = L3S.M_SWSTREETID) = ''' + aAddrecc + '''';
   if OpenQry(strSQLa,nCount)=True then Begin // запись вернулась, адрес есть в базе
     if nCount > 1 then begin // адресов в базе больше 1
       with lcMRMoreThanOneAddress do                 // BO 30.11.18
         LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now,FADOQuery.FieldByName('Addr').AsString);
       ShowMessage('В базе обнаружено более одного указанного адреса');
     end else begin  // один адрес присутствует
       pTable.m_swMID:=FADOQuery.FieldByName('M_SWMID').AsInteger;
       strFIO:=FADOQuery.FieldByName('M_SCHNAME').AsString;
       i1:=pos('(',strFIO);
       i2:=pos(')',strFIO);
       if (i1>0) and (i2>0) then
       Delete(strFIO,i1,i2);

       if aFIO <> strFIO then begin
       with lcMRLastNameChanged do                 // BO 30.11.18
         LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now,'Запись № ' + IntToStr(pTable.m_swMID) +' значение '+ aFIO);
       end;
       if pTable.M_SDDFABNUM <> FADOQuery.FieldByName('M_SDDFABNUM').AsString then begin
       with lcMRChangedFactoryNumber do                 // BO 30.11.18
         LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now,'Запись № ' + IntToStr(pTable.m_swMID) +' значение '+ pTable.M_SDDFABNUM);
       end;
       if pTable.M_STPNUM <> FADOQuery.FieldByName('M_STPNUM').AsString then begin
       with lcMRChangedAccount do                 // BO 30.11.18
         LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now,'Запись № ' + IntToStr(pTable.m_swMID) +' значение '+ pTable.M_STPNUM);
       end;

       pTable.m_swMID:=FADOQuery.FieldByName('M_SWMID').AsInteger;
       SetMeterTable(pTable); // update
     end;
   end else begin
     // нет адреса
    if (pTable.m_swMID=-1) then begin
      strMatch := 'matching (m_swABOID,M_SDDPHADDRES)';
    end else begin
      keyField := 'm_swMID,';
      keyData  := IntToStr(pTable.m_swMID)+',';
    end;
    with pTable do
    Begin
    strSQL := 'INSERT INTO L2TAG '+
              '('+keyField+'m_swABOID,pullid,m_sbyGroupID,m_swVMID,m_sbyType,m_sbyLocation,m_sddFabNum,'+
              'm_schPassword,m_sddPHAddres,m_schName,m_sbyPortID,'+
              'm_sbyRepMsg,m_swRepTime,m_sfKI,m_sfKU,m_sfMeterKoeff,m_sbyPrecision,'+
              'm_swCurrQryTm,m_sbyTSlice,m_sPhone,m_sbyModem,m_sbyEnable,' +
              'm_swMinNKan, m_swMaxNKan,m_sdtSumKor,m_sdtLimKor,m_sdtPhLimKor,m_bySynchro,m_swKE,'+
              'm_sbyNSEnable,m_sdwFMark,m_sdwEMark,m_sdwRetrans,m_sdwKommut,m_sdwDevice,'+
              'm_sbySpeed,m_sbyParity,m_sbyStop,m_sbyKBit,m_nB0Timer,m_sbyPause,'+
              'm_sAktEnLose,m_sReaEnLose,m_sTranAktRes,m_sTranReaRes,m_sGrKoeff,m_sTranVolt,m_sTpNum,'+
              'typepu,typezvaz,typeabo,M_SDDHADR_HOUSE,M_SDDHADR_KV,M_SWABOID_CHANNEL,M_SWABOID_TARIFF,M_SADVDISCL2TAG)'+
              ' VALUES('+keyData+
              IntToStr(m_swABOID)+ ','+
              IntToStr(pullid)+ ','+
              IntToStr(m_sbyGroupID)+ ','+
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
              IntToStr(m_sbyPrecision) + ',' +
              IntToStr(m_swCurrQryTm)+ ','+
              IntToStr(m_sbyTSlice) + ',' +
              ''''+m_sPhone +''''+ ','+
              IntToStr(m_sbyModem)+ ',' +
              IntToStr(m_sbyEnable)+ ',' +
              IntToStr(m_swMinNKan) + ',' +
              IntToStr(m_swMaxNKan) + ',' +
              '''' + DateTimeToStr(m_sdtSumKor) + '''' + ',' +
              '''' + DateTimeToStr(m_sdtLimKor) + '''' +  ',' +
              '''' + DateTimeToStr(m_sdtPhLimKor) + '''' + ','+
              IntToStr(m_bySynchro) + ',' +
              IntToStr(m_swKE) + ','+
              IntToStr(m_sAD.m_sbyNSEnable)+ ',' +
              IntToStr(m_sAD.m_sdwFMark)+ ',' +
              IntToStr(m_sAD.m_sdwEMark)+ ',' +
              IntToStr(m_sAD.m_sdwRetrans)+ ',' +
              IntToStr(m_sAD.m_sdwKommut)+ ',' +
              IntToStr(m_sAD.m_sdwDevice)+ ',' +
              IntToStr(m_sAD.m_sbySpeed)+ ',' +
              IntToStr(m_sAD.m_sbyParity)+ ',' +
              IntToStr(m_sAD.m_sbyStop)+ ',' +
              IntToStr(m_sAD.m_sbyKBit)+ ',' +
              IntToStr(m_sAD.m_nB0Timer)+ ',' +
              IntToStr(m_sAD.m_sbyPause)+ ',' +
              FloatToStr(m_sAktEnLose)+ ',' +
              FloatToStr(m_sReaEnLose)+ ',' +
              FloatToStr(m_sTranAktRes)+ ',' +
              FloatToStr(m_sTranReaRes)+ ',' +
              IntToStr(m_sGrKoeff)+ ',' +
              IntToStr(m_sTranVolt) + ',' +
              '''' + m_sTpNum + '''' + ',' +
              IntToStr(typepu) + ',' +
              '''' + typezvaz+ '''' + ',' +
              '''' + typeabo + '''' + ',' +
              '''' + m_sddHOUSE+ '''' + ',' +
              '''' + m_sddKV + '''' + ',' +
              IntToStr(m_aid_channel) + ',' +
              IntToStr(m_aid_tariff) + ',' +
              '''' + M_SADVDISCL2TAG + '''' +
              ') '; //+strMatch;
    End;
    ExecQry(strSQL);

    if OpenQry(strSQLa,nCount)=True then Begin
      // Получить запросом новый адрес
      with lcMRAddedNewAddress do                 // BO 30.11.18
        LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now,FADOQuery.FieldByName('Addr').AsString);
    end;
   end;


    strSQL := 'select m_swMID from L2TAG'+
              ' where m_swABOID='+IntToStr(pTable.m_swABOID)+
              ' and m_sddFabNum='+''''+pTable.m_sddFabNum+''''+
              ' and m_schName='+''''+pTable.m_schName+'''';

    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id := FADOQuery.FieldByName('m_swMID').AsInteger;
      FADOQuery.Next;
     End;
    End;


    Result := id;
End;



function CDBase.addVMeterId(pTable:SL3VMETERTAG):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
   id := -1;
   //if(pTable.m_swVMID=-1) then strMatch := 'matching (m_sbyGroupID,m_sddPHAddres,m_sMeterName)' else
   if(pTable.m_swVMID=-1) then strMatch := 'matching (m_sbyGroupID,M_SDDPHADDRES)' else
   begin
    keyField := 'm_swVMID,';
    keyData  := IntToStr(pTable.m_swVMID)+',';
   end;
   with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO SL3VMETERTAG'+
              '('+keyField+'m_swMID,m_sbyPortID,m_sbyType,m_sbyGroupID,m_sddPHAddres,m_sMeterName,m_sMeterCode,m_sVMeterName,m_sbyExport,m_swPLID,m_sbyEnable)'+
              ' VALUES('+keyData+
              IntToStr(m_swMID)+ ','+
              IntToStr(m_sbyPortID)+ ','+
              IntToStr(m_sbyType)+ ','+
              IntToStr(m_sbyGroupID)+ ','+
              ''''+m_sddPHAddres+''''+ ','+
              ''''+m_sMeterName+''''+ ','+
              ''''+m_sMeterCode+''''+ ','+
              ''''+m_sVMeterName+''''+','+
              IntToStr(m_sbyExport)+ ','+
              IntToStr(m_swPLID)+ ','+
              IntToStr(m_sbyEnable)+ ') '+strMatch;

    End;
    ExecQry(strSQL);
    //strSQL := 'select max(m_swVMID) as m_swVMID from SL3VMETERTAG';
    strSQL := 'select m_swVMID from SL3VMETERTAG'+
              ' where m_sbyGroupID='+IntToStr(pTable.m_sbyGroupID)+
              ' and m_sddPHAddres='+''''+pTable.m_sddPHAddres+''''+
              ' and m_sMeterName='+''''+pTable.m_sMeterName+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      id := FADOQuery.FieldByName('m_swVMID').AsInteger;
      FADOQuery.Next;
     End;
    End;
    Result := id;
End;


function CDBase.DelRegionTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then strSQL := 'DELETE FROM SL3REGION WHERE m_nRegionID='+IntToStr(nIndex) else
    if nIndex=-1  then strSQL := 'DELETE FROM SL3REGION';
    Result := ExecQry(strSQL);
End;

function CDBase.GetRegTable(var pTable:SL3REGIONS):Boolean;
Var
    i,j : Integer;
    res : Boolean;
Begin
    res := False;
    if GetRegionsTable(pTable)=True then
     for i:=0 to pTable.Count-1 do
      if GetAbonRegTable(pTable.Items[i].m_nRegionID,pTable.Items[i].Item)=True then
       for j:=0 to pTable.Items[i].Item.Count-1 do
        res := GetAbonTag(pTable.Items[i].Item.Items[j].m_swABOID,pTable.Items[i].Item.Items[j].Item);
    Result := res;
End;

function CDBase.GetAllDepartamentsTable(var pTable:SL3DEPARTAMENTS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3DEPARTAMENT ORDER BY m_swDepID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swRegion := FieldByName('m_swRegion').AsInteger;
      m_swDepID  := FieldByName('m_swDepID').AsInteger;
      m_sName    := FieldByName('m_sName').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
{
   mAddrSet := m_pDB.GetAddressSett(ABOID);
   mSIDAbon := (mAddrSet mod TID_MULT) div SID_MULT;
   mTIDAbon := (mAddrSet mod DID_MULT) div TID_MULT;
   mDIDAbon := (mAddrSet mod RID_MULT) div DID_MULT;
   mRIDAbon := mAddrSet div RID_MULT;

    SL3REGION = packed record
     m_swID      : Integer;
     m_nRegionID : Integer;
     m_nRegNM    : string[100];
     m_sKSP      : string[5];
     m_sbyEnable : Byte;
     Item        : SL3ABONS;
    End;
    SL3DEPARTAMENT = packed record
      m_swID            : Integer;
      m_swRegion        : Integer;
      m_swDepID         : Integer;
      m_sName           : string[150];
    end;
    SL3TOWN = packed record
      m_swID            : Integer;
      m_swDepID         : Integer;
      m_swTownID        : Integer;
      m_sName           : string[150];
    end;
    SL3STREET = packed record
      m_swID            : Integer;
      m_swTownID        : Integer;
      m_swStreetID      : Integer;
      m_sName           : string[150];
    end;
}
function CDBase.GetAbonLabel(nABOID: integer;var pTable:SL3ABONLB):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    mAddrSet : int64;
    mSIDAbon : Integer;
    mTIDAbon : Integer;
    mDIDAbon : Integer;
    mRIDAbon : Integer;
Begin
    res := False;
    mAddrSet := m_pDB.GetAddressSett(nABOID);
    mSIDAbon := (mAddrSet mod TID_MULT) div SID_MULT;
    mTIDAbon := (mAddrSet mod DID_MULT) div TID_MULT;
    mDIDAbon := (mAddrSet mod RID_MULT) div DID_MULT;
    mRIDAbon := mAddrSet div RID_MULT;
    pTable.m_nRegID    := mRIDAbon;
    pTable.m_nDepartID := mDIDAbon;
    pTable.m_nTwnID    := mTIDAbon;
    pTable.m_nStreetID := mSIDAbon;
    strSQL := 'SELECT s0.m_nRegNM,s1.m_sName as nm0,s2.m_sName as nm1,s3.m_sName as nm2'+
              ' FROM SL3REGION as s0,SL3DEPARTAMENT as s1,SL3TOWN as s2,SL3STREET as s3'+
              ' WHERE s0.m_nRegionID=s1.m_swRegion AND s0.m_nRegionID='+IntToStr(mRIDAbon)+
              ' AND s1.m_swDepID=s2.m_swDepID AND s1.m_swDepID='+IntToStr(mDIDAbon)+
              ' AND s2.m_swTownID=s3.m_swTownID AND s2.m_swTownID='+IntToStr(mTIDAbon)+
              ' AND s3.m_swStreetID='+IntToStr(mSIDAbon);
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     with FADOQuery,pTable do  Begin
      m_sRegName    := FieldByName('m_nRegNM').AsString;
      m_sDepartName := FieldByName('nm0').AsString;
      m_sTwnName    := FieldByName('nm1').AsString;
      m_sStreetName := FieldByName('nm2').AsString;
      End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetDepartamentsTable(RegID: integer;var pTable:SL3DEPARTAMENTS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3DEPARTAMENT where m_swRegion=' + IntToStr(RegID) + ' ORDER BY m_sName';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swRegion := FieldByName('m_swRegion').AsInteger;
      m_swDepID  := FieldByName('m_swDepID').AsInteger;
      m_sName    := FieldByName('m_sName').AsString;
      code       := FieldByName('code').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.GetDepartamentsTableALL(var pTable:SL3DEPARTAMENTS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3DEPARTAMENT ORDER BY m_sName';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swRegion := FieldByName('m_swRegion').AsInteger;
      m_swDepID  := FieldByName('m_swDepID').AsInteger;
      m_sName    := FieldByName('m_sName').AsString;
      code       := FieldByName('code').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.AddDepartamentTable(var pTable:SL3DEPARTAMENT):Boolean;
Var
    strSQL   : String;
Begin
    if IsDepartamentTable(pTable)=True then Begin Result := SetDepartamentTable(pTable);exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3DEPARTAMENT'+
              '(m_swRegion,m_swDepID,m_sName,CODE)'+
              ' VALUES('+
              IntToStr(m_swRegion)+','+
              IntToStr(m_swDepID)+','+
              ''''+m_sName+''''+','+
              ''''+CODE+''''+')';
    End;
    Result := ExecQry(strSQL);
end;

function CDBase.IsDepartamentTable(var pTable:SL3DEPARTAMENT):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3DEPARTAMENT WHERE m_swDepID='+IntToStr(pTable.m_swDepID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;


function CDBase.IsDepartamentTableCode(_code:String):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3DEPARTAMENT WHERE CODE='+_code;
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;


function CDBase.SetDepartamentTable(var pTable:SL3DEPARTAMENT):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3DEPARTAMENT SET '+
              ' m_swRegion='  +IntToStr(m_swRegion)+
              ',m_swDepID='   +IntToStr(m_swDepID)+
              ',m_sName='     +''''+m_sName+''''+
              ',CODE='        +''''+code+''''+
              ' WHERE m_swDepID=' +IntToStr(m_swDepID);
   End;
   Result := ExecQry(strSQL);
end;

function CDBase.DelDepartamentTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then strSQL := 'DELETE FROM SL3DEPARTAMENT WHERE m_swDepID='+IntToStr(nIndex) else
    if nIndex=-1  then strSQL := 'DELETE FROM SL3DEPARTAMENT';
    Result := ExecQry(strSQL);
end;

function CDBase.GetAllTownsTable(var pTable:SL3TOWNS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3TOWN ORDER BY m_swTownID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swDepID  := FieldByName('m_swDepID').AsInteger;
      m_swTownID := FieldByName('m_swTownID').AsInteger;
      m_sName    := FieldByName('m_sName').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;


function CDBase.GetAllTPTable(var pTable:SL3TPS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3TP ORDER BY ID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      ID          := FieldByName('ID').AsInteger;
      M_SWTOWNID  := FieldByName('M_SWTOWNID').AsInteger;
      TPTYPE      := FieldByName('TPTYPE').AsInteger;
      NAME        := FieldByName('NAME').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;


function CDBase.GetTownsTable(DepID: integer;var pTable:SL3TOWNS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3TOWN WHERE m_swDepID=' + IntToStr(DepID) + ' ORDER BY m_sName';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swDepID  := FieldByName('m_swDepID').AsInteger;
      m_swTownID := FieldByName('m_swTownID').AsInteger;
      m_sName    := FieldByName('m_sName').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;


function CDBase.AddTownTable(var pTable:SL3TOWN):Boolean;
Var
    strSQL   : String;
Begin
    if IsTownTable(pTable)=True then Begin Result := SetTownTable(pTable);exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3TOWN'+
              '(m_swDepID,m_swTownID,m_sName)'+
              ' VALUES('+
              IntToStr(m_swDepID)+','+
              IntToStr(m_swTownID)+','+
              ''''+m_sName+''''+')';
    End;
    Result := ExecQry(strSQL);
end;


function CDBase.IsTownTable(var pTable:SL3TOWN):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3TOWN WHERE m_swTownID='+IntToStr(pTable.m_swTownID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.SetTownTable(var pTable:SL3TOWN):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3TOWN SET '+
              ' m_swDepID='  +IntToStr(m_swDepID)+
              ',m_swTownID='   +IntToStr(m_swTownID)+
              ',m_sName='     +''''+m_sName+''''+
              ' WHERE m_swTownID=' +IntToStr(m_swTownID);
   End;
   Result := ExecQry(strSQL);
end;

function CDBase.DelTownTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then strSQL := 'DELETE FROM SL3TOWN WHERE m_swTownID='+IntToStr(nIndex) else
    if nIndex=-1  then strSQL := 'DELETE FROM SL3TOWN';
    Result := ExecQry(strSQL);
end;


function CDBase.AddTPTable(var pTable:SL3TP):Boolean;
Var
    strSQL   : String;
Begin
    if IsTPTable(pTable)=True then Begin Result := SetTPTable(pTable);exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3TP'+
              '(ID,M_SWTOWNID,TPTYPE,NAME)'+
              ' VALUES('+
              IntToStr(ID)+','+
              IntToStr(M_SWTOWNID)+','+
              IntToStr(0)+','+              
              ''''+NAME+''''+')';
    End;
    Result := ExecQry(strSQL);
end;


function CDBase.IsTPTable(var pTable:SL3TP):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3TP WHERE ID='+IntToStr(pTable.ID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.SetTPTable(var pTable:SL3TP):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3TP SET '+
              ' NAME='     +''''+NAME+''''+
              ' WHERE ID='  +IntToStr(ID)+
              ' and m_swTownID=' +IntToStr(m_swTownID)+
              ' and TPTYPE='   +IntToStr(TPTYPE);
   End;
   Result := ExecQry(strSQL);
end;

function CDBase.DelSL3TPTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then strSQL := 'DELETE FROM SL3TP WHERE ID='+IntToStr(nIndex) else
    if nIndex=-1  then strSQL := 'DELETE FROM SL3TP';
    Result := ExecQry(strSQL);
end;



function CDBase.GetAllStreetsTable(var pTable:SL3STREETS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3STREET ORDER BY m_swStreetID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := FieldByName('m_swID').AsInteger;
      m_swTownID   := FieldByName('m_swTownID').AsInteger;
      m_swStreetID := FieldByName('m_swStreetID').AsInteger;
      m_sName      := FieldByName('m_sName').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.GetPodsTable(TownID: integer; var pTable:SL3TPS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3TP'+
              ' WHERE M_SWTOWNID=' + IntToStr(TownID) +
              ' ORDER BY name';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      id         := FieldByName('id').AsInteger;
      M_SWTOWNID := FieldByName('M_SWTOWNID').AsInteger;
      TPTYPE     := FieldByName('TPTYPE').AsInteger;
      name       := FieldByName('name').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;
function CDBase.GetStreetByTpTable(tpID: integer; var pTable:SL3STREETS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    //strSQL := 'SELECT * FROM SL3STREET WHERE m_swTownID=' + IntToStr(TownID) + ' ORDER BY m_sName';
    strSQL := 'SELECT * FROM SL3STREET WHERE M_SWSTREETID in '+
    ' (SELECT M_SWSTREETID from SL3ABON where tpid='+IntToStr(tpID)+')'+
    ' ORDER BY m_sName';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := FieldByName('m_swID').AsInteger;
      m_swTownID   := FieldByName('m_swTownID').AsInteger;
      m_swStreetID := FieldByName('m_swStreetID').AsInteger;
      m_sName      := FieldByName('m_sName').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.GetStreetsTable(TownID: integer; var pTable:SL3STREETS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3STREET WHERE m_swTownID=' + IntToStr(TownID) + ' ORDER BY m_sName';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := FieldByName('m_swID').AsInteger;
      m_swTownID   := FieldByName('m_swTownID').AsInteger;
      m_swStreetID := FieldByName('m_swStreetID').AsInteger;
      m_sName      := FieldByName('m_sName').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.AddStreetTable(var pTable:SL3STREET):Boolean;
Var
    strSQL   : String;
Begin
    if IsStreetTable(pTable)=True then Begin Result := SetStreetTable(pTable);exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3STREET'+
              '(m_swTownID,m_swStreetID,m_sName)'+
              ' VALUES('+
              IntToStr(m_swTownID)+','+
              IntToStr(m_swStreetID)+','+
              ''''+m_sName+''''+')';
    End;
    Result := ExecQry(strSQL);
end;

function CDBase.IsStreetTable(var pTable:SL3STREET):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3STREET WHERE m_swStreetID='+IntToStr(pTable.m_swStreetID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.SetStreetTable(var pTable:SL3STREET):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3STREET SET '+
              ' m_swTownID='  +IntToStr(m_swTownID)+
              ',m_swStreetID='+IntToStr(m_swStreetID)+
              ',m_sName='     +''''+m_sName+''''+
              ' WHERE m_swStreetID=' +IntToStr(m_swStreetID);
   End;
   Result := ExecQry(strSQL);
end;

function CDBase.DelStreetTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then strSQL := 'DELETE FROM SL3STREET WHERE m_swStreetID='+IntToStr(nIndex) else
    if nIndex=-1  then strSQL := 'DELETE FROM SL3STREET';
    Result := ExecQry(strSQL);
end;

function CDBase.GetAbonsTable(var pTable:SL3ABONS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3ABON';
    if (m_dwSort and SRT_ABON)<>0 then strSQL := 'SELECT * FROM SL3ABON ORDER BY m_sName';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swABOID   := FieldByName('m_swABOID').AsInteger;
      m_swPortID  := FieldByName('m_swPortID').AsInteger;
      m_sdtRegDate:= FieldByName('m_sdtRegDate').AsDateTime;
      m_sName     := FieldByName('m_sName').AsString;
//      m_sObject   := FieldByName('m_sObject').AsString;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
//      m_sKSP      := FieldByName('m_sKSP').AsString;
//      m_sDogNum   := FieldByName('m_sDogNum').AsString;
//      m_sPhone    := FieldByName('m_sPhone').AsString;
      m_sAddress  := FieldByName('m_sAddress').AsString;
//      m_sEAddress := FieldByName('m_sEAddress').AsString;
//      m_sShemaPath:= FieldByName('m_sShemaPath').AsString;
//      m_sComment  := FieldByName('m_sComment').AsString;
      m_sTelRing  := FieldByName('m_sTelRing').AsString;
//      m_sRevPhone := FieldByName('m_sRevPhone').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyVisible:= FieldByName('m_sbyVisible').AsInteger;
      m_sReportVS := StrToInt64Def(FieldByName('m_sReportVS').AsString, 0);
//      m_sLIC      := FieldByName('m_sLIC').AsString;
//      m_strOBJCODE:= FieldByName('m_strOBJCODE').AsString;
//      m_sMaxPower := FieldByName('m_sMaxPower').AsFloat;
      m_sTreeSettings := FieldByName('m_sTreeSettings').AsInteger;
      m_sAddrSettings := StrToInt64Def(FieldByName('m_sAddrSettings').AsString, 0);
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetAbonsNamesTable(var pTable:SL3ABONSNAMES):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT m_swABOID, m_sName  FROM SL3ABON ORDER BY m_swABOID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swABOID   := FieldByName('m_swABOID').AsInteger;
      m_sName     := FieldByName('m_sName').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

{*******************************************************************************
 * Получить список абонентов для модуля статистики
 ******************************************************************************}
function CDBase.GetAbonsForStatistic(var pTable:SL3ABONS_STAT):Boolean;
Var
    i : Integer;
    strSQL   : String;
    nCount   : Integer;
Begin
  Result := False;
  strSQL := 'SELECT M_SWABOID,(M_SNAME||'' - ''||M_SOBJECT) M_SFULLNAME FROM SL3ABON WHERE M_SBYVISIBLE>0 ORDER BY M_SNAME';
  pTable.Count := 0;

  if OpenQry(strSQL,nCount)=True then
  Begin
    Result := True;
    i := 0;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);

    while not FADOQuery.Eof do
    Begin
      with FADOQuery,pTable.Items[i] do
      Begin
        m_swABOID   := FieldByName('M_SWABOID').AsInteger;
        m_sName     := FieldByName('M_SFULLNAME').AsString;
        Next;
        Inc(i);
      End;
    End;
  End;
  CloseQry();
End;


{*******************************************************************************
 * Получить список вычислителей по абоненту для модуля статистики
 ******************************************************************************}
function CDBase.GetMetersByAbonForStatistic(var pTable:SL3ABON_STAT):Boolean;
Var
    i : Integer;
    strSQL   : String;
    nCount   : Integer;
Begin
  Result := False;
  strSQL :=
  'select '+
    'sl3vmetertag.m_swmid, '+
    'sl3vmetertag.m_swvmid, '+
    'sl3vmetertag.m_sbyportid, '+
    'sl3vmetertag.m_svmetername '+
  'from sl3grouptag '+
  'left join sl3vmetertag '+
  'on sl3vmetertag.m_sbygroupid=sl3grouptag.m_sbygroupid '+
  'left join l2tag '+
  'on l2tag.m_swmid=sl3vmetertag.m_swmid '+ // and l2tag.m_sbyEnable=1
  'where (sl3grouptag.m_swaboid='+IntToStr(pTable.m_swABOID) +') '+
  'order by (sl3grouptag.m_swaboid)';

  pTable.Count := 0;

  if OpenQry(strSQL,nCount)=True then
  Begin
    Result := True;
    i := 0;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);

    while not FADOQuery.Eof do
    Begin
      with FADOQuery,pTable.Items[i] do
      Begin
        m_swMID       := FieldByName('m_swMID').AsInteger;
        m_swVMID      := FieldByName('m_swVMID').AsInteger;
        m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
        m_sVMeterName := FieldByName('m_sVMeterName').AsString;
        Next;
        Inc(i);
      End;
    End;
  End;
  CloseQry();
End;
{
     M_NABONTYPE     : Integer;
     M_SMARSHNUMBER  : string[10];
     M_SHOUSENUMBER  : string[5];
     M_SKORPUSNUMBER : string[5];
}
function CDBase.GetAbonsTableNS(var pTable:SL3ABONS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT distinct * FROM SL3ABON ORDER BY m_swABOID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swABOID   := FieldByName('m_swABOID').AsInteger;
      m_swPortID  := FieldByName('m_swPortID').AsInteger;
      m_sdtRegDate:= FieldByName('m_sdtRegDate').AsDateTime;
      m_sName     := FieldByName('m_sName').AsString;
//      m_sObject   := FieldByName('m_sObject').AsString;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
      M_SWSTREETID:= FieldByName('M_SWSTREETID').AsInteger;
      M_SWTOWNID  := FieldByName('M_SWTOWNID').AsInteger;
      M_SWDEPID   := FieldByName('M_SWDEPID').AsInteger;
//      m_sKSP      := FieldByName('m_sKSP').AsString;
//      m_sDogNum   := FieldByName('m_sDogNum').AsString;
//      m_sPhone    := FieldByName('m_sPhone').AsString;
      m_sAddress  := FieldByName('m_sAddress').AsString;
//      m_sEAddress := FieldByName('m_sEAddress').AsString;
//      m_sShemaPath:= FieldByName('m_sShemaPath').AsString;
//      m_sComment  := FieldByName('m_sComment').AsString;
      m_sTelRing  := FieldByName('m_sTelRing').AsString;
//      m_sRevPhone := FieldByName('m_sRevPhone').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyVisible:= FieldByName('m_sbyVisible').AsInteger;
      m_sReportVS := StrToInt64Def(FieldByName('m_sReportVS').AsString, 0);
//      m_sLIC      := FieldByName('m_sLIC').AsString;
//      m_strOBJCODE:= FieldByName('m_strOBJCODE').AsString;
//      m_sMaxPower := FieldByName('m_sMaxPower').AsFloat;
      m_sTreeSettings := FieldByName('m_sTreeSettings').AsInteger;
      m_sAddrSettings := StrToInt64Def(FieldByName('m_sAddrSettings').AsString, 0);
      M_NABONTYPE     := FieldByName('M_NABONTYPE').AsInteger;
//      M_SMARSHNUMBER  := FieldByName('M_SMARSHNUMBER').AsString;
      M_SHOUSENUMBER  := FieldByName('M_SHOUSENUMBER').AsString;
      M_SKORPUSNUMBER := FieldByName('M_SKORPUSNUMBER').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
{
                     m_pExportDBF.Items[m_pExportDBF.Count + _nMeterZI].s_AID   := _pAbon.Items[_nAbonI].m_swABOID;
                     m_pExportDBF.Items[m_pExportDBF.Count + _nMeterZI].s_VMID  := _pMeterZ.Item.Items[_nMeterZI].m_swVMID;
                     m_pExportDBF.Items[m_pExportDBF.Count + _nMeterZI].NUMABON := _pAbon.Items[_nAbonI].m_sDogNum;
                     m_pExportDBF.Items[m_pExportDBF.Count + _nMeterZI].ZAVOD   := 'A2K';
                     m_pExportDBF.Items[m_pExportDBF.Count + _nMeterZI].TIP_SC  := '145335';
                     m_pExportDBF.Items[m_pExportDBF.Count + _nMeterZI].NOM_SC  := _pMeterZ.Item.Items[_nMeterZI].m_sddPHAddres;
                     m_pExportDBF.Items[m_pExportDBF.Count + _nMeterZI].UL      := _pAbon.Items[_nAbonI].m_sAddress;
    if nChannel<>-1 then strSQL := 'SELECT SL3VMETERTAG.M_SBYPORTID,SL3VMETERTAG.M_SWMID,SL3VMETERTAG.M_SWVMID,L2TAG.m_sddFabNum,SL3VMETERTAG.M_SVMETERNAME,SL3VMETERTAG.M_SBYTYPE,(L2TAG.M_SFKI*L2TAG.M_SFKU) AS m_sfKTR FROM SL3VMETERTAG,SL3GROUPTAG,L2TAG'+
                                   ' WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
                                   ' and SL3GROUPTAG.m_sbyGroupID='+IntToStr(nChannel)+
                                   ' and L2TAG.M_SWMID=SL3VMETERTAG.M_SWMID'+
                                   ' and SL3VMETERTAG.m_sbyEnable=1 '+
                                   ' and SL3GROUPTAG.M_NGROUPLV=0 '+
                                   ' ORDER BY m_swVMID';
}

function CDBase.GetAbonTable(swABOID:Integer;var pTable:SL3ABONS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3ABON WHERE m_swABOID='+IntToStr(swABOID);
    if (m_dwSort and SRT_ABON)<>0 then strSQL := 'SELECT * FROM SL3ABON WHERE m_swABOID='+IntToStr(swABOID)+' ORDER BY m_sName';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swABOID   := FieldByName('m_swABOID').AsInteger;
      m_swPortID  := FieldByName('m_swPortID').AsInteger;
      m_sdtRegDate:= FieldByName('m_sdtRegDate').AsDateTime;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
      M_SWSTREETID:= FieldByName('M_SWSTREETID').AsInteger;
      M_SWTOWNID  := FieldByName('M_SWTOWNID').AsInteger;
      TPID        := FieldByName('TPID').AsInteger;
      M_SWDEPID   := FieldByName('M_SWDEPID').AsInteger;
      m_sName     := FieldByName('m_sName').AsString;
//      m_sObject   := FieldByName('m_sObject').AsString;
//      m_sKSP      := FieldByName('m_sKSP').AsString;
//      m_sDogNum   := FieldByName('m_sDogNum').AsString;
//      m_sPhone    := FieldByName('m_sPhone').AsString;
      m_sAddress  := FieldByName('m_sAddress').AsString;
//      m_sEAddress := FieldByName('m_sEAddress').AsString;
//      m_sShemaPath:= FieldByName('m_sShemaPath').AsString;
      m_sTelRing  := FieldByName('m_sTelRing').AsString;
//      m_sComment  := FieldByName('m_sComment').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyVisible:= FieldByName('m_sbyVisible').AsInteger;
//      m_sRevPhone := FieldByName('m_sRevPhone').AsString;
      m_sReportVS := StrToInt64Def(FieldByName('m_sReportVS').AsString, 0);
//      m_sLIC      := FieldByName('m_sLIC').AsString;
//      m_strOBJCODE:= FieldByName('m_strOBJCODE').AsString;
//      m_sMaxPower := FieldByName('m_sMaxPower').AsFloat;
      m_sTreeSettings := FieldByName('m_sTreeSettings').AsInteger;
      m_sAddrSettings := StrToInt64Def(FieldByName('m_sAddrSettings').AsString, 0);
      M_NABONTYPE     := FieldByName('M_NABONTYPE').AsInteger;
//      M_SMARSHNUMBER  := FieldByName('M_SMARSHNUMBER').AsString;
      M_SHOUSENUMBER  := FieldByName('M_SHOUSENUMBER').AsString;
      M_SKORPUSNUMBER := FieldByName('M_SKORPUSNUMBER').AsString;
      GORS            := FieldByName('GORS').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetAbonRegTable(nRegionID:Integer;var pTable:SL3ABONS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3ABON WHERE m_nRegionID='+IntToStr(nRegionID);
    if (m_dwSort and SRT_ABON)<>0 then strSQL := 'SELECT * FROM SL3ABON WHERE m_nRegionID='+IntToStr(nRegionID)+' ORDER BY m_sName';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swABOID   := FieldByName('m_swABOID').AsInteger;
      m_swPortID  := FieldByName('m_swPortID').AsInteger;
      m_sdtRegDate:= FieldByName('m_sdtRegDate').AsDateTime;
      m_sName     := FieldByName('m_sName').AsString;
//      m_sObject   := FieldByName('m_sObject').AsString;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
      M_SWSTREETID:= FieldByName('M_SWSTREETID').AsInteger;
      M_SWTOWNID  := FieldByName('M_SWTOWNID').AsInteger;
      M_SWDEPID   := FieldByName('M_SWDEPID').AsInteger;
//      m_sKSP      := FieldByName('m_sKSP').AsString;
//      m_sDogNum   := FieldByName('m_sDogNum').AsString;
//      m_sPhone    := FieldByName('m_sPhone').AsString;
      m_sAddress  := FieldByName('m_sAddress').AsString;
//      m_sEAddress := FieldByName('m_sEAddress').AsString;
//      m_sShemaPath:= FieldByName('m_sShemaPath').AsString;
//      m_sComment  := FieldByName('m_sComment').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyVisible:= FieldByName('m_sbyVisible').AsInteger;
//      m_sRevPhone := FieldByName('m_sRevPhone').AsString;
      m_sReportVS := StrToInt64Def(FieldByName('m_sReportVS').AsString, 0);
//      m_sLIC      := FieldByName('m_sLIC').AsString;
//      m_strOBJCODE:= FieldByName('m_strOBJCODE').AsString;
//      m_sMaxPower := FieldByName('m_sMaxPower').AsFloat;
      m_sTreeSettings := FieldByName('m_sTreeSettings').AsInteger;
      m_sAddrSettings := StrToInt64Def(FieldByName('m_sAddrSettings').AsString, 0);
      M_NABONTYPE     := FieldByName('M_NABONTYPE').AsInteger;
//      M_SMARSHNUMBER  := FieldByName('M_SMARSHNUMBER').AsString;
      M_SHOUSENUMBER  := FieldByName('M_SHOUSENUMBER').AsString;
      M_SKORPUSNUMBER := FieldByName('M_SKORPUSNUMBER').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

{
 M_SWDEPID   : Integer;
     M_SWSTREETID: Integer;
     M_SWTOWNID  : Integer;
}
function CDBase.GetAbonRegTableByAddr(reg,ray,tow,tpid,str:Integer;var pTable:SL3ABONS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3ABON '+
    ' WHERE m_nRegionID='+IntToStr(reg)+
    ' AND M_SWDEPID='+IntToStr(ray)+
    ' AND M_SWSTREETID='+IntToStr(str)+
    ' AND M_SWTOWNID='+IntToStr(tow)+
    ' AND TPID='+IntToStr(tpid);
    //if (m_dwSort and SRT_ABON)<>0 then strSQL := 'SELECT * FROM SL3ABON WHERE m_nRegionID='+IntToStr(nRegionID)+' ORDER BY m_sName';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swABOID   := FieldByName('m_swABOID').AsInteger;
      m_swPortID  := FieldByName('m_swPortID').AsInteger;
      m_sdtRegDate:= FieldByName('m_sdtRegDate').AsDateTime;
      m_sName     := FieldByName('m_sName').AsString;
      //m_sObject   := FieldByName('m_sObject').AsString;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
      M_SWSTREETID:= FieldByName('M_SWSTREETID').AsInteger;
      M_SWTOWNID  := FieldByName('M_SWTOWNID').AsInteger;
      M_SWDEPID   := FieldByName('M_SWDEPID').AsInteger;
      //m_sKSP      := FieldByName('m_sKSP').AsString;
      //m_sDogNum   := FieldByName('m_sDogNum').AsString;
      //m_sPhone    := FieldByName('m_sPhone').AsString;
      m_sAddress  := FieldByName('m_sAddress').AsString;
//      m_sEAddress := FieldByName('m_sEAddress').AsString;
//      m_sShemaPath:= FieldByName('m_sShemaPath').AsString;
//      m_sComment  := FieldByName('m_sComment').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyVisible:= FieldByName('m_sbyVisible').AsInteger;
//      m_sRevPhone := FieldByName('m_sRevPhone').AsString;
      m_sReportVS := StrToInt64Def(FieldByName('m_sReportVS').AsString, 0);
//      m_sLIC      := FieldByName('m_sLIC').AsString;
//      m_strOBJCODE:= FieldByName('m_strOBJCODE').AsString;
//      m_sMaxPower := FieldByName('m_sMaxPower').AsFloat;
      m_sTreeSettings := FieldByName('m_sTreeSettings').AsInteger;
      m_sAddrSettings := StrToInt64Def(FieldByName('m_sAddrSettings').AsString, 0);
      M_NABONTYPE     := FieldByName('M_NABONTYPE').AsInteger;
//      M_SMARSHNUMBER  := FieldByName('M_SMARSHNUMBER').AsString;
      M_SHOUSENUMBER  := FieldByName('M_SHOUSENUMBER').AsString;
      M_SKORPUSNUMBER := FieldByName('M_SKORPUSNUMBER').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;



function CDBase.GetFiltAbonRegTable(nRegionID:Integer;MinF,MaxF:int64;var pTable:SL3ABONS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3ABON WHERE  m_nRegionID='+IntToStr(nRegionID) + ' and   M_SADDRSETTINGS >=' +
        IntToStr(MinF) + ' and M_SADDRSETTINGS <' + IntToStr(MaxF);
    if (m_dwSort and SRT_ABON)<>0 then strSQL := strSQL + ' ORDER BY m_sName';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swABOID   := FieldByName('m_swABOID').AsInteger;
      m_swPortID  := FieldByName('m_swPortID').AsInteger;
      m_sdtRegDate:= FieldByName('m_sdtRegDate').AsDateTime;
      m_sName     := FieldByName('m_sName').AsString;
//      m_sObject   := FieldByName('m_sObject').AsString;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
      M_SWSTREETID:= FieldByName('M_SWSTREETID').AsInteger;
      M_SWTOWNID  := FieldByName('M_SWTOWNID').AsInteger;
      M_SWDEPID   := FieldByName('M_SWDEPID').AsInteger;
//      m_sKSP      := FieldByName('m_sKSP').AsString;
//      m_sDogNum   := FieldByName('m_sDogNum').AsString;
//      m_sPhone    := FieldByName('m_sPhone').AsString;
      m_sAddress  := FieldByName('m_sAddress').AsString;
//      m_sEAddress := FieldByName('m_sEAddress').AsString;
//      m_sShemaPath:= FieldByName('m_sShemaPath').AsString;
//      m_sComment  := FieldByName('m_sComment').AsString;
      m_sTelRing  := FieldByName('m_sTelRing').AsString;
//      m_sRevPhone := FieldByName('m_sRevPhone').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyVisible:= FieldByName('m_sbyVisible').AsInteger;
      m_sReportVS := StrToInt64Def(FieldByName('m_sReportVS').AsString, 0);
//      m_sLIC      := FieldByName('m_sLIC').AsString;
//      m_strOBJCODE:= FieldByName('m_strOBJCODE').AsString;
//      m_sMaxPower := FieldByName('m_sMaxPower').AsFloat;
      m_sTreeSettings := FieldByName('m_sTreeSettings').AsInteger;
      m_sAddrSettings := StrToInt64Def(FieldByName('m_sAddrSettings').AsString, 0);
      M_NABONTYPE     := FieldByName('M_NABONTYPE').AsInteger;
//      M_SMARSHNUMBER  := FieldByName('M_SMARSHNUMBER').AsString;
      M_SHOUSENUMBER  := FieldByName('M_SHOUSENUMBER').AsString;
      M_SKORPUSNUMBER := FieldByName('M_SKORPUSNUMBER').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetFiltAbonRegTable_N(nRegionID,nDepID,nTownID,nStreetID:Integer;var pTable:SL3ABONS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3ABON WHERE  m_nRegionID='+IntToStr(nRegionID) + ' and   M_SWDEPID='+IntToStr(nDepID) +
     ' and   M_SWTOWNID='+IntToStr(nTownID) + ' and   M_SWSTREETID='+IntToStr(nStreetID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swABOID   := FieldByName('m_swABOID').AsInteger;
      m_swPortID  := FieldByName('m_swPortID').AsInteger;
      m_sdtRegDate:= FieldByName('m_sdtRegDate').AsDateTime;
      m_sName     := FieldByName('m_sName').AsString;
//      m_sObject   := FieldByName('m_sObject').AsString;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
      M_SWSTREETID:= FieldByName('M_SWSTREETID').AsInteger;
      M_SWTOWNID  := FieldByName('M_SWTOWNID').AsInteger;
      M_SWDEPID   := FieldByName('M_SWDEPID').AsInteger;
//      m_sKSP      := FieldByName('m_sKSP').AsString;
//      m_sDogNum   := FieldByName('m_sDogNum').AsString;
//      m_sPhone    := FieldByName('m_sPhone').AsString;
      m_sAddress  := FieldByName('m_sAddress').AsString;
//      m_sEAddress := FieldByName('m_sEAddress').AsString;
//      m_sShemaPath:= FieldByName('m_sShemaPath').AsString;
//      m_sComment  := FieldByName('m_sComment').AsString;
      m_sTelRing  := FieldByName('m_sTelRing').AsString;
//      m_sRevPhone := FieldByName('m_sRevPhone').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyVisible:= FieldByName('m_sbyVisible').AsInteger;
      m_sReportVS := StrToInt64Def(FieldByName('m_sReportVS').AsString, 0);
//      m_sLIC      := FieldByName('m_sLIC').AsString;
//      m_strOBJCODE:= FieldByName('m_strOBJCODE').AsString;
//      m_sMaxPower := FieldByName('m_sMaxPower').AsFloat;
      m_sTreeSettings := FieldByName('m_sTreeSettings').AsInteger;
      m_sAddrSettings := StrToInt64Def(FieldByName('m_sAddrSettings').AsString, 0);
      M_NABONTYPE     := FieldByName('M_NABONTYPE').AsInteger;
//      M_SMARSHNUMBER  := FieldByName('M_SMARSHNUMBER').AsString;
      M_SHOUSENUMBER  := FieldByName('M_SHOUSENUMBER').AsString;
      M_SKORPUSNUMBER := FieldByName('M_SKORPUSNUMBER').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetFiltAbonRegTable_N_TP(nRegionID,nDepID,nTownID,nTpID:Integer;var pTable:SL3ABONS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3ABON WHERE  m_nRegionID='+IntToStr(nRegionID) + ' and   M_SWDEPID='+IntToStr(nDepID) +
     ' and   M_SWTOWNID='+IntToStr(nTownID)+'and TPID='+IntToStr(nTpID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swABOID   := FieldByName('m_swABOID').AsInteger;
      m_swPortID  := FieldByName('m_swPortID').AsInteger;
      m_sdtRegDate:= FieldByName('m_sdtRegDate').AsDateTime;
      m_sName     := FieldByName('m_sName').AsString;
//      m_sObject   := FieldByName('m_sObject').AsString;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
      M_SWSTREETID:= FieldByName('M_SWSTREETID').AsInteger;
      M_SWTOWNID  := FieldByName('M_SWTOWNID').AsInteger;
      M_SWDEPID   := FieldByName('M_SWDEPID').AsInteger;
//      m_sKSP      := FieldByName('m_sKSP').AsString;
//      m_sDogNum   := FieldByName('m_sDogNum').AsString;
//      m_sPhone    := FieldByName('m_sPhone').AsString;
      m_sAddress  := FieldByName('m_sAddress').AsString;
//      m_sEAddress := FieldByName('m_sEAddress').AsString;
//      m_sShemaPath:= FieldByName('m_sShemaPath').AsString;
//      m_sComment  := FieldByName('m_sComment').AsString;
      m_sTelRing  := FieldByName('m_sTelRing').AsString;
//      m_sRevPhone := FieldByName('m_sRevPhone').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyVisible:= FieldByName('m_sbyVisible').AsInteger;
      m_sReportVS := StrToInt64Def(FieldByName('m_sReportVS').AsString, 0);
//      m_sLIC      := FieldByName('m_sLIC').AsString;
//      m_strOBJCODE:= FieldByName('m_strOBJCODE').AsString;
//      m_sMaxPower := FieldByName('m_sMaxPower').AsFloat;
      m_sTreeSettings := FieldByName('m_sTreeSettings').AsInteger;
      m_sAddrSettings := StrToInt64Def(FieldByName('m_sAddrSettings').AsString, 0);
      M_NABONTYPE     := FieldByName('M_NABONTYPE').AsInteger;
//      M_SMARSHNUMBER  := FieldByName('M_SMARSHNUMBER').AsString;
      M_SHOUSENUMBER  := FieldByName('M_SHOUSENUMBER').AsString;
      M_SKORPUSNUMBER := FieldByName('M_SKORPUSNUMBER').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.IsAbonTable(var pTable:SL3ABON):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3ABON WHERE m_swABOID='+IntToStr(pTable.m_swABOID);
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
function CDBase.SetAbonTable(var pTable:SL3ABON):Boolean;
Var
    strSQL : String;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3ABON SET '+
              ' m_swABOID='   +IntToStr(m_swABOID)+
              ',m_swPortID='  +IntToStr(m_swPortID)+
              ',m_nRegionID=' +IntToStr(m_nRegionID)+
              ',m_sdtRegDate='+''''+DateTimeToStr(m_sdtRegDate)+''''+
              ',m_sName='     +''''+m_sName+''''+
//              ',m_sObject='   +''''+m_sObject+''''+
//              ',m_sKSP='      +''''+m_sKSP+''''+
//              ',m_sDogNum='   +''''+m_sDogNum+''''+
//              ',m_sPhone='    +''''+m_sPhone+''''+
              ',m_sAddress='  +''''+m_sAddress+''''+
//              ',m_sEAddress=' +''''+m_sEAddress+''''+
//              ',m_sShemaPath='+''''+m_sShemaPath+''''+
//              ',m_sComment='  +''''+m_sComment+''''+
              ',m_sTelRing='  +''''+m_sTelRing+''''+
//              ',m_sRevPhone=' +''''+m_sRevPhone+''''+
              ',m_sbyEnable=' +IntToStr(m_sbyEnable)+
              ',m_sbyVisible=' +IntToStr(m_sbyVisible)+
              ',m_sReportVS=' + IntToStr(m_sReportVS)+
//              ',m_sLIC='   +''''+m_sLIC+''''+
//              ',m_strOBJCODE='   +''''+m_strOBJCODE+''''+
//              ',m_sMaxPower=' + FloatToStr(m_sMaxPower)+
              ',m_sTreeSettings=' + IntToStr(m_sTreeSettings)+
              ',m_sAddrSettings=' + IntToStr(m_sAddrSettings)+
              ',M_NABONTYPE=' + IntToStr(M_NABONTYPE)+
//              ',M_SMARSHNUMBER=' +''''+M_SMARSHNUMBER+''''+
              ',M_SHOUSENUMBER=' +''''+M_SHOUSENUMBER+''''+
              ',M_SKORPUSNUMBER=' +''''+M_SKORPUSNUMBER+''''+
              ' WHERE m_swABOID=' +IntToStr(m_swABOID);
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.SetAbonNmTable(var pTable:SL3ABON):Boolean;
Var
    strSQL : String;
Begin
    if IsAbonTable(pTable)=True then
    Begin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3ABON SET '+
              ' m_swABOID='   +IntToStr(m_swABOID)+
              ',m_sName='     +''''+m_sName+''''+
              ',m_sObject='   +''''+m_sObject+''''+
              ',m_sbyEnable=' +IntToStr(m_sbyEnable)+
              ' WHERE m_swABOID=' +IntToStr(m_swABOID);
    End;
    Result := ExecQry(strSQL);
    End;
End;
function CDBase.AddAbonTable(var pTable:SL3ABON):Boolean;
Var
    strSQL : String;
Begin
    if IsAbonTable(pTable)=True then Begin Result := False; SetAbonTable(pTable);exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3ABON'+
              '(m_swABOID,m_nRegionID,m_swPortID,m_sdtRegDate,m_sName,m_sAddress,m_sTelRing,m_sbyVisible,m_sReportVS' +
              ',m_sbyEnable,m_sTreeSettings,M_NABONTYPE,M_SHOUSENUMBER,M_SKORPUSNUMBER,m_sAddrSettings)'+
              ' VALUES('+
              IntToStr(m_swABOID)+ ','+
              IntToStr(m_nRegionID)+ ','+
              IntToStr(m_swPortID)+ ','+
              ''''+DateTimeToStr(m_sdtRegDate)+''''+','+
              ''''+m_sName+''''+ ','+
//              ''''+m_sObject+''''+ ','+
//              ''''+m_sKSP+''''+ ','+
//              ''''+m_sDogNum+''''+ ','+
//              ''''+m_sPhone+''''+ ','+
              ''''+m_sAddress+''''+ ','+
//              ''''+m_sEAddress+''''+ ','+
//              ''''+m_sShemaPath+''''+ ','+
//              ''''+m_sComment+''''+ ','+
              ''''+m_sTelRing+''''+ ','+
//              ''''+m_sRevPhone+''''+','+
              IntToStr(m_sbyVisible)+ ','+
              IntToStr(m_sReportVS)+','+
//              ''''+m_sLIC+''''+ ','+
//              ''''+m_strOBJCODE+''''+ ','+
              IntToStr(m_sbyEnable)+','+
//              FloatToStr(m_sMaxPower)+','+
              IntToStr(m_sTreeSettings)+','+
              IntToStr(M_NABONTYPE)+','+
//              ''''+M_SMARSHNUMBER+''''+ ','+
              ''''+M_SHOUSENUMBER+''''+ ','+
              ''''+M_SKORPUSNUMBER+''''+ ','+
              IntToStr(m_sAddrSettings)+')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelTpTable(swTPID:Integer):Boolean;
Var
    strSQL : String;
Begin
    if swTPID<>-1 then
    Begin
     strSQL := 'DELETE FROM SL3ABON WHERE TPID='+IntToStr(swTPID);
     Result := ExecQry(strSQL);
     
     strSQL := 'DELETE FROM SL3TP WHERE ID='+IntToStr(swTPID);
     Result := ExecQry(strSQL);
    End;
End;

function CDBase.AbonTpId(swTPID:integer):String;
Var
    strSQL   : String;
    nCount   : Integer;
Begin
     strSQL := 'Select NAME FROM SL3TP WHERE ID='+IntToStr(swTPID);
    if OpenQry(strSQL,nCount)=True then
    Begin
      Result := FADOQuery.FieldByName('NAME').AsString;
    End;
    CloseQry;
End;



function CDBase.AbonDepCode(DepName:string):String;
Var
    strSQL   : String;
    nCount   : Integer;
Begin
     strSQL := 'Select CODE FROM SL3DEPARTAMENT WHERE M_SNAME='+''''+DepName+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
      Result := FADOQuery.FieldByName('CODE').AsString;
    End;
    CloseQry;
End;



function CDBase.DelAbonTable(swABOID:Integer):Boolean;
Var
    strSQL : String;
Begin
    if swABOID<>-1 then strSQL := 'DELETE FROM SL3ABON WHERE m_swABOID='+IntToStr(swABOID);
    if swABOID=-1  then strSQL := 'DELETE FROM SL3ABON ';
    Result := ExecQry(strSQL);
End;
function CDBase.SetAbonParam(swABOID:Integer;str:String):Boolean;
Var
    strSQL  : String;
    strPred : String;
Begin
    if (swABOID<>-1) then strPred := ' WHERE m_swABOID='+IntToStr(swABOID);
    strSQL := 'UPDATE SL3ABON SET '+str+strPred;
    Result := ExecQry(strSQL);
End;
//m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_sdtBegin='+''''+DateTimeToStr(dtm_sdtBegin.DateTime)+'''');
function CDBase.GetGroup(nGID:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    res : Boolean;
    i   : Integer;
Begin
    res := False;
   { if GetVMetersTable(nGID,pTable)=True then           // JKLJKL
    Begin
     with pTable do for i:=0 to Item.Count-1 do
     begin
     GetVParamsTable(Item.Items[i].m_swVMID,Item.Items[i]);
     end;
     res := True;
    End;
    Result := res; }

    if GetVMetersTableWithParams(nGID,pTable)=True then res := True;
    Result := res;
End;
function CDBase.GetGroupTreeSett(nGID:Integer):int64;
var strSQL    : string;
    nCount    : Integer;
begin
    Result := 0;
    strSQL := 'select distinct sl3abon.m_streesettings from sl3abon,sl3grouptag where sl3abon.m_swaboid = sl3grouptag.m_swaboid and ' +
              'sl3grouptag.m_sbygroupid =' + IntToStr(nGID);
    if OpenQry(strSQL,nCount)=True then
    Begin
      Result := FADOQuery.FieldByName('m_streesettings').AsInteger;
    End;
    CloseQry;
end;
function CDBase.GetAddressSett(nABOID:Integer):int64;
var strSQL    : string;
    nCount    : Integer;
begin
   Result := 0;
   strSQL := 'select m_sAddrSettings from sl3abon where m_swaboid=' + IntToStr(nABOID);

   if OpenQry(strSQL,nCount)=True then
   Begin
     Result := StrToInt64Def(FADOQuery.FieldByName('m_sAddrSettings').AsString, 0);
   End;
   CloseQry;
end;
function CDBase.GetAbonTag(nAbon:Integer;var pTable:SL3INITTAG):Boolean;
Var
    res   : Boolean;
    i,j,k : Integer;
Begin
    res := False;
    if GetAbonGroupsTable(nAbon,pTable)=True then //Get Group
    Begin
     res := True;
     //for i:=0 to pTable.Count-1 do
     //if GetVMetersTable(pTable.Items[i].m_sbyGroupID,pTable.Items[i])=True then //Get VMeter
     //with pTable.Items[i] do for j:=0 to Item.Count-1 do GetVParamsTable(Item.Items[j].m_swVMID,Item.Items[j]);//Get VParams
    End;
    Result := res;
End;
function CDBase.GetAbonGroupsTable(swABOID:Integer;var pTable:SL3INITTAG):Boolean;
Var
    strSQL,strSRT : String;
    res      : Boolean;
    nCount,i : Integer;
Begin
    //strSQL := 'SELECT * FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(swABOID)+' ORDER BY m_sbyGroupID';
    strSRT := 'm_swPosition';
    if (m_dwSort and SRT_GRUP)<>0 then strSRT := 'm_swPosition,m_sGroupName';
    strSQL := 'SELECT * FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(swABOID)+' ORDER BY '+strSRT;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      m_sbyID         := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      m_swABOID       := FieldByName('m_swABOID').AsInteger;
      m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      m_swPLID        := FieldByName('m_swPLID').AsInteger;
      m_swPosition    := FieldByName('m_swPosition').AsInteger;
      M_NGROUPLV      := FieldByName('M_NGROUPLV').AsInteger;
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
function CDBase.GetAbonGroupsTableNS(swABOID:Integer;var pTable:SL3INITTAG):Boolean;
Var
    strSQL,strSRT : String;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT * FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(swABOID)+' ORDER BY m_sbyGroupID';
    {
    strSRT := 'm_swPosition';
    if (m_dwSort and SRT_GRUP)<>0 then strSRT := 'm_swPosition,m_sGroupName';
    strSQL := 'SELECT * FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(swABOID)+' ORDER BY '+strSRT;
    }
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      m_sbyID         := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      m_swABOID       := FieldByName('m_swABOID').AsInteger;
      m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      m_swPLID        := FieldByName('m_swPLID').AsInteger;
      m_swPosition    := FieldByName('m_swPosition').AsInteger;
      M_NGROUPLV      := FieldByName('M_NGROUPLV').AsInteger;
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
function CDBase.GetGroupsTable(var pTable:SL3INITTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount,i : Integer;
Begin
    res:=False;
    pTable.Count := 0;
    strSQL := 'SELECT * FROM SL3GROUPTAG ORDER BY m_sbyGroupID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      m_sbyID         := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      m_swPLID        := FieldByName('m_swPLID').AsInteger;
      m_swPosition    := FieldByName('m_swPosition').AsInteger;
      M_NGROUPLV      := FieldByName('M_NGROUPLV').AsInteger;
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
function CDBase.GetGroupsAbonTable(nABOID:Integer;var pTable:SL3INITTAG1):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount,i : Integer;
Begin
    res:=False;
    pTable.Count := 0;
    strSQL := 'SELECT s1.*,s0.M_STREESETTINGS,s0.M_SREPORTVS'+
    ' FROM sl3abon as s0,SL3GROUPTAG as s1'+
    ' WHERE s1.m_swABOID=s0.m_swABOID'+
    ' AND s1.m_swABOID='+IntToStr(nABOID)+
    ' ORDER BY s1.m_sbyGroupID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      m_sbyID         := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      m_swPLID        := FieldByName('m_swPLID').AsInteger;
      m_swPosition    := FieldByName('m_swPosition').AsInteger;
      M_NGROUPLV      := FieldByName('M_NGROUPLV').AsInteger;
      m_sGroupName    := FieldByName('m_sGroupName').AsString;
      m_sGroupExpress := FieldByName('m_sGroupExpress').AsString;
      m_sbyEnable     := FieldByName('m_sbyEnable').AsInteger;
      m_sReportVS     := StrToInt64Def(FieldByName('m_sReportVS').AsString,0);
      M_STREESETTINGS := FieldByName('M_STREESETTINGS').AsInteger;
      Inc(i);
      Next;
     End;
     End;
    res := True;
    End;
    CloseQry;
    if res=True then GetAbonVMetersTable1(nABOID,-1,pTable.Items[0]);
   Result := res;
End;

//QUERYGROUP
function CDBase.GetQueryGroups(groupID:Integer; var pTable:TThreadList):Boolean;
Var
    strSQL : String;
    strWhere : String;
    res    : Boolean;
    nCount : Integer;
    //list   : TThreadList;
    data   : QUERYGROUP;
Begin
    res := false;
    strWhere := '';
    if groupID<>-1 then strWhere := ' where id='+IntToStr(groupID);
    strSQL := 'SELECT * FROM QUERYGROUP '+strWhere+' ORDER BY name';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      data           := QUERYGROUP.Create;
      data.id        := FADOQuery.FieldByName('id').AsInteger;
      data.name      := FADOQuery.FieldByName('name').AsString;
      data.enable    := FADOQuery.FieldByName('enable').AsInteger;
      data.STATPARAM := FADOQuery.FieldByName('STATPARAM').AsInteger;
      data.DateQuery := FADOQuery.FieldByName('DATEQUERY').AsDateTime;     // BO 12/12/18
      data.ErrorQuery:= FADOQuery.FieldByName('ERRORQUERY').AsInteger;     // BO 12/12/18
      FADOQuery.Next;
      pTable.LockList.Add(data);
      pTable.UnLockList;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;
{
QGABONS = class
    public
      ID       : INTEGER;
      ABOID    : INTEGER;
      ABONM    : String;
      QGID     : INTEGER;
    End;

CREATE TABLE QGABONS (
    ID           INTEGER NOT NULL,
    ABOID        INTEGER,
    QGID         INTEGER,
    ENABLE       INTEGER,
    DTBEGINH     TIMESTAMP,
    DTENDH       TIMESTAMP,
    DTBEGINC     TIMESTAMP,
    DTENDC       TIMESTAMP,
    COUNTERNAME  VARCHAR(100),
    DESCRIPTION  VARCHAR(100),
    STATE        INTEGER
);

    QGABONS = class
    public
      ID          : INTEGER;
      ABOID       : INTEGER;
      ABONM       : String;
      QGID        : INTEGER;
      DTBEGINH    : TDateTime;
      DTENDH      : TDateTime;
      ALLCOUNTER  : INTEGER;
      ISOK        : INTEGER;
      ISNO        : INTEGER;
      ISER        : INTEGER;
      PERCENT     : Double;
      DESCRIPTION : String;
      STATE       : Integer;
      ENABLE      : INTEGER;
    End;
    ' AND s0.M_NREGIONID=s2.M_NREGIONID'+
              ' AND s0.M_SWDEPID=s3.M_SWDEPID'+
              ' AND s0.M_SWTOWNID=s4.M_SWTOWNID'+
              ' AND s0.M_SWSTREETID=s5.M_SWSTREETID
                   QUERY_STATE_OK = 0;
     QUERY_STATE_NO = 1;
     QUERY_STATE_ER = 2;
}
function CDBase.GetQueryAbons(groupID:Integer; var pTable:TThreadList):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
    data   : QGABONS;
    regNM,aboNM,depNM,townNM,streetNM : String;
    dbIsOk : Double;
    dbIsNo : Double;
    dbIsEr : Double;
    dbAllCt: Double;
Begin
    res := false;
    strSQL := 'SELECT'+
    ' s0.DTBEGINH,s0.DTENDH,s0.DESCRIPTION,s0.STATE,s0.ENABLE,s0.CURCOUNTER,'+
    ' s0.id,s0.QGID,s0.ABOID,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and M_SWABOID=s0.ABOID) as ALLCOUNTER,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_OK)+' and M_SWABOID=s0.ABOID) as ISOK,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_NO)+' and M_SWABOID=s0.ABOID) as ISNO,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_ER)+' and M_SWABOID=s0.ABOID) as ISER,'+
    ' s1.M_SNAME as aboNM,s4.M_SNAME as townNM,s5.M_SNAME as streetNM'+
    ' FROM QGABONS as s0,SL3ABON as s1,'+
    ' SL3REGION as s2,SL3DEPARTAMENT as s3,SL3TOWN as s4,SL3STREET as s5'+
    ' where s0.QGID='+IntToStr(groupID)+
    ' and s0.ABOID=s1.M_SWABOID'+
    ' AND s1.M_NREGIONID=s2.M_NREGIONID'+
    ' AND s1.M_SWDEPID=s3.M_SWDEPID'+
    ' AND s1.M_SWTOWNID=s4.M_SWTOWNID'+
    ' AND s1.M_SWSTREETID=s5.M_SWSTREETID'+
    ' ORDER BY s0.ABOID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      data             := QGABONS.Create;
      data.id          := FADOQuery.FieldByName('id').AsInteger;
      data.QGID        := FADOQuery.FieldByName('QGID').AsInteger;
      data.ABOID       := FADOQuery.FieldByName('ABOID').AsInteger;
      aboNM            := FADOQuery.FieldByName('aboNM').AsString;
      //regNM            := FADOQuery.FieldByName('regNM').AsString;
      //depNM            := FADOQuery.FieldByName('depNM').AsString;
      townNM           := FADOQuery.FieldByName('townNM').AsString;
      streetNM         := FADOQuery.FieldByName('streetNM').AsString;
      data.ABONM       := townNM+'/'+streetNM+'/'+aboNM;
      data.DTBEGINH    := FADOQuery.FieldByName('DTBEGINH').AsDateTime;
      data.DTENDH      := FADOQuery.FieldByName('DTENDH').AsDateTime;
      data.ALLCOUNTER  := FADOQuery.FieldByName('ALLCOUNTER').AsInteger;
      data.ISOK        := FADOQuery.FieldByName('ISOK').AsInteger;
      data.ISNO        := FADOQuery.FieldByName('ISNO').AsInteger;
      data.ISER        := FADOQuery.FieldByName('ISER').AsInteger;
      //data.PERCENT     := FADOQuery.FieldByName('PERCENT').AsFloat;
      dbAllCt          := data.ALLCOUNTER;
      dbIsOk           := data.ISOK;
      dbIsNo           := data.ISNO;
      data.PERCENT     := 100*(dbAllCt-dbIsNo)/dbAllCt;
      data.QUALITY     := 100*dbIsOk/dbAllCt;
      data.CURCOUNTER  := FADOQuery.FieldByName('CURCOUNTER').AsString;
      data.DESCRIPTION := FADOQuery.FieldByName('DESCRIPTION').AsString;
      data.STATE       := FADOQuery.FieldByName('STATE').AsInteger;
      data.ENABLE      := FADOQuery.FieldByName('ENABLE').AsInteger;
      FADOQuery.Next;
      pTable.LockList.Add(data);
      pTable.UnLockList;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.getQueryGroupsParam(groupID,paramID:Integer; var pTable:TThreadList):Boolean;
Var strSQL : String;
    strParam : String;
    res    : Boolean;
    nCount : Integer;
    data   : QGPARAM;
Begin
    res := false;
    if(paramID<>-1) then strParam := ' and PARAM='+IntToStr(paramID);
    strSQL := 'SELECT QGPARAM.*,QM_PARAMS.M_SNAME FROM QGPARAM,QM_PARAMS'+
    ' where QGID='+IntToStr(groupID)+
    ' and PARAM=M_SWTYPE'+
    strParam+
    ' ORDER BY param';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      data             := QGPARAM.Create;
      data.id          := FADOQuery.FieldByName('id').AsInteger;
      data.QGID        := FADOQuery.FieldByName('QGID').AsInteger;
      data.PARAM       := FADOQuery.FieldByName('PARAM').AsInteger;
      data.PARAMNM     := FADOQuery.FieldByName('M_SNAME').AsString;
      data.DTBEGIN     := FADOQuery.FieldByName('DTBEGIN').AsDateTime;
      data.DTEND       := FADOQuery.FieldByName('DTEND').AsDateTime;
      data.DTPERIOD    := FADOQuery.FieldByName('DTPERIOD').AsDateTime;
      data.DAYMASK     := FADOQuery.FieldByName('DAYMASK').AsInteger;
      data.MONTHMASK   := FADOQuery.FieldByName('MONTHMASK').AsInteger;
      data.ENABLE      := FADOQuery.FieldByName('ENABLE').AsInteger;
      data.DEEPFIND    := FADOQuery.FieldByName('DEEPFIND').AsInteger;
      data.PAUSE       := FADOQuery.FieldByName('PAUSE').AsInteger;
      data.FINDDATA    := FADOQuery.FieldByName('FINDDATA').AsInteger;
      data.UNDEEPFIND  := FADOQuery.FieldByName('UNDEEPFIND').AsInteger;
      data.UNPATH      := FADOQuery.FieldByName('UNPATH').AsString;
      data.UNENABLE    := FADOQuery.FieldByName('UNENABLE').AsInteger;
      data.ISRUNSTATUS := FADOQuery.FieldByName('ISRUNSTATUS').AsInteger;
      data.RUNSTATUS   := FADOQuery.FieldByName('RUNSTATUS').AsString;
      data.ERRORPERCENT:= FADOQuery.FieldByName('ERRORPERCENT').AsFloat;
      data.TIMETOSTOP  := FADOQuery.FieldByName('TIMETOSTOP').AsDateTime;
      data.PACKETK     := FADOQuery.FieldByName('PACK_KUB').AsInteger;
      data.ERRORPERCENT2:= FADOQuery.FieldByName('ERRORPERCENT2').AsFloat;
      FADOQuery.Next;
      pTable.LockList.Add(data);
      pTable.UnLockList;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.delQueryGroup(groupID:Integer):Boolean;
Var
    strSQL : String;
    strWhere : String;
    res    : Boolean;
Begin
    res := false;
    strWhere := '';
    if groupID<>-1 then strWhere := ' where id='+IntToStr(groupID);
    strSQL := 'DELETE FROM QUERYGROUP '+strWhere;
    Result := ExecQry(strSQL)
End;

function CDBase.delQueryGroupParams(groupID:Integer):Boolean;
Var
    strSQL : String;
    res    : Boolean;
Begin
    res := false;
    strSQL := 'DELETE FROM QGPARAM where QGID='+IntToStr(groupID);
    Result := ExecQry(strSQL)
End;

function CDBase.setQueryState(aid,mid,qState:Integer):Boolean;
Var
    strSQL,sqlQuery : String;
Begin
    if(mid=-1)  then sqlQuery := ' m_swABOID='+IntToStr(aid);
    if(mid<>-1) then sqlQuery := ' M_SWMID='+IntToStr(mid);
    strSQL := 'update l2tag set QUERYSTATE='+IntToStr(qState)+' where'+sqlQuery;
    Result := ExecQry(strSQL);
End;

function CDBase.setQueryGroupAbonsState(groupID,aboid,state:Integer):Boolean;
Var
    strSQL,sql : String;
    res    : Boolean;
Begin
    res := false;
    if (groupID=-1) then exit;
    if (aboid=-1)  then sql := ' where QGID='+IntToStr(groupID);
    if (aboid<>-1) then sql := ' where aboid='+IntToStr(aboid);

    if (aboid=-1) then
    begin
      strSQL:='UPDATE QGABONS SET ENABLE='+IntToStr(state)+', ENABLE_PROG='+IntToStr(state)
      +' where QGABONS.aboid in (SELECT distinct s0.ABOID from QGABONS as s0, l2tag as s1'
      +' where s0.QGID='+IntToStr(groupID)+' and s1.M_SBYTYPE=17 and s1.M_SWABOID=s0.ABOID)';
      Result := ExecQry(strSQL);
    end;
    strSQL := 'UPDATE QGABONS SET ENABLE='+IntToStr(state)+sql;
              //' where aboid='+IntToStr(aboid);
              //' where QGID='+IntToStr(groupID)+
              //' and aboid='+IntToStr(aboid);
    Result := ExecQry(strSQL)
End;

function CDBase.setQueryGroupAbonsStateProg(groupID,aboid,state:Integer):Boolean;
Var
    strSQL,sql : String;
    res    : Boolean;
Begin
    res := false;
    if (groupID=-1) then exit;
    if (aboid=-1)  then sql := ' where QGID='+IntToStr(groupID);
    if (aboid<>-1) then sql := ' where aboid='+IntToStr(aboid);
    strSQL := 'UPDATE QGABONS SET ENABLE_PROG='+IntToStr(state)+sql;
              //' where aboid='+IntToStr(aboid);
              //' where QGID='+IntToStr(groupID)+
              //' and aboid='+IntToStr(aboid);
    Result := ExecQry(strSQL);
End;

function CDBase.delQueryGroupAbons(groupID,aboid:Integer):Boolean;
Var
    strSQL : String;
    res    : Boolean;
Begin
    res := false;
    strSQL := 'DELETE FROM QGABONS '+
              ' where QGID='+IntToStr(groupID)+
              ' and aboid='+IntToStr(aboid);
    Result := ExecQry(strSQL);
End;

function CDBase.SetQueryGroupAbonsNoGSM(aboid:Integer):Boolean;
Var
    strSQL : String;
Begin
    if (aboid=-1)then
     strSQL := 'UPDATE SL3ABON SET IDCHANNELGSM = -1'
    else
     strSQL := 'UPDATE SL3ABON SET IDCHANNELGSM = -1 WHERE M_SWABOID = ' + IntToStr(aboid);
    Result := ExecQry(strSQL);
End;


function CDBase.GetQueryGroupAbons(groupID,aboid:Integer; var str:string):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount   : Integer;
Begin
    res := false;
    strSQL := 'SELECT QUERYQUALITY FROM SL3ABON '+
              ' WHERE M_SWABOID='+IntToStr(aboid);
    if OpenQry(strSQL,nCount)=True then
    with FADOQuery do
      Begin
       str :=FieldByName('QUERYQUALITY').AsString;;
       res := true;
      End;
    CloseQry;
    Result:=res;    
End;

function CDBase.SetQueryGroupAbons(AbonID: integer;str:string):Boolean;
Var
    strSQL : String;
Begin
    strSQL := 'UPDATE SL3ABON SET QUERYQUALITY = ''' + str + ''' WHERE M_SWABOID = ' + IntToStr(AbonID);
    Result := ExecQry(strSQL);
End;

function CDBase.GetEnable(gGroup:integer;var pTable:TThreadList):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
    data   : QGABONS;
Begin
    res := false;
    strSQL := 'SELECT ABOID FROM QGABONS where QGID='+IntToStr(gGroup)+' and ENABLE=1';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do
     Begin
      data := QGABONS.Create;
      data.ABOID  := FADOQuery.FieldByName('ABOID').AsInteger;
      FADOQuery.Next;
      pTable.LockList.Add(data);
      pTable.UnLockList;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetAbonGroup(gGroup:integer;var pTable:TThreadList):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
    data   : QGABONS;
Begin
    res := false;
    strSQL := 'SELECT ABOID FROM QGABONS where QGID='+IntToStr(gGroup);
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do
     Begin
      data := QGABONS.Create;
      data.ABOID  := FADOQuery.FieldByName('ABOID').AsInteger;
      FADOQuery.Next;
      pTable.LockList.Add(data);
      pTable.UnLockList;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.setQueryQroupState(id:Integer;state:Integer):Integer;
Var
    strSql : String;
Begin
    if (id=-1) then exit;
    strSql := 'update QGABONS set STATE='+IntToStr(state)+
              ' where QGID='+IntToStr(id);
    ExecQry(strSQL);
    Result := 1;
End;


function CDBase.addQueryGroup(pTable:QueryGroup):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
    id := -1;
    if(pTable.id=-1) then strMatch := 'matching (name)' else
    Begin
     keyField := 'id,';
     keyData  := IntToStr(pTable.id)+',';
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO QUERYGROUP'+
              '('+keyField+'name,enable)'+
              ' VALUES('+keyData+
              ''''+name+''''+ ','+
              IntToStr(enable)+ ') '+strMatch;
    End;
    ExecQry(strSQL);
    Result := 1;
End;

function CDBase.addQueryGroupAbon(pTable:QGABONS):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
    id := -1;
    if(pTable.id=-1) then strMatch := 'matching (QGID,ABOID)' else
    Begin
     keyField := 'id,';
     keyData  := IntToStr(pTable.id)+',';
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO QGABONS'+
              '('+keyField+'QGID,ABOID,DTBEGINH,DTENDH,'+
              'CURCOUNTER,DESCRIPTION,STATE,ENABLE)'+
              ' VALUES('+keyData+
              IntToStr(QGID)+ ','+
              IntToStr(ABOID)+ ','+
              ''''+DateTimeToStr(DTBEGINH)+''''+ ','+
              ''''+DateTimeToStr(DTENDH)+''''+ ','+
              ''''+CURCOUNTER+''''+','+
              ''''+DESCRIPTION+''''+ ','+
              IntToStr(STATE)+ ','+
              IntToStr(ENABLE)+
              ') '+strMatch;
    End;
    ExecQry(strSQL);
    Result := 1;
End;
function CDBase.addQueryGroupAbonReject(pTable:QGABONS):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
    id := -1;
    if(pTable.id=-1) then strMatch := 'matching (QGID,ABOID)' else
    Begin
     keyField := 'id,';
     keyData  := IntToStr(pTable.id)+',';
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO QGABONS_REJECT'+
              '('+keyField+'QGID,ABOID,DTBEGINH,DTENDH,'+
              'CURCOUNTER,DESCRIPTION,STATE,ENABLE)'+
              ' VALUES('+keyData+
              IntToStr(QGID)+ ','+
              IntToStr(ABOID)+ ','+
              ''''+DateTimeToStr(DTBEGINH)+''''+ ','+
              ''''+DateTimeToStr(DTENDH)+''''+ ','+
              ''''+CURCOUNTER+''''+','+
              ''''+DESCRIPTION+''''+ ','+
              IntToStr(STATE)+ ','+
              IntToStr(ENABLE)+
              ') '+strMatch;
    End;
    ExecQry(strSQL);
    Result := 1;
End;

function CDBase.addQueryGroupParam(pTable:QGPARAM):Integer;
Var
    strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch,keyField,keyData : String;
Begin
    id := -1;
    if(pTable.id=-1) then strMatch := 'matching (QGID,PARAM)' else
    Begin
     keyField := 'id,';
     keyData  := IntToStr(pTable.id)+',';
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO QGPARAM'+
              '('+keyField+'QGID,PARAM,DTBEGIN,DTEND,DTPERIOD,'+
              'DAYMASK,MONTHMASK,ENABLE,DEEPFIND,PAUSE,FINDDATA,UNDEEPFIND,UNPATH,UNENABLE,ISRUNSTATUS,RUNSTATUS,ERRORPERCENT,ERRORPERCENT2,TIMETOSTOP)'+
              ' VALUES('+keyData+
              IntToStr(QGID)+ ','+
              IntToStr(PARAM)+ ','+
              ''''+DateTimeToStr(DTBEGIN)+''''+','+
              ''''+DateTimeToStr(DTEND)+''''+','+
              ''''+DateTimeToStr(DTPERIOD)+''''+','+
              IntToStr(DAYMASK)+ ','+
              IntToStr(MONTHMASK)+ ','+
              IntToStr(ENABLE)+ ','+
              IntToStr(DEEPFIND)+ ','+
              IntToStr(PAUSE)+ ','+
              IntToStr(FINDDATA)+ ','+
              IntToStr(UNDEEPFIND)+ ','+
              ''''+UNPATH+''''+','+
              IntToStr(UNENABLE)+','+
              IntToStr(ISRUNSTATUS)+','+
              ''''+RUNSTATUS+''''+','+
              FloatToStr(ERRORPERCENT)+ ','+
              FloatToStr(ERRORPERCENT2)+ ','+
              ''''+DateTimeToStr(TIMETOSTOP)+''''+') '+strMatch;
    End;
    ExecQry(strSQL);
    Result := 1;
End;

function CDBase.updateGQParams(groupID,qgParamID:Integer;field:String):Integer;
Var
    strSQL : String;
    sqlAdd : String;
    res    : Boolean;
Begin
    if (groupID<>-1) then sqlAdd := ' and QGID='+IntToStr(groupID);
    strSQL := 'update QGPARAM set '+field+ ' where PARAM='+IntToStr(qgParamID)+sqlAdd;
    ExecQry(strSQL);
    Result := 1;
End;

function CDBase.GroupIdToName(groupID:Integer):string;
Var
    strSQL : String;
    nCount   : Integer;
Begin
    Result:='';
    //if (groupID<>-1) then sqlAdd := ' and QGID='+IntToStr(groupID);
    strSQL := 'Select NAME From querygroup where id='+IntToStr(groupID);
    if OpenQry(strSQL,nCount)=True then
     with FADOQuery do
     Begin
     Result   :=FieldByName('NAME').AsString;;
    End;
    CloseQry;
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
      m_swABOID       := FieldByName('m_swABOID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      m_swPLID        := FieldByName('m_swPLID').AsInteger;
      m_swPosition    := FieldByName('m_swPosition').AsInteger;
      M_NGROUPLV      := FieldByName('M_NGROUPLV').AsInteger;
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
              ' m_swABOID='+IntToStr(m_swABOID)+
              ',m_swPosition=' +IntToStr(m_swPosition)+
              ',M_NGROUPLV=' +IntToStr(M_NGROUPLV)+
              ',m_sGroupName='    +''''+m_sGroupName+''''+
              ',m_sGroupExpress=' +''''+m_sGroupExpress+''''+
              ',m_swPLID=' +IntToStr(m_swPLID)+
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
              '(m_swABOID,m_sbyGroupID,M_NGROUPLV,m_swPosition,m_sGroupName,m_sGroupExpress,m_swPLID,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swABOID)+ ','+
              IntToStr(m_sbyGroupID)+ ','+
              IntToStr(M_NGROUPLV)+ ','+
              IntToStr(m_swPosition)+ ','+
              ''''+m_sGroupName+''''+ ','+
              ''''+m_sGroupExpress+''''+ ','+
              IntToStr(m_swPLID)+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelGroupTable(nAbon,nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then strSQL := 'DELETE FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(nAbon)+' and m_sbyGroupID='+IntToStr(nIndex);
    if nIndex=-1  then strSQL := 'DELETE FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(nAbon);
    Result := ExecQry(strSQL);
End;
function CDBase.GetMSGROUPEXPRESS(nAbon,nChannel:Integer;var pTable:SL3GROUPTAG):string;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;

Begin
    res := False;
    if nChannel<>-1 then strSQL := 'SELECT M_SGROUPEXPRESS FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(nAbon)+' and M_SBYGROUPID='+IntToStr(nChannel);
    if nChannel=-1  then strSQL := 'SELECT M_SGROUPEXPRESS FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(nAbon);
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
      pTable.m_swAmVMeter := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable do  Begin
      m_sGroupExpress := FieldByName('M_SGROUPEXPRESS').AsString;
      Next;
      End;
     End;
    End;
    CloseQry;
    Result := pTable.m_sGroupExpress;
End;
function CDBase.GetGroupExpress(nChannel:Integer):string;
Var
    i,nCount : Integer;
    strSQL   : String;
Begin
    Result := '';
    strSQL := 'SELECT DISTINCT M_SGROUPEXPRESS FROM SL3GROUPTAG WHERE M_SBYGROUPID='+IntToStr(nChannel);
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      Result := FADOQuery.FieldByName('M_SGROUPEXPRESS').AsString;
      FADOQuery.Next;
     End;
    End;
    CloseQry;
End;
function CDBase.GetVMIDExpress(nChannel,nCMDID:Integer):string;
Var
    i,nCount : Integer;
    strSQL   : String;
Begin
    Result := '';
    strSQL := 'SELECT DISTINCT M_SPARAMEXPRESS FROM SL3PARAMS WHERE m_swVMID='+IntToStr(nChannel)+
    ' and M_SWPARAMID='+IntToStr(nCMDID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      Result := FADOQuery.FieldByName('M_SPARAMEXPRESS').AsString;
      FADOQuery.Next;
     End;
    End;
    CloseQry;
End;



function CDBase.GetAbonVMetersTable(nAbon,nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if (nAbon<>-1)and(nChannel<>-1) then strSQL := 'SELECT * FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
                                   ' and SL3GROUPTAG.m_sbyGroupID='+IntToStr(nChannel)+
                                   ' ORDER BY m_swVMID' else
    if (nAbon<>-1)and(nChannel=-1)  then strSQL := 'SELECT * FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
                                   ' ORDER BY m_swVMID' else
    if (nAbon=-1)and(nChannel=-1)  then strSQL := 'SELECT * FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' ORDER BY m_swVMID';
    pTable.m_swAmVMeter := 0;pTable.Item.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swABOID     := FieldByName('M_SWABOID').AsInteger;
      m_swMID       := FieldByName('m_swMID').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      m_sbyGroupID  := FieldByName('m_sbyGroupID').AsInteger;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_sddPHAddres := FieldByName('m_sddPHAddres').AsString;
      m_sMeterName  := FieldByName('m_sMeterName').AsString;
      m_sVMeterName := FieldByName('m_sVMeterName').AsString;
      m_sbyExport   := FieldByName('m_sbyExport').AsInteger;
      m_swPLID      := FieldByName('m_swPLID').AsInteger;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
      M_SMETERCODE  := FieldByName('M_SMETERCODE').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;





function CDBase.GetAbonVMetersTable1(nAbon,nChannel:Integer;var pTable:SL3GROUPTAG1):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nChannel<>-1 then strSQL := 'SELECT * FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
                                   ' and SL3GROUPTAG.m_sbyGroupID='+IntToStr(nChannel)+
                                   ' ORDER BY m_swVMID';
    if nChannel=-1  then strSQL := 'SELECT * FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
                                   ' ORDER BY m_swVMID';
    pTable.m_swAmVMeter := 0;pTable.Item.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
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
      m_swPLID      := FieldByName('m_swPLID').AsInteger;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetAbonVMeterTable(nAbon,nVMid:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if (nAbon=-1) and (nVMid=-1)  then strSQL := 'SELECT DISTINCT * FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' ORDER BY SL3VMETERTAG.m_swVMID' else
    if (nAbon=-1) and (nVMid<>-1) then strSQL := 'SELECT DISTINCT * FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' and SL3VMETERTAG.m_swVMID='+IntToStr(nVMid)+
                                   ' ORDER BY SL3VMETERTAG.m_swVMID' else
    if (nAbon<>-1)and (nVMid<>-1) then strSQL := 'SELECT DISTINCT * FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
                                   ' and SL3VMETERTAG.m_swVMID='+IntToStr(nVMid)+
                                   ' ORDER BY m_swVMID' else
    if (nAbon<>-1)and (nVMid=-1)  then strSQL := 'SELECT * FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
                                   ' ORDER BY m_swVMID';
    pTable.m_swAmVMeter := 0;pTable.Item.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swMID       := FieldByName('m_swMID').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      m_sbyGroupID  := FieldByName('m_sbyGroupID').AsInteger;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_sddPHAddres := FieldByName('m_sddPHAddres').AsString;
      m_sMeterName  := FieldByName('m_sMeterName').AsString;
      m_sMeterCode  := FieldByName('m_sMeterCode').AsString;
      m_sVMeterName := FieldByName('m_sVMeterName').AsString;
      m_sbyExport   := FieldByName('m_sbyExport').AsInteger;
      m_swPLID      := FieldByName('m_swPLID').AsInteger;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetAbonPortMetersTable(nAbon:Integer;var pTable:SABONPORTMETER):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if GetAbonPortsTable(nAbon,pTable)=True then
    Begin
     for i:=0 to pTable.Count-1 do
     GetPortMeterTable(nAbon,pTable.Items[i].m_sbyPortID,pTable.Items[i]);
     res := True;
    End;
    Result := res;
End;
function CDBase.GetPortMeterTable(nAbon,nPort:Integer;var pTable:SPORTMETERS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT m_swMID FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
              ' and not ((SL3VMETERTAG.m_sbyType=8) or (SL3VMETERTAG.m_sbyType=9))'+
              ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
              ' and (m_sbyPortID IN (SELECT m_sbyPortID FROM L1TAG WHERE (m_sbyProtID=1 or m_sbyProtID=4) and m_sblReaddres=1 and m_swAddres='+IntToStr(nPort)+')'+
              ' or m_sbyPortID='+IntToStr(nPort)+')'+
              ' ORDER BY m_swMID';
    pTable.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swMID     := FieldByName('m_swMID').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetAbonPortsTable(nAbon:Integer;var pTable:SABONPORTMETER):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT L1TAG.m_sbyPortID FROM SL3VMETERTAG,L1TAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
              ' and not ((SL3VMETERTAG.m_sbyType=8) or (SL3VMETERTAG.m_sbyType=9))'+
              ' and SL3VMETERTAG.m_sbyPortID=L1TAG.m_sbyPortID'+
              ' and (m_sbyProtID=1 or m_sbyProtID=4)'+
              ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
              ' and (m_sblReaddres=0) or (m_sblReaddres=1 and L1TAG.m_sbyPortID IN (SELECT m_sbyPortID FROM L1TAG WHERE (m_sbyProtID=1 or m_sbyProtID=4) and m_sblReaddres=1))'+
              ' ORDER BY m_sbyPortID';
    pTable.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count   := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetAbonMetersTable(nAbon:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT m_swMID,m_swVMID,m_sbyPortID FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
              ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
              ' and SL3GROUPTAG.m_sbyEnable=1'+
              ' ORDER BY m_swMID';
    pTable.m_swAmVMeter := 0;pTable.Item.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
      m_swMID       := FieldByName('m_swMID').AsInteger;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetAbonMetersLocTable(nAbon:Integer;strType:String;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    sql      : String;
    sqlAbon  : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if(strType<>'') then sql := ' and s2.m_sbyType IN '+strType else sql := '';
    if(nAbon<>-1) then sqlAbon := ' and s1.m_swABOID='+IntToStr(nAbon) else sqlAbon := '';
    strSQL := 'SELECT DISTINCT s1.M_SWABOID,s2.pullid, s2.M_SBYLOCATION,s2.m_swMID,s0.m_swVMID,s2.m_sbyPortID,s0.M_SMETERCODE,s0.m_sbyType,s2.M_SADVDISCL2TAG,s2.M_SDDFABNUM'+
              ' FROM SL3VMETERTAG as s0,SL3GROUPTAG as s1,L2TAG as s2 '+
              ' WHERE s0.m_sbyGroupID=s1.m_sbyGroupID'+
              ' and s2.m_swMID=s0.m_swMID'+
              ' and s2.m_sbyEnable=1'+
              sqlAbon+sql+
              ' ORDER BY s0.m_swVMID';
    pTable.m_swAmVMeter := 0;pTable.Item.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
      m_swMID       := FieldByName('m_swMID').AsInteger;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_swABOID     := FieldByName('M_SWABOID').AsInteger;
      m_sbyPullID   := FieldByName('pullid').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      M_SMETERCODE  := FieldByName('M_SMETERCODE').AsString;
      m_sMeterName  := FieldByName('M_SADVDISCL2TAG').AsString;
      m_sddPHAddres := FieldByName('M_SDDFABNUM').AsString;
      m_sbyExport   := FieldByName('M_SBYLOCATION').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetAbonVMIDTable(nAbon:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT m_swVMID FROM SL3VMETERTAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
              ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
              ' ORDER BY m_swVMID';
    pTable.m_swAmVMeter := 0;pTable.Item.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetVMNameTable(var pTable:SL3VMNAMETAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT m_swVMID,m_sVMeterName FROM SL3VMETERTAG ORDER BY m_swVMID';
    pTable.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count   := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      //m_sMeterName   := FieldByName('m_sMeterName').AsString;
      m_sMeterName   := FieldByName('m_sVMeterName').AsString;
      //m_sVMeterName
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetMetNameTable(var pTable:SL3VMNAMETAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT m_swMID,M_SCHNAME FROM L2TAG ORDER BY m_swMID';
    pTable.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count   := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swVMID       := FieldByName('m_swMID').AsInteger;
      m_sMeterName   := FieldByName('M_SCHNAME').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetPHAddrL3(nVMID:Integer;var sPHAddr:String):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT m_sddPHAddres FROM SL3VMETERTAG WHERE m_swVMID='+IntToStr(nVMID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     //pTable.m_swAmVMeter := nCount;
     //pTable.Item.Count   := nCount;
     //SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery do  Begin
      sPHAddr  := FieldByName('m_sddPHAddres').AsString;
      Next;
      //Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetPHAddrL2(nVMID:Integer;var nPHAddr:Integer):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    str      : String;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT s0.m_sddPHAddres FROM L2TAG as s0,SL3VMETERTAG as s1 WHERE s0.m_swMID=s1.m_swMID and s1.m_swVMID='+IntToStr(nVMID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     //pTable.m_swAmVMeter := nCount;
     //pTable.Item.Count   := nCount;
     //SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery do  Begin
      str  := FieldByName('m_sddPHAddres').AsString;
      if str<>'' then nPHAddr := StrToInt(str);
      Next;
      //Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetVMetersTable(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL,strSRT : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSRT := 'm_swVMID';
    if (m_dwSort and SRT_TUCH)<>0 then strSRT := 'm_sVMeterName';

    { ************* BO 27/09/2018   JKLJKL

    if nChannel<>-1 then strSQL := 'SELECT * FROM SL3VMETERTAG WHERE m_sbyGroupID='+IntToStr(nChannel)+ ' ORDER BY cast(m_swMID as int), '+strSRT;
    if nChannel=-1  then strSQL := 'SELECT * FROM SL3VMETERTAG ORDER BY '+strSRT;}

    if nChannel<>-1 then strSQL :=
      'SELECT SVM.m_swid, SVM.m_swmid, SVM.m_sbyportid, SVM.m_sbytype, SVM.m_sbygroupid, SVM.m_swvmid, SVM.m_sddphaddres, ' +
      '       SVM.m_svmetername, SVM.m_smetername, SVM.m_sbyenable, SVM.m_sbyexport, SVM.m_swplid, SVM.m_smetercode, SVM.note,' +
      '       L2TAG.m_sddhadr_house ' +
      'FROM SL3VMETERTAG SVM, L2TAG ' +
      'WHERE SVM.m_sbyGroupID='+IntToStr(nChannel)+ ' AND SVM.m_swmid = L2TAG.m_swmid ' +
      'ORDER BY cast(SVM.m_swMID as int), SVM.'+strSRT;


    if nChannel=-1  then strSQL :=
      'SELECT SVM.m_swid, SVM.m_swmid, SVM.m_sbyportid, SVM.m_sbytype, SVM.m_sbygroupid, SVM.m_swvmid, SVM.m_sddphaddres, ' +
      '       SVM.m_svmetername, SVM.m_smetername, SVM.m_sbyenable, SVM.m_sbyexport, SVM.m_swplid, SVM.m_smetercode, SVM.note,' +
      '       L2TAG.m_sddhadr_house ' +
      'FROM SL3VMETERTAG SVM, L2TAG ' +
      'WHERE SVM.m_swmid = L2TAG.m_swmid ' +
      'ORDER BY SVM.'+strSRT;

    // ************* end of BO

    pTable.m_swAmVMeter := 0;pTable.Item.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swMID       := FieldByName('m_swMID').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      m_sbyGroupID  := FieldByName('m_sbyGroupID').AsInteger;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_sddPHAddres := FieldByName('m_sddPHAddres').AsString;
      m_sMeterName  := FieldByName('m_sMeterName').AsString;
      m_sMeterCode  := FieldByName('m_sMeterCode').AsString;
      m_sVMeterName := FieldByName('m_sVMeterName').AsString;
      m_sbyExport   := FieldByName('m_sbyExport').AsInteger;
      m_swPLID      := FieldByName('m_swPLID').AsInteger;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;

    // ************* BO 27/09/2018
      m_sddHOUSE     := FieldByName('M_SDDHADR_HOUSE').AsString;
    // ************* end of BO

      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;


function CDBase.GetVMetersTableWithParams(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;     { ************* BO 4/10/2018
                                     комбинирование двух запросов (GetVMetersTable и GetVParamsTable) в один}
Var
    i, j     : Integer;
    strSQL   : String;
    strSRT   : String;
    res      : Boolean;
    nCount   : Integer;
    ptr      : longint;
Begin
    res := False;
    strSRT := 'm_swVMID';
    if (m_dwSort and SRT_TUCH)<>0 then strSRT := 'm_sVMeterName';

    { ************* BO 27/09/2018   JKLJKL

    if nChannel<>-1 then strSQL := 'SELECT * FROM SL3VMETERTAG WHERE m_sbyGroupID='+IntToStr(nChannel)+ ' ORDER BY cast(m_swMID as int), '+strSRT;
    if nChannel=-1  then strSQL := 'SELECT * FROM SL3VMETERTAG ORDER BY '+strSRT;}

    if nChannel<>-1 then strSQL :=
      'SELECT SVM.m_swid SVMm_swid, SVM.m_swmid SVMm_swmid, SVM.m_sbyportid, SVM.m_sbytype, SVM.m_sbygroupid, ' +
      '       SVM.m_swvmid SVMm_swvmid, SVM.m_sddphaddres, ' +
      '       SVM.m_svmetername, SVM.m_smetername, SVM.m_sbyenable, SVM.m_sbyexport, SVM.m_swplid, SVM.m_smetercode, SVM.note,' +
      '       L2TAG.m_sddhadr_house, ' +
      '       SLP.m_swid SLPm_swid, SLP.m_swvmid SLPm_swvmid, SLP.m_swparamid, SLP.m_sparamexpress, SLP.m_sparam, SLP.m_fmin, SLP.m_flimit, ' +
      '       SLP.m_fmax, SLP.m_fdiffer, SLP.m_dtlasttime, SLP.m_stsvperiod, SLP.m_sbltarif, SLP.m_sblcalculate, SLP.m_sblsaved, ' +
      '       SLP.m_swstatus, SLP.m_sblenable, SLP.m_sbydatagroup, SLP.m_sbylockstate, SLP.m_sndatatype ' +
      'FROM SL3VMETERTAG SVM, L2TAG, SL3PARAMS SLP ' +
      'WHERE SVM.m_sbyGroupID='+IntToStr(nChannel)+
      ' AND SVM.m_swmid = L2TAG.m_swmid ' +
      ' AND SVM.m_swvmid = SLP.m_swvmid ' +
      'ORDER BY cast(SVM.m_swMID as int), SVM.'+strSRT + ', SLP.m_swparamid';


    if nChannel=-1  then strSQL :=
      'SELECT SVM.m_swid SVMm_swid, SVM.m_swmid SVMm_swmid, SVM.m_sbyportid, SVM.m_sbytype, SVM.m_sbygroupid, ' +
      '       SVM.m_swvmid SVMm_swvmid, SVM.m_sddphaddres, ' +
      '       SVM.m_svmetername, SVM.m_smetername, SVM.m_sbyenable, SVM.m_sbyexport, SVM.m_swplid, SVM.m_smetercode, SVM.note,' +
      '       L2TAG.m_sddhadr_house, ' +
      '       SLP.m_swid SLPm_swid, SLP.m_swvmid SLPm_swvmid, SLP.m_swparamid, SLP.m_sparamexpress, SLP.m_sparam, SLP.m_fmin, SLP.m_flimit, ' +
      '       SLP.m_fmax, SLP.m_fdiffer, SLP.m_dtlasttime, SLP.m_stsvperiod, SLP.m_sbltarif, SLP.m_sblcalculate, SLP.m_sblsaved, ' +
      '       SLP.m_swstatus, SLP.m_sblenable, SLP.m_sbydatagroup, SLP.m_sbylockstate, SLP.m_sndatatype ' +
      'FROM SL3VMETERTAG SVM, L2TAG, SL3PARAMS SLP ' +
      'WHERE SVM.m_swmid = L2TAG.m_swmid ' +
      ' AND SVM.m_swvmid = SLP.m_swvmid ' +
      'ORDER BY SVM.'+strSRT + ', SLP.m_swparamid';

    // ************* end of BO

    // Три переменные из таблы  SL3VMETERTAG переалиасятся с добавлением префикса SVM
    // Две переменные из таблы  SL3PARAMS переалиасятся с добавлением префикса SLP

    pTable.m_swAmVMeter := 0;pTable.Item.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0; j:=0; res := True;
     pTable.m_swAmVMeter := 1;
     pTable.Item.Count   := 1;
     SetLength(pTable.Item.Items,1);

     ptr := FADOQuery.FieldByName('SVMm_swVMID').AsInteger;
     pTable.Item.Items[i].m_swAmParams := 1;
     pTable.Item.Items[i].Item.Count := 1;
     SetLength(pTable.Item.Items[i].Item.Items,1);

     while not FADOQuery.Eof do Begin
       with FADOQuery do  Begin
         if j = 0 then begin
           pTable.Item.Items[i].m_swID        := FieldByName('SVMm_swID').AsInteger;
           pTable.Item.Items[i].m_swMID       := FieldByName('SVMm_swMID').AsInteger;
           pTable.Item.Items[i].m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
           pTable.Item.Items[i].m_sbyType     := FieldByName('m_sbyType').AsInteger;
           pTable.Item.Items[i].m_sbyGroupID  := FieldByName('m_sbyGroupID').AsInteger;
           pTable.Item.Items[i].m_swVMID      := FieldByName('SVMm_swVMID').AsInteger;
           pTable.Item.Items[i].m_sddPHAddres := FieldByName('m_sddPHAddres').AsString;
           pTable.Item.Items[i].m_sMeterName  := FieldByName('m_sMeterName').AsString;
           pTable.Item.Items[i].m_sMeterCode  := FieldByName('m_sMeterCode').AsString;
           pTable.Item.Items[i].m_sVMeterName := FieldByName('m_sVMeterName').AsString;
           pTable.Item.Items[i].m_sbyExport   := FieldByName('m_sbyExport').AsInteger;
           pTable.Item.Items[i].m_swPLID      := FieldByName('m_swPLID').AsInteger;
           pTable.Item.Items[i].m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
           // ************* BO 27/09/2018
           pTable.Item.Items[i].m_sddHOUSE     := FieldByName('M_SDDHADR_HOUSE').AsString;
           // ************* end of BO
         end;

         pTable.Item.Items[i].Item.Items[j].m_swID :=FieldByName('SLPm_swid').AsInteger;
         pTable.Item.Items[i].Item.Items[j].m_swVMID :=FieldByName('SLPm_swvmid').AsInteger;
         pTable.Item.Items[i].Item.Items[j].m_swParamID :=FieldByName('m_swParamID').AsInteger;
         pTable.Item.Items[i].Item.Items[j].m_sParamExpress :=FieldByName('m_sParamExpress').AsString;
         pTable.Item.Items[i].Item.Items[j].m_sParam :=FieldByName('m_sParam').AsString;
         pTable.Item.Items[i].Item.Items[j].m_fMin :=FieldByName('m_fMin').AsFloat;
         pTable.Item.Items[i].Item.Items[j].m_fMax :=FieldByName('m_fMax').AsFloat;
         pTable.Item.Items[i].Item.Items[j].m_fDiffer :=FieldByName('m_fDiffer').AsFloat;
         pTable.Item.Items[i].Item.Items[j].m_dtLastTime :=FieldByName('m_dtLastTime').AsDateTime;
         pTable.Item.Items[i].Item.Items[j].m_stSvPeriod :=FieldByName('m_stSvPeriod').AsInteger;
         pTable.Item.Items[i].Item.Items[j].m_sblTarif :=FieldByName('m_sblTarif').AsInteger;
         pTable.Item.Items[i].Item.Items[j].m_sblCalculate :=FieldByName('m_sblCalculate').AsInteger;
         pTable.Item.Items[i].Item.Items[j].m_sblSaved :=FieldByName('m_sblSaved').AsInteger;
         pTable.Item.Items[i].Item.Items[j].m_swStatus :=FieldByName('m_swStatus').AsInteger;
         pTable.Item.Items[i].Item.Items[j].m_sblEnable :=FieldByName('m_sblEnable').AsInteger;
         pTable.Item.Items[i].Item.Items[j].m_sbyDataGroup :=FieldByName('m_sbyDataGroup').AsInteger;
         pTable.Item.Items[i].Item.Items[j].m_sbyLockState :=FieldByName('m_sbyLockState').AsInteger;
         pTable.Item.Items[i].Item.Items[j].m_snDataType :=FieldByName('m_snDataType').AsInteger;

         Next;
         if ptr <> FADOQuery.FieldByName('SVMm_swVMID').AsInteger then begin
           ptr:=FADOQuery.FieldByName('SVMm_swVMID').AsInteger;
           Inc(i);
           inc(pTable.m_swAmVMeter);
           inc(pTable.Item.Count);
           SetLength(pTable.Item.Items,i+1);
           pTable.Item.Items[i].m_swAmParams := 1;
           pTable.Item.Items[i].Item.Count   := 1;
           SetLength(pTable.Item.Items[i].Item.Items,1);
           j:=0;
         end else begin
           inc(pTable.Item.Items[i].m_swAmParams);
           inc(pTable.Item.Items[i].Item.Count);
           inc(j);
           SetLength(pTable.Item.Items[i].Item.Items,j+1);
         end;
       End;

     End;

    End;
    CloseQry;
    Result := res;
End;





function CDBase.GetVmidJoin(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL,strSRT : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nChannel=-1  then strSQL := 'SELECT m_swMID,m_swVMID,m_sbyType,m_sbyExport,m_sbyEnable FROM SL3VMETERTAG ORDER BY m_swVMID';
    pTable.m_swAmVMeter := 0;
    pTable.Item.Count   := 0;
    if OpenQryD(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQueryD.Eof do Begin
     with FADOQueryD,pTable.Item.Items[i] do  Begin
      m_swMID       := FieldByName('m_swMID').AsInteger;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      m_sbyExport   := FieldByName('m_sbyExport').AsInteger;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQryD;
    Result := res;
End;

function CDBase.GetVL2tagTable(nChannel:Integer;var pTable:SL2InitImgIndex):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
begin  
    res := False;
    if nChannel<>-1 then strSQL := 'SELECT m_sbyModem,m_sbyEnable FROM L2TAG WHERE m_sbyGroupID='+IntToStr(nChannel)+ ' ORDER BY m_swMID';
    if nChannel=-1  then strSQL := 'SELECT m_sbyModem,m_sbyEnable FROM L2TAG ORDER BY m_swMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmMeter := nCount;
     SetLength(pTable.m_sMeter,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sMeter[i] do  Begin
      m_sbyModem     := FieldByName('m_sbyModem').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
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
     if nChannel<>-1 then strSQL := ' SELECT * FROM SL3VMETERTAG as s0,L2TAG as s1 WHERE s0.m_sbyGroupID='+IntToStr(nChannel)+
                                    ' and s0.m_swMID=s1.m_swMID and s1.m_sbyEnable=1 ORDER BY s0.m_swMID';
     if nChannel=-1  then strSQL := ' SELECT * FROM SL3VMETERTAG ORDER BY m_swVMID';
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
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
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
      m_swPLID      := FieldByName('m_swPLID').AsInteger;
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
    //GetAbonVMeterTable(nAbon,nVMid:Integer;var pTable:SL3GROUPTAG):Boolean;
    if GetVMetersTable(nChannel,pTable) then
    Begin
     for i:=0 to pTable.m_swAmVMeter-1 do
     Begin
      //if GetVMeterTable(pTable.Item.Items[i])=True Then
      //GetChandgeDTTable(pTable.Item.Items[i].m_swVMID,pTable.Item.Items[i].ItemCh);
      LoadChandgeTable(pTable.Item.Items[i].m_swVMID,True,pTable.Item.Items[i].ItemCh);
      if GetVParamsTable(pTable.Item.Items[i].m_swVMID,pTable.Item.Items[i])=True then
      res := True;
     End
    End;
    Result := res;
End;
function CDBase.GetAbonVMetersFullTable(nAbon:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if GetAbonVMetersTable(nAbon,-1,pTable) then
    Begin
     for i:=0 to pTable.m_swAmVMeter-1 do
     Begin
      //if GetVMeterTable(pTable.Item.Items[i])=True Then
      //GetChandgeDTTable(pTable.Item.Items[i].m_swVMID,pTable.Item.Items[i].ItemCh);
      LoadChandgeTable(pTable.Item.Items[i].m_swVMID,True,pTable.Item.Items[i].ItemCh);
      if GetVParamsTable(pTable.Item.Items[i].m_swVMID,pTable.Item.Items[i])=True then
      res := True;
     End
    End;
    Result := res;
End;
function CDBase.GetVMetersAbonFTable(nAbon:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if GetAbonVMetersTable(nAbon,-1,pTable) then
    Begin
     for i:=0 to pTable.m_swAmVMeter-1 do
     Begin
      //if GetVMeterTable(pTable.Item.Items[i])=True Then
      //GetChandgeDTTable(pTable.Item.Items[i].m_swVMID,pTable.Item.Items[i].ItemCh);
      //LoadChandgeTable(pTable.Item.Items[i].m_swVMID,True,pTable.Item.Items[i].ItemCh);
      if GetVParamsTable(pTable.Item.Items[i].m_swVMID,pTable.Item.Items[i])=True then
      res := True;
     End
    End;
    Result := res;
End;
function CDBase.GetVMetersAbonVMidFTable(nAbon,nVMid:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if GetAbonVMeterTable(nAbon,nVMid,pTable) then
    Begin
     for i:=0 to pTable.m_swAmVMeter-1 do
     Begin
      if GetVParamsTable(pTable.Item.Items[i].m_swVMID,pTable.Item.Items[i])=True then
      res := True;
     End
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
      m_sMeterCode  := FieldByName('m_sMeterCode').AsString;
      m_sVMeterName := FieldByName('m_sVMeterName').AsString;
      m_sbyExport   := FieldByName('m_sbyExport').AsInteger;
      m_swPLID      := FieldByName('m_swPLID').AsInteger;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
     res   := True;
    End;
    End;
    CloseQry;
    if res=True then
    Begin
     LoadChandgeTable(pTable.m_swVMID,True,pTable.ItemCh);
     GetVParamsTable(pTable.m_swVMID,pTable);
    End;
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
              ',m_sMeterCode='   +''''+m_sMeterCode+''''+
              ',m_sVMeterName='  +''''+m_sVMeterName+''''+
              ',m_sbyExport='    +IntToStr(m_sbyExport)+
              ',m_sbyEnable='    +IntToStr(m_sbyEnable)+
              ',m_swPLID='       +IntToStr(m_swPLID)+
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
              '(m_swMID,m_sbyPortID,m_sbyType,m_sbyGroupID,m_swVMID,m_sddPHAddres,m_sMeterName,m_sMeterCode,m_sVMeterName,m_sbyExport,m_swPLID,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swMID)+ ','+
              IntToStr(m_sbyPortID)+ ','+
              IntToStr(m_sbyType)+ ','+
              IntToStr(m_sbyGroupID)+ ','+
              IntToStr(m_swVMID)+ ','+
              ''''+m_sddPHAddres+''''+ ','+
              ''''+m_sMeterName+''''+ ','+
              ''''+m_sMeterCode+''''+ ','+
              ''''+m_sVMeterName+''''+','+
              IntToStr(m_sbyExport)+ ','+
              IntToStr(m_swPLID)+ ','+
              IntToStr(m_sbyEnable)+ ')';

    End;
    Result := ExecQry(strSQL);
End;

function CDBase.UpdateGROUPLV(GrID, GROUPLV : integer):Boolean;
var strSQL : string;
begin
   strSQL := 'UPDATE SL3GROUPTAG SET ' +
             'M_NGROUPLV='+IntToStr(GROUPLV) +
             ' WHERE m_sbyGroupID=' + IntToStr(GrID);
   Result := ExecQry(strSQL);
end;

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
      m_sbyDeltaPer  := FieldByName('m_sbyDeltaPer').AsInteger;
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
              ',m_sbyDeltaPer=' +IntToStr(m_sbyDeltaPer)+
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
              '(m_swType,m_sName,m_sEName,m_sEMet,m_swSvPeriod,m_sblTarif,m_swActive,m_swStatus,m_swIsGraph,m_sbyDataGroup,m_sbyDeltaPer)'+
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
              IntToStr(m_sbyDataGroup)+ ',' +
              IntToStr(m_sbyDeltaPer) +
              ')';
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
    i      : Integer;
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
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
      m_snDataType:= FieldByName('m_snDataType').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetQMCmdDirTable(nType,nMID:Integer;var pTable:QM_COMMANDS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT distinct QM_COMMANDS.m_snDataType,CCOMMAND.m_swCMDID'+
    ' FROM QM_COMMANDS,CCOMMAND'+
    ' WHERE QM_COMMANDS.m_swType='+IntToStr(nType)+
    ' and CCOMMAND.m_swMID='+IntToStr(nMID)+
    ' and QM_COMMANDS.m_swCmdID=CCOMMAND.m_swCMDID'+
    ' ORDER BY CCOMMAND.m_swCMDID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmCommandType := nCount;
     SetLength(pTable.m_sCommandType,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sCommandType[i] do  Begin
      m_snDataType:= FieldByName('m_snDataType').AsInteger;
      m_swCMDID   := FieldByName('m_swCMDID').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsCommandInQMTable(nIndex:Integer):Byte;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    byCMDID  : Byte;
Begin
    try
     Result := 0;
     strSQL := 'SELECT m_swCMDID FROM QM_COMMANDS WHERE M_SWCMDID='+IntToStr(nIndex);
     if OpenQry(strSQL,nCount)=True then
     Begin
      if nIndex=FADOQuery.FieldByName('m_swCMDID').AsInteger then
      Result := 1;
     End;
     CloseQry;
    except
     Result := 2;
    end;
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
              ',m_snDataType='   +IntToStr(m_snDataType)+
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
              '(m_swType,m_swCMDID,m_sName,m_swSpec0,m_swSpec1,m_swSpec2,m_sblSaved,m_sbyEnable,m_snDataType,m_sbyDirect)'+
              ' VALUES('+
              IntToStr(m_swType)+ ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+m_sName+''''+ ','+
              IntToStr(m_swSpec0)+ ','+
              IntToStr(m_swSpec1)+ ','+
              IntToStr(m_swSpec2)+ ','+
              IntToStr(m_sblSaved)+ ','+
              IntToStr(m_sbyEnable)+ ','+
              IntToStr(m_snDataType)+','+
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

{
TM_PLANE = packed record
     m_swID       : Integer;
     m_swPLID     : Integer;
     m_sName      : String[100];
     m_sbyEnable  : Byte;
    End;
}
function CDBase.GetTPlanesTable(var pTable:TM_PLANES):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM TM_PLANE ORDER BY m_swPLID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swPLID   := FieldByName('m_swPLID').AsInteger;
      m_sName    := FieldByName('m_sName').AsString;
      m_sAmZones := FieldByName('m_sAmZones').AsInteger;
      m_sbyEnable:= FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsTPlaneTable(var pTable:TM_PLANE):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM TM_PLANE WHERE m_swID='+IntToStr(pTable.m_swID)+
              ' and m_swPLID='+IntToStr(pTable.m_swPLID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetTPlaneTable(var pTable:TM_PLANE):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE TM_PLANE SET '+
              ' m_swPLID='      +IntToStr(m_swPLID)+
              ',m_sName='       +''''+m_sName+''''+
              ',m_sAmZones='    +IntToStr(m_sAmZones)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ' WHERE m_swPLID='+IntToStr(m_swPLID)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddTPlaneTable(var pTable:TM_PLANE):Boolean;
Var
    strSQL   : String;
Begin
    if IsTPlaneTable(pTable)=True then Begin SetTPlaneTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO TM_PLANE'+
              '(m_swPLID,m_sName,m_sAmZones,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swPLID)+ ','+
              ''''+m_sName+''''+ ','+
              IntToStr(m_sAmZones)+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelTPlaneTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM TM_PLANE WHERE m_swPLID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM TM_PLANE';
    Result := ExecQry(strSQL);
End;


{
     m_swPLID     : Integer;
     m_swSZNID    : Integer;
     m_swTDayID   : Integer;
}
function CDBase.GetTMTarifsTable(swPLID,swSZNID,swTDayID:Integer;var pTable:TM_TARIFFSS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM TM_TARIFFS WHERE m_swPLID='+IntToStr(swPLID)+
    ' and m_swSZNID='+IntToStr(swSZNID)+
    ' and m_swTDayID='+IntToStr(swTDayID)+
    ' ORDER BY m_swID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swZoneID := FieldByName('m_swZoneID').AsInteger;
      m_swTTID   := FieldByName('m_swTTID').AsInteger;
      m_swPLID   := FieldByName('m_swPLID').AsInteger;
      m_swSZNID  := FieldByName('m_swSZNID').AsInteger;
      m_swTDayID := FieldByName('m_swTDayID').AsInteger;
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
function CDBase.GetTMTarifsTableEx(swPLID,swSZNID,swTDayID:Integer;var pTable:TM_TARIFFSS):Boolean;
Var
    i, TID   : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM TM_TARIFFS WHERE m_swPLID='+IntToStr(swPLID)+
    ' and m_swSZNID='+IntToStr(swSZNID)+
    ' and m_swTDayID='+IntToStr(swTDayID)+
    ' ORDER BY m_swID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swZoneID := FieldByName('m_swZoneID').AsInteger;
      m_swTTID   := FieldByName('m_swTTID').AsInteger;
      m_swPLID   := FieldByName('m_swPLID').AsInteger;
      m_swSZNID  := FieldByName('m_swSZNID').AsInteger;
      m_swTDayID := FieldByName('m_swTDayID').AsInteger;
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
    for i := 0 to pTable.Count - 1 do
      GetTMTarPeriodsTable(-1,pTable.Items[i].m_swTTID, pTable.Items[i]);
    Result := res;
End;
function CDBase.IsTMTarifTable(var pTable:TM_TARIFFS):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM TM_TARIFFS WHERE m_swPLID='+IntToStr(pTable.m_swPLID)+
              //' and m_swSZNID='+IntToStr(pTable.m_swSZNID)+
              ' and m_swTDayID='+IntToStr(pTable.m_swTDayID)+
              ' and m_swTTID='+IntToStr(pTable.m_swTTID)+
              ' and m_swZoneID='+IntToStr(pTable.m_swZoneID);
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
              //',m_swZoneID='    +IntToStr(m_swZoneID)+
              ',m_swPLID='      +IntToStr(m_swPLID)+
              ',m_swSZNID='     +IntToStr(m_swSZNID)+
              ',m_swTDayID='    +IntToStr(m_swTDayID)+
              ',m_sName='       +''''+m_sName+''''+
              ',m_swCMDID='     +IntToStr(m_swCMDID)+
              ',m_dtTime0='     +''''+DateTimeToStr(m_dtTime0)+''''+
              ',m_dtTime1='     +''''+DateTimeToStr(m_dtTime1)+''''+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ' WHERE m_swTTID='+IntToStr(m_swTTID)+
              ' and m_swPLID='+IntToStr(m_swPLID)+
              ' and m_swTDayID='+IntToStr(m_swTDayID)+
              ' and m_swZoneID='+IntToStr(m_swZoneID);
              //' and m_swSZNID='+IntToStr(m_swSZNID);
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
              '(m_swZoneID,m_swTTID,m_swPLID,m_swSZNID,m_swTDayID,m_sName,m_swCMDID,m_dtTime0,m_dtTime1,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swZoneID)+ ','+
              IntToStr(m_swTTID)+ ','+
              IntToStr(m_swPLID)+ ','+
              IntToStr(m_swSZNID)+ ','+
              IntToStr(m_swTDayID)+ ','+
              ''''+m_sName+''''+ ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_dtTime0)+''''+ ','+
              ''''+DateTimeToStr(m_dtTime1)+''''+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelTMTarifTable(swPLID,swSZNID,swTDayID,nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM TM_TARIFFS WHERE m_swTTID='+IntToStr(nIndex)+
              ' and m_swPLID='+IntToStr(swPLID)+
              ' and m_swSZNID='+IntToStr(swSZNID)+
              ' and m_swTDayID='+IntToStr(swTDayID);
    if nIndex=-1 then
    strSQL := 'DELETE FROM TM_TARIFFS WHERE m_swPLID='+IntToStr(swPLID)+
              ' and m_swSZNID='+IntToStr(swSZNID)+
              ' and m_swTDayID='+IntToStr(swTDayID);
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
function CDBase.GetTMTarPeriodsTable(VMID,nIndex:Integer;var pTable:TM_TARIFFS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res    := False;
    if VMID <> -1 then
    begin
      strSQL := 'select M_SWPLID from SL3VMETERTAG where M_SWVMID=' + IntToStr(VMID);
      if OpenQry(strSQL,nCount)=True then
        nIndex := FADOQuery.FieldByName('M_SWPLID').AsInteger*$1000000 + nIndex;
      CloseQry;
    end;
    strSQL := 'SELECT * FROM TM_TARIFF WHERE m_swZoneID='+IntToStr(nIndex)+' ORDER BY m_swPTID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swPTID   := FieldByName('m_swPTID').AsInteger;
      m_swZoneID := FieldByName('m_swZoneID').AsInteger;
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
function CDBase.GetTMTarPeriodsCmdTable(dtDate:TDateTime;nVMID,nCMDID,nTSHift:Integer;var pTable:TM_TARIFFS):Boolean;
Var
    i      : Integer;
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
    nTZone,nTPlane,nZoneID : DWord;
Begin
    res    := False;
    strSQL := 'select M_SBLTARIF from SL3PARAMS '+
    ' where M_SWVMID='+IntToStr(nVMID)+
    ' and M_SWPARAMID='+IntToStr(nCMDID);
    if OpenQry(strSQL,nCount)=True then
    nTZone := FADOQuery.FieldByName('M_SBLTARIF').AsInteger+nTSHift;
    CloseQry;

    strSQL := 'select M_SWPLID from SL3VMETERTAG where M_SWVMID=' + IntToStr(nVMID);
    if OpenQry(strSQL,nCount)=True then
    nTPlane := FADOQuery.FieldByName('M_SWPLID').AsInteger;
    CloseQry;

    //TarIndexGen(nPlane,nSZone,nTDay,nZone:Integer):Dword;
    nZoneID := 0;
    if Assigned(FTZoneHand) then nZoneID := FTZoneHand(dtDate,nTPlane,0,0,nTZone);

    strSQL := 'SELECT * FROM TM_TARIFF WHERE m_swZoneID='+IntToStr(nZoneID)+' ORDER BY m_swPTID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swPTID   := FieldByName('m_swPTID').AsInteger;
      m_swZoneID := FieldByName('m_swZoneID').AsInteger;
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
function CDBase.GetRealTMTarPeriodsPlaneTable(dtDate:TDateTime;nVMID,nCMDID:Integer;var pTable:TM_TARIFFS):Integer;
Var
    i      : Integer;
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
    nTZone,nTPlane,nZoneID : DWord;
Begin
    res    := False;
    strSQL := 'select M_SBLTARIF from SL3PARAMS '+
    ' where M_SWVMID='+IntToStr(nVMID)+
    ' and M_SWPARAMID='+IntToStr(nCMDID);
    if OpenQry(strSQL,nCount)=True then
    nTZone := FADOQuery.FieldByName('M_SBLTARIF').AsInteger;
    CloseQry;

    strSQL := 'select M_SWPLID from SL3VMETERTAG where M_SWVMID=' + IntToStr(nVMID);
    if OpenQry(strSQL,nCount)=True then
    nTPlane := FADOQuery.FieldByName('M_SWPLID').AsInteger;
    CloseQry;

    //TarIndexGen(nPlane,nSZone,nTDay,nZone:Integer):Dword;
    nZoneID := 0;
    if Assigned(FTZoneHand) then nZoneID := FTZoneHand(dtDate,nTPlane,0,0,nTZone);

    strSQL := 'SELECT * FROM TM_TARIFF WHERE m_swZoneID='+IntToStr(nZoneID)+' ORDER BY m_swPTID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swPTID   := FieldByName('m_swPTID').AsInteger;
      m_swZoneID := FieldByName('m_swZoneID').AsInteger;
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
    Result := nTPlane;
End;
function CDBase.IsTMTarPeriodTable(var pTable:TM_TARIFF):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM TM_TARIFF WHERE m_swID='+IntToStr(pTable.m_swID)+
              ' and m_swZoneID='+IntToStr(pTable.m_swZoneID);
    //strSQL := 'SELECT 0 FROM TM_TARIFF WHERE m_swZoneID='+IntToStr(pTable.m_swZoneID);
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
              //',m_swZoneID='      +IntToStr(m_swZoneID)+
              ',m_swTID='       +IntToStr(m_swTID)+
              ',m_sName='       +''''+m_sName+''''+
              ',m_dtTime0='     +''''+DateTimeToStr(m_dtTime0)+''''+
              ',m_dtTime1='     +''''+DateTimeToStr(m_dtTime1)+''''+
              ',m_sfKoeff='       +FloatToStr(m_sfKoeff)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ' WHERE m_swID='+IntToStr(m_swID)+' and m_swZoneID='+IntToStr(m_swZoneID);
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
              '(m_swPTID,m_swZoneID,m_swTID,m_sName,m_dtTime0,m_dtTime1,m_sfKoeff,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swPTID)+ ','+
              IntToStr(m_swZoneID)+ ','+
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
    strSQL := 'DELETE FROM TM_TARIFF WHERE m_swZoneID='+IntToStr(nIndex);
    Result := ExecQry(strSQL);
End;









{
TM_SZNTARIFF = packed record
     m_swID       : Integer;
     m_swSZNID    : Integer;
     m_swSZNName  : String[100];
     m_snFTime    : TDateTime;
     m_snETime    : TDateTime;
     m_sbyEnable  : Byte;
    End;
    TM_SZNTARIFFS = packed record
     Count        : Word;
     Items        : array of TM_SZNTARIFF;
    End;
    TM_SZNDAY = packed record
     m_swID       : Integer;
     m_swSZNID    : Byte;
     m_swMntID    : Byte;
     m_swDayID    : Byte;
     m_swTDayID   : Byte;
     m_sbyEnable  : Byte;
    End;
    TM_SZNDAYS = packed record
     Count        : Word;
     Items        : array of TM_SZNDAY;
    End;
}
function CDBase.GetSZTarifsTable(var pTable:TM_SZNTARIFFS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM TM_SZNTARIFF ORDER BY m_swID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swSZNID  := FieldByName('m_swSZNID').AsInteger;
      m_swSZNName:= FieldByName('m_swSZNName').AsString;
      m_snFTime  := FieldByName('m_snFTime').AsDateTime;
      m_snETime  := FieldByName('m_snETime').AsDateTime;
      m_sbyEnable:= FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetSZFullTarifsTable(var pTable:TM_SZNTARIFFS):Boolean;
Var
    i : Integer;
Begin
    if GetSZTarifsTable(pTable)=True then
    Begin
     for i:=0 to pTable.Count-1 do
      GetSZDayTable(pTable.Items[i].m_swSZNID,pTable.Items[i].Item)
    End;
End;
function CDBase.IsSZTarifTable(var pTable:TM_SZNTARIFF):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM TM_SZNTARIFF WHERE m_swID='+IntToStr(pTable.m_swID)+
              ' and m_swSZNID='+IntToStr(pTable.m_swSZNID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetSZTarifTable(var pTable:TM_SZNTARIFF):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE TM_SZNTARIFF SET '+
              ' m_swSZNID='     +IntToStr(m_swSZNID)+
              ',m_swSZNName='   +''''+m_swSZNName+''''+
              ',m_snFTime='     +''''+DateTimeToStr(m_snFTime)+''''+
              ',m_snETime='     +''''+DateTimeToStr(m_snETime)+''''+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ' WHERE m_swSZNID='+IntToStr(m_swSZNID)+' and m_swID='+IntToStr(m_swID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddSZTarifTable(var pTable:TM_SZNTARIFF):Boolean;
Var
    strSQL   : String;
Begin
    if IsSZTarifTable(pTable)=True then Begin SetSZTarifTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO TM_SZNTARIFF'+
              '(m_swSZNID,m_swSZNName,m_snFTime,m_snETime,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swSZNID)+ ','+
              ''''+m_swSZNName+''''+ ','+
              ''''+DateTimeToStr(m_snFTime)+''''+ ','+
              ''''+DateTimeToStr(m_snETime)+''''+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelSZTarifTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM TM_SZNTARIFF WHERE m_swSZNID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM TM_SZNTARIFF';
    Result := ExecQry(strSQL);
End;
{
TM_SZNDAY = packed record
     m_swID       : Integer;
     m_swSZNID    : Byte;
     m_swMntID    : Byte;
     m_swDayID    : Byte;
     m_swTDayID   : Byte;
     m_sbyEnable  : Byte;
    End;
}

function CDBase.GetSZDayTable(swSZNID:Integer;var pTable:TM_SZNDAYS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM TM_SZNDAY WHERE m_swSZNID='+IntToStr(swSZNID)+
    ' and ((BIN_AND(m_swTDayID,15)='+IntToStr(SZN_HOLY_DAY)+')'+
    ' or (BIN_AND(m_swTDayID,15)='+IntToStr(SZN_WRST_DAY)+'))'+
    ' ORDER BY m_swID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=1;res := True;
     pTable.Count := nCount;
     //SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swSZNID  := FieldByName('m_swSZNID').AsInteger;
      m_swMntID  := FieldByName('m_swMntID').AsInteger;
      m_swDayID  := FieldByName('m_swDayID').AsInteger;
      m_swTDayID := FieldByName('m_swTDayID').AsInteger;
      m_sbyEnable:= FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsSZDayTable(var pTable:TM_SZNDAY):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM TM_SZNDAY WHERE m_swSZNID='+IntToStr(pTable.m_swSZNID)+
              ' and m_swMntID='+IntToStr(pTable.m_swMntID)+
              ' and m_swDayID='+IntToStr(pTable.m_swDayID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetSZDayTable(var pTable:TM_SZNDAY):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE TM_SZNDAY SET '+
              ' m_swTDayID='     +IntToStr(m_swTDayID)+
              ',m_sbyEnable='    +IntToStr(m_sbyEnable)+
              ' WHERE m_swSZNID='+IntToStr(pTable.m_swSZNID)+
              ' and m_swMntID='  +IntToStr(pTable.m_swMntID)+
              ' and m_swDayID='  +IntToStr(pTable.m_swDayID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddSZDayTable(var pTable:TM_SZNDAY):Boolean;
Var
    strSQL   : String;
Begin
    if IsSZDayTable(pTable)=True then Begin SetSZDayTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO TM_SZNDAY'+
              '(m_swSZNID,m_swMntID,m_swDayID,m_swTDayID,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swSZNID)+ ','+
              IntToStr(m_swMntID)+ ','+
              IntToStr(m_swDayID)+ ','+
              IntToStr(m_swTDayID)+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelSZDayTable(swSZNID,swMntID,swDayID:Integer):Boolean;
Var
    strSQL : String;
Begin
    if not((swMntID=-1)and(swDayID=-1)) then
    strSQL := 'DELETE FROM TM_SZNDAY WHERE m_swSZNID='+IntToStr(swSZNID)+
    ' and m_swMntID='  +IntToStr(swMntID)+
    ' and m_swDayID='  +IntToStr(swDayID) else
    if (swMntID=-1)and(swDayID=-1) then
    strSQL := 'DELETE FROM TM_SZNDAY WHERE m_swSZNID='+IntToStr(swSZNID);
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
function CDBase.SetGroupParamAll(nAbon,nGroup,nCmd:Integer;strCmd:String):Boolean;
Var
    strSQL,strSEL   : String;
BEgin
    if nAbon=-1 then
    strSEL := '(SELECT DISTINCT SL3VMETERTAG.M_SWVMID FROM SL3ABON,SL3GROUPTAG,SL3VMETERTAG'+
              ' WHERE SL3ABON.m_swABOID=SL3GROUPTAG.m_swABOID'+
              ' and SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID)'
    else
    if nGroup<>-1 then
    strSEL := '(SELECT DISTINCT SL3VMETERTAG.M_SWVMID FROM SL3ABON,SL3GROUPTAG,SL3VMETERTAG'+
              ' WHERE SL3ABON.m_swABOID=SL3GROUPTAG.m_swABOID'+
              ' and SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID'+
              ' and SL3ABON.m_swABOID='+IntToStr(nAbon)+
              ' and SL3GROUPTAG.M_SBYGROUPID='+IntToStr(nGroup)+')'
    else
    if nGroup=-1 then
    strSEL := '(SELECT DISTINCT SL3VMETERTAG.M_SWVMID FROM SL3ABON,SL3GROUPTAG,SL3VMETERTAG'+
              ' WHERE SL3ABON.m_swABOID=SL3GROUPTAG.m_swABOID'+
              ' and SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID'+
              ' and SL3ABON.m_swABOID='+IntToStr(nAbon)+')';
    strSQL := 'UPDATE SL3PARAMS SET '+strCmd+
              ' WHERE m_swParamID='+IntToStr(nCmd)+
              ' and M_SWVMID IN '+strSEL;
    Result := ExecQry(strSQL);
End;
function CDBase.GetVParamsTable(nChannel:Integer;var pTable:SL3VMETERTAG):Boolean;
Var
    i : Integer;
    strSQL,strSRT : String;
    res      : Boolean;
    nCount   : Integer;
Begin                                             // JKLJKL
    res := False;
    //strSRT := '';
    //if (m_dwSort and SRT_PARM)<>0 then strSRT := ' ORDER BY m_swParamID';
    strSRT := ' ORDER BY m_swParamID';
    if nChannel<>-1 then strSQL := 'SELECT * FROM SL3PARAMS WHERE m_swVMID='+IntToStr(nChannel)+strSRT;
    if nChannel=-1  then strSQL := 'SELECT * FROM SL3PARAMS'+strSRT;
    pTable.m_swAmParams := 0; pTable.Item.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmParams := nCount;
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
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
      m_sbyLockState  := FieldByName('m_sbyLockState').AsInteger;
      m_snDataType    := FieldByName('m_snDataType').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;


function CDBase.GetVPMatrix(nAID,nVMID:Integer;var pTable:SL3VMETERTAG):Boolean;
Var
    i      : Integer;
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
Begin
    res := False;
    if (nAID<>-1)and(nVMID<>-1) then strSQL := 'SELECT distinct s2.m_swABOID,s2.m_sbyGroupID,s0.m_swVMID,s1.m_swMID,s1.m_sbyPortID,m_swParamID,m_stSvPeriod,m_sParamExpress,m_snDataType,m_sbyDeltaPer,M_NGROUPLV,s1.m_sbyType,s0.m_sblSaved'+
                                   ' FROM SL3PARAMS as s0,SL3VMETERTAG as s1,SL3GROUPTAG as s2,QM_PARAMS as s3'+
                                   ' WHERE s0.m_swVMID='+IntToStr(nVMID)+
                                   ' AND s2.m_swABOID='+IntToStr(nAID)+
                                   ' AND s0.m_swParamID=s3.m_swType'+
                                   ' AND s0.m_swVMID=s1.m_swVMID'+
                                   ' AND s1.m_sbyGroupID=s2.m_sbyGroupID ORDER BY s0.m_swVMID,m_swParamID' else
    if (nAID<>-1)and(nVMID=-1) then strSQL := 'SELECT distinct s2.m_swABOID,s2.m_sbyGroupID,s0.m_swVMID,s1.m_swMID,s1.m_sbyPortID,m_swParamID,m_stSvPeriod,m_sParamExpress,m_snDataType,m_sbyDeltaPer,M_NGROUPLV,s1.m_sbyType,s0.m_sblSaved'+
                                   ' FROM SL3PARAMS as s0,SL3VMETERTAG as s1,SL3GROUPTAG as s2,QM_PARAMS as s3'+
                                   ' WHERE s2.m_swABOID='+IntToStr(nAID)+
                                   ' AND s0.m_swParamID=s3.m_swType'+
                                   ' AND s0.m_swVMID=s1.m_swVMID'+
                                   ' AND s1.m_sbyGroupID=s2.m_sbyGroupID ORDER BY s0.m_swVMID,m_swParamID' else
    if (nAID=-1)and(nVMID<>-1) then strSQL := 'SELECT distinct s2.m_swABOID,s2.m_sbyGroupID,s0.m_swVMID,s1.m_swMID,s1.m_sbyPortID,m_swParamID,m_stSvPeriod,m_sParamExpress,m_snDataType,m_sbyDeltaPer,M_NGROUPLV,s1.m_sbyType,s0.m_sblSaved'+
                                   ' FROM SL3PARAMS as s0,SL3VMETERTAG as s1,SL3GROUPTAG as s2,QM_PARAMS as s3'+
                                   ' WHERE s0.m_swVMID='+IntToStr(nVMID)+
                                   ' AND s0.m_swParamID=s3.m_swType'+
                                   ' AND s0.m_swVMID=s1.m_swVMID'+
                                   ' AND s1.m_sbyGroupID=s2.m_sbyGroupID ORDER BY s0.m_swVMID,m_swParamID' else
    if (nAID=-1)and(nVMID=-1)  then strSQL := 'SELECT distinct s2.m_swABOID,s2.m_sbyGroupID,s0.m_swVMID,s1.m_swMID,s1.m_sbyPortID,m_swParamID,m_stSvPeriod,m_sParamExpress,m_snDataType,m_sbyDeltaPer,M_NGROUPLV,s1.m_sbyType,s0.m_sblSaved'+
                                   ' FROM SL3PARAMS as s0,SL3VMETERTAG as s1,SL3GROUPTAG as s2,QM_PARAMS as s3'+
                                   ' WHERE s0.m_swVMID=s1.m_swVMID AND s1.m_sbyGroupID=s2.m_sbyGroupID'+
                                   ' AND s0.m_swParamID=s3.m_swType'+
                                   ' ORDER BY s0.m_swVMID,m_swParamID';
    pTable.m_swAmParams := 0; pTable.Item.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmParams := nCount;
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
      m_swAID         := FieldByName('m_swABOID').AsInteger;
      m_swGID         := FieldByName('m_sbyGroupID').AsInteger;
      m_swVMID        := FieldByName('m_swVMID').AsInteger;
      m_swMID         := FieldByName('m_swMID').AsInteger;
      m_sbyPortID     := FieldByName('m_sbyPortID').AsInteger;
      m_swParamID     := FieldByName('m_swParamID').AsInteger;
      m_sParamExpress := FieldByName('m_sParamExpress').AsString;
      m_snDataType    := FieldByName('m_snDataType').AsInteger;
      m_stSvPeriod    := FieldByName('m_stSvPeriod').AsInteger;
      m_sbyDataGroup  := FieldByName('M_NGROUPLV').AsInteger;
      m_sbyRecursive  := FieldByName('m_sbyDeltaPer').AsInteger;
      m_sblTarif      := FieldByName('m_sbyType').AsInteger;
      m_sblSaved      := FieldByName('m_sblSaved').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBase.GetVParamsGrTable(nAbon,nGroup,nChannel,nType:Integer;var pTable:SL3VMETERTAG):Boolean;
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
     if (nChannel=-1) and(nGroup=-1)  then
     strSQL := 'SELECT * FROM SL3PARAMS WHERE SL3PARAMS.m_swVMID IN '+
     ' (SELECT SL3VMETERTAG.m_swVMID FROM SL3GROUPTAG,SL3VMETERTAG '+
     ' WHERE SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID '+
     ' and SL3GROUPTAG.M_SWABOID='+IntToStr(nAbon)+') ORDER BY m_swParamID';
     if (nChannel=-1) and(nGroup<>-1) then
     strSQL := 'SELECT * FROM SL3PARAMS WHERE SL3PARAMS.m_swVMID IN '+
     ' (SELECT SL3VMETERTAG.m_swVMID FROM SL3GROUPTAG,SL3VMETERTAG '+
     ' WHERE SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID '+
     ' and SL3GROUPTAG.M_SWABOID='+IntToStr(nAbon)+
     ' and SL3GROUPTAG.M_SBYGROUPID='+IntToStr(nGroup)+' ) ORDER BY m_swVMID';
    End else
    if nType<>-1 then
    Begin
     if (nChannel=-1)and(nGroup<>-1) then
     strSQL := 'SELECT * FROM SL3PARAMS WHERE SL3PARAMS.m_swVMID IN '+
     ' (SELECT SL3VMETERTAG.m_swVMID FROM SL3GROUPTAG,SL3VMETERTAG '+
     ' WHERE SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID '+
     ' and SL3GROUPTAG.M_SWABOID='+IntToStr(nAbon)+
     ' and SL3GROUPTAG.M_SBYGROUPID='+IntToStr(nGroup)+
     ' and SL3VMETERTAG.M_SBYTYPE='+IntToStr(nType)+' ) ORDER BY m_swParamID' else
     if (nGroup=-1) then
     strSQL := 'SELECT * FROM SL3PARAMS WHERE SL3PARAMS.m_swVMID IN '+
     ' (SELECT SL3VMETERTAG.m_swVMID FROM SL3GROUPTAG,SL3VMETERTAG '+
     ' WHERE SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID '+
     ' and SL3GROUPTAG.M_SWABOID='+IntToStr(nAbon)+
     ' and SL3VMETERTAG.M_SBYTYPE='+IntToStr(nType)+' ) ORDER BY m_swParamID';
    End;
    if strSQL<>'' then
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmParams := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
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
      m_sbyLockState  := FieldByName('m_sbyLockState').AsInteger;
      m_snDataType    := FieldByName('m_snDataType').AsInteger;
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
     SetLength(pTable.Item.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
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
{function CDBase.GetVParamTbl(var pTable:SL3PARAMS):Boolean;
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
End;   }

function CDBase.GetVParamTbl(nIndex:Integer;var pTable:SL3PARAMS):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3PARAMS WHERE M_SWVMID='+IntToStr(nIndex);
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
      m_sbyLockState  := FieldByName('m_sbyLockState').AsInteger;
      m_snDataType    := FieldByName('m_snDataType').AsInteger;
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
              ',m_sParamExpress='+ ''''+m_sParamExpress+''''+
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
              ',m_sbyLockState=' +IntToStr(m_sbyLockState)+
              ',m_snDataType='   +IntToStr(m_snDataType)+
              ' WHERE M_SWVMID=' +IntToStr(M_SWVMID) + ' and m_swParamID='+IntToStr(m_swParamID);
              {m_swParamID=' +IntToStr(m_swParamID)+' and m_swID='+IntToStr(m_swID)+}

   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddVParamTable(nIndex:Integer;var pTable:SL3PARAMS):Boolean;
Var
    strSQL   : String;
Begin
   // if GetVParamTbl(nIndex,pTable)=True then Begin SetVParamTable(pTable);Result:=False;exit;End;
     if GetVParamTbl(nIndex,pTable)=True then Begin SetVParamTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3PARAMS'+
              '(m_swVMID,m_swParamID,m_sParamExpress,m_fMin,m_fLimit,m_fMax,m_fDiffer,m_dtLastTime,m_stSvPeriod,m_sblTarif,m_sblCalculate,m_sblSaved,m_swStatus,m_sblEnable,m_sbyDataGroup,m_snDataType,m_sbyLockState)'+
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
              IntToStr(m_sbyDataGroup)+ ','+
              IntToStr(m_snDataType)+ ','+
              IntToStr(m_sbyLockState)+ ')';
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
              '          m_swVMID,m_swParamID,m_sParamExpress,m_sParam,m_fMin,m_fLimit,m_fMax,m_fDiffer,m_dtLastTime,m_stSvPeriod,m_sblTarif,m_sblCalculate,m_sblSaved,m_swStatus,m_sblEnable,m_sbyDataGroup,m_sbyLockState,m_snDataType)'+
              ' SELECT '+IntToStr(nIndex)+',m_swCMDID,m_sEName,m_sEName,0,0,0,0,'+''''+DateTimeToStr(Now)+''''+',m_swSvPeriod,m_sblTarif,1,m_swIsGraph,m_swStatus,1,QM_PARAMS.m_sbyDataGroup,1,m_snDataType'+
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
    strQRY   : String;
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
      m_swAddres      := FieldByName('m_swAddres').AsString;
      m_swMask        := FieldByName('m_swMask').AsString;
      m_swGate        := FieldByName('m_swGate').AsString;
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
      m_sbyAllowInDConn := FieldByName('m_sbyAllowInDConn').AsInteger;
      m_sTransTime    := FieldByName('m_sTransTime').AsInteger;
      m_sCalendOn     := FieldByName('m_sCalendOn').AsInteger;
      m_sChooseExport := FieldByName('m_sChooseExport').AsInteger;
      m_swSelfTest    := FieldByName('m_swSelfTest').AsInteger;
      m_blOnStartCvery:= FieldByName('m_blOnStartCvery').AsInteger;
      m_dtEStart      := FieldByName('m_dtEStart').AsDateTime;
      m_dtEInt        := FieldByName('m_dtEInt').AsDateTime;
      m_dtLast        := FieldByName('m_dtLast').AsDateTime;
      m_sDBNAME       := FieldByName('m_sDBNAME').AsString;
      m_sDBUSR        := FieldByName('m_sDBUSR').AsString;
      m_sDBPASSW      := FieldByName('m_sDBPASSW').AsString;
      m_SDBSERVER     := FieldByName('m_SDBSERVER').AsString;
      m_SDBPORT       := FieldByName('m_SDBPORT').AsInteger;
      m_byEnableArchiv:= FieldByName('m_byEnableArchiv').AsInteger;
      m_sArchPath     := FieldByName('m_sArchPath').AsString;
      m_sSrcPath      := FieldByName('m_sSrcPath').AsString;
      m_tmArchPeriod  := FieldByName('m_tmArchPeriod').AsInteger;
      m_dtEnterArchTime:=FieldByName('m_dtEnterArchTime').AsDateTime;
      m_sbyDeltaFH    := FieldByName('m_sbyDeltaFH').AsInteger;
      strQRY          := FieldByName('M_SQUERYMASK').AsString;
      m_sDBFLOCATION  := FieldByName('M_SDBFLOCATION').AsString;
      m_nEInt         := FieldByName('m_nEInt').AsInteger;
      m_sMAKLOCATION  := FieldByName('m_sMAKLOCATION').AsString;
      m_sHOSTMAK      := FieldByName('m_sHOSTMAK').AsString;
      m_sEMAILMAK     := FieldByName('m_sEMAILMAK').AsString;
      m_sPASSMAK      := FieldByName('m_sPASSMAK').AsString;
      m_sNAMEMAILMAK  := FieldByName('m_sNAMEMAILMAK').AsString;
      m_blMdmExp      := FieldByName('m_blMdmExp').AsInteger;
      M_BLFMAKDELFILE := FieldByName('M_BLFMAKDELFILE').AsInteger;
      M_NSESSIONTIME  := FieldByName('M_NSESSIONTIME').AsInteger;
      if strQRY<>'' then M_SQUERYMASK := StrToInt64(strQRY) else M_SQUERYMASK:=0;
      {
       m_byEnableArchiv := cbm_byEnableArchiv.ItemIndex;
       m_sArchPath      := edm_sArchPath.Text;
       m_tmArchPeriod
      }
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
              '(m_sbyMode,m_sbyLocation,m_sbyAutoPack,m_swAddres,m_swMask,m_swGate,m_sStorePeriod,m_sStoreClrTime,m_sStoreProto,m_sPoolPeriod,m_sProjectName'+
              ',m_sPrePoolGraph,m_sQryScheduler,m_sPowerLimit,m_sPowerPrc,m_sAutoTray,m_sPrecise,m_sPreciseExpense,m_sBaseLocation, m_sKorrDelay,m_sSetForETelecom'+
              ',m_sInterSet,m_sMdmJoinName,m_sUseModem,m_sInterDelay,m_sChannSyn,m_sbyAllowInDConn,m_sTransTime,m_swSelfTest,m_blOnStartCvery, m_sbyDeltaFH,m_nEInt'+
              ',m_blMdmExp,M_BLFMAKDELFILE'+
              ',m_dtLast,m_dtEStart,m_sMAKLOCATION,M_SHOSTMAK,M_SEMAILMAK,M_SPASSMAK,m_sNAMEMAILMAK,M_SQUERYMASK,M_NSESSIONTIME,m_sCalendOn)'+
              ' VALUES('+
              IntToStr(m_sbyMode)+ ','+
              IntToStr(m_sbyLocation)+ ','+
              IntToStr(m_sbyAutoPack)+ ','+
              ''''+m_swAddres+''''+ ','+
              ''''+m_swMask+''''+ ','+
              ''''+m_swGate+''''+ ','+
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
              FloatToStr(m_sInterDelay) + ','+
              IntToStr(m_sChannSyn)+ ',' +
              IntToStr(m_sbyAllowInDConn)+ ',' +
              IntToStr(m_sTransTime) + ','+
              IntToStr(m_sChooseExport) + ','+
              IntToStr(m_swSelfTest) + ','+
              IntToStr(m_blOnStartCvery)+ ',' +
              IntToStr(m_sbyDeltaFH) + ','+
              IntToStr(m_nEInt) + ','+
              IntToStr(m_blMdmExp) + ','+
              IntToStr(M_BLFMAKDELFILE) + ','+
              ''''+DateTimeToStr(m_dtLast)+''''+ ','+
              ''''+DateTimeToStr(m_dtEStart)+''''+ ','+
              ''''+m_sMAKLOCATION+''''+ ','+
              ''''+M_SHOSTMAK+''''+ ','+
              ''''+M_SEMAILMAK+''''+ ','+
              ''''+M_SPASSMAK+''''+ ','+
              ''''+m_sNAMEMAILMAK+''''+ ','+
              ''''+IntToStr(M_SQUERYMASK)+''''+','+
              IntToStr(M_NSESSIONTIME) + ','+
              IntToStr(m_sCalendOn) + ')';
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
              ',m_swAddres='  +''''+m_swAddres+''''+
              ',m_swMask='  +''''+m_swMask+''''+
              ',m_swGate='  +''''+m_swGate+''''+
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
              ',m_sChannSyn=' + IntToStr(m_sChannSyn) +
              ',m_sbyAllowInDConn=' + IntToStr(m_sbyAllowInDConn) +
              ',m_sTransTime='+IntToStr(m_sTransTime)+
              ',m_sChooseExport='+IntToStr(m_sChooseExport)+
              ',m_swSelfTest='+IntToStr(m_swSelfTest)+
              ',m_blOnStartCvery='+IntToStr(m_blOnStartCvery)+
              ',m_sbyDeltaFH='+IntToStr(m_sbyDeltaFH)+
              ',m_nEInt='+IntToStr(m_nEInt)+
              ',m_blMdmExp='+IntToStr(m_blMdmExp)+
              ',M_BLFMAKDELFILE='+IntToStr(M_BLFMAKDELFILE)+
              ',m_dtLast='+''''+DateTimeToStr(m_dtLast)+''''+
              ',m_dtEStart='+''''+DateTimeToStr(m_dtEStart)+''''+
              ',m_sMAKLOCATION='+''''+m_sMAKLOCATION+''''+
              ',M_SHOSTMAK='+''''+M_SHOSTMAK+''''+
              ',M_SEMAILMAK='+''''+M_SEMAILMAK+''''+
              ',M_SPASSMAK='+''''+M_SPASSMAK+''''+
              ',m_sNAMEMAILMAK='+''''+m_sNAMEMAILMAK+''''+
              ',M_SQUERYMASK='+''''+IntToStr(M_SQUERYMASK)+''''+
              ',m_sCalendOn='+IntToStr(m_sCalendOn)+
              ',M_NSESSIONTIME='+IntToStr(M_NSESSIONTIME);
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.SetLastExportDate(dtLast:TDateTime):Boolean;
Var
    strSQL   : String;
Begin
    strSQL := 'UPDATE SGENSETTTAG SET m_dtLast='+''''+DateTimeToStr(dtLast)+'''';
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

{function CDBase.DelFixEvents(dt0, dt1 : TDateTime; nIndex:Integer):Boolean;
var
   strSQL : String;
Begin
   if nIndex<>-1 then
     strSQL := 'DELETE FROM SEVENTTTAG WHERE m_swGroupID='+IntToStr(nIndex) +
               ' and CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(dt0)+'''' + ' and ' + '''' + DateToStr(dt1) + '''';
   if nIndex=-1 then
     strSQL := 'DELETE FROM SEVENTTTAG WHERE ' +
                ' CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(dt0)+'''' + ' and ' + '''' + DateToStr(dt1) + '''';
   Result := ExecQry(strSQL);
End;  }

{function CDBase.GetFixEventsTable(nABOID,nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime;var pTable:SEVENTTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nVMID=$ffff then nVMID := 0;
    if (nGroup=-1)and(nEvents=-1) then  strSQL := 'SELECT * FROM SEVENTTTAG WHERE'+
    ' m_swVMID='+IntToStr(nVMID)+
    ' and CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + ''''
    else
    if (nGroup<>-1)and(nEvents=-1) then  strSQL := 'SELECT * FROM SEVENTTTAG WHERE'+
    ' m_swVMID='+IntToStr(nVMID)+
    ' and m_swGroupID='+IntToStr(nGroup)+
    ' and CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + ''''
    else
    if (nGroup<>-1)and(nEvents<>-1) then  strSQL := 'SELECT * FROM SEVENTTTAG WHERE'+
    ' m_swVMID='+IntToStr(nVMID)+
    ' and m_swGroupID='+IntToStr(nGroup)+
    ' and m_swEventID='+IntToStr(nEvents)+
    ' and CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + '''';
    pTable.Count := 0;
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
      m_swDescription   := FieldByName('m_swDescription').AsFloat;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;  }

{function CDBase.GetFixEventsTableFromStr(nGroup,nVMID:Integer;var nEvents:string;tm0,tm1:TDateTime;var pTable:SEVENTTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nVMID=$ffff then nVMID := 0;
    if Length(nEvents) = 0 then
    begin
      res := False;
      pTable.Count := 0;
      exit;
    end;
    if (nEvents[Length(nEvents)] = ',') then
      nEvents[Length(nEvents)] := ' ';
    strSQL := 'SELECT * FROM SEVENTTTAG WHERE'+
    ' m_swVMID='+IntToStr(nVMID)+
    ' and m_swGroupID='+IntToStr(nGroup)+
    ' and m_swEventID in ('+nEvents+ ')' +
    ' and CAST(m_sdtEventTime AS DATE) BETWEEN '+''''+DateToStr(tm0)+'''' + ' and ' + '''' + DateToStr(tm1) + '''';
    pTable.Count := 0;
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
      m_swDescription   := FieldByName('m_swDescription').AsFloat;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;    }
{
     m_swID         : Integer;
     m_swGroupID    : Word;
     m_swEventID    : Word;
     m_sdtEventTime : TDateTIme;
     m_nEvent       : Word;
     m_sUser        : String[10];
     m_sbyEnable    : Byte;
}
{function CDBase.GetUspdEventALL(nIndex:Integer;var pTable:SEVENTTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nIndex=-1 then  strSQL := 'SELECT * FROM SEVENTTTAG ORDER BY m_swEventID';
    if nIndex<>-1 then strSQL := 'SELECT * FROM SEVENTTTAG WHERE m_swGroupID='+IntToStr(nIndex)+' ORDER BY m_swEventID';
    if OpenQry(strSQL,nCount)=True then
    Begin

     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swDescription   := FieldByName('m_swDescription').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;  }
{function CDBase.GetUspdEventCorrector(nEvent:Integer):Boolean;
Var
    pTable:SEVENTTAG;
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT m_swDescription FROM SEVENTTTAG where m_swEventID ='+ IntToStr(nEvent);
    if OpenQry(strSQL,nCount)=True then
     Begin
      pTable.m_swDescription := FADOQuery.FieldByName('m_swDescription').AsInteger;
    End;
    CloseQry;
    Result := res;
End;   }
function CDBase.FixUspdEventCorrector(nEvent:Integer;m_swDescription:extended):Boolean;
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
    pTable.m_swDescription:= m_swDescription;
    if m_nEV[0].Items[nEvent].m_sbyEnable=1 then
    Begin
//     m_pDB.AddFixEventTable(pTable);
     Result := True;
    End else
    Result := True;
End;
function CDBase.FixUspdEventCorrectorEx(dtOldTime:TDateTIme;nEvent:Integer;m_swDescription:extended):Boolean;
Var
    pTable:SEVENTTAG;
Begin
    Result := False;
    if (nEvent=-1) then exit;
    pTable.m_swVMID       := 0;
    pTable.m_swGroupID    := 0;
    pTable.m_swEventID    := nEvent;
    pTable.m_sdtEventTime := dtOldTime;
    pTable.m_sUser        := m_strCurrUser;
    pTable.m_sbyEnable    := 1;
    pTable.m_swDescription:= m_swDescription;
    if m_nEV[0].Items[nEvent].m_sbyEnable=1 then
    Begin
//     m_pDB.AddFixEventTable(pTable);
     Result := True;
    End else
    Result := True;
End;

{function CDBase.FixUSPDCorrMonth(Value : integer; Time : TDateTime) : boolean;
var strSQL : string;
    nCount : Integer;
begin
   strSQL := 'SELECT 0 FROM SEVENTTTAG WHERE M_SWEVENTID = ' + IntToStr(EVS_SUM_KORR);
   if OpenQry(strSQL,nCount)=True then
   Begin
     strSQL := 'UPDATE SEVENTTTAG SET '+
              ' M_SDTEVENTTIME='+''''+DateTimeToStr(Time)+''''+','+
              ' M_SWDESCRIPTION=' + IntToStr(Value)+
              ' WHERE M_SWEVENTID = ' + IntToStr(EVS_SUM_KORR) + ' AND M_SWGROUPID=3';
   End
   else
     strSQL := 'INSERT INTO SEVENTTTAG'+
               '(M_SWGROUPID,M_SWEVENTID,M_SDTEVENTTIME,M_SUSER,M_SBYENABLE,M_SWVMID,M_SWDESCRIPTION)'+
               ' VALUES(3,' + IntToStr(EVS_SUM_KORR) + ', '+
               '''' + DateTimeToStr(Time) + '''' + ','+
               '''' + m_strCurrUser + ''''+ ','+
               '1,0,'+
               IntToStr(Value)+ ')';
   CloseQry;
   Result := ExecQry(strSQL);
end;  }

{function CDBase.UpdateKorrMonth(Delta: TDateTime):boolean;
var i          : Integer;
    strSQL     : String;
    res        : Boolean;
    nCount, ID : Integer;
    BeginMonth,
    _1Sec      : TDateTime;
    KorTime    : double;
Begin
    res := false;
    BeginMonth := Now;
    BeginMonth := cDateTimeR.GetBeginMonth(BeginMonth);
    _1Sec      := EncodeTime(0, 0, 1, 0);
    strSQL := 'SELECT M_SWDESCRIPTION, m_swID FROM SEVENTTTAG WHERE M_SWEVENTID=' + IntToStr(EVH_CORR_MONTH) +
              ' AND CAST(M_SDTEVENTTIME AS DATE)=' +
              '''' + DateToStr(BeginMonth) + '''';
    if OpenQry(strSQL,nCount)=True then
    begin
      res := True;
      with FADOQuery do
      begin
        ID      := FieldByName('m_swID').AsInteger;
        KorTime := FieldByName('M_SWDESCRIPTION').AsFloat;
      end;
    end;
    CloseQry;
    if res then
      KorTime := KorTime + Delta/_1Sec
    else
      KorTime := Delta/_1Sec;
    if res then
      strSQL := 'UPDATE SEVENTTTAG SET M_SWDESCRIPTION=' + FloatToStr(KorTime) +
                ' WHERE m_swID=' + IntToStr(ID)
    else
      strSQL := 'INSERT INTO SEVENTTTAG' +
                '(M_SWGROUPID, M_SWEVENTID, M_SDTEVENTTIME, M_SUSER, M_SBYENABLE, M_SWVMID, M_SWDESCRIPTION, M_SWADVDESCRIPTION)' +
                ' VALUES(' +
                '0,' +
                IntToStr(EVH_CORR_MONTH) + ',' +
                '''' + DateToStr(BeginMonth) + '''' + ',' +
                '''' + 'a2000' + '''' + ',' +
                '1' + ',' +
                '0' + ',' +
                FloatToStr(KorTime) + ',' +
                '0' + ')';
    res := ExecQry(strSQL);
end;  }

function CDBase.FixLimitEvent(VMID, CMDID, TID, EvID : integer; Time : TDateTime) : boolean;
begin
   Result := false;
{   if true IsLimitEvent(VMID, CMDID, TID, EvID, Time) then
     Result := UpdateLimitEvent(VMID, CMDID, TID, EvID)
   else
     Result := AddLimitEvent(VMID, CMDID, TID, EvID, Time); }
end;

{function CDBase.IsLimitEvent(VMID, CMDID, TID, EvID : integer; Time : TDateTime) : boolean;
var strSQL   : string;
    nCount   : integer;
begin
   Result := false;
   strSQL := 'SELECT 0 FROM SEVENTTTAG WHERE ' +
             ' m_swEventID=' + IntToStr(EvID) +
             ' and m_swVMID=' + IntToStr(VMID) +
             ' and m_swAdvDescription=' + IntToStr(CMDID) +
             ' and m_swDescription=' + FloatToStr(EvID) +
             ' and m_sdtEventTime=' + '''' + DateTimeToStr(Time) + '''';
   Result := OpenQry(strSQL,nCount);
   CloseQry;
end;  }

{function CDBase.AddLimitEvent(VMID, CMDID, TID, EvID : integer; Time : TDateTime) : boolean;
var strSQL : string;
begin
   Result := false;
   strSQL := 'INSERT INTO SEVENTTTAG' +
             '(m_swVMID,m_swGroupID,m_swEventID,m_sdtEventTime,m_sUser,m_sbyEnable,m_swDescription,m_swAdvDescription)'+
             'VALUES('+
             IntToStr(VMID) + ',' + '2' + ',' +
             IntToStr(EvID) + ',' +
             '''' + DateTimeToStr(Time) + '''' +  ',' +
             '''' + m_strCurrUser + '''' + ',' +  '1' + ',' +
             FloatToStr(TID) + ',' +
             IntToStr(CMDID) + ')';
   Result := ExecQry(strSQL);
end;    }

function CDBase.UpdateLimitEvent(VMID, CMDID, TID, EvID : integer) : boolean;
var strSQL : string;
begin
   Result := true;
end;

{function CDBase.GetLimitEventTbl(VMID, CMDID, TID : integer; var pTable : SEVENTTAGS) : boolean;
var strSQL      : string;
    nCount, i   : integer;
begin
   strSQL := 'SELECT * FROM SEVENTTTAG WHERE ' +
             ' m_swEventID>=' + IntToStr(EVM_LSTEP_UP) +
             ' and m_swEventID<=' + IntToStr(EVM_L_NORMAL) +
             ' and m_swVMID=' + IntToStr(VMID) +
             ' and m_swDescription=' + IntToStr(TID) +
             ' and m_swAdvDescription=' + IntToStr(CMDID);
   pTable.Count := 0;
   Result := OpenQry(strSQL,nCount);
   if Result then
   begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.EOF do
     begin
       with FADOQuery,pTable.Items[i] do
       begin
         m_swID             := FieldByName('m_swID').AsInteger;
         m_swVMID           := FieldByName('m_swVMID').AsInteger;
         m_swGroupID        := FieldByName('m_swGroupID').AsInteger;
         m_swEventID        := FieldByName('m_swEventID').AsInteger;
         m_sdtEventTime     := FieldByName('m_sdtEventTime').AsDateTime;
         m_sUser            := FieldByName('m_sUser').AsString;
         m_sbyEnable        := FieldByName('m_sbyEnable').AsInteger;
         m_swDescription    := FieldByName('m_swDescription').AsInteger;
         m_swAdvDescription := FieldByName('m_swAdvDescription').AsInteger;
         Next;
         Inc(i);
       end;
     end;
   end;
   CloseQry;
end;   }

{function CDBase.DelLimitEvent(var pTable : SEVENTTAG) : boolean;
var strSQL   : string;
begin
   strSQL := 'DELETE FROM SEVENTTTAG WHERE ' +
             ' m_swVMID=' + IntToStr(pTable.m_swVMID) +
             ' and m_swGroupID=' + IntToStr(2) +
             ' and m_swEventID=' + IntToStr(pTable.m_swEventID) +
             ' and m_swDescription=' + FloatToStr(pTable.m_swDescription) +
             ' and m_swAdvDescription=' + IntToStr(pTable.m_swAdvDescription) +
             ' and m_sdtEventTime=' + '''' + DateTimeToStr(pTable.m_sdtEventTime) + '''';
   Result := ExecQry(strSQL);
end; }

{function CDBase.FixUspdEvent(PKey,Group,nEvent:Integer):Boolean;
Var
    pTable:SEVENTTAG;
    i:integer;
Begin
    Result := False;
    if (nEvent=-1) then exit;
    pTable.m_swVMID         := PKey;
    pTable.m_swGroupID      := Group;
    pTable.m_swEventID      := nEvent;
    pTable.m_sdtEventTime   := Now;
    pTable.m_sUser          := m_strCurrUser;
    pTable.m_sbyEnable      := 1;
    pTable.m_swDescription  := 0;
   for i := 0 to m_nEV[Group].Count -1 do
   begin
   if ((m_nEV[Group].Items[i].m_swEventID = nEvent)and(m_nEV[Group].Items[i].m_sbyEnable=1) and(m_nEV[Group].Items[i].m_swGroupID=Group) ) then
    Begin
     if Group=0 then if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,m_nJrnlN1.Strings[nEvent]) else
     if Group=2 then if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,m_nJrnlN3.Strings[nEvent]);
     m_pDB.AddFixEventTable(pTable);
     Result := True;
    End else
    Result := True;                                                     
   end;
End;  }


{function CDBase.FixUspdDescEvent(PKey,Group,nEvent:Integer;swDescription:Extended):Boolean;
Var
    pTable:SEVENTTAG;
    i:integer;
Begin
    Result := False;
    if (nEvent=-1) then exit;
    pTable.m_swVMID         := PKey;
    pTable.m_swGroupID      := Group;
    pTable.m_swEventID      := nEvent;
    pTable.m_sdtEventTime   := Now;
    pTable.m_sUser          := m_strCurrUser;
    pTable.m_sbyEnable      := 1;
    pTable.m_swDescription  := swDescription;

   for i := 0 to m_nEV[Group].Count -1 do
   begin
   if ((m_nEV[Group].Items[i].m_swEventID = nEvent)and(m_nEV[Group].Items[i].m_sbyEnable=1) and(m_nEV[Group].Items[i].m_swGroupID=Group) ) then
    Begin
     //if (EventBox<>Nil) then EventBox.FixEvents(ET_NORMAL,m_nJrnlN1.Strings[nEvent]);
     m_pDB.AddFixEventTable(pTable);
     Result := True;
    End else
    Result := True;                                                     
   end;
End;   }

{function CDBase.FixMeterEvent(nGroup,nEvent,nVMID:Integer;Descr:Double; Date : TDateTime):Boolean;
Var
    pTable:SEVENTTAG;
    m_nobj:ARCH_USPD;
Begin
    Result := False;
    if ((nEvent<m_nJrnlN3.Count) and (nGroup = 2)) or ((nEvent<m_nJrnlN1.Count) and (nGroup = 0)) or 
       ((nEvent<m_nJrnlN4.Count) and (nGroup = 3)) or ((nEvent<m_nJrnlN2.Count) and (nGroup = 1)) then
    Begin
     case nGroup of
       0 : TraceL(3, nVMID, '(__)CL3MD::>CVMTR:' + DateTimeToStr(Date) + ' ; EVT:' + m_nJrnlN1.Strings[nEvent]);
       1 : TraceL(3, nVMID, '(__)CL3MD::>CVMTR:' + DateTimeToStr(Date) + ' ; EVT:' + m_nJrnlN2.Strings[nEvent]);
       2 : TraceL(3, nVMID, '(__)CL3MD::>CVMTR:' + DateTimeToStr(Date) + ' ; EVT:' + m_nJrnlN3.Strings[nEvent]);
       3 : TraceL(3, nVMID, '(__)CL3MD::>CVMTR:' + DateTimeToStr(Date) + ' ; EVT:' + m_nJrnlN4.Strings[nEvent]);
     end;
//     TraceL(3, nVMID, '(__)CL3MD::>CVMTR: EVT:' + m_nJrnlN3.Strings[nEvent]);
     Result := False;
     if (nGroup=-1) or (nGroup>3) then exit;
     if (nGroup = 0) or (nGroup = 3) then
       nVMID := 0;
     pTable.m_swVMID       := nVMID;
     pTable.m_swGroupID    := nGroup;
     pTable.m_swEventID    := nEvent;
     pTable.m_sdtEventTime := Date;
     pTable.m_sUser        := m_strCurrUser;
     pTable.m_swDescription:= Descr;
     pTable.m_sbyEnable    := 1;
     ///////////energo///////////////
     m_nobj.n_obj := nVMID;
     m_nobj.on_date_time := Date;
     m_nobj.n_ri := 0;
     ///////////////////////////
     if m_nEV[nGroup].Items[nEvent].m_sbyEnable=1 then
     Begin
      m_pDB.AddFixEventTable(pTable);
      if m_blIsEEnergo=True then m_pDB.AddArchUspdTable(m_nobj, nGroup, nEvent);
      Result := True;
     End else
     Result := True;
    End else
     TraceL(3, nVMID, '(__)CL3MD::>CVMTR: EVT:Unknow Code:' + IntToStr(nEvent)+' ?');
End;   }


{function CDBase.IsFixEvent(var pTable:SEVENTTAG):Boolean;
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
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;  }

{function CDBase.UpdateFixEventTable(var pTable:SEVENTTAG):Boolean;
Var
    strSQL   : String;
    nCount :integer;
Begin
  strSQL := 'SELECT 0 FROM SEVENTTTAG WHERE'+
             ' M_SWEVENTID = 25'+
             ' and CAST(m_sdtEventTime AS DATE) = ' + ''''+DateToStr(pTable.m_sdtEventTime)+'''';
   if OpenQry(strSQL,nCount)=True then
   begin
   strSQL := 'UPDATE SEVENTTTAG SET '+
              ' M_SDTEVENTTIME='+''''+DateTimeToStr(pTable.m_sdtEventTime)+''''+','+
              ' M_SWDESCRIPTION=' + FloatToStr(pTable.M_SWDESCRIPTION)+
              ' WHERE M_SWEVENTID = 25 AND M_SWGROUPID=0';
   Result := ExecQry(strSQL);
   end
   else
  Result := false;
end;   }

{function CDBase.AddFixEventTable(var pTable:SEVENTTAG):Boolean;
Var
    strSQL   : String;
Begin
    Result := False;
    if IsFixEvent(pTable)<>True then
    Begin
     if (pTable.m_swEventID = 25) and (pTable.m_swGroupID = 0) then Result := UpdateFixEventTable(pTable);
     if  Result = true then exit else
    with pTable do
    Begin
    strSQL := 'INSERT INTO SEVENTTTAG'+
              '(m_swVMID,m_swGroupID,m_swEventID,m_sdtEventTime,m_sUser,m_sbyEnable,m_swDescription)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swGroupID)+ ','+
              IntToStr(m_swEventID)+ ','+
              ''''+DateTimeToStr(m_sdtEventTime)+''''+ ','+
              ''''+m_sUser+''''+ ','+
              IntToStr(m_sbyEnable)+ ','+
              FloatToStr(m_swDescription)+ ')';
    End;
    if m_byEvents=1 then
    Result := ExecQry(strSQL);
    End;
End;  }

{function CDBase.DelFixEventsTable(nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime):Boolean;
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
End; }
















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
    strSQL := 'SELECT * FROM SQRYSDLTAG ORDER BY CAST(m_sdtEventTime AS TIME)';
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
    if OpenQrySA(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuerySA.Eof do Begin
     with FADOQuerySA,pTable.Items[i] do  Begin
      m_swID         := FieldByName('m_swID').AsInteger;
      m_swUID        := FieldByName('m_swUID').AsInteger;
      m_swSLID       := FieldByName('m_swSLID').AsInteger;
      m_sdtRegDate   := FieldByName('m_sdtRegDate').AsDateTime;
      m_strShName    := FieldByName('m_strShName').AsString;
      m_strPassword  := DecodeStrCrypt(FieldByName('m_strPassword').AsString);
      //m_strPassword  := FieldByName('m_strPassword').AsString;
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
      m_sbyQryGrp    := FieldByName('m_sbyQryGrp').AsInteger;
      m_sbyAccReg    := FieldByName('m_sbyAccReg').AsInteger;
      m_sAccesReg    := FieldByName('m_sAccesReg').AsString;
      m_sAllowAbon   := FieldByName('m_sAllowAbon').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQrySA;
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
    if OpenQrySA(strSQL,nCount)=True then
    Begin
     res := True;
     with FADOQuerySA,pTable do
     Begin
      m_swID         := FieldByName('m_swID').AsInteger;
      m_swUID        := FieldByName('m_swUID').AsInteger;
      m_swSLID       := FieldByName('m_swSLID').AsInteger;
      m_sdtRegDate   := FieldByName('m_sdtRegDate').AsDateTime;

      m_strShName    := FieldByName('m_strShName').AsString;
      m_strPassword  := DecodeStrCrypt(FieldByName('m_strPassword').AsString);
      //m_strPassword  := FieldByName('m_strPassword').AsString;
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
      m_sbyQryGrp    := FieldByName('m_sbyQryGrp').AsInteger;
      m_sbyAccReg    := FieldByName('m_sbyAccReg').AsInteger;
      m_sAccesReg    := FieldByName('m_sAccesReg').AsString;
      m_sAllowAbon   := FieldByName('m_sAllowAbon').AsString;
      End;
    End;
    CloseQrySA;
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
    if OpenQrySA(strSQL,nCount)=True then
   Begin
       FADOQuerySA.Edit;
       TBlobField(FADOQuerySA.FieldByName('m_sPhoto')).LoadFromStream(MemoryStream);
       ptable.m_sPhoto := TBlobField(FADOQuerySA.FieldByName('m_sPhoto')).Asstring;
       FADOQuerySA.Post;
    End;
    CloseQrySA;
End;

function CDBase.GetPhotoTable(var pTable:SUSERTAG;var MemoryStream : TMemoryStream):boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
     strSQL := 'SELECT * FROM SUSERTAG WHERE m_swUID='+IntToStr(pTable.m_swUID);
    if OpenQrySA(strSQL,nCount)=True then
    Begin
      {FADOQuerySA.Edit;
      if TBlobField(FADOQuerySA.FieldByName('m_sPhoto')).Isnull <> true then
      begin
      TBlobField(FADOQuerySA.FieldByName('m_sPhoto')).SaveToStream(MemoryStream);
       res := true;
      end
       else res := false;
      FADOQuerySA.Post;
      }
    End;
    CloseQrySA;

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
    if OpenQrySA(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQrySA;
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
              ',m_sbyQryGrp='+IntToStr(m_sbyQryGrp)+              
              ',m_sbyAccReg='+IntToStr(m_sbyAccReg)+
              ',m_sAccesReg='''+m_sAccesReg+''''+
              ',m_sAllowAbon='+''''+m_sAllowAbon+''''+
          //    ',m_sPhoto='+''''+m_sPhoto+''''+
              ' WHERE m_swUID='+IntToStr(pTable.m_swUID);
    End;
    Result := ExecQrySA(strSQL);
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
              ',m_sbyPrmDE,m_sbyPrmPE,m_sbyPrmQE,m_sbyPrmCE,m_sbyPrmGE,m_sbyPrmTE,m_sbyPrmCNE,m_sbyPrmPRE,m_sbyEnable,m_sbyQryGrp,m_sbyAccReg,m_sAccesReg,m_sAllowAbon)'+
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
              IntToStr(m_sbyEnable)+ ','+
              IntToStr(m_sbyQryGrp)+ ','+              
              IntToStr(m_sbyAccReg)+ ','+
              ''''+m_sAccesReg+''''+ ','+
              ''''+m_sAllowAbon+''''+
              ')';
             // IntToStr(m_sbyEnable)+ '')';
             // ''''+m_sPhoto+''''+ ')';
    End;
    ExecQrySA(strSQL);
    Result := res;
End;
function CDBase.DelUserTable(swUID:Integer):Boolean;
Var
    strSQL : String;
Begin
    strSQL := 'DELETE FROM SUSERTAG WHERE m_swUID='+IntToStr(swUID);
    Result := ExecQrySA(strSQL);
End;

function CDBase.GetUserID(name : string):integer;
  // JKLJKL    BO 20.11.18
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
  strSQL := 'SELECT M_SWID ID FROM SUSERTAG WHERE M_STRSHNAME = ''' + name + '''';
  if OpenQry(strSQL,nCount)=True then
  Begin
   Result   := FADOQuery.FieldByName('ID').asInteger;
  End else Result := -1;
  CloseQry;
end;

function CDBase.GetUserNameFromID(ID : integer):string;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
  strSQL := 'SELECT M_STRSHNAME NAME FROM SUSERTAG WHERE M_SWID = ''' + IntToStr(ID) + '''';
  if OpenQry(strSQL,nCount)=True then
  Begin
   Result   := FADOQuery.FieldByName('NAME').asString;
  End else Result := 'Безымянный';
  CloseQry;
end;

function CDBase.GetGroupQueryName(GroupQueryID : integer):string;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
  strSQL := 'SELECT NAME FROM QUERYGROUP WHERE ID = ' + IntToStr(GroupQueryID);
  if OpenQry(strSQL,nCount)=True then
  Begin
   Result   := FADOQuery.FieldByName('NAME').asString;
  End else Result := 'Безымянный';
  CloseQry;
end;

function CDBase.UpdateGroupQuery(GroupQueryID : integer; DATEQUERY : TDate; ERRORQUERY:byte):Boolean;
  // JKLJKL    BO 12.12.18
Var
    strSQL   : String;
Begin
  strSQL := 'UPDATE QUERYGROUP SET ' +
            'DATEQUERY = ''' + DateToStr(DATEQUERY) + '''' + ', ' +
            'ERRORQUERY = ' + IntToStr(ERRORQUERY) +
            'WHERE ID = ' + IntToStr(GroupQueryID);
  Result := ExecQry(strSQL);
end;


function CDBase.AddLimitData(var pTable: SL3LIMITTAG):boolean;
var strSQL : string;
begin
   with pTable do
     strSQL := 'INSERT INTO SL3LIMITTAG' +
               '(m_swABOID, m_swVMID, m_swCMDID, m_swTID, m_swMinValue, m_swMaxValue, m_sDateBeg, m_sDateEnd)'+
               'VALUES('+
               IntToStr(m_swABOID) + ',' +
               IntToStr(m_swVMID) + ',' +
               IntToStr(m_swCMDID) + ',' +
               IntToStr(m_swTID) + ',' +
               FloatToStr(m_swMinValue) + ',' +
               FloatToStr(m_swMaxValue) + ',' +
               '''' + DateTimeToStr(m_sDateBeg) + '''' + ',' +
               '''' + DateTimeToStr(m_sDateEnd) + '''' + ')';
   Result := ExecQry(strSQL);
end;

function CDBase.GetLimitDatas(VMID, CMDID, TID : integer; var pTable: SL3LIMITTAGS):boolean;
var i, nCount : integer;
    strSQL    : string;
    res       : boolean;
begin
   res := false;
   strSQL := 'SELECT * FROM SL3LIMITTAG WHERE m_swVMID = ' + IntToStr(VMID) +
             ' AND m_swCMDID = ' + IntToStr(CMDID) + ' AND m_swTID = ' + IntToStr(TID) +
             ' ORDER BY m_sDateBeg';
   pTable.Count := 0;
   if OpenQry(strSQL, nCount) then
   begin
     res := true; i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery, pTable.Items[i] do
       begin
         mswID        := FieldByName('mswID').AsInteger;
         m_swABOID    := FieldByName('m_swABOID').AsInteger;
         m_swVMID     := FieldByName('m_swVMID').AsInteger;
         m_swCMDID    := FieldByName('m_swCMDID').AsInteger;
         m_swTID      := FieldByName('m_swTID').AsInteger;
         m_swMinValue := FieldByName('m_swMinValue').AsFloat;
         m_swMaxValue := FieldByName('m_swMaxValue').AsFloat;
         m_sDateBeg   := FieldByName('m_sDateBeg').AsDateTime;
         m_sDateEnd   := FieldByName('m_sDateEnd').AsDateTime;
         Inc(i);
         Next;
       end;
     end;
   end;
   CloseQry;
   Result := res;
end;

function CDBase.GetLimitDatasFromDate(dt_Date : TDateTime; var pTable: SL3LIMITTAGS):boolean;
var i, nCount : integer;
    strSQL    : string;
    res       : boolean;
begin
   res := false;
   strSQL := 'SELECT * FROM SL3LIMITTAG WHERE m_sDateBeg=' + '''' + DateTimeToStr(dt_Date) + '''';
   pTable.Count := 0;
   if OpenQry(strSQL, nCount) then
   begin
     res := true; i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery, pTable.Items[i] do
       begin
         mswID        := FieldByName('mswID').AsInteger;
         m_swABOID    := FieldByName('m_swABOID').AsInteger;
         m_swVMID     := FieldByName('m_swVMID').AsInteger;
         m_swCMDID    := FieldByName('m_swCMDID').AsInteger;
         m_swTID      := FieldByName('m_swTID').AsInteger;
         m_swMinValue := FieldByName('m_swMinValue').AsFloat;
         m_swMaxValue := FieldByName('m_swMaxValue').AsFloat;
         m_sDateBeg   := FieldByName('m_sDateBeg').AsDateTime;
         m_sDateEnd   := FieldByName('m_sDateEnd').AsDateTime;
         Inc(i);
         Next;
       end;
     end;
   end;
   CloseQry;
   Result := res;
end;

function CDBase.GetAllLimitDatas(var pTable: SL3LIMITTAGS):boolean;
var i, nCount : integer;
    strSQL    : string;
    res       : boolean;
begin
   res := false;
   strSQL := 'SELECT * FROM SL3LIMITTAG ORDER BY m_sDateBeg';
   pTable.Count := 0;
   if OpenQry(strSQL, nCount) then
   begin
     res := true; i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery, pTable.Items[i] do
       begin
         mswID        := FieldByName('mswID').AsInteger;
         m_swABOID    := FieldByName('m_swABOID').AsInteger;
         m_swVMID     := FieldByName('m_swVMID').AsInteger;
         m_swCMDID    := FieldByName('m_swCMDID').AsInteger;
         m_swTID      := FieldByName('m_swTID').AsInteger;
         m_swMinValue := FieldByName('m_swMinValue').AsFloat;
         m_swMaxValue := FieldByName('m_swMaxValue').AsFloat;
         m_sDateBeg   := FieldByName('m_sDateBeg').AsDateTime;
         m_sDateEnd   := FieldByName('m_sDateEnd').AsDateTime;
         Inc(i);
         Next;
       end;
     end;
   end;
   CloseQry;
   Result := res;
end;

function CDBase.DeleteLimitData(var pTable: SL3LIMITTAG):boolean;
var strSQL : string;
begin
    with pTable do
      strSQL := 'DELETE FROM SL3LIMITTAG WHERE m_swVMID = ' + IntToStr(m_swVMID) +
                ' AND m_swCMDID=' + IntToStr(m_swCMDID) + ' AND m_swTID=' + IntToStr(m_swTID);
    Result := ExecQry(strSQL);
end;

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
    if OpenQrySA(strSQL,nCount)=True then
    Begin
     res      := True;
     m_swSLID := FADOQuerySA.FieldByName('m_swSLID').AsInteger;
    End;
    CloseQrySA;
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
    ' and m_strPassword='+''''+EncodeStrCrypt(pTable.m_strPassword)+''''+
    ' and m_swSLID='+IntToStr(pTable.m_swSLID)
    else
    if m_nValue=1 then
    strSQL := 'SELECT * FROM SUSERTAG WHERE m_strShName='+''''+pTable.m_strShName+''''+
    ' and m_strPassword='+''''+EncodeStrCrypt(pTable.m_strPassword)+'''';
    if OpenQrySA(strSQL,nCount)=True then
    Begin
     res := True;
     with FADOQuerySA,pTable do
     Begin
      m_swID         := FieldByName('m_swID').AsInteger;
      m_swUID        := FieldByName('m_swUID').AsInteger;
      m_swSLID       := FieldByName('m_swSLID').AsInteger;
      m_sdtRegDate   := FieldByName('m_sdtRegDate').AsDateTime;

      m_strShName    := FieldByName('m_strShName').AsString;
      m_strPassword  := DecodeStrCrypt(FieldByName('m_strPassword').AsString);
      //m_strPassword  := FieldByName('m_strPassword').AsString;
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
      m_sbyQryGrp    := FieldByName('m_sbyQryGrp').AsInteger;
      m_sbyAccReg    := FieldByName('m_sbyAccReg').AsInteger;
      m_sAccesReg    := FieldByName('m_sAccesReg').AsString;
      m_sAllowAbon   := FieldByName('m_sAllowAbon').AsString;
     // m_sPhoto       := FieldByName('m_sPhoto').AsString;
     End;
    End;
    CloseQrySA;
    Result := res;
End;

function CDBase.GetAllowAbonStr(UID : integer) : string;
Var strSQL   : String;
    nCount   : Integer;
begin
   Result := '';
   strSQL := 'SELECT M_SALLOWABON FROM SUSERTAG WHERE M_SWUID=' + IntToStr(UID);
   if OpenQrySA(strSQL,nCount)=True then
   Begin
     with FADOQuerySA do
     Begin
       Result   := FieldByName('m_sAllowAbon').AsString;
     End;
   End;
   CloseQrySA;
end;

{
    SL3TRANSTIME = packed record
     m_swID        : Integer;
     m_dtTimeUP    : TDateTime;
     m_dtTimeUPNew : TDateTime;
     m_blEnableUP  : Boolean;
     m_dtTimeDN    : TDateTime;
     m_dtTimeDNNew : TDateTime;
     m_blEnableDN  : Boolean;
     m_blEnable    : Boolean
    End;
}


function CDBase.GetTransTimeTable(var pTable:SL3TRANSTIMES):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3TRANSTIME ORDER BY m_swTRSID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swTRSID     := FieldByName('m_swTRSID').AsInteger;
      m_dtTime      := FieldByName('m_dtTime').AsDateTime;
      m_dtTimeNew   := FieldByName('m_dtTimeNew').AsDateTime;
      m_sbyState    := FieldByName('m_sbyState').AsInteger;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsTransTime(nIndex:Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3TRANSTIME WHERE m_swTRSID='+IntToStr(nIndex);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetTransTimeTable(var pTable:SL3TRANSTIME):Boolean;
Var
    strSQL : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3TRANSTIME SET '+
              ' m_swTRSID='+IntToStr(m_swTRSID)+
              ',m_dtTime='+''''+DateTimeToStr(m_dtTime)+''''+
              ',m_dtTimeNew='+''''+DateTimeToStr(m_dtTimeNew)+''''+
              ',m_sbyState='+IntToStr(m_sbyState)+
              ',m_sbyEnable='+IntToStr(m_sbyEnable)+
              ' WHERE m_swTRSID='+IntToStr(m_swTRSID);
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AddTransTimeTable(var pTable:SL3TRANSTIME):Boolean;
Var
    strSQL   : String;
Begin
    if IsTransTime(pTable.m_swTRSID)=True then Begin SetTransTimeTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3TRANSTIME'+
              '(m_swTRSID,m_dtTime,m_dtTimeNew,m_sbyState,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swTRSID)+ ','+
              ''''+DateTimeToStr(m_dtTime)+''''+ ','+
              ''''+DateTimeToStr(m_dtTimeNew)+''''+ ','+
              IntToStr(m_sbyState)+ ','+
              IntToStr(m_sbyEnable)+')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelTransTimeTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM SL3TRANSTIME WHERE m_swTRSID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM SL3TRANSTIME';
    Result := ExecQry(strSQL);
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
      m_swID         := FieldByName('m_swID').AsInteger;
      m_swCtrlID     := FieldByName('m_swCtrlID').AsInteger;
      m_swColor      := FieldByName('m_swColor').AsInteger;
      m_sstrFontName := FieldByName('m_sstrFontName').AsString;
      m_swFontSize   := FieldByName('m_swFontSize').AsInteger;
      m_swColorPanel := FieldByName('m_swColorPanel').AsInteger;
      M_SWSTYLE      := FieldByName('M_SWSTYLE').AsInteger;
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

function CDBase.SetStyle(style:integer):Boolean;
Var
    strSQL : String;
    m_swCtrlID:integer;
    mcl : SCOLORSETTTAG;
BEgin
    mcl.m_swCtrlID := CL_TREE_CONF;
    mcl.M_SWSTYLE := style;
    with mcl do
    Begin
    strSQL := 'UPDATE SCOLORSETTTAGS SET '+
              ' M_SWSTYLE='+IntToStr(M_SWSTYLE)+
              ' WHERE m_swCtrlID='+IntToStr(m_swCtrlID);
    End;
    Result := ExecQry(strSQL);
End;

function CDBase.SaveStyle(style:integer):Boolean;
Var
    strSQL   : String;
    m_swCtrlID:integer;
    mcl : SCOLORSETTTAG;
Begin
     mcl.m_swCtrlID :=CL_TREE_CONF;
     mcl.M_SWSTYLE := style;
    if IsColor(mcl.m_swCtrlID)=True then Begin SetStyle(style);Result:=False;exit;End;
    with mcl do
    Begin
    strSQL := 'INSERT INTO SCOLORSETTTAGS'+
              '(m_swCtrlID,M_SWSTYLE)'+
              ' VALUES('+
              IntToStr(m_swCtrlID)+ ','+
              IntToStr(M_SWSTYLE)+ ')';

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

//Замена счетчика
{
SL3CHANDGE = packed record
     m_swID      : Integer;
     m_swVMID    : Integer;
     m_swCHID    : Integer;
     m_dtTime    : TDateTime;
     m_sComment  : String[100];
     m_sddFabNum_0   : String[26];
     m_sddPHAddres_0 : string[26];
     m_sfKU_0    : Double;
     m_sfKI_0    : Double;
     m_sddFabNum_1   : String[26];
     m_sddPHAddres_1 : string[26];
     m_sfKU_1    : Double;
     m_sfKI_1    : Double;
     m_sbyEnable : Byte;
     Item        : SL3CHANDTS;
    End;
}
function CDBase.GetChandgeTable(nIndex:Integer;blType:Boolean;var pTable:SL3CHANDGES):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if blType=False then strSQL := 'SELECT * FROM SL3CHANDGE WHERE m_swVMID='+IntToStr(nIndex)+' ORDER BY m_swCHID';
    if blType=True  then strSQL := 'SELECT * FROM SL3CHANDGE WHERE m_swVMID='+IntToStr(nIndex)+' AND m_sbyEnable=1 ORDER BY m_swCHID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID          := FieldByName('m_swID').AsInteger;
      m_swVMID        := FieldByName('m_swVMID').AsInteger;
      m_swCHID        := FieldByName('m_swCHID').AsInteger;
      m_dtTime        := FieldByName('m_dtTime').AsDateTime;
      m_sComment      := FieldByName('m_sComment').AsString;
      m_sddFabNum_0   := FieldByName('m_sddFabNum_0').AsString;
      m_sddPHAddres_0 := FieldByName('m_sddPHAddres_0').AsString;
      m_sfKU_0        := FieldByName('m_sfKU_0').AsFloat;
      m_sfKI_0        := FieldByName('m_sfKI_0').AsFloat;
      m_sddFabNum_1   := FieldByName('m_sddFabNum_1').AsString;
      m_sddPHAddres_1 := FieldByName('m_sddPHAddres_1').AsString;
      m_sfKU_1        := FieldByName('m_sfKU_1').AsFloat;
      m_sfKI_1        := FieldByName('m_sfKI_1').AsFloat;
      m_sbyEnable     := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.AddChandgeTable(nIndex:Integer;var pTable:SL3CHANDGE):Boolean;
Var
    strSQL   : String;
Begin
    if IsChandgeTable(pTable)=True then Begin SetChandgeTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3CHANDGE'+
              '(m_swVMID,m_swCHID,m_dtTime,m_sComment,m_sddFabNum_0,m_sddPHAddres_0,'+
              ' m_sfKU_0,m_sfKI_0,m_sddFabNum_1,m_sddPHAddres_1,m_sfKU_1,m_sfKI_1,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCHID)+ ','+
              ''''+DateTimeToStr(m_dtTime)+''''+ ','+
              ''''+m_sComment+''''+ ','+
              ''''+m_sddFabNum_0+''''+ ','+
              ''''+m_sddPHAddres_0+''''+ ','+
              FloatToStr(m_sfKU_0)+ ','+
              FloatToStr(m_sfKI_0)+ ','+
              ''''+m_sddFabNum_1+''''+ ','+
              ''''+m_sddPHAddres_1+''''+ ','+
              FloatToStr(m_sfKU_1)+ ','+
              FloatToStr(m_sfKI_1)+ ','+
              IntToStr(m_sbyEnable)+  ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.IsChandgeTable(var pTable:SL3CHANDGE):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := ' SELECT 0 FROM SL3CHANDGE WHERE m_swVMID='+IntToStr(pTable.m_swVMID)+
              ' AND m_swCHID='+IntToStr(pTable.m_swCHID)+
              ' AND CAST(m_dtTime AS DATE)='+''''+DateToStr(pTable.m_dtTime)+'''';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetChandgeTable(var pTable:SL3CHANDGE):Boolean;
Var
    strSQL : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3CHANDGE SET '+
              ' m_swVMID='+IntToStr(m_swVMID)+
              ',m_swCHID='+IntToStr(m_swCHID)+
              ',m_dtTime='+''''+DateTimeToStr(m_dtTime)+''''+
              ',m_sComment='+''''+m_sComment+''''+
              ',m_sddFabNum_0='+''''+m_sddFabNum_0+''''+
              ',m_sddPHAddres_0='+''''+m_sddPHAddres_0+''''+
              ',m_sfKU_0='+FloatToStr(m_sfKU_0)+
              ',m_sfKI_0='+FloatToStr(m_sfKI_0)+
              ',m_sddFabNum_1='+''''+m_sddFabNum_1+''''+
              ',m_sddPHAddres_1='+''''+m_sddPHAddres_1+''''+
              ',m_sfKU_1='+FloatToStr(m_sfKU_1)+
              ',m_sfKI_1='+FloatToStr(m_sfKI_1)+
              ',m_sbyEnable='+IntToStr(m_sbyEnable)+
              ' WHERE m_swVMID='+IntToStr(pTable.m_swVMID)+
              ' AND m_swCHID='+IntToStr(pTable.m_swCHID)+
              ' AND CAST(m_dtTime AS DATE)='+''''+DateToStr(pTable.m_dtTime)+'''';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelChandgeTable(nVMID,nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM SL3CHANDGE WHERE m_swVMID='+IntToStr(nVMID)+' AND m_swCHID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM SL3CHANDGE WHERE m_swVMID='+IntToStr(nVMID);
    Result := ExecQry(strSQL);
End;
{
 SL3CHANDT = packed record
     m_swID      : Integer;
     m_swCHID    : Integer;
     m_swCNBID   : Integer;
     m_swCMDID   : Word;
     m_swTID     : Word;
     m_sTime     : TDateTime;
     m_sfWP0     : Double;
     m_sfWM0     : Double;
     m_sfQP0     : Double;
     m_sfQM0     : Double;
     m_sfWP1     : Double;
     m_sfWM1     : Double;
     m_sfQP1     : Double;
     m_sfQM1     : Double;
     m_sfDWP     : Double;
     m_sfDWM     : Double;
     m_sfDQP     : Double;
     m_sfDQM     : Double;
    End;
}
function CDBase.GetChandgeDTTable(nIndex:Integer;var pTable:SL3CHANDTS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3CHANDT WHERE m_swCHID='+IntToStr(nIndex)+' ORDER BY m_swCMDID,m_swTID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID    := FieldByName('m_swID').AsInteger;
      m_swCHID  := FieldByName('m_swCHID').AsInteger;
      m_swCMDID := FieldByName('m_swCMDID').AsInteger;
      m_swTID   := FieldByName('m_swTID').AsInteger;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      m_sfWP0   := FieldByName('m_sfWP0').AsFloat;
      m_sfWM0   := FieldByName('m_sfWM0').AsFloat;
      m_sfQP0   := FieldByName('m_sfQP0').AsFloat;
      m_sfQM0   := FieldByName('m_sfQM0').AsFloat;
      m_sfWP1   := FieldByName('m_sfWP1').AsFloat;
      m_sfWM1   := FieldByName('m_sfWM1').AsFloat;
      m_sfQP1   := FieldByName('m_sfQP1').AsFloat;
      m_sfQM1   := FieldByName('m_sfQM1').AsFloat;
      m_sfDWP   := FieldByName('m_sfDWP').AsFloat;
      m_sfDWM   := FieldByName('m_sfDWM').AsFloat;
      m_sfDQP   := FieldByName('m_sfDQP').AsFloat;
      m_sfDQM   := FieldByName('m_sfDQM').AsFloat;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.AddChnDTTable(nIndex:Integer;var pTable:SL3CHANDT):Boolean;
Var
    strSQL : String;
Begin
    if IsChandgeDTTable(pTable)=True then Begin SetChandgeDTTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SL3CHANDT'+
              '(m_swCHID,m_swCMDID,m_swTID,m_sTime,'+
              'm_sfWP0,m_sfWM0,m_sfQP0,m_sfQM0,'+
              'm_sfWP1,m_sfWM1,m_sfQP1,m_sfQM1,'+
              'm_sfDWP,m_sfDWM,m_sfDQP,m_sfDQM)'+
              ' VALUES('+
              IntToStr(m_swCHID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              IntToStr(m_swTID)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              FloatToStr(m_sfWP0)+ ','+
              FloatToStr(m_sfWM0)+ ','+
              FloatToStr(m_sfQP0)+ ','+
              FloatToStr(m_sfQM0)+ ','+
              FloatToStr(m_sfWP1)+ ','+
              FloatToStr(m_sfWM1)+ ','+
              FloatToStr(m_sfQP1)+ ','+
              FloatToStr(m_sfQM1)+ ','+
              FloatToStr(m_sfDWP)+ ','+
              FloatToStr(m_sfDWM)+ ','+
              FloatToStr(m_sfDQP)+ ','+
              FloatToStr(m_sfDQM)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.IsChandgeDTTable(var pTable:SL3CHANDT):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := ' SELECT 0 FROM SL3CHANDT WHERE m_swID='+IntToStr(pTable.m_swID);
              {
              ' WHERE m_swCHID='+IntToStr(pTable.m_swCHID)+
              ' AND m_swCMDID='+IntToStr(pTable.m_swCMDID)+
              ' AND m_swTID='+IntToStr(pTable.m_swTID)+
              ' AND CAST(m_sTime AS DATE)='+''''+DateToStr(pTable.m_sTime)+'''';
              }
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetChandgeDTTable(var pTable:SL3CHANDT):Boolean;
Var
    strSQL : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SL3CHANDT SET '+
              ' m_swCHID=' +IntToStr(pTable.m_swCHID)+
              ',m_swCMDID='+IntToStr(pTable.m_swCMDID)+
              ',m_swTID='  +IntToStr(pTable.m_swTID)+
              ',m_sTime='  +''''+DateTimeToStr(pTable.m_sTime)+''''+
              ',m_sfWP0='+FloatToStr(m_sfWP0)+
              ',m_sfWM0='+FloatToStr(m_sfWM0)+
              ',m_sfQP0='+FloatToStr(m_sfQP0)+
              ',m_sfQM0='+FloatToStr(m_sfQM0)+
              ',m_sfWP1='+FloatToStr(m_sfWP1)+
              ',m_sfWM1='+FloatToStr(m_sfWM1)+
              ',m_sfQP1='+FloatToStr(m_sfQP1)+
              ',m_sfQM1='+FloatToStr(m_sfQM1)+
              ',m_sfDWP='+FloatToStr(m_sfDWP)+
              ',m_sfDWM='+FloatToStr(m_sfDWM)+
              ',m_sfDQP='+FloatToStr(m_sfDQP)+
              ',m_sfDQM='+FloatToStr(m_sfDQM)+
              ' WHERE m_swID='+IntToStr(pTable.m_swID);
              {
              ' WHERE m_swCHID='+IntToStr(pTable.m_swCHID)+
              ' AND m_swCMDID='+IntToStr(pTable.m_swCMDID)+
              ' AND m_swTID='+IntToStr(pTable.m_swTID)+
              ' AND CAST(m_sTime AS DATE)='+''''+DateToStr(pTable.m_sTime)+'''';
              }
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelChandgeDTTable(nIndex,nType:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nType<>-1 then
    strSQL := 'DELETE FROM SL3CHANDT WHERE m_swCHID='+IntToStr(nIndex)+' AND m_swID='+IntToStr(nType);
    if nType=-1 then
    strSQL := 'DELETE FROM SL3CHANDT WHERE m_swCHID='+IntToStr(nIndex);
    Result := ExecQry(strSQL);
End;
function CDBase.AddChnDTLoadTable(nType:Integer;var pTable:SL3CHANDT):Boolean;
Var
    strSQL,ss,s0 : String;
Begin
    if IsChandgeDTLoadTable(pTable)=True then Begin SetChandgeDTLoadTable(nType,pTable);Result:=False;exit;End;
    with pTable do
    Begin
    if nType=0 then Begin
     ss := 'm_sfWP0,m_sfWM0,m_sfQP0,m_sfQM0';
     s0 := FloatToStr(m_sfWP0)+','+FloatToStr(m_sfWM0)+ ','+FloatToStr(m_sfQP0)+','+FloatToStr(m_sfQM0);
    End else
    if nType=1 then Begin
     ss := 'm_sfWP1,m_sfWM1,m_sfQP1,m_sfQM1';
     s0 := FloatToStr(m_sfWP1)+','+FloatToStr(m_sfWM1)+','+FloatToStr(m_sfQP1)+','+FloatToStr(m_sfQM1);
    End;
    strSQL := 'INSERT INTO SL3CHANDT'+
              '(m_swCHID,m_swCMDID,m_swTID,m_sTime,'+ss+')'+
              ' VALUES('+
              IntToStr(m_swCHID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              IntToStr(m_swTID)+ ','+
              ''''+DateToStr(m_sTime)+''''+ ','+s0+')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.IsChandgeDTLoadTable(var pTable:SL3CHANDT):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := ' SELECT 0 FROM SL3CHANDT'+
              ' WHERE m_swCHID='+IntToStr(pTable.m_swCHID)+
              ' AND m_swCMDID='+IntToStr(pTable.m_swCMDID)+
              ' AND m_swTID='+IntToStr(pTable.m_swTID)+
              ' AND CAST(m_sTime AS DATE)='+''''+DateToStr(pTable.m_sTime)+'''';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetChandgeDTLoadTable(nType:Integer;var pTable:SL3CHANDT):Boolean;
Var
    strSQL,ss : String;
BEgin
    with pTable do
    Begin
    if nType=0 then ss := ',m_sfWP0='+FloatToStr(m_sfWP0)+',m_sfWM0='+FloatToStr(m_sfWM0)+',m_sfQP0='+FloatToStr(m_sfQP0)+',m_sfQM0='+FloatToStr(m_sfQM0) else
    if nType=1 then ss := ',m_sfWP1='+FloatToStr(m_sfWP1)+',m_sfWM1='+FloatToStr(m_sfWM1)+',m_sfQP1='+FloatToStr(m_sfQP1)+',m_sfQM1='+FloatToStr(m_sfQM1);
    strSQL := 'UPDATE SL3CHANDT SET '+
              ' m_swCHID=' +IntToStr(pTable.m_swCHID)+
              ',m_swCMDID='+IntToStr(pTable.m_swCMDID)+
              ',m_swTID='  +IntToStr(pTable.m_swTID)+
              ',m_sTime='  +''''+DateTimeToStr(pTable.m_sTime)+''''+ss+
              ' WHERE m_swCHID='+IntToStr(pTable.m_swCHID)+
              ' AND m_swCMDID='+IntToStr(pTable.m_swCMDID)+
              ' AND m_swTID='+IntToStr(pTable.m_swTID)+
              ' AND CAST(m_sTime AS DATE)='+''''+DateToStr(pTable.m_sTime)+'''';
    End;
    Result := ExecQry(strSQL);
End;

function CDBase.GetChngData(nIndex,nCmdID,nTid:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT DISTINCT m_sTime,m_swCMDID,m_swTID,m_sfValue,m_sfKI,m_sfKU'+
              ' FROM L3CURRENTDATA,SL3VMETERTAG,L2TAG'+
              ' WHERE L3CURRENTDATA.m_swVMID='+IntToStr(nIndex)+
              ' AND L3CURRENTDATA.m_swVMID=SL3VMETERTAG.m_swVMID'+
              ' AND L2TAG.m_swMID=SL3VMETERTAG.m_swMID'+
              ' AND m_swTID='+IntToStr(nTid)+
              ' AND (M_SWCMDID>='+IntToStr(nCmdID)+' AND M_SWCMDID<='+IntToStr(nCmdID+3)+')'+
              ' ORDER BY M_SWCMDID';
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
      m_sfKI    := FieldByName('m_sfKI').AsFloat;
      m_sfKU    := FieldByName('m_sfKU').AsFloat;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      m_swTID   := FieldByName('m_swTID').AsInteger;
      m_swCMDID := FieldByName('m_swCMDID').AsInteger;
      m_sfValue := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;

function CDBase.GetChngDataArch(nIndex,nCmdID,nTid:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT DISTINCT m_sTime,m_swCMDID,m_swTID,m_sfValue,m_sfKI,m_sfKU'+
              ' FROM L3ARCHDATA,SL3VMETERTAG,L2TAG'+
              ' WHERE L3ARCHDATA.m_swVMID='+IntToStr(nIndex)+
              ' AND L3ARCHDATA.m_swVMID=SL3VMETERTAG.m_swVMID'+
              ' AND L3ARCHDATA.M_STIME=(select max(s0.m_stime) FROM L3ARCHDATA as s0 where s0.m_swVMID='+IntToStr(nIndex)+')'+
              ' AND L2TAG.m_swMID=SL3VMETERTAG.m_swMID'+
              ' AND m_swTID='+IntToStr(nTid)+
              ' AND (M_SWCMDID>='+IntToStr(nCmdID)+' AND M_SWCMDID<='+IntToStr(nCmdID+3)+')'+
              ' ORDER BY M_SWCMDID';
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
      m_sfKI    := FieldByName('m_sfKI').AsFloat;
      m_sfKU    := FieldByName('m_sfKU').AsFloat;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      m_swTID   := FieldByName('m_swTID').AsInteger;
      m_swCMDID := FieldByName('m_swCMDID').AsInteger;
      m_sfValue := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;

function CDBase.GetPrecision(nVMID:Integer;var m_sbyPrecision:Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT DISTINCT m_sbyPrecision FROM SL3VMETERTAG,L2TAG WHERE SL3VMETERTAG.m_swVMID='+IntToStr(nVMID)+
              ' AND L2TAG.m_swMID=SL3VMETERTAG.m_swMID';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     m_sbyPrecision := FADOQuery.FieldByName('m_sbyPrecision').AsInteger;
     res:= True;
    End;
    CloseQry;
    Result := res;
End;
{
 m_sddFabNum_0   : String[26];
     m_sddPHAddres_0 : string[26];
}
function CDBase.GetKiKU(nVMID:Integer;var nPR:Integer;var dKI,dKU:Double;var sddFabNum,sddPHAddres:String):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT DISTINCT m_sbyPrecision,m_sfKI,m_sfKU,L2TAG.m_sddFabNum,L2TAG.m_sddPHAddres FROM SL3VMETERTAG,L2TAG WHERE SL3VMETERTAG.m_swVMID='+IntToStr(nVMID)+
              ' AND L2TAG.m_swMID=SL3VMETERTAG.m_swMID';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     sddFabNum   := FADOQuery.FieldByName('m_sddFabNum').AsString;
     sddPHAddres := FADOQuery.FieldByName('m_sddPHAddres').AsString;
     nPR         := FADOQuery.FieldByName('m_sbyPrecision').AsInteger;
     dKI         := FADOQuery.FieldByName('m_sfKI').AsFloat;
     dKU         := FADOQuery.FieldByName('m_sfKU').AsFloat;
     res:= True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.getChangeData(nIndex,nCmdID,nTid:Integer;var pTable:CCDatas):boolean;
Begin
    if((nCmdID>=1) and (nCmdID<=4)) then
     Result := GetChngData(nIndex,nCmdID,nTid,pTable)
      else
     Result := GetChngDataArch(nIndex,nCmdID,nTid,pTable);
End;
function CDBase.AddChandgeDTTable(nVMID,nCHID,nCmdID,nType:Integer):Boolean;
Var
    i,j,nPR : Integer;
    pSTbl   : CCDatas;
    pDTbl   : SL3CHANDT;
Begin
    FillChar(pDTbl,sizeof(SL3CHANDT),0);
    GetPrecision(nVMID,nPR);
    for i:=1 to MAX_TARIFF-1 do
    if getChangeData(nVMID,nCmdID,i,pSTbl)=True then
    Begin
     pDTbl.m_swCHID := nCHID;
     pDTbl.m_swCMDID:= nCmdID;
     pDTbl.m_swTID  := i;
     pDTbl.m_sTime  := pSTbl.Items[0].m_sTime;
     for j:=0 to pSTbl.Count-1 do
     Begin
      with pSTbl.Items[j] do Begin
      if nType=0 then
      Begin
       if j=0 then pDTbl.m_sfWP0 := RVLPr(m_sfValue/(m_sfKI*m_sfKU),nPR);
       if j=1 then pDTbl.m_sfWM0 := RVLPr(m_sfValue/(m_sfKI*m_sfKU),nPR);
       if j=2 then pDTbl.m_sfQP0 := RVLPr(m_sfValue/(m_sfKI*m_sfKU),nPR);
       if j=3 then pDTbl.m_sfQM0 := RVLPr(m_sfValue/(m_sfKI*m_sfKU),nPR);
      End else
      if nType=1 then
      Begin
       if j=0 then pDTbl.m_sfWP1 := RVLPr(m_sfValue/(m_sfKI*m_sfKU),nPR);
       if j=1 then pDTbl.m_sfWM1 := RVLPr(m_sfValue/(m_sfKI*m_sfKU),nPR);
       if j=2 then pDTbl.m_sfQP1 := RVLPr(m_sfValue/(m_sfKI*m_sfKU),nPR);
       if j=3 then pDTbl.m_sfQM1 := RVLPr(m_sfValue/(m_sfKI*m_sfKU),nPR);
      End;
      End;
     End;
     AddChnDTLoadTable(nType,pDTbl);
    End;
End;

function CDBase.LoadChandgeTable(nVMID:Integer;blType:Boolean;var pTable:SL3CHANDGES):Boolean;
Var
    i : Integer;
Begin
     if GetChandgeTable(nVMID,blType,pTable)=True then
     Begin
      for i:=0 to pTable.Count-1 do
      with pTable.Items[i] do Result := GetChandgeDTTable(m_swCHID,Item);
     End else pTable.Count:=0;
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
     m_CRC     : Integer;
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
    //TAdoDataSet
    if IsCurrentParam(pTable)=True then Begin {SetCurrentParam(pTable);}Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO L3CURRENTDATA'+
              '(m_swVMID,m_swCMDID,m_swTID,m_crc,m_sTime,m_sfValue,m_byOutState,m_byInState)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              IntToStr(m_swTID)+ ','+
              IntToStr(m_CRC)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              FloatToStr(m_sfValue)+','+
              IntToStr(m_byOutState)+ ','+
              IntToStr(m_byInState)+  ')';
    End;
    Result := ExecQryD(strSQL);
End;
function CDBase.CurrentPrepare:Boolean;
Begin
    strBSQL := 'execute block as begin';
    m_nBLOs := m_nBLOs + 1;
    m_nQRYs := 0;
end;
function CDBase.CurrentExecute:Boolean;
Var
    nLen : Integer;
Begin
    if strBSQL<>'' then
    if Pos('end;',strBSQL)=0 then strBSQL := strBSQL + 'end;';
    //if strBSQL<>'execute block as beginend;' then
    Begin
     nLen := Length(strBSQL);
     if nLen<>0 then
     Begin
      if m_nPauseCM=False then
      ExecQryD(strBSQL);
      //if m_nPauseCM=True then WaitForSingleObject(w_mGEvent0,1000);
     End;
     strBSQL := '';
    End;
    m_nQRYs := 0;
End;
function CDBase.CurrentFlush(swVMID:Integer):Boolean;
Var
    strSQL : String;
Begin
    if m_nBLOs<>0 then
    Begin
     m_nBLOs := 0;
     strSQL :=' MERGE INTO L3ARCHDATA AS d'+
              ' USING (SELECT L3CURRENTDATA.m_swVMID,m_swCMDID,m_swTID, m_sTime, m_sfValue,m_CRC,m_sbyMaskRead,m_sbyMaskReRead FROM L3CURRENTDATA'+
              ' WHERE m_swVMID='+IntToStr(swVMID)+
              ' AND m_byInState=4'+
              ' AND ((m_swCMDID>=5 and m_swCMDID<=12) or (m_swCMDID>=17 and m_swCMDID<=24)'+
              ' or (m_swCMDID>=' + IntToStr(QRY_RASH_HOR_V) + ' and m_swCMDID<=' + IntToStr(QRY_RASH_MON_V) + ')' +
              ' or (m_swCMDID>=' + IntToStr(QRY_ENERGY_SUM_R1) + ' and m_swCMDID<=' + IntToStr(QRY_ENERGY_MON_R4) + ')' +
              ' or (m_swCMDID>=' + IntToStr(QRY_NAK_EN_DAY_R1) + ' and m_swCMDID<=' + IntToStr(QRY_NAK_EN_MONTH_R4) + ')' +
              ' or (m_swCMDID>=' + IntToStr(QRY_NACKM_POD_TRYB_HEAT) + ' and m_swCMDID<=' + IntToStr(QRY_NACKM_WORK_TIME_ERR) + ')' +
              ' or (m_swCMDID>=60 and m_swCMDID<=63) or (m_swCMDID>='+IntToStr(QRY_POD_TRYB_HEAT)+' and m_swCMDID<='+IntToStr(QRY_WORK_TIME_ERR)+'))) AS o'+
              ' ON (d.m_swVMID=o.m_swVMID AND d.m_swCMDID=o.m_swCMDID AND d.m_swTID=o.m_swTID'+
              ' AND CAST(d.m_sTime as Date)=CAST(o.m_sTime as Date))'+
              ' WHEN MATCHED THEN'+
              ' UPDATE SET d.m_sfValue=o.m_sfValue,d.m_CRC=o.m_CRC,d.m_sbyMaskRead=o.m_sbyMaskRead,d.m_sbyMaskReRead=o.m_sbyMaskReRead'+
              ' WHEN NOT MATCHED THEN'+
              ' INSERT (d.m_swVMID,d.m_swCMDID,d.m_crc,d.m_sTime,d.m_sfValue,d.m_swTID, d.m_sbyMaskRead, d.m_sbyMaskReRead)'+
              ' VALUES (o.m_swVMID,o.m_swCMDID,o.m_crc,CAST(o.m_sTime AS DATE),o.m_sfValue,o.m_swTID, o.m_sbyMaskRead, o.m_sbyMaskReRead)';
      Result := ExecQryD(strSQL);
      strSQL := 'UPDATE L3CURRENTDATA set m_byInState=2 WHERE m_swVMID='+IntToStr(swVMID);
      if m_nPauseCM=False then
      Result := ExecQryD(strSQL);
     End;
end;
function CDBase.SetCurrentParam(var pTable:L3CURRENTDATA):Boolean;
Begin
    if m_nQRYs=0 then CurrentPrepare;
    with pTable do
Begin
    strBSQL := strBSQL + ' UPDATE L3CURRENTDATA SET '+
              ' m_sTime='+''''+DateTimeToStr(m_sTime)+''''+
              ',m_sfValue='+FloatToStr(m_sfValue)+
              ',m_byOutState='+IntToStr(m_byOutState)+
              ',m_CRC='+IntToStr(m_CRC)+                             
              ',m_byInState='+IntToStr(m_byInState)+
              ',M_SBYMASKREREAD='+IntToStr(m_sbyMaskReRead)+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+
              ' and m_swVMID='+IntToStr(m_swVMID)+
              ' and m_swTID='+IntToStr(m_swTID)+';';
    End;
    if m_nQRYs=MAX_BLOCK_QRY then CurrentExecute else
    m_nQRYs := m_nQRYs + 1;
    Result := True;
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
              ',m_CRC='+IntToStr(m_CRC)+
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
function CDBase.UpdateLockStParam(nVMID,nCMDID,nLockState:Integer):Boolean;
Var
    strSQL   : String;
Begin
    Begin
    strSQL := 'UPDATE SL3PARAMS SET '+
              ' m_sbyLockState='+IntToStr(nLockState)+
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
{
 QRY_MGAKT_POW_S       = 37;//8
  QRY_MGAKT_POW_A       = 38;
  QRY_MGAKT_POW_B       = 39;
  QRY_MGAKT_POW_C       = 40;
  QRY_MGREA_POW_S       = 41;//9
  QRY_MGREA_POW_A       = 42;
  QRY_MGREA_POW_B       = 43;
  QRY_MGREA_POW_C       = 44;
  QRY_U_PARAM_S         = 45;
  QRY_U_PARAM_A         = 46;//10
  QRY_U_PARAM_B         = 47;
  QRY_U_PARAM_C         = 48;
  QRY_I_PARAM_S         = 49;
  QRY_I_PARAM_A         = 50;//11
  QRY_I_PARAM_B         = 51;
  QRY_I_PARAM_C         = 52;
  QRY_FREQ_NET          = 53;//13
}
function CDBase.GetMetaData(nIndex,nDataType:Integer;var pTable:CGMetaDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
    pMD      : CGMetaData;
Begin
    //SL3PARAMS.m_swVMID=L3CURRENTDATA.m_swVMID                      // JKLJKL
    if nDataType<>-1 then
    strSQL := 'SELECT m_swType,QM_PARAMS.m_sblTarif,SL3PARAMS.m_swStatus,QM_PARAMS.m_sName,SL3PARAMS.m_fMin,SL3PARAMS.m_fMax,SL3PARAMS.m_fLimit,QM_PARAMS.m_sEMet,SL3PARAMS.m_sbyDataGroup'+
    ' FROM SL3PARAMS,QM_PARAMS'+
    ' WHERE m_sblCalculate=1'+
    ' and SL3PARAMS.m_swVMID='+IntToStr(nIndex)+
    ' and m_swParamID=m_swType'+
    ' and (m_swType=1 or (m_swType>=37 and m_swType<=53))'+
    ' and SL3PARAMS.m_sbyDataGroup='+IntToStr(nDataType)+
    ' ORDER BY m_swParamID' else
    strSQL := 'SELECT m_swType,QM_PARAMS.m_sblTarif,SL3PARAMS.m_swStatus,QM_PARAMS.m_sName,SL3PARAMS.m_fMin,SL3PARAMS.m_fMax,SL3PARAMS.m_fLimit,QM_PARAMS.m_sEMet,SL3PARAMS.m_sbyDataGroup'+
    ' FROM SL3PARAMS,QM_PARAMS'+
    ' WHERE m_sblCalculate=1'+
    ' and SL3PARAMS.m_swVMID='+IntToStr(nIndex)+
    ' and m_swParamID=m_swType'+
    ' and (m_swType=1 or (m_swType>=37 and m_swType<=53))'+
    ' ORDER BY m_swParamID';
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
    ' FROM L3CURRENTDATA,L2TAG,SL3VMETERTAG WHERE L3CURRENTDATA.m_swVMID='+IntToStr(FIndex)+
    ' and L3CURRENTDATA.m_swCMDID='+IntToStr(FCmdIndex)+' and m_swTID<>0 and ' +
    '  SL3VMETERTAG.m_swVMID=L3CURRENTDATA.m_swVMID and SL3VMETERTAG.M_SWMID=L2TAG.M_SWMID ORDER BY m_swTID';
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
      m_CRC     := FieldByName('m_CRC').AsInteger;
      m_sfValue := FieldByName('m_sfValue').AsFloat;
      m_sfKI    := FieldByName('m_sfKi').AsFloat;
      m_sfKU    := FieldByName('m_sfKU').AsFloat;
      m_sbyPrecision    := FieldByName('m_sbyPrecision').AsInteger;
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
      m_CRC     := FieldByName('m_CRC').AsInteger;
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
    strSQL := 'SELECT m_swParamID,m_sTime,m_byOutState,m_byInState,m_sfValue,m_CRC,m_sfKI,m_sfKU,m_swCMDID,m_sbyPrecision FROM SL3PARAMS,L3CURRENTDATA,L2TAG,SL3VMETERTAG'+
    ' WHERE SL3PARAMS.m_swVMID=L3CURRENTDATA.m_swVMID and M_SWCMDID=m_swParamID and m_sbyDataGroup='+IntToStr(nDataType)+
    ' and (m_swParamID=1 or (m_swParamID>=37 and m_swParamID<=53))'+
    ' and SL3PARAMS.m_swVMID='+IntToStr(nIndex)+' and L3CURRENTDATA.m_swTID=1 and m_sblCalculate=1 and ' +
    ' L3CURRENTDATA.m_swVMID=SL3VMETERTAG.m_swVMID and SL3VMETERTAG.M_SWMID=L2TAG.M_SWMID ORDER BY m_swParamID' else
  {  strSQL := 'SELECT m_swParamID,m_sTime,m_byOutState,m_byInState,m_sfValue,m_CRC,m_sfKI,m_sfKU,m_swCMDID,m_sbyPrecision FROM SL3PARAMS,L3CURRENTDATA,L2TAG,SL3VMETERTAG'+
    ' WHERE SL3PARAMS.m_swVMID=L3CURRENTDATA.m_swVMID and M_SWCMDID=m_swParamID and m_sblCalculate=1'+
    ' and (m_swParamID=1 or (m_swParamID>=37 and m_swParamID<=53))'+
    ' and SL3PARAMS.m_swVMID='+IntToStr(nIndex)+' and L3CURRENTDATA.m_swTID=0 and ' + //БЫЛО L3CURRENTDATA.m_swTID=1
    ' L3CURRENTDATA.m_swVMID=SL3VMETERTAG.m_swVMID and SL3VMETERTAG.M_SWMID=L2TAG.M_SWMID ORDER BY m_swParamID';
    }

    strSQL := 'SELECT m_swParamID,m_sTime,m_byOutState,m_byInState,m_swTID,m_sfValue,m_CRC,m_sfKI,m_sfKU,m_swCMDID,m_sbyPrecision FROM SL3PARAMS,L3CURRENTDATA,L2TAG,SL3VMETERTAG'+
    ' WHERE SL3PARAMS.m_swVMID=L3CURRENTDATA.m_swVMID and M_SWCMDID=m_swParamID and m_sblCalculate=1'+
    ' and (m_swParamID=1 or (m_swParamID>=37 and m_swParamID<=53))'+
    ' and SL3PARAMS.m_swVMID='+IntToStr(nIndex)+' and L3CURRENTDATA.m_swTID>=0 and L3CURRENTDATA.m_swTID<=4 and ' + //БЫЛО L3CURRENTDATA.m_swTID=1
    ' L3CURRENTDATA.m_swVMID=SL3VMETERTAG.m_swVMID and SL3VMETERTAG.M_SWMID=L2TAG.M_SWMID ORDER BY m_swParamID';


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
      m_sfKI       := FieldByName('m_sfKi').AsFloat;
      m_sfKU       := FieldByName('m_sfKU').AsFloat;
      m_swCMDID    := FieldByName('m_swCMDID').AsInteger;
      m_swTID      := FieldByName('m_swTID').AsInteger;  // можно убрать
      m_sfValue    := FieldByName('m_sfValue').AsFloat;
      m_CRC        := FieldByName('m_CRC').AsInteger;
      m_sbyPrecision := FieldByName('m_sbyPrecision').AsInteger;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;
function CDBase.GetGData(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatasWithTarif):Boolean;
Var
    strSQL   : AnsiString;
   // str0, str1
    res      : Boolean;
    nCount,i,j : Integer;
    m_sTime    : TDateTime;
Begin
{     if TID = 0 then
      strSQL := 'SELECT m_sTime, 1 as m_sbyMaskReRead,1 as m_sbyMaskRead, sum(m_crc)as m_crc,sum(m_sfValue) as m_sfValue '+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swTID<>0 and m_swTID<>4 and m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' GROUP BY m_sTime ORDER BY m_sTime '
     else
     if TID = 6 then
      strSQL := 'SELECT m_sTime, 1 as m_sbyMaskReRead,1 as m_sbyMaskRead, sum(m_crc)as m_crc,sum(m_sfValue) as m_sfValue '+
                 ' FROM L3ARCHDATA'+
                 ' WHERE (m_swTID=1 or m_swTID=2) and m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' GROUP BY m_sTime ORDER BY m_sTime '
     else
     if TID = 1 then
      strSQL := 'SELECT m_sTime, 1 as m_sbyMaskReRead,1 as m_sbyMaskRead, sum(m_crc)as m_crc,sum(m_sfValue) as m_sfValue '+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swTID=0 and m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' GROUP BY m_sTime ORDER BY m_sTime '
     else
       strSQL := 'SELECT m_sTime, m_sfValue,m_CRC,m_swTID,1 as m_sbyMaskReRead,1 as m_sbyMaskRead '+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 'm_swTID='+IntToStr(TID - 1)+ ' and ' +
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime';
}        // BO 18/10/2018

// BO 18/10/2018 Новый вид запроса и обработчик, для разделения

    strSQL := ' SELECT m_sTime,1 as m_sbyMaskReRead,1 as m_sbyMaskRead, ' +
              '        m_swvmid, m_swtid, m_crc, m_sfValue ' +
              ' FROM L3ARCHDATA ' +
              ' WHERE m_swVMID=' + IntToStr(FKey) + ' and m_swCMDID= ' + IntToStr(PKey) + ' and ' +
              ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+'''' +
              ' ORDER BY m_sTime' ;

 {   res := False;     // old handler
    pTable.Count := 0;
    if OpenQryD1(strSQL,nCount)=True then Begin
      i := 0; res := True;
      pTable.Count := nCount;
      SetLength(pTable.Items,nCount);
      while not FADOQueryD1.Eof do Begin
        with FADOQueryD1,pTable.Items[i] do  Begin
          m_swID       := i;
          m_swTID      := TID;
          //m_swTID      := FieldByName('m_swTID').AsInteger;
          m_sTime      := FieldByName('m_sTime').AsDateTime;
          m_sfValue    := FieldByName('m_sfValue').AsFloat;
          m_CRC        := FieldByName('m_CRC').AsInteger;
          m_sbyMaskRead   := FieldByName('m_sbyMaskRead').AsInteger;
          m_sbyMaskReRead := FieldByName('m_sbyMaskReRead').AsInteger;
          Next;
          Inc(i);
        End;
      End;
    End;  }


    res := False;              // new handler
    pTable.Count := 0;
    if OpenQryD1(strSQL,nCount)=True then Begin
      i := 0;
      j:=0;
      res := True;
      pTable.Count := 1;
      SetLength(pTable.Items,1);
      m_sTime := FADOQueryD1.FieldByName('m_sTime').AsDateTime;
                                                 
      while not FADOQueryD1.Eof do Begin
        with FADOQueryD1 do  Begin
          pTable.Items[i].m_swID       := i;
          pTable.Items[i].m_swTID      := TID;
          pTable.Items[i].m_sTime      := FieldByName('m_sTime').AsDateTime;
//          pTable.Items[i].m_sfValue    := FieldByName('m_sfValue').AsFloat;
          pTable.Items[i].m_CRC        := FieldByName('m_CRC').AsInteger;
          pTable.Items[i].m_sbyMaskRead   := FieldByName('m_sbyMaskRead').AsInteger;
          pTable.Items[i].m_sbyMaskReRead := FieldByName('m_sbyMaskReRead').AsInteger;

          if FieldByName('m_swtid').AsInteger = 0 then pTable.Items[i].m_sfValue:= FieldByName('m_sfValue').AsFloat;
          if FieldByName('m_swtid').AsInteger = 1 then pTable.Items[i].m_sfValue1:= FieldByName('m_sfValue').AsFloat;
          if FieldByName('m_swtid').AsInteger = 2 then pTable.Items[i].m_sfValue2:= FieldByName('m_sfValue').AsFloat;
          if FieldByName('m_swtid').AsInteger = 3 then pTable.Items[i].m_sfValue3:= FieldByName('m_sfValue').AsFloat;
          if FieldByName('m_swtid').AsInteger = 4 then pTable.Items[i].m_sfValue4:= FieldByName('m_sfValue').AsFloat;

          Next;

          if m_sTime <> FieldByName('m_sTime').AsDateTime then begin
            m_sTime:=FieldByName('m_sTime').AsDateTime;
            Inc(i);
            inc(pTable.Count);
            SetLength(pTable.Items,i+1);
            j:=0;
          end else begin
            inc(j);
          end;

//          Inc(i);
        End;
      End;
    End;



    CloseQryD1;
    Result := res;
End;
function CDBase.GetGRData(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT m_sfValue,M_SBYMASKREREAD,M_SBYLOCKSTATE'+
              ' FROM L3ARCHDATA as b0,SL3PARAMS as b1'+
              ' WHERE b0.m_swVMID=b1.m_swVMID and b0.m_swCMDID=b1.M_SWPARAMID'+
              ' and b0.m_swVMID='+IntToStr(pTable.m_swVMID)+' and m_swCMDID='+IntToStr(pTable.m_swCMDID)+' and '+
              ' m_swTID='+IntToStr(pTable.m_swTID)+ ' and ' +
              ' CAST(m_sTime AS DATE)='+ ''''+DateToStr(pTable.m_sTime)+'''';
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     res := True;
     pTable.m_sfValue       := FADOQueryD1.FieldByName('m_sfValue').AsFloat;
     pTable.m_sbyMaskReRead := FADOQueryD1.FieldByName('M_SBYMASKREREAD').AsInteger;
     pTable.m_CRC           := FADOQueryD1.FieldByName('M_SBYLOCKSTATE').AsInteger;
    End;
    CloseQryD1;
    Result := res;
End;
function CDBase.GetCRDataT(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT m_sfValue,m_sTime,m_CRC FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and m_swCMDID='+IntToStr(pTable.m_swCMDID)+
    ' and m_swTID='+IntToStr(pTable.m_swTID);
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     pTable.m_sfValue := FADOQueryD1.FieldByName('m_sfValue').AsFloat;
     pTable.m_CRC     := FADOQueryD1.FieldByName('m_CRC').AsInteger;
     pTable.m_sTime   := FADOQueryD1.FieldByName('m_sTime').AsDateTime;
     res   := True;
    End;
    CloseQryD1;
    Result := res;
End;
function CDBase.GetCRData(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT m_sfValue,m_CRC,m_sTime FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and m_swCMDID='+IntToStr(pTable.m_swCMDID);
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     pTable.m_sfValue := FADOQueryD1.FieldByName('m_sfValue').AsFloat;
     pTable.m_sTime   := FADOQueryD1.FieldByName('m_sTime').AsDateTime;
     pTable.m_CRC     := FADOQueryD1.FieldByName('m_CRC').AsInteger;
     res   := True;
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
    strSQL := 'SELECT m_swCMDID,m_sTime,m_sfValue,m_swTID,m_CRC '+
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
      m_CRC        := FieldByName('m_CRC').AsInteger;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD1;
    Result := res;
End;
{
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
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_swCMDID      := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      m_CRC          := FieldByName('m_CRC').AsInteger;
      for j:=0 to 47 do v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;
}
function CDBase.GetGDPData(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:CCDatasWithTarif):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i,j : Integer;
    sTime    : TDateTime;
Begin
    strSQL := 'SELECT *'+
              ' FROM L3PDTDATA_48'+
              ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
              ' CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sdtDate';
    res := False;
    pTable.Count := 0;
    if OpenQryD2(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount*48;
    SetLength(pTable.Items,pTable.Count);
    while not FADOQueryD2.Eof do Begin
     with FADOQueryD2 do  Begin
      j:=0;
      sTime := trunc(FieldByName('m_sdtDate').AsDateTime);
      for j:=0 to 47 do
      Begin
       pTable.Items[i*48+j].m_sfValue := FieldByName('v'+IntToStr(j)).AsFloat;
       pTable.Items[i*48+j].m_sTime   := sTime + j*EncodeTime(0,30,0,0);
      End;
      Next;
      i:=i+1;
    End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;

function CDBase.DelPdtData(Date1, Date2 : TDateTime; var Data :L3CURRENTDATA):Boolean;
Var
    strSQL,strSel : String;
Begin
    strSel := '(select distinct m_swVMID from SL3ABON as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2'+
    ' where s0.m_swABOID=s1.m_swABOID and s1.m_sbyGroupID=s2.m_sbyGroupID and s0.m_swABOID='+IntToStr(Data.m_swTID)+')';
    if Data.m_swVMID=$fffe then
    strSQL := 'DELETE FROM L3PDTDATA_48 WHERE m_swVMID in'+strSel+
    ' and m_swCMDID=' + IntToStr(Data.m_swCMDID) else
    if Data.m_swVMID=$ffff then
    strSQL := 'DELETE FROM L3PDTDATA_48 WHERE m_swVMID in'+strSel+
    ' and m_swCMDID=' + IntToStr(Data.m_swCMDID) +
    ' and CAST(m_sdtDate as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''' else
    if Data.m_swVMID<$fffe then
    strSQL := 'DELETE FROM L3PDTDATA_48 WHERE m_swVMID='+
    IntToStr(Data.m_swVMID) + ' AND m_swCMDID=' + IntToStr(Data.m_swCMDID) +
    ' and CAST(m_sdtDate as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''';

    if Data.m_swVMID>$fffe then
    strSQL := 'DELETE FROM L3PDTDATA_48 WHERE m_swVMID='+
    IntToStr(Data.m_swVMID) + ' AND m_swCMDID=' + IntToStr(Data.m_swCMDID) +
    ' and CAST(m_sdtDate as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''';
    Result := ExecQryD1(strSQL);
//Удаляем из текущих
    if (Data.m_swVMID>$fffe) or (Data.m_swVMID<$fffe) or (Data.m_swVMID=$fffe )then
    strSQL := 'DELETE FROM L3CURRENTDATA WHERE m_swVMID='+
    IntToStr(Data.m_swVMID) + ' AND m_swCMDID=' + IntToStr(Data.m_swCMDID) +
    ' and CAST(M_STIME as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
     ' and ' + '''' + DateToStr(Date2) + '''';
    Result := ExecQryD1(strSQL);
End;
function CDBase.AddPdtData(var pTable:L3CURRENTDATA):Boolean;
//Var
//    strBSQL : String;
Begin
    if m_nQRYs=0 then CurrentPrepare;
    with pTable do
    Begin
    strBSQL :=strBSQL+ ' INSERT INTO L3PDTDATA'+
              '(m_swVMID,m_swCMDID,m_sTime,m_sfValue,m_swTID)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              FloatToStr(m_sfValue)+ ',' + IntToStr(pTable.m_swTID) +');';
    End;
    if m_nQRYs=MAX_BLOCK_QRY then CurrentExecute else
    m_nQRYs := m_nQRYs + 1;
    Result := True;
    //Result := ExecQryD1(strSQL);
End;
function CDBase.IsPdtParam(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM L3PDTDATA WHERE m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and m_sTime='+''''+DateTimeToStr(pTable.m_sTime)+''''+
    ' and m_swCMDID='+IntToStr(pTable.m_swCMDID)+
    ' and m_swTID='+IntToStr(pTable.m_swTID);
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQryD1;
    Result := res;
End;
function CDBase.UpdatePdtData(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
begin
    with pTable do
    Begin
    strSQL :=' UPDATE L3PDTDATA SET '+
              'm_sfValue=' + FloatToStr(m_sfValue) +
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+
              ' and m_swVMID='+IntToStr(m_swVMID) +
              ' and m_swTID=' + IntToStr(pTable.m_swTID) +
              ' AND m_sTime='+''''+DateTimeToStr(m_sTime)+'''';
    End;
    Result := ExecQryD1(strSQL);
end;
function CDBase.AddPdtDataEx(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
Begin
    if IsPdtParam(pTable)=True then
    Begin
     UpdatePdtData(pTable);
     Result:=False;
     exit;
    End;
    with pTable do
    Begin
    strSQL :=' INSERT INTO L3PDTDATA'+
             '(m_swVMID,m_swCMDID,m_sTime,m_sfValue,m_swTID)'+
             ' VALUES('+
             IntToStr(m_swVMID)+ ','+
             IntToStr(m_swCMDID)+ ','+
             ''''+DateTimeToStr(m_sTime)+''''+ ','+
             FloatToStr(m_sfValue)+ ',' +
             IntToStr(pTable.m_swTID) +')';
    End;
    Result := ExecQryD1(strSQL);
End;


function CDBase.AddPDTData_48(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL,strV,strD : AnsiString;
    i,nLen : Integer;
    sMaskRead : int64;
Begin
    sMaskRead := pTable.m_sMaskRead;
    if IsPDTData_48(pTable)=True then
    Begin
      pTable.m_sMaskRead := sMaskRead;
      UpdatePDTData_48(pTable);
      Result:=False;
      exit;
    End;
    pTable.m_sMaskRead := sMaskRead;
    for i:=0 to 47 do
    begin
     strD := strD + ','+FloatToStr(pTable.v[i]);
    end;
    for i:=0 to 47 do strV := strV + ',v'+IntToStr(i);
    with pTable do
    Begin
    strSQL := 'INSERT INTO L3PDTDATA_48'+
              '(m_swVMID,m_swCMDID,m_sdtDate,m_sMaskRead'+strV+')'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_sdtDate)+''''+','+
              ''''+IntToStr(m_sMaskRead)+''''+strD+')';
    End;
    //TraceL(4,0,'(__)CLDBD::>CVPRM INS LEN : '+IntToStr(Length(strSQL)));
    Result := ExecQryD1(strSQL);
End;



function CDBase.UpdatePDTFilds_48(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL,strD,strV : AnsiString;
    i,nLen : Integer;
    pTab   : L3GRAPHDATA;
    //ptabcrc:L3GRAPHDATAS;
Begin
    pTab.m_swVMID      := pTable.m_swVMID;
    pTab.m_swCMDID     := pTable.m_swCMDID;
    pTab.m_sdtDate     := pTable.m_sTime;
    pTab.m_sMaskRead   := 0;
    if pTable.m_swSID>47 then exit;
    if IsPDTData_48(pTab)=False then
    Begin
     for i:=0 to 47 do
     begin
     strD := strD +',' + FloatToStr(0);
     strV := strV + ',v'+IntToStr(i);
     end;
     with pTab do
     Begin
      strSQL := 'INSERT INTO L3PDTDATA_48'+
                '(m_swVMID,m_swCMDID,m_sMaskRead,m_sdtDate'+strV+')'+
                ' VALUES('+
                IntToStr(m_swVMID)+ ','+
                IntToStr(m_swCMDID)+ ','+
                ''''+IntToStr(m_sMaskRead)+''''+ ',' +
                ''''+DateTimeToStr(m_sdtDate)+''''+strD+')';
     End;
     ExecQryD1(strSQL);
    End;
    strV := ' ,v'+IntToStr(pTable.m_swSID)+'='+FloatToStr(pTable.m_sfValue);
    SetByteMask(pTab.m_sMaskRead, pTable.m_swSID);
    with pTable do
    Begin
    strSQL := 'UPDATE L3PDTDATA_48 SET '+
              ' m_sMaskRead = '+''''+IntToStr(pTab.m_sMaskRead)+''''+
              ',m_sdtDate='   +''''+DateTimeToStr(m_sTime)+''''+
              strV+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+' and m_swVMID='+IntToStr(m_swVMID) +
              ' AND CAST(m_sdtDate as Date) = ' + '''' + DateToStr(pTable.m_sTime) + '''';
    nLen := Length(strSQL);
    End;
    Result := ExecQryD1(strSQL);
End;
function CDBase.UpdatePDTData_48(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL,strD : AnsiString;
    i,nLen : Integer;
Begin
    for i:=0 to 47 do
    Begin
     if (abs(pTable.v[i])<0.000001) then
     pTable.v[i]:=0;
     strD := strD + ',v'+IntToStr(i)+'='+FloatToStr(pTable.v[i]);
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE L3PDTDATA_48 SET '+
              ' m_sdtDate='   +''''+DateTimeToStr(m_sdtDate)+''''+
              ',m_sMaskRead='+''''+IntToStr(m_sMaskRead)+''''+
              strD+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+' and m_swVMID='+IntToStr(m_swVMID) +
              ' AND CAST(m_sdtDate as Date) = ' + '''' + DateToStr(pTable.m_sdtDate) + '''';
    nLen := Length(strSQL);
    //TraceL(4,0,'(__)CLDBD::>CVPRM UPD LEN : '+IntToStr(nLen));
    End;
    Result := ExecQryD1(strSQL);
End;
function CDBase.IsPDTData_48(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    nSr      : byte;
    str0     : String;
Begin
    strSQL := 'SELECT m_sMaskRead FROM L3PDTDATA_48 WHERE'+
    ' m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and m_swCMDID='+IntToStr(pTable.m_swCMDID)+
    ' and CAST(m_sdtDate as DATE)='+''''+DateToStr(pTable.m_sdtDate)+'''';
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     res                 := True;
     str0 := FADOQueryD1.FieldByName('m_sMaskRead').AsString;
     if str0<>'' then pTable.m_sMaskRead := StrToInt64(str0);
    End;
    CloseQryD1;
    Result := res;
End;
function CDBase.DelArchData(Date1, Date2 : TDateTime; var Data :L3CURRENTDATA):Boolean;
Var
    strSQL,strSel          : String;
    FirstCMDID,LastCMDID   : Integer;
Begin
    FirstCMDID := Data.m_swCMDID - (Data.m_swCMDID - 1) mod 4;
    LastCMDID  := FirstCMDID + 4;
    strSel := '(select distinct m_swVMID from SL3ABON as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2'+
    ' where s0.m_swABOID=s1.m_swABOID and s1.m_sbyGroupID=s2.m_sbyGroupID and s0.m_swABOID='+IntToStr(Data.m_swTID)+')';
    if Data.m_swVMID=-2 then
    strSQL := 'DELETE FROM L3ARCHDATA WHERE m_swVMID in'+strSel+
    ' and m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) else
    if Data.m_swVMID=-1 then
    strSQL := 'DELETE FROM L3ARCHDATA WHERE m_swVMID in'+strSel+
    ' and m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sTime as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''' else
    if Data.m_swVMID>=0 then
    strSQL := 'DELETE FROM L3ARCHDATA WHERE m_swVMID='+
    IntToStr(Data.m_swVMID) + ' AND m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sTime as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''';
    Result := ExecQryD1(strSQL);
End;
{
SQL> SELECT * FROM dept;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        10 ACCOUNTING     NEW YORK
        20 RESEARCH       DALLAS
        30 SALES          CHICAGO
        60 HELP DESK      PITTSBURGH
        40 OPERATIONS     BOSTON


SQL> SELECT * FROM dept_online;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        40 OPERATIONS     BOSTON
        20 RESEARCH DEV   DALLAS
        50 ENGINEERING    WEXFORD


SQL> MERGE INTO dept d
     USING dept_online o
     ON (d.deptno = o.deptno)
     WHEN MATCHED THEN
         UPDATE SET d.dname = o.dname, d.loc = o.loc
     WHEN NOT MATCHED THEN
         INSERT (d.deptno, d.dname, d.loc)
         VALUES (o.deptno, o.dname, o.loc);

3 rows merged.
}
{
function CDBase.AddPdtData(var pTable:L3CURRENTDATA):Boolean;
Begin
    if m_nQRYs=0 then CurrentPrepare;
    with pTable do
    Begin
    strBSQL :=strBSQL+ ' INSERT INTO L3PDTDATA'+
              '(m_swVMID,m_swCMDID,m_sTime,m_sfValue,m_swTID)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              FloatToStr(m_sfValue)+ ',' + IntToStr(pTable.m_swTID) +');';
    End;
    if m_nQRYs=MAX_BLOCK_QRY then CurrentExecute else
    m_nQRYs := m_nQRYs + 1;
    Result := True;
End;
}
function CDBase.setCurrentParamEx(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L3CURRENTDATA'+
              '(m_swVMID,m_swCMDID,m_sTime,m_sfValue,m_swTID, m_sbyMaskRead, m_sbyMaskReRead)'+
              ' VALUES('+
              '(select m_swVMID from sl3vmetertag where m_swMID='+IntToStr(m_swVMID)+')' + ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              FloatToStr(m_sfValue)+ ',' + IntToStr(pTable.m_swTID) + ',' +
              IntToStr(m_sbyMaskRead) + ',' + '0) matching (m_swVMID,m_swCMDID,m_swTID)';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AddArchDataNoBlock(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L3ARCHDATA'+
              '(m_swVMID,m_swCMDID,m_sTime,m_sfValue,m_swTID, m_sbyMaskRead, m_sbyMaskReRead)'+
              ' VALUES('+
              '(select m_swVMID from sl3vmetertag where m_swMID='+IntToStr(m_swVMID)+')' + ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              FloatToStr(m_sfValue)+ ',' + IntToStr(pTable.m_swTID) + ',' +
              IntToStr(m_sbyMaskRead) + ',' + '0) matching (m_swVMID,m_swCMDID,m_swTID,m_sTime)';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AddArchData(var pTable:L3CURRENTDATA):Boolean;
Begin
    if IsArchData(pTable)=True then
    Begin
      UpdateArchData(pTable);
      Result:=False;
      exit;
    End;

    if m_nQRYs=0 then CurrentPrepare;
    with pTable do
    Begin
    strBSQL :=strBSQL+ ' INSERT INTO L3ARCHDATA'+
              '(m_swVMID,m_swCMDID,m_crc,m_sTime,m_sfValue,m_swTID, m_sbyMaskRead, m_sbyMaskReRead)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              IntToStr(m_CRC)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              FloatToStr(m_sfValue)+ ',' + IntToStr(pTable.m_swTID) + ',' +
              IntToStr(m_sbyMaskRead) + ',' + '0);';
    End;
    if m_nQRYs=MAX_BLOCK_QRY then
     CurrentExecute else
    m_nQRYs := m_nQRYs + 1;

    Result := True;

    //Result := ExecQryD1(strSQL);
End;

function CDBase.UpdateArchData(var pTable:L3CURRENTDATA):Boolean;
begin
    if m_nQRYs=0 then CurrentPrepare;
    with pTable do
    Begin
    strBSQL :=strBSQL+ ' UPDATE L3ARCHDATA SET '+
              'm_sfValue=' + FloatToStr(m_sfValue) + ',' +
              'm_CRC=' + IntToStr(m_CRC) + ',' +
              'm_sbyMaskRead=' + IntToStr(m_sbyMaskRead) +
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+' and m_swVMID='+IntToStr(m_swVMID) +
              ' and m_swTID=' + IntToStr(pTable.m_swTID) +
              ' AND CAST(m_sTime as Date)='+''''+DateToStr(m_sTime)+''''+';';
    End;
    if m_nQRYs=MAX_BLOCK_QRY then CurrentExecute else
    m_nQRYs := m_nQRYs + 1;
    Result := True;
    //Result := ExecQryD1(strSQL);
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
    if OpenQryD(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQryD;
    Result := res;
end;
///////ki*ku knsl2grafframe//////////
function CDBase.GetKI_KU(nAVMid : integer;var pTable : SL2TAGREPORTLIST) : boolean;
Var
    nCount,i : Integer;
    res      : Boolean;
    strSQL   : String;
begin
    res := False;

     strSQL := 'SELECT L2TAG.m_swMID,L2TAG.m_sfKI,L2TAG.m_sfKU,SL3VMETERTAG.M_SWVMID,SL3VMETERTAG.M_SWMID'+
     ' from  SL3VMETERTAG INNER JOIN L2TAG ON L2TAG.m_swMID=SL3VMETERTAG.M_SWMID where SL3VMETERTAG.M_SWVMID ='+IntToStr(nAVMid);

    i := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     pTable.Count := nCount;
     SetLength(pTable.m_sMeter, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery,pTable.m_sMeter[i] do
       Begin
       //  m_swVMID      := FieldByName('m_swvmid').AsInteger;
       //  m_swMID       := FieldByName('M_SWMID').AsInteger;
         m_sfKI        := FieldByName('M_SFKI').AsFloat;
         m_sfKU        := FieldByName('M_SFKU').AsFloat;
         Inc(i);
         Next;
       End;
     end;
     res := True;
    End;
    CloseQry;
    Result := res;
end;
/////////////////
function CDBase.GetGraphDatas(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    str0, str1  : string;
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
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_swCMDID      := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      str0  := FADOQueryD2.FieldByName('M_SMASKREAD').AsString;
      str1  := FADOQueryD2.FieldByName('M_SMASKREREAD').AsString;
      if str0='' then str0 := '0';
      if str1='' then str1 := '0';
      m_sMaskRead   := StrToInt64(str0);
      m_sMaskReRead := StrToInt64(str1);
      m_CRC          := FieldByName('m_CRC').AsInteger;
      for j:=0 to 47 do v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;
function CDBase.GetGraphDatasFMAK(strOBJCODE:String;dtP0,dtP1:TDateTime;var pTable:L3GRAPHDATAMCS):Boolean;
Var
    strSQL,strV : AnsiString;
    str0, str1  : string;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin
    strSQL := 'SELECT DISTINCT L2HALF_HOURLY_ENERGY.*,SL3VMETERTAG.m_sMeterCode' +
    ' FROM L2HALF_HOURLY_ENERGY,SL3VMETERTAG'+
    ' WHERE L2HALF_HOURLY_ENERGY.m_swVMID=SL3VMETERTAG.m_swVMID'+
    ' and CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+
    ' and SL3VMETERTAG.m_swVMID IN '+
    ' (SELECT DISTINCT SL3VMETERTAG.m_swVMID FROM SL3GROUPTAG,SL3VMETERTAG,SL3ABON'+
    ' WHERE SL3GROUPTAG.m_swABOID=SL3ABON.m_swABOID'+
    ' and SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID'+
    ' and SL3ABON.m_strOBJCODE='+''''+strOBJCODE+''''+')'+
    ' ORDER BY SL3VMETERTAG.m_swVMID,m_swCMDID,m_sdtDate';
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
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_swCMDID      := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      m_sMeterCode   := FieldByName('m_sMeterCode').AsString;
      str0  := FieldByName('M_SMASKREAD').AsString;
      str1  := FieldByName('M_SMASKREREAD').AsString;
      if str0='' then str0 := '0';
      if str1='' then str1 := '0';
      m_sMaskRead   := StrToInt64(str0);
      m_sMaskReRead := StrToInt64(str1);
      m_CRC          := FieldByName('m_CRC').AsInteger;
      for j:=0 to 47 do v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;
function CDBase.GetGDataFMAK(strOBJCODE:String;dtP0,dtP1:TDateTime;PKey:Integer;var pTable:CCDataMCs):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT SL3VMETERTAG.m_swVMID,m_sMeterCode,m_swCMDID,m_sTime, sum(m_sfValue) as m_sfValue'+
              ' FROM L3ARCHDATA,SL3VMETERTAG'+
              ' WHERE SL3VMETERTAG.m_swVMID=L3ARCHDATA.m_swVMID'+
              ' and m_swTID<>0 and m_swTID<>4'+
              ' and m_swCMDID BETWEEN '+IntToStr(PKey)+' and '+IntToStr(PKey+4)+
              ' and CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+
              ' and SL3VMETERTAG.m_swVMID IN '+
              ' (SELECT DISTINCT SL3VMETERTAG.m_swVMID FROM SL3GROUPTAG,SL3VMETERTAG,SL3ABON'+
              ' WHERE SL3GROUPTAG.m_swABOID=SL3ABON.m_swABOID'+
              ' and SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID'+
              ' and SL3ABON.m_strOBJCODE='+''''+strOBJCODE+''''+')'+
              ' GROUP BY SL3VMETERTAG.m_swVMID,m_sMeterCode,m_swCMDID,m_sTime'+
              ' ORDER BY SL3VMETERTAG.m_swVMID,m_swCMDID,m_sTime';
    {
              SELECT SL3VMETERTAG.m_swVMID,m_sMeterCode,m_swCMDID,m_sTime, sum(m_sfValue) as m_sfValue
              FROM L3ARCHDATA,SL3VMETERTAG
              WHERE SL3VMETERTAG.m_swVMID=L3ARCHDATA.m_swVMID
              and m_swTID<>0 and m_swTID<>4
              and m_swCMDID BETWEEN 17 and 21
              and CAST(m_sTime AS DATE) BETWEEN '03.03.2012' and '03.03.2012'
              and SL3VMETERTAG.m_swVMID IN
              (SELECT DISTINCT SL3VMETERTAG.m_swVMID FROM SL3GROUPTAG,SL3VMETERTAG,SL3ABON
              WHERE SL3GROUPTAG.m_swABOID=SL3ABON.m_swABOID
              and SL3GROUPTAG.M_SBYGROUPID=SL3VMETERTAG.M_SBYGROUPID
              and SL3ABON.m_strOBJCODE='CODEPROU_1')
              GROUP BY SL3VMETERTAG.m_swVMID,m_sMeterCode,m_swCMDID,m_sTime
              ORDER BY SL3VMETERTAG.m_swVMID,m_swCMDID,m_sTime
    }
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
      //m_swTID      := 0;
      m_swCMDID    := FieldByName('m_swCMDID').AsInteger;
      m_sTime      := FieldByName('m_sTime').AsDateTime;
      m_sfValue    := FieldByName('m_sfValue').AsFloat;
      m_sMeterCode := FieldByName('m_sMeterCode').AsString;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD1;
    Result := res;
End;
function CDBase.GetGraphDatasST(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    str0, str1  : string;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin
    strSQL := 'SELECT DISTINCT b0.*,b1.M_SBYLOCKSTATE' +
     ' FROM L2HALF_HOURLY_ENERGY as b0,SL3PARAMS as b1'+
     ' WHERE b0.m_swVMID=b1.m_swVMID and b0.m_swCMDID=b1.M_SWPARAMID'+
     ' and b0.m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and'+
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
      m_swID         := i;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_swCMDID      := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_crc          := FieldByName('M_SBYLOCKSTATE').AsInteger;
      str0           := FieldByName('M_SMASKREAD').AsString;if str0='' then str0 := '0';
      str1           := FieldByName('M_SMASKREREAD').AsString;if str1='' then str1 := '0';
      m_sMaskRead    := StrToInt64(str0);
      m_sMaskReRead  := StrToInt64(str1);
      for j:=0 to 47 do v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQryD2;
    Result := res;
End;
function CDBase.GetGraphDatasPD48(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin
    strSQL := 'SELECT *' +
     ' FROM L3PDTDATA_48'+
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
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_swCMDID      := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
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
    pTable.Count := 0;
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
      m_CRC          := FieldByName('m_CRC').AsInteger;
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

function CDBase.ReturnCRC(m_sfValue:array of double):word;
begin
 result := CalcCRCDB(@m_sfValue,length(m_sfValue)*sizeof(double));
end;

function CDBase.AddGraphData_save(var pTable:L3GRAPHDATA):Boolean;
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
    pTable.m_CRC := 0;
    for i:=0 to 47 do
    begin
     strD := strD + ','+FloatToStr(pTable.v[i]);
     pTable.m_CRC := pTable.m_CRC + ReturnCRC(pTable.v[i]);
     end;

    for i:=0 to 47 do strV := strV + ',v'+IntToStr(i);
    with pTable do
    Begin
    strSQL := 'INSERT INTO L2HALF_HOURLY_ENERGY'+
              '(m_swVMID,m_swCMDID,m_swSumm,m_sdtLastTime,m_sdtDate,m_sMaskReRead,m_sMaskRead'+strV+',M_CRC)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              FloatToStr(m_swSumm)+ ','+
              ''''+DateTimeToStr(m_sdtLastTime)+''''+ ','+
              ''''+DateTimeToStr(m_sdtDate)+''''+','+
              ''''+IntToStr(m_sMaskReRead)+''''+','+
              ''''+IntToStr(m_sMaskRead)+''''+strD+','+
              IntToStr(M_CRC)+');' ;
    End;
    strSQL_into := strSQL_into +  strSQL;
End;

function CDBase.AddGraphData(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL,strV,strD : AnsiString;
    i,nLen : Integer;
    sMaskRead,sMaskReRead : int64;
Begin
    sMaskRead   := pTable.m_sMaskRead;
    sMaskReRead := pTable.m_sMaskReRead;
    if IsGraphData(pTable)=True then
    Begin
      pTable.m_sMaskRead   := sMaskRead;
      pTable.m_sMaskReRead := sMaskReRead;
      UpdateGraphData(pTable);
      Result:=False;
      exit;
    End;
    pTable.m_sMaskRead   := sMaskRead;
    pTable.m_sMaskReRead := sMaskReRead;
    pTable.m_CRC := 0;
    for i:=0 to 47 do
    begin
     strD := strD + ','+FloatToStr(pTable.v[i]);
     pTable.m_CRC := pTable.m_CRC + ReturnCRC(pTable.v[i]);
    end;
    pTable.m_swSumm := pTable.m_CRC;
    pTable.m_sdtLastTime := pTable.m_sdtDate;
    for i:=0 to 47 do strV := strV + ',v'+IntToStr(i);
    with pTable do
    Begin
    strSQL := 'INSERT INTO L2HALF_HOURLY_ENERGY'+
              '(m_swVMID,m_swCMDID,m_swSumm,m_sdtLastTime,m_sdtDate,m_sMaskReRead,m_sMaskRead'+strV+',M_CRC)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              FloatToStr(m_swSumm)+ ','+
              ''''+DateTimeToStr(m_sdtLastTime)+''''+ ','+
              ''''+DateTimeToStr(m_sdtDate)+''''+','+
              ''''+IntToStr(m_sMaskReRead)+''''+','+
              ''''+IntToStr(m_sMaskRead)+''''+strD+','+
              IntToStr(M_CRC)+')' ;
    End;
    //TraceL(4,0,'(__)CLDBD::>CVPRM INS LEN : '+IntToStr(Length(strSQL)));
    Result := ExecQryD1(strSQL);
End;
function CDBase.AddIfExGraphData(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL,strV,strD : AnsiString;
    i,nLen,nCSID : Integer;
    sMaskRead,sMaskReRead,sUpdMask,sValidMask : int64;
    nM : int64;
Begin
    nM := 1;
    sMaskRead   := pTable.m_sMaskRead or ($1000000000000);
    sMaskReRead := pTable.m_sMaskReRead;
    if IsGraphData(pTable)=True then
    Begin
      nCSID    := trunc(frac(Now)/EncodeTime(0,30,0,0))-1;
      sUpdMask := pTable.m_sMaskRead xor sMaskRead;
      if (nCSID>=0)and(trunc(pTable.m_sdtDate)=trunc(Now)) then sUpdMask := sUpdMask or (nM shl nCSID);
      UpdateIfExGraphData(pTable,sUpdMask,sMaskReRead);
      Result:=False;
      exit;                                                             
    End;
    pTable.m_sMaskRead   := sMaskRead and $ffffffffffff;
    pTable.m_sMaskReRead := sMaskReRead;
    pTable.m_CRC := 0;
    for i:=0 to 47 do
    begin
     strD := strD + ','+FloatToStr(pTable.v[i]);
     pTable.m_CRC := pTable.m_CRC + ReturnCRC(pTable.v[i]);
    end;
    pTable.m_swSumm := pTable.m_CRC;
    pTable.m_sdtLastTime := pTable.m_sdtDate;
    for i:=0 to 47 do strV := strV + ',v'+IntToStr(i);
    with pTable do
    Begin
    strSQL := 'INSERT INTO L2HALF_HOURLY_ENERGY'+
              '(m_swVMID,m_swCMDID,m_swSumm,m_sdtLastTime,m_sdtDate,m_sMaskReRead,m_sMaskRead'+strV+',M_CRC)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              FloatToStr(m_swSumm)+ ','+
              ''''+DateTimeToStr(m_sdtLastTime)+''''+ ','+
              ''''+DateTimeToStr(m_sdtDate)+''''+','+
              ''''+IntToStr(m_sMaskReRead)+''''+','+
              ''''+IntToStr(m_sMaskRead)+''''+strD+','+
              IntToStr(M_CRC)+')' ;
    End;
    //TraceL(4,0,'(__)CLDBD::>CVPRM INS LEN : '+IntToStr(Length(strSQL)));
    Result := ExecQryD1(strSQL);
End;

function CDBase.SaveGraphData:Boolean;
var
strSQL :string;
begin
    strSQL:='';
    strSQL := 'execute block as begin ' + strSQL_into + 'end';
    strSQL_into := '';
    Result := ExecQryD1(strSQL);
end;

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

{function CDBase.AddArchUspdTable(var pTable:Arch_uspd; nGroup,nEvent:Integer):Boolean;
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
End;  }

{
SEVENTSETTTAG = packed record
     m_swID         : Integer;
     m_swGroupID    : Word;
     m_swEventID    : Word;
     //m_sdtEventTime : TDateTIme;
     m_schEventName : String[50];
     m_sbyEnable    : Byte;
    end;
}

function CDBase.DelArchUspdTable(nGroup,nEvents,nVMID:Integer;tm0,tm1:TDateTime):Boolean;
Var
    strSQL : String;
    pTable : ARCH_USPD;
    nCount   : integer;
    m_nobj   : SL3VMETERTAG;
    m_nevent : SEVENTSETTTAG;
Begin
     strSQL := 'SELECT M_SCHEVENTNAME FROM SEVENTSETTTAGS WHERE '+
    ' m_swGroupID = '+IntToStr(nGroup)+
    ' AND  m_swEventID =' + IntToStr(nEvents); //+
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
{     //gomel'_енерготелеком
     function IsAbon(var pTable:Abon):Boolean;
     function AddAbon(var pTable:Abon):Boolean;
     function UpdateAbon(var pTable:Abon):Boolean;
     function DelAbon(Date1, Date2 : TDateTime; var Data :Abon):Boolean;
    }

     { ABON = packed record
     ABO        :INTEGER;
     NM_ABO     :string[100];
     KSP        :string[5];
     NOM_DOGWR  :string[6];
    end;}
    function CDBase.IsAbon(var pTable:Abon):Boolean;
    Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    Begin
      strSQL := 'SELECT 0 FROM Abon WHERE'+
      ' ABO='+IntToStr(pTable.ABO);
      res := False;
      if OpenQryD1(strSQL,nCount)=True then
      Begin
       res   := True;
      End;
      CloseQryD1;
      Result := res;
      end;

function CDBase.AddAbon(var pTable:Abon):Boolean;
 Var
    strSQL   : AnsiString;
    Begin
    if IsAbon(pTable) = true then
    begin
      UpdateAbon(pTable);
      Result:=False;
      exit;
    end;
  with pTable do
    Begin
    strSQL := 'INSERT INTO Abon'+
              '(ABO,NM_ABO,KSP,NOM_DOGWR)'+
              ' VALUES('+
              IntToStr(ABO)+ ','+
             ''''+NM_ABO   +'''' +','+
              ''''+KSP   +'''' +','+
              ''''+NOM_DOGWR+''''+')';
     End;
     Result := ExecQryD1(strSQL);
end;

function CDBase.UpdateAbon(var pTable:Abon):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    i,nLen : Integer;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE Abon SET '+
              ' ABO='+IntToStr(ABO)+
              ',NM_ABO='   +''''+NM_ABO+''''+
              ',KSP='   +''''+KSP+''''+
              ',NOM_DOGWR='   +''''+NOM_DOGWR+'''';
     nLen := Length(strSQL);
    End;
    Result := ExecQryD1(strSQL);
End;

function CDBase.DelAbon(Date1, Date2 : TDateTime; var Data :ABON):Boolean;
Var
    strSQL                 : String;

Begin
    strSQL := 'DELETE FROM ABON ';//WHERE '+
    Result := ExecQryD1(strSQL);
End;
/////////////////////////////////////////////////////////////////////////////////////
     {  TUCH = packed record
     ABO      :INTEGER;
     TUCH     :INTEGER;
     ZNOM_SH  :string[10];
     ADRTU    :string[50];
     KFTRN    :INTEGER;
    end;
    function IsTUCH(var pTable:TUCH):Boolean;
     function AddTUCH(var pTable:TUCH):Boolean;
     function UpdateTUCH(var pTable:TUCH):Boolean;
     function DelTUCH(Date1, Date2 : TDateTime; var Data :TUCH):Boolean;
}
function CDBase.LoadForTUCHParams(var pTable:SLTUCH;n_abo:integer):Boolean;
var
strSQL                 : String;
nCount,i:integer;
 res      : Boolean;
begin
 strSQL := 'SELECT L2TAG.m_swMID,L2TAG.m_sfKI,L2TAG.m_sfKU,L2TAG.m_sddfabnum,SL3VMETERTAG.M_SWVMID,SL3VMETERTAG.M_SWMID,'+
  'SL3VMETERTAG.m_svmetername from  SL3VMETERTAG INNER JOIN L2TAG ON L2TAG.m_swMID=SL3VMETERTAG.M_SWMID';
  i := 0;
 if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do
     begin
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
       with FADOQuery,pTable.Items[i] do
       Begin
       Abo      :=  n_abo;
       TUCH     :=  FieldByName('m_swvmid').AsInteger;
       ZNOM_SH  :=  FieldByName('m_sddfabnum').AsString;
       ADRTU    :=  FieldByName('m_svmetername').AsString;
       KFTRN    :=  FieldByName('M_SFKI').AsInteger*FieldByName('M_SFKU').AsInteger;
       AddTUCH(pTable.Items[i]);
       Inc(i);
       Next;
       End;
     end;
     res := True;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.IsTUCH(var pTable:TUCH):Boolean;
Var
strSQL   : String;
res      : Boolean;
nCount   : Integer;
    Begin
      strSQL := 'SELECT 0 FROM TUCH WHERE'+
      ' ABO='+IntToStr(pTable.ABO)+
      ' and TUCH='+IntToStr(pTable.TUCH);
    {  ' and ZNOM_SH = ' +''''+ pTable.ZNOM_SH +''''+
      ' and ADRTU = ' +''''+ pTable.ADRTU +''''+
      ' and KFTRN='+IntToStr(pTable.KFTRN);  }
      res := False;
      if OpenQryD1(strSQL,nCount)=True then
      Begin
       res   := True;
      End;
      CloseQryD1;
      Result := res;
      end;

function CDBase.AddTUCH(var pTable:TUCH):Boolean;
 Var
    strSQL   : AnsiString;
    Begin
    if IsTUCH(pTable) = true then
    begin
      UpdateTUCH(pTable);
      Result:=False;
      exit;
    end;

  with pTable do
    Begin
    strSQL := 'INSERT INTO TUCH'+
              '(ABO,TUCH,ZNOM_SH,ADRTU,KFTRN)'+
              ' VALUES('+
              IntToStr(ABO)+ ','+
              IntToStr(TUCH)+ ','+
              ''''+ZNOM_SH   +'''' +','+
              ''''+ADRTU   +'''' +','+
              IntToStr(KFTRN)+ ')';
     End;
     Result := ExecQryD1(strSQL);
end;

function CDBase.UpdateTUCH(var pTable:TUCH):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    i,nLen : Integer;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE TUCH SET '+
              ' ZNOM_SH='   +''''+ZNOM_SH+''''+
              ',ADRTU='   +''''+ADRTU+''''+
              ',KFTRN='+IntToStr(KFTRN)+
              ' WHERE  ABO='+IntToStr(ABO)+ 'and TUCH='+IntToStr(TUCH);
     nLen := Length(strSQL);
    End;
    Result := ExecQryD1(strSQL);
End;

function CDBase.DelTUCH(Date1, Date2 : TDateTime; var Data :TUCH):Boolean;
Var
    strSQL                 : String;

Begin
    strSQL := 'DELETE FROM ABON ';//WHERE '+
    Result := ExecQryD1(strSQL);
End;
/////////////////////////////////////////////////////////////////////////////////////
     {   BUF_V_INT = packed record
     ABO          :INTEGER;
     TUCH         :INTEGER;
     N_GR_TY      :INTEGER;
     DD_MM_YYYY   :TDateTime;
     N_INTER_RAS  :INTEGER;
     VAL          :Double;
     POK_START    :Double;
     VAL1         :Double;
    end;
  function IsBUF_V_INT(var pTable:BUF_V_INT):Boolean;
     function AddBUF_V_INT(var pTable:BUF_V_INT):Boolean;
     function UpdateBUF_V_INT(var pTable:BUF_V_INT):Boolean;
     function DelBUF_V_INT(Date1, Date2 : TDateTime; var Data :BUF_V_INT):Boolean;
}
function CDBase.GetGDataGomelEnergo(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT m_swCMDID,m_sTime,m_sfValue,m_swTID,m_CRC '+
              ' FROM L3ARCHDATA'+
              ' WHERE m_swVMID='+IntToStr(FKey)+' and '+
              ' m_swCMDID BETWEEN '+ IntToStr(PKey) + ' and ' + IntToStr(PKey+4)+
              ' and m_swTID = 0'+
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
      m_CRC        := FieldByName('m_CRC').AsInteger;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD1;
    Result := res;
End;
    function CDBase.IsBUF_V_INT(var pTable:BUF_V_INT):Boolean;
    Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    Begin

      strSQL := 'SELECT 0 FROM BUF_V_INT WHERE'+
      ' ABO='+IntToStr(pTable.ABO)+
      ' and TUCH='+IntToStr(pTable.TUCH)+
      ' and N_GR_TY='+IntToStr(pTable.N_GR_TY)+
      ' and DD_MM_YYYY = ' +''''+ DateToStr(pTable.DD_MM_YYYY) +''''+
      ' and N_INTER_RAS='+IntToStr(pTable.N_INTER_RAS);
{      ' and VAL='+FloatToStr(pTable.VAL)+
      ' and POK_START='+FloatToStr(pTable.POK_START)+
      ' and VAL1='+FloatToStr(pTable.VAL1);}

      res := False;
      if OpenQryD1(strSQL,nCount)=True then
      Begin
       res   := True;
      End;
      CloseQryD1;
      Result := res;
      end;

function CDBase.AddBUF_V_INT(var pTable:BUF_V_INT):Boolean;
 Var
    strSQL   : AnsiString;
    Begin
    if IsBUF_V_INT(pTable) = true then
    begin
      UpdateBUF_V_INT(pTable);
      Result:=False;
      exit;
    end;
  with pTable do
    Begin

    strSQL := 'INSERT INTO BUF_V_INT'+
              '(ABO,TUCH,N_GR_TY,DD_MM_YYYY,N_INTER_RAS,VAL,POK_START,VAL1)'+
              ' VALUES('+
              IntToStr(ABO)+ ','+
              IntToStr(TUCH)+ ','+
              IntToStr(N_GR_TY)+ ','+
             ''''+DateToStr(DD_MM_YYYY)   +'''' +','+
              IntToStr(N_INTER_RAS)+ ','+
              FloatToStr(VAL)+ ','+
              FloatToStr(POK_START)+ ','+
              FloatToStr(VAL1)+ ')';
     End;
     Result := ExecQryD1(strSQL);
end;

function CDBase.UpdateBUF_V_INT(var pTable:BUF_V_INT):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    i,nLen : Integer;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE BUF_V_INT SET '+
              ' ABO='+IntToStr(ABO)+
              ',TUCH='+IntToStr(TUCH)+
              ',N_GR_TY='+IntToStr(N_GR_TY)+
              ',DD_MM_YYYY='   +''''+DateToStr(DD_MM_YYYY)+''''+
              ',N_INTER_RAS='+IntToStr(N_INTER_RAS)+
              ',VAL='+FloatToStr(VAL)+
              ',POK_START='+FloatToStr(POK_START)+
              ',VAL1='+FloatToStr(VAL1);
     nLen := Length(strSQL);
    End;
    Result := ExecQryD1(strSQL);
End;

function CDBase.DelBUF_V_INT(Date1, Date2 : TDateTime; var Data :BUF_V_INT;M_pABON:integer):Boolean;
Var
    strSQL                 : String;
    FirstCMDID,LastCMDID,nCount   : Integer;
    m_nobj:SL3VMETERTAG;
Begin
    FirstCMDID := Data.N_GR_TY - (Data.N_GR_TY - 1) mod 4;
    LastCMDID  := FirstCMDID + 4;
    if Data.ABO=$fffe then
    strSQL := 'DELETE FROM BUF_V_INT WHERE '+
    ' N_GR_TY BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) else
    if Data.ABO=$ffff then
    strSQL := 'DELETE FROM BUF_V_INT WHERE '+
    ' N_GR_TY BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and DD_MM_YYYY BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''' else
    if Data.ABO<$fffe then
    begin
     strSQL := 'SELECT  * From SL3VMETERTAG WHERE SL3VMETERTAG.m_swVMID = '+IntToStr(Data.ABO) ;
     if OpenQry(strSQL,nCount)=True then
     Begin
     // m_nobj.m_sbyPortID   := FADOQuery.FieldByName('m_sbyPortID').AsInteger;
      m_nobj.m_sVMeterName   := FADOQuery.FieldByName('m_sVMeterName').AsString;
      Data.TUCH   :=  m_nobj.m_swVMID;
      Data.ABO    :=  M_pABON;
     end;
     CloseQry;
     strSQL := 'DELETE FROM BUF_V_INT WHERE ABO= '+
     IntToStr(Data.ABO) + 'AND TUCH = '+IntToStr(Data.TUCH)+
     ' AND N_GR_TY BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
     ' and DD_MM_YYYY BETWEEN '+''''+DateToStr(Date1)+'''' +
     ' and ' + '''' + DateToStr(Date2) + '''';
    end;
    Result := ExecQryD1(strSQL);
End;

    {strSQL := 'DELETE FROM BUF_V_INT ';//WHERE '+
    Result := ExecQryD1(strSQL);  }

/////////////////////////////////////////////////////////////////////////////////////
     {   AVT_EXP = packed record
     ZAVN     :string[28];
     KJU      :string[16];
     ADR      :string[255];
     KOD_CH   :INTEGER;
     TIPSH    :string[8];
     UCH      :INTEGER;
     DAT      :TDateTime;
     VREM     :Double;
     Q1       :Double;
     V1       :Double;
     TPOD     :Double;
     Q2       :Double;
     V2       :Double;
     TOBR     :Double;
     TXV      :Double;
     TRAB     :Double;
     TRAB_O   :Double;
     N_GRUCH  :INTEGER;
    end;
 {

     function IsAVT_EXP(var pTable:AVT_EXP):Boolean;
     function AddAVT_EXP(var pTable:AVT_EXP):Boolean;
     function UpdateAVT_EXP(var pTable:AVT_EXP):Boolean;
     function DelAVT_EXP(Date1, Date2 : TDateTime; var Data :AVT_EXP):Boolean;}
    function CDBase.IsAVT_EXP(var pTable:AVT_EXP):Boolean;
    Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    Begin
      strSQL := 'SELECT 0 FROM AVT_EXP WHERE'+
      ' ZAVN = ' +''''+ pTable.ZAVN +''''+
      ' KJU = ' +''''+ pTable.KJU +''''+
      ' ADR = ' +''''+ pTable.ADR +''''+
      ' KOD_CH='+IntToStr(pTable.KOD_CH)+
      ' TIPSH = ' +''''+ pTable.TIPSH +''''+
      ' UCH='+IntToStr(pTable.UCH)+
      ' DAT = ' +''''+ DateToStr(pTable.DAT) +''''+
      ' VREM='+FloatToStr(pTable.VREM)+
      ' Q1='+FloatToStr(pTable.Q1)+
      ' V1='+FloatToStr(pTable.V1)+
      ' TPOD='+FloatToStr(pTable.TPOD)+
      ' Q2='+FloatToStr(pTable.Q2)+
      ' V2='+FloatToStr(pTable.V2)+
      ' TOBR='+FloatToStr(pTable.TOBR)+
      ' TXV='+FloatToStr(pTable.TXV)+
      ' TRAB='+FloatToStr(pTable.TRAB)+
      ' TRAB_O='+FloatToStr(pTable.TRAB_O)+
      ' N_GRUCH='+IntToStr(pTable.N_GRUCH);
      res := False;
      if OpenQryD1(strSQL,nCount)=True then
      Begin
       res   := True;
      End;
      CloseQryD1;
      Result := res;
      end;

function CDBase.AddAVT_EXP(var pTable:AVT_EXP):Boolean;
 Var
    strSQL   : AnsiString;
    Begin
    if IsAVT_EXP(pTable) = true then
    begin
      UpdateAVT_EXP(pTable);
      Result:=False;
      exit;
    end;
  with pTable do
     Begin
     strSQL := 'INSERT INTO AVT_EXP'+
              '(ZAVN,KJU,ADR,KOD_CH,TIPSH,UCH,DAT,VREM,Q1,V1,TPOD,Q2,V2,TOBR,TXV,TRAB,TRAB_O,N_GRUCH)'+
              ' VALUES('+
              ''''+ZAVN   +'''' +','+
              ''''+KJU   +'''' +','+
              ''''+ADR   +'''' +','+
              IntToStr(KOD_CH)+ ','+
              ''''+TIPSH   +'''' +','+
               IntToStr(UCH)+ ','+
              ''''+DateToStr(DAT)   +'''' +','+
              FloatToStr(VREM)+ ','+
              FloatToStr(Q1)+ ','+
              FloatToStr(V1)+ ','+
              FloatToStr(Q2)+ ','+
              FloatToStr(V2)+ ','+
              FloatToStr(TOBR)+ ','+
              FloatToStr(TXV)+ ','+
              FloatToStr(TRAB)+ ','+
              FloatToStr(TRAB_O)+ ','+
              IntToStr(N_GRUCH)+ ')';

     End;
     Result := ExecQryD1(strSQL);
end;

function CDBase.UpdateAVT_EXP(var pTable:AVT_EXP):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    i,nLen : Integer;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE AVT_EXP SET '+
              'ZAVN='   +''''+ZAVN+''''+
              ',KJU='   +''''+KJU+''''+
              ',ADR='   +''''+ADR+''''+
              ',KOD_CH='+IntToStr(KOD_CH)+
              ',TIPSH='   +''''+TIPSH+''''+
              ',UCH='+IntToStr(UCH)+
              ',DAT='   +''''+DateToStr(DAT)+''''+
              ',VREM='+FloatToStr(VREM)+
              ',Q1='+FloatToStr(Q1)+
              ',V1='+FloatToStr(V1)+
              ',TPOD='+FloatToStr(TPOD)+
              ',Q2='+FloatToStr(Q2)+
              ',V2='+FloatToStr(V2)+
              ',TOBR='+FloatToStr(TOBR)+
              ',TXV='+FloatToStr(TXV)+
              ',TRAB='+FloatToStr(TRAB)+
              ',TRAB_O='+FloatToStr(TRAB_O)+
              ',N_GRUCH='+IntToStr(N_GRUCH);

     nLen := Length(strSQL);
    End;
    Result := ExecQryD1(strSQL);
End;

function CDBase.DelAVT_EXP(Date1, Date2 : TDateTime; var Data :L3DATASAVT_EXP):Boolean;
Var
    strSQL                 : String;

Begin
    strSQL := 'DELETE FROM AVT_EXP '+
    ' WHERE CAST(dat AS DATE) BETWEEN '+'''' + FormatDateTime('yyyy-mm-dd',Date1) +''''+ ' and ' +''''+FormatDateTime('yyyy-mm-dd',Date2)+''''+
    ' and ZAVN='+''''+Data.ZAVN+'''';
    FADOQueryMySQL.SQL.Clear;
    FADOQueryMySQL.SQL.Add(strSQL);
    FADOQueryMySQL.ExecSQL();
    FADOQueryMySQL.Close();
End;
/////////////////////////////////////////////////////////////////////////////////////
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
function CDBase.UpdateGD48(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL,strD,strV : AnsiString;
    i,nLen : Integer;
    pTab   : L3GRAPHDATA;
    ptabcrc:L3GRAPHDATAS;
Begin
    pTab.m_swVMID      := pTable.m_swVMID;
    pTab.m_swCMDID     := pTable.m_swCMDID;
    pTab.m_sdtDate     := pTable.m_sTime;
    pTab.m_sdtLastTime := pTable.m_sTime;
    if pTable.m_swSID>47 then exit;
    if IsGraphData(pTab)=False then
    Begin
     for i:=0 to 47 do
     begin
      strD := strD +',' + FloatToStr(0);
      strV := strV + ',v'+IntToStr(i);
     end;
     with pTab do
     Begin
      strSQL := 'INSERT INTO L2HALF_HOURLY_ENERGY'+
                '(m_swVMID,m_swCMDID,m_swSumm,M_CRC,m_sMaskRead,m_sMaskReRead,m_sdtLastTime,m_sdtDate'+strV+')'+
                ' VALUES('+
                IntToStr(m_swVMID)+ ','+
                IntToStr(m_swCMDID)+ ','+
                FloatToStr(m_swSumm)+ ','+
                IntToStr(m_CRC)+ ','+
                ''''+IntToStr(m_sMaskRead)+''''+ ',' +
                ''''+IntToStr(m_sMaskReRead)+''''+',' +
                ''''+DateTimeToStr(m_sdtLastTime)+''''+ ','+
                ''''+DateTimeToStr(m_sdtDate)+''''+strD+')';
     End;
     ExecQryD1(strSQL);
    End;
    strV := ' ,v'+IntToStr(pTable.m_swSID)+'='+FloatToStr(pTable.m_sfValue);
    pTab.m_sMaskRead   := pTable.m_sbyMaskRead;
    pTab.m_sMaskReRead := pTable.m_sbyMaskReRead;
    with pTable do
    Begin
    strSQL := 'UPDATE L2HALF_HOURLY_ENERGY SET '+
              ' m_sMaskRead = '+''''+IntToStr(pTab.m_sMaskRead)+''''+
              ',m_sMaskreRead = '+''''+IntToStr(pTab.m_sMaskReRead)+''''+
              ',m_sdtDate='   +''''+DateTimeToStr(m_sTime)+''''+
              ',m_CRC='+IntToStr(m_CRC)+
              strV+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+' and m_swVMID='+IntToStr(m_swVMID) +
              ' AND CAST(m_sdtDate as Date) = ' + '''' + DateToStr(pTable.m_sTime) + '''';
    nLen := Length(strSQL);
    //TraceL(4,0,'(__)CLDBD::>CVPRM UPD LEN : '+IntToStr(nLen));
    End;
    Result := ExecQryD1(strSQL);
End;
function CDBase.UpdateGraphFilds(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL,strD,strV : AnsiString;
    i,nLen : Integer;
    pTab   : L3GRAPHDATA;
    ptabcrc:L3GRAPHDATAS;
Begin
    pTab.m_swVMID      := pTable.m_swVMID;
    pTab.m_swCMDID     := pTable.m_swCMDID;
    pTab.m_sdtDate     := pTable.m_sTime;
    pTab.m_sdtLastTime := pTable.m_sTime;
    pTab.m_sMaskRead   := 0;
    pTab.m_sMaskReRead := 0;
    if pTable.m_swSID>47 then exit;
    if IsGraphData(pTab)=False then
    Begin
     for i:=0 to 47 do
     begin
     strD := strD +',' + FloatToStr(0);
     strV := strV + ',v'+IntToStr(i);
     //pTab.m_CRC := pTab.m_CRC + ReturnCRC(pTab.v[i]);
     end;
     with pTab do
     Begin
      strSQL := 'INSERT INTO L2HALF_HOURLY_ENERGY'+
                '(m_swVMID,m_swCMDID,m_swSumm,M_CRC,m_sMaskRead,m_sMaskReRead,m_sdtLastTime,m_sdtDate'+strV+')'+
                ' VALUES('+
                IntToStr(m_swVMID)+ ','+
                IntToStr(m_swCMDID)+ ','+
                FloatToStr(m_swSumm)+ ','+
                IntToStr(m_CRC)+ ','+
                ''''+IntToStr(m_sMaskRead)+''''+ ',' +
                ''''+IntToStr(m_sMaskReRead)+''''+',' +
                ''''+DateTimeToStr(m_sdtLastTime)+''''+ ','+
                ''''+DateTimeToStr(m_sdtDate)+''''+strD+')';
     End;
     ExecQryD1(strSQL);
    End;
    strV := ' ,v'+IntToStr(pTable.m_swSID)+'='+FloatToStr(pTable.m_sfValue);
    SetByteMask(pTab.m_sMaskRead, pTable.m_swSID);
    if pTable.m_sbyMaskReRead=PR_TRUE then SetByteMask(pTab.m_sMaskReRead, pTable.m_swSID) else
    if pTable.m_sbyMaskReRead=PR_FAIL then RemByteMask(pTab.m_sMaskReRead, pTable.m_swSID);
    with pTable do
    Begin
    strSQL := 'UPDATE L2HALF_HOURLY_ENERGY SET '+
              ' m_sMaskRead = '+''''+IntToStr(pTab.m_sMaskRead)+''''+
              ',m_sMaskreRead = '+''''+IntToStr(pTab.m_sMaskReRead)+''''+
              ',m_sdtDate='   +''''+DateTimeToStr(m_sTime)+''''+
              ',m_CRC='+IntToStr(m_CRC)+
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
    pTable.m_CRC := 0;
    for i:=0 to 47 do
    Begin
     if(abs(pTable.v[i])<0.000001) then pTable.v[i]:=0;
     strD := strD + ',v'+IntToStr(i)+'='+FloatToStr(pTable.v[i]);
    End;
    with pTable do
    Begin
    strSQL := 'UPDATE L2HALF_HOURLY_ENERGY SET '+
              ' m_swSumm='+FloatToStr(m_swSumm)+
               ',m_CRC='+IntToStr(m_CRC)+
              ',m_sdtLastTime='+''''+DateTimeToStr(m_sdtLastTime)+''''+
              ',m_sdtDate='   +''''+DateTimeToStr(m_sdtDate)+''''+
              ',m_sMaskRead='+''''+IntToStr(m_sMaskRead)+''''+
              ',m_sMaskReRead='+''''+IntToStr(m_sMaskReRead)+''''+
              strD+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+' and m_swVMID='+IntToStr(m_swVMID) +
              ' AND CAST(m_sdtDate as Date) = ' + '''' + DateToStr(pTable.m_sdtDate) + '''';
    nLen := Length(strSQL);
    //TraceL(4,0,'(__)CLDBD::>CVPRM UPD LEN : '+IntToStr(nLen));
    //nLen := Length(strSQL);
    End;
    Result := ExecQryD1(strSQL);
End;
function CDBase.UpdateIfExGraphData(var pTable:L3GRAPHDATA;sUpdMask,sValidMask:int64):Boolean;
Var
    strSQL,strD : AnsiString;
    i,nLen : Integer;
    nM,nMask : int64;
Begin
    nM := 1;nMask:= $ffffffffffff;
    pTable.m_CRC := 0;
    strD := '';
    for i:=0 to 47 do
    Begin
     if(abs(pTable.v[i])<0.000001) then pTable.v[i]:=0;
     if (sUpdMask and(nM shl i))<>0 then
     Begin
      strD := strD + ',v'+IntToStr(i)+'='+FloatToStr(pTable.v[i]);
      if (sValidMask and(nM shl i))<>0 then pTable.m_sMaskReRead := pTable.m_sMaskReRead or (nM shl i);
      if (sValidMask and(nM shl i))=0  then pTable.m_sMaskReRead := pTable.m_sMaskReRead and not (nM shl i);
      //pTable.m_sMaskReRead := pTable.m_sMaskReRead or (1 shl i);
     End;
    End;
    pTable.m_sMaskRead := (pTable.m_sMaskRead or sUpdMask)and nMask;
    with pTable do
    Begin
    strSQL := 'UPDATE L2HALF_HOURLY_ENERGY SET '+
              ' m_swSumm='+FloatToStr(m_swSumm)+
               ',m_CRC='+IntToStr(m_CRC)+
              ',m_sdtLastTime='+''''+DateTimeToStr(m_sdtLastTime)+''''+
              ',m_sdtDate='   +''''+DateTimeToStr(m_sdtDate)+''''+
              ',m_sMaskRead='+''''+IntToStr(m_sMaskRead)+''''+
              ',m_sMaskReRead='+''''+IntToStr(m_sMaskReRead)+''''+
              strD+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+' and m_swVMID='+IntToStr(m_swVMID) +
              ' AND CAST(m_sdtDate as Date) = ' + '''' + DateToStr(pTable.m_sdtDate) + '''';
    nLen := Length(strSQL);
    //TraceL(4,0,'(__)CLDBD::>CVPRM UPD LEN : '+IntToStr(nLen));
    //nLen := Length(strSQL);
    End;
    Result := ExecQryD1(strSQL);
End;
function CDBase.IsGraphData(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    nSr      : byte;
    str0     : String;
Begin
    strSQL := 'SELECT m_sMaskRead,m_sMaskReRead FROM L2HALF_HOURLY_ENERGY WHERE'+
    ' m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and m_swCMDID='+IntToStr(pTable.m_swCMDID)+
    ' and CAST(m_sdtDate as DATE)='+''''+DateToStr(pTable.m_sdtDate)+'''';
    res := False;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     res                 := True;
     str0 := FADOQueryD1.FieldByName('m_sMaskRead').AsString;
     if str0<>'' then pTable.m_sMaskRead := StrToInt64(str0);
     str0 := FADOQueryD1.FieldByName('m_sMaskReRead').AsString;
     if str0<>'' then pTable.m_sMaskReRead := StrToInt64(str0);
    End;
    CloseQryD1;
    Result := res;
End;
//CAST(m_sTime AS DATE)
{
strSQL := 'SELECT distinct s1.m_swABOID,s2.M_SWVMID,s0.m_sDogNum,s3.m_sddFabNum,s0.m_sAddress'+
    ' FROM SL3ABON as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2,L2TAG as s3'+
    ' where s0.m_swABOID in ('+strAID+')'+
    ' and s0.m_swABOID=s1.m_swABOID and s2.M_SWMID=s3.M_SWMID'+
    ' and s1.m_sbyGroupID=s2.m_sbyGroupID'+
    ' and s2.m_sbyEnable=1 and s1.M_NGROUPLV=0'+
    ' ORDER BY s0.m_swABOID,s2.m_swVMID';
}
function CDBase.DelGraphData(Date1, Date2 : TDateTime;var Data :L3GRAPHDATA):Boolean;
Var
    strSQL,strSel          : String;
    FirstCMDID,LastCMDID   : Integer;
Begin
    FirstCMDID := Data.m_swCMDID - (Data.m_swCMDID - 1) mod 4;
    LastCMDID  := FirstCMDID + 4;
    strSel := '(select distinct m_swVMID from SL3ABON as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2'+
    ' where s0.m_swABOID=s1.m_swABOID and s1.m_sbyGroupID=s2.m_sbyGroupID and s0.m_swABOID='+IntToStr(Data.m_swID)+')';
    if Data.m_swVMID=$fffe then
    strSQL := 'DELETE FROM L2HALF_HOURLY_ENERGY WHERE m_swVMID in'+strSel+
    ' and m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) else
    if Data.m_swVMID=$ffff then
    strSQL := 'DELETE FROM L2HALF_HOURLY_ENERGY WHERE m_swVMID in'+strSel+
    ' and m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sdtDate as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''' else
    if Data.m_swVMID<$fffe then
    strSQL := 'DELETE FROM L2HALF_HOURLY_ENERGY WHERE m_swVMID= '+IntToStr(Data.m_swVMID) +
    ' AND m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sdtDate as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''';
    if Data.m_swVMID>$fffe then
    strSQL := 'DELETE FROM L2HALF_HOURLY_ENERGY WHERE m_swVMID= '+IntToStr(Data.m_swVMID) +
    ' AND m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sdtDate as DATE) BETWEEN '+''''+DateToStr(Date1)+'''' +
    ' and ' + '''' + DateToStr(Date2) + '''';
    Result := ExecQryD1(strSQL);
End;
function CDBase.SetValidSlice(DateTime:TDateTime;FMasterIndex,FIndex,m_nValIndex:Integer;nValid:Boolean):Boolean;
Var
    pTable : L3GRAPHDATA;
    strSQL : String;
    nM     : int64;
Begin
    nM := 1;
    pTable.m_swVMID  :=FMasterIndex;
    pTable.m_swCMDID :=FIndex;
    pTable.m_sdtDate :=DateTime;
    if IsGraphData(pTable)=True then
    Begin
     if nValid=True  then pTable.m_sMaskReRead := pTable.m_sMaskReRead or (nM shl m_nValIndex);
     if nValid=False then pTable.m_sMaskReRead := pTable.m_sMaskReRead and not(nM shl m_nValIndex);
     strSQL := 'UPDATE L2HALF_HOURLY_ENERGY SET M_SMASKREREAD='+IntToStr(pTable.m_sMaskReRead)+
     ' WHERE CAST(m_sdtDate AS DATE)='+''''+DateToStr(DateTime)+''''+
     ' and m_swVMID='+IntToStr(FMasterIndex)+
     ' and m_swCMDID='+IntToStr(FIndex);
     Result := ExecQryD(strSQL);
    End;
End;

function CDBase.SetSliceToRead(DateTime:TDateTime;FMasterIndex,FIndex,m_nValIndex:Integer;nValid:Boolean):Boolean;
Var
    pTable : L3GRAPHDATA;
    strSQL : String;
    nM     : int64;
Begin
    nM := 1;
    pTable.m_swVMID  :=FMasterIndex;
    pTable.m_swCMDID :=FIndex;
    pTable.m_sdtDate :=DateTime;
    if IsGraphData(pTable)=True then
    Begin
     if nValid=True  then pTable.m_sMaskRead := pTable.m_sMaskRead or (nM shl m_nValIndex);
     if nValid=False then pTable.m_sMaskRead := pTable.m_sMaskRead and not(nM shl m_nValIndex);
     strSQL := 'UPDATE L2HALF_HOURLY_ENERGY SET M_SMASKREAD='+IntToStr(pTable.m_sMaskRead)+
     ' WHERE CAST(m_sdtDate AS DATE)='+''''+DateToStr(DateTime)+''''+
     ' and m_swVMID='+IntToStr(FMasterIndex)+
     ' and m_swCMDID='+IntToStr(FIndex);
     Result := ExecQryD(strSQL);
    End;
End;
function CDBase.SetSlice(DateTime:TDateTime;FMasterIndex,FIndex,m_nValIndex:Integer;dValue:Double;nValid,nState:Boolean):Boolean;
Var
    pTable : L3GRAPHDATA;
    strSQL : String;
    nM     : int64;
Begin
    nM := 1;
    pTable.m_swVMID  :=FMasterIndex;
    pTable.m_swCMDID :=FIndex;
    pTable.m_sdtDate :=DateTime;
    if IsGraphData(pTable)=True then
    Begin
     if nValid=True  then pTable.m_sMaskReRead := pTable.m_sMaskReRead or (nM shl m_nValIndex);
     if nValid=False then pTable.m_sMaskReRead := pTable.m_sMaskReRead and not(nM shl m_nValIndex);
     if nState=True  then pTable.m_sMaskRead   := pTable.m_sMaskRead or (nM shl m_nValIndex);
     if nState=False then pTable.m_sMaskRead   := pTable.m_sMaskRead and not(nM shl m_nValIndex);
     strSQL := 'UPDATE L2HALF_HOURLY_ENERGY SET'+
     ' M_SMASKREAD='+IntToStr(pTable.m_sMaskRead)+
     ',M_SMASKREREAD='+IntToStr(pTable.m_sMaskReRead)+
     ',v'+IntToStr(m_nValIndex)+'='+FloatToStr(dValue)+
     ' WHERE CAST(m_sdtDate AS DATE)='+''''+DateToStr(DateTime)+''''+
     ' and m_swVMID='+IntToStr(FMasterIndex)+
     ' and m_swCMDID='+IntToStr(FIndex);
     Result := ExecQryD(strSQL);
    End;
End;
{
L3PDTDATA_48 = packed record
     m_swID        : Integer;
     m_swVMID      : Integer;
     m_swCMDID     : Integer;
     m_sdtDate     : TDateTime;
     m_sMaskRead   : int64;
     v             : array[0..47] of Single;
    end;
}
function CDBase.SetDPSlice(DateTime:TDateTime;FMasterIndex,FIndex,m_nValIndex:Integer;dValue:Double;nValid,nState:Boolean):Boolean;
Var
    pTable : L3GRAPHDATA;
    strSQL : String;
    nM     : int64;
Begin
    nM := 1;
    pTable.m_swVMID  :=FMasterIndex;
    pTable.m_swCMDID :=FIndex;
    pTable.m_sdtDate :=DateTime;
    if IsPDTData_48(pTable)=True then
    Begin
     if nState=True  then pTable.m_sMaskRead   := pTable.m_sMaskRead or (nM shl m_nValIndex);
     if nState=False then pTable.m_sMaskRead   := pTable.m_sMaskRead and not(nM shl m_nValIndex);
     strSQL := 'UPDATE L3PDTDATA_48 SET'+
     ' M_SMASKREAD='+IntToStr(pTable.m_sMaskRead)+
     ',v'+IntToStr(m_nValIndex)+'='+FloatToStr(dValue)+
     ' WHERE CAST(m_sdtDate AS DATE)='+''''+DateToStr(DateTime)+''''+
     ' and m_swVMID='+IntToStr(FMasterIndex)+
     ' and m_swCMDID='+IntToStr(FIndex);
     Result := ExecQryD(strSQL);
    End;
End;
{
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
    if OpenQryD(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQryD;
    Result := res;
end;
}
function CDBase.SetArchSlice(DateTime:TDateTime;FMasterIndex,FIndex,nTID:Integer;dValue:Double;nValid,nState:Boolean):Boolean;
Var
    pTable : L3CURRENTDATA;
    strSQL : String;
    strTSQL : String;
Begin
    pTable.m_swVMID  := FMasterIndex;
    pTable.m_swCMDID := FIndex;
    pTable.m_swTID   := nTID;
    pTable.m_sTime   := DateTime;
    if (IsArchData(pTable)=True)or(nTID=-1) then
    Begin
     if nState=True  then pTable.M_SBYMASKREAD := 1;
     if nState=False then pTable.M_SBYMASKREAD := 0;
     if nState=True  then pTable.M_SBYMASKREREAD := 1;
     if nState=False then pTable.M_SBYMASKREREAD := 0;
     if nTID<>-1 then strTSQL := ' and m_swTID='+IntToStr(nTID)  else
     if nTID=-1 then  strTSQL := ' and m_swTID>=0 and m_swTID<=5';
     strSQL := 'UPDATE L3ARCHDATA SET'+
     ' M_SBYMASKREAD='+IntToStr(pTable.M_SBYMASKREAD)+
     ',M_SBYMASKREREAD='+IntToStr(pTable.M_SBYMASKREREAD)+
     ',m_sfValue='+FloatToStr(dValue)+
     ' WHERE CAST(m_sTime AS DATE)='+''''+DateToStr(DateTime)+''''+
     ' and m_swVMID='+IntToStr(FMasterIndex)+
     strTSQL+
     ' and m_swCMDID='+IntToStr(FIndex);
     Result := ExecQryD(strSQL);
    End;
End;

function CDBase.delArchSlice(DateTime:TDateTime;FMasterIndex,FIndex,nTID:Integer;dValue:Double;nValid,nState:Boolean):Boolean;
Var
    pTable : L3CURRENTDATA;
    strSQL : String;
    strTSQL : String;
Begin
    pTable.m_swVMID  := FMasterIndex;
    pTable.m_swCMDID := FIndex;
    pTable.m_swTID   := nTID;
    pTable.m_sTime   := DateTime;
    if (IsArchData(pTable)=True)or(nTID=-1) then
    Begin
     if nState=True  then pTable.M_SBYMASKREAD := 1;
     if nState=False then pTable.M_SBYMASKREAD := 0;
     if nState=True  then pTable.M_SBYMASKREREAD := 1;
     if nState=False then pTable.M_SBYMASKREREAD := 0;
     if nTID<>-1 then strTSQL := ' and m_swTID='+IntToStr(nTID)  else
     if nTID=-1 then  strTSQL := ' and m_swTID>=0 and m_swTID<=5';
     strSQL := 'delete from L3ARCHDATA '+
     ' WHERE CAST(m_sTime AS DATE)='+''''+DateToStr(DateTime)+''''+
     ' and m_swVMID='+IntToStr(FMasterIndex)+
     strTSQL+
     ' and m_swCMDID='+IntToStr(FIndex);
     Result := ExecQryD(strSQL);
    End;
End;


{procedure CDBase.DeleteEventsSl(Count:integer);
var
   minID, cntEv, nCount : integer;
   strSQL               : string;
begin
    strSQL := 'SELECT count(m_swID) as cnt, min(m_swID) as minID FROM SEVENTTTAG';
    if OpenQryD(strSQL,nCount)=True then
    Begin
     minID := FADOQueryD.FieldByName('minID').AsInteger;
     cntEv := FADOQueryD.FieldByName('cnt').AsInteger;
    end
    else
    begin
     minID := 0;
     cntEv := 0;
    end;
    CloseQryD;

    strSQL := 'DELETE FROM SEVENTTTAG WHERE m_swID <= '+IntToStr(minID+cntEv-Count);
    ExecQryD(strSQL);
end; }

{
 QRY_NAK_EN_MONTH_EP   = 21;//43
  QRY_NAK_EN_MONTH_EM   = 22;
  QRY_NAK_EN_MONTH_RP   = 23;
  QRY_NAK_EN_MONTH_RM   = 24;

  QRY_ENERGY_MON_EP     = 9;//3
  QRY_ENERGY_MON_EM     = 10;
  QRY_ENERGY_MON_RP     = 11;
  QRY_ENERGY_MON_RM     = 12;
}

function CDBase.DelSlices(MonthN : integer):Boolean;
Var
    strSQL                           : String;
    FirstCMDID,LastCMDID             : Integer;
    TempDate,TempDate0,TempDate1     : TDateTime;
    tDateForMonth                    : TDateTime;
    i                                : integer;
Begin
    TempDate  := Now;
    TempDate0 := Now;
    //TempDate1 := Now-m_nMaxDayNetParam;
    TempDate1 := Now-30;
    tDateForMonth := Now - 365;
    tDateForMonth := cDateTimeR.GetBeginMonth(tDateForMonth);
    for i := 0 to MonthN * 31 do cDateTimeR.DecDate(TempDate);

    strSQL := 'DELETE FROM L2HALF_HOURLY_ENERGY WHERE CAST(m_sdtDate AS DATE) <= ' + '''' + DateToStr(TempDate) + '''';
    Result := ExecQryD(strSQL);
///
    strSQL := 'DELETE FROM L3ARCHDATA WHERE not ((m_swCMDID >=' + IntToStr(QRY_ENERGY_MON_EP) +
              ' and m_swCMDID <=' + IntToStr(QRY_ENERGY_MON_RM) + ')' +
              ' or (m_swCMDID >=' + IntToStr(QRY_NAK_EN_MONTH_EP) +
              ' and m_swCMDID <=' + IntToStr(QRY_NAK_EN_MONTH_RM) + '))' +
              ' and (CAST(m_sTime AS DATE) <= ' + '''' + DateToStr(TempDate) + ''''+')';
    Result := ExecQryD(strSQL);
    strSQL := 'DELETE FROM L3ARCHDATA WHERE ((m_swCMDID >=' + IntToStr(QRY_ENERGY_MON_EP) +
              ' and m_swCMDID <=' + IntToStr(QRY_ENERGY_MON_RM) + ')' +
              ' or (m_swCMDID >=' + IntToStr(QRY_NAK_EN_MONTH_EP) +
              ' and m_swCMDID <=' + IntToStr(QRY_NAK_EN_MONTH_RM) + '))' +
              ' and (CAST(m_sTime AS DATE) < ' + '''' + DateToStr(tDateForMonth) + ''''+')';
    Result := ExecQryD(strSQL);

///
    cDateTimeR.DecMonth(TempDate0);
    strSQL := 'DELETE FROM L3PDTDATA WHERE (CAST(m_sTime AS DATE) <= ' + '''' + DateToStr(TempDate0) + ''''+')';
    Result := ExecQryD(strSQL);

    strSQL := 'DELETE FROM L3PDTDATA_48 WHERE (CAST(m_sdtDate AS DATE) <= ' + '''' + DateToStr(TempDate1) + ''''+')';
    Result := ExecQryD(strSQL);

//    DeleteEventsSl(m_nCountOfEvents);

{    strSQL := 'DELETE FROM SEVENTTTAG WHERE (CAST(M_SDTEVENTTIME AS DATE) <= ' + '''' + DateToStr(TempDate0) + ''''+')';
    Result := ExecQryD(strSQL); }

    strSQL := 'DELETE FROM VAL WHERE CAST(data AS DATE) <= ' + '''' + DateToStr(TempDate) + '''';
    Result := ExecQryD(strSQL);

    //strSQL := 'DELETE FROM BUF_V_INT WHERE CAST(DD_MM_YYYY AS DATE) <= ' + '''' + DateToStr(TempDate) + '''';
    //Result := ExecQryD(strSQL);
End;
procedure CDBase.FreeBase(MonthN : integer);
Var
    TempDate : TDateTime;
    i        : integer;
    strSQL   : String;
Begin
    TempDate := Now;
    cDateTimeR.DecDate(TempDate);

    TempDate := Now;
    for i := 0 to MonthN * 31 do cDateTimeR.DecDate(TempDate);

    strSQL := 'DELETE FROM L2HALF_HOURLY_ENERGY WHERE CAST(m_sdtDate AS DATE) <= ' + '''' + DateToStr(TempDate) + '''';
    ExecQryD(strSQL);

    strSQL := 'DELETE FROM L3ARCHDATA WHERE (CAST(m_sTime AS DATE) <= ' + '''' + DateToStr(TempDate) + ''''+')';
    ExecQryD(strSQL);
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
             'delete  from sl2uspdcharactkanal where m_swUSPDID =' + IntToStr(AdrUSPD) + ';' +
             'delete  from sl2uspdcharactgr; end';
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

function CDBase.AddUSPDCharGr(var pTable : SL2USPDCHARACTGR):Boolean;
var strSQL : string;
begin
   if not IsUSPDCharGr(pTable) then
   begin
     with pTable do
     strSQL := 'INSERT INTO SL2USPDCHARACTGR '+
               '(M_SWGRID, M_SVMETERS, m_sGroupName)'+ ' VALUES(' +
               IntToStr(m_swGrID) + ',' + '''' + m_sVMeters + ''''
               + ',' + '''' + m_sGroupName + '''' + ')';

     Result := ExecQry(strSQL);
   end
   else
     Result := UpdateUSPDCharGr(pTable);
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

function CDBase.IsUSPDCharGr(var pTable : SL2USPDCHARACTGR):Boolean;
var strSQL : string;
    nCount : integer;
begin
   strSQL := 'SELECT 0 FROM SL2USPDCHARACTGR WHERE m_swGrID = ' + IntToStr(pTable.m_swGrID);
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

function CDBase.UpdateUSPDCharGr(var pTable : SL2USPDCHARACTGR):Boolean;
var strSQL : string;
begin
   with pTable do
   begin
     strSQL := 'UPDATE SL2USPDCHARACTGR SET' +
               ' ,m_sVMeters=' + '''' + m_sVMeters + '''' +
               ' ,m_sGroupName=' + '''' + m_sGroupName + '''' +
               ' where m_swGrID = ' + IntToStr(m_swGrID);
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
              IntToStr(AdrUSPD) + ' ORDER BY M_SWMID';
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
       pTable.Items[i].m_sfKtr       := FADOQuery.FieldByName('m_sfKtr').AsFloat;
       FADOQuery.Next;
       Inc(i);
     End;
   End;
   CloseQry;
   Result := res;
end;

function CDBase.ReadUSPDCharGr(var pTable:SL2USPDCHARACTGRLIST): boolean;
var strSQL    : string;
    nCount, i : integer;
    res       : boolean;
begin
   strSQL       := 'SELECT * FROM SL2USPDCHARACTGR';
   res          := False;
   pTable.Count := 0;
   if OpenQry(strSQL,nCount)=True then
   Begin
     i            := 0;
     res          := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do
     Begin
       pTable.Items[i].m_swGrID        := FADOQuery.FieldByName('m_swGrID').AsInteger;
       pTable.Items[i].m_sVMeters      := FADOQuery.FieldByName('m_sVMeters').AsString;
       pTable.Items[i].m_sGroupName    := FADOQuery.FieldByName('m_sGroupName').AsString;
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
              'm_sbyRepMsg,m_swRepTime,m_sfKI,m_sfKU,m_sfMeterKoeff,m_sbyPrecision,'+
              'm_swCurrQryTm,m_sPhone,m_sbyModem,m_sbyEnable,' +
              'm_swMinNKan, m_swMaxNKan, m_sdtSumKor, m_sdtLimKor, m_sdtPhLimKor,m_sAdvDiscL2Tag, m_sbyStBlock,m_swKE)'+
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
              IntToStr(m_sbyPrecision)+ ','+
              IntToStr(m_swCurrQryTm)+ ','+
              ''''+m_sPhone +''''+ ','+
              IntToStr(m_sbyModem)+ ',' +
              IntToStr(m_sbyEnable)+ ',' +
              IntToStr(m_swMinNKan) + ',' +
              IntToStr(m_swMaxNKan) + ',' +
              '''' + DateTimeToStr(m_sdtSumKor) + '''' + ',' +
              '''' + DateTimeToStr(m_sdtLimKor) + '''' + ',' +
              '''' + DateTimeToStr(m_sdtPhLimKor) + '''' + ',' +
              '''' + m_sAdvDiscL2Tag + '''' +  ',' +
              IntToStr(m_sbyStBlock) + ',' +
              IntToStr(0) +
              ')';
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
              ',m_sbyPrecizion=' +IntToStr(m_sbyPrecision)+
              ',m_swCurrQryTm=' +IntToStr(m_swCurrQryTm)+
              ',m_sPhone='      +''''+m_sPhone+''''+
              ',m_sbyModem='    +IntToStr(m_sbyModem)+
              ',m_sbyEnable='   +IntToStr(m_sbyEnable)+
              ',m_swMinNKan='   +IntToStr(m_swMinNKan) +
              ',m_swMaxNKan='   +IntToStr(m_swMaxNKan) +
              ',m_sAdvDiscL2Tag='+'''' + m_sAdvDiscL2Tag +
              ',m_sbyStBlock='  + IntToStr(m_sbyStBlock)+
              ',m_sTariffs='    +'''' + m_sTariffs + 
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
var strSQL        : string;
    nCount, i     : integer;
    res           : boolean;
begin
   res    := false;
   strSQL := 'SELECT m_swVMID, m_sMeterName FROM SL3VMETERTAG, SL3GROUPTAG' +
             ' WHERE m_sGroupName =' + '''' + 'Энергосбыт' + ''''+
             ' AND SL3VMETERTAG.m_sbygroupid = SL3GROUPTAG.m_sbygroupid ORDER BY m_swVMID';
   pTable.Count := 0;
   if OpenQry(strSQL,nCount)=True then
   begin
     i := 0;
     res := True;
     pTable.Count := nCount;
     SetLength(pTable.m_sMeter,nCount);
     while not FADOQuery.Eof do Begin
       with FADOQuery, pTable.m_sMeter[i] do  Begin
        m_swVMID      := FieldByName('m_swVMID').AsInteger + 1;
        m_sVMeterName := FieldByName('m_sMeterName').AsString;
        if Length(m_sVMeterName) > 27 then
          SetLength(m_sVMeterName, 27);
        Next;
        Inc(i);
       End;
     End;
   end;
   CloseQry;
   Result := res;
end;

function CDBase.ReadUSPDDevCFG(IsMSGOur :boolean; var pTable : SL2USPDEVLISTEX) : boolean;
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
         m_swIdev := FieldByName('m_swType').AsInteger + 1;
         m_sName  := FieldByName('m_sName').AsString;
         if (Length(m_sName) > 31) and (not IsMSGOur) then
           SetLength(m_sName, 31);
         Inc(i);
         Next;
       end;
   end;
   CloseQry();
   Result := res;
end;

function CDBase.ReadUSPDCharDevCFG(IsMSGOur :boolean;var pTable : SL2USPDCHARACTDEVLISTEX) : boolean;
var strSQL    : string;
    nCount, i : integer;
    res       : boolean;
begin
   res    := false;
   i      := 0;
   strSQL := 'SELECT sl3vmetertag.m_sbyType, sl3vmetertag.m_swVMID, sl3vmetertag.m_sddPHAddres,' +
             ' sl3vmetertag.m_svMeterName, l2tag.m_sfki, l2tag.m_sfku, l2tag.m_sddfabnum' +
             ' FROM sl3vmetertag, l2tag' +
             ' where l2tag.m_swmid = sl3vmetertag.m_swmid ORDER BY sl3vmetertag.m_swVMID';
   if OpenQry(strSQL, nCount) then
   begin
     res := true;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
       with FADOQuery, pTable.Items[i] do
       begin
         m_swNDev      := FieldByName('m_swVMID').AsInteger + 1;
         m_swIDev      := FieldByName('m_sbyType').AsInteger + 1;
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
         if (Length(m_sStrAdr) > 31) and (not IsMSGOur) then
           SetLength(m_sStrAdr, 31);
         Next;
         Inc(i);
       end;
   end;
   CloseQry();
   Result := res;
end;

function CDBase.LoadReportParams(nAbon:Integer;var pTable : REPORT_F1):boolean;
Var
    strSQL   : String;
    nCount   : integer;
    res      : boolean;
begin
   strSQL := 'SELECT * FROM REPORT_F1 WHERE m_swABOID='+IntToStr(nAbon);
   res := False;
   if OpenQry(strSQL,nCount)=True then
   Begin
    pTable.m_swID         := FADOQuery.FieldByName('m_swID').AsInteger;
    pTable.m_swABOID      := FADOQuery.FieldByName('m_swABOID').AsInteger;
    pTable.m_sWorkName    := FADOQuery.FieldByName('m_sWorkName').AsString;
    pTable.m_sFirstSign   := FADOQuery.FieldByName('m_sFirstSign').AsString;
    pTable.m_sSecondSign  := FADOQuery.FieldByName('m_sSecondSign').AsString;
    pTable.m_sThirdSign   := FADOQuery.FieldByName('m_sThirdSign').AsString;
    pTable.m_swColorCol   := FADOQuery.FieldByName('m_swColorCol').AsInteger;
    pTable.m_swColorRow   := FADOQuery.FieldByName('m_swColorRow').AsInteger;
    pTable.m_sTelephon    := FADOQuery.FieldByName('M_STELEPHON').AsString;
    pTable.m_sEMail       := FADOQuery.FieldByName('M_SEMAIL').AsString;
    pTable.m_sNDogovor    := FADOQuery.FieldByName('m_sNDogovor').AsString;
    pTable.m_sAdress      := FADOQuery.FieldByName('m_sAdress').AsString;
    pTable.m_sNameObject  := FADOQuery.FieldByName('m_sNameObject').AsString;
    pTable.m_strObjCode   := FADOQuery.FieldByName('m_strObjCode').AsString;
    pTable.m_sbyIsReadZerT:= FADOQuery.FieldByName('m_sbyIsReadZerT').AsInteger;
    pTable.ABO            := FADOQuery.FieldByName('ABO').AsInteger;
    pTable.KSP            := FADOQuery.FieldByName('KSP').AsString;
    res := True;
   End;
   CloseQry;
   Result := res;
end;
function CDBase.IsReprtParm(var pTable:REPORT_F1):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    strSQL := 'SELECT 0 FROM REPORT_F1 WHERE m_swABOID='+IntToStr(pTable.m_swABOID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.AddReportParams(var pTable:REPORT_F1):boolean;
Var
    strSQL   : String;
Begin
    if IsReprtParm(pTable) then begin UpdateReportParams(pTable);Result:=false;exit;end;
    with pTable do
    Begin
    strSQL := 'INSERT INTO REPORT_F1'+
              '(m_sWorkName,m_sFirstSign,m_sSecondSign,m_sThirdSign,m_swColorCol,m_swColorRow,'+
              'm_sbyIsReadZerT,M_STELEPHON,M_SEMAIL,m_sNDogovor,'+
              'm_sAdress,m_sNameObject,m_strObjCode,ABO,m_swABOID,KSP)'+
              ' VALUES('+
              ''''+m_sWorkName +''''+','+
              ''''+m_sFirstSign +''''+','+
              ''''+m_sSecondSign +''''+','+
              ''''+m_sThirdSign     +''''+','+
              IntToStr(m_swColorCol)+ ','+
              IntToStr(m_swColorRow)+ ','+
              IntToStr(m_sbyIsReadZerT)+ ','+
              ''''+M_STELEPHON +''''+','+
              ''''+M_SEMAIL +''''+','+
              ''''+m_sNDogovor +''''+','+
              ''''+m_sAdress     +''''+','+
              ''''+m_sNameObject     +''''+','+
              ''''+m_strObjCode     +''''+','+
              IntToStr(ABO)+ ',' +
              IntToStr(m_swABOID)+ ',' +
              ''''+KSP +''''+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.UpdateReportParams(var pTable : REPORT_F1):boolean;
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
                 ' ,m_sbyIsReadZerT = ' + IntToStr(m_sbyIsReadZerT) +
                 ' ,M_STELEPHON = ' + '''' + m_sTelephon + '''' +
                 ' ,M_SEMAIL = ' + '''' + m_sEMail + ''''+
                 ' ,m_sNDogovor = ' + '''' + m_sNDogovor + '''' +
                  ' ,m_sAdress = ' + '''' + m_sAdress + '''' +
                 ' ,m_sNameObject = ' + '''' + m_sNameObject + '''' +
                 ' ,m_strObjCode = ' + '''' + m_strObjCode + '''' +
                 ' ,ABO = ' + IntToStr(ABO) +
                 ' ,m_swABOID='+IntToStr(pTable.m_swABOID)+
                 ' ,KSP = ' + '''' + KSP + '''' +
                 ' WHERE m_swABOID='+IntToStr(pTable.m_swABOID);
    end;
    Result := ExecQry(strSQL);
end;


function CDBase.OpenQry(strSQL:String;var nCount:Integer):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
  if m_blIsConnect=False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQuery.Transaction.Active then
      FADOQuery.Transaction.StartTransaction;
    iQ := Integer(FADOQuery);
    iT := Integer(FADOQuery.Transaction);
     FADOQuery.SQL.Clear;
     FADOQuery.SQL.Add(strSQL);
     FADOQuery.Open;
     FADOQuery.FetchAll;
    FADOQuery.Transaction.CommitRetaining;
    if FADOQuery.RecordCount>0 then Begin
      nCount := FADOQuery.RecordCount;
      res := True;
    End;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.OpenQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQuery.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQuery.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;

function CDBase.OpenQryD(strSQL:String;var nCount:Integer):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
  if m_blIsConnect=False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQueryD.Transaction.Active then
      FADOQueryD.Transaction.StartTransaction;
    iQ := Integer(FADOQueryD);
    iT := Integer(FADOQueryD.Transaction);
     FADOQueryD.SQL.Clear;
     FADOQueryD.SQL.Add(strSQL);
     FADOQueryD.Open;
     FADOQueryD.FetchAll;
    FADOQueryD.Transaction.CommitRetaining;
    if FADOQueryD.RecordCount>0 then Begin
      nCount := FADOQueryD.RecordCount;
      res := True;
    End;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.OpenQryD: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryD = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryD.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryD.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;

function CDBase.OpenQryD1(strSQL:String;var nCount:Integer):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
  if m_blIsConnect=False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQueryD1.Transaction.Active then
      FADOQueryD1.Transaction.StartTransaction;
    iQ := Integer(FADOQueryD1);
    iT := Integer(FADOQueryD1.Transaction);
     FADOQueryD1.SQL.Clear;
     FADOQueryD1.SQL.Add(strSQL);
     FADOQueryD1.Open;
     FADOQueryD1.FetchAll;
    FADOQueryD1.Transaction.CommitRetaining;
    if FADOQueryD1.RecordCount>0 then Begin
      nCount := FADOQueryD1.RecordCount;
      res := True;
    End;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.OpenQryD1: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryD1 = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryD1.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryD1.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;

function CDBase.OpenQryD2(strSQL:String;var nCount:Integer):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
  if m_blIsConnect=False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQueryD2.Transaction.Active then
      FADOQueryD2.Transaction.StartTransaction;
    iQ := Integer(FADOQueryD2);
    iT := Integer(FADOQueryD2.Transaction);
     FADOQueryD2.SQL.Clear;
     FADOQueryD2.SQL.Add(strSQL);
     FADOQueryD2.Open;
     FADOQueryD2.FetchAll;
    FADOQueryD2.Transaction.CommitRetaining;
    if FADOQueryD2.RecordCount>0 then Begin
      nCount := FADOQueryD2.RecordCount;
      res := True;
    End;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.OpenQryD2: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryD2 = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryD2.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryD2.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;

function CDBase.OpenQrySA(strSQL:String;var nCount:Integer):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
  if m_blIsConnect=False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQuerySA.Transaction.Active then
      FADOQuerySA.Transaction.StartTransaction;
    iQ := Integer(FADOQuerySA);
    iT := Integer(FADOQuerySA.Transaction);
     FADOQuerySA.SQL.Clear;
     FADOQuerySA.SQL.Add(strSQL);
     FADOQuerySA.Open;
     FADOQuerySA.FetchAll;
    FADOQuerySA.Transaction.CommitRetaining;
    if FADOQuerySA.RecordCount>0 then Begin
      nCount := FADOQuerySA.RecordCount;
      res := True;
    End;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.OpenQrySA: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQuerySA = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQuerySA.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQuerySA.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;

function CDBase.OpenQryBTI(strSQL:String;var nCount:Integer):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
  if m_blIsConnect=False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQueryBTI.Transaction.Active then
      FADOQueryBTI.Transaction.StartTransaction;
    iQ := Integer(FADOQueryBTI);
    iT := Integer(FADOQueryBTI.Transaction);
     FADOQueryBTI.SQL.Clear;
     FADOQueryBTI.SQL.Add(strSQL);
     FADOQueryBTI.Open;
     FADOQueryBTI.FetchAll;
    FADOQueryBTI.Transaction.CommitRetaining;
    if FADOQueryBTI.RecordCount>0 then Begin
      nCount := FADOQueryBTI.RecordCount;
      res := True;
    End;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.OpenQryBTI: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryBTI = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryBTI.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryBTI.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;


function CDBase.OpenQryDBF(strSQL:String;var nCount:Integer):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
  if m_blIsConnect = False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQueryDBF.Transaction.Active then
      FADOQueryDBF.Transaction.StartTransaction;
    iQ := Integer(FADOQueryDBF);
    iT := Integer(FADOQueryDBF.Transaction);
     FADOQueryDBF.SQL.Clear;
     FADOQueryDBF.SQL.Add(strSQL);
     FADOQueryDBF.Open;
     FADOQueryDBF.FetchAll;
    FADOQueryDBF.Transaction.CommitRetaining;
    if FADOQueryDBF.RecordCount>0 then Begin
      nCount := FADOQueryDBF.RecordCount;
      res := True;
    End;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.OpenQryDBF: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryDBF = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryDBF.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryDBF.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;

procedure CDBase.CloseQry;
Begin
  if m_blIsConnect=False then exit;
  if m_blIsBackUp=True then exit;
  FADOQuery.SQL.Clear;
  FADOQuery.Close;
End;

procedure CDBase.CloseQryD;
Begin
  if m_blIsConnect=False then exit;
  if m_blIsBackUp=True then exit;
  FADOQueryD.SQL.Clear;
  FADOQueryD.Close;
End;


procedure CDBase.CloseQryD1;
Begin
  if m_blIsConnect=False then exit;
  if m_blIsBackUp=True then exit;
  FADOQueryD1.SQL.Clear;
  FADOQueryD1.Close;
End;

procedure CDBase.CloseQryD2;
Begin
  if m_blIsConnect=False then exit;
  if m_blIsBackUp=True then exit;
  FADOQueryD2.SQL.Clear;
  FADOQueryD2.Close;
End;

procedure CDBase.CloseQrySA;
Begin
  if m_blIsConnect=False then exit;
  if m_blIsBackUp=True then exit;
  FADOQuerySA.SQL.Clear;
  FADOQuerySA.Close;
End;

procedure CDBase.CloseQryBTI;
Begin
  if m_blIsConnect=False then exit;
  if m_blIsBackUp=True then exit;
  FADOQueryBTI.SQL.Clear;
  FADOQueryBTI.Close;
End;

procedure CDBase.CloseQryDBF;
Begin
  if m_blIsConnect=False then exit;
  if m_blIsBackUp=True then exit;
  FADOQueryDBF.SQL.Clear;
  FADOQueryDBF.Close;
End;


function CDBase.ExecQryMySql(strSQL:String):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
  res := False;
  if m_blIsBackUp=True then exit;
  if m_blIsConnect = False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQueryMySQL.Transaction.Active then
      FADOQueryMySQL.Transaction.StartTransaction;
    iQ := Integer(FADOQueryMySQL);
    iT := Integer(FADOQueryMySQL.Transaction);
    FADOQueryMySQL.Close;
    FADOQueryMySQL.SQL.Clear;
    FADOQueryMySQL.SQL.Add(strSQL);
    FADOQueryMySQL.ExecSQL;
    FADOQueryMySQL.Close;
    FADOQueryMySQL.SQL.Clear;
    FADOQueryMySQL.Transaction.Commit;
    res := True;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.ExecQryMySql: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'ExecQryMySql = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'ExecQryMySql.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
    FADOQueryMySQL.Transaction.Rollback;
    res := False;
   end;
  end;
  Result := res;
End;

function CDBase.ExecQry(strSQL:String):Boolean;
Var res : Boolean;
    iQ, iT : Integer;
Begin
  res := False;
  if m_blIsBackUp=True then exit;
  if m_blIsConnect = False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQuery.Transaction.Active then
      FADOQuery.Transaction.StartTransaction;
    iQ := Integer(FADOQuery);
    iT := Integer(FADOQuery.Transaction);
    FADOQuery.Close;
    FADOQuery.SQL.Clear;
    FADOQuery.SQL.Add(strSQL);
    FADOQuery.ExecSQL;
    FADOQuery.Close;
    FADOQuery.SQL.Clear;
    FADOQuery.Transaction.Commit;
    res := True;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.ExecQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQuery.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQuery.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;

function CDBase.ExecQryD(strSQL:String):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
  res := False;
  if m_blIsBackUp=True then exit;
  if m_blIsConnect = False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQueryD.Transaction.Active then
      FADOQueryD.Transaction.StartTransaction;
    iQ := Integer(FADOQueryD);
    iT := Integer(FADOQueryD.Transaction);
     FADOQueryD.Close;
     FADOQueryD.SQL.Clear;
     FADOQueryD.SQL.Add(strSQL);
     FADOQueryD.ExecSQL;
     FADOQueryD.Close;
    FADOQueryD.SQL.Clear;
    FADOQueryD.Transaction.Commit;
    res := True;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.ExecQryD: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryD = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryD.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryD.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;

function CDBase.ExecQryD1(strSQL:String):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
  res := False;
  if m_blIsBackUp=True then exit;
  if m_blIsConnect = False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQueryD1.Transaction.Active then
      FADOQueryD1.Transaction.StartTransaction;
    iQ := Integer(FADOQueryD1);
    iT := Integer(FADOQueryD1.Transaction);
     FADOQueryD1.Close;
     FADOQueryD1.SQL.Clear;
     FADOQueryD1.SQL.Add(strSQL);
     FADOQueryD1.ExecSQL;
     FADOQueryD1.Close;
    FADOQueryD1.SQL.Clear;
    FADOQueryD1.Transaction.Commit;
    res := True;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.ExecQryD1: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryD1 = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryD1.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryD1.Transaction.Rollback;
      res := False;
    end;
  end;
   Result := res;
End;

function CDBase.ExecQryD2(strSQL:String):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
  res := False;
  if m_blIsBackUp=True then exit;
  if m_blIsConnect = False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQueryD2.Transaction.Active then
      FADOQueryD2.Transaction.StartTransaction;
    iQ := Integer(FADOQueryD2);
    iT := Integer(FADOQueryD2.Transaction);
     FADOQueryD2.Close;
     FADOQueryD2.SQL.Clear;
     FADOQueryD2.SQL.Add(strSQL);
     FADOQueryD2.ExecSQL;
     FADOQueryD2.Close;
    FADOQueryD2.SQL.Clear;
    FADOQueryD2.Transaction.Commit;
    res := True;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.ExecQryD2: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryD2 = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryD2.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryD2.Transaction.Rollback;
      res := False;
    end;
   end;
  Result := res;
End;

function CDBase.ExecQrySA(strSQL:String):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
  res := False;
  if m_blIsBackUp=True then exit;
  if m_blIsConnect = False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQuerySA.Transaction.Active then
      FADOQuerySA.Transaction.StartTransaction;
    iQ := Integer(FADOQuerySA);
    iT := Integer(FADOQuerySA.Transaction);
     FADOQuerySA.Close;
     FADOQuerySA.SQL.Clear;
     FADOQuerySA.SQL.Add(strSQL);
     FADOQuerySA.ExecSQL;
     FADOQuerySA.Close;
    FADOQuerySA.SQL.Clear;
    FADOQuerySA.Transaction.Commit;
    res := True;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.ExecQrySA: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQuerySA = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQuerySA.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQuerySA.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;

function CDBase.ExecQryBTI(strSQL:String):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
  res := False;
  if m_blIsBackUp=True then exit;
  if m_blIsConnect = False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQueryBTI.Transaction.Active then
      FADOQueryBTI.Transaction.StartTransaction;
    iQ := Integer(FADOQueryBTI);
    iT := Integer(FADOQueryBTI.Transaction);
     FADOQueryBTI.Close;
     FADOQueryBTI.SQL.Clear;
     FADOQueryBTI.SQL.Add(strSQL);
     FADOQueryBTI.ExecSQL;
     FADOQueryBTI.Close;
    FADOQueryBTI.SQL.Clear;
    FADOQueryBTI.Transaction.Commit;
    res := True;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.ExecQryBTI: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryBTI = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryBTI.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryBTI.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;

function CDBase.ExecQryDBF(strSQL:String):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
  res := False;
  if m_blIsBackUp=True then exit;
  if m_blIsConnect = False then Begin
    Result := False;
    exit;
  End;
  try
    if not FADOQueryDBF.Transaction.Active then
      FADOQueryDBF.Transaction.StartTransaction;
    iQ := Integer(FADOQueryDBF);
    iT := Integer(FADOQueryDBF.Transaction);
     FADOQueryDBF.Close;
     FADOQueryDBF.SQL.Clear;
     FADOQueryDBF.SQL.Add(strSQL);
     FADOQueryDBF.ExecSQL;
     FADOQueryDBF.Close;
    FADOQueryDBF.SQL.Clear;
    FADOQueryDBF.Transaction.Commit;
    res := True;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.ExecQryDBF: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryDBF = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryDBF.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryDBF.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;


function CDBase.GetL3Table(var pTable:SL3INITTAG):Boolean;
Var
     j,i : Integer;
Begin
     //Объекты наблюдения
     pTable.m_sbyLayerID := 3;
     pTable.Count  := 8;
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
    iQ, iT : Integer;
Begin
  res := True;
  try
    if not FqryReport.Transaction.Active then
      FqryReport.Transaction.StartTransaction;
    iQ := Integer(FqryReport);
    iT := Integer(FqryReport.Transaction);
      FqryReport.Close;
      FqryReport.SQL.Text := strSQL;
      FqryReport.ExecSQL;
      FqryReport.Close;
     FqryReport.SQL.Clear;
    FqryReport.Transaction.Commit;
    res := True;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.FqryReport: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FqryReport = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FqryReport.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FqryReport.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
End;

function  CDBase.OpenQryR(strSQL:String;var nCount:Integer):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
begin
  res    := False;
  nCount := 0;
  try
    if not FqryReport.Transaction.Active then
      FqryReport.Transaction.StartTransaction;
    iQ := Integer(FqryReport);
    iT := Integer(FqryReport.Transaction);
    FqryReport.SQL.Clear;
     FqryReport.SQL.Add(strSQL);
     FqryReport.Open;
    FqryReport.FetchAll;
    FqryReport.Transaction.CommitRetaining;
     if FqryReport.RecordCount>0 then Begin
        nCount := FqryReport.RecordCount;
        res := True;
        End;
    except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.FqryReport: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FqryReport = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FqryReport.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FqryReport.Transaction.Rollback;
      res := False;
    end;
  end;
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
    GetTMTarifsTable(0,0,0,pTable);
    for zoneIndex := 0 to pTable.Count-1 do begin
       with pTable do begin
          GetTMTarPeriodsTable(-1,Items[zoneIndex].m_swTTID,TarifTable);
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
       strSQL := 'SELECT m_sTime,m_sfValue,m_swTID,m_CRC'+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime'
     else
       strSQL := 'SELECT m_sTime,m_sfValue,m_swTID,m_CRC'+
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
      m_CRC        := FieldByName('m_CRC').AsInteger;
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
      m_CRC          := FieldByName('m_CRC').AsInteger;
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
      m_CRC     := FieldByName('m_CRC').AsInteger;
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
      m_CRC     := FieldByName('m_CRC').AsInteger;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryBTI;
    Result := res;
End;
function CDBase.InitMySQL(strDSN : String) : boolean;
begin
    m_sMySQLConnStr := strDSN;
    result := true;
end;

{
    Подключение к серверу MySQL
}
function CDBase.ConnectMySQL() : boolean;
Var IBTr : TIBTransaction;
begin
  result := true;
  if FADOConnectionMySQL = Nil then Begin
      FADOConnectionMySQL := TIBDataBase.Create(nil);
      IBTr := TIBTransaction.Create(nil);
    IBTr := TIBTransaction.Create(nil);
    IBTr.Params.Add('read_committed');
    IBTr.Params.Add('rec_version');
    IBTr.Params.Add('wait');
      with FADOConnectionMySQL do begin
       DatabaseName := m_sMySQLConnStr;
       Params.Add('user_name=sysdba');
       Params.Add('password=masterkey');
       Params.Add('lc_ctype=WIN1251');
       LoginPrompt := False;
       DefaultTransaction := IBTr;
      end;
      FADOConnectionMySQL.Connected        := true;
    if FADOQueryMySQL=Nil then Begin
      FADOQueryMySQL := TIBQuery.Create(Nil);
      FADOQueryMySQL.Transaction:=IBTr;
      FADOQueryMySQL.Database:=FADOConnectionMySQL;
     End;
    End;
end;

{
    Отключение от сервера MySQL
}
function CDBase.DisconnectMySQL() : boolean;
Var IBTr : TIBTransaction;
begin
  result := false;            { TODO -oBO -cИнф : Входит сюда в момент загрузки программы }
  if FADOConnectionMySQL <> Nil then Begin
    IBTr := FADOQueryMySQL.Transaction;
    FreeAndNil(FADOConnectionMySQL);
    if FADOQueryMySQL <> Nil then FreeAndNil(FADOQueryMySQL);
    if IBTr <> Nil then FreeAndNil(IBTr);
    End;
end;

function CDBase.MySQLStat(var res : TStringList) : Boolean;
begin
  try
    FADOQueryMySQL.SQL.Add('SHOW STATUS;');
    FADOQueryMySQL.Open;

    while (not FADOQueryMySQL.Eof) do
        with FADOQueryMySQL do
        begin
            res.Add(FieldByName('Variable_name').AsString + ' = ' + FieldByName('Value').AsString);
            Next;
        end;

    FADOQueryMySQL.Close;
    FADOQueryMySQL.SQL.Clear;
    Result := true;
    exit;
  except
    FADOQueryMySQL.Close;
    FADOQueryMySQL.SQL.Clear;
    res.Add('Error catched!');
  end;

  Result := false;
end;

function CDBase.MyPing(var d : TDateTime) : Boolean;
begin
    Result := true;
    FADOQueryMySQL.SQL.Clear;
    FADOQueryMySQL.SQL.Add('SELECT NOW() d;');
    FADOQueryMySQL.Open();

    try
    d := FADOQueryMySQL.FieldByName('d').AsDateTime;
    except
        Result := false;
    end;

    FADOQueryMySQL.Close;
end;

function CDBase.MyInsertABO(_AboID : Integer; _Name,_KSP,_DogNum : String): Integer;
var
    qstr : String;
begin
    FADOQueryMySQL.SQL.Clear;
    qstr := 'INSERT IGNORE INTO ABON(ABO,NM_ABO,KSP,NOM_DOGWR) VALUES(' +
             IntToStr(_AboID) + ', ' +
             '"' + _Name + '", ' +
             '"' + _KSP + '", ' +
             '"' + _DogNum + '")';
    try
    FADOQueryMySQL.SQL.Add(qstr);
    FADOQueryMySQL.ExecSQL;
    Result := 1;
    except
    Result := -1;
    end;
    FADOQueryMySQL.Close;
end;



function CDBase.MyGetAbonVMetersTable(nAbon,nChannel:Integer;var pTable:SL3MYGROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nChannel<>-1 then strSQL := 'SELECT SL3VMETERTAG.M_SBYPORTID,SL3VMETERTAG.M_SWMID,SL3VMETERTAG.M_SWVMID,L2TAG.m_sddFabNum,SL3VMETERTAG.M_SVMETERNAME,SL3VMETERTAG.M_SBYTYPE,(L2TAG.M_SFKI*L2TAG.M_SFKU) AS m_sfKTR FROM SL3VMETERTAG,SL3GROUPTAG,L2TAG'+
                                   ' WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
                                   ' and SL3GROUPTAG.m_sbyGroupID='+IntToStr(nChannel)+
                                   ' and L2TAG.M_SWMID=SL3VMETERTAG.M_SWMID'+
                                   ' and SL3VMETERTAG.m_sbyEnable=1 '+
                                   ' and (SL3GROUPTAG.M_NGROUPLV=0 or SL3GROUPTAG.M_NGROUPLV=2) '+
                                   ' ORDER BY m_swVMID';
    if nChannel=-1  then strSQL := 'SELECT SL3VMETERTAG.M_SBYPORTID,SL3VMETERTAG.M_SWMID,SL3VMETERTAG.M_SWVMID,L2TAG.m_sddFabNum,SL3VMETERTAG.M_SVMETERNAME,SL3VMETERTAG.M_SBYTYPE,(L2TAG.M_SFKI*L2TAG.M_SFKU) AS m_sfKTR FROM SL3VMETERTAG,SL3GROUPTAG,L2TAG'+
                                   ' WHERE SL3VMETERTAG.m_sbyGroupID=SL3GROUPTAG.m_sbyGroupID'+
                                   ' and SL3GROUPTAG.m_swABOID='+IntToStr(nAbon)+
                                   ' and L2TAG.M_SWMID=SL3VMETERTAG.M_SWMID'+
                                   ' and SL3VMETERTAG.m_sbyEnable=1 '+
                                   ' and (SL3GROUPTAG.M_NGROUPLV=0 or SL3GROUPTAG.M_NGROUPLV=2) '+
                                   ' ORDER BY m_swVMID';
    {
     m_swVMID
     m_sddPHAddres
     m_sVMeterName
     m_sfKTR
    }
    pTable.m_swAmVMeter := 0;pTable.Item.Count   := 0;
    if OpenQryM2F(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     pTable.Item.Count   := nCount;
     SetLength(pTable.Item.Items,nCount);
     while not FADOQueryM2F.Eof do Begin
     with FADOQueryM2F,pTable.Item.Items[i] do  Begin
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_swMID       := FieldByName('m_swMID').AsInteger;
      m_sddPHAddres := FieldByName('m_sddFabNum').AsString;
      m_sVMeterName := FieldByName('m_sVMeterName').AsString;
      m_sfKTR       := FieldByName('m_sfKTR').AsInteger;
      m_nType       := FieldByName('M_SBYTYPE').AsInteger;
      m_vPortID     := FieldByName('M_SBYPORTID').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQryM2F;
    Result := res;
End;

{
function CDBase.MyDeleteTUCH(abon, tuch : Integer): Boolean;
var
    sDeStr : String;
begin
    FADOQueryMySQL.SQL.Clear();
    sDeStr := 'DELETE FROM TUCH';


    if (abon > 0) then // удалять по абоненту
    begin
        sDeStr := sDeStr + ' WHERE ABO='+IntToStr(abon);
        if (tuch > 0) then // удалять по абоненту и точке учета
            sDeStr := sDeStr + ' AND TUCH='+IntToStr(tuch);
    end;

    FADOQueryMySQL.SQL.Add(sDeStr);
    FADOQueryMySQL.ExecSQL();
    FADOQueryMySQL.Close();
end;
}
{
function CDBase.IsRegTable(var pTable:SL3REGION):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SL3REGION WHERE m_nRegionID='+IntToStr(pTable.m_nRegionID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
}
function CDBase.IsTuchTable(_AboID, _Tuch : Integer):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM TUCH WHERE ABO='+IntToStr(_AboID)+
              ' AND TUCH='+IntToStr(_Tuch);
    res := False;
    if OpenQryMySQL(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQryMySQL;
    Result := res;
End;
function CDBase.SetTuchTable(_AboID, _Tuch : Integer; _ZNom,_Name : String; _KTR : Integer):Boolean;
Var
    strSQL   : String;
BEgin
    strSQL := 'UPDATE tuch SET'+
              ' ABO='      +IntToStr(_AboID)+
              ',TUCH='     +IntToStr(_Tuch)+
              ',ZNOM_SH='  +''''+_ZNom+''''+
              ',ADRTU='    +''''+_Name+''''+
              ',KFTRN='    +IntToStr(_KTR)+
              ' WHERE ABO='+IntToStr(_AboID)+' and TUCH='+IntToStr(_Tuch);
   Result := ExecQryMySql(strSQL);
End;
function CDBase.MyAddTUCH(_AboID, _Tuch : Integer; _ZNom,_Name : String; _KTR : Integer): Integer;
Begin
    if IsTuchTable(_AboID,_Tuch)=True then SetTuchTable(_AboID,_Tuch,_ZNom,_Name,_KTR) else
    MyInsertTUCH(_AboID,_Tuch,_ZNom,_Name,_KTR);
End;
function CDBase.MyInsertTUCH(_AboID, _Tuch : Integer; _ZNom,_Name : String; _KTR : Integer): Integer;
var
    qstr : String;
begin
    try
    FADOQueryMySQL.SQL.Clear();
    qstr := 'INSERT IGNORE INTO TUCH(ABO, TUCH, ZNOM_SH, ADRTU, KFTRN) VALUES(' +
                     IntToStr(_AboID) + ', ' +
                     IntToStr(_Tuch) + ', ' +
                     '"' + _ZNom + '", ' +
                     '"' + _Name + '", ' +
                     IntToStr(_KTR) + ')';

    FADOQueryMySQL.SQL.Add(qstr);
    FADOQueryMySQL.ExecSQL;
    Result := 1;
    FADOQueryMySQL.Close();
    except
     Result := -1;
    end;
end;

{$define MYSQ_DEBUG
function CDBase.MyInsertBUF_V_INT(nAbon,nTuch, _CMDID : Integer; _sdtDate : TDateTime; it : INteger; val, _valDS, val1 : Double): Integer;
begin
    FADOQueryMySQL.SQL.Clear;

    try
    {$ifndef MYSQ_DEBUG
        FADOQueryMySQL.SQL.add('INSERT INTO BUF_V_INT(ABO,TUCH,N_GR_TY,DD_MM_YYYY,N_INTER_RAS,VAL,POK_START,VAL1) VALUES(' +
    {$else
        FADOQueryMySQL.SQL.add('INSERT IGNORE INTO BUF_V_INT(ABO,TUCH,N_GR_TY,DD_MM_YYYY,N_INTER_RAS,VAL,POK_START,VAL1) VALUES(' +
    {$endif
                    IntToStr(nAbon) + ',' +
                    IntToStr(nTuch) + ',' +
                    IntToStr(_CMDID-12) + ',' +
                    '''' + FormatDateTime('yyyy-mm-dd',_sdtDate) + '''' + ',' +
                    IntToStr(it) + ',' +
                    FloatToStr(val) + ',' +
                    FloatToStr(_valDS) + ',' +
                    FloatToStr(val1) + ')');

        Result := FADOQueryMySQL.ExecSQL;
        FADOQueryMySQL.SQL.Clear;
    except
    Result := -1;
    end;
end; }

function CDBase.MyPrepareMultiExec(): Integer;
begin
    m_sMySQLqStr := '';
    FADOQueryMySQL.SQL.Clear;
end;

function CDBase.MyMultiExec(): Integer;
begin
    FADOQueryMySQL.SQL.Add(m_sMySQLqStr);
    FADOQueryMySQL.ExecSQL;
    Result := 1;
    FADOQueryMySQL.Close;
end;
{
asbyt_enrg = packed record
     M_SWABOID: Integer;
     M_SWVMID : Integer;
     M_SWMID  : Integer;
     LIC_CH   : String[20];
     FIO      : String[40];
     NAM_PUNK : String[20];
     NAS_STR  : String[20];
     DOM      : String[5];
     KORP     : String[4];
     KVAR     : String[4];
     STAMP    : TDateTime;
     NOM_SCH  : String[20];
     D1       : TDateTime;
     D2       : TDateTime;
     VAL_K1   : Double;
     VAL_MAX1 : Double;
     VAL_MIN1 : Double;
     VAL_K2   : Double;
     VAL_MAX2 : Double;
     VAL_MIN2 : Double;
     R_MAX    : Double;
     R_MIN    : Double;
     R_ALL    : Double;
    End;

var
    sDeStr : String;
    whereDef : String;
begin
    sDeStr := 'DELETE FROM BUF_V_INT ';
    whereDef := '';
    FADOQueryMySQL.SQL.Clear();
    if ((ds > 0) AND (de <> 0)) then
        whereDef := ' WHERE (CAST(DD_MM_YYYY AS DATE) BETWEEN "'+FormatDateTime('yyyy-mm-dd', ds) +'" AND "'+FormatDateTime('yyyy-mm-dd', de) +'")';

    if (abon > 0) then // удалять по абоненту
    begin
        if (whereDef='') then
            whereDef := ' WHERE AND ABO='+IntToStr(abon)
        else
            whereDef := whereDef + ' AND ABO='+IntToStr(abon);
        if (tuch > 0) then // удалять по абоненту и точке учета
            whereDef := whereDef + ' AND TUCH='+IntToStr(tuch);
    end;

    FADOQueryMySQL.SQL.Add(sDeStr+whereDef);
    FADOQueryMySQL.ExecSQL();
    FADOQueryMySQL.Close();
end;
}
function CDBase.MyMakeDeleteBYT(ds,de:TDateTime):Integer;
Var
    sSQL : String;
Begin
    try
     FADOQueryMySQL.SQL.Clear();
     sSQL := 'DELETE FROM asbyt_enrg'+
     ' WHERE (CAST(STAMP AS DATE) BETWEEN "'+FormatDateTime('yyyy-mm-dd', ds) +'" AND "'+FormatDateTime('yyyy-mm-dd', de) +'")';
     FADOQueryMySQL.SQL.Clear;
     FADOQueryMySQL.SQL.Add(sSQL);
     FADOQueryMySQL.ExecSQL;
     Result := 1;
    except
    Result := -1;
    end;
End;
function CDBase.MyMakeDeleteBYT_Ex(ds,de:TDateTime;strDom,strKorp,strStrt:String):Integer;  //aav
Var
    sSQL : String;
Begin
    try
     FADOQueryMySQL.SQL.Clear();
     sSQL := 'DELETE FROM asbyt_enrg'+
     ' WHERE (CAST(STAMP AS DATE) BETWEEN "'+FormatDateTime('yyyy-mm-dd', ds) +'" AND "'+FormatDateTime('yyyy-mm-dd', de) +'")'+
     ' AND DOM='+''''+strDom+''''+
     ' AND KORP='+''''+strKorp+''''+
     ' AND NAS_STR='+''''+strStrt+'''';
     FADOQueryMySQL.SQL.Clear;
     FADOQueryMySQL.SQL.Add(sSQL);
     FADOQueryMySQL.ExecSQL;
     Result := 1;
    except
    Result := -1;
    end;
End;
function CDBase.MyMakeInsertBYT(var pTbl:asbyt_enrg):Integer;
//Var
//    sSQL : String;
Begin
    try
    if trunc(pTbl.D1)>trunc(pTbl.STAMP) then pTbl.STAMP := pTbl.D1;
    with pTbl do Begin
     m_sMySQLqStr := m_sMySQLqStr + 'INSERT INTO asbyt_enrg(LIC_CH,FIO,NAM_PUNK,NAS_STR,DOM,KORP,KVAR,STAMP,NOM_SCH,'+
     ' D1,D2,VAL_K1,VAL_MAX1,VAL_MIN1,VAL_K2,VAL_MAX2,VAL_MIN2,R_MAX,R_MIN,R_ALL) VALUES(' +
              ''''+LIC_CH+'''' + ',' +
              ''''+FIO+'''' + ',' +
              ''''+NAM_PUNK+'''' + ',' +
              ''''+NAS_STR+'''' + ',' +
              ''''+DOM+'''' + ',' +
              ''''+KORP+'''' + ',' +
              ''''+KVAR+'''' + ',' +
              '''' + FormatDateTime('yyyy-mm-dd',STAMP) + '''' + ',' +
              ''''+NOM_SCH+'''' + ',' +
              '''' + FormatDateTime('yyyy-mm-dd',D1) + '''' + ',' +
              '''' + FormatDateTime('yyyy-mm-dd',D2) + '''' + ',' +
              FloatToStr(VAL_K1) + ',' +
              FloatToStr(VAL_MAX1) + ',' +
              FloatToStr(VAL_MIN1) + ',' +
              FloatToStr(VAL_K2) + ',' +
              FloatToStr(VAL_MAX2) + ',' +
              FloatToStr(VAL_MIN2) + ',' +
              FloatToStr(R_MAX) + ',' +
              FloatToStr(R_MIN) + ',' +
              FloatToStr(R_ALL) + ');';
    End;
    //FADOQueryMySQL.SQL.Clear;
    //FADOQueryMySQL.SQL.Add(sSQL);
    //Result := FADOQueryMySQL.ExecSQL;
    except
    Result := -1;
    End;
End;

{$undef MYSQ_DEBUG}
function CDBase.MyMakeInsertBUF_V_INT(nAbon,nTuch, _CMDID : Integer; _sdtDate : TDateTime; it : INteger; val, _valDS, val1 : Double): Integer;
begin
    try
    {$ifndef MYSQ_DEBUG}
        m_sMySQLqStr := m_sMySQLqStr + 'INSERT INTO BUF_V_INT(ABO,TUCH,N_GR_TY,DD_MM_YYYY,N_INTER_RAS,VAL,POK_START,VAL1) VALUES(' +
    {$else}
        m_sMySQLqStr := m_sMySQLqStr + 'INSERT IGNORE INTO BUF_V_INT(ABO,TUCH,N_GR_TY,DD_MM_YYYY,N_INTER_RAS,VAL,POK_START,VAL1) VALUES(' +
    {$endif}
                    IntToStr(nAbon) + ',' +
                    IntToStr(nTuch) + ',' +
                    IntToStr(_CMDID-12) + ',' +
                    '''' + FormatDateTime('yyyy-mm-dd',_sdtDate) + '''' + ',' +
                    IntToStr(it) + ',' +
                    FloatToStr(val) + ',' +
                    FloatToStr(_valDS) + ',' +
                    FloatToStr(val1) + ');';
    except
    Result := -1;
    end;
end;


function CDBase.MyMakeDeleteBUF_V_FAIL(nAbon,nTuch, _CMDID : Integer; _sdtDate : TDateTime; it : INteger): Integer;
begin
    try
        m_sMySQLqStr := m_sMySQLqStr +
                'DELETE FROM BUF_V_FAIL WHERE '+
                'ABO='+IntToStr(nAbon) + ' AND ' +
                'TUCH='+IntToStr(nTuch) + ' AND ' +
                'N_GR_TY='+IntToStr(_CMDID-12) + ' AND ' +
                'DD_MM_YYYY=''' + FormatDateTime('yyyy-mm-dd',_sdtDate) + ''' AND ' +
                'N_INTER_RAS='+IntToStr(it) + ';';
    except
    Result := -1;
    end;
end;

function CDBase.MyGetInvalidData(var pTable:L3VALIDATASMY):Boolean;
Var
    nCount,i  : Integer;
Begin
    Result := False;

    pTable.Count := 0;
    pTable.Items := nil;
    if OpenQryMySQL('SELECT DISTINCT ABO, TUCH, DD_MM_YYYY FROM BUF_V_FAIL ORDER BY ABO, TUCH, DD_MM_YYYY;', nCount) = True then
    Begin
    i := 0;
    Result := True;
    pTable.Count := nCount;
    SetLength(pTable.Items, nCount);
    while not FADOQueryMySQL.Eof do Begin
     with FADOQueryMySQL, pTable.Items[i] do  Begin
      m_swAbon      := FieldByName('ABO').AsInteger;
      m_swTuch      := FieldByName('TUCH').AsInteger;
//      m_swGraphType := FieldByName('N_GR_TY').AsInteger;
      m_sdtDate     := FieldByName('DD_MM_YYYY').AsDateTime;
//      m_swHH        := FieldByName('N_INTER_RAS').AsInteger;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQryMySQL;
End;

function CDBase.OpenQryMy(strSQL:String;var nCount:Integer):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
    res    := False;
    nCount := 0;
    try
    if not FADOQueryMySQL.Transaction.Active then
      FADOQueryMySQL.Transaction.StartTransaction;
    iQ := Integer(FADOQueryMySQL);
    iT := Integer(FADOQueryMySQL.Transaction);
     FADOQueryMySQL.SQL.Clear;
     FADOQueryMySQL.SQL.Add(strSQL);
     FADOQueryMySQL.Open;
    FADOQueryMySQL.FetchAll;
    FADOQueryMySQL.Transaction.CommitRetaining;
    if FADOQueryMySQL.RecordCount>0 then Begin
      nCount := FADOQueryMySQL.RecordCount;
      res := True;
    End;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.FADOQueryMySQL: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryMySQL = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryMySQL.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryMySQL.Transaction.Rollback;
      res := False;
    end;
    end;
    Result := res;
End;

{
procedure CSaveSystem.DataBaseRun;
Var
     IBDB : TIBDataBase;
     IBTr : TIBTransaction;
     Q : TIBQuery;
     name : string;
Begin
  IBDB := TIBDataBase.Create(nil);
  IBTr := TIBTransaction.Create(nil);
  with IBDB do begin
    DatabaseName := 'D:\Kon2\SYSINFOAUTO.FDB';
    Params.Add('user_name=sysdba');
    Params.Add('password=masterkey');
    Params.Add('lc_ctype=WIN1251');
    LoginPrompt := False;
    DefaultTransaction := IBTr;
  end;
  try
  //with IBTr do begin
  //  DefaultDatabase := IBDB;
  //  with Params do begin
  //    Add('isc_tpb_read');
  //    Add('isc_tpb_nowait');
  //    Add('isc_tpb_concurrency');
  //    Add('isc_tpb_read_committed');
  //    Add('isc_tpb_rec_version');
  //  end;
  //end;
    IBDB.Connected := True;
    Q:=TIBQuery.Create(nil);
    Q.Transaction:=IBTr;
    Q.Database:=IBDB;
    Q.Transaction.StartTransaction;
    Q.SQL.Clear;
    Q.SQL.Add('SELECT * FROM L2TAG');
    Q.Active:=true;

    while not Q.EOF do
    begin
     name :=  Q.FieldByName('M_SCHNAME').AsString;
     TraceL(0,0,'(__)CSaveSystem::>name :'+name);
     Q.Next;
    end;
    Q.Transaction.Commit;
    IBDB.Connected := False;
  except
    TraceL(0,0,'(__)CSaveSystem::>Error CSaveSystem.DataBaseRun');
  end;
End;
}


function CDBase.OpenQryM2F(strSQL:String;var nCount:Integer):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
    res    := False;
    nCount := 0;
    try
    if not FADOQueryM2F.Transaction.Active then
      FADOQueryM2F.Transaction.StartTransaction;
    iQ := Integer(FADOQueryM2F);
    iT := Integer(FADOQueryM2F.Transaction);
     FADOQueryM2F.SQL.Clear;
     FADOQueryM2F.SQL.Add(strSQL);
     FADOQueryM2F.Open;
    FADOQueryM2F.FetchAll;
    FADOQueryM2F.Transaction.CommitRetaining;
    if FADOQueryM2F.RecordCount>0 then Begin
      nCount := FADOQueryM2F.RecordCount;
      res := True;
    End;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.FADOQueryM2F: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryM2F = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryM2F.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryM2F.Transaction.Rollback;
      res := False;
    end;
    end;
    Result := res;
End;

procedure CDBase.CloseQryM2F;
Begin
    FADOQueryM2F.Close;
End;
function CDBase.GetGraphDatasMyExport(dtP0,dtP1:TDateTime;VMID:Integer;var pTable:L3GRAPHDATASMY):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin
    strSQL := 'SELECT L2HALF_HOURLY_ENERGY.*, L3ARCHDATA.M_SFVALUE FROM L2HALF_HOURLY_ENERGY' +
              ' LEFT JOIN L3ARCHDATA ON (L3ARCHDATA.m_swtid=0 AND' +
              ' (l3archdata.m_stime=L2HALF_HOURLY_ENERGY.m_sdtDate AND L3ARCHDATA.M_SWCMDID=(L2HALF_HOURLY_ENERGY.M_SWCMDID+4))' +
              ' AND L3ARCHDATA.M_SWVMID=L2HALF_HOURLY_ENERGY.M_SWVMID)' +
              ' WHERE L2HALF_HOURLY_ENERGY.m_swVMID=' + IntToStr(VMID) +
              ' AND (CAST(L2HALF_HOURLY_ENERGY.m_sdtDate AS DATE) BETWEEN '''+DateToStr(dtP0)+''' and '''+DateToStr(dtP1)+''')' +
              ' ORDER BY L2HALF_HOURLY_ENERGY.m_sdtDate';
    res := False;
    if OpenQryM2F(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryM2F.Eof do Begin
     with FADOQueryM2F,pTable.Items[i] do  Begin
      //m_sdtLastTime  := FieldByName('m_sdtLastTime').AsDateTime;
      m_swCMDID      := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swSumm       := FieldByName('M_SFVALUE').AsFloat;
      for j:=0 to 47 do v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQryM2F;
    Result := res;
End;
{
asbyt_enrg = packed record
     M_SWABOID: Integer;
     M_SWVMID : Integer;
     M_SWMID  : Integer;
     LIC_CH   : String[20];
     FIO      : String[40];
     NAM_PUNK : String[20];
     NAS_STR  : String[20];
     DOM      : String[5];
     KORP     : String[4];
     KVAR     : String[4];
     STAMP    : TDateTime;
     NOM_SCH  : String[20];
     D1       : TDateTime;
     D2       : TDateTime;
     VAL_K1   : Double;
     VAL_MAX1 : Double;
     VAL_MIN1 : Double;
     VAL_K2   : Double;
     VAL_MAX2 : Double;
     VAL_MIN2 : Double;
     R_MAX    : Double;
     R_MIN    : Double;
     R_ALL    : Double;
    End;
    asbyt_enrgs = packed record
     Count : Integer;
     Items : array of asbyt_enrg;
    End;
      strSQL := 'SELECT m_sTime, m_sbyMaskReRead,m_sbyMaskRead, sum(m_crc)as m_crc,sum(m_sfValue) as m_sfValue '+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swTID<>0 and m_swTID<>4 and m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' GROUP BY m_sTime, m_sbyMaskReRead,m_sbyMaskRead ORDER BY m_sTime '

}
function CDBase.GetBytDatasMyExport(nDIndex,nABOID:Integer;dtP0,dtP1:TDateTime;var pTable:asbyt_enrgs):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    pLabel      : SL3ABONLB;
    nTID        : Integer;
    sTime       : TDateTime;
    dbVal       : Double;
Begin
{
     UTP_KU     = 5;
     UTP_KUB    = 6;
     UTP_NKUB   = 7;
     UTP_NKUNB  = 8;
}
    GetAbonLabel(nABOID,pLabel);
    strSQL := 'SELECT DISTINCT s2.M_SWVMID as SWVMID,s4.M_SWMID as SWMID,s4.M_STPNUM,s2.M_SVMETERNAME,s0.M_SHOUSENUMBER,s0.M_SKORPUSNUMBER,'+
              ' s4.M_SDDPHADDRES,s4.M_SDDFABNUM,s3.m_swtid,s3.M_SFVALUE,s3.M_STIME'+
              ' FROM SL3ABON as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2,L3ARCHDATA as s3,L2TAG as s4' +
              ' WHERE s3.m_swtid>=0 and s3.m_swtid<=2'+
              ' AND (CAST(s3.M_STIME AS DATE) BETWEEN '''+DateToStr(dtP0)+''' and '''+DateToStr(dtP1)+''')' +
              ' AND s0.M_SWABOID='+IntToStr(nABOID)+
              ' AND s0.M_SWABOID=s1.M_SWABOID'+
              ' AND s1.M_SBYGROUPID=s2.M_SBYGROUPID'+
              ' AND s2.M_SWVMID=s3.M_SWVMID'+
              ' AND s3.m_swCMDID='+IntToStr(QRY_NAK_EN_MONTH_EP)+
              ' AND s2.M_SWMID=s4.M_SWMID'+
              ' AND (s4.m_sbyLocation='+IntTostr(UTP_KU)+
              ' OR s4.m_sbyLocation='+IntTostr(UTP_KUB)+
              ' OR s4.m_sbyLocation='+IntTostr(UTP_NKUB)+
              ' OR s4.m_sbyLocation='+IntTostr(UTP_NKUNB)+')'+
              ' ORDER BY s4.M_SWMID,s3.m_swtid';
    res := False;
    i := 0;
    if nDIndex=0 then Begin bl0:=False;bl1:=False; End;
    if OpenQryM2F(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    if nDIndex=0 then Begin bl0:=True;bl1:=False; End;
    if nDIndex=1 then Begin bl1:=True; End;
    for i:=0 to pTable.Count-1 do
    Begin
     if (nDIndex=0)or((nDIndex=1)and(bl0=False)) then
     Begin
      pTable.Items[i].VAL_K1   := 0;
      pTable.Items[i].VAL_MAX1 := 0;
      pTable.Items[i].VAL_MIN1 := 0;
      pTable.Items[i].VAL_K2   := 0;
      pTable.Items[i].VAL_MAX2 := 0;
      pTable.Items[i].VAL_MIN2 := 0;
     End;
    End;
    i := 0;
    while not FADOQueryM2F.Eof do Begin
     with FADOQueryM2F,pTable.Items[i] do  Begin
      M_SWABOID:= nABOID;
      M_SWVMID := FieldByName('SWVMID').AsInteger;
      M_SWMID  := FieldByName('SWMID').AsInteger;
      nTID     := FieldByName('m_swtid').AsInteger;
      sTime    := trunc(FieldByName('M_STIME').AsDateTime);
      LIC_CH   := FieldByName('M_STPNUM').AsString;
      FIO      := FieldByName('M_SVMETERNAME').AsString;
      NAM_PUNK := pLabel.m_sTwnName;
      NAS_STR  := pLabel.m_sStreetName;
      DOM      := FieldByName('M_SHOUSENUMBER').AsString;
      KORP     := FieldByName('M_SKORPUSNUMBER').AsString;
      KVAR     := FieldByName('M_SDDPHADDRES').AsString;
      if nDIndex=1 then STAMP := dtP0;
      NOM_SCH  := FieldByName('M_SDDFABNUM').AsString;
      if nDIndex=0 then D1 := dtP0;
      if nDIndex=1 then D2 := dtP0;
      dbVal    := FieldByName('M_SFVALUE').AsFloat;
      if nDIndex=0 then
      Begin
       if nTID=0   then VAL_K1   := dbVal;
       if nTID=1   then VAL_MAX1 := dbVal;
       if nTID=2   then VAL_MIN1 := dbVal;
      End else
      if nDIndex=1 then
      Begin
       if nTID=0 then VAL_K2   := dbVal;
       if nTID=1 then VAL_MAX2 := dbVal;
       if nTID=2 then VAL_MIN2 := dbVal;
       R_MAX := VAL_MAX2 - VAL_MAX1;
       R_MIN := VAL_MIN2 - VAL_MIN1;
       R_ALL := VAL_K2   - VAL_K1;
      End;
      if LIC_CH=''   then LIC_CH   := IntToStr(M_SWMID)+'|0/0/7';
      if NAM_PUNK='' then NAM_PUNK := 'Нет данных';
      if NAS_STR=''  then NAS_STR  := 'Нет данных';
      if nTID=2 then Inc(i);
      Next;
    End;
    End;
    pTable.RCount := i;
    End;
    CloseQryM2F;
    Result := res;
End;
function CDBase.ChandgrMarchNumber(nABOID,nPID:Integer;strKSP,strMNumber,strOldMN:String):Boolean;
Var
    strFild,str,strF{,strOldMN} : String;
    pTable   : SL2INITITAG;
    pVTable  : SL3GROUPTAG;
    i,nPos   : Integer;
Begin
    pTable.m_swAmMeter:=0;
    GetMetersTable(nPID,pTable);
    if pTable.m_swAmMeter=0 then exit;
    {
    strOldMN := '';
    str  := pTable.m_sMeter[0].m_sTpNum;
    str  := StringReplace(str,'|',':::',[rfReplaceAll]);
    str  := StringReplace(str,'/',':::',[rfReplaceAll]);
    nPos := Pos(':::',str);
    i:=0;
    while nPos<>0 do
    Begin
     strF := Copy(str,0,nPos-1);
     Delete(str,1,nPos+2);
     nPos := Pos(':::',str);
     if (i=1) then strOldMN  := strF;
     Inc(i);
    End;
    }
    for i:=0 to pTable.m_swAmMeter-1 do
    Begin
     //if pTable.m_sMeter[i].m_sbyLocation=UTP_KU then
     Begin
      strFild := pTable.m_sMeter[i].m_sTpNum;
      strFild  := StringReplace(strFild,strOldMN,strMNumber,[rfReplaceAll]);
      pTable.m_sMeter[i].m_sTpNum := strFild;
      strFild := pTable.m_sMeter[i].m_schName;
      strFild  := StringReplace(strFild,strOldMN,strMNumber,[rfReplaceAll]);
      pTable.m_sMeter[i].m_schName := strFild;
     End;
     SetMeterTable(pTable.m_sMeter[i]);
    End;

    GetAbonVMeterTable(nABOID,-1,pVTable);
    for i:=0 to pVTable.Item.Count-1 do
    Begin
     strFild := pVTable.Item.Items[i].m_sVMeterName;
     strFild := StringReplace(strFild,strOldMN,strMNumber,[rfReplaceAll]);
     pVTable.Item.Items[i].m_sVMeterName := strFild;
     SetVMeterTable(pVTable.Item.Items[i]);
    End;


End;
function CDBase.ChandgeKSPNumber(nABOID,nPID:Integer;strKSP,strOldKSP:String):Boolean;
Var
    strFild,str,strF{,strOldMN} : String;
    pTable   : SL2INITITAG;
    pVTable  : SL3GROUPTAG;
    i,nPos   : Integer;
Begin
    pTable.m_swAmMeter:=0;
    GetMetersTable(nPID,pTable);
    if pTable.m_swAmMeter=0 then exit;
    for i:=0 to pTable.m_swAmMeter-1 do
    Begin
     //if pTable.m_sMeter[i].m_sbyLocation=UTP_KU then
     Begin
      strFild := pTable.m_sMeter[i].m_sTpNum;
      strFild  := StringReplace(strFild,strOldKSP+'|',strKSP+'|',[rfReplaceAll]);
      pTable.m_sMeter[i].m_sTpNum := strFild;
      strFild := pTable.m_sMeter[i].m_schName;
      strFild  := StringReplace(strFild,strOldKSP+'|',strKSP+'|',[rfReplaceAll]);
      pTable.m_sMeter[i].m_schName := strFild;
     End;
     SetMeterTable(pTable.m_sMeter[i]);
    End;

    GetAbonVMeterTable(nABOID,-1,pVTable);
    for i:=0 to pVTable.Item.Count-1 do
    Begin
     strFild := pVTable.Item.Items[i].m_sVMeterName;
     strFild := StringReplace(strFild,strOldKSP+'|',strKSP+'|',[rfReplaceAll]);
     pVTable.Item.Items[i].m_sVMeterName := strFild;
     SetVMeterTable(pVTable.Item.Items[i]);
    End;


End;
function CDBase.ChandgeKVName(nABOID,nPID:Integer;strKV:String):Boolean;
Var
    strFild,str,strF,strNew : String;
    pTable   : SL2INITITAG;
    pVTable  : SL3GROUPTAG;
    i,nPos   : Integer;
Begin
    try
    pTable.m_swAmMeter:=0;
    GetMetersTable(nPID,pTable);
    if pTable.m_swAmMeter=0 then exit;
    for i:=0 to pTable.m_swAmMeter-1 do
    Begin
     if pTable.m_sMeter[i].m_sbyLocation=UTP_KU then
     Begin
      strFild := strKV;                           //Format('%.3d',[StrToInt(strFild0)]);
      strNew  := Format('%.3d',[StrToInt(pTable.m_sMeter[i].m_sddPHAddres)]);
      strFild := StringReplace(strFild,'№',strNew,[rfReplaceAll]);
      pTable.m_sMeter[i].m_schName := strFild;
      SetMeterTable(pTable.m_sMeter[i]);
     End;
    End;

    GetAbonVMeterTable(nABOID,-1,pVTable);
    for i:=0 to pVTable.Item.Count-1 do
    Begin
     if pTable.m_sMeter[i].m_sbyLocation=UTP_KU then
     Begin
      strFild := strKV;
      strNew  := Format('%.3d',[StrToInt(pVTable.Item.Items[i].m_sddPHAddres)]);
      strFild := StringReplace(strFild,'№',strNew,[rfReplaceAll]);
      pVTable.Item.Items[i].m_sVMeterName := strFild;
      SetVMeterTable(pVTable.Item.Items[i]);
     End;
    End;
    except
    end
End;
function CDBase.GetTplMyExport(nABOID:Integer;dtP0:TDateTime;var pTable:L3DATASAVT_EXPS):Boolean;
Var
    res     : Boolean;
    i,j     : Integer;
    pVMT    : SL3GROUPTAG;
    pTD     : L3ARCHDATASMY;
    strType : String;
Begin
    res := False;
    strType := '('+IntToStr(MET_TEM104)+','+IntToStr(MET_VZLJOT)+')';
    GetAbonMetersLocTable(nABOID,strType,pVMT);
    SetLength(pTable.Items,pVMT.Item.Count);
    pTable.Count := pVMT.Item.Count;
    for i:=0 to pVMT.Item.Count-1 do
    Begin
     pTable.Items[i].m_swVMID := pVMT.Item.Items[i].m_swVMID;
     pTable.Items[i].ZAVN     := pVMT.Item.Items[i].m_sddPHAddres;
     pTable.Items[i].KJU      := GetParceString(3,pVMT.Item.Items[i].m_sMeterName);
     pTable.Items[i].ADR      := GetParceString(2,pVMT.Item.Items[i].m_sMeterName);
     pTable.Items[i].UID      := StrToInt(GetParceString(4,pVMT.Item.Items[i].m_sMeterName));
     pTable.Items[i].KOD_CH   := StrToInt(GetParceString(5,pVMT.Item.Items[i].m_sMeterName));
     pTable.Items[i].TIPSH    := GetParceString(6,pVMT.Item.Items[i].m_sMeterName);
     pTable.Items[i].DAT      := dtP0;
     pTable.Items[i].VREM     := dtP0;
     ReplaceTime(pTable.Items[i].DAT,0);
     ReplaceDate(pTable.Items[i].VREm,0);
     pTable.Items[i].NoTrab_o :='1';
     //if pVMT.Item.Items[i].m_sbyExport=
     pTable.Items[i].N_GRUCH  := 0;
     GetArchTplMyExport(dtP0,pVMT.Item.Items[i].m_swVMID,pTD);
      for j:=0 to pTD.Count-1 do
      Begin
       res := True;
       case pTD.Items[j].m_swCMDID of
            QRY_NACKM_POD_TRYB_HEAT     : pTable.Items[i].Q1     := pTD.Items[j].m_sfValue;
            QRY_NACKM_POD_TRYB_RASX     : pTable.Items[i].V1     := pTD.Items[j].m_sfValue;
            QRY_NACKM_POD_TRYB_TEMP     : pTable.Items[i].TPOD   := pTD.Items[j].m_sfValue;
            //QRY_NACKM_POD_TRYB_V        : pTable.Items[i].Q1     := 0;
            QRY_NACKM_OBR_TRYB_HEAT     : pTable.Items[i].Q2     := pTD.Items[j].m_sfValue;
            QRY_NACKM_OBR_TRYB_RASX     : pTable.Items[i].V2     := pTD.Items[j].m_sfValue;
            QRY_NACKM_OBR_TRYB_TEMP     : pTable.Items[i].TOBR   := pTD.Items[j].m_sfValue;
            //QRY_NACKM_OBR_TRYB_V        : pTable.Items[i].Q1     := 0;
            QRY_NACKM_TEMP_COLD_WAT_DAY : pTable.Items[i].TXV    := 4;
            QRY_NACKM_POD_TRYB_RUN_TIME : pTable.Items[i].TRAB   := pTD.Items[j].m_sfValue;
            QRY_NACKM_WORK_TIME_ERR     : pTable.Items[i].TRAB_O := pTD.Items[j].m_sfValue;
       End;
     End;
    End;
    Result := res;
End;


function CDBase.GetGraphDataValidity(dt : TDateTime; VMID, ET : Integer; var _Mask:int64) : Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin
    strSQL := 'SELECT m_sMaskRead'+
              ' WHERE m_swVMID=' + IntToStr(VMID) +
              ' AND (CAST(m_sdtDate AS DATE) = '''+DateToStr(dt)+''')' +
              ' ORDER BY m_sdtDate LIMIT 1';

    res := False;
    if OpenQryM2F(strSQL,nCount)=True then
    Begin
    res := True;
    if (not FADOQueryM2F.Eof) then
    Begin
      //_Mask  := FADOQueryM2F.FieldByName('m_sMaskRead').AsInteger;
    End;
    End;
    CloseQryM2F;
    Result := res;
End;


function CDBase.SetMyGenSettTable(var pTable:SGENSETTTAG):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SGENSETTTAG SET '+
              ' M_DTESTART='''+DateTimeToStr(M_DTESTART)+''''+
              ',M_DTEINT='''+DateTimeToStr(M_DTEINT)+''''+
              ',m_dtLast='''+DateTimeToStr(m_dtLast)+''''+
              ',m_blMdmExp='+IntToStr(m_blMdmExp)+
              ',M_BLFMAKDELFILE='+IntToStr(M_BLFMAKDELFILE)+
              ',M_SDBNAME='''+  M_SDBNAME+''''+
              ',M_SDBUSR='''+ M_SDBUSR+''''+
              ',M_SDBPASSW=''' + M_SDBPASSW +''''+
              ',M_SDBSERVER=''' + M_SDBSERVER+''''+
              ',M_SDBPORT=''' + IntToStr(M_SDBPORT) +''''+
              ',m_byEnableArchiv=''' + IntToStr(m_byEnableArchiv) +''''+
              ',m_sArchPath=''' + m_sArchPath +''''+
              ',m_sSrcPath=''' + m_sSrcPath +''''+
              ',m_tmArchPeriod=''' + IntToStr(m_tmArchPeriod) +''''+
              ',m_dtEnterArchTime=''' + DateTimeToStr(m_dtEnterArchTime) +'''';
    End;
    Result := ExecQry(strSQL);
End;

function CDBase.SetMySqlConfTable(var pTable:SGENSETTTAG):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SGENSETTTAG SET '+
              ' M_SDBNAME='''+  M_SDBNAME+''''+
              ',M_SDBUSR='''+ M_SDBUSR+''''+
              ',M_SDBPASSW=''' + M_SDBPASSW +''''+
              ',M_SDBSERVER=''' + M_SDBSERVER+''''+
              ',M_SDBPORT=''' + IntToStr(M_SDBPORT) +''''+'';
    End;
    Result := ExecQry(strSQL);
End;

function CDBase.SetEnTransTime(sTransTime:Byte):Boolean;
Var
    strSQL   : String;
BEgin
    strSQL := 'UPDATE SGENSETTTAG SET m_sTransTime=''' + IntToStr(sTransTime) +'''';
    Result := ExecQry(strSQL);
End;

function CDBase.MyGetHalfHours(var pTable:L3VALIDATAMY):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin
{
     m_swAbon      : Word; // abonent
     m_swTuch      : Word; // tuch
     m_swGraphType : Word;
     m_sdtDate     : TDateTime;
     m_swHH        : Byte;
     m_fVal        : Double;
     m_fPokStart   : Double;
     m_fVal1       : Double;
 }
 
    strV := 'v'+IntToStr(pTable.m_swHH-1);
    strSQL := 'SELECT L2HALF_HOURLY_ENERGY.' + strV + ', L3ARCHDATA.M_SFVALUE FROM L2HALF_HOURLY_ENERGY' +
              ' LEFT JOIN L3ARCHDATA ON (L3ARCHDATA.m_swtid=0 AND' +
              ' (l3archdata.m_stime=L2HALF_HOURLY_ENERGY.m_sdtDate AND L3ARCHDATA.M_SWCMDID=(L2HALF_HOURLY_ENERGY.M_SWCMDID+4))' +
              ' AND L3ARCHDATA.M_SWVMID=L2HALF_HOURLY_ENERGY.M_SWVMID)' +
              ' WHERE L2HALF_HOURLY_ENERGY.m_swVMID=' + IntToStr(pTable. m_swTuch) +
              ' AND L2HALF_HOURLY_ENERGY.M_SWCMDID=' + IntToStr(12+pTable.m_swGraphType) +
              ' AND (CAST(L2HALF_HOURLY_ENERGY.m_sdtDate AS DATE)='''+DateToStr(pTable.m_sdtDate)+''')' +
              ' ORDER BY L2HALF_HOURLY_ENERGY.m_sdtDate';
              
    res := False;
    if OpenQryM2F(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
//    pTable.Count := nCount;
//    SetLength(pTable.Items,nCount);
    while not FADOQueryM2F.Eof do Begin
     with FADOQueryM2F, pTable do  Begin
      //m_sdtLastTime  := FieldByName('m_sdtLastTime').AsDateTime;
      //m_swAbon       := FieldByName('M_SMASKREAD').AsInteger;
      m_swTuch       := FieldByName('m_swCMDID').AsInteger;
      m_swGraphType  := FieldByName('M_SFVALUE').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swHH         := FieldByName('M_SFVALUE').AsInteger;
      m_fVal         := 1;

      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQryM2F;
    Result := res;
End;

function CDBase.GetArchTplMyExport(dt:TDateTime;VMID:Integer; var pTable:L3ARCHDATASMY):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin

    strSQL := ' SELECT m_swvmid,m_swcmdid,m_stime,m_sfvalue' +
              ' FROM l3archdata' +
              ' WHERE m_swvmid=' + IntToStr(VMID) +
              ' and m_swtid=0'+
              ' and (m_swcmdid>='+IntToStr(QRY_NACKM_POD_TRYB_HEAT)+') and (m_swcmdid<='+IntToStr(QRY_NACKM_WORK_TIME_ERR)+')'+
              ' and m_stime='''+ DateToStr(dt)+''''+
              ' order by m_swcmdid asc;';
    res := False;
    if OpenQryM2F(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryM2F.Eof do Begin
     with FADOQueryM2F,pTable.Items[i] do  Begin
      m_swVMID   := FieldByName('m_swVMID').AsInteger;
      m_swCMDID  := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate  := FieldByName('m_stime').AsDateTime;
      m_sfValue  := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQryM2F;
    Result := res;
End;
function CDBase.GetArchDataMyExport(dt:TDateTime;VMID:Integer; var pTable:L3ARCHDATASMY):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin

    strSQL := ' SELECT' +
              ' m_swvmid,' +
              ' m_swcmdid,' +
              ' m_stime,' +
              ' m_sfvalue' +
          ' FROM' +
              ' l3archdata' +
          ' WHERE' +
              ' m_swvmid=' + IntToStr(VMID) +
              ' and' +
              ' m_swtid=0 and (m_swcmdid=75 or m_swcmdid=76 or m_swcmdid=77 or m_swcmdid=79 or m_swcmdid=80'+
                              ' or m_swcmdid=81 or m_swcmdid=83 or m_swcmdid=84 or m_swcmdid=85)' +
              ' and' +
              ' m_stime =''' + DateToStr(dt) + '''' +
              ' order by m_swcmdid asc;';
(*
              ' m_swtid=0 and (m_swcmdid=74 or m_swcmdid=75 or m_swcmdid=76 or m_swcmdid=78 or m_swcmdid=79'+
                              ' or m_swcmdid=80 or m_swcmdid=82 or m_swcmdid=83 or m_swcmdid=84)' +
*)
              
    res := False;
    if OpenQryM2F(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryM2F.Eof do Begin
     with FADOQueryM2F,pTable.Items[i] do  Begin
      m_swVMID   := FieldByName('m_swVMID').AsInteger;
      m_swCMDID  := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate  := FieldByName('m_stime').AsDateTime;
      m_sfValue  := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQryM2F;
    Result := res;
End;



function CDBase.GetArchDataDBFExport(dt:TDateTime;VMID:Integer; var pTable:L3ARCHDATASMY):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin

    strSQL := ' SELECT' +
              ' m_swvmid,' +
              ' m_swcmdid,' +
              ' m_stime,' +
              ' m_sfvalue' +
          ' FROM' +
              ' l3archdata' +
          ' WHERE' +
              ' m_swvmid=' + IntToStr(VMID) +
              ' and' +
              ' m_swtid=0 and (m_swcmdid=21 or m_swcmdid=22)' +
              ' and' +
              ' m_stime =''' + DateToStr(dt) + '''' +
              ' order by m_swcmdid asc;';
              
    res := False;
    if OpenQryM2F(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryM2F.Eof do Begin
     with FADOQueryM2F,pTable.Items[i] do  Begin
      m_swVMID   := FieldByName('m_swVMID').AsInteger;
      m_swCMDID  := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate  := FieldByName('m_stime').AsDateTime;
      m_sfValue  := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQryM2F;
    Result := res;
End;

function CDBase.GetAtomArchDataDBFExport(_dt:TDateTime; _VMID:Integer; _tar, _CMD : WORD; var pTable:L3ARCHDATAMY):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin

    strSQL := ' SELECT' +
              ' m_swvmid,' +
              ' m_swcmdid,' +
              ' m_stime,' +
              ' m_sfvalue' +
          ' FROM' +
              ' l3archdata' +
          ' WHERE' +
              ' m_swvmid=' + IntToStr(_VMID) +
              ' and' +
              ' m_swtid='+ IntToStr(_tar) +' and m_swcmdid=' + IntToStr(_cmd) +
              ' and' +
              ' CAST(m_stime AS DATE) =''' + DateToStr(_dt) + ''';';
              
    res := False;
    if OpenQryM2F(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    while not FADOQueryM2F.Eof do Begin
     with FADOQueryM2F,pTable do  Begin
      m_swVMID   := FieldByName('m_swVMID').AsInteger;
      m_swCMDID  := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate  := FieldByName('m_stime').AsDateTime;
      m_sfValue  := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQryM2F;
    Result := res;
End;
function CDBase.GetConfDataMyExport(_VMID : Integer; var pTable:L3DATASAVT_EXP):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := ' SELECT'+
          ' L2TAG.M_SDDFABNUM AS ZAVN,'+
          ' ''ABO'' AS KJU,'+
          ' (SL3VMETERTAG.M_SVMETERNAME) AS ADR,'+
          ' L2TAG.M_SBYTYPE AS KOD_CH,'+
          ' L2TAG.M_SBYTYPE AS TIPSH,'+
          ' L2TAG.M_SBYID AS UCH'+
          ' FROM'+
          ' SL3VMETERTAG'+
          ' LEFT JOIN'+
          ' L2TAG'+
          ' ON'+
          ' SL3VMETERTAG.M_SWMID=L2TAG.M_SWMID'+
          ' WHERE SL3VMETERTAG.M_SWVMID='+IntToStr(_VMID)+';';
    res := False;
    if OpenQryM2F(strSQL,nCount)=True then
    Begin
     pTable.ZAVN   := FADOQueryM2F.FieldByName('ZAVN').AsString;
     pTable.KJU    := FADOQueryM2F.FieldByName('KJU').AsString;
     pTable.ADR    := FADOQueryM2F.FieldByName('ADR').AsString;
     pTable.KOD_CH := FADOQueryM2F.FieldByName('KOD_CH').AsInteger;
     pTable.TIPSH  := FADOQueryM2F.FieldByName('TIPSH').AsString;
     pTable.UCH    := FADOQueryM2F.FieldByName('UCH').AsInteger;

{    pTable.ZAVN   := 'зав.ном.';
    pTable.KJU    := 'код объекта';
    pTable.ADR    := 'адрес местоположения';
    pTable.KOD_CH := 1;
    pTable.TIPSH  := '1';
    pTable.UCH	  := 2;

    pTable.DAT	  := ds;
    pTable.VREM	  := 00.00;}
     res   := True;
    End;
    CloseQryM2F;
    Result := res;
End;


function CDBase.OpenQryMySQL(strSQL:String;var nCount:Integer):Boolean;
Var res    : Boolean;
    iQ, iT : Integer;
Begin
    res    := False;
    nCount := 0;
    try
    if not FADOQueryMySQL.Transaction.Active then
      FADOQueryMySQL.Transaction.StartTransaction;
    iQ := Integer(FADOQueryMySQL);
    iT := Integer(FADOQueryMySQL.Transaction);
    FADOQueryMySQL.SQL.Clear;
    FADOQueryMySQL.SQL.Add(strSQL);
    FADOQueryMySQL.Open;
    FADOQueryMySQL.FetchAll;
    if FADOQueryMySQL.RecordCount>0 then Begin
      nCount := FADOQueryMySQL.RecordCount;
      res := True;
    End;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in CDBase.FADOQueryMySQL: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQueryMySQL = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQueryMySQL.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQueryMySQL.Transaction.Rollback;
      res := False;
    end;
    end;
    Result := res;
End;

procedure CDBase.CloseQryMySQL;
Begin
    FADOQueryMySQL.Close;
End;


function CDBase.MyDeleteABON(abon : Integer): Boolean;
var
    sDeStr : String;
begin
    FADOQueryMySQL.SQL.Clear();
    sDeStr := 'DELETE FROM ABO';


    if (abon > 0) then // удалять по абоненту
        sDeStr := sDeStr + ' WHERE ABO='+IntToStr(abon);

    FADOQueryMySQL.SQL.Add(sDeStr);
    FADOQueryMySQL.ExecSQL();
    FADOQueryMySQL.Close();
end;



function CDBase.MyDeleteTUCH(abon, tuch : Integer): Boolean;
var
    sDeStr : String;
begin
    FADOQueryMySQL.SQL.Clear();
    sDeStr := 'DELETE FROM TUCH';


    if (abon > 0) then // удалять по абоненту
    begin
        sDeStr := sDeStr + ' WHERE ABO='+IntToStr(abon);
        if (tuch > 0) then // удалять по абоненту и точке учета
            sDeStr := sDeStr + ' AND TUCH='+IntToStr(tuch);
    end;

    FADOQueryMySQL.SQL.Add(sDeStr);
    FADOQueryMySQL.ExecSQL();
    FADOQueryMySQL.Close();
end;


function CDBase.MyDeleteValues(ds, de : TDateTime; abon, tuch : Integer) : Boolean;
var
    sDeStr : String;
    whereDef : String;
begin
    sDeStr := 'DELETE FROM BUF_V_INT ';
    whereDef := '';
    FADOQueryMySQL.SQL.Clear();
    if ((ds > 0) AND (de <> 0)) then
        whereDef := ' WHERE (CAST(DD_MM_YYYY AS DATE) BETWEEN "'+FormatDateTime('yyyy-mm-dd', ds) +'" AND "'+FormatDateTime('yyyy-mm-dd', de) +'")';

    if (abon > 0) then // удалять по абоненту
    begin
        if (whereDef='') then
            whereDef := ' WHERE AND ABO='+IntToStr(abon)
        else
            whereDef := whereDef + ' AND ABO='+IntToStr(abon);
        if (tuch > 0) then // удалять по абоненту и точке учета
            whereDef := whereDef + ' AND TUCH='+IntToStr(tuch);
    end;

    FADOQueryMySQL.SQL.Add(sDeStr+whereDef);
    FADOQueryMySQL.ExecSQL();
    FADOQueryMySQL.Close();
end;


function CDBase.MyMakeInsertAVT_EXP(_Table : L3DATASAVT_EXP): Integer;
begin
    try
        with _Table do
        m_sMySQLqStr := m_sMySQLqStr + 'INSERT INTO AVT_EXP'+
              '(ZAVN,KJU,ADR,UID,KOD_CH,TIPSH,UCH,DAT,VREM,Q1,V1,G1,TPOD,Q2,V2,G2,TOBR,TXV,TRAB,TRAB_O,NoTrab_o,N_GRUCH)'+
              ' VALUES('+
              ''''+ZAVN  +''''+','+
              ''''+KJU   +''''+','+
              ''''+ADR   +''''+','+
              IntToStr(UID)+ ','+
              IntToStr(KOD_CH)+ ','+
              ''''+TIPSH   +''''+','+
              IntToStr(UCH)+ ','+
              '''' + FormatDateTime('yyyy-mm-dd',DAT) +''''+','+
              '''' + FormatDateTime('hh:nn:ss',VREM) +''''+','+
              FloatToStr(Q1)+ ','+
              FloatToStr(V1)+ ','+
              FloatToStr(G1)+ ','+
              FloatToStr(TPOD)+ ','+
              FloatToStr(Q2)+ ','+
              FloatToStr(V2)+ ','+
              FloatToStr(G2)+ ','+
              FloatToStr(TOBR)+ ','+
              FloatToStr(TXV)+ ','+
              FloatToStr(TRAB)+ ','+
              FloatToStr(TRAB_O)+ ','+
              ''''+NoTrab_o   +''''+','+
              IntToStr(N_GRUCH)+ ');';
    except
    Result := -1;
    end;
end;


{*******************************************************************************
 *    Сохранение настроек, связанных с экспортом данных
 ******************************************************************************}
function CDBase.SaveDBFSettTable(var pTable:SGENSETTTAG):Boolean;
var
   l_QS : String;
begin
   Result := false;
   l_QS := 'UPDATE SGENSETTTAG ' +
           'SET ' +
           'M_SDBFLOCATION=''' + pTable.m_sDBFLOCATION + '''';
   Result := ExecQry(l_QS);
end;

              


function CDBase.GetVectorsTable(_dt : TDateTime; VMID : WORD; var _Table : SL3Vectors): Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    l_H, l_M, l_S, l_MS : WORD;
begin
   DecodeTime(_dt, l_H, l_M, l_S, l_MS);

   ReplaceTime(_dt, EncodeTime(l_H, (l_M div 30) * 30, 0, 0));
   strSQL := ' SELECT' +
             ' m_sfvalue' +
          ' FROM' +
             ' l3pdtdata' +
          ' WHERE' +
             ' m_swvmid=' + IntToStr(VMID) +
             ' and' +
             ' m_swtid=0 and (M_SWCMDID>45 AND M_SWCMDID<57 AND M_SWCMDID<>49)' +
             ' and' +
             ' CAST(m_stime AS DATE) =''' + DateToStr(_dt) + '''' +
             ' order by m_stime ASC, m_swcmdid asc;';

   res := False;
   if OpenQryD1(strSQL,nCount)=True then
   if ((nCount div 10) >0) then
   Begin
      i := 0;
      res := True;
      _Table.Count := nCount div 10;
      SetLength(_Table.Items, _Table.Count);
      
      while not FADOQueryD1.Eof do Begin
      with FADOQueryD1,_Table do  Begin
         Items[i].UA    := FieldByName('m_sfValue').AsFloat; Next();
         Items[i].UB    := FieldByName('m_sfValue').AsFloat; Next();
         Items[i].UC    := FieldByName('m_sfValue').AsFloat; Next();

         Items[i].IA    := FieldByName('m_sfValue').AsFloat; Next();
         Items[i].IB    := FieldByName('m_sfValue').AsFloat; Next();
         Items[i].IC    := FieldByName('m_sfValue').AsFloat; Next();

         Items[i].FREQ  := FieldByName('m_sfValue').AsFloat; Next();

         Items[i].COSFA := FieldByName('m_sfValue').AsFloat; Next();
         Items[i].COSFB := FieldByName('m_sfValue').AsFloat; Next();
         Items[i].COSFC := FieldByName('m_sfValue').AsFloat; Next();
         Inc(i);
      End;
      End;
   End;
    CloseQryD1;
    Result := res;

      (*
   _Table.Count := 1;
   SetLength(_Table.Items, 1);
 
   _Table.Items[0].DT := Trunc(_dt);

   _Table.Items[0].FREQ := 50.1;
   
   _Table.Items[0].IA := 0;
   _Table.Items[0].UA := 0;
   _Table.Items[0].COSFA := 0;

   _Table.Items[0].IB := 0;
   _Table.Items[0].UB := 0;
   _Table.Items[0].COSFB := 0;

   _Table.Items[0].IC := 0.1600749492645;
   _Table.Items[0].UC := 230.288604736328;
   _Table.Items[0].COSFC := 0.6765676736832;
   *)
//   Result := true;
end;

function CDBase.GetVectorsTable_48(_dt : TDateTime; VMID : WORD; var _Table : SL3Vectors_48): Boolean;
type
  TArray48D = array[0..47] of Double;
  PArray48D = ^TArray48D;
var
   strSQL,strV : AnsiString;
   nCount,i  : Integer;
   a, b, c : Extended;
   l_pArr48 : PArray48D;
begin
   Result := false;

   _dt := trunc(_dt);
   strSQL := ' SELECT DISTINCT ' +
             ' * ' +
          ' FROM' +
             ' l3pdtdata_48' +
          ' WHERE' +
             ' m_swvmid=' + IntToStr(VMID) +
             ' and' +
             ' M_SWCMDID IN(38,39,40,42,43,44,46,47,48,50,51,52,53,54,55,56)' +
             ' and' +
             ' CAST(m_sdtdate AS date)='''+DateToStr(trunc(_dt))+'''' +
             ' order by m_sdtdate ASC, m_swcmdid asc;';
try
   if OpenQryD1(strSQL,nCount)=True then
  begin
    Result := True;
    _Table.DT    := _dt;
    while (not FADOQueryD1.Eof) do
    begin
      _Table.DataMask := _Table.DataMask or (1 shl (FADOQueryD1.FieldByName('M_SWCMDID').AsInteger-32));
      case FADOQueryD1.FieldByName('M_SWCMDID').AsInteger of
        QRY_U_PARAM_A:   l_pArr48 := @_Table.UA;
        QRY_U_PARAM_B:   l_pArr48 := @_Table.UB;
        QRY_U_PARAM_C:   l_pArr48 := @_Table.UC;
        QRY_I_PARAM_A:   l_pArr48 := @_Table.IA;
        QRY_I_PARAM_B:   l_pArr48 := @_Table.IB;
        QRY_I_PARAM_C:   l_pArr48 := @_Table.IC;
        QRY_FREQ_NET:    l_pArr48 := @_Table.FREQ;
        QRY_KOEF_POW_A:  l_pArr48 := @_Table.COSFA;
        QRY_KOEF_POW_B:  l_pArr48 := @_Table.COSFB;
        QRY_KOEF_POW_C:  l_pArr48 := @_Table.COSFC;
        QRY_MGAKT_POW_A: l_pArr48 := @_Table.PA;
        QRY_MGAKT_POW_B: l_pArr48 := @_Table.PB;
        QRY_MGAKT_POW_C: l_pArr48 := @_Table.PC;
        QRY_MGREA_POW_A: l_pArr48 := @_Table.QA;
        QRY_MGREA_POW_B: l_pArr48 := @_Table.QB;
        QRY_MGREA_POW_C: l_pArr48 := @_Table.QC;
        else
          continue;
      end;
      for i:=0 to 47 do
        l_pArr48^[i] := FADOQueryD1.FieldByName('V'+IntToStr(i)).AsFloat;
      FADOQueryD1.Next();
      End;
   End;
    CloseQryD1;
except
 CloseQryD1;
end;
end;

{function CDBase.IsCoverOpen : boolean;
var strSQL   : string;
    nCount   : integer;
    LastEv   : integer;
begin
   if (m_nCheckPins = 1) and (m_nWDTTime > 0) and (m_nWDTTime <= 512) then
   begin
     strSQL := 'SELECT * FROM SEVENTTTAG WHERE m_swID=(' +
               'SELECT MAX(M_SWID) FROM SEVENTTTAG where M_SWGROUPID=0' +
               ' AND (M_SWEVENTID=' + IntToStr(EVH_OPN_COVER) +
               ' OR M_SWEVENTID=' + IntToStr(EVH_CLS_COVER) + '))';
     if OpenQry(strSQL,nCount)=True then
        LastEv := FADOQuery.FieldByName('M_SWEVENTID').AsInteger;
     if LastEv = EVH_OPN_COVER then
       Result := true
     else
       Result := false;
     CloseQry;
   end
   else
     Result := true;
end;  }

function CDBase.IsMonitorTag(var pTable:SMONITORDATA):Boolean;
Var
     strSQL   : String;
     res      : Boolean;
     nCount   : Integer;
Begin
     strSQL := 'SELECT 0 FROM SMONITORDATA'+
     ' WHERE m_swVMID='+IntToStr(pTable.m_swVMID)+
     ' and CAST(m_dtDate as DATE)='+''''+DateToStr(pTable.m_dtDate)+''''+
     ' and CmdID='+IntToStr(pTable.CmdID);
     res := False;
     if OpenQry(strSQL,nCount)=True then
     Begin
      res   := True;
     End;
     CloseQry;
     Result := res;
End;

function CDBase.SetMonTable(var pTable:SMONITORDATA):Boolean;
Var
     strSQL   : String;
     res      : Boolean;
     nCount   : Integer;
Begin
     res := True;
     strSQL := 'SELECT * FROM SMONITORDATA'+
     ' WHERE m_swVMID='+IntToStr(pTable.m_swVMID)+
     ' and CAST(m_dtDate as DATE)='+''''+DateToStr(pTable.m_dtDate)+''''+
     ' and CmdID='+IntToStr(pTable.CmdID);
     if OpenQry(strSQL,nCount)=True then
     Begin
      FADOQuery.Edit;
       FADOQuery.FieldByName('m_nCount').AsInteger := pTable.m_nCount;
       FADOQuery.FieldByName('m_nSize').AsInteger    := pTable.m_nSize;
       FADOQuery.FieldByName('m_nPeriod').AsInteger  := pTable.m_nPeriod;
       TBlobField(FADOQuery.FieldByName('m_nData')).LoadFromStream(pTable.m_nData);
      FADOQuery.Post;
     End;
     CloseQry;
     Result :=res;
End;

function CDBase.AddMonTable(var pTable:SMONITORDATA):Boolean;
Var
     strSQL   : String;
Begin
     if IsMonitorTag(pTable)=True then Begin SetMonTable(pTable);Result:=False;exit;End;
     with pTable do
     Begin
     strSQL := 'INSERT INTO SMONITORDATA'+
               '(m_swVMID,m_nCount,m_nSize,m_nPeriod,CmdID,m_dtDate,m_nData)'+
               ' VALUES('+
               IntToStr(m_swVMID)+  ','+
               IntToStr(m_nCount)+  ','+
               IntToStr(m_nSize)+  ','+
               IntToStr(m_nPeriod)+  ','+
               IntToStr(CmdID)+  ','+
               ''''+DateTimeToStr(m_dtDate)+''''+ ','+
               '0'+')';
      End;
      Result := ExecQry(strSQL);
      SetMonTable(pTable);
End;
//select * from l2tag where m_sbyPortID = 1 order by m_swMID
function CDBase.GetFirstObjFromPort(PortID:integer):integer;
Var
     strSQL   : String;
     nCount   : Integer;
Begin
     strSQL := 'SELECT * FROM l2tag'+
     ' WHERE m_sbyPortID='+IntToStr(PortID)+
     ' ORDER by m_swMID';
     if OpenQry(strSQL,nCount)=True then
       Result := FADOQuery.FieldByName('m_swMID').AsInteger
     else
       Result := 0;
     CloseQry;
End;
{
    SQWERYSRV = packed record
     m_snID     : Integer;
     m_snAID    : Integer;
     m_snSRVID  : Integer;
     m_sName    : String[30];
     m_sbyEnable:Byte;
     Item      : SQWERYVMS;
    End;
function GetQwerySRVTable(snSRVID:Integer;var pTable:SQWERYSRVS):Boolean;
function IsQwerySRVTable(var pTable:SQWERYSRV):Boolean;
function SetQwerySRVTable(var pTable:SQWERYSRV):Boolean;
function AddQwerySRVTable(var pTable:SQWERYSRV):Boolean;
function DelQwerySRVTable(snSRVID:Integer):Boolean;
}
function CDBase.GetQweryFullSRVTable(snAID,snSRVID,snCLID:Integer;var pTable:SQWERYSRVS):Boolean;
Var
    i,j : Integer;
Begin
    Result := False;
    if GetQwerySRVTable(snAID,snSRVID,pTable)=True then
    Begin
     Result := True;
     for j:=0 to pTable.Count-1 do
      if GetQweryVMTable(pTable.Items[j].m_snSRVID,snCLID,pTable.Items[j].Item)=True then
       with pTable.Items[j].Item do
        for i:=0 to Count-1 do
        GetQweryMDLTable(Items[i].m_snCLID,Items[i].Item);
         //Result := Result or GetQweryMDLTable(Items[i].m_snCLID,Items[i].Item);
    End;
End;
function CDBase.GetQwerySRVTable(snAID,snSRVID:Integer;var pTable:SQWERYSRVS):Boolean;
Var
    i      : Integer;
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
Begin
    res    := False;
    if (snAID<>-1)and(snSRVID<>-1) then strSQL := 'select * from SQWERYSRV where m_snAID='+IntToStr(snAID)+' and m_snSRVID='+IntToStr(snSRVID)+' ORDER BY m_snSRVID' else
    if (snAID<>-1)and(snSRVID=-1)  then strSQL := 'select * from SQWERYSRV where m_snAID='+IntToStr(snAID)+' ORDER BY m_snSRVID';
    if (snAID=-1) and(snSRVID=-1)  then strSQL := 'select * from SQWERYSRV'+' ORDER BY m_snSRVID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_snID      := FieldByName('m_snID').AsInteger;
      m_snAID     := FieldByName('m_snAID').AsInteger;
      m_snSRVID   := FieldByName('m_snSRVID').AsInteger;
      m_sName     := FieldByName('m_sName').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_nSrvWarning := FieldByName('m_nSrvWarning').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.IsQwerySRVTable(var pTable:SQWERYSRV):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SQWERYSRV WHERE m_snAID='+IntToStr(pTable.m_snAID)+' and m_snSRVID='+IntToStr(pTable.m_snSRVID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetQwerySRVTable(var pTable:SQWERYSRV):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SQWERYSRV SET '+
              ' m_snAID='        +IntToStr(m_snAID)+
              ',m_snSRVID='      +IntToStr(m_snSRVID)+
              ',m_sName='+''''+m_sName+''''+
              ',m_sbyEnable='    +IntToStr(m_sbyEnable)+
              ',m_nSrvWarning='  +IntToStr(m_nSrvWarning)+
              ' WHERE m_snAID='+IntToStr(m_snAID)+' and m_snSRVID='+IntToStr(m_snSRVID);
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.AddQwerySRVTable(var pTable:SQWERYSRV):Boolean;
Var
    strSQL   : String;
Begin
    if IsQwerySRVTable(pTable)=True then Begin SetQwerySRVTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SQWERYSRV'+
              '(m_snAID,m_snSRVID,m_sName,m_nSrvWarning,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_snAID)+ ','+
              IntToStr(m_snSRVID)+ ','+
              ''''+m_sName+''''+ ','+
              IntToStr(m_nSrvWarning)+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.SetSrvParam(snAID,snSRVID:Integer;str:String):Boolean;
Var
    strSQL  : String;
    strPred : String;
Begin
    if (snSRVID<>-1) then strPred := ' WHERE m_snAID='+IntToStr(snAID)+' and m_snSRVID='+IntToStr(snSRVID) else
    if (snSRVID=-1)  then strPred := ' WHERE m_snAID='+IntToStr(snAID);
    strSQL := 'UPDATE SQWERYSRV SET '+str+strPred;
    Result := ExecQry(strSQL);
End;
function CDBase.DelQwerySRVTable(snAID,snSRVID:Integer):Boolean;
Var
    strSQL : String;
Begin
    if snSRVID<>-1 then strSQL := 'DELETE FROM SQWERYSRV WHERE m_snAID='+IntToStr(snAID)+' and m_snSRVID='+IntToStr(snSRVID) else
    if snSRVID=-1  then strSQL := 'DELETE FROM SQWERYSRV WHERE m_snAID='+IntToStr(snAID);
    Result := ExecQry(strSQL);
End;
function CDBase.GetEntasJoin(nMID:Integer;var pTable:SQWERYVMS):Boolean;
Var
    i,nPID : Integer;
    strSQL,sFilter : String;
    res    : Boolean;
    nCount : Integer;
Begin
    res    := False;
    GetMeterPortID(nMID,nPID);
    strSQL := 'select distinct s0.m_swVMID,s0.m_swMID,s0.m_sbyPortID'+
              ' from SL3VMETERTAG as s0,L2TAG as s1'+
              ' where s0.m_swMID=s1.m_swMID'+
              //' and s1.M_SDDPHADDRES<>-1'+
              ' and s1.M_SBYPORTID='+IntToStr(nPID);
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_snVMID  := FieldByName('m_swVMID').AsInteger;
      m_snMID   := FieldByName('m_swMID').AsInteger;
      m_snPID   := FieldByName('m_sbyPortID').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetQweryVMTable(snSRVID,snCLID:Integer;var pTable:SQWERYVMS):Boolean;
Var
    i      : Integer;
    strSQL,sFilter : String;
    res    : Boolean;
    nCount : Integer;
Begin
    res    := False;
    if (snSRVID<>-1)and(snCLID<>-1) then strSQL := 'select * from SQWERYVM where m_snSRVID='+IntToStr(snSRVID)+' and m_snCLID='+IntToStr(snCLID) else
    if (snSRVID<>-1)and(snCLID=-1)  then strSQL := 'select * from SQWERYVM where m_snSRVID='+IntToStr(snSRVID) else
    if (snSRVID=-1)                 then strSQL := 'select * from SQWERYVM';
    pTable.Count := 0;
    sFilter := '1,4,8,9,11,12';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_snCLID  := FieldByName('m_snCLID').AsInteger;
      m_snSRVID := FieldByName('m_snSRVID').AsInteger;
      m_snVMID  := FieldByName('m_snVMID').AsInteger;
      m_snMID   := FieldByName('m_snMID').AsInteger;
      m_snTPID  := FieldByName('m_snTPID').AsInteger;
      m_snPID   := FieldByName('m_snPID').AsInteger;
      m_sName   := FieldByName('m_sName').AsString;
      Next;
      Inc(i);
      //GetCommandsFTable(m_snMID,sFilter,Commands);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetQweryVM(snSRVID,snCLID:Integer;var pTable:SQWERYVM):Boolean;
Var
    i      : Integer;
    strSQL,sFilter : String;
    res    : Boolean;
    nCount : Integer;
Begin
    res    := False;
    if (snSRVID<>-1)and(snCLID<>-1) then strSQL := 'select * from SQWERYVM where m_snSRVID='+IntToStr(snSRVID)+' and m_snCLID='+IntToStr(snCLID) else exit;
    sFilter := '1,4,8,9,11,12';
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
     with FADOQuery,pTable do  Begin
      m_snCLID  := FieldByName('m_snCLID').AsInteger;
      m_snSRVID := FieldByName('m_snSRVID').AsInteger;
      m_snVMID  := FieldByName('m_snVMID').AsInteger;
      m_snMID   := FieldByName('m_snMID').AsInteger;
      m_snTPID  := FieldByName('m_snTPID').AsInteger;
      m_snPID   := FieldByName('m_snPID').AsInteger;
      m_sName   := FieldByName('m_sName').AsString;
      //GetCommandsFTable(m_snMID,sFilter,Commands);
     End;
    End;
    CloseQry;
    if nCount<>0 then res:=GetQweryMDLTable(pTable.m_snCLID,pTable.Item);
    Result := res;
End;
function CDBase.IsQweryVMTable(var pTable:SQWERYVM):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SQWERYVM WHERE m_snSRVID='+IntToStr(pTable.m_snSRVID)+' and m_snCLID='+IntToStr(pTable.m_snCLID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetQweryVMTable(var pTable:SQWERYVM):Boolean;
Var
    strSQL   : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE SQWERYVM SET '+
              ' m_snVMID=' +IntToStr(m_snVMID)+
              ',m_snMID='  +IntToStr(m_snMID)+
              ',m_snTPID=' +IntToStr(m_snTPID)+
              ',m_snPID='  +IntToStr(m_snPID)+
              ',m_sName='  +''''+m_sName+''''+
              ' WHERE m_snSRVID='+IntToStr(m_snSRVID)+' and m_snCLID='+IntToStr(m_snCLID);
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.AddQweryVMTable(var pTable:SQWERYVM):Boolean;
Var
    strSQL   : String;
Begin
    if IsQweryVMTable(pTable)=True then Begin SetQweryVMTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SQWERYVM'+
              '(m_snCLID,m_snSRVID,m_snVMID,m_snMID,m_snTPID,m_sName,m_snPID)'+
              ' VALUES('+
              IntToStr(m_snCLID)+ ','+
              IntToStr(m_snSRVID)+ ','+
              IntToStr(m_snVMID)+ ','+
              IntToStr(m_snMID)+ ','+
              IntToStr(m_snTPID)+ ','+
              ''''+m_sName+''''+ ','+
              IntToStr(m_snPID)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelQweryVMTable(snSRVID,snCLID:Integer):Boolean;
Var
    strSQL : String;
Begin
    if snCLID<>-1 then strSQL := 'DELETE FROM SQWERYVM WHERE m_snSRVID='+IntToStr(snSRVID)+' and m_snCLID='+IntToStr(snCLID) else
    if snCLID=-1  then strSQL := 'DELETE FROM SQWERYVM WHERE m_snSRVID='+IntToStr(snSRVID);
    Result := ExecQry(strSQL);
End;


function CDBase.GetQweryMDLTable(snCLID:Integer;var pTable:SQWERYMDLS):Boolean;
Var
    i : Integer;
    strSQL,str : String;
    res    : Boolean;
    nCount : Integer;
    nCMD   : Integer;
Begin
    res    := False;
    if snCLID<>-1 then strSQL := 'select * from SQWERYMDL where m_snCLID='+IntToStr(snCLID)+' order by m_snCLSID' else
    if snCLID= -1 then strSQL := 'select * from SQWERYMDL order by m_snCLSID';
    pTable.Count := 0;
    //sFilter := '1,4,8,9,11,12';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_snID         := FieldByName('m_snID').AsInteger;
      m_snAID        := FieldByName('m_snAID').AsInteger;
      m_snSRVID      := FieldByName('m_snSRVID').AsInteger;
      m_snVMID       := FieldByName('m_snVMID').AsInteger;
      m_snMID        := FieldByName('m_snMID').AsInteger;
      m_snPID        := FieldByName('m_snPID').AsInteger;
      m_snCLID       := FieldByName('m_snCLID').AsInteger;
      m_snCLSID      := FieldByName('m_snCLSID').AsInteger;
      m_sdtBegin     := FieldByName('m_sdtBegin').AsDateTime;
      m_sdtEnd       := FieldByName('m_sdtEnd').AsDateTime;
      m_sdtPeriod    := FieldByName('m_sdtPeriod').AsDateTime;
      m_swDayMask    := FieldByName('m_swDayMask').AsInteger;
      m_sdwMonthMask := FieldByName('m_sdwMonthMask').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_sbyPause     := FieldByName('m_sbyPause').AsInteger;
      m_sbyFindData  := FieldByName('m_sbyFindData').AsInteger;
      m_snDeepFind   := FieldByName('m_snDeepFind').AsInteger;
      m_strCMDCluster:= FieldByName('m_strCMDCluster').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetQweryMDLOneTable(snCLID,snCLSID:Integer;var pTable:SQWERYMDLS):Boolean;
Var
    i : Integer;
    strSQL,str : String;
    res    : Boolean;
    nCount : Integer;
    nCMD   : Integer;
Begin
    res    := False;
    if snCLSID<>-1 then strSQL := 'select * from SQWERYMDL where m_snCLID='+IntToStr(snCLID)+' and m_snCLSID='+IntToStr(snCLSID)+' order by m_snCLSID' else
    if snCLSID= -1 then strSQL := 'select * from SQWERYMDL where m_snCLID='+IntToStr(snCLID)+' order by m_snCLSID';
    pTable.Count := 0;
    //sFilter := '1,4,8,9,11,12';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_snID         := FieldByName('m_snID').AsInteger;
      m_snAID        := FieldByName('m_snAID').AsInteger;
      m_snSRVID      := FieldByName('m_snSRVID').AsInteger;
      m_snVMID       := FieldByName('m_snVMID').AsInteger;
      m_snMID        := FieldByName('m_snMID').AsInteger;
      m_snPID        := FieldByName('m_snPID').AsInteger;
      m_snCLID       := FieldByName('m_snCLID').AsInteger;
      m_snCLSID      := FieldByName('m_snCLSID').AsInteger;
      m_sdtBegin     := FieldByName('m_sdtBegin').AsDateTime;
      m_sdtEnd       := FieldByName('m_sdtEnd').AsDateTime;
      m_sdtPeriod    := FieldByName('m_sdtPeriod').AsDateTime;
      m_swDayMask    := FieldByName('m_swDayMask').AsInteger;
      m_sdwMonthMask := FieldByName('m_sdwMonthMask').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_sbyPause     := FieldByName('m_sbyPause').AsInteger;
      m_sbyFindData  := FieldByName('m_sbyFindData').AsInteger;
      m_snDeepFind   := FieldByName('m_snDeepFind').AsInteger;
      m_strCMDCluster:= FieldByName('m_strCMDCluster').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.GetCluster(snCLID,snCLSID:Integer):String;
Var
    strSQL : String;
    nCount : Integer;
Begin
    Result := '';
    strSQL := 'select m_strCMDCluster from SQWERYMDL where m_snCLID='+IntToStr(snCLID)+' and m_snCLSID='+IntToStr(snCLSID)+' order by m_snCLSID';
    if OpenQry(strSQL,nCount)=True then
    Result:= FADOQuery.FieldByName('m_strCMDCluster').AsString;
    CloseQry;
End;
function CDBase.GetQweryMaskMDLTable(sVMID:Integer;sSRVID:String;var pTable:SQWERYMDLS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res    := False;
    if sVMID<>-1 then
    strSQL := 'select distinct * from SQWERYMDL'+
    ' where m_snVMID='+IntToStr(sVMID)+
    ' and m_snSRVID IN ('+sSRVID+')' else
    if sVMID=-1 then
    strSQL := 'select distinct * from SQWERYMDL'+
    ' where m_snSRVID IN ('+sSRVID+')';
    pTable.Count := 0;
    if OpenQryD1(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQueryD1.Eof do Begin
     with FADOQueryD1,pTable.Items[i] do  Begin
      m_snID         := FieldByName('m_snID').AsInteger;
      m_snAID        := FieldByName('m_snAID').AsInteger;
      m_snSRVID      := FieldByName('m_snSRVID').AsInteger;
      m_snCLID       := FieldByName('m_snCLID').AsInteger;
      m_snVMID       := FieldByName('m_snVMID').AsInteger;
      m_snMID        := FieldByName('m_snMID').AsInteger;
      m_snPID        := FieldByName('m_snPID').AsInteger;
      m_snCLSID      := FieldByName('m_snCLSID').AsInteger;
      m_sdtBegin     := FieldByName('m_sdtBegin').AsDateTime;
      m_sdtEnd       := FieldByName('m_sdtEnd').AsDateTime;
      m_sdtPeriod    := FieldByName('m_sdtPeriod').AsDateTime;
      m_swDayMask    := FieldByName('m_swDayMask').AsInteger;
      m_sdwMonthMask := FieldByName('m_sdwMonthMask').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_sbyPause     := FieldByName('m_sbyPause').AsInteger;
      m_sbyFindData  := FieldByName('m_sbyFindData').AsInteger;
      m_snDeepFind   := FieldByName('m_snDeepFind').AsInteger;
      m_strCMDCluster:= FieldByName('m_strCMDCluster').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQryD1;
    Result := res;
End;
function CDBase.IsQweryMDLTable(var pTable:SQWERYMDL):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM SQWERYMDL WHERE m_snCLID='+IntToStr(pTable.m_snCLID)+' and m_snCLSID='+IntToStr(pTable.m_snCLSID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBase.SetQweryMDLTable(var pTable:SQWERYMDL):Boolean;
Var
    strSQL  : String;
    strPred : String;
BEgin
    with pTable do
    Begin
    if (m_snCLID=-1) and(m_snSRVID=-1)  then strPred := ' WHERE m_snCLSID='+IntToStr(m_snCLSID) else
    if (m_snCLID<>-1)and(m_snSRVID<>-1) then strPred := ' WHERE m_snSRVID='+IntToStr(m_snSRVID)+' and m_snCLID='+IntToStr(m_snCLID)+' and m_snCLSID='+IntToStr(m_snCLSID) else
    if (m_snCLID= -1)and(m_snSRVID<>-1) then strPred := ' WHERE m_snSRVID='+IntToStr(m_snSRVID)+' and m_snCLSID='+IntToStr(m_snCLSID);
    strSQL := 'UPDATE SQWERYMDL SET '+
              ' m_snAID='        +IntToStr(m_snAID)+
              ',m_snVMID='       +IntToStr(m_snVMID)+
              ',m_snMID='        +IntToStr(m_snMID)+
              ',m_snPID='        +IntToStr(m_snPID)+
              ',m_snCLSID='      +IntToStr(m_snCLSID)+
              ',m_sdtBegin='     +''''+DateTimeToStr(m_sdtBegin)+''''+
              ',m_sdtEnd='       +''''+DateTimeToStr(m_sdtEnd)+''''+
              ',m_sdtPeriod='    +''''+DateTimeToStr(m_sdtPeriod)+''''+
              ',m_swDayMask='    +IntToStr(m_swDayMask)+
              ',m_sdwMonthMask=' +IntToStr(m_sdwMonthMask)+
              ',m_sbyEnable='    +IntToStr(m_sbyEnable)+
              ',m_sbyPause='    +IntToStr(m_sbyPause)+
              ',m_sbyFindData='  +IntToStr(m_sbyFindData)+
              ',m_snDeepFind='   +IntToStr(m_snDeepFind)+
              ',m_strCMDCluster='+''''+m_strCMDCluster+''''+
              strPred;
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.SetQweryMDLTableEx(var pTable:SQWERYMDL):Boolean;
Var
    strSQL,strCLID  : String;
    strPred : String;
BEgin
    with pTable do
    Begin
    if (m_snAID<>-1)and(m_snSRVID<>-1) then
    strCLID := 'SELECT distinct m_snCLID'+
    ' FROM SQWERYMDL as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2 WHERE s1.m_sbyGroupID=s2.m_sbyGroupID'+
    ' and s1.M_NGROUPLV=0 and s0.m_snAID=s1.m_swABOID and s0.m_snVMID=s2.m_swVMID'+
    ' and s0.m_snAID='+IntToStr(m_snAID)+
    ' and s0.m_snSRVID='+IntToStr(m_snSRVID) else
    if (m_snAID<>-1)and(m_snSRVID=-1) then
    strCLID := 'SELECT distinct m_snCLID'+
    ' FROM SQWERYMDL as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2 WHERE s1.m_sbyGroupID=s2.m_sbyGroupID'+
    ' and s1.M_NGROUPLV=0 and s0.m_snAID=s1.m_swABOID and s0.m_snVMID=s2.m_swVMID'+
    ' and s0.m_snAID='+IntToStr(m_snAID) else
    if (m_snAID=-1)and(m_snSRVID=-1) then
    strCLID := 'SELECT distinct m_snCLID'+
    ' FROM SQWERYMDL as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2 WHERE s1.m_sbyGroupID=s2.m_sbyGroupID'+
    ' and s1.M_NGROUPLV=0 and s0.m_snAID=s1.m_swABOID and s0.m_snVMID=s2.m_swVMID';
    strSQL := 'UPDATE SQWERYMDL SET '+
              //' m_snAID='        +IntToStr(m_snAID)+
              //',m_snVMID='       +IntToStr(m_snVMID)+
              //',m_snMID='        +IntToStr(m_snMID)+
              //',m_snPID='        +IntToStr(m_snPID)+
              //',m_snCLSID='      +IntToStr(m_snCLSID)+
              ' m_sdtBegin='     +''''+DateTimeToStr(m_sdtBegin)+''''+
              ',m_sdtEnd='       +''''+DateTimeToStr(m_sdtEnd)+''''+
              ',m_sdtPeriod='    +''''+DateTimeToStr(m_sdtPeriod)+''''+
              ',m_swDayMask='    +IntToStr(m_swDayMask)+
              ',m_sdwMonthMask=' +IntToStr(m_sdwMonthMask)+
              ',m_sbyEnable='    +IntToStr(m_sbyEnable)+
              ',m_sbyPause='    +IntToStr(m_sbyPause)+
              ',m_sbyFindData='  +IntToStr(m_sbyFindData)+
              ',m_snDeepFind='   +IntToStr(m_snDeepFind)+
              ',m_strCMDCluster='+''''+m_strCMDCluster+''''+
              ' where m_snCLSID='+IntToStr(m_snCLSID)+
              ' and m_snCLID in ('+strCLID+')';
              //strPred+' and m_snCLID in ('+strCLID+')';
   End;
   Result := ExecQry(strSQL);
End;
function CDBase.SetMdlParam(snAID,snSRVID,snCLID,snCLSID:Integer;str:String):Boolean;
Var
    strSQL  : String;
    strPred : String;
Begin
    if (snAID<>-1)and(snSRVID<>-1)and(snCLID<>-1)and(snCLSID<>-1) then strPred := ' WHERE m_snAID='+IntToStr(snAID)+' and m_snSRVID='+IntToStr(snSRVID)+' and m_snCLID='+IntToStr(snCLID)+' and m_snCLSID='+IntToStr(snCLSID) else
    if (snAID<>-1)and(snSRVID<>-1)and(snCLID=-1) and(snCLSID<>-1) then strPred := ' WHERE m_snAID='+IntToStr(snAID)+' and m_snSRVID='+IntToStr(snSRVID)+' and m_snCLSID='+IntToStr(snCLSID) else
    if (snAID<>-1)and(snSRVID<>-1)and(snCLID=-1) and(snCLSID=-1)  then strPred := ' WHERE m_snAID='+IntToStr(snAID)+' and m_snSRVID='+IntToStr(snSRVID) else
    if (snAID=-1) and(snSRVID=-1) and(snCLID=-1) and(snCLSID<>-1) then strPred := ' WHERE m_snCLSID='+IntToStr(snCLSID);
    strSQL := 'UPDATE SQWERYMDL SET '+str+strPred;
    Result := ExecQry(strSQL);
End;
function CDBase.SetMdlParamEx(snAID,snSRVID,snCLID,snCLSID:Integer;str:String):Boolean;
Var
    strSQL  : String;
    strPred : String;
    strCLID : String;
Begin
    strCLID := 'SELECT distinct m_snCLID'+
    ' FROM SQWERYMDL as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2'+
    ' WHERE s1.m_sbyGroupID=s2.m_sbyGroupID'+
    ' and s1.M_NGROUPLV=0'+
    ' and s0.m_snAID=s1.m_swABOID'+
    ' and s0.m_snVMID=s2.m_swVMID'+
    ' and s0.m_snAID='+IntToStr(snAID)+
    ' and s0.m_snSRVID='+IntToStr(snSRVID);
    if (snCLID<>-1)and(snCLSID<>-1) then strPred := ' WHERE m_snAID='+IntToStr(snAID)+' and m_snSRVID='+IntToStr(snSRVID)+' and m_snCLID='+IntToStr(snCLID)+' and m_snCLSID='+IntToStr(snCLSID) else
    if (snCLID=-1) and(snCLSID<>-1) then strPred := ' WHERE m_snAID='+IntToStr(snAID)+' and m_snSRVID='+IntToStr(snSRVID)+' and m_snCLSID='+IntToStr(snCLSID) else
    if (snCLID=-1) and(snCLSID=-1)  then strPred := ' WHERE m_snAID='+IntToStr(snAID)+' and m_snSRVID='+IntToStr(snSRVID);
    strSQL := 'UPDATE SQWERYMDL SET '+str+strPred+' and m_snCLID in ('+strCLID+')';
    Result := ExecQry(strSQL);
End;
function CDBase.AddMDLTable(var pTable:SQWERYMDL):Boolean;
Begin
    Result:=False;
    if IsQweryMDLTable(pTable)=True then Begin SetQweryMDLTable(pTable);Result:=True;exit;End;
End;
function CDBase.AddQweryMDLTable(var pTable:SQWERYMDL):Boolean;
Var
    strSQL   : String;
Begin
    if IsQweryMDLTable(pTable)=True then Begin SetQweryMDLTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO SQWERYMDL'+
              '(m_snAID,m_snVMID,m_snSRVID,m_snCLID,m_snMID,m_snPID,m_snCLSID,m_sdtBegin,m_sdtEnd,m_sdtPeriod,m_swDayMask,m_sdwMonthMask,m_strCMDCluster,m_sbyFindData,m_snDeepFind,m_sbyPause,m_sbyEnable)'+
              ' VALUES('+
              IntToStr(m_snAID)+ ','+
              IntToStr(m_snVMID)+ ','+
              IntToStr(m_snSRVID)+ ','+
              IntToStr(m_snCLID)+ ','+
              IntToStr(m_snMID)+ ','+
              IntToStr(m_snPID)+ ','+
              IntToStr(m_snCLSID)+ ','+
              ''''+DateTimeToStr(m_sdtBegin)+''''+ ','+
              ''''+DateTimeToStr(m_sdtEnd)+''''+ ','+
              ''''+DateTimeToStr(m_sdtPeriod)+''''+ ','+
              IntToStr(m_swDayMask)+ ','+
              IntToStr(m_sdwMonthMask)+ ','+
              ''''+m_strCMDCluster+''''+ ','+
              IntToStr(m_sbyFindData)+ ','+
              IntToStr(m_snDeepFind)+ ','+
              IntToStr(m_sbyPause)+ ','+
              IntToStr(m_sbyEnable)+ ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBase.DelQweryMDLVMIDTable(nCLID:Integer):Boolean;
Var
    strSQL : String;
Begin
    strSQL := 'DELETE FROM SQWERYMDL WHERE m_snCLID='+IntToStr(nCLID);
    Result := ExecQry(strSQL);
End;
function CDBase.DelQweryMDLCMDIDTable(nSRVID,nCLID:Integer;snCLSID:Integer):Boolean;
Var
    strSQL : String;
Begin
    if (nSRVID<>-1)and(nCLID<>-1)and(snCLSID<>-1) then
    strSQL := 'DELETE FROM SQWERYMDL WHERE m_snSRVID='+IntToStr(nSRVID)+' and m_snCLID='+IntToStr(nCLID)+' and  m_snCLSID='+IntToStr(snCLSID) else
    if (nSRVID<>-1)and(nCLID=-1)and(snCLSID<>-1) then
    strSQL := 'DELETE FROM SQWERYMDL WHERE m_snSRVID='+IntToStr(nSRVID)+' and  m_snCLSID='+IntToStr(snCLSID);
    Result := ExecQry(strSQL);
End;

function CDBase.GetQweryStruct(sVMID,sFilter:String;var pTable:SQWERYMDLCOMMS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
begin
    Res := false;
    strSQL := 'select distinct t1.m_swmid, t1.m_sbyportid, t2.m_swvmid,t2.m_sVMeterName,t2.M_SBYTYPE,t2.m_sbyGroupID,t3.m_swaboid'+
              ' from l2tag as t1, sl3vmetertag as t2,sl3grouptag as t3' +
              ' where t1.m_swmid=t2.m_swmid and t3.m_sbyGroupID=t2.m_sbyGroupID'+
              ' and t2.m_swvmid IN (' + sVMID + ')';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swABOID:= FieldByName('m_swaboid').AsInteger;
      m_swVMID := FieldByName('m_swvmid').AsInteger;
      m_swGID  := FieldByName('m_sbyGroupID').AsInteger;
      m_swMID  := FieldByName('m_swmid').AsInteger;
      m_swPID  := FieldByName('m_sbyportid').AsInteger;
      m_sName  := FieldByName('m_sVMeterName').AsString;
      m_swTMID := FieldByName('M_SBYTYPE').AsInteger;
      Next;
      Inc(i);
      GetCommandsFTable(m_swMID,sFilter,Commands);
      GetQweryMaskMDLTable(m_swVMID,sFilter,QweryMDLS);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;

function CDBase.GetSchemsTable(var pTable: SL3SCHEMTABLES):boolean;
Var
    strSQL      : String;
    res         : Boolean;
    nCount, i   : Integer;
Begin
    strSQL := 'SELECT * FROM SL3SCHEMTABLE';
    res := False;
    pTable.Count := 0;
    if OpenQryD(strSQL,nCount)=True then
    Begin
     i := 0; res   := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQueryD.Eof do Begin
      with FADOQueryD,pTable.Items[i] do  Begin
       m_swID          := FieldByName('m_swID').AsInteger;
       m_swNodeNum     := FieldByName('m_swNodeNum').AsInteger;
       m_swSubNodeNum  := FieldByName('m_swSubNodeNum').AsInteger;
       m_sNodeName     := FieldByName('m_sNodeName').AsString;
       m_sPathToFile   := FieldByName('m_sPathToFile').AsString;
       Next;
       Inc(i);
      End;
     End;
    End;
    CloseQryD;
    Result := res;
End;

function CDBase.UpdateSchemTable(ID : integer; var pTable : SL3SCHEMTABLE):boolean;
Var
    strSQL      : String;
begin
   strSQL := 'UPDATE SL3SCHEMTABLE SET ' +
              'm_swNodeNum = ' +  IntToStr(pTable.m_swNodeNum) +
              ',m_swSubNodeNum = ' + IntToStr(pTable.m_swSubNodeNum) +
              ',m_sNodeName = ' + '''' + pTable.m_sNodeName + '''' +
              ',m_sPathToFile = ' + '''' + pTable.m_sPathToFile + '''' +
              ' where m_swID=' + IntToStr(ID);
   Result := ExecQryD(strSQL);
end;

function CDBase.DeleteSchemTable(ID : integer):boolean;
var strSQL : string;
begin
    strSQL := 'delete from SL3SCHEMTABLE where m_swID=' + IntToStr(ID);
    Result := ExecQryD(strSQL);
end;

function CDBase.AddSchemTable(var pTable : SL3SCHEMTABLE):boolean;
var strSQL : String;
begin
    strSQL := 'INSERT INTO SL3SCHEMTABLE ' +
              '(m_swNodeNum, m_swSubNodeNum, m_sNodeName, m_sPathToFile)' +
              ' VALUES(' +
              IntToStr(pTable.m_swNodeNum) + ',' +
              IntToStr(pTable.m_swSubNodeNum) + ',' +
              '''' + pTable.m_sNodeName + '''' + ',' +
              '''' + pTable.m_sPathToFile + '''' + ')';
    Result := ExecQryD(strSQL);
end;

function CDBase.GetCurrentDataForSchems(var CMDIDStr, VMIDStr : String;var pTable:L3CURRENTDATAS):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    if (Length(VMIDStr) > 2) and (Length(CMDIDStr) > 2) then
      strSQL := 'SELECT *'+
                ' FROM L3CURRENTDATA WHERE m_swTID = 0 and m_swVMID in'+ VMIDStr+
                ' and m_swCMDID in'+CMDIDStr
    else
    begin
      pTable.Count := 0;
      exit;
    end;
    res := False;
    pTable.Count := 0;
    if OpenQryD(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQueryD.Eof do Begin
     with FADOQueryD,pTable.Items[i] do  Begin
      m_swID    := i;
      m_swVMID  := FieldByName('m_swVMID').AsInteger;
      m_swTID   := FieldByName('m_swTID').AsInteger;
      m_swCMDID := FieldByName('m_swCMDID').AsInteger;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      m_sfValue := FieldByName('m_sfValue').AsFloat;
      m_CRC     := FieldByName('m_CRC').AsInteger;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQryD;
    Result := res;
End;

function CDBase.GetFormulaForVMID(VMID : integer):string;
Var
    strSQL   : AnsiString;
    nCount   : Integer;
begin
    Result := '[x]';
    strSQL := 'select M_SGROUPEXPRESS from SL3GROUPTAG, sl3vmetertag where ' +
              ' SL3GROUPTAG.m_sbygroupid = sl3vmetertag.m_sbygroupid and ' +
              ' m_swVMID = ' + IntToStr(VMID);
    if OpenQryD(strSQL,nCount)=True then
    Begin
      with FADOQueryD do
        Result := FieldByName('M_SGROUPEXPRESS').AsString;
    End;
    CloseQryD;
end;

function CDBase.LoadTID(ParamID : word) : word;
var strSQL : AnsiString;
    nCount : integer;
begin
   Result := 0;
   strSQL := 'SELECT m_sblTarif FROM QM_PARAMS where m_swType = ' + IntToStr(ParamID);
   if OpenQryD(strSQL, nCOunt) = true then
     Result := FADOQueryD.FieldByName('m_sblTarif').AsInteger;
   CloseQryD;
end;

function CDBase.GetCurrLimitValue(VMID, CMDID, TID : integer):double;
var nCount    : integer;
    strSQL    : string;
begin
   Result := 0;
   strSQL := 'SELECT m_swMaxValue FROM SL3LIMITTAG WHERE m_swVMID = ' + IntToStr(VMID) +
             ' AND m_swCMDID = ' + IntToStr(CMDID) + ' AND m_swTID = ' + IntToStr(TID) +
             ' and ' + '''' + DateTimeToStr(Now) + '''' + '>=m_sDateBeg ' +
             ' and ' + ''''  + DateTimeToStr(Now) + '''' + '<=m_sDateEnd';
   if OpenQryD(strSQL, nCount) then
   begin
     with FADOQueryD do
       Result    := FieldByName('m_swMaxValue').AsFloat;
   end;
   CloseQryD;
end;

function CDBase.GetFirstEntasNetPIDAndMID(var PID, MID : integer):boolean;
var nCount    : integer;
    strSQL    : string;
    res       : boolean;
begin
   res := false;
   strSQL := 'select l1tag.m_sbyportid, l2tag.m_swmid from l1tag, l2tag where l1tag.m_sbyportid = l2tag.m_sbyportid ' +
             ' and l2tag.m_sbytype = ' + IntToStr(MET_ENTASNET) +
             ' and l2tag.m_sbyenable = 1 ' +
             ' and l1tag.m_sblreaddres = 0';
   if OpenQryD(strSQL, nCount) then
   begin
     res := true;
     with FADOQueryD do
     begin
       PID := FieldByName('m_sbyportid').AsInteger;
       MID := FieldByName('m_swmid').AsInteger;
     end;
   end
   else
   begin
     PID := -1;
     MID := 0;
   end;
   CloseQryD;
   result := res;
end;
{
     procedure CreateUPDBF(strTable : String);
     procedure InsertUPDBF(var pTable:SL3ExportDBF);
     procedure DeleteUPDBF(strTable : String);

}
procedure CDBase.CreateUPDBF(strTable:String);
Var
    strSQL : String;
begin
    strSQL := 'CREATE TABLE '+strTable+'('+
    ' NUMABON String(15),'+
    ' ZAVOD String(4),'+
    ' TIP_SC String(20),'+
    ' NOM_SC String(20),'+
    ' UL String(100),'+
    ' DOM String(4),'+
    ' KORP String(4),'+
    ' KV String(15),'+
    ' DAT Date,'+
    ' POKP_ALL Float,'+
    ' POKP_1 Float,'+
    ' POKP_2 Float,'+
    ' POKP_3 Float,'+
    ' POKP_4 Float,'+
    ' POKP_5 Float,'+
    ' POKP_6 Float,'+
    ' POKP_7 Float,'+
    ' POKP_8 Float,'+
    ' POKO_ALL Float,'+
    ' POKO_1 Float,'+
    ' POKO_2 Float,'+
    ' POKO_3 Float,'+
    ' POKO_4 Float,'+
    ' POKO_5 Float,'+
    ' POKO_6 Float,'+
    ' POKO_7 Float,'+
    ' POKO_8 Float,'+
    ' M1 Float,'+
    ' M2 Float,'+
    ' M3 Float,'+
    ' M4 Float'+
    ')';
    ExecQryDBF(strSQL);
end;
procedure CDBase.CreateUPDBFVIT(strTable:String);
Var
    strSQL : String;
begin
    strSQL := 'CREATE TABLE '+strTable+'('+
    ' NUMABON String(15),'+
    ' POK_ALL Numeric(11,2),'+
    ' POK_T1 Numeric(11,2),'+
    ' POK_T2 Numeric(11,2),'+
    ' POK_T3 Numeric(11,2),'+
    ' POK_T4 Numeric(11,2),'+
    ' POK_T5 Numeric(11,2),'+
    ' POK_HOUSE Numeric(11,2),'+
    ' TIMЕ String(14),'+
    ' FLAG Integer'+
    ')';
    ExecQryDBF(strSQL);
end;
procedure CDBase.InsertUPDBF(strTable:String;var pTable:SL3ExportDBF);
Var
    strSQL : String;
begin
    with pTable do
    Begin
    strSQL := 'INSERT INTO '+strTable+
              '(NUMABON,ZAVOD,TIP_SC,NOM_SC,UL,DOM,KORP,KV,DAT,'+
              'POKP_ALL,POKP_1,POKP_2,POKP_3,POKP_4,POKP_5,POKP_6,POKP_7,POKP_8,'+
              'POKO_ALL,POKO_1,POKO_2,POKO_3,POKO_4,POKO_5,POKO_6,POKO_7,POKO_8,'+
              'M1,M2,M3,M4)'+
              //'MU,MV,MD,MN)'+
              ' VALUES('+
              ''''+NUMABON+''''+ ','+
              ''''+ZAVOD+''''+ ','+
              ''''+TIP_SC+''''+ ','+
              ''''+NOM_SC+''''+ ','+
              ''''+UL+''''+ ','+
              ''''+DOM+''''+ ','+
              ''''+KORP+''''+ ','+
              ''''+KV+''''+ ','+
              ''''+DateToStr(DAT)+''''+ ','+
              FloatToStr(POKP_ALL)+ ','+
              FloatToStr(POKP_1)+ ','+
              FloatToStr(POKP_2)+ ','+
              FloatToStr(POKP_3)+ ','+
              FloatToStr(POKP_4)+ ','+
              FloatToStr(POKP_5)+ ','+
              FloatToStr(POKP_6)+ ','+
              FloatToStr(POKP_7)+ ','+
              FloatToStr(POKP_8)+ ','+
              FloatToStr(POKO_ALL)+ ','+
              FloatToStr(POKO_1)+ ','+
              FloatToStr(POKO_2)+ ','+
              FloatToStr(POKO_3)+ ','+
              FloatToStr(POKO_4)+ ','+
              FloatToStr(POKO_5)+ ','+
              FloatToStr(POKO_6)+ ','+
              FloatToStr(POKO_7)+ ','+
              FloatToStr(POKO_8)+ ','+
              FloatToStr(MD)+ ','+
              FloatToStr(MN)+ ','+
              FloatToStr(MU)+ ','+
              FloatToStr(MV)+ ')';
    End;
    ExecQryDBF(strSQL);
end;
procedure CDBase.InsertUPDBFVIT(strTable:String;var pTbl:SL3ExportVIT);
Var
    strSQL,str : String;
begin
        with pTbl do
    Begin
    strSQL := 'INSERT INTO '+strTable+
              '(NUMABON,'+
              'POK_ALL,POK_T1,POK_T2,POK_T3,POK_T4,POK_T5,'+
              'POK_HOUSE,TIMЕ,FLAG)'+
              ' VALUES('+
              ''''+NUMABON+''''+ ','+
              FloatToStrF(POK_ALL,ffFixed,11,2)+ ','+
              FloatToStrF(POK_T1,ffFixed,11,2)+ ','+
              FloatToStrF(POK_T2,ffFixed,11,2)+ ','+
              FloatToStrF(POK_T3,ffFixed,11,2)+ ','+
              FloatToStrF(POK_T4,ffFixed,11,2)+ ','+
              FloatToStrF(POK_T5,ffFixed,11,2)+ ','+
              FloatToStrF(POK_HOUSE,ffFixed,11,2)+','+
              ''''+TIME+''''+ ','+
              IntToStr(FLAG)+ ')';
          end;
    ExecQryDBF(strSQL);
end;


procedure CDBase.DeleteUPDBF(strTable:String);
Var
    strSQL : String;
begin
    strSQL := 'DROP TABLE '+strTable;
    ExecQryDBF(strSQL);
end;
{
procedure CDBase.CopyCommandsToQwery(var pTable: SQWERYMDLSEx);
var i : integer;
begin
   for i := 0 to pTable.Commands.m_swAmCommand - 1 do
   begin
     pTable.QweryMDLS.Items[i].m_snVMID       := pTable.m_swVMID;
     pTable.QweryMDLS.Items[i].m_snMID        := pTable.m_swMID;
     pTable.QweryMDLS.Items[i].m_snPID        := pTable.m_swPID;
     pTable.QweryMDLS.Items[i].m_snCMDID      := pTable.Commands.m_sCommand[i].m_swCmdID;
     pTable.QweryMDLS.Items[i].m_sdtBegin     := Now;
     pTable.QweryMDLS.Items[i].m_sdtEnd       := Now;
     pTable.QweryMDLS.Items[i].m_sdtPeriod    := Now;
     pTable.QweryMDLS.Items[i].m_swDayMask    := 0;
     pTable.QweryMDLS.Items[i].m_sdwMonthMask := 0;
     pTable.QweryMDLS.Items[i].m_sbyEnable    := 1;


   end;
end;
}

function CDBase.GetAbonPortID(nIndex: Integer): integer;
Var
    strSQL : String;
    nCOunt : integer;
begin
   Result := -1;
   strSQL := 'select sl3abon.M_SWPORTID from sl3abon where M_SWABOID=' + IntToStr(nIndex);
   if OpenQry(strSQL, nCOunt) = true then
     Result := FADOQuery.FieldByName('M_SWPORTID').AsInteger;
   CloseQry;
end;

function CDBase.GetAbonMax: integer;
Var
    strSQL : String;
    nCOunt : integer;
begin
   Result := -1;
   strSQL := 'select Count(M_SWABOID) from sl3abon';
   if OpenQry(strSQL, nCOunt) = true then
     Result := FADOQuery.FieldByName('COUNT').AsInteger;
   CloseQry;
end;

function CDBase.DelAbonTbl(nIndex, nPID:Integer):Boolean;
Var
    strSQL : String;
Begin
    strSQL := 'DELETE FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(nIndex);
    Result := ExecQry(strSQL);
    strSQL := 'DELETE FROM L2TAG WHERE M_SBYPORTID='+IntToStr(nPID);
    Result := ExecQry(strSQL);
End;
function CDBase.SetVMeterTableCode(m_swVMID:Integer; code:String):Boolean;
Var
    strSQL : String;
Begin
    strSQL := 'UPDATE SL3VMETERTAG SET' +
              ' M_SMETERCODE='  +''''+  code +''''+
              ' WHERE M_SWVMID=' +IntToStr(m_swVMID);
    Result := ExecQry(strSQL);
End;
procedure CDBase.saveToDefData(wCMDID,wWMID:Word);
Var
    i : Byte;
Begin
    case wCMDID of
        QRY_ENERGY_SUM_EP                : for i:=0 to 4 do saveToCurrent(QRY_ENERGY_SUM_EP,i,wWMID);
        QRY_MGAKT_POW_S,QRY_MGAKT_POW_A  : for i:=0 to 3 do saveToCurrent(QRY_MGAKT_POW_S+i,0,wWMID);
        QRY_MGREA_POW_S,QRY_MGREA_POW_A  : for i:=0 to 3 do saveToCurrent(QRY_MGREA_POW_S+i,0,wWMID);
        QRY_U_PARAM_S,QRY_U_PARAM_A      : for i:=0 to 3 do saveToCurrent(QRY_U_PARAM_S+i,0,wWMID);
        QRY_I_PARAM_S,QRY_I_PARAM_A      : for i:=0 to 3 do saveToCurrent(QRY_I_PARAM_S+i,0,wWMID);
        QRY_KOEF_POW_A                   : for i:=0 to 2 do saveToCurrent(QRY_KOEF_POW_A+i,0,wWMID);
        QRY_FREQ_NET                     : saveToCurrent(QRY_FREQ_NET,0,wWMID);  
    End;
End;
procedure CDBase.saveToCurrent(wCMDID,wTID,wWMID:Word);
Var
    pD : L3CURRENTDATA;
    dbValue,dD,dDC : Double;
Begin
    dbValue :=-1;
    dD := 4*(wWMID+1)+random(1000)/1000.0;
    dDC:= random(1000)/1000.0;
    if (dbValue=-1) then
    Begin
      dbValue := 0;
      case wCMDID of
          QRY_ENERGY_SUM_EP :
          Begin
           if wTID=0 then dbValue := 1863.5537+dD;
           if wTID=1 then dbValue := 1454.5787+dD;
           if wTID=2 then dbValue := 354.432+dD;
           if wTID=3 then dbValue := 54.543+dD;
           if wTID=4 then dbValue := 0.0;
          End;
          QRY_MGAKT_POW_S : dbValue := 94.543+dD;
          QRY_MGAKT_POW_A : dbValue := 32.355+dD;
          QRY_MGAKT_POW_B : dbValue := 28.754+dD;
          QRY_MGAKT_POW_C : dbValue := 25.867+dD;
          QRY_MGREA_POW_S : dbValue := 33.554+dD;
          QRY_MGREA_POW_A : dbValue := 10.675+dD;
          QRY_MGREA_POW_B : dbValue := 11.322+dD;
          QRY_MGREA_POW_C : dbValue := 12.455+dD;
          QRY_U_PARAM_S   : dbValue := 384.432+dDC;
          QRY_U_PARAM_A   : dbValue := 223.542+dDC;
          QRY_U_PARAM_B   : dbValue := 220.364+dDC;
          QRY_U_PARAM_C   : dbValue := 221.767+dDC;
          QRY_I_PARAM_S   : dbValue := 24.545+dD;
          QRY_I_PARAM_A   : dbValue := 6.556+dD;
          QRY_I_PARAM_B   : dbValue := 9.432+dD;
          QRY_I_PARAM_C   : dbValue := 8.456+dD;
          QRY_FREQ_NET    : dbValue := 50;
          QRY_KOEF_POW_A  : dbValue := 0.934-wWMID/1000;
          QRY_KOEF_POW_B  : dbValue := 0.943-wWMID/1000;
          QRY_KOEF_POW_C  : dbValue := 0.833-wWMID/1000;
      end;
    End;

    pD.m_swVMID  := wWMID;
    pD.m_swTID   := wTID;
    pD.m_swCMDID := wCMDID;
    pD.m_swSID   := 0;
    pD.m_sTime   := now;
    pD.m_sfKU    := 1;
    pD.m_sfKI    := 1;
    pD.m_sfSvValue := dbValue;
    pD.m_sfValue   := dbValue;
    pD.m_byOutState    := DT_NEW;
    pD.m_byInState     := DT_NEW;
    pD.m_sbyMaskRead   := 0 ;
    pD.m_sbyMaskReRead := 0;
    pD.m_sMaskRead     := 0;
    pD.m_sMaskReRead   := 0;
    pD.m_sbyPrecision  := 3;
    SetCurrentParamNoBlock(pD);
End;
function CDBase.SetCurrentParamNoBlock(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
Begin
    with pTable do
    Begin
    strSQL := ' UPDATE L3CURRENTDATA SET '+
              ' m_sTime='+''''+DateTimeToStr(m_sTime)+''''+
              ',m_sfValue='+FloatToStr(m_sfValue)+
              ',m_byOutState='+IntToStr(m_byOutState)+
              ',m_CRC='+IntToStr(m_CRC)+
              ',m_byInState='+IntToStr(m_byInState)+
              ',M_SBYMASKREREAD='+IntToStr(m_sbyMaskReRead)+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+
              ' and m_swVMID='+IntToStr(m_swVMID)+
              ' and m_swTID='+IntToStr(m_swTID);
    Result := ExecQryD(strSQL);
    End;
End;

function CDBase.GET_QUERYSTATE(nChannel:Integer):integer;
Var
    strSQL : String;
    nCount : integer; 
Begin
    strSQL := 'select QUERYSTATE from l2tag where m_swMID=(Select m_swMID from sl3vmetertag where m_swVMID='+IntToStr(nChannel)+')';
    if OpenQry(strSQL,nCount)=True then
    Result := FADOQuery.FieldByName('QUERYSTATE').AsInteger;
    CloseQry;
End;



function CDBase.SetRegTable(sName:String):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False; //Будет если нет такого район в таблице
    strSQL := 'SELECT * FROM SL3REGION WHERE M_NREGNM='+ '''' + sName + '''';
   // pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;
     res := True; //Если такой район в таблице есть выход без добавления
    CloseQry;
    end
    else
       begin
    CloseQry;
       strSQL := 'INSERT INTO SL3REGION'+
              '(M_NREGNM,M_SKSP,M_SBYENABLE)'+
              ' VALUES('+
              ''''+sName+ ''''+','+
              IntToStr(8005)+ ','+
              IntToStr(1)+')';

      Result := ExecQryD(strSQL);
      end;

    Result := res;
End;


function CDBase.DelRegTable(sName:String):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False; //Будет если нет такого район в таблице
      strSQL := 'DELETE FROM SL3REGION Where M_NREGNM='+ '''' + sName + '''';
      Result := ExecQryD(strSQL);
//    Result := res;
End;


function CDBase.GetIdRegTable(var IdRes:Integer;sName:String):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False; //Будет если нет такого район в таблице
    strSQL := 'SELECT * FROM SL3REGION WHERE M_NREGNM='+ '''' + sName + '''';
    if OpenQry(strSQL,nCount)=True then
    begin
     Result:=true;
     IdRes := FADOQuery.FieldByName('M_NREGIONID').AsInteger;
     CloseQry;
     exit;
    end;
    CloseQry;
    IdRes:=-1;
    Result := res;
End;


function CDBase.DelDepTable(sName:String):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False; //Будет если нет такого район в таблице
      strSQL := 'DELETE FROM SL3DEPARTAMENT Where M_SNAME='+ '''' + sName + '''';
      Result := ExecQryD(strSQL);
//    Result := res;
End;


function CDBase.SetDepTable(Reg_ID,_Code:Integer;sName:String):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False; //Будет если нет такого район в таблице
    strSQL := 'SELECT * FROM SL3DEPARTAMENT WHERE M_SNAME='+ '''' + sName + '''';
   // pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;
     res := True; //Если такой район в таблице есть выход без добавления
    CloseQry;
    end
    else
       begin
    CloseQry;
       strSQL := 'INSERT INTO SL3DEPARTAMENT'+
              '(M_SWREGION,M_SNAME,CODE)'+
              ' VALUES('+
               IntToStr(Reg_ID)+ ','+
               ''''+sName+ ''''+','+
               IntToStr(_Code)+')';

      Result := ExecQryD(strSQL);
      end;

    Result := res;
End;

function CDBase.DelAbonVMID(m_VMID:Integer):Boolean;
Var
    strSQL   : String;
    nCount   : integer;
    m_swMID  : Integer;
Begin
    m_swMID:=-1;

    if(m_VMID<>-1) then
    Begin
      strSQL := 'Select m_swMID FROM SL3VMETERTAG WHERE M_SWVMID='+IntToStr(m_VMID);
        if OpenQry(strSQL,nCount)=True then
           m_swMID := FADOQuery.FieldByName('m_swMID').AsInteger
        else
         Begin
          Result:=False;
          exit;
         end;
    end
    else
       Begin
          Result:=False;
          exit;
       end;

    if(m_VMID<>-1) then strSQL := 'DELETE FROM SL3VMETERTAG WHERE M_SWVMID='+IntToStr(m_VMID);
    Result := ExecQry(strSQL);
    if(m_VMID<>-1) then strSQL := 'DELETE FROM L2TAG WHERE m_swMID='+IntToStr(m_swMID);
    Result := ExecQry(strSQL);
End;

procedure  CDBase.GetRegion;
var strSQL : string;
nCount, i  : integer;
h , j : integer;
s : string;
begin
strSQL:='Select sl3region.M_NREGIONID, sl3region.m_nregnm from sl3region Where sl3region.m_nregionid <> 500 Order by M_NREGIONID';
if OpenQry(strSQL,nCount)=True then
     begin
//     TKnsForm.AdvProgress2.Position:=0;
{        for i := 0 to nCount-1 do
        begin
          s:=FADOQuery.FieldByName('m_nregnm').AsString;
          h:=FADOQuery.FieldByName('M_NREGIONID').AsInteger;
          TKnsForm.TreeList1.Items.AddObject(nil,s,Pointer(h));
          FADOQuery.Next;
        end;    }
    end
else
  exit;
end;

procedure  CDBase.GetDepartament;
var strSQL : string;
nCount, i  : integer;
h,j,id : integer;
s : string;
node : TTreeNode;
begin
strSQL:='Select SL3DEP.M_SWDEPID, SL3DEP.M_SNAME, SL3DEP.M_SWREGION from SL3DEPARTAMENT SL3DEP Order by SL3DEP.M_SWREGION, SL3DEP.M_SNAME';
i:=0;
if OpenQry(strSQL,nCount)=True then
     begin
 {      node:=TKnsForm.TreeList1.Items[i];
       j:=integer(node.data);
       TKnsForm.tmp_GetDepartament:=j;
       while i < nCount do begin
          s:=FADOQuery.FieldByName('M_SNAME').AsString;
          id:=FADOQuery.FieldByName('M_SWDEPID').AsInteger;
          h:=FADOQuery.FieldByName('M_SWREGION').AsInteger;

          if h = j then begin
            node:=TKnsForm.TreeList1.Items[i];
            j:=integer(node.data);
            TKnsForm.tmp_GetDepartament:=j;
            inc(i);
          end
          else
            begin
 //           inc(i);
            node:=TKnsForm.TreeList1.Items[i];
            j:=integer(node.data);
            TKnsForm.tmp_GetDepartament:=j;
            inc(i);
            end;


            TKnsForm.TreeList1.Items.AddChildObject(node,s,Pointer(id));
            FADOQuery.Next;

        end  }
      end
    else
    exit;
end;


function CDBase.GetPathNameByID(IdRes:Integer; var sName:String):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT L3R.M_NREGNM || '' / '' || L3D.M_SNAME || '' / '' || L3T.M_SNAME || '' / '' || L3TP.NAME || '' / '' || L3S.M_SNAME || '' / '' || L3A.M_SNAME RES ' +
              'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T, SL3DEPARTAMENT L3D, SL3REGION L3R ' +
              'WHERE L3A.M_SWABOID = ' + IntToStr(IdRes) +
              '  AND L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
              '  AND L3A.TPID = L3TP.ID ' +
              '  AND L3A.M_SWTOWNID = L3T.M_SWTOWNID ' +
              '  AND L3A.M_SWDEPID = L3D.M_SWDEPID ' +
              '  AND L3A.M_NREGIONID = L3R.M_NREGIONID';
    if OpenQry(strSQL,nCount)=True then
    begin
     Result:=true;
     sName := FADOQuery.FieldByName('RES').AsString;
     CloseQry;
     exit;
    end;
    CloseQry;
    IdRes:=-1;
    Result := res;
End;

function CDBase.GetNodeToExcel(Id, level:Integer; var WB:TSheet; var sNode : string):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    s        : string;
begin
  case level of
    1 : begin      // REGION
      strSQL := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, L3TP.NAME TP, L3T.M_SNAME TOWN, L3D.M_SNAME DEPART, L3R.M_NREGNM REGION, ' +
                '  (SELECT FIRST 1 QM.M_SCOMMENT FROM L2TAG L2T, QM_METERS QM WHERE L2T.M_SWABOID = L3A.M_SWABOID AND QM.M_SWTYPE = L2T.M_SBYTYPE) USPD, ' +
                '  (SELECT FIRST 1 L2T.M_SADVDISCL2TAG FROM L2TAG L2T WHERE L2T.M_SWABOID = L3A.M_SWABOID) ADVDISCL ' +
                'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T, SL3DEPARTAMENT L3D, SL3REGION L3R ' +
                'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
                '  AND L3A.TPID = L3TP.ID ' +
                '  AND L3A.M_SWTOWNID = L3T.M_SWTOWNID ' +
                '  AND L3A.M_SWDEPID = L3D.M_SWDEPID ' +
                '  AND L3A.M_NREGIONID = L3R.M_NREGIONID ' +
                '  AND L3R.M_NREGIONID = ' + IntToStr(Id) + ' ' +
                'ORDER BY REGION, DEPART, TOWN, TP, STREET, HOUSE';
    end;
    2 :  begin   //  DEPARTAMENT
      strSQL := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, L3TP.NAME TP, L3T.M_SNAME TOWN, L3D.M_SNAME DEPART, ' +
                '  (SELECT FIRST 1 QM.M_SCOMMENT FROM L2TAG L2T, QM_METERS QM WHERE L2T.M_SWABOID = L3A.M_SWABOID AND QM.M_SWTYPE = L2T.M_SBYTYPE) USPD, ' +
                '  (SELECT FIRST 1 L2T.M_SADVDISCL2TAG FROM L2TAG L2T WHERE L2T.M_SWABOID = L3A.M_SWABOID) ADVDISCL ' +
                'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T, SL3DEPARTAMENT L3D ' +
                'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
                '  AND L3A.TPID = L3TP.ID ' +
                '  AND L3A.M_SWTOWNID = L3T.M_SWTOWNID ' +
                '  AND L3A.M_SWDEPID = L3D.M_SWDEPID ' +
                '  AND L3D.M_SWDEPID = ' + IntToStr(Id) + ' ' +
                'ORDER BY DEPART, TOWN, TP, STREET, HOUSE';
    end;
    3 : begin      // TOWN
      strSQL := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, L3TP.NAME TP, L3T.M_SNAME TOWN, ' +
                '  (SELECT FIRST 1 QM.M_SCOMMENT FROM L2TAG L2T, QM_METERS QM WHERE L2T.M_SWABOID = L3A.M_SWABOID AND QM.M_SWTYPE = L2T.M_SBYTYPE) USPD, ' +
                '  (SELECT FIRST 1 L2T.M_SADVDISCL2TAG FROM L2TAG L2T WHERE L2T.M_SWABOID = L3A.M_SWABOID) ADVDISCL ' +
                'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T ' +
                'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
                '  AND L3A.TPID = L3TP.ID ' +
                '  AND L3A.M_SWTOWNID = L3T.M_SWTOWNID ' +
                '  AND L3T.M_SWTOWNID = ' + IntToStr(Id) + ' ' +
                'ORDER BY TOWN, TP, STREET, HOUSE';
    end;
    4 : begin       // TP
      strSQL := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, L3TP.NAME TP, ' +
                '  (SELECT FIRST 1 QM.M_SCOMMENT FROM L2TAG L2T, QM_METERS QM WHERE L2T.M_SWABOID = L3A.M_SWABOID AND QM.M_SWTYPE = L2T.M_SBYTYPE) USPD, ' +
                '  (SELECT FIRST 1 L2T.M_SADVDISCL2TAG FROM L2TAG L2T WHERE L2T.M_SWABOID = L3A.M_SWABOID) ADVDISCL ' +
                'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP ' +
                'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
                '  AND L3A.TPID = L3TP.ID ' +
                '  AND L3TP.ID = ' + IntToStr(Id) + ' ' +
                'ORDER BY TP, STREET, HOUSE';
    end;
    5 : begin       // STREET
      strSQL := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, ' +
                '  (SELECT FIRST 1 QM.M_SCOMMENT FROM L2TAG L2T, QM_METERS QM WHERE L2T.M_SWABOID = L3A.M_SWABOID AND QM.M_SWTYPE = L2T.M_SBYTYPE) USPD, ' +
                '  (SELECT FIRST 1 L2T.M_SADVDISCL2TAG FROM L2TAG L2T WHERE L2T.M_SWABOID = L3A.M_SWABOID) ADVDISCL ' +
                'FROM SL3ABON L3A, SL3STREET L3S ' +
                'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
                '  AND L3S.M_SWSTREETID = ' + IntToStr(Id)+ ' ' +
                'ORDER BY STREET, HOUSE';
    end;
    10 : begin         // Группа опроса
      strSQL := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, L3TP.NAME TP, L3T.M_SNAME TOWN, L3D.M_SNAME DEPART, QG.NAME QGNAME, ' +
                '  (SELECT FIRST 1 QM.M_SCOMMENT FROM L2TAG L2T, QM_METERS QM WHERE L2T.M_SWABOID = L3A.M_SWABOID AND QM.M_SWTYPE = L2T.M_SBYTYPE) USPD, ' +
                '  (SELECT FIRST 1 L2T.M_SADVDISCL2TAG FROM L2TAG L2T WHERE L2T.M_SWABOID = L3A.M_SWABOID) ADVDISCL ' +
                'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T, SL3DEPARTAMENT L3D, QUERYGROUP QG, QGABONS QA ' +
                'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
                '  AND L3A.TPID = L3TP.ID ' +
                '  AND L3A.M_SWTOWNID = L3T.M_SWTOWNID ' +
                '  AND L3A.M_SWDEPID = L3D.M_SWDEPID ' +
                '  AND L3A.M_SWABOID = QA.ABOID ' +
                '  AND QG.ID = QA.QGID ' +
                '  AND QG.ID =  '+ IntToStr(Id)+ ' ' +
                'ORDER BY DEPART, TOWN, TP, STREET, HOUSE';
    end;
  end;
  if OpenQry(strSQL,nCount)=True then begin
    i := 1;
    case level of
      1 : begin
        WB.Cells[0,0].Value:='Экспорт узла: Регион: ' + FADOQuery.FieldByName('REGION').AsString;
        sNode := FADOQuery.FieldByName('REGION').AsString;
        WB.Cells[i,0].Value:='Регион';
        WB.Cells[i,1].Value:='Департамент';
        WB.Cells[i,2].Value:='Город';
        WB.Cells[i,3].Value:='ТП';
        WB.Cells[i,4].Value:='Улица';
        WB.Cells[i,5].Value:='Дом';
        WB.Cells[i,6].Value:='УСПД';
        WB.Cells[i,7].Value:='Тип связи УСПД->Счетчик';
      end;
      2 : begin
        WB.Cells[0,0].Value:='Экспорт узла: Департамент: ' + FADOQuery.FieldByName('DEPART').AsString;
        sNode := FADOQuery.FieldByName('DEPART').AsString;
        WB.Cells[i,0].Value:='Департамент';
        WB.Cells[i,1].Value:='Город';
        WB.Cells[i,2].Value:='ТП';
        WB.Cells[i,3].Value:='Улица';
        WB.Cells[i,4].Value:='Дом';
        WB.Cells[i,5].Value:='УСПД';
        WB.Cells[i,6].Value:='Тип связи УСПД->Счетчик';
      end;
      3 : begin
        WB.Cells[0,0].Value:='Экспорт узла: Город: ' + FADOQuery.FieldByName('TOWN').AsString;
        sNode := FADOQuery.FieldByName('TOWN').AsString;
        WB.Cells[i,0].Value:='Город';
        WB.Cells[i,1].Value:='ТП';
        WB.Cells[i,2].Value:='Улица';
        WB.Cells[i,3].Value:='Дом';
        WB.Cells[i,4].Value:='УСПД';
        WB.Cells[i,5].Value:='Тип связи УСПД->Счетчик';
      end;
      4 : begin
        WB.Cells[0,0].Value:='Экспорт узла: ТП: ' + FADOQuery.FieldByName('TP').AsString;
        sNode := FADOQuery.FieldByName('TP').AsString;
        WB.Cells[i,0].Value:='ТП';
        WB.Cells[i,1].Value:='Улица';
        WB.Cells[i,2].Value:='Дом';
        WB.Cells[i,3].Value:='УСПД';
        WB.Cells[i,4].Value:='Тип связи УСПД->Счетчик';
      end;
      5 : begin
        WB.Cells[0,0].Value:='Экспорт узла: Улица: ' + FADOQuery.FieldByName('STREET').AsString;
        sNode := FADOQuery.FieldByName('STREET').AsString;
        WB.Cells[i,0].Value:='Улица';
        WB.Cells[i,1].Value:='Дом';
        WB.Cells[i,2].Value:='УСПД';
        WB.Cells[i,3].Value:='Тип связи УСПД->Счетчик';
      end;
      10 : begin
        WB.Cells[0,0].Value:='Экспорт узла: Группа опроса: ' + FADOQuery.FieldByName('QGNAME').AsString;
        sNode := FADOQuery.FieldByName('QGNAME').AsString;
        WB.Cells[i,0].Value:='Группа опроса';
        WB.Cells[i,1].Value:='Город';
        WB.Cells[i,2].Value:='ТП';
        WB.Cells[i,3].Value:='Улица';
        WB.Cells[i,4].Value:='Дом';
        WB.Cells[i,5].Value:='УСПД';
        WB.Cells[i,6].Value:='Тип связи УСПД->Счетчик';
      end;
    end;
    inc(i);
    while not FADOQuery.Eof do Begin
      case level of
        1 : begin
          WB.Cells[i,0].Value:=FADOQuery.FieldByName('REGION').AsString;
          WB.Cells[i,1].Value:=FADOQuery.FieldByName('DEPART').AsString;
          WB.Cells[i,2].Value:=FADOQuery.FieldByName('TOWN').AsString;
          WB.Cells[i,3].Value:=FADOQuery.FieldByName('TP').AsString;
          WB.Cells[i,4].Value:=FADOQuery.FieldByName('STREET').AsString;
          WB.Cells[i,5].Value:=FADOQuery.FieldByName('HOUSE').AsString;
          WB.Cells[i,6].Value:=FADOQuery.FieldByName('USPD').AsString;
          WB.Cells[i,7].Value:=ParseADVDISCL(FADOQuery.FieldByName('ADVDISCL').AsString, 5);
        end;
        2 : begin
          WB.Cells[i,0].Value:=FADOQuery.FieldByName('DEPART').AsString;
          WB.Cells[i,1].Value:=FADOQuery.FieldByName('TOWN').AsString;
          WB.Cells[i,2].Value:=FADOQuery.FieldByName('TP').AsString;
          WB.Cells[i,3].Value:=FADOQuery.FieldByName('STREET').AsString;
          WB.Cells[i,4].Value:=FADOQuery.FieldByName('HOUSE').AsString;
          WB.Cells[i,5].Value:=FADOQuery.FieldByName('USPD').AsString;
          WB.Cells[i,6].Value:=ParseADVDISCL(FADOQuery.FieldByName('ADVDISCL').AsString, 5);
        end;
        3 : begin
          WB.Cells[i,0].Value:=FADOQuery.FieldByName('TOWN').AsString;
          WB.Cells[i,1].Value:=FADOQuery.FieldByName('TP').AsString;
          WB.Cells[i,2].Value:=FADOQuery.FieldByName('STREET').AsString;
          WB.Cells[i,3].Value:=FADOQuery.FieldByName('HOUSE').AsString;
          WB.Cells[i,4].Value:=FADOQuery.FieldByName('USPD').AsString;
          WB.Cells[i,5].Value:=ParseADVDISCL(FADOQuery.FieldByName('ADVDISCL').AsString, 5);
        end;
        4 : begin
          WB.Cells[i,0].Value:=FADOQuery.FieldByName('TP').AsString;
          WB.Cells[i,1].Value:=FADOQuery.FieldByName('STREET').AsString;
          WB.Cells[i,2].Value:=FADOQuery.FieldByName('HOUSE').AsString;
          WB.Cells[i,3].Value:=FADOQuery.FieldByName('USPD').AsString;
          WB.Cells[i,4].Value:=ParseADVDISCL(FADOQuery.FieldByName('ADVDISCL').AsString, 5);
        end;
        5 : begin
          WB.Cells[i,0].Value:=FADOQuery.FieldByName('STREET').AsString;
          WB.Cells[i,1].Value:=FADOQuery.FieldByName('HOUSE').AsString;
          WB.Cells[i,2].Value:=FADOQuery.FieldByName('USPD').AsString;
          WB.Cells[i,3].Value:=ParseADVDISCL(FADOQuery.FieldByName('ADVDISCL').AsString, 5);
        end;
        10 : begin
          WB.Cells[i,0].Value:=FADOQuery.FieldByName('QGNAME').AsString;
          WB.Cells[i,1].Value:=FADOQuery.FieldByName('TOWN').AsString;
          WB.Cells[i,2].Value:=FADOQuery.FieldByName('TP').AsString;
          WB.Cells[i,3].Value:=FADOQuery.FieldByName('STREET').AsString;
          WB.Cells[i,4].Value:=FADOQuery.FieldByName('HOUSE').AsString;
          WB.Cells[i,5].Value:=FADOQuery.FieldByName('USPD').AsString;
          WB.Cells[i,6].Value:=ParseADVDISCL(FADOQuery.FieldByName('ADVDISCL').AsString, 5);
        end;
      end;
      FADOQuery.Next;
      Inc(i);
    End;
  end;
  CloseQry;
  Id:=-1;
  Result := res;
end;



function CDBase.GetNodeToQueryGrop(Id, level:Integer; var List : TList):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    s        : string;
begin
  case level of
    1 : begin      // REGION
      strSQL := 'SELECT L3A.M_SWABOID ' +
                'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T, SL3DEPARTAMENT L3D, SL3REGION L3R ' +
                'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
                '  AND L3A.TPID = L3TP.ID ' +
                '  AND L3A.M_SWTOWNID = L3T.M_SWTOWNID ' +
                '  AND L3A.M_SWDEPID = L3D.M_SWDEPID ' +
                '  AND L3A.M_NREGIONID = L3R.M_NREGIONID ' +
                '  AND L3R.M_NREGIONID = ' + IntToStr(Id) + ' ' +
                'ORDER BY L3A.M_SWABOID';
    end;
    2 :  begin   //  DEPARTAMENT
      strSQL := 'SELECT L3A.M_SWABOID ' +
                'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T, SL3DEPARTAMENT L3D ' +
                'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
                '  AND L3A.TPID = L3TP.ID ' +
                '  AND L3A.M_SWTOWNID = L3T.M_SWTOWNID ' +
                '  AND L3A.M_SWDEPID = L3D.M_SWDEPID ' +
                '  AND L3D.M_SWDEPID = ' + IntToStr(Id) + ' ' +
                'ORDER BY L3A.M_SWABOID';
    end;
    3 : begin      // TOWN
      strSQL := 'SELECT L3A.M_SWABOID ' +
                'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T ' +
                'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
                '  AND L3A.TPID = L3TP.ID ' +
                '  AND L3A.M_SWTOWNID = L3T.M_SWTOWNID ' +
                '  AND L3T.M_SWTOWNID = ' + IntToStr(Id) + ' ' +
                'ORDER BY L3A.M_SWABOID';
    end;
    4 : begin       // TP
      strSQL := 'SELECT L3A.M_SWABOID ' +
                'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP ' +
                'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
                '  AND L3A.TPID = L3TP.ID ' +
                '  AND L3TP.ID = ' + IntToStr(Id) + ' ' +
                'ORDER BY L3A.M_SWABOID';
    end;
    5 : begin       // STREET
      strSQL := 'SELECT L3A.M_SWABOID ' +
                'FROM SL3ABON L3A, SL3STREET L3S ' +
                'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
                '  AND L3S.M_SWSTREETID = ' + IntToStr(Id)+ ' ' +
                'ORDER BY L3A.M_SWABOID';
    end;
  end;
  if OpenQry(strSQL,nCount)=True then begin
    while not FADOQuery.Eof do Begin
      List.Add(Pointer(FADOQuery.FieldByName('M_SWABOID').AsInteger));
      FADOQuery.Next;
      Inc(i);
    End;
  end;
  CloseQry;
  Id:=-1;
  Result := res;
end;


function CDBase.SetGroupRefresh(GID,STATE:Integer;_Date:TDateTime):Boolean;
Var
    strSQL   : String;
BEgin
    strSQL := 'UPDATE QUERYGROUP SET '+
              ' DATEQUERY='  +''''+ DateTimeToStr(_Date)+''''+ //
              ',ERRORQUERY=' + IntToStr(STATE)+
              ' WHERE ID=' + IntToStr(GID);
   Result := ExecQry(strSQL);
End;

function CDBase.GetPulls_L1(IP,IPPORT,DESCRIPTION:String; Check:Integer;var ID:Integer):Integer;
Var
    strSQL   : String;
    OLDNEW   : Integer;
    nCount   : Integer;
    rs       : boolean;
Begin
    OLDNEW := 0;
    nCount := 0;
    strSQL := ' SELECT ID, OLDNEW FROM'+
              ' CHECK_ID_EXTSTR('''+IP+'''' +',''' +IPPORT+''','+IntToStr(Check)+','''+ DESCRIPTION+''')';
  //  Result := ExecQry(strSQL);
  if OpenQry(strSQL,nCount)=True then
     with FADOQuery do  Begin
      ID      := FieldByName('ID').AsInteger;
      OLDNEW  := FieldByName('OLDNEW').AsInteger;
      End;
    Result:=OLDNEW;

   strSQL := 'select first 1 id from  L2PULLS';
   rs := ExecQry(strSQL);
End;

function CDBase.GetExtParam(QGID : Integer; var LB:TCheckListBox):Boolean;
Var strSQL  : String;
    res     : Boolean;
    nCount  : Integer;
    i, k, h : Integer;
Begin
  res := False;
  strSQL := 'SELECT * FROM QM_PARAMS ' +
            'WHERE M_SWTYPE IN (1, 17, 21, 37, 59, 73)';
  if OpenQry(strSQL,nCount)=True then Begin
    LB.Items.Clear;
    res := True;
    while not FADOQuery.Eof do Begin
      with FADOQuery do  Begin
        LB.Items.AddObject(FieldByName('M_SNAME').AsString,
           TObject(FieldByName('M_SWTYPE').AsInteger));
        Next;
      End;
    End;
  End;
  CloseQry;
  FADOQuery.SQL.Clear;
  strSQL := 'SELECT ID, PARAM FROM QGPARAM ' +
            'WHERE QGID = ' + IntToStr(QGID);
  if OpenQry(strSQL,nCount)=True then Begin
    for i := 0 to FADOQuery.RecordCount-1 do Begin

      for k := 0 to LB.Items.Count-1 do begin
        h := Integer(LB.Items.Objects[k]);
        if FADOQuery.FieldByName('PARAM').AsInteger = h then begin
          LB.Checked[k] := True;
        end;
      end;
      FADOQuery.Next;
    End;
  End;
  CloseQry;
  Result := res;
End;

function CDBase.SetExtParam(QGID: Integer; var LB: TCheckListBox): Boolean;
Var strSQL  : String;
    res     : Boolean;
    nCount  : Integer;
    i, k, h : Integer;
    PARAM   : Integer;
begin
  FADOQuery.SQL.Clear;
  strSQL := 'SELECT ID, PARAM FROM QGPARAM ' +
            'WHERE QGID = ' + IntToStr(QGID);
  OpenQry(strSQL,nCount);
    for i := 0 to LB.Items.Count-1 do begin
      res := False;
      PARAM := Integer(LB.Items.Objects[i]);
      FADOQuery.First;
      while not FADOQuery.Eof do Begin
        if FADOQuery.FieldByName('PARAM').AsInteger = PARAM then begin
          res := True;
          if not LB.Checked[i] then begin // delete record
            strSQL := 'DELETE FROM QGPARAM ' +
                      'WHERE QGID = ' + IntToStr(QGID) + ' ' +
                      '  AND PARAM = ' + IntToStr(PARAM);
            Result := ExecQryD(strSQL);
          end;
        end;
        FADOQuery.Next;
      end;
      if not res then begin  // add new record;
        if LB.Checked[i] then begin
          strSQL := 'INSERT INTO QGPARAM(QGID, PARAM, DTBEGIN, DTEND, DTPERIOD, DAYMASK, MONTHMASK, ENABLE, ' +
                    '     DEEPFIND, PAUSE, FINDDATA, UNDEEPFIND, UNPATH, UNENABLE, ISRUNSTATUS, RUNSTATUS, ' +
                    '     ERRORPERCENT, PACK_KUB, ERRORPERCENT2, TIMETOSTOP) ' +
                    'VALUES(' + IntToStr(QGID) + ', ' + IntToStr(PARAM) + ', ''' + DateToStr(now) + ''', ' +
                    '''' + DateToStr(now) + ''', ''' + DateToStr(now) + ''', 0, 0, 0, ' +
                    '       0, 0, 0, 0, '' '', 0, 0, ''0,0'', 0, 0, 0,'+'''02.05.2010 0:01:00'')';
          Result := ExecQryD(strSQL);
        end;
      end;
    end;
  CloseQry;
  Result := res;
end;

function CDBase.GetDepartGroupID(GroupQueryID : integer; var SB : TStringList):Boolean;
Var
    strSQL   : String;
    nCount   : Integer;
Begin
  Result := false;
  SB.Clear;
strSQL:='SELECT DISTINCT L3A.M_NREGIONID IDREGION, L3A.M_SWDEPID IDDEPART ' +
                'FROM QGABONS QG, SL3ABON L3A ' +
                'WHERE QG.QGID = ' + IntToStr(GroupQueryID) +
                '  AND QG.ABOID = L3A.M_SWABOID';
  if OpenQry(strSQL,nCount)=True then Begin
    while not FADOQuery.Eof do Begin
      with FADOQuery do  Begin
        SB.Add(FieldByName('IDREGION').AsString + ' ' + FieldByName('IDDEPART').AsString);
   //     SB.Items.AddObject(FieldByName('IDDEPART').AsString);
        Next;
      End;
    End;
  End;
  if nCount >= 0 then Result := True;
  CloseQry;
end;

procedure InitModule;
var I :Integer;
begin
  for I := 0 to MAX_DYNCONN do
    m_pDBC[I] := nil;
end;

procedure FinalizModule;
var I :Integer;
begin
  if m_pDB <> nil then begin
    m_pDB.FullDisconnect;
    FreeAndNil(m_pDB);
  end;
  
  for I := 0 to MAX_DYNCONN do
    if m_pDBC[I] <> nil then
    begin
     m_pDBC[I].Disconnect;
     FreeAndNil(m_pDBC[I]);
    end;
end;

destructor CDBase.Destroy;
begin
  if sCS <> nil then FreeAndNil(sCS);
  if SenderClass <> Nil then FreeAndNil(SenderClass);

  inherited;
end;

initialization
  InitModule();

finalization
  FinalizModule();

end.

