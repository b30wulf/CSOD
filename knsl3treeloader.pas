unit knsl3treeloader;

interface
uses
  Windows, Classes, SysUtils,SyncObjs,stdctrls,Controls, Forms, Dialogs,comctrls,
  utltypes,utlbox,utldatabase,knsl2treehandler,knsl5tracer,utlconst,knsl3AddrUnit;
type
    CL3TreeLoader = class(CTreeHandler)
    private
     //Type 1
     m_sTblL1   : SL1INITITAG;
     m_dwSort   : Dword;
     MM,EM,PM,DM,UM,SM,NM,OM:Int64;
     bAllowAbon : array of integer;
     m_nCurrUsr : integer;
    private
     function  GetRealPort(nPort:Integer):Integer;
     procedure SetReprts(nTI:CTI;rtChild:TTreeNode; _RVMask : Int64);
     procedure SetAddrTemplate_1;
     procedure SetAddrTemplate_1Filter;
     procedure SetInAddrNode_1(nTI:CTI;pTbl:SL3ABONS;rtChild:TTreeNode);
     procedure SetInAbonNode_1(nTI:CTI;pTbl:SL3INITTAG;rtChild:TTreeNode;_RVMask,TrMask:Int64);
     procedure SetReprts_1(nTI:CTI;rtChild:TTreeNode);
     procedure SetVMeters_1(nTI:CTI;var pTbl:SL3GROUPTAG;rtChild:TTreeNode;nTS:Int64);
     procedure SetPrims_1(nTI:CTI;nLEV:Byte;var pTbl:SL3VMETERTAG;rtChild:TTreeNode;nTS:Int64);
     procedure SetParams_1(nTI:CTI;var pTbl:SL3VMETERTAG;rtChild:TTreeNode);
     function  CreateCTI:PCTI;override;
     function  IsTrueNode(nCTI:CTreeIndex):Boolean;override;
     procedure SetQweryServers(nTI:CTI;swABOID:Integer;rtChild:TTreeNode);
     procedure LoadAllowAbonBuf(var buf : array of integer);
     function  IsAbonAllow(ABOID: integer):boolean;
     procedure RefreshTreeImageText(IDGID,STATE:Integer);
     public
     procedure OnLoadGroup(nTI:CTI;rtChild:TTreeNode);
     procedure OnLoadInRegion(nTI:CTI;rtChild:TTreeNode);
     procedure OnLoadInRayon(nTI:CTI;rtChild:TTreeNode);
     procedure OnLoadInTown(nTI:CTI;rtChild:TTreeNode);
     procedure OnLoadInPods(nTI:CTI;rtChild:TTreeNode);
     procedure OnLoadInStreet(nTI:CTI;rtChild:TTreeNode);
     procedure OnLoadInAbon(nTI:CTI;rtChild:TTreeNode);
     procedure OnLoadInQueryGroup(nTI:CTI;rtChild:TTreeNode);
     constructor Create(pTree : PTTreeView);
     destructor  Destroy;override;
     procedure   LoadTree;
     procedure   LoadTree_1;
     procedure   LoadTree_1_Filter;
     procedure   SelectTreeType;
     procedure   MessageRefreshTree(GID,STATE:Integer;_Date:TDateTime);
     procedure   LoadFiltredTree;
     procedure   SetSortType(dwSort:Dword);
     procedure   SetCurrUsr(user : integer);
     End;
  PCL3TreeLoader =^ CL3TreeLoader;
implementation
constructor CL3TreeLoader.Create(pTree : PTTreeView);
Var
    i : Integer;
Begin
    OM := 1;
    for i:= 0 to c_ReportsCount-1 do
    Begin
     if c_ReportsTitles[i].G='Мощность'       then MM := MM or (OM shl i);
     if c_ReportsTitles[i].G='Энергия'        then EM := EM or (OM shl i);
     if c_ReportsTitles[i].G='Показания'      then PM := PM or (OM shl i);
     if c_ReportsTitles[i].G='Диагностические'then DM := DM or (OM shl i);
     if c_ReportsTitles[i].G='Учет тепла'     then UM := UM or (OM shl i);
     if c_ReportsTitles[i].G='Стоимость'      then SM := SM or (OM shl i);
     if c_ReportsTitles[i].G='Настройки'      then NM := NM or (OM shl i);
    End;
    inherited Create(pTree);
End;
destructor CL3TreeLoader.Destroy;
Begin
    inherited;
End;
procedure CL3TreeLoader.SelectTreeType;
Begin
    case m_dwTree of
         0: LoadTree;
         1: LoadTree_1;
    End;
End;

procedure CL3TreeLoader.MessageRefreshTree(GID,STATE:Integer;_Date:TDateTime);
Begin
//LoadTree;
 m_pDB.SetGroupRefresh(GID,STATE,_Date); //создать запрос на обновление параметра для анализа состояния группы опроса
 RefreshTreeImageText(GID,STATE);
End;

procedure CL3TreeLoader.LoadFiltredTree;
begin
   LoadTree_1_Filter;
end;
//Абонент-Примитивы-Группы-Тучи-Параметры
procedure CL3TreeLoader.LoadTree;
Begin
    m_nPIID := 0;
