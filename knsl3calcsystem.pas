unit knsl3calcsystem;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
controls,utldatabase,knsl5tracer,knsl3EventBox,knsl3HolesFinder,utlTimeDate,knsl3datamatrix,knsl3jointable;
type
     TSaveProc = procedure() of object;
     CCalcSystem = class
     private
      m_pD  : PCDBDynamicConn;
      m_pMX : PCDataMatrix;
      m_nDT : SQWCLSS;
      m_nPrmID : Integer;
      m_nCLSID : Integer;
      m_nSRVID : Integer;
      FSaveProc : TSaveProc;
      holesFinder : CHolesFinder;
      procedure CalcRoutine(var pMsg:CMessage);
      procedure Calculate;
      procedure Calc(byLevel:Byte);
      procedure ClearDMX;
      procedure Flush;
      procedure Next;
      procedure CreateJobs(var pMsg:CMessage);
      procedure OnClearDMX(var pMsg:CMessage);
      function saveToDB(var pMsg:CMessage):Boolean;
      function getTypeParam(cmdID:Integer):Integer;
      function isTrueValue(data : L3CURRENTDATA):Boolean;
     public
      constructor Create(pMX:PCDataMatrix);
      destructor Destroy;override;
      procedure Run;
      function EventHandler(var pMsg:CMessage):Boolean;
      function ExtractData(var pMsg:CMessage):Boolean;
     public
      property PSaveProc : TSaveProc read FSaveProc write FSaveProc;
     End;
implementation
//CCalcSystem
constructor CCalcSystem.Create(pMX:PCDataMatrix);
Begin
     m_pMX := pMX;
     m_pD := m_pDB.CreateConnect;
     holesFinder := CHolesFinder.Create(nil);
     //SendLockMX(2);
     //SendLockMX(3);
     //SendUnLockMX(2);
     //SendUnLockMX(3);
End;
destructor CCalcSystem.Destroy;
Begin
End;
function CCalcSystem.EventHandler(var pMsg:CMessage):Boolean;
Begin
     case pMsg.m_sbyType of
          CSRV_START_CALC : CalcRoutine(pMsg);
          CSRV_CLEAR_DMTX : OnClearDMX(pMsg);
     End;
End;
procedure CCalcSystem.OnClearDMX(var pMsg:CMessage);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
     pTable : SL3GROUPTAG;
     i   : Integer;
Begin
     if(m_pMX=nil) then exit;
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     Move(pDS.m_sbyInfo[0],sQC,sizeof(SQWERYCMDID)); //m_snAID
     if m_pDB.GetAbonVMetersTable(sQC.m_snABOID,-1,pTable) then
     Begin
      for i:=0 to pTable.Item.Count-1 do
      Begin
       if (sQC.m_snVMID=-1)or(sQC.m_snVMID=pTable.Item.Items[i].m_swVMID) then
       m_pMX.FreeData(pTable.Item.Items[i].m_swVMID,sQC.m_snPrmID);
      End;
      //ClearDXM(pTable.Item.Items[i].m_swVMID,sQC.m_snPrmID);
     End;
End;
procedure CCalcSystem.CalcRoutine(var pMsg:CMessage);
var
     byPrmID:Integer;
Begin
     //if Assigned(PSaveProc) then PSaveProc;
     CreateJobs(pMsg);
     Calculate;
     ClearDMX;
     Next;
End;
procedure CCalcSystem.CreateJobs(var pMsg:CMessage);
Var
     i : Integer;
Begin
     m_nDT.Count := pMsg.m_swObjID;
     m_nSRVID    := pMsg.m_sbyServerID;
     m_nCLSID    := pMsg.m_sbyTypeIntID;
     m_nPrmID    := pMsg.m_sbyDirID;
     SetLength(m_nDT.Items,m_nDT.Count);
     for i:=0 to m_nDT.Count-1 do
     Move(pMsg.m_sbyInfo[2*i],m_nDT.Items[i],2);
     TraceL(4,0,'(__)CCSMD::>Jobs SRV:'+IntToStr(m_nSRVID)+' CLS:'+IntToStr(m_nCLSID)+' PRM:'+IntToStr(m_nPrmID)+' CNT:'+IntToStr(m_nDT.Count));
End;
procedure CCalcSystem.Calculate;
Var
     i : Integer;
Begin
     //for i:=0 to MAX_GVR do Calc(i);
     if(m_pMX=nil) then exit;
     Calc(0);
     Calc(1);
     Calc(2);
     Calc(3);
     Calc(4);
