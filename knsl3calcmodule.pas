unit knsl3calcmodule;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlconst,utldatabase,inifiles,Db,ADODB
    ,knsl5tracer, Dates,utlbox, utlTimeDate,Parser10,knsl3vmeter,knsl3vparam,utlexparcer,
    knsl3treeloader,knsl2treeloader;
type
    CCalcModule = class
    private
     m_pGR : PSL3GROUPTAG;
     m_pVM : PCVMeters;
     m_nPR : CEvaluator;
     m_swVMID : Integer;
     m_swMID  : Integer;
     m_nCmdID : Integer;
     m_nTarifMask : DWord;
     function  FindTokenL1(var str:String;var pTN:CVToken):Boolean;
     function  FindTokenL2(var str:String;var pTN:CVToken):Boolean;
     procedure CalculateLG1(sExpr1:String;pPR:PCVParam;nTarifMask:DWord);
     procedure RunCSL1(sExpr1:String;pPR:PCVParam;nTID:Integer);
     procedure CalculateL1(sExpr0,sExpr1:String;pPR:PCVParam);
     procedure CalculateL2(sExpr0,sExpr1:String;pPR:PCVParam);
     function  GetInfo(var str:String;var pTN:CVToken):Boolean;
     procedure RunEvaluatorL1(sExpr0,sExpr1:String;pPR:PCVParam;nTID:Integer);
     procedure RunEvaluatorL2(sExpr0,sExpr1:String;pPR:PCVParam;nTID:Integer);
     procedure OnCalcLG1;
     function  IsParam4(nCMDID:Integer):Boolean;
     function  IsKvadrant(nCType,cmd,m_sbyType: integer):Boolean;
     function  GetTarifMask(nVMID:Integer):DWord;
    public
     procedure Init(pGR:PSL3GROUPTAG;pVM:PCVMeters);
     procedure OnCalculate(nVMID,nMID,nCmdID:Integer);
     procedure OnFree;
     procedure OnCalc(nCType,nCmdID:Integer;IsFree:Boolean);
     procedure OnCalcAllCurrL1(nCmdID:Integer);
     procedure OnCalcAllL1;
     procedure OnCalcArchL1(nCType:Integer);
     procedure OnCalcAllL2;
     procedure OnCalcArchL2(nCType:Integer);
     procedure OnCalcAllL3;
     procedure OnCalcArchL3(nCType:Integer);
     destructor Destroy; override;
    public
 //    property PTreeModuleData  :PTTreeView        read FTreeModuleData    write FTreeModuleData;
//     property PTreeModuleLoader :PCL3TreeLoader   read FTreeModuleLoader  write FTreeModuleLoader;

    End;
const
    MAX_TARIFFS = 8;
implementation

destructor CCalcModule.Destroy;
begin
  if m_nPR <> nil then FreeAndNil(m_nPR);
  inherited;
end;

procedure CCalcModule.Init(pGR:PSL3GROUPTAG;pVM:PCVMeters);
Begin
     m_pGR := pGR;
     m_pVM := pVM;
     m_nPR := CEvaluator.Create;
     //w_mGEvent0 := CreateEvent(nil, False, False, nil);
//     m_nPR.Init;
   //  FTreeModuleLoader.LoadTree;
End;
procedure CCalcModule.OnCalc(nCType,nCmdID:Integer;IsFree:Boolean);
Begin
     m_blIsalc := 1;
     if nCType=-2 then
     Begin
      OnCalcAllCurrL1(nCmdID);
      OnFree;
     End
     else
     if nCType=-1 then
     Begin
      OnCalcAllL1;
      OnCalcAllL2;
      OnCalcAllL3;
      OnFree;
     End
     else
     Begin
      OnCalcArchL1(nCType);
      OnCalcArchL2(nCType);
      OnCalcArchL3(nCType);
      if IsFree=true then OnFree;
     End;
     //m_pDB.CurrentFlush(0);
     m_blIsalc := 0;
End;
procedure CCalcModule.OnCalculate(nVMID,nMID,nCmdID:Integer);
Begin
     m_blIsalc := 1;
      m_swVMID     := nVMID;
      m_swMID      := nMID;
      m_nCmdID     := nCmdID;
      m_nTarifMask := $0000000f;
      OnCalcLG1;
     m_blIsalc := 0;
End;
function CCalcModule.GetTarifMask(nVMID:Integer):DWord;
Begin
    //if m_pGR.
End;
procedure CCalcModule.OnFree;
Var
     i,j,k: Integer;
     pVMT : PSL3VMETERTAG;
     pVM  : PCVMeter;
     sExpr0,sExpr1 : String;
