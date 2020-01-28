unit knsl2treehandler;

interface
uses
  Windows, Classes, SysUtils,SyncObjs,stdctrls,Controls, Forms, Dialogs,comctrls,
  utltypes,utlbox,utlconst,utldatabase;
type
    SIMID = packed record
     m_sbyLOCK : Byte;
     m_sbyUNLK : Byte;
     m_sbyALOK : Byte;
     m_sbyCVRY : Byte;
     m_sbyALRM : Byte;
     m_sbyREDY : Byte;
    End;

    CTI = class
    public
     constructor Create;overload;
     constructor Create(sNSTT:SIMID);overload;
     constructor Create(nCTreeIndex:CTreeIndex);overload;
     constructor Create(PTIN,PTSD,PNID,PSTT:Integer);overload;
     constructor Create(PTIN,PTSD,PNID,PRID,PSTT:Integer);overload;
     constructor Create(PTIN,PTSD,PNID,PRID,PAID,PSTT:Integer);overload;
     constructor Create(PTIN,PTSD,PNID,PRID,PAID,PGID,PSTT:Integer);overload;
     constructor Create(PTIN,PTSD,PNID,PRID,PAID,PGID,PVID,PMID,PPID,PSTT:Integer);overload;
     constructor Create(PTIN,PTSD,PNID,PRID,PAID,PGID,PVID,PMID,PPID,PCID,PTID,PSID,PDID:Integer);overload;
     constructor Create(PTIN,PTSD,PNID,PRID,PAID,PGID,PVID,PMID,PPID,PCID,PTID,PSID,PDID,PSTT:Integer);overload;
    public
     m_sNSTT    : SIMID;
     m_blPulce  : Byte;
     m_blPulceEn: Byte;
     m_nCTI     : CTreeIndex;
    public
     procedure Run;
     procedure SetPulceState;
     procedure RemPulceState;
     procedure ChandgeState(byState:Byte);
     procedure PulceNode;
     procedure setRegion(value:Integer);
     procedure setRayon(value:Integer);
     procedure setTown(value:Integer);
     procedure setStreet(value:Integer);
     procedure setPods(value:Integer);
     procedure setAbon(value:Integer);
     procedure setGroup(value:Integer);
     procedure setQueryGroup(value:Integer);
     procedure setQGroupParam(value:Integer);
     procedure setCommand(value:Integer);
   protected
    destructor Destroy;override;
    End;
    PCTI = ^CTI;

    CTreeHandler = class
    public
     m_blEnable : Boolean;
    protected
     FTree   : PTTreeView;
     m_nPIID : Integer;
     m_sNI   : SIMID;
     procedure SetHardTreeL1(pSL:Pointer;nL0,nL1:String;blDelete:Boolean);
     procedure SetHardTreeL2(pSL:Pointer;nL0,nL1,nL2:String;blDelete:Boolean;ImgIndex:word);
     procedure SetHardTreeL3(pSL:Pointer;nL0,nL1,nL2,nL3:String;blDelete:Boolean);
     function  SetInNode(nTI:CTI;rtChild:TTreeNode;strName:String):TTreeNode;
     procedure FreeTree;
     procedure FreeTreeTEST;     
     procedure ExpandTree(strNode : String);
     procedure ExpandTreeL2(strPNode,strNode : String);
     constructor Create(pTree : PTTreeView);
     destructor Destroy;override;
    public
     procedure Run;
     function  GetImID(nCTI:CTreeIndex):Byte;//virtual;
     function  CreateCTI:PCTI;virtual;
     function  IsTrueNode(nCTI:CTreeIndex):Boolean;virtual;
     function  SetState(var pDS:CGDataSource):Byte;
     function  SetAbonState(var pDS:CGDataSource):Byte;
     function  SetClusterState(nSRVID,nCLID,nCLSID,nSTT:Integer):Byte;
     function  SetVMetrState(var pDS:CGDataSource):Byte;
     function  IsLevel(nLevel:Integer;str:String):Boolean;
     function  IsLevel2(nLevel:Integer;str:String):Boolean;
     function  IsLevel3(nLevel:Integer;str:String):Boolean;
    public
     property  PTreeModule :PTTreeView      read FTree    write FTree;
    End;

