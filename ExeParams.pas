unit ExeParams;

interface

uses SysUtils;

type
  TStartParams = record
    isStartOpros :Boolean;
    isWriteLog   :Boolean;
    isResError   :Boolean;
    UserName     : string;
    Pass         : string;
    AutoReset    : Boolean;    
  end;

var
  startParams :TStartParams;

implementation

procedure InitParams();
var
  I :Integer;
  S,n :String;
  pc   : integer;
begin
  startParams.isStartOpros := False;
  startParams.isWriteLog   := False;
  startParams.isResError   := False;


  startParams.AutoReset    := False;
  startParams.UserName     := '';
  startParams.Pass         := '';

  for I := 1 to ParamCount do begin
    S := LowerCase(ParamStr(I));
    if S = '-startopros' then begin
      startParams.isStartOpros := True; //�������� ��������������� ������
    end
    else if S = '-writelog' then begin  //�������� ����������� � ����
      startParams.isWriteLog := True;
    end
    else if S = '-reserror' then begin //�������� ���������� ��������� � ����������
      startParams.isResError := True;
    end else
    if S = '-username' then begin
      startParams.UserName := ParamStr(I+1);
    end else
    if S = '-pass' then begin
      startParams.Pass := ParamStr(I+1);
    end;
  end;
end;

initialization
  InitParams();

finalization


end.
