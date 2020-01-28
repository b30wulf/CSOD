unit knsl3updatemanager;
interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlconst,inifiles,Db,ADODB
    ,knsl5tracer, Dates,utlbox, utlTimeDate,math,utldatabase,ShellApi,Graphics;
type
    CUpdateManager = class
    private
     edm_nUpdatePath  : PTEdit;
     cbm_nIsRemLink   : PTComboBox;
     edm_nIsRemLink   : PTEdit;
     {
     pbm_nUnpackUpdate: PTGauge;
     pbm_nCopyUpdate  : PTGauge;
     pbm_nLoadUpdate  : PTGauge;
     }
     edm_nRemLinkState: PTEdit;
     edm_nLoadUpdate  : PTEdit;
     edm_nUnpackUpdate: PTEdit;
     edm_nCopyUpdate  : PTEdit;
     edm_nStartProgramm: PTEdit;
     edm_nDestPath    : PTEdit;
     m_pTable         : PSGENSETTTAG;
     m_npTable        : SL3CONNTBLS;
     m_strDestPath    : String;
     m_strSrcPath     : String;
     function  WindowsCopyFile(FromFile, ToDir : string) : boolean;
     procedure InitComboConn;
    public
     procedure Init(pTable:PSGENSETTTAG);
     procedure OnStartCall;
     procedure OnStopCall;
     procedure OnStartReload;
     procedure OnChandgeConn;
     procedure OnStartCopy;
    Public
     property Pedm_nUpdatePath  : PTEdit     read edm_nUpdatePath   write edm_nUpdatePath;
     property Pcbm_nIsRemLink   : PTComboBox read cbm_nIsRemLink    write cbm_nIsRemLink;
     property Pedm_nIsRemLink   : PTEdit     read edm_nIsRemLink    write edm_nIsRemLink;
     {
     property Ppbm_nUnpackUpdate: PTGauge    read pbm_nUnpackUpdate write pbm_nUnpackUpdate;
     property Ppbm_nCopyUpdate  : PTGauge    read pbm_nCopyUpdate   write pbm_nCopyUpdate;
     property Ppbm_nLoadUpdate  : PTGauge    read pbm_nLoadUpdate   write pbm_nLoadUpdate;
     }
     property Pedm_nRemLinkState: PTEdit     read edm_nRemLinkState write edm_nRemLinkState;
     property Pedm_nLoadUpdate  : PTEdit     read edm_nLoadUpdate   write edm_nLoadUpdate;
     property Pedm_nUnpackUpdate: PTEdit     read edm_nUnpackUpdate write edm_nUnpackUpdate;
     property Pedm_nCopyUpdate  : PTEdit     read edm_nCopyUpdate   write edm_nCopyUpdate;
     property Pedm_nStartProgramm: PTEdit    read edm_nStartProgramm write edm_nStartProgramm;
     property Pedm_nDestPath    : PTEdit     read edm_nDestPath     write edm_nDestPath;
    End;
implementation
procedure CUpdateManager.Init(pTable:PSGENSETTTAG);
Begin
     m_pTable := pTable;
     InitComboConn;
     edm_nRemLinkState.Color := clRed;
     edm_nLoadUpdate.Color   := clRed;
     edm_nUnpackUpdate.Color := clRed;
     edm_nCopyUpdate.Color   := clRed;
     edm_nStartProgramm.Color:= clRed;
     edm_nUpdatePath.Text    := GetCurrentDir;
End;
procedure CUpdateManager.OnStartCall;
Begin
End;
procedure CUpdateManager.OnStopCall;
Begin
End;
procedure CUpdateManager.OnStartCopy;
Begin
      edm_nLoadUpdate.Color   := clRed;
      if WindowsCopyFile(m_strSrcPath,m_strDestPath)=True then
      Begin
       edm_nLoadUpdate.Color   := clLime;
       //SendUnpak;
      End;
      //SendUnpak
      //SendCopy
      //SendRestart
End;
procedure CUpdateManager.OnStartReload;
Begin
     //CopyFile(PChar('d:\mxusb_setup_1.3.zip'),PChar('192.168.1.6:C:\a2000\mxusb_setup_1.3.zip'),False);
     //WindowsCopyFile('d:\mxusb_setup_1.3.zip', '127.0.0.1\C:\a2000\');
     WindowsCopyFile(m_strSrcPath,m_strDestPath);
     //CopyFile('\\server\dir\file.txt','C:\a.txt',False);
End;
function CUpdateManager.WindowsCopyFile(FromFile, ToDir : string) : boolean;
var
     F : TShFileOpStruct;
begin
     if not((FromFile='')or(ToDir='')) then
     Begin
      F.Wnd := 0; F.wFunc := FO_COPY;
      FromFile:=FromFile+#0; F.pFrom:=pchar(FromFile);
      ToDir:=ToDir+#0; F.pTo:=pchar(ToDir);
      F.lpszProgressTitle := pchar(ToDir);
      F.fFlags := FOF_SIMPLEPROGRESS;
      result:=ShFileOperation(F) = 0;
     End else result := False;
end;
procedure CUpdateManager.InitComboConn;
Var
     i      : Integer;
Begin
     cbm_nIsRemLink.Items.Clear;
     if m_pDB.GetConnTable(m_npTable) then
     Begin
      for i:=0 to m_npTable.Count-1 do
      cbm_nIsRemLink.Items.Add(m_npTable.Items[i].m_sName);
      cbm_nIsRemLink.ItemIndex := 0;
      OnChandgeConn;
     End;
End;
procedure CUpdateManager.OnChandgeConn;
Begin
     try
      edm_nIsRemLink.Text := m_npTable.Items[cbm_nIsRemLink.ItemIndex].m_sLogin;
      if edm_nUpdatePath.Text<>'' then
      Begin
       m_strSrcPath := edm_nUpdatePath.Text;
       if pos('.',edm_nIsRemLink.Text)<>0 then m_strDestPath:= edm_nIsRemLink.Text+':'+'c:\a2000\ascue\input\' else
       if pos('.',edm_nIsRemLink.Text)=0 then m_strDestPath:= 'c:\a2000\ascue\input\';
       edm_nDestPath.Text := m_strDestPath;
      End;
     except
     end;
End;
end.
 