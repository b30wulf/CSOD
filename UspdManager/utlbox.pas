unit utlbox;
{$define DEBUG_SPEED}
//{$define DEB_METROL}
interface
uses
  Windows, Classes, SysUtils,SyncObjs,stdctrls,Controls, Forms, Dialogs,comctrls,
  utltypes,Grids, utlconst;
type
    //Format::>Word,array[xxx] of byte;
    TCreateNode = procedure(Sender : TObject) of object;
    TVBase = packed record
     State        : Word;
     Messages     : Integer;
     wAmTI        : Word;
     wAmTS        : Word;
     blDirtyBit   : Boolean;
     nObject      : array of Integer;
     wState       : array of Word;
     tmChangeTime : array of TDateTime;
     tmDChangeTime : TDateTime;
    End;
    PVBase = ^TVBase;
    TVCommand = packed record
     blState     : Boolean;
     blValue     : Boolean;
     nValue      : Integer;
     tmDCommTime : TDateTime;
    End;
    CTBox = record
     pb_mBoxCont : array of Byte;
     w_mEvent    : THandle;
     sCS : TCriticalSection;
     w_mBoxWrite : DWord;
     w_mBoxRead  : DWord;
     w_mBoxSize  : DWord;
     w_mBoxCSize : DWord;
     w_mBoxMesCt : DWord;
     m_byIsEvent : Boolean;
     w_blSynchro : Boolean;
    End;
    procedure SetTexSB(byIndex:Byte;str:String);
    procedure Moves(pS,pD:Pointer;nLen:Integer);
    procedure FDEFINE(nIndex:Integer;w_lBoxSize:DWord;blSynch:Boolean);
    procedure FFDEFINE(nIndex:Integer;w_lBoxSize:DWord;w_lunBoxSize:DWord;blSynch:Boolean);
    function  FPUT(nIndex:Integer;pb_lInBox:Pointer):Integer;
    function  FPUT1(nIndex:Integer;pb_lInBox:Pointer):Integer;
    function  FGET(nIndex:Integer;pb_lInBox:Pointer):Integer;
    function  FPEEK(nIndex:Integer;pb_lInBox:Pointer):Integer;
    function  FCHECK(nIndex:Integer):Integer;
    procedure FDELETE(nIndex:Integer);
    procedure FFREE(nIndex:Integer);
    procedure FCLRSYN(nIndex:Integer);
    procedure FSETSYN(nIndex:Integer);
    procedure FSTOP(nIndex:Integer);
    procedure FSTART(nIndex:Integer);
    procedure FSET(nIndex:Integer);
    procedure FREM(nIndex:Integer);
    procedure FRES(nIndex:Integer);
    procedure FWAIT(nIndex:Integer);
    procedure FINIT;
    //Define OpcBase

    procedure FDEFINE_VA(nDirID,nTI,nTS:Word);
    procedure FDELETE_VA(nDirID:Word);
    procedure FPUTTI_VA(nDirID,nTI:Word;ChangeTime:TDateTime;OPCState:Word;nValue:Integer);
    procedure FPUTTS_VA(nDirID,nTS:Word;ChangeTime:TDateTime;OPCState:Word;nValue:Integer);
    function  FGETTI_VA(nDirID,nTI:Word;var ChangeTime:TDateTime;var OPCState:Word):Integer;
    function  FGETTS_VA(nDirID,nTS:Word;var ChangeTime:TDateTime;var OPCState:Word):Integer;
    procedure FSETSTATE_VA(nDirID:Word;ChangeTime:TDateTime;OPCState:Byte);
    procedure FSETMSG_VA(nDirID:Word;ChangeTime:TDateTime;nMessages:Integer);
    function  FGETSTATE_VA(nDirID:Word):Word;
    function  FGETMSG_VA(nDirID:Word):Integer;
    procedure SendMsg(byBox,byIndex,byFor,byType:Byte);
    procedure SendMsgData(byBox,byIndex,byFor,byType:Byte;var pDS:CMessageData);
    procedure SendMsgIData(byBox,byIndex,byInt,byFor,byType:Byte;var pDS:CMessageData);
    procedure SendData(byBox,byIndex,byFor,byType,nLen:Byte;pDS:Pointer);
    procedure SendPData(byBox,byIndex,byPIndex,byFor,byType,nLen:Byte;pDS:Pointer);
    procedure SendPMSG(byBox,byIndex,byFor,byType:Byte);
    procedure SendRemMsg(byBox,byIndex,byFor,byType:Byte;var plMsg:CMessage);
    procedure SendRemSHMsg(byBox,byIndex,byFor,byType:Byte;var plMsg:CHMessage);
    procedure SendRMsg(var plMsg:CMessage);
    procedure SendRSMsg(plMsg:CHMessage);
    function  FracEx(par : single; nIV : integer) : string;
    function  TVLS(fVal:Single;nT:integer):String;
    function  DVLSEx(fVal:Double; Koef:Double):String;
    function  DVLS(fVal:Double):String;
    function  DVLS1(fVal:Double):String;
    function  RVL(fVal:Double):Double;
    procedure OnDisconnectAction;

    function CreateMSG(byBox,byIndex,byFor,byType:Byte):CHMessage;
    function CreateMSGD(byBox,byIndex,byFor,byType:Byte;var pDS:CMessageData):CHMessage;
    function FindClient(str:String):PSL4CONNTAG;
    function CalcCRCDB(pArray : PBYTEARRAY; len : integer):WORD;



