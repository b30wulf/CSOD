unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm4 = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit3;

{$R *.DFM}

procedure TForm4.Button1Click(Sender: TObject);
begin
        Form3.ShowModal;
end;

procedure TForm4.FormCreate(Sender: TObject);
var vg    : String;
    SafeF : TextFile;
    str, test   : String;
    index : Integer;
begin
    vg := ExtractFilePath(Application.Exename);
    vg := (vg + 'Settings\OPC_tegs.ini');
    AssignFile(SafeF, vg);
    if FileExists(vg) then
    begin
        Reset(SafeF);
        readLn(SafeF, str); // в переменную str
        while str <> '' do
        begin
             if copy(str, 0, 4) = '----' then
             begin
                  index := pos('----', copy(str, 4, length(str))) - 2;
                  test :=  copy(str, 5, index);
                  ComboBox1.Items.Add(test);
                  readLn(SafeF, str);
             end
             else
             begin
                  readLn(SafeF, str);
             end;
        end;
        CloseFile(SafeF);
    end;
end;

{
var   vg    : String;
      SafeF : TextFile;
      str   : string;
begin
      vg := ExtractFilePath(Application.Exename);
      vg := (vg + 'Settings\OPC_tegs.ini');
      AssignFile(SafeF, vg);
      if FileExists(vg) then
        begin
                Reset(SafeF);
                readLn(SafeF, str); // в переменную str записываем информацию из файла f
                While str <> '' do
                begin
                        MyStringGrid.Cells[1, Count_in_File + 1] := str;
                        MyStringGrid.Cells[0, Count_in_File + 1] := IntToStr(Count_in_File + 1);
                        readLn(SafeF, str);
                        Count_in_File := Count_in_File + 1;
                end;
                CloseFile(SafeF);
        end;
end;
}

end.
