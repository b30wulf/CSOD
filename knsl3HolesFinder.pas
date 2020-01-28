unit knsl3HolesFinder;

interface
uses
    Windows, Classes,utltypes,utlconst, utlTimeDate, Sysutils,utldynconnect;

type
    SHALLSDATES = packed record
     Count : Integer;
     Items : array of TDateTime;
    end;
    SCMPLTAG = packed record
     Count : Integer;
     Items : array of int64;
    End;
    CHolesFinder = class
    private
      m_nIsInit : Boolean;
      m_pMDB    : CDBDynamicConn;
      function  FindHolesInGraph(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsDates : SHALLSDATES):boolean;
      function  FindHolesInArch(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsDates : SHALLSDATES):boolean;
      function  FindDateInArch(Date : TDateTime; var pTable : CCDatas) : integer;
      function  FindDateInGraph(Date : integer; var pTable : L3GRAPHDATAS) : integer;
      function  FindHolesInPeriod(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsDates : SHALLSDATES):boolean;
      function  GetHolesInGraph(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsMask : SCMPLTAG):boolean;
      function  GetHolesInGraph48(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsMask : SCMPLTAG):boolean;
      function  GetHolesInDayArch(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsMask : SCMPLTAG):boolean;
      function  GetHolesInMontArch(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsMask : SCMPLTAG):boolean;
      function  TrueArchiveDate(CMDID : integer; dt_Date : TDateTime) : TDateTime;
      function  AddBuffer(dtDate:TDateTime):Boolean;
    public
      m_nDT     : SHALLSDATES;
      function  FindStartDate(CMDID : integer; dt_Date : TDateTime) : TDateTime;
      procedure IncDateTime(CMDID : integer; var dt_Date : TDateTime);
      procedure DecDateTime(CMDID : integer; var dt_Date : TDateTime);
      constructor Create(pMDB:CDBDynamicConn);
      destructor Destroy;override;
      function FindHall(nCLSID:Integer;dtBegin, dtEnd : TDateTime; VMID, CMDID : integer; var HallsDates : SHALLSDATES) : boolean;
      function FindHallMask(nCLSID:Integer;dtBegin, dtEnd : TDateTime; VMID, CMDID : integer; var HallsMask : SCMPLTAG) : boolean;
      //function FindHallEx(dtBegin, dtEnd : TDateTime; VMID, CMDID : integer) : boolean;
      procedure AddToBuffer(var pDT:SHALLSDATES);
      procedure InitFinder;
      procedure FreeFinder;
      procedure GetBuffer(var pDT:SHALLSDATES);
    End;
    PCHolesFinder =^ CHolesFinder;
implementation

constructor CHolesFinder.Create(pMDB:CDBDynamicConn);
begin
     m_pMDB := pMDB;
     m_nIsInit := False;
     //InitFinder;
     //m_pMDB := m_pDB.CreateConnect;
end;

destructor CHolesFinder.Destroy;
begin
     m_pMDB := Nil;
     inherited Destroy;
end;
procedure CHolesFinder.InitFinder;
Var
     i : Integer;
Begin
     if m_nIsInit=False then
     Begin
      m_nIsInit := True;
      SetLength(m_nDT.Items,MAX_FINDCL);
      for i:=0 to MAX_FINDCL-1 do m_nDT.Items[i]:=-1;
     End;
End;
procedure CHolesFinder.FreeFinder;
Begin
     SetLength(m_nDT.Items,0);
     m_nDT.Count := 0;
     m_nIsInit   := False;
End;
{
function CHolesFinder.FindHallEx(dtBegin, dtEnd : TDateTime; VMID, CMDID : integer) : boolean;
Var
     pDT : SHALLSDATES;
     i : Integer;
Begin
     if FindHall(dtBegin,dtEnd,VMID,CMDID,pDT)=True then
     Begin
      for i:=0 to pDT.Count-1 do
      AddBuffer(pDT.Items[i]);
     End;
End;
}
procedure CHolesFinder.AddToBuffer(var pDT:SHALLSDATES);
Var
     i : Integer;
Begin
     for i:=0 to pDT.Count-1 do
     AddBuffer(pDT.Items[i]);
