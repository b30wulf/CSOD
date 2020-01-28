unit knsl5ArchBaseCopy;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, RbDrawCore, RbButton, StdCtrls, GradientLabel, AdvGlowButton,
  AdvToolBar, ExtCtrls, AdvPanel, Menus, AdvMenus, inifiles, knsl3savebase,
  utldatabase, ShellApi, ZLib;

type
  TArchBaseCopy = class(TForm)
    AdvPanel9: TAdvPanel;
    AdvToolBar8: TAdvToolBar;
    AdvGlowMenuButton19: TAdvGlowMenuButton;
    AdvGlowMenuButton20: TAdvGlowMenuButton;
    AdvGlowMenuButton21: TAdvGlowMenuButton;
    mMySQLECmpl: TLabel;
    mMySQLENext: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label51: TLabel;
    Label56: TLabel;
    GradientLabel3: TGradientLabel;
    Label25: TLabel;
    Label50: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    GradientLabel5: TGradientLabel;
    mMySQLStat: TMemo;
    edm_sArchPath: TEdit;
    cbm_byEnableArchiv: TComboBox;
    cbm_tmArchPeriod: TComboBox;
    edm_sSrcPath: TEdit;
    RbButton5: TRbButton;
    RbButton4: TRbButton;
    tmm_dtEnterArchTime: TDateTimePicker;
    pmExportBase: TAdvPopupMenu;
    miDBFSave: TMenuItem;
    pmExportBaseExp: TAdvPopupMenu;
    miHandExport: TMenuItem;
    pmExportBaseCntrl: TAdvPopupMenu;
    N5: TMenuItem;
    miOnSetDBF: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    N1: TMenuItem;
    cbbStoragePeriodM: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cbbStoragePeriodD: TComboBox;
    procedure RbButton5Click(Sender: TObject);
    procedure RbButton4Click(Sender: TObject);
    procedure miDBFSaveClick(Sender: TObject);
    procedure miDBFReadClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure miOnSetDBFClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure miHandExportClick(Sender: TObject);
    procedure AdvGlowMenuButton21Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    SaveBase : CSaveBase;
    StoreClrTime : Integer;
    function GetNameError(e : Integer; var desc : string): string;
//    SaveDB   : PCSaveBase;
    { Privat
    procedure miDBFReadClick(Sender: TObject);
    procedure miDBFReadClick(Sender: TObject);e declarations }
  public
    procedure CompressFile(SourceFileName,DestFileName:string);
    procedure DeCompressFile(SourceFileName,DestFileName:string);
    function  GenClearPeriod(i : integer):Integer;
    { Public declarations }
  end;

var
  ArchBaseCopy: TArchBaseCopy;

implementation

{$R *.DFM}

uses utlTimeDate, utlDB, knsl5config;

procedure TArchBaseCopy.RbButton5Click(Sender: TObject);
begin
    OpenDialog1.DefaultExt := 'fbk';
    OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
    OpenDialog1.FileName   := 'sysinfoauto.fbk';
    OpenDialog1.Filter     := 'Файлы баз данных|*.fbk;*.fdb';
    try
     if OpenDialog1.Execute=True then
     edm_sSrcPath.Text := OpenDialog1.FileName;
    except
    end;
end;

procedure TArchBaseCopy.RbButton4Click(Sender: TObject);
begin
    SaveDialog1.DefaultExt := 'fbk';
    SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName)+'Archive';
    SaveDialog1.FileName   := '1.fbk';
    SaveDialog1.Filter     := 'Файлы баз данных|*.fbk;*.fdb';
    try
    if SaveDialog1.Execute=True then
    Begin
     if SaveDialog1.FileName<>'' then
     edm_sArchPath.Text := ExtractFilePath(SaveDialog1.FileName);
    End;
    except

    end;
end;

procedure TArchBaseCopy.miDBFSaveClick(Sender: TObject);
var
    strPath : String;
    Fl      : TINIFile;