End;
procedure CL3TreeLoader.SetReprts(nTI:CTI;rtChild:TTreeNode; _RVMask : Int64);
var
  i : Integer;
  sh : int64;
Begin
  sh := 1;
  with nTI.m_nCTI do
  Begin
    for i:=0 to c_ReportsCount-1 do
    Begin
     if (_RVMask AND (sh shl i))>0 then
     Begin
      if rtChild.Text=c_ReportsTitles[i].G then
      SetInNode(CTI.Create(PTIM,SD_REPRT,PD_RPRTS,0,PAID, c_ReportsTitles[i].I,1),rtChild,c_ReportsTitles[i].N);
     End;
    End;
  End;
End;
//Адрес-Абонент-Группы-Тучи-Примитивы-Параметры
procedure CL3TreeLoader.LoadTree_1;
Begin
    TraceL(1,0,'ExecSetTree #1');
    m_nPIID := 0;
    SetAddrTemplate_1;
End;
procedure CL3TreeLoader.LoadTree_1_Filter;
Begin
    TraceL(1,0,'ExecSetTree #1');
    m_nPIID := 0;
    SetAddrTemplate_1Filter;
End;
procedure CL3TreeLoader.SetSortType(dwSort:Dword);
Begin
    m_dwSort := dwSort;
End;
procedure CL3TreeLoader.SetCurrUsr(user : integer);
begin
   m_nCurrUsr := user;
end;
function CL3TreeLoader.CreateCTI:PCTI;
Var
    pTI : PCTI;
Begin
    m_sNI.m_sbyLOCK := 11;
    m_sNI.m_sbyUNLK := 10;
    m_sNI.m_sbyALOK := 9;
    m_sNI.m_sbyCVRY := 9;
    m_sNI.m_sbyALRM := 12;
    m_sNI.m_sbyREDY := 9;
    New(pTI);
    pTI^ := CTI.Create(m_sNI);
    Result := pTI;
End;
function  CL3TreeLoader.IsTrueNode(nCTI:CTreeIndex):Boolean;
Begin
    Result := ((nCTI.PTSD=SD_ABONT)or(nCTI.PTSD=SD_VMETR))and(nCTI.PNID<>PD_SCHEM);
End;
procedure CL3TreeLoader.SetAddrTemplate_1;
Var
    pTbl    : SL3REGIONS;
    i       : Integer;
    nI      : CTI;
    strName : string;
    nextNode: TTreeNode;
Begin
    //FTree.FullCollapse;
    FreeTree;
    FTree.ReadOnly := True;
    m_pDB.GetRegionsTable(pTbl);
    Begin
     for i:=0 to pTbl.Count-1 do
     Begin
     with pTbl.Items[i] do
     Begin
      if m_sbyEnable=1 then
      Begin
       nI       := CTI.Create(1,SD_REGIN,PD_UNKNW,m_nRegionID,m_sbyEnable);
       strName  := m_nRegNM;//m_sKSP+':'+m_nRegNM;
       SetInNode(nI,SetInNode(nI,Nil,strName),'A');
       FreeAndNil(nI);
      End;
     End;
     End;
      nI := CTI.Create(35,SD_QGRUP,PD_UNKNW,1);
      SetInNode(nI,SetInNode(nI,nil,'Группы опроса'),'A');
      FreeAndNil(nI);
      nI := CTI.Create(6,SD_PRIMT,PD_EVENS,1);
      nI.m_nCTI.PVID := $ffff;
      SetInNode(nI,nil,'События системмы');
      FreeAndNil(nI);
    End;
End;
{
    SL3DEPARTAMENT = packed record
      m_swID            : Integer;
      m_swRegion        : Integer;
      m_swDepID         : Integer;
      m_sName           : string[150];
    end;

    SL3DEPARTAMENTS = packed record
      Count             : Integer;
      Items             : array of SL3DEPARTAMENT;
    end;
}
procedure CL3TreeLoader.OnLoadInRegion(nTI:CTI;rtChild:TTreeNode);
Var
     pTbl : SL3DEPARTAMENTS;
     nI   : CTI;
     node : TTreeNode;
     i    : Integer;
Begin
  if m_pDB.GetDepartamentsTable(nTI.m_nCTI.PRID,pTbl)=True then Begin
    for i:=0 to pTbl.Count-1 do Begin
      if UserPermission.AccessAllowed(nTI.m_nCTI.PRID, pTbl.Items[i].m_swDepID) or
           (not UserPermission.AccessByRegion) then begin
       nI  := CTI.Create(1,SD_RAYON,PD_UNKNW,1);
       nI.setRegion(nTI.m_nCTI.PRID);
       nI.setRayon(pTbl.Items[i].m_swDepID);
       SetInNode(nI,SetInNode(nI,rtChild,pTbl.Items[i].m_sName),'A');
       FreeAndNil(nI);
      End;
     End;
  End;
End;

procedure CL3TreeLoader.OnLoadInRayon(nTI:CTI;rtChild:TTreeNode);
Var
     pTbl : SL3TOWNS;
     nI   : CTI;
     node : TTreeNode;
     i    : Integer;
