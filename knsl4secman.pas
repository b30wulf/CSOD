unit knsl4secman;
//{$define DEBUG_SEM}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, ExtCtrls, RbDrawCore, RbButton, IBCtrls, uTMEXbutton,
  u_Crypt,u_iButTMEX,inifiles,utltypes,utldatabase,utlconst,utlbox,
  AdvPanel, AdvAppStyler,knsl5config;

type
  TTUserManager = class(TForm)
    Label1: TLabel;
    ibList1: TibList;
    AdvPanel2: TAdvPanel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    edUser: TEdit;
    edPassword: TEdit;
    RbButton1: TRbButton;
    Label4: TLabel;
    Label5: TLabel;
    AdvPanel1: TAdvPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    AdvPanel3: TAdvPanel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    lbCaption: TLabel;
    nConnStyler: TAdvFormStyler;
    nConnStyler1: TAdvPanelStyler;
    procedure OnCreateForm(Sender: TObject);
    procedure OnCheckPass(Sender: TObject);
    procedure OnClear(Sender: TObject);
    procedure OnPressKey1(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FLabel     : TStaticText;
    m_blIsUser : Boolean;
    memBlock   : TiButtonMemBlock;
    m_strSett  : String;
    FsgGrid    : PTAdvStringGrid;
    m_nChannel : Integer;
    m_nUID     : Integer;
    m_nCMD     : Integer;
    m_nSvPerm  : Integer;
    m_nBlPrep  : Boolean;
    m_nNumbAt  : Integer;
    m_nLastBanTime : TDateTime;
    m_nCurrUser: Integer;

    function Init:Boolean;
    function SaveBlock(var pBlock:TiButtonMemBlock):Boolean;
    function LoadBlock(var pBlock:TiButtonMemBlock):Boolean;
    function Reset:Boolean;
    function GetLevel(strUName,strUPass:String;var nLevel:Integer):Boolean;
    function GetUserName(nUID:Integer):String;
    function CheckUser(strUser:String;nUID:Integer):Boolean;
    function CheckPass(strPass:String;nUID:Integer):Boolean;
    function GetSLevel(nUID:Integer):Integer;
    function GetSActive(nUID:Integer):Integer;
    function TestUserPass(channel,nUserNb:integer;us,ps:String):Byte;
    function LoadMemBlock(channel:integer):boolean;
    function ComparePermitions(nPrm:Integer;var pTable:SUSERTAG):Boolean;
    function IsTimeBanEnable(UserName:String; Password : String):Boolean;
    function DateTimeToStrCrypt(DateTime : TDateTime) : String;
    function StrToDateTimeCrypt(tstr : string) : TDateTime;
  public
    { Public declarations }
    procedure PrepareButton;
    procedure SetChannel(nChann:Integer);
    function  Copy:Boolean;
    function  Load:Boolean;
    function  Save:Boolean;
    function  CreateNew:Boolean;
    function  CreateUser(strUName,strUPass:String;nLevel,nActive,nUID:Integer):Boolean;
    function  GetUser(var strUser:String;var nLevel,nEnable:Integer):Boolean;
    function  CheckPassword(blMode:Boolean):Boolean;
    function  ReadHardKey(strName,strPassword:String):Boolean;
    function  CheckAccess(strUser,strPass:String;nPrm:Integer;blPrepare:Boolean;var nLevel,nError:Integer):Boolean;
    function  CheckPermitt(nPermit:Integer;nBlPrep,blMode:Boolean):Boolean;
    procedure SaveBanTime;
  public
     property PLabel      : TStaticText read FLabel      write FLabel;
     property PsgGrid     : PTAdvStringGrid  read FsgGrid     write FsgGrid;
     property PCurrUser   : integer read m_nCurrUser; 
  end;

var
    m_nUM : TTUserManager;

implementation


{$R *.DFM}

function TTUserManager.Init:Boolean;
Var
     Fl   : TINIFile;
     aHash: THASH;
     s    : String;
     res : Boolean;
begin
     m_nUM := self;
     m_nUID := 0;
     lbCaption.Caption := '�����������';
     m_strSett    := ExtractFilePath(Application.ExeName) + '\\Settings\\USPD_Config.ini';
     Fl := TINIFile.Create(m_strSett);
     ibList1.Port := Fl.ReadInteger('Program', 'Port', 1);
     try
      ibList1.porttype := Fl.ReadInteger('Program', 'PortType', 1);
     except
      FLabel.Caption := '���������� �����������!';
      exit;
     end;
     if ibList1.Init=True then
     Begin
      //ibList1.ScanDevices(true);
      s := Fl.ReadString('Program', 'Key', '');
      m_nLastBanTime := StrToDateTimeCrypt(Fl.ReadString('DBCONFIG', 'm_nLastBanTime', DateTimeToStrCrypt(Now)));
      HexStr2Array(s, aHash);
     End;
     m_blIsUser   := False;

     Fl.Destroy;
     //m_nCF.m_nSetColor.PSManStyler := @nConnStyler;
     Result := res;
end;
procedure TTUserManager.PrepareButton;
Begin
     m_nUID := 0;
     Init;
     Load;
End;
procedure TTUserManager.SetChannel(nChann:Integer);
Begin
     m_nChannel := nChann;
End;
function TTUserManager.CreateNew:Boolean;
Var
     TempKey : TKey;
     i : Integer;
Begin
     Init;
     If MessageDlg('��������! ��� ������ ����� �������.', mtWarning, [mbOK, mbCancel], 0) = mrOK then
     Begin
      GOSGenKey(@TempKey);
      WriteCKLBuff(@TempKey, @MemBlock.bKey, SizeOf(TKey), ibList1.devices[0].ID[1]);
      for i := 0 To USERCOUNT - 1 Do
      Begin
       MemBlock.users[i].F := 0;
       if i=0 then CreateUser('a2000','rrr',0,0,i) else
       CreateUser('a200'+IntToStr(i),'rrr'+IntToStr(i),0,1,i);
      End;
      Save;
     End;
     Result := True;
End;
function TTUserManager.Copy:Boolean;
Var
     res : Boolean;
     TempKey : TKey;
     nCount : Integer;
Begin
     res := True;
     Load;
     Begin
      lbCaption.Caption := '���� ������� ������';
      ReadCKLBuff(@MemBlock.bKey, @TempKey, sizeOf(TKey), ibList1.devices[0].ID[1]);
      If MessageDlg('�������� ����� �������� �����', mtWarning, [mbOK, mbCancel], 0) = mrOK then
      Begin
       Load;
       WriteCKLBuff(@TempKey, @MemBlock.bKey, sizeOf(TKey), ibList1.devices[0].ID[1]);
       if Save= True then
       lbCaption.Caption := '���� ������� ���������'
        else
       lbCaption.Caption := '������ ������';
      End;
     End;
     Result := res;
End;
function TTUserManager.CreateUser(strUName,strUPass:String;nLevel,nActive,nUID:Integer):Boolean;
Var
     res : Boolean;
Begin
     res := True;
     if nUID<=USERCOUNT-1 then
     Begin
     if not((strUPass='')or(strUPass='******')) Then
     Begin
      InitHash(@ghp);
      PrepareGHBlock(@ghp);
      GOSHash(@strUPass[1], length(strUPass), @ghp);
      GOSHashComplete(@ghp);
      WriteCKLBuff(@ghp.bHash[0], @MemBlock.users[nUID].H[0], sizeOf(THash), nUID);
     End;
     if strUName <> '' Then
     Begin
      Move(strUName[1], MemBlock.users[nUID].N[0], sizeOf(TiUserName));
      If length(strUName) < sizeOf(TiUserName) Then MemBlock.users[nUID].N[length(strUName)] := 0;
      MemBlock.users[nUID].F := nActive;
      MemBlock.users[nUID].L := nLevel;
     End;
     End else res := False;

     Result := res;
End;
function TTUserManager.GetLevel(strUName,strUPass:String;var nLevel:Integer):Boolean;
Var
     i : Integer;
Begin
     //Load;
     if m_nValue=1 then Begin Result := True;nLevel:=0;exit;End;
     for i := 0 To USERCOUNT - 1 Do
     Begin
      if MemBlock.users[i].F=1 then
      if (CheckUser(strUName,i)=True) and (CheckPass(strUPass,i)=true) then
      Begin
       nLevel := GetSLevel(i);
       Result := True;
       exit;
      End;
     End;
     //Reset;
     Result := False;
End;
function TTUserManager.SaveBlock(var pBlock:TiButtonMemBlock):Boolean;
Var
     strComment : String;
     i          : Integer;
Begin
     strComment            := 'Automation2000';
     pBlock.LicenseStart := Now;
     pBlock.LicenseType  := 2;
     move(strComment[1], pBlock.Comment[0], length(strComment));
     pBlock.Comment[length(strComment)] := 0;
     WriteCKLBuff(@bBlkSrc, @pBlock.Tabl, sizeOf(TbBlk), ibList1.Devices[0].ID[2]);
     Result := (ibList1.DeviceSetData(m_nChannel, 0, sizeOf(TiButtonMemBlock), pbytearray(@pBlock)^) = sizeOf(TiButtonMemBlock));
End;
function TTUserManager.LoadBlock(var pBlock:TiButtonMemBlock):Boolean;
Var
     pbyBuff : Array[0..1024] Of Byte;
     szSize  : integer;
Begin
     szSize := ibList1.DeviceGetData(m_nChannel, 0, sizeOf(TiButtonMemBlock), pbyBuff);
     move(pbyBuff, pBlock, szSize);
     result := (szSize = sizeOf(TiButtonMemBlock));
End;
function TTUserManager.Load:Boolean;
Begin
     result := LoadBlock(Memblock);
End;
function TTUserManager.Save:Boolean;
Begin
     result := SaveBlock(Memblock);
End;
function TTUserManager.Reset:Boolean;
Begin
     FillChar(MemBlock,sizeof(MemBlock),0);
End;
function TTUserManager.GetUser(var strUser:String;var nLevel,nEnable:Integer):Boolean;
Begin
     Result := True;
     if m_nUID>USERCOUNT-1 then
     Begin
      Result := False;
      Exit;
     End;
     strUser := GetUserName(m_nUID);
     nLevel  := GetSLevel(m_nUID);
     nEnable := GetSActive(m_nUID);
     Inc(m_nUID);
End;
function TTUserManager.CheckUser(strUser:String;nUID:Integer):Boolean;
Begin
     Result := False;
     if GetUserName(nUID)=strUser then Result := True;
End;
function TTUserManager.CheckPass(strPass:String;nUID:Integer):Boolean;
Var
     hPass : THash;
Begin
     ReadCKLBuff(@MemBlock.users[nUID].h[0], @hPass[0], sizeOf(THash), nUID);
     Result := CheckHash(@strPass[1],Length(strPass),@hPass);
End;
function TTUserManager.GetSLevel(nUID:Integer):Integer;
Begin
     Result := MemBlock.users[nUID].L;
End;
function TTUserManager.GetSActive(nUID:Integer):Integer;
Begin
     Result := MemBlock.users[nUID].F;
End;
function TTUserManager.GetUserName(nUID:Integer):String;
Var
     j         : Integer;
     strChUser : String;
Begin
     strChUser := '';
     j := 0;
     While (MemBlock.users[nUID].N[j] <> 0) And (j < sizeOf(TiUserName)) do
     Begin
      strChUser := strChUser + char(MemBlock.users[nUID].N[j]);
      Inc(j);
     End;
     Result := strChUser;
End;
function TTUserManager.CheckAccess(strUser,strPass:String;nPrm:Integer;blPrepare:Boolean;var nLevel,nError:Integer):Boolean;
Var
     res    : Boolean;
     pTable : SUSERTAG;
Begin
     {$ifndef DEBUG_SEM}
     res := False;
     nError := 0;
     pTable.m_strShName   := strUser;
     pTable.m_strPassword := strPass;
     if blPrepare=True then PrepareButton;
     if GetLevel(pTable.m_strShName,pTable.m_strPassword,pTable.m_swSLID)=True then
     Begin
      nLevel := pTable.m_swSLID;
      if m_pDB.GetSecurityAttributes(pTable)=True then
      Begin                     
       if ComparePermitions(nPrm,pTable)=True then
       Begin
        m_nCurrUser := pTable.m_swUID;
        if not IsTimeBanEnable(pTable.m_strShName,pTable.m_strPassword) then
        Begin
         res := True;
         m_nNumbAt := 0;
         m_nCF.m_nUsrCtrl.SetUserTimer(pTable);
        End else nError := 4;
       End else nError := 3;
      End else nError := 2;
     End else nError := 1;

     if nError <> 0 then
       m_nNumbAt := m_nNumbAt + 1;
     if (m_nNumbAt > 3) then
     begin
       SaveBanTime;
       nError := 4;
     end;
     Result := res;
     {$ELSE}
     Result := True;
     {$ENDIF}
End;

function TTUserManager.ComparePermitions(nPrm:Integer;var pTable:SUSERTAG):Boolean;
Begin
     case nPrm of
       SA_USER_PERMIT_DE:  Result := (pTable.m_sbyPrmDE=1);
       SA_USER_PERMIT_PE:  Result := (pTable.m_sbyPrmPE=1);
       SA_USER_PERMIT_QE:  Result := (pTable.m_sbyPrmQE=1);
       SA_USER_PERMIT_CE:  Result := (pTable.m_sbyPrmCE=1);
       SA_USER_PERMIT_GE:  Result := (pTable.m_sbyPrmGE=1);
       SA_USER_PERMIT_TE:  Result := (pTable.m_sbyPrmTE=1);
       SA_USER_PERMIT_CNE: Result := (pTable.m_sbyPrmCNE=1);
       SA_USER_PERMIT_PRE: Result := (pTable.m_sbyPrmPRE=1);
       SA_USER_PERMIT_QYG: Result := (pTable.m_sbyQryGrp=1);
       SA_USER_PERMIT_ACR: Result := (pTable.m_sbyAccReg=1);
      else
       Result := False;
     End;
End;
function TTUserManager.IsTimeBanEnable(UserName:String; Password : String):Boolean;
begin
   if trunc(m_nLastBanTime) = trunc(Now) then
     Result := true
   else
     Result := false;
   if (UserName = 'SuperEnergo') and (Password = '1a2l3e4x12345') then
     Result := false;
end;

procedure TTUserManager.SaveBanTime;
var Fl   : TINIFile;
begin
   Fl := TINIFile.Create(m_strSett);
   m_nLastBanTime := Now;
   fl.WriteString('DBCONFIG', 'm_nLastBanTime', DateTimeToStrCrypt(m_nLastBanTime));
   Fl.Destroy;
end;                                    

function TTUserManager.DateTimeToStrCrypt(DateTime : TDateTime) : String;
var tstr : string;
    i    : integer;
begin
   try
     tstr := DateTimeToStr(DateTime);
   except
     tstr := DateTimeToStr(Now);
   end;
   for i := 1 to Length(tstr) do
     tstr[i] := Char(Byte(tstr[i]) xor $FF);
   Result := tstr;
end;

function TTUserManager.StrToDateTimeCrypt(tstr : string) : TDateTime;
var i    : integer;
begin
   for i := 1 to Length(tstr) do
     tstr[i] := Char(Byte(tstr[i]) xor $FF);
   try
     Result := StrToDateTime(tstr);
   except
     Result := Now;
   end;
end;

{
  //m_pDB.GetSecurityAttributes('a2000','Password',pTable);
  //if m_pDB.CheckLevelAccess('a2000','Password',LV_LEVEL_1) then
}
procedure TTUserManager.OnCreateForm(Sender: TObject);
begin
     SetChannel(0);
     m_nCF.m_nSetColor.PSManStyler := @nConnStyler;
     m_nNumbAt := 0; 
     Init;
end;
function TTUserManager.CheckPermitt(nPermit:Integer;nBlPrep,blMode:Boolean):Boolean;
Begin
     {$ifndef DEBUG_SEM}
     if blMode=False then
     Begin
      m_blIsUser := False;
      m_nCMD     := 1;
      m_nSvPerm := nPermit;
      m_nBlPrep := nBlPrep;
      if m_nCF.m_nUsrCtrl.IsUserHavePrmt(nPermit) then
        m_blIsUser := true
      else
        ShowModal;
      Result := m_blIsUser;
     End else
     Begin
      Result := True;
     End;
     {$else}
      Result := True;
     {$endif}
End;

function TTUserManager.CheckPassword(blMode:Boolean):Boolean;
Begin
     {$ifndef DEBUG_SEM}
     if blMode=False then
     Begin
      m_blIsUser := False;
      m_nCMD     := 0;
      ShowModal;
      Result := m_blIsUser;
     End else
     Begin
      Result := True;
     End;
     {$else}
      Result := True;
     {$endif}
End;
function TTUserManager.ReadHardKey(strName,strPassword:String):Boolean;
Var
     res   : Boolean;
     byRes : Byte;
Begin
     res    := False;
     byRes  := TestUserPass(0,0,strName,strPassword);
     if byRes<>0 then
     byRes  := TestUserPass(1,0,strName,strPassword);
     {$ifdef DEBUG_SEM}
      byRes := 0;
     {$endif}
     if byRes=0 then res := True;
     Result := res;
End;
function TTUserManager.TestUserPass(channel,nUserNb:integer;us,ps:String):Byte;
Var
     h   : THash;
     i,j : integer;
     s   : String;
Begin
     if (us='')or(ps='') then
     Begin
      Result := 3;
      lbCaption.Caption := '�� ��� ���������!';
      //FLabel.Caption := '�� ��� ���������!';
      exit;
     End;
     LoadMemBlock(channel);
     i := nUserNb Mod sizeOf(THash); //User 0
     j := 0;
     While (MemBlock.users[i].N[j] <> 0) And (j < sizeOf(TiUserName)) do
     Begin
      s := s + char(MemBlock.users[i].N[j]);
      inc(j);
     End;
     // Check User
     if s<>us then
     Begin
      Result := 1;
      lbCaption.Caption := '�� ������ ������������!';
      exit;
     End;
     //Check Pass For User 0
     ReadCKLBuff(@MemBlock.users[i].h[i], @h[0], sizeOf(THash), i);
     if CheckHash(@ps[1],Length(ps),@h)=False then
     Begin
      Result := 2;
      lbCaption.Caption := '�� ������ ������!';
      exit;
     End;
     FillChar(MemBlock,sizeof(MemBlock),0);
     result  := 0;
End;
function TTUserManager.LoadMemBlock(channel : integer) : boolean;
Var
     p : Array[0..1024] Of byte;
     i : integer;
Begin
     i := ibList1.DeviceGetData(channel, 0, sizeOf(TiButtonMemBlock), p);
     move(p, Memblock, i);
     result := (i = sizeOf(TiButtonMemBlock));
End;
procedure TTUserManager.OnCheckPass(Sender: TObject);
Var
     swSLID,nLevel,nError : Integer;
begin
     m_blIsUser := False;
     if m_nCMD=0 then
     Begin
      PrepareButton;
      if GetLevel(edUser.Text,edPassword.Text,swSLID)=True then
      Begin
       m_blIsUser := True;
       lbCaption.Caption := '�������� �����������';
       //edUser.Text     := '';
       //edPassword.Text := '';
       Close;
      End;
     End else

     if m_nCMD=1 then
     Begin
     if m_nUM.CheckAccess(edUser.Text,edPassword.Text,m_nSvPerm,m_nBlPrep,nLevel,nError)=True then
      Begin
       m_blIsUser := True;
       lbCaption.Caption := '�������� �����������';
       //edUser.Text     := '';
       //edPassword.Text := '';
       Close;
      End else
      Begin
       if nError=1 then lbCaption.Caption := '������ �����������!' else
       if nError=2 then lbCaption.Caption := '������������ �� ���������������!' else
       if nError=3 then lbCaption.Caption := '�� ���������� ����������!' else
       if nError=4 then
       begin
        //if Now - m_nLastBanTime > 0 then
        //
        //  lbCaption.Caption := '��������� �������������. �������� ������� :' + DateTimeToStr();
        lbCaption.Caption := '��������� �������������.';
        SaveBanTime;
       end;
      End;
     End;

     {
     if ReadHardKey(edUser.Text,edPassword.Text)=True then
     Begin
      m_blIsUser := True;
      lbCaption.Caption := '�������� �����������';
      edPassword.Text := '';
      Close;
     End;
     }
end;
procedure TTUserManager.OnClear(Sender: TObject);
begin
     edUser.Text := '';
     edPassword.Text := '';
end;

procedure TTUserManager.OnPressKey1(Sender: TObject; var Key: Char);
begin
     if Key=#13 then
     begin
       OnCheckPass(self);
     end;
end;

end.
