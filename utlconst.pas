unit utlconst;

interface
uses AdvAppStyler,AdvStyleIF;

type
   TBooleanArray = array[0..32767] of Boolean;
   PBooleanArray = ^TBooleanArray;
const
  __SetMask   : array [0..7] of byte = ($01, $02, $04, $08, $10, $20, $40, $80);
    DeltaFHF     : array [0..12] of integer = (1,0,1,2,3,5, 7, 14, 31, 62, 182, 365, 62);

  ET_NORMAL   = 0;
  ET_CRITICAL = 1;
  ET_RELEASE  = 2;

  RID_MULT : int64 = 1000000000000;
  DID_MULT : int64 = 100000000;
  TID_MULT : int64 = 10000;
  SID_MULT : int64 = 1;
  _MULT    : int64 = 10000;

  MAX_SPACE_DB          = 31;
  MAX_TARIFF            = 5;
  MAX_USER              = 100;
  {$IFDEF HOMEL}
  MAX_ABON              = 100;
  {$ELSE}
  MAX_ABON              = 100*1024;
  {$ENDIF}

  MAX_DELAY_IN_BTI_INIT = 10;
  MAX_LIM_TIMER         = 10;

  REG_UNKNOWN           = 500;
  REG_UNKNOWN_NAME      = 'Неизвестный адрес';

//Boxes
//BOX For L1 0..9
//Уровни доступа
  LV_LEVEL_0 = 0;
  LV_LEVEL_1 = 1;
  LV_LEVEL_2 = 2;
  LV_LEVEL_3 = 3;
//Уровни Групп
  GLV0       = 0;//Счетчики
  GLV1       = 1;//Сумма счетчиков
  GLV2       = 2;//Сумма счетчиков по суммам счетчиков
  GLV3       = 3;//...
  MAX_GVR    = 4;

  //Состояние задачи
  TASK_WAIT_RUN   = 0;
  TASK_WAIT_PORT  = 1;
  TASK_WAIT_CONN  = 2;
  TASK_CONN_OK    = 3;
  TASK_QUERY      = 4;
  TASK_WAIT_DISC  = 5;
  TASK_DISK_OK    = 6;
  TASK_QUERY_COMPL= 7;
  TASK_CONN_ERR   = 8;
  TASK_MANY_ERR   = 9;
  TASK_HAND_STOP  = 10;
  TASK_QUERY_WAIT = 11;
  TASK_QUERY_PROG = 12;
  TASK_QUERY_PROG_COMPL = 13;
  CALL_STATE      = 14;
  DATA_PROCESSING = 15;
  TASK_QUERY_WAIT_PROG = 16;
  TASK_ERROR_AUTORIZE  = 17;
  ERROR_PROG           = 18;
  ERROR_NO_PROG        = 19;  //  Концентратор не запрограммирован!
  TASK_CONN_ERR_REG    = 20;  //  Ошибка связи, будет произведен передозвон
  TASK_DATE_TIME_COR   = 21;  //  Корректировка времени успешно завершена
  TASK_ABON_QUALITY    = 22;  //  Качество данных положительное для абонента

  PULL_STATE_CONN = 0;
  PULL_STATE_DISC = 1;
  PULL_STATE_ERR  = 2;

  //Kill Token
  TASK_STATE_KIL  = 0;
  TASK_STATE_RUN  = 1;

   WAIT_NUL = 0;
   WAIT_PLS = 1;
   WAIT_ATH = 2;
   WAIT_CON = 3;
   DISC_CTR  = 4;

//Разрешения

  SA_USER_PERMIT_DE  = 0;  //Редактор данных
  SA_USER_PERMIT_PE  = 1;  //Редактор параметров
  SA_USER_PERMIT_QE  = 2;  //Редактор запросов
  SA_USER_PERMIT_CE  = 3;  //Редактор каналов
  SA_USER_PERMIT_GE  = 4;  //Редактор групп
  SA_USER_PERMIT_TE  = 5;  //Редактор тарифов
  SA_USER_PERMIT_CNE = 6;  //Редактор соединений
  SA_USER_PERMIT_PRE = 7;  //Редактор пользователей
  SA_USER_PERMIT_QYG = 8;  // Опрос групп
  SA_USER_PERMIT_ACR = 9;  // Разрешения для регионов для каждого пользователя

  ST_USER_TMR_TO_ACCESS = 300; //Время без потверждения пароля

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
  ST_WAIT_ASK_USPD_CHARGR_BTI  = 9;
  ST_USPD_CHARGR_BTI           = 10;
  ST_READY_BTI                 = 11;

//Состояния модуля поиска дыр в графиках
  ST_NULL_FH                   = 0;          //Нулевое состояние

  ST_START_FE_S                = 1;          //Состояние чтения: поиск последней записи в архивах
  ST_START_FE_D_PR             = 2;
  ST_START_FE_D_NAK            = 3;
  ST_START_FE_M_PR             = 4;
  ST_START_FE_M_NAK            = 5;

  ST_START_FH_S                = 6;          //Состояние чтения: поиск дыр
  ST_START_FH_D_PR             = 7;
  ST_START_FH_D_NAK            = 8;
  ST_START_FH_M_PR             = 9;
  ST_START_FH_M_NAK            = 10;

  ST_START_FA_S                = 11;         //Состояние чтения: поиск ненормальных значений в архивах
  ST_START_FA_D_PR             = 12;
  ST_START_FA_D_NAK            = 13;
  ST_START_FA_M_PR             = 14;
  ST_START_FA_M_NAK            = 15;

  ST_END_SERCH_FH              = 16;        //Состояние окончания поиска дыр
//--------------------------------------------------------------------------
//Состояния модуля самотестирования системы
  ST_SLFT_STAT_NULL            = 0;          //Нулевое состояние
  ST_SLFT_OPEN_CHAN            = 1;          //Открытие физ каналов
  ST_SLFT_OPEN_MODM            = 2;          //Соединение по модемам
  ST_SLFT_CONN_METR            = 3;          //Соединение со счетчиками
  ST_SLFT_CONN_USPD            = 4;          //Соединение с успд
  ST_SLFT_CONN_ARMT            = 5;          //Соединение с арм

//-------------Состояния параметризатора-----------------------
  ST_CONF_NULL                 = 0;
  ST_CONF_BTI_CONN             = 1;
  ST_CONF_CHECK_PASSW          = 2;
  ST_CONF_UPD_DATETIME         = 3;
  ST_CONF_UPD_PHADDR           = 4;
  ST_CONF_UPD_PORTCONF         = 5;
  ST_CONF_UPD_KI               = 6;
  ST_CONF_UPD_KU               = 7;
  ST_CONF_UPD_PASSW            = 8;
  ST_CONF_UPD_ADVPASSW         = 9;
  ST_CONF_UPD_TARIFF           = 10;
  ST_CONF_UPD_CALENDAR         = 11;
  ST_CONF_UPD_NEW_SUMSEASON    = 12;
  ST_CONF_UPD_NEW_WINSEASON    = 13;
  ST_CONF_READ_PORTCONF        = 14;
  ST_CONF_READ_KI              = 15;
  ST_CONF_READ_KU              = 16;
  ST_CONF_READ_TARIFF          = 17;
  ST_CONF_READ_CALENDAR        = 18;
  ST_CONF_READ_SUMSEASON       = 19;
  ST_CONF_READ_WINSEASON       = 20;
  ST_CONF_GSM_CONN             = 21;
  ST_CONF_GSM_DISC             = 22;
  ST_CONF_READ_DATE_TIME       = 23;
  ST_CONF_AUTHORIZATION        = 24;
  //ST_CONF_FREE_PORT            = 25;
  ST_CONF_FINISH               = 25;
//---------------Ошибки параметризатора-----------------------
  ER_CONF_PASSW                = 0;
  ER_CONF_FORMAT_PASSW         = 1;
  ER_CONF_FORMAT_ADVPASSW      = 2;
  ER_CONF_FORMAT_PHADDR        = 3;
  ER_CONF_PORT                 = 4;
  ER_CONF_GSM_PORT             = 5;
  ER_CONF_LOAD_TAR             = 6;