Begin
     if m_pDB.GetTownsTable(nTI.m_nCTI.PRYD,pTbl)=True then
     Begin
      for i:=0 to pTbl.Count-1 do
      Begin
       nI  := CTI.Create(1,SD_TOWNS,PD_UNKNW,1);
       nI.setRegion(nTI.m_nCTI.PRID);
       nI.setRayon(nTI.m_nCTI.PRYD);
       nI.setTown(pTbl.Items[i].m_swTownID);
       SetInNode(nI,SetInNode(nI,rtChild,pTbl.Items[i].m_sName),'A');
       FreeAndNil(nI);
      End;
     End;
End;
procedure CL3TreeLoader.OnLoadInTown(nTI:CTI;rtChild:TTreeNode);
Var
     pTbl : SL3TPS;
     nI   : CTI;
     node : TTreeNode;
     i    : Integer;
Begin
     if m_pDB.GetPodsTable(nTI.m_nCTI.PTWN,pTbl)=True then
     Begin
      for i:=0 to pTbl.Count-1 do
      Begin
       nI  := CTI.Create(1,SD_TPODS,PD_UNKNW,1);
       nI.setRegion(nTI.m_nCTI.PRID);
       nI.setRayon(nTI.m_nCTI.PRYD);
       nI.setTown(nTI.m_nCTI.PTWN);
       nI.setPods(pTbl.Items[i].id);
       SetInNode(nI,SetInNode(nI,rtChild,pTbl.Items[i].name),'A');
       FreeAndNil(nI);       
      End;
     End;
End;
{procedure CL3TreeLoader.OnLoadInTown(nTI:CTI;rtChild:TTreeNode);
Var
     pTbl : SL3STREETS;
     nI   : CTI;
     node : TTreeNode;
     i    : Integer;
Begin
     if m_pDB.GetStreetsTable(nTI.m_nCTI.PTWN,pTbl)=True then
     Begin
      for i:=0 to pTbl.Count-1 do
      Begin
       nI  := CTI.Create(1,SD_STRET,PD_UNKNW,1);
       nI.setRegion(nTI.m_nCTI.PRID);
       nI.setRayon(nTI.m_nCTI.PRYD);
       nI.setTown(nTI.m_nCTI.PTWN);
       nI.setStreet(pTbl.Items[i].m_swStreetID);
       SetInNode(nI,SetInNode(nI,rtChild,pTbl.Items[i].m_sName),'A');
      End;
     End;
End;}
procedure CL3TreeLoader.OnLoadInPods(nTI:CTI;rtChild:TTreeNode);
Var
     pTbl : SL3STREETS;
     nI   : CTI;
     node : TTreeNode;
     i    : Integer;
Begin
     if m_pDB.GetStreetByTpTable(nTI.m_nCTI.PTPS,pTbl)=True then
     Begin
      for i:=0 to pTbl.Count-1 do
      Begin
       nI  := CTI.Create(1,SD_STRET,PD_UNKNW,1);
       nI.setRegion(nTI.m_nCTI.PRID);
       nI.setRayon(nTI.m_nCTI.PRYD);
       nI.setTown(nTI.m_nCTI.PTWN);
       nI.setPods(nTI.m_nCTI.PTPS);
       nI.setStreet(pTbl.Items[i].m_swStreetID);
       SetInNode(nI,SetInNode(nI,rtChild,pTbl.Items[i].m_sName),'A');
       FreeAndNil(nI);       
      End;
     End;
End;
procedure CL3TreeLoader.OnLoadInStreet(nTI:CTI;rtChild:TTreeNode);
Var
     pTbl  : SL3ABONS;
     nI    : CTI;
     node  : TTreeNode;
     i     : Integer;
Begin
     with nTI.m_nCTI do begin
     if m_pDB.GetAbonRegTableByAddr(PRID,PRYD,PTWN,PTPS,PSTR,pTbl)=True then
     Begin
      for i:=0 to pTbl.Count-1 do
      Begin
       nI  := CTI.Create(10,SD_ABONT,PD_UNKNW,pTbl.Items[i].m_sbyEnable);
       nI.setRegion(PRID);
       nI.setRayon(PRYD);
       nI.setTown(PTWN);
       nI.setPods(PTPS);
       nI.setStreet(PSTR);
       nI.setAbon(pTbl.Items[i].m_swABOID);
       SetInNode(nI,SetInNode(nI,rtChild,pTbl.Items[i].m_sName),'A');
       FreeAndNil(nI);
      End;
     End;
     End;
End;

procedure CL3TreeLoader.OnLoadInAbon(nTI:CTI;rtChild:TTreeNode);
Var
     pTbl  : SL3INITTAG1;
     pgTbl : SL3INITTAG;
     nI    : CTI;
     nIAbon: CTI;
     node  : TTreeNode;
     i     : Integer;
