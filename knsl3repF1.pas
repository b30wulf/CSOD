unit knsl3repF1;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, Dialogs,
  DBTables, Db, ADODB, QuickRpt, Qrctrls, ExtCtrls,
  StdCtrls, Forms, Dates, utlconst,
  utldatabase,
  utltypes;

type
  TfrmRepF1 = class(TQuickRep)
    QRB_RepTitle: TQRBand;
    QRShape3: TQRShape;
    QRlbl_RepTitle: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel8: TQRLabel;
    QRShp_TitleLn1: TQRShape;
    QRShape1: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRSh_Ln3: TQRShape;
    QRShape2: TQRShape;
    QRShape4: TQRShape;
    QRB_PHeader: TQRBand;
    lbl_ProdUser: TQRLabel;
    lbl_Enterprise: TQRLabel;
    QRLabel1: TQRLabel;
    QRB_ColHeader: TQRBand;
    QRLDateforRep: TQRLabel;
    QRLDateAfter: TQRLabel;
    QRShape5: TQRShape;
    QRLabel14: TQRLabel;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRLabel15: TQRLabel;
    QRShape9: TQRShape;
    QRLabel16: TQRLabel;
    QRShape10: TQRShape;
    QRLRepDate: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRShape11: TQRShape;
    QRDBText2: TQRDBText;
    QRBand1: TQRBand;
    QRShape12: TQRShape;
    QRDBText5: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText3: TQRDBText;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRDBText1: TQRDBText;
    QRExSubstract: TQRExpr;
    QRExpr3: TQRExpr;
    QRExKoeff: TQRExpr;
    blSum: TQRBand;
    shlSum: TQRShape;
    shlT4: TQRShape;
    shlT3: TQRShape;
    shlT2: TQRShape;
    shlT1: TQRShape;
    shlWp0: TQRShape;
    shlWm0: TQRShape;
    shlQp0: TQRShape;
    shlQm0: TQRShape;
    shlWp4: TQRShape;
    shlWm4: TQRShape;
    shlQp4: TQRShape;
    shlQm4: TQRShape;
    shlWp3: TQRShape;
    shlWm3: TQRShape;
    shlQp3: TQRShape;
    shlQm3: TQRShape;
    shlWp2: TQRShape;
    shlWm2: TQRShape;
    shlQp2: TQRShape;
    shlQm2: TQRShape;
    shlWp1: TQRShape;
    shlWm1: TQRShape;
    shlQp1: TQRShape;
    shlQm1: TQRShape;
    shlWp: TQRShape;
    shlWm: TQRShape;
    shlQp: TQRShape;
    shlQm: TQRShape;
    llQp: TQRLabel;
    llWm: TQRLabel;
    llWp: TQRLabel;
    llQm: TQRLabel;
    llT1: TQRLabel;
    llT2: TQRLabel;
    llT3: TQRLabel;
    llT4: TQRLabel;
    llSum: TQRLabel;
    shlItogo: TQRShape;
    llItogo: TQRLabel;
    ll11: TQRLabel;
    ll21: TQRLabel;
    ll31: TQRLabel;
    ll41: TQRLabel;
    ll12: TQRLabel;
    ll22: TQRLabel;
    ll32: TQRLabel;
    ll42: TQRLabel;
    ll13: TQRLabel;
    ll23: TQRLabel;
    ll33: TQRLabel;
    ll43: TQRLabel;
    ll10: TQRLabel;
    ll20: TQRLabel;
    ll30: TQRLabel;
    ll40: TQRLabel;
    ll14: TQRLabel;
    ll24: TQRLabel;
    ll34: TQRLabel;
    ll44: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;

    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepAfterPrint(Sender: TObject);
    procedure blSumBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepAfterPreview(Sender: TObject);

  private
    procedure SetColHeader;
    procedure SetSummary;
    procedure Init;
  published
    function  Chek(var RepMonth,RepYear,CurMonth,CurYear: Integer ) : Integer;
    procedure ShowReportModal(var Rep : RepCONFIG);
  end;

var
   frmRepF1: TfrmRepF1;
   strConfSQL,
   strArchSQL1,
   strArchSQL2,
   strCurSQL1,
   strSQLcur   : String;
   RepF1cnfg   : RepCONFIG;
implementation


{$R *.DFM}

procedure TfrmRepF1.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
//
end;

procedure TfrmRepF1.QuickRepAfterPrint(Sender: TObject);
begin
  //qryDetail.Active := False;

end;
procedure TfrmRepF1.Init;
begin
   ll10.Caption := '0.00';
   ll11.Caption := '0.00';
   ll12.Caption := '0.00';
   ll13.Caption := '0.00';
   ll14.Caption := '0.00';
   ll20.Caption := '0.00';
   ll21.Caption := '0.00';
   ll22.Caption := '0.00';
   ll23.Caption := '0.00';
   ll24.Caption := '0.00';
   ll30.Caption := '0.00';
   ll31.Caption := '0.00';
   ll32.Caption := '0.00';
   ll33.Caption := '0.00';
   ll34.Caption := '0.00';
   ll40.Caption := '0.00';
   ll41.Caption := '0.00';
   ll42.Caption := '0.00';
   ll43.Caption := '0.00';
   ll44.Caption := '0.00';

