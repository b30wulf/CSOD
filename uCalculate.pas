
{******************************************************************************}
{                                                                              }
{                                                                              }
{                       Модуль системы обработки данных.                       }
{                                                                              }
{                                                                              }
{                                                                              }
{                                                                              }
{                Copyright (C) 2003 год, ООО "АВТОМАТИЗАЦИЯ 2000"              }
{                                                                              }
{******************************************************************************}

Unit uCalculate;

Interface

Uses Windows, ADODB, classes, sysutils, Forms, Controls, Dialogs, DB;

Function CreateFormula(lvl : integer; co : Double) : String;
Procedure CalculateGraphics(D : TDateTime);
Procedure CalculateSumGraphics(D : TDateTime);
Procedure CalculateGraphicsResult(D : TDateTime);
Procedure CalculatePoints;
Function CreateQueryForGraphics(D : TDateTime; Var pCount : integer) : Boolean;
Procedure ExtractPoints(Frml : String; Var expr : String; Var SL,
  PL : TStringList);
Procedure Analizing;
Procedure ChangeShiftCorr;
Procedure Str2Arr(sourcestr : String; Var p : Array Of byte);
Function Arr2Str(Var p : Array Of byte) : String;
Implementation

Uses
  umain, uADODBs, uAlarms, uMessages, uTypes, uSystem, uNewWindow, uEvent,
  uNewScheme, uCRC_DB;

//расчетная часть

//Создается формула для расчетов. Номера точек заменяются на реальные значения Val

Function CreateFormula(lvl : integer; co : Double) : String;
Var
  i                 : Integer;
  Len               : Word;
  frml, str, ins    : String;
  npi               : Integer;
  nds, nps          : String;
  b                 : Boolean;
Begin
  With ADODbs Do Begin
    frml := PointsByLevelFormula.AsString;
    i := Pos('[x]', frml);
    If i > 0 Then Begin
      delete(frml, i, 3);
      ins := floattostr(co);
      insert(ins, frml, i);
    End;
    If lvl = 0 Then Begin
      Result := frml;
      Exit;
    End;
    Len := Length(frml);
    nds := '';
    nps := '';
    b := false;
    str := '';
    For i := 1 To Len Do Begin
      If (Not (frml[i] In ['[', ']', ':'])) Then
        If b Then nps := nps + frml[i] Else str := str + frml[i];
      If frml[i] = '[' Then Begin
        nps := '';
        b := true;
      End
      Else
        If frml[i] = ']' Then Begin
          npi := strtoint(nps);
          b := false;
          If sqlFormulaPoints.Locate('N_point', npi, []) Then str := str + sqlFormulaPointsVal.AsString
          Else str := str + '0';
        End;
    End;
  End;
//!!! в формулах могут быть запятые, например в LIM  for i:=1 to length(str) do if str[i]=#44 then str[i]:=#46;
  Result := str;
End;

//перерасчет графиков по формуле

Procedure CalculateGraphics(D : TDateTime);
Var
  nd, np, i, c      : Integer;
  co, res           : Double;
//  csm               : smallint;
  step              : Integer;
// nd, np, i, c ,l: Integer;
// co,summ,val : Double;
Begin
  With frmMain, ADODBs Do try
    RefreshStatus(stCalcGraphics);
    GraphUpdateName := GetGraphBDName(D);
//    CheckGraphDB(GraphUpdateName);
    CheckGraphDB(D);
    ADOGraphics.Open;
    step := 1;
    frmMain.GCalc.MaxValue := ADOGraphics.RecordCount;
    frmMain.GCalc.Progress := 0;
    PointsByLevel.Open;
    InsertSumGraphics.Close;
    While Not ADOGraphics.Eof Do Begin
      //поиск формулы
      nd := ADOGraphics.Fields[0].AsInteger; // ('N_Dir')
      np := ADOGraphics.Fields[1].AsInteger; // ('N_Point')
      D := ADOGraphics.Fields[2].Value; // UDate;
      GraphUpdateName := GetGraphBDName(D);
