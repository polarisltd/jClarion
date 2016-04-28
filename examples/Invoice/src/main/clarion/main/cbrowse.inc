
!ABCIncludeFile(SV)

OMIT('_EndOfInclude_',_cBrowsePresent_)
_cBrowsePresent_ EQUATE(1)
!

    include('ado_sql.int'), once
    include('Ifilter.int'), once
    include('cFldPair.inc'), once
    include('abpopup.inc'), once

    itemize(EVENT:User + 1)
EVENT:EIPModeBegin      equate
EVENT:EIPModeEnd        equate
EVENT:EIPModeAbort      equate
    end

TColumnGrp      group, type
ColName           string(50)    ! Column header in the list (Ex: Customer ID)
ColNbr            byte          ! Col nbr in the list
ColListFormat     string(50)    ! Format string for that col of the list
Width             long          ! Actual width of the column
OriginalWidth     long          ! Original width of the column
AlwaysVisible     byte          ! Is Col must be visible all the time?
Visible           byte          ! Is column visible?
SortHeader        string(10)    ! Col is part of sort order and that string is added to the header
ColName_SQL       &string       ! Col SQL name  (Ex: CustID)
ColType           string(1)     ! Table Column or Expression, valid values are 'T' and 'E'
ColDataType       long          ! Equate Data type of the column  (valid values listed in EQUATES.CLW)
PosInQueue        long          ! Position in the Data queue
SortOrder         long          ! If Col is part of the sort order, which position in the sort order
SortDirection     string(1)     ! +, - (ASC, DESC)
EIPEnable         byte          ! Is EIP available for that column
EIPControlType    long          ! EIP control type
EIPFeq            long          ! EIP Field equate label
CanBeMoved        byte          ! Is column can be moved?  (For future use)
CanBeSorted       byte          ! Is column can be sorted ?
                end

TColumnQ        queue(TColumnGrp), type
                end


! cbrowse class
cBrowse         class, type, module('cbrowse.clw'), link('cbrowse.clw', _svLinkMode_), DLL(_svDLLMode_)

! properties

szSelectStr       cstring(1024)
szFromStr         cstring(1024)
szWhereStr        cstring(1024)
szUserWhereStr    cstring(1024)
szOrderByStr      cstring(1024)
szLocatorWhere    cstring(1024)

szColsPopup       cstring(1024)
szResetAlltext    cstring(128)

DefaultEquate     long              ! Equate that will get the EVENT:Accepted if user double click in the list.

CurSortCol        long, protected   ! Use to keep what is the last col MouseLeft sorted.
NextSortNbr       long, protected   ! Use to know what will be the next sort nbr to apply in the list header.

ColQ              &TColumnQ         ! Internal Col list info
ListCtrl          long              ! Field Equate label of List control
DataQueue         &queue            ! Reference to the queue storing the list data
UpdateQ           &TUpdateQ         ! Reference to an update queue for EIP

CopyQ             &queue            ! Reference to a DataQueue copy (used in tagging if user needs to do something with a bunch of tagged rows)

FieldPair         &cFieldPair


Popup             &Popupclass       ! Reference to a popupclass

TableLoad         byte              ! Flag used to populate all rows in the memory queue
QueueSort         byte              ! Flag used to instruct the code to sort the memory queue instead to generate a new result set.
SortQueueStr      string(128)       ! String that will receive the sort expression for sorting the queue (ex: +Field1, -Fiedl2 etc...)
szSortStr         cstring(128)      ! String that keeps the actual sort order

LocatorVar        &string           ! Reference to a var string associated with an entry control for locator purpose
CopyToCB          byte              ! Flag that indicate if the query should be copied to the clipboard or not

DB                &ADO_SQL          ! Ref to an ADO_SQL implementation

Filter            &IFilter          ! Ref to an IFilter implementation
W                 &Window           ! Ref to the parent window in order to register events with it

EIPMode           byte              ! Flag that indicate if EIP is in progress.
EIPCurCol         long
EIPCompletionKey  long
EIPAbortKey       long

MainSortStyle     long

TaggingFlag       byte              ! Flag that indicate if tagging is active or not
TaggingMark       &byte             ! Reference to the mark field in the queue structure for multiple select listbox.
TagKeyAlerted     byte              ! Flag that indicate if keys needed for tagging are alerted or not.

! Methods

construct         procedure
destruct          procedure

ApplyColOrder     procedure(string pColOrderStr), long, protected
ApplyHide         procedure(string pHideStr), long, protected
ApplySort         procedure(string pSortStr), long !, protected

CheckWidth        procedure(string pText), long, virtual

EIPAlertKey       procedure(), byte, virtual
EIPAccepted       procedure(), byte, virtual

GenerateOrderBy   procedure(), virtual
GenPopupStr       procedure(), virtual
GetColOrderSettings procedure(*string pColOrderStr), protected
getHideSettings   procedure(*string pHideStr), protected
GetPage           procedure(), virtual
GetSortSettings   procedure(*string pSortStr), protected


Init              procedure(long pListCtl, queue pDataQueue, window pW), virtual
InitColQ          procedure(), virtual
InitListStyle     procedure(), virtual
InitLocator       procedure(*string pLocatorVar), virtual
InitMarkRef       procedure(*byte pMark), virtual
InitCopyQ         procedure(*queue pQueue), virtual

Locate            procedure(), virtual
LoadSettings      procedure(), virtual

OnColResize       procedure(), byte, virtual, proc
OnDrop            procedure(), byte, virtual, proc
OnDrag            procedure(), byte, virtual, proc
OnAlertKey        procedure(), byte, virtual
OnPreAlertKey     procedure(), byte, virtual
OnEIPModeBegin    procedure(), virtual
OnEIPModeEnd      procedure(), byte, virtual
OnScrollUpDown    procedure(), byte, virtual


ReformatList      procedure(), virtual
Refresh           procedure(), virtual
RefreshPage       procedure(), virtual
RegisterEvents    procedure(), virtual
ResetAllVisible   procedure(), virtual
RestoreOrigHdr    procedure(), virtual

SaveSettings      procedure(), virtual
SetAlwaysVisible  procedure(string pColName), long, virtual
SetAlertKeys      procedure(), virtual
SetCopyToCB       procedure(byte pFlag), virtual
SetDB             procedure(ADO_SQL pIDB), virtual
SetEIPinfo        procedure(long ColNbr, long pControlType, *? pControlUse), proc, long, virtual   ! Value returned will be the FEQ return by create()
SetEIPCompleteKey procedure(long pKeycode), virtual
SetEIPAbortKey    procedure(long pKeycode), virtual
SetIFilter        procedure(IFilter pIFilter), virtual
SetListStyle      procedure(), virtual
SetNoSortOn       procedure(string pColName), long virtual
SetQuery          procedure(string pQuery), virtual
SetQueueRecord    procedure(), virtual
SetQueueSort      procedure(byte pFlag), virtual
SetSQLColQ        procedure(long pColNbr, string pSQLColName), virtual
SetTagging        procedure(byte pFlag), virtual
SetTableLoad      procedure(byte pFlag), virtual

UpdateColFormat   procedure(long pColNbr), virtual
UnselectAll       procedure(), virtual


                end


 _EndOfInclude_
