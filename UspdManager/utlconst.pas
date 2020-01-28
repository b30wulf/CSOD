unit utlconst;

interface


const
  MAX_USER = 100;
//Boxes
//BOX For L1 0..9
//Уровни доступа
  LV_LEVEL_0 = 0;
  LV_LEVEL_1 = 1;
  LV_LEVEL_2 = 2;
  LV_LEVEL_3 = 3;
//Разрешения

  SA_USER_PERMIT_DE  = 0;
  SA_USER_PERMIT_PE  = 1;
  SA_USER_PERMIT_QE  = 2;
  SA_USER_PERMIT_CE  = 3;
  SA_USER_PERMIT_GE  = 4;
  SA_USER_PERMIT_TE  = 5;
  SA_USER_PERMIT_CNE = 6;
  SA_USER_PERMIT_PRE = 7;

//Идентификаторы граф компонентов
  CL_TREE_CONF                 = 0;//конфигуратор

//Состояния для BELTI модуля
  ST_NULL_BTI                  = 0;
  ST_WAIT_ASK_USPD_TYPE_BTI    = 1;
  ST_USPD_TYPE_BTI             = 2;
  ST_WAIT_ASK_USPD_DEV_BTI     = 3;
  ST_USPD_DEV_BTI              = 4;
  ST_WAIT_ASK_USPD_CHARDEV_BTI = 5;
  ST_USPD_CHARDEV_BTI          = 6;
  ST_WAIT_ASK_USPD_CHARKAN_BTI = 7;
  ST_USPD_CHARKAN_BTI          = 8;
  ST_READY_BTI                 = 9;



  KNS_COLOR  = $00FFe0a0;
  KNS_NCOLOR = $00FFf3e8;

  MAX_PARAM  = 50; 
  MAX_PORT   = 50;
  MAX_MTYPE  = 50;
  MAX_TTYPE  = 50;             
  MAX_PTYPE  = 100;
  MAX_METER  = 200;
  MAX_CTYPE  = 50;
  MAX_DYNCONN = 20;

  MAX_GROUP  = 50;
  MAX_VMETER = 200;

  BOX_L2_LD  = 0;            BOX_L2_LD_SZ  = 1024*5;
  BOX_L1     = MAX_METER+0;  BOX_L1_SZ     = 1024*50;
  BOX_L2     = MAX_METER+10; BOX_L2_SZ     = 1024*50;
  BOX_L3     = MAX_METER+11; BOX_L3_SZ     = 1024*50;
  BOX_L3_LME = MAX_METER+9;  BOX_L3_LME_SZ = 1024*4;
  BOX_L4     = MAX_METER+12; BOX_L4_SZ     = 1024*4;         //Integer
  BOX_L5     = MAX_METER+13; BOX_L5_SZ     = 1024*4;
  BOX_L3_QS  = MAX_METER+14; BOX_L3_QS_SZ  = 1024*60;        //18 kB --> 1 mec
  BOX_L5_TC  = MAX_METER+15; BOX_L5_TC_SZ  = 1024*10;


