unit utlcbox;
interface
uses
SyncObjs,Windows,utltypes,Sysutils,knsl5tracer;
type
    CBox = class
    private
     pb_mBoxCont : array of Byte;
     sCS         : TCriticalSection;
     w_mBoxWrite : DWord;
     w_mBoxRead  : DWord;
     w_mBoxSize  : DWord;
     w_mBoxCSize : DWord;
     w_mBoxMesCt : DWord;
     m_byIsEvent : Boolean;
     w_blSynchro : Boolean;
     w_mEvent    : THandle;
     procedure FDEFINE(w_lBoxSize:DWord);overload;
     procedure FDEFINE(w_lBoxSize:DWord;blSynch:Boolean);overload;
    public
     constructor Create(szSize:Integer);overload;
     constructor Create(szSize:Integer;blSynch:Boolean);overload;
     destructor Destroy;override;
     function FPUT(pb_lInBox:Pointer):Integer;
     function FGET(pb_lInBox:Pointer):Integer;
     function FPUTStk49(pData:CStk49Srez):Integer;
     function FGetSum (dtDate00:TDateTime;var pData:CStk43Srez):Boolean;
     function FGetSum49(dtDate:TDateTime;var pData:CStk49Srez):Boolean;
     function FINDStk49(dtDate:TDateTime;var pData:CStk49Srez):Boolean;
     function FPUTStk43(pData:CStk43Srez):Integer;
     function FINDStk43(dtDate:TDateTime;var pData:CStk43Srez):Boolean;
     procedure FFREE;
     function FCHECK:Integer;
    End;
implementation

constructor CBox.Create(szSize:Integer);
Begin
    FDEFINE(szSize);
End;
constructor CBox.Create(szSize:Integer;blSynch:Boolean);
Begin
    FDEFINE(szSize,blSynch);
End;
destructor CBox.Destroy;
Begin
    SetLength(pb_mBoxCont,0);
    if sCS<>Nil then FreeAndNil(sCS);//sCS.Destroy;
    inherited;
End;
procedure CBox.FDEFINE(w_lBoxSize:DWord);
Begin
    if sCS=Nil then
    Begin
     sCS:=TCriticalSection.Create;
     SetLength(pb_mBoxCont,w_lBoxSize+3000);
     w_mBoxSize  := w_lBoxSize;
     w_mBoxCSize := w_lBoxSize;
     w_mBoxWrite := 0;
     w_mBoxRead  := 0;
     w_mBoxMesCt := 0;
     w_blSynchro := false
    end;
End;
procedure CBox.FDEFINE(w_lBoxSize:DWord;blSynch:Boolean);
Begin
    if sCS=Nil then
    Begin
     sCS:=TCriticalSection.Create;
     SetLength(pb_mBoxCont,w_lBoxSize+3000);
     w_mEvent    := CreateEvent(nil, False, False, nil);
     w_mBoxSize  := w_lBoxSize;
     w_mBoxCSize := w_lBoxSize;
     w_mBoxWrite := 0;
     w_mBoxRead  := 0;
     w_mBoxMesCt := 0;
     w_blSynchro := blSynch;
     ResetEvent(w_mEvent);
    end;
End;
procedure CBox.FFREE;
Begin
    w_mBoxSize  := w_mBoxCSize;
    w_mBoxWrite := 0;
    w_mBoxRead  := 0;
    w_mBoxMesCt := 0;
    if w_blSynchro then ResetEvent(w_mEvent);
End;
function CBox.FCHECK:Integer;
Begin
    result := w_mBoxMesCt;
End;

function CBox.FPUT(pb_lInBox:Pointer):Integer;
Var
    w_lLength:Word;
Begin
    Result := 0;
    if sCS=Nil then exit;
    sCS.Enter;
     Move(pb_lInBox^,w_lLength,2);
     if (w_lLength>w_mBoxSize) or (w_lLength<2) then Begin sCS.Leave;result:=0;FFREE;Exit; End;
     Move(pb_lInBox^,pb_mBoxCont[w_mBoxWrite],w_lLength);
     w_mBoxWrite := w_mBoxWrite + w_lLength;
     w_mBoxSize  := w_mBoxSize  - w_lLength;
     w_mBoxMesCt := w_mBoxMesCt + 1;
     if(w_mBoxWrite>w_mBoxCSize) then w_mBoxWrite := 0;
     if w_blSynchro then SetEvent(w_mEvent);
    sCS.Leave;
    result := 1;
End;
function CBox.FGET(pb_lInBox:Pointer):Integer;
Var
    wLng:Word;
