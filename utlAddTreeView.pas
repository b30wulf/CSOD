unit utlAddTreeView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TAddTreeView = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    CBRegin: TComboBox;
    LRegin: TLabel;
    SBReginAdd: TSpeedButton;
    SBReginDel: TSpeedButton;
    Panel1: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddTreeView: TAddTreeView;

implementation

{$R *.DFM}

end.
