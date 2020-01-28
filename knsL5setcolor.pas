unit knsL5setcolor;
interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlconst,inifiles,Db,ADODB
    ,AdvGrid,Dates,utlbox, utlTimeDate,utldynconnect,utldatabase,knsl5tracer,AdvAppStyler,AdvStyleIF;
type
    CSetColor = class
    Private
      //FTreeModule     :PTTreeView;
      FTreeModuleData :PTTreeView;
      SgParam         :PTAdvStringGrid;
      SgMeterType     :PTAdvStringGrid;
      SgChannels      :PTAdvStringGrid;
      SgMeters        :PTAdvStringGrid;
      SgGroup         :PTAdvStringGrid;
      SgAbon          :PTAdvStringGrid;
      SgVMeters       :PTAdvStringGrid;
      SgCNMeters      :PTAdvStringGrid;
      SgTariffType    :PTAdvStringGrid;
      SgConnList      :PTAdvStringGrid;
      SgVParam        :PTAdvStringGrid;
      SgTariff        :PTAdvStringGrid;
      SgQMCommand     :PTAdvStringGrid;
      SgCommands      :PTAdvStringGrid;
      SgCGrid         :PTAdvStringGrid;
      SgEGrid         :PTAdvStringGrid;
      SgPGrid         :PTAdvStringGrid;
      SgVGrid         :PTAdvStringGrid;
      Fsgsyazone      :PTAdvStringGrid;
      FsgSznDay       :PTAdvStringGrid;
      FsgTransTime    :PTAdvStringGrid;
      //report
      FSgStatistics   :PTAdvStringGrid;
      FSgCalcMoney    :PTAdvStringGrid;
      FSgGroups       :PTAdvStringGrid;
      FSgGroupsV2     :PTAdvStringGrid;
      FSgVMeters      :PTAdvStringGrid;
      FSgRasxMonth    :PTAdvStringGrid;
      FSgRasxMonthZab :PTAdvStringGrid;
      FSgRasxEnergy2  :PTAdvStringGrid;
      FSgMaxControl   :PTAdvStringGrid;
      FSgMaxDay2      :PTAdvStringGrid;
      FSgVectorD      :PTAdvStringGrid;
      FSgRasxMonthV3  :PTAdvStringGrid;
      FSgAllGraphs    :PTAdvStringGrid;
      FSgHourGenOut   :PTAdvStringGrid;
      FSgVedomPokazV2 :PTAdvStringGrid;
      FSgUsing        :PTAdvStringGrid;
      FPageRp         :PTPageControl;
      FSgExpenseDay   :PTAdvStringGrid;
      FSgRasxDay      :PTAdvStringGrid;
      FSgIncrementDay :PTAdvStringGrid;
      FSgSizeEnergy   :PTAdvStringGrid;
      FsgGomelAktive  :PTAdvStringGrid;
      FsgGomelReact   :PTAdvStringGrid;
      FSGValidInfo    :PTAdvStringGrid;
      FSGValidSlices  :PTAdvStringGrid;
      FsgGraphDay     :PTAdvStringGrid;
      FsgGraphDayME   :PTAdvStringGrid;
      FSGKorTime      :PTAdvStringGrid;
      fsgTeploMoz     :PTAdvStringGrid;
      fsgVedomPokaz   :PTAdvStringGrid;
      fsgPowerHourMTZ :PTAdvStringGrid;
      fsgCalcHeatMTZ  :PTAdvStringGrid;
      fsgTechYchetMTZ :PTAdvStringGrid;
      fsgPowerLimit   :PTAdvStringGrid;
      fsg3PowerAndLimit:PTAdvStringGrid;
      fsgMaxPowerComp :PTAdvStringGrid;
      fsgSummVedom    :PTAdvStringGrid;
      fsgCheckValData :PTAdvStringGrid;
      fsgHomeBalanse  :PTAdvStringGrid;
      fsgBalanseDay  :PTAdvStringGrid;
      fsgCheckPowerSyst :PTAdvStringGrid;
      FAdvStringGrid1 :PTAdvStringGrid;
      FAdvStringGrid2 :PTAdvStringGrid;
      //event
      FSgGrid         :PTAdvStringGrid;
      FSgGridEvent    :PTAdvStringGrid;
      //statistic
      FSgStatistic    :PTAdvStringGrid;
      FSgQryTable     :PTAdvStringGrid;
      FsgLimitEdtor   :PTAdvStringGrid;
      FSGLimitView    :PTAdvStringGrid;
      FCHandgeAT      :PTAdvStringGrid;
      FCHandgeDT      :PTAdvStringGrid;
      FRegion         :PTAdvStringGrid;
      //dataframe
       FSGDataFrameTable  : PTAdvStringGrid;
       FAdvFormStyler     : PAdvFormStyler;
       FReportFormStyler  : PAdvFormStyler;
       FCofigStyler       : PAdvFormStyler;
       FGraphStyler       : PAdvFormStyler;
       FMonitorStyler     : PAdvFormStyler;
       FEventStyler       : PAdvFormStyler;
       FLightStyler       : PAdvFormStyler;
       FQweryMdlstyler    : PAdvFormStyler;
       FStatisticaStyler  : PAdvFormStyler;
       FDataStyler        : PAdvFormStyler;
       FUserStyler        : PAdvFormStyler;
       FAbonStyler        : PAdvFormStyler;
       FAddPortStyler     : PAdvFormStyler;
       FEventBoxStyler    : PAdvFormStyler;
       FRedactorStyler    : PAdvFormStyler;
       FConnStyler        : PAdvFormStyler;
       FSManStyler        : PAdvFormStyler;
       FConfMeterStyler   : PAdvFormStyler;
       FMainEditorStyler  : PAdvFormStyler;
       FLimitStyler       : PAdvFormStyler;
       FChandgeStyler     : PAdvFormStyler;
       FRegionStyler      : PAdvFormStyler;
       FVectorStyler      : PAdvFormStyler;
       FControlStyler     : PAdvFormStyler;
       FGomelBalansStyle  : PAdvFormStyler;
       FHideCtrlFrStyle   : PAdvFormStyler;
       FSchemEditor       : PAdvFormStyler;
    Public
      procedure SetFontColor(GetCol:integer);
      procedure SetColorPanel(pTab:SCOLORSETTTAG);
      procedure SetFontName(GetFName :string);
      procedure SetFontSize(GetFsize:integer);
      procedure FontName(FName:string);
      function  SetColorPPanel(var mCL : SCOLORSETTTAG):Boolean;
      function  SetAllHigthGrid(nHigth:Integer):integer;
      function  SetReportHigthGrid(nHigth:Integer):integer;
      function  SetEventHigthGrid(nHigth:Integer):integer;
      function  SetEventsHigthGrid(nHigth:Integer):integer;
      function  SetStatisticHigthGrid(nHigth:Integer):integer;
      procedure SetColorSettings(var mCL : SCOLORSETTTAG);
      procedure SetAllStyle(nstyle:integer);
      procedure SaveStyle(style:integer);
      procedure SetReportColorFont(GetCol:integer);
      procedure SetAutoTheme;
    Public
      //property PTreeModule :PTTreeView          read FTreeModule       write FTreeModule;
      property PTreeModuleData :PTTreeView      read FTreeModuleData   write FTreeModuleData;
      property PSgParam :PTAdvStringGrid        read SgParam           write SgParam;
      property PSgMeterType :PTAdvStringGrid    read SgMeterType       write SgMeterType;
      property PSgChannels :PTAdvStringGrid     read SgChannels        write SgChannels;
      property PSgMeters :PTAdvStringGrid       read SgMeters          write SgMeters;
      property PSgGroup :PTAdvStringGrid        read SgGroup           write SgGroup;
      property PSgAbon  :PTAdvStringGrid        read SgAbon            write SgAbon;
      property PSgVMeters :PTAdvStringGrid      read SgVMeters         write SgVMeters;
      property PSgCNMeters :PTAdvStringGrid     read SgCNMeters        write SgCNMeters;
      property PSgTariffType :PTAdvStringGrid   read SgTariffType      write SgTariffType;
      property PSgConnList :PTAdvStringGrid     read SgConnList        write SgConnList;
      property PSgVParam :PTAdvStringGrid       read SgVParam          write SgVParam;
      property PSgTariff :PTAdvStringGrid       read SgTariff          write SgTariff;
      property PSgQMCommand :PTAdvStringGrid    read SgQMCommand       write SgQMCommand;
      property PSgCommands  :PTAdvStringGrid    read SgCommands        write SgCommands;
      property PSgCGrid :PTAdvStringGrid        read SgCGrid           write SgCGrid;
      property PSgEGrid :PTAdvStringGrid        read SgEGrid           write SgEGrid;
      property PSgPGrid :PTAdvStringGrid        read SgPGrid           write SgPGrid;
      property PSgVGrid :PTAdvStringGrid        read SgVGrid           write SgVGrid;
      property PsgSyazone:PTAdvStringGrid       read Fsgsyazone        write Fsgsyazone;
      property PsgSznDay:PTAdvStringGrid        read FsgSznDay         write FsgSznDay;
      property PsgTransTime:PTAdvStringGrid     read FsgTransTime      write FsgTransTime;

      //report
      property PSgStatistics   :PTAdvStringGrid   read FSgStatistics      write FSgStatistics;
      property PSgCalcMoney    :PTAdvStringGrid   read FSgCalcMoney       write FSgCalcMoney;
      property PSgGroups       :PTAdvStringGrid   read FSgGroups          write FSgGroups;
      property PSgGroupsV2     :PTAdvStringGrid   read FSgGroupsV2        write FSgGroupsV2;
      property PSgVMetersReport:PTAdvStringGrid   read FSgVMeters         write FSgVMeters;
      property PSgRasxMonth    :PTAdvStringGrid   read FSgRasxMonth       write FSgRasxMonth;
      property PSgRasxMonthZab :PTAdvStringGrid   read FSgRasxMonthZab    write FSgRasxMonthZab;
      property PSgRasxEnergy2  :PTAdvStringGrid   read FSgRasxEnergy2     write FSgRasxEnergy2;
      property PSgMaxControl   :PTAdvStringGrid   read FSgMaxControl      write FSgMaxControl;
      property PSgMaxDay2      :PTAdvStringGrid   read FSgMaxDay2         write FSgMaxDay2;
      property PSgVectorD      :PTAdvStringGrid   read FSgVectorD         write FSgVectorD;
      property PSgRasxMonthV3  :PTAdvStringGrid   read FSgRasxMonthV3     write FSgRasxMonthV3;
      property PSgAllGraphs    :PTAdvStringGrid   read FSgAllGraphs       write FSgAllGraphs;
      property PSgHourGenOut   :PTAdvStringGrid   read FSgHourGenOut      write FSgHourGenOut;

      property PSgVedomPokazV2 :PTAdvStringGrid   read FSgVedomPokazV2    write FSgVedomPokazV2;
      property PSgUsing        :PTAdvStringGrid   read FSgUsing           write FSgUsing;
      property PPageRp         :PTPageControl     read FPageRp            write FPageRp;
      property PSgExpenseDay   :PTAdvStringGrid   read FSgExpenseDay      write FSgExpenseDay;
      property PSgRasxDay      :PTAdvStringGrid   read FSgRasxDay         write FSgRasxDay;
      property PSgIncrementDay :PTAdvStringGrid   read FSgIncrementDay    write FSgIncrementDay;
      property PSgSizeEnergy   :PTAdvStringGrid   read FSgSizeEnergy      write FSgSizeEnergy;
      property PsgGomelAktive  :PTAdvStringGrid   read FsgGomelAktive     write FsgGomelAktive;
      property PsgGomelReact   :PTAdvStringGrid   read FsgGomelReact      write FsgGomelReact;
      property PSgValidInfo    :PTAdvStringGrid   read FSGValidInfo       write FSGValidInfo;
      property PSGValidSlices  :PTAdvStringGrid   read FSGValidSlices     write FSGValidSlices;
      property PsgGraphDay     :PTAdvStringGrid   read FsgGraphDay        write FsgGraphDay;
      property PsgGraphDayME   :PTAdvStringGrid   read FsgGraphDayME      write FsgGraphDayME;
      property PSGKorTime      :PTAdvStringGrid   read FSGKorTime         write FSGKorTime;
      property PsgTeploMoz     :PTAdvStringGrid   read FsgTeploMoz        write FsgTeploMoz;
      property PsgVedomPokaz   :PTAdvStringGrid   read fsgVedomPokaz      write fsgVedomPokaz;
      property PsgPowerHourMTZ :PTAdvStringGrid   read fsgPowerHourMTZ    write fsgPowerHourMTZ;
      property PsgCalcHeatMTZ  :PTAdvStringGrid   read fsgCalcHeatMTZ     write fsgCalcHeatMTZ;
      property PsgTechYchetMTZ :PTAdvStringGrid   read fsgTechYchetMTZ    write fsgTechYchetMTZ;
      property PsgPowerLimit   :PTAdvStringGrid   read fsgPowerLimit      write fsgPowerLimit;
      property Psg3PowerAndLimit:PTAdvStringGrid  read fsg3PowerAndLimit  write fsg3PowerAndLimit;
      property psgMaxPowerComp :PTAdvStringGrid   read fsgMaxPowerComp    write fsgMaxPowerComp;
      property psgSummVedom    :PTAdvStringGrid   read fsgSummVedom       write fsgSummVedom;
      property psgCheckValData :PTAdvStringGrid   read fsgCheckValData    write fsgCheckValData;
      property psgHomeBalanse  :PTAdvStringGrid   read fsgHomeBalanse     write fsgHomeBalanse;
      property psgBalanseDay  :PTAdvStringGrid   read fsgBalanseDay       write fsgBalanseDay;
      property psgCheckPowerSyst  :PTAdvStringGrid   read fsgCheckPowerSyst     write fsgCheckPowerSyst;

      //statistic
      property PSgGridStatistic :PTAdvStringGrid     read FSgStatistic        write FSgStatistic;
      //events
      property PsgGrid          :PTAdvStringGrid read FsgGrid            write FsgGrid;
      property PsgGridEvent     :PTAdvStringGrid read FsgGridEvent       write FsgGridEvent;
      property PAdvStringGrid1  :PTAdvStringGrid read FAdvStringGrid1    write FAdvStringGrid1;
      property PAdvStringGrid2  :PTAdvStringGrid read FAdvStringGrid2    write FAdvStringGrid2;
      //config/graf
      property PSgQryTable      :PTAdvStringGrid read FSgQryTable        write FSgQryTable;
      property PsgLimitEdtor    :PTAdvStringGrid read FsgLimitEdtor      write FsgLimitEdtor;
      property PSGLimitView     :PTAdvStringGrid read FSGLimitView       write FSGLimitView;
     //dataframe
      property PDataFrameTable  :PTAdvStringGrid read FSGDataFrameTable  write FSGDataFrameTable;
     //Chandge Meter
      property PChandgeAT       :PTAdvStringGrid read FChandgeAT         write FChandgeAT;
      property PChandgeDT       :PTAdvStringGrid read FChandgeDT         write FChandgeDT;
      property PRegion          :PTAdvStringGrid read FRegion            write FRegion;


      ////////stile
      property PFormStyler      : PAdvFormStyler read FAdvFormStyler     write FAdvFormStyler;
      property PReportStyler    : PAdvFormStyler read FReportFormStyler  write FReportFormStyler;
      property PCofigStyler     : PAdvFormStyler read FCofigStyler       write FCofigStyler;
      property PGraphStyler     : PAdvFormStyler read FGraphStyler       write FGraphStyler;
      property PMonitorStyler   : PAdvFormStyler read FMonitorStyler     write FMonitorStyler;
      property PEventStyler     : PAdvFormStyler read FEventStyler       write FEventStyler;
      property PLightStyler     : PAdvFormStyler read FLightStyler       write FLightStyler;
      property PQweryMdlstyler  : PAdvFormStyler read FQweryMdlstyler    write FQweryMdlstyler;
      property PStatisticaStyler: PAdvFormStyler read FStatisticaStyler  write FStatisticaStyler;
      property PDataStyler      :PAdvFormStyler  read FDataStyler        write  FDataStyler;
      property PUserStyler      :PAdvFormStyler  read FUserStyler        write  FUserStyler;
      property PAbonStyler      :PAdvFormStyler  read FAbonStyler        write  FAbonStyler;
      property PAddPortStyler   :PAdvFormStyler  read FAddPortStyler     write  FAddPortStyler;
      property PRedactorStyler  :PAdvFormStyler  read FRedactorStyler    write  FRedactorStyler;
      property PConnStyler      :PAdvFormStyler  read FConnStyler        write  FConnStyler;
      property PSManStyler      :PAdvFormStyler  read FSManStyler        write  FSManStyler;
      property PConfMeterStyler :PAdvFormStyler  read FConfMeterStyler   write  FConfMeterStyler;
      property PMainEditorStyler:PAdvFormStyler  read FMainEditorStyler  write  FMainEditorStyler;
      property PEventBoxStyler  :PAdvFormStyler  read FEventBoxStyler    write  FEventBoxStyler;
      property PLimitStyler     :PAdvFormStyler  read FLimitStyler       write  FLimitStyler;
      property PChandgeStyler   :PAdvFormStyler  read FChandgeStyler     write  FChandgeStyler;
      property PRegionStyler    :PAdvFormStyler  read FRegionStyler      write  FRegionStyler;
      property PVectorStyler    :PAdvFormStyler  read FVectorStyler      write  FVectorStyler;
      property PControlStyler   :PAdvFormStyler  read FControlStyler     write  FControlStyler;
      property PGomelBalansStyle:PAdvFormStyler  read FGomelBalansStyle  write  FGomelBalansStyle;
      property PHideCtrlFrStyle :PAdvFormStyler  read FHideCtrlFrStyle   write  FHideCtrlFrStyle;
      property PSchemEditor     :PAdvformStyler  read FSchemEditor       write  FSchemEditor; 


    End;

