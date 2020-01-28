unit knsl3Monitor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
controls,utldatabase,knsl5tracer,knsl3EventBox;
type
    CData = class
    private
     //DataS : array of MONTAG1;
     //DataS : array of MONTAG1;
     //DataD : array of Double;
     m_nCount: Integer;
     Count   : Integer;
     Size    : Integer;
     destructor Destroy();override;
    protected
     constructor Create(nCount:Integer);
     function  GetValue:CData;
     function  GetBuffer:Pointer;virtual;
     procedure Reset;
     procedure AddValue(const Value:CData);virtual;
     procedure SubValue(const Value:CData);virtual;
     procedure SetValue(const Value:CData);virtual;
     procedure Extract(var pMsg:CMessage);virtual;
    public
     property PAdd:CData read GetValue write AddValue;
     property PSub:CData read GetValue write SubValue;
     property PData:CData read GetValue write SetValue;

     property PBuffer:Pointer read GetBuffer;
     property PSize:Integer read Size;
    End;
    CDataF1X1 = class(CData)
    private
     Data : Single;
    public
     constructor Create;
     destructor Destroy();override;
     procedure AddValue(const Value:CData);override;
     procedure SubValue(const Value:CData);override;
     procedure SetValue(const Value:CData);override;
     procedure Extract(var pMsg:CMessage);override;
     function  GetBuffer:Pointer;override;
    End;
    CDataF1X3 = class(CData)
    private
     Data : array[0..3] of Single;
    public
     constructor Create;
     destructor Destroy();override;
     procedure AddValue(const Value:CData);override;
     procedure SubValue(const Value:CData);override;
     procedure SetValue(const Value:CData);override;
     procedure Extract(var pMsg:CMessage);override;
     function  GetBuffer:Pointer;override;
    End;
    CDataF1X4 = class(CData)
    private
     Data : array[0..3] of Single;
    public
     constructor Create;
     destructor Destroy();override;
     procedure AddValue(const Value:CData);override;
     procedure SubValue(const Value:CData);override;
     procedure SetValue(const Value:CData);override;
     procedure Extract(var pMsg:CMessage);override;
     function  GetBuffer:Pointer;override;
    End;
    //CDataCluster
    CDataCluster = class
    private
     m_nCount  : Integer;
     m_nPeriod : Integer;
     m_nSize   : Integer;
     m_dtBegin : TDateTime;
     m_dtEnd   : TDateTime;
     m_nTCount : Integer;
     m_nPosition : Integer;
     m_nData   : TMemoryStream;
    public
     constructor Create(pTM:PSTIMEPERIOD);
     destructor Destroy();override;
     procedure Add(var Data:CData);
     function  GetBuffer:Pointer;
     function  GetSize:Integer;
    public
     property PBuffer:Pointer read GetBuffer;
     property PSize:Integer read GetSize;
    End;
    //CDataBuffer
    CDataBuffer = class
    private
     m_nVMID  : Integer;
     m_nMID   : Integer;
     m_nCMDID : Integer;
     m_nCount : Integer;
     m_dtDate : TDateTime;
     m_nData  : TMemoryStream;
    public
     constructor Create(nVMID,nMID,nCMDID:Integer);
     procedure Add(var DCData:CDataCluster);
     procedure Flush;
     function  GetClusters(var DCDatas:CDataClusters):Boolean;
    End;
    //CQweryModule
    CQweryModule = class
    private
     m_Data     : CData;
     m_DCluster : CDataCluster;
     m_DBuffer  : CDataBuffer;
     m_nVMID    : Integer;
     m_nMID     : Integer;
     m_nPortID  : Integer;
     m_nCMDID   : Integer;
     procedure SetValue(const Data:CData);
    public
     constructor Create(nVMID,nMID,nCMDID,nPortID:Integer);
     destructor Destroy();override;
     procedure OnBeginPeriod(pTM:PSTIMEPERIOD);
     procedure OnEndPeriod;
     procedure OnFinalize;
     procedure EventHandler(var pMsg:CMessage);
    public
     property PData:CData write SetValue;
    End;
    CQweryModules = packed record
     Count : Integer;
     Items : array of CQweryModule;
    End;
    CQweryF1X1 = class(CQweryModule)
    public
     constructor Create(nVMID,nMID,nCMDID,nPortID:Integer);
     destructor Destroy();override;
    End;
    CQweryF1X3 = class(CQweryModule)
    public
     constructor Create(nVMID,nMID,nCMDID,nPortID:Integer);
     destructor Destroy();override;
    End;
    CQweryF1X4 = class(CQweryModule)
    public
     constructor Create(nVMID,nMID,nCMDID,nPortID:Integer);
     destructor Destroy();override;
    End;
    //CFindTime
    CFindTime = class
    private
     m_nTPeriods : STIMEPERIODS;
    public
     //constructor Create;
     //destructor Destroy();override;
    End;
    //CQweryCluster
    CQweryCluster = class
    private
     //m_nVMID   : Integer;
     //m_nMID    : Integer;
     //m_nPortID : Integer;
     //m_nCMDID  : Integer;
     m_QModule : CQweryModules;
    public
     constructor Create;
     destructor Destroy();override;
     //procedure Add(QModule:CQweryModule);
     procedure OnStart(pTM:PSTIMEPERIOD);
     procedure OnStop;
     procedure OnOnFinalize;
     procedure Run;
    public
    End;
    {
    CQweryClusters = packed record
     Count : Integer;
     Items : array of CQweryCluster;
    End;
    }
    {
    //CQweryObject
    CQweryObject = class
    private
     m_nFTModule : CFindTime;
     m_Qlasters  : CQweryClusters;
     m_sFormula  : String;
    public

    End;
    }


    CMonitor = class
    protected
     m_blEnabled : Boolean;
     m_wPID      : Word;
     m_wMID      : Word;
     m_wVMID     : Word;
     m_wCMDID    : Word;
     m_wFormat   : Word;
     m_dwCounter : DWord;
     m_nTMR      : CTimer;
     m_nD1       : MONTAG1;
     m_nD2       : MONTAG2;
     m_nD2Ct     : Integer;
     m_nRCount   : Integer;
     m_nCount    : Integer;
     FData       : Integer;
     m_dtLastDate: TDateTime;
     m_blBegin   : Boolean;
     m_blEnd     : Boolean;
     m_dtBegin   : TDateTime;
     m_dtEnd     : TDateTime;
     m_pBuff     : SMONITORDATAS;
     m_blProced  : Boolean;
     procedure EVT(wFinal:Integer);
     procedure CMD;
     procedure OnTimeExpired(byEvent:Byte);
     procedure Load;
     function  LoadDB(dtDate:TDateTime):PSMONITORDATA;
     procedure Save;
     procedure ResetData;
     procedure Pack;
     procedure UnPack;
     procedure SaveToDB(pD:PSMONITORDATA);
     function EventHandler(var pMsg:CMessage):Boolean;
     procedure InitBuffer;
     procedure SaveToFile(pD:PSMONITORDATA);
     //procedure Pack;
     function  StartProcess(strPath:String;blWait:Boolean):Boolean;
     function  SaveToBuffer(var pTbl:SMONITORDATA):PSMONITORDATA;
     procedure PrepareBuffer(pD:PSMONITORDATA;var pTbl:SMONITORDATA);
     function  ProcMon:Boolean;
    public
     m_hHandle   : MONHANDLE;
     m_wPeriod   : Word;
     m_nBF       : SMONITORDATA;
     constructor Create(wPID,wMID,wVMID,wCMDID,wPeriod,wFormat:Word;dtBegin,dtEnd:TDateTime);
     destructor  Destroy;override;
     procedure StartMonitor;
     procedure StopMonitor;
     procedure SetPeriod(wTime:Integer);
     procedure Flush(dtDate:TDateTime;blInit:Boolean);
     function GetBuffer(dtDate:TDateTime):PSMONITORDATA;
     procedure Run;
    End;
    PCMonitor = ^CMonitor;
    SMONTAG = packed record
     Count : Integer;
     Items : array[0..PH_MAX_MON-1] of CMonitor;
    End;
    procedure MONINIT;
    function  MONCREATE(wPID,wMID,wVMID,wCMDID,wPeriod,wFormat:Word;dtBegin,dtEnd:TDateTime):MONHANDLE;
    function  MONASSIGNED(hHandle:MONHANDLE):MONHANDLE;
    function  MONGET(hMON:MONHANDLE):PCMonitor;
    procedure MONDEL(hMON:MONHANDLE);
    procedure MONSTOP(hMON:MONHANDLE);
    procedure MONSTART(hMON:MONHANDLE);
    procedure MONSETTM(wTime:Word;hMON:MONHANDLE);
    procedure MONHANDLER(var pMsg:CMessage);
    function  MONGETBUFFER(hMON:MONHANDLE;dtDate:TDateTime):PSMONITORDATA;
    procedure MONSAVE(hMON:MONHANDLE;dtDate:TDateTime);
    function  MONLOAD(hMON:MONHANDLE;dtDate:TDateTime):PSMONITORDATA;
    procedure MONRUN;