Var
    m_nOutState     : TStringList;
    m_nInState      : TStringList;
    m_nTypeProt     : TStringList;
    m_nDataGroup    : TStringList;
    m_nNetMode      : TStringList;
    m_nSaveList     : TStringList;
    m_nActiveList   : TStringList;
    m_nMeterLocation: TStringList;
    m_nStatusList   : TStringList;
    m_nCmdDirect    : TStringList;
    m_nCommandList  : TStringList;
    m_nParamList    : TStringList;
    m_nPTariffList  : TStringList;
    m_nMeterList    : TStringList;

    m_nSpeedList    : TStringList; 
    m_nPortTypeList : TStringList;
    m_nParityList   : TStringList;
    m_nDataList     : TStringList;
    m_nStopList     : TStringList;
    m_nSvPeriodList : TStringList;
    m_nEsNoList     : TStringList;
    m_nJrnlN1       : TStringList;
    m_nJrnlN2       : TStringList;
    m_nJrnlN3       : TStringList;
    m_nUserLayer    : TStringList;

    FTreeEditor     : PTTreeView;
    //m_pDS           : CGDataSource;
    m_nParams       : QM_PARAMS;
    pHiBuff         : array[0..MAX_METER+50]  of CTBox;
    m_blPortIndex   : array[0..50]  of Boolean;
    m_blMeterIndex  : array[0..200] of Boolean;
    m_blMTypeIndex  : array[0..50]  of Boolean;
    m_blPTypeIndex  : array[0..200] of Boolean;
    m_blTarTypeIndex : array[0..50] of Boolean;
    m_blConnTypeIndex : array[0..50] of Boolean;


    m_blGroupIndex  : array[0..50]  of Boolean;
    m_blVMeterIndex : array[0..200] of Boolean;
    m_blUserIndex   : array[0..100] of Boolean;
    //m_pB          : PTOpcBase;
    m_pVirtualBase  : array[0..1] of PVBase;
    strSB           : array[0..10] of String;
    m_strL2SelNode  : String;
    m_strL3SelNode  : String;
    m_strCurrUser   : String;
    m_csOut         : TCriticalSection;
    FStatBar        : TStatusBar;
    w_mGEvent       : THandle;
    w_mTcpEvent     : THandle;
    m_nMasterPort0  : Integer;
    m_nCurrentConnection : Integer;
    m_blIsLocal     : Boolean;
    m_blIsSlave     : Boolean;
    m_blIsConnect   : Boolean;
    m_blIsEEnergo   : Boolean;
    m_dwIN          : DWord;
    m_dwOut         : DWord;
    m_nValue        : integer;
    m_nPrecise      : integer; //точность после запятой показания
    m_nPreciseExpense : integer; //точность после запятой расход
    m_nOnAutorization : integer;
    m_blConnectST   : Boolean;
    m_sCurrentUser  : String;
    m_blNoCheckPass : Boolean;
    m_blMinimized   : Boolean;
    m_sL4ConTag     : SL4CONNTAGS;
    m_nEV           : array[0..2] of SEVENTSETTTAGS;
    gsCS            : TCriticalSection;
    m_blGridDataFontColor : Integer;
    m_blGridDataFontSize  : Integer;
    m_blGridDataFontName  : String;
    nSizeFont:integer;
    ReportFormCrete:boolean;
    m_blIsBackUp    : Boolean;
    //m_blGridDataClick     : boolean;
    m_sEnrgoTelCom  : SENRGOTELCOM;
    m_strCurrentDir        : String;
    m_strProgrammPlacement : String;
    m_strPrepare           : String;
    m_strProgName          : String;
    m_strBaseName          : String;
    m_strSettName          : String;
    m_strExeDir            : String;

