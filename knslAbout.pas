unit knslAbout;
{$define DEBUG_NO_CHECK}
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, jpeg, StdCtrls,utldatabase,utlconst,
  utltypes, RbDrawCore, RbButton, utlbox,registry, AdvGlowButton;
type
  TTAbout = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label2: TLabel;
    edSoftID: TEdit;
    edSoftHashID: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    AdvGlowButton1: TAdvGlowButton;
    RbButton1: TAdvGlowButton;
    RbButton2: TAdvGlowButton;
    Label6: TLabel;
    Label10: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure OnRegistration(Sender: TObject);
    procedure OnGenHardID(Sender: TObject);
    procedure OnChandgeRegKey(Sender: TObject);
    procedure OnCreateForm(Sender: TObject);
  private
    pGenTable : SGENSETTTAG;
    function GetSoftID:String;
    function GetSoftPPID:String;
    procedure WriteRegistry(Key_Open, Key_Read,strValue: string);
    function Code1(Code: String): string;
    function Code2(Code: String): string;
    function CompareCode(strCode0,strCode1:String):Boolean;
    { Private declarations }
  public
    { Public declarations }
    m_blRG : Boolean;
    function CompareKey:Boolean;
    function ReadRegistry(Key_Open, Key_Read: string): string;
  end;
var
  TAbout: TTAbout;
implementation
{$R *.DFM}
procedure TTAbout.FormActivate(Sender: TObject);
var
    vers : string;
begin
    vers           := FileVersion(ParamStr(0));
    label1.Caption :='версия ' + vers;
    if m_pDB<>Nil then
    Begin
     m_pDB.GetGenSettTable(pGenTable);
     Label2.Caption := pGenTable.m_sProjectName;
    End;
end;
procedure TTAbout.Button1Click(Sender: TObject);
begin
    Close;
end;
procedure TTAbout.OnRegistration(Sender: TObject);
Var
    strSoft_P,strSoft_PP,strCalc_PP : String;
begin
    strSoft_P  := Code1(GetSoftID);
    strSoft_PP := Code2(strSoft_P);
    try
    Begin
     if edSoftHashID.Text<>'' then
     Begin
      strCalc_PP := edSoftHashID.Text;
      if CompareCode(strSoft_PP,strCalc_PP)=True then
      Begin
       WriteRegistry('\SOFTWARE\A2K\A2KAutorization','A2KAutorization',strCalc_PP);
       WriteRegistry('\SOFTWARE\A2K\A2KAutorization','DateReg',DateTimeToStr(now));
       WriteRegistry('\SOFTWARE\A2K\A2KAutorization','DateRegEnd','no date');
       m_pDB.GetGenSettTable(pGenTable);
       WriteRegistry('\SOFTWARE\A2K\A2KAutorization','NameComp',pGenTable.m_sProjectName);
       if CompareKey=True  then MessageDlg('Регистрация прошла успешно!',mtInformation,[mbOk],0);
      End else if CompareKey=False then MessageDlg('Не верный код регистрации!',mtWarning,[mbOk,mbCancel],0);
     End else MessageDlg('Код регистрации не введен!',mtWarning,[mbOk,mbCancel],0);
    End;
    except
    end;
end;
function TTAbout.GetSoftID:String;
Var
    str : String;
Begin
    str := 'Key not found';
    str := ReadRegistry('Software\Microsoft\Windows\CurrentVersion','ProductID');
    if str<>'' then Result := str;
End;
function TTAbout.GetSoftPPID:String;
Var
    str : String;
Begin
    str := 'Key not found';
    str := ReadRegistry('\SOFTWARE\A2K\A2KAutorization','A2KAutorization');
    if str<>'' then Result := str;
End;
function TTAbout.Code1(Code: String): string;
var
    ProdIDcode: char;
    Res: string;
    i: Integer;
begin
    ProdIDcode:=#0;
    for i := 1 to length(Code) do
    begin
     If Code[i]='9' then ProdIDcode:= chr(ord(Code[i])) else
     If Code[i]='-' then ProdIDcode:= chr(ord(Code[i])) else
     ProdIDcode := chr((ord(Code[i]) + 1));
     Res:=Res+ProdIDcode;
    end;
    Result:=Res;
end;
function TTAbout.Code2(Code: String): string;
var
    ProdIDcode: char;
    Res: string;
    i: Integer;
begin
    ProdIDcode:=#0;
    for i := 1 to length(Code) do
    begin
     If Code[i]='-' then ProdIDcode:= chr(ord(Code[i])) else
     ProdIDcode := chr((ord(Code[i]) + 16));
     Res:=Res+ProdIDcode;
    end;
    Result:=Res;
end;
function TTAbout.CompareKey:Boolean;
Var
    strSoft_PP,strReg_PP,res : String;
Begin
    strSoft_PP := Code2(Code1(GetSoftID));
    strReg_PP  := GetSoftPPID;
    if CompareCode(strSoft_PP,strReg_PP)=True then
    Begin
     edSoftID.Visible     := False;
     edSoftHashID.Visible := False;
     //Label3.Visible       := False;
     //Label4.Visible       := False;
     Label5.Visible       := False;
     RbButton1.Visible    := False;
     RbButton2.Visible    := False;
     m_blRG               := True;
     Result               := True;
     res:=ReadRegistry('\SOFTWARE\A2K\A2KAutorization','NameComp');
     if res='' then
     begin
      Label6.Visible:=False;
      Label3.Visible:=False;
     end
      else
      begin
      Label6.Visible:=True;
      Label6.Caption:=res;
      Label3.Visible:=True;
      Label3.Font.Size:=12;
      Label3.Caption:='Зарегистрирована на :';
      end;
     res:=ReadRegistry('\SOFTWARE\A2K\A2KAutorization','DateReg');
     if res='' then
     begin
      Label10.Visible:=False;
      Label4.Visible:=False;
     end
      else
      begin
      Label10.Visible:=True;
      Label10.Caption:=res;
      Label4.Visible:=True;
      Label4.Font.Size:=12;
      Label4.Caption:='Дата регистрации      :';
      end;
    End else
    Begin
     edSoftID.Visible     := True;
     edSoftHashID.Visible := True;
     //Label3.Visible       := True;
     Label3.Font.Size:=18;
     Label3.Caption:='Код системы       :';
     //Label4.Visible       := True;
     Label4.Font.Size:=18;
     Label4.Caption:='Код регистрации:';
     Label5.Visible       := True;
     RbButton1.Visible    := True;
     RbButton2.Visible    := True;
     m_blRG               := False;
     Result               := False;
     Label6.Visible       :=False;
     Label10.Visible      :=False;
    End;
End;
function TTAbout.ReadRegistry(Key_Open, Key_Read: string): string;
var
    Registry: TRegistry;
    RegType: TRegDataType;
begin
    {$ifndef DEBUG_NO_CHECK}
    Registry := TRegistry.Create;
    try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    Registry.OpenKey(Key_Open, True);
    RegType:=Registry.GetDataType(Key_Read);
    if RegType<>rdString then Registry.DeleteValue(Key_Read);
    Result := Registry.ReadString(Key_Read);
    finally
    Registry.Free;
    end;
    {$endif}
end;
procedure TTAbout.WriteRegistry(Key_Open, Key_Read,strValue: string);
var
    Registry: TRegistry;
begin
    {$ifndef DEBUG_NO_CHECK}
    Registry := TRegistry.Create;
    try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    Registry.OpenKey(Key_Open, True);
    Registry.WriteString(Key_Read, strValue);
    finally
    Registry.Free;
    end;
    {$endif}
end;
function TTAbout.CompareCode(strCode0,strCode1:String):Boolean;
Begin
   Result := True;
   {$ifndef DEBUG_NO_CHECK}
   if strCode0<>strCode1 then
   Begin
    Result := False;
    exit;
   End;
   {$endif}
End;
procedure TTAbout.OnGenHardID(Sender: TObject);
begin
   edSoftID.Enabled     := True;
   edSoftHashID.Enabled := True;
   edSoftID.Text := Code1(GetSoftID);
end;
procedure TTAbout.OnChandgeRegKey(Sender: TObject);
begin
   RbButton1.Enabled := True;
end;
procedure TTAbout.OnCreateForm(Sender: TObject);
begin
   m_blRG := False;
end;

end.
