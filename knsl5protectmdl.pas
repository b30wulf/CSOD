unit knsl5protectmdl;
//{$DEFINE HKEY_PROTECT}
//{$DEFINE HOUR_PROTECT}
//{$DEFINE DAY_PROTECT}
interface
uses
Windows, forms,Classes,controls, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
knsl3EventBox,utldatabase,knsl5grddriver,grddelphi,Graphics,knsl2module,registry,inifiles;
type
    CProtectModule = class
    protected
     m_nGRD : CStealth2Driver;
     m_nKeysTimer : CTimer;
     m_nCmprTimer : CTimer;
     m_nLockTimer : CTimer;
     m_nUnlkTimer : CTimer;
     m_nDaysTimer : CTimer;
     m_strVectorIV : SGSII64VECT;
     m_pComp0 : TControl;
     m_pComp1 : TControl;
     m_pComp2 : TControl;
     m_pComp3 : TControl;
     m_pComp4 : TControl;
     FForm    : TForm;
     m_blError: Boolean;
     m_blPulce: Boolean;
     m_blUnlock: Boolean;
     m_nExitCtr : Integer;
     m_nRegDate : TDateTime;
     procedure InitVector;
     function  InitFindKey:SFINDSETT;
     procedure OnException(nEvent:Integer);
     procedure Lock;
     procedure Unlock;
     function Compare32(str0:String;str1:array of byte):Boolean;
     procedure PulceError;
     function  ReadDateInst:boolean;

    public
     m_nFormFL : PByte;
//     constructor Create(pC0,pC1,pC2,pC3,pC4:TControl;stText:TStaticText;nForm:TForm);
     constructor Create(pC0,pC1,pC2,pC3,pC4:TControl;nForm:TForm);
     destructor Destroy;override;
     procedure Init;
     function FindKey:Boolean;
     function KeysHandler:Boolean;
     function CmprHandler:Boolean;
     function LockHandler:Boolean;
     function UnlkHandler:Boolean;
     function CheckLicenseDay:Boolean;
     procedure Run;
    End;
Var
    m_nPMD : CProtectModule = nil;
implementation
const
    PMD_KEYS_TIME = 15;
    PMD_CMPR_TIME = 3*60;
    PMD_LOCK_TIME = 5;
    PMD_UNLK_TIME = 3;
    PMD_RISC_TIME = 6*60;
    PMD_VALID_TIME = 3*3600;
    PMD_LIC_DAY_COUNT = 5;
    //PMD_VALID_TIME = 2*60;
    KEY_SIZE      = 32;
    m_strCodeKey:array[0..KEY_SIZE-1] of BYTE =(
    248,176,159,135, 46,241, 87,169, 69,140, 92,248, 34,105,  5,157,
    156,180, 55,165, 89,151,129,142, 57, 73, 60,227,208,191,188,242);
    m_strKey:string[KEY_SIZE]='4d2c3518-b337-496e-baa8-95926118';
procedure CProtectModule.InitVector;
Begin
    m_strVectorIV[0] := $4d;
    m_strVectorIV[1] := $04;
    m_strVectorIV[2] := $5b;
    m_strVectorIV[3] := $c5;
    m_strVectorIV[4] := $b1;
    m_strVectorIV[5] := $3d;
    m_strVectorIV[6] := $cd;
    m_strVectorIV[7] := $27;
End;
function CProtectModule.InitFindKey:SFINDSETT;
Var
    nFIND : SFINDSETT;
Begin
    with nFIND do
    Begin
     dwRemoteMode := GrdFMR_Local; 	              { Local dongle }
     dwFlags      := GrdFM_NProg+GrdFM_Ver+GrdFM_Type;{ Check by bProg, bVer & dongle type flag }
     byProg       := 1;     			      { Check by specified program number }
     byVer        := 62;    			      { Check by specified version }
     wType        := GrdDT_GSII64;		      { Dongle with GSII64 algorithm }
     dwID         := 0;		     		      { This search mode is not used }
     wSN          := 0;     			      { This search mode is not used }
     wMask        := 0;     			      { This search mode is not used }
     dwModel      := GrdFMM_ALL;		      { Possible model bits }
     dwInterface  := GrdFMI_ALL;		      { Possible interface bits }
    End;
    Result := nFIND;
