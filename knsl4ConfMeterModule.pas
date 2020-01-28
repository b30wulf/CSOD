unit knsl4ConfMeterModule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RbDrawCore, RbButton, ComCtrls, AdvProgr, StdCtrls, Spin, ExtCtrls, utldynconnect,
  utltypes,utlbox,utlconst,utlmtimer,knsl4automodule,knsl5config,knsl5tracer,utldatabase, utlTimeDate,
  AdvAppStyler, AdvOfficePager, WinXP, AdvOfficePagerStylers,
  AdvOfficeButtons, Grids, BaseGrid, AdvGrid, AdvPanel, AdvDateTimePicker,FileCtrl,
  GradientLabel, AdvToolBar, AdvToolBarStylers, ImgList, AdvGlowButton,knsl3EventBox;
type TQuerryReq = packed record
     Yn, Yk      : byte;
     perc        : byte;
     ReqCount    : integer;
     Equee       : array [0..20] of CQueryPrimitive;
   end;

type
  TConfMeterAuto = class(CHIAutomat)
  private
    IsActive           : boolean;
    IsOpenTranz        : boolean;
    FState             : byte;
    m_blIsModemOpen    : boolean;
    PhAddrAndComPrt    : SPHADRANDCOMPRTS;
    m_nTxMsg           : CMessage;
    m_pDDB             : PCDBDynamicConn;
    QuerryReq          : TQuerryReq;
    m_nTranzTimer      : CTimer;
    Meters             : SL2INITITAG;
    m_sTblL1           : SL1INITITAG;
    DirToSave          : string;
    m_blFreePort       : boolean;
    function  FindPortID : byte;
    function  IsGsmKanal : boolean;
    procedure CreateMSGHead(var pMsg :CMessage; Size :byte);
    procedure StartTranz;
    procedure FinishTranz;
    procedure GetPhAdrAndNameMeter(Ph : integer; var PHAddr, Name : string);
    //function  GetTelNumb(PortID): string;
    procedure CreateReq(fnc, pID, sp0, sp1, sp2 : byte);
    procedure CreateReadReq;
    procedure CreateGsmConReq;
    procedure CreateGsmDiscReq;
    procedure CreateFreePort;
    procedure CreateOpenPort;
    procedure CreateOpenBTIKanalTranzReq;
    procedure CreateVerifReq;
    procedure CreateUpdDateTimeReq;
    procedure CreateUpdPHAddrReq;
    procedure CreateUpdPortConfReq;
    procedure CreateUpdKIReq;
    procedure CreateUpdKUReq;
    procedure CreateUpdPasswReq;
    procedure CreateUpdAdvPasswReq;
    procedure CreateUpdTarReq;
    procedure CreateUpdCalReq;
    procedure CreateUpdSumWinDateReq;
    procedure ReadSpeedReq(var pMsg : CMessage);
    procedure ReadKIReq(var pMsg : CMessage);
    procedure ReadTarifReq(var pMsg : CMessage);
    procedure ReadKUReq(var pMsg : CMessage);
    procedure ReadKalenReq(var pMsg : CMessage);
    procedure ReadSumSeasonReq(var pMsg : CMessage);
    procedure ReadWinSeasonReq(var pMsg : CMessage);
    procedure ReadDateTimeReq(var pMsg : CMessage);
    procedure ReadUpdateDataReq(var pMsg : CMessage);
    procedure ReadGsmConAns(var pMsg : CMessage);
    procedure ReadGsmDicsAns(var pMsg : CMessage);
    procedure ReadBTIConReq(var pMsg : CMessage);
    procedure ErrorRecive;
    function  GetRealPort(nPort:Integer):Integer;
    function  CRC_CC301(var buf : array of byte; cnt : integer):boolean;
    function  CRC_BTI(var buf : array of byte; count : integer):boolean;
  public
     ReadWriteMode      : byte;

     procedure InitAuto(var pTable : SL1TAG);override;
     function  SelfHandler(var pMsg : CMessage):Boolean;override;
     function  LoHandler(var pMsg : CMessage):Boolean;override;
     function  HiHandler(var pMsg : CMessage):Boolean;override;
     procedure RunAuto;override;
     procedure ResetAuto;
     procedure StopAuto;
     procedure ConfigShell;
     procedure AddReqToQuerry(st, par, spec0, spec1, spec2 : byte);
     function  IncStateQuerry : boolean;
     procedure GoToEndQuerry;
     procedure ResetQuerry;
     procedure QuerryToProgBar;
  end;
  TConfMeterModule = class(TForm)
    ConfMeterStyler     : TAdvFormStyler;
    WinXP               : TWinXP;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    OpenDialog1         : TOpenDialog;
    SaveDialog1         : TSaveDialog;
    ImageList2: TImageList;
    AdvPanel3: TAdvPanel;
    Label18: TLabel;
    AdvPanel1: TAdvPanel;
    Label19: TLabel;
    AdvToolBar1: TAdvToolBar;
    bClearEv: TAdvToolBarButton;
    bEnablEv: TAdvToolBarButton;
    AdvToolBarSeparator2: TAdvToolBarSeparator;
    AdvToolBarButton1: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    prProgressParam: TAdvProgress;
    KalenSetPage: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    lbTelGsmCon: TLabel;
    lbTimeMetAndUSPD: TLabel;
    seVMAddress: TSpinEdit;
    edPassword: TEdit;
    sePHAddress: TSpinEdit;
    spNewPHAddress: TSpinEdit;
    cbSpeed: TComboBox;
    cbParitet: TComboBox;
    cbStopBit: TComboBox;
    edKU: TEdit;
    edKI: TEdit;
    edNewPassword: TEdit;
    edAdvPassword: TEdit;
    chbNewPHAddress: TAdvOfficeCheckBox;
    chbSpeed: TAdvOfficeCheckBox;
    chbSetDateTime: TAdvOfficeCheckBox;
    chbParitet: TAdvOfficeCheckBox;
    chbStopBit: TAdvOfficeCheckBox;
    chbKU: TAdvOfficeCheckBox;
    chbKI: TAdvOfficeCheckBox;
    chbNewPassword: TAdvOfficeCheckBox;
    chbAdvPassword: TAdvOfficeCheckBox;
    edTelGsmCon: TEdit;
    chbGsmCon: TAdvOfficeCheckBox;
    TarifSetPage: TAdvOfficePage;
    Label1: TLabel;
    Label9: TLabel;
    sgTariffs: TAdvStringGrid;
    cbMonthTarif: TComboBox;
    cbWorkPrDay: TComboBox;
    chbSetAllYear: TAdvOfficeCheckBox;
    AdvOfficePager13: TAdvOfficePage;
    Label12: TLabel;
    Label17: TLabel;
    sgKalendar: TAdvStringGrid;
    rbNoActionKal: TAdvOfficeRadioButton;
    rbResetActKal: TAdvOfficeRadioButton;
    rbUpdateActKal: TAdvOfficeRadioButton;
    dtSummerSeason: TAdvDateTimePicker;
    dtWinterSeason: TAdvDateTimePicker;
    chbKalUpdate: TAdvOfficeCheckBox;
    TransOpenPage: TAdvOfficePage;
    lbTranzOpen: TLabel;
    cbTranzTime: TComboBox;
    sgGroup: TAdvStringGrid;
    ComboBox1: TComboBox;
    lbProgressParam: TGradientLabel;
    AdvPanel2: TAdvPanel;
    GradientLabel1: TGradientLabel;
    GradientLabel2: TGradientLabel;
    GradientLabel3: TGradientLabel;
    GradientLabel4: TGradientLabel;
    GradientLabel5: TGradientLabel;
    GradientLabel6: TGradientLabel;
    ImageList1: TImageList;
    GradientLabel7: TGradientLabel;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    AdvGlowButton3: TAdvGlowButton;
    AdvGlowButton4: TAdvGlowButton;
    AdvGlowButton5: TAdvGlowButton;
    AdvGlowButton6: TAdvGlowButton;
    AdvGlowButton7: TAdvGlowButton;
    AdvGlowButton8: TAdvGlowButton;
    AdvGlowButton9: TAdvGlowButton;
    AdvOfficeCheckBox1: TAdvOfficeCheckBox;
    cbm_nFreePort: TAdvOfficeCheckBox;
    gbClose: TAdvGlowButton;
    //chbKalUpdate: TAdvOfficeCheckBox;
    //chbSeasonUpdate: TAdvOfficeCheckBox;
    procedure Ondisc(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbReadClick(Sender: TObject);
    procedure rbWriteClick(Sender: TObject);
    procedure rbTranzOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sgTariffsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure rbClearTariffsClick(Sender: TObject);
    procedure rbLoadTrFromFileClick(Sender: TObject);
    procedure rbSaveTrFromFileClick(Sender: TObject);
    procedure sgTariffsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgKalendarDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure sgKalendarDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateErrorMSG(ErrCode : byte);
    procedure SetReqInfo;
    procedure seVMAddressChange(Sender: TObject);
    procedure sePHAddressChange(Sender: TObject);
    procedure Ondisconnect(Sender: TObject);
    procedure rbClearKalClick(Sender: TObject);
    procedure OpenTransit;
    procedure PrepareTransit(nPage:Integer);
    procedure OnClosePhone(Sender: TObject);
  private
    { Private declarations }
    procedure MakeDir;
  public
    { Public declarations }
    PhabNum     : string;
    PHAddres    : string;
    PVAddres    : string;
    sPassword   : string;
    MID         : integer;
    m_Type      : WORD;
    m_Password  : String;
    m_ProtoID   : WORD;
    m_sbyReply  : BYTE;
    clTarifGrid : array [0..49] of byte;
    clKalenGrid : array [1..12, 1..31] of byte;
  end;

var
  ConfMeterModule: TConfMeterModule;
  ConfMeterAuto  : TConfMeterAuto;
const
  TranzTime      : array [0..5] of integer = (5, 10, 30, 60, 2*60, 4*60);

implementation

{$R *.DFM}
procedure TConfMeterModule.MakeDir;
var i, x      : integer;
    cur_dir   : string;
    RootDir   : string;
    value     : string;
begin
   //SetCurrentDirectory('c:\');
   CreateDir(ExtractFilePath(Application.ExeName)+'CounterProfiles');
   {
   SetCurrentDirectory('c:\a2000\');
   value   := '\ascue\CounterProfiles\';
   x       := 1;
   cur_dir :='';
   if (value[1]='\') then x:=2;
   for i := x to Length(value) do
    begin
     if not (value[i] = '\')then
       cur_dir := cur_dir+value[i];
     if (value[i] = '\')or (i=length(value)) then
      begin
       if not DirectoryExists(cur_dir) then
        CreateDirectory(pchar(cur_dir),0);
       SetCurrentDirectory(pchar(cur_dir));
       cur_dir:='';
      end;
    end;
   }
end;

procedure TConfMeterModule.FormCreate(Sender: TObject);
begin
   m_nCF.m_nSetColor.PConfMeterStyler := @ConfMeterStyler;
   if ConfMeterAuto <> nil then
     ConfMeterAuto.IsActive := false;
end;

procedure TConfMeterModule.FormShow(Sender: TObject);
var Year, Month, Day, i : word;
    TempDate            : TDateTime;
begin
   lbTimeMetAndUSPD.Caption := 'Время счетчика неизвестно';
   DecodeDate(Now, Year, Month, Day);
   cbWorkPrDay.ItemIndex  := 0;
   //cbTranzTime.ItemIndex  := 0;
   if chbGsmCon.Checked=True then gbClose.Enabled := True;
   cbMonthTarif.ItemIndex := Month - 1;
   FillChar(clTarifGrid, 48, 0);
   FillChar(clKalenGrid, 12*31, 0);
   TempDate  := Now;
   for i := 1 to 31 do
     sgKalendar.Cells[i, 0] := IntToStr(i);
   for i := 1 to 12 do
   begin
     DecodeDate(TempDate, Year, Month, Day);
     sgKalendar.Cells[0, i] := chMonth[Month] + ' ' + IntToStr(Year mod 100);
     cDateTimeR.IncMonth(TempDate);
   end;
   if m_blIsSlave then
     sePHAddress.Value := StrToInt(PHAddres)   //УСПД
   else
   Begin
     seVMAddress.Value := StrToInt(PVAddres);  //АРМ
     sePHAddress.Value := StrToInt(PHAddres);  //АРМ
   End;
   ConfMeterAuto.ResetAuto;
   ConfMeterAuto.StartTranz;
   ConfMeterAuto.m_blIsModemOpen := false;
   ConfMeterAuto.IsActive := true;
   if m_blIsSlave then
   begin
     seVMAddress.Enabled := false;
     //sePhAddress.Enabled := false;
   end
   else
   begin
     seVMAddress.Enabled := true;
     sePhAddress.Enabled := true;
   end
end;

procedure TConfMeterModule.rbReadClick(Sender: TObject);
var i                : integer;
    Year, Month, Day : word;
begin
   ConfMeterAuto.ReadWriteMode := 1;
   ConfMeterAuto.QuerryReq.ReqCount := 5;
   ConfMeterAuto.ResetAuto;
   if chbGsmCon.Checked then
     ConfMeterAuto.AddReqToQuerry(ST_CONF_GSM_CONN, 0, 0, 0, 0);
   case KalenSetPage.ActivePageIndex of
     0 : begin
           if not m_blIsSlave then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_BTI_CONN, 0, 10, 0, 0);
           ConfMeterAuto.AddReqToQuerry(ST_CONF_READ_DATE_TIME, 32, 0, 0, 0);
           ConfMeterAuto.AddReqToQuerry(ST_CONF_READ_PORTCONF, 23, 0, 0, 0);
           ConfMeterAuto.AddReqToQuerry(ST_CONF_READ_KI, 34, 0, 0, 0);
           ConfMeterAuto.AddReqToQuerry(ST_CONF_READ_KU, 34, 0, 0, 0);
         end;
     1 :
         begin
           if not m_blIsSlave then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_BTI_CONN, 0, 10, 0, 0);
           ConfMeterAuto.AddReqToQuerry(ST_CONF_READ_TARIFF, 30 + cbWorkPrDay.ItemIndex, 0, 0, cbMonthTarif.ItemIndex + 1);
         end;
     2 : begin
           if not m_blIsSlave then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_BTI_CONN, 0, 10, 0, 0);
           DecodeDate(Now, Year, Month, Day);
           if chbKalUpdate.Checked then
           begin
           for i := 1 to 12 do
             if i < Month then
                 ConfMeterAuto.AddReqToQuerry(ST_CONF_READ_CALENDAR, 29, 1, 0, i)
               else
                 ConfMeterAuto.AddReqToQuerry(ST_CONF_READ_CALENDAR, 29, 0, 0, i);
           End;
           ConfMeterAuto.AddReqToQuerry(ST_CONF_READ_SUMSEASON, 27, 0, 0, 0);
           ConfMeterAuto.AddReqToQuerry(ST_CONF_READ_WINSEASON, 28, 0, 0, 0);
         end;
   end;
   if chbGsmCon.Checked then
     ConfMeterAuto.AddReqToQuerry(ST_CONF_GSM_DISC, 0, 0, 0, 0);
   ConfMeterAuto.ConfigShell;
end;

procedure TConfMeterModule.rbWriteClick(Sender: TObject);
var i                : integer;
    Year, Month, Day : word;
begin
   if MessageDlg('Выполнить запись в устройство?',mtWarning,[mbOk,mbCancel],0)=mrOk then
   Begin
   ConfMeterAuto.QuerryReq.ReqCount := 5;
   ConfMeterAuto.ReadWriteMode := 0;
   ConfMeterAuto.ResetAuto;
   if chbGsmCon.Checked then
     ConfMeterAuto.AddReqToQuerry(ST_CONF_GSM_CONN, 0, 0, 0, 0);
   case KalenSetPage.ActivePageIndex of
     0 : begin
           if not m_blIsSlave then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_BTI_CONN, 0, 10, 0, 0);
           ConfMeterAuto.AddReqToQuerry(ST_CONF_CHECK_PASSW, 0, 0, 0, 0);
           if chbSetDateTime.Checked then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_DATETIME, 32, 0, 0, 0);
           {if chbKI.Checked then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_KI, 34, 0, 0, 0);
           if chbKU.Checked then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_KU, 34, 0, 0, 0);  }
           if chbSpeed.Checked or chbParitet.Checked or chbStopBit.Checked then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_PORTCONF, 23, 0, 0, 0);
           if chbNewPassword.Checked then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_PASSW, 0, 0, 0, 0);
           if chbAdvPassword.Checked then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_ADVPASSW, 0, 0, 0, 0);
           if chbNewPHAddress.Checked then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_PHADDR, 21, 0, 0, 0);
         end;
     1 :
         begin
           if not m_blIsSlave then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_BTI_CONN, 0, 10, 0, 0);
           ConfMeterAuto.AddReqToQuerry(ST_CONF_CHECK_PASSW, 0, 0, 0, 0);
           if not chbSetAllYear.Checked then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_TARIFF, 30 + cbWorkPrDay.ItemIndex, ConfMeterModule.cbMonthTarif.ItemIndex + 1, 0, cbMonthTarif.ItemIndex + 1)
           else
           for i := 1 to 12 do
             ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_TARIFF, 30 + cbWorkPrDay.ItemIndex, i, 0, cbMonthTarif.ItemIndex + 1);
         end;
     2 : begin
           if not m_blIsSlave then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_BTI_CONN, 0, 10, 0, 0);
           ConfMeterAuto.AddReqToQuerry(ST_CONF_CHECK_PASSW, 0, 0, 0, 0);
           DecodeDate(Now, Year, Month, Day);
           if chbKalUpdate.Checked then
           begin
             for i := 1 to 12 do
               if i < Month then
                 ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_CALENDAR, 29, 1, 0, i)
               else
                 ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_CALENDAR, 29, 0, 0, i);
           end;
           if not rbNoActionKal.Checked then
           begin
             ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_NEW_SUMSEASON, 27, 0, 0, 0);
             ConfMeterAuto.AddReqToQuerry(ST_CONF_UPD_NEW_WINSEASON, 28, 0, 0, 0);
           end;
         end;
   end;
   if chbGsmCon.Checked then
     ConfMeterAuto.AddReqToQuerry(ST_CONF_GSM_DISC, 0, 0, 0, 0);
   ConfMeterAuto.ConfigShell;
   End;