Begin
     try
     //if m_pGR.m_sbyEnable=0 then exit;
     for i:=0 to m_pGR.m_swAmVMeter-1 do
     Begin
      if m_pGR.Item.Items[i].m_sbyEnable=1 then
      Begin
       pVMT := @m_pGR.Item.Items[i];
       pVM  := @m_pVM.Items[pVMT.m_swVMID];
       for j:=0 to pVM.m_nP.m_swAmParams-1 do
       Begin
        k := pVM.m_nP.Item.Items[j].m_swParamID;
        pVM.m_nVParam[k].OnFree;
       End;
      End;
     End;
     except
      TraceER('(__)CL3MD::>Error In CL3Module.OnCalculate!!!');
     end
End;
procedure CCalcModule.OnCalcLG1;
Var
     i,j  : Integer;
     pVMT : PSL3VMETERTAG;
     pVM  : PCVMeter;
     res  : Boolean;
Begin
     try
     for i:=0 to m_pGR.m_swAmVMeter-1 do
     Begin
      res := False;
      if m_pGR.Item.Items[i].m_sbyEnable=1 then
      Begin
       pVMT := @m_pGR.Item.Items[i];
       pVM  := @m_pVM.Items[pVMT.m_swVMID];
       if (pVM.m_nP.m_swVMID=m_swVMID)or(m_swVMID=-1) then
       Begin
        //Calc Param In VMID
        if (pVMT.m_sbyType=MET_SUMM)or(pVMT.m_sbyType=MET_GSUMM) then continue;
        for j:=0 to pVM.m_nP.m_swAmParams-1 do
        Begin
         with pVM.m_nP.Item.Items[j] do
         Begin
          if m_sblCalculate=1 then
          Begin
           if (IsParam4(m_swParamID)=True) then
           Begin
           if((m_swParamID>=m_nCmdID)and(m_swParamID<=(m_nCmdID+3)))or(m_nCmdID=-1) then res := True;
           End else if (m_swParamID=m_nCmdID)or(m_nCmdID=-1) then res := True;
           if res=True then CalculateLG1(m_sParamExpress,@pVM.m_nVParam[m_swParamID],m_nTarifMask);
          End;
         End;
        End;
        //Save VMID and exit
        if res=True then
        Begin
         m_pDB.CurrentExecute;
         m_pDB.CurrentFlush(pVMT.m_swVMID);
         res := False;
         if (m_swVMID<>-1) then exit;
        End
       End;
      End;
     End;
     except
      TraceER('(__)CL3MD::>Error In CL3Module.OnCalculate!!!');
     end
End;
procedure CCalcModule.OnCalcAllCurrL1(nCmdID:Integer);
Var
     i,j,k: Integer;
     pVMT : PSL3VMETERTAG;
     pVM  : PCVMeter;
     sExpr0,sExpr1 : String;
Begin
     try
     //if m_pGR.m_sbyEnable=0 then exit;
     for i:=0 to m_pGR.m_swAmVMeter-1 do
     Begin
      if m_pGR.Item.Items[i].m_sbyEnable=1 then
      Begin
       pVMT := @m_pGR.Item.Items[i];
       pVM  := @m_pVM.Items[pVMT.m_swVMID];
       if pVM.m_nP.m_sbyEnable=1 then
       if not((pVMT.m_sbyType=MET_SUMM)or(pVMT.m_sbyType=MET_GSUMM))then
       Begin
        for j:=0 to pVM.m_nP.m_swAmParams-1 do
        Begin
         sExpr0 := pVM.m_nP.Item.Items[j].m_sParamExpress+';';
         sExpr1 := pVM.m_nP.Item.Items[j].m_sParamExpress;
         k := pVM.m_nP.Item.Items[j].m_swParamID;
         case k of
              QRY_ENERGY_SUM_EP,QRY_ENERGY_SUM_EM,QRY_ENERGY_SUM_RP,QRY_ENERGY_SUM_RM,
              QRY_MGAKT_POW_S,QRY_MGAKT_POW_A,QRY_MGAKT_POW_B,QRY_MGAKT_POW_C,
              QRY_MGREA_POW_S,QRY_MGREA_POW_A,QRY_MGREA_POW_B,QRY_MGREA_POW_C,
              QRY_U_PARAM_A,QRY_U_PARAM_B,QRY_U_PARAM_C,
              QRY_I_PARAM_A,QRY_I_PARAM_B,QRY_I_PARAM_C:
              if ((k>=nCmdID)and(k<=(nCmdID+3))) then if pVM.m_nP.Item.Items[j].m_sblCalculate=1 then CalculateL1(sExpr0,sExpr1,@pVM.m_nVParam[k]);
              QRY_FREQ_NET,QRY_SUM_RASH_V,QRY_RASH_AVE_V  :if (k=nCmdID)       then if pVM.m_nP.Item.Items[j].m_sblCalculate=1 then CalculateL1(sExpr0,sExpr1,@pVM.m_nVParam[k]);
         end;
        End;
        m_pDB.CurrentExecute;
        m_pDB.CurrentFlush(pVMT.m_swVMID);
       End;
      End;
     End;
     except
      TraceER('(__)CL3MD::>Error In CL3Module.OnCalculate!!!');
     end
