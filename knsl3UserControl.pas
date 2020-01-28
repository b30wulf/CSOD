unit knsl3UserControl;

interface
uses Windows, Messages, SysUtils, utlmtimer, utlconst, utltypes, knsl5tracer;
type
    CUserControlClass = class
    private
     m_nUserTimer       : CTimer;
     m_nHardKeyTimer    : CTimer;
     m_nUsrPrmt_DE      : Byte;
     m_nUsrPrmt_PE      : Byte;
     m_nUsrPrmt_QE      : Byte;
     m_nUsrPrmt_CE      : Byte;
     m_nUsrPrmt_GE      : Byte;
     m_nUsrPrmt_TE      : Byte;
     m_nUsrPrmt_CNE     : Byte;
     m_nUsrPrmt_PRE     : Byte;
     m_nUsrPrmt_QYG     : Byte;
     m_nUsrPrmt_ACR     : Byte;
     m_dwSessTime       : Dword;
    public
     procedure Init();
     destructor Destroy; override;
     procedure InitTimer(dwSTime:Dword);
     procedure RunTimer;
     function  EventHandler(var pMsg : CMessage):boolean;
     function  SelfHandler(var pMsg : CMessage):boolean;
     function  IsUserHavePrmt(Prmt:Byte):boolean;
     procedure SetUserTimer(var pTable:SUSERTAG);
    Public
    End;

implementation

destructor CUserControlClass.Destroy;
begin
  if m_nUserTimer <> Nil then FreeAndNil(m_nUserTimer);
  if m_nHardKeyTimer <> Nil then FreeAndNil(m_nHardKeyTimer);
  inherited;
end;

procedure CUserControlClass.Init();
begin
   if m_nUserTimer=Nil then m_nUserTimer := CTimer.Create;
   m_nUserTimer.SetTimer(DIR_L3TOL3, DL_USR_CNTRL_TMR, 0, 0, BOX_L3);
   if m_nHardKeyTimer=Nil then m_nHardKeyTimer := CTimer.Create;
   m_nHardKeyTimer.SetTimer(DIR_L3TOL3, DL_HRD_KEY_CTRL_TMR, 0, 0, BOX_L3);
   m_nUsrPrmt_DE  := 0;
   m_nUsrPrmt_PE  := 0;
   m_nUsrPrmt_QE  := 0;
   m_nUsrPrmt_CE  := 0;
   m_nUsrPrmt_GE  := 0;
   m_nUsrPrmt_TE  := 0;
   m_nUsrPrmt_CNE := 0;
   m_nUsrPrmt_PRE := 0;
   m_nUsrPrmt_QYG := 0;
   m_nUsrPrmt_ACR := 0;
   m_dwSessTime   := 180;
end;
procedure CUserControlClass.InitTimer(dwSTime:Dword);
Begin
   m_dwSessTime := dwSTime;
   m_nUserTimer.OnTimer(m_dwSessTime);
End;
function CUserControlClass.EventHandler(var pMsg : CMessage):boolean;
begin
   try
     case pMsg.m_sbyFor of
       DIR_L3TOL3    : SelfHandler(pMsg);
      //DIR_L2TOL3    : LoHandler(pMsg);
      //DIR_L4TOL3    : HiHandler(pMsg);
     End;
     except
       TraceER('(__)CERMD::>Error In CL3Module.EventHandler!!!');
   End;
end;

function CUserControlClass.SelfHandler(var pMsg : CMessage):boolean;
begin
   case pMsg.m_sbyType of
      DL_USR_CNTRL_TMR : m_nUserTimer.OffTimer;
      DL_HRD_KEY_CTRL_TMR : m_nHardKeyTimer.OffTimer;
   end;
end;

function CUserControlClass.IsUserHavePrmt(Prmt:Byte):boolean;
begin
   if m_nUserTimer.IsProceed then
   begin
     case Prmt of
       SA_USER_PERMIT_DE:  Result := (m_nUsrPrmt_DE=1);
       SA_USER_PERMIT_PE:  Result := (m_nUsrPrmt_PE=1);
       SA_USER_PERMIT_QE:  Result := (m_nUsrPrmt_QE=1);
       SA_USER_PERMIT_CE:  Result := (m_nUsrPrmt_CE=1);
       SA_USER_PERMIT_GE:  Result := (m_nUsrPrmt_GE=1);
       SA_USER_PERMIT_TE:  Result := (m_nUsrPrmt_TE=1);
       SA_USER_PERMIT_CNE: Result := (m_nUsrPrmt_CNE=1);
       SA_USER_PERMIT_PRE: Result := (m_nUsrPrmt_PRE=1);
       SA_USER_PERMIT_QYG: Result := (m_nUsrPrmt_QYG=1);
       SA_USER_PERMIT_ACR: Result := (m_nUsrPrmt_ACR=1);
      else
       Result := False;
     End;
   end
   else
     Result := false;
end;

procedure CUserControlClass.SetUserTimer(var pTable:SUSERTAG);
begin
   m_nUserTimer.OnTimer(m_dwSessTime);
   m_nUsrPrmt_DE  := pTable.m_sbyPrmDE;
   m_nUsrPrmt_PE  := pTable.m_sbyPrmPE;
   m_nUsrPrmt_QE  := pTable.m_sbyPrmQE;
   m_nUsrPrmt_CE  := pTable.m_sbyPrmCE;
   m_nUsrPrmt_GE  := pTable.m_sbyPrmGE;
   m_nUsrPrmt_TE  := pTable.m_sbyPrmTE;
   m_nUsrPrmt_CNE := pTable.m_sbyPrmCNE;
   m_nUsrPrmt_PRE := pTable.m_sbyPrmPRE;
   m_nUsrPrmt_QYG := pTable.m_sbyQryGrp;
   m_nUsrPrmt_ACR := pTable.m_sbyAccReg;
end;

procedure CUserControlClass.RunTimer;
begin
   if m_nUserTimer <> nil then m_nUserTimer.RunTimer;
   if m_nHardKeyTimer <> nil then m_nHardKeyTimer.RunTimer;
end;

end.
