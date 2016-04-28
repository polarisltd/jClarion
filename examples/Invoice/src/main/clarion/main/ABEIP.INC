
!ABCIncludeFile

  OMIT('_EndOfInclude_',_EIPPresent_)
_EIPPresent_ EQUATE(1)

  INCLUDE('abwindow.inc'),ONCE

INVALID_COLOR EQUATE(0FF000000H)

EditAction ITEMIZE(0),PRE
None     EQUATE
Forward  EQUATE     ! Next field
Backward EQUATE
Complete EQUATE     ! OK
Cancel   EQUATE
Next     EQUATE     ! Next record
Previous EQUATE
Ignore   EQUATE
  END

MSAction   ITEMIZE(1),PRE
Add          EQUATE
Delete       EQUATE
EndProcess   EQUATE
Move         EQUATE
StartProcess EQUATE
           END

! ----------------------------------------------------------------
! The EditClasses are used to edit individual columns of a browse.
! Each edir class uses a different schemes to interact with the
! user. The current set includes, entry fields, text windows,
! check fields, drop lists, drop combo lists and color dialogs.
! ----------------------------------------------------------------

EditClass   CLASS,TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
Feq           UNSIGNED
UseVar        ANY
ListBoxFeq    SIGNED
ReadOnly      BYTE
FieldNo       UNSIGNED
Req           BYTE

CreateControl PROCEDURE,VIRTUAL,PROTECTED
Init          PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar),VIRTUAL
Kill          PROCEDURE,VIRTUAL
SetAlerts     PROCEDURE,VIRTUAL
SetReadOnly   PROCEDURE(BYTE State),VIRTUAL
TakeAccepted  PROCEDURE(BYTE Action),BYTE,VIRTUAL
TakeEvent     PROCEDURE(UNSIGNED Event),BYTE,VIRTUAL
            END