const
    MON_FMT_1IN1 = 0;
    MON_FMT_1IN3 = 1;
    MON_FMT_1IN4 = 2;
Var
    m_nMON : SMONTAG;
    m_pMDB : PCDBDynamicConn;
implementation
//CData
constructor CData.Create(nCount:Integer);
Begin
     Count := nCount;
End;
destructor CData.Destroy;
Begin
     inherited;
End;
function CData.GetValue:CData;
Begin
     Result := Self;
End;
procedure CData.Reset;
Begin
     m_nCount := 0;
End;
procedure CData.AddValue(const Value:CData);
Begin
End;
procedure CData.SubValue(const Value:CData);
Begin
End;
procedure CData.Extract(var pMsg:CMessage);
Begin
End;
function  CData.GetBuffer:Pointer;
Begin
End;
procedure CData.SetValue(const Value:CData);
Begin
End;
//CDataF1X1
constructor CDataF1X1.Create;
Begin
     inherited Create(1);
     Size  := sizeof(Single);
     Reset;
End;
destructor CDataF1X1.Destroy;
Begin
     inherited;
End;
procedure CDataF1X1.AddValue(const Value:CData);
Begin
     Data :=  Data + (Value as CDataF1X1).Data;
End;
procedure CDataF1X1.SubValue(const Value:CData);
Begin
     Data :=  Data - (Value as CDataF1X1).Data;