End;
procedure CHolesFinder.GetBuffer(var pDT:SHALLSDATES);
Var
     i : Integer;
Begin
     SetLength(pDT.Items,m_nDT.Count);
     pDT.Count := m_nDT.Count;
     for i:=0 to m_nDT.Count-1 do
     pDT.Items[i]:=m_nDT.Items[i];
End;
function CHolesFinder.FindHallMask(nCLSID:Integer;dtBegin, dtEnd : TDateTime; VMID, CMDID : integer; var HallsMask : SCMPLTAG) : boolean;
Begin
   case nCLSID of
        CLS_DAY,CLS_MONT : Result := GetHolesInDayArch(dtBegin, dtEnd, VMID, CMDID, HallsMask);
        CLS_GRAPH48      : Result := GetHolesInGraph(dtBegin, dtEnd, VMID, CMDID, HallsMask);
        CLS_PNET         : Result := GetHolesInGraph48(dtBegin, dtEnd, VMID, CMDID, HallsMask);
   else
     begin
       Result := false;
       HallsMask.Count := 0;
     end;
   end;
End;
{
     CLS_MGN      = 1;
     CLS_GRAPH48  = 4;
     CLS_DAY      = 8;
     CLS_MONT     = 9;
     CLS_EVNT     = 11;
     CLS_TIME     = 12;
     CLS_PNET     = 13;
}
function CHolesFinder.FindHall(nCLSID:Integer;dtBegin, dtEnd : TDateTime; VMID, CMDID : integer; var HallsDates : SHALLSDATES) : boolean;
begin
   case nCLSID of
        CLS_DAY,CLS_MONT : Result := FindHolesInArch(dtBegin, dtEnd, VMID, CMDID, HallsDates);
        CLS_GRAPH48      : Result := FindHolesInGraph(dtBegin, dtEnd, VMID, CMDID, HallsDates);
        CLS_PNET         : Result := FindHolesInPeriod(dtBegin, dtEnd, VMID, CMDID, HallsDates);
   else
     begin
       Result := false;
       HallsDates.Count := 0;
     end;
   end;
end;
function CHolesFinder.GetHolesInGraph(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsMask : SCMPLTAG):boolean;
Var
    GraphData : L3GRAPHDATAS;
    i,j,Item : Integer;
Begin
    m_pMDB.GetGraphDates(dtBeg, trunc(dtEnd), VMID, CMDID, GraphData);
    j:=0;
    for i := trunc(dtBeg) downto trunc(dtEnd+1) do
    begin
     Item := FindDateInGraph(i, GraphData);
     if Item = -1 then
      HallsMask.Items[j] := 0
     else
      HallsMask.Items[j] := GraphData.Items[Item].m_sMaskReRead;
      j:=j+1;
     end;
End;
function CHolesFinder.GetHolesInGraph48(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsMask : SCMPLTAG):boolean;
Var
    GraphData : L3GRAPHDATAS;
    i,j,Item : Integer;
Begin
    m_pMDB.GetGraphDatesPD48(dtBeg, trunc(dtEnd), VMID, CMDID, GraphData);
    j:=0;
    for i := trunc(dtBeg) downto trunc(dtEnd+1) do
    begin
     Item := FindDateInGraph(i, GraphData);
     if Item = -1 then
      HallsMask.Items[j] := 0
     else
      HallsMask.Items[j] := GraphData.Items[Item].m_sMaskReRead;
      j:=j+1;
     end;
End;
function CHolesFinder.GetHolesInDayArch(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsMask : SCMPLTAG):boolean;
Var
    ArchData : CCDatas;
    j,Item : Integer;
    TempDate : TDateTime;
    Year, Month, Day,oldMonth: Word;
    sh : int64;