end;

procedure TConfMeterModule.rbTranzOpenClick(Sender: TObject);
Var
   PortID : Byte;
begin
   //ConfMeterAuto.m_nTranzTimer.OnTimer(TranzTime[cbTranzTime.ItemIndex]);
   if chbGsmCon.Checked=True then gbClose.Enabled := True;
   ConfMeterAuto.ResetQuerry;
   if chbGsmCon.Checked then
     ConfMeterAuto.AddReqToQuerry(ST_CONF_GSM_CONN, 0, 0, 0, 0);
   if not m_blIsSlave then
   begin
     ConfMeterAuto.AddReqToQuerry(ST_CONF_BTI_CONN, 0, TranzTime[cbTranzTime.ItemIndex], 0, 0);
   end;
   if chbGsmCon.Checked then
   Begin
    if cbm_nFreePort.Checked=True then ConfMeterAuto.m_blFreePort:=True else
    ConfMeterAuto.AddReqToQuerry(ST_CONF_GSM_DISC, 0, 0, 0, 0);
   End;
   ConfMeterAuto.ConfigShell;
end;
procedure TConfMeterModule.OpenTransit;
Begin
   ConfMeterAuto.IsOpenTranz := True;
   cbTranzTime.ItemIndex := 5;
   rbTranzOpenClick(self);