End;
procedure CCalcSystem.Calc(byLevel:Byte);
Var
     i : Integer;
Begin
     for i:=0 to m_nDT.Count-1 do
     Begin
      if Assigned(m_pMX.m_nDMX[m_nDT.Items[i],m_nPrmID]) then
      with m_pMX.m_nDMX[m_nDT.Items[i],m_nPrmID] do
      Begin
       if m_sbyLevel=byLevel then
       Begin
        m_pMX.Calculate(m_nDT.Items[i],m_nPrmID);
        m_pMX.Flush(m_nDT.Items[i],m_nPrmID);
        TraceL(4,0,'(__)CCSMD::>CalcL '+IntToStr(byLevel)+' VMID:'+IntToStr(m_nDT.Items[i])+' PRM:'+IntToStr(m_nPrmID));
       End;
      End;
     End;
End;
procedure CCalcSystem.ClearDMX;
Var
     i : Integer;
Begin
     if(m_pMX=nil) then exit;
     for i:=0 to m_nDT.Count-1 do
     Begin
       m_pMX.FreeData(m_nDT.Items[i],m_nPrmID);
       TraceL(4,0,'(__)CCSMD::>Clear VMID:'+IntToStr(m_nDT.Items[i])+' PRM:'+IntToStr(m_nPrmID));
       //EventBox.FixEvents(ET_CRITICAL,'(__)CCSMD::>Clear VMID:'+IntToStr(m_nDT.Items[i])+' PRM:'+IntToStr(m_nPrmID));
     End;
End;
procedure CCalcSystem.Flush;
Var
     i : Integer;
Begin
     if(m_pMX=nil) then exit;
     for i:=0 to m_nDT.Count-1 do
     Begin
      m_pMX.Flush(m_nDT.Items[i],m_nPrmID);
      TraceL(4,0,'(__)CCSMD::>Flush VMID:'+IntToStr(m_nDT.Items[i])+' PRM:'+IntToStr(m_nPrmID));
     End;
End;
procedure CCalcSystem.Next;
Var
     pDS : CMessageData;
Begin
     pDS.m_swData0 := m_nSRVID;
     pDS.m_swData1 := m_nCLSID;
     pDS.m_swData2 := m_nPrmID;
     SendMsgData(BOX_QSRV,0,DIR_CSTOQS,QSRV_CALC_COMPL_REQ,pDS);
     TraceL(4,0,'(__)CCSMD::>Next SRV:'+IntToStr(m_nSRVID)+' CLS:'+IntToStr(m_nCLSID)+' PRM:'+IntToStr(m_nPrmID));
     //EventBox.FixEvents(ET_CRITICAL,'(__)CCSMD::>Next SRV:'+IntToStr(m_nSRVID)+' CLS:'+IntToStr(m_nCLSID)+' PRM:'+IntToStr(m_nPrmID));
End;
function CCalcSystem.ExtractData(var pMsg:CMessage):Boolean;
Begin
     case pMsg.m_sbyType of
          DL_DATARD_IND:
          Begin
            if(m_pMX<>nil) then
               Result := m_pMX.ExtractData(pMsg) else
               Result := saveToDB(pMsg);
          End;
     End;
End;

function CCalcSystem.saveToDB(var pMsg:CMessage):Boolean;
Var
     data : L3CURRENTDATA;
     dDT  : CDTTime;
Begin
     data.m_swVMID  := pMsg.m_swObjID;
     data.m_swCMDID := pMsg.m_sbyInfo[1];
     data.m_swTID   := pMsg.m_sbyInfo[8];
     data.m_swSID   := pMsg.m_sbyServerID;
     Move(pMsg.m_sbyInfo[2],dDT,sizeof(CDTTime));
     if (dDT.Year=0)or(dDT.Month=0)or(dDT.Day=0)or(dDT.Month>12)or(dDT.Hour>23)or(dDT.Month>12)or(dDT.Day>31)or(dDT.Sec>59) then exit else
     data.m_sTime   := EncodeDate(2000+dDT.Year,dDT.Month,dDT.Day)+EncodeTime(dDT.Hour,dDT.Min,dDT.Sec,0);
     Move(pMsg.m_sbyInfo[9],data.m_sfValue,sizeof(Double));
     case getTypeParam(data.m_swCMDID) of
          SV_CURR_ST:
          Begin
            m_pD.SetCurrentParamNoBlock(data);
            if not ((data.m_swCMDID>=QRY_ENERGY_SUM_EP) and (data.m_swCMDID<=QRY_ENERGY_SUM_EP)) then
            m_pD.UpdatePDTFilds_48(data);
          End;
          SV_ARCH_ST:
          Begin
           //if isTrueValue(data) then
           m_pD.AddArchDataNoBlock(data);
          End;
          SV_GRPH_ST: m_pD.UpdateGD48(data);
     End;