End;
procedure CDataF1X1.SetValue(const Value:CData);
Begin
     Data := (Value as CDataF1X1).Data;
End;
procedure CDataF1X1.Extract(var pMsg:CMessage);
Var
     dValue : Double;
Begin
     Move(pMsg.m_sbyInfo[9],dValue,sizeof(Double));
     Data := dValue;
     Reset;
End;
function CDataF1X1.GetBuffer:Pointer;
Begin
     Result := @Data;
End;
//CDataF1X3
constructor CDataF1X3.Create;
Begin
     inherited Create(4);
     Size  := Count*sizeof(Single);
     m_nCount := 1;
End;
destructor CDataF1X3.Destroy;
Begin
     inherited;
End;
procedure CDataF1X3.AddValue(const Value:CData);
Var
     i : Byte;
Begin
     for i:=0 to Count-1 do Data[i] :=  Data[i] + (Value as CDataF1X3).Data[i];
End;
procedure CDataF1X3.SubValue(const Value:CData);
Var
     i : Byte;
Begin
     for i:=0 to Count-1 do Data[i] :=  Data[i] - (Value as CDataF1X3).Data[i];
End;
procedure CDataF1X3.SetValue(const Value:CData);
Begin
     Move((Value as CDataF1X3).Data,Data,Count*sizeof(Single));
End;
procedure CDataF1X3.Extract(var pMsg:CMessage);
Var
     dValue : Double;
Begin
     Move(pMsg.m_sbyInfo[9],dValue,sizeof(Double));
     if m_nCount<(Count-1) then Data[m_nCount] := dValue;
     Inc(m_nCount);
     if m_nCount>(Count-1) then m_nCount := 1;
End;
function CDataF1X3.GetBuffer:Pointer;
Begin
     Result := @Data;
End;
//CDataF1X4
constructor CDataF1X4.Create;
Begin
     inherited Create(4);
     Size  := Count*sizeof(Single);
     Reset;
End;
destructor CDataF1X4.Destroy;
Begin
     inherited;
End;
procedure CDataF1X4.AddValue(const Value:CData);
Var
     i : Byte;
Begin
     for i:=0 to Count-1 do Data[i] :=  Data[i] + (Value as CDataF1X4).Data[i];
End;
procedure CDataF1X4.SubValue(const Value:CData);
Var
     i : Byte;
Begin
     for i:=0 to Count-1 do Data[i] :=  Data[i] - (Value as CDataF1X4).Data[i];
End;
procedure CDataF1X4.SetValue(const Value:CData);
Begin
     Move((Value as CDataF1X4).Data,Data,Count*sizeof(Single));
End;
procedure CDataF1X4.Extract(var pMsg:CMessage);
Var
     dValue : Double;
Begin
     Move(pMsg.m_sbyInfo[9],dValue,sizeof(Double));
     if m_nCount<(Count-1) then Data[m_nCount] := dValue;
     Inc(m_nCount);
     if m_nCount>(Count-1) then Reset;
End;
function CDataF1X4.GetBuffer:Pointer;
Begin
     Result := @Data;
End;
//CDataCluster
constructor CDataCluster.Create(pTM:PSTIMEPERIOD);
Var
     h,m,s,ms : Word;
     dtPeriod : TDateTime;
Begin
     try
     if (pTM.m_dtEnd>pTM.m_dtBegin)and(pTM.m_nPeriod>0) then
     Begin
      m_nCount  := 0;
      m_nPeriod := pTM.m_nPeriod;
      dtPeriod  := pTM.m_dtEnd - pTM.m_dtBegin;
      DecodeTime(dtPeriod,h,m,s,ms);
      m_nTCount  := trunc((h*3600+m*60+s)/m_nPeriod);
      m_dtBegin := pTM.m_dtBegin;
      m_dtEnd   := pTM.m_dtEnd;
      m_nData   := TMemoryStream.Create;
      m_nData.Position := 0;
      m_nData.Write(self,2*sizeof(Integer)+2*sizeof(TDateTime))
     End;
     except
      if Assigned(m_nData) then
      Begin
       m_nData.Free;
       m_nData := Nil;
      End;
     end;
