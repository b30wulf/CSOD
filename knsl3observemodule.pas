unit knsl3observemodule;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlcbox,utlconst,utlmtimer,utldatabase,knsl5config,utldynconnect;
type
    CObserveModule = class
    Private
     m_swMID          : Integer;
     m_swCurrQryTm    : Integer;
     m_sPhone         : String;
     m_byBoxID        : Integer;
     m_byBoxQryID     : Integer;
     m_byObserverID   : Integer;
     m_sbyModem   : Byte;
     m_sbyEnable      : Byte;
     m_nIndex         : Integer;
     m_nScenarioList  : TThreadList;
     m_nControlList   : TThreadList;
     m_nCurrQryList   : TThreadList;
     m_nCtrlQryList   : TThreadList;
     m_nCurrQryTm     : CTimer;
     m_nGraphQryTm    : CTimer;
     m_nCtrlQryTm     : CTimer;
     m_sInil2CmdTbl   : TThreadList;
     dynConnect       : CDBDynamicConn;
     function  IsEnabled(swCmdID:Integer):Boolean;
     procedure CreateCurrQuery;
     procedure CreateGraphQuery;
     procedure SetScenario;
    public
     box : CBox;
     procedure setDbConnect(vDynConnect:CDBDynamicConn);
     procedure SendMSG(byBox,byFor,byType:Byte);
     procedure StopObserve;
     procedure StartObserve;
     procedure GoObserve;
     procedure ClearCurrQry;
     procedure ClearGraphQry;
     procedure ClearCtrlQry();
     procedure GetQwery(swCmdID:Integer;var nQry:CQueryPrimitive);
     function LoadCurrQry:Boolean;
     function LoadParam(swCmdID:Integer):Boolean;
     procedure LoadParamQS(swCmdID:Integer);
     function LoadGraphQry:Integer;
     procedure LoadGraphQryQS(nCMDID:Integer);
     function LoadCtrlQry:Integer;
     function LoadCurrFirstQry:Boolean;
     procedure AddCurrParam(wParamID:Word;wSpec0,wSpec1,wSpec2:Smallint;byEnable:Byte);
     procedure AddGraphParam(wParamID:Word;wSpec0,wSpec1,wSpec2:Smallint;byEnable:Byte);
     procedure AddCtrlParam(wParamID:Word;wSpec0,wSpec1,wSpec2:Smallint;byEnable:Byte);
     procedure SetBox(byBox:Integer);
     procedure GetArchCmd(var pBox:CBox);
     procedure SetArchCmd(var pBox:CBox);
     procedure Run;
     procedure Init(var pTable : SL2TAG);
     function  EventHandler(var pMsg : CMessage):Boolean;
     function  GetCommand(var pQry : PCQueryPrimitive):Boolean;
     function  IsChekObserver:boolean;
     destructor Destroy; override;
     public
       property pm_sInil2CmdTbl :TThreadList  read m_sInil2CmdTbl;
    End;
    PCObserveModule =^ CObserveModule;
implementation
procedure CObserveModule.Init(var pTable : SL2TAG);
Var
    pQry : PCQueryPrimitive;
    i : Integer;
