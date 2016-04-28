  MEMBER

DELETE                    EQUATE(00010000h)
READ_CONTROL              EQUATE(00020000h)
WRITE_DAC                 EQUATE(00040000h)
WRITE_OWNER               EQUATE(00080000h)
SYNCHRONIZE               EQUATE(00100000h)

STANDARD_RIGHTS_REQUIRED  EQUATE(000F0000h)

STANDARD_RIGHTS_READ      EQUATE(READ_CONTROL)
STANDARD_RIGHTS_WRITE     EQUATE(READ_CONTROL)
STANDARD_RIGHTS_EXECUTE   EQUATE(READ_CONTROL)

STANDARD_RIGHTS_ALL       EQUATE(001F0000h)

SPECIFIC_RIGHTS_ALL       EQUATE(0000FFFFh)

HKEY_CLASSES_ROOT           EQUATE(80000000h)
HKEY_CURRENT_USER           EQUATE(80000001h)
HKEY_LOCAL_MACHINE          EQUATE(80000002h)
HKEY_USERS                  EQUATE(80000003h)
HKEY_PERFORMANCE_DATA       EQUATE(80000004h)
HKEY_CURRENT_CONFIG         EQUATE(80000005h)
HKEY_DYN_DATA               EQUATE(80000006h)

KEY_QUERY_VALUE             EQUATE(00001h)
KEY_SET_VALUE               EQUATE(00002h)
KEY_CREATE_SUB_KEY          EQUATE(00004h)
KEY_ENUMERATE_SUB_KEYS      EQUATE(00008h)
KEY_NOTIFY                  EQUATE(00010h)
KEY_CREATE_LINK             EQUATE(00020h)

KEY_READ                    EQUATE(STANDARD_RIGHTS_READ + KEY_QUERY_VALUE + KEY_ENUMERATE_SUB_KEYS + KEY_NOTIFY)
KEY_WRITE                   EQUATE(STANDARD_RIGHTS_WRITE + KEY_SET_VALUE + KEY_CREATE_SUB_KEY)
KEY_EXECUTE                 EQUATE(KEY_READ)
KEY_ALL_ACCESS              EQUATE(STANDARD_RIGHTS_ALL + KEY_QUERY_VALUE + KEY_SET_VALUE + KEY_CREATE_SUB_KEY + KEY_ENUMERATE_SUB_KEYS + KEY_NOTIFY + KEY_CREATE_LINK)

REG_OPTION_RESERVED         EQUATE(000000000h)   !!// Parameter is reserved
REG_OPTION_NON_VOLATILE     EQUATE(000000000h)   !!// Key is preserved
                                                 !!// when system is rebooted
REG_OPTION_VOLATILE         EQUATE(000000001h)   !!// Key is not preserved
                                                 !!// when system is rebooted
REG_OPTION_CREATE_LINK      EQUATE(000000002h)   !!// Created key is a
                                                 !!// symbolic link
REG_OPTION_BACKUP_RESTORE   EQUATE(000000004h)   !!// open for backup or restore
                                                 !!// special access rules
                                                 !!// privilege required
REG_OPTION_OPEN_LINK        EQUATE(000000008h)   !!// Open symbolic link

REG_LEGAL_OPTION            EQUATE(REG_OPTION_RESERVED + REG_OPTION_NON_VOLATILE + REG_OPTION_VOLATILE + REG_OPTION_CREATE_LINK + REG_OPTION_BACKUP_RESTORE + REG_OPTION_OPEN_LINK)

REG_CREATED_NEW_KEY         EQUATE(000000001h)   !!// New Registry Key created
REG_OPENED_EXISTING_KEY     EQUATE(000000002h)   !!// Existing Key opened

REG_WHOLE_HIVE_VOLATILE     EQUATE(000000001h)   !!// Restore whole hive volatile
REG_REFRESH_HIVE            EQUATE(000000002h)   !!// Unwind changes to last flush
REG_NO_LAZY_FLUSH           EQUATE(000000004h)   !!// Never lazy flush this hive

REG_NOTIFY_CHANGE_NAME       EQUATE(000000001h)  !!// Create or delete (child)
REG_NOTIFY_CHANGE_ATTRIBUTES EQUATE(000000002h)
REG_NOTIFY_CHANGE_LAST_SET   EQUATE(000000004h)  !!// time stamp
REG_NOTIFY_CHANGE_SECURITY   EQUATE(000000008h)