End;
procedure TConfMeterModule.PrepareTransit(nPage:Integer);
Begin
   ConfMeterAuto.IsOpenTranz := True;
   cbTranzTime.ItemIndex := 5;
   KalenSetPage.ActivePageIndex := nPage;
End;
procedure TConfMeterModule.Ondisc(Sender: TObject);
begin
   if MessageDlg('Остановить выполнение операции?',mtWarning,[mbOk,mbCancel],0)=mrOk then
   Begin
   //ConfMeterAuto.StopAuto;
   //ConfMeterModule.Close;
   ConfMeterAuto.QuerryReq.ReqCount := 0;
   ConfMeterAuto.m_nRepTimer.OffTimer;
   if ConfMeterAuto.m_blIsModemOpen then
   Begin
    if cbm_nFreePort.Checked=True then ConfMeterAuto.CreateOpenPort;
    ConfMeterAuto.CreateGsmDiscReq;
   End
   End;
end;

procedure TConfMeterModule.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   ConfMeterAuto.StopAuto;
   //ConfMeterModule.Close;
   ConfMeterAuto.IsActive := false;
end;

procedure TConfMeterModule.rbClearTariffsClick(Sender: TObject);
begin
   FillChar(clTarifGrid, 48, 0);
   sgTariffs.Refresh;
end;

procedure TConfMeterModule.rbLoadTrFromFileClick(Sender: TObject);
var f    : TFileStream;
    i    : integer;
    buf  : array [0..52] of byte;
begin
   OpenDialog1.DefaultExt := 'fbk';
   OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName)+'CounterProfiles';
   //OpenDialog1.FileName   := 'sysinfoauto.trf';
   OpenDialog1.Filter     := 'Файлы тарифов|*.trf';
   if OpenDialog1.Execute then
   begin
     f := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
     f.Read(buf, 53);
     if (Char(buf[0]) <> 't') or (Char(buf[1]) <> 'r') or ((Char(buf[2])) <> 'f')
       or (not ConfMeterAuto.CRC_CC301(buf[3], 48)) then
       CreateErrorMSG(ER_CONF_LOAD_TAR)
     else
     begin
       for i := 0 to 47 do
         clTarifGrid[i] := buf[3 + i];
       sgTariffs.Refresh;
     end;
     f.Free;
   end;
end;

procedure TConfMeterModule.rbSaveTrFromFileClick(Sender: TObject);
var f    : TFileStream;
    i    : integer;
    buf  : array [0..52] of byte;
    str  : string;
begin
   SaveDialog1.DefaultExt := 'trf';
   SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'CounterProfiles';
   //SaveDialog1.FileName   := 'sysinfoauto.fbk';
   SaveDialog1.Filter     := 'Файлы тарифов|*.trf';
   SaveDialog1.FileName := 'Тарифное расписание (' + PhabNum + ')';
   if SaveDialog1.Execute then
   begin
     SetLength(str, 4);
     if Length(SaveDialog1.FileName) > 4 then
       move(SaveDialog1.FileName[Length(SaveDialog1.FileName) - 3], str[1], 4);
     if str = '.trf' then
       f := TFileStream.Create(SaveDialog1.FileName, fmCreate)
     else
       f := TFileStream.Create(SaveDialog1.FileName + '.trf', fmCreate);
     buf[0] := Byte('t');
     buf[1] := Byte('r');
     buf[2] := Byte('f');
     ConfMeterAuto.CRC_CC301(clTarifGrid[0], 48);
     for i := 0 to 49 do
       buf[3 + i] := clTarifGrid[i];
     f.Write(buf, 53);
     f.Free;
   end;
end;

procedure TConfMeterModule.sgTariffsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   if (ACol > 0) and (ACol <= 8) and (ARow > 0) and (ARow <= 48) then
     clTarifGrid[ARow - 1] := clTarifGrid[ARow - 1] xor __SetMask[ACol - 1];
end;

procedure TConfMeterModule.sgTariffsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   if (ARow = 0) or (ACol = 0) then
     exit;
   if (clTarifGrid[ARow - 1] and __SetMask[ACol - 1]) <> 0 then
     (Sender as TadvStringGrid).Canvas.Brush.Color := clRed
   else
     sgTariffs.Canvas.Brush.Color := clWhite;
   sgTariffs.Canvas.FillRect(Rect);