Begin
    j := 0;
    sh := 1;
    TempDate := FindStartDate(CMDID, dtBeg);
    DecodeDate(TempDate,Year, Month, Day);
    oldMonth := Month;
    m_pMDB.GetArchDates(TempDate, dtEnd, VMID, CMDID, ArchData);
    while (TempDate>dtEnd)and(j<HallsMask.Count) do
    begin
     Item := FindDateInArch(TempDate, ArchData);
     if Item<>-1 then
     HallsMask.Items[j] := HallsMask.Items[j] or (sh shl (Day-1));
     DecDateTime(CMDID, TempDate);
     DecodeDate(TempDate,Year, Month, Day);
     if Month<>oldMonth then
     j:=j+1;
     oldMonth := Month;
    end;
End;
function CHolesFinder.GetHolesInMontArch(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsMask : SCMPLTAG):boolean;
Var
    ArchData : CCDatas;
    j,Item : Integer;
    TempDate : TDateTime;
Begin
    j := 0;
    TempDate := FindStartDate(CMDID, dtBeg);
    m_pMDB.GetArchDates(TempDate, dtEnd, VMID, CMDID, ArchData);
    while (TempDate>dtEnd)and(j<HallsMask.Count) do
    begin
     Item := FindDateInArch(TempDate, ArchData);
     if Item<>-1 then
     HallsMask.Items[j] := 1;
     DecDateTime(CMDID, TempDate);
     j:=j+1;
    end;
End;
function CHolesFinder.FindHolesInGraph(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsDates : SHALLSDATES):boolean;
var GraphData             : L3GRAPHDATAS;
    i, nCykl, nNode, Item : integer;
    bFH                   : boolean;
begin
   m_pMDB.GetGraphDates(dtBeg, trunc(dtEnd), VMID, CMDID, GraphData);
   HallsDates.Count := 0;
   nNode := 0;
   Result := false;

   for nCykl := 0 to 1 do
   begin
     if (nCykl = 1) and (HallsDates.Count > 0) then
     begin
       SetLength(HallsDates.Items, HallsDates.Count);
       Result := true;
     end;

     for i := trunc(dtEnd) to trunc(dtBeg) do
     begin
       bFH := false;
       Item := FindDateInGraph(i, GraphData);

       if Item = -1 then
         bFH := true
       else if (GraphData.Items[Item].m_sMaskReRead <> $FFFFFFFFFFFF)or(trunc(Now)=trunc(i)) then
         bFH := true;

       if bFH and (nCykl = 0) then
         HallsDates.Count := HallsDates.Count + 1   //В первом цикле исчем количество пропусков
       else if bFH then
       begin
         HallsDates.Items[nNode] := i;              //Во втором заполняем массив дат
         nNode := nNode + 1;
       end;

     end;
   end;
end;
function CHolesFinder.FindHolesInPeriod(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsDates : SHALLSDATES):boolean;
var GraphData             : L3GRAPHDATAS;
    i, nCykl, nNode, Item : integer;
    bFH                   : boolean;
begin
   m_pMDB.GetGraphDatesPD48(dtBeg, trunc(dtEnd), VMID, CMDID, GraphData);
   HallsDates.Count := 0;
   nNode := 0;
   Result := false;

   for nCykl := 0 to 1 do
   begin
     if (nCykl = 1) and (HallsDates.Count > 0) then
     begin
       SetLength(HallsDates.Items, HallsDates.Count);
       Result := true;
     end;

     for i := trunc(dtEnd) to trunc(dtBeg) do
     begin
       bFH := false;
       Item := FindDateInGraph(i, GraphData);

       if Item = -1 then
         bFH := true
       else if (GraphData.Items[Item].m_sMaskReRead <> $FFFFFFFFFFFF)or(trunc(Now)=trunc(i)) then
         bFH := true;

       if bFH and (nCykl = 0) then
         HallsDates.Count := HallsDates.Count + 1   //В первом цикле исчем количество пропусков
       else if bFH then
       begin
         HallsDates.Items[nNode] := i;              //Во втором заполняем массив дат
         nNode := nNode + 1;
       end;

     end;
   end;
end;
function CHolesFinder.FindHolesInArch(dtBeg, dtEnd : TDateTime; VMID, CMDID: integer; var HallsDates : SHALLSDATES):boolean;
var ArchData           : CCDatas;
    TempDate           : TDateTime;
    Item, nCykl, nNode : integer;
