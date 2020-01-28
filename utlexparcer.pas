unit utlexparcer;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlconst,inifiles,Db,ADODB
    ,knsl5tracer, Dates,utlbox, utlTimeDate,math,knsl5config;
type
    CEvaluator = class
    private
     _Stack,Temp: TStringList;
     //Ms : TMemoryStream;
    private
     function  GetPriority( c: char ): byte;
     procedure ParseString;
     function  Calculate: Extended;
     procedure SetVar(const VarName: string; const Value: extended);
     //User Function
     function  Factorial( ch: integer ): integer;
     function  Lim( fV0,fV1,fLim,fPerc:Extended ): Extended;
     function  MLim(fM0,fM1,fV0,fV1,fLim,fPerc:Extended ): Extended;
     procedure Init;
    public
     Expression : String;
     constructor Create;
     destructor Destroy; override;
     function  Value:Extended;
     property Variable[const VarName: string]: extended write SetVar;
    End;
implementation
(* ѕолучение приоритета *)
constructor CEvaluator.Create;
Begin
     Init;
End;

destructor CEvaluator.Destroy;
begin
  if _Stack <> nil then FreeAndNil(_Stack);
  if Temp <> nil then FreeAndNil(Temp);
  inherited;
end;

procedure CEvaluator.Init;
Begin
    _Stack := TStringList.Create;
    Temp := TStringList.Create;
    //Ms := TMemoryStream.Create;
End;
procedure CEvaluator.SetVar(const VarName: string; const Value: extended);
Var
    sStr : String;
    sValue : String;
Begin
    sValue := FloatToStr(Value);
    if Value<0 then sValue := 'neg('+FloatToStr(abs(Value))+')';
    sStr := StringReplace(Expression,VarName,sValue,[rfReplaceAll]);
    Expression := sStr;
End;
function CEvaluator.GetPriority( c: char ): byte;
begin
   Result := 0;
   case c of
      '(': Result := 1;
      '+', '-': Result := 2;
      '*', '/': Result := 3;
      '^', '!': Result := 4;
      'c', 's', 'l', 'L', 'e', 'm', 'M': Result := 5;
      'n': Result := 6;
   end;
end;

(* ѕереводим строку с формулой в обратную польскую запись *)
procedure CEvaluator.ParseString;
var
  flag   : boolean;
  Ms     : TMemoryStream;
  strT   : String;
  ch     : char;
  m_nPRC : TParser;
begin
   Ms := TMemoryStream.Create;
   //TMemoryStream
   Ms.WriteBuffer( Expression[1], Length( Expression ) );
   //Ms.Seek(0, soFromBeginning);
   Ms.Position := 0;
   if Expression='' then exit;
   m_nPRC := TParser.Create( Ms );
   with m_nPRC do
   begin
      while Token <> toEof do
      begin
         // ≈сли это число, помещаем его в выходной стек
         ch := TokenString[1];
         if ( ch in ['0'..'9'] ) then
            if flag then
            begin
               _Stack[_Stack.Count-1] := _Stack[_Stack.Count-1] + TokenString;
               flag := false;
            end
            else
               _Stack.Add( TokenString );
         // ≈сли это разделитель дробной части
         if ( TokenString[1] in [DecimalSeparator] ) then
         begin
            _Stack[_Stack.Count-1] := _Stack[_Stack.Count-1] + TokenString;
            flag := true;
         end;
         // ≈сли это знак (или геометрическа€ функци€), то...
         ch := TokenString[1];
         if ( ch in ['+','-','/','*','^','!','c','s','l','L','n','e','m','M'] ) then
         begin
            // ...если стек пустой, помещаем знак в стек ...
            if Temp.Count = 0 then
               Temp.Add( TokenString )
            else
            begin
               // ... если приоритет текущей операции выше, чем приоритет
               // последней операции в стеке, помещаем знак в стек ...
               if GetPriority( TokenString[1] ) > GetPriority( Temp.Strings[Temp.Count-1][1] ) then
                  Temp.Add( TokenString )
               else
               begin
                  // ... иначе извлекаем из стека все операции, пока
                  // не встретим операцию с более высшим приоритетом
                  while true do
                  begin
                     strT := Temp.Strings[Temp.Count-1];
                     if strT<>',' then _Stack.Add( strT );
                     //_Stack.Add( Temp.Strings[Temp.Count-1] );
                     Temp.Delete( Temp.Count-1 );
                     if Temp.Count = 0 then Break;
                     if GetPriority( TokenString[1] ) > GetPriority( Temp.Strings[Temp.Count-1][1] ) then
                        Break;
                  end;
                  // Ќе забываем добавить в стек текущую операцию
                  Temp.Add( TokenString );
               end;
            end;
         end;
         // ≈сли это открывающа€ скобка, помещаем ее в стек операций
         if ( TokenString[1] in ['('] ) then
            Temp.Add( TokenString );
         // ≈сли это закрывающа€ скобка, извлекаем из стека операций в
         // выходной стек все операции, пока не встретим открывающую скобку.
         // —ами скобки при этом уничтожаютс€.
         if ( TokenString[1] in [')'] ) then
         while true do
         begin
            if Temp.Count = 0 then Break;
            if Temp.Strings[Temp.Count-1] = '(' then
            begin
               Temp.Delete( Temp.Count-1 );
               Break;
            end;
            _Stack.Add( Temp.Strings[Temp.Count-1] );
            Temp.Delete( Temp.Count-1 );
         end;
         NextToken;
      end;
   end;
   // ≈сли по окончании разбора строки с формулой, в стеке операций
   // еще чтото осталось, извлекаем все в выходной стек
   if Temp.Count <> 0 then
      while Temp.Count <> 0 do
      begin
         _Stack.Add( Temp.Strings[Temp.Count-1] );
         Temp.Delete( Temp.Count-1 );
      end;
   m_nPRC.Destroy;
   Ms.Destroy;

