unit knslRPErrorMeterRegion;
interface
uses
Windows,Forms, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,
utldatabase,utlTimeDate,utldynconnect, ComObj, StrUtils, Dialogs, ActiveX, Excel2000,
AdvProgr,utlDB;
type
    RPErrorMeterRegion = class
    private
	pAID,regionId : Integer;
	m_DB : PCDBDynamicConn;
	
    public
     procedure createErrorReport(month, year, nParam: Integer;strByDate : string;var AdvProgress: TAdvProgress;ViewReport:boolean);
     procedure setAbonData(AbonId: Integer; m_DBLink : PCDBDynamicConn);
     //procedure createErrorReport2(regionId,month, year, nParam: Integer);
	 procedure setRegionData(regId: Integer; m_DBLink : PCDBDynamicConn);
    public
      IDRegion         : Integer;
      IDDepartament    : Integer;
      NameRegion       : string;
      NameDepartament  : string;
      TypeDR           : Integer;     // 0 - Region, 1 - Departament
      constructor Create;
      destructor  Destroy;override;
    End;
implementation

uses ShellAPI
   { ---------------------------------------------------------------------------
   Use required TXLSFile library units
   --------------------------------------------------------------------------- }
   , XLSFile
   , XLSFormat
   , XLSWorkbook,
   knsl3report;

constructor RPErrorMeterRegion.Create;
Begin
End;
destructor  RPErrorMeterRegion.Destroy;
Begin
End;

//-------------------------------------------------------------------------------------------------------------------------------------------------
procedure  RPErrorMeterRegion.setAbonData(AbonId: Integer; m_DBLink : PCDBDynamicConn);
Begin
pAID :=AbonId;
m_DB := m_DBLink;
regionId := m_DB.getRegionId(pAID);
End;
//-------------------------------------------------------------------------------------------------------------------------------------------------
procedure  RPErrorMeterRegion.setRegionData(regId: Integer; m_DBLink : PCDBDynamicConn);
Begin
m_DB := m_DBLink;
regionId := regId;
End;



//-------------------------------------------------------------------------------------------------------------------------------------------------
procedure  RPErrorMeterRegion.createErrorReport(month, year, nParam: Integer;strByDate : string;var AdvProgress: TAdvProgress;ViewReport:boolean);
var
  m_strCurrentDir       : String;
  strFileName           : String;
  FileDir, strSQL       : String;
  month2,i, Day         : Integer;
  allMeterCount, ID     : Integer;
  strNoDataMeter        : String;
  noDataCount           : Integer;
  StrTmp, strDate       : String;
  RowInTable, TypeML    : integer;
  WB                    : TSheet;
  xf                    : TXLSFile;
  R                     : TRange;
  nCount, AboID         : integer;
  _TOWN, _STREET        : string;
  _HOUSE, _KORP         : string;
  RepName               : string;
  y, m, d               : Word;


  function ToRussia(s: string): string;
  var i : Integer;
  begin
    for i:= 1 to Length(s) do begin
      if s[i] = 'k' then s[i]:='к';
      if s[i] = 'v' then s[i]:='в';
      if s[i] = 'N' then s[i]:='№';
    end;
    Result := s;
  end;
  
Begin
  // если приходит strByDate то ее нужно преобразовать в Day, Month, Year

  if strByDate = '' then Day := 0;
//  else DecodeDate(StrToDate(strByDate), nowYear, nowMonth, nowDay);


  AdvProgress.Position   := 1500;
  m_strCurrentDir := ExtractFilePath(Application.ExeName);
  if strByDate = '' then strDate := IntToStr(month) + '/' + IntToStr(year)
  else strDate := strByDate;


