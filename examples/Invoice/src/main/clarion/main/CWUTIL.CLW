  MEMBER
  INCLUDE ('ERRORS.CLW')

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


!! Type DEFS for API

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

HexDigitsUp                     STRING('0123456789ABCDEF'),PRIVATE
HexDigitsLow                    STRING('0123456789abcdef'),PRIVATE


  MAP
    MODULE('C Library')
      mkdir (*CSTRING),SIGNED,PROC,RAW,NAME('_mkdir')
      rmdir (*CSTRING),SIGNED,PROC,RAW,NAME('_rmdir')
    END
    MODULE('win32')
      FindFirstFile( *CSTRING lpFileName, *WIN32_FIND_DATA ),LONG,RAW,PASCAL,NAME('FindFirstFileA')
      FindClose( LONG hFindFile ),BOOL,RAW,PASCAL,PROC
      GetLastError(),ULONG,PASCAL,RAW
      FindWindow( <*CSTRING>, *CSTRING ),UNSIGNED,PASCAL,RAW,NAME( 'FindWindowA' )
      FileTimeToSystemTime(*FILETIME lpFileTime, *SYSTEMTIME lpSystemTime),BOOL,RAW,PASCAL,PROC
      FileTimeToLocalFileTime(*FILETIME lpFileTime, *FILETIME lpLocalFileTime),BOOL,RAW,PASCAL,PROC
      CreateFile( *CSTRING lpFileName, ULONG dwDesiredAccess, ULONG dwShareMode, LONG lpSecurityAttributes, ULONG dwCreationDisposition, ULONG dwFlagsAndAttributes, LONG hTemplateFile), LONG,RAW,PASCAL,NAME('CreateFileA')
      WriteFile( LONG hFile, *STRING lpBuffer, ULONG nNumberOfBytesToWrite, *ULONG lpNumberOfBytesWritten, LONG lpOverlapped ),BOOL,RAW,PASCAL
      CloseHandle( LONG hObject ),BOOL,RAW,PASCAL,PROC
      WNetGetUser( <*CSTRING lpName>, *CSTRING lpUserName, *ULONG lpnLength ),ULONG,RAW,PASCAL,PROC,NAME('WNetGetUserA')
      CreateEvent( <*?>, BOOL bManualReset, BOOL bInitialState, *CSTRING lpName ),LONG,RAW,PASCAL,NAME('CreateEventA')
      GetSystemMetrics( SIGNED nIndex ),SIGNED,RAW,PASCAL
      GetTempPath( LONG nBufferLength, *? lpBuffer ),LONG,RAW,PASCAL,NAME('GetTempPathA')
      GetTempFileName( *CSTRING lpPathName, *CSTRING lpPrefixString, UNSIGNED uUnique, *CSTRING lpTempFileName ),UNSIGNED,RAW,PASCAL,NAME('GetTempFileNameA')

      RegCloseKey(LONG hkey),LONG,RAW,PASCAL,PROC
      RegCreateKeyEx( LONG hKey, *CSTRING lpSubKey, <LONG Reserved>, <*CSTRING lpClass>, LONG dwOptions, LONG samDesired, LONG lpSecurityAttributes, *LONG phkResult, *LONG lpdwDisposition ),LONG,RAW,PASCAL,NAME('RegCreateKeyExA')
      RegOpenKeyEx( LONG hKey, <*CSTRING lpSubKey>, LONG ulOptions, LONG samDesired, *LONG phkResult ),LONG,RAW,PASCAL,NAME('RegOpenKeyExA')
      RegSetValue(LONG hkey, *CSTRING item, LONG type, *CSTRING value, LONG valLen),LONG,RAW,PASCAL,NAME('RegSetValueA')
      RegQueryValueEx( LONG hKey, *CSTRING lpValueName, LONG lpReserved, *LONG lpType, *STRING lpData, *LONG lpcbData ),LONG,RAW,PASCAL,NAME('RegQueryValueExA')
      RegSetValueEx( LONG hKey, *CSTRING lpValueName, LONG Reserved, LONG dwType, *STRING lpData, LONG cbData ),LONG,RAW,PASCAL,NAME('RegSetValueExA')
      RegEnumKeyEx( LONG hKey, LONG dwIndex, *CSTRING lpName, *LONG lpcbName,  LONG lpReserved, *CSTRING lpClass, *LONG lpcbClass, LONG lpftLastWriteTime ),LONG,RAW,PASCAL,NAME('RegEnumKeyExA')
      RegDeleteKey( LONG hKey, *CSTRING lpSubKey ),LONG,RAW,PASCAL,NAME('RegDeleteKeyA')
      RegDeleteValue( LONG hKey, *CSTRING lpValueName ),LONG,RAW,PASCAL,NAME('RegDeleteValueA')

      SystemParametersInfo( LONG uAction, LONG uParam, *? lpvParam, LONG fuWinIni ), LONG, RAW, PASCAL, DLL(TRUE), NAME('SystemParametersInfoA'),PROC
    END
    INCLUDE('CWUTIL.INC'),ONCE

    GetFileSystemTimeDate (STRING FileName, BYTE which, *SYSTEMTIME systime),BOOL,PRIVATE
  END