end;

procedure TConfMeterModule.sgKalendarDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
var Year, Month, Day : word;
begin
   if (ACol = 0) or (ARow = 0) then
     exit;
   DecodeDate(Now, Year, Month, Day);
   Month := Month + ARow - 1;
   if Month > 12 then
   begin
     Inc(Year);
     Month := Month - 12;
   end;
   if (ACol <= 31) and (ARow <= 12) and (ACol <= cDateTimeR.DayPerMonth(Month, Year)) then
     Inc(clKalenGrid[ARow, ACol]);
   sgKalendar.Refresh;
end;

procedure TConfMeterModule.sgKalendarDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   if (ARow = 0) or (ACol = 0) then
     exit;
   if (clKalenGrid[ARow, ACol] and 1) = 1 then
     sgKalendar.Canvas.Brush.Color := clRed
   else
     sgKalendar.Canvas.Brush.Color := clWhite;
   sgKalendar.Canvas.FillRect(Rect);
end;

procedure TConfMeterModule.CreateErrorMSG(ErrCode : byte);
begin
   //MessageDlg(chConfError[ErrCode],mtWarning,[mbOk],0);
   ConfMeterAuto.ResetAuto;
end;

procedure TConfMeterModule.SetReqInfo;
begin
   with ConfMeterAuto do
     ConfMeterModule.lbProgressParam.Caption  := chConfState[QuerryReq.Equee[QuerryReq.Yn].m_swMtrID]
         + '(' + IntToStr(QuerryReq.ReqCount) + ')' ;
end;

procedure TConfMeterAuto.InitAuto(var pTable : SL1TAG);
var i      : integer;
begin
   FState                        := ST_CONF_NULL;
   m_pDDB                        := m_pDB.DynConnect(7);
   m_sbyRepTime                  := 5;
   IsOpenTranz                   := False;
   ConfMeterAuto                 := Self;
   m_sIsTranzOpen.m_sbIsTrasnBeg := false;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
   m_blFreePort                  := False;
   QuerryReq.ReqCount            := 5;
   m_pDDB.GetL1Table(m_sTblL1);
   ConfMeterModule.MakeDir;
   if m_pDDB.GetMetersIniTable(Meters) then
   begin
     PhAddrAndComPrt.Count := Meters.m_swAmMeter;
     SetLength(PhAddrAndComPrt.Items, Meters.m_swAmMeter);
     for i := 0 to Meters.m_swAmMeter - 1 do
     begin
       if (Meters.m_sMeter[i].m_sbyType = MET_KASKAD)or(Meters.m_sMeter[i].m_sbyType = MET_MIRT1)or(Meters.m_sMeter[i].m_sbyType=MET_CE301BY) then
         PhAddrAndComPrt.Items[i].m_swPHAddres := 0
       else
         PhAddrAndComPrt.Items[i].m_swPHAddres := StrToInt(Meters.m_sMeter[i].m_sddPHAddres);
       PhAddrAndComPrt.Items[i].m_swPortID   := GetRealPort(Meters.m_sMeter[i].m_sbyPortID);
     end;
   end;
end;

procedure TConfMeterAuto.CreateMSGHead(var pMsg :CMessage; Size :byte);
begin
   pMsg.m_swLen       := Size;
   pMsg.m_swObjID     := m_sbyID;             //Сетевой адрес счётчика
   pMsg.m_sbyFrom     := DIR_L2TOL1;
   pMsg.m_sbyFor      := DIR_L2TOL1;          //DIR_L2toL1
   pMsg.m_sbyType     := PH_DATARD_REQ;       //PH_DATARD_REC
   pMsg.m_sbyIntID    := GetRealPort(FindPortID);
   pMsg.m_sbyServerID := MET_SS301F3;         //Указать тип счетчика
   pMsg.m_sbyDirID    := GetRealPort(FindPortID);
end;

function  TConfMeterAuto.FindPortID : byte;
var i : integer;
begin
   Result := High(byte);
   if m_blIsSlave then
   begin
     {if PhAddrAndComPrt.Items[i].m_sbyPHAddres = ConfMeterModule.sePhAddress.Value then
       Result := PhAddrAndComPrt.Items[i].m_sbyPortID; }
     for i := 0 to Meters.m_swAmMeter - 1 do
       if Meters.m_sMeter[i].m_swMID = ConfMeterModule.MID then
         Result := Meters.m_sMeter[i].m_sbyPortID;
     end
   else
     for i := 0 to PhAddrAndComPrt.Count - 1 do
       if PhAddrAndComPrt.Items[i].m_swPHAddres = ConfMeterModule.seVMAddress.Value then
         Result := PhAddrAndComPrt.Items[i].m_swPortID;
end;

function  TConfMeterAuto.IsGsmKanal : boolean;
var PortID, i : integer;
begin
   Result := false;
   PortID := GetRealPort(FindPortID);
   for i := 0 to m_sTblL1.Count - 1 do
    if m_sTblL1.Items[i].m_sbyPortID = PortID then
      if m_sTblL1.Items[i].m_sbyType = DEV_COM_GSM then
      begin
        Result := true;
        exit;
      end;
end;

procedure TConfMeterAuto.StartTranz;
Var
    pDS : CMessageData;
begin
   //TraceL(4, 0,'(__)CL4MD::>SS301:  : Начало опроса. Основной опрос остановлен');
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   m_nCF.SchedPause;
   //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
   m_sIsTranzOpen.m_sbIsTrasnBeg := true;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
end;

procedure TConfMeterAuto.FinishTranz;
Var
    pDS : CMessageData;
begin
   {TraceL(4, 0,'(__)CL4MD::>SS301:  : Окончание опроса. Основной опрос запущен');   }
   m_nRepTimer.OffTimer;
   m_sIsTranzOpen.m_sbIsTrasnBeg := false;
   m_nCF.SchedGo;
   {if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);      }
end;

procedure TConfMeterAuto.GetPhAdrAndNameMeter(Ph : integer; var PHAddr, Name : string);
var i       : integer;
begin
   PHAddr := 'Unknown';
   Name   := 'Счетчик неизвестен';
   for i := 0 to Meters.m_swAmMeter - 1 do
     if StrToInt(Meters.m_sMeter[i].m_sddPHAddres) = Ph then
     begin
       PHAddr := Meters.m_sMeter[i].m_sddPHAddres;
       Name   := Meters.m_sMeter[i].m_schName;
     end;
end;