End;
procedure CCalcModule.OnCalcAllL1;
Var
     i,j,k: Integer;
     pVMT : PSL3VMETERTAG;
     pVM  : PCVMeter;
     sExpr0,sExpr1 : String;
Begin
     try
     //if m_pGR.m_sbyEnable=0 then exit;
     for i:=0 to m_pGR.m_swAmVMeter-1 do
     Begin
      if m_pGR.Item.Items[i].m_sbyEnable=1 then
      Begin
       //if m_nPauseCM=True then exit;
       pVMT := @m_pGR.Item.Items[i];
       pVM  := @m_pVM.Items[pVMT.m_swVMID];
       //if pVM.m_nP.m_sbyEnable=1 then
       if not((pVMT.m_sbyType=MET_SUMM)or(pVMT.m_sbyType=MET_GSUMM))then
       Begin
        //m_pDB.CurrentPrepare;
        for j:=0 to pVM.m_nP.m_swAmParams-1 do
        Begin
         sExpr0 := pVM.m_nP.Item.Items[j].m_sParamExpress+';';
         sExpr1 := pVM.m_nP.Item.Items[j].m_sParamExpress;
         k := pVM.m_nP.Item.Items[j].m_swParamID;
         //if k=13 then
         if pVM.m_nP.Item.Items[j].m_sblCalculate=1 then
         CalculateL1(sExpr0,sExpr1,@pVM.m_nVParam[k]);
        End;
        m_pDB.CurrentExecute;
        m_pDB.CurrentFlush(pVMT.m_swVMID);
       End;
      End;
     End;
     except
      TraceER('(__)CL3MD::>Error In CL3Module.OnCalculate!!!');
     end
End;
procedure CCalcModule.OnCalcArchL1(nCType:Integer);
Var
     i,j,k: Integer;
     pVMT : PSL3VMETERTAG;
     pVM  : PCVMeter;
     sExpr0,sExpr1 : String;
Begin
     try
     //if m_pGR.m_sbyEnable=0 then exit;

     for i:=0 to m_pGR.m_swAmVMeter-1 do
     Begin
      if m_pGR.Item.Items[i].m_sbyEnable=1 then
      Begin
       //if m_nPauseCM=True then exit;
       pVMT := @m_pGR.Item.Items[i];
       pVM  := @m_pVM.Items[pVMT.m_swVMID];
       //if pVM.m_nP.m_sbyEnable=1 then
       if not((pVMT.m_sbyType=MET_SUMM)or(pVMT.m_sbyType=MET_GSUMM))then
       Begin
        //m_pDB.CurrentPrepare;
        for j:=0 to pVM.m_nP.m_swAmParams-1 do
        Begin
         sExpr0 := pVM.m_nP.Item.Items[j].m_sParamExpress+';';
         sExpr1 := pVM.m_nP.Item.Items[j].m_sParamExpress;
         k := pVM.m_nP.Item.Items[j].m_swParamID;
         if ((k>=nCType)and(k<=(nCType+3)))or IsKvadrant(nCType,k,pVMT.m_sbyType) or ((k>=QRY_POD_TRYB_HEAT)and(k<=QRY_WORK_TIME_ERR)) or ((k>=QRY_NACKM_POD_TRYB_HEAT)and(k<=QRY_NACKM_WORK_TIME_ERR)) then
         Begin
          if pVM.m_nP.Item.Items[j].m_sblCalculate=1 then
         CalculateL1(sExpr0,sExpr1,@pVM.m_nVParam[k]);
         End;
        End;
        m_pDB.CurrentExecute;
        m_pDB.CurrentFlush(pVMT.m_swVMID);
       End;
      // FTreeModuleLoader.RefreshTree(pVMT.m_swVMID,pVMT.m_sVMeterName);
      End;
     End;

     except
      TraceER('(__)CL3MD::>Error In CL3Module.OnCalculate!!!');
     end