End;
destructor CDataCluster.Destroy;
Begin
     if Assigned(m_nData) then
     Begin
      m_nData.Free;
      m_nData := Nil;
     End;
End;
function  CDataCluster.GetBuffer:Pointer;
Begin
     m_nPosition := m_nData.Position;
      m_nData.Position := 0;
      m_nData.Write(self,2*sizeof(Integer)+2*sizeof(TDateTime));
      Result := m_nData.Memory;
     m_nData.Position := m_nPosition;
End;
function  CDataCluster.GetSize:Integer;
Begin
     Result := m_nData.Size;
End;
procedure CDataCluster.Add(var Data:CData);
Begin
     if m_nCount<m_nTCount then
     Begin
      m_nSize := Data.PSize;
      m_nData.Write(Data.PBuffer^,Data.PSize);
      m_nCount := m_nCount + 1;
     End;
End;
//CDataBuffer
constructor CDataBuffer.Create(nVMID,nMID,nCMDID:Integer);
Begin
     m_nVMID  := nVMID;
     m_nMID   := nMID;
     m_nCMDID := nCMDID;
     m_dtDate := Now;
     m_nCount := 0;
     m_nData  := TMemoryStream.Create;
     m_nData.Position := 0;
     m_nData.Write(self,4*sizeof(Integer)+1*sizeof(TDateTime))
End;
procedure CDataBuffer.Add(var DCData:CDataCluster);
Begin
     m_nData.Write(DCData.PBuffer^,DCData.PSize);
     m_nCount := m_nCount + 1;
End;
procedure CDataBuffer.Flush;
Begin

End;
function CDataBuffer.GetClusters(var DCDatas:CDataClusters):Boolean;
Begin

End;
//CQweryModule
constructor CQweryModule.Create(nVMID,nMID,nCMDID,nPortID:Integer);
Begin
     m_DBuffer := CDataBuffer.Create(nVMID,nMID,nCMDID);
     m_nVMID   := nVMID;
     m_nMID    := nMID;
     m_nPortID := nPortID;
     m_nCMDID  := nCMDID;
End;
destructor CQweryModule.Destroy;
Begin
     inherited;
End;
procedure CQweryModule.SetValue(const Data:CData);
Begin
     m_Data := Data;
     m_DCluster.Add(m_Data);
End;
procedure CQweryModule.OnBeginPeriod(pTM:PSTIMEPERIOD);
Begin
     m_DCluster := CDataCluster.Create(pTM);
End;
procedure CQweryModule.OnEndPeriod;
Begin
     m_DBuffer.Add(m_DCluster);
     m_DCluster.Destroy;
End;
procedure CQweryModule.OnFinalize;
Begin
     m_DBuffer.Flush;
End;
procedure CQweryModule.EventHandler(var pMsg:CMessage);
Begin
     m_Data.Extract(pMsg);
     m_DCluster.Add(m_Data);
End;
//CQweryF1X1
constructor CQweryF1X1.Create(nVMID,nMID,nCMDID,nPortID:Integer);
Begin
     Inherited Create(nVMID,nMID,nCMDID,nPortID);
     m_Data := CDataF1X1.Create;
End;
destructor CQweryF1X1.Destroy;
Begin
     Inherited;
End;
//CQweryF1X3
constructor CQweryF1X3.Create(nVMID,nMID,nCMDID,nPortID:Integer);
Begin
     Inherited Create(nVMID,nMID,nCMDID,nPortID);
     m_Data := CDataF1X3.Create;
End;
destructor CQweryF1X3.Destroy;
Begin
     Inherited;
End;
//CQweryF1X4
constructor CQweryF1X4.Create(nVMID,nMID,nCMDID,nPortID:Integer);
Begin
     Inherited Create(nVMID,nMID,nCMDID,nPortID);
     m_Data := CDataF1X4.Create;
End;
destructor CQweryF1X4.Destroy;
Begin
     Inherited;
End;
//CQweryCluster
constructor CQweryCluster.Create;
Begin

End;
destructor CQweryCluster.Destroy;
Begin

End;
procedure CQweryCluster.OnStart(pTM:PSTIMEPERIOD);
Begin

End;
procedure CQweryCluster.OnStop;
Begin

End;
procedure CQweryCluster.OnOnFinalize;
Begin

End;
procedure CQweryCluster.Run;
Begin

