  MEMBER

  MAP
    MODULE('WINDOWS')
    END
    MODULE('CLIB')
      Access(*CSTRING,SHORT),SHORT,RAW,NAME('_access')
      FnSplit(*CSTRING,*CSTRING,*CSTRING,*CSTRING,*CSTRING),SHORT,RAW,NAME('_fnsplit')
      MkDir(*CSTRING),SHORT,RAW,NAME('_mkdir')
    END
    ReplaceMacro(STRING _Macro,STRING _Source,*STRING _Target),PRIVATE
  END
  INCLUDE('KEYCODES.CLW'),ONCE
  INCLUDE('BrwExt.INC'),ONCE
  INCLUDE('BrwExt.TRN'),ONCE
  INCLUDE('Errors.CLW'),ONCE
  INCLUDE('TplEqu.CLW'),ONCE

cls_Counter      LONG(0),THREAD                    ! File opening counter
                 
cls_File         GROUP,PRE(),THREAD                ! Main file group
m_Key              &KEY
m_AppName          ANY
m_ProcId           ANY
m_UserId           ANY
m_CtrlId           ANY
m_FormatId         ANY
m_FormatName       ANY
m_Flag             ANY
m_Format           ANY
m_VarLine          ANY
                 END

Qcls_Map         QUEUE,TYPE                ! Mapping queue
Choice             SHORT
Id                 SHORT
                 END

Qcls_PosList     QUEUE,TYPE                ! Field position in the VarLine
m_Pos              LONG,DIM(3)
m_FieldNo          SHORT
                 END

ColumnQueue      QUEUE,TYPE                 ! Target column queue type
m_Column           SHORT                    ! Number of column in the LIST
m_FieldNo          SHORT                    ! PROPLIST:FieldNo
m_Width            SHORT                    ! PROPLIST:Width
m_Format           &STRING                  ! PROPLIST:Format
m_GroupNo          SHORT                    ! Number of group to which column belong
m_StartPos         LONG                     ! Start position of the column
                 END

GroupQueue       QUEUE,TYPE                 ! Target group queue type
m_Group            SHORT
m_Width            SHORT
m_Header           &STRING
m_Name             &STRING
m_Columns          SHORT
                 END

!// List Format Manager moving direction flags
DIR_UP           EQUATE(1)                  ! Moving up
DIR_DOWN         EQUATE(2)                  ! Moving down
DIR_FIRST        EQUATE(3)                  ! Moving to first
DIR_LAST         EQUATE(4)                  ! Moving to last

!// List Format Manager column browse icons
COLUMN_SHOW      EQUATE(1)                  ! Column is active and visible
COLUMN_HIDE      EQUATE(2)                  ! Column is active and invisible
COLUMN_SHOW_DIM  EQUATE(3)                  ! Column is inactive and visible
COLUMN_HIDE_DIM  EQUATE(4)                  ! Column is inactive and invisible

!// List Format Manager format types
FORMAT_DEFAULT   EQUATE(1)                  ! Default format (designed and saved)
FORMAT_CURRENT   EQUATE(2)                  ! Current format (at this moment)
FORMAT_INIT      EQUATE(3)                  ! Init format (designed)

!// Offset for list of columns (See the SELF.EditFormat...)
CHECK_OFFSET     EQUATE(11)                 ! Offset

!// Inner variable for storing address of WINDOW structure
  COMPILE('end_of_standalone_model',dll_mode)
WslWind:pFrame   LONG,EXTERNAL,NAME('WslWind@pFrame')
    COMPILE('***',_C55_)
MODAL_STYLE      EQUATE(-4)                 ! Offset for C55
    ***
    OMIT('***',_C55_)
MODAL_STYLE      EQUATE(-20)                ! Offset for C5
    ***
  end_of_standalone_model

  OMIT('end_of_local_model',dll_mode)
WslWind:Modal    LONG,EXTERNAL,NAME('WslWind@Modal')
  end_of_local_model

!==============================================================================
!
!  CListFMgr
!
! 
!
!==============================================================================
ListFormatManagerClass.Construct       PROCEDURE()
 CODE
    SELF.m_cls_Map     &= NEW(Qcls_Map)
    SELF.m_cls_PosList &= NEW(Qcls_PosList)

ListFormatManagerClass.Destruct        PROCEDURE()
 CODE
    FREE(SELF.m_cls_Map)
    DISPOSE(SELF.m_cls_Map)
    FREE(SELF.m_cls_PosList)
    DISPOSE(SELF.m_cls_PosList)

!//////////////////////////////////////////////////////////////////////////////
!/
!/ NAME        : INIT
!/ DESCRIPTION :  is a Format Manager object constructor
!/ PARAMETERS  : [in] _AppName   - Application name where the object is used
!/               [in] _ProcId    - Procedure instance where the object is used
!/               [in] _UserId    - UserId that is using the app
!/               [in] _Control   - Listbox control equate
!/               [in] _CtrlId    - Listbox control identifier
!/               [in] _PopupText - Reference to variable containing string for POPUP
!/               [in] _File      - Reference to main configuration file
!/               [in] _Record    - Record buffer of the _File
!/               [in] _UseTip    - Use format tooltip
!/ RETURNS     : No returned value
!/
!//////////////////////////////////////////////////////////////////////////////
ListFormatManagerClass.Init              PROCEDURE(STRING _AppName, STRING _ProcId,      |
                                      SHORT _UserId,    |
                                      SIGNED _Control,    |
                                      BYTE _CtrlId,       |
                                      *STRING _PopupText, |
                                      *QUEUE _Queue,      |
                                      SHORT  _FieldCount, |
                                      FILE _File,         |
                                      *GROUP _Record,     |
                                      BYTE _UseTip = TRUE |
                                     )

loc_LoopIndex               SHORT,AUTO      ! Local loop index
loc_Format                  STRING(8192)    ! Buffer for format content
loc_Columns                 SHORT,AUTO      ! Quantity of columns in the group
loc_PoundPos                LONG,AUTO       ! Position of the first "#"

  CODE
  SELF.m_File   &= _File
  SELF.m_Record &= _Record
!// Bind file fields to an object
  SELF.BindFile()
!// Open configuration file
  LOOP 2 TIMES
    OPEN(SELF.m_File,42h)
    CASE ERRORCODE()
    OF NoError
    OROF IsOpenErr
      cls_Counter += 1
      BREAK
    OF BadKeyErr
      OPEN(SELF.m_File)
      BUILD(SELF.m_File)
      IF SELF.GetError(1) 
        CLOSE(SELF.m_File)
        RETURN
      END
      CLOSE(SELF.m_File)
    OF NoPathErr
    OROF NoFileErr
      DO CreateDir
      CREATE(SELF.m_File)
      IF SELF.GetError(2) 
        SELF.Kill(TRUE)
      END
    ELSE
      IF SELF.GetError(3) 
        SELF.Kill(TRUE)
      END
    END
  END
!// Initialization of instance
  SELF.m_Queue  &= _Queue
  SELF.m_QFields = _FieldCount
  SELF.m_AppName = _AppName
  SELF.m_ProcId  = _ProcId
  SELF.m_UserId  = _UserId
  SELF.m_Control = _Control
  SELF.m_CtrlId  = _CtrlId
  SELF.m_Check   = CHECK_ICON
  SELF.m_Sort    = SORT_ALPHA
  SELF.m_PopupText &= _PopupText
  SELF.m_UseTip = _UseTip
  IF SELF.m_UseTip
    SELF.m_Tip &= NEW(STRING(LEN(SELF.m_Control{PROP:Tip})))
    SELF.m_Tip  = SELF.m_Control{PROP:Tip}
  END
  SELF.m_Format &= NEW(STRING(LEN(SELF.m_Control{PROP:Format})))
  SELF.m_Format  = SELF.m_Control{PROP:Format}
  SELF.m_Columns = SELF.GetColumns()
  SELF.m_Groups  = SELF.GetGroups()
  SELF.m_ColumnList &= NEW(ColumnQueue)
  SELF.m_GroupList  &= NEW(GroupQueue)

  SELF.RefreshColumnsWidth(True)

!// Create or modify "default" format record
  IF SELF.GetFormat(FORMAT_DEFAULT)
    loc_Format = cls_File.m_Format
    IF CLIP(loc_Format) <> SELF.GetFormat(FORMAT_INIT)
!// If the default format differ from initial format...
      cls_File.m_Format  = SELF.GetFormat(FORMAT_INIT)
      cls_File.m_VarLine = SELF.BuildFieldLine()
      PUT(SELF.m_File)
      IF SELF.GetError(5) 
        SELF.Kill(TRUE)
      END
      SELF.Synchronize()
    END
  ELSE
!// There is no "default" format. Create it.
    CLEAR(SELF.m_File)
    cls_File.m_AppName    = SELF.m_AppName
    cls_File.m_ProcId     = SELF.m_ProcId
    cls_File.m_UserId     = SELF.m_UserId
    cls_File.m_CtrlId     = SELF.m_CtrlId
    cls_File.m_FormatId   = 1
    cls_File.m_FormatName = POPUP_NAME_DEFAULT
    cls_File.m_Flag       = FORMAT_DEFAULT + FORMAT_CURRENT
    cls_File.m_Format     = SELF.GetFormat(FORMAT_INIT)
    cls_File.m_VarLine    = SELF.BuildFieldLine()
    ADD(SELF.m_File)
    IF SELF.GetError(6) 
      SELF.Kill(TRUE)
    END
  END

!// Set current format
  SELF.m_Control{PROP:Format} = SELF.GetFormat(FORMAT_CURRENT)
  SELF.m_LastId = cls_File.m_FormatId

!// Set identification tooltip
  IF SELF.m_UseTip
    SELF.SetTip()
  END

!// Object has been initialized
  SELF.m_Inited = TRUE
!------------------------------------------------------------------------------
! NAME        : CREATEDIR
! DESCRIPTION : routine creates a directory
!------------------------------------------------------------------------------
CreateDir                   ROUTINE

  DATA

