unit knsl3datatype;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
controls,utldatabase,utldynconnect,knsl5tracer,knsl3EventBox,utlTimeDate;
type
    CData = class
    private
     m_nCount    : Integer;
     Size        : Integer;
     Mask        : int64;
     //TRMask      : int64;
     m_snCMDID   : Byte;
     m_stSvPeriod: Byte;
     m_dtLastTime: TDateTime;
     m_pFDB      : PCDBDynamicConn;
    private
     procedure CheckCount;
     function GetBuffer:Pointer;virtual;
     function GetIndex(var pMsg:CMessage):Integer;virtual;
     function GetCurrentIndex:Integer;virtual;
     function GetSavePeriod:TDateTime;
     function IsComplette(nIndex:Integer):Boolean;virtual;
     function IsCompletteEx(nIndex:Integer):Boolean;
     function FinalExecute:Boolean;virtual;
     procedure SetVal(const nIndex: Integer; const Value: extended);virtual;
     procedure SetValEx(const nIndex: Integer; const Value: extended);
     procedure Reset;virtual;
     function FlushQwery:Boolean;
     function FlushCurrent:Boolean;virtual;
     function FlushUpdate:Boolean;virtual;
    public
     m_snAID        : Word;
     m_snGID        : Word;
     m_snMID        : Word;
     m_snVMID       : Word;
     m_sbyPortID    : Word;
     Count          : Integer;
     Express        : String;
     m_byInState    : Byte;
     m_sTime        : TDateTime;
     m_sbyLevel     : Byte;
     m_sbyLockState : Byte;
     m_snCLSID      : Byte;
     m_sbyType      : Byte;
     m_sblSaved     : Byte;
     IsUpdate       : Boolean;
     destructor Destroy();override;
     constructor Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,nCount:Integer;nExpress:String);
     procedure FreeCmdData;
     function LoadData(sTime:TDateTime;nIsUpdate:Boolean):Boolean;virtual;
     function Flush:Boolean;
     function GetState:Boolean;
     function GetTimeState:Boolean;
     function GetValue(nIndex:Dword):Extended;virtual;
     function ExtractData(var pMsg:CMessage):Boolean;
     function Extract(var pMsg:CMessage):Boolean;virtual;
     procedure SetMask(nCount:Integer);virtual;
     procedure SetMaskEx(nCount:Integer;var pMsg:CMessage);virtual;
     procedure ReSetMask(nCount:Integer);
     function GetMask(nIndex:Integer):Boolean;
     function GetTMState:Boolean;
    public
     property SetValue[const nIndex:Integer]: extended write SetValEx;
    End;

    CDataF = class(CData)
    private
     lValue : array of Single;
     destructor Destroy();override;
     procedure Reset;override;
    private
     function GetBuffer:Pointer;virtual;
     procedure SetVal(const nIndex: Integer; const Value: extended);override;
    public
     constructor Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,nCount:Integer;nExpress:String);
     function GetValue(nIndex:Dword):Extended;override;
    End;

    CDataF48 = class(CDataF)
    private
     function FlushCurrent:Boolean;override;
     function FlushUpdate:Boolean;override;
     function GetCurrentIndex:Integer;override;
    public
     constructor Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
     function GetIndex(var pMsg:CMessage):Integer;override;
     function IsComplette(nIndex:Integer):Boolean;override;
     procedure SetMask(nCount:Integer);override;
     //function FinalExecute:Boolean;override;
    End;

    CDataD = class(CData)
    private
     lValue : array of Double;
     destructor Destroy();override;
     procedure Reset;override;
    private
     function GetBuffer:Pointer;virtual;
     procedure SetVal(const nIndex: Integer; const Value: extended);override;
     function FlushCurrent:Boolean;override;
     function FlushUpdate:Boolean;override;
     function GetIndex(var pMsg:CMessage):Integer;override;
    public
     constructor Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,nCount:Integer;nExpress:String);
     function GetValue(nIndex:Dword):Extended;override;
    End;

    CDataD1 = class(CDataD)
    public
     constructor Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
    End;
    CDataD3 = class(CDataD)
    public
     constructor Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
    End;
    CDataD4 = class(CDataD)
    public
     constructor Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
    End;
    CDataD5 = class(CDataD)
    private
     //function FlushCurrent:Boolean;override;
     //function FlushUpdate:Boolean;override;
    public
     constructor Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
     //function GetIndex(var pMsg:CMessage):Integer;override;
    End;
    CDataD48 = class(CDataD)
    private
     function FlushCurrent:Boolean;override;
     function FlushUpdate:Boolean;override;
     function GetCurrentIndex:Integer;override;
     function TimeToIndex(dtTime:TDateTime):Integer;
    public
     constructor Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
     function GetIndex(var pMsg:CMessage):Integer;override;
     function IsComplette(nIndex:Integer):Boolean;override;
     procedure SetMask(nCount:Integer);override;
     procedure SetMaskEx(nCount:Integer;var pMsg:CMessage);override;
     function LoadData(sTime:TDateTime;nIsUpdate:Boolean):Boolean;override;

     //function FinalExecute:Boolean;override;
    End;
    CDataDateTime = class(CDataD)
    public
     constructor Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
     function  Extract(var pMsg:CMessage):Boolean;override;
    End;
    CDataEvent = class(CData)
    public
     constructor Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
     function  Extract(var pMsg:CMessage):Boolean;override;

    End;
