unit knsl3HideCtrlFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AdvPanel, ExtCtrls, AdvOfficeButtons, StdCtrls, AdvEdit, AdvGlowButton,
  AdvAppStyler,knsl5config,utlconst,utlbox,utltypes,knsl5tracer,
  AdvGroupBox,inifiles,utldatabase;

type
  THideCtrlFrame = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanelStyler1: TAdvPanelStyler;
    cbInitL1: TAdvOfficeCheckBox;
    cbInitL2: TAdvOfficeCheckBox;
    cbInitL3: TAdvOfficeCheckBox;
    cbReloadMeters: TAdvOfficeCheckBox;
    cbPackBase: TAdvOfficeCheckBox;
    cbSchedInit: TAdvOfficeCheckBox;
    cbSchedGo: TAdvOfficeCheckBox;
    cbSchedPause: TAdvOfficeCheckBox;
    cbInstTimeLabel: TAdvOfficeCheckBox;
    cbOffModuleTurn: TAdvOfficeCheckBox;
    cbSetSmartFinder: TAdvOfficeCheckBox;
    cbSetIsOneSynchro: TAdvOfficeCheckBox;
    cbReload15Min: TAdvOfficeCheckBox;
    cbSelfStop: TAdvOfficeCheckBox;
    cbEnternetConn: TAdvOfficeCheckBox;
    cbSetUpdateFnc: TAdvOfficeCheckBox;
    cbReload: TAdvOfficeCheckBox;
    cbSetCountOfEv: TAdvOfficeCheckBox;
    cbRunSQLInn: TAdvOfficeCheckBox;
    cbRunModemStr: TAdvOfficeCheckBox;
    edTimeLabel: TAdvEdit;
    cbOpenSesTime: TComboBox;
    edCountOfEv: TAdvEdit;
    btnInitL1: TAdvGlowButton;
    btnInitL2: TAdvGlowButton;
    btnInitL3: TAdvGlowButton;
    btnReloadMeters: TAdvGlowButton;
    btnPackBase: TAdvGlowButton;
    btnSchedInit: TAdvGlowButton;
    btnSchedGo: TAdvGlowButton;
    btnSchedPause: TAdvGlowButton;
    btnInstTimeLabel: TAdvGlowButton;
    btnOffModuleTurn: TAdvGlowButton;
    btnSetSmartFinder: TAdvGlowButton;
    btnSetIsOneSynchro: TAdvGlowButton;
    btnReload15Min: TAdvGlowButton;
    btnSelfStop: TAdvGlowButton;
    btnEnternetConn: TAdvGlowButton;
    btnSetUpdateFnc: TAdvGlowButton;
    btnReload: TAdvGlowButton;
    btnSetCountOfEv: TAdvGlowButton;
    btnRunSQLInn: TAdvGlowButton;
    btnRunModemStr: TAdvGlowButton;
    HideCtrlFrameStyler: TAdvFormStyler;
    AdvOfficeCheckGroup1: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup2: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup3: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup4: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup5: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup6: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup7: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup8: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup9: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup10: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup11: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup12: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup13: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup14: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup15: TAdvOfficeCheckGroup;
    Label1: TLabel;
    edPortID: TAdvEdit;
    btBrandOn: TAdvGlowButton;
    cbBrandOn: TAdvOfficeCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    cbm_sChannSyn: TComboBox;
    Label4: TLabel;
    chProtokol: TAdvOfficeCheckBox;
    chRdpOn: TAdvOfficeCheckBox;
    btRdpOn: TAdvGlowButton;
    chNoLock: TAdvOfficeCheckBox;
    btNoLock: TAdvGlowButton;
    AdvOfficeCheckGroup16: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup17: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup18: TAdvOfficeCheckGroup;
    AdvOfficeCheckGroup19: TAdvOfficeCheckGroup;
    chUpdArm: TAdvOfficeCheckBox;
    btUpdArm: TAdvGlowButton;
    chStartAmmy: TAdvOfficeCheckBox;
    btStartAmmy: TAdvGlowButton;
    chRebootUspd: TAdvOfficeCheckBox;
    btRebootUspd: TAdvGlowButton;
    chRunUSPD: TAdvOfficeCheckBox;
    btRunUSPD: TAdvGlowButton;
    chC12: TAdvOfficeCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edPortIDChang(Sender: TObject);
    procedure btnInitL1Click(Sender: TObject);
    procedure btnInitL2Click(Sender: TObject);
    procedure btnReloadMetersClick(Sender: TObject);
    procedure btnPackBaseClick(Sender: TObject);
    procedure btnInitL3Click(Sender: TObject);
    procedure btnSchedInitClick(Sender: TObject);
    procedure btnSchedGoClick(Sender: TObject);
    procedure btnSchedPauseClick(Sender: TObject);
    procedure btnSetIsOneSynchroClick(Sender: TObject);
    procedure btnReload15MinClick(Sender: TObject);
    procedure btnSelfStopClick(Sender: TObject);
    procedure btnReloadClick(Sender: TObject);
    procedure btnRunSQLInnClick(Sender: TObject);
    procedure btnEnternetConnClick(Sender: TObject);
    procedure btnSetSmartFinderClick(Sender: TObject);
    procedure btnSetUpdateFncClick(Sender: TObject);
    procedure btnSetCountOfEvClick(Sender: TObject);
    procedure btnInstTimeLabelClick(Sender: TObject);
    procedure btnOffModuleTurnClick(Sender: TObject);
    procedure btBrandOnClick(Sender: TObject);
    procedure cbm_sChannSynDropDown(Sender: TObject);
    procedure chProtokolClick(Sender: TObject);
    procedure OnFClose(Sender: TObject; var Action: TCloseAction);
    procedure btRdpOnClick(Sender: TObject);
    procedure btNoLockClick(Sender: TObject);
    procedure btUpdArmClick(Sender: TObject);
    procedure btStartAmmyClick(Sender: TObject);
    procedure btRebootUspdClick(Sender: TObject);
    procedure btRunUSPDClick(Sender: TObject);
  private
    { Private declarations }
    FPRID : Integer;
    //procedure SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
    m_svCrc : Boolean;
    m_svEko : Boolean;
    m_svC12 : Boolean;
    procedure InitComboChannel;
    function  GetRealPort(nPort:Integer):Integer;
    procedure SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
    procedure SendQryBoolInit(nFCrcRb,nFEkom,nInnerF:Integer;nParam:Integer);
    procedure SendQryIntInit(nFCrcRb,nFEkom,nInnerF:Integer;nParam:Integer);

  public
    { Public declarations }
  end;