implementation

procedure CSetColor.SetAutoTheme;
begin
try
 if PFormStyler         <> nil  then PFormStyler.AutoThemeAdapt   := true;
 if PReportStyler       <> nil  then PReportStyler.AutoThemeAdapt := true;
 if PCofigStyler        <> nil  then PCofigStyler.AutoThemeAdapt  := true;
 if PGraphStyler        <> nil  then PGraphStyler.AutoThemeAdapt  := true;
 if PMonitorStyler      <> nil  then PMonitorStyler.AutoThemeAdapt  := true;
 if PEventStyler        <> nil  then PEventStyler.AutoThemeAdapt  := true;
 if PLightStyler        <> nil  then PLightStyler.AutoThemeAdapt  := true;
 if PQweryMdlstyler     <> nil  then PQweryMdlstyler.AutoThemeAdapt := true;
 if PStatisticaStyler   <> nil  then PStatisticaStyler.AutoThemeAdapt  := true;
 if PDataStyler         <> nil  then PDataStyler.AutoThemeAdapt  := true;
 if PUserStyler         <> nil  then PUserStyler.AutoThemeAdapt  := true;
 if PAbonStyler         <> nil  then PAbonStyler.AutoThemeAdapt  := true;
 if PAddPortStyler      <> nil  then PAddPortStyler.AutoThemeAdapt      := true;
 if PEventBoxStyler     <> nil  then PEventBoxStyler.AutoThemeAdapt     := true;
 if PLimitStyler        <> nil  then PLimitStyler.AutoThemeAdapt := true;
 if PRedactorStyler     <> nil  then PRedactorStyler.AutoThemeAdapt  := true;
 if PConnStyler         <> nil  then PConnStyler.AutoThemeAdapt  := true;
 if PSManStyler         <> nil  then PSManStyler.AutoThemeAdapt  := true;
 if PConfMeterStyler    <> nil  then PConfMeterStyler.AutoThemeAdapt := true;
 if PMainEditorStyler   <> nil  then PMainEditorStyler.AutoThemeAdapt := true; 
 if FChandgeStyler      <> nil  then FChandgeStyler.AutoThemeAdapt := true;
 if FRegionStyler       <> nil  then FRegionStyler.AutoThemeAdapt := true;
 if FVectorStyler       <> nil  then FVectorStyler.AutoThemeAdapt := true;
 if FControlStyler      <> nil  then FControlStyler.AutoThemeAdapt := true;
 if FGomelBalansStyle   <> nil  then FGomelBalansStyle.AutoThemeAdapt   := true;
 if FHideCtrlFrStyle    <> nil  then FHideCtrlFrStyle.AutoThemeAdapt := true;
 if FSchemEditor        <> nil  then FSchemEditor.AutoThemeAdapt := true;
  except
          TraceER('(__)CL3MD::>Error InCSetColor.SetAllStyle!!!');
   end;
