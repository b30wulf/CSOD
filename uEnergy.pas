unit uEnergy;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QuickRpt, Qrctrls, ExtCtrls, Db, ADODB, Grids, DBGrids;

type
  TfrmEnergy = class(TForm)
    QuickRep1: TQuickRep;
    QRBand2: TQRBand;
    QRShapeMs: TQRShape;
    sT1Es: TQRShape;
    sT2Es: TQRShape;
    sT3Es: TQRShape;
    sT4Es: TQRShape;
    QRGroup1: TQRGroup;
    QRDBTextName: TQRDBText;
    QRBand3: TQRBand;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRShapeM: TQRShape;
    sT4detailSumVal: TQRShape;
    sT1detailVal: TQRShape;
    sT1detailSumVal: TQRShape;
    sT3detailSumVal: TQRShape;
    sT4detailVal: TQRShape;
    sT2detailVal: TQRShape;
    sT2detailSumVal: TQRShape;
    sT3detailVal: TQRShape;
    QRDBText2: TQRDBText;
    QRDBTextSumm: TQRDBText;
    QRDBTextSummS: TQRDBText;
    lT1DetailVal: TQRDBText;
    lT1DetailSumVal: TQRDBText;
    lT3DetailSumVal: TQRDBText;
    lT4DetailVal: TQRDBText;
    lT2DetailVal: TQRDBText;
    lT2DetailSumVal: TQRDBText;
    lT3DetailVal: TQRDBText;
    lT4DetailSumVal: TQRDBText;
    QRBand7: TQRBand;
    ChildBand2: TQRChildBand;
    QRShape1: TQRShape;
    lDate: TQRLabel;
    QRShape6: TQRShape;
    QRShape4: TQRShape;
    QRShape2: TQRShape;
    QRShape5: TQRShape;
    sT1: TQRShape;
    sT2: TQRShape;
    sT3: TQRShape;
    sT1SumVal: TQRShape;
    sT2Val: TQRShape;
    sT2SumVal: TQRShape;
    sT1Val: TQRShape;
    sT3Val: TQRShape;
    sT3SumVal: TQRShape;
    sT4: TQRShape;
    lData: TQRLabel;
    lAll: TQRLabel;
    lT1: TQRLabel;
    lT2: TQRLabel;
    lT3: TQRLabel;
    lT4: TQRLabel;
    lOnDay: TQRLabel;
    lT1Val: TQRLabel;
    lT1SumVal: TQRLabel;
    lT4Val: TQRLabel;
    lT2Val: TQRLabel;
    lT3Val: TQRLabel;
    sT4Val: TQRShape;
    sT4SumVal: TQRShape;
    lT4SumVal: TQRLabel;
    lT3SumVal: TQRLabel;
    lT2SumVal: TQRLabel;
    lAllSumVal: TQRLabel;
    lProdUser: TQRLabel;
    QRLabelTitul: TQRLabel;
    QRBand5: TQRBand;
    QRSysData3: TQRSysData;
    QRSysData4: TQRSysData;
    lBuilded: TQRLabel;
    lOneFio: TQRLabel;
    lTwoFio: TQRLabel;
    lPage: TQRLabel;
    lT2Es: TQRExpr;
    lT4Es: TQRExpr;
    lT3Es: TQRExpr;
    lT1Es: TQRExpr;
    QRExprSum: TQRExpr;
    QuickRep2: TQuickRep;
    QRBand4: TQRBand;
    QRShape27: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRShape37: TQRShape;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText15: TQRDBText;
    QRBand6: TQRBand;
    lProdUsers: TQRLabel;
    QRLabelTitulSum: TQRLabel;
    QRBand8: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    llBuilded: TQRLabel;
    lOneFios: TQRLabel;
    lTwoFios: TQRLabel;
    llPage: TQRLabel;
    QRDBText1: TQRDBText;
    QRBand1: TQRBand;
    QRShape43: TQRShape;
    llObject: TQRLabel;
    QRShape45: TQRShape;
    QRLabel24: TQRLabel;
    QRShape48: TQRShape;
    QRLabel25: TQRLabel;
    QRShape49: TQRShape;
    QRLabel26: TQRLabel;
    QRShape50: TQRShape;
    QRLabel27: TQRLabel;
    QRShape57: TQRShape;
    QRLabel28: TQRLabel;
    QRShape39: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel3: TQRLabel;
    lDetails: TQRLabel;
    QRDBText3: TQRDBText;
    bSum: TQRBand;
    lOne: TQRLabel;
    lTwo: TQRLabel;
    blSum: TQRBand;
    llOne: TQRLabel;
    llTwo: TQRLabel;
    QRDBText4: TQRDBText;
    lTime1: TQRLabel;
    lTime2: TQRLabel;
    lTime3: TQRLabel;
    lTime4: TQRLabel;
    lDetail: TQRLabel;
    procedure sqlEnergyCalcFields(DataSet: TDataSet);
    procedure sqlEnergyMonthCalcFields(DataSet: TDataSet);
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    CurType: Integer;
    procedure UnVisibleElements(ATarif: Integer);
    procedure SetVisibleElements(ATarif: Integer);
  public
    { Public declarations }
  end;

