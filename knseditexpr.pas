unit knseditexpr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RbDrawCore, RbButton, ExtCtrls, Spin, StdCtrls, ComCtrls, jpeg, Buttons,
  Grids, BaseGrid, AdvGrid, Db, ADODB, utldatabase, utlconst, utltypes,utlbox,knsl5config,
  AdvPanel, AdvAppStyler, IdBaseComponent, IdComponent, IdRawBase,
  IdRawClient, IdIcmpClient, IBCustomDataSet, IBTable;

type
  TfrmEditExpr = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    clbEditNode: TLabel;
    Label1: TLabel;
    AdvPanel2: TAdvPanel;
    RBGenerate: TRbButton;
    RbButton4: TRbButton;
    RbButton1: TRbButton;
    RbButton2: TRbButton;
    AdvPanel3: TAdvPanel;
    Label4: TLabel;
    e_expr: TEdit;
    RbButton3: TRbButton;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    chb_GenAllParams: TCheckBox;
    chb_dir: TCheckBox;
    chb_GrCounter: TCheckBox;
    chb_SGrCounter: TCheckBox;
    chb_partype: TCheckBox;
    LFormula: TLabel;
    Label7: TLabel;
    sg_Params: TAdvStringGrid;
    cb_dir: TComboBox;
    cb_abonent: TComboBox;
    cb_partype: TComboBox;
    E_formula: TEdit;
    bt_sumbyall: TRbButton;
    RbButton5: TRbButton;
    AdvPanelStyler1: TAdvPanelStyler;
    RedactorStyler: TAdvFormStyler;
    IdIcmpClient1: TIdIcmpClient;
    procedure chb_GrCounterClick(Sender: TObject);
    procedure RbButton2Click(Sender: TObject);
    procedure RbButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure k(Sender: TObject);
    procedure cb_Change(Sender: TObject);
    procedure RbButton3Click(Sender: TObject);
    procedure sg_ParamsDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure sg_ParamsClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormCreate(Sender: TObject);
    procedure OnSummAll(Sender: TObject);
    procedure OnChVmid(Sender: TObject);
    procedure OnChPrid(Sender: TObject);
    procedure OnClear(Sender: TObject);
    procedure OnSummAll1(Sender: TObject);
    procedure OnComa(Sender: TObject);
    procedure OnSet0(Sender: TObject);
    procedure OnSet1(Sender: TObject);
    procedure OnSet2(Sender: TObject);
    procedure OnSet3(Sender: TObject);
    procedure OnSet4(Sender: TObject);
    procedure OnSet5(Sender: TObject);
    procedure OnSet6(Sender: TObject);
    procedure OnSet7(Sender: TObject);
    procedure OnSet8(Sender: TObject);
    procedure OnSet9(Sender: TObject);
    procedure OnSetLimit(Sender: TObject);
    procedure OnGenerateLim(Sender: TObject);
    procedure OnGenMLimit(Sender: TObject);
    procedure OnSuperGroup(Sender: TObject);
    procedure OnReplaceFormula(Sender: TObject);
    procedure OnSummAllGE(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
     nY : Integer;
     pIT : SL3INITTAG;
     pGT : SL3GROUPTAG;
     pMT : SL3VMETERTAG;
     m_nGrList : TList;
     m_nMtList : TList;
     m_nPrList : TList;
     m_nMeterType  : integer;
     nG,nM,nP      : integer;
     nG1,nM1,nP1   : integer;
     m_byGID   : array[0..MAX_GROUP]  of SmallInt;
     m_byMID   : array[0..MAX_METER] of SmallInt;
     m_byPID   : array[0..100]  of SmallInt;
     FPPFGrid  : PTAdvStringGrid;
     FPParam    : PSL3VMETERTAG;
     FPPFGridGe: PTAdvStringGrid;
     glblOnClickfrom:boolean;
     function  GetGroup(nVMID:Integer):String;
     function  GetName(nVMID:Integer):String;
     procedure SetGroupList(var pT:SL3INITTAG);
     procedure SetMeterList(var pT:SL3GROUPTAG);
     procedure SetParamList(var pT:SL3VMETERTAG);
     procedure AddRecordToGrid(pTbl:PSL3PARAMS);
     procedure FillParamTypesList;
     procedure FillAll(_Abon,_Group,_VMID,_ParamType : Integer);
     procedure SelectRow;
     procedure MLimilGenerator;
     function  CreateMLimit(nVMID:Integer;sValue:String):String;
     function  CreateLimit(nVMID:Integer;sValue:String):String;
     function  IsPower30(pParam:Integer):Boolean;
     function  Replace(Str, X, Y: string): string;
  public
    m_forAbon,
    m_forGroup,
    m_forVMID,
    m_forParam,m_nGenIndex  : Integer;
    m_forCurrExpr : String;
    m_forCurrShExpr : String;
    m_forRunExpr : String;
   public
     procedure SetParent(pGrid:PTAdvStringGrid;pParam:PSL3VMETERTAG;blOnClickfrom:boolean);
     procedure SetParentGe(geGrid:PTAdvStringGrid;blOnClickfrom:boolean);
  end;
var
  frmEditExpr: TfrmEditExpr;

implementation

{$R *.DFM}
procedure TfrmEditExpr.SetParent(pGrid:PTAdvStringGrid;pParam:PSL3VMETERTAG;blOnClickfrom:boolean);
Begin
     glblOnClickfrom := blOnClickfrom;
     FPPFGrid := pGrid;
     FPParam  := pParam;
End;

procedure TfrmEditExpr.SetParentGe(geGrid:PTAdvStringGrid;blOnClickfrom:boolean);
Begin
     glblOnClickfrom := blOnClickfrom;
     FPPFGridGe := geGrid;
//     FPParam  := pParam;
End;

procedure TfrmEditExpr.FormShow(Sender: TObject);
begin
    frmEditExpr := self;
    m_nGrList := TList.Create;
    m_nMtList := TList.Create;
    m_nPrList := TList.Create;
    sg_Params.Cells[0,0]  := '№/T';
    sg_Params.Cells[1,0]  := '№ параметра';
    sg_Params.Cells[2,0]  := '№ вирт. счетчика';
    sg_Params.Cells[3,0]  := 'Группа';
    sg_Params.Cells[4,0]  := 'Абонент';
    sg_Params.Cells[5,0]  := 'Параметр';
    sg_Params.Cells[6,0]  := 'Выражение';
    m_forRunExpr := m_forCurrExpr; 
    m_nMeterType := -1;
    sg_Params.EditMode := false;
    m_pDB.GetAbonVMetersTable(m_forAbon,-1,pGT);
    FillParamTypesList;
    if (m_forGroup < 0) then
    begin
     m_forGroup := -1;
     chb_dir.Enabled := false;
    end;
    nP1 := m_forParam+1;
    cb_partype.ItemIndex := nP1;
    e_expr.Text          := m_forCurrExpr;
    e_formula.Text       := m_pDB.GetMSGROUPEXPRESS(m_forAbon,m_forGroup,pGT);
    //FPPFGrid.Options     := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing];
    FillAll(m_forAbon,m_forGroup,m_forVMID,m_forParam);
    chb_GrCounterClick(self);

    m_nCF.m_nSetColor.PRedactorStyler := @RedactorStyler;
    m_nCF.m_nSetColor.SetAllStyle(m_nCF.StyleForm.ItemIndex{+1});
end;

procedure TfrmEditExpr.FillAll(_Abon,_Group,_VMID,_ParamType : Integer);
var
    grC,  // счетчик групп
    abC,  // счетчик абонентов
    parC,  // счетчик параметров
    i : integer;
begin
    sg_Params.ClearNormalCells;
    sg_Params.RowCount := 2;

    //if m_pDB.GetGroupsTable(pIT)=True then
    if m_pDB.GetAbonGroupsTable(m_forAbon,pIT)=True then
    Begin
     nG := _Group;
     nM := _VMID;
     SetGroupList(pIT);
     if m_pDB.GetVMetersTypeTable(nG,m_nMeterType,pGT)=true then
     Begin
      SetMeterList(pGT);
      if m_pDB.GetVParamsGrTable(m_forAbon,nG,nM,m_nMeterType,pMT)=true then
      Begin
       SetParamList(pMT);
      End;
     End;
    End;
end;
procedure TfrmEditExpr.SetGroupList(var pT:SL3INITTAG);
Var
    i : Integer;
Begin
    cb_dir.Items.Clear;
    cb_dir.Items.Add('Все');
    m_byGID[0]       := -1;
    cb_dir.ItemIndex := 0;
    for i:=0 to pT.Count-1 do
    Begin
     m_byGID[i+1] := pT.Items[i].m_sbyGroupID;
     cb_dir.Items.Add(pT.Items[i].m_sGroupName);
     if pT.Items[i].m_sbyGroupID=nG then cb_dir.ItemIndex := i+1;
    End;
End;
procedure TfrmEditExpr.SetMeterList(var pT:SL3GROUPTAG);
Var
    i : Integer;
Begin
    cb_abonent.Items.Clear;
    cb_abonent.Items.Add('Все');
    m_byMID[0] := -1;
    cb_abonent.ItemIndex := 0;
    for i:=0 to pT.m_swAmVMeter-1 do
    Begin
     m_byMID[i+1] := pT.Item.Items[i].m_swVMID;
     cb_abonent.Items.Add(pT.Item.Items[i].m_sVMeterName);
     if pT.Item.Items[i].m_swVMID=nM then cb_abonent.ItemIndex := i+1;
    End;
End;
procedure TfrmEditExpr.SetParamList(var pT:SL3VMETERTAG);
Var
    i : Integer;
Begin

    sg_Params.ClearNormalCells;
    sg_Params.RowCount := 2;
    nY := 0;
    for i:=0 to pT.m_swAmParams-1 do
    Begin

     if nP1=0 then AddRecordToGrid(@pT.Item.Items[i]) else
     Begin
      if (nP1-1)=pT.Item.Items[i].m_swParamID then
      AddRecordToGrid(@pT.Item.Items[i])
     End;
    End;
End;
procedure TfrmEditExpr.FillParamTypesList;
var
     pPar : QM_PARAMS;
     parC : integer;
begin
    cb_partype.Items.Clear;
    cb_partype.Items.Add('Все');
    if (m_pDB.GetParamsTypeTable(pPar) = true) then
    begin
     for parC:=0 to pPar.Count-1 do
     begin
      cb_partype.Items.Add(pPar.Items[parC].m_sName + '   ' + pPar.Items[parC].m_sEMet);
     end;
      cb_partype.ItemIndex := 0;
    end;
end;
procedure TfrmEditExpr.chb_GrCounterClick(Sender: TObject);
begin
    if chb_GrCounter.Checked=True  then
    Begin
     m_nMeterType := MET_SUMM;
     RbButton5.Enabled := False;
    End else
    if chb_GrCounter.Checked=False then
    Begin
     m_nMeterType := -1;
     RbButton5.Enabled := True;
    End;
    nG := -1;
    nM := -1;
    FillAll(m_forAbon,nG,nM,nP);
end;
procedure TfrmEditExpr.OnSuperGroup(Sender: TObject);
begin
    if chb_SGrCounter.Checked=True  then
    Begin
     m_nMeterType := MET_GSUMM;
     RbButton5.Enabled := False;
    End else
    if chb_SGrCounter.Checked=False then
    Begin
     m_nMeterType := -1;
     RbButton5.Enabled := True;
    End;
    nG := -1;
    nM := -1;
    FillAll(m_forAbon,nG,nM,nP);
end;
procedure TfrmEditExpr.RbButton2Click(Sender: TObject);
begin
    self.ModalResult := mrCancel;
end;
procedure TfrmEditExpr.RbButton1Click(Sender: TObject);
begin
    if chb_GenAllParams.Checked=False then
    Begin
     if e_expr.Text='' then
     Begin
      if MessageDlg('Сохранить пустое выражение?',mtWarning,[mbOk,mbCancel],0)=mrOk then
      m_forRunExpr := e_expr.Text else m_forRunExpr := m_forCurrExpr;
     End else m_forRunExpr := e_expr.Text;
     e_formula.Text := e_expr.Text;
    End;

    self.ModalResult := mrOk;
    FPPFGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goEditing];
