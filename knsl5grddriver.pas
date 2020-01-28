unit knsl5grddriver;
interface
uses
grddelphi{,knsl3EventBox};
type
    TKeyEvent = procedure(nEvent:Integer) of object;
    SFINDSETT = packed record
     dwRemoteMode : Dword;
     dwFlags      : Dword;
     byProg       : Byte;
     dwID         : Dword;
     wSN          : Word;
     byVer        : Byte;
     wMask        : Word;
     wType        : Word;
     dwModel      : Dword;
     dwInterface  : Dword;
    End;
    SKEYSETT = packed record
     dwPublic : Dword;
     dwPrivRD : Dword;
     dwPrivWR : Dword;
     dwPrivMS : Dword;
    End;
    SGRDINFO = packed record
     Count : Integer;
     Items : array[0..10] of TGrdFindInfo;
    End;
    SGSII64VECT = array[0..7] of Byte;
    CStealth2Driver = class
    protected
     m_byOutTrace  : Boolean;
     m_nFIND       : SFINDSETT;
     m_nHKEYS      : SKEYSETT;
     m_nGINF       : SGRDINFO;
     m_hGrd        : Handle;
     m_nCount      : Integer;
     FOnKeyErr     : TKeyEvent;
     m_strVectorIV : SGSII64VECT;
     procedure Writeln(str:String);
     procedure WritelnER(str:String);
     function  PrintResult(nErrorCode:integer):integer;
     function  ErrorHandling(hGrd:HANDLE;nRet:integer):Boolean;
     procedure ErrorMessage(nErrCode:Integer);
     function  WriteKey(nAddr:Integer;pBuffer:Pointer;wLen:Integer):Boolean;
     function  ReadKey(nAddr:Integer;pBuffer:Pointer;wLen:Integer):Boolean;
     function SetFindDevices:Boolean;
     function FindDevice:Boolean;
    public
     constructor Create(strVector:SGSII64VECT;nFIND:SFINDSETT);
     destructor Destroy;override;
     function Encode(pBuffer:Pointer;wLen:Integer):Boolean;
     function Decode(pBuffer:Pointer;wLen:Integer):Boolean;
     function Write(pBuffer:Pointer;wLen:Integer):Boolean;
     function Read(pBuffer:Pointer;wLen:Integer):Boolean;
     function Init:Boolean;
     function Find:Boolean;
     function Close:Boolean;
    public
     property OnKeyErr : TKeyEvent read FOnKeyErr write FOnKeyErr;
    End;
implementation
const
//Пароли (Запароленные)
    GrdDC_NVK = $53E223EB;//$41e04ea9;
    GrdDC_RDO = $66A72164;//$404f113f;
    GrdDC_WRF = $A2D95D09;//$85b40e86;
    GrdDC_MST = $4363E750;//$1ffe151c;
//Декрипт к паролям
    CryptPU   = $1201D542;
    CryptRD   = $26581025;
    CryptWR   = $1D254E83;
    CryptMS   = $2365D234;
//Дескриптор алгоритма
    GRD_ALG   = 4;
//Адрес и размер пользовательских данных для ключа "Guardant Stealth II"
    GRD_ARRD  = 126;
    GRD_SIZE  = 90;
//Ошибки
    ERR_NO_FIND = 0;
    ERR_NO_INIT = 1;
constructor CStealth2Driver.Create(strVector:SGSII64VECT;nFIND:SFINDSETT);
Begin
    m_byOutTrace  := False;
    m_strVectorIV := strVector;
    m_nFIND       := nFIND;
    m_hGrd        := Nil;
End;
destructor CStealth2Driver.Destroy;
Begin
    FillChar(m_strVectorIV,0,sizeof(SGSII64VECT));
    FillChar(m_nFIND,0,sizeof(SFINDSETT));
    FillChar(m_nGINF,0,sizeof(SGRDINFO));
End;
function CStealth2Driver.Init:Boolean;
Var
    nRet   : Integer;