End;
procedure CCalcModule.OnCalcAllL2;
Var
     i,j,k: Integer;
     pVMT : PSL3VMETERTAG;
     pVM  : PCVMeter;
     sExpr0,sExpr1 : String;
Begin
     try
     //if m_pGR.m_sbyEnable=0 then exit;
     for i:=0 to m_pGR.m_swAmVMeter-1 do
     Begin
      if m_pGR.Item.Items[i].m_sbyEnable=1 then
      Begin
       //if m_nPauseCM=True then exit;
       pVMT := @m_pGR.Item.Items[i];
       pVM  := @m_pVM.Items[pVMT.m_swVMID];
       //if pVM.m_nP.m_sbyEnable=1 then
       if pVMT.m_sbyType=MET_SUMM then
       Begin
        //m_pDB.CurrentPrepare;
        for j:=0 to pVM.m_nP.m_swAmParams-1 do
        Begin
         sExpr0 := pVM.m_nP.Item.Items[j].m_sParamExpress+';';
         sExpr1 := pVM.m_nP.Item.Items[j].m_sParamExpress;
         k := pVM.m_nP.Item.Items[j].m_swParamID;
         if pVM.m_nP.Item.Items[j].m_sblCalculate=1 then
         CalculateL2(sExpr0,sExpr1,@pVM.m_nVParam[k]);
        End;
        m_pDB.CurrentExecute;
        m_pDB.CurrentFlush(pVMT.m_swVMID);
       End;
    //   FTreeModuleLoader.RefreshTree(pVMT.m_swVMID,pVMT.m_sVMeterName);
      End;
     End;
     except
      TraceER('(__)CL3MD::>Error In CL3Module.OnCalculate!!!');
     end
End;
procedure CCalcModule.OnCalcArchL2(nCType:Integer);
Var
     i,j,k: Integer;
     pVMT : PSL3VMETERTAG;
     pVM  : PCVMeter;
     sExpr0,sExpr1 : String;
Begin
     try
     //if m_pGR.m_sbyEnable=0 then exit;
     for i:=0 to m_pGR.m_swAmVMeter-1 do
     Begin
      if m_pGR.Item.Items[i].m_sbyEnable=1 then
      Begin
       //if m_nPauseCM=True then exit;
       pVMT := @m_pGR.Item.Items[i];
       pVM  := @m_pVM.Items[pVMT.m_swVMID];
       //if pVM.m_nP.m_sbyEnable=1 then
       if pVMT.m_sbyType=MET_SUMM then
       Begin
        //m_pDB.CurrentPrepare;
        for j:=0 to pVM.m_nP.m_swAmParams-1 do
        Begin
         sExpr0 := pVM.m_nP.Item.Items[j].m_sParamExpress+';';
         sExpr1 := pVM.m_nP.Item.Items[j].m_sParamExpress;
         k := pVM.m_nP.Item.Items[j].m_swParamID;
         //if ((k>=nCType)and(k<=(nCType+3)))or((k>=QRY_POD_TRYB_HEAT)and(k<=QRY_WORK_TIME_ERR)) then
         if ((k>=nCType)and(k<=(nCType+3)))or IsKvadrant(nCType,k,pVMT.m_sbyType) or ((k>=QRY_NACKM_POD_TRYB_HEAT)and(k<=QRY_NACKM_WORK_TIME_ERR))  or ((k>=QRY_POD_TRYB_HEAT)and(k<=QRY_WORK_TIME_ERR)) then
         Begin
          if pVM.m_nP.Item.Items[j].m_sblCalculate=1 then
          CalculateL2(sExpr0,sExpr1,@pVM.m_nVParam[k]);
         End;
        End;
        m_pDB.CurrentExecute;
        m_pDB.CurrentFlush(pVMT.m_swVMID);
       End;
      End;
     End;
     except
      TraceER('(__)CL3MD::>Error In CL3Module.OnCalculate!!!');
     end
End;
procedure CCalcModule.OnCalcAllL3;
Var
     i,j,k: Integer;
     pVMT : PSL3VMETERTAG;
     pVM  : PCVMeter;
     sExpr0,sExpr1 : String;
