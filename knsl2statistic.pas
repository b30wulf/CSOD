unit knsl2statistic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, Grids, BaseGrid, AdvGrid, ComCtrls, ToolWin, StdCtrls, jpeg,
  ExtCtrls,utldatabase,utltypes,utlbox,knsl5tracer,knsl5config, AdvToolBar,
  AdvPanel, AdvToolBarStylers, AdvAppStyler,utlconst, AdvOfficeButtons;

type
  CObjectObserve = class;
  TTL2Statistic = class(TForm)
    ImageList1: TImageList;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    lbGenSettings: TLabel;
    Label2: TLabel;
    FsgGrid: TAdvStringGrid;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarButton1: TAdvToolBarButton;
    AdvToolBarButton2: TAdvToolBarButton;
    AdvToolBarButton3: TAdvToolBarButton;
    AdvToolBarButton4: TAdvToolBarButton;
    Label5: TLabel;
    StatisticaStyler: TAdvFormStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvPanelStyler1: TAdvPanelStyler;
    cbm_RemCommand: TAdvOfficeCheckBox;
    procedure OnFormResize(Sender: TObject);
    procedure OnResetCounter(Sender: TObject);
    procedure OnResetTime(Sender: TObject);
    procedure OnStopAll(Sender: TObject);
    procedure OnGo(Sender: TObject);
    procedure OnGetColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnFormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OnSetRemState(Sender: TObject);
  private
    { Private declarations }
    m_blEnable : Boolean;
    m_nCounter : Integer;
    m_nAmMeter : Integer;
    m_nObserver : array[0..MAX_METER] of CObjectObserve;
    FOnRemStat : Byte;
    m_nMsg     : CMessage;
    m_sIniTbl : SL2INITITAG;
    procedure SendStatistic;
    procedure StatPause;
    procedure StatGo;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    
    procedure SetGrid;
  public
    { Public declarations }
    procedure Init;
    procedure IntitObserver;
    procedure Run;
    function  GetIn(nMID:Integer):Longword;
    function  GetOut(nMID:Integer):Longword;
    function  GetInAll(nMID:Integer):Longword;
    function  GetOutAll(nMID:Integer):Longword;
    function  GetRej(nMID:Integer):Longword;
    function  GetTimeRout(nMID:Integer):Longword;
    procedure SetIn(nMID,nLen:Integer);
    procedure SetOut(nMID,nLen:Integer);
    procedure SetRej(nMID,nLen:Integer);
    procedure OnSetStat(var pDS:CMessageData);
    procedure SetRemState(var pDS:CMessageData);
    procedure ResetCounter;
    procedure LoResetCounter;
    procedure GetStatistic(var pMsg:CMessage);
    procedure Pause;
    procedure Go;
  Public
    property POnRemStat    : Byte           read FOnRemStat  write FOnRemStat;
  end;

  {
  FsgGrid.Cells[2,0]  := 'Качество ';
    FsgGrid.Cells[3,0]  := 'Передано';
    FsgGrid.Cells[4,0]  := 'Принято';
    FsgGrid.Cells[5,0]  := 'Повторов';
    FsgGrid.Cells[6,0]  := 'Частота';
    FsgGrid.Cells[7,0]  := 'Скорость';
    FsgGrid.Cells[8,0]  := 'Нагрузка';
  }
  CObjectObserve = class
  private
   m_nInSize  : Longword;
   m_nOutSize : Longword;
   m_nQuant   : LongWord;
   m_nPhSpeed : LongWord;
   m_nCounter : Longword;
   m_blEnable : Boolean;
  public
   m_nIn      : Longword;
   m_nOut     : Longword;
   m_nQuality : Single;
   m_nInAll   : Longword;
   m_nOutAll  : Longword;
   m_nRej     : Longword;
   m_nFreq    : Single;
   m_nSpeed   : Single;
   m_nPower   : Single;
   m_nTime    : LongWord;
  private
   procedure Init(nQuant,nPhSpeed:Longword);
   procedure Clear;
   procedure Reset;
   procedure Stop;
   procedure Go;
   procedure Run;
  public
   function  GetQuality:Single;
   procedure SetIn(nLen:Integer);
   procedure SetOut(nLen:Integer);
   procedure SetRej(nLen:Integer);

  End;
var
  TL2Statistic: TTL2Statistic;