End;
//     m_dtBegin   : TDateTime;
//     m_dtEnd     : TDateTime;
constructor CMonitor.Create(wPID,wMID,wVMID,wCMDID,wPeriod,wFormat:Word;dtBegin,dtEnd:TDateTime);
Begin
     m_blEnabled := False;
     m_wPID      := wPID;
     m_wMID      := wMID;
     m_wVMID     := wVMID;
     m_wCMDID    := wCMDID;
     m_wPeriod   := wPeriod;
     m_dtBegin   := dtBegin;
     m_dtEnd     := dtEnd;
     m_blProced  := False;
     m_dtLastDate:= 0;
     if m_wPeriod<=0 then m_wPeriod := 1;
     m_wFormat   := wFormat;
     m_nTMR      := CTimer.Create;
     if m_wFormat=MON_FMT_1IN3 then m_nD2Ct := 1;
     if m_wFormat=MON_FMT_1IN4 then m_nD2Ct := 0;
     m_nCount    := 0;
     InitBuffer;
     LoadDB(Now);
End;
destructor  CMonitor.Destroy;
Begin
     m_nTMR.Destroy;
     inherited;
End;
procedure CMonitor.InitBuffer;
Var
     h,m,s,ms : Word;
     i : Integer;
Begin
     m_nBF.m_nPeriod := m_wPeriod;
     m_nRCount       := trunc(24*3600/m_wPeriod);
     DecodeTime(Now,h,m,s,ms);
     m_nBF.m_nCount  := trunc((h*3600+m*60+s)/m_wPeriod);
     m_nCount        := m_nBF.m_nCount;
     m_nBF.CmdID     := m_wCMDID;
     m_nBF.m_swVMID  := m_wVMID;
     case m_wFormat of
          MON_FMT_1IN1:
          Begin
           m_nBF.m_nSize := 1;
           SetLength(m_nBF.Items1,m_nRCount);
          End;
          MON_FMT_1IN3,
          MON_FMT_1IN4:
          Begin
           m_nBF.m_nSize := 4;
           SetLength(m_nBF.Items2,m_nRCount);
          End;
     End;
End;
procedure CMonitor.StartMonitor;
Var
     h,m,s,ms : Word;
Begin
     m_blBegin := False;
     m_blEnd   := False;
     DecodeTime(Now,h,m,s,ms);
     m_nBF.m_nCount := trunc((h*3600+m*60+s)/m_wPeriod);
     m_nCount    := m_nBF.m_nCount;
     m_blEnabled := True;
     m_nTMR.SetTimer(DIR_L3TOL3,DL_REPMSG_TMR,0,0,BOX_L3);
     m_nTMR.PTmrEV := OnTimeExpired;
     m_nTMR.OnTimer(m_wPeriod);
End;
procedure CMonitor.StopMonitor;
Begin
     m_blBegin := True;
     m_blEnd   := True;
     m_nTMR.OffTimer;
     m_blEnabled := False;
End;
procedure CMonitor.OnTimeExpired(byEvent:Byte);
Begin
     Save;
     Load;
End;
procedure CMonitor.Save;
Begin
     if m_nCount<m_nRCount then
     Begin
      m_nBF.m_dtDate  := Now;
      case m_wFormat of
           MON_FMT_1IN1: m_nBF.Items1[m_nCount].Value := m_nD1.Value;
           MON_FMT_1IN3,
           MON_FMT_1IN4: Move(m_nD2.Value,m_nBF.Items2[m_nCount],sizeof(MONTAG2))
      End;
      m_nCount    := m_nCount + 1;
      m_nBF.m_nCount := m_nCount;
      ResetData;
     End;
End;
procedure CMonitor.ResetData;
Begin
     if m_wFormat=MON_FMT_1IN3 then m_nD2Ct := 1;
     if m_wFormat=MON_FMT_1IN4 then m_nD2Ct := 0;
     //FillChar(m_nD1,0,sizeof(MONTAG1));
     //FillChar(m_nD2,0,sizeof(MONTAG2));
     //if m_nCount>=m_nRCount then Flush(Now,True);
     //if (m_nCount mod 1000)=0 then Flush(Now,False);
     m_nTMR.OnTimer(m_wPeriod);
End;
procedure CMonitor.SetPeriod(wTime:Integer);
Begin
     m_wPeriod := wTime;
     InitBuffer;
End;
procedure CMonitor.Load;
Var
     IsFree : Boolean;
Begin
     IsFree:=False;
     if FCHECK(BOX_L3_QS+m_wPID)=0 then IsFree:=True;
     EVT(QM_ENT_MON_IND);
     EVT(QM_ENT_MTR_IND);
     CMD;
     EVT(QM_FIN_MTR_IND);
     EVT(QM_FIN_COM_IND);
     EVT(QM_FIN_MON_IND);
     if IsFree=True then
     SendMSG(BOX_L2,m_wPID,DIR_QMTOL2,DL_STARTSNDR_IND);
