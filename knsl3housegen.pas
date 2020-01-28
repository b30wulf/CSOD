unit knsl3housegen;
interface
uses
Windows,Forms, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,Graphics,
utldatabase,knsl3indexgen,utlTimeDate,AdvProgressBar,utldynconnect,AdvOfficeStatusBar,Controls;
type
    CHouseGen = class
    private
     m_nL2I : CIndexGen;
     m_nL3I : CIndexGen;
     m_nLGI : CIndexGen;
     m_nLQSI: CIndexGen;
     m_nLQCI: CIndexGen;
     cDateTimeR : CDTRouting;
     m_nKUGID   : Integer;
     m_nNKUNBGID  : Integer;
     m_nTPUGID  : Integer;
     m_nQSID    : Integer;
     m_pL1Tbl   : SL1INITITAG;
     FsbAbon    : TAdvOfficeStatusBar;
     Fpbm_sBTIProgress : TAdvProgressBar;
     FsbAbonImport   : TAdvOfficeStatusBar;
     Fpbm_sBTIProgressImport : TAdvProgressBar;
     Fpbm_sBTIProgressImportl5 : TAdvOfficeStatusPanel;
     Fpbm_sBTIProg_Meter_Rep : TAdvProgressBar;
     m_strCurrentDir : String;
     m_nTypeList : TStringList;
    public
     procedure GenQwerySrv(var mHG:SHOUSEGEN);
     procedure InitL3(var mHG:SHOUSEGEN);
     procedure InitTree(var mHG:SHOUSEGEN);
     procedure InitTreeRef;
     procedure OnInitL1;
     procedure loadFromFile;
     function  loadHouseFromFile(pullNb:Integer;treeID:CTreeIndex;path:String):boolean;
     function  ExtractFileNameNoExt(const FileName: string): string; // Функция для удаления расширения из названия файла
     function  loadReplacementHouse(pullNb:Integer;treeID:CTreeIndex;path:String):boolean;
     function  getPullID(pullNB:Integer):Integer;
     procedure unLoadHouseFromDb(isInsert:Boolean;nAboid:Integer;path:String);
     function  loadTP(pTWID:Integer;value:CLoadEntity):SL3TP;
    private
     function  getDefaultSett(pTPID,pulID:Integer;value:CLoadEntity):SL3ABON;
     function  getDefaultTpSett(pTWID:Integer;value:CLoadEntity):SL3TP;
     function  getL2Tag(vPullID,nTPUCH,AID:Integer;mHG:CLoadEntity):SL2TAG;
     function  getL3Tag(nGID,sMID:Integer;l2Tag:SL2TAG):SL3VMETERTAG;
     function  getGroupTag(sName:String;abon:Integer):SL3GROUPTAG;
     procedure getStrings(s1:String;var value:TStringList);
     function  loadfromcsvfile(path:String;var value:TList):boolean;
     function  checkSTR(s: string) : boolean;
     procedure loadcsvfile(path:String;var value:TList);
     procedure prepare(var pD:CLoadEntity);
     procedure loadcsvfileM(path:String;var value:TList);
     procedure GenL2(var mHG:SHOUSEGEN);
     procedure GenGroup(var mHG:SHOUSEGEN);
     procedure GenL3(var mHG:SHOUSEGEN);
     procedure GenQS(var mHG:SHOUSEGEN);
     procedure GenUpload(var mHG:SHOUSEGEN);
     procedure InitL2(var mHG:SHOUSEGEN);
     //procedure InitL3(var mHG:SHOUSEGEN);
     procedure InitQS(var mHG:SHOUSEGEN);
     procedure SendQSCommEx(snAID,snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);
     function  CreateQweryserver(var mHG:SHOUSEGEN):Integer;
     procedure AddGroupNode(snGID,snSRVID:Integer;var mHG:SHOUSEGEN);
     procedure AddAbonNode(snSRVID:Integer;var mHG:SHOUSEGEN);
     procedure AddDefaultCluster(nCLSID,nSVID:Integer;var pTbl:SQWERYVM;var mHG:SHOUSEGEN);
     procedure AddDefaultClusters(var pTbl:SQWERYVM;var mHG:SHOUSEGEN);
     //procedure InitTree(var mHG:SHOUSEGEN);
     function SetL2Tag(nTPUCH,nKV:Integer;var mHG:SHOUSEGEN):Integer;
     function SetGroupTag(nTPUCH,nKV:Integer;sName:String;var mHG:SHOUSEGEN):Integer;
     function SetL3Tag(nTPUCH,nGID:Integer;var mHG:SHOUSEGEN):Integer;
     function GetRealPort(nPort:Integer):Integer;
     procedure SetProgress(nPRC:Integer;strText:String);
     procedure SetProgressIMport(nPRC:Integer;strText:String);
     procedure SetProgressMeter_Rep(nPRC:Integer;strText:String);
    protected

    public
     constructor Create;
     destructor  Destroy;override;
     procedure StartGen(mHG:SHOUSEGEN);
     procedure StartGenAbonMeter(mHG:SHouseGenMeter);
    public
     property PsbAbon           : TAdvOfficeStatusBar read FsbAbon           write FsbAbon;
     property Ppbm_sBTIProgress : TAdvProgressBar     read Fpbm_sBTIProgress write Fpbm_sBTIProgress;
     property PsbAbonImport     : TAdvOfficeStatusBar read FsbAbonImport           write FsbAbonImport;

     property Ppbm_sBTIProgressImport : TAdvProgressBar     read Fpbm_sBTIProgressImport write Fpbm_sBTIProgressImport;
     property Ppbm_sBTIProg_Meter_Rep : TAdvProgressBar     read Fpbm_sBTIProg_Meter_Rep write Fpbm_sBTIProg_Meter_Rep;


     property Ppbm_sBTIProgressImportl5 : TAdvOfficeStatusPanel  read Fpbm_sBTIProgressImportl5 write Fpbm_sBTIProgressImportl5;

    End;
implementation
uses knsl2QweryTrServer,knsl3abon, utlDB, Dialogs;

constructor CHouseGen.Create;
Begin
    m_nL2I  := CGenL2Index.Create(@m_blMeterIndex,MAX_METER);
    m_nL3I  := CGenL3Index.Create(@m_blVMeterIndex,MAX_VMETER);
    m_nLGI  := CGenGroupIndex.Create(@m_blGroupIndex,MAX_GROUP);
    m_nLQSI := CGenQSIndex.Create(@m_blQServer,MAX_QSERVER);
    m_nLQCI := CGenQCIndex.Create(@m_blQCell,MAX_QWCELL);
    cDateTimeR := CDTRouting.Create;
    m_pDB.GetL1Table(m_pL1Tbl);
End;
destructor  CHouseGen.Destroy;
Begin
    Inherited;
    m_nL2I.Destroy;
    m_nL3I.Destroy;
    m_nLGI.Destroy;
    m_nLQSI.Destroy;
    m_nLQCI.Destroy;
    cDateTimeR.Destroy;
End;
procedure CHouseGen.StartGen(mHG:SHOUSEGEN);
Var
    pDS : CMessageData;
Begin
    pDS.m_swData4 := MTR_LOCAL;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
    GenL2(mHG);    SetProgress(10,'Создание источников данных');
    GenGroup(mHG); SetProgress(20,'Создание групп');
    GenL3(mHG);    SetProgress(30,'Создание точек учета');
    GenQS(mHG);    SetProgress(40,'Создание точек опроса');
    GenUpload(mHG);SetProgress(50,'Настройка выгрузки');
    InitL2(mHG);   SetProgress(60,'Инициализация источников данных');
    //InitL3(mHG);   SetProgress(70,'Инициализация точек учета');    //AAV 27.04.2017
    //InitQS(mHG);   SetProgress(80,'Инициализация точек опроса');   //AAV 27.04.2017
    //InitTree(mHG); SetProgress(90,'Инициализация дерева объектов');//AAV 27.04.2017
                   SetProgress(100,'Генерация завершена');
End;

procedure CHouseGen.StartGenAbonMeter(mHG:SHouseGenMeter);
Var
    pDS : CMessageData;
    pKUGID: Integer;
    pMETID : Integer;
    pVMETID: Integer;
    l2Data : SL2TAG;
    l3Data : SL3VMETERTAG;
    vl     : CLoadEntity;
    pulID  :Integer;
    nKV    :integer;
    kvID   :Integer;
