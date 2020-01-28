unit fLogTypeCommand;

interface

uses Classes, Sysutils, Graphics;

type
  lcRec = record
    ID    : integer;
    GRP   : integer;
    EVNT  : integer;
  end;

const
  // CE - CommandExecuted    Выполнена комманда:      unit knsl2fqwerymdl
  ColorGroup120CE = clNavy;
  lcCEInitializeAllGroupParameters : lcRec =  // Инициализировать все параметры группы
    (ID : 60; GRP : 120; EVNT : 120);
  lcCEStop : lcRec =  // Остановить
    (ID : 61; GRP : 120; EVNT : 121);
  lcCEInterview : lcRec =  // Опросить
    (ID : 62; GRP : 120; EVNT : 122);
  lcCEApplySettingsForParameter : lcRec =  // Применить настройки для параметра
    (ID : 63; GRP : 120; EVNT : 123);
  lcCEPollingInProgress : lcRec =  // Выполняется опрос
    (ID : 64; GRP : 120; EVNT : 124);
  lcCEPollWasSuccessful : lcRec =  // Опрос выполнен успешно
    (ID : 65; GRP : 120; EVNT : 125);
  lcCESurveyWasPerformedWithErrorERROR_RUNNABLE_NILL : lcRec =  // Опрос выполнен с ошибкой: "ERROR RUNNABLE NILL"
    (ID : 66; GRP : 120; EVNT : 126);
  lcCEPollIsForcedToStop : lcRec =  // Опрос принудительно остановлен
    (ID : 67; GRP : 120; EVNT : 127);
  lcCEStopOperationsForAllGroups : lcRec =  // Остановить операции по всем группам
    (ID : 68; GRP : 120; EVNT : 128);

  // PC - Parameter Change    Изменение параметра        unit knsl2fqwerymdl;
  ColorGroup121PC = clGreen;
  lcPCBeginningSurveyPeriod : lcRec =  // Начало периода опроса
    (ID : 168; GRP : 121; EVNT : 0);
  lcPCEndingSurveyPeriod : lcRec =  // Окончание периода опроса
    (ID : 169; GRP : 121; EVNT : 1);
  lcPCPollingPeriod : lcRec =  // Период опроса
    (ID : 170; GRP : 121; EVNT : 2);
  lcPCAllowAutoUpload : lcRec =  // Разрешить автовыгрузку
    (ID : 171; GRP : 121; EVNT : 3);
  lcPCTakeIntoAccountDaysOfTheWeek : lcRec =  // Учитывать дни недели
    (ID : 172; GRP : 121; EVNT : 4);
  lcPCTakeIntoAccountDaysOfTheMonth : lcRec =  // Учитывать дни месяца
    (ID : 173; GRP : 121; EVNT : 5);
  lcPCRunWithStatus : lcRec =  // Запускать со статусом
    (ID : 174; GRP : 121; EVNT : 6);
  lcPCCriticalErrorRate : lcRec =  // Критический процент ошибок
    (ID : 175; GRP : 121; EVNT : 7);
  lcPCSearchDepth : lcRec =  // Глубина поиска
    (ID : 176; GRP : 121; EVNT : 8);
  lcPCAllowAutoPoll : lcRec =  // Разрешить автоматический опрос
    (ID : 177; GRP : 121; EVNT : 9);
  lcPCPause : lcRec =  // Пауза
    (ID : 178; GRP : 121; EVNT : 10);
  lcPCSearchUpdate : lcRec =  // Поиск/обновление
    (ID : 179; GRP : 121; EVNT : 11);
  lcPCUnloadingDepth : lcRec =  // Глубина выгрузки
    (ID : 180; GRP : 121; EVNT : 12);

  // CED - Channel Editor    Редактор каналов        unit knsl5module;
  ColorGroup130CE = $00FAF1E9;  // ?
  lcCEDSave : lcRec =  // Записать
    (ID : 200; GRP : 130; EVNT : 0);
  lcCEDRead : lcRec =  // Прочитать
    (ID : 201; GRP : 130; EVNT : 1);
  lcCEDCreate : lcRec =  // Создать
    (ID : 202; GRP : 130; EVNT : 2);
  lcCEDClone : lcRec =  // Клонировать
    (ID : 203; GRP : 130; EVNT : 3);
  lcCEDDeleteRecord : lcRec =  // Удалить запись
    (ID : 204; GRP : 130; EVNT : 4);
  lcCEDDeleteAll : lcRec =  // Удалить всё
    (ID : 205; GRP : 130; EVNT : 5);
  lcCEDExportToExcel : lcRec =  // Экспортировать в Excel
    (ID : 206; GRP : 130; EVNT : 6);
  lcCEDInitializeChannel : lcRec =  // Инициализировать каналы
    (ID : 207; GRP : 130; EVNT : 7);
  lcCEDReleaseChannels : lcRec =  // Освободить каналы
    (ID : 208; GRP : 130; EVNT : 8);
  lcCEDDisplay : lcRec =  // Отображение
    (ID : 209; GRP : 130; EVNT : 9);
  lcCEDTechnologicalInfo : lcRec =  // Технологическая информация
    (ID : 210; GRP : 130; EVNT : 10);
  // CEDPDm - Channel Editor: Pull Desc    Редактор каналов: Получить Описание        unit knsl5module;
    ColorGroup131CE = $10EAE1D9;  // ?
  lcCEDPDmSave : lcRec =  // Записать
    (ID : 250; GRP : 131; EVNT : 0);
  lcCEDPDmRead : lcRec =  // Прочитать
    (ID : 251; GRP : 131; EVNT : 1);
  lcCEDPDmCreate : lcRec =  // Создать
    (ID : 252; GRP : 131; EVNT : 2);
  lcCEDPDmClone : lcRec =  // Клонировать
    (ID : 253; GRP : 131; EVNT : 3);
  lcCEDPDmDeleteRecord : lcRec =  // Удалить запись
    (ID : 254; GRP : 131; EVNT : 4);
  lcCEDPDmDeleteAll : lcRec =  // Удалить всё
    (ID : 255; GRP : 131; EVNT : 5);
  lcCEDPDmDisplay : lcRec =  // Отображение
    (ID : 256; GRP : 131; EVNT : 6);
  // CEDPMm - Channel Editor: Pull Menu    Редактор каналов: Получить Меню        unit knsl5module;
    ColorGroup132CE = $20DAD1C9;  // ?
  lcCEDPMmSave : lcRec =  // Записать
    (ID : 260; GRP : 132; EVNT : 0);
  lcCEDPMmRead : lcRec =  // Прочитать
    (ID : 261; GRP : 132; EVNT : 1);
  lcCEDPMmCreate : lcRec =  // Создать
    (ID : 262; GRP : 132; EVNT : 2);
  lcCEDPMmClone : lcRec =  // Клонировать
    (ID : 263; GRP : 132; EVNT : 3);
  lcCEDPMmDeleteRecord : lcRec =  // Удалить запись
    (ID : 264; GRP : 132; EVNT : 4);
  lcCEDPMmDeleteAll : lcRec =  // Удалить всё
    (ID : 265; GRP : 132; EVNT : 5);
  lcCEDPMmDisplay : lcRec =  // Отображение
    (ID : 266; GRP : 132; EVNT : 6);
{    ColorGroup133CE = $20C0C1B9;  // ?
  lcCECPMmSave : lcRec =  // Записать
    (ID : 270; GRP : 133; EVNT : 0);
  lcCECPMmRead : lcRec =  // Прочитать
    (ID : 271; GRP : 133; EVNT : 1);
  lcCECPMmCreate : lcRec =  // Создать
    (ID : 272; GRP : 133; EVNT : 2);
  lcCECPMmClone : lcRec =  // Клонировать
    (ID : 273; GRP : 133; EVNT : 3);
  lcCECPMmDeleteRecord : lcRec =  // Удалить запись
    (ID : 274; GRP : 133; EVNT : 4);
  lcCECPMmDeleteAll : lcRec =  // Удалить всё
    (ID : 275; GRP : 133; EVNT : 5);
  lcCECPMmExportToExcel : lcRec =  // Экспортировать в Excel
    (ID : 276; GRP : 133; EVNT : 6);
  lcCECPMmInitializeChannel : lcRec =  // Инициализировать каналы
    (ID : 277; GRP : 133; EVNT : 7);
  lcCECPMmReleaseChannels : lcRec =  // Освободить каналы
    (ID : 278; GRP : 133; EVNT : 8);
  lcCECPMmDisplay : lcRec =  // Отображение
    (ID : 279; GRP : 133; EVNT : 9);
  lcCECPMmTechnologicalInfo : lcRec =  // Технологическая информация
    (ID : 280; GRP : 133; EVNT : 10); }

  // ME - Meter Editor   Редактор счетчиков        unit knsl5module;
     ColorGroup140ME = $20C0C1B9;  // ?
  lcMESave : lcRec =  // Записать
    (ID : 300; GRP : 140; EVNT : 0);
  lcMERead : lcRec =  // Прочитать
    (ID : 301; GRP : 140; EVNT : 1);
  lcMECreate : lcRec =  // Создать
    (ID : 302; GRP : 140; EVNT : 2);
  lcMEClone : lcRec =  // Клонировать
    (ID : 303; GRP : 140; EVNT : 3);
  lcMEDeleteRecord : lcRec =  // Удалить запись
    (ID : 304; GRP : 140; EVNT : 4);
  lcMEDeleteAll : lcRec =  // Удалить всё
    (ID : 305; GRP : 140; EVNT : 5);
  lcMEExportToExcel : lcRec =  // Экспортировать в Excel
    (ID : 306; GRP : 140; EVNT : 6);
  lcMEInitializeDevices : lcRec =  // Инициализировать устройства
    (ID : 307; GRP : 140; EVNT : 7);
  lcMECreateMeters : lcRec =  // Создать счетчики ?
    (ID : 308; GRP : 140; EVNT : 8);
  lcMEDisplay : lcRec =  // Отображение
    (ID : 309; GRP : 140; EVNT : 9);
  lcMETechnologicalInfo : lcRec =  // Технологическая информация
    (ID : 310; GRP : 140; EVNT : 10);

  // QE - Query Editor   Редактор запросов        unit knsl5module;
     ColorGroup150QE = $20C0C1B9;  // ?
  lcQESave : lcRec =  // Записать
    (ID : 330; GRP : 150; EVNT : 0);
  lcQERead : lcRec =  // Прочитать
    (ID : 331; GRP : 150; EVNT : 1);
  lcQECreate : lcRec =  // Создать
    (ID : 332; GRP : 150; EVNT : 2);
  lcQEClone : lcRec =  // Клонировать
    (ID : 333; GRP : 150; EVNT : 3);
  lcQEDeleteRecord : lcRec =  // Удалить запись
    (ID : 334; GRP : 150; EVNT : 4);
  lcQEDeleteAll : lcRec =  // Удалить всё
    (ID : 335; GRP : 150; EVNT : 5);
  lcQEExportToExcel : lcRec =  // Экспортировать в Excel
    (ID : 336; GRP : 150; EVNT : 6);
  lcQEDisplay : lcRec =  // Отображение
    (ID : 337; GRP : 150; EVNT : 7);
  lcQETechnologicalInfo : lcRec =  // Технологическая информация
    (ID : 338; GRP : 150; EVNT : 8);

  // PE - Parameter Editor   Редактор параметров        unit knsl5module;
     ColorGroup155PE = $20A0A199;  // ?
  lcPESave : lcRec =  // Записать
    (ID : 350; GRP : 155; EVNT : 0);
  lcPERead : lcRec =  // Прочитать
    (ID : 351; GRP : 155; EVNT : 1);
  lcPECreate : lcRec =  // Создать
    (ID : 352; GRP : 155; EVNT : 2);
  lcPEClone : lcRec =  // Клонировать
    (ID : 353; GRP : 155; EVNT : 3);
  lcPEDeleteRecord : lcRec =  // Удалить запись
    (ID : 354; GRP : 155; EVNT : 4);
  lcPEDeleteAll : lcRec =  // Удалить всё
    (ID : 355; GRP : 155; EVNT : 5);
  lcPEExportToExcel : lcRec =  // Экспортировать в Excel
    (ID : 356; GRP : 155; EVNT : 6);
  lcPEDisplay : lcRec =  // Отображение
    (ID : 357; GRP : 155; EVNT : 7);
  lcPETechnologicalInfo : lcRec =  // Технологическая информация
    (ID : 358; GRP : 155; EVNT : 8);

  // GE - Group Editor : Sub  Редактор групп : Абоненты       unit knsl5module;
     ColorGroup160GES = $10909189;  // ?
  lcGESSave : lcRec =  // Записать
    (ID : 380; GRP : 160; EVNT : 0);
  lcGESRead : lcRec =  // Прочитать
    (ID : 381; GRP : 160; EVNT : 1);
  lcGESCreate : lcRec =  // Создать
    (ID : 382; GRP : 160; EVNT : 2);
  lcGESEdit : lcRec =  // Редактировать
    (ID : 383; GRP : 160; EVNT : 3);
  lcGESDeleteRecord : lcRec =  // Удалить запись
    (ID : 384; GRP : 160; EVNT : 4);
  lcGESDeleteAll : lcRec =  // Удалить всё
    (ID : 385; GRP : 160; EVNT : 5);
  lcGESExportToExcel : lcRec =  // Экспортировать в Excel
    (ID : 386; GRP : 160; EVNT : 6);
  lcGESInitializeGroups : lcRec =  // Инициализировать группы
    (ID : 387; GRP : 160; EVNT : 7);
  lcGESDisplay : lcRec =  // Отображение
    (ID : 388; GRP : 160; EVNT : 8);
  lcGESSaveChannelDataToWord : lcRec =  // Сохранить данные по каналам в Word
    (ID : 389; GRP : 160; EVNT : 9);
  lcGESRefreshChannels : lcRec =  // Обновить каналы
    (ID : 390; GRP : 160; EVNT : 10);
  lcGESTechnologicalInfo : lcRec =  // Технологическая информация
    (ID : 391; GRP : 160; EVNT : 11);

  // GEAPG - Group Editor : Account Point Groups  Редактор групп : Группы точек учета       unit knsl5module;
     ColorGroup161GEAPG = $10808179;  // ?
  lcGEAPGSave : lcRec =  // Записать
    (ID : 400; GRP : 161; EVNT : 0);
  lcGEAPGRead : lcRec =  // Прочитать
    (ID : 401; GRP : 161; EVNT : 1);
  lcGEAPGCreate : lcRec =  // Создать
    (ID : 402; GRP : 161; EVNT : 2);
  lcGEAPGClone : lcRec =  // Клонировать
    (ID : 403; GRP : 161; EVNT : 3);
  lcGEAPGDeleteRecord : lcRec =  // Удалить запись
    (ID : 404; GRP : 161; EVNT : 4);
  lcGEAPGDeleteAll : lcRec =  // Удалить всё
    (ID : 405; GRP : 161; EVNT : 5);
  lcGEAPGExportToExcel : lcRec =  // Экспортировать в Excel
    (ID : 406; GRP : 161; EVNT : 6);
  lcGEAPGInitializeGroups : lcRec =  // Инициализировать группы
    (ID : 407; GRP : 161; EVNT : 7);
  lcGEAPGDisplay : lcRec =  // Отображение
    (ID : 408; GRP : 161; EVNT : 8);
  lcGEAPGTechnologicalInfo : lcRec =  // Технологическая информация
    (ID : 409; GRP : 161; EVNT : 9);

  // GEAP - Group Editor : Account Points  Редактор групп : Точки учета       unit knsl5module;
     ColorGroup162GEAP = $09807169;  // ?
  lcGEAPSave : lcRec =  // Записать
    (ID : 420; GRP : 162; EVNT : 0);
  lcGEAPRead : lcRec =  // Прочитать
    (ID : 421; GRP : 162; EVNT : 1);
  lcGEAPCreate : lcRec =  // Создать
    (ID : 422; GRP : 162; EVNT : 2);
  lcGEAPClone : lcRec =  // Клонировать
    (ID : 423; GRP : 162; EVNT : 3);
  lcGEAPDeleteRecord : lcRec =  // Удалить запись
    (ID : 424; GRP : 162; EVNT : 4);
  lcGEAPDeleteAll : lcRec =  // Удалить всё
    (ID : 425; GRP : 162; EVNT : 5);
  lcGEAPExportToExcel : lcRec =  // Экспортировать в Excel
    (ID : 426; GRP : 162; EVNT : 6);
  lcGEAPInitializeGroups : lcRec =  // Инициализировать группы
    (ID : 427; GRP : 162; EVNT : 7);
  lcGEAPConnectMeter : lcRec =  // Подключить счетчик
    (ID : 428; GRP : 162; EVNT : 8);
  lcGEAPDisplay : lcRec =  // Отображение
    (ID : 429; GRP : 162; EVNT : 9);
  lcGEAPTechnologicalInfo : lcRec =  // Технологическая информация
    (ID : 430; GRP : 162; EVNT : 10);


  // MR - Meter Replacement  Замена счетчика       unit knsl5module;
     ColorGroup200MR = $2F120145;  // ?
  lcMRMoreThanOneAddress : lcRec =  // Более одного адреса
    (ID : 600; GRP : 200; EVNT : 0);
  lcMRAddedNewAddress : lcRec =  // Добавлен новый адрес
    (ID : 601; GRP : 200; EVNT : 1);
  lcMRLastNameChanged : lcRec =  // Изменена фамилия
    (ID : 602; GRP : 200; EVNT : 2);
  lcMRChangedFactoryNumber : lcRec =  // Изменен фабричный номер
    (ID : 603; GRP : 200; EVNT : 3);
  lcMRChangedAccount : lcRec =  // Изменен лицевой счет
    (ID : 604; GRP : 200; EVNT : 4);









  // ERR - Errors  Ошибки       Все модули
     ColorGroup200ERR = $2F2F2F2F;  // ?
  lcERRInaccessibleValue : lcRec =  // Попытка обращения к методам удаленного объекта
    (ID : 1000; GRP : 300; EVNT : 0);
  lcERRObjectIsNil : lcRec =  // Попытка обращения к методам не созданного объекта
    (ID : 1001; GRP : 300; EVNT : 1);


var IDCurrentUser      : integer;



implementation


//initialization


//finalization


end.
