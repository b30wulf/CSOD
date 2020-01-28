unit knsl5MainEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  utltypes, utldatabase, AdvAppStyler, AdvPanel, AdvToolBar, StdCtrls,
  AdvOfficePager,knsl5config,utlconst,utlTimeDate, RbDrawCore, RbButton,
  AdvSmoothEdit, AdvSmoothEditButton, AdvSmoothDatePicker, ComCtrls,
  AdvGroupBox, AdvOfficeButtons, AdvOfficePagerStylers, Spin, AdvGlowButton;

type
  TfrMainEditor = class(TForm)
    AdvPanelStyler1     : TAdvPanelStyler;
    MainEditorStyler    : TAdvFormStyler;
    pgrMainEditor       : TAdvOfficePager;
    pgL1Editor          : TAdvOfficePage;
    pgL2Editor          : TAdvOfficePage;
    pgrL2Editor         : TAdvOfficePager;
    pgL2MainParams      : TAdvOfficePage;
    lbL2TypeMeter       : TLabel;
    lbL2NameMeter       : TLabel;
    lbFubrNumb          : TLabel;
    lbL2PhAddr          : TLabel;
    lbL2Passw           : TLabel;
    lbL2KI              : TLabel;
    lbL2KU              : TLabel;
    lbL2Teleph          : TLabel;
    lbL2IsModem         : TLabel;
    lbL2Enabl           : TLabel;
    ed_L2NameMeter      : TEdit;
    cb_L2TypeMeter      : TComboBox;
    ed_L2PhAddr         : TEdit;
    ed_L2FubNumb        : TEdit;
    ed_L2Passw          : TEdit;
    ed_L2KI             : TEdit;
    ed_L2KU             : TEdit;
    cb_L2IsModem        : TComboBox;
    cb_L2IsEnable       : TComboBox;
    ed_L2Teleph         : TEdit;
    pgL2AdvParams       : TAdvOfficePage;
    lbL2MeterLoc        : TLabel;
    lbL2NumbRej         : TLabel;
    lbL2PeriodRej       : TLabel;
    lbL2Koeff           : TLabel;
    lbL2SumKorr         : TLabel;
    lbL2LimKorr         : TLabel;
    lbL2PhLimKorr       : TLabel;
    lbL2Precis          : TLabel;
    lbL2Period          : TLabel;
    lbL2TurboSlice      : TLabel;
    cb_L2MeterLocation  : TComboBox;
    ed_L2KolRej         : TEdit;
    ed_L2PeriodRej      : TEdit;
    ed_L2Koeff          : TEdit;
    ed_L2SumKorr        : TEdit;
    ed_L2LimKorr        : TEdit;
    ed_L2PhLimKorr      : TEdit;
    ed_L2Precision      : TEdit;
    ed_L2Period         : TEdit;
    cb_L2TurboSlice     : TComboBox;
    RbButton1: TRbButton;
    lbL1KanName: TLabel;
    ed_L1KanName: TEdit;
    cb_L1PortType: TComboBox;
    lbL1KanNumb: TLabel;
    ed_L1KanNumb: TEdit;
    lbL1PortType: TLabel;
    lbL1ProtType: TLabel;
    cb_L1ProtType: TComboBox;
    lbL1Ypr: TLabel;
    cb_L1Ypravl: TComboBox;
    lbL1ResSave: TLabel;
    cb_L1ReshSave: TComboBox;
    lbL1PortSpeed: TLabel;
    cb_L1PortSpeed: TComboBox;
    lbL1Parit: TLabel;
    cb_L1PortParity: TComboBox;
    lbL1BitData: TLabel;
    cb_L1DataBit: TComboBox;
    lbL1StopBit: TLabel;
    cb_L1StopBit: TComboBox;
    lbL1TimeSb: TLabel;
    ed_L1TimeSbor: TEdit;
    lbL1Addres: TLabel;
    ed_L1Addres: TEdit;
    lbL1Recc: TLabel;
    cb_L1ReConn: TComboBox;
    lbL1Phone: TLabel;
    ed_L1Phone: TEdit;
    lbL1IPPort: TLabel;
    ed_L1IPPort: TEdit;
    lbL1IPAddr: TLabel;
    ed_L1IPAddr: TEdit;
    lb_L2FubKoncNumb: TLabel;
    ed_L2KoncFubNum: TEdit;
    lb_L2KoncAdrToRead: TLabel;
    ed_L2KoncAdrToRead: TEdit;
    l2_KoncRazNum: TLabel;
    ed_L2KoncRazNum: TEdit;
    lb_L2Konc: TLabel;
    ed_L2KoncNumTar: TEdit;
    lb_L2KoncPassw: TLabel;
    ed_L2KoncPassw: TEdit;
    lbL2NaprVvoda: TLabel;
    ed_L2NaprVvoda: TEdit;
    lbL2TypeTI: TLabel;
    ed_L2TypeTI: TEdit;
    ed_L2TypeTU: TEdit;
    lbL2TypeTU: TLabel;
    lbL2DateInst: TLabel;
    dt_L2DateInst: TDateTimePicker;
    lb_L2StBlock: TLabel;
    ed_L2StBlock: TEdit;
    chg_L2Tariffs: TAdvOfficeCheckGroup;
    Label1: TLabel;
    cbm_bySynchro: TComboBox;
    lb_L2Ke: TLabel;
    ed_l2KE: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    chm_sbyNSEnable: TCheckBox;
    edm_sdwFMark: TEdit;
    edm_sdwRetrans: TEdit;
    Label4: TLabel;
    edm_sdwKommut: TEdit;
    edm_sdwEMark: TEdit;
    edm_sdwDevice: TEdit;
    Label3: TLabel;
    Label7: TLabel;
    cbm_sbySpeed: TComboBox;
    Label5: TLabel;
    cbm_sbyParity: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    cbm_sbyStop: TComboBox;
    cbm_sbyKBit: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    cbm_sbyPause: TComboBox;
    Label12: TLabel;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    spm_nB0Timer: TSpinEdit;
    Label6: TLabel;
    Label13: TLabel;
    Label17: TLabel;
    edAktEnLose: TEdit;
    edReaEnLose: TEdit;
    Label18: TLabel;
    edTranAktRes: TEdit;
    edTranReaRes: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    cbGrKoeff: TComboBox;
    Label22: TLabel;
    cbTranVolt: TComboBox;
    Label23: TLabel;
    edTpNum: TEdit;
    btSaveAll: TRbButton;
    btSaveAllAID: TRbButton;
    Label24: TLabel;
    ed_L2KoncTarNum: TEdit;
    lbHOUSE: TLabel;
    ed_L2HOUSE: TEdit;
    Label25: TLabel;
    ed_L2KV: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnSaveTF(Sender: TObject);
    procedure chm_sbyNSEnableClick(Sender: TObject);
    procedure btSaveAllClick(Sender: TObject);
    procedure btSaveAllAIDClick(Sender: TObject);
  private
    { Private declarations }
    m_nL1Node   : SL1TAG;
    m_nL2Node   : SL2TAG;
    procedure SelectAtribute;
    procedure LoadParamsToL1Editor;
    procedure LoadParamsForEA8086;
    procedure LoadParamsForAlarm;
    procedure LoadTariffsZone;
    procedure LoadParamsToL2Editor;
    procedure SaveL1ParamsToBD;
    procedure SaveL2ParamsEA8086;
    procedure SaveL2ParamsAlarm;
    procedure SaveL2Tariffs;
    procedure SaveL2ParamsToBD;
    procedure LoadComboBoxL1;
    procedure LoadComboBoxL2;
  public
    { Public declarations }
    byTypeEditor     : integer;
  public
    //procedure PrepParamsForAlarm;
  public
    property pL1Node : SL1TAG read m_nL1Node write m_nL1Node;
    property pL2Node : SL2TAG read m_nL2Node write m_nL2Node;
  end;


