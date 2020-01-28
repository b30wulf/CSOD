unit knsl5FRMSQL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, AdvGlowButton, StdCtrls, GradientLabel, ExtCtrls,utldatabase,knsl3EventBox,utltypes,utlconst,utlbox,knsl5config;

type
  TFRMSQL = class(TForm)
    Panel1: TPanel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label45: TLabel;
    GradientLabel4: TGradientLabel;
    mysqlSERVER: TEdit;
    mysqlDATABASE: TEdit;
    mysqlUSER: TEdit;
    mysqlPASSW: TEdit;
    mysqlPORT: TEdit;
    cbEnPassw: TCheckBox;
    AdvGlowButton1: TAdvGlowButton;
    MySql_ImageList: TImageList;
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbEnPasswClick(Sender: TObject);
  private
   //   m_pGenTable : SGENSETTTAG;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRMSQL: TFRMSQL;

implementation

{$R *.DFM}

procedure TFRMSQL.AdvGlowButton1Click(Sender: TObject);
begin
    with m_nCF.m_pGenTable do
    Begin
     m_SDBPORT        := StrToInt(mysqlPORT.Text);
     m_SDBSERVER      := mysqlSERVER.Text;
     m_sDBNAME        := mysqlDATABASE.Text;
     m_sDBUSR         := mysqlUSER.Text;
     m_sDBPASSW       := mysqlPASSW.Text;
     m_pDB.SetMySqlConfTable(m_nCF.m_pGenTable);
//     m_Export2My.SaveUnloadSett;
//     m_Export2My.ReInit();
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'Конфигурация MySql сохранена!');
    End;
end;

procedure TFRMSQL.FormActivate(Sender: TObject);
begin
   cbEnPassw.Checked:=True;
  if m_pDB.GetGenSettTable(m_nCF.m_pGenTable) then
    Begin
     with m_nCF.m_pGenTable do
     Begin
      mysqlPORT.Text:=IntToStr(m_SDBPORT);
      mysqlSERVER.Text:=m_SDBSERVER;
      mysqlDATABASE.Text:= m_sDBNAME;
      mysqlUSER.Text:=m_sDBUSR;
      mysqlPASSW.Text:=m_sDBPASSW;
     end;
    end
  else
 if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'Ошибка чтения конфигурации с базы!');

end;

procedure TFRMSQL.cbEnPasswClick(Sender: TObject);
begin
   if cbEnPassw.Checked=True  then mysqlPASSW.PasswordChar := #0 else
   if cbEnPassw.Checked=False then mysqlPASSW.PasswordChar := '*';
end;


end.