implementation

procedure FINIT;
Begin
    gsCS:=TCriticalSection.Create;
    w_mGEvent    := CreateEvent(nil, False, False, nil);
End;

function FindClient(str:String):PSL4CONNTAG;
Var
    i : Integer;
Begin
    for i:=0 to m_sL4ConTag.Count-1 do
    Begin
     if m_sL4ConTag.Items[i].m_schPhone=str then
     Begin
      Result := @m_sL4ConTag.Items[i];
      Exit;
     End;
    End;
    Result := Nil;
End;
function FracEx(par : single; nIV : integer) : string;
begin
   Result := IntToStr(abs(round(Frac(par)*nIV)));
   while Length(Result) < m_nPrecise do
     Result := Result + '0';
end;

function DVLSEx(fVal:Double; Koef:Double):String;
begin
   if Koef = 1 then
     Result := DVLS1(fVal)
   else
     Result := DVLS(fVal);
end;

function DVLS(fVal:Double):String;
Var
    nIV     : Integer;
Begin
    case m_nPrecise of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;
    if fVal=0 then Result := '0' else
    Begin
     if m_nPrecise<>0 then
     Result := FloatToStr(trunc(fVal)+round(Frac(fVal)*nIV)/nIV) else
     Result := IntToStr(trunc(fVal));
    End;
End;
function RVL(fVal:Double):Double;
Var
    nIV     : Integer;
Begin
    case m_nPrecise of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;
    {$IFNDEF DEB_METROL}
    if m_nPrecise<>0 then
    Result := trunc(fVal)+round(Frac(fVal)*nIV)/nIV else
    Result := trunc(fVal);
    {$ELSE}
    Result := fVal;
    {$ENDIF}
End;
function  DVLS1(fVal:Double):String;
Var
    nIV     : Integer;
Begin
    {
    case m_nPrecise of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;
    }
    nIV := 10;
    //if m_nPrecise<>0 then Result := IntToStr(trunc(fVal))+'.'+{IntToStr(trunc(Frac(fVal)*nIV))}FracEx(abs(fVal), nIV) else
    //              Result := IntToStr(trunc(fVal));
   //if m_nPrecise<>0 then Result := IntToStr(trunc(fVal))+'.'+IntToStr(round(Frac(fVal)*nIV)) else
   //              Result := IntToStr(trunc(fVal));

     Result := FloatToStr(trunc(fVal)+round(Frac(fVal)*nIV)/nIV);
     //Result := IntToStr(trunc(fVal));
End;

function TVLS(fVal:Single;nT:integer):String;
Var
    nIV     : Integer;
Begin
    case nT of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;
    if nT<>0 then Result := IntToStr(trunc(fVal))+'.'+IntToStr(abs(trunc(Frac(fVal)*nIV))) else
                  Result := IntToStr(trunc(fVal));
