unit knslLoadMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,utldatabase,utlconst,utltypes, StdCtrls, ComCtrls, utlbox;

type
  TLoadMainForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ProgressBar1: TProgressBar;
    lbl_CPUID: TLabel;
    procedure FormCreate(Sender: TObject);
    function GetCPUID():string;
  private
  ReportSettings: REPORT_F1;

    { Private declarations }
  public
    m_Version : String;
    m_CPUID   : String;
    { Public declarations }
  end;

var
  LoadMainForm: TLoadMainForm;

implementation

{$R *.DFM}

procedure TLoadMainForm.FormCreate(Sender: TObject);
begin
  ProgressBar1.Max := 9;
  ProgressBar1.Position:=0;
  m_Version           := FileVersion(ParamStr(0));
  label1.Caption := m_Version;
  lbl_CPUID.Caption := GetCPUID();
 // m_pDB.LoadReportParams(ReportSettings);
//                Label2.Caption := ReportSettings.m_sWorkName;
  //Label3.Caption := TKnsForm.StatusProgramm();
end;

//function StatusProgramm(state:integer):string;

function TLoadMainForm.GetCPUID:string;
  function CPUID : longint; assembler; register;
  var
    temp:longint;
  begin
    asm
      push ebx
      push edi
      mov  edi,eax
      mov  eax,1
      dw   $a20f
      mov  temp,edx
      pop  edi
      pop  ebx
    end; 
    result:=temp; 
  end; 
begin 
  result:=inttohex(cpuid,8); 
end;

end.
