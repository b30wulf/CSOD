unit utlCEmcosGenTable;

interface

uses
  Forms, ComObj, SysUtils, Dialogs, utldatabase, utltypes;

type
  CEmcosGenTable = class
  private

    Function CreateWord:boolean;
    Function VisibleWord(visible:boolean):boolean;
    Function AddDoc:boolean;
    Function SaveDocAs(file_:string):boolean;
    Function CloseDoc:boolean;
    Function CloseWord:boolean;
    Function StartOfDoc:boolean;
    Function EndOfDoc:boolean;
    Function CreateTable1(NumRows, NumColumns:integer;var index:integer):boolean;
    Function SetSizeTable(Table:integer;RowsHeight, ColumnsWidth:real):boolean;
    Function SetHeightRowTable(Table,Row:integer;RowHeight:real):boolean;
    Function SetWidthColumnTable(Table,Column:integer;ColumnWidth:real):boolean;
    Function SetTextToTable(Table:integer;Row,Column:integer;text:string):boolean;
    Function SetMergeCellsTable(Table:integer;Row1,Column1,Row2,Column2:integer):boolean;

    //Function CreateMeterTable(id:integer; path:String):boolean;


  public
   constructor Create;
   Function CreateMeterTable(id:integer):boolean;
   Function UpdateCode(id:integer):boolean;
    { Public declarations }
  end;

implementation

var W      : variant;

constructor CEmcosGenTable.Create;
Begin

end;

//Function CEmcosGenTable.CreateMeterTable(id:integer; path: String):boolean;
Function CEmcosGenTable.CreateMeterTable(id:integer):boolean;
  var tabl, i, j, k : integer;
      pTableAbon    : SL3ABONS;
      pTableGroup   : SL3INITTAG;
      pTableMeter   : SL3GROUPTAG;
      path, code    : String;
begin
        m_pDB.GetAbonTable(id, pTableAbon);
    m_pDB.GetAbonGroupsTable(id, pTableGroup);
    m_pDB.GetAbonVMetersTable(id, -1, pTableMeter);

    path := ExtractFilePath(Application.ExeName) + 'ExportSettings'+'\';
    path :=path + StringReplace(StringReplace(pTableAbon.Items[0].m_sName, '.', '', [rfReplaceAll]), '"', '', [rfReplaceAll]);
    if CreateWord then
    begin
      //VisibleWord(true);
      If AddDoc then
        begin
          // cсоздаем таблицу
          If CreateTable1(pTableMeter.Item.Count + 2, 3,tabl) then
            begin
              // изменяем размеры таблицы
              SetSizeTable(tabl,25,37);
              SetWidthColumnTable(tabl,1,200);
              SetWidthColumnTable(tabl,2,150);
              SetWidthColumnTable(tabl,3,100);

              // записывает информацию в ячейки таблицы
              SetTextToTable(tabl,1,1,pTableAbon.Items[0].m_sName);

              SetTextToTable(tabl,2,1,'Наименование группы');
              SetTextToTable(tabl,2,2,'Наименование точки учета');
              SetTextToTable(tabl,2,3,'Код точки учета');
              k := 3;

              for i:=0 to pTableGroup.Count - 1 do
                Begin
                  for j:=0 to pTableMeter.Item.Count - 1 do
                    Begin
                      if(pTableGroup.Items[i].m_sbyGroupID = pTableMeter.Item.Items[j].m_sbyGroupID) then
                        Begin
                          SetTextToTable(tabl,k,1,pTableGroup.Items[i].m_sGroupName);
                          SetTextToTable(tabl,k,2,pTableMeter.Item.Items[j].m_sVMeterName);
                          try
                            code := 'B' + IntToStr(StrToInt(pTableMeter.Item.Items[j].M_SMETERCODE)*4 + 1) +
                                  ' - B' + IntToStr(StrToInt(pTableMeter.Item.Items[j].M_SMETERCODE)*4 + 4);
                          except
                            ShowMessage('Обновите данные по каналам!');
                          end;
                          SetTextToTable(tabl,k,3, code);
                          k := k + 1;
                        end;
                    end;

                end;
              // объединяем необходимые ячейки таблицы
              SetMergeCellsTable(tabl,1,1,1,3);
              //SetMergeCellsTable(tabl,3,2,4,2);
            end;
          SaveDocAs(path);
          CloseDoc;
        end;
      CloseWord;
    end;
end;

Function CEmcosGenTable.UpdateCode(id:integer):boolean;
  var i, j, tmp   : integer;
      pTableMeter : SL3GROUPTAG;
      vmid         : Array of Integer;