Begin
    box             := Cbox.Create(BOX_L2_LD_SZ,false);
    m_swMID         := pTable.m_swMID;
    m_swCurrQryTm   := pTable.m_swCurrQryTm;
    m_sPhone        := pTable.m_sPhone;
    m_sbyModem      := pTable.m_sbyModem;
    m_sbyEnable     := pTable.m_sbyEnable;
    m_byObserverID  := pTable.m_sbyPortID;
    m_byBoxQryID    := BOX_L3_QS + m_byObserverID;
    //FFDEFINE(BOX_L2_LD+m_swMID,BOX_L2_LD_SZ,sizeof(CQueryPrimitive)+5,False);

    if m_sInil2CmdTbl =Nil then m_sInil2CmdTbl := TThreadList.Create;
    if m_nCurrQryList =Nil then m_nCurrQryList  := TThreadList.Create;

    if m_nCtrlQryList =Nil then m_nCtrlQryList  := TThreadList.Create; // Ukrop

    if m_nScenarioList=Nil then m_nScenarioList := TThreadList.Create;

    if m_nControlList=Nil then m_nControlList := TThreadList.Create; // Ukrop

    if m_nCurrQryTm   =NIl then m_nCurrQryTm    := CTimer.Create;
    m_nCurrQryTm.SetTimer(DIR_L2TOL2,QL_CQRYMSG_TMR,0,m_swMID,m_byBoxID);
    m_nCurrQryTm.OnTimer(m_swCurrQryTm);
    m_nCurrQryTm.OffTimer;
    if m_nGraphQryTm  =NIl then m_nGraphQryTm   := CTimer.Create;
    m_nGraphQryTm.SetTimer(DIR_L2TOL2,QL_GQRYMSG_TMR,0,m_swMID,m_byBoxID);
    m_nGraphQryTm.OnTimer(10);
    m_nGraphQryTm.OffTimer;
    if m_nCtrlQryTm  =NIl then m_nCtrlQryTm   := CTimer.Create;
    m_nCtrlQryTm.SetTimer(DIR_L2TOL2,QL_GQRYMSG_TMR,0,m_swMID,m_byBoxID);
    m_nCtrlQryTm.OnTimer(10);
    m_nCtrlQryTm.OffTimer;
    //if pTable.m_sbyModem=1 then
     SetScenario;
End;
destructor CObserveModule.destroy;
Begin
    ClearListAndFree(m_sInil2CmdTbl);
    ClearListAndFreeD(m_nScenarioList);
    ClearListAndFreeD(m_nControlList);
    ClearListAndFreeD(m_nCurrQryList);
    ClearListAndFreeD(m_nCtrlQryList);
    if m_nCurrQryTm<>nil  then FreeAndNil(m_nCurrQryTm);
    if m_nGraphQryTm<>nil then FreeAndNil(m_nGraphQryTm);
    if m_nCtrlQryTm<>nil  then FreeAndNil(m_nCtrlQryTm);
    if box<>nil then FreeAndNil(box);

    inherited;
End;
procedure CObserveModule.setDbConnect(vDynConnect:CDBDynamicConn);
Begin
    dynConnect := vDynConnect;
End;


procedure CObserveModule.SetScenario;
Var
    //m_sInil2CmdTbl : CCOMMANDS;
    pQry  : PCQueryPrimitive;
    i     : Integer;
    vList : TList;
    pD    : CComm;
Begin
    m_nIndex := 0;
    m_nScenarioList.Clear;
    if m_sbyEnable=1 then
    vList := m_sInil2CmdTbl.LockList;
    if dynConnect.GetCommandsTable(m_swMID,m_sInil2CmdTbl)=True then
    Begin
     for i:=0 to vList.Count-1 do
     Begin
      pD := CComm(vList[i]);
      if (pD.m_sbyEnable=1) then
      Begin
        New(pQry);
        with pQry^ do
        Begin
         m_wLen      := sizeof(CQueryPrimitive);
         m_swMtrID   := pD.m_swMID;
         m_swParamID := pD.m_swCmdID;
         m_swChannel := pD.m_swChannel;
         m_swSpecc0  := pD.m_swSpecc0;
         m_swSpecc1  := pD.m_swSpecc1;
         m_swSpecc2  := pD.m_swSpecc2;
         m_sbyEnable := pD.m_sbyEnable;
        End;
        if (pD.m_sbyDirect=3) then
        Begin
         m_nControlList.LockList.Add(pQry);
         m_nControlList.UnLockList;
        End
        else
        Begin
         m_nScenarioList.LockList.Add(pQry);
         m_nScenarioList.UnLockList;
        End;
      End;
     End;
    End;
    m_sInil2CmdTbl.UnLockList;
End;
{
with MyList.LockList do
try
  for i := 0 to Count - 1 do
     Inc(iAmount, Integer(Items[i]));
finally
  MayList.UnlockList;
end;
}
function  CObserveModule.GetCommand(var pQry : PCQueryPrimitive):Boolean;
Begin
   with m_nScenarioList.LockList do
    try
     if m_nIndex<Count then
     Begin
      pQry := Items[m_nIndex];
      Inc(m_nIndex); Result := True;
     End else Begin m_nIndex:=0;Result := False;End;
     finally
      m_nScenarioList.UnlockList;
     end;
