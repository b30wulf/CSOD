unit fLogView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, utldatabase,
  fLogFile,
  fLogTypeCommand;

type
  TLogView = class(TForm)
    Panel1: TPanel;
    LOGRich: TRichEdit;
    BeginTime: TDateTimePicker;
    EndTime: TDateTimePicker;
    BeginTimeLabel: TLabel;
    EndTimeLabel: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure BeginTimeChange(Sender: TObject);
    procedure SetEventLog;
    procedure Button1Click(Sender: TObject);
    procedure EndTimeChange(Sender: TObject);
  private
    function SetStringColor(grp : integer):TColor;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogView: TLogView;

implementation

{$R *.DFM}

procedure TLogView.FormActivate(Sender: TObject);
var  i : integer;
begin
{  LogFile.onCloseProgram := true;
  LogFile.AddEventGroup(0,0,0,0);
  LogFile.AddEventStringGroup(0,0,0,0,'');
  LogFile.onCloseProgram := false;
      LOGRich.Lines.BeginUpdate;
  LOGRich.Clear;
     LOGRich.Lines.EndUpdate;
  LogFile.LoadEventList(BeginTime.DateTime,EndTime.DateTime); //TEST

  for i := 0 to LogFile.LOGList.Count - 1 do begin
    LogFile.LOGItem := TLogItem(LogFile.LOGList.Items[i]);

     LOGRich.Lines.BeginUpdate;
     LOGRich.SelStart := LOGRich.GetTextLen;
     LOGRich.SelAttributes.Color := SetStringColor(LogFile.LOGItem.GRP);
//     LOGRich.SelAttributes.Style := l_Font;

//     LOGRich.Lines.Add(DateTimeToStr(Now()) + ' :> ' + _Message);

    LOGRich.Lines.Add(LogFile.LOGItem.DTIME + ' | ' +
                      LogFile.LOGItem.USER + ' | ' +
                        LogFile.LOGItem.EVTEXT + ' | ' +
                      LogFile.LOGItem.TX);

     LOGRich.Lines.EndUpdate;



  end;}
   BeginTime.DateTime:=Now;
   EndTime.DateTime:=Now;
   SetEventLog;
//  LOGRich.Lines:=LogFile.STR;
  //
end;

function TLogView.SetStringColor(grp : integer):TColor;
var cl : TColor;
begin
  case grp of
    120 : cl:= ColorGroup120CE;
    121 : cl:= ColorGroup121PC;
    130 : cl:= ColorGroup130CE;
    131 : cl:= ColorGroup131CE;
    132 : cl:= ColorGroup132CE;
//    133 : cl:= ColorGroup133CE;
    140 : cl:= ColorGroup140ME;
    150 : cl:= ColorGroup150QE;
    155 : cl:= ColorGroup155PE;
    160 : cl:= ColorGroup160GES;
    161 : cl:= ColorGroup161GEAPG;
    162 : cl:= ColorGroup162GEAP;
    200 : cl:= ColorGroup200MR;
    else cl:= clGray;
  end;
  Result := cl;
end;


procedure TLogView.BeginTimeChange(Sender: TObject);
begin
   EndTime.DateTime:=BeginTime.DateTime;
   SetEventLog;
end;

procedure TLogView.SetEventLog;
var  i : integer;
begin
  LogFile.onCloseProgram := true;
  LogFile.AddEventGroup(0,0,0,0);
  LogFile.AddEventStringGroup(0,0,0,0,'');
  LogFile.onCloseProgram := false;
  //    LOGRich.Lines.BeginUpdate;
  LOGRich.Lines.Clear;
  //   LOGRich.Lines.EndUpdate;
  LogFile.LoadEventList(BeginTime.DateTime,EndTime.DateTime); //TEST

  for i := 0 to LogFile.LOGList.Count - 1 do begin
    LogFile.LOGItem := TLogItem(LogFile.LOGList.Items[i]);

     LOGRich.Lines.BeginUpdate;
     LOGRich.SelStart := LOGRich.GetTextLen;
     LOGRich.SelAttributes.Color := SetStringColor(LogFile.LOGItem.GRP);
//     LOGRich.SelAttributes.Style := l_Font;
//     LOGRich.Lines.Add(DateTimeToStr(Now()) + ' :> ' + _Message);

    LOGRich.Lines.Add(LogFile.LOGItem.DTIME + ' | ' +
                      LogFile.LOGItem.USER + ' | ' +
                      LogFile.LOGItem.EVTEXT + ' | ' +
                      LogFile.LOGItem.TX);

     LOGRich.Lines.EndUpdate;
  end;
  for i := 0 to LogFile.LOGList.Count -1 do begin
    LogFile.LOGItem := TLOGItem(LogFile.LOGList[i]);
    FreeAndNil(LogFile.LOGItem);
  end;
  LogFile.LOGList.Clear;
end;
procedure TLogView.Button1Click(Sender: TObject);
begin
    LOGRich.Lines.Clear;
end;

procedure TLogView.EndTimeChange(Sender: TObject);
begin
   SetEventLog;
end;

end.