implementation
//CDataD
constructor CData.Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,nCount:Integer;nExpress:String);
Begin
     Count         := nCount;
     m_nCount      := 0;
     Mask          := 0;
     //TRMask        := 0;
     //if nVMID=35 then
     m_byInState   := DT_FRE+1;
     m_byInState   := DT_FRE;
     Express       := nExpress;
     //m_sbyLockState:= PR_TRUE;
     m_sbyLockState:= SA_UNLK;
     IsUpdate      := False;
     //IsCalc        := False;
     //IsOpenTrap    := TRP_FREE;
     m_snAID       := nAID;
     m_snGID       := nGID;
     m_snVMID      := nVMID;
     m_snMID       := nMID;
     m_snCMDID     := nCMDID;
     m_snCLSID     := nCLSID; 
     m_stSvPeriod  := nSVP;
     m_sbyLevel    := byLevel;
     m_sbyType     := byType;
     m_sblSaved    := blSaved;
     m_dtLastTime  := Now-1;
     m_pFDB        := pFDB;
End;
destructor CData.Destroy;
Begin
     inherited;
End;
function CData.LoadData(sTime:TDateTime;nIsUpdate:Boolean):Boolean;
Begin
     Result := True;
End;
function CData.GetSavePeriod:TDateTime;
Begin
     case m_stSvPeriod of
       1: Result := EncodeTime(0,0,1,0);
       2: Result := EncodeTime(0,3,0,0);
       3: Result := EncodeTime(0,15,0,0);
       4: Result := EncodeTime(0,30,0,0);
       5: Result := EncodeTime(1,0,0,0);
       6: Result := EncodeTime(3,0,0,0);
       7: Result := EncodeTime(6,0,0,0);
       else
       Result := Now;
     End;
End;
function CData.GetCurrentIndex:Integer;
Var
     nIndex:Integer;
Begin
     nIndex := trunc(frac(Now)/EncodeTime(0,30,0,0));
     if nIndex>0 then Dec(nIndex);
     Result := nIndex;
End;
procedure CData.FreeCmdData;
Begin
     m_nCount    := 0;
     m_byInState := DT_FRE;
     IsUpdate    := False;
     m_sTime     := 0;
End;
function CData.GetState:Boolean;
Begin
     Result:=False;
     if (m_byInState=DT_OLD)or(m_byInState=DT_CLC)or(m_byInState=DT_FRE) then Result:=False else
     if (m_byInState=DT_NEW)or(m_byInState=DT_EXT) then Result:=True;
End;
function CData.GetTMState:Boolean;
Begin
     if m_sbyLevel=0  then Result := (m_byInState=DT_EXT)or(m_byInState=DT_NEW) else
     if m_sbyLevel<>0 then Result := (m_byInState=DT_EXT)or(m_byInState=DT_NEW);
End;
function CData.GetTimeState:Boolean;
Begin
     Result:=(m_byInState=DT_NEW)or(m_byInState=DT_EXT);
End;
function CData.GetValue(nIndex:Dword):Extended;
Begin
     Result := 0;
