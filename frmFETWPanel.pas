unit frmFETWPanel;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, RbDrawCore, RbButton, AdvPanel;

type
  TRayonCode = class
    ID : Integer;
    Code : integer;
  end;

  TframeFETW = class(TFrame)
    Panel: TAdvPanel;
    AdvPanelStyler1: TAdvPanelStyler;
    Label1: TLabel;
    ComboBox: TComboBox;
    Label2: TLabel;
    Edit: TEdit;
    btnAdd: TRbButton;
    btnRef: TRbButton;
    btnDel: TRbButton;
    procedure MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBoxEnter(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnRefClick(Sender: TObject);
  private
    function NewSelection:integer;
    procedure InLstAddress(cbb : TComboBox);
    procedure SetStructAddress(tag, value : integer);
    function CbbCompare(var cbb: TComboBox): Boolean;
  public
    REGIN        : Integer;
    RAYON        : Integer;
    TOWNS        : Integer;
    TPODS        : Integer;
    STRET        : Integer;
    ABONT        : Integer;
    procedure GetData(cbb : TComboBox);
    procedure SetInNil(level : Integer);
    function SetIndex: boolean;
    procedure VisableFETW(level:integer);
    procedure SetColorNormal;
    procedure SetColorHighlight(AdvPanel : TAdvPanel);
    procedure ClearRayon;    
  end;

implementation

uses utlconst, utlDB, frmEditTreeView;

{$R *.DFM}

{$R+}

// ***********************************
// Обработка кликов мыши и ввода с клавиатуры
// ***********************************
procedure TframeFETW.MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i   : Integer;
    tx  : string;
    ETW : TFrameEditTreeView;
begin
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  if ETW.ActiveProc = Tag then Exit;
//  if FirstStart then InitObjects;
  SetColorNormal;
  SetColorHighlight(Panel);
  ETW.ActiveProc := Tag;
  ETW.lblAddress.Caption := Label1.Caption;
//  CaptionPanel.Caption := Label1.Caption;
  if X <> -1 then begin  // событие пришло от мышки
    case Tag of
        SD_REGIN : begin
          VisableFETW(1);
          if REGIN <> -1 then InlstAddress(ComboBox);
        end;
        SD_RAYON : begin
          if REGIN <> -1 then VisableFETW(2);
          if RAYON = -1 then SetInNil(1)
          else InlstAddress(ComboBox);
        end;
        SD_TOWNS : begin
          if RAYON <> -1 then VisableFETW(3);
          if TOWNS = -1 then SetInNil(2)
          else InlstAddress(ComboBox);
        end;
        SD_TPODS : begin
          if TPODS <> -1 then VisableFETW(4);
          if TPODS = -1 then SetInNil(3)
          else InlstAddress(ComboBox);
        end;
        SD_STRET : begin
          if TPODS <> -1 then VisableFETW(5);
          if STRET = -1 then SetInNil(4)
          else InlstAddress(ComboBox);
        end;
        SD_ABONT : begin
          if TPODS <> -1 then VisableFETW(6);
          if ABONT = -1 then SetInNil(5)
          else InlstAddress(ComboBox);
        end;
    end;
  end else begin  // событие пришло с клавиатуры
    if not CbbCompare(ComboBox) then begin
      case Tag of
        SD_REGIN : REGIN:=-1;
        SD_RAYON : RAYON:=-1;
        SD_TOWNS : TOWNS:=-1;
        SD_TPODS : TPODS:=-1;
        SD_STRET : STRET:=-1;
        SD_ABONT : ABONT:=-1;
      end;
    ComboBox.ItemIndex:=-1;
    ETW.lstAddress.ItemIndex:=ComboBox.ItemIndex;
    end else begin
      case Tag of
        SD_REGIN : VisableFETW(1);
        SD_RAYON : VisableFETW(2);
        SD_TOWNS : VisableFETW(3);
        SD_TPODS : VisableFETW(4);
        SD_STRET : VisableFETW(5);
        SD_ABONT : VisableFETW(6);
      end;
      InlstAddress(ComboBox);
    end;
  end;
end;

procedure TframeFETW.ComboBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  MouseUp(Sender, mbMiddle, [ssMiddle], -1, Byte(Key));
end;

procedure TframeFETW.ComboBoxEnter(Sender: TObject);
var act : integer;
begin
  if Tag <> SD_REGIN then
    MouseUp(Sender, mbMiddle, [ssMiddle], -1, -1)

end;


// ***********************************
// Запросы и занесение данных в ComboBox
// ***********************************
procedure TframeFETW.GetData(cbb : TComboBox);
var strSQL     : string;
    nCount, i  : integer;
    ItemIndx   : integer;
    RayonCode  : TRayonCode;
    ETW        : TFrameEditTreeView;
begin
//  if FirstStart then InitObjects;
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  ItemIndx := ComboBox.ItemIndex;
  if Tag <> SD_RAYON then ComboBox.Items.Clear;
  case Tag of
    SD_REGIN : begin    //Регион
      strSQL:='SELECT M_NREGIONID, M_NREGNM FROM SL3REGION ' +
              'WHERE M_SBYENABLE > 0 ORDER BY M_NREGNM';
    end;
    SD_RAYON : begin    //Район
      ETW.fRayon.ClearRayon;
      strSQL:='SELECT L3D.M_SWDEPID, L3D.M_SNAME, L3D.CODE ' +
              'FROM SL3DEPARTAMENT L3D WHERE L3D.M_SWREGION = ' + IntToStr(REGIN) + ' ' +
              'ORDER BY L3D.M_SNAME;';
    end;
    SD_TOWNS : begin    //Город
      strSQL:='SELECT L3T.M_SWTOWNID, L3T.M_SNAME FROM SL3TOWN L3T ' +
              'WHERE L3T.M_SWDEPID = ' + IntToStr(RAYON) + ' ' +
              'ORDER BY L3T.M_SNAME;';
    end;
    SD_TPODS : begin    //ТП
      strSQL:='SELECT L3P.ID, L3P.NAME FROM SL3TP L3P ' +
              'WHERE L3P.M_SWTOWNID = ' + IntToStr(TOWNS) + ' ' +
              'ORDER BY L3P.NAME;';
    end;
    SD_STRET : begin    //Улица
      strSQL:='SELECT L3A.M_SWSTREETID, L3S.M_SNAME ' +
              'FROM SL3ABON L3A, SL3STREET L3S ' +
              'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ' +
              '  AND L3A.M_SWTOWNID = ' + IntToStr(TOWNS) + ' ' +
              '  AND L3A.TPID = ' + IntToStr(TPODS) + ' ' +
              'GROUP BY M_SWSTREETID, M_SNAME ' +
              'ORDER BY M_SNAME;';
      strSQL:='SELECT L3S.M_SWSTREETID, L3S.M_SNAME FROM SL3STREET L3S ' +
              'WHERE L3S.M_SWTPID = ' + IntToStr(TPODS) + ' ' +
              'ORDER BY M_SNAME;';
    end;
    SD_ABONT : begin    //Абонент (строение)
      strSQL:='SELECT L3A.M_SWABOID, L3A.M_SNAME FROM SL3ABON L3A ' +
              'WHERE M_SWSTREETID = ' + IntToStr(STRET) + ' ' +
              'ORDER BY L3A.M_SNAME;';
    end;
  end;

  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    for i := 0 to utlDB.DBase.IBQuery.RecordCount-1 do begin
      case Tag of
        SD_REGIN : cbb.Items.AddObject(utlDB.DBase.IBQuery.FieldByName('M_NREGNM').AsString,
                               TObject(utlDB.DBase.IBQuery.FieldByName('M_NREGIONID').AsInteger));
        SD_RAYON : begin
          RayonCode := TRayonCode.Create;
          RayonCode.ID := utlDB.DBase.IBQuery.FieldByName('M_SWDEPID').AsInteger;
          RayonCode.Code := utlDB.DBase.IBQuery.FieldByName('CODE').AsInteger;
          cbb.Items.AddObject(utlDB.DBase.IBQuery.FieldByName('M_SNAME').AsString, RayonCode);
        end;
        SD_TOWNS : cbb.Items.AddObject(utlDB.DBase.IBQuery.FieldByName('M_SNAME').AsString,
                               TObject(utlDB.DBase.IBQuery.FieldByName('M_SWTOWNID').AsInteger));
        SD_TPODS : cbb.Items.AddObject(utlDB.DBase.IBQuery.FieldByName('NAME').AsString,
                               TObject(utlDB.DBase.IBQuery.FieldByName('ID').AsInteger));
        SD_STRET : cbb.Items.AddObject(utlDB.DBase.IBQuery.FieldByName('M_SNAME').AsString,
                               TObject(utlDB.DBase.IBQuery.FieldByName('M_SWSTREETID').AsInteger));
        SD_ABONT : cbb.Items.AddObject(utlDB.DBase.IBQuery.FieldByName('M_SNAME').AsString,
                               TObject(utlDB.DBase.IBQuery.FieldByName('M_SWABOID').AsInteger));
      end;
      utlDB.DBase.IBQuery.Next;
    end;
    if nCount = 0 then begin
      case Tag of
        SD_REGIN : SetInNil(0);   // replase all необработано пока
        SD_RAYON : SetInNil(1);
        SD_TOWNS : SetInNil(2);
        SD_TPODS : SetInNil(3);
        SD_STRET : SetInNil(4);
        SD_ABONT : SetInNil(5);
      end;
    end;
  end;
  if ItemIndx <= ComboBox.Items.Count-1 then
    ComboBox.ItemIndex := ItemIndx;
end;

// ***********************************
// Очистка fRAYON.ComboBox от записей RayonCode
// ***********************************
procedure TframeFETW.ClearRayon;
var i : Integer;
    ComboBox : TComboBox;
    RayonCode : TRayonCode;
    ETW : TFrameEditTreeView;
begin
  if Parent.Parent.Parent.Parent <> nil then begin
    ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
    if ETW.fRAYON <> nil then
      ComboBox := ETW.fRAYON.ComboBox;
  end;
  if ComboBox <> nil then begin
    for i := 0 to ComboBox.Items.Count -1 do begin
      RayonCode := TRayonCode(ComboBox.Items.Objects[i]);
      FreeAndNil(RayonCode);//RayonCode.Destroy;
    end;
    ComboBox.Items.Clear;
  end;
end;

// ***********************************
// обнуление результата в случае выбора новой цепочки адреса
// ***********************************
procedure TframeFETW.SetInNil(level: Integer);
var i : Integer;
    ETW : TFrameEditTreeView;
begin                   // level 1 - RAYON, 2 - TOWNS, 3 - TPODS, 4 - STRET, 5 - ABONT, 6 - All visible
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
//  if FirstStart then InitObjects;
  if level <= 0 then ETW.fREGIN.ComboBox.Text := '';       // REGIN
  if level <= 1 then begin                             // RAYON
    ETW.fRAYON.ComboBox.Text := '';
    ETW.fRAYON.Edit.Text := '00';
  end;
  if level <= 2 then ETW.fTOWNS.ComboBox.Text := '';       // TOWNS
  if level <= 3 then ETW.fTPODS.ComboBox.Text := '';       // TPODS
  if level <= 4 then ETW.fSTRET.ComboBox.Text := '';       // STRET
  if level <= 5 then ETW.fABONT.ComboBox.Text := '';       // ABONT
end;

// ***********************************
// Установка в ComboBox ссылки на объект текущей цепочки адресов
// ***********************************
function TframeFETW.SetIndex: boolean ;
var i   : Integer;
    nID : Integer;
    ID  : Integer;
    RayonCode : TRayonCode;
    ETW : TFrameEditTreeView;
begin
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  case Tag of
    SD_REGIN : ID := REGIN;
    SD_RAYON : ID := RAYON;
    SD_TOWNS : ID := TOWNS;
    SD_TPODS : ID := TPODS;
    SD_STRET : ID := STRET;
    SD_ABONT : ID := ABONT;
  end;
  if ComboBox.Items.Count > 0 then begin
    for i := 0 to ComboBox.Items.Count-1 do begin
      if Tag = SD_RAYON {ComboBox = ETW.fRAYON.ComboBox} then begin
        RayonCode := TRayonCode(ComboBox.Items.Objects[i]);
        nID := RayonCode.ID;
      end else nID:=Integer(ComboBox.Items.Objects[i]);
      if nID = ID then begin
        ComboBox.ItemIndex:=i;
        if ComboBox = ETW.fRAYON.ComboBox then Edit.Text:=IntToStr(RayonCode.Code);
        Result:=True;
        Exit;
      end;
    end;
    if ComboBox.ItemIndex < 0 then Result:=False;
  end else Result:=False;
end;

// ***********************************
// Проверка ComboBox на выбор нового объекта из текстового поля либо из Popup
// ***********************************
function TframeFETW.NewSelection:integer;
var RayonCode : TRayonCode;
    ETW : TFrameEditTreeView;
begin
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  if ComboBox.ItemIndex = -1 then Result := -1
  else if ComboBox = ETW.fRAYON.ComboBox then begin
    RayonCode := TRayonCode(ComboBox.Items.Objects[ComboBox.ItemIndex]);
    Edit.text := IntToStr(RayonCode.Code);
    Result := RayonCode.ID;
  end else Result:= Integer(ComboBox.Items.Objects[ComboBox.ItemIndex]);
end;

// ***********************************
// Проверка ComboBox на изменение объекта
// ***********************************
procedure TframeFETW.ComboBoxChange(Sender: TObject);
var i   : Integer;
    s   : string;
    f   : TframeFETW;
    ItemIndx : integer;
    ETW : TFrameEditTreeView;
    selSt : Integer;
begin
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  i := NewSelection;
  if not CbbCompare(ComboBox) then i := -1;
  if i <> -1 then begin
    ItemIndx := ETW.fABONT.ComboBox.ItemIndex;
    ETW.lstAddress.Items.Clear;
    case Tag of
        SD_REGIN : begin
          SetStructAddress(SD_REGIN, i);  f := ETW.fRAYON;
          f.ComboBox.ItemIndex := -1;
          f.Edit.Text := '00';  f.SetInNil(1);  VisableFETW(2);
        end;
        SD_RAYON : begin
          SetStructAddress(SD_RAYON, i);  f := ETW.fTOWNS;
          f.ComboBox.ItemIndex := -1;  f.SetInNil(2);  VisableFETW(3);
        end;
        SD_TOWNS : begin
          SetStructAddress(SD_TOWNS, i);  f := ETW.fTPODS;
          f.ComboBox.ItemIndex := -1;  f.SetInNil(3);  VisableFETW(4);
        end;
        SD_TPODS : begin
          SetStructAddress(SD_TPODS, i);  f := ETW.fSTRET;
          f.ComboBox.ItemIndex := -1;  f.SetInNil(4);  VisableFETW(5);
        end;
        SD_STRET : begin
          SetStructAddress(SD_STRET, i);  f := ETW.fABONT;
          f.ComboBox.ItemIndex := -1;  f.SetInNil(5);  VisableFETW(6);
        end;
        SD_ABONT : begin
          SetStructAddress(SD_ABONT, i);  f := ETW.fABONT;  f.SetInNil(6);
          f.ComboBox.Itemindex := ItemIndx;  VisableFETW(6);
        end;
    end;
    f.MouseUp(Sender, mbMiddle, [ssMiddle], -1, -1);
    f.GetData(f.ComboBox);
    if f.Tag <> SD_ABONT then f.ComboBox.ItemIndex := -1;
    InlstAddress(f.ComboBox);
  end else begin
    case Tag of
        SD_REGIN : f := ETW.fREGIN;
        SD_RAYON : f := ETW.fRAYON;
        SD_TOWNS : f := ETW.fTOWNS;
        SD_TPODS : f := ETW.fTPODS;
        SD_STRET : f := ETW.fSTRET;
        SD_ABONT : f := ETW.fABONT;
    end;
    selSt := f.ComboBox.SelStart;
    s := f.ComboBox.Text;
    f.ComboBox.ItemIndex :=-1;
    f.ComboBox.Text := s;
    f.ComboBox.SelStart := selSt;
    ETW.lstAddress.ItemIndex:=-1;
    InlstAddress(f.ComboBox);
  end;

end;

// ***********************************
// Передача ComboBox в ListBox
// ***********************************
procedure TframeFETW.InLstAddress(cbb : TComboBox);
var ETW : TFrameEditTreeView;
begin
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  ETW.lstAddress.Items:=cbb.Items;
  ETW.lstAddress.ItemIndex:=cbb.ItemIndex;
end;

// ***********************************
// Обновление полей структуры фрейма в случае выбора нового значения
// ***********************************
procedure TframeFETW.SetStructAddress(tag, value : integer);
var i : Integer;
    ETW : TFrameEditTreeView;
begin
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  for i := 0 to 5 do begin
    case tag of
      SD_REGIN : ETW.pnlColor[i].REGIN := value;
      SD_RAYON : ETW.pnlColor[i].RAYON := value;
      SD_TOWNS : ETW.pnlColor[i].TOWNS := value;
      SD_TPODS : ETW.pnlColor[i].TPODS := value;
      SD_STRET : ETW.pnlColor[i].STRET := value;
      SD_ABONT : ETW.pnlColor[i].ABONT := value;
    end;
  end;
end;

// ***********************************
// Сверка в ComboBox строки ввода Text с элементами PopUp
// ***********************************
function TframeFETW.CbbCompare(var cbb: TComboBox): Boolean;
var s1, s2 : string;
    i      : Integer;
    res    : Boolean;
    ETW    : TFrameEditTreeView;
begin
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  s1:=cbb.Text; //+chr(Y);
  Result := False;
  for i := 0 to cbb.Items.Count -1 do Begin
    s2:=cbb.Items[i];
    s2:=Copy(s2,1,Length(s1));
    if AnsiCompareText(s1, s2) = 0 then begin
      ETW.lstAddress.ItemIndex:=i;
      Result:=True;
      Exit;
    end;
  end;
end;

// ***********************************
// Установка видимости фреймов
// ***********************************
procedure TframeFETW.VisableFETW(level:integer);
var i : Integer;
    ETW    : TFrameEditTreeView;
begin                             // подумать здесь, может лучше делать visable = false по else для увеличения скорости
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  for i := 0 to 5 do ETW.pnlColor[i].Visible := false;
  ETW.fREGIN.Visible:=True;
  if level >= 1 then ETW.fREGIN.Visible := True;
  if level >= 2 then ETW.fRAYON.Visible := True;
  if level >= 3 then ETW.fTOWNS.Visible := True;
  if level >= 4 then ETW.fTPODS.Visible := True;
  if level >= 5 then ETW.fSTRET.Visible := True;
  if level >= 6 then ETW.fABONT.Visible := True;
end;

// ***********************************
// Кинопка "Добавить"
// ***********************************
procedure TframeFETW.btnAddClick(Sender: TObject);
var strSQL     : string;
    i          : Integer;
    cbb        : TComboBox;
    TPType     : Integer;
    ETW    : TFrameEditTreeView;
begin
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  TPType:=1;        // Эта переменная в будущем должна ответить за принадлежность к ТП или МЖД для их распределения внутри энергосистеммы
  case Tag of
    SD_REGIN : cbb := ETW.fREGIN.ComboBox;
    SD_RAYON : cbb := ETW.fRAYON.ComboBox;
    SD_TOWNS : cbb := ETW.fTOWNS.ComboBox;
    SD_TPODS : cbb := ETW.fTPODS.ComboBox;
    SD_STRET : cbb := ETW.fSTRET.ComboBox;
    SD_ABONT : cbb := ETW.fABONT.ComboBox;
  end;

    case Tag of
      SD_REGIN : begin
        if {REGIN = -1} not CbbCompare(cbb) then begin
          strSQL:='SELECT GEN_ID(GEN_SL3REGION_ID, 1) GENS FROM RDB$DATABASE';
          if utlDB.DBase.OpenQry(strSQL, i) then
            REGIN := utlDB.DBase.IBQuery.FieldByName('GENS').AsInteger;
        end;
        strSQL:='UPDATE OR INSERT INTO SL3REGION (M_NREGIONID, M_NREGNM, M_SKSP, M_SBYENABLE) ' +
                'VALUES(' + IntToStr(REGIN) + ', ''' + cbb.text + ''', 8005, 1) matching (M_NREGIONID);';
        VisableFETW(2);
        for i := 0 to 5 do ETW.pnlColor[i].REGIN := REGIN;
        ETW.REGIN := REGIN;
      end;
      SD_RAYON : begin     // Проверить, чтобы нельзя было менять REGIN чтобы это не отразилось на сылке RAYON на определенное место
                           // т.е. цепочка должна сохранятся в любом случае
        if {RAYON = -1} not CbbCompare(cbb) then begin
          strSQL:='SELECT GEN_ID(GEN_SL3DEPARTAMENT_ID, 1) GENS FROM RDB$DATABASE';
          if utlDB.DBase.OpenQry(strSQL, i) then
            RAYON := utlDB.DBase.IBQuery.FieldByName('GENS').AsInteger;
        end;
        strSQL:='UPDATE OR INSERT INTO SL3DEPARTAMENT (M_SWDEPID, M_SNAME, M_SWREGION, CODE) ' +
                'VALUES(' + IntToStr(RAYON) + ', ''' + cbb.text + ''', ' +
                IntToStr(RAYON) + ', ' + Edit.text + ') matching (M_SWDEPID);';
        VisableFETW(3);
        for i := 0 to 5 do ETW.pnlColor[i].RAYON := RAYON;
        ETW.RAYON := RAYON;
      end;
      SD_TOWNS : begin
        if {TOWNS = -1} not CbbCompare(cbb) then begin
          strSQL:='SELECT GEN_ID(GEN_SL3TOWN_ID, 1) GENS FROM RDB$DATABASE';
          if utlDB.DBase.OpenQry(strSQL, i) then
            TOWNS := utlDB.DBase.IBQuery.FieldByName('GENS').AsInteger;
        end;
        strSQL:='UPDATE OR INSERT INTO SL3TOWN (M_SWTOWNID, M_SNAME, M_SWDEPID) ' +
                'VALUES(' + IntToStr(TOWNS) + ', ''' + cbb.text + ''', ' +
                IntToStr(RAYON) + ') matching (M_SWTOWNID);';
        VisableFETW(4);
        for i := 0 to 5 do ETW.pnlColor[i].TOWNS := TOWNS;
        ETW.TOWNS := TOWNS;
      end;
      SD_TPODS : begin
        if {TPODS = -1} not CbbCompare(cbb) then begin
          strSQL:='SELECT GEN_ID(GEN_SL3TP_ID, 1) GENS FROM RDB$DATABASE';
          if utlDB.DBase.OpenQry(strSQL, i) then
            TPODS := utlDB.DBase.IBQuery.FieldByName('GENS').AsInteger;
        end;
        strSQL:='UPDATE OR INSERT INTO SL3TP (ID, NAME, M_SWTOWNID, TPTYPE) ' +
                'VALUES(' + IntToStr(TPODS) + ', ''' + cbb.text + ''', ' +
                IntToStr(TOWNS) + ', ' + IntToStr(TPType) + ') matching (ID);';
        VisableFETW(5);
        for i := 0 to 5 do ETW.pnlColor[i].TPODS := TPODS;
        ETW.TPODS := TPODS;
      end;
      SD_STRET : begin
        if {STRET = -1} not CbbCompare(cbb) then begin
          strSQL:='SELECT GEN_ID(GEN_SL3STREET_ID, 1) GENS FROM RDB$DATABASE';
          if utlDB.DBase.OpenQry(strSQL, i) then
            STRET := utlDB.DBase.IBQuery.FieldByName('GENS').AsInteger;
        end;
        // этот запрос нужно придумать он неправильный по ходу нужен еще и запрос на добавление абонента
        // реализованно методом добавления в таблицу SL3STREET поля M_SWTPID
        // в котором содержится ссылка на ID нужного ТП
        strSQL:='UPDATE OR INSERT INTO SL3STREET (M_SWSTREETID, M_SNAME, M_SWTOWNID, M_SWTPID) ' +
                'VALUES(' + IntToStr(STRET) + ', ''' + cbb.text + ''', ' +
                IntToStr(TOWNS) + ', ' + IntToStr(TPODS) + ') matching (M_SWSTREETID);';
        VisableFETW(6);
        for i := 0 to 5 do ETW.pnlColor[i].STRET := STRET;
        ETW.STRET := STRET;
      end;
      SD_ABONT : begin
        if {ABONT = -1} not CbbCompare(cbb) then begin
          strSQL:='SELECT GEN_ID(GEN_SL3ABON_ID, 1) GENS FROM RDB$DATABASE';
          if utlDB.DBase.OpenQry(strSQL, i) then
            ABONT := utlDB.DBase.IBQuery.FieldByName('GENS').AsInteger;
        end;
        strSQL:='UPDATE OR INSERT INTO SL3ABON (M_SWABOID, M_SNAME, M_NREGIONID, M_SWDEPID, M_SWTOWNID, ' +
                '                               TPID, M_SWSTREETID, M_SWPORTID, M_SADDRESS, M_SDTREGDATE, ' +
                '                               M_SBYENABLE, M_SBYVISIBLE, M_SREPORTVS, M_STREESETTINGS, ' +
                '                               M_SADDRSETTINGS, M_NABONTYPE, M_SMARSHNUMBER, GORS) ' +
                'VALUES(' + IntToStr(ABONT) + ', ''' + cbb.text + ''', ' +
                IntToStr(REGIN) + ', ' + IntToStr(RAYON) + ', ' + IntToStr(TOWNS) + ', ' +
                IntToStr(TPODS) + ', ' + IntToStr(STRET) + ', 0, ''' + ETW.fSTRET.ComboBox.text + ''', ''' +
                DateTimeToStr(now) + ''', 1, 1, 63, 51, 24, 1, 1000, 0) matching (M_SWABOID);';     
        VisableFETW(6);
        for i := 0 to 5 do ETW.pnlColor[i].ABONT := ABONT;
        ETW.ABONT := ABONT;
      end;
    end;
    if utlDB.DBase.ExecQry(strSQL) then begin
      GetData(cbb);
      SetIndex;
      InlstAddress(cbb);
    end;
end;

// ***********************************
// Кинопка "Удалить"
// ***********************************
procedure TframeFETW.btnDelClick(Sender: TObject);
var strSQL     : string;
    i          : Integer;
    cbb        : TComboBox;
    nCount     : Integer;
    ETW    : TFrameEditTreeView;
begin
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  case Tag of
    SD_REGIN : cbb := ETW.fREGIN.ComboBox;
    SD_RAYON : cbb := ETW.fRAYON.ComboBox;
    SD_TOWNS : cbb := ETW.fTOWNS.ComboBox;
    SD_TPODS : cbb := ETW.fTPODS.ComboBox;
    SD_STRET : cbb := ETW.fSTRET.ComboBox;
    SD_ABONT : cbb := ETW.fABONT.ComboBox;
  end;
  case Tag of
    SD_REGIN : strSQL:='SELECT COUNT(M_SWDEPID) CID FROM SL3DEPARTAMENT WHERE M_SWREGION = ' + IntToStr(REGIN);
    SD_RAYON : strSQL:='SELECT COUNT(M_SWTOWNID) CID FROM SL3TOWN WHERE M_SWDEPID = ' + IntToStr(RAYON);
    SD_TOWNS : strSQL:='SELECT COUNT(ID) CID FROM SL3TP WHERE M_SWTOWNID = ' + IntToStr(TOWNS);
    SD_TPODS : strSQL:='SELECT COUNT(M_SWSTREETID) CID FROM SL3STREET WHERE M_SWTPID = ' + IntToStr(TPODS);
    SD_STRET : strSQL:='SELECT COUNT(M_SWABOID) CID FROM SL3ABON WHERE M_SWSTREETID = ' + IntToStr(STRET);
    SD_ABONT : strSQL:='SELECT COUNT(M_SWABOID) CID FROM L2TAG WHERE M_SWABOID = ' + IntToStr(ABONT);
  end;

  if utlDB.DBase.OpenQry(strSQL,nCount) = True then begin
     i:= utlDB.DBase.IBQuery.FieldByName('CID').AsInteger;
     if i > 0 then Begin  // Удалять нельзя
       MessageDlg('Нельзя удалить элемент имеющий внутреннюю структуру', mtConfirmation,[mbYes],0)
     end else begin
       case Tag of
         SD_REGIN : strSQL:='DELETE FROM SL3REGION WHERE M_NREGIONID = ' + IntToStr(REGIN);
         SD_RAYON : strSQL:='DELETE FROM SL3DEPARTAMENT WHERE M_SWDEPID = ' + IntToStr(RAYON);
         SD_TOWNS : strSQL:='DELETE FROM SL3TOWN WHERE M_SWTOWNID = ' + IntToStr(TOWNS);
         SD_TPODS : strSQL:='DELETE FROM SL3TP WHERE ID = ' + IntToStr(TPODS);
         SD_STRET : strSQL:='DELETE FROM SL3STREET WHERE M_SWSTREETID = ' + IntToStr(STRET);
         SD_ABONT : strSQL:='DELETE FROM SL3ABON WHERE M_SWABOID = ' + IntToStr(ABONT);
       end;
       if utlDB.DBase.ExecQry(strSQL) then begin
         i:=cbb.ItemIndex;
         cbb.Items.Delete(i);
         Dec(i);
         cbb.ItemIndex:=i;
         case Tag of
           SD_REGIN : if cbb.ItemIndex >= 0 then REGIN:=Integer(cbb.items.Objects[cbb.ItemIndex])
                      else begin SetInNil(0); VisableFETW(1); end;
           SD_RAYON : if cbb.ItemIndex >= 0 then RAYON:=Integer(cbb.items.Objects[cbb.ItemIndex])
                      else begin SetInNil(1); VisableFETW(2); end;
           SD_TOWNS : if cbb.ItemIndex >= 0 then TOWNS:=Integer(cbb.items.Objects[cbb.ItemIndex])
                      else begin SetInNil(2); VisableFETW(3); end;
           SD_TPODS : if cbb.ItemIndex >= 0 then TPODS:=Integer(cbb.items.Objects[cbb.ItemIndex])
                      else begin SetInNil(3); VisableFETW(4); end;
           SD_STRET : if cbb.ItemIndex >= 0 then STRET:=Integer(cbb.items.Objects[cbb.ItemIndex])
                      else begin SetInNil(4); VisableFETW(5); end;
           SD_ABONT : if cbb.ItemIndex >= 0 then ABONT:=Integer(cbb.items.Objects[cbb.ItemIndex])
                      else begin SetInNil(5); VisableFETW(6); end;
         end;
         InlstAddress(cbb);
       end;
     end;
  end;
end;


// ***********************************
// Кинопка "Обновить"
// ***********************************
procedure TframeFETW.btnRefClick(Sender: TObject);
var strSQL : string;
    i      : Integer;
    cbb    : TComboBox;
    nCount : Integer;
    ETW    : TFrameEditTreeView;
begin
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  case Tag of
    SD_REGIN : cbb := ETW.fREGIN.ComboBox;
    SD_RAYON : cbb := ETW.fRAYON.ComboBox;
    SD_TOWNS : cbb := ETW.fTOWNS.ComboBox;
    SD_TPODS : cbb := ETW.fTPODS.ComboBox;
    SD_STRET : cbb := ETW.fSTRET.ComboBox;
    SD_ABONT : cbb := ETW.fABONT.ComboBox;
  end;           

  case Tag of
    SD_REGIN : strSQL:='UPDATE SL3REGION SET M_NREGNM = ' + '''' + cbb.text + '''' + ' WHERE M_NREGIONID = ' + IntToStr(REGIN);
    SD_RAYON : strSQL:='UPDATE SL3DEPARTAMENT SET M_SNAME = ' + '''' + cbb.text + '''' + ', M_SWREGION = ' + IntToStr(REGIN) + ', CODE = ' + '''' + Edit.text + '''' + ' WHERE M_SWDEPID = ' + IntToStr(RAYON);
    SD_TOWNS : strSQL:='UPDATE SL3TOWN SET M_SNAME = ' + '''' + cbb.text + '''' + ', M_SWDEPID = ' + IntToStr(RAYON) + ' WHERE M_SWTOWNID = ' + IntToStr(TOWNS);
    SD_TPODS : strSQL:='UPDATE SL3TP SET NAME = ' + '''' + cbb.text + '''' + ', M_SWTOWNID = ' + IntToStr(TOWNS) + ', TPTYPE = 0 WHERE ID = ' + IntToStr(TPODS);
    SD_STRET : strSQL:='UPDATE SL3STREET SET M_SNAME = ' + '''' + cbb.text + '''' + ', M_SWTOWNID = ' + IntToStr(TOWNS) + ', M_SWTPID = ' + IntToStr(TPODS) + ' WHERE M_SWSTREETID = ' + IntToStr(STRET);
    SD_ABONT : strSQL:='UPDATE SL3ABON SET M_SNAME = ' + '''' + cbb.text + '''' + ', M_NREGIONID = ' + IntToStr(REGIN) + ',  M_SWDEPID = ' + IntToStr(RAYON) + ', M_SWTOWNID = ' + IntToStr(TOWNS) + ', '+
                       'TPID = ' + IntToStr(TPODS) + ', M_SWSTREETID = ' + IntToStr(STRET) + ' WHERE M_SWABOID = ' + IntToStr(ABONT);
  end;

  if utlDB.DBase.ExecQry(strSQL) then begin
    GetData(cbb);
    case Tag of
      SD_REGIN : ETW.fREGIN.SetIndex;
      SD_RAYON : ETW.fRAYON.SetIndex;
      SD_TOWNS : ETW.fTOWNS.SetIndex;
      SD_TPODS : ETW.fTPODS.SetIndex;
      SD_STRET : ETW.fSTRET.SetIndex;
      SD_ABONT : ETW.fABONT.SetIndex;
    end;
    InlstAddress(cbb);
  end;
  
end;

procedure TframeFETW.SetColorHighlight(AdvPanel: TAdvPanel);
begin
  Panel.Color := $009F9691;
  Panel.ColorMirror := $00958B84;
  Panel.ColorMirrorTo := $00ACACA5;
  Panel.ColorTo := $00958B84;
end;


procedure TframeFETW.SetColorNormal;
var i : Integer;
    ETW : TFrameEditTreeView;
begin
  ETW := Parent.Parent.Parent.Parent as TFrameEditTreeView;
  for i := 0 to 5 do begin
    ETW.pnlColor[i].Panel.Color := $00CFC6C1;
    ETW.pnlColor[i].Panel.ColorMirror := $00C5BBB4;
    ETW.pnlColor[i].Panel.ColorMirrorTo := $00ECECE5;
    ETW.pnlColor[i].Panel.ColorTo := $00C5BBB4;
  end;
end;



end.