Begin
    if sCS=Nil then exit;
    if w_blSynchro then WaitForSingleObject(w_mEvent,INFINITE);
    sCS.Enter;
     Move(pb_mBoxCont[w_mBoxRead],wLng,2);
     Move(pb_mBoxCont[w_mBoxRead],pb_lInBox^,wLng);
     w_mBoxRead  := w_mBoxRead + wLng;
     w_mBoxSize  := w_mBoxSize + wLng;
     w_mBoxMesCt := w_mBoxMesCt - 1;
     if(w_mBoxRead>w_mBoxCSize) then w_mBoxRead := 0;
     if w_mBoxMesCt=0 then wLng:=0;
     if w_blSynchro then
     Begin
      if w_mBoxMesCt=0 then ResetEvent(w_mEvent) else SetEvent(w_mEvent);
     End;
    sCS.Leave;
    result := wLng;
End;
//CStk49Srez
function CBox.FINDStk49(dtDate:TDateTime;var pData:CStk49Srez):Boolean;
Var
    mBoxWrite : DWord;
    mBoxRead  : DWord;
    mBoxSize  : DWord;
    mBoxCSize : DWord;
    mBoxMesCt : DWord;
    wLng      : Word;
    y0,m0,d0,h0,mi0,s0,ms0:Word;
    y1,m1,d1,h1,mi1,s1,ms1:Word;
Begin
    Result := False;
    if sCS=Nil then exit;
    sCS.Enter;
     mBoxWrite := w_mBoxWrite;
     mBoxRead  := w_mBoxRead;
     mBoxSize  := w_mBoxSize;
     mBoxCSize := w_mBoxCSize;
     mBoxMesCt := w_mBoxMesCt;
     DecodeDate(dtDate,y1,m1,d1);
     DecodeTime(dtDate,h1,mi1,s1,ms1);
     while mBoxMesCt<>0 do
     Begin
      Move(pb_mBoxCont[mBoxRead],wLng,2);
      Move(pb_mBoxCont[mBoxRead],pData,wLng);
      mBoxRead  := mBoxRead + wLng;
      mBoxSize  := mBoxSize + wLng;
      mBoxMesCt := mBoxMesCt - 1;
      if(mBoxRead>mBoxCSize) then mBoxRead := 0;
      //if mBoxMesCt=0 then wLng:=0;
      DecodeDate(pData.DATETIME,y0,m0,d0);
      DecodeTime(pData.DATETIME,h0,mi0,s0,ms0);
      //if (pData.DATETIME-dtDate)=0 then
      if (y0=y1)and(m0=m1)and(d0=d1)and(h0=h1)and(mi0=mi1) then
      Begin
       Result := True;
       sCS.Leave;
       exit;
      End;
     End;
    sCS.Leave;
End;
function CBox.FPUTStk49(pData:CStk49Srez):Integer;
Var
    nData:CStk49Srez;
Begin
    if FINDStk49(pData.DATETIME,nData)=True then Result := 0 else
    Begin
     FPUT(@pData);
     Result := 1;
    End;
End;
//CStk43Srez
function CBox.FINDStk43(dtDate:TDateTime;var pData:CStk43Srez):Boolean;
Var
    mBoxWrite : DWord;
    mBoxRead  : DWord;
    mBoxSize  : DWord;
    mBoxCSize : DWord;
    mBoxMesCt : DWord;
    wLng      : Word;
    y0,m0,d0,h0,mi0,s0,ms0:Word;
    y1,m1,d1,h1,mi1,s1,ms1:Word;
Begin
    Result := False;
    if sCS=Nil then exit;
    sCS.Enter;
     mBoxWrite := w_mBoxWrite;
     mBoxRead  := w_mBoxRead;
     mBoxSize  := w_mBoxSize;
     mBoxCSize := w_mBoxCSize;
     mBoxMesCt := w_mBoxMesCt;
     DecodeDate(dtDate,y1,m1,d1);
     DecodeTime(dtDate,h1,mi1,s1,ms1);
     while mBoxMesCt<>0 do
     Begin
      Move(pb_mBoxCont[mBoxRead],wLng,2);
      Move(pb_mBoxCont[mBoxRead],pData,wLng);
      mBoxRead  := mBoxRead + wLng;
      mBoxSize  := mBoxSize + wLng;
      mBoxMesCt := mBoxMesCt - 1;
      if(mBoxRead>mBoxCSize) then mBoxRead := 0;
      //if mBoxMesCt=0 then wLng:=0;
      DecodeDate(pData.DATETIME,y0,m0,d0);
      DecodeTime(pData.DATETIME,h0,mi0,s0,ms0);
      //if (pData.DATETIME-dtDate)=0 then
      if (y0=y1)and(m0=m1)and(d0=d1)and(h0=h1)and(mi0=mi1) then
      Begin
       Result := True;
       sCS.Leave;
       exit;
      End;
     End;
    sCS.Leave;
End;


function CBox.FPUTStk43(pData:CStk43Srez):Integer;
Var
    nData:CStk43Srez;