end;

procedure CSetColor.SetAllStyle(nstyle:integer);
begin
try
 //if  nstyle = 0 then  SetAutoTheme else
 begin
 if PFormStyler   <> nil then PFormStyler.Style    := Style[nstyle];
 if  ReportFormCrete = true then
 begin
 if PReportStyler <> nil then PReportStyler.Style  := Style[nstyle];
 end;
 if PCofigStyler        <> nil  then PCofigStyler.Style   := Style[nstyle];
 if PGraphStyler        <> nil  then PGraphStyler.Style   := Style[nstyle];
 if PMonitorStyler      <> nil  then PMonitorStyler.Style   := Style[nstyle];
 if PEventStyler        <> nil  then PEventStyler.Style   := Style[nstyle];
 if PLightStyler        <> nil  then PLightStyler.Style   := Style[nstyle];
 if PQweryMdlstyler     <> nil  then PQweryMdlstyler.Style := Style[nstyle];
 if PStatisticaStyler   <> nil  then PStatisticaStyler.Style   := Style[nstyle];
 if PDataStyler         <> nil  then PDataStyler.Style   := Style[nstyle];
 if PUserStyler         <> nil  then PUserStyler.Style   := Style[nstyle];
 if PAbonStyler         <> nil  then PAbonStyler.Style   := Style[nstyle];
 if PAddPortStyler      <> nil  then PAddPortStyler.Style:= Style[nstyle];
 if PEventBoxStyler     <> nil  then PEventBoxStyler.Style:= Style[nstyle];
 if PLimitStyler        <> nil  then PLimitStyler.Style  := Style[nstyle];
 if PRedactorStyler     <> nil  then PRedactorStyler.Style   := Style[nstyle];
 if PConnStyler         <> nil  then PConnStyler.Style   := Style[nstyle];
 if PSManStyler         <> nil  then PSManStyler.Style   := Style[nstyle];
 if PConfMeterStyler    <> nil  then PConfMeterStyler.Style := Style[nstyle];
 if PMainEditorStyler   <> nil  then PMainEditorStyler.Style := Style[nstyle];
 if PLimitStyler        <> nil  then PLimitStyler.Style := Style[nstyle];
 if FChandgeStyler      <> nil  then FChandgeStyler.Style := Style[nstyle];
 if FRegionStyler       <> nil  then FRegionStyler.Style := Style[nstyle];
 if FVectorStyler       <> nil  then FVectorStyler.Style := Style[nstyle];
 if FControlStyler      <> nil  then FControlStyler.Style := Style[nstyle];
 if FGomelBalansStyle   <> nil  then FGomelBalansStyle.Style := Style[nstyle];
 if FHideCtrlFrStyle    <> nil  then FHideCtrlFrStyle.Style := Style[nstyle];
 if FSchemEditor        <> nil  then FSchemEditor.Style := Style[nstyle];
 end;
  except
          TraceER('(__)CL3MD::>Error InCSetColor.SetAllStyle!!!');
   end;
