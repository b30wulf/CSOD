unit utltypes;

interface
uses
   Windows, forms,Classes, SysUtils,SyncObjs,stdctrls,comctrls,Grids,mask,Db, ADODB;
type
    SMouseM = packed record
      LastX   : Integer;
      LastY   : Integer;
      dX, dY  : Integer;
    end;
    //Структура межмодульного сообщения
    PTTreeView      = ^TTreeView;
    //PTAdvStringGrid = ^TAdvStringGrid;
    PTComboBox      = ^TComboBox;
    PTForm          = ^TForm;
    PTMaskEdit      = ^TMaskEdit;
    PTEdit          = ^TEdit;
    PTLabel         = ^TLabel;
    PTADOQuery      = ^TADOQuery;
    PTDateTimePicker = ^TDateTimePicker;
    PTPageControl   = ^TPageControl;


    THandles = packed record
     m_sProcHandle   : THandle;
     m_sTHreadHandle : THandle;
    End;
    CDTTime = packed record
     Year  : Byte;
     Month : Byte;
     Day   : Byte;
     Hour  : Byte;
     Min   : Byte;
     Sec   : Byte;
    End;

    CVData = packed record
     dtTime : TDateTime;
     nTarif : Word;
     nSID   : Word;
     fValue : Double;
    End;
    PCVData =^ CVData;

    CTreeIndex = packed record
     PKey    : Integer;
     FKey    : Integer;
     PParam  : Integer;
     PParam1 : Integer;
     PParam2 : Integer;
     PParam3 : Integer;
     PParam4 : Integer;
    End;
    PCTreeIndex =^ CTreeIndex;
    CGDataSource = packed record
     PKey       : Integer;
     FKey       : Integer;
     FParam     : Integer;
     FParam1    : Integer;
     FParam2    : Integer;
     FParam3    : Integer;
     FParam4    : Integer;
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
     m_sbyInfo : array[0..50] of Byte;
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
     m_swID       : Integer;
     m_swVMID     : Integer;
     m_swCMDID    : Integer;
     m_swTID      : Integer;
     m_sTime      : TDateTime;
     m_byOutState : Byte;
     m_byInState  : Byte;
     //m_sfMin      : Double;
     //m_sfMax      : Double;
     m_sfValue    : Double;
    End;
    PCData=^ CCData;

    CCDatas = packed record
     Count : Integer;
     Items : array of CCData;
    End;
    PCCDatas =^ CCDatas;

    CGRMetaData = packed record
     m_sName      : String;
     m_sShName    : String;
     m_sEMet      : String;
    End;
    PCGRMetaData =^ CGRMetaData;


    CMessage = packed record
     m_swLen       : Word;
     m_swObjID     : Word;    //Сетевой адрес счётчика
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
    //Структура межмодульного сообщения(короткая)
    CHMessage = record
     m_swLen       : Word;
     m_swObjID     : Word;
     m_sbyFrom     : Byte;
     m_sbyFor      : Byte;
     m_sbyType     : Byte;
     m_sbyTypeIntID: Byte;
     m_sbyIntID    : Byte;
     m_sbyServerID : Byte;
     m_sbyDirID    : Byte;
     m_sbyInfo     : array[0..80] of Byte;
    end;
    //Примитив запроса
    CCOMMAND = packed record
     m_swID       : Word;
     m_swMID      : Word;
     m_swCmdID    : Word;
     m_swSpecc0   : Integer;
     m_swSpecc1   : Integer;
     m_swSpecc2   : Integer;
     m_sbyEnable  : Byte;
     m_sbyDirect  : Byte;
    End;
    PCCOMMAND =^ CCOMMAND;
    CCOMMANDS = packed record
     m_swAmCommand: Word;
     m_sCommand  : array of CCOMMAND;
    End;
    SL2TAG = packed record
     m_sbyID        : Word;
     m_sbyGroupID   : Byte;
     m_swVMID       : WORD;
     m_sbyPortID    : Byte;
     m_swMID        : WORD;
     m_sbyType      : Byte;
     m_sbyLocation  : Byte;
     m_sddFabNum    : string[26];
     m_sddPHAddres  : string[26];
     m_schPassword  : String[16];
     m_schName      : String[50];
     m_sbyRepMsg    : Byte;
     m_swRepTime    : Word;
     m_sfKI         : Double;
     m_sfKU         : Double;
     m_sfMeterKoeff : Double;
     m_swCurrQryTm  : Word;
     m_sPhone       : String[30];
     m_sbyModem     : Byte;
     m_sbyEnable    : Byte;
     m_swMinNKan    : Word;
     m_swMaxNKan    : Word;
    end;

    PSL2TAG =^ SL2TAG;
    SL2INITITAG = packed record
     m_sbyLayerID    : Byte;
     m_swAmMeter     : Word;
     m_sMeter        : array of SL2TAG;
    end;
    PSL2INITITAG =^ SL2INITITAG;

    SL2TAGREPORT = packed record
      m_sVMeterName : string;
      m_sddPHAddres : string;
      m_sbyType     : Byte;
      m_swVMID      : word;
      m_swMID       : word;
      m_sfKI        : Double;
      m_sfKU        : Double;
      m_sName       : string;
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
     m_sbyID       : Byte;
     m_sbyPortID   : Integer;
     m_schName     : String[50];
     m_sbyPortNum  : Integer;
     m_sbyType     : Byte;
     m_sbyProtID   : Byte;
     m_sbyControl  : Byte;
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
    end;
    PSL1TAG =^ SL1TAG;
    SL1INITITAG = packed record
     m_sbyLayerID  : Byte;
     Count : Byte;
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
     m_sbyGroupID    : Byte;
     m_swVMID        : WORD;
     m_sblIsConnect  : Boolean;
    end;
    PL3CONNECTION =^ L3CONNECTION;

    SL3PARAM = packed record
     m_swID          : WORD;
     m_swParamID     : WORD;
     m_sParamName    : String[30];
     m_sParamEI      : String[30];
    end;
    PSL3PARAM =^ SL3PARAM;

    //Таблица параметров вычислителя
    SL3PARAMS = packed record
     m_swID          : Word;
     m_swVMID        : WORD;
     m_swParamID     : WORD;
     m_sParamExpress : String[150];
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
    end;
    PSL3PARAMS =^ SL3PARAMS;

    //Таблица вычислителя
    SL3VMETERTAG = packed record
     m_swID          : Word;
     m_swMID         : WORD;
     m_sbyPortID     : WORD;
     m_sbyType       : WORD;
     m_sbyGroupID    : Byte;
     m_swVMID        : WORD;
     m_swAmParams    : WORD;
     m_sddPHAddres   : string[30];
     m_sMeterName    : String[80];
     m_sVMeterName   : String[80];
     m_sParams       : array of SL3PARAMS;
     m_sbyExport     : Byte;
     m_sbyEnable     : Byte;
    end;
    PSL3VMETERTAG =^ SL3VMETERTAG;

    
    //Таблица группы вычислителей
    SL3GROUPTAG = packed record
     m_sbyID         : Byte;
     m_sbyGroupID    : Byte;
     m_swAmVMeter    : Word;
     m_sbyEnable     : Byte;
     m_sGroupName    : String[100];
     m_sGroupExpress : String[100];
     m_sVMeters      : array of SL3VMETERTAG;
    end;
    PSL3GROUPTAG =^ SL3GROUPTAG;

    //Таблица инициализации L3
    SL3INITTAG = packed record
     m_sbyLayerID    : Byte;
     m_swAmGroup     : Word;
     m_sGroups       : array of SL3GROUPTAG;
    end;
    PSL3INITTAG =^ SL3INITTAG;

    QM_METER = packed record
     m_swID     : Word;
     m_swType   : Word;
     m_sName    : String[40];
     m_sComment : String[40];
    end;
    PQM_METER =^ QM_METER;
    QM_METERS = packed record
     m_swAmMeterType : Word;
     m_sMeterType    : array of QM_METER;
    end;

    QM_PARAM = packed record
     m_swID        : Word;
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
    end;
    PQM_PARAM =^ QM_PARAM;
    QM_PARAMS = packed record
     Count    : Word;
     Items    : array of QM_PARAM;
    end;
    QM_COMMAND = packed record
     m_swID      : Word;
     m_swType    : Word;
     m_swCMDID   : Word;
     m_sName     : string[40];
     m_swSpec0   : Integer;
     m_swSpec1   : Integer;
     m_swSpec2   : Integer;
     m_sblSaved  : Byte;
     m_sbyEnable : Byte;
     m_sbyDirect : Byte;
    end;
    PQM_COMMAND =^ QM_COMMAND;
    QM_COMMANDS = packed record
     m_swAmCommandType : Word;
     m_sCommandType    : array of QM_COMMAND;
    end;

    TM_TARIFF = packed record
     m_swID       : Word;
     m_swPTID     : Word;
     m_swTID      : Word;
     m_swTTID     : Word;
     m_sName      : String[100];
     m_dtTime0    : TDateTime;
     m_dtTime1    : TDateTime;
     m_sfKoeff    : Double;
     m_sbyEnable  : Byte;
    End;
    PTM_TARIFF =^ TM_TARIFF;
    TM_TARIFFS = packed record
     m_swID       : Word;
     m_swTTID     : Word;
     m_sName      : String[100];
     m_swCMDID    : Word;
     m_dtTime0    : TDateTime;
     m_dtTime1    : TDateTime;
     m_sbyEnable  : Byte;
     Count     : Word;
     Items     : array of TM_TARIFF;
    End;
    PTM_TARIFFS =^ TM_TARIFFS;
    TM_TARIFFSS = packed record
     Count     : Word;
     Items     : array of TM_TARIFFS;
    End;


    //Data Routing
    L3GRAPHDATA = packed record
     m_swID        : Word;
     m_swVMID      : Word;
     m_swCMDID     : Word;
     m_swSumm      : Double;
     m_sdtLastTime : TDateTime;
     m_sdtDate     : TDateTime;
     v             : array[0..47] of Double;
    end;
    PL3GRAPHDATA =^ L3GRAPHDATA;
    L3GRAPHDATAS = packed record
     Count         : Integer;
     Items         : array of L3GRAPHDATA;
    end;
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
     n_obj       : Word;
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
     m_swVMID  : Word;
     m_swTID   : Word;
     m_swCMDID : Word;
     m_swSID   : Word;
     m_sTime   : TDateTime;
     m_sfSvValue : Double;
     m_sfValue : Double;
     m_byOutState : Byte;
     m_byInState  : Byte;
    end;
    PL3CURRENTDATA =^ L3CURRENTDATA;
    L3CURRENTDATAS = packed record
     Count    : Word;
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
     blIsUpdate : Boolean;
     blError : Boolean;
    End;
    PCVToken =^ CVToken;

    //Примитив запроса
    CQueryPrimitive = packed record
     m_wLen       : Word;
     m_swMtrID    : Word;
     m_swParamID  : Word;
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
     m_swPRUSPDDevMax     : WORD;
     m_swPRUSPDCharDevMax : WORD;
     m_swPRUSPDCharKanMax : WORD;
    end;

    SL2USPDTYPE = packed record       // Запрос типа и характеристик УСПД
      m_swID           : DWORD;
      m_swUSPDID       : DWORD;
      m_sUSPDName      : string[32];  // УСПД, дата выпуска, номер версии
      m_sNameAdr       : string[32];  // Название и краткий адрес объекта
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
      m_sName          : String[32];   // название устройства
    end;

    SL2USPDEVEX = packed record          // Запрос списка поддерживаемых устройств
      m_swIdev         : WORD;         // елочисленный код устройства
      m_sName          : String;   // название устройства
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
      m_sStrAdr        : string[32];            // адреса узла сети
    end;

    SL2USPDCHARACTDEVEX = packed record      //Запрос характеристик подключенных устройств
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
      m_sNameKanal     : string[32];               // наименование ИК
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
     m_sWorkName     : string;
     m_sFirstSign    : string;
     m_sSecondSign   : string;
     m_sThirdSign    : string;
     m_sTelephon     : string;
     m_sEMail        : string;
     m_sNDogovor     : string;
     m_swColorCol    : integer;
     m_swColorRow    : integer;
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
     m_swAddres     : Integer;
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
     m_swID         : Integer;
     m_swVMID       : Word;
     m_swGroupID    : Word;
     m_swEventID    : Word;
     m_sdtEventTime : TDateTIme;
     m_sUser        : String[10];
     m_sbyEnable    : Byte;
    end;
    SEVENTTAGS = packed record
     Count         : Integer;
     Items         : array of SEVENTTAG;
    end;
    SQRYSDLTAG = packed record
     m_swID         : Integer;
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
     m_sPhoto      : String; 
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
      m_sbyPHAddres  : Byte;
      m_sbyPortID    : Byte;
    end;
    SPHADRANDCOMPRTS = packed record
      Count         : Integer;
      Items         : array of SPHADRANDCOMPRT;
    end;
    //----------------------------
implementation

end.