EditEntryClass CLASS(EditClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
CreateControl    PROCEDURE,VIRTUAL,PROTECTED
               END

TextWindowClass CLASS(WindowManager),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
Title             STRING(64), PRIVATE
EntryFEQ          SIGNED, PRIVATE
SelS              UNSIGNED, AUTO
SelE              UNSIGNED, AUTO
Txt               ANY, AUTO

Init              PROCEDURE,BYTE,DERIVED,PROC
Init              PROCEDURE(SIGNED EntryFEQ, STRING Title)
TakeAccepted      PROCEDURE,BYTE,PROC,DERIVED
Kill              PROCEDURE,PROC,BYTE,DERIVED
                END

EditTextClass  CLASS(EditClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
Title            CSTRING(256)

CreateControl    PROCEDURE,VIRTUAL,PROTECTED
TakeEvent        PROCEDURE(UNSIGNED Event),BYTE,VIRTUAL
               END


EditCheckClass CLASS(EditClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
Init             PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar),VIRTUAL
CreateControl    PROCEDURE,VIRTUAL,PROTECTED
               END


EditSpinClass  CLASS(EditClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
CreateControl    PROCEDURE,VIRTUAL,PROTECTED
               END


EditDropListClass CLASS(EditClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
CreateControl       PROCEDURE,VIRTUAL,PROTECTED
SetAlerts           PROCEDURE,VIRTUAL
SetReadOnly         PROCEDURE(BYTE State),DERIVED
TakeEvent           PROCEDURE(UNSIGNED Event),BYTE,VIRTUAL
                  END


EditDropComboClass CLASS(EditDropListClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
CreateControl       PROCEDURE,VIRTUAL,PROTECTED
                   END


EditColorClass CLASS(EditClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
Title            CSTRING(256)

CreateControl    PROCEDURE,VIRTUAL,PROTECTED
TakeEvent        PROCEDURE(UNSIGNED Event),BYTE,VIRTUAL
               END


EditFileClass CLASS(EditClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
Title            CSTRING(256)
FilePattern      CSTRING(1024)
FileMask         CSTRING(15)

CreateControl    PROCEDURE,VIRTUAL,PROTECTED
TakeEvent        PROCEDURE(UNSIGNED Event),BYTE,VIRTUAL
               END


EditFontClass CLASS(EditClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
Title            CSTRING(256)

CreateControl    PROCEDURE,VIRTUAL,PROTECTED
TakeEvent        PROCEDURE(UNSIGNED Event),BYTE,VIRTUAL
               END

EditCalendarClass CLASS(EditClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
Title              CSTRING(256)
Calendar           &CalendarBaseClass

SetCalendar        PROCEDURE(*CalendarBaseClass pCalendar)
CreateControl      PROCEDURE,VIRTUAL,PROTECTED
TakeEvent          PROCEDURE(UNSIGNED Event),BYTE,VIRTUAL
                  END
EditLookupClass CLASS(EditClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
CreateControl    PROCEDURE,VIRTUAL,PROTECTED
TakeEvent        PROCEDURE(UNSIGNED Event),BYTE,VIRTUAL
AskLookup        PROCEDURE(BYTE pForce),BYTE,VIRTUAL
               END

EditMultiSelectClass CLASS(EditClass),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
Available              &ItemQueue,PROTECTED
FilePattern            CSTRING(1024)
Selected               &ItemQueue,PROTECTED
Title                  CSTRING(256)

AddValue               PROCEDURE(STRING Value, BYTE Marked=0)
Reset                  PROCEDURE
CreateControl          PROCEDURE,DERIVED,PROTECTED
Init                   PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar),DERIVED
Kill                   PROCEDURE,DERIVED
TakeAction             PROCEDURE(BYTE Action, <STRING Item>, LONG Pos1=0, LONG Pos2=0),VIRTUAL
TakeEvent              PROCEDURE(UNSIGNED Event),BYTE,DERIVED
TakeCompletedInit       PROCEDURE(LONG pSelectedRecords),VIRTUAL
TakeCompletedProcess    PROCEDURE(LONG pSelectedRecord,STRING Value,BYTE Mark),VIRTUAL
                     END

EditQueue QUEUE,TYPE
Field       UNSIGNED
FreeUp      BYTE
Control     &EditClass
          END

  ITEMIZE,PRE(EIPAction)
Default  EQUATE(0)
Always   EQUATE(1)
Never    EQUATE(2)
Prompted EQUATE(4)
Save     EQUATE(7)
Remain   EQUATE(8)
Before   EQUATE(9)
Append   EQUATE(10)
RetainColumn   EQUATE(16)
  END


! ----------------------------------------------------------------
! The EIPManager class manages all the EditClasses that are used
! to perform EIP on specific browse columns.
! ----------------------------------------------------------------

EIPManager CLASS(WindowManager),TYPE,MODULE('ABEIP.CLW'),LINK('ABEIP.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
Again       BYTE,PROTECTED
Arrow       &BYTE              ! Should be treated as protected other than during initialization
Column      UNSIGNED
Enter       &BYTE              ! Should be treated as protected other than during initialization
EQ          &EditQueue         ! Should be treated as protected other than during initialization
Fields      &FieldPairsClass   ! Should be treated as protected other than during initialization
FocusLoss   &BYTE              ! Should be treated as protected other than during initialization
Insert      BYTE
ListControl SIGNED             ! Should be treated as protected other than during initialization
LastColumn  BYTE,PROTECTED
Repost      UNSIGNED,PROTECTED
RepostField UNSIGNED,PROTECTED
Req         BYTE,PROTECTED
SeekForward BYTE,PROTECTED
Tab         &BYTE              ! Should be treated as protected other than during initialization
MouseLeftIndex BYTE,PROTECTED

AddControl            PROCEDURE(<EditClass EC>,UNSIGNED Column,BYTE AutoFree = 0)
ClearColumn           PROCEDURE,VIRTUAL
Init                  PROCEDURE,BYTE,DERIVED,PROC
InitControls          PROCEDURE,VIRTUAL
Kill                  PROCEDURE,PROC,BYTE,DERIVED
Next                  PROCEDURE,PROTECTED
GetEdit               PROCEDURE,BYTE,VIRTUAL,PROTECTED
ResetColumn           PROCEDURE,VIRTUAL,PROTECTED
Run                   PROCEDURE(BYTE Req),BYTE
TakeAcceptAll         PROCEDURE(),BYTE,VIRTUAL
TakeAction            PROCEDURE(UNSIGNED Action),VIRTUAL
TakeCompleted         PROCEDURE(BYTE Force),VIRTUAL   ! Note this does -not- override the WindowManager variant
TakeEvent             PROCEDURE,DERIVED,BYTE,PROC
TakeFieldEvent        PROCEDURE,DERIVED,BYTE,PROC
TakeFocusLoss         PROCEDURE,VIRTUAL
TakeNewSelection      PROCEDURE,DERIVED,BYTE,PROC
           END

  _EndOfInclude_


