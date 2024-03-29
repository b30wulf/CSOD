unit knsl2Factory;
interface
uses
Windows, Classes, SysUtils,SyncObjs,utltypes,utlconst,utldynconnect,knsl2IRunnable,knsl2CThreadPull,
knsl2_HouseTask_Vzep,knsl2_HouseTask_SSDU,knsl2_HouseTask_16401B,knsl2_HouseTask_16401M_K,knsl2_HouseTask_KUB,knsl2_HouseTask_A2000,knsl2_HouseTask_Global,
knsl2_HouseTask_SSDU_ONE_CHANEL,knsl2_HouseTask_USPD1500;
type
    Factory = class
     public
      function getRunnable(dtBegin,dtEnd:TDateTime;gidGroup:QGPARAM;
      portPull:TThreadList;abonPull:CThreadPull;id:Integer;dyncon:CDBDynamicConn;dataQqAbon: qgabons;runn:IRunnable):IRunnable;
      function getRunnable8086(dtBegin,dtEnd:TDateTime;gidGroup:QGPARAM;
      portPull:TThreadList;abonPull:CThreadPull;id:Integer;dyncon:CDBDynamicConn;dataQqAbon: qgabons;runn:IRunnable):IRunnable;
      function getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):SL2TAG;
    End;

implementation

{$IFDEF HOMEL}
function Factory.getRunnable(dtBegin,dtEnd:TDateTime;gidGroup:QGPARAM;
portPull:TThreadList;abonPull:CThreadPull;id:Integer;dyncon:CDBDynamicConn;dataQqAbon: qgabons;runn:IRunnable):IRunnable;
var
runnable : IRunnable;
pTable   : SL2TAG;
data     : TThreadList;
vList    : TList;
pD       : CJoinL2;
begin
   data := TThreadList.Create;
   dyncon.GetAbonL2Join(dataQqAbon.QGID,dataQqAbon.ABOID,data);
   vList := data.LockList;
   pD    := nil;
   pD    := vList.Items[0];
   pTable:=getL2Instance(dyncon,pD.m_swMID);
   begin
  // if (gidGroup.PARAM<>QRY_LOAD_ALL_PARAMS)then   //����
   // begin
    case pTable.m_sbyType of
{       MET_EA8086        :   begin
                             if ((dataQqAbon.ENABLE=1) and (dataQqAbon.ENABLE_PROG=0))then
                             runnable := CHouseTaskVzep.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn)
                             else if((dataQqAbon.ENABLE=1) and (dataQqAbon.ENABLE_PROG=1))then
                             runnable := CHouseTaskVzep.Create(dtBegin,dtEnd,QRY_LOAD_ALL_PARAMS,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn)
                             end;
       MET_USPDSSDU      : runnable := CHouseTaskSSDU.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_USPD16401B    : runnable := CHouseTask16401B.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_USPD16401K    : runnable := CHouseTask16401M_K.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_USPD16401I    : runnable := CHouseTask16401M_K.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_CE16401M      : runnable := CHouseTask16401M_K.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_USPD16401M_v4 : runnable := CHouseTask16401M_K.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_USPDKUB       : runnable := CHouseTaskKUB.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);}
       MET_A2000by       : runnable := CHouseTaskA2000.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);

///////�������� ���������� ���������� ���� ����//////////////
{       MET_CE301BY       : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_CE102         : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_CE208BY       : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_CE6822        : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);

       MET_CRCRB         : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);

       MET_SS301F3       : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_SS101         : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);

       MET_EE8003        : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_EE8005        : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_EE8007        : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);

       MET_MIRT1         : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);

       MET_MES1          : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       MET_MES3          : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
/////////////////////////////////////////////////////////////
}
       Else runnable:=nil;
    end;
   end;

   data.UnLockList;
   ClearListAndFree(data);
   //FreeAndNil(pD);
   Result:=runnable;
end;

function Factory.getRunnable8086(dtBegin,dtEnd:TDateTime;gidGroup:QGPARAM;
portPull:TThreadList;abonPull:CThreadPull;id:Integer;dyncon:CDBDynamicConn;dataQqAbon: qgabons;runn:IRunnable):IRunnable;
var
runnable : IRunnable;                                    
pTable   : SL2TAG;
data     : TThreadList;
vList    : TList;
pD       : CJoinL2;
begin
   data := TThreadList.Create;
   dyncon.GetAbonL2Join(dataQqAbon.QGID,dataQqAbon.ABOID,data);
   vList := data.LockList;
   pD    := nil;
   pD    := vList.Items[0];
   pTable:= getL2Instance(dyncon,pD.m_swMID);
   begin
//   if (gidGroup.PARAM<>QRY_LOAD_ALL_PARAMS) or (dataQqAbon.ENABLE_PROG<>1)then   //����
    begin
    case pTable.m_sbyType of
     MET_EA8086    :  runnable:=nil
    //       MET_EA8086        : runnable := CHouseTaskVzep.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);
       Else runnable:=nil;
       end;
    end;
   end;
   data.UnLockList;
   data.Destroy;
   //FreeAndNil(pD);
   Result:=runnable;