End;
procedure CData.SetValEx(const nIndex: Integer; const Value: extended);
Begin
     if nIndex<=(Count-1) then
     Begin
      SetVal(nIndex,Value);
      //SetMask(nIndex);
     End;
     m_byInState := DT_NEW;
     //if m_sbyLevel=1
     //if IsCompletteEx(nIndex)=True then
     //m_byInState:=DT_NEW else
     //Inc(m_nCount);
End;
procedure CData.SetVal(const nIndex: Integer; const Value: extended);
Begin
End;
procedure CData.Reset;
Begin
     m_nCount := 0;
     m_byInState := DT_FRE;
     IsUpdate := False;
     m_sTime  := 0;
End;
function  CData.Extract(var pMsg:CMessage):Boolean;
Var
     dValue : Double;
     nIndex : Integer;
Begin
     Result := False;
     Move(pMsg.m_sbyInfo[9],dValue,sizeof(Double));
     nIndex := GetIndex(pMsg);
     SetVal(nIndex,dValue);
     SetMaskEx(nIndex,pMsg);
     //SetMask(nIndex);
     //TraceL(4,0,'(__)CL3MD::>CDTTP: DATA SID:'+IntToStr(m_nCount)+' CID:'+IntToStr(Count-1));
     CheckCount;
     //EventBox.FixEvents(ET_NORMAL,'������-1. ������:'+GetVMName(m_snVMID)+' �����: '+DateTimeToStr(m_sTime)+' ��������:'+GetCMD(m_snCMDID)+' : '+FloatToStr(dValue)+IntToStr(m_nCount)+' CID:'+IntToStr(Count-1));
     if IsComplette(nIndex)=True then
     Begin
      m_byInState:=DT_EXT;
      Result:=True;
      EventBox.FixEvents(ET_NORMAL,'������. ������:'+GetVMName(m_snVMID)+' �����: '+DateTimeToStr(m_sTime)+' ��������:'+GetCMD(m_snCMDID){+' : '+FloatToStr(dValue)});
      //EventBox.FixEvents(ET_NORMAL,'������. ������:'+IntToStr(m_snVMID)+' �����: '+DateTimeToStr(m_sTime)+' ��������:'+GetCMD(m_snCMDID){+' : '+FloatToStr(dValue)});
     End else Inc(m_nCount);
End;
procedure CData.SetMaskEx(nCount:Integer;var pMsg:CMessage);
Begin
     SetMask(nCount);
End;
procedure CData.CheckCount;
Begin
     if m_byInState=DT_EXT then
     if m_nCount=(Count-1) then
     Begin
      FreeCmdData;
      EventBox.FixEvents(ET_CRITICAL,'�������. ������:'+IntToStr(m_snVMID)+' ��������:'+GetCMD(m_snCMDID));
     End;
End;
function CData.GetIndex(var pMsg:CMessage):Integer;
Begin
     Result := pMsg.m_sbyServerID and $3f;
     if Result>=Count then Result := 0;
End;
function CData.IsCompletteEx(nIndex:Integer):Boolean;
Begin
     if IsUpdate=True  then Result := (m_nCount=(Count-1)) else
     if IsUpdate=False then Result := (nIndex and $3f )=GetCurrentIndex;
End;
function CData.IsComplette(nIndex:Integer):Boolean;
Begin
     //TraceL(4,0,'(__)CL3MD::>CDTTP: DATA SID:'+IntToStr(m_nCount)+' CID:'+IntToStr(Count-1));
     Result := False;
     if (m_nCount=(Count-1)) then
     Begin
      TraceL(4,0,'(__)CL3MD::>CDTTP: DATA RDY.');
      Result := True;
     End;
End;
function CData.FinalExecute:Boolean;
Begin
     Result := True;
End;
function  CData.ExtractData(var pMsg:CMessage):Boolean;
Var
     dDT  : CDTTime;
     fVal : Double;
Begin
     if pMsg.m_sbyDirID=1 then IsUpdate := True else IsUpdate := False;
     Move(pMsg.m_sbyInfo[2],dDT,sizeof(CDTTime));
     if (dDT.Year=0)or(dDT.Month=0)or(dDT.Day=0)or(dDT.Month>12)or(dDT.Hour>23)or(dDT.Month>12)or(dDT.Day>31)or(dDT.Sec>59) then exit else
     m_sTime := EncodeDate(2000+dDT.Year,dDT.Month,dDT.Day)+EncodeTime(dDT.Hour,dDT.Min,dDT.Sec,0);
     Result := Extract(pMsg);
     Move(pMsg.m_sbyInfo[9],fVal,sizeof(Double));
     TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>CDTTP: EXT:'+DateTimeToStr(m_sTime)+' TID:'+IntToStr(pMsg.m_sbyInfo[8])+' SID:'+IntToStr(m_nCount)+
      ' CMD:'+m_nCommandList.Strings[pMsg.m_sbyInfo[1]]+
      ' VAL:'+FloatToStr(fVal));