{
    CTreeIndex = packed record
     PTIM     : Integer;    //Картинка
     PTSD     : Integer;    //Узел Типа Структуры Данных
     PNID     : Integer;    //Узел Типа Примитива Данных
     PRID     : Integer;    //Регион
     PRYD     : Integer;    //Район
     PTWN     : Integer;    //Город
     PSTR     : Integer;    //Улица
     PAID     : Integer;    //Абонент
     PGID     : Integer;    //Группа
     PVID     : Integer;    //Виртуальный Счетчик
     PCID     : Integer;    //Команда
     PPID     : Integer;    //Порт
     PMID     : Integer;    //Физ счетчик
     PTID     : Integer;    //Тариф
     PSID     : Integer;    //Тип хранения
     PDID     : Integer;    //Тип Отображения
     PKey     : Integer;
     FKey     : Integer;
     PIID     : Integer;
     PSTT     : Integer;
     PTND     : PTTreeView;
    End;
    SA_LOCK                      = 00;
    SA_UNLK                      = 01;
    SA_ALOK                      = 02;
    SA_CVRY                      = 03;
    SA_ALRM                      = 04;
    SA_REDY                      = 05;
}

implementation

procedure CTI.setRegion(value:Integer);
Begin
    m_nCTI.PRID := value;
End;
procedure CTI.setRayon(value:Integer);
Begin
    m_nCTI.PRYD := value;
End;
procedure CTI.setTown(value:Integer);
Begin
    m_nCTI.PTWN := value;
End;
procedure CTI.setStreet(value:Integer);
Begin
    m_nCTI.PSTR := value;
End;
procedure CTI.setPods(value:Integer);
Begin
    m_nCTI.PTPS := value;
End;
procedure CTI.setAbon(value:Integer);
Begin
    m_nCTI.PAID := value;
End;
procedure CTI.setGroup(value:Integer);
Begin
    m_nCTI.PGID := value;
End;
procedure CTI.setQueryGroup(value:Integer);
Begin
    m_nCTI.PQGD := value;
End;
procedure CTI.setQGroupParam(value:Integer);
Begin
    m_nCTI.PQPR := value;
End;
procedure CTI.setCommand(value:Integer);
Begin
    m_nCTI.PCID := value;
End;

constructor CTI.Create;
Begin
    FillChar(m_nCTI,sizeof(m_nCTI),0);
    m_blPulceEn := 0;
End;

constructor CTI.Create(sNSTT:SIMID);
Begin
    Move(sNSTT,m_sNSTT,sizeof(SIMID));
End;

constructor CTI.Create(nCTreeIndex:CTreeIndex);
Begin
    Move(nCTreeIndex,m_nCTI,sizeof(m_nCTI));
End;

constructor CTI.Create(PTIN,PTSD,PNID,PSTT:Integer);
Begin
    FillChar(m_nCTI,sizeof(m_nCTI),$ff);
    m_nCTI.PTIM := PTIN;
    m_nCTI.PNID := PNID;
    m_nCTI.PTSD := PTSD;
    m_nCTI.PSTT := PSTT;
End;

constructor CTI.Create(PTIN,PTSD,PNID,PRID,PSTT:Integer);
Begin
    FillChar(m_nCTI,sizeof(m_nCTI),$ff);
    m_nCTI.PTIM := PTIN;
    m_nCTI.PNID := PNID;
    m_nCTI.PTSD := PTSD;
    m_nCTI.PRID := PRID;
    m_nCTI.PSTT := PSTT;
End;
constructor CTI.Create(PTIN,PTSD,PNID,PRID,PAID,PSTT:Integer);
Begin
    FillChar(m_nCTI,sizeof(m_nCTI),$ff);
    m_nCTI.PTIM := PTIN;
    m_nCTI.PNID := PNID;
    m_nCTI.PTSD := PTSD;
    m_nCTI.PRID := PRID;
    m_nCTI.PAID := PAID;
    m_nCTI.PSTT := PSTT;
End;
constructor CTI.Create(PTIN,PTSD,PNID,PRID,PAID,PGID,PSTT:Integer);
Begin
    FillChar(m_nCTI,sizeof(m_nCTI),$ff);
    m_nCTI.PTIM := PTIN;
    m_nCTI.PNID := PNID;
    m_nCTI.PTSD := PTSD;
    m_nCTI.PRID := PRID;
    m_nCTI.PAID := PAID;
    m_nCTI.PGID := PGID;
    m_nCTI.PSTT := PSTT;