var
  frMainEditor: TfrMainEditor;

implementation

{$R *.DFM}

procedure TfrMainEditor.LoadComboBoxL1;
var m_strCurrentDir : string;
begin
   m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
   cb_L1PortType.items.loadfromfile(m_strCurrentDir+'PortType.dat');
   cb_L1ProtType.items.loadfromfile(m_strCurrentDir+'TypeProt.dat');
   cb_L1ReConn.items.loadfromfile(m_strCurrentDir+'Active.dat');
   cb_L1Ypravl.items.loadfromfile(m_strCurrentDir+'Active.dat');
   cb_L1ReshSave.items.loadfromfile(m_strCurrentDir+'ktrouting.dat');
   cb_L1PortSpeed.items.loadfromfile(m_strCurrentDir+'potrspeed.dat');
   cb_L1PortParity.items.loadfromfile(m_strCurrentDir+'portparity.dat');
   cb_L1DataBit.items.loadfromfile(m_strCurrentDir+'portdbit.dat');
   cb_L1StopBit.items.loadfromfile(m_strCurrentDir+'portsbit.dat');
end;

procedure TfrMainEditor.LoadComboBoxL2;
var m_strCurrentDir : string;
    i : Integer;
begin
   m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
   cb_L2TypeMeter.items.loadfromfile(m_strCurrentDir+'MeterType.dat');
   cb_L2IsEnable.items.loadfromfile(m_strCurrentDir+'Active.dat');
   cb_L2IsModem.items.loadfromfile(m_strCurrentDir+'Active.dat');
   cb_L2MeterLocation.items.loadfromfile(m_strCurrentDir+'MeterLocation.dat');
   cb_L2TurboSlice.items.loadfromfile(m_strCurrentDir+'Active.dat');
   cbm_bySynchro.items.loadfromfile(m_strCurrentDir+'Active.dat');

   cbm_sbySpeed.items.loadfromfile(m_strCurrentDir+'potrspeedA.dat');
   cbm_sbyParity.items.loadfromfile(m_strCurrentDir+'portparityA.dat');
   cbm_sbyStop.items.loadfromfile(m_strCurrentDir+'portsbitA.dat');
   cbm_sbyKBit.items.loadfromfile(m_strCurrentDir+'portdbitA.dat');

   for i:=1 to 50 do
   cbm_sbyPause.items.Add(IntToStr(i));