var
  HideCtrlFrame: THideCtrlFrame;

implementation

{$R *.DFM}

procedure THideCtrlFrame.FormCreate(Sender: TObject);
begin
   m_nCF.m_nSetColor.PHideCtrlFrStyle := @HideCtrlFrameStyler;
   cbOpenSesTime.ItemIndex := 0;
   FPRID := StrToInt(edPortID.Text);
   m_svCrc := m_blIsRemCrc;
   m_svEko := m_blIsRemEco;
   m_svC12 := m_blIsRemC12;
end;

{case cbOpenSessionTime.ItemIndex of
       0 : sec := 60;
       1 : sec := 120;
       2 : sec := 300;
       3 : sec := 600;
       4 : sec := 1800;
       5 : sec := 3600;
       6 : sec := 7200;
       else
       sec := 180;}

{if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SendRemCrcQry(0,pDS);exit; End;}
procedure THideCtrlFrame.SendQryBoolInit(nFCrcRb,nFEkom,nInnerF:Integer;nParam:Integer);
Var
    m_nTxMsg : CMessage;
    fnc,wCRC:Word;
    //FPRID    : integer;
Begin
    if MessageDlg(
    'INIT::> FCRC:'+IntToHex(nFCrcRb,4)+
    ' FEKO:'+IntToStr(nFEkom)+
    ' FINN:'+IntToStr(nInnerF)+
    ' PARM:'+IntToStr(nParam),mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
     m_nTxMsg.m_sbyInfo[6] := nInnerF; //10
     m_nTxMsg.m_sbyInfo[7] := nParam;
     if m_blIsRemCrc=True then
     Begin
      CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+16+1)+4, nFCrcRb);
      CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (26+16+1)+4);
     End else
     if m_blIsRemEco=True then
     Begin
      m_nTxMsg.m_sbyInfo[0] := 1;
      m_nTxMsg.m_sbyInfo[1] := nFEkom;
      wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26+16);
      m_nTxMsg.m_sbyInfo[26+16] := Lo(wCRC);
      m_nTxMsg.m_sbyInfo[26+16+1] := Hi(wCRC);
      CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (26+16+2));
     End;
     if m_blIsRemC12=True then
     Begin
      m_nTxMsg.m_sbyInfo[0] := 1;
      m_nTxMsg.m_sbyInfo[1] := $FA;
      m_nTxMsg.m_sbyInfo[2] := nFEkom;
      CRC_C12(m_nTxMsg.m_sbyInfo[0], 26+16+2);
      CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (26+16+2));
     End;
     {
     if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
     begin
       //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
       exit;
     end;
     fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
     }
     TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:',@m_nTxMsg);
     FPUT(BOX_L1, @m_nTxMsg);
    End;