End;
function CData.Flush:Boolean;
Begin
     if IsUpdate=False then FlushQwery else
     if IsUpdate=True  then FlushUpdate;
     if IsUpdate=True  then Mask := 0;
     //m_byInState := DT_FRE;
     //m_nCount    := 0;
End;
function CData.FlushQwery:Boolean;
Var
     SystemTime: TSystemTime;
Begin
     if (Now>=(m_dtLastTime+GetSavePeriod))or(trunc(Now)-trunc(m_dtLastTime)<>0)or(m_stSvPeriod=1) then
     Begin
      DateTimeToSystemTime(Now,SystemTime);
      SystemTime.wSecond :=0;SystemTime.wMilliseconds:=0;
      m_dtLastTime       :=  SystemTimeToDateTime(SystemTime);
      FlushCurrent;
     End;
End;
function CData.FlushUpdate:Boolean;
Begin
End;
function CData.FlushCurrent:Boolean;
Begin
End;
procedure CData.SetMask(nCount:Integer);
Var
     nShift : int64;
Begin
     nShift := 1;
     Mask := Mask or(nShift shl nCount);
End;
procedure CData.ReSetMask(nCount:Integer);
Var
     nShift : int64;
Begin
     nShift := 1;
     Mask := Mask and (not(nShift shl nCount));
End;
function CData.GetMask(nIndex:Integer):Boolean;
Var
     nShift : int64;
Begin
     nShift := 1;
     Result := (Mask and (nShift shl nIndex))<>0;
End;
function CData.GetBuffer:Pointer;Begin End;
//CDataF
constructor CDataF.Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,nCount:Integer;nExpress:String);
Begin
     inherited  Create(pFDB,nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,nCount,nExpress);
     Size  := nCount*sizeof(Single);
     SetLength(lValue,nCount);
     Reset;
End;
destructor CDataF.Destroy();
Begin
     SetLength(lValue,0);
     inherited;
End;
procedure CDataF.Reset;
Var
    i:Integer;
Begin
    for i:=0 to Count-1 do
    lValue[i] := 0;
End;
function CDataF.GetBuffer:Pointer;
Begin
     Result := @lValue;
End;
function CDataF.GetValue(nIndex:Dword):Extended;
Begin
     Result := 0;
     if nIndex<=(Count-1) then
     Result := lValue[nIndex];
End;
procedure CDataF.SetVal(const nIndex: Integer; const Value: extended);
Begin
     if nIndex<=(Count-1) then
     lValue[nIndex] := (Value);
End;
//CDataF48
constructor CDataF48.Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
Begin
     inherited  Create(pFDB,nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,48,nExpress);
End;
function CDataF48.GetIndex(var pMsg:CMessage):Integer;
Begin
     if IsUpdate=True  then Result:= pMsg.m_sbyServerID and $3f else
     if IsUpdate=False then Result:= GetCurrentIndex;
     if Result>=Count  then Result := 0;
End;
function CDataF48.GetCurrentIndex:Integer;
Var
     nIndex:Integer;
Begin
     nIndex := trunc(frac(Now)/EncodeTime(0,30,0,0));
     if nIndex>0 then Dec(nIndex);
     Result := nIndex;
End;
function CDataF48.IsComplette(nIndex:Integer):Boolean;
Begin
     if IsUpdate=True  then
     Begin
      Result := (m_nCount=(Count-1));
      if Result=True then TraceL(4,0,'(__)CL3MD::>CDTTP: FDATA RDY48 UPD.');
     End else
     if IsUpdate=False then
     Begin
      Result := (nIndex and $3f )=GetCurrentIndex;
      if Result=True then TraceL(4,0,'(__)CL3MD::>CDTTP: FDATA RDY48 QWR.');
     End;
End;
procedure CDataF48.SetMask(nCount:Integer);
Var
     nShift : int64;