End;
procedure CMonitor.Flush(dtDate:TDateTime;blInit:Boolean);
Var
     pD : PSMONITORDATA;
Begin
     pD := @m_nBF;
     //pD^.m_dtDate := dtDate;

     if trunc(dtDate)<>trunc(Now) then
     Begin
      if m_pBuff.Count=0 then exit;
      m_pBuff.Items[0].m_dtDate := dtDate;
      pD := @m_pBuff.Items[0];
     End;
     
     SaveToFile(pD);
     Pack;
     SaveToDB(pD);
     if blInit=True Then m_nCount := 0;
End;
procedure CMonitor.SaveToFile(pD:PSMONITORDATA);
Var
     i : Integer;
Begin
     //if pD^.m_nData<>Nil then pD^.m_nData.Free;
     pD^.m_nData := TMemoryStream.Create;
     pD^.m_nData.Position := 0;
     pD^.m_nData.Write(pD^,6*sizeof(Integer)+sizeof(TDateTime));
     //for i:=0 to m_nRCount-1 do
     for i:=0 to pD^.m_nCount-1 do
     Begin
      if m_wFormat=MON_FMT_1IN1  then pD^.m_nData.Write(pD^.Items1[i].Value,sizeof(MONTAG1)) else
      if (m_wFormat=MON_FMT_1IN3)or
         (m_wFormat=MON_FMT_1IN4)then
         Begin
           //m_nBF.Items2[i].Value[0] := i*0.5;
           //m_nBF.Items2[i].Value[1] := i*1.5;
           //m_nBF.Items2[i].Value[2] := i*2.5;
           //m_nBF.Items2[i].Value[3] := i*3.5;
           pD^.m_nData.Write(pD^.Items2[i].Value[0],sizeof(MONTAG2));
         End;
     End;
     pD^.m_nData.SaveToFile(m_strExePath+'arch.mdd');
     pD^.m_nData.Free;
End;
procedure CMonitor.Pack;
Var
     strPackPath,strArcPathFile,strSavePathFile:String;
Begin
     strArcPathFile  := m_strExePath+'arch.rar';
     strSavePathFile := m_strExePath+'arch.mdd';
     strPackPath     := '"'+m_strExePath+'rar.exe" a -ep1 '+'"'+strArcPathFile+'" "'+strSavePathFile+'"';
     StartProcess(strPackPath,TRUE);
End;
procedure CMonitor.SaveToDB(pD:PSMONITORDATA);
Begin
     pD^.m_nData   := TMemoryStream.Create;
      pD^.m_nData.Position := 0;
      pD^.m_nData.LoadFromFile(m_strExePath+'arch.rar');
      m_pMDB.AddMonTable(pD^);
     pD^.m_nData.Free;
End;
function CMonitor.LoadDB(dtDate:TDateTime):PSMONITORDATA;
Begin
     Result := Nil;
     if (m_dtLastDate=dtDate)and(m_pBuff.Count<>0)and(trunc(dtDate)<>trunc(Now)) then
     Begin
      if trunc(dtDate)=trunc(Now) then Result := @m_nBF else  Result := @m_pBuff.Items[0];
      exit;
     End;
     if m_pMDB.GetMonitorTable(m_wVMID,m_wCMDID,dtDate,m_pBuff)=True then
     Begin
      m_dtLastDate := dtDate;
      m_pBuff.Items[0].m_nData.SaveToFile(m_strExePath+'arch.rar');
      m_pBuff.Items[0].m_nData.Free;
      UnPack;
      Result := SaveToBuffer(m_pBuff.Items[0]);
     End else Result := @m_nBF;
End;
procedure CMonitor.UnPack;
Var
     strPackPath,strArcPathFile,strSavePathFile:String;
Begin
     strArcPathFile  := m_strExePath+'arch.rar';
     strPackPath     := '"'+m_strExePath+'rar.exe" x -y '+'"'+strArcPathFile+'"';
     StartProcess(strPackPath,TRUE);
End;
function CMonitor.SaveToBuffer(var pTbl:SMONITORDATA):PSMONITORDATA;
Var
     i  : Integer;
     pD : PSMONITORDATA;
     //dtDate : TDateTime;