var
  frmEnergy: TfrmEnergy;

implementation

{$R *.DFM}

procedure TfrmEnergy.SetVisibleElements(ATarif: Integer);
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount - 1 do begin
    if ( Pos('T'+IntToStr(ATarif),Components[i].Name) <> 0 ) then begin
      if ( Components[i] is TQRLabel ) then begin
        ( Components[i] as TQRLabel ).Font.Color := clBlack;
      end;
      if ( Components[i] is TQRShape ) then begin
        ( Components[i] as TQRShape ).Pen.Color := clBlack;
      end;
      if ( Components[i] is TQRDBText ) then begin
        ( Components[i] as TQRDBText ).Font.Color := clBlack;
      end;
      if ( Components[i] is TQRExpr ) then begin
        ( Components[i] as TQRExpr ).Font.Color := clBlack;
      end;
    end;
  end
end;

procedure TfrmEnergy.sqlEnergyCalcFields(DataSet: TDataSet);
const
   ALL_FLEW:string='Общее потребление, кВт ч';
var
  i : byte;
begin
  {sqlEnergy.FieldByName('NewGroup').Value := sqlEnergy.FieldByName('EG_num').AsInteger*100 + sqlEnergy.FieldByName('P_TYPE').AsInteger;//*100+sqlEnergy.FieldByName('C_NUM').AsInteger;
  with sqlEnergy do begin
    CurType := FieldByName('P_TYPE').AsInteger;
    FieldByName('NameGroup').Value:='Группа: '+FieldByName('EG_name').AsString + ' (' + FieldByName('T_NAME').AsString + ')';//+'.';
    FieldByName('OptionNumber').Value:=' Договор № '+FieldByName('EG_dog').AsString;//+'.';
    Case FieldByName('t_stattype').AsInteger of
      1: begin
        FieldByName('NameGroup').Value:=FieldByName('NameGroup').Value;//+' (энергия активная потребления)';
      end;
      2: begin
        FieldByName('NameGroup').Value:=FieldByName('NameGroup').Value;//+' (энергия реактивная потребления)';
      end;
      3: begin
        FieldByName('NameGroup').Value:=FieldByName('NameGroup').Value;//+' (энергия реактивная генерация)';
      end;
      4: begin
        FieldByName('NameGroup').Value:=FieldByName('NameGroup').Value;//+' (энергия активная генерация)';
      end;
      else
    end; {case}

   { if ( lT1.Caption = '' ) then begin
      UnVisibleElements(1);
    end
    else begin
      SetVisibleElements(1);
    end;
    if ( lT2.Caption = '' ) then begin
      UnVisibleElements(2);
    end
    else begin
      SetVisibleElements(2);
    end;
    if ( lT3.Caption = '' ) then begin
      UnVisibleElements(3);
    end
    else begin
      SetVisibleElements(3);
    end;
    if ( lT4.Caption = '' ) then begin
      UnVisibleElements(4);
    end
    else begin
      SetVisibleElements(4);
    end;
    FieldByName('procCurHH').Value:=inttostr(trunc((FieldByName('Column49').AsInteger+1)/48*100))+'%';

    FieldByName('T1_day').Value:=0;
    FieldByName('T1_days').Value:=0;

    FieldByName('T2_night').Value:=0;
    FieldByName('T2_nights').Value:=0;

    FieldByName('T3_pik').Value:=0;
    FieldByName('T3_piks').Value:=0;

    FieldByName('T4_rezerv').Value:=0;
    FieldByName('T4_rezervs').Value:=0;

    FieldByName('Sum_T').Value:=0;
    FieldByName('Sum_Ts').Value:=0;


    tTarifs.Active:=false;

    tTarifs.SQL.Clear;
    tTarifs.SQL.Add('Select T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,');
    tTarifs.SQL.Add('T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23,T24,T25,');
    tTarifs.SQL.Add('T26,T27,T28,T29,T30,T31,T32,T33,T34,T35,T36,T37,T38,');
    tTarifs.SQL.Add('T39,T40,T41,T42,T43,T44,T45,T46,T47,T_Num,Day_type,Date_From,Date_To');
    tTarifs.SQL.Add('From Tarifs');
    tTarifs.SQL.Add('Where ((Day_type='+FieldByName('t_stattype').AsString+') or (Day_type=0))');
    tTarifs.SQL.Add(' and (:nd between Date_From and Date_To)');
    tTarifs.Parameters[0].DataType:=ftDateTime;
    tTarifs.Parameters[0].Value:=FieldByName('udate').Value;

    try
      tTarifs.Active:=true;
      if tTarifs.RecordCount=0
        then begin
          ShowMessage('Не введены тарифные зоны для выбранного периода...');
          Close;
        end
        else begin
          if not tTarifs.Locate('Day_type',FieldByName('t_stattype').AsString,[])
            then tTarifs.First;
        end;
    except
      Close;
    end;

    For i:=0 to 47 do begin
      Case tTarifs.Fields[i].AsInteger of
        1: begin
          FieldByName('T2_night').Value:=FieldByName('T2_night').Value+Fields[i].Value/2;
        end;
        2: begin
          FieldByName('T1_day').Value:=FieldByName('T1_day').Value+Fields[i].Value/2;
        end;
        3: begin
          FieldByName('T3_pik').Value:=FieldByName('T3_pik').Value+Fields[i].Value/2;
        end;
        4: begin
          FieldByName('T4_rezerv').Value:=FieldByName('T4_rezerv').Value+Fields[i].Value/2;
        end;
        else
      end;
    end;

    FieldByName('Sum_T').Value:=FieldByName('T1_day').Value+FieldByName('T2_night').Value+FieldByName('T3_pik').Value+FieldByName('T4_rezerv').Value;

    FieldByName('Sum_Ts').Value:=QRExprSum.Value.dblResult+FieldByName('Sum_T').Value;
    FieldByName('T1_days').Value:=lT1Es.Value.dblResult+FieldByName('T1_day').Value;
    FieldByName('T2_nights').Value:=lT2Es.Value.dblResult+FieldByName('T2_night').Value;
    FieldByName('T3_piks').Value:=lT3Es.Value.dblResult+FieldByName('T3_pik').Value;
    FieldByName('T4_rezervs').Value:=lT4Es.Value.dblResult+FieldByName('T4_rezerv').Value;

  end;}
end;

procedure TfrmEnergy.sqlEnergyMonthCalcFields(DataSet: TDataSet);
var
  st : string;
  stat : boolean;
begin
{  sqlEnergy.Active:=false;
  st:=sqlEnergy.Filter;
  stat:=sqlEnergy.Filtered;
  sqlEnergy.Filter:='eg_num='+sqlEnergyMonth.FieldByName('eg_num').AsString;
  sqlEnergy.Filtered:=true;
  sqlEnergy.Active:=true;

  sqlEnergyMonth.FieldByName('Sum_Ts').Value:=0;
  sqlEnergyMonth.FieldByName('Sum_T1').Value:=0;
  sqlEnergyMonth.FieldByName('Sum_T2').Value:=0;
  sqlEnergyMonth.FieldByName('Sum_T3').Value:=0;
  sqlEnergyMonth.FieldByName('Sum_T4').Value:=0;

  sqlEnergy.First;
  While not sqlEnergy.Eof do begin
    sqlEnergyMonth.FieldByName('Sum_T1').Value:=sqlEnergyMonth.FieldByName('Sum_T1').Value+sqlEnergyT1_day.Value;
    sqlEnergyMonth.FieldByName('Sum_T2').Value:=sqlEnergyMonth.FieldByName('Sum_T2').Value+sqlEnergyT2_night.Value;
    sqlEnergyMonth.FieldByName('Sum_T3').Value:=sqlEnergyMonth.FieldByName('Sum_T3').Value+sqlEnergyT3_pik.Value;
    sqlEnergyMonth.FieldByName('Sum_T4').Value:=sqlEnergyMonth.FieldByName('Sum_T4').Value+sqlEnergyT4_rezerv.Value;
    sqlEnergy.Next;
  end;
  sqlEnergyMonth.FieldByName('Sum_Ts').Value:=sqlEnergyMonth.FieldByName('Sum_T1').Value+sqlEnergyMonth.FieldByName('Sum_T2').Value+sqlEnergyMonth.FieldByName('Sum_T3').Value+sqlEnergyMonth.FieldByName('Sum_T4').Value;
  sqlEnergy.Active:=false;
  sqlEnergy.Filter:=st;
  sqlEnergy.Filtered:=stat;
  sqlEnergy.Active:=true;}
end;

procedure TfrmEnergy.UnVisibleElements(ATarif: Integer);
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount - 1 do begin
    if ( Pos('T'+IntToStr(ATarif),Components[i].Name) <> 0 ) then begin
      if ( Components[i] is TQRLabel ) then begin
        ( Components[i] as TQRLabel ).Font.Color := clWhite;
      end;
      if ( Components[i] is TQRShape ) then begin
        ( Components[i] as TQRShape ).Pen.Color := clWhite;
      end;
      if ( Components[i] is TQRDBText ) then begin
        ( Components[i] as TQRDBText ).Font.Color := clWhite;
      end;
      if ( Components[i] is TQRExpr ) then begin
        ( Components[i] as TQRExpr ).Font.Color := clWhite;
      end;
    end;
  end;
end;

procedure TfrmEnergy.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  if ( lT1.Caption = '' ) then begin
      UnVisibleElements(1);
    end
    else begin
      SetVisibleElements(1);
    end;
    if ( lT2.Caption = '' ) then begin
      UnVisibleElements(2);
    end
    else begin
      SetVisibleElements(2);
    end;
    if ( lT3.Caption = '' ) then begin
      UnVisibleElements(3);
    end
    else begin
      SetVisibleElements(3);
    end;
    if ( lT4.Caption = '' ) then begin
      UnVisibleElements(4);
    end
    else begin
      SetVisibleElements(4);
    end;
end;

end.
