unit knsl2editframe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Grids, BaseGrid, AdvGrid, TeEngine, Series, TeeProcs,
  Chart, RbDrawCore, RbButton, jpeg, ExtCtrls, ToolWin, ImgList;

type
  TTL2EditForm = class(TForm)
    tbVGraph: TToolBar;
    ToolButton50: TToolButton;
    ToolButton51: TToolButton;
    ToolButton52: TToolButton;
    ToolButton53: TToolButton;
    ToolButton54: TToolButton;
    ToolButton55: TToolButton;
    ToolButton56: TToolButton;
    ToolButton57: TToolButton;
    ToolButton58: TToolButton;
    ToolButton59: TToolButton;
    imgEditPannel: TImageList;
    Panel8: TPanel;
    Image6: TImage;
    Label7: TLabel;
    Chart1: TChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    Series3: TBarSeries;
    Series4: TBarSeries;
    dtPic1: TDateTimePicker;
    dtPic2: TDateTimePicker;
    Label1: TLabel;
    procedure OnCloseCForm(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TL2EditForm: TTL2EditForm;

implementation

{$R *.DFM}

procedure TTL2EditForm.OnCloseCForm(Sender: TObject;
  var Action: TCloseAction);
begin
    Action := caFree;
end;

end.