Begin
    Result := True;
    try
    if m_hGrd<>Nil then exit;
    m_nHKEYS.dwPublic:= GrdDC_NVK-CryptPU;
    m_nHKEYS.dwPrivRD:= GrdDC_RDO-CryptRD;
    m_nHKEYS.dwPrivWR:= GrdDC_WRF-CryptWR;
    m_nHKEYS.dwPrivMS:= GrdDC_MST-CryptMS;

    nRet:=GrdStartup(GrdFMR_Local);
    if ErrorHandling(nil,nRet)=False then Begin Close;Result:=False;exit; End;

    m_hGrd := 0;
    m_hGrd:= GrdCreateHandle(Nil,GrdCHM_MultiThread,nil);
    if(m_hGrd=nil)then Begin Close;Result:=False;exit; End;
    if ErrorHandling(m_hGrd,nRet)=False then Begin Close;Result:=False;exit; End;

    with m_nHKEYS do
    nRet:= GrdSetAccessCodes(m_hGrd,dwPublic,dwPrivRD,dwPrivWR,dwPrivMS);
    if ErrorHandling(m_hGrd,nRet)=False then Begin Close;Result:=False;exit; End;

    except
     Close;
     ErrorMessage(ERR_NO_INIT);
    end;
End;
function CStealth2Driver.Find:Boolean;
Var
    dwLMS : DWord;
    nRet  : Integer;
Begin
    try
    Result:=True;
    dwLMS:=$FFFFFFFF;                                      
    nRet:= GrdLogout(m_hGrd,0);
    if SetFindDevices=False then Begin Close;Result:=False;exit; End;
    if FindDevice=False     then Begin Close;Result:=False;exit; End;
    nRet:= GrdLogin(m_hGrd,dwLMS,GrdLM_PerStation );
    if ErrorHandling(nil,nRet)=False then Begin Close;Result:=False;exit; End;
    except
     Close;
     ErrorMessage(ERR_NO_FIND);
    end;
End;
function CStealth2Driver.SetFindDevices:Boolean;
Var
    nRet : Integer;
Begin
    with m_nFIND do nRet := GrdSetFindMode(m_hGrd,dwRemoteMode,dwFlags,byProg,dwID,wSN,byVer,wMask,wType,dwModel,dwInterface);
    Result := ErrorHandling(m_hGrd,nRet);
End;
function CStealth2Driver.FindDevice:Boolean;
Var
    nRet : Integer;
    dwID : Dword;
Begin
    m_nGINF.Count:= 0;
    nRet:= GrdFind(m_hGrd,GrdF_First,@dwID,@m_nGINF.Items[m_nGINF.Count]);

    //if(nRet=GrdE_OK) then m_nGINF.Count := 1;
    //while(nRet=GrdE_OK) do
    //begin
     {
     with m_nGINF.Items[m_nGINF.Count] do
     Begin
      writeln('--------- Dongle  '+IntToStr(m_nGINF.Count)+' -----------------');
      writeln(' ID = '           +IntToStr(dwID) );
      writeln(' PublicCode =    '+IntToStr(dwPublicCode));
      writeln(' HardWare Ver. = '+IntToStr(byHrwVersion));
      writeln(' MaxNetRes =     '+IntToStr(byMaxNetRes));
      writeln(' Type =          '+IntToStr(wType));
      writeln(' ID =            '+IntToStr(dwID));
      writeln(' Num Prog =      '+IntToStr(byNProg));
      writeln(' Version =       '+IntToStr(byVer));
      writeln(' Serial Num =    '+IntToStr(wSN));
      writeln(' Bit Mask =      '+IntToStr(wMask));
      writeln(' GP counter =    '+IntToStr(wGP));
      writeln(' Real Net Res =  '+IntToStr(wRealNetRes));
      writeln(' Index =         '+IntToStr(dwIndex));
      writeln('--------------------------------------');
     End;
     }
     //if m_nGINF.Count<=10 then
     //nRet:= GrdFind(m_hGrd,GrdF_Next,@dwID,@m_nGINF.Items[m_nGINF.Count]);
     //m_nGINF.Count:= m_nGINF.Count+1;
    //end;
    //if (nRet<>GrdE_AllDonglesFound) then
    //Result := ErrorHandling(m_hGrd,nRet) else
    Result := ErrorHandling(m_hGrd,nRet);
    Result := True;
End;
function CStealth2Driver.Close:Boolean;
Var
    nRet : Integer;