end;

{$ELSE}

function Factory.getRunnable(dtBegin,dtEnd:TDateTime;gidGroup:QGPARAM;
portPull:TThreadList;abonPull:CThreadPull;id:Integer;dyncon:CDBDynamicConn;dataQqAbon: qgabons;runn:IRunnable):IRunnable;
var
runnable : IRunnable;
pTable   : SL2TAG;
data     : TThreadList;
vList    : TList;
pD       : CJoinL2;
begin
   data  := TThreadList.Create;
   dyncon.GetAbonL2Join(dataQqAbon.QGID,dataQqAbon.ABOID,data);
   vList := data.LockList;
   pD    := nil;
   pD    := vList.Items[0];
   pTable:= getL2Instance(dyncon,pD.m_swMID);
   begin
  // if (gidGroup.PARAM<>QRY_LOAD_ALL_PARAMS)then   //����
   // begin
    case pTable.m_sbyType of
       MET_EA8086        :   begin
                             if ((dataQqAbon.ENABLE=1) and (dataQqAbon.ENABLE_PROG=0))then
                             runnable := CHouseTaskVzep.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn)
                             else if((dataQqAbon.ENABLE=1) and (dataQqAbon.ENABLE_PROG=1))then
                             runnable := CHouseTaskVzep.Create(dtBegin,dtEnd,QRY_LOAD_ALL_PARAMS,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn)
                             end;
       //MET_USPDSSDU      : runnable := CHouseTaskSSDU.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,portpull,id,abonPull,runn);

       MET_USPDSSDU      : runnable := CHouseTask_SSDU_ONE_Channel.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_USPD16401B    : runnable := CHouseTask16401B.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_USPD16401K    : runnable := CHouseTask16401M_K.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_USPD16401I    : runnable := CHouseTask16401M_K.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_CE16401M      : runnable := CHouseTask16401M_K.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_USPD16401M_v4 : runnable := CHouseTask16401M_K.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_USPDKUB       : runnable := CHouseTaskKUB.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.PACKETK,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_A2000by       : runnable := CHouseTaskA2000.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_USPD1500      : runnable := CHouseTaskUSPD1500.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);

///////�������� ���������� ���������� ���� ����//////////////
       MET_CE301BY       : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_CE102         : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_CE208BY       : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_CE6822        : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);

       MET_CRCRB         : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);

       MET_SS301F3       : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_SS101         : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);

       MET_EE8003        : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_EE8005        : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_EE8007        : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_EE8003_4      : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_MIRT1         : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);

       MET_MES1          : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       MET_MES3          : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);

       MET_CEO6005       : runnable := CHouseTaskGlobal.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);

/////////////////////////////////////////////////////////////
       Else runnable:=nil;
    end;
   end;
   data.UnLockList;
   ClearListAndFree(data);
   Result:=runnable;
end;

function Factory.getRunnable8086(dtBegin,dtEnd:TDateTime;gidGroup:QGPARAM;
portPull:TThreadList;abonPull:CThreadPull;id:Integer;dyncon:CDBDynamicConn;dataQqAbon: qgabons;runn:IRunnable):IRunnable;
var
runnable : IRunnable;                                    
pTable   : SL2TAG;
data     : TThreadList;
vList    : TList;
pD       : CJoinL2;
i        : Integer; 
begin
   data  := TThreadList.Create;
   dyncon.GetAbonL2Join(dataQqAbon.QGID,dataQqAbon.ABOID,data);
   vList := data.LockList;
   pD    := nil;
   pD    := vList.Items[0];
   pTable:= getL2Instance(dyncon,pD.m_swMID);
   begin
//   if (gidGroup.PARAM<>QRY_LOAD_ALL_PARAMS) or (dataQqAbon.ENABLE_PROG<>1)then   //����
    begin
    case pTable.m_sbyType of
       MET_EA8086        : runnable := CHouseTaskVzep.Create(dtBegin,dtEnd,gidGroup.PARAM,gidGroup.QGID,dataQqAbon.ABOID,-1,gidGroup.FINDDATA,gidGroup.ERRORPERCENT,gidGroup.ERRORPERCENT2,gidGroup.TIMETOSTOP,portpull,id,abonPull,runn);
       Else runnable:=nil;
       end;
    end;
   end;
   data.UnLockList;
   for i:=0 to vList.Count-1 do
     begin
       pD := vList[i];
       if pD<>Nil then FreeAndNil(pD);
     end;
   vList.Clear;

   FreeAndNil(data);//.Destroy;
   Result:=runnable;
end;
  {$ENDIF}


function Factory.getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):SL2TAG;
Var
    pTable : SL2TAG;
Begin
    if (dynConnect.GetMMeterTableEx(mid,pTable)) then
    Begin
       Result:=pTable;
      End
      else
      Result := pTable; 
End;

end.