Begin
     pgTbl.Count := 0;
     with nTI.m_nCTI do begin
     if m_pDB.GetGroupsAbonTable(PAID,pTbl)=True then
     Begin
      for i:=0 to pTbl.Count-1 do
      Begin
       nI  := CTI.Create(13,SD_GROUP,PD_UNKNW,pTbl.Items[i].m_sbyEnable);
       nI.setRegion(PRID);
       nI.setRayon(PRYD);
       nI.setTown(PTWN);
       nI.setPods(PTPS);
       nI.setStreet(PSTR);
       nI.setAbon(PAID);
       nI.setGroup(pTbl.Items[i].m_sbyGroupID);
       SetInNode(nI,SetInNode(nI,rtChild,pTbl.Items[i].m_sGroupName),'A');

       if i<>pTbl.Count-1 then
        FreeAndNil(nI);
      End;
      SetInAbonNode_1(nI,pgTbl,rtChild,pTbl.Items[0].m_sReportVS,pTbl.Items[0].m_sTreeSettings);
      FreeAndNil(nI);
     End;
     End;
End;

procedure CL3TreeLoader.OnLoadInQueryGroup(nTI:CTI;rtChild:TTreeNode);
Var
     pTbl  : TThreadList;
     pTblParam : TThreadList;
     vList : TList;
     vListParam : TList;
     data  : querygroup;
     dataParam  : QGPARAM;     
     nI    : CTI;
     node  : TTreeNode;
     i,j,k : Integer;
     PictIndex : integer;
     arrayParam: array[0..3] of byte;
Begin
 try
  if not UserPermission.PermissQueryGroup then Exit;
     // считка группы опроса
     with nTI.m_nCTI do begin
     pTbl  := TThreadList.Create;
     if m_pDB.GetQueryGroups(-1,pTbl)=True then
     Begin
      vList := pTbl.LockList;
      for i:=0 to vList.Count-1 do
      Begin
        for k:=0 to 3 do
         arrayParam[k]:=0;

       data := vList[i];

       pTblParam  := TThreadList.Create;
       if m_pDB.getQueryGroupsParam(data.ID,-1, pTblParam)then
       begin
         vListParam:=pTblParam.LockList;
         for j:=0 to vListParam.Count-1 do
         begin
            dataParam:=vListParam[j];
            if (dataParam.PARAM=1)and(dataParam.ENABLE=1) then
             arrayParam[0]:=1
            else if (dataParam.PARAM=17)and(dataParam.ENABLE=1) then
             arrayParam[1]:=1
            else if (dataParam.PARAM=21)and(dataParam.ENABLE=1) then
             arrayParam[2]:=1;
         end;
         pTblParam.UnlockList;
         ClearListAndFree(pTblParam);
       end;

       if data.ErrorQuery = 1 then begin  // Запрос остановлен        // BO 12/12/18
         if trunc(data.DateQuery) <> date then
           begin   // Запрос просрочен
             PictIndex:= 31;
             if (arrayParam[0]=1) or (arrayParam[1]=1) or (arrayParam[2]=1) then
              data.name:= 'Вкл.(авт)/ ' +data.name+ ' / ' +DateTimeToStr(data.DateQuery) +' / Опрос просрочен'
             else data.name:=data.name+ ' / ' +DateTimeToStr(data.DateQuery) +' / Опрос просрочен';
           end
         else
           begin                          // Все хорошо
             PictIndex:= 16;
             data.name:=data.name+' / Опрос'
           end;
       end
       else if data.ErrorQuery = 2 then    // Запрос опроса(руч.)'
         begin
           if trunc(data.DateQuery) <> date then
             begin   // Запрос просрочен
               PictIndex:= 31;
               if (arrayParam[0]=1) or (arrayParam[1]=1) or (arrayParam[2]=1) then
                data.name:= 'Вкл.(авт)/ ' + data.name+ ' / ' +DateTimeToStr(data.DateQuery) +' / Опрос просрочен'
               else data.name:=data.name+ ' / ' +DateTimeToStr(data.DateQuery) +' / Опрос просрочен';
             end
           else
             begin                          // Все хорошо
               PictIndex:= 21;
               data.name:=data.name+' / Ожидание опроса(руч.)'
             end;
         end
       else if data.ErrorQuery = 3 then    // Запрос опроса(авт.)'
         begin
           if trunc(data.DateQuery) <> date then
             begin   // Запрос просрочен
               PictIndex:= 31;
               if (arrayParam[0]=1) or (arrayParam[1]=1) or (arrayParam[2]=1) then
                data.name:= 'Вкл.(авт)/ ' + data.name+ ' / ' +DateTimeToStr(data.DateQuery) +' / Опрос просрочен'
                else data.name:=data.name+ ' / ' +DateTimeToStr(data.DateQuery) +' / Опрос просрочен';
             end
           else
             begin                          // Все хорошо
               PictIndex:= 21;
               data.name:=data.name+' / Ожидание опроса(авт.)'
             end;
         end
         else if data.ErrorQuery = 4 then    // Запрос опроса(авт.)'
         begin
               PictIndex:= 31;
               if (arrayParam[0]=1) or (arrayParam[1]=1) or (arrayParam[2]=1) then
                data.name:= 'Вкл.(авт)/ ' + data.name+ ' / ' +DateTimeToStr(data.DateQuery) +' / Опрос прерван'
               else data.name:=data.name+ ' / ' +DateTimeToStr(data.DateQuery) +' / Опрос прерван'
         end
       else if data.ErrorQuery = 0 then  // Запрос завершен
         begin
             PictIndex:= 30;
             if (arrayParam[0]=1) or (arrayParam[1]=1) or (arrayParam[2]=1) then
               data.name:= 'Вкл.(авт)/ ' + data.name+ ' / ' +DateTimeToStr(data.DateQuery)+' / Опрос завершен'
             else data.name:=data.name+ ' / ' +DateTimeToStr(data.DateQuery)+' / Опрос завершен';

         end;                                                              // End of BO 12/12/18
       nI  := CTI.Create(PictIndex,SD_QGSRV,PD_UNKNW,1);                       // BO 12/12/18