End;
procedure THideCtrlFrame.InitComboChannel;
Var
    pTable : SL1INITITAG;
    i      : Integer;
Begin
    cbm_sChannSyn.Items.Clear;
    if m_pDB.GetL1Table(pTable) then
    Begin
     for i:=0 to pTable.Count-1 do
     cbm_sChannSyn.Items.Add(IntToStr(pTable.Items[i].m_sbyPortID)+':'+pTable.Items[i].m_schName);
     cbm_sChannSyn.ItemIndex := 0;
    End;
End;
procedure THideCtrlFrame.SendQryIntInit(nFCrcRb,nFEkom,nInnerF:Integer;nParam:Integer);
Var
    m_nTxMsg : CMessage;
    fnc,wCRC:Word;
    //FPRID    : integer;
Begin
    if MessageDlg(
    'INIT::> FCRC:'+IntToHex(nFCrcRb,4)+
    ' FEKO:'+IntToHex(nFEkom,4)+
    ' FINN:'+IntToStr(nInnerF)+
    ' PARM:'+IntToStr(nParam),mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
     m_nTxMsg.m_sbyInfo[6] := nInnerF; //10
     move(nParam,m_nTxMsg.m_sbyInfo[7],4);
     if m_blIsRemCrc=True then
     Begin
      CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+16+1)+4, nFCrcRb);
      CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (26+16+1)+4);
     End else
     if m_blIsRemEco=True then
     Begin
      m_nTxMsg.m_sbyInfo[0] := 1;
      m_nTxMsg.m_sbyInfo[1] := nFEkom;
      wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26+16);
      m_nTxMsg.m_sbyInfo[26+16] := Lo(wCRC);
      m_nTxMsg.m_sbyInfo[26+16+1] := Hi(wCRC);
      CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (26+16+2));
     End;
     if m_blIsRemC12=True then
     Begin
      m_nTxMsg.m_sbyInfo[0] := 1;
      m_nTxMsg.m_sbyInfo[1] := $FA;
      m_nTxMsg.m_sbyInfo[2] := nFEkom;
      CRC_C12(m_nTxMsg.m_sbyInfo[0], 26+16+2);
      CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (26+16+2));
     End;
     {
     if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
     begin
       //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
       exit;
     end;
     fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
     }
     TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:',@m_nTxMsg);
     FPUT(BOX_L1, @m_nTxMsg);
    End;
End;
procedure THideCtrlFrame.SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
Var
    m_nTxMsg : CMessage;
    fnc,wCRC:Word;
Begin
    FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
    move(pDS.m_swData0,m_nTxMsg.m_sbyInfo[6], 4);
    move(pDS.m_swData1,m_nTxMsg.m_sbyInfo[10],4);
    move(pDS.m_swData2,m_nTxMsg.m_sbyInfo[14],4);
    move(pDS.m_swData3,m_nTxMsg.m_sbyInfo[18],4);
    move(pDS.m_sbyInfo[0],m_nTxMsg.m_sbyInfo[26],sizeof(TDateTime)*2);
    if m_blIsRemCrc=True then
    Begin
     CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+16+1)+4, $FF18);
     CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (26+16+1)+4);
    End else
    if m_blIsRemEco=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := 213;
     wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26+16);
     m_nTxMsg.m_sbyInfo[26+16] := Lo(wCRC);
     m_nTxMsg.m_sbyInfo[26+16+1] := Hi(wCRC);
     CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (26+16+2));
    End;
    if m_blIsRemC12=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := $FA;
     m_nTxMsg.m_sbyInfo[2] := 213;
     CRC_C12(m_nTxMsg.m_sbyInfo[0], 26+16+2);
     CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (26+16+2));
    End;

    {
    if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
    begin
      //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
      exit;
    end;
    fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
    }
    TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:',@m_nTxMsg);
    FPUT(BOX_L1, @m_nTxMsg);