Begin
     pD := @pTbl;
     //dtDate := pTbl.m_dtDate;
     if trunc(pTbl.m_dtDate)=trunc(Now) then pD := @m_nBF;
     pTbl.m_nData := TMemoryStream.Create;
     pTbl.m_nData.Position := 0;
     pTbl.m_nData.LoadFromFile(m_strExePath+'arch.mdd');
     pTbl.m_nData.Read(pD^,6*sizeof(Integer)+sizeof(TDateTime));
     //pD^.m_dtDate := dtDate;
     PrepareBuffer(pD,pTbl);
     for i:=0 to pD^.m_nCount-1 do
     Begin
      if pD^.m_nSize=1 then pTbl.m_nData.Read(pD^.Items1[i].Value,sizeof(MONTAG1)) else
      if pD^.m_nSize=4 then pTbl.m_nData.Read(pD^.Items2[i].Value[0],sizeof(MONTAG2));
     End;
     SetLength(pTbl.Items1,0);
     SetLength(pTbl.Items2,0);
     pTbl.m_nData.Free;
     Result := pD;
End;
procedure CMonitor.PrepareBuffer(pD:PSMONITORDATA;var pTbl:SMONITORDATA);
Var
     nRCount : Integer;
Begin
     if trunc(pTbl.m_dtDate)<>trunc(Now) then
     Begin
      nRCount := trunc(24*3600/pD^.m_nPeriod);
      if pD^.m_nSize=1 then SetLength(pD^.Items1,nRCount) else
      if pD^.m_nSize=4 then SetLength(pD^.Items2,nRCount);
     End else
     if trunc(pTbl.m_dtDate)=trunc(Now) then
     Begin
      //SetLength(pTbl.Items1,0);
      //SetLength(pTbl.Items2,0);
      m_wPeriod := pD^.m_nPeriod;
      InitBuffer;
     End;
End;
function CMonitor.GetBuffer(dtDate:TDateTime):PSMONITORDATA;
Begin
     if trunc(dtDate)=trunc(Now) then Result := @m_nBF else
     Result := LoadDB(dtDate);
End;
procedure CMonitor.EVT(wFinal:Integer);
Var
     pQR : CQueryPrimitive;
Begin
     with pQR do
     Begin
      m_wLen      := sizeof(CQueryPrimitive);
      m_swVMtrID  := m_wVMID;
      m_swMtrID   := m_wMID;
      m_swParamID := wFinal;
      m_swCmdID   := m_hHandle;
      m_sbyEnable := 1;
     End;
     FPUT(BOX_L3_QS+m_wPID,@pQR);
End;
procedure CMonitor.CMD;
Var
     pQR : CQueryPrimitive;
Begin
     with pQR do
     Begin
      m_wLen      := sizeof(CQueryPrimitive);
      m_swVMtrID  := m_wVMID;
      m_swMtrID   := m_wMID;
      m_swParamID := m_wCMDID;
      m_swSpecc0  := 0;
      m_swSpecc1  := 0;
      m_swSpecc2  := 0;
      m_swCmdID   := m_hHandle;
      m_sbyEnable := 1;
     End;
     FPUT(BOX_L3_QS+m_wPID,@pQR);
End;
function CMonitor.EventHandler(var pMsg:CMessage):Boolean;
Var
     fValue : Double;
     nCMDID : Byte;
Begin
     case pMsg.m_sbyType of
          DL_MONINFO_IND:
          Begin
           //TraceM(3,pMsg.m_swObjID,'(__)CMONI::>INP:',@pMsg);
           nCMDID := pMsg.m_sbyInfo[1]; if nCMDID>MAX_PARAM then nCMDID := 0;
           Move(pMsg.m_sbyInfo[9],fValue,sizeof(Double));
           case m_wFormat of
                MON_FMT_1IN1 :
                Begin
                 m_nD1.Value := fValue;
                 TraceL(3,pMsg.m_sbyIntID,'(__)CL3MD::>CMONI: CMD: '+m_nCommandList.Strings[nCMDID]+' V0: '+FloatToStr(m_nD1.Value));
                End;
                MON_FMT_1IN3,
                MON_FMT_1IN4:
                Begin
                 if m_nD2Ct<=3 then
                 Begin
                  m_nD2.Value[m_nD2Ct] := fValue;
                  TraceL(3,pMsg.m_sbyIntID,'(__)CL3MD::>CMONI: CMD: '+m_nCommandList.Strings[nCMDID]+' V'+IntToStr(m_nD2Ct)+': '+FloatToStr(m_nD2.Value[m_nD2Ct]));
                  m_nD2Ct := m_nD2Ct + 1;
                 End;
                End;
           End;
          End;
     End;
End;
function CMonitor.StartProcess(strPath:String;blWait:Boolean):Boolean;
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
      TraceL(4,0,':Process is not created');
      result := FALSE;
     end;
     if(blWait) then
     begin
      dwRes := WaitForSingleObject(pi.hProcess,14*60*1000);
      if(dwRes=WAIT_ABANDONED) then TraceL(4,0,':Process is abandoned!');
     end;
     CloseHandle( pi.hProcess );
     CloseHandle( pi.hThread );
     result := True;
