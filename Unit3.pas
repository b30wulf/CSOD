unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComObj,
  ActiveX, OPCtypes, OPCDA, OPCutils, StdCtrls, CheckLst, Db, DBTables,
  Grids,knsl3EventBox,utlconst, ExtCtrls,utlDB;

const
  OneSecond = 1 / (24 * 60 * 60);
  // these are for use with the Matrikon sample server
  Item0Name = 'Bucket Brigade.Real8';
  Item1Name = 'Bucket Brigade.Real4';
  RPC_C_AUTHN_LEVEL_NONE = 1;
  RPC_C_IMP_LEVEL_IMPERSONATE = 3;
  EOAC_NONE = 0;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    MyStringGrid: TStringGrid;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Edit1: TEdit;
    Button3: TButton;
    Button4: TButton;
    LabelLog: TLabel;
    ListBox1: TListBox;
    GroupBox3: TGroupBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button2: TButton;
    Button5: TButton;
    Timer1: TTimer;
    Button1: TButton;
    Button6: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    GroupBox4: TGroupBox;
    SearchGo: TButton;
    SearchIn: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    VMIDOut: TEdit;
    UserOut: TEdit;
    Label7: TLabel;
    ADDSERV: TButton;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure UpdateListTegs();
    procedure CreateArray();
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RefreshConnection();
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ReadTegs();
    procedure Timer1Timer(Sender: TObject);
    procedure SearchGoClick(Sender: TObject);
    procedure ADDSERVClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
   IsNeedConfigurateHR  : Boolean;
  public
    ServerProgID : String;
    ServerNameIP : String;
  end;

  // class to receive IDataObject data change advises
  TOPCAdviseSink = class(TInterfacedObject, IAdviseSink)
  public
    procedure OnDataChange(const formatetc: TFormatEtc;
                            const stgmed: TStgMedium); stdcall;
    procedure OnViewChange(dwAspect: Longint; lindex: Longint); stdcall;
    procedure OnRename(const mk: IMoniker); stdcall;
    procedure OnSave; stdcall;
    procedure OnClose; stdcall;
  end;

  // class to receive IConnectionPointContainer data change callbacks
  TOPCDataCallback = class(TInterfacedObject, IOPCDataCallback)
  public
    function OnDataChange(dwTransid: DWORD; hGroup: OPCHANDLE;
      hrMasterquality: HResult; hrMastererror: HResult; dwCount: DWORD;
      phClientItems: POPCHANDLEARRAY; pvValues: POleVariantArray;
      pwQualities: PWordArray; pftTimeStamps: PFileTimeArray;
      pErrors: PResultList): HResult; stdcall;
    function OnReadComplete(dwTransid: DWORD; hGroup: OPCHANDLE;
      hrMasterquality: HResult; hrMastererror: HResult; dwCount: DWORD;
      phClientItems: POPCHANDLEARRAY; pvValues: POleVariantArray;
      pwQualities: PWordArray; pftTimeStamps: PFileTimeArray;
      pErrors: PResultList): HResult; stdcall;
    function OnWriteComplete(dwTransid: DWORD; hGroup: OPCHANDLE;
      hrMastererr: HResult; dwCount: DWORD; pClienthandles: POPCHANDLEARRAY;
      pErrors: PResultList): HResult; stdcall;
    function OnCancelComplete(dwTransid: DWORD; hGroup: OPCHANDLE):
      HResult; stdcall;
  end;


var
  Form3: TForm3;
  ServerIf: IOPCServer;
  GroupIf: IOPCItemMgt;
  GroupHandle: OPCHANDLE;
  Item0Handle: OPCHANDLE;
  Item1Handle: OPCHANDLE;
  ItemType: TVarType;
  ItemValue: string;
  ItemQuality: Word;
  HR: HResult;
  AdviseSink: IAdviseSink;
  AsyncConnection: Longint;
  OPCDataCallback: IOPCDataCallback;
  StartTime: TDateTime;
  Name_Tegs_Array : array of String;
  Items_Handle_Array: array of OPCHANDLE;
  Count_in_File: Integer;

implementation


// TOPCAdviseSink methods

// OPC standard says this is the only method we need to fill in
procedure TOPCAdviseSink.OnDataChange(const formatetc: TFormatEtc;
                                      const stgmed: TStgMedium);
var
  PG: POPCGROUPHEADER;
  PI1: POPCITEMHEADER1ARRAY;
  PI2: POPCITEMHEADER2ARRAY;
  PV: POleVariant;
  I: Integer;
  PStr: PWideChar;
  NewValue: string;
  WithTime: Boolean;
  ClientHandle: OPCHANDLE;
  Quality: Word;