End;
constructor CTI.Create(PTIN,PTSD,PNID,PRID,PAID,PGID,PVID,PMID,PPID,PSTT:Integer);
Begin
    FillChar(m_nCTI,sizeof(m_nCTI),$ff);
    m_nCTI.PTIM := PTIN;
    m_nCTI.PNID := PNID;
    m_nCTI.PTSD := PTSD;
    m_nCTI.PRID := PRID;
    m_nCTI.PAID := PAID;
    m_nCTI.PGID := PGID;
    m_nCTI.PVID := PVID;
    m_nCTI.PMID := PMID;
    m_nCTI.PPID := PPID;
    m_nCTI.PSTT := PSTT;
End;
constructor CTI.Create(PTIN,PTSD,PNID,PRID,PAID,PGID,PVID,PMID,PPID,PCID,PTID,PSID,PDID:Integer);
Begin
    FillChar(m_nCTI,sizeof(m_nCTI),$ff);
    m_nCTI.PTIM := PTIN;
    m_nCTI.PNID := PNID;
    m_nCTI.PTSD := PTSD;
    m_nCTI.PRID := PRID;
    m_nCTI.PAID := PAID;
    m_nCTI.PGID := PGID;
    m_nCTI.PVID := PVID;
    m_nCTI.PMID := PMID;
    m_nCTI.PPID := PPID;
    m_nCTI.PCID := PCID;
    m_nCTI.PTID := PTID;
    m_nCTI.PSID := PSID;
    m_nCTI.PDID := PDID;
End;
constructor CTI.Create(PTIN,PTSD,PNID,PRID,PAID,PGID,PVID,PMID,PPID,PCID,PTID,PSID,PDID,PSTT:Integer);
Begin
    FillChar(m_nCTI,sizeof(m_nCTI),$ff);
    m_nCTI.PTIM := PTIN;
    m_nCTI.PNID := PNID;
    m_nCTI.PTSD := PTSD;
    m_nCTI.PRID := PRID;
    m_nCTI.PAID := PAID;
    m_nCTI.PGID := PGID;
    m_nCTI.PVID := PVID;
    m_nCTI.PMID := PMID;
    m_nCTI.PPID := PPID;
    m_nCTI.PCID := PCID;
    m_nCTI.PTID := PTID;
    m_nCTI.PSID := PSID;
    m_nCTI.PSTT := PSTT;
End;

destructor CTI.Destroy;
Begin
    FillChar(m_nCTI,sizeof(m_nCTI),0);
    inherited;
End;


procedure CTI.PulceNode;
Begin
    with m_nCTI do
    if m_blPulce=1 then
    Begin
     ChandgeState(SA_UNLK);
     m_blPulce := 0;
    End else
    if m_blPulce=0 then
    Begin
     ChandgeState(SA_CVRY);
     m_blPulce := 1;
    End;
End;
procedure CTI.SetPulceState;
Begin
    m_blPulceEn := 1;
End;
procedure CTI.RemPulceState;
Begin
    m_blPulceEn := 0;
End;
procedure CTI.ChandgeState(byState:Byte);
Begin
    m_nCTI.PSTT := byState;
    if (m_nCTI.PIID>(m_nCTI.PTND.Items.Count-1)) then
      exit;

    with m_nCTI.PTND.Items.Item[m_nCTI.PIID],m_sNSTT do
    Begin
     case byState of
          SA_LOCK: Begin ImageIndex:=m_sbyLOCK;SelectedIndex:=m_sbyLOCK;End;
          SA_UNLK: Begin ImageIndex:=m_sbyUNLK;SelectedIndex:=m_sbyUNLK;End;
          SA_ALOK: Begin ImageIndex:=m_sbyALOK;SelectedIndex:=m_sbyALOK;End;
          SA_CVRY: Begin ImageIndex:=m_sbyCVRY;SelectedIndex:=m_sbyCVRY;End;
          SA_ALRM: Begin ImageIndex:=m_sbyALRM;SelectedIndex:=m_sbyALRM;End;
          SA_REDY: Begin ImageIndex:=m_sbyREDY;SelectedIndex:=m_sbyREDY;End;
     End;
    End;
End;
procedure CTI.Run;
Begin
    if m_blPulceEn=1 then PulceNode;
End;
constructor CTreeHandler.Create(pTree : PTTreeView);
Begin
    FTree      := pTree;
    m_blEnable := True;
End;
destructor CTreeHandler.Destroy;
Begin
    FreeTree;
    inherited;
End;
function  CTreeHandler.CreateCTI:PCTI;
Var
    pTI      : PCTI;
Begin
    New(pTI);
    pTI^ := CTI.Create;
    Result := pTI;
End;

