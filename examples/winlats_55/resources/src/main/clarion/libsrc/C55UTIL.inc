  MODULE('c55util.clw')
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
    CreateDirectory( STRING sDirectory ), BYTE
    RemoveDirectory( STRING sDirectory ), BYTE
    GetTempPath( ), STRING
    GetTempFileName( STRING sPrefix, <STRING sDirectory> ),STRING
    GetReg( LONG hKey, STRING sSubKeyPath, STRING sValue ), ?
    PutReg( LONG hKey, STRING sSubKeyPath, STRING sValueName, STRING sValue, LONG lType=1 ), BYTE
    FullDrag( <LONG lDragSetting> ),LONG,PROC
  END