End;
procedure FDEFINE(nIndex:Integer;w_lBoxSize:DWord;blSynch:Boolean);
Begin
    with pHiBuff[nIndex] do
    begin
    if sCS=Nil then
    Begin
     sCS:=TCriticalSection.Create;
     SetLength(pb_mBoxCont,w_lBoxSize+3000);
     w_mEvent    := CreateEvent(nil, False, False, nil);
     w_mBoxSize  := w_lBoxSize;
     w_mBoxCSize := w_lBoxSize;
     w_mBoxWrite := 0;
     w_mBoxRead  := 0;
     w_mBoxMesCt := 0;
     w_blSynchro := blSynch;
     m_byIsEvent := False;
     ResetEvent(w_mEvent);
    end;
    end;
End;
procedure FFDEFINE(nIndex:Integer;w_lBoxSize:DWord;w_lunBoxSize:DWord;blSynch:Boolean);
Begin
    with pHiBuff[nIndex] do
    begin
    if sCS=Nil then
    Begin
     if w_lunBoxSize=0 then w_lunBoxSize:=3000;
     sCS:=TCriticalSection.Create;
     SetLength(pb_mBoxCont,w_lBoxSize+w_lunBoxSize);
     w_mEvent    := CreateEvent(nil, False, False, nil);
     w_mBoxSize  := w_lBoxSize;
     w_mBoxCSize := w_lBoxSize;
     w_mBoxWrite := 0;
     w_mBoxRead  := 0;
     w_mBoxMesCt := 0;
     w_blSynchro := blSynch;
     m_byIsEvent := False;
     ResetEvent(w_mEvent);
    end;
    end;
End;
procedure FFREE(nIndex:Integer);
Begin
    with pHiBuff[nIndex] do
    begin
    w_mBoxSize  := w_mBoxCSize;
    w_mBoxWrite := 0;
    w_mBoxRead  := 0;
    w_mBoxMesCt := 0;
    m_byIsEvent := False;
    ResetEvent(w_mEvent);
    End;
End;
{$ifndef DEBUG_SPEED}
function FPUT(nIndex:Integer;pb_lInBox:Pointer):Integer;
Var
    w_lLength:Word;
Begin
    //pHiBuff[nIndex].sCS.Enter;
    //pHiBuff[nIndex].w_mBoxSize := pHiBuff[nIndex].w_mBoxSize;
    //sCS.Enter;
    if pHiBuff[nIndex].sCS=Nil then exit;
    with pHiBuff[nIndex] do
    begin
    sCS.Enter;
    Move(pb_lInBox^,w_lLength,2);
    if (w_lLength>w_mBoxSize) or (w_lLength<2) then
    Begin
     result:=0;
     //SendDebug('Free Buffer.');
     //SetEvent(w_mEvent);
     FFREE(nIndex);
     sCS.Leave;
     Exit;
    End;
    Move(pb_lInBox^,pb_mBoxCont[w_mBoxWrite],w_lLength);
    w_mBoxWrite := w_mBoxWrite + w_lLength;
    w_mBoxSize  := w_mBoxSize  - w_lLength;
    w_mBoxMesCt := w_mBoxMesCt + 1;
    if(w_mBoxWrite>w_mBoxCSize) then w_mBoxWrite := 0;
    //if w_blSynchro then WaitForSingleObject(w_mGEvent,1);
    sCS.Leave;
    if w_blSynchro then
     if w_mBoxMesCt=1 then
     Begin
      SetEvent(w_mEvent);
     End;
    result := 1;
    End;
    //if pHiBuff[nIndex].w_blSynchro then Sleep(1);
    if pHiBuff[nIndex].w_blSynchro then WaitForSingleObject(w_mGEvent,1);
End;
function FGET(nIndex:Integer;pb_lInBox:Pointer):Integer;
Var
    wLng:Word;
Begin
    with pHiBuff[nIndex] do
    begin
    if w_blSynchro then WaitForSingleObject(w_mEvent,INFINITE);
    if(w_mBoxMesCt=0) then Begin ResetEvent(w_mEvent);result:=0;exit;End;
    Move(pb_mBoxCont[w_mBoxRead],wLng,2);
    Move(pb_mBoxCont[w_mBoxRead],pb_lInBox^,wLng);
    w_mBoxRead  := w_mBoxRead + wLng;
    w_mBoxSize  := w_mBoxSize + wLng;
    w_mBoxMesCt := w_mBoxMesCt - 1;
    if(w_mBoxRead>w_mBoxCSize) then w_mBoxRead := 0;
    if(w_mBoxMesCt<>0) then SetEvent(w_mEvent);
    result := wLng;
    End;
