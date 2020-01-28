unit knsl4ConfMeterModule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RbDrawCore, RbButton, ComCtrls, AdvProgr, StdCtrls, Spin, ExtCtrls, utldynconnect,
  utltypes,utlbox,utlconst,utlmtimer,knsl4automodule,knsl5config,knsl5tracer,utldatabase, utlTimeDate,
  AdvAppStyler, AdvOfficePager, WinXP, AdvOfficePagerStylers,
  AdvOfficeButtons, Grids, BaseGrid, AdvGrid, AdvPanel, AdvDateTimePicker,FileCtrl,
  GradientLabel, AdvToolBar, AdvToolBarStylers, ImgList;
type TQuerryReq = packed record
     Yn, Yk      : byte;
     perc        : byte;
     Equee       : array [0..20] of CQueryPrimitive;
   end;

type
  TConfMeterAuto = class(CHIAutomat)
  private
    IsActive           : boolean;
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
    function  FindPortID : byte;
    function  IsGsmKanal : boolean;
    procedure StartTranz;
    procedure FinishTranz;
    procedure GetPhAdrAndNameMeter(Ph : integer; var PHAddr, Name : string);
    procedure CreateGsmConReq;
    procedure CreateGsmDiscReq;
    procedure CreateOpenBTIKanalTranzReq;
    //function  GetTelNumb(PortID): string;

    //  Функции для параметризации счетчиков СС-301/101
    procedure SS301_CreateMSGHead(var pMsg :CMessage; Size :byte);
    procedure SS301_CreateReq(fnc, pID, sp0, sp1, sp2 : byte);
    procedure SS301_CreateReadReq;
    procedure SS301_CreateVerifReq;
    procedure SS301_CreateUpdDateTimeReq;
    procedure SS301_CreateUpdPHAddrReq;
    procedure SS301_CreateUpdPortConfReq;
    procedure SS301_CreateUpdKIReq;
    procedure SS301_CreateUpdKUReq;
    procedure SS301_CreateUpdPasswReq;
    procedure SS301_CreateUpdAdvPasswReq;
    procedure SS301_CreateUpdTarReq;
    procedure SS301_CreateUpdCalReq;
    procedure SS301_CreateUpdSumWinDateReq;
    procedure SS301_ReadSpeedReq(var pMsg : CMessage);
    procedure SS301_ReadKIReq(var pMsg : CMessage);
    procedure SS301_ReadTarifReq(var pMsg : CMessage);
    procedure SS301_ReadKUReq(var pMsg : CMessage);
    procedure SS301_ReadKalenReq(var pMsg : CMessage);
    procedure SS301_ReadSumSeasonReq(var pMsg : CMessage);
    procedure SS301_ReadWinSeasonReq(var pMsg : CMessage);
    procedure SS301_ReadDateTimeReq(var pMsg : CMessage);
    procedure SS301_ReadUpdateDataReq(var pMsg : CMessage);


    //  Функции для параметризации счетчиков СС-301/101
    procedure C12_CreateMSGHead(var pMsg :CMessage; Size :byte);
    procedure C12_FillMessageInfo(var _Buffer : array of byte; _Length : word; _FNC : BYTE);
    procedure C12_CreateReq(fnc, pID, sp0, sp1, sp2 : byte);
    procedure C12_CreateReadReq();
    procedure C12_CreateVerifReq();
    procedure C12_CreateAuthorizationReq();
    procedure C12_CreateUpdDateTimeReq();
    procedure C12_CreateUpdPHAddrReq();
    procedure C12_CreateUpdPortConfReq();
    procedure C12_CreateUpdKIReq();
    procedure C12_CreateUpdKUReq();
    procedure C12_CreateUpdPasswReq();
    procedure C12_CreateUpdAdvPasswReq();
    procedure C12_CreateUpdTarReq();
    procedure C12_CreateUpdCalReq();
    procedure C12_CreateUpdSumWinDateReq();
    procedure C12_ReadSpeedReq(var pMsg : CMessage);
    procedure C12_ReadKIKUReq(var pMsg : CMessage);
    procedure C12_ReadTarifReq(var pMsg : CMessage);
    procedure C12_ReadKalenReq(var pMsg : CMessage);

    procedure C12_ReadSumSeasonReq(var pMsg : CMessage);
    procedure C12_ReadWinSeasonReq(var pMsg : CMessage);
    procedure C12_ReadDateTimeReq(var pMsg : CMessage);
    procedure C12_ReadUpdateDataReq(var pMsg : CMessage);
    procedure C12_ReadAuthorization(var pMsg : CMessage);


    procedure ReadGsmConAns(var pMsg : CMessage);
    procedure ReadGsmDicsAns(var pMsg : CMessage);
    procedure ReadBTIConReq(var pMsg : CMessage);
    procedure ErrorRecive;
    function  GetRealPort(nPort:Integer):Integer;
    function  CRC_CC301(var buf : array of byte; cnt : integer):boolean;
    function  CRC_BTI(var buf : array of byte; count : integer):boolean;
    function  CRC16(var _Buff : array of BYTE; _Count : WORD; _SetCRC16 : Boolean) : Boolean;
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
    lbProgressParam: TGradientLabel;
    ImageList1: TImageList;
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
    GradientLabel5: TGradientLabel;
    GradientLabel7: TGradientLabel;
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
    RbButton1: TRbButton;
    TarifSetPage: TAdvOfficePage;
    Label1: TLabel;
    Label9: TLabel;
    sgTariffs: TAdvStringGrid;
    cbMonthTarif: TComboBox;
    cbWorkPrDay: TComboBox;
    rbClearTariffs: TRbButton;
    chbSetAllYear: TAdvOfficeCheckBox;
    rbLoadTarFrFile: TRbButton;
    rbSaveTrToFile: TRbButton;
    AdvOfficePager13: TAdvOfficePage;
    Label12: TLabel;
    Label17: TLabel;
    GradientLabel2: TGradientLabel;
    sgKalendar: TAdvStringGrid;
    rbNoActionKal: TAdvOfficeRadioButton;
    rbResetActKal: TAdvOfficeRadioButton;
    rbUpdateActKal: TAdvOfficeRadioButton;
    dtSummerSeason: TAdvDateTimePicker;
    dtWinterSeason: TAdvDateTimePicker;
    chbKalUpdate: TAdvOfficeCheckBox;
    rbClearKal: TRbButton;
    TransOpenPage: TAdvOfficePage;
    lbTranzOpen: TLabel;
    GradientLabel6: TGradientLabel;
    cbTranzTime: TComboBox;
    rbTranzOpen: TRbButton;
    AdvPanel2: TAdvPanel;
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
    procedure seVMAddressChange(Sender: TObject);
    procedure sePHAddressChange(Sender: TObject);
    procedure OnDisconnect(Sender: TObject);
    procedure rbClearKalClick(Sender: TObject);
  private
    { Private declarations }
    procedure MakeDir;
  public
    { Public declarations }
    PhabNum     : string;
    PHAddres    : string;
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
   ConfMeterAuto.IsActive := false;