end;

procedure TfrMainEditor.FormCreate(Sender: TObject);
begin
   m_nCF.m_nSetColor.PMainEditorStyler := @MainEditorStyler;
   LoadComboBoxL1;
   LoadComboBoxL2;
end;

procedure TfrMainEditor.FormShow(Sender: TObject);
begin
   case byTypeEditor of
     EDT_MN_L1TAG :
     begin
       pgL1Editor.TabEnabled := true;
       pgL2Editor.TabEnabled := false;
       LoadParamsToL1Editor;
       pgrMainEditor.ActivePage := pgL1Editor;
     end;
     EDT_MN_L2TAG :
     begin
       pgL1Editor.TabEnabled := false;
       pgL2Editor.TabEnabled := true;
       LoadParamsToL2Editor;
       pgrMainEditor.ActivePage := pgL2Editor;
     end;
   end;
   SelectAtribute;
end;
procedure TfrMainEditor.SelectAtribute;
Begin
   if (m_nL2Node.m_sbyType=MET_CE16401M) or (m_nL2Node.m_sbyType=MET_USPD16401I)or (m_nL2Node.m_sbyType=MET_USPD16401K) then
   Begin
    lb_L2FubKoncNumb.Caption   :='Логин УСПД:';           //0
    lb_L2KoncPassw.Caption     :='Пароль УСПД:';          //1
    lb_L2KoncAdrToRead.Caption :='Адрес УСПД:';           //2
    l2_KoncRazNum.Caption      :='Адрес пользователя:';   //3
    lb_L2Konc.Caption          :='Параметр №1:';          //4
    lbL2NaprVvoda.Caption      :='Напряжение ввода:';
    lbL2TypeTI.Caption         :='Тип тр. по току:';
    ed_L2KoncAdrToRead.Width:= 75;
   End else
   if (m_nL2Node.m_sbyType=MET_TEM104) then
   Begin
    lb_L2KoncAdrToRead.Caption :='Адрес счетчика:';
    l2_KoncRazNum.Caption      :='Код ЖЭУ:';
    lb_L2Konc.Caption          :='Код объекта:';
    lbL2NaprVvoda.Caption      :='Код счетчика:';
    lbL2TypeTI.Caption         :='Название(ТИП):';
   End
   else
   if (m_nL2Node.m_sbyType=MET_EE8003) or (m_nL2Node.m_sbyType=MET_EE8005)or (m_nL2Node.m_sbyType=MET_EE8007)then
   Begin
    lb_L2KoncPassw.Caption     :='Пароль чтения счетчика:';
    lb_L2KoncAdrToRead.Caption :='Сетевой адрес чтения:';
   end
   else
   if (m_nL2Node.m_sbyType=MET_USPD16401B) then
   begin
    lb_L2FubKoncNumb.Caption   :='Адрес УСПД:';           //0
    lb_L2KoncPassw.Caption     :='Пароль УСПД:';          //1
    lb_L2KoncAdrToRead.Caption :='Адрес чтения канала:';           //2
    l2_KoncRazNum.Caption      :='Адрес пользователя:';   //3
    lb_L2Konc.Caption          :='Параметр №1:';          //4
    lbL2NaprVvoda.Caption      :='Напряжение ввода:';
    lbL2TypeTI.Caption         :='Тип тр. по току:';
    ed_L2KoncAdrToRead.Width:= 75;
   end
   else
   Begin
    lb_L2KoncAdrToRead.Caption :='Адрес чтения параметра:';
    l2_KoncRazNum.Caption      :='Номер разъема:';
    lb_L2Konc.Caption          :='Номер вар-та тарификации:';
    lbL2NaprVvoda.Caption      :='Напряжение ввода:';
    lbL2TypeTI.Caption         :='Тип тр. по току:';
    if (m_nL2Node.m_aid_channel=0)and (m_nL2Node.m_aid_tariff=0) then
    begin
    ed_L2KoncRazNum.Text       := '';
    ed_L2KoncTarNum.Text       := '';
    end else
        begin
        ed_L2KoncRazNum.Text         := IntToStr(m_nL2Node.m_aid_channel);
        ed_L2KoncTarNum.Text         := IntToStr(m_nL2Node.m_aid_tariff);
        end;
   End;