REG_LEGAL_CHANGE_FILTER      EQUATE(REG_NOTIFY_CHANGE_NAME + REG_NOTIFY_CHANGE_ATTRIBUTES + REG_NOTIFY_CHANGE_LAST_SET + REG_NOTIFY_CHANGE_SECURITY)

REG_NONE                     EQUATE( 0 )   !!// No value type
REG_SZ                       EQUATE( 1 )   !!// Unicode nul terminated string
REG_EXPAND_SZ                EQUATE( 2 )   !!// Unicode nul terminated string
                                           !!// (with environment variable references)
REG_BINARY                   EQUATE( 3 )   !!// Free form binary
REG_DWORD                    EQUATE( 4 )   !!// 32-bit number
REG_DWORD_LITTLE_ENDIAN      EQUATE( 4 )   !!// 32-bit number (same as REG_DWORD)
REG_DWORD_BIG_ENDIAN         EQUATE( 5 )   !!// 32-bit number
REG_LINK                     EQUATE( 6 )   !!// Symbolic Link (unicode)
REG_MULTI_SZ                 EQUATE( 7 )   !!// Multiple Unicode strings
REG_RESOURCE_LIST            EQUATE( 8 )   !!// Resource list in the resource map
REG_FULL_RESOURCE_DESCRIPTOR EQUATE( 9 )   !!// Resource list in the hardware description
REG_RESOURCE_REQUIREMENTS_LIST EQUATE( 10 )


!! Equates for API
GENERIC_READ              EQUATE(80000000h)
GENERIC_WRITE             EQUATE(40000000h)
GENERIC_EXECUTE           EQUATE(20000000h)
GENERIC_ALL               EQUATE(10000000h)

FILE_ATTRIBUTE_READONLY   EQUATE(00000001h)
FILE_ATTRIBUTE_HIDDEN     EQUATE(00000002h)
FILE_ATTRIBUTE_SYSTEM     EQUATE(00000004h)
FILE_ATTRIBUTE_DIRECTORY  EQUATE(00000010h)
FILE_ATTRIBUTE_ARCHIVE    EQUATE(00000020h)
FILE_ATTRIBUTE_NORMAL     EQUATE(00000080h)
FILE_ATTRIBUTE_TEMPORARY  EQUATE(00000100h)

CREATE_NEW                EQUATE(1)
CREATE_ALWAYS             EQUATE(2)
OPEN_EXISTING             EQUATE(3)
OPEN_ALWAYS               EQUATE(4)
TRUNCATE_EXISTING         EQUATE(5)

SHARE_NONE                EQUATE(0)
INVALID_LONG_VALUE        EQUATE(4294967295)
INVALID_LONG              EQUATE( -1 )
SM_REMOTESESSION          EQUATE(01000h)


  !! Version Stuff
VER_PLATFORM_WIN32s             EQUATE( 0 )
VER_PLATFORM_WIN32_WINDOWS      EQUATE( 1 )
VER_PLATFORM_WIN32_NT           EQUATE( 2 )

!! Type DEFS for API
  !! Version Stuff
OSVERSIONINFO                   GROUP,TYPE
dwOSVersionInfoSize               ULONG
dwMajorVersion                    ULONG
dwMinorVersion                    ULONG
dwBuildNumber                     ULONG
dwPlatformId                      ULONG
szCSDVersion                      CSTRING( 128 )
                                END

  !! File Stuff
FILETIME                        GROUP,TYPE
dwLowDateTime                     ULONG
dwHighDateTime                    ULONG
                                END

WIN32_FIND_DATA                 GROUP,TYPE
dwFileAttributes                  ULONG
ftCreationTime                    GROUP(FILETIME).
ftLastAccessTime                  GROUP(FILETIME).
ftLastWriteTime                   GROUP(FILETIME).
nFileSizeHigh                     ULONG
nFileSizeLow                      ULONG
dwReserved0                       ULONG
dwReserved1                       ULONG
cFileName                         CSTRING( FILE:MaxFilePath )
cAlternateFileName                CSTRING( 14 )
                                END

SYSTEMTIME                      GROUP,TYPE
wYear                             USHORT
wMonth                            USHORT
wDayOfWeek                        USHORT
wDay                              USHORT
wHour                             USHORT
wMinute                           USHORT
wSecond                           USHORT
wMilliseconds                     USHORT
                                END

