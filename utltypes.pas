unit utltypes;

interface
uses
   Windows, forms,Classes, SysUtils,SyncObjs,stdctrls,comctrls,Grids,BaseGrid, AdvGrid,mask,Db, ADODB,
   Gauges,AdvAppStyler,utlconst,AdvOfficeButtons,AdvPanel,AdvProgressBar, Controls;
type
    SMouseM = packed record
      LastX   : Integer;
      LastY   : Integer;
      dX, dY  : Integer;
    end;
    //Структура межмодульного сообщения
    PTTreeView      = ^TTreeView;
    PTAdvStringGrid = ^TAdvStringGrid;
    PTAdvOfficeCheckBox = ^TAdvOfficeCheckBox;
    PTComboBox      = ^TComboBox;
    PTCheckBox      = ^TCheckBox;
    PTForm          = ^TForm;
    PTMaskEdit      = ^TMaskEdit;
    PTEdit          = ^TEdit;
    PTLabel         = ^TLabel;
    PTStaticText    = ^TStaticText;
    PTADOQuery      = ^TADOQuery;
    PTDateTimePicker = ^TDateTimePicker;
    PTPageControl   = ^TPageControl;
    PTGauge         = ^TGauge;
    PTProgressBar   = ^TProgressBar;
    PAdvFormStyler  = ^TAdvFormStyler;
    PTTreeNode      = ^TTreeNode;
    PTMemo          = ^TMemo;
    PTAdvPanel      = ^TAdvPanel;
    PTTrackBar      = ^TTrackBar;
    PTComponent     = ^TComponent;
    //PCTI            = ^CTI;

    CStk49Srez = packed record
      szSize   : Word;
      DATETIME : TDateTime;
      dbEnergy : array[0..3] of Double;
    End;
    CStk43Srez = packed record
      szSize   : Word;
      DATETIME : TDateTime;
      dbEnergy : Double;
    End;

    TStartParams = record
      isStartOpros :Boolean;
    end;

    CDTTime = packed record
     Year  : Byte;
     Month : Byte;
     Day   : Byte;
     Hour  : Byte;
     Min   : Byte;
     Sec   : Byte;
    End;
    SCTRPORT = packed record
     Count : Integer;
     SType : array[0..100] of Byte;
     Items : array[0..100] of Integer;
    End;
    CVData = packed record
     dtTime : TDateTime;
     nTarif : Word;
     nSID   : Word;
     fValue : Double;
    End;
    PCVData =^ CVData;

    CTreeIndex = packed record
     PTIM     : Integer;    //Картинка
     PTSD     : Integer;    //Узел Типа Структуры Данных
     PNID     : Integer;    //Узел Типа Примитива Данных
     PRID     : Integer;    //Регион
     PRYD     : Integer;    //Район
     PTWN     : Integer;    //Город
     PTPS     : Integer;    //TP
     PSTR     : Integer;    //Улица
     PAID     : Integer;    //Абонент
     PGID     : Integer;    //Группа
     PQGD     : Integer;    //Группа опроса
     PQPR     : Integer;    //Параметр группы опроса
     PVID     : Integer;    //Виртуальный Счетчик
     PCID     : Integer;    //Команда
     PPID     : Integer;    //Порт
     PMID     : Integer;    //Физ счетчик
     PTID     : Integer;    //Тариф
     PSID     : Integer;    //Тип хранения
     PDID     : Integer;    //Тип Отображения
     PKey     : Integer;
     FKey     : Integer;
     PIID     : Integer;
     PSTT     : Integer;
     PTND     : PTTreeView;
    End;
    PCTreeIndex =^ CTreeIndex;

    CGDataSource = packed record
     {
     PKey       : Integer;
     FKey       : Integer;
     FParam     : Integer;
     FParam1    : Integer;
     FParam2    : Integer;
     FParam3    : Integer;
     FParam4    : Integer;
     }
     trTRI      : CTreeIndex;
     trPTND     : Pointer;
     strCaption : String;
     strClassName : String;
     dtTime0    : TDateTime;
     dtTime1    : TDateTime;
     nViewID    : Integer;
     nHeight    : Integer;
     nWidth     : Integer;
     pOwner     : TComponent;
    End;
    PCGDataSource =^ CGDataSource;

    CMessageData = packed record
     m_swData0 : Integer;
     m_swData1 : Integer;
     m_swData2 : Integer;
     m_swData3 : Integer;
     m_swData4 : Integer;
     m_sbyInfo : array[0..60] of Byte;
    End;
    PCMessageData =^ CMessageData;

    CGMetaData = packed record
     m_swID       : Integer;
     m_dtLastTime : TDateTime;
     m_swType     : Integer;
     m_sblTarif   : Integer;
     m_swStatus   : Integer;
     m_sName      : String;
     m_fMin       : Double;
     m_fMax       : Double;
     m_fLimit     : Double;
     m_sEMet      : String;
     m_sbyDataGroup  : Byte;
    End;
    PCGMetaData =^ CGMetaData;

    CGMetaDatas = packed record
     Count : Integer;
     Items : array of CGMetaData;
    End;
    PCGMetaDatas =^ CGMetaDatas;

    CCData = packed record
     m_swID         : Integer;
     m_swVMID       : Integer;
     m_swCMDID      : Integer;
     m_swTID        : Integer;
     m_sTime        : TDateTime;
     m_byOutState   : Byte;
     m_byInState    : Byte;
     m_sfKI         : Double;
     m_sfKU         : Double;
     m_sbyMaskRead  : int64;
     m_sbyMaskReRead:Byte;
     m_sbyPrecision : Byte;
     m_sfValue      : Double;
     m_CRC          : Integer;
    End;
    PCData=^ CCData;

    CCDatas = packed record
     Count : Integer;
     Items : array of CCData;
    End;
    PCCDatas =^ CCDatas;


    // BO 18/10/2018 Запись для нового обработчика тарифов        JKLJKL
    CCDataWithTarif = packed record
     m_swID         : Integer;
     m_swVMID       : Integer;
     m_swCMDID      : Integer;
     m_swTID        : Integer;
     m_sTime        : TDateTime;
     m_byOutState   : Byte;
     m_byInState    : Byte;
     m_sfKI         : Double;
     m_sfKU         : Double;
     m_sbyMaskRead  : int64;
     m_sbyMaskReRead:Byte;
     m_sbyPrecision : Byte;
     m_sfValue      : Double;
     m_sfValue1     : Double;
     m_sfValue2     : Double;
     m_sfValue3     : Double;
     m_sfValue4     : Double;
     m_CRC          : Integer;
    End;
    PCDataWithTarif=^ CCDataWithTarif;

    CCDatasWithTarif = packed record
     Count : Integer;
     Items : array of CCDataWithTarif;
    End;
    PCCDatasWithTarif =^ CCDatasWithTarif;




    CCDataMC = packed record
     m_swID         : Integer;
     m_swVMID       : Integer;
     m_swCMDID      : Integer;
     m_sTime        : TDateTime;
     m_sfValue      : Double;
     m_sMeterCode   : string[30];
    End;
    PCDataMC=^ CCDataMC;
    CCDataMCs = packed record
     Count : Integer;
     Items : array of CCDataMC;
    End;
    PCCDataMCs =^ CCDataMCs;



    CCDataEkom = packed record
     m_swID         : Integer;
     m_swVMID       : Integer;
     m_sbyType      : Integer;
     m_swCMDID      : Integer;
     m_swTID        : Integer;
     m_sTime        : TDateTime;
     m_byOutState   : Byte;
     m_byInState    : Byte;
     m_sfKI         : Double;
     m_sfKU         : Double;
     m_sbyMaskRead  : int64;
     m_sbyMaskReRead:Byte;
     m_sbyPrecision : Byte;
     m_sfValue      : Double;
     m_CRC          : Integer;
    End;
    PCDataEkom=^ CCDataEkom;

    CCDatasEkom = packed record
     Count : Integer;
     Items : array of CCDataEkom;
    End;
    PCCDatasEkom =^ CCDatasEkom;

    CGRMetaData = packed record
     m_sName      : String;
     m_sShName    : String;
     m_sEMet      : String;
    End;
    PCGRMetaData =^ CGRMetaData;

    CIntBuffer = array of Integer;
    PCIntBuffer =^ CIntBuffer;

    CMessage = packed record
     m_swLen       : Word;
     m_swObjID     : Integer;    //Сетевой адрес счётчика
     m_sbyFrom     : Byte;
     m_sbyFor      : Byte;    //DIR_L2toL1
     m_sbyType     : Byte;    //PH_DATARD_REC
     m_sbyTypeIntID: Byte;    //DEF_COM
     m_sbyIntID    : Byte;
     m_sbyServerID : Byte;    //Указать тип счетчика
     m_sbyDirID    : Byte;
     m_sbyInfo     : array [0..3000] of Byte;
    end;
    PCMessage =^ CMessage;

    CMessageBuffer = array of CMessage;
    PCMessageBuffer =^ CMessageBuffer;

   { BufferADR = packed record
     H_Addres   : string;
    end;
    }
    CMessageBufferADR = array of string;
    PCMessageBufferADR =^ CMessageBufferADR;


    //Структура межмодульного сообщения(короткая)
    CHMessage = packed record
     m_swLen       : Word;
     m_swObjID     : Integer;
     m_sbyFrom     : Byte;
     m_sbyFor      : Byte;
     m_sbyType     : Byte;
     m_sbyTypeIntID: Byte;
     m_sbyIntID    : Byte;
     m_sbyServerID : Byte;
     m_sbyDirID    : Byte;
     m_sbyInfo     : array[0..1023] of Byte;
    end;
    //Примитив запроса
    CCOMMAND = packed record
     m_swID       : Integer;
     m_swMID      : Integer;
     m_swCmdID    : Integer;
     m_swChannel  : String[15];
     m_swSpecc0   : Integer;
     m_swSpecc1   : Integer;
     m_swSpecc2   : Integer;
     m_sbyEnable  : Byte;
     m_sbyDirect  : Byte;
     m_snDataType : Byte;
     m_swCommandNm: String;
    End;
    PCCOMMAND =^ CCOMMAND;
    CCOMMANDS = packed record
     m_swAmCommand: Word;
     m_sCommand  : array of CCOMMAND;
    End;

    CComm = class
    public
     m_swID       : Integer;
     m_swMID      : Integer;
     m_swCmdID    : Integer;
     m_swChannel  : String[15];
     m_swSpecc0   : Integer;
     m_swSpecc1   : Integer;
     m_swSpecc2   : Integer;
     m_sbyEnable  : Byte;
     m_sbyDirect  : Byte;
     m_snDataType : Byte;
    End;


    CTRLCOMMAND = packed record
     m_swCmdID    : Integer;
     m_sParamName : String[40];
     m_swSpecc0   : Integer;
     m_swSpecc1   : Integer;
     m_swSpecc2   : Integer;
    End;
    PCTRLCOMMAND =^ CTRLCOMMAND;
    CTRLCOMMANDS = packed record
     m_swAmCommand: Word;
     m_sCommand  : array of CTRLCOMMAND;
    End;



    SL3GETL2INFO = packed record
     m_swVMID       : Integer;
     m_sfKI         : Double;
     m_sfKU         : Double;
    End;
    SL3GETL2INFOS = packed record
     Count          : Integer;
     Items          : array of SL3GETL2INFO;
    End;
    PSL3GETL2INFOS  =^SL3GETL2INFOS;

    SPMETER = packed record
     m_swMID        : Integer;
    End;
    SPORTMETERS = packed record
     m_sbyPortID    : Byte;
     Count          : Integer;
     Items          : array of SPMETER;
    End;
    SABONPORTMETER = packed record
     Count         : Integer;
     Items         : array of SPORTMETERS;
    End;

    CMSDS = packed record
     m_sdwFMark    : DWORD;
     m_swLen       : Word;
     m_swType      : Word;
     m_swNS        : DWORD;
     m_sdwRetrans  : DWORD;
     m_sdwKommut   : DWORD;
     m_sdwDevice   : DWORD;
     m_sbySpeed    : Byte;
     m_sbyParity   : Byte;
     m_sbyStop     : Byte;
     m_sbyKBit     : Byte;
     m_sbyPause    : Byte;
     m_nB0Timer    : Byte;
     m_sbyReserv1  : array [0..9] of Byte;
     m_sbyInfo     : array [0..2000] of Byte;
     //m_sdwEMark    : DWORD;
    End;
    SL2ADTAG = packed record
     m_sbyNSEnable : Byte;
     m_sdwFMark    : DWORD;
     m_sdwEMark    : DWORD;
     m_sdwRetrans  : DWORD;
     m_sdwKommut   : DWORD;
     m_sdwDevice   : DWORD;
     m_sbySpeed    : Byte;
     m_sbyParity   : Byte;
     m_sbyStop     : Byte;
     m_sbyKBit     : Byte;
     m_sbyPause    : Byte;
     m_nB0Timer    : Byte;
     m_sbyReserv   : array [0..10] of Byte;
    End;

    threadKillToken = packed record
      groupID : Integer;
      paramID : Integer;
      cmd     : Integer;
    End;

    SL2TAG = packed record
     M_SWABOID      : Integer;
     m_sbyID        : Integer;
     m_sbyGroupID   : Integer;
     m_swVMID       : Integer;
     m_sbyPortID    : Integer;
     m_sbyProtID    : Integer;
     pullid         : Integer;
     m_swMID        : Integer;
     m_sbyType      : Integer;
     m_sbyLocation  : Integer;
     m_sddFabNum    : string[26];
     m_sddPHAddres  : string[35];
     m_sddPHAddres2 : string[35];
     m_swAddrOffset : Integer;
     m_schPassword  : String[20];
     m_schName      : String[100];
     m_sbyRepMsg    : Integer;
     m_swRepTime    : Word;
     m_sfKI         : Double;
     m_sfKU         : Double;
     m_sfMeterKoeff : Double;
     m_sbyPrecision : Byte;
     m_swCurrQryTm  : Word;
     m_sbyTSlice    : Byte;
     m_sPhone       : String[30];
     m_sbyModem     : Byte;
     m_sbyEnable    : Byte;
     m_swMinNKan    : Integer;
     m_swMaxNKan    : Integer;
     m_sdtSumKor    : TDateTime;
     m_sdtLimKor    : TDateTime;
     m_sdtPhLimKor  : TDateTime;
     m_sAdvDiscL2Tag: string[55];
     m_sbyStBlock   : integer;
     m_sTariffs     : string[15];
     m_bySynchro    : Byte;
     m_blOneSynchro : Boolean;
     m_swKE         : integer;
     m_sAD          : SL2ADTAG;
     m_sAktEnLose   : double;
     m_sReaEnLose   : double;
     m_sTranAktRes  : double;
     m_sTranReaRes  : double;
     m_sGrKoeff     : integer;
     m_sTranVolt    : integer;
     m_sTpNum       : string[30];
     m_sbyKTRout    : integer;
     typepu         : integer;
     typezvaz       : string;
     typeabo        : string;
     m_aid_channel  : Integer;
     m_aid_tariff   : Integer;
     m_sddHOUSE     : string[26];
     m_sddKV        : string[26];
    end;

    PSL2TAG =^ SL2TAG;

    TByteDynArray         = array of Byte;
    PByteDynArray         = ^TByteDynArray;

    CMETERTAG = packed record
      P1             : Pointer;
      B1,B2,B3,B4,B5 : Boolean;
      ListBD         : TStringList;
      CMD            : Integer;
    end;
    //////ОПИСАНИЕ CMETERTAG////////
    //ССДУ//
    {
     B1 - для проверки контрольной суммы и выход если OK иначе повторный запрос
     B2 - определение для посылки одного канала или промежуток 1..50
     B3 - пометка статистики опрошени или нет
     B4 - пометка авторизации для 164-01МиК
     B5 - пометка команд. проверка какая команда выполняется
    }
    ////////////////////////////////


    PCMETERTAG =^CMETERTAG;

    SL2INITITAG = packed record
     m_sbyLayerID    : Byte;
     m_swAmMeter     : Word;
     m_sMeter        : array of SL2TAG;
    end;
    PSL2INITITAG =^ SL2INITITAG;

    SL2ImgIndex = packed record
     m_swVMID       : WORD;
     m_sbyModem     : Byte;
     m_sbyEnable    : Byte;
     end;

    PSL2ImgIndex =^ SL2ImgIndex;
    SL2InitImgIndex = packed record
     m_sbyLayerID    : Byte;
     m_swAmMeter     : Word;
     m_sMeter        : array of SL2ImgIndex;
    end;
    PSL2InitImgIndex =^ SL2InitImgIndex;

    SL2TAGREPORT = packed record
      m_sVMeterName : string;
      m_sddPHAddres : string;
      m_sddKVNum    : string;
      m_sbyType     : Byte;
      m_swVMID      : Integer;
      m_swMID       : Integer;
      m_sfKI        : Double;
      m_sfKU        : Double;
      m_sbyPrecision: Byte;
      m_sbyLocation : Byte;
      m_sObject     : string;
      m_sGroupName  : string;
      m_sName       : string;
      M_SDOGNUM     : string;
     // m_sTpTar      : string;
      M_SMAXPOWER   : double;
      M_SWPLID      : integer;
    end;

    SL2TAGREPORTLIST = packed record
      Count         : integer;
      m_sMeter      : array of SL2TAGREPORT;
    end;

    //Таблица инициализации L1
    SL1SHTAG = packed record
     m_sbyID       : Byte;
     m_sbyPortID   : Integer;
     m_sbyPortNum  : Integer;
     m_sbySpeed    : Byte;
     m_sbyParity   : Integer;
     m_sbyData     : Byte;
     m_sbyStop     : Byte;
     m_swDelayTime : Integer;
     m_swPoolTime  : Integer;
    end;

    SL1TAG = packed record
     m_sbyID       : Integer;
     m_sbyPortID   : Integer;
     m_schName     : String[50];
     m_sbyPortNum  : Integer;
     m_sbyType     : Byte;
     m_sbyProtID   : Byte;
     m_sbyControl  : Byte;
     m_sbyKTRout   : Byte;
     m_sbySpeed    : Byte;
     m_sbyParity   : Integer;
     m_sbyData     : Byte;
     m_sbyStop     : Byte;
     m_swDelayTime : Integer;
     m_swAddres    : Integer;
     m_sblReaddres : Byte;
     m_schPhone    : String[30];
     m_swIPPort    : String[30];
     m_schIPAddr   : String[30];
     m_nFreePort   : Byte;
    end;
    PSL1TAG =^ SL1TAG;
    SL1INITITAG = packed record
     m_sbyLayerID  : Byte;
     Count         : Integer;
     Items : array of SL1TAG;
    end;
    PSL1INITITAG =^ SL1INITITAG;
    SL4CONNTAG = packed record
     m_sbyID       : Integer;
     m_sbyCliID    : Integer;
     m_sbyPortID   : Integer;
     m_sbyProtID   : Byte;
     m_schName     : String[50];
     m_schPhone    : String[30];
    end;
    PSL4CONNTAG =^ SL4CONNTAG;
    SL4CONNTAGS = packed record
     Count : Byte;
     Items : array[0..50] of SL4CONNTAG;
    end;
    //Таблица подключений счетчиков
    L3CONNECTION = packed record
     m_sbyID         : Byte;
     m_sbyGroupID    : Integer;
     m_swVMID        : WORD;
     m_sblIsConnect  : Boolean;
    end;
    PL3CONNECTION =^ L3CONNECTION;
    SL3CHANEQDT = packed record
     m_swID      : Integer;
     m_swCHID    : Integer;
     m_swCMDID   : Word;
     m_swTID     : Word;
     m_sTime     : TDateTime;
     m_sfV       : array[0..11] of Extended;
    End;
    SL3CHANDT = packed record
     m_swID      : Integer;
     m_swCHID    : Integer;
     m_swCMDID   : Word;
     m_swTID     : Word;
     m_sTime     : TDateTime;
     m_sfWP0     : Extended;
     m_sfWM0     : Extended;
     m_sfQP0     : Extended;
     m_sfQM0     : Extended;
     m_sfWP1     : Extended;
     m_sfWM1     : Extended;
     m_sfQP1     : Extended;
     m_sfQM1     : Extended;
     m_sfDWP     : Extended;
     m_sfDWM     : Extended;
     m_sfDQP     : Extended;
     m_sfDQM     : Extended;
    End;
    PSL3CHANDT =^ SL3CHANDT;
    SL3CHANDTS = packed record
     Count       : Integer;
     Items       : array of SL3CHANDT;
    End;
    SL3CHANDGE = packed record
     m_swID      : Integer;
     m_swVMID    : Integer;
     m_swCHID    : Integer;
     m_dtTime    : TDateTime;
     m_sComment  : String[100];
     m_sddFabNum_0   : String[26];
     m_sddPHAddres_0 : string[26];
     m_sfKU_0    : Double;
     m_sfKI_0    : Double;
     m_sddFabNum_1   : String[26];
     m_sddPHAddres_1 : string[26];
     m_sfKU_1    : Double;
     m_sfKI_1    : Double;
     m_sbyEnable : Byte;
     Item        : SL3CHANDTS;
    End;
    PSL3CHANDGE =^ SL3CHANDGE;
    SL3CHANDGES = packed record
     Count       : Integer;
     Items       : array of SL3CHANDGE;
    End;

    SL3PARAM = packed record
     m_swID          : WORD;
     m_swParamID     : WORD;
     m_sParamName    : String[30];
     m_sParamEI      : String[30];
    end;
    PSL3PARAM =^ SL3PARAM;

    //Таблица параметров вычислителя
    SL3PARAMS = packed record
     m_swID          : Integer;
     m_swAID         : Integer;
     m_swGID         : Integer;
     m_swVMID        : Integer;
     m_swMID         : Integer;
     m_swParamID     : Integer;
     m_sbyPortID     : Integer;
     m_sParamExpress : String[250];
     m_sParam        : String[10];
     m_fValueSv      : Double;
     m_fValue        : Double;
     m_fMin          : Double;
     m_fMax          : Double;
     m_fLimit        : Double;
     m_fDiffer       : Double;
     m_dtLastTime    : TDateTime;
     m_stSvPeriod    : Integer;
     //m_byOutState    : Byte;
     //m_byInState     : Byte;
     m_sblTarif      : Byte;
     m_sblCalculate  : Byte;
     m_sblSaved      : Byte;
     m_sblEnable     : Byte;
     m_swStatus      : Byte;
     m_sbyDataGroup  : Byte;
     m_sbyRecursive  : Byte;
     m_sbyLockState  : Byte;
     m_snDataType    : Byte;
    end;
    PSL3PARAMS =^ SL3PARAMS;
    SL3PARAMSS = packed record
     Count : Integer;
     Items : array of SL3PARAMS;
    End;
   //Таблица вычислителя
    SL3VMETERTAG = packed record
     m_swID          : Integer;
     m_swABOID       : Integer;
     m_swMID         : Integer;
     m_sbyPortID     : Integer;
     m_sbyPullID     : Integer;
     m_sbyType       : Integer;
     m_sbyGroupID    : Integer;
     m_swVMID        : Integer;
     m_swAmParams    : Integer;
     m_sbyExport     : Byte;
     m_sbyEnable     : Byte;
     m_sddPHAddres   : string[30];
     m_sMeterName    : String[150];
     m_sVMeterName   : String[150];
     m_swPLID        : integer;
     M_SMETERCODE    : string[30];
     ItemCh          : SL3CHANDGES;
     Item            : SL3PARAMSS;

    // ************* BO 27/09/2018
     m_sddHOUSE      : string[26];
    // ************* end of BO
    
    end;
    PSL3VMETERTAG =^ SL3VMETERTAG;
    SL3VMETERTAGS = packed record
     Count : Integer;
     Items : array of SL3VMETERTAG;
    End;
    {
    id абонента	Код района	Название населенного пункта	Город\село	Улица	       Дом	Корпус	Квартира	Лицевой счет	Фамилия	   Имя	   Отчество	Заводской номер счетчика  Тип счетчика	Тип УСПД	Тип связи с ИЦ	номер для дозвона к УСПД	тип абонента	Количество точек учета	Поле 1	Поле 2	Поле 3	Поле 4	Поле 5	Поле 6	Поле 7
                20	        Могилев	                        0	        Орловского	24	Д	1         	1325001	        Nерешкова  Лариса  Арсеньевна	514256	                  EE8007	USPDEA8086	0	        3,75448E+11	                0	        1		        1	1
    }
    CUnloadEntity = class
    public
      mtid      : Integer;
      mesID     : Integer;
      resID     : Integer;
      ulicaID   : Integer;
      naspID    : Integer;
      aboID     : Integer;
      rayCode   : String;
      townName  : String;
      gorSel    : String;
      street    : String;
      houseName : String;
      korpus    : String;
      kvarNo    : String;
      licNo     : String;
      fam       : String;
      imya      : String;
      otch      : String;
      zavNo     : String;
      metType   : String;
      uspdType  : String;
      connType  : String;
      connNo    : String;
      aboType   : String;
      amMeter   : String;
      field1    : String;
      field2    : String;
      field3    : String;
      field4    : String;
      field5    : String;
      field6    : String;
      field7    : String;
    End;
    SL2PULLDS = packed record
     ID             : INTEGER;
     PULLTYPE       : String[20];
     DESCRIPTION    : String[50];
    end;
    SL2PULLDSS = packed record
     count          : Integer;
     items          : array of SL2PULLDS;
    end;

    SL2PULL = packed record
     ID                : INTEGER;
     PULLID            : INTEGER;
     CONNECTIONTIMEOUT : INTEGER;
     CONNSTRING        : String[50];
     RECONNECTIONS     : INTEGER;
     PORTID            : INTEGER;
     STATE             : SMALLINT;
    end;
    SL2PULLS = packed record
     count             : Integer;
     items             : array of SL2PULL;
    end;

    CL2Pulls = class
     public
      ID             : INTEGER;
      PULLTYPE       : String[20];
      DESCRIPTION    : String[50];
      item           : TThreadList;
      procedure clear;
      destructor Destroy; override;
    end;
    PCL2Pulls = ^CL2Pulls;

    CL2Pull = class
     public
      ID                : INTEGER;
      PULLID            : INTEGER;
      PORTID            : INTEGER;
      CONNECTIONTIMEOUT : INTEGER;
      CONNSTRING        : String[50];
      RECONNECTIONS     : INTEGER;
      STATE             : SMALLINT;
    end;
    PCL2Pull = ^CL2Pull;

    CL2PullObject = record
      ID                : INTEGER;
      PULLTYPE          : String[20];
      DESCRIPTION       : String[50];
      CONNECTIONTIMEOUT : INTEGER;
      CONNSTRING        : String[50];
      RECONNECTIONS     : INTEGER;
      STATE             : SMALLINT;
    End;
    PCL2PullObject = ^CL2PullObject;




    SL2PORTPULL = packed record
     id              : Integer;
     pullid          : Integer;
     connstring      : String[50];
    end;
    PSL2PORTPULL =^ SL2PORTPULL;
    SL2PORTPULLS = packed record
     id              : Integer;
     pullid          : Integer;
     count           : Integer;
     pulltype        : Integer;
     name            : String[50];
     items           : array of SL2PORTPULL;
    end;
    PSL2PORTPULLS =^ SL2PORTPULLS;



    CJoinL2 = class
    public
     m_swMID     : Integer;
     m_swVMID    : Integer;
     m_swPullID  : Integer;
     M_SBYTYPE   : Integer;
    end;

    CQueryState = class
    public
     allMeter : Integer;
     isOk     : Integer;
     isNo     : Integer;
     isEr     : Integer;
    End;

    //0. Код_РЭС,
    //1. Населенный пункт,
    //2. ГородСело,
    //3. Улица,
    //4. Дом,
    //5. ,
    //6. Квартира,
    //7. ЛицевойСчет,
    //8. Фамилия,
    //9. Имя,
    //10.Отчество,
    //11.ЗаводскойНомер,
    //12.Тип_ПУ,
    //13.Тип УСПД,
    //14.Тип связи УСПД и ИЦ,
    //15.номер для дозвона к УСПД,
    //16.тип абонента,
    //17.номер точки учета,,,,,,,

    CLoadEntity = class
    public
      id    : Integer;
      mes   : String;    //0
      res   : String;    //0
      nasp  : String;    //1
      tp    : String;    //1
      gors  : String;    //2
      ulica : String;    //3
      dom   : String;    //4
      korp  : String;    //5
      kvar  : String;    //6
      lics  : String;    //7
      fam   : String;    //8
      imya  : String;    //9
      otch  : String;    //10
      zavno :  String;   //11
      typepu   : String; //12
      typeuspd : String; //13
      typezvaz : String; //14
      nomerdoz : String; //15
      typeabo  : String; //16
      nomertu : String;  //17
      field1  : String;
      field2  : String;
      field3  : String;
      field4  : String;
      field5  : String;
      field6  : String;
      field7  : String;
      mesID   : Integer;
      resID   : Integer;
      naspID  : Integer;
      ulicaID : Integer;
      aboID   : Integer;
      mtID    : Integer;
      raycode : String;
      ki      : Double;
      ku      : Double;
      idchannel: String;
      idtariff : String;
      house   : String;    //ДЛЯ ТП И УСТРОЙСТВ ССДУ КУБ И ТД
      kv      : String;    //ДЛЯ ТП И УСТРОЙСТВ ССДУ КУБ И ТД
    End;

    QUERYGROUP = class
    public
      ID     : Integer;
      NAME   : String;
      ENABLE : Integer;
      STATPARAM : Integer;
      DateQuery  : TDate;               // BO 12/12/18
      ErrorQuery : byte;                // BO 12/12/18
      itemParam : TThreadList;
      itemAbon : TThreadList;
      destructor Destroy; override;
    end;

    QGPARAM = class
    public
      ID       : Integer;
      QGID     : INTEGER;
      PARAM    : INTEGER;
      PARAMNM  : String;
      DTBEGIN  : TDateTime;
      DTEND    : TDateTime;
      DTPERIOD : TDateTime;
      DAYMASK  : INTEGER;
      MONTHMASK: INTEGER;
      ENABLE   : INTEGER;
      DEEPFIND : INTEGER;
      PAUSE    : INTEGER;
      FINDDATA : INTEGER;
      PACKETK  : INTEGER;
      UNDEEPFIND : INTEGER;
      UNPATH     : String;
      UNENABLE   : INTEGER;
      ISRUNSTATUS : INTEGER;
      RUNSTATUS   : String;
      ERRORPERCENT : double;
      ERRORPERCENT2: double;
      TIMETOSTOP   : TDateTime;
    end;

    QGABONS = class
    public
      ID          : INTEGER;
      ABOID       : INTEGER;
      ABONM       : String;
      QGID        : INTEGER;
      DTBEGINH    : TDateTime;
      DTENDH      : TDateTime;
      CURCOUNTER  : String;
      ALLCOUNTER  : INTEGER;
      ISOK        : INTEGER;
      ISNO        : INTEGER;
      ISER        : INTEGER;
      PERCENT     : Double;
      QUALITY     : Double;
      DESCRIPTION : String;
      STATE       : Integer;
      ENABLE      : INTEGER;
      ENABLE_PROG : INTEGER;
      EA8086      : INTEGER; // Определение что это концентратор
      NUMABON     : String; // Номер или IP
      TYPEUSPD    : String;
      GSM         : Integer;
    End;
     SLQGABONS = packed record
     //m_sbyLayerID    : Byte;
     Count           : integer;
     Items           : array of QGABONS;
    end;

    QGABONSTP = packed record
      NAMETP      : String[50];
    End;
     SLQQABONTP = packed record
     //m_sbyLayerID    : Byte;
     Count           : integer;
     Items           : array of QGABONSTP;
    end;


    //Таблица группы вычислителей
    SL3GROUPTAG = packed record
     m_sbyID         : Integer;
     m_swABOID       : Integer;
     m_sbyGroupID    : Integer;
     m_swPLID        : Integer;
     m_swAmVMeter    : Integer;
     m_swPosition    : Integer;
     M_NGROUPLV      : Byte;
     m_nTarifMask    : DWord;
     m_sbyEnable     : Byte;
     m_sGroupName    : String[250];
     m_sGroupExpress : String[250];
     Item            : SL3VMETERTAGS;
    end;
    PSL3GROUPTAG =^ SL3GROUPTAG;
    //Таблица инициализации L3
    SL3INITTAG = packed record
     m_sbyLayerID    : Byte;
     Count           : Word;
     Items           : array of SL3GROUPTAG;
    end;
    PSL3INITTAG =^ SL3INITTAG;
    //Таблица группы вычислителей
    SL3GROUPTAG1 = packed record
     m_sbyID         : Byte;
     m_swABOID       : Integer;
     m_sbyGroupID    : Integer;
     m_swPLID        : Integer;
     m_swAmVMeter    : Integer;
     m_swPosition    : Integer;
     M_NGROUPLV      : Byte;
     m_nTarifMask    : DWord;
     m_sbyEnable     : Byte;
     m_sGroupName    : String;
     m_sGroupExpress : String;
     m_sReportVS     : int64;
     M_STREESETTINGS : int64;
     Item            : SL3VMETERTAGS;
    end;
    SL3INITTAG1 = packed record
     m_sbyLayerID    : Byte;
     Count           : Word;
     Items           : array of SL3GROUPTAG1;
    end;
    //Таблица абонента
    SL3ABON = packed record
     m_swID      : Integer;
     m_swABOID   : Integer;
     m_swPortID  : Integer;
     m_sdtRegDate: TDateTime;
     m_nRegionID : Integer;
     M_SWDEPID   : Integer;
     M_SWSTREETID: Integer;
     M_SWTOWNID  : Integer;
     TPID        : Integer;
     m_sName     : string[100];
     m_sObject   : string[100];
     m_sKSP      : string[5];
     m_sDogNum   : string[25];
     m_sPhone    : string[25];
     m_sAddress  : string[75];
     m_sEAddress : string[55];
     m_sShemaPath: string[55];
     m_sComment  : string[200];
     m_sTelRing  : string[25];
     m_sRevPhone : string[35];
     m_sPhoto    : string;
     m_sbyEnable : Byte;
     m_sbyVisible: Byte;
     m_sReportVS : Int64;
     m_sLIC      : string[100];
     m_strOBJCODE: string[100];
     m_sMaxPower : double;
     m_sTreeSettings : int64;
     m_sAddrSettings : int64;//M_SADDRSETTINGS
     M_NABONTYPE     : Integer;
     M_SMARSHNUMBER  : string[10];
     M_SHOUSENUMBER  : string[5];
     M_SKORPUSNUMBER : string[5];
     GORS            : string;
     Item        : SL3INITTAG;
     //Схема электроснабжения
    End;
    PSL3ABON =^ SL3ABON;
    SL3ABONS = packed record
     Count     : Integer;
     Items     : array of SL3ABON;
    end;

    SL3ABONNAME = packed record
     m_swABOID   : Integer;
     m_sName     : String;
    end;
    SL3ABONSNAMES = packed record
     Count     : Integer;
     Items     : array of SL3ABONNAME;
    end;

    {

CREATE TABLE SL3TP (
    ID     INTEGER NOT NULL,
    ABOID  INTEGER,
    NAME   VARCHAR(50)
);
    }

    SL3TP = packed record
     ID         : Integer;
     M_SWTOWNID : Integer;
     TPTYPE     : Integer;
     NAME       : String;
    end;
    PSL3TP =^ SL3TP;

    SL3TPS = packed record
     Count     : Integer;
     Items     : array of SL3TP;
    end;


    // Структура вычислителя для модуля статистики
    SL3VMETERTAG_STAT = packed record
     m_swMID         : WORD;
     m_swVMID        : WORD;
     m_sbyPortID     : WORD;