Begin
    strPath := ExtractFilePath(Application.ExeName)+'\Settings\UnLoad_Config.ini';
    try
    Fl := TINIFile.Create(strPath);
    Fl.WriteString('UNLOAD_MYARCHBASE','edm_sSrcPath',edm_sSrcPath.Text);
    Fl.WriteString('UNLOAD_MYARCHBASE','edm_sArchPath',edm_sArchPath.Text);
    Fl.WriteString('UNLOAD_MYARCHBASE','tmm_dtEnterArchTime',TimeToStr(tmm_dtEnterArchTime.DateTime));
    Fl.WriteString('UNLOAD_MYARCHBASE','cbm_tmArchPeriod',cbm_tmArchPeriod.Text);
    Fl.WriteString('UNLOAD_MYARCHBASE','cbm_byEnableArchiv',cbm_byEnableArchiv.Text);
    Fl.WriteInteger('UNLOAD_MYARCHBASE','cbm_tmArchPeriodIndx',cbm_tmArchPeriod.ItemIndex);
    Fl.WriteInteger('UNLOAD_MYARCHBASE','cbm_byEnableArchivIndx',cbm_byEnableArchiv.ItemIndex);
    Fl.WriteString('UNLOAD_MYARCHBASE','cbbStoragePeriodM',cbbStoragePeriodM.Text);
    Fl.WriteInteger('UNLOAD_MYARCHBASE','cbbStoragePeriodMIndx',cbbStoragePeriodM.ItemIndex);
    Fl.WriteString('UNLOAD_MYARCHBASE','cbbStoragePeriodD',cbbStoragePeriodD.Text);
    Fl.WriteInteger('UNLOAD_MYARCHBASE','cbbStoragePeriodDIndx',cbbStoragePeriodD.ItemIndex);
    Fl.Destroy;
    except
    end;
end;

procedure TArchBaseCopy.miDBFReadClick(Sender: TObject);
Var
    strPath : String;
    Fl      : TINIFile;
Begin
    strPath := ExtractFilePath(Application.ExeName) + '\Settings\SettStoreClrTime.dat';
    try
      cbbStoragePeriodM.items.loadfromfile(strPath);
      cbbStoragePeriodD.items.loadfromfile(strPath);
    except
    end;

    strPath := ExtractFilePath(Application.ExeName)+'\Settings\UnLoad_Config.ini';
    try
      Fl := TINIFile.Create(strPath);
      edm_sSrcPath.Text               := Fl.ReadString('UNLOAD_MYARCHBASE','edm_sSrcPath','');
      edm_sArchPath.Text              := Fl.ReadString('UNLOAD_MYARCHBASE','edm_sArchPath','');
      tmm_dtEnterArchTime.DateTime    := StrToDateTime(Fl.ReadString('UNLOAD_MYARCHBASE','tmm_dtEnterArchTime',''));
      cbm_byEnableArchiv.Text         := Fl.ReadString('UNLOAD_MYARCHBASE','cbm_byEnableArchiv','');
      cbm_byEnableArchiv.ItemIndex    := Fl.ReadInteger('UNLOAD_MYARCHBASE','cbm_byEnableArchivIndx',-1);
      cbm_tmArchPeriod.Text           := Fl.ReadString('UNLOAD_MYARCHBASE','cbm_tmArchPeriod','');
      cbm_tmArchPeriod.ItemIndex      := Fl.ReadInteger('UNLOAD_MYARCHBASE','cbm_tmArchPeriodIndx',-1);
      cbbStoragePeriodM.Text          := Fl.ReadString('UNLOAD_MYARCHBASE','cbbStoragePeriodM','');
      cbbStoragePeriodM.ItemIndex     := Fl.ReadInteger('UNLOAD_MYARCHBASE','cbbStoragePeriodMIndx',14);
      cbbStoragePeriodD.Text          := Fl.ReadString('UNLOAD_MYARCHBASE','cbbStoragePeriodD','');
      cbbStoragePeriodD.ItemIndex     := Fl.ReadInteger('UNLOAD_MYARCHBASE','cbbStoragePeriodDIndx',14);
      if Fl<>Nil then FreeAndNil(Fl);//Fl.Destroy;
    except
    end;

end;