!-----------------------------------------------------------------------------!
!OSVersion
! Return the Current OS Version (Windows 95, Windows 98 or Windows NT)
!-----------------------------------------------------------------------------!

OSVersion  PROCEDURE()
  CODE
  RETURN SYSTEM {PROP:WindowsVersion}

!-----------------------------------------------------------------------------!
!FileExists
! Return wether a file exists or not (TRUE = Exists, FALSE = Does NOT)
!-----------------------------------------------------------------------------!

FileExists         PROCEDURE ( STRING sFile )

bRetVal            BYTE,AUTO
hFindHandle        SIGNED,AUTO
szFindFile         CSTRING(FILE:MaxFileName),AUTO
gFileFind          LIKE (WIN32_FIND_DATA),AUTO

  CODE
  hFindHandle = 0
  bRetVal     = FALSE
  szFindFile  = CLIP (sFile)
  CLEAR (gFileFind)

  hFindHandle = FindFirstFile (szFindFile, gFileFind)
  bRetVal = CHOOSE (NOT (hFindHandle = INVALID_LONG_VALUE OR hFindHandle <= 0))

  FindClose (hFindHandle)
  RETURN bRetVal

!-----------------------------------------------------------------------------!
!WindowExists
! Return wether a window exists or not (TRUE = Exists, FALSE = Does NOT)
!-----------------------------------------------------------------------------!

WindowExists       PROCEDURE (STRING sWindow)

hWnd               UNSIGNED,AUTO
szWindowName       CSTRING (128),AUTO

  CODE
  szWindowName = CLIP (sWindow)
  hWnd = FindWindow (,szWindowName)
  RETURN CHOOSE (hWnd <> 0)

!-----------------------------------------------------------------------------!
!ValidateOLE
! Validate that the OLE Control Created
!-----------------------------------------------------------------------------!
ValidateOLE        PROCEDURE( SIGNED OleControl, <STRING OleFileName>, <STRING OleCreateName> )

lCallRet           LONG

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
GetUserName        PROCEDURE()

sRetUser           CSTRING(128)
dwUserLen          ULONG,AUTO

  CODE
  dwUserLen = SIZE ( sRetUser )
  IF WNetGetUser (, sRetUser, dwUserLen ) = 0
    RETURN CLIP (sRetUser)
  ELSE
    RETURN ''
  END

!-----------------------------------------------------------------------------!
!BeginUnique
! Set APP to run in Single Process
!-----------------------------------------------------------------------------!
BeginUnique        PROCEDURE( STRING sAppName )

szEventName        CSTRING(FILE:MaxFilePath),AUTO
hEvent             LONG,AUTO

  CODE
  szEventName = CLIP( sAppName ) & '_UEvent'
  CLEAR( hEvent )
  hEvent = CreateEvent (, 0, 0, szEventName )
  IF hEvent = 0 OR GetLastError() = 183             !Already Exists
    RETURN FALSE
  ELSE
    RETURN hEvent
  END

