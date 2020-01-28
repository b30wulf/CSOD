unit knsl4secman;
{$define DEBUG_SEM}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, ExtCtrls, RbDrawCore, RbButton, IBCtrls, uTMEXbutton,
  u_Crypt,u_iButTMEX,inifiles,utltypes;

type
  TTUserManager = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    lbCaption: TLabel;
    Label4: TLabel;
    edUser: TEdit;
    Label5: TLabel;
    edPassword: TEdit;
    Panel8: TPanel;
    Image5: TImage;
    Label12: TLabel;
    Label11: TLabel;
    RbButton1: TRbButton;
    RbButton2: TRbButton;
    ibList1: TibList;
    procedure OnCreateForm(Sender: TObject);
    procedure OnCheckPass(Sender: TObject);
    procedure OnClear(Sender: TObject);
  private
    { Private declarations }
    FLabel     : TLabel;
    m_blIsUser : Boolean;
    memBlock   : TiButtonMemBlock;
    m_strSett  : String;
    function ReadHardKey(strName,strPassword:String):Boolean;
    function TestUserPass(channel,nUserNb:integer;us,ps:String):Byte;
    function LoadMemBlock(channel:integer):boolean;
  public
    { Public declarations }
    function CheckPassword(blMode:Boolean):Boolean;
  public
     property  PLabel : TLabel      read FLabel    write FLabel;
  end;

var
    TUserManager: TTUserManager;

implementation

{$R *.DFM}

procedure TTUserManager.OnCreateForm(Sender: TObject);
Var
     Fl   : TINIFile;
     aHash: THASH;
     s    : String;
begin
     TUserManager := self;
     lbCaption.Caption := 'Авторизация';
     m_strSett    := ExtractFilePath(Application.ExeName) + '\\Settings\\USPD_Config.ini';
     Fl := TINIFile.Create(m_strSett);
     ibList1.Port := Fl.ReadInteger('Program', 'Port', 1);
     try
      ibList1.porttype := Fl.ReadInteger('Program', 'PortType', 1);
     except
      FLabel.Caption := 'Устройство отсутствует!';
      exit;
     end;
     if ibList1.Init=True then
     Begin
      //ibList1.ScanDevices(true);
      s := Fl.ReadString('Program', 'Key', '');
      HexStr2Array(s, aHash);
     End;
     m_blIsUser   := False;
     Fl.Destroy;
end;
function TTUserManager.CheckPassword(blMode:Boolean):Boolean;
Begin
     {$ifndef DEBUG_SEM}
     if blMode=False then
     Begin
      m_blIsUser := False;
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
      lbCaption.Caption := 'Не все параметры!';
      //FLabel.Caption := 'Не все параметры!';
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
      lbCaption.Caption := 'Не верный пользователь!';
      exit;
     End;
     //Check Pass For User 0
     ReadCKLBuff(@MemBlock.users[i].h[i], @h[0], sizeOf(THash), i);
     if CheckHash(@ps[1],Length(ps),@h)=False then
     Begin
      Result := 2;
      lbCaption.Caption := 'Не верный пароль!';
      exit;
     End;
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
begin
     m_blIsUser := False;
     if ReadHardKey(edUser.Text,edPassword.Text)=True then
     Begin
      m_blIsUser := True;
      lbCaption.Caption := 'Успешная авторизация';
      edPassword.Text := '';
      Close;
     End;
end;
procedure TTUserManager.OnClear(Sender: TObject);
begin
     edUser.Text := '';
     edPassword.Text := '';
end;

end.