function  CTreeHandler.SetState(var pDS:CGDataSource):Byte;
Var
    pTI      : PCTI;
Begin
  try
    Result:=0;
    pTI := pDS.trPTND;
    if pTI<>Nil then pTI.ChandgeState(pDS.trTRI.PSTT);
  except
    Result:=1;
  end;
end;
function  CTreeHandler.SetVMetrState(var pDS:CGDataSource):Byte;
Var
    pTI : PCTI;
    i   : Integer;
Begin
  try
   Result:=0;
    //SetState(pDS);
    if FTree<>Nil then
    for i:=0 to FTree.Items.Count-1 do
    Begin
     pTI := FTree.Items[i].Data;
     if pTI<>Nil then
     Begin
      case pTI.m_nCTI.PTSD of
        SD_VMETR:if (pTI.m_nCTI.PAID=pDS.trTRI.PAID)and(pTI.m_nCTI.PVID=pDS.trTRI.PVID) then
                 pTI.ChandgeState(pDS.trTRI.PSTT);
      end;
     End;
    End;
  except
    Result:=1;
  end;
end;
function  CTreeHandler.SetAbonState(var pDS:CGDataSource):Byte;
Var
    pTI : PCTI;
    i   : Integer;
Begin
  try
  Result:=0;
    SetState(pDS);
    if FTree<>Nil then
    for i:=0 to FTree.Items.Count-1 do
    Begin
     pTI := FTree.Items[i].Data;
     if pTI<>Nil then
     Begin
      case pTI.m_nCTI.PTSD of
        SD_VMETR: if pTI.m_nCTI.PAID=pDS.trTRI.PAID then pTI.ChandgeState(pDS.trTRI.PSTT);
      end;
     End;
    End;
   except
     Result:=1;
   end;  
end;
//function  CTreeHandler.SetClusterState(var pDS:CGDataSource):Byte;
function  CTreeHandler.SetClusterState(nSRVID,nCLID,nCLSID,nSTT:Integer):Byte;
Var
    pTI : PCTI;
    i   : Integer;
    res0,res1,res2 : Boolean;
Begin
  try
  Result:=0;
    if FTree<>Nil then
    for i:=0 to FTree.Items.Count-1 do
    Begin
     pTI := FTree.Items[i].Data;
     with FTree.Items[i],pTI.m_sNSTT do
     Begin
     if pTI<>Nil then
     Begin
      res0 := (pTI.m_nCTI.PGID=nSRVID);if nSRVID=-1 then res0 := True;
      res1 := (pTI.m_nCTI.PCID=nCLID); if nCLID= -1 then res1 := True;
      res2 := (pTI.m_nCTI.PTID=nCLSID);
      case pTI.m_nCTI.PTSD of
           SD_CLUST:
           if (res0=True)and(res1=True)and(res2=True)then
           Begin
            case nSTT of
             SA_LOCK: Begin ImageIndex:=m_sbyLOCK;SelectedIndex:=m_sbyLOCK;End;
             SA_UNLK: Begin ImageIndex:=m_sbyUNLK;SelectedIndex:=m_sbyUNLK;End;
             SA_ALOK: Begin ImageIndex:=m_sbyALOK;SelectedIndex:=m_sbyALOK;End;
             SA_CVRY: Begin ImageIndex:=m_sbyCVRY;SelectedIndex:=m_sbyCVRY;End;
             SA_ALRM: Begin ImageIndex:=m_sbyALRM;SelectedIndex:=m_sbyALRM;End;
             SA_REDY: Begin ImageIndex:=m_sbyREDY;SelectedIndex:=m_sbyREDY;End;
            End;
           End;
           //pTI.ChandgeState(nSTT);
      end;
     End;
     End;
    End;
  except
   Result:=1;
  end; 
end;
function  CTreeHandler.GetImID(nCTI:CTreeIndex):Byte;
Begin
    Result := nCTI.PTIM;
    if IsTrueNode(nCTI)=True then  //менять картинку еслине тру
    case nCTI.PSTT of
         SA_LOCK: Result := m_sNI.m_sbyLOCK;
         SA_UNLK: Result := m_sNI.m_sbyUNLK;
         SA_ALOK: Result := m_sNI.m_sbyALOK;
         SA_CVRY: Result := m_sNI.m_sbyCVRY;
         SA_ALRM: Result := m_sNI.m_sbyALRM;
         SA_REDY: Result := m_sNI.m_sbyREDY;
    End;