End;
procedure TfrMainEditor.LoadParamsToL1Editor;
begin
   ed_L1KanName.Text         := m_nL1Node.m_schName;
   ed_L1KanNumb.Text         := IntToStr(m_nL1Node.m_sbyPortNum);
   cb_L1PortType.ItemIndex   := m_nL1Node.m_sbyType;
   cb_L1ProtType.ItemIndex   := m_nL1Node.m_sbyProtID;
   cb_L1Ypravl.ItemIndex     := m_nL1Node.m_sbyControl;
   cb_L1ReshSave.ItemIndex   := m_nL1Node.m_sbyKTRout;
   cb_L1PortSpeed.ItemIndex  := m_nL1Node.m_sbySpeed;
   cb_L1PortParity.ItemIndex := m_nL1Node.m_sbyParity;
   cb_L1DataBit.ItemIndex    := m_nL1Node.m_sbyData;
   cb_L1StopBit.ItemIndex    := m_nL1Node.m_sbyStop;
   ed_L1TimeSbor.Text        := IntToStr(m_nL1Node.m_swDelayTime);
   ed_L1Addres.Text          := IntToStr(m_nL1Node.m_swAddres);
   cb_L1ReConn.ItemIndex     := m_nL1Node.m_sblReaddres;
   ed_L1Phone.Text           := m_nL1Node.m_schPhone;
   ed_L1IPPort.Text          := m_nL1Node.m_swIPPort;
   ed_L1IPAddr.Text          := m_nL1Node.m_schIPAddr;
end;

procedure TfrMainEditor.LoadParamsForEA8086;
var i, j  : integer;
    ts    : string;