//       nI  := CTI.Create(30,SD_QGSRV,PD_UNKNW,1);
       nI.setQueryGroup(data.id);
       SetInNode(nI,rtChild,data.name);
       FreeAndNil(nI);
       //SetInNode(nI,SetInNode(nI,rtChild,data.name),'...');
      End;
      pTbl.UnlockList;
     End;
     ClearListAndFree(pTbl);
     End;
 except
    if pTbl<>Nil then begin
     pTbl.UnlockList;
     ClearListAndFree(pTbl);
    end;
    if pTblParam<>Nil then begin
     pTblParam.UnlockList;
     ClearListAndFree(pTblParam);
    end;
 end;
End;

procedure CL3TreeLoader.SetAddrTemplate_1Filter;
Var
    pTbl : SL3REGIONS;
    i    : Integer;
    nI   : CTI;
    strName   : string;
Begin
    FTree.FullCollapse;
    FreeTree;
    FTree.ReadOnly := True;
    m_pDB.GetL1Table(m_sTblL1);
    LoadAllowAbonBuf(bAllowAbon);
    if AbonAddress.GetRegTable(pTbl)=True then
    Begin
     for i:=0 to pTbl.Count-1 do
     Begin
     with pTbl.Items[i] do
     Begin
      if m_sbyEnable=1 then
      Begin
       nI      := CTI.Create(1,SD_REGIN,PD_UNKNW,m_nRegionID,m_sbyEnable);
       strName := m_sKSP+':'+m_nRegNM;
       SetInAddrNode_1(nI,Item,SetInNode(nI,Nil,strName));
       FreeAndNil(nI);
      End;
     End;
     End;
    End;

end;
procedure CL3TreeLoader.SetInAddrNode_1(nTI:CTI;pTbl:SL3ABONS;rtChild:TTreeNode);
Var
    i  : Integer;
    nI : CTI;
    strName : String;
Begin
    for i:=0 to pTbl.Count-1 do
    Begin
     with pTbl.Items[i],nTI.m_nCTI do
     Begin
      nI      := CTI.Create(1,SD_ABONT,PD_UNKNW,PRID,m_swABOID,m_sbyEnable);
      strName := m_sName+':'+m_sObject;
      if (m_sbyVisible=1) and (IsAbonAllow(m_swABOID)) then
      SetInAbonNode_1(nI,Item,SetInNode(nI,rtChild,strName), pTbl.Items[i].m_sReportVS, pTbl.Items[i].m_sTreeSettings);
      FreeAndNil(nI);
     End;
    End;
End;
{
        (I:2; G:'Мощность';       N:'Учет мощности'),
        (I:24;G:'Мощность';       N:'Учет мощности (Вид 2)'),
        (I:15;G:'Мощность';       N:'График мощности за день (Вид 1)'),
        (I:23;G:'Мощность';       N:'График мощности за день (Вид 2)'),

        (I:21;G:'Мощность';       N:'Замер часовой мощности'),
        (I:19;G:'Энергия';        N:'Ведомость показаний счетчика'),
        (I:3; G:'Энергия';        N:'Учет электрической энергии'),
        (I:12;G:'Энергия';        N:'Активная электроэнергия и мощность'),

        (I:13;G:'Энергия';        N:'Реактивная электроэнергия и мощность'),
        (I:20;G:'Энергия';        N:'Баланс по объекту'),
        (I:26;G:'Энергия';        N:'Учет электрической энергии (Вид 2)'), // Максимальные мощности за месяц посуточно
        (I:0; G:'Энергия';        N:'Приращение за месяц'),

        (I:10;G:'Энергия';        N:'Приращение за день'),
        (I:11;G:'Энергия';        N:'Объём покупной электроэнергии'),
        (I:1; G:'Показания';      N:'Расход за месяц'),
        (I:25;G:'Показания';      N:'Расход за месяц (Вид 2)'),

        (I:4; G:'Показания';      N:'Текущие показания электроэнергии'),
        (I:8; G:'Показания';      N:'Расход за сутки в течении месяца'),
        (I:9; G:'Показания';      N:'Расход за день'),
        (I:27;G:'Диагностические';N:'Векторная диаграмма'),

        (I:14;G:'Диагностические';N:'Полнота сбора данных'),
        (I:16;G:'Диагностические';N:'Полнота 30-минутных срезов'),
        (I:17;G:'Диагностические';N:'Суммарная коррекция времени'),
        (I:18;G:'Учет тепла';     N:'Показания теплосчетчика'),

        (I:22;G:'Учет тепла';     N:'Расчет тепла по показаниям теплосчетчика'),
        (I:5; G:'Стоимость';      N:'Расчет стоимости'),
        (I:6; G:'Настройки';      N:'Состав групп'),
        (I:7; G:'Настройки';      N:'Настройки отчетов')
}
procedure CL3TreeLoader.SetInAbonNode_1(nTI:CTI;pTbl:SL3INITTAG;rtChild:TTreeNode;_RVMask,TrMask:Int64);
Var
    i     : Integer;
    nI    : CTI;
    rtRep : TTreeNode;
