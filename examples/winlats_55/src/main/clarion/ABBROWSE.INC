
!ABCIncludeFile

OMIT('_EndOfInclude_',_BrowsePresent_)
_BrowsePresent_ EQUATE(1)

  INCLUDE ('ABFILE.INC'),ONCE
  INCLUDE ('ABPOPUP.INC'),ONCE
  INCLUDE ('ABTOOLBA.INC'),ONCE
  INCLUDE ('ABEIP.INC'),ONCE

! Server classes for browse routines
  ITEMIZE,PRE(ScrollBy)
Name            EQUATE
Alpha           EQUATE
Runtime         EQUATE
  END
  ITEMIZE,PRE(ScrollSort)
AllowAlpha    EQUATE(1)
AllowAlt      EQUATE(2)
AllowNumeric  EQUATE(4)
CaseSensitive EQUATE(8)
Descending    EQUATE(16)
  END

StepClass CLASS,MODULE('ABBROWSE.CLW'),TYPE,LINK('ABBROWSE.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Controls BYTE
GetPercentile  PROCEDURE(? Value),BYTE,VIRTUAL
GetValue       PROCEDURE(BYTE Percentile),STRING,VIRTUAL
Init           PROCEDURE(BYTE Controls)   !,EXTENDS
Kill           PROCEDURE,VIRTUAL
SetLimit       PROCEDURE(? Low,? High),VIRTUAL
SetLimitNeeded PROCEDURE,BYTE,VIRTUAL
  END

StepLongClass CLASS(StepClass),MODULE('ABBROWSE.CLW'),TYPE,DLL(_ABCDllMode_)
Low  LONG
High LONG
GetPercentile PROCEDURE(? Value),BYTE,VIRTUAL
GetValue      PROCEDURE(BYTE Percentile),STRING,VIRTUAL
SetLimit      PROCEDURE(? Low,? High),VIRTUAL
  END

StepRealClass CLASS(StepClass),MODULE('ABBROWSE.CLW'),TYPE,DLL(_ABCDllMode_)
Low  REAL
High REAL
GetPercentile  PROCEDURE(? Value),BYTE,VIRTUAL
GetValue       PROCEDURE(BYTE Percentile),STRING,VIRTUAL
SetLimit       PROCEDURE(? Low,? High),VIRTUAL
  END

StepStringClass CLASS(StepClass),MODULE('ABBROWSE.CLW'),TYPE,DLL(_ABCDllMode_)
LookupMode  BYTE
Ref         &STRING,PRIVATE
Root        CSTRING(40)
SortChars   &CSTRING
TestLen      BYTE,PROTECTED
GetPercentile  PROCEDURE(? Value),BYTE,VIRTUAL
GetValue       PROCEDURE(BYTE Percentile),STRING,VIRTUAL
Hash           PROCEDURE(STRING Val),LONG,PRIVATE
Init           PROCEDURE(BYTE Controls,BYTE Mode)   !,EXTENDS
Kill           PROCEDURE,VIRTUAL
SetLimit       PROCEDURE(? Low,? High),VIRTUAL
SetLimitNeeded PROCEDURE,BYTE,VIRTUAL
Unhash         PROCEDURE(LONG Val),STRING,PRIVATE
  END

CStringList QUEUE,TYPE
Item  &CSTRING
            END

StepCustomClass CLASS(StepClass),MODULE('ABBROWSE.CLW'),TYPE,DLL(_ABCDllMode_)
Entries       &CStringList,PROTECTED
AddItem       PROCEDURE(STRING Text)
GetPercentile PROCEDURE(? Value),BYTE,VIRTUAL
GetValue      PROCEDURE(BYTE Percentile),STRING,VIRTUAL
Init          PROCEDURE(BYTE Controls)   !,EXTENDS
Kill          PROCEDURE,VIRTUAL
  END

LocatorClass CLASS,TYPE,MODULE('ABBROWSE.CLW'),DLL(_ABCDllMode_)
ViewManager &BrowseClass
Control     SIGNED
FreeElement ANY
NoCase      BYTE
Destruct      PROCEDURE,VIRTUAL
GetShadow     PROCEDURE,VIRTUAL,STRING
Init          PROCEDURE(SIGNED Control = 0,*? Free,BYTE NoCase = 0,<BrowseClass BC>)   !,EXTENDS
!*** Synchronises locator to current entry value (where applicable)
Reset         PROCEDURE,VIRTUAL
!*** Starts an 'empty' locator
Set           PROCEDURE,VIRTUAL
SetAlerts     PROCEDURE(SIGNED FieldEquate),VIRTUAL
SetEnabled    PROCEDURE(BYTE B)
SetShadow     PROCEDURE(STRING S),VIRTUAL
TakeAccepted  PROCEDURE,VIRTUAL,BYTE ! 1 for locator on value required
TakeKey       PROCEDURE,VIRTUAL,BYTE ! 1 for locator on value required
UpdateWindow  PROCEDURE,VIRTUAL
  END

StepLocatorClass CLASS(LocatorClass),TYPE,MODULE('ABBROWSE.CLW'),DLL(_ABCDllMode_)
Set           PROCEDURE,DERIVED
TakeKey       PROCEDURE,DERIVED,BYTE ! 1 for locator on value required
  END

EntryLocatorClass CLASS(LocatorClass),TYPE,MODULE('ABBROWSE.CLW'),DLL(_ABCDllMode_)
Shadow        CSTRING(40)
Init          PROCEDURE(SIGNED Control = 0,*? Free,BYTE NoCase = 0,<BrowseClass BC>)   !,EXTENDS
GetShadow     PROCEDURE,DERIVED,STRING
Set           PROCEDURE,DERIVED
SetShadow     PROCEDURE(STRING S),DERIVED
TakeAccepted  PROCEDURE,DERIVED,BYTE ! 1 for locator on value required
TakeKey       PROCEDURE,DERIVED,BYTE ! 1 for locator on value required
Update        PROCEDURE,PROTECTED,VIRTUAL
UpdateWindow  PROCEDURE,DERIVED
  END

IncrementalLocatorClass CLASS(EntryLocatorClass),TYPE,MODULE('ABBROWSE.CLW'),DLL(_ABCDllMode_)
SetAlerts     PROCEDURE(SIGNED Control),VIRTUAL
TakeKey       PROCEDURE,VIRTUAL,BYTE ! 1 for locator on value required
  END

FilterLocatorClass CLASS(IncrementalLocatorClass),TYPE,MODULE('ABBROWSE.CLW'),DLL(_ABCDllMode_)
FloatRight    BYTE
Reset         PROCEDURE,VIRTUAL
TakeAccepted  PROCEDURE,VIRTUAL,BYTE
UpdateWindow  PROCEDURE,VIRTUAL
  END


FillBackward             EQUATE(1)
FillForward              EQUATE(2)

 ITEMIZE,PRE(Reset)
Queue              EQUATE
Done               EQUATE
 END

BrowseSortOrder QUEUE(SortOrder),TYPE
Locator      &LocatorClass
Resets       &FieldPairsClass
Thumb        &StepClass
             END

BrowseEditQueue QUEUE(EditQueue),TYPE
  END

BrowseEIPManager CLASS(EIPManager),TYPE,MODULE('ABBROWSE.CLW'),DLL(_ABCDllMode_)
BC                   &BrowseClass,PROTECTED
ClearColumn          PROCEDURE,DERIVED
Init                 PROCEDURE,BYTE,DERIVED,PROC
Kill                 PROCEDURE,PROC,BYTE,DERIVED
TakeCompleted        PROCEDURE(BYTE Force),DERIVED
TakeNewSelection     PROCEDURE,DERIVED,BYTE,PROC
           END

MouseLeft2Index EQUATE(252)

BrowseQueue     INTERFACE
Records           PROCEDURE, UNSIGNED
Insert            PROCEDURE
Insert            PROCEDURE(UNSIGNED RowNum)
Fetch             PROCEDURE(UNSIGNED RowNum)
Update            PROCEDURE
Delete            PROCEDURE
Free              PROCEDURE
Who               PROCEDURE(UNSIGNED ColNum), STRING
GetViewPosition   PROCEDURE, STRING
SetViewPosition   PROCEDURE(STRING S)
                END

IListControl INTERFACE
Choice       PROCEDURE,SIGNED
GetControl   PROCEDURE,SIGNED
GetItems     PROCEDURE,SIGNED
GetVisible   PROCEDURE,BYTE
SetChoice    PROCEDURE(SIGNED NewChoice)
SetControl   PROCEDURE(SIGNED NewControl)
             END

StandardBehavior CLASS,IMPLEMENTS(BrowseQueue),IMPLEMENTS(IListControl),TYPE,MODULE('ABBROWSE.CLW'),DLL(_ABCDllMode_)
Init            PROCEDURE(QUEUE QU, *STRING VPos, SIGNED LC)   !,EXTENDS
Q               &QUEUE, PRIVATE
S               &STRING, PRIVATE
LC              SIGNED,PRIVATE
              END

BrowseClass CLASS(ViewManager),IMPLEMENTS(WindowComponent),TYPE,MODULE('ABBROWSE.CLW'),DLL(_ABCDllMode_)
ActiveInvisible BYTE               ! Should the browse be active when invisible
AllowUnfilled BYTE
ArrowAction   BYTE
AskProcedure  USHORT               !Procedure to call from ask, 0=>EIP
Behavior      &StandardBehavior,PRIVATE
Buffer        USHORT,PRIVATE
ChangeControl SIGNED
CurrentChoice LONG,PROTECTED
CurrentEvent  LONG,PRIVATE
DeleteControl SIGNED
EIP           &BrowseEIPManager           ! Is freed during kill
EditList      &BrowseEditQueue,PROTECTED
EnterAction   BYTE
Fields        &FieldPairsClass,PROTECTED
FileLoaded    BYTE
FocusLossAction BYTE
FreeEIP       BYTE,PRIVATE
HasThumb      BYTE
HideSelect    BYTE
ILC           &IListControl
InsertControl SIGNED
ItemsToFill   LONG,PRIVATE
LastChoice    LONG,PRIVATE
LastItems     LONG,PRIVATE
ListQueue     &BrowseQueue,PROTECTED
LoadPending   BYTE,PRIVATE
Loaded        BYTE,PROTECTED ! Used by browse code to see if starting up
NeedRefresh   BYTE,PROTECTED
Popup         &PopupClass
PrevChoice    LONG,PROTECTED
PrintControl  SIGNED
PrintProcedure USHORT
Processors    &ProcessorQueue,PROTECTED
Query         &QueryClass
QueryControl  SIGNED
QueryResult   SIGNED,PROTECTED
QueryShared   BYTE
QuickScan     BYTE
RecordStatus  BYTE,PRIVATE
RetainRow     BYTE           ! Attempt to preserve highlighted row# during queue refill
SelectControl SIGNED
SelectWholeRecord BYTE       ! Set to 1 if you want the -whole- record when Selecting
Selecting     BYTE
Sort          &BrowseSortOrder,PROTECTED    ! Is really a 'shadow' of the parent ORDER queue
StartAtCurrent BYTE          ! Jump to current file value on first browse load
TabAction     BYTE
ToolControl   SIGNED
Toolbar       &ToolbarClass
ToolbarItem   &ToolbarListboxClass
ViewControl   SIGNED
Window        &WindowManager,PROTECTED
AddEditControl       PROCEDURE(<EditClass EC>,UNSIGNED Column,BYTE AutoFree = 0)
AddField             PROCEDURE(*? Left,*? Right)
AddField             PROCEDURE(*long Left,*long Right)
AddField             PROCEDURE(*string Left,*string Right)
AddItem              PROCEDURE(RecordProcessor RP)
AddLocator           PROCEDURE(LocatorClass LC) ! Must come -after- SortOrder added
AddResetField        PROCEDURE(*? Field)
AddResetField        PROCEDURE(*string Field)
AddSortOrder         PROCEDURE(<StepClass SC>,<Key K>),BYTE,PROC
AddToolbarTarget     PROCEDURE(ToolbarClass TC)
ApplyRange           PROCEDURE,PROC,VIRTUAL,BYTE ! 1 if action taken !*** Signal browse to 'reevaluate' resets and range limits.
Ask                  PROCEDURE(BYTE Request),BYTE,VIRTUAL,PROC ! Request in, response out
AskRecord            PROCEDURE(BYTE Request),BYTE,VIRTUAL,PROC ! Request in, response out
CheckEIP             PROCEDURE,PRIVATE
Fetch                PROCEDURE(BYTE Direction),VIRTUAL,PROTECTED
Init                 PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)   !,EXTENDS
Init                 PROCEDURE(IListControl IC,VIEW V,BrowseQueue LQ,RelationManager RM,WindowManager WM)         !,EXTENDS
InitSort             PROCEDURE(BYTE NewOrder),BYTE,VIRTUAL
Kill                 PROCEDURE,VIRTUAL
Next                 PROCEDURE,BYTE,VIRTUAL
NotifyUpdateError    PROCEDURE(),BYTE,VIRTUAL                  ! Response out
PostNewSelection     PROCEDURE
Previous             PROCEDURE,VIRTUAL,BYTE  ! :Notify for eof, :Fatal for error condition
Records              PROCEDURE,LONG,PROC  ! Has side effect of resyncing other controls to emptyness
ResetFields          PROCEDURE
ResetFromAsk         PROCEDURE(*BYTE Request,*BYTE Response),PROTECTED,VIRTUAL
ResetFromBuffer      PROCEDURE,VIRTUAL
ResetFromFile        PROCEDURE,VIRTUAL
ResetFromView        PROCEDURE,VIRTUAL
ResetQueue           PROCEDURE(BYTE ResetMode),VIRTUAL
ResetResets          PROCEDURE,PROTECTED
ResetSort            PROCEDURE(BYTE Force),BYTE,VIRTUAL,PROC
ResetThumbLimits     PROCEDURE,PRIVATE
ScrollEnd            PROCEDURE(SIGNED Event),VIRTUAL,PROTECTED
ScrollOne            PROCEDURE(SIGNED Event),VIRTUAL,PROTECTED
ScrollPage           PROCEDURE(SIGNED Event),VIRTUAL,PROTECTED
SetAlerts            PROCEDURE,VIRTUAL
SetQueueRecord       PROCEDURE,VIRTUAL
SetSort              PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,VIRTUAL,PROC
TakeAcceptedLocator  PROCEDURE,VIRTUAL
TakeChoiceChanged    PROCEDURE,PRIVATE
TakeEvent            PROCEDURE,VIRTUAL
TakeKey              PROCEDURE,BYTE,PROC,VIRTUAL ! 1 If action taken
TakeLocate           PROCEDURE,VIRTUAL
TakeNewSelection     PROCEDURE,VIRTUAL
TakeScroll           PROCEDURE(SIGNED Event = 0),VIRTUAL
TakeVCRScroll        PROCEDURE(SIGNED Vcr = 0),VIRTUAL
UpdateBuffer         PROCEDURE,VIRTUAL      ! Update file fields from CurrentChoice
UpdateQuery          PROCEDURE(QueryClass QC, BYTE CaseLess=1)
UpdateResets         PROCEDURE,PROTECTED
UpdateThumb          PROCEDURE
UpdateThumbFixed     PROCEDURE,PROTECTED
UpdateToolbarButtons PROCEDURE,PRIVATE
UpdateViewRecord     PROCEDURE,VIRTUAL    ! Reget on all involved files
UpdateWindow         PROCEDURE,VIRTUAL
  END

_EndOfInclude_