Begin
    if(m_hGrd<>nil ) then
    Begin
     nRet:=GrdCloseHandle(m_hGrd);
     ErrorHandling(nil,nRet);
    End;
    nRet:= GrdCleanup();
    ErrorHandling(nil,nRet);
    m_hGrd := Nil;
End;
//Работа с ключем (чтение-запись)
function CStealth2Driver.WriteKey(nAddr:Integer;pBuffer:Pointer;wLen:Integer):Boolean;
Var
    nRet : Integer;
Begin
    nRet   := GrdWrite(m_hGrd,nAddr,wLen,pBuffer,Nil);
    Result := ErrorHandling(m_hGrd,nRet);
End;
function CStealth2Driver.ReadKey(nAddr:Integer;pBuffer:Pointer;wLen:Integer):Boolean;
Var
    nRet : Integer;
Begin
    nRet   := GrdRead(m_hGrd,nAddr,wLen,pBuffer,Nil);
    Result := ErrorHandling(m_hGrd,nRet);
End;
function CStealth2Driver.Write(pBuffer:Pointer;wLen:Integer):Boolean;
Begin
    Result := False;
    if (wLen>GRD_SIZE)then exit;
    Result := WriteKey(GRD_ARRD,pBuffer,wLen);
End;
function CStealth2Driver.Read(pBuffer:Pointer;wLen:Integer):Boolean;
Begin
    Result := False;
    if (wLen>GRD_SIZE)then exit;
    Result := ReadKey(GRD_ARRD,pBuffer,wLen);
End;
//Аппаратное кодирование-декодирование
function CStealth2Driver.Encode(pBuffer:Pointer;wLen:Integer):Boolean;
Var
    nRet  : Integer;
    strIV : SGSII64VECT;
Begin
    Move(m_strVectorIV,strIV,sizeof(SGSII64VECT));
    nRet   := GrdTransform(m_hGrd,GRD_ALG,wLen,pBuffer,GrdAM_OFB+GrdAM_encode,@strIV[0]);
    Result := ErrorHandling(m_hGrd,nRet);
End;
function CStealth2Driver.Decode(pBuffer:Pointer;wLen:Integer):Boolean;
Var
    nRet  : Integer;
    strIV : SGSII64VECT;
Begin
    Move(m_strVectorIV,strIV,sizeof(SGSII64VECT));
    nRet   := GrdTransform(m_hGrd,GRD_ALG,wLen,pBuffer,GrdAM_OFB+GrdAM_decode,@strIV[0]);
    Result := ErrorHandling(m_hGrd,nRet);
End;

procedure CStealth2Driver.ErrorMessage(nErrCode:Integer);
Begin
    if Assigned(FOnKeyErr) then FOnKeyErr(nErrCode);
End;
procedure CStealth2Driver.Writeln(str:String);
Begin
    //if m_byOutTrace=True then EventBox.FixEvents(ET_NORMAL,str);
End;
procedure CStealth2Driver.WritelnER(str:String);
Begin
    //if m_byOutTrace=True then EventBox.FixEvents(ET_CRITICAL,str);
End;
function CStealth2Driver.PrintResult(nErrorCode:integer):integer;
var
     szErrorMsg:STRING[$FF];	{ buffer for error string }
     nError:integer;
     hGrd:HANDLE;
     strError:String;
     i:integer;
begin
     hGrd:=nil;
     nError:=nErrorCode;
     strError:='';
     i:=1;
     GrdFormatMessage(hGrd,nError,GrdLng_ENG,@szErrorMsg[1],$FF,nil );
     while(szErrorMsg[i]<>chr(0)) do
     begin
      strError:=strError+szErrorMsg[i];
      i:=i+1;
     end;
     //if( nErrorCode = GrdE_OK ) Then writeln('  ' + strError) else
     //WritelnER('Error! '+ strError );
     PrintResult:=nErrorCode;
end;
function CStealth2Driver.ErrorHandling(hGrd:HANDLE;nRet:integer):Boolean;
begin
     Result := True;
     if( nRet <> GrdE_OK ) Then
     begin
      ErrorMessage(nRet);
      Result := False;
     end;
end;
end.
