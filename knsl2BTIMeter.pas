unit knsl2BTIMeter;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer
,knsl5tracer;
type
    CNullMeter = class(CMeter)
    Private
     procedure SetCurrQry;
     procedure SetGraphQry;
     procedure SetHandScenarioCurr;
     procedure SetHandScenarioGraph;
     procedure RunMeter;override;
     procedure InitMeter(var pL2:SL2TAG);override;
     function SelfHandler(var pMsg:CMessage):Boolean;override;
     function LoHandler(var pMsg:CMessage):Boolean;override;
     function HiHandler(var pMsg:CMessage):Boolean;override;
     constructor Create;
     destructor Destroy; override;
    End;
implementation
constructor CNullMeter.Create;
Begin

End;
destructor CNullMeter.Destroy;
Begin
    inherited;
End;
procedure CNullMeter.InitMeter(var pL2:SL2TAG);
Begin
    if m_nP.m_sbyHandScenr=0 then
    Begin
     SetCurrQry;
     SetGraphQry;
    end;
    if m_nP.m_sbyHandScenr=1 then
    Begin
     SetHandScenarioCurr;
     SetHandScenarioGraph;
    end;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>Null    Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;
procedure CNullMeter.SetCurrQry;
Begin
    with m_nObserver do
    Begin
     ClearCurrQry;
     //AddCurrParam(1,0,0,0,1);
    End;
End;
procedure CNullMeter.SetGraphQry;
Begin
End;
procedure CNullMeter.SetHandScenarioCurr;
Var
    pQry   : PCQueryPrimitive;
    nIndex : Integer;
Begin
    while(m_nObserver.GetCommand(pQry)=True) do
    Begin
     nIndex := nIndex + 1;
    End;
End;
procedure CNullMeter.SetHandScenarioGraph;
Begin
End;
function CNullMeter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;
function CNullMeter.LoHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATARD_IND:
      Begin
        //Переслать в L3 только значение и остановить таймер ожидания подтверждения
        //m_nRepTimer.OffTimer;
      End;
    End;
    Result := res;
End;
function CNullMeter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L3
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
       TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>Null DRQ:',@pMsg);
       m_nRepTimer.OnTimer(m_nP.m_swRepTime);
      End;
    End;
    Result := res;
End;
procedure CNullMeter.RunMeter;
Begin
    //m_nRepTimer.RunTimer;
    //m_nObserver.Run;
End;
end.
 