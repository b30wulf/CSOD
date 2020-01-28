{*******************************************************************************
   Ukrop
   03.11.11    Удалены неиспользуемые/бессмысленные Label
               cbConnectionStr.Style := csDropDownList
*******************************************************************************}
unit knsl4connfrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, ExtCtrls, Mask,  knsl4connmanager,utlconst, RbDrawCore,
  RbButton, AdvPanel,knsl5config, AdvAppStyler, ExeParams;

type
  TConnForm = class(TForm)
    AdvPanel1: TAdvPanel;
    nConnStyler1: TAdvPanelStyler;
    Label4: TLabel;
    Label5: TLabel;
    cbConnectionStr: TComboBox;
    edUser: TEdit;
    edPassword: TEdit;
    RbButton1: TRbButton;
    AdvPanel16: TAdvPanel;
    lbUserInfo: TLabel;
    AdvPanel2: TAdvPanel;
    nConnStyler: TAdvFormStyler;
    Label1: TLabel;
    lbConnnInfo: TLabel;
    procedure OnCreateForm(Sender: TObject);
    procedure OnComboChandge(Sender: TObject);
    procedure OnKeyPress(Sender: TObject; var Key: Char);
    procedure OnSetPassw(Sender: TObject);
    procedure OnClose(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    m_nConnManager    : CConnManager;
    m_blQuerryConnected  : boolean;
    function GetUser:String;
    function AutoConnect:boolean;    
    procedure Init;
    destructor Destroy; override;
  end;

var
  ConnForm: TConnForm;

implementation

uses fLogTypeCommand, utldatabase;

{$R *.DFM}
procedure TConnForm.Init;
Begin
     //m_nConnManager := CConnManager.Create;
     if m_nConnManager<>Nil then m_nConnManager.InitManager;
End;
procedure TConnForm.OnCreateForm(Sender: TObject);
begin
     {
     cbConnectionStr.Color      := KNS_COLOR;
     edUser.Color               := KNS_COLOR;
     edPassword.Color           := KNS_COLOR;
     }
     //cbConnectionStr.ControlStyle
     if m_nConnManager=Nil then m_nConnManager := CConnManager.Create;
     m_nConnManager.PConnString := @cbConnectionStr;
     m_nConnManager.PLogin      := @edUser;
     m_nConnManager.PPassword   := @edPassword;
     m_nConnManager.PConnInfo   := @lbConnnInfo;
     m_nConnManager.InitManager;
     m_nCF.m_nSetColor.PConnStyler := @nConnStyler;
     //m_nCF.m_nSetColor.SetAllStyle(m_nCF.StyleForm.ItemIndex{+1});
end;

procedure TConnForm.OnComboChandge(Sender: TObject);
begin                                               
     m_nConnManager.SelectDataSource(cbConnectionStr.ItemIndex);
end;

procedure TConnForm.OnKeyPress(Sender: TObject; var Key: Char);
begin
     if Key=#13 then
     begin
       m_blQuerryConnected := m_nConnManager.QueryConnection;
       if m_blQuerryConnected then
     Begin
      //Sleep(1000);
      IDCurrentUser:=m_pDB.GetUserID(edUser.text);
      Close;
     End;
     end;
end;

procedure TConnForm.OnSetPassw(Sender: TObject);
begin
    m_blQuerryConnected := m_nConnManager.QueryConnection;
    if m_blQuerryConnected then
    Begin
      //Sleep(1000);
      IDCurrentUser:=m_pDB.GetUserID(edUser.text);
      Close;
    End;
end;
function TConnForm.GetUser:String;
Begin
    Result := m_nConnManager.m_sLogin;
End;

procedure TConnForm.OnClose(Sender: TObject);
begin
    Close;
end;

function TConnForm.AutoConnect:boolean;
begin
  Result := False;
  if startParams.UserName <> '' then begin
    edUser.Text := startParams.UserName;
    IDCurrentUser:=m_pDB.GetUserID(edUser.text);
    edPassword.Text := startParams.Pass;
      // воткнуть сюда вызов считывания данных пользователя и перечитывание TreeView
    m_blQuerryConnected := m_nConnManager.QueryConnection;
    if m_blQuerryConnected then Begin
      OnSetPassw(Self);
      Result := True;
    End;
  end;
end;

destructor TConnForm.Destroy;
begin
  if m_nConnManager <> nil then FreeAndNil(m_nConnManager);
  inherited;
end;

end.
