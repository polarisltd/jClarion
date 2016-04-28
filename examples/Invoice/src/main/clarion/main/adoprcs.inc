!ABCIncludeFile(SV)

OMIT('_EndOfInclude_',_ADOProcessManagerClassPresente_)
_ADOProcessManagerClassPresente_ EQUATE(1)

 INCLUDE('QProcess.INC'),ONCE
 INCLUDE('svmapper.inc'),ONCE
 INCLUDE('cwado.inc'),ONCE
ADOProcessManagerClass    CLASS(QProcessManagerClass),MODULE('ADOPrcs.CLW'),TYPE,LINK('ADOPrcs.CLW',_svLinkMode_),DLL(_svDllMode_)
FirstRecordProc     byte
Mapper              &TableMapper
HR                  HRESULT
RecordSet           &CRecordSet
RSCreated           BYTE,PROTECTED
MPCreated           BYTE,PROTECTED
RSConnection        &CConnection
Query               CSTRING(6000)
Init                PROCEDURE(),VIRTUAL
Init                PROCEDURE(*CRecordSet pRecordSet),VIRTUAL
Init                PROCEDURE(*TableMapper pMapper),VIRTUAL
Init                PROCEDURE(*CRecordSet pRecordSet,*TableMapper pMapper),VIRTUAL
Next                PROCEDURE(),VIRTUAL,BYTE
GetRecordsToProcess PROCEDURE(),LONG,VIRTUAL
GetEOF              PROCEDURE(),BYTE,VIRTUAL
Open                PROCEDURE(*CConnection Conn, LONG CursorType, LONG LockType, LONG Options),PROC, HRESULT, VIRTUAL
SetQuery            PROCEDURE(STRING pQuery),VIRTUAL
AddFieldsInfo       PROCEDURE(STRING pTableName, STRING pColName, *? pTargetVar, SHORT pDateTimeID)
AddFieldsInfo       PROCEDURE(STRING pTableName, *GROUP pFileRecord)
Kill                PROCEDURE(),VIRTUAL
                END

 _EndOfInclude_