Begin
     try
     //if m_pGR.m_sbyEnable=0 then exit;
     for i:=0 to m_pGR.m_swAmVMeter-1 do
     Begin
      if m_pGR.Item.Items[i].m_sbyEnable=1 then
      Begin
       //if m_nPauseCM=True then exit;
       pVMT := @m_pGR.Item.Items[i];
       pVM  := @m_pVM.Items[pVMT.m_swVMID];
       //if pVM.m_nP.m_sbyEnable=1 then
       if pVMT.m_sbyType=MET_GSUMM then
       Begin
        //m_pDB.CurrentPrepare;
        for j:=0 to pVM.m_nP.m_swAmParams-1 do
        Begin
         sExpr0 := pVM.m_nP.Item.Items[j].m_sParamExpress+';';
         sExpr1 := pVM.m_nP.Item.Items[j].m_sParamExpress;
         k := pVM.m_nP.Item.Items[j].m_swParamID;
         if pVM.m_nP.Item.Items[j].m_sblCalculate=1 then
         CalculateL2(sExpr0,sExpr1,@pVM.m_nVParam[k]);
        End;
        m_pDB.CurrentExecute;
        m_pDB.CurrentFlush(pVMT.m_swVMID);
       End;
      End;
     End;                                                      
     except
      TraceER('(__)CL3MD::>Error In CL3Module.OnCalculate!!!');
     end
End;
procedure CCalcModule.OnCalcArchL3(nCType:Integer);
Var
     i,j,k: Integer;
     pVMT : PSL3VMETERTAG;
     pVM  : PCVMeter;
     sExpr0,sExpr1 : String;
Begin
     try
     //if m_pGR.m_sbyEnable=0 then exit;
     for i:=0 to m_pGR.m_swAmVMeter-1 do
     Begin
      if m_pGR.Item.Items[i].m_sbyEnable=1 then
      Begin
       //if m_nPauseCM=True then exit;
       pVMT := @m_pGR.Item.Items[i];
       pVM  := @m_pVM.Items[pVMT.m_swVMID];
       //if pVM.m_nP.m_sbyEnable=1 then
       if pVMT.m_sbyType=MET_GSUMM then
       Begin
        //m_pDB.CurrentPrepare;
        for j:=0 to pVM.m_nP.m_swAmParams-1 do
        Begin
         sExpr0 := pVM.m_nP.Item.Items[j].m_sParamExpress+';';
         sExpr1 := pVM.m_nP.Item.Items[j].m_sParamExpress;
         k := pVM.m_nP.Item.Items[j].m_swParamID;
         //if ((k>=nCType)and(k<=(nCType+3)))or((k>=QRY_POD_TRYB_HEAT)and(k<=QRY_WORK_TIME_ERR)) then
         if ((k>=nCType)and(k<=(nCType+3)))or IsKvadrant(nCType,k,pVMT.m_sbyType) or ((k>=QRY_NACKM_POD_TRYB_HEAT)and(k<=QRY_NACKM_WORK_TIME_ERR))  or ((k>=QRY_POD_TRYB_HEAT)and(k<=QRY_WORK_TIME_ERR)) then
         Begin
          if pVM.m_nP.Item.Items[j].m_sblCalculate=1 then
          CalculateL2(sExpr0,sExpr1,@pVM.m_nVParam[k]);
         End;
        End;
        m_pDB.CurrentExecute;
        m_pDB.CurrentFlush(pVMT.m_swVMID);
       End;
      End;
     End;
     except
      TraceER('(__)CL3MD::>Error In CL3Module.OnCalculate!!!');
     end
End;
{
  CL_SUMM_TR  = 0;
  CL_AVRG_TR  = 1;
  CL_MAXM_TR  = 2;
  CL_NOTG_TR  = 3;
  CL_READ_PR  = 4;
}
procedure CCalcModule.CalculateLG1(sExpr1:String;pPR:PCVParam;nTarifMask:DWord);
Var
     i : Integer;
Begin
     case pPR.m_nP.m_swStatus of
          CL_SUMM_TR,CL_MAXM_TR,CL_AVRG_TR,CL_READ_PR:
          Begin
           for i:=MAX_TARIFFS-1 DownTo 0 do
           if (nTarifMask and (1 shl i))<>0 then RunCSL1(sExpr1,pPR,i);
          End;
          CL_NOTG_TR:RunCSL1(sExpr1,pPR,0);
     End;
End;
procedure CCalcModule.RunCSL1(sExpr1:String;pPR:PCVParam;nTID:Integer);
Var
    i,nCT : Integer;
    pTN   : CVToken;
    sExpr0 : String;