procedure TConfMeterAuto.ReadSpeedReq(var pMsg : CMessage);
var param : WORD;
begin
   if pMsg.m_sbyInfo[3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   move(pMsg.m_sbyInfo[4], param, 2);
   ConfMeterModule.cbSpeed.ItemIndex   := ConfMeterModule.cbSpeed.Items.IndexOf(IntToStr(param));
   ConfMeterModule.cbParitet.ItemIndex := pMsg.m_sbyInfo[8];
   ConfMeterModule.cbStopBit.ItemIndex := pMsg.m_sbyInfo[9] - 1;
end;

procedure TConfMeterAuto.ReadKIReq(var pMsg : CMessage);
var param : DWORD;
begin
   if pMsg.m_sbyInfo[3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   move(pMsg.m_sbyInfo[4], param, 4);
   ConfMeterModule.edKI.Text := IntToStr(param);
   move(pMsg.m_sbyInfo[8], param, 4);
   ConfMeterModule.edKU.Text := IntToStr(param);
end;

procedure TConfMeterAuto.ReadKUReq(var pMsg : CMessage);
var param : DWORD;
begin
   if pMsg.m_sbyInfo[3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   move(pMsg.m_sbyInfo[4], param, 4);
   ConfMeterModule.edKI.Text := IntToStr(param);
   move(pMsg.m_sbyInfo[8], param, 4);
   ConfMeterModule.edKU.Text := IntToStr(param);
   ConfMeterModule.spNewPHAddress.Value := ConfMeterModule.seVMAddress.Value;
end;

procedure TConfMeterAuto.ReadTarifReq(var pMsg : CMessage);
begin
   if pMsg.m_sbyInfo[3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   move(pMsg.m_sbyInfo[4], ConfMeterModule.clTarifGrid, 48);
   ConfMeterModule.sgTariffs.Refresh;
end;

procedure TConfMeterAuto.ReadKalenReq(var pMsg : CMessage);
var Year, Month, Day, Row  : word;
    i, j                   : byte;
begin
   if pMsg.m_sbyInfo[3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   DecodeDate(Now, Year, Month, Day);
   if QuerryReq.Equee[QuerryReq.Yn].m_swSpecc2 >= Month then
     Row := QuerryReq.Equee[QuerryReq.Yn].m_swSpecc2 - Month + 1
   else
     Row := 12 - (Month - QuerryReq.Equee[QuerryReq.Yn].m_swSpecc2) + 1;
   for i := 0 to 3 do
     for j := 0 to 7 do
     begin
       if (i = 3) and (j = 7) then
         continue;
       if (pMsg.m_sbyInfo[i + 4] and __SetMask[j]) <> 0 then
         ConfMeterModule.clKalenGrid[Row][i*8 + j + 1] := 1
       else
         ConfMeterModule.clKalenGrid[Row][i*8 + j + 1] := 0;
     end;
   ConfMeterModule.sgKalendar.Refresh;
end;

procedure TConfMeterAuto.ReadSumSeasonReq(var pMsg : CMessage);
var Year, Month, Day  : word;
    Hour, Min, Sec    : word;
begin
   if pMsg.m_sbyInfo[3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   Sec   := pMsg.m_sbyInfo[4];
   Min   := pMsg.m_sbyInfo[5];
   Hour  := pMsg.m_sbyInfo[6];
   Day   := pMsg.m_sbyInfo[7];
   Month := pMsg.m_sbyInfo[8];
   Year  := pMsg.m_sbyInfo[9] + 2000;
   ConfMeterModule.dtSummerSeason.DateTime := EncodeDate(Year, Month, Day) +
                                        EncodeTime(Hour, Min, Sec, 0);
end;

procedure TConfMeterAuto.ReadWinSeasonReq(var pMsg : CMessage);
var Year, Month, Day  : word;
    Hour, Min, Sec    : word;
begin
   if pMsg.m_sbyInfo[3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   Sec   := pMsg.m_sbyInfo[4];
   Min   := pMsg.m_sbyInfo[5];
   Hour  := pMsg.m_sbyInfo[6];
   Day   := pMsg.m_sbyInfo[7];
   Month := pMsg.m_sbyInfo[8];
   Year  := pMsg.m_sbyInfo[9] + 2000;
   ConfMeterModule.dtWinterSeason.DateTime := EncodeDate(Year, Month, Day) +
                                        EncodeTime(Hour, Min, Sec, 0);
end;

procedure TConfMeterAuto.ReadDateTimeReq(var pMsg : CMessage);
var dt_Meter : TDateTime;
    dt_Delta : TDateTime;
begin
   dt_Meter := 0;
   dt_Meter := EncodeDate(pMsg.m_sbyInfo[9] + 2000, pMsg.m_sbyInfo[8], pMsg.m_sbyInfo[7]) +
               EncodeTime(pMsg.m_sbyInfo[6], pMsg.m_sbyInfo[5], pMsg.m_sbyInfo[4], 0);
   dt_Delta := abs(Now - dt_Meter);
   ConfMeterModule.lbTimeMetAndUSPD.Caption := 'Время счетчика: ' + DateTimeToStr(dt_Meter) + '; Разница: ' +
                                               TimeToStr(dt_Delta); 
end;

procedure TConfMeterAuto.ReadUpdateDataReq(var pMsg : CMessage);
begin
  if pMsg.m_sbyInfo[3] = 4 then
  begin
    ConfMeterModule.CreateErrorMSG(ER_CONF_PASSW);
    exit;
  end;
  if pMsg.m_sbyInfo[3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
end;

procedure TConfMeterAuto.ReadGsmConAns(var pMsg : CMessage);
begin
   if pMsg.m_sbyType <> QL_CONNCOMPL_REQ then
   begin
     ErrorRecive;
     exit;
   end else m_blIsModemOpen := true;
end;

procedure TConfMeterAuto.ReadGsmDicsAns(var pMsg : CMessage);
begin
   m_blIsModemOpen := false;
end;

procedure TConfMeterAuto.ReadBTIConReq(var pMsg : CMessage);
begin
   if pMsg.m_sbyInfo[6] = 9 then
     ErrorRecive;
   if m_blFreePort=True then
   Begin
    CreateFreePort;
    m_blFreePort := False;
   End;
end;

procedure TConfMeterAuto.CreateReq(fnc, pID, sp0, sp1, sp2 : byte);
begin
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := fnc;
   m_nTxMsg.m_sbyInfo[2] := pID;
   m_nTxMsg.m_sbyInfo[3] := sp0;
   m_nTxMsg.m_sbyInfo[4] := sp1;
   m_nTxMsg.m_sbyInfo[5] := sp2;
   CRC_CC301(m_nTxMsg.m_sbyInfo, 6);
end;

procedure TConfMeterAuto.CreateReadReq;
begin
   with QuerryReq do
     CreateReq(3, Equee[Yn].m_swParamID, Equee[Yn].m_swSpecc0, Equee[Yn].m_swSpecc1, Equee[Yn].m_swSpecc2);
   CreateMSGHead(m_nTxMsg, 11 + 6 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateGsmConReq;
Var
    pDS       : CMessageData;
    nLen, i   : Integer;
    PortID    : Byte;
begin
   if not IsGsmKanal then
   begin
     ConfMeterModule.CreateErrorMSG(ER_CONF_GSM_PORT);
     GoToEndQuerry;
     exit;
   end;
   nLen            := Length(ConfMeterModule.edTelGsmCon.Text)+1;
   pDS.m_swData0   := nLen-1;
   pDS.m_swData1   := 60;
   SendPMSG(BOX_L1,GetRealPort(FindPortID),DIR_L2TOL1,PH_RESET_PORT_IND);
   //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Вызов абонента тел.:'+ConfMeterModule.edTelGsmCon.Text);
   if nLen<50 then
   begin
     for i:=0 to nLen-1 do
       pDS.m_sbyInfo[i] := Byte(ConfMeterModule.edTelGsmCon.Text[i+1]);
     pDS.m_sbyInfo[nLen] := Byte(#0);
     SendMsgIData(BOX_L1,0,GetRealPort(FindPortID),DIR_L2TOL1,PH_CONN_IND,pDS);
   end;
   m_blIsModemOpen := true;
end;

procedure TConfMeterAuto.CreateGsmDiscReq;
var PortID : byte;
begin
   PortID := FindPortID;
   if FindPortID <> High(byte) then
     SendPMSG(BOX_L1,GetRealPort(PortID),DIR_L2TOL1,PH_DISC_IND);
end;
procedure TConfMeterAuto.CreateFreePort;
var PortID : byte;
begin
   PortID := FindPortID;
   if FindPortID <> High(byte) then
     SendPMSG(BOX_L1,GetRealPort(PortID),DIR_L2TOL1,PH_FREE_PORT_IND);
end;
procedure TConfMeterAuto.CreateOpenPort;
var PortID : byte;
begin
   PortID := FindPortID;
   if FindPortID <> High(byte) then
     SendPMSG(BOX_L1,GetRealPort(PortID),DIR_L2TOL1,PH_RESET_PORT_IND);
end;

procedure TConfMeterAuto.CreateOpenBTIKanalTranzReq;
begin
   m_nTxMsg.m_sbyInfo[0] := $55;
   m_nTxMsg.m_sbyInfo[1] := $01;
   m_nTxMsg.m_sbyInfo[2] := $00;
   m_nTxMsg.m_sbyInfo[3] := $0E;
   m_nTxMsg.m_sbyInfo[4] := $00;
   m_nTxMsg.m_sbyInfo[5] := $F8;
   m_nTxMsg.m_sbyInfo[6] := ConfMeterModule.seVMAddress.Value div $100;
   m_nTxMsg.m_sbyInfo[7] := ConfMeterModule.seVMAddress.Value mod $100;
   m_nTxMsg.m_sbyInfo[8] := $00;
   m_nTxMsg.m_sbyInfo[9] := QuerryReq.Equee[QuerryReq.Yn].m_swSpecc0;
   m_nTxMsg.m_sbyInfo[10]:= $55;
   m_nTxMsg.m_sbyInfo[11]:= $55;
   CRC_BTI(m_nTxMsg.m_sbyInfo, 12);
   CreateMSGHead(m_nTxMsg, 11 + 12 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateVerifReq;
begin
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 31;
   m_nTxMsg.m_sbyInfo[2] := 0;
   m_nTxMsg.m_sbyInfo[3] := 0;
   if Length(ConfMeterModule.edPassword.Text) <> 8 then
   begin
     ConfMeterModule.CreateErrorMSG(ER_CONF_PASSW);
     exit;
   end;
   move(ConfMeterModule.edPassword.Text[1], m_nTxMsg.m_sbyInfo[4], 8);
   CRC_CC301(m_nTxMsg.m_sbyInfo, 12);
   CreateMSGHead(m_nTxMsg, 11 + 12 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateUpdDateTimeReq;
var Year, Month, Day   : word;
    Hour, Min, Sec, ms : word;
begin
   DecodeDate(Now, Year, Month, Day);
   DecodeTime(Now, Hour, Min, Sec, ms);
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 16;
   m_nTxMsg.m_sbyInfo[2] := 32;
   m_nTxMsg.m_sbyInfo[3] := 2;
   m_nTxMsg.m_sbyInfo[4] := Sec;
   m_nTxMsg.m_sbyInfo[5] := Min;
   m_nTxMsg.m_sbyInfo[6] := Hour;
   m_nTxMsg.m_sbyInfo[7] := Day;
   m_nTxMsg.m_sbyInfo[8] := Month;
   m_nTxMsg.m_sbyInfo[9] := Year - 2000;
   CRC_CC301(m_nTxMsg.m_sbyInfo, 10);
   CreateMSGHead(m_nTxMsg, 11 + 10 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateUpdPHAddrReq;
var phAddr  : integer;
begin
   phAddr                := ConfMeterModule.spNewPHAddress.Value;
   if (phAddr = 0) or (phAddr > 255) then
   begin
     ConfMeterModule.CreateErrorMSG(ER_CONF_FORMAT_PHADDR);
     exit;
   end;
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 16;
   m_nTxMsg.m_sbyInfo[2] := 21;
   m_nTxMsg.m_sbyInfo[3] := 0;
   m_nTxMsg.m_sbyInfo[4] := ConfMeterModule.sePHAddress.Value;
   CRC_CC301(m_nTxMsg.m_sbyInfo, 5);
   CreateMSGHead(m_nTxMsg, 11 + 5 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateUpdPortConfReq;
var Speed       : word;
    Par, Bit    : byte;
begin
   if (ConfMeterModule.cbSpeed.ItemIndex = -1) or (ConfMeterModule.cbParitet.ItemIndex = -1)
       or (ConfMeterModule.cbStopBit.ItemIndex = -1) then
   begin
     ConfMeterModule.CreateErrorMSG(ER_CONF_PORT);
     exit;
   end;
   Speed := StrToInt(ConfMeterModule.cbSpeed.Items[ConfMeterModule.cbSpeed.ItemIndex]);
   Par   := ConfMeterModule.cbParitet.ItemIndex;
   Bit   := ConfMeterModule.cbStopBit.ItemIndex + 1;
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 16;
   m_nTxMsg.m_sbyInfo[2] := 23;
   m_nTxMsg.m_sbyInfo[3] := 0;
   move(Speed, m_nTxMsg.m_sbyInfo[4], 2);
   m_nTxMsg.m_sbyInfo[6] := 1;
   m_nTxMsg.m_sbyInfo[7] := 8;
   m_nTxMsg.m_sbyInfo[8] := Par;
   m_nTxMsg.m_sbyInfo[9] := Bit;
   CRC_CC301(m_nTxMsg.m_sbyInfo, 10);
   CreateMSGHead(m_nTxMsg, 11 + 10 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateUpdKIReq;
var KoefI, KoefU   : integer;
begin
   if (ConfMeterModule.edKI.Text = '') or (ConfMeterModule.edKU.Text = '') then
   begin
     ErrorRecive;
     exit;
   end;
   KoefI  := StrToInt(ConfMeterModule.edKI.Text);
   KoefU  := StrToInt(ConfMeterModule.edKU.Text);
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 16;
   m_nTxMsg.m_sbyInfo[2] := 34;
   m_nTxMsg.m_sbyInfo[3] := 0;

   move(KoefI, m_nTxMsg.m_sbyInfo[4], 4);
   move(KoefU, m_nTxMsg.m_sbyInfo[8], 4);
   
   CRC_CC301(m_nTxMsg.m_sbyInfo, 8);
   CreateMSGHead(m_nTxMsg, 11 + 8 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateUpdKUReq;
var Koef   : integer;
begin
   Koef  := StrToInt(ConfMeterModule.edKU.Text);
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 16;
   m_nTxMsg.m_sbyInfo[2] := 34;
   m_nTxMsg.m_sbyInfo[3] := 0;
   move(Koef, m_nTxMsg.m_sbyInfo[4], 4);
   CRC_CC301(m_nTxMsg.m_sbyInfo, 8);
   CreateMSGHead(m_nTxMsg, 11 + 8 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateUpdPasswReq;
begin
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 16;
   m_nTxMsg.m_sbyInfo[2] := 37;
   m_nTxMsg.m_sbyInfo[3] := 0;
   if Length(ConfMeterModule.edNewPassword.Text) <> 8 then
   begin
     ConfMeterModule.CreateErrorMSG(ER_CONF_FORMAT_PASSW);
     exit;
   end;
   move(ConfMeterModule.edNewPassword.Text[1], m_nTxMsg.m_sbyInfo[4], 8);
   CRC_CC301(m_nTxMsg.m_sbyInfo, 12);
   CreateMSGHead(m_nTxMsg, 11 + 12 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateUpdAdvPasswReq;
begin
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 16;
   m_nTxMsg.m_sbyInfo[2] := 37;
   m_nTxMsg.m_sbyInfo[3] := 1;
   if Length(ConfMeterModule.edAdvPassword.Text) <> 8 then
   begin
     ConfMeterModule.CreateErrorMSG(ER_CONF_FORMAT_ADVPASSW);
     exit;
   end;
   move(ConfMeterModule.edAdvPassword.Text[1], m_nTxMsg.m_sbyInfo[4], 8);
   CRC_CC301(m_nTxMsg.m_sbyInfo, 12);
   CreateMSGHead(m_nTxMsg, 11 + 12 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateUpdTarReq;
begin
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 16;
   m_nTxMsg.m_sbyInfo[2] := 30 + ConfMeterModule.cbWorkPrDay.ItemIndex;
   m_nTxMsg.m_sbyInfo[3] := QuerryReq.Equee[QuerryReq.Yn].m_swSpecc0;
//
   move(ConfMeterModule.clTarifGrid, m_nTxMsg.m_sbyInfo[4], 48);
   CRC_CC301(m_nTxMsg.m_sbyInfo, 52);
   CreateMSGHead(m_nTxMsg, 11 + 52 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateUpdCalReq;
var Year, Month, Day, Row : word;
    i, j                  : byte;
    BitMask               : array [0..3] of byte;
begin
   DecodeDate(Now, Year, Month, Day);
   Year := Year - 2000;
   if QuerryReq.Equee[QuerryReq.Yn].m_swSpecc2 >= Month then
     Row := QuerryReq.Equee[QuerryReq.Yn].m_swSpecc2 - Month + 1
   else
   begin
     Row := 12 - (Month - QuerryReq.Equee[QuerryReq.Yn].m_swSpecc2) + 1;
     //Inc(Year);
   end;
   FillChar(BitMask, 4, 0);
   for i := 0 to 3 do
     for j := 0 to 7 do
     begin
       if (i = 3) and (j = 7) then
         continue;
       if (ConfMeterModule.clKalenGrid[Row][i*8 + j + 1] and 1) <> 0 then
         BitMask[i] := BitMask[i] or __SetMask[j];
     end;
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 16;
   m_nTxMsg.m_sbyInfo[2] := 29;
   m_nTxMsg.m_sbyInfo[3] := QuerryReq.Equee[QuerryReq.Yn].m_swSpecc2;
   move(BitMask, m_nTxMsg.m_sbyInfo[4], 4);
   //for i := 0 to 3 do
   //  m_nTxMsg.m_sbyInfo[i] := BitMask[3 - i];
   m_nTxMsg.m_sbyInfo[8] := Year + QuerryReq.Equee[QuerryReq.Yn].m_swSpecc0;
   CRC_CC301(m_nTxMsg.m_sbyInfo, 9);
   CreateMSGHead(m_nTxMsg, 11 + 9 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.CreateUpdSumWinDateReq;
var Year, Month, Day   : word;
    Hour, Min, Sec, ms : word;
begin
   if ConfMeterModule.rbNoActionKal.Checked then
     exit;
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[2] := QuerryReq.Equee[QuerryReq.Yn].m_swParamID;
   m_nTxMsg.m_sbyInfo[3] := 0;
   if ConfMeterModule.rbResetActKal.Checked then
   begin
     m_nTxMsg.m_sbyInfo[1] := 30;
     CRC_CC301(m_nTxMsg.m_sbyInfo, 4);
     CreateMSGHead(m_nTxMsg, 11 + 4 + 2);
   end
   else
   begin
     m_nTxMsg.m_sbyInfo[1] := 16;
     if QuerryReq.Equee[QuerryReq.Yn].m_swParamID = 27 then
     begin
       DecodeDate(ConfMeterModule.dtSummerSeason.DateTime, Year, Month, Day);
       DecodeTime(ConfMeterModule.dtSummerSeason.DateTime, Hour, Min, Sec, ms);
     end
     else
     begin
       DecodeDate(ConfMeterModule.dtWinterSeason.DateTime, Year, Month, Day);
       DecodeTime(ConfMeterModule.dtWinterSeason.DateTime, Hour, Min, Sec, ms);
     end;
     m_nTxMsg.m_sbyInfo[4] := Sec;
     m_nTxMsg.m_sbyInfo[5] := Min;
     m_nTxMsg.m_sbyInfo[6] := Hour;
     m_nTxMsg.m_sbyInfo[7] := Day;
     m_nTxMsg.m_sbyInfo[8] := Month;
     m_nTxMsg.m_sbyInfo[9] := Year - 2000;
     CRC_CC301(m_nTxMsg.m_sbyInfo, 10);
     CreateMSGHead(m_nTxMsg, 11 + 10 + 2);
   end;
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;
procedure TConfMeterAuto.ConfigShell;
begin
    case QuerryReq.Equee[QuerryReq.Yn].m_swMtrID of
     ST_CONF_NULL               : {ConfMeterAuto.StartTranz};
     ST_CONF_BTI_CONN           : CreateOpenBTIKanalTranzReq;
     ST_CONF_CHECK_PASSW        : CreateVerifReq;
     ST_CONF_UPD_DATETIME       : CreateUpdDateTimeReq;
     ST_CONF_UPD_PHADDR         : CreateUpdPHAddrReq;
     ST_CONF_UPD_PORTCONF       : CreateUpdPortConfReq;
     ST_CONF_UPD_KI             : CreateUpdKIReq;
     ST_CONF_UPD_KU             : CreateUpdKIReq;
     ST_CONF_UPD_PASSW          : CreateUpdPasswReq;
     ST_CONF_UPD_ADVPASSW       : CreateUpdAdvPasswReq;
     ST_CONF_UPD_TARIFF         : CreateUpdTarReq;
     ST_CONF_UPD_CALENDAR       : CreateUpdCalReq;
     ST_CONF_UPD_NEW_SUMSEASON,
     ST_CONF_UPD_NEW_WINSEASON  : CreateUpdSumWinDateReq;
     ST_CONF_READ_PORTCONF, ST_CONF_READ_KU,
     ST_CONF_READ_KI, ST_CONF_READ_TARIFF,
     ST_CONF_READ_CALENDAR, ST_CONF_READ_SUMSEASON,
     ST_CONF_READ_WINSEASON, ST_CONF_READ_DATE_TIME
                                : CreateReadReq;
     ST_CONF_GSM_CONN           : CreateGsmConReq;
     ST_CONF_GSM_DISC           : CreateGsmDiscReq;
     ST_CONF_FINISH             : exit;
   end;
   QuerryToProgBar;
end;

function  TConfMeterAuto.SelfHandler(var pMsg : CMessage):Boolean;
begin
   if (pMsg.m_sbyType=AL_REPMSG_TMR) and (QuerryReq.ReqCount = 0) then
     ErrorRecive
   else
   begin
     Dec(QuerryReq.ReqCount);
     ConfMeterModule.SetReqInfo;
     FPUT(BOX_L1, @m_nTxMsg);
     m_nRepTimer.OnTimer(m_sbyRepTime);
   end;  
   Result := true;
end;

function  TConfMeterAuto.LoHandler(var pMsg : CMessage):Boolean;
begin
   Result := true;
   if not (IsActive and m_nRepTimer.IsProceed) and (QuerryReq.Equee[QuerryReq.Yn].m_swMtrID <> ST_CONF_GSM_CONN)
      and ((QuerryReq.Equee[QuerryReq.Yn].m_swMtrID <> ST_CONF_GSM_DISC)) then exit;         //Если модуль не активен пропускаем все сообщения
   case pMsg.m_sbyType of
     PH_DATA_IND :
     begin
       if (QuerryReq.Equee[QuerryReq.Yn].m_swMtrID = ST_CONF_BTI_CONN) and (not CRC_BTI(pMsg.m_sbyInfo[0], pMsg.m_swLen - 11 - 2)) then
       begin
         ErrorRecive;
         exit;
       end;
       if (QuerryReq.Equee[QuerryReq.Yn].m_swMtrID <> ST_CONF_BTI_CONN) and (not CRC_CC301(pMsg.m_sbyInfo[0], pMsg.m_swLen - 11 - 2)) then
       begin
         ErrorRecive;
         exit;
       end;
       if (m_nTxMsg.m_sbyInfo[0] <> pMsg.m_sbyInfo[0]) and (QuerryReq.Equee[QuerryReq.Yn].m_swMtrID <> ST_CONF_BTI_CONN)  then
       begin
         ConfigShell;
         exit;
       end;
       case QuerryReq.Equee[QuerryReq.Yn].m_swMtrID of
           ST_CONF_BTI_CONN           : ReadBTIConReq(pMsg);
         ST_CONF_UPD_DATETIME, ST_CONF_UPD_PHADDR,
         ST_CONF_UPD_PORTCONF, ST_CONF_UPD_KI,
         ST_CONF_UPD_KU, ST_CONF_UPD_PASSW,
         ST_CONF_UPD_ADVPASSW, ST_CONF_UPD_TARIFF,
         ST_CONF_UPD_CALENDAR, ST_CONF_UPD_NEW_SUMSEASON,
         ST_CONF_UPD_NEW_WINSEASON,
         ST_CONF_CHECK_PASSW        : ReadUpdateDataReq(pMsg);
         ST_CONF_READ_KU            : ReadKUReq(pMsg);
         ST_CONF_READ_KI            : ReadKIReq(pMsg);
         ST_CONF_READ_PORTCONF      : ReadSpeedReq(pMsg);
         ST_CONF_READ_TARIFF        : ReadTarifReq(pMsg);
         ST_CONF_READ_CALENDAR      : ReadKalenReq(pMsg);
         ST_CONF_READ_SUMSEASON     : ReadSumSeasonReq(pMsg);
         ST_CONF_READ_WINSEASON     : ReadWinSeasonReq(pMsg);
         ST_CONF_READ_DATE_TIME     : ReadDateTimeReq(pMsg);
         //ST_CONF_GSM_CONN           : ReadGsmConAns(pMsg);
         //ST_CONF_GSM_DISC           : ReadGsmDicsAns(pMsg);
         ST_CONF_FINISH             : exit;
       end;
     end;
     QL_CONNCOMPL_REQ : if QuerryReq.Equee[QuerryReq.Yn].m_swMtrID <> ST_CONF_GSM_CONN then exit
                        else ReadGsmConAns(pMsg);
     PH_MDISCSCMPL_IND, PH_MNOCA_IND, PH_MNANS_IND, PH_MBUSY_IND :
                        Begin
                         if IsOpenTranz=True then
                         Begin
                          //if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Транзитный канал установлен на 4 минуты!');
                          IsOpenTranz := False;
                         End;
                         if QuerryReq.Equee[QuerryReq.Yn].m_swMtrID = ST_CONF_GSM_CONN then
                         begin
                           GoToEndQuerry;
                           ReadGsmDicsAns(pMsg);
                         end;
                        End;
     else begin ConfigShell; exit; end;
   end;
   m_nRepTimer.OffTimer;
   if IncStateQuerry then
     ConfigShell
   else
   begin
     ConfMeterModule.lbProgressParam.Caption  := 'Операция завершена';
     ConfMeterModule.prProgressParam.Position := 100;
     ConfMeterModule.Refresh;
   end;
end;

function  TConfMeterAuto.HiHandler(var pMsg : CMessage):Boolean;
begin
   Result := true;
end;

procedure TConfMeterAuto.RunAuto;
begin

end;

procedure TConfMeterAuto.StopAuto;
begin
   if m_sIsTranzOpen.m_sbIsTrasnBeg then
     FinishTranz;
   ResetQuerry;
end;

procedure TConfMeterAuto.ResetAuto;
begin
   ConfMeterModule.lbProgressParam.Caption  := 'Ожидание';
   ConfMeterModule.prProgressParam.Position := 0;
   ResetQuerry;
end;

procedure TConfMeterAuto.ErrorRecive;
begin
   m_nRepTimer.OffTimer;
   ConfMeterModule.lbProgressParam.Caption  := 'Ожидание';
   ConfMeterModule.prProgressParam.Position := 0;
   MessageDlg('Ошибка принятия сообщения!',mtWarning,[mbOk],0);
   CreateGsmDiscReq;
   //ConfigShell;
end;

procedure TConfMeterAuto.AddReqToQuerry(st, par, spec0, spec1, spec2 : byte);
begin
   QuerryReq.Equee[QuerryReq.Yk].m_swMtrID   := st;
   QuerryReq.Equee[QuerryReq.Yk].m_swParamID := par;
   QuerryReq.Equee[QuerryReq.Yk].m_swSpecc0  := spec0;
   QuerryReq.Equee[QuerryReq.Yk].m_swSpecc1  := spec1;
   QuerryReq.Equee[QuerryReq.Yk].m_swSpecc2  := spec2;
   Inc(QuerryReq.Yk);
   QuerryReq.Perc := round(QuerryReq.Yn/QuerryReq.Yk*100);
end;

function TConfMeterAuto.IncStateQuerry : boolean;
begin
   Result := true;
   QuerryReq.ReqCount := 5;
   if QuerryReq.Yn < QuerryReq.Yk then
     Inc(QuerryReq.Yn);
   if QuerryReq.Yk <> 0 then
     QuerryReq.Perc := round(QuerryReq.Yn/QuerryReq.Yk*100)
   else
     QuerryReq.Perc := 0;
   if QuerryReq.Yn = QuerryReq.Yk then
     Result := false;
end;

procedure TConfMeterAuto.GoToEndQuerry;
begin
   QuerryReq.Yn := QuerryReq.Yk;
   if QuerryReq.Yk <> 0 then
     QuerryReq.Perc := round(QuerryReq.Yn/QuerryReq.Yk*100)
   else
     QuerryReq.Perc := 0;
end;

procedure TConfMeterAuto.ResetQuerry;
begin
   QuerryReq.Yn   := 0;
   QuerryReq.Yk   := 0;
   QuerryReq.Perc := 0;
end;

procedure TConfMeterAuto.QuerryToProgBar;
begin
   ConfMeterModule.lbProgressParam.Caption  := chConfState[QuerryReq.Equee[QuerryReq.Yn].m_swMtrID]
       + '(' + IntToStr(QuerryReq.ReqCount) + ')' ;
   ConfMeterModule.prProgressParam.Position := QuerryReq.perc;
   ConfMeterModule.Refresh;
end;

function TConfMeterAuto.GetRealPort(nPort:Integer):Integer;
Var
    i : Integer;
Begin
    Result := nPort;
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

function TConfMeterAuto.CRC_CC301(var buf : array of byte; cnt : integer):boolean;
var
    CRChiEl             : byte;
    CRCloEl             : byte;
    i                   : integer;
    idx                 : byte;
begin
    Result  := true;
    CRChiEl := $FF;
    CRCloEl := $FF;
    for i:=0 to cnt - 1 do
    begin
     idx       := (CRChiEl Xor buf[i]) And $FF;
     CRChiEl   := (CRCloEl Xor CRCHI[idx]);
     CRCloEl   := CRCLO[idx];
    end;
    if (CRCloEl <> buf[cnt]) or (CRChiEl <> buf[cnt+1]) then
      Result := false;
    buf[cnt]    := CRCloEl;
    buf[cnt+1]  := CRChiEl;
end;

function  TConfMeterAuto.CRC_BTI(var buf : array of byte; count : integer):boolean;
var i                 : integer;
    CRCHi, CRCLo, ind : byte;
begin
  CRCHi   := $FF;
  CRCLo   := $FF;
  Result  := true;
  for i := 0 to count - 1 do
  begin
    ind:= CRCHi xor buf[i];
    CRCHi:= CRCLo xor srCRCHi[ind];
    CRCLo:= srCRCLo[ind];
  end;
  if (buf[count] <> CRCHi) or (buf[count+1] <> CRCLo) then
    Result := false;
  buf[count]   := CRCHi;
  buf[count+1] := CRCLo;
end;

procedure TConfMeterModule.seVMAddressChange(Sender: TObject);
var MeterCapt : string;
begin
//   GetPhAdrAndNameMeter   m_blIsSlave
   {if not m_blIsSlave then
   begin
     ConfMeterAuto.GetPhAdrAndNameMeter(seVMAddress.Value, MeterCapt, PhabNum);
     ConfMeterModule.Caption := 'Параметризация счетчика: ' + MeterCapt;
   end;}
end;

procedure TConfMeterModule.sePHAddressChange(Sender: TObject);
var MeterCapt : string;
begin
   {if m_blIsSlave then
   begin
     ConfMeterAuto.GetPhAdrAndNameMeter(sePHAddress.Value, MeterCapt, PhabNum);
     ConfMeterModule.Caption := 'Параметризация счетчика: ' + MeterCapt;
   end;}
end;

procedure TConfMeterModule.Ondisconnect(Sender: TObject);
begin
   ConfMeterAuto.CreateGsmDiscReq;
end;

procedure TConfMeterModule.rbClearKalClick(Sender: TObject);
var i, j : integer;
begin
   for i := 1 to 12 do
     for j := 1 to 31 do
       clKalenGrid[i, j] := 0;
   sgKalendar.Refresh;
end;

procedure TConfMeterModule.OnClosePhone(Sender: TObject);
begin
   //if cbm_nFreePort.Checked=True then
   Begin
    if cbm_nFreePort.Checked=True then ConfMeterAuto.CreateOpenPort;
    ConfMeterAuto.CreateGsmDiscReq;
    ConfMeterAuto.m_blFreePort := False;
   End;
end;

end.