End;
{
   case pMsg.m_sbyInfo[6] of
        0 : mL1Module.Init;         //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL1_REQ,pDS);
        1 : mL2Module.Init;         //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL2_REQ,pDS);
        2 : mL3Module.OnLoadVMeters;//SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL3_REQ,pDS);
        3 : m_nCF.SetGenSettings;
        4 : SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_SAVE_DB_REQ,pDS);
        5 : m_nCF.SchedInit;
        6 : m_nCF.SchedGo;
        7 : m_nCF.SchedPause;
        8 : Begin Move(pMsg.m_sbyInfo[7],pDS.m_swData1,4); m_nST.SetDTime(pDS.m_swData1);End;
        9 : m_nST.SetState(pMsg.m_sbyInfo[7]);
        10 : Begin
              m_nSmartFinder := pMsg.m_sbyInfo[7];
              m_nCF.SetSettIntValue('m_nSmartFinder',pMsg.m_sbyInfo[7]);
             End;
        11 : Begin
              m_nIsOneSynchro := pMsg.m_sbyInfo[7];
              m_nCF.SetSettIntValue('m_nIsOneSynchro',pMsg.m_sbyInfo[7]);
             End;
        12 : m_nQweryReboot := 1; //Запрос перезагрузки
        13 : m_nCF.SelfStop;
        14 : Begin
              Move(pMsg.m_sbyInfo[10],InnerPDS.m_swData1,4);//Time
              Move(pMsg.m_sbyInfo[14],InnerPDS.m_swData2,4);//Speed
              InnerFunctionPr := 14;
              m_nRepTimer.OnTimer(45);
             End;
        15 : Begin
              m_nUpdateFunction := pMsg.m_sbyInfo[7];
              m_nCF.SetSettIntValue('m_nUpdateFunction',pMsg.m_sbyInfo[7]);
             End;
        16:  Begin
              if pMsg.m_sbyInfo[7]=0 then pDS.m_swData4 := MTR_LOCAL else
              if pMsg.m_sbyInfo[7]=1 then pDS.m_swData4 := MTR_REMOTE;
              SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RELOAD_USPRO_REQ,pDS);
             End;
        17 : Begin
              move(pMsg.m_sbyInfo[7], m_nCountOfEvents, 4);
              m_nCF.SetSettIntValue('m_nCountOfEvents',m_nCountOfEvents);
             End;

}
procedure THideCtrlFrame.edPortIDChang(Sender: TObject);
begin
     if (edPortID.Text<>'') then
     Begin
      FPRID := StrToInt(edPortID.Text);
      m_nCtrlObjID  := m_pDB.GetFirstObjFromPort(GetRealPort(FPRID));
     End;
end;
function THideCtrlFrame.GetRealPort(nPort:Integer):Integer;
Var
    i : Integer;
    m_sTblL1 : SL1INITITAG;
Begin
    Result := nPort;
    if m_pDB.GetL1Table(m_sTblL1)=True then
    for i:=0 to m_sTblL1.Count-1 do
    Begin
      if m_sTblL1.Items[i].m_sbyPortID=nPort then
      Begin
       Result := m_sTblL1.Items[i].m_sbyPortID;
       if m_sTblL1.Items[i].m_sblReaddres=1 then Result := m_sTblL1.Items[i].m_swAddres;
       exit;
      End;
    End;
end;
procedure THideCtrlFrame.btnInitL1Click(Sender: TObject);
begin
     if cbInitL1.Checked=True then
     SendQryBoolInit($FF18,213,0,0);
end;

procedure THideCtrlFrame.btnInitL2Click(Sender: TObject);
begin
     if cbInitL2.Checked=True then
     SendQryBoolInit($FF18,213,1,0);
end;

procedure THideCtrlFrame.btnReloadMetersClick(Sender: TObject);
begin
     if cbReloadMeters.Checked=True then
     SendQryBoolInit($FF18,213,3,0);
end;

procedure THideCtrlFrame.btnPackBaseClick(Sender: TObject);
begin
     if cbPackBase.Checked=True then
     SendQryBoolInit($FF18,213,4,0);
end;

procedure THideCtrlFrame.btnInitL3Click(Sender: TObject);
begin
     if cbInitL3.Checked=True then
     SendQryBoolInit($FF18,213,2,0);
end;

procedure THideCtrlFrame.btnSchedInitClick(Sender: TObject);
begin
     if cbSchedInit.Checked=True then
     SendQryBoolInit($FF18,213,5,0);
end;

procedure THideCtrlFrame.btnSchedGoClick(Sender: TObject);
begin
    if cbSchedGo.Checked=True then
    SendQryBoolInit($FF18,213,6,0);
end;