Begin
     kvID:=0;
     m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
     m_nTypeList := TStringList.Create;
     m_nTypeList.loadfromfile(m_strCurrentDir+'MeterType.dat');
     pulID := getPullID(mHG.m_swPortID);
     SetProgress(10,'Создание источников данных');
     SetProgress(20,'Создание групп');
     pKUGID    := m_pDB.addGroupId(getGroupTag('Квартиры',mHG.m_swABOID));  // Создает группу в доме и записывает в бд
     SetProgress(30,'Создание точек учета');
     if (mHG.m_snFirstKvartNumber<>0)and(mHG.m_snEndKvartNumber<>0) then
     for nKV:=mHG.m_snFirstKvartNumber to mHG.m_snEndKvartNumber do
    Begin
     inc(kvID);
     vl := CLoadEntity.Create;
     vl.mtID := mHG.mtid;
     vl.raycode := mHG.raycode;
     vl.nasp := mHG.nasp;
     vl.tp := mHG.tp;
     vl.gors := mHG.gors;
     vl.ulica := mHG.ulica;
     vl.dom := mHG.dom;
     vl.korp := mHG.korp;
     vl.kvar := IntToStr(kvID);
     vl.lics := mHG.lics;
     vl.fam := mHG.fam;
     vl.imya := mHG.imya;
     vl.otch := mHG.otch;
     vl.zavno := mHG.zavno;
     vl.ki := mHG.ki;
     vl.ku := mHG.ku;
     vl.typepu := mHG.typepu;
     vl.typeuspd := mHG.typeuspd;
     vl.typezvaz := mHG.typezvaz;
     vl.nomerdoz := mHG.nomerdoz;
     vl.typeabo := mHG.typeabo;
     vl.nomertu := mHG.nomertu;
     vl.field1 := mHG.field1;
     vl.field2 := mHG.field2;
     vl.field3 := mHG.field3;
     vl.field4 := mHG.field4;
     vl.field5 := mHG.field5;
     vl.field6 := mHG.field6;
     vl.field7 := mHG.field7;
     vl.idchannel:= mHG.idchannel;
     vl.idtariff := mHG.idtariff;
     vl.house    := mHG.house;
     vl.kv       := mHG.kv;


     l2Data    := getL2Tag(pulID,UTP_KU,mHG.m_swABOID,vl);
     pMETID    := m_pDB.addMeterId(l2Data);
     m_pDB.InsertCommand(pMETID,l2Data.m_sbyType);

     l3Data    := getL3Tag(pKUGID,pMETID,l2Data);
     pVMETID   := m_pDB.addVMeterId(l3Data);
     m_pDB.InsertVParams(l3Data.m_sbyType,pVMETID);     //AAV 27.04.2017
    // if (nKV=(mHG.m_snEndKvartNumber div 2)) then
     SetProgress(30+(nKV*60 div mHG.m_snEndKvartNumber),'Инициализация точки учета '+IntToStr(nKV));   //AAV 27.04.2017
     vl.Destroy;
     end;
     if (mHG.m_snBalanseNumber<>0) then
     for nKV:=0 to mHG.m_snBalanseNumber-1 do
    Begin
     inc(kvID);
     vl := CLoadEntity.Create;
     vl.mtID := mHG.mtid;
     vl.raycode := mHG.raycode;
     vl.nasp := mHG.nasp;
     vl.tp := mHG.tp;
     vl.gors := mHG.gors;
     vl.ulica := mHG.ulica;
     vl.dom := mHG.dom;
     vl.korp := mHG.korp;
     vl.kvar := IntToStr(kvID);
     vl.lics := mHG.lics;
     vl.fam := mHG.fam;
     vl.imya := mHG.imya;
     vl.otch := mHG.otch;
     vl.zavno := mHG.zavno;
     vl.ki := mHG.ki;
     vl.ku := mHG.ku;
     vl.typepu := mHG.typepu;
     vl.typeuspd := mHG.typeuspd;
     vl.typezvaz := mHG.typezvaz;
     vl.nomerdoz := mHG.nomerdoz;
     vl.typeabo := '6';
     vl.nomertu := mHG.nomertu;
     vl.field1 := mHG.field1;
     vl.field2 := mHG.field2;
     vl.field3 := mHG.field3;
     vl.field4 := mHG.field4;
     vl.field5 := mHG.field5;
     vl.field6 := mHG.field6;
     vl.field7 := mHG.field7;
     vl.idchannel:= mHG.idchannel;
     vl.idtariff := mHG.idtariff;
     vl.house    := mHG.house;
     vl.kv       := mHG.kv;


     l2Data    := getL2Tag(pulID,UTP_KUB,mHG.m_swABOID,vl);
     pMETID    := m_pDB.addMeterId(l2Data);
     m_pDB.InsertCommand(pMETID,l2Data.m_sbyType);

     l3Data    := getL3Tag(pKUGID,pMETID,l2Data);
     pVMETID   := m_pDB.addVMeterId(l3Data);
     m_pDB.InsertVParams(l3Data.m_sbyType,pVMETID);     //AAV 27.04.2017
    // if (nKV=(mHG.m_snEndKvartNumber div 2)) then
     SetProgress(30+(nKV*60 div mHG.m_snEndKvartNumber),'Инициализация точки учета '+IntToStr(nKV));   //AAV 27.04.2017
     vl.Destroy;
     end;

    if (mHG.m_snNoBalanseNumber<>0) then
     for nKV:=0 to mHG.m_snNoBalanseNumber-1 do
    Begin
     inc(kvID);
     vl := CLoadEntity.Create;
     vl.mtID := mHG.mtid;
     vl.raycode := mHG.raycode;
     vl.nasp := mHG.nasp;
     vl.tp := mHG.tp;
     vl.gors := mHG.gors;
     vl.ulica := mHG.ulica;
     vl.dom := mHG.dom;
     vl.korp := mHG.korp;
     vl.kvar := IntToStr(kvID);
     vl.lics := mHG.lics;
     vl.fam := mHG.fam;
     vl.imya := mHG.imya;
     vl.otch := mHG.otch;
     vl.zavno := mHG.zavno;
     vl.ki := mHG.ki;
     vl.ku := mHG.ku;
     vl.typepu := mHG.typepu;
     vl.typeuspd := mHG.typeuspd;
     vl.typezvaz := mHG.typezvaz;
     vl.nomerdoz := mHG.nomerdoz;
     vl.typeabo := '7';
     vl.nomertu := mHG.nomertu;
     vl.field1 := mHG.field1;
     vl.field2 := mHG.field2;
     vl.field3 := mHG.field3;
     vl.field4 := mHG.field4;
     vl.field5 := mHG.field5;
     vl.field6 := mHG.field6;
     vl.field7 := mHG.field7;
     vl.idchannel:= mHG.idchannel;
     vl.idtariff := mHG.idtariff;
     vl.house    := mHG.house;
     vl.kv       := mHG.kv;


     l2Data    := getL2Tag(pulID,UTP_NKUB,mHG.m_swABOID,vl);
     pMETID    := m_pDB.addMeterId(l2Data);
     m_pDB.InsertCommand(pMETID,l2Data.m_sbyType);

     l3Data    := getL3Tag(pKUGID,pMETID,l2Data);
     pVMETID   := m_pDB.addVMeterId(l3Data);
     m_pDB.InsertVParams(l3Data.m_sbyType,pVMETID);     //AAV 27.04.2017
    // if (nKV=(mHG.m_snEndKvartNumber div 2)) then
     SetProgress(30+(nKV*60 div mHG.m_snEndKvartNumber),'Инициализация точки учета '+IntToStr(nKV));   //AAV 27.04.2017
     vl.Destroy;
     end;

    if (mHG.m_snNoNoBalanseNumber<>0) then
     for nKV:=0 to mHG.m_snNoNoBalanseNumber-1 do
    Begin
     inc(kvID);
     vl := CLoadEntity.Create;
     vl.mtID := mHG.mtid;
     vl.raycode := mHG.raycode;
     vl.nasp := mHG.nasp;
     vl.tp := mHG.tp;
     vl.gors := mHG.gors;
     vl.ulica := mHG.ulica;
     vl.dom := mHG.dom;
     vl.korp := mHG.korp;
     vl.kvar := IntToStr(kvID);
     vl.lics := mHG.lics;
     vl.fam := mHG.fam;
     vl.imya := mHG.imya;
     vl.otch := mHG.otch;
     vl.zavno := mHG.zavno;
     vl.ki := mHG.ki;
     vl.ku := mHG.ku;
     vl.typepu := mHG.typepu;
     vl.typeuspd := mHG.typeuspd;
     vl.typezvaz := mHG.typezvaz;
     vl.nomerdoz := mHG.nomerdoz;
     vl.typeabo := '8';
     vl.nomertu := mHG.nomertu;
     vl.field1 := mHG.field1;
     vl.field2 := mHG.field2;
     vl.field3 := mHG.field3;
     vl.field4 := mHG.field4;
     vl.field5 := mHG.field5;
     vl.field6 := mHG.field6;
     vl.field7 := mHG.field7;
     vl.idchannel:= mHG.idchannel;
     vl.idtariff := mHG.idtariff;
     vl.house    := mHG.house;
     vl.kv       := mHG.kv;


     l2Data    := getL2Tag(pulID,UTP_NKUNB,mHG.m_swABOID,vl);
     pMETID    := m_pDB.addMeterId(l2Data);
     m_pDB.InsertCommand(pMETID,l2Data.m_sbyType);

     l3Data    := getL3Tag(pKUGID,pMETID,l2Data);
     pVMETID   := m_pDB.addVMeterId(l3Data);
     m_pDB.InsertVParams(l3Data.m_sbyType,pVMETID);     //AAV 27.04.2017
    // if (nKV=(mHG.m_snEndKvartNumber div 2)) then
     SetProgress(30+(nKV*60 div mHG.m_snEndKvartNumber),'Инициализация точки учета '+IntToStr(nKV));   //AAV 27.04.2017
     vl.Destroy;
     end;

     SetProgress(100,'Готово. Сгенерировано '+IntToStr(mHG.m_snEndKvartNumber+mHG.m_snBalanseNumber+mHG.m_snNoBalanseNumber+mHG.m_snNoNoBalanseNumber)+' точек учета');   //AAV 27.04.2017

End;


procedure CHouseGen.unLoadHouseFromDb(isInsert:Boolean;nAboid:Integer;path:String);
Var
    mPidFile : TextFile;
    pDb      : CDBDynamicConn;
    vList    : TThreadList;
    mList    : TList;
    pD       : CLoadEntity;
    i        : Integer;
    strLine,strID : String;
