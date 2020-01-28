unit knsl3qwerytree;

interface
uses
  Windows, Classes, SysUtils,SyncObjs,stdctrls,Controls, Forms, Dialogs,comctrls,
  utltypes,utlbox,utldatabase,knsl2treehandler,knsl5tracer,utlconst;
type
    CL3QweryTree = class(CTreeHandler)
    private
     //Type 1
    private

     public
     constructor Create(pTree : PTTreeView);
     destructor  Destroy;override;
     procedure   LoadTree;
     End;
  PCL3QweryTree =^ CL3QweryTree;
implementation
constructor CL3QweryTree.Create(pTree : PTTreeView);
Begin
    inherited Create(pTree);
End;
destructor CL3QweryTree.Destroy;
Begin
    inherited;
End;

//Абонент-Примитивы-Группы-Тучи-Параметры
procedure CL3QweryTree.LoadTree;
Begin
    TraceL(1,0,'ExecSetTree #0');
    //m_nPIID := 0;
    //SetAbonTemplate;
End;
{
procedure CL3TreeLoader.SetAbonTemplate;
Var
    pTbl : SL3ABONS;
    i    : Integer;
    strName   : string;
    PAID,PSTT : Integer;
    nTI  : CTI;
    pTI  : PCTI;
Begin
    FreeTree;
    FTree.ReadOnly := True;
    if m_pDB.GetAbonsTable(pTbl)=True then
    Begin
     for i:=0 to pTbl.Count-1 do
     Begin
      PSTT    := pTbl.Items[i].m_sbyEnable;
      PAID    := pTbl.Items[i].m_swABOID;
      strName := pTbl.Items[i].m_sName+':'+pTbl.Items[i].m_sObject;
      nTI     := CTI.Create(1,SD_ABONT,PD_UNKNW,0,PAID,PSTT);
      nTI.m_nCTI.PPID := pTbl.Items[i].m_swPortID;
      SetInAbonNode(nTI,SetInNode(nTI,Nil,strName));
      nTI.Destroy;
     end;
    end;
End;
}
end.