begin
   TempDate := FindStartDate(CMDID, dtEnd);
   m_pMDB.GetArchDates(dtBeg, TempDate, VMID, CMDID, ArchData);
   HallsDates.Count := 0;
   Result           := false;
   nNode            := 0;
   for nCykl := 0 to 1 do
   begin
     if (nCykl = 1) and (HallsDates.Count > 0) then
     begin
       TempDate := FindStartDate(CMDID, dtEnd);
       SetLength(HallsDates.Items, HallsDates.Count);  
       Result := true;
     end;
     
     while TempDate <= dtBeg do
     begin
       Item := FindDateInArch(TempDate, ArchData);

       if Item = -1 then
       begin
         if nCykl = 0 then
           HallsDates.Count := HallsDates.Count + 1
         else
         begin
           HallsDates.Items[nNode] := TrueArchiveDate(CMDID, TempDate);
           nNode := nNode + 1;
         end;
       end;
       IncDateTime(CMDID, TempDate);
     end;
   end;
end;
function CHolesFinder.FindDateInArch(Date : TDateTime; var pTable : CCDatas) : integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if trunc(Date) = trunc(pTable.Items[i].m_sTime) then
     begin
       Result := i;
       break;
     end;
end;

function CHolesFinder.FindDateInGraph(Date : integer; var pTable : L3GRAPHDATAS) : integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if Date = trunc(pTable.Items[i].m_sdtDate) then
     begin
       Result := i;
       break;
     end;
end;
{
  QRY_POD_TRYB_HEAT     = 75;   //Расход тепла в подающем трубопроводе (Гкал)
  QRY_POD_TRYB_RASX     = 76;   //Расход воды в подающем трубопроводе  (т)
  QRY_POD_TRYB_TEMP     = 77;   //Температура воды в подающем трубопроводе  (°C)
  QRY_POD_TRYB_V        = 78;   //Расход воды (объем) в подающем водопроводе (м3)

  QRY_OBR_TRYB_HEAT     = 79;   //Расход тепла в обратном трубопроводе (Гкал)
  QRY_OBR_TRYB_RASX     = 80;   //Расход воды в обратном трубопроводе (т)
  QRY_OBR_TRYB_TEMP     = 81;   //Температура воды в обратном трубопроводе (°C)
  QRY_OBR_TRYB_V        = 82;   //Расход воды (объем) в обратном трубопроводе (м3)

  QRY_TEMP_COLD_WAT_DAY = 83;   //Температура холодной воды  (°C)
  QRY_POD_TRYB_RUN_TIME = 84;   //Время наработки в подающем трубопроводе (ч)
  QRY_WORK_TIME_ERR     = 85;   //Время работы c каждой ошибкой (ч)
  QRY_LIM_TIME_KORR     = 86;   //Выход за пределы коррекции
}
function  CHolesFinder.FindStartDate(CMDID : integer; dt_Date : TDateTime) : TDateTime;
begin
   if (CMDID>=QRY_MGAKT_POW_S)and(CMDID<=QRY_KPRTEL_KE) then Begin Result := trunc(dt_Date);exit;End;
   case CMDID of
     QRY_POD_TRYB_HEAT,QRY_POD_TRYB_RASX,QRY_POD_TRYB_TEMP,QRY_POD_TRYB_V,
     QRY_OBR_TRYB_HEAT,QRY_OBR_TRYB_RASX,QRY_OBR_TRYB_TEMP,QRY_OBR_TRYB_V,
     QRY_TEMP_COLD_WAT_DAY,QRY_POD_TRYB_RUN_TIME,QRY_WORK_TIME_ERR,QRY_LIM_TIME_KORR,
     QRY_RASH_DAY_V,
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM, QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM,
     QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM, QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM : Result := trunc(dt_Date);
     QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM, QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM,
     QRY_RASH_MON_V,
     QRY_NACKM_POD_TRYB_HEAT,QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM, QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM : Result := cDateTimeR.GetBeginMonth(dt_Date);
     else Result := trunc(dt_Date);
   end;