end;
function CMonitor.ProcMon:Boolean;
Begin
     Result := False;
     if (m_dtBegin<=Now)and(m_blBegin=False) then
     Begin
      StartMonitor;
      m_blBegin := True;
      Result    := True;
     End;
     if (m_dtEnd>=Now)and(m_blEnd=False) then
     Begin
      StopMonitor;
      m_blEnd := True;
      Result  := False;
     End;
End;
procedure CMonitor.Run;
Begin
     if (m_blEnabled=True) then
     Begin
      ProcMon;
      m_nTMR.RunTimer;
     End;
End;
//Monitor Handler
procedure MONINIT;
Begin
     m_pMDB := m_pDB.CreateConnect;
End;
function  MONCREATE(wPID,wMID,wVMID,wCMDID,wPeriod,wFormat:Word;dtBegin,dtEnd:TDateTime):MONHANDLE;
Var
     i : Integer;
Begin
     Result := 0;
     try
     for i:=0 to PH_MAX_MON-1 do
     Begin
      if not Assigned(m_nMON.Items[i]) then
      Begin
       m_nMON.Count := m_nMON.Count + 1;
       m_nMON.Items[i] := CMonitor.Create(wPID,wMID,wVMID,wCMDID,wPeriod,wFormat,dtBegin,dtEnd);
       m_nMON.Items[i].m_hHandle := i;
       Result := i;
       exit;
      End;
     End;
     except
      TraceER('(__)CMONI::>Error In CREATEMONITOR!!!');
     End;
End;
function  MONASSIGNED(hHandle:MONHANDLE):MONHANDLE;
Begin
     if hHandle=-1 then Begin Result := -1;exit;end;
     if Assigned(m_nMON.Items[hHandle]) then
     Result := hHandle else Result := -1;
End;
function  MONGET(hMON:MONHANDLE):PCMonitor;
Begin
     if hMON=-1 then Begin Result := Nil;exit;End;
     if Assigned(m_nMON.Items[hMON]) then
     Begin
      Result := @m_nMON.Items[hMON];
     End;
End;
procedure MONDEL(hMON:MONHANDLE);
Begin
     if hMON<>-1 then
     if Assigned(m_nMON.Items[hMON]) then
     Begin
      if m_nMON.Count>0 then m_nMON.Count := m_nMON.Count - 1;
      m_nMON.Items[hMON].StopMonitor;
      m_nMON.Items[hMON].Destroy;
      m_nMON.Items[hMON] := Nil;
     End;
End;
procedure MONSTOP(hMON:MONHANDLE);
Begin
     if hMON<>-1 then
     if Assigned(m_nMON.Items[hMON]) then
     Begin
      m_nMON.Items[hMON].StopMonitor;
     End;
End;
procedure MONSTART(hMON:MONHANDLE);
Begin
     if hMON<>-1 then
     if Assigned(m_nMON.Items[hMON]) then
     Begin
      m_nMON.Items[hMON].StartMonitor;
     End;
End;
procedure MONSETTM(wTime:Word;hMON:MONHANDLE);
Begin
     if hMON<>-1 then
     if Assigned(m_nMON.Items[hMON]) then
     Begin
      if wTime>0 then m_nMON.Items[hMON].SetPeriod(wTime);
     End;
End;
function MONGETBUFFER(hMON:MONHANDLE;dtDate:TDateTime):PSMONITORDATA;
Begin
     if hMON=-1 then Begin Result := Nil;exit;End;
     if Assigned(m_nMON.Items[hMON]) then
     Begin
      Result := m_nMON.Items[hMON].GetBuffer(dtDate);
     End;
End;
procedure MONHANDLER(var pMsg:CMessage);
Var
     hMON : MONHANDLE;
Begin
     try
     hMON := pMsg.m_sbyIntID;
     if Assigned(m_nMON.Items[hMON]) then
     Begin
      m_nMON.Items[hMON].EventHandler(pMsg);
     End;
     except
      TraceER('(__)CMONI::>Error In MONHANDLER!!!');
     end;
End;
procedure MONSAVE(hMON:MONHANDLE;dtDate:TDateTime);
Begin
     if hMON<>-1 then
     if Assigned(m_nMON.Items[hMON]) then
     Begin
      m_nMON.Items[hMON].Flush(dtDate,False);
     End;
End;
function MONLOAD(hMON:MONHANDLE;dtDate:TDateTime):PSMONITORDATA;
Begin
     Result := Nil;
     if hMON<>-1 then
     if Assigned(m_nMON.Items[hMON]) then
     Begin
      Result := m_nMON.Items[hMON].LoadDB(dtDate);
     End;
End;
procedure MONRUN;
Var
     i : Integer;
Begin
     for i:=0 to PH_MAX_MON-1 do
     Begin
      if Assigned(m_nMON.Items[i]) then
      Begin
       m_nMON.Items[i].Run;
      End;
     End;
End;
end.
