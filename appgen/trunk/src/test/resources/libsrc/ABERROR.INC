
!ABCIncludeFile

OMIT('_EndOfInclude_',_ErrorClassPresent_)
ErrorBlock                    GROUP,TYPE         ! Parameter to AddErrors procedure
Number                          USHORT           ! Current error message identifier
                              END
     _EndOfInclude_

    omit('java-end',java)
C8ErrorBlock    equate(ErrorBlock)
    java-end
    compile('java-end',java)
C8ErrorBlock    equate(Group)
    java-end


OMIT('_EndOfInclude_',_ErrorClassPresent_)
_ErrorClassPresent_ EQUATE(1)

  INCLUDE('ABWINDOW.INC'),ONCE

BaseButtonFeq EQUATE(100)
ListFeq       EQUATE(200)
ImageFeq      EQUATE(300)

! Severity of error
Level:Benign                  EQUATE(0)
Level:User                    EQUATE(1)
Level:Program                 EQUATE(2)
Level:Fatal                   EQUATE(3)
Level:Cancel                  EQUATE(4)
Level:Notify                  EQUATE(5)

! Message numbers for predefined error messages in ABERROR.TRN
  ITEMIZE(0),PRE(Msg)
None                      EQUATE
AbortReading              EQUATE
AccessDenied              EQUATE
AddAnother                EQUATE
AddFailed                 EQUATE
AddNewRecord              EQUATE
ConcurrencyFailed         EQUATE
ConcurrencyFailedFromForm EQUATE
ConfirmCancel             EQUATE
ConfirmDelete             EQUATE
CreateFailed              EQUATE
DeleteFailed              EQUATE
DeleteIllegal             EQUATE
DuplicateKey              EQUATE
FieldNotInFile            EQUATE
FieldNotInList            EQUATE
FieldOutOfRange           EQUATE
FieldOutOfRangeHigh       EQUATE
FieldOutOfRangeLow        EQUATE
FileLoadFailed            EQUATE
InsertIllegal             EQUATE
LogoutFailed              EQUATE
NoRecords                 EQUATE
OpenFailed                EQUATE
ProcedureToDo             EQUATE
PutFailed                 EQUATE
RebuildFailed             EQUATE
RebuildKey                EQUATE
RecordHeld                EQUATE
RecordLimit               EQUATE
RestrictDelete            EQUATE
RestrictUpdate            EQUATE
RetryAutoInc              EQUATE
RetryDelete               EQUATE
RetrySave                 EQUATE
SaveRecord                EQUATE
SearchReachedBeginning    EQUATE
SearchReachedEnd          EQUATE
UpdateIllegal             EQUATE
UseClosedFile             EQUATE
ViewOpenFailed            EQUATE
QBEColumnNotSupported     EQUATE
SMTPError                 EQUATE
NNTPError                 EQUATE
WinsockError              EQUATE
  END

ErrorEntry                    QUEUE,TYPE         ! List of all translated error messages
Id                              USHORT           ! Error message identifier
Message                         &STRING          ! Message text
Title                           &STRING          ! Error window caption bar text
Fatality                        BYTE             ! Severity of error
Category                        ASTRING          ! Optional category for this error, if blank uses CurrentCategory
                              END


ErrorHistoryList              QUEUE,TYPE
Category                        ASTRING
Txt                             CSTRING(1024)   ! Fully expanded text of message (neeed because macros reflect 'current state')
Id                              SHORT
                              END


MessageMaxlen                 EQUATE(255)