{  if  strByDate = '' then
    strDate := IntToStr(month) + '/' + IntToStr(year)
  else strDate := strByDate; }

  if TypeDR = 0 then begin
    ID := IDRegion;  // ID Region
    RepName := NameRegion;
  end else begin
    ID := IDDepartament;  // ID Departament
    RepName := NameDepartament;
  end;

  if strByDate = '' then strFileName :='Отчет_об_ошибках_'+ RepName + '_за_' + strDate
  else strFileName :='Отчет_об_ошибках_'+ RepName + '_на_' + strDate;

  strFileName := StringReplace(strFileName,':','_',[rfReplaceAll]);
  strFileName := StringReplace(strFileName,'.','_',[rfReplaceAll]);
  strFileName := StringReplace(strFileName,'"','_',[rfReplaceAll]);
  strFileName := StringReplace(strFileName,'-','_',[rfReplaceAll]);
  strFileName := StringReplace(strFileName,'/','_',[rfReplaceAll]);

  if strByDate = '' then begin
  month2 := (month mod 12) +1;
    if (month=12)then year:=year+1;
  end else begin
    DecodeDate(StrToDate(strByDate), y, m, d);
    year := y;
    month2 := m;
    Day := d;
  end;  
  //year:=2019;                        // BO 18.01.19

  FileDir := m_strCurrentDir + 'report\Отчет_об_ошибках.xls';

  xf:= TXLSFile.Create;
  xf.OpenFile(FileDir);
  WB:= XF.Workbook.Sheets[0];          // BeginTable

  R:= WB.Ranges.RangeByName['BeginTable'];
  RowInTable:=R.Rect[0].RowFrom;