procedure TArchBaseCopy.N1Click(Sender: TObject);
begin
  miDBFReadClick(Sender);
  cbm_byEnableArchiv.Enabled:=true;
  tmm_dtEnterArchTime.Enabled:=true;
  cbm_tmArchPeriod.Enabled:=true;
  edm_sSrcPath.Enabled:=true;
  edm_sArchPath.Enabled:=true;
  RbButton5.Enabled:=true;
  RbButton4.Enabled:=true;
  cbbStoragePeriodM.Enabled := True;
  cbbStoragePeriodD.Enabled := True;
end;

procedure TArchBaseCopy.miOnSetDBFClick(Sender: TObject);
begin
  cbm_byEnableArchiv.Enabled:=false;
  tmm_dtEnterArchTime.Enabled:=false;
  cbm_tmArchPeriod.Enabled:=false;
  edm_sSrcPath.Enabled:=false;
  edm_sArchPath.Enabled:=false;
  RbButton5.Enabled:=false;
  RbButton4.Enabled:=false;
  miDBFSaveClick(Sender);
  cbbStoragePeriodM.Enabled := false;
  cbbStoragePeriodD.Enabled := false;
end;

procedure TArchBaseCopy.FormActivate(Sender: TObject);
Begin
  miDBFReadClick(Sender);
  SaveBase := CSaveBase.Create;
end;

procedure TArchBaseCopy.FormDeactivate(Sender: TObject);
begin
  FreeAndNil(SaveBase);
end;

procedure RunDosInMemo(CmdLine: string; AMemo: TMemo);
const
  ReadBuffer = 2400;
var
  Security: TSecurityAttributes;
  ReadPipe, WritePipe: THandle;
  start: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  Buffer: Pchar;
  BytesRead: DWord;
  Apprunning: DWord;
  SaveCursor : TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := CrHourGlass;
  with Security do begin
    nlength := SizeOf(TSecurityAttributes);
    binherithandle := true;
    lpsecuritydescriptor := nil;
  end;
  if Createpipe(ReadPipe, WritePipe, @Security, 0) then begin
    Buffer := AllocMem(ReadBuffer + 1);
    FillChar(Start, Sizeof(Start), #0);
    start.cb := SizeOf(start);
    start.hStdOutput := WritePipe;
    start.hStdInput := ReadPipe;
    start.dwFlags := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    if CreateProcess(nil, PChar(CmdLine), @Security, @Security, true,
        NORMAL_PRIORITY_CLASS, nil, nil, start, ProcessInfo) then begin
      repeat
        Apprunning := WaitForSingleObject(ProcessInfo.hProcess, 100);
        ReadFile(ReadPipe, Buffer[0], ReadBuffer, BytesRead, nil);
        Buffer[BytesRead] := #0;
        OemToAnsi(Buffer, Buffer);
        AMemo.Text := AMemo.text + string(Buffer);

        AMemo.SelStart:=Length(AMemo.lines.text);
        AMemo.perform(EM_LINESCROLL,0,AMemo.lines.count);
        Application.ProcessMessages;
      until (Apprunning <> WAIT_TIMEOUT);
    end;
//    ReadFile(ReadPipe, Buffer[0], ReadBuffer, BytesRead, nil);
    Buffer[BytesRead] := #0;
    OemToAnsi(Buffer, Buffer);
    AMemo.Text := AMemo.text + string(Buffer);

    AMemo.SelStart:=Length(AMemo.lines.text);
    AMemo.perform(EM_LINESCROLL,0,AMemo.lines.count);
    Application.ProcessMessages;

    FreeMem(Buffer);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ReadPipe);
    CloseHandle(WritePipe);
  end;
  Screen.Cursor := SaveCursor;
end;


procedure TArchBaseCopy.miHandExportClick(Sender: TObject);
var
  Year,Month,Day,msec : Word;
  StrFrom, StrTo      : string;
  StrToZip            : string;
  eName, eDesc        : string;
  error               : Integer;
  strPackPath         : string;
  ST, ET              : TdateTime;
  DT                  : TdateTime;
  StrSQL              : string;
  rCountM, rCountD    : Integer;
  DayToM, DayToD      : Integer;