implementation
procedure CObjectObserve.Init(nQuant,nPhSpeed:Longword);
Begin
    if nQuant=0   then nQuant := 10;
    if nPhSpeed=0 then nPhSpeed:= 9600;
    m_nQuant   := nQuant;
    m_nPhSpeed := nPhSpeed;
    m_nTime    := 0;
    m_blEnable := True;
    Reset;
End;
procedure CObjectObserve.Reset;
Begin
    m_nIn      := 0;
    m_nOut     := 0;
    m_nRej     := 0;
    m_nInSize  := 0;
    m_nOutSize := 0;
    m_nCounter := 0;
    m_nQuality := 0;
    m_nInAll   := 0;
    m_nOutAll  := 0;
    //m_nTime    := 0;
End;
procedure CObjectObserve.Clear;
Begin
    m_nIn      := 0;
    m_nOut     := 0;
    m_nInSize  := 0;
    m_nOutSize := 0;
End;
procedure CObjectObserve.Stop;
Begin
    m_blEnable := False;
End;
procedure CObjectObserve.Go;
Begin
    m_blEnable := True;
End;
procedure CObjectObserve.SetIn(nLen:Integer);
Begin
    if m_blEnable=True then
    Begin
     Inc(m_nIn);
     Inc(m_nInAll);
     m_nInSize := m_nInSize + nLen;
    End;
End;
procedure CObjectObserve.SetOut(nLen:Integer);
Begin
    if m_blEnable=True then
    Begin
     Inc(m_nOut);
     Inc(m_nOutAll);
     m_nOutSize := m_nOutSize + nLen;
    End;
End;
procedure CObjectObserve.SetRej(nLen:Integer);
Begin
    if m_blEnable=True then
    Begin
     Inc(m_nRej);
     m_nOutSize := m_nOutSize + nLen;
    End;
End;
function  CObjectObserve.GetQuality:Single;
Var
     nQuality : Single;
Begin
     if m_nOutAll=0 then m_nQuality := 0 else
     if m_nInAll>m_nOutAll then m_nInAll := m_nOutAll else
     nQuality := 100*m_nInAll/m_nOutAll;
     if nQuality>100 then nQuality := 100;
     Result := nQuality;
End;
procedure CObjectObserve.Run;
Var
    fIn,fOut,fQuant,fSpeed : Single;
Begin
    if m_blEnable=True then
    if (m_nCounter mod m_nQuant)=0 then
    Begin
     fIn        := m_nIn;
     fOut       := m_nOut;
     fQuant     := m_nQuant;
     fSpeed     := m_nPhSpeed;
     if m_nOut=0 then m_nQuality := 0 else
     if m_nIn>m_nOut then m_nIn := m_nOut else
     m_nQuality := 100*m_nIn/m_nOut;
     if m_nQuality>100 then m_nQuality := 100;
     m_nFreq    := (m_nIn+m_nOut)/fQuant;
     m_nSpeed   := (m_nInSize+m_nOutSize)/fQuant;
     m_nPower   := 100*(8*m_nSpeed)/fSpeed;
     m_nTime    := m_nTime + m_nQuant;
     Clear;
    End;
    Inc(m_nCounter);
End;

{$R *.DFM}
procedure TTL2Statistic.Init;
Begin
    FsgGrid.ColCount    := 10;
    FsgGrid.RowCount    := 2;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'Счетчик';
    FsgGrid.Cells[2,0]  := 'Q(%) ';
    FsgGrid.Cells[3,0]  := 'Tx';
    FsgGrid.Cells[4,0]  := 'Rx';
    FsgGrid.Cells[5,0]  := 'Rej';
    FsgGrid.Cells[6,0]  := 'F(msg/s)';
    FsgGrid.Cells[7,0]  := 'S(Byte/s)';
    FsgGrid.Cells[8,0]  := 'P(%)';
    FsgGrid.Cells[9,0]  := 'Time(s.)';
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 150;
    FOnRemStat          := 0; 
    //FsgGrid.ColWidths[2]:= 50;
    //FsgGrid.ColWidths[3]:= 400;
    m_nCF.m_nSetColor.PSgGridStatistic := @FSgGrid;
    m_nCF.m_nSetColor.PStatisticaStyler := @StatisticaStyler;
    m_nCF.m_nSetColor.SetAllStyle(m_nCF.StyleForm.ItemIndex{+1});
    OnFormResize(self);
    IntitObserver;
end;
procedure TTL2Statistic.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
    for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;

procedure TTL2Statistic.OnFormResize(Sender: TObject);
Var
    i : Integer;
Begin
    for i:=2 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(150)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-2));
