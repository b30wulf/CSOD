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
  // CE - CommandExecuted    ��������� ��������:      unit knsl2fqwerymdl
  ColorGroup120CE = clNavy;
  lcCEInitializeAllGroupParameters : lcRec =  // ���������������� ��� ��������� ������
    (ID : 60; GRP : 120; EVNT : 120);
  lcCEStop : lcRec =  // ����������
    (ID : 61; GRP : 120; EVNT : 121);
  lcCEInterview : lcRec =  // ��������
    (ID : 62; GRP : 120; EVNT : 122);
  lcCEApplySettingsForParameter : lcRec =  // ��������� ��������� ��� ���������
    (ID : 63; GRP : 120; EVNT : 123);
  lcCEPollingInProgress : lcRec =  // ����������� �����
    (ID : 64; GRP : 120; EVNT : 124);
  lcCEPollWasSuccessful : lcRec =  // ����� �������� �������
    (ID : 65; GRP : 120; EVNT : 125);
  lcCESurveyWasPerformedWithErrorERROR_RUNNABLE_NILL : lcRec =  // ����� �������� � �������: "ERROR RUNNABLE NILL"
    (ID : 66; GRP : 120; EVNT : 126);
  lcCEPollIsForcedToStop : lcRec =  // ����� ������������� ����������
    (ID : 67; GRP : 120; EVNT : 127);
  lcCEStopOperationsForAllGroups : lcRec =  // ���������� �������� �� ���� �������
    (ID : 68; GRP : 120; EVNT : 128);

  // PC - Parameter Change    ��������� ���������        unit knsl2fqwerymdl;
  ColorGroup121PC = clGreen;
  lcPCBeginningSurveyPeriod : lcRec =  // ������ ������� ������
    (ID : 168; GRP : 121; EVNT : 0);
  lcPCEndingSurveyPeriod : lcRec =  // ��������� ������� ������
    (ID : 169; GRP : 121; EVNT : 1);
  lcPCPollingPeriod : lcRec =  // ������ ������
    (ID : 170; GRP : 121; EVNT : 2);
  lcPCAllowAutoUpload : lcRec =  // ��������� ������������
    (ID : 171; GRP : 121; EVNT : 3);
  lcPCTakeIntoAccountDaysOfTheWeek : lcRec =  // ��������� ��� ������
    (ID : 172; GRP : 121; EVNT : 4);
  lcPCTakeIntoAccountDaysOfTheMonth : lcRec =  // ��������� ��� ������
    (ID : 173; GRP : 121; EVNT : 5);
  lcPCRunWithStatus : lcRec =  // ��������� �� ��������
    (ID : 174; GRP : 121; EVNT : 6);
  lcPCCriticalErrorRate : lcRec =  // ����������� ������� ������
    (ID : 175; GRP : 121; EVNT : 7);
  lcPCSearchDepth : lcRec =  // ������� ������
    (ID : 176; GRP : 121; EVNT : 8);
  lcPCAllowAutoPoll : lcRec =  // ��������� �������������� �����
    (ID : 177; GRP : 121; EVNT : 9);
  lcPCPause : lcRec =  // �����
    (ID : 178; GRP : 121; EVNT : 10);
  lcPCSearchUpdate : lcRec =  // �����/����������
    (ID : 179; GRP : 121; EVNT : 11);
  lcPCUnloadingDepth : lcRec =  // ������� ��������
    (ID : 180; GRP : 121; EVNT : 12);

  // CED - Channel Editor    �������� �������        unit knsl5module;
  ColorGroup130CE = $00FAF1E9;  // ?
  lcCEDSave : lcRec =  // ��������
    (ID : 200; GRP : 130; EVNT : 0);
  lcCEDRead : lcRec =  // ���������
    (ID : 201; GRP : 130; EVNT : 1);
  lcCEDCreate : lcRec =  // �������
    (ID : 202; GRP : 130; EVNT : 2);
  lcCEDClone : lcRec =  // �����������
    (ID : 203; GRP : 130; EVNT : 3);
  lcCEDDeleteRecord : lcRec =  // ������� ������
    (ID : 204; GRP : 130; EVNT : 4);
  lcCEDDeleteAll : lcRec =  // ������� ��
    (ID : 205; GRP : 130; EVNT : 5);
  lcCEDExportToExcel : lcRec =  // �������������� � Excel
    (ID : 206; GRP : 130; EVNT : 6);
  lcCEDInitializeChannel : lcRec =  // ���������������� ������
    (ID : 207; GRP : 130; EVNT : 7);
  lcCEDReleaseChannels : lcRec =  // ���������� ������
    (ID : 208; GRP : 130; EVNT : 8);
  lcCEDDisplay : lcRec =  // �����������
    (ID : 209; GRP : 130; EVNT : 9);
  lcCEDTechnologicalInfo : lcRec =  // ��������������� ����������
    (ID : 210; GRP : 130; EVNT : 10);
  // CEDPDm - Channel Editor: Pull Desc    �������� �������: �������� ��������        unit knsl5module;
    ColorGroup131CE = $10EAE1D9;  // ?
  lcCEDPDmSave : lcRec =  // ��������
    (ID : 250; GRP : 131; EVNT : 0);
  lcCEDPDmRead : lcRec =  // ���������
    (ID : 251; GRP : 131; EVNT : 1);
  lcCEDPDmCreate : lcRec =  // �������
    (ID : 252; GRP : 131; EVNT : 2);
  lcCEDPDmClone : lcRec =  // �����������
    (ID : 253; GRP : 131; EVNT : 3);
  lcCEDPDmDeleteRecord : lcRec =  // ������� ������
    (ID : 254; GRP : 131; EVNT : 4);
  lcCEDPDmDeleteAll : lcRec =  // ������� ��
    (ID : 255; GRP : 131; EVNT : 5);
  lcCEDPDmDisplay : lcRec =  // �����������
    (ID : 256; GRP : 131; EVNT : 6);
  // CEDPMm - Channel Editor: Pull Menu    �������� �������: �������� ����        unit knsl5module;
    ColorGroup132CE = $20DAD1C9;  // ?
  lcCEDPMmSave : lcRec =  // ��������
    (ID : 260; GRP : 132; EVNT : 0);
  lcCEDPMmRead : lcRec =  // ���������
    (ID : 261; GRP : 132; EVNT : 1);
  lcCEDPMmCreate : lcRec =  // �������
    (ID : 262; GRP : 132; EVNT : 2);
  lcCEDPMmClone : lcRec =  // �����������
    (ID : 263; GRP : 132; EVNT : 3);
  lcCEDPMmDeleteRecord : lcRec =  // ������� ������
    (ID : 264; GRP : 132; EVNT : 4);
  lcCEDPMmDeleteAll : lcRec =  // ������� ��
    (ID : 265; GRP : 132; EVNT : 5);
  lcCEDPMmDisplay : lcRec =  // �����������
    (ID : 266; GRP : 132; EVNT : 6);
{    ColorGroup133CE = $20C0C1B9;  // ?
  lcCECPMmSave : lcRec =  // ��������
    (ID : 270; GRP : 133; EVNT : 0);
  lcCECPMmRead : lcRec =  // ���������
    (ID : 271; GRP : 133; EVNT : 1);
  lcCECPMmCreate : lcRec =  // �������
    (ID : 272; GRP : 133; EVNT : 2);
  lcCECPMmClone : lcRec =  // �����������
    (ID : 273; GRP : 133; EVNT : 3);
  lcCECPMmDeleteRecord : lcRec =  // ������� ������
    (ID : 274; GRP : 133; EVNT : 4);
  lcCECPMmDeleteAll : lcRec =  // ������� ��
    (ID : 275; GRP : 133; EVNT : 5);
  lcCECPMmExportToExcel : lcRec =  // �������������� � Excel
    (ID : 276; GRP : 133; EVNT : 6);
  lcCECPMmInitializeChannel : lcRec =  // ���������������� ������
    (ID : 277; GRP : 133; EVNT : 7);
  lcCECPMmReleaseChannels : lcRec =  // ���������� ������
    (ID : 278; GRP : 133; EVNT : 8);
  lcCECPMmDisplay : lcRec =  // �����������
    (ID : 279; GRP : 133; EVNT : 9);
  lcCECPMmTechnologicalInfo : lcRec =  // ��������������� ����������
    (ID : 280; GRP : 133; EVNT : 10); }

  // ME - Meter Editor   �������� ���������        unit knsl5module;
     ColorGroup140ME = $20C0C1B9;  // ?
  lcMESave : lcRec =  // ��������
    (ID : 300; GRP : 140; EVNT : 0);
  lcMERead : lcRec =  // ���������
    (ID : 301; GRP : 140; EVNT : 1);
  lcMECreate : lcRec =  // �������
    (ID : 302; GRP : 140; EVNT : 2);
  lcMEClone : lcRec =  // �����������
    (ID : 303; GRP : 140; EVNT : 3);
  lcMEDeleteRecord : lcRec =  // ������� ������
    (ID : 304; GRP : 140; EVNT : 4);
  lcMEDeleteAll : lcRec =  // ������� ��
    (ID : 305; GRP : 140; EVNT : 5);
  lcMEExportToExcel : lcRec =  // �������������� � Excel
    (ID : 306; GRP : 140; EVNT : 6);
  lcMEInitializeDevices : lcRec =  // ���������������� ����������
    (ID : 307; GRP : 140; EVNT : 7);
  lcMECreateMeters : lcRec =  // ������� �������� ?
    (ID : 308; GRP : 140; EVNT : 8);
  lcMEDisplay : lcRec =  // �����������
    (ID : 309; GRP : 140; EVNT : 9);
  lcMETechnologicalInfo : lcRec =  // ��������������� ����������
    (ID : 310; GRP : 140; EVNT : 10);

  // QE - Query Editor   �������� ��������        unit knsl5module;
     ColorGroup150QE = $20C0C1B9;  // ?
  lcQESave : lcRec =  // ��������
    (ID : 330; GRP : 150; EVNT : 0);
  lcQERead : lcRec =  // ���������
    (ID : 331; GRP : 150; EVNT : 1);
  lcQECreate : lcRec =  // �������
    (ID : 332; GRP : 150; EVNT : 2);
  lcQEClone : lcRec =  // �����������
    (ID : 333; GRP : 150; EVNT : 3);
  lcQEDeleteRecord : lcRec =  // ������� ������
    (ID : 334; GRP : 150; EVNT : 4);
  lcQEDeleteAll : lcRec =  // ������� ��
    (ID : 335; GRP : 150; EVNT : 5);
  lcQEExportToExcel : lcRec =  // �������������� � Excel
    (ID : 336; GRP : 150; EVNT : 6);
  lcQEDisplay : lcRec =  // �����������
    (ID : 337; GRP : 150; EVNT : 7);
  lcQETechnologicalInfo : lcRec =  // ��������������� ����������
    (ID : 338; GRP : 150; EVNT : 8);

  // PE - Parameter Editor   �������� ����������        unit knsl5module;
     ColorGroup155PE = $20A0A199;  // ?
  lcPESave : lcRec =  // ��������
    (ID : 350; GRP : 155; EVNT : 0);
  lcPERead : lcRec =  // ���������
    (ID : 351; GRP : 155; EVNT : 1);
  lcPECreate : lcRec =  // �������
    (ID : 352; GRP : 155; EVNT : 2);
  lcPEClone : lcRec =  // �����������
    (ID : 353; GRP : 155; EVNT : 3);
  lcPEDeleteRecord : lcRec =  // ������� ������
    (ID : 354; GRP : 155; EVNT : 4);
  lcPEDeleteAll : lcRec =  // ������� ��
    (ID : 355; GRP : 155; EVNT : 5);
  lcPEExportToExcel : lcRec =  // �������������� � Excel
    (ID : 356; GRP : 155; EVNT : 6);
  lcPEDisplay : lcRec =  // �����������
    (ID : 357; GRP : 155; EVNT : 7);
  lcPETechnologicalInfo : lcRec =  // ��������������� ����������
    (ID : 358; GRP : 155; EVNT : 8);

  // GE - Group Editor : Sub  �������� ����� : ��������       unit knsl5module;
     ColorGroup160GES = $10909189;  // ?
  lcGESSave : lcRec =  // ��������
    (ID : 380; GRP : 160; EVNT : 0);
  lcGESRead : lcRec =  // ���������
    (ID : 381; GRP : 160; EVNT : 1);
  lcGESCreate : lcRec =  // �������
    (ID : 382; GRP : 160; EVNT : 2);
  lcGESEdit : lcRec =  // �������������
    (ID : 383; GRP : 160; EVNT : 3);
  lcGESDeleteRecord : lcRec =  // ������� ������
    (ID : 384; GRP : 160; EVNT : 4);
  lcGESDeleteAll : lcRec =  // ������� ��
    (ID : 385; GRP : 160; EVNT : 5);
  lcGESExportToExcel : lcRec =  // �������������� � Excel
    (ID : 386; GRP : 160; EVNT : 6);
  lcGESInitializeGroups : lcRec =  // ���������������� ������
    (ID : 387; GRP : 160; EVNT : 7);
  lcGESDisplay : lcRec =  // �����������
    (ID : 388; GRP : 160; EVNT : 8);
  lcGESSaveChannelDataToWord : lcRec =  // ��������� ������ �� ������� � Word
    (ID : 389; GRP : 160; EVNT : 9);
  lcGESRefreshChannels : lcRec =  // �������� ������
    (ID : 390; GRP : 160; EVNT : 10);
  lcGESTechnologicalInfo : lcRec =  // ��������������� ����������
    (ID : 391; GRP : 160; EVNT : 11);

  // GEAPG - Group Editor : Account Point Groups  �������� ����� : ������ ����� �����       unit knsl5module;
     ColorGroup161GEAPG = $10808179;  // ?
  lcGEAPGSave : lcRec =  // ��������
    (ID : 400; GRP : 161; EVNT : 0);
  lcGEAPGRead : lcRec =  // ���������
    (ID : 401; GRP : 161; EVNT : 1);
  lcGEAPGCreate : lcRec =  // �������
    (ID : 402; GRP : 161; EVNT : 2);
  lcGEAPGClone : lcRec =  // �����������
    (ID : 403; GRP : 161; EVNT : 3);
  lcGEAPGDeleteRecord : lcRec =  // ������� ������
    (ID : 404; GRP : 161; EVNT : 4);
  lcGEAPGDeleteAll : lcRec =  // ������� ��
    (ID : 405; GRP : 161; EVNT : 5);
  lcGEAPGExportToExcel : lcRec =  // �������������� � Excel
    (ID : 406; GRP : 161; EVNT : 6);
  lcGEAPGInitializeGroups : lcRec =  // ���������������� ������
    (ID : 407; GRP : 161; EVNT : 7);
  lcGEAPGDisplay : lcRec =  // �����������
    (ID : 408; GRP : 161; EVNT : 8);
  lcGEAPGTechnologicalInfo : lcRec =  // ��������������� ����������
    (ID : 409; GRP : 161; EVNT : 9);

  // GEAP - Group Editor : Account Points  �������� ����� : ����� �����       unit knsl5module;
     ColorGroup162GEAP = $09807169;  // ?
  lcGEAPSave : lcRec =  // ��������
    (ID : 420; GRP : 162; EVNT : 0);
  lcGEAPRead : lcRec =  // ���������
    (ID : 421; GRP : 162; EVNT : 1);
  lcGEAPCreate : lcRec =  // �������
    (ID : 422; GRP : 162; EVNT : 2);
  lcGEAPClone : lcRec =  // �����������
    (ID : 423; GRP : 162; EVNT : 3);
  lcGEAPDeleteRecord : lcRec =  // ������� ������
    (ID : 424; GRP : 162; EVNT : 4);
  lcGEAPDeleteAll : lcRec =  // ������� ��
    (ID : 425; GRP : 162; EVNT : 5);
  lcGEAPExportToExcel : lcRec =  // �������������� � Excel
    (ID : 426; GRP : 162; EVNT : 6);
  lcGEAPInitializeGroups : lcRec =  // ���������������� ������
    (ID : 427; GRP : 162; EVNT : 7);
  lcGEAPConnectMeter : lcRec =  // ���������� �������
    (ID : 428; GRP : 162; EVNT : 8);
  lcGEAPDisplay : lcRec =  // �����������
    (ID : 429; GRP : 162; EVNT : 9);
  lcGEAPTechnologicalInfo : lcRec =  // ��������������� ����������
    (ID : 430; GRP : 162; EVNT : 10);


  // MR - Meter Replacement  ������ ��������       unit knsl5module;
     ColorGroup200MR = $2F120145;  // ?
  lcMRMoreThanOneAddress : lcRec =  // ����� ������ ������
    (ID : 600; GRP : 200; EVNT : 0);
  lcMRAddedNewAddress : lcRec =  // �������� ����� �����
    (ID : 601; GRP : 200; EVNT : 1);
  lcMRLastNameChanged : lcRec =  // �������� �������
    (ID : 602; GRP : 200; EVNT : 2);
  lcMRChangedFactoryNumber : lcRec =  // ������� ��������� �����
    (ID : 603; GRP : 200; EVNT : 3);
  lcMRChangedAccount : lcRec =  // ������� ������� ����
    (ID : 604; GRP : 200; EVNT : 4);









  // ERR - Errors  ������       ��� ������
     ColorGroup200ERR = $2F2F2F2F;  // ?
  lcERRInaccessibleValue : lcRec =  // ������� ��������� � ������� ���������� �������
    (ID : 1000; GRP : 300; EVNT : 0);
  lcERRObjectIsNil : lcRec =  // ������� ��������� � ������� �� ���������� �������
    (ID : 1001; GRP : 300; EVNT : 1);


var IDCurrentUser      : integer;



implementation


//initialization


//finalization


end.