Begin
    with nTI.m_nCTI do
    Begin
     if (TrMask and (1 shl PD_RPRTS)) <> 0 then
     begin
       nI:=CTI.Create(5,SD_PRIMT,PD_RPRTS,PRID,PAID,1); rtRep := SetInNode(nI,rtChild,'Отчеты'); nI.Destroy;
       if (_RVMask and MM)<>0 then Begin nI:=CTI.Create(23,SD_PRIMT,PD_RPRTS,PRID,PAID,1);SetReprts(nI, SetInNode(nI,rtRep,'Мощность'),       _RVMask);nI.Destroy;End;
       if (_RVMask and EM)<>0 then Begin nI:=CTI.Create(24,SD_PRIMT,PD_RPRTS,PRID,PAID,1);SetReprts(nI, SetInNode(nI,rtRep,'Энергия'),        _RVMask);nI.Destroy;End;
       if (_RVMask and PM)<>0 then Begin nI:=CTI.Create(25,SD_PRIMT,PD_RPRTS,PRID,PAID,1);SetReprts(nI, SetInNode(nI,rtRep,'Показания'),      _RVMask);nI.Destroy;End;
       if (_RVMask and DM)<>0 then Begin nI:=CTI.Create(26,SD_PRIMT,PD_RPRTS,PRID,PAID,1);SetReprts(nI, SetInNode(nI,rtRep,'Диагностические'),_RVMask);nI.Destroy;End;
       if (_RVMask and UM)<>0 then Begin nI:=CTI.Create(27,SD_PRIMT,PD_RPRTS,PRID,PAID,1);SetReprts(nI, SetInNode(nI,rtRep,'Учет тепла'),     _RVMask);nI.Destroy;End;
       if (_RVMask and SM)<>0 then Begin nI:=CTI.Create(28,SD_PRIMT,PD_RPRTS,PRID,PAID,1);SetReprts(nI, SetInNode(nI,rtRep,'Стоимость'),      _RVMask);nI.Destroy;End;
       if (_RVMask and NM)<>0 then Begin nI:=CTI.Create(29,SD_PRIMT,PD_RPRTS,PRID,PAID,1);SetReprts(nI, SetInNode(nI,rtRep,'Настройки'),      _RVMask);nI.Destroy;End;
     end;
     nI := CTI.Create(6,SD_PRIMT,PD_EVENS,PRID,PAID,1);
     SetInNode(nI,rtChild,'События');
     FreeAndNil(nI);
    End;
    //SetQweryServers(nTI,nTI.m_nCTI.PAID,rtChild);
End;
procedure CL3TreeLoader.SetQweryServers(nTI:CTI;swABOID:Integer;rtChild:TTreeNode);
var
    pTbl : SQWERYSRVS;
    nI   : CTI;
    i    : Integer;
    rtNext:TTreeNode;
Begin
    nI := CTI.Create(34,SD_CLUST,PD_QWERY,nTI.m_nCTI.PRID,nTI.m_nCTI.PAID,1);
    rtNext := SetInNode(nI,rtChild,'Расписание опроса');
    FreeAndNil(nI);;
    if m_pDB.GetQwerySRVTable(swABOID,-1,pTbl)=True then
    Begin
     for i:=0 to pTbl.Count-1 do
     with pTbl.Items[i],nTI.m_nCTI do
     Begin
      nI := CTI.Create(34,SD_ABONT,PD_QWERY,PRID,PAID,m_snSRVID,m_sbyEnable);
      SetInNode(nI,rtNext,m_sName);
      FreeAndNil(nI);
     End;
    End;
End;
procedure CL3TreeLoader.SetReprts_1(nTI:CTI;rtChild:TTreeNode);
Begin
End;
procedure CL3TreeLoader.OnLoadGroup(nTI:CTI;rtChild:TTreeNode);
Var
     pTbl    : SL3GROUPTAG;
     TreeSet : int64;
Begin
     TreeSet := m_pDB.GetGroupTreeSett(nTI.m_nCTI.PGID);
     if m_pDB.GetGroup(nTI.m_nCTI.PGID,pTbl)=True then
     SetVMeters_1(nTI,pTbl,rtChild,TreeSet);
End;
procedure CL3TreeLoader.SetVMeters_1(nTI:CTI;var pTbl:SL3GROUPTAG;rtChild:TTreeNode;nTS:Int64);
Var
    i,m_sbyType : Integer;
    nI          : CTI;
    rtRep       : TTreeNode;
    res         : integer;