procedure THideCtrlFrame.btnSchedPauseClick(Sender: TObject);
begin
    if cbSchedPause.Checked=True then
    SendQryBoolInit($FF18,213,7,0);
end;

procedure THideCtrlFrame.btnSetIsOneSynchroClick(Sender: TObject);
begin
    if cbSetIsOneSynchro.Checked=True then
     SendQryBoolInit($FF18,213,11,1) else
    if cbSetIsOneSynchro.Checked<>True then
     SendQryBoolInit($FF18,213,11,0);
end;

procedure THideCtrlFrame.btnReload15MinClick(Sender: TObject);
begin
    if cbReload15Min.Checked=True then
     SendQryBoolInit($FF18,213,12,0);
end;

procedure THideCtrlFrame.btnSelfStopClick(Sender: TObject);
begin
    if cbSelfStop.Checked=True then
     SendQryBoolInit($FF18,213,13,0);
end;

procedure THideCtrlFrame.btnReloadClick(Sender: TObject);
begin
     if cbReload.Checked=True then
     SendQryBoolInit($FF18,213,16,0);
end;

procedure THideCtrlFrame.btnRunSQLInnClick(Sender: TObject);
Var
    Fl       : TINIFile;
    strSQL   : String;
    m_nTxMsg : CMessage;
    fnc,wCRC : Word;
    nLen,i : integer;
Begin
    try
     if cbRunSQLInn.Checked=True then
     Begin
     Fl := TINIFile.Create(ExtractFilePath(Application.ExeName)+'\Settings\USPD_Config.ini');
      strSQL := Fl.ReadString('DBCONFIG','DBAddField',' ');
     Fl.Destroy;
     if MessageDlg('Выполнить SQL запрос: '+strSQL,mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      //FPRID := 0;
      FillChar(m_nTxMsg.m_sbyInfo[0],500,0);
      nLen := Length(strSQL);
      Move(nLen,m_nTxMsg.m_sbyInfo[6],2);
      for i:=0 to nLen do m_nTxMsg.m_sbyInfo[8+i] := Byte(strSQL[i+1]);

      if m_blIsRemCrc=True then
      Begin
       CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (6+nLen+2)+4, $FF17);
       CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (6+nLen+2)+4);
      End else
      if m_blIsRemEco=True then
      Begin
       m_nTxMsg.m_sbyInfo[0] := 1;
       m_nTxMsg.m_sbyInfo[1] := 212;
       wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 6+nLen+2);
       m_nTxMsg.m_sbyInfo[6+nLen+2] := Lo(wCRC);
       m_nTxMsg.m_sbyInfo[6+nLen+2+1] := Hi(wCRC);
       CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (6+nLen+2+2));
      End else
      if m_blIsRemC12=True then
      Begin
       m_nTxMsg.m_sbyInfo[0] := 1;
       m_nTxMsg.m_sbyInfo[1] := $FA;
       m_nTxMsg.m_sbyInfo[2] := 212;
       CRC_C12(m_nTxMsg.m_sbyInfo[0], 6+nLen+2+2);
      CreateMSGHeadCrcRem_0(FPRID,m_nTxMsg, (6+nLen+2+2));
      End;
      {
      if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
       begin
        //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
        exit;
      end;
      fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
      }
      TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:',@m_nTxMsg);
      //FPUT(BOX_L1, @m_nTxMsg);
      if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then
      FPUT(BOX_L1, @m_nTxMsg);
      End;
      End;
    except
    end;
End;

procedure THideCtrlFrame.btnEnternetConnClick(Sender: TObject);
var pDS         : CMessageData;
    sec, Speed  : integer;