rou_FileName                CSTRING(256)         ! Buffer for filename
rou_SPos                    LONG(1)              ! Start position for INSTRING
rou_FPos                    LONG,AUTO            ! Found position
rou_Dir                     CSTRING(256)         ! Buffer for partial path

  CODE
  rou_FileName = LEFT(NAME(SELF.m_File))
  LOOP
    rou_FPos = INSTRING('\',rou_FileName,1,rou_SPos)
!// There is no path just a name
    IF ~rou_FPos THEN BREAK.
    rou_SPos = rou_FPos + 1
    rou_Dir = rou_FileName[1 : (rou_FPos - 1)]
    IF rou_Dir[LEN(CLIP(rou_Dir))] = ':' 
      CYCLE
    END
    rou_FPos = INSTRING('\',rou_FileName,1,rou_SPos)
    IF ~rou_FPos AND rou_FileName[rou_SPos] = '!'
      BREAK
    END
    IF Access(rou_Dir,0)
      IF MkDir(rou_Dir)
        MESSAGE(MESSAGE_DIRFAILED,MESSAGE_TITLE,ICON:Exclamation)
        SELF.Kill(TRUE)
      END
    END
  END
ListFormatManagerClass.RefreshColumnsWidth   PROCEDURE(BYTE _AddPound=0)
loc_LoopIndex               SHORT,AUTO      ! Local loop index
loc_Columns                 SHORT,AUTO      ! Quantity of columns in the group
loc_PoundPos                LONG,AUTO       ! Position of the first "#"
loc_GroupNo                 SHORT(0)        ! Local group number
loc_Format                  STRING(8192)    ! Buffer for format content
loc_FPos                    UNSIGNED,AUTO   ! Found position for INSTRING
loc_TildePos                LONG,AUTO       ! Position of the first "~"
loc_MPos                    LONG,AUTO       ! Position of the first "~"

  CODE
!// Init initial group queue if groups are
  LOOP loc_LoopIndex = 1 TO RECORDS(SELF.m_GroupList)
      GET(SELF.m_GroupList,loc_LoopIndex)
      DISPOSE(SELF.m_GroupList.m_Header)
      DISPOSE(SELF.m_GroupList.m_Name)
      CLEAR(SELF.m_GroupList)
  END
  FREE(SELF.m_GroupList)
  IF SELF.m_Groups
    LOOP loc_LoopIndex = 1 TO SELF.m_Columns
      IF loc_GroupNo <> SELF.m_Control{PROPLIST:GroupNo,loc_LoopIndex}
        loc_GroupNo = SELF.m_Control{PROPLIST:GroupNo,loc_LoopIndex}
        loc_Columns = SELF.m_Control{PROPLIST:GroupNo + PROPLIST:Group,loc_LoopIndex}
        IF loc_Columns
          CLEAR(SELF.m_GroupList)
          SELF.m_GroupList.m_Group = loc_GroupNo
          IF _AddPound THEN
             IF SELF.m_Control{PROPLIST:Resize+ PROPLIST:Group,loc_LoopIndex} THEN
                SELF.m_Control{PROPLIST:Resize+ PROPLIST:Group,loc_LoopIndex}=0
             END
          END
          loc_Format  = SELF.m_Control{PROPLIST:Format + PROPLIST:Group,loc_LoopIndex}
!// Search for a group header (all behind "]" symbol)
          loc_FPos = INSTRING(']',loc_Format,1,1)
          IF ~loc_FPos
            MESSAGE(MESSAGE_WRONGFORMAT,MESSAGE_TITLE,ICON:Exclamation,MESSAGE_BTNOK)
            SELF.Kill(TRUE)
          END
          
          loc_Format = loc_Format[(loc_FPos + 1) : LEN(CLIP(loc_Format))]
          SELF.m_GroupList.m_Header &= NEW(STRING(LEN(CLIP(loc_Format))))
          SELF.m_GroupList.m_Header  = CLIP(loc_Format)
          SELF.m_GroupList.m_Name   &= NEW(STRING(LEN(SELF.m_Control{PROPLIST:Header + PROPLIST:Group,loc_LoopIndex})))
          SELF.m_GroupList.m_Name    = SELF.m_Control{PROPLIST:Header + PROPLIST:Group,loc_LoopIndex}
          SELF.m_GroupList.m_Width   = SELF.m_Control{PROPLIST:Width + PROPLIST:Group,loc_LoopIndex}
          SELF.m_GroupList.m_Columns = loc_Columns
          ADD(SELF.m_GroupList,SELF.m_GroupList.m_Group)
        END
      END
    END
  END
!// Init initial column queue
  LOOP loc_LoopIndex = 1 TO RECORDS(SELF.m_ColumnList)
      GET(SELF.m_ColumnList,loc_LoopIndex)
      DISPOSE(SELF.m_ColumnList.m_Format)
      CLEAR(SELF.m_ColumnList)
  END
  FREE(SELF.m_ColumnList)
  LOOP loc_LoopIndex = 1 TO SELF.m_Columns
    CLEAR(SELF.m_ColumnList)
    SELF.m_ColumnList.m_Column  = loc_LoopIndex
    SELF.m_ColumnList.m_FieldNo = SELF.m_Control{PROPLIST:FieldNo,loc_LoopIndex}
    SELF.m_ColumnList.m_Width   = SELF.m_Control{PROPLIST:Width,loc_LoopIndex}
    SELF.m_ColumnList.m_Format &= NEW(STRING(LEN(SELF.m_Control{PROPLIST:Format,loc_LoopIndex})))
    SELF.m_ColumnList.m_Format  = SELF.m_Control{PROPLIST:Format,loc_LoopIndex}
!// Columns in the group
    loc_Columns = SELF.m_Control{PROPLIST:GroupNo + PROPLIST:Group,loc_LoopIndex}
    IF loc_Columns
      SELF.m_ColumnList.m_GroupNo = SELF.m_Control{PROPLIST:GroupNo,loc_LoopIndex}
    END
    loc_PoundPos = INSTRING('#',SELF.m_ColumnList.m_Format,1,1)
    SELF.m_ColumnList.m_StartPos = INSTRING(SELF.m_ColumnList.m_Format[1 : (loc_PoundPos - 1)],SELF.m_Format,1,1)
    ADD(SELF.m_ColumnList,SELF.m_ColumnList.m_Column)
    IF SELF.GetError(4)
      SELF.Kill(TRUE)
    END
  END
!##############################################################################
!#
!# NAME        : KILL
!# DESCRIPTION :  is a Format Manager object destructor
!# PARAMETERS  : No parameters
!# RETURNS     : No returned value
!#
!##############################################################################
ListFormatManagerClass.Kill              PROCEDURE(BYTE _Halt = FALSE)

loc_LoopIndex               SHORT,AUTO      ! Loop index

  CODE
  
  IF SELF.SaveFormat AND SELF.m_Inited = True AND _Halt = FALSE THEN
     SELF.UpdateCurrentFormat()
  END

  cls_Counter -= 1
  IF ~cls_Counter
    CLOSE(SELF.m_File)
  END
  IF SELF.m_Inited
    SELF.m_Inited = FALSE
    LOOP loc_LoopIndex = 1 TO SELF.m_Columns
      GET(SELF.m_ColumnList,loc_LoopIndex)
      DISPOSE(SELF.m_ColumnList.m_Format)
      CLEAR(SELF.m_ColumnList)
    END
    IF ~(SELF.m_ColumnList &= NULL)
      DISPOSE(SELF.m_ColumnList)
    END
    LOOP loc_LoopIndex = 1 TO SELF.m_Groups
      GET(SELF.m_GroupList,loc_LoopIndex)
      DISPOSE(SELF.m_GroupList.m_Header)
      DISPOSE(SELF.m_GroupList.m_Name)
      CLEAR(SELF.m_GroupList)
    END
    IF ~(SELF.m_GroupList &= NULL)
      DISPOSE(SELF.m_GroupList)
    END
    IF ~(SELF.m_Format &= NULL)
      DISPOSE(SELF.m_Format)
    END
    IF SELF.m_SavePos
      DISPOSE(SELF.m_INIFile)
    END
    IF SELF.m_UseTip
      IF ~(SELF.m_Tip &= NULL)
        DISPOSE(SELF.m_Tip)
      END
    END
    FREE(SELF.m_cls_Map)
    FREE(SELF.m_cls_PosList)
  END
  IF _Halt
    HALT(0,MESSAGE_HALT)
  END
ListFormatManagerClass.SetPopupChoice     PROCEDURE(<USHORT InitChoice>,USHORT LastChoice)
 CODE
 IF NOT OMITTED(2) THEN
    SELF.m_InitChoice=InitChoice
 END
 SELF.m_LastChoice=LastChoice
!##############################################################################
!#
!# NAME        : GETPOPUPTEXT
!# DESCRIPTION :  forms string of items for POPUP()
!# PARAMETERS  : [in] _Disable - Flag defining popup-menu disable status
!#             : [in] _PopupText - Previously generated popup menu string
!# RETURNS     : String for POPUP
!#
!##############################################################################
ListFormatManagerClass.MakePopup         PROCEDURE(                      |
                                      *STRING _PopupText,   |
                                      BYTE _Disable = FALSE |
                                     )

loc_PopupText               STRING(1024)    ! Buffer for popup string
loc_LoopIndex               SHORT,AUTO      ! Local loop index
loc_SortQueue               QUEUE,PRE()     ! Queue for sorting
FormatId                      SHORT         !
FormatName                    STRING(128)   !
                            END

  CODE
  IF ~SELF.m_Inited
    RETURN
  END
!// Bind file fields to an object
  SELF.BindFile()
  FREE(loc_SortQueue)
  CLEAR(SELF.m_File)
  cls_File.m_AppName= SELF.m_AppName
  cls_File.m_ProcId = SELF.m_ProcId
  cls_File.m_UserId = SELF.m_UserId
  cls_File.m_CtrlId = SELF.m_CtrlId
  SET(cls_File.m_Key,cls_File.m_Key)
  LOOP
    NEXT(SELF.m_File)
    IF ERRORCODE() THEN BREAK.
    IF cls_File.m_AppName<> SELF.m_AppName OR |
       cls_File.m_ProcId <> SELF.m_ProcId OR |
       cls_File.m_CtrlId <> SELF.m_CtrlId OR |
       cls_File.m_UserId <> SELF.m_UserId
      BREAK
    END
!// Fill sort queue
    CLEAR(loc_SortQueue)
    loc_SortQueue.FormatId   = cls_File.m_FormatId
    loc_SortQueue.FormatName = cls_File.m_FormatName
    DO ReplaceAmpersand
    ADD(loc_SortQueue)
  END

!// Use alphabetic sort
  IF SELF.m_Sort = SORT_ALPHA
    SORT(loc_SortQueue,loc_SortQueue.FormatName)
  END

  IF _PopupText
!// If edit menu is present separate "format" popup menu
    loc_PopupText = '|-|'
  ELSE
!// ... else clear
    loc_PopupText = ''
  END

!// Disable menu
  IF _Disable
    loc_PopupText = CLIP(loc_PopupText) & '~'
  END

!// Gather menu items
  loc_PopupText = CLIP(loc_PopupText) & POPUP_NAME_MAIN & '{{'
  FREE(SELF.m_cls_Map)
  LOOP loc_LoopIndex = 1 TO RECORDS(loc_SortQueue)
    GET(loc_SortQueue,loc_LoopIndex)
!// Fill mapping queue
    CLEAR(SELF.m_cls_Map)
    SELF.m_cls_Map.Choice = loc_LoopIndex
    SELF.m_cls_Map.Id     = loc_SortQueue.FormatId
    ADD(SELF.m_cls_Map,SELF.m_cls_Map.Choice)
    IF SELF.m_cls_Map.Id = SELF.m_LastId
      loc_PopupText = CLIP(loc_PopupText) & '+'
    END
    loc_PopupText = CLIP(loc_PopupText) & CLIP(loc_SortQueue.FormatName) & '|'
  END
  loc_PopupText = CLIP(loc_PopupText) & '-|' & POPUP_NAME_SETUP & '}'

!// Initial List Format Manager choice number
  SELF.m_InitChoice = SELF.GetMaxChoices() + 1

!// Make result popup menu
  _PopupText = CLIP(_PopupText) & CLIP(loc_PopupText)
!------------------------------------------------------------------------------
! NAME        : REPLACEAMPERSAND
! DESCRIPTION : The given routine perfoms a terminating code
!------------------------------------------------------------------------------
ReplaceAmpersand            ROUTINE

  DATA

rou_Pos                     LONG,DIM(2)

  CODE
  rou_Pos[2] = 1
  LOOP
    rou_Pos[1] = INSTRING(' & ',loc_SortQueue.FormatName,1,rou_Pos[2])
    IF rou_Pos[1]
      rou_Pos[2] = rou_Pos[1] + 2
      loc_SortQueue.FormatName = loc_SortQueue.FormatName[1 : rou_Pos[1]] & '&&' & |
                                 loc_SortQueue.FormatName[rou_Pos[2] : LEN(CLIP(loc_SortQueue.FormatName))]
    ELSE
      BREAK
    END
  END
!##############################################################################
!#
!# NAME        : GETMAXCHOICES
!# DESCRIPTION :  counts and returns quantity of popup items
!# PARAMETERS  : No parameters
!# RETURNS     : Quantity of POPUP-items
!#
!##############################################################################
ListFormatManagerClass.GetMaxChoices     PROCEDURE

loc_LoopIndex               SHORT,AUTO      ! Loop index
loc_MaxChoices              SIGNED(0)       ! Maximum number of choices
loc_NoChoices               SIGNED(0)       ! Flag if choice isn't selective
loc_TextLen                 LONG,AUTO       ! Popup text length

  CODE
  IF SELF.m_LastChoice THEN
     RETURN SELF.m_LastChoice
  END
  loc_TextLen = LEN(CLIP(SELF.m_PopupText))
  IF ~loc_TextLen
    RETURN(loc_MaxChoices)
  END
!// Check for empty popup menu
  IF loc_TextLen = 1
    IF ~INLIST(SELF.m_PopupText[1],'-','|')
      loc_MaxChoices = 1
    END
    RETURN(loc_MaxChoices)
  END
!// Clip extreme symbols '|'
  IF SELF.m_PopupText[1] = '|'
    SELF.m_PopupText = SELF.m_PopupText[2 : loc_TextLen]
    loc_TextLen = LEN(CLIP(SELF.m_PopupText))
  END
  IF SELF.m_PopupText[loc_TextLen] = '|'
    SELF.m_PopupText = SELF.m_PopupText[1 : (loc_TextLen - 1)]
    loc_TextLen = LEN(CLIP(SELF.m_PopupText))
  END
!// Count maximum choices
  LOOP loc_LoopIndex = 1 TO loc_TextLen
    IF SELF.m_PopupText[loc_LoopIndex] = '|'
      loc_MaxChoices += 1
    END
  END
  IF loc_MaxChoices = loc_TextLen
    loc_MaxChoices = 0
  ELSE
    loc_MaxChoices += 1
    LOOP loc_LoopIndex = 1 TO loc_TextLen
      IF SELF.m_PopupText[loc_LoopIndex] = '-'
        IF loc_LoopIndex = 1
          IF SELF.m_PopupText[loc_LoopIndex + 1] = '|'
            loc_NoChoices += 1
          END
        ELSE
          IF SELF.m_PopupText[loc_LoopIndex - 1] = '|'
            loc_NoChoices += 1
          END
        END
      END
    END
    loc_MaxChoices -= loc_NoChoices
  END
  RETURN(loc_MaxChoices)
!##############################################################################
!#
!# NAME        : DISPATCHCHOICE
!# DESCRIPTION :  dispatches a POPUP choice to Format Manager
!# PARAMETERS  : [in] _Choice - Choice which user selected using popup-menu
!# RETURNS     : No returned value
!#
!##############################################################################
ListFormatManagerClass.DispatchChoice    PROCEDURE(SIGNED _Choice)
ReturnValue BYTE
  CODE
!// Disable popup appearing
  ReturnValue = False
  SETKEYCODE(0) 
!// If no choice then return
  IF ~_Choice
    RETURN ReturnValue
  END

!// If choice not in range then return
  IF NOT(SELF.m_InitChoice<=_Choice AND _Choice<=SELF.GetMaxChoices())
     RETURN ReturnValue
  END

!// Bind file fields to an object
  SELF.BindFile()
!// "Setup" item?
  IF _Choice = SELF.GetMaxChoices()
    SELF.RefreshColumnsWidth()
    SELF.BrowseFormat()
  ELSE
!// The real choice
    SELF.m_cls_Map.Choice = _Choice - SELF.m_InitChoice + 1
    GET(SELF.m_cls_Map,SELF.m_cls_Map.Choice)
    IF SELF.GetError(100)
      RETURN ReturnValue
    END
    SELF.m_LastId = SELF.m_cls_Map.Id
!// Set new current format
    SELF.SetCurrentFormat(SELF.m_LastId)
    SELF.m_ForceRefresh = TRUE
  END
!// Apply current format
  IF SELF.m_ForceRefresh
    SELF.m_ForceRefresh = FALSE
    ReturnValue = True
    SELF.UpdateFormat(SELF.GetFormat(FORMAT_CURRENT))
  END
  RETURN ReturnValue
!##############################################################################
!#
!# NAME        : SETUPFORMAT
!# DESCRIPTION : launches format setup utility
!# PARAMETERS  : No parameters
!# RETURNS     : No returned value
!#
!##############################################################################
ListFormatManagerClass.BrowseFormat      PROCEDURE

loc_Choice                  SHORT(1)        ! Current choice in LIST
loc_PopupText               STRING(255)     ! Buffer for popup text
loc_Message                 STRING(255)     ! Message for deleting
loc_DisableSign             STRING(1)       ! Popup disable sign ~
loc_ListQueue               QUEUE,PRE()     ! Queue for list format browsing
loc_Name                      STRING(128)   ! Name of a list
loc_Position                  STRING(512)   ! Position in the file
                            END
loc_HighlightPosition       STRING(512)     ! Highlighted position
loc_SaveFormat              BYTE
browse_window WINDOW('List Format Setup'),AT(,,216,164),FONT('MS Sans Serif',8,,),CENTER,SYSTEM,GRAY, |
         DOUBLE
       GROUP('&List Formats'),AT(4,2,156,156),USE(?grp_ListQueue),BOXED
         LIST,AT(10,12,144,140),USE(?List),VSCROLL,ALRT(MouseLeft2),ALRT(MouseRight),FORMAT('120L(1)|F@s30@'), |
             FROM(loc_ListQueue)
       END
       BUTTON('&Insert'),AT(164,6,48,14),USE(?btn_Insert),KEY(InsertKey)
       BUTTON('&Change'),AT(164,22,48,14),USE(?btn_Change),KEY(CtrlEnter)
       BUTTON('&Delete'),AT(164,38,48,14),USE(?btn_Delete),KEY(DeleteKey)
       BUTTON('A&pply'),AT(164,54,48,14),USE(?btn_Apply),KEY(EnterKey)
       PANEL,AT(164,72,48,1),USE(?Separator1),BEVEL(-1)
       BUTTON('Delete &All'),AT(164,76,48,14),USE(?btn_DeleteAll),KEY(CtrlDelete)
       PANEL,AT(164,94,48,1),USE(?Separator2),BEVEL(-1)
       BUTTON('Cl&ose'),AT(164,98,48,14),USE(?btn_Close)
     END

  CODE
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  OPEN(browse_window)
  DO SetupWindow
  DO RefreshList
  ACCEPT
    CASE FIELD()
    OF ?List
      CASE EVENT()
      OF EVENT:PreAlertKey
        CASE KEYCODE()
        OF MouseRight
          IF RECORDS(loc_ListQueue)
            SETKEYCODE(0)
            CYCLE
          END
        END
      OF EVENT:AlertKey
        CASE KEYCODE()
        OF MouseRight
          DO ProcessPopup
        OF MouseLeft2
          POST(EVENT:Accepted,?btn_Change)
        END
      OF EVENT:NewSelection
        IF ~RECORDS(loc_ListQueue)
          CYCLE
        END
        loc_Choice = CHOICE(?List)
        GET(loc_ListQueue,loc_Choice)
        IF ~ERRORCODE()
          REGET(cls_File.m_Key,loc_ListQueue.loc_Position)
          IF SELF.GetError(7)
            DO ProcedureReturn
          END
        END
        CASE KEYCODE() 
        OF MouseRight
          DO ProcessPopup
        END
      END
    OF ?btn_Insert
      CASE EVENT()
      OF EVENT:Accepted
        SELF.EditFormat(InsertRecord)
        loc_HighlightPosition = POSITION(cls_File.m_Key)
        DO RefreshList
      END
    OF ?btn_Change
      CASE EVENT()
      OF EVENT:Accepted
        SELF.EditFormat(ChangeRecord)
        loc_HighlightPosition = POSITION(cls_File.m_Key)
        DO RefreshList
      END
    OF ?btn_Delete
      CASE EVENT()
      OF EVENT:Accepted
        loc_Message = MESSAGE_DELETE
        ReplaceMacro('%FormatName%',cls_File.m_FormatName,loc_Message)
        IF MESSAGE(CLIP(loc_Message),MESSAGE_TITLE,ICON:Question,MESSAGE_BTNYESNO,2) = 1
          DELETE(SELF.m_File)
          IF SELF.GetError(8) 
            DO ProcedureReturn
          END
!// If current format was deleted
          IF cls_File.m_FormatId = SELF.m_LastId
            IF SELF.GetFormat(FORMAT_DEFAULT)
              cls_File.m_Flag = BOR(cls_File.m_Flag,FORMAT_CURRENT)
              PUT(SELF.m_File)
              IF SELF.GetError(9)
                DO ProcedureReturn
              END
            END
!// Set default fotmat to current
            SELF.m_LastId = 1
            SELF.m_ForceRefresh = TRUE
          END
          loc_Choice -= 1
        END
        DO RefreshList
      END
    OF ?btn_DeleteAll
      CASE EVENT()
      OF EVENT:Accepted
        IF MESSAGE(MESSAGE_DELETEALL,MESSAGE_TITLE,ICON:Question,MESSAGE_BTNYESNO,2) = 1
          CLEAR(SELF.m_File)
          cls_File.m_AppName= SELF.m_AppName
          cls_File.m_ProcId = SELF.m_ProcId
          cls_File.m_UserId = SELF.m_UserId
          cls_File.m_CtrlId = SELF.m_CtrlId
          SET(cls_File.m_Key,cls_File.m_Key)
          LOOP
            NEXT(SELF.m_File)
            IF ERRORCODE() THEN BREAK.
            IF cls_File.m_AppName<> SELF.m_AppName OR |
               cls_File.m_ProcId <> SELF.m_ProcId OR |
               cls_File.m_CtrlId <> SELF.m_CtrlId OR |
               cls_File.m_UserId <> SELF.m_UserId
              BREAK
            END
            IF BAND(cls_File.m_Flag,FORMAT_DEFAULT)
              cls_File.m_Flag = BOR(cls_File.m_Flag,FORMAT_CURRENT)
              PUT(SELF.m_File)
              IF SELF.GetError(10)
                CYCLE
              END
!// Set default fotmat to current
              SELF.m_LastId = 1
              SELF.m_ForceRefresh = TRUE
              CYCLE
            END
!// Delete all records beside "default" format
            DELETE(SELF.m_File)
            IF SELF.GetError(11)
              DO ProcedureReturn
            END
          END
          loc_Choice = 1
        END
        DO RefreshList
      END
    OF ?btn_Apply
      CASE EVENT()
      OF EVENT:Accepted
        SELF.m_LastId = cls_File.m_FormatId
        loc_SaveFormat=SELF.SaveFormat
        SELF.SaveFormat=False
        SELF.SetCurrentFormat(SELF.m_LastId)
        SELF.SaveFormat=loc_SaveFormat
        SELF.m_ForceRefresh = TRUE
        POST(EVENT:CloseWindow)
      END
    OF ?btn_Close
      CASE EVENT()
      OF EVENT:Accepted
        POST(EVENT:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!------------------------------------------------------------------------------
! NAME        : PROCEDURERETURN
! DESCRIPTION : termination code
!------------------------------------------------------------------------------
ProcedureReturn             ROUTINE

  FREE(loc_ListQueue)
  IF SELF.m_SavePos
    PUTINI('List Format Manager','browse_x',browse_window{PROP:XPos},SELF.m_INIFile)
    PUTINI('List Format Manager','browse_y',browse_window{PROP:YPos},SELF.m_INIFile)
  END
  CLOSE(browse_window)
!------------------------------------------------------------------------------
! NAME        : PROCESSPOPUP
! DESCRIPTION : processes edit popup menu
!------------------------------------------------------------------------------
ProcessPopup                ROUTINE
  DATA
loc_pop SHORT
  CODE
  IF RECORDS(loc_ListQueue)
    loc_DisableSign = ''
  ELSE
    loc_DisableSign = '~'
  END
  loc_PopupText = CHOOSE(NOT SELF.AllowAdd,'',BROWSE_BTNINSERT & '|') & |
                  CHOOSE(NOT SELF.AllowChange,'',CLIP(loc_DisableSign)  & BROWSE_BTNCHANGE & '|') & |
                  CHOOSE(NOT SELF.AllowDelete,'',CLIP(loc_DisableSign)  & BROWSE_BTNDELETE & '|') & |
                  CHOOSE(NOT (SELF.AllowAdd OR SELF.AllowChange OR SELF.AllowDelete),'','-'& '|') & |
                  CLIP(loc_DisableSign)  & BROWSE_BTNAPPLY   & |
                  CHOOSE(NOT SELF.AllowDelete,'','|-'        & '|') & |
                  CHOOSE(NOT SELF.AllowDelete,'',CLIP(loc_DisableSign)  & BROWSE_BTNDELETEALL)
  loc_pop = POPUP(loc_PopupText)
  IF NOT SELF.AllowAdd    THEN
     loc_pop +=1
  END
  IF NOT SELF.AllowChange THEN
     loc_pop +=1
  END
  IF NOT SELF.AllowDelete THEN
     loc_pop +=1
  END
  EXECUTE(loc_pop)
    POST(EVENT:Accepted,?btn_Insert)
    POST(EVENT:Accepted,?btn_Change)
    POST(EVENT:Accepted,?btn_Delete)
    POST(EVENT:Accepted,?btn_Apply)
    POST(EVENT:Accepted,?btn_DeleteAll)
  END
!------------------------------------------------------------------------------
! NAME        : SETUPWINDOW
! DESCRIPTION : customizes the window
!------------------------------------------------------------------------------
SetupWindow                 ROUTINE

  browse_window{PROP:Text}  = BROWSE_TITLE
  ?grp_ListQueue{PROP:Text} = BROWSE_GROUPPROMPT
  ?btn_Insert{PROP:Text}    = BROWSE_BTNINSERT
  ?btn_Change{PROP:Text}    = BROWSE_BTNCHANGE
  ?btn_Delete{PROP:Text}    = BROWSE_BTNDELETE
  ?btn_DeleteAll{PROP:Text} = BROWSE_BTNDELETEALL
  ?btn_Apply{PROP:Text}     = BROWSE_BTNAPPLY
  ?btn_Close{PROP:Text}     = BROWSE_BTNCLOSE
  ?List{PROP:LineHeight}    = ?List{PROP:FontSize} + 2
!// Set the icon and remove minimize box
  IF SELF.m_SavePos
    browse_window{PROP:XPos} = GETINI('List Format Manager','browse_x',browse_window{PROP:XPos},SELF.m_INIFile)
    browse_window{PROP:YPos} = GETINI('List Format Manager','browse_y',browse_window{PROP:YPos},SELF.m_INIFile)
  END
  IF NOT SELF.AllowAdd    THEN
     HIDE(?btn_Insert)
  END
  IF NOT SELF.AllowDelete THEN
     HIDE(?btn_Delete)
     HIDE(?btn_DeleteAll)
  END
  IF NOT SELF.AllowChange THEN
     HIDE(?btn_Change)
  END

!------------------------------------------------------------------------------
! NAME        : REFRESHLIST
! DESCRIPTION : refreshes current state of available formats
!------------------------------------------------------------------------------
RefreshList                 ROUTINE

  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  FREE(loc_ListQueue)
  CLEAR(SELF.m_File)
  cls_File.m_AppName= SELF.m_AppName
  cls_File.m_ProcId = SELF.m_ProcId
  cls_File.m_UserId = SELF.m_UserId
  cls_File.m_CtrlId = SELF.m_CtrlId
  SET(cls_File.m_Key,cls_File.m_Key)
  LOOP
    NEXT(SELF.m_File)
    IF ERRORCODE() THEN BREAK.
    IF cls_File.m_AppName<> SELF.m_AppName OR |
       cls_File.m_ProcId <> SELF.m_ProcId OR |
       cls_File.m_CtrlId <> SELF.m_CtrlId OR |
       cls_File.m_UserId <> SELF.m_UserId
      BREAK
    END
    IF BAND(cls_File.m_Flag,FORMAT_DEFAULT)
      CYCLE
    END
    CLEAR(loc_ListQueue)
    loc_ListQueue.loc_Name = cls_File.m_FormatName
    loc_ListQueue.loc_Position = POSITION(cls_File.m_Key)
    ADD(loc_ListQueue,loc_ListQueue.loc_Name)
    IF loc_ListQueue.loc_Position = loc_HighlightPosition
      loc_Choice = POINTER(loc_ListQueue)
    END
  END
  SELF.m_FormatCount = RECORDS(loc_ListQueue)
  IF SELF.m_FormatCount
    ENABLE(?btn_Change,?btn_DeleteAll)
  ELSE
    DISABLE(?btn_Change,?btn_DeleteAll)
  END
  SELECT(?List,loc_Choice)
  POST(EVENT:NewSelection,?List)
!##############################################################################
!# NAME        : EDITFORMAT
!# DESCRIPTION : launches format setup form
!# PARAMETERS  : [in] _Action - Action with a config file
!# RETURNS     : Result of config file operation
!##############################################################################
ListFormatManagerClass.EditFormat        PROCEDURE(BYTE _Action)

loc_Completed               BYTE(0)         ! Completition flag
loc_LoopIndex               SHORT,AUTO      ! Loop index
loc_Choice                  SHORT,AUTO      ! Current LIST choice
loc_RealChoice              SHORT,AUTO      ! The real column number
loc_EmptyColumns            SHORT,AUTO      ! Quantity with unchecked status
loc_PopupText               STRING(128)     ! Popup string for marking
loc_DroppedColumn           SIGNED(1)       ! Dropped row (column)
loc_Direction               BYTE            ! Moving direction
loc_Format                  STRING(8192)    ! Local buffer for format string
loc_VarLine                 STRING(8192)    ! Local buffer for variable line
loc_ColumnQueue             QUEUE,PRE()     ! Queue for list column browsing
loc_ColName                   STRING(30)    ! Name of a column
loc_ColMark                   STRING(3)     ! Field for marking area
loc_ColIcon                   SHORT         ! Mark icon
loc_ColFormat                 STRING(1024)  ! Column format
loc_ColVar                    STRING(1024)  ! Column variable
loc_ColField                  SHORT         ! Column field number
loc_ColGroup                  SHORT         ! Group number of column 
loc_ColOrder                  SHORT         ! Order number in the group
loc_ColRows                   SHORT         ! Rows to move
                            END
loc_ColumnQueue2            QUEUE(loc_ColumnQueue)
                            END             ! Clone of the source queue
loc_ListName                STRING(60)      ! Entry for list name
loc_LowNumber               SHORT           ! Low range column
loc_HighNumber              SHORT           ! High range column
loc_RowsToMove              SHORT           ! Quantity of rows to move
loc_MovedRows               SHORT           ! Quantity of rows to be moved
loc_Pointer                 LONG,AUTO       ! Current queue pointer
loc_PrevHeight              LONG,AUTO       ! Previous window height
loc_ForceChange             BYTE(1)         ! Force column width changing
loc_ListHeight              LONG,AUTO       ! Height of list
loc_IconStatus              BYTE,AUTO       ! Icon status for joint icons
loc_GroupWidth              SHORT,AUTO      ! Width of the group
loc_Width                   SHORT,AUTO      ! Width of the column
edit_window WINDOW('Change List Format'),AT(,,215,164),FONT('MS Sans Serif',8,,),CENTER,IMM,SYSTEM,GRAY, |
         DOUBLE
       GROUP('Settings'),AT(4,2,156,156),USE(?ColumnGroup),BOXED
         PROMPT('&Name:'),AT(10,14),USE(?loc_ListName:Prompt)
         ENTRY(@s30),AT(10,24,144,12),USE(loc_ListName),REQ,OVR
         PROMPT('&Columns:'),AT(10,42),USE(?ColumnList:Prompt)
         LIST,AT(10,52,144,100),USE(?ColumnList),VSCROLL,ALRT(MouseLeft2),FORMAT('117L(1)|F~Name~L(2)@s40@16C|FI~On~@s3@'), |
             FROM(loc_ColumnQueue),DRAGID('lfm'),DROPID('lfm')
       END
       BUTTON('&Save'),AT(164,6,48,14),USE(?btn_Save),DEFAULT,REQ
       BUTTON('Cancel'),AT(164,22,48,14),USE(?btn_Cancel)
       PANEL,AT(164,40,48,1),USE(?Separator),BEVEL(-1)
       BUTTON('7'),AT(164,44,12,14),USE(?btn_First),FONT('Webdings',10,,),TIP('Move column to first')
       BUTTON('3'),AT(176,44,12,14),USE(?btn_Up),FONT('Webdings',10,,),TIP('Move column to left')
       BUTTON('4'),AT(188,44,12,14),USE(?btn_Down),FONT('Webdings',10,,),TIP('Move column to right')
       BUTTON('8'),AT(200,44,12,14),USE(?btn_Last),FONT('Webdings',10,,),TIP('Move column to last')
       LIST,AT(168,105,214,28),USE(?DummyList),HIDE,TIP('Dummy listbox for FORMAT')
     END

  CODE
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  OPEN(edit_window)
  DO BuildSetupList
  DO SetupWindow


  Do RefreshListbox

  DISPLAY
  ACCEPT
    CASE EVENT()
    OF EVENT:Completed
      CASE _Action
      OF InsertRecord
!// New format will be added
        CLEAR(SELF.m_File)
        cls_File.m_AppName    = SELF.m_AppName
        cls_File.m_ProcId     = SELF.m_ProcId
        cls_File.m_UserId     = SELF.m_UserId
        cls_File.m_CtrlId     = SELF.m_CtrlId
        cls_File.m_FormatId   = SELF.m_FormatCount + 2
        cls_File.m_FormatName = loc_ListName
        cls_File.m_Flag       = 0
        cls_File.m_Format     = ?DummyList{PROP:Format}
        cls_File.m_VarLine    = loc_VarLine
        ADD(SELF.m_File)
        IF SELF.GetError(12)
          DO ProcedureReturn
        END
      OF ChangeRecord
!// Selected format will be changed
        cls_File.m_FormatName = loc_ListName
        cls_File.m_Format     = ?DummyList{PROP:Format}
        cls_File.m_VarLine    = loc_VarLine
        PUT(SELF.m_File)
        IF SELF.GetError(13)
          DO ProcedureReturn
        END
!// Arm the refreshing flag, if current format was changed
        IF cls_File.m_FormatId = SELF.m_LastId
          SELF.m_ForceRefresh = TRUE
        END
      END
      loc_Completed = TRUE
      POST(EVENT:CloseWindow)
    END
    CASE FIELD()
    OF ?ColumnList
      CASE EVENT()
      OF EVENT:Drop
        loc_DroppedColumn = ?ColumnList{PROPLIST:MouseMoveRow,1}
        DO MoveColumn
      OF EVENT:NewSelection
        DO GetColumn
        loc_DroppedColumn = loc_Choice
        CASE KEYCODE()
        OF MouseRight
          DO ProcessPopup
        END
      OF EVENT:AlertKey
        CASE KEYCODE() 
        OF MouseLeft2
!// Action only for "On" field
          IF ?ColumnList{PROPLIST:MouseDownField} <> 2
            CYCLE
          END
          GET(loc_ColumnQueue,loc_Choice)
!// If the current choice is the end of group
          IF ~loc_ColumnQueue.loc_ColIcon
            CYCLE
          END
          DO ChangeColumnStatus
          Do RefreshListbox
        END
        IF KEYCODE() = MouseRight
          SETKEYCODE(0)
        END
      END
    OF ?btn_Up
      CASE EVENT()
      OF EVENT:Accepted
        loc_Direction = DIR_UP
        IF loc_DroppedColumn > 1
          loc_DroppedColumn -= 1
          DO MoveColumn
        END
      END
    OF ?btn_Down
      CASE EVENT()
      OF EVENT:Accepted
        loc_Direction = DIR_DOWN
        IF loc_DroppedColumn < RECORDS(loc_ColumnQueue)
          loc_DroppedColumn += 1
          DO MoveColumn
        END
      END
    OF ?btn_First
      CASE EVENT()
      OF EVENT:Accepted
        loc_Direction = DIR_FIRST
        loc_DroppedColumn = loc_LowNumber
        DO MoveColumn
      END
    OF ?btn_Last
      CASE EVENT()
      OF EVENT:Accepted
        loc_Direction = DIR_LAST
        loc_DroppedColumn = loc_HighNumber
        DO MoveColumn
      END
    OF ?btn_Save
      CASE EVENT()
      OF EVENT:Accepted
        IF INRANGE(_Action,InsertRecord,ChangeRecord)
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
      END
    OF ?btn_Cancel
      CASE EVENT()
      OF EVENT:Accepted
        POST(EVENT:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!------------------------------------------------------------------------------
! NAME        : RefreshListbox
! DESCRIPTION : changes current column status
!------------------------------------------------------------------------------
RefreshListbox              ROUTINE
  DATA

rou_LoopIndex2              SHORT,AUTO           ! Local loop index
rou_LoopIndex               SHORT,AUTO           ! Local loop index
rou_Choice                  SHORT(0)
LastGroup                   SHORT(0)
LastGroupWidth              SHORT(0)
OmitGroup                   BYTE(0)
  CODE
  IF NOT (_Action=InsertRecord OR (_Action=ChangeRecord AND cls_File.m_FormatId = SELF.m_LastId)) THEN
     EXIT
  END
  loc_RealChoice = 0
  LOOP rou_LoopIndex = 1 TO RECORDS(loc_ColumnQueue)
     GET(loc_ColumnQueue,rou_LoopIndex)
     IF loc_ColumnQueue.loc_ColRows = 0
        IF LastGroup THEN
           SELF.m_GroupList.m_Group = LastGroup
           GET(SELF.m_GroupList,SELF.m_GroupList.m_Group)
           LastGroupWidth=0
           LastGroup = 0
           OmitGroup = 0
        END
        CYCLE
     END
     IF loc_ColumnQueue.loc_ColGroup !Is a group or inside a group
        IF loc_ColumnQueue.loc_ColRows > 1  !IS a group header
           LastGroup=loc_ColumnQueue.loc_ColGroup
           LastGroupWidth=0
           IF loc_ColumnQueue.loc_ColIcon<>COLUMN_SHOW THEN
              OmitGroup = True
           END
        ELSE
           loc_RealChoice += 1
           SELF.m_ColumnList.m_Column = loc_ColumnQueue.loc_ColField
           GET(SELF.m_ColumnList,SELF.m_ColumnList.m_Column)
           IF OmitGroup=False AND loc_ColumnQueue.loc_ColIcon=COLUMN_SHOW THEN
              IF ?DummyList{PROPLIST:Width,loc_RealChoice} THEN
                 ?DummyList{PROPLIST:Width,loc_RealChoice} = SELF.m_ColumnList.m_Width
                 LastGroupWidth+=SELF.m_ColumnList.m_Width
              END
           ELSE
              ?DummyList{PROPLIST:Width,loc_RealChoice} = 0
           END
        END
     ELSE
        loc_RealChoice += 1
        SELF.m_ColumnList.m_Column = loc_ColumnQueue.loc_ColField
        GET(SELF.m_ColumnList,SELF.m_ColumnList.m_Column)
        IF loc_ColumnQueue.loc_ColIcon=COLUMN_SHOW THEN
           IF ?DummyList{PROPLIST:Width,loc_RealChoice} THEN
              ?DummyList{PROPLIST:Width,loc_RealChoice} = SELF.m_ColumnList.m_Width
           END
        ELSE
           ?DummyList{PROPLIST:Width,loc_RealChoice} = 0
        END
     END
  END

!------------------------------------------------------------------------------
! NAME        : CHANGECOLUMNSTATUS
! DESCRIPTION : changes current column status
!------------------------------------------------------------------------------
ChangeColumnStatus          ROUTINE

  CASE loc_ColumnQueue.loc_ColIcon
  OF COLUMN_SHOW
    loc_ColumnQueue.loc_ColIcon = COLUMN_HIDE
    IF SELF.m_Check = CHECK_TEXT
      loc_ColumnQueue.loc_ColMark = '-'
    END
    DO GetRealColumn
    IF loc_ColumnQueue.loc_ColGroup
      IF loc_ColumnQueue.loc_ColRows > 1
        ?DummyList{PROPLIST:Width + PROPLIST:Group,loc_RealChoice} = 0
      ELSE
        ?DummyList{PROPLIST:Width,loc_RealChoice} = 0
      END
    ELSE
      ?DummyList{PROPLIST:Width,loc_RealChoice} = 0
    END
  OF COLUMN_HIDE
    loc_ColumnQueue.loc_ColIcon = COLUMN_SHOW
    IF SELF.m_Check = CHECK_TEXT
      loc_ColumnQueue.loc_ColMark = 'Yes'
    END
    DO GetRealColumn
    IF loc_ColumnQueue.loc_ColGroup
      IF loc_ColumnQueue.loc_ColRows > 1
        SELF.m_GroupList.m_Group = loc_ColumnQueue.loc_ColGroup
        GET(SELF.m_GroupList,SELF.m_GroupList.m_Group)
        ?DummyList{PROPLIST:Width + PROPLIST:Group,loc_RealChoice} = SELF.m_GroupList.m_Width
      ELSE
        SELF.m_ColumnList.m_Column = loc_Choice
        GET(SELF.m_ColumnList,SELF.m_ColumnList.m_Column)
        ?DummyList{PROPLIST:Width,loc_RealChoice} = SELF.m_ColumnList.m_Width
      END
    ELSE
      SELF.m_ColumnList.m_Column = loc_Choice
      GET(SELF.m_ColumnList,SELF.m_ColumnList.m_Column)
      ?DummyList{PROPLIST:Width,loc_RealChoice} = SELF.m_ColumnList.m_Width
    END
  END
  PUT(loc_ColumnQueue)
!// The column is a group header
  IF loc_ColumnQueue.loc_ColGroup AND loc_ColumnQueue.loc_ColRows > 1
    loc_IconStatus = loc_ColumnQueue.loc_ColIcon
    DO SetJointIconsStatus
  END
  DO CheckLastColumn
  SELECT(?ColumnList,loc_DroppedColumn)
  POST(EVENT:NewSelection,?ColumnList)
!------------------------------------------------------------------------------
! NAME        : GETREALCOLUMN
! DESCRIPTION : defines the real column number
!------------------------------------------------------------------------------
GetRealColumn               ROUTINE

  DATA

rou_LoopIndex               SHORT,AUTO           ! Local loop index
rou_Choice                  SHORT(0)             

  CODE
  LOOP loc_RealChoice = 1 TO RECORDS(loc_ColumnQueue2)
    GET(loc_ColumnQueue2,loc_RealChoice)
    IF loc_ColumnQueue2.loc_ColRows > 1 OR loc_ColumnQueue2.loc_ColRows = 0
      CYCLE
    END
    rou_Choice += 1
    IF loc_ColumnQueue2.loc_ColField = loc_ColumnQueue.loc_ColField
      loc_RealChoice = rou_Choice
      BREAK
    END
  END
!------------------------------------------------------------------------------
! NAME        : SETJOINTICONSSTATUS
! DESCRIPTION : sets dimmed status for columns that are 
!               inside of switched off group.
!------------------------------------------------------------------------------
SetJointIconsStatus         ROUTINE

  DATA

rou_SavedPointer            UNSIGNED,AUTO
rou_LoopIndex               SHORT,AUTO
rou_SavedGroup              SHORT,AUTO

  CODE
  rou_SavedPointer = POINTER(loc_ColumnQueue)
  rou_SavedGroup = loc_ColumnQueue.loc_ColGroup
  LOOP loc_LoopIndex = rou_SavedPointer + 1 TO RECORDS(loc_ColumnQueue)
    GET(loc_ColumnQueue,loc_LoopIndex)
    IF loc_ColumnQueue.loc_ColGroup = rou_SavedGroup
      IF loc_ColumnQueue.loc_ColRows
        CASE loc_IconStatus
        OF COLUMN_SHOW
!// The column is visible
          IF loc_ColumnQueue.loc_ColIcon = COLUMN_HIDE_DIM
            loc_ColumnQueue.loc_ColIcon = COLUMN_HIDE
            IF SELF.m_Check = CHECK_TEXT
              loc_ColumnQueue.loc_ColMark = '-'
            END
          ELSIF loc_ColumnQueue.loc_ColIcon = COLUMN_SHOW_DIM
            loc_ColumnQueue.loc_ColIcon = COLUMN_SHOW
            IF SELF.m_Check = CHECK_TEXT
              loc_ColumnQueue.loc_ColMark = 'Yes'
            END
          END
        OF COLUMN_HIDE
!// The column is invisible
          IF loc_ColumnQueue.loc_ColIcon = COLUMN_HIDE
            loc_ColumnQueue.loc_ColIcon = COLUMN_HIDE_DIM
            IF SELF.m_Check = CHECK_TEXT
              loc_ColumnQueue.loc_ColMark = '*'
            END
          ELSIF loc_ColumnQueue.loc_ColIcon = COLUMN_SHOW
            loc_ColumnQueue.loc_ColIcon = COLUMN_SHOW_DIM
            IF SELF.m_Check = CHECK_TEXT
              loc_ColumnQueue.loc_ColMark = '*'
            END
          END
        END
        PUT(loc_ColumnQueue)
      ELSE
        BREAK
      END
    END
  END
  GET(loc_ColumnQueue,rou_SavedPointer)
!------------------------------------------------------------------------------
! NAME        : PROCESSPOPUP
! DESCRIPTION : processes edit popup menu
!------------------------------------------------------------------------------
ProcessPopup                ROUTINE

  CLEAR(loc_PopupText)
  CASE loc_ColumnQueue.loc_ColIcon 
  OF COLUMN_SHOW
    loc_PopupText = EDIT_RESETMARK
  OF COLUMN_HIDE
    loc_PopupText = EDIT_SETMARK
  ELSE
!// If the current choice is an end of group
    EXIT
  END
  loc_PopupText = CLIP(loc_PopupText) & '|-|'
  IF ?btn_First{PROP:Disable}
    loc_PopupText = CLIP(loc_PopupText) & '~'
  END
  loc_PopupText = CLIP(loc_PopupText) & EDIT_MOVEFIRST & '|'
  IF ?btn_Up{PROP:Disable}
    loc_PopupText = CLIP(loc_PopupText) & '~'
  END
  loc_PopupText = CLIP(loc_PopupText) & EDIT_MOVEUP & '|'
  IF ?btn_Down{PROP:Disable}
    loc_PopupText = CLIP(loc_PopupText) & '~'
  END
  loc_PopupText = CLIP(loc_PopupText) & EDIT_MOVEDOWN & '|'
  IF ?btn_Last{PROP:Disable}
    loc_PopupText = CLIP(loc_PopupText) & '~'
  END
  loc_PopupText = CLIP(loc_PopupText) & EDIT_MOVELAST
  EXECUTE POPUP(loc_PopupText)
    BEGIN
!// Only for icon field
      ?ColumnList{PROPLIST:MouseDownField} = 2
      SETKEYCODE(MouseLeft2)
      POST(EVENT:AlertKey,?ColumnList)
    END
    POST(EVENT:Accepted,?btn_First)
    POST(EVENT:Accepted,?btn_Up)
    POST(EVENT:Accepted,?btn_Down)
    POST(EVENT:Accepted,?btn_Last)
  END
!------------------------------------------------------------------------------
! NAME        : SETUPWINDOW
! DESCRIPTION : customizes the window
!------------------------------------------------------------------------------
SetupWindow                 ROUTINE

  CASE _Action
  OF InsertRecord
    loc_ListName = 'New List ' & SELF.m_FormatCount + 1
    edit_window{PROP:Text} = EDIT_TITLE_INSERT
  OF ChangeRecord
    loc_ListName = cls_File.m_FormatName
    edit_window{PROP:Text} = EDIT_TITLE_CHANGE & ' - ' & loc_ListName
  END
  CASE SELF.m_Check
  OF CHECK_ICON
    ?ColumnList{PROP:IconList,1} = '~checkon.ico'
    ?ColumnList{PROP:IconList,2} = '~checkoff.ico'
    ?ColumnList{PROP:IconList,3} = '~checkondim.ico'
    ?ColumnList{PROP:IconList,4} = '~checkoffdim.ico'
    ?ColumnList{PROP:Format} = '118L(1)|F~' & EDIT_LIST_COLNAME      & |
                               '~L(2)@s40@16C|FI~' & EDIT_LIST_COLON & |
                               '~@s3@'
  OF CHECK_TEXT
    ?ColumnList{PROP:Format} = '112L(1)|F~' & EDIT_LIST_COLNAME     & |
                               '~L(2)@s40@16C|F~' & EDIT_LIST_COLON & |
                               '~@s3@'
  END
  ?ColumnList{PROP:LineHeight}    = ?ColumnList{PROP:FontSize} + 2
  ?ColumnGroup{PROP:Text}         = EDIT_GROUPPROMPT
!// If there are groups then disable drag 'n' drop
  IF SELF.m_Groups
    ?ColumnList{PROP:DropId} = ''
    ?ColumnList{PROP:DragId} = ''
  END
  ?loc_ListName:Prompt{PROP:Text} = EDIT_NAMEPROMPT
  ?ColumnList:Prompt{PROP:Text}   = EDIT_LISTPROMPT
  ?btn_Save{PROP:Text}            = EDIT_BTNSAVE
  ?btn_Cancel{PROP:Text}          = EDIT_BTNCANCEL
!// Set the icon and remove minimize box
!// Limit the size
  loc_PrevHeight = edit_window{PROP:Height}
!// Restore window size and position
  IF SELF.m_SavePos
    edit_window{PROP:XPos}   = GETINI('List Format Manager','edit_x',edit_window{PROP:XPos},SELF.m_INIFile)
    edit_window{PROP:YPos}   = GETINI('List Format Manager','edit_y',edit_window{PROP:YPos},SELF.m_INIFile)
  END
  SYSTEM{PROP:LazyDisplay} = TRUE
!------------------------------------------------------------------------------
! NAME        : GETCOLUMN
! DESCRIPTION : retrieve a highlighted queue row
!------------------------------------------------------------------------------
GetColumn                   ROUTINE

  loc_Choice  = CHOICE(?ColumnList)
  GET(loc_ColumnQueue,loc_Choice)
!// Is the group?
  IF loc_ColumnQueue.loc_ColGroup
    IF loc_ColumnQueue.loc_ColRows > 1
      loc_LowNumber  = 1
      loc_HighNumber = RECORDS(loc_ColumnQueue)
    ELSE
!// Inside the group find the moving range
      LOOP loc_LoopIndex = 1 TO RECORDS(loc_ColumnQueue2)
        GET(loc_ColumnQueue2,loc_LoopIndex)
        IF loc_ColumnQueue2.loc_ColGroup <> loc_ColumnQueue.loc_ColGroup
          CYCLE
        END
        IF loc_ColumnQueue2.loc_ColRows > 1
          loc_LowNumber = loc_LoopIndex + 1
        ELSIF loc_ColumnQueue2.loc_ColRows = 0
          loc_HighNumber = loc_LoopIndex - 1
        END
      END
    END
  ELSE
    loc_LowNumber  = 1
    loc_HighNumber = RECORDS(loc_ColumnQueue)
  END
  IF loc_ColumnQueue.loc_ColIcon = 0
    ?btn_Up{PROP:Disable}    = TRUE
    ?btn_Down{PROP:Disable}  = TRUE
    ?btn_First{PROP:Disable} = TRUE
    ?btn_Last{PROP:Disable}  = TRUE
  ELSE
    ?btn_Up{PROP:Disable}    = FALSE
    ?btn_Down{PROP:Disable}  = FALSE
    ?btn_First{PROP:Disable} = FALSE
    ?btn_Last{PROP:Disable}  = FALSE
    IF loc_Choice = loc_LowNumber
      ?btn_Up{PROP:Disable}    = TRUE
      ?btn_First{PROP:Disable} = TRUE
    END
    IF loc_Choice = loc_HighNumber OR loc_Choice + loc_MovedRows - 1 = loc_HighNumber
!// If there no space to move column or group
      ?btn_Down{PROP:Disable} = TRUE
      ?btn_Last{PROP:Disable} = TRUE
    END
  END
!------------------------------------------------------------------------------
! NAME        : MOVECOLUMN
! DESCRIPTION : moves a queue row
!------------------------------------------------------------------------------
MoveColumn                  ROUTINE

  DATA

rou_Offset                  SHORT(0)             ! Offset for moving up

  CODE

  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  IF loc_DroppedColumn > 0
    DO CheckColumn
    IF ~loc_RowsToMove
      MESSAGE(MESSAGE_NOMOVE,MESSAGE_TITLE,ICON:Exclamation,MESSAGE_BTNOK)
      SELF.Kill(TRUE)
    END
    CASE loc_Direction
    OF DIR_UP
      loc_DroppedColumn -= loc_RowsToMove - 1
    OF DIR_DOWN
      loc_DroppedColumn += loc_RowsToMove - 1
    END
!// Replace columns
    DELETE(loc_ColumnQueue)
    ADD(loc_ColumnQueue,loc_DroppedColumn)
    IF loc_MovedRows > 1
!// Replace linked columns (it is used for groups)
      LOOP loc_LoopIndex = 1 TO loc_MovedRows - 1
        CASE loc_Direction
        OF DIR_UP
        OROF DIR_FIRST
          rou_Offset += 1
        END
        GET(loc_ColumnQueue,loc_Pointer + rou_Offset)
        DELETE(loc_ColumnQueue)
        ADD(loc_ColumnQueue,loc_DroppedColumn + rou_Offset)
      END
    END
!// Set dropped column to position of group header if it is else default position
    loc_DroppedColumn = POINTER(loc_ColumnQueue) - loc_MovedRows + 1
!// Make changed format string
    DO MakeNewFormat
!// Synchronize queues
    DO CloneQueue
    DO RefreshListbox
    SELECT(?ColumnList,loc_DroppedColumn)
    POST(EVENT:NewSelection,?ColumnList)
  END
!------------------------------------------------------------------------------
! NAME        : CHECKCOLUMN
! DESCRIPTION : checks a queue row if it is a group
!------------------------------------------------------------------------------
CheckColumn                 ROUTINE

  DATA

rou_Group                   SHORT,AUTO           ! Local group number

  CODE
!// Is the row in a group?
  IF loc_ColumnQueue.loc_ColOrder
!// If current choice is a group item then limit the moving inside group
    loc_MovedRows  = 1
    loc_RowsToMove = 1
    EXIT
  END
!// If column is out of the group set quantity of rows to be moved
  loc_Pointer = POINTER(loc_ColumnQueue)
  loc_Choice  = CHOICE(?ColumnList)
  loc_MovedRows = loc_ColumnQueue.loc_ColRows
!// Check the next choice
  CASE loc_Direction
  OF DIR_UP
    loc_Choice -= 1
  OF DIR_DOWN
!// Increase choice by quantity of rows of the item (column or group)
    loc_Choice += loc_MovedRows
  ELSE
    loc_RowsToMove = 1
    EXIT
  END
  GET(loc_ColumnQueue2,loc_Choice)
!// Header or end of the group
  IF loc_ColumnQueue2.loc_ColGroup
    IF loc_ColumnQueue2.loc_ColRows
!// The start of the group
      loc_RowsToMove = loc_ColumnQueue2.loc_ColRows
    ELSE
!// The end of the group
      rou_Group = loc_ColumnQueue2.loc_ColGroup
      LOOP loc_LoopIndex = 1 TO RECORDS(loc_ColumnQueue2)
        GET(loc_ColumnQueue2,loc_LoopIndex)
        IF loc_ColumnQueue2.loc_ColGroup <> rou_Group
          CYCLE
        END
        IF loc_ColumnQueue2.loc_ColRows > 1
          loc_RowsToMove = loc_ColumnQueue2.loc_ColRows
          BREAK
        END
      END
    END
    CASE loc_Direction
    OF DIR_DOWN
      loc_RowsToMove += loc_MovedRows - 1
    END
  ELSE
!// The next choice is a single item...
    CASE loc_Direction
    OF DIR_UP
      loc_RowsToMove = 1
    OF DIR_DOWN
!// Rows for single column or group
      loc_RowsToMove = loc_MovedRows
    END
  END
!------------------------------------------------------------------------------
! NAME        : MAKENEWFORMAT
! DESCRIPTION : forms a new format string using changed values
!------------------------------------------------------------------------------
MakeNewFormat               ROUTINE
  CLEAR(loc_Format)
  CLEAR(loc_VarLine)
  LOOP loc_LoopIndex = 1 TO RECORDS(loc_ColumnQueue)
    GET(loc_ColumnQueue,loc_LoopIndex)
    IF SELF.m_Groups
!// Process columns if there are groups...
      IF loc_ColumnQueue.loc_ColGroup
        IF loc_ColumnQueue.loc_ColRows > 1
!// This is a group header
          IF loc_Format
            loc_Format = CLIP(loc_Format) & '['
          ELSE
            loc_Format = '['
          END
        ELSIF loc_ColumnQueue.loc_ColRows = 0
!// This is a end of group
          SELF.m_GroupList.m_Group = loc_ColumnQueue.loc_ColGroup
          GET(SELF.m_GroupList,SELF.m_GroupList.m_Group)
          loc_Format = CLIP(loc_Format) & ']' & SELF.m_GroupList.m_Header
        ELSE
!// This is default column
          loc_Format = CLIP(loc_Format) & loc_ColumnQueue.loc_ColFormat
          loc_VarLine = CLIP(loc_VarLine) & loc_ColumnQueue.loc_ColVar
        END
      ELSE
        loc_Format = CLIP(loc_Format) & loc_ColumnQueue.loc_ColFormat
        loc_VarLine = CLIP(loc_VarLine) & loc_ColumnQueue.loc_ColVar
      END
    ELSE
!// Process columns without any groups...
      loc_Format = CLIP(loc_Format) & loc_ColumnQueue.loc_ColFormat
      loc_VarLine = CLIP(loc_VarLine) & loc_ColumnQueue.loc_ColVar
    END
  END
  SETCLIPBOARD(loc_Format)
  ?DummyList{PROP:Format} = loc_Format
!------------------------------------------------------------------------------
! NAME        : CHECKLASTCOLUMN
! DESCRIPTION : checks last column which may be checked off
!------------------------------------------------------------------------------
CheckLastColumn             ROUTINE

  CLEAR(loc_EmptyColumns)
  LOOP loc_LoopIndex = 1 TO RECORDS(loc_ColumnQueue)
    GET(loc_ColumnQueue,loc_LoopIndex)
    IF loc_ColumnQueue.loc_ColIcon = COLUMN_HIDE OR |
       loc_ColumnQueue.loc_ColIcon = COLUMN_HIDE_DIM
      loc_EmptyColumns += 1
    END
  END
!// Restore selected queue pointer
  DO GetColumn                        
!// Without group ends...
  IF loc_EmptyColumns = RECORDS(loc_ColumnQueue) - SELF.m_Groups
    loc_ColumnQueue.loc_ColIcon = COLUMN_SHOW
    IF SELF.m_Check = CHECK_TEXT
      loc_ColumnQueue.loc_ColMark = 'Yes'
    END
    PUT(loc_ColumnQueue)
    MESSAGE(MESSAGE_UNCHECKLAST,MESSAGE_TITLE,ICON:Asterisk,MESSAGE_BTNOK)
  END
!------------------------------------------------------------------------------
! NAME        : BUILDSETUPLIST
! DESCRIPTION : fills column queue for setup
!------------------------------------------------------------------------------
BuildSetupList              ROUTINE

  DATA

rou_GroupNo                 SHORT(0)             ! Local temp group number
rou_OrderNo                 SHORT,AUTO           ! Column order number
rou_LoopIndex               SHORT,AUTO           ! Local loop index

  CODE
  CASE _Action
  OF InsertRecord
!// Get the current format
    ?DummyList{PROP:Format} = SELF.GetFormat(FORMAT_CURRENT)
  OF ChangeRecord
!// Get the selected format
    ?DummyList{PROP:Format} = cls_File.m_Format
  END
!// Copy content of file field CFG:VarLine
  loc_VarLine = cls_File.m_VarLine
  SELF.SplitVarLine(loc_VarLine)
  FREE(loc_ColumnQueue)
  LOOP loc_LoopIndex = 1 TO SELF.m_Columns
    CLEAR(loc_ColumnQueue)
    loc_ColumnQueue.loc_ColName   = ?DummyList{PROPLIST:Header,loc_LoopIndex}
    loc_ColumnQueue.loc_ColFormat = ?DummyList{PROPLIST:Format,loc_LoopIndex}
    loc_ColumnQueue.loc_ColField  = ?DummyList{PROPLIST:FieldNo,loc_LoopIndex}
!// Get the variable name for a column
    GET(SELF.m_cls_PosList,loc_LoopIndex)
!// Here is variable name like that -> BRWX::LOC:Field(N), N - column number
    loc_ColumnQueue.loc_ColVar = loc_VarLine[(SELF.m_cls_PosList.m_Pos[1] - 1) : SELF.m_cls_PosList.m_Pos[3]]
!// Get the right checkbox type
    loc_Width = ?DummyList{PROPLIST:Width,loc_LoopIndex}
    loc_GroupWidth = ?DummyList{PROPLIST:Width + PROPLIST:Group,loc_LoopIndex}
    IF loc_Width
      loc_ColumnQueue.loc_ColIcon = COLUMN_SHOW
      IF SELF.m_Check = CHECK_TEXT
        loc_ColumnQueue.loc_ColMark = 'Yes'
      END
    ELSE
      loc_ColumnQueue.loc_ColIcon = COLUMN_HIDE
      IF SELF.m_Check = CHECK_TEXT
        loc_ColumnQueue.loc_ColMark = '-'
      END
    END
!// Check column belonging
    SELF.m_ColumnList.m_FieldNo = loc_ColumnQueue.loc_ColField
    GET(SELF.m_ColumnList,SELF.m_ColumnList.m_FieldNo)
    IF SELF.m_ColumnList.m_GroupNo
!// Column is in group
      loc_ColumnQueue.loc_ColGroup  = SELF.m_ColumnList.m_GroupNo
      SELF.m_GroupList.m_Group = SELF.m_ColumnList.m_GroupNo
      GET(SELF.m_GroupList,SELF.m_GroupList.m_Group)
!// Set column order number
      IF rou_GroupNo <> SELF.m_ColumnList.m_GroupNo
        rou_GroupNo = SELF.m_ColumnList.m_GroupNo
        rou_OrderNo = 1
      ELSE
        rou_OrderNo += 1
      END
!// Prepare group entry fields
      IF rou_OrderNo = 1
        loc_ColumnQueue.loc_ColName  = EDIT_GROUPHEAD & SELF.m_GroupList.m_Name
        loc_ColumnQueue.loc_ColRows  = SELF.m_GroupList.m_Columns + 2
        IF loc_GroupWidth <= 0
          loc_ColumnQueue.loc_ColIcon = COLUMN_HIDE
          IF SELF.m_Check = CHECK_TEXT
            loc_ColumnQueue.loc_ColMark = '-'
          END
        ELSE
          loc_ColumnQueue.loc_ColIcon = COLUMN_SHOW
          IF SELF.m_Check = CHECK_TEXT
            loc_ColumnQueue.loc_ColMark = 'Yes'
          END
        END
        ADD(loc_ColumnQueue)
        loc_ColumnQueue.loc_ColName  = '    ' & ?DummyList{PROPLIST:Header,loc_LoopIndex}
        loc_ColumnQueue.loc_ColRows  = 1
        loc_ColumnQueue.loc_ColOrder = rou_OrderNo
        DO SetColumnDimIcon
      END
      IF rou_OrderNo = SELF.m_GroupList.m_Columns
        loc_ColumnQueue.loc_ColName  = '    ' & loc_ColumnQueue.loc_ColName
        loc_ColumnQueue.loc_ColRows  = 1
        loc_ColumnQueue.loc_ColOrder = rou_OrderNo
        DO SetColumnDimIcon
        ADD(loc_ColumnQueue)
        loc_ColumnQueue.loc_ColName  = EDIT_GROUPFOOT & SELF.m_GroupList.m_Name
        loc_ColumnQueue.loc_ColIcon  = 0
        loc_ColumnQueue.loc_ColRows  = 0
        loc_ColumnQueue.loc_ColOrder = 0
        loc_ColumnQueue.loc_ColMark  = ''
      END
      IF NOT(rou_OrderNo = SELF.m_GroupList.m_Columns) AND NOT(rou_OrderNo = 1)
        loc_ColumnQueue.loc_ColName  = '    ' & ?DummyList{PROPLIST:Header,loc_LoopIndex}
        loc_ColumnQueue.loc_ColRows  = 1
        loc_ColumnQueue.loc_ColOrder = rou_OrderNo
        DO SetColumnDimIcon
      END
    ELSE
!// Column is out of any group
      loc_ColumnQueue.loc_ColRows = 1
    END
    ADD(loc_ColumnQueue)
  END
!// Make working copy of queue
  DO CloneQueue
!// To the first entry
  ?ColumnList{PROP:SelStart} = 1
  POST(EVENT:NewSelection,?ColumnList)
!------------------------------------------------------------------------------
! NAME        : SETCOLUMNDIMICON
! DESCRIPTION : just changes icon if group width = 0
!------------------------------------------------------------------------------
SetColumnDimIcon            ROUTINE

  IF loc_GroupWidth <= 0
    IF loc_Width
      loc_ColumnQueue.loc_ColIcon = COLUMN_SHOW_DIM
    ELSE
      loc_ColumnQueue.loc_ColIcon = COLUMN_HIDE_DIM
    END
    IF SELF.m_Check = CHECK_TEXT
      loc_ColumnQueue.loc_ColMark = '*'               
    END
  ELSE
    IF loc_Width
      loc_ColumnQueue.loc_ColIcon = COLUMN_SHOW
      IF SELF.m_Check = CHECK_TEXT
        loc_ColumnQueue.loc_ColMark = 'Yes'           
      END
    ELSE
      loc_ColumnQueue.loc_ColIcon = COLUMN_HIDE
      IF SELF.m_Check = CHECK_TEXT
        loc_ColumnQueue.loc_ColMark = '-'             
      END
    END
  END
!------------------------------------------------------------------------------
! NAME        : CLONEQUEUE
! DESCRIPTION : makes clone of the source queue
!------------------------------------------------------------------------------
CloneQueue                  ROUTINE

  DATA

rou_LoopIndex               SHORT,AUTO           ! Local loop index

  CODE
  FREE(loc_ColumnQueue2)
  LOOP rou_LoopIndex = 1 TO RECORDS(loc_ColumnQueue)
    GET(loc_ColumnQueue,rou_LoopIndex)
    CLEAR(loc_ColumnQueue2)
    loc_ColumnQueue2 = loc_ColumnQueue
    ADD(loc_ColumnQueue2)
  END
!------------------------------------------------------------------------------
! NAME        : PROCEDURERETURN
! DESCRIPTION : termination code
!------------------------------------------------------------------------------
ProcedureReturn             ROUTINE

  IF SELF.m_SavePos
    PUTINI('List Format Manager','edit_x',edit_window{PROP:XPos},SELF.m_INIFile)
    PUTINI('List Format Manager','edit_y',edit_window{PROP:YPos},SELF.m_INIFile)
  END
  CLOSE(edit_window)
  FREE(loc_ColumnQueue)
  FREE(loc_ColumnQueue2)
  RETURN(loc_Completed)
!##############################################################################
!#
!# NAME        : GETFORMAT
!# DESCRIPTION : reads a format string from config file
!# PARAMETERS  : [in] _Mode   - Mode defined getting format
!#               [in] _Notify - Notify user about error
!# RETURNS     : Format string
!#
!##############################################################################
ListFormatManagerClass.GetFormat         PROCEDURE(BYTE _Mode)

loc_LoopIndex               SHORT,AUTO
loc_Format                  STRING(1024)
loc_GroupNo                 SHORT(0)
loc_ListRecords             SHORT(0)

  CODE
  CLEAR(loc_Format)
  CASE _Mode
  OF FORMAT_CURRENT
  OROF FORMAT_DEFAULT
    CLEAR(SELF.m_File)
    cls_File.m_AppName= SELF.m_AppName
    cls_File.m_ProcId = SELF.m_ProcId
    cls_File.m_UserId = SELF.m_UserId
    cls_File.m_CtrlId = SELF.m_CtrlId
    SET(cls_File.m_Key,cls_File.m_Key)
    LOOP
      NEXT(SELF.m_File)
      IF ERRORCODE() THEN BREAK.
      IF cls_File.m_AppName<> SELF.m_AppName OR |
         cls_File.m_ProcId <> SELF.m_ProcId OR |
         cls_File.m_CtrlId <> SELF.m_CtrlId OR |
         cls_File.m_UserId <> SELF.m_UserId
        BREAK
      END
      loc_ListRecords += 1
      CASE _Mode
      OF FORMAT_CURRENT
        IF ~BAND(cls_File.m_Flag,FORMAT_CURRENT)
          CYCLE
        END
      OF FORMAT_DEFAULT
        IF ~BAND(cls_File.m_Flag,FORMAT_DEFAULT)
          CYCLE
        END
      END
      RETURN(cls_File.m_Format)
    END
  OF FORMAT_INIT
    LOOP loc_LoopIndex = 1 TO SELF.m_Columns
      GET(SELF.m_ColumnList,loc_LoopIndex)
!// It's necessary for GROUP displaying
      loc_Format = SELF.m_Format
    END
    RETURN(loc_Format)
  END
!// Only if there are format records
  IF loc_ListRecords
    CASE _Mode
    OF FORMAT_DEFAULT
      MESSAGE(MESSAGE_DFLTNOTFOUND,MESSAGE_TITLE,ICON:Exclamation,MESSAGE_BTNOK)
    OF FORMAT_CURRENT
      MESSAGE(MESSAGE_CURRNOTFOUND,MESSAGE_TITLE,ICON:Exclamation,MESSAGE_BTNOK)
    END
  END
  RETURN('')
!##############################################################################
!#
!# NAME        : GETFORMATBYID
!# DESCRIPTION : reads a format string using specified ID
!# PARAMETERS  : No parameters
!# RETURNS     : Format string
!#
!##############################################################################
ListFormatManagerClass.GetFormatByID     PROCEDURE(SHORT _FormatId)

  CODE
  IF RECORDS(SELF.m_File)
    CLEAR(SELF.m_File)
    cls_File.m_AppName= SELF.m_AppName
    cls_File.m_ProcId = SELF.m_ProcId
    cls_File.m_UserId = SELF.m_UserId
    cls_File.m_CtrlId = SELF.m_CtrlId
    cls_File.m_FormatId = _FormatId
    GET(SELF.m_File,cls_File.m_Key)
    IF SELF.GetError(14)
      SELF.Kill(TRUE)
    END
    RETURN(cls_File.m_Format)
  ELSE
    RETURN('')
  END
!##############################################################################
!#
!# NAME        : SETCURRENTFORMAT
!# DESCRIPTION : sets a new current format
!# PARAMETERS  : No parameters
!# RETURNS     : Format string
!#
!##############################################################################
ListFormatManagerClass.SetCurrentFormat  PROCEDURE(SHORT _FormatId)

  CODE
!// Clear an old current format
  IF SELF.GetFormat(FORMAT_CURRENT)
    IF SELF.SaveFormat AND NOT BAND(cls_File.m_Flag,FORMAT_DEFAULT)=FORMAT_DEFAULT THEN
       cls_File.m_Format = SELF.m_Control{PROP:Format}
    END
    cls_File.m_Flag = BAND(cls_File.m_Flag,BXOR(FORMAT_CURRENT,0FFh))
    PUT(SELF.m_File)
    IF SELF.GetError(15)
      SELF.Kill(TRUE)
    END
  END
!// Set a new current format
  IF SELF.GetFormatByID(_FormatId)
    cls_File.m_Flag = BOR(cls_File.m_Flag,FORMAT_CURRENT)
    PUT(SELF.m_File)
    IF SELF.GetError(16)
      SELF.Kill(TRUE)
    END
  END
!##############################################################################
!#
!# NAME        : UPDATEFORMAT
!# DESCRIPTION : updates and applies current format to listbox
!# PARAMETERS  : [in] _Format - Format string to apllying
!# RETURNS     : No returned value
!#
!##############################################################################
ListFormatManagerClass.UpdateFormat      PROCEDURE(               |
                                      STRING _Format |
                                     )

  CODE
  SELF.m_Control{PROP:Format} = _Format
!// Set identification tooltip
  IF SELF.m_UseTip
    SELF.SetTip()
  END
!##############################################################################
!#
!# NAME        : SYNCHRONIZE
!# DESCRIPTION : updates and applies current format to listbox
!# PARAMETERS  : No parameters
!# RETURNS     : No returned value
!#
!##############################################################################
ListFormatManagerClass.Synchronize       PROCEDURE

loc_Width                   LONG,AUTO            ! Buffer for column width
loc_LoopIndex               SHORT,AUTO           ! Local loop index
loc_LoopIndex2              SHORT,AUTO           ! Local loop index
loc_DummyControl            SIGNED,AUTO          ! Dummy list control
loc_Format                  STRING(8192)         ! Buffer for format
loc_VarLine                 STRING(8192)         ! Buffer for variable line
loc_TempVarLine             STRING(8192)         ! Buffer for variable line
DummyWindow                 WINDOW('Dummy'),AT(,,244,24),FONT('MS Sans Serif',8,,),CENTER,GRAY
                              LIST,AT(2,2,240,20),USE(?DummyList)
                            END

  CODE
!//////////////////////////////////////////////////////////////////////////////
!// three ways of changing (default) format:
!// 1. The format of field may be changed;
!// 2. The new column may be added to listbox;
!// 3. The field may be deleted from listbox.
!//////////////////////////////////////////////////////////////////////////////
!// Prepare variable buffer
  loc_VarLine = SELF.BuildFieldLine()
!// 1. The format of field may be changed
!// Use dummy window
  OPEN(DummyWindow)
!// Running over all format records (default is excluded)
  CLEAR(SELF.m_File)
  cls_File.m_AppName= SELF.m_AppName
  cls_File.m_ProcId = SELF.m_ProcId
  cls_File.m_UserId = SELF.m_UserId
  cls_File.m_CtrlId = SELF.m_CtrlId
  SET(cls_File.m_Key,cls_File.m_Key)
  LOOP
    NEXT(SELF.m_File)
    IF ERRORCODE() THEN BREAK.
    IF cls_File.m_AppName<> SELF.m_AppName OR |
       cls_File.m_ProcId <> SELF.m_ProcId OR |
       cls_File.m_CtrlId <> SELF.m_CtrlId OR |
       cls_File.m_UserId <> SELF.m_UserId
      BREAK
    END
    IF BAND(cls_File.m_Flag,FORMAT_DEFAULT)
      CYCLE
    END
!// It is used if default parameters only was changed
    IF CLIP(UPPER(cls_File.m_VarLine)) <> CLIP(UPPER(loc_VarLine))
!// Checking for new entries which was added
      SELF.SplitVarLine(loc_VarLine)
      LOOP loc_LoopIndex = 1 TO RECORDS(SELF.m_cls_PosList)
        GET(SELF.m_cls_PosList,loc_LoopIndex)
!// If such column present in the format the CYCLE
        IF INSTRING(loc_VarLine[SELF.m_cls_PosList.m_Pos[1] : SELF.m_cls_PosList.m_Pos[2]],cls_File.m_VarLine,1,1)
          CYCLE
        END
!// Depending of new column location add its format to appropriate point
        GET(SELF.m_ColumnList,SELF.m_cls_PosList.m_FieldNo)
        CASE SELF.m_cls_PosList.m_FieldNo
        OF 1
          cls_File.m_Format = CLIP(SELF.m_ColumnList.m_Format) & cls_File.m_Format
        OF SELF.m_Columns
          cls_File.m_Format = CLIP(cls_File.m_Format) & SELF.m_ColumnList.m_Format
        ELSE
          loc_Format = cls_File.m_Format
          loc_Format = loc_Format[1 : (SELF.m_ColumnList.m_StartPos - 1)] & |
               CLIP(SELF.m_ColumnList.m_Format) & |
               loc_Format[SELF.m_ColumnList.m_StartPos : LEN(CLIP(loc_Format))]
          cls_File.m_Format = loc_Format
        END
      END
!// Checking for entries which was deleted
      SELF.SplitVarLine(cls_File.m_VarLine)
      loc_TempVarLine = cls_File.m_VarLine
      LOOP loc_LoopIndex = 1 TO RECORDS(SELF.m_cls_PosList)
        GET(SELF.m_cls_PosList,loc_LoopIndex)
!// If such column present in the format the CYCLE
        IF INSTRING(loc_TempVarLine[SELF.m_cls_PosList.m_Pos[1] : SELF.m_cls_PosList.m_Pos[2]],loc_VarLine,1,1)
          CYCLE
        END
!// For building of a new format
        ?DummyList{PROP:Format} = cls_File.m_Format
        CLEAR(cls_File.m_Format)
!// Loop using only present fields
        LOOP loc_LoopIndex2 = 1 TO RECORDS(SELF.m_cls_PosList)
          IF loc_LoopIndex2 = loc_LoopIndex 
            CYCLE
          END
          cls_File.m_Format = CLIP(cls_File.m_Format) & ?DummyList{PROPLIST:Format,loc_LoopIndex2}
        END
      END
      cls_File.m_VarLine = loc_VarLine
    END
    ?DummyList{PROP:Format} = cls_File.m_Format
!// The updated format in the queue
    LOOP loc_LoopIndex = 1 TO SELF.m_Columns
      GET(SELF.m_ColumnList,loc_LoopIndex)
      IF ?DummyList{PROPLIST:Format,loc_LoopIndex} <> SELF.m_ColumnList.m_Format
        loc_Format = SELF.m_ColumnList.m_Format
        loc_Width = ?DummyList{PROPLIST:Width,loc_LoopIndex}
        IF loc_Width
          ?DummyList{PROPLIST:Format,loc_LoopIndex} = loc_Format
        END
      END
    END
    cls_File.m_Format = ?DummyList{PROP:Format}
    PUT(SELF.m_File)
    IF SELF.GetError(3000)
      SELF.Kill(TRUE)
    END
  END
  CLOSE(DummyWindow)
!//////////////////////////////////////////////////////////////////////////////
!/
!/ NAME        : GETERROR
!/ DESCRIPTION : launch format setup utility
!/ PARAMETERS  : [in] _Action - Some action (reading, writing etc.)
!/               [in] _Level  - Level of an error (only for debugging purpose)
!/ RETURNS     : An error code
!/
!//////////////////////////////////////////////////////////////////////////////
ListFormatManagerClass.BuildFieldLine    PROCEDURE

loc_FieldLine               STRING(8192)    ! String buffer for fields line
loc_LoopIndex               SHORT,AUTO      ! Local loop index
loc_VarName                 STRING(8192)    ! Buffer for variable name
loc_FieldNo                 SHORT(0)        ! Real column number

  CODE
  CLEAR(loc_FieldLine)
  LOOP loc_LoopIndex = 1 TO SELF.m_QFields
    loc_VarName = WHO(SELF.m_Queue,loc_LoopIndex)
    IF INSTRING(':ICON',UPPER(CLIP(loc_VarName)),1,1)       OR |
       INSTRING(':NORMALFG',UPPER(CLIP(loc_VarName)),1,1)   OR |
       INSTRING(':NORMALBG',UPPER(CLIP(loc_VarName)),1,1)   OR |
       INSTRING(':SELECTEDFG',UPPER(CLIP(loc_VarName)),1,1) OR |
       INSTRING(':SELECTEDBG',UPPER(CLIP(loc_VarName)),1,1) OR |
       INSTRING(':STYLE',UPPER(CLIP(loc_VarName)),1,1)      OR |
       INSTRING(':TIP',UPPER(CLIP(loc_VarName)),1,1)
      CYCLE
    END
    loc_FieldNo += 1
    loc_FieldLine = CLIP(loc_FieldLine) & '?' & CLIP(loc_VarName) & '(' & loc_FieldNo & ')'
  END
  RETURN(loc_FieldLine)
!##############################################################################
!#
!# NAME        : GETERROR
!# DESCRIPTION : launch format setup utility
!# PARAMETERS  : [in] _Action - Some action (reading, writing etc.)
!#               [in] _Level  - Level of an error (only for debugging purpose)
!# RETURNS     : An error code
!#
!##############################################################################
ListFormatManagerClass.GetError          PROCEDURE(                |
                                      BYTE _Level = 0 |
                                     )

loc_Error                   LONG(0)         ! Error code
loc_Message                 STRING(255)     ! Error message

  CODE
  IF ERRORCODE()
    loc_Error = ERRORCODE()
    loc_Message = MESSAGE_ERROR
    ReplaceMacro('%Error%',ERROR(),loc_Message)
    IF _Level
      loc_Message = CLIP(loc_Message) & MESSAGE_ERRORLEVEL & _Level
    END
    MESSAGE(CLIP(loc_Message),MESSAGE_TITLE,ICON:Exclamation,MESSAGE_BTNOK)
  END
  RETURN(loc_Error)
!##############################################################################
!#
!# NAME        : GETCOLUMNS
!# DESCRIPTION : counts maximum of original listbox columns
!# PARAMETERS  : No parameters
!# RETURNS     : A number of columns
!#
!##############################################################################
ListFormatManagerClass.GetColumns        PROCEDURE

loc_Columns                 SHORT(0)        ! Quantity of columns

  CODE
  LOOP 
    IF ~SELF.m_Control{PROPLIST:Exists,loc_Columns + 1}
      BREAK
    END
    loc_Columns += 1
  END
  RETURN(loc_Columns)
!##############################################################################
!#
!# NAME        : GETGROUPS
!# DESCRIPTION : counts maximum of original listbox groups
!# PARAMETERS  : No parameters
!# RETURNS     : A number of groups
!#
!##############################################################################
ListFormatManagerClass.GetGroups         PROCEDURE

loc_Groups                  SHORT(0)        ! Quantity of groups
loc_SPos                    UNSIGNED(1)     ! Start position for INSTRING
loc_FPos                    UNSIGNED,AUTO   ! Found position for INSTRING

  CODE
  LOOP
    loc_FPos = INSTRING('[',SELF.m_Format,1,loc_SPos)
    IF loc_FPos
      loc_Groups += 1
      loc_SPos = loc_FPos + 1
    ELSE
      BREAK
    END
  END
  RETURN(loc_Groups)
!##############################################################################
!#
!# NAME        : SETWIDTH
!# DESCRIPTION : set or reset column width
!# PARAMETERS  : [in] _Format - string returned by {PROPLIST:Format}
!#               [in] _Width  - conditional column width
!# RETURNS     : A number of columns
!#
!##############################################################################
ListFormatManagerClass.SetWidth          PROCEDURE(                 |
                                      *STRING _Format, |
                                      SHORT _Width     |
                                     )

loc_LoopIndex               SHORT,AUTO
loc_ClipPos                 UNSIGNED,AUTO

  CODE
  IF _Width
!// If only first symbol is zero
    IF _Format[1] = '0'
      _Format = _Width & _Format[2 : LEN(CLIP(_Format))]
    END
  ELSE
!// Find the first alignment flag
    LOOP loc_LoopIndex = 1 TO LEN(CLIP(_Format))
      IF INLIST(_Format[loc_LoopIndex],'L','C','R','D')
        _Format = '0' & _Format[loc_LoopIndex : LEN(CLIP(_Format))]
        BREAK
      END
    END
  END
!##############################################################################
!#
!# NAME        : BINDINTERFACE
!# DESCRIPTION : binds an interface features to class
!# PARAMETERS  : [in] _CheckType - Choose a checkbox type in the edit_window
!#               [in] _Sort      - Defines an items sort order
!#               [in] _SavePos   - Saves and restores windows positions
!# RETURNS     : No returned parameters
!#
!##############################################################################
ListFormatManagerClass.BindInterface     PROCEDURE(                              |
                                      BYTE _CheckType = CHECK_ICON, |
                                      BYTE _Sort = SORT_ALPHA,      |
                                      BYTE _SavePos = TRUE,         |   
                                      <STRING _IniFile>             |
                                     )

  CODE
  SELF.m_Check   = _CheckType
  SELF.m_Sort    = _Sort
  SELF.m_SavePos = _SavePos
  IF SELF.m_SavePos
    SELF.m_INIFile &= NEW(STRING(LEN(_IniFile)))
    SELF.m_INIFile = _IniFile
  END
!##############################################################################
!#
!# NAME        : BINDFILE
!# DESCRIPTION : binds a file record to local group
!# PARAMETERS  : No parameters
!# RETURNS     : No returned parameters
!#
!##############################################################################
ListFormatManagerClass.BindFile          PROCEDURE

  CODE
  CLEAR(cls_File)
  cls_File.m_Key        &= SELF.m_File{PROP:Key,1}
  cls_File.m_AppName    &= WHAT(SELF.m_Record,1)
  cls_File.m_ProcId     &= WHAT(SELF.m_Record,2)
  cls_File.m_UserId     &= WHAT(SELF.m_Record,3)
  cls_File.m_CtrlId     &= WHAT(SELF.m_Record,4)
  cls_File.m_FormatId   &= WHAT(SELF.m_Record,5)
  cls_File.m_FormatName &= WHAT(SELF.m_Record,6)
  cls_File.m_Flag       &= WHAT(SELF.m_Record,7)
  cls_File.m_Format     &= WHAT(SELF.m_Record,8)
  cls_File.m_VarLine    &= WHAT(SELF.m_Record,9)
!##############################################################################
!#
!# NAME        : SETTIP
!# DESCRIPTION : set format identification tooltip
!# PARAMETERS  : No parameters
!# RETURNS     : No returned parameters
!#
!##############################################################################
ListFormatManagerClass.SetTip            PROCEDURE

loc_Tip                     STRING(512)

  CODE
  loc_Tip = SELF.m_Tip
  IF loc_Tip
    loc_Tip = CLIP(loc_Tip) & '<10>'
  END
  loc_Tip = CLIP(loc_Tip) & TIPTEXT & '"' & CLIP(cls_File.m_FormatName) & '"'
  SELF.m_Control{PROP:Tip} = loc_Tip
!##############################################################################
!#
!# NAME        : ISDUPLICATE
!# DESCRIPTION :  checks for column identity
!# PARAMETERS  : [in] _Format - Group format string
!# RETURNS     : 1 - if duplicate is, 0 - otherwise.
!#
!##############################################################################
ListFormatManagerClass.IsDuplicate       PROCEDURE(               |
                                      STRING _Format |
                                     )

loc_IsDuplicate             BYTE(0)              ! Duplication flag
loc_FPos                    SHORT(0)             ! Found position for INSTRING
loc_SPos                    SHORT(0)             ! Start position for INSTRING
loc_Pattern                 &STRING              ! Buffer for the format
loc_PoundList               QUEUE,PRE()
loc_PPos                      SHORT,DIM(2)
                            END
loc_TildaList               QUEUE,PRE()
loc_TPos                      SHORT,DIM(2)
                            END
loc_LoopIndex               SHORT,AUTO
loc_PoundCycle              BYTE,AUTO
loc_PoundCount              SHORT(0)
loc_DupCount                SHORT,AUTO

  CODE
!// Find tildas...
  FREE(loc_TildaList)
  CLEAR(loc_TildaList)
  LOOP
    loc_FPos = INSTRING('~',_Format,1,loc_SPos + 1)
    IF loc_FPos
      IF loc_TildaList.loc_TPos[1]
        loc_TildaList.loc_TPos[2] = loc_FPos
        ADD(loc_PoundList)
        CLEAR(loc_TildaList)
      ELSE
        loc_TildaList.loc_TPos[1] = loc_FPos
      END
      loc_SPos = loc_FPos
    ELSE
      BREAK
    END
  END
!// Find pounds...
  loc_SPos = 0
  FREE(loc_PoundList)
  LOOP
    loc_FPos = INSTRING('#',_Format,1,loc_SPos + 1)
    IF loc_FPos
      loc_PoundCycle = FALSE
      LOOP loc_LoopIndex = 1 TO RECORDS(loc_TildaList)
        GET(loc_TildaList,loc_LoopIndex)
!// Only those that locate outside tildas
        IF INRANGE(loc_FPos,loc_TildaList.loc_TPos[1],loc_TildaList.loc_TPos[2])
          loc_PoundCycle = TRUE
          BREAK
        END
      END
      loc_SPos = loc_FPos
      IF loc_PoundCycle
        CYCLE
      END
      loc_PoundCount += 1
      IF loc_PoundCount = 1
!// First is the "["
        loc_PoundList.loc_PPos[1] = 2 
        loc_PoundList.loc_PPos[2] = loc_FPos - 1
        ADD(loc_PoundList)
      ELSE
        IF loc_PoundCount % 2
          loc_PoundList.loc_PPos[2] = loc_FPos - 1
          ADD(loc_PoundList)
        ELSE
          loc_PoundList.loc_PPos[1] = loc_FPos + 1
        END
      END
    ELSE
      IF loc_SPos
        BREAK
      ELSE
        MESSAGE(MESSAGE_WRONGFORMAT,MESSAGE_TITLE,ICON:Exclamation,MESSAGE_BTNOK)
        SELF.Kill(TRUE)
      END
    END
  END
  LOOP loc_LoopIndex = 1 TO RECORDS(loc_PoundList)
    GET(loc_PoundList,loc_LoopIndex)
    loc_Pattern &= NEW(STRING(LEN(_Format[loc_PoundList.loc_PPos[1] : loc_PoundList.loc_PPos[2]])))
    loc_Pattern = _Format[loc_PoundList.loc_PPos[1] : loc_PoundList.loc_PPos[2]]
    loc_DupCount = 0
    loc_FPos = 0
    LOOP
      loc_FPos = INSTRING(loc_Pattern,_Format,1,loc_FPos + 1)
      IF loc_FPos
        loc_DupCount += 1
      ELSE
        BREAK
      END
    END
    DISPOSE(loc_Pattern)
    IF loc_DupCount > 1
      loc_IsDuplicate = TRUE
      BREAK
    END
  END
  RETURN(loc_IsDuplicate)
!//////////////////////////////////////////////////////////////////////////////
!/
!/ NAME        : SPLITVARLINE
!/ DESCRIPTION : The given procedure splits the variable line to parts
!/ PARAMETERS  : [in]  _VarLine - passed variable line
!/ RETURNS     : No returned value
!/
!//////////////////////////////////////////////////////////////////////////////
ListFormatManagerClass.SplitVarLine      PROCEDURE(STRING _VarLine)

loc_SPos                    LONG(1)              ! Start position for INSTRING
loc_FPos                    LONG,DIM(3)          ! Variables for INSTRING

  CODE
  FREE(SELF.m_cls_PosList)
  LOOP
    loc_FPos[1] = INSTRING('?',_VarLine,1,loc_SPos)
    IF loc_FPos[1] = 0
!// The first time? Force error...
      IF loc_SPos = 1
        MESSAGE(MESSAGE_ERR_VARLINE,MESSAGE_TITLE,ICON:Exclamation)
        SELF.Kill(TRUE)
      ELSE
        BREAK
      END
    END
    loc_FPos[2] = INSTRING('(',_VarLine,1,loc_FPos[1])
    loc_FPos[3] = INSTRING(')',_VarLine,1,loc_FPos[1])
    loc_SPos = loc_FPos[3]
    CLEAR(SELF.m_cls_PosList)
    SELF.m_cls_PosList.m_Pos[1]  = loc_FPos[1] + 1
    SELF.m_cls_PosList.m_Pos[2]  = loc_FPos[2] - 1
    SELF.m_cls_PosList.m_Pos[3]  = loc_FPos[3]
    SELF.m_cls_PosList.m_FieldNo = _VarLine[(loc_FPos[2] + 1) : (loc_FPos[3] - 1)]
    ADD(SELF.m_cls_PosList)
  END
!##############################################################################
!#
!# NAME        : REPLACEMACRO
!# DESCRIPTION : The given procedure replaces macro with appropriate value
!# PARAMETERS  : [in]  _Macro  - Name of a macro
!#               [in]  _Source - Replacing string
!#               [out] _Target - Replaced string
!# RETURNS     : Result of message processing
!#
!##############################################################################
ReplaceMacro                PROCEDURE(                |
                                      STRING _Macro,  |
                                      STRING _Source, |
                                      *STRING _Target |
                                     )

loc_Pos                     LONG,AUTO

  CODE
  loc_Pos = INSTRING(_Macro,_Target,1,1)
  IF ~loc_Pos
    RETURN
  END
  _Target = SUB(_Target,1,loc_Pos - 1) & CLIP(_Source) & |
            SUB(_Target,loc_Pos + LEN(_Macro),LEN(CLIP(_Target)))

ListFormatManagerClass.UpdateCurrentFormat   PROCEDURE()
  CODE
  IF RECORDS(SELF.m_File)
     CLEAR(SELF.m_File)
     cls_File.m_AppName= SELF.m_AppName
     cls_File.m_ProcId = SELF.m_ProcId
     cls_File.m_UserId = SELF.m_UserId
     cls_File.m_CtrlId = SELF.m_CtrlId
     cls_File.m_FormatId = SELF.m_LastId
     GET(SELF.m_File,cls_File.m_Key)
     IF NOT ERROR() THEN
        IF FORMAT_CURRENT=BAND(cls_File.m_Flag,FORMAT_CURRENT) AND NOT BAND(cls_File.m_Flag,FORMAT_DEFAULT)=FORMAT_DEFAULT THEN
           cls_File.m_Format = SELF.m_Control{PROP:Format}
           PUT(SELF.m_File)
        ELSE
           cls_File.m_Flag = BAND(cls_File.m_Flag,BXOR(FORMAT_CURRENT,0FFh))
           PUT(SELF.m_File)
           SELF.m_LastId=0
           SELF.SetCurrentFormat(1000,'Current Format')
           IF CLIP(cls_File.m_Format) <> CLIP(SELF.m_Control{PROP:Format}) THEN
              cls_File.m_Format = SELF.m_Control{PROP:Format}
              PUT(SELF.m_File)
           END
        END
     END
  END
ListFormatManagerClass.SetCurrentFormat     PROCEDURE(SHORT _FormatId,STRING _FormatName)

  CODE
  !// Clear an old current format
    IF _FormatId=SELF.m_LastId THEN
       RETURN
    END
    IF SELF.m_LastId THEN
       CLEAR(SELF.m_File)
       cls_File.m_AppName  = SELF.m_AppName
       cls_File.m_ProcId   = SELF.m_ProcId
       cls_File.m_UserId   = SELF.m_UserId
       cls_File.m_CtrlId   = SELF.m_CtrlId
       cls_File.m_FormatId = SELF.m_LastId
       GET(SELF.m_File,cls_File.m_Key)
       IF NOT ERRORCODE() THEN
         IF SELF.SaveFormat AND NOT (BAND(cls_File.m_Flag,FORMAT_DEFAULT)=FORMAT_DEFAULT) THEN
            cls_File.m_Format = SELF.m_Control{PROP:Format}
         END
         cls_File.m_Flag = BAND(cls_File.m_Flag,BXOR(FORMAT_CURRENT,0FFh))
         PUT(SELF.m_File)
         IF SELF.GetError(15)
           SELF.Kill(TRUE)
         END
       END
    END
    !// Get format
    CLEAR(SELF.m_File)
    cls_File.m_AppName= SELF.m_AppName
    cls_File.m_ProcId = SELF.m_ProcId
    cls_File.m_UserId = SELF.m_UserId
    cls_File.m_CtrlId = SELF.m_CtrlId
    cls_File.m_FormatId = _FormatId
    GET(SELF.m_File,cls_File.m_Key)
    IF ERRORCODE() THEN
       !// will add it
       cls_File.m_AppName    = SELF.m_AppName
       cls_File.m_ProcId     = SELF.m_ProcId
       cls_File.m_UserId     = SELF.m_UserId
       cls_File.m_CtrlId     = SELF.m_CtrlId
       cls_File.m_FormatId   = _FormatId
       cls_File.m_FormatName = _FormatName
       IF NOT cls_File.m_FormatName THEN
          cls_File.m_FormatName = 'Format_'&_FormatId
       END
       cls_File.m_Format     = SELF.m_Control{PROP:Format}
       cls_File.m_VarLine    = SELF.BuildFieldLine()
       cls_File.m_Flag       = FORMAT_CURRENT
       ADD(SELF.m_File)
       SELF.UpdateFormat(cls_File.m_Format)
    ELSE
       !// Set a new current format
       cls_File.m_Flag = BOR(cls_File.m_Flag,FORMAT_CURRENT)
       IF NOT CLIP(cls_File.m_Format) THEN
          cls_File.m_Format     = SELF.m_Control{PROP:Format}
          cls_File.m_VarLine    = SELF.BuildFieldLine()
       END
       PUT(SELF.m_File)
       SELF.UpdateFormat(cls_File.m_Format)
    END
    SELF.m_LastId = cls_File.m_FormatId
!//////////////////////////////////////////////////////////////////////////////
!/ END OF CLASS IMPLEMENTATION
!//////////////////////////////////////////////////////////////////////////////
!==============================================================================
!
!  SortHeaderClassType
!
! 
!
!==============================================================================
!=========================== Public Methods ===================================
SortHeaderClassType.Init PROCEDURE(QUEUE ListQueue,SIGNED ListControl,LONG RowSortDefault = 0,<STRING IniFileName>,<STRING ProcedureName>,<VIEW pView>,<KEY pPK>)

Loc:lLoopIndex  LONG,AUTO
Loc:stSortOrder STRING(100),AUTO

  CODE
  IF SELF.RegionControl
    RETURN
  END

  SELF.QueueListHeader  &= NEW(QueueListHeaderType)
  SELF.QueueListSort    &= NEW(QueueListSortType)

  SELF.RegionControl               = CREATE(0,CREATE:Region)
  SELF.RegionControl{PROP:Width}   = 1
  SELF.RegionControl{PROP:Height}  = 1
  SELF.RegionControl{PROP:Disable} = False
  SELF.RegionControl{PROP:Imm}     = True
  SELF.SetRegionUp()

  SELF.ListQueue   &= ListQueue
  SELF.ListControl  = ListControl

  SELF.ForceChangeSignOrder = False
  SELF.LastKeyCode = MouseLeft
  CLEAR(SELF.FirstSortField)

  IF NOT OMITTED(IniFileName) AND IniFileName AND NOT OMITTED(ProcedureName) AND ProcedureName
    SELF.IniFileName   = IniFileName
    SELF.ProcedureName = ProcedureName
    Loc:stSortOrder = GETINI(CLIP(SELF.ProcedureName),'CurrentSortRow:' & SELF.ListControl,'?',SELF.IniFileName)
    IF CLIP(Loc:stSortOrder) <> '?'
      RowSortDefault = Loc:stSortOrder
    END
  END

  SELF.NoCase = True

  SELF.DisableNonViewColumns = True
  IF NOT OMITTED(pView)
     SELF.View &= pView
  END
  IF NOT OMITTED(pPK)
     SELF.PK &= pPK
  END
  IF RowSortDefault
    IF SELF.ListControl{PROPLIST:Exists,ABS(RowSortDefault)} AND SELF.ListControl{PROPLIST:Width,ABS(RowSortDefault)}>0
      SELF.PrevSortOrder = RowSortDefault
      SELF.SortOrder     = RowSortDefault
    ELSE
      SELF.PrevSortOrder = 1
      SELF.SortOrder     = 1
    END
  ELSE
    SELF.PrevSortOrder = 0
    SELF.SortOrder     = 0
  END

  Loc:lLoopIndex = 1
  LOOP
    IF SELF.ListControl{PROPLIST:Exists,Loc:lLoopIndex}
      SELF.QueueListHeader.ListHeaderText = SELF.ListControl{PROPLIST:Header,Loc:lLoopIndex}
      SELF.QueueListHeader.FieldNo        = SELF.ListControl{PROPLIST:FieldNo,Loc:lLoopIndex}
      ADD(SELF.QueueListHeader)
      Loc:lLoopIndex += 1
    ELSE
      BREAK
    END
  END
  SELF.ListControl{PROP:Alrt,255} = MouseLeft         !Set one column sort

  SELF.MouseRegionStatus = RegionStatus:MouseReleased

  IF RowSortDefault
    IF RowSortDefault < 0
      SELF.SortOrder = ABS(SELF.SortOrder)
    END
    SELF.SetPrevSortOrder()
    SELF.SortQueue()
    IF SELF.ForceFindRecord
       GET(SELF.ListQueue,1)
       SELF.FirstSortField = WHAT(SELF.ListQueue,SELF.ListControl{PROPLIST:FieldNo,SELF.SortOrder})
    END
  END

  RETURN
!------------------------------------------------------------------------------
SortHeaderClassType.SetAlerts              PROCEDURE()
  CODE
  0{PROP:Alrt,255} = ShiftMouseLeft    !Delete the sort
  0{PROP:Alrt,255} = CtrlMouseLeft     !Add one column to the sort
!------------------------------------------------------------------------------
SortHeaderClassType.TakeEvents PROCEDURE
  CODE
  IF SELF.RegionControl = 0
     RETURN(0)
  END
  IF EVENT() = EVENT:PreAlertKey
    SELF.LastKeyCode = KEYCODE()
    IF (SELF.LastKeyCode = ShiftMouseLeft OR SELF.LastKeyCode = MouseLeft OR SELF.LastKeyCode = CtrlMouseLeft)
      RETURN(1)
    END
  END
  IF EVENT() = EVENT:AlertKey
     IF KEYCODE() = MouseLeft
        IF FIELD() = SELF.ListControl AND SELF.ListControl{PROP:Visible}
           IF SELF.ListControl{PROPLIST:MouseDownRow} = 0 AND SELF.ListControl{PROPLIST:MouseDownZone} <> LISTZONE:Right
              SELF.MousePressed()
              SELF.MouseRegionStatus = RegionStatus:MousePressedAndInRegion
              SELF.LastKeyCode = KEYCODE()
              RETURN(1)
           ELSE
              IF SELF.ListControl{PROPLIST:MouseDownRow}>0
                 SELF.ListControl{PROP:SELECTED}=SELF.ListControl{PROPLIST:MouseDownRow}
                 POST(EVENT:NewSelection,SELF.ListControl)
                 RETURN(2)
              END
           END
        END
     END
  END
  IF EVENT() = EVENT:AlertKey AND (KEYCODE() = ShiftMouseLeft OR KEYCODE() = MouseLeft OR KEYCODE() = CtrlMouseLeft)
    IF (INRANGE(MOUSEX(),SELF.ListControl{PROP:XPos},SELF.ListControl{PROP:XPos}+SELF.ListControl{PROP:Width}-1) AND |
        INRANGE(MOUSEY(),SELF.ListControl{PROP:YPos},SELF.ListControl{PROP:YPos}+SELF.ListControl{PROP:HeaderHeight}-1) AND |
        SELF.ListControl{PROP:Visible} AND SELF.ListControl{PROPLIST:MouseDownZone} <> LISTZONE:Right|
        AND SELF.ListControl{PROPLIST:MouseDownField}>0) THEN
      SELF.MousePressed()
      SELF.MouseRegionStatus = RegionStatus:MousePressedAndInRegion
      SELF.LastKeyCode = KEYCODE()
      RETURN(1)
    END
  END
  IF SELF.ForceFindRecord
     IF FIELD() = SELF.ListControl
       CASE EVENT()
       OF EVENT:NewSelection
       OROF EVENT:Accepted
         GET(SELF.ListQueue,CHOICE(SELF.ListControl))
         SELF.FirstSortField = WHAT(SELF.ListQueue,SELF.ListControl{PROPLIST:FieldNo,ABS(SELF.GetSortOrder())})
         MESSAGE('FirstSortField='&SELF.FirstSortField)
       END
     END
  END
  IF FIELD() = SELF.RegionControl
    CASE EVENT()
    OF EVENT:MouseUp
      IF SELF.MouseRegionStatus = RegionStatus:MousePressedAndInRegion
        SELF.MouseReleased()
      ELSE
        SELF.RegionControl{PROP:Hide} = True
      END
      SELF.MouseRegionStatus = RegionStatus:MouseReleased
      SELECT(SELF.ListControl)
    OF EVENT:MouseOut
      IF SELF.MouseRegionStatus = RegionStatus:MousePressedAndInRegion
        IF ~SELF.CheckRangeRegion()
          SELF.SetRegionUp()
          SELF.MouseRegionStatus = RegionStatus:MousePressedAndOutRegion
        END
      END
    OF EVENT:MouseIn
    OROF EVENT:MouseMove
      IF SELF.MouseRegionStatus = RegionStatus:MousePressedAndOutRegion
        IF SELF.CheckRangeRegion()
          SELF.SetRegionDown()
          SELF.MouseRegionStatus = RegionStatus:MousePressedAndInRegion
        END
      END
    END
  END
  RETURN(0)
!------------------------------------------------------------------------------
SortHeaderClassType.SetSortOrder PROCEDURE(<LONG SortOrder>)
  CODE
  IF SELF.RegionControl
    IF ~OMITTED(2)
      SELF.SortOrder = SortOrder
    END
    IF SELF.SortOrder
      SELF.SetPrevSortOrder()
      SELF.SortQueue()
    END
  END
  RETURN
!------------------------------------------------------------------------------
SortHeaderClassType.GetSortOrder PROCEDURE
  CODE
  IF SELF.RegionControl
    IF RECORDS(SELF.QueueListSort)
      GET(SELF.QueueListSort,1)
      IF ABS(SELF.QueueListSort.PrevListSortColumn) = SELF.QueueListSort.ListSortColumn AND SELF.QueueListSort.PrevListSortColumn < 0
        RETURN(-SELF.QueueListSort.ListSortColumn)
      ELSE
        RETURN(SELF.QueueListSort.ListSortColumn)
      END
    ELSE
      RETURN(SELF.SortOrder)
    END
  ELSE
    RETURN(0)
  END
!------------------------------------------------------------------------------
SortHeaderClassType.Kill PROCEDURE

Loc:lLoopIndex LONG,AUTO

  CODE
  IF SELF.RegionControl
    IF SELF.IniFileName AND SELF.ProcedureName
      PUTINI(CLIP(SELF.ProcedureName),'CurrentSortRow:' & SELF.ListControl,SELF.GetSortOrder(),SELF.IniFileName)
    END
    SELF.RestoreHeaderText()
    FREE(SELF.QueueListHeader)
    DISPOSE(SELF.QueueListHeader)
    FREE(SELF.QueueListSort)
    DISPOSE(SELF.QueueListSort)
    DESTROY(SELF.RegionControl)
    SELF.RegionControl = 0
  END
  RETURN
!------------------------------------------------------------------------------

!=========================== Private Methods ==================================
SortHeaderClassType.SetPrevSortOrder PROCEDURE
  CODE
  CASE SELF.LastKeyCode
  OF MouseLeft
    IF ABS(SELF.PrevSortOrder) = SELF.SortOrder AND SELF.ForceChangeSignOrder = True
       SELF.PrevSortOrder = -1 * SELF.PrevSortOrder
    ELSE
       SELF.PrevSortOrder = ABS(SELF.SortOrder)
    END
    FREE(SELF.QueueListSort)
    CLEAR(SELF.QueueListSort)
    SELF.QueueListSort.ListSortColumn = SELF.SortOrder
    SELF.QueueListSort.PrevListSortColumn = SELF.PrevSortOrder
    ADD(SELF.QueueListSort)
    IF SELF.ForceFindRecord
       SELF.FirstSortField = WHAT(SELF.ListQueue,SELF.ListControl{PROPLIST:FieldNo,SELF.QueueListSort.ListSortColumn})
    END
  OF CtrlMouseLeft
    CLEAR(SELF.QueueListSort)
    SELF.QueueListSort.ListSortColumn = SELF.SortOrder
    GET(SELF.QueueListSort,+SELF.QueueListSort.ListSortColumn)
    IF ~ERRORCODE()
      IF SELF.ForceChangeSignOrder = True
        SELF.QueueListSort.PrevListSortColumn = -1 * SELF.QueueListSort.PrevListSortColumn
        PUT(SELF.QueueListSort)
      END
    ELSE
      SELF.QueueListSort.PrevListSortColumn = SELF.SortOrder
      ADD(SELF.QueueListSort)
      IF RECORDS(SELF.QueueListSort) = 2
        GET(SELF.QueueListSort,1)
        SELF.QueueListSort.PrevListSortColumn = SELF.PrevSortOrder
      END
    END
  OF ShiftMouseLeft
    SELF.ResetSort()
  END
  RETURN
!------------------------------------------------------------------------------
SortHeaderClassType.ValidField             PROCEDURE(STRING pColumnName)
F           &File
FieldIdx    BYTE,AUTO
FN          CSTRING(100)
Record      &GROUP,AUTO
ReturnValue BYTE,AUTO
  CODE
    ReturnValue = False
    IF pColumnName
       IF NOT(SELF.View &= NULL) AND SELF.DisableNonViewColumns
          LOOP FieldIdx = 1 to SELF.View{PROP:Fields}
            F &= SELF.View{PROP:FieldsFile, FieldIdx}
            Record &= F{PROP:Record}
            FN = Who(Record, SELF.View{PROP:Field, FieldIdx})
            IF UPPER(FN) = UPPER(pColumnName)
               ReturnValue = True
               BREAK
            END
          END
       ELSE
           ReturnValue = True
       END
    END
    RETURN ReturnValue
!------------------------------------------------------------------------------
SortHeaderClassType.MousePressed PROCEDURE

Loc:lDelta   LONG,AUTO
Loc:lDeltaX  LONG,AUTO
Loc:byPixels BYTE,AUTO
Loc:OldControl LONG,AUTO
RW   LONG
RX   LONG
LW   LONG
LX   LONG
ScrollWidth LONG,AUTO
lRow    SHORT,AUTO
  CODE
  IF SELF.ListControl{PROPLIST:MouseDownField}
     IF NOT SELF.ValidField(SELF.GetColumnName(SELF.ListControl{PROPLIST:MouseDownField}))
        RETURN
     END
  ELSE
     RETURN
  END
  SELF.SortOrder = SELF.ListControl{PROPLIST:MouseDownField}
  Loc:OldControl = 0
  Loc:byPixels = False
  Loc:byPixels = 0{PROP:Pixels}
  0{PROP:Pixels} = True
  Loc:OldControl = SELF.ListControl{PROP:Edit,SELF.SortOrder}
  SELF.ListControl{PROP:Edit,SELF.SortOrder} = SELF.RegionControl
  IF Loc:OldControl=SELF.RegionControl
     Loc:OldControl=0
  END
  SELF.ListControl{PROP:Edit,SELF.SortOrder} = Loc:OldControl
  lRow = SELF.FieldInGroup()
  IF lRow
    SELF.RegionControl{PROP:Height} = SELF.ListControl{PROP:HeaderHeight} / (SELF.ListControl{PROPLIST:GroupNo + PROPLIST:Group,SELF.SortOrder}+0) - 1
    IF SELF.ListControl{PROP:FLAT}
       SELF.RegionControl{PROP:YPos} = SELF.RegionControl{PROP:YPos} - 4
       SELF.RegionControl{PROP:XPos} = SELF.RegionControl{PROP:XPos} + 1
       SELF.RegionControl{PROP:Width} = SELF.RegionControl{PROP:Width} - 1
       SELF.RegionControl{PROP:YPos} = (lRow * (SELF.ListControl{PROP:HeaderHeight} / (SELF.ListControl{PROPLIST:GroupNo + PROPLIST:Group,SELF.SortOrder}+0)))-SELF.RegionControl{PROP:Height}
    ELSE
       SELF.RegionControl{PROP:YPos} = (lRow * ((SELF.ListControl{PROP:HeaderHeight} / (SELF.ListControl{PROPLIST:GroupNo + PROPLIST:Group,SELF.SortOrder}+0)) - 1))-SELF.RegionControl{PROP:Height}
    END
  ELSE
    SELF.RegionControl{PROP:YPos} = 0
    SELF.RegionControl{PROP:Height} = SELF.ListControl{PROP:HeaderHeight} - 1
  END
  IF SELF.ListControl{PROPLIST:Icon,SELF.SortOrder}
    Loc:lDelta = SELF.ListControl{PROPLIST:Width,SELF.SortOrder} - SELF.RegionControl{PROP:Width}
    SELF.RegionControl{PROP:XPos} = SELF.RegionControl{PROP:XPos} - Loc:lDelta
    SELF.RegionControl{PROP:Width} = SELF.RegionControl{PROP:Width} + Loc:lDelta
  END
  SELF.RegionControl{PROP:XPos} = SELF.RegionControl{PROP:XPos} - 1
  SELF.RegionControl{PROP:Width} = SELF.RegionControl{PROP:Width}
  IF SELF.ListControl{PROP:VScroll}
     ScrollWidth = 20
  ELSE
     ScrollWidth = 3
  END
  IF (SELF.RegionControl{PROP:XPos}+SELF.RegionControl{PROP:Width}>=SELF.ListControl{PROP:Width}-ScrollWidth)
      SELF.RegionControl{PROP:Width}=SELF.RegionControl{PROP:Width}-(SELF.RegionControl{PROP:XPos}+SELF.RegionControl{PROP:Width}-(SELF.ListControl{PROP:Width}-ScrollWidth+1))
  END
  0{PROP:Pixels} = Loc:byPixels
  SELF.SetRegionDown()
  SELF.RegionControl{PROP:YPos} = SELF.RegionControl{PROP:YPos}+SELF.ListControl{PROP:YPos}+1
  SELF.RegionControl{PROP:XPos} = SELF.RegionControl{PROP:XPos}+SELF.ListControl{PROP:XPos}+1
  SELF.RegionControl{PROP:Hide} = False
  RETURN
!------------------------------------------------------------------------------
SortHeaderClassType.MouseReleased PROCEDURE

Loc:lPointer LONG,AUTO

  CODE
  IF SELF.ListControl{PROPLIST:MouseDownField}
     IF NOT SELF.ValidField(SELF.GetColumnName(SELF.ListControl{PROPLIST:MouseDownField}))
        RETURN
     END
  END
  SELF.SortOrder = SELF.ListControl{PROPLIST:MouseDownField}
  SELF.RegionControl{PROP:Hide} = True
  SELF.ForceChangeSignOrder = True
  SELF.SetPrevSortOrder()
  GET(SELF.ListQueue,CHOICE(SELF.ListControl))
  SELF.SortQueue()
  IF ABS(SELF.PrevSortOrder) <> SELF.SortOrder
    SELF.PrevSortOrder = SELF.SortOrder
  END
  SELF.SetRegionUp()
  IF SELF.ForceFindRecord
     Loc:lPointer = SELF.FindRecord()
     IF Loc:lPointer
       SELECT(SELF.ListControl,Loc:lPointer)
     ELSE
       SELECT(SELF.ListControl)
     END
  END
  POST(EVENT:NewSelection,SELF.ListControl)
  RETURN
!------------------------------------------------------------------------------
SortHeaderClassType.FieldInGroup FUNCTION

lRow    SHORT,AUTO
lGroup  SHORT,AUTO
lIndex  SHORT,AUTO
  CODE
     IF SELF.ListControl{PROPLIST:GroupNo + PROPLIST:Group,SELF.SortOrder}+0=0
        RETURN 0
     ELSE
        lGroup = SELF.ListControl{PROPLIST:GroupNo,SELF.SortOrder}+0
        lRow   = 0
        lIndex = 0
        LOOP lIndex=SELF.SortOrder TO 1 BY -1
             IF lGroup<>SELF.ListControl{PROPLIST:GroupNo,lIndex}+0
                BREAK
             END
             lRow+=1
        END
        RETURN lRow
     END
!------------------------------------------------------------------------------
SortHeaderClassType.ResetSort   PROCEDURE()
  CODE
    SELF.ClearSort()
    SELF.QueueResorted('')
    RETURN
!------------------------------------------------------------------------------
SortHeaderClassType.RestoreHeaderText PROCEDURE
Loc:lLoopIndex   LONG,AUTO
Loc:lLoopIndex2  LONG,AUTO
  CODE
  Loc:lLoopIndex = 1
  LOOP
    IF SELF.ListControl{PROPLIST:Exists,Loc:lLoopIndex}
       LOOP Loc:lLoopIndex2=1 TO RECORDS(SELF.QueueListHeader)
            GET(SELF.QueueListHeader,Loc:lLoopIndex2)
            IF SELF.QueueListHeader.FieldNo = SELF.ListControl{PROPLIST:FieldNo,Loc:lLoopIndex} THEN
               SELF.ListControl{PROPLIST:Header,Loc:lLoopIndex}=SELF.QueueListHeader.ListHeaderText
               BREAK
            END
       END
       Loc:lLoopIndex += 1
    ELSE
      BREAK
    END
  END
!------------------------------------------------------------------------------
SortHeaderClassType.GetColumnText PROCEDURE(LONG pColumn)
Loc:lLoopIndex2  LONG,AUTO
  CODE
    IF SELF.ListControl{PROPLIST:Exists,pColumn}
       LOOP Loc:lLoopIndex2=1 TO RECORDS(SELF.QueueListHeader)
            GET(SELF.QueueListHeader,Loc:lLoopIndex2)
            IF SELF.QueueListHeader.FieldNo = SELF.ListControl{PROPLIST:FieldNo,pColumn} THEN
               RETURN CLIP(SELF.QueueListHeader.ListHeaderText)
               BREAK
            END
       END
    END
  RETURN ''
!------------------------------------------------------------------------------
SortHeaderClassType.GetColumnName PROCEDURE(LONG pColumn)
Loc:lLoopIndex2  LONG,AUTO
  CODE
    IF pColumn
       IF SELF.ListControl{PROPLIST:Exists,pColumn}
          LOOP Loc:lLoopIndex2=1 TO RECORDS(SELF.QueueListHeader)
               GET(SELF.QueueListHeader,Loc:lLoopIndex2)
               IF SELF.QueueListHeader.FieldNo = SELF.ListControl{PROPLIST:FieldNo,pColumn} THEN
                  RETURN UPPER(WHO(SELF.ListQueue,SELF.ListControl{PROPLIST:FieldNo,pColumn}))
                  BREAK
               END
          END
       END
    END
  RETURN ''
!------------------------------------------------------------------------------
SortHeaderClassType.ClearSort PROCEDURE
 CODE
  SELF.RestoreHeaderText()
  SELF.SortOrder =0
  SELF.PrevSortOrder=0
  FREE(SELF.QueueListSort)
!------------------------------------------------------------------------------
SortHeaderClassType.GetSortingColumnString PROCEDURE(STRING pSign,STRING pColumnName,STRING pColumnPicture)
 CODE
    CASE SUB(UPPER(pColumnPicture)&'@S',2,1)
    OF 'N' OROF 'T' OROF 'D' OROF 'E'
       RETURN pSign&pColumnName
    ELSE
       IF SELF.NoCase
          RETURN pSign&'UPPER('&pColumnName&')'
       ELSE
          RETURN pSign&pColumnName
       END
    END
!------------------------------------------------------------------------------
SortHeaderClassType.SortQueue PROCEDURE
Loc:lLoopIndex   LONG,AUTO
Loc:stSortString STRING(10 * 1024),AUTO
Loc:stSign       STRING(1),AUTO
KFile            &File
FieldIdx         BYTE,AUTO
lFound           BYTE, AUTO
lPicture         STRING(10)
  CODE
  IF SELF.SortOrder=0 THEN
     RETURN
  END
  IF SELF.ListControl{PROPLIST:Exists,SELF.SortOrder} = 0 OR SELF.ListControl{PROPLIST:Width,SELF.SortOrder} = 0
    SELF.SortOrder = ABS(SELF.PrevSortOrder)
    RETURN
  END
  SELF.RestoreHeaderText()
  CLEAR(Loc:stSortString)
  LOOP Loc:lLoopIndex = 1 TO RECORDS(SELF.QueueListSort)
    GET(SELF.QueueListSort,Loc:lLoopIndex)
    IF ABS(SELF.QueueListSort.PrevListSortColumn) = SELF.QueueListSort.ListSortColumn AND SELF.QueueListSort.PrevListSortColumn < 0
      Loc:stSign = '-'
    ELSE
      Loc:stSign = '+'
    END
    SELF.ListControl{PROPLIST:Header,SELF.QueueListSort.ListSortColumn} = |
    CLIP(SELF.GetColumnText(SELF.QueueListSort.ListSortColumn)) & '[' & Loc:stSign & CHOOSE(RECORDS(SELF.QueueListSort) = 1,'',CLIP(Loc:lLoopIndex)) & ']'
    lPicture = SELF.ListControl{PROPLIST:Picture,SELF.QueueListSort.ListSortColumn}
    Loc:stSortString = CLIP(Loc:stSortString) & CHOOSE(LEN(CLIP(Loc:stSortString)) = 0,'',',') & SELF.GetSortingColumnString(Loc:stSign,WHO(SELF.ListQueue,SELF.ListControl{PROPLIST:FieldNo,SELF.QueueListSort.ListSortColumn}),lPicture)
  END
  IF NOT SELF.PK &=NULL
     KFile &= SELF.PK{PROP:File}
     LOOP FieldIdx=1 TO SELF.PK{PROP:Components}
          lFound = False
          LOOP Loc:lLoopIndex = 1 TO RECORDS(SELF.QueueListSort)
               GET(SELF.QueueListSort,Loc:lLoopIndex)
               IF ABS(SELF.QueueListSort.PrevListSortColumn) = SELF.QueueListSort.ListSortColumn AND SELF.QueueListSort.PrevListSortColumn < 0
                 Loc:stSign = '-'
               ELSE
                 Loc:stSign = '+'
               END
               lPicture = SELF.ListControl{PROPLIST:Picture,SELF.QueueListSort.ListSortColumn}
               IF (UPPER(SELF.GetSortingColumnString(Loc:stSign,WHO(SELF.ListQueue,SELF.ListControl{PROPLIST:FieldNo,SELF.QueueListSort.ListSortColumn}),lPicture))='+'&UPPER(KFile{PROP:Label,SELF.PK{PROP:Field, FieldIdx}}) OR |
                  UPPER(SELF.GetSortingColumnString(Loc:stSign,WHO(SELF.ListQueue,SELF.ListControl{PROPLIST:FieldNo,SELF.QueueListSort.ListSortColumn}),lPicture))='-'&UPPER(KFile{PROP:Label,SELF.PK{PROP:Field, FieldIdx}}) )
                  lFound = True
                  BREAK
               END
          END
          IF NOT lFound
             Loc:stSortString = CLIP(Loc:stSortString) & CHOOSE(LEN(CLIP(Loc:stSortString)) = 0,'',',') & CHOOSE(SELF.PK{PROP:Ascending,FieldIdx}=1,'+','-') &UPPER(KFile{PROP:Label,SELF.PK{PROP:Field, FieldIdx}})
          END
     END
  END
  SELF.QueueResorted(Loc:stSortString)
  SORT(SELF.ListQueue,Loc:stSortString)
  SELF.ForceChangeSignOrder = False
  RETURN
!------------------------------------------------------------------------------
SortHeaderClassType.SetRegionUp PROCEDURE
  CODE
  SELF.RegionControl{PROP:BevelInner} = 0
  SELF.RegionControl{PROP:BevelOuter} = 0
  IF SELF.ListControl{PROPLIST:HeaderLeft,SELF.SortOrder}
    SELF.ListControl{PROPLIST:HeaderLeftOffset,SELF.SortOrder} = SELF.ListControl{PROPLIST:HeaderLeftOffset,SELF.SortOrder} - 1
  END
  IF SELF.ListControl{PROPLIST:HeaderRight,SELF.SortOrder}
    SELF.ListControl{PROPLIST:HeaderRightOffset,SELF.SortOrder} = SELF.ListControl{PROPLIST:HeaderRightOffset,SELF.SortOrder} + 1
  END
  IF SELF.ListControl{PROPLIST:HeaderCenter,SELF.SortOrder}
    SELF.ListControl{PROPLIST:HeaderCenterOffset,SELF.SortOrder} = SELF.ListControl{PROPLIST:HeaderCenterOffset,SELF.SortOrder} - 1
  END
  IF SELF.ListControl{PROPLIST:HeaderDecimal,SELF.QueueListSort.ListSortColumn}
    SELF.ListControl{PROPLIST:HeaderDecimalOffset,SELF.SortOrder} = SELF.ListControl{PROPLIST:HeaderDecimalOffset,SELF.SortOrder} + 1
  END
  RETURN
!------------------------------------------------------------------------------
SortHeaderClassType.SetRegionDown PROCEDURE
  CODE
  SELF.RegionControl{PROP:BevelInner} = -1
  SELF.RegionControl{PROP:BevelOuter} = -1
  IF SELF.ListControl{PROPLIST:HeaderLeft,SELF.SortOrder}
    SELF.ListControl{PROPLIST:HeaderLeftOffset,SELF.SortOrder} = SELF.ListControl{PROPLIST:HeaderLeftOffset,SELF.SortOrder} + 1
  END
  IF SELF.ListControl{PROPLIST:HeaderRight,SELF.SortOrder}
    SELF.ListControl{PROPLIST:HeaderRightOffset,SELF.SortOrder} = SELF.ListControl{PROPLIST:HeaderRightOffset,SELF.SortOrder} - 1
  END
  IF SELF.ListControl{PROPLIST:HeaderCenter,SELF.SortOrder}
    SELF.ListControl{PROPLIST:HeaderCenterOffset,SELF.SortOrder} = SELF.ListControl{PROPLIST:HeaderCenterOffset,SELF.SortOrder} + 1
  END
  IF SELF.ListControl{PROPLIST:HeaderDecimal,SELF.SortOrder}
    SELF.ListControl{PROPLIST:HeaderDecimalOffset,SELF.SortOrder} = SELF.ListControl{PROPLIST:HeaderDecimalOffset,SELF.SortOrder} - 1
  END
  RETURN
!------------------------------------------------------------------------------
SortHeaderClassType.CheckRangeRegion PROCEDURE
  CODE
  IF MOUSEX() > SELF.ListControl{PROP:Xpos} + SELF.RegionControl{PROP:Xpos}                                  AND |
     MOUSEX() < SELF.ListControl{PROP:Xpos} + SELF.RegionControl{PROP:Xpos} + SELF.RegionControl{PROP:Width} AND |
     MOUSEY() > SELF.ListControl{PROP:Ypos} + SELF.RegionControl{PROP:Ypos}                                  AND |
     MOUSEY() < SELF.ListControl{PROP:Ypos} + SELF.RegionControl{PROP:Ypos} + SELF.RegionControl{PROP:Height} 
    RETURN(1)
  ELSE
    RETURN(0)
  END
!------------------------------------------------------------------------------
SortHeaderClassType.FindRecord PROCEDURE

Loc:lCurrentColumn LONG,AUTO
Loc:lPointer       LONG,AUTO
Loc:stSortString   STRING(1024),AUTO
Loc:anyField       ANY,AUTO

  CODE
  Loc:lCurrentColumn = SELF.GetSortOrder()
  Loc:lPointer = 0
  CLEAR(SELF.ListQueue)                                                 
  Loc:anyField &= WHAT(SELF.ListQueue,SELF.ListControl{PROPLIST:FieldNo,SELF.QueueListSort.ListSortColumn})
  Loc:anyField = CLIP(SELF.FirstSortField)
  Loc:stSortString = CHOOSE(Loc:lCurrentColumn > 0,'+','-') & WHO(SELF.ListQueue,SELF.ListControl{PROPLIST:FieldNo,SELF.QueueListSort.ListSortColumn})
  GET(SELF.ListQueue,Loc:stSortString)
  IF ~ERRORCODE()
    Loc:lPointer = POINTER(SELF.ListQueue)
  ELSE
    ADD(SELF.ListQueue,Loc:stSortString)
    GET(SELF.ListQueue,Loc:stSortString)
    Loc:lPointer = POINTER(SELF.ListQueue)
    IF Loc:lCurrentColumn < 0
      IF Loc:lPointer > 1
        Loc:lPointer -= 1
      END
    END
    DELETE(SELF.ListQueue)
    IF Loc:lPointer > RECORDS(SELF.ListQueue)
      Loc:lPointer = RECORDS(SELF.ListQueue)
    END
  END
  Loc:anyField &= NULL
  RETURN(Loc:lPointer)
!------------------------------------------------------------------------------

!=========================== Virtual Methods ==================================
SortHeaderClassType.QueueResorted PROCEDURE(STRING pSortingString)
  CODE
  RETURN
!------------------------------------------------------------------------------
!==============================================================================
!
!  AutoSizeColumnClassType
!
! 
!
!==============================================================================
!============================ Public Methods ==================================
AutoSizeColumnClassType.Init PROCEDURE
  CODE
  IF SELF.Initialized = False
    SELF.Initialized = True
    SELF.QueueAutoSizeListBox &= NEW(BrwExtQueueAutoSizeListBoxType)
    SELF.StringControl = CREATE(0,CREATE:String)
  END
  RETURN
!------------------------------------------------------------------------------
AutoSizeColumnClassType.AddListBox PROCEDURE(SIGNED ListControl,QUEUE ListQueue)
  CODE
  IF SELF.Initialized = False
    SELF.Init()
  END
  SELF.QueueAutoSizeListBox.AutoSizeListBoxControl = ListControl
  GET(SELF.QueueAutoSizeListBox,+SELF.QueueAutoSizeListBox.AutoSizeListBoxControl)
  IF ERRORCODE()
    SELF.QueueAutoSizeListBox.AutoSizeListBoxQueue &= ListQueue
    ADD(SELF.QueueAutoSizeListBox,+SELF.QueueAutoSizeListBox.AutoSizeListBoxQueue)
    SELF.QueueAutoSizeListBox.AutoSizeListBoxControl{PROP:Alrt,255} = MouseLeft2
  END
  RETURN
!------------------------------------------------------------------------------
AutoSizeColumnClassType.TakeEvents PROCEDURE
  CODE
  IF SELF.Initialized
    IF EVENT() = EVENT:AlertKey AND KEYCODE() = MouseLeft2
      SELF.QueueAutoSizeListBox.AutoSizeListBoxControl = FIELD()
      GET(SELF.QueueAutoSizeListBox,+SELF.QueueAutoSizeListBox.AutoSizeListBoxControl)
      IF ~ERRORCODE()
        IF SELF.QueueAutoSizeListBox.AutoSizeListBoxControl{PROPLIST:MouseDownZone} = LISTZONE:right
          SELF.ResizeColumn(SELF.QueueAutoSizeListBox.AutoSizeListBoxControl,SELF.QueueAutoSizeListBox.AutoSizeListBoxControl{PROPLIST:MouseDownField})
          RETURN(1)
        END
      END
    END
  END
  RETURN(0)
!------------------------------------------------------------------------------
AutoSizeColumnClassType.ResizeColumn PROCEDURE(SIGNED ListControl,LONG Column)

Loc:lLoopIndex       LONG,AUTO
Loc:lColumnWidth     LONG,AUTO
Loc:lTempColumnWidth LONG,AUTO
Loc:lStyleColumn     LONG,AUTO
Loc:lStyle           LONG,AUTO
Loc:lGroupSize       LONG,AUTO

  CODE
  IF SELF.Initialized
    SELF.QueueAutoSizeListBox.AutoSizeListBoxControl = ListControl
    GET(SELF.QueueAutoSizeListBox,+SELF.QueueAutoSizeListBox.AutoSizeListBoxControl)
    IF ERRORCODE()
      RETURN
    END
    IF ListControl{PROPLIST:Exists,Column} AND ListControl{PROPLIST:Resize,Column} AND ListControl{PROPLIST:Width,Column} > 0
      Loc:lColumnWidth = 0
      IF ListControl{PROPLIST:Header,Column}
        SELF.StringControl{PROP:FontName}    = ListControl{PROP:FontName}
        SELF.StringControl{PROP:FontSize}    = ListControl{PROP:FontSize}
        SELF.StringControl{PROP:FontStyle}   = ListControl{PROP:FontStyle}
        SELF.StringControl{PROP:FontCharSet} = ListControl{PROP:CharSet}
        SELF.StringControl{PROP:Text}        = ListControl{PROPLIST:Header,Column}
        Loc:lColumnWidth = SELF.StringControl{PROP:Width} + 2
        Loc:lColumnWidth += 2 * ListControl{PROPLIST:HeaderLeftOffset}
        Loc:lColumnWidth += 2 * ListControl{PROPLIST:HeaderRightOffset}
        Loc:lColumnWidth += 2 * ListControl{PROPLIST:HeaderCenterOffset}
        Loc:lColumnWidth += 2 * ListControl{PROPLIST:HeaderDecimalOffset}
      END
      LOOP Loc:lLoopIndex = 1 TO RECORDS(SELF.QueueAutoSizeListBox.AutoSizeListBoxQueue)
        GET(SELF.QueueAutoSizeListBox.AutoSizeListBoxQueue,Loc:lLoopIndex)
        SELF.StringControl{PROP:FontName}    = ListControl{PROP:FontName}
        SELF.StringControl{PROP:FontSize}    = ListControl{PROP:FontSize}
        SELF.StringControl{PROP:FontStyle}   = ListControl{PROP:FontStyle}
        SELF.StringControl{PROP:FontCharSet} = ListControl{PROP:CharSet}
        IF ListControl{PROPLIST:CellStyle,Column}
          Loc:lStyleColumn = ListControl{PROPLIST:FieldNo,Column} + 1
          IF ListControl{PROPLIST:Icon,Column}
            Loc:lStyleColumn += 1
          END
          IF ListControl{PROPLIST:Color,Column}
            Loc:lStyleColumn += 4
          END
          Loc:lStyle = WHAT(SELF.QueueAutoSizeListBox.AutoSizeListBoxQueue,Loc:lStyleColumn)
          IF ListControl{PROPSTYLE:FontName,Loc:lStyle}
            SELF.StringControl{PROP:FontName} = ListControl{PROPSTYLE:FontName,Loc:lStyle}
          END
          IF ListControl{PROPSTYLE:FontSize,Loc:lStyle}
            SELF.StringControl{PROP:FontSize} = ListControl{PROPSTYLE:FontSize,Loc:lStyle}
          END
          IF ListControl{PROPSTYLE:FontStyle,Loc:lStyle}
            SELF.StringControl{PROP:FontStyle} = ListControl{PROPSTYLE:FontStyle,Loc:lStyle}
          END
          IF ListControl{PROPSTYLE:CharSet,Loc:lStyle}
            SELF.StringControl{PROP:FontCharSet} = ListControl{PROPSTYLE:CharSet,Loc:lStyle}
          END
        END
        SELF.StringControl{PROP:Text} = CLIP(LEFT(FORMAT(WHAT(SELF.QueueAutoSizeListBox.AutoSizeListBoxQueue,ListControl{PROPLIST:FieldNo,Column}),ListControl{PROPLIST:Picture,Column})))
        Loc:lTempColumnWidth = SELF.StringControl{PROP:Width}
        Loc:lTempColumnWidth += 2 * ListControl{PROPLIST:LeftOffset,Column}
        Loc:lTempColumnWidth += 2 * ListControl{PROPLIST:RightOffset,Column}
        Loc:lTempColumnWidth += 2 * ListControl{PROPLIST:CenterOffset,Column}
        Loc:lTempColumnWidth += 2 * ListControl{PROPLIST:DecimalOffset,Column}
        IF ListControl{PROPLIST:Icon,Column}
          Loc:lTempColumnWidth += SELF.StringControl{PROP:FontSize}
          Loc:lTempColumnWidth += ListControl{Prop:LineHeight} - ListControl{PROP:FontSize}
        END
        Loc:lTempColumnWidth += 1
        IF Loc:lColumnWidth < Loc:lTempColumnWidth
          Loc:lColumnWidth = Loc:lTempColumnWidth
        END
      END
      ListControl{PROPLIST:Width,Column} = Loc:lColumnWidth
      Loc:lGroupSize = 0
      Loc:lLoopIndex = 1
      LOOP UNTIL ~ListControl{PROPLIST:Exists,Loc:lLoopIndex}
        IF ListControl{PROPLIST:GroupNo,Loc:lLoopIndex} = ListControl{PROPLIST:GroupNo,Column}
          Loc:lGroupSize += ListControl{PROPLIST:Width,Loc:lLoopIndex}
        END
        Loc:lLoopIndex += 1
      END
      ListControl{PROPLIST:Width+PROPLIST:Group,Column} = Loc:lGroupSize
      SELF.StringControl{PROP:Text} = ''
    END
  END
  RETURN
!------------------------------------------------------------------------------
AutoSizeColumnClassType.ResizeAll PROCEDURE

Loc:lLoopIndex LONG,AUTO

  CODE
  IF SELF.Initialized
    LOOP Loc:lLoopIndex = 1 TO RECORDS(SELF.QueueAutoSizeListBox)
      GET(SELF.QueueAutoSizeListBox,Loc:lLoopIndex)
      SELF.ResizeAll(SELF.QueueAutoSizeListBox.AutoSizeListBoxControl)
    END
  END
  RETURN
!------------------------------------------------------------------------------
AutoSizeColumnClassType.ResizeAll PROCEDURE(SIGNED ListControl)

Loc:lLoopIndex LONG,AUTO

  CODE
  IF SELF.Initialized
    SELF.QueueAutoSizeListBox.AutoSizeListBoxControl = ListControl
    GET(SELF.QueueAutoSizeListBox,+SELF.QueueAutoSizeListBox.AutoSizeListBoxControl)
    IF ~ERRORCODE()
      SETCURSOR(Cursor:Wait)
      Loc:lLoopIndex = 1
      LOOP UNTIL ~SELF.QueueAutoSizeListBox.AutoSizeListBoxControl{PROPLIST:Exists,Loc:lLoopIndex}
        SELF.ResizeColumn(SELF.QueueAutoSizeListBox.AutoSizeListBoxControl,Loc:lLoopIndex)
        Loc:lLoopIndex += 1
      END
      SETCURSOR
    END
  END
  RETURN
!------------------------------------------------------------------------------
AutoSizeColumnClassType.Kill PROCEDURE
  CODE
  IF SELF.Initialized
    DESTROY(SELF.StringControl)
    FREE(SELF.QueueAutoSizeListBox)
    DISPOSE(SELF.QueueAutoSizeListBox)
  END
  RETURN
!------------------------------------------------------------------------------