End;
procedure TTL2Statistic.IntitObserver;
Var
    m_sl1Tbl  : SL1INITITAG;
    //m_sIniTbl : SL2INITITAG;
    i,nPort,nSpeed,nMID : Integer;
Begin
    try
    lbGenSettings.Caption := 'Наблюдение включено';
    if m_pDB.GetL1Table(m_sl1Tbl) then
    if m_pDB.GetMetersIniTable(m_sIniTbl)=True then
    Begin
     m_nAmMeter := m_sIniTbl.m_swAmMeter;
     //SetLength(m_nObserver,m_sIniTbl.m_swAmMeter);
     FsgGrid.RowCount :=  m_sIniTbl.m_swAmMeter+3;
     for i:=0 to m_sIniTbl.m_swAmMeter-1 do
     Begin
      nMID   := m_sIniTbl.m_sMeter[i].m_swMID;
      nPort  := m_sIniTbl.m_sMeter[i].m_sbyPortID;
      nSpeed := m_sl1Tbl.Items[nPort].m_sbySpeed;
      if m_nObserver[nMID]=Nil then m_nObserver[nMID] := CObjectObserve.Create;
      if nSpeed<=m_nSpeedList.Count-1 then
      m_nObserver[nMID].Init(5,StrToInt(m_nSpeedList.Strings[nSpeed]));
      FsgGrid.Cells[1,i+1] := m_sIniTbl.m_sMeter[i].m_schName;
      //FsgGrid.Cells[1,i+1] := m_sl1Tbl.Items[nPort].m_schName+':'+m_sIniTbl.m_sMeter[i].m_schName;
     End;
     SetGrid;
    End;
    except
     TraceER('(__)CL3MD::>Error In TTL2Statistic.IntitObserver!!!');
    end;
End;
{
   m_nQuality : Single;
   m_nInAll   : Longword;
   m_nOutAll  : Longword;
   m_nRej     : Longword;
   m_nFreq    : Single;
   m_nSpeed   : Single;
   m_nPower   : Single;
   m_nTime    : LongWord;
}
procedure TTL2Statistic.SetGrid;
Var
    i,nMID : Integer;
Begin
    for i:=0 to m_nAmMeter-1 do
    Begin
     nMID   := m_sIniTbl.m_sMeter[i].m_swMID;
     with m_nObserver[nMID] do
     Begin

      FsgGrid.Cells[0,i+1]  := IntToStr(i);
      //FsgGrid.Cells[1,i+1]  := 'Счетчик';
      FsgGrid.Cells[2,i+1]  := FloatToStrF(GetQuality,ffFixed,6,3);//'Качество ';
      FsgGrid.Cells[3,i+1]  := IntToStr(m_nOutAll);//'Передано';
      FsgGrid.Cells[4,i+1]  := IntToStr(m_nInAll);//'Принято';
      FsgGrid.Cells[5,i+1]  := IntToStr(m_nRej);//'Повторов';
      FsgGrid.Cells[6,i+1]  := FloatToStrF(m_nFreq,ffFixed,6,3);//'Частота';
      FsgGrid.Cells[7,i+1]  := FloatToStrF(m_nSpeed,ffFixed,6,3);//'Скорость';
      FsgGrid.Cells[8,i+1]  := FloatToStrF(m_nPower,ffFixed,6,3);//'Нагрузка';
      FsgGrid.Cells[9,i+1]  := IntToStr(m_nTime);//'Нагрузка';
      //Clear;
     End;
    End;
    if FOnRemStat=1 then SendStatistic;
    //SendStatistic;
End;
procedure TTL2Statistic.SendStatistic;
Var
    fQuality : Single;
    i,szOS,nMID   : Integer;
Begin
    szOS                := 32;
    m_nMsg.m_swLen      := 13+szOS*m_nAmMeter;
    if m_nMsg.m_swLen>sizeof(m_nMsg) then exit;
    m_nMsg.m_sbyFor     := DIR_LHTOLM3;
    m_nMsg.m_sbyType    := QL_STATS_RECC_REQ;
    m_nMsg.m_sbyInfo[0] := m_nAmMeter;
    for i:=0 to m_nAmMeter-1 do
    Begin
     nMID := m_sIniTbl.m_sMeter[i].m_swMID;
     Move(m_nObserver[nMID].m_nQuality,m_nMsg.m_sbyInfo[1+i*szOS],szOS);
    End;
    SendRemMsg(m_nMsg);
