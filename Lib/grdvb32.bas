
Public Const GrdContainerSize& = &H2000    ' Size of memory allocated for Guardant protected container

'- Demo Codes
Public Const GrdDC_DEMONVK& = &H519175B7  ' Demo public code
Public Const GrdDC_DEMORDO& = &H51917645  ' Demo private read code
Public Const GrdDC_DEMOPRF& = &H51917603  ' Demo private write code
Public Const GrdDC_DEMOMST& = &H5191758C  ' Demo private master code

'- Dongle Models
Public Const GrdDM_GS1L& = 0                ' Guardant Stealth       LPT
Public Const GrdDM_GS1U& = 1                ' Guardant Stealth       USB
Public Const GrdDM_GF1L& = 2                ' Guardant Fidus         LPT
Public Const GrdDM_GS2L& = 3                ' Guardant StealthII     LPT
Public Const GrdDM_GS2U& = 4                ' Guardant StealthII     USB
Public Const GrdDM_GS3U& = 5                ' Guardant StealthIII    USB
Public Const GrdDM_GF1U& = 6                ' Guardant Fidus         USB
Public Const GrdDM_GS3TU& = 7               ' Guardant StealthIII Sign/Time USB
Public Const GrdDM_Total& = 8               ' Number of different models

'- Dongle Interfaces
Public Const GrdDI_LPT& = 0               ' LPT port
Public Const GrdDI_USB& = 1               ' USB bus

'- Dongle Types
Public Const GrdDT_DOS& = &H0             ' DOS Stealth Dongle
Public Const GrdDT_Win& = &H0             ' Windows Stealth Dongle
Public Const GrdDT_LAN& = &H1             ' LAN Stealth Dongle
Public Const GrdDT_Time& = &H2            ' Time Stealth Dongle
Public Const GrdDT_GSII64& = &H8          ' Support of Guardant Stealth II 64 bit (GSII64) algorithm
Public Const GrdDT_PI& = &H10             ' Support of Guardant Stealth III protected items
Public Const GrdDT_TRU_& = &H20           ' Support of Guardant Stealth III remote update
Public Const GrdDT_RTC& = &H40        ' Support of Real Time Clock
Public Const GrdDT_AES& = &H80        ' Support of AES 128 algorithm
Public Const GrdDT_ECC& = &H100       ' Support of ECC 160 algorithm

'-- Flags GrdCreateHandle() Mode
Public Const GrdCHM_SingleThread& = &H0         ' Multi-threading support is disabled
Public Const GrdCHM_MultiThread& = &H1          ' Multi-threading support is enabled (access synchronization to hGrd is on)

'-- Flags for GrdLogin() Licensing Mode
Public Const GrdLM_PerStation& = &H0            ' Allocate Guardant Net license for each workstation
Public Const GrdLM_PerHandle& = &H1             ' Allocate Guardant Net license for each logged in protected container (application copy)

'-- Flags for Remote Mode of GrdSetFindMode()
'- Dongle SetFindMode Remote mode search flags
Public Const GrdFMR_Local& = 1                              ' Local dongle
Public Const GrdFMR_Remote& = 2                             ' Remote dongle
'- SetFindMode dongle model search bits
Public Const GrdFMM_GS1L& = (1 * 2 ^ GrdDM_GS1L)      ' Guardant Stealth     LPT
Public Const GrdFMM_GS1U& = (1 * 2 ^ GrdDM_GS1U)          ' Guardant Stealth     USB
Public Const GrdFMM_GF1L& = (1 * 2 ^ GrdDM_GF1L)          ' Guardant Fidus       LPT
Public Const GrdFMM_GS2L& = (1 * 2 ^ GrdDM_GS2L)          ' Guardant StealthII   LPT
Public Const GrdFMM_GS2U& = (1 * 2 ^ GrdDM_GS2U)          ' Guardant StealthII   USB
Public Const GrdFMM_GS3U& = (1 * 2 ^ GrdDM_GS3U)          ' Guardant StealthIII  USB
Public Const GrdFMM_GF1U& = (1 * 2 ^ GrdDM_GF1U)          ' Guardant Fidus       USB
Public Const GrdFMM_GS3TU& = (1 * 2 ^ GrdDM_GS3TU)        ' Guardant Stealth III Sign/Time
Public Const GrdFMM_GS1& = (GrdFMM_GS1L Or GrdFMM_GS1U)   ' Guardant Stealth I of any interface
Public Const GrdFMM_GF& = (GrdFMM_GF1L Or GrdFMM_GF1U)    ' Guardant Fidus   I   of any interface
Public Const GrdFMM_GS2& = (GrdFMM_GS2L Or GrdFMM_GS2U)   ' Guardant Stealth II of any interface
Public Const GrdFMM_GS3& = (GrdFMM_GS3U)                  ' Guardant Stealth III of any interface
Public Const GrdFMM_GS3T& = (GrdFMM_GS3TU)                ' Guardant Stealth III Sign/Time of any interface
Public Const GrdFMM_ALL& = 0                              ' All Guardant Stealth & Fidus family
'- SetFindMode dongle Interface search bits
Public Const GrdFMI_LPT& = (1 * 2 ^ GrdDI_LPT)           ' LPT port
Public Const GrdFMI_USB& = (1 * 2 ^ GrdDI_USB)           ' USB bus
Public Const GrdFMI_ALL& = 0                             ' All Guardant Stealth & Fidus interfaces

'-- Definition for use in GrdFind() function call
Public Const GrdF_First& = 1              ' First call
Public Const GrdF_Next& = 0               ' All following calls