Begin
    pDb := m_pDB.getConnection;
    vList := TThreadList.Create;
    try
    if pDb.getAbonInfo(nAboid,vList) then
    Begin
     mList := vList.LockList;
     AssignFile(mPidFile,path);
     Rewrite(mPidFile);

     strLine := '1.id абонента;'+
    '2.Код района;'+
    '3.Название населенного пункта;'+
    '4.ТП;'+
    '5.Город\село;'+
    '6.Улица;'+
    '7.Дом;'+
    '8.Корпус;'+
    '9.Квартира;'+
    '10.Лицевой счет;'+
    '11.Фамилия;'+
    '12.Имя;'+
    '13.Отчество;'+
    '14.Заводской номер счетчика;'+
    '15.K;'+
    '16.Тип счетчика;'+
    '17.Тип УСПД;'+
    '18.Тип связи с ИЦ;'+
    '19.номер для дозвона к УСПД;'+
    '20.тип абонента;'+
    '21.Количество точек учета;'+
    '22.Поле 1;'+
    '23.Поле 2;'+
    '24.Поле 3;'+
    '25.Поле 4;'+
    '26.Поле 5;'+
    '27.Поле 6;'+
    '28.Поле 7;'+
    '29.Канал;'+
    '30.Тариф;'+
    '31.Дом;'+
    '32.Кв;';
    WriteLn(mPidFile,strLine);
     for i:=0 to mList.Count-1 do
     Begin
      pD := mList[i];
      strID := IntToStr(pD.mtid);
      if isInsert=true then strID := '';
      strLine := strID+';'+
                       pD.rayCode+';'+
                       pD.nasp+';'+
                       pD.tp+';'+
                       pD.gors+';'+
                       pD.ulica+';'+
                       pD.dom+';'+
                       pD.korp+';'+
                       pD.kvar+';'+
                       pD.lics+';'+
                       pD.fam+';'+
                       pD.imya+';'+
                       pD.otch+';'+
                       pD.zavno+';'+
                       FloatToStr(pD.ki)+';'+
                       //FloatToStr(pD.ku)+';'+
                       pD.typepu+';'+
                       pD.typeuspd+';'+
                       pD.typezvaz+';'+
                       '['+pD.nomerdoz+']'+';'+
                       pD.typeabo+';'+
                       pD.nomertu+';'+
                       '['+pD.field1+']'+';'+
                       '['+pD.field2+']'+';'+
                       '['+pD.field3+']'+';'+
                       '['+pD.field4+']'+';'+
                       '['+pD.field5+']'+';'+
                       '['+pD.field6+']'+';'+
                       '['+pD.field7+']'+';'+
                        pD.idchannel+';'+
                        pD.idtariff+';'+
                        pD.house+';'+
                        pD.kv+';';
       WriteLn(mPidFile,strLine);
     End;
     CloseFile(mPidFile);
    End;
    finally
//     vList.UnLockList;
     mList := vList.LockList;
     for i:=0 to mList.Count-1 do
     begin
       pD := mList[i];
       if pD<>nil then FreeAndNil(pD);
     end;
     vList.Clear;
     vList.UnLockList;
     if vList<>Nil then FreeAndNil(vList);
//     vList.Destroy;//протестировать
    m_pDB.DiscDynConnect(pDb);// pDb.Disconnect;
    end;
End;

function CHouseGen.getPullID(pullNB:Integer):Integer;
Var
    pDb        : CDBDynamicConn;
    pullConfig : TThreadList;
    vList      : TList;
    pl         : CL2Pulls;
    i          : integer;
begin
    pullConfig := TThreadList.Create;
    try
    Result := 0;
    pDb  := m_pDB.getConnection;
    pDb.getPulls(pullConfig);
    vList := pullConfig.LockList;
    for i:=0 to vList.count-1 do
    Begin
     pl := vList[i];
     if i=pullNB then
     Begin
      Result := pl.id;
      exit;
     End;
    End;
    finally
     pullConfig.UnLockList;
     ClearListAndFree(pullConfig);
     pDb.Disconnect;
    End;
end;
function CHouseGen.loadHouseFromFile(pullNb:Integer;treeID:CTreeIndex;path:String):boolean;
Var
    slB : TList;
    i   : Integer;
    pD  : CLoadEntity;
    pTW : SL3TOWN;
    pST : SL3STREET;
    pRGID : Integer;
    pDPID : Integer;
    pTWID : Integer;
    pSTID : Integer;
    pAID  : Integer;
    pTPID : Integer;
    pKUGID: Integer;
    pMETID : Integer;
    pVMETID: Integer;
    l2Data : SL2TAG;
    l3Data : SL3VMETERTAG;
    pulID  : Integer;
    BolCheck:boolean;
    strFile :string;
    CheckSt:Integer;
    strSQL : string;
    nCount : Integer;    
Begin
    Result:=true;
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    m_nTypeList := TStringList.Create;
    m_nTypeList.loadfromfile(m_strCurrentDir+'MeterType.dat');
    slB := TList.Create;
    BolCheck:=loadfromcsvfile(path,slB);
    if (BolCheck<>true)then
    begin
    if (Fpbm_sBTIProgressImport<>nil) then Fpbm_sBTIProgressImport.Level3Color  := clRed;
    if (Fpbm_sBTIProgressImport<>nil) then Fpbm_sBTIProgressImport.Level3ColorTo:= $0045FF;
    SetProgressIMport(100,'Ошибка. Сгенерировано 0 точек учета');   //AAV 27.04.2017
    Result:=false;
    exit;
    end;
    strFile:= ExtractFileNameNoExt(ExtractFileName(path));  // извлекаем название файла и удаляем расширение
    // Проверяем в L1Tag каналы и добавляем пулы и связываем, иначе извлекаем чисто пул
    pD := slB[0];
    strSQL := 'SELECT COUNT(M_SBYPORTID) as CNT FROM L1TAG WHERE M_SBYTYPE  = 3 ' +
              '  AND M_SCHIPADDR = ' + '''' + pD.nomerdoz + '''' +
              '  AND M_SWIPPORT = ' + '''' + pD.field5 + '''';

    if utlDB.DBase.OpenQry(strSQL, nCount) = True then begin
      if utlDB.DBase.IBQuery.FieldByName('CNT').AsInteger > 0 then begin
        if (MessageDlg('С IP адресом: ' + pD.nomerdoz + ' и портом: ' + pD.field5 + ' уже существует подключение.' + #13#10 +
               'Вы уверены, что импортируется запись именно с указанным IP адресом?' , mtInformation ,[mbYes, mbNo],0)= mrNo) then
        Exit;
      end;
    end;

    CheckSt:=m_pDB.GetPulls_L1(pD.nomerdoz,pD.field5,strFile,StrToInt(pD.typezvaz),pulID);
    if CheckSt=1 then
     begin
      OnInitL1;
      mQServer.InitPUL(m_pDB.CreateConnect);   //здесь я иничу занаво
     end;

    for i:=0 to slB.Count-1 do
    Begin
     Application.ProcessMessages;
     pD := slB[i];
     pTW.m_swDepID  := m_pDB.CheckDepId(StrToInt(pD.raycode),pD.mesID);
     if (pTW.m_swDepID=-1)then
     begin
        if (Fpbm_sBTIProgressImport<>nil) then Fpbm_sBTIProgressImport.Level3Color  := clRed;
        if (Fpbm_sBTIProgressImport<>nil) then Fpbm_sBTIProgressImport.Level3ColorTo:= $0045FF;
         SetProgressIMport(100,'Ошибка. Точки не сгенерированы. Отсутствует регион');   //AAV 27.04.2017
         //TKnsForm.msbStatBar.Panels[0].Progress.Position:=100;
          if Fpbm_sBTIProgressImportl5<>nil then Fpbm_sBTIProgressImportl5.Progress.Position:=100;
        exit;
     end
     else
      begin
         if (Fpbm_sBTIProgressImport<>nil) then Fpbm_sBTIProgressImport.Level3Color  := clLime;
         if (Fpbm_sBTIProgressImport<>nil) then Fpbm_sBTIProgressImport.Level3ColorTo:=$00E1FFE1;
      end;

     pTW.m_sName    := pD.nasp;       //Могилев
     pTW.m_swTownID := -1;
     pTWID := m_pDB.addTownId(pTW);
     pD.resID   := pTW.m_swDepID;
     pD.naspID  := pTWID;

     pST.m_swTownID  := pTWID;              // BO 11.06.19
     pST.m_sName    := pD.ulica;
     pST.m_swStreetID :=- 1;
     pTPID     := m_pDB.addTpId(getDefaultTpSett(pTWID,pD));       //Создает ТП и записывает в бд
     pST.m_swTPID := pTPID;               // BO 11.06.19
     pSTID := m_pDB.addStreetId(pST);

     pD.ulicaID := pSTID;

     //pTPID
     pTPID     := m_pDB.addTpId(getDefaultTpSett(pTWID,pD));       //Создает ТП и записывает в бд
     pAID      := m_pDB.addAbonId(getDefaultSett(pTPID,pulID,pD)); // Создает дом в группе и записывает в бд

     pKUGID    := m_pDB.addGroupId(getGroupTag('Квартиры',pAID));  // Создает счетчики в доме и записывает в бд

     l2Data    := getL2Tag(pulID,UTP_KU,pAID,pD);
     pMETID    := m_pDB.addMeterId(l2Data);
     m_pDB.InsertCommand(pMETID,l2Data.m_sbyType);

     if (l2Data.m_sbyType=41) or (l2Data.m_sbyType=52) or (l2Data.m_sbyType=38) then
     m_pDB.InsertCommandUSPD164Profile(pMETID,StrToInt(pD.kvar)-1);

     if (l2Data.m_sbyType=54) then
     m_pDB.InsertCommandUSPD164v4Profile(pMETID,StrToInt(pD.kvar)-1);

     l3Data    := getL3Tag(pKUGID,pMETID,l2Data);
     pVMETID   := m_pDB.addVMeterId(l3Data);
     m_pDB.InsertVParams(l3Data.m_sbyType,pVMETID);     //AAV 27.04.2017
     SetProgressIMport(0+((i+1)*98 div slB.Count-1),'Инициализация точки учета '+IntToStr(i+1));   //AAV 27.04.2017
     if Fpbm_sBTIProgressImportl5<>nil then Fpbm_sBTIProgressImportl5.Progress.Position:=0+((i+1)*98 div slB.Count-1);;
     FreeAndNil(pD);
    End;

    SetProgressIMport(100,'Готово. Сгенерировано '+IntToStr(slB.Count)+' точек учета');   //AAV 27.04.2017
    if Ppbm_sBTIProgressImportl5<>nil then Ppbm_sBTIProgressImportl5.Progress.Position:=100;

    m_nTypeList.Clear;
    FreeAndNil(m_nTypeList);

    slB.Clear;
    FreeAndNil(slB);
End;

function CHouseGen.ExtractFileNameNoExt(const FileName: string): string;
var
  FEx: string;
begin
  Result:= ExtractFileName(FileName);
  FEx:= ExtractFileExt(FileName);
  Delete(Result,pos(FEx,Result),Length(FEx));
