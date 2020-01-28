unit knsl3Abonent;
interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl1cport,knsl1comport,
    utldatabase,extctrls,utlmtimer,knsl5tracer,knsl2BTIInit;
type
    STRNODE = packed record
     blPulce  : Byte;
     blPulceEn: Byte;
     pKey     : PCTreeIndex;
     trNode   : PTTreeNode;
    End;
    PSTRNODE =^ STRNODE;
    CAbonNode = class
    private
     m_trNode : STRNODE;
     m_trList : TList;
     procedure Add(pN:PSTRNODE);
     procedure ChandgeState(byState:Byte);
     //procedure ChandgeSubState(nIndex:Integer;byState:Byte);
     procedure PulceNode;
     //procedure PulceSubNode(nIndex:Integer;byState:Byte);
     procedure ClearAll;
    public
     constructor Create;
     procedure RunNode;
    End;
implementation
constructor CAbonNode.Create;
Begin
    if not Assigned(m_trList) then m_trList := TList.Create;
End;
procedure CAbonNode.Add(pN:PSTRNODE);
Var
    plN : PSTRNODE;
Begin
    if m_trNode.pKey.PNID=$ffff then
    Begin
     New(plN);
     pN.blPulce := 0;
     Move(pN^,plN^,sizeof(STRNODE));
     m_trList.Add(plN);
    End;
End;
procedure CAbonNode.ClearAll;
Var
    i : Integer;
Begin
    for i:=0 to m_trList.Count-1 do
    m_trList.Delete(i);
End;
procedure CAbonNode.PulceNode;
Begin
    with m_trNode do
    if blPulce=1 then
    Begin
     ChandgeState(SA_UNLK);
     blPulce := 0;
    End else
    if blPulce=0 then
    Begin
     ChandgeState(SA_CVRY);
     blPulce := 1;
    End;
End;
{
procedure CAbonNode.PulceSubNode(nIndex:Integer;byState:Byte);
Begin

End;
}
procedure CAbonNode.ChandgeState(byState:Byte);
Begin
     m_trNode.pKey.PSTT := byState;
     with m_trNode.trNode^ do
     Begin
      case byState of
           SA_LOCK: Begin ImageIndex:=11;SelectedIndex:=11;End;
           SA_UNLK: Begin ImageIndex:=10;SelectedIndex:=10;End;
           SA_CVRY: Begin ImageIndex:=9; SelectedIndex:=9; End;
           SA_ALRM: Begin ImageIndex:=12;SelectedIndex:=12;End;
      End;
     End;
End;
{
procedure CAbonNode.ChandgeSubState(nIndex:Integer;byState:Byte);
Begin

End;
}
procedure CAbonNode.RunNode;
Begin
     if m_trNode.blPulceEn=1 then
     Begin
       PulceNode;
     End;
End;

end.