//      CheckGraphDB(GraphUpdateName);
      CheckGraphDB(D);
      PointsByLevel.Locate('N_dir;N_point', VarArrayOf([nd, np]), []);
      InsertSumGraphics.Parameters[1].Value := nd; //dir
      InsertSumGraphics.Parameters[2].Value := np; //point
      InsertSumGraphics.Parameters[3].Value := D; //data

      //обновление графиков в существующем графике
//      if (Trunc(D)*1.0)=(Trunc(Now)*1.0)
//        then c:=Graphics.FieldByName('CurHH').Value
//        else c:=47;

      c := ADOGraphics.FieldByName('CurHH').Value;

      //CurHH
      InsertSumGraphics.Parameters[52].Value := c; //CurHH
      InsertSumGraphics.Parameters[105].Value := c; //CurHH
      //TarifType
      InsertSumGraphics.Parameters[53].Value := CurrentTariff;
      InsertSumGraphics.Parameters[106].Value := CurrentTariff;
      //GrState
      InsertSumGraphics.Parameters[56].Value := 1; //grstate
      InsertSumGraphics.Parameters[109].Value := 1; //grstate

      For i := 0 To 47 Do Begin
        Res := 0;
        If (i <= c) And (Not ADOGraphics.Fields[3 + i].IsNull) Then Try
          co := ADOGraphics.Fields[3 + i].Value;
          Parser.Formula := CreateFormula(0, co);
          Parser.ReCalc;
          Res := Parser.Value;
        Except
        End;

        InsertSumGraphics.Parameters[i + 4].DataType := ftFloat;
        InsertSumGraphics.Parameters[i + 4].Value := Res;
        InsertSumGraphics.Parameters[i + 57].DataType := ftFloat;
        InsertSumGraphics.Parameters[i + 57].Value := Res;

      End;
      //summ

      Try
        co := ADOGraphics.Fields[53].AsFloat;

        Parser.Formula := CreateFormula(0, co);
        Parser.ReCalc;

        InsertSumGraphics.Parameters[54].Value := Parser.Value; //summ
        InsertSumGraphics.Parameters[107].Value := Parser.Value; //summ
      //counter
        InsertSumGraphics.Parameters[55].Value := 0; //null;  //counter
        InsertSumGraphics.Parameters[108].Value := 0; //null;  //counter
        InsertSumGraphics.Parameters.ParamByName('Result').Value := 0;

        InsertSumGraphics.ExecSQL;

        SetCRCGraphics(integer(InsertSumGraphics.Parameters[2].Value), InsertSumGraphics.Parameters[3].Value);

      Except
      End;

      ADOGraphics.Next;

      GCalc.AddProgress(step);
      GCalc.Repaint;
      //Application.ProcessMessages;

    End;
    ADOGraphics.Close;
    PointsByLevel.Close;
    RefreshStatus(stNoCalc);
  except
  End;                                  //with frmMain
End;

//в случае неполных данных лдя расчетов в поле GRState поставить 2

//перерасчет суммарных графиков за указанную дату

Procedure CalculateSumGraphics(D : TDateTime);
Var
  i, j              : Integer;
  s                 : Double;
  V                 : Array[0..47] Of Double;
  Ps                : String;
  step              : Integer;
  pCount            : integer;
  CurHH             : integer;