begin
   ed_L2KoncFubNum.Text  := '';
   ed_L2KoncPassw.Text   := '';
   ed_L2KoncAdrToRead.Text := '';
   ed_L2KoncRazNum.Text  := '';
   ed_L2KoncNumTar.Text  := '';
   ed_L2NaprVvoda.Text   := '';
   ed_L2TypeTI.Text      := '';
   ed_L2TypeTU.Text      := '';
   dt_L2DateInst.Date    := trunc(Now);
   j  := 0;
   ts := '';
   for i := 1 to Length(m_nL2Node.m_sAdvDiscL2Tag) do
   begin
     if m_nL2Node.m_sAdvDiscL2Tag[i] = ';' then
     begin
       case j of
         0 : begin ed_L2KoncFubNum.Text   := ts; j := j + 1; end;
         1 : begin ed_L2KoncPassw.Text    := ts; j := j + 1; end;
         2 : begin ed_L2KoncAdrToRead.Text  := ts; j := j + 1; end;
         3 : begin ed_L2KoncRazNum.Text   := ts; j := j + 1; end;
         4 : begin ed_L2KoncNumTar.Text   := ts; j := j + 1; end;
         5 : begin ed_L2NaprVvoda.Text    := ts; j := j + 1; end;
         6 : begin ed_L2TypeTI.Text       := ts; j := j + 1; end;
         7 : begin ed_L2TypeTU.Text       := ts; j := j + 1; end;
         8 : begin dt_L2DateInst.Date     := StrToDate(ts); j := j + 1; end;
       end;
       ts := '';
       continue;
     end;
     ts := ts + m_nL2Node.m_sAdvDiscL2Tag[i];
   end;
end;

procedure TfrMainEditor.LoadTariffsZone;
var i  : integer;
    ts : string;
begin
   for i := 0 to chg_L2Tariffs.Items.Count - 1 do
     chg_L2Tariffs.Checked[i] := false;
   ts := '';
   for i := 1 to Length(m_nL2Node.m_sTariffs) do
   begin
     if m_nL2Node.m_sTariffs[i] = ',' then
     begin
       chg_L2Tariffs.Checked[StrToInt(ts) - 1] := true;
       ts := '';
       continue;
     end;
     ts := ts + m_nL2Node.m_sTariffs[i];
   end;
end;
procedure TfrMainEditor.LoadParamsForAlarm;
Begin
   with m_nL2Node.m_sAD do
   Begin
    chm_sbyNSEnable.Checked := Boolean(m_sbyNSEnable);
    edm_sdwFMark.Text       := IntToStr(m_sdwFMark);
    edm_sdwEMark.Text       := IntToStr(m_sdwEMark);
    edm_sdwRetrans.Text     := IntToStr(m_sdwRetrans);
    edm_sdwKommut.Text      := IntToStr(m_sdwKommut);
    edm_sdwDevice.Text      := IntToStr(m_sdwDevice);
    cbm_sbySpeed.ItemIndex  := m_sbySpeed;
    cbm_sbyParity.ItemIndex := m_sbyParity;
    cbm_sbyStop.ItemIndex   := m_sbyStop;
    cbm_sbyKBit.ItemIndex   := m_sbyKBit;
    cbm_sbyPause.ItemIndex  := m_sbyPause;
    spm_nB0Timer.Value      := m_nB0Timer;
   End;
   chm_sbyNSEnableClick(chm_sbyNSEnable);