begin
  if cbm_byEnableArchiv.ItemIndex = 1 then begin    // ДА
    DecodeDate(Now,Year,Month,Day);
    try
      StrFrom := ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FDB';
      StrTo := ExtractFilePath(Application.ExeName)+'Archive\'+IntToStr(Year)+'_'+IntToStr(Month)+'_'+IntToStr(Day)+'.fbk';
      StrToZip := ExtractFilePath(Application.ExeName)+'Archive\'+IntToStr(Year)+'_'+IntToStr(Month)+'_'+IntToStr(Day)+'.zbk';

 //     DayTo := m_nCF.GenClearPeriod;
      DayToM := GenClearPeriod(cbbStoragePeriodM.ItemIndex);
      DT := Now - (DayToM{-24})*31;        // Убрать 24 для основной программы, делается только для проверки
      mMySQLStat.Lines.Add('Удаление данных по ' + DateToStr(DT));
      StrSQL := 'SELECT Count(M_SFVALUE) CN FROM L3ARCHDATA WHERE M_STIME < ''' + DateToStr(DT) + '''' + '  AND M_SWCMDID >= 21 AND M_SWCMDID <= 24';

      utlDB.DBase.OpenQry(StrSQL, rCountM);
      rCountM := utlDB.DBase.IBQuery.FieldByName('CN').AsInteger;
      StrSQL := 'DELETE FROM L3ARCHDATA WHERE M_STIME < ''' + DateToStr(DT) + '''' + '  AND M_SWCMDID >= 21 AND M_SWCMDID <= 24';
      utlDB.DBase.ExecQry(StrSQL);
      mMySQLStat.Lines.Add('Удалено записей: ' + IntToStr(rCountM));

      DayToD := GenClearPeriod(cbbStoragePeriodD.ItemIndex);
      DT := Now - (DayToD{-24})*31;        // Убрать 24 для основной программы, делается только для проверки
      mMySQLStat.Lines.Add('Удаление данных по ' + DateToStr(DT));
      StrSQL := 'SELECT Count(M_SFVALUE) CN FROM L3ARCHDATA WHERE M_STIME < ''' + DateToStr(DT) + '''' + '  AND M_SWCMDID >= 17 AND M_SWCMDID <= 20';

      utlDB.DBase.OpenQry(StrSQL, rCountD);
      rCountD := utlDB.DBase.IBQuery.FieldByName('CN').AsInteger;
      StrSQL := 'DELETE FROM L3ARCHDATA WHERE M_STIME < ''' + DateToStr(DT) + '''' + '  AND M_SWCMDID >= 17 AND M_SWCMDID <= 20';
      utlDB.DBase.ExecQry(StrSQL);
      mMySQLStat.Lines.Add('Удалено записей: ' + IntToStr(rCountD));
      mMySQLStat.Lines.Add('Суммарно удалено записей: ' + IntToStr(rCountD + rCountM));

      mMySQLStat.Lines.Add('Копирование базы в ' + pchar(StrTo));

      if true then begin
        ST := Now;
        mMySQLStat.Lines.Add('Старт копирования ' + DateTimeToStr(ST));

 //       strPackPath := 'gbak -b ' + StrFrom + ' ' + StrTo + ' -user SYSDBA -password masterkey -v';
 //       RunDosInMemo(strPackPath, mMySQLStat);

 {       mMySQLStat.Lines.Add('Compressed...');
//        CompressFile(StrTo, StrToZip);

        sleep(5000);
        RunDosInMemo('rar a ' + StrToZip + ' ' + StrTo, mMySQLStat);   }

        ET := Now;
        mMySQLStat.Lines.Add('Окончание копирования ' + DateTimeToStr(ET));
        mMySQLStat.Lines.Add('Время на создание копии ' + TimeToStr(ET - ST));

        mMySQLStat.Lines.Add('Done')
      end else begin
        error := GetLastError;
        eName := GetNameError(error, eDesc);
        mMySQLStat.Lines.Add('Ошибка ' + eName + '. Код: ' + IntToStr(error));
        mMySQLStat.Lines.Add(eDesc);
      end;
      ArchBaseCopy.Deactivate;
    except

    end;
  end;
end;

procedure TArchBaseCopy.AdvGlowMenuButton21Click(Sender: TObject);
begin
  miHandExportClick(Sender);
end;

function TArchBaseCopy.GetNameError(e: Integer; var desc: string): string;
var //tf        : TextFile;
    fn    : string;
    SL        : TStringList;
    i, h      : Integer;
    s, sa, sb : string;
begin
  fn := ExtractFilePath(Application.ExeName) + 'Settings\ErrorCodeRu.txt';
  SL := TStringList.Create;
  SL.LoadFromFile(fn);
  for i := 0 to SL.Count -1 do begin
    s := SL.Strings[i];
    sa := Trim(Copy(s, 1, 3));
    Delete(s, 1, 4);
    sb := Trim(Copy(s, 1, Pos(' ', s)));
    Delete(s, 1, Pos(' ', s));
    h := StrToInt(sa);
    if e = h then begin
      Result := sb;
      desc := s;
      Exit;
    end;
  end;
  Result := 'UNCNOWN_ERROR';
  desc := 'Неопознанная ошибка';
end;

function TArchBaseCopy.GenClearPeriod(i : integer):Integer;
Begin
    case i of
         0,1,2,3,4,5,6,7,8,9,10,11: Result := 1+i;
         12:                        Result := 6+12;
         13:                        Result := 2*12;
         14:                        Result := 3*12;
         15:                        Result := 10*12;
         else
             Result := 1;
    End;
    //Result := m_pGenTable.m_sStoreClrTime + 1;
End;


procedure TArchBaseCopy.CompressFile(SourceFileName,DestFileName:string);
{var
  SourceFileStream:TFileStream;
  DestFileStream:TFileStream;
  CompressStream:TCompressionStream;
  bytecount : Integer;  }
begin
{  //Архивируем измененный файл
  //поток исходного файла
  SourceFileStream:=TFileStream.Create(SourceFileName,fmOpenRead);
  //поток файла архива
  DestFileStream:=TFileStream.Create(DestFileName,fmCreate);
  //размер исходного файла
  bytecount:=SourceFileStream.Size;
  try
    //в начала архива запишем исходный размер
    DestFileStream.Write(bytecount,sizeof(bytecount));
    //Создадим архивирующий поток, в конструктор передадим тип архивации и поток файла архива
    CompressStream := TCompressionStream.Create(clDefault,DestFileStream);
    try
      //Скопируем все из исходного файла в файл архива через упаковывающифй поток
      CompressStream.CopyFrom(SourceFileStream,bytecount);
    finally
      CompressStream.Free;
    end;
  finally
    SourceFileStream.free;
    DestFileStream.Free;
  end;  }
end;


procedure TArchBaseCopy.DeCompressFile(SourceFileName,DestFileName:string);
{var
  SourceFileStream:TFileStream;
  DestFileStream:TFileStream;
  DeCompressStream:TDecompressionStream;
  bytecount : Integer; }
begin
{  //Архивируем измененный файл
  //поток исходного файла архива
  SourceFileStream:=TFileStream.Create(SourceFileName,fmOpenRead);
  //поток целевого файла
  DestFileStream:=TFileStream.Create(DestFileName,fmCreate);
  //размер исходного файла
  bytecount:=SourceFileStream.Size;
  try
    //прочитаем размер разархивируемого файла
    SourceFileStream.Read(bytecount,SizeOf(bytecount));
    //если размер больше нуля
    if bytecount > 0 then
    begin
      //Создадим разархивирующий поток от файла архива
      DeCompressStream := TDecompressionStream.Create(SourceFileStream);
      try
        //вытащим все из разархивирующего потока
        DeCompressStream.CopyFrom(DeCompressStream,bytecount);
      finally
        DeCompressStream.Free;
      end;
    end;

  finally
    SourceFileStream.free;
    DestFileStream.Free;
  end; }
end;

end.





