!Declarations of SortHeader Class and Type
OMIT('_EndOfInclude_',_BrowseBoxExtender_)
_BrowseBoxExtender_ EQUATE(1)

!==============================================================================
!
!  CListFMgr
!
! 
!
!==============================================================================
!// Window standard styles
!// GetWindowLong flags
INCLUDE('svapi.inc'),ONCE

!// GetClassLong flags
GCL_HICON        EQUATE(-14)

!// List Format Manager switching checkboxes type
CHECK_ICON       EQUATE(1)                  ! Checkbox is an icon
CHECK_TEXT       EQUATE(2)                  ! Checkbox is a text

!// List Format Manager sorting rules
SORT_CODE        EQUATE(1)                  ! Sorting by code
SORT_ALPHA       EQUATE(2)                  ! Sorting by name

!// State flag for List Format Manager popup menu
STATE_DISABLE    EQUATE(1)                  ! LFM popup menu state

!// List Format Manager class declaration
ListFormatManagerClass    CLASS,TYPE,MODULE('BrwExt.CLW'),LINK('BrwExt.CLW',1),DLL(0)
m_File                      &FILE,PRIVATE
m_Record                    &GROUP,PRIVATE
m_Control                   SIGNED,PRIVATE
m_Queue                     &QUEUE,PRIVATE
m_QFields                   SHORT,PRIVATE
m_AppName                   STRING(30),PRIVATE
m_ProcId                    STRING(30),PRIVATE
m_UserId                    SHORT,PRIVATE
m_CtrlId                    SHORT,PRIVATE
m_Inited                    BYTE,PRIVATE
m_InitChoice                SHORT,PRIVATE
m_LastChoice                SHORT,PRIVATE
m_LastId                    SHORT,PRIVATE
m_PopupText                 &STRING,PRIVATE
m_Format                    &STRING,PRIVATE
m_Columns                   SHORT,PRIVATE
m_Groups                    SHORT,PRIVATE
m_Check                     BYTE,PRIVATE
m_ForceRefresh              BYTE(FALSE),PRIVATE
m_SavePos                   BYTE,PRIVATE
m_INIFile                   &STRING,PRIVATE
m_Sort                      BYTE,PRIVATE
m_UseTip                    BYTE,PRIVATE
m_Tip                       &STRING,PRIVATE
m_ColumnList                &ColumnQueue,PRIVATE
m_GroupList                 &GroupQueue,PRIVATE
m_cls_Map                   &Qcls_Map,PRIVATE! Mapping queue
m_cls_PosList               &Qcls_PosList,PRIVATE ! Field position in the VarLine
m_FormatCount               SHORT,PRIVATE

SaveFormat                  BYTE
AllowAdd                    BYTE(1)
AllowDelete                 BYTE(1)
AllowChange                 BYTE(1)

Construct                   PROCEDURE()
Destruct                    PROCEDURE()
BrowseFormat                PROCEDURE,PRIVATE
BindFile                    PROCEDURE,PRIVATE
BindInterface               PROCEDURE(BYTE _CheckType = CHECK_ICON,BYTE _Sort = SORT_ALPHA,BYTE _SavePos = TRUE,<STRING _IniFile>)
BuildFieldLine              PROCEDURE,STRING,PRIVATE
DispatchChoice              PROCEDURE(SIGNED _Choice),BYTE,PROC
EditFormat                  PROCEDURE(BYTE _Action),BYTE,PRIVATE,PROC
GetError                    PROCEDURE(BYTE _Level = 0),BYTE,PRIVATE,PROC
GetFormat                   PROCEDURE(BYTE _Mode),STRING,PRIVATE,PROC
GetFormatByID               PROCEDURE(SHORT _FormatId),STRING,PRIVATE
GetMaxChoices               PROCEDURE,SIGNED,PRIVATE
GetColumns                  PROCEDURE,SHORT,PRIVATE
GetGroups                   PROCEDURE,SHORT,PRIVATE
Init                        PROCEDURE(STRING m_AppName,STRING _ProcId,SHORT _UserId,SIGNED _Control,BYTE _ControlOrder,*STRING _PopupText,*QUEUE _Queue,SHORT  _FieldCount,FILE _File,*GROUP _Record,BYTE _UseTip = TRUE)
IsDuplicate                 PROCEDURE(STRING _Format),BYTE,PRIVATE
Kill                        PROCEDURE(BYTE _Halt = FALSE)
MakePopup                   PROCEDURE(*STRING _PopupText,BYTE _Disable = FALSE)
SetCurrentFormat            PROCEDURE(SHORT _FormatId),PRIVATE
SetTip                      PROCEDURE,PRIVATE
SetWidth                    PROCEDURE(*STRING _Format,SHORT _Width),PRIVATE
SplitVarLine                PROCEDURE(STRING _VarLine),PRIVATE
Synchronize                 PROCEDURE,PRIVATE
SetPopupChoice              PROCEDURE(<USHORT InitChoice>,USHORT LastChoice)
UpdateFormat                PROCEDURE(STRING _Format),PRIVATE
RefreshColumnsWidth         PROCEDURE(BYTE _AddPound=0)
UpdateCurrentFormat         PROCEDURE()
SetCurrentFormat            PROCEDURE(SHORT _FormatId,STRING _FormatName)
                        END