End;
procedure TfrMainEditor.LoadParamsToL2Editor;
var str : string;
begin
   cb_L2TypeMeter.ItemIndex     := m_nL2Node.m_sbyType;
   cb_L2MeterLocation.ItemIndex := m_nL2Node.m_sbyLocation;
   ed_L2FubNumb.Text            := m_nL2Node.m_sddFabNum;
   ed_L2PhAddr.Text             := m_nL2Node.m_sddPHAddres;
   ed_L2Passw.Text              := m_nL2Node.m_schPassword;
   ed_L2NameMeter.Text          := m_nL2Node.m_schName;
   ed_L2KolRej.Text             := IntToStr(m_nL2Node.m_sbyRepMsg);
   ed_L2PeriodRej.Text          := IntToStr(m_nL2Node.m_swRepTime);
   ed_L2KI.Text                 := FloatToStrF(m_nL2Node.m_sfKI,ffFixed,6,4);
   ed_L2KU.Text                 := FloatToStrF(m_nL2Node.m_sfKU,ffFixed,6,4);
   ed_L2Koeff.Text              := FloatToStrF(m_nL2Node.m_sfMeterKoeff,ffFixed,6,4);
   ed_L2Precision.Text          := IntToStr(m_nL2Node.m_sbyPrecision);
   ed_L2Period.Text             := IntToStr(m_nL2Node.m_swCurrQryTm);
   cb_L2TurboSlice.ItemIndex    := m_nL2Node.m_sbyTSlice;
   ed_L2Teleph.Text             := m_nL2Node.m_sPhone;
   cb_L2IsModem.ItemIndex       := m_nL2Node.m_sbyModem;
   cb_L2IsEnable.ItemIndex      := m_nL2Node.m_sbyEnable;
   ed_L2SumKorr.Text            := IntToStr(cDateTimeR.DateTimeToSec(m_nL2Node.m_sdtSumKor));
   ed_L2LimKorr.Text            := IntToStr(cDateTimeR.DateTimeToSec(m_nL2Node.m_sdtLimKor));
   ed_L2PhLimKorr.Text          := IntToStr(cDateTimeR.DateTimeToSec(m_nL2Node.m_sdtPhLimKor));
   //cb_L2TurboSlice.ItemIndex    := m_nL2Node.m_sbyEnable;
   cbm_bySynchro.ItemIndex      := m_nL2Node.m_bySynchro;
   LoadParamsForEA8086;
   LoadParamsForAlarm;
   ed_L2StBlock.Text            := '$' + IntToHex(m_nL2Node.m_sbyStBlock, 4);
   LoadTariffsZone;
   ed_L2KE.Text                 := IntToStr(m_nL2Node.m_swKE);

   edAktEnLose.Text             := FloatToStr(m_nL2Node.m_sAktEnLose);
   edReaEnLose.Text             := FloatToStr(m_nL2Node.m_sReaEnLose);
   edTranAktRes.Text            := FloatToStr(m_nL2Node.m_sTranAktRes);
   edTranReaRes.Text            := FloatToStr(m_nL2Node.m_sTranReaRes);
   cbGrKoeff.ItemIndex          := m_nL2Node.m_sGrKoeff;
   cbTranVolt.ItemIndex         := m_nL2Node.m_sTranVolt;
   edTpNum.Text                 := m_nL2Node.m_sTpNum;
   ed_L2HOUSE.Text              := m_nL2Node.m_sddHOUSE;
   ed_L2KV.Text                 := m_nL2Node.m_sddKV;
end;

procedure TfrMainEditor.SaveL1ParamsToBD;
begin
   m_nL1Node.m_schName       := ed_L1KanName.Text;
   m_nL1Node.m_sbyPortNum    := StrToInt(ed_L1KanNumb.Text);
   m_nL1Node.m_sbyType       := cb_L1PortType.ItemIndex;
   m_nL1Node.m_sbyProtID     := cb_L1ProtType.ItemIndex;
   m_nL1Node.m_sbyControl    := cb_L1Ypravl.ItemIndex;
   m_nL1Node.m_sbyKTRout     := cb_L1ReshSave.ItemIndex;
   m_nL1Node.m_sbySpeed      := cb_L1PortSpeed.ItemIndex;
   m_nL1Node.m_sbyParity     := cb_L1PortParity.ItemIndex;
   m_nL1Node.m_sbyData       := cb_L1DataBit.ItemIndex;
   m_nL1Node.m_sbyStop       := cb_L1StopBit.ItemIndex;
   m_nL1Node.m_swDelayTime   := StrToInt(ed_L1TimeSbor.Text);
   m_nL1Node.m_swAddres      := StrToInt(ed_L1Addres.Text);
   m_nL1Node.m_sblReaddres   := cb_L1ReConn.ItemIndex;
   m_nL1Node.m_schPhone      := ed_L1Phone.Text;
   m_nL1Node.m_swIPPort      := ed_L1IPPort.Text;
   m_nL1Node.m_schIPAddr     := ed_L1IPAddr.Text;
   m_pDB.SetPortTable(m_nL1Node);
end;

procedure TfrMainEditor.SaveL2ParamsEA8086;
var TempStr : string;
begin
   TempStr := '';
   TempStr := ed_L2KoncFubNum.Text  + ';' +
              ed_L2KoncPassw.Text   + ';' +
              ed_L2KoncAdrToRead.Text + ';' +
              ed_L2KoncRazNum.Text  + ';' +
              ed_L2KoncNumTar.Text  + ';' +
              ed_L2NaprVvoda.Text   + ';' +
              ed_L2TypeTI.Text      + ';' +
              ed_L2TypeTU.Text      + ';' +
              DateToStr(dt_L2DateInst.Date) + ';';
   m_nL2Node.m_sAdvDiscL2Tag := TempStr;
