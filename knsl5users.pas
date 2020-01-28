unit knsl5users;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, StdCtrls, ComCtrls, ToolWin, jpeg, ExtCtrls, RbDrawCore,
  RbButton,utldatabase,utlconst,utlbox,utltypes,knsl4secman, Grids,
  BaseGrid, AdvGrid,knsl5config, Spin, ExtDlgs, AdvPanel, AdvToolBar,
  AdvSplitter, AdvAppStyler, AdvToolBarStylers, paramchklist, CheckLst;

type
  TTUsers = class(TForm)
    ImageList1: TImageList;
    OpenPictureDialog1: TOpenPictureDialog;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    Label5: TLabel;
    Label21: TLabel;
    sem_nChannel: TSpinEdit;
    lbGenSettings: TLabel;
    Label1: TLabel;
    AdvPanel3: TAdvPanel;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    edm_swUID: TEdit;
    cbm_swSLID: TComboBox;
    edm_sdtRegDate: TEdit;
    edm_strShName: TEdit;
    edm_strPassword: TEdit;
    edm_strFam: TEdit;
    edm_strImya: TEdit;
    edm_strOtch: TEdit;
    edm_strDolgn: TEdit;
    edm_strHomeAddr: TEdit;
    edm_strTel: TEdit;
    edm_strEMail: TEdit;
    OnLoadPhoto: TRbButton;
    edm_swAmUser: TEdit;
    Photo: TPanel;
    img_photo: TImage;
    AdvPanel4: TAdvPanel;
    GroupBox4: TGroupBox;
    chbm_sbyPrmPE: TCheckBox;
    chbm_sbyPrmQE: TCheckBox;
    chbm_sbyPrmCE: TCheckBox;
    chbm_sbyPrmGE: TCheckBox;
    chbm_sbyPrmTE: TCheckBox;
    chbm_sbyPrmCNE: TCheckBox;
    chbm_sbyPrmPRE: TCheckBox;
    chbm_sbyEnable: TCheckBox;
    chbm_sbyPrmDE: TCheckBox;
    GroupBox3: TGroupBox;
    Label18: TLabel;
    Label15: TLabel;
    Edit2: TEdit;
    Edit1: TEdit;
    AdvPanel5: TAdvPanel;
    AdvSplitter1: TAdvSplitter;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarButton1: TAdvToolBarButton;
    AdvToolBarButton2: TAdvToolBarButton;
    AdvToolBarButton3: TAdvToolBarButton;
    AdvToolBarButton4: TAdvToolBarButton;
    AdvToolBarButton5: TAdvToolBarButton;
    AdvToolBarButton6: TAdvToolBarButton;
    AdvToolBarButton7: TAdvToolBarButton;
    AdvToolBar2: TAdvToolBar;
    AdvToolBarButton8: TAdvToolBarButton;
    AdvToolBarButton9: TAdvToolBarButton;
    AdvToolBarButton10: TAdvToolBarButton;
    AdvToolBarButton11: TAdvToolBarButton;
    AdvToolBarButton14: TAdvToolBarButton;
    AdvPanel6: TAdvPanel;
    GroupBox2: TGroupBox;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    UserStyler: TAdvFormStyler;
    AdvPanelStyler1: TAdvPanelStyler;
    cbPassw: TCheckBox;
    GroupBox5: TGroupBox;
    FsgGrid: TAdvStringGrid;
    AbonsCheckList: TParamCheckList;
    chbm_sbyQryGrp: TCheckBox;
    AdvPanelPermission: TAdvPanel;
    AdvPanelPermREGIN: TAdvPanel;
    AdvSplitter2: TAdvSplitter;
    AdvPanelPermRAYON: TAdvPanel;
    clbREGIN: TCheckListBox;
    chbm_sbyAccReg: TCheckBox;
    clbRAYON: TCheckListBox;
    procedure OnSaveUserSett(Sender: TObject);
    procedure OnCreateForm(Sender: TObject);
    procedure OnGetUserInfo(Sender: TObject);
    procedure OnCreateUserSettings(Sender: TObject);
    procedure OnDelUserSettings(Sender: TObject);
    procedure OnBackForward(Sender: TObject);
    procedure OnForward(Sender: TObject);
    procedure OnChandgeLevel(Sender: TObject);
    procedure OnLoadHKeyInfo(Sender: TObject);
    procedure OnGetCellColorKey(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnCopyKey(Sender: TObject);
    procedure OnSaveKey(Sender: TObject);
    procedure OnGetType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnCreateNewKey(Sender: TObject);
    procedure OnSaveToKey(Sender: TObject);
    procedure OnClearAllUser(Sender: TObject);
    procedure OnClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure OnChandgeChann(Sender: TObject);
    procedure OnLoadPhotoClick(Sender: TObject);
    procedure SetPhotoParam(pTable : SUSERTAG);
    procedure GetPhotoParam(pTable : SUSERTAG);
    procedure OnEventSave;
    procedure edm_strPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OnClichPassw(Sender: TObject);
    procedure chbm_sbyAccRegClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure clbREGINClick(Sender: TObject);
    procedure clbRAYONClickCheck(Sender: TObject);
    procedure clbREGINClickCheck(Sender: TObject);
  private
    { Private declarations }
    m_strCurrentDir : String;
    m_nCountUser    : Integer;
    m_pTable        : SUSERTAGS;
    m_pAbonTable    : SL3ABONSNAMES;
    m_nIDIndex      : Integer;
    m_nCurRow       : Integer;
    ms_photo        : string;
    EventFlag       : Integer;
    UserPerm        : TUserPermission;

    procedure SetDefaultSett;
    procedure SetUsers;
    function  GenIndex:Integer;
    function  GenIndexSv:Integer;
    function  SetIndex(nIndex : Integer):Integer;
    procedure FreeIndex(nIndex : Integer);
    procedure FreeAllIndex;
    procedure OnSaveUserSettings;
    procedure OnGetUserSettings;
    procedure SetDefaultGrid(i:Integer);
    procedure SetUserParam(Var pTable : SUSERTAG);
    procedure GetUserParam(Var pTable : SUSERTAG);
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    procedure SaveToKey(strUser,strPass:String;nLevel:Integer);
    function  FindRow(str:String):Integer;
    function  FindUser(str:String):Integer;
    procedure LoadAbonsCheckList;
    procedure SetAbonCheckedList(var AllowAbon : string);
    procedure SaveAbonCheckedList(var AllowAbon : string);
    procedure chbm_sbyAccRegShow;
    procedure SetCheckBoxes(AL : TList);
    procedure SetCBRegion(AL : TList);
    procedure SetCBDepart(AL: TList; ID : integer);
    procedure SetCheckBoxUser(UP: TUserPermission);  // устанавливает чекбоксы
    function GetCheckBoxUser(UP: TUserPermission): TUserPermission;  // читает чекбоксы
    procedure SaveUserSettings;
  public
    { Public declarations }
  end;

var
  TUsers: TTUsers;
  m_nCurrentUser : Integer;

implementation

{$R *.DFM}

procedure TTUsers.OnSaveUserSett(Sender: TObject);
begin
      if (Length(edm_strPassword.Text) < 8) and (chbm_sbyPrmPRE.Checked) then
      begin
         MessageDlg('Пароль администратора должен состоять из не менее 8 символов!',mtWarning,[mbOk],0);
         exit;
      end;
      OnSaveUserSettings;
  //    OnEventSave;
  SaveUserSettings;
end;

procedure TTUsers.OnEventSave;
var strSettingsPath : string[100];
begin
 if  EventFlag = EVH_MOD_PASSWORD then begin
//      m_pDB.FixUspdEvent(0,0,EVH_MOD_PASSWORD); //EVENT
      EventFlag := -1;
      m_nReStartEvent := 1;
      strSettingsPath := ExtractFilePath(Application.ExeName) + '\\Settings\\USPD_Config.ini';
      m_pDB.WriteReStartEvent(strSettingsPath);
  end;
end;

procedure TTUsers.OnSaveUserSettings;
Var
      pTable : SUSERTAG;
Begin
      SetUserParam(pTable);
      if m_pDB.AddUserTable(pTable)=True then
      Begin
//       m_pDB.FixUspdDescEvent(0,3,EVS_EDI_ACCT,0);
       SetIndex(pTable.m_swUID);
       SetUsers;
       m_nCurrentUser := m_pTable.Count-1;
      // SetPhotoParam(pTable);
      End else SetUsers;
      GetUserParam(m_pTable.Items[m_nCurrentUser]);
End;
procedure TTUsers.OnGetUserSettings;
var SUT : SUSERTAG;
Begin
  if m_pTable.Count<>0 then
    GetUserParam(m_pTable.Items[m_nCurrentUser])
  else
    edm_swUID.Text := '1';
  SUT := m_pTable.Items[m_nCurrentUser];  //BO
  if not Assigned(UserPerm) then
    UserPerm := TUserPermission.Create;
  UserPerm.GetUserData(SUT.m_swID);
  SetCheckBoxUser(UserPerm);
End;

procedure TTUsers.SetDefaultSett;
Begin
      if edm_swUID.Text=''       then edm_swUID.Text       := IntToStr(GenIndex+1);
      if cbm_swSLID.Text=''      then cbm_swSLID.ItemIndex := 0;
      if edm_sdtRegDate.Text=''  then edm_sdtRegDate.Text  := DateTimeToStr(Now);
      if edm_strShName.Text=''   then edm_strShName.Text   := 'User';
      if edm_strPassword.Text='' then edm_strPassword.Text := 'Password'+edm_swUID.Text;
      if edm_strFam.Text=''      then edm_strFam.Text      := 'Фамилия';
      if edm_strImya.Text=''     then edm_strImya.Text     := 'Имя';
      if edm_strOtch.Text=''     then edm_strOtch.Text     := 'Отчество';
      if edm_strDolgn.Text=''    then edm_strDolgn.Text    := 'Оператор цеха ЭВС';
      if edm_strHomeAddr.Text='' then edm_strHomeAddr.Text := 'г.Минск ул.Буденого 11';
      if edm_strTel.Text=''      then edm_strTel.Text      := '8-017-230-80-95';
      if edm_strEMail.Text=''    then edm_strEMail.Text    := 'http::\\www.a2000.by';
End;

procedure TTUsers.SetPhotoParam( pTable : SUSERTAG);
var jpg: TJpegImage;
    bmp: TBitmap;
    MemoryStream :TMemoryStream;
begin
MemoryStream := TMemoryStream.Create;
  try
   MemoryStream.Clear;
   Img_Photo.Picture.Graphic.SaveToStream(MemoryStream);
   MemoryStream.Position := 0;
   m_pDB.SetPhotoTable(ptable,MemoryStream);
  finally
   if (MemoryStream<>Nil) then FreeAndNil(MemoryStream);//MemoryStream.Free;
  End;
end;
procedure TTUsers.GetPhotoParam(pTable : SUSERTAG);
var jpg: TJpegImage;
    bmp: TBitmap;
    MemoryStream :TMemoryStream;
begin
  MemoryStream := TMemoryStream.Create;
        MemoryStream.Clear;
   try
    if m_pDB.GetPhotoTable(ptable,MemoryStream) then
     begin
          try
            MemoryStream.Position := 0;
            jpg := TJpegImage.Create;
            jpg.LoadFromStream(MemoryStream);
            Img_Photo.Picture.Assign(jpg);
            jpg.free;
          Except
           MemoryStream.Position := 0;
           bmp := TBitmap.Create;
           bmp.LoadFromStream(MemoryStream);
           Img_Photo.Picture.Assign(bmp);
           bmp.free;
          end;
     end
    else
    Img_Photo.Picture.Assign(nil);
   finally
    if (MemoryStream<>Nil)then FreeAndNil(MemoryStream); //MemoryStream.Free;
   end;
end;

procedure TTUsers.SetUserParam(Var pTable : SUSERTAG);
Begin
      SetDefaultSett;
      with pTable do
      Begin
       m_swUID        := StrToInt(edm_swUID.Text)-1;
       m_swSLID       := cbm_swSLID.ItemIndex;
       m_sdtRegDate   := StrToDateTime(edm_sdtRegDate.Text);
       m_strShName    := edm_strShName.Text;
       m_strPassword  := EncodeStrCrypt(edm_strPassword.Text);
       m_strFam       := edm_strFam.Text;
       m_strImya      := edm_strImya.Text;
       m_strOtch      := edm_strOtch.Text;
       m_strDolgn     := edm_strDolgn.Text;
       m_strHomeAddr  := edm_strHomeAddr.Text;
       m_strTel       := edm_strTel.Text;
       m_strEMail     := edm_strEMail.Text;
       m_sbyPrmDE     := SmallInt(chbm_sbyPrmDE.Checked);
       m_sbyPrmPE     := SmallInt(chbm_sbyPrmPE.Checked);
       m_sbyPrmQE     := SmallInt(chbm_sbyPrmQE.Checked);
       m_sbyPrmCE     := SmallInt(chbm_sbyPrmCE.Checked);
       m_sbyPrmGE     := SmallInt(chbm_sbyPrmGE.Checked);
       m_sbyPrmTE     := SmallInt(chbm_sbyPrmTE.Checked);
       m_sbyPrmCNE    := SmallInt(chbm_sbyPrmCNE.Checked);
       m_sbyPrmPRE    := SmallInt(chbm_sbyPrmPRE.Checked);
       m_sbyEnable    := SmallInt(chbm_sbyEnable.Checked);
       m_sbyQryGrp    := SmallInt(chbm_sbyQryGrp.Checked);   //chbm_sbyAccReg
       m_sbyAccReg    := SmallInt(chbm_sbyAccReg.Checked);
      // setPhotoParam(pTable);
       SaveAbonCheckedList(m_sAllowAbon);
      End;
End;
procedure TTUsers.GetUserParam(Var pTable : SUSERTAG);
Begin
      with pTable do
      Begin
       edm_swUID.Text         := IntToStr(m_swUID+1);
       cbm_swSLID.ItemIndex   := m_swSLID;
       edm_sdtRegDate.Text    := DateTimeToStr(m_sdtRegDate);
       edm_strShName.Text     := m_strShName;
       edm_strPassword.Text   := m_strPassword;
       edm_strFam.Text        := m_strFam;
       edm_strImya.Text       := m_strImya;
       edm_strOtch.Text       := m_strOtch;
       edm_strDolgn.Text      := m_strDolgn;
       edm_strHomeAddr.Text   := m_strHomeAddr;
       edm_strTel.Text        := m_strTel;
       edm_strEMail.Text      := m_strEMail;
       chbm_sbyPrmDE.Checked  := Boolean(m_sbyPrmDE);
       chbm_sbyPrmPE.Checked  := Boolean(m_sbyPrmPE);
       chbm_sbyPrmQE.Checked  := Boolean(m_sbyPrmQE);
       chbm_sbyPrmCE.Checked  := Boolean(m_sbyPrmCE);
       chbm_sbyPrmGE.Checked  := Boolean(m_sbyPrmGE);
       chbm_sbyPrmTE.Checked  := Boolean(m_sbyPrmTE);
       chbm_sbyPrmCNE.Checked := Boolean(m_sbyPrmCNE);
       chbm_sbyPrmPRE.Checked := Boolean(m_sbyPrmPRE);
       chbm_sbyEnable.Checked := Boolean(m_sbyEnable);
       chbm_sbyQryGrp.Checked := Boolean(m_sbyQryGrp);  // chbm_sbyAccReg
       chbm_sbyAccReg.Checked := Boolean(m_sbyAccReg);
       //GetPhotoParam(pTable);
       SetAbonCheckedList(m_sAllowAbon);
      End;
End;

function  TTUsers.GenIndex:Integer;
Var
      i : Integer;
Begin
      for i:=0 to MAX_USER do
      if m_blUserIndex[i]=True then
      Begin
       Result := i;
       exit;
      End;
      Result := -1;
End;
function TTUsers.GenIndexSv:Integer;
Begin
      Result := SetIndex(GenIndex);
End;
function TTUsers.SetIndex(nIndex : Integer):Integer;
Begin
      m_blUserIndex[nIndex] := False;
      Result := nIndex;
End;
Procedure TTUsers.FreeIndex(nIndex : Integer);
Begin
      m_blUserIndex[nIndex] := True;
End;
Procedure TTUsers.FreeAllIndex;
Var
      i : Integer;
Begin
      for i:=0 to MAX_USER do
      m_blUserIndex[i] := True;
End;
procedure TTUsers.OnCreateForm(Sender: TObject);
var
mCL                    :  SCOLORSETTTAG;
begin

      FreeAllIndex;
      m_nCurrentUser  := 0;
      m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
      cbm_swSLID.items.loadfromfile(m_strCurrentDir+'SettUserLayer.dat');
      cbm_swSLID.ItemIndex := 0;
      if m_nUM=Nil then exit; 
      m_nUM.PsgGrid   := @FsgGrid;
      m_nIDIndex          := 1;
      m_nCurRow           := 1;
      FsgGrid.ColCount    := 5;
      FsgGrid.RowCount    := 10;
      FsgGrid.Cells[0,0]  := '№/T';
      FsgGrid.Cells[1,0]  := 'Пользователь';
      FsgGrid.Cells[2,0]  := 'Пароль';
      FsgGrid.Cells[3,0]  := 'Уровень доступа';
      FsgGrid.Cells[4,0]  := 'Активность';
      FsgGrid.ColWidths[0]:= 35;
      mCL.m_swCtrlID := CL_TREE_CONF;
      m_pDB.GetColorTable(mCL);
      nSizeFont := mCL.m_swFontSize;
      SetHigthGrid(FsgGrid,nSizeFont+17);
      m_nCF.m_nSetColor.PUserStyler := @UserStyler;
      m_nCF.m_nSetColor.SetAllStyle(m_nCF.StyleForm.ItemIndex{+1});
      LoadAbonsCheckList;
      OnFormResize;
      SetUsers;
      OnGetUserSettings;

  AdvPanelPermission.Visible:=True;
  AdvPanelPermission.Align:=alClient;

end;
procedure TTUsers.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
      i : Integer;
Begin
      for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TTUsers.OnFormResize;
Var
      i : Integer;
begin
      for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
end;
procedure TTUsers.SetUsers;
Var
      i : Integer;
Begin
      if m_pDB.GetUsersTable(m_pTable)=True then
      Begin
       edm_swAmUser.Text := IntTostr(m_pTable.Count);
       for i:=0 to m_pTable.Count-1 do SetIndex(m_pTable.Items[i].m_swUID);
      End;
End;
procedure TTUsers.OnGetUserInfo(Sender: TObject);
begin
      OnGetUserSettings;
end;
procedure TTUsers.OnCreateUserSettings(Sender: TObject);
Begin
      SetUsers;
      edm_swUID.Text         := IntToStr(GenIndex+1);
      cbm_swSLID.ItemIndex   := 0;
      edm_sdtRegDate.Text    := DateTimeToStr(Now);
      edm_strShName.Text     := '';
      edm_strPassword.Text   := '';
      edm_strFam.Text        := '';
      edm_strImya.Text       := '';
      edm_strOtch.Text       := '';
      edm_strDolgn.Text      := '';
      edm_strHomeAddr.Text   := '';
      edm_strTel.Text        := '';
      edm_strEMail.Text      := '';
      chbm_sbyPrmDE.Checked  := False;
      chbm_sbyPrmPE.Checked  := False;
      chbm_sbyPrmQE.Checked  := False;
      chbm_sbyPrmCE.Checked  := False;
      chbm_sbyPrmGE.Checked  := False;
      chbm_sbyPrmTE.Checked  := False;
      chbm_sbyPrmCNE.Checked := False;
      chbm_sbyPrmPRE.Checked := False;
      chbm_sbyEnable.Checked := True;
      chbm_sbyQryGrp.Checked := False;  // chbm_sbyAccReg
      chbm_sbyAccReg.Checked := False;
      Img_Photo.Picture.Assign(nil);
//      m_pDB.FixUspdDescEvent(0,3,EVS_CRT_ACCT,0);
End;
procedure TTUsers.OnDelUserSettings(Sender: TObject);
begin
      if MessageDlg('Удалить пользователя '+edm_strShName.Text+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
      Begin
//       m_pDB.FixUspdDescEvent(0,3,EVS_DEL_ACCT,0);
       m_nCurrentUser := 0;
       m_pDB.DelUserTable(StrToInt(edm_swUID.Text)-1);
       FreeIndex(StrToInt(edm_swUID.Text)-1);
       SetUsers;
       if m_pTable.Count<>0 then
       Begin
        m_nCurrentUser := m_pTable.Count - 1;
        OnGetUserSettings;
       End else
       if m_pTable.Count=0 then OnCreateUserSettings(self);
      End;
end;
function  TTUsers.FindUser(str:String):Integer;
Var
      i : Integer;
Begin
      Result := -1;
      for i:=0 to m_pTable.Count-1 do
      Begin
       if m_pTable.Items[i].m_strShName=str then
       Begin
        Result := i;
        exit; 
       End;
      End;
End;
procedure TTUsers.OnBackForward(Sender: TObject);
begin
      if m_nCurrentUser=0 then OnGetUserSettings;
      if m_nCurrentUser>0 then
      Begin
       m_nCurrentUser:=m_nCurrentUser-1;
       OnGetUserSettings;
      End;
      FsgGrid.SelectRows(FindRow(edm_strShName.Text),1);
      //FsgGrid.Refresh;
  chbm_sbyAccRegShow;
end;
function TTUsers.FindRow(str:String):Integer;
Var
      i : Integer;
Begin
      for i:=1 to FsgGrid.RowCount-1 do if FsgGrid.Cells[m_nIDIndex,i]=str then
      Begin
       if (i-FsgGrid.VisibleRowCount)>0  then FsgGrid.TopRow := i-FsgGrid.VisibleRowCount+1 else FsgGrid.TopRow := 1;
       Result := i;
       exit;
      End;
      Result := 1;
End;
procedure TTUsers.OnForward(Sender: TObject);
Var
      pTable : SUSERTAG;
begin
      //m_pDB.GetSecurityAttributes('a2000','Password',pTable);
      //if m_pDB.CheckLevelAccess('a2000','Password',LV_LEVEL_1) then
      if m_pTable.Count<>0 then
      if m_nCurrentUser<m_pTable.Count-1 then
      Begin
       m_nCurrentUser:=m_nCurrentUser+1;
       OnGetUserSettings;
      End;
      FsgGrid.SelectRows(FindRow(edm_strShName.Text),1);
      //FsgGrid.Refresh;
  chbm_sbyAccRegShow;
end;

procedure TTUsers.OnChandgeLevel(Sender: TObject);
begin
      if cbm_swSLID.ItemIndex=0 then
      Begin
       chbm_sbyPrmDE.Checked  := True;
       chbm_sbyPrmPE.Checked  := False;
       chbm_sbyPrmQE.Checked  := False;
       chbm_sbyPrmCE.Checked  := False;
       chbm_sbyPrmGE.Checked  := False;
       chbm_sbyPrmTE.Checked  := False;
       chbm_sbyPrmCNE.Checked := False;
       chbm_sbyPrmPRE.Checked := False;
       chbm_sbyQryGrp.Checked := False;
       chbm_sbyAccReg.Checked := True;
      End else
      if cbm_swSLID.ItemIndex=1 then
      Begin
       chbm_sbyPrmDE.Checked  := True;
       chbm_sbyPrmPE.Checked  := False;
       chbm_sbyPrmQE.Checked  := False;
       chbm_sbyPrmCE.Checked  := True;
       chbm_sbyPrmGE.Checked  := True;
       chbm_sbyPrmTE.Checked  := True;
       chbm_sbyPrmCNE.Checked := False;
       chbm_sbyPrmPRE.Checked := False;
       chbm_sbyQryGrp.Checked := True;
       chbm_sbyAccReg.Checked := False;
      End else
      if cbm_swSLID.ItemIndex=2 then
      Begin
       chbm_sbyPrmDE.Checked  := True;
       chbm_sbyPrmPE.Checked  := True;
       chbm_sbyPrmQE.Checked  := True;
       chbm_sbyPrmCE.Checked  := True;
       chbm_sbyPrmGE.Checked  := True;
       chbm_sbyPrmTE.Checked  := True;
       chbm_sbyPrmCNE.Checked := True;
       chbm_sbyPrmPRE.Checked := True;
       chbm_sbyQryGrp.Checked := True;
       chbm_sbyAccReg.Checked := False;
      End;
      chbm_sbyEnable.Checked := True;
end;

procedure TTUsers.OnLoadHKeyInfo(Sender: TObject);
Var
      strUser : String;
      nLevel,nY,nActive : Integer;
begin
      FsgGrid.ClearNormalCells;
      m_nUM.PrepareButton;
      nY := 1;
      while m_nUM.GetUser(strUser,nLevel,nActive)=True do
      Begin
       //if nActive=1 then
       Begin
        FsgGrid.Cells[0,nY] := IntToStr(nY);
        FsgGrid.Cells[1,nY] := strUser;
        FsgGrid.Cells[2,nY] := '******';
        if nLevel<m_nUserLayer.Count then FsgGrid.Cells[3,nY] := m_nUserLayer.Strings[nLevel] else FsgGrid.Cells[3,nY] := m_nUserLayer.Strings[0];
        if nActive<m_nEsNoList.Count then FsgGrid.Cells[4,nY] := m_nEsNoList.Strings[nActive] else FsgGrid.Cells[4,nY] := m_nEsNoList.Strings[1];
       End;
       Inc(nY);
      End;
end;

procedure TTUsers.OnGetCellColorKey(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
      OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTUsers.OnCopyKey(Sender: TObject);
begin
      lbGenSettings.Caption := 'Копирование ключа шифрования';
      m_nUM.Copy;
      m_nUM.PrepareButton;
      lbGenSettings.Caption := 'Подготовка к записи даных';
      OnSaveKey(Sender);
      lbGenSettings.Caption := 'Все данные перенесены';
end;
procedure TTUsers.OnSaveKey(Sender: TObject);
Var
      i       : Integer;
      strUser : String;
      strPass : String;
      nLevel  : Integer;
      nActive : Integer;
begin
      for i:=1 to FsgGrid.RowCount-1 do
      Begin
       if (FsgGrid.Cells[1,i]='') or (i>7) then break;
       SetDefaultGrid(i);
       strUser := FsgGrid.Cells[1,i];
       strPass := FsgGrid.Cells[2,i];
       nLevel  := m_nUserLayer.IndexOf(FsgGrid.Cells[3,i]);
       nActive  := m_nEsNoList.IndexOf(FsgGrid.Cells[4,i]);
       m_nUM.CreateUser(strUser,strPass,nLevel,nActive,i-1);
      End;
      //if FsgGrid.RowCount<>0 then
      m_nUM.Save;
end;
procedure TTUsers.SaveToKey(strUser,strPass:String;nLevel:Integer);
Var
      i       : Integer;
Begin
      for i:=1 to FsgGrid.RowCount-1 do
      Begin
       if (FsgGrid.Cells[1,i]='')or(i>7) then break;
       if (m_nCurRow=i) then
       //if ((m_nCurRow=i)and(FsgGrid.Cells[4,i]=m_nEsNoList.Strings[0])) then
          {(FsgGrid.Cells[4,i]=m_nEsNoList.Strings[0])or
          (FsgGrid.Cells[1,i]=strUser)}
       Begin
        FsgGrid.Cells[1,i] := strUser;
        FsgGrid.Cells[2,i] := strPass;
        FsgGrid.Cells[3,i] := m_nUserLayer.Strings[nLevel];
        FsgGrid.Cells[4,i] := m_nEsNoList.Strings[1];
        break;
       End;
      End;
      m_nCurRow := 0;

End;
procedure TTUsers.SetDefaultGrid(i:Integer);
Begin
      if FsgGrid.Cells[1,i]=''  then FsgGrid.Cells[1,i]  := 'a2000';
      if FsgGrid.Cells[2,i]=''  then FsgGrid.Cells[2,i]  := 'rrr'+IntToStr(i);
      if FsgGrid.Cells[3,i]=''  then FsgGrid.Cells[3,i]  := m_nUserLayer.Strings[0];
      if FsgGrid.Cells[4,i]=''  then FsgGrid.Cells[4,i]  := m_nEsNoList.Strings[1];
End;
procedure TTUsers.OnGetType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
begin
      with FsgGrid do
      case ACol of
      3:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'SettUserLayer.dat');
       End;
      4:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;

procedure TTUsers.OnCreateNewKey(Sender: TObject);
begin
     lbGenSettings.Caption := 'Создание ключа';
     m_nUM.CreateNew;
     OnLoadHKeyInfo(Sender);
end;

procedure TTUsers.OnSaveToKey(Sender: TObject);
begin
     SaveToKey(edm_strShName.Text,edm_strPassword.Text,cbm_swSLID.ItemIndex);
end;

procedure TTUsers.OnClearAllUser(Sender: TObject);
Var
      i       : Integer;
Begin
      for i:=1 to FsgGrid.RowCount-1 do
      Begin
       if (i>7) then break;
       FsgGrid.Cells[0,i] := IntToStr(i);
       if i=1 then
       Begin
        FsgGrid.Cells[1,i] := 'a2000';
        FsgGrid.Cells[2,i] := 'rrr';
        FsgGrid.Cells[3,i] := m_nUserLayer.Strings[2];
        FsgGrid.Cells[4,i] := m_nEsNoList.Strings[1];
       End else
       if i<>1 then
       Begin
        FsgGrid.Cells[1,i] := 'a200'+IntToStr(i);
        FsgGrid.Cells[2,i] := 'rrr'+IntToStr(i);
        FsgGrid.Cells[3,i] := m_nUserLayer.Strings[0];
        FsgGrid.Cells[4,i] := m_nEsNoList.Strings[0];
       End;
      End;
End;
procedure TTUsers.OnClickCell(Sender: TObject; ARow, ACol: Integer);
Var
      nUser : Integer;
begin
       m_nCurRow := 0;
       if (ARow>0)and(ARow<8) then
       Begin
        m_nCurRow := ARow;
        if (FsgGrid.Cells[4,ARow]=m_nEsNoList.Strings[0]) then exit;
        nUser := FindUser(FsgGrid.Cells[1,ARow]);
        if nUser<>-1 then
        Begin
         m_nCurrentUser:=nUser;
         OnGetUserSettings;
        End;
       End;
end;

procedure TTUsers.OnChandgeChann(Sender: TObject);
begin
       m_nUM.SetChannel(sem_nChannel.Value);
end;

procedure TTUsers.OnLoadPhotoClick(Sender: TObject);
var
 Strem:TFileStream;
 size:integer;
 begin
  if OpenPictureDialog1.Execute then
  begin
   Strem:=tfilestream.create(OpenPictureDialog1.FileName,fmOpenRead);
   size:=Strem.seek(0,sofromend);
   if (Strem<>Nil)then FreeAndNil(Strem);//  Strem.free;
   if size > 100000 then ShowMessage('Размер файла превышает 100 Kb')
   else
   Img_Photo.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
 end;

procedure TTUsers.edm_strPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   EventFlag := EVH_MOD_PASSWORD;
end;

procedure TTUsers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  m_nCF.m_nSetColor.PUserStyler := nil;
//  m_pDB.FixUspdDescEvent(0,3,EVS_CLOS_EACC,0);
end;

procedure TTUsers.OnClichPassw(Sender: TObject);
begin
   if cbPassw.Checked=True  then edm_strPassword.PasswordChar := #0 else
   if cbPassw.Checked=False then edm_strPassword.PasswordChar := '*';
end;

procedure TTUsers.LoadAbonsCheckList;
var i : integer;
begin
   m_pDB.GetAbonsNamesTable(m_pAbonTable);
   AbonsCheckList.Clear;
   AbonsCheckList.Items.Add('Все');
   for i := 0 to m_pAbonTable.Count - 1 do
     AbonsCheckList.Items.Add(m_pAbonTable.Items[i].m_sName);
end;

procedure TTUsers.SetAbonCheckedList(var AllowAbon : string);
var AllowAbonsBuf : array of integer;
    i, j          : integer;
begin
   SetLength(AllowAbonsBuf, m_pAbonTable.Count + 5);
   GetIntArrayFromStr(AllowAbon, AllowAbonsBuf);
   for i := 0 to AbonsCheckList.Items.Count - 1 do
     AbonsCheckList.Checked[i] := false;
   for i := 0 to Length(AllowAbonsBuf) - 1 do
     if (AllowAbonsBuf[i] <> -100) and (AllowAbonsBuf[i] <> -1) then
     begin
       for j := 0 to m_pAbonTable.Count - 1 do
         if AllowAbonsBuf[i] = m_pAbonTable.Items[j].m_swABOID then
           AbonsCheckList.Checked[j + 1] := true;
     end
     else if AllowAbonsBuf[i] = -1 then
       AbonsCheckList.Checked[0] := true;
end;

procedure TTUsers.SaveAbonCheckedList(var AllowAbon : string);
var i  : integer;
begin
   AllowAbon := '';
   for i := 0 to AbonsCheckList.Items.Count - 1 do
     if AbonsCheckList.Checked[i] then
        if i = 0 then
          AllowAbon := '-1,'
        else
          AllowAbon := AllowAbon + IntToStr(m_pAbonTable.Items[i - 1].m_swABOID) + ',';
end;

procedure TTUsers.chbm_sbyAccRegClick(Sender: TObject);
begin
//  chbm_sbyAccReg.Checked := not chbm_sbyAccReg.Checked;
  chbm_sbyAccRegShow;
end;



procedure TTUsers.FormActivate(Sender: TObject);
begin
  chbm_sbyAccRegShow;
end;

procedure TTUsers.chbm_sbyAccRegShow;
begin
  if chbm_sbyAccReg.Checked then begin
    AdvPanelPermREGIN.Visible := True;
    AdvPanelPermRAYON.Visible := True;
  end else begin
    AdvPanelPermREGIN.Visible := False;
    AdvPanelPermRAYON.Visible := False;
  end;
  if chbm_sbyAccReg.Checked then
    SetCheckBoxes(UserPerm.ABRList);
end;



function TTUsers.GetCheckBoxUser(UP: TUserPermission): TUserPermission;  // читает чекбоксы
begin
  UP.DataEditor        := chbm_sbyPrmDE.Checked;
  UP.ParameterEditor   := chbm_sbyPrmPE.Checked;
  UP.QueryEditor       := chbm_sbyPrmQE.Checked;
  UP.ChannelEditor     := chbm_sbyPrmCE.Checked;
  UP.GroupEditor       := chbm_sbyPrmGE.Checked;
  UP.TariffEditor      := chbm_sbyPrmTE.Checked;
  UP.ConectionEditor   := chbm_sbyPrmCNE.Checked;
  UP.PermissionEditor  := chbm_sbyPrmPRE.Checked;
  UP.GeneralResolution := chbm_sbyEnable.Checked;
  UP.PermissQueryGroup := chbm_sbyQryGrp.Checked;
  UP.AccessByRegion    := chbm_sbyAccReg.Checked;
  Result := UP;
end;

procedure TTUsers.SetCheckBoxUser(UP: TUserPermission);  // устанавливает чекбоксы
begin
  chbm_sbyPrmDE.Checked  := UP.DataEditor;
  chbm_sbyPrmPE.Checked  := UP.ParameterEditor;
  chbm_sbyPrmQE.Checked  := UP.QueryEditor;
  chbm_sbyPrmCE.Checked  := UP.ChannelEditor;
  chbm_sbyPrmGE.Checked  := UP.GroupEditor;
  chbm_sbyPrmTE.Checked  := UP.TariffEditor;
  chbm_sbyPrmCNE.Checked := UP.ConectionEditor;
  chbm_sbyPrmPRE.Checked := UP.PermissionEditor;
  chbm_sbyEnable.Checked := UP.GeneralResolution;
  chbm_sbyQryGrp.Checked := UP.PermissQueryGroup;
  chbm_sbyAccReg.Checked := UP.AccessByRegion;
end;

procedure TTUsers.FormDestroy(Sender: TObject);
begin
  UserPerm.Destroy;
end;

procedure TTUsers.SetCheckBoxes(AL: TList);
var k : Integer;
begin
  SetCBRegion(AL);
  if clbREGIN.Items.Count > 0 then begin
    if clbREGIN.ItemIndex < 0 then clbREGIN.ItemIndex := 0;
    k := Integer(clbREGIN.Items.Objects[clbREGIN.ItemIndex]);
    SetCBDepart(AL, k);
  end;
end;

procedure TTUsers.SetCBRegion(AL: TList);
var i, h : Integer;
    ABR  : TABR;
    tReg : Integer;
begin
  clbREGIN.Clear;
  ABR := TABR(AL.items[0]);
  tReg := ABR.IDREGION;
  clbREGIN.items.AddObject(ABR.REGION, TObject(ABR.IDREGION));
  h:=1;
  if ABR.Access then clbREGIN.Checked[0] := True;
  for i := 1 to AL.Count-1 do begin
    ABR := TABR(AL.items[i]);
    if ABR.IDREGION <> tReg then begin
      clbREGIN.items.AddObject(ABR.REGION, TObject(ABR.IDREGION));
      if ABR.Access then clbREGIN.Checked[h] := True;
      Inc(h);
      tReg := ABR.IDREGION;
    end else if ABR.Access then clbREGIN.Checked[h-1] := True;
  end;
end;

procedure TTUsers.SetCBDepart(AL: TList; ID : integer);
var i, h : Integer;
    ABR  : TABR;
    tRay : Integer;
begin
  clbRAYON.Clear;
  ABR := TABR(AL.items[0]);
  tRay := ABR.IDDEPART;
  if ABR.IDREGION = ID then begin
    clbRAYON.items.AddObject(ABR.DEPART, TObject(ABR.IDDEPART));
    h:=1;
  end else h:=0;
  if ABR.Access then
    if clbRAYON.Items.Count >= 1 then
      clbRAYON.Checked[0] := True;
  for i := 1 to AL.Count-1 do begin
    ABR := TABR(AL.items[i]);
    if ABR.IDDEPART <> tRay then begin
      if ABR.IDREGION = ID then begin
        clbRAYON.items.AddObject(ABR.DEPART, TObject(ABR.IDDEPART));
        if ABR.Access then clbRAYON.Checked[h] := True;
        Inc(h);
        tRay := ABR.IDDEPART;
      end;
    end;
  end;
end;

procedure TTUsers.clbREGINClick(Sender: TObject);
var k : Integer;
begin
  if clbREGIN.Items.Count > 0 then begin
    if clbREGIN.ItemIndex < 0 then clbREGIN.ItemIndex := 0;
    k := Integer(clbREGIN.Items.Objects[clbREGIN.ItemIndex]);
    SetCBDepart(UserPerm.ABRList, k);
  end;
end;



procedure TTUsers.SaveUserSettings;
begin
  UserPerm := GetCheckBoxUser(UserPerm);
  UserPerm.SetUserData(UserPerm.IDUser);
  // сопоставить clbREGIN и clbRAYON с ABRList ??
  // --  UserPerm.ABRList
end;

procedure TTUsers.clbRAYONClickCheck(Sender: TObject);
var i, k, reg, ray : Integer;
    ABR            : TABR;
    isReg          : Boolean;
begin
  reg := Integer(clbREGIN.Items.Objects[clbREGIN.ItemIndex]);
  ray := Integer(clbRAYON.Items.Objects[clbRAYON.ItemIndex]);
  for i := 0 to UserPerm.ABRList.Count-1 do begin
    ABR := TABR(UserPerm.ABRList.items[i]);
    if (ABR.IDREGION = reg) and (ABR.IDDEPART = ray) then
      ABR.Access := clbRAYON.Checked[clbRAYON.ItemIndex];
  end;
  isReg := False;
  for i := 0 to clbRAYON.Items.Count-1 do begin
    if clbRAYON.Checked[i] then isReg := True;
  end;
  if isReg then clbREGIN.Checked[clbREGIN.ItemIndex] := True
  else clbREGIN.Checked[clbREGIN.ItemIndex] := False;
end;

procedure TTUsers.clbREGINClickCheck(Sender: TObject);
var i, k : Integer;
    tbl  : boolean;
begin
  // при изменении чекбокса clbREGIN все чекбоксы clbRAYON устанавливаются равными ему
  k := Integer(clbREGIN.Items.Objects[clbREGIN.ItemIndex]);
  SetCBDepart(UserPerm.ABRList, k);
  tbl := clbREGIN.Checked[clbREGIN.ItemIndex];
  for i := 0 to clbRAYON.Items.Count-1 do begin
    clbRAYON.Checked[i] := tbl;
    clbRAYON.ItemIndex := i;
    clbRAYONClickCheck(Sender);
  end;
end;

end.