end;

procedure TConfMeterModule.FormShow(Sender: TObject);
var Year, Month, Day, i : word;
    TempDate            : TDateTime;
begin
   ConfMeterAuto.m_sbyRepTime := m_sbyReply; 
   lbTimeMetAndUSPD.Caption := 'Время счетчика неизвестно';
   DecodeDate(Now, Year, Month, Day);
   cbWorkPrDay.ItemIndex  := 0;
   cbTranzTime.ItemIndex  := 0;
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
     seVMAddress.Value := StrToInt(PHAddres);  //АРМ
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
   ConfMeterAuto.ResetAuto;
   if chbGsmCon.Checked then
     ConfMeterAuto.AddReqToQuerry(ST_CONF_GSM_CONN, 0, 0, 0, 0);
   case KalenSetPage.ActivePageIndex of
     0 : begin
           if not m_blIsSlave AND (m_ProtoID = DEV_BTI_CLI) then
             ConfMeterAuto.AddReqToQuerry(ST_CONF_BTI_CONN, 0, 10, 0, 0);
           if (m_ProtoID = utlconst.DEV_C12_SRV) then
            ConfMeterAuto.AddReqToQuerry(ST_CONF_AUTHORIZATION, 0, 0, 0, 0);
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
begin
   //ConfMeterAuto.m_nTranzTimer.OnTimer(TranzTime[cbTranzTime.ItemIndex]);
   ConfMeterAuto.ResetQuerry;
   if chbGsmCon.Checked then
     ConfMeterAuto.AddReqToQuerry(ST_CONF_GSM_CONN, 0, 0, 0, 0);
   if not m_blIsSlave then
   begin
     ConfMeterAuto.AddReqToQuerry(ST_CONF_BTI_CONN, 0, TranzTime[cbTranzTime.ItemIndex], 0, 0);
   end;
   if chbGsmCon.Checked then
     ConfMeterAuto.AddReqToQuerry(ST_CONF_GSM_DISC, 0, 0, 0, 0);
   ConfMeterAuto.ConfigShell;
end;

procedure TConfMeterModule.Ondisc(Sender: TObject);
begin
   if MessageDlg('Остановить выполнение операции с выходом из режима параметризации?',mtWarning,[mbOk,mbCancel],0)=mrOk then
   Begin
   ConfMeterAuto.StopAuto;
   ConfMeterModule.Close;
   if ConfMeterAuto.m_blIsModemOpen then
     ConfMeterAuto.CreateGsmDiscReq;
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

procedure TConfMeterAuto.InitAuto(var pTable : SL1TAG);
var i,j      : integer;
begin
   FState                        := ST_CONF_NULL;
   m_pDDB                        := m_pDB.DynConnect(7);
   m_sbyRepTime                  := 60;
   ConfMeterAuto                 := Self;
   m_sIsTranzOpen.m_sbIsTrasnBeg := false;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
   m_pDDB.GetL1Table(m_sTblL1);
   ConfMeterModule.MakeDir;
   if m_pDDB.GetMetersIniTable(Meters) then
   begin
     PhAddrAndComPrt.Count := Meters.m_swAmMeter;
     SetLength(PhAddrAndComPrt.Items, Meters.m_swAmMeter);
     for i := 0 to Meters.m_swAmMeter - 1 do
     begin
       PhAddrAndComPrt.Items[i].m_swPHAddres := StrToInt(Meters.m_sMeter[i].m_sddPHAddres);
       PhAddrAndComPrt.Items[i].m_swPortID   := GetRealPort(Meters.m_sMeter[i].m_sbyPortID);
       for j := 0 to m_sTblL1.Count do
         if (m_sTblL1.Items[j].m_sbyPortID = PhAddrAndComPrt.Items[i].m_swPortID) then
         begin
            PhAddrAndComPrt.Items[i].m_swProto := m_sTblL1.Items[j].m_sbyProtID;
            Break;
         end;
     end;
   end;
