unit utldynconnect;

interface
uses
  Windows,forms, Classes, SysUtils, SyncObjs, StdCtrls, ComCtrls, Db, ADODB, Dates,
  utltypes, utlconst, inifiles, utlbox,knsl3EventBox, utlTimeDate, knsl5tracer, math,IBDatabase,IBQuery,
  XLSWorkbook, knslRPTypes, XLSFormat,Controls, utlSendRecive;
type
    TZoneHand = function (dtDate:TDateTime;nPlane,nSZone,nTDay,nZone:Integer):Dword of object;
    CDBDynamicConn = class
    private
     FTZoneHand      : TZoneHand;
     m_strProvider   : String;
     m_strFileName   : String;
     m_nCurrentConnection : Integer;
     m_byConnectionLevel  : Integer;
     FFileIndex      : Integer;
     m_blIsConnect   : Boolean;
     m_nQRYs         : Integer;
     m_nBLOs         : Integer;
     strBSQL         : String;
     function CheckIsFullNakMonth(dtP0, dtP1: TDateTime; var pTable: CCDatasEkom): boolean;
     function CheckIsFillPrDay(dtP0, dtP1: TDateTime; var pTable: CCDatasEkom): boolean;
     function FindValueNakEnMon(Dt: TDateTime; VMID, CMDID : integer; var pTable: CCDatasEkom): double;
     function FindValuePrEnDay(Dt: TDateTime; VMID, CMDID : integer; var pTable: CCDatasEkom): double;
     procedure UpdatePrirEnDayStr(var pTable: CCDatasEkom);
    public
     FADOQuery       : TIBQuery;