End;
{$else}
function FPUT(nIndex:Integer;pb_lInBox:Pointer):Integer;
Var
    w_lLength:Word;
Begin
    if pHiBuff[nIndex].sCS=Nil then exit;
    with pHiBuff[nIndex] do
    begin
    gsCS.Enter;
     Move(pb_lInBox^,w_lLength,2);
     if (w_lLength>w_mBoxSize) or (w_lLength<2) then Begin gsCS.Leave;result:=0;FFREE(nIndex);Exit;End;
     Move(pb_lInBox^,pb_mBoxCont[w_mBoxWrite],w_lLength);
     w_mBoxWrite := w_mBoxWrite + w_lLength;
     w_mBoxSize  := w_mBoxSize  - w_lLength;
     w_mBoxMesCt := w_mBoxMesCt + 1;
     if(w_mBoxWrite>w_mBoxCSize) then w_mBoxWrite := 0;
     if w_blSynchro=True then SetEvent(w_mEvent);
    gsCS.Leave;
    result := 1;
    End;
End;
function FGET(nIndex:Integer;pb_lInBox:Pointer):Integer;
Var
    wLng:Word;
Begin
    with pHiBuff[nIndex] do
    begin
    if w_blSynchro then WaitForSingleObject(w_mEvent,INFINITE);
    gsCS.Enter;
     Move(pb_mBoxCont[w_mBoxRead],wLng,2);
     Move(pb_mBoxCont[w_mBoxRead],pb_lInBox^,wLng);
     w_mBoxRead  := w_mBoxRead + wLng;
     w_mBoxSize  := w_mBoxSize + wLng;
     w_mBoxMesCt := w_mBoxMesCt - 1;
     if(w_mBoxRead>w_mBoxCSize) then w_mBoxRead := 0;
     if w_mBoxMesCt=0 then ResetEvent(w_mEvent) else SetEvent(w_mEvent);
    gsCS.Leave;
    result := wLng;
    End;
End;
procedure FSET(nIndex:Integer);
Begin
   with pHiBuff[nIndex] do
   if(w_blSynchro=True) then
   Begin
   if (w_mBoxMesCt<>0)and(m_byIsEvent=False) Then
   Begin
    SetEvent(w_mEvent);
    //m_byIsEvent := True;
   End else
   if(w_mBoxMesCt=0) then FRES(nIndex);
   End;
End;
procedure FREM(nIndex:Integer);
Begin
   with pHiBuff[nIndex] do
   if(w_mBoxMesCt<>0) then m_byIsEvent := False else m_byIsEvent := True;
End;
procedure FRES(nIndex:Integer);
Begin
   with pHiBuff[nIndex] do
   Begin
    m_byIsEvent := True;;
    ReSetEvent(w_mEvent);
   End;
End;
procedure FWAIT(nIndex:Integer);
Begin
   with pHiBuff[nIndex] do
   if w_blSynchro then WaitForSingleObject(w_mEvent,INFINITE);
End;
{$endif}
procedure Moves(pS,pD:Pointer;nLen:Integer);
Var
    pSB,pDB : PByteArray;
    i : Integer;
Begin
    pSB := pS;
    pDB := pD;
    for i:=0 to nLen-1 do pDB[i]:=pSB[i];
End;
function FPUT1(nIndex:Integer;pb_lInBox:Pointer):Integer;
Var
    w_lLength:Word;
