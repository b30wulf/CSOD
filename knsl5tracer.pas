unit knsl5tracer;
interface
uses
     Windows, Classes, SysUtils,SyncObjs,stdctrls,Controls, Forms, Dialogs,comctrls,
     utltypes,Grids, BaseGrid, AdvGrid,utlbox,utlconst,graphics,AdvOfficeButtons,knsl3EventBox;
//type

     procedure TraceInit;
     procedure TOnSaveTrace(strFilename:String;blEnable:Boolean);
     procedure TraceM(wLayer :Word; wSI :Integer; strComm :String; pMsg :Pointer);
     procedure TraceL(wLayer :Word; wSI :Integer; str :String);
     procedure TraceMR(wLayer :Word; wSI :Integer; strComm :String; pMsg :Pointer);
     procedure TraceLR(wLayer :Word; wSI :Integer; str :String);
     procedure TraceER(str:String);
     //procedure TraceMessage(wLayer,wSI:Word;strComm:String);
     procedure TraceMessage(strComm : String);
     procedure TextProc(var pMsg:CMessage);
     //function IsOutChecked(wLayer:Word):Boolean;

var
     FOutSrvMonitor : TListView;
     FMonitorIndex  : Integer;
     FFileIndex     : Integer;
//     FcbOutL1       : TAdvOfficeCheckBox;
//     FcbOutL2       : TAdvOfficeCheckBox;
//     FcbOutL3       : TAdvOfficeCheckBox;
//     FcbOutL4       : TAdvOfficeCheckBox;
//     FcbOutL5       : TAdvOfficeCheckBox;
     FcbMaster      : TAdvOfficeCheckBox;
     m_blProtoState : Boolean;
     m_blRemProtoState : Boolean;
     m_nLayerID     : Word;
     m_nSiID        : Integer;
     m_nTMsg        : CMessage;
     m_nTMsg1       : CMessage;


implementation
{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TTracer.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TTracer }


procedure TraceMR(wLayer :Word; wSI :Integer; strComm :String; pMsg :Pointer);
Var
    plMsg  : PCMessage;
    byBuff : PByteArray;
    wLen,i : Integer;
    str1   : String;
Begin
      plMsg   := pMsg;
      byBuff  := pMsg;
      m_nTMsg.m_sbyServerID := wLayer;
      m_nTMsg.m_swObjID     := wSI;
      m_nTMsg.m_sbyFor      := DIR_LHTOLMT;
      for i:=0 to plMsg.m_swLen-1 do strComm := strComm + IntToHex(byBuff[i], 2) + ' ';
      wLen := Length(strComm);
      if wLen>=255 then Begin wLen := Length(strComm);strComm:= 'Wery Long Message!';End;
      Move(strComm[1],m_nTMsg.m_sbyInfo[0],wLen);
      m_nTMsg.m_swLen := 13+wLen;
      SendRMsg(m_nTMsg);
      //str1 := '';for i:=0 to m_nTMsg.m_swLen-1-11 do str1 := str1 + Char(m_nTMsg.m_sbyInfo[i]);
      //TraceMessage(m_nTMsg.m_sbyServerID,m_nTMsg.m_swObjID,strComm);
      //FPUT(BOX_L5_TC,@m_nTMsg);
     //End;
     //m_csOut.Leave;
End;
procedure TraceLR(wLayer :Word; wSI: Integer; str:String);
Var
     wLen,i : Integer;
     str1 : String;
Begin
     m_nTMsg1.m_sbyServerID := wLayer;
     m_nTMsg1.m_swObjID     := wSI;
     m_nTMsg1.m_sbyFor      := DIR_LHTOLMT;
     wLen                   := Length(str);
     if wLen>=255 then Begin wLen := Length(str);str:= 'Wery Long Message!';End;
     Move(str[1],m_nTMsg1.m_sbyInfo[0],wLen);
     m_nTMsg1.m_swLen := 13+wLen;
     SendRMsg(m_nTMsg1);
     //TextProc(m_nTMsg1);
     //str1 := '';for i:=0 to m_nTMsg1.m_swLen-1-11 do str1 := str1 + Char(m_nTMsg1.m_sbyInfo[i]);
     //TraceMessage(m_nTMsg1.m_sbyServerID,m_nTMsg1.m_swObjID,str);
     //FPUT(BOX_L5_TC,@m_nTMsg1);
End;
procedure TextProc(var pMsg:CMessage);
Var
     i      : Integer;
     m_nStr : String;
Begin
     m_nStr := '';
     if pMsg.m_swLen<500 then
     Begin
      for i:=0 to pMsg.m_swLen-1-11 do m_nStr := m_nStr + Char(pMsg.m_sbyInfo[i]);
      TraceL(pMsg.m_sbyServerID,pMsg.m_swObjID,m_nStr);
     End;
End;

procedure TraceInit;
Var
    i : Integer;
Begin
    //m_csOut := TCriticalSection.Create;   Чусть что вернуть
    {
    with FOutSrvMonitor do Begin
    for i:=0 to 10050 do
    Begin
     Items.Add.Caption   := '';
     Items[i].ImageIndex := 0;
     Items[i].SubItems.Add('');
     Items[i].SubItems.Add('');
     Items[i].SubItems.Add('');
     Items[i].SubItems.Add('');
    End;
    End;
    }
    m_blProtoState := True;
End;
procedure PrintHexMsg(strComm : String;pPointer:Pointer;wLen:Word);
Var
   str : String;
   i   : Word;
   byBuff : PByteArray;