End;
function CCalcSystem.isTrueValue(data : L3CURRENTDATA):Boolean;
Var
     value : Double;
     dataEx : L3CURRENTDATA;
Begin
     dataEx := data;
     holesFinder.IncDateTime(data.m_swCMDID,dataEx.m_sTime);
     value := m_pD.getArchParam(dataEx);
     Result := (value>=data.m_sfValue);
End;
function CCalcSystem.getTypeParam(cmdID:Integer):Integer;
Begin
     if (((cmdID>=QRY_ENERGY_DAY_EP) and (cmdID<=QRY_ENERGY_DAY_RM)) or
        ((cmdID>=QRY_NAK_EN_DAY_EP) and (cmdID<=QRY_NAK_EN_DAY_RM))) or
        (((cmdID>=QRY_ENERGY_MON_EP) and (cmdID<=QRY_ENERGY_MON_RM)) or
        ((cmdID>=QRY_NAK_EN_MONTH_EP) and (cmdID<=QRY_NAK_EN_MONTH_RM))) then
     Begin
       Result := SV_ARCH_ST;
       exit;
     End else
     if((cmdID>=QRY_SRES_ENR_EP)and(cmdID<=QRY_SRES_ENR_RM)) then
     Begin
       Result := SV_GRPH_ST;
       exit;
     End else
     if(((cmdID>=QRY_ENERGY_SUM_EP) and (cmdID<=QRY_ENERGY_SUM_EP)) or
        ((cmdID>=QRY_MGAKT_POW_S) and (cmdID<=QRY_FREQ_NET))) then
     Begin
       Result := SV_CURR_ST;
       exit;
     End else
     Begin
       Result := SV_CURR_ST;
       exit;
     End;