End;
procedure CObserveModule.ClearCurrQry;
Begin
    with m_nCurrQryList.LockList do
    try
     if m_nCurrQryList<>Nil then
     if Count<>0 then Clear;
    finally
     m_nCurrQryList.UnlockList;
    end;
End;
procedure CObserveModule.ClearGraphQry;
Begin
    //if m_nCF.QueryType<>QWR_QWERY_SRV then
    //FFREE(BOX_L2_LD+m_swMID);
    box.FFREE;
End;
{*******************************************************************************
 *  Ukrop
 *  Очистка списка команд управления
 ******************************************************************************}
procedure CObserveModule.ClearCtrlQry();
Begin
    with m_nCtrlQryList.LockList do
    try
      if Count<>0 then
       Clear();
       box.FFREE;
    finally
     m_nCtrlQryList.UnlockList;
    end;
End;

procedure CObserveModule.AddCurrParam(wParamID:Word;wSpec0,wSpec1,wSpec2:Smallint;byEnable:Byte);
Var
    pQry : PCQueryPrimitive;
Begin
    New(pQry);
    with pQry^ do
    Begin
     m_wLen      := sizeof(CQueryPrimitive);
     m_swMtrID   := m_swMID;
     m_swParamID := wParamID;
     m_swSpecc0  := wSpec0;
     m_swSpecc1  := wSpec1;
     m_swSpecc2  := wSpec2;
     m_sbyEnable := byEnable;
    End;
    m_nCurrQryList.Add(pQry);
End;
procedure CObserveModule.AddGraphParam(wParamID:Word;wSpec0,wSpec1,wSpec2:Smallint;byEnable:Byte);
Var
    pQry : CQueryPrimitive;
Begin
    //New(pQry);
    with pQry do
    Begin
     m_wLen      := sizeof(CQueryPrimitive);
     m_swMtrID   := m_swMID;
     m_swParamID := wParamID;
     m_swSpecc0  := wSpec0;
     m_swSpecc1  := wSpec1;
     m_swSpecc2  := wSpec2;
     m_sbyEnable := byEnable;
    End;
//    TraceL(4,m_swMID,'(__)CL2MD::>LGQ PR:S0:S1:S2:EN '+IntTostr(wParamID)+
//                                    ' '+IntTostr(wSpec0)+
//                                    ' '+IntTostr(wSpec1)+
//                                    ' '+IntTostr(wSpec2)+
//                                    ' '+IntTostr(byEnable));
    //m_nGraphQryList.Add(pQry);
    //FPUT(BOX_L2_LD+m_swMID,@pQry);
    box.FPUT(@pQry);
End;
{
  Ukrop
  Добавление команды управления
}
procedure CObserveModule.AddCtrlParam(wParamID:Word;wSpec0,wSpec1,wSpec2:Smallint;byEnable:Byte);
Var
    pQry : CQueryPrimitive;
Begin
    //New(pQry);
    with pQry do
    Begin
     m_wLen      := sizeof(CQueryPrimitive);
     m_swMtrID   := m_swMID;
     m_swParamID := wParamID;
     m_swSpecc0  := wSpec0;
     m_swSpecc1  := wSpec1;
     m_swSpecc2  := wSpec2;
     m_sbyEnable := byEnable;
    End;
//    TraceL(4,m_swMID,'(__)CL2MD::>LGQ PR:S0:S1:S2:EN '+IntTostr(wParamID)+
//                                    ' '+IntTostr(wSpec0)+
//                                    ' '+IntTostr(wSpec1)+
//                                    ' '+IntTostr(wSpec2)+
//                                    ' '+IntTostr(byEnable));
    //m_nGraphQryList.Add(pQry);
    //FPUT(BOX_L2_LD+m_swMID,@pQry);
    box.FPUT(@pQry);
End;

procedure CObserveModule.SetBox(byBox:Integer);
Begin
    m_byBoxID := byBox;