!-----------------------------------------------------------------------------!
!EndUnique
! Un Set APP to run in Single Process
!-----------------------------------------------------------------------------!
EndUnique          PROCEDURE( LONG hUnique )

  CODE
  CloseHandle ( hUnique )
  RETURN


!-----------------------------------------------------------------------------!
!IsTermServer
! Is this application running on terminal server
!-----------------------------------------------------------------------------!
IsTermServer       PROCEDURE()

  CODE
  IF GetSystemMetrics( SM_REMOTESESSION ) <> 0
    RETURN TRUE
  ELSE
    RETURN FALSE
  END


!-----------------------------------------------------------------------------!
!GetFileSystemTimeDate
! Get the system File Time and Date for the specified file.
!-----------------------------------------------------------------------------!
GetFileSystemTimeDate PROCEDURE (STRING FileName, BYTE which, *SYSTEMTIME systime)

hFindHandle        LONG,AUTO
gFileFind          GROUP( WIN32_FIND_DATA ),AUTO.
szFindFile         CSTRING(FILE:MaxFileName),AUTO
gTempLocalTime     GROUP(FILETIME),AUTO.

  CODE
  hFindHandle = 0
  szFindFile  = CLIP (FileName)
  CLEAR (gFileFind)

  hFindHandle = FindFirstFile( szFindFile, gFileFind )
  IF hFindHandle = INVALID_LONG_VALUE OR hFindHandle <= 0
    RETURN FALSE
  END

  FindClose (hFindHandle)

  CASE which
  OF 0
    FileTimeToLocalFileTime( gFileFind.ftLastWriteTime, gTempLocalTime )
  OF 1
    FileTimeToLocalFileTime( gFileFind.ftCreationTime, gTempLocalTime )
  OF 2
    FileTimeToLocalFileTime( gFileFind.ftLastAccessTime, gTempLocalTime )
  END

  FileTimeToSystemTime ( gTempLocalTime, systime )
  RETURN TRUE

!-----------------------------------------------------------------------------!
!GetFileTime
! Get the File Time for the specified file.
!-----------------------------------------------------------------------------!
GetFileTime        PROCEDURE ( STRING iFile, BYTE bType=0 )

gTempSystemTime    GROUP(SYSTEMTIME),AUTO.

  CODE
  IF GetFileSystemTimeDate (iFile, bType, gTempSystemTime)
    RETURN DEFORMAT( gTempSystemTime.wHour & ':' & gTempSystemTime.wMinute & ':' & gTempSystemTime.wSecond, @t4 )
  END

  RETURN 0

!-----------------------------------------------------------------------------!
!GetFileDate
! Get the File Date for the specified file.
!-----------------------------------------------------------------------------!
GetFileDate        PROCEDURE ( STRING iFile, BYTE bType=0 )

gTempSystemTime    GROUP(SYSTEMTIME),AUTO.

  CODE
  IF GetFileSystemTimeDate (iFile, bType, gTempSystemTime)
    RETURN DEFORMAT( gTempSystemTime.wMonth & '/' & gTempSystemTime.wDay & '/' & gTempSystemTime.wYear, @d2 )
  END

  RETURN 0

!-----------------------------------------------------------------------------!
!CreateDirectory
! Create a directory
!-----------------------------------------------------------------------------!
CreateDirectory    PROCEDURE ( STRING sDirectory )

szDirName          CSTRING(FILE:MaxFilePath),AUTO

  CODE
  szDirName = CLIP( sDirectory )
  RETURN mkdir ( szDirName )

!-----------------------------------------------------------------------------!
!RemoveDirectory
! Remove a directory
!-----------------------------------------------------------------------------!
RemoveDirectory    PROCEDURE ( STRING sDirectory )

szDirName          CSTRING(FILE:MaxFilePath),AUTO

  CODE
  szDirName = CLIP( sDirectory )
  RETURN rmdir ( szDirName )

!-----------------------------------------------------------------------------!
!GetTempPath
! Retreive the path pointed to by TMP or TEMP
!-----------------------------------------------------------------------------!
GetTempPath        PROCEDURE()

