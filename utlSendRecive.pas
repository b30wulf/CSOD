unit utlSendRecive;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,utltypes,utlconst;

type

  TRecivedClass = class
  private
    //Обработчик сообщения WM_COPYDATA
//    procedure WMCopyData(var MessageData: TWMCopyData); message WM_COPYDATA;
  public
    procedure WMCopyData(var MessageData: TWMCopyData; var s : string);
    function ExtractString(s : string): SQWERYCMDID;
    function ExtractStringBoxEvent(s: string; var _type:byte): string;
    function ExtractStringBoxEventMsg(s: string; var _type:byte; var TextMessage : string): CMessage;    
    function StrToByte(const Value: String; msg:CMessage): CMessage;
    { Public declarations }
  end;

  TSenderClass = class
    procedure Send(CMDID:Integer;Handle,HandlParent : integer; str:String);
  private
    { Private declarations }
  public
    function ToString(SQMD : SQWERYCMDID): string;
    function ToStringBox(_Type : Integer; _Message : String): string;
    function ToStringBoxMsg(_Type : Integer; _Message : String; msg : CMessage): string;
    { Public declarations }
  end;

const
  CMD_SETLABELTEXT = 1;

implementation

uses knsl5module;

procedure TRecivedClass.WMCopyData(var MessageData: TWMCopyData; var s : string);
begin
  //Устанавливаем свойства метки, если заданная команда совпадает
  if (MessageData.CopyDataStruct.dwData = CMD_SETLABELTEXT)
  or (MessageData.CopyDataStruct.dwData = QL_QWERYTREE_REQ)
  or (MessageData.CopyDataStruct.dwData = QL_QWERYSTATUSBAR_REQ)
  or (MessageData.CopyDataStruct.dwData = QL_QWERYSTATISTICABON_REQ)
  or (MessageData.CopyDataStruct.dwData = QL_QWERYBOXEVENT)
  or (MessageData.CopyDataStruct.dwData = QL_QWERYBOXEVENTMSG) then
  begin
    //Устанавливаем текст из полученных данных
    // TKnsForm.Label48.Caption := PAnsiChar((MessageData.CopyDataStruct.lpData));
    // LabelStr.Caption := PAnsiChar((MessageData.CopyDataStruct.lpData));
    s := PAnsiChar((MessageData.CopyDataStruct.lpData));
    MessageData.Result := 1;
  end
  else
    MessageData.Result := 0;
end;

procedure TSenderClass.Send(CMDID:Integer;Handle,HandlParent: integer; str:String);
var
  CDS: TCopyDataStruct;
  //TextForRecive : string;
  AppReciver : string;
  wnd         : HWND;
begin

//str := IntToStr(Random(100000));
 // TextForRecive := FormatDateTime('dddd, mmmm d, yyyy, hh:mm:zzz AM/PM',Now);

  AppReciver := ExtractFileName(Application.ExeName);
  AppReciver := Copy(AppReciver, 1, Pos('.', AppReciver)-1);
  //Устанавливаем тип команды
  CDS.dwData := CMDID; //CMD_SETLABELTEXT;
  //Устанавливаем длину передаваемых данных
  CDS.cbData := Length(str) + 1;
  //Выделяем память буфера для передачи данных
  GetMem(CDS.lpData, CDS.cbData);
  try
  //  wnd := FindWindow(LPCTSTR('TTQweryModule'), nil);    // TTQweryModule

    // wnd := FindWindow(LPCTSTR('knsmodule'), nil);
    //Копируем данные в буфер
    StrPCopy(CDS.lpData, AnsiString(str));
    //Отсылаем сообщение в окно с заголовком StringReceiver
{    SendMessage(FindWindow(nil, 'knsmodule'),
                  WM_COPYDATA, Handle, Integer(@CDS));
 } //SendMessage(FindWindow(LPCTSTR, 'TTQweryModule'),nil);

   //if wnd <> 0 then
    //   SendMessage(wnd,WM_COPYDATA, Handle, Integer(@CDS));
  //  SendMessage(FindWindowEx(FindWindow('TTKnsForm', nil),0,'Label48',nil),WM_COPYDATA,0,Integer(@CDS));


   SendMessage(Handle, WM_COPYDATA, HandlParent, Integer(@CDS));

   //FindWindow(LPCTSTR('TTKnsForm'), nil);
  //  SendMessage(Handle, WM_COPYDATA, Handle, Integer(@CDS));
  finally
    //Высвобождаем буфер
    FreeMem(CDS.lpData, CDS.cbData);
  end;
end;