Begin
    //pHiBuff[nIndex].sCS.Enter;
    //pHiBuff[nIndex].w_mBoxSize := pHiBuff[nIndex].w_mBoxSize;
    //sCS.Enter;
    if pHiBuff[nIndex].sCS=Nil then exit;
    with pHiBuff[nIndex] do
    begin
    sCS.Enter;
    Move(pb_lInBox^,w_lLength,2);
    if (w_lLength>w_mBoxSize) or (w_lLength<2) then
    Begin
     result:=0;
     //SendDebug('Free Buffer.');
     //SetEvent(w_mEvent);
     FFREE(nIndex);
     sCS.Leave;
     Exit;
    End;
    Move(pb_lInBox^,pb_mBoxCont[w_mBoxWrite],w_lLength);
    w_mBoxWrite := w_mBoxWrite + w_lLength;
    w_mBoxSize  := w_mBoxSize  - w_lLength;
    w_mBoxMesCt := w_mBoxMesCt + 1;
    if(w_mBoxWrite>w_mBoxCSize) then w_mBoxWrite := 0;
    //if w_blSynchro then WaitForSingleObject(w_mGEvent,1);
    sCS.Leave;
    if w_blSynchro then
     if w_mBoxMesCt=1 then
     Begin
      SetEvent(w_mEvent);
     End;
    result := 1;
    End;
    if pHiBuff[nIndex].w_blSynchro then WaitForSingleObject(w_mGEvent,1);
End;
function FPEEK(nIndex:Integer;pb_lInBox:Pointer):Integer;
Var
    w_lLength:Word;
Begin
    with pHiBuff[nIndex] do
    begin
    sCS.Enter;
    Move(pb_lInBox^,w_lLength,2);
    if(w_mBoxRead-w_lLength)<=0 then Begin FPUT(nIndex,pb_lInBox);sCS.Leave;result := 0;exit;End;
    w_mBoxRead  := w_mBoxRead - w_lLength;
    w_mBoxSize  := w_mBoxSize - w_lLength;
    w_mBoxMesCt := w_mBoxMesCt + 1;
    Move(pb_lInBox^,pb_mBoxCont[w_mBoxRead],w_lLength);
    SetEvent(w_mEvent);
    sCS.Leave;
    result := 1;
    End;
End;
procedure FCLRSYN(nIndex:Integer);
Begin
    pHiBuff[nIndex].w_blSynchro := False;
End;
procedure FSETSYN(nIndex:Integer);
Begin
    pHiBuff[nIndex].w_blSynchro := True;
    FSTART(nIndex);
End;
procedure FSTOP(nIndex:Integer);
Begin
    ReSetEvent(pHiBuff[nIndex].w_mEvent);
End;
procedure FSTART(nIndex:Integer);
Begin
    if(pHiBuff[nIndex].w_mBoxMesCt<>0) then
    SetEvent(pHiBuff[nIndex].w_mEvent);
End;
function FCHECK(nIndex:Integer):Integer;
Begin
    result := pHiBuff[nIndex].w_mBoxMesCt;
End;
procedure FDELETE(nIndex:Integer);
Begin
    with pHiBuff[nIndex] do
    begin
    sCS.Free;
    End;
End;

//VBase For Opc Interface
procedure FDEFINE_VA(nDirID,nTI,nTS:Word);
Var
    i : Integer;
Begin
    if(Assigned(m_pVirtualBase[nDirID])=False) then
    Begin
    New(m_pVirtualBase[nDirID]);
    with m_pVirtualBase[nDirID]^ do
    Begin
     wAmTI        := nTI;
     wAmTS        := nTS;
     blDirtyBit   := False;
     tmDChangeTime := Now;
     SetLength(tmChangeTime ,wAmTI+wAmTS);
     SetLength(wState ,wAmTI+wAmTS);
     SetLength(nObject,wAmTI+wAmTS);
     for i:=0 to (wAmTI+wAmTS-1) do
     Begin
       tmChangeTime[i] := Now;
       wState[i]       := $C0;
       nObject[i]      := 0;
     end;
    End;
    End;
End;
procedure FDELETE_VA(nDirID:Word);
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     SetLength(m_pVirtualBase[nDirID]^.wState ,0);
     SetLength(m_pVirtualBase[nDirID]^.nObject,0);
     Dispose(m_pVirtualBase[nDirID]);
    End;
End;
procedure FPUTTI_VA(nDirID,nTI:Word;ChangeTime:TDateTime;OPCState:Word;nValue:Integer);
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     with m_pVirtualBase[nDirID]^ do
     Begin
      if (nTI<=(wAmTI+wAmTS)) then
      Begin
       nObject[nTI]      := nValue;
       wState[nTI]       := OPCState;
       blDirtyBit        := True;
       tmChangeTime[nTI] := ChangeTime;
       State             := OPCState;
      End;
     End;
    End;