sTmpPath           STRING(FILE:MaxFilePath),AUTO
lPathSize          LONG,AUTO

  CODE
  lPathSize = GetTempPath ( SIZE (sTmpPath), sTmpPath )
  IF lPathSize = 0 OR lPathSize > SIZE (sTmpPath)
    RETURN ''
  ELSE
    RETURN sTmpPath [ 1 : lPathSize ]
  END

!-----------------------------------------------------------------------------!
!GetTempPath
! Retreive the path pointed to by TMP or TEMP
!-----------------------------------------------------------------------------!
GetTempFileName    PROCEDURE ( STRING sPrefix, <STRING sDirectory> )

szPrefix           CSTRING( 4 ),AUTO
szPath             CSTRING(FILE:MaxFilePath),AUTO
szTempname         CSTRING(FILE:MaxFilePath),AUTO

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

!-----------------------------------------------------------------------------!
!FullDrag
! Query or change full window dragging setting
!-----------------------------------------------------------------------------!
FullDrag           PROCEDURE( <LONG lDragSetting> )

lCurrentSetting    LONG

  CODE
  IF ~OMITTED( 1 )
    SystemParametersInfo(SPI_SETDRAGFULLWINDOWS, lDragSetting, lCurrentSetting, SPIF_SENDWININICHANGE+SPIF_UPDATEINIFILE)
    RETURN lDragSetting
  END
  SystemParametersInfo(SPI_GETDRAGFULLWINDOWS, 0, lCurrentSetting, SPIF_SENDWININICHANGE+SPIF_UPDATEINIFILE)
  RETURN lCurrentSetting

!-----------------------------------------------------------------------------!
!LongToHex
!ShortToHex
!ByteToHex
! Convert numeric values to hexadecimal string
!-----------------------------------------------------------------------------!

LongToHex PROCEDURE(ULONG in, BYTE LowerCase)
Out STRING(8),AUTO
Inb BYTE,DIM(4),OVER(in)
  CODE
  Out[1 : 2] = ByteToHex(Inb[4], LowerCase)
  Out[3 : 4] = ByteToHex(Inb[3], LowerCase)
  Out[5 : 6] = ByteToHex(Inb[2], LowerCase)
  Out[7 : 8] = ByteToHex(Inb[1], LowerCase)
  RETURN Out

ShortToHex PROCEDURE(USHORT in, BYTE LowerCase)
Out STRING(4),AUTO
Inb BYTE,DIM(2),OVER(in)
  CODE
  Out[1 : 2] = ByteToHex(Inb[2], LowerCase)
  Out[3 : 4] = ByteToHex(Inb[1], LowerCase)
  RETURN Out

ByteToHex PROCEDURE(BYTE in, BYTE LowerCase)
Out       STRING(2),AUTO
HEX       &STRING,AUTO
  CODE
  IF LowerCase
    HEX &= HexDigitsLow
  ELSE
    HEX &= HexDigitsUp
  END
  Out[1] = HEX [BSHIFT(in, -4) + 1]
  Out[2] = HEX [BAND(in, 0FH) + 1]
  RETURN Out

!-----------------------------------------------------------------------------!
!BLOBTOFILE
! Copy data from the BLOB field to file
!-----------------------------------------------------------------------------!

  OMIT ('=== DO LINK', lib_mode)
    PRAGMA('link(C%V%DOS%X%%L%.LIB)')
! === DO LINK

BLOBTOFILE  PROCEDURE (*BLOB b, STRING name)
OutFile FILE,DRIVER('DOS'),CREATE
          RECORD
buffer      STRING(32768)
          END
        END
