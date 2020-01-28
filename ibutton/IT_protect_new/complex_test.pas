Unit complex_test;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  u_Crypt, inifiles, ComCtrls, StdCtrls, Spin, Buttons, ExtCtrls,
  Grids, {RxGIF,} ImgList, uTMEXbutton, u_iButTMEX;

Type
  TFrmMain = Class(TForm)
    Panel2 : TPanel;
    GroupBox1 : TGroupBox;
    EdOldPass : TEdit;
    EdOldPassOfs : TSpinEdit;
    GroupBox2 : TGroupBox;
    EdPass : TEdit;
    EdPassOfs : TSpinEdit;
    BtnSetPass : TButton;
    EdPass2 : TEdit;
    Panel3 : TPanel;
    GroupBox3 : TGroupBox;
    BtnSaveKey : TButton;
    GroupBox4 : TGroupBox;
    SpeedButton1 : TSpeedButton;
    SpeedButton2 : TSpeedButton;
    SpeedButton3 : TSpeedButton;
    GrUsers : TStringGrid;
    Notebook1 : TNotebook;
    BtnTestU : TSpeedButton;
    Label1 : TLabel;
    EdLicDate : TDateTimePicker;
    EdTestUPass : TEdit;
    EdComment : TEdit;
    RadioButton1 : TRadioButton;
    RadioButton2 : TRadioButton;
    Label2 : TLabel;
    Image1 : TImage;
    Label3 : TLabel;
    EdLicPer : TSpinEdit;
    Bevel1 : TBevel;
    RadioButton3 : TRadioButton;
    Timer1 : TTimer;
    ImageList1 : TImageList;
    BtnLoad : TSpeedButton;
    BtnNew : TButton;
    BtnStore : TButton;
    BtnCopy : TButton;
    ch1 : TRadioButton;
    ch2 : TRadioButton;
    ibList1 : TibList;
    PageControl1 : TPageControl;
    TabSheet1 : TTabSheet;
    TabSheet2 : TTabSheet;
    EdPort : TSpinEdit;
    Procedure FormCreate(Sender : TObject);
    Procedure BtnLoadClick(Sender : TObject);
    Procedure BtnStoreClick(Sender : TObject);
    Procedure BtnSetPassClick(Sender : TObject);
    Procedure BtnSaveKeyClick(Sender : TObject);
    Procedure BtnNewClick(Sender : TObject);
    Procedure GrUsersDrawCell(Sender : TObject; ACol, ARow : Integer;
      Rect : TRect; State : TGridDrawState);
    Procedure GrUsersGetEditText(Sender : TObject; ACol, ARow : Integer;
      Var Value : String);
    Procedure GrUsersSetEditText(Sender : TObject; ACol, ARow : Integer;
      Const Value : String);
    Procedure BtnCopyClick(Sender : TObject);
    Procedure GrUsersMouseUp(Sender : TObject; Button : TMouseButton;
      Shift : TShiftState; X, Y : Integer);
    Procedure BtnTestUClick(Sender : TObject);
    Procedure RadioButton2Click(Sender : TObject);
    Procedure Image1DblClick(Sender : TObject);
    Procedure Timer1Timer(Sender : TObject);
    Procedure GrUsersKeyUp(Sender : TObject; Var Key : Word;
      Shift : TShiftState);
    Procedure EdPortChange(Sender : TObject);
    Procedure FormDestroy(Sender : TObject);
    Procedure PageControl1Change(Sender : TObject);
  private
    { Private declarations }
    ini : TiniFile;
    uem : Array[0..7] Of byte;
    memBlock : TiButtonMemBlock;
//    ghp:GOSHASHPARAM;
    Procedure EditorToButton(channel : integer);
    Procedure ButtonToEditor(channel : integer);
  public
    { Public declarations }
    Function TestPass(channel : integer; ps : String) : boolean;
    Function StoreMemBlock(channel : integer) : boolean;
    Function LoadMemBlock(channel : integer) : boolean;

  End;

Var
  FrmMain           : TFrmMain;

Implementation

Uses uEdUser, uCopyIB;

{$R *.DFM}


Procedure TFrmMain.FormCreate(Sender : TObject);
Var
  aHash             : THASH;
  i                 : integer;
  s                 : String;
Begin
  ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  ibList1.Port := ini.ReadInteger('Program', 'Port', 1);
  ibList1.porttype := ini.ReadInteger('Program', 'PortType', 1);