Begin
  With frmMain, ADODBS Do Begin
    RefreshStatus(stCalcGraphics);
    GraphUpdateName := GetGraphBDName(D);
    CheckGraphDB(D);
    QueryFormula.DisableControls;
    QueryForGraphics.DisableControls;
    QueryFormula.Open;
    step := 1;
    GCalc.MaxValue := QueryFormula.RecordCount;
    GCalc.Progress := 0;
    LackPoints := '';
    QueryFormula.First;
    While Not QueryFormula.eof Do Begin
      s := 0;
      For j := 0 To 47 Do v[j] := 0;
      pCount := 0;
      If Not CreateQueryForGraphics(D, pCount) Then Begin
        QueryFormula.Next;
        Continue;
      End
      Else Begin
        QueryForGraphics.First;
        CurHH := 47;
        While Not QueryForGraphics.Eof Do Begin
          j := QueryForGraphics.Fields[51].AsInteger;
          If (j > 2) And (j < CurHH) Then CurHH := j; //find min nonzero
          QueryForGraphics.Next;
        End;
        QueryForGraphics.First;
      End;
      Parser.Formula := Expression;
      For j := 0 To 47 Do Begin
        If QueryForGraphics.Locate('n_point', strtoint(Params[0]), []) Then
          If QueryForGraphics.Fields[3 + j].IsNull Then Ps := 'P' + Params[0] + '=0'
          Else Ps := 'P' + Params[0] + '=' + QueryForGraphics.Fields[3 + j].AsString
        Else Begin
          Ps := 'P' + Params[0] + '= 0';
          LackPoints := LackPoints + Params[0] + '|';
        End;

        For i := 1 To Params.Count - 1 Do Begin
          If QueryForGraphics.Locate('n_point', strtoint(Params.Strings[i]), []) Then
            If QueryForGraphics.Fields[3 + j].IsNull Then Ps := Ps + '|P' + Params[i] + '=0'
            Else Ps := Ps + '|P' + Params[i] + '=' + QueryForGraphics.Fields[3 + j].AsString
          Else Begin
            Ps := Ps + '|P' + Params[i] + '= 0';
            LackPoints := LackPoints + Params[i] + '|';
          End;
        End;                            //for i
        Parser.Parameters := Ps;
        Parser.ReCalc;
        V[j] := Parser.Value;
        s := s + v[j];
      End;                              //for j

      //n_dir
      InsertSumGraphics.Parameters[1].Value := QueryFormula.Fields[0].Value;
      //n_point
      InsertSumGraphics.Parameters[2].Value := QueryFormula.Fields[1].Value;
      //udate
      InsertSumGraphics.Parameters[3].Value := D;
      //CurrHH
//      if (Trunc(D)*1.0)=(Trunc(Now)*1.0)
//        then begin
//          InsertSumGraphics.Parameters[52].Value:=QueryForGraphics.Fields[51].AsInteger;
//          InsertSumGraphics.Parameters[105].Value:=QueryForGraphics.Fields[51].AsInteger;//0
//        end
//        else begin
      If pCount = 0 Then CurHH := 0;
      InsertSumGraphics.Parameters[52].Value := CurHH; //47;
      InsertSumGraphics.Parameters[105].Value := CurHH; //47;
//        end;//
      //TarifType
      InsertSumGraphics.Parameters[53].Value := CurrentTariff;
      InsertSumGraphics.Parameters[106].Value := CurrentTariff; //0
      //summ
      InsertSumGraphics.Parameters[54].Value := s;
      InsertSumGraphics.Parameters[107].Value := s;
      //counter
      InsertSumGraphics.Parameters[55].Value := 0;
      InsertSumGraphics.Parameters[108].Value := 0;
      //GrState
      InsertSumGraphics.Parameters[56].Value := 0; //trunc((curHH+1)/48*100);
      InsertSumGraphics.Parameters[109].Value := 0; //trunc((curHH+1)/48*100);
      //V0..V47
      For i := 0 To 47 Do Begin
        InsertSumGraphics.Parameters[i + 4].DataType := ftFloat;
        InsertSumGraphics.Parameters[i + 57].DataType := ftFloat;
        InsertSumGraphics.Parameters[4 + i].Value := v[i];
        InsertSumGraphics.Parameters[57 + i].Value := v[i];
      End;

      InsertSumGraphics.Parameters.ParamByName('Result').Value := 0;
      InsertSumGraphics.ExecSQL;
      SetCRCGraphics(integer(InsertSumGraphics.Parameters[2].Value), InsertSumGraphics.Parameters[3].Value);
      QueryFormula.Next;
      GCalc.AddProgress(step);
      GCalc.Repaint;
      //Application.ProcessMessages;
    End;
    QueryFormula.Close;
    QueryForGraphics.EnableControls;
    QueryFormula.EnableControls;
    RefreshStatus(stNoCalc);
  End;                                  //with frmMain
End;

//Рассчет контрольной суммы для графиков за указанную дату

Procedure CalculateGraphicsResult(D : TDateTime);
Var
  step              : word;