End;
function CObserveModule.EventHandler(var pMsg : CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    case pMsg.m_sbyFor of
       DIR_L2TOL2:
       Begin
        if pMsg.m_sbyType=QL_CQRYMSG_TMR then CreateCurrQuery;
        if pMsg.m_sbyType=QL_GQRYMSG_TMR then CreateGraphQuery;
       End;
    End;
    Result := res;
End;
procedure CObserveModule.StopObserve;
Begin
    m_nCurrQryTm.OffTimer;
    m_nGraphQryTm.OffTimer;
End;
procedure CObserveModule.StartObserve;
Begin
    m_nCurrQryTm.OnTimer(m_swCurrQryTm);
    m_nGraphQryTm.OnTimer(10);
End;
procedure CObserveModule.GoObserve;
Begin
    m_nCurrQryTm.GoTimer;
    m_nGraphQryTm.GoTimer;
End;
function CObserveModule.LoadParam(swCmdID:Integer):Boolean;
Var
    pQry : PCQueryPrimitive;
    i : Integer;
    res  : Boolean;
Begin
    with m_nCurrQryList.LockList do
    try
    res := False;
    if m_sbyEnable=1 then
    Begin
     for i:=0 to Count-1 do
     Begin
      pQry := Items[i];
      if pQry.m_sbyEnable=1 then
      Begin
      case swCmdID of
           QRY_ENERGY_SUM_EP:
           case pQry.m_swParamID of
                 QRY_ENERGY_SUM_EP,QRY_ENERGY_SUM_EM,QRY_ENERGY_SUM_RP,QRY_ENERGY_SUM_RM:FPUT(m_byBoxQryID,pQry);
                 QRY_KPRTEL_KE : FPUT(m_byBoxQryID,pQry);
                 QRY_AUTORIZATION : FPUT(m_byBoxQryID,pQry);
           end;
           QRY_MGAKT_POW_S:
           case pQry.m_swParamID of
                 QRY_MGAKT_POW_S,QRY_MGAKT_POW_A,QRY_MGAKT_POW_B,QRY_MGAKT_POW_C:FPUT(m_byBoxQryID,pQry);
                 //QRY_KPRTEL_KE : FPUT(m_byBoxQryID,pQry);
                 QRY_AUTORIZATION : FPUT(m_byBoxQryID,pQry);
           end;
           QRY_MGREA_POW_S:
           case pQry.m_swParamID of
                 QRY_MGREA_POW_S,QRY_MGREA_POW_A,QRY_MGREA_POW_B,QRY_MGREA_POW_C:FPUT(m_byBoxQryID,pQry);
                 //QRY_KPRTEL_KE : FPUT(m_byBoxQryID,pQry);
                 QRY_AUTORIZATION : FPUT(m_byBoxQryID,pQry);
           end;
           QRY_U_PARAM_A:
           case pQry.m_swParamID of
                 QRY_U_PARAM_A,QRY_U_PARAM_B,QRY_U_PARAM_C:FPUT(m_byBoxQryID,pQry);
                 //QRY_KPRTEL_KE : FPUT(m_byBoxQryID,pQry);
                 QRY_AUTORIZATION : FPUT(m_byBoxQryID,pQry);
           end;
           QRY_I_PARAM_A:
           case pQry.m_swParamID of
                 QRY_I_PARAM_A,QRY_I_PARAM_B,QRY_I_PARAM_C:FPUT(m_byBoxQryID,pQry);
                 //QRY_KPRTEL_KE : FPUT(m_byBoxQryID,pQry);
                 QRY_AUTORIZATION : FPUT(m_byBoxQryID,pQry);
           end;
           QRY_KOEF_POW_A:
           case pQry.m_swParamID of
                 QRY_KOEF_POW_A,QRY_KOEF_POW_B,QRY_KOEF_POW_C:FPUT(m_byBoxQryID,pQry);
                 //QRY_KPRTEL_KE : FPUT(m_byBoxQryID,pQry);
                 QRY_AUTORIZATION : FPUT(m_byBoxQryID,pQry);
           end;
           QRY_FREQ_NET :
           case pQry.m_swParamID of
                 QRY_FREQ_NET:FPUT(m_byBoxQryID,pQry);
                 //QRY_KPRTEL_KE : FPUT(m_byBoxQryID,pQry);
                 QRY_AUTORIZATION : FPUT(m_byBoxQryID,pQry);
           end;
           QRY_DATA_TIME:
           case pQry.m_swParamID of
                 QRY_DATA_TIME:FPUT(m_byBoxQryID,pQry);
                 QRY_AUTORIZATION : FPUT(m_byBoxQryID,pQry);
           end;
      end;
      {
      case swCmdID of
           QRY_ENERGY_SUM_EP:
           Begin
            if (pQry.m_swParamID>=QRY_ENERGY_SUM_EP)and(pQry.m_swParamID<=QRY_ENERGY_SUM_RM) then
            FPUT(m_byBoxQryID,pQry);
           End;
           //QRY_ENERGY_SUM_EP:
           //Begin
           // if (pQry.m_swParamID>=QRY_ENERGY_SUM_EP)and(pQry.m_swParamID<=QRY_ENERGY_SUM_RM) then
           // FPUT(m_byBoxQryID,pQry);
           //End;
      End
      }
      end;
     End;
     res := True;
    End;
    finally
     m_nCurrQryList.UnlockList;
    end;
    Result := res;
End;
function CObserveModule.LoadCurrQry:Boolean;
Var
    i    : Integer;
    pQry : PCQueryPrimitive;
    res  : Boolean;
Begin
    res := False;
    if m_sbyEnable=1 then
    Begin
//     TraceL(4,m_byObserverID,'(__)CL2MD::>LoadCurrQry:'+IntTostr(m_swMID));
     with m_nCurrQryList.lockList do
     try
     for i:=0 to Count-1 do
     Begin
      pQry := Items[i];
      if pQry.m_sbyEnable=1 {@todo AND pQry.m_sbyDirect=1 }then
      Begin
       if not(((pQry.m_swParamID=QRY_SRES_ENR_EP)or
               (pQry.m_swParamID=QRY_SRES_ENR_EM)or
               (pQry.m_swParamID=QRY_SRES_ENR_RP)or
               (pQry.m_swParamID=QRY_SRES_ENR_RM)or
       (pQry.m_swParamID=QRY_SRES_ENR_DAY_EP))and(m_nCF.IsPreGraph=True)) then
       Begin
       {
       TraceL(2,m_swMID,'(__)CL2MD::>LGQ1 PR:S0:S1:S2:EN '+IntTostr(pQry.m_swParamID)+
                                    ' '+IntTostr(pQry.m_swSpecc0)+
                                    ' '+IntTostr(pQry.m_swSpecc1)+
                                    ' '+IntTostr(pQry.m_swSpecc2)+
                                    ' '+IntTostr(pQry.m_sbyEnable));
       }
       FPUT(m_byBoxQryID,pQry);
       End;
      End;
     End;
     finally
      m_nCurrQryList.UnlockList;
     end;
     res := True;
    End;
    Result := res;
End;

function CObserveModule.LoadCurrFirstQry:Boolean;
Var
    i    : Integer;
    pQry : PCQueryPrimitive;
    res  : Boolean;
Begin
    res := False;
    if m_sbyEnable=1 then
    Begin
//     TraceL(4,m_byObserverID,'(__)CL2MD::>LoadCurrQry:'+IntTostr(m_swMID));
     with m_nCurrQryList.LockList do
     try
     for i:=0 to Count-1 do
     Begin
      pQry := Items[i];
      if pQry.m_sbyEnable=1 then
      Begin
       FPUT(m_byBoxQryID,pQry);
       res := True;
       break;
      End;
     End;
     finally
       m_nCurrQryList.UnlockList;
     end;
    End;
    Result := res;
End;



function CObserveModule.LoadGraphQry:Integer;
Var
    i,j  : Integer;
    pQry : CQueryPrimitive;
    res  : Integer;
Begin
    res := -1;
    try
    if m_sbyEnable=1 then
    Begin
//     TraceL(4,m_byObserverID,'(__)CL2MD::>LoadGraphQry:'+IntTostr(m_swMID));
     for i:=0 to  box.FCHECK()-1 do
     Begin
       box.FGET(@pQry);
      if pQry.m_sbyEnable=1 then
      Begin
       if IsEnabled(pQry.m_swParamID)=True then
       Begin
        if FPUT(m_byBoxQryID,@pQry)=0 then break;
        res := pQry.m_swParamID;
       End;
      End;
     End;
    End;
    except
//     TraceER('(__)CERMD::>Error In CObserveModule.LoadGraphQry!!!');
    end;
    Result := res;
End;
{
procedure CQweryMDL.GetHandle(var pQR:CQueryPrimitive;nCMDID:Integer);
Begin
     with pQR,m_nTbl do
     Begin
      m_swSpecc0 := nCMDID and $7fff;
      m_swSpecc0 := m_swSpecc0 or (Word(m_snSRVID) shl 8);
      m_swSpecc1 := Word(m_snVMID);
      m_swSpecc2 := Word(m_snGID);
      m_swSpecc2 := m_swSpecc2 or (Word(m_snAID) shl 8);
     End;
End;
     m_swVMtrID   : Integer;
     m_swMtrID    : Word;
     m_swCmdID    : Word;
     m_swParamID  : Word;
     m_swChannel  : string[8];
     m_swSpecc0   : Smallint;
     m_swSpecc1   : Smallint;
     m_swSpecc2   : Smallint;
     m_sbyEnable  : Byte;
}
procedure CObserveModule.GetQwery(swCmdID:Integer;var nQry:CQueryPrimitive);
Var
    i : Integer;
    pQry : PCQueryPrimitive;
Begin
    try
     with m_nCurrQryList.LockList do
     try
     for i:=0 to Count-1 do
     Begin
      pQry := Items[i];
      if swCmdID=pQry.m_swParamID then
      Begin
       System.Move(pQry^,nQry,sizeof(CQueryPrimitive));
       break;
      End
     End;
     finally
      m_nCurrQryList.UnlockList;
     end;
    except
//     TraceER('(__)CERMD::>Error In CObserveModule.GetQwery!!!');
    end;
End;
{
 CQueryPrimitive = packed record
     m_wLen       : Word;
     m_swVMtrID   : Integer;
     m_swMtrID    : Word;
     m_swCmdID    : Word;
     m_swParamID  : Word;
     m_swChannel  : string[8];
     m_swSpecc0   : Smallint;
     m_swSpecc1   : Smallint;
     m_swSpecc2   : Smallint;
     m_sbyEnable  : Byte;
    End;
}
procedure CObserveModule.LoadParamQS(swCmdID:Integer);
Var
    i : Integer;
    pQry : PCQueryPrimitive;
Begin
    if ((swCmdID=QRY_ENTER_COM) or (swCmdID=QRY_EXIT_COM) {or (swCmdID=QRY_AUTORIZATION)})  then
    Begin
     AddGraphParam(swCmdID,0,0,0,1);
     exit;
    End;
    try
     with m_nCurrQryList.LockList do
     try
     for i:=0 to Count-1 do
     Begin
      pQry := Items[i];
      if swCmdID=pQry.m_swParamID then
      Begin
       box.FPUT(pQry);
      //if FPUT(m_byBoxQryID,pQry)=0 then break;
      End
     End;
      finally
      m_nCurrQryList.UnlockList;
     end;
    except
//     TraceER('(__)CERMD::>Error In CObserveModule.LoadParamQS!!!');
    end;
End;
procedure CObserveModule.LoadGraphQryQS(nCMDID:Integer);
Var
    i : Integer;
    pQry : CQueryPrimitive;
Begin
    try
     for i:=0 to  box.FCHECK-1 do
     Begin
       box.FGET(@pQry);
      if nCMDID= pQry.m_swParamID then FPUT(m_byBoxQryID,@pQry);
     End;
    except
//     TraceER('(__)CERMD::>Error In CObserveModule.LoadGraphQryQS!!!');
    end;
End;
procedure CObserveModule.SetArchCmd(var pBox:CBox);
Var
    i : Integer;
    pQry : CQueryPrimitive;
Begin
    try
     for i:=0 to pBox.FCHECK-1 do
     Begin
      pBox.FGET(@pQry);
      FPUT(m_byBoxQryID,@pQry);
     End;
    except
//     TraceER('(__)CERMD::>Error In CObserveModule.GetArchCmd!!!');
    end;
End;
procedure CObserveModule.GetArchCmd(var pBox:CBox);
Var
    i : Integer;
    pQry : CQueryPrimitive;
Begin
    try
     for i:=0 to  box.FCHECK()-1 do
     Begin
       box.FGET(@pQry);
      //if nCMDID=pQry.m_swParamID then
      pBox.FPUT(@pQry);
     End;
    except
//     TraceER('(__)CERMD::>Error In CObserveModule.GetArchCmd!!!');
    end;
End;
{*******************************************************************************
 *  Загрузка команды управления в бокс счетчика
 *  Ukrop
 ******************************************************************************}
function CObserveModule.LoadCtrlQry:Integer;
Var
    i,j  : Integer;
    pQry : CQueryPrimitive;
    res  : Integer;
Begin
    res := -1;
    try
    if m_sbyEnable=1 then
    Begin
//     TraceL(4,m_byObserverID,'(__)CL2MD::>LoadCtrlQry:'+IntTostr(m_swMID));
     for i:=0 to  box.FCHECK()-1 do
     Begin
       box.FGET(@pQry);
      if pQry.m_sbyEnable=1 then
      Begin
       if IsEnabled(pQry.m_swParamID)=True then
       Begin
        if FPUT(m_byBoxQryID,@pQry)=0 then break;
        res := pQry.m_swParamID;
       End;
      End;
     End;
    End;
    except
//     TraceER('(__)CERMD::>Error In CObserveModule.LoadGraphQry!!!');
    end;
    Result := res;
End;


function CObserveModule.IsEnabled(swCmdID:Integer):Boolean;
Var
    i     : Integer;
    pQry  : PCQueryPrimitive;
    vList : TList;
    pD    : CComm;
Begin
    if (((swCmdID=QRY_SRES_ENR_EP)or(swCmdID=QRY_SRES_ENR_DAY_EP))and(m_nCF.IsPreGraph=True)) or
       (swCmdID=QRY_AUTORIZATION)or(swCmdID=QRY_KPRTEL_KE)or
       (swCmdID=QRY_JRNL_T1) or (swCmdID=QRY_JRNL_T2) or (swCmdID=QRY_JRNL_T3) or (swCmdID=QRY_JRNL_T4) or (swCmdID=QRY_SUM_KORR_MONTH) or
       (swCmdID=QRY_LOAD_ALL_PARAMS) then
       Begin Result := True;exit;end;
    vList := m_sInil2CmdTbl.LockList;
    try
    for i:=0 to vList.count-1 do
    Begin
     pD := CComm(vList[i]);
     if (pD.m_swCmdID=swCmdID) then
     Begin
      if (pD.m_sbyEnable=1) then
      Begin
       Result := True;
       exit;
      end;
     end;
    end;
    finally
     m_sInil2CmdTbl.UnLockList;
    end;

    Result := False;
end;
procedure CObserveModule.CreateCurrQuery;
Begin
    //TraceL(2,m_swMID,'(__)CL2MD::>CreateCurrQuery');
    LoadCurrQry;
    m_nCurrQryTm.OnTimer(m_swCurrQryTm);
End;
procedure CObserveModule.CreateGraphQuery;
Begin
    //TraceL(2,m_swMID,'(__)CL2MD::>CreateGraphQuery');
    LoadGraphQry;
    m_nGraphQryTm.OnTimer(10);
End;
procedure CObserveModule.Run;
Begin
    //m_nCurrQryTm.RunTimer;
    //m_nGraphQryTm.RunTimer;
    //TraceL(2,m_swMID,'(__)CL2MD::>Observer Run');
End;
procedure CObserveModule.SendMSG(byBox,byFor,byType:Byte);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 11;
    m_swObjID     := m_swMID;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := m_byObserverID;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    end;
    FPUT(byBox,@pMsg);
End;

function  CObserveModule.IsChekObserver:boolean;
Var
    i,j  : Integer;
    pQry : CQueryPrimitive;
    res  : Boolean;
Begin
    res := false;
    try
    for i:=0 to  box.FCHECK()-1 do
       res:=true;
    except
//     TraceER('(__)CERMD::>Error In CObserveModule.LoadGraphQry!!!');
    end;
    Result := res;     
end;

end.