//     ibList1.ScanDevices(true);
  EdPort.Value := ibList1.Port;
  s := ini.ReadString('Program', 'Key', '');
  HexStr2Array(s, aHash);
  EdLicDate.MaxDate := trunc(Now) * 1.0;
  With GrUsers Do Begin
    ColWidths[0] := 30;
    ColWidths[3] := 50;
    ColWidths[2] := 80;
    ColWidths[1] := ClientWidth - 160;
    Cells[0, 0] := '№';
    Cells[1, 0] := 'Пользователь';
    Cells[2, 0] := 'Пароль';
    Cells[3, 0] := 'Уровень';
    For i := 1 To RowCount - 1 Do Cells[0, i] := IntToStr(i);
  End;
{
     if not iBtn.TestIDHash(aHash) then begin
        MessageDlg('Ошибка. Неверный ключ.', mtWarning, [mbOK], 0);
     Application.Terminate;
     end;
{}
     //iBtn.LoadMemBlock;
  BtnLoadClick(Self);
  Notebook1.PageIndex := ord(UpperCase(ParamStr(1)) = '/A2000');
End;

Procedure TFrmMain.BtnLoadClick(Sender : TObject);
Var
  ch                : integer;
Begin
  ch := ord(ch2.checked);
  ButtonToEditor(ch);
End;

Procedure TFrmMain.BtnStoreClick(Sender : TObject);
Var
  ch                : integer;
Begin
  ch := ord(ch2.checked);
  If TestPass(ch, EdOldPass.Text) And Not (TestPass(ch, EdOldPass.Text + '1')) Then Begin
    EditorToButton(ch);
  End Else ShowMessage('Неверный пароль');
  ButtonToEditor(ch);
End;

Procedure TFrmMain.BtnSetPassClick(Sender : TObject);
Var
  i, c              : integer;
   // ghp:GOSHASHPARAM;
  ch                : integer;
Begin
  ch := ord(ch2.checked);
  If EdOldPass.Text = '' Then Begin
    MessageDlg('Не введен старый пароль', mtWarning, [mbOK], 0);
    Exit;
  End;
  If (EdPass.Text <> EdPass2.Text) Or (EdPass.Text = '') Or (EdPass2.Text = '') Then Begin
    MessageDlg('Не совпадают значения паролей 1 и 2' + #13 + #10 + 'Внимательнее вводите новые значения', mtWarning, [mbOK], 0);
    Exit;
  End;
  If TestPass(ch, EdOldPass.Text) And Not (TestPass(ch, EdOldPass.Text + '1')) Then Begin
    InitHash(@ghp);
    PrepareGHBlock(@ghp);
    GOSHash(@EdPass.Text[1], Length(EdPass2.Text), @ghp);
    GOSHashComplete(@ghp);
    c := sizeOf(THash);
    i := EdPassOfs.value Mod c;
    WriteCKLBuff(@ghp.bHash, @memBlock.pswSpace[0], c, i);
             //move(ghp.bHash,iBtn.memBlock.pswSpace[i],sizeOf(THash));
    StoreMemBlock(ch);
  End Else Begin
    ShowMessage('Неверный пароль');
  End;
End;

Function TFrmMain.TestPass(channel : integer; ps : String) : boolean;
Var
  H                 : THash;
  i, c              : integer;
Begin
  LoadMemBlock(channel);
  c := SizeOf(THash);
  i := EdOldPassOfs.value Mod c;
  ReadCKLBuff(@(memBlock.pswSpace[0]), @H, c, i);
  result := CheckHash(@ps[1], Length(ps), @H);
     //if chMasterMode.checked then result:=true;
End;

Procedure TFrmMain.BtnSaveKeyClick(Sender : TObject);
Var
  TempKey           : TKey;
  ch                : integer;
Begin
  ch := ord(ch2.checked);
  If TestPass(ch, EdOldPass.Text) And Not (TestPass(ch, EdOldPass.Text + '1')) Then
    If MessageDlg('Внимание ! Изменение ключа шифрования ' + #13 + #10 + 'для работающей программы может привести ' + #13 + #10 + 'к потере данных. Изменить ключ шифрования?', mtWarning, [mbYes, mbNo], 0) = mrYes Then Begin
      LoadMemBlock(ch);
      GOSGenKey(@TempKey);
      Move(tempKey, MemBlock.bKey, sizeOf(TKey));
    End Else Begin
      ShowMessage('Неверный пароль');
    End;
End;

Procedure TFrmMain.BtnNewClick(Sender : TObject);
Var
  i, c              : integer;
  TempKey           : TKey;
  p                 : pointer;
  ch                : integer;
Begin
  ch := ord(ch2.checked);
  If MessageDlg('Внимание ! При создании нового носителя' + #13 + #10 + 'ключевой информации все старые данные' + #13 + #10 + 'на носителе будут уничтожены. Продолжить?', mtWarning, [mbYes, mbNo], 0) = mrYes Then Begin
    GOSGenKey(@TempKey);
    WriteCKLBuff(@TempKey, @MemBlock.bKey, SizeOf(TKey), ibList1.devices[0].ID[1]);
           //Move(tempKey,iBtn.MemBlock.bKey,sizeOf(TKey));
           // def pass
    EdOldPass.Text := '0000';
    EdOldPassOfs.value := 0;
    p := @(EdOldPass.Text[1]);
    InitHash(@ghp);
    PrepareGHBlock(@ghp);
    GOSHash(p, 4, @ghp);
    GOSHashComplete(@ghp);
    c := sizeOf(THash);
    i := EdOldPassOfs.value Mod c;
    WriteCKLBuff(@(ghp.bHash[0]), @memBlock.pswSpace[0], c, i);
           //
    For i := 0 To USERCOUNT - 1 Do Begin
      MemBlock.users[i].F := 0;
    End;
    EditorToButton(ch);
  End;
  ButtonToEditor(ch);
End;

Procedure TFrmMain.ButtonToEditor(channel : integer);
Var
  i, j              : integer;
  res               : boolean;
  s                 : String;
//    ims:TMemoryStream;
//    ibm:TBitmap;
Begin
  res := LoadMemBlock(channel);
  For i := 0 To Panel3.ControlCount - 1 Do
    If Not (Panel3.Controls[i] Is TSpeedButton) And
      Not (Panel3.Controls[i] Is TRadioButton) And
      Not (Panel3.Controls[i] Is TSpinEdit) Then Begin
      If (Panel3.Controls[i] Is TWinControl) Then
        For j := 0 To TWinControl(Panel3.Controls[i]).controlCount - 1 Do TWinControl(Panel3.Controls[i]).controls[j].enabled := res;
      Panel3.Controls[i].enabled := res;
    End;
  GrUsers.Enabled := res;
{
     i:=ord(iBtn.LoadMemBlock);
     ibm := TBitmap.Create;
     ImageList1.GetBitmap(i,ibm);
     ims := TMemoryStream.Create;
     ibm.SaveToStream(ims);
     Image2.Picture.LoadFromStream(ims);
     BtnLoad.Glyph.LoadFromStream(ims);
     ibm.free;
     ims.free;
}
//     EdProgName.text:= string(@iBtn.memBlock.ProgName[0]);
//     EdVersion.text:= string(@iBtn.memBlock.ProgVer[0]);
//     EdProgOwner.text:= string(@iBtn.memBlock.ProgOwnerName[0]);
  Try
    EdLicDate.DateTime := Date;
    If MemBlock.LicenseStart > 0 Then
      EdLicDate.DateTime := MemBlock.LicenseStart Else
  Except
  End;
  EdComment.text := String(@MemBlock.Comment[0]);
  Case Hi(MemBlock.LicenseType) Of
    1 : Begin
        RadioButton1.Checked := true;
      End;
    2 : Begin
        RadioButton2.Checked := true;
        EdLicPer.Value := lo(MemBlock.LicenseType);
      End;
    3 : Begin
        RadioButton3.Checked := true;
      End;
  End;
  EdLicDate.tag := Hi(MemBlock.LicenseType);
  EdLicPer.Enabled := RadioButton2.Checked;
  For i := 0 To USERCOUNT - 1 Do Begin
    GrUsers.Cells[0, i + 1] := IntToStr(i);
    GrUsers.Cells[2, i + 1] := '';
    If MemBlock.users[i].F > 0 Then Begin
//           GrUsers.Cells[1,i+1]:='пароль установлен';
      uem[i] := 1;
      s := '';
      j := 0;
      While (MemBlock.users[i].N[j] <> 0) And (j < sizeOf(TiUserName)) Do Begin
        s := s + char(MemBlock.users[i].N[j]);
        inc(j);
      End;
      GrUsers.Cells[1, i + 1] := s;
      GrUsers.Cells[3, i + 1] := IntToStr(MemBlock.users[i].F Xor MemBlock.users[i].L)
    End Else Begin
      uem[i] := 0;
      GrUsers.Cells[1, i + 1] := '';
      GrUsers.Cells[3, i + 1] := '';
    End;
  End;
End;

Procedure TFrmMain.EditorToButton(channel : integer);
Var
  i, j              : integer;
  s                 : String;
Begin
//    for i:= 1 to Length(EdProgName.text) do iBtn.memBlock.ProgName[i-1]:=ord(EdProgName.text[i]);
//    iBtn.memBlock.ProgName[Length(EdProgName.text)]:=0;

//    for i:= 1 to Length(EdVersion.text) do iBtn.memBlock.ProgVer[i-1]:=ord(EdVersion.text[i]);
//    iBtn.memBlock.ProgVer[Length(EdVersion.text)]:=0;

//    for i:= 1 to Length(EdProgOwner.text) do iBtn.memBlock.ProgOwnerName[i-1]:=ord(EdProgOwner.text[i]);
//    iBtn.memBlock.ProgOwnerName[Length(EdProgOwner.text)]:=0;

  MemBlock.LicenseStart := EdLicDate.DateTime;
  move(EdComment.text[1], MemBlock.Comment[0], length(EdComment.text));
  MemBlock.Comment[length(EdComment.text)] := 0;

  MemBlock.LicenseType := (EdLicDate.tag * $100) + byte(EdLicPer.Value);

    // tabl podst
  WriteCKLBuff(@bBlkSrc, @MemBlock.Tabl, sizeOf(TbBlk), ibList1.Devices[0].ID[2]);

  For i := 0 To USERCOUNT - 1 Do Begin
    If (uem[i] = 2) And (GrUsers.Cells[3, i + 1] <> '') Then Begin
            // haSH
      s := GrUsers.Cells[2, i + 1];
      If s <> '' Then Begin
        InitHash(@ghp);
        PrepareGHBlock(@ghp);
        GOSHash(@s[1], length(s), @ghp);
        GOSHashComplete(@ghp);
        WriteCKLBuff(@ghp.bHash[0], @MemBlock.users[i].H[0], sizeOf(THash), i);
      End;
      s := GrUsers.Cells[1, i + 1];
      Move(s[1], MemBlock.users[i].N[0], sizeOf(TiUserName));
      If length(s) < sizeOf(TiUserName) Then MemBlock.users[i].N[length(s)] := 0;
            // Level - write when edited
      j := StrToInt(GrUsers.Cells[3, i + 1]);
      MemBlock.users[i].F := trunc(Random(250)) + 1;
      MemBlock.users[i].L := MemBlock.users[i].F Xor byte(j);
    End Else If uem[i] = 0 Then MemBlock.users[i].F := 0;
  End;
  StoreMemBlock(channel);
End;

Procedure TFrmMain.GrUsersDrawCell(Sender : TObject; ACol, ARow : Integer; Rect : TRect; State : TGridDrawState);
Var
  s                 : String;
Begin
  With GrUsers.Canvas Do Begin
    font.Color := clNavy;
    If (aRow = 0) Then Begin
      Brush.Color := clSilver;
      s := GrUsers.Cells[aCol, aRow];
    End Else If aCol = 0 Then Begin
      Brush.Color := clSilver;
      Case uem[aRow - 1] Of
        0 : s := GrUsers.Cells[aCol, aRow] + ' ';
        1 : s := GrUsers.Cells[aCol, aRow] + '>';
        2 : s := GrUsers.Cells[aCol, aRow] + '*';
      Else s := GrUsers.Cells[aCol, aRow];
      End;
    End Else Begin

      If aRow In [GrUsers.Selection.Top..GrUsers.Selection.Bottom] Then Begin
        GrUsers.tag := aRow - 1;
        Brush.Color := clBlack;
        pen.Color := clWhite;
        font.Color := clWhite;
      End Else Begin
        Brush.Color := clWhite;
        font.Color := clNavy;
        pen.Color := clBlue;
      End;
      s := GrUsers.Cells[aCol, aRow];
      Case aCol Of
        1 : If uem[aRow - 1] = 0 Then s := '';
        2 : If uem[aRow - 1] = 0 Then s := ''
          Else s := '************';
        3 : If uem[aRow - 1] = 0 Then s := '-'
          Else If s = '1' Then s := 'П'
          Else If s = '3' Then s := 'OП'
          Else If s = '7' Then s := 'А'
          Else s := 'O'
      End;
    End;
    If Not GrUsers.Enabled Then s := '- - -';
    TextRect(Rect, Rect.Left + 3, Rect.Top + 3, s);
  End;
End;

Procedure TFrmMain.GrUsersGetEditText(Sender : TObject; ACol, ARow : Integer; Var Value : String);
Begin
  If aCol = 2 Then Begin
    Value := '************';
  End;
End;

Procedure TFrmMain.GrUsersSetEditText(Sender : TObject; ACol, ARow : Integer;
  Const Value : String);
Begin
  If Value = '' Then uem[aRow - 1] := 0
  Else uem[aRow - 1] := 2;
End;

Procedure TFrmMain.BtnCopyClick(Sender : TObject);
Var
  i, c              : integer;
  TempKey           : TKey;
  p                 : pointer;
  ch_f, ch_t        : integer;
  s                 : String;
Begin
  FrmCopyIB := TFrmCopyIB.create(self);
  With FrmCopyIB Do Begin
    i := -1;
    While i < 0 Do Begin
      ibList1.ScanDevices(true);
      If ibList1.Count > 0 Then Begin

        src1.Caption := ibList1.DeviceName(0);
        src2.Caption := ibList1.DeviceName(1);
        dest1.Caption := ibList1.DeviceName(0);
        dest2.Caption := ibList1.DeviceName(1);
        src2.Enabled := (ibList1.Count > 1);
        dest2.Enabled := (ibList1.Count > 1);

        i := FrmCopyIB.ShowModal;

        ch_f := ord(src2.checked);
        ch_t := ord(dest2.checked);
      End Else Begin
        ShowMessage('Нет iButton в считывателе');
        exit;
      End;
    End;
  End;

  FrmCopyIB.Release;

  If (i = mrOK) Then
    If TestPass(ch_f, EdOldPass.Text) And Not (TestPass(ch_f, EdOldPass.Text + '1')) Then Begin
      If MessageDlg('Внимание ! При создании нового носителя' + #13 + #10 +
        'ключевой информации все старые данные' + #13 + #10 +
        'на носителе будут уничтожены. Продолжить?',
        mtWarning, [mbYes, mbNo], 0) = mrYes Then Begin

        ButtonToEditor(ch_f);
            // def pass
        EdOldPass.Text := '0000';
        EdOldPassOfs.value := 0;
        p := @(EdOldPass.Text[1]);
        InitHash(@ghp);
        PrepareGHBlock(@ghp);
        GOSHash(p, 4, @ghp);
        GOSHashComplete(@ghp);
        c := sizeOf(THash);
        i := EdOldPassOfs.value Mod c;
        WriteCKLBuff(@(ghp.bHash[0]), @memBlock.pswSpace[0], c, i);
           //
        For i := 0 To USERCOUNT - 1 Do Begin
          MemBlock.users[i].F := 0;
        End;
        ReadCKLBuff(@memBlock.bKey, @TempKey, sizeOf(TKey), ibList1.devices[0].ID[1]);
        If (ch_f = ch_t) Then
          If MessageDlg('Вставьте новый носитель ключа', mtWarning, [mbOK, mbCancel], 0) = mrOK Then Begin
            WriteCKLBuff(@TempKey, @memBlock.bKey, sizeOf(TKey), ibList1.devices[0].ID[1]);
          End;
        EditorToButton(ch_t);
      End;
    End Else ShowMessage('Неверный пароль');
  If ch_t = 0 Then ch1.Checked := true Else ch2.Checked := true;
  ButtonToEditor(ch_t);
End;

Procedure TFrmMain.GrUsersMouseUp(Sender : TObject; Button : TMouseButton;
  Shift : TShiftState; X, Y : Integer);
Var
  R, C              : integer;
  p                 : TPoint;
Begin
  If ssShift In Shift Then Begin
    GrUsers.MouseToCell(x, y, c, r);
    If (r > 0) Then Begin
      FrmUsEd := TFrmUsEd.create(Nil);
      p.y := GrUsers.CellRect(0, r).top + top;
      p.x := Left;
      FrmMain.ClientToScreen(p);
      FrmUsEd.top := p.y;
      FrmUsEd.left := p.x;
      With FrmUsEd Do Begin
        If uem[r - 1] > 0 Then EdUName.Text := GrUsers.Cells[1, r]
        Else EdUName.Text := '';
        Tag := MemBlock.users[r - 1].L Xor MemBlock.users[r - 1].F;
      End;
      FrmUsEd.ShowModal;
      If FrmUsEd.Edited Then Begin
        uem[r - 1] := 2;
          //iBtn.MemBlock.users[r-1].F:=random(250)+1;
        GrUsers.Cells[1, r] := FrmUsEd.EdUName.Text;
        If FrmUsEd.CheckBox1.Checked Then GrUsers.Cells[2, r] := FrmUsEd.EdUPass.Text;
          //iBtn.MemBlock.users[r-1].L:= FrmUsEd.Tag XOR iBtn.MemBlock.users[r-1].F;
        GrUsers.Cells[3, r] := IntToStr(FrmUsEd.Tag);
        GrUsers.Refresh;
      End;
      FrmUsEd.Release;
    End;
  End;
End;

Procedure TFrmMain.BtnTestUClick(Sender : TObject);
Var
  h                 : THash;
Begin
  ReadCKLBuff(@MemBlock.users[GrUsers.tag].h[0], @h[0], sizeOf(THash), GrUsers.tag);
  If CheckHash(@EdTestUPass.text[1], Length(EdTestUPass.text), @h[0]) Then Begin
    ShowMessage('Уровень доступа ' + IntToStr(MemBlock.users[GrUsers.tag].L Xor MemBlock.users[GrUsers.tag].F));
  End Else
    ShowMessage('Пароль введен неверно');
End;

Procedure TFrmMain.RadioButton2Click(Sender : TObject);
Begin
  EdLicPer.Enabled := RadioButton2.Checked;
  EdLicDate.tag := (sender As TComponent).tag;
End;

Procedure TFrmMain.Image1DblClick(Sender : TObject);
Begin
  If image1.Tag <> 0 Then Begin
    Timer1.Enabled := false;
    Image1.Left := Image1.Tag;
    image1.Tag := 0;
  End Else Begin
    Image1.Tag := Image1.Left;
    Timer1.tag := 1;
    Timer1.Enabled := true;
  End;
End;

Procedure TFrmMain.Timer1Timer(Sender : TObject);
Begin
  If Image1.Left > 200 Then Timer1.tag := -1
  Else If Image1.Left < 10 Then Timer1.tag := 1;
  Image1.Left := Image1.Left + Timer1.tag;
End;

Procedure TFrmMain.GrUsersKeyUp(Sender : TObject; Var Key : Word;
  Shift : TShiftState);
Begin
  If ssShift In Shift Then Begin
    Case key Of
      VK_DELETE : If MessageDlg('Удалить пользователя', mtWarning, [mbYes, mbNo], 0) = mrYes Then Begin
          uem[GrUsers.tag] := 0;
        End;
    End;
  End;
  If key = VK_F2 Then BtnLoadClick(Self);
End;

Function TFrmMain.LoadMemBlock(channel : integer) : boolean;
Var
  p                 : Array[0..1024] Of byte;
  i                 : integer;
Begin
  i := ibList1.DeviceGetData(channel, 0, sizeOf(TiButtonMemBlock), p);
  move(p, Memblock, i);
  result := (i = sizeOf(TiButtonMemBlock));
End;

Function TFrmMain.StoreMemBlock(channel : integer) : boolean;
Begin
  result := (ibList1.DeviceSetData(channel, 0, sizeOf(TiButtonMemBlock), pbytearray(@MemBlock)^) = sizeOf(TiButtonMemBlock));
End;

Procedure TFrmMain.EdPortChange(Sender : TObject);
Begin
  ibList1.Port := EdPort.Value;
End;

Procedure TFrmMain.FormDestroy(Sender : TObject);
Begin
  ini.WriteInteger('Program', 'Port', ibList1.Port);
End;

Procedure TFrmMain.PageControl1Change(Sender : TObject);
Begin
  ibList1.porttype := PageControl1.ActivePageIndex * 5 + 1;
End;

End.