Begin
  ADODBs.GraphUpdateName := ADODBs.GetGraphBDName(D);
  With ADODBs.sqlPointsToGraphics Do Begin
    SQL.Clear;
    SQL.Add('select n_point, UDate');
    SQL.Add('from ' + ADODBs.GraphUpdateName);
    SQL.Add('where (uDate=:nd)');
    Parameters.ParamByName('nd').DataType := ftDateTime;
    Parameters.ParamByName('nd').Value := trunc(D) * 1.0;

    Try
      open;

      frmMain.RefreshStatus(stCalcGraphics);
      frmMain.GCalc.MaxValue := RecordCount;
      frmMain.GCalc.Progress := 0;
      step := 1;
      While Not EOF Do Begin
        SetCRCGraphics(Fields[0].AsInteger, Fields[1].Value);
        next;
        frmMain.GCalc.AddProgress(step);
      End;
      frmMain.RefreshStatus(stNoCalc);
    Finally
      close;
    End;

  End;
End;

//Производится перасчет точек по формулам.
//Исходное значение берется из поля Code и записывается в поле Val

Procedure CalculatePoints;
Var
  nd, np, l, i, j, st : Integer;
  co                : Real;
  ss                : String;
  step              : Integer;
  s                 : Real;
Begin
  DecimalSeparator := '.';
  With frmMain Do Begin
    With ADODBs Do Begin
      PointsByLevel.Open;
      step := 1;
      GCalc.MaxValue := PointsByLevel.RecordCount;
      GCalc.Progress := 0;
      RefreshStatus(stCalcPoints);
      l := PointsByLevel.Fields[0].AsInteger; //p_level

      While Not PointsByLevel.Eof Do Begin

        nd := PointsByLevel.Fields[1].AsInteger; // ('N_Dir')
        np := PointsByLevel.Fields[2].AsInteger; // ('N_Point')
        If l <> PointsByLevel.Fields[0].AsInteger Then Begin //p_level
          l := PointsByLevel.Fields[0].AsInteger; //p_level
          sqlFormulaPoints.Close;
          sqlFormulaPoints.Parameters[0].Value := l;
          sqlFormulaPoints.Open;
        End;

        If Not PointsByLevel.Fields[4].IsNull {Code} Then Begin
          st := 0;
          co := PointsByLevel.Fields[4].Value
        End Else Begin
          st := ord(l = 0);
          co := 0;
        End;

        Parser.Formula := CreateFormula(l, co);
        Try
          Parser.ReCalc;
        Except
          st := 1;
          frmMessages.AddMsg('Ошибка при расчете точки ' + IntToStr(nd) + ':' + IntToStr(np));
        End;

        Try
          s := Parser.Value;
          UpdatePoints.Parameters[0].Value := s; //.ParamByName('Value')
          UpdatePoints.Parameters[1].Value := Now; // .ParamByName('ATime')
//        UpdatePoints.Parameters[2].Value:=nd; // ('Dir')
          UpdatePoints.Parameters[2].Value := st; // ('State')
          UpdatePoints.Parameters[3].Value := np; // ('Point')
          UpdatePoints.ExecSQL;

          If (CurHalfHour.HalfH >= 0) And (CurHalfHour.HalfH < 26) Then Begin
            If (Not PointsByLevelLimHi.IsNull) And Config.GetLimit(CurHalfHour.HalfH + 1) Then If (s > PointsByLevelLimHi.AsFloat) Then Begin
                RaizeEvent(101, PointsByLevelfName.AsString, PointsByLeveln_point.AsInteger, true);
              End
              Else If (s > (PointsByLevelLimHi.AsFloat * Config.ApproachLimit / 100)) Then Begin
                RaizeEvent(102, PointsByLevelfName.AsString, PointsByLeveln_point.AsInteger, true);
              End;
          End Else Begin
            If (Not PointsByLevelLimLo.IsNull) And Config.GetLimit(CurHalfHour.HalfH + 1) Then If (s > PointsByLevelLimLo.AsFloat) Then Begin
                RaizeEvent(101, PointsByLevelfName.AsString, PointsByLeveln_point.AsInteger, true);
              End
              Else If (s > (PointsByLevelLimLo.AsFloat * Config.ApproachLimit / 100)) Then Begin
                RaizeEvent(102, PointsByLevelfName.AsString, PointsByLeveln_point.AsInteger, true);
              End;
          End;

        Except
        End;

        GCalc.AddProgress(step);
        GCalc.Repaint;
        //Application.ProcessMessages;

        PointsByLevel.Next;

      End;

      PointsByLevel.Close;
      sqlFormulaPoints.Close;

      // Update CurHalfh with Points data
      GraphUpdateName := GetGraphBDName(Now);
