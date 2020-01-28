unit knsl5calendar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RbDrawCore, RbButton, ComCtrls;

type
  TMCalendar = class(TForm)
    RbButton1: TRbButton;
    DateTimePicker1: TDateTimePicker;
    RbButton2: TRbButton;
    RbButton3: TRbButton;
    procedure OnSetTime(Sender: TObject);
    procedure OnDate(Sender: TObject);
    procedure OnTime(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MCalendar: TMCalendar;

implementation

{$R *.DFM}

procedure TMCalendar.OnSetTime(Sender: TObject);
begin
    Close;
    ModalResult := mrOK;
end;

procedure TMCalendar.OnDate(Sender: TObject);
begin
    DateTimePicker1.Kind := dtkDate;
end;

procedure TMCalendar.OnTime(Sender: TObject);
begin
    DateTimePicker1.Kind := dtkTime;
end;

end.
