!ABCIncludeFile


  OMIT('_EndOfInclude_',_FileClassPresent_)  ! Omit this if already compiled
_FileClassPresent_         EQUATE(1)

  INCLUDE('FILECB.INC'),ONCE

  ITEMIZE(1)
InsertRecord            EQUATE                 !  Add a record to table
ChangeRecord            EQUATE                 !  Change the current record
DeleteRecord            EQUATE                 !  Delete the current record
SelectRecord            EQUATE                 !  Select the current record
ProcessRecord           EQUATE                 !  Process the current record
ViewRecord              EQUATE                 !  View the current record
  END

AS:AddrFileManager      EQUATE(1000)           ! Address of file manager (TIED to ASTRING)

! File Access Modes

ReadOnly                EQUATE (0H)
WriteOnly               EQUATE (1H)
ReadWrite               EQUATE (2H)

AnyAccess               EQUATE (0H)
DenyAll                 EQUATE (10H)
DenyWrite               EQUATE (20H)
DenyRead                EQUATE (30H)
DenyNone                EQUATE (40H)


  MAP
    MODULE('ABFILE.CLW')
GetFieldValue   PROCEDURE(ASTRING FileManagerTag, ASTRING FldTag),STRING    ! get field value, formatted if numeric and picture available
GetFileField    PROCEDURE(ASTRING FileManagerTag, ASTRING FldTag),*?        ! gets 'pointer to field'
GetFileManager  PROCEDURE(ASTRING Tag),*FileManager
SetFileManager  PROCEDURE(FileManager FM, ASTRING Tag)
    END
  END

!---------------------------------------------------------
! The FileManager class

BufferQueue                   QUEUE,TYPE         ! QUEUE of 'saved' record buffers
Id                              LONG             ! Handle to recognise saved instance
Buffer                          &STRING          ! Reference to the record buffer
                              END

UseType ITEMIZE(1),PRE
Corrupts EQUATE                                  ! Changes but doesn't rely on value
Uses     EQUATE                                  ! Changes and relies on value
Returns  EQUATE                                  ! Holds a value to be returned to parent
Benign   EQUATE                                  ! Outside of tracking mechanism
  END