//      CheckGraphDB(GraphUpdateName);
      CheckGraphDB(Now);
      With sqlPointsToGraphics Do Try
        If Active Then Close;
        SQL.Clear;
        SQL.Add('UPDATE ' + GetGraphBDName(Now));
        i := TimeToHH(Now);
        ss := 'SUMM= V0';
        If i > 0 Then For j := 1 To i Do ss := ss + '+V' + IntToStr(j);
        SQL.Add('SET V' + IntToStr(i) + '= val ,' + ss + ', CurHH=1');
        SQL.Add('FROM ' + GetGraphBDName(Now) + ' G, Points P');
        SQL.Add('Where G.uDate=:nd AND g.n_Point=p.n_point');
        Parameters.ParamByName('nd').DataType := ftDateTime;
        Parameters.ParamByName('nd').Value := trunc(Now) * 1.0;

        ExecSQL;

        CalculateGraphicsResult(Now);

        // Test Today graphics and create if need to
        If (RowsAffected = 0) Then Begin
          SQL.Clear;
//          SQL.Add('select n_dir, n_point');
//          SQL.Add('from points P,types T, Connections c');
//          SQL.Add('where (P.p_type = T.p_type) AND (t_graphic=1)');

          SQL.Add('SELECT P.N_DIR, P.N_POINT, P.P_TYPE, T.T_GRAPHIC, P.N_CON, c.N_CONNECTION');
          SQL.Add('FROM CONNECTIONS c CROSS JOIN');
          SQL.Add('POINTS P INNER JOIN');
          SQL.Add('TYPES T ON P.P_TYPE = T.P_TYPE AND P.N_CON = c.N_CONNECTION');
          SQL.Add('WHERE (T.T_GRAPHIC = 1)');
          open;
          While Not EOF Do Begin
            sqlAddGraphic.Parameters[0].Value := Fields[0].AsInteger;
            sqlAddGraphic.Parameters[1].Value := Fields[1].AsInteger;
            sqlAddGraphic.Parameters[2].Value := trunc(Now) * 1.0;
            sqlAddGraphic.ExecSQL;
            SetCRCGraphics(integer(sqlAddGraphic.Parameters[1].Value), sqlAddGraphic.Parameters[2].Value);
            next;
          End;
          close;
        End;

      Except;
      End;
    End;
    RefreshStatus(stNoCalc);
  End;                                  //with frmMain
End;

//выбирает все графики за указанную дату и номера точек у которых
//соответствуют номерам точек в формуле
//True когда количество полученных графиков равно количеству точек в формуле

Function CreateQueryForGraphics(D : TDateTime; Var pCount : integer) : Boolean;
Var
  s                 : String;
  i                 : Integer;
Begin
  With frmMain Do
    With ADODBs Do Begin
      List.Clear;
      Params.Clear;
      ExtractPoints(QueryFormula.Fields[2].Value, Expression, List, Params);
      pCount := List.Count;
      If List.Count > 0 Then Begin
        s := 'where (' + List.Strings[0];
        For i := 1 To List.Count - 1 Do Begin
          s := s + ' or ' + List.Strings[i];
        End;
        s := s + ') and (UDate=:nd)';
      End Else s := 'where (UDate=:nd)';
      QueryForGraphics.Close;
      QueryForGraphics.SQL.Clear;
      QueryForGraphics.SQL.Add('select * from ' + GraphUpdateName);
      QueryForGraphics.SQL.Add(s);
      QueryForGraphics.Parameters.ParamByName('nd').DataType := ftDateTime;
      QueryForGraphics.Parameters.ParamByName('nd').Value := trunc(d) * 1.0;
      QueryForGraphics.Open;
      result := (pCount > 0) And (QueryForGraphics.RecordCount > 0); //(List.Count=QueryForGraphics.RecordCount);
    End;
End;

//Извлекает номера точек из формулы

Procedure ExtractPoints(Frml : String; Var expr : String; Var SL,
  PL : TStringList);
Var
  Len               : Word;
  b                 : Boolean;
  i                 : Integer;
  str, nps          : String;