end;


procedure CSetColor.SaveStyle(style:integer);
begin
  m_pDB.SaveStyle(style);
end;

Function CSetColor.SetAllHigthGrid(nHigth:Integer):integer;
Var
        i : Integer;
Begin
        try
         Result:=0;
         if sgParam<>Nil      then for i:=1 to sgParam.RowCount-1          do Begin sgParam.Cells[0,i+1] := IntToStr(i+1);       sgParam.RowHeights[i]:= nHigth;End;
         if SgMeterType<>Nil  then for i:=1 to SgMeterType.RowCount-1      do Begin SgMeterType.Cells[0,i+1] := IntToStr(i+1);   SgMeterType.RowHeights[i]:= nHigth;End;
         if SgChannels<>Nil   then for i:=1 to SgChannels.RowCount-1       do Begin SgChannels.Cells[0,i+1] := IntToStr(i+1);    SgChannels.RowHeights[i]:= nHigth;End;
         if SgMeters<>Nil     then for i:=1 to SgMeters.RowCount-1         do Begin SgMeters.Cells[0,i+1] := IntToStr(i+1);      SgMeters.RowHeights[i]:= nHigth;End;
         if SgGroup<>Nil      then for i:=1 to SgGroup.RowCount-1          do Begin SgGroup.Cells[0,i+1] := IntToStr(i+1);       SgGroup.RowHeights[i]:= nHigth;End;
         if SgAbon<>Nil       then for i:=1 to SgAbon.RowCount-1           do Begin SgAbon.Cells[0,i+1] := IntToStr(i+1);        SgAbon.RowHeights[i]:= nHigth;End;
         if SgVMeters<>Nil    then for i:=1 to SgVMeters.RowCount-1        do Begin SgVMeters.Cells[0,i+1] := IntToStr(i+1);     SgVMeters.RowHeights[i]:= nHigth;End;
         if SgCNMeters<>Nil   then for i:=1 to SgCNMeters.RowCount-1       do Begin SgCNMeters.Cells[0,i+1] := IntToStr(i+1);    SgCNMeters.RowHeights[i]:= nHigth;End;
         if SgTariffType<>Nil then for i:=1 to SgTariffType.RowCount-1     do Begin SgTariffType.Cells[0,i+1] := IntToStr(i+1);  SgTariffType.RowHeights[i]:= nHigth;End;
         if SgConnList<>Nil   then for i:=1 to SgConnList.RowCount-1       do Begin SgConnList.Cells[0,i+1] := IntToStr(i+1);    SgConnList.RowHeights[i]:= nHigth;End;
         if SgVParam<>Nil     then for i:=1 to SgVParam.RowCount-1         do Begin SgVParam.Cells[0,i+1] := IntToStr(i+1);      SgVParam.RowHeights[i]:= nHigth;End;
         if SgTariff<>Nil     then for i:=1 to SgTariff.RowCount-1         do Begin SgTariff.Cells[0,i+1] := IntToStr(i+1);      SgTariff.RowHeights[i]:= nHigth;End;
         if SgQMCommand<>Nil  then for i:=1 to SgQMCommand.RowCount-1      do Begin SgQMCommand.Cells[0,i+1] := IntToStr(i+1);   SgQMCommand.RowHeights[i]:= nHigth;End;
         if SgCommands<>Nil   then for i:=1 to SgCommands.RowCount-1       do Begin SgCommands.Cells[0,i+1] := IntToStr(i+1);    SgCommands.RowHeights[i]:= nHigth;End;
         if SgCGrid<>Nil      then for i:=1 to SgCGrid.RowCount-1          do Begin SgCGrid.Cells[0,i+1] := IntToStr(i+1);       SgCGrid.RowHeights[i]:= nHigth;End;
         if SgEGrid<>Nil      then for i:=1 to SgEGrid.RowCount-1          do Begin SgEGrid.Cells[0,i+1] := IntToStr(i+1);       SgEGrid.RowHeights[i]:= nHigth;End;
         if SgPGrid<>Nil      then for i:=1 to SgPGrid.RowCount-1          do Begin SgPGrid.Cells[0,i+1] := IntToStr(i+1);       SgPGrid.RowHeights[i]:= nHigth;End;
         if SgVGrid<>Nil      then for i:=1 to SgVGrid.RowCount-1          do Begin SgVGrid.Cells[0,i+1] := IntToStr(i+1);       SgVGrid.RowHeights[i]:= nHigth;End;
         if PsgSyazone<>Nil   then for i:=1 to PsgSyazone.RowCount-1       do Begin PsgSyazone.Cells[0,i+1] := IntToStr(i+1);    PsgSyazone.RowHeights[i]:= nHigth;End;
         if PSgSznDay<>Nil    then for i:=1 to PSgSznDay.RowCount-1        do Begin PSgSznDay.Cells[0,i] := cDateTimeR.GetNameMonth0(i);     PSgSznDay.RowHeights[i]:= nHigth;End;
         if PsgTransTime<>Nil then for i:=1 to PsgTransTime.RowCount-1     do Begin PsgTransTime.Cells[0,i+1] := IntToStr(i+1);  PsgTransTime.RowHeights[i]:= nHigth;End;
         if FCHandgeAT<>Nil   then for i:=1 to FCHandgeAT.RowCount-1       do Begin FCHandgeAT.Cells[0,i+1] := IntToStr(i+1);    FCHandgeAT.RowHeights[i]:= nHigth;End;
         if FCHandgeDT<>Nil   then for i:=1 to FCHandgeDT.RowCount-1       do Begin FCHandgeDT.Cells[0,i+1] := IntToStr(i+1);    FCHandgeDT.RowHeights[i]:= nHigth;End;
         if FRegion<>Nil      then for i:=1 to FRegion.RowCount-1          do Begin FRegion.Cells[0,i+1] := IntToStr(i+1);       FRegion.RowHeights[i]:= nHigth;End;
         if psgHomeBalanse<>Nil then for i:=1 to psgHomeBalanse.RowCount-1 do Begin psgHomeBalanse.Cells[0,i+1] := IntToStr(i+1);psgHomeBalanse.RowHeights[i]:= nHigth;End;
         if psgBalanseDay<>Nil then for i:=1 to psgBalanseDay.RowCount-1 do Begin psgBalanseDay.Cells[0,i+1] := IntToStr(i+1);psgBalanseDay.RowHeights[i]:= nHigth;End;
        except
          //TraceER('(__)CL3MD::>Error InCSetColor.SetAllHigthGrid!!!');
          Result:=1;
        end;
End;
{FSgMaxControl.Cells[0,i+1] := IntToStr(i+1);}
Function CSetColor.SetReportHigthGrid(nHigth:Integer):integer;
Var
     i : Integer;
Begin
      try
      Result:=0;
      begin
       if  ReportFormCrete = true then
       begin
        if FSgStatistics<>Nil   then for i:=1 to FSgStatistics.RowCount-1    do Begin FSgStatistics.RowHeights[i]:= nHigth;End;
        if FSgCalcMoney<>Nil    then for i:=1 to FSgCalcMoney.RowCount-1     do Begin FSgCalcMoney.RowHeights[i]:= nHigth;End;
        if FSgGroups<>Nil       then for i:=1 to FSgGroups.RowCount-1        do Begin FSgGroups.RowHeights[i]:= nHigth;End;
        if FSgGroupsV2<>Nil     then for i:=1 to FSgGroupsV2.RowCount-1      do Begin FSgGroupsV2.RowHeights[i]:= nHigth;End;
        if FSgRasxMonth<>Nil    then for i:=1 to FSgRasxMonth.RowCount-1     do Begin FSgRasxMonth.RowHeights[i]:= nHigth;End;
        if FSgRasxMonthZab<>Nil then for i:=1 to FSgRasxMonthZab.RowCount-1  do Begin FSgRasxMonthZab.RowHeights[i]:= nHigth;End;
        if FSgRasxEnergy2<>Nil  then for i:=1 to FSgRasxEnergy2.RowCount-1   do Begin FSgRasxEnergy2.RowHeights[i]:= nHigth;End;
        if FSgMaxControl<>Nil   then for i:=1 to FSgMaxControl.RowCount-1    do Begin FSgMaxControl.RowHeights[i]:= nHigth;End;
        if FSgMaxDay2<>Nil      then for i:=1 to FSgMaxDay2.RowCount-1       do Begin FSgMaxDay2.RowHeights[i]:= nHigth;End;
        if FSgVectorD<>Nil      then for i:=1 to FSgVectorD.RowCount-1       do Begin FSgVectorD.RowHeights[i]:= nHigth;End;
        if FSgRasxMonthV3<>Nil  then for i:=1 to FSgRasxMonthV3.RowCount-1   do Begin FSgRasxMonthV3.RowHeights[i]:= nHigth;End;
        if FSgAllGraphs<>Nil    then for i:=1 to FSgAllGraphs.RowCount-1     do Begin FSgAllGraphs.RowHeights[i]:= nHigth;End;
        if FSgHourGenOut<>Nil    then for i:=1 to FSgHourGenOut.RowCount-1     do Begin FSgHourGenOut.RowHeights[i]:= nHigth;End;

        if FSgVedomPokazV2<>Nil then for i:=1 to FSgVedomPokazV2.RowCount-1  do Begin FSgVedomPokazV2.RowHeights[i]:= nHigth;End;
        if FSgUsing<>Nil        then for i:=1 to FSgUsing.RowCount-1         do Begin FSgUsing.RowHeights[i]:= nHigth;End;
        if FSgVMeters<>Nil      then for i:=1 to FSgVMeters.RowCount-1       do Begin FSgVMeters.RowHeights[i]:= nHigth;End;
        if FAdvStringGrid1<>Nil then for i:=1 to FAdvStringGrid1.RowCount-1  do Begin FAdvStringGrid1.RowHeights[i]:= nHigth;End;
        if FAdvStringGrid2<>Nil then for i:=1 to FAdvStringGrid2.RowCount-1  do Begin FAdvStringGrid2.RowHeights[i]:= nHigth;End;
        if FSgExpenseDay<>Nil   then for i:=1 to FSgExpenseDay.RowCount-1    do Begin FSgExpenseDay.RowHeights[i]:= nHigth;End;
        if FSgRasxDay<>Nil      then for i:=1 to FSgRasxDay.RowCount-1       do Begin FSgRasxDay.RowHeights[i]:= nHigth;End;
        if FSgIncrementDay<>Nil then for i:=1 to FSgIncrementDay.RowCount-1  do Begin FSgIncrementDay.RowHeights[i]:= nHigth;End;
        if FSgSizeEnergy<>Nil   then for i:=1 to FSgSizeEnergy.RowCount-1    do Begin FSgSizeEnergy.RowHeights[i]:= nHigth;End;
        if FsgGomelAktive<>Nil   then for i:=1 to FsgGomelAktive.RowCount-1  do Begin FsgGomelAktive.RowHeights[i]:= nHigth;End;
        if FsgGomelReact<>Nil   then for i:=1 to FsgGomelReact.RowCount-1    do Begin FsgGomelReact.RowHeights[i]:= nHigth;End;
        if FsgGraphDay<>Nil     then for i:=1 to FsgGraphDay.RowCount-1      do Begin FsgGraphDay.RowHeights[i]:= nHigth;End;
        if FsgGraphDayME<>Nil   then for i:=1 to FsgGraphDayME.RowCount-1    do Begin FsgGraphDayME.RowHeights[i]:= nHigth;End;
        if FSGValidInfo<>Nil    then for i:=1 to FSgValidInfo.RowCount-1     do Begin FSGValidInfo.RowHeights[i]:= nHigth;End;
        if FSGValidSlices<>Nil  then for i:=1 to FSGValidSlices.RowCount-1   do Begin FSGValidSlices.RowHeights[i]:= nHigth;End;
        if FsgLimitEdtor<>Nil   then for i:=1 to FsgLimitEdtor.RowCount-1    do Begin FsgLimitEdtor.RowHeights[i]:= nHigth;End;
        if FSGLimitView<>Nil   then  for i:=1 to FSGLimitView.RowCount-1     do Begin FSGLimitView.RowHeights[i]:= nHigth;End;
        if FSGKorTime<>Nil     then  for i:=1 to FSGKorTime.RowCount-1       do Begin FSGKorTime.RowHeights[i]:= nHigth;End;
        if FsgTeploMoz<>Nil    then  for i:=1 to FsgTeploMoz.RowCount-1      do Begin FsgTeploMoz.RowHeights[i]:= nHigth;End;
        if fsgVedomPokaz<>Nil   then for i:=1 to fsgVedomPokaz.RowCount-1    do Begin fsgVedomPokaz.RowHeights[i]:= nHigth;End;
        if fsgPowerHourMTZ<>Nil then for i:=1 to fsgPowerHourMTZ.RowCount-1  do Begin fsgPowerHourMTZ.RowHeights[i]:= nHigth;End;
        if fsgCalcHeatMTZ<>Nil  then for i:=1 to fsgCalcHeatMTZ.RowCount-1   do Begin fsgCalcHeatMTZ.RowHeights[i]:= nHigth;End;
        if fsgTechYchetMTZ<>Nil then for i:=1 to fsgTechYchetMTZ.RowCount-1  do Begin fsgTechYchetMTZ.RowHeights[i]:= nHigth;End;
        if fsgPowerLimit<>Nil   then for i:=1 to fsgPowerLimit.RowCount-1    do Begin fsgPowerLimit.RowHeights[i]:= nHigth;End;
        if fsg3PowerAndLimit<>Nil then for i:=1 to fsg3PowerAndLimit.RowCount-1    do Begin fsg3PowerAndLimit.RowHeights[i]:= nHigth;End;
        if fsgMaxPowerComp<>Nil then for i:=1 to fsgMaxPowerComp.RowCount-1  do Begin fsgMaxPowerComp.RowHeights[i]:= nHigth;End;
        if fsgSummVedom<>Nil    then for i:=1 to fsgSummVedom.RowCount-1     do Begin fsgSummVedom.RowHeights[i]:=nHigth;End;
        if fsgCheckValData<>Nil then for i:=1 to fsgCheckValData.RowCount-1  do Begin fsgCheckValData.RowHeights[i]:=nHigth;End;
        if fsgHomeBalanse<>Nil  then for i:=1 to fsgHomeBalanse.RowCount-1   do Begin fsgHomeBalanse.RowHeights[i]:=nHigth;End;
        if fsgCheckPowerSyst<>Nil  then for i:=1 to fsgCheckPowerSyst.RowCount-1   do Begin fsgCheckPowerSyst.RowHeights[i]:=nHigth;End;
       end
      end;
       except
       //TraceER('(__)CL3MD::>Error InCSetColor.SetReportHigthGrid!!!');
       Result:=1;
      end;
End;
procedure CSetColor.SetReportColorFont(GetCol:integer);
Begin
      try
      begin
       if  ReportFormCrete = true then
       begin
        if FSgStatistics<>Nil   then FSgStatistics.Font.Color := GetCol;
        if FSgCalcMoney<>Nil    then FSgCalcMoney.Font.Color := GetCol;
        if FSgGroups<>Nil       then FSgGroups.Font.Color := GetCol;
        if FSgGroupsV2<>Nil     then FSgGroupsV2.Font.Color := GetCol;
        if FSgRasxMonth<>Nil    then FSgRasxMonth.Font.Color := GetCol;
        if FSgRasxMonthZab<>Nil then FSgRasxMonthZab.Font.Color := GetCol;
        if FSgRasxEnergy2<>Nil  then FSgRasxEnergy2.Font.Color := GetCol;
        if FSgMaxControl<>Nil   then FSgMaxControl.Font.Color := GetCol;
        if FSgMaxDay2<>Nil      then FSgMaxDay2.Font.Color := GetCol;
        if FSgVectorD<>Nil      then FSgVectorD.Font.Color := GetCol;
        if FSgRasxMonthV3<>Nil  then FSgRasxMonthV3.Font.Color := GetCol;
        if FSgAllGraphs<>Nil    then FSgAllGraphs.Font.Color := GetCol;
        if FSgHourGenOut<>Nil   then FSgHourGenOut.Font.Color := GetCol;
        if FSgVedomPokazV2<>Nil then FSgVedomPokazV2.Font.Color := GetCol;
        if FSgUsing<>Nil        then FSgUsing.Font.Color := GetCol;
        if FSgVMeters<>Nil      then FSgVMeters.Font.Color := GetCol;
        if FAdvStringGrid1<>Nil then FAdvStringGrid1.Font.Color := GetCol;
        if FAdvStringGrid2<>Nil then FAdvStringGrid2.Font.Color := GetCol;
        if FSgExpenseDay<>Nil   then FSgExpenseDay.Font.Color := GetCol;
        if FSgRasxDay<>Nil      then FSgRasxDay.Font.Color := GetCol;
        if FSgIncrementDay<>Nil then FSgIncrementDay.Font.Color := GetCol;
        if FSgSizeEnergy<>Nil   then FSgSizeEnergy.Font.Color := GetCol;
        if FsgGomelAktive<>Nil  then FsgGomelAktive.Font.Color := GetCol;
        if FsgGomelReact<>Nil   then FsgGomelReact.Font.Color := GetCol;
        if FsgGraphDay<>Nil     then FsgGraphDay.Font.Color := GetCol;
        if FsgGraphDayME<>Nil     then FsgGraphDayME.Font.Color := GetCol;
        if FSGValidInfo<>Nil    then FSGValidInfo.Font.Color := GetCol;
        if FSGValidSlices<>Nil  then FSGValidSlices.Font.Color := GetCol;
        if FsgLimitEdtor<>Nil   then FsgLimitEdtor.Font.Color := GetCol;
        if FSGLimitView<>Nil    then FSGLimitView.Font.Color := GetCol;
        if FSGKorTime<>Nil      then FSGKorTime.Font.Color := GetCol;
        if FsgTeploMoz<>Nil     then FsgTeploMoz.Font.Color := GetCol;
        if fsgVedomPokaz<>Nil   then fsgVedomPokaz.Font.Color := GetCol;
        if fsgPowerHourMTZ<>Nil then fsgPowerHourMTZ.Font.Color := GetCol;
        if fsgCalcHeatMTZ<>Nil  then fsgCalcHeatMTZ.Font.Color := GetCol;
        if fsgTechYchetMTZ<>Nil then fsgTechYchetMTZ.Font.Color := GetCol;
        if fsgPowerLimit<>Nil   then fsgPowerLimit.Font.Color := GetCol;
        if fsg3PowerAndLimit<>Nil then fsg3PowerAndLimit.Font.Color := GetCol;
        if fsgMaxPowerComp<>Nil then fsgMaxPowerComp.Font.Color := GetCol;
        if fsgSummVedom<>Nil    then fsgSummVedom.Font.Color := GetCol;
        if fsgCheckValData<>Nil then fsgCheckValData.Font.Color := GetCol;
        if FCHandgeAT<>Nil      then FCHandgeAT.Font.Color := GetCol;
        if FCHandgeDT<>Nil      then FCHandgeDT.Font.Color := GetCol;
        if FRegion<>Nil         then FRegion.Font.Color := GetCol;
        if fsgHomeBalanse<>Nil  then fsgHomeBalanse.Font.Color := GetCol;
        if fsgCheckPowerSyst<>Nil  then fsgCheckPowerSyst.Font.Color := GetCol;
       end
      end;
       except
       TraceER('(__)CL3MD::>Error InCSetColor.SetReportHigthGrid!!!');
      end;
End;

Function CSetColor.SetEventHigthGrid(nHigth:Integer):integer;
Var
      i : Integer;
Begin
 try
  Result:=0;
      for i:=0 to FsgGrid.RowCount-1 do Begin FsgGrid.Cells[0,i+1] := IntToStr(i+1); FsgGrid.RowHeights[i]:= nHigth;End;
      for i:=0 to FSgQryTable.RowCount-1 do Begin FSgQryTable.Cells[0,i+1] := IntToStr(i+1); FSgQryTable.RowHeights[i]:= nHigth;End;
 except
   Result:=1;
 end;
End;
Function CSetColor.SetEventsHigthGrid(nHigth:Integer):integer;
Var
      i : Integer;
Begin
  try
    Result:=0;
      if FsgGridEvent<>Nil then for i:=1 to FsgGridEvent.RowCount-1  do Begin FsgGridEvent.RowHeights[i]:= nHigth;End;
  except
    Result:=1;
  end;
End;
function CSetColor.SetStatisticHigthGrid(nHigth:Integer):integer;
Var
      i : Integer;
Begin
  try
   Result:=0;
      if FSgStatistic<>Nil then for i:=1 to FSgStatistic.RowCount-1   do Begin FSgStatistic.RowHeights[i]:= nHigth;End;
   except
     Result:=1;
   end;
End;
procedure CSetColor.SetFontColor(GetCol:integer);
Begin
      TraceL(4,0,'SetColor.');
      //FTreeModule.Font.Color          := GetCol;
      FTreeModuleData.Font.Color      := GetCol;
      SgParam.Font.Color              := GetCol;
      SgMeterType.Font.Color          := GetCol;
      SgChannels.Font.Color           := GetCol;
      SgMeters.Font.Color             := GetCol;
      SgGroup.Font.Color              := GetCol;
      SgAbon.Font.Color               := GetCol;
      SgVMeters.Font.Color            := GetCol;
      SgCNMeters.Font.Color           := GetCol;