End;
procedure FPUTTS_VA(nDirID,nTS:Word;ChangeTime:TDateTime;OPCState:Word;nValue:Integer);
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     with m_pVirtualBase[nDirID]^ do
     Begin
      if (nTS<=wAmTS) then
      Begin
       nObject[wAmTI+nTS]      := nValue;
       wState[wAmTI+nTS]       := OPCState;
       blDirtyBit              := True;
       tmChangeTime[wAmTI+nTS] := ChangeTime;
       State                   := OPCState;
      End;
     End;
    End;
End;
function FGETTI_VA(nDirID,nTI:Word;var ChangeTime:TDateTime;var OPCState:Word):Integer;
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     with m_pVirtualBase[nDirID]^ do
     Begin
      if (nTI<=(wAmTI+wAmTS)) then
      Begin
       blDirtyBit := True;
       ChangeTime := tmChangeTime[nTI];
       OPCState   := wState[nTI];
       Result     := nObject[nTI];
       exit;
      End;
     End;
    End;
    Result := -1;
End;
function FGETTS_VA(nDirID,nTS:Word;var ChangeTime:TDateTime;var OPCState:Word):Integer;
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     with m_pVirtualBase[nDirID]^ do
     Begin
      if (nTS<=wAmTS) then
      Begin
       blDirtyBit := True;
       ChangeTime := tmChangeTime[wAmTI+nTS];
       OPCState   := wState[wAmTI+nTS];
       Result     := nObject[wAmTI+nTS];
       exit;
      End;
     End;
    End;
    Result := -1;
End;
procedure FSETSTATE_VA(nDirID:Word;ChangeTime:TDateTime;OPCState:Byte);
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     m_pVirtualBase[nDirID]^.tmDChangeTime := ChangeTime;
     m_pVirtualBase[nDirID]^.State        := OPCState;
    End;
End;
procedure FSETMSG_VA(nDirID:Word;ChangeTime:TDateTime;nMessages:Integer);
Begin
    if(Assigned(m_pVirtualBase[nDirID])) then
    Begin
     m_pVirtualBase[nDirID]^.tmDChangeTime := ChangeTime;
     m_pVirtualBase[nDirID]^.Messages      := nMessages;
    End;
End;
function FGETSTATE_VA(nDirID:Word):Word;
Begin
    Result := 0;
    if(Assigned(m_pVirtualBase[nDirID])) then
    Result := m_pVirtualBase[nDirID]^.State;
End;
function FGETMSG_VA(nDirID:Word):Integer;
Begin
    Result := 0;
    if(Assigned(m_pVirtualBase[nDirID])) then
    Result := m_pVirtualBase[nDirID]^.Messages;
End;
procedure SendRMsg(var plMsg:CMessage);
Var
    pMsg : CMessage;
Begin
    With pMsg do
    Begin
     m_swLen       := 11+plMsg.m_swLen;
     m_swObjID     := 0;
     m_sbyFrom     := DIR_LMETOL1;
     m_sbyFor      := DIR_LMETOL1;
     m_sbyType     := PH_DATARD_REQ;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := m_nMasterPort0;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
    end;
    Move(plMsg,pMsg.m_sbyInfo[0],plMsg.m_swLen);
    FPUT(BOX_L1,@pMsg);
End;
procedure SendRSMsg(plMsg:CHMessage);
Var
    pMsg : CMessage;
Begin
    With pMsg do
    Begin
     m_swLen       := 11+plMsg.m_swLen;
     m_swObjID     := 0;
     m_sbyFrom     := DIR_LMETOL1;
     m_sbyFor      := DIR_LMETOL1;
     m_sbyType     := PH_DATARD_REQ;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := m_nMasterPort0;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
    end;
    Move(plMsg,pMsg.m_sbyInfo[0],plMsg.m_swLen);
    FPUT(BOX_L1,@pMsg);