End;
procedure TTL2Statistic.GetStatistic(var pMsg:CMessage);
Var
    nAmMeter : Byte;
    i,szOS,nMID   : Integer;
Begin
    szOS     := 32;
    nAmMeter := pMsg.m_sbyInfo[0];
    if nAmMeter<=m_nAmMeter then
    for i:=0 to nAmMeter-1 do
    Begin
     nMID := m_sIniTbl.m_sMeter[i].m_swMID;
     if m_nObserver[nMID]<>Nil then
     Move(pMsg.m_sbyInfo[1+i*szOS],m_nObserver[nMID].m_nQuality,szOS);
    End;
    SetGrid;
End;
procedure TTL2Statistic.SetIn(nMID,nLen:Integer);
Begin
    if m_nObserver[nMID]<>Nil then
    m_nObserver[nMID].SetIn(nLen);
End;
procedure TTL2Statistic.SetOut(nMID,nLen:Integer);
Begin
    if m_nObserver[nMID]<>Nil then
    m_nObserver[nMID].SetOut(nLen);
End;
procedure TTL2Statistic.SetRej(nMID,nLen:Integer);
Begin
    if m_nObserver[nMID]<>Nil then
    m_nObserver[nMID].SetRej(nLen);
End;
function  TTL2Statistic.GetIn(nMID:Integer):Longword;
Begin
    Result := 0;
    if m_nObserver[nMID]<>Nil then
    Result := m_nObserver[nMID].m_nIn;
End;
function  TTL2Statistic.GetOut(nMID:Integer):Longword;
Begin
    Result := 0;
    if m_nObserver[nMID]<>Nil then
    Result := m_nObserver[nMID].m_nOut;
End;
function  TTL2Statistic.GetInAll(nMID:Integer):Longword;
Begin
    Result := 0;
    if m_nObserver[nMID]<>Nil then
    Result := m_nObserver[nMID].m_nInAll;
End;
function  TTL2Statistic.GetOutAll(nMID:Integer):Longword;
Begin
    Result := 0;
    if m_nObserver[nMID]<>Nil then
    Result := m_nObserver[nMID].m_nOutAll;
End;
function  TTL2Statistic.GetRej(nMID:Integer):Longword;
Begin
    Result := 0;
    if m_nObserver[nMID]<>Nil then
    Result := m_nObserver[nMID].m_nRej;
End;
function  TTL2Statistic.GetTimeRout(nMID:Integer):Longword;
Begin
    Result := 0;
    if m_nObserver[nMID]<>Nil then
    Result := m_nObserver[nMID].m_nTime;
End;

procedure TTL2Statistic.Run;
Var
    i,nMID : Integer;
Begin
    try
     if cbm_RemCommand.Checked=False then
     Begin
      {for i:=0 to m_nAmMeter-1 do
      Begin
       nMID := m_sIniTbl.m_sMeter[i].m_swMID;
       if m_nObserver[nMID]<>Nil then m_nObserver[nMID].Run;
      End;
      if (m_nCounter mod 3)=0 then SetGrid;
      Inc(m_nCounter);
      }
     End;
    except
     TraceER('(__)CL2ST::>Error In TTL2Statistic.Run!!!');
    End;
End;
procedure TTL2Statistic.OnResetCounter(Sender: TObject);
Var
    pDS : CMessageData;
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_CLER_STDT,0);
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RESCT_RMST_REQ,pDS);
end;
procedure TTL2Statistic.ResetCounter;
Var
    i,nMID : Integer;
begin
    for i:=0 to m_nAmMeter-1 do
    Begin
     nMID := m_sIniTbl.m_sMeter[i].m_swMID;
     if m_nObserver[nMID]<>Nil then
     m_nObserver[nMID].Reset;
    End;
    SetGrid;
end;
procedure TTL2Statistic.LoResetCounter;
Var
    i,nMID : Integer;
begin
    for i:=0 to m_nAmMeter-1 do
    Begin
     nMID := m_sIniTbl.m_sMeter[i].m_swMID;
     if m_nObserver[nMID]<>Nil then
     Begin
     m_nObserver[nMID].m_nIn  := 0;
     m_nObserver[nMID].m_nOut := 0;
     //m_nObserver[i].m_nRej    := 0;
     End;
    End;
    SetGrid;
end;

procedure TTL2Statistic.OnResetTime(Sender: TObject);
Var
    i,nMID : Integer;
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_CLER_STTM,0);
    for i:=0 to m_nAmMeter-1 do
    Begin
     nMID := m_sIniTbl.m_sMeter[i].m_swMID;
     if m_nObserver[nMID]<>Nil then
     m_nObserver[nMID].m_nTime := 0;
    End;
    SetGrid;