//Primitives for L1
  PH_DATARD_REQ    = 0;
  PH_DATARD_IND    = 1;
  PH_DATAWR_REQ    = 2;
  PH_DATAWR_IND    = 3;
  PH_CONN_IND      = 4;
  PH_RING_IND      = 5;
  PH_DISC_IND      = 6;
  PH_NANS_IND      = 7;
  PH_PHONEKEY_REQ  = 8;
  PH_STATIONON_REQ = 9;
  PH_STATIONOF_REQ = 10;
  PH_TEXT_IND      = 11;
  PH_DATA_IND      = 12;
  PH_ENDTMR_IND    = 13;
  PH_SETPORT_IND   = 14;
  PH_SETDEFSET_IND = 15;
  PH_CONN_REQ      = 16;
  PH_DISC_REQ      = 17;
  PH_CONNTMR_IND   = 18;
  PH_MCREG_IND     = 19;
  PH_MCONN_IND     = 20;
  PH_MRING_IND     = 21;
  PH_MNOCA_IND     = 22;
  PH_MBUSY_IND     = 23;
  PH_MNDLT_IND     = 24;
  PH_MNANS_IND     = 25;
  PH_MDISC_IND     = 26;
  PH_DISCTMR_IND   = 27;
  PH_CALLOFFTMR_IND= 28;
  PH_RCONN_IND     = 29;
  PH_WTOKTMR_IND   = 30;
  PH_MDISCSCMPL_IND= 31;
  PH_EVENTS_INT    = 32;
  PH_RECONN_IND    = 33;
  PH_FREE_PORT_IND  = 34;
  PH_SETT_PORT_IND  = 35;
{
  if Pos('+CREG:',strText)>0      then Begin FindStation(strText);  End;
  if Pos('CONNECT',strText)>0     then Begin SendToL1(PH_CONN_IND);SetUpBuffer End;
  if Pos('RING',strText)>0        then Begin SendToL1(PH_RING_IND);SetUpBuffer End;
  if Pos('NO CARRIER',strText)>0  then Begin SendToL1(PH_DISC_IND);SetUpBuffer End;
  if Pos('BUSY',strText)>0        then Begin SendToProc(2,DIR_L1TOL3,AL_RCON_REQ,BOX_L4,@i);SetUpBuffer;End;
  if Pos('NO DIALTONE',strText)>0 then Begin SendToProc(2,DIR_L1TOL3,AL_DISC_REQ,BOX_L4,@i);SetUpBuffer;End;
  if Pos('NO ANSWER',strText)>0   then Begin SendToL2(PH_NANS_IND);SetUpBuffer End;
}
  //Внутренние примитивы (Таймер и тд)

  DL_DATARD_REQ = 30+0;
  DL_DATARD_IND = 30+1;
  DL_DATAWR_REQ = 30+2;
  DL_DATAWR_IND = 30+3;
  DL_REPMSG_TMR = 30+4;
  DL_ERRTMR_IND = 30+5;

  DL_STOPSNDR_IND   = 30+6;
  DL_STARTSNDR_IND  = 30+7;
  DL_FREESNDR_IND   = 30+8;

  DL_STOPL2OBS_IND  = 30+9;
  DL_STARTL2OBS_IND = 30+10;
  DL_GOL2OBS_IND    = 30+11;
  DL_SYNC_EVENT_IND = 30+12;

  DL_STOPCHLOBS_IND  = 30+13;
  DL_STARTCHLOBS_IND = 30+14;
  DL_GOCHLOBS_IND    = 30+15;
  DL_PAUSESNDR_IND   = 30+16;
  DL_GOSNDR_IND      = 30+17;
  DL_LOADOBSERVER_IND= 30+18;
  DL_LOADOBSERVER_GR_IND= 30+19;
  DL_LOADOBSERVER_ALLGR_IND= 30+20;
  DL_ERRTMR1_IND     = 30+21;
  DL_LOADMETER_IND   = 30+22;
  DL_LOAD_EV_METER_IND=30+23;
  DL_AUTO_SEND_TMR    =30+24;
  DL_GSM_SET_TMR      =30+26;
  DL_GSM_FRE_TMR      =30+27;
  DL_GSM_DSC_TMR      =30+28;



  //Внутренние примитивы (Таймер и тд)

  QL_DATARD_REQ         = 60+0;
  QL_DATARD_IND         = 60+1;
  QL_DATAWR_REQ         = 60+2;
  QL_DATAWR_IND         = 60+3;
  QL_CQRYMSG_TMR        = 60+4;
  QL_GQRYMSG_TMR        = 60+5;
  QL_UPDATE_TMR         = 60+6;
  QL_DATA_GRAPH_REQ     = 60+7;
  QL_DATA_FIN_GRAPH_REQ = 60+8;
  QL_SAVE_TMR           = 60+9;
  QL_INITL1_REQ         = 60+10;
  QL_INITL2_REQ         = 60+11;
  QL_INITL3_REQ         = 60+12;
  QL_PACKDB_REQ         = 60+13;
  QL_DATA_ALLGRAPH_REQ  = 60+14;
  QL_START_TMR          = 60+15;
  QL_PROTOSV_TMR        = 60+16;
  QL_POOL_TMR           = 60+17;
  QL_SETGENSETT_REQ     = 60+18;
  QL_CONNCOMPL_REQ      = 60+19;
  QL_DISCCOMPL_REQ      = 60+20;
  QL_CONNOFF_TMR        = 60+21;
  QL_LOAD_EVENTS_REQ    = 60+22;
  QL_START_SYN_REQ      = 60+23;
  QL_STOP_SYN_REQ       = 60+24;


  //Внутренние примитивы (Таймер и тд)

  AL_DATARD_REQ    = 90+0;
  AL_DATARD_IND    = 90+1;
  AL_DATAWR_REQ    = 90+2;
  AL_DATAWR_IND    = 90+3;
  AL_RCON_REQ      = 90+4;
  AL_DISC_REQ      = 90+5;
  AL_REPMSG_TMR    = 90+6;
  AL_VIEWDATA_REQ  = 90+7;
  AL_VIEWGRAPH_REQ = 90+8;
  AL_VIEWREPLACED_REQ = 90+9;
  AL_UPDATEDATA_REQ   = 90+10;
  AL_UPDATEGRAPH_REQ  = 90+11;
  AL_UPDMETADATA_REQ  = 90+12;
  AL_UPDATEALLGRAPH_REQ=90+13;
  AL_DATA_CALC_REQ    = 90+14;
  AL_DATA_FIN_CALC_IND= 90+15;
  AL_UPDATEALLDATA_REQ= 90+16;
  AL_UPDATETSLICE_REQ = 90+17;
  AL_UPDATETARCH_REQ  = 90+18;
  AL_UPDATETTARIF_REQ = 90+19;
  AL_RELOADVMET_REQ   = 90+20;
  AL_RESETPARAMS_REQ  = 90+21;
  AL_REFRESHDATA_REQ  = 90+22;
  AL_STOPL2_IND       = 90+23;

  NL_SETOPENL1_REQ    = 120+0;
  NL_SETOPENL2_REQ    = 120+1;
  NL_SETOPENL3_REQ    = 120+2;
  NL_SETOPENL4_REQ    = 120+3;
  NL_SETOPENL5_REQ    = 120+4;
  NL_SETREMML1_REQ    = 120+5;
  NL_SETREMML2_REQ    = 120+6;
  NL_SETREMML3_REQ    = 120+7;
  NL_SETREMML4_REQ    = 120+8;
  NL_SETREMML5_REQ    = 120+9;
  NL_SETOPENALL_REQ   = 120+10;
  NL_SETREMMALL_REQ   = 120+11;
  NL_SETOPENRALL_REQ  = 120+12;
  NL_SETREMMRALL_REQ  = 120+13;
  NL_FULLDISC_REQ     = 120+14;
  NL_CONNECTDB_REQ    = 120+15;
  NL_USPDCONN_REQ     = 120+16;
  NL_SAVEDB_REQ       = 120+17;
  NL_SAVEDBOK_REQ     = 120+18;
  NL_PACKSTART_REQ    = 120+19;
  NL_STARTCALC_REQ    = 120+20;
  NL_WAITPOLL_REQ     = 120+21;
  NL_STARTPOLL_REQ    = 120+22;
  NL_UPDGRAPH_REQ     = 120+23;
  NL_DATAINFO_REQ     = 120+24;
  NL_STOPSRV_REQ      = 120+25;
  NL_STARTSRV_REQ     = 120+26;
  NL_STARTSRVGR_REQ   = 120+27;
  NL_STARTCORR_REQ    = 120+28;
  NL_FINALCORR_REQ    = 120+29;

  //NL_INITL1_REQ       = 120+14;
  //NL_INITL2_REQ       = 120+15;
  //NL_INITL3_REQ       = 120+16;
  //Команды Менеджера УСПД

  SC_LOAD_USPD_REQ    = 30+0;
  SC_TERM_USPD_REQ    = 30+1;
  SC_RESM_USPD_REQ    = 30+2;
  SC_SUSP_USPD_REQ    = 30+3;
  SC_UPAK_USPD_REQ    = 30+4;
  SC_UPAK_BASE_REQ    = 30+5;
  SC_UPAK_SETT_REQ    = 30+6;
  SC_UPAK_ALLP_REQ    = 30+7;

  //Признаки окончания опроса
  QM_FIN_MTR_IND   = $ff00;
  QM_FIN_CHN_IND   = $ff01;
  QM_FIN_ALL_IND   = $ff02;

  QM_FIN_GPLD_IND  = $ff03;
  QM_FIN_GPLA_IND  = $ff04;

  QM_ENT_MTR_IND   = $ff05;
  QM_ENT_CHN_IND   = $ff06;
  QM_FIN_COM_IND   = $ff07;

  //Состояние менеджера опроса
  QM_NULL_STATE    = 0;
  QM_POOL_STATE    = 1;

  //Состояние менеджера уровней
  LME_NULL_STATE = 0;
  LME_POLL_STATE = 1;
  LME_CALC_STATE = 2;
  LME_VIEW_STATE = 3;
  LME_GPLL_STATE = 4;
  LME_PACK_STATE = 5;
  LME_GPLLALL_STATE = 6;

  //События менеджера уровней

  LME_GO_POLL_REQ       = 0;
  LME_STOP_POLL_REQ     = 1;
  LME_STOP_POLC_REQ     = 2;
  LME_FIN_MTR_POLL_REQ  = 3;
  LME_FIN_CHN_POLL_REQ  = 4;
  LME_FIN_MTR_GPLD_REQ  = 5;
  LME_FIN_CHN_GPLA_REQ  = 6;
  LME_GO_GRAPH_POLL_REQ = 7;
  LME_GO_ALLGRAPH_POLL_REQ = 8;
  LME_DISC_POLL_REQ     = 9;
  LME_STOP_POLL1_REQ    = 10;
  LME_LOAD_COMPL_IND    = 11;
  //LME_FIN_CHN_GPOLL_REQ  = 9;


  //Направления
  DIR_L1TOL1 = 0;
  DIR_L1TOL2 = 1;
  DIR_L2TOL1 = 2;
  DIR_L1TOL3 = 3;
  DIR_L1TOAT = 4;
  DIR_L1TOTXT = 5;

  DIR_L2TOL2 = 10+0;
  DIR_L2TOL3 = 10+1;
  DIR_L3TOL2 = 10+2;
  DIR_LMTOL2 = 10+3;
  DIR_QMTOL2 = 10+4;

  DIR_L3TOL3 = 20+0;
  DIR_L3TOL4 = 20+1;
  DIR_L4TOL3 = 20+2;

  DIR_LM3TOLM3 = 20+3;
  DIR_LLTOLM3  = 20+4;
  DIR_LHTOLM3  = 20+5;
  DIR_LMETOL1  = 20+6;
  DIR_LHTOLMT  = 20+7;
  DIR_LHTOLMC  = 20+8;
  DIR_LHTOLAL  = 20+9;

  DIR_L4TOL4 = 30+0;
  DIR_L4TOAR = 30+1;
  DIR_ARTOL4 = 30+2;

  DIR_L5TOL5 = 40+0;
  DIR_L5TOL6 = 40+1;
  DIR_L6TOL5 = 40+2;
  DIR_L5TOL1 = 40+3;

  DIR_L2TOVML3   = 50+0;
  DIR_VML3TOVML3 = 50+1;
  DIR_VML3TOL2   = 50+2;

  DIR_L1TOBTI    = 60;
  DIR_BTITOBTI   = 60+1;
  DIR_BTITOL1    = 60+2;
  DIR_BTITOL3    = 60+3;
  DIR_L3TOBTI    = 60+4;
  DIR_LMETOL4    = 60+5;

  DIR_L1TOL6     = 60+6;
  DIR_ULTOL6     = 60+7;
  DIR_L6TOL6     = 60+8;

  //Типы запросов
  REQ_QPLUS = 0;
  REQ_QMINS = 1;
  REQ_PPLUS = 2;
  REQ_PMINS = 3;

  //Типы портов
  DEV_COM_LOC  = 0;
  DEV_COM_GSM  = 1;
  DEV_TCP_SRV  = 2;
  DEV_TCP_CLI  = 3;
  DEV_UDP_SRV  = 4;
  DEV_UDP_CLI  = 5;

  //Типы протоколов
  DEV_NUL      = 0;
  DEV_MASTER   = 1;
  DEV_SLAVE    = 2;
  DEV_BTI_CLI  = 3;
  DEV_BTI_SRV  = 4;
  DEV_SQL      = 5;
  DEV_UDP_CC301= 6;

  //Типы счетчиков
  MET_NULL   = 0;
  MET_SS101  = 1;
  MET_SS301  = 2;
  MET_EMS134 = 3;
  MET_CE6850 = 4;
  MET_CE6822 = 5;
  MET_SET4TM = 6;
  MET_EE8005 = 7;
  MET_SUMM   = 8;
  MET_GSUMM  = 9;
  MET_RDKORR = 10;

  //Расположение счетчика
  MTR_LOCAL   = 0;
  MTR_REMOTE  = 1;
  MTR_REMLOC  = 2;

  CL_SUMM_TR  = 0;
  CL_AVRG_TR  = 1;
  CL_MAXM_TR  = 2;
  CL_NOTG_TR  = 3;

  //Типы запросов
  EN_QRY_SUM     = 0; //Енергия: суммарная накопленная
  EN_QRY_INC_DAY = 1; //Енергия: Приращение за день
  EN_QRY_INC_MON = 2; //Енергия: Приращение за месяц
  EN_QRY_SRS_30M = 3; //Енергия: Cрез 30 мин
  EN_QRY_ALL_DAY = 4; //Енергия: Начало суток
  EN_QRY_ALL_MON = 5; //Енергия: Начало месяца
  PW_QRY_SRS_3M  = 6; //Мощность:Срез 3 мин
  PW_QRY_SRS_30M = 7; //Мощность:Срез 30 мин
  PW_QRY_MGACT   = 8; //Мощность:Мгновенная активная
  PW_QRY_MGRCT   = 9; //Мощность:Мгновенная реактивная
  U_QRY          = 10;//Напряжение
  I_QRY          = 11;//Ток
  F_QRY          = 12;//Частота
  KM_QRY         = 13;//Коэффициент можности
  DATE_QRY       = 14;//Дата-время

  //Типы расчетов
  EVL_ALLD_CL     = 0;
  EVL_ARCH_CL     = 1;
  EVL_GRPH_CL     = 2;