'-- Flags of find parameters during GrdLogin() or GrdFind()
Public Const GrdFM_NProg& = &H1            ' wDongleNProg == wNProg
Public Const GrdFM_ID& = &H2               ' dwDongleID == dwID
Public Const GrdFM_SN& = &H4               ' Serial Number wDongleSN == wSN
Public Const GrdFM_Ver& = &H8              ' bDongleVersion >= bVer
Public Const GrdFM_Mask& = &H10            ' wDongleMask & wMask == wMask
Public Const GrdFM_Type& = &H20            ' wDongleType & wType == wType

'-- GrdSetWorkMode() dwFlagsWork mode flags
Public Const GrdWM_UAM& = &H0               ' Enables UAM (User Address Mode) in read/write operations. Default mode
Public Const GrdWM_SAM& = &H80              ' Enables SAM (System Address Mode) in read/write operations
Public Const GrdWM_CodeIsString& = &H100    ' Reserved
Public Const GrdWM_NoRetry& = &H200         ' Disables auto configuration of communication protocol
Public Const GrdWM_NoFullAccess& = &H400    ' Disables full capture of the parallel port resource
Public Const GrdWM_OnlyStdLPT1& = &H800     ' Enables search for the dongle in LPT1 only (address &h378)
Public Const GrdWM_OnlyStdLPT2& = &H1000    ' Enables search for the dongle in LPT2 only (address &h278)
Public Const GrdWM_OnlyStdLPT3& = &H2000    ' Enables search for the dongle in LPT3 only (address &h3BC)
Public Const GrdWM_NoAutoMem32& = &H4000    ' Indicates that data segment is different from the standard one
Public Const GrdWM_UseOldCRC& = &H8000      ' Reserved
Public Const GrdWM_NotStdLPTAddr& = &H2000000

'-- GrdSetWorkMode() dwFlagsMode parameters
Public Const GrdWMFM_DriverAuto& = &H0         ' Use driver automaticaly. Call the dongle by means of driver if it is installed
Public Const GrdWMFM_DriverOnly& = &H1         ' Call the dongle by means of driver only
Public Const GrdWMFM_BypassDriver& = &H2       ' Bypass driver in Win9X

'- Lock Mode flags ---
'  Login, Check and Find commands cannot be locked
Public Const GrdLM_Nothing& = &H0               ' Works like critical section
Public Const GrdLM_Init& = &H1                  ' Prevent Init operations
Public Const GrdLM_Protect& = &H2               ' Prevent Protect operations
Public Const GrdLM_Transform& = &H4             ' Prevent Transform operations
Public Const GrdLM_Read& = &H8                  ' Prevents reading from UAM memory
Public Const GrdLM_Write& = &H10                ' Prevents writing to UAM memory
Public Const GrdLM_Activate& = &H20             ' Prevent activation of protected items
Public Const GrdLM_Deactivate& = &H40           ' Prevent deactivation of protected items
Public Const GrdLM_ReadItem& = &H80             ' Prevent reading from protected items
Public Const GrdLM_UpdateItem& = &H100          ' Prevent updating of protected items
Public Const GrdLM_All& = &HFFFFFFFF            ' Prevent all mentioned above operations

'- UAM Addresses of Fields ---
Public Const GrdUAM_bNProg& = (30 - 30)         ' 00h Programm number
Public Const GrdUAM_bVer& = (31 - 30)           ' 01h Version
Public Const GrdUAM_wSN& = (32 - 30)            ' 02h Serial number
Public Const GrdUAM_wMask& = (34 - 30)          ' 04h Bit mask
Public Const GrdUAM_wGP& = (36 - 30)            ' 06h Counter #1 (GP)
Public Const GrdUAM_wRealLANRes& = (38 - 30)    ' 08h Current network license limit
Public Const GrdUAM_dwIndex& = (40 - 30)        ' 0Ah Index
Public Const GrdUAM_abAlgoAddr& = (44 - 30)     ' 0Eh User data, algorithm descriptors

'- SAM Addresses of Fields
' Fields protection against nsc_Init, nsc_Protect, nsc_Write commands
'    * - Partial protection: nsc_Protect can be executed only after nsc_Init
'    X - Full protection
' Protection against command:                Init Protect Write
Public Const GrdSAM_byDongleModelAddr& = 0     '  0h   X     X     X    0=GS,1=GU,2=GF
Public Const GrdSAM_byDongleMemSizeAddr& = 1   '  1h   X     X     X    0=0, 8=256
Public Const GrdSAM_byDongleProgVerAddr& = 2   '  2h   X     X     X
Public Const GrdSAM_byDongleProtocolAddr& = 3  '  3h   X     X     X
Public Const GrdSAM_wClientVerAddr& = 4        '  4h   X     X     X    &h104=1.4
Public Const GrdSAM_byDongleUserAddrAddr& = 6  '  6h   X     X     X
Public Const GrdSAM_byDongleAlgoAddrAddr& = 7  '  7h   X     X     X
Public Const GrdSAM_wPrnportAddr& = 8          '  8h   X     X     X
Public Const GrdSAM_byWriteProtectS3 = 10      '  Ah         *     X
Public Const GrdSAM_byReadProtectS3 = 12       '  Ch         *     X
Public Const GrdSAM_dwPublicCode& = 14         '  Eh   X     X     X
Public Const GrdSAM_byVersion& = 18            ' 12h   X     X     X
Public Const GrdSAM_byLANRes& = 19             ' 13h   X     X     X
Public Const GrdSAM_wType& = 20                ' 14h   X     X     X
Public Const GrdSAM_dwID& = 22                 ' 16h   X     X     X
Public Const GrdSAM_bWriteProtect& = 26        ' 1Ah         *     X
Public Const GrdSAM_byReadProtect& = 27        ' 1Bh         *     X
Public Const GrdSAM_byNumFunc& = 28            ' 1Ch         *     X
Public Const GrdSAM_byTableLMS& = 29           ' 1Dh         *     X
Public Const GrdSAM_byTableLMS_S3 = 29         ' 1Dh         *     X
Public Const GrdSAM_byNProg& = 30              ' 1Eh   X     X
Public Const GrdSAM_UAM = 30                   ' 1Eh  start address of UAM memory
Public Const GrdSAM_byVer& = 31                ' 1Fh   X     X
Public Const GrdSAM_wSN& = 32                  ' 20h   X     X
Public Const GrdSAM_wMask& = 34                ' 22h   X     X
Public Const GrdSAM_wGP& = 36                  ' 24h   X     X
Public Const GrdSAM_wRealLANRes& = 38          ' 26h   X     X
Public Const GrdSAM_dwIndex& = 40              ' 28h   X     X
Public Const GrdSAM_abyAlgoAddr& = 44          ' 2Ch


