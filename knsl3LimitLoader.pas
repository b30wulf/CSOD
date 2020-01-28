unit knsl3LimitLoader;

interface
uses utltypes, utldatabase, utlmtimer, knsl3vparam, knsl3vmeter;
type
   CL3LimLoadModule = class
     private
       procedure LoadAllLimits;
     public
       dt_MinDate   :  TDateTime;
       p_nVM        : ^CVMeters;
       procedure Init;
       function  LoHandler(var pMsg : CMessage) : boolean;
       function  SelfHandler(var pMsg : CMessage) : boolean;
   end;
var L3LimLoadModule : CL3LimLoadModule;
implementation


procedure CL3LimLoadModule.Init;
begin //  m_pDB.GetLimitDatasFromDate
   //MinDate := ;
end;

procedure CL3LimLoadModule.LoadAllLimits;
var pTable : SL3LIMITTAGS;
    i      : integer;
begin
   m_pDB.GetLimitDatasFromDate(dt_MinDate, pTable);
   for i := 0 to pTable.Count - 1 do
   begin

   end;
end;

function CL3LimLoadModule.LoHandler(var pMsg : CMessage) : boolean;
begin

end;

function CL3LimLoadModule.SelfHandler(var pMsg : CMessage) : boolean;
begin

end;

end.
