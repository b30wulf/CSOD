unit GRDDelphi;
{6.00.00}
interface

    uses
        ActiveX,
        WinProcs,
        SysUtils,
        Nb30;

        {$L GRDFWBO.OBJ}
    //{$IF CompilerVersion < 23}
    //{$L GRDFWBO.OBJ}
    //{$ELSE}
    //{$IFDEF CPUX86}
    //{$L GRDFWBO.OBJ}
    //{$ELSE}
    //{$IFDEF CPUX64}
    //{$L GRDFWMC64.OBJ}
    //{$ENDIF}
    //{$ENDIF}
    //{$IFEND}
    const
    { Type of asymmetric cryptoalgorithm }
    GrdVSC_ECC160=  0;

    { Hardware-implemented ECC160 algorithm properties }
    GrdECC160_PUBLIC_KEY_SIZE=  40;
    GrdECC160_PRIVATE_KEY_SIZE= 20;

    GrdECC160_DIGEST_SIZE=      40;
    GrdECC160_MESSAGE_SIZE=     20;

    type
        TGrdHandle = Pointer;
        BOOL = integer;
        DWORD = LongWord;
        QWORD = Int64;
        HANDLE = TGrdHandle;

{ Dongle Notification CallBack routine  }
    TGrdDongleNotifyCallBack = procedure(hGrd: HANDLE; nGrdNotifyMessage: Integer); stdcall;

    TGrdFindInfo = packed record
        dwPublicCode:       DWORD;                                      { Public code }
        byHrwVersion:       BYTE;                                       { Dongle hardware version }
        byMaxNetRes:        BYTE;                                       { Maximum Guardant Net license limit }
        wType:              WORD;                                       { Dongle type flags }
        dwID:               DWORD;                                      { Dongle's ID (unique) }
        { Following fields are available from UAM mode }
        byNProg:            BYTE;                                       { Program number }
        byVer:              BYTE;                                       { Version }
        wSN:                WORD;                                       { Serial number }
        wMask:              WORD;                                       { Bit mask }
        wGP:                WORD;                                       { Executions GP counter/ License time counter }
        wRealNetRes:        WORD;                                       { Current Guardant Net license limit, must be <= byMaxNetRes }
        dwIndex:            DWORD;                                      { Index for remote programming }
        { Only Stealth III info }
        abyReservedISEE:    array[1..$1C] of BYTE;                      { Reserved for future }
        wWriteProtectS3:    WORD;                                       { Stealth III write protect address }
        wReadProtectS3:     WORD;                                       { Stealth III read protect address }
        wGlobalFlags:       WORD;                                       { Global Stealth III flags. Reserved. }
        dwDongleState:      DWORD;                                      { Dongle State. See GrdDSF_XXX definition }
        { Available since: }
        { 1. Stealth Sign.(Firmware number >= 0x01000011h or 01.00.00.11) }
        { 2. Guardant Code. }
        dwOldMPNum:         DWORD;                                      { Old firmware number(before SFU). }
        abyReservedH:       array[1..$100-$1A-$1C-$0E] of BYTE;         { Reserved. For align to 0x100 [0x100 - 0x1A - 0x1C - 0x0A] }
        { Reserved info from gsA }
        { Driver info }
        dwGrDrv_Platform:   DWORD;                                      { Driver platform (Win32/Win64) }
        dwGrDrv_Vers:       DWORD;                                      { Driver version (0x04801234=4.80.12.34 }
        dwGrDrv_Build:      DWORD;                                      { Driver build }
        dwGrDrv_Reserved:   DWORD;                                      { Reserved }
        { dongle info }
        dwRkmUserAddr:      DWORD;                                      { wkmUserAddr }
        dwRkmAlgoAddrW:     DWORD;                                      { wkmAlgoAddr }
        dwPrnPort:          DWORD;                                      { Printer port address or 0 if it USB }
        dwClientVersion:    DWORD;                                      { Dongle client version }
        { SAP start }
        dwRFlags:           DWORD;                                      { Type of MCU }
        dwRProgVer:         DWORD;                                      { Program version (in MCU) }
        dwRcn_rc:           DWORD;                                      { curr_num & answer code }
        dwNcmps:            DWORD;                                      { Number of compare conditions }
        dwNSKClientVersion: DWORD;                                      { Client version (low byte - minor, hi - major) }
        dwModel:            DWORD;                                      { Dongle Model }
        dwMcuType:          DWORD ;                                     { Dongle MCU Type }
        dwMemoryType:       DWORD ;                                     { Dongle Memory Type }
        { Reserved for future }
        abyReserved:        array[1..$200-$100-$28]  of BYTE;           { Reserved. For align to 0x200  [0x200 - 0x100 - 0x34] }
    end;

    TGrdStdFields = packed record
{ Fields protection against nsc_Init, nsc_Protect, nsc_Write commands }
{    * - Partial protection : nsc_Protect can be executed only after nsc_Init }
{    X - Full protection }
{ Protection against command :      Init Protect Write }
        byDongleModel:      BYTE;                                     {  0h   X     X     X    0=GS,1=GU,2=GF, }
        byDongleMemSize:    BYTE;                                     {  1h   X     X     X    0=0, 8=256 ( Memsize = 1 << byDongleMemSize ) }
        byDongleProgVer:    BYTE;                                     {  2h   X     X     X }
        byDongleProtocol:   BYTE;                                     {  3h   X     X     X }
        wClientVer:         WORD;                                     {  4h   X     X     X    0x104=1.4 }
        byDongleUserAddr:   BYTE;                                     {  6h   X     X     X }
        byDongleAlgoAddr:   BYTE;                                     {  7h   X     X     X }
        wPrnport:           WORD;                                     {  8h   X     X     X }
        wWriteProtectS3:    WORD;                                     {  Ah         *     X      { Stealth III write protect SAM address in bytes }
        wReadProtectS3:     WORD;                                     {  Ch         *     X      { Stealth III read  protect SAM address in bytes }
        dwPublicCode:       DWORD;                                    {  Eh   X     X     X }
        byVersion:          BYTE;                                     { 12h   X     X     X }
        byLANRes:           BYTE;                                     { 13h   X     X     X }
        wType:              WORD;                                     { 14h   X     X     X }
        dwID:               DWORD;                                    { 16h   X     X     X }
        byWriteProtect:     BYTE;                                     { 1Ah         *     X      { Stealth I & II write protect SAM address in words }
        byReadProtect:      BYTE;                                     { 1Bh         *     X      { Stealth I & II read  protect SAM address in words }
        byNumFunc:          BYTE;                                     { 1Ch         *     X }
        byTableLMS:         BYTE;                                     { 1Dh         *     X }
        byNProg:            BYTE;                                     { 1Eh   X     X }
        byVer:              BYTE;                                     { 1Fh   X     X }
        wSN:                WORD;                                     { 20h   X     X }
        wMask:              WORD;                                     { 22h   X     X }
        wGP:                WORD;                                     { 24h   X     X }
        wRealLANRes:        WORD;                                     { 26h   X     X }
        dwIndex:            DWORD;                                    { 28h   X     X }
        abyAlgoAddr:        array[1..1]of BYTE;                       { 2Ch }
    end;

    TGrdSystemTime = packed record
        wYear:              WORD;             { The year (1601 - 2099) }
        wMonth:             WORD;             { The month (January = 1, February = 2, ...) }
        wDayOfWeek:         WORD;             { The day of the week (Sunday = 0, Monday = 1, ...) }
        wDay:               WORD;             { The day of the month (1-31) }
        wHour:              WORD;             { The hour (0-23) }
        wMinute:            WORD;             { The minute (0-59) }
        wSecond:            WORD;             { The second (0-59) }
        wMilliseconds:      WORD;             { The millisecond (0-999) }
    end;

    TGrdCodePublicData = packed record
        bLoadableCodeVersion:    BYTE;        { Loadable Code version.   }
        bReserved0:              BYTE;        { Loading date.            }
        bState:                  BYTE;        { Loadable Code state.     }
        bReserved:               BYTE;
        dwLoadingDate:           DWORD;       { In\Out buffer size.      }
    end;

{- Return’s struct for GrdCodeGetInfo}

    TGrdCodeInfo =  packed record
        dwStartAddr:        DWORD;  { Flash start address for Loadable Code. }
        dwCodeSizeMax:      DWORD;  { Flash size for Loadable Code.          }
        dwCodeSectorSize:   DWORD;  { Flash sector size for Loadable Code.   }
        dwStartRamAddr:     DWORD;  { RAM start address for Loadable Code.   }
        dwRamSizeMax:       DWORD;  { RAM size for Loadable Code.            }
        dwReserved:         DWORD;  { Reserved.                              }
        PublicDataLoadableCode:  TGrdCodePublicData;
        abHashLoadableCode: array[1..32]  of BYTE;  { Hash of loadable code. }
        abReserved:         array[1..64]  of BYTE;  { Reserved.              }
    end;

{- The structure of the determinant for the type descriptor "loadable code" }
    TGrdLoadableCodeData = packed record
        PublicDataLoadableCode: TGrdCodePublicData;
        abLoadableCodePublicKey4VerifySign: array [1..GrdECC160_PUBLIC_KEY_SIZE] of BYTE;
        abLoadableCodePrivateKey4DecryptKey:array [1..GrdECC160_PRIVATE_KEY_SIZE]of BYTE;
        dwBegFlashAddr:                     DWORD;    { The specified start address flash-memory for loadable code. }
        dwEndFlashAddr:                     DWORD;    { The specified end address flash-memory for loadable code. }
        dwBegMemAddr:                       DWORD;    { The specified start address RAM-memory for loadable code. }
        dwEndMemAddr:                       DWORD;    { The specified end address RAM-memory for loadable code. }
    end;

{- Demo Codes}
    const

    GrdDC_DEMONVK:DWORD= $519175b7;  { Demo public code }
    GrdDC_DEMORDO:DWORD= $51917645;  { Demo private read code }
    GrdDC_DEMOPRF:DWORD= $51917603;  { Demo private write code }
    GrdDC_DEMOMST:DWORD= $5191758c;  { Demo private master code }

    GrdContainerSize= $3000;    { Size of memory allocated for Guardant protected container }

{- Dongle Models }
    GrdDM_GS1L=         0;      { Guardant Stealth       LPT }
    GrdDM_GS1U=         1;      { Guardant Stealth       USB }
    GrdDM_GF1L=         2;      { Guardant Fidus         LPT }
    GrdDM_GS2L=         3;      { Guardant StealthII     LPT }
    GrdDM_GS2U=         4;      { Guardant StealthII     USB }
    GrdDM_GS3U=         5;      { Guardant StealthIII    USB }
    GrdDM_GF1U=         6;      { Guardant Fidus         USB }
    GrdDM_GS3SU=        7;      { Guardant StealthIII Sign/Time USB }
    GrdDM_GCU=          8;      { Guardant Code          USB }
    GrdDM_GSP=          9;      { Guardant SP       SOFTWARE }
    GrdDM_Total=        10;     { Number of different models }

 {- Dongle Models }
    GrdDM_Stealth1LPT=   GrdDM_GS1L;  { Guardant Stealth         LPT }
    GrdDM_Stealth1USB=   GrdDM_GS1U;  { Guardant Stealth         USB }
    GrdDM_FidusLPT=      GrdDM_GF1L;  { Guardant Fidus           LPT }
    GrdDM_Stealth2LPT=   GrdDM_GS2L;  { Guardant Stealth II      LPT }
    GrdDM_Stealth2USB=   GrdDM_GS2U;  { Guardant Stealth II      USB }
    GrdDM_Stealth3USB=   GrdDM_GS3U;  { Guardant Stealth III     USB }
    GrdDM_FidusUSB=      GrdDM_GF1U;  { Guardant Fidus           USB }
    GrdDM_SignUSB=       GrdDM_GS3SU; { Guardant Stealth III Sign/Time USB }
    GrdDM_Soft=          GrdDM_GSP;   { Guardant SP         SOFTWARE }
    GrdDM_CodeUSB=       GrdDM_GCU;   { Guardant Code            USB }

{- Dongle Interfaces }
    GrdDI_LPT=          0;      { LPT port  }
    GrdDI_USB=          1;      { USB bus }
    GrdDI_SP=           2;      { Software bus }

{- Definitions for use in GrdSetDriverMode () function call }
    GrdDM_GRD_DRV=      0;      { Guardant driver }
    GrdDM_USB_HID=      1;      { HID driver }

{- Dongle Types }
    GrdDT_DOS=          $0000;  { DOS Stealth Dongle }
    GrdDT_Win=          $0000;  { Windows Stealth Dongle }
    GrdDT_LAN=          $0001;  { LAN Stealth Dongle }
    GrdDT_Time=         $0002;  { Time Stealth Dongle }
    GrdDT_GSII64=       $0008;  { Support of Guardant Stealth II 64 bit (GSII64) algorithm }
    GrdDT_PI=           $0010;  { Support of Guardant Stealth III protected items }
    GrdDT_TRU=          $0020;  { Support of Guardant Stealth III remote update }
    GrdDT_RTC=          $0040;  { Support of Real Time Clock }
    GrdDT_AES=          $0080;  { Support of AES 128 algorithm }
    GrdDT_ECC=          $0100;  { Support of ECC 160 algorithm }
    GrdDT_LoadableCode= $0400;  { Support of Loadable Code }

{-- Flags GrdCreateHandle() Mode }
    GrdCHM_SingleThread=$00000000;        { Multi-thredaing support is disabled }
    GrdCHM_MultiThread= $00000001;        { Multi-thredaing support is enabled (access synchronisation to hGrd is on) }

{-- Flags for GrdLogin() Liceseng Mode }
    GrdLM_PerStation=   $00000000;        { Allocate Guardant Net license for each workstation }
    GrdLM_PerHandle=    $00000001;        { Allocate Guardant Net license for each logged in protected container }
    GrdLM_PerProcess=   $00000002;        { Allocate Guardant Net license for each process (application copy)}

{-- Flags for Remote Mode of GrdSetFindMode() }
{- Dongle SetFindMode Remote mode search flags }
    GrdFMR_Local=  1;                                           { Local dongle }
    GrdFMR_Remote= 2;                                           { Remote dongle }

{- SetFindMode dongle Models search bits }
    GrdFMM_GS1L=         (1 shl GrdDM_GS1L);                    { Guardant Stealth LPT }
    GrdFMM_GS1U=         (1 shl GrdDM_GS1U);                    { Guardant Stealth USB }
    GrdFMM_GF1L=         (1 shl GrdDM_GF1L);                    { Guardant Fidus  LPT }
    GrdFMM_GS2L=         (1 shl GrdDM_GS2L);                    { Guardant StealthII LPT }
    GrdFMM_GS2U=         (1 shl GrdDM_GS2U);                    { Guardant StealthII USB }
    GrdFMM_GS3U=         (1 shl GrdDM_GS3U);                    { Guardant StealthIII USB }
    GrdFMM_GF1U=         (1 shl GrdDM_GF1U);                    { Guardant Fidus USB }
    GrdFMM_GS3SU=        (1 shl GrdDM_GS3SU);                   { Guardant StealthIII Sign/Time USB }
    GrdFMM_GCU=          (1 shl GrdDM_GCU);                     { Guardant Code USB }
    GrdFMM_GSP=          (1 shl GrdDM_GSP);                     { Guardant SP SOFTWARE }
    GrdFMM_GS1=          ( GrdFMM_GS1L or GrdFMM_GS1U );        { Guardant Stealth I of any interface }
    GrdFMM_GF=           ( GrdFMM_GF1L or GrdFMM_GF1U );        { Guardant Fidus I of any interface }
    GrdFMM_GS2=          ( GrdFMM_GS2L or GrdFMM_GS2U );         { Guardant Stealth II  of any interface }
    GrdFMM_GS3=          ( GrdFMM_GS3U );                       { Guardant Stealth III of any interface }
    GrdFMM_GS3S=         ( GrdFMM_GS3SU );                      { Guardant Stealth III Sign/Time of any interface }
    GrdFMM_GC=           ( GrdFMM_GCU );                        { Guardant Code of any interface }
    GrdFMM_ALL=          0;                                     { All Guardant Stealth & Fidus family }

{- SetFindMode dongle model search bits }
    GrdFMM_Stealth1LPT=     (1 shl GrdDM_Stealth1LPT);          { Guardant Stealth     LPT }
    GrdFMM_Stealth1USB=     (1 shl GrdDM_Stealth1USB);          { Guardant Stealth     USB }
    GrdFMM_FidusLPT=        (1 shl GrdDM_FidusLPT);             { Guardant Fidus       LPT }
    GrdFMM_Stealth2LPT=     (1 shl GrdDM_Stealth2LPT);          { Guardant StealthII   LPT }
    GrdFMM_Stealth2USB=     (1 shl GrdDM_Stealth2USB);          { Guardant StealthII   USB }
    GrdFMM_Stealth3USB=     (1 shl GrdDM_Stealth3USB);          { Guardant StealthIII  USB }
    GrdFMM_FidusUSB=        (1 shl GrdDM_FidusUSB);             { Guardant Fidus       USB }
    GrdFMM_SignUSB=         (1 shl GrdDM_SignUSB);              { Guardant StealthIII Sign/Time USB }
    GrdFMM_Soft=            (1 shl GrdDM_Soft);                 { Guardant SP SOFTWARE }
    GrdFMM_CodeUSB=         (1 shl GrdDM_CodeUSB);              { Guardant Code        USB }
    GrdFMM_Stealth1=        (GrdFMM_Stealth1LPT or GrdFMM_Stealth1USB);     { Guardant Stealth I   of any interface }
    GrdFMM_Fidus=           (GrdFMM_FidusLPT    or GrdFMM_FidusUSB);        { Guardant Fidus   I   of any interface }
    GrdFMM_Stealth2=        (GrdFMM_Stealth2LPT or GrdFMM_Stealth2USB);     { Guardant Stealth II  of any interface }
    GrdFMM_Stealth3=        (GrdFMM_Stealth3USB);               { Guardant Stealth III of any interface             }
    GrdFMM_Sign=            (GrdFMM_SignUSB);                   { Guardant Stealth III Sign/Time of any interface   }
    GrdFMM_Code=            (GrdFMM_CodeUSB);                   { Guardant Code of any interface                    }

{- SetFindMode          dongle Interfaces search bits }
    GrdFMI_LPT= (1 shl GrdDI_LPT);                              { LPT port }
    GrdFMI_USB= (1 shl GrdDI_USB);                              { USB bus }
    GrdFMI_SP=  (1 shl GrdDI_SP);                               { Software bus }
    GrdFMI_ALL= 0;                                              { All Guardant Stealth & Fidus interfaces }

{-- Definition for use in GrdFind() function call }
    GrdF_First=              1;  { First call }
    GrdF_Next=               0;  { Next calls }

{-- Flags of Find parameters during GrdLogin() or GrdFind() }
    GrdFM_NProg=         $0001;  { wDongleNProg == wNProg }
    GrdFM_ID=            $0002;  { dwDongleID == dwID }
    GrdFM_SN=            $0004;  { Serial Number wDongleSN == wSN }
    GrdFM_Ver=           $0008;  { bDongleVersion >= bVer }
    GrdFM_Mask=          $0010;  { wDongleMask & wMask == wMask }
    GrdFM_Type=          $0020;  { wDongleType & wType == wType }

{-- Flags of Work Mode (Lo) }
    GrdWM_UAM=           $0000;  { Enables UAM (User Address Mode) in read/write operations. Default mode }
    GrdWM_SAM=           $0080;  { Enables SAM (System Address Mode) in read/write operations }
    GrdWM_CodeIsString=  $0100;  { Reserved }
    GrdWM_NoRetry=       $0200;  { Disables auto configuration of communication protocol }
    GrdWM_NoFullAccess=  $0400;  { Disables full capture of the parallel port resource }
    GrdWM_OnlyStdLPT1=   $0800;  { Enables search for the dongle in LPT1 only (address $378) }
    GrdWM_OnlyStdLPT2=   $1000;  { Enables search for the dongle in LPT2 only (address $278) }
    GrdWM_OnlyStdLPT3=   $2000;  { Enables search for the key in LPT3 only (address $3BC) }
    GrdWM_NoAutoMem32=   $4000;  { Indicates that data segment is different from the standard one }
    GrdWM_UseOldCRC=     $8000;  { Reserved }
    GrdWM_NotStdLPTAddr= $02000000;

{-- GrdSetWorkMode() dwFlagsMode parameters}
    GrdWMFM_DriverAuto=  $0000;  { Use driver automaticaly. Call the dongle by means of driver if it is installed}
    GrdWMFM_DriverOnly=  $0001;  { Call the dongle by means of driver only}
    GrdWMFM_BypassDriver=$0002;  { Bypass driver in Win9X}

{- Lock Mode flags --- }
{  Commands Login, Check and Find cannot be locked }
    GrdLM_Nothing=       $00000000;  {  Works like critical section }
    GrdLM_Init=          $00000001;  { Prevent Init operations }
    GrdLM_Protect=       $00000002;  { Prevent Protect operations  }
    GrdLM_Transform=     $00000004;  { Prevent Transform operations }
    GrdLM_Read=          $00000008;  { Prevents read from UAM memory }
    GrdLM_Write=         $00000010;  { Prevents write to UAM memory }
    GrdLM_Activate=      $00000020;  { Prevent activation of protected items}
    GrdLM_Deactivate=    $00000040;  { Prevent deactivation of protected items}
    GrdLM_ReadItem=      $00000080;  { Prevent reading from protected items}
    GrdLM_UpdateItem=    $00000100;  { Prevent updating of protected items}
    GrdLM_All=           $FFFFFFFF;  { Prevent all mentioned above operations}

{- UAM Addresses of Fields --- }
    GrdUAM_bNProg=           (30-30); { 00h Programm number }
    GrdUAM_bVer=             (31-30); { 01h Version }
    GrdUAM_wSN=              (32-30); { 02h Serial number }
    GrdUAM_wMask=            (34-30); { 04h Bit mask }
    GrdUAM_wGP=              (36-30); { 06h Counter #1 (GP) }
    GrdUAM_wRealLANRes=      (38-30); { 08h Current network license limit }
    GrdUAM_dwIndex=          (40-30); { 0Ah Index }
    GrdUAM_abAlgoAddr=       (44-30); { 0Eh User data, algorithm descriptors }

{- SAM Addresses of Fields }
{ Fields protection against nsc_Init, nsc_Protect, nsc_Write commands }
{    * - Partial protection: nsc_Protect can be executed only after nsc_Init }
{    X - Full protection }
{ Protection against command:  Init Protect Write }
    GrdSAM_byDongleModelAddr=     0; {  0h   X     X     X    0=GS,1=GU,2=GF }
    GrdSAM_byDongleMemSizeAddr=   1; {  1h   X     X     X    0=0, 8=256 }
    GrdSAM_byDongleProgVerAddr=   2; {  2h   X     X     X }
    GrdSAM_byDongleProtocolAddr=  3; {  3h   X     X     X }
    GrdSAM_wClientVerAddr=        4; {  4h   X     X     X    $104=1.4 }
    GrdSAM_byDongleUserAddrAddr=  6; {  6h   X     X     X }
    GrdSAM_byDongleAlgoAddrAddr=  7; {  7h   X     X     X }
    GrdSAM_wPrnportAddr=          8; {  8h   X     X     X }
    GrdSAM_byWriteProtectS3=     10; {  Ah         *     X }
    GrdSAM_byReadProtectS3=      12; {  Ch         *     X }
    GrdSAM_dwPublicCode=         14; {  Eh   X     X     X }
    GrdSAM_byVersion=            18; { 12h   X     X     X }
    GrdSAM_byLANRes=             19; { 13h   X     X     X }
    GrdSAM_wType=                20; { 14h   X     X     X }
    GrdSAM_dwID=                 22; { 16h   X     X     X }
    GrdSAM_bWriteProtect=        26; { 1Ah         *     X }
    GrdSAM_byReadProtect=        27; { 1Bh         *     X }
    GrdSAM_byNumFunc=            28; { 1Ch         *     X }
    GrdSAM_byTableLMS=           29; { 1Dh         *     X }
    GrdSAM_byTableLMS_S3=        29; { 1Dh         *     X }
    GrdSAM_UAM=                  30; { 1Eh  start address of UAM memory}
    GrdSAM_byNProg=              30; { 1Eh   X     X }
    GrdSAM_byVer=                31; { 1Fh   X     X }
    GrdSAM_wSN=                  32; { 20h   X     X }
    GrdSAM_wMask=                34; { 22h   X     X }
    GrdSAM_wGP=                  36; { 24h   X     X }
    GrdSAM_wRealLANRes=          38; { 26h   X     X }
    GrdSAM_dwIndex=              40; { 28h   X     X }
    GrdSAM_abyAlgoAddr=          44; { 2Ch }

{- Guardant Stealth III default Algorithm & Protected Items numbers }
    GrdAN_GSII64=                 0; { GSII64 for automatic protection & use in API }
    GrdAN_HASH64=                 1; { HASH64 for automatic protection & use in API }
    GrdAN_RAND64=                 2; { RAND64 for automatic protection & use in API }
    GrdAN_READ_ONLY=              3; { Protected Item for read only data. Can be updated via Secured Guardant Remote Update }
    GrdAN_READ_WRITE=             4; { Protected Item for read/write data. Can be updated at protected application runtime }
    GrdAN_GSII64_DEMO=            5; { GSII64 demo algorithm for use in guardant examlpes }
    GrdAN_HASH64_DEMO=            6; { HASH64 demo algorithm for use in guardant examlpes }
    GrdAN_ECC160=                 8; { ECC160 for automatic protection & use in API }
    GrdAN_AES128=                 9; { AES128 for automatic protection & use in API }
    GrdAN_GSII64_ENCRYPT=        10; { GSII64_ENCRYPT for automatic protection & use in API }
    GrdAN_GSII64_DECRYPT=        11; { GSII64_DECRYPT for automatic protection & use in API }

{- Guardant Stealth III default Algorithm & Protected Items Request Size }
    GrdARS_GSII64=                8; { GSII64 for automatic protection & use in API }
    GrdARS_HASH64=                8; { HASH64 for automatic protection & use in API }
    GrdARS_RAND64=                8; { RAND64 for automatic protection & use in API }
    GrdARS_READ_ONLY=             8; { Protected Item for read only data. Can be update via Secured Guardant Remote Update }
    GrdARS_READ_WRITE=            8; { Protected Item for read/write data. Can be update at protected application runtime }
    GrdARS_GSII64_DEMO=           8; { GSII64 demo algo for use in guardant examlpes }
    GrdARS_HASH64_DEMO=           8; { HASH64 demo algorithm for use in Guardant examlpes}
    GrdARS_ECC160=               20; { ECC160 for automatic protection & use in API }
    GrdARS_AES128=               16; { AES128 for automatic protection & use in API }
    GrdARS_HASH_SHA256=          0;  {  SHA256 for automatic protection & use in API }

{- Guardant Stealth III default Algorithm & Protected Items maximum Request Size}
    GrdAMRS_GSII64=     248; { GSII64 for automatic protection & use in API}
    GrdAMRS_HASH64=     248; { HASH64 for automatic protection & use in API}
    GrdAMRS_RAND64=     248; { RAND64 for automatic protection & use in API}

{- Guardant Stealth III default Algorithm & Protected Items Determinant Size }
    GrdADS_GSII64=       16; { GSII64 for automatic protection & use in API }
    GrdADS_HASH64=       16; { HASH64 for automatic protection & use in API }
    GrdADS_RAND64=       16; { RAND64 for automatic protection & use in API }
    GrdADS_READ_ONLY=     8; { Protected Item for read only data. Can be updated via Secured Guardant Remote Update }
    GrdADS_READ_WRITE=    8; { Protected Item for read/write data. Can be updated at protected application runtime }
    GrdADS_GSII64_DEMO=  16; { GSII64 demo algo for use in guardant examlpes }
    GrdADS_HASH64_DEMO=  16; { HASH64 demo algo for use in guardant examlpes }
    GrdADS_ECC160=       20; { ECC160 for automatic protection & use in API }
    GrdADS_AES128=       16; { AES128 for automatic protection & use in API }

{ Guardant GSII64 DEMO Algorithm default passwords }
    GrdAP_GSII64_DEMO_ACTIVATION=    $AAAAAAAA;
    GrdAP_GSII64_DEMO_DEACTIVATION=  $DDDDDDDD;
    GrdAP_GSII64_DEMO_READ=          $BBBBBBBB;
    GrdAP_GSII64_DEMO_UPDATE=        $CCCCCCCC;

{ Guardant HASH64 DEMO Algorithm default passwords }
    GrdAP_HASH64_DEMO_ACTIVATION=    $AAAAAAAA;
    GrdAP_HASH64_DEMO_DEACTIVATION=  $DDDDDDDD;
    GrdAP_HASH64_DEMO_READ=          $BBBBBBBB;
    GrdAP_HASH64_DEMO_UPDATE=        $CCCCCCCC;

{- Guardant Stealth Fast EnCode/DeCode Algorithm Types }
    GrdAT_Algo0=         0;   { Basic method }
    GrdAT_AlgoASCII=     1;   { Character method }
    GrdAT_AlgoFile=      2;   { File method }

{- Guardant Stealth API Algorithm use Method }
{- bit 0-5 block chaining mode }
    GrdAM_ECB=           0;   { Electronic Code Book }
    GrdAM_CBC=           1;   { Cipher Block Chaining }
    GrdAM_CFB=           2;   { Cipher Feed Back }
    GrdAM_OFB=           3;   { Output Feed Back }
{- bit 7 - Encode/Decode }
    GrdAM_Encode=        0;   { Encode mode }
    GrdAM_Decode=      $80;   { Decode mode }

{- Software or hardware implemented cryptographic algorithm mode }
{ can be combined with GrdAM_ECB, GrdAM_CBC, GrdAM_CFB, GrdAM_OFB }
{- bit 8-9 First/Next/Last }
    GrdSC_First=    $100; {First data block}
    GrdSC_Next=     $200; {Next data block}
    GrdSC_Last=     $400; {Last data block}
    GrdSC_All=      (GrdSC_First + GrdSC_Next + GrdSC_Last) ;

{ Synonim definitions }
    GrdAM_Encrypt=  GrdAM_Encode;
    GrdAM_Decrypt=  GrdAM_Decode;

{- Hardware-implemented cryptographic or hashing algorithm flag }
    GrdSA_SoftAlgo= $80000000;
{- Software implemented asymmetric cryptoalgorithms for call GrdSign}
    GrdSS_ECC160=   (GrdSA_SoftAlgo + 0);

{- Software-implemented cryptographic algorithm }
    GrdSC_AES256=   (GrdSA_SoftAlgo + 0);

{- Software-implemented  hashing   algorithm }
    GrdSH_CRC32=    (GrdSA_SoftAlgo + 0);
    GrdSH_SHA256=   (GrdSA_SoftAlgo + 1);

{-  Hashing algorithms properties }
    GrdHASH64_DIGEST_SIZE=      8;  { HASH64 algorithm hash size }
    GrdCRC32_DIGEST_SIZE=       4;  { CRC32 algorithm hash size }
    GrdSHA256_DIGEST_SIZE=     32;  { SHA256 algorithm hash size }
    GrdSHA256_CONTEXT_SIZE=  $200;  { must be>= sizeof(SHA256_CONTEXT) }

    GrdAES256_KEY_SIZE=        32;
    GrdAES256_BLOCK_SIZE=      16;
    GrdAES_CONTEXT_SIZE=    $4000;  { must be >= sizeof(AES_CONTEXT) }
    GrdAES256_CONTEXT_SIZE=      GrdAES_CONTEXT_SIZE;  { synonym definition}

{ GrdTRU_PrepareData() mode }
    GrdTRU_Flags_Init=          1;  {Execute Init before Update }
    GrdTRU_Flags_Protect=       2;  {Execute Protect before Update }

{ GrdProtect() and GrdTRU_SetAnswerProperties() global flags }
    GrdGF_ProtectTime=          1;  {  Disable RTC modification by GrdSetTime call }
    GrdGF_HID=                  2;  {  Enable HID mode }
    GrdGF_OnlyOneSessKey=       4;  {  Allow only one instance of Guardant API Protected application to run }
    GrdGF_2ndSessKey=           8;  { Allow only one instance of AutoProtected application to run }

{GrdTRU_DecryptQuestionEx(), GrdTRU_DecryptQuestionTimeEx(), GrdTRU_EncryptAnswerEx(), crypt mode}
    GrdTRU_CryptMode_GSII64=         0;
    GrdTRU_CryptMode_AES128SHA256=   1;

{ GrdPI_Update Methods }
    GrdUM_MOV=      0;
    GrdUM_XOR=      1;

{ Language constants for Convert Guardant error code to text message string via GrdGetErrorMessage() }
    GrdLng_ENG=     0;
    GrdLng_RUS=     7;

{ Guardant get information code constants for GrdGetInfo() }
{ API information }
    GrdGIV_VerAPI=        $0000;  { API version }
{ Common Mode }
    GrdGIM_WorkMode=      $1000;  { Work mode }
    GrdGIM_HandleMode=    $1001;  { Handle mode }
    GrdGIF_Remote=        $2000;  { Local and/or remote (GrdFMR_Local + GrdFMR_Remote)}
    GrdGIF_Flags=         $2001;  { Flags }
    GrdGIF_Prog=          $2002;  { Program number field value}
    GrdGIF_ID=            $2003;  { Dongle ID field value}
    GrdGIF_SN=            $2004;  { Serial number field value}
    GrdGIF_Ver=           $2005;  { Version field value}
    GrdGIF_Mask=          $2006;  { Bit mask field value}
    GrdGIF_Type=          $2007;  { Dongle type field value}
    GrdGIF_Model=         $2008;  { Possible model     bits. 1 << GrdDM_XXX (GS1L, GS1U, GF1L, GS2L, GS2U )}
    GrdGIF_Interface=     $2009;  { Possible interface bits. 1 << GrdDI_XXX (LPT | USB) )}

{ Logon information on current dongle}
    GrdGIL_Remote=        $3000;  { Local or remote dongle}
    GrdGIL_ID=            $3001;  { ID of current dongle}
    GrdGIL_Model=         $3002;  { Model of current dongle}
    GrdGIL_Interface=     $3003;  { Interface of current dongle}
    GrdGIL_LockCounter=   $3005;  { Lock counter value for current dongle}
    GrdGIL_Seek=          $3006;  { Current dongle memory address}

{ Logon information on current local or remote dongle driver }
    GrdGIL_DrvVers=       $4000;  { Driver       version ($04801234=4.80.12.34)}
    GrdGIL_DrvBuild=      $4001;  { Driver       build}
    GrdGIL_PortLPT=       $4002;  { LPT port address (0 == USB)}

{ Logon information on current remote dongle}
    GrdGIR_VerSrv=               $5000;  { Guardant Net server version}
    GrdGIR_LocalIP=              $5001;  { Guardant Net local  IP}
    GrdGIR_LocalPort=            $5002;  { Guardant Net local  IP port}
    GrdGIR_LocalNB=              $5003;  { Guardant Net local  NetBIOS name}
    GrdGIR_RemoteIP=             $5004;  { Guardant Net remote IP}
    GrdGIR_RemotePort=           $5005;  { Guardant Net remote IP port}
    GrdGIR_RemoteNB=             $5006;  { Guardant Net remote NetBIOS name}
    GrdGIR_HeartBeatThread=      $5007;  { Handle of internal heartbeat thread}
    GrdGIR_IniTimeOutSend=       $5008;  { Send operation timeout in seconds. Requires the API to be started up with GrdFMR_Remote flag.                       }
    GrdGIR_IniTimeOutReceive=    $5009;  { Receive operation timeout in seconds. Requires the API to be started up with GrdFMR_Remote flag.                    }
    GrdGIR_IniTimeOutSearch=     $500A;  { Broadcasting search timeout in seconds. Requires the API to be started up with GrdFMR_Remote flag.                  }
    GrdGIR_IniClientUDPPort=     $500B;  { Client's UDP port for sending of datagrams to a server. Requires the API to be started up with GrdFMR_Remote flag.  }
    GrdGIR_IniServerUDPPort=     $500C;  { Server's UDP port for sending of replies to a client. Requires the API to be started up with GrdFMR_Remote flag.    }
    GrdGIR_IniBroadcastAddress=  $500D;  { Broadcasting address . Requires the API to be started up with GrdFMR_Remote flag.                                   }
    GrdGIR_IniFileName=          $500E;  { Initialization file name. Requires the API to be started up with GrdFMR_Remote flag.                                }
    GrdGIR_LocalMACAddress=      $500F;  { MAC address of the local network adapter. Requires the API to be started up with GrdFMR_Remote flag.                }
    GrdGIR_FullHostName=         $5010;  { Full name of the local host. Requires the API to be started up with GrdFMR_Remote flag.                             }
    GrdGIR_IniServerIPName=      $5011;  { Server IP address or host name. Requires the API to be started up with GrdFMR_Remote flag.                          }

{- CRC Starting value}
    Grd_StartCRC=     $FFFFFFFF;  { Starting value for 'continued' CRC}
    GrdSeekCur=       $FFFFFFFF;  { Use current dongle memory pointer associated with handle}

{- Error codes}
    GrdE_OK=                                      0; { No errors                           }
    GrdE_DongleNotFound=                          1; { Dongle with specified search conditions not found}
                                                     { 2 Code not found (N/A)}
    GrdE_AddressTooBig=                           3; { The specified address is too big    }
                                                     { 4 Byte counter too big  N/A}
    GrdE_GPis0=                                   5; { GP executions counter exhausted (has 0 value)  }
    GrdE_InvalidCommand=                          6; { Invalid dongle call command}
                                                     { 7  not used (N/A)}
    GrdE_VerifyError=                             8; { Write verification error}
    GrdE_NetProtocolNotFound=                     9; { Network protocol not found}
    GrdE_NetResourceExhaust=                     10; { License counter of Guardant Net exhausted}
    GrdE_NetConnectionLost=                      11; { Connection with Guardant Net server was lost}
    GrdE_NetDongleNotFound=                      12; { Guardant Net server not found}
    GrdE_NetServerMemory=                        13; { Guardant Net server memory allocation error}
    GrdE_DPMI=                                   14; { DPMI error}
    GrdE_Internal=                               15; { Internal error}
    GrdE_NetServerReloaded=                      16; { Guardant Net server has been reloaded}
    GrdE_VersionTooOld=                          17; { This command is not supported by this dongle version}
    GrdE_BadDriver=                              18; { Windows NT driver is required}
    GrdE_NetProtocol=                            19; { Network protocol error}
    GrdE_NetPacket=                              20; { Network packet format is not supported}
    GrdE_NeedLogin=                              21; { Logging in is required}
    GrdE_NeedLogout=                             22; { Logging out is required}
    GrdE_DongleLocked=                           23; { Guardant dongle is busy (locked by another copy of protected application)}
    GrdE_DriverBusy=                             24; { Guardant driver cannot capture the parallel port}
                                                     { 25 - 29 not used}
    GrdE_CRCError=                               30; { CRC error occurred while attempting to call the dongle}
    GrdE_CRCErrorRead=                           31; { CRC error occurred while attempting to read data from the dongle}
    GrdE_CRCErrorWrite=                          32; { CRC error occurred while attempting to write data to the dongle}
    GrdE_Overbound=                              33; { The boundary of the dongle's memory has been override}
    GrdE_AlgoNotFound=                           34; { The hardware algorithm with this number has not been found in the dongle}
    GrdE_CRCErrorFunc=                           35; { CRC error of the hardware algorithm}
    GrdE_AllDonglesFound=                        36; { All dongles found, or CRC error occurred while attempting to execute ChkNSK operation}
    GrdE_ProtocolNotSup=                         37; { Guardant API release is too old}
    GrdE_InvalidCnvType=                         38; { Non-existent reversible conversion method has been specified}
    GrdE_UnknownError=                           39; { Unknown error occurred while attempting to call the algorithm or protected item, operation may be incomplete}
    GrdE_AccessDenied=                           40; { Invalid password}
    GrdE_StatusUnchangeable=                     41; { Error counter has been exhausted for this Protected Item}
    GrdE_NoService=                              42; { Specified algorithm or protected item does not support requested service}
    GrdE_InactiveItem=                           43; { Specified algorithm or protected item is inactive, command has not been executed}
    GrdE_DongleServerTooOld=                     44; { Dongle server does not support specified command}
    GrdE_DongleBusy=                             45; { Dongle is busy at this moment. The command cannot be executed. The dongle keeps busy for 11 seconds after GrdInit}
    GrdE_InvalidArg=                             46; { One or more arguments are invalid}
    GrdE_MemoryAllocation=                       47; { Memory allocation error}
    GrdE_InvalidHandle=                          48; { Invalid handle}
    GrdE_ContainerInUse=                         49; { This protected container is already in use}
    GrdE_Reserved50=                             50; { Reserved}
    GrdE_Reserved51=                             51; { Reserved}
    GrdE_Reserved52=                             52; { Reserved}
    GrdE_SystemDataCorrupted=                    53; { Remote update system data corrupted}
    GrdE_NoQuestion=                             54; { Remote update question has not been generated}
    GrdE_InvalidData=                            55; { Invalid remote update data format}
    GrdE_QuestionOK=                             56; { Remote update question has been already generated}
    GrdE_UpdateNotComplete=                      57; { Remote update writing has not been completed}
    GrdE_InvalidHash=                            58; { Invalid remote update data hash}
    GrdE_GenInternal=                            59; { Internal error}
    GrdE_AlreadyInitialized=                     60; { This copy of Guardant API has been already initialized}
    GrdE_RTC_Error=                              61; { Real Time Clock error }
    GrdE_BatteryError=                           62; { Real Time Clock battery low error }
    GrdE_DuplicateNames=                         63; { Duplicate items/algorithms names }
    GrdE_AATFormatError=                         64; { Address in AAT table is out of range }
    GrdE_SessionKeyNtGen=                        65; { Session key not generated }
    GrdE_InvalidPublicKey=                       66; { Invalid public key }
    GrdE_InvalidDigitalSign=                     67; { Invalid digital sign }
    GrdE_SessionKeyGenError=                     68; { Session key generation error }
    GrdE_InvalidSessionKey=                      69; { Invalid session key }
    GrdE_SessionKeyTooOld=                       70; { Session key too old }
    GrdE_NeedInitialization=                     71; { Initialization is required }
    GrdE_gcProhibitCode=                         72; { Verification of loadable code failed }{ Probable reasons: invalid entry point, forbidden insructions } { in the code, attempt to access prohibited memory address}
    GrdE_LoadableCodeTimeOut=                    73; { Loadable code time out}
    GrdE_FlashSizeFromDescriptorTooSmall=        74; { Flash memory size specified in item descriptor for loadable code is too small }
    GrdE_Reserved75=                             75; { Reserved }
    GrdE_Reserved76=                             76; { Reserved }
    GrdE_Reserved77=                             77; { Reserved }
    GrdE_Reserved78=                             78; { Reserved }
    GrdE_Reserved79=                             79; { Reserved }
    GrdE_gcIncorrectMask=                        80; { TGrdLoadableCodeData structure exceeds space reserved for determinant in item descriptor }
    GrdE_gcRamOverboundInProtect=                81; { Incorrect RAM area specified in loadable code descriptor                                  }
    GrdE_gcFlashOverboundInProtect=              82; { Incorrect FLASH memory area specified in loadable code descriptor                          }
    GrdE_gcIntersectionOfCodeAreasInProtect=     83; { Allocation of intersecting FLASH memory areas for different loadable code modules           }
    GrdE_gcBmapFileTooBig=                       84; { BMAP file is too long                                                                        }
    GrdE_gcZeroLengthProgram=                    85; { The loadable code has zero length                                                             }
    GrdE_gcDataCorrupt=                          86; { Data verification failed                                                                       }
    GrdE_gcProtocolError=                        87; { Error in Guardant Code protocol                                                                 }
    GrdE_gcGCEXENotFound=                        88; { Loadable code not found                                                                          }
    GrdE_gcNotEnoughRAM=                         89; { IO buffer size specified in loadable code is not enough for transmitting/receiving data           }
    GrdE_gcException=                            90; { Security violation in Guardant Code virtual environment                                            }
    GrdE_gcRamOverboundInCodeLoad=               91; { IO buffer specified in loadable code exceeds the bounds of allowed RAM area                         }
    GrdE_gcFlashOverboundInCodeLoad=             92; { Loadable code exceeds the bounds of allowed FLASH memory area                                        }
    GrdE_gcIntersectionOfCodeAreasInCodeLoad=    93; { Allocation of intersecting RAM areas for different loadable code modules ( Init operation is required)}
    GrdE_gcGCEXEFormatError=                     94; { Incorrect GCEXE file format                                                                            }
    GrdE_gcRamAccessViolation=                   95; { Incorrect RAM area specified in loadable code for GcaCodeRun}
    GrdE_gcCallDepthOverflow=                    96; { Too many nested calls of GcaCodeRun}
    GrdE_LastError=                              97; { Total number of errors }


{ Dongle State Flags }
    GrdDSF_RTC_Quality=                           1; { Real Time Clock Quality error flag }
    GrdDSF_RTC_Battery=                           2; { Real Time Clock Battery error flag }

{- Loadable Code state (for TGrdCodeUFPublicData.bState):}
    GrdCodeState_CodeNotLoad=                     0; { - not loading. }
    GrdCodeState_CodeStartLoad=                   1; { - loading now. }
    GrdCodeState_CodeOk=                          2; { - loaded now.  }

    GrdNotifyMessage_DongleArrived=               0; { Dongle has been connected to USB port   }
    GrdNotifyMessage_DongleRemoved=               1; { Dongle has been disconnected from USB port}

{ Initialise this copy of GrdAPI. GrdStartup called once before calls of GrdAPI at startup application }
    function GrdStartup(dwRemoteMode:DWORD):DWORD; stdcall; external;

{ Support user defined path to gnClient.ini file }
    function GrdStartupEx (dwRemoteMode:DWORD;                  { Local and/or remote (GrdFMR_Local + GrdFMR_Remote) }
                           szNetworkClientIniPath: pointer;     { Path to gnClient.ini. NULL default place near application executable }
                           pReserved:pointer ):integer; stdcall; external; { Reserved Must by nil }

{ DeInitialise this copy of GrdAPI. GrdCleanup called once after all calls of GrdAPI before terminate application }
    function GrdCleanup():integer; stdcall; external;

{ Must be called at the beginning of any Win32 DllMain function }
    function GrdDllMain(hinstDLL:HANDLE;
                        fdwReason:DWORD;
                        lpvReserved:pointer):integer; stdcall; external;

{ Get last error information from prootected container with specifed handle }
{ The last-error code is maintained on a per-handle basis }
{ Multiple handles do not overwrite each other's last-error code }
    function GrdGetLastError(hGrd:HANDLE; ppLastErrFunc:pointer ):integer; stdcall; external;

{ Convert Guardant error code to text message string }
    function GrdFormatMessage(hGrd:HANDLE;                { if != nil then handle for GrdGetLastError() }
                              nErrorCode:integer;         { if hGrd == nil then Guardant error code. Else ignored }
                              nLanguage:integer;          { Guardant language ID }
                              szErrorMsg:pointer;         { Pointer to a buffer for the formatted (and nil-terminated) message. }
                              nErrorMsgSize:integer;      { this parameter specifies the maximum number of characters that can be stored in the output buffer. }
                              pReserved:pointer ):integer; stdcall; external;   { reserved and must by nil }

{ Get requested information }
    function GrdGetInfo(hGrd:HANDLE;         { Handle to Guardant protected container}
                        dwInfoCode:DWORD;    { code of requested information. See GrdGIX_XXXXX }
                        pInfoData:pointer;   { Pointer to buffer for return data}
                        dwInfoSize:DWORD     { Number of bytes for returning }
                        ):integer; stdcall; external;  { reserved & must be nil }

{ Prootected container handle validator }
    function GrdIsValidHandle(hGrd:HANDLE):BOOL; stdcall; external;

{ Create Grd protected container & return it handle }
    function GrdCreateHandle(hGrd:HANDLE;    { hGrd - address for place of new container or nil if need allocate memory for it }
                             dwMode:DWORD;   { Create Handle Mode flags. See GrdCHM_XXXXX definition }
                             pReserved:pointer):HANDLE; stdcall; external; { must by nil }

{ Close corresponding handle. }
{ If need process Logout, clear container & free allocated memory }
    function GrdCloseHandle(hGrd:HANDLE):integer; stdcall; external;

{ Store dongle codes in Guardant protected container }
    function GrdSetAccessCodes(hGrd:HANDLE;         { Handle to guardant protected container }
                               dwPublic:DWORD;      { Must by allready specifed }
                               dwPrivateRD:DWORD;   { Must by allready specifed }
                               dwPrivateWR:DWORD;   { == 0 if not need }
                               dwPrivateMST:DWORD ):integer; stdcall; external; { == 0 if not need }

{ Set dongle working mode to Guardant protected container }
    function GrdSetWorkMode(hGrd:HANDLE;
                            dwFlagsWork:DWORD;  { combination of GrdSWML_XXXX flags }
                            dwFlagsMode:DWORD)  { combination of GrdWMFM_XXXX flags }:integer; stdcall; external;

{ Set dongle search conditions and operation modes to Guardant protected conteiner }
    function GrdSetFindMode(hGrd:HANDLE;        { Handle to guardant protected container }
                            dwRemoteMode:DWORD; { Local and/or remote (GrdSMF_Local + GrdSMF_Remote) }
                            dwFlags:DWORD;      { combination of GrdSFM_XXXXX flags }
                            dwProg:DWORD;
                            dwID:DWORD;
                            dwSN:DWORD;
                            dwVer:DWORD;
                            dwMask:DWORD;
                            dwType:DWORD;
                            dwModels:DWORD;     { possible dongle model bits. See GrdFMM_GSX definition }
                            dwInterfaces:DWORD):integer; stdcall; external; { possible dongle interface bits. See GrdFMI_XXX definition }

{ Obtain the ID and other dongle info of the first or next dongle found }
    function GrdFind(hGrd:HANDLE;         { handle to guardant protected container }
                     dwMode:DWORD;        { GrdF_First or GrdF_Next }
                     pdwID:pointer;       { pointer to variable for return dongle ID }
                     pFindInfo:pointer ):integer; stdcall; external;    { place for return key info or nil for ignore it in other lang-s }

{ Login to Guardant Net server to a specified resource }
    function GrdLogin(hGrd:HANDLE;        { handle to guardant protected container }
                      dwModuleLMS:DWORD;  { module number or -1 if License Management System functions are not used }
                      dwLoginFlags:DWORD ){ Login flags (GrdLM_PerStation or GrdLM_PerHandle)}:integer; stdcall; external;

{ Login to Guardant Net server to a specified resource }
    function GrdLogout(hGrd:HANDLE;       { handle to logged in guardant protected container }
                       dwMode:DWORD ):integer; stdcall; external;   { == nil if not need }

{ Increment lock counter of specifed Dongle }
    function GrdLock(hGrd:HANDLE;                  { Handle to logged in guardant protected container }
                     dwTimeoutWaitForUnlock:DWORD; { Max GrdAPI unlock waiting time. -1 == infinity. 0 == no wait }
                     dwTimeoutAutoUnlock:DWORD;    { Max dongle locking time in ms.  -1 == infinity. 0 == 10000 ms (10 sec) }
                     dwMode:DWORD ):integer; stdcall; external;

{ Unlock Guardant dongle }
    function GrdUnlock(hGrd:HANDLE):integer; stdcall; external;

{ Check for availability of the dongle }
    function GrdCheck(hGrd:HANDLE):integer; stdcall; external;

{ Check for availability of the dongle and decrement GP executions counter }
    function GrdDecGP(hGrd:HANDLE):integer; stdcall; external;

{ Read a block of bytes from the dongle's memory }
{ and return number of actually readed bytes }
    function GrdRead (hGrd:HANDLE;  { Handle to Guardant protected container }
                      dwAddr:DWORD; { Starting address in dongle memory to be read }
                      dwLng:DWORD;  { Length of data to be read }
                      pData:pointer;{ Buffer for data to be read }
                      pReserved:pointer ):integer; stdcall; external; { Reserved must be nil}

{ Write a block of bytes into the dongle's memory }
{ and return number of actually writed bytes }
    function GrdWrite(hGrd:HANDLE;  { Handle to Guardant protected container }
                      dwAddr:DWORD; { Starting address in dongle memory to be written }
                      dwLng:DWORD;  { Length of data to be written }
                      pData:pointer;{ Buffer for data to be written }
                      pReserved:pointer):integer; stdcall; external; { Reserved must be nil}

{ Moves the dongle memory pointer associated with handle to a new location that is offset bytes from origin}
{ of dongle memory in current addressing mode. The next operation on the handle takes place at the new location.}
    function GrdSeek(hGrd:HANDLE;
                     dwAddr:DWORD):integer; stdcall; external;

{ Initialize the dongle's memory }
    function GrdInit(hGrd:HANDLE):integer; stdcall; external;

{ Implement locks / Specify the number of hardware algorithms}
{ and LMS table address}
{ Requires Private master code to be specified in GrdSetAccessCodes}
    function GrdProtect(hGrd:HANDLE;         {Handle to Guardant protected container}
                        dwWrProt:DWORD;      { SAM addres of the first byte available for writing in bytes }
                        dwRdProt:DWORD;      { SAM addres of the first byte available for reading in bytes }
                        dwNumFunc:DWORD;     { Number of hardware-implemented algorithms in the dongle including all protected items and LMS table of Net III }
                        dwTableLMS:DWORD;    { Net II: SAM address of the first byte of LMS Table in 2-byte words; }
                                             { Net III: number of protected item that contains LMS Table }
                        dwGlobalFlags:DWORD; { Reserved, must be 0 }
                        pReserved:pointer)   { Reserved, must be 0 }:integer; stdcall; external;

{--- Cryptographic functions}

{ Transform a block of bytes using dongle's hardware algorithm (also and GSII64 too) }
    function GrdTransform(hGrd:HANDLE; dwAlgoNum:DWORD;dwLng:DWORD;pData:pointer;
                          dwMethod:DWORD;    { if Stealth I or Fidus it must by 0 }
                          pIV:pointer):integer; stdcall; external; { if Stealth I or Fidus it must by nil }

    function GrdTransformEx(hGrd:HANDLE; dwAlgoNum:DWORD;dwDataLng:DWORD;pData:pointer;
                            dwMethod:DWORD;  { if Stealth I or Fidus it must by 0. Otherwise - combination of GrdAM_XXX flags }
                            dwIVLng:DWORD;   { IV length }
                            pIV:pointer;     { if Stealth I or Fidus it must by nil. Otherwise - n-bytes initialization vector }
                            pReserved:pointer):integer; stdcall; external; { Reserved, must be nil }

{ Crypt a block of bytes using cryption algorithm }
    function GrdCrypt(hGrd:HANDLE;       { Handle for setting last error }
                      dwAlgo:DWORD;      { Number of hardware- or software-implemented algorithm }
                      dwDataLng:DWORD;   { Data length }
                      pData:pointer;     { Data for Encryption/Decryption }
                      dwMethod:DWORD;    { Encrypt/Decrypt, First/Next/Last, block chaining modes (ECB/OFB/...) }
                      pIV:pointer;       { Initialisation Vector }
                      pKeyBuf:pointer;   { Encryption/decryption secret key for software-implemented algorithm (nil if not used) }
                      pContext:pointer):integer; stdcall; external; {Context for multiple-buffer encryption. Must be corresponded GrdXXXXXX_CONTEXT_SIZE bytes size }

    function GrdCryptEx(hGrd:HANDLE;         { Handle for setting last error }
                        dwAlgo:DWORD;        { Number of hardware- or software-implemented algorithm }
                        dwDataLng:DWORD;     { Data length }
                        pData:pointer;       { Data for Encryption/Decryption }
                        dwMethod:DWORD;      { Encrypt/Decrypt, First/Next/Last, block chaining modes (ECB/OFB/...) }
                        dwIVLng:DWORD;       { IV length }
                        pIV:pointer;         { Initialisation Vector }
                        pKeyBuf:pointer;     { Encryption/decryption secret key for software-implemented algorithm (nil if not used) }
                        pContext:pointer;    { Context for multiple-buffer encryption. Must be corresponded GrdXXXXXX_CONTEXT_SIZE bytes size }
                        pReserved:pointer):integer; stdcall; external; { Reserved, must be nil }

{ Hash calculation of a block of bytes }
    function GrdHash(hGrd:HANDLE;            { handle for set last error }
                     dwHash:DWORD;           { number of software or hardware realised hash algo }
                     dwDataLng:DWORD;        { data length }
                     pData:pointer;          { data for hash calculation }
                     dwMethod:DWORD;         { GrdSC_First/GrdSC_Next/GrdSC_Last }
                     pDigest:pointer;        { place for hash on GrdSC_Last step }
                     pKeyBuf:pointer;        { software hash calculation secret key (nil if not used) }
                     pContext:pointer):integer; stdcall; external;  { Context for multy buffer calculation. Must by corresponded GrdXXXXXX_CONTEXT_SIZE bytes size }

    function GrdHashEx(hGrd:HANDLE;          { handle for set last error }
                       dwHash:DWORD;         { number of software or hardware realised hash algo }
                       dwDataLng:DWORD;      { data length }
                       pData:pointer;        { data for hash calculation }
                       dwMethod:DWORD;       { GrdSC_First/GrdSC_Next/GrdSC_Last }
                       dwDigestLng:DWORD;    { Digest length }
                       pDigest:pointer;      { place for hash on GrdSC_Last step }
                       dwKeyBufLng:DWORD;    { Key length }
                       pKeyBuf:pointer;      { software hash calculation secret key (nil if not used) }
                       dwContextLng:DWORD;   { Context length}
                       pContext:pointer;     { Context for multy buffer calculation. Must by corresponded GrdXXXXXX_CONTEXT_SIZE bytes size }
                       pReserved:pointer):integer; stdcall; external;

{--- Old compatibility software coding functions }

{ Initialize a password for fast reversible conversion }
    function GrdCodeInit(hGrd:HANDLE; dwCnvType:DWORD; dwAddr:DWORD; pKeyBuf:pointer):integer; stdcall; external;

{ Encode data using fast reversible conversion }
    function GrdEnCode(dwCnvType:DWORD; pKeyBuf:pointer; pData:pointer; dwLng:DWORD):integer; stdcall; external;

{ Decode data using fast reversible conversion }
    function GrdDeCode(dwCnvType:DWORD; pKeyBuf:pointer; pData:pointer; dwLng:DWORD):integer; stdcall; external;

{ Calculate 32-bit CRC of a memory block }
    function GrdCRC(pData:pointer; dwLng:DWORD; dwPrevCRC:DWORD):integer; stdcall; external;


{--- Protected Item functions }
    function GrdPI_Activate(hGrd:HANDLE;            { Handle to logged in protected container }
                            dwItemNum:DWORD;        { Logged in dongle Algorithm or Protected Item number }
                            dwActivatePsw:DWORD ):integer; stdcall; external;{ optional password if need. Else must be 0 }

{ Dectivate dongle Algorithm or Protected Item }
    function GrdPI_Deactivate(hGrd:HANDLE;          { Handle to logged in protected container }
                              dwItemNum:DWORD;      { Logged in dongle Algorithm or Protected Item number }
                              dwDeactivatePsw:DWORD ):integer; stdcall; external; { Optional password. If not used, must be 0}

{ Read data from dongle Protected Item }
    function GrdPI_Read (hGrd:HANDLE;           { Handle to logged in protected container }
                         dwItemNum:DWORD;       { Logged in dongle Algorithm or Protected Item number }
                         dwAddr:DWORD;          { Offset in Algorithm or Protected Item data }
                         dwLng:DWORD;           { number of bytes for reading }
                         pData:pointer;         { Pointer to buffer for read data }
                         dwReadPsw:DWORD;       { Optional password if need. Else must be 0 }
                         pReserved:pointer ):integer; stdcall; external;  { Reserved must be nil }

{ Update data in dongle Protected Item }
    function GrdPI_Update(hGrd:HANDLE;          { Handle to logged in protected container }
                          dwItemNum:DWORD;      { Logged in dongle Algorithm or Protected Item number }
                          dwAddr:DWORD;         { Offset in Algorithm or Protected Item data }
                          dwLng:DWORD;          { number of bytes for reading }
                          pData:pointer;        { pointer to buffer with write data }
                          dwUpdatePsw:DWORD;    { optional password if need. Else must be 0 }
                          dwMethod:DWORD;       { Update method. See GrdUM_XXX definitions }
                          pReserved:pointer ):integer; stdcall; external; { Reserved must be nil }


{ --- Remote Update API }

{ Write GSII64 encription algorithm secret key for Guardant Remote Update }
    function GrdTRU_SetKey(hGrd:HANDLE;         { Handle to logged in protected container }
                                                { Unique Trusted Remote Update GSII64 128-bit secret key}
                           pKey128:pointer ):integer; stdcall; external;

{ Generate encrypted question and initialize remote update procedure }
    function GrdTRU_GenerateQuestionEx(hGrd:HANDLE;              { Handle to logged in protected container }
                                       dwLngQuestion:DWORD;      { Size Question buf. }
                                       pQuestion:pointer;        { Pointer to Question }
                                       pdwID:DWORD;              { Pointer to ID 4 bytes }
                                       pdwPublic:DWORD;          { Pointer to Dongle Public Code 4 bytes }
                                       dwLngHash:DWORD;          { Size Hash buf. }
                                       pHash:pointer;            { Pointer to Hash of prev }
                                       dwReserved:DWORD;         { Reserved, must be 0 }
                                       pReserved:pointer ):integer; stdcall; external;      { Reserved, must be nil }

{ Generate encrypted question and initialize remote update procedure }
    function GrdTRU_GenerateQuestion(hGrd:HANDLE;         { Handle to logged in protected container }
                                     pQuestion:pointer;   { Pointer to Question     8 bytes (64 bit) }
                                     pdwID:pointer;       { Pointer to ID  4 bytes}
                                     pdwPublic:pointer;   { Pointer to Dongle Public Code   4 bytes }
                                     pHash:pointer ):integer; stdcall; external;  { Pointer to Hash of prev 16 bytes   8 bytes}

{ Generate encrypted question and initialize remote update procedure }
    function GrdTRU_GenerateQuestionTimeEx(hGrd:HANDLE;          { Handle to logged in protected container }
                                           dwLngQuestion:DWORD;      { Size for Question }
                                           pQuestion:pointer;         { Pointer to Question }
                                           pdwID:pointer;             { Pointer to ID 4 bytes }
                                           pdwPublic:pointer;         { Pointer to Dongle Public Code 4 bytes }
                                           pqwDongleTime:pointer;
                                           dwDeadTimesSize:DWORD ;
                                           pqwDeadTimes:pointer;
                                           pdwDeadTimesNumbers:pointer;
                                           dwLngHash:DWORD;          { Size for Hash }
                                           pHash:pointer;             { Pointer to Hash of previous data }
                                           dwReserved:DWORD;         { Reserved, must be 0 }
                                           pReserved:pointer ):integer; stdcall; external;      { Reserved, must be nil }
{ Generate encrypted question and initialize remote update procedure }
    function GrdTRU_GenerateQuestionTime(hGrd:HANDLE;          { Handle to Guardant protected container }
                                         pQuestion:pointer;    { Pointer to Question  8 bytes (64 bit) }
                                         pdwID:pointer;        { Pointer to ID  4 bytes }
                                         pdwPublic:pointer;    { Pointer to Dongle Public Code 4 bytes }
                                         pqwDongleTime:pointer;{ Pointer to Dongle Time (encrypted)  8 bytes }
                                         dwDeadTimesSize:DWORD;
                                         pqwDeadTimes:pointer;
                                         pdwDeadTimesNumbers:pointer;
                                         pHash:pointer;        { Pointer to Hash of previous data }
                                         pReserved:pointer):integer; stdcall; external; { Reserved, must be nil }

{ Decrypt encrypted question and validate it data }
    function GrdTRU_DecryptQuestionEx(hGrd:HANDLE;              { Handle to Guardant protected container }
                                      dwAlgoNum_Decrypt:DWORD;  { Dongle decrypt algorithm number with same key as in remote dongle }
                                      dwAlgoNum_Hash:DWORD;     { Dongle HASH algorithm number with same key as in remote dongle }
                                      dwLngQuestion:DWORD;      { Size for Question }
                                      pQuestion:pointer;        { Pointer to Question }
                                      dwID:DWORD;               { ID 4 bytes }
                                      dwPublic:DWORD;           { Public Code  4 bytes }
                                      dwLngHash:DWORD;          { Size for Hash }
                                      pHash:pointer;            { Pointer to Hash of prev }
                                      dwMode:DWORD;             { GrdTRU_CryptMode_GSII64      : crypt=gsII64( 8 byte), hash=based on gsII64(8 byte) }
                                                                { GrdTRU_CryptMode_AES128SHA256: crypt=aes128(16 byte), hash=sha256(32 byte) }
                                  dwReserved:DWORD;             { Reserved, must be 0 }
                                  pReserved:pointer):integer; stdcall; external; { Reserved, must be nil }

{ Decrypt encrypted question and validate it data }
    function GrdTRU_DecryptQuestion(hGrd:HANDLE;                  { Handle to logged in protected container of dongle with }
                                                                  { GSII64 algorithm number with same key as in remote update dongle }
                                    dwAlgoNum_GSII64:DWORD;   { Dongle GSII64 algorithm number with same key as in remote update dongle }
                                    dwAlgoNum_HashS3:DWORD;   { Dongle HASH algorithm number with same key as in remote update dongle }
                                    pQuestion:pointer;        { pointer to Question 8 bytes (64 bit) }
                                    dwID:DWORD;               { ID 4 bytes }
                                    dwPublic:DWORD;           { Public Code 4 bytes }
                                    pHash:pointer ):integer; stdcall; external;{ Pointer to Hash of previous 16 bytes 8 bytes }

{ Decrypt and validate question }
    function GrdTRU_DecryptQuestionTimeEx(hGrd:HANDLE;              { Handle to logged in protected container of dongle with }
                                          dwAlgoNum_Decrypt:DWORD;  { Dongle decrypt algorithm number with same key as in remote dongle }
                                          dwAlgoNum_Hash:DWORD;     { Dongle HASH algorithm number with same key as in remote dongle }
                                          dwLngQuestion:DWORD;      { Size for Question  }
                                          pQuestion:pointer;        { Pointer to Question }
                                          dwID:DWORD;               { ID                                   4 bytes }
                                          dwPublic:DWORD;           { Public Code                          4 bytes }
                                          pqwDongleTime:pointer;    { Pointer to Dongle Time (encrypted)   8 bytes }
                                          pqwDeadTimes:pointer;
                                          dwDeadTimesNumbers:DWORD;
                                          dwLngHash:DWORD;          { Size for Hash }
                                          pHash:pointer;            { Pointer to Hash of previous }
                                          dwMode:DWORD;             { GrdTRU_CryptMode_GSII64      : crypt=gsII64( 8 byte), hash=based on gsII64(8 byte) }
                                                                    { GrdTRU_CryptMode_AES128SHA256: crypt=aes128(16 byte), hash=sha256(32 byte) }
                                          dwReserved:DWORD;         { Reserved, must be 0 }
                                          pReserved:pointer):integer; stdcall; external; { Reserved, must be nil }

{ Decrypt and validate question }
    function GrdTRU_DecryptQuestionTime(hGrd:HANDLE;              { Handle to Guardant protected container of dongle that contains }
                                                                  { GSII64 algorithm with the same key as in remote dongle }
                                        dwAlgoNum_GSII64:DWORD;   { Dongle GSII64 algorithm number with same key as in remote dongle }
                                        dwAlgoNum_HashS3:DWORD;   { Dongle HASH64 algorithm number with same key as in remote dongle }
                                        pQuestion:pointer;        { Pointer to Question 8 bytes (64 bit) }
                                        dwID:DWORD;               { ID 4 bytes }
                                        dwPublic:DWORD;           { Public Code 4 bytes }
                                        pqwDongleTime:pointer;    { Pointer to Dongle Time (encrypted) 8 bytes }
                                        pqwDeadTimes:pointer;
                                        dwDeadTimesNumbers:DWORD;
                                        pHash:pointer):integer; stdcall; external; { Pointer to Hash of previous 16 bytes 8 bytes }

{ Set Init & Protect parameters for Trusted Remote Update}
{ This function must be called after GrdTRU_DecryptQuestion and before GrdTRU_EncryptAnswer functions}
{ only if Init & Protect operations will be executed during remote update (call GrdTRU_ApplyAnswer) procedure on remote PC }
    function GrdTRU_SetAnswerProperties(hGrd:HANDLE;              { Handle to Guardant protected container }
                                        dwTRU_Flags:DWORD;        { Use Init & Protect or not}
                                        dwReserved:DWORD;         { Reserved, must be 0}
                                        dwWrProt:DWORD;           { remote GrdProtect parameters, SAM addres of the first word available for writing in bytes }
                                        dwRdProt:DWORD;           { remote GrdProtect parameters, SAM addres of the first word available for reading in bytes }
                                        dwNumFunc:DWORD;          { remote GrdProtect parameters, Number of hardware-implemented algorithms in the dongle including all protected items and LMS table of Net III }
                                        dwTableLMS:DWORD;         { remote GrdProtect parameters, Net III: number of protected item that contains LMS Table }
                                        dwGlobalFlags:DWORD;      { remote GrdProtect parameters, Reserved, must be 0}
                                        pReserved:pointer ):integer; stdcall; external; { remote GrdProtect parameters, Reserved, must be nil}

{ Prepare data for Trusted Remote Update}
    function GrdTRU_EncryptAnswerEx(hGrd:HANDLE;                 { Handle to Guardant protected container }
                                                                  { encrypt algorithm with the same key as in remote dongle }
                                                                  { and pre-stored GrdTRU_SetAnswerProperties data if needed }
                                     dwAddr:DWORD;                { Starting address for writing in dongle }
                                     dwLng:DWORD;                 { Size of data to be written }
                                     pData:pointer;               { Buffer for data to be written  }
                                     dwLngQuestion:DWORD;         { Size for Question }
                                     pQuestion:pointer;           { Pointer to decrypted Question }
                                     dwAlgoNum_Encrypt:DWORD;     { Dongle encrypt algorithm number with the same key as in remote dongle }
                                     dwAlgoNum_Hash:DWORD;        { Dongle HASH algorithm number with the same key as in remote dongle }
                                     pAnswer:pointer;             { Pointer to the buffer for Answer data }
                                     pdwAnswerSize:pointer;       { IN: Maximum buffer size for Answer data, OUT: Size of pAnswer buffer }
                                     dwMode:DWORD;                { GrdTRU_CryptMode_GSII64      : crypt=gsII64( 8 byte), hash=based on gsII64(8 byte) }
                                                                  { GrdTRU_CryptMode_AES128SHA256: crypt=aes128(16 byte), hash=sha256(32 byte) }
                                     dwReserved:DWORD;            { Reserved, must be 0 }
                                     pReserved:pointer ):integer; stdcall; external; { remote GrdProtect parameters, Reserved, must be nil}

{ Prepare data for Trusted Remote Update}
    function GrdTRU_EncryptAnswer(hGrd:HANDLE;              { Handle to Guardant protected container of dongle that contains }
                                                            { GSII64 algorithm with the same key as in remote dongle }
                                                            { and pre-stored GrdTRU_SetAnswerProperties data if needed }
                                  dwAddr:DWORD;             { Starting address for writing in dongle }
                                  dwLng:DWORD;              { Size of data to be written }
                                  pData:pointer;            { Buffer for data to be written }
                                  pQuestion:pointer;        { Pointer to decrypted Question         8 bytes (64 bit) }
                                  dwAlgoNum_GSII64:DWORD;   { Dongle GSII64 algorithm number with the same key as in remote dongle }
                                  dwAlgoNum_HashS3:DWORD;   { Dongle HASH algorithm number with the same key as in remote dongle }
                                  pAnswer:pointer;          { Pointer to the buffer for Answer data }
                                                            { IN: Maximum buffer size for Answer data, OUT: Size of pAnswer buffer }
                                  pdwAnswerSize:pointer ):integer; stdcall; external;

{ Apply encrypted answer data buffer received via remote update procedure}
    function GrdTRU_ApplyAnswer(hGrd:HANDLE;                { Handle to Guardant protected container of dongle with}
                                                            { corresponding pregenerated question }
                                pAnswer:pointer;            { Answer data update buffer prepared and encrypted by GrdTRU_EncryptAnswer}
                                                            { Size of pAnswer buffer }
                                dwAnswerSize:DWORD ):integer; stdcall; external;


{ Digitally sign a block of bytes by using dongle hardware implemented ECC algorithm }
    function GrdSign(hGrd:HANDLE;             { Handle to Guardant protected container }
                     dwAlgoNum:DWORD;         { Number of hardware implemented ECC algorithm }
                     dwDataLng:DWORD;         { Data for sign length (20 bytes for ECC160) }
                     pData:pointer;           { Data for sign }
                     dwSignResultLng:DWORD;   { ECC sign length (40 bytes for ECC160) }
                     pSignResult:pointer;     { ECC sign }
                     pReserved:pointer):integer; stdcall; external; { Reserved, must be nil }

{ ECC algorithm digest verifing. Full software implemented }
    function GrdVerifySign(hGrd:HANDLE;          { Handle to Guardant protected container }
                           dwAlgoType:DWORD;     { Type of asymmetric cryptoalgorithm. See GrdVSC_XXXXX definition }
                           dwPublicKeyLng:DWORD; { Public ECC key length }
                           pPublicKey:pointer;   { Public ECC key }
                           dwDataLng:DWORD;      { Data for sign length (20 bytes for ECC160) }
                           pData:pointer;        { Data for sign }
                           dwSignLng:DWORD;      { ECC sign length (40 bytes for ECC160) }
                           pSign:pointer;        { ECC sign }
                           pReserved:pointer):integer; stdcall; external; { Reserved, must be nil }

{ Set dongle system time }
    function GrdSetTime(hGrd:HANDLE;             { Handle to Guardant protected container }
                        pGrdSystemTime:pointer;  { Pointer to TGrdSystemTime }
                        pReserved:pointer):integer; stdcall; external; { Reserved, must be nil }

{ Get dongle system time }
    function GrdGetTime(hGrd:HANDLE;             { Handle to Guardant protected container }
                        pGrdSystemTime:pointer;  { Pointer to TGrdSystemTime }
                        pReserved:pointer):integer; stdcall; external; { Reserved, must be nil }

{ Get time limit for specified item }
    function GrdPI_GetTimeLimit(hGrd:HANDLE;            { Handle to Guardant protected container }
                                dwItemNum:DWORD;        { Algorithm or Protected Item number }
                                pGrdSystemTime:pointer; { Pointer to TGrdSystemTime }
                                pReserved:pointer):integer; stdcall; external; { Reserved, must be nil }

{ Get counter for specified item }
    function GrdPI_GetCounter(hGrd:HANDLE;          { Handle to Guardant protected container }
                              dwItemNum:DWORD;      { Algorithm or Protected Item number }
                              pdwCounter:pointer;   { Pointer to counter value }
                              pReserved:pointer):integer; stdcall; external; { Reserved, must be nil }

{ Create a system time from components }
    function GrdMakeSystemTime(hGrd:HANDLE;         { Handle to Guardant protected container }
                               wYear:WORD;          { The year (2000 - 2099) }
                               wMonth:WORD;         { The month (January = 1, February = 2, ...) }
                               wDayOfWeek:WORD;     { The day of the week (Sunday = 0, Monday = 1,...) }
                               wDay:WORD;           { The day of the month (1-31) }
                               wHour:WORD;          { The hour (0-23) }
                               wMinute:WORD;        { The minute (0-59) }
                               wSecond:WORD;        { The second (0-59) }
                               wMilliseconds:WORD;  { The millisecond (0-999) }
                               pGrdSystemTime:pointer):integer; stdcall; external;   { Pointer to destination system time }

{ Break a system time into components }
    function GrdSplitSystemTime(hGrd:HANDLE;            { Handle to Guardant protected container }
                                pGrdSystemTime:pointer; { Pointer to source system time }
                                pwYear:pointer;         { Pointer for return year value }
                                pwMonth:pointer;        { Pointer for return month value }
                                pwDayOfWeek:pointer;    { Pointer for return day of the week value }
                                pwDay:pointer;          { Pointer for return day of the month value }
                                pwHour:pointer;         { Pointer for return hour value }
                                pwMinute:pointer;       { Pointer for return minute value }
                                pwSecond:pointer;       { Pointer for return second value }
                                pwMilliseconds:pointer):integer; stdcall; external; { Pointer for return millisecond value }


{ Get information from user-defined loadable code descriptor  }
   function GrdCodeGetInfo(hGrd:HANDLE;            { Handle to Guardant protected container }
                           dwAlgoName:DWORD;       { Algorithm numerical name to be loaded }
                           dwLng:DWORD;            { Number of bytes for reading (size of TGrdCodeInfo) }
                           pBuf:pointer;           { Buffer for data to be read (pointer to TGrdCodeUFInfo) }
                           pReserved:pointer):integer; stdcall; external; { Reserved: must be nil }

{ Load GCEXE file to the dongle }
   function GrdCodeLoad(hGrd:HANDLE;            { Handle to Guardant protected container }
                        dwAlgoName:DWORD;       { Algorithm number to load }
                        dwFileSize:DWORD;       { Buffer size for GCEXE-file  }
                        pFileBuf:pointer;       { Pointer to buffer for GCEXE-file }
                        pReserved:pointer):integer; stdcall; external; { Reserved: must be nil }

{ Run user-defined loadable code }
   function GrdCodeRun(hGrd:HANDLE;                   { Handle to Guardant protected container }
                       dwAlgoName:DWORD;              { Algorithm number to run }
                       dwP1:DWORD;                    { Parameter (subfunction code) for loadable code  }
                       pdwRet:pointer;                { Return code of Loadable Code }
                       dwDataFromDongleLng:DWORD;     { The amount of data to be received from the dongle }
                       pDataFromDongle:pointer;       { Pointer to a buffer for data to be received from the dongle  }
                       dwDataToDongleLng:DWORD;       { he amount of data to be sent to the dongle }
                       pDataToDongle:pointer;         { ointer to a buffer for data to be sent to the dongle }
                       pReserved:pointer):integer; stdcall; external; { Reserved: must be nil }

{ Switch driver type of dongle }
   function GrdSetDriverMode(hGrd:HANDLE;             { Handle to Guardant protected container }
                             dwMode:DWORD;            { New Guardant dongle USB driver mode. See GrdDM_XXX definitions }
                             pReserved:pointer):integer; stdcall; external; { Reserved: must be nil }

{ Initialize Dongle Notification API }
   function GrdInitializeNotificationAPI():integer; stdcall; external;

{ Register dongle notification for specified handle }
   function GrdRegisterDongleNotification(hGrd:HANDLE;  { Handle to Guardant protected container }
                                          pCallBack:pointer):integer; stdcall; external; { Pointer to Dongle Notification CallBack routine }

{ Unregister dongle notification for specified handle }
   function GrdUnRegisterDongleNotification(hGrd:HANDLE):integer; stdcall; external; { Handle to Guardant protected container }

{ Uninitialize Dongle Notification API }
   function GrdUnInitializeNotificationAPI():integer; stdcall; external;


implementation


end.