ErrorLogInterface             INTERFACE                         !All method should return Level:Benign (everything ok) or Level:Notify (couldn't complete action)
Close                           PROCEDURE(BYTE Force = False),BYTE,PROC
Open                            PROCEDURE(BYTE Force = False),BYTE,PROC
Take                            PROCEDURE(STRING ErrText),BYTE,PROC
                              END


StandardErrorLogClass         CLASS,TYPE,IMPLEMENTS(ErrorLogInterface),MODULE('ABERROR.CLW'),LINK('ABERROR.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Usage                           LONG,PRIVATE

Construct                       PROCEDURE
Destruct                        PROCEDURE

Open                            PROCEDURE(BYTE Force = False),BYTE,PROC,PROTECTED
Close                           PROCEDURE(BYTE Force = False),BYTE,PROC,PROTECTED
                              END


ErrorClass                    CLASS,TYPE,MODULE('ABERROR.CLW'),LINK('ABERROR.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
DefaultCategory                 ASTRING,PROTECTED                  ! The default category associated with errors that don't have their own
Errors                          &ErrorEntry,PROTECTED              ! Queue to hold all translated error messages
ErrorLog                        &ErrorLogInterface,PROTECTED       ! Interface to error log
FieldName                       CSTRING(MessageMaxlen),PROTECTED   ! name of field that produced the error
FileName                        CSTRING(MessageMaxlen),PROTECTED   ! name of file that produced the error
History                         &ErrorHistoryList,PROTECTED
MessageText                     CSTRING(MessageMaxlen),PROTECTED   ! message text
ProcNames                       &PNQ,PRIVATE
SaveError                       CSTRING(255),PRIVATE               ! Clarion error message
SaveErrorCode                   LONG,PRIVATE                       ! Clarion error code
SaveFileError                   CSTRING(255),PRIVATE               ! File system's error message
SaveFileErrorCode               CSTRING(255),PRIVATE               ! File system's error code
Silent                          BYTE                               ! Set true to force silent error handling
StdErrorLog                     &StandardErrorLogClass,PRIVATE     ! The standard error log handler
LogErrors                       BYTE                               ! Set true to send errors to the error log
HistoryThreshold                LONG                               ! Set number of items to 'store' in history setting to -1 means keep all errors, setting to 0 switches off history
HistoryViewLevel                LONG                               ! Sets the error level which triggers history viewing, only valid with HistoryThreshold <> 0
HistoryResetOnView              BYTE                               ! Set true to auto clear history after viewing, only valid with HistoryThreshold <> 0

AddErrors                       PROCEDURE(C8ErrorBlock EB),VIRTUAL
AddHistory                      PROCEDURE,VIRTUAL
GetCategory                     PROCEDURE(SHORT Id = -1),ASTRING   ! Gets the category of a specific eror, or it -1 the default category
GetProcedureName                PROCEDURE,STRING
HistoryMsg                      PROCEDURE(STRING Caption, LONG Icon, LONG Buttons, LONG DefaultButton),LONG,PROC,VIRTUAL
Init                            PROCEDURE   !,EXTENDS
Init                            PROCEDURE(ErrorLogInterface ErrLog),VIRTUAL
Kill                            PROCEDURE
Message                         PROCEDURE(SHORT Id,LONG Buttons,LONG Default),LONG
Msg                             PROCEDURE(STRING Txt, <STRING Caption>, <STRING Icon>, LONG Buttons = Button:Ok, LONG DefaultButton = 0, LONG Style = 0),LONG,PROC,VIRTUAL,PROTECTED
MessageBox                      PROCEDURE(BYTE Level = Level:Benign, STRING Txt, <STRING Caption>, <STRING Icon>, LONG Buttons, LONG DefaultButton, LONG Style),LONG,VIRTUAL,PROTECTED
RemoveErrors                    PROCEDURE(C8ErrorBlock EB)
ResetHistory                    PROCEDURE                          ! Reset(empty) the current history state
SetCategory                     PROCEDURE(SHORT Id = -1, ASTRING Category)  ! If id = -1, sets default category, otherwise sets the category of a specific error
SetErrors                       PROCEDURE
SetFatality                     PROCEDURE(SHORT Id,BYTE Level)
SetField                        PROCEDURE(STRING Text)
SetFile                         PROCEDURE(STRING Text)
SetId                           PROCEDURE(USHORT Id),PROTECTED
SetProcedureName                PROCEDURE(<STRING Name>)           ! Omit when leaving scope
SubsString                      PROCEDURE,STRING,PROTECTED
TakeBenign                      PROCEDURE,BYTE,VIRTUAL,PROC,PROTECTED
TakeError                       PROCEDURE(SHORT Id),BYTE,PROC
TakeFatal                       PROCEDURE,BYTE,VIRTUAL,PROC,PROTECTED
TakeNotify                      PROCEDURE,VIRTUAL,PROTECTED
TakeOther                       PROCEDURE,BYTE,VIRTUAL,PROC,PROTECTED
TakeProgram                     PROCEDURE,BYTE,VIRTUAL,PROC,PROTECTED
TakeUser                        PROCEDURE,BYTE,VIRTUAL,PROC,PROTECTED
Throw                           PROCEDURE(SHORT Id),BYTE,PROC  !,EXTENDS
ThrowFile                       PROCEDURE(SHORT Id,STRING FileName),BYTE,PROC  !,EXTENDS
ThrowMessage                    PROCEDURE(SHORT Id,STRING Text),BYTE,PROC  !,EXTENDS
ViewHistory                     PROCEDURE,VIRTUAL                  ! View the current error history state
                              END

MsgBoxClass                   CLASS(WindowManager),TYPE,MODULE('ABERROR.CLW'),LINK('ABERROR.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
ButtonTypes                     LONG,PROTECTED
Caption                         &STRING,PROTECTED
Err                             &ErrorClass,PROTECTED
Icon                            LONG,PROTECTED
HistoryHandler                  &WindowComponent
MsgButtons                      LONG,PRIVATE
MsgButtonID                     LONG,DIM(8),PRIVATE
MsgRVal                         LONG
Style                           LONG,PROTECTED
Win                             &WINDOW,PROTECTED

FetchFeq                        PROCEDURE(BYTE Btn),SHORT
FetchStdButton                  PROCEDURE(SHORT Feq),BYTE
Init                            PROCEDURE(WINDOW Win, ErrorClass Err, <STRING Caption>, LONG Icon, LONG Buttons = Button:Ok, LONG DefaultButton = 0, LONG Style = 0)
Init                            PROCEDURE,BYTE,PROC,DERIVED
Kill                            PROCEDURE,BYTE,PROC,DERIVED
SetupAdditionalFeqs             PROCEDURE,VIRTUAL,PROTECTED
TakeAccepted                    PROCEDURE,BYTE,PROC,DERIVED
                              END


HistHandlerClass              CLASS,TYPE,IMPLEMENTS(WindowComponent),MODULE('ABERROR.CLW'),LINK('ABERROR.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Err                             &ErrorClass,PROTECTED
History                         &ErrorHistoryList
LBColumns                       SHORT,PROTECTED
Win                             &WINDOW,PROTECTED

_VLBProc                        PROCEDURE(LONG RowNum, SHORT ColNum),STRING,PRIVATE

Init                            PROCEDURE(WINDOW Win, ErrorClass Err, ErrorHistoryList History)
TakeEvent                       PROCEDURE,BYTE,VIRTUAL
VLBProc                         PROCEDURE(LONG RowNum, SHORT ColNum),STRING,VIRTUAL,PROTECTED
                              END


  _EndOfInclude_



