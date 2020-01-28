unit knslLoadMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,utldatabase,utlconst,utltypes, StdCtrls, ComCtrls, utlbox, jpeg, knslAbout;

type
  TLoadMainForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure FormCreate(Sender: TObject);
  private
  ReportSettings: REPORT_F1;

    { Private declarations }
  public
    m_Version : String;
    { Public declarations }
  end;

var
  LoadMainForm: TLoadMainForm;
implementation

{$R *.DFM}

procedure TLoadMainForm.FormCreate(Sender: TObject);
var
  res: string;
begin
  ProgressBar1.Max := 9;
  ProgressBar1.Position:=0;
  m_Version           := FileVersion(ParamStr(0));
  label1.Caption :='версия '+ m_Version;
 // m_pDB.LoadReportParams(ReportSettings);
 // Label2.Caption := ReportSettings.m_sWorkName;
  //Label3.Caption := TKnsForm.StatusProgramm();
  if knslAbout.TAbout.CompareKey=False  then
  Begin
   Label5.Visible:=True;
   Label8.Visible:=False;
   Label9.Visible:=False;
   Label10.Visible:=False;
   Label11.Visible:=False;
  end
  else
  if knslAbout.TAbout.CompareKey=True  then
  Begin
   Label5.Visible:=False;
   res:=knslAbout.TAbout.ReadRegistry('\SOFTWARE\A2K\A2KAutorization','NameComp');
   If res='' then
   begin
    Label10.Visible:=False;
    Label8.Visible:=False;
   end
    else
    begin
     Label8.Visible:=True;
     Label10.Visible:=True;
     Label10.Caption:=res;
    end;
   res:=knslAbout.TAbout.ReadRegistry('\SOFTWARE\A2K\A2KAutorization','DateReg');
   If res='' then
   begin
    Label11.Visible:=False;
    Label9.Visible:=False;
   end
    else
    begin
     Label9.Visible:=True;
     Label10.Visible:=True;
     Label11.Caption:=res;
    end;
  end;
end;

//function StatusProgramm(state:integer):string;

end.