'-- Guardant Stealth I & II old compatibility default Algorithm Numbers & Request Size
'- Guardant Stealth I & II Algorithm Numbers
'Public Const GrdAN_AutoProtect   0   ' For automatic protection
'Public Const GrdAN_Fast          1   ' For CodeInit (EnCode/DeCode) operation
'Public Const GrdAN_Random        2   ' Random number generator
'Public Const GrdAN_DEMO          3   ' For Transform operation
'Public Const GrdAN_GSII64        4   ' For GSII64 TransformEx operation
'- Guardant Stealth I & II Algorithm Request Size
'Public Const GrdARS_AutoProtect  4   ' For automatic protection
'Public Const GrdARS_Fast        32   ' For CodeInit (EnCode/DeCode) operation
'Public Const GrdARS_Random       4   ' Random number generator
'Public Const GrdARS_DEMO         4   ' For Transform operation
'Public Const GrdARS_GSII64       8   ' For GSII64 TransformEx operation


'-- Guardant Stealth III default Algorithm & Protected Items
'- Guardant Stealth III default Algorithm & Protected Items numbers
Public Const GrdAN_GSII64& = 0          ' GSII64 for automatic protection & use in API
Public Const GrdAN_HASH64& = 1          ' HASH64 for automatic protection & use in API
Public Const GrdAN_RAND64& = 2          ' RAND64 for automatic protection & use in API
Public Const GrdAN_READ_ONLY& = 3       ' Protected Item for read-only data. Can be updated via Secured Guardant Remote Update
Public Const GrdAN_READ_WRITE& = 4      ' Protected Item for read/write data. Can be updated at protected application runtime
Public Const GrdAN_GSII64_DEMO& = 5     ' GSII64 demo algorithm for use in Guardant examlpes
Public Const GrdAN_HASH64_DEMO& = 6     ' HASH64 demo algorithm for use in Guardant examlpes
Public Const GrdAN_ECC160 = 8           ' ECC160 for automatic protection & use in API
Public Const GrdAN_AES128 = 9           ' AES128 for automatic protection & use in API
Public Const GrdAN_GSII64_ENCRYPT = 10  ' GSII64_ENCRYPT for automatic protection & use in API
Public Const GrdAN_GSII64_DECRYPT = 11  ' GSII64_DECRYPT for automatic protection & use in API

'- Guardant Stealth III default Algorithm & Protected Items Request Size
Public Const GrdARS_GSII64& = 8         ' GSII64 for automatic protection & use in API
Public Const GrdARS_HASH64& = 8         ' HASH64 for automatic protection & use in API
Public Const GrdARS_RAND64& = 8         ' RAND64 for automatic protection & use in API
Public Const GrdARS_READ_ONLY& = 8      ' Protected Item for read-only data. Can be updated via Secured Guardant Remote Update
Public Const GrdARS_READ_WRITE& = 8     ' Protected Item for read/write data. Can be updated at protected application runtime
Public Const GrdARS_GSII64_DEMO& = 8    ' GSII64 demo algo for use in Guardant examlpes
Public Const GrdARS_HASH64_DEMO& = 8    ' HASH64 demo algo for use in Guardant examlpes
Public Const GrdARS_ECC160 = 20         ' ECC160 for automatic protection & use in API
Public Const GrdARS_AES128 = 16     ' AES128 for automatic protection & use in API

'- Guardant Stealth III default Algorithm & Protected Items maximum Request Size
Public Const GrdAMRS_GSII64& = 248     ' GSII64 for automatic protection & use in API
Public Const GrdAMRS_HASH64& = 248     ' HASH64 for automatic protection & use in API
Public Const GrdAMRS_RAND64& = 248     ' RAND64 for automatic protection & use in API

'- Guardant Stealth III default Algorithm & Protected Items Determinant Size
Public Const GrdADS_GSII64& = 16        ' GSII64 for automatic protection & use in API
Public Const GrdADS_HASH64& = 16        ' HASH64 for automatic protection & use in API
Public Const GrdADS_RAND64& = 16        ' RAND64 for automatic protection & use in API
Public Const GrdADS_READ_ONLY& = 8      ' Protected Item for read-only data. Can be updated via Secured Guardant Remote Update
Public Const GrdADS_READ_WRITE& = 8     ' Protected Item for read/write data. Can be updated at protected application runtime
Public Const GrdADS_GSII64_DEMO& = 16   ' GSII64 demo algo for use in Guardant examlpes
Public Const GrdADS_HASH64_DEMO& = 16   ' HASH64 demo algo for use in Guardant examlpes
Public Const GrdADS_ECC160 = 40     ' ECC160 for automatic protection & use in API
Public Const GrdADS_AES128 = 16     ' AES128 for automatic protection & use in API

' Guardant GSII64 DEMO Algorithm default passwords
Public Const GrdAP_GSII64_DEMO_ACTIVATION& = &HAAAAAAAA
Public Const GrdAP_GSII64_DEMO_DEACTIVATION& = &HDDDDDDDD
Public Const GrdAP_GSII64_DEMO_READ& = &HBBBBBBBB
Public Const GrdAP_GSII64_DEMO_UPDATE& = &HCCCCCCCC