end;
procedure TfrmEditExpr.SpeedButton13Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + m_forCurrExpr;
end;
procedure TfrmEditExpr.SpeedButton1Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + ' + ';
end;
procedure TfrmEditExpr.SpeedButton2Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + ' - ';
end;
procedure TfrmEditExpr.SpeedButton3Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + ' / ';
end;
procedure TfrmEditExpr.SpeedButton4Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + ' * ';
end;
procedure TfrmEditExpr.SpeedButton11Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + ' ^ ';
end;
procedure TfrmEditExpr.SpeedButton12Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + 'exp(';
end;
procedure TfrmEditExpr.SpeedButton5Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + 'sin(';
end;
procedure TfrmEditExpr.SpeedButton6Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + 'cos(';
end;
procedure TfrmEditExpr.SpeedButton7Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + 'tg(';
end;
procedure TfrmEditExpr.SpeedButton8Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + 'ctg(';
end;
procedure TfrmEditExpr.OnSetLimit(Sender: TObject);
begin
     e_expr.Text := e_expr.Text + 'Lim';
end;
procedure TfrmEditExpr.SpeedButton9Click(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '(';
end;
procedure TfrmEditExpr.k(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + ')';
end;
procedure TfrmEditExpr.OnComa(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '.';
end;
procedure TfrmEditExpr.OnSet0(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '0';
end;
procedure TfrmEditExpr.OnSet1(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '1';
end;
procedure TfrmEditExpr.OnSet2(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '2';
end;
procedure TfrmEditExpr.OnSet3(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '3';
end;
procedure TfrmEditExpr.OnSet4(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '4';
end;
procedure TfrmEditExpr.OnSet5(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '5';
end;
procedure TfrmEditExpr.OnSet6(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '6';
end;
procedure TfrmEditExpr.OnSet7(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '7';
end;
procedure TfrmEditExpr.OnSet8(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '8';
end;
procedure TfrmEditExpr.OnSet9(Sender: TObject);
begin
    e_expr.Text := e_expr.Text + '9';
end;
procedure TfrmEditExpr.cb_Change(Sender: TObject);
begin
    nG  := m_byGID[cb_dir.ItemIndex];
    nM  := -1;
    nP1 := cb_partype.ItemIndex;
    FillAll(m_forAbon,nG,nM,nP);
end;
procedure TfrmEditExpr.OnChVmid(Sender: TObject);
begin
    nG  := m_byGID[cb_dir.ItemIndex];
    nM  := m_byMID[cb_abonent.ItemIndex];
    nP1 := cb_partype.ItemIndex;
    FillAll(m_forAbon,nG,nM,nP);
    //SelectRow;
    //sg_Params.SelectRows(ARow, 1);
end;
procedure TfrmEditExpr.SelectRow;
Var
    i : Integer;
Begin
    for i:=1 to sg_Params.RowCount-1 do
    Begin
     if nP1>0 then
     if (nP1-1)=StrToInt(sg_Params.Cells[1,i]) then
     Begin
      sg_Params.SelectRows(i, 1);
      Exit;
     End;
    End;
End;
procedure TfrmEditExpr.OnChPrid(Sender: TObject);
begin
    nP1 := cb_partype.ItemIndex;
    SetParamList(pMT);
end;
procedure TfrmEditExpr.AddRecordToGrid(pTbl:PSL3PARAMS);
Var
    nVMID : Integer;
Begin
    nY := nY+1;
    sg_Params.RowCount := sg_Params.RowCount + 1;
    nVMID := pTbl.m_swVMID;
    with pTbl^ do Begin
     sg_Params.Cells[0,nY]  := IntToStr(nY);
     sg_Params.Cells[1,nY]  := IntToStr(m_swParamID);
     sg_Params.Cells[2,nY]  := IntToStr(m_swVMID);
     sg_Params.Cells[3,nY]  := GetGroup(nVMID);
     sg_Params.Cells[4,nY]  := GetName(nVMID);
     sg_Params.Cells[5,nY]  := m_sParam;
     sg_Params.Cells[6,nY]  := m_sParamExpress;
    End;
End;
function TfrmEditExpr.GetName(nVMID:Integer):String;
Var
    i : Integer;
Begin
    Result := 'Not Found!';
    for i:=0 to pGT.m_swAmVMeter-1 do
    if pGT.Item.Items[i].m_swVMID=nVMID then
    Result := pGT.Item.Items[i].m_sVMeterName;
End;
function TfrmEditExpr.GetGroup(nVMID:Integer):String;
Var
    i,j : Integer;
Begin
    Result := '';
    for i:=0 to pGT.m_swAmVMeter-1 do
    if pGT.Item.Items[i].m_swVMID=nVMID then
    Begin
     for j:=0 to pIT.Count-1 do
     if pGT.Item.Items[i].m_sbyGroupID=pIT.Items[j].m_sbyGroupID then
     Begin
      Result := pIT.Items[j].m_sGroupName;
      exit;
     End;
    End;
End;
procedure TfrmEditExpr.RbButton3Click(Sender: TObject);
begin
    ShowMessage('EditExpr :>> Unrealized');
end;
procedure TfrmEditExpr.sg_ParamsDblClickCell(Sender: TObject; ARow,
    ACol: Integer);
var
str :string[40];
begin
    if glblOnClickfrom = false then
    begin
    if m_nMeterType=-1       then e_expr.Text := e_expr.Text + sg_Params.Cells[6, ARow] else
    if (m_nMeterType=MET_SUMM)or(m_nMeterType=MET_GSUMM) then e_expr.Text := e_expr.Text + 'v'+sg_Params.Cells[2, ARow]+'_'+sg_Params.Cells[5, ARow];
    end
    else
    begin
      if m_nMeterType=-1       then   e_expr.Text := e_expr.Text + 'v'+sg_Params.Cells[2, ARow]+'_P'
      else
      if (m_nMeterType=MET_SUMM)or(m_nMeterType=MET_GSUMM) then e_expr.Text := e_expr.Text + 'v'+sg_Params.Cells[2, ARow]+'_P';
    end;

end;
procedure TfrmEditExpr.sg_ParamsClickCell(Sender: TObject; ARow, ACol: Integer);
begin
    sg_Params.SelectRows(ARow, 1);
    m_nGenIndex := StrToInt(sg_Params.Cells[2,ARow]);
end;
procedure TfrmEditExpr.FormCreate(Sender: TObject);
begin
    m_forGroup:= -1;
    nY := 0;
end;
procedure TfrmEditExpr.OnSummAll(Sender: TObject);
Var
    i : Integer;
begin
 if glblOnClickfrom = false then
   begin
     e_expr.Text := e_expr.Text+'(';
     if m_nMeterType=-1 then
     Begin
      for i:=1 to sg_Params.RowCount-2 do
      Begin
       if i=1 then e_expr.Text := e_expr.Text + sg_Params.Cells[6, i] else
       e_expr.Text := e_expr.Text + ' + ' +sg_Params.Cells[6, i];
      End
     End else
     if m_nMeterType=MET_SUMM then
     Begin
      for i:=1 to sg_Params.RowCount-2 do
      Begin
       if i=1 then e_expr.Text := e_expr.Text+'v'+sg_Params.Cells[2, i]+'_'+sg_Params.Cells[5, i] else
       e_expr.Text := e_expr.Text+' + '+'v'+sg_Params.Cells[2, i]+'_'+sg_Params.Cells[5, i];
      End
     End;
     e_expr.Text := e_expr.Text+')';
     end
     else
     OnSummAllGE(Sender);
end;

procedure TfrmEditExpr.OnSummAllGE(Sender: TObject);
Var
    i : Integer;
    strSign : String;
begin
    strSign := ' + ';
    if e_expr.Text='Lim' then strSign := ',';
    e_expr.Text := e_expr.Text+'(';
    for i:=1 to sg_Params.RowCount-2 do
    Begin
     if i=1 then e_expr.Text := e_expr.Text+'v'+sg_Params.Cells[2, i]+'_P' else
     e_expr.Text := e_expr.Text + strSign + 'v'+sg_Params.Cells[2, i]+'_P';
    End;
    e_expr.Text := e_expr.Text+')';
    E_formula.Text := e_expr.Text;
    glblOnClickfrom := true;
end;

procedure TfrmEditExpr.OnClear(Sender: TObject);
begin
     e_expr.Text := '';
     E_formula.Text   := '';  
end;
procedure TfrmEditExpr.OnSummAll1(Sender: TObject);
Var
    i : Integer;
begin
if glblOnClickfrom = false then
   begin 
     e_expr.Text := '';
     e_expr.Text := e_expr.Text+'(';
     for i:=1 to sg_Params.RowCount-3 do
     Begin
      if i=1 then e_expr.Text := e_expr.Text + sg_Params.Cells[6, i] else
                  e_expr.Text := e_expr.Text + ' + ' +sg_Params.Cells[6, i];
     End;
     e_expr.Text := e_expr.Text+')';
     end
     else
     OnSummAllGE(Sender);
     
end;
procedure TfrmEditExpr.OnGenerateLim(Sender: TObject);
Var
     strV : String;
begin      //m_forCurrShExpr
     strV := 'Lim('+
     '(2*v'+IntToStr(m_nGenIndex)+'_'+m_forCurrShExpr+'),'+
     '(2*v'+IntToStr(m_nGenIndex+1)+'_'+m_forCurrShExpr+'),'+
     FloatToStr(m_nCF.GetPowLim)+','+
     FloatToStr(m_nCF.GetPowPrc)+')';
     e_expr.Text := strV;
end;

procedure TfrmEditExpr.OnGenMLimit(Sender: TObject);
begin
    if chb_GenAllParams.Checked=False then
     e_expr.Text := CreateMLimit(m_nGenIndex,m_forCurrShExpr)
    else
     MLimilGenerator;
end;
procedure TfrmEditExpr.MLimilGenerator;
Var
     i,nVMID : Integer;
     sVal,sT : String;
Begin
     for i:=0 to FPParam.m_swAmParams-1 do
     Begin
      nVMID := m_nGenIndex;
      sVal  := FPParam.Item.Items[i].m_sParam;
      if IsPower30(FPParam.Item.Items[i].m_swParamID)=False then
       sT := CreateMLimit(nVMID,sVal)
      else
       sT := CreateLimit(nVMID,sVal);
      FPPFGrid.Cells[4,i+1] := sT;
      if FPParam.Item.Items[i].m_swParamID=m_forParam then
       m_forRunExpr := sT;
     End;
End;
function TfrmEditExpr.CreateLimit(nVMID:Integer;sValue:String):String;
Begin
     Result := 'Lim('+
               'v'+IntToStr(nVMID)+'_'+sValue+','+
               'v'+IntToStr(nVMID+1)+'_'+sValue+')';
               //FloatToStr(m_nCF.GetPowLim)+','+
               //FloatToStr(m_nCF.GetPowPrc)+')';
End;
function TfrmEditExpr.CreateMLimit(nVMID:Integer;sValue:String):String;
Begin
     Result := 'MLim('+
               'v'+IntToStr(nVMID)+'_'+sValue+','+
               'v'+IntToStr(nVMID+1)+'_'+sValue+','+
               'v'+IntToStr(nVMID)+'_Pmgas,'+
               'v'+IntToStr(nVMID+1)+'_Pmgas)';
               //FloatToStr(m_nCF.GetPowLim)+','+
               //FloatToStr(m_nCF.GetPowPrc)+')';
End;
function TfrmEditExpr.IsPower30(pParam:Integer):Boolean;
Begin
      case pParam of
       QRY_SRES_ENR_EP,
       QRY_SRES_ENR_EM,
       QRY_SRES_ENR_RP,
       QRY_SRES_ENR_RM : Result := True;
      else
       Result := False;
      End;
End;


function TfrmEditExpr.Replace(Str, X, Y: string): string;
var
  buf1, buf2, buffer: string;
  i: Integer;

begin
  buf1 := '';
  buf2 := Str;
  Buffer := Str;

  while Pos(X, buf2) > 0 do
  begin
    buf2 := Copy(buf2, Pos(X, buf2), (Length(buf2) - Pos(X, buf2)) + 1);
    buf1 := Copy(Buffer, 1, Length(Buffer) - Length(buf2)) + Y;
    Delete(buf2, Pos(X, buf2), Length(X));
    Buffer := buf1 + buf2;
  end;

  Replace := Buffer;
end;

procedure TfrmEditExpr.OnReplaceFormula(Sender: TObject);
var
 strV,strE : String;
 i:integer;
begin
 if   e_formula.Text <> '[x]' then
 begin
  m_forRunExpr := '';
 if chb_GenAllParams.Checked=False then
    Begin
     if e_expr.Text='' then
     Begin
      if MessageDlg('Сохранить пустое выражение?',mtWarning,[mbOk,mbCancel],0)=mrOk then
      m_forRunExpr := e_expr.Text else m_forRunExpr := m_forCurrExpr;
     End else
     begin
      for i:=0 to FPParam.m_swAmParams-1 do
      begin
          strE  := e_formula.Text;
          strV := strV + replace(strE,'P',FPParam.Item.Items[i].m_sParam);
          FPPFGrid.Cells[4,i+1] :=  strV;
          strV:='';
       end;
    end;
  End;
    self.ModalResult := mrOk;
    end
else   MessageDlg('Неверная формула.',mtWarning,[mbOk],0);
 //   FPPFGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goEditing];
end;

procedure TfrmEditExpr.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   m_nCF.m_nSetColor.PRedactorStyler := nil;
end;

end.
