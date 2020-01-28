unit Knsl5Meter_Replace;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, AdvProgressBar,knsl3housegen,utltypes, GradientLabel,utldynconnect,utldatabase,
  ExtCtrls, AdvSmoothButton;

type
  TMeter_Replace = class(TForm)
    Panel1: TPanel;
    Progress_Meter_Replace: TAdvProgressBar;
    GradientLabel3: TGradientLabel;
    Label7: TLabel;
    GradientLabel1: TGradientLabel;
    cmbPull: TComboBox;
    OpenDialog1: TOpenDialog;
    importHouse: TAdvSmoothButton;

    procedure FormShow(Sender: TObject);
    procedure setCmbPull;
    procedure ReplaceHouseClick(Sender: TObject);
  private
     m_treeID      : CTreeIndex;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Meter_Replace: TMeter_Replace;

implementation

{$R *.DFM}


procedure TMeter_Replace.FormShow(Sender: TObject);
begin
// TAbonManager.Ppbm_sBTIProgressImport_Meter := Progress_Meter_Replace;
//setCmbPull;
end;

procedure TMeter_Replace.setCmbPull;
Var
    pDb        : CDBDynamicConn;
    pullConfig : TThreadList;
    vList      : TList;
    pl         : CL2Pulls;
    i          : integer;
begin
    pDb  := m_pDB.getConnection;
    pullConfig := TThreadList.Create;
    pDb.getPulls(pullConfig);
    vList := pullConfig.LockList;
    cmbPull.Items.Clear;
    for i:=0 to vList.count-1 do
    Begin
     pl := vList[i];
     cmbPull.Items.Add('['+IntToStr(pl.id)+']'+pl.PULLTYPE+'/'+pl.DESCRIPTION);
    End;
    if cmbPull.Items.Count>0 then cmbPull.ItemIndex := 0;
    pullConfig.UnLockList;
    m_pDB.DiscDynConnect(pDb);
    ClearListAndFree(pullConfig);
end;


procedure TMeter_Replace.ReplaceHouseClick(Sender: TObject);
Var
     m_nHouseGen : CHouseGen;
begin
     OpenDialog1.Filter := 'Text files (*.csv)|*.csv;*.*';
     if OpenDialog1.Execute then
     if FileExists(OpenDialog1.FileName) then
     begin
       m_nHouseGen := CHouseGen.Create;
       m_nHouseGen.Ppbm_sBTIProg_Meter_Rep := Progress_Meter_Replace;
       m_nHouseGen.loadReplacementHouse(cmbPull.ItemIndex,m_treeID,OpenDialog1.FileName);
       m_nHouseGen.InitTreeRef; //Автообновление дерева
       m_nHouseGen.Destroy;//протестировать
     end
end;


end.
