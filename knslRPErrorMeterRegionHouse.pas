unit knslRPErrorMeterRegionHouse;
interface
uses
Windows,Forms, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,
utldatabase,utlTimeDate,utldynconnect, ComObj, StrUtils, Dialogs, ActiveX, Excel2000, AdvProgr;
type
    RPErrorMeterRegionHouse = class
    private
	pAID,regionId : Integer;
	m_DB : PCDBDynamicConn;
    public
     procedure createErrorReport(Abon, month, year, nParam: Integer;strByDate : string;var AdvProgress: TAdvProgress;paramwrite:boolean);
     procedure setAbonData(AbonId: Integer; m_DBLink : PCDBDynamicConn);
     //procedure createErrorReport2(regionId,month, year, nParam: Integer);
	 procedure setRegionData(regId: Integer; m_DBLink : PCDBDynamicConn);

    public
     constructor Create;
     destructor  Destroy;override;
    End;
implementation
constructor RPErrorMeterRegionHouse.Create;
Begin
End;
destructor  RPErrorMeterRegionHouse.Destroy;
Begin
End;

//-------------------------------------------------------------------------------------------------------------------------------------------------
procedure  RPErrorMeterRegionHouse.setAbonData(AbonId: Integer; m_DBLink : PCDBDynamicConn);
Begin
pAID :=AbonId;
m_DB := m_DBLink;
regionId := m_DB.getRegionId(pAID);
End;
//-------------------------------------------------------------------------------------------------------------------------------------------------
procedure  RPErrorMeterRegionHouse.setRegionData(regId: Integer; m_DBLink : PCDBDynamicConn);
Begin
m_DB := m_DBLink;
regionId := regId;
End;

