unit LogWarn;

interface

uses
  {$IFDEF VER90}
  Windows,
  {$ELSE}
  WinProcs,
  {$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TLogWarnForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogWarnForm: TLogWarnForm;

implementation

{$R *.DFM}

end.