sz      LONG,AUTO
start   LONG,AUTO
amount  LONG,AUTO
CurErr  SIGNED,AUTO
  CODE
  IF name = ''
    RETURN BadFileErr
  END
  sz = b{PROP:Size}
  IF sz = 0
    RETURN 0
  END
  OutFile{PROP:Name} = name
  CREATE (OutFile)
  IF ERRORCODE() THEN RETURN ERRORCODE().
  OPEN (OutFile)
  IF ERRORCODE() THEN RETURN ERRORCODE().
  SEND (OutFile, 'FILEBUFFERS=' & ROUND(sz/512, 1))

  CurErr = 0
  start  = 0
  LOOP WHILE sz <> 0
    amount = SIZE (OutFile.buffer)
    IF amount > sz
      amount = sz
    END
    OutFile.buffer [1 : amount] = b [start : start + amount - 1]
    ADD (OutFile, amount)
    CurErr = ERRORCODE()
    IF CurErr <> 0
      BREAK
    END
    start += amount
    sz    -= amount
  END

  CLOSE (OutFile)
  RETURN CurErr

!-----------------------------------------------------------------------------!
!FILETOBLOB
! Copy data from file to the BLOB field
!-----------------------------------------------------------------------------!

FILETOBLOB  PROCEDURE (STRING name, *BLOB b)
InFile  FILE,DRIVER('DOS')
          RECORD
buffer      STRING(32768)
          END
        END
sz      LONG,AUTO
start   LONG,AUTO
fetch   LONG,AUTO
CurErr  SIGNED,AUTO
  CODE
  IF name = ''
    RETURN BadFileErr
  END
  InFile{PROP:Name} = name
  OPEN (InFile)
  IF ERRORCODE() THEN RETURN ERRORCODE().
  sz = BYTES(InFile)
  IF sz = 0
    CurErr = BadFileErr
  ELSE
    SEND (InFile, 'FILEBUFFERS=' & ROUND(sz/512, 1))
    b{PROP:Size} = sz
    
    CurErr = 0
    start  = 0
    LOOP WHILE sz <> 0
      fetch = SIZE (InFile.buffer)
      IF fetch > sz
        fetch = sz
      END
      GET (InFile, start + 1, fetch)
      CurErr = ERRORCODE()
      IF CurErr <> 0
        BREAK
      END
      b [start : start + fetch - 1] = InFile.buffer [1 : fetch]
      start += fetch
      sz    -= fetch
    END
  END

  CLOSE (InFile)
  RETURN CurErr

!-----------------------------------------------------------------------------!
!ResizeImage
! Resize the image to fit the original control size
! pImagePosition set the position where the image will go
! The posible values are:
! 123
! 456
! 789
! 5 mean centered in the image control
!-----------------------------------------------------------------------------!
ResizeImage       PROCEDURE  (SHORT pOriginalControl,SHORT pOrigianlXPos,SHORT pOriginalYPos,SHORT pOriginalWidth,SHORT pOriginalHeight,<REPORT pReport>)
lLocalImage SHORT
new_w       SHORT
new_h       SHORT
old_w       SHORT
old_h       SHORT
old_x       SHORT
old_y       SHORT
  CODE
    IF pOriginalControl
       IF NOT OMITTED(6)
          SETTARGET(pReport)
       END
       lLocalImage=CREATE(0, CREATE:image, pOriginalControl{prop:parent})
       lLocalImage{Prop:ImageBlob}=pOriginalControl{Prop:ImageBlob}
       new_w=lLocalImage{prop:width}
       new_h=lLocalImage{prop:height}
       old_x=pOrigianlXPos
       old_y=pOriginalYPos
       old_w=pOriginalWidth
       old_h=pOriginalHeight
       DESTROY(lLocalImage)
       IF ((new_w>old_w) OR (new_h>old_h))
         LOOP WHILE ((new_w>old_w) OR (new_h>old_h))
           new_w=new_w-(new_w/10)
           new_h=new_h-(new_h/10)
         END
       ELSIF ((old_w>new_w) OR (old_h>new_h))
         LOOP WHILE ((old_w>(new_w+(new_w/10))) AND (old_h>(new_h+(new_h/10))))
           new_w=new_w+(new_w/10)
           new_h=new_h+(new_h/10)
         END
       END
       pOriginalControl{prop:xpos}=old_x+(old_w-new_w)/2
       pOriginalControl{prop:ypos}=old_y+(old_h-new_h)/2
       pOriginalControl{prop:width}=new_w
       pOriginalControl{prop:height}=new_h
       IF NOT OMITTED(6)
          SETTARGET()
       END
    END