//-------------------------------------------------------------------------------------------------------------------------------------------------
procedure  RPErrorMeterRegionHouse.createErrorReport(Abon, month, year, nParam: Integer;strByDate : string;var AdvProgress: TAdvProgress;paramwrite:boolean);
var
houseList             : TThreadList;//список сч
tampList              : TList;
m_strCurrentDir       : String;
strFileName, strFile , strTempleName,strFileDir       : String;
FileDir               : String;
f,ftest               : TextFile;
month2,i, j,allMeterCount           : Integer;
strNoDataMeter        : String;
noDataCount           : Integer;
rowCount, colCount,dataRow : Integer;
FData: Variant;
infHouse: ^REGIONHOUSELIST;//инф о точке уч
r:Word;
VExcel: Variant;
FCLSID: TCLSID;
Sheet,Range: Variant;
listNoDataRow : TList;
StrTmp, strDate : String;
sumProgress,cycleProgress : Double;
Year_, Month_, Day_ : word;
Begin

 try
  ColCount :=7;
  dataRow := 4;
  houseList := TThreadList.Create;

  {if not m_DB.getRegionHouseAbonList(Abon,regionId,houseList)then  //regionId заменить на Abon
          begin
          r:= MessageDLG('Ошибка. Нет данных о доме.', mterror, [mbOK], 0);
          exit;
          end;}
  if not m_DB.getRegionHouseList(regionId,houseList)then
          begin
          r:= MessageDLG('Ошибка. Нет данных о домах.', mterror, [mbOK], 0);
          exit;
          end;        
  AdvProgress.Position   := 1500;
  listNoDataRow := TList.Create; //для выделения отсутств. данных
  tampList := houseList.LockList;
  RowCount :=tampList.Count;
  m_strCurrentDir := ExtractFilePath(Application.ExeName);

  infHouse := tampList[0];

  if  strByDate = '' then strDate := IntToStr(month) + '/' + IntToStr(year)
  else begin strDate := strByDate;
  DecodeDate(StrToDate(strDate), Year_, Month_, Day_);
  end;

  strFileName :='Отчет_об_ошибках_'+infHouse^.region + '_за_' + strDate;
  //strTempleName := 'report\Анализ_баланса_потребления_по_тарифам.xml';


  strFileName := StringReplace(strFileName,':','_',[rfReplaceAll]);
  strFileName := StringReplace(strFileName,'.','_',[rfReplaceAll]);
  strFileName := StringReplace(strFileName,'"','_',[rfReplaceAll]);
  strFileName := StringReplace(strFileName,'-','_',[rfReplaceAll]);
  strFileName := StringReplace(strFileName,'/','_',[rfReplaceAll]);



  month2 :=(month mod 12) +1;
  if (month2=12)then
     year:=year+1;

  //создаем вариантный массив
  FData:=VarArrayCreate([1,RowCount,1,ColCount],varVariant);


  cycleProgress := (7000-AdvProgress.Position)/ tampList.Count;
  sumProgress := AdvProgress.Position;
  for i:=0 to tampList.Count-1 do
       Begin
       strNoDataMeter :='';
       noDataCount :=0;
       infHouse := tampList[i];

        if  strByDate = '' then
         m_DB.getNoDataMeter(nParam,Day_,month2,year,infHouse^.houseId,strNoDataMeter,noDataCount,allMeterCount)
        else m_DB.getNoDataMeterDay(strByDate,infHouse^.houseId,strNoDataMeter,noDataCount);
        m_DB.getNoDataMeter(nParam,Day_,Month_,Year_,infHouse^.houseId,strNoDataMeter,noDataCount, allMeterCount);

        FData[i+1,1]:=infHouse^.town;
        FData[i+1,2]:=infHouse^.ulica;
        FData[i+1,3]:=infHouse^.house;
        FData[i+1,4]:=infHouse^.korpus;
        allMeterCount := m_DB.getCountHouseMeter(infHouse^.houseId);
        FData[i+1,5]:=IntToStr(allMeterCount);
        FData[i+1,6]:=IntToStr(noDataCount);
        if noDataCount = allMeterCount then
                  begin
                  strNoDataMeter := 'Нет данных';
                   listNoDataRow.Add(pointer(i));
                  end;
        FData[i+1,7]:=strNoDataMeter;

       dispose(infHouse);
       sumProgress := sumProgress + cycleProgress;
       AdvProgress.Position   := trunc(sumProgress);
       End;
  AdvProgress.Position   := 7000;

  FileDir := m_strCurrentDir + 'report\Отчет_об_ошибках.xls';
  if (CLSIDFromProgID('Excel.Application', FCLSID) <> S_OK) then
          begin
          r:= MessageDLG('Для формирования отчета необходимо ' +
            'иметь установленное программное обеспечение Microsoft Excel.', mterror, [mbOK], 0);
          exit;
          end;

  VExcel := CreateOleObject('Excel.Application');
  VExcel.Visible := False;
  //Открывать Excel на полный экран
  VExcel.WindowState := -4137;
  //не показывать предупреждающие сообщения
  VExcel.DisplayAlerts := False;

     // if paramwrite then begin
  try
      //Открываем рабочую книгу
      VExcel.WorkBooks.Open(FileDir);
      except
        r:= MessageDLG('Отсутствует шаблон: '+FileDir, mterror, [mbOK], 0);
        exit;
      end;

  //Становимся на первый лист
  Sheet := VExcel.WorkSheets[1];
  Sheet.Activate;


  StrTmp := Sheet.Cells[1,1].Value;
  StrTmp := StringReplace(StrTmp,'strDate',strDate,[rfReplaceAll]);
  Sheet.Cells[1,1].Value := StrTmp;

  Range:=Sheet.Range[Sheet.Cells[dataRow,1],Sheet.Cells[RowCount+dataRow-1,ColCount]];
  Range.Value:=FData;
  //формирование области данных
  Range.Borders.LineStyle := xlContinuous;
  Range.Borders.ColorIndex := 0;
  Range.Borders.TintAndShade := 0;
  Range.Borders.Weight := xlThin;

  Range:=Sheet.Range[Sheet.Cells[dataRow,1],Sheet.Cells[RowCount+dataRow-1,ColCount-1]];
  Range.NumberFormat := '@';
  Sheet.Columns[ColCount].WrapText := True;

  AdvProgress.Position   := 8000;

  for i := 0 to listNoDataRow.Count - 1 do
  Sheet.Range[Sheet.Cells[dataRow+Integer(listNoDataRow[i]),1],Sheet.Cells[dataRow+Integer(listNoDataRow[i]),ColCount]].Interior.Color := rgb(255, 255, 0);

  AdvProgress.Position   := 9000;

  FileDir:=m_strCurrentDir+'ExportData\' + strFileName + '.xls';
  VExcel.WorkBooks[1].SaveAs(FileDir);
   if paramwrite then begin
  VExcel.Visible:=false;
  VExcel.Workbooks[1].Close;
  VExcel.Quit;
  end
  else
  VExcel.Visible := True;
  VExcel := Unassigned;
  AdvProgress.Position   := 10000;
 finally
 if houseList<>Nil then FreeAndNil(houseList);
 if listNoDataRow<>Nil then FreeAndNil(listNoDataRow);
 end;
end;
//--------------------------------------------------------------------------------------------------------------
end.
