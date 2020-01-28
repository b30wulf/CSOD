unit knsl3RPSelfTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class,utldatabase,utldynconnect,utltypes,utlconst,utlbox;

type
  TTRpSelfTest = class(TForm)
    frRpselfTest: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frRpselfTestManualBuild(Page: TfrPage);
    procedure OnGerValue(const ParName: String; var ParValue: Variant);
 
  private
    { Private declarations }
    FDB        : PCDBDynamicConn;
    m_srpParam : REPORT_F1;
    m_pTstTbl  : STESTTAGS;
    Index      : Integer;
    IsFirstPage : Boolean;
    m_cPage    : TfrPage;
    m_rpTitle  : String;
    m_swTSTID  : String;
    m_sdtTestTime : String;
    m_strComment  : String;
    m_strDescription : String;
    m_strResult   : String;
  public
    { Public declarations }
    procedure ShowReport;
  private
    function FillReport(Page: TfrPage):Boolean;
  public
  property PDB : PCDBDynamicConn  read FDB  write FDB;
  end;

var
  TRpSelfTest: TTRpSelfTest;

implementation
{$R *.DFM}
procedure TTRpSelfTest.ShowReport;
Begin
     m_pDB.LoadReportParams(0,m_srpParam);
     m_srpParam.m_sWorkName   := ' ';
     m_srpParam.m_sNDogovor   := '№ 1';
     m_srpParam.m_sAdress     := ' ';
     m_srpParam.m_sNameObject := 'Сервер АСКУЭ';
     frRpselfTest.ShowReport;
End;
//frGomelReact.ShowReport;
{
    STESTTAG = packed record
     m_swID         : Integer;
     m_swTSTID      : Integer;
     m_swObjID      : Integer;
     m_sdtTestTime  : TDateTIme;
     m_strComment   : String[50];
     m_strDescription : String[20];
     m_strResult    : String[10];
    end;
REPORT_F1 = packed record
     m_swID          : integer;
     m_sWorkName     : string;
     m_sFirstSign    : string;
     m_sSecondSign   : string;
     m_sThirdSign    : string;
     m_sTelephon     : string;
     m_sEMail        : string;
     m_sNDogovor     : string;
     m_sAdress       : string;
     m_sNameObject   : string;
     m_sbyIsReadZerT : byte;
     m_swColorCol    : integer;
     m_swColorRow    : integer;
     ABO             : integer;
     KSP             : string;
    end;
}
procedure TTRpSelfTest.frRpselfTestManualBuild(Page: TfrPage);
begin
     m_rpTitle := 'Отчет тестирования системы : '+DateToStr(Now)+'.';
     IsFirstPage := False;
     if FillReport(Page)=True then
     Page.ShowBandByName('rpPageFooter');
end;
function TTRpSelfTest.FillReport(Page: TfrPage):Boolean;
Var
     i,j : Integer;
     res : Boolean;
Begin
     res := False;
     for i:=0 to TST_END-1 do
     if FDB.GetTestTypeTable(i,m_pTstTbl)=True then
     Begin
      res := True;
      m_swTSTID := m_nTestName.Strings[i];
      if (Page.CurY+64)>900 then page.NewPage;
      Page.ShowBandByName('MasterHeader1');
      for j:=0 to m_pTstTbl.Count-1 do
      Begin
       Index             := j+1;
       m_sdtTestTime     := TimeToStr(m_pTstTbl.Items[j].m_sdtTestTime);
       m_strComment      := m_pTstTbl.Items[j].m_strComment;
       m_strDescription  := m_pTstTbl.Items[j].m_strDescription;
       m_strResult       := m_pTstTbl.Items[j].m_strResult;
       m_cPage           := Page;
       Page.ShowBandByName('mdTestInfo');
       if (Page.CurY>900)and(i<>(TST_END-1))and(j<>(m_pTstTbl.Count-1)) then
       Begin
        page.NewPage;
        Page.ShowBandByName('MasterHeader1');
       End;
      end;
     end;
     Result := res;
end;
procedure TTRpSelfTest.OnGerValue(const ParName: String;
  var ParValue: Variant);
begin
     if ParName='Index'         then ParValue:=Index;
     if ParName='m_sWorkName'   then ParValue:=m_srpParam.m_sWorkName;
     if ParName='m_sFirstSign'  then ParValue:=m_srpParam.m_sFirstSign;
     if ParName='m_sSecondSign' then ParValue:=m_srpParam.m_sSecondSign;
     if ParName='m_sThirdSign'  then ParValue:=m_srpParam.m_sThirdSign;
     if ParName='m_sNDogovor'   then ParValue:=m_srpParam.m_sNDogovor;
     if ParName='m_sAdress'     then ParValue:=m_srpParam.m_sAdress;
     if ParName='m_sNameObject' then ParValue:=m_srpParam.m_sNameObject;
     if ParName='m_sNDogovor'   then ParValue:=m_srpParam.m_sNDogovor;
     if ParName='m_rpTitle'     then ParValue:=m_rpTitle;
     if ParName='m_swTSTID'     then ParValue:=m_swTSTID;
     if ParName='m_sdtTestTime' then ParValue:=m_sdtTestTime;
     if ParName='m_strComment'     then ParValue:=m_strComment;
     if ParName='m_strDescription' then ParValue:=m_strDescription;
     if ParName='m_strResult'      then ParValue:=m_strResult;
end;

end.