end;

function CHouseGen.loadReplacementHouse(pullNb:Integer;treeID:CTreeIndex;path:String):boolean;
Var
    slB : TList;
    slK : TList;
    slM : TList;
    i   : Integer;
    pD  : CLoadEntity;
    pDb : CDBDynamicConn;
    pRG : SL3REGION;
    pDP : SL3DEPARTAMENT;
    pTW : SL3TOWN;
    pST : SL3STREET;
    pRGID : Integer;
    pDPID : Integer;
    pTWID : Integer;
    pSTID : Integer;
    pAID  : Integer;
    pTPID : Integer;
    pKUGID: Integer;
    pNKUNBGID: Integer;
    pTPUGID: Integer;
    pMETID : Integer;
    pVMETID: Integer;
    cList  : TList;
    metType : Integer;
    l2Data : SL2TAG;
    l3Data : SL3VMETERTAG;
    nMeterType,pulID : Integer;
    regid,depid,towid,streid:Integer;
    AddressC : string;
    FIOC     : string;

    BolCheck:boolean;
    strFile :string;
    CheckSt:Integer;
    
    strSQL : string;
    nCount : Integer;
Begin
    pulID := getPullID(pullNb);
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    m_nTypeList := TStringList.Create;
    m_nTypeList.loadfromfile(m_strCurrentDir+'MeterType.dat');
    slB := TList.Create;
    //loadfromcsvfile(path,slB);

    BolCheck:=loadfromcsvfile(path,slB);
    if (BolCheck<>true)then
    begin
    if (Fpbm_sBTIProgressImport<>nil) then Fpbm_sBTIProgressImport.Level3Color  := clRed;
    if (Fpbm_sBTIProgressImport<>nil) then Fpbm_sBTIProgressImport.Level3ColorTo:= $0045FF;
    SetProgressIMport(100,'Ошибка. Сгенерировано 0 точек учета');   //AAV 27.04.2017
    Result:=false;
    exit;
    end;
    strFile:= ExtractFileNameNoExt(ExtractFileName(path));  // извлекаем название файла и удаляем расширение
    // Проверяем в L1Tag каналы и добавляем пулы и связываем, иначе извлекаем чисто пул
    pD := slB[0];

    strSQL := 'SELECT COUNT(M_SBYPORTID) as CNT FROM L1TAG WHERE M_SBYTYPE  = 3 ' +
              '  AND M_SCHIPADDR = ' + '''' + pD.nomerdoz + '''' +
              '  AND M_SWIPPORT = ' + '''' + pD.field5 + '''';

    if utlDB.DBase.OpenQry(strSQL, nCount) = True then begin
      if utlDB.DBase.IBQuery.FieldByName('CNT').AsInteger > 0 then begin
        if (MessageDlg('С IP адресом: ' + pD.nomerdoz + ' и портом: ' + pD.field5 + ' уже существует подключение.' + #13#10 +
               'Вы уверены, что импортируется запись именно с указанным IP адресом?' , mtInformation ,[mbYes, mbNo],0)= mrNo) then
        Exit;
      end;
    end;

    CheckSt:=m_pDB.GetPulls_L1(pD.nomerdoz,pD.field5,strFile,StrToInt(pD.typezvaz),pulID);
     if CheckSt=1 then
     begin
      OnInitL1;
      mQServer.InitPUL(m_pDB.CreateConnect);   //здесь я иничу занаво
     end;

    for i:=0 to slB.Count-1 do
    Begin
     Application.ProcessMessages;
     pD := slB[i];
     pTW.m_swDepID  := m_pDB.CheckDepId(StrToInt(pD.raycode),pD.mesID);
     if (pTW.m_swDepID=-1)then
     begin
         Fpbm_sBTIProg_Meter_Rep.Level3Color  := clRed;
         Fpbm_sBTIProg_Meter_Rep.Level3ColorTo:= $0045FF;
         SetProgressIMport(100,'Ошибка. Точки не сгенерированы. Отсутствует регион');   //AAV 27.04.2017
        exit;
     end
     else
      begin
         Fpbm_sBTIProg_Meter_Rep.Level3Color  := clLime;
         Fpbm_sBTIProg_Meter_Rep.Level3ColorTo:=$00E1FFE1;
      end;

     pTW.m_sName    := pD.nasp;       //Могилев
     pTW.m_swTownID := -1;
     pTWID := m_pDB.addTownId(pTW);

     pST.m_swTownID  := pTWID;
     pST.m_sName    := pD.ulica;
     pST.m_swStreetID := -1;
     pSTID := m_pDB.addStreetId(pST);

     pD.resID   := pTW.m_swDepID;
     pD.naspID  := pTWID;
     pD.ulicaID := pSTID;

     pTPID     := m_pDB.addTpId(getDefaultTpSett(pTWID,pD));       //Создает ТП и записывает в бд
     pAID      := m_pDB.addAbonId(getDefaultSett(pTPID,pulID,pD)); // Создает дом в группе и записывает в бд

     pKUGID    := m_pDB.addGroupId(getGroupTag('Квартиры',pAID));  // Создает счетчики в доме и записывает в бд

     AddressC := pD.raycode + ', ' + IntToStr(pD.naspID) + ', ' + IntToStr(pD.ulicaID) + ', ' + pD.dom + ', ' + pD.korp +  ', ' + pD.kvar;
     FIOC     := pD.fam + ' ' + pD.imya + ' ' + pD.otch;

   //  m_schName      := '(Кв №'+mHG.kvar+'/Лс №'+mHG.lics+')'+mHG.fam+' '+mHG.imya+' '+mHG.otch;
                                                      
     l2Data    := getL2Tag(pulID,UTP_KU,pAID,pD);
     pMETID    := m_pDB.addMeterId2(AddressC, FIOC, l2Data);
     m_pDB.InsertCommand(pMETID,l2Data.m_sbyType);

     if (l2Data.m_sbyType=41) or (l2Data.m_sbyType=52) or (l2Data.m_sbyType=38) then
     m_pDB.InsertCommandUSPD164Profile(pMETID,StrToInt(pD.kvar)-1);
     l3Data    := getL3Tag(pKUGID,pMETID,l2Data);
     pVMETID   := m_pDB.addVMeterId(l3Data);
     m_pDB.InsertVParams(l3Data.m_sbyType,pVMETID);     //AAV 27.04.2017
     SetProgressMeter_Rep(0+((i+1)*98 div slB.Count-1),'Замена точки учета '+IntToStr(i+1));   //AAV 27.04.2017
    End;
    m_nTypeList.Destroy;
    SetProgressMeter_Rep(100,'Готово. Замена завершена '+IntToStr(slB.Count)+' точек учета');   //AAV 27.04.2017
    slB.Destroy;
End;

procedure CHouseGen.loadFromFile;
Var
    slB : TList;
    slK : TList;
    slM : TList;
    i   : Integer;
    pD  : CLoadEntity;
    pRG : SL3REGION;
    pDP : SL3DEPARTAMENT;
    pTW : SL3TOWN;
    pST : SL3STREET;
    pRGID : Integer;
    pDPID : Integer;
    pTWID : Integer;
    pSTID : Integer;
    pAID  : Integer;
    pKUGID: Integer;
    pNKUNBGID: Integer;
    pTPUGID: Integer;
    pMETID : Integer;
    pVMETID: Integer;
    cList  : TList;
    metType : Integer;
    l2Data : SL2TAG;
    l3Data : SL3VMETERTAG;
    nMeterType : Integer;
Begin
    {
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    m_nTypeList := TStringList.Create;
    m_nTypeList.loadfromfile(m_strCurrentDir+'MeterType.dat');
    metType := m_nTypeList.IndexOf('MET_EA8086');
    metType := metType +1;


    slB := TList.Create;
    slK := TList.Create;
    slM := TList.Create;
    loadcsvfile('D:\Kon2\ImportConfig\Бобруйские ЭС.csv',slB);
    loadcsvfile('D:\Kon2\ImportConfig\Климовичские ЭС.csv',slK);
    loadcsvfileM('D:\Kon2\ImportConfig\Могилевские ЭС.csv',slM);
    m_pDB.ExecQry('delete from MGCONFIG;');
    for i:=0 to slB.Count-1 do
    Begin
     pD := CLoadEntity(slB[i]);
     pD.mes := 'Бобруйские ЭС';
     m_pDB.AddMConfig(pd);
    End;
    for i:=0 to slK.Count-1 do
    Begin
     pD := CLoadEntity(slK[i]);
     pD.mes := 'Климовичские ЭС';
     m_pDB.AddMConfig(pd);
    End;
    for i:=0 to slM.Count-1 do
    Begin
     pD := CLoadEntity(slM[i]);
     pD.mes := 'Могилевские ЭС';
     m_pDB.AddMConfig(pd);
    End;

    m_pDB.ExecQry('delete from L2TAG;');
    m_pDB.ExecQry('delete from SL3ABON;');
    m_pDB.ExecQry('delete from SL3REGION;');
    }
    //nMeterType := m_nTypeList.IndexOf('MET_USPD16401B');
    //MET_USPD16401B
    //MET_USPD16401B
    //nMeterType := nMeterType +1;
    cList := TList.Create;
    m_pDB.getMConfig(0,50000,cList);




    for i:=0 to cList.Count-1 do
    Begin
     //if (i>=0) and (i<=(50000)) then
     //Begin

     pD := CLoadEntity(cList[i]);

     pRG.m_nRegNM    := pD.mes;
     pRG.m_sKSP      := '8005';
     pRG.m_sbyEnable := 1;
     pRG.m_nRegionID := -1;
     pRGID := m_pDB.addRegionId(pRG);

     pDP.m_swRegion := pRGID;
     pDP.m_sName    := pD.res;
     pDP.m_swDepID  := -1;
     pDPID := m_pDB.addDepartamentId(pDP);

     pTW.m_swDepID  := pDPID;
     pTW.m_sName    := pD.nasp;
     pTW.m_swTownID := -1;
     pTWID := m_pDB.addTownId(pTW);

     pST.m_swTownID  := pTWID;
     pST.m_sName    := pD.ulica;
     pST.m_swStreetID :=- 1;
     pSTID := m_pDB.addStreetId(pST);

     pD.mesID   := pRGID;
     pD.resID   := pDPID;
     pD.naspID  := pTWID;
     pD.ulicaID := pSTID;

     pAID      := m_pDB.addAbonId(getDefaultSett(0,0,pD));
     pKUGID    := m_pDB.addGroupId(getGroupTag('Квартиры',pAID));
     //pNKUNBGID := m_pDB.addGroupId(getGroupTag('Собственные нужды',pAID));
     //pTPUGID   := m_pDB.addGroupId(getGroupTag('Тепловой учет',pAID));

     l2Data    := getL2Tag(0,UTP_KU,pAID,pD);
     pMETID    := m_pDB.addMeterId(l2Data);
     m_pDB.InsertCommand(pMETID,l2Data.m_sbyType);

     l3Data    := getL3Tag(pKUGID,pMETID,l2Data);
     pVMETID   := m_pDB.addVMeterId(l3Data);
     m_pDB.InsertVParams(l3Data.m_sbyType,pVMETID);     //AAV 27.04.2017
     //End;
    End;
    