end;
procedure TfrmRepF1.ShowReportModal(var Rep : RepCONFIG);
begin
    RepF1cnfg := Rep;
    Init;
    SetColHeader;
    SetSummary;
    //qryDetail.Active := True;
    PreviewModal;
end;
procedure TfrmRepF1.SetColHeader;
Begin
    QRLRepDate.Caption := LongMonthNames[RepF1cnfg.Month] +'  '+ IntToStr(RepF1cnfg.Year) + ' года';
    case RepF1cnfg.Month of
      1: BEGIN
        QRLDateforRep.Caption := '01.01.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.02.' + IntToStr(RepF1cnfg.Year2);
      END;
      2: BEGIN
        QRLDateforRep.Caption := '01.02.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.03.' + IntToStr(RepF1cnfg.Year2);
      END;
      3: BEGIN
        QRLDateforRep.Caption := '01.03.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.04.' + IntToStr(RepF1cnfg.Year2);
      END;
      4: BEGIN
        QRLDateforRep.Caption := '01.04.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.05.' + IntToStr(RepF1cnfg.Year2);
      END;
      5: BEGIN
        QRLDateforRep.Caption := '01.05.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.06.' + IntToStr(RepF1cnfg.Year2);
      END;
      6: BEGIN
        QRLDateforRep.Caption := '01.06.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.07.' + IntToStr(RepF1cnfg.Year2);
      END;
      7: BEGIN
        QRLDateforRep.Caption := '01.07.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.08.' + IntToStr(RepF1cnfg.Year2);
      END;
      8: BEGIN
        QRLDateforRep.Caption := '01.08.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.09.' + IntToStr(RepF1cnfg.Year2);
      END;
      9: BEGIN
        QRLDateforRep.Caption := '01.09.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.10.' + IntToStr(RepF1cnfg.Year2);
      END;
      10: BEGIN
        QRLDateforRep.Caption := '01.10.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.11.' + IntToStr(RepF1cnfg.Year2);
      END;
      11: BEGIN
        QRLDateforRep.Caption := '01.11.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.12.' + IntToStr(RepF1cnfg.Year2);
      END;
      12: BEGIN
        QRLDateforRep.Caption := '01.12.' + IntToStr(RepF1cnfg.Year);
        QRLDateAfter.Caption  := '01.01.' + IntToStr(RepF1cnfg.Year2);
      END;
    end;
End;

function  TfrmRepF1.Chek(var RepMonth,RepYear,CurMonth,CurYear: Integer ) : Integer;
begin

end;

procedure TfrmRepF1.blSumBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //qrySummary.ExecSQL;
end;
procedure TfrmRepF1.SetSummary;
Var Tbl : SUMMARY_F1;
i : Integer;
tmp : String;
begin
  m_pDb.GetSummaryF1(Tbl);
  for i := 0  to Tbl.m_sbyCount do begin
    tmp := FloatToStrF(Tbl.Item[i].m_sfValue,ffFixed,10,2);
    case Tbl.Item[i].m_sEnergyType of
       QRY_NAK_EN_MONTH_EP :
           case Tbl.Item[i].m_sTarType of
              0 : ll10.Caption := tmp;
              1 : ll11.Caption := tmp;
              2 : ll12.Caption := tmp;
              3 : ll13.Caption := tmp;
              4 : ll14.Caption := tmp;
           end;
        QRY_NAK_EN_MONTH_EM :
           case Tbl.Item[i].m_sTarType of
              0 : ll20.Caption := tmp;
              1 : ll21.Caption := tmp;
              2 : ll22.Caption := tmp;
              3 : ll23.Caption := tmp;
              4 : ll24.Caption := tmp;
           end;
        QRY_NAK_EN_MONTH_RP :
           case Tbl.Item[i].m_sTarType of
              0 : ll30.Caption := tmp;
              1 : ll31.Caption := tmp;
              2 : ll32.Caption := tmp;
              3 : ll33.Caption := tmp;
              4 : ll34.Caption := tmp;
           end;
       QRY_NAK_EN_MONTH_RM :
           case Tbl.Item[i].m_sTarType of
              0 : ll40.Caption := tmp;
              1 : ll41.Caption := tmp;
              2 : ll42.Caption := tmp;
              3 : ll43.Caption := tmp;
              4 : ll44.Caption := tmp;
           end;
    end;
  end;
end;


procedure TfrmRepF1.QuickRepAfterPreview(Sender: TObject);
begin
  //qryDetail.Active := False;
end;

end.