End;
{

L3CURRENTDATA = packed record
     m_swID    : Word;
     m_swVMID  : Word;
     m_swTID   : Word;
     m_swCMDID : Word;
     m_swSID   : Word;
     m_sTime   : TDateTime;
     m_sfKU    : Double;
     m_sfKI    : Double;
     m_sfSvValue     : Double;
     m_sfValue       : Double;
     m_byOutState    : Byte;
     m_byInState     : Byte;
     m_sbyMaskRead   : Byte;
     m_sbyMaskReRead : Byte;
     m_sMaskRead     : int64;
     m_sMaskReRead   : int64;
     m_sbyPrecision  : Byte;
     m_CRC           :Integer;
    end;

SV_DEFT_ST = -1;
  SV_CURR_ST = 0;
  SV_ARCH_ST = 1;
  SV_GRPH_ST = 2;
  SV_PDPH_ST = 3;


QRY_AUTORIZATION      = 0;//0
  QRY_ENERGY_SUM_EP     = 1;//1
  QRY_ENERGY_SUM_EM     = 2;
  QRY_ENERGY_SUM_RP     = 3;
  QRY_ENERGY_SUM_RM     = 4;
  QRY_ENERGY_DAY_EP     = 5;//2
  QRY_ENERGY_DAY_EM     = 6;
  QRY_ENERGY_DAY_RP     = 7;
  QRY_ENERGY_DAY_RM     = 8;
  QRY_ENERGY_MON_EP     = 9;//3
  QRY_ENERGY_MON_EM     = 10;
  QRY_ENERGY_MON_RP     = 11;
  QRY_ENERGY_MON_RM     = 12;
  QRY_SRES_ENR_EP       = 13;//36
  QRY_SRES_ENR_EM       = 14;
  QRY_SRES_ENR_RP       = 15;
  QRY_SRES_ENR_RM       = 16;
  QRY_NAK_EN_DAY_EP     = 17;//42
  QRY_NAK_EN_DAY_EM     = 18;
  QRY_NAK_EN_DAY_RP     = 19;
  QRY_NAK_EN_DAY_RM     = 20;
  QRY_NAK_EN_MONTH_EP   = 21;//43
  QRY_NAK_EN_MONTH_EM   = 22;
  QRY_NAK_EN_MONTH_RP   = 23;
  QRY_NAK_EN_MONTH_RM   = 24;
  QRY_NAK_EN_YEAR_EP    = 25;
  QRY_NAK_EN_YEAR_EM    = 26;
  QRY_NAK_EN_YEAR_RP    = 27;
  QRY_NAK_EN_YEAR_RM    = 28;
  QRY_E3MIN_POW_EP      = 29;//5
  QRY_E3MIN_POW_EM      = 30;
  QRY_E3MIN_POW_RP      = 31;
  QRY_E3MIN_POW_RM      = 32;
  QRY_E30MIN_POW_EP     = 33;//6
  QRY_E30MIN_POW_EM     = 34;
  QRY_E30MIN_POW_RP     = 35;
  QRY_E30MIN_POW_RM     = 36;
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
  QRY_KOEF_POW_A        = 54;//12
  QRY_KOEF_POW_B        = 55;
  QRY_KOEF_POW_C        = 56;
  QRY_KPRTEL_KPR        = 57;//24
  QRY_KPRTEL_KE         = 58;
  QRY_DATA_TIME         = 59;//32
  QRY_MAX_POWER_EP      = 60;
  QRY_MAX_POWER_EM      = 61;
  QRY_MAX_POWER_RP      = 62;
  QRY_MAX_POWER_RM      = 63;
  QRY_SRES_ENR_DAY_EP   = 64;//36
  QRY_SRES_ENR_DAY_EM   = 65;
  QRY_SRES_ENR_DAY_RP   = 66;
  QRY_SRES_ENR_DAY_RM   = 67;
  QRY_NULL_COMM         = 68;
  QRY_JRNL_T1           = 69;
  QRY_JRNL_T2           = 70;
  QRY_JRNL_T3           = 71;
  QRY_JRNL_T4           = 72;
  QRY_LOAD_ALL_PARAMS   = 73;
  QRY_SUM_KORR_MONTH    = 74;
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
  QRY_ANET_FI           = 87;
  QRY_ANET_CFI          = 88;


     Move(pMsg.m_sbyInfo[2],dDT,sizeof(CDTTime));
     if (dDT.Year=0)or(dDT.Month=0)or(dDT.Day=0)or(dDT.Month>12)or(dDT.Hour>23)or(dDT.Month>12)or(dDT.Day>31)or(dDT.Sec>59) then exit else
     m_sTime := EncodeDate(2000+dDT.Year,dDT.Month,dDT.Day)+EncodeTime(dDT.Hour,dDT.Min,dDT.Sec,0);
     Result := Extract(pMsg);
     Move(pMsg.m_sbyInfo[9],fVal,sizeof(Double));
     TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>CDTTP: EXT:'+DateTimeToStr(m_sTime)+' TID:'+IntToStr(pMsg.m_sbyInfo[8])+' SID:'+IntToStr(m_nCount)+
      ' CMD:'+m_nCommandList.Strings[pMsg.m_sbyInfo[1]]+
      ' VAL:'+FloatToStr(fVal));

     nVMID := pMsg.m_swObjID;
     nCID  := pMsg.m_sbyInfo[1];
function CDBDynamicConn.SetCurrentParamNoBlock(var pTable:L3CURRENTDATA):Boolean;
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
    Result := ExecQry(strSQL);
    End;
End;

function CDBDynamicConn.AddArchDataNoBlock(var pTable:L3CURRENTDATA):Boolean;
Var
    strSQL : String;
Begin
    with pTable do
    Begin
    strSQL := 'UPDATE OR INSERT INTO L3ARCHDATA'+
              '(m_swVMID,m_swCMDID,m_crc,m_sTime,m_sfValue,m_swTID, m_sbyMaskRead, m_sbyMaskReRead)'+
              ' VALUES('+
              IntToStr(m_swVMID)+ ','+
              IntToStr(m_swCMDID)+ ','+
              IntToStr(m_CRC)+ ','+
              ''''+DateTimeToStr(m_sTime)+''''+ ','+
              FloatToStr(m_sfValue)+ ',' + IntToStr(pTable.m_swTID) + ',' +
              IntToStr(m_sbyMaskRead) + ',' + '0) matching (m_swVMID,m_swCMDID,m_swTID,m_sTime)';
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
     ExecQry(strSQL);
    End;
    strV := ' ,v'+IntToStr(pTable.m_swSID)+'='+FloatToStr(pTable.m_sfValue);
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
     ExecQry(strSQL);
    End;
    strV := ' ,v'+IntToStr(pTable.m_swSID)+'='+FloatToStr(pTable.m_sfValue);
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
    Result := ExecQry(strSQL);
End;

}


procedure CCalcSystem.Run;
Begin

End;

end.
