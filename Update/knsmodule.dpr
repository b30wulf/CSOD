program knsmodule;

uses
  Forms,
  Windows,
  inifiles,
  Sysutils,
  knsl5module in 'knsl5module.pas' {TKnsForm},
  utlbox in 'utlbox.pas',
  utltypes in 'utltypes.pas',
  utlconst in 'utlconst.pas',
  knsl1module in 'knsl1module.pas',
  knsl1cport in 'knsl1cport.pas',
  knsl1comport in 'knsl1comport.pas',
  utldatabase in 'utldatabase.pas',
  knsl2module in 'knsl2module.pas',
  knsl2meter in 'knsl2meter.pas',
  utlmtimer in 'utlmtimer.pas',
  knsl2ems134meter in 'knsl2ems134meter.pas',
  knsl2ee8005meter in 'knsl2ee8005meter.pas',
  knsl2set4tmmeter in 'knsl2set4tmmeter.pas',
  knsl2Nullmeter in 'knsl2Nullmeter.pas',
  knsl3module in 'knsl3module.pas',
  knsl3observemodule in 'knsl3observemodule.pas',
  knsL3querysender in 'knsl3querysender.pas',
  knsl4automodule in 'knsl4automodule.pas',
  knsl4a2000module in 'knsl4a2000module.pas',
  knsl4c12module in 'knsl4c12module.pas',
  knsl4btimodule in 'knsl4btimodule.pas',
  knsl4module in 'knsl4module.pas',
  knsl1editor in 'knsl1editor.pas',
  knsl4cc301module in 'knsl4cc301module.pas',
  knsl2editor in 'knsl2editor.pas',
  knsl2cmdeditor in 'knsl2cmdeditor.pas',
  knsl3groupeditor in 'knsl3groupeditor.pas',
  knsl3vmetereditor in 'knsl3vmetereditor.pas',
  knsl3vparameditor in 'knsl3vparameditor.pas',
  knsl2mtypeeditor in 'knsl2mtypeeditor.pas',
  knsl2qmcmdeditor in 'knsl2qmcmdeditor.pas',
  knsl2graphframe in 'knsl2graphframe.pas' {GraphFrame},
  knsl3vmeter in 'knsl3vmeter.pas',
  knsl3vparam in 'knsl3vparam.pas',
  knsl2treeloader in 'knsl2treeloader.pas',
  knsl2treehandler in 'knsl2treehandler.pas',
  knsl3treeloader in 'knsl3treeloader.pas',
  knsl3viewgraph in 'knsl3viewgraph.pas',
  knsl2parameditor in 'knsl2parameditor.pas',
  knsl3dataframe in 'knsl3dataframe.pas' {DataFrame},
  knsl3viewcdata in 'knsl3viewcdata.pas',
  knsl3lme in 'knsl3lme.pas',
  knsl5tracer in 'knsl5tracer.pas',
  knsl3tartypeeditor in 'knsl3tartypeeditor.pas',
  knsl3tariffeditor in 'knsl3tariffeditor.pas',
  knsl1tcp in 'knsl1tcp.pas',
  knsl3conneditor in 'knsl3conneditor.pas',
  knsl2BTIInit in 'knsl2BTIInit.pas',
  knsl4connmanager in 'knsl4connmanager.pas',
  knsl4connfrm in 'knsl4connfrm.pas' {ConnForm},
  Dates in 'Dates.pas',
  knsl3report in 'knsl3report.pas' {TRepPower},
  knsl2timers in 'knsl2timers.pas',
  knsl2BTIModule in 'knsl2BTIModule.pas',
  knsl4secman in 'knsl4secman.pas' {TUserManager},
  ReportKPD in 'ReportKPD.pas' {rpKPDReport},
  utlTimeDate in 'utlTimeDate.pas',
  knslRPMaxDay in 'knslRPMaxDay.pas' {rpMaxDay},
  knslRPRasxEnerg in 'knslRPRasxEnerg.pas' {rpRasxEnerg},
  knslRPPokMeters in 'knslRPPokMeters.pas' {rpPokMeters},
  knslRPSostavGroup in 'knslRPSostavGroup.pas' {rpSostavGroup},
  knsl5config in 'knsl5config.pas' {TL5Config},
  u_Crypt in 'u_Crypt.pas',
  u_iButTMEX in 'u_iButTMEX.pas',
  utldynconnect in 'utldynconnect.pas',
  knslRPMaxLoadPower in 'knslRPMaxLoadPower.pas' {rpMaxPowerLoad},
  knslRpCalcMoney in 'knslRpCalcMoney.pas' {rpCalcMoney},
  knsl3calcmodule in 'knsl3calcmodule.pas',
  knseditexpr in 'knseditexpr.pas' {frmEditExpr},
  utlexparcer in 'utlexparcer.pas',
  knsl2statistic in 'knsl2statistic.pas' {TL2Statistic},
  knslRPRasxMonth in 'knslRPRasxMonth.pas' {rpRasxMonth},
  knsl5events in 'knsl5events.pas' {TL5Events},
  knsl3qryschedlr in 'knsl3qryschedlr.pas',
  knsL5setcolor in 'knsL5setcolor.pas',
  knsl5users in 'knsl5users.pas' {TUsers},
  knslRPPokEnerg in 'knslRPPokEnerg.pas' {rpPokEnerg},
  knslRPExpenseDay in 'knslRPExpenseDay.pas' {rpExpenseDay},
  knslRPRasxDay in 'knslRPRasxDay.pas' {rpRasxDay},
  knsRPMaxDayFact in 'knsRPMaxDayFact.pas' {rpMaxDayFact},
  knsl3setenergo in 'knsl3setenergo.pas',
  knslRPIncrememtDay in 'knslRPIncrememtDay.pas' {rpIncrementDay},
  knsl3setgsmtime in 'knsl3setgsmtime.pas',
  RASUnit in 'RASUnit.pas',
  knsl2ssrdmeter in 'knsl2ssrdmeter.pas',
  knslRPSizeEnergy in 'knslRPSizeEnergy.pas' {rpSizeEnergy},
  knsl3updatemanager in 'knsl3updatemanager.pas',
  knslRPExpenseDayXL in 'knslRPExpenseDayXL.pas',
  knsl2fmtime in 'knsl2FMTime.pas',
  knsl2ss301f3meter in 'knsl2ss301f3meter.pas',
  knsl2ss301f4meter in 'knsl2ss301f4meter.pas',
  knslAbout in 'knslAbout.pas' {TAbout},
  knslLoadMainForm in 'knslLoadMainForm.pas' {LoadMainForm},
  knslReportKPDXL in 'knslReportKPDXL.pas',
  knslRpCalcMoneyXL in 'knslRpCalcMoneyXL.pas',
  knslRPIncrememtDayXL in 'knslRPIncrememtDayXL.pas',
  knslRPMaxDayXL in 'knslRPMaxDayXL.pas',
  knslRPMaxLoadPowerXL in 'knslRPMaxLoadPowerXL.pas',
  knslRPPokEnergXL in 'knslRPPokEnergXL.pas',
  knslRPPokMetersXL in 'knslRPPokMetersXL.pas',
  knslRPRasxDayXL in 'knslRPRasxDayXL.pas',
  knslRPRasxEnergXL in 'knslRPRasxEnergXL.pas',
  knslRPRasxMonthXL in 'knslRPRasxMonthXL.pas',
  knslRPSizeEnergyXL in 'knslRPSizeEnergyXL.pas',
  knslRPSostavGroupXL in 'knslRPSostavGroupXL.pas',
  knsRPMaxDayFactXL in 'knsRPMaxDayFactXL.pas',
  knsl3FHModule in 'knsl3FHModule.pas',
  knsl3recalcmodule in 'knsl3recalcmodule.pas',
  knslProgressLoad in 'knslProgressLoad.pas' {ProgressLoad},
  knsl3szneditor in 'knsl3szneditor.pas',
  knsl5calendar in 'knsl5calendar.pas' {MCalendar},
  uTMSocket in 'uTMSocket.pas',
  knsl3transtime in 'knsl3transtime.pas',
  knsl3setenergomoz in 'knsl3setenergomoz.pas',
  knslRPGomelActive in 'knslRPGomelActive.pas' {RPGomelActive},
  knslRPGomelReact in 'knslRPGomelReact.pas' {RPGomelReact},
  knslRPValidInfo in 'knslRPValidInfo.pas' {RPValidInfo},
  knsl4ConfMeterModule in 'knsl4ConfMeterModule.pas' {ConfMeterModule},
  knsl3selftestmodule in 'knsl3selftestmodule.pas',
  knsl3RPSelfTest in 'knsl3RPSelfTest.pas' {TRpSelfTest},
  utlverinfo in 'utlverinfo.pas',
  knsl3tarplaneeditor in 'knsl3tarplaneeditor.pas',
  knsl4EKOMmodule in 'knsl4EKOMmodule.pas',
  knsl3abon in 'knsl3abon.pas' {TAbonManager},
  knsl3aboneditor in 'knsl3aboneditor.pas',
  knsl2KaskadMeter in 'knsl2KaskadMeter.pas',
  knsl2a2000meter in 'knsl2a2000meter.pas',
  knsl3Abonent in 'knsl3Abonent.pas',
  knsl2VzljotMeter in 'knsl2VzljotMeter.pas',
  knsl3AddPortForAbon in 'knsl3AddPortForAbon.pas' {PortForAbon},
  knsl3EventBox in 'knsl3EventBox.pas' {EventBox},
  knslRPGraphDayXL in 'knslRPGraphDayXL.pas',
  knsl3LimitEditor in 'knsl3LimitEditor.pas' {fr3LimitEditor},
  knslRPValidSlice in 'knslRPValidSlice.pas' {RPValidSlice},
  knslRPKorrTime in 'knslRPKorrTime.pas' {rpKorrTime},
  knsl3MyExportModule in 'knsl3MyExportModule.pas',
  knsl3archive in 'knsl3archive.pas',
  knslRPTeploMoz in 'knslRPTeploMoz.pas' {RPTeploMoz},
  knsl3chandge in 'knsl3chandge.pas' {TMeterChandge},
  knsl3chdteditor in 'knsl3chdteditor.pas',
  knsl3cheditor in 'knsl3cheditor.pas',
  knsl3regeditor in 'knsl3regeditor.pas',
  knsl3addregions in 'knsl3addregions.pas' {TAddRegions},
  knsl3datafinder in 'knsl3datafinder.pas' {TDataFinder},
  knsl2C12Module in 'knsl2C12Module.pas',
  knsl5MainEditor in 'knsl5MainEditor.pas' {frMainEditor},
  knsl2EA8086Meter in 'knsl2EA8086Meter.pas',
  knsl2EKOM3000Meter in 'knsl2EKOM3000Meter.pas',
  knsl2SEM2Meter in 'knsl2SEM2Meter.pas',
  knsl3qwerycell in 'knsl3qwerycell.pas',
  knsl3qwerytree in 'knsl3qwerytree.pas',
  knslRPVedomPokaz in 'knslRPVedomPokaz.pas' {RPVedomPokaz},
  knsl2EPQMMeter in 'knsl2epqmmeter.pas',
  knsl3VectorFrame in 'knsl3vectorframe.pas' {VectorFrame},
  knsl4Unloader in 'knsl4Unloader.pas',
  knsl2ce6822meter in 'knsl2ce6822meter.pas',
  knsl2ce6850meter in 'knsl2ce6850meter.pas',
  knsl2E9STK1Meter in 'knsl2E9STK1Meter.pas',
  knslRPGomelBalans in 'knslRPGomelBalans.pas' {RPGomelBalans},
  knsl4Loader in 'knsl4Loader.pas',
  knsl2TEM051Meter in 'knsl2TEM051Meter.pas',
  knslRPPowerHourMTZ in 'knslRPPowerHourMTZ.pas' {RPPowerHourMTZ},
  knslRPCalcHeatMTZ in 'knslRPCalcHeatMTZ.pas' {RPCalcHeatMTZ},
  knsl3savetime in 'knsl3savetime.pas',
  knsl2ControlFrame in 'knsl2ControlFrame.pas' {ControlFrame},
  knslRPGraphDayXLME in 'knslRPGraphDayXLME.pas',
  knslRPMaxDay2 in 'knslRPMaxDay2.pas' {rpMaxDay2},
  knslRPRasxMonthZab in 'knslRPRasxMonthZab.pas' {rpRasxMonthZab},
  knslRPVector in 'knslRPVector.pas' {rpVector},
  knslRPRasxEnergy2 in 'knslRPRasxEnergy2.pas' {rpRasxEnergy2},
  knsl3ExportDBMaket in 'knsl3ExportDBMaket.pas',
  VectorDiagramHelper in 'VectorDiagramHelper.pas',
  knslRPRasxMonthV3 in 'knslRPRasxMonthV3.pas' {RPRasxMonthV3},
  knslRPSostavGroupV2 in 'knslRPSostavGroupV2.pas' {RPSostavGroupV2},
  knsl3discret in 'knsl3discret.pas',
  knsl3Monitor in 'knsl3Monitor.pas',
  knsl3FrmMonitor in 'knsl3FrmMonitor.pas' {TFrmMonitor},
  knslRPAllGraphs in 'knslRPAllGraphs.pas' {RPAllGraphs},
  utlSpeedTimer in 'utlSpeedTimer.pas',
  knslRPVedomPokazV2 in 'knslRPVedomPokazV2.pas' {RPVedomPokazV2},
  knsl3HideCtrlFrame in 'knsl3HideCtrlFrame.pas' {HideCtrlFrame},
  knsl2qwerymdl in 'knsl2qwerymdl.pas',
  knsl2fqwerymdl in 'knsl2fqwerymdl.pas' {TQweryModule},
  knsl3shem in 'knsl3shem.pas' {TShemModule},
  knsl2qweryvmeter in 'knsl2qweryvmeter.pas',
  knsl2qwerygroupsrv in 'knsl2qwerygroupsrv.pas',
  knsl3jointable in 'knsl3jointable.pas',
  knsl2qweryabonsrv in 'knsl2qweryabonsrv.pas',
  knsl2qwerysystem in 'knsl2qwerysystem.pas',
  knslRPHourGraphDayXLME in 'knslRPHourGraphDayXLME.pas',
  knsl2qwerytmr in 'knsl2qwerytmr.pas',
  knsl2qweryarchmdl in 'knsl2qweryarchmdl.pas',
  knsl2QweryTrServer in 'knsl2QweryTrServer.pas',
  knsl3HolesFinder in 'knsl3HolesFinder.pas',
  knsl3datatype in 'knsl3datatype.pas',
  knsl3datamatrix in 'knsl3datamatrix.pas',
  knsl3calcsystem in 'knsl3calcsystem.pas',
  kns3CalcTrServer in 'kns3CalcTrServer.pas',
  kns3SaveTrServer in 'kns3SaveTrServer.pas',
  knsl3savesystem in 'knsl3savesystem.pas',
  knsl2CE301BYMeter in 'knsl2CE301BYMeter.pas';

