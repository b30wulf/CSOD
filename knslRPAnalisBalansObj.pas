unit knslRPAnalisBalansObj;
interface
uses
Windows,Forms, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,
utldatabase,utlTimeDate,utldynconnect, ComObj,StrUtils,  Dialogs, ActiveX;
type
    RPAnalisBalansObj = class
    private
	pAID : Integer;
	m_DB : PCDBDynamicConn;
        procedure  parseXML(subStr : String; offset: Integer; var strRes,strSource : String);
    public
     procedure createBalansReport(month, year, nParam,typeRep: Integer);
     procedure setAbonData(AbonId: Integer; m_DBLink : PCDBDynamicConn);


    public
     constructor Create;
     destructor  Destroy;override;
    End;
implementation
constructor RPAnalisBalansObj.Create;
Begin
End;
destructor  RPAnalisBalansObj.Destroy;
Begin
End;

//-------------------------------------------------------------------------------------------------------------------------------------------------
procedure  RPAnalisBalansObj.setAbonData(AbonId: Integer; m_DBLink : PCDBDynamicConn);
//������ xml ��������� ANSI  <?xml version="1.0"  encoding="windows-1251"?>
Begin
pAID :=AbonId;
m_DB := m_DBLink;
End;
//-----------������������--������-�������-��-����-���������-�--������--������----------------------------------------------------------------------
procedure  RPAnalisBalansObj.createBalansReport(month, year, nParam,typeRep: Integer);
 // nParam - 21 �������� �� ������ ��� +, 22 ����� -, 23 ���������� +,24 ���������� -, pAID - id ����,typeRep - ��� ������(1 - � ��������, 0 - ���)
Var
ulica  : String;
dom     : String;
infMeter, infMeterSupply : ^SL2TAG;//��� � ����� ��
measureMeter1, measureMeter2,measureMeterSupply1,measureMeterSupply2  : MEASUREBALANSREP;//��������� ��
listId             : TThreadList;//������ ��
tampList           : TList;
i,tmpi,j,countOpros,countAll,year2, P1 : Integer;
position           : Integer;
month2             : Integer;
cheak, cheakSupply, cheakIsSupply : Boolean;
sumMat, sumMeter, noBalansAbs, noBalansProc, balansTrue   : Double;
strCheak           : Integer;
isBalansTrue       : String;
m_strCurrentDir    : String;
m_nTypeList, StringList1        : TStringList;
strFileName, strFile , strTempleName,strFileDir       : String;
strDate1, strDate2, strDom,strTypeTchk1 : String;
strUpper,strData,strTempleData,strItogo,strSupply,strnoBalansAbs,strnoBalansProc,strTypeSup,strSerialNumSup,strEnd,strOut : String;
strT0,strT1,strT2,strT3,strT4,strT20,strT21,strT22,strT23,strT24,strT0Potr,strT1Potr,strT2Potr,strT3Potr,strT4Potr : String;
strPrinadleg, strKvarc, strTime1, strTime2,strLicsSup : String;
R:Word;
f,ftest:TextFile;
FileDir:String;
VExcel: Variant;
FCLSID: TCLSID;
Begin
  m_DB.getAbonInfBalans(pAID,ulica,dom);
  listId := TThreadList.Create;
  m_DB.getListMeter(pAID,listId);
  tampList := listId.LockList;

  m_strCurrentDir := ExtractFilePath(Application.ExeName);
  m_nTypeList := TStringList.Create;
  m_nTypeList.loadfromfile(m_strCurrentDir+'\\Settings\\MeterType.dat');

  position := AnsiPos(':',dom);
  strDom := Copy(dom,position+1,Length(dom)-position);

  if(typeRep=1) then
    begin
     //strFileName := '������ ������� ����������� �� ������� '+ ulica +', '+ strDom + ' �� '+ IntToStr(month)+ '_' + IntToStr(year) + '.xls';
     strFileName :='��_�������_'+ ulica +'_'+ strDom + '_��_' + IntToStr(month)+ '_' + IntToStr(year);
     strTempleName := 'report\������_�������_�����������_��_�������.xml';
     P1 := 5;//������ ����� xml �������
    end
  else
    begin
      //strFileName := '������ ������� ����������� '+ ulica +', '+ strDom + ' �� '+ IntToStr(month)+ '_' + IntToStr(year) + '.xls';
      strFileName :=ulica + '_' + strDom + '_��_' + IntToStr(month)+ '_' + IntToStr(year);
      strTempleName := 'report\������_�������_�����������.xml';
      P1 := 3;//������ ����� xml �������
    end;
    strFileName := StringReplace(strFileName,':','_',[rfReplaceAll]);
    strFileName := StringReplace(strFileName,'.','_',[rfReplaceAll]);
    strFileName := StringReplace(strFileName,'"','_',[rfReplaceAll]);
    strFileName := StringReplace(strFileName,'-','_',[rfReplaceAll]);
    strFileName := StringReplace(strFileName,'/','_',[rfReplaceAll]);
    strFileDir := m_strCurrentDir+'ExportData\������_�������_�����������_' + strFileName;
    FileDir:=strFileDir + '.xls';
    AssignFile(f,FileDir);
    Rewrite(f);
    //AssignFile(ftest,'c:\test.txt');
    //Rewrite(ftest);