End;
//constructor CProtectModule.Create(pC0,pC1,pC2,pC3,pC4:TControl;stText:TStaticText;nForm:TForm);
constructor CProtectModule.Create(pC0,pC1,pC2,pC3,pC4:TControl;nForm:TForm);
Begin
    m_pComp0  := pC0;
    m_pComp1  := pC1;
    m_pComp2  := pC2;
    m_pComp3  := pC3;
    m_pComp4  := pC4;
    m_blUnlock:= True;
    FForm     := nForm;
    m_blError := False;
    m_nExitCtr:= PMD_RISC_TIME;

    {$IFDEF HKEY_PROTECT}
    m_nExitCtr:= PMD_RISC_TIME;
    {$ENDIF HKEY_PROTECT}

    {$IFDEF HOUR_PROTECT}
    m_nExitCtr:= PMD_VALID_TIME;
    {$ENDIF HOUR_PROTECT}

    InitVector;
    m_nGRD := CStealth2Driver.Create(m_strVectorIV,InitFindKey);
    m_nGRD.OnKeyErr := OnException;
    m_nGRD.Init;
    m_nKeysTimer := CTimer.Create;
    m_nKeysTimer.SetTimer(DIR_L3TOL3,DL_KEYS_TMR,0,0,BOX_L3);

    m_nCmprTimer := CTimer.Create;
    m_nCmprTimer.SetTimer(DIR_L3TOL3,DL_CMPR_TMR,0,0,BOX_L3);

    m_nLockTimer := CTimer.Create;
    m_nLockTimer.SetTimer(DIR_L3TOL3,DL_LOCK_TMR,0,0,BOX_L3);

    m_nUnlkTimer := CTimer.Create;
    m_nUnlkTimer.SetTimer(DIR_L3TOL3,DL_UNLK_TMR,0,0,BOX_L3);

    m_nDaysTimer := CTimer.Create;
    m_nDaysTimer.SetTimer(DIR_L3TOL3,DL_DAYS_LOCK_TMR,0,0,BOX_L3);
End;
procedure CProtectModule.Init;
Begin
    {$IFDEF HKEY_PROTECT}
    m_nGRD.Init;
    m_nCmprTimer.OnTimer(PMD_CMPR_TIME);
    {$ENDIF HKEY_PROTECT}
End;
function CProtectModule.FindKey:Boolean;
Begin
    Result := True;
    {$IFDEF HKEY_PROTECT}
    Result := m_nGRD.Find;
    {$ENDIF HKEY_PROTECT}
    {$IFDEF HOUR_PROTECT}
    m_nLockTimer.OnTimer(PMD_VALID_TIME-20);
    {$ENDIF HOUR_PROTECT}
    {$IFDEF DAY_PROTECT}
    Result := ReadDateInst;
    m_nDaysTimer.OnTimer(60);
    {$ENDIF DAY_PROTECT}
End;
destructor CProtectModule.Destroy;
Begin
  if m_nGRD <> nil then FreeAndNil(m_nGRD);

  if m_nKeysTimer <> nil then FreeAndNil(m_nKeysTimer);
  if m_nCmprTimer <> nil then FreeAndNil(m_nCmprTimer);
  if m_nLockTimer <> nil then FreeAndNil(m_nLockTimer);

  if m_nUnlkTimer <> nil then FreeAndNil(m_nUnlkTimer);
  if m_nDaysTimer <> nil then FreeAndNil(m_nDaysTimer);
End;

procedure CProtectModule.OnException(nEvent:Integer);
Begin

End;
function CProtectModule.KeysHandler:Boolean;
Begin
    if FindKey=True then  m_nCmprTimer.OnTimer(PMD_CMPR_TIME) else
                          m_nLockTimer.OnTimer(PMD_LOCK_TIME)
End;
function CProtectModule.LockHandler:Boolean;
Begin
    Lock;
    m_nGRD.Init;
    m_nKeysTimer.OnTimer(PMD_KEYS_TIME)