Begin
    for i:=0 to pTbl.Item.Count-1 do
    Begin //PMID<=>Level
     with nTI.m_nCTI,pTbl.Item.Items[i] do
     Begin
      m_sbyPortID := GetRealPort(m_sbyPortID);
      nI := CTI.Create(PTIM,SD_VMETR,PD_VMETR,PRID,PAID,PGID,m_swVMID,m_swMID,m_sbyPortID,m_sbyEnable);
    // ************* BO 27/09/2018

      if (m_sddHOUSE = '') then SetPrims_1(nI,PVID,pTbl.Item.Items[i],SetInNode(nI,rtChild, m_sVMeterName),nTS)
      else SetPrims_1(nI,PVID,pTbl.Item.Items[i],SetInNode(nI,rtChild, m_sddHOUSE + ' ' + m_sVMeterName),nTS);  // m_sddHOUSE + ' ' +       m_sddHOUSE

    // ************* end of BO
      if (rtChild.Text='Квартиры') then
        begin
           res :=m_pDB.GET_QUERYSTATE(m_swVMID);
             if (res=1) then rtChild.Item[i].ImageIndex := 12;
        end;
      FreeAndNil(nI);
     End;
    End;
End;
procedure CL3TreeLoader.SetPrims_1(nTI:CTI;nLEV:Byte;var pTbl:SL3VMETERTAG;rtChild:TTreeNode;nTS:Int64);
Var
     nI : CTI;
Begin
     with nTI.m_nCTI do
     Begin
      if (nTS and (1 shl PD_ARCHV)) <> 0 then
      begin
       nI := CTI.Create(2,SD_PRIMT,PD_ARCHV,PRID,PAID,PGID,PVID,PMID,PPID,PSTT);
       SetParams_1(nI,pTbl,SetInNode(nI,rtChild,'Архивы'));
       FreeAndNil(nI);
      end;

      if (nTS and (1 shl PD_GRAPH)) <> 0 then
      begin
       nI := CTI.Create(4,SD_PRIMT,PD_GRAPH,PRID,PAID,PGID,PVID,PMID,PPID,PSTT);
       //if nLEV<>2 then
       SetParams_1(nI,pTbl,SetInNode(nI,rtChild,'Графики'));
       FreeAndNil(nI);
      end;

      if (nTS and (1 shl PD_LIMIT)) <> 0 then
      begin
       nI := CTI.Create(7,SD_PRIMT,PD_LIMIT,PRID,PAID,PGID,PVID,PMID,PPID,PSTT);
       SetParams_1(nI,pTbl,SetInNode(nI,rtChild,'Лимиты'));
       FreeAndNil(nI);
      end;

      if (nTS and (1 shl PD_PERIO)) <> 0 then
      begin
       nI := CTI.Create(3,SD_PRIMT,PD_PERIO,PRID,PAID,PGID,PVID,PMID,PPID,PSTT);
       //if (nLEV=0)or(nLEV=1) then
       SetParams_1(nI,pTbl,SetInNode(nI,rtChild,'Периодические'));
       FreeAndNil(nI);
      end;

      if (nTS and (1 shl PD_CURRT)) <> 0 then
      begin
       nI := CTI.Create(1,SD_PRIMT,PD_CURRT,PRID,PAID,PGID,PVID,PMID,PPID,PSTT);
       SetInNode(nI,rtChild,'Текущие');
       FreeAndNil(nI);
      end;

      {
      nI := CTI.Create(33,SD_PRIMT,PD_MONIT,PRID,PAID,PGID,PVID,PMID,PPID,PSTT);
       if (pTblG.M_NGROUPLV=0)and(pTblG.M_NGROUPLV<>2) then
       SetInNode(nI,rtChild,'Мониторинг');
      nI.Destroy;
      }
      if (nTS and (1 shl PD_VECDG)) <> 0 then
      begin
       nI := CTI.Create(21,SD_PRIMT,PD_VECDG,PRID,PAID,PGID,PVID,PMID,PPID,PSTT);
       if (nLEV=0)and(nLEV<>2) then
       SetInNode(nI,rtChild,'Векторная диаграмма');
       FreeAndNil(nI);
      end;
      {
      nI := CTI.Create(22,SD_PRIMT,PD_CTRLF,PRID,PAID,PGID,PVID,PMID,PPID,PSTT);
       if (pTblG.M_NGROUPLV=0)and(pTblG.M_NGROUPLV=0) then
       SetInNode(nI,rtChild,'Управление');
      nI.Destroy;
      }
      if (nTS and (1 shl PD_CHNDG)) <> 0 then
      begin
       nI := CTI.Create(15,SD_PRIMT,PD_CHNDG,PRID,PAID,PGID,PVID,PMID,PPID,PSTT);
       //if nLEV=0 then
       SetInNode(nI,rtChild,'Замены');
       FreeAndNil(nI);
      end;

      if (nTS and (1 shl PD_EVENS)) <> 0 then
      begin
       nI := CTI.Create(6,SD_PRIMT,PD_EVENS,PRID,PAID,PGID,PVID,PMID,PPID,PSTT);
       SetInNode(nI,rtChild,'События');
       FreeAndNil(nI);
      end;

      {
       nI := CTI.Create(34,SD_PRIMT,PD_QWERY,PRID,PAID,PGID,PVID,PMID,PPID,PSTT);
       //if (pTblG.M_NGROUPLV=0)and(pTblG.M_NGROUPLV<>2) then
       SetInNode(nI,rtChild,'Сервер опроса');
       nI.Destroy;
      }
     End;
