unit frmProgressBar;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, AdvProgr, StdCtrls, utlDB, ExtCtrls;

type
  TItem = class
    Name  : string;
    ID    : integer;
    Lab   : TLabel;
    PrBar : TAdvProgress;
  end;

  TPrgBar = class(TFrame)
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    List : TList;
    Item : TItem;
    Owner : TFrame;
  public
    FirstStart : boolean;
    Procedure CreateF;
    Procedure Clear;
    Procedure DestroyF;
    Procedure Start(Own : TFrame);
    Function Add(i : integer; NameGr: string; IDGr: integer; Item : TItem):TItem;
    Procedure GetSQL;
  //  Procedure Process(ID : integer; allC, );
  end;

implementation


{$R *.DFM}

{ TFrame2 }

procedure TPrgBar.CreateF;
begin
  List := TList.Create;
end;

procedure TPrgBar.Clear;
var i : integer;
begin
  for i := 0 to List.Count -1  do begin
    Item := TItem(List[i]);
    FreeAndNil(Item.Lab);
    //Item.Lab.Destroy;
    //Item.PrBar.Destroy;
    FreeAndNil(Item.PrBar);
    //Item.Destroy;
    FreeAndNil(Item);
  end;
  List.Clear;
end;


procedure TPrgBar.DestroyF;
begin
  Clear;
  List.Destroy;
end;


function TPrgBar.Add(i : integer; NameGr: string; IDGr: integer; Item : TItem):TItem;
begin
  Item.Lab := TLabel.Create(Owner);
  Item.Lab.Parent:= Owner;
  Item.Lab.Top := 35*i + 8;
  Item.Lab.Left:=10;
  Item.Lab.WordWrap:=false;
  Item.Lab.AutoSize:=true;
  Item.Lab.Caption := NameGr;

  Item.PrBar := TAdvProgress.Create(Owner);
  Item.PrBar.Parent:= Owner;
  Item.PrBar.Top:= 35*i + 25;
  Item.PrBar.Left:=10;
  Item.PrBar.Width := Width - 30;
  Item.PrBar.Height := 16;
  Item.PrBar.Position := 0;
  Item.Lab.Left:=10;

  List.Add(Item);

  Result := item;
end;


procedure TPrgBar.GetSQL;
Var
  i, j, nCount : Integer;
  strSQL       : String;
  NamePlus     : string;
  ID           : integer;
  C1, C2, C3   : integer;
Begin
  if FirstStart then strSQL := 'SELECT QG.NAME, QG.ID, COUNT(L2T.M_SWABOID) as S1, '
  else strSQL := 'SELECT QG.ID, COUNT(L2T.M_SWABOID) as S1, ';
  strSQL := strSQL + 'COUNT(case when L2T.QUERYSTATE=0 then L2T.M_SWABOID end) as S2, ' +
                     'COUNT(case when L2T.QUERYSTATE=2 then L2T.M_SWABOID end) as S3 ' +
                     'FROM QUERYGROUP QG, QGABONS QGA, L2TAG L2T ' +
                     'WHERE QG.ENABLE = 1 AND QG.ID = QGA.QGID ' +
                     '  AND QGA.ENABLE = 1 AND QGA.ABOID = L2T.M_SWABOID ' +
                     'GROUP BY QG.NAME, QG.ID ';

  if utlDB.DBase.OpenQry(strSQL,nCount) = True then Begin
    if nCount > 0 then begin
      if FirstStart then begin // построение таблицы опроса
        clear;
        for i := 0 to utlDB.DBase.IBQuery.RecordCount - 1 do begin
          Item := TItem.Create;
          Item.ID := utlDB.DBase.IBQuery.FieldByName('ID').AsInteger;
          Item.Name := utlDB.DBase.IBQuery.FieldByName('NAME').AsString;
          C1 := utlDB.DBase.IBQuery.FieldByName('S1').AsInteger;
          C2 := utlDB.DBase.IBQuery.FieldByName('S2').AsInteger;
          C3 := utlDB.DBase.IBQuery.FieldByName('S3').AsInteger;
          NamePlus:=Item.Name + ' ' + IntToStr(C1) + ' / ' + IntToStr(C2) + ' / ' + IntToStr(C3);
          Item:=Add(i, NamePlus, Item.ID, Item);
          Item.PrBar.Max:=C1;
          utlDB.DBase.IBQuery.Next;
        end;
      end else begin // просесс опроса
        for i := 0 to utlDB.DBase.IBQuery.RecordCount - 1 do begin
          ID := utlDB.DBase.IBQuery.FieldByName('ID').AsInteger;
          for j := 0 to List.Count - 1 do begin
            Item:=TItem(List[j]);
            if Item.ID = ID then begin
              C1 := utlDB.DBase.IBQuery.FieldByName('S1').AsInteger;
              C2 := utlDB.DBase.IBQuery.FieldByName('S2').AsInteger;
              C3 := utlDB.DBase.IBQuery.FieldByName('S3').AsInteger;
              NamePlus := Item.Name + ' ' + IntToStr(C1) + ' / ' + IntToStr(C2) + ' / ' + IntToStr(C3);
              Item.Lab.Caption := NamePlus;
              Item.PrBar.Position := C2+C3;
            end;
          end;
          utlDB.DBase.IBQuery.Next;
        end;
      end;
    end; //else MessageDlg('Не выбрано не одного объекта для опроса', mtError, [mbOK], 0);
  End;
  utlDB.DBase.CloseQry;
  FirstStart := false;
end;


procedure TPrgBar.Start(Own : TFrame);
begin
  FirstStart := true;
  Owner := Own;
  GetSQL;
end;

procedure TPrgBar.Timer1Timer(Sender: TObject);
begin
  GetSQL;
end;

end.