begin
   if cbEnternetConn.Checked=True then
   if MessageDlg('Установить удаленный сеанс на ' +
                  cbOpenSesTime.Items[cbOpenSesTime.ItemIndex] + ' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
   Begin
     case cbOpenSesTime.ItemIndex of
       0 : sec := 60;
       1 : sec := 120;
       2 : sec := 300;
       3 : sec := 600;
       4 : sec := 1800;
       5 : sec := 3600;
       6 : sec := 7200;
       else
       sec := 180;
     end;
             Speed := m_nInterSpeed;
     pDS.m_swData0 := 14;
     pDS.m_swData1 := sec;
     pDS.m_swData2 := Speed;
     pDS.m_swData3 := 0;
     if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SendRemCrcQry(0,pDS);exit; End;


     m_nCF.m_nSDL.m_nGST.OpenSession(pDS.m_swData1,pDS.m_swData2);
   End;
End;
procedure THideCtrlFrame.btnSetSmartFinderClick(Sender: TObject);
begin
    if cbSetSmartFinder.Checked=True then
     SendQryBoolInit($FF18,213,10,1) else
    if cbSetSmartFinder.Checked<>True then
     SendQryBoolInit($FF18,213,10,0);
end;

procedure THideCtrlFrame.btnSetUpdateFncClick(Sender: TObject);
begin
    if cbSetUpdateFnc.Checked=True then
     SendQryBoolInit($FF18,213,15,1) else
    if cbSetUpdateFnc.Checked<>True then
     SendQryBoolInit($FF18,213,15,0);
end;


procedure THideCtrlFrame.btnSetCountOfEvClick(Sender: TObject);
begin
    if cbSetCountOfEv.Checked=True then
    if edCountOfEv.Text<>'' then
    SendQryIntInit($FF18,213,17,(StrToInt(edCountOfEv.Text)));
end;

procedure THideCtrlFrame.btnInstTimeLabelClick(Sender: TObject);
begin
    if cbInstTimeLabel.Checked=True then
    if edTimeLabel.Text<>'' then
    SendQryIntInit($FF18,213,8,(StrToInt(edTimeLabel.Text)));
end;

procedure THideCtrlFrame.btnOffModuleTurnClick(Sender: TObject);
begin
    if cbOffModuleTurn.Checked=True then
     SendQryBoolInit($FF18,213,9,1) else
    if cbOffModuleTurn.Checked<>True then
     SendQryBoolInit($FF18,213,9,0);

end;

procedure THideCtrlFrame.btBrandOnClick(Sender: TObject);
begin
    if cbBrandOn.Checked=True then
     SendQryBoolInit($FF18,213,18,1) else
    if cbBrandOn.Checked<>True then
     SendQryBoolInit($FF18,213,18,0);
end;

procedure THideCtrlFrame.cbm_sChannSynDropDown(Sender: TObject);
begin
     InitComboChannel;
     edPortID.Enabled := True;
     chProtokol.Enabled := True;
end;

procedure THideCtrlFrame.chProtokolClick(Sender: TObject);
begin
     if chProtokol.Checked=True then
     Begin
      m_blIsRemCrc:=True;
      m_blIsRemEco:=False;
     End else
     if chProtokol.Checked=False then
     Begin
      m_blIsRemCrc:=False;
      m_blIsRemEco:=True;
     End;
     if chC12.Checked then
     Begin
      m_blIsRemCrc:=False;
      m_blIsRemEco:=False;
      m_blIsRemC12:=True;
     End;
end;

procedure THideCtrlFrame.OnFClose(Sender: TObject;
  var Action: TCloseAction);
begin
    m_blIsRemCrc := m_svCrc;
    m_blIsRemEco := m_svEko;
    m_blIsRemC12 := m_svC12;
end;

procedure THideCtrlFrame.btRdpOnClick(Sender: TObject);
begin
    if chRdpOn.Checked=True then
     SendQryBoolInit($FF18,213,19,1) else
    if chRdpOn.Checked<>True then
     SendQryBoolInit($FF18,213,19,0);
end;

procedure THideCtrlFrame.btNoLockClick(Sender: TObject);
begin
    if chNoLock.Checked=True then
     SendQryBoolInit($FF18,213,20,1) else
    if chNoLock.Checked<>True then
     SendQryBoolInit($FF18,213,20,0);
end;

procedure THideCtrlFrame.btUpdArmClick(Sender: TObject);
begin
    if chUpdArm.Checked=True then
     SendQryBoolInit($FF18,213,21,1) else
    if chUpdArm.Checked<>True then
     SendQryBoolInit($FF18,213,21,0);
end;

procedure THideCtrlFrame.btStartAmmyClick(Sender: TObject);
begin
    if chStartAmmy.Checked=True then
     SendQryBoolInit($FF18,213,22,1) else
    if chStartAmmy.Checked<>True then
     SendQryBoolInit($FF18,213,22,0);
end;

procedure THideCtrlFrame.btRebootUspdClick(Sender: TObject);
begin
    if chRebootUspd.Checked=True then
     SendQryBoolInit($FF03,203,0,0);
end;
procedure THideCtrlFrame.btRunUSPDClick(Sender: TObject);
begin
    if chRunUSPD.Checked=True then
     SendQryBoolInit($FF00,200,0,0) else
    if chRunUSPD.Checked=False then
     SendQryBoolInit($FF01,201,0,0);
end;

end.