{$IFDEF HOMEL}
  TypeML := 0;
{$ELSE}
  TypeML := 1;
{$ENDIF}



  strSQL:='SELECT * FROM GET_METER_ERROR_ALL(' + IntToStr(nParam)+ ', ' +
                                                 IntToStr(Day) + ', ' +
                                                 IntToStr(month2) + ', ' +
                                                 IntToStr(year) + ', ' +
                                                 IntToStr(TypeML) + ', ' +    // TYPEML (0 - HOMEL, 1 - Other)
                                                 IntToStr(TypeDR) + ', ' +
                                                 IntToStr(ID) +')';
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    AboID := utlDB.DBase.IBQuery.FieldByName('ABOID').AsInteger;
    allMeterCount := 0; noDataCount:= 0;
    strNoDataMeter := '';
    for i := 0 to utlDB.DBase.IBQuery.RecordCount-1 do begin
      if (AboID = utlDB.DBase.IBQuery.FieldByName('ABOID').AsInteger) and
         (i < utlDB.DBase.IBQuery.RecordCount-1) then begin
        _TOWN := utlDB.DBase.IBQuery.FieldByName('TOWN').AsString;
        _STREET := utlDB.DBase.IBQuery.FieldByName('STREET').AsString;
        _HOUSE := utlDB.DBase.IBQuery.FieldByName('HOUSE').AsString;
        _KORP := utlDB.DBase.IBQuery.FieldByName('KORP').AsString;
        allMeterCount := utlDB.DBase.IBQuery.FieldByName('NCOUNT').AsInteger;
        noDataCount := utlDB.DBase.IBQuery.FieldByName('NMETER').AsInteger;
        strNoDataMeter := strNoDataMeter + ToRussia(utlDB.DBase.IBQuery.FieldByName('NMETERSTR').AsString);
      end else begin
        if i = utlDB.DBase.IBQuery.RecordCount-1 then begin
          // AboID = 4396   FieldByName('ABOID') = 4811
          if AboID <> utlDB.DBase.IBQuery.FieldByName('ABOID').AsInteger then begin
            WB.Rows.InsertRows(RowInTable,1);
            WB.Rows.CopyRows(RowInTable,RowInTable+1,RowInTable+1);
            WB.Cells[RowInTable,0].Value:=_TOWN;
            WB.Cells[RowInTable,1].Value:=_STREET;
            WB.Cells[RowInTable,2].Value:=_HOUSE;
            WB.Cells[RowInTable,3].Value:=_KORP;
            WB.Cells[RowInTable,4].Value:=IntToStr(allMeterCount);
            WB.Cells[RowInTable,5].Value:=IntToStr(noDataCount);
            if noDataCount = allMeterCount then begin
              strNoDataMeter := 'Нет данных';
              R:= WB.Ranges.Add;
              R.AddRect(RowInTable,RowInTable,0,6);
              R.FillPattern:=xlPatternSolid;
              R.FillPatternBGColorIndex:= xlColorYellow;
              R.Wrap:=true;
            end;
            WB.Cells[RowInTable,6].Value :=strNoDataMeter;
            WB.Rows[RowInTable].AutoFit;
            inc(RowInTable);
          end;
          _TOWN := utlDB.DBase.IBQuery.FieldByName('TOWN').AsString;
          _STREET := utlDB.DBase.IBQuery.FieldByName('STREET').AsString;
          _HOUSE := utlDB.DBase.IBQuery.FieldByName('HOUSE').AsString;
          _KORP := utlDB.DBase.IBQuery.FieldByName('KORP').AsString;
          allMeterCount := utlDB.DBase.IBQuery.FieldByName('NCOUNT').AsInteger;
          noDataCount := utlDB.DBase.IBQuery.FieldByName('NMETER').AsInteger;
          strNoDataMeter := strNoDataMeter + ToRussia(utlDB.DBase.IBQuery.FieldByName('NMETERSTR').AsString);
        end;
        WB.Rows.InsertRows(RowInTable,1);
        WB.Rows.CopyRows(RowInTable,RowInTable+1,RowInTable+1);

        WB.Cells[RowInTable,0].Value:=_TOWN;
        WB.Cells[RowInTable,1].Value:=_STREET;
        WB.Cells[RowInTable,2].Value:=_HOUSE;
        WB.Cells[RowInTable,3].Value:=_KORP;

        WB.Cells[RowInTable,4].Value:=IntToStr(allMeterCount);
        WB.Cells[RowInTable,5].Value:=IntToStr(noDataCount);

        if noDataCount = allMeterCount then begin
          strNoDataMeter := 'Нет данных';
          R:= WB.Ranges.Add;
          R.AddRect(RowInTable,RowInTable,0,6);
          R.FillPattern:=xlPatternSolid;
          R.FillPatternBGColorIndex:= xlColorYellow;
          R.Wrap:=true;
        end;

        WB.Cells[RowInTable,6].Value :=strNoDataMeter;
        WB.Rows[RowInTable].AutoFit;

        AboID := utlDB.DBase.IBQuery.FieldByName('ABOID').AsInteger;
        _TOWN := utlDB.DBase.IBQuery.FieldByName('TOWN').AsString;
        _STREET := utlDB.DBase.IBQuery.FieldByName('STREET').AsString;
        _HOUSE := utlDB.DBase.IBQuery.FieldByName('HOUSE').AsString;
        _KORP := utlDB.DBase.IBQuery.FieldByName('KORP').AsString;
        allMeterCount := utlDB.DBase.IBQuery.FieldByName('NCOUNT').AsInteger;
        noDataCount := utlDB.DBase.IBQuery.FieldByName('NMETER').AsInteger;
        strNoDataMeter := ToRussia(utlDB.DBase.IBQuery.FieldByName('NMETERSTR').AsString);
        inc(RowInTable);
      end;

      utlDB.DBase.IBQuery.Next;
    end;
  end;

  WB.Rows.DeleteRows(RowInTable, RowInTable);

 { R.FillPattern:=xlPatternSolid;
  R.FillPatternBGColorIndex:= xlColorYellow;  }

  StrTmp := WB.Cells[0,0].Value;
  StrTmp := StringReplace(StrTmp,'strDate',strDate,[rfReplaceAll]);
  StrTmp := StringReplace(StrTmp,'strName',RepName,[rfReplaceAll]);
  WB.Cells[0,0].Value := StrTmp;

  AdvProgress.Position   := 7000;

  FileDir:=m_strCurrentDir+'ExportData\' + strFileName + '.xls';

  try
    xf.SaveAs(FileDir);
  except
    MessageDlg('В данный момент отчет с текущим именем открыт в другой сессии' + #13#10 +
               '       закройте открытый файл и повторите попытку' ,mtWarning,[mbYes], 0);
  end;


  if ViewReport then ShellExecute(0, 'open', PChar(FileDir), nil, nil, SW_SHOW);
  AdvProgress.Position   := 10000;
 if xf<>Nil then FreeAndNil(xf); // xf.Free;
end;
//--------------------------------------------------------------------------------------------------------------
end.