Begin
  i := Pos('[x]', frml);
  If i > 0 Then delete(frml, i, 3);

  str := '';
  Len := Length(frml);
  nps := '';
  b := false;
  For i := 1 To Len Do Begin
    If (Not (frml[i] In ['[', ']', ':'])) Then
      If b Then nps := nps + frml[i]
      Else str := str + frml[i];
    If frml[i] = '[' Then Begin
      nps := '';
      b := true;
    End
    Else
      If frml[i] = ']' Then Begin
        SL.Add('(n_point=' + nps + ')');
        PL.Add(nps);
        str := str + 'P' + nps;
        nps := '';
        b := false;
      End;
  End;
  expr := str;
End;

//Определение смещения времени счетчиков относительно времени компьютера

Procedure ChangeShiftCorr;
Var
  i, j, k           : byte;
  shift             : integer;
  col               : byte;
  delta             : Array[0..4, 0..255] Of integer;
Begin
    // Обнулить смещение смещение
  For i := 0 To Systems.Count - 1 Do
    For j := 0 To Systems.GetSystem(i).Abonents.Count - 1 Do
      With Systems.GetSystem(i).Abonents.GetAbonent(j) Do Begin
        AbntTime.ShiftCorr := 0;
      End;
  // Определение необходимости вычисления смещения времени
  If Systems.fShiftCorr Then Begin
    // Заполнение рабочей таблицы данными абонентов
    k := 0;
    For i := 0 To Systems.Count - 1 Do Begin
      For j := 0 To Systems.GetSystem(i).Abonents.Count - 1 Do Begin
        // Отброс неактивных и неответивших абонентов из списка абонентов,
        // учавствующих в коррекции времени
        If (Systems.GetSystem(i).Abonents.GetAbonent(j).Active) And
          (Systems.GetSystem(i).Abonents.GetAbonent(j).OnceAnswered) Then Begin
          delta[0, k] := i;             // номер системы
          delta[1, k] := j;             // номер абонента
          Systems.GetSystem(i).Abonents.GetAbonent(j).AbntTime.TimeCorr :=
            round((double(Systems.GetSystem(i).Abonents.GetAbonent(j).AbntTime.TimeOfAsk)
            - double(Systems.GetSystem(i).Abonents.GetAbonent(j).AbntTime.TimeOfAbnt)) * MSecsPerDay / 1000);
          delta[2, k] := Systems.GetSystem(i).Abonents.GetAbonent(j).AbntTime.TimeCorr;
          delta[3, k] := 0;             // среднее арифметическое всех активных, за исключение текущего
          delta[4, k] := 0;             // учавствует в расчете смещения
          inc(k);
        End;
      End;
    End;

    // Определение смещения системы счетчиков относительно компьютерного времени
    // Отбросить счетчики со значительным отклонением относительно среднего арифметического
    col := k;
    While (col > 1) Do Begin
      For i := 0 To k - 1 Do
        If delta[4, i] = 0 Then Begin
          delta[3, i] := 0;
          For j := 0 To k - 1 Do
            If (delta[4, j] = 0) And ((j <> i) Or (col = 2)) Then delta[3, i] := (delta[3, i] + delta[2, j]);
          If col = 2 Then delta[3, i] := delta[3, i] Div 2
          Else delta[3, i] := delta[3, i] Div (col - 1);
        End;

      shift := -1;
      For i := 0 To k - 1 Do
        If (shift < abs(delta[3, i] - delta[2, i])) And (delta[4, i] = 0) Then shift := abs(delta[3, i] - delta[2, i]);

      If shift > 10 Then Begin
        For i := 0 To k - 1 Do
          If (shift = abs(delta[3, i] - delta[2, i])) And (delta[4, i] = 0) Then Begin
            col := col - 1;
            delta[4, i] := 1;
          End;
      End
      Else break;                       //shift<=10
    End;

    shift := 0;
    If (col > 1) Or (k = 1) Then Begin
      For i := 0 To k - 1 Do
        If delta[4, i] = 0 Then shift := shift + delta[2, i];
      shift := shift Div col;
    End;

    // Занести вычисленное смещение
    For i := 0 To Systems.Count - 1 Do
      For j := 0 To Systems.GetSystem(i).Abonents.Count - 1 Do
        With Systems.GetSystem(i).Abonents.GetAbonent(j) Do Begin
          AbntTime.ShiftCorr := shift;
          If (Systems.GetSystem(i).CorrFlags And FC_CompCorr) = 0 Then AbntTime.TimeCorr := AbntTime.TimeCorr - AbntTime.ShiftCorr;
        End;

    Systems.fShiftCorr := false;
  End;                                  {then Systems.fShiftCorr}
