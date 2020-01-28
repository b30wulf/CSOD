unit utlStringGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, fLogTypeCommand, utlDB, AdvGrid;

type
  TSG = class
  private
    Grd       : TAdvStringGrid;
    procedure GetSQLColWidth;
    procedure SetSQLColWidth;
    procedure GetNameColumn;
    procedure DelBitmap;
  public
    GrWidth   : array of integer;
    aColCount : integer;
    NameGR    : string;
    procedure Activate(Grid:TAdvStringGrid);
    procedure DeActivate;
    procedure SetColCount(Count : integer);
    procedure SetRowCount;

  end;

implementation

(*
  Проблеммы с модулем, которые пока не удалось решить:
  1) если элемент имеет ширину 0, то это нужно обязательно прописывать
     в тексте программы после вызова SetColCount, иначе при любом новом
     пользователе эти ячейки отобразятся и прибется их скрывать путем
     редавтирования базы данных.
  2) модуль может редактировать только одну таблицу с уникальным именем,
     т.е. две таблицы с обинаковым именем (sgQGroup) создавать нельзя, даже
     если они и находятся в разных модулях.

*)

procedure TSG.Activate(Grid:TAdvStringGrid);
begin
  Grd:=Grid;
  NameGR:=Grd.Name;
end;


procedure TSG.DeActivate;
begin
  SetSQLColWidth;
  DelBitmap;
  Grd:=nil;
  GrWidth:=nil;
end;


procedure TSG.SetColCount(Count: integer);
var i : integer;
begin
  aColCount:=Count;
  Grd.ColCount:=Count;
  SetLength(GrWidth, Count);
  GetSQLColWidth;
  GetNameColumn;
end;

procedure TSG.SetRowCount;
begin
  //
end;

procedure TSG.GetSQLColWidth;
var strSQL,s     : string;
    nCount, i, h : integer;
begin
  for i := 0 to aColCount-1 do GrWidth[i]:= -1;
  strSQL:='SELECT NAME, WIDTH FROM SGWIDTH ' +
          'WHERE NAME LIKE ''' + ansiUpperCase(NameGR)+ '%''' +
          '  AND USERID = ' + intToStr(IDCurrentUser);
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    if nCount > 0 then begin
        for i := 0 to utlDB.DBase.IBQuery.RecordCount-1 do begin
          for h := 0 to aColCount-1 do begin
            s := (ansiUpperCase(NameGR)+ 'COL' + intToStr(h));
            if s = utlDB.DBase.IBQuery.FieldByName('NAME').AsString then begin
              GrWidth[h]:=utlDB.DBase.IBQuery.FieldByName('WIDTH').AsInteger;
              Break;
            end;
          end;
          utlDB.DBase.IBQuery.Next;
        end;
    end;
  end;
  
  for i := 0 to aColCount-1 do begin
    if GrWidth[i] = -1 then begin
      GrWidth[i]:=Grd.DefaultColWidth;
    end;
    Grd.ColWidths[i]:=GrWidth[i];
  end;
end;



procedure TSG.SetSQLColWidth;
var i        : Integer;
    SL       : TStringList;
    nCount   : integer;
begin
  SL := TStringList.Create;
  SL.Add('EXECUTE BLOCK AS BEGIN ');
  for i := 0 to aColCount-1 do begin
    SL.Add('UPDATE OR INSERT INTO SGWIDTH(NAME, USERID, WIDTH) ');
    SL.Add('VALUES(''' + ansiUpperCase(NameGR)+ 'COL' + intToStr(i) + ''', '
                       + IntToStr(IDCurrentUser) + ', ' + IntToStr(GrWidth[i])+ ') matching (NAME, USERID);');
  end;
  SL.Add('END ');
  utlDB.DBase.ExecQrySL(SL);
  SL.Clear;
  SL.Destroy;
end;

procedure TSG.GetNameColumn;
var strSQL, s    : string;
    nCount, i, h : integer;
begin
  strSQL:='SELECT NAME, TEXT FROM SGTEXT ' +
          'WHERE NAME LIKE ''' + ansiUpperCase(NameGR)+ '%''';
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    if nCount > 0 then begin
      for i := 0 to utlDB.DBase.IBQuery.RecordCount-1 do begin
        for h := 0 to aColCount-1 do begin
          if (ansiUpperCase(NameGR)+ 'COL' + intToStr(h)) =  utlDB.DBase.IBQuery.FieldByName('NAME').AsString then begin
            Grd.Cells[i,0]:=utlDB.DBase.IBQuery.FieldByName('TEXT').AsString;
          end;
        end;
        utlDB.DBase.IBQuery.Next;
      end;
    end;
  end;
end;

procedure TSG.DelBitmap;
var i, h : Integer;
begin
  for i := 0 to aColCount-1 do
    if Grd.GetImageIdx(i,0,h) then
      Grd.RemoveImageIdx(i,0);
end;

end.