Begin
    byBuff := pPointer;
    str := strComm;
    for i:=0 to wLen-1 do str := str + IntToHex(byBuff[i], 2) + ' ';
//    if ((FcbOutL1.Checked=True) and (m_nLayerID=1)) or
//       ((FcbOutL2.Checked=True) and (m_nLayerID=2)) or
//       ((FcbOutL3.Checked=True) and (m_nLayerID=3)) or
//       ((FcbOutL4.Checked=True) and (m_nLayerID=4)) or
//       ((FcbOutL5.Checked=True) and (m_nLayerID=5)) then
//    Begin
//     //TraceMessage(str);
//     if m_blRemProtoState then TraceMessage(str);
//     //if m_blIsSlave=True  then TraceMR(m_nLayerID,m_nSiID,str,pPointer);
//    End;
    //TraceL(m_nLayerID,m_nSiID,str);
End;
procedure Trace(strComm : String);
Begin
    TraceMessage(strComm);
End;
procedure TraceM(wLayer :Word; wSI :Integer; strComm :String; pMsg :Pointer);
Var
    plMsg : PCMessage;
Begin
    //if m_blIsSlave=True then TraceLR(wLayer,wSI,strComm) else
    //Begin
    if m_blProtoState=True then
    Begin
    if m_csOut=nil then exit;
    m_csOut.Enter;
    plMsg := PCMessage(pMsg);
    m_nLayerID := wLayer;
    m_nSiID    := wSI;
    PrintHexMsg(strComm,plMsg,plMsg.m_swLen);
    m_csOut.Leave;
    End;
    //End;
End;
procedure TraceMessage(strComm : String);
Var
    i:Integer;
Begin
    with FOutSrvMonitor do Begin
    Items.Add.Caption   := DateToStr(Date);
    Items[FMonitorIndex].ImageIndex := 0;
    Items[FMonitorIndex].SubItems.Add(TimeToStr(Now));
    //Items[FMonitorIndex].SubItems.Add(IntToStr(m_pB.PDirID));
    Items[FMonitorIndex].SubItems.Add(IntToStr(m_nLayerID));
    Items[FMonitorIndex].SubItems.Add(IntToStr(m_nSiID));
    Items[FMonitorIndex].SubItems.Add(strComm);
    Inc(FMonitorIndex);
    Scroll(0,10);
    if Items.Count>50000 then
     Begin
      for i:=0 to 6000 do
      Items.delete(0);
      FMonitorIndex := Items.Count;
     End;
    End;
    //TListView
End;
procedure TOnSaveTrace(strFilename:String;blEnable:Boolean);
Var
    strPath,str,strCurrentSett : String;
    i:Integer;
    mPidFile : TextFile;
begin
    if m_csOut=nil then exit;
    m_csOut.Enter;
    if FOutSrvMonitor.Items.Count=0 then Begin exit;m_csOut.Leave;End;
    if blEnable=False then strCurrentSett := ExtractFilePath(Application.ExeName) + '\Log\OpcAutoLOG_'+IntToStr(FFileIndex)+'.log';
    if blEnable=True  then strCurrentSett := strFilename;
    Inc(FFileIndex);
    AssignFile(mPidFile,strCurrentSett);
    if strCurrentSett<>'' then Begin
    Rewrite(mPidFile);
    for i:=0 to FOutSrvMonitor.Items.Count-1 do
    Begin
     with FOutSrvMonitor.Items[i] do Begin
     str := Caption+' '+SubItems[0]+' '+SubItems[1]+' '+SubItems[2]+' '+SubItems[3];
     End;
     WriteLn(mPidFile,str);
    End;
    if blEnable=False then
    Begin
     //while FOutSrvMonitor.Items.Count<>0 do FOutSrvMonitor.Items.delete(0);
     //FMonitorIndex:=FOutSrvMonitor.Items.Count;
     //while FOutSrvMonitor.Items.Count<>0 do FOutSrvMonitor.Items.delete(0);
     //FOutSrvMonitor.Items.Clear;
     //FMonitorIndex:=0;
    End;
    End;
    CloseFile(mPidFile);
    m_csOut.Leave;
end;

procedure TraceL(wLayer :Word; wSI :Integer; str :String);
Begin
    if m_blProtoState=True then
    Begin
    if m_csOut=nil then exit;
    m_csOut.Enter;
    m_nLayerID := wLayer;
    m_nSiID    := wSI;
    if m_nLayerID=1 then if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,str);
//    if ((FcbOutL1.Checked=True) and (m_nLayerID=1)) or
//       ((FcbOutL2.Checked=True) and (m_nLayerID=2)) or
//       ((FcbOutL3.Checked=True) and (m_nLayerID=3)) or
//       ((FcbOutL4.Checked=True) and (m_nLayerID=4)) or
//       ((FcbOutL5.Checked=True) and (m_nLayerID=5)) then
//    Begin
//     if m_blRemProtoState then TraceMessage(str);
//     if m_blIsSlave=True  then TraceLR(wLayer,wSI,str);
//    End;
    m_csOut.Leave;
    End;
End;
procedure TraceER(str:String);
Var
    wLayer,wSI:Word;
Begin
    if m_csOut=nil then exit;
    m_csOut.Enter;
    m_nFatalError := m_nFatalError + 1; 
    wLayer :=7;wSI    :=7;
    if m_blRemProtoState then TraceMessage(str);
    if m_blIsSlave=True  then TraceLR(wLayer,wSI,str);
    m_csOut.Leave;
End;
end.