End;
function  CTreeHandler.IsTrueNode(nCTI:CTreeIndex):Boolean;
Begin
    Result := (nCTI.PTSD=SD_ABONT)or(nCTI.PTSD=SD_VMETR);
End;
procedure CTreeHandler.ExpandTree(strNode : String);
Var
    i : Integer;
    nNode : TTreeNode;
Begin
     for i:=0 to FTree.Items.Count-1 do
     Begin
      if FTree.Items[i].Text=strNode then
      Begin
       if FTree.Items[i].Count<>0 then
       FTree.Items[i+1].Selected := True;

       //FTree.Items[i+1].StateIndex := 1;
       break;
      End
     End;
End;
procedure CTreeHandler.ExpandTreeL2(strPNode,strNode : String);
Var
    i : Integer;
    nNode : TTreeNode;
Begin
     for i:=0 to FTree.Items.Count-1 do
     Begin
      if FTree.Items[i].Parent<>Nil then
      if FTree.Items[i].Parent.Text=strPNode then
      if FTree.Items[i].Text=strNode then
      Begin
       if FTree.Items[i].Count<>0 then
       FTree.Items[i+1].Selected := True;

       //FTree.Items[i+1].StateIndex := 1;
       break;
      End
     End;
End;
function CTreeHandler.SetInNode(nTI:CTI;rtChild:TTreeNode;strName:String):TTreeNode;
Var
    pSL      : PCTI;
    rtChild1 : TTreeNode;
Begin
    //New(pSL);
    nTI.m_nCTI.PIID := m_nPIID;
    //pSL^ := CTI.Create;
    pSL := CreateCTI;
    Move(nTI.m_nCTI,pSL.m_nCTI,sizeof(CTreeIndex));
    rtChild1 := FTree.Items.AddChild(rtChild,strName);
    with nTI.m_nCTI do PTIM :=GetImID(nTI.m_nCTI);     //Внутри делать проверку по началу суток месяца и менять картинку опрошена или нет
    //with nTI.m_nCTI do if (PTSD=SD_ABONT)or(PTSD=SD_VMETR) then PTIM:=GetImID(PSTT);
    rtChild1.ImageIndex    := nTI.m_nCTI.PTIM;
    rtChild1.SelectedIndex := nTI.m_nCTI.PTIM;
    pSL.m_nCTI.PTND        := FTree;
    rtChild1.Data          := pSL;
    m_nPIID  := m_nPIID + 1;
    Result   := rtChild1;
End;

procedure CTreeHandler.FreeTree;
Var
    i   : Integer;
    pTI : PCTI;
Begin
    for i:=0 to FTree.Items.Count-1 do
    Begin
     if FTree.Items[i]<>Nil then
     Begin
      pTI := FTree.Items[i].Data;
      if pTI<>Nil then
      Begin
       //pTI.Free;
       pTI^.Destroy;
       pTI^:= nil;
       Dispose(pTI);
      End;
     End;
    End;
    FTree.Items.Clear;
    m_nPIID := 0;
End;

procedure CTreeHandler.FreeTreeTEST;
Var
    i   : Integer;
    pTI : PCTI;
Begin
    for i:=0 to FTree.Items.Count-1 do
    Begin
     if FTree.Items[i]<>Nil then
     Begin
      pTI := FTree.Items[i].Data;
      if pTI<>Nil then
      Begin
       //pTI.Free;
       pTI^.Destroy;
       pTI^:= nil;
       Dispose(pTI);       
      End;
     End;
    End;
    FTree.Items.Clear;
    m_nPIID := 0;
End;

procedure CTreeHandler.SetHardTreeL1(pSL:Pointer;nL0,nL1:String;blDelete:Boolean);
Var
   i,j     : Integer;
   ndChild : TTreeNode;
Begin
   for i:=0 to FTree.Items.Count-1 do
   Begin
    with FTree.Items[i] do Begin
    //if (Text=nL2) then
    //if (Text=nL1) then
    //if Parent<>Nil then
    if (Text=nL0) then
    Begin
     if blDelete=False then
     Begin
      ndChild:=FTree.Items.AddChild(FTree.Items[i],nL1);
      ndChild.Data := pSL;
      exit;
     End else
     Begin
      if Count<>0 then
      for j:=0 to Count-1 do
      Begin
       pSL := Item[0].Data;
       if pSL<>Nil then Dispose(pSL);
       Item[0].Delete;
      End;
      exit;
     End;

    End;
    End;
   End;