//     IBTr            : TIBTransaction;
     FADOConnection  : TIBDatabase;
     constructor Create; overload;
     constructor Create(m_strProvider : string); overload;
     destructor Destroy; override;
     function  InitStrFileName:String;
     procedure Init(strFileName:String);
     function  Connect:Boolean;
     function  Disconnect:Boolean;
     procedure CreateConnection(var vConn:TIBDatabase;var vQry:TIBQuery);
     procedure DestroyConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
     procedure DestroyConnectionQuery(vQry:TIBQuery);
     function  ExecQry(strSQL:String):Boolean;
     function  ExecQryByt(strList:TStringList):Boolean;
     function  OpenQry(strSQL:String;var nCount:Integer):Boolean;
     function  OpenQrySL(SL:TStringList;var nCount:Integer):Boolean;
     procedure CloseQry;
     function  getArchParam(var pTable:L3CURRENTDATA):Double;
     function  DelArchData(dtBegin, dtEnd : TDateTime; abo,cmd:Integer):Boolean;
     function  DelArchDataTP(dtBegin, dtEnd : TDateTime; cmd:Integer;abo:array of integer):Boolean;
     //Function
     function setQueryGroupStat(qgID,stat:Integer):Integer;
     function GetQueryAbonsDyn(groupID:Integer;sortStr:String; var pTable:TThreadList):Boolean;
     function GetQueryAbonsIDDyn(groupID,AbonID:Integer; var COLY,COLN:Integer):Boolean;
     function GetQueryAbonsError(aboid:Integer; var data : QGABONS):Boolean;
     function GetQueryAbonsEx(groupID:Integer;sortStr:String;var pTable:TThreadList):Boolean;
     function getQueryGroupStat(groupID:Integer):Integer;
     function GetQueryAbonsGroup(groupID:Integer; var pTable:TThreadList):Boolean;
     function getAbonInfo(aboid:Integer;var list:TThreadList):boolean;
     procedure setParseFIO(strFIO:String;var pD:CLoadEntity);
     procedure setAddingFields(var pD:CLoadEntity);
     procedure getStrings(separator,s1:String;var value:TStringList);
     function GetAbonMetersLocTable(nAbon:Integer;strType:String;var pTable:SL3GROUPTAG):Boolean;
     function GetAbonL2Join(gid,nAbon:Integer;var pTable:TThreadList):Boolean;

     function setADR(aid:Integer;var pTable :PCIntBuffer):Boolean;

     function GetAbonL2JoinTP(gid:Integer;nAbon:array of integer;var pTable:TThreadList):Boolean;
     function setQueryState(aid,mid,qState:Integer):Boolean;
     function setQueryStateTP(mid,qState:Integer;aid:array of integer):Boolean;
     function GetMMeterTableEx(nIndex:Integer;var pTable:SL2TAG):Boolean;
     function GetMetersIniTable(var pTable:SL2INITITAG):Boolean;
     function GetCommandsTable(nChannel:Integer;var pTable:TThreadList):Boolean;
     function getPulls(var pull:TThreadList):Boolean;
     function getPullByID(id : Integer; var pull:TThreadList):Boolean;
     function addQueryGroupAbon(pTable:QGABONS):Integer;
     function setDtBeginInQueryQroup(id:Integer;date:TDateTime;state:Integer):Integer;
     function SetChannelGSM(AboId,id:Integer;var Port:Integer):Integer;
     function SetResetChannelGSM(AboId,id:Integer):Integer;
     function setDtBeginEndInQueryQroup(id:Integer;dtBegin,dtEnd:TDateTime;state:Integer):Boolean;
     function setDtEndInQueryQroup(id:Integer;date:TDateTime;state:Integer):Integer;
     function setDescQueryQroup(id:Integer;strCtNm,desc:String;state:Integer):Integer;
     function setKvarQueryQroup(id:Integer;kvar:String):Integer;
     function setStateQueryQroup(id:Integer;state:Integer):Integer;

     function getQueryGroup(var pull:TThreadList):Boolean;
     function getParamByID(id : Integer; var pull:TThreadList):Boolean;
     function getAbonByID(id : Integer; var pull:TThreadList):Boolean;

     function GetQueryAbons(gid:QGPARAM;tptype:Integer; var pTable:TThreadList):Boolean;
     function GetAbonFromGroupReload(gid:QGPARAM; tptype:Integer; check:integer; var List:TThreadList) : Boolean;
     function GetQueryAbons8086(gid:QGPARAM;tptype:Integer; check:integer; var pTable:TThreadList):Boolean;
     function GetQueryAbonsCheckTP(gid:QGPARAM;tptype:Integer):Boolean;
     function GetQueryAbonsTP(gid:QGPARAM;tptype:Integer; var pTable:SLQQABONTP):Boolean;
     function GetQueryAbonsTP_ABOID(gidID:Integer;NameTP:string; var pTable:TThreadList):Boolean;

     function LoadReportParams(var pTable : REPORT_F1):boolean;
     function SaveReportParams(var pTable : REPORT_F1):boolean;
     function GetVMetersTable(nAbon,nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetMeterTableForReport(nAbon,GroupID : integer;var pTable : SL2TAGREPORTLIST) : boolean;
     function GetMeterTableForReportWithCode(nAbon,GroupID : integer;Code:string;var pTable : SL2TAGREPORTLIST) : boolean;
     function GetMeterGLVTableForReport(nAbon,GroupID,nLevel : integer;var pTable : SL2TAGREPORTLIST) : boolean;
     function GetMeterGLVRashcet(nAbon : integer;var pTable : SL2TAGREPORTLIST) : boolean;
     function GetMeterForHomeBallReport(nAbon,GroupID,nLevel : integer;var pTable : SL2TAGREPORTLIST) : boolean;

     function GetHomeBallanceReport(SL: TStringList; XLSP : TXLSPointerHomeBalanse; var WB:TSheet; var aData : string): boolean;

     function GetVMetersAbonTable(nAbon,nVMID:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetUsersTable(var pTable:SUSERTAGS):Boolean;
     function GetTMTarPeriodsTableGr(GrInd, nIndex:Integer;var pTable:TM_TARIFFS):Integer;
     function GetTMTarPeriodsTable(VMID, nIndex:Integer;var pTable:TM_TARIFFS):Integer;
     function GetPlaneName(m_swPLID: integer): string;
     function GetTMTarPeriodsCmdTable(dtDate:TDateTime;nVMID,nCMDID,nTSHift:Integer;var pTable:TM_TARIFFS):Integer;
     function GetRealTMTarPeriodsCmdTable(dtDate:TDateTime;nVMID,nCMDID:Integer;var pTable:TM_TARIFFS):Boolean;
     function GetRealTMTarPeriodsPlaneTable(dtDate:TDateTime;nVMID,nCMDID:Integer;var pTable:TM_TARIFFS):Integer;
     function GetGroupsTable(var pTable:SL3INITTAG):Boolean;
     function GetAllAbonGroupsTable(nAbon:Integer;var pTable:SL3INITTAG):Boolean;
     function GetAbonGroupsTable(nAbon:Integer;var pTable:SL3INITTAG):Boolean;
     function GetAbonGroupsLVTable(nAbon,nLevel:Integer;var pTable:SL3INITTAG):Boolean;
     function GetAbonGroupsLVVMidTable(nAbon,nLevel:Integer;var pTable:SL3INITTAG):Boolean;

     function UpdateReReadMaskInArch(VMID : Integer; Date : TDateTime):Boolean;
     function GetGData(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
     function GetMeterType(FVMID:Integer;var nTypeID,swPLID:Integer):Boolean;
     function GetGDataTimeCRQ(x:Integer; var pTable:CCDatas):Boolean;
     function GetGDPData(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:CCDatas):Boolean;
     function GetEKOM3000GData(dtP0,dtP1:TDateTime;FKeyB,FKeyE,PKeyB,PKeyE:Integer;var pTable:CCDatasEkom):Boolean;
     function UpdareReReadMaskInGr(BM : int64; VMID : Integer; Date : TDateTime):Boolean;
     function GetGraphDatas(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetGraphDatas4(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetOneSliceData(dtP:TDateTime;VMID,SLID:integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetGraphDatasABON(dtP0,dtP1:TDateTime;ABOID,CMDID:integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetGraphDatasABONAllEn(dtP0,dtP1:TDateTime;ABOID:integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetGraphDatasFromSomeVMIDs(dtP0,dtP1:TDateTime;var FKey,PKey :string;var pTable:L3GRAPHDATAS):Boolean;
     function GetGraphDatasTimeCRQ(x:Integer; var pTable:L3GRAPHDATAS):Boolean;
     function GetEKOM3000GraphDatas(dtP0,dtP1:TDateTime;FKeyB,FKeyE,PKeyB,PKeyE:Integer;var pTable:L3GRAPHDATASEKOM):Boolean;
     function GetCurrentData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetAllCurrentData(FIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetCurrentDataInCCDatas(FIndex,FCmdIndex:Integer;var pTable:CCDatas):Boolean;
     function GetCurrentTimeData(FABO:Integer;var tTime:TDateTime):Boolean;
     function GetTariffData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetTariffString(FIndex:Integer):String;
     function UpdateTarifKoef(ID:integer; Koef:single):boolean;
     function LoadTID(ParamID : word) : word;
     function GetVMFromEnerg(var pTable : SL2TAGREPORTLIST) : boolean;
     function GetCurrTableForBTI(Um, NU, CMDID : Integer; var pTable : L3CURRENTDATAS) : Boolean;
     function GetArchTableForBTI(KanBeg, KanEnd, CMDID : Integer; dtP0, dtP1 : TDateTime; var pTable : CCDatas) : Boolean;
     function GetArchTableForBTIPuls(KanBeg, KanEnd, CMDID : Integer; dtP0, dtP1 : TDateTime; var pTable : CCDatas) : Boolean;
     function GetTariffTableForBTI(Um, NU : integer; var pTable:L3CURRENTDATAS):Boolean;
     function GetEventsTable(nIndex:Integer;var pTable:SEVENTSETTTAGS):Boolean;
//     function ReadJrnl(nIndex:Integer; Date : TDateTime; var pTable : SEVENTTAGS) : boolean;
//     function ReadJrnlEx(nIndex, VMID :Integer; dt1, dt2 : TDateTime; var pTable : SEVENTTAGS) : boolean;
//     function ReadJrnlLastOneCRQ(nIndex: Integer; var pTable : SEVENTTAGS) : boolean;
//     function ReadJrnlVM(nIndex, VM:Integer; Date : TDateTime; var pTable : SEVENTTAGS) : boolean;
//     function ReadJrnlLastCRQ(nIndex, VM:Integer; var pTable : SEVENTTAGS) : boolean;
//     function ReadJrnlIdCRQ(nIndex, n1, n2:Integer; var pTable : SEVENTTAGS) : boolean;
     Function GetCurrTableForECOM(Um, NU, CMDID : Integer; Var pTable : L3CURRENTDATAS) : Boolean;
     Function GetArchTableForECOM(KanBeg, KanEnd, CMDID : Integer; dtP0, dtP1 : TDateTime; Var pTable : CCDatas) : Boolean;
     Function GetGraphDatasECOM(dtP0, dtP1 : TDateTime; Um, NU : Integer; Var pTable : L3GRAPHDATAS) : Boolean;
//     Function ReadJrnlECOM(nIndex, IFrom, ITo : Integer; Date : TDateTime; Var pTable : SEVENTTAGS) : boolean;
     Function MakeSQLList(Um, NU, Tarifs : Integer) : AnsiString;

     function GetTestTable(var pTable:STESTTAGS):Boolean;
     function GetTestTypeTable(nTSTID:Integer;var pTable:STESTTAGS):Boolean;
     function IsTest(var pTable:STESTTAG):Boolean;
     function SetTestTable(var pTable:STESTTAG):Boolean;
     function SaveTestRecord(wTSTID,wObjID:Integer;dtTestTime:TDateTime;strComment,strDescription,strResult:String):Boolean;
     function AddTestTable(var pTable:STESTTAG):Boolean;
     function DelTestTable(nIndex:Integer):Boolean;

     function GetL2Info(var pTable:SL3GETL2INFOS):Boolean;

     //Функции для работы с EKOM - 3000
     function ReadUSPDCharDevCFG(IsMSGOur :boolean;var pTable : SL2USPDCHARACTDEVLISTEX) : boolean;
     function GetPortTable(var pTable:SL1TAG):Boolean;
     function GetMetersAll(var pTable:SL2INITITAG):Boolean;
     function GetParamsTypeTable(var pTable:QM_PARAMS):Boolean;
     function GetL1Table(var pTable:SL1INITITAG):Boolean;
     function GetAbonsTable(var pTable:SL3ABONS):Boolean;
     function GetAbonTable(swABOID:Integer;var pTable:SL3ABONS):Boolean;
     function GetAbonTableS(swABOIDS:string;var pTable:SL3ABONS):Boolean;
     function GetMMeterTable(VMID:Integer;var pTable:SL2TAG):Boolean;
     function GetGDPData_48(dtP0,dtP1:TDateTime;FKey,PKeyB,PKeyE:Integer;var pTable:CCDatas):Boolean;
     function GetGraphDatesPD48(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
//     function IsFixEvent(var pTable:SEVENTTAG):Boolean;
//     function FixUspdEvent(PKey,Group,nEvent:Integer):Boolean;
//     function AddFixEventTable(var pTable:SEVENTTAG):Boolean;
//     function UpdateKorrMonth(Delta: TDateTime):boolean;
     {}
     function GetOneVector(_VectorDT : TDateTime; _VMID : WORD; var _Table : SL3VectorData): Boolean; // Ukrop 2012-03-23
     function Get4EnergyGraphs(_Date : TDateTime;_VMID : Integer; var _pTable : L3GRAPHDATAS) : Boolean; // Ukrop 2012-05-02
     function GetMonitorTable(nVMID,nCMDID:Integer;m_dtDate:TdateTime;var pTable:SMONITORDATAS):Boolean;
     function IsMonitorTag(var pTable:SMONITORDATA):Boolean;
     function SetMonTable(var pTable:SMONITORDATA):Boolean;
     function AddMonTable(var pTable:SMONITORDATA):Boolean;
     function DelMonTable(nVMID,nCMDID:Integer;dtDate:TDateTime):Boolean;
     function GetSchemsTable(var pTable: SL3SCHEMTABLES ):boolean;
     function GetCurrentDataForSchems(var CMDIDStr, VMIDStr : String;var pTable:L3CURRENTDATAS):Boolean;
     function GetFormulaForVMID(VMID : integer):string;
     function GetCurrLimitValue(VMID, CMDID, TID : integer):double;
     function GetLimitDatas(VMID, CMDID : integer; var pTable: SL3LIMITTAGS):boolean;
     function GetGraphDatasEnergo(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetArchDates(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:CCDatas):Boolean;
     function GetGraphDates(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;

     function CurrentPrepare:Boolean;
     function CurrentExecute:Boolean;
     function CurrentFlush(swVMID:Integer):Boolean;

     function SetCurrentParam(var pTable:L3CURRENTDATA):Boolean;
     function SetCurrentParamNoBlock(var pTable:L3CURRENTDATA):Boolean;
     function SetCurrentParamNoBlock_8086(fub_num : string; id_object : integer;var pTable:L3CURRENTDATA):Boolean;

     function AddPDTData_48(var pTable:L3GRAPHDATA):Boolean;
     function UpdatePDTFilds_48(var pTable:L3CURRENTDATA):Boolean;
     function UpdatePDTFilds_48_8086(fub_num : string; id_object : integer; var pTable:L3CURRENTDATA):Boolean;

     function UpdatePDTData_48(var pTable:L3GRAPHDATA):Boolean;
     function IsPDTData_48(var pTable:L3GRAPHDATA):Boolean;

     function AddGraphData(var pTable:L3GRAPHDATA):Boolean;
     function UpdateGD48(var pTable:L3CURRENTDATA):Boolean;
     function UpdateGD48_8086(fub_num : string; id_object : integer; var pTable:L3CURRENTDATA):Boolean;

     function UpdateGraphData(var pTable:L3GRAPHDATA):Boolean;
     function IsGraphData(var pTable:L3GRAPHDATA):Boolean;

     function AddArchData(var pTable:L3CURRENTDATA):Boolean;
     function AddArchDataNoBlock(var pTable:L3CURRENTDATA{;var SQL_LOG:String}):Boolean;
     function AddArchDataNoBlock_8086(fub_num : string; id_object : integer; var pTable:L3CURRENTDATA{;var SQL_LOG:String}):Boolean;
     function AddArchDataNoBlockByt(var pTable:L3CURRENTDATA;var strSQL_DB : String):Boolean;

     function UpdateArchData(var pTable:L3CURRENTDATA):Boolean;
     function UpdateArchDataNoBlock(var pTable:L3CURRENTDATA):Boolean;
     
     function IsArchData(var pTable:L3CURRENTDATA):Boolean;
     function GetParamTableForGroup(GrID : integer; var pTable:SL3PARAMSS; var pNames : SL3ARRAYOFSTRING):Boolean;
     function GetAdditInfoForMTZTex(VMIDs : string; var pTable:SL3TECHMTZREPORTSDATAS):Boolean;
     function GetVMsTableABON(ABOID:Integer;var pTable:SL3VMETERTAGS):Boolean;
     function GetL2MtrsABON(ABOID:Integer;var pTable:SL2INITITAG):Boolean;
     function GetTransformatorInfo(VMID : integer; var pTable:SL2TAG):Boolean;
     function GetAtomArchDataDBFExport(_dt:TDateTime; _VMID:Integer; _tar, _CMD : WORD; var pTable:L3ARCHDATAMY):Boolean;
     function GetAtomArchDataDBFVITExport(_dt:TDateTime; _VMID:Integer; _tar, _CMD : WORD; var pTable:L3ARCHDATAMY):Boolean;
     function GetAbonLabel(nABOID: integer;var pTable:SL3ABONLB):Boolean;
     function GetAddressSett(nABOID:Integer):int64;
     function GetMogBitData(nABOID:Integer;de:TDateTime;var pTable:SL3ExportMOGBS):Boolean;
     function GetMogBitDataMySql(nABOID:Integer;de:TDateTime;var pTable:SL3ExportMOGBS):Boolean;     // ********** BO
     function GetMogBitDataMySqlExport(nABOID:Integer;var pTable:SL2INITITAG):Boolean;     // ********** BO
     function CalcTRET(dtCalc : TDateTime; VMID, CMDID, TID: integer): double;
     function GetAbonsTableNSDBF(strZavod,strMetType,strAID:String;var pTable:SL3ExportDBFS):Boolean;
     function GetAbonsTableNSDBFVIT(nABOID:Integer;de:TDateTime;var pTable:SL3ExportVitebsk):Boolean;
//     function GetEventsCount: integer;
//     function GetAllEventsTable(var pTable: SEVENTTAGS):Boolean;
     function GetEventName(GrID, EvID: integer): string;
     function GetFabNumber(VMID: integer): string;
     function FindNakEnInMonthDays(dtP0,dtP1:TDateTime;FKeyB,FKeyE,PKeyB,PKeyE:Integer;var pTable:CCDatasEkom): boolean;
     function getMeasureMeter(nParam,month,year:Integer; var measureMeter:MEASUREBALANSREP):Boolean;
     function getListMeter(pAID:Integer; var listMeter:TThreadList):Boolean;
     function getAbonInfBalans(pAID:Integer; var ulica, dom:String):Boolean;
     function getRegionHouseList(regionId:Integer; var houseList:TThreadList):Boolean;
     function getRegionHouseAbonList(AbonId, regionId:Integer; var houseList:TThreadList):Boolean;
     function getNoDataMeter(nParam,day,month,year,houseId:Integer; var MeterList:String; var count, countMeter : Integer):Boolean;
     function getCountHouseMeter(houseId:Integer):Integer;
     function getRegionId(houseId:Integer):Integer;
     function getRegionCountID(var regionList:TThreadList): Boolean;
     function addErrorArch(aid,mid:Integer):Boolean;
     function getNoDataMeterDay(strDate :String;houseId:Integer; var MeterList:String; var count : Integer):Boolean;
     function getChannelMeter(houseId,ChannelId,tarif:Integer;var pTable:SL2INITITAG):Boolean;
     function getChannel(houseId:Integer;var pTable:SL2INITITAG):Boolean;
     function getCountMeterKiKu(houseId:integer;strFabnum:string;var ki,ku:integer):boolean;
     function GetMetersSSDU(SAbon:integer;var pTable:SL2INITITAG):Boolean;
     function WriteBD(StrBD:TStringList):Boolean;
     function ChannelResetNul(aid:Integer):Boolean;
     function ChannelSet(aid,channel:Integer;fab_num:string):Boolean;
     function SetGroupRefresh(GID,STATE:Integer;_Date:TDateTime):Boolean;
     function SetFabNum_SwVMID(ABOID:Integer;SDDFABNUM:String):Integer;
     function setQueryGroupAbonsState(groupID,aboid,state:Integer):Boolean;
     function setQueryGroupAbonsStateProg(groupID,aboid,state:Integer):Boolean;
     function GetEnable(gGroup:integer;var pTable:TThreadList):Boolean;
     function delQueryGroupAbons(groupID,aboid:Integer):Boolean;
     function updateGQParams(groupID,qgParamID:Integer;field:String):Integer;
    protected
      SenderClass : TSenderClass;
      procedure SendEventBox(aType : Byte; aMessage : String);
    public
     property PTZoneHand       : TZoneHand       read FTZoneHand       write FTZoneHand;
    End;
implementation

uses knslRPHomeBalance;

function GetSqlDecimal(const D :Double): String;
begin
  Result := StringReplace(FloatToStr(D), DecimalSeparator, '.', [rfReplaceAll]);
end;

const
    MAX_BLOCK_QRY = 50;

constructor CDBDynamicConn.Create;
begin
  if SenderClass = Nil then SenderClass := TSenderClass.Create;
end;

constructor CDBDynamicConn.Create(m_strProvider : string);
begin
  if SenderClass = Nil then SenderClass := TSenderClass.Create;
  Self.Init(m_strProvider);
  Self.Connect;
end;

destructor CDBDynamicConn.Destroy;
begin
  //if vConn<>Nil then FreeAndNil(vConn);
  //if vQry<>Nil then  FreeAndNil(vQry);
  //if IBTr<>Nil then  FreeAndNil(IBTr);
  DestroyConnection(FADOConnection,FADOQuery);
  if SenderClass <> Nil then FreeAndNil(SenderClass);
  inherited;
end;

procedure CDBDynamicConn.SendEventBox(aType : Byte; aMessage : String);
Var s  : string;
    ID : Integer;
Begin
  ID := 0;
  s := SenderClass.ToStringBox(aType, aMessage);
  ID := GetCurrentThreadID;
  SenderClass.Send(QL_QWERYBOXEVENT, EventBoxHandle, ID, s);
End;

function CDBDynamicConn.InitStrFileName:String;
var
  Fl   : TINIFile;
begin
 try
   try
    Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\USPD_Config.ini');
    Result   := Fl.ReadString('DBCONFIG', 'DBProvider', '');
   except
    if Fl<>nil then FreeAndNil(Fl);
    Result:= 'C:\a2000\ascue\SYSINFOAUTO.fdb'
   end;
 finally
    if Fl<>nil then FreeAndNil(Fl);
 end;
end;

procedure CDBDynamicConn.Init(strFileName:String);
var
    Fl: TINIFile;
Begin
    m_strFileName := strFileName;
    //Fl := TINIFile.Create(strFileName);
    //if sCS=Nil then sCS:=TCriticalSection.Create;
    //m_strProvider        := Fl.ReadString('DBCONFIG', 'DBProvider', '');
    m_strProvider := strFileName;
    m_blIsConnect := False;
    //m_nCurrentConnection := Fl.ReadInteger('DBCONFIG','CurrentConnection', 0);
    //FFileIndex           := Fl.ReadInteger('DBCONFIG','FFileIndex', 0);
    //m_byConnectionLevel  := 1;
    //Fl.Destroy;
End;
function CDBDynamicConn.Connect:Boolean;
Begin
    Result := True;
    m_blIsConnect := True;
    try
     CreateConnection(FADOConnection,FADOQuery);
    except
    // TraceER('(__)CERMD::>Error In CDBDynamicConn.Connect!!!');
    end;
End;
         {
function CDBDynamicConn.Connect():Boolean;
Begin
    Result := True;
    m_blIsConnect := True;
    try
     CreateConnection(PADOConnection,FADOQuery);
    except

    end;
End;     }

function CDBDynamicConn.Disconnect:Boolean;
Begin
    //sCS.Enter;
    Result := True;
    m_blIsConnect := False;
    //Sleep(300);
    try
     DestroyConnection(FADOConnection,FADOQuery);
    except
    // TraceER('(__)CERMD::>Error In CDBDynamicConn.Disconnect!!!');
    end;
    //sCS.Leave;
    //sCS.Destroy;
End;
procedure CDBDynamicConn.CreateConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
var IBTr : TIBTransaction;
Begin
//    if vConn=Nil then
//    Begin
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
//      if vQry=Nil then
//      Begin
       vQry := TIBQuery.Create(Nil);
       vQry.Transaction:=IBTr;
       vQry.Database:=vConn;
//      End;
//    End;
End;


procedure CDBDynamicConn.DestroyConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
var IBTr : TIBTransaction;
Begin
  if vConn <> Nil then Begin
    IBTr := vQry.Transaction;
    if IBTr<>Nil then FreeAndNil(IBTr);
    if vQry<>Nil then FreeAndNil(vQry);
    vConn.DefaultTransaction := nil;
    FreeAndNil(vConn);
  End;
End;

procedure CDBDynamicConn.DestroyConnectionQuery(vQry:TIBQuery);
var IBTr : TIBTransaction;
Begin
  if vQry <> Nil then Begin
    IBTr := vQry.Transaction;
    if IBTr <> nil then FreeAndNil(IBTr);
      FreeAndNil(vQry);
    End;
End;

function CDBDynamicConn.ExecQry(strSQL:String):Boolean;
Var res : Boolean;
    iQ, iT : Integer;
Begin
  res := False;
  if m_blIsBackUp = True then Exit;
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
      // TEventBox.FixEvents(ET_CRITICAL, 'CDBDynamicConn.ExecQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'Error in CDBDynamicConn.ExecQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQuery.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQuery.Transaction.Rollback;
      res := False;
    end;
      end;  
  Result := res;
End;

function CDBDynamicConn.ExecQryByt(strList:TStringList):Boolean;
Var res : Boolean;
    i   : Integer;
    iQ, iT : Integer;
Begin
    if m_blIsBackUp=True then exit;
    res := True;
    try
    if not FADOQuery.Transaction.Active then
      FADOQuery.Transaction.StartTransaction;
    iQ := Integer(FADOQuery);
    iT := Integer(FADOQuery.Transaction);
     FADOQuery.Close;
     FADOQuery.SQL.Clear;
    for i:=0 to strList.Count-1 do begin
         FADOQuery.SQL.Add(strList[i]);
    end;
    // FADOQuery.SQL.Add(strSQL);
     FADOQuery.ExecSQL;
     FADOQuery.SQL.Clear;
     FADOQuery.Close;
    FADOQuery.Transaction.Commit;
  except
    on E: Exception do begin
      //TEventBox.FixEvents(ET_CRITICAL, 'CDBDynamicConn.ExecQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'Error in CDBDynamicConn.ExecQryByt: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQuery.Transaction = ' + IntToStr(iT));
      for i:=0 to strList.Count-1 do
        if i = 0 then
          SendEventBox(ET_CRITICAL, 'SQL reqest = ' + FADOQuery.SQL.Strings[i])
        else SendEventBox(ET_CRITICAL, '             ' + FADOQuery.SQL.Strings[i]);
      FADOQuery.Transaction.Rollback;
      res := False;
    end;
   end;
   Result := res;
End;


function CDBDynamicConn.OpenQry(strSQL:String;var nCount:Integer):Boolean;
Var res : Boolean;
    iQ, iT : Integer;
Begin
    res    := False;
    if m_blIsBackUp=True then exit;
    nCount := 0;
    if m_blIsConnect=False then Begin Result := False;exit;End;
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
      //TEventBox.FixEvents(ET_CRITICAL, 'CDBDynamicConn.ExecQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'Error in CDBDynamicConn.OpenQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQuery.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      FADOQuery.Transaction.Rollback;
      res := False;
    end;
    end;
    Result := res;
End;


function  CDBDynamicConn.OpenQrySL(SL:TStringList;var nCount:Integer):Boolean;
Var res : Boolean;
    i : Integer;
    iQ, iT : Integer;
Begin
  res    := False;
  if m_blIsBackUp=True then exit;
  nCount := 0;
  if m_blIsConnect=False then Begin Result := False;exit;End;
  try
    if not FADOQuery.Transaction.Active then
      FADOQuery.Transaction.StartTransaction;
    iQ := Integer(FADOQuery);
    iT := Integer(FADOQuery.Transaction);
   FADOQuery.SQL.Clear;
   FADOQuery.SQL := SL;
   FADOQuery.Open;
   FADOQuery.FetchAll;
    FADOQuery.Transaction.CommitRetaining;
   if FADOQuery.RecordCount>0 then  Begin nCount := FADOQuery.RecordCount; res := True;End;
  except
    on E: Exception do begin
      //TEventBox.FixEvents(ET_CRITICAL, 'CDBDynamicConn.ExecQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'Error in CDBDynamicConn.OpenQrySL: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'FADOQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'FADOQuery.Transaction = ' + IntToStr(iT));
      for i:=0 to SL.Count-1 do
        if i = 0 then
          SendEventBox(ET_CRITICAL, 'SQL reqest = ' + FADOQuery.SQL.Strings[i])
        else SendEventBox(0, '             ' + FADOQuery.SQL.Strings[i]);
      FADOQuery.Transaction.Rollback;
      res := False;
    end;
  end;
  Result := res;
end;


procedure CDBDynamicConn.CloseQry;
Begin
    if m_blIsConnect=False then exit;
    if m_blIsBackUp=True then exit;
    FADOQuery.SQL.Clear;
    FADOQuery.Close;
End;
//Dynamic Report

function CDBDynamicConn.DelArchData(dtBegin, dtEnd : TDateTime; abo,cmd:Integer):Boolean;
Var
    strSQL,strSel          : String;
    FirstCMDID,LastCMDID   : Integer;
Begin
    FirstCMDID := cmd - (cmd - 1) mod 4;
    LastCMDID  := FirstCMDID + 4;
     ////OLD////
   { strSel := '(select distinct m_swVMID from SL3ABON as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2'+
    ' where s0.m_swABOID=s1.m_swABOID and s1.m_sbyGroupID=s2.m_sbyGroupID and s0.m_swABOID='+IntToStr(abo)+')';
    strSQL := 'DELETE FROM L3ARCHDATA WHERE m_swVMID in'+strSel+
    ' and m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sTime as DATE) BETWEEN '+''''+DateToStr(dtBegin)+'''' +
    ' and ' + '''' + DateToStr(dtEnd) + '''';
    }
   ////OLD////
   ////NEW////
     strSel := '(select distinct m_swVMID from SL3ABON as L3AB,SL3GROUPTAG as L3GT,SL3VMETERTAG as L3MT'+
     ' where L3AB.m_swABOID='+IntToStr(abo)+' AND L3AB.m_swABOID=L3GT.m_swABOID AND L3GT.m_sbyGroupID=L3MT.m_sbyGroupID)';
     strSQL := 'DELETE FROM L3ARCHDATA'
     +' WHERE m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID)
     +' and CAST(m_sTime as DATE) BETWEEN '+''''+DateToStr(dtBegin)+''''
     +' and ' + '''' + DateToStr(dtEnd) + ''''
     +' and m_swVMID in'+strSel;
     Result := ExecQry(strSQL);
   ////NEW////
End;
function CDBDynamicConn.DelArchDataTP(dtBegin, dtEnd : TDateTime; cmd:Integer;abo:array of integer):Boolean;
Var
    i :integer;
    strSQL,strSel          : String;
    FirstCMDID,LastCMDID   : Integer;
Begin
  for i:=0 to Length(abo)-1 do
   begin
    FirstCMDID := cmd - (cmd - 1) mod 4;
    LastCMDID  := FirstCMDID + 4;
    strSel := '(select distinct m_swVMID from SL3ABON as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2'+
    ' where s0.m_swABOID=s1.m_swABOID and s1.m_sbyGroupID=s2.m_sbyGroupID and s0.m_swABOID='+IntToStr(abo[i])+')';
    strSQL := 'DELETE FROM L3ARCHDATA WHERE m_swVMID in'+strSel+
    ' and m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sTime as DATE) BETWEEN '+''''+DateToStr(dtBegin)+'''' +
    ' and ' + '''' + DateToStr(dtEnd) + '''';
    Result := ExecQry(strSQL);
   end;
End;

//TThreadList
function CDBDynamicConn.GetAbonL2Join(gid,nAbon:Integer;var pTable:TThreadList):Boolean;
Var
    i : Integer;
    strSQL   : String;
    strQuery : String;
    res      : Boolean;
    nCount   : Integer;
    pD       : CJoinL2;
    vList    : TList;
    sStatus  : String;
Begin
 try
  try
    res := False;
    sStatus := '';
    strQuery := '';
    if(gid<>-1) then strQuery := ' and s3.QGID='+IntToStr(gid);
    strSQL := 'SELECT s2.pullid,s2.m_swMID,s0.m_swVMID,s2.M_SBYTYPE'+
              ' FROM SL3VMETERTAG as s0,SL3GROUPTAG as s1,L2TAG as s2,QGABONS as s3'+
              ' WHERE s0.m_sbyGroupID=s1.m_sbyGroupID'+
              ' and s2.m_swMID=s0.m_swMID'+
              ' and s2.m_sbyEnable=1'+
              ' and s1.m_swABOID=s3.aboid'+
              ' and s3.enable=1'+
              strQuery +
              ' and s1.m_swABOID='+IntToStr(nAbon)+
              ' ORDER BY s0.m_swVMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     vList  := pTable.LockList;
     res := True;
     while not FADOQuery.Eof do
     Begin
      pD := CJoinL2.Create;;
      with FADOQuery do  Begin
       pD.m_swMID    := FieldByName('m_swMID').AsInteger;
       pD.m_swVMID   := FieldByName('m_swVMID').AsInteger;
       pD.m_swPullID := FieldByName('pullid').AsInteger;
       pD.M_SBYTYPE  := FieldByName('M_SBYTYPE').AsInteger;
       Next;
      End;
      vList.Add(pD);
     End;
     pTable.UnlockList;
    End;
    CloseQry;
  except
   res:=False;
  end;
 finally
    Result := res;
 end;
End;

function CDBDynamicConn.GetAbonL2JoinTP(gid:Integer;nAbon:array of integer;var pTable:TThreadList):Boolean;
Var
    i,j : Integer;
    strSQL   : String;
    strQuery : String;
    res      : Boolean;
    nCount   : Integer;
    pD       : CJoinL2;
    vList    : TList;
    sStatus  : String;
Begin
    for j:=0 to Length(nAbon)-1 do begin
    res := False;
    sStatus := '';
    strQuery := '';
    if(gid<>-1) then strQuery := ' and s3.QGID='+IntToStr(gid);
    strSQL := 'SELECT s2.pullid,s2.m_swMID,s0.m_swVMID,s2.M_SBYTYPE'+
              ' FROM SL3VMETERTAG as s0,SL3GROUPTAG as s1,L2TAG as s2,QGABONS as s3'+
              ' WHERE s0.m_sbyGroupID=s1.m_sbyGroupID'+
              ' and s2.m_swMID=s0.m_swMID'+
              ' and s2.m_sbyEnable=1'+
              ' and s1.m_swABOID=s3.aboid'+
              ' and s3.enable=1'+
              strQuery +
              ' and s1.m_swABOID='+IntToStr(nAbon[j]);
    if OpenQry(strSQL,nCount)=True then
    Begin
     vList  := pTable.LockList;
     res := True;
     while not FADOQuery.Eof do
     Begin
      pD := CJoinL2.Create;;
      with FADOQuery do  Begin
       pD.m_swMID    := FieldByName('m_swMID').AsInteger;
       pD.m_swVMID   := FieldByName('m_swVMID').AsInteger;
       pD.m_swPullID := FieldByName('pullid').AsInteger;
       pD.M_SBYTYPE  := FieldByName('M_SBYTYPE').AsInteger;
       Next;
      End;
      vList.Add(pD);
     End;
    End;
    CloseQry;
    Result := res;
   end;
     pTable.UnlockList;
End;


function CDBDynamicConn.setADR(aid:Integer;var pTable :PCIntBuffer):Boolean;
var
    strSQL,strFab: String;
    res          : Boolean;
    nCount,i,j   : Integer;

Begin
    Result := False;
    strSQL := 'Select M_SDDFABNUM '+
              'from l2tag where M_SWABOID='+ IntToStr(aid);
    i:=0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    SetLength(pTable^,nCount);
    while not FADOQuery.Eof do
    with FADOQuery do
      Begin
        strFab:= FADOQuery.FieldByName('m_sddFabNum').AsString;
        pTable^[i]:= StrToInt(strFab);
        Inc(i);
        Next;
      end;
    res := True;
    End;
    CloseQry;
    Result := res;
End;


//aid,cmd,QUERY_STATE_NO:Integer
function CDBDynamicConn.setQueryState(aid,mid,qState:Integer):Boolean;
Var
    strSQL,sqlQuery : String;
Begin
    if(mid=-1)  then sqlQuery := ' m_swABOID='+IntToStr(aid);
    if(mid<>-1) then sqlQuery := ' M_SWMID='+IntToStr(mid);
    strSQL := 'update l2tag set QUERYSTATE='+IntToStr(qState)+' where'+sqlQuery;
    Result := ExecQry(strSQL);
End;
function CDBDynamicConn.setQueryStateTP(mid,qState:Integer;aid:array of integer):Boolean;
Var
    strSQL,sqlQuery : String;
    i:integer;
Begin
    for i:=0 to Length(aid)-1 do
    begin
    if(mid=-1)  then sqlQuery := ' m_swABOID='+IntToStr(aid[i]);
    if(mid<>-1) then sqlQuery := ' M_SWMID='+IntToStr(mid);
    strSQL := 'update l2tag set QUERYSTATE='+IntToStr(qState)+' where'+sqlQuery;
    Result := ExecQry(strSQL);
    end;
End;


function CDBDynamicConn.GetAbonMetersLocTable(nAbon:Integer;strType:String;var pTable:SL3GROUPTAG):Boolean;
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


function CDBDynamicConn.getQueryGroup(var pull:TThreadList):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    groupList : TThreadList;
    pl       : QUERYGROUP;
    pList    : TList;
Begin
    res := False;
    strSQL := 'SELECT * FROM QUERYGROUP';
    groupList := TThreadList.Create;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
     while not FADOQuery.Eof do Begin
      pl := QUERYGROUP.Create;
     with FADOQuery do  Begin
      pl.ID     := FieldByName('ID').AsInteger;
      pl.NAME   := FieldByName('NAME').AsString;
      pl.ENABLE := FieldByName('ENABLE').AsInteger;
      Next;
      groupList.LockList.Add(pl);
      groupList.UnLockList;
      End;
     End;
     res := true;
    End;
    CloseQry;
    pList := groupList.LockList;
    for i:=0 to pList.Count-1 do
    Begin
     pl := pList[i];
     pl.itemParam := TThreadList.Create;
     pl.itemAbon := TThreadList.Create;
     getParamByID(pl.id,pl.itemParam);
     getAbonByID(pl.id,pl.itemAbon);
     pull.LockList.add(pList[i]);
     pull.UnLockList;
    End;
    groupList.UnLockList;
    FreeAndNil(groupList);
    Result := res;
End;

function CDBDynamicConn.getParamByID(id : Integer; var pull:TThreadList):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    item     : QGPARAM;
Begin
    res := False;
    strSQL := 'SELECT * FROM QGPARAM where QGID='+IntToStr(id);
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
     while not FADOQuery.Eof do Begin
      item := QGPARAM.Create;
     with FADOQuery do  Begin
      item.ID        := FieldByName('ID').AsInteger;
      item.QGID      := FieldByName('QGID').AsInteger;
      item.PARAM     := FieldByName('PARAM').AsInteger;
      item.DTBEGIN   := FieldByName('DTBEGIN').AsDateTime;
      item.DTEND     := FieldByName('DTEND').AsDateTime;
      item.DTPERIOD  := FieldByName('DTPERIOD').AsDateTime;
      item.DAYMASK   := FieldByName('DAYMASK').AsInteger;
      item.MONTHMASK := FieldByName('MONTHMASK').AsInteger;
      item.ENABLE    := FieldByName('ENABLE').AsInteger;
      item.DEEPFIND  := FieldByName('DEEPFIND').AsInteger;
      item.PAUSE     := FieldByName('PAUSE').AsInteger;
      item.FINDDATA  := FieldByName('FINDDATA').AsInteger;
      Next;
      End;
      pull.LockList.add(item);
      pull.UnLockList;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.getAbonByID(id : Integer; var pull:TThreadList):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    item     : QGABONS;
Begin
    res := False;
    strSQL := 'SELECT * FROM QGABONS where QGID='+IntToStr(id);
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
     while not FADOQuery.Eof do Begin
      item := QGABONS.Create;
     with FADOQuery do  Begin
      item.ID    := FieldByName('ID').AsInteger;
      item.QGID  := FieldByName('QGID').AsInteger;
      item.ABOID := FieldByName('ABOID').AsInteger;
      Next;
      End;
      pull.LockList.add(item);
      pull.UnLockList;
     End;
    End;
    CloseQry;
    Result := res;
End;
//function CDBDynamicConn.GetQueryAbons(groupID,isStatus:Integer;strStatus:String; var pTable:TThreadList):Boolean;
//gid.QGID,gid.ISRUNSTATUS,gid.RUNSTATUS
function CDBDynamicConn.GetQueryAbons(gid:QGPARAM;tptype:Integer; var pTable:TThreadList):Boolean;
Var
    strSQL : String;
    sStatus: String;
    sTpType, sTpFrom: String;
    res    : Boolean;
    nCount : Integer;
    data   : QGABONS;
Begin
    res := false;
    sTpType := ''; sStatus := '';sTpFrom := '';
    if (tptype<>-1) then
    Begin
     sTpFrom:=',SL3TP as s2';
     sTpType := ' and s1.TPID=s2.ID and s2.tptype='+IntToStr(tptype);
    End;
    if (gid.ISRUNSTATUS=1) then sStatus := ' and s0.state in('+gid.RUNSTATUS+')';
    strSQL := 'SELECT s0.*, (QG.NAME || '', '' || s1.M_SADDRESS || '', '' || s1.M_SNAME) M_SNAME '+    // BO 21.11.18
    ' FROM QGABONS as s0, SL3ABON as s1'+sTpFrom+ ', QUERYGROUP as QG ' +
    ' where s0.QGID = QG.ID and s0.QGID='+IntToStr(gid.QGID)+
    ' and s0.ABOID=s1.M_SWABOID'+sTpType+
    ' and s0.ENABLE=1'+sStatus+
    ' ORDER BY s0.ABOID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      data        := QGABONS.Create;
      data.id     := FADOQuery.FieldByName('id').AsInteger;
      data.QGID   := FADOQuery.FieldByName('QGID').AsInteger;
      data.ABOID  := FADOQuery.FieldByName('ABOID').AsInteger;
      data.ABONM  := FADOQuery.FieldByName('M_SNAME').AsString;
      data.ENABLE  := FADOQuery.FieldByName('ENABLE').AsInteger;
      data.ENABLE_PROG  := FADOQuery.FieldByName('ENABLE_PROG').AsInteger;
      FADOQuery.Next;
      pTable.LockList.Add(data);
      pTable.UnLockList;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetAbonFromGroupReload(gid:QGPARAM; tptype:Integer; check:integer; var List:TThreadList) : Boolean;
Var strSQL   : String;
    sStatus  : String;
    sTpType  : String;
    sTpFrom  : String;
    res      : Boolean;
    nCount   : Integer;
    data     : QGABONS;
begin
  res := False;
  sTpType := ''; sStatus := '';sTpFrom := '';
  if (tptype<>-1) then Begin
    sTpFrom:=',SL3TP as s2';
    sTpType := ' and s1.TPID=s2.ID and s2.tptype='+IntToStr(tptype);
  End;
  if (gid.ISRUNSTATUS=1) then sStatus := ' and s0.state in('+gid.RUNSTATUS+')';
  strSQL := 'SELECT s0.*, (QG.NAME || '', '' || s1.M_SADDRESS || '', '' || s1.M_SNAME) M_SNAME ' +    // BO 21.11.18
            ' FROM QGABONS as s0, SL3ABON as s1' + sTpFrom + ', QUERYGROUP as QG ' +
            ' where s0.QGID = QG.ID and s0.QGID=' + IntToStr(gid.QGID) +
            ' and s0.ABOID=s1.M_SWABOID' + sTpType +
            ' and s0.ENABLE=1' + sStatus;
  if Check = 1 then
    strSQL := strSQL + ' and s0.ENABLE_PROG=1'+
                       ' and s0.STATE<>18';
    strSQL := strSQL + ' ORDER BY s0.ABOID';

  if OpenQry(strSQL,nCount)=True then
  Begin
    res := True;
    while not FADOQuery.Eof do Begin
      if Trunc(FADOQuery.FieldByName('DTENDH').AsDateTime) <> Trunc(now) then begin
        if (FADOQuery.FieldByName('STATE').AsInteger = TASK_WAIT_RUN) or                   // = 0;  ожидание обработки
           (FADOQuery.FieldByName('STATE').AsInteger = TASK_WAIT_PORT) or                  // = 1;  запрос порта
           (FADOQuery.FieldByName('STATE').AsInteger = TASK_WAIT_CONN) or                  // = 2;  ожидание соединения
           (FADOQuery.FieldByName('STATE').AsInteger = TASK_CONN_OK) or                    // = 3;  соединение установлено
           (FADOQuery.FieldByName('STATE').AsInteger = TASK_QUERY) or                      // = 4;  опрос
           (FADOQuery.FieldByName('STATE').AsInteger = TASK_QUERY_WAIT) or                 // = 11; ожидание опроса
           (FADOQuery.FieldByName('STATE').AsInteger = TASK_QUERY_PROG) or                 // = 12; программирование
           (FADOQuery.FieldByName('STATE').AsInteger = TASK_QUERY_PROG_COMPL) or           // = 13; Программирование завершено
           (FADOQuery.FieldByName('STATE').AsInteger = CALL_STATE) or                      // = 14; Вызов абонента
           (FADOQuery.FieldByName('STATE').AsInteger = DATA_PROCESSING) or                 // = 15; опрос завершен, обработка данных
           (FADOQuery.FieldByName('STATE').AsInteger = TASK_QUERY_WAIT_PROG) or            // = 16; ожидание программирования
           (FADOQuery.FieldByName('STATE').AsInteger = ERROR_PROG) or                      // = 18; ошибка программирования или обрыв связи при программировании
           (FADOQuery.FieldByName('STATE').AsInteger = ERROR_NO_PROG) then                 // = 19; Концентратор не запрограммирован!
        begin
          data        := QGABONS.Create;
          data.id     := FADOQuery.FieldByName('id').AsInteger;
          data.QGID   := FADOQuery.FieldByName('QGID').AsInteger;
          data.ABOID  := FADOQuery.FieldByName('ABOID').AsInteger;
          data.ABONM  := FADOQuery.FieldByName('M_SNAME').AsString;
          data.ENABLE  := FADOQuery.FieldByName('ENABLE').AsInteger;
          data.ENABLE_PROG  := FADOQuery.FieldByName('ENABLE_PROG').AsInteger;
          List.LockList.add(data);
          List.UnLockList;
        end;
      end;
      FADOQuery.Next;
    end;
  end;
  CloseQry;
  Result := res;
end;

function CDBDynamicConn.GetQueryAbons8086(gid:QGPARAM;tptype:Integer;check:integer; var pTable:TThreadList):Boolean;
Var
    strSQL : String;
    sStatus: String;
    sTpType, sTpFrom: String;
    res    : Boolean;
    nCount : Integer;
    data   : QGABONS;
Begin
    res := false;
    sTpType := ''; sStatus := '';sTpFrom := '';
    if (tptype<>-1) then
    Begin
     sTpFrom:=',SL3TP as s2';
     sTpType := ' and s1.TPID=s2.ID and s2.tptype='+IntToStr(tptype);
    End;


    if (gid.ISRUNSTATUS=1) then sStatus := ' and s0.state in('+gid.RUNSTATUS+')';
    strSQL := 'SELECT s0.*,s1.M_SNAME FROM QGABONS as s0,SL3ABON as s1'+sTpFrom+
    ' where s0.QGID='+IntToStr(gid.QGID)+
    ' and s0.ABOID=s1.M_SWABOID'+sTpType+
    ' and s0.ENABLE=1'+sStatus+
    ' and s0.ENABLE_PROG=1'+
    ' and s0.STATE<>18'+
    ' ORDER BY s0.ABOID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      data        := QGABONS.Create;
      data.id     := FADOQuery.FieldByName('id').AsInteger;
      data.QGID   := FADOQuery.FieldByName('QGID').AsInteger;
      data.ABOID  := FADOQuery.FieldByName('ABOID').AsInteger;
      data.ABONM  := FADOQuery.FieldByName('M_SNAME').AsString;
      data.ENABLE  := FADOQuery.FieldByName('ENABLE').AsInteger;
      data.ENABLE_PROG  := FADOQuery.FieldByName('ENABLE_PROG').AsInteger;
      FADOQuery.Next;
      pTable.LockList.Add(data);
      pTable.UnLockList;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;


function CDBDynamicConn.GetQueryAbonsCheckTP(gid:QGPARAM;tptype:Integer):Boolean;
Var
    strSQL : String;
    sStatus: String;
    sTpType, sTpFrom: String;
    res    : Boolean;
    nCount : Integer;
    data   : QGABONS;
Begin
     sTpFrom:=',SL3TP as s2';
     sTpType := ' and s1.TPID=s2.ID and s2.tptype='+IntToStr(tptype);
    strSQL := 'SELECT s0.*,s1.M_SNAME FROM QGABONS as s0,SL3ABON as s1'+sTpFrom+
    ' where s0.QGID='+IntToStr(gid.QGID)+
    ' and s0.ABOID=s1.M_SWABOID'+sTpType+
    ' and s0.ENABLE=1'+sStatus+
    ' ORDER BY s0.ABOID';
    if OpenQry(strSQL,nCount)=True then
       res := True;
    CloseQry;
    Result := res;
End;


function CDBDynamicConn.GetQueryAbonsTP(gid:QGPARAM;tptype:Integer; var pTable:SLQQABONTP):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount,i : Integer;
    data   : QGABONS;
Begin
    i:=0;
    res := false;
    strSQL := 'SELECT s2.NAME,count (ALL s2.TPTYPE) FROM QGABONS as s0,SL3TP as s2'+
     ' where s0.QGID='+IntTostr(gid.QGID)+' and s2.ID=(select TPID from sl3abon where M_SWABOID=s0.ABOID)'+
     ' group by s2.NAME HAVING s2.NAME IS NOT NULL';
    if OpenQry(strSQL,nCount)=True then
    begin
    pTable.Count := nCount;

    SetLength(pTable.Items,nCount);

    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      NAMETP := FieldByName('NAME').AsString;
      Next;
      Inc(i);
      End;
    End;
     res := True;
    End;
    CloseQry;
    Result := res;
End;


function CDBDynamicConn.GetQueryAbonsTP_ABOID(gidID:Integer;NameTP:string; var pTable:TThreadList):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount,i : Integer;
    data   : QGABONS;
Begin
    i:=0;
    res := false;
    strSQL := 'SELECT QGABONS.*,SL3ABON.M_SNAME FROM'
    +' ((QGABONS INNER JOIN sl3abon ON QGABONS.ABOID = sl3abon.M_SWABOID)'
    +' INNER JOIN sl3tp ON sl3tp.id = sl3abon.tpid) where  QGABONS.ENABLE=1 and QGABONS.QGID='+IntToStr(gidID)+' and sl3tp.name='+'''' +NameTP+'''';

 if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      data        := QGABONS.Create;
      data.id     := FADOQuery.FieldByName('id').AsInteger;
      data.QGID   := FADOQuery.FieldByName('QGID').AsInteger;
      data.ABOID  := FADOQuery.FieldByName('ABOID').AsInteger;
      data.ABONM  := FADOQuery.FieldByName('M_SNAME').AsString;
      data.ENABLE  := FADOQuery.FieldByName('ENABLE').AsInteger;
      FADOQuery.Next;
      pTable.LockList.Add(data);
      pTable.UnLockList;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;


function CDBDynamicConn.setQueryGroupStat(qgID,stat:Integer):Integer;
Var
    strSQL,strQuery : String;
Begin
    strQuery := '';
    if qgID<>-1 then strQuery := ' where ID='+IntToStr(qgID);
    strSQL := 'UPDATE QUERYGROUP set STATPARAM='+IntToStr(stat)+strQuery;
    ExecQry(strSQL);
    Result := 1;
End;

function CDBDynamicConn.getQueryGroupStat(groupID:Integer):Integer;
Var
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
    data   : Integer;
Begin
    if groupID=-1 then Begin Result := 0;exit;End;
    strSQL := 'SELECT STATPARAM from QUERYGROUP where id='+IntToStr(groupID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      Result := FADOQuery.FieldByName('STATPARAM').AsInteger;
      FADOQuery.Next;
     End;
    res := True;
    End;
    CloseQry;
End;

function CDBDynamicConn.GetQueryAbonsEx(groupID:Integer;sortStr:String;var pTable:TThreadList):Boolean;
Begin
    if getQueryGroupStat(groupID)=1 then
    Result := GetQueryAbonsGroup(groupID,pTable) else
    Result := GetQueryAbonsDyn(groupID,sortStr,pTable);
End;

function CDBDynamicConn.GetQueryAbonsDyn(groupID:Integer;sortStr:String; var pTable:TThreadList):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
    data   : QGABONS;
    regNM,aboNM,depNM,townNM,streetNM,TPNM : String;
    dbIsOk : Double;
    dbIsNo : Double;
    dbIsEr : Double;
    dbAllCt: Double;
Begin
    res := false;
    strSQL := 'SELECT'+
    ' s0.DTBEGINH,s0.DTENDH,s0.DESCRIPTION,s0.STATE,s0.ENABLE,s0.ENABLE_PROG,s0.CURCOUNTER,'+
    ' s0.id,s0.QGID,s0.ABOID,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and M_SWABOID=s0.ABOID) as ALLCOUNTER,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_OK)+' and M_SWABOID=s0.ABOID and s0.QGID='+IntToStr(groupID)+') as ISOK,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_NO)+' and M_SWABOID=s0.ABOID and s0.QGID='+IntToStr(groupID)+') as ISNO,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_ER)+' and M_SWABOID=s0.ABOID and s0.QGID='+IntToStr(groupID)+') as ISER,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and M_SBYTYPE=17 and M_SWABOID=s0.ABOID and s0.QGID='+IntToStr(groupID)+') as EA8086,'+
    ' (select first 1 l2tag.M_SPHONE from l2tag where M_SBYENABLE=1 and M_SWABOID=s0.ABOID and s0.QGID='+IntToStr(groupID)+' group by l2tag.M_SPHONE) as NUM,'+
    ' (select First 1 QM_METERS.M_SCOMMENT from l2tag, QM_METERS where M_SBYENABLE=1 and M_SWABOID=s0.ABOID and s0.QGID='+IntToStr(groupID)+' and l2tag.M_SBYTYPE=QM_METERS.M_SWTYPE  group by QM_METERS.M_SCOMMENT) as SBNAME,'+
//    ' (select First 1 METERNAME.name from l2tag, METERNAME where M_SBYENABLE=1 and M_SWABOID=s0.ABOID and s0.QGID='+IntToStr(groupID)+' and l2tag.M_SBYTYPE=METERNAME.id  group by METERNAME.name) as SBNAME,'+
    ' (select first 1 l2tag.M_SBYTYPE from l2tag where M_SBYENABLE=1 and M_SWABOID=s0.ABOID and s0.QGID='+IntToStr(groupID)+' group by l2tag.M_SBYTYPE) as SBYTYPE,'+
    ' s1.M_SNAME as aboNM,s4.M_SNAME as townNM,s5.M_SNAME as streetNM, s6.Name as TPNM,s1.IDCHANNELGSM as GSM'+
    ' FROM QGABONS as s0,SL3ABON as s1,'+
    ' SL3REGION as s2,SL3DEPARTAMENT as s3,SL3TOWN as s4,SL3STREET as s5,sl3TP as s6'+
    ' where s0.QGID='+IntToStr(groupID)+
    ' and s0.ABOID=s1.M_SWABOID'+
    ' AND s1.M_NREGIONID=s2.M_NREGIONID'+
    ' AND s1.M_SWDEPID=s3.M_SWDEPID'+
    ' AND s1.M_SWTOWNID=s4.M_SWTOWNID'+
    ' AND s1.M_SWSTREETID=s5.M_SWSTREETID'+
    ' AND s1.TPID =s6.ID'+
    ' ORDER BY '+sortStr;
    //' ORDER BY townNM,streetNM,aboNM';
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
      TPNM             := FADOQuery.FieldByName('TPNM').AsString;
      streetNM         := FADOQuery.FieldByName('streetNM').AsString;
      data.ABONM       := townNM+'/'+TPNM+'/'+streetNM+'/'+aboNM;//townNM+'/'+streetNM+'/'+aboNM;
      data.DTBEGINH    := FADOQuery.FieldByName('DTBEGINH').AsDateTime;
      data.DTENDH      := FADOQuery.FieldByName('DTENDH').AsDateTime;
      data.ALLCOUNTER  := FADOQuery.FieldByName('ALLCOUNTER').AsInteger;
      data.ISOK        := FADOQuery.FieldByName('ISOK').AsInteger;
      data.ISNO        := FADOQuery.FieldByName('ISNO').AsInteger;
      data.ISER        := FADOQuery.FieldByName('ISER').AsInteger;
      //data.PERCENT     := FADOQuery.FieldByName('PERCENT').AsFloat;
      dbAllCt          := data.ALLCOUNTER;
      if(dbAllCt=0) then dbAllCt:=1;
      dbIsOk           := data.ISOK;
      dbIsNo           := data.ISNO;
      data.PERCENT     := 100*(dbAllCt-dbIsNo)/dbAllCt;
      data.QUALITY     := 100*dbIsOk/dbAllCt;
      data.CURCOUNTER  := FADOQuery.FieldByName('CURCOUNTER').AsString;
      data.DESCRIPTION := FADOQuery.FieldByName('DESCRIPTION').AsString;
      data.STATE       := FADOQuery.FieldByName('STATE').AsInteger;
      data.ENABLE      := FADOQuery.FieldByName('ENABLE').AsInteger;
      data.ENABLE_PROG := FADOQuery.FieldByName('ENABLE_PROG').AsInteger;
      data.EA8086      := FADOQuery.FieldByName('EA8086').AsInteger;
      data.NUMABON     := FADOQuery.FieldByName('NUM').AsString;
      data.TYPEUSPD    := FADOQuery.FieldByName('SBNAME').AsString;
      data.GSM         := FADOQuery.FieldByName('GSM').AsInteger;
      FADOQuery.Next;
      pTable.LockList.Add(data);
      pTable.UnLockList;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetQueryAbonsIDDyn(groupID,AbonID:Integer; var COLY,COLN:Integer):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
Begin
    res  := false;
    COLY := 0;
    COLN := 0;
    strSQL := 'select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_OK)+' and M_SWABOID='+IntToStr(AbonID);
    //' ORDER BY townNM,streetNM,aboNM';
    if OpenQry(strSQL,nCount)=True then
    Begin
     COLY           := FADOQuery.FieldByName('SUM').AsInteger;
     res := True;
    End;
    strSQL := 'select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_NO)+' and M_SWABOID='+IntToStr(AbonID);
     if OpenQry(strSQL,nCount)=True then
    Begin
     COLN           := FADOQuery.FieldByName('SUM').AsInteger;
     res := True;
    end;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetQueryAbonsError(aboid:Integer; var data : QGABONS):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
    dbIsOk : Double;
    dbIsNo : Double;
    dbIsEr : Double;
    dbAllCt: Double;
Begin
    res := false;
    strSQL := 'SELECT'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and M_SWABOID=s0.ABOID) as ALLCOUNTER,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_OK)+' and M_SWABOID=s0.ABOID) as ISOK,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_NO)+' and M_SWABOID=s0.ABOID) as ISNO,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_ER)+' and M_SWABOID=s0.ABOID) as ISER'+
    ' FROM QGABONS as s0'+
    ' where s0.ABOID='+IntToStr(aboid);
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      if data=nil then data := QGABONS.Create;
      data.ALLCOUNTER  := FADOQuery.FieldByName('ALLCOUNTER').AsInteger;
      data.ISOK        := FADOQuery.FieldByName('ISOK').AsInteger;
      data.ISNO        := FADOQuery.FieldByName('ISNO').AsInteger;
      data.ISER        := FADOQuery.FieldByName('ISER').AsInteger;
      dbAllCt          := data.ALLCOUNTER;
      if(dbAllCt=0) then dbAllCt:=1;
      dbIsOk           := data.ISOK;
      dbIsNo           := data.ISNO;
      data.PERCENT     := 100*(dbAllCt-dbIsNo)/dbAllCt;
      data.QUALITY     := 100*dbIsOk/dbAllCt;
      FADOQuery.Next;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetQueryAbonsGroup(groupID:Integer; var pTable:TThreadList):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
    data   : QGABONS;
    dbIsOk : Double;
    dbIsNo : Double;
    dbIsEr : Double;
    dbAllCt: Double;
Begin
    res := false;
    strSQL := ' select ('+
    ' select sum(1) from l2tag as s0,QGABONS as s1,QUERYGROUP as s2'+
    ' where s0.M_SBYENABLE=1'+
    ' and   s0.M_SWABOID=s1.aboid'+
    ' and   s2.ID=s1.qgid'+
    ' and   s2.ID=s3.id'+
    ' ) as ALLCOUNTER,'+
    ' (select sum(1) from l2tag as s0,QGABONS as s1,QUERYGROUP as s2'+
    ' where s0.M_SBYENABLE=1'+
    ' and   s0.QUERYSTATE='+IntToStr(QUERY_STATE_OK)+
    ' and   s0.M_SWABOID=s1.aboid'+
    ' and   s2.ID=s1.qgid'+
    ' and   s2.ID=s3.id'+
    ' ) as ISOK,'+
    ' (select sum(1) from l2tag as s0,QGABONS as s1,QUERYGROUP as s2'+
    ' where s0.M_SBYENABLE=1'+
    ' and   s0.QUERYSTATE='+IntToStr(QUERY_STATE_NO)+
    ' and   s0.M_SWABOID=s1.aboid'+
    ' and   s2.ID=s1.qgid'+
    ' and   s2.ID=s3.id'+
    ' ) as ISNO,'+
    ' (select sum(1) from l2tag as s0,QGABONS as s1,QUERYGROUP as s2'+
    ' where s0.M_SBYENABLE=1'+
    ' and   s0.QUERYSTATE='+IntToStr(QUERY_STATE_ER)+
    ' and   s0.M_SWABOID=s1.aboid'+
    ' and   s2.ID=s1.qgid'+
    ' and   s2.ID=s3.id'+
    ' ) as ISER'+
    ' from QUERYGROUP as s3 where s3.id='+IntToStr(groupID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
      data             := QGABONS.Create;
      data.PERCENT     := 0;
      data.QUALITY     := 0;
      data.id          := -1;
      data.QGID        := groupID;
      data.ABOID       := -1;
      data.DTBEGINH    := now;
      data.DTENDH      := now;
      data.ALLCOUNTER  := FADOQuery.FieldByName('ALLCOUNTER').AsInteger;
      data.ISOK        := FADOQuery.FieldByName('ISOK').AsInteger;
      data.ISNO        := FADOQuery.FieldByName('ISNO').AsInteger;
      data.ISER        := FADOQuery.FieldByName('ISER').AsInteger;
      dbAllCt          := data.ALLCOUNTER;
      dbIsOk           := data.ISOK;
      dbIsNo           := data.ISNO;
      if dbAllCt<>0 then data.PERCENT     := 100*(dbAllCt-dbIsNo)/dbAllCt;
      if dbAllCt<>0 then data.QUALITY     := 100*dbIsOk/dbAllCt;
      data.CURCOUNTER  := ' ';
      data.DESCRIPTION := '';
      data.STATE       := 0;
      data.ENABLE      := 1;
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

    id абонента	Код района	Название населенного пункта	Город\село	Улица	       Дом	Корпус	Квартира	Лицевой счет	Фамилия	   Имя	   Отчество	Заводской номер счетчика  Тип счетчика	Тип УСПД	Тип связи с ИЦ	номер для дозвона к УСПД	тип абонента	Количество точек учета	Поле 1	Поле 2	Поле 3	Поле 4	Поле 5	Поле 6	Поле 7
                20	        Могилев	                        0	        Орловского	24	Д	1         	1325001	        Nерешкова  Лариса  Арсеньевна	514256	                  EE8007	USPDEA8086	0	        3,75448E+11	                0	        1		        1	1

    CUnloadEntity = class
    public
      id        : Integer;
      rayCode   : String;
      townName  : String;
      gorSel    : String;
      street    : String;
      houseName : String;
      korpus    : String;
      kvarNo    : String;
      licNo     : String;
      fam       : String;
      imya      : String;
      otch      : String;
      zavNo     : String;
      metType   : String;
      uspdType  : String;
      connType  : String;
      connNo    : String;
      aboType   : String;
      amMeter   : String;
      field1    : String;
      field2    : String;
      field3    : String;
      field4    : String;
      field5    : String;
      field6    : String;
      field7    : String;
    End;
    a:=pos(Simvol,Result);
if a>0 then
Delete(Result,a,Length(Result)-a);
}
function CDBDynamicConn.getAbonInfo(aboid:Integer;var list:TThreadList):boolean;
Var
    i,s0     : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    pl       : CLoadEntity;
    strName  : String;
    strCurrentDir : String;
    nTypeList : TStringList;
Begin
    res := false;
    strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    nTypeList := TStringList.Create;
    nTypeList.loadfromfile(strCurrentDir+'MeterType.dat');
    strSQL := 'SELECT s1.M_SWABOID_CHANNEL,s1.M_SWABOID_TARIFF,s1.M_SWMID as mtid,s3.CODE as rayCode,s4.M_SNAME as nasp,s0.gors,'+
              ' s5.M_SNAME as ulica,s0.M_SHOUSENUMBER as dom,s0.M_SKORPUSNUMBER as korp,'+
              ' s1.M_SDDPHADDRES as kvar,s1.M_STPNUM as lics,s1.M_SCHNAME,s1.M_SDDFABNUM as zavno,'+
              ' s1.typepu,s1.M_SBYTYPE as typeuspd,s1.typezvaz,s1.M_SPHONE as nomerdoz,s1.typeabo,'+
              ' s1.M_SADVDISCL2TAG,s2.M_NREGIONID as mesID,s3.M_SWDEPID as resID,s4.M_SWTOWNID as naspID,'+
              ' s5.M_SWSTREETID as ulicaID,s0.M_SWABOID as aboID,s1.M_SBYLOCATION,s1.M_SFKI,s1.M_SFKU,s6.name as tpname,s6.tptype, s1.M_SBYMODEM, s1.M_SDDHADR_KV,s1.M_SDDHADR_HOUSE'+
              ' FROM SL3ABON as s0,L2TAG as s1,'+
              ' SL3REGION as s2,SL3DEPARTAMENT as s3,SL3TOWN as s4,SL3STREET as s5,SL3TP as s6'+
              ' WHERE s0.M_SWABOID=s1.M_SWABOID'+
              ' AND s0.M_SWABOID='+IntToStr(aboid)+
              ' AND s0.M_NREGIONID=s2.M_NREGIONID'+
              ' AND s0.TPID=s6.ID'+
              ' AND s0.M_SWDEPID=s3.M_SWDEPID'+
              ' AND s0.M_SWTOWNID=s4.M_SWTOWNID'+
              ' AND s0.M_SWSTREETID=s5.M_SWSTREETID order by cast(s1.M_SWMID as int);';
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
     while not FADOQuery.Eof do Begin
      pl := CLoadEntity.Create;
     with FADOQuery do  Begin
      pl.mtid      := FieldByName('mtid').AsInteger;
      pl.mesID     := FieldByName('mesID').AsInteger;
      pl.resID     := FieldByName('resID').AsInteger;
      pl.naspID    := FieldByName('naspID').AsInteger;
      pl.ulicaID   := FieldByName('ulicaID').AsInteger;
      pl.aboID     := FieldByName('aboID').AsInteger;
      pl.rayCode   := FieldByName('rayCode').AsString;
      pl.nasp      := FieldByName('nasp').AsString;
      pl.gors      := FieldByName('gors').AsString;;
      pl.ulica     := FieldByName('ulica').AsString;
      pl.dom       := FieldByName('dom').AsString;
      pl.korp      := FieldByName('korp').AsString;
      pl.kvar      := FieldByName('kvar').AsString;
      pl.lics      := FieldByName('lics').AsString;
      strName      := FieldByName('M_SCHNAME').AsString;
      setParseFIO(strName,pL);
      pl.zavno     := FieldByName('zavno').AsString;

      if (FieldByName('typeuspd').AsInteger=17)then
        begin
        s0           := FieldByName('typeuspd').AsInteger;
        pl.typeuspd  := nTypeList.Strings[s0];
        pl.typepu    := nTypeList.Strings[s0];
        end
      else
        begin
        s0           := FieldByName('typepu').AsInteger;
        pl.typepu    := nTypeList.Strings[s0];
        s0           := FieldByName('typeuspd').AsInteger;
        pl.typeuspd  := nTypeList.Strings[s0];
        end;

      pl.typezvaz  := FieldByName('M_SBYMODEM').AsString;//FieldByName('typezvaz').AsString;
      pl.nomerdoz    := FieldByName('nomerdoz').AsString;
      //pl.typeabo   := FieldByName('typeabo').AsString;
      pl.nomertu   := '1';
      pL.field7    := FieldByName('M_SADVDISCL2TAG').AsString;;
      setAddingFields(pL);
      pl.typeabo   := IntToStr(FieldByName('M_SBYLOCATION').AsInteger);
      pl.ki        := FieldByName('M_SFKI').AsFloat;
      pl.ku        := FieldByName('M_SFKU').AsFloat;
      pl.tp        := FieldByName('tpname').AsString;
      pl.idchannel := FieldByName('M_SWABOID_CHANNEL').AsString;
      pl.idtariff  := FieldByName('M_SWABOID_TARIFF').AsString;
      pl.house     := FieldByName('M_SDDHADR_HOUSE').AsString;
      pl.kv        := FieldByName('M_SDDHADR_KV').AsString;
      //if (FieldByName('tptype').AsInteger=0) then pl.tp := '';
      Next;
      list.LockList.Add(pl);
      list.UnLockList;
      End;
     End;
    End;
    CloseQry;
    if nTypeList<>nil then FreeAndnil(nTypeList);
    Result := res;
End;
//00001;00001;$000000;;;;;;14.08.2017;
procedure CDBDynamicConn.setAddingFields(var pD:CLoadEntity);
Var
    slv   : TStringList;
    str   : String;
Begin
 try
   try
      str := pD.field7;
      pD.field7 := '';
      slv := TStringList.Create;
      getStrings(';',str,slv);
      if slv.Count=1 then
      Begin
       pD.field1 := slv[0];
       pD.field2 := '';
       pD.field3 := '';
      End else
      if slv.Count=2 then
      Begin
       pD.field1 := slv[0];
       pD.field2 := slv[1];
       pD.field3 := '';
      End else
      if slv.Count>=3 then
      Begin
       pD.field1 := slv[0];
       pD.field2 := slv[1];
       pD.field3 := slv[2];
       pD.field4 := slv[3];
       pD.field5 := slv[4];
       pD.field6 := slv[5];
       pD.field7 := slv[6];
      End else
      Begin
       pD.field1 := '00001';
       pD.field2 := '00001';
       pD.field3 := '$000000';
      End;
   except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка! utlDynConnect.setAddingFields!');
   end;
 finally
   if (slv<>Nil) then FreeAndNil(slv);
 End;
End;
//(Кв №11/Лс №9951011)Гордеев Юрий Петрович
procedure CDBDynamicConn.setParseFIO(strFIO:String;var pD:CLoadEntity);
Var
      s0,s1 : Integer;
      slv   : TStringList;
Begin
  try
    try
      s0:=pos('(',strFIO);
      s1:=pos(')',strFIO);
      if (s0>0) and (s1>0) then
      Delete(strFIO,s0,s1);
      slv := TStringList.Create;
      getStrings(' ',strFIO,slv);
      if slv.Count=0 then
      Begin
       pD.fam      := '';
       pD.imya     := '';
       pD.otch     := '';
      End else
      if slv.Count=1 then
      Begin
       pD.fam      := slv[0];
       pD.imya     := '';
       pD.otch     := '';
      End else
      if slv.Count=2 then
      Begin
       pD.fam      := slv[0];
       pD.imya     := slv[1];
       pD.otch     := '';
      End else
      if slv.Count>=3 then
      Begin
       pD.fam      := slv[0];
       pD.imya     := slv[1];
       pD.otch     := slv[2];
      End;
   except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка! utlDynConnect.setParseFIO!');
   end;
 finally
   if (slv<>Nil) then FreeAndNil(slv);
 End
//      slv.Destroy;
End;
procedure CDBDynamicConn.getStrings(separator,s1:String;var value:TStringList);
Var
    j  : Integer;
    s2 : string;
Begin
    //separator := ' ';
    j:=0;
    while pos(separator, s1)<>0 do
    begin
     s2 := copy(s1,1,pos(separator, s1)-1);
     j := j + 1;
     delete (s1, 1, pos(separator, S1));
     value.Add(s2);
    end;
    if pos (separator, s1)=0 then
    begin
     j := j + 1;
     value.Add(s1);
    end;
End;
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
    strSQL := 'SELECT * FROM L2PULLS ORDER BY ID';

     pullList := TThreadList.Create;
    if OpenQry(strSQL,nCount)=True then
    Begin
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
     pl := pList[i];
     pl.item := TThreadList.Create;
     getPullByID(pl.id, pl.item);
     pull.LockList.add(pl);
     pull.UnLockList;
    End;
    finally
     pullList.UnLockList;
    end;
    Result := res;
    FreeAndNil(pullList);
End;
{
    ID                 INTEGER NOT NULL,
    PULLID             INTEGER NOT NULL,
    CONNECTIONTIMEOUT  INTEGER,
    CONNSTRING         VARCHAR(50),
    RECONNECTIONS      INTEGER,
    STATE              SMALLINT
}

function CDBDynamicConn.getPullByID(id : Integer; var pull:TThreadList):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    item     : CL2Pull;
Begin
    res := False;
    strSQL := 'SELECT * FROM L2PULL where pullid='+IntToStr(id);
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
     while not FADOQuery.Eof do Begin
      item := CL2Pull.Create;
     with FADOQuery do  Begin
      item.ID                := FieldByName('ID').AsInteger;
      item.PULLID            := FieldByName('PULLID').AsInteger;
      item.PORTID            := FieldByName('PORTID').AsInteger;
      item.CONNECTIONTIMEOUT := FieldByName('CONNECTIONTIMEOUT').AsInteger;
      item.CONNSTRING        := FieldByName('CONNSTRING').AsString;
      item.RECONNECTIONS     := FieldByName('RECONNECTIONS').AsInteger;
      item.STATE             := FieldByName('STATE').AsInteger;
      Next;
      End;
      pull.LockList.add(item);
      pull.UnLockList;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.addQueryGroupAbon(pTable:QGABONS):Integer;
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

function CDBDynamicConn.setDtBeginEndInQueryQroup(id:Integer;dtBegin,dtEnd:TDateTime;state:Integer):Boolean;
Var
    strSql : String;
Begin
    strSql := 'update QGABONS set DTBEGINH='+''''+DateTimeToStr(dtBegin)+''''+','+
              ' DTENDH='+''''+DateTimeToStr(dtEnd)+''''+','+
              ' STATE='+IntToStr(state)+
              ' where aboid='+IntToStr(id);
    Result:= ExecQry(strSQL);
   // Result := 1;
End;

function CDBDynamicConn.SetChannelGSM(AboId,id:Integer;var Port:Integer):Integer;
Var
    strSql,strSql1 : String;
    PORTID,nCount  : Integer;
    res            : Boolean;
Begin
   PORTID:=0;
   res:=False;
   strSql1:='SELECT PORTNUM FROM GET_L1_PORTNUM('+IntToStr(id)+')';
     if OpenQry(strSQL1,nCount)=True then
     Begin
       res := True;
       PORTID      := FADOQuery.FieldByName('PORTNUM').AsInteger;
     End;
   CloseQry;

    if (PORTID<>0)then
    begin
    Port:= PORTID;
    strSql := 'update SL3ABON set'+
              ' IDCHANNELGSM='+IntToStr(PORTID)+
              ' where M_SWABOID='+IntToStr(AboId);
    ExecQry(strSQL);
    Result := 1;
    end;
End;

function CDBDynamicConn.SetResetChannelGSM(AboId,id:Integer):Integer;
Var
    strSql,strSql1 : String;
    PORTID,nCount  : Integer;
    res            : Boolean;
Begin
    strSql := 'update SL3ABON set'+
              ' IDCHANNELGSM='+IntToStr(id)+
              ' where M_SWABOID='+IntToStr(AboId);
    ExecQry(strSQL);
    Result := 1;
End;

function CDBDynamicConn.setDtBeginInQueryQroup(id:Integer;date:TDateTime;state:Integer):Integer;
Var
    strSql : String;
Begin
    strSql := 'update QGABONS set DTBEGINH='+''''+DateTimeToStr(date)+''''+','+
              ' STATE='+IntToStr(state)+
              ' where aboid='+IntToStr(id);
    ExecQry(strSQL);
    Result := 1;
End;
function CDBDynamicConn.setDtEndInQueryQroup(id:Integer;date:TDateTime;state:Integer):Integer;
Var
    strSql : String;
Begin
    strSql := 'update QGABONS set DTENDH='+''''+DateTimeToStr(date)+''''+','+
              ' STATE='+IntToStr(state)+
              ' where aboid='+IntToStr(id);
    ExecQry(strSQL);
    Result := 1;
End;
function CDBDynamicConn.setKvarQueryQroup(id:Integer;kvar:String):Integer;
Var
    strSql : String;
Begin
    strSql := 'update QGABONS set CURCOUNTER='+''''+kvar+''''+
              ' where aboid='+IntToStr(id);
    ExecQry(strSQL);
    Result := 1;
End;
function CDBDynamicConn.setDescQueryQroup(id:Integer;strCtNm,desc:String;state:Integer):Integer;
Var
    strSql : String;
Begin
    strSql := 'update QGABONS set COUNTERNAME='+''''+strCtNm+''''+','+
              ' STATE='+IntToStr(state)+','+
              ' DESCRIPTION='+''''+desc+''''+
              ' where aboid='+IntToStr(id);
    ExecQry(strSQL);
    Result := 1;
End;
function CDBDynamicConn.setStateQueryQroup(id:Integer;state:Integer):Integer;
Var
    strSql : String;
Begin
    strSql := 'update QGABONS set STATE='+IntToStr(state)+
              ' where aboid='+IntToStr(id);
    ExecQry(strSQL);
    Result := 1;
End;

function CDBDynamicConn.GetCommandsTable(nChannel:Integer;var pTable:TThreadList):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
    pD       : CComm;
    vList    : TList;
Begin
    res := False;
    strSQL := 'SELECT * FROM CCOMMAND WHERE m_swMID='+IntToStr(nChannel)+' ORDER BY m_swCmdID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     vList := pTable.LockList;
     res := True;
     while not FADOQuery.Eof do Begin
     pD := CComm.Create;
     with FADOQuery,pD do  Begin
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swMID     := FieldByName('m_swMID').AsInteger;
      m_swCmdID   := FieldByName('m_swCmdID').AsInteger;
      m_swChannel := FieldByName('m_swChannel').AsString;
      m_swSpecc0  := FieldByName('m_swSpecc0').AsInteger;
      m_swSpecc1  := FieldByName('m_swSpecc1').AsInteger;
      m_swSpecc2  := FieldByName('m_swSpecc2').AsInteger;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_snDataType:= FieldByName('m_snDataType').AsInteger;
      Next;
      End;
      pTable.add(pD);
     End;
     pTable.UnLockList;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetPortTable(var pTable:SL1TAG):Boolean;
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
function CDBDynamicConn.GetMetersIniTable(var pTable:SL2INITITAG):Boolean;
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
      m_sAdvDiscL2Tag:= FieldByName('m_sAdvDiscL2Tag').AsString;
      m_sbyStBlock   := FieldByName('m_sbyStBlock').AsInteger;
      Next;
      Inc(i);
      End;
     End;           
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetAbonGroupsTable(nAbon:Integer;var pTable:SL3INITTAG):Boolean;
Var
    strSQL,str   : String;
    res      : Boolean;
    nCount,i : Integer;
Begin
    //str := 'Энергосбыт';
    strSQL := 'SELECT * FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(nAbon)+
    ' AND m_sbyEnable=1 ORDER BY m_swPosition';
    //' and m_sGroupName<>'+''''+str+''''+' ORDER BY m_sbyGroupID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      m_sbyID         := FieldByName('m_sbyID').AsInteger;
      m_swABOID       := FieldByName('m_swABOID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      //m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      //Item.Count      := FieldByName('m_swAmVMeter').AsInteger;
      m_swPosition    := FieldByName('m_swPosition').AsInteger;
      m_sGroupName    := FieldByName('m_sGroupName').AsString;
      m_sGroupExpress := FieldByName('m_sGroupExpress').AsString;
      m_swPLID        := FieldByName('m_swPLID').AsInteger;
      m_sbyEnable     := FieldByName('m_sbyEnable').AsInteger;
      m_nGroupLV      := FieldByName('M_NGROUPLV').AsInteger;
      Inc(i);
      Next;
     End;
     End;
    res := True;
    End;
    CloseQry;
   Result := res;
   //End;
End;
function CDBDynamicConn.GetAllAbonGroupsTable(nAbon:Integer;var pTable:SL3INITTAG):Boolean;
Var
    strSQL,str   : String;
    res      : Boolean;
    nCount,i : Integer;
Begin
    //str := 'Энергосбыт';
    strSQL := 'SELECT * FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(nAbon);
    //' and m_sGroupName<>'+''''+str+''''+' ORDER BY m_sbyGroupID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      m_sbyID         := FieldByName('m_sbyID').AsInteger;
      m_swABOID       := FieldByName('m_swABOID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      //m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      //Item.Count      := FieldByName('m_swAmVMeter').AsInteger;
      m_swPosition    := FieldByName('m_swPosition').AsInteger;
      m_sGroupName    := FieldByName('m_sGroupName').AsString;
      m_sGroupExpress := FieldByName('m_sGroupExpress').AsString;
      m_swPLID        := FieldByName('m_swPLID').AsInteger;
      m_sbyEnable     := FieldByName('m_sbyEnable').AsInteger;
      m_nGroupLV      := FieldByName('M_NGROUPLV').AsInteger;
      Inc(i);
      Next;
     End;
     End;
    res := True;
    End;
    CloseQry;
   Result := res;
   //End;
End;
function CDBDynamicConn.GetAbonGroupsLVTable(nAbon,nLevel:Integer;var pTable:SL3INITTAG):Boolean;
Var
    strSQL,strEQ,str   : String;
    res      : Boolean;
    nCount,i : Integer;
Begin
    //str := 'Энергосбыт';
    if nLevel=0  then strEQ := ' AND M_NGROUPLV=0' else
    if nLevel<>0 then strEQ := ' AND M_NGROUPLV<>0';
    strSQL := 'SELECT * FROM SL3GROUPTAG WHERE m_swABOID='+IntToStr(nAbon)+
    strEQ+//' AND M_NGROUPLV='+IntToStr(nLevel)+
    ' AND m_sbyEnable=1 ORDER BY m_swPosition';
    //' and m_sGroupName<>'+''''+str+''''+' ORDER BY m_sbyGroupID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      m_sbyID         := FieldByName('m_sbyID').AsInteger;
      m_swABOID       := FieldByName('m_swABOID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      //m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      //Item.Count      := FieldByName('m_swAmVMeter').AsInteger;
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
   //End;
End;
function CDBDynamicConn.GetAbonGroupsLVVMidTable(nAbon,nLevel:Integer;var pTable:SL3INITTAG):Boolean;
Var
    i : Integer;
    res : Boolean;
Begin
    res := GetAbonGroupsLVTable(nAbon,nLevel,pTable);
    if res=True then
    Begin
     for i:=0 to pTable.Count-1 do
     GetVMetersTable(nAbon, pTable.Items[i].m_sbyGroupID,pTable.Items[i]);
    End;
    Result := res;
End;
//function CDBDynamicConn.GetVMetersTable(nAbon,nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
function CDBDynamicConn.GetGroupsTable(var pTable:SL3INITTAG):Boolean;
Var
    strSQL,str   : String;
    res      : Boolean;
    nCount,i : Integer;
Begin
    {strSQL := 'SELECT * FROM SL3INITTAG';res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do
     Begin
      m_sbyLayerID := FieldByName('m_sbyLayerID').AsInteger;
      m_swAmGroup  := FieldByName('m_swAmGroup').AsInteger;
     End;
    CloseQry;   }
    str := 'Энергосбыт';
    //strSQL := 'SELECT * FROM SL3GROUPTAG WHERE m_sGroupName<>'+''''+str+''''+' ORDER BY m_sbyGroupID';
    strSQL := 'SELECT * FROM SL3GROUPTAG WHERE m_sGroupName<>'+''''+str+''''+' ORDER BY m_swPosition';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do Begin
      m_sbyID         := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      //m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      //Item.Count      := FieldByName('m_swAmVMeter').AsInteger;
      m_swPosition    := FieldByName('m_swPosition').AsInteger;
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
   //End;
End;
function CDBDynamicConn.LoadReportParams(var pTable : REPORT_F1):boolean;
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
   End;
   CloseQry;
   Result := res;
end;

function CDBDynamicConn.SaveReportParams(var pTable : REPORT_F1):boolean;
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
                 ' WHERE m_swID='+IntToStr(m_swID);
    end;
    Result := ExecQry(strSQL);
end;
function CDBDynamicConn.GetVMetersTable(nAbon,nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    nCount := 0;
    res := False;
    if (nAbon=-1)and(nChannel=-1) then
      strSQL := 'SELECT * FROM SL3VMETERTAG, L2TAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_swmid = l2tag.m_swmid'+
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID'+
                ' ORDER BY SL3GROUPTAG.m_swABOID,SL3VMETERTAG.m_swVMID';
      //strSQL := 'SELECT * FROM SL3VMETERTAG,L2TAG WHERE SL3VMETERTAG.m_swmid = l2tag.m_swmid ORDER BY SL3VMETERTAG.m_swVMID';
    if nChannel<>-1 then
      strSQL := 'SELECT * FROM SL3VMETERTAG, L2TAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_swmid = l2tag.m_swmid'+
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID'+
                ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                ' and SL3VMETERTAG.m_sbyGroupID='+IntToStr(nChannel)+
                ' ORDER BY SL3VMETERTAG.m_swVMID';
    if (nChannel=-1) and (nAbon<>-1)  then
      strSQL := 'SELECT * FROM SL3VMETERTAG,L2TAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_swmid = l2tag.m_swmid'+
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID'+
                ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                ' ORDER BY SL3VMETERTAG.m_swVMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter:= nCount;
     pTable.Item.Count  := nCount;
     SetLength(pTable.Item.Items,nCount);
    // SetLength(MeterPrecision, nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
      m_swID                   := FieldByName('m_swID').AsInteger;
      m_swMID                  := FieldByName('m_swMID').AsInteger;
      m_sbyPortID              := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType                := FieldByName('m_sbyType').AsInteger;
      m_sbyGroupID             := FieldByName('m_sbyGroupID').AsInteger;
      m_swVMID                 := FieldByName('m_swVMID').AsInteger;
      m_sddPHAddres            := FieldByName('m_sddPHAddres').AsString;
      m_sMeterName             := FieldByName('m_sMeterName').AsString;
      m_sVMeterName            := FieldByName('m_sVMeterName').AsString;
      m_sMeterCode             := FieldByName('m_sMeterCode').AsString;
      m_sbyEnable              := FieldByName('m_sbyEnable').AsInteger;
      MeterPrecision[m_swVMID] := FieldByName('m_sbyPrecision').AsInteger;
      Next;
      Inc(i);
      End;
     End;
     MaxPrecision := FindMax(MeterPrecision, nCount);
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetVMetersAbonTable(nAbon,nVMID:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    nCount := 0;
    res := False;
    pTable.m_swAmVMeter := 0;
    pTable.Item.Count   := 0;
    if (nAbon=-1)and(nVMID=-1) then
      strSQL := 'SELECT * FROM SL3VMETERTAG, L2TAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_swmid = l2tag.m_swmid'+
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID'+
                ' ORDER BY SL3GROUPTAG.m_swABOID,SL3VMETERTAG.m_swVMID' else
    if (nAbon<>-1)and(nVMID=-1) then
      strSQL := 'SELECT * FROM SL3VMETERTAG, L2TAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_swmid = l2tag.m_swmid'+
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID'+
                ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                ' ORDER BY SL3VMETERTAG.m_swVMID' else
    if (nAbon<>-1)and(nVMID<>-1) then
      strSQL := 'SELECT DISTINCT * FROM SL3VMETERTAG,L2TAG,SL3GROUPTAG WHERE SL3VMETERTAG.m_swmid = l2tag.m_swmid'+
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID'+
                ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                ' and SL3VMETERTAG.m_swVMID=' + IntToStr(nVMID)+
                ' ORDER BY SL3VMETERTAG.m_swVMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter:= nCount;
     pTable.Item.Count  := nCount;
     SetLength(pTable.Item.Items,nCount);
    // SetLength(MeterPrecision, nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Item.Items[i] do  Begin
      m_swID                   := FieldByName('m_swID').AsInteger;
      m_swMID                  := FieldByName('m_swMID').AsInteger;
      m_sbyPortID              := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType                := FieldByName('m_sbyType').AsInteger;
      m_sbyGroupID             := FieldByName('m_sbyGroupID').AsInteger;
      m_swVMID                 := FieldByName('m_swVMID').AsInteger;
      m_sddPHAddres            := FieldByName('m_sddPHAddres').AsString;
      m_sMeterName             := FieldByName('m_sMeterName').AsString;
      m_sVMeterName            := FieldByName('m_sVMeterName').AsString;
      m_sbyExport              := FieldByName('m_sbyExport').AsInteger;
      m_sbyEnable              := FieldByName('m_sbyEnable').AsInteger;
      //MeterPrecision[m_swVMID] := FieldByName('m_sbyPrecision').AsInteger;
      Next;
      Inc(i);
      End;
     End;
     //MaxPrecision := FindMax(MeterPrecision, nCount);
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetMeterTableForReport(nAbon,GroupID : integer;var pTable : SL2TAGREPORTLIST) : boolean;
Var
    nCount,i : Integer;
    res      : Boolean;
    strSQL   : String;
begin
    nCount := 0;                       
    res    := False;
    //SL3GROUPTAG WHERE m_swABOID
    if GroupID <> - 1 then
      strSQL := 'SELECT SL3ABON.m_sObject,SL3GROUPTAG.m_sGroupName,SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM, SL3VMETERTAG.m_swvmid, '+
                ' L2TAG.M_SWMID, M_SFKI, M_SFKU, QM_METERS.m_sname, SL3VMETERTAG.m_sbytype, l2Tag.m_sbyPrecision ' +
                ' from SL3ABON,SL3VMETERTAG, L2TAG, QM_METERS,SL3GROUPTAG ' +
                ' where l2tag.m_swmid=SL3VMETERTAG.m_swmid and QM_METERS.m_swtype=SL3VMETERTAG.m_sbytype' +
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID and SL3GROUPTAG.m_sbyEnable=1'+
                ' and SL3ABON.m_swABOID=SL3GROUPTAG.m_swABOID'+
                ' and SL3VMETERTAG.m_sbyType<>' + IntToStr(MET_VZLJOT)+
                ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                ' and  SL3VMETERTAG.M_SBYGROUPID = ' + IntToStr(GroupID)+
                ' ORDER BY SL3GROUPTAG.M_SWPOSITION'
    else
      strSQL := 'SELECT SL3ABON.m_sObject,SL3GROUPTAG.m_sGroupName,SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM, SL3VMETERTAG.m_swvmid, '+
                ' L2TAG.M_SWMID, M_SFKI, M_SFKU, QM_METERS.m_sname, SL3VMETERTAG.m_sbytype, l2tag.m_sbyPrecision ' +
                ' from SL3ABON,SL3VMETERTAG, L2TAG, QM_METERS,SL3GROUPTAG ' +
                ' where l2tag.m_swmid=SL3VMETERTAG.m_swmid and QM_METERS.m_swtype=SL3VMETERTAG.m_sbytype'+
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID and SL3GROUPTAG.m_sbyEnable=1'+
                ' and SL3ABON.m_swABOID=SL3GROUPTAG.m_swABOID'+
                ' and SL3VMETERTAG.m_sbyType<>' + IntToStr(MET_VZLJOT)+
                ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                ' ORDER BY SL3GROUPTAG.m_sbygroupid';
    i := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     pTable.Count := nCount;
     SetLength(pTable.m_sMeter, nCount);
    // SetLength(MeterPrecision, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery,pTable.m_sMeter[i] do
       Begin
         //m_sObject                := FieldByName('m_sObject').AsString;
         m_sGroupName             := FieldByName('m_sGroupName').AsString;
         m_sVMeterName            := FieldByName('m_svmetername').AsString;
         m_sddPHAddres            := FieldByName('M_SDDFABNUM').AsString;
         m_swVMID                 := FieldByName('m_swvmid').AsInteger;
         m_swMID                  := FieldByName('M_SWMID').AsInteger;
         m_sfKI                   := FieldByName('M_SFKI').AsFloat;
         m_sfKU                   := FieldByName('M_SFKU').AsFloat;
         m_sName                  := FieldByName('m_sname').AsString;
         m_sbyType                := FieldByName('m_sbytype').AsInteger;
         MeterPrecision[m_swVMID] := FieldByName('m_sbyPrecision').AsInteger;
         Inc(i);
         Next;
       End;
     end;
     MaxPrecision := FindMax(MeterPrecision, nCount);
     res := True;
    End;
    CloseQry;
    Result := res;
end;
function CDBDynamicConn.GetUsersTable(var pTable:SUSERTAGS):Boolean;
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
      m_sbyQryGrp    := FieldByName('m_sbyQryGrp').AsInteger;
      m_sbyAccReg    := FieldByName('m_sbyAccReg').AsInteger;
      m_sAccesReg    := FieldByName('m_sAccesReg').AsString;
      m_sAllowAbon   := FieldByName('m_sAllowAbon').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetMeterTableForReportWithCode(nAbon,GroupID : integer;Code:string;var pTable : SL2TAGREPORTLIST) : boolean;
Var
    nCount,i : Integer;
    res      : Boolean;
    strSQL   : String;
begin
    nCount := 0;
    res    := False;
    pTable.Count := 0;
    if Code = '' then
    begin
      if GroupID <> - 1 then
        strSQL := 'SELECT SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM, SL3VMETERTAG.m_swvmid, '+
                  ' L2TAG.M_SWMID, M_SFKI, M_SFKU, m_sname, SL3VMETERTAG.m_sbytype, l2Tag.m_sbyPrecision ' +
                  ' from SL3VMETERTAG, L2TAG, QM_METERS,SL3GROUPTAG ' +
                  ' where l2tag.m_swmid=SL3VMETERTAG.m_swmid and QM_METERS.m_swtype=SL3VMETERTAG.m_sbytype' +
                  ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID and SL3GROUPTAG.m_sbyEnable=1'+
                  ' and SL3VMETERTAG.m_sbyType<>' + IntToStr(MET_VZLJOT)+
                  ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                  ' and  SL3VMETERTAG.M_SBYGROUPID = ' + IntToStr(GroupID)+
                  ' ORDER BY sl3grouptag.M_SWPOSITION'
      else
        strSQL := 'SELECT SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM, SL3VMETERTAG.m_swvmid, '+
                  ' L2TAG.M_SWMID, M_SFKI, M_SFKU, m_sname, SL3VMETERTAG.m_sbytype, l2tag.m_sbyPrecision ' +
                  ' from SL3VMETERTAG, L2TAG, QM_METERS,SL3GROUPTAG ' +
                  ' where l2tag.m_swmid=SL3VMETERTAG.m_swmid and QM_METERS.m_swtype=SL3VMETERTAG.m_sbytype'+
                  ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID and SL3GROUPTAG.m_sbyEnable=1'+
                  ' and SL3VMETERTAG.m_sbyType<>' + IntToStr(MET_VZLJOT)+
                  ' and SL3VMETERTAG.m_sbyType<>' + IntToStr(MET_SUMM)+
                  ' and SL3VMETERTAG.m_sbyType<>' + IntToStr(MET_GSUMM)+
                  ' and SL3GROUPTAG.M_SBYENABLE=1' +
                  ' and SL3GROUPTAG.M_NGROUPLV=0' +  
                  ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                  ' ORDER BY sl3grouptag.M_SWPOSITION';
    end else
    begin
      strSQL := 'SELECT SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM, SL3VMETERTAG.m_swvmid, '+
                  ' L2TAG.M_SWMID, M_SFKI, M_SFKU, m_sname, SL3VMETERTAG.m_sbytype, l2tag.m_sbyPrecision ' +
                  ' from SL3VMETERTAG, L2TAG, QM_METERS,SL3GROUPTAG ' +
                  ' where l2tag.m_swmid=SL3VMETERTAG.m_swmid and QM_METERS.m_swtype=SL3VMETERTAG.m_sbytype'+
                  ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID and SL3GROUPTAG.m_sbyEnable=1'+
                  ' and SL3VMETERTAG.m_sbyType<>' + IntToStr(MET_VZLJOT)+
                  ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                  ' and SL3VMETERTAG.M_SMETERCODE=' + '''' + Code + '''' +
                  ' ORDER BY sl3grouptag.M_SWPOSITION';
    end;
    i := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     pTable.Count := nCount;
     SetLength(pTable.m_sMeter, nCount);
    // SetLength(MeterPrecision, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery,pTable.m_sMeter[i] do
       Begin
         m_sVMeterName            := FieldByName('m_svmetername').AsString;
         m_sddPHAddres            := FieldByName('M_SDDFABNUM').AsString;
         m_swVMID                 := FieldByName('m_swvmid').AsInteger;
         m_swMID                  := FieldByName('M_SWMID').AsInteger;
         m_sfKI                   := FieldByName('M_SFKI').AsFloat;
         m_sfKU                   := FieldByName('M_SFKU').AsFloat;
         m_sName                  := FieldByName('m_sname').AsString;
         m_sbyType                := FieldByName('m_sbytype').AsInteger;
         MeterPrecision[m_swVMID] := FieldByName('m_sbyPrecision').AsInteger;
         Inc(i);
         Next;
       End;
     end;
     MaxPrecision := FindMax(MeterPrecision, nCount);
     res := True;
    End;
    CloseQry;
    Result := res;
end;
function CDBDynamicConn.GetMeterGLVTableForReport(nAbon,GroupID,nLevel : integer;var pTable : SL2TAGREPORTLIST) : boolean;
Var
    nCount,i : Integer;
    res      : Boolean;
    strSQL   : String;
begin
    nCount := 0;
    res    := False;
    //SL3GROUPTAG WHERE m_swABOID
    if GroupID <> - 1 then
      strSQL := 'SELECT SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM,L2TAG.m_sbyLocation, SL3VMETERTAG.m_swvmid, '+
                ' L2TAG.M_SWMID, M_SFKI, M_SFKU, m_sname, SL3VMETERTAG.m_sbytype, l2Tag.m_sbyPrecision ' +
                ' from SL3VMETERTAG, L2TAG, QM_METERS,SL3GROUPTAG' +
                ' where l2tag.m_swmid=SL3VMETERTAG.m_swmid and QM_METERS.m_swtype=SL3VMETERTAG.m_sbytype' +
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID and SL3GROUPTAG.m_sbyEnable=1'+
                ' and SL3GROUPTAG.M_NGROUPLV=' + IntToStr(nLevel)+
                ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                ' and  SL3VMETERTAG.M_SBYGROUPID = ' + IntToStr(GroupID)+
                //' ORDER BY SL3VMETERTAG.m_swVMID'
                ' ORDER BY sl3grouptag.M_SWPOSITION'
    else
      strSQL := 'SELECT SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM,L2TAG.m_sbyLocation, SL3VMETERTAG.m_swvmid, '+
                ' L2TAG.M_SWMID, M_SFKI, M_SFKU, m_sname, SL3VMETERTAG.m_sbytype, l2tag.m_sbyPrecision ' +
                ' from SL3VMETERTAG, L2TAG, QM_METERS,SL3GROUPTAG ' +
                ' where l2tag.m_swmid=SL3VMETERTAG.m_swmid and QM_METERS.m_swtype=SL3VMETERTAG.m_sbytype'+
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID and SL3GROUPTAG.m_sbyEnable=1'+
                ' and SL3GROUPTAG.M_NGROUPLV=' + IntToStr(nLevel)+
                ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                ' ORDER BY sl3grouptag.M_SWPOSITION';
                //' ORDER BY SL3VMETERTAG.m_swVMID';
    i := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     pTable.Count := nCount;
     SetLength(pTable.m_sMeter, nCount);
    // SetLength(MeterPrecision, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery,pTable.m_sMeter[i] do
       Begin
         m_sVMeterName            := FieldByName('m_svmetername').AsString;
         m_sddPHAddres            := FieldByName('M_SDDFABNUM').AsString;
         m_swVMID                 := FieldByName('m_swvmid').AsInteger;
         m_swMID                  := FieldByName('M_SWMID').AsInteger;
         m_sfKI                   := FieldByName('M_SFKI').AsFloat;
         m_sfKU                   := FieldByName('M_SFKU').AsFloat;
         m_sName                  := FieldByName('m_sname').AsString;
         m_sbyType                := FieldByName('m_sbytype').AsInteger;
         m_sbyLocation            := FieldByName('m_sbyLocation').AsInteger;
         MeterPrecision[m_swVMID] := FieldByName('m_sbyPrecision').AsInteger;
         Inc(i);
         Next;
       End;
     end;
     MaxPrecision := FindMax(MeterPrecision, nCount);
     res := True;
    End;
    CloseQry;
    Result := res;
end;

function CDBDynamicConn.GetMeterGLVRashcet(nAbon : integer;var pTable : SL2TAGREPORTLIST) : boolean;
Var
    nCount,i : Integer;
    res      : Boolean;
    strSQL   : String;
begin
    nCount := 0;
    res    := False;
    if nAbon<>-1 then
      strSQL := 'SELECT distinct SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM,L2TAG.m_sbyLocation, SL3VMETERTAG.m_swvmid, '+
                ' L2TAG.M_SWMID, M_SFKI, M_SFKU, SL3ABON.m_sname, SL3ABON.M_SMAXPOWER, SL3VMETERTAG.M_SWPLID, SL3VMETERTAG.m_sbytype, l2tag.m_sbyPrecision ' +
                ' from SL3VMETERTAG, L2TAG, QM_METERS,SL3GROUPTAG,SL3ABON ' +
                ' where l2tag.m_swmid=SL3VMETERTAG.m_swmid and QM_METERS.m_swtype=SL3VMETERTAG.m_sbytype'+
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID and SL3GROUPTAG.m_sbyEnable=1'+
                ' and SL3GROUPTAG.m_swABOID=SL3ABON.m_swABOID'+
                ' and SL3VMETERTAG.M_SMETERCODE='+''''+'Raschet'+''''+
                ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                ' ORDER BY SL3ABON.m_swABOID'    else
      strSQL := 'SELECT distinct SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM,L2TAG.m_sbyLocation, SL3VMETERTAG.m_swvmid, '+
                ' L2TAG.M_SWMID, M_SFKI, M_SFKU, SL3ABON.m_sname,SL3ABON.m_sComment,SL3ABON.M_SMAXPOWER, M_SDOGNUM, SL3VMETERTAG.M_SWPLID, SL3VMETERTAG.m_sbytype, l2tag.m_sbyPrecision ' +
                ' from SL3VMETERTAG, L2TAG, QM_METERS,SL3GROUPTAG,SL3ABON ' +
                ' where l2tag.m_swmid=SL3VMETERTAG.m_swmid and QM_METERS.m_swtype=SL3VMETERTAG.m_sbytype'+
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID and SL3GROUPTAG.m_sbyEnable=1'+
                ' and SL3GROUPTAG.m_swABOID=SL3ABON.m_swABOID'+
                ' and SL3VMETERTAG.M_SMETERCODE='+''''+'Raschet'+''''+
                ' ORDER BY SL3ABON.m_swABOID';
    i := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     pTable.Count := nCount;
     SetLength(pTable.m_sMeter, nCount);
    // SetLength(MeterPrecision, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery,pTable.m_sMeter[i] do
       Begin
         m_sVMeterName            := FieldByName('m_svmetername').AsString; //VmidName
         m_sddPHAddres            := FieldByName('M_SDDFABNUM').AsString;
         m_swVMID                 := FieldByName('m_swvmid').AsInteger;     //Vmid
         m_swMID                  := FieldByName('M_SWMID').AsInteger;
         m_sfKI                   := FieldByName('M_SFKI').AsFloat;
         m_sfKU                   := FieldByName('M_SFKU').AsFloat;
         m_sName                  := FieldByName('m_sname').AsString;  //AboName
         M_SDOGNUM                := FieldByName('M_SDOGNUM').AsString;  //AboNameObject
         m_sbyType                := FieldByName('m_sbytype').AsInteger;
         m_sbyLocation            := FieldByName('m_sbyLocation').AsInteger;
         MeterPrecision[m_swVMID] := FieldByName('m_sbyPrecision').AsInteger;
         M_SMAXPOWER              := FieldByName('M_SMAXPOWER').AsFloat;   //DogPower
         M_SWPLID                 := FieldByName('M_SWPLID').AsInteger;   //Tarif
         m_sGroupName             := FieldByName('m_sComment').AsString;
         Inc(i);
         Next;
       End;
     end;
     MaxPrecision := FindMax(MeterPrecision, nCount);
     res := True;
    End;
    CloseQry;
    Result := res;
end;

function CDBDynamicConn.GetMeterForHomeBallReport(nAbon,GroupID,nLevel : integer;var pTable : SL2TAGREPORTLIST) : boolean;
Var
    nCount,i : Integer;
    res      : Boolean;
    strSQL   : String;
begin
    nCount := 0;
    res    := False;
    //SL3GROUPTAG WHERE m_swABOID
    if GroupID <> - 1 then
      strSQL := 'SELECT SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM,L2TAG.m_sbyLocation, SL3VMETERTAG.m_swvmid, '+
                ' L2TAG.M_SWMID,L2TAG.m_sddPHAddres, M_SFKI, M_SFKU, m_sname, SL3VMETERTAG.m_sbytype, l2Tag.m_sbyPrecision ' +
                ' from SL3VMETERTAG, L2TAG, QM_METERS,SL3GROUPTAG ' +
                ' where l2tag.m_swmid=SL3VMETERTAG.m_swmid and QM_METERS.m_swtype=SL3VMETERTAG.m_sbytype' +
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID and SL3GROUPTAG.m_sbyEnable=1'+
                ' and SL3GROUPTAG.M_NGROUPLV=' + IntToStr(nLevel)+
                ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                ' and  SL3VMETERTAG.M_SBYGROUPID = ' + IntToStr(GroupID)+
                //' ORDER BY SL3VMETERTAG.m_swVMID'
                ' ORDER BY L2TAG.m_swMID'
    else
      strSQL := 'SELECT SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM,L2TAG.m_sbyLocation, SL3VMETERTAG.m_swvmid, '+
                ' L2TAG.M_SWMID,L2TAG.m_sddPHAddres, M_SFKI, M_SFKU, m_sname, SL3VMETERTAG.m_sbytype, l2tag.m_sbyPrecision ' +
                ' from SL3VMETERTAG, L2TAG, QM_METERS,SL3GROUPTAG ' +
                ' where l2tag.m_swmid=SL3VMETERTAG.m_swmid and QM_METERS.m_swtype=SL3VMETERTAG.m_sbytype'+
                ' and SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID and SL3GROUPTAG.m_sbyEnable=1'+
                ' and SL3GROUPTAG.M_NGROUPLV=' + IntToStr(nLevel)+
                ' and SL3GROUPTAG.m_swABOID=' + IntToStr(nAbon)+
                //' ORDER BY sl3grouptag.M_SWPOSITION';
                ' ORDER BY SL3VMETERTAG.m_swMID';
    i := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     pTable.Count := nCount;
     SetLength(pTable.m_sMeter, nCount);
    // SetLength(MeterPrecision, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery,pTable.m_sMeter[i] do
       Begin
         m_sVMeterName            := FieldByName('m_svmetername').AsString;
         m_sddKVNum               := FieldByName('m_sddPHAddres').AsString;
         m_sddPHAddres            := FieldByName('M_SDDFABNUM').AsString;
         m_swVMID                 := FieldByName('m_swvmid').AsInteger;
         m_swMID                  := FieldByName('M_SWMID').AsInteger;
         m_sfKI                   := FieldByName('M_SFKI').AsFloat;
         m_sfKU                   := FieldByName('M_SFKU').AsFloat;
         m_sName                  := FieldByName('m_sname').AsString;
         m_sbyType                := FieldByName('m_sbytype').AsInteger;
         m_sbyLocation            := FieldByName('m_sbyLocation').AsInteger;
         //MeterPrecision[m_swVMID] := FieldByName('m_sbyPrecision').AsInteger;
         Inc(i);
         Next;
       End;
     end;
     //MaxPrecision := FindMax(MeterPrecision, nCount);
     res := True;
    End;
    CloseQry;
    Result := res;
end;

function CDBDynamicConn.UpdateTarifKoef(ID:integer; Koef:single):boolean;
var
   strSQL   : AnsiString;
begin
   strSQL := 'UPDATE TM_TARIFF SET ' +
             ' m_sfKoeff= ' + FloatToStr(Koef) +
             ' where m_swID = ' + IntToStr(ID);
   Result := ExecQry(strSQL);
end;

function CDBDynamicConn.GetTMTarPeriodsTableGr(GrInd, nIndex:Integer;var pTable:TM_TARIFFS):Integer;
var i      : Integer;
    strSQL : String;
    res    : Integer;
    nCount : Integer;
begin
   res := -1;
   if GrInd <> -1 then
   begin
      strSQL := 'select m_swPLID from SL3GROUPTAG where m_sbyGroupID=' + IntToStr(GrInd);
      if OpenQry(strSQL, nCount)=True then
      begin
        res    := FADOQuery.FieldByName('m_swPLID').AsInteger;
        nIndex := res*$1000000 + nIndex;
      end
      else
        res := 0;
      CloseQry;
   end;
    strSQL := 'SELECT * FROM TM_TARIFF WHERE m_swZoneID='+IntToStr(nIndex)+' ORDER BY m_swPTID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swPTID   := FieldByName('m_swPTID').AsInteger;
      m_swZoneID   := FieldByName('m_swZoneID').AsInteger;
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

function CDBDynamicConn.GetTMTarPeriodsTable(VMID, nIndex:Integer;var pTable:TM_TARIFFS):Integer;
Var
    i : Integer;
    strSQL   : String;
    res      : Integer;
    nCount   : Integer;
Begin
    res    := -1;
    if VMID <> -1 then
    begin
      strSQL := 'select M_SWPLID from SL3VMETERTAG where M_SWVMID=' + IntToStr(VMID);
      if OpenQry(strSQL,nCount)=True then
      begin
        res    := FADOQuery.FieldByName('m_swPLID').AsInteger;
        nIndex := res*$1000000 + nIndex;
      end
      else
        res := 0;
      CloseQry;
    end;
    strSQL := 'SELECT * FROM TM_TARIFF WHERE m_swZoneID='+IntToStr(nIndex)+' ORDER BY m_swPTID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;
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

function CDBDynamicConn.GetTMTarPeriodsCmdTable(dtDate:TDateTime;nVMID,nCMDID,nTSHift:Integer;var pTable:TM_TARIFFS):Integer;
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
    Result := nTPlane;
End;

function CDBDynamicConn.GetRealTMTarPeriodsCmdTable(dtDate:TDateTime;nVMID,nCMDID:Integer;var pTable:TM_TARIFFS):Boolean;
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
    if Assigned(FTZoneHand) then nZoneID := FTZoneHand(0,nTPlane,0,0,nTZone);

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
function CDBDynamicConn.GetRealTMTarPeriodsPlaneTable(dtDate:TDateTime;nVMID,nCMDID:Integer;var pTable:TM_TARIFFS):Integer;
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
function CDBDynamicConn.GetPlaneName(m_swPLID: integer): string;
Var
    strSQL   : String;
    nCount   : Integer;
begin
   Result := '';
   strSQL := 'SELECT m_sName FROM TM_PLANE WHERE m_swPLID=' + IntToStr(m_swPLID);
   if OpenQry(strSQL,nCount)=True then
     Result := FADOQuery.FieldByName('m_sName').AsString;
   CloseQry;
end;
//Dynamic Function CRC
function CDBDynamicConn.UpdateReReadMaskInArch(VMID : Integer; Date : TDateTime):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
begin
   strSQL := 'UPDATE L3ARCHDATA SET ' +
              'm_sMaskReRead=1' +
              ' WHERE m_swVMID='+ IntToStr(VMID) +
              ' and m_sdtDate=' + '''' + DateToStr(Date) + '''';
   Result := ExecQry(strSQL);
end;
function CDBDynamicConn.GetMeterType(FVMID:Integer;var nTypeID,swPLID:Integer):Boolean;
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
function CDBDynamicConn.GetGData(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
     //GetMeterType(FKey,nTypeID,swPLID);
     if TID = 0 then
       strSQL := 'SELECT m_swVMID,m_sTime,m_sfValue,m_swTID,m_sbyMaskRead,m_sbyMaskReRead'+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime'
     else if TID = -1 then
       strSQL := 'SELECT m_swVMID,m_sTime,m_sfValue,m_swTID,m_sbyMaskRead,m_sbyMaskReRead'+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 'm_swTID='+IntToStr(0)+ ' and ' +
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime'
     else
       strSQL := 'SELECT m_swVMID,m_sTime,m_sfValue,m_swTID,m_sbyMaskRead,m_sbyMaskReRead'+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 'm_swTID='+IntToStr(TID)+ ' and ' +
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID          := i;
      m_swVMID        := FieldByName('m_swVMID').AsInteger;
      m_swTID         := FieldByName('m_swTID').AsInteger;
      m_sTime         := FieldByName('m_sTime').AsDateTime;
      m_sfValue       := FieldByName('m_sfValue').AsFloat;
      m_sbyMaskRead   := FieldByName('m_sbyMaskRead').AsInteger;
      m_sbyMaskReRead := FieldByName('m_sbyMaskReRead').AsInteger;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetGDataTimeCRQ(x:Integer; var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
     if x = 0 then
       strSQL := 'SELECT FIRST 1 m_sTime FROM L3ARCHDATA ORDER BY m_sTime ASC'
     else
       strSQL := 'SELECT FIRST 1 m_sTime FROM L3ARCHDATA ORDER BY m_sTime DESC';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID          := i;
      m_sTime         := FieldByName('m_sTime').AsDateTime;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetEKOM3000GData(dtP0,dtP1:TDateTime;FKeyB,FKeyE,PKeyB,PKeyE:Integer;var pTable:CCDatasEkom):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
   strSQL := 'SELECT L3ARCHDATA.*, sl3vmetertag.m_sbyType FROM L3ARCHDATA, sl3vmetertag'+
             ' WHERE L3ARCHDATA.m_swVMID>='+IntToStr(FKeyB)+' and L3ARCHDATA.m_swVMID<='+IntToStr(FKeyE)+
             ' and m_swCMDID>='+IntToStr(PKeyB)+' and m_swCMDID<='+IntToStr(PKeyE)+
             ' and L3ARCHDATA.m_swVMID = sl3vmetertag.m_swVMID' +
             ' and m_swTID=0 and ' +
             ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID          := i;
      m_swVMID        := FieldByName('m_swVMID').AsInteger;
      m_swCMDID       := FieldByName('m_swCMDID').AsInteger;
      m_swTID         := FieldByName('m_swTID').AsInteger;
      m_sTime         := FieldByName('m_sTime').AsDateTime;
      m_sfValue       := FieldByName('m_sfValue').AsFloat;
      m_sbyMaskRead   := FieldByName('m_sbyMaskRead').AsInteger;
      m_sbyMaskReRead := FieldByName('m_sbyMaskReRead').AsInteger;
      m_sbyType       := FieldByName('m_sbyType').AsInteger;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    if (pTable.Count = 0) and (((PKeyB >= QRY_NAK_EN_DAY_EP) and (PKeyB <= QRY_NAK_EN_DAY_RM))) then
      res := FindNakEnInMonthDays(dtP0, dtP1, FKeyB, FKeyE, pKeyB, pKeyE, pTable);
    Result := res;
End;

function CDBDynamicConn.GetGDPData(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:CCDatas):Boolean;
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
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      m_sTime      := FieldByName('m_sTime').AsDateTime;
      m_sfValue    := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.UpdareReReadMaskInGr(BM : int64; VMID : Integer; Date : TDateTime):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
begin
   strSQL := 'UPDATE L2HALF_HOURLY_ENERGY SET ' +
              'm_sMaskReRead=' + IntToStr(BM) +
              ' WHERE m_swVMID='+ IntToStr(VMID) +
              ' and m_swCMDID='+IntToStr(QRY_SRES_ENR_EP) +
              ' and m_sdtDate=' + '''' + DateToStr(Date) + '''';
   Result := ExecQry(strSQL);
end;
function CDBDynamicConn.GetGraphDatas(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    str0,str1   : String;
Begin
     strSQL := 'SELECT *' +
     ' FROM L2HALF_HOURLY_ENERGY'+
     ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and'+
     ' CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sdtDate';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_swCMDID      := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      str0  := FADOQuery.FieldByName('M_SMASKREAD').AsString;
      str1  := FADOQuery.FieldByName('M_SMASKREREAD').AsString;
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
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetGraphDatas4(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    str0,str1   : String;
Begin
     strSQL := 'SELECT *' +
     ' FROM L2HALF_HOURLY_ENERGY'+
     ' WHERE m_swVMID='+IntToStr(FKey)+' and (m_swCMDID>='+IntToStr(PKey)+' and m_swCMDID<='+IntToStr(PKey+3)+')'+
     ' and CAST(m_sdtDate AS DATE) = '+ ''''+DateToStr(dtP0)+''''+' ORDER BY m_swCMDID,m_sdtDate';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_swCMDID      := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      str0  := FADOQuery.FieldByName('M_SMASKREAD').AsString;
      str1  := FADOQuery.FieldByName('M_SMASKREREAD').AsString;
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
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetOneSliceData(dtP:TDateTime;VMID,SLID:integer;var pTable:L3GRAPHDATAS):Boolean;
var i, nCount    : integer;
    strSQL, strV : AnsiString;
    tmpCMDID     : Integer;
begin
   pTable.Count := 4;
   if (SLID > 47) or (SLID < 0) then
     SLID := 0;
   SetLength(pTable.Items, 4);
   for i := 0 to 3 do
   begin
     pTable.Items[i].v[0]        := 0;
     pTable.Items[i].m_sMaskRead := 0;
   end;
   strSQL := 'select M_SMASKREAD,M_SWCMDID,v' + IntToStr(SLID) + ' as slice from L2HALF_HOURLY_ENERGY where m_swVMID=' + IntToStr(VMID) +
             ' and CAST(M_SDTDATE AS DATE) = ' + ''''+DateToStr(dtP)+'''' +
             ' and M_SWCMDID>=' + IntToStr(QRY_SRES_ENR_EP) + ' and M_SWCMDID<= ' + IntToStr(QRY_SRES_ENR_RM);
   if OpenQry(strSQL,nCount)=True then
   begin
     while not FADOQuery.Eof do
     begin
       with FADOQuery do
       begin
          tmpCMDID := FieldByName('M_SWCMDID').AsInteger - QRY_SRES_ENR_EP;
          pTable.Items[tmpCMDID].v[0] := FieldByName('slice').AsFloat;
          strV     := FieldByName('M_SMASKREAD').AsString;
          if (strV = '') then
            strV := '0';
          if IsBitInMask(StrToInt64(strV), SLID) then
            pTable.Items[tmpCMDID].m_sMaskRead := 1
          else
            pTable.Items[tmpCMDID].m_sMaskRead := 0;
          Next;
       end;
     end;
   end;
   CloseQry;
   Result := true;
end;
function CDBDynamicConn.GetGraphDatasABON(dtP0,dtP1:TDateTime;ABOID,CMDID:integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    str0,str1   : String;
Begin
     strSQL := 'select * from L2HALF_HOURLY_ENERGY where m_swVMID in ' +
               '(select m_swVMID from sl3vmetertag where M_SMETERCODE=' + '''' + 'Raschet' + '''' +  ' and M_SBYGROUPID in ' +
               '(select M_SBYGROUPID from sl3grouptag where M_SWABOID = ' + IntToStr(ABOID) + '))' +
               ' and CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+'''' +
               ' and m_swCMDID=' + IntToStr(CMDID);
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      //m_sdtLastTime  := FieldByName('m_sdtLastTime').AsDateTime;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      str0  := FADOQuery.FieldByName('m_sMaskRead').AsString;
      str1  := FADOQuery.FieldByName('m_sMaskReRead').AsString;
      if str0='' then str0 := '0';
      if str1='' then str1 := '0';
      m_sMaskRead   := StrToInt64(str0){ or m_sMaskRead};
      m_sMaskReRead := StrToInt64(str1) or m_sMaskReRead;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      for j:=0 to 47 do
         v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetGraphDatasABONAllEn(dtP0,dtP1:TDateTime;ABOID:integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    str0,str1   : String;
Begin
     strSQL := 'select * from L2HALF_HOURLY_ENERGY where m_swVMID in ' +
               '(select m_swVMID from sl3vmetertag where M_SMETERCODE=' + '''' + 'Raschet' + '''' +  ' and M_SBYGROUPID in ' +
               '(select M_SBYGROUPID from sl3grouptag where M_SWABOID = ' + IntToStr(ABOID) + '))' +
               ' and CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+'''';;
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      //m_sdtLastTime  := FieldByName('m_sdtLastTime').AsDateTime;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      str0  := FADOQuery.FieldByName('m_sMaskRead').AsString;
      str1  := FADOQuery.FieldByName('m_sMaskReRead').AsString;
      if str0='' then str0 := '0';
      if str1='' then str1 := '0';
      m_sMaskRead   := StrToInt64(str0){ or m_sMaskRead};
      m_sMaskReRead := StrToInt64(str1) or m_sMaskReRead;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      for j:=0 to 47 do
         v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetGraphDatasFromSomeVMIDs(dtP0,dtP1:TDateTime;var FKey,PKey :string;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    str0,str1   : String;
Begin
     strSQL := 'SELECT *' +
     ' FROM L2HALF_HOURLY_ENERGY'+
     ' WHERE m_swVMID in('+FKey+') and m_swCMDID in('+PKey+') and'+
     ' CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sdtDate';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      //m_sdtLastTime  := FieldByName('m_sdtLastTime').AsDateTime;
      m_swVMID := FieldByName('m_swVMID').AsInteger;
      m_swCMDID := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      str0  := FADOQuery.FieldByName('m_sMaskRead').AsString;
      str1  := FADOQuery.FieldByName('m_sMaskReRead').AsString;
      if str0='' then str0 := '0';
      if str1='' then str1 := '0';
      m_sMaskRead   := StrToInt64(str0){ or m_sMaskRead};
      m_sMaskReRead := StrToInt64(str1) or m_sMaskReRead;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      for j:=0 to 47 do
         v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetGraphDatasTimeCRQ(x:Integer; var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    str0,str1   : String;
Begin
    if x = 0 then
       strSQL := 'SELECT FIRST 1 m_sdtDate FROM L2HALF_HOURLY_ENERGY ORDER BY m_sdtDate ASC'
     else
       strSQL := 'SELECT FIRST 1 m_sdtDate FROM L2HALF_HOURLY_ENERGY ORDER BY m_sdtDate DESC';

    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetEKOM3000GraphDatas(dtP0,dtP1:TDateTime;FKeyB,FKeyE,PKeyB,PKeyE:Integer;var pTable:L3GRAPHDATASEKOM):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    str0,str1   : String;
Begin
     strSQL := 'SELECT L2HALF_HOURLY_ENERGY.*, sl3vmetertag.m_sbyType' +
     ' FROM L2HALF_HOURLY_ENERGY, sl3vmetertag'+
     ' WHERE L2HALF_HOURLY_ENERGY.m_swVMID>='+IntToStr(FKeyB)+ ' and L2HALF_HOURLY_ENERGY.m_swVMID<='+IntToStr(FKeyE) +
     ' and m_swCMDID>='+IntToStr(PKeyB)+
     ' and m_swCMDID<='+IntToStr(PKeyE)+
     ' and L2HALF_HOURLY_ENERGY.m_swVMID=sl3vmetertag.m_swVMID'+
     ' and CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sdtDate';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      //m_sdtLastTime  := FieldByName('m_sdtLastTime').AsDateTime;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_swCMDID      := FieldByName('m_swCMDID').AsInteger;
      str0  := FADOQuery.FieldByName('m_sMaskRead').AsString;
      str1  := FADOQuery.FieldByName('m_sMaskReRead').AsString;
      if str0='' then str0 := '0';
      if str1='' then str1 := '0';
      m_sMaskRead   := StrToInt64(str0) or m_sMaskRead;
      m_sMaskReRead := StrToInt64(str1) or m_sMaskReRead;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      for j:=0 to 47 do
         v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      m_sbyType := FieldByName('m_sbyType').AsInteger;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetCurrentData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    pTable.Count := 0;
    strSQL := 'SELECT *'+
    ' FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(FIndex)+
    ' and m_swCMDID='+IntToStr(FCmdIndex);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
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
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetAllCurrentData(FIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    pTable.Count := 0;
    strSQL := 'SELECT * FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(FIndex)+' ORDER BY m_swCMDID,m_swTID';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
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
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetCurrentDataInCCDatas(FIndex,FCmdIndex:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    pTable.Count := 0;
    strSQL := 'SELECT *'+
    ' FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(FIndex)+
    ' and m_swCMDID='+IntToStr(FCmdIndex);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
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
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetCurrentTimeData(FABO:Integer;var tTime:TDateTime):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
    pTable   : L3CURRENTDATAS;
Begin
    pTable.Count := 0;
    strSQL := 'SELECT max(m_sTime) as m_sTime'+
    ' FROM L3CURRENTDATA'+
    ' WHERE m_swCMDID=1 and m_swVMID IN '+
    ' (SELECT DISTINCT m_swVMID FROM SL3GROUPTAG,SL3VMETERTAG'+
    ' WHERE SL3GROUPTAG.m_sbyGroupID=SL3VMETERTAG.m_sbyGroupID'+
    ' and SL3GROUPTAG.m_swABOID='+IntToStr(FABO)+')';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID    := i;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      Next;
      Inc(i);
     End;
    End;
    End;
    if pTable.Count<>0 then
    tTime := pTable.Items[0].m_sTime;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetTariffData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    pTable.Count := 0;
    strSQL := 'SELECT *'+
    ' FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(FIndex)+
    ' and m_swCMDID='+IntToStr(FCmdIndex)+' and m_swTID<>0 ORDER BY m_swTID';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
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
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetTariffString(FIndex:Integer):String;
Var
    strSQL   : AnsiString;
    nCount,i : Integer;
begin
   Result := '';
   strSQL := 'select l2tag.M_STARIFFS from l2tag, sl3vmetertag where l2tag.m_swmid = sl3vmetertag.m_swmid ' +
             ' and sl3vmetertag.m_swvmid = ' + IntToStr(FIndex);
   if OpenQry(strSQL, nCOunt) = true then
     Result := FADOQuery.FieldByName('M_STARIFFS').AsString;
   CloseQry;
end;

function CDBDynamicConn.LoadTID(ParamID : word) : word;
var strSQL : AnsiString;
    nCount : integer;
begin
   Result := 0;
   strSQL := 'SELECT m_sblTarif FROM QM_PARAMS where m_swType = ' + IntToStr(ParamID);
   if OpenQry(strSQL, nCOunt) = true then
     Result := FADOQuery.FieldByName('m_sblTarif').AsInteger;
   CloseQry;
end;

function CDBDynamicConn.GetVMFromEnerg(var pTable : SL2TAGREPORTLIST) : boolean;
var strSQL    : AnsiString;
    nCount, i : integer;
    res       : boolean;
begin
   pTable.Count := 0;
   res    := false;
   strSQL := 'SELECT m_swVMID, m_sVMeterName FROM SL3VMETERTAG, SL3GROUPTAG' +
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

function CDBDynamicConn.GetArchTableForBTI(KanBeg, KanEnd, CMDID : Integer; dtP0, dtP1 : TDateTime; var pTable : CCDatas) : Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    pTable.Count := 0;
    strSQL := 'SELECT *'+
              ' FROM L3ARCHDATA'+
              ' WHERE m_swVMID>='+IntToStr(KanBeg div 4) + ' and m_swVMID<= ' + IntToStr(KanEnd div 4) +
              ' and m_swCMDID>='+IntToStr(CMDID)+' and m_swCMDID<='+IntToStr(CMDID + 4) +
              ' and CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      m_swVMID     := FieldByName('m_swVMID').AsInteger;
      m_swCMDID    := FieldByName('m_swCMDID').AsInteger;
      m_swTID      := FieldByName('m_swTID').AsInteger;
      m_sTime      := FieldByName('m_sTime').AsDateTime;
      m_sfValue    := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
end;
function CDBDynamicConn.GetArchTableForBTIPuls(KanBeg, KanEnd, CMDID : Integer; dtP0, dtP1 : TDateTime; var pTable : CCDatas) : Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    pTable.Count := 0;
    strSQL := 'SELECT *'+
              ' FROM L3ARCHDATA'+
              ' WHERE m_swVMID>='+IntToStr(KanBeg div 4) + ' and m_swVMID<= ' + IntToStr(KanEnd div 4) +
              ' and m_swCMDID>='+IntToStr(CMDID)+' and m_swCMDID<='+IntToStr(CMDID + 0) +
              ' and CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      m_swVMID     := FieldByName('m_swVMID').AsInteger;
      m_swCMDID    := FieldByName('m_swCMDID').AsInteger;
      m_swTID      := FieldByName('m_swTID').AsInteger;
      m_sTime      := FieldByName('m_sTime').AsDateTime;
      m_sfValue    := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
end;

function CDBDynamicConn.GetCurrTableForBTI(Um, NU, CMDID : Integer; var pTable : L3CURRENTDATAS) : Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
    sm       : byte;
Begin
     case CMDID of
       QRY_U_PARAM_S, QRY_I_PARAM_S, QRY_MGAKT_POW_S, QRY_MGREA_POW_S : sm := 3;
       QRY_KOEF_POW_A                                                 : sm := 2;
       QRY_FREQ_NET                                                   : sm := 0;
       QRY_E3MIN_POW_EP                                               : sm := 3;
       QRY_SUM_RASH_V,
       QRY_RASH_HOR_V,
       QRY_RASH_DAY_V,
       QRY_RASH_MON_V,
       QRY_RASH_AVE_V: sm := 4;
     end;
     strSQL := 'SELECT * FROM L3CURRENTDATA WHERE ' +
                ' m_swVMID >= ' + IntToStr(Um) + ' AND ' + ' m_swVMID <= ' + IntToStr(Um+NU) +
                ' and m_swCMDID >= ' + IntToStr(CMDID) + ' and m_swCMDID <= ' + IntToStr(CMDID + sm)+' ORDER BY m_swCMDID';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
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
    CloseQry;
    Result := res;
end;

function CDBDynamicConn.GetTariffTableForBTI(Um, NU : integer; var pTable:L3CURRENTDATAS):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT *'+
    ' FROM L3CURRENTDATA WHERE m_swVMID>='+IntToStr(Um)+ ' and m_swVMID<=' + IntToStr(Um + NU) +
    ' and m_swCMDID>='+IntToStr(QRY_ENERGY_SUM_EP)+ ' and m_swCMDID <= ' + IntToStr(QRY_ENERGY_SUM_RM) +
    ' and m_swTID<>0 ORDER BY m_swTID';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
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
    CloseQry;
    Result := res;
end;

function CDBDynamicConn.GetEventsTable(nIndex:Integer;var pTable:SEVENTSETTTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nIndex=-1 then  strSQL := 'SELECT * FROM SEVENTSETTTAGS ORDER BY m_swEventID';
    if nIndex<>-1 then strSQL := 'SELECT * FROM SEVENTSETTTAGS WHERE m_swGroupID='+IntToStr(nIndex)+' ORDER BY m_swEventID';
    pTable.Count := 0;
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

{function CDBDynamicConn.ReadJrnl(nIndex:Integer; Date : TDateTime; var pTable : SEVENTTAGS) : boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
begin
   pTable.Count := 0;
   strSQL := 'SELECT * FROM SEVENTTTAG WHERE M_SWGROUPID = ' + IntToStr(nIndex) +
             ' AND M_SDTEVENTTIME >= ' + '''' + DateTimeToStr(Date) + '''' +  ' ORDER BY M_SDTEVENTTIME';
   if OpenQry(strSQL,nCount)=True then
   begin
     i:=0;   res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery, pTable.Items[i] do
       begin
         m_swID         := FieldByName('m_swID').AsInteger;
         m_swVMID       := FieldByName('m_swVMID').AsInteger;
         m_swGroupID    := FieldByName('m_swGroupID').AsInteger;
         m_swEventID    := FieldByName('m_swEventID').AsInteger;
         m_sdtEventTime := FieldByName('m_sdtEventTime').AsDateTime;
         m_sUser        := FieldByName('m_sUser').AsString;
         m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
         m_swDescription    := FieldByName('m_swDescription').AsFloat;
         m_swAdvDescription := FieldByName('m_swAdvDescription').AsInteger;
         Next;
         Inc(i);
       end;
     end;
   end;
   CloseQry;
   Result := res;
end;  }

{function CDBDynamicConn.ReadJrnlEx(nIndex, VMID :Integer; dt1, dt2 : TDateTime; var pTable : SEVENTTAGS) : boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
begin
   pTable.Count := 0;
   if VMID = -1 then
     strSQL := 'SELECT * FROM SEVENTTTAG WHERE M_SWGROUPID = ' + IntToStr(nIndex) +
               ' AND M_SDTEVENTTIME >= ' + '''' + DateTimeToStr(dt1) + '''' +
               ' AND M_SDTEVENTTIME <= ' + '''' + DateTimeToStr(dt2) + '''' +
               ' ORDER BY M_SDTEVENTTIME'
   else
     strSQL := 'SELECT * FROM SEVENTTTAG WHERE M_SWGROUPID = ' + IntToStr(nIndex) +
               ' AND M_SWVMID = ' + IntToStr(VMID) + 
               ' AND M_SDTEVENTTIME >= ' + '''' + DateTimeToStr(dt1) + '''' +
               ' AND M_SDTEVENTTIME <= ' + '''' + DateTimeToStr(dt2) + '''' +
               ' ORDER BY M_SDTEVENTTIME';
   if OpenQry(strSQL,nCount)=True then
   begin
     i:=0;   res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery, pTable.Items[i] do
       begin
         m_swID             := FieldByName('m_swID').AsInteger;
         m_swVMID           := FieldByName('m_swVMID').AsInteger;
         m_swGroupID        := FieldByName('m_swGroupID').AsInteger;
         m_swEventID        := FieldByName('m_swEventID').AsInteger;
         m_sdtEventTime     := FieldByName('m_sdtEventTime').AsDateTime;
         Next;
         Inc(i);
       end;
     end;
   end;
   CloseQry;
   Result := res;
end;  }
{function CDBDynamicConn.ReadJrnlLastOneCRQ(nIndex: Integer; var pTable : SEVENTTAGS) : boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
begin
   pTable.Count := 0;
   strSQL := 'SELECT FIRST 1 m_sdtEventTime FROM SEVENTTTAG WHERE M_SWGROUPID = ' + IntToStr(nIndex) +
             ' ORDER BY M_SDTEVENTTIME';
   if OpenQry(strSQL,nCount)=True then
   begin
     i:=0;   res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery, pTable.Items[i] do
       begin
         m_sdtEventTime := FieldByName('m_sdtEventTime').AsDateTime;
         Next;
         Inc(i);
       end;
     end;
   end;
   CloseQry;
   Result := res;
end; }
{function CDBDynamicConn.ReadJrnlIdCRQ(nIndex, n1, n2:Integer; var pTable : SEVENTTAGS) : boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
begin
   pTable.Count := 0;
   strSQL := 'SELECT * FROM SEVENTTTAG WHERE M_SWGROUPID = ' + IntToStr(nIndex) +
             ' AND M_SWID >= ' + IntToStr(n1) +
             ' AND M_SWID <= ' + IntToStr(n2) +
             ' ORDER BY M_SDTEVENTTIME';
   if OpenQry(strSQL,nCount)=True then
   begin
     i:=0;   res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery, pTable.Items[i] do
       begin
         m_swID         := FieldByName('m_swID').AsInteger;
         m_swVMID       := FieldByName('m_swVMID').AsInteger;
         m_swGroupID    := FieldByName('m_swGroupID').AsInteger;
         m_swEventID    := FieldByName('m_swEventID').AsInteger;
         m_sdtEventTime := FieldByName('m_sdtEventTime').AsDateTime;
         m_sUser        := FieldByName('m_sUser').AsString;
         m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
         m_swDescription    := FieldByName('m_swDescription').AsFloat;
         m_swAdvDescription := FieldByName('m_swAdvDescription').AsInteger;
         Next;
         Inc(i);
       end;
     end;
   end;
   CloseQry;
   Result := res;
end;  }
{function CDBDynamicConn.ReadJrnlVM(nIndex, VM:Integer; Date : TDateTime; var pTable : SEVENTTAGS) : boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
begin
   pTable.Count := 0;
   strSQL := 'SELECT * FROM SEVENTTTAG WHERE M_SWGROUPID = ' + IntToStr(nIndex) +
             ' AND m_swVMID=' + IntToStr(VM) +
             ' AND M_SDTEVENTTIME >= ' + '''' + DateTimeToStr(Date) + '''' +  ' ORDER BY M_SDTEVENTTIME';
   if OpenQry(strSQL,nCount)=True then
   begin
     i:=0;   res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery, pTable.Items[i] do
       begin
         m_swID         := FieldByName('m_swID').AsInteger;
         m_swVMID       := FieldByName('m_swVMID').AsInteger;
         m_swGroupID    := FieldByName('m_swGroupID').AsInteger;
         m_swEventID    := FieldByName('m_swEventID').AsInteger;
         m_sdtEventTime := FieldByName('m_sdtEventTime').AsDateTime;
         m_sUser        := FieldByName('m_sUser').AsString;
         m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
         Next;
         Inc(i);
       end;
     end;
   end;
   CloseQry;
   Result := res;
end;   }
{function CDBDynamicConn.ReadJrnlLastCRQ(nIndex, VM:Integer; var pTable : SEVENTTAGS) : boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
begin
   pTable.Count := 0;
   strSQL := 'SELECT FIRST 1 * FROM SEVENTTTAG WHERE M_SWGROUPID = ' + IntToStr(nIndex) +
             ' AND m_swVMID=' + IntToStr(VM) +
             ' ORDER BY M_SDTEVENTTIME DESC';
   if OpenQry(strSQL,nCount)=True then
   begin
     i:=0;   res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery, pTable.Items[i] do
       begin
         m_swID         := FieldByName('m_swID').AsInteger;
         m_swVMID       := FieldByName('m_swVMID').AsInteger;
         m_swGroupID    := FieldByName('m_swGroupID').AsInteger;
         m_swEventID    := FieldByName('m_swEventID').AsInteger;
         m_sdtEventTime := FieldByName('m_sdtEventTime').AsDateTime;
         m_sUser        := FieldByName('m_sUser').AsString;
         m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
         Next;
         Inc(i);
       end;
     end;
   end;
   CloseQry;
   Result := res;
end;  }
{
STESTTAG = packed record
     m_swID         : Integer;
     m_swTSTID      : Integer;
     m_sdtTestTime  : TDateTIme;
     m_strComment   : String[50];
     m_strDescription : String[20];
     m_strResult    : String[10];
    end;
}
function CDBDynamicConn.GetTestTable(var pTable:STESTTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM STESTTAG ORDER BY m_swTSTID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swTSTID     := FieldByName('m_swTSTID').AsInteger;
      m_swObjID     := FieldByName('m_swObjID').AsInteger;
      m_sdtTestTime := FieldByName('m_sdtTestTime').AsDateTime;
      m_strComment  := FieldByName('m_strComment').AsString;
      m_strDescription := FieldByName('m_strDescription').AsString;
      m_strResult   := FieldByName('m_strResult').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetTestTypeTable(nTSTID:Integer;var pTable:STESTTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM STESTTAG WHERE m_swTSTID='+IntToStr(nTSTID)+' ORDER BY m_swObjID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swTSTID     := FieldByName('m_swTSTID').AsInteger;
      m_swObjID     := FieldByName('m_swObjID').AsInteger;
      m_sdtTestTime := FieldByName('m_sdtTestTime').AsDateTime;
      m_strComment  := FieldByName('m_strComment').AsString;
      m_strDescription := FieldByName('m_strDescription').AsString;
      m_strResult   := FieldByName('m_strResult').AsString;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.IsTest(var pTable:STESTTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM STESTTAG'+
              ' WHERE m_swTSTID=' +IntToStr(pTable.m_swTSTID)+
              ' and m_swObjID=' +IntToStr(pTable.m_swObjID);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.SetTestTable(var pTable:STESTTAG):Boolean;
Var
    strSQL : String;
BEgin
    with pTable do
    Begin
    strSQL := 'UPDATE STESTTAG SET '+
              ' m_sdtTestTime='+''''+DateTimeToStr(m_sdtTestTime)+''''+
              ',m_strComment='+''''+m_strComment+''''+
              ',m_strDescription='+''''+m_strDescription+''''+
              ',m_strResult='+''''+m_strResult+''''+
              ' WHERE m_swTSTID=' +IntToStr(m_swTSTID)+
              ' and m_swObjID=' +IntToStr(m_swObjID);
    End;
    Result := ExecQry(strSQL);
End;
function CDBDynamicConn.SaveTestRecord(wTSTID,wObjID:Integer;dtTestTime:TDateTime;strComment,strDescription,strResult:String):Boolean;
var
    pTable:STESTTAG;
Begin
    with pTable do
    Begin
     m_swTSTID      := wTSTID;
     m_swObjID      := wObjID;
     m_sdtTestTime  := dtTestTime;
     m_strComment   := strComment;
     m_strDescription := strDescription;
     m_strResult    := strResult;
    end;
    Result := AddTestTable(pTable);
End;
function CDBDynamicConn.AddTestTable(var pTable:STESTTAG):Boolean;
Var
    strSQL   : String;
Begin
    if IsTest(pTable)=True then Begin SetTestTable(pTable);Result:=False;exit;End;
    with pTable do
    Begin
    strSQL := 'INSERT INTO STESTTAG'+
              '(m_swTSTID,m_swObjID,m_sdtTestTime,m_strComment,m_strDescription,m_strResult)'+
              ' VALUES('+
              IntToStr(m_swTSTID)+ ','+
              IntToStr(m_swObjID)+ ','+
              ''''+DateTimeToStr(m_sdtTestTime)+''''+ ','+
              ''''+m_strComment+''''+ ','+
              ''''+m_strDescription+''''+ ','+
              ''''+m_strResult+''''+  ')';
    End;
    Result := ExecQry(strSQL);
End;
function CDBDynamicConn.DelTestTable(nIndex:Integer):Boolean;
Var
    strSQL : String;
Begin
    if nIndex<>-1 then
    strSQL := 'DELETE FROM STESTTAG WHERE m_swTSTID='+IntToStr(nIndex);
    if nIndex=-1 then
    strSQL := 'DELETE FROM STESTTAG';
    Result := ExecQry(strSQL);
End;
function CDBDynamicConn.GetL2Info(var pTable:SL3GETL2INFOS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT SL3VMETERTAG.m_swVMID,m_sfKI,m_sfKU FROM L2TAG,SL3VMETERTAG WHERE L2TAG.m_swMID=SL3VMETERTAG.m_swMID'+
    ' and L2TAG.m_sbyType<>8'+
    ' and L2TAG.m_sbyType<>9'+
    ' ORDER BY SL3VMETERTAG.m_swVMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_sfKI        := FieldByName('m_sfKI').AsFloat;
      m_sfKU        := FieldByName('m_sfKU').AsFloat;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
Type
  TAddrECOMToAddrBD = Record
    VM, T, CMD : integer;
  End;

Var
  AddrECOMToAddrBD  : Array[0..2{048}] Of TAddrECOMToAddrBD; // массив переадрессации адреса в ID

Function CDBDynamicConn.MakeSQLList(Um, NU, Tarifs : Integer) : AnsiString;
Var
  I                 : Integer;
Begin
  // заполнение массива для отладки
  If tarifs < 0 Then
    For I := 0 To 2048 Do Begin         // для графиков
      AddrECOMToAddrBD[I].VM := I Div 4; // номер счетчика
      AddrECOMToAddrBD[I].CMD := I Mod 4 + 13; // тип параметра
    End
  Else If tarifs = 0 Then               // текущие значения
    For I := 0 To 2048 Do Begin
      AddrECOMToAddrBD[I].VM := I Div (64 * 5); // номер счетчика
      AddrECOMToAddrBD[I].CMD := (I mod (64 * 5)) div 5 + 1; // тип параметра
      AddrECOMToAddrBD[I].T := I Mod 5; // тариф
    End
  Else
    For I := 0 To 2048 Do Begin         // для показаний на начало суток, месяца, года
      AddrECOMToAddrBD[I].VM := I Div (4 * 5); // номер счетчика
      AddrECOMToAddrBD[I].CMD := (I mod (4 * 5)) div 5 + 1 + tarifs * 4; // тип параметра
      AddrECOMToAddrBD[I].T := I mod 5;  // тариф
    End;
  Result := '(';
  For I := Um To Um + NU Do Begin
    Result := Result + '(m_swVMID = ' + IntToStr(AddrECOMToAddrBD[I].VM);
    If tarifs <> 0 Then
      Result := Result + ' and m_swTID = ' + IntToStr(AddrECOMToAddrBD[I].T);
    Result := Result + ' and m_swCMDID = ' + IntToStr(AddrECOMToAddrBD[I].CMD) + ')';
    If I < Um + NU Then Result := Result + ' or ';
  End;
  Result := result + ')';
End;
Function CDBDynamicConn.GetCurrTableForECOM(Um, NU, CMDID : Integer; Var pTable : L3CURRENTDATAS) : Boolean;
Var
  strSQL            : AnsiString;
  res               : Boolean;
  nCount, i         : Integer;
  sm                : byte;
Begin
//  Case CMDID Of
//    QRY_U_PARAM_S, QRY_I_PARAM_S, QRY_MGAKT_POW_S, QRY_MGREA_POW_S : sm := 3;
//    QRY_FREQ_NET : sm := 0;
//  End;
  pTable.Count := NU + 1;
  SetLength(pTable.Items, pTable.Count);
  For I := Um To Um + NU Do Begin
    pTable.Items[I - Um].m_swID := I;
    pTable.Items[I - Um].m_byInState := $80; //нет данных по каналу
    pTable.Items[I - Um].m_sfValue := 0;
  End;
  strSQL := 'SELECT * FROM L3CURRENTDATA WHERE ' + MakeSQLList(Um, NU, 0);
  Result := OpenQry(strSQL, nCount);
  If Result Then Begin
    While Not FADOQuery.EOF Do Begin
      For I := Um To Um + NU Do
        If (AddrECOMToAddrBD[i].VM = FADOQuery.FieldByName('m_swVMID').AsInteger) And
          (AddrECOMToAddrBD[i].T = FADOQuery.FieldByName('m_swTID').AsInteger) And
          (AddrECOMToAddrBD[i].CMD = FADOQuery.FieldByName('m_swCMDID').AsInteger) Then Begin
          If FADOQuery.FieldByName('m_ByInState').AsInteger = 0 Then
            pTable.Items[I - Um].m_byInState := $40
          Else
            pTable.Items[I - Um].m_byInState := $00;
          pTable.Items[i - Um].m_sfValue := FADOQuery.FieldByName('m_sfValue').AsFloat;
          pTable.Items[i - Um].m_sTime := FADOQuery.FieldByName('m_sTime').AsDateTime;
          Break;
        End;
      FADOQuery.Next;
    End;
  End;
  CloseQry;
End;
Function CDBDynamicConn.GetArchTableForECOM(KanBeg, KanEnd, CMDID : Integer; dtP0, dtP1 : TDateTime; Var pTable : CCDatas) : Boolean;
Var
  strSQL            : AnsiString;
  res               : Boolean;
  nCount, i, NU, Um, N : Integer;
Begin
  NU := KanEnd - KanBeg;
  Um := KanBeg;
  pTable.Count := NU + 1;
  SetLength(pTable.Items, pTable.Count);
  // инициализация данных
  For I := Um To Um + NU Do Begin
    pTable.Items[I - Um].m_swID := I;
    pTable.Items[I - Um].m_byInState := $80; // нет в конфигурации
    pTable.Items[I - Um].m_sfValue := 0;
    pTable.Items[I - Um].m_sTime := 0.0;
  End;
  strSQL := 'SELECT * FROM L3ARCHDATA WHERE (' + MakeSQLList(Um, NU + 1, CMDID) +
    ') and CAST(m_sTime AS DATE) BETWEEN ''' +
    DateToStr(dtP1) + ''' and ''' + DateToStr(dtP0) + ''' ORDER BY m_sTime';
  Result := OpenQry(strSQL, nCount);
  If Result Then Begin
    FADOQuery.Last;
    N := 0;
    While (Not FADOQuery.BOF) and (N < pTable.Count) Do Begin
      For I := Um To Um + NU Do
        If (AddrECOMToAddrBD[i].VM = FADOQuery.FieldByName('m_swVMID').AsInteger) And
          (AddrECOMToAddrBD[i].T = FADOQuery.FieldByName('m_swTID').AsInteger) And
          (AddrECOMToAddrBD[i].CMD = FADOQuery.FieldByName('m_swCMDID').AsInteger)
          and (pTable.Items[I].m_sTime = 0.0) Then
          Begin
           pTable.Items[i - Um].m_sfValue := FADOQuery.FieldByName('m_sfValue').AsFloat;
           pTable.Items[i - Um].m_sTime   := FADOQuery.FieldByName('m_sTime').AsDateTime;
          If FADOQuery.FieldByName('m_sbyMaskRead').AsInteger = 0 Then
            pTable.Items[I - Um].m_byInState := $40
          Else
            pTable.Items[I - Um].m_byInState := $00;
          if pTable.Items[i - Um].m_sTime > 0.0 then inc(N);
          Break;
        End;
      FADOQuery.Prior;
    End;
  End;
  CloseQry;
End;
Function CDBDynamicConn.GetGraphDatasECOM(dtP0, dtP1 : TDateTime; Um, NU : Integer; Var pTable : L3GRAPHDATAS) : Boolean;
Var
  strSQL, strV      : AnsiString;
  res               : Boolean;
  nCount, i, j, k   : Integer;
  str0, str1        : String;
Begin
  nCount := Trunc((Int(dtP1) - Int(dtP0))) + 1; // / (60000 * 30) * MSecsPerDay) + 1;
  pTable.Count := (NU + 1) * nCount;
  SetLength(pTable.Items, pTable.Count);
  For I := Um To (Um + NU) * nCount Do Begin
    pTable.Items[I - Um].m_swID := I;
    pTable.Items[I - Um].m_sMaskRead := $80; //нет данных по каналу
    pTable.Items[I - Um].m_swSumm := 0;
    pTable.Items[I - Um].m_sdtDate := 0.0;
    For J := 0 To 47 Do pTable.Items[I - Um].V[J] := 0;
  End;
  strSQL := 'SELECT * FROM L2HALF_HOURLY_ENERGY WHERE (' + MakeSQLList(Um, NU, -1) +
    ') and CAST(m_sdtDate AS DATE) BETWEEN ''' +
    DateToStr(dtP0) + ''' and ''' + DateToStr(dtP1) + ''' ORDER BY m_sdtDate';
  Result := OpenQry(strSQL, K);
  If Result Then Begin
    While Not FADOQuery.Eof Do Begin
      For I := Um To Um + NU Do Begin
        If (AddrECOMToAddrBD[i].VM = FADOQuery.FieldByName('m_swVMID').AsInteger) And
          (AddrECOMToAddrBD[i].CMD = FADOQuery.FieldByName('m_swCMDID').AsInteger) Then Begin
          pTable.Items[I].m_sdtDate := FADOQuery.FieldByName('m_sdtDate').AsDateTime;
          If FADOQuery.FieldByName('m_sbyMaskRead').AsInteger = 0 Then
            pTable.Items[I - Um].m_sMaskRead := $40
          Else
            pTable.Items[I - Um].m_sMaskRead := $00;
          For j := 0 To 47 Do
            pTable.Items[I - Um].v[j] := FADOQuery.FieldByName('v' + IntToStr(j)).AsFloat;
          Break;
        End;
      End;
      FADOQuery.Next;
    End;
  End;
  CloseQry;
End;

{Function CDBDynamicConn.ReadJrnlECOM(nIndex, IFrom, ITo : Integer; Date : TDateTime; Var pTable : SEVENTTAGS) : boolean;
Var
  strSQL            : String;
  res               : Boolean;
  I, nCount         : Integer;
Begin

  strSQL := 'SELECT * FROM SEVENTTTAG WHERE M_SWGROUPID = ' + IntToStr(nIndex) +
    ' AND M_SDTEVENTTIME <= ' + '''' + DateTimeToStr(Date) + '''' +
    ' ORDER BY M_SDTEVENTTIME';

  res := OpenQry(strSQL, nCount);

  nCount := 0;
  I := 0;

  If res Then Begin

    SetLength(pTable.Items, ITo - IFrom + 1);

    While (Not FADOQuery.Eof) And (I <= IFrom + ITo) Do Begin
      If (I >= IFrom) Then
        With FADOQuery, pTable.Items[nCount] Do Begin
          m_swEventID := FieldByName('m_swEventID').AsInteger;
          m_sdtEventTime := FieldByName('m_sdtEventTime').AsDateTime;
          Next;
          Inc(nCount);
        End;
      inc(I);
    End;

  End;

  pTable.Count := nCount;

  CloseQry;

End;  }

function CDBDynamicConn.ReadUSPDCharDevCFG(IsMSGOur :boolean;var pTable : SL2USPDCHARACTDEVLISTEX) : boolean;
var strSQL    : string;
    nCount, i : integer;
    res       : boolean;
begin
   res    := false;
   i      := 0;
   strSQL := 'SELECT sl3vmetertag.m_sbyType, sl3vmetertag.m_swVMID, sl3vmetertag.m_sddPHAddres,' +
             ' sl3vmetertag.m_svMeterName, l2tag.m_sfki, l2tag.m_sfku, l2tag.m_sddfabnum, l2tag.m_sbyPortID' +
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
         m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
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



function CDBDynamicConn.GetMetersAll(var pTable:SL2INITITAG):Boolean;
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
      m_sdtSumKor    := FieldByName('m_sdtSumKor').AsDateTime;
      m_sdtLimKor    := FieldByName('m_sdtLimKor').AsDateTime;
      m_sdtPhLimKor  := FieldByName('m_sdtPhLimKor').AsDateTime;
      m_sAdvDiscL2Tag:= FieldByName('m_sAdvDiscL2Tag').AsString;
      m_sbyStBlock   := FieldByName('m_sbyStBlock').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;

function CDBDynamicConn.GetParamsTypeTable(var pTable:QM_PARAMS):Boolean;
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

function CDBDynamicConn.GetL1Table(var pTable:SL1INITITAG):Boolean;
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

function CDBDynamicConn.GetAbonsTable(var pTable:SL3ABONS):Boolean;
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
function CDBDynamicConn.GetAbonTable(swABOID:Integer;var pTable:SL3ABONS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3ABON WHERE m_swABOID='+IntToStr(swABOID);
    pTable.Count := 0;
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
      m_sName     := FieldByName('m_sName').AsString;
//      m_sObject   := FieldByName('m_sObject').AsString;
      m_nRegionID := FieldByName('m_nRegionID').AsInteger;
//      m_sKSP      := FieldByName('m_sKSP').AsString;
//      m_sDogNum   := FieldByName('m_sDogNum').AsString;
//      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sAddress  := FieldByName('m_sAddress').AsString;
//      m_sEAddress := FieldByName('m_sEAddress').AsString;
//      m_sShemaPath:= FieldByName('m_sShemaPath').AsString;
//      m_sComment  := FieldByName('m_sComment').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyVisible:= FieldByName('m_sbyVisible').AsInteger;
//      m_sMaxPower := FieldByName('m_sMaxPower').AsFloat;
      Next;
      Inc(i);
      End;
      End;
     End;           
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetAbonTableS(swABOIDS:string;var pTable:SL3ABONS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM SL3ABON WHERE m_swABOID in '+swABOIDS;
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
//      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sAddress  := FieldByName('m_sAddress').AsString;
//      m_sEAddress := FieldByName('m_sEAddress').AsString;
//      m_sShemaPath:= FieldByName('m_sShemaPath').AsString;
//      m_sComment  := FieldByName('m_sComment').AsString;
      m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
      m_sbyVisible:= FieldByName('m_sbyVisible').AsInteger;
//      m_sMaxPower := FieldByName('m_sMaxPower').AsFloat;
      Next;
      Inc(i);
      End;
      End;
     End;           
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetMMeterTable(VMID:Integer;var pTable:SL2TAG):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    strSQL := 'SELECT L2TAG.m_sbyType, L2TAG.m_sddFabNum, L2TAG.m_sfKI, L2TAG.m_sfKU, L2TAG.m_sAdvDiscL2Tag ' +
     'FROM L2TAG, SL3VMETERTAG, QM_METERS WHERE SL3VMETERTAG.m_swMID=L2TAG.m_swMID ' +
     ' AND SL3VMETERTAG.M_SWVMID=' + IntToStr(VMID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do  Begin
      m_sddFabNum    := FieldByName('m_sddFabNum').AsString;
      m_sfKI         := FieldByName('m_sfKI').asFloat;
      m_sfKU         := FieldByName('m_sfKU').asFloat;
      m_sAdvDiscL2Tag:= FieldByName('m_sAdvDiscL2Tag').AsString;
     End;
     res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetGDPData_48(dtP0,dtP1:TDateTime;FKey,PKeyB,PKeyE:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL, ts  : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    sTime       : TDateTime;
Begin
    strSQL := 'SELECT *'+
              ' FROM L3PDTDATA_48'+
              ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID>='+IntToStr(PKeyB)+' and '+
              ' m_swCMDID<=' + IntToStr(PKeyE) + ' and ' +
              ' CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sdtDate';
    res          := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount*48;
    SetLength(pTable.Items,pTable.Count);
    while not FADOQuery.Eof do Begin
     with FADOQuery do  Begin
      j:=0;
      sTime := FieldByName('m_sdtDate').AsDateTime;
      if frac(sTime) > EncodeTime(0, 30, 0, 0) then
        sTime := trunc(sTime);
      for j:=0 to 47 do
      Begin
       pTable.Items[i*48+j].m_swVMID      := FieldByName('m_swVMID').AsInteger;
       pTable.Items[i*48+j].m_sfValue     := FieldByName('v'+IntToStr(j)).AsFloat;
       pTable.Items[i*48+j].m_sTime       := sTime + j*EncodeTime(0,30,0,0);
       pTable.Items[i*48+j].m_swCMDID     := FieldByName('m_swCMDID').AsInteger;
       ts                                 := FieldByName('m_sMaskRead').AsString;
       if ts = '' then ts := '0';
       pTable.Items[i*48+j].m_sbyMaskRead := StrToInt64(ts);
      End;
      Next;
      i:=i+1;
    End;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetGraphDatesPD48(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    str0,str1   : String;
Begin
     strSQL := 'SELECT m_sdtDate, M_SMASKREAD' +
     ' FROM L3PDTDATA_48'+
     ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
     ' CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sdtDate';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      str0  := FADOQuery.FieldByName('M_SMASKREAD').AsString;
      if str0='' then str0 := '0';
      m_sMaskReRead := StrToInt64(str0);
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
end;

{function CDBDynamicConn.IsFixEvent(var pTable:SEVENTTAG):Boolean;
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

{function CDBDynamicConn.AddFixEventTable(var pTable:SEVENTTAG):Boolean;
Var
    strSQL   : String;
Begin
    Result := False;
    if IsFixEvent(pTable)<>True then
      exit;
    with pTable do
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
    Result := ExecQry(strSQL);
End;  }

{function CDBDynamicConn.FixUspdEvent(PKey,Group,nEvent:Integer):Boolean;
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
     AddFixEventTable(pTable);
     Result := True;
    End else
    Result := True;                                                     
   end;
End;     }

{function CDBDynamicConn.UpdateKorrMonth(Delta: TDateTime):boolean;
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


function CDBDynamicConn.GetOneVector(_VectorDT : TDateTime; _VMID : WORD; var _Table : SL3VectorData): Boolean;
var
  l_hh, l_mm, l_ss, l_mss : WORD;
  l_HHID : BYTE;

   strSQL : AnsiString;
   nCount  : Integer;
   l_tValue : Double;
begin
  Result := false;

  DecodeTime(_VectorDT, l_hh, l_mm, l_ss, l_mss);
  l_HHID := l_hh*2 + (l_mm div 30);

   strSQL := ' SELECT DISTINCT ' +
             ' M_SWCMDID, V' +IntToStr(l_HHID)+
          ' FROM' +
             ' l3pdtdata_48' +
          ' WHERE' +
             ' m_swvmid=' + IntToStr(_VMID) +
             ' and' +
             ' M_SWCMDID IN(38,39,40,42,43,44,46,47,48,50,51,52,53,54,55,56)' +
             ' and' +
             ' CAST(m_sdtdate AS date)='''+DateToStr(trunc(_VectorDT))+'''' +
          ' order by m_sdtdate ASC, m_swcmdid asc;';
try
  if OpenQry(strSQL,nCount)=True then
  begin
    Result := True;
    _Table.DT    := _VectorDT;
    while (not FADOQuery.Eof) do
    begin
      l_tValue := FADOQuery.FieldByName('V'+IntToStr(l_HHID)).AsFloat;
      _Table.DataMask := _Table.DataMask or (1 shl (FADOQuery.FieldByName('M_SWCMDID').AsInteger-32));
      case FADOQuery.FieldByName('M_SWCMDID').AsInteger of
        QRY_U_PARAM_A:   _Table.UA    := l_tValue;
        QRY_U_PARAM_B:   _Table.UB    := l_tValue;
        QRY_U_PARAM_C:   _Table.UC    := l_tValue;
        QRY_I_PARAM_A:   _Table.IA    := l_tValue;
        QRY_I_PARAM_B:   _Table.IB    := l_tValue;
        QRY_I_PARAM_C:   _Table.IC    := l_tValue;
        QRY_FREQ_NET:    _Table.FREQ  := l_tValue;
        QRY_KOEF_POW_A:  _Table.COSFA := l_tValue;
        QRY_KOEF_POW_B:  _Table.COSFB := l_tValue;
        QRY_KOEF_POW_C:  _Table.COSFC := l_tValue;
        QRY_MGAKT_POW_A: _Table.PA := l_tValue;
        QRY_MGAKT_POW_B: _Table.PB := l_tValue;
        QRY_MGAKT_POW_C: _Table.PC := l_tValue;
        QRY_MGREA_POW_A: _Table.QA := l_tValue;
        QRY_MGREA_POW_B: _Table.QB := l_tValue;
        QRY_MGREA_POW_C: _Table.QC := l_tValue;
      end;
      FADOQuery.Next();
    end;
  end;
  CloseQry();
except
  CloseQry();
end;
end;
{**
 *  Получение 30минутных графиков и показаний на начало суток 4х типов энергии (A+, A-, R+, R-)
 *  Для отчета "Все графики за сутки"
 *  @param _Date      : TDateTime    Дата
 *  @param _VMID      : Integer      Виртуальный номер счетчика
 *  @param var pTable : L3GRAPHDATAS Массив 4х
 *}
function CDBDynamicConn.Get4EnergyGraphs(_Date : TDateTime;_VMID : Integer; var _pTable : L3GRAPHDATAS) : Boolean;
var
  l_QueryStr, l_ValidityStr : String;
  l_Count, j  : Integer;
  l_CMD : Integer;
begin
  Result := False;
    
  l_QueryStr := ' SELECT L2HALF_HOURLY_ENERGY.*,' +
     ' L3ARCHDATA.M_SFVALUE AS M_SFSTARTVALUE' +
     ' FROM L2HALF_HOURLY_ENERGY' +
     ' INNER JOIN L3ARCHDATA' +
     ' ON L3ARCHDATA.m_swvmid = L2HALF_HOURLY_ENERGY.m_swvmid' +
       ' AND L3ARCHDATA.m_swcmdid = (4+L2HALF_HOURLY_ENERGY.m_swCMDID)' +
       ' AND L3ARCHDATA.m_swtid = 0' +
       ' AND CAST(L3ARCHDATA.m_stime AS DATE)=CAST(L2HALF_HOURLY_ENERGY.m_sdtDate AS DATE)' +
     ' WHERE CAST(L2HALF_HOURLY_ENERGY.m_sdtDate AS DATE)=''' + FormatDateTime('yyyy-mm-dd', _Date) +'''' +
       ' AND L2HALF_HOURLY_ENERGY.m_swVMID=' + IntToStr(_VMID) +
       ' AND (L2HALF_HOURLY_ENERGY.m_swCMDID BETWEEN 13 AND 16)' +
       ' ORDER BY L2HALF_HOURLY_ENERGY.m_swCMDID';

  if OpenQry(l_QueryStr,l_Count) then
  begin
    Result := True;
    _pTable.Count := l_Count;
    SetLength(_pTable.Items, l_Count);

    while not FADOQuery.Eof do
      with FADOQuery do
      begin
        l_CMD := FieldByName('m_swCMDID').AsInteger - 13;

        _pTable.Items[l_CMD].m_swID        := l_CMD;
        _pTable.Items[l_CMD].m_sdtDate     := trunc(FieldByName('m_sdtDate').AsDateTime);
        _pTable.Items[l_CMD].m_swVMID      := FieldByName('m_swVMID').AsInteger;
        _pTable.Items[l_CMD].m_swCMDID     := FieldByName('m_swCMDID').AsInteger;
        _pTable.Items[l_CMD].m_sMaskRead   := StrToInt64Def(FADOQuery.FieldByName('m_sMaskRead').AsString, 0);
        _pTable.Items[l_CMD].m_sMaskReRead := StrToInt64Def(FADOQuery.FieldByName('m_sMaskReRead').AsString, 0);
        _pTable.Items[l_CMD].m_swSumm      := FieldByName('M_SFSTARTVALUE').AsFloat;
        for j:=0 to 47 do
          _pTable.Items[l_CMD].v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
        Next();
      End;
  End;
  CloseQry;
End;
{
function CDBDynamicConn.GetMonData(var pTable:SMONITORDATA):Boolean;
Var
    strSQL  : String;
    res     : Boolean;
    nCount  : Integer;
    mStream : TMemoryStream;
Begin
    res := False;
    strSQL := 'SELECT * FROM SMONITORDATA'+
    ' WHERE m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and (Date as DATE)='+''''+DateToStr(pTable.Date)+''''+
    ' and CmdID='+IntToStr(pTable.CmdID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     FADOQuery.Edit;
      pTable.Count  := FADOQuery.FieldByName('Count').AsInteger;
      pTable.Size   := FADOQuery.FieldByName('Size').AsInteger;
      pTable.Period := FADOQuery.FieldByName('Period').AsInteger;
      if TBlobField(FADOQuery.FieldByName('m_sData')).Isnull <> true then
      TBlobField(FADOQuery.FieldByName('m_sData')).SaveToStream(pTable.m_nData);
     FADOQuery.Post;
    End;
    CloseQry;
    Result :=res;
End;
}
function CDBDynamicConn.GetMonitorTable(nVMID,nCMDID:Integer;m_dtDate:TdateTime;var pTable:SMONITORDATAS):Boolean;
Var
     i : Integer;
     strSQL   : String;
     res      : Boolean;
     nCount   : Integer;
Begin
     res := False;
     if (nVMID=-1) and (nCMDID=-1) then
     strSQL := 'SELECT * FROM SMONITORDATA'+
     ' WHERE CAST(m_dtDate AS Date)='+''''+DateToStr(m_dtDate)+'''' else
     if (nVMID<>-1) and (nCMDID=-1) then
     strSQL := 'SELECT * FROM SMONITORDATA'+
     ' WHERE CAST(m_dtDate AS Date)='+''''+DateToStr(m_dtDate)+''''+
     ' and m_swVMID='+IntToStr(nVMID) else
     if (nVMID<>-1) and (nCMDID<>-1) then
     strSQL := 'SELECT * FROM SMONITORDATA'+
     ' WHERE CAST(m_dtDate AS Date)='+''''+DateToStr(m_dtDate)+''''+
     ' and CmdID='+IntToStr(nCMDID)+
     ' and m_swVMID='+IntToStr(nVMID);
     pTable.Count := 0;
     if OpenQry(strSQL,nCount)=True then
     Begin
      i:=0;res := True;
      pTable.Count := nCount;
      SetLength(pTable.Items,nCount);
      while not FADOQuery.Eof do Begin
      with FADOQuery,pTable.Items[i] do
      Begin
       m_nCount  := FADOQuery.FieldByName('m_nCount').AsInteger;
       m_nSize   := FADOQuery.FieldByName('m_nSize').AsInteger;
       m_nPeriod := FADOQuery.FieldByName('m_nPeriod').AsInteger;
       m_dtBegin := FADOQuery.FieldByName('m_dtBegin').AsDateTime;
       m_dtEnd   := FADOQuery.FieldByName('m_dtEnd').AsDateTime;
       m_dtDate  := FADOQuery.FieldByName('m_dtDate').AsDateTime;
       if TBlobField(FADOQuery.FieldByName('m_nData')).Isnull <> true then
       m_nData := TMemoryStream.Create;
       m_nData.Position := 0;
       TBlobField(FADOQuery.FieldByName('m_nData')).SaveToStream(m_nData);
       Next;
       Inc(i);
      End;
      End;
     End;
     CloseQry;
     Result := res;
End;
function CDBDynamicConn.IsMonitorTag(var pTable:SMONITORDATA):Boolean;
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
function CDBDynamicConn.SetMonTable(var pTable:SMONITORDATA):Boolean;
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
       FADOQuery.FieldByName('m_dtBegin').AsDateTime := pTable.m_dtBegin;
       FADOQuery.FieldByName('m_dtEnd').AsDateTime   := pTable.m_dtEnd;
       FADOQuery.FieldByName('m_nCount').AsInteger := pTable.m_nCount;
       FADOQuery.FieldByName('m_nSize').AsInteger    := pTable.m_nSize;
       FADOQuery.FieldByName('m_nPeriod').AsInteger  := pTable.m_nPeriod;
       TBlobField(FADOQuery.FieldByName('m_nData')).LoadFromStream(pTable.m_nData);
      FADOQuery.Post;
     End;
     CloseQry;
     Result :=res;
End;
{
    SMONITORDATA = packed record
     m_swID  : Integer;
     m_swVMID: Integer;
     Count   : Integer;
     Size    : Integer;
     Period  : Integer;
     CmdID   : Integer;
     m_dtDate    : TDateTime;
     m_nData : TMemoryStream;
     Items1  : array of MONTAG1;
     Items2  : array of MONTAG2;
    End;
}
function CDBDynamicConn.AddMonTable(var pTable:SMONITORDATA):Boolean;
Var
     strSQL   : String;
Begin
     if IsMonitorTag(pTable)=True then Begin SetMonTable(pTable);Result:=False;exit;End;
     with pTable do
     Begin
     strSQL := 'INSERT INTO SMONITORDATA'+
               '(m_swVMID,m_nCount,m_nSize,m_nPeriod,CmdID,m_dtDate,m_dtBegin,m_dtEnd,m_nData)'+
               ' VALUES('+
               IntToStr(m_swVMID)+  ','+
               IntToStr(m_nCount)+  ','+
               IntToStr(m_nSize)+  ','+
               IntToStr(m_nPeriod)+  ','+
               IntToStr(CmdID)+  ','+
               ''''+DateTimeToStr(m_dtDate)+''''+ ','+
               ''''+DateTimeToStr(m_dtBegin)+''''+ ','+
               ''''+DateTimeToStr(m_dtEnd)+''''+ ','+
               '0'+')';
      End;
      Result := ExecQry(strSQL);
      SetMonTable(pTable);
End;
function CDBDynamicConn.DelMonTable(nVMID,nCMDID:Integer;dtDate:TDateTime):Boolean;
Var
     strSQL : String;
Begin
     if (nVMID=-1) and (nCMDID=-1) then
     strSQL := 'DELETE FROM SMONITORDATA'+
     ' WHERE CAST(m_dtDate AS Date)='+''''+DateToStr(dtDate)+'''' else
     if (nVMID<>-1) and (nCMDID=-1) then
     strSQL := 'DELETE FROM SMONITORDATA'+
     ' WHERE CAST(m_dtDate AS Date)='+''''+DateToStr(dtDate)+''''+
     ' and m_swVMID='+IntToStr(nVMID) else
     if (nVMID<>-1) and (nCMDID<>-1) then
     strSQL := 'DELETE FROM SMONITORDATA'+
     ' WHERE CAST(m_dtDate AS Date)='+''''+DateToStr(dtDate)+''''+
     ' and CmdID='+IntToStr(nCMDID)+
     ' and m_swVMID='+IntToStr(nVMID);
     Result := ExecQry(strSQL);
End;

function CDBDynamicConn.GetSchemsTable(var pTable: SL3SCHEMTABLES ):boolean;
Var
    strSQL      : String;
    res         : Boolean;
    nCount, i   : Integer;
Begin
    strSQL := 'SELECT * FROM SL3SCHEMTABLE';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0; res   := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
      with FADOQuery,pTable.Items[i] do  Begin
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
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetCurrentDataForSchems(var CMDIDStr, VMIDStr : String;var pTable:L3CURRENTDATAS):Boolean;
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
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
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
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetFormulaForVMID(VMID : integer):string;
Var
    strSQL   : AnsiString;
    nCount   : Integer;
begin
    Result := '[x]';
    strSQL := 'select M_SGROUPEXPRESS from SL3GROUPTAG, sl3vmetertag where ' +
              ' SL3GROUPTAG.m_sbygroupid = sl3vmetertag.m_sbygroupid and ' +
              ' m_swVMID = ' + IntToStr(VMID);
    if OpenQry(strSQL,nCount)=True then
    Begin
      with FADOQuery do
        Result := FieldByName('M_SGROUPEXPRESS').AsString;
    End;
    CloseQry;
end;

function CDBDynamicConn.GetCurrLimitValue(VMID, CMDID, TID : integer):double;
var nCount    : integer;
    strSQL    : string;
begin
   Result := 0;
   strSQL := 'SELECT m_swMaxValue FROM SL3LIMITTAG WHERE m_swVMID = ' + IntToStr(VMID) +
             ' AND m_swCMDID = ' + IntToStr(CMDID) + ' AND m_swTID = ' + IntToStr(TID) +
             ' and ' + '''' + DateTimeToStr(Now) + '''' + '>=m_sDateBeg ' +
             ' and ' + ''''  + DateTimeToStr(Now) + '''' + '<=m_sDateEnd';
   if OpenQry(strSQL, nCount) then
   begin
     with FADOQuery do
       Result    := FieldByName('m_swMaxValue').AsFloat;
   end;
   CloseQry;
end;

function CDBDynamicConn.GetLimitDatas(VMID, CMDID : integer; var pTable: SL3LIMITTAGS):boolean;
var i, nCount : integer;
    strSQL    : string;
    res       : boolean;
begin
   res := false;
   strSQL := 'SELECT * FROM SL3LIMITTAG WHERE m_swVMID = ' + IntToStr(VMID) +
             ' AND m_swCMDID = ' + IntToStr(CMDID) + 
             ' and ' + '''' + DateTimeToStr(Now) + '''' + '>=m_sDateBeg ' +
             ' and ' + ''''  + DateTimeToStr(Now) + '''' + '<=m_sDateEnd';
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

function CDBDynamicConn.GetGraphDatasEnergo(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
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
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
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
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetArchDates(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
     strSQL := 'SELECT m_sTime,M_SBYMASKREAD'+
               ' FROM L3ARCHDATA'+
               ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and m_swTID=1 and '+
               ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID          := i;
      m_sTime         := FieldByName('m_sTime').AsDateTime;
      m_sbyMaskRead   := FieldByName('M_SBYMASKREAD').AsInteger;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
end;

function CDBDynamicConn.GetGraphDates(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
    str0,str1   : String;
Begin
     strSQL := 'SELECT m_sdtDate, m_sMaskRead, m_sMaskReRead' +
     ' FROM L2HALF_HOURLY_ENERGY'+
     ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
     ' CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sdtDate';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      str0  := FADOQuery.FieldByName('m_sMaskRead').AsString;
      str1  := FADOQuery.FieldByName('m_sMaskReRead').AsString;
      if str0='' then str0 := '0';
      if str1='' then str1 := '0';
      m_sMaskReRead := StrToInt64(str1) or m_sMaskReRead;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
end;
//CSaveSystem
function CDBDynamicConn.CurrentPrepare:Boolean;
Begin
    strBSQL := 'execute block as begin';
    m_nBLOs := m_nBLOs + 1;
    m_nQRYs := 0;
end;
function CDBDynamicConn.CurrentExecute:Boolean;
Var
    nLen : Integer;
Begin
    if strBSQL<>'' then
    if Pos('end;',strBSQL)=0 then
     strBSQL := strBSQL + 'end;';
    //if strBSQL<>'execute block as beginend;' then
    Begin
     nLen := Length(strBSQL);
     if nLen<>0 then
     Begin
      if m_nPauseCM=False then
      ExecQry(strBSQL);
      //if m_nPauseCM=True then WaitForSingleObject(w_mGEvent0,1000);
     End;
     strBSQL := '';
    End;
    m_nQRYs := 0;
End;
function CDBDynamicConn.CurrentFlush(swVMID:Integer):Boolean;
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
              ' or (m_swCMDID>=60 and m_swCMDID<=63) or (m_swCMDID>='+IntToStr(QRY_POD_TRYB_HEAT)+' and m_swCMDID<='+IntToStr(QRY_WORK_TIME_ERR)+'))) AS o'+
              ' ON (d.m_swVMID=o.m_swVMID AND d.m_swCMDID=o.m_swCMDID AND d.m_swTID=o.m_swTID'+
              ' AND CAST(d.m_sTime as Date)=CAST(o.m_sTime as Date))'+
              ' WHEN MATCHED THEN'+
              ' UPDATE SET d.m_sfValue=o.m_sfValue,d.m_CRC=o.m_CRC,d.m_sbyMaskRead=o.m_sbyMaskRead,d.m_sbyMaskReRead=o.m_sbyMaskReRead'+
              ' WHEN NOT MATCHED THEN'+
              ' INSERT (d.m_swVMID,d.m_swCMDID,d.m_crc,d.m_sTime,d.m_sfValue,d.m_swTID, d.m_sbyMaskRead, d.m_sbyMaskReRead)'+
              ' VALUES (o.m_swVMID,o.m_swCMDID,o.m_crc,CAST(o.m_sTime AS DATE),o.m_sfValue,o.m_swTID, o.m_sbyMaskRead, o.m_sbyMaskReRead)';
      Result := ExecQry(strSQL);
      strSQL := 'UPDATE L3CURRENTDATA set m_byInState=2 WHERE m_swVMID='+IntToStr(swVMID);
      if m_nPauseCM=False then
      Result := ExecQry(strSQL);
     End;
end;
function CDBDynamicConn.SetCurrentParam(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
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
    {
    with pTable do
    Begin
    strSQL  :='execute block as begin'+
              ' UPDATE L3CURRENTDATA SET '+
              ' m_sTime='+''''+DateTimeToStr(m_sTime)+''''+
              ',m_sfValue='+FloatToStr(m_sfValue)+
              ',m_byOutState='+IntToStr(m_byOutState)+
              ',m_CRC='+IntToStr(m_CRC)+
              ',m_byInState='+IntToStr(m_byInState)+
              ',M_SBYMASKREREAD='+IntToStr(m_sbyMaskReRead)+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+
              ' and m_swVMID='+IntToStr(m_swVMID)+
              ' and m_swTID='+IntToStr(m_swTID)+';'+
              ' UPDATE L3CURRENTDATA SET '+
              ' m_sTime='+''''+DateTimeToStr(m_sTime)+''''+
              ',m_sfValue='+FloatToStr(m_sfValue)+
              ',m_byOutState='+IntToStr(m_byOutState)+
              ',m_CRC='+IntToStr(m_CRC)+
              ',m_byInState='+IntToStr(m_byInState)+
              ',M_SBYMASKREREAD='+IntToStr(m_sbyMaskReRead)+
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+
              ' and m_swVMID='+IntToStr(m_swVMID)+
              ' and m_swTID='+IntToStr(m_swTID)+';'+
              ' end;'
    End;
    Result := ExecQry(strSQL);
    }
End;
function CDBDynamicConn.SetCurrentParamNoBlock(var pTable:L3CURRENTDATA):Boolean;
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
              GetSqlDecimal(m_sfValue){FloatToStr(m_sfValue)}+ ',' + IntToStr(pTable.m_swTID) + ',' +
              IntToStr(m_sbyMaskRead) + ',' + '0) matching (m_swVMID,m_swCMDID,m_swTID)';
    End;
    Result := ExecQry(strSQL);
End;
function CDBDynamicConn.AddPDTData_48(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL,strV,strD : AnsiString;
    i,nLen : Integer;
Begin
    if IsPDTData_48(pTable)=True then
    Begin
      UpdatePDTData_48(pTable);
      Result:=False;
      exit;
    End;
    for i:=0 to 47 do
    Begin
     if (abs(pTable.v[i])<0.000001) then pTable.v[i]:=0;
     strD := strD + ','+FloatToStr(pTable.v[i]);
    End;
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
    Result := ExecQry(strSQL);
End;
function CDBDynamicConn.UpdatePDTFilds_48(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL,strD,strV : AnsiString;
    i,nLen : Integer;
    pTab   : L3GRAPHDATA;
Begin
    pTab.m_swVMID      := pTable.m_swVMID;
    pTab.m_swCMDID     := pTable.m_swCMDID;
    pTab.m_sdtDate     := pTable.m_sTime;
    pTab.m_sMaskRead   := pTable.m_sMaskRead;
    pTab.m_sMaskReRead := pTable.m_sMaskReRead;
    if pTable.m_swSID>47 then exit;
    strD := 'v'+IntToStr(pTable.m_swSID);
    with pTab do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L3PDTDATA_48'+
              '(m_swVMID,m_swCMDID,m_sdtDate,m_sMaskRead,'+strD+')'+
              ' VALUES('+
              '(select m_swVMID from sl3vmetertag where m_swMID='+IntToStr(m_swVMID)+')' + ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(trunc(m_sdtDate))+''''+','+
              ''''+IntToStr(m_sMaskRead)+''''+','+
               GetSqlDecimal(pTable.m_sfValue){FloatToStr(pTable.m_sfValue)}+ ')'+
              ' matching (m_swVMID,m_swCMDID,m_sdtDate)' ;
    End;
    Result := ExecQry(strSQL);
End;

function CDBDynamicConn.SetCurrentParamNoBlock_8086(fub_num : string; id_object : integer; var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L3CURRENTDATA'+
              '(m_swVMID,m_swCMDID,m_sTime,m_sfValue,m_swTID, m_sbyMaskRead, m_sbyMaskReRead)'+
              ' VALUES('+
              '(select m_swVMID from sl3vmetertag where m_swMID='+'(select m_swMID from l2tag where m_sddfabnum=' +
              fub_num +  ' and m_swaboid=' + IntToStr(id_object) + '))' + ',' +
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              GetSqlDecimal(pTable.m_sfValue)+{FloatToStr(m_sfValue)+ }',' + IntToStr(pTable.m_swTID) + ',' +
              IntToStr(m_sbyMaskRead) + ',' + '0) matching (m_swVMID,m_swCMDID,m_swTID)';
    End;
    Result := ExecQry(strSQL);
End;

function CDBDynamicConn.UpdatePDTFilds_48_8086(fub_num : string; id_object : integer; var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL,strD,strV : AnsiString;
    i,nLen : Integer;
    pTab   : L3GRAPHDATA;
Begin
    pTab.m_swVMID      := pTable.m_swVMID;
    pTab.m_swCMDID     := pTable.m_swCMDID;
    pTab.m_sdtDate     := pTable.m_sTime;
    pTab.m_sMaskRead   := pTable.m_sMaskRead;
    pTab.m_sMaskReRead := pTable.m_sMaskReRead;
    if pTable.m_swSID>47 then exit;
    strD := 'v'+IntToStr(pTable.m_swSID);
    with pTab do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L3PDTDATA_48'+
              '(m_swVMID,m_swCMDID,m_sdtDate,m_sMaskRead,'+strD+')'+
              ' VALUES('+
              '(select m_swVMID from sl3vmetertag where m_swMID='+'(select m_swMID from l2tag where m_sddfabnum=' +
              fub_num +  ' and m_swaboid=' + IntToStr(id_object) + ')))' + ',' +
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(trunc(m_sdtDate))+''''+','+
              ''''+IntToStr(m_sMaskRead)+''''+','+
              GetSqlDecimal(pTable.m_sfValue)+')'+// FloatToStr(pTable.m_sfValue)+')'+
              ' matching (m_swVMID,m_swCMDID,m_sdtDate)' ;
    End;
    Result := ExecQry(strSQL);
End;

function CDBDynamicConn.UpdatePDTData_48(var pTable:L3GRAPHDATA):Boolean;
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
    Result := ExecQry(strSQL);
End;
function CDBDynamicConn.IsPDTData_48(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM L3PDTDATA_48 WHERE'+
    ' m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and m_swCMDID='+IntToStr(pTable.m_swCMDID)+
    ' and CAST(m_sdtDate as DATE)='+''''+DateToStr(pTable.m_sdtDate)+'''';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.AddGraphData(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL,strV,strD : AnsiString;
    i,nLen : Integer;
Begin
    {if IsGraphData(pTable)=True then
    Begin
      UpdateGraphData(pTable);
      Result:=False;
      exit;
    End;}

    pTable.m_sdtDate := trunc(pTable.m_sdtDate);
    for i:=0 to 47 do
    Begin
     if (abs(pTable.v[i])<0.000001) then pTable.v[i]:=0;
     strD := strD + ','+FloatToStr(pTable.v[i]);
    End;
    for i:=0 to 47 do strV := strV + ',v'+IntToStr(i);
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L2HALF_HOURLY_ENERGY'+
              '(m_swVMID,m_swCMDID,m_swSumm,m_sdtLastTime,m_sdtDate,m_sMaskReRead,m_sMaskRead'+strV+',M_CRC)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              FloatToStr(m_swSumm)+ ','+
              ''''+DateTimeToStr(m_sdtLastTime)+''''+ ','+
              ''''+DateTimeToStr(m_sdtDate)+''''+','+
              ''''+IntToStr(m_sMaskReRead)+''''+','+
              ''''+IntToStr(m_sMaskRead)+''''+strD+','+
              IntToStr(M_CRC)+') matching (m_swVMID,m_swCMDID,m_sdtDate)' ;
              //IntToStr(M_CRC)+')' ;
    End;
    //TraceL(4,0,'(__)CLDBD::>CVPRM INS LEN : '+IntToStr(Length(strSQL)));
    Result := ExecQry(strSQL);
End;
function CDBDynamicConn.UpdateGraphData(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL,strD : AnsiString;
    i,nLen : Integer;
Begin
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
    Result := ExecQry(strSQL);
End;
function CDBDynamicConn.UpdateGD48(var pTable:L3CURRENTDATA):Boolean;
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
    pTab.m_sMaskRead   := pTable.m_sMaskRead;
    pTab.m_sMaskReRead := pTable.m_sMaskReRead;
    if pTable.m_swSID>47 then exit;
    strD := 'v'+IntToStr(pTable.m_swSID);
    with pTab do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L2HALF_HOURLY_ENERGY'+
              '(m_swVMID,m_swCMDID,m_sdtDate,m_sMaskReRead,m_sMaskRead,'+strD+')'+
              ' VALUES('+
              '(select m_swVMID from sl3vmetertag where m_swMID='+IntToStr(m_swVMID)+')' + ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(trunc(m_sdtDate))+''''+','+
              ''''+IntToStr(m_sMaskReRead)+''''+','+
              ''''+IntToStr(m_sMaskRead)+''''+','+
              GetSqlDecimal(pTable.m_sfValue)+')'+ //FloatToStr(pTable.m_sfValue)+')'+
              ' matching (m_swVMID,m_swCMDID,m_sdtDate)' ;
    End;
    Result := ExecQry(strSQL);
End;

function CDBDynamicConn.UpdateGD48_8086(fub_num : string; id_object : integer; var pTable:L3CURRENTDATA):Boolean;
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
    pTab.m_sMaskRead   := pTable.m_sMaskRead;
    pTab.m_sMaskReRead := pTable.m_sMaskReRead;
    if pTable.m_swSID>47 then exit;
    strD := 'v'+IntToStr(pTable.m_swSID);
    with pTab do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L2HALF_HOURLY_ENERGY'+
              '(m_swVMID,m_swCMDID,m_sdtDate,m_sMaskReRead,m_sMaskRead,'+strD+')'+
              ' VALUES('+
              '(select m_swVMID from sl3vmetertag where m_swMID='+'(select m_swMID from l2tag where m_sddfabnum=' +
              fub_num +  ' and m_swaboid=' + IntToStr(id_object) + ')))' + ',' +
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(trunc(m_sdtDate))+''''+','+
              ''''+IntToStr(m_sMaskReRead)+''''+','+
              ''''+IntToStr(m_sMaskRead)+''''+','+
              GetSqlDecimal(pTable.m_sfValue)+')'+ //FloatToStr(pTable.m_sfValue)+')'+
              ' matching (m_swVMID,m_swCMDID,m_sdtDate)' ;
    End;
    Result := ExecQry(strSQL);
End;
function CDBDynamicConn.IsGraphData(var pTable:L3GRAPHDATA):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    strSQL := 'SELECT 0 FROM L2HALF_HOURLY_ENERGY WHERE'+
    ' m_swVMID='+IntToStr(pTable.m_swVMID)+
    ' and m_swCMDID='+IntToStr(pTable.m_swCMDID)+
    ' and CAST(m_sdtDate as DATE)='+''''+DateToStr(pTable.m_sdtDate)+'''';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     res := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.AddArchData(var pTable:L3CURRENTDATA):Boolean;
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
              IntToStr(m_sbyMaskRead) + ',' + '0); ';
    End;
    if m_nQRYs=MAX_BLOCK_QRY then
     CurrentExecute else
    m_nQRYs := m_nQRYs + 1;
    Result := True;
End;

{
 if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      str0  := FADOQuery.FieldByName('m_sMaskRead').AsString;
      str1  := FADOQuery.FieldByName('m_sMaskReRead').AsString;
      if str0='' then str0 := '0';
      if str1='' then str1 := '0';
      m_sMaskReRead := StrToInt64(str1) or m_sMaskReRead;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
}
function CDBDynamicConn.getArchParam(var pTable:L3CURRENTDATA):Double;
Var
    strSQL : String;
    value  : Double;
    nCount : Integer;
Begin
    strSQL := 'select s0.m_sfValue from L3ARCHDATA as s0,sl3vmetertag as s1'+
              ' where s0.m_swCMDID='+IntToStr(pTable.m_swCMDID)+
              ' and s0.m_swVMID=s1.m_swVMID'+
              ' and s1.m_swMID='+IntToStr(pTable.m_swVMID)+
              ' and s0.m_sTime='+''''+DateToStr(pTable.m_sTime)+''''+
              ' and s0.m_swTID='+IntToStr(pTable.m_swTID);
    value := 1000000000;
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FADOQuery.Eof do Begin
       value := FADOQuery.FieldByName('m_sfValue').AsFloat;
       FADOQuery.Next;
     End;
    End;
    CloseQry;
    Result := value;
End;
function CDBDynamicConn.AddArchDataNoBlock(var pTable:L3CURRENTDATA):Boolean;
Var
   // outfile: TextFile;
    strSQL : String;
Begin
    with pTable do
    Begin
    DecimalSeparator:='.';
    strSQL := 'UPDATE OR INSERT INTO L3ARCHDATA'+
              '(m_swVMID,m_swCMDID,m_sTime,m_sfValue,m_swTID, m_sbyMaskRead, m_sbyMaskReRead)'+
              ' VALUES('+
              '(select m_swVMID from sl3vmetertag where m_swMID='+IntToStr(m_swVMID)+')' + ','+
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              GetSqlDecimal(m_sfValue){FloatToStr(m_sfValue)}+ ',' + IntToStr(pTable.m_swTID) + ',' +
              IntToStr(m_sbyMaskRead) + ',' + '0) matching (m_swVMID,m_swCMDID,m_swTID,m_sTime)';
   // SQL_LOG:=strSQL;
    End;
    Result := ExecQry(strSQL);
End;

function CDBDynamicConn.AddArchDataNoBlock_8086(fub_num : string; id_object : integer; var pTable:L3CURRENTDATA{;var SQL_LOG:String}):Boolean;
Var
    strSQL : String;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L3ARCHDATA'+
              '(m_swVMID,m_swCMDID,m_sTime,m_sfValue,m_swTID, m_sbyMaskRead, m_sbyMaskReRead)'+
              ' VALUES('+
              '(select m_swVMID from sl3vmetertag where m_swMID='+ '(select m_swMID from l2tag where m_sddfabnum=' +
              ''''+fub_num+'''' +  ' and m_swaboid=' + IntToStr(id_object) + '))' + ',' +    { TODO 1 : РАЗОБРАТЬСЯ ПОЧЕМУ НЕ РАБОТАЕТ ЗАПРОС С ПАРАМЕТРОМ STRING }
              IntToStr(m_swCMDID)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              GetSqlDecimal(m_sfValue){FloatToStr(m_sfValue)}+ ',' + IntToStr(pTable.m_swTID) + ',' +
              IntToStr(m_sbyMaskRead) + ',' + '0) matching (m_swVMID,m_swCMDID,m_swTID,m_sTime)';
    End;
    //    //select m_swVMID from sl3vmetertag where m_swMID=(select m_swMID from l2tag where M_SDDFABNUM='733813' and m_swaboid=2865)
    Result := ExecQry(strSQL);
End;

function CDBDynamicConn.AddArchDataNoBlockByt(var pTable:L3CURRENTDATA;var strSQL_DB : String):Boolean;
Var
   // outfile: TextFile;
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
              GetSqlDecimal(m_sfValue){FloatToStr(m_sfValue)}+ ',' + IntToStr(pTable.m_swTID) + ',' +
              IntToStr(m_sbyMaskRead) + ',' + '0) matching (m_swVMID,m_swCMDID,m_swTID,m_sTime)';
    End;
  //  strSQL_DB:= strSQL;
//    Result := ExecQry(strSQL);
    Result := true;
End;


function CDBDynamicConn.UpdateArchData(var pTable:L3CURRENTDATA):Boolean;
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
              ' AND CAST(m_sTime as Date)='+''''+DateToStr(m_sTime)+''''+'; ';
    End;
    if m_nQRYs=MAX_BLOCK_QRY then CurrentExecute else
    m_nQRYs := m_nQRYs + 1;
    Result := True;
    //Result := ExecQryD1(strSQL);
end;

function CDBDynamicConn.UpdateArchDataNoBlock(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
begin
    with pTable do
    Begin
    strSQL := ' UPDATE L3ARCHDATA SET '+
              'm_sfValue=' + FloatToStr(m_sfValue) + ',' +
              'm_CRC=' + IntToStr(m_CRC) + ',' +
              'm_sbyMaskRead=' + IntToStr(m_sbyMaskRead) +
              ' WHERE m_swCMDID=' +IntToStr(m_swCMDID)+' and m_swVMID='+IntToStr(m_swVMID) +
              ' and m_swTID=' + IntToStr(pTable.m_swTID) +
              ' AND CAST(m_sTime as Date)='+''''+DateToStr(m_sTime)+'''';
    End;
    Result := ExecQry(strSQL);
end;

function CDBDynamicConn.IsArchData(var pTable:L3CURRENTDATA):Boolean;
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
    if OpenQry(strSQL,nCount)=True then
    Begin
     res   := True;
    End;
    CloseQry;
    Result := res;
end;

function CDBDynamicConn.GetParamTableForGroup(GrID : integer; var pTable:SL3PARAMSS; var pNames : SL3ARRAYOFSTRING):Boolean;
Var
    strSQL      : String;
    res         : Boolean;
    nCount, i   : Integer;
Begin
    strSQL := 'select SL3PARAMS.m_swid, SL3PARAMS.m_swvmid, SL3PARAMS.m_sparamexpress, SL3PARAMS.m_swparamid, sl3vmetertag.M_SVMETERNAME ' +
              ' from sl3params,  sl3vmetertag ' +
              ' where sl3params.m_swVMID in (select m_swVMID from sl3vmetertag where sl3vmetertag.m_sbygroupid =' + IntToStr(GrID) + ')' +
              ' and sl3params.m_swParamID = ' + IntToStr(QRY_SRES_ENR_EP) +
              ' and sl3params.m_swVMID = sl3vmetertag.m_swvmid';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
      i := 0;
      res := True;
      pTable.Count := nCount;
      SetLength(pTable.Items,nCount);
      SetLength(pNames.Items,nCount);
      while not FADOQuery.Eof do
      Begin
        with FADOQuery,pTable.Items[i] do
        Begin
          m_swID          := FieldByName('m_swID').AsInteger;
          m_swVMID        := FieldByName('m_swVMID').AsInteger;
          m_swParamID     := FieldByName('m_swParamID').AsInteger;
          m_sParamExpress := FieldByName('m_sParamExpress').AsString;
          pNames.Items[i].m_nString := FieldByName('m_sVMeterName').AsString;
          Next;
          Inc(i);
        End;
      End;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetAdditInfoForMTZTex(VMIDs : string; var pTable:SL3TECHMTZREPORTSDATAS):Boolean;
Var
    strSQL    : String;
    res       : Boolean;
    nCount, i : Integer;
Begin
    strSQL := 'select l2tag.m_schname as m_nFiderName, l2tag.m_sfku, l1tag.m_schname as m_nKPName, sl3vmetertag.m_swVMID, l2tag.m_sTpNum ' +
              'from sl3vmetertag, l2tag, l1tag ' +
              'where sl3vmetertag.m_swmid = l2tag.m_swmid ' +
              ' and sl3vmetertag.m_swvmid in (' + VMIDs + ' )' +
              ' and l1tag.m_sbyportid = l2tag.m_sbyportid';
    res := False;
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
      i := 0;
      res := True;
      pTable.Count := nCount;
      SetLength(pTable.Items,nCount);
      while not FADOQuery.Eof do
      Begin
        with FADOQuery,pTable.Items[i] do
        Begin
          m_nVMID          := FieldByName('m_swVMID').AsInteger;
          m_nKPName        := FieldByName('m_nKPName').AsString;
          m_nKTransform    := FieldByName('m_sfku').AsFloat;
          m_nFiderName     := FieldByName('m_nFiderName').AsString;
          m_sTpNum         := FieldByName('m_sTpNum').AsString;
          Inc(i);
          Next;
        End;
      End;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetVMsTableABON(ABOID:Integer;var pTable:SL3VMETERTAGS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'select * from sl3vmetertag where m_sbyGroupID in (select M_SBYGROUPID from sl3grouptag where m_swABOID =' +
              IntToStr(ABOID) + ')';
    pTable.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count   := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
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

function CDBDynamicConn.GetL2MtrsABON(ABOID:Integer;var pTable:SL2INITITAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if pTable.m_sbyLayerID=0 then
    strSQL := 'select * from l2tag where m_swMID in (select m_swMID from sl3vmetertag where m_sbyGroupID in ' +
              ' (select M_SBYGROUPID from sl3grouptag where m_swABOID = ' + IntToStr(ABOID) + '))' else
    if pTable.m_sbyLayerID=1 then
    strSQL := 'select * from l2tag where (not(m_sbyType=8 or m_sbyType=9)) and m_swMID in (select m_swMID from sl3vmetertag where m_sbyGroupID in ' +
              ' (select M_SBYGROUPID from sl3grouptag where m_swABOID = ' + IntToStr(ABOID) + '))';
    if pTable.m_sbyLayerID=2 then
    strSQL := 'select l2tag.*,sl3vmetertag.m_swVMID as VMD from l2tag,sl3vmetertag,sl3grouptag'+
              ' where (not(l2tag.m_sbyType=8 or l2tag.m_sbyType=9))'+
              ' and l2tag.m_swMID=sl3vmetertag.m_swMID'+
              ' and sl3grouptag.m_sbyGroupID=sl3vmetertag.m_sbyGroupID'+
              ' and sl3grouptag.m_swABOID = ' + IntToStr(ABOID);

    pTable.m_swAmMeter := 0;
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
      m_swVMID       := 0;
      if pTable.m_sbyLayerID=2 then
      m_swVMID       := FieldByName('VMD').AsInteger;
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
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
end;

function CDBDynamicConn.GetTransformatorInfo(VMID : integer; var pTable:SL2TAG):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    strSQL := 'select distinct l2tag.* from l2tag, sl3vmetertag where l2tag.m_swmid = sl3vmetertag.m_swmid and sl3vmetertag.m_swvmid = ' + IntToStr(VMID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do  Begin
      m_sfKI         := FieldByName('m_sfKI').AsFloat;
      m_sfKU         := FieldByName('m_sfKU').AsFloat;
      m_sAktEnLose   := FieldByName('m_sAktEnLose').AsFloat;
      m_sReaEnLose   := FieldByName('m_sReaEnLose').AsFloat;
      m_sTranAktRes  := FieldByName('m_sTranAktRes').AsFloat;
      m_sTranReaRes  := FieldByName('m_sTranReaRes').AsFloat;
      m_sGrKoeff     := FieldByName('m_sGrKoeff').AsInteger;
      m_sTranVolt    := FieldByName('m_sTranVolt').AsInteger;
     End;
     res := True;
    End;
    CloseQry;
    Result := res;
End;
{
 SL3ExportMOGB = packed record
     m_nABOID    : Integer;
     m_nVMID     : Integer;
     m_nCMDID    : Integer;
     m_dtDate    : TDateTime;
     m_byREGID   : Byte;
     m_wDEPID    : Word;
     m_strLicNb  : String;
     m_nGorSel   : Byte;
     m_nRES      : Byte;
     m_nCS       : Byte;
     m_strLicNbAbo : String;
     m_strFabNum : String;
     m_strFIO    : String;
     m_strAddr   : String;
     m_dbDataT1  : Double;
     m_dbDataT2  : Double;
     m_dbDataT3  : Double;
     m_dbDataT4  : Double;
   End;
   QRY_ENERGY_SUM_EP     = 1;//1
  QRY_ENERGY_SUM_EM     = 2;
  QRY_ENERGY_SUM_RP     = 3;
  QRY_ENERGY_SUM_RM     = 4;
}

function aGetm_strAddr(M_SBYTYPE : integer; M_SDDHADR_HOUSE, M_SDDHADR_KV, townName, streetName, domName, TPNAME, am_strKvNb : string):string;
var    m_strAddr : string;
begin
{  if (M_SBYTYPE = 49) then begin
    if (M_SDDHADR_HOUSE = '') and (M_SDDHADR_KV = '') then
      m_strAddr := 'г. ' + townName + ',' + ' ул. ' + streetName + ',' + ' ' + domName + ',' + ' кв. '+am_strKvNb
    else if (M_SDDHADR_HOUSE <> '') and( M_SDDHADR_KV = '') then
      m_strAddr := 'г. ' + townName + ',' + ' ' + TPNAME + ',' + ' '+M_SDDHADR_HOUSE
    else if (M_SDDHADR_HOUSE <> '') and (M_SDDHADR_KV <> '') then
      m_strAddr := 'г. '+ townName + ',' + ' ' + TPNAME + ',' + ' ' + M_SDDHADR_HOUSE + ',' + ' кв. ' + M_SDDHADR_KV;
  end
  else if (M_SBYTYPE = 50) then begin
    if (M_SDDHADR_HOUSE = '') and (M_SDDHADR_KV = '') then
      m_strAddr := 'г. ' + townName + ',' + ' ул. ' + streetName + ',' + ' ' + domName + ',' + ' кв. '+am_strKvNb
    else if (M_SDDHADR_HOUSE <> '') and (M_SDDHADR_KV = '') then
      m_strAddr     := 'г. ' + townName + ',' + ' ' + TPNAME + ',' + ' '+M_SDDHADR_HOUSE
    else if (M_SDDHADR_HOUSE <> '') and (M_SDDHADR_KV <> '') then
      m_strAddr := 'г. ' + townName + ',' + ' ' + TPNAME + ',' + ' '+M_SDDHADR_HOUSE + ',' + ' кв. '+M_SDDHADR_KV;
  end
  else if (M_SBYTYPE = 27) then begin
    if (M_SDDHADR_HOUSE = '') and (M_SDDHADR_KV = '') then
      m_strAddr := 'г. ' + townName + ',' + ' ул. ' + streetName + ',' + ' ' + domName + ',' + ' кв. '+am_strKvNb
    else if (M_SDDHADR_HOUSE <> '') and (M_SDDHADR_KV <> '') then
      m_strAddr     := 'г. ' + townName + ',' + M_SDDHADR_HOUSE + ',' + ' кв. '+M_SDDHADR_KV
    else if (M_SDDHADR_HOUSE <> '') and (M_SDDHADR_KV = '') then
      m_strAddr     := 'г. ' + townName + ',' + ' ' + TPNAME + ',' + ' '+M_SDDHADR_HOUSE;
  end
  else begin}
    if (M_SDDHADR_HOUSE = '') and (M_SDDHADR_KV = '') then
      m_strAddr := 'г. ' + townName + ',' + ' ул. ' + streetName + ',' + ' ' + domName + ',' + ' кв. '+am_strKvNb
    else if (M_SDDHADR_HOUSE <> '') and (M_SDDHADR_KV <> '') then
      m_strAddr := 'г. ' + townName + ',' + M_SDDHADR_HOUSE + ',' + ' кв. ' + M_SDDHADR_KV
    else if (M_SDDHADR_HOUSE <> '') and (M_SDDHADR_KV = '') then
      m_strAddr     := 'г. ' + townName + ',' + ' ' + TPNAME + ',' + ' '+M_SDDHADR_HOUSE;
    //end;
  Result := m_strAddr;
end;


function CDBDynamicConn.GetMogBitData(nABOID:Integer;de:TDateTime;var pTable:SL3ExportMOGBS):Boolean;     // ********** BO
Var
    i,j : Integer;
    strSQL   : String;     //s2.M_SMETERCODE - город село
    res      : Boolean;    //s2.M_STPNUM     - Код Лицензии
    nCount,swTid : Integer;    //s2.M_SVMETERNAME- Фио
    pLabel   : SL3ABONLB;
    strAddr  : String;
    nTypeAbo : Integer;
    ki       : Double;
    pts      : longint;
const
  maxCountOfTar = 5;
  maxNumOfTar = maxCountOfTar - 1;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT s3.m_swtid,s2.m_swMID,s0.m_swVMID,s0.M_SMETERCODE,s0.M_SVMETERNAME, '+
              ' s2.M_STPNUM,s2.M_SDDFABNUM,s2.M_SDDPHADDRES,s3.m_sfvalue,s3.M_STIME, '+
              ' s6.code, '+
              ' s4.M_SNAME as domName, s6.M_SNAME as depName,s7.M_SNAME as townName,s8.M_SNAME as streetName, '+
              ' s2.M_SBYLOCATION,s2.M_SFKI,s2.M_SBYTYPE,s2.M_SDDHADR_HOUSE,s2.M_SDDHADR_KV,s9.NAME as TPNAME,s4.M_SKORPUSNUMBER KORPUSNUMBER,s4.M_SHOUSENUMBER HOUSENUMBER '+
              ' FROM SL3VMETERTAG as s0,SL3GROUPTAG as s1,L2TAG as s2,L3ARCHDATA as s3, '+
              ' SL3ABON as s4, '+
              ' sl3region as s5, '+
              ' sl3departament as s6, '+
              ' sl3town as s7, '+
              ' sl3street as s8, '+
              ' sl3TP as s9 '+
              ' WHERE s0.m_sbyGroupID=s1.m_sbyGroupID '+
              ' and cast(s3.M_STIME as date)='+''''+DateToStr(de)+''''+
              ' and s0.m_swVMID=s3.m_swVMID'+
              ' and s3.m_swtid BETWEEN 0 and '+ IntToStr(maxNumOfTar)+//' and (s3.m_swtid>=1) and (s3.m_swtid<=3)'+
              ' and s3.m_swcmdid='+IntToStr(QRY_NAK_EN_MONTH_EP)+
              ' and s1.m_swABOID=s4.m_swABOID'+
              ' and s2.m_swMID=s0.m_swMID'+
              ' and s0.m_sbyEnable=1'+              
              ' and s1.m_sbyEnable=1'+
              ' and s1.m_swABOID='+IntToStr(nABOID)+
              ' and s4.M_NREGIONID=s5.M_NREGIONID'+
              ' and s4.M_SWDEPID=s6.M_SWDEPID'+
              ' and s4.M_SWTOWNID=s7.M_SWTOWNID'+
              ' and s4.M_SWSTREETID=s8.M_SWSTREETID and s4.TPID=s9.ID'+
              ' and s2.M_STPNUM<>'''''+
              ' ORDER BY s0.m_swVMID,s3.m_swtid';
//    pTable.Count   := 1;
//    SetLength(pTable.Items, 1);
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;j:=0;res := True;
     {pTable.Count   := trunc(nCount/3);
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin}

{     pTable.Count   := ceil(nCount/maxCountOfTar);     ************** BO 5/11/18
     SetLength(pTable.Items,pTable.Count); }

     pTable.Count   := 1;                // ************** BO 5/11/18
     SetLength(pTable.Items,1);

     //pTable.Items[i].m_swtid
     pts:=FADOQuery.FieldByName('m_swMID').AsInteger;

     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_strTYPE     := FieldByName('M_SBYTYPE').AsString;
      m_nABOID      := nABOID;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_nCMDID      := QRY_ENERGY_SUM_EP;
      m_dtDate      := FieldByName('M_STIME').AsDateTime;
      m_byREGID     := 4;
      m_strLicNb    := FieldByName('M_STPNUM').AsString;
      //m_nGorSel     := FieldByName('M_SMETERCODE').AsString;
      m_wDEPID      := FieldByName('code').AsInteger;
      m_nGorSel     := '0';
      m_nRES        := 0;
      m_strFabNum   := FieldByName('M_SDDFABNUM').AsString;
      m_strFIO      := FieldByName('M_SVMETERNAME').AsString;
      m_strKvNb     := FieldByName('M_SDDPHADDRES').AsString;
      swTid         := FieldByName('m_swtid').AsInteger;

      m_strAddr := aGetm_strAddr(FieldByName('M_SBYTYPE').AsInteger, FieldByName('M_SDDHADR_HOUSE').AsString,
                                             FieldByName('M_SDDHADR_KV').AsString, FieldByName('townName').AsString,
                                             FieldByName('streetName').AsString, FieldByName('domName').AsString,
                                             FieldByName('TPNAME').AsString, m_strKvNb);
      m_strTown := FieldByName('townName').AsString;
      m_strStreet := FieldByName('streetName').AsString;
      m_strHouse := FieldByName('HOUSENUMBER').AsString;
      m_strKorpus := FieldByName('KORPUSNUMBER').AsString;

      nTypeAbo      := FieldByName('M_SBYLOCATION').AsInteger;
      ki            := FieldByName('M_SFKI').AsFloat;
      KFTR          := FieldByName('M_SFKI').AsInteger;
      m_swtid       := FieldByName('m_swtid').AsInteger;
      if ki > 0 then begin
      if (swTid=0) then m_dbDataT0 := FieldByName('m_sfvalue').AsFloat;///ki;
      if (swTid=1) then m_dbDataT1 := FieldByName('m_sfvalue').AsFloat;///ki;
      if (swTid=2) then m_dbDataT2 := FieldByName('m_sfvalue').AsFloat;///ki;
      if (swTid=3) then m_dbDataT3 := FieldByName('m_sfvalue').AsFloat;///ki;
      if (swTid=4) then m_dbDataT4 := FieldByName('m_sfvalue').AsFloat;///ki;
       end else begin
        if (swTid=0) then m_dbDataT0 := FieldByName('m_sfvalue').AsFloat;
        if (swTid=1) then m_dbDataT1 := FieldByName('m_sfvalue').AsFloat;
        if (swTid=2) then m_dbDataT2 := FieldByName('m_sfvalue').AsFloat;
        if (swTid=3) then m_dbDataT3 := FieldByName('m_sfvalue').AsFloat;
        if (swTid=4) then m_dbDataT4 := FieldByName('m_sfvalue').AsFloat;
       end;
      Next;

      if pts <> FADOQuery.FieldByName('m_swMID').AsInteger then begin
        pts := FADOQuery.FieldByName('m_swMID').AsInteger;
        Inc(i);
        inc(pTable.Count);           // ************** BO 5/11/18
        SetLength(pTable.Items,i+1);
      end;

   {   Inc(j);
      //if(j=3) then
      if(j=maxCountOfTar) then
      Begin
       j := 0;
       Inc(i);
      End; }
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetMogBitDataMySql(nABOID:Integer;de:TDateTime;var pTable:SL3ExportMOGBS):Boolean;     // ********** BO
Var
    i,j : Integer;
    strSQL   : String;     //s2.M_SMETERCODE - город село
    res      : Boolean;    //s2.M_STPNUM     - Код Лицензии
    nCount,swTid : Integer;    //s2.M_SVMETERNAME- Фио
    pLabel   : SL3ABONLB;
    strAddr  : String;
    nTypeAbo : Integer;
    ki       : Double;
    pts      : longint;
const
  maxCountOfTar = 5;
  maxNumOfTar = maxCountOfTar - 1;
Begin
    res := False;
    strSQL := 'SELECT DISTINCT s3.m_swtid,s2.m_swMID,s0.m_swVMID,s0.M_SMETERCODE,s0.M_SVMETERNAME, '+
              ' s2.M_STPNUM,s2.M_SDDFABNUM,s2.M_SDDPHADDRES,s3.m_sfvalue,s3.M_STIME, '+
              ' s6.code, '+
              ' s4.M_SNAME as domName, s6.M_SNAME as depName,s7.M_SNAME as townName,s8.M_SNAME as streetName, '+
              ' s2.M_SBYLOCATION,s2.M_SFKI,s2.M_SBYTYPE,s2.M_SDDHADR_HOUSE,s2.M_SDDHADR_KV,s9.NAME as TPNAME,s4.M_SKORPUSNUMBER KORPUSNUMBER,s4.M_SHOUSENUMBER HOUSENUMBER '+
              ' FROM SL3VMETERTAG as s0,SL3GROUPTAG as s1,L2TAG as s2,L3ARCHDATA as s3, '+
              ' SL3ABON as s4, '+
              ' sl3region as s5, '+
              ' sl3departament as s6, '+
              ' sl3town as s7, '+
              ' sl3street as s8, '+
              ' sl3TP as s9 '+
              ' WHERE s0.m_sbyGroupID=s1.m_sbyGroupID '+
              ' and cast(s3.M_STIME as date)='+''''+DateToStr(de)+''''+
              ' and s0.m_swVMID=s3.m_swVMID'+
              ' and s3.m_swtid BETWEEN 0 and '+ IntToStr(maxNumOfTar)+//' and (s3.m_swtid>=1) and (s3.m_swtid<=3)'+
              ' and s3.m_swcmdid='+IntToStr(QRY_NAK_EN_MONTH_EP)+
              ' and s1.m_swABOID=s4.m_swABOID'+
              ' and s2.m_swMID=s0.m_swMID'+
              ' and s0.m_sbyEnable=1'+              
              ' and s1.m_sbyEnable=1'+
              ' and s1.m_swABOID='+IntToStr(nABOID)+
              ' and s4.M_NREGIONID=s5.M_NREGIONID'+
              ' and s4.M_SWDEPID=s6.M_SWDEPID'+
              ' and s4.M_SWTOWNID=s7.M_SWTOWNID'+
              ' and s4.M_SWSTREETID=s8.M_SWSTREETID and s4.TPID=s9.ID'+
              ' and s2.M_STPNUM<>'''''+
              ' and s2.M_SDDFABNUM<>'''''+
              ' ORDER BY s0.m_swVMID,s3.m_swtid';
//    pTable.Count   := 1;
//    SetLength(pTable.Items, 1);
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;j:=0;res := True;
     {pTable.Count   := trunc(nCount/3);
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin}

{     pTable.Count   := ceil(nCount/maxCountOfTar);     ************** BO 5/11/18
     SetLength(pTable.Items,pTable.Count); }

     pTable.Count   := 1;                // ************** BO 5/11/18
     SetLength(pTable.Items,1);

     //pTable.Items[i].m_swtid
     pts:=FADOQuery.FieldByName('m_swMID').AsInteger;

     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_strTYPE     := FieldByName('M_SBYTYPE').AsString;
      m_nABOID      := nABOID;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_nCMDID      := QRY_ENERGY_SUM_EP;
      m_dtDate      := FieldByName('M_STIME').AsDateTime;
      m_byREGID     := 4;
      m_strLicNb    := FieldByName('M_STPNUM').AsString;
      //m_nGorSel     := FieldByName('M_SMETERCODE').AsString;
      m_wDEPID      := FieldByName('code').AsInteger;
      m_nGorSel     := '0';
      m_nRES        := 0;
      m_strFabNum   := FieldByName('M_SDDFABNUM').AsString;
      m_strFIO      := FieldByName('M_SVMETERNAME').AsString;
      m_strKvNb     := FieldByName('M_SDDPHADDRES').AsString;
      swTid         := FieldByName('m_swtid').AsInteger;

      m_strAddr := aGetm_strAddr(FieldByName('M_SBYTYPE').AsInteger, FieldByName('M_SDDHADR_HOUSE').AsString,
                                             FieldByName('M_SDDHADR_KV').AsString, FieldByName('townName').AsString,
                                             FieldByName('streetName').AsString, FieldByName('domName').AsString,
                                             FieldByName('TPNAME').AsString, m_strKvNb);
      m_strTown := FieldByName('townName').AsString;
      m_strStreet := FieldByName('streetName').AsString;
      m_strHouse := FieldByName('HOUSENUMBER').AsString;
      m_strKorpus := FieldByName('KORPUSNUMBER').AsString;

      nTypeAbo      := FieldByName('M_SBYLOCATION').AsInteger;
      ki            := FieldByName('M_SFKI').AsFloat;
      KFTR          := FieldByName('M_SFKI').AsInteger;
      m_swtid       := FieldByName('m_swtid').AsInteger;
      if ki > 0 then begin
      if (swTid=0) then m_dbDataT0 := FieldByName('m_sfvalue').AsFloat/ki;
      if (swTid=1) then m_dbDataT1 := FieldByName('m_sfvalue').AsFloat/ki;
      if (swTid=2) then m_dbDataT2 := FieldByName('m_sfvalue').AsFloat/ki;
      if (swTid=3) then m_dbDataT3 := FieldByName('m_sfvalue').AsFloat/ki;
      if (swTid=4) then m_dbDataT4 := FieldByName('m_sfvalue').AsFloat/ki;
       end else begin
        if (swTid=0) then m_dbDataT0 := FieldByName('m_sfvalue').AsFloat;
        if (swTid=1) then m_dbDataT1 := FieldByName('m_sfvalue').AsFloat;
        if (swTid=2) then m_dbDataT2 := FieldByName('m_sfvalue').AsFloat;
        if (swTid=3) then m_dbDataT3 := FieldByName('m_sfvalue').AsFloat;
        if (swTid=4) then m_dbDataT4 := FieldByName('m_sfvalue').AsFloat;
       end;
      Next;

      if pts <> FADOQuery.FieldByName('m_swMID').AsInteger then begin
        pts := FADOQuery.FieldByName('m_swMID').AsInteger;
        Inc(i);
        inc(pTable.Count);           // ************** BO 5/11/18
        SetLength(pTable.Items,i+1);
      end;

   {   Inc(j);
      //if(j=3) then
      if(j=maxCountOfTar) then
      Begin
       j := 0;
       Inc(i);
      End; }
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;


function CDBDynamicConn.GetMogBitDataMySqlExport(nABOID:Integer;var pTable:SL2INITITAG):Boolean;     // ********** BO
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin
    strSQL := ' SELECT' +
              ' M_SCHNAME' +
          ' FROM L2TAG' +
          ' WHERE' +
              ' M_SWABOID=' + IntToStr(nABOID) +
              ' and' +
              ' M_SDDFABNUM=''''';

    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.m_swAmMeter := nCount;
    SetLength(pTable.m_sMeter,nCount);
    while not FADOQuery.Eof do Begin
    with FADOQuery,pTable.m_sMeter[i] do  Begin
      m_schName   := FieldByName('M_SCHNAME').AsString;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQry;
    Result := res;
End;



function CDBDynamicConn.GetAbonLabel(nABOID: integer;var pTable:SL3ABONLB):Boolean;
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
    mAddrSet := GetAddressSett(nABOID);
    mSIDAbon := (mAddrSet mod TID_MULT) div SID_MULT;
    mTIDAbon := (mAddrSet mod DID_MULT) div TID_MULT;
    mDIDAbon := (mAddrSet mod RID_MULT) div DID_MULT;
    mRIDAbon := mAddrSet div RID_MULT;
    pTable.m_nRegID    := mRIDAbon;
    pTable.m_nDepartID := mDIDAbon;
    pTable.m_nTwnID    := mTIDAbon;
    pTable.m_nStreetID := mSIDAbon;

    strSQL := 'SELECT s0.m_nRegNM FROM SL3REGION as s0 WHERE s0.m_nRegionID='+IntToStr(mRIDAbon);
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do
     m_sRegName := FieldByName('m_nRegNM').AsString;
    End;
    CloseQry;
    strSQL := 'SELECT s0.m_sName FROM SL3DEPARTAMENT as s0 WHERE s0.m_swDepID='+IntToStr(mDIDAbon);
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do
     m_sDepartName := FieldByName('m_sName').AsString;
    End;
    CloseQry;
    strSQL := 'SELECT s0.m_sName FROM SL3TOWN as s0 WHERE s0.m_swTownID='+IntToStr(mTIDAbon);
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do
     m_sTwnName := FieldByName('m_sName').AsString;
    End;
    CloseQry;
    strSQL := 'SELECT s0.m_sName FROM SL3STREET as s0 WHERE s0.m_swStreetID='+IntToStr(mTIDAbon);
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do
     m_sStreetName := FieldByName('m_sName').AsString;
    End;
    CloseQry;

    {
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
    }
    Result := res;
End;
function CDBDynamicConn.GetAddressSett(nABOID:Integer):int64;
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
function CDBDynamicConn.GetAtomArchDataDBFExport(_dt:TDateTime; _VMID:Integer; _tar, _CMD : WORD; var pTable:L3ARCHDATAMY):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin

    strSQL := ' SELECT' +
              ' M_SWVMID,' +
              ' m_swcmdid,' +
              ' m_stime,' +
              ' m_sfvalue' +
          ' FROM L3ARCHDATA' +
          ' WHERE' +
              ' M_SWVMID=' + IntToStr(_VMID) +
              ' and' +
              ' m_swtid='+ IntToStr(_tar) +' and m_swcmdid=' + IntToStr(_cmd) +
              ' and' +
              ' CAST(m_stime AS DATE) =''' + DateToStr(_dt) + ''';';

    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable do  Begin
      m_swVMID   := FieldByName('M_SWVMID').AsInteger;
      m_swCMDID  := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate  := FieldByName('m_stime').AsDateTime;
      m_sfValue  := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQry;
    Result := res;
End;


function CDBDynamicConn.GetAtomArchDataDBFVITExport(_dt:TDateTime; _VMID:Integer; _tar, _CMD : WORD; var pTable:L3ARCHDATAMY):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin

    strSQL := ' SELECT' +
              ' M_SWVMID,' +
              ' m_swcmdid,' +
              ' m_stime,' +
              ' m_sfvalue' +
          ' FROM L3ARCHDATA' +
          ' WHERE' +
              ' M_SWVMID=' + IntToStr(_VMID) +
              ' and' +
              ' m_swtid='+ IntToStr(_tar) +' and m_swcmdid=' + IntToStr(_cmd) +
              ' and' +
              ' CAST(m_stime AS DATE) =''' + DateToStr(_dt) + ''';';

    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable do  Begin
      m_swVMID   := FieldByName('M_SWVMID').AsInteger;
      m_swCMDID  := FieldByName('m_swCMDID').AsInteger;
      m_sdtDate  := FieldByName('m_stime').AsDateTime;
      m_sfValue  := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
    End;
    End;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetAbonsTableNSDBF(strZavod,strMetType,strAID:String;var pTable:SL3ExportDBFS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strAID := strAID+'-1';
    strSQL := 'SELECT distinct s3.m_sfKI,s3.m_sfKU,s1.m_swABOID,s2.M_SWVMID,s0.m_sDogNum,s3.m_sddFabNum,s0.m_sAddress,s2.M_SMETERCODE,s1.M_NGROUPLV'+
    ' FROM SL3ABON as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2,L2TAG as s3'+
    ' where s0.m_swABOID in ('+strAID+')'+
    ' and s0.m_swABOID=s1.m_swABOID and s2.M_SWMID=s3.M_SWMID'+
    ' and s1.m_sbyGroupID=s2.m_sbyGroupID'+
    //' and s2.m_sbyEnable=1 and s1.M_NGROUPLV=0'+
    ' and s2.m_sbyEnable=1'+
    ' ORDER BY s0.m_swABOID,s1.M_NGROUPLV,s2.m_swVMID';
    pTable.Count := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      s_Type := FieldByName('M_NGROUPLV').AsInteger;
      m_strMType := FieldByName('M_SMETERCODE').AsString;
      s_AID  := FieldByName('m_swABOID').AsInteger;
      s_VMID := FieldByName('M_SWVMID').AsInteger;
      NUMABON:= FieldByName('m_sDogNum').AsString;
      ZAVOD  := strZavod;
      TIP_SC := strMetType;
      NOM_SC := FieldByName('m_sddFabNum').AsString;
      UL     := FieldByName('m_sAddress').AsString;
      KI     := FieldByName('m_sfKI').AsFloat;
      KU     := FieldByName('m_sfKU').AsFloat;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.GetAbonsTableNSDBFVIT(nABOID:Integer;de:TDateTime;var pTable:SL3ExportVitebsk):Boolean;
Var
    i,j : Integer;
    strSQL   : String;         //s2.M_SMETERCODE - город село
    res      : Boolean;        //s2.M_STPNUM     - Код Лицензии
    nCount,swTid : Integer;    //s2.M_SVMETERNAME- Фио
    pLabel   : SL3ABONLB;
    len      : Integer;
Begin
    res := False;
    GetAbonLabel(nABOID,pLabel);
    strSQL := 'SELECT DISTINCT s3.m_swtid,s2.m_swMID,s0.m_swVMID,s0.M_SMETERCODE,s0.M_SVMETERNAME,s2.M_STPNUM,s2.M_SDDFABNUM,s2.M_SDDPHADDRES,s3.m_swtid,s3.m_sfvalue,s4.M_SMARSHNUMBER,s2.M_SDDPHADDRES'+
              ' FROM SL3VMETERTAG as s0,SL3GROUPTAG as s1,L2TAG as s2,L3ARCHDATA as s3,SL3ABON as s4 '+
              ' WHERE s0.m_sbyGroupID=s1.m_sbyGroupID'+
              ' and s0.m_swVMID=s3.m_swVMID'+
              ' and (s3.m_swtid>=1) and (s3.m_swtid<=3)'+
              ' and (s3.m_swcmdid='+IntToStr(QRY_NAK_EN_DAY_EP)+' or s3.m_swcmdid='+IntToStr(QRY_NAK_EN_MONTH_EP)+')'+
              ' and CAST(s3.m_stime AS DATE)='+''''+ DateToStr(de) + ''''+
              ' and s2.m_swMID=s0.m_swMID'+
              ' and s1.m_sbyEnable=1'+
              ' and s1.m_swABOID='+IntToStr(nABOID)+
              ' ORDER BY s0.m_swVMID,s3.m_swtid';

    pTable.Count   := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;j:=0;res := True;
     pTable.Count   := trunc(nCount/3);
     SetLength(pTable.Items,pTable.Count);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_nABOID      := nABOID;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_nCMDID      := QRY_NAK_EN_MONTH_EP;
      TIME          := DateToStr(de);
      m_byREGID     := 4;
      DOM           := FieldByName('M_SMARSHNUMBER').AsString;
      KVAR          := FieldByName('M_SDDPHADDRES').AsString;
      m_nRES        := 0;
      m_strFabNum   := FieldByName('M_SDDFABNUM').AsString;
      swTid         := FieldByName('m_swtid').AsInteger;
      FLAG          :=1;
      if (swTid=1) then
      POK_T1 := FieldByName('m_sfvalue').AsFloat;
      if (swTid=2) then
      POK_T2 := FieldByName('m_sfvalue').AsFloat;
      if (swTid=3) then
      POK_T3 := FieldByName('m_sfvalue').AsFloat;
      if (swTid=4) then
      POK_T4 := FieldByName('m_sfvalue').AsFloat;
      if (swTid=5) then
      POK_T5 := FieldByName('m_sfvalue').AsFloat;


      POK_ALL:= POK_T1 + POK_T2 + POK_T3 + POK_T4 + POK_T5;

      if (POK_ALL=0) then
      begin
      TIME:='';
      FLAG:=0;
      end;
      len := Length(KVAR);
      if (len=1) then  KVAR := '00'+ KVAR;
      if (len=2) then  KVAR := '0' + KVAR;

      NUMABON := DOM+KVAR;

      Next;
      Inc(j);
      if(j=3) then
      Begin
       j := 0;
       Inc(i);
      End;
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;


function CDBDynamicConn.CalcTRET(dtCalc : TDateTime; VMID, CMDID, TID: integer): double;
var mTransInfo     : SL2TAG;
    mTariffs       : TM_TARIFFS;
    Data           : CCDatas;
    mTHourCount    : double;
    mTMask         : int64;
    mBegMAPok, mEndMAPok,
    mRaznAPok, mBegMRPok,
    mEndMRPok, mRaznRPok  : double;
    sKE : Double;
begin
   Result := -1;
   GetTransformatorInfo(VMID, mTransInfo);
   if ((mTransInfo.m_sAktEnLose = 0.0) and (mTransInfo.m_sReaEnLose = 0.0)
       and (mTransInfo.m_sTranAktRes = 0.0) and (mTransInfo.m_sTranReaRes = 0.0))then
       //and (mTransInfo.m_sGrKoeff = 0) and (mTransInfo.m_sTranVolt = 0)) then
     exit;
   if (CMDID <> QRY_SRES_ENR_EP) and (CMDID <> QRY_SRES_ENR_RP) then
     exit;
   //GetRealTMTarPeriodsCmdTable(VMID, QRY_ENERGY_SUM_EP + CMDID - QRY_SRES_ENR_EP, mTariffs);
   GetRealTMTarPeriodsCmdTable(Now,VMID, QRY_SRES_ENR_EP, mTariffs);

   mTMask := GetTAllMask(TID, mTariffs);
   mTHourCount := Get1Count(mTMask) / 2.0 * cDateTimeR.DayPerMonthDT(dtCalc);

   if TID = 0 then TID := -1;
   //A+ Конецс месяца
   if not GetGData(cDateTimeR.fIncMonth(dtCalc), cDateTimeR.fIncMonth(dtCalc), VMID, QRY_NAK_EN_MONTH_EP, TID, Data) then
     if not GetGData(cDateTimeR.fIncMonth(dtCalc), cDateTimeR.fIncMonth(dtCalc), VMID, QRY_NAK_EN_DAY_EP, TID, Data) then
       Data.Count := 0
     else
       if not GetCurrentDataInCCDatas(VMID, QRY_ENERGY_SUM_EP, Data) then
         Data.Count := 0;

   if Data.Count > 0 then
     mEndMAPok := Data.Items[0].m_sfValue
   else mEndMAPok := 0;

   //А+ Начало мессяца
   if not GetGData(cDateTimeR.GetBeginMonth(dtCalc), cDateTimeR.GetBeginMonth(dtCalc), VMID, QRY_NAK_EN_MONTH_EP, TID, Data) then
     if not GetGData(cDateTimeR.GetBeginMonth(dtCalc), cDateTimeR.GetBeginMonth(dtCalc), VMID, QRY_NAK_EN_DAY_EP, TID, Data) then
       Data.Count := 0
     else
       if not GetCurrentDataInCCDatas(VMID, QRY_ENERGY_SUM_EP, Data) then
         Data.Count := 0;

   if Data.Count > 0 then
     mBegMAPok := Data.Items[0].m_sfValue
   else mBegMAPok := 0;
   mRaznAPok := mEndMAPok - mBegMAPok;
   if mRaznAPok < 0 then mRaznAPok := 0;

   //R+ Конецс месяца
   if not GetGData(cDateTimeR.fIncMonth(dtCalc), cDateTimeR.fIncMonth(dtCalc), VMID, QRY_NAK_EN_MONTH_RP, TID, Data) then
     if not GetGData(cDateTimeR.fIncMonth(dtCalc), cDateTimeR.fIncMonth(dtCalc), VMID, QRY_NAK_EN_DAY_RP, TID, Data) then
       Data.Count := 0
     else
       if not GetCurrentDataInCCDatas(VMID, QRY_ENERGY_SUM_RP, Data) then
         Data.Count := 0;

   if Data.Count > 0 then
     mEndMRPok := Data.Items[0].m_sfValue
   else mEndMRPok := 0;

   //R+ Начало мессяца
   if not GetGData(cDateTimeR.GetBeginMonth(dtCalc), cDateTimeR.GetBeginMonth(dtCalc), VMID, QRY_NAK_EN_MONTH_RP, TID, Data) then
     if not GetGData(cDateTimeR.GetBeginMonth(dtCalc), cDateTimeR.GetBeginMonth(dtCalc), VMID, QRY_NAK_EN_DAY_RP, TID, Data) then
       Data.Count := 0
     else
       if not GetCurrentDataInCCDatas(VMID, QRY_ENERGY_SUM_EP, Data) then
         Data.Count := 0;

   if Data.Count > 0 then
     mBegMRPok := Data.Items[0].m_sfValue
   else mBegMRPok := 0;
   mRaznRPok := mEndMRPok - mBegMRPok;
   if mRaznRPok < 0 then mRaznRPok := 0;

   if mTHourCount = 0 then
   begin
     Result := 0;
     exit;
   end;
   with mTransInfo do
   Begin
     //mTHourCount := 1;
     sKE := m_sfKI*m_sfKU;if sKE=0    then sKE    := 1;
                          if m_sfKU=0 then m_sfKU := 1;
     case CMDID of
       QRY_SRES_ENR_EP : Result := mTHourCount * m_sAktEnLose +
                (sqr(mRaznAPok) + sqr(mRaznRPok)) / (mTHourCount *sqr(GetTrabVolt(m_sTranVolt)/1000)) *
                m_sTranAktRes * GetGrKoeffVal(m_sGrKoeff)*0.001;

       QRY_SRES_ENR_RP : Result := mTHourCount * m_sReaEnLose +
                (sqr(mRaznAPok) + sqr(mRaznRPok)) / (mTHourCount *sqr(GetTrabVolt(m_sTranVolt)/1000)) *
                m_sTranReaRes * GetGrKoeffVal(m_sGrKoeff)*0.001;

       else Result := 0;
     end;
     Result := Result{/sKE};
   End;
end;

{function CDBDynamicConn.GetEventsCount: integer;
Var
    strSQL   : String;
    nCount   : Integer;
Begin
   Result := 0;
   strSQL := 'select count(*) from SEVENTTTAG';
   if OpenQry(strSQL,nCount)=True then
   Begin
     Result := FADOQuery.FieldByName('count').AsInteger;
   End;
   CloseQry;
end;  }

{function CDBDynamicConn.GetAllEventsTable(var pTable: SEVENTTAGS):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
begin
   pTable.Count := 0;
   strSQL := 'SELECT * FROM SEVENTTTAG';
   if OpenQry(strSQL,nCount)=True then
   begin
     i:=0;   res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery, pTable.Items[i] do
       begin
         m_swID         := FieldByName('m_swID').AsInteger;
         m_swVMID       := FieldByName('m_swVMID').AsInteger;
         m_swGroupID    := FieldByName('m_swGroupID').AsInteger;
         m_swEventID    := FieldByName('m_swEventID').AsInteger;
         m_sdtEventTime := FieldByName('m_sdtEventTime').AsDateTime;
         m_sUser        := FieldByName('m_sUser').AsString;
         m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
         m_swDescription    := FieldByName('m_swDescription').AsFloat;
         m_swAdvDescription := FieldByName('m_swAdvDescription').AsInteger;
         Next;
         Inc(i);
       end;
     end;
   end;
   CloseQry;
   Result := res;
end; }
//

function CDBDynamicConn.GetEventName(GrID, EvID: integer): string;
Var
    strSQL   : String;
    nCount   : Integer;
Begin
   Result := '';
   strSQL := 'select m_scheventname from SEVENTSETTTAGS where M_SWEVENTID =' +
        IntToStr(EvID) + ' and M_SWGROUPID = ' + IntToStr(GrID);
   if OpenQry(strSQL,nCount)=True then
   Begin
     Result := FADOQuery.FieldByName('m_scheventname').AsString;
   End;
   CloseQry;
end;

function CDBDynamicConn.GetFabNumber(VMID: integer): string;
Var
    strSQL   : String;
    nCount   : Integer;
Begin
   Result := '---';
   strSQL := 'select distinct(l2tag.m_sddfabnum) from sl3vmetertag, l2tag where sl3vmetertag.m_swmid = l2tag.m_swmid and ' +
             'sl3vmetertag.m_swvmid = ' + IntToStr(VMID);
   if OpenQry(strSQL,nCount)=True then
   Begin
     Result := FADOQuery.FieldByName('m_sddfabnum').AsString;
   End;
   CloseQry;
end;
 {
  1. - чтение накопленной энергии на начало месяца за промежуток времени        +
  2. - чтение приращений энергии за сутки за промежуток времени                 +
  3. - функции проверки правильности параметров на начало месяца                +
  4. - функции проверки правильности параметров приращение за сутки             +
  5. - формирование функций поиска месячной накопленной энергии по датам        +
  6. - формирование функций поиска приращение электроэнергии по дате            +
  7. - формирование динамического массива структру размером (dtP0 - dtP1 + 1)*(FKeyE - FKeyB + 1)*(PKeyB - pKefdf + 1)
  8. - сформировать цикл заполнения структрур накопленных энерги
 }
function CDBDynamicConn.FindNakEnInMonthDays(dtP0,dtP1:TDateTime;FKeyB,FKeyE,PKeyB,PKeyE:Integer;var pTable:CCDatasEkom): boolean;
var nakEnMonth, prirEnDay : CCDatasEkom;
    vmidC, cmdidC, dtC    : integer;
    VM, CMD, DT, CN       : integer;
begin
   Result := false;
   GetEKOM3000GData(cDateTimeR.GetBeginMonth(dtP0), cDateTimeR.GetBeginMonth(dtP1), FKeyB, FKeyE,
                        QRY_NAK_EN_MONTH_EP + PKeyB - QRY_NAK_EN_DAY_EP, QRY_NAK_EN_MONTH_EP + PKeyE - QRY_NAK_EN_DAY_EP, nakEnMonth);
   GetEKOM3000GData(dtP0, cDateTimeR.GetBeginMonth(dtP1) + 1, FKeyB, FKeyE,
                        QRY_ENERGY_DAY_EP + PKeyB - QRY_NAK_EN_DAY_EP, QRY_ENERGY_DAY_EP + PKeyE - QRY_NAK_EN_DAY_EP, prirEnDay);
   if (CheckIsFullNakMonth(dtP0, dtP1, nakEnMonth) and CheckIsFillPrDay(dtP0, cDateTimeR.GetBeginMonth(dtP1) + 1, prirEnDay)) then
   begin
     Result := true;
     vmidC  := FKeyB - FKeyE + 1;
     cmdidC := PKeyE - PKeyB + 1;
     dtC    := (trunc(dtP0) - trunc(dtP1)) + 1;
     pTable.Count := vmidC * cmdidC * dtC;
     SetLength(pTable.Items, pTable.Count);
     UpdatePrirEnDayStr(prirEnDay);
     for DT := trunc(dtP1) to trunc(dtP0) do
       for VM := FKeyB to FKeyE do
         for CMD := PKeyB to PKeyE do
         begin
           CN := (DT - trunc(dtP1)) * vmidC * cmdidC + (VM - FKeyB) * cmdidC + CMD - PKeyB;
           pTable.Items[CN].m_sTime := DT;
           pTable.Items[CN].m_swVMID := VM;
           pTable.Items[CN].m_swCMDID := CMD;
           pTable.Items[CN].m_sfValue := FindValueNakEnMon(dtP1, VM, QRY_NAK_EN_MONTH_EP + CMD - QRY_NAK_EN_DAY_EP, nakEnMonth) +
                        FindValuePrEnDay(DT, VM, QRY_ENERGY_DAY_EP + CMD - QRY_NAK_EN_DAY_EP, prirEnDay);
         end;
   end;
end;

function CDBDynamicConn.CheckIsFullNakMonth(dtP0, dtP1: TDateTime; var pTable: CCDatasEkom): boolean;
var unicDC, calcDC, i : integer;
    tempDate          : TDateTime;
begin
   Result := false;
   unicDC := 0;
   if (dtP0 >= dtP1) and (pTable.Count > 0) then
   begin
     dtP0 := cDateTimeR.GetBeginMonth(dtP0);
     dtP1 := cDateTimeR.GetBeginMonth(dtP1);
     while dtP0 >= dtP1 do
     begin
       unicDC := unicDC + 1;
       cDateTimeR.IncMonth(dtP1);
     end;
     tempDate := pTable.Items[0].m_sTime;
     calcDC   := 1;
     for i := 1 to pTable.Count - 1 do
       if tempDate <> pTable.Items[i].m_sTime then
         calcDC := calcDC + 1;
     if (calcDC = unicDC) then
       Result := true;
   end;
end;

function CDBDynamicConn.CheckIsFillPrDay(dtP0, dtP1: TDateTime; var pTable: CCDatasEkom): boolean;
var unicDC, calcDC, i : integer;
    tempDate          : TDateTime;
begin
   Result := false;
   unicDC := 0;
   if (dtP0 >= dtP1) and (pTable.Count > 0) then
   begin
     unicDC := trunc(dtP0) - trunc(dtP1) + 1;
     tempDate := pTable.Items[0].m_sTime;
     calcDC   := 1;
     for i := 1 to pTable.Count - 1 do
       if tempDate <> pTable.Items[i].m_sTime then
         calcDC := calcDC + 1;
     if (calcDC = unicDC) then
       Result := true;
   end;
end;

function CDBDynamicConn.FindValueNakEnMon(Dt: TDateTime; VMID, CMDID: integer; var pTable: CCDatasEkom): double;
var i : integer;
begin
   Result := 0.0;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swVMID = VMID) and (pTable.Items[i].m_swCMDID = CMDID)
        and (pTable.Items[i].m_sTime = cDateTimeR.GetBeginMonth(Dt)) then
     begin
       Result := pTable.Items[i].m_sfValue;
       exit;
     end;
end;

function CDBDynamicConn.FindValuePrEnDay(Dt: TDateTime; VMID, CMDID : integer; var pTable: CCDatasEkom): double;
var i: integer;
begin
   Result := 0.0;
   for i := 0 to pTable.Count - 1 do
     if (pTable.Items[i].m_swVMID = VMID) and (pTable.Items[i].m_swCMDID = CMDID)
        and (pTable.Items[i].m_sTime = Dt) then
     begin
       Result := pTable.Items[i].m_sfValue;
       exit;
     end;
end;

procedure CDBDynamicConn.UpdatePrirEnDayStr(var pTable: CCDatasEkom);
var i: integer;
begin
   //for i := pTable.Count - 1 downto 1 do
   //  pTable.Items[i].m_sfValue := pTable.Items[i - 1].m_sfValue;
   for i := 1 to pTable.Count - 1 do
     pTable.Items[i].m_sfValue :=  pTable.Items[i].m_sfValue + pTable.Items[i - 1].m_sfValue;
   pTable.Items[0].m_sfValue := 0;

end;

function CDBDynamicConn.GetMMeterTableEx(nIndex:Integer;var pTable:SL2TAG):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    //strSQL := 'SELECT L2TAG.*,L1TAG.m_sbyProtID FROM L2TAG,L1TAG WHERE L1TAG.m_sbyPortID=L2TAG.m_sbyPortID'+
    //' AND M_SBYENABLE=1'+
    //' AND m_swMID='+IntToStr(nIndex);
    strSQL := 'SELECT * FROM L2TAG'+
    ' WHERE M_SBYENABLE=1'+
    ' AND m_swMID='+IntToStr(nIndex);
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do  Begin
      m_sbyID        := FieldByName('m_sbyID').AsInteger;
      //m_sbyProtID    := FieldByName('m_sbyProtID').AsInteger;
      m_sbyProtID    := 0;
      m_sbyGroupID   := FieldByName('m_sbyGroupID').AsInteger;
      m_swMID        := FieldByName('m_swMID').AsInteger;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_sbyPortID    := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType      := FieldByName('m_sbyType').AsInteger;
      m_sbyLocation  := FieldByName('m_sbyLocation').AsInteger;
      m_sddFabNum    := FieldByName('m_sddFabNum').AsString;
      m_schPassword  := FieldByName('m_schPassword').AsString;
      m_sddPHAddres  := FieldByName('m_sddPHAddres').AsString;
      m_sddPHAddres2 := '';
      m_swAddrOffset := 0;
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
      pullid         := FieldByName('pullid').AsInteger;
      M_SWABOID      := FieldByName('M_SWABOID').AsInteger;
      m_aid_channel  := FieldByName('M_SWABOID_CHANNEL').AsInteger;
      m_aid_tariff   := FieldByName('M_SWABOID_TARIFF').AsInteger;
     End;
     res := True;
    End;
    CloseQry;
    Result := res;
End;

//----------------инф-о-доме--------------------------------
function CDBDynamicConn.getAbonInfBalans(pAID:Integer; var ulica, dom:String):Boolean;
var
    strSQL       : String;
    res          : Boolean;
    nCount       : Integer;
Begin
    Result := False;
    strSQL := 'SELECT M_SADDRESS as ulica, M_SNAME as dom'+
              ' FROM SL3ABON WHERE M_SWABOID='+IntToStr(pAID);
    if OpenQry(strSQL,nCount)=True then
    Begin
     ulica   := FADOQuery.FieldByName('ulica').AsString;
     dom := FADOQuery.FieldByName('dom').AsString;
     res   := True;
    End;
    CloseQry;
    Result := res;
End;
//------------------------инф--счетчиков-в--доме--------------------------------
function CDBDynamicConn.getListMeter(pAID:Integer; var listMeter:TThreadList):Boolean;
var
    strSQL       : String;
    res          : Boolean;
    nCount   : Integer;
    infMeter     : ^SL2TAG;
Begin
    Result := False;
    strSQL := 'SELECT M_SWMID as idMeter, M_SDDPHADDRES as kvar, M_STPNUM as lics, TYPEPU, M_SDDFABNUM as zavno, M_SCHNAME'+
              ' FROM L2TAG WHERE M_SWABOID='+IntToStr(pAID);

    if OpenQry(strSQL,nCount)=True then
    Begin
        while not FADOQuery.Eof do Begin
                with FADOQuery do
                Begin
                new(infMeter);
                infMeter^.m_swMID := FieldByName('idMeter').AsInteger;
                infMeter^.m_sddPHAddres := FieldByName('kvar').AsString;
                infMeter^.m_sTpNum := FieldByName('lics').AsString;
                infMeter^.typepu :=  FieldByName('TYPEPU').AsInteger;
                infMeter^.m_sddFabNum := FieldByName('zavno').AsString;
                infMeter^.m_schName :=  FieldByName('M_SCHNAME').AsString;
                Next;
                End;
                listMeter.LockList.Add(infMeter);
                listMeter.UnLockList;
        End;
    res   := True;
    End;
    CloseQry;
    Result := res;
End;
//------------------------показания--счетчика------------------------------------------------------
function CDBDynamicConn.getMeasureMeter(nParam,month,year:Integer; var measureMeter:MEASUREBALANSREP):Boolean;
var
    strSQL       : String;
    res          : Boolean;
    nCount       : Integer;
Begin
    Result := False;
    strSQL := 'SELECT distinct s1.M_SWTID as tarif, s1.M_SFVALUE as measure, s1.M_STIME'+
              ' FROM SL3VMETERTAG as s0,L3ARCHDATA as s1'+
              ' WHERE s0.M_SWMID='+IntToStr(measureMeter.id_meter)+
              ' and s0.M_SWVMID=s1.M_SWVMID'+
              ' and s1.M_SWCMDID='+IntToStr(nParam)+
              ' and EXTRACT(MONTH FROM s1.M_STIME)='+IntToStr(month)+
              ' and EXTRACT(YEAR FROM s1.M_STIME)='+IntToStr(year);
     res := OpenQry(strSQL,nCount);
    if res then
    Begin
        measureMeter.datatime := FADOQuery.FieldByName('M_STIME').AsDateTime;
        while not FADOQuery.Eof do Begin
                with FADOQuery do
                Begin

                        case FieldByName('tarif').AsInteger of
                        //0: measureMeter.t0 := FieldByName('measure').AsFloat;
                        1: measureMeter.t1 := FieldByName('measure').AsFloat;
                        2: measureMeter.t2 := FieldByName('measure').AsFloat;
                        3: measureMeter.t3 := FieldByName('measure').AsFloat;
                        4: measureMeter.t4 := FieldByName('measure').AsFloat;
                        End;
                Next;
                End;
        End;
    //res   := True;
    End;
    CloseQry;
    Result := res;
End;

//------------------------------------------------------------------------------------------------------------
function CDBDynamicConn.getRegionHouseList(regionId:Integer; var houseList:TThreadList):Boolean;
var
    strSQL       : String;
    res          : Boolean;
    nCount       : Integer;
    houseInf    : ^REGIONHOUSELIST;
Begin
    Result := False;
    strSQL := 'SELECT t2.M_NREGNM as region, t0.M_SNAME as town,t1.M_SWABOID as houseId,t1.M_SHOUSENUMBER as house, t1.M_SKORPUSNUMBER as korpus, t1.M_SADDRESS as ulica '+
    'from sl3town as t0,sl3abon as t1, sl3region as t2 WHERE t0.M_SWTOWNID = t1.M_SWTOWNID AND t2.M_NREGIONID = t1.M_NREGIONID AND t1.M_SWDEPID IN (SELECT M_SWDEPID FROM sl3departament '+
    'where M_SWREGION = '+IntToStr(regionId)+')';

    if OpenQry(strSQL,nCount)=True then
    Begin
        while not FADOQuery.Eof do Begin
                with FADOQuery do
                Begin
                new(houseInf);
                houseInf^.town := FieldByName('town').AsString;
                houseInf^.ulica := FieldByName('ulica').AsString;
                houseInf^.house := FieldByName('house').AsString;
                houseInf^.korpus :=  FieldByName('korpus').AsString;
                houseInf^.houseId := FieldByName('houseId').AsInteger;
                houseInf^.region := FieldByName('region').AsString;
                Next;
                End;
                houseList.LockList.Add(houseInf);
                houseList.UnLockList;
        End;
    res   := True;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.getRegionHouseAbonList(AbonId, regionId:Integer; var houseList:TThreadList):Boolean;
var
    strSQL       : String;
    res          : Boolean;
    nCount       : Integer;
    houseInf    : ^REGIONHOUSELIST;
Begin
    Result := False;
    strSQL := 'SELECT t2.M_NREGNM as region, t0.M_SNAME as town,t1.M_SWABOID as houseId,t1.M_SHOUSENUMBER as house, t1.M_SKORPUSNUMBER as korpus, t1.M_SADDRESS as ulica '+
    'from sl3town as t0,sl3abon as t1, sl3region as t2 WHERE t0.M_SWTOWNID = t1.M_SWTOWNID AND t1.M_SWABOID='+IntToStr(AbonId)+' AND t2.M_NREGIONID = t1.M_NREGIONID AND t1.M_SWDEPID IN (SELECT M_SWDEPID FROM sl3departament where M_SWREGION = '+IntToStr(regionId)+')';

    if OpenQry(strSQL,nCount)=True then
    Begin
        while not FADOQuery.Eof do Begin
                with FADOQuery do
                Begin
                new(houseInf);
                houseInf^.town := FieldByName('town').AsString;
                houseInf^.ulica := FieldByName('ulica').AsString;
                houseInf^.house := FieldByName('house').AsString;
                houseInf^.korpus :=  FieldByName('korpus').AsString;
                houseInf^.houseId := FieldByName('houseId').AsInteger;
                houseInf^.region := FieldByName('region').AsString;
                Next;
                End;
                houseList.LockList.Add(houseInf);
                houseList.UnLockList;
        End;
    res   := True;
    End;
    CloseQry;
    Result := res;
End;
//------------------------------------------------------------------------------------------------------------
function CDBDynamicConn.getNoDataMeter(nParam,day,month,year,houseId:Integer; var MeterList:String; var count, countMeter : Integer):Boolean;
var
    strSQL       : String;
    res          : Boolean;
    nCount       : Integer;
Begin
    Result := False;
   { strSQL := 'SELECT M_SDDPHADDRES as kvarc, M_SDDFABNUM as numMeter FROM l2tag where M_SWABOID = ' + IntToStr(houseId) + ' AND '+
    'M_SWMID NOT IN (SELECT M_SWVMID FROM l3archdata where M_SWCMDID=' + IntToStr(nParam) + ' and EXTRACT(MONTH FROM M_STIME)= '+ IntToStr(month)+
    ' and EXTRACT(YEAR FROM M_STIME)=' + IntToStr(year) + ' and M_SWVMID IN (SELECT M_SWMID FROM l2tag WHERE M_SWABOID =' + IntToStr(houseId)+'))';  }
   if ((nParam>=QRY_NAK_EN_DAY_EP) and (nParam<=QRY_NAK_EN_DAY_EP)) then
   strSQL := 'SELECT M_SWMID, M_SDDPHADDRES as kvarc, M_SDDFABNUM as numMeter, '+
             '    (SELECT COUNT(M_SWMID) FROM l2tag WHERE M_SWABOID = ' + IntToStr(houseId)+') as countMeter' +
             ' FROM l2tag where M_SWABOID = ' + IntToStr(houseId)+' AND M_SWMID NOT IN(SELECT distinct s2.m_swMID FROM SL3VMETERTAG as s0,SL3GROUPTAG as s1,L2TAG as s2,L3ARCHDATA as s3, SL3ABON as s4'+
             ' WHERE s0.m_sbyGroupID=s1.m_sbyGroupID and EXTRACT(DAY FROM M_STIME)='+ IntToStr(day)+' and EXTRACT(MONTH FROM M_STIME)='+ IntToStr(month)+' and EXTRACT(YEAR FROM M_STIME)=' + IntToStr(year) + ' and s0.m_swVMID=s3.m_swVMID and'+
             ' s3.m_swcmdid=' + IntToStr(nParam) + ' and s1.m_swABOID=s4.m_swABOID and s2.m_swMID=s0.m_swMID and s1.m_sbyEnable=1 and s1.m_swABOID=' + IntToStr(houseId)+')'

   else
   strSQL := 'SELECT M_SWMID, M_SDDPHADDRES as kvarc, M_SDDFABNUM as numMeter, '+
             '    (SELECT COUNT(M_SWMID) FROM l2tag WHERE M_SWABOID = ' + IntToStr(houseId)+') as countMeter' +
             ' FROM l2tag where M_SWABOID = ' + IntToStr(houseId)+' AND M_SWMID NOT IN(SELECT distinct s2.m_swMID FROM SL3VMETERTAG as s0,SL3GROUPTAG as s1,L2TAG as s2,L3ARCHDATA as s3, SL3ABON as s4'+
             ' WHERE s0.m_sbyGroupID=s1.m_sbyGroupID and EXTRACT(MONTH FROM M_STIME)='+ IntToStr(month)+' and EXTRACT(YEAR FROM M_STIME)=' + IntToStr(year) + ' and s0.m_swVMID=s3.m_swVMID and'+
             ' s3.m_swcmdid=' + IntToStr(nParam) + ' and s1.m_swABOID=s4.m_swABOID and s2.m_swMID=s0.m_swMID and s1.m_sbyEnable=1 and s1.m_swABOID=' + IntToStr(houseId)+')';

    {strSQL := 'SELECT t0.M_SDDPHADDRES as kvarc, t0.M_SDDFABNUM as numMeter FROM l2tag AS t0, sl3vmetertag AS t1 where t0.M_SWABOID =' + IntToStr(houseId)+
              ' and  t1.M_SWMID = t0.M_SWMID' +
              ' AND t1.M_SWVMID NOT IN (SELECT M_SWVMID FROM l3archdata where M_SWCMDID=' + IntToStr(nParam) +
              ' and EXTRACT(MONTH FROM M_STIME)=' + IntToStr(month) +
              ' and EXTRACT(YEAR FROM M_STIME)=' + IntToStr(year) +
              ' and M_SWVMID IN (SELECT t0.M_SWVMID FROM sl3vmetertag AS t0, l2tag AS t1 WHERE t1.M_SWABOID =' + IntToStr(houseId) + ' and t0.M_SWMID = t1.M_SWMID))';  }

    if OpenQry(strSQL,nCount)=True then
    Begin
        count := nCount;
        countMeter:=FADOQuery.FieldByName('countMeter').AsInteger;
        while not FADOQuery.Eof do Begin
                with FADOQuery do
                Begin
                {$IFDEF HOMEL}
                MeterList := MeterList + 'кв.'+ FieldByName('kvarc').AsString+'; ';
                {$ELSE}
                MeterList := MeterList + 'кв.'+ FieldByName('kvarc').AsString + ' №' + FieldByName('numMeter').AsString + '; ';
                {$ENDIF}
                Next;
                End;
        End;
    res   := True;
    End;
    CloseQry;
    Result := res;
End;
//----------------------------------------------------------------------------------------------------------------
function CDBDynamicConn.getCountHouseMeter(houseId:Integer):Integer;
var
    strSQL       : String;
    res          : Integer;
    nCount       : Integer;
Begin
    Result := 0;
    strSQL := 'SELECT COUNT(M_SWMID) as countMeter FROM l2tag WHERE M_SWABOID =' + IntToStr(houseId);

    if OpenQry(strSQL,nCount)=True then
    Begin
    res   := FADOQuery.FieldByName('countMeter').AsInteger;
    End;
    CloseQry;
    Result := res;
End;
//-----------------------------------------------------------------------------------------------------------------
function CDBDynamicConn.getRegionId(houseId:Integer):Integer;
var
    strSQL       : String;
    res          : Integer;
    nCount       : Integer;
Begin
    Result := 0;
    strSQL := 'SELECT M_NREGIONID as regId FROM sl3abon WHERE M_SWABOID =' + IntToStr(houseId);

    if OpenQry(strSQL,nCount)=True then
    Begin
    res   := FADOQuery.FieldByName('regId').AsInteger;
    End;
    CloseQry;
    Result := res;
End;
//------------------------------------------------------------------------------------------------------------------


{ ******************************************************************************
*  Данный метод возвращает все ID - регионов и их наименования
*******************************************************************************}
{
    SL3REGION = packed record
     m_swID      : Integer;
     m_nRegionID : Integer;
     m_nRegNM    : string[100];
     m_sKSP      : string[5];
     m_sbyEnable : Byte;
     Item        : SL3ABONS;
    End;
}

function CDBDynamicConn.getRegionCountID(var regionList:TThreadList):Boolean;
var
    strSQL       : String;
    nCount       : Integer;
    res          : Boolean;
    regionInf    : ^SL3REGION;
begin
    Result := False;
    strSQL := 'SELECT M_NREGIONID as regId, M_NREGNM as name, M_SBYENABLE as enable FROM SL3REGION ORDER BY M_NREGIONID';

    if OpenQry(strSQL,nCount)=True then
    Begin
        while not FADOQuery.Eof do Begin
                with FADOQuery do
                Begin
                new(regionInf);
                regionInf^.m_nRegionID := FieldByName('regId').AsInteger;
                regionInf^.m_nRegNM    := FieldByName('name').AsString;
                regionInf^.m_sbyEnable := FieldByName('enable').AsInteger;
                Next;
                End;
                regionList.LockList.Add(regionInf);
                regionList.UnLockList;
        End;
    res   := True;
    End;
    CloseQry;
    Result := res;
end;

function CDBDynamicConn.addErrorArch(aid,mid:Integer):Boolean;
Var
    strSQL: String;
Begin
    strSQL := 'UPDATE OR INSERT INTO ARCHIVE_ERROR (m_swABOID, M_SWMID, M_DATE) VALUES('+IntToStr(aid) + ',' + IntToStr(mid) + ','  + '''' + DateToStr(now) + '''' +')';
    Result := ExecQry(strSQL);

End;
//----------------------------------------------------------------------------------------------------------------------
function CDBDynamicConn.getNoDataMeterDay(strDate :String;houseId:Integer; var MeterList:String; var count : Integer):Boolean;
var
    strSQL       : String;
    res          : Boolean;
    nCount       : Integer;
Begin
    Result := False;
    strSQL := 'SELECT M_SDDPHADDRES as kvarc, M_SDDFABNUM as numMeter FROM l2tag where '+
    'M_SWMID IN (SELECT M_SWMID FROM archive_error WHERE M_SWABOID = '+ IntToStr(houseId) + ' AND M_DATE = ' + '''' + strDate +''''+')';


    if OpenQry(strSQL,nCount)=True then
    Begin
        count := nCount;
        while not FADOQuery.Eof do Begin
                with FADOQuery do
                Begin
                MeterList := MeterList + 'кв.'+ FieldByName('kvarc').AsString + ' №' + FieldByName('numMeter').AsString + '; ';
                Next;
                End;
        End;
    res   := True;
    End;
    CloseQry;
    Result := res;
End;


function CDBDynamicConn.getChannelMeter(houseId,ChannelId,tarif:Integer;var pTable:SL2INITITAG):Boolean;
var
    strSQL       : String;
    res          : Boolean;
    nCount,i       : Integer;
Begin
    Result := False;
    if (tarif=-1) then
    strSQL := 'Select M_SWMID,M_SDDFABNUM, M_SWABOID_CHANNEL '+
              'from l2tag where M_SWABOID='+ IntToStr(houseId)+' and  M_SWABOID_CHANNEL='+IntToStr(ChannelId)
    else
    strSQL := 'Select M_SWMID,M_SDDFABNUM, M_SWABOID_CHANNEL '+
              'from l2tag where M_SWABOID='+ IntToStr(houseId)+' and  M_SWABOID_CHANNEL='+IntToStr(ChannelId)+' and M_SWABOID_TARIFF='+IntToStr(tarif);

    i:=0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    pTable.m_swAmMeter := nCount;
    SetLength(pTable.m_sMeter,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sMeter[i] do  Begin
      m_swMID   := FieldByName('M_SWMID').AsInteger;
      typeabo    := FieldByName('m_sddFabNum').AsString;
      Next;
      Inc(i);
      End;
    End;
     res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.getChannel(houseId:integer;var pTable:SL2INITITAG):Boolean;
var
    strSQL       : String;
    res          : Boolean;
    nCount,i       : Integer;
Begin
    Result := False;
    strSQL := 'select m_swaboid_channel,  count (ALL l2tag.m_swaboid )KOL_VO_METERS'+
              ' from l2tag where m_swaboid='+ IntToStr(houseId)+ 'group by m_swaboid_channel  HAVING m_swaboid_channel IS NOT NULL';
    i:=0;
    if OpenQry(strSQL,nCount)=True then
    Begin
    pTable.m_swAmMeter := nCount;
    SetLength(pTable.m_sMeter,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sMeter[i] do  Begin
      M_SWABOID := FieldByName('m_swaboid_channel').AsInteger;
      m_swVMID  := FieldByName('KOL_VO_METERS').AsInteger;
      Next;
      Inc(i);
      End;
    End;
     res := True;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.getCountMeterKiKu(houseId:integer;strFabnum:string;var ki,ku:integer):boolean;
var
    strSQL       : String;
    res          : Integer;
    nCount       : Integer;
Begin
    //Result := 0;
    strSQL := 'select M_SFKI,M_SFKU from l2tag where M_SWABOID=' + IntToStr(houseId)+' and M_SDDFABNUM='+strFabnum;

    if OpenQry(strSQL,nCount)=True then
    Begin
    ki   := FADOQuery.FieldByName('M_SFKI').AsInteger;
    ku   := FADOQuery.FieldByName('M_SFKU').AsInteger;
    End;
    CloseQry;
    Result := true;
End;


function CDBDynamicConn.GetMetersSSDU(SAbon:integer;var pTable:SL2INITITAG):Boolean;
Var
    i        : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM L2TAG where M_SWABOID='+IntToStr(SAbon)+' ORDER BY m_swMID';
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
      m_sAdvDiscL2Tag:= FieldByName('m_sAdvDiscL2Tag').AsString;
      m_sbyStBlock   := FieldByName('m_sbyStBlock').AsInteger;
      Next;
      Inc(i);
      End;
     End;           
    End;
    CloseQry;
    Result := res;
End;


function CDBDynamicConn.WriteBD(StrBD:TStringList):Boolean;
Begin
 //   strSql := '';
    Result := ExecQryByt(StrBD);
End;


function CDBDynamicConn.ChannelResetNul(aid:Integer):Boolean;
Var
    strSQL: String;
Begin
    strSQL := 'UPDATE L2TAG SET L2TAG.M_SADVDISCL2TAG ='
             +'(SELECT OVERLAY(L2.M_SADVDISCL2TAG PLACING ''0'' FROM (POSITION('';'', L2.M_SADVDISCL2TAG, '
             +'POSITION('';'' IN L2.M_SADVDISCL2TAG)+1)+1) FOR (POSITION('';'', L2.M_SADVDISCL2TAG, POSITION('';'', L2.M_SADVDISCL2TAG, '
             +'POSITION('';'' IN L2.M_SADVDISCL2TAG)+1)+1) - POSITION('';'', L2.M_SADVDISCL2TAG, '
             +'POSITION('';'' IN L2.M_SADVDISCL2TAG)+1)-1)) '
             +' FROM L2TAG L2  WHERE L2TAG.M_SWMID = L2.M_SWMID) '
             +' WHERE L2TAG.M_SWABOID = '+IntToStr(aid);

    Result := ExecQry(strSQL);

End;

function CDBDynamicConn.ChannelSet(aid,channel:Integer;fab_num:string):Boolean;
Var
    strSQL: String;
Begin
    strSQL := 'UPDATE L2TAG SET L2TAG.M_SADVDISCL2TAG ='
              +' (SELECT OVERLAY(L2.M_SADVDISCL2TAG PLACING '''+ IntToStr(channel)+''''
              +' FROM (POSITION('';'', L2.M_SADVDISCL2TAG, POSITION('';'' IN L2.M_SADVDISCL2TAG)+1)+1) FOR (POSITION('';'', L2.M_SADVDISCL2TAG,'
              +' POSITION('';'', L2.M_SADVDISCL2TAG,POSITION('';'' IN L2.M_SADVDISCL2TAG)+1)+1) - POSITION('';'', L2.M_SADVDISCL2TAG,POSITION('';'' IN L2.M_SADVDISCL2TAG)+1)-1))'
              +' FROM L2TAG L2  WHERE L2TAG.M_SWMID = L2.M_SWMID)'
              +' WHERE L2TAG.M_SWABOID = ' +IntToStr(aid)
              +' AND TRIM(M_SDDFABNUM) ='+ fab_num;
    Result := ExecQry(strSQL);

End;

function CDBDynamicConn.GetHomeBallanceReport(SL: TStringList; XLSP : TXLSPointerHomeBalanse; var WB:TSheet; var aData : string): boolean;
var
    nCount, i, j : Integer;
    s, sa, sb : string;
    MID    : integer;
    fa, fb : double;
    Loc    : byte;
    dt     : TDate;
Begin
  if OpenQrySL(SL,nCount)=True then begin
    i:=XLSP.xnFirstRow;

    for j := 0 to 4 do begin
      rpHomeBalanse.TotalPowerConsumptionT[j] := 0;
      rpHomeBalanse.TotalPowerBalanceT[j] := 0;
      rpHomeBalanse.TotalPowerNoBalanceT[j] := 0;      
    end;


    while not FADOQuery.Eof do begin
      MID := FADOQuery.FieldByName('MID').AsInteger;
      Loc := FADOQuery.FieldByName('LOC').AsInteger;
      s := FADOQuery.FieldByName('M_SCHNAME').AsString;
      delete(s, 1, 5);
      WB.Cells[i,XLSP.xnNumberHouse].Value:=copy(s,1,pos('/', s)-1);
      delete(s, 1, pos('/', s));
      delete(s, 1, 4);
      WB.Cells[i,XLSP.xnConsumerLS].Value:=copy(s,1,pos(')', s)-1);
      delete(s, 1, pos(')', s));
      WB.Cells[i,XLSP.xnConsumerName].Value:= s;
      WB.Cells[i,XLSP.xnEnergy].Value:= rpHomeBalanse.PH_KindEnergy;
      WB.Cells[i,XLSP.xnMeterNumb].Value:= FADOQuery.FieldByName('FABNUM').AsString;
      WB.Cells[i,XLSP.xnRatio].Value:= FADOQuery.FieldByName('KE').AsInteger;

      // певичные значения счетчика
      for j := 0 to 4 do begin
        if FADOQuery.FieldByName('V_TARIF_' + IntToStr(j) + '_VAL_APLUS').AsString = '' then begin
          WB.Cells[i,XLSP.xnPrimaryIndicationsT[j]].Value :='н/д';
          WB.Cells[i,XLSP.xnPrimaryIndicationsT[j]].FillPattern:= xlPatternSolid;
          WB.Cells[i,XLSP.xnPrimaryIndicationsT[j]].FillPatternBGColorIndex:= xlColorRose;
      end else begin                           // FADOQuery.FieldByName('V_TARIF_0_VAL_APLUS').AsFloat;
          WB.Cells[i,XLSP.xnPrimaryIndicationsT[j]].Value:= RVLPr(FADOQuery.FieldByName('V_TARIF_' + IntToStr(j) + '_VAL_APLUS').AsFloat,MeterPrecision[MID]);///FADOQuery.FieldByName('KE').AsFloat, MeterPrecision[MID]);
          WB.Cells[i,XLSP.xnPrimaryIndicationsT[j]].FillPattern:= xlPatternSolid;
          WB.Cells[i,XLSP.xnPrimaryIndicationsT[j]].FillPatternBGColorIndex:= xlColorWhite;
      end;
      end;


      // вторичные значения счетчика
      for j := 0 to 4 do begin
        if FADOQuery.FieldByName('R_TARIF_' + IntToStr(j) + '_VAL_APLUS').AsString = '' then begin
          WB.Cells[i,XLSP.xnSecondaryIndicationsT[j]].Value :='н/д';
          WB.Cells[i,XLSP.xnSecondaryIndicationsT[j]].FillPattern:= xlPatternSolid;
          WB.Cells[i,XLSP.xnSecondaryIndicationsT[j]].FillPatternBGColorIndex:= xlColorRose;
        end else begin                           // FADOQuery.FieldByName('V_TARIF_0_VAL_APLUS').AsFloat;
          WB.Cells[i,XLSP.xnSecondaryIndicationsT[j]].Value:= RVLPr(FADOQuery.FieldByName('R_TARIF_' + IntToStr(j) + '_VAL_APLUS').AsFloat,MeterPrecision[MID]);///FADOQuery.FieldByName('KE').AsFloat, MeterPrecision[MID]);
          WB.Cells[i,XLSP.xnSecondaryIndicationsT[j]].FillPattern:= xlPatternSolid;
          WB.Cells[i,XLSP.xnSecondaryIndicationsT[j]].FillPatternBGColorIndex:= xlColorWhite;
        end;
      end;

      if dt = 0 then begin
        dt := FADOQuery.FieldByName('R_TARIF_0_TIME_APLUS').AsDateTime;
        aData := DateToStr(dt);
      end;

      // Разница показаний
      for j := 0 to 4 do begin
        sa := WB.Cells[i,XLSP.xnSecondaryIndicationsT[j]].Value;
        sb := WB.Cells[i,XLSP.xnPrimaryIndicationsT[j]].Value;
        if (sa = 'н/д') or (sb = 'н/д') then begin
          WB.Cells[i,XLSP.xnDifferenceIndicationT[j]].Value :='н/д';
          WB.Cells[i,XLSP.xnDifferenceIndicationT[j]].FillPattern:= xlPatternSolid;
          WB.Cells[i,XLSP.xnDifferenceIndicationT[j]].FillPatternBGColorIndex:= xlColorRose;
        end else begin
          fa := WB.Cells[i,XLSP.xnSecondaryIndicationsT[j]].Value;
          fb := WB.Cells[i,XLSP.xnPrimaryIndicationsT[j]].Value;
          WB.Cells[i,XLSP.xnDifferenceIndicationT[j]].Value:= fa - fb;
          WB.Cells[i,XLSP.xnDifferenceIndicationT[j]].FillPattern:= xlPatternSolid;
          WB.Cells[i,XLSP.xnDifferenceIndicationT[j]].FillPatternBGColorIndex:= xlColorWhite;
        end;
      end;

      // Расход энергии
      for j := 0 to 4 do begin
        sa := WB.Cells[i,XLSP.xnDifferenceIndicationT[j]].Value;
        if sa = 'н/д' then begin
          WB.Cells[i,XLSP.xnPowerConsumptionT[j]].Value :='н/д';
          WB.Cells[i,XLSP.xnPowerConsumptionT[j]].FillPattern:= xlPatternSolid;
          WB.Cells[i,XLSP.xnPowerConsumptionT[j]].FillPatternBGColorIndex:= xlColorRose;
        end else begin
          fa := WB.Cells[i,XLSP.xnDifferenceIndicationT[j]].Value;
          WB.Cells[i,XLSP.xnPowerConsumptionT[j]].Value:= fa * FADOQuery.FieldByName('KE').AsFloat;
          WB.Cells[i,XLSP.xnPowerConsumptionT[j]].FillPattern:= xlPatternSolid;
          WB.Cells[i,XLSP.xnPowerConsumptionT[j]].FillPatternBGColorIndex:= xlColorWhite;
          if Loc = 5 then rpHomeBalanse.TotalPowerConsumptionT[j] := rpHomeBalanse.TotalPowerConsumptionT[j] + fa;
          if Loc = 6 then rpHomeBalanse.TotalPowerBalanceT[j] := rpHomeBalanse.TotalPowerBalanceT[j] + fa;
        end;
        end;


      FADOQuery.next;

      // вставляем строчку
      WB.Rows.InsertRows(i,1);
      WB.Rows.CopyRows(i,i+1,i+1);

      inc(i);
    end;
    WB.Rows.DeleteRows(i,i);
  End;
  CloseQry;
  Result := true;
end;

function CDBDynamicConn.SetGroupRefresh(GID,STATE:Integer;_Date:TDateTime):Boolean;
Var
    strSQL   : String;
BEgin
    strSQL := 'UPDATE QUERYGROUP SET '+
              ' DATEQUERY='  +''''+ DateToStr(_Date)+''''+ //
              ',ERRORQUERY=' + IntToStr(STATE)+
              ' WHERE ID=' + IntToStr(GID);
   Result := ExecQry(strSQL);
End;

function CDBDynamicConn.SetFabNum_SwVMID(ABOID:Integer;SDDFABNUM:String):Integer;
Var
    strSQL     : String;
    nCount,res : Integer;
BEgin
    res:=-1;
    strSQL := 'SELECT M_SWMID FROM L2TAG WHERE'+
              ' M_SWABOID ='+IntToStr(ABOID)+
              ' AND M_SDDFABNUM ='+''''+SDDFABNUM+'''';
    if OpenQry(strSQL,nCount)=True then
    Begin
    res   := FADOQuery.FieldByName('M_SWMID').AsInteger;
    End;
    CloseQry;
    Result := res;
End;

function CDBDynamicConn.setQueryGroupAbonsState(groupID,aboid,state:Integer):Boolean;
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

function CDBDynamicConn.setQueryGroupAbonsStateProg(groupID,aboid,state:Integer):Boolean;
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

function CDBDynamicConn.GetEnable(gGroup:integer;var pTable:TThreadList):Boolean;
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

function CDBDynamicConn.delQueryGroupAbons(groupID,aboid:Integer):Boolean;
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

function CDBDynamicConn.updateGQParams(groupID,qgParamID:Integer;field:String):Integer;
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

end.