end;
procedure TTL2Statistic.Pause;
Var
    i,nMID : Integer;
begin
    for i:=0 to m_nAmMeter-1 do
    Begin
     nMID := m_sIniTbl.m_sMeter[i].m_swMID;
     if m_nObserver[nMID]<>Nil then
     m_nObserver[nMID].m_nQuant := $FFFFFFFF;
    End;
end;
procedure TTL2Statistic.Go;
Var
    i,nMID : Integer;
begin
    for i:=0 to m_nAmMeter-1 do
    Begin
     nMID := m_sIniTbl.m_sMeter[i].m_swMID;
     if m_nObserver[nMID]<>Nil then
     m_nObserver[nMID].m_nQuant := 5;
    End;
end;
procedure TTL2Statistic.OnStopAll(Sender: TObject);
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_STOP_STAT,0);
    StatPause;
end;
procedure TTL2Statistic.OnGo(Sender: TObject);
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_STRT_STAT,0);
    StatGo
end;
procedure TTL2Statistic.OnSetStat(var pDS:CMessageData);
Var
    i,nMID   : Integer;
Begin
    if pDS.m_swData0=0 then
    Begin
    for i:=0 to m_nAmMeter-1 do
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if m_nObserver[nMID]<>Nil then m_nObserver[nMID].Stop;
      lbGenSettings.Caption := 'Наблюдение выключено';
     End;
    End;

    if pDS.m_swData0=1 then
    Begin
     for i:=0 to m_nAmMeter-1 do
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if m_nObserver[nMID]<>Nil then m_nObserver[nMID].Go;
      lbGenSettings.Caption := 'Наблюдение включено';
     End;
    End;
End;
procedure TTL2Statistic.StatPause;
Var
    pDS : CMessageData;
Begin
    pDS.m_swData0 := 0;
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_OPCLS_RMST_REQ,pDS);
End;
procedure TTL2Statistic.StatGo;
Var
    pDS : CMessageData;
Begin
    pDS.m_swData0 := 1;
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_OPCLS_RMST_REQ,pDS);
End;
procedure TTL2Statistic.OnGetColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
   with (Sender AS TAdvStringGrid)  do
    Begin
     if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and (not(gdSelected in AState) or (gdFocused in AState)) then
     begin
     // if (ACol<>0)and(ARow<>0) then ABrush.Color := clTeal;
     end;
    if (ARow=0)or(ACol=0) then
    Begin
     AFont.Size  := 8;
     AFont.Style := [fsBold];
     AFont.Color := clBlack;
    End;
     if (ARow<>0) and (ACol<>0)then
      Begin
       AFont.Color :=  m_blGridDataFontColor;
       AFont.Size  :=  m_blGridDataFontSize;
       AFont.Name  :=  m_blGridDataFontName;
        case ACol of
         1      : Begin {AFont.Style := [fsBold];}AFont.Color := clBlack{clAqua};End;
         2      : AFont.Color := clBlack;//clWhite;
         3,4    : AFont.Color := clBlack;//clLime;
         5      : AFont.Color := clRed;
         6,7,8  : AFont.Color := clBlack;//clYellow;
         9      : Begin {AFont.Style := [fsBold];}AFont.Color :=clBlack; {clAqua;}End;
        End;
      End;
    End;
end;
procedure TTL2Statistic.OnFormCreate(Sender: TObject);
begin
    TL2Statistic := self;

end;

procedure TTL2Statistic.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   m_nCF.m_nSetColor.PStatisticaStyler := nil;
//   m_pDB.FixUspdDescEvent(0,3,EVS_CLOS_STAT,0);
end;


procedure TTL2Statistic.OnSetRemState(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if cbm_RemCommand.Checked=False then begin
      pDS.m_swData0 := 0;
//      m_pDB.FixUspdDescEvent(0,3,EVS_STOP_RSTAT,0);
    end else
    if cbm_RemCommand.Checked=True  then begin
      pDS.m_swData0 := 1;
//      m_pDB.FixUspdDescEvent(0,3,EVS_STRT_RSTAT,0);
    end;
    //FOnRemStat    := pDS.m_swData0;
    pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_STPRS_RMST_REQ,pDS);
end;
procedure TTL2Statistic.SetRemState(var pDS:CMessageData);
Begin
    FOnRemStat := pDS.m_swData0;
End;
end.