Begin
     nShift := 1;
     if trunc(m_sTime)=trunc(Now) then
     Begin
      if nCount<=GetCurrentIndex then
      Mask := Mask or(nShift shl nCount) else
      Mask := Mask and not (nShift shl nCount);
     End else
     Mask := Mask or(nShift shl nCount);
End;
{
function CDataD48.GetCurrentIndex:Integer;
Var
     nIndex:Integer;
Begin
     nIndex := trunc(frac(Now)/EncodeTime(0,30,0,0));
     if nIndex>0 then Dec(nIndex);
     Result := nIndex;
End;
}
function CDataF48.FlushCurrent:Boolean;
Var
     pD  : L3CURRENTDATA;
Begin
     pD.m_swVMID        := m_snVMID;
     pD.m_swTID         := 0;
     pD.m_swCMDID       := m_snCMDID;
     pD.m_swSID         := GetCurrentIndex;
     pD.m_sfValue       := GetValue(pD.m_swSID);
     pD.m_sTime         := m_sTime;
     //pD.m_sTime         := Now;
     pD.m_byOutState    := LM_NRM;
     pD.m_byInState     := DT_FLS;
     pD.m_sMaskRead     := Mask;
     pD.m_sMaskReRead   := Mask;
     pD.m_CRC           := 0;
     SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_SET_CUR,SVS_CUR,sizeof(L3CURRENTDATA),@pD);
     SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_UPD_F48,SVS_CUR,sizeof(L3CURRENTDATA),@pD);
End;
function CDataF48.FlushUpdate:Boolean;
Var
     pD : L3GRAPHDATA;
     i,nCount  : Integer;
Begin
     nCount             := Count;
     for i:=0 to Count-1 do pD.v[i]:=0;
     if (trunc(m_sTime)=trunc(Now)) then
     nCount             := GetCurrentIndex;
     pD.m_swVMID        := m_snVMID;
     pD.m_swCMDID       := m_snCMDID;
     for i:=0 to nCount-1 do
     pD.v[i]            := GetValue(i);
     pD.m_sdtLastTime   := m_sTime;
     pD.m_sdtDate       := m_sTime;
     pD.m_sMaskRead     := Mask;
     pD.m_sMaskReRead   := Mask;
     pD.m_swSumm        := 0;
     pD.m_CRC           := 0;
     SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_ADD_F48,SVS_F48,sizeof(L3GRAPHDATA),@pD);
End;
//CDataD
constructor CDataD.Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,nCount:Integer;nExpress:String);
Begin
     inherited  Create(pFDB,nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,nCount,nExpress);
     Size  := nCount*sizeof(Double);
     SetLength(lValue,nCount);
     Reset;
End;
destructor CDataD.Destroy();
Begin
     SetLength(lValue,0);
     inherited;
End;
procedure CDataD.Reset;
Var
    i:Integer;
Begin
    for i:=0 to Count-1 do
    lValue[i] := 0;
End;
function CDataD.GetBuffer:Pointer;
Begin
     Result := @lValue;
End;
function CDataD.GetValue(nIndex:Dword):Extended;
Begin
     Result := 0;
     if nIndex<=(Count-1) then
     Result := lValue[nIndex];
End;
procedure CDataD.SetVal(const nIndex: Integer; const Value: extended);
Begin
     if nIndex<=(Count-1) then
     Begin
      lValue[nIndex] := (Value);
      if (m_sbyType=MET_SUMM)or(m_sbyType=MET_GSUMM) then Inc(m_nCount);
     End;
End;
function CDataD.GetIndex(var pMsg:CMessage):Integer;
Begin
     //Result:= m_nCount;
     Result:= pMsg.m_sbyInfo[8];
     if Result>=Count then Result := 0;
End;
function CDataD.FlushUpdate:Boolean;
Var
     pD  : L3CURRENTDATA;
     nSH : int64;
     i   : Integer;
