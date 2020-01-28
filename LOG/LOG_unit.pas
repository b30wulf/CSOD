unit LOG_unit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  fLogFile,
  fLogView;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses fBases;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  LogView.ShowModal;
{  LogFile.LoadEventList;
  ListBox1.Items := LogFile.STR;}
end;



procedure TForm1.Button2Click(Sender: TObject);
var b : boolean;
    i : integer;
    t1, t2 : TDateTime;
    h : TDateTime;
    l1, l2, ll : longint;
begin
  l1 := GetTickCount;
  t1:=now;
  for i := 0 to 199 do begin
    LogFile.AddEvent(100, 102, i + 8000, now);
  end;
  ListBox1.Items:=LogFile.STR;
  l2 := GetTickCount;
  t2:=now;
  h := t2 - t1;
  ll:=l2-l1;
  ListBox1.Items := LogFile.STR;  
  ListBox1.Items.Add(TimeToStr(h));
  ListBox1.Items.Add(IntToStr(ll));
end;




procedure TForm1.Button3Click(Sender: TObject);
var b : boolean;
    i : integer;
    t1, t2 : TDateTime;
    h : TDateTime;
    l1, l2, ll : longint;
begin
  l1 := GetTickCount;
  t1:=now;
  for i := 0 to 33 do begin
    LogFile.AddEventGroup(100, 102, i + 9000, now)
  end;
  l2 := GetTickCount;
  t2:=now;
  h := t2 - t1;
  ListBox1.Items.Add(TimeToStr(h));
  ll:=l2-l1;
  ListBox1.Items.Add(IntToStr(ll));
end;

procedure TForm1.Button4Click(Sender: TObject);
var b : boolean;
    i, j : integer;
    t1, t2 : TDateTime;
    h : TDateTime;
    l1, l2, ll : longint;
begin
  l1 := GetTickCount;
  t1:=now;
  for i := 0 to 99 do begin
    j := i mod 5;
    LogFile.AddEventString(100, 102, 16000, now, 'строчка ' + IntToStr(j));
  end;
  l2 := GetTickCount;
  t2:=now;
  h := t2 - t1;
  ListBox1.Items.Add(TimeToStr(h));
  ll:=l2-l1;
  ListBox1.Items.Add(IntToStr(ll));
end;

procedure TForm1.Button5Click(Sender: TObject);
var b : boolean;
    i, j : integer;
    t1, t2 : TDateTime;
    h : TDateTime;
    l1, l2, ll : longint;
begin
  l1 := GetTickCount;
  t1:=now;
  for i := 0 to 22 do begin
    j := i mod 5;
    LogFile.AddEventStringGroup(100, 102, 15000, now, 'строчка ' + IntToStr(j));
  end;
  l2 := GetTickCount;
  t2:=now;
  h := t2 - t1;
  ListBox1.Items.Add(TimeToStr(h));
  ll:=l2-l1;
  ListBox1.Items.Add(IntToStr(ll));
end;

procedure TForm1.Button6Click(Sender: TObject);
var  MS : TMemoryStream;
begin
  MS := TMemoryStream.Create;

  MS.LoadFromFile('grddrv.lib');

  LogFile.AddEventBlob(100,102,17000,now,MS);

  MS.Destroy;
end;

end.
