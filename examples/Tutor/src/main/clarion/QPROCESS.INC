!ABCIncludeFile(ABC)

OMIT('_EndOfInclude_',_QProcessManagerClassPresente_)
_QProcessManagerClassPresente_ EQUATE(1)

QProcessManagerClass    CLASS,MODULE('QProcess.CLW'),TYPE,LINK('QProcess.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
ControlPText        SIGNED,PROTECTED
ControlCancel       SIGNED,PROTECTED
ControlPause        SIGNED,PROTECTED
ControlProgress     SIGNED,PROTECTED
CompletedText       STRING(100)
RecordsProcessed    LONG
RecordsToProcess    LONG
RecordsPerCycle     LONG,PROTECTED
Low                 SHORT,PROTECTED
High                SHORT,PROTECTED
Timer               LONG,PROTECTED
CloseWindowAtEnd    BYTE,PROTECTED
ProgressCancelled   BYTE,PROTECTED
ProgressPaused      BYTE,PROTECTED
Init                PROCEDURE(),VIRTUAL
Open                PROCEDURE(),VIRTUAL
Close               PROCEDURE(),VIRTUAL
SetDefault          PROCEDURE,VIRTUAL
IsPaused            PROCEDURE(),BYTE,VIRTUAL
SetPause            PROCEDURE(),VIRTUAL
SetPause            PROCEDURE(BYTE pPause),VIRTUAL
SetTimer            PROCEDURE(SIGNED ptimer=10),VIRTUAL
SetControls         PROCEDURE(STRING pText,SIGNED ControlProgress=0,SIGNED ControlCancel = 0,SIGNED ControlText = 0,SIGNED ControlPause = 0),VIRTUAL
SetControlProgress  PROCEDURE(SIGNED pControl=0),VIRTUAL
SetControlCancel    PROCEDURE(SIGNED pControl=0),VIRTUAL
SetControlText      PROCEDURE(SIGNED pControl=0),VIRTUAL
SetControlPause     PROCEDURE(SIGNED pControl=0),VIRTUAL
SetCompletedText    PROCEDURE(STRING pText),VIRTUAL
SetCloseWindow      PROCEDURE(BYTE pClose)
Reset               PROCEDURE,VIRTUAL
Run                 PROCEDURE,VIRTUAL
Ask                 PROCEDURE,VIRTUAL
Kill                PROCEDURE,VIRTUAL
SetProgressLimits   PROCEDURE(LONG pTimer=0,LONG RecordsPerCycle=1)
TakeEvent           PROCEDURE,BYTE,VIRTUAL
TakeRecord          PROCEDURE,VIRTUAL
UpdateDisplay       PROCEDURE,PRIVATE
ValidateRecord      PROCEDURE,BYTE,VIRTUAL
GetPorcentile       PROCEDURE,BYTE,VIRTUAL
TakeNoRecords       PROCEDURE,VIRTUAL
TakeCancelled       PROCEDURE,VIRTUAL
TakePaused          PROCEDURE,VIRTUAL
TakeCompleted       PROCEDURE,VIRTUAL
!This 2 method must to be implemented by the derived class
Next                PROCEDURE(),VIRTUAL,BYTE
GetRecordsToProcess PROCEDURE(),LONG,VIRTUAL
!This can be implemented but not required
GetEOF              PROCEDURE(),BYTE,VIRTUAL
                END
!***************************************************************************
QueueProcessManagerClass    CLASS(QProcessManagerClass),MODULE('QProcess.CLW'),TYPE,LINK('QProcess.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Q               &Queue
Init                PROCEDURE(QUEUE pQ),VIRTUAL
Next                PROCEDURE(),VIRTUAL,BYTE
GetRecordsToProcess PROCEDURE(),LONG,VIRTUAL
                END

 _EndOfInclude_