end;
(* –ассчитываем выражение в постфиксной форме *)
function CEvaluator.Calculate: Extended;
var
  i: integer;
  a0, a1, a2, a3, a4, a5: Extended;
  strV : String;
begin
   Result := 0;
   for i := 0 to _Stack.Count-1 do
      // ≈сли зто число, помещаем его в стек дл€ рассчета, иначе ...
      if _Stack.Strings[i][1] in ['0'..'9'] then
         Temp.Add( _Stack.Strings[i] )
      else
      begin
         // ... ¬ынимаем из стека рассчета последнее число
         if _Stack.Strings[i][1] in ['m','M'] then
         Begin
          a3 := StrToFloat( Temp.Strings[Temp.Count-1] );
          Temp.Delete( Temp.Count-1 );
          a2 := StrToFloat( Temp.Strings[Temp.Count-1] );
          Temp.Delete( Temp.Count-1 );
          a1 := StrToFloat( Temp.Strings[Temp.Count-1] );
          Temp.Delete( Temp.Count-1 );
          a0 := StrToFloat( Temp.Strings[Temp.Count-1] );
          Temp.Delete( Temp.Count-1 );
         End else
         if _Stack.Strings[i][1] in ['l','L'] then
         Begin
          a1 := StrToFloat( Temp.Strings[Temp.Count-1] );
          Temp.Delete( Temp.Count-1 );
          a0 := StrToFloat( Temp.Strings[Temp.Count-1] );
          Temp.Delete( Temp.Count-1 );
         End else
         Begin
          a2 := StrToFloat( Temp.Strings[Temp.Count-1] );
          Temp.Delete( Temp.Count-1 );
          // если дл€ выполнени€ операции требуетс€ 2 аргумента,
          // вынимаем из стека рассчета еще одно число
          if _Stack.Strings[i][1] in ['+','-','/','*','^',','] then
          begin
           try
           a1 := StrToFloat( Temp.Strings[Temp.Count-1] );
           Temp.Delete( Temp.Count-1 );
           except
            a1 := 0.0;
            Temp.Delete( Temp.Count-1 );
           end
          end;
         End;
         // ѕроизводим рассчет               //function StringReplace(const S, OldPattern, NewPattern: string; Flags: TReplaceFlags): string;
         case _Stack.Strings[i][1] of
            '=': Begin a1:=a2;Temp.Add( FloatToStr( a1 ) );End;
            '+': Temp.Add( FloatToStr( a1 + a2 ) );
            '-': Temp.Add( FloatToStr( a1 - a2 ) );
            '/': Temp.Add( FloatToStr( a1 / a2 ) );
            '*': Temp.Add( FloatToStr( a1 * a2 ) );
            '^': Temp.Add( FloatToStr( Power( a1, a2 ) ) );
            '!': Temp.Add( FloatToStr( Factorial( Round( a2 ) ) ) );
            'c': Temp.Add( FloatToStr( cos( a2 ) ) );
            's': Temp.Add( FloatToStr( sin( a2 ) ) );
            'L','l': Temp.Add( FloatToStr( lim( a0,a1,m_nCF.GetPowLim,m_nCF.GetPowPrc ) ) );
            'M','m': Temp.Add( FloatToStr( MLim( a0,a1,a2,a3,m_nCF.GetPowLim,m_nCF.GetPowPrc ) ) );
            'n': Temp.Add( FloatToStr( -a2 ) );
            'e': Temp.Add( FloatToStr( exp( a2 ) ) );
         end;
      end;
   Result := StrToFloat( Temp.Strings[0] );
   end;
function CEvaluator.Value:Extended;
Begin
    _Stack.Clear;
    Temp.Clear;
    ParseString;
    Temp.Clear;
    Result := Calculate;
    _Stack.Clear;
    Temp.Clear;
End;

function CEvaluator.Factorial( ch: integer ): integer;
var
  i: integer;
begin
   if ch < 0 then
   begin
      Result := 2147483648; // 2147483647 + 1 - выход за пределы integer
      Exit;
   end;
   Result := 1;
   if ch = 0 then
      Exit;
   for i := 1 to ch do
      Result := Result * i;
end;
function CEvaluator.Lim( fV0,fV1,fLim,fPerc:Extended ): Extended;
Var
   fValue : Extended;
Begin
   fValue := fLim+fLim*fPerc/100.0;
   if 2*fV1>fValue then Result := fV0 else
                      Result := fV1;
End;
function CEvaluator.MLim(fM0,fM1,fV0,fV1,fLim,fPerc:Extended ): Extended;
Var
   fValue : Extended;
Begin
   fValue := fLim+fLim*fPerc/100.0;
   if fV1>fValue then Result := fM0 else
                      Result := fM1;
End;

end.