End;

function CHouseGen.getGroupTag(sName:String;abon:Integer):SL3GROUPTAG;
Var
    pTbl : SL3GROUPTAG;
Begin
    pTbl.m_swABOID       := abon;
    pTbl.m_sbyGroupID    := -1;
    pTbl.M_NGROUPLV      := 0;
    pTbl.m_swPosition    := 0;
    pTbl.m_sGroupName    := sName;
    pTbl.m_sGroupExpress := '[x]';
    pTbl.m_swPLID        := 0;
    pTbl.m_sbyEnable     := 1;
    Result := pTbl;
End;

function CHouseGen.getDefaultSett(pTPID,pulID:Integer;value:CLoadEntity):SL3ABON;
Var
      pTable : SL3ABON;
Begin
      with pTable do
      Begin
      m_swABOID       := -1;
      m_swPortID      := pulID;
      m_sdtRegDate    := Now;
      m_sName         := 'Дом №:'+value.dom+'/'+value.korp;
      m_sObject       := value.ulica;
      m_nRegionID     := value.mesID;
      M_SWDEPID       := value.resID;
      M_SWSTREETID    := value.ulicaID;
      M_SWTOWNID      := value.naspID;
      TPID            := pTPID;
      m_sKSP          := '80002';
      m_sDogNum       := 'Договор/'+value.dom;
      m_sPhone        := '8-017-230-22-33';
      m_sAddress      := value.ulica;
      m_sEAddress     := 'http:\\www.a2000.by';
      m_sShemaPath    := 'C:\a2000\ascue\shema.jpg';
      m_sComment      := 'Комментарий';
      m_sTelRing      := value.nomerdoz;
      m_sMaxPower     := 0;
      m_sbyEnable     := 1;
      m_sbyVisible    := 1;
      m_nAbonType     := 1;
      m_sRevPhone     := ' ';
      m_sReportVS     := 63;
      m_sLIC          := 'Счет №';
      m_strOBJCODE    := '';
      m_sTreeSettings := 51;
      M_SMARSHNUMBER  := '1000';
      M_SHOUSENUMBER  := value.dom;
      M_SKORPUSNUMBER := value.korp;
      gors            := value.gors;
      End;
      Result := pTable;
End;

function CHouseGen.loadTP(pTWID:Integer;value:CLoadEntity):SL3TP;
begin
  Result:=getDefaultTpSett(pTWID,value);
end;
function CHouseGen.getDefaultTpSett(pTWID:Integer;value:CLoadEntity):SL3TP;
Var
      pTable : SL3TP;
Begin
      pTable.ID         := -1;
      pTable.M_SWTOWNID := pTWID;
      pTable.NAME       := value.tp;
      pTable.TPTYPE     := 0;
      //if(value.tp<>'') then pTable.TPTYPE := 0;
      Result := pTable;
End;

function CHouseGen.getL3Tag(nGID,sMID:Integer;l2Tag:SL2TAG):SL3VMETERTAG;
Var
    pTbl3 : SL3VMETERTAG;
Begin
    pTbl3.m_swMID       := sMID;
    pTbl3.m_swVMID      := -1;
    pTbl3.m_sbyPortID   := 0;
    pTbl3.m_sbyType     := l2Tag.m_sbyType;
    pTbl3.m_sbyGroupID  := nGID;
    //pTbl3.m_swVMID      := m_nL3I.GenIndexSv;
    pTbl3.m_sddPHAddres := l2Tag.m_sddPHAddres;
    pTbl3.m_sMeterName  := l2Tag.m_schName;
    pTbl3.m_sMeterCode  := l2Tag.m_sTpNum;
    pTbl3.m_sVMeterName := l2Tag.m_schName;
    pTbl3.m_sbyExport   := 1;
    pTbl3.m_swPLID      := 0;
    pTbl3.m_sbyEnable   := 1;
    Result := pTbl3;
    //m_pDB.AddVMeterTable(pTbl3);
    //m_pDB.InsertVParams(pTbl3.m_sbyType,pTbl3.m_swVMID);     //AAV 27.04.2017
End;

function CHouseGen.getL2Tag(vPullID,nTPUCH,AID:Integer;mHG:CLoadEntity):SL2TAG;
Var
     pTbl : SL2TAG;
     sMK,sName : String;
     nMeterType,byModem,byEnable,byLocation : Integer;
Begin
//     byLocation := 5;
     byLocation :=  nTPUCH;
     with pTbl do Begin
     M_SWABOID      := AID;
     m_sbyGroupID   := 0;
     m_swVMID       := 0;
     m_sbyPortID    := 0;
     m_swMID        := -1;
     try
      if not((mHG.typeuspd='EMPTY') or (mHG.typeuspd='ROWALANT')) then
       nMeterType := m_nTypeList.IndexOf(mHG.typeuspd)
      else
       nMeterType := m_nTypeList.IndexOf(mHG.typepu);
       m_sbyType  := nMeterType;
      except
       m_sbyType := 32;
      end;

     if(nMeterType=-1) then m_sbyType := 32;
     pullid         := vPullID;
     typepu         := m_nTypeList.IndexOf(mHG.typepu);
     if typepu=-1 then typepu := 32;
     m_swmid        := mHG.mtID;
     typezvaz       := mHG.typezvaz;
     typeabo        := mHG.typeabo;
     m_sbyLocation  := StrToInt(mHG.typeabo);
     m_sddFabNum    := mHG.zavno;
     m_sddPHAddres  := mHG.kvar;
     m_schPassword  := '0';
     m_schName      := '(Кв №'+mHG.kvar+'/Лс №'+mHG.lics+')'+mHG.fam+' '+mHG.imya+' '+mHG.otch;
     m_sbyRepMsg    := 3;
     m_swRepTime    := 7;
     m_sfKI         := mHG.ki;
     m_sfKU         := mHG.ku;
     m_sfMeterKoeff := 1;
     m_sdtSumKor    := cDateTimeR.SecToDateTime(0);
     m_sdtLimKor    := cDateTimeR.SecToDateTime(1800);
     m_sdtPhLimKor  := cDateTimeR.SecToDateTime(1800);
     m_sbyPrecision := 3;
     m_swCurrQryTm  := 40;
     m_sbyTSlice    := 0;
     m_sPhone       := mHG.nomerdoz;
     m_sbyModem     := StrToInt(mHG.typezvaz);//1; //Если 0 то не использовать модем, 1 модемная связь
     m_sbyEnable    := 1;
     if (mHG.idchannel<>'') then     m_aid_channel := StrToInt(mHG.idchannel) else m_aid_channel:=0;
     if (mHG.idtariff<>'') then      m_aid_tariff  := StrToInt(mHG.idtariff) else m_aid_tariff:=0;

       m_sddHOUSE:=mHG.house;
       m_sddKV:= mHG.kv;

     //if nMeterType=MET_SUMM then Begin m_sbyModem:=0;m_sbyEnable:=0;End;
     //if (m_sbyType=MET_EA8086) or (m_sbyType=MET_USPD16401B) or (m_sbyType=MET_SS301F3)or (m_sbyType=MET_USPDSSDU) or (m_sbyType=MET_USPDKUB)
     //or(m_sbyType=MET_A2000by) then
     //Begin
      //00001;00001;$000000;;;;;;14.08.2017;
      m_sAdvDiscL2Tag:= mHG.field1+';'+mHG.field2+';'+mHG.field3+';'+mHG.field4+';'+mHG.field5+';'+mHG.field6+';'+mHG.field7+';;'+DateToStr(now)+';';
     //End;
     m_sbyStBlock   := 0;
     m_sTariffs     := '1,2,3,4,';;
     m_bySynchro    := 0;
     with m_sAD do
     Begin
      m_sbyNSEnable := 0;
      m_sdwFMark    := 286261249;
      m_sdwEMark    := 16781329;
      m_sdwRetrans  := 0;
      m_sdwKommut   := 0;
      m_sdwDevice   := 0;
      m_sbySpeed    := 2;
      m_sbyParity   := 0;
      m_sbyStop     := 0;
      m_sbyKBit     := 0;
      m_sbyPause    := 15;
      m_nB0Timer    := 0;
     End;
     m_swKE         := 0;
     m_sAktEnLose   := 0;
     m_sReaEnLose   := 0;
     m_sTranAktRes  := 0;
     m_sTranReaRes  := 0;
     m_sGrKoeff     := 0;
     m_sTranVolt    := 0;
     m_sTpNum       := mHG.lics;
    End;
    //if m_pDB.AddMeterTable(pTbl)=True then m_pDB.InsertCommand(pTbl.m_swMID,pTbl.m_sbyType);
    Result := pTbl;
End;


procedure CHouseGen.getStrings(s1:String;var value:TStringList);
Var
    i,j:Integer;
    s2,separator : string;
    index : Integer;