FileManager                   CLASS,IMPLEMENTS(FileCallBackInterface),TYPE,MODULE('ABFILE.CLW'),LINK('ABFILE.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
AliasedFile                     &FileManager               ! If this manager is handling a File Alias this should point to underlying FileManager
Buffer                          &GROUP,PROTECTED           ! The record buffer
Buffers                         &BufferQueue,PROTECTED     ! QUEUE of all 'saved' buffers for this file
Create                          BYTE                       ! Create/NoCreate flag
Errors                          &ErrorClass,PROTECTED      ! The Error object for this file
Fields                          &FieldsList,PRIVATE       ! List of fields/field tags for this file
FieldTypes                      &FieldTypesList,PRIVATE    ! List of 'known' field types with DataType Id's
File                            &File                      ! Reference to the object FILE
FileName                        ANY,PROTECTED              ! String in NAME attribute
FileNameValue                   STRING(FILE:MaxFileName),PROTECTED       ! The NAME attribute of the fil
HasAutoInc                      BYTE,PRIVATE               ! Auto-increment or not flag
InUseFile                       BYTE,PRIVATE               ! Stops asserts when setting up to use the file
InCallBack                      BYTE,PRIVATE               ! Stops infinite loop in callback code
InClose                         BYTE,PRIVATE               ! Flags that FileManager.close is being executed
InRestore                       BYTE,PRIVATE               ! Used by File Callback code
Info                            &FileThreadQueue,PRIVATE   ! QUEUE of status of all buffers for this file
Keys                            &FileKeyQueue,PRIVATE      ! QUEUE of all keys for this file
LazyOpen                        BYTE                       ! Set True to enable Lazy opening for this file
LockRecover                     SHORT                      ! Wait time parameter for LOCKing this FILE
OpenMode                        BYTE                       ! File sharing flag
PrimaryKey                      BYTE,PRIVATE               ! Primary key or not flag
Saved                           &SaveQueue,PRIVATE
SkipHeldRecords                 BYTE                       ! Should a Locked record abort reading or 'skip'
CleanedUp                       BYTE,PRIVATE

Destruct                        PROCEDURE,VIRTUAL
AddField                        PROCEDURE(ASTRING Tag, *? Field, ASTRING FieldType, <ASTRING FieldPicture>),BYTE,PROC
AddKey                          PROCEDURE(KEY K,STRING Description,BYTE AutoInc = 0)
BindFields                      PROCEDURE,VIRTUAL
CancelAutoInc                   PROCEDURE(<RelationManager RM>),VIRTUAL,BYTE,PROC
ClearKey                        PROCEDURE(KEY K,BYTE LowComp=1,BYTE HighComp=22,BYTE High=0)
Close                           PROCEDURE,BYTE,PROC,VIRTUAL
EqualBuffer                     PROCEDURE(*USHORT Handle),BYTE,VIRTUAL
Fetch                           PROCEDURE(KEY K),BYTE,PROC,VIRTUAL
FindField                       PROCEDURE(ASTRING Tag),BYTE,PRIVATE
GetComponents                   PROCEDURE(KEY K),BYTE
GetEOF                          PROCEDURE,BYTE
GetError                        PROCEDURE,SIGNED
GetField                        PROCEDURE(ASTRING Tag),*?
GetField                        PROCEDURE(KEY K,BYTE Component),*?
GetField                        PROCEDURE(LONG Idx, *ASTRING Tag, *? Field),BYTE
GetFieldType                    PROCEDURE(ASTRING Tag),ASTRING
GetFields                       PROCEDURE(),LONG
GetFieldName                    PROCEDURE(KEY K,BYTE Component),STRING
GetFieldName                    PROCEDURE(*? Fld),ASTRING
GetFieldPicture                 PROCEDURE(ASTRING Tag),ASTRING
GetName                         PROCEDURE,STRING
Init                            PROCEDURE(File File,ErrorClass EC),VIRTUAL
Insert                          PROCEDURE,BYTE,PROC,VIRTUAL
InsertServer                    PROCEDURE(BYTE HandleError),BYTE,PRIVATE
KeyToOrder                      PROCEDURE(KEY K,BYTE MajorComp),STRING
Kill                            PROCEDURE,VIRTUAL
Next                            PROCEDURE,BYTE,PROC,VIRTUAL
NextServer                      PROCEDURE(BYTE HandleError,BYTE Previous=0),BYTE,PRIVATE
Open                            PROCEDURE(),BYTE,PROC,VIRTUAL
OpenFile                        PROCEDURE(BYTE HandleError),BYTE,PRIVATE
OpenServer                      PROCEDURE(BYTE HandleError,BYTE ForceOpen=False),BYTE,PROC,PRIVATE
Position                        PROCEDURE(),STRING
Previous                        PROCEDURE,BYTE,PROC,VIRTUAL
PrimeAutoInc                    PROCEDURE,BYTE,PROC,VIRTUAL
PrimeAutoIncServer              PROCEDURE(BYTE HandleErrors),BYTE,PROC,PRIVATE
PrimeFields                     PROCEDURE,PROC,VIRTUAL
PrimeRecord                     PROCEDURE(BYTE SuppressClear = 0),BYTE,PROC,VIRTUAL
RestoreBuffer                   PROCEDURE(*USHORT Handle,BYTE DoRestore=1)
RestoreBuffer                   PROCEDURE(*USHORT Handle,FileManager FM,BYTE DoRestore = 1),PRIVATE
RestoreFile                     PROCEDURE(*USHORT Handle,BYTE DoRestore=1)
RestoreFile                     PROCEDURE(*USHORT Handle,FileManager FM,BYTE DoRestore = 1),PRIVATE
SaveBuffer                      PROCEDURE,USHORT
SaveFile                        PROCEDURE,USHORT
SetError                        PROCEDURE(USHORT Number)
SetKey                          PROCEDURE(KEY K),PROTECTED
SetName                         PROCEDURE(STRING Text)
SetThread                       PROCEDURE,PRIVATE
Throw                           PROCEDURE(USHORT ErrorNumber),BYTE,PROC,VIRTUAL
Throw                           PROCEDURE,BYTE,PROC,VIRTUAL
ThrowMessage                    PROCEDURE(USHORT ErrorNumber,STRING Text),BYTE,PROC,VIRTUAL
TryFetch                        PROCEDURE(KEY K),BYTE,PROC,VIRTUAL
TryInsert                       PROCEDURE,BYTE,PROC,VIRTUAL
TryNext                         PROCEDURE,BYTE,PROC,VIRTUAL
TryOpen                         PROCEDURE(),BYTE,PROC,VIRTUAL
TryPrevious                     PROCEDURE,BYTE,PROC,VIRTUAL
TryPrimeAutoInc                 PROCEDURE,BYTE,PROC,VIRTUAL
TryReget                        PROCEDURE(STRING Position),BYTE,PROC
TryUpdate                       PROCEDURE,BYTE,PROC,VIRTUAL
Update                          PROCEDURE,BYTE,PROC,VIRTUAL
UpdateServer                    PROCEDURE(BYTE HandleError),BYTE,PROC,PRIVATE
UseFile                         PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC
ValidateField                   PROCEDURE(UNSIGNED Id),BYTE,PROC,VIRTUAL
TryValidateField                PROCEDURE(UNSIGNED Id),BYTE,PROC,VIRTUAL
ValidateFieldServer             PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,VIRTUAL,PROTECTED
ValidateFields                  PROCEDURE(UNSIGNED Low,UNSIGNED High,<*UNSIGNED Failed>),BYTE,PROTECTED,PROC,VIRTUAL
ValidateRecord                  PROCEDURE(<*UNSIGNED Failed>),BYTE,VIRTUAL
DeleteRecord                    PROCEDURE(BYTE Query=1),BYTE,PROC,VIRTUAL
Deleted                         PROCEDURE,BYTE,VIRTUAL
                              END



!------------------------------------------------------------------
! The RelationManager class.
! The RelationManager class behaves as a file manager -except- it
! broadcasts commands on to child classes where useful.
! This layer contains Referential Integrity (RI) code.


! Defines how actions percolate through a relation tree.
  ITEMIZE(0),PRE(Propagate)
None                EQUATE          ! Only act on primary
OneMany             EQUATE          ! Only percolate down 1-Many relations
ManyOne             EQUATE          ! Only percolate down Many-1 relations
All                 EQUATE          ! Percolate down all relations
  END


  ITEMIZE(0),PRE(RI)
None                       EQUATE
Clear                      EQUATE
Restrict                   EQUATE
Cascade                    EQUATE
Clear_Server               EQUATE
Restrict_Server            EQUATE
Cascade_Server             EQUATE
  END

RelationManager               CLASS,TYPE,MODULE('ABFILE.CLW'),LINK('ABFILE.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Me                              &FileManager               ! The FileManager object for this file???
Relations                       &RelationQueue,PRIVATE     ! QUEUE of all related files
AliasFile                       &RelationManager,PRIVATE   ! The RelationManager object for Alias file???
UseLogout                       BYTE                       ! Logout or not flag
LastTouched                     LONG,PRIVATE               ! Time file was last touched
AddRelation                     PROCEDURE(RelationManager RM),PROTECTED
AddRelation                     PROCEDURE(RelationManager RM,BYTE UpdateMode,BYTE DeleteMode,KEY His),PROTECTED
AddRelationLink                 PROCEDURE(*? Left,*? Right),PROTECTED
AddRelationLink                 PROCEDURE(*long Left,*long Right),PROTECTED
AddRelationLink                 PROCEDURE(*string Left,*string Right),PROTECTED
CancelAutoInc                   PROCEDURE(),BYTE,PROC,VIRTUAL
CascadeUpdates                  PROCEDURE,BYTE,PRIVATE
Close                           PROCEDURE(BYTE Cascading=0),BYTE,PROC,VIRTUAL
Delete                          PROCEDURE(BYTE Query=1),BYTE,VIRTUAL,PROC
DeleteSecondary                 PROCEDURE(KEY MyKey,BufferedPairsClass Links,BYTE Mode),BYTE,PRIVATE,VIRTUAL
Init                            PROCEDURE(FileManager FM,BYTE UseLogout=0)   !,EXTENDS
Kill                            PROCEDURE,VIRTUAL
ListLinkingFields               PROCEDURE(RelationManager Him,FieldPairsClass Trgt,BYTE RightFirst = 0)
LogoutDelete                    PROCEDURE,BYTE,PRIVATE
LogoutPrime                     PROCEDURE,BYTE,PRIVATE
LogoutUpdate                    PROCEDURE,BYTE,PRIVATE
OpenCloseServer                 PROCEDURE(BYTE Cascading=0,BYTE Opening),BYTE,PROC,PRIVATE
Open                            PROCEDURE(BYTE Cascading=0),BYTE,PROC,VIRTUAL
Save                            PROCEDURE,VIRTUAL
SetAlias                        PROCEDURE(RelationManager RM)
SetQuickScan                    PROCEDURE(BYTE On,BYTE Propagate=Propagate:None),VIRTUAL
Update                          PROCEDURE(BYTE FromForm=0),BYTE,VIRTUAL,PROC
UpdateSecondary                 PROCEDURE(KEY MyKey,BufferedPairsClass Links,BYTE Mode),BYTE,PRIVATE,VIRTUAL

GetNbRelations                  PROCEDURE, LONG                           ! returns the number of relations defined for the primary file
GetNbFiles                      PROCEDURE(RelationManager parent), LONG     ! returns the number of children files in this relation
GetRelation                     PROCEDURE(LONG relPos), *RelationManager    ! returns the relation number relPos in the list of relations
GetRelation                     PROCEDURE(FILE f), *RelationManager         ! returns the relation manager for the file f
GetRelationType                 PROCEDURE(LONG relPos), LONG                ! returns the type of the relation i (-1 = pb, 1 : 1:many relation, 0 : other relation)

                              END



!---------------------------------------------------------
! The ViewManager class

  ITEMIZE(0),PRE(Record)
OK                     EQUATE          ! Record passes range and filter
OutOfRange             EQUATE          ! Record fails range test
Filtered               EQUATE          ! Record fails filter tests
  END

  ITEMIZE(0),PRE(Limit)
None                    EQUATE          ! no range limit
Current                 EQUATE          ! range limited to current value
Single                  EQUATE          ! range limited to single value
Pair                    EQUATE          ! range falls between a pair of values
File                    EQUATE          ! range limited to current value of parent file's linking field
  END

FilterQueue QUEUE,TYPE
ID                  STRING(30)                   ! By convention first char is digit 0-9 for priority
Filter              &STRING
  END

SortOrder                     QUEUE,TYPE         ! QUEUE of sort info for this file
Filter                          &FilterQueue     ! A conjunctive list of filter expressions
FreeElement                     ANY              ! The Free key element
LimitType                       BYTE             ! Range limit flag/indicator
MainKey                         &KEY             ! The KEY
Order                           &STRING          ! ORDER clause for sort order
RangeList                       &BufferedPairsClass ! List of fields in range limit
                              END

ViewManager                   CLASS,TYPE,MODULE('ABFILE.CLW'),DLL(_ABCDllMode_)
DisposeOrder                    BYTE,PRIVATE
Opened                          BYTE,PRIVATE               ! Opened or not flag
Order                           &SortOrder,PROTECTED       ! QUEUE of sort/range/filter info
PagesAhead                      USHORT
PagesBehind                     USHORT
PageSize                        USHORT
Primary                         &RelationManager           ! The RelationManager object for this VIEW
TimeOut                         USHORT
View                            &VIEW                      ! The object VIEW

AddRange                        PROCEDURE(*? Field)
AddRange                        PROCEDURE(*? Field,*? Limit)
AddRange                        PROCEDURE(*? Field,*? Low,*? High)
AddRange                        PROCEDURE(*? Field,RelationManager MyFile,RelationManager RelatedFile)
AddSortOrder                    PROCEDURE(<KEY K>),BYTE,PROC
AppendOrder                     PROCEDURE(STRING Order),VIRTUAL
ApplyFilter                     PROCEDURE,VIRTUAL
ApplyOrder                      PROCEDURE,VIRTUAL
ApplyRange                      PROCEDURE,VIRTUAL,BYTE,PROC
Close                           PROCEDURE,VIRTUAL
GetFreeElementName              PROCEDURE,STRING,VIRTUAL
GetFreeElementPosition          PROCEDURE,BYTE,PROTECTED,VIRTUAL
Init                            PROCEDURE(VIEW V,RelationManager RM,<SortOrder SO>)   !,EXTENDS
Kill                            PROCEDURE,VIRTUAL
LimitMajorComponents            PROCEDURE(*? Field),PRIVATE
Next                            PROCEDURE,VIRTUAL,BYTE
Open                            PROCEDURE,VIRTUAL
Previous                        PROCEDURE,VIRTUAL,BYTE
PrimeRecord                     PROCEDURE(BYTE SuppressClear = 0),BYTE,PROC,VIRTUAL
Reset                           PROCEDURE(BYTE Locate),VIRTUAL
Reset                           PROCEDURE,VIRTUAL
SetFilter                       PROCEDURE(STRING Filter),VIRTUAL
SetFilter                       PROCEDURE(STRING Filter,STRING Id),VIRTUAL
SetFreeElement                  PROCEDURE,PRIVATE
SetOrder                        PROCEDURE(STRING Order),VIRTUAL
SetSort                         PROCEDURE(BYTE OrderNumber),BYTE,VIRTUAL,PROC
UseView                         PROCEDURE,PROTECTED
ValidateRecord                  PROCEDURE,BYTE,VIRTUAL
                              END

!---------------------------------------------------------
! DBTriggers

IDbChangeAudit INTERFACE
ChangeField       PROCEDURE(*? Left, *? Right, STRING Name, STRING FileName)
OnChange          PROCEDURE(STRING FileName, FILE File)
BeforeChange      PROCEDURE(STRING FileName, BufferedPairsClass BFP)
               END

DbLogFileManager CLASS(FileManager),TYPE,MODULE('ABFILE.CLW'),LINK('ABFILE.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Opened            BYTE
Init              PROCEDURE(ErrorClass EC, STRING LogFileName)   !,EXTENDS
                 END

DbTriggerQueue QUEUE,TYPE
ID                USHORT
FileName          ASTRING
BFP               &BufferedPairsClass
               END

DbNameQueue    QUEUE,TYPE
FileName          ASTRING
FieldName         ASTRING
Ptr               USHORT
               END

DbColumnQueue    QUEUE,TYPE
FileName          ASTRING
FieldName         ASTRING
FieldHeader       ASTRING
FieldPicture      ASTRING
Length            USHORT
Field             ANY
                 END

LogFileQueue     QUEUE,TYPE
FileName          ASTRING
LogFileName       ASTRING
                 END

DbChangeManager  CLASS,TYPE,MODULE('ABFILE.CLW'),LINK('ABFILE.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
TriggerQueue      &DbTriggerQueue,PROTECTED
NameQueue         &DbNameQueue,PROTECTED
DbChangeAudit     &IDbChangeAudit,PRIVATE
AddItem            PROCEDURE(*? Left, STRING Name, STRING FileName)
AddThread          PROCEDURE(STRING FileName)
CheckChanges       PROCEDURE(STRING FileName, FILE File)
CheckPair          PROCEDURE(FieldPairsClass FP)
Equal              PROCEDURE(STRING FileName),BYTE
Init               PROCEDURE(*IDbChangeAudit IDbC)   !,EXTENDS
Kill               PROCEDURE()
Update             PROCEDURE(STRING FileName)
SetThread          PROCEDURE(STRING FileName),BYTE
                 END

DbAuditManager  CLASS,IMPLEMENTS(IDbChangeAudit),TYPE,MODULE('ABFILE.CLW'),LINK('ABFILE.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Action          STRING(20)
ColumnInfo      &DbColumnQueue,PROTECTED
LogFiles        &LogFileQueue,PROTECTED
LFM             &DbLogFileManager,PROTECTED
Errors          &ErrorClass,PROTECTED
AddItem            PROCEDURE(STRING FileName, STRING FieldName, *? Field, STRING FieldHeader, STRING FieldPicture)
AddLogFile         PROCEDURE(STRING FileName, STRING LogFileName)
AppendLog          PROCEDURE(STRING FileName)
BeforeChange       PROCEDURE(STRING FileName, BufferedPairsClass BFP),VIRTUAL
CreateHeader       PROCEDURE(STRING FileName, DbLogFileManager LFM),VIRTUAL
Init               PROCEDURE(ErrorClass ErrorHandler),VIRTUAL
Kill               PROCEDURE(),VIRTUAL
SetFM              PROCEDURE(STRING FileName),BYTE,PROTECTED
OnChange           PROCEDURE(STRING FileName, FILE File),VIRTUAL
OnDelete           PROCEDURE(STRING FileName, FILE File),VIRTUAL
OnFieldChange      PROCEDURE(*? Left, *? Right, STRING FieldName, STRING FileName),VIRTUAL
OnInsert           PROCEDURE(STRING FileName, FILE File),VIRTUAL
OpenLogFile        PROCEDURE(STRING FileName),PROTECTED
                 END


_EndOfInclude_