Begin
     nSH := 1;
     for i:=0 to Count-1 do
     Begin
      pD.m_swVMID        := m_snVMID;
      pD.m_swTID         := i;
      pD.m_swCMDID       := m_snCMDID;
      pD.m_sfValue       := GetValue(i);
      pD.m_sTime         := m_sTime;
      pD.m_byOutState    := LM_NRM;
      pD.m_byInState     := DT_FLS;
      pD.m_sbyMaskRead   := Byte((Mask and (nSH shl i))<>0);
      pD.m_sbyMaskReRead := Byte((Mask and (nSH shl i))<>0);
      pD.m_CRC           := 0;
      //EventBox.FixEvents(ET_RELEASE,'���.���. ������:'+IntToStr(pD.m_swVMID)+' �����: '+DateTimeToStr(pD.m_sTime)+' ��������:'+GetCMD(pD.m_swCMDID));
      if m_sblSaved=SV_ARCH_ST then
      Begin
       SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_SET_CUR,SVS_CUR,sizeof(L3CURRENTDATA),@pD);
       SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_SET_ARC,SVS_CUR,sizeof(L3CURRENTDATA),@pD);
      End;
     End;
End;
function CDataD.FlushCurrent:Boolean;
Var
     pD  : L3CURRENTDATA;
     nSH : int64;
     i   : Integer;
Begin
     nSH := 1;
     for i:=0 to Count-1 do
     Begin
      pD.m_swVMID        := m_snVMID;
      pD.m_swTID         := i;
      pD.m_swCMDID       := m_snCMDID;
      pD.m_sfValue       := GetValue(i);
      pD.m_sTime         := m_sTime;
      pD.m_byOutState    := LM_NRM;
      pD.m_byInState     := DT_FLS;
      pD.m_sbyMaskRead   := Byte((Mask and (nSH shl i))<>0);
      pD.m_sbyMaskReRead := Byte((Mask and (nSH shl i))<>0);
      pD.m_CRC           := 0;
      if m_sblSaved=SV_CURR_ST then SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_SET_CUR,SVS_CUR,sizeof(L3CURRENTDATA),@pD) else
      if m_sblSaved=SV_ARCH_ST then
      Begin
       SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_SET_CUR,SVS_CUR,sizeof(L3CURRENTDATA),@pD);
       SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_SET_ARC,SVS_CUR,sizeof(L3CURRENTDATA),@pD);
      End;
     End;
End;
//CDataD1
constructor CDataD1.Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
Begin
     inherited  Create(pFDB,nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,1,nExpress);
End;
//CDataD3
constructor CDataD3.Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
Begin
     inherited  Create(pFDB,nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,3,nExpress);
End;
//CDataD4
constructor CDataD4.Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
Begin
     inherited  Create(pFDB,nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,4,nExpress);
End;
//CDataD5
constructor CDataD5.Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
Begin
     inherited  Create(pFDB,nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,5,nExpress);
End;
{
function CDataD5.GetIndex(var pMsg:CMessage):Integer;
Begin
     Result:= m_nCount;
     if Result>=Count then Result := 0;
End;
function CDataD5.FlushUpdate:Boolean;
Var
     pD  : L3CURRENTDATA;
     nSH : int64;
     i   : Integer;
Begin
     nSH := 1;
     for i:=0 to Count-1 do
     Begin
      pD.m_swVMID        := m_snVMID;
      pD.m_swTID         := i;
      pD.m_swCMDID       := m_snCMDID;
      pD.m_sfValue       := GetValue(i);
      pD.m_sTime         := m_sTime;
      pD.m_byOutState    := LM_NRM;
      pD.m_byInState     := DT_FLS;
      pD.m_sbyMaskRead   := Byte((Mask and (nSH shl i))<>0);
      pD.m_sbyMaskReRead := Byte((Mask and (nSH shl i))<>0);
      pD.m_CRC           := 0;
      //EventBox.FixEvents(ET_RELEASE,'���.���. ������:'+IntToStr(pD.m_swVMID)+' �����: '+DateTimeToStr(pD.m_sTime)+' ��������:'+GetCMD(pD.m_swCMDID));
      if m_sblSaved=SV_ARCH_ST then
      Begin
       SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_SET_CUR,SVS_CUR,sizeof(L3CURRENTDATA),@pD);
       SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_SET_ARC,SVS_CUR,sizeof(L3CURRENTDATA),@pD);
      End;
     End;
End;
function CDataD5.FlushCurrent:Boolean;
Var
     pD  : L3CURRENTDATA;
     nSH : int64;
     i   : Integer;
