unit knsl3LightControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, Spin, utlbox, AdvPanel, ExtCtrls, AdvAppStyler, knsl5SetColor,
  knsl5config, AdvGlowButton, utltypes, utlconst, utldatabase, ImgList;

type
  TLightControlForm = class(TForm)
    AdvPanel1: TAdvPanel;
    gLite1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    seDLightOnH: TSpinEdit;
    seDLightOnM: TSpinEdit;
    seDLightOffH: TSpinEdit;
    seDLightOffM: TSpinEdit;
    chAutoDLight: TCheckBox;
    gLite2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    seR1LightOnH: TSpinEdit;
    seR1LightOnM: TSpinEdit;
    seR1LightOffH: TSpinEdit;
    seR1LightOffM: TSpinEdit;
    chAutoR1Light: TCheckBox;
    gLite3: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    seR2LightOnH: TSpinEdit;
    seR2LightOnM: TSpinEdit;
    seR2LightOffH: TSpinEdit;
    seR2LightOffM: TSpinEdit;
    AdvPanelStyler1: TAdvPanelStyler;
    LightStyler: TAdvFormStyler;
    btnApplyChange: TAdvGlowButton;
    btnCloseForm: TAdvGlowButton;
    swDezur: TCheckBox;
    swRab: TCheckBox;
    procedure btnCloseFormClick(Sender: TObject);
    procedure btnSetTimeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    mPortID : Integer;
    mObjID  : Integer;
    m_nTxMsg: CHMessage;
    procedure LoadLightValue;
    procedure SetLightValue;
    procedure SetGlobalValue;
    procedure CreateMSGAndPUTToL1;
    procedure SetLightInfoInOutArray(var buf : array of byte);
    procedure FillMessageHead(var pMsg : CHMessage; length : word);
    Function  ByteToBCD(DIn : Byte):Byte;
  public
    { Public declarations }
  end;

var
  LightControlForm: TLightControlForm;

implementation

{$R *.DFM}

procedure TLightControlForm.FormCreate(Sender: TObject);
begin
   m_nCF.m_nSetColor.PLightStyler :=  @LightStyler;
end;

procedure TLightControlForm.FormShow(Sender: TObject);
begin
   mPortID := -1;
   m_pDB.GetFirstEntasNetPIDAndMID(mPortID, mObjID);
   LoadLightValue;
end;

procedure TLightControlForm.btnCloseFormClick(Sender: TObject);
begin
   Close;
end;

procedure TLightControlForm.btnSetTimeClick(Sender: TObject);
begin
   if (seDLightOnH.Value < 0) or (seDLightOnH.Value > 23) or
      (seDLightOnM.Value < 0) or (seDLightOnM.Value > 59) or
      (seDLightOffH.Value < 0) or (seDLightOffH.Value > 23) or
      (seDLightOffM.Value < 0) or (seDLightOffM.Value > 59) or
      (seR1LightOnH.Value < 0) or (seR1LightOnH.Value > 23) or
      (seR1LightOnM.Value < 0) or (seR1LightOnM.Value > 59) or
      (seR1LightOffH.Value < 0) or (seR1LightOffH.Value > 23) or
      (seR1LightOffM.Value < 0) or (seR1LightOffM.Value > 59) or
      (seR2LightOnH.Value < 0) or (seR2LightOnH.Value > 23) or
      (seR2LightOnM.Value < 0) or (seR2LightOnM.Value > 59) or
      (seR2LightOffH.Value < 0) or (seR2LightOffH.Value > 23) or
      (seR2LightOffM.Value < 0) or (seR2LightOffM.Value > 59) then
   begin
     MessageDlg('¬ведены неправильные данные!',mtWarning,[mbOk],0);
     LoadLightValue;
   end
   else
   begin
     SetLightValue;
     //Close;
   end;
end;

