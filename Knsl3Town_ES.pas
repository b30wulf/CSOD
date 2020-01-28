unit Knsl3Town_ES;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RbDrawCore, RbButton, GradientLabel, StdCtrls, AdvProgressBar, rtflabel,
  ExtCtrls, AdvPanel, AdvOfficePager;

type
  TAdvTownES = class(TForm)
    aop_AbonPages: TAdvOfficePager;
    aop_AbonAttributes: TAdvOfficePage;
    AdvPanel3: TAdvPanel;
    Label1: TLabel;
    RTFLabel1: TRTFLabel;
    AdvProgressBar1: TAdvProgressBar;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    cmbPullAbon: TComboBox;
    Label14: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    GradientLabel1: TGradientLabel;
    cbm_nRegion: TComboBox;
    cbm_nDepart: TComboBox;
    cbm_nTown: TComboBox;
    btn_nTownAdd: TRbButton;
    btn_nTownDel: TRbButton;
    cbm_nStreet: TComboBox;
    btn_nStreetAdd: TRbButton;
    btn_nStreetDel: TRbButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AdvTownES: TAdvTownES;

implementation

{$R *.DFM}

end.