{
Эн: Суммарная накопленная E+
Эн: Суммарная накопленная E-
Эн: Суммарная накопленная R+
Эн: Суммарная накопленная R-
Эн: Приращение за день E+
Эн: Приращение за день E-
Эн: Приращение за день R+
Эн: Приращение за день R-
Эн: Приращение за месяц E+
Эн: Приращение за месяц E-
Эн: Приращение за месяц R+
Эн: Приращение за месяц R-
Эн: Cрез 30 мин E+
Эн: Cрез 30 мин E-
Эн: Cрез 30 мин R+
Эн: Cрез 30 мин R-
Эн: Начало суток E+
Эн: Начало суток E-
Эн: Начало суток R+
Эн: Начало суток R-
Эн: Начало месяца E+
Эн: Начало месяца E-
Эн: Начало месяца R+
Эн: Начало месяца R-
Эн: Начало года E+
Эн: Начало года E-
Эн: Начало года R+
Эн: Начало года R-
Мт: Срез 3 мин P+
Мт: Срез 3 мин P-
Мт: Срез 3 мин Q+
Мт: Срез 3 мин Q-
Мт: Срез 30 мин P+
Мт: Срез 30 мин P-
Мт: Срез 30 мин Q+
Мт: Срез 30 мин Q-
Мт: Мгновенная активная S
Мт: Мгновенная активная A
Мт: Мгновенная активная B
Мт: Мгновенная активная C
Мт: Мгновенная реактивная S
Мт: Мгновенная реактивная A
Мт: Мгновенная реактивная B
Мт: Мгновенная реактивная C
Напряжение A
Напряжение B
Напряжение C
Ток A
Ток B
Ток C
Частота
Коэффициент мощности A
Коэффициент мощности B
Коэффициент мощности C
Коэффициент A
Коэффициент R
Дата-время
}
  //Типы ответов
  QRY_NULL_COMM         = 0;//0
  QRY_ENERGY_SUM_EP     = 1;//1
  QRY_ENERGY_SUM_EM     = 2;
  QRY_ENERGY_SUM_RP     = 3;
  QRY_ENERGY_SUM_RM     = 4;
  QRY_ENERGY_DAY_EP     = 5;//2
  QRY_ENERGY_DAY_EM     = 6;
  QRY_ENERGY_DAY_RP     = 7;
  QRY_ENERGY_DAY_RM     = 8;
  QRY_ENERGY_MON_EP     = 9;//3
  QRY_ENERGY_MON_EM     = 10;
  QRY_ENERGY_MON_RP     = 11;
  QRY_ENERGY_MON_RM     = 12;
  QRY_SRES_ENR_EP       = 13;//36
  QRY_SRES_ENR_EM       = 14;
  QRY_SRES_ENR_RP       = 15;
  QRY_SRES_ENR_RM       = 16;
  QRY_NAK_EN_DAY_EP     = 17;//42
  QRY_NAK_EN_DAY_EM     = 18;
  QRY_NAK_EN_DAY_RP     = 19;
  QRY_NAK_EN_DAY_RM     = 20;
  QRY_NAK_EN_MONTH_EP   = 21;//43
  QRY_NAK_EN_MONTH_EM   = 22;
  QRY_NAK_EN_MONTH_RP   = 23;
  QRY_NAK_EN_MONTH_RM   = 24;
  QRY_NAK_EN_YEAR_EP    = 25;
  QRY_NAK_EN_YEAR_EM    = 26;
  QRY_NAK_EN_YEAR_RP    = 27;
  QRY_NAK_EN_YEAR_RM    = 28;
  QRY_E3MIN_POW_EP      = 29;//5
  QRY_E3MIN_POW_EM      = 30;
  QRY_E3MIN_POW_RP      = 31;
  QRY_E3MIN_POW_RM      = 32;
  QRY_E30MIN_POW_EP     = 33;//6
  QRY_E30MIN_POW_EM     = 34;
  QRY_E30MIN_POW_RP     = 35;
  QRY_E30MIN_POW_RM     = 36;
  QRY_MGAKT_POW_S       = 37;//8
  QRY_MGAKT_POW_A       = 38;
  QRY_MGAKT_POW_B       = 39;
  QRY_MGAKT_POW_C       = 40;
  QRY_MGREA_POW_S       = 41;//9
  QRY_MGREA_POW_A       = 42;
  QRY_MGREA_POW_B       = 43;
  QRY_MGREA_POW_C       = 44;
  QRY_U_PARAM_S         = 45;
  QRY_U_PARAM_A         = 46;//10
  QRY_U_PARAM_B         = 47;
  QRY_U_PARAM_C         = 48;
  QRY_I_PARAM_S         = 49;
  QRY_I_PARAM_A         = 50;//11
  QRY_I_PARAM_B         = 51;
  QRY_I_PARAM_C         = 52;
  QRY_FREQ_NET          = 53;//13
  QRY_KOEF_POW_A        = 54;//12
  QRY_KOEF_POW_B        = 55;
  QRY_KOEF_POW_C        = 56;
  QRY_KPRTEL_KPR        = 57;//24
  QRY_KPRTEL_KE         = 58;
  QRY_DATA_TIME         = 59;//32
  QRY_MAX_POWER_EP      = 60;
  QRY_MAX_POWER_EM      = 61;
  QRY_MAX_POWER_RP      = 62;
  QRY_MAX_POWER_RM      = 63;
  QRY_SRES_ENR_DAY_EP   = 64;//36
  QRY_SRES_ENR_DAY_EM   = 65;
  QRY_SRES_ENR_DAY_RP   = 66;
  QRY_SRES_ENR_DAY_RM   = 67;
  QRY_AUTORIZATION      = 68;
  QRY_JRNL_T1           = 69;
  QRY_JRNL_T2           = 70;
  QRY_JRNL_T3           = 71;


  //QRY_POINT_POS         = 100;


  //Типы протоколов верхнего уровня
  HIP_A2K = 0;
  HIP_C12 = 1;
  HIP_BTI = 2;
  HIP_ACC = 3;

  //Идентификаторы уровней
  LID_L1 = 0;
  LID_L2 = 1;
  LID_L3 = 2;
  LID_L4 = 3;
  LID_L5 = 4;

  //Действие над узлом
  ND_EDIT = 0;
  ND_ADD  = 1;
  ND_DEL  = 2;

  {
  Текущий
  Архивируемый
  График
  }
  //Тип хранения
  SV_CURR_ST = 0;
  SV_ARCH_ST = 1;
  SV_GRPH_ST = 2;
  SV_PDPH_ST = 3;

  //Лимиты
  LM_MIN = 0;
  LM_NRM = 1;
  LM_MAX = 2;

  //Признак обновления
  DT_OLD = 0;
  DT_NEW = 1;

  //Состояния уровня L1
  ST_DISC_L1      = 0;
  ST_WAIT_CONN_L1 = 1;
  ST_CONN_L1      = 2;

  const chEndTn : array[0..7] of String = (
    ' ',
    ',',
    '+',
    '-',
    '/',
    '*',
    ')',
    ';');
  const chLmeState : array[0..4] of String = (
  'LME_NULL_STATE',
  'LME_POLL_STATE',
  'LME_CALC_STATE',
  'LME_VIEW_STATE',
  'LME_GPLL_STATE');

  const chBTISate : array [0..9]  of String = (
  'ST_NULL_BTI',
  'ST_WAIT_ASK_USPD_TYPE_BTI',
  'ST_USPD_TYPE_BTI',
  'ST_WAIT_ASK_USPD_DEV_BTI',
  'ST_USPD_DEV_BTI',
  'ST_WAIT_ASK_USPD_CHARDEV_BTI',
  'ST_CHARDEV_BTI',
  'ST_WAIT_ASK_USPD_CHARKAN_BTI',
  'ST_CHARKAN_BTI',
  'ST_READY_BTI'
  );

  const chQmState : array[0..1] of String = (
  'QML_NULL_STATE',
  'QML_POOL_STATE');


    const chQryType : array[0..14] of String = (
    'Энергия: суммарная накопленная',
    'Энергия: Приращение за день',
    'Энергия: Приращение за месяц',
    'Энергия: Cрез 30 мин',
    'Энергия: Начало суток',
    'Энергия: Начало месяца',
    'Мощность:Срез 3 мин',
    'Мощность:Срез 30 мин',
    'Мощность:Мгновенная активная',
    'Мощность:Мгновенная реактивная',
    'Напряжение',
    'Ток',
    'Частота',
    'Коэффициент можности',
    'Дата-время');


    const chModule : array[0..10] of String = (
    'DEFAULT_PORT',
    'PLC_CPU_260',
    'PLC_CPU_X20',
    'TCPCOM_IF_681',
    '3AI375_6',
    '3AO775_6',
    '3DI477_6',
    '3DO760_6',
    'DM9371_IN',
    'DM9322_OUT',
    'AI4622_IN');

    const chObjectType : array[0..2] of String = (
    'ТС',
    'ТИ',
    'ТУ');
    const chParity : array[0..2] of String = (
    'NO',
    'EVEN',
    'ODD');
    const chDataBit : array[0..1] of String = (
    '7',
    '8');
    const chStopBit : array[0..2] of String = (
    '1',
    '1.5',
    '2');
    const chPriority : array[0..1] of String = (
    'LOW',
    'HIGHT');
    const chAlarmMode : array[0..2] of String = (
    'LO_TO_HI',
    'HI_TO_LO',
    'AL_TO_AL');
    const chPulceType : array[0..1] of String = (
    'INVERT',
    'DIRECT');
    const chState : array[0..3] of String = (
    'CLOSE',
    'OPEN',
    'LOCK',
    'UNLOCK');

    const chEvents : array[0..14] of String = (
    'EV_SET_HI',
    'EV_REM_HI',
    'EV_SET_LO',
    'EV_REM_LO',
    'EV_CHG_PR',
    'EV_0T1_CH',
    'EV_1T0_CH',
    'EV_SAL_CH',
    'EV_RAL_CH',
    'EV_0T1_ST',
    'EV_1T0_ST',
    'EV_INI_CH',
    'EV_ALP_CH',
    'EV_ALS_CH',
    'EV_CHK_CH');
    const chAlarms : array[0..1] of String = (
    'GOOD',
    'ALARM');
    const chIRate : array[0..6] of String = (
    '1200',
    '2400',
    '9600',
    '14400',
    '38400',
    '57600',
    '115200');
    const chInterface : array[0..4] of String = (
    'TCP',
    'RS232',
    'RS485',
    'USB',
    'SYS');
    const chMeterType : array[0..7] of String = (
    'SSNULL',
    'SS101',
    'SS301',
    'EMS134',
    'CE6850',
    'CE6822',
    'SET4TM',
    'EE8005');
    const chMeterState : array[0..1] of String = (
    'CLOSE',
    'OPEN');
    const chPortType : array[0..4] of String = (
    'COM_L2',
    'COM_L4',
    'GSM_MODEM',
    'TCP',
    'UDP');
    const
    //тип запроса по времени
    ONLY_ARCH      = 0;  //построекние отчета только на основе L3ARCHDATA
    CUR_AND_ARCH   = 1;  //построекние отчета на основе L3CURRENTDATA и L3ARCHDATA
    NO_DATA_M      = 2;  //нет данных за выбранный месяц + 1
    NO_DATA        = 3;  //нет данных вообще
    //Типы отчета
    INSTRUM_READ    = 0; // Показания счетчиков
    CONTROL_OF_MAX  = 1; // Контроль максимума
    STOCK_TACKING   = 2; // Учет потребления
    STATISTICS      = 3; // Статистика
    GROUP_STRUCTURE = 4; // Состав групп
    //Тип детализации
    DET_DAY    =  0;
    DET_MONTH  =  1;
    //Изменения чужих функций
    REP_TARIFS =  255;