begin
  // the rest of this method assumes that the item header array uses
  // OPCITEMHEADER1 or OPCITEMHEADER2 records,
  // so check this first to be defensive
  if (formatetc.cfFormat <> OPCSTMFORMATDATA) and
      (formatetc.cfFormat <> OPCSTMFORMATDATATIME) then Exit;
  // does the data stream provide timestamps with each value?
  WithTime := formatetc.cfFormat = OPCSTMFORMATDATATIME;

  PG := GlobalLock(stgmed.hGlobal);
  if PG <> nil then
  begin
    // we will only use one of these two values, according to whether
    // WithTime is set:
    PI1 := Pointer(PChar(PG) + SizeOf(OPCGROUPHEADER));
    PI2 := Pointer(PI1);
    if Succeeded(PG.hrStatus) then
    begin
      for I := 0 to PG.dwItemCount - 1 do
      begin
        if WithTime then
        begin
          PV := POleVariant(PChar(PG) + PI1[I].dwValueOffset);
          ClientHandle := PI1[I].hClient;
          Quality := (PI1[I].wQuality and OPC_QUALITY_MASK);
        end
        else begin
          PV := POleVariant(PChar(PG) + PI2[I].dwValueOffset);
          ClientHandle := PI2[I].hClient;
          Quality := (PI2[I].wQuality and OPC_QUALITY_MASK);
        end;
        if Quality = OPC_QUALITY_GOOD then
        begin
          // this test assumes we're not dealing with array data
          if TVarData(PV^).VType <> VT_BSTR then
          begin
            NewValue := VarToStr(PV^);
          end
          else begin
            // for BSTR data, the BSTR image follows immediately in the data
            // stream after the variant union;  the BSTR begins with a DWORD
            // character count, which we skip over as the BSTR is also
            // NULL-terminated
            PStr := PWideChar(PChar(PV) + SizeOf(OleVariant) + 4);
            NewValue := WideString(PStr);
          end;
          if WithTime then
          begin
            Writeln('New value for item ', ClientHandle, ' advised:  ',
                    NewValue, ' (with timestamp)');
          end
          else begin
            Writeln('New value for item ', ClientHandle, ' advised:  ',
                    NewValue);
          end;
        end
        else begin
          Writeln('Advise received for item ', ClientHandle,
                  ' , but quality not good');
        end;
      end;
    end;
    GlobalUnlock(stgmed.hGlobal);
  end;
end;

procedure TOPCAdviseSink.OnViewChange(dwAspect: Longint; lindex: Longint);
begin
end;

procedure TOPCAdviseSink.OnRename(const mk: IMoniker);
begin
end;

procedure TOPCAdviseSink.OnSave;
begin
end;

procedure TOPCAdviseSink.OnClose;
begin
end;

// TOPCDataCallback methods

function TOPCDataCallback.OnDataChange(dwTransid: DWORD; hGroup: OPCHANDLE;
  hrMasterquality: HResult; hrMastererror: HResult; dwCount: DWORD;
  phClientItems: POPCHANDLEARRAY; pvValues: POleVariantArray;
  pwQualities: PWordArray; pftTimeStamps: PFileTimeArray;
  pErrors: PResultList): HResult;
var
  ClientItems: POPCHANDLEARRAY;
  Values: POleVariantArray;
  Qualities: PWORDARRAY;
  I: Integer;
  NewValue: string;
begin
  Result := S_OK;
  ClientItems := POPCHANDLEARRAY(phClientItems);
  Values := POleVariantArray(pvValues);
  Qualities := PWORDARRAY(pwQualities);
  for I := 0 to dwCount - 1 do
  begin
    if Qualities[I] = OPC_QUALITY_GOOD then
    begin
      NewValue := VarToStr(Values[I]);
      Writeln('New callback for item ', ClientItems[I], ' received, value:  ',
              NewValue);
    end
    else begin
      Writeln('Callback received for item ', ClientItems[I],
              ' , but quality not good');
    end;
  end;
end;

function TOPCDataCallback.OnReadComplete(dwTransid: DWORD; hGroup: OPCHANDLE;
  hrMasterquality: HResult; hrMastererror: HResult; dwCount: DWORD;
  phClientItems: POPCHANDLEARRAY; pvValues: POleVariantArray;
  pwQualities: PWordArray; pftTimeStamps: PFileTimeArray;
  pErrors: PResultList): HResult;