//-------------------------------------------------------------

  KNS_COLOR  = $00FFe0a0;
  KNS_NCOLOR = $00FFf3e8;
  //KNS_NCOLOR = $00E5D7D0;

  MAX_PARAM  = 134;
  MAX_CHNG   = 100;
  MAX_PORT   = 10000;
  MAX_MTYPE  = 50;
  MAX_TTYPE  = 50;             
  MAX_PTYPE  = 150;
  MAX_METER  = 900*1024;
  MAX_METER_PLUS = MAX_METER + 130;
  MAX_CTYPE  = 50;
  MAX_TRTIME  = 50;
  MAX_DYNCONN = 500;
  MAX_GPRS    = 4;

  MAX_CLUSTER = 15;
  MAX_VMCLUST = 100;
  MAX_QSERVER = 512;
  MAX_QWCELL  = 900*1024;
  MAX_FINDCL  = 365;

  MAX_GROUP  = 300;
  MAX_VMETER = 900*1024;
  //MAX_ABON   = 100;

  MAX_SZONE  = 30;
  MAX_TDAY   = 5;
  MAX_PLANE  = 10;
  MAX_TRTYPE = 30;
  MAX_TRLIM  = 8;

  MAX_REGION      = 200;
  MAX_DEPARTAMENT = 10000;
  MAX_TOWN        = 10000;
  MAX_STREET      = 10000;

  BOX_L2_LD  = 0;            BOX_L2_LD_SZ  = 1024*5;
  BOX_L1     = MAX_METER+0;  BOX_L1_SZ     = 1024*1000;
  BOX_L2     = MAX_METER+10; BOX_L2_SZ     = 1024*1000;
  BOX_L3     = MAX_METER+11; BOX_L3_SZ     = 1024*1000;
  BOX_L3_LME = MAX_METER+9;  BOX_L3_LME_SZ = 1024*500;
  BOX_L4     = MAX_METER+12; BOX_L4_SZ     = 1024*4;         //Integer
  BOX_L5     = MAX_METER+13; BOX_L5_SZ     = 1024*4;
  BOX_L3_QS  = MAX_METER+14; BOX_L3_QS_SZ  = 1024*1000;        //18 kB --> 1 mec 100 QSender
  BOX_L5_TC  = MAX_METER+115; BOX_L5_TC_SZ  = 1024*10;
  BOX_L3_HF  = MAX_METER+116; BOX_L3_HF_SZ  = 1024*4;
  BOX_LOAD   = MAX_METER+117; BOX_LOAD_SZ   = 1024*200;
  BOX_UN_LOAD= MAX_METER+118; BOX_UNLOAD_SZ = 200*100;
  BOX_UNLD   = MAX_METER+119; BOX_UNLD_SZ   = 1024*100;
  BOX_QSRV   = MAX_METER+120; BOX_QSRV_SZ   = 15*1024*300;
  BOX_CSRV   = MAX_METER+121; BOX_CSRV_SZ   = 15*1024*1200;
  BOX_SSRV   = MAX_METER+122; BOX_SSRV_SZ   = 15*1024*1200;
  BOX_SVBF   = MAX_METER+123; BOX_SVBF_SZ   = 15*1024*1000;
  BOX_CSSC   = MAX_METER+124; BOX_CSSC_SZ   = 1024*100;
                              BOX_PUMP_SZ   = 1024*100;
        {
          BOX_L2_LD  = 0;            BOX_L2_LD_SZ  = 1024*5;
  BOX_L1     = MAX_METER+0;  BOX_L1_SZ     = 1024*500;
  BOX_L2     = MAX_METER+10; BOX_L2_SZ     = 1024*500;
  BOX_L3     = MAX_METER+11; BOX_L3_SZ     = 1024*500;
  BOX_L3_LME = MAX_METER+9;  BOX_L3_LME_SZ = 1024*10;
  BOX_L4     = MAX_METER+12; BOX_L4_SZ     = 1024*4;         //Integer
  BOX_L5     = MAX_METER+13; BOX_L5_SZ     = 1024*4;
  BOX_L3_QS  = MAX_METER+14; BOX_L3_QS_SZ  = 1024*1000;        //18 kB --> 1 mec 100 QSender
  BOX_L5_TC  = MAX_METER+115; BOX_L5_TC_SZ  = 1024*10;
  BOX_L3_HF  = MAX_METER+116; BOX_L3_HF_SZ  = 1024*4;
  BOX_LOAD   = MAX_METER+117; BOX_LOAD_SZ   = 1024*200;
  BOX_UN_LOAD= MAX_METER+118; BOX_UNLOAD_SZ = 200*100;
  BOX_UNLD   = MAX_METER+119; BOX_UNLD_SZ   = 1024*100;
  BOX_QSRV   = MAX_METER+120; BOX_QSRV_SZ   = 1024*300;
  BOX_CSRV   = MAX_METER+121; BOX_CSRV_SZ   = 1024*1200;
  BOX_SSRV   = MAX_METER+122; BOX_SSRV_SZ   = 1024*1200;
  BOX_SVBF   = MAX_METER+123; BOX_SVBF_SZ   = 1024*10;
  BOX_CSSC   = MAX_METER+124; BOX_CSSC_SZ   = 1024*10;
                             BOX_PUMP_SZ   = 1024*10;
        }

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
  PH_WATCHTMR_IND   = 36;
  PH_COMM_IND       = 37;
  PH_OPEN_PORT_IND  = 38;
  PH_RESET_PORT_IND = 39;
  PH_SET_PULCE_IND  = 40;
  PH_MON_ANS_IND    = 41;
  PH_DIAL_ERR_IND   = 42;
  PH_RECONN_L1_IND  = 43;
  PH_GPRS_ON_IND    = 44;
  PH_GPRS_OF_IND    = 45;
  PH_STOP_IS_GPRS_IND= 46;

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

  DL_SYSCHPREPARE_IND= 30+13;
  DL_STARTCHLOBS_IND = 30+14;
  DL_GOCHLOBS_IND    = 30+15;
  DL_PAUSESNDR_IND   = 30+16;
  DL_GOSNDR_IND      = 30+17;
  DL_LOADOBSERVER_IND           = 30+18;
  DL_LOADOBSERVER_GR_IND        = 30+19;
  DL_LOADOBSERVER_ALLGR_IND     = 30+20;
  DL_ERRTMR1_IND     = 30+21;
  DL_LOADMETER_IND   = 30+22;
  DL_LOAD_EV_METER_IND=30+23;
  DL_AUTO_SEND_TMR    =30+24;
  DL_GSM_SET_TMR      =30+26;
  DL_GSM_FRE_TMR      =30+27;
  DL_GSM_DSC_TMR      =30+28;
  DL_SDL_WPOLL_TMR    =30+29;
  DL_GSM_DEL_SRV_TMR  =30+30;
  DL_EXPORTMYSQL_START  =30+31;
  DL_LOAD_ONE_METER_IND =30+32;
  DL_LDONE_MTR_TMOF_IND =30+33;
  DL_LDONE_MTR_CALC_IND =30+34;
  DL_EXPORTDBF_START    =30+35;
  DL_LOAD_EV_ONE_METER_IND=30+36;
  DL_LIMIT_IND                  = 30+37;
  DL_LOAD_ONE_METER_CTRL_IND=30+38;
  DL_LOADOBSERVER_CTRL_IND  =30+39;
  DL_GSM_CHSP_TMR           =30+40;
  DL_GSM_SCAN_TMR           =30+41;
  DL_GSM_SHOCK_TMR          =30+42;
  DL_GSM_WOPEN_TMR          =30+43;
  DL_EXPORTFMAK_START       =30+44;
  DL_RESTARTTMR_START       =30+45;
  DL_TURNOFFTMR_START       =30+46;
  DL_MONINFO_IND            =30+47;
  DL_INTERNET_CONN_IND      =30+48;
  DL_INTERNET_DISC_IND      =30+49;
  DL_INTERNET_OPEN_REQ      =30+50;
  DL_EXPORT_START_TMR_IND   =30+51;
  DL_INTERNET_CLOSE_REQ     =30+52;
  DL_USR_CNTRL_TMR          =30+53;
  DL_HRD_KEY_CTRL_TMR       =30+54;
  DL_KEYS_TMR               =30+55;
  DL_CMPR_TMR               =30+56;
  DL_LOCK_TMR               =30+57;
  DL_UNLK_TMR               =30+58;
  DL_QSDISC_TMR             =30+57;
  DL_GSM_HOCK_TMR           =30+58;
  DL_DAYS_LOCK_TMR          =30+59;
  DL_START_ROUT_REQ         =30+60;
  DL_STOP_ROUT_REQ          =30+61;
  DL_PORT_OPEN_TMR          =30+62;
  DL_INIT_ROUT_REQ          =30+63;
  DL_GPRS_PRE_DSTM_REQ      =30+64;
  DL_AUTORIZED_TM_REQ       =30+65;
  DL_RESTART_TM_REQ         =30+66;
  DL_GSM_DSC2_TMR           =30+67;
  DL_GSM_PING_TMR           =30+68;
  DL_GSM_REST_TMR           =30+69;
  DL_GSM_PREP_TMR           =30+70;
  DL_GSM_PPRC_TMR           =30+71;
  DL_GSM_DSC3_TMR           =30+72;
  DL_GSM_MATH_TMR           =30+73;
  DL_GSM_CLPR_TMR           =30+74;
  DL_EXPORTDBFVIT_START     =30+75;


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
  QL_POOL_ERR_TMR       = 60+25;
  QL_RCALC_DATA_REQ     = 60+26;
  QL_RBOOT_DATA_REQ     = 60+27;
  QL_SHLGO_DATA_REQ     = 60+28;
  QL_SHLST_DATA_REQ     = 60+29;
  QL_DISCM_METR_REQ     = 60+30;
  QL_CONNM_METR_REQ     = 60+31;
  QL_START_TSTM_REQ     = 60+32;
  QL_STOP_TSTM_REQ      = 60+33;
  QL_OPCLS_RMST_REQ     = 60+34;
  QL_RESCT_RMST_REQ     = 60+35;
  QL_STPRS_RMST_REQ     = 60+36;
  QL_STATS_RECC_REQ     = 60+37;
  QL_START_TST_REQ      = 60+38;
  QL_STOP_TST_REQ       = 60+39;
  QL_SET_REPRT_REQ      = 60+40;
  QL_SHLST_INIT_REQ     = 60+41;
  QL_TMSST_INIT_REQ     = 60+42;
  QL_CONNM_ABON_REQ     = 60+43;

  QL_CVRY_VMTR_REQ      = 60+46;
  QL_CVRY_ABON_REQ      = 60+47;
  QL_DATA_VMTGRAPH_REQ  = 60+48;
  QL_DATA_ABOGRAPH_REQ  = 60+49;
  
  QL_EXPORT_DT_ON_REQ   = 60+50;
  QL_EXPORT_DT_OF_REQ   = 60+51;
  QL_EXPORT_DTINI_REQ   = 60+52;
  QL_INIT_VMET_REQ      = 60+53;
  QL_QRY_PARAM_REQ      = 60+54;
  QL_START_UNLOAD_REQ   = 60+55;
  QL_REM_CONN_REQ       = 60+56;
  QL_START_FH_REQ       = 60+57;
  QL_LOAD_EVENT_ONE_REQ = 60+58;
  QL_RECALC_ABON_REQ    = 60+59;
  QL_RCALC_CPLT_REQ     = 60+60;
  QL_CHANDGE_IP_REQ     = 60+61;
  QL_SAVE_DB_REQ        = 60+62;
  QL_DATA_CTRL_REQ      = 60+63;
  QL_CLOSE_USPD_REQ     = 60+64;
  QL_UPDAT_ARM_REQ      = 60+65;
  QL_RELOAD_USPRO_REQ   = 60+66;
  QL_TURNOFF_REQ        = 60+67;
  QL_REDIRECT_REQ       = 60+68;
  QL_QWERYROUT_REQ      = 60+69;
  QL_QWERYSAVEDB_REQ    = 60+70;

  QL_STOP_TRANS_REQ     = 60+71;
  QL_START_TRANS_REQ    = 60+72;
  QL_CHECK_BASE_CON_REQ = 60+73;

  QL_START_GPRS_REQ     = 60+74;
  QL_STOP_GPRS_REQ      = 60+75;
  QL_INIT_GPRS_REQ      = 60+76;
  QL_INIT_PORT_L2_REQ   = 60+77;
  QL_INIT_TREE_REQ      = 60+78;

  QL_QWERYTREE_REQ      = 60+79;
  QL_QWERYSTATUSBAR_REQ = 60+80;
  QL_QWERYSTATISTICABON_REQ = 60+81;
  QL_QWERYBOXEVENT      = 60+82;
  QL_QWERYBOXEVENTMSG   = 60+83;

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
  AL_RECALC_IND       = 90+24;
  AL_LOADVMET_IND     = 90+25;
  AL_TRANZTIM_IND     = 90+26;
  AL_FINDJOIN_IND     = 90+27;
  AL_SETPULSE_IND     = 90+28;
  AL_SETPIN_IND       = 90+29;
  AL_CHANDGEPIN_IND   = 90+30;
  AL_UPDATESHEM_IND   = 90+31;
  AL_TROPEN_TMR       = 90+32;
  AL_WATCH_TMR        = 90+33;

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
  NL_STARTRCLC_REQ    = 120+30;
  NL_STOPRCLC_REQ     = 120+31;
  NL_L1INITOK_REQ     = 120+32;
  NL_L2INITOK_REQ     = 120+33;
  NL_L3INITOK_REQ     = 120+34;
  NL_L3SDLGO_REQ      = 120+35;
  NL_L3SDLST_REQ      = 120+36;
  NL_L3TTMON_REQ      = 120+37;
  NL_L3TTMOF_REQ      = 120+38;
  NL_L3CTRON_REQ      = 120+39;
  NL_L3CTROF_REQ      = 120+40;
  NL_L3RSCOF_REQ      = 120+41;
  NL_L3RSCON_REQ      = 120+42;
  NL_L3RSSON_REQ      = 120+44;
  NL_L3RMSOF_REQ      = 120+45;
  NL_L3RMSON_REQ      = 120+46;
  NL_START_TST_REQ    = 120+47;
  NL_STOP_TST_REQ     = 120+48;
  NL_REM_INIT_REQ     = 120+49;
  NL_L3ABOON_REQ      = 120+50;
  NL_L3ABOOF_REQ      = 120+51;
  NL_ABOCVRY_REQ      = 120+52;
  NL_VMTCVRY_REQ      = 120+53;

  NL_EXPRTOF_REQ      = 120+54;
  NL_EXPRTON_REQ      = 120+55;
  NL_EXPRTIN_REQ      = 120+56;
  NL_INITVMET_REQ     = 120+57;
  NL_QMETPARM_REQ     = 120+58;
  NL_STRTFIND_REQ     = 120+59;
  NL_GPRS_ON_REQ      = 120+60;
  NL_GPRS_OF_REQ      = 120+61;
  NL_STARTCLEX_REQ    = 120+62;
  NL_SAVEUPD_REQ      = 120+63;

  SL_WTGSM_TMR_REQ    = 0;
  SL_START_TST_REQ    = 1;
  SL_STOP_TST_REQ     = 2;
  SL_SET_REPRT_REQ    = 3;
  SL_FIN_POLL_REQ     = 4;
  SL_UPD_REM_REQ      = 5;
  SL_RES_REM_REQ      = 6;


  //NL_INITL1_REQ       = 120+14;
  //NL_INITL2_REQ       = 120+15;
  //NL_INITL3_REQ       = 120+16;




  //Признаки окончания опроса
  QM_FIN_MTR_IND   = $ff00;
  QM_FIN_CHN_IND   = $ff01;
  QM_FIN_ALL_IND   = $ff02;

  QM_FIN_GPLD_IND  = $ff03;
  QM_FIN_GPLA_IND  = $ff04;

  QM_ENT_MTR_IND   = $ff05;
  QM_ENT_CHN_IND   = $ff06;
  QM_FIN_COM_IND   = $ff07;

  QM_ENT_MON_IND   = $ff08;
  QM_FIN_MON_IND   = $ff09;
  QM_CLC_SRV_IND   = $ff0a;


  //Состояние менеджера опроса
  QM_NULL_STATE    = 0;
  QM_POOL_STATE    = 1;
  QM_WAIT_STOP_STATE = 2;

  //Состояние менеджера уровней
  LME_NULL_STATE = 0;
  LME_POLL_STATE = 1;
  LME_CALC_STATE = 2;
  LME_VIEW_STATE = 3;
  LME_GPLL_STATE = 4;
  LME_PACK_STATE = 5;
  LME_GPLLALL_STATE = 6;

  //События менеджера уровней
  LME_GO_POLL_REQ            = 0;
  LME_STOP_POLL_REQ          = 1;
  LME_STOP_POLC_REQ          = 2;
  LME_FIN_MTR_POLL_REQ       = 3;
  LME_FIN_CHN_POLL_REQ       = 4;
  LME_FIN_MTR_GPLD_REQ       = 5;
  LME_FIN_CHN_GPLA_REQ       = 6;
  LME_GO_GRAPH_POLL_REQ      = 7;
  LME_GO_ALLGRAPH_POLL_REQ   = 8;
  LME_DISC_POLL_REQ          = 9;
  LME_STOP_POLL1_REQ         = 10;
  LME_LOAD_COMPL_IND         = 11;
  LME_LOAD_ONE_COMPL_IND     = 12;
  LME_LOAD_ONEEV_COMPL_IND   = 13;
  LME_LOAD_ONECTRL_COMPL_IND = 14;
  LME_GO_CTRL_POLL_REQ       = 15;

  //События сервера опроса
  QSRV_LOAD_COMPL_REQ         = 0;
  QSRV_CALC_COMPL_REQ         = 1;
  QSRV_ERR_L2_REQ             = 2;
  QSRV_FIND_COMPL_REQ         = 3;

  //События сервера расчета
  CSRV_START_CALC             = 0;
  SSRV_START_SAVE             = 0;
  CSRV_CLEAR_DMTX             = 1;
  CSRV_INIT_JMTX              = 2;


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
  DIR_L3TOSDL    = 60+6;
  DIR_L1TOSL     = 60+7;
  DIR_EKOMTOL1   = 60+8;

  DIR_L3TOLIM    = 60+9;

  DIR_L1TOC12    = 60+10;
  DIR_C12TOC12   = 60+11;
  DIR_C12TOL1    = 60+12;
  DIR_C12TOL3    = 60+13;
  DIR_L3TOC12    = 60+14;

  DIR_ULTOUL     = 60+15;

  DIR_QSTOQS     = 60+16;
  DIR_L2TOQS     = 60+17;
  DIR_CSTOQS     = 60+18;

  DIR_CSTOCS     = 60+19;
  DIR_L2TOCS     = 60+20;
  DIR_QSTOCS     = 60+21;
  DIR_L3TOCS     = 60+22;

  DIR_SSTOSS     = 60+21;
  DIR_CSTOSS     = 60+22;
  DIR_SSTOSB     = 60+23;

  DIR_L1TOL4     = 60+24;

  DIR_QSTOL1     = 60+25;

  DIR_L1TOGPRS   = 60+26;
  DIR_L3TOLME    = 60+27;
  DIR_L1TOTRANSIT= 60+28;
  DIR_TRANSITTOL1= 60+29;

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
  DEV_TCP_GPRS = 6;

  //Типы протоколов
  DEV_NUL      = 0;
  DEV_MASTER   = 1;
  DEV_SLAVE    = 2;
  DEV_BTI_CLI  = 3;
  DEV_BTI_SRV  = 4;
  DEV_SQL      = 5;
  DEV_UDP_CC301= 6;
  DEV_ECOM_SRV  = 7;
  DEV_ECOM_CLI  = 8;
  DEV_C12_SRV   = 9;
  DEV_LOOP_L1   = 10;
  DEV_ECOM_SRV_CRQ = 11;
  DEV_TRANSIT   = 12;
  DEV_K2000B_CLI = 13;


  //Типы счетчиков
  MET_NULL              = 0;
  MET_SS101             = 1;
  MET_SS301F3           = 2;
  MET_EMS134            = 3;
  MET_CE6850            = 4;
  MET_CE6822            = 5;
  MET_SET4TM            = 6;
  MET_EE8005            = 7;
  MET_SUMM              = 8;
  MET_GSUMM             = 9;
  MET_RDKORR            = 10;
  MET_SS301F4           = 11;
  MET_KASKAD            = 12;
  MET_A2000             = 13;
  MET_VZLJOT            = 14;
  MET_C12               = 15;
  MET_C12_SM            = 16;
  MET_EA8086            = 17;
  MET_EKOM3000          = 18;
  MET_SEM2              = 19;
  MET_EPQM              = 20;
  MET_E9CTK1            = 21;
  MET_TEM501            = 22;
  MET_ENTASNET          = 23;
  MET_CEO6005           = 24;
  MET_E9CTK310Q2H4M     = 25;
  MET_CE301BY           = 26;
  MET_USPD16401B        = 27;
  MET_STKVER16          = 28;
  MET_STKVER43          = 29;
  MET_EPQS              = 30;
  MET_STKVER49          = 31;
  MET_CE102             = 32;
  MET_MIRT1             = 33;
  MET_TEM104            = 34;
  MET_CET7007           = 35;
  MET_STKVER51          = 36;
  MET_STKVER18          = 37;
  MET_CE16401M          = 38;
  MET_PULCR             = 39;
  MET_MIRTW2            = 40;
  MET_USPD16401I        = 41;
  MET_USPDSSDU_02       = 42;
  MET_USPDCE16401X      = 43;
  MET_EE8003            = 44;
  MET_EE8004            = 45;
  MET_EE8007            = 46;
  MES_1_5_60            = 47;
  USPDK2000B            = 48;
  MET_USPDSSDU          = 49;
  MET_USPDKUB           = 50;
  MET_A2000by           = 51;
  MET_USPD16401K        = 52;
  MET_CE208BY           = 53;
  MET_USPD16401M_v4     = 54; //УСПД 16401М версии 4.0
  MET_CRCRB             = 55;
  MET_CE303             = 56;
  MET_MES1              = 57;
  MET_MES3              = 58;
  MET_EE8003_4          = 59;
  MET_USPD1500          = 60;
  
  //Расположение счетчика
  MTR_LOCAL   = 0;
  MTR_REMOTE  = 1;
  MTR_REMLOC  = 2;

  CL_SUMM_TR  = 0;
  CL_AVRG_TR  = 1;
  CL_MAXM_TR  = 2;
  CL_NOTG_TR  = 3;
  CL_READ_PR  = 4;

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
  QRY_AUTORIZATION      = 0;//0
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
  QRY_NULL_COMM         = 68;
  QRY_JRNL_T1           = 69;
  QRY_JRNL_T2           = 70;
  QRY_JRNL_T3           = 71;
  QRY_JRNL_T4           = 72;
  QRY_LOAD_ALL_PARAMS   = 73;
  QRY_SUM_KORR_MONTH    = 74;
  QRY_POD_TRYB_HEAT     = 75;   //Расход тепла в подающем трубопроводе (Гкал)
  QRY_POD_TRYB_RASX     = 76;   //Расход воды в подающем трубопроводе  (т)
  QRY_POD_TRYB_TEMP     = 77;   //Температура воды в подающем трубопроводе  (°C)
  QRY_POD_TRYB_V        = 78;   //Расход воды (объем) в подающем водопроводе (м3)
  QRY_OBR_TRYB_HEAT     = 79;   //Расход тепла в обратном трубопроводе (Гкал)
  QRY_OBR_TRYB_RASX     = 80;   //Расход воды в обратном трубопроводе (т)
  QRY_OBR_TRYB_TEMP     = 81;   //Температура воды в обратном трубопроводе (°C)
  QRY_OBR_TRYB_V        = 82;   //Расход воды (объем) в обратном трубопроводе (м3)
  QRY_TEMP_COLD_WAT_DAY = 83;   //Температура холодной воды  (°C)
  QRY_POD_TRYB_RUN_TIME = 84;   //Время наработки в подающем трубопроводе (ч)
  QRY_WORK_TIME_ERR     = 85;   //Время работы c каждой ошибкой (ч)
  QRY_LIM_TIME_KORR     = 86;   //Выход за пределы коррекции
  QRY_ANET_FI           = 87;
  QRY_ANET_CFI          = 88;
  //Внутренние команды
  QRY_ENTER_COM         = 89;
  QRY_EXIT_COM          = 90;
  QRY_TANGENS           = 91;

  QRY_ENERGY_SUM_R1     = 92;
  QRY_ENERGY_SUM_R2     = 93;
  QRY_ENERGY_SUM_R3     = 94;
  QRY_ENERGY_SUM_R4     = 95;

  QRY_ENERGY_DAY_R1     = 96;
  QRY_ENERGY_DAY_R2     = 97;
  QRY_ENERGY_DAY_R3     = 98;
  QRY_ENERGY_DAY_R4     = 99;

  QRY_ENERGY_MON_R1     = 100;
  QRY_ENERGY_MON_R2     = 101;
  QRY_ENERGY_MON_R3     = 102;
  QRY_ENERGY_MON_R4     = 103;

  QRY_SRES_ENR_R1       = 104;
  QRY_SRES_ENR_R2       = 105;
  QRY_SRES_ENR_R3       = 106;
  QRY_SRES_ENR_R4       = 107;

  QRY_NAK_EN_DAY_R1     = 108;
  QRY_NAK_EN_DAY_R2     = 109;
  QRY_NAK_EN_DAY_R3     = 110;
  QRY_NAK_EN_DAY_R4     = 111;

  QRY_NAK_EN_MONTH_R1   = 112;
  QRY_NAK_EN_MONTH_R2   = 113;
  QRY_NAK_EN_MONTH_R3   = 114;
  QRY_NAK_EN_MONTH_R4   = 115;

  QRY_FREE_COMM         = 116;
  QRY_CONTACT_CTR       = 117;

  QRY_NACKM_POD_TRYB_HEAT     = 118;   //Расход тепла в подающем трубопроводе (Гкал)
  QRY_NACKM_POD_TRYB_RASX     = 119;   //Расход воды в подающем трубопроводе  (т)
  QRY_NACKM_POD_TRYB_TEMP     = 120;   //Температура воды в подающем трубопроводе  (°C)
  QRY_NACKM_POD_TRYB_V        = 121;   //Расход воды (объем) в подающем водопроводе (м3)
  QRY_NACKM_OBR_TRYB_HEAT     = 122;   //Расход тепла в обратном трубопроводе (Гкал)
  QRY_NACKM_OBR_TRYB_RASX     = 123;   //Расход воды в обратном трубопроводе (т)
  QRY_NACKM_OBR_TRYB_TEMP     = 124;   //Температура воды в обратном трубопроводе (°C)
  QRY_NACKM_OBR_TRYB_V        = 125;   //Расход воды (объем) в обратном трубопроводе (м3)
  QRY_NACKM_TEMP_COLD_WAT_DAY = 126;   //Температура холодной воды  (°C)
  QRY_NACKM_POD_TRYB_RUN_TIME = 127;   //Время наработки в подающем трубопроводе (ч)
  QRY_NACKM_WORK_TIME_ERR     = 128;   //Время работы c каждой ошибкой (ч)
  //Для одного канала счетчиков Пульсар
  QRY_SUM_RASH_V              = 129;   //Расход общий (м3)
  QRY_RASH_HOR_V              = 130;   //Расход в час (м3)
  QRY_RASH_DAY_V              = 131;   //Расход в сутки (м3)
  QRY_RASH_MON_V              = 132;   //Расход в месяц (м3)
  QRY_RASH_AVE_V              = 133;   //Расход средний (м3/ч)
  //!!!!!
  QRY_END                     = 134;
  QRY_TRANSIT                 = 135;
  QRY_CLOSE_TRANSIT           = 136;
  QRY_POINT_POS               = 137;