//-----------xml-read----------------------------------------------------------------------
  StringList1:=TStringList.Create;
  try
     StringList1.LoadFromFile(m_strCurrentDir+strTempleName);
  except
    // ShowMessage('����������� ������ '+'report\������_�������_�����������_��_�������.xml');
    r:= MessageDLG('����������� ������ '+strTempleName, mterror, [mbOK], 0);
    exit;
  end;

  strFile :=   StringList1.Text;
  StringList1.Clear;

  for i:=0 to P1 do
  begin
   parseXML('</Row',5,strUpper,strFile);
   //strUpper: strUlica,strDom, strDate1,strDate2
  end;

  parseXML('</Row',5,strTempleData,strFile);
  parseXML('</Row',5,strItogo,strFile);
  // strItogo: sumMat
  parseXML('</Row',5,strSupply,strFile);
  parseXML('</Row',5,strSupply,strFile);

  strEnd:= strFile; //strNoBalans+ strBalansTrue+ strNoBalansObj:strnoBalansAbs strnoBalansProc countOpros countAll isBalansTrue
  //-------------------------------------------------------------------------------------------
  year2 :=year;
  month2 :=(month mod 12) +1;
  strDate1 := DateToStr(EncodeDate(year, month, 1));
  if(month=12) then year2 := year2+1;
  strDate2 := DateToStr(EncodeDate(year2, month2, 1)-1);

  strUpper := StringReplace(strUpper,'strUlica',ulica,[rfReplaceAll]);
  strUpper := StringReplace(strUpper,'strDom',strDom,[rfReplaceAll]);
  strUpper := StringReplace(strUpper,'strDate1',strDate1,[rfReplaceAll]);
  strUpper := StringReplace(strUpper,'strDate2',strDate2,[rfReplaceAll]);
  Write(f,strUpper);

  sumMat :=0;
  cheakSupply := False;//������ ���������������
  cheakIsSupply := False;//����������������������
  BalansTrue := 0.03; //������� �������������
  countOpros :=0; //����� ��������� �����
  countAll :=0; //����� �������

  for i:=0 to tampList.Count-1 do     //���������� �� ������ ��������
  begin
    tmpi:=0;
    for j:=0 to tampList.Count-1-i do
    begin
      infMeter := tampList[j];
      infMeterSupply := tampList[j+1];
      if(StrToInt(infMeter^.m_sddPHAddres)>StrToInt(infMeterSupply^.m_sddPHAddres)) then
         begin
           tmpi:= tmpi+1;
           tampList[j]:=infMeterSupply;
           tampList[j+1] := infMeter;
         end;
      if(tmpi=0) then break;
    end;
  end;

  for i:=0 to tampList.Count-1 do
     Begin
      infMeter := tampList[i];
      cheak:=True;
      strCheak:=StrToIntDef(infMeter^.m_sTpNum,-1);
      if strCheak = -1 then cheak:=False;


      strTypeTchk1 := infMeter^.m_schName;
      if AnsiPos('��������������',strTypeTchk1)<>0 then //��������������
        begin
         infMeterSupply :=infMeter;
         cheakIsSupply :=True;
         measureMeterSupply1.id_meter := infMeter^.m_swMID;
         measureMeterSupply2.id_meter := infMeter^.m_swMID;
         cheakSupply := m_DB.getMeasureMeter(nParam,month,year,measureMeterSupply1) and m_DB.getMeasureMeter(nParam,month2,year,measureMeterSupply2);
        end
      else
        begin
         if cheak then //�������� �� ����������� �������
          Begin
            countAll := countAll+1;
            strData :=  strTempleData;

            if(typeRep=1) then
              begin
                   //strNo,strType,strSerial
               strData := StringReplace(strData,'strNo',IntToStr(countAll),[rfReplaceAll]);
               strData := StringReplace(strData,'strType',m_nTypeList[infMeter^.typepu],[rfReplaceAll]);
               strData := StringReplace(strData,'strSerial',infMeter^.m_sddFabNum,[rfReplaceAll]);
              end
            else
              begin
              strPrinadleg :='����������� �������';
              strKvarc :='��. �' + infMeter^.m_sddPHAddres;
              //strPrinadleg,,strKvarc,strType,strSerial
              strData := StringReplace(strData,'strPrinadleg',strPrinadleg,[rfReplaceAll]);
              strData := StringReplace(strData,'strKvarc',strKvarc,[rfReplaceAll]);
              strData := StringReplace(strData,'strType',m_nTypeList[infMeter^.typepu],[rfReplaceAll]);
              strData := StringReplace(strData,'strSerial',infMeter^.m_sddFabNum,[rfReplaceAll]);
              end;

            measureMeter1.id_meter := infMeter^.m_swMID;
            measureMeter2.id_meter := infMeter^.m_swMID;
            //������ � ����� ��������� ������
            cheak := m_DB.getMeasureMeter(nParam,month,year,measureMeter1) and m_DB.getMeasureMeter(nParam,month2,year,measureMeter2);
            if cheak then
              begin
                countOpros := countOpros+1;
                measureMeter1.t0 :=  measureMeter1.t1 + measureMeter1.t2 + measureMeter1.t3 + measureMeter1.t4;
                //����� ��������� ������
                measureMeter2.t0 :=  measureMeter2.t1 + measureMeter2.t2 + measureMeter2.t3 + measureMeter2.t4;
                strT0 := FormatFloat('0.##',measureMeter1.t0);
                strT1 := FormatFloat('0.##',measureMeter1.t1);
                strT2 := FormatFloat('0.##',measureMeter1.t2);
                strT3 := FormatFloat('0.##',measureMeter1.t3);
                strT4 := FormatFloat('0.##',measureMeter1.t4);
                strT20 := FormatFloat('0.##',measureMeter2.t0);
                strT21 := FormatFloat('0.##',measureMeter2.t1);
                strT22 := FormatFloat('0.##',measureMeter2.t2);
                strT23 := FormatFloat('0.##',measureMeter2.t3);
                strT24 := FormatFloat('0.##',measureMeter2.t4);
                strT0Potr := FormatFloat('0.##',measureMeter2.t0-measureMeter1.t0);
                strT1Potr := FormatFloat('0.##',measureMeter2.t1-measureMeter1.t1);
                strT2Potr := FormatFloat('0.##',measureMeter2.t2-measureMeter1.t2);
                strT3Potr := FormatFloat('0.##',measureMeter2.t3-measureMeter1.t3);
                strT4Potr := FormatFloat('0.##',measureMeter2.t4-measureMeter1.t4);
                strTime1 := TimeToStr(measureMeter1.datatime);
                strTime2 := TimeToStr(measureMeter2.datatime);
                sumMat := sumMat+ measureMeter2.t0-measureMeter1.t0;
              end
            else
             begin
              strT0 := '-';
              strT1 := '-';
              strT2 := '-';
              strT3 := '-';
              strT4 := '-';
              strT20 := '-';
              strT21 := '-';
              strT22 := '-';
              strT23 := '-';
              strT24 := '-';
              strT0Potr := '-';
              strT1Potr := '-';
              strT2Potr := '-';
              strT3Potr := '-';
              strT4Potr := '-';
              strTime1 := '-';
              strTime2 := '-';
             end;
            if(typeRep=1) then
              begin
                //strT0 strT1 strT2 strT3 strT4 strT20 strT21 strT22 strT23 strT24 strT0Potr strT1Potr strT2Potr strT3Potr strT4Potr
                strData := StringReplace(strData,'strT0',strT0,[rfReplaceAll]);
                strData := StringReplace(strData,'strT1',strT1,[rfReplaceAll]);
                strData := StringReplace(strData,'strT2',strT2,[rfReplaceAll]);
                strData := StringReplace(strData,'strT3',strT3,[rfReplaceAll]);
                strData := StringReplace(strData,'strT4',strT4,[rfReplaceAll]);
                strData := StringReplace(strData,'str2T0',strT20,[rfReplaceAll]);
                strData := StringReplace(strData,'str2T1',strT21,[rfReplaceAll]);
                strData := StringReplace(strData,'str2T2',strT22,[rfReplaceAll]);
                strData := StringReplace(strData,'str2T3',strT23,[rfReplaceAll]);
                strData := StringReplace(strData,'str2T4',strT24,[rfReplaceAll]);
                strData := StringReplace(strData,'strPotr0',strT0Potr,[rfReplaceAll]);
                strData := StringReplace(strData,'strPotr1',strT1Potr,[rfReplaceAll]);
                strData := StringReplace(strData,'strPotr2',strT2Potr,[rfReplaceAll]);
                strData := StringReplace(strData,'strPotr3',strT3Potr,[rfReplaceAll]);
                strData := StringReplace(strData,'strPotr4',strT4Potr,[rfReplaceAll]);
                dispose(infMeter);
              end
            else
              begin
               //strT0,strTime1,strT20,strTime2,strT0Potr
               strData := StringReplace(strData,'strT0',strT0,[rfReplaceAll]);
               strData := StringReplace(strData,'str2T0',strT20,[rfReplaceAll]);
               strData := StringReplace(strData,'strPotr',strT0Potr,[rfReplaceAll]);
               strData := StringReplace(strData,'strTime1',strTime1,[rfReplaceAll]);
               strData := StringReplace(strData,'strTime2',strTime2,[rfReplaceAll]);
              end;
           //strOut:= strOut + strData;
           Write(f,strData);
          End
         else
          begin
           dispose(infMeter);
          end;
        end;

     End;//���������� �����
       strItogo := StringReplace(strItogo,'sumMat',FormatFloat('0.##',sumMat),[rfReplaceAll]);
       //strOut := strOut + strItogo;
       Write(f,strItogo);

      //-----���--���������������--------------------------------------
      if cheakIsSupply then
        begin
          strTypeSup := m_nTypeList[infMeterSupply^.typepu];
          strSerialNumSup :=infMeterSupply^.m_sddFabNum;
          strLicsSup := '��������������';
          noBalansAbs := 0;
          noBalansProc :=0;
          sumMeter :=0;
          if  cheakSupply then
            begin
              measureMeterSupply1.t0 :=  measureMeterSupply1.t1 + measureMeterSupply1.t2 + measureMeterSupply1.t3 + measureMeterSupply1.t4;
              //����� ��������� ������
              measureMeterSupply2.t0 :=  measureMeterSupply2.t1 + measureMeterSupply2.t2 + measureMeterSupply2.t3 + measureMeterSupply2.t4;
              strT0 := FormatFloat('0.##',measureMeterSupply1.t0);
              strT1 := FormatFloat('0.##',measureMeterSupply1.t1);
              strT2 := FormatFloat('0.##',measureMeterSupply1.t2);
              strT3 := FormatFloat('0.##',measureMeterSupply1.t3);
              strT4 := FormatFloat('0.##',measureMeterSupply1.t4);
              strT20 := FormatFloat('0.##',measureMeterSupply2.t0);
              strT21 := FormatFloat('0.##',measureMeterSupply2.t1);
              strT22 := FormatFloat('0.##',measureMeterSupply2.t2);
              strT23 := FormatFloat('0.##',measureMeterSupply2.t3);
              strT24 := FormatFloat('0.##',measureMeterSupply2.t4);
              strT0Potr := FormatFloat('0.##',measureMeterSupply2.t0-measureMeterSupply1.t0);
              strT1Potr := FormatFloat('0.##',measureMeterSupply2.t1-measureMeterSupply1.t1);
              strT2Potr := FormatFloat('0.##',measureMeterSupply2.t2-measureMeterSupply1.t2);
              strT3Potr := FormatFloat('0.##',measureMeterSupply2.t3-measureMeterSupply1.t3);
              strT4Potr := FormatFloat('0.##',measureMeterSupply2.t4-measureMeterSupply1.t4);
              strTime1 := TimeToStr(measureMeterSupply1.datatime);
              strTime2 := TimeToStr(measureMeterSupply2.datatime);
              sumMeter := measureMeterSupply2.t0-measureMeterSupply1.t0;
              noBalansAbs := Abs(sumMat-sumMeter);
              noBalansProc := noBalansAbs/sumMeter;
              if  noBalansProc<=balansTrue then
               begin
                isBalansTrue :='������ ����������';
               end
              else
               isBalansTrue :='������ �� ����������';
              strnoBalansAbs :=FormatFloat('0.##',noBalansAbs);
              strnoBalansProc :=FormatFloat('0.##',noBalansProc*100);
            end
          else
            begin
              isBalansTrue :='������ �� ����������';
              strT0 := '-';
              strT1 := '-';
              strT2 := '-';
              strT3 := '-';
              strT4 := '-';
              strT20 := '-';
              strT21 := '-';
              strT22 := '-';
              strT23 := '-';
              strT24 := '-';
              strT0Potr := '-';
              strT1Potr := '-';
              strT2Potr := '-';
              strT3Potr := '-';
              strT4Potr := '-';
              strnoBalansAbs :='-';
              strnoBalansProc :='-';
              strTime1 := '-';
              strTime2 := '-';
            end;
        end
      else
        begin
          strTypeSup :='-';
          strSerialNumSup :='-';
          isBalansTrue :='������ �� ����������';
          strT0 := '-';
          strT1 := '-';
          strT2 := '-';
          strT3 := '-';
          strT4 := '-';
          strT20 := '-';
          strT21 := '-';
          strT22 := '-';
          strT23 := '-';
          strT24 := '-';
          strT0Potr := '-';
          strT1Potr := '-';
          strT2Potr := '-';
          strT3Potr := '-';
          strT4Potr := '-';
          strnoBalansAbs :='-';
          strnoBalansProc :='-';
          strTime1 := '-';
          strTime2 := '-';
        end;
    if(typeRep=1) then
      begin
        strSupply := StringReplace(strSupply,'strT0',strT0,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strT1',strT1,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strT2',strT2,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strT3',strT3,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strT4',strT4,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'str2T0',strT20,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'str2T1',strT21,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'str2T2',strT22,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'str2T3',strT23,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'str2T4',strT24,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strPotr0',strT0Potr,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strPotr1',strT1Potr,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strPotr2',strT2Potr,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strPotr3',strT3Potr,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strPotr4',strT4Potr,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strTypeSup',strTypeSup,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strSerialSu',strSerialNumSup,[rfReplaceAll]);
      end
    else
     begin
        strSupply := StringReplace(strSupply,'strT0',strT0,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'str2T0',strT20,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strPotr',strT0Potr,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strTypeSup',strTypeSup,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strSerialSu',strSerialNumSup,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strLicsSup',strLicsSup,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strDom',strDom,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strUlica',ulica,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strTime1',strTime1,[rfReplaceAll]);
        strSupply := StringReplace(strSupply,'strTime2',strTime2,[rfReplaceAll]);
     end;
  strEnd := StringReplace(strEnd,'countOpros',IntToStr(countOpros),[rfReplaceAll]);
  strEnd := StringReplace(strEnd,'countAll',IntToStr(countAll),[rfReplaceAll]);
  strEnd := StringReplace(strEnd,'isBalansTrue',isBalansTrue,[rfReplaceAll]);
  strEnd := StringReplace(strEnd,'strnoBalansAbs',strnoBalansAbs,[rfReplaceAll]);
  strEnd := StringReplace(strEnd,'strnoBalansProc',strnoBalansProc,[rfReplaceAll]);

  Write(f,strSupply + strEnd);
  Flush(f);
  CloseFile(f);
  //Flush(ftest);
  //CloseFile(ftest);

  if (CLSIDFromProgID('Excel.Application', FCLSID) <> S_OK) then
    begin
      r:= MessageDLG('��� �������� ������ ���������� ' +
        '����� ������������� ����������� ����������� Microsoft Excel.'#13#10
        +'������������ ������: '+FileDir, mterror, [mbOK], 0);
      exit;
    end;

    VExcel := CreateOleObject('Excel.Application');
    VExcel.Visible := True;
    //��������� Excel �� ������ �����
    VExcel.WindowState := -4137;
    //�� ���������� ��������������� ���������
    VExcel.DisplayAlerts := False;
    //��������� ������� �����
    VExcel.WorkBooks.Open(FileDir);
    //���������� �� ������ ����
    VExcel.WorkSheets[1].Activate;
    //VExcel.WorkBooks[1].SaveAs(FileDir,xlWorkbookNormal);
   // VExcel.WorkBooks[1].add(FileDir);
    VExcel.Qiut;
    VExcel:= NULL;
   // VExcel := Unassigned;
  {
  Excel.Application.EnableEvents := false;
  Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPHourGraphDay.xlt');
  Excel.ActiveSheet.PageSetup.Orientation:= 1;
  Sheet := Excel.Sheets.Item[1];
  Excel.ActiveWorkBook.WorkSheets[1].Activate;
  Sheet.Name := '������ ������� ��������';
  FProgress.Position := 2;
  }
 if listId<>Nil then FreeAndNil(listId);
 if m_nTypeList<>Nil then FreeAndNil(m_nTypeList);
 if StringList1<>Nil then FreeAndNil(StringList1);
End;


//----------------------------------------------------------------------------------------
procedure  RPAnalisBalansObj.parseXML(subStr : String; offset: Integer; var strRes,strSource : String);
var
p1 : Integer;

Begin
p1:=AnsiPos(subStr,strSource);
strRes:=strRes+Copy(strSource, 1,P1+offset);
Delete(strSource, 1, P1+offset);

End;

//-------------------------------------------------------------------------------------------------------------------------------------------------
end.