//Для подсчета контрольной суммы
Const
  CRCHI             : Array[0..255] Of byte =
    (
    $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00,
    $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1,
    $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81,
    $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40,
    $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01,
    $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0,
    $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80,
    $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
    $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00,
    $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0,
    $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80,
    $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41,
    $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01,
    $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1,
    $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81,
    $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
    $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01,
    $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1,
    $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80,
    $41, $01, $C0, $80, $41, $00, $C1, $81, $40);

const
  CRCLO             : Array[0..255] Of byte =
    (
    $00, $C0, $C1, $01, $C3, $03, $02, $C2, $C6, $06, $07, $C7, $05,
    $C5, $C4, $04, $CC, $0C, $0D, $CD, $0F, $CF, $CE, $0E, $0A, $CA,
    $CB, $0B, $C9, $09, $08, $C8, $D8, $18, $19, $D9, $1B, $DB, $DA,
    $1A, $1E, $DE, $DF, $1F, $DD, $1D, $1C, $DC, $14, $D4, $D5, $15,
    $D7, $17, $16, $D6, $D2, $12, $13, $D3, $11, $D1, $D0, $10, $F0,
    $30, $31, $F1, $33, $F3, $F2, $32, $36, $F6, $F7, $37, $F5, $35,
    $34, $F4, $3C, $FC, $FD, $3D, $FF, $3F, $3E, $FE, $FA, $3A, $3B,
    $FB, $39, $F9, $F8, $38, $28, $E8, $E9, $29, $EB, $2B, $2A, $EA,
    $EE, $2E, $2F, $EF, $2D, $ED, $EC, $2C, $E4, $24, $25, $E5, $27,
    $E7, $E6, $26, $22, $E2, $E3, $23, $E1, $21, $20, $E0, $A0, $60,
    $61, $A1, $63, $A3, $A2, $62, $66, $A6, $A7, $67, $A5, $65, $64,
    $A4, $6C, $AC, $AD, $6D, $AF, $6F, $6E, $AE, $AA, $6A, $6B, $AB,
    $69, $A9, $A8, $68, $78, $B8, $B9, $79, $BB, $7B, $7A, $BA, $BE,
    $7E, $7F, $BF, $7D, $BD, $BC, $7C, $B4, $74, $75, $B5, $77, $B7,
    $B6, $76, $72, $B2, $B3, $73, $B1, $71, $70, $B0, $50, $90, $91,
    $51, $93, $53, $52, $92, $96, $56, $57, $97, $55, $95, $94, $54,
    $9C, $5C, $5D, $9D, $5F, $9F, $9E, $5E, $5A, $9A, $9B, $5B, $99,
    $59, $58, $98, $88, $48, $49, $89, $4B, $8B, $8A, $4A, $4E, $8E,
    $8F, $4F, $8D, $4D, $4C, $8C, $44, $84, $85, $45, $87, $47, $46,
    $86, $82, $42, $43, $83, $41, $81, $80, $40);

implementation

end.