End;
procedure CL3TreeLoader.SetParams_1(nTI:CTI;var pTbl:SL3VMETERTAG;rtChild:TTreeNode);
Var
    i       : Integer;
    strName : String;
    nI      : CTI;
Begin
    if nTI.m_nCTI.PNID=PD_CURRT then exit;
    for i:=0 to pTbl.Item.Count-1 do
    Begin
     with nTI.m_nCTI,pTbl.Item.Items[i] do
     if (PNID=m_sblSaved)or(PNID=PD_LIMIT) then
     Begin
      nI       := CTI.Create(PTIM,SD_VPARM,PNID,0,PAID,PGID,PVID,PMID,PPID,m_swParamID,m_sblTarif,m_sblSaved,m_swStatus);
      strName  := m_nCommandList.Strings[m_swParamID];
      if m_sblCalculate=1 then SetInNode(nI,rtChild,strName);
      FreeAndNil(nI);
     End;
    End;
End;
function CL3TreeLoader.GetRealPort(nPort:Integer):Integer;
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
End;

procedure CL3TreeLoader.LoadAllowAbonBuf(var buf : array of integer);
var AllowBufStr : string;
begin
   AllowBufStr := m_pDB.GetAllowAbonStr(m_nCurrUsr);
   SetLength(bAllowAbon, Length(AllowBufStr) div 2);
   GetIntArrayFromStr(AllowBufStr, bAllowAbon);
end;

function CL3TreeLoader.IsAbonAllow(ABOID: integer):boolean;
var i : integer;
begin
   Result := false;
   if (Length(bAllowAbon) = 0) then
     exit;
   if (bAllowAbon[0] = -1) then
   begin
     Result := true;
     exit;
   end;
   for i := 0 to Length(bAllowAbon) - 1 do
     if bAllowAbon[i] = ABOID then
     begin
       Result := true;
       exit;
     end;
end;

procedure CL3TreeLoader.RefreshTreeImageText(IDGID,STATE:Integer);
Var
    i       : Integer;
    pIND    : PCTI;
    Str1    : String;    
Begin
  Str1:='Вкл.(авт)';
    for i:=0 to FTree.Items.Count-1 do
     begin
       // if  FTree.Items[i].Text = 'Группы опроса' then
         begin
         pIND := FTree.Items[i].Data;
            if (IDGID=pIND.m_nCTI.PQGD)then
               begin
                 case (STATE) of
                 0: begin
                     FTree.Items[i].ImageIndex   := 30;
                     FTree.Items[i].SelectedIndex:= 30;
                     if Pos(Str1, FTree.Items[i].Text) > 0 then
                      FTree.Items[i].Text := Str1+'/ '+  m_pDB.GetGroupQueryName(pIND.m_nCTI.PQGD) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / Опрос завершен'
                     else
                      FTree.Items[i].Text := m_pDB.GetGroupQueryName(pIND.m_nCTI.PQGD) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / Опрос завершен'
                    end;
                 1: begin
                     FTree.Items[i].ImageIndex   := 16;
                     FTree.Items[i].SelectedIndex:= 16;
                     if Pos(Str1, FTree.Items[i].Text) > 0 then
                      FTree.Items[i].Text := Str1+'/ '+  m_pDB.GetGroupQueryName(pIND.m_nCTI.PQGD) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / Опрос'
                     else
                      FTree.Items[i].Text := m_pDB.GetGroupQueryName(pIND.m_nCTI.PQGD) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / Опрос';
                    end;
                 2: begin
                     FTree.Items[i].ImageIndex   := 21;
                     FTree.Items[i].SelectedIndex:= 21;
                     if Pos(Str1, FTree.Items[i].Text) > 0 then
                      FTree.Items[i].Text := Str1+'/ '+  m_pDB.GetGroupQueryName(pIND.m_nCTI.PQGD) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / Ожидание опроса(руч.)'
                     else
                      FTree.Items[i].Text := m_pDB.GetGroupQueryName(pIND.m_nCTI.PQGD) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / Ожидание опроса(руч.)';
                    end;
                 3: begin
                     FTree.Items[i].ImageIndex   := 21;
                     FTree.Items[i].SelectedIndex:= 21;
                     if Pos(Str1, FTree.Items[i].Text) > 0 then
                      FTree.Items[i].Text := Str1+'/ '+   m_pDB.GetGroupQueryName(pIND.m_nCTI.PQGD) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / Ожидание опроса(авт.)'
                     else
                      FTree.Items[i].Text := m_pDB.GetGroupQueryName(pIND.m_nCTI.PQGD) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / Ожидание опроса(авт.)';
                    end;
                 end;
                 break;
               end;
         end;
     end;
End;

end.