Begin
    sExpr0 := sExpr1+';';
    nCT := pPR.m_pDV[nTID].Count;
    for i:=0 to nCT-1 do
    Begin
     pTN.nTID := nTID;
     pTN.nSID := i;
     m_nPR.Expression := sExpr1;
     while(FindTokenL1(sExpr0,pTN))=True do
     m_nPR.Variable[pTN.sPName] := pTN.fValue;
     if pTN.blError=False then
     Begin
      pTN.fValue := m_nPR.Value;
      pTN.nGSID  := (nCT-1)-i;
      pPR.SetDataL1(pTN);
     End;
     sExpr0 := sExpr1+';';
    End;
End;
procedure CCalcModule.CalculateL1(sExpr0,sExpr1:String;pPR:PCVParam);
Begin
     if (pPR.m_nP.m_swStatus=CL_SUMM_TR)or(pPR.m_nP.m_swStatus=CL_MAXM_TR)or(pPR.m_nP.m_swStatus=CL_AVRG_TR)or(pPR.m_nP.m_swStatus=CL_READ_PR) then
     Begin
      RunEvaluatorL1(sExpr0,sExpr1,pPR,1);
      RunEvaluatorL1(sExpr0,sExpr1,pPR,2);
      RunEvaluatorL1(sExpr0,sExpr1,pPR,3);
      RunEvaluatorL1(sExpr0,sExpr1,pPR,4);
      RunEvaluatorL1(sExpr0,sExpr1,pPR,0);
     End else
     if (pPR.m_nP.m_swStatus=CL_NOTG_TR) then
     RunEvaluatorL1(sExpr0,sExpr1,pPR,0);
     //WaitForSingleObject(w_mGEvent0,3);
End;
procedure CCalcModule.RunEvaluatorL1(sExpr0,sExpr1:String;pPR:PCVParam;nTID:Integer);
Var
    i,nCT : Integer;
    pTN   : CVToken;
Begin
    nCT := pPR.m_pDV[nTID].Count;
    for i:=0 to nCT-1 do
    Begin
     pTN.nTID := nTID;
     pTN.nSID := i;
     m_nPR.Expression := sExpr1;
     while(FindTokenL1(sExpr0,pTN))=True do
     m_nPR.Variable[pTN.sPName] := pTN.fValue;
     if pTN.blError=False then
     Begin
      pTN.fValue := m_nPR.Value;
      pTN.nGSID  := (nCT-1)-i;
      pPR.SetDataL1(pTN); //!!!!!!!!!!!!
     End;
     sExpr0 := sExpr1+';';
    End;
    //WaitForSingleObject(w_mGEvent0,1);
End;

procedure CCalcModule.CalculateL2(sExpr0,sExpr1:String;pPR:PCVParam);
Begin
     if (pPR.m_nP.m_swStatus=CL_SUMM_TR)or(pPR.m_nP.m_swStatus=CL_MAXM_TR)or(pPR.m_nP.m_swStatus=CL_AVRG_TR)or(pPR.m_nP.m_swStatus=CL_READ_PR) then
     Begin
      RunEvaluatorL2(sExpr0,sExpr1,pPR,1);
      RunEvaluatorL2(sExpr0,sExpr1,pPR,2);
      RunEvaluatorL2(sExpr0,sExpr1,pPR,3);
      RunEvaluatorL2(sExpr0,sExpr1,pPR,4);
      RunEvaluatorL2(sExpr0,sExpr1,pPR,0);
     End else
     if (pPR.m_nP.m_swStatus=CL_NOTG_TR) then
     RunEvaluatorL2(sExpr0,sExpr1,pPR,0);
     //WaitForSingleObject(w_mGEvent0,3);
End;
procedure CCalcModule.RunEvaluatorL2(sExpr0,sExpr1:String;pPR:PCVParam;nTID:Integer);
Var
    i,nCT : Integer;
    pTN   : CVToken;
    pTND  : CVToken;
    slExpr0 : String;
    nTM   : TDateTime;
    blFirstInfo : Boolean;
