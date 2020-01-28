unit uEdUser;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

type
  TFrmUsEd = class(TForm)
    SpeedButton1: TSpeedButton;
    EdUName: TEdit;
    EdUPass: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    SpeedButton2: TSpeedButton;
    EdUpass2: TEdit;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    procedure RadioButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Edited:boolean;
  end;

var
  FrmUsEd: TFrmUsEd;

implementation

{$R *.DFM}

procedure TFrmUsEd.RadioButton1Click(Sender: TObject);
begin
     if (Sender as TRadioButton).Checked then tag:=(Sender as TRadioButton).tag;
end;

procedure TFrmUsEd.SpeedButton2Click(Sender: TObject);
begin
     Edited:=false;
     Close;
end;

procedure TFrmUsEd.SpeedButton1Click(Sender: TObject);
begin
     if (EdUName.Text = '') then begin
        ShowMessage('Не введено имя пользователя');
        exit;
     end;
     if (CheckBox1.Checked and ((EdUPass.Text='')or(EdUPass2.Text=''))) then begin
        ShowMessage('Не введен пароль');
        exit;
     end;
     if CheckBox1.Checked and (EdUPass.Text<> EdUPass2.Text) then begin
        ShowMessage('Не совпадают пароль1 и пароль2');
        EdUPass.Text:='';
        EdUPass2.Text:='';
        exit;
     end;
     Edited:=true;
     close;
end;

procedure TFrmUsEd.FormShow(Sender: TObject);
begin
     Edited:=false;
     case Tag of
       1: RadioButton2.Checked:=true;
       3: RadioButton3.Checked:=true;
       7: RadioButton4.Checked:=true;
     else RadioButton1.Checked:=true;
     end;
end;

procedure TFrmUsEd.CheckBox1Click(Sender: TObject);
begin
     EdUPass.Enabled:= CheckBox1.Checked;
     EdUPass2.Enabled:= CheckBox1.Checked;
end;

end.