//     m_sbyEnable     : Byte;
     m_sVMeterName   : String[150];
    end;
    // Структура абонента для модуля статистики
    SL3ABON_STAT = packed record
     m_swABOID   : Integer;
     m_sName     : string[200];
     Count       : Integer;
     Items       : array of SL3VMETERTAG_STAT;
    End;
    // Структура списка абонентов для модуля статистики
    SL3ABONS_STAT = packed record
     Count     : Integer;
     Items     : array of SL3ABON_STAT;
    end;
    SL3ABONLB = packed record
     m_nRegID      : Integer;
     m_sRegName    : String;
     m_nDepartID   : Integer;
     m_sDepartName : String;
     m_nTwnID      : Integer;
     m_sTwnName    : String;
     m_nStreetID   : Integer;
     m_sStreetName : String;
    End;

    SL3REGION = packed record
     m_swID      : Integer;
     m_nRegionID : Integer;
     m_nRegNM    : string[100];
     m_sKSP      : string[5];
     m_sbyEnable : Byte;
     Item        : SL3ABONS;
    End;
    PSL3REGION =^ SL3REGION;

    SL3REGIONS = packed record
     Count     : Integer;
     Items     : array of SL3REGION;
    End;

    SL3DEPARTAMENT = packed record
      m_swID            : Integer;
      m_swRegion        : Integer;
      m_swDepID         : Integer;
      m_sName           : string[150];
      code              : String;
    end;

    SL3DEPARTAMENTS = packed record
      Count             : Integer;
      Items             : array of SL3DEPARTAMENT;
    end;

    SL3TOWN = packed record
      m_swID            : Integer;
      m_swDepID         : Integer;
      m_swTownID        : Integer;
      m_sName           : string[150];
    end;

    SL3TOWNS = packed record
      Count             : Integer;
      Items             : array of SL3TOWN;
    end;

    SL3STREET = packed record
      m_swID            : Integer;
      m_swTownID        : Integer;
      m_swTPID          : Integer;
      m_swStreetID      : Integer;
      m_sName           : string[150];
    end;

    SL3STREETS = packed record
      Count             : Integer;
      Items             : array of SL3STREET;
    end;

    QM_METER = packed record
     m_swID     : Word;
     m_swType   : Word;
     m_sName    : String[100];
     m_sComment : String[100];
    end;
    PQM_METER =^ QM_METER;
    QM_METERS = packed record
     m_swAmMeterType : Word;
     m_sMeterType    : array of QM_METER;
    end;

    QM_PARAM = packed record
     m_swID        : Integer;
     m_swType      : Word;
     m_sName       : String[40];
     m_sShName     : String[30];
     m_sEName      : String[10];
     m_sEMet       : String[10];
     m_swSvPeriod  : Integer;
     m_sblTarif    : Byte;
     m_swActive    : Byte;
     m_swStatus    : Byte;
     m_swIsGraph   : Byte;
     m_sbyDataGroup: Byte;
     m_sbyDeltaPer : Byte;
    end;
    PQM_PARAM =^ QM_PARAM;
    QM_PARAMS = packed record
     Count    : Word;
     Items    : array of QM_PARAM;
    end;
    QM_COMMAND = packed record
     m_swID      : Integer;
     m_swType    : Word;
     m_swCMDID   : Word;
     m_sName     : string[40];
     m_swSpec0   : Integer;
     m_swSpec1   : Integer;
     m_swSpec2   : Integer;
     m_sblSaved  : Byte;
     m_sbyEnable : Byte;
     m_sbyDirect : Byte;
     m_snDataType: Byte;
    end;
    PQM_COMMAND =^ QM_COMMAND;
    QM_COMMANDS = packed record
     m_swAmCommandType : Word;
     m_sCommandType    : array of QM_COMMAND;
    end;

    TM_SZNDAY = packed record
     m_swID       : Integer;
     m_swSZNID    : Byte;
     m_swMntID    : Byte;
     m_swDayID    : Byte;
     m_swTDayID   : Byte;
     m_sbyEnable  : Byte;
    End;
    TM_SZNDAYS = packed record
     Count        : Integer;
     Items        : array[1..400] of TM_SZNDAY;
    End;
    TM_SZNTARIFF = packed record
     m_swID       : Integer;
     m_swSZNID    : Integer;
     m_swSZNName  : String[100];
     m_snFTime    : TDateTime;
     m_snETime    : TDateTime;
     m_sbyEnable  : Byte;
     Item         : TM_SZNDAYS;
    End;
    PTM_SZNTARIFF =^ TM_SZNTARIFF;
    TM_SZNTARIFFS = packed record
     Count        : Word;
     Items        : array of TM_SZNTARIFF;
    End;
    PTM_SZNTARIFFS =^ TM_SZNTARIFFS;

    TM_PLANE = packed record
     m_swID       : Integer;
     m_swPLID     : Integer;
     m_sName      : String[100];
     m_sAmZones   : Integer;
     m_sbyEnable  : Byte;
    End;
    PTM_PLANE = ^TM_PLANE;
    TM_PLANES = packed record
     Count        : Word;
     Items        : array of TM_PLANE;
    End;
    PTM_PLANES = ^TM_PLANES; 

    TM_TARIFF = packed record
     m_swID       : Integer;
     m_swPTID     : Integer;
     m_swTID      : Integer;
     m_swZoneID   : Integer;
     m_sName      : String[100];
     m_dtTime0    : TDateTime;
     m_dtTime1    : TDateTime;
     m_sfKoeff    : Double;
     m_sbyEnable  : Byte;
    End;
    PTM_TARIFF =^ TM_TARIFF;
    TM_TARIFFS = packed record
     m_swID       : Integer;
     m_swTTID     : Integer;
     m_swZoneID   : Integer;
     m_swPLID     : Integer;
     m_swSZNID    : Integer;
     m_swTDayID   : Integer;
     m_sName      : String[100];
     m_swCMDID    : Integer;
     m_dtTime0    : TDateTime;
     m_dtTime1    : TDateTime;
     m_sbyEnable  : Byte;
     Count        : Integer;
     Items        : array of TM_TARIFF;
    End;
    PTM_TARIFFS =^ TM_TARIFFS;
    TM_TARIFFSS = packed record
     Count     : Word;
     Items     : array of TM_TARIFFS;
    End;
    STATIFJOINTAG = packed record
     m_swSZNID  : Integer;
     m_swTDayID : Integer;
     m_swPLID   : Integer;
     m_swSZTM0  : TDateTime;
     m_swSZTM1  : TDateTime;
    End;

    SL3TRANSTIME = packed record
     m_swID        : Integer;
     m_swTRSID     : Integer;
     m_dtTime      : TDateTime;
     m_dtTimeNew   : TDateTime;
     m_sbyState    : Byte;
     m_sbyEnable   : Byte
    End;
    PSL3TRANSTIME =^ SL3TRANSTIME;
    SL3TRANSTIMES = packed record
     Count     : Integer;
     Items     : array of SL3TRANSTIME;
    End;

    //Data Routing
    L3GRAPHDATA = packed record
     m_swID        : Word;
     m_swVMID      : Integer;
     m_swCMDID     : Word;
     m_swSumm      : Double;  // предположим - это сумма счетчиков
     m_sdtLastTime : TDateTime;
     m_sdtDate     : TDateTime;
     m_sMaskRead   : int64;
     m_sMaskReRead : int64;
     v             : array[0..47] of Double;  //  или это здесь
     m_crc         : integer;
    end;
    PL3GRAPHDATA =^ L3GRAPHDATA;
    L3GRAPHDATAS = packed record
     Count         : Integer;
     Items         : array of L3GRAPHDATA;
    end;

    L3GRAPHDATAMC = packed record
     m_swID        : Word;
     m_swVMID      : Word;
     M_SMETERCODE  : String[30];
     m_swCMDID     : Word;
     m_swSumm      : Double;
     m_sdtLastTime : TDateTime;
     m_sdtDate     : TDateTime;
     m_sMaskRead   : int64;
     m_sMaskReRead : int64;
     v             : array[0..47] of Double;
     m_crc         : integer;
    end;
    PL3GRAPHDATAMC =^ L3GRAPHDATAMC;
    L3GRAPHDATAMCS = packed record
     Count         : Integer;
     Items         : array of L3GRAPHDATAMC;
    end;


    L3GRAPHDATAEKOM = packed record
     m_swID        : Word;
     m_swVMID      : Word;
     m_sbyType     : Integer;
     m_swCMDID     : Word;
     m_swSumm      : Double;
     m_sdtLastTime : TDateTime;
     m_sdtDate     : TDateTime;
     m_sMaskRead   : int64;
     m_sMaskReRead : int64;
     v             : array[0..47] of Double;
     m_crc         : integer;
    end;
    PL3GRAPHDATAEKOM =^ L3GRAPHDATAEKOM;
    L3GRAPHDATASEKOM = packed record
     Count         : Integer;
     Items         : array of L3GRAPHDATAEKOM;
    end;

    L3PDTDATA_48 = packed record
     m_swID        : Integer;
     m_swVMID      : Integer;
     m_swCMDID     : Integer;
     m_sdtDate     : TDateTime;
     m_sMaskRead   : int64;
     v             : array[0..47] of Single;
    end;
    PL3PDTDATA_48 =^ L3PDTDATA_48;
    L3PDTDATA_48S = packed record
     Count         : Integer;
     Items         : array of L3PDTDATA_48;
    end;


        // список недостоверных, по мнению Гомелского Энргосбыта, данных
    L3VALIDATAMY = packed record
     m_swAbon      : Word; // abonent
     m_swTuch      : Word; // tuch
     m_swGraphType : Word;
     m_sdtDate     : TDateTime;
     m_swHH        : Byte;
     m_fVal        : Double;
     m_fPokStart   : Double;
     m_fVal1       : Double;
    end;
    PL3VALIDATAMY =^ L3VALIDATAMY;
    L3VALIDATASMY = packed record
     Count         : Integer;
     Items         : array of L3VALIDATAMY;
    end;

    L3DATASAVT_EXP = packed record
        m_swVMID: Integer;
        ZAVN    : String[28];
        KJU     : String[16];
        ADR     : String[255];
        UID     : Integer;
        KOD_CH  : Integer;
        TIPSH   : String[28];
        UCH     : Integer;
        DAT     : TDateTime;
        VREM    : TDateTime;
        Q1      : Extended;
        V1      : Extended;
        G1      : Extended;
        TPOD    : Single;
        Q2      : Extended;
        V2      : Extended;
        G2      : Extended;
        TOBR    : Single;
        TXV     : Single;
        TRAB    : Extended;
        TRAB_O  : Extended;
        NoTrab_o : String[255];
        N_GRUCH : Integer;
    end;
    L3DATASAVT_EXPS = packed record
        Count    : Integer;
        Items : array of L3DATASAVT_EXP;
    End;
    //Arch_uspd(архив событий успд)
    ARCH_USPD = packed record
     n_obj       : Word;
     link_adr    : Word;
     n_ri        : Word;
     on_date_time: TDateTime;
     event_text  : String[50];
    end;
    PL3ARCH_USPD =  ^ ARCH_USPD;
   //VAl(срезы энергии и показания приборов учета)
    VAl = packed record
     n_obj       : Integer;
     link_adr    : Word;
     n_ri        : Word;
     izm_type    : Word;
     data        : TDateTime;
     inter_val   : Word;
     n_zone      : Word;
     znach       : Double;
     flag        : string[10];
    end;
    PL3VAl =  ^ VAl;

    //Data Routing
    L3CURRENTDATA = packed record
     m_swID    : Word;
     m_swVMID  : Integer;
     m_swTID   : Word;
     m_swCMDID : Word;
     m_swSID   : Word;
     m_sTime   : TDateTime;
     m_sfKU    : Double;
     m_sfKI    : Double;
     m_sfSvValue     : Double;
     m_sfValue       : Double;
     m_byOutState    : Byte;
     m_byInState     : Byte;
     m_sbyMaskRead   : Byte;
     m_sbyMaskReRead : Byte;
     m_sMaskRead     : int64;
     m_sMaskReRead   : int64;
     m_sbyPrecision  : Byte;
     m_CRC           :Integer;
    end;
    PL3CURRENTDATA =^ L3CURRENTDATA;
    L3CURRENTDATAS = packed record
     Count    : Integer;
     Items    : array of L3CURRENTDATA;
    end;
    PL3CURRENTDATAS =^ L3CURRENTDATAS;

    CVToken = packed record
     sPName  : String;
     fValue  : Extended;
     sTime   : TDateTime;
     sbyOutState : Byte;
     sbyInState  : Byte;
     nTID    : Integer;
     nSID    : Integer;
     nGSID   : Integer;
     nVMID   : Integer;
     blIsUpdate : Boolean;
     blError : Boolean;
     m_crc   :Integer;
     m_sbyPrecision  : Byte;
    End;
    PCVToken =^ CVToken;

    //Примитив запроса
    CQueryPrimitive = packed record
     m_wLen       : Word;
     m_swVMtrID   : Integer;
     m_swMtrID    : Word;
     m_swCmdID    : Word;
     m_swParamID  : Word;
     m_swChannel  : string[8];
     m_swSpecc0   : Smallint;
     m_swSpecc1   : Smallint;
     m_swSpecc2   : Smallint;
     m_sbyEnable  : Byte;
    End;
    PCQueryPrimitive =^ CQueryPrimitive;

    //Таблица соединений
    SL3CONNTBL = packed record
     m_swID        : Integer;
     m_swCNID      : Integer;
     m_swCPortID   : Integer;
     m_swLocation  : Integer;
     m_swNetMode   : Integer;
     m_sName       : String[50];
     m_sConnString : String[150];
     m_sLogin      : String[50];
     m_sPassword   : String[50];
     m_sPasswordL2 : String[50];
     m_sPasswordL3 : String[50];
     m_sbyEnable   : Byte;
    End;
    PSL3CONNTBL =^ SL3CONNTBL;
    SL3CONNTBLS = packed record
     Count         : Integer;
     Items         : array of SL3CONNTBL;
    End;
    PSL3CONNTBLS =^ SL3CONNTBLS;


    //Таблица инициализации L4
    SL4TAG = packed record
     m_sbyID        : Byte;
     m_swAddr       : Word;
     m_sbyArmType   : Byte;
     m_sbyPortTypeID: Byte;
     m_sbyPortID    : Byte;
     m_sbyRepMsg    : Byte;
     m_sbyRepTime   : Byte;
    end;
    SL4INITITAG = packed record
     m_sbyLayerID    : Byte;
     m_sbyAmArm      : Byte;
     //m_sbyBox        : Byte;
     //m_sbyBoxSz      : Word;
     m_sArmModule    : array[0..4] of SL4TAG;
    end;
    PSL4INITITAG =^ SL4INITITAG;
    //Таблица инициализации L5
    SL5INITITAG = packed record
     m_sbyLayerID    : Byte;
     m_byL1Open      : Byte;
     m_byL2Open      : Byte;
     m_byL3Open      : Byte;
     m_byL4Open      : Byte;
     m_byL5Open      : Byte;
    end;
    SREADDRTAG = packed record
     m_sbyID         : Word;
     m_sbyLAddr      : Word;
     m_sbyPAddr      : Int64;
    end;
    SREADDRTBL = packed record
     m_sAmRec        : Word;
     m_nRTBL         : array of SREADDRTAG;
    end;

    SL2USPDREADLIST = packed record
     m_swMaxPackLen       : WORD;
     m_swPRUSPDDev        : WORD;
     m_swPRUSPDCharDev    : WORD;
     m_swPRUSPDCharKan    : WORD;
     m_swPRUSPDCharGr     : WORD;
     m_swPRUSPDDevMax     : WORD;
     m_swPRUSPDCharDevMax : WORD;
     m_swPRUSPDCharKanMax : WORD;
     m_swPRUSPDCharGrMax  : WORD;
    end;

    SL2USPDTYPE = packed record       // Запрос типа и характеристик УСПД
      m_swID           : DWORD;
      m_swUSPDID       : DWORD;
      m_sUSPDName      : string;      // УСПД, дата выпуска, номер версии
      m_sNameAdr       : string;      // Название и краткий адрес объекта
      m_sdwWorkNumb    : DWORD;       // Заводской номер УСПД.
      m_swVersPO       : WORD;        // Номер версии ПО УСПД.
      m_swNumIK        : WORD;        // Используемое количество ИК.
      m_swNumGr        : WORD;        // Используемое количество групп.
      m_swNumTZ        : WORD;        // Используемое количество тарифных зон
      m_swMaxSupMetNum : WORD;        // Максимальное количество поддерживаемых устройств
      m_swNumConMet    : WORD;        // Общее количество подключенных устройств
      m_swMaxPackLen   : WORD;        // Максимальная возможная длина в байтах ответной посылки
    end; PSL2USPDTYPE = ^SL2USPDTYPE;

    SL2USPDTYPEEX = packed record       // Запрос типа и характеристик УСПД
      m_sUSPDName      : string;  // УСПД, дата выпуска, номер версии
      m_sNameAdr       : string;  // Название и краткий адрес объекта
      m_sdwWorkNumb    : DWORD;       // Заводской номер УСПД.
      m_swVersPO       : WORD;        // Номер версии ПО УСПД.
      m_swNumIK        : WORD;        // Используемое количество ИК.
      m_swNumGr        : WORD;        // Используемое количество групп.
      m_swNumTZ        : WORD;        // Используемое количество тарифных зон
      m_swMaxSupMetNum : WORD;        // Максимальное количество поддерживаемых устройств
      m_swNumConMet    : WORD;        // Общее количество подключенных устройств
      m_swMaxPackLen   : WORD;        // Максимальная возможная длина в байтах ответной посылки
    end; PSL2USPDTYPEEX = ^SL2USPDTYPEEX;

    SL2USPDEV = packed record          // Запрос списка поддерживаемых устройств
      m_swID           : DWORD;
      m_swUSPDID       : DWORD;
      m_swBMID         : DWORD;
      m_swIdev         : WORD;         // елочисленный код устройства
      m_sName          : String;       // название устройства
    end;

    SL2USPDEVEX = packed record          // Запрос списка поддерживаемых устройств
      m_swIdev         : WORD;           // елочисленный код устройства
      m_sName          : String;         // название устройства
    end;

    SL2USPDEVLIST = packed record
      Count            : WORD;
      Items            : array of SL2USPDEV;
    end;  PSL2SUPDEVLIST = ^ SL2USPDEVLIST;

    SL2USPDEVLISTEX = packed record
      Count            : WORD;
      Items            : array of SL2USPDEVEX;
    end;  PSL2SUPDEVLISTEX = ^ SL2USPDEVLISTEX;

    SL2USPDCHARACTDEV = packed record      //Запрос характеристик подключенных устройств
      m_swID           : DWORD;
      m_swUSPDID       : DWORD;
      m_swBMID         : DWORD;
      m_swMID          : DWORD;
      m_swNDev         : WORD;         //Номер устройства, назначаемый УСПД
      m_swIDev         : WORD;         //Код устройства из списка запроса
      m_sdwWorkNumb    : DWORD;        //Заводской номер устройства
      m_swANet         : WORD;         //Сетевой адрес устройства
      m_swNK           : WORD;         //Число запрограммированных каналов для данного устройства
      m_swLMax         : WORD;         //Максимальная глубина доступной информации
      m_sfKt           : Double;       //Коэффициент трансформации
      m_sfKpr          : Double;       //Коэффициент преобразования
      m_sfKp           : Double;       //Коэффициент трансформации
      m_swKmb          : WORD;         // битовая маска
      m_sdwMUmHi       : DWORD;        // маска  считываемых параметров
      m_sdwMUmLo       : DWORD;        // младший байт
      m_sStrAdr        : string;            // адреса узла сети
    end;

    SL2USPDCHARACTDEVEX = packed record      //Запрос характеристик подключенных устройств
      m_sbyPortID      : integer;
      m_swNDev         : WORD;         //Номер устройства, назначаемый УСПД
      m_swIDev         : WORD;         //Код устройства из списка запроса
      m_sdwWorkNumb    : DWORD;        //Заводской номер устройства
      m_swANet         : WORD;         //Сетевой адрес устройства
      m_swNK           : WORD;         //Число запрограммированных каналов для данного устройства
      m_swLMax         : WORD;         //Максимальная глубина доступной информации
      m_sfKt           : Double;       //Коэффициент трансформации
      m_sfKpr          : Double;       //Коэффициент преобразования
      m_sfKp           : Double;
      m_swKmb          : WORD;         // битовая маска
      m_sdwMUmHi       : DWORD;        // маска  считываемых параметров
      m_sdwMUmLo       : DWORD;        // младший байт
      m_sStrAdr        : string;            // адреса узла сети
    end;

    SL2USPDCHARACTDEVLIST = packed record
      Count            : WORD;
      Items            : array of SL2USPDCHARACTDEV;
    end; PSL2USPDCHARACTDEV = ^SL2USPDCHARACTDEV;

    SL2USPDCHARACTDEVLISTEX = packed record
      Count            : WORD;
      Items            : array of SL2USPDCHARACTDEVEX;
    end; PSL2USPDCHARACTDEVEX = ^SL2USPDCHARACTDEVEX;


    SL2USPDCHARACTKANAL = packed record            // Запрос характеристик каналов
      m_swID           : DWORD;
      m_swUSPDID       : DWORD;
      m_swBMID         : DWORD;
      m_swMID          : DWORD;
      m_swNk           : WORD;                 // Номер канала УСПД
      m_swNDev         : WORD;                 // Номер устройства, назначаемый УСПД
      m_swIk           : WORD;                 // Номер ИК подчиненного УСПД
      m_sfKtr          : Double;               // Коэффициент трансформации
      m_sfKpr          : Double;               // Коэффициент преобразования
      m_sfKp           : Double;               // Коэффициент потерь
      m_sbyPm          : byte;                 // вид измеряемой энергии
      m_sbyKmb         : byte;
      m_sNameKanal     : string;               // наименование ИК
    end;

    SL2USPDCHARACTKANALEX = packed record            // Запрос характеристик каналов
      m_swNk           : WORD;                 // Номер канала УСПД
      m_swNDev         : WORD;                 // Номер устройства, назначаемый УСПД
      m_swIk           : WORD;                 // Номер ИК подчиненного УСПД
      m_sfKtr          : Double;               // Коэффициент трансформации
      m_sfKpr          : Double;               // Коэффициент преобразования
      m_sfKp           : Double;               // Коэффициент потерь
      m_sbyPm          : byte;                 // вид измеряемой энергии
      m_sbyKmb         : byte;
      m_sNameKanal     : string;               // наименование ИК
    end;

    SL2USPDCHARACTKANALLIST = packed record
      Count           : WORD;
      Items           : array of SL2USPDCHARACTKANAL;
    end; pSL2USPDCHARACTKANALLIST =  ^SL2USPDCHARACTKANALLIST;

    SL2USPDCHARACTKANALLISTEX = packed record
      Count           : WORD;
      Items           : array of SL2USPDCHARACTKANALEX;
    end; pSL2USPDCHARACTKANALLISTEX =  ^SL2USPDCHARACTKANALLISTEX;

    SL2USPDCHARACTGR = packed record
      m_swGrID        : integer;
      m_sVMeters      : string;
      m_sGroupName    : string;
    end;

    SL2USPDCHARACTGRLIST = packed record
      Count           : WORD;
      Items           : array of SL2USPDCHARACTGR;
    end; pSL2USPDCHARACTGRLIST =  ^SL2USPDCHARACTGRLIST;
    	 //for Reports
    ITEM_SUM_F1 = packed record
     m_sEnergyType  : Integer;
     m_sTarType     : Integer;
     m_sfValue      : Real;
    end;
    SUMMARY_F1 = packed record
     m_sbyCount     : Integer;
     Item           : array [1..40] of ITEM_SUM_F1
    end;                
    REPORT_F1 = packed record
     m_swID          : integer;
     m_swABOID       : integer;
     m_sWorkName     : string;
     m_sFirstSign    : string;
     m_sSecondSign   : string;
     m_sThirdSign    : string;
     m_sTelephon     : string;
     m_sEMail        : string;
     m_sNDogovor     : string;
     m_sAdress       : string;
     m_sNameObject   : string;
     m_sbyIsReadZerT : byte;
     m_swColorCol    : integer;                                                                 
     m_swColorRow    : integer;
     ABO             : integer;
     KSP             : string;
     m_strObjCode    : string;
    end;


    {
    cbm_sInterSet: TComboBox;
    Label35: TLabel;
    edm_sMdmJoinName: TEdit;
    Label17: TLabel;
    Label36: TLabel;
    cbm_sUseModem: TComboBox;
    edm_sInterDelay: TEdit;
    }
    //General Settings
    SGENSETTTAG = packed record
     m_swID         : Integer;
     m_sbyMode      : Byte;
     m_sbyLocation  : Byte;
     m_sbyAutoPack  : Byte;
     m_swAddres     : String[30];
     m_swMask       : String[30];
     m_swGate       : String[30];
     m_sStorePeriod : Integer;
     m_sStoreClrTime: Integer;
     m_sStoreProto  : Integer;
     m_sPoolPeriod  : Integer;
     m_sProjectName : String[100];
     m_sPrePoolGraph: Byte;
     m_sQryScheduler: Byte;
     m_sPowerLimit  : Double;
     m_sPowerPrc    : Integer;
     m_sAutoTray    : Byte;
     m_sPrecise     : Byte;
     m_sPreciseExpense : Byte;
     m_sCorrDir     : Byte;
     m_sBaseLocation: Byte;
     m_sKorrDelay   : Double;
     m_sSetForETelecom : Byte;
     m_sInterSet    : Byte;
     m_sMdmJoinName : String[50];
     m_sUseModem    : Byte;
     m_sInterDelay  : Double;
     m_sChannSyn    : Byte;
     m_sbyAllowInDConn :Byte;
     m_sTransTime   : Byte;
     m_sChooseExport: integer;
     m_swSelfTest   : Dword;
     m_blOnStartCvery:Byte;   
     m_sbyDeltaFH   : Byte;
     {MySQL}
     m_dtEStart     : TDateTime;
     m_dtEInt       : TDateTime;
     m_dtLast       : TDateTime;
     m_sDBNAME      : String[16];
     m_sDBUSR       : String[16];
     m_sDBPASSW     : String[16];
     m_SDBSERVER    : String[20];
     m_SDBPORT      : Integer;
     {Archive}
     m_byEnableArchiv : Byte;
     m_sArchPath      : String[100];
     m_sSrcPath       : String[100];
     m_tmArchPeriod   : Byte;
     m_dtEnterArchTime: TDateTime;
     M_SQUERYMASK     : int64;
     {DBF, Минский Энергосбыт}
     m_sDBFLOCATION   : String[255];
     m_sMAKLOCATION   : String[255];
     m_sHOSTMAK       : String[100];
     m_sEMAILMAK      : String[100];
     m_sPASSMAK       : String[100];
     m_sNAMEMAILMAK   : String[100];
     m_nEInt          : Byte;
     m_blMdmExp       : Byte;
     M_BLFMAKDELFILE  : Byte;
     M_NSESSIONTIME   : Integer;
     m_sCalendOn      : Byte;
    end;
    PSGENSETTTAG =^ SGENSETTTAG; 

    //Event Settings
    SEVENTSETTTAG = packed record
     m_swID         : Integer;
     m_swGroupID    : Word;
     m_swEventID    : Word;
     //m_sdtEventTime : TDateTIme;
     m_schEventName : String[50];
     m_sbyEnable    : Byte;
    end;
    SEVENTSETTTAGS = packed record
     Count         : Integer;
     Items         : array of SEVENTSETTTAG;
    end;

    SEVENTTAG = packed record
     m_swID             : Integer;
     m_swVMID           : Word;
     m_swGroupID        : Word;
     m_swEventID        : Word;
     m_sdtEventTime     : TDateTIme;
     m_sUser            : String[10];
     m_sbyEnable        : Byte;
     m_swDescription    : extended;
     m_swAdvDescription : integer;
    end;
    SEVENTTAGS = packed record
     Count         : Integer;
     Items         : array of SEVENTTAG;
    end;
    STESTTAG = packed record
     m_swID         : Integer;
     m_swTSTID      : Integer;
     m_swObjID      : Integer;
     m_sdtTestTime  : TDateTIme;
     m_strComment   : String[50];
     m_strDescription : String[50];
     m_strResult    : String[10];
    end;
    STESTTAGS = packed record
     Count         : Integer;
     Items         : array of STESTTAG;
    end;


    SQRYSDLTAG = packed record
     m_swID         : Integer;
     m_swQCID       : Integer;
     m_sdtEventTime : TDateTIme;
     m_sbyState     : Byte;
     m_sbySynchro   : Byte;
     m_sbyEnable    : Byte;
    end;
    SQRYSDLTAGS = packed record
     Count         : Integer;
     Items         : array of SQRYSDLTAG;
    end;
    //User Settings
    SUSERTAG = packed record
     m_swID        : Integer;
     m_swUID       : Integer;
     m_swSLID      : Integer;
     m_sdtRegDate  : TDateTime;
     m_strShName   : String[50];
     m_strPassword : String[50];
     m_strFam      : String[50];
     m_strImya     : String[50];
     m_strOtch     : String[50];
     m_strDolgn    : String[50];
     m_strHomeAddr : String[50];
     m_strTel      : String[50];
     m_strEMail    : String[50];
     m_sbyPrmDE    : Byte;
     m_sbyPrmPE    : Byte;
     m_sbyPrmQE    : Byte;
     m_sbyPrmCE    : Byte;
     m_sbyPrmGE    : Byte;
     m_sbyPrmTE    : Byte;
     m_sbyPrmCNE   : Byte;
     m_sbyPrmPRE   : Byte;
     m_sbyEnable   : Byte;
     m_sbyQryGrp   : Byte;
     m_sbyAccReg   : Byte;
     m_sAccesReg   : String;
     m_sPhoto      : String; 
     m_sAllowAbon  : String;
    end;
    SUSERTAGS = packed record
     Count         : Integer;
     Items         : array of SUSERTAG;
    end;
    //Connection Settings
    SCONNSETTTAG = packed record
     m_swID        : Integer;
     m_swConnID    : Word;
     m_schConnName : String[50];
     m_sbyEnable   : Byte;
    end;
    SCONNSETTTAGS = packed record
     Count         : Integer;
     Items         : array of SCONNSETTTAG;
    end;
    //Color Settings
    SCOLORSETTTAG = packed record
     m_swID        : Integer;
     m_swCtrlID    : Integer;
     m_swColor     : Integer;
     m_sstrFontName:String[30];
     m_swFontSize  :Byte;
     m_swColorPanel:Integer;
     m_swStyle     :integer;
    end;
    SCOLORSETTTAGS = packed record
     Count         : Integer;
     Items         : array of SCOLORSETTTAG;
    end;
    //Scins Settings
    SSKINSETTTAG = packed record
     m_swID        : Integer;
     m_swSkinID    : Integer;
     m_schSkinName : String[50];
     m_byIsCurrent : Byte;
    end;
    SSKINSETTTAGS = packed record
     Count         : Integer;
     Items         : array of SSKINSETTTAG;
    end;
    //Hard Key Settings
    SHKEYSETTTAG = packed record
     m_swID         : Integer;
     m_swPortID     : Integer;
     m_swPortTypeID : Integer;
    end;
    //----ENERGOTELECOM TYPES-----
    SENRGOTELCOM = packed record
      m_sbIsTrasnBeg : Boolean;
      m_swObjID      : Word;
    end;
    SPHADRANDCOMPRT = packed record
      m_swPHAddres  : WORD;
      m_swPortID    : WORD;
      m_swProto     : WORD;
    end;
    SPHADRANDCOMPRTS = packed record
      Count         : Integer;
      Items         : array of SPHADRANDCOMPRT;
    end;
    //----------------------------

    ////_GOMELENERGO_////////////////////////////////////////////
    ABON = packed record
     ABO        :INTEGER;
     NM_ABO     :string[100];
     KSP        :string[5];
     NOM_DOGWR  :string[25];
    end;
    PLABON = ^ ABON;

    TUCH = packed record
     ABO      :INTEGER;
     TUCH     :INTEGER;
     ZNOM_SH  :string[10];
     ADRTU    :string[50];
     KFTRN    :INTEGER;
    end;
    PLTUCH = ^TUCH;

    SLTUCH = packed record
      Count         : integer;
      Items         : array of TUCH;
    end;
    PSLTUCH = ^SLTUCH;

    BUF_V_INT = packed record
     ABO          :INTEGER;
     TUCH         :INTEGER;
     N_GR_TY      :INTEGER;
     DD_MM_YYYY   :TDateTime;
     N_INTER_RAS  :INTEGER;
     VAL          :Double;
     POK_START    :Double;
     VAL1         :Double;
    end;
    PLBUF_V_INT = ^BUF_V_INT;

    AVT_EXP = packed record
     ZAVN     :string[28];
     KJU      :string[16];
     ADR      :string[255];
     KOD_CH   :INTEGER;
     TIPSH    :string[8];
     UCH      :INTEGER;
     DAT      :TDateTime;
     VREM     :Double;
     Q1       :Double;
     V1       :Double;
     TPOD     :Double;
     Q2       :Double;
     V2       :Double;
     TOBR     :Double;
     TXV      :Double;
     TRAB     :Double;
     TRAB_O   :Double;
     N_GRUCH  :INTEGER;
    end;
    PLAVT_EXP = ^AVT_EXP;

    SL3QUERRYFH   = packed record
      m_swParam       : integer;
      m_swYn          : integer;
      m_swYk          : integer;
      m_sQuerry       : array of CQueryPrimitive;
    end;

    SL3FHSTATE    = packed record
     m_swState        : integer;
     m_sQuerrys       : array of SL3QUERRYFH;
    end;