SPI_GETDRAGFULLWINDOWS          EQUATE(38)
SPI_SETDRAGFULLWINDOWS          EQUATE(37)
SPIF_UPDATEINIFILE              EQUATE(1)
SPIF_SENDWININICHANGE           EQUATE(2)



  MAP
    MODULE('win32')
      FindFirstFile( *CSTRING lpFileName, *WIN32_FIND_DATA ),LONG,RAW,PASCAL,NAME('FindFirstFileA')
      FindClose( LONG hFindFile ),BOOL,RAW,PASCAL,PROC
      CreateDirectory( *cSTRING lpPathName, LONG ),BOOL,PASCAL,RAW,NAME( 'CreateDirectoryA' )
      GetLastError(),ULONG,PASCAL,RAW
      FindWindow( <*CSTRING>, *CSTRING ),LONG,PASCAL,RAW,NAME( 'FindWindowA' )
      FileTimeToSystemTime(*FILETIME lpFileTime, *SYSTEMTIME lpSystemTime),BOOL,RAW,PASCAL,PROC
      FileTimeToLocalFileTime(*FILETIME lpFileTime, *FILETIME lpLocalFileTime),BOOL,RAW,PASCAL,PROC
      CreateFile( *CSTRING lpFileName, ULONG dwDesiredAccess, ULONG dwShareMode, LONG lpSecurityAttributes, ULONG dwCreationDisposition, ULONG dwFlagsAndAttributes, LONG hTemplateFile), LONG,RAW,PASCAL,NAME('CreateFileA')
      WriteFile( LONG hFile, *STRING lpBuffer, ULONG nNumberOfBytesToWrite, *ULONG lpNumberOfBytesWritten, LONG lpOverlapped ),BOOL,RAW,PASCAL
      CloseLONG( LONG hObject ),BOOL,RAW,PASCAL,PROC
      GetVersionEx( *OSVERSIONINFO lpVersionInformation ),BOOL,RAW,PASCAL,NAME('GetVersionExA'),PROC
      WNetGetUser( *CSTRING lpName, *STRING lpUserName,  *ULONG lpnLength ),ULONG,RAW,PASCAL,PROC,NAME('WNetGetUserA')
      CreateEvent( LONG lpEventAttributes, BOOL bManualReset, BOOL bInitialState, *CSTRING lpName ),LONG,RAW,PASCAL,NAME('CreateEventA')
      GetSystemMetrics( SHORT nIndex ),SHORT,RAW,PASCAL
      RemoveDirectory( *CSTRING lpPathName ), BOOL, RAW, PASCAL, NAME( 'RemoveDirectoryA' )
      GetTempPath( LONG nBufferLength, *STRING lpBuffer ), LONG, RAW, PASCAL, NAME('GetTempPathA')
      GetTempFileName( *CSTRING lpPathName, *CSTRING lpPrefixString, UNSIGNED uUnique, *CSTRING lpTempFileName ),UNSIGNED,RAW,PASCAL,NAME('GetTempFileNameA')

      RegCloseKey(LONG hkey),LONG,RAW,PASCAL,PROC
      RegCreateKey(LONG class, *CSTRING key, *LONG hkey),LONG,RAW,PASCAL,PROC,NAME('RegCreateKeyA')
      RegOpenKey(LONG class, *CSTRING key, *LONG hkey),LONG,RAW,PASCAL,NAME('RegOpenKeyA')
      RegSetValue(LONG hkey, *CSTRING item, LONG type, *CSTRING value, LONG valLen),LONG,RAW,PASCAL,NAME('RegSetValueA')
      RegOpenKeyEx( LONG hKey, *CSTRING lpSubKey, LONG ulOptions, LONG samDesired, *LONG phkResult ),LONG,RAW,PASCAL,NAME('RegOpenKeyExA'),DLL(dll_mode)
      RegQueryValueEx( LONG hKey, *CSTRING lpValueName, LONG lpReserved, *LONG lpType, *STRING lpData, *LONG lpcbData ),LONG,RAW,PASCAL,NAME('RegQueryValueExA'),DLL(dll_mode)
      RegQueryValue(LONG hkey, *CSTRING item, *STRING value, *LONG valLen),LONG,RAW,PASCAL,NAME('RegQueryValueA')
      RegSetValueEx( LONG hKey, *CSTRING lpValueName, LONG Reserved, LONG dwType, *STRING lpData, LONG cbData ),LONG,RAW,PASCAL,NAME('RegSetValueExA'),DLL(dll_mode)
      RegCreateKeyEx( LONG hKey, *CSTRING lpSubKey, LONG Reserved, *CSTRING lpClass, LONG dwOptions, LONG samDesired, LONG lpSecurityAttributes, *LONG phkResult, *LONG lpdwDisposition ),LONG,RAW,PASCAL,NAME('RegCreateKeyExA'),DLL(dll_mode)
      RegEnumKeyEx( LONG hKey, LONG dwIndex, *CSTRING lpName, *LONG lpcbName,  LONG lpReserved, *CSTRING lpClass, *LONG lpcbClass, LONG lpftLastWriteTime ),LONG,RAW,PASCAL,NAME('RegEnumKeyExA'),DLL(dll_mode)
      RegDeleteKey( LONG hKey, *CSTRING lpSubKey ),LONG,RAW,PASCAL,NAME('RegDeleteKeyA'),DLL(dll_mode)
      RegDeleteValue( LONG hKey, *CSTRING lpValueName ),LONG,RAW,PASCAL,NAME('RegDeleteValueA'),DLL(dll_mode)

      SystemParametersInfo( LONG uAction, LONG uParam, *? lpvParam, LONG fuWinIni ), LONG, RAW, PASCAL, DLL(TRUE), NAME('SystemParametersInfoA'),PROC
    END
    INCLUDE('C55Util.INC')
  END