//      SgTariffType.Font.Color         := GetCol;
      SgConnList.Font.Color           := GetCol;
      SgVParam.Font.Color             := GetCol;
//      SgTariff.Font.Color             := GetCol;
      SgQMCommand.Font.Color          := GetCol;
      SgCommands.Font.Color           := GetCol;
      SgCGrid.Font.Color              := GetCol;
      SgEGrid.Font.Color              := GetCol;
      SgPGrid.Font.Color              := GetCol;
      if Fsgsyazone<>Nil      then Fsgsyazone.Font.Color := GetCol;
      if FsgSznDay<>Nil       then FsgSznDay.Font.Color := GetCol;
      if FsgTransTime<>Nil    then FsgTransTime.Font.Color := GetCol;
      if FCHandgeAT<>Nil      then FCHandgeAT.Font.Color := GetCol;
      if FCHandgeDT<>Nil      then FCHandgeDT.Font.Color := GetCol;
      if FRegion<>Nil         then FRegion.Font.Color := GetCol;
      if fsgHomeBalanse<>Nil  then fsgHomeBalanse.Font.Color := GetCol;
      if fsgCheckPowerSyst<>Nil  then fsgCheckPowerSyst.Font.Color := GetCol;
 End;
procedure CSetColor.SetFontName(GetFName :string);
Begin
      TraceL(4,0,'SetFontName.');
      //FTreeModule.Font.Name      := GetFName;
      FTreeModuleData.Font.Name  := GetFName;
      SgParam.Font.Name          := GetFName;
      SgMeterType.Font.Name      := GetFName;
      SgChannels.Font.Name       := GetFName;
      SgMeters.Font.Name         := GetFName;
      SgGroup.Font.Name          := GetFName;
      SgAbon.Font.Name           := GetFName;
      SgVMeters.Font.Name        := GetFName;
      //SgTariffType.Font.Name     := GetFName;
      SgConnList.Font.Name       := GetFName;
      SgVParam.Font.Name         := GetFName;
      //SgTariff.Font.Name         := GetFName;
      SgQMCommand.Font.Name      := GetFName;
      SgCommands.Font.Name       := GetFName;;
      SgCGrid.Font.Name          := GetFName;
      SgEGrid.Font.Name          := GetFName;
      SgPGrid.Font.Name          := GetFName;
      if Fsgsyazone<>Nil      then Fsgsyazone.Font.Name := GetFName;
      if FsgSznDay<>Nil       then FsgSznDay.Font.Name := GetFName;
      if FsgTransTime<>Nil    then FsgTransTime.Font.Name := GetFName;
      if FCHandgeAT<>Nil    then FCHandgeAT.Font.Name := GetFName;
      if FCHandgeDT<>Nil    then FCHandgeDT.Font.Name := GetFName;
      if FRegion<>Nil       then FRegion.Font.Name := GetFName;
      if fsgHomeBalanse<>Nil       then fsgHomeBalanse.Font.Name := GetFName;
      if fsgCheckPowerSyst<>Nil       then fsgCheckPowerSyst.Font.Name := GetFName;
End;
procedure CSetColor.SetFontSize(GetFsize:integer);
Begin
      TraceL(4,0,'SetFontSize.');

      //FTreeModule.Font.Size      := GetFsize;
      FTreeModuleData.Font.Size  := GetFsize;
      SgParam.Font.Size          := GetFsize;
      SgMeterType.Font.Size      := GetFsize;
      SgChannels.Font.Size       := GetFsize;
      SgMeters.Font.Size         := GetFsize;
      SgGroup.Font.Size          := GetFsize;
      SgAbon.Font.Size           := GetFsize;
      SgVMeters.Font.Size        := GetFsize;
      SgCNMeters.Font.Size       := GetFsize;
      //SgTariffType.Font.Size     := GetFsize;
      SgConnList.Font.Size       := GetFsize;
      SgVParam.Font.Size         := GetFsize;
      //SgTariff.Font.Size         := GetFsize;
      SgQMCommand.Font.Size      := GetFsize;
      SgCommands.Font.Size       := GetFsize;
      SgCGrid.Font.Size          := GetFsize;
      SgEGrid.Font.Size          := GetFsize;
      SgPGrid.Font.Size          := GetFsize;
      if Fsgsyazone<>Nil      then Fsgsyazone.Font.Size := GetFsize;
      if FsgSznDay<>Nil       then FsgSznDay.Font.Size := GetFsize;
      if FsgTransTime<>Nil    then FsgTransTime.Font.Size := GetFsize;
      if FCHandgeAT<>Nil    then FCHandgeAT.Font.Size := GetFsize;
      if FCHandgeDT<>Nil    then FCHandgeDT.Font.Size := GetFsize;
      if FRegion<>Nil       then FRegion.Font.Size := GetFsize;
      if fsgHomeBalanse<>Nil       then fsgHomeBalanse.Font.Size := GetFsize;
      if fsgCheckPowerSyst<>Nil       then fsgCheckPowerSyst.Font.Size := GetFsize;
End;
procedure CSetColor.SetColorPanel(pTab:SCOLORSETTTAG);
var
      GetCPanel:integer;
Begin
      TraceL(4,0,'SetColorPanel.');
      GetCPanel                     :=  pTab.m_swColorPanel;
     // FTreeModule.Color          :=  GetCPanel;
     // FTreeModuleData.Color      :=  GetCPanel;
End;
procedure CSetColor.FontName(FName:string);
Begin
      TraceL(4,0,'FontName.');
    //  FTreeModule.Font.Name      := FindFontName(CL_TREE_CONF);
End;


function CSetColor.SetColorPPanel(var mCL : SCOLORSETTTAG):Boolean;
Begin
  try
    Result:=False;
      m_pDB.AddColorPanel(mCL);
  except
    Result:=True;
  end;
End;
procedure CSetColor.SetColorSettings(var mCL : SCOLORSETTTAG);
begin
      SetFontColor(mCL.m_swColor);
      SetReportColorFont(mCL.m_swColor);
      SetFontName(mCL.m_sstrFontName);
      SetFontSize(mCL.m_swFontSize);
      SetAllHigthGrid(nSizeFont+17);
      SetReportHigthGrid(nSizeFont+17);
      SetEventHigthGrid(nSizeFont+17);
      SetEventsHigthGrid(nSizeFont+17);
      SetStatisticHigthGrid(nSizeFont+17);
     
      SendMsg(BOX_L3,0,DIR_L4TOL3,AL_REFRESHDATA_REQ);
end;
end.