procedure TLightControlForm.LoadLightValue;
begin
   seDLightOnH.Value := m_nLightInfo.m_nHDOn;
   seDLightOnM.Value := m_nLightInfo.m_nMDOn;
   seDLightOffH.Value := m_nLightInfo.m_nHDOff;
   seDLightOffM.Value := m_nLightInfo.m_nMDOff;
   seR1LightOnH.Value := m_nLightInfo.m_nHR1On;
   seR1LightOnM.Value := m_nLightInfo.m_nMR1On;
   seR1LightOffH.Value := m_nLightInfo.m_nHR1Off;
   seR1LightOffM.Value := m_nLightInfo.m_nMR1Off;
   seR2LightOnH.Value := m_nLightInfo.m_nHR2On;
   seR2LightOnM.Value := m_nLightInfo.m_nMR2On;
   seR2LightOffH.Value := m_nLightInfo.m_nHR2Off;
   seR2LightOffM.Value := m_nLightInfo.m_nMR2Off;
   chAutoDLight.Checked := m_nLightInfo.m_nDAuto;
   chAutoR1Light.Checked := m_nLightInfo.m_nR1Auto;
   swDezur.Checked := m_nLightInfo.m_nDChecked;
   swDezur.Enabled := m_nLightInfo.m_nDCHange;
   swRab.Checked := m_nLightInfo.m_nR1Checked;
   swRab.Enabled := m_nLightInfo.m_nR1CHange;
end;

procedure TLightControlForm.SetGlobalValue;
begin
   m_nLightInfo.m_nHDOn := seDLightOnH.Value;
   m_nLightInfo.m_nMDOn := seDLightOnM.Value;
   m_nLightInfo.m_nHDOff := seDLightOffH.Value;
   m_nLightInfo.m_nMDOff := seDLightOffM.Value;
   m_nLightInfo.m_nHR1On := seR1LightOnH.Value;
   m_nLightInfo.m_nMR1On := seR1LightOnM.Value;
   m_nLightInfo.m_nHR1Off := seR1LightOffH.Value;
   m_nLightInfo.m_nMR1Off := seR1LightOffM.Value;
   m_nLightInfo.m_nHR2On := seR2LightOnH.Value;
   m_nLightInfo.m_nMR2On := seR2LightOnM.Value;
   m_nLightInfo.m_nHR2Off := seR2LightOffH.Value;
   m_nLightInfo.m_nMR2Off := seR2LightOffM.Value;
   m_nLightInfo.m_nDAuto := chAutoDLight.Checked;
   m_nLightInfo.m_nR1Auto := chAutoR1Light.Checked;
   m_nLightInfo.m_nDChecked := swDezur.Checked;
   m_nLightInfo.m_nDCHange := swDezur.Enabled;
   m_nLightInfo.m_nR1Checked := swRab.Checked;
   m_nLightInfo.m_nR1CHange := swRab.Enabled;
end;

procedure TLightControlForm.SetLightValue;
begin
   SetGlobalValue;
   if (mPortID <> -1) then
     CreateMSGAndPUTToL1;
end;

procedure TLightControlForm.CreateMSGAndPUTToL1;
var CRC, i : integer;
begin
   m_nTxMsg.m_sbyInfo[0] := $10;
   m_nTxMsg.m_sbyInfo[1] := 22;
   m_nTxMsg.m_sbyInfo[2] := 23;
   m_nTxMsg.m_sbyInfo[3] := 0;
   m_nTxMsg.m_sbyInfo[4] := 20;
   m_nTxMsg.m_sbyInfo[5] := 15;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 20;
   SetLightInfoInOutArray(m_nTxMsg.m_sbyInfo);
   CRC := $10;
   for i := 1 to 22 do
     CRC :=  CRC + m_nTxMsg.m_sbyInfo[i];
   m_nTxMsg.m_sbyInfo[23] := $10;
   m_nTxMsg.m_sbyInfo[24] := 3;
   m_nTxMsg.m_sbyInfo[25] := CRC mod $100;
   if (m_nTxMsg.m_sbyInfo[25] = 16) then
   begin
     m_nTxMsg.m_sbyInfo[25] := 17;
     m_nTxMsg.m_sbyInfo[5] := m_nTxMsg.m_sbyInfo[5] + 1;
   end;
   FillMessageHead(m_nTxMsg, 26);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure TLightControlForm.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := mObjID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := mPortID;
   pMsg.m_sbyIntID      := mPortID;
   pMsg.m_sbyServerID   := MET_ENTASNET;
   pMsg.m_sbyDirID      := 0;
