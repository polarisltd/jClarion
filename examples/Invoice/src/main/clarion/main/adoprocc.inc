!ABCIncludeFile(SV)

OMIT('_EndOfInclude_',_ADOProcCPresente_)
_ADOProcCPresente_ EQUATE(1)

ADOMaxStatementSize            EQUATE(10000)

! PT: Added a queue that will hold Colname that are of Date or Time type
! This is in order to have the statement generated with the string representation of the data rather the numeric value
! Ex: WHERE MyDate = '1/27/1993' instead of WHERE MyDate = 71566
TDateTimeQ        queue, type
ColName             string(50)
DateTimeID          string(1)
                  end

! PT: Added a queue that will apply the real col name (instead of using the name of the local group) when generating the WHERE clause

TColNameQ         queue, type
LocGrpName          string(50)
ColName             string(50)
                  end

ADOProcCommCaller CLASS,MODULE('ADOProcC.CLW'),TYPE,LINK('ADOProcC.CLW',_svLinkMode_),DLL(_svDllMode_)
UsePrefix                           byte, protected
FieldsGroup                         &GROUP,PROTECTED
RecordSet                           &CRecordset,PROTECTED
Child                               &ADOProcCommCalled
ChildPresent                        BYTE,PROTECTED
RequestAction                       BYTE,PROTECTED
Response                            BYTE,PROTECTED
DateTimeQ                           &TDateTimeQ
ColNameQ                            &TColNameQ

SetChild                            PROCEDURE(*ADOProcCommCalled pChild)
SetNoChild                          PROCEDURE(),PROTECTED
SetRequest                          PROCEDURE(BYTE pRequestAction)
GetRequest                          PROCEDURE(),BYTE !InsertRecord DeleteRecord ChangeRecord ViewRecord
GetResponse                         PROCEDURE(),BYTE !RequestCompleted RequestCanceled
SetFields                           PROCEDURE(*GROUP pFieldsGroup)
SetRecordset                        PROCEDURE(*CRecordset pRecordset)
Init                                PROCEDURE(*GROUP pFieldsGroup,*CRecordset pRecordset)
Kill                                PROCEDURE()
UpdateFields                        PROCEDURE(FILE pFile,KEY parKey)
GetFieldsStatement                  PROCEDURE(),STRING
GetFieldsStatement                  PROCEDURE(FILE pFile,KEY parKey),STRING
GetFieldsStatement                  PROCEDURE(STRING p1,<STRING p2>,<STRING p3>,<STRING p4>,<STRING p5>,<STRING p6>,<STRING p7>,<STRING p8>,<STRING p9>,<STRING p10>,<STRING p11>,<STRING p12>,<STRING p13>,<STRING p14>,<STRING p15>),STRING
GetStatement                        PROCEDURE(*GROUP pFieldsGroup),STRING
GetStatementAndKey                  PROCEDURE(*GROUP pFieldsGroup),STRING
RemovePrefix                        procedure(string pStr), string
                               END
                               
ADOProcCommCalled CLASS,MODULE('ADOProcC.CLW'),TYPE,LINK('ADOProcC.CLW',_svLinkMode_),DLL(_svDllMode_)
Caller                              &ADOProcCommCaller,PROTECTED
ParentPresent                       BYTE,PROTECTED
DateTimeQ                           &TDateTimeQ
Init                                PROCEDURE()
Kill                                PROCEDURE()
SetNoParent                         PROCEDURE(),PROTECTED
SetResponse                         PROCEDURE(BYTE pResponse)! RequestCompleted RequestCanceled
GetRequest                          PROCEDURE(),BYTE
GetFieldsStatement                  PROCEDURE(),STRING
GetFieldsStatement                  PROCEDURE(FILE pFile,KEY parKey),STRING
GetFieldsStatement                  PROCEDURE(STRING p1,<STRING p2>,<STRING p3>,<STRING p4>,<STRING p5>,<STRING p6>,<STRING p7>,<STRING p8>,<STRING p9>,<STRING p10>,<STRING p11>,<STRING p12>,<STRING p13>,<STRING p14>,<STRING p15>),STRING
GetFields                           PROCEDURE(*GROUP pFieldsGroup)
GetRecordset                        PROCEDURE(),*CRecordset
GetStatement                        PROCEDURE(*GROUP pFieldsGroup),STRING
GetStatementAndKey                  PROCEDURE(*GROUP pFieldsGroup),STRING
                               END

TempADOProcCommObject    &ADOProcCommCaller,THREAD


 _EndOfInclude_