end;
procedure CHolesFinder.IncDateTime(CMDID : integer; var dt_Date : TDateTime);
begin
   if (CMDID>=QRY_MGAKT_POW_S)and(CMDID<=QRY_KPRTEL_KE) then Begin dt_Date := trunc(dt_Date) + 1;exit;End;
   case CMDID of
     QRY_POD_TRYB_HEAT,QRY_POD_TRYB_RASX,QRY_POD_TRYB_TEMP,QRY_POD_TRYB_V,
     QRY_OBR_TRYB_HEAT,QRY_OBR_TRYB_RASX,QRY_OBR_TRYB_TEMP,QRY_OBR_TRYB_V,
     QRY_TEMP_COLD_WAT_DAY,QRY_POD_TRYB_RUN_TIME,QRY_WORK_TIME_ERR,QRY_LIM_TIME_KORR,
     QRY_RASH_DAY_V,
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM, QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM,
     QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM, QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM  : dt_Date := trunc(dt_Date) + 1;
     QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM, QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM,
     QRY_RASH_MON_V,
     QRY_NACKM_POD_TRYB_HEAT,QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM, QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : cDateTimeR.IncMonth(dt_Date);
     else dt_Date := dt_Date + 500;
   end;
end;
procedure CHolesFinder.DecDateTime(CMDID : integer; var dt_Date : TDateTime);
begin
   if (CMDID>=QRY_MGAKT_POW_S)and(CMDID<=QRY_KPRTEL_KE) then Begin dt_Date := trunc(dt_Date) - 1;exit;End;
   case CMDID of
     QRY_POD_TRYB_HEAT,QRY_POD_TRYB_RASX,QRY_POD_TRYB_TEMP,QRY_POD_TRYB_V,
     QRY_OBR_TRYB_HEAT,QRY_OBR_TRYB_RASX,QRY_OBR_TRYB_TEMP,QRY_OBR_TRYB_V,
     QRY_TEMP_COLD_WAT_DAY,QRY_POD_TRYB_RUN_TIME,QRY_WORK_TIME_ERR,QRY_LIM_TIME_KORR,
     QRY_RASH_DAY_V,
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM, QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM,
     QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM, QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM  : dt_Date := trunc(dt_Date) -1;
     QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM, QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM,
     QRY_RASH_MON_V,
     QRY_NACKM_POD_TRYB_HEAT,QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM, QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : cDateTimeR.DecMonth(dt_Date);
     else dt_Date := dt_Date + 500;
   end;
end;

function CHolesFinder.TrueArchiveDate(CMDID : integer; dt_Date : TDateTime) : TDateTime;
begin
   case CMDID of
     QRY_POD_TRYB_HEAT,QRY_POD_TRYB_RASX,QRY_POD_TRYB_TEMP,QRY_POD_TRYB_V,
     QRY_OBR_TRYB_HEAT,QRY_OBR_TRYB_RASX,QRY_OBR_TRYB_TEMP,QRY_OBR_TRYB_V,
     QRY_TEMP_COLD_WAT_DAY,QRY_POD_TRYB_RUN_TIME,QRY_WORK_TIME_ERR,QRY_LIM_TIME_KORR : Result := trunc(dt_Date);
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM, QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM  : Result := trunc(dt_Date - 1);
     QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM, QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM,QRY_RASH_DAY_V  : Result := trunc(dt_Date);
     QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM, QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM  : Result := cDateTimeR.DecMonth(dt_Date);
     QRY_NACKM_POD_TRYB_HEAT,QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM, QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM,QRY_RASH_MON_V  : Result := cDateTimeR.GetBeginMonth(dt_Date);
     else Result := trunc(Now);
   end;
end;
function  CHolesFinder.AddBuffer(dtDate:TDateTime):Boolean;
Var
     i : Integer;
Begin
     Result := False;
     for i:=0 to MAX_FINDCL-1 do
     Begin
      if (m_nDT.Items[i]=dtDate) then exit;
      if (m_nDT.Items[i]=-1) then
      Begin
       m_nDT.Items[i]:=dtDate;
       m_nDT.Count := m_nDT.Count + 1;
       Result := True;
       exit;
      End;
     End;
End;

end.