end;

procedure TfrMainEditor.SaveL2Tariffs;
var TempStr : string;
    i       : integer;
begin
   TempStr := '';
   for i := 0 to chg_L2Tariffs.Items.Count - 1 do
   begin
     if chg_L2Tariffs.Checked[i] then
       TempStr := TempStr + IntToStr(i + 1) + ',';
   end;
   m_nL2Node.m_sTariffs := TempStr;
end;
{
    SL2ADTAG = packed record
     m_sbyNSEnable : Byte;
     m_sdwFMark    : DWORD;
     m_sdwEMark    : DWORD;
     m_sdwRetrans  : DWORD;
     m_sdwKommut   : DWORD;
     m_sdwDevice   : DWORD;
     m_sbySpeed    : Byte;
     m_sbyParity   : Byte;
     m_sbyStop     : Byte;
     m_sbyKBit     : Byte;
     m_sbyPause    : Byte;
     m_sbyReserv   : array [0..9] of Byte;
    End;
}
//procedure PrepParamsForAlarm;
procedure TfrMainEditor.SaveL2ParamsAlarm;
Begin
   with m_nL2Node.m_sAD do
   Begin
    m_sbyNSEnable := Byte(chm_sbyNSEnable.Checked);
    m_sdwFMark    := StrToInt(edm_sdwFMark.Text);
    m_sdwEMark    := StrToInt(edm_sdwEMark.Text);
    m_sdwRetrans  := StrToInt(edm_sdwRetrans.Text);
    m_sdwKommut   := StrToInt(edm_sdwKommut.Text);
    m_sdwDevice   := StrToInt(edm_sdwDevice.Text);
    m_sbySpeed    := cbm_sbySpeed.ItemIndex;
    m_sbyParity   := cbm_sbyParity.ItemIndex;
    m_sbyStop     := cbm_sbyStop.ItemIndex;
    m_sbyKBit     := cbm_sbyKBit.ItemIndex;
    m_sbyPause    := cbm_sbyPause.ItemIndex;
    m_nB0Timer    := spm_nB0Timer.Value;
   End;
End;
procedure TfrMainEditor.SaveL2ParamsToBD;
begin
   m_nL2Node.m_sbyType          := cb_L2TypeMeter.ItemIndex;
   m_nL2Node.m_sbyLocation      := cb_L2MeterLocation.ItemIndex;
   m_nL2Node.m_sddFabNum        := ed_L2FubNumb.Text;
   m_nL2Node.m_sddPHAddres      := ed_L2PhAddr.Text;
   m_nL2Node.m_schPassword      := ed_L2Passw.Text;
   m_nL2Node.m_schName          := ed_L2NameMeter.Text;
   m_nL2Node.m_sbyRepMsg        := StrToInt(ed_L2KolRej.Text);
   m_nL2Node.m_swRepTime        := StrToInt(ed_L2PeriodRej.Text);
   m_nL2Node.m_sfKI             := StrToFloat(ed_L2KI.Text);
   m_nL2Node.m_sfKU             := StrToFloat(ed_L2KU.Text);
   m_nL2Node.m_sfMeterKoeff     := StrToFloat(ed_L2Koeff.Text);
   m_nL2Node.m_sbyPrecision     := StrToInt(ed_L2Precision.Text);
   m_nL2Node.m_swCurrQryTm      := StrToInt(ed_L2Period.Text);
   m_nL2Node.m_sbyTSlice        := cb_L2TurboSlice.ItemIndex;
   m_nL2Node.m_sPhone           := ed_L2Teleph.Text;
   m_nL2Node.m_sbyModem         := cb_L2IsModem.ItemIndex;
   m_nL2Node.m_sbyEnable        := cb_L2IsEnable.ItemIndex;
   m_nL2Node.m_sdtSumKor        := cDateTimeR.SecToDateTime(StrToInt(ed_L2SumKorr.Text));
   m_nL2Node.m_sdtLimKor        := cDateTimeR.SecToDateTime(StrToInt(ed_L2LimKorr.Text));
   m_nL2Node.m_sdtPhLimKor      := cDateTimeR.SecToDateTime(StrToInt(ed_L2PhLimKorr.Text));
   //m_nL2Node.m_sbyEnable        := cb_L2TurboSlice.ItemIndex;
   m_nL2Node.m_bySynchro        := cbm_bySynchro.ItemIndex;
   SaveL2ParamsEA8086;
   SaveL2ParamsAlarm;
   m_nL2Node.m_sbyStBlock       := StrToInt(ed_L2StBlock.Text);
   SaveL2Tariffs;
   m_nL2Node.m_swKE             := StrToInt(ed_L2KE.Text);

   m_nL2Node.m_sAktEnLose       := StrToFloat(edAktEnLose.Text);
   m_nL2Node.m_sReaEnLose       := StrToFloat(edReaEnLose.Text);
   m_nL2Node.m_sTranAktRes      := StrToFloat(edTranAktRes.Text);
   m_nL2Node.m_sTranReaRes      := StrToFloat(edTranReaRes.Text);
   m_nL2Node.m_sGrKoeff         := cbGrKoeff.ItemIndex;
   m_nL2Node.m_sTranVolt        := cbTranVolt.ItemIndex;
   m_nL2Node.m_sTpNum           := edTpNum.Text;
   if (ed_L2KoncRazNum.Text<>'') then
   m_nL2Node.m_aid_channel      := StrToInt(ed_L2KoncRazNum.Text);
   if (ed_L2KoncTarNum.Text<>'') then
   m_nL2Node.m_aid_tariff       := StrToInt(ed_L2KoncTarNum.Text);
   m_nL2Node.m_sddHOUSE        := ed_L2HOUSE.Text;
   m_nL2Node.m_sddKV           := ed_L2KV.Text;
   m_pDB.SetMeterTable(m_nL2Node);