Begin
     nSH := 1;
     for i:=0 to Count-1 do
     Begin
      pD.m_swVMID        := m_snVMID;
      pD.m_swTID         := i;
      pD.m_swCMDID       := m_snCMDID;
      pD.m_sfValue       := GetValue(i);
      pD.m_sTime         := m_sTime;
      pD.m_byOutState    := LM_NRM;
      pD.m_byInState     := DT_FLS;
      pD.m_sbyMaskRead   := Byte((Mask and (nSH shl i))<>0);
      pD.m_sbyMaskReRead := Byte((Mask and (nSH shl i))<>0);
      pD.m_CRC           := 0;
      if m_sblSaved=SV_CURR_ST then SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_SET_CUR,SVS_CUR,sizeof(L3CURRENTDATA),@pD) else
      if m_sblSaved=SV_ARCH_ST then
      Begin
       SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_SET_CUR,SVS_CUR,sizeof(L3CURRENTDATA),@pD);
       SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_SET_ARC,SVS_CUR,sizeof(L3CURRENTDATA),@pD);
      End;
     End;
End;
}
//CDataD48
constructor CDataD48.Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
Begin
     inherited  Create(pFDB,nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,48,nExpress);
End;
function CDataD48.GetIndex(var pMsg:CMessage):Integer;
Begin
     if IsUpdate=True  then Result:= (pMsg.m_sbyServerID and $3f) else
     if IsUpdate=False then Result:= GetCurrentIndex;
     if Result>=Count  then Result := 0;
End;
procedure CDataD48.SetMaskEx(nCount:Integer;var pMsg:CMessage);
Begin
     //nCount := GetIndex(pMsg);
     if (pMsg.m_sbyServerID and $80)=0  then SetMask(nCount) else
     if (pMsg.m_sbyServerID and $80)<>0 then ReSetMask(nCount);
End;
procedure CDataD48.SetMask(nCount:Integer);
Var
     nShift : int64;
Begin
     nShift := 1;
     if trunc(m_sTime)=trunc(Now) then
     Begin
      if nCount<=GetCurrentIndex then
      Mask := Mask or(nShift shl nCount) else
      Mask := Mask and not (nShift shl nCount);
     End else
     Mask := Mask or(nShift shl nCount);
End;
function CDataD48.GetCurrentIndex:Integer;
Var
     nIndex:Integer;
Begin
     nIndex := trunc(frac(Now)/EncodeTime(0,30,0,0));
     if nIndex>0 then Dec(nIndex);
     Result := nIndex;
End;
function CDataD48.TimeToIndex(dtTime:TDateTime):Integer;
Var
     nIndex:Integer;
Begin
     nIndex := trunc(frac(dtTime)/EncodeTime(0,30,0,0));
     if nIndex>0 then Dec(nIndex);
     Result := nIndex;
End;
function CDataD48.IsComplette(nIndex:Integer):Boolean;
Begin
     Result := False;
     if (IsUpdate=True)  and  (trunc(m_sTime)=trunc(Now))then
     Begin
      Result := ((nIndex and $3f)=0);
      //Result := (nIndex>=GetCurrentIndex);
      if Result=True then TraceL(4,0,'(__)CL3MD::>CDTTP: DATA RDY48 NOW.');
     End else
     if (IsUpdate=True)  then
     Begin
      Result := (m_nCount=(Count-1));
      if Result=True then TraceL(4,0,'(__)CL3MD::>CDTTP: DATA RDY48 UPD.');
     End else
     if (IsUpdate=False) then
     Begin
      Result := (nIndex=GetCurrentIndex);
      if Result=True then TraceL(4,0,'(__)CL3MD::>CDTTP: DATA RDY48 QWR.');
     End;
End;
function CDataD48.FlushCurrent:Boolean;
Var
     pD : L3CURRENTDATA;
Begin
     pD.m_swVMID        := m_snVMID;
     pD.m_swCMDID       := m_snCMDID;
     pD.m_swSID         := GetCurrentIndex;
     pD.m_sfValue       := GetValue(pD.m_swSID);
     pD.m_sTime         := m_sTime;
     pD.m_byOutState    := LM_NRM;
     pD.m_byInState     := DT_FLS;
     pD.m_sMaskRead     := Mask;
     pD.m_sMaskReRead   := Mask;
     pD.m_CRC           := 0;
     SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_UPD_D48,SVS_D48,sizeof(L3CURRENTDATA),@pD);
End;
function CDataD48.FlushUpdate:Boolean;
Var
     pD       : L3GRAPHDATA;
     nCount,i : Integer;