' Guardant HASH64 DEMO Algorithm default passwords
Public Const GrdAP_HASH64_DEMO_ACTIVATION& = &HAAAAAAAA
Public Const GrdAP_HASH64_DEMO_DEACTIVATION& = &HDDDDDDDD
Public Const GrdAP_HASH64_DEMO_READ& = &HBBBBBBBB
Public Const GrdAP_HASH64_DEMO_UPDATE& = &HCCCCCCCC

'- Guardant Stealth Fast EnCode/DeCode Algorithm Methods
Public Const GrdAT_Algo0& = 0           ' Basic method
Public Const GrdAT_AlgoASCII& = 1       ' Character method
Public Const GrdAT_AlgoFile& = 2        ' File method

'- Guardant Stealth API Algorithm use Method
'- bit 0-5 block chaining mode
Public Const GrdAM_ECB& = 0             ' Electronic Code Book
Public Const GrdAM_CBC& = 1             ' Cipher Block Chaining
Public Const GrdAM_CFB& = 2             ' Cipher Feed Back
Public Const GrdAM_OFB& = 3             ' Output Feed Back
'- bit 7 - Encode/Decode
Public Const GrdAM_Encode& = 0          ' Encode mode
Public Const GrdAM_Decode& = &H80       ' Decode mode
'- Software- or hardware-implemented cryptographic algorithm mode
' can be combined with GrdAM_ECB, GrdAM_CBC, GrdAM_CFB, GrdAM_OFB
'- bit 8-9 First/Next/Last
Public Const GrdSC_First& = &H100       ' First data block
Public Const GrdSC_Next& = &H200        ' Next data block
Public Const GrdSC_Last& = &H400        ' Last data block
Public Const GrdSC_All& = (GrdSC_First + GrdSC_Next + GrdSC_Last)
' Synonym definitions
Public Const GrdAM_Encrypt& = GrdAM_Encode&
Public Const GrdAM_Decrypt& = GrdAM_Decode&

' Type of asymmetric cryptoalgorithm.
Public Const GrdVSC_ECC160 = 0

Public Const GrdECC160_PUBLIC_KEY_SIZE = 40
Public Const GrdECC160_DIGEST_SIZE = 40
Public Const GrdECC160_MESSAGE_SIZE = 20

'- Hardware-implemented cryptographic or hashing algorithm flag
Public Const GrdSA_SoftAlgo& = &H80000000

'- Software-implemented cryptographic algorithm
Public Const GrdSC_AES256& = (GrdSA_SoftAlgo& + 0)

'- Software-implemented hashing algorithm
Public Const GrdSH_CRC32& = (GrdSA_SoftAlgo& + 0)
Public Const GrdSH_SHA256& = (GrdSA_SoftAlgo& + 1)

Public Const GrdHASH64_DIGEST_SIZE& = 8
Public Const GrdCRC32_DIGEST_SIZE& = 4

Public Const GrdSHA256_DIGEST_SIZE& = 32
Public Const GrdSHA256_CONTEXT_SIZE& = &H200        ' must be >= sizeof(SHA256_CONTEXT)
Public Const GrdAES256_KEY_SIZE& = 32
Public Const GrdAES256_BLOCK_SIZE& = 16
Public Const GrdAES_CONTEXT_SIZE& = &H4000          ' must be >= sizeof(AES_CONTEXT)

' GrdTRU_PrepareData() mode
Public Const GrdRmtUpdFlags_Init& = 1               ' Execute Init before Update
Public Const GrdRmtUpdFlags_Protect& = 2            ' Execute Protect before Update
Public Const GrdTRU_Flags_Init& = 1         ' Execute Init before Update
Public Const GrdTRU_Flags_Protect& = 2          ' Execute Protect after Update

' GrdPI_Update Methods
Public Const GrdUM_MOV& = 0
Public Const GrdUM_XOR& = 1
'Public Const GrdUM_OR      2
'Public Const GrdUM_AND     3

' Language constants for convert Guardant error code to text message string via GrdGetErrorMessage()
Public Const GrdLng_ENG& = 0
Public Const GrdLng_RUS& = 7

' Guardant get information code constants for GrdGetInfo()
' API information
Public Const GrdGIV_VerAPI& = &H0           ' API version
' Common Mode
Public Const GrdGIM_WorkMode& = &H1000      ' Work mode
Public Const GrdGIM_HandleMode& = &H1001    ' Handle mode
' Find & logon mode
Public Const GrdGIF_Remote& = &H2000        ' Local and/or remote (GrdSMF_Local + GrdSMF_Remote)
Public Const GrdGIF_Flags& = &H2001         ' Flags
Public Const GrdGIF_Prog& = &H2002          ' Program number field value
Public Const GrdGIF_ID& = &H2003            ' Dongle ID field value
Public Const GrdGIF_SN& = &H2004            ' Serial number field value
Public Const GrdGIF_Ver& = &H2005           ' Version field value
Public Const GrdGIF_Mask& = &H2006          ' Bit mask field value
Public Const GrdGIF_Type& = &H2007          ' Dongle type field value
Public Const GrdGIF_Model& = &H2008         ' Possible model     bits. 1 << GrdDM_XXX (GS1L, GS1U, GF1L, GS2L, GS2U )
Public Const GrdGIF_Interface& = &H2009     ' Possible interface bits. 1 << GrdDI_XXX (LPT | USB) )
' Logon information on current dongle
Public Const GrdGIL_Remote& = &H3000        ' Local or remote dongle
Public Const GrdGIL_ID& = &H3001            ' ID of current dongle
Public Const GrdGIL_Model& = &H3002         ' Model of current dongle
Public Const GrdGIL_Interface& = &H3003     ' Interface of current dongle
'Public Const   GrdGIL_LockID       &h3004
Public Const GrdGIL_LockCounter& = &H3005   ' Lock counter value for current dongle
Public Const GrdGIL_Seek = &H3006       ' Current dongle memory address