Begin
    separator := ';';
    while pos(separator, s1)<>0 do
    begin
     index := pos(separator, s1);
     s2 := copy(s1,1,index-1);
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

function CHouseGen.loadfromcsvfile(path:String;var value:TList):boolean;
Var
    sl : TStringList;
    slv : TStringList;
    i  : Integer;
    vl : CLoadEntity;
    licsB : boolean;//лицевой
    zav   : boolean;//заводской
Begin
    Result:=true;
    sl := TStringList.Create;
    sl.LoadFromFile(path);
    for i:=1 to sl.Count-1 do
    Begin
      try
       slv := TStringList.Create;
       //slv.CommaText := sl[i];
       getStrings(sl[i],slv);
       vl  := CLoadEntity.Create;
       with vl do
        Begin
          if slv[0]='' then mtid:=-1
          else
          mtid     := StrToInt(slv[0]);
          raycode  := slv[1];
          nasp     := Trim(slv[2]);
          tp       := Trim(slv[3]);
          if(slv[3]='') then tp:=nasp;//tp:='ТП-'+nasp;
          gors     := slv[4];
          ulica    := Trim(slv[5]);
          dom      := Trim(slv[6]);
          korp     := Trim(slv[7]);
          kvar     := slv[8];
          licsB    := checkSTR(slv[9]); //Проверка лицевого
          if licsB=true then
          lics     := slv[9]
          else
          begin
            Result:=false;
            exit;
          end;
           fam      := Trim(slv[10]);
           imya     := Trim(slv[11]);
           otch     := Trim(slv[12]);

          zav := checkSTR(slv[13]); //Проверка заводского
          zav := true;           {TODO -oBO -cинформационно : Костыль!!! Отключена проверка заводского номера на вшивость }
          if zav=true then
            zavno := slv[13]
          else
          begin
            Result := false;
            exit;
          end;
          ki       := StrToFloat(slv[14]);
          ku       := 1.0;
          typepu   := slv[15];
          typeuspd := slv[16];
          typezvaz := slv[17];
          nomerdoz := StringReplace(slv[18], '[', '', [rfReplaceAll]);
          nomerdoz := StringReplace(nomerdoz, ']', '', [rfReplaceAll]);
          typeabo  := slv[19];
          nomertu  := slv[20];
          field1   := StringReplace(slv[21], '[', '', [rfReplaceAll]);
          field2   := StringReplace(slv[22], '[', '', [rfReplaceAll]);
          field3   := StringReplace(slv[23], '[', '', [rfReplaceAll]);
          field4   := StringReplace(slv[24], '[', '', [rfReplaceAll]);
          field5   := StringReplace(slv[25], '[', '', [rfReplaceAll]);
          field6   := StringReplace(slv[26], '[', '', [rfReplaceAll]);
          field7   := StringReplace(slv[27], '[', '', [rfReplaceAll]);
          field1   := StringReplace(field1, ']', '', [rfReplaceAll]);
          field2   := StringReplace(field2, ']', '', [rfReplaceAll]);
          field3   := StringReplace(field3, ']', '', [rfReplaceAll]);
          field4   := StringReplace(field4, ']', '', [rfReplaceAll]);
          field5   := StringReplace(field5, ']', '', [rfReplaceAll]);
          field6   := StringReplace(field6, ']', '', [rfReplaceAll]);
          field7   := StringReplace(field7, ']', '', [rfReplaceAll]);
          idchannel := slv[28];
          idtariff  := slv[29];

          if (slv.Count>30) then
          begin
          house := slv[30];
          kv    := slv[31];
          end;
          if ulica='' then ulica := nasp+' 1-я';
        End;
      // prepare(vl); //Прошлые проверки файлов из 1С
       value.Add(vl);
       FreeAndNil(slv);
      except
       //value.add(CLoadEntity.Create);
       Result:=False;
      end;
    End;
    FreeAndNil(sl);
end;

//*************************************
//Проверка лицевого на числовые только значения
//*************************************
function CHouseGen.checkSTR(s: string) : boolean;
var hasNum, hasLetter: boolean;
    i: integer;
begin
  hasNum := true;
  hasLetter := true;
  for i := 1 to length(s) do
  begin
    //if ((s[i] >= '0') and (s[i] <= '9')) then
      //  hasNum := true;
    if ((s[i] >= 'A') and (s[i] <= 'Z')) or ((s[i] >= 'a') and (s[i] <= 'z')) then
        hasLetter := false;
    //if hasNum and hasLetter then
    if not hasLetter then
        break;
  end;
//  result := hasNum and hasLetter;
  result := hasLetter;
end;

procedure CHouseGen.loadcsvfile(path:String;var value:TList);
Var
    sl : TStringList;
    slv : TStringList;
    i  : Integer;
    vl : CLoadEntity;
Begin

    sl := TStringList.Create;
    sl.LoadFromFile(path);
    for i:=0 to sl.Count-1 do
    Begin
    try
     slv := TStringList.Create;
     //slv.CommaText := sl[i];
     getStrings(sl[i],slv);
     vl  := CLoadEntity.Create;
     with vl do
      Begin
      res      := slv[0];
      nasp     := slv[1];
      gors     := slv[2];
      ulica    := slv[3];
      dom      := slv[4];
      korp     := slv[5];
      kvar     := slv[6];
      lics     := slv[7];
      fam      := slv[8];
      imya     := slv[9];
      otch     := slv[10];
      zavno    := slv[11];
      typepu   := slv[12];
      typeuspd := slv[13];
      typezvaz := slv[14];
      nomerdoz := slv[15];
      typeabo  := slv[16];
      nomertu  := slv[17];
      if ulica='' then ulica := nasp+' 1-я';
     End;
     prepare(vl);
     value.Add(vl);
    except
     value.add(CLoadEntity.Create);
    end;
    End;
end;

procedure CHouseGen.prepare(var pD:CLoadEntity);
Begin
    with pd do
    Begin
    if KVAR='' then
       KVAR := '1';

    TYPEUSPD := Trim(TYPEUSPD);
    if TYPEUSPD='' then
       TYPEUSPD := 'EMPTY';

    if TYPEUSPD='"Коммуникатор ""Ровалэнт"""' then
       TYPEUSPD := 'ROWALANT';

    if (TYPEUSPD='УСПД 164-01Б') or
       (TYPEUSPD='164-01б')  or
       (TYPEUSPD='УСПД164-01Б')  or
       (TYPEUSPD='УСПД164-01Б')  or
       (TYPEUSPD='164-01Б') or
       (TYPEUSPD='164-01Б') or
       (TYPEUSPD='УСПД164-01Б') then
       TYPEUSPD := 'MET_USPD16401B';

    if (TYPEUSPD='УСПД 164-01И') or (TYPEUSPD='УСПД164-01И')  or (TYPEUSPD='164-01И') then
       TYPEUSPD := 'MET_USPD16401I';

    if (TYPEUSPD='УСПД 164-01М') or (TYPEUSPD='УСПД164-01М') or (TYPEUSPD='164-01М') then
       TYPEUSPD := 'MET_CE16401M';

    if TYPEUSPD='164-01' then
       TYPEUSPD :='MET_USPD16401I';

    if (TYPEUSPD='ЕА8086') or (TYPEUSPD='EA8086') or (TYPEUSPD='ЕА 8086') then
       TYPEUSPD := 'MET_EA8086';


    if (TYPEUSPD='ССДУ-02') then
       TYPEUSPD := 'MET_USPDSSDU_02';

    TYPEPU := trim(TYPEPU);

    if (TYPEPU='ЭЭ8003') or (TYPEPU='ЭЭ 8003/2') or (TYPEPU='ЭЭ8003/2') then
        TYPEPU := 'EE8003';

    if (TYPEPU='ЭЭ8004') then
        TYPEPU := 'EE8004';

    if (TYPEPU='ЭЭ8007') or (TYPEPU='ЭЭ8007/3' ) then
        TYPEPU := 'EE8007';

    if (TYPEPU='МЭС-1-5/60') then
        TYPEPU := 'MES_1_5_60';

    if (TYPEPU='CE102BY') or (TYPEPU='СЕ102ВУ') then
        TYPEPU := 'MET_CE102';

    if (TYPEPU='Миртек-1') then
        TYPEPU := 'MET_CE102';
    End;
End;


procedure CHouseGen.loadcsvfileM(path:String;var value:TList);
Var
    sl : TStringList;
    slv : TStringList;
    i  : Integer;
    vl : CLoadEntity;
Begin
    sl := TStringList.Create;
    sl.LoadFromFile(path);
    for i:=0 to sl.Count-1 do
    Begin
    try
     slv := TStringList.Create;
     //slv.CommaText := sl[i];
     getStrings(sl[i],slv);
     vl  := CLoadEntity.Create;
     with vl do
      Begin
      res      := slv[0];
      nasp     := slv[1];
      gors     := slv[2];
      ulica    := slv[3];
      dom      := slv[4];
      korp     := slv[5];
      kvar     := slv[6];
      lics     := slv[7];
      fam      := slv[8];
      imya     := slv[9];
      otch     := slv[10];
      zavno    := slv[11];
      typepu   := slv[12];
      typeuspd := slv[13];
      //typezvaz := slv[14];
      nomerdoz := slv[14];
      typeabo  := slv[15];
      nomertu  := slv[16];
      if ulica='' then ulica := nasp+' 1-я';
     End;
     prepare(vl);
     value.Add(vl);
    except
     value.add(CLoadEntity.Create);
    end;
    End;
end;


procedure CHouseGen.SetProgress(nPRC:Integer;strText:String);
Begin
    if not((FsbAbon=Nil)or(Fpbm_sBTIProgress=Nil)) then
    Begin
     Fpbm_sBTIProgress.Position   := nPRC;
     FsbAbon.Panels.Items[0].Text := strText;
     FsbAbon.Refresh;
    End;
End;