///////////////////////////////////////////////////////////
{MySQL}
 // MySQL
 
    L3ARCHDATAMY = packed record
     m_swVMID      : Word; // tuch
     m_swCMDID     : Word;
     m_sdtDate     : TDateTime;
     m_sfValue     : Double;
    end;
    PL3ARCHDATAMY =^ L3ARCHDATAMY;
    L3ARCHDATASMY = packed record
     Count         : Integer;
     Items         : array of L3ARCHDATAMY;
    end;
    L3GRAPHDATAMY = packed record
     m_swAbon      : Word; // abonent
     m_swVMID      : Word; // tuch
     m_swCMDID     : Word;
     m_swSumm      : Double;
     m_sdtDate     : TDateTime;
     v             : array[0..47] of Double;
    end;
    PL3GRAPHDATAMY =^ L3GRAPHDATAMY;
    L3GRAPHDATASMY = packed record
     Count         : Integer;
     Items         : array of L3GRAPHDATAMY;
    end;
       //Таблица вычислителя
    SL3MYVMETERTAG = packed record
     m_swVMID        : WORD;
     m_swMID         : WORD;
     m_sddPHAddres   : string[30];
     m_sVMeterName   : String[150];
     m_sfKTR         : Integer;
     m_nType         : Byte;
     m_vPortID       : Integer;
    end;
    PSL3MYVMETERTAG =^ SL3MYVMETERTAG;
    SL3MYVMETERTAGS = packed record
     Count : Integer;
     Items : array of SL3MYVMETERTAG;
    End;
    //Таблица группы вычислителей
    SL3MYGROUPTAG = packed record
     m_swABOID       : Integer;
     m_sbyGroupID    : Integer;
     m_swAmVMeter    : Integer;
     m_sGroupName    : String[100];
     Item            : SL3MYVMETERTAGS;
    end;
    PSL3MYGROUPTAG =^ SL3MYGROUPTAG;
    STUCH = packed record
     m_nVMID     : Integer;
     m_nMID      : Integer;
     m_nPID      : Integer;
     m_nABO      : Integer;
     m_nTUCH     : Integer;
     m_sZNOM_SH  : String[10];
     m_sADRTU    : String[50];
     m_nKFTRN    : Integer;
     m_nType     : Byte;
    end;
    PSTUCH = ^STUCH;
    SABON = packed record
     m_nABOID    : Integer;
     m_nABO      : Integer;
     M_NABONTYPE : Integer;
     M_SMARSHNUMBER  : string[10];
     M_SHOUSENUMBER  : string[5];
     M_SKORPUSNUMBER : string[5];
     m_sNM_ABO   : String[100];
     m_sKSP      : String[5];
     m_sNOM_DOGWR: String[6];
     Count       : Integer;
     Items       : array of STUCH;
    end;
    PSABON = ^SABON;
{
CREATE TABLE `asbyt_enrg` (
  `LIC_CH` varchar(20) DEFAULT NULL,
  `FIO` varchar(40) DEFAULT NULL,
  `NAM_PUNK` varchar(20) DEFAULT NULL,
  `NAS_STR` varchar(20) DEFAULT NULL,
  `DOM` varchar(5) DEFAULT NULL,
  `KORP` varchar(4) DEFAULT NULL,
  `KVAR` varchar(4) DEFAULT NULL,
  `STAMP` date DEFAULT NULL,
  `NOM_SCH` varchar(20) DEFAULT NULL,
  `D1` date DEFAULT NULL,
  `D2` date DEFAULT NULL,
  `VAL_K1` decimal(11,0) DEFAULT NULL,
  `VAL_MAX1` decimal(11,0) DEFAULT NULL,
  `VAL_MIN1` decimal(11,0) DEFAULT NULL,
  `VAL_K2` decimal(11,0) DEFAULT NULL,
  `VAL_MAX2` decimal(11,0) DEFAULT NULL,
  `VAL_MIN2` decimal(11,0) DEFAULT NULL,
  `R_MAX` decimal(11,0) DEFAULT NULL,
  `R_MIN` decimal(11,0) DEFAULT NULL,
  `R_ALL` decimal(11,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT
}
    asbyt_enrg = packed record
     M_SWABOID: Integer;
     M_SWVMID : Integer;
     M_SWMID  : Integer;
     LIC_CH   : String[20];
     FIO      : String[40];
     NAM_PUNK : String[20];
     NAS_STR  : String[20];
     DOM      : String[5];
     KORP     : String[4];
     KVAR     : String[4];
     STAMP    : TDateTime;
     NOM_SCH  : String[20];
     D1       : TDateTime;
     D2       : TDateTime;
     v        : array[0..5] of Double; 
     VAL_K1   : Double;
     VAL_MAX1 : Double;
     VAL_MIN1 : Double;
     VAL_K2   : Double;
     VAL_MAX2 : Double;
     VAL_MIN2 : Double;
     R_MAX    : Double;
     R_MIN    : Double;
     R_ALL    : Double;
    End;
    asbyt_enrgs = packed record
     Count : Integer;
     RCount : Integer;
     Items : array of asbyt_enrg;
    End;

    SL3LIMITTAG = packed record
     IsLoad        : boolean;
     mswID         : Integer;
     m_swABOID     : Integer;
     m_swVMID      : Integer;
     m_swCMDID     : Integer;
     m_swTID       : Integer;
     m_swMinValue  : Double;
     m_swMaxValue  : Double;
     m_sDateBeg    : TDateTime;
     m_sDateEnd    : TDateTime;
    end; PSL3LIMITTAG = ^SL3LIMITTAG;
    SL3LIMITTAGS = packed record
     Count         : Integer;
     Items         : array of SL3LIMITTAG;
    end; PSL3LIMITTAGS = ^SL3LIMITTAGS;
    SL3LIMITVALUE = packed record
      Tarr         : integer;
      maxVal       : Double;
      minVal       : Double;
      DateBeg      : TDateTime;
      DateEnd      : TDateTime;
    end; PSL3LIMITVALUE = ^SL3LIMITVALUE;
    SL3LIMITVALUES = packed record
      Count           : integer;
      IsMaxValNormal  : boolean;
      IsMinValNormal  : boolean;
      ABOID           : integer;
      Items           : array of SL3LIMITVALUE;
    end; PSL3LIMITVALUES = ^SL3LIMITVALUES;

    SL3WRITETAG = packed record
     M_SWCMDID: Integer;
     M_SWTID  : Integer;
    End;
    SL3WRITETAGS = packed record
     Count       : Integer;
     Items       : array of SL3WRITETAG;
    End;
    SL2EA8086STRUCT = packed record
     m_sKoncFubNum : string;
     m_sKoncPassw  : string;
     m_sAdrToRead  : string;
     m_sRazNumb    : string;
     m_sTarVar     : string;
    end;
    SL2EA8086STRUCT_RX = packed record
     Packet : array of Byte;
    end;
    SL2EA8086STRUCT_RXPacket = packed record
     Count       : Integer;
     Items       : array of SL2EA8086STRUCT_RX;
    End;

    SL2TAGADVSTRUCT = packed record
      m_sKoncFubNum  : string;
      m_sKoncPassw   : string;
      m_sAdrToRead   : string;
      m_sKoncRazName : string;
      m_sKoncRazNumb : string;
      m_sKoncNumTar  : string;
      m_sNaprVvoda   : string;
      m_sTypeTI      : string;
      m_sTypeTU      : string;
      m_sDateInst    : TDateTime;
    end;
    SL3ExportDBF = packed record
      s_AID   : WORD;
      s_VMID  : WORD;
      s_Type  : Byte;
      m_strMType : String[30]; // Номер абонента  или лиц.счет для быт. потребителей  (поле должно быть предоставлено для коррекции в программе опроса)
      NUMABON : String[15]; // Номер абонента  или лиц.счет для быт. потребителей  (поле должно быть предоставлено для коррекции в программе опроса)
      ZAVOD   : String[4];  // Ваш идентификатор, например (по-английски  A2K)
      TIP_SC  : String[20]; // Код типа счетчика (поле должно быть предоставлено для коррекции в программе опроса)
      NOM_SC  : String[20]; // Номер счетчика
      UL      : String[100];// Наименование улицы
      DOM     : String[4];  // Дом
      KORP    : String[4];  // Корпус
      KV      : String[4];  // Квартира
      DAT     : TDateTime;  // Дата снятия показаний (01.ММ.ГГГГ)
      KI      : Double;     //
      KU      : Double;     //
      POKP_ALL: Double;     // Общее показание счетчика (прием)
      POKP_1  : Double;     // Показание шкалы 1 (прием) (по тарифам)
      POKP_2  : Double;     // Показание шкалы 2 (прием) (по тарифам)
      POKP_3  : Double;     // Показание шкалы 3 (прием) (по тарифам)
      POKP_4  : Double;     // Показание шкалы 4 (прием) (по тарифам)
      POKP_5  : Double;     // Показание шкалы 5 (прием) (по тарифам)
      POKP_6  : Double;     // Показание шкалы 6 (прием) (по тарифам)
      POKP_7  : Double;     // Показание шкалы 7 (прием) (по тарифам)
      POKP_8  : Double;     // Показание шкалы 8 (прием) (по тарифам)

      POKO_ALL: Double;     // Общее показание счетчика (отдача)
      POKO_1  : Double;     // Показание шкалы 1 (отдача) (по тарифам)
      POKO_2  : Double;     // Показание шкалы 2 (отдача) (по тарифам)
      POKO_3  : Double;     // Показание шкалы 3 (отдача) (по тарифам)
      POKO_4  : Double;     // Показание шкалы 4 (отдача) (по тарифам)
      POKO_5  : Double;     // Показание шкалы 5 (отдача) (по тарифам)
      POKO_6  : Double;     // Показание шкалы 6 (отдача) (по тарифам)
      POKO_7  : Double;     // Показание шкалы 7 (отдача) (по тарифам)
      POKO_8  : Double;     // Показание шкалы 8 (отдача) (по тарифам)

      MU      : Double;
      MV      : Double;
      MD      : Double;
      MN      : Double;
    end;
{28. Максимальная мощность за месяц
29. Выборочные данные событий нормального и аварийного режима работы устройств
(журналов событий, сбои, отключение питания и т.д.) влияющие на расчеты
28. Максимальная мощность за месяц                   
29. Выборочные данные событий нормального и аварийного режима работы устройств 
(журналов событий, сбои, отключение питания и т.д.) влияющие на расчеты:
29.1	Возможность применения к расчетам
29.2	Отсутствие токов в фазе А(1),В(2),С(3). 
29.3	Отсутствие напряжений  А(1),В(2),С(3). 
29.4	Перегрузки по току
29.5	Низкое напряжение линии
29.6	Воздействие электромагнитным полем
29.7	Вскрытие клемника устройства
29.8	Продолжительность открытия
29.9	Реверс
29.10	 Критические ошибки устройств
29.11	 Уход часов
29.12	 Дата поверки
29.13	 Дата выпуска
29.14	 Дата сброса
29.15	 Неисправность батареи
29.16	 Блокировка устройств
29.17	 Состояние устройства отключения нагрузки
29.18	 Отключения устройства при достижении порога по мощности
29.19	 Дата программирования
29.20	 Последовательность фаз
29.21	 Существующее тарифное расписание (по признаку)
29.22	 Прочие

 }

  SL3ExportDBFS = packed record
    Count : Integer;
    Items : array of SL3ExportDBF;
  end;
   SL3ExportMOGB = packed record
     m_nABOID    : Integer;
     m_swVMID    : Integer;
     m_nCMDID    : Integer;
     m_swtid     : Integer;
     m_dtDate    : TDateTime;
     m_byREGID   : Byte;
     m_wDEPID    : Word;
     m_strLicNb  : String;
     m_nGorSel   : String;
     m_nRES      : Byte;
     m_nCS       : Byte;
     m_strTYPE   :String;
     m_strLicNbAbo : String;
     m_strKvNb   : String;
     m_strFabNum : String;
     m_strFIO    : String;
     m_strAddr   : String;
     m_strTown   : String;
     m_strStreet : String;
     m_strHouse  : String;
     m_strKorpus : String;
     m_dbDataT0  : Double;     
     m_dbDataT1  : Double;
     m_dbDataT2  : Double;
     m_dbDataT3  : Double;
     m_dbDataT4  : Double;
     KFTR        : Integer;
   End;
   SL3ExportMOGBS = packed record
    Count : Integer;
    Items : array of SL3ExportMOGB;
   end;

     SL3ExportVIT = packed record
     m_nABOID      : Integer;
     m_swVMID      : Integer;
     m_nCMDID      : Integer;
     m_byREGID     : Byte;
     m_wDEPID      : Word;
     NUMABON       : String[15]; // Номер абонента  или лиц.счет для быт. потребителей  (поле должно быть предоставлено для коррекции в программе опроса)
     DOM           : String[10];
     KVAR          : String[30];
     m_nRES        : Byte;
     m_nCS         : Byte;
     m_strLicNbAbo : String;
     m_strKvNb     : String;
     m_strFabNum   : String;
      POK_HOUSE    : Double;      // Дом
      TIME         : String[14];     // Дата снятия показаний (01.ММ.ГГГГ)
      POK_ALL      : Double;     // Общее показание счетчика (прием)
      POK_T1       : Double;     // Показание шкалы 1 (прием) (по тарифам)
      POK_T2       : Double;     // Показание шкалы 2 (прием) (по тарифам)
      POK_T3       : Double;     // Показание шкалы 3 (прием) (по тарифам)
      POK_T4       : Double;     // Показание шкалы 4 (прием) (по тарифам)
      POK_T5       : Double;     // Показание шкалы 5 (прием) (по тарифам)
      FLAG         : Integer;
   End;

   SL3ExportVitebsk = packed record
    Count : Integer;
    Items : array of SL3ExportVIT;
   end;

   SL3Vector = packed record
      DT : TDateTime;
      FREQ  : Double;
      IA    : Double;
      UA    : Double;
      COSFA : Double;
      IB    : Double;
      UB    : Double;
      COSFB : Double;
      IC    : Double;
      UC    : Double;
      COSFC : Double;
   end;

   SL3Vectors_48 = packed record
      DT : TDateTime;
      DataMask : Int64;
      
      FREQ  : array [0..47] of Double;
      IA    : array [0..47] of Double;
      UA    : array [0..47] of Double;
      COSFA : array [0..47] of Double;
      PA    : array [0..47] of Double;
      QA    : array [0..47] of Double;
      SA    : array [0..47] of Double;

      IB    : array [0..47] of Double;
      UB    : array [0..47] of Double;
      COSFB : array [0..47] of Double;
      PB    : array [0..47] of Double;
      QB    : array [0..47] of Double;
      SB    : array [0..47] of Double;

      IC    : array [0..47] of Double;
      UC    : array [0..47] of Double;
      COSFC : array [0..47] of Double;
      PC    : array [0..47] of Double;



      QC    : array [0..47] of Double;
      SC    : array [0..47] of Double;

      PS    : array [0..47] of Double;
      QS    : array [0..47] of Double;
      SS    : array [0..47] of Double;
      COSFS : array [0..47] of Double;
   end;


   SL3Vectors = packed record
      Count : Integer;
      Items : array of SL3Vector;
   end;

   SL3VectorData = packed record
      DT : TDateTime;
      DataMask : Int64;
      FREQ     : Double;
      IA    : Double;
      UA    : Double;
      COSFA : Double;
      PA    : Double;
      QA    : Double;
      SA    : Double;

      IB    : Double;
      UB    : Double;
      COSFB : Double;
      PB    : Double;
      QB    : Double;
      SB    : Double;

      IC    : Double;
      UC    : Double;
      COSFC : Double;
      PC    : Double;
      QC    : Double;
      SC    : Double;

      PS    : Double;
      QS    : Double;
      SS    : Double;
      COSFS : Double;
   end;

    SL3VMTAG = packed record
     m_swID       : Integer;
     m_swQCID     : Integer;
     m_swABOID    : Integer;
     m_swVMID     : Integer;
     m_nQryMask0 : int64;
    End;
    PSL3VMTAG =^ SL3VMTAG;
    SL3VMTAGS = packed record
     Count : Integer;
     Items : array of SL3VMTAG;
    End;
    SL3QWERYCELLTAG = packed record
     m_swID       : Integer;
     m_swQCID     : Integer;
     m_nMonthMask : DWord;
     m_nDayMask   : DWord;
     m_sbyEnable  : Byte;
     m_sVMT       : SL3VMTAGS;
     m_sSDL       : SQRYSDLTAGS;
    End;
    PSL3QWERYCELLTAG =^ SL3QWERYCELLTAG;
    SL3QWERYCELLTAGS = packed record
     Count : Integer;
     Items : array of SL3QWERYCELLTAG;
    End;
    PSL3QWERYCELLTAGS =^ SL3QWERYCELLTAGS;
    SECOMTRANZ = packed record
     m_nAutoStart : Integer;
     m_nPort      : Integer;
     m_nPortSpeed : String;
     m_nPhone     : String;
     m_nNode      : Integer;
     m_nPassword  : String;
     m_nPause     : Integer;
     m_nTotalTime : Integer;
     m_nPortUspd  : Integer;
    End;
    MONHANDLE = Integer;
    MONTAG1 = packed record
     Value : Single;
    End;
    MONTAG2 = packed record
     Value : array[0..3] of Single;
    End;
    SMONITORDATA = packed record
     m_swID   : Integer;
     m_swVMID : Integer;
     m_nCount : Integer;
     m_nSize  : Integer;
     m_nPeriod: Integer;
     CmdID    : Integer;
     m_dtBegin: TDateTime;
     m_dtEnd : TDateTime;
     m_dtDate: TDateTime;
     m_nData : TMemoryStream;
     Items1  : array of MONTAG1;
     Items2  : array of MONTAG2;
    End;
    PSMONITORDATA = ^SMONITORDATA;
    SMONITORDATAS = packed record
     Count : Integer;
     Items  : array of SMONITORDATA;
    End;
    STIMEPERIOD = packed record
     m_dtBegin : TDateTime;
     m_dtEnd   : TDateTime;
     m_nPeriod : Integer;
    End;
    STIMEPERIODS = packed record
     Count : Integer;
     Items  : array of STIMEPERIOD;
    End;
    PSTIMEPERIOD =^ STIMEPERIOD;
    CDataClusters = packed record
     Count : Integer;
     Items : array of TMemoryStream;
    End;
    SQWERYMDL = packed record
     m_snID         : Integer;
     m_snCLID       : Integer;
     m_snAID        : Integer;
     m_snSRVID      : Integer;
     m_snVMID       : Integer;
     m_snMID        : Integer;
     m_snPID        : Integer;
     m_snCLSID      : Integer;
     m_strCMDCluster: String[70];
     m_sdtBegin     : TDateTime;
     m_sdtEnd       : TDateTime;
     m_sdtPeriod    : TDateTime;
     m_swDayMask    : Word;
     m_sdwMonthMask : Dword;
     m_sbyEnable    : Byte;
     m_sbyPause     : Byte;
     m_sbyFindData  : Byte;
     m_snDeepFind   : Byte;
     m_nSrvWarning  : Integer;
     //Commands  : CCOMMANDS;
    End;
    PSQWERYMDL = ^SQWERYMDL;
    SQWERYMDLS = packed record
     Count : Integer;
     Items : array of SQWERYMDL;
    End;
    SQWERYVM = packed record
     m_snID    : Integer;
     m_snCLID  : Integer;
     m_snSRVID : Integer;
     m_snVMID  : Integer;
     m_snMID   : Integer;
     m_snTPID  : Integer;
     m_snPID   : Integer;
     m_sName   : String[150];
     Commands  : CCOMMANDS;
     Item      : SQWERYMDLS;
    End;
    SQWERYVMS = packed record
     Count : Integer;
     Items : array of SQWERYVM;
    End;
    SQWERYSRV = packed record
     m_snID     : Integer;
     m_snAID    : Integer;
     m_snSRVID  : Integer;
     m_sName    : String[30];
     m_sbyEnable: Byte;
     m_nSrvWarning : Integer;
     Item      : SQWERYVMS;
    End;
    SQWERYSRVS = packed record
     Count : Integer;
     Items : array of SQWERYSRV;
    End;

    SQWERYMDLCOMM = packed record
     m_swABOID : Integer;
     m_swVMID  : Integer;
     m_swGID   : Integer;
     m_swMID   : Integer;
     m_swPID   : Integer;
     m_swTMID  : Integer;
     m_sName   : String;
     Commands  : CCOMMANDS;
     QweryMDLS : SQWERYMDLS;
    End;
     SQWERYMDLCOMMS= packed record
     Count : Integer;
     Items : array of SQWERYMDLCOMM;
    End;
    SQWERYCMDID = packed record
     //m_snRID   : Integer;
     m_snABOID : Integer;   //ID DOMA
     m_snSRVID : Integer;   //ID GROUP
     m_snCLID  : Integer;   //Kol-vo опрошенных
     m_snCLSID : Integer;   //Kol-vo не опрошенных
     m_snCmdID : Integer;   //Команда о состоянии
     m_snVMID  : Integer;   //Номер порта
     m_snMID   : Integer;
     m_sdtBegin: TDatetime; //Начало опроса
     m_sdtEnd  : TDatetime; //Конец опроса
     m_snPrmID : Integer;
     m_snResult: Integer;
    End;
    SL3SCHEMTABLE = packed record
     m_swID          : Integer;
     m_swNodeNum     : Integer;
     m_swSubNodeNum  : Integer;
     m_sNodeName     : String;
     m_sPathToFile   : String;
    End;
    SL3SCHEMTABLES = packed record
     Count           : Integer;
     Items           : array of SL3SCHEMTABLE;
    End;
    SMYRECTTYPE = packed record
      X, Y           : Integer;
      Width, Height  : Integer;
    End;
    SL3SCHEMPOINTER = packed record
     m_nFormPointer  : TForm;
     m_nBFWidth      : integer;
     m_nBFHeight     : integer;
     m_nCompSizes    : array of SMYRECTTYPE;
     m_nSchemID      : integer;
     m_nAktLimit     : double;
     m_nReaLimit     : double;
     m_nFormula      : string;
     m_nCMDIDList    : array of integer;
     m_nVMIDList     : array of integer;
     m_nVMIDSum      : array of integer;
     m_nLabelPoint   : array of TLabel;
     m_nPrBars       : array of TAdvProgressBar;
    End;
    PSL3SCHEMPOINTER = ^SL3SCHEMPOINTER;
    SL3LIGHTSTRUCT = packed record
     m_nHDOn         : Integer;
     m_nMDOn         : Integer;
     m_nHDOff        : Integer;
     m_nMDOff        : Integer;
     m_nHR1On        : Integer;
     m_nMR1On        : Integer;
     m_nHR1Off       : Integer;
     m_nMR1Off       : Integer;
     m_nHR2On        : Integer;
     m_nMR2On        : Integer;
     m_nHR2Off       : Integer;
     m_nMR2Off       : Integer;
     m_nDAuto        : Boolean;
     m_nDChecked     : Boolean;
     m_nDCHange      : Boolean;
     m_nR1Auto       : Boolean;
     m_nR1Checked    : Boolean;
     m_nR1Change     : Boolean;
    end;
    SL3TECHMTZREPORTSDATA = packed record
     m_nVMID         : Integer;
     m_nKPName       : String;
     m_nFiderName    : String;
     m_nKTransform   : Double;
     m_sTpNum        : String;
    end;
    SL3TECHMTZREPORTSDATAS = packed record
      Count          : Integer;
      Items          : array of SL3TECHMTZREPORTSDATA;
    end;
    STRINGRECORD = packed record
      m_nString      : String;
    end;
    SL3ARRAYOFSTRING  = packed record
      Count          : Integer;
      Items          : array of STRINGRECORD;
    end;
    _WORD = word;
    STRPSUMMVEDOM = packed record
      m_nAbons       : array of integer;
      m_nAllKEn      : array [0..3] of boolean;
      m_nAllEP       : array [0..7] of boolean;
      m_nAllEM       : array [0..7] of boolean;
      m_nAllRP       : array [0..7] of boolean;
      m_nAllRM       : array [0..7] of boolean;
      m_nAllPowEP    : array [0..5] of boolean;
      m_nAllPowEM    : array [0..5] of boolean;
      m_nAllPowRP    : array [0..3] of boolean;
      m_nAllPowRM    : array [0..3] of boolean;
    end;
    
    CE9STKMonthStruct = packed record
      Energy0 : Double;
      Energy1 : Double;
      Energy2 : Double;
      Energy3 : Double;
      Date    : TDateTime;
    end;

    CE9STKPowerStr = packed record
      Value   : Double;
      Date    : TDateTime;
    end;
    
    CE9STKPowerBuf = packed record
      LASTnum : integer;
      LASTuk  : integer;
      buf     : array [0..2999] of CE9STKPowerStr;
    end;

    SHOUSEGEN = packed record
      m_sKSP               : String[10];
      m_sMarshNumber       : String[10];
      m_sKodSysBalance     : String[10];
      m_sStreet            : String[250];
      m_sPhone             : String[30];
      m_sAbonName          : String[50];
      m_sVmName            : String[50];
      m_swABOID            : Integer;
      m_swPortID           : Integer;
      m_sbyProtID          : Integer;
      m_sbyMeterType       : Integer;
      m_snFirstKvartNumber : Integer;
      m_snEndKvartNumber   : Integer;
      m_snAmBal1           : Integer;
      m_snAmBal2           : Integer;
      m_snAmBal3           : Integer;
      m_snAmTeploUch       : Integer;
      m_nUSPDType          : Integer;
      m_nKvarUchType       : Integer;
      m_nNKvarUchType      : Integer;
      m_nTeploType         : Integer;
      m_nIsModem           : Integer;
      m_blEnable           : Boolean;
      m_sdtBegin           : TDateTime;
      m_sdtEnd             : TDateTime;
      m_sdtPeriod          : TDateTime;
      m_strClsEnable       : String;
    End;

    SHouseGenMeter = packed record
      m_swABOID : Integer;
      m_swPortID : Integer;
      id    : Integer;
      mes   : String;    //0
      res   : String;    //0
      nasp  : String;    //1
      tp    : String;    //1
      gors  : String;    //2
      ulica : String;    //3
      dom   : String;    //4
      korp  : String;    //5
      kvar  : String;    //6
      lics  : String;    //7
      fam   : String;    //8
      imya  : String;    //9
      otch  : String;    //10
      zavno :  String;   //11
      typepu   : String; //12
      typeuspd : String; //13
      typezvaz : String; //14
      nomerdoz : String; //15
      typeabo  : String; //16
      nomertu : String;  //17
      field1  : String;
      field2  : String;
      field3  : String;
      field4  : String;
      field5  : String;
      field6  : String;
      field7  : String;
      mesID   : Integer;
      resID   : Integer;
      naspID  : Integer;
      ulicaID : Integer;
      aboID   : Integer;
      mtID    : Integer;
      raycode : String;
      ki      : Double;
      ku      : Double;
      idchannel: String;
      idtariff : String;
      house   : String;    //ДЛЯ ТП И УСТРОЙСТВ ССДУ КУБ И ТД
      kv      : String;    //ДЛЯ ТП И УСТРОЙСТВ ССДУ КУБ И ТД
      m_snFirstKvartNumber:Integer;
      m_snEndKvartNumber:Integer;
      m_snBalanseNumber:Integer;
      m_snNoBalanseNumber:Integer;
      m_snNoNoBalanseNumber:Integer;

    End;


    FTMET = packed record
     Vp,Mp,Qp,Tp : Single;
     Vo,Mo,Qo,Tob : Single;
     Time,TimeErr: Single;
    End;

    //-----------------------данные-для-баланса--------------------------------------
    MEASUREBALANSREP = packed record
      id_meter        : Integer;
      t0              : Double;
      t1              : Double;
      t2              : Double;
      t3              : Double;
      t4              : Double;
      datatime        : TDateTime;
    End;
	 //--------------------------дома--филиала-----------------------------------------
     REGIONHOUSELIST = packed record
      houseId        : Integer;
      town           : String;
      ulica          : String;
      house          : String;
      korpus         : String;
      noDataMeter    : String;
      noDataCount    : Integer;
      region         : String;

    End;
    //-------------------------------------------------------------------------------

    SL3VMNAMETAG = packed record
     m_swVMID        : WORD;
     m_sMeterName    : String[150];
    end;
    PSL3VMNAMETAG =^ SL3VMNAMETAG;
    SL3VMNAMETAGS = packed record
     Count : Integer;
     Items : array of SL3VMNAMETAG;
    End;

    TABR = class
      IDREGION : integer;
      REGION   : string[50];
      IDDEPART : integer;
      DEPART   : string[50];
      Access   : boolean;
    end;

    // Права доступа текущего пользователя
    TUserPermission = class(TObject)
      IDUser             : Integer;
      NameUser           : string;
      DataEditor         : Boolean;    // chbm_sbyPrmDE
      ParameterEditor    : Boolean;    // chbm_sbyPrmPE
      QueryEditor        : Boolean;    // chbm_sbyPrmQE
      ChannelEditor      : Boolean;    // chbm_sbyPrmCE
      GroupEditor        : Boolean;    // chbm_sbyPrmGE
      TariffEditor       : Boolean;    // chbm_sbyPrmTE
      ConectionEditor    : Boolean;    // chbm_sbyPrmCNE
      PermissionEditor   : Boolean;    // chbm_sbyPrmPRE
      GeneralResolution  : Boolean;    // chbm_sbyEnable
      PermissQueryGroup  : Boolean;    // chbm_sbyQryGrp
      AccessByRegion     : Boolean;    // chbm_sbyAccReg
      private
        ABR  : TABR;
        procedure ClearABRList;
        procedure GetUserPermissionData(UserID: Integer; var ACCESREG: string);
        procedure SetUserPermissionData(UserID: Integer; ACCESREG: string);
        procedure DecodeACCESREG(ACCESREG : string);
        function EncodeACCESREG: string;
      public
        ABRList : TList;
        constructor Create;
        destructor Destroy; override;
        procedure GetUserData(ID : integer);
        procedure SetUserData(ID : integer);
        function AccessAllowed(IDRegion, IDDepart : integer): Boolean;
    end;

var
      CurrentStateMeter : integer;
      UserPermission : TUserPermission;
    
    function EndianSwap(_Value : DWORD) : DWORD; // преобразование BigEndian <-> LittleEndian
    procedure ClearListAndFree(var aList :TThreadList);
    procedure ClearListAndFreeIndex(var aList :TThreadList;Index:Integer);
    procedure ClearListAndFreeD(var aList :TThreadList);

implementation

uses utlDB;

procedure CL2Pulls.clear;
Begin
    if(item<>nil) then
      item.Clear;
End;

destructor CL2Pulls.Destroy;
begin
  ClearListAndFree(item);
  inherited;
end;


{*******************************************************************************
 * Преобразование BigEndian <-> LittleEndian
 * @param _Value : DWORD
 * @return DWORD
 ******************************************************************************}
function EndianSwap(_Value : DWORD) : DWORD;
var
  l_pDW : array [0..3] of BYTE absolute _Value;
  l_tpDW: array [0..3] of BYTE absolute Result;
begin
  l_tpDW[3] := l_pDW[0];
  l_tpDW[2] := l_pDW[1];
  l_tpDW[1] := l_pDW[2];
  l_tpDW[0] := l_pDW[3];
end;

procedure ClearListAndFree(var aList :TThreadList);
var
  vList :TList;
  I :Integer;
begin
  if aList = nil then Exit;

  vList := aList.LockList;
  for I := 0 to Pred(vList.Count) do
    if vList[I] <> nil then
     // FreeAndNIl(TObject(vList[I])); //.Free
     TObject(vList[I]).Free;


  aList.UnlockList();
  FreeAndNil(aList);
end;


procedure ClearListAndFreeIndex(var aList :TThreadList;Index:Integer);
var
  vList :TList;
  I :Integer;
begin
  if aList = nil then Exit;

  vList := aList.LockList;
//  for I := 0 to Pred(vList.Count) do
    if vList[Index] <> nil then
     TObject(vList[Index]).Free;
  aList.UnlockList();
//  FreeAndNil(aList);
end;

procedure ClearListAndFreeD(var aList :TThreadList);
var
  vList :TList;
  I :Integer;
begin
  if aList = nil then Exit;

  vList := aList.LockList;
  for I := 0 to Pred(vList.Count) do
    if vList[I] <> nil then
     begin
      Dispose(vList[I]);
      vList[I]:=nil;
     end;

  aList.UnlockList();
  FreeAndNil(aList);
end;

{ QUERYGROUP }

destructor QUERYGROUP.Destroy;
begin
  ClearListAndFree(itemParam);
  ClearListAndFree(itemAbon);
  inherited;
end;

{ TUserPermission }

constructor TUserPermission.Create;
begin
  ABRList := TList.Create;
end;

destructor TUserPermission.Destroy;
begin
  ClearABRList;
  ABRList.Destroy;
  inherited;  
end;

procedure TUserPermission.ClearABRList;
var i    : integer;
    ABR  : TABR;
begin
  if Assigned(ABRList) then begin
    for i := 0 to ABRList.Count -1 do begin
      ABR := TABR(ABRList.items[i]);
      if Assigned(ABR) then FreeAndNil(ABR);
    end;
    ABRList.Clear;
  end;
end;


procedure TUserPermission.GetUserData(ID : integer);
var ACCESREG : string;
begin
  ClearABRList;
  IDUser := ID;
  GetUserPermissionData(IDUser, ACCESREG);
  DecodeACCESREG(ACCESREG);
end;


procedure TUserPermission.SetUserData(ID : integer);
var s : string;
begin
  s := EncodeACCESREG;
  SetUserPermissionData(ID, s);
end;


procedure TUserPermission.DecodeACCESREG(ACCESREG: string);
var i            : Integer;
    sReg, sR, s0 : string;
    regin, rayon : Integer;
    ABR          : TABR;
begin
  for i := 0 to ABRList.Count-1 do begin
    ABR := TABR(ABRList.items[i]);
    ABR.Access := False;
  end;
  sReg := '';
  if Trim(ACCESREG) = '' then exit;
  for i:= 1 to length(ACCESREG) do
    if ACCESREG[i] <> ' ' then sReg := sReg + ACCESREG[i];
  if sReg[length(sReg)] <> ';' then sReg := sReg + ';';
  while Pos(';', sReg) <> 0 do begin
    sR := Copy(sReg, 1, Pos(';', sReg)-1);
    delete(sReg, 1, Pos(';', sReg));
    s0 := Copy(sR, 1, Pos(',', sR)-1);
    if Length(Trim(s0)) > 0 then begin
      delete(sR, 1, Pos(',', sR));
      regin := StrToInt(Trim(s0));
      if sR[length(sR)] <> ',' then sR := sR + ',';
      while Pos(',', sR) <> 0 do begin
        s0 := Copy(sR, 1, Pos(',', sR)-1);
        delete(sR, 1, Pos(',', sR));
        rayon := StrToInt(Trim(s0));
        for i := 0 to ABRList.Count-1 do begin
          ABR := TABR(ABRList.items[i]);
          if (ABR.IDREGION = regin) and (ABR.IDDEPART = rayon) then
            ABR.Access := True;
        end;
      end;
    end;
  end;

end;

function ToBool(i : Integer):Boolean;
begin
  if i = 0 then Result := False
  else Result := True;
end;

function FromBool(B : Boolean):Integer;
begin
  if B then Result := 1
  else Result := 0;
end;

procedure TUserPermission.GetUserPermissionData(UserID: Integer; var ACCESREG: string);
Var strSQL  : String;
    res     : Boolean;
    nCount  : Integer;
    ABR     : TABR;
begin
  res := False;
  strSQL := 'SELECT L3R.M_NREGIONID IDREGION, L3R.M_NREGNM REGION, ' +
            '       L3D.M_SWDEPID IDDEPART, L3D.M_SNAME DEPART ' +
            'FROM SL3REGION L3R, SL3DEPARTAMENT L3D ' +
            'WHERE M_SBYENABLE = 1 ' +
            '  AND L3D.M_SWREGION = L3R.M_NREGIONID ' +
            'ORDER BY L3R.M_NREGNM, L3D.M_SNAME ';
  if DBase.OpenQry(strSQL,nCount)=True then Begin
    ClearABRList;
    res := True;
    while not DBase.IBQuery.Eof do Begin
      with DBase.IBQuery do  Begin
        ABR := TABR.Create;
        ABR.IDREGION := FieldByName('IDREGION').AsInteger;
        ABR.REGION := FieldByName('REGION').AsString;
        ABR.IDDEPART := FieldByName('IDDEPART').AsInteger;
        ABR.DEPART := FieldByName('DEPART').AsString;
        ABRList.Add(ABR);
        Next;
      End;
    End;
  End;
  strSQL := 'SELECT M_STRSHNAME NAME, M_SBYPRMDE, M_SBYPRMPE, M_SBYPRMQE, M_SBYPRMCE, ' +
            '       M_SBYPRMGE, M_SBYPRMTE, M_SBYPRMCNE, M_SBYPRMPRE, M_SBYENABLE, ' +
            '       M_SBYQRYGRP, M_SBYACCREG, M_SACCESREG ACCESREG ' +
            'FROM SUSERTAG ' +
            'WHERE M_SWID = ' + IntToStr(UserID);
  if DBase.OpenQry(strSQL,nCount)=True then Begin
    NameUser := DBase.IBQuery.FieldByName('NAME').AsString;
    DataEditor        := ToBool(DBase.IBQuery.FieldByName('M_SBYPRMDE').AsInteger);
    ParameterEditor   := ToBool(DBase.IBQuery.FieldByName('M_SBYPRMPE').AsInteger);
    QueryEditor       := ToBool(DBase.IBQuery.FieldByName('M_SBYPRMQE').AsInteger);
    ChannelEditor     := ToBool(DBase.IBQuery.FieldByName('M_SBYPRMCE').AsInteger);
    GroupEditor       := ToBool(DBase.IBQuery.FieldByName('M_SBYPRMGE').AsInteger);
    TariffEditor      := ToBool(DBase.IBQuery.FieldByName('M_SBYPRMTE').AsInteger);
    ConectionEditor   := ToBool(DBase.IBQuery.FieldByName('M_SBYPRMCNE').AsInteger);
    PermissionEditor  := ToBool(DBase.IBQuery.FieldByName('M_SBYPRMPRE').AsInteger);
    GeneralResolution := ToBool(DBase.IBQuery.FieldByName('M_SBYENABLE').AsInteger);
    PermissQueryGroup := ToBool(DBase.IBQuery.FieldByName('M_SBYQRYGRP').AsInteger);
    AccessByRegion    := ToBool(DBase.IBQuery.FieldByName('M_SBYACCREG').AsInteger);
    ACCESREG      := DBase.IBQuery.FieldByName('ACCESREG').AsString;
  end;
end;

procedure TUserPermission.SetUserPermissionData(UserID: Integer; ACCESREG: string);
Var strSQL  : String;
begin
    strSQL := 'UPDATE OR INSERT INTO SUSERTAG ' +
              '  (M_SWID, M_SBYPRMDE, M_SBYPRMPE, M_SBYPRMQE, M_SBYPRMCE, ' +
              '   M_SBYPRMGE, M_SBYPRMTE, M_SBYPRMCNE, M_SBYPRMPRE, M_SBYENABLE, ' +
              '   M_SBYQRYGRP, M_SBYACCREG, M_SACCESREG) ' +
              'VALUES(:ID, :PRMDE, :PRMPE, :PRMQE, :PRMCE, ' +
              '       :PRMGE, :PRMTE, :PRMCNE, :PRMPRE, :ENABLE, ' +
              '       :QRYGRP, :ACCREG, :ACCESREG) ' +
              'MATCHING (M_SWID) ';
    DBase.IBQuery.SQL.Clear;
    DBase.IBQuery.SQL.Text := strSQL;
    DBase.IBQuery.ParamByName('ID').AsInteger := UserID;
    DBase.IBQuery.ParamByName('PRMDE').AsInteger  := FromBool(DataEditor);
    DBase.IBQuery.ParamByName('PRMPE').AsInteger  := FromBool(ParameterEditor);
    DBase.IBQuery.ParamByName('PRMQE').AsInteger  := FromBool(QueryEditor);
    DBase.IBQuery.ParamByName('PRMCE').AsInteger  := FromBool(ChannelEditor);
    DBase.IBQuery.ParamByName('PRMGE').AsInteger  := FromBool(GroupEditor);
    DBase.IBQuery.ParamByName('PRMTE').AsInteger  := FromBool(TariffEditor);
    DBase.IBQuery.ParamByName('PRMCNE').AsInteger := FromBool(ConectionEditor);
    DBase.IBQuery.ParamByName('PRMPRE').AsInteger := FromBool(PermissionEditor);
    DBase.IBQuery.ParamByName('ENABLE').AsInteger := FromBool(GeneralResolution);
    DBase.IBQuery.ParamByName('QRYGRP').AsInteger := FromBool(PermissQueryGroup);
    DBase.IBQuery.ParamByName('ACCREG').AsInteger := FromBool(AccessByRegion);
    DBase.IBQuery.ParamByName('ACCESREG').AsString := ACCESREG;
    DBase.IBQuery.ExecSQL;
   // запись в базу
end;

function TUserPermission.EncodeACCESREG: string;
var i       : Integer;
    s0      : string;
    old_reg : Integer;
    fst_sv  : Boolean;
    ABR     : TABR;
begin
  s0 := '';
  ABR := TABR(ABRList.items[0]);
  old_reg := ABR.IDREGION;
  if ABR.Access then begin
    s0 := s0 + IntToStr(ABR.IDREGION) + ',' + IntToStr(ABR.IDDEPART);
    fst_sv := True;
  end else fst_sv := False;

  for i := 1 to ABRList.Count-1 do begin
    ABR := TABR(ABRList.items[i]);
    if ABR.IDREGION <> old_reg then begin
      fst_sv := False;
      old_reg := ABR.IDREGION;
      if length(s0) <> 0 then s0 := s0 + ';';
    end;
    if ABR.Access then begin
      if fst_sv then begin
        s0 := s0 + ',' + IntToStr(ABR.IDDEPART);
      end else begin
        s0 := s0 + IntToStr(ABR.IDREGION) + ',' + IntToStr(ABR.IDDEPART);
        fst_sv := true;
      end;
    end;
  end;
  Result := s0;
end;

function TUserPermission.AccessAllowed(IDRegion,
  IDDepart: integer): Boolean;   // если вместо IDDepart приходит -1, то проверяем только IDREGION
var i : Integer;
begin
  Result := False;
  for i := 0 to ABRList.Count-1 do begin
    ABR := TABR(ABRList.items[i]);
    if IDDepart = (-1) then begin
      if (ABR.IDREGION = IDRegion) then begin
      if ABR.Access then Result := True;
    end;
    end else begin
      if (ABR.IDREGION = IDRegion) and (ABR.IDDEPART = IDDepart) then begin
        if ABR.Access then Result := True;
      end;
    end;
  end;
end;

initialization
  CurrentStateMeter:= -1;
end.
