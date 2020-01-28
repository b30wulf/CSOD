unit knsl1cport;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst;
type
    CPort = class(TPersistent)
    protected
     m_byID        : Byte;
     m_byType      : Byte;
     m_byIsControl : Byte;
     m_byReccBoxID : Byte;
     m_sbyProtoType: Byte; 
     m_wCurrMtrType: Word;
     m_wCurrMtrID  : Word;
     m_nL1         : SL1TAG;
     m_blIsPause   : Boolean;
     constructor Create;
     destructor Destroy;override;
    public
     function  EventHandler(var pMsg:CMessage):boolean;virtual; abstract;
     procedure Close;virtual; abstract;
     procedure MakeMessageL1;virtual; abstract;
     procedure RunTmr;virtual; abstract;
     procedure Init(var pL1:SL1TAG);virtual; abstract;
     procedure SetDynamic(var pL1 : SL1SHTAG);virtual; abstract;
     procedure SetDefaultSett;virtual; abstract;
     function Send(pMsg:Pointer;nLen:Word):Boolean;virtual; abstract;
     function Connect(var pMsg:CMessage):Boolean;virtual;abstract;
     function ReConnect(var pMsg:CMessage):Boolean;virtual;abstract;
     function Disconnect(var pMsg:CMessage):Boolean;virtual; abstract;
     function FreePort(var pMsg:CMessage):Boolean;virtual;abstract;
     function SettPort(var pMsg:CMessage):Boolean;virtual; abstract;
     procedure QueryConnect(var pMsg:CMessage);virtual;
    End;
    PCPort =^ CPort;
implementation
constructor CPort.Create;
Var
   v : Integer;
Begin
   v := 0;
End;
destructor CPort.Destroy;
Begin
   inherited;
End;
procedure CPort.QueryConnect(var pMsg:CMessage);
Begin
End;
end.