{$R *.RES}
var wnd         : HWND;
    LE          : DWORD;      //Загрузка только одного приложение knslmodule
    Fl          : TINIFile;
    m_nOOOA     : integer;
begin
  Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\USPD_Config.ini');
  m_nOOOA := Fl.ReadInteger('DBCONFIG','m_nOpenOnlyOneApp', -1);
  Fl.Destroy;
  CreateMutex(nil, false, PChar('{92CEEB41-1CCD-477B-8A34-AA0358992A59}'));
  if (m_nOOOA >= 1) then
  begin
    LE := GetLastError();
    if (LE = ERROR_ALREADY_EXISTS) or (LE = ERROR_ACCESS_DENIED) then
    begin
      wnd := FindWindow(LPCTSTR('TTKnsForm'), nil);
      if wnd <> 0 then
        SendMessage(wnd,WM_GOTOFOREGROUND, 0, 0);
      Application.Terminate;
      Exit;
    end;
  end;
  Application.Initialize;
  Application.CreateForm(TTKnsForm, TKnsForm);
  Application.CreateForm(TrpKPDReport, rpKPDReport);
  Application.CreateForm(TrpMaxDay, rpMaxDay);
  Application.CreateForm(TrpRasxEnerg, rpRasxEnerg);
  Application.CreateForm(TrpPokMeters, rpPokMeters);
  Application.CreateForm(TrpSostavGroup, rpSostavGroup);
  Application.CreateForm(TrpMaxPowerLoad, rpMaxPowerLoad);
  Application.CreateForm(TrpCalcMoney, rpCalcMoney);
  Application.CreateForm(TfrmEditExpr, frmEditExpr);
  Application.CreateForm(TrpRasxMonth, rpRasxMonth);
  Application.CreateForm(TTUsers, TUsers);
  Application.CreateForm(TrpPokEnerg, rpPokEnerg);
  Application.CreateForm(TrpExpenseDay, rpExpenseDay);
  Application.CreateForm(TrpRasxDay, rpRasxDay);
  Application.CreateForm(TrpMaxDayFact, rpMaxDayFact);
  Application.CreateForm(TrpIncrementDay, rpIncrementDay);
  Application.CreateForm(TrpSizeEnergy, rpSizeEnergy);
  Application.CreateForm(TLoadMainForm, LoadMainForm);
  Application.CreateForm(TProgressLoad, ProgressLoad);
  Application.CreateForm(TMCalendar, MCalendar);
  Application.CreateForm(TRPGomelActive, RPGomelActive);
  Application.CreateForm(TRPGomelReact, RPGomelReact);
  Application.CreateForm(TRPValidInfo, RPValidInfo);
  Application.CreateForm(TConfMeterModule, ConfMeterModule);
  Application.CreateForm(TTRpSelfTest, TRpSelfTest);
  Application.CreateForm(TTAbonManager, TAbonManager);
  Application.CreateForm(TPortForAbon, PortForAbon);
  Application.CreateForm(Tfr3LimitEditor, fr3LimitEditor);
  Application.CreateForm(TRPValidSlice, RPValidSlice);
  Application.CreateForm(TrpKorrTime, rpKorrTime);
  Application.CreateForm(TRPTeploMoz, RPTeploMoz);
  Application.CreateForm(TTMeterChandge, TMeterChandge);
  Application.CreateForm(TTDataFinder, TDataFinder);
  Application.CreateForm(TfrMainEditor, frMainEditor);
  Application.CreateForm(TRPVedomPokaz, RPVedomPokaz);
  Application.CreateForm(TRPGomelBalans, RPGomelBalans);
  Application.CreateForm(TRPPowerHourMTZ, RPPowerHourMTZ);
  Application.CreateForm(TRPCalcHeatMTZ, RPCalcHeatMTZ);
  Application.CreateForm(TrpMaxDay2, rpMaxDay2);
  Application.CreateForm(TrpRasxMonthZab, rpRasxMonthZab);
  Application.CreateForm(TRPVector, RPVector);
  Application.CreateForm(TrpRasxEnergy2, rpRasxEnergy2);
  Application.CreateForm(TRPAllGraphs, f_RPAllGraphs);
  Application.CreateForm(TRPRasxMonthV3, f_RPRasxMonthV3);
  Application.CreateForm(TRPSostavGroupV2, f_RPSostavGroupV2);
  Application.CreateForm(TRPVedomPokazV2, f_RPVedomPokazV2);
  Application.CreateForm(THideCtrlFrame, HideCtrlFrame);
  //Application.CreateForm(TTQweryModule, TQweryModule);
  Application.Run;
end.
