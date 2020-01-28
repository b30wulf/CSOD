unit knsl3qwerycell;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  utlbox,utlconst,utldatabase,knsl5tracer,knsl3setgsmtime,knsl3FHModule;
type
    CL3QweryCell = class
    Private
     m_pTable : PSL3QWERYCELLTAG;
     m_pGST   : PSGENSETTTAG;
     m_dwCounter : Dword;
 
     procedure ShedProcess;
     function  FindTime:Integer;
     procedure CreateAction;
     procedure SetTime;
     function  FindMonth(wDayMMask:Dword):Boolean;
     function  FindDay(wDayWMask:Dword):Boolean;
     function  FindTM(dtTime:TDateTime;var nID,nRes:Integer):Boolean;
     procedure ResetAllState;
     procedure AddFindQwery(pVMT:SL3VMTAG);
    Public
     constructor Create;overload;
     procedure Init(var pTable:PSL3QWERYCELLTAG;var pGST:PSGENSETTTAG);
     procedure Run;
    End;
implementation
const
  DeltaFH     : array [0..10] of integer = (1,1,2,3,5, 7, 14, 31, 62, 182, 365);
constructor CL3QweryCell.Create;
Begin
     //inherited;
End;
procedure CL3QweryCell.Init(var pTable:PSL3QWERYCELLTAG;var pGST:PSGENSETTTAG);
Begin
     m_pTable := pTable;
     m_pGST   := pGST;
     m_dwCounter := 0;
     ResetAllState;
End;
procedure CL3QweryCell.ShedProcess;
Begin
     case FindTime of
          1: CreateAction;
          2: SetTime;
     End;
End;
{
SL3VMTAG = packed record
     m_swID       : Integer;
     m_swQCID     : Integer;
     m_swABOID    : Integer;
     m_swVMID     : Integer;
     m_nQryMask0 : int64;
    End;
SL3QWERYCELLTAG = packed record
     m_swID       : Integer;
     m_swQCID     : Integer;
     m_nMonthMask : DWord;
     m_nDayMask   : DWord;
     m_sbyEnable  : Byte;
     m_sVMT       : SL3VMTAGS;
     m_sSDL       : SQRYSDLTAGS;
    End;
}
function  CL3QweryCell.FindTime:Integer;
Var
     Year,Month,Day,Hour,Min,Sec,mSec : Word;
     dtTime : TDateTime;
     wDay,wDayWMask,wDayMMask : Dword;
     nID    : Integer;
     nRes   : Integer;
Begin
     dtTime    := Now;
     nRes      := -1;
     wDayWMask := 1;
     wDayMMask := 1;
     DecodeDate(Now,Year,Month,Day);
     DecodeTime(Now,Hour,Min,Sec,mSec);
     wDay      := DayOfWeek(dtTime);
     wDayWMask := (wDayWMask shl (wDay-1));
     wDayMMask := (wDayMMask shl  (Day-1));
     if FindMonth(wDayMMask) and FindDay(wDayWMask) and FindTM(dtTime,nID,nRes) then exit;
     if FindDay(wDayWMask) and FindTM(dtTime,nID,nRes) then exit;
     if FindTM(dtTime,nID,nRes)=True then exit;
     Result := nRes;
End;
function CL3QweryCell.FindMonth(wDayMMask:Dword):Boolean;
Begin
     Result := ((wDayMMask and MTM_ENABLE)<>0)and((wDayMMask and m_pTable.m_nMonthMask)<>0);
End;
function CL3QweryCell.FindDay(wDayWMask:Dword):Boolean;
Begin
     Result := ((wDayWMask and DYM_ENABLE)<>0)and((wDayWMask and m_pTable.m_nDayMask)<>0);
End;
function CL3QweryCell.FindTM(dtTime:TDateTime;var nID,nRes:Integer):Boolean;
Var
     i : Integer;
     h0,m0,s0,ms0 : Word;
     h1,m1,s1,ms1 : Word;
Begin
     try
     for i:=0 to m_pTable.m_sSDL.Count-1 do
     Begin
      with m_pTable.m_sSDL do
      Begin
       if Items[i].m_sbyState = 0 then
       Begin
        DecodeTime(Items[i].m_sdtEventTime,h0,m0,s0,ms0);
        DecodeTime(dtTime,h1,m1,s1,ms1);
        if (h0=h1)and(m0=m1) then
        Begin
         Items[i].m_sbyState := 1;
         if i>0 then Items[i-1].m_sbyState := 0;
         if i=0 then Items[Count-1].m_sbyState := 0;
         if i=Count-1 then ResetAllState;

         if Items[i].m_sbySynchro=1 then nRes := 2 else
         if Items[i].m_sbyEnable=1  then nRes := 1 else
         if Items[i].m_sbyEnable=0  then nRes := 0;
         
         exit;
        End;
       End;
      End;
     End;
     except
     nRes := 0;
     End;
     nRes := 0;
     Result := (nRes=2)or(nRes=1);
End;
procedure CL3QweryCell.ResetAllState;
Var
     i : Integer;
Begin
     for i:=0 to m_pTable.m_sSDL.Count-1 do m_pTable.m_sSDL.Items[i].m_sbyState := 0;
End;
procedure CL3QweryCell.CreateAction;
Var
     i : Integer;
Begin
     for i:=0 to m_pTable.m_sVMT.Count-1 do AddFindQwery(m_pTable.m_sVMT.Items[i]);
     mL3FHModule.Go;
End;
procedure CL3QweryCell.AddFindQwery(pVMT:SL3VMTAG);
Var
     ldtFTime,ldtETime: TDateTime;
     year,month,day:Word;
Begin
     try
      ldtFTime  := Now;
      if m_pGST.m_sbyDeltaFH>10 then m_pGST.m_sbyDeltaFH := 1;
      if m_pGST.m_sbyDeltaFH=0 then
      Begin
       DecodeDate(Now,year,month,day);
       ldtETime := EncodeDate(year,month,1);
      End else
      if m_pGST.m_sbyDeltaFH<>0 then ldtETime := ldtFTime - DeltaFH[m_pGST.m_sbyDeltaFH];
      mL3FHModule.AddFindAbonHoles(pVMT.m_swABOID,pVMT.m_swVMID,ldtETime,ldtFTime,pVMT.m_nQryMask0)
     except
     end;
End;
procedure CL3QweryCell.SetTime;
Begin
     if m_nGLST<>Nil then
     m_nGLST.SettTime;
End;
procedure CL3QweryCell.Run;
Begin
     if m_pTable<>Nil then
     Begin
      if m_pTable.m_sbyEnable=1 then
      if (m_dwCounter mod 10)=0 then ShedProcess;
     End;
     m_dwCounter := m_dwCounter + 1; 
End;
end.