End;
function CProtectModule.CmprHandler:Boolean;
Begin
    if Compare32(m_strKey,m_strCodeKey)=True then
    Begin
     m_nCmprTimer.OnTimer(PMD_CMPR_TIME);
     m_nUnlkTimer.OnTimer(PMD_UNLK_TIME)
    End
    else
     m_nLockTimer.OnTimer(PMD_LOCK_TIME)
End;
function CProtectModule.UnlkHandler;
Begin
    Unlock;
End;
function CProtectModule.Compare32(str0:string;str1:array of byte):Boolean;
Var
    i : Integer;
Begin
    Result := True;
    m_nGRD.Encode(@str0[1],KEY_SIZE);
    for i:=0 to KEY_SIZE-1 do
    if str0[i+1]<>char(str1[i]) then
    Begin
     Result := False;
     exit;
    End;
End;
procedure CProtectModule.Lock;
Var
    i : Integer;
Begin
    m_blUnlock       := False;
    m_pComp0.Enabled := False;
    m_pComp1.Enabled := False;
    m_pComp2.Enabled := False;
    m_pComp3.Enabled := False;
    m_pComp4.Enabled := False;
    for i:=0 to FForm.MDIChildCount-1 do FForm.MDIChildren[i].Enabled := False;
    mL2Module.Suspend;
    m_blError  := True;
End;
procedure CProtectModule.Unlock;
Var
    i : Integer;
Begin
    if m_blUnlock=False then
    Begin
     m_blUnlock       := True;
     m_pComp0.Enabled := True;
     m_pComp1.Enabled := True;
     m_pComp2.Enabled := True;
     m_pComp3.Enabled := True;
     m_pComp4.Enabled := True;
     for i:=0 to FForm.MDIChildCount-1 do FForm.MDIChildren[i].Enabled := True;
     mL2Module.Resume;
     m_blError := False;
     m_nExitCtr:= PMD_RISC_TIME;
    End;
End;
procedure CProtectModule.PulceError;
Begin
    if m_blPulce=False then
    Begin
     m_blPulce := True;
    End else
    if m_blPulce=True then
    Begin
     m_blPulce := False;
    End;
    if m_nExitCtr>0 then m_nExitCtr := m_nExitCtr - 1;
    if m_nExitCtr=0 then Begin m_nFormFL^:=1;Application.Terminate;{FForm.Close;}End;
End;

function  CProtectModule.ReadDateInst:boolean;
var Fl   : TINIFile;
begin
   Result := true;
   try
     Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\USPD_Config.ini');
     if not Fl.SectionExists('REGDATE') then
     begin
       m_nRegDate := Now;
       Fl.WriteString('REGDATE', 'm_nRegDate', DateTimeToStrCrypt(m_nRegDate));
     end else
       m_nRegDate := StrToDateTimeCrypt(Fl.ReadString('REGDATE', 'm_nRegDate', '12321'));
   except
     Result := false;
   end;
   Fl.Destroy;
end;
function CProtectModule.CheckLicenseDay:Boolean;
begin
   if abs(Now - m_nRegDate) > PMD_LIC_DAY_COUNT then
   begin
     Application.Terminate;
   end;
   m_nDaysTimer.OnTimer(60);
end;
procedure CProtectModule.Run;
Begin
    {$IFDEF HKEY_PROTECT}
    m_nKeysTimer.RunTimer;
    m_nCmprTimer.RunTimer;
    m_nLockTimer.RunTimer;
    m_nUnlkTimer.RunTimer;
    if m_blError=True then PulceError;
    {$ENDIF HKEY_PROTECT}
    {$IFDEF HOUR_PROTECT}
    PulceError;
    m_nLockTimer.RunTimer;
    {$ENDIF HOUR_PROTECT}
    {$IFDEF DAY_PROTECT}
    m_nDaysTimer.RunTimer;
    {$ENDIF DAY_PROTECT}
End;

initialization

finalization
  if m_nPMD <> nil then FreeAndNil(m_nPMD);

end.
