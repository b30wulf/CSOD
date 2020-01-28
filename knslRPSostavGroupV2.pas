{**
 * Project:     Konus-2000E
 * File:        knslRPSostavGroupV2.pas
 * Description: Модуль отчета "Состав групп (Вид 2)"
 *
 * Delphi version 5
 *
 * Category    Reports
 * Package     RP
 * Author      Petrushevitch Roman <ukrop.gs@gmail.com>
 * Author      $Author$
 * Copyright   2008-2012 Automation-2000, LLC
 *
 * License     Private Licence
 * Version:    2.3.33.763 SVN: $Id$
 * Link        Reports/SostavGroup
 *}

unit knslRPSostavGroupV2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utltypes, utldatabase, utlTimeDate, utlconst;

type
  TRPSostavGroupV2 = class(TForm)
    frReport1   : TfrReport;
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    PH_AbonentName    : String;
    PH_ObjectName     : String;
    PH_AbonentAddress : String;
    PH_ObjectNumber   : String;
    PH_ContractNumber : String;
    PH_CurrentGroupName   : String;
    PH_CurrentGroupConfig : String;
    PH_CurrentGroupNumber : String;
    PH_CurrentMeterName   : String;
    PH_CurrentMeterExpression  : string;

    m_Grid           : PTAdvStringGrid;
    VMeters           : SL3GROUPTAG;
    m_DB               : PCDBDynamicConn;
    FABOID            : Integer;
    procedure FillNameAndConfig(_FullName: String; var _CurrentGroupNumber, _GroupName, _GroupConfig : String);
    function FindNumOfGroups(var str: string):integer;
    function GetGrStartPos(var str: string; stFP: integer):integer;
    procedure GetGrPos(var str:string; stFindPos:integer; var BP, EP : integer);
    function GetGrStringArr(var str : string; maxSymbInStr : integer) : string;
  public
    procedure PrepareTable;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure PrintPreview();
    procedure OnFormResize;
  public
    property PABOID      :Integer          read FABOID       write FABOID;

    property Grid           : PTAdvStringGrid  read m_Grid     write m_Grid;
    property DatabaseLink   : PCDBDynamicConn  read m_DB       write m_DB;

//    property AbonenID       : Integer read m_AbonentID      write m_AbonentID;
    property AbonentName    : String  read PH_AbonentName    write PH_AbonentName;
    property AbonentAddress : String  read PH_AbonentAddress write PH_AbonentAddress;
    property Contract       : String  read PH_ContractNumber write PH_ContractNumber;
    property ObjectName     : String  read PH_ObjectName     write PH_ObjectName;
    property ObjectNumber   : String  read PH_ObjectNumber   write PH_ObjectNumber;

  end;

var
  f_RPSostavGroupV2: TRPSostavGroupV2;
const MAX_STR_CONFIG_LEN : integer = 65;
const strNewLine         : string  = #13;

implementation

{$R *.DFM}

procedure TRPSostavGroupV2.PrepareTable;
var Groups : SL3INITTAG;
    i      : integer;
begin
   if m_Grid=Nil then
     exit;
   m_Grid.ColCount   := 2;
   m_Grid.Cells[0,0] := '№ п.п';
   m_Grid.Cells[1,0] := 'Наименование группы';
   m_Grid.ColWidths[0]  := 30;
   SetHigthGrid(m_Grid^,20);
   if not m_DB.GetAbonGroupsTable(FABOID,Groups) then
     m_Grid.RowCount := 1
   else
   begin
     m_Grid.RowCount := Groups.Count + 1;
     for i := 0 to Groups.Count - 1 do
     begin
       m_Grid.Cells[0, i + 1] := IntToStr(Groups.Items[i].m_sbyGroupID);
       m_Grid.Cells[1, i + 1] := Groups.Items[i].m_sGroupName;
     end;
   end;
   OnFormResize;
end;

procedure TRPSostavGroupV2.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
   for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TRPSostavGroupV2.OnFormResize;
Var
    i : Integer;
Begin
    if m_Grid=Nil then exit;
    for i:=1 to m_Grid.ColCount-1  do m_Grid.ColWidths[i]  := trunc((m_Grid.Width-2*m_Grid.ColWidths[0])/(m_Grid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPSostavGroupV2.PrintPreview();
begin
  if (trim(PH_ContractNumber) <> '') then
    PH_ContractNumber := PH_ContractNumber;
  frReport1.ShowReport();
end;

procedure TRPSostavGroupV2.frReport1ManualBuild(Page: TfrPage);
var i, j      : word;
    Groups    : SL3INITTAG;
begin
 // PH_CurrentGroupNumber := 0;
  Page.ShowBandByType(btReportTitle);

  m_DB.GetAbonGroupsTable(FABOID,Groups);
  for i := 0 to Groups.Count - 1 do
  begin
   // m_DB.GetVMetersTable(FABOID,Groups.Items[i].m_sbyGroupID, VMeters);
    FillNameAndConfig(Groups.Items[i].m_sGroupName, PH_CurrentGroupNumber, PH_CurrentGroupName, PH_CurrentGroupConfig);
   // Inc(PH_CurrentGroupNumber);
    Page.ShowBandByName('MD_Group');
    {
    for j := 0 to VMeters.m_swAmVMeter - 1 do
    begin
      PH_CurrentMeterName := VMeters.Item.Items[j].m_sVMeterName;
      Page.ShowBandByName('MD_Meter');
    end;
    }
  end;
  Page.ShowBandByName('PageFooter1');
end;

procedure TRPSostavGroupV2.frReport1GetValue(const ParName: String; var ParValue: Variant);
var tstr : string;
begin
  if      ParName = 'AbonentName'    then ParValue := PH_AbonentName
  else if ParName = 'AbonentAddress' then ParValue := PH_AbonentAddress
  else if ParName = 'ContractNumber' then ParValue := PH_ContractNumber
  else if ParName = 'ObjectName'     then ParValue := PH_ObjectName
  else if ParName = 'ObjectNumber'   then Parvalue := PH_ObjectNumber
  else if ParName = 'GroupName'      then ParValue := PH_CurrentGroupName
  else if ParName = 'GroupConfig'    then ParValue := GetGrStringArr(PH_CurrentGroupConfig, MAX_STR_CONFIG_LEN)
  else if ParName = 'GroupNumber'    then ParValue := PH_CurrentGroupNumber
  else if ParName = 'MeterName'      then ParValue := PH_CurrentMeterName
  else if ParName = 'Expression'     then ParValue := PH_CurrentMeterExpression
end;

procedure TRPSostavGroupV2.FillNameAndConfig(_FullName: String; var _CurrentGroupNumber, _GroupName, _GroupConfig : String);
var
  l_Count    : Integer;
  i          : Integer;
  fO, fZ, fD : Integer;
begin
  l_Count := Length(_FullName);
  _CurrentGroupNumber := '';
  _GroupName          := '';
  _GroupConfig        := '';
  fO := -1;
  fZ := -1;
  fD := -1;
  for i:=1 to l_Count do
  begin
    if (fO = -1) and (_FullName[i] = '(') then
      fO := i;
    if (fZ = -1) and (_FullName[i] = ')') then
      fZ := i;
    if (fD = -1) and (_FullName[i] = ':') then
      fD := i;
    if (fD = -1) and (i = l_Count) then
      fD := i;
  end;
  _CurrentGroupNumber := Copy(_FullName, fO + 1, fZ - fO - 1);
  if (fD = l_Count) then
  begin
    _GroupName := Copy(_FullName, fZ + 1, fD - fZ);
    _GroupConfig := '(' + _CurrentGroupNumber + ')' + _GroupName;
  end
  else
  begin
    _GroupName := Copy(_FullName, fZ + 1, fD - fZ - 1);
    _GroupConfig := Copy(_FullName, fD + 1, l_Count - fD);
  end;
end;
{+ Гр}
{- Гр}
function TRPSostavGroupV2.FindNumOfGroups(var str: string):integer;
var i, j : integer;
begin
   Result := 1;
   for i := 1 to Length(str) do
   begin
     if (str[i] = '+') or (str[i] = '-') then
       for j := i + 1 to i + 5 do
         if (str[j] = 'Г') and (str[j + 1] = 'р') then
         begin
           Result := Result + 1;
           break;
         end;
   end;
end;

function TRPSostavGroupV2.GetGrStartPos(var str: string; stFP: integer):integer;
var i, j : integer;
begin
   Result := Length(str);
   for i := stFP to Length(str) do
   begin
     if (str[i] = '+') or (str[i] = '-') then
       for j := i + 1 to i + 5 do
         if (str[j] = 'Г') and (str[j + 1] = 'р') then
         begin
            Result := j - 1;
            exit;
         end;
   end;
end;

procedure TRPSostavGroupV2.GetGrPos(var str:string; stFindPos:integer; var BP, EP : integer);
begin
   BP := 0;
   EP := 0;
   BP := GetGrStartPos(str, stFindPos);
   EP := GetGrStartPos(str, BP);
end;

function TRPSostavGroupV2.GetGrStringArr(var str : string; maxSymbInStr : integer) : string;
var nCount, tLen    : integer;
    strArr          : array of string;
    i,stP, eP, iP   : integer;
begin
   Result := '';
   iP     := 1;

   nCount := FindNumOfGroups(str);
   SetLength(strArr, nCount);

   for i := 0 to nCount - 1 do
   begin
      GetGrPos(str, iP, stP, eP);
      strArr[i] := Copy(str, iP, stP - iP + 1);
      iP := stP + 1;
   end;

   Result := strArr[0];
   tLen   := Length(strArr[0]);

   for i := 1 to nCount - 1 do
   begin
      tLen := Length(strArr[i]) + tLen;
      if (tLen > maxSymbInStr) then
      begin
        Result := Result + strNewLine;
        tLen   := 0;
      end;
      Result := Result + strArr[i];
   end;
end;


end.