function TSenderClass.ToString(SQMD: SQWERYCMDID): string;
var s : string;
begin
  s := IntToStr(SQMD.m_snABOID) + #10 + IntToStr(SQMD.m_snSRVID) + #10 + IntToStr(SQMD.m_snCLID) + #10 +
       IntToStr(SQMD.m_snCLSID) + #10 + IntToStr(SQMD.m_snCmdID) + #10 + IntToStr(SQMD.m_snVMID) + #10 +
       IntToStr(SQMD.m_snMID)   + #10 + IntToStr(SQMD.m_snPrmID) + #10 + IntToStr(SQMD.m_snResult) + #10 +
       DateTimeToStr(SQMD.m_sdtBegin) + #10 + DateTimeToStr(SQMD.m_sdtEnd);
  Result := s;
end;

function TSenderClass.ToStringBox(_Type : Integer; _Message : String): string;
var s : string;
begin
  s := IntToStr(_Type) + #10 + _Message;
  Result := s;
end;

function TSenderClass.ToStringBoxMsg(_Type : Integer; _Message : String; msg : CMessage): string;
var
  s : string;
  i : integer;
  Litera: char;
begin
  s := IntToStr(_Type) + #10 + _Message + #10;
  s:=s + IntToStr(msg.m_swLen)+ #10 + IntToStr(msg.m_swObjID)+ #10 + IntToStr(msg.m_sbyFrom)+ #10 +  IntToStr(msg.m_sbyFor)+ #10 +
  IntToStr(msg.m_sbyType)+ #10 + IntToStr(msg.m_sbyTypeIntID)+ #10 + IntToStr(msg.m_sbyIntID)+ #10 + IntToStr(msg.m_sbyServerID)+ #10 + IntToStr(msg.m_sbyDirID)+ #10;

  for i:=0 to Length(msg.m_sbyInfo)-1 do
    begin
      Litera:= Chr(msg.m_sbyInfo[I] + 48);
      s:=s+Litera;
    end;
    
  Result := s;
end;




{
function TForm1.StrToByte(const Value: String): TByteArr;
var
    I: integer;
begin
    SetLength(Result, Length(Value));
    for I := 0 to Length(Value) - 1 do
        Result[I] := ord(Value[I + 1]) - 48;
end;
  
function TForm1.ByteToString(const Value: TByteArr): String;
var
    I: integer;
    S : String;
    Litera: char;
begin
    S := '';
    for I := Length(Value)-1 Downto 0 do
    begin
        Litera := Chr(Value[I] + 48);
        S := Litera + S;
    end;
    Result := S;
end;

}

function TRecivedClass.ExtractStringBoxEvent(s: string; var _type:byte): string;
var SQMD   : SQWERYCMDID;
    s0     : string;
begin
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  _type := StrToInt(s0);
  Result:= s;
end;

function TRecivedClass.StrToByte(const Value: String; msg:CMessage): CMessage;
var
    I: integer;
begin
    FillChar(msg.m_sbyInfo,SizeOf(msg.m_sbyInfo),0);
    for I := 0 to Length(Value) - 1 do
        msg.m_sbyInfo[I] := ord(Value[I + 1]) - 48;
    Result:= msg;
end;

function TRecivedClass.ExtractStringBoxEventMsg(s: string; var _type:byte; var TextMessage : string): CMessage;
var
  s0   : string;
begin
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  _type := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  TextMessage := s0;
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  Result.m_swLen   := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  Result.m_swObjID := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  Result.m_sbyFrom := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  Result.m_sbyFor  := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  Result.m_sbyType := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  Result.m_sbyTypeIntID := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  Result.m_sbyIntID     := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  Result.m_sbyServerID  := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  Result.m_sbyDirID     := StrToInt(s0);
  Result:= StrToByte(s,Result);
end;

function TRecivedClass.ExtractString(s: string): SQWERYCMDID;
var SQMD   : SQWERYCMDID;
    s0     : string;
begin
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  SQMD.m_snABOID := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  SQMD.m_snSRVID := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  SQMD.m_snCLID := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  SQMD.m_snCLSID := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  SQMD.m_snCmdID := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  SQMD.m_snVMID := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  SQMD.m_snMID := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  SQMD.m_snPrmID := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  SQMD.m_snResult := StrToInt(s0);
  s0 := Copy(s, 1, Pos(#10, s)-1);  Delete(s, 1, Pos(#10, s));  SQMD.m_sdtBegin := StrToDateTime(s0);
  s0 := s;  SQMD.m_sdtEnd := StrToDateTime(s0);

  Result := SQMD;
end;

end.