Begin
    //if pPR.m_nP.m_swVMID=11 then
    //slExpr0 := sExpr0;

    slExpr0 := sExpr0;
    nCT := 0;i := 0;

    //if (pPR.m_nP.m_swVMID=34)and(pPR.m_nP.m_swParamID=QRY_SRES_ENR_EP) then
    //TraceL(3,pPR.m_nP.m_swVMID,'(__)CL3MD::>CVPRM: SRUNL2:'+DateTimeToStr(nTM));
    blFirstInfo := False;
    if Pos('MLim',slExpr0)<>0 then
     blFirstInfo := True;
    while GetInfo(slExpr0,pTND)=True do
    Begin
     {if i=0 then nTM := pTND.sTime;}Inc(i);
     //if (pTND.nSID<=nCT)and(m_pVM.Items[pTND.nVMID].m_nP.m_sbyEnable=1) then Begin nCT := pTND.nSID;nTM := pTND.sTime;End;
     if (pTND.nSID>=nCT)and(pTND.blError<>True) then Begin pTN.nGSID:=pTND.nGSID; nCT := pTND.nSID;nTM := pTND.sTime;End;
     //if (pTND.nSID=0)and(m_pVM.Items[pTND.nVMID].m_nP.m_sbyEnable=1) then Exit;
     if blFirstInfo=True then break;
    End;
    //if pPR.m_nP.m_swVMID=15 then
    //TraceL(3,pPR.m_nP.m_swVMID,'(__)CL3MD::>CVPRM: SRUNL2:'+DateTimeToStr(nTM));
    Begin
     //nCT := pTND.nSID;
     for i:=0 to nCT-1 do
     Begin

      pTN.nTID := nTID;
      pTN.nSID := i;

      //if pPR.m_nP.m_swVMID=15 then
      //m_nPR.Expression := sExpr1;

      m_nPR.Expression := sExpr1;
      while(FindTokenL2(sExpr0,pTN))=True do
      m_nPR.Variable[pTN.sPName] := pTN.fValue;
      if pTN.blError=False then
      Begin
       pTN.fValue := m_nPR.Value;
       if nCT>1 then pTN.nGSID  := (nCT-1)-i;
       pTN.sTime  := nTM;
       pPR.SetDataL2(pTN);
      End;
      sExpr0 := sExpr1+';';
     End;
    End;
    //WaitForSingleObject(w_mGEvent0,1);
End;

function CCalcModule.FindTokenL1(var str:String;var pTN:CVToken):Boolean;
Var
     res   : Boolean;
     i,j,k,n,km : Integer;
     sV,sP : String;
     nVMID : Integer;
Begin
     Result := False;
     //Find VMID
     i := Pos('v',str)+1;
     if i=1 then exit;
     if i>2 then Begin Delete(str,1,i-2);i:=Pos('v',str)+1;End;
     j := Pos('_',str);
     if j<=i then Begin pTN.blError:=True;exit;End;
     sV := Copy(str,i,j-i);
     nVMID := StrToInt(sV);
     pTN.nVMID := nVMID;
     //Find CMD
     km := 100;
     for n:=0 to 7 do
     Begin
      k:=Pos(chEndTn[n],str);
      if (k<=km) and (k<>0) then km:=k;
     End;
     if km>=j then sP:=Copy(str,j+1,km-(j+1));
     if km=100 then Begin pTN.blError:=True;exit;End;
     //Extract Value
     if sP<>'' then
     Begin
      pTN.blError:=False;
      if m_pVM.Items[nVMID].GetDataTSL1(sP,pTN)=False then
      Begin

       //pTN.blError:=True;
       //exit;
      End;
      if m_pVM.Items[nVMID].m_nP.m_sbyEnable=0 then
       pTN.fValue:=0;
      pTN.sPName := Copy(str,i-1,km-(i-1));
      Delete(str,i-1,(km+1)-(i-1));
      Result := True;
     End;
End;
function CCalcModule.FindTokenL2(var str:String;var pTN:CVToken):Boolean;
Var
     res   : Boolean;
     i,j,k,n,km : Integer;
     sV,sP : String;
     nVMID : Integer;
Begin
     Result := False;
     //Find VMID
     i := Pos('v',str)+1;
     if i=1 then exit;
     if i>2 then Begin Delete(str,1,i-2);i:=Pos('v',str)+1;End;
     j := Pos('_',str);
     if j<=i then Begin pTN.blError:=True;exit;End;
     sV := Copy(str,i,j-i);
     nVMID := StrToInt(sV);
     pTN.nVMID := nVMID;
     //Find CMD
     km := 100;
     for n:=0 to 7 do
     Begin
      k:=Pos(chEndTn[n],str);
      if (k<=km) and (k<>0) then km:=k;
     End;
     if km>=j then sP:=Copy(str,j+1,km-(j+1));
     if km=100 then Begin pTN.blError:=True;exit;End;
     //Extract Value
     if sP<>'' then
     Begin
      pTN.blError:=False;
      //if m_pVM.Items[nVMID].GetDataTS2(sP,pTN.nTID,pTN.nSID,pTN.fValue)=False then
      if m_pVM.Items[nVMID].GetDataTSL2(sP,pTN)=False then
      Begin
       pTN.fValue:=0;
       //pTN.blError:=True;
       //exit;
      End;
      if m_pVM.Items[nVMID].m_nP.m_sbyEnable=0 then
       pTN.fValue:=0;
      pTN.sPName := Copy(str,i-1,km-(i-1));
      Delete(str,i-1,(km+1)-(i-1));
      Result := True;
     End;