{
Расход тепла в подающем трубопроводе
Расход воды в подающем трубопроводе
Температура воды в подающем трубопроводе
Расход воды (объем) в подающем водопроводе
Расход тепла в обратном трубопроводе
Расход воды в обратном трубопроводе
Температура воды в обратном трубопроводе
Расход воды (объем) в обратном трубопроводе
Температура холодной воды
Время наработки в подающем трубопроводе
Время работы с каждой ошибкой
}
  // УПРАВЛЕНИЕ
  QRY_RELAY_CTRL        = 92;  // Команды управления контактором
  QRY_SETDT_CTRL        = 93;  // Коррекция даты/времени
  QRY_TRANSIT_CTRL      = 94;

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
  SV_DEFT_ST = -1;
  SV_CURR_ST = 0;
  SV_ARCH_ST = 1;
  SV_GRPH_ST = 2;
  SV_PDPH_ST = 3;

  //Лимиты
  LM_MIN = 0;
  LM_NRM = 1;
  LM_MAX = 2;

  //Признак обновления
  DT_OLD = 1;
  DT_NEW = 2;
  DT_FLS = 4;
  DT_EXT = 5;
  DT_CLC = 6;
  DT_FRE = 7;
  DT_HNW = 8;

  //Состояния уровня L1
  ST_DISC_L1      = 0;
  ST_WAIT_CONN_L1 = 1;
  ST_CONN_L1      = 2;

  //Типы дней
  SZN_WORK_DAY    = 0;
  SZN_SATR_DAY    = 1;
  SZN_HOLY_DAY    = 2;
  SZN_WRST_DAY    = 3;

  //Типы тестов
  TST_VER_NO        = 0;
  TST_AM_PH_CHANNEL = 1;
  TST_ST_PH_CHANNEL = 2;
  TST_AM_MODEM      = 3;
  TST_ST_MODEM      = 4;
  TST_AM_METERS     = 5;
  TST_ST_METERS     = 6;
  TST_AM_ARM        = 7;
  TST_ST_ARM        = 8;
  TST_TIME_ROUT     = 9;
  TST_TRANS_ERROR   = 10;
  TST_FATAL_ERROR   = 11;
  TST_END           = 12;
  //Типы редакторов
  EDT_MN_L1TAG      = 0;
  EDT_MN_L2TAG      = 1;
  const chDays : array[1..7] of String = (
    'вс',
    'пн',
    'вт',
    'ср',
    'чт',
    'пт',
    'сб');
  const chMonth : array[1..12] Of String = (
    'Ян',
    'Фв',
    'Мр',
    'Ап',
    'Май',
    'Ин',
    'Ил',
    'Ав',
    'Сн',
    'Ок',
    'Нб',
    'Дк');
  const chEndTn : array[0..7] of String = (
    ' ',
    ',',
    '+',
    '-',
    '/',
    '*',
    ')',
    ';');
  const chLmeState : array[0..5] of String = (
  'LME_NULL_STATE',
  'LME_POLL_STATE',
  'LME_CALC_STATE',
  'LME_VIEW_STATE',
  'LME_GPLL_STATE',
  'LME_CTRL_STATE');

  const chBTISate : array [0..11]  of String = (
  'ST_NULL_BTI',
  'ST_WAIT_ASK_USPD_TYPE_BTI',
  'ST_USPD_TYPE_BTI',
  'ST_WAIT_ASK_USPD_DEV_BTI',
  'ST_USPD_DEV_BTI',
  'ST_WAIT_ASK_USPD_CHARDEV_BTI',
  'ST_CHARDEV_BTI',
  'ST_WAIT_ASK_USPD_CHARKAN_BTI',
  'ST_CHARKAN_BTI',
  'ST_WAIT_ASK_USPD_CHARGR_BTI',
  'ST_USPD_CHARGR_BTI',
  'ST_READY_BTI'
  );

    
  const chFHState : array[0..16] of String = (
   'ST_NULL_FH',
   'ST_START_FE_S',
   'ST_START_FE_D_PR',
   'ST_START_FE_D_NAK',
   'ST_START_FE_M_PR',
   'ST_START_FE_M_NAK',
   'ST_START_FH_S',
   'ST_START_FH_D_PR',
   'ST_START_FH_D_NAK',
   'ST_START_FH_M_PR',
   'ST_START_FH_M_NAK',
   'ST_START_FA_S',
   'ST_START_FA_D_PR',
   'ST_START_FA_D_NAK',
   'ST_START_FA_M_PR',
   'ST_START_FA_M_NAK',
   'ST_END_SERCH_FH'
  );
  const chSLTState : array[0..5] of String = (
   'ST_SLFT_STAT_NULL',
   'ST_SLFT_OPEN_CHAN',
   'ST_SLFT_OPEN_MODM',
   'ST_SLFT_CONN_METR',
   'ST_SLFT_CONN_USPD',
   'ST_SLFT_CONN_ARMT'
  );


 { ST_CONF_NULL                 = 0;
  ST_CONF_BTI_CONN             = 1;
  ST_CONF_CHECK_PASSW          = 2;
  ST_CONF_UPD_PHADDR           = 3;
  ST_CONF_UPD_PORTCONF         = 4;
  ST_CONF_UPD_KI               = 5;
  ST_CONF_UPD_KU               = 6;
  ST_CONF_UPD_PASSW            = 7;
  ST_CONF_UPD_ADVPASSW         = 8;
  ST_CONF_UPD_TARIFF           = 9;
  ST_CONF_UPD_CALENDAR         = 10;
  ST_CONF_UPD_NEW_SUMSEASON    = 11;
  ST_CONF_UPD_NEW_WINSEASON    = 12;
  ST_CONF_READ_PORTCONF        = 13;
  ST_CONF_READ_KI              = 14;
  ST_CONF_READ_KU              = 15;
  ST_CONF_READ_TARIFF          = 16;
  ST_CONF_READ_CALENDAR        = 17;
  ST_CONF_READ_SUMSEASON       = 18;
  ST_CONF_READ_WINSEASON       = 19;
  ST_CONF_FINISH               = 20;   }

  const chConfState : array[0..24] of String = (
    'Нулевое состояние',
    'Удаленное подключение к УСПД',
    'Проверка пароля',
    'Запись времени в счетчик',
    'Запись физического адреса',
    'Запись конфигурации порта',
    'Запись коэффициента KI',
    'Запись коэффициента KU',
    'Запись основного пароля',
    'Запись дополнительного пароля',
    'Запись тарифного расписания',
    'Запись календаря',
    'Запись времени перехода на летнее время',
    'Запись времени перехода на зимнее время',
    'Чтение конфигурации порта',
    'Чтение коэффициента KI',
    'Чтение коэффициента KU',
    'Чтение тарифного расписания',
    'Чтение календаря',
    'Чтение времени перехода на летнее время',
    'Чтение времени перехода на зимнее время',
    'Подключение к удаленному устройству',
    'Отключение от удаленного устройства',
    'Чтение даты времени',
    'Окончание выполнения операции'
  );

  const chConfError : array[0..6] of String = (
    'Неверный пароль',
    'Ошибка в задании основного пароля',
    'Ошибка в задании дополнительного пароля',
    'Ошибка в задании физического адреса',
    'Ошибка в задании параметров порта',
    'Канал связи не поддерживает GSM связь',
    'Ошибка загрузки тарифного расписания из файла'
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
Const
// фиксация событий УСПД
  EVH_PROG_RESTART             = 0;     // Программный перезапуск                               1
  EVH_REST_WDT                 = 1;     // (срабатывание WatchDog-таймера)                      1
  EVH_FIRST_START              = 2;     // Первичный запуск                                     1
  EVH_ENTER_PASSWORD           = 3;     // Ввод пароля и переход в режим перепрограммирования   1
  EVH_MOD_TARIFF               = 4;     // Изменение тарифного расписания                       1
  EVH_MOD_SPEED                = 5;     // Изменение скорости обмена                            1
  EVH_MOD_ADRES_USPD           = 6;     // Изменение сетевого адреса УСПД                       1
  EVH_MOD_PASSWORD             = 7;     // Изменение пароля                                     1
  EVH_DEL_BASE                 = 8;     // Удаление накопленной базы данных                     1
  EVH_START_REPROGRAMM         = 9;     // Запуск после перепрограммирования                    1
  EVH_POW_OF                   = 10;    // Выключение УСПД                                      1
  EVH_POW_ON                   = 11;    // Включение УСПД                                       1
  EVH_STEST_PS                 = 14;    // Самодиагностика УСПД прошла успешно                  1
  EVH_STEST_FL                 = 15;    // Самодиагностика УСПД прошла неудачно                 1
  EVH_COR_TIME_KYEBD           = 19;    // Коррекция времени УСПД с клавиатуры                  1
  EVH_COR_TIME_DEVICE          = 20;    // Коррекция времени УСПД по запросу от внешнего устр   1
  EVH_COR_TIME_AUTO            = 21;    // Автоматическая коррекция времени по часам точного    1
  EVH_CORR_MONTH               = 22;    // Суммарная коррекция времени за месяц                 1
  EVH_CORR_BEG                 = 23;    // Начало коррекции времени УСПД                        1
  EVH_CORR_END                 = 24;    // Окончание коррекции времени УСПД                     1
  EVH_MOD_DATA                 = 25;    // Несанкционированное изменение данных                 1
  EVH_INCL_METER               = 26;    // Включение счетчика                                   1
  EVH_EXCL_METER               = 27;    // Отключение счетчика                                  1
  EVH_RESTART_PO               = 28;    // Перезагрузка ПО
  EVH_ABS_DATA_MET             = 29;    // Осутствие данных от электронного счетчика
  EVH_REST_DATA_MET            = 30;    // Восстановление данных от электронного счетчика
  EVH_ARM_EXIT                 = 31;    // Выход из ПО
  EVH_MISS_MET_DATA            = 32;    // Отсутствуют данные от электронного счетчика
  EVH_RECOV_MET_DATA           = 33;    // Отсутствующие данные восстановлены
  EVH_AUTO_GO_TIME             = 34;    // Автоматический переход на зимнее/летнее время
  EVH_START_CORR               = 35;    // Начало коррекции
  EVH_FINISH_CORR              = 36;    // Окончание коррекции
  EVH_CONNARM_START            = 37;    // Подключение АРМ
  EVH_OPN_COVER                = 38;    // Открытие крышки УСПД
  EVH_CLS_COVER                = 39;    // Закрытие крышки УСПД
  EVH_OPN_SES_ECOM3            = 40;    // Открыта сессия свзяи с ЭКОМ - 3000
  EVH_CLS_SES_ECOM3            = 41;    // Закрыта сессия связи с ЭКОМ - 3000


//Журнал №4
  EVS_SBPARAM_ED_ON            = 0;     // Переход в режим редакт. шаблона параметров           4
  EVS_SBPARAM_ED_OF            = 1;     // Выход из режима редакт. шаблона параметров           4
  EVS_TPMETER_ED_ON            = 2;     // Переход в режим редакт. типов счетчиков              4
  EVS_TPMETER_ED_OF            = 3;     // Выход из режима редакт. типов счетчиков              4
  EVS_SBSCEN_ED_ON             = 4;     // Переход в режим редакт. шаблона сценария             4
  EVS_SBSCEN_ED_OF             = 5;     // Выход из режима редакт. шаблона сценария             4
  EVS_PHCHANN_ED_ON            = 6;     // Переход в режим редакт. физ.каналов                  4
  EVS_PHCHANN_ED_OF            = 7;     // Выход из режима редакт. физ.каналов                  4
  EVS_PHMETER_ED_ON            = 8;     // Переход в режим редакт. физ.счетчиков                4
  EVS_PHMETER_ED_OF            = 9;     // Выход из режима редакт. физ.счетчиков                4
  EVS_PHSCEN_ED_ON             = 10;    // Переход в режим редакт. сценария запросов            4
  EVS_PHSCEN_ED_OF             = 11;    // Выход из режима редакт. сценария запросов            4
  EVS_GROUP_ED_ON              = 12;    // Переход в режим редакт. групп                        4
  EVS_GROUP_ED_OF              = 13;    // Выход из режима редакт. групп                        4
  EVS_POINT_ED_ON              = 14;    // Переход в режим редакт. точек учета                  4
  EVS_POINT_ED_OF              = 15;    // Выход из режима редакт. точек учета                  4
  EVS_PARAM_ED_ON              = 16;    // Переход в режим редакт. параметров                   4
  EVS_PARAM_ED_OF              = 17;    // Выход из режима редакт. параметров                   4
  EVS_SYZONE_ED_ON             = 18;    // Переход в режим редакт. сезонов                      4
  EVS_SYZONE_ED_OF             = 19;    // Выход из режима редакт. сезонов                      4
  EVS_TPLANE_ED_ON             = 20;    // Переход в режим редакт. тарифных планов              4
  EVS_TPLANE_ED_OF             = 21;    // Выход из режима редакт. тарифных планов              4
  EVS_OPZONE_ED_ON             = 22;    // Переход в режим редакт. описателей зон               4
  EVS_OPZONE_ED_OF             = 23;    // Выход из режима редакт. описателей зон               4
  EVS_TZONE_ED_ON              = 24;    // Переход в режим редакт. тарифных зон                 4
  EVS_TZONE_ED_OF              = 25;    // Выход из режима редакт. тарифных зон                 4
  EVS_TTIME_ED_ON              = 26;    // Переход в режим редакт. перевода времени             4
  EVS_TTIME_ED_OF              = 27;    // Выход из режима редакт. перевода времени             4
  EVS_TSHEDL_ED_ON             = 28;    // Переход в режим редакт. планировщика                 4
  EVS_TSHEDL_ED_OF             = 29;    // Выход из режима редакт. планировщика                 4
  EVS_SZTDAY_ED_ON             = 30;    // Переход в режим редакт. типов дней                   4
  EVS_SZTDAY_ED_OF             = 31;    // Выход из режима редакт. типов дней                   4
  EVS_STSTART                  = 32;    // Начало самодиагностики УСПД                          4
  EVS_STSTOP                   = 33;    // Окончание самодиагностики УСПД                       4
  EVS_CONN_BASE                = 34;    // Подключение к базе                                   4
  EVS_OPEN_CONF                = 35;    // Вход в конфигуратор                                  4
  EVS_CLOS_CONF                = 36;    // Выход из конфигуратора                               4
  EVS_STOP_USPD                = 37;    // Останов УСПД                                         4
  EVS_STRT_USPD                = 38;    // Запуск УСПД                                          4
  EVS_STRT_ARCH                = 39;    // Запуск опроса архивов                                4
  EVS_DEL_AR_PER               = 40;    // Удаление архива за период                            4
  EVS_ALL_DEL_AR_PER           = 41;    // Удаление всего архива за период                      4
  EVS_ALL_DEL_AR               = 42;    // Удаление всего архива                                4
  EVS_DEL_ACCT                 = 43;    // Удаление уч.зап.пользователя                         4
  EVS_CRT_ACCT                 = 44;    // Создание уч.зап.пользователя                         4
  EVS_EDI_ACCT                 = 45;    // Редактирование уч.зап.пользователя                   4
  EVS_OPEN_INIT                = 46;    // Открытие настроек УСПД                               4
  EVS_CLOS_INIT                = 47;    // Закрытие настроек УСПД                               4
  EVS_STRT_ARCH_BASE           = 48;    // Запуск архивирования                                 4
  EVS_OPEN_STAT                = 49;    // Открытие статистики приемопередачи                   4
  EVS_CLOS_STAT                = 50;    // Закрытие статистики приемопередачи                   4
  EVS_STOP_TRAN                = 51;    // Останов операции                                     4
  EVS_OPEN_EACC                = 52;    // Вход в ред.пользователей                             4
  EVS_CLOS_EACC                = 53;    // Выход из ред.пользователей                           4
  EVS_STRT_SHDL                = 54;    // Запуск планировщика                                  4
  EVS_STOP_SHDL                = 55;    // Останов планировщика                                 4
  EVS_STRT_TRTM                = 56;    // Запуск м.превода времени                             4
  EVS_STOP_TRTM                = 57;    // Останов м.превода времени                            4
  EVS_CLER_STDT                = 58;    // Обнуление стат.приемопередачи                        4
  EVS_CLER_STTM                = 59;    // Обнуление времени приемопередачи                     4
  EVS_STRT_STAT                = 60;    // Останов м.статистики приемопередачи                  4
  EVS_STOP_STAT                = 61;    // Запуск м.статистики приемопередачи                   4
  EVS_STRT_RSTAT               = 62;    // Включение удаленной статистики                       4
  EVS_STOP_RSTAT               = 63;    // Отключение удаленной статистики                      4
  EVS_INIT_PHCH                = 64;    // Инициализация физ.каналов                            4
  EVS_INIT_MERT                = 65;    // Инициализация физ.счетчиков                          4
  EVS_INIT_VMET                = 66;    // Инициализация точек учета                            4
  EVS_AUTORIZ                  = 67;    // Авторизация                                          4
  EVS_END_AUTORIZ              = 68;    // Окончание авторизации                                4
  EVS_SUM_KORR                 = 69;    // Cуммарное время коррекции                            4
  EVS_ABON_ED_ON               = 70;    // Переход в режим редакт. абонентов                    4
  EVS_ABON_ED_OF               = 71;    // Выход из режима редакт. абонентов                    4
  EVS_INCL_ABON                = 72;    // Подключение абонента                                 4
  EVS_EXCL_ABON                = 73;    // Отключение абонента                                  4
  EVS_CVRY_VMTR                = 74;    // Опрашивание точки учета                              4
  EVS_CVRY_ABON                = 75;    // Опрашивание абонента                                 4
  EVS_EXPRT_OF                 = 76;    // Отключение экспорта                                  4
  EVS_EXPRT_ON                 = 77;    // Включение экспорта                                   4
  EVS_EXPRT_INIT               = 78;    // Иициализация экспорта                                4
  EVS_CHANDR_ED_ON             = 79;    // Переход в режим редакт. замены счетчика              4
  EVS_CHANDR_ED_OF             = 80;    // Выход из режима редакт. замены счетчика              4
  EVS_DEL_EVENT_JRNL           = 81;    // Сброс журнала событий                                4
  EVS_CHNG_OPZONE              = 82;    // Изменение тарифного расписания
  EVS_CHNG_SBPARAM             = 83;    // Изменение шаблона параметров
  EVS_CHNG_TPMETER             = 84;    // Изменение типов счетчиков
  EVS_CHNG_PHCHANN             = 85;    // Изменение параметров физических каналов
  EVS_CHNG_PHMETER             = 86;    // Изменение параметров физических счетчиков
  EVS_CHNG_PARAM_ED            = 87;    // Изменение в сценарии запросов
  EVS_CHNG_GROUP               = 88;    // Изменение групп
  EVS_CHNG_POINT               = 89;    // Изменение точек учета
  EVS_CHNG_PARAM               = 90;    // Изменение параметров
  EVS_CHNG_T_ZONE              = 91;    // Изменение тарифных зон
  EVS_CHNG_TPLANE              = 92;    // Изменение тарифного плана
  EVS_CHNG_SYZONE              = 93;    // Изменение сезонов
  EVS_CHNG_SZTDAY              = 94;    // Изменение типов дней


  /////////////фиксация событий счетчика(Журнал №3)
  EVM_ERR_REAL_CLOCK           = 0;     // Сбой часов реального времени
  EVM_ERR_KAL                  = 1;     // Поврежден файл калибровок
  EVM_ERR_RAM                  = 2;     // Неисправно ПЗУ или ОЗУ
  EVM_ERR_FLASH                = 3;     // Неисправно Flash-память данных
  EVM_CHG_SPEED                = 4;     // Изменение скорости обмена по интерфейсу
  EVM_CHG_CONST                = 5;     // Изменение констант ( сетевого адреса, Ki, Ku и т.д.)
  EVM_CHG_PASSW                = 6;     // Изменение пароля доступа
  EVM_RES_SLICE                = 7;     // Обнуление накопленной базы данных срезов
  EVM_OFF_POWER                = 8;     // Выключение питания счетчика
  EVM_ON_POWER                 = 9;     // Включение питания счетчика
  EVM_OPN_COVER                = 10;    // Открытие крышки счетчика
  EVM_CLS_COVER                = 11;    // Закрытие крышки счетчика
  EVM_INST_COVER               = 12;    // Клеммная крышка УСПД установлена
  EVM_CORR_BUTN                = 13;    // Коррекция времени счетчика с кнопок
  EVM_CORR_INTER               = 14;    // Коррекция времени счетчика по интерфейсу
  EVM_CHG_TARIFF               = 15;    // Изменение тарифного расписания
  EVM_CHG_FREEDAY              = 16;    // Изменение списка выходных дней
  EVM_NOIZE                    = 17;    // Помехи в сети
  EVM_ERR_DSP                  = 18;    // Ошибка DSP
  EVM_CHG_DT_SEAS              = 19;    // Изменение даты переключения сезонов
  EVM_CHG_PAR_TELEM            = 20;    // Изменение параметров телеметрии
  EVM_CHG_MODE_IZM             = 21;    // Изменение режима измерения
  EVM_RES_ENERG                = 22;    // Обнуление энергии
  EVM_RES_MAX_POW              = 23;    // Обнуление максимально мощности
  EVM_OFF_METER                = 24;    // Отключение счетчика
  EVM_ON_METER                 = 25;    // Включение счетчика
  EVM_EXCL_PH_A                = 26;    // Пропадание фазы А
  EVM_INCL_PH_A                = 27;    // Востановление фазы А
  EVM_EXCL_PH_B                = 28;    // Пропадание фазы B
  EVM_INCL_PH_B                = 29;    // Востановление фазы B
  EVM_EXCL_PH_C                = 30;    // Пропадание фазы C
  EVM_INCL_PH_C                = 31;    // Востановление фазы C
  EVM_LSTEP_UP                 = 32;    // Выход за верхний предел лимита
  EVM_LSTEP_DOWN               = 33;    // Выход за нижний предел лимита
  EVM_L_NORMAL                 = 34;    // Возврат в нормальное состояние
  EVM_ERR_KORR                 = 35;    // Выход за пределы коррекции
  EVM_START_CORR               = 36;    // Начало коррекции
  EVM_FINISH_CORR              = 37;    // Окончание коррекции
  EVM_ERROR_CORR               = 38;    // Ошибка коррекции

  //Журнал №2
  EVA_METER_NO_ANSWER          = 0;     // Счетчик не ответил на запрос (автоблокировка)
  EVA_METER_ANSWER             = 1;     // Счетчик вышел из состояния автоблокировки
  EVA_ERROR_CRC                = 2;     // Ошибка контрольной суммы в ответе счетчика

  //Типы Узлов
{
  SV_CURR_ST = 0;
  SV_ARCH_ST = 1;
  SV_GRPH_ST = 2;
  SV_PDPH_ST = 3;
}
//Примитивы данных для каждого абонента
  PD_CURRT                     = 0;
  PD_ARCHV                     = 1;
  PD_GRAPH                     = 2;
  PD_PERIO                     = 3;
  PD_RPRTS                     = 4;
  PD_EVENS                     = 5;
  PD_LIMIT                     = 6;
  PD_VMETR                     = 7;
  PD_CHNDG                     = 8;
  PD_VECDG                     = 9;
  PD_CTRLF                     = 10;
  PD_MONIT                     = 11;
  PD_QWERY                     = 12;
  PD_CLUST                     = 13;
  PD_SCHEM                     = 14;
  PD_UNKNW                     = $ffff;
//Тип структуры
  SD_ABONT                     = 0;    //Абонент
  SD_PRIMT                     = 1;
  SD_GROUP                     = 2;    //Группа ?
  SD_VMETR                     = 3;
  SD_VPARM                     = 4;
  SD_REPRT                     = 5;    //Отчеты
  SD_EVENS                     = 6;
  SD_LIMIT                     = 7;    //Лимиты
  SD_REGIN                     = 8;    //Регион
  SD_CLUST                     = 9;
  SD_RAYON                     = 10;   //Район
  SD_TOWNS                     = 11;   //Город
  SD_STRET                     = 12;   //Улица
  SD_QGRUP                     = 13;   //Группа опроса
  SD_QGLIN                     = 21;   //Группы опроса (по каждому значению)
  SD_QGSRV                     = 14;   //Группы опроса (папка)
  SD_QGSOS                     = 15;
  SD_QGPAR                     = 16;
  SD_QGCOM                     = 17;
  SD_TPODS                     = 18;   //ТП
  SD_APART                     = 19;   //квартиры
  SD_APNUM                     = 20;   //Собственно сами квартиры по номерам
  SD_RRP01                     = 21;   //Отчеты (Мощность)
  SD_RRP02                     = 22;   //Отчеты (Энергия)
  SD_RRP03                     = 23;   //Отчеты (Показания)
  SD_RRP04                     = 24;   //Отчеты (Диагностические)
  SD_RRP05                     = 25;   //Отчеты (Учет тепла)
  SD_RRP06                     = 26;   //Отчеты (Стоимость)
  SD_RRP07                     = 27;   //Отчеты (Настройки)
  SD_RRP08                     = 28;   //Отчеты (резерв)
  SD_RRP09                     = 29;   //Отчеты (резерв)
  SD_EVNTA                     = 30;   //События по дому
  SD_ARCHV                     = 32;   //Архивы
  SD_GRAPH                     = 33;   //Графики
  SD_PERIO                     = 35;   //Периодические
  SD_CURRT                     = 36;   //Текущие
  SD_VECDG                     = 37;   //Векторная диаграмма
  SD_CHNDG                     = 38;   //Замены
  SD_EVNTH                     = 39;   //События по квартире
  SD_QRYGR                     = 50;   //Группа опроса - наименование группы
  SD_QRYTP                     = 51;   //Группа опроса - тип параметра (задачи)
  SD_QRYQO                     = 52;   //Группа опроса - объекты опроса
  SD_QRY01                     = 55;   //Группа опроса - позиция 01
  SD_QRY02                     = 56;   //Группа опроса - позиция 02
  SD_QRY03                     = 57;   //Группа опроса - позиция 03
  SD_QRY04                     = 58;   //Группа опроса - позиция 04
  SD_QRY05                     = 59;   //Группа опроса - позиция 05
  SD_QRY06                     = 60;   //Группа опроса - позиция 06
  SD_QRY07                     = 61;   //Группа опроса - позиция 07
  SD_QRY08                     = 62;   //Группа опроса - позиция 08
  SD_QRY09                     = 63;   //Группа опроса - позиция 09
  SD_QRY10                     = 64;   //Группа опроса - позиция 10


  // редактор TreeView
  ETV_ADDRESS                  = 01;   // Редактирование адреса

//Состояние абонента/счетчика
  SA_LOCK                      = 00;
  SA_UNLK                      = 01;
  SA_ALOK                      = 02;
  SA_CVRY                      = 03;
  SA_ALRM                      = 04;
  SA_REDY                      = 05;
  SA_HDUC                      = 06;
//Состояние блокировки параметра
  PR_FAIL                      = 00;
  PR_TRUE                      = 01;
  PR_HAND_LOCK                 = 02;
//Признак сортировки
  SRT_REGI                     = $00000001;
  SRT_ABON                     = $00000002;
  SRT_GRUP                     = $00000004;
  SRT_TUCH                     = $00000008;
  SRT_PARM                     = $00000010;
//Признак команды поиска
  QFH_ARCH_EN                  = $0000000000000001;
  QFH_ENERGY_DAY_EP            = $0000000000000002;
  QFH_ENERGY_MON_EP            = $0000000000000004;
  QFH_SRES_ENR_EP              = $0000000000000008;
  QFH_NAK_EN_DAY_EP            = $0000000000000010;
  QFH_NAK_EN_MONTH_EP          = $0000000000000020;

  QFH_CURR                     = $0000000000000040;
  QFH_CURR_SUMM                = $0000000000000080;
  QFH_CURR_MAP                 = $0000000000000100;
  QFH_CURR_MRP                 = $0000000000000200;
  QFH_CURR_U                   = $0000000000000400;
  QFH_CURR_I                   = $0000000000000800;
  QFH_CURR_F                   = $0000000000001000;
  QFH_CURR_CFI                 = $0000000000002000;
  QFH_CORR_TIME                = $0000000000004000;

  QFH_POD_TRYB_HEAT            = $0000000000008000;

  QFH_JUR_EN                   = $0000000000010000;
  QFH_JUR_0                    = $0000000000020000;
  QFH_JUR_1                    = $0000000000040000;
  QFH_JUR_2                    = $0000000000080000;
  QFH_JUR_3                    = $0000000000100000;

  QFH_ANET_EN                  = $0000000000200000;
  QFH_ANET_U                   = $0000000000400000;
  QFH_ANET_I                   = $0000000000800000;
  QFH_ANET_FI                  = $0000000001000000;
  QFH_ANET_CFI                 = $0000000002000000;
  QFH_ANET_F                   = $0000000004000000;
  QFH_ANET_P                   = $0000000008000000;
  QFH_ANET_Q                   = $0000000010000000;
  QFH_AMNET_EN                 = $0000000020000000;
  QFH_NACKM_POD_TRYB_HEAT      = $0000000040000000;


  QFH_RECALC_ABOID             = $0800000000000000;
  QFH_FIND_UPDATE              = $1000000000000000;


//////////////them
//Состояния СЭМ-а
  ST_SM2_NULL_ST               = 0;       //Нулевое состояние сумматора
  ST_SM2_CHNG_VIRT_ADR         = 1;       //Состояние запроса перехода на новый вирт адрес
  ST_SM2_CHNG_VIRT_ADR_REQ     = 2;       //Состояние ожидание ответа от сумматора
  ST_SM2_CHNG_D_READ           = 3;       //Состояние запроса переход на новую глубину чтения инфы
  ST_SM2_CHNG_D_READ_REQ       = 4;       //Чтение запроса перехода на глубину
  ST_SM2_CREATE_PAR_REQ        = 5;       //Запрос на чтение параметра
  ST_SM2_READ_PARAM            = 6;       //Чтение пришедших параметров

//Маски дней недели
  DYM_ENABLE                   = $00000001;
  DYM_VOS                      = $00000002;
  DYM_PON                      = $00000004;
  DYM_BTO                      = $00000008;
  DYM_SRD                      = $00000010;
  DYM_CHT                      = $00000020;
  DYM_PTN                      = $00000040;
  DYM_SUB                      = $00000080;
//Маски дней месяца
  MTM_ENABLE                   = $00000001;
  MTM_01                       = $00000002;
  MTM_02                       = $00000004;
  MTM_03                       = $00000008;
  MTM_04                       = $00000010;
  MTM_05                       = $00000020;
  MTM_06                       = $00000040;
  MTM_07                       = $00000080;
  MTM_08                       = $00000100;
  MTM_09                       = $00000200;
  MTM_10                       = $00000400;
  MTM_11                       = $00000800;
  MTM_12                       = $00001000;
  MTM_13                       = $00002000;
  MTM_14                       = $00004000;
  MTM_15                       = $00008000;
  MTM_16                       = $00010000;
  MTM_17                       = $00020000;
  MTM_18                       = $00040000;
  MTM_19                       = $00080000;
  MTM_20                       = $00100000;
  MTM_21                       = $00200000;
  MTM_22                       = $00400000;
  MTM_23                       = $00800000;
  MTM_24                       = $01000000;
  MTM_25                       = $02000000;
  MTM_26                       = $04000000;
  MTM_27                       = $08000000;
  MTM_28                       = $10000000;
  MTM_29                       = $20000000;
  MTM_30                       = $40000000;
  MTM_31                       = $80000000;

  //Тип Опроса
  QWR_EQL_TIME                 = 0;
  QWR_QWERY_SHED               = 1;
  QWR_FIND_SHED                = 2;
  QWR_QWERY_SRV                = 3;

  //Состояние Разгрузчика
  UNL_WAIT_CONN_STATE          = 0;
  UNL_DISC_STATE               = 1;
  UNL_WAIT_DISC_STATE          = 2;
  UNL_CONN_STATE               = 3;
  UNL_CONN_PAUSE_STATE         = 4;
  UNL_CONN_UNLOD_STATE         = 5;
  //Сообщения разгрузчика
  UNL_DIAL_TM                  = 0;
  UNL_REP_TM                   = 1;
  UNL_GET_MSG                  = 2;
  UNL_DATA                     = 3;
  UNL_SEND_ACK                 = 4;
  UNL_DISC                     = 5;
  UNL_REM_DATA                 = 6;
  UNL_DIAL_CONN                = 7;
  UNL_DIAL_DISC                = 8;
  UNL_CLER                     = 9;

  //Состояние блокировок 2-го уровня
  ST_L2_NO_BLOCK               = 0;     // Нет никаких блокировок
  ST_L2_NO_HAND_BLOCK          = 1;     // Счетчик вышел из ручной блокировки
  ST_L2_HAND_BLOCK             = 2;     // Ручная блокировка
  ST_L2_NO_AUTO_BLOCK          = 4;     // Счетчик вышел из автоблокировки
  ST_L2_AUTO_BLOCK             = 8;     // Счетчик автозаблокировался (Нет ответа)

  PH_MAX_PIN                   = $32; 
  PH_BASE_ADDR_SET_PORT        = $98;
  PH_BASE_ADDR_PIN_PORT        = $78;
  PH_DIRECT_PIN                = 0;
  PH_INVERT_PIN                = 1;
  PH_0_TO_1_EV                 = 0;
  PH_1_TO_0_EV                 = 1;
  PH_X_TO_X_EV                 = 2;
  PH_NULL_EV                   = 3;
  PIN_STATE_ONN                = 0;
  PIN_STATE_OFF                = 1;
  PIN_STATE_TRI                = 2;
  PIN_INPUT                    = 0;
  PIN_OUTPT                    = 1;

  PH_MAX_MON                   = 100;
  //Команды управления сервером опроса

  QS_HQWR_SR  = 0;
  QS_FIND_SR  = 1;
  QS_UPDT_SR  = 2;
  QS_STOP_SR  = 3;
  QS_INIT_SR  = 4;
  QS_ERL2_SR  = 5;
  QS_FIND_AP  = 6;
  QS_CLER_BL  = 7;
  QS_FIND_AL  = 8;
  QS_UPDT_AL  = 9;
  QS_FREE_AL  = 10;
  QS_STP1_SR  = 11;
  QS_UNLD_SR  = 12;
  QS_INIT_GS  = 13;
  QS_LOAD_ON  = 14;
  QS_TRAN_ON  = 15;
  QS_RESTART_ERROR  = 16;//перезапуск программы и авточнеие после ошибки

  AL_NO_ERR   = 0;
  AL_ER_DIAL  = 1;

  //Команды управления сервером расчета
  CS_CALC_AA  = 0;
  CS_CALC_AB  = 1;
  CS_CALC_GR  = 2;
  CS_CALC_VM  = 3;
  CS_CRT_JOB  = 4;

  //Типы данных
  DTP_FLT1     = 0;
  DTP_FLT3     = 1;
  DTP_FLT4     = 2;
  DTP_FLT5     = 3;
  DTP_FLT48    = 4;
  DTP_FLT480   = 5;
  DTP_DBL1     = 6;
  DTP_DBL3     = 7;
  DTP_DBL4     = 8;
  DTP_DBL5     = 9;
  DTP_DBL48    = 10;
  DTP_DBL480   = 11;
  DTP_DATETIME = 12;
  DTP_EVENT    = 14;
  //Тип опоса
//Равные промежутки
//Опрос по графику
//Поиск по графику
//Сервер опроса
  QTP_EQ_PERIOD  = 0;
  QTP_QWERY_SHED = 1;
  QTP_FIND_SHED  = 2;
  QTP_QWERY_SRV  = 3;
{
     function CurrentPrepare:Boolean;
     function CurrentExecute:Boolean;
     function CurrentFlush(swVMID:Integer):Boolean;

     function SetCurrentParam(var pTable:L3CURRENTDATA):Boolean;

     function UpdatePDTFilds_48(var pTable:L3CURRENTDATA):Boolean;
     function UpdatePDTData_48(var pTable:L3GRAPHDATA):Boolean;
     function IsPDTData_48(var pTable:L3GRAPHDATA):Boolean;

     function UpdateGD48(var pTable:L3CURRENTDATA):Boolean;
     function IsGraphData(var pTable:L3GRAPHDATA):Boolean;
}
//Сервер сохранения
     SVS_CUR_PREP = 0;
     SVS_CUR_EXEC = 1;
     SVS_CUR_FLSH = 2;
     SVS_SET_CUR  = 3;
     SVS_SET_ARC  = 4;
     SVS_UPD_F48  = 5;
     SVS_ADD_F48  = 6;
     SVS_UPD_D48  = 7;
     SVS_ADD_D48  = 8;
     SVS_FLS_TMR  = 9;
     SVS_ARC_TMR  = 10;
     SVS_PAC_TMR  = 11;
     SVS_SAVE_TMR = 12;
     SVS_CHSZ_TMR = 13;
     SVS_SVBS_TMR = 14;
//Типы данных сервера сохранения
     SVS_CUR      = 0;
     SVS_F48      = 1;
     SVS_D48      = 2;
//Состояние ловушки
     TRP_WAIT     = 0;
     TRP_CAPT     = 1;
     TRP_FREE     = 2;
//Тип передачи/управления
     SND_PHDT     = 0;
     SND_POKAS    = 1;
     SND_MASTER   = 2;
     SND_SLAVE    = 3;
//Состояние команды
     CMD_ENABLED  = $8000;
     CMD_QWRCMPL  = $4000;
//Типы кластеров
     CLS_MGN      = 1;
     CLS_GRAPH48  = 4;
     CLS_DAY      = 8;
     CLS_MONT     = 9;
     CLS_EVNT     = 11;
     CLS_TIME     = 12;
     CLS_PNET     = 13;
{
Local
Remote
Rem-crc
Rem-Ecom
Rem-C12
КУ
КУБ
НКУБ
НКУНБ
ТПУ
}
//Типы абонентов
     ABO_BYT    = 0;
     ABO_PROM   = 1;
     ABO_TECH   = 2;
//Типы учетов
     UTP_LOC    = 0;
     UTP_REM    = 1;
     UTP_CRC    = 2;
     UTP_ECO    = 3;
     UTP_C12    = 4;
     UTP_KU     = 5;
     UTP_KUB    = 6;
     UTP_NKUB   = 7;
     UTP_NKUNB  = 8;
     UTP_OTP    = 9;
     UTP_GVS    = 10;
     UTP_OBS    = 11;
     UTP_SUM    = 12;
     UTP_GSUM   = 13;
     QUERY_STATE_OK = 0;
     QUERY_STATE_NO = 1;
     QUERY_STATE_ER = 2;
Const
  Style   : array [0..8] of TTMSStyle =     (tsOffice2003Blue,
                                            tsOffice2003Silver,
                                            tsOffice2003Olive,
                                            tsOffice2003Classic,
                                            tsOffice2007Luna,
                                            tsOffice2007Obsidian,
                                            tsOffice2007Silver,
                                            tsWindowsXP,
                                            tsCustom);

  StrStyle   : array [0..8] of string = (   '2003Blue',
                                            '2003Silver',
                                            '2003Olive',
                                            '2003Classic',
                                            '2007Luna',
                                            '2007Obsidian',
                                            '2007Silver',
                                            'WindowsXP',
                                            'Custom');

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
  CRCLO             : array [0..255] of byte =
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

const srCRCHi:array[0..255] of byte = (
$00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
$00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
$00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41,
$00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
$00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
$01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40,
$00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
$01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
$00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
$00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
$01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
$01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
$00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40);

      srCRCLo:array[0..255] of byte = (
$00, $C0, $C1, $01, $C3, $03, $02, $C2, $C6, $06, $07, $C7, $05, $C5, $C4, $04, $CC, $0C, $0D, $CD,
$0F, $CF, $CE, $0E, $0A, $CA, $CB, $0B, $C9, $09, $08, $C8, $D8, $18, $19, $D9, $1B, $DB, $DA, $1A,
$1E, $DE, $DF, $1F, $DD, $1D, $1C, $DC, $14, $D4, $D5, $15, $D7, $17, $16, $D6, $D2, $12, $13, $D3,
$11, $D1, $D0, $10, $F0, $30, $31, $F1, $33, $F3, $F2, $32, $36, $F6, $F7, $37, $F5, $35, $34, $F4,
$3C, $FC, $FD, $3D, $FF, $3F, $3E, $FE, $FA, $3A, $3B, $FB, $39, $F9, $F8, $38, $28, $E8, $E9, $29,
$EB, $2B, $2A, $EA, $EE, $2E, $2F, $EF, $2D, $ED, $EC, $2C, $E4, $24, $25, $E5, $27, $E7, $E6, $26,
$22, $E2, $E3, $23, $E1, $21, $20, $E0, $A0, $60, $61, $A1, $63, $A3, $A2, $62, $66, $A6, $A7, $67,
$A5, $65, $64, $A4, $6C, $AC, $AD, $6D, $AF, $6F, $6E, $AE, $AA, $6A, $6B, $AB, $69, $A9, $A8, $68,
$78, $B8, $B9, $79, $BB, $7B, $7A, $BA, $BE, $7E, $7F, $BF, $7D, $BD, $BC, $7C, $B4, $74, $75, $B5,
$77, $B7, $B6, $76, $72, $B2, $B3, $73, $B1, $71, $70, $B0, $50, $90, $91, $51, $93, $53, $52, $92,
$96, $56, $57, $97, $55, $95, $94, $54, $9C, $5C, $5D, $9D, $5F, $9F, $9E, $5E, $5A, $9A, $9B, $5B,
$99, $59, $58, $98, $88, $48, $49, $89, $4B, $8B, $8A, $4A, $4E, $8E, $8F, $4F, $8D, $4D, $4C, $8C,
$44, $84, $85, $45, $87, $47, $46, $86, $82, $42, $43, $83, $41, $81, $80, $40);

type
    REPNODE = packed record
      I : Byte;   //ID Отчета
      G : String; //Группа Отчета
      N : String; //Название Отчета
    end;
const

  c_ReportsCount : BYTE = 6;
  c_ReportsTitles : array[0..5] of REPNODE = (
        (I:1; G:'Показания';      N:'Текущие показания электроэнергии'),
        (I:3; G:'Показания';      N:'Баланс по дому'),
        (I:4; G:'Показания';      N:'Анализ баланса потребления по объекту'),

        (I:5; G:'Диагностические';N:'Отчет о неопрошенных счетчиках на конец месяца'),
        (I:6; G:'Диагностические';N:'Отчет об ошибках опроса счетчиков за день'),

        (I:2; G:'Настройки';      N:'Настройки отчетов')
  );

var TKnsFormHandle      : Integer;
    TKnsFormThead       : Integer;
    TKnsFormTheadID     : Integer;
    TQweryModuleHandle  : Integer;
    TQweryModuleThead   : Integer;
    TQweryModuleTheadID : Integer;
    EventBoxHandle      : Integer;
    EventBoxThead       : Integer;
    EventBoxTheadID     : Integer;

function PosNeg(Substr: string; S: string): Integer;   // то же что и pos но ищет Substr с конца;

implementation

function PosNeg(Substr: string; S: string): Integer;
var i,k  : Integer;
    isOk : Boolean;
begin
  for i := Length(s) - Length(Substr) downto 1 do begin
    for k := 1 to Length(Substr) do begin
      isOk := False;
      if Substr[k] = s[k+i] then begin
        isOk:=True;
      end else begin
        isOk := False;
        Break;
      end;
    end;
    if isOk then begin
      Result := i + 1;
      Exit;
    end;
  end;
  Result := 0;
end;


end.