begin
  Result := OnDataChange(dwTransid, hGroup, hrMasterquality, hrMastererror,
    dwCount, phClientItems, pvValues, pwQualities, pftTimeStamps, pErrors);
end;

function TOPCDataCallback.OnWriteComplete(dwTransid: DWORD; hGroup: OPCHANDLE;
  hrMastererr: HResult; dwCount: DWORD; pClienthandles: POPCHANDLEARRAY;
  pErrors: PResultList): HResult;
begin
  // we don't use this facility
  Result := S_OK;
end;

function TOPCDataCallback.OnCancelComplete(dwTransid: DWORD;
  hGroup: OPCHANDLE): HResult;
begin
  // we don't use this facility
  Result := S_OK;
end;
{$R *.DFM}

procedure TForm3.FormCreate(Sender: TObject);
var vg    : String;
    SafeF : TextFile;
    str, test   : String;
    index : Integer;
    strSQL: String;
    nCount,i: Integer;
begin
    IsNeedConfigurateHR:=True;
//    vg := ExtractFilePath(Application.Exename);
//    vg := (vg + 'Settings\OPC_tegs.ini');
//    AssignFile(SafeF, vg);
//    if FileExists(vg) then
//    begin
//        Reset(SafeF);
//        readLn(SafeF, str); // в переменную str
//        while str <> '' do
//        begin
//             if copy(str, 0, 4) = '----' then
//             begin
//                  index := pos('----', copy(str, 4, length(str))) - 2;
//                  test :=  copy(str, 5, index);
//                  ComboBox1.Items.Add(test);
//                  readLn(SafeF, str);
//             end
//             else
//             begin
//                  readLn(SafeF, str);
//             end;
//        end;
//        CloseFile(SafeF);
//    end;


    MyStringGrid.Cells[0, 0] := 'Наименование ТЕГА';
    MyStringGrid.Cells[1, 0] := 'VMID Клиента';
    MyStringGrid.Cells[2, 0] := 'Ф.И.О. Клиента';
    MyStringGrid.Cells[3, 0] := 'Значение';

   // strSQL:='select L2T.m_SWMID, L2T.M_SCHNAME, L2T.M_OPC_NAME FROM L2TAG L2T WHERE M_OPC_ENABLED = 1 ';
   strSQL:='select M3.m_swvmid,L2T.M_SCHNAME, L2T.M_OPC_NAME FROM L2TAG L2T,sl3vmetertag M3 WHERE M_OPC_ENABLED = 1 and M3.m_swmid=L2T.m_swmid';
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin

    for i := 0 to nCount do begin
      MyStringGrid.Cells[0, i+1] := utlDB.DBase.IBQuery.FieldByName('M_OPC_NAME').AsString;
      MyStringGrid.Cells[1, i+1] := utlDB.DBase.IBQuery.FieldByName('M_SWVMID').AsString;
      MyStringGrid.Cells[2, i+1] := utlDB.DBase.IBQuery.FieldByName('M_SCHNAME').AsString;
      MyStringGrid.RowCount := i+1;
      utlDB.DBase.IBQuery.Next;
    end;
  end;
    ComboBox1.ItemIndex := 0;
    ComboBox1.Text:='Matrikon.OPC.Simulation.1';;
    ServerProgID := ComboBox1.Text;
    Edit2.Text   := 'localhost';
    ServerNameIP := Edit2.Text;
  {$IFDEF HOMEL}
    Exit; 
  {$ELSE}
   // RefreshConnection();
  {$ENDIF}
end;

procedure TForm3.RefreshConnection();
var i : integer;
    test_var: TGUID;