End;
procedure CTreeHandler.SetHardTreeL2(pSL:Pointer;nL0,nL1,nL2:String;blDelete:Boolean;ImgIndex:word);
Var
   i,j     : Integer;
   //pSL     : PTHardSlot;
   ndChild : TTreeNode;
Begin
   for i:=0 to FTree.Items.Count-1 do
   Begin
    with FTree.Items[i] do Begin
    if (Text=nL1) then
     if (Parent.Text=nL0) then
     Begin
      if blDelete=False then
       Begin
        ndChild:=FTree.Items.AddChild(FTree.Items[i],nL2);
        ndChild.ImageIndex := ImgIndex ;
        ndChild.SelectedIndex := ImgIndex ;
        ndChild.Data := pSL;
        exit;
      //New(pSL);Move(sTH,pSL^,sizeof(THardSlot));ndChild.Data:=pSL;exit;
        End else
     Begin
      if Count<>0 then
      for j:=0 to Count-1 do
      Begin
       pSL := Item[0].Data;
       if pSL<>Nil then Dispose(pSL);
       Item[0].Delete;
      End;
      exit;
     End;

    End;
    End;
   End;
End;
procedure CTreeHandler.SetHardTreeL3(pSL:Pointer;nL0,nL1,nL2,nL3:String;blDelete:Boolean);
Var
   i,j     : Integer;
   //pSL     : PTHardSlot;
   ndChild : TTreeNode;
Begin
   for i:=0 to FTree^.Items.Count-1 do
   Begin
    with FTree.Items[i] do Begin
    //if (Text=nL3) then
    if (Text=nL2) then
    if (Parent.Text=nL1) then
    if (Parent.Parent.Text=nL0) then
    Begin
     if blDelete=False then
     Begin
      ndChild:=FTree.Items.AddChild(FTree.Items[i],nL3);
      ndChild.Data:=pSL;
      exit;
      //New(pSL);Move(sTH,pSL^,sizeof(THardSlot));ndChild.Data:=pSL;exit;
     End else
     Begin
      if (Count<>0) and (blDelete=True) then
      for j:=0 to Count-1 do
      Begin
       pSL := Item[0].Data;
       if pSL<>Nil then Dispose(pSL);
       Item[0].Delete;
      End;
     exit;
     End;

    End;
    End;
   End;
End;

function CTreeHandler.IsLevel(nLevel:Integer;str:String):Boolean;
Var
    Node : TTreeNode;
    res  : Boolean;
Begin
    res  := False;
    Node := FTree.Selected;
    if str='' then
    Begin
     if Node<>Nil then
     if Node.Level=nLevel then res := True;
    End
    Else
    Begin
     if Node<>Nil then
     if Node.Parent<>Nil then
     if Node.Parent.Text=str then res := True
    End;
    Result := res;
End;
function CTreeHandler.IsLevel2(nLevel:Integer;str:String):Boolean;
Var
    Node : TTreeNode;
    res  : Boolean;
Begin
    res  := False;
    Node := FTree.Selected;
    if str='' then
    Begin
     if Node<>Nil then
     if Node.Level=nLevel then res := True;
    End
    Else
    Begin
     if Node<>Nil then
     if Node.Parent<>Nil then
     if Node.Parent.Parent<>Nil then
     if Node.Parent.Parent.Text=str then res := True
    End;
    Result := res;
End;
function CTreeHandler.IsLevel3(nLevel:Integer;str:String):Boolean;
Var
    Node : TTreeNode;
    res  : Boolean;
Begin
    res  := False;
    Node := FTree.Selected;
    if str='' then
    Begin
     if Node<>Nil then
     if Node.Level=nLevel then res := True;
    End
    Else
    Begin
     if Node<>Nil then
     if Node.Parent<>Nil then
     if Node.Parent.Parent<>Nil then
     if Node.Parent.Parent.Parent<>Nil then
     if Node.Parent.Parent.Parent.Text=str then res := True
    End;
    Result := res;
End;
procedure CTreeHandler.Run;
Var
    i   : Integer;
    pCI : PCTI;
Begin
    try
    {
    if m_blEnable=True Then
    if FTree<>Nil then
    for i:=0 to FTree.Items.Count-1 do
    Begin
     pCI := FTree.Items[i].Data;
     if pCI<>Nil then
     Begin
      case pCI.m_nCTI.PTSD of
        SD_ABONT,SD_VMETR:pCI.Run;
      end;
     End;
    End;
    }
    except
    
    end;
End;
end.