end;

Function TLightControlForm.ByteToBCD ( DIn : Byte):Byte;
begin
  While DIn >= 100 do DIn := DIn - 100;
  result := ((DIn Div 10) Shl 4) + (DIn Mod 10);
end;
{

   m_nLightInfo.m_nR1Auto := chAutoR1Light.Checked;
   m_nLightInfo.m_nR1Checked := chStartR1Light.Checked;

   m_nLightInfo.m_nR2Auto := chAutoR2Light.Checked;
   m_nLightInfo.m_nR2Checked       }
procedure TLightControlForm.SetLightInfoInOutArray(var buf : array of byte);
begin
   m_nTxMsg.m_sbyInfo[8]  := ByteToBcd(Byte(m_nLightInfo.m_nHDOn));
   m_nTxMsg.m_sbyInfo[9]  := ByteToBcd(Byte(m_nLightInfo.m_nMDOn));
   m_nTxMsg.m_sbyInfo[10] := ByteToBcd(Byte(m_nLightInfo.m_nHDOff));
   m_nTxMsg.m_sbyInfo[11] := ByteToBcd(Byte(m_nLightInfo.m_nMDOff));

   if (m_nLightInfo.m_nDAuto) then
     if (m_nLightInfo.m_nDChecked) then
       m_nTxMsg.m_sbyInfo[12] := ByteToBcd(Byte(3))
     else
       m_nTxMsg.m_sbyInfo[12] := ByteToBcd(Byte(1))
   else
     if (m_nLightInfo.m_nDChecked) then
       m_nTxMsg.m_sbyInfo[12] := ByteToBcd(Byte(2))
     else
       m_nTxMsg.m_sbyInfo[12] := ByteToBcd(Byte(0));

   m_nTxMsg.m_sbyInfo[13] := ByteToBcd(Byte(m_nLightInfo.m_nHR1On));
   m_nTxMsg.m_sbyInfo[14] := ByteToBcd(Byte(m_nLightInfo.m_nMR1On));
   m_nTxMsg.m_sbyInfo[15] := ByteToBcd(Byte(m_nLightInfo.m_nHR1Off));
   m_nTxMsg.m_sbyInfo[16] := ByteToBcd(Byte(m_nLightInfo.m_nMR1Off));

   if (m_nLightInfo.m_nR1Auto) then
     if (m_nLightInfo.m_nR1Checked) then
     begin
       m_nTxMsg.m_sbyInfo[17] := ByteToBcd(Byte(3));
       m_nTxMsg.m_sbyInfo[22] := ByteToBcd(Byte(3));
     end
     else
     begin
       m_nTxMsg.m_sbyInfo[17] := ByteToBcd(Byte(1));
       m_nTxMsg.m_sbyInfo[22] := ByteToBcd(Byte(1));
     end
   else
     if (m_nLightInfo.m_nR1Checked) then
     begin
       m_nTxMsg.m_sbyInfo[17] := ByteToBcd(Byte(2));
       m_nTxMsg.m_sbyInfo[22] := ByteToBcd(Byte(2));
     end
     else
     begin
       m_nTxMsg.m_sbyInfo[17] := ByteToBcd(Byte(0));
       m_nTxMsg.m_sbyInfo[22] := ByteToBcd(Byte(0));
     end;

   m_nTxMsg.m_sbyInfo[18] := ByteToBcd(Byte(m_nLightInfo.m_nHR2On));
   m_nTxMsg.m_sbyInfo[19] := ByteToBcd(Byte(m_nLightInfo.m_nMR2On));
   m_nTxMsg.m_sbyInfo[20] := ByteToBcd(Byte(m_nLightInfo.m_nHR2Off));
   m_nTxMsg.m_sbyInfo[21] := ByteToBcd(Byte(m_nLightInfo.m_nMR2Off));
end;

end.