Begin
     for i:=0 to Count-1 do pD.v[i]:=0;
     nCount             := Count-1;
     if (trunc(m_sTime)=trunc(Now)) then
     nCount             := GetCurrentIndex;
     pD.m_swVMID        := m_snVMID;
     pD.m_swCMDID       := m_snCMDID;
     for i:=0 to nCount do
     pD.v[i]            := GetValue(i);
     pD.m_sdtLastTime   := m_sTime;
     pD.m_sdtDate       := m_sTime;
     pD.m_sMaskRead     := Mask;
     pD.m_sMaskReRead   := Mask;
     pD.m_swSumm        := 0;
     pD.m_CRC           := 0;
     SendMsgLData(BOX_SSRV,m_snVMID,DIR_CSTOSS,SVS_ADD_D48,SVS_D48,sizeof(L3GRAPHDATA),@pD);
End;
{
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
}
function CDataD48.LoadData(sTime:TDateTime;nIsUpdate:Boolean):Boolean;
Var
     pTable:L3GRAPHDATAS;
     i : Integer;
     res : Boolean;
Begin
     res := False;
     //if (m_nCount=0) then
     if (m_byInState=DT_FRE) then
     Begin
      m_sTime     := sTime;
      IsUpdate    := nIsUpdate;
      //m_byInState := DT_EXT;
      if m_pFDB.GetGraphDatas(m_sTime,m_sTime,m_snVMID,m_snCMDID,pTable)=True then
      Begin
       EventBox.FixEvents(ET_CRITICAL,'�������� ����������� ��� ������� ������. ������:'+IntToStr(m_snVMID)+' �����: '+DateTimeToStr(m_sTime)+' ��������:'+GetCMD(m_snCMDID){+' : '+FloatToStr(dValue)});
       res  := True;
       Mask := pTable.Items[0].m_sMaskRead;
       for i:=0 to Count-1 do lValue[i] := pTable.Items[0].v[i];
      End else
      Begin
       for i:=0 to Count-1 do lValue[i] := 0;
       Mask := 0;
       EventBox.FixEvents(ET_CRITICAL,'��� ����������� ��� ������� ������! ������:'+IntToStr(m_snVMID)+' �����: '+DateTimeToStr(m_sTime)+' ��������:'+GetCMD(m_snCMDID){+' : '+FloatToStr(dValue)});
      End;
     End;
     Result := res;
End;
//CDataDateTime
constructor CDataDateTime.Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
Begin
     inherited  Create(pFDB,nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,1,nExpress);
End;
function CDataDateTime.Extract(var pMsg:CMessage):Boolean;
Var
     dValue : Double;
Begin
     Move(pMsg.m_sbyInfo[9],dValue,sizeof(Double));
     lValue[0] := dValue;
     Result := True;
     //Reset;
End;
//CDataEvent
constructor CDataEvent.Create(pFDB:PCDBDynamicConn;nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType:Integer;nExpress:String);
Begin
     inherited  Create(pFDB,nAID,nGID,nVMID,nMID,nCMDID,nCLSID,nSVP,byLevel,blSaved,byType,0,nExpress);
End;
{
procedure CVMeter.SaveJrnlEvents(var pMsg:CMessage);
begin
   if pMsg.m_sbyServerID <> DEV_BTI_SRV then
   begin
     case pMsg.m_sbyInfo[1] of
       QRY_JRNL_T1,       // : ReadPhaseJrnl(pMsg);
       QRY_JRNL_T2,       // : ReadStateJrnl(pMsg);
       QRY_JRNL_T3        : SaveEventsDB(pMsg);//ReadKorrJrnl(pMsg);
       QRY_SUM_KORR_MONTH : SaveKorrMonth(pMsg);
       QRY_LIM_TIME_KORR  : SaveLimKorr(pMsg);
     end;
   end
   else
   begin
      case pMsg.m_sbyInfo[1] of
       QRY_JRNL_T1,
       QRY_JRNL_T4 : ReadJrnl1_BTI(pMsg);
       QRY_JRNL_T2 : ReadJrnl2_BTI(pMsg);
       QRY_JRNL_T3 : ReadJrnl3_BTI(pMsg);
     end;
   end;
end;
}

function CDataEvent.Extract(var pMsg:CMessage):Boolean;
Begin
End;

end.