begin
    m_pDB.GetAbonVMetersTable(id, -1, pTableMeter);
    SetLength(vmid, pTableMeter.Item.Count);
    for i:=0 to  pTableMeter.Item.Count-1 do vmid[i] := pTableMeter.Item.Items[i].m_swVMID;
    //i:= Length(vmid);
    for i:=0 to  pTableMeter.Item.Count - 2 do
      for j:=i + 1 to pTableMeter.Item.Count - 1 do
        if (vmid[i] > vmid[j]) then
          begin
            tmp:=vmid[i];
            vmid[i]:=vmid[j];
            vmid[j]:=tmp;
          end;
    for i:=0 to pTableMeter.Item.Count - 1 do
      Begin
        m_pDB.SetVMeterTableCode(vmid[i], IntToStr(i));
      end;
   SetLength(vmid, 0);
end;

Function CEmcosGenTable.CreateWord:boolean;
begin
    CreateWord:=true;
    try
      W:=CreateOleObject('Word.Application');
      W.Options.CheckGrammarAsYouType:=False;
      W.Options.CheckSpellingAsYouType:=False;
    except
      CreateWord:=false;
    end;
End;

Function CEmcosGenTable.VisibleWord(visible:boolean):boolean;
begin
    VisibleWord:=true;
    try
      W.visible:= visible;
    except
      VisibleWord:=false;
    end;
End;

Function CEmcosGenTable.AddDoc:boolean;
Var Doc_:variant;
begin
    AddDoc:=true;
    try
      Doc_:=W.Documents;
      Doc_.Add;
    except
      AddDoc:=false;
    end;
End;

Function CEmcosGenTable.SaveDocAs(file_:string):boolean;
begin
    SaveDocAs:=true;
    try
      W.ActiveDocument.SaveAs(file_);
    except
      SaveDocAs:=false;
    end;
End;

Function CEmcosGenTable.CloseDoc:boolean;
begin
    CloseDoc:=true;
    try
      W.ActiveDocument.Close;
    except
      CloseDoc:=false;
    end;
End;

Function CEmcosGenTable.CloseWord:boolean;
begin
    CloseWord:=true;
    try
      W.Quit;
    except
      CloseWord:=false;
    end;
End;

Function CEmcosGenTable.StartOfDoc:boolean;
begin
    StartOfDoc:=true;
    try
      W.Selection.End:=0;
      W.Selection.Start:=0;
    except
      StartOfDoc:=false;
    end;
End;

Function CEmcosGenTable.EndOfDoc:boolean;
begin
    EndOfDoc:=true;
    try
      W.Selection.End:=W.ActiveDocument.Characters.Count;
      W.Selection.Start:=W.ActiveDocument.Characters.Count;
    except
      EndOfDoc:=false;
    end;
End;

//----------- Таблицы  --------------------------------------------------
Function CEmcosGenTable.CreateTable1(NumRows, NumColumns:integer;var index:integer):boolean;
begin
    CreateTable1:=true;
    try
      EndOfDoc;
      W.ActiveDocument.Tables.Add(W.Selection.Range, NumRows:=NumRows, NumColumns:=NumColumns);
      index:=W.ActiveDocument.Tables.Count;
      W.ActiveDocument.Tables.Item(index).Borders.Enable:=true;
      W.ActiveDocument.Range.InsertAfter(' ');
    except
      CreateTable1:=false;
    end;
End;

Function CEmcosGenTable.SetSizeTable(Table:integer;RowsHeight, ColumnsWidth:real):boolean;
begin
    SetSizeTable:=true;
    try
      W.ActiveDocument.Tables.Item(Table).Columns.Width:=ColumnsWidth;
      W.ActiveDocument.Tables.Item(Table).Rows.Height:=RowsHeight;
    except
      SetSizeTable:=false;
    end;
End;

Function CEmcosGenTable.SetHeightRowTable(Table,Row:integer;RowHeight:real):boolean;
begin
    SetHeightRowTable:=true;
    try
      W.ActiveDocument.Tables.Item(Table).Rows.item(Row).Height:=RowHeight;
    except
      SetHeightRowTable:=false;
    end;
End;

Function CEmcosGenTable.SetWidthColumnTable(Table,Column:integer;ColumnWidth:real):boolean;
begin
    SetWidthColumnTable:=true;
    try
      W.ActiveDocument.Tables.Item(Table).Columns.Item(Column).Width:=ColumnWidth;
    except
      SetWidthColumnTable:=false;
    end;
End;

Function CEmcosGenTable.SetTextToTable(Table:integer;Row,Column:integer;text:string):boolean;
begin
    SetTextToTable:=true;
    try
      W.ActiveDocument.Tables.Item(Table).Columns.Item(Column).Cells.Item(Row).Range.Text:=text;
    except
      SetTextToTable:=false;
    end;
End;

Function CEmcosGenTable.SetMergeCellsTable(Table:integer;Row1,Column1,Row2,Column2:integer):boolean;
 var cel_:variant;
begin
    SetMergeCellsTable:=true;
    try
      cel_:=W.ActiveDocument.Tables.Item(Table).Cell(Row2,Column2);
      W.ActiveDocument.Tables.Item(Table).Cell(Row1,Column1).Merge(cel_);
    except
      SetMergeCellsTable:=false;
    end;
End;



end.