End;
procedure SendRemMsg(byBox,byIndex,byFor,byType:Byte;var plMsg:CMessage);
Var
    pMsg : CMessage;
Begin
    With pMsg do
    Begin
     m_swLen       := 11+plMsg.m_swLen;
     m_swObjID     := 0;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := byIndex;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
    end;
    Move(plMsg,pMsg.m_sbyInfo[0],plMsg.m_swLen);
    FPUT(byBox,@pMsg);
End;
procedure SendRemSHMsg(byBox,byIndex,byFor,byType:Byte;var plMsg:CHMessage);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
     m_swLen       := 11+plMsg.m_swLen;
     m_swObjID     := 0;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := byIndex;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
    end;
    Move(plMsg,pMsg.m_sbyInfo[0],plMsg.m_swLen);
    FPUT(byBox,@pMsg);
End;
procedure SendMSG(byBox,byIndex,byFor,byType:Byte);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 11;
    m_swObjID     := byIndex;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := 0;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    end;
    FPUT(byBox,@pMsg);
End;
function CreateMSG(byBox,byIndex,byFor,byType:Byte):CHMessage;
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 11;
    m_swObjID     := byIndex;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := 0;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    end;
    //FPUT(byBox,@pMsg);
    Result := pMsg;
End;
function CreateMSGD(byBox,byIndex,byFor,byType:Byte;var pDS:CMessageData):CHMessage;
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 11;
    m_swObjID     := byIndex;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := 0;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    Move(pDS,m_sbyInfo[0],sizeof(pDS));
    m_swLen       := 11 + sizeof(pDS);
    end;
    Result := pMsg;
End;
procedure SendPMSG(byBox,byIndex,byFor,byType:Byte);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 11;
    m_swObjID     := 0;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := byIndex;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    end;
    FPUT(byBox,@pMsg);
End;
procedure SendMsgData(byBox,byIndex,byFor,byType:Byte;var pDS:CMessageData);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
     m_swObjID     := byIndex;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := 0;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     Move(pDS,m_sbyInfo[0],sizeof(pDS));
     m_swLen       := 11 + sizeof(pDS);
    end;
    FPUT(byBox,@pMsg);
End;
procedure SendMsgIData(byBox,byIndex,byInt,byFor,byType:Byte;var pDS:CMessageData);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
     m_swObjID     := byIndex;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := byInt;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     Move(pDS,m_sbyInfo[0],sizeof(pDS));
     m_swLen       := 11 + sizeof(pDS);
    end;
    FPUT(byBox,@pMsg);
End;
procedure SendData(byBox,byIndex,byFor,byType,nLen:Byte;pDS:Pointer);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
     m_swObjID     := byIndex;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := 0;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     Move(pDS^,m_sbyInfo[0],nLen);
     m_swLen       := 11 + nLen;
    end;
    FPUT(byBox,@pMsg);
End;
procedure SendPData(byBox,byIndex,byPIndex,byFor,byType,nLen:Byte;pDS:Pointer);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
     m_swObjID     := byIndex;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := byPIndex;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     Move(pDS^,m_sbyInfo[0],nLen);
     m_swLen       := 11 + nLen;
    end;
    FPUT(byBox,@pMsg);
End;
procedure OnDisconnectAction;
Var
    pDS : CMessageData;
Begin
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
End;
procedure SetTexSB(byIndex:Byte;str:String);
Begin
    strSB[byIndex] := str;
    FStatBar.Invalidate;
End;
function CalcCRCDB(pArray : PBYTEARRAY; len : integer):WORD;
var
    CRChiEl             : byte;
    CRCloEl             : byte;
    i                   : integer;
    cmp                 : byte;
    idx                 : byte;
begin
    CRChiEl := $FF;
    CRCloEl := $FF;
    for i:=0 to len - 1 do
    begin
     idx       := (CRChiEl Xor pArray[i]) And $FF;
     CRChiEl   := (CRCloEl Xor CRCHI[idx]);
     CRCloEl   := CRCLO[idx];
    end;
    Result := (CRChiEl shl 8) + CRCloEl;
end;

end.