!==============================================================================
!
!  SortHeaderClassType
!
! 
!
!==============================================================================
RegionStatus:MouseReleased            EQUATE(0)
RegionStatus:MousePressedAndInRegion  EQUATE(1)
RegionStatus:MousePressedAndOutRegion EQUATE(2)

QueueListHeaderType    QUEUE,TYPE
ListHeaderText           CSTRING(512)
FieldNo                  LONG
                       END
QueueListSortType      QUEUE,TYPE
ListSortColumn           LONG
PrevListSortColumn       LONG
                       END

SortHeaderClassType  CLASS,TYPE,MODULE('BrwExt.CLW'),LINK('BrwExt.CLW',1),DLL(0)
!----------- Private Members -------------
ListQueue              &QUEUE,PRIVATE
QueueListHeader        &QueueListHeaderType,PRIVATE
QueueListSort          &QueueListSortType,PRIVATE
ListControl            SIGNED,PRIVATE
RegionControl          SIGNED,PRIVATE
IniFileName            STRING(255),PRIVATE
ProcedureName          STRING(255),PRIVATE
SortOrder              SHORT,PRIVATE
PrevSortOrder          SHORT,PRIVATE
MouseRegionStatus      BYTE,PRIVATE
ForceChangeSignOrder   BYTE,PRIVATE
ForceFindRecord        BYTE
LastKeyCode            LONG,PRIVATE
FirstSortField         STRING(1024),PRIVATE
View                   &View
PK                     &KEY
DisableNonViewColumns  BYTE
NoCase                 BYTE

!----------- Public Methods --------------
Init                   PROCEDURE(QUEUE ListQueue,SIGNED ListControl,LONG RowSortDefault = 0,<STRING IniFileName>,<STRING ProcedureName>,<VIEW pView>,<KEY pPK>)
SetAlerts              PROCEDURE()
TakeEvents             PROCEDURE(),BYTE,PROC
SetSortOrder           PROCEDURE(<LONG SortOrder>)
GetSortOrder           PROCEDURE(),LONG
Kill                   PROCEDURE()
ClearSort              PROCEDURE()
ResetSort              PROCEDURE()
GetColumnText          PROCEDURE(LONG pColumn),STRING
GetColumnName          PROCEDURE(LONG pColumn),STRING
RestoreHeaderText      PROCEDURE()

SortQueue              PROCEDURE()

!----------- Private Methods -------------
SetPrevSortOrder       PROCEDURE(),PRIVATE
MouseReleased          PROCEDURE(),PRIVATE
MousePressed           PROCEDURE(),PRIVATE
FieldInGroup           FUNCTION(),BYTE,PRIVATE
SetRegionUp            PROCEDURE(),PRIVATE
SetRegionDown          PROCEDURE(),PRIVATE
CheckRangeRegion       PROCEDURE(),BYTE,PRIVATE
FindRecord             PROCEDURE(),LONG,PRIVATE

!----------- Vitrual Methods -------------
GetSortingColumnString PROCEDURE(STRING pSign,STRING pColumnName,STRING pColumnPicture),STRING,VIRTUAL
QueueResorted          PROCEDURE(STRING pSortingString),VIRTUAL
ValidField             PROCEDURE(STRING pColumnName),BYTE,VIRTUAL   !RETURN True if the passed field name is valid to sort by that field
                     END
!--------------------------------------------------
!==============================================================================
!
!  AutoSizeColumnClassType
!
! 
!
!==============================================================================

BrwExtQueueAutoSizeListBoxType QUEUE,TYPE
AutoSizeListBoxControl           SIGNED
AutoSizeListBoxQueue             &QUEUE
                               END

AutoSizeColumnClassType CLASS,TYPE,MODULE('BrwExt.CLW'),LINK('BrwExt.CLW',1),DLL(0)
!----------- Private Members -------------
Initialized               BYTE,PRIVATE
QueueAutoSizeListBox      &BrwExtQueueAutoSizeListBoxType,PRIVATE
StringControl             SIGNED,PRIVATE

!----------- Public Methods --------------
Init                      PROCEDURE
AddListBox                PROCEDURE(SIGNED ListControl,QUEUE ListQueue)
TakeEvents                PROCEDURE,BYTE,PROC
ResizeColumn              PROCEDURE(SIGNED ListControl,LONG Colomn)
ResizeAll                 PROCEDURE
ResizeAll                 PROCEDURE(SIGNED ListControl)
Kill                      PROCEDURE
                        END
!--------------------------------------------------

_EndOfInclude_