procedure CHouseGen.SetProgressIMport(nPRC:Integer;strText:String);
Begin
    if not((FsbAbonImport=Nil)or(Fpbm_sBTIProgressImport=Nil)) then
    Begin
     Fpbm_sBTIProgressImport.Position   := nPRC;
     FsbAbonImport.Panels.Items[0].Text := strText;
     FsbAbonImport.Refresh;
    End;
End;


procedure CHouseGen.SetProgressMeter_Rep(nPRC:Integer;strText:String);
Begin
    if not(Fpbm_sBTIProg_Meter_Rep=Nil) then
    Begin
     Fpbm_sBTIProg_Meter_Rep.Position   := nPRC;
//     FsbAbonImport.Refresh;
    End;
End;


//Конфигурирование уровня L2
procedure CHouseGen.GenL2(var mHG:SHOUSEGEN);
Var
    nKV : Integer;
Begin
    m_pDB.DelMeterTable(mHG.m_swPortID,-1);
    m_nL2I.Refresh;
    //Квартирный учет
    if (mHG.m_snFirstKvartNumber<>0)and(mHG.m_snEndKvartNumber<>0) then
    Begin
     for nKV:=mHG.m_snFirstKvartNumber to mHG.m_snEndKvartNumber do
     SetL2Tag(UTP_KU,nKV,mHG);
    End;
    //Не квартирный учет 1
    for nKV:=0 to mHG.m_snAmBal1-1 do
    SetL2Tag(UTP_KUB,nKV,mHG);
    //Не квартирный учет 2
    for nKV:=0 to mHG.m_snAmBal2-1 do
    SetL2Tag(UTP_NKUB,nKV,mHG);
    //Не квартирный учет 3
    for nKV:=0 to mHG.m_snAmBal3-1 do
    SetL2Tag(UTP_NKUNB,nKV,mHG);
    //Тепловой учет
    for nKV:=0 to mHG.m_snAmTeploUch-1 do
    SetL2Tag(UTP_OTP,nKV,mHG);
    //Суммирующий счетчик
    SetL2Tag(UTP_SUM,0,mHG);
End;
function CHouseGen.SetL2Tag(nTPUCH,nKV:Integer;var mHG:SHOUSEGEN):Integer;
Var
     pTbl:SL2TAG;
     sMK,sName : String;
     nMeterType,byModem,byEnable,byLocation : Integer;
Begin
     byLocation := 5;
     case nTPUCH of
          UTP_KU:
          Begin
           sMK        := mHG.m_sKSP+'|'+mHG.m_sMarshNumber+'/'+IntToStr(nKV);
           sName      := 'Фам'+sMK+'Имя'+sMK+'Отч'+sMK;
           if mHG.m_sVmName<>'' then sName := mHG.m_sVmName+IntToStr(nKV);
           nMeterType := mHG.m_nKvarUchType;
          End;
          UTP_KUB:
          Begin
           sMK        := mHG.m_sKSP+'|'+mHG.m_sMarshNumber+'/-111/'+mHG.m_sKodSysBalance+'/';
           sName      := 'Балансный';
           nMeterType := mHG.m_nNKvarUchType;
          End;
          UTP_NKUB:
          Begin
           sMK        := mHG.m_sKSP+'|'+mHG.m_sMarshNumber+'/-211/'+mHG.m_sKodSysBalance+'/';
           sName      := 'Не кварт. в балансе';
           nMeterType := mHG.m_nNKvarUchType;
          End;
          UTP_NKUNB:
          Begin
           sMK        := mHG.m_sKSP+'|'+mHG.m_sMarshNumber+'/-311/'+mHG.m_sKodSysBalance+'/';
           sName      := 'Не кварт. не в балансе';
           nMeterType := mHG.m_nNKvarUchType;
          End;
          UTP_OTP:
          Begin
           sMK        := mHG.m_sKSP+'|'+mHG.m_sMarshNumber+'/-111/'+mHG.m_sKodSysBalance+'/';
           sName      := 'Тепловой';
           nMeterType := mHG.m_nTeploType;
          End;
          UTP_SUM:
          Begin
           sMK        := mHG.m_sKSP+'|'+mHG.m_sMarshNumber+'/-111/'+mHG.m_sKodSysBalance+'/';
           sName      := 'Сумма по дому';
           nMeterType := MET_SUMM;
          End;
     End;
     with pTbl do Begin
     m_sbyGroupID   := 0;
     m_swVMID       := 0;
     m_sbyPortID    := mHG.m_swPortID ;
     m_swMID        := m_nL2I.GenIndexSv;
     m_sbyType      := nMeterType;
     m_sbyLocation  := nTPUCH;
     m_sddFabNum    := '000000';
     m_sddPHAddres  := IntToStr(nKV);
     m_schPassword  := '0';
     m_schName      := sName;
     m_sbyRepMsg    := 10;
     m_swRepTime    := 7;
     m_sfKI         := 1;
     m_sfKU         := 1;
     m_sfMeterKoeff := 1;
     m_sdtSumKor    := cDateTimeR.SecToDateTime(0);
     m_sdtLimKor    := cDateTimeR.SecToDateTime(1800);
     m_sdtPhLimKor  := cDateTimeR.SecToDateTime(1800);
     m_sbyPrecision := 3;
     m_swCurrQryTm  := 40;
     m_sbyTSlice    := 0;
     m_sPhone       := mHG.m_sPhone;
     m_sbyModem     := mHG.m_nIsModem;
     m_sbyEnable    := 1;
     if nMeterType=MET_SUMM then Begin m_sbyModem:=0;m_sbyEnable:=0;End;
     m_sAdvDiscL2Tag:= '';
     m_sbyStBlock   := 0;
     m_sTariffs     := '1,2,3,4,';;
     m_bySynchro    := 0;
     with m_sAD do
     Begin
      m_sbyNSEnable := 0;
      m_sdwFMark    := 286261249;
      m_sdwEMark    := 16781329;
      m_sdwRetrans  := 0;
      m_sdwKommut   := 0;
      m_sdwDevice   := 0;
      m_sbySpeed    := 2;
      m_sbyParity   := 0;
      m_sbyStop     := 0;
      m_sbyKBit     := 0;
      m_sbyPause    := 15;
      m_nB0Timer    := 0;
     End;
     m_swKE         := 0;
     m_sAktEnLose   := 0;
     m_sReaEnLose   := 0;
     m_sTranAktRes  := 0;
     m_sTranReaRes  := 0;
     m_sGrKoeff     := 0;
     m_sTranVolt    := 0;
     m_sTpNum       := sMK;
    End;
    if m_pDB.AddMeterTable(pTbl)=True then m_pDB.InsertCommand(pTbl.m_swMID,pTbl.m_sbyType);
    Result := pTbl.m_swMID;
End;
procedure CHouseGen.InitL2(var mHG:SHOUSEGEN);
Var
    pDS : CMessageData;
Begin
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    pDS.m_swData1 := mHG.m_swPortID;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INIT_PORT_L2_REQ,pDS);
End;
//Конфигурирование групп
procedure CHouseGen.GenGroup(var mHG:SHOUSEGEN);
Begin
    m_pDB.DelGroupTable(mHG.m_swABOID,-1);
    m_nLGI.Refresh;
    m_nKUGID    := SetGroupTag(UTP_KU   ,0,'Квартиры',mHG);
    m_nNKUNBGID := SetGroupTag(UTP_NKUNB,0,'Собственные нужды',mHG);
    m_nTPUGID   := SetGroupTag(UTP_OTP  ,0,'Тепловой учет',mHG);
End;
function CHouseGen.SetGroupTag(nTPUCH,nKV:Integer;sName:String;var mHG:SHOUSEGEN):Integer;
Var
    pTbl : SL3GROUPTAG;
Begin
    pTbl.m_swABOID       := mHG.m_swABOID;
    pTbl.m_sbyGroupID    := m_nLGI.GenIndexSv;
    pTbl.M_NGROUPLV      := 0;
    if nTPUCH=UTP_SUM  then pTbl.M_NGROUPLV := 1;
    if nTPUCH=UTP_GSUM then pTbl.M_NGROUPLV := 2;
    pTbl.m_swPosition    := nKV;
    pTbl.m_sGroupName    := sName;
    pTbl.m_sGroupExpress := '[x]';
    pTbl.m_swPLID        := 0;
    pTbl.m_sbyEnable     := 1;
    m_pDB.AddGroupTable(pTbl);
    Result := pTbl.m_sbyGroupID;
End;
//Конфигурирование уровня L3
procedure CHouseGen.GenL3(var mHG:SHOUSEGEN);
Begin
     m_nL3I.Refresh;
     SetL3Tag(UTP_KU   ,m_nKUGID ,mHG);
     SetL3Tag(UTP_KUB  ,m_nKUGID ,mHG);
     SetL3Tag(UTP_NKUB ,m_nKUGID ,mHG);
     SetL3Tag(UTP_NKUNB,m_nNKUNBGID,mHG);
     SetL3Tag(UTP_OTP  ,m_nTPUGID,mHG);
End;
function CHouseGen.SetL3Tag(nTPUCH,nGID:Integer;var mHG:SHOUSEGEN):Integer;
Var
    pTbl  : SL2INITITAG;
    pTbl3 : SL3VMETERTAG;
    i : Integer;
Begin
    if m_pDB.GetMetersTableLC(mHG.m_swPortID,nTPUCH,pTbl)=True then
    Begin
     for i:=0 to pTbl.m_swAmMeter-1 do
     Begin
      pTbl3.m_swMID       := pTbl.m_sMeter[i].m_swMID;
      pTbl3.m_sbyPortID   := pTbl.m_sMeter[i].m_sbyPortID;
      pTbl3.m_sbyType     := pTbl.m_sMeter[i].m_sbyType;
      pTbl3.m_sbyGroupID  := nGID;
      pTbl3.m_swVMID      := m_nL3I.GenIndexSv;
      pTbl3.m_sddPHAddres := pTbl.m_sMeter[i].m_sddPHAddres;
      pTbl3.m_sMeterName  := pTbl.m_sMeter[i].m_schName;
      pTbl3.m_sMeterCode  := 'MCode:'+IntToStr(pTbl3.m_swVMID);
      pTbl3.m_sVMeterName := pTbl.m_sMeter[i].m_schName;
      pTbl3.m_sbyExport   := 1;
      pTbl3.m_swPLID      := 0;
      pTbl3.m_sbyEnable   := 1;
      m_pDB.AddVMeterTable(pTbl3);
      m_pDB.InsertVParams(pTbl3.m_sbyType,pTbl3.m_swVMID);     //AAV 27.04.2017
     End;
    End;