begin
  //   Count_in_File := 0;
  // this is for DCOM:
  // without this, callbacks from the server may get blocked, depending on
  // DCOM configuration settings
     if (IsNeedConfigurateHR=true) then
     begin 
      HR := CoInitializeSecurity(
      nil,                    // points to security descriptor
      -1,                     // count of entries in asAuthSvc
      nil,                    // array of names to register
      nil,                    // reserved for future use
      RPC_C_AUTHN_LEVEL_NONE, // the default authentication level for proxies
      RPC_C_IMP_LEVEL_IMPERSONATE,// the default impersonation level for proxies
      nil,                    // used only on Windows 2000
      EOAC_NONE,              // additional client or server-side capabilities
      nil                     // reserved for future use
      );
      IsNeedConfigurateHR := False;
    end;
  if Failed(HR) then
  begin
    //Label1.Caption := 'Failed to initialize DCOM security';
    ListBox1.Items.Add('Failed to initialize DCOM security');
   if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'Ошибка')
  end;
  try
    // we will use the custom OPC interfaces, and OPCProxy.dll will handle
    // marshaling for us automatically (if registered)
    if ServerNameIP = '' then
    begin
       ServerIf := nil;
    end
    else
    begin
      test_var := ProgIDToClassID(ServerProgID);
      ServerIf := CreateRemoteComObject(ServerNameIP,test_var) as IOPCServer;
    end;
  except
     ServerIf := nil;
  end;
  if ServerIf <> nil then
  begin
    ListBox1.Items.Add('Connected to OPC server');
  end
  else
  begin
      // Если не удалось подключиться к серверу, то загружаются теги, но данные обнуляются,
      // это блок эксепшена
      ListBox1.Items.Add('Unable to connect to OPC server');
//      MyStringGrid.ColCount := 4;
//      MyStringGrid.RowCount := 14;
     // MyStringGrid.Cells[1, 0] := 'Наименование ТЕГА';
     // MyStringGrid.Cells[2, 0] := 'Значение ТЕГА';


//      UpdateListTegs();
//      SetLength(Name_Tegs_Array, Count_in_File);
//      SetLength(Items_Handle_Array, Count_in_File);
     { MyStringGrid.RowCount := Count_in_File + 1;
      for i := 1 to Count_in_File do
      begin
          MyStringGrid.Cells[2, i] := '';
      end;}
      CreateArray();
     Exit;
  end;

  HR := ServerAddGroup(ServerIf, 'MyGroup0', True, 500, 0, GroupIf, GroupHandle);
  if Succeeded(HR) then
  begin
    ListBox1.Items.Add('Added group to server');
  end
  else begin
    ListBox1.Items.Add('Unable to add group to server');
    Exit;
  end;
//  MyStringGrid.ColCount := 3;
//  MyStringGrid.RowCount := 1;
//  MyStringGrid.Cells[1, 0] := 'Наименование ТЕГА';
//  MyStringGrid.Cells[2, 0] := 'Значение ТЕГА';


//  UpdateListTegs();
//  SetLength(Name_Tegs_Array, Count_in_File);
//  SetLength(Items_Handle_Array, Count_in_File);
//  MyStringGrid.RowCount := Count_in_File + 1;
  CreateArray();
  ReadTegs();
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
    ReadTegs();
end;

procedure TForm3.ReadTegs();
var ID, i : Integer;
    TID   : Integer;
    MySQL : string;    
