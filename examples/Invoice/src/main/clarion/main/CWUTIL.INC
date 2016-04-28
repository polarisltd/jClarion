  MODULE('cwutil.clw')
    OSVersion( ),STRING
    FileExists( STRING sFile ), BYTE
    WindowExists( STRING sWindow ), BYTE
    ValidateOLE( SIGNED OleControl, <STRING OleFileName>, <STRING OleCreateName> ), BYTE
    GetUserName( ),STRING
    BeginUnique( STRING sAppName ),LONG
    EndUnique( LONG hUnique )
    IsTermServer( ),BYTE
    GetFileTime( STRING iFile, BYTE bType=0 ),LONG
    GetFileDate( STRING iFile, BYTE bType=0 ),LONG
    CreateDirectory( STRING sDirectory ), BYTE,PROC
    RemoveDirectory( STRING sDirectory ), BYTE,PROC
    GetTempPath( ), STRING
    GetTempFileName( STRING sPrefix, <STRING sDirectory> ),STRING
    FullDrag( <LONG lDragSetting> ),LONG,PROC
    LongToHex(ULONG, BYTE LowerCase = FALSE),STRING
    ShortToHex(USHORT, BYTE LowerCase = FALSE),STRING
    ByteToHex(BYTE, BYTE LowerCase = FALSE),STRING
    FileToBLOB(STRING name, *BLOB b),SIGNED
    BLOBToFile(*BLOB b, STRING name),SIGNED
    ResizeImage(SHORT pOriginalControl,SHORT pOrigianlXPos,SHORT pOriginalYPos,SHORT pOriginalWidth,SHORT pOriginalHeight,<REPORT pReport>)
  END
  MODULE('Core')
    PathSplit(CONST *CSTRING path, <*CSTRING drive>, <*CSTRING dir>, <*CSTRING file>, <*CSTRING ext>), SIGNED, PROC, RAW, NAME('_fnsplit')
    PathMerge(*CSTRING path, <*CSTRING drive>, <*CSTRING dir>, <*CSTRING file>, <*CSTRING ext>), SIGNED, PROC, RAW, NAME('_fnmerge')
  END

COMPILE('Link', _ABCLinkMode_)
 PRAGMA('compile(CWUTIL.CLW)')
!Link