hFindHandle         LONG
gFileFind           GROUP( WIN32_FIND_DATA ).
szFindFile          CSTRING(256)
gTempLocalTime      GROUP(FILETIME).
gTempSystemTime     GROUP(SYSTEMTIME).

!-----------------------------------------------------------------------------!
!OSVersion
! Return the Current OS Version (Windows 95, Windows 98 or Windows NT)
!-----------------------------------------------------------------------------!

OSVersion                               FUNCTION()

gVersion        GROUP( OSVERSIONINFO ).
sReturnVersion  STRING(128)

  CODE
  CLEAR( gVersion )
  CLEAR( sReturnVersion )
  sReturnVersion = 'Unkown'
  gVersion.dwOSVersionInfoSize = SIZE( OSVERSIONINFO )
  GetVersionEx( gVersion )
  CASE gVersion.dwPlatformID
  OF VER_PLATFORM_WIN32_WINDOWS
    IF gVersion.dwMinorVersion = 0
      sReturnVersion = 'Windows 95'
    ELSE
      sReturnVersion = 'Windows 98'
    END
  OF VER_PLATFORM_WIN32_NT
    IF gVersion.dwMajorVersion <= 4
      IF UPPER( CLIP( GetReg( HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\ProductOptions', 'ProductType' ) ) ) = 'WINNT'
        sReturnVersion = 'Windows NT Workstation'
      ELSE
        sReturnVersion = 'Windows NT Server'
      END
    ELSIF gVersion.dwMajorVersion = 5
      IF UPPER( CLIP( GetReg( HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\ProductOptions', 'ProductType' ) ) ) = 'WINNT'
        sReturnVersion = 'Windows 2000 Professional'
      ELSE
        sReturnVersion = 'Windows 2000 Server'
      END
    END

  END
  IF CLIP( gVersion.szCSDVersion ) <> ''
    sReturnVersion = CLIP( sReturnVersion ) & ' ' & CLIP( gVersion.szCSDVersion )
  END
  RETURN CLIP( sReturnVersion )

!-----------------------------------------------------------------------------!
!FileExists
! Return wether a file exists or not (TRUE = Exists, FALSE = Does NOT)
!-----------------------------------------------------------------------------!

FileExists                              FUNCTION( STRING sFile )

bRetVal             BYTE

  CODE
  hFindHandle = 0
  bRetVal     = FALSE
  szFindFile   = CLIP( sFile )
  CLEAR( gFileFind )

  hFindHandle = FindFirstFile( szFindFile, gFileFind )
  IF hFindHandle = INVALID_LONG_VALUE OR hFindHandle <= 0
    bRetVal = FALSE
  ELSE
    bRetVal = TRUE
  END
  FindClose( hFindHandle )
  RETURN bRetVal

!-----------------------------------------------------------------------------!
!WindowExists
! Return wether a file exists or not (TRUE = Exists, FALSE = Does NOT)
!-----------------------------------------------------------------------------!

WindowExists                            FUNCTION( STRING sWindow )

hHwnd               LONG
szWindowName        CSTRING( 128 )
bRetVal             BYTE

  CODE
  szWindowName = CLIP( sWindow )
  hHwnd = FindWindow(,szWindowName)
  IF hHwnd
    bRetVal = TRUE
  ELSE
    bRetVal = FALSE
  END
  RETURN bRetVal

!-----------------------------------------------------------------------------!
!ValidateOLE
! Validate that the OLE Control Created
!-----------------------------------------------------------------------------!
ValidateOLE                             PROCEDURE( SIGNED OleControl, <STRING OleFileName>, <STRING OleCreateName> )

lCallRet      LONG

  CODE
  IF OleControl{PROP:OLE} = FALSE AND OleControl{PROP:Object} = ''
    IF ~OMITTED( 2 )
      OleControl{PROP:Create} = CLIP( OleCreateName )
      IF OleControl{PROP:OLE} = FALSE AND OleControl{PROP:Object} = ''
        IF ~OMITTED( 3 )
          lCallRet = CALL( CLIP( OleFileName ),'DllRegisterServer' )
          IF lCallRet
            MESSAGE('Can not Register OLE Control ' & CLIP( OleFileName ) & ' Error: ' & CLIP( lCallRet ) & '.  Please re-install Legal Files.','Fatal OLE Error',ICON:Exclamation)
            RETURN FALSE
          END
          UNLOAD( CLIP( OleFileName ) )
          OleControl{PROP:Create} = CLIP( OleCreateName )
        ELSE
          RETURN FALSE
        END
        IF OleControl{PROP:OLE} = FALSE AND OleControl{PROP:Object} = ''
          MESSAGE('Can not Find OLE Control ' & CLIP( OleFileName ) & ' !  Please re-install.','Fatal OLE Error',ICON:Exclamation)
          RETURN FALSE
        ELSE
          RETURN TRUE
        END
      END
    ELSE
      RETURN FALSE
    END
  ELSE
    RETURN TRUE
  END

!-----------------------------------------------------------------------------!
!GetUserName
! Return the network username
!-----------------------------------------------------------------------------!
GetUserName                             PROCEDURE( )

sRetuser      STRING(64)
dwUserLen     ULONG
szProcess     CSTRING(2)

  CODE
  szProcess = ''
  sRetUser  = ''
  dwUserLen = LEN( sRetUser )
  IF WNetGetUser( szProcess, sRetUser, dwUserLen ) = 0
    LOOP dwUserLen = LEN( sRetUser ) TO 1 BY -1
      IF sRetUser[ dwUserLen ] = '<0>'
        sRetUser[ dwUserLen ] = ' '
      END
    END
    RETURN CLIP( sRetUser )
  ELSE
    RETURN ''
  END

!-----------------------------------------------------------------------------!
!BeginUnique
! Set APP to run in Single Process
!-----------------------------------------------------------------------------!
BeginUnique                             PROCEDURE( STRING sAppName )

szEventName       CSTRING(64)
hEvent            LONG

  CODE
  szEventName = CLIP( sAppName ) & '_UEvent'
  CLEAR( hEvent )
  hEvent = CreateEvent( 0, 0, 0, szEventName )
  IF hEvent = 0 OR GetLastError() = 183             !Already Exists
    RETURN FALSE
  ELSE
    RETURN hEvent
  END

!-----------------------------------------------------------------------------!
!EndUnique
! Un Set APP to run in Single Process
!-----------------------------------------------------------------------------!
EndUnique                               PROCEDURE( LONG hUnique )

  CODE
  CloseLONG( hUnique )
  RETURN


!-----------------------------------------------------------------------------!
!IsTermServer
! Is this application running on terminal server
!-----------------------------------------------------------------------------!
IsTermServer                            FUNCTION( )

  CODE
  IF GetSystemMetrics( SM_REMOTESESSION ) <> 0
    RETURN TRUE
  ELSE
    RETURN FALSE
  END

!-----------------------------------------------------------------------------!
!GetFileTime
! Get the File Time for the specified file.
!-----------------------------------------------------------------------------!
GetFileTime                             FUNCTION( STRING iFile, BYTE bType=0 )

  CODE
  hFindHandle = 0
  szFindFile   = CLIP( iFile )
  CLEAR( gFileFind )

  hFindHandle = FindFirstFile( szFindFile, gFileFind )
  IF hFindHandle = INVALID_LONG_VALUE OR hFindHandle <= 0
    RETURN 0
  END
  FindClose( hFindHandle )
  CASE bType
  OF 0
    FileTimeToLocalFileTime( gFileFind.ftLastWriteTime, gTempLocalTime )
  OF 1
    FileTimeToLocalFileTime( gFileFind.ftCreationTime, gTempLocalTime )
  OF 2
    FileTimeToLocalFileTime( gFileFind.ftLastAccessTime, gTempLocalTime )
  END

  FileTimeToSystemTime( gTempLocalTime, gTempSystemTime )
  RETURN DEFORMAT( gTempSystemTime.wHour & ':' & gTempSystemTime.wMinute & ':' & gTempSystemTime.wSecond, @t4 )

!-----------------------------------------------------------------------------!
!GetFileDate
! Get the File Time for the specified file.
!-----------------------------------------------------------------------------!
GetFileDate                             FUNCTION( STRING iFile, BYTE bType=0 )

  CODE
  hFindHandle = 0
  szFindFile   = CLIP( iFile )
  CLEAR( gFileFind )

  hFindHandle = FindFirstFile( szFindFile, gFileFind )
  IF hFindHandle = INVALID_LONG_VALUE OR hFindHandle <= 0
    RETURN 0
  END
  FindClose( hFindHandle )
  CASE bType
  OF 0
    FileTimeToLocalFileTime( gFileFind.ftLastWriteTime, gTempLocalTime )
  OF 1
    FileTimeToLocalFileTime( gFileFind.ftCreationTime, gTempLocalTime )
  OF 2
    FileTimeToLocalFileTime( gFileFind.ftLastAccessTime, gTempLocalTime )
  END

  FileTimeToSystemTime( gTempLocalTime, gTempSystemTime )

  RETURN DEFORMAT( gTempSystemTime.wMonth & '/' & gTempSystemTime.wDay & '/' & gTempSystemTime.wYear, @d2 )

!-----------------------------------------------------------------------------!
!CreateDirectory
! Create a directory
!-----------------------------------------------------------------------------!
CreateDirectory                         FUNCTION( STRING sDirectory )

  CODE
  szFindFile = CLIP( sDirectory )
  RETURN CreateDirectory( szFindFile, 0 )

!-----------------------------------------------------------------------------!
!RemoveDirectory
! Remove a directory
!-----------------------------------------------------------------------------!
RemoveDirectory                         FUNCTION( STRING sDirectory )

  CODE
  szFindFile = CLIP( sDirectory )
  RETURN RemoveDirectory( szFindFile )

!-----------------------------------------------------------------------------!
!GetTempPath
! Retreive the path pointed to by TMP or TEMP
!-----------------------------------------------------------------------------!
GetTempPath                             FUNCTION( )

sTmpPath        STRING(FILE:MaxFilePath)
lPathSize       LONG

  CODE
  lPathSize = GetTempPath( FILE:MaxFilePath, sTmpPath )
  IF lPathSize = 0 OR lPathSize > FILE:MaxFilePath
    RETURN ''
  ELSE
    RETURN sTmpPath[ 1 : lPathSize ]
  END

!-----------------------------------------------------------------------------!
!GetTempPath
! Retreive the path pointed to by TMP or TEMP
!-----------------------------------------------------------------------------!
GetTempFileName                         FUNCTION( STRING sPrefix, <STRING sDirectory> )

szPath          CSTRING(FILE:MaxFilePath)
szPrefix        CSTRING( 4 )
szTempname      CSTRING(FILE:MaxFilePath)
uiUnique        UNSIGNED

  CODE
  IF OMITTED( 2 )
    szPath = GetTempPath()
    IF CLIP( szPath ) = ''
      szPath = '.'
    END
  ELSE
    szPath = CLIP( sDirectory )
  END
  szPrefix = CLIP( sPrefix )
  IF szPrefix = ''
    szPrefix = '$$$'
  END
  IF GetTempFileName( szPath, szPrefix, 0, szTempName ) = 0
    RETURN ''
  ELSE
    RETURN CLIP( szTempName )
  END

GetReg                               FUNCTION( LONG hKey, STRING sSubKeyPath, STRING sValue )
!here
szValueName           CSTRING(256)
lRegRetVal            LONG
lLength               LONG
szOpenKey             CSTRING(256)
szClass               CSTRING(2)
szValue               CSTRING(256)
dwValueType           LONG
sData                 STRING(255)
dwData                ULONG
hKeyHandle            LONG

  CODE

  szOpenKey = CLIP(sSubKeyPath)
  lRegRetVal = RegOpenKeyEx( hKey, szOpenKey, 0, KEY_READ, hKeyHandle )
  IF lRegRetVal <> 0
    RETURN FALSE
  END

  szValue = CLIP( sValue )
  lLength = 255
  lRegRetVal = RegQueryValueEx( hKeyHandle, szValue, 0, dwValueType, sData, lLength )
  RegCloseKey( hKeyHandle )
  CASE dwValueType
  OF REG_SZ
  OROF REG_EXPAND_SZ
  OROF REG_MULTI_SZ
    RETURN sData[ 1 : lLength - 1 ]
  OF REG_BINARY
    RETURN sData[ 1 : lLength ]
  OF REG_DWORD
  OROF REG_DWORD_LITTLE_ENDIAN
  OROF REG_DWORD_BIG_ENDIAN
    dwData = VAL( CLIP( sData ) )
    RETURN dwData
  ELSE
    RETURN FALSE
  END

PutReg                               FUNCTION( LONG hKey, STRING sSubKeyPath, STRING sValueName, STRING sValue, LONG lType=1 )

szValueName           CSTRING(256)
lRegRetVal            LONG
lLength               LONG
szOpenKey             CSTRING(256)
szClass               CSTRING(2)
szValue               STRING(256)
dwValueType           LONG
sData                 STRING(255)
dwData                ULONG
hKeyHandle            LONG
dwDisposition         LONG
iLongVal              LONG

  CODE

  szOpenKey = CLIP(sSubKeyPath)
  lRegRetVal = RegCreateKeyEx( hKey, szOpenKey, 0, szClass, REG_OPTION_NON_VOLATILE, KEY_READ + KEY_WRITE, 0, hKeyHandle, dwDisposition )
  IF lRegRetVal <> 0
    RETURN FALSE
  END
  szValueName = CLIP( sValueName )
  szValue = sValue

  CASE lType
  OF REG_SZ
  OROF REG_EXPAND_SZ
  OROF REG_MULTI_SZ
    lLength = LEN( CLIP( szValue ) ) + 1
    szValue = szValue[ 1 : lLength - 1 ] & '<0>'
  OF REG_BINARY
    lLength = LEN( CLIP( szValue ) )
    szValue = szValue[ 1 : lLength ]
  OF REG_DWORD
  OROF REG_DWORD_LITTLE_ENDIAN
  OROF REG_DWORD_BIG_ENDIAN
    iLongVal = szValue
    szValue = CHR( BAND( iLongVal, 11111111b ) ) & |
                 CHR( BAND( BSHIFT(iLongVal,-8), 11111111b ) ) & |
                 CHR( BAND( BSHIFT(iLongVal,-16), 11111111b ) ) & |
                 CHR( BAND( BSHIFT(iLongVal,-24), 11111111b ) )
    lLength = 4
  END
  lRegRetVal = RegSetValueEx( hKeyHandle, szValueName, 0, lType, szValue, lLength )
  RETURN lRegRetVal


FullDrag                  PROCEDURE( <LONG lDragSetting> )
lCurrentSetting     LONG
  CODE
  IF ~OMITTED( 1 )
    SystemParametersInfo(SPI_SETDRAGFULLWINDOWS, lDragSetting, lCurrentSetting, SPIF_SENDWININICHANGE+SPIF_UPDATEINIFILE)
    RETURN lDragSetting
  END    
  SystemParametersInfo(SPI_GETDRAGFULLWINDOWS, 0, lCurrentSetting, SPIF_SENDWININICHANGE+SPIF_UPDATEINIFILE)
  RETURN lCurrentSetting