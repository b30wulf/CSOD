unit knsl3AddPortForAbon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AdvPanel, StdCtrls, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers, AdvToolBar, AdvToolBarStylers, AdvAppStyler, knsl5config,
  RbDrawCore, RbButton, utltypes, utldatabase, utlconst, ImgList,knsl3indexgen,utlbox;

type
  TPortForAbon = class(TForm)
    AdvPanel3: TAdvPanel;
    AdvPanelStyler3: TAdvPanelStyler;
    AbonStyler: TAdvFormStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    Label5: TLabel;
    cb_PortType: TComboBox;
    lbPortNumb: TLabel;
    edIPPort: TEdit;
    lbIPPort: TLabel;
    edIPAdr: TEdit;
    lbIPAdr: TLabel;
    lbPortName: TLabel;
    edPortName: TEdit;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    ImageList2: TImageList;
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarButton1: TAdvToolBarButton;
    AdvToolBarButton2: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    Label3: TLabel;
    cbProtID: TComboBox;
    chbReaddr: TCheckBox;
    cbPorts: TComboBox;
    edNumPort: TEdit;
    abSaveButt: TAdvToolBarButton;
    Label4: TLabel;
    edPortID: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cb_PortTypeChange(Sender: TObject);
    procedure RbButton1Click(Sender: TObject);
    procedure AddPortBtnClick(Sender: TObject);
    procedure OnCloseAddPort(Sender: TObject);
    procedure chbReaddrClick(Sender: TObject);
    procedure OnSaveEdit(Sender: TObject);
    procedure OnCloseAdd(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    pPortTable : SL1INITITAG;
    m_strCurrentDir : String;
    m_nL1I   : CIndexGen;
    m_pL1Tbl : SL1INITITAG;
    procedure ShowSettings;
    procedure LoadDefParams;
    procedure InitComboChannel;
    function GetPortID(sPort:String):Integer;
    function IsPortExist(sName:String):Boolean;
    function IsComPortExist(nPort:Integer):Boolean;
    procedure SetChannel(blIsAdd:Boolean);
  public
    m_byUSPDType : Integer;
    m_nNewPortName : String;
    { Public declarations }
    procedure SetEditInfo(pTbl:SL1TAG);
  end;

var
  PortForAbon: TPortForAbon;

implementation

{$R *.DFM}

procedure TPortForAbon.LoadDefParams;
begin
   edPortName.Text := 'Канал';
   edNumPort.Text  := '0';
   edIPPort.Text   := '20000';
   edIPAdr.Text    := '0.0.0.0';
end;

{
//Типы протоколов
  DEV_NUL      = 0;
  DEV_MASTER   = 1;
  DEV_SLAVE    = 2;
  DEV_BTI_CLI  = 3;
  DEV_BTI_SRV  = 4;
  DEV_SQL      = 5;
  DEV_UDP_CC301= 6;
  DEV_ECOM_SRV  = 7;
  DEV_ECOM_CLI  = 8;
  DEV_C12_SRV   = 9;
  DEV_LOOP_L1   = 10;
  DEV_ECOM_SRV_CRQ = 11;
  DEV_TRANSIT   = 12;
  DEV_A2000_CLI = 13;

//Типы портов
  DEV_COM_LOC  = 0;
  DEV_COM_GSM  = 1;
  DEV_TCP_SRV  = 2;
  DEV_TCP_CLI  = 3;
  DEV_UDP_SRV  = 4;
  DEV_UDP_CLI  = 5;
  DEV_TCP_GPRS = 6;
}
procedure TPortForAbon.FormCreate(Sender: TObject);
begin
   m_nCF.m_nSetColor.PAddPortStyler := @AbonStyler;
   m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
   m_byUSPDType := 0;
   m_nNewPortName := '';
   //m_nL1I := CGenL1Index.Create(@m_blPortIndex,MAX_PORT);
   //m_nL1I.Refresh;
   //InitComboChannel;
end;

procedure TPortForAbon.ShowSettings;
begin
   if (cb_PortType.ItemIndex = 0) or (cb_PortType.ItemIndex = 1) then
   begin
     edIPPort.Enabled    := false;
     edIPAdr.Enabled     := false;
     lbIPPort.Enabled    := false;
     lbIPAdr.Enabled     := false;
     lbPortNumb.Enabled  := true;
     edNumPort.Enabled  := true;
   end
   else
   begin
     edIPPort.Enabled    := true;
     edIPAdr.Enabled     := true;
     lbIPPort.Enabled    := true;
     lbIPAdr.Enabled     := true;
     lbPortNumb.Enabled  := false;
     edNumPort.Enabled  := false;
     edNumPort.Text := '0';
   end;
end;

procedure TPortForAbon.FormShow(Sender: TObject);
begin
   if abSaveButt.Visible=False then
   Begin
    m_nNewPortName   := '';
    cb_PortType.items.loadfromfile(m_strCurrentDir+'PortType.dat');
    cb_PortType.ItemIndex := DEV_COM_GSM;
    cbProtID.items.loadfromfile(m_strCurrentDir+'TypeProt.dat');
    if m_nL1I=Nil then m_nL1I := CGenL1Index.Create(@m_blPortIndex,MAX_PORT);
    m_nL1I.Refresh;
    InitComboChannel;
    if m_byUSPDType=0 then cbProtID.ItemIndex := DEV_BTI_SRV else
    if m_byUSPDType=1 then cbProtID.ItemIndex := DEV_K2000B_CLI;
    ShowSettings;
    LoadDefParams;
   End;
end;
{
     m_nNewPortName      := edPortName.Text;
     if blIsAdd=True then pTable.m_sbyPortID  := m_nL1I.GenIndexSv else
     pTable.m_sbyPortID  := m_nL1I.GenIndexSv;
     pTable.m_schName    := edPortName.Text;
     pTable.m_sbyPortNum := StrToInt(edNumPort.Text);
     pTable.m_sbyType    := cb_PortType.ItemIndex;
     pTable.m_sbyProtID  := cbProtID.ItemIndex;
}
procedure TPortForAbon.SetEditInfo(pTbl:SL1TAG);
Begin
     cb_PortType.ItemIndex := pTbl.m_sbyType;
     cbProtID.ItemIndex    := pTbl.m_sbyProtID;
     edPortName.Text       := pTbl.m_schName;
     edIPPort.Text         := pTbl.m_swIPPort;
     edIPAdr.Text          := pTbl.m_schIPAddr;
     edNumPort.Text        := IntToStr(pTbl.m_sbyPortNum);
     chbReaddr.Checked     := Boolean(pTbl.m_sblReaddres);
     edPortID.Text         := IntToStr(pTbl.m_sbyPortID);
     abSaveButt.Visible    := True;
End;
procedure TPortForAbon.cb_PortTypeChange(Sender: TObject);
begin
   ShowSettings;
end;

procedure TPortForAbon.AddPortBtnClick(Sender: TObject);
begin
    if IsPortExist(edPortName.Text)=True then
    Begin
     MessageDlg('В системе уже есть канал с этим именем!',mtWarning,[mbOk,mbCancel],0);
     exit;
    End;
    if ((cb_PortType.ItemIndex=DEV_COM_LOC)or(cb_PortType.ItemIndex=DEV_COM_GSM)) then
    Begin
     if edNumPort.Text='' then Begin MessageDlg('COM порт не выбран!',mtWarning,[mbOk,mbCancel],0);exit;End;
     if IsComPortExist(StrToInt(edNumPort.Text))=True then
     Begin
      MessageDlg('COM порт №'+edNumPort.Text+' уже используется!',mtWarning,[mbOk,mbCancel],0);
      exit;
     End;
    End;
   SetChannel(True);
   Close;
end;
procedure TPortForAbon.SetChannel(blIsAdd:Boolean);
var
     pTable : SL1TAG;
Begin
     m_nNewPortName      := edPortName.Text;
     if blIsAdd=True then pTable.m_sbyPortID  := m_nL1I.GenIndexSv else
     pTable.m_sbyPortID  := StrToInt(edPortID.Text);
     pTable.m_schName    := edPortName.Text;
     pTable.m_sbyPortNum := StrToInt(edNumPort.Text);
     pTable.m_sbyType    := cb_PortType.ItemIndex;
     pTable.m_sbyProtID  := cbProtID.ItemIndex;
     pTable.m_sbyControl := 0;
     pTable.m_sbyKTRout  := 0;
     pTable.m_sbySpeed   := 2;
     pTable.m_sbyParity  := 0;
     pTable.m_sbyData    := 1;
     pTable.m_sbyStop    := 0;
     pTable.m_swDelayTime:= 300;
     pTable.m_swAddres   := 0;
     pTable.m_sblReaddres:= 0;
     if chbReaddr.Checked=True then
     Begin
      pTable.m_swAddres   := GetPortID(cbPorts.Text);
      pTable.m_sblReaddres:= 1;
     End;
     pTable.m_schPhone   := '80172305898';
     pTable.m_swIPPort   := edIPPort.Text;
     pTable.m_schIPAddr  := edIPAdr.Text;
     pTable.m_nFreePort  := 0;
     m_pDB.AddPortTable(pTable);
     m_pDB.GetL1Table(m_pL1Tbl);
End;
//AddPortBtnClick
procedure TPortForAbon.RbButton1Click(Sender: TObject);
begin
   m_nNewPortName   := '';
   abSaveButt.Visible := False;
   Close;
end;

procedure TPortForAbon.OnCloseAddPort(Sender: TObject);
begin
    m_nNewPortName   := '';
    abSaveButt.Visible := False;
    //m_nL1I.Destroy;
end;
procedure TPortForAbon.InitComboChannel;
Var
    i : Integer;
Begin
    cbPorts.Items.Clear;
    if m_pDB.GetL1Table(m_pL1Tbl) then
    Begin
     for i:=0 to m_pL1Tbl.Count-1 do
     Begin
      if not((m_pL1Tbl.Items[i].m_sblReaddres<>0)or(m_pL1Tbl.Items[i].m_sbyControl=1)) then
      cbPorts.Items.Add(m_pL1Tbl.Items[i].m_schName);
     End;
     cbPorts.ItemIndex := 0;
    End;
End;
function TPortForAbon.GetPortID(sPort:String):Integer;
Var
    i : Integer;
Begin
    Result := 0;
    for i:=0 to m_pL1Tbl.Count-1 do
    if m_pL1Tbl.Items[i].m_schName=sPort then
    Begin
     Result := m_pL1Tbl.Items[i].m_sbyPortID;
     exit;
    End;
End;
procedure TPortForAbon.chbReaddrClick(Sender: TObject);
begin
     cbPorts.Enabled   := (Sender as TCheckBox).Checked;
     edNumPort.Enabled := not(Sender as TCheckBox).Checked;
     edNumPort.Text    := '0';
end;
function TPortForAbon.IsPortExist(sName:String):Boolean;
Var
    i : Integer;
Begin
    Result := False;
    for i:=0 to m_pL1Tbl.Count-1 do
    if m_pL1Tbl.Items[i].m_schName=sName then
    Begin
     Result := True;
     exit;
    End;
End;
function TPortForAbon.IsComPortExist(nPort:Integer):Boolean;
Var
    i : Integer;
Begin
    Result := False;
    for i:=0 to m_pL1Tbl.Count-1 do
    if ((m_pL1Tbl.Items[i].m_sbyType=DEV_COM_LOC)or(m_pL1Tbl.Items[i].m_sbyType=DEV_COM_GSM))and
        (m_pL1Tbl.Items[i].m_sblReaddres=0)and(m_pL1Tbl.Items[i].m_sbyPortNum=nPort) then
    Begin
     Result := True;
     exit;
    End;
End;


procedure TPortForAbon.OnSaveEdit(Sender: TObject);
begin
    if MessageDlg('Сохранить изменения?',mtWarning,[mbOk,mbCancel],0)=mrOK then 
    SetChannel(False);
end;

procedure TPortForAbon.OnCloseAdd(Sender: TObject;
  var Action: TCloseAction);
begin
    //m_nNewPortName   := '';
    abSaveButt.Visible := False;
end;

end.