end;

procedure TfrMainEditor.OnSaveTF(Sender: TObject);
begin
   case byTypeEditor of
     EDT_MN_L1TAG : SaveL1ParamsToBD;
     EDT_MN_L2TAG : SaveL2ParamsToBD;
   end;
   Close;
end;

procedure TfrMainEditor.chm_sbyNSEnableClick(Sender: TObject);
begin
    if chm_sbyNSEnable.Checked=False then
    Begin
     //chm_sbyNSEnable.Enabled := False;
     edm_sdwFMark.Enabled    := False;
     edm_sdwEMark.Enabled    := False;
     edm_sdwRetrans.Enabled  := False;
     edm_sdwKommut.Enabled   := False;
     edm_sdwDevice.Enabled   := False;
     cbm_sbySpeed.Enabled    := False;
     cbm_sbyParity.Enabled   := False;
     cbm_sbyStop.Enabled     := False;
     cbm_sbyKBit.Enabled     := False;
     cbm_sbyPause.Enabled    := False;
     spm_nB0Timer.Enabled    := False;
    End else
    if chm_sbyNSEnable.Checked=True then
    Begin
     //chm_sbyNSEnable.Enabled := True;
     edm_sdwFMark.Enabled    := True;
     edm_sdwEMark.Enabled    := True;
     edm_sdwRetrans.Enabled  := True;
     edm_sdwKommut.Enabled   := True;
     edm_sdwDevice.Enabled   := True;
     cbm_sbySpeed.Enabled    := True;
     cbm_sbyParity.Enabled   := True;
     cbm_sbyStop.Enabled     := True;
     cbm_sbyKBit.Enabled     := True;
     cbm_sbyPause.Enabled    := True;
     spm_nB0Timer.Enabled    := True;
    End;
end;
procedure TfrMainEditor.btSaveAllClick(Sender: TObject);
begin
    SaveL2ParamsEA8086;
    m_pDB.UpdateTextField(m_nL2Node.m_sbyPortID,m_nL2Node.m_sAdvDiscL2Tag);
end;

procedure TfrMainEditor.btSaveAllAIDClick(Sender: TObject);
begin
    SaveL2ParamsEA8086;
    m_pDB.UpdateTextFieldAID(m_nL2Node.M_SWABOID,m_nL2Node.m_sAdvDiscL2Tag);
end;
end.