End;
procedure CHouseGen.InitL3(var mHG:SHOUSEGEN);
Var
    pDS : CMessageData;
Begin
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    pDS.m_swData1 := mHG.m_swABOID;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL3_REQ,pDS);
End;
//Конфигурирование сервера опроса
procedure CHouseGen.GenQS(var mHG:SHOUSEGEN);
begin
     m_pDB.DelQwerySRVTable(mHG.m_swABOID,-1);
     m_nLQSI.Refresh;
     m_nLQCI.Refresh;
     m_nQSID := CreateQweryserver(mHG);
     AddGroupNode(m_nKUGID   ,m_nQSID,mHG);
     AddGroupNode(m_nNKUNBGID,m_nQSID,mHG);
     AddGroupNode(m_nTPUGID  ,m_nQSID,mHG);
end;
procedure CHouseGen.GenQwerySrv(var mHG:SHOUSEGEN);
begin
     m_pDB.DelQwerySRVTable(mHG.m_swABOID,-1);
     m_nLQSI.Refresh;
     m_nLQCI.Refresh;
     m_nQSID := CreateQweryserver(mHG);
     AddAbonNode(m_nQSID,mHG);
end;
procedure CHouseGen.AddGroupNode(snGID,snSRVID:Integer;var mHG:SHOUSEGEN);
Var
     pTbl : SQWERYVM;
     pTable:SL3GROUPTAG;
     i : Integer;
Begin
     if m_pDB.GetVMetersTypeTable(snGID,-1,pTable)=True then
     Begin
      //for i:=0 to pTable.Item.Count-1 do                     //AAV 27.04.2017
      if pTable.Item.Count>0 then
      Begin
       i:= 0;
       pTbl.m_snSRVID := snSRVID;
       pTbl.m_snCLID  := m_nLQCI.GenIndexSv;
       pTbl.m_snVMID  := pTable.Item.Items[i].m_swVMID;
       pTbl.m_snMID   := pTable.Item.Items[i].m_swMID;
       pTbl.m_snPID   := GetRealPort(pTable.Item.Items[i].m_sbyPortID);
       pTbl.m_sName   := pTable.Item.Items[i].m_sVMeterName;
       pTbl.m_snTPID  := pTable.Item.Items[i].m_sbyType;
       if m_pDB.AddQweryVMTable(pTbl)=True then AddDefaultClusters(pTbl,mHG);
      End;
     End;
End;
procedure CHouseGen.AddAbonNode(snSRVID:Integer;var mHG:SHOUSEGEN);
Var
     pTbl : SQWERYVM;
     pTable:SL3GROUPTAG;
     i : Integer;
Begin
     if m_pDB.GetAbonVMetersTable(mHG.m_swABOID,-1,pTable)=True then
     Begin
      for i:=0 to pTable.Item.Count-1 do
      Begin
       pTbl.m_snSRVID := snSRVID;
       pTbl.m_snCLID  := m_nLQCI.GenIndexSv;
       pTbl.m_snVMID  := pTable.Item.Items[i].m_swVMID;
       pTbl.m_snMID   := pTable.Item.Items[i].m_swMID;
       pTbl.m_snPID   := GetRealPort(pTable.Item.Items[i].m_sbyPortID);
       pTbl.m_sName   := pTable.Item.Items[i].m_sVMeterName;
       pTbl.m_snTPID  := pTable.Item.Items[i].m_sbyType;
       if m_pDB.AddQweryVMTable(pTbl)=True then AddDefaultClusters(pTbl,mHG);
      End;
     End;
End;
procedure CHouseGen.AddDefaultClusters(var pTbl:SQWERYVM;var mHG:SHOUSEGEN);
Begin
     if m_pDB.GetCommandsFTable(pTbl.m_snMID,'1,4,8,9,11,12',pTbl.Commands)=True then
     Begin
      AddDefaultCluster(CLS_MGN,    SV_DEFT_ST,pTbl,mHG);
      AddDefaultCluster(CLS_MGN,    SV_PDPH_ST,pTbl,mHG);
      AddDefaultCluster(CLS_GRAPH48,SV_DEFT_ST,pTbl,mHG);
      AddDefaultCluster(CLS_DAY,    SV_DEFT_ST,pTbl,mHG);
      AddDefaultCluster(CLS_MONT,   SV_DEFT_ST,pTbl,mHG);
      AddDefaultCluster(CLS_EVNT,   SV_DEFT_ST,pTbl,mHG);
      AddDefaultCluster(CLS_TIME,   SV_DEFT_ST,pTbl,mHG);
     End;
End;
procedure CHouseGen.AddDefaultCluster(nCLSID,nSVID:Integer;var pTbl:SQWERYVM;var mHG:SHOUSEGEN);
Var
     i,lCLSID  : Integer;
     pT : SQWERYMDL;
Begin
     pT.m_strCMDCluster := '';
     for i:=0 to pTbl.Commands.m_swAmCommand-1 do
     Begin
      with pTbl.Commands.m_sCommand[i] do
      if (m_sbyDirect=nCLSID)and((m_swID=nSVID)or(nSVID=SV_DEFT_ST)) then
      Begin
       lCLSID             := nCLSID;
       if (nSVID=SV_PDPH_ST)and(pTbl.m_snTPID<>MET_ENTASNET) then lCLSID:=CLS_PNET;
       pT.m_snAID         := mHG.m_swABOID;
       pT.m_snSRVID       := pTbl.m_snSRVID;
       pT.m_snCLID        := pTbl.m_snCLID;
       pT.m_snVMID        := pTbl.m_snVMID;
       pT.m_snMID         := pTbl.m_snMID;
       pT.m_snPID         := pTbl.m_snPID;
       pT.m_snCLSID       := lCLSID;
       pT.m_strCMDCluster := pT.m_strCMDCluster+IntToStr($8000 or m_swCmdID)+',';
       if mHG.m_sdtBegin=0  then pT.m_sdtBegin := EncodeTime(0,10,0,0)   else pT.m_sdtBegin  := mHG.m_sdtBegin;
       if mHG.m_sdtEnd=0    then pT.m_sdtEnd   := EncodeTime(23,59,59,0) else pT.m_sdtEnd    := mHG.m_sdtEnd;
       if mHG.m_sdtPeriod=0 then pT.m_sdtPeriod:= EncodeTime(1,0,0,0)    else pT.m_sdtPeriod := mHG.m_sdtPeriod;
       pT.m_swDayMask     := 0;
       pT.m_sdwMonthMask  := 0;
       if pos(','+IntToStr(lCLSID)+',',mHG.m_strClsEnable)<>0 then pT.m_sbyEnable := 1 else
       pT.m_sbyEnable     := 0;
       pT.m_sbyPause      := 0;
       pT.m_sbyFindData   := 1;
       pT.m_snDeepFind    := 2;
       if (lCLSID=CLS_GRAPH48)or(lCLSID=CLS_DAY)or(lCLSID=CLS_MONT)or(lCLSID=CLS_MONT)or(lCLSID=CLS_PNET) then Begin pT.m_sbyFindData := 0;pT.m_snDeepFind := 0;End;
      End;
     End;
     if pT.m_strCMDCluster<>'' then
     m_pDB.AddQweryMDLTable(pT);
End;
function CHouseGen.GetRealPort(nPort:Integer):Integer;
Var
    i : Integer;
Begin
    Result := nPort;
    for i:=0 to m_pL1Tbl.Count-1 do
    Begin
     if m_pL1Tbl.Items[i].m_sbyPortID=nPort then
     Begin
      Result := m_pL1Tbl.Items[i].m_sbyPortID;
      if m_pL1Tbl.Items[i].m_sblReaddres=1 then Result := m_pL1Tbl.Items[i].m_swAddres;
      exit;
     End;
    End;
End;
function CHouseGen.CreateQweryserver(var mHG:SHOUSEGEN):Integer;
Var
     pTbl : SQWERYSRV;
Begin
     pTbl.m_snAID       := mHG.m_swABOID ;
     pTbl.m_snSRVID     := m_nLQSI.GenIndexSv;
     pTbl.m_sName       := 'Опрос:'+mHG.m_sAbonName;
     pTbl.m_sbyEnable   := 1;
     pTbl.m_nSrvWarning := 3;
     m_pDB.AddQwerySRVTable(pTbl);
     Result := pTbl.m_snSRVID;
End;
procedure CHouseGen.SendQSCommEx(snAID,snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     sQC.m_snABOID := snAID;
     sQC.m_snSRVID := snSRVID;
     sQC.m_snCLID  := snCLID;
     sQC.m_snCLSID := snCLSID;
     sQC.m_snPrmID := snPrmID;
     sQC.m_snCmdID := nCommand;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure CHouseGen.InitQS(var mHG:SHOUSEGEN);
Begin
     SendQSCommGEx(mHG.m_swABOID,-1,-1,-1,-1,QS_INIT_SR)
End;
//Конфигурирование выгрузки
procedure CHouseGen.GenUpload(var mHG:SHOUSEGEN);
Begin

End;
//Конфигурирование дерева
procedure CHouseGen.InitTree(var mHG:SHOUSEGEN);
Var
    pDS : CMessageData;
Begin
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INIT_TREE_REQ,pDS);
End;

procedure CHouseGen.InitTreeRef;
Var
    pDS : CMessageData;
Begin
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INIT_TREE_REQ,pDS);
End;

procedure CHouseGen.OnInitL1;
Var
    pDS : CMessageData;
begin
    pDS.m_swData4 := MTR_LOCAL;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL1_REQ,pDS);
end;

end.
