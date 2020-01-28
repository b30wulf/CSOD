unit OpcSrvAddNode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,bnrbox,
  StdCtrls, Spin, Mask, jpeg, ExtCtrls, ComCtrls, RbDrawCore, RbButton;

type
  TfrmKpAddNode = class(TForm)
    pgSet: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    edKPName: TEdit;
    seAmCallPU: TSpinEdit;
    seSetChannPU: TSpinEdit;
    seCallPeriodPU: TSpinEdit;
    seQryPeriodPU: TSpinEdit;
    chAutoQryPU: TCheckBox;
    chClearBuffPU: TCheckBox;
    chSetForeverPU: TCheckBox;
    edDirID: TEdit;
    seAmTI: TSpinEdit;
    seAmTS: TSpinEdit;
    seAmTU: TSpinEdit;
    sewTimeUnload: TSpinEdit;
    cbTUTime: TComboBox;
    edPassword: TEdit;
    cbLSPort: TComboBox;
    edKPPhone: TMaskEdit;
    Label32: TLabel;
    Image1: TImage;
    Image2: TImage;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label1: TLabel;
    RbButton25: TRbButton;
    RbButton1: TRbButton;
    Label2: TLabel;
    procedure OnCreateNode(Sender: TObject);
    procedure OnDropDw(Sender: TObject);
  private
    { Private declarations }
    FOnCreateNode : TCreateNode;
  public
    { Public declarations }
    m_blEdit : Boolean;
    property POnCreateNode : TCreateNode  read FOnCreateNode  write FOnCreateNode;
  end;

var
  frmKpAddNode: TfrmKpAddNode;

implementation

{$R *.DFM}

procedure TfrmKpAddNode.OnCreateNode(Sender: TObject);
begin
    try
    if Assigned(POnCreateNode) then POnCreateNode(Sender);
    except
    end; 
end;

procedure TfrmKpAddNode.OnDropDw(Sender: TObject);
var
  i: Integer;
  FPHandle : THandle;
begin
  cbLSPort.Clear;
  for i := 1 to 20 do
  Begin
   FPHandle := CreateFile(PChar('\\.\Com' + IntToStr(i)), GENERIC_READ or GENERIC_WRITE, 0 , nil, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
   if (FPHandle<>INVALID_HANDLE_VALUE) then
    Begin
     cbLSPort.Items.Add('COM' + IntToStr(i));
     CloseHandle(FPHandle);
    End;
   End;
  cbLSPort.Text := cbLSPort.Items[0];
end;

end.