Begin
    if FINDStk43(pData.DATETIME,nData)=True then Result := 0 else
    Begin
     FPUT(@pData);
     Result := 1;
    End;
End;

function  CBox.FGetSum (dtDate00 :TDateTime;var pData:CStk43Srez):Boolean;
Var
    mBoxWrite : DWord;
    mBoxRead  : DWord;
    mBoxSize  : DWord;
    mBoxCSize : DWord;
    mBoxMesCt : DWord;
    wLng      : Word;
    y0,m0,d0,h0,mi0,s0,ms0:Word;
    y1,m1,d1,h1,mi1,s1,ms1,i:Word;
    Sum :Double;

Begin
    Result := False;
    Sum :=0; i:=0;
     mBoxWrite := w_mBoxWrite;
     mBoxRead  := w_mBoxRead;
     mBoxSize  := w_mBoxSize;
     mBoxCSize := w_mBoxCSize;
     mBoxMesCt := w_mBoxMesCt;
     DecodeDate(dtDate00,y1,m1,d1);
     DecodeTime(dtDate00,h1,mi1,s1,ms1);
     while mBoxMesCt<>0 do
     Begin
      Move(pb_mBoxCont[mBoxRead],wLng,2);
      Move(pb_mBoxCont[mBoxRead],pData,wLng);
      mBoxRead  := mBoxRead + wLng;
      mBoxSize  := mBoxSize + wLng;
      mBoxMesCt := mBoxMesCt - 1;
      if(mBoxRead>mBoxCSize) then mBoxRead := 0;
      //if mBoxMesCt=0 then wLng:=0;
      DecodeDate(pData.DATETIME,y0,m0,d0);
      DecodeTime(pData.DATETIME,h0,mi0,s0,ms0);
      //if (pData.DATETIME-dtDate)=0 then
      if (y0=y1)and(m0=m1)and(d0=d1) then
      Begin
       Result := True;
       Sum:= Sum + pData.dbEnergy;
       //TraceL(3, 3,'('+IntToStr(i)+') Summa DT :'+ DateTimeToStr(pData.DATETIME+1)+  ' En: '+FloatToStr(pData.dbEnergy)+  ' Sum: '+FloatToStr(Sum));
       //i := i + 1;
      End;
     End;
     pData.dbEnergy := Sum;
     if (sum=0)  then Result:=False;
     if (sum<>0) then Result:=true;
End;


function CBox.FGetSum49(dtDate:TDateTime;var pData:CStk49Srez):Boolean;
Var
    mBoxWrite : DWord;
    mBoxRead  : DWord;
    mBoxSize  : DWord;
    mBoxCSize : DWord;
    mBoxMesCt : DWord;
    wLng      : Word;
    y0,m0,d0,h0,mi0,s0,ms0:Word;
    y1,m1,d1,h1,mi1,s1,ms1:Word;
    i :integer;
    Sum :array[0..3] of Double;
    SumEnergy  : Double;
Begin
    Result := False;
    if sCS=Nil then exit;
    sCS.Enter;
     mBoxWrite := w_mBoxWrite;
     mBoxRead  := w_mBoxRead;
     mBoxSize  := w_mBoxSize;
     mBoxCSize := w_mBoxCSize;
     mBoxMesCt := w_mBoxMesCt;
     DecodeDate(dtDate,y1,m1,d1);
     DecodeTime(dtDate,h1,mi1,s1,ms1);
     while mBoxMesCt<>0 do
     Begin
      Move(pb_mBoxCont[mBoxRead],wLng,2);
      Move(pb_mBoxCont[mBoxRead],pData,wLng);
      mBoxRead  := mBoxRead + wLng;
      mBoxSize  := mBoxSize + wLng;
      mBoxMesCt := mBoxMesCt - 1;
      if(mBoxRead>mBoxCSize) then mBoxRead := 0;
      //if mBoxMesCt=0 then wLng:=0;
      DecodeDate(pData.DATETIME,y0,m0,d0);
      DecodeTime(pData.DATETIME,h0,mi0,s0,ms0);
      //if (pData.DATETIME-dtDate)=0 then
      if (y0=y1)and(m0=m1)and(d0=d1) then
      Begin
       Result := True;
       for i:=0 to 3 do
       Sum[i]:= Sum[i] + pData.dbEnergy[i];
       //TraceL(3, 3,'('+IntToStr(i)+') Summa DT :'+ DateTimeToStr(pData.DATETIME+1)+  ' En: '+FloatToStr(pData.dbEnergy)+  ' Sum: '+FloatToStr(Sum));
       //i := i + 1;
      End;
     End;
     for i:=0 to 3 do
     begin
     pData.dbEnergy[i] := Sum[i];
     SumEnergy:=SumEnergy+Sum[i];
     if (SumEnergy<>0) then Result:=true
     else if (SumEnergy=0)  then Result:=False;
     end;

End;


end.