begin
//  for i := 0 to Count_in_File - 1 do
  for i := 0 to MyStringGrid.RowCount - 1 do
  begin
        try
        HR := ReadOPCGroupItemValue(GroupIf, Items_Handle_Array[i], ItemValue, ItemQuality);
        if Succeeded(HR) then
        begin
            if (ItemQuality and OPC_QUALITY_MASK) = OPC_QUALITY_GOOD then
            begin
                MyStringGrid.Cells[3, i+1] := ItemValue;
                ID := StrToInt(MyStringGrid.Cells[1, i+1]);
                TID := 1;
                MySQL := 'UPDATE OR INSERT INTO L3CURRENTDATA ' +
                         '(M_SWVMID, M_SWTID, M_SFVALUE, M_STIME, M_SWCMDID, M_SBYMASKREAD, M_SBYMASKREREAD)' +
                         ' VALUES(' + IntToStr(ID) + ' ,' + IntToStr(0) +
                         ','+ItemValue+ ', ''' + DateTimeToStr(Now) + ''', 1, 0, 0) MATCHING(M_SWVMID, M_SWTID)';
                utlDB.DBase.ExecQry(MySQL);
                MySQL := 'UPDATE OR INSERT INTO L3CURRENTDATA ' +
                         '(M_SWVMID, M_SWTID, M_SFVALUE, M_STIME, M_SWCMDID, M_SBYMASKREAD, M_SBYMASKREREAD)' +
                         ' VALUES(' + IntToStr(ID) + ' ,' + IntToStr(1) +
                         ','+ItemValue+ ', ''' + DateTimeToStr(Now) + ''', 1, 0, 0) MATCHING(M_SWVMID, M_SWTID)';
                utlDB.DBase.ExecQry(MySQL)
            end
            else begin
                ListBox1.Items.Add('Item ' + IntToStr(i) + ' value was read synchronously, but quality was not good');
            end;
        end
        else begin
            ListBox1.Items.Add('Failed to read item ' + IntToStr(i) + ' value synchronously');
        end;
        except
            continue;
        end;
  end;
end;


// Процедура обновления списка тегов OPC-сервера
procedure TForm3.UpdateListTegs();
var   vg    : String;
      SafeF : TextFile;
      str   : string;
begin
//      vg := ExtractFilePath(Application.Exename);
//      vg := (vg + 'Settings\OPC_tegs.ini');
//      AssignFile(SafeF, vg);
//      if FileExists(vg) then
//        begin
                Reset(SafeF);
                readLn(SafeF, str); // в переменную str записываем информацию из файла f
                While str <> '' do
                begin
                        if str = ('----' + ServerProgID + '----') then
                        begin
                            readLn(SafeF, str);
                            while (str <> '') and (copy(str, 0, 4) <> '----') do
                            begin
                                MyStringGrid.Cells[1, Count_in_File + 1] := str;
                                MyStringGrid.Cells[0, Count_in_File + 1] := IntToStr(Count_in_File + 1);
                                Count_in_File := Count_in_File + 1;
                                readLn(SafeF, str);
                            end;
                            break;
                        end;
//                        readLn(SafeF, str);
                end;
//                CloseFile(SafeF);
//        end;
end;



procedure TForm3.CreateArray();
var i: Integer;
    s: String;
    strSQL : string;
    nCount : Integer;    
begin
  //strSQL:='select L2T.m_SWMID, L2T.M_SCHNAME, L2T.M_OPC_NAME FROM L2TAG L2T WHERE M_OPC_ENABLED = 1 ';
  //if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    SetLength(Items_Handle_Array,MyStringGrid.RowCount);
     for i := 0 to MyStringGrid.RowCount - 1 do
     begin
       //  Name_Tegs_Array[i] := MyStringGrid.Cells[1, i + 1];
    //     MyStringGrid.Cells[0, i+1] := utlDB.DBase.IBQuery.FieldByName('M_OPC_NAME').AsString;
     //    MyStringGrid.Cells[1, i+1] := utlDB.DBase.IBQuery.FieldByName('M_SWMID').AsString;
     //    MyStringGrid.Cells[2, i+1] := utlDB.DBase.IBQuery.FieldByName('M_SCHNAME').AsString;
     //    MyStringGrid.RowCount := i+1;
     //    utlDB.DBase.IBQuery.Next;

       //   s := MyStringGrid.Cells[1, i + 1];
          // now add an item to the group
//          HR := GroupAddItem(GroupIf, Name_Tegs_Array[i], 0, VT_EMPTY, Items_Handle_Array[i], ItemType);
          HR := GroupAddItem(GroupIf, MyStringGrid.Cells[0, i+1], 0, VT_EMPTY, Items_Handle_Array[i], ItemType);

          if Succeeded(HR) then
          begin
                ListBox1.Items.Add('Added item ' + IntToStr(i) + ' to group');
          end
          else begin
                ListBox1.Items.Add('Unable to add item ' + IntToStr(i) + 'to group');
          end;
       
     end;
//  end;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
//     Count_in_File := Count_in_File + 1;
//     SetLength(Name_Tegs_Array, Count_in_File);
//     SetLength(Items_Handle_Array, Count_in_File);
       SetLength(Items_Handle_Array, MyStringGrid.RowCount-1);

//     MyStringGrid.Cells[1, Count_in_File] := edit1.Text;
//     MyStringGrid.Cells[0, Count_in_File] := IntToStr(Count_in_File);
//     Name_Tegs_Array[Count_in_File - 1] := edit1.Text;

     HR := GroupAddItem(GroupIf, Name_Tegs_Array[Count_in_File - 1], 0, VT_EMPTY, Items_Handle_Array[Count_in_File - 1],
     ItemType);
     if Succeeded(HR) then
     begin
        ListBox1.Items.Add('Added item ' + IntToStr(Count_in_File) + ' to group');
     end
     else begin
        ListBox1.Items.Add('Unable to add item ' + IntToStr(Count_in_File - 1) + 'to group');
     end;
     MyStringGrid.Cells[2, Count_in_File] := '';
     MyStringGrid.RowCount := Count_in_File + 1;


end;

procedure TForm3.Button4Click(Sender: TObject);
var line, i : Integer;
begin
    line := MyStringGrid.Selection.Top;
    for i := line to Count_in_File  - 1 do
    begin
        MyStringGrid.Cells[2, i] := MyStringGrid.Cells[2, i + 1];
        MyStringGrid.Cells[1, i] := MyStringGrid.Cells[1, i + 1];
        Name_Tegs_Array[i - 1] := Name_Tegs_Array[i];
        Items_Handle_Array[i - 1] := Items_Handle_Array[i];
    end;
    Count_in_File := Count_in_File - 1;
    MyStringGrid.RowCount := Count_in_File + 1;
    SetLength(Name_Tegs_Array, Count_in_File);
    SetLength(Items_Handle_Array, Count_in_File);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
    ServerProgID := ComboBox1.Text;
    ServerNameIP := Edit2.Text;
    RefreshConnection();
    Timer1.Interval:=10000;
    Timer1.Enabled:=True;
end;

procedure TForm3.Button5Click(Sender: TObject);
var   vg    : String;
      sl    : TStringList;
      i     : integer;
      k     : integer;
   offset   : integer;
begin
     Timer1.Enabled:=False;//останавливаем таймер чтения тегов
      sl:=TStringList.Create;
      try
          vg := ExtractFilePath(Application.Exename);
          vg := (vg + 'Settings\OPC_tegs.ini');
          sl.LoadFromFile(vg);
          //удаление строк без 'abc'
    i:=0;
    while i<sl.Count do
      begin
        if sl[i] = ('----' + ComboBox1.Text + '----') then
        begin
            offset := i + 1;
            while true do
            begin
                if (offset = sl.Count) or (pos('----', sl[offset]) > 0) or (sl[offset] = '') then
                begin
                     for k := 0 to MyStringGrid.RowCount - 1 do
                     begin
                         sl.Delete(i);
                     end;
                     i := sl.Count;
                     break;
                end;
                sl.Delete(offset);
                //inc(offset);
            end;
        end
        else
            begin
                 inc(i);
            end;
      end;
      sl.SaveToFile(vg);
      finally
          sl.Free;
      end;
end;

procedure TForm3.Button6Click(Sender: TObject);
var   vg    : String;
      sl    : TStringList;
      i     : integer;
      k     : integer;
   offset   : integer;
begin
      sl:=TStringList.Create;
      try
          vg := ExtractFilePath(Application.Exename);
          vg := (vg + 'Settings\OPC_tegs.ini');
          sl.LoadFromFile(vg);
          //удаление строк без 'abc'
    i:=0;
    while i<sl.Count do
      begin
        if sl[i] = ('----' + ComboBox1.Text + '----') then
        begin
            offset := i + 1;
            while true do
            begin
                if (offset = sl.Count) or (pos('----', sl[offset]) > 0) or (sl[offset] = '') then
                begin
                     for k := 1 to MyStringGrid.RowCount - 1 do
                     begin
                         sl.Insert(i + 1, MyStringGrid.Cells[1, MyStringGrid.RowCount - k]);
                     end;
                     i := sl.Count;
                     break;
                end;
                sl.Delete(offset);
                //inc(offset);
            end;
        end
        else
            begin
                 inc(i);
                 if i = sl.Count then
                 begin
                     sl.Insert(i, '----' + ComboBox1.Text + '----');
                     for k := 1 to MyStringGrid.RowCount - 1 do
                     begin
                         sl.Insert(i + 1, MyStringGrid.Cells[1, MyStringGrid.RowCount - k]);
                     end;
                     i := sl.Count;
                 end;
            end;
      end;
      sl.SaveToFile(vg);
      finally
          sl.Free;
      end;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  ReadTegs();
end;

procedure TForm3.SearchGoClick(Sender: TObject);
var i   : Integer;
    s   : String;
    strSQL : string;
    nCount : Integer;
begin
    strSQL:='SELECT L2.M_SWMID, L2.M_SCHNAME FROM L2TAG L2 WHERE L2.M_SDDFABNUM = ''' + Trim(SearchIn.Text) + '''';
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin

//    for i := 0 to nCount-1 do begin
      VMIDOut.text := utlDB.DBase.IBQuery.FieldByName('M_SWMID').AsString;
      UserOut.text := utlDB.DBase.IBQuery.FieldByName('M_SCHNAME').AsString;

    //MyStringGrid.RowCount := i+1;
    //utlDB.DBase.IBQuery.Next;
//    end;
  end;
end;

procedure TForm3.ADDSERVClick(Sender: TObject);
begin
  ComboBox1.Clear;
  ComboBox1.ItemIndex := 0;
  ComboBox1.Text:=Edit3.Text;
  ServerProgID := ComboBox1.Text;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Timer1.Enabled:=False;

end;

end.