end;

procedure TConfMeterAuto.SS301_CreateMSGHead(var pMsg :CMessage; Size :byte);
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

procedure TConfMeterAuto.SS301_ReadSpeedReq(var pMsg : CMessage);
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

procedure TConfMeterAuto.SS301_ReadKIReq(var pMsg : CMessage);
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

procedure TConfMeterAuto.SS301_ReadKUReq(var pMsg : CMessage);
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

procedure TConfMeterAuto.SS301_ReadTarifReq(var pMsg : CMessage);
begin
   if pMsg.m_sbyInfo[3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   move(pMsg.m_sbyInfo[4], ConfMeterModule.clTarifGrid, 48);
   ConfMeterModule.sgTariffs.Refresh;
end;

procedure TConfMeterAuto.SS301_ReadKalenReq(var pMsg : CMessage);
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

procedure TConfMeterAuto.SS301_ReadSumSeasonReq(var pMsg : CMessage);
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

procedure TConfMeterAuto.SS301_ReadWinSeasonReq(var pMsg : CMessage);
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

procedure TConfMeterAuto.SS301_ReadDateTimeReq(var pMsg : CMessage);
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

procedure TConfMeterAuto.SS301_ReadUpdateDataReq(var pMsg : CMessage);
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

procedure TConfMeterAuto.C12_ReadAuthorization(var pMsg : CMessage);
begin
   if pMsg.m_sbyInfo[2] <> 0 then
     ErrorRecive;
end;


procedure TConfMeterAuto.ReadBTIConReq(var pMsg : CMessage);
begin
   if pMsg.m_sbyInfo[6] = 9 then
     ErrorRecive;
end;

procedure TConfMeterAuto.SS301_CreateReq(fnc, pID, sp0, sp1, sp2 : byte);
begin
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := fnc;
   m_nTxMsg.m_sbyInfo[2] := pID;
   m_nTxMsg.m_sbyInfo[3] := sp0;
   m_nTxMsg.m_sbyInfo[4] := sp1;
   m_nTxMsg.m_sbyInfo[5] := sp2;
   CRC_CC301(m_nTxMsg.m_sbyInfo, 6);
end;

procedure TConfMeterAuto.SS301_CreateReadReq;
begin
   with QuerryReq do
     SS301_CreateReq(3, Equee[Yn].m_swParamID, Equee[Yn].m_swSpecc0, Equee[Yn].m_swSpecc1, Equee[Yn].m_swSpecc2);
   SS301_CreateMSGHead(m_nTxMsg, 11 + 6 + 2);
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
   SS301_CreateMSGHead(m_nTxMsg, 11 + 12 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.SS301_CreateVerifReq;
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
   SS301_CreateMSGHead(m_nTxMsg, 11 + 12 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.SS301_CreateUpdDateTimeReq;
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
   SS301_CreateMSGHead(m_nTxMsg, 11 + 10 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.SS301_CreateUpdPHAddrReq;
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
   SS301_CreateMSGHead(m_nTxMsg, 11 + 5 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.SS301_CreateUpdPortConfReq;
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
   SS301_CreateMSGHead(m_nTxMsg, 11 + 10 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.SS301_CreateUpdKIReq;
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
   SS301_CreateMSGHead(m_nTxMsg, 11 + 8 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.SS301_CreateUpdKUReq;
var Koef   : integer;
begin
   Koef  := StrToInt(ConfMeterModule.edKU.Text);
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 16;
   m_nTxMsg.m_sbyInfo[2] := 34;
   m_nTxMsg.m_sbyInfo[3] := 0;
   move(Koef, m_nTxMsg.m_sbyInfo[4], 4);
   CRC_CC301(m_nTxMsg.m_sbyInfo, 8);
   SS301_CreateMSGHead(m_nTxMsg, 11 + 8 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.SS301_CreateUpdPasswReq;
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
   SS301_CreateMSGHead(m_nTxMsg, 11 + 12 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.SS301_CreateUpdAdvPasswReq;
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
   SS301_CreateMSGHead(m_nTxMsg, 11 + 12 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.SS301_CreateUpdTarReq;
begin
   m_nTxMsg.m_sbyInfo[0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[1] := 16;
   m_nTxMsg.m_sbyInfo[2] := 30 + ConfMeterModule.cbWorkPrDay.ItemIndex;
   m_nTxMsg.m_sbyInfo[3] := QuerryReq.Equee[QuerryReq.Yn].m_swSpecc0;
//
   move(ConfMeterModule.clTarifGrid, m_nTxMsg.m_sbyInfo[4], 48);
   CRC_CC301(m_nTxMsg.m_sbyInfo, 52);
   SS301_CreateMSGHead(m_nTxMsg, 11 + 52 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.SS301_CreateUpdCalReq;
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
   SS301_CreateMSGHead(m_nTxMsg, 11 + 9 + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.SS301_CreateUpdSumWinDateReq;
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
     SS301_CreateMSGHead(m_nTxMsg, 11 + 4 + 2);
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
     SS301_CreateMSGHead(m_nTxMsg, 11 + 10 + 2);
   end;
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.ConfigShell;
begin

   case ConfMeterModule.m_Type of
   utlconst.MET_SS101,
   utlconst.MET_SS301F3,
   utlconst.MET_SS301F4:
      case QuerryReq.Equee[QuerryReq.Yn].m_swMtrID of
         ST_CONF_NULL               : {ConfMeterAuto.StartTranz};
         ST_CONF_BTI_CONN           : CreateOpenBTIKanalTranzReq;
         ST_CONF_CHECK_PASSW        : SS301_CreateVerifReq;
         ST_CONF_UPD_DATETIME       : SS301_CreateUpdDateTimeReq;
         ST_CONF_UPD_PHADDR         : SS301_CreateUpdPHAddrReq;
         ST_CONF_UPD_PORTCONF       : SS301_CreateUpdPortConfReq;
         ST_CONF_UPD_KI             : SS301_CreateUpdKIReq;
         ST_CONF_UPD_KU             : SS301_CreateUpdKIReq; // @todo: возможно SS301_CreateUpdKUReq
         ST_CONF_UPD_PASSW          : SS301_CreateUpdPasswReq;
         ST_CONF_UPD_ADVPASSW       : SS301_CreateUpdAdvPasswReq;
         ST_CONF_UPD_TARIFF         : SS301_CreateUpdTarReq;
         ST_CONF_UPD_CALENDAR       : SS301_CreateUpdCalReq;
         ST_CONF_UPD_NEW_SUMSEASON,
         ST_CONF_UPD_NEW_WINSEASON  : SS301_CreateUpdSumWinDateReq;
         ST_CONF_READ_PORTCONF, ST_CONF_READ_KU,
         ST_CONF_READ_KI, ST_CONF_READ_TARIFF,
         ST_CONF_READ_CALENDAR, ST_CONF_READ_SUMSEASON,
         ST_CONF_READ_WINSEASON, ST_CONF_READ_DATE_TIME
                                    : SS301_CreateReadReq;
         ST_CONF_GSM_CONN           : CreateGsmConReq;
         ST_CONF_GSM_DISC           : CreateGsmDiscReq;
         ST_CONF_FINISH             : exit;
      end;

   utlconst.MET_C12 :
      case QuerryReq.Equee[QuerryReq.Yn].m_swMtrID of
         ST_CONF_NULL               : {ConfMeterAuto.StartTranz};
         ST_CONF_BTI_CONN           : CreateOpenBTIKanalTranzReq;
         ST_CONF_AUTHORIZATION      : C12_CreateAuthorizationReq();
         ST_CONF_CHECK_PASSW        : C12_CreateVerifReq;
         ST_CONF_UPD_DATETIME       : C12_CreateUpdDateTimeReq;
         ST_CONF_UPD_PHADDR         : C12_CreateUpdPHAddrReq;
         ST_CONF_UPD_PORTCONF       : C12_CreateUpdPortConfReq;
         ST_CONF_UPD_KI             : C12_CreateUpdKIReq;
         ST_CONF_UPD_KU             : C12_CreateUpdKIReq; // @todo: возможно C12_CreateUpdKUReq
         ST_CONF_UPD_PASSW          : C12_CreateUpdPasswReq;
         ST_CONF_UPD_ADVPASSW       : C12_CreateUpdAdvPasswReq;
         ST_CONF_UPD_TARIFF         : C12_CreateUpdTarReq;
         ST_CONF_UPD_CALENDAR       : C12_CreateUpdCalReq;
         ST_CONF_UPD_NEW_SUMSEASON,
         ST_CONF_UPD_NEW_WINSEASON  : C12_CreateUpdSumWinDateReq;
         ST_CONF_READ_PORTCONF, ST_CONF_READ_KU,
         ST_CONF_READ_KI, ST_CONF_READ_TARIFF,
         ST_CONF_READ_CALENDAR, ST_CONF_READ_SUMSEASON,
         ST_CONF_READ_WINSEASON, ST_CONF_READ_DATE_TIME
                                    : C12_CreateReadReq;
         ST_CONF_GSM_CONN           : CreateGsmConReq;
         ST_CONF_GSM_DISC           : CreateGsmDiscReq;
         ST_CONF_FINISH             : exit;
      end;
   end;

   QuerryToProgBar;
end;

function  TConfMeterAuto.SelfHandler(var pMsg : CMessage):Boolean;
begin
   if pMsg.m_sbyType=AL_REPMSG_TMR then
     ErrorRecive;
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

         case ConfMeterModule.m_Type of
         utlconst.MET_SS101,
         utlconst.MET_SS301F3,
         utlconst.MET_SS301F4 :
            case QuerryReq.Equee[QuerryReq.Yn].m_swMtrID of
               ST_CONF_BTI_CONN           : ReadBTIConReq(pMsg);

               ST_CONF_UPD_DATETIME,
               ST_CONF_UPD_PHADDR,
               ST_CONF_UPD_PORTCONF,
               ST_CONF_UPD_KI,
               ST_CONF_UPD_KU,
               ST_CONF_UPD_PASSW,
               ST_CONF_UPD_ADVPASSW,
               ST_CONF_UPD_TARIFF,
               ST_CONF_UPD_CALENDAR,
               ST_CONF_UPD_NEW_SUMSEASON,
               ST_CONF_UPD_NEW_WINSEASON,
               ST_CONF_CHECK_PASSW        : SS301_ReadUpdateDataReq(pMsg);

               ST_CONF_READ_KU            : SS301_ReadKUReq(pMsg);
               ST_CONF_READ_KI            : SS301_ReadKIReq(pMsg);
               ST_CONF_READ_PORTCONF      : SS301_ReadSpeedReq(pMsg);
               ST_CONF_READ_TARIFF        : SS301_ReadTarifReq(pMsg);
               ST_CONF_READ_CALENDAR      : SS301_ReadKalenReq(pMsg);
               ST_CONF_READ_SUMSEASON     : SS301_ReadSumSeasonReq(pMsg);
               ST_CONF_READ_WINSEASON     : SS301_ReadWinSeasonReq(pMsg);
               ST_CONF_READ_DATE_TIME     : SS301_ReadDateTimeReq(pMsg);
               //ST_CONF_GSM_CONN           : ReadGsmConAns(pMsg);
               //ST_CONF_GSM_DISC           : ReadGsmDicsAns(pMsg);
               ST_CONF_FINISH             : exit;
            end;
         utlconst.MET_C12 :
            case QuerryReq.Equee[QuerryReq.Yn].m_swMtrID of
               ST_CONF_BTI_CONN           : ReadBTIConReq(pMsg);

               ST_CONF_AUTHORIZATION      : C12_ReadAuthorization(pMsg);

               ST_CONF_UPD_DATETIME,
               ST_CONF_UPD_PHADDR,
               ST_CONF_UPD_PORTCONF,
               ST_CONF_UPD_KI,
               ST_CONF_UPD_KU,
               ST_CONF_UPD_PASSW,
               ST_CONF_UPD_ADVPASSW,
               ST_CONF_UPD_TARIFF,
               ST_CONF_UPD_CALENDAR,
               ST_CONF_UPD_NEW_SUMSEASON,
               ST_CONF_UPD_NEW_WINSEASON,
               ST_CONF_CHECK_PASSW        : C12_ReadUpdateDataReq(pMsg);

               ST_CONF_READ_KU            : C12_ReadKIKUReq(pMsg);
               ST_CONF_READ_KI            : C12_ReadKIKUReq(pMsg);
               ST_CONF_READ_PORTCONF      : C12_ReadSpeedReq(pMsg);
               ST_CONF_READ_TARIFF        : C12_ReadTarifReq(pMsg);
               ST_CONF_READ_CALENDAR      : C12_ReadKalenReq(pMsg);
               ST_CONF_READ_SUMSEASON     : C12_ReadSumSeasonReq(pMsg);
               ST_CONF_READ_WINSEASON     : C12_ReadWinSeasonReq(pMsg);
               ST_CONF_READ_DATE_TIME     : C12_ReadDateTimeReq(pMsg);
               //ST_CONF_GSM_CONN           : ReadGsmConAns(pMsg);
               //ST_CONF_GSM_DISC           : ReadGsmDicsAns(pMsg);
               ST_CONF_FINISH             : exit;
            end;
         end;
      end;

     QL_CONNCOMPL_REQ : if QuerryReq.Equee[QuerryReq.Yn].m_swMtrID <> ST_CONF_GSM_CONN then exit
                        else ReadGsmConAns(pMsg);
     PH_MDISCSCMPL_IND, PH_MNOCA_IND, PH_MNANS_IND :
                        if QuerryReq.Equee[QuerryReq.Yn].m_swMtrID = ST_CONF_GSM_CONN then
                        begin
                          GoToEndQuerry;
                          ReadGsmDicsAns(pMsg);
                        end;
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
   ConfMeterModule.lbProgressParam.Caption  := chConfState[QuerryReq.Equee[QuerryReq.Yn].m_swMtrID];
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

{*******************************************************************************
 *  Подсчет контрольной суммы
 *      @param var _Buff : array of BYTE
 *      @param _Count : WORD Полная длина сообщения (с контрольной суммой)
 *      @param _SetCRC16 : Boolean
 *      @return Boolean 
 ******************************************************************************}
function TConfMeterAuto.CRC16(var _Buff : array of BYTE; _Count : WORD; _SetCRC16 : Boolean) : Boolean;
var
    i       : integer;
    CRCHi,
    CRCLo,
    ind     : byte;
begin
    Result  := true;
    CRCHi   := $FF;
    CRCLo   := $FF;

    for i := 0 to _Count - 3 do
    begin
        ind:= CRCHi xor _Buff[i];
        CRCHi:= CRCLo xor srCRCHi[ind];
        CRCLo:= srCRCLo[ind];
    end;

    if (_Buff[_Count - 2] <> CRCLo) and (_Buff[_Count - 1] <> CRCHi) then
        Result := false;

    _Buff[_Count - 2] := CRCLo;
    _Buff[_Count - 1] := CRCHi;
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

procedure TConfMeterModule.OnDisconnect(Sender: TObject);
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




// параметризация CC301 через С12
procedure TConfMeterAuto.C12_CreateMSGHead(var pMsg : CMessage; Size : Byte);
begin
   pMsg.m_swLen       := Size;
   pMsg.m_swObjID     := m_sbyID;
   pMsg.m_sbyFrom     := DIR_L2TOL1;
   pMsg.m_sbyFor      := DIR_L2TOL1;
   pMsg.m_sbyType     := PH_DATARD_REQ;
   pMsg.m_sbyIntID    := GetRealPort(FindPortID);
   pMsg.m_sbyServerID := MET_C12;
   pMsg.m_sbyDirID    := GetRealPort(FindPortID);
end;

{*******************************************************************************
 *  Формирование запроса
 *      @param var _Buffer : array of byte
 *      @param _Length : word Полная длина запроса
 *      @param _FNC : word Функция
 ******************************************************************************}
procedure TConfMeterAuto.C12_FillMessageInfo(var _Buffer : array of byte; _Length : word; _FNC : BYTE);
var
  l_OAddress : WORD;
begin
  _Buffer[0]          := 0;
  _Buffer[1]          := _FNC;

  if (_FNC = 2) then
  begin
    _Buffer[0]  := l_OAddress div 1000; // адрес объекта С12
    _Buffer[1]  := 2;                   // идентификатор заголовка
    _Buffer[2]  := LO(_Length);            // полная длина пакета
    _Buffer[3]  := HI(_Length);            // -/-
    _Buffer[4]  := 1;                   // идентификатор пакета
    _Buffer[5]  := 0;                   // флаги пакета 0 - запрос, 1 - ответ
    _Buffer[6]  := 1;                   //
    _Buffer[7]  := 0;                   //
  end;

   CRC16(_Buffer, _Length, true);
end;


procedure TConfMeterAuto.C12_CreateReq(fnc, pID, sp0, sp1, sp2 : byte);
begin
  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
  m_nTxMsg.m_sbyInfo[8 + 1] := fnc;
  m_nTxMsg.m_sbyInfo[8 + 2] := pID;
  m_nTxMsg.m_sbyInfo[8 + 3] := sp0;
  m_nTxMsg.m_sbyInfo[8 + 4] := sp1;
  m_nTxMsg.m_sbyInfo[8 + 5] := sp2;

  C12_FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 2);
  C12_CreateMSGHead(m_nTxMsg, 16);
end;


procedure TConfMeterAuto.C12_CreateReadReq();
begin
   with QuerryReq do
     C12_CreateReq(3, Equee[Yn].m_swParamID, Equee[Yn].m_swSpecc0, Equee[Yn].m_swSpecc1, Equee[Yn].m_swSpecc2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.C12_CreateAuthorizationReq();
begin
   ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

   move(ConfMeterModule.m_Password[1], m_nTxMsg.m_sbyInfo[2], 8);

   c12_FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 85);
   C12_CreateMSGHead(m_nTxMsg, 16);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure TConfMeterAuto.C12_CreateVerifReq();
begin
   m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[8 + 1] := 31;
   m_nTxMsg.m_sbyInfo[8 + 2] := 0;
   m_nTxMsg.m_sbyInfo[8 + 3] := 0;
   if Length(ConfMeterModule.edPassword.Text) <> 8 then
   begin
     ConfMeterModule.CreateErrorMSG(ER_CONF_PASSW);
     exit;
   end;
   move(ConfMeterModule.edPassword.Text[1], m_nTxMsg.m_sbyInfo[8 + 4], 8);
   C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 22, 2);
   C12_CreateMSGHead(m_nTxMsg, 11 + 22);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;


procedure TConfMeterAuto.C12_CreateUpdDateTimeReq;
var
   l_Year, l_Month, l_Day     : word;
   l_Hour, l_Min, l_Sec, l_ms : word;
begin
   DecodeDate(Now(), l_Year, l_Month, l_Day);
   DecodeTime(Now(), l_Hour, l_Min, l_Sec, l_ms);
   m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[8 + 1] := 16;
   m_nTxMsg.m_sbyInfo[8 + 2] := 32;
   m_nTxMsg.m_sbyInfo[8 + 3] := 2;
   m_nTxMsg.m_sbyInfo[8 + 4] := l_Sec;
   m_nTxMsg.m_sbyInfo[8 + 5] := l_Min;
   m_nTxMsg.m_sbyInfo[8 + 6] := l_Hour;
   m_nTxMsg.m_sbyInfo[8 + 7] := l_Day;
   m_nTxMsg.m_sbyInfo[8 + 8] := l_Month;
   m_nTxMsg.m_sbyInfo[8 + 9] := l_Year - 2000;
   C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 20, 2);
   C12_CreateMSGHead(m_nTxMsg, 11 + 20);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;


procedure TConfMeterAuto.C12_CreateUpdPHAddrReq;
var phAddr  : integer;
begin
   phAddr                := ConfMeterModule.spNewPHAddress.Value;
   if (phAddr = 0) or (phAddr > 255) then
   begin
     ConfMeterModule.CreateErrorMSG(ER_CONF_FORMAT_PHADDR);
     exit;
   end;
   m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[8 + 1] := 16;
   m_nTxMsg.m_sbyInfo[8 + 2] := 21;
   m_nTxMsg.m_sbyInfo[8 + 3] := 0;
   m_nTxMsg.m_sbyInfo[8 + 4] := ConfMeterModule.sePHAddress.Value;
   C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 15, 2);
   C12_CreateMSGHead(m_nTxMsg, 11 + 15);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;


procedure TConfMeterAuto.C12_CreateUpdPortConfReq();
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
   m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[8 + 1] := 16;
   m_nTxMsg.m_sbyInfo[8 + 2] := 23;
   m_nTxMsg.m_sbyInfo[8 + 3] := 0;
   move(Speed, m_nTxMsg.m_sbyInfo[8 + 4], 2);
   m_nTxMsg.m_sbyInfo[8 + 6] := 1;
   m_nTxMsg.m_sbyInfo[8 + 7] := 8;
   m_nTxMsg.m_sbyInfo[8 + 8] := Par;
   m_nTxMsg.m_sbyInfo[8 + 9] := Bit;
   C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 20, 2);
   C12_CreateMSGHead(m_nTxMsg, 11 + 20);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;


procedure TConfMeterAuto.C12_CreateUpdKIReq();
var
   KoefI, KoefU   : integer;
begin
   if (ConfMeterModule.edKI.Text = '') or (ConfMeterModule.edKU.Text = '') then
   begin
     ErrorRecive;
     exit;
   end;
   KoefI  := StrToInt(ConfMeterModule.edKI.Text);
   KoefU  := StrToInt(ConfMeterModule.edKU.Text);
   m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[8 + 1] := 16;
   m_nTxMsg.m_sbyInfo[8 + 2] := 34;
   m_nTxMsg.m_sbyInfo[8 + 3] := 0;

   move(KoefI, m_nTxMsg.m_sbyInfo[8 + 4], 4);
   move(KoefU, m_nTxMsg.m_sbyInfo[8 + 8], 4);

   C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 18, 2);
   C12_CreateMSGHead(m_nTxMsg, 11 + 18);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;


procedure TConfMeterAuto.C12_CreateUpdKUReq();
var Koef   : integer;
begin
   Koef  := StrToInt(ConfMeterModule.edKU.Text);
   m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[8 + 1] := 16;
   m_nTxMsg.m_sbyInfo[8 + 2] := 34;
   m_nTxMsg.m_sbyInfo[8 + 3] := 0;
   move(Koef, m_nTxMsg.m_sbyInfo[8 + 4], 4);
   C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 18, 2);
   C12_CreateMSGHead(m_nTxMsg, 11 + 18);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;


procedure TConfMeterAuto.C12_CreateUpdPasswReq();
begin
   m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[8 + 1] := 16;
   m_nTxMsg.m_sbyInfo[8 + 2] := 37;
   m_nTxMsg.m_sbyInfo[8 + 3] := 0;
   if Length(ConfMeterModule.edNewPassword.Text) <> 8 then
   begin
     ConfMeterModule.CreateErrorMSG(ER_CONF_FORMAT_PASSW);
     exit;
   end;
   move(ConfMeterModule.edNewPassword.Text[1], m_nTxMsg.m_sbyInfo[8 + 4], 8);
   C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 22, 2);
   C12_CreateMSGHead(m_nTxMsg, 11 + 22);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;


procedure TConfMeterAuto.C12_CreateUpdAdvPasswReq();
begin
   m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[8 + 1] := 16;
   m_nTxMsg.m_sbyInfo[8 + 2] := 37;
   m_nTxMsg.m_sbyInfo[8 + 3] := 1;
   if Length(ConfMeterModule.edAdvPassword.Text) <> 8 then
   begin
     ConfMeterModule.CreateErrorMSG(ER_CONF_FORMAT_ADVPASSW);
     exit;
   end;
   move(ConfMeterModule.edAdvPassword.Text[1], m_nTxMsg.m_sbyInfo[8 + 4], 8);
   C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 22, 2);
   C12_CreateMSGHead(m_nTxMsg, 11 + 22);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;


procedure TConfMeterAuto.C12_CreateUpdTarReq();
begin
   m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[8 + 1] := 16;
   m_nTxMsg.m_sbyInfo[8 + 2] := 30 + ConfMeterModule.cbWorkPrDay.ItemIndex;
   m_nTxMsg.m_sbyInfo[8 + 3] := QuerryReq.Equee[QuerryReq.Yn].m_swSpecc0;
//
   move(ConfMeterModule.clTarifGrid, m_nTxMsg.m_sbyInfo[8 + 4], 48);
   C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 62, 2);
   C12_CreateMSGHead(m_nTxMsg, 11 + 62);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;


procedure TConfMeterAuto.C12_CreateUpdCalReq;
var
   Year, Month, Day, Row : word;
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
   m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[8 + 1] := 16;
   m_nTxMsg.m_sbyInfo[8 + 2] := 29;
   m_nTxMsg.m_sbyInfo[8 + 3] := QuerryReq.Equee[QuerryReq.Yn].m_swSpecc2;
   move(BitMask, m_nTxMsg.m_sbyInfo[8 + 4], 4);
   //for i := 0 to 3 do
   //  m_nTxMsg.m_sbyInfo[i] := BitMask[3 - i];
   m_nTxMsg.m_sbyInfo[8 + 8] := Year + QuerryReq.Equee[QuerryReq.Yn].m_swSpecc0;
   C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 19, 2);
   C12_CreateMSGHead(m_nTxMsg, 11 + 19);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;


procedure TConfMeterAuto.C12_CreateUpdSumWinDateReq;
var Year, Month, Day   : word;
    Hour, Min, Sec, ms : word;
begin
   if ConfMeterModule.rbNoActionKal.Checked then
     exit;
   m_nTxMsg.m_sbyInfo[8 + 0] := ConfMeterModule.sePHAddress.Value;
   m_nTxMsg.m_sbyInfo[8 + 2] := QuerryReq.Equee[QuerryReq.Yn].m_swParamID;
   m_nTxMsg.m_sbyInfo[8 + 3] := 0;
   if ConfMeterModule.rbResetActKal.Checked then
   begin
     m_nTxMsg.m_sbyInfo[8 + 1] := 30;
     C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 14, 2);
     C12_CreateMSGHead(m_nTxMsg, 11 + 14);
   end
   else
   begin
     m_nTxMsg.m_sbyInfo[8 + 1] := 16;
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
     m_nTxMsg.m_sbyInfo[8 + 4] := Sec;
     m_nTxMsg.m_sbyInfo[8 + 5] := Min;
     m_nTxMsg.m_sbyInfo[8 + 6] := Hour;
     m_nTxMsg.m_sbyInfo[8 + 7] := Day;
     m_nTxMsg.m_sbyInfo[8 + 8] := Month;
     m_nTxMsg.m_sbyInfo[8 + 9] := Year - 2000;
     C12_FillMessageInfo(m_nTxMsg.m_sbyInfo, 20, 2);
     C12_CreateMSGHead(m_nTxMsg, 11 + 20);
   end;
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;


procedure TConfMeterAuto.C12_ReadSpeedReq(var pMsg : CMessage);
var param : WORD;
begin
   if pMsg.m_sbyInfo[8 + 3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   move(pMsg.m_sbyInfo[8 + 4], param, 2);
   ConfMeterModule.cbSpeed.ItemIndex   := ConfMeterModule.cbSpeed.Items.IndexOf(IntToStr(param));
   ConfMeterModule.cbParitet.ItemIndex := pMsg.m_sbyInfo[8 + 8];
   ConfMeterModule.cbStopBit.ItemIndex := pMsg.m_sbyInfo[8 + 9] - 1;
end;


procedure TConfMeterAuto.C12_ReadKIKUReq(var pMsg : CMessage);
var param : DWORD;
begin
   if pMsg.m_sbyInfo[8 + 3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   move(pMsg.m_sbyInfo[8 + 4], param, 4);
   ConfMeterModule.edKI.Text := IntToStr(param);
   move(pMsg.m_sbyInfo[8 + 8], param, 4);
   ConfMeterModule.edKU.Text := IntToStr(param);
end;


procedure TConfMeterAuto.C12_ReadTarifReq(var pMsg : CMessage);
begin
   if pMsg.m_sbyInfo[8 + 3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   move(pMsg.m_sbyInfo[8 + 4], ConfMeterModule.clTarifGrid, 48);
   ConfMeterModule.sgTariffs.Refresh();
end;


procedure TConfMeterAuto.C12_ReadKalenReq(var pMsg : CMessage);
var Year, Month, Day, Row  : word;
    i, j                   : byte;
begin
   if pMsg.m_sbyInfo[8 + 3] <> 0 then
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
       if (pMsg.m_sbyInfo[8 + i + 4] and __SetMask[j]) <> 0 then
         ConfMeterModule.clKalenGrid[Row][i*8 + j + 1] := 1
       else
         ConfMeterModule.clKalenGrid[Row][i*8 + j + 1] := 0;
     end;
   ConfMeterModule.sgKalendar.Refresh();
end;


procedure TConfMeterAuto.C12_ReadSumSeasonReq(var pMsg : CMessage);
var Year, Month, Day  : word;
    Hour, Min, Sec    : word;
begin
   if pMsg.m_sbyInfo[8 + 3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   Sec   := pMsg.m_sbyInfo[8 + 4];
   Min   := pMsg.m_sbyInfo[8 + 5];
   Hour  := pMsg.m_sbyInfo[8 + 6];
   Day   := pMsg.m_sbyInfo[8 + 7];
   Month := pMsg.m_sbyInfo[8 + 8];
   Year  := pMsg.m_sbyInfo[8 + 9] + 2000;
   ConfMeterModule.dtSummerSeason.DateTime := EncodeDate(Year, Month, Day) +
                                        EncodeTime(Hour, Min, Sec, 0);
end;

procedure TConfMeterAuto.C12_ReadWinSeasonReq(var pMsg : CMessage);
var Year, Month, Day  : word;
    Hour, Min, Sec    : word;
begin
   if pMsg.m_sbyInfo[8 + 3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
   Sec   := pMsg.m_sbyInfo[8 + 4];
   Min   := pMsg.m_sbyInfo[8 + 5];
   Hour  := pMsg.m_sbyInfo[8 + 6];
   Day   := pMsg.m_sbyInfo[8 + 7];
   Month := pMsg.m_sbyInfo[8 + 8];
   Year  := pMsg.m_sbyInfo[8 + 9] + 2000;
   ConfMeterModule.dtWinterSeason.DateTime := EncodeDate(Year, Month, Day) +
                                        EncodeTime(Hour, Min, Sec, 0);
end;


procedure TConfMeterAuto.C12_ReadDateTimeReq(var pMsg : CMessage);
var dt_Meter : TDateTime;
    dt_Delta : TDateTime;
begin
   dt_Meter := 0;
   dt_Meter := EncodeDate(pMsg.m_sbyInfo[8 + 9] + 2000, pMsg.m_sbyInfo[8 + 8], pMsg.m_sbyInfo[8 + 7]) +
               EncodeTime(pMsg.m_sbyInfo[8 + 6], pMsg.m_sbyInfo[8 + 5], pMsg.m_sbyInfo[8 + 4], 0);
   dt_Delta := abs(Now - dt_Meter);
   ConfMeterModule.lbTimeMetAndUSPD.Caption := 'Время счетчика: ' + DateTimeToStr(dt_Meter) + '; Разница: ' +
                                               TimeToStr(dt_Delta);
end;


procedure TConfMeterAuto.C12_ReadUpdateDataReq(var pMsg : CMessage);
begin
  if pMsg.m_sbyInfo[8 + 3] = 4 then
  begin
    ConfMeterModule.CreateErrorMSG(ER_CONF_PASSW);
    exit;
  end;
  if pMsg.m_sbyInfo[8 + 3] <> 0 then
   begin
     ErrorRecive;
     exit;
   end;
end;

end.