End;

//Перерасчет полученных значений по формулам

Procedure Analizing;
Var
  i                 : Integer;
//  j                 : word;
  s, e              : TTime;
  r                 : Boolean;
  da                : TDateTime;
//  temp              : String;
Begin
  With frmMain Do Begin
    RefreshStatus(StNoPolling);
    If isAnalize Then Exit;
    isAnalize := true;
    Screen.Cursor := crAppStart;
    RaizeEvent(12, '', 0, false);
    s := Now;
    AnalizingStartedAt := Now;
    Try
      r := true;
      If Config.ClearServerLog Then ADODBs.TruncateLog;
      CalculatePoints;
//!!! null onAbntTimeout       ADODBs.sqlNullCode.ExecSQL;

      If GrCalc Then Begin

        For i := 0 To Systems.Count - 1 Do
          r := r And (Not Systems.GetSystem(i).IsPolling);

        If r Then Begin
          GrCalc := false;
          da := Trunc(GrCalcDate) * 1.0;
          CalculateGraphics(da);

          Try
            ADODBs.GrphicsTmpByDate.open;
            While Not ADODBs.GrphicsTmpByDate.Eof Do Begin
              da := ADODBs.GrphicsTmpByDateuDate.Value;
              CalculateSumGraphics(da);
              ADODBs.GrphicsTmpByDate.Next;
            End;
          Finally
            ADODBs.GrphicsTmpByDate.close;
          End;
          ADODBs.ClearGraphics.ExecSQL; //!!!??? а может все-таки оставлять их
        End;

        If isGraphPollNow Then Begin
          EnablePollCommands(true);
          isGraphPollNow := false;
        End;
      End;
      RefreshWindow;

      RefreshStatus(stNoCalc);

      e := Now;
      RaizeEvent(13, 'Время расчета ' + formatdatetime('hh ч nn м ss с zzz мс', e - s), 0, false);
      ADODBs.TbSchemePoints.close;
      ADODBs.TbSchemePoints.open;
      If Assigned(ActiveMDIChild) Then
        If (ActiveMDIChild Is TfrmNewWindow) Then (ActiveMDIChild As TfrmNewWindow).Redraw
        Else
          If (ActiveMDIChild Is TfrmNewWindow) Then (ActiveMDIChild As TfrmNewScheme).Redraw;
    Except
      On E : Exception Do Begin
        frmMessages.AddMsg(E.Message);
        Logger.Add(E.Message);
      End;
    End;

    Screen.Cursor := crDefault;
    isAnalize := false;

  End;                                  //with frmMain
End;

Procedure Str2Arr(sourcestr : String; Var p : Array Of byte);
Var
  i, j              : byte;
  tempstr           : String;
Begin
  Try
    j := 0;
    tempstr := '';
    For i := 1 To Length(sourcestr) Do
      If sourcestr[i] In ['0'..'9'] Then Begin
        tempstr := tempstr + sourcestr[i];
      End
      Else
        If sourcestr[i] = ' ' Then Begin
          If Length(tempStr) > 0 Then p[j] := strtoint(tempstr);
          inc(j);
          tempstr := '';
        End;
  Except
    MessageDlg('Error in transformation string to array (procedure Str2Arr) !', mtError, [mbOK], 0);
  End;
End;

Function Arr2Str(Var p : Array Of byte) : String;
Var
  fstr              : String;
  i                 : byte;
Begin
  Try
    fstr := '';
    For i := 0 To Length(p) - 1 Do fstr := fstr + inttostr(p[i]) + ' ';
    result := fstr;
  Except
    MessageDlg('Error in transformation array to string  (function Arr2Str) !', mtError, [mbOK], 0);
    result := '';
  End;
End;

End.