End;
function CCalcModule.GetInfo(var str:String;var pTN:CVToken):Boolean;
Var
     res   : Boolean;
     i,j,k,n,km : Integer;
     sV,sP : String;
     nVMID : Integer;
Begin
     Result := False;
     //Find VMID
     i := Pos('v',str)+1;
     if i=1 then exit;
     if i>2 then Begin Delete(str,1,i-2);i:=Pos('v',str)+1;End;
     j := Pos('_',str);
     if j<=i then Begin pTN.blError:=True;exit;End;
     sV := Copy(str,i,j-i);
     nVMID := StrToInt(sV);
     pTN.nVMID := nVMID;
     //Find CMD
     km := 100;
     for n:=0 to 7 do
     Begin
      k:=Pos(chEndTn[n],str);
      if (k<=km) and (k<>0) then km:=k;
     End;
     if km>=j then sP:=Copy(str,j+1,km-(j+1));
     if km=100 then Begin pTN.blError:=True;exit;End;
     //Extract Value
     if sP<>'' then
     Begin
      pTN.blError:=False;
      if m_pVM.Items[nVMID].GetInfo(sP,pTN)=False then
      Begin
       pTN.blError:=True;
       //exit;
      End;

      pTN.sPName := Copy(str,i-1,km-(i-1));
      Delete(str,i-1,(km+1)-(i-1));
      Result := True;
     End;
End;
function CCalcModule.IsParam4(nCMDID:Integer):Boolean;
Begin
     Result:=False;
     case nCMDID of
          QRY_ENERGY_DAY_EP,QRY_ENERGY_DAY_EM,QRY_ENERGY_DAY_RP,QRY_ENERGY_DAY_RM,
          QRY_ENERGY_MON_EP,QRY_ENERGY_MON_EM,QRY_ENERGY_MON_RP,QRY_ENERGY_MON_RM,
          QRY_NAK_EN_DAY_EP,QRY_NAK_EN_DAY_EM,QRY_NAK_EN_DAY_RP,QRY_NAK_EN_DAY_RM,
          QRY_NAK_EN_MONTH_EP,QRY_NAK_EN_MONTH_EM,QRY_NAK_EN_MONTH_RP,QRY_NAK_EN_MONTH_RM,
          QRY_SRES_ENR_EP,QRY_SRES_ENR_EM,QRY_SRES_ENR_RP,QRY_SRES_ENR_RM,
          QRY_MGAKT_POW_S,QRY_MGAKT_POW_A,QRY_MGAKT_POW_B,QRY_MGAKT_POW_C,
          QRY_MGREA_POW_S,QRY_MGREA_POW_A,QRY_MGREA_POW_B,QRY_MGREA_POW_C,
          QRY_U_PARAM_S,QRY_U_PARAM_A,QRY_U_PARAM_B,QRY_U_PARAM_C,
          QRY_I_PARAM_S,QRY_I_PARAM_A,QRY_I_PARAM_B,QRY_I_PARAM_C: Result:=True;
     End;
     if (nCMDID >= QRY_ENERGY_SUM_R1) and (nCMDID <=QRY_NAK_EN_MONTH_R4) then
       Result := true;
End;
function CCalcModule.IsKvadrant(nCType,cmd,m_sbyType: integer):Boolean;
begin;
  Result:=False;
  if m_sbyType = MET_EPQS then
  begin
    if (nCType=QRY_ENERGY_DAY_EP)and((cmd>=QRY_ENERGY_DAY_R1)and(cmd<=QRY_ENERGY_DAY_R4)) then Result:=True else
    if (nCType=QRY_ENERGY_MON_EP)and((cmd>=QRY_ENERGY_MON_R1)and(cmd<=QRY_ENERGY_MON_R4)) then Result:=True else
    if (nCType=QRY_NAK_EN_MONTH_EP)and((cmd>=QRY_NAK_EN_MONTH_R1)and(cmd<=QRY_NAK_EN_MONTH_R4)) then Result:=True else
    if (nCType=QRY_SRES_ENR_EP)and((cmd>=QRY_SRES_ENR_R1)and(cmd<=QRY_SRES_ENR_R4)) then Result:=True;
  end;
end;
end.