' Logon information on current local or remote dongle driver
Public Const GrdGIL_DrvVers& = &H4000       ' Driver       version (&h04801234=4.80.12.34
Public Const GrdGIL_DrvBuild& = &H4001      ' Driver       build
Public Const GrdGIL_PortLPT& = &H4002       ' LPT port address (0 == USB)
' Logon information on current remote dongle
Public Const GrdGIR_VerSrv& = &H5000        ' Guardant Net server version
Public Const GrdGIR_LocalIP& = &H5001       ' Guardant Net local  IP
Public Const GrdGIR_LocalPort& = &H5002     ' Guardant Net local  IP port
Public Const GrdGIR_LocalNB& = &H5003       ' Guardant Net local  NetBIOS name
Public Const GrdGIR_RemoteIP& = &H5004      ' Guardant Net remote IP
Public Const GrdGIR_RemotePort& = &H5005    ' Guardant Net remote IP port
Public Const GrdGIR_RemoteNB& = &H5006      ' Guardant Net remote NetBIOS name

'- CRC Starting value
Public Const Grd_StartCRC& = &HFFFFFFFF     ' Starting value for 'continued' CRC

Public Const GrdSeekCur& = &HFFFFFFFF       ' Use current dongle memory pointer associated with handle

'- Error codes
Public Const GrdE_OK& = 0                  ' No errors
Public Const GrdE_DongleNotFound& = 1      ' Dongle with specified search conditions not found
                            '   2    Code not found ' N/A
Public Const GrdE_AddressTooBig& = 3       ' The specified address is too big
                            '   4    'Long counter too big ' N/A
Public Const GrdE_GPis0& = 5               ' GP executions counter exhausted  Lib "GrdApi32.dll" as 0 value)
Public Const GrdE_InvalidCommand& = 6      ' Invalid dongle call command
                            '   7 not used
Public Const GrdE_VerifyError& = 8         ' Write verification error
Public Const GrdE_NetProtocolNotFound& = 9 ' Network protocol not found
Public Const GrdE_NetResourceExhaust& = 10 ' License counter of Guardant Net exhausted
Public Const GrdE_NetConnectionLost& = 11  ' Connection with Guardant Net server was lost
Public Const GrdE_NetDongleNotFound& = 12  ' Guardant Net server not found
Public Const GrdE_NetServerMemory& = 13    ' Guardant Net server memory allocation error
Public Const GrdE_DPMI& = 14               ' DPMI error
Public Const GrdE_Internal& = 15           ' Internal error
Public Const GrdE_NetServerReloaded& = 16  ' Guardant Net server has been reloaded
Public Const GrdE_VersionTooOld& = 17      ' This command is not supported by this dongle version
Public Const GrdE_BadDriver& = 18          ' Windows NT driver is required
Public Const GrdE_NetProtocol& = 19        ' Network protocol error
Public Const GrdE_NetPacket& = 20          ' Network packet format is not supported
Public Const GrdE_NeedLogin& = 21          ' Logging in is required
Public Const GrdE_NeedLogout& = 22         ' Logging out is required
Public Const GrdE_DongleLocked& = 23         ' Guardant dongle is busy (locked by another copy of protected application)
Public Const GrdE_DriverBusy& = 24         ' Guardant driver cannot capture the parallel port
                            ' 25 - 29 not used
Public Const GrdE_CRCError& = 30           ' CRC error occurred while attempting to call the dongle
Public Const GrdE_CRCErrorRead& = 31       ' CRC error occurred while attempting to read data from the dongle
Public Const GrdE_CRCErrorWrite& = 32      ' CRC error occurred while attempting to write data to the dongle
Public Const GrdE_Overbound& = 33          ' The boundary of the dongle's memory has been override
Public Const GrdE_AlgoNotFound& = 34       ' The hardware algorithm with this number has not been found in the dongle
Public Const GrdE_CRCErrorFunc& = 35       ' CRC error of the hardware algorithm
Public Const GrdE_AllDonglesFound& = 36          ' CRC error occurred while attempting to execute ChkNSK operation, or all dongles found
Public Const GrdE_ProtocolNotSup& = 37     ' Guardant API release is too old
Public Const GrdE_InvalidCnvType& = 38     ' Non-existent reversible conversion method has been specified
Public Const GrdE_UnknownError& = 39       ' Unknown error in work with algorithm or protected item, operation may by not complete
Public Const GrdE_AccessDenied& = 40       ' Invalid password
Public Const GrdE_StatusUnchangeable& = 41 ' Error counter has been exhausted for this Protected Item
Public Const GrdE_NoService& = 42          ' Specifed algorithm or protected item not support requested service
Public Const GrdE_InactiveItem& = 43       ' This is a inactive algorithm or protected item, command not executed
Public Const GrdE_DongleServerTooOld& = 44 ' Dongle server not support specifed command
Public Const GrdE_DongleBusy& = 45         ' Dongle busy at this moment and can't execute any command. It will by during 11 seconds after Init
Public Const GrdE_InvalidArg& = 46         ' One or more arguments are invalid
Public Const GrdE_MemoryAllocation& = 47   ' Memory allocation error
Public Const GrdE_InvalidHandle& = 48      ' Invalid handle
Public Const GrdE_ContainerInUse& = 49     ' This protected container is already in use
Public Const GrdE_Reserved50& = 50         ' Reserved
Public Const GrdE_Reserved51& = 51         ' Reserved
Public Const GrdE_Reserved52& = 52         ' Reserved
Public Const GrdE_SystemDataCorrupted& = 53 ' Remote update system data corrupted
Public Const GrdE_NoQuestion& = 54         ' Remote update question has not been generated
Public Const GrdE_InvalidData& = 55        ' Invalid remote update data format
Public Const GrdE_QuestionOK& = 56         ' Remote update question has been already generated
Public Const GrdE_UpdateNotComplete& = 57  ' Remote update writing has not been completed
Public Const GrdE_InvalidHash& = 58        ' Invalid remote update data hash
Public Const GrdE_GenInternal& = 59        ' Internal error
Public Const GrdE_AlreadyInitialized& = 60 ' This copy of Guardant API has been already initialized
Public Const GrdE_RTC_Error& = 61      ' Real Time Clock error
Public Const GrdE_BatteryError& = 62       ' Real Time Clock battery low error
Public Const GrdE_DuplicateNames& = 63     ' Duplicate items/algorithms names
Public Const GrdE_AATFormatError& = 64     ' Address in AAT table is out of range
Public Const GrdE_SessionKeyNtGen& = 65    ' Session key not generated
Public Const GrdE_InvalidPublicKey& = 66   ' Invalid public key
Public Const GrdE_InvalidDigitalSign& = 67 ' Invalid digital sign
Public Const GrdE_SessionKeyGenError& = 68 ' Session key generation error
Public Const GrdE_InvalidSessionKey& = 69  ' Invalid session key
Public Const GrdE_SessionKeyTooOld& = 70   ' Session key too old
Public Const GrdE_NeedInitialization& = 71 ' Initialization is required
Public Const GrdE_LastError& = 72          ' Total number of errors

' Dongle State Flags
Public Const GrdDSF_RTC_Quality = 1    ' Real Time Clock Quality error flag
Public Const GrdDSF_RTC_Battery = 2    ' Real Time Clock Battery error flag

' Initialize this copy of GrdAPI. GrdStartup() must be called once before first GrdAPI call at application startup
Declare Function GrdStartup Lib "GrdApi32.dll" (ByVal dwMode As Long) As Integer

' Deinitialize this copy of GrdAPI. GrdCleanup() must be called after last GrdAPI call before program termination
Declare Function GrdCleanup Lib "GrdApi32.dll" () As Integer

' Must be called at the beginning of any Win32 DllMain function
Declare Function GrdDllMain Lib "GrdApi32.dll" (ByVal hinstDLL As Long, ByVal fdwReason As Long, ByVal lpvReserved As Any) As Integer

' Get last error information from protected container with specifed handle
' The last error code is maintained on a per-handle basis
' Multiple handles do not overwrite each other's last-error code
Declare Function GrdGetLastError Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal ppLastErrFunc As Any) As Integer

' Convert Guardant error code to text message string
Declare Function GrdFormatMessage Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal nErrorCode As Integer, ByVal nLanguage As Integer, ByVal szErrorMsg As Any, ByVal nErrorMsgSize As Integer, ByVal pReserved As Any) As Integer

' Get requested information

Declare Function GrdGetInfo Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwInfoCode As Long, ByVal pInfoData As Any, ByVal dwDataCount As Long) As Integer

' Protected container handle validator
Declare Function GrdIsValidHandle Lib "GrdApi32.dll" (ByVal hGrd As Long) As Integer

' Create Grd protected container & return it's handle
Declare Function GrdCreateHandle Lib "GrdApi32.dll" (ByVal hGrd As Any, ByVal dwMode As Long, ByVal pReserved As Any) As Long

' Close specified handle.
' Log out from dongle/server & free allocated memory
Declare Function GrdCloseHandle Lib "GrdApi32.dll" (ByVal hGrd As Long) As Integer

' Store dongle codes in Guardant protected container
Declare Function GrdSetAccessCodes Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwPublic As Long, ByVal dwPrivateRD As Long, ByVal dwPrivateWR As Long, ByVal dwPrivateMST As Long) As Integer

' Set dongle working mode to Guardant protected container
Declare Function GrdSetWorkMode Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwFlagsWork As Long, ByVal dwFlagsMode As Long) As Integer

' Set dongle search conditions and operation modes to Guardant protected container
Declare Function GrdSetFindMode Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwRemoteMode As Long, ByVal dwFlags As Long, ByVal dwProg As Long, ByVal dwID As Long, ByVal dwSN As Long, ByVal dwVer As Long, ByVal dwMask As Long, ByVal dwType As Long, ByVal dwModels As Long, ByVal dwInterfaces As Long) As Integer

' Obtain the ID and other dongle info of the first or next dongle found
Declare Function GrdFind Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwMode As Long, ByVal pdwID As Any, ByVal pFindInfo As Any) As Integer

' Login to Guardant dongle
Declare Function GrdLogin Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwModuleLMS As Long, ByVal dwLoginFlags As Long) As Integer

' Log out from Guardant dongle
Declare Function GrdLogout Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwMode As Long) As Integer

' Increment lock counter of specified dongle
Declare Function GrdLock Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwTimeoutWaitForUnlock As Long, ByVal dwTimeoutAutoUnlock As Long, ByVal dwMode As Long) As Integer

' Unlock specified dongle
Declare Function GrdUnlock Lib "GrdApi32.dll" (ByVal hGrd As Long) As Integer

' Check for dongle availability
Declare Function GrdCheck Lib "GrdApi32.dll" (ByVal hGrd As Long) As Integer

' Check for dongle availability and decrement GP executions counter
Declare Function GrdDecGP Lib "GrdApi32.dll" (ByVal hGrd As Long) As Integer

' Read a block of Longs from the dongle's memory
Declare Function GrdRead Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwAddr As Long, ByVal dwLng As Long, ByVal pData As Any, ByVal pReserved As Any) As Integer

' Write a block of Longs into the dongle's memory
Declare Function GrdWrite Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwAddr As Long, ByVal dwLng As Long, ByVal pData As Any, ByVal pReserved As Any) As Integer

' Moves the dongle memory pointer associated with handle to a new location that is offset Longs from origin
' of dongle memory in current addressing mode. The next operation on the handle takes place at the new location.
Declare Function GrdSeek Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwAddr As Long) As Integer


' Initialize the dongle's memory
Declare Function GrdInit Lib "GrdApi32.dll" (ByVal hGrd As Long) As Integer

' Implement locks / Specify the number of hardware algorithms
' and LMS table address
Declare Function GrdProtect Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwWrProt As Long, ByVal dwRdProt As Long, ByVal dwNumFunc As Long, ByVal dwTableLMS As Long, ByVal dwGlobalFlags As Long, ByVal pReserved As Any) As Integer


'--- Cryptographic functions

' Transform a block of Longs using dongle's hardware algorithm   Lib "GrdApi32.dll" (also and GSII64 too)
Declare Function GrdTransform Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwAlgoNum As Long, ByVal dwLng As Long, ByVal pData As Any, ByVal DwMethod As Long, ByVal pIV As Any) As Integer

' Crypt a block of Longs using cryption algorithm
Declare Function GrdCrypt Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwAlgo As Long, ByVal dwDataLng As Long, ByVal pData As Any, ByVal DwMethod As Long, ByVal pIV As Any, ByVal pKeyBuf As Any, ByVal pContext As Any) As Integer

' Hash calculation of a block of Longs
Declare Function GrdHash Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwSoftHash As Long, ByVal dwDataLng As Long, ByVal pData As Any, ByVal DwMethod As Long, ByVal pDigest As Any, ByVal pKeyBuf As Any, ByVal pContext As Any) As Integer

'--- Old compatibility software coding functions

' Initialize a password for fast reversible conversion
Declare Function GrdCodeInit Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwCnvType As Long, ByVal dwAddr As Long, ByVal pKeyBuf As Any) As Integer

' Encode data using fast reversible conversion
Declare Function GrdEnCode Lib "GrdApi32.dll" (ByVal dwCnvType As Long, ByVal pKeyBuf As Any, ByVal pData As Any, ByVal dwLng As Long) As Integer

' Decode data using fast reversible conversion
Declare Function GrdDeCode Lib "GrdApi32.dll" (ByVal dwCnvType As Long, ByVal pKeyBuf As Any, ByVal pData As Any, ByVal dwLng As Long) As Integer

' Calculate 32-bit CRC of a memory block
Declare Function GrdCRC Lib "GrdApi32.dll" (ByVal pData As Any, ByVal dwLng As Long, ByVal dwPrevCRC As Long) As Long


'--- Protected Item functions

' Activate dongle Algorithm or Protected Item
Declare Function GrdPI_Activate Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwItemNum As Long, ByVal dwActivPassw As Long) As Integer

' Deactivate dongle Algorithm or Protected Item
Declare Function GrdPI_Deactivate Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwItemNum As Long, ByVal dwActivPassw As Long) As Integer

' Read data from dongle Protected Item
Declare Function GrdPI_Read Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwItemNum As Long, ByVal dwAddr As Long, ByVal dwLng As Long, ByVal pData As Any, ByVal dwReadPSW As Long, ByVal pdwReserved As Any) As Integer

' Update data in dongle Protected Item
Declare Function GrdPI_Update Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwItemNum As Long, ByVal dwAddr As Long, ByVal dwLng As Long, ByVal pData As Any, ByVal dwUpdatePSW As Long, ByVal DwMethod As Long, ByVal pdwReserved As Any) As Integer


' ---  Guardant Trusted Remote Update API

' Write secret GSII64 remote update key for Guardant Secured Remote Update to the dongle
Declare Function GrdTRU_SetKey Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal pGSII64_Key128 As Any) As Integer    ' Unique Guardant Secured Remote Update GSII64 secret key

' Generate encrypted question and initialize remote update procedure
Declare Function GrdTRU_GenerateQuestion Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal pQuestion As Any, ByVal pdwID As Any, ByVal pdwPublic As Any, ByVal pHash As Any) As Integer

' Decrypt and validate question
Declare Function GrdTRU_DecryptQuestion Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwAlgoNum_GSII64 As Long, ByVal dwAlgoNum_HashS3 As Long, ByVal pQuestion As Any, ByVal dwID As Long, ByVal dwPublic As Long, ByVal pHash As Any) As Integer

' Set Init & Protect parameters for Trusted Remote Update
' This function must be called after GrdTRU_DecryptQuestion and before GrdTRU_EncryptAnswer functions
' only if Init & Protect operations will be executed during remote update (call GrdTRU_ApplyAnswer) procedure on remote PC
Declare Function GrdTRU_SetAnswerProperties Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwTRU_Flags As Long, ByVal dwReserved As Long, ByVal dwWriteProtect As Long, ByVal dwReadProtect As Long, ByVal dwNumFunc As Long, ByVal dwTableLMS As Long, ByVal dwGlobalFlags As Long, ByVal pReserved As Any) As Integer

'  Prepare data for Trusted Remote Update
Declare Function GrdTRU_EncryptAnswer Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwAddr As Long, ByVal dwLng As Long, ByVal pData As Any, ByVal pQuestion As Any, ByVal dwAlgoNum_GSII64 As Long, ByVal dwAlgoNum_HashS3 As Long, ByVal pAnswer As Any, ByVal pdwAnswerSize As Any) As Integer

' Apply encrypted answer data buffer received via remote update procedure
Declare Function GrdTRU_ApplyAnswer Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal pAnswer As Any, ByVal dwAnswerSize As Long) As Integer


' Guardant StealthIII Sign/Time Functions

' TGrdFindInfo
Public Type TGrdFindInfo
dwPublicCode As Long
byHrwVersion As Byte
byMaxNetRes As Byte
wType As Integer
dwID As Long
byNProg As Byte
byVer As Byte
wSN As Integer
wMask As Integer
wGP As Integer
wRealNetRes As Integer
dwIndex As Long
abyReservedISEE(&H1C) As Byte
wWriteProtectS3 As Integer
wReadProtectS3 As Integer
wGlobalFlags As Integer
dwDongleState As Long
abyReservedH(&H100 - &H1A - &H1C - &HA) As Byte
dwGrDrv_Platform As Long
dwGrDrv_Vers As Long
dwGrDrv_Build As Long
dwGrDrv_Reserved As Long
dwRkmUserAddr As Long
dwRkmAlgoAddrW As Long
dwPrnPort As Long
dwClientVersion As Long
dwRFlags As Long
dwRProgVer As Long
dwRcn_rc As Long
dwNcmps As Long
dwNSKClientVersion As Long
abyReserved(&H200 - &H100 - &H34) As Byte
End Type

' Dongle memory fields in SAM

' Fields protection against nsc_Init, nsc_Protect, nsc_Write commands
'    * - Partial protection: nsc_Protect can be executed only after nsc_Init
'    X - Full protection
' Protection against command:         Init Protect Write
Public Type TGrdStdFields
 byDongleModel As Byte          '  0h   X     X     X    0=GS,1=GU,2=GF,...
 byDongleMemSize As Byte        '  1h   X     X     X    0=0, 8=256 ( Memsize = 1 << byDongleMemSize )
 byDongleProgVer As Byte        '  2h   X     X     X
 byDongleProtocol As Byte       '  3h   X     X     X
 wClientVer As Integer             '  4h   X     X     X    0x104=1.4
 byDongleUserAddr As Byte       '  6h   X     X     X
 byDongleAlgoAddr As Byte       '  7h   X     X     X
 wPrnport As Integer            '  8h   X     X     X
 wWriteProtectS3 As Integer        '  Ah         *     X      // Stealth III write protect SAM address in bytes
 wReadProtectS3 As Integer         '  Ch         *     X      // Stealth III read  protect SAM address in bytes
 dwPublicCode As Long           '  Eh   X     X     X
 byVersion As Byte              ' 12h   X     X     X
 byLANRes As Byte               ' 13h   X     X     X
 wType As Integer                  ' 14h   X     X     X
 dwID As Long                   ' 16h   X     X     X
 byWriteProtect As Byte         ' 1Ah         *     X      // Stealth I & II write protect SAM address in words
 byReadProtect As Byte          ' 1Bh         *     X      // Stealth I & II read  protect SAM address in words
 byNumFunc As Byte              ' 1Ch         *     X
 byTableLMS As Byte             ' 1Dh         *     X
 byNProg As Byte                ' 1Eh   X     X
 byVer As Byte                  ' 1Fh   X     X
 wSN As Integer                 ' 20h   X     X
 wMask As Integer               ' 22h   X     X
 wGP As Integer                 ' 24h   X     X
 wRealLANRes As Integer         ' 26h   X     X
 dwIndex As Long                ' 28h   X     X
 abyAlgoAddr(1) As Byte         ' 2Ch
 End Type


Public Type TGrdSystemTime    ' Struktura vremeni
wYear As Integer
wMonth As Integer
wDayOfWeek As Integer
wDay As Integer
wHour As Integer
wMinute As Integer
wSecond As Integer
wMilliSeconds As Integer
End Type

' Digital sing on stealth Time/Sign dongles
Declare Function GrdSign Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwAlgoNum As Long, ByVal dwDataLng As Long, ByVal pData As Any, ByVal dwSignResultLng As Any, ByVal pSignResult As Any, ByVal pReseved As Any) As Integer

' ECC algorithm digest verifing
Declare Function GrdVerifySign Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwAlgoType As Long, ByVal dwPublicKeyLng As Long, ByVal pPublicKey As Any, ByVal dwDataLng As Long, ByVal pData As Any, ByVal dwSignLng As Long, ByVal pSign As Any, ByVal pReserved As Any) As Integer

' Set dongle system time
Declare Function GrdSetTime Lib "GrdApi32.dll" (ByVal hGrd As Long, ByRef pGrdSystemTime As TGrdSystemTime, ByVal pReserved As Any) As Integer

' Get dongle system time
Declare Function GrdGetTime Lib "GrdApi32.dll" (ByVal hGrd As Long, ByRef pGrdSystemTime As TGrdSystemTime, ByVal pReserved As Any) As Integer

' Get time limit for specified item
Declare Function GrdPI_GetTimeLimit Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal dwItemNum As Long, ByVal pGrdSystemTime As TGrdSystemTime, ByVal pReserved As Any) As Integer

'Get counter for specified item
Declare Function GrdPI_GetCounter Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal pdwCounter As Long, ByVal dwItemNum As Long) As Integer

'Create a system time from components
Declare Function GrdMakeSystemTime Lib "GrdApi32.dll" (ByVal hGrd As Long, ByVal wYear As Long, ByVal wMonth As Long, ByVal wDayOfWeek As Long, ByVal wDay As Long, ByVal wHour As Long, ByVal wMinute As Long, ByVal wSecond As Long, ByVal wMilliSeconds As Long, ByRef pGrdSystemTime As TGrdSystemTime) As Integer

'Split a system time into components
Declare Function GrdSplitSystemTime Lib "GrdApi32.dll" (ByVal hGrd As Long, ByRef pGrdSystemTime As TGrdSystemTime, ByVal pwYear As Long, ByVal pwMonth As Long, ByVal pwDayOfWeek As Long, ByVal pwDay As Long, ByVal pwHour As Long, ByVal pwMinute As Long, ByVal pwSecond As Long, ByVal pwMilliseconds As Long) As Integer
