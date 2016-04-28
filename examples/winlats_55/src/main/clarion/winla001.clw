                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateNodalas PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
Update::Reloop  BYTE
Update::Error   BYTE
History::NOD:Record LIKE(NOD:Record),STATIC
SAV::NOD:Record      LIKE(NOD:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the NODALAS File'),AT(,,362,116),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateNodalas'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(4,4,357,95),USE(?CurrentTab)
                         TAB('Nodaïa'),USE(?Tab:1)
                           PROMPT('No&daïa:'),AT(7,31),USE(?NOD:U_NR:Prompt)
                           ENTRY(@S2),AT(48,31,15,10),USE(NOD:U_NR),LEFT,REQ
                           STRING('(aizpildiet abas zîmes; virsrakstiem-pirmo)'),AT(67,32),USE(?String1)
                           PROMPT('Kods:'),AT(7,44),USE(?NOD:KODS:Prompt)
                           ENTRY(@s6),AT(48,44,35,10),USE(NOD:KODS)
                           PROMPT('&Nosaukums:'),AT(7,57,43,10),USE(?NOD:NOS_P:Prompt)
                           ENTRY(@S90),AT(48,57,311,10),USE(NOD:NOS_P)
                           PROMPT('&Svars:'),AT(7,70,24,10),USE(?Prompt:svars)
                           ENTRY(@N2),AT(48,70,40,10),USE(NOD:SVARS),RIGHT(1)
                         END
                       END
                       BUTTON('&OK'),AT(266,101,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(315,101,45,14),USE(?Cancel)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
  END
  QuickWindow{Prop:Text} = ActionMessage
  ENABLE(TBarBrwHistory)
  ACCEPT
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE() = 734 THEN
        DO HistoryField
      END
    OF EVENT:CloseWindow
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
    OF EVENT:CloseDown
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?NOD:U_NR:Prompt)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ACCEPTED() = TbarBrwHistory
        DO HistoryField
      END
      IF EVENT() = Event:Completed
        History::NOD:Record = NOD:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(NODALAS)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(NOD:Nr_Key)
              IF StandardWarning(Warn:DuplicateKey,'NOD:Nr_Key')
                SELECT(?NOD:U_NR:Prompt)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?NOD:U_NR:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::NOD:Record <> NOD:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:NODALAS(1)
            ELSE
              Update::Error = 0
            END
            SETCURSOR()
            IF Update::Error THEN
              IF Update::Error = 1 THEN
                CASE StandardWarning(Warn:UpdateError)
                OF Button:Yes
                  CYCLE
                OF Button:No
                  POST(Event:CloseWindow)
                  BREAK
                END
              END
              DISPLAY
              SELECT(?NOD:U_NR:Prompt)
              VCRRequest = VCRNone
            ELSE
              IF RecordChanged OR VCRRequest = VCRNone THEN
                LocalResponse = RequestCompleted
              END
              POST(Event:CloseWindow)
            END
            BREAK
          END
        END
      END
      IF ToolbarMode = FormMode THEN
        CASE ACCEPTED()
        OF TBarBrwBottom TO TBarBrwUp
        OROF TBarBrwInsert
          VCRRequest=ACCEPTED()
          POST(EVENT:Completed)
        OF TBarBrwHelp
          PRESSKEY(F1Key)
        END
      END
    END
    CASE FIELD()
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
          !Code to assign button control based upon current tab selection
          CASE CHOICE(?CurrentTab)
          OF 1
            DO FORM::AssignButtons
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?NOD:SVARS
      CASE EVENT()
      OF EVENT:Accepted
        IF NOD:SVARS > 100
          IF StandardWarning(Warn:OutOfRangeHigh,'NOD:SVARS','100')
            SELECT(?NOD:SVARS)
            QuickWindow{Prop:AcceptAll} = False
            CYCLE
          END
        END
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF NODALAS::Used = 0
    CheckOpen(NODALAS,1)
  END
  NODALAS::Used += 1
  BIND(NOD:RECORD)
  FilesOpened = True
  RISnap:NODALAS
  SAV::NOD:Record = NOD:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:NODALAS()
          SETCURSOR()
          CASE StandardWarning(Warn:DeleteError)
          OF Button:Yes
            CYCLE
          OF Button:No OROF Button:Cancel
            BREAK
          END
        ELSE
          SETCURSOR()
          LocalResponse = RequestCompleted
        END
        BREAK
      END
    END
    DO ProcedureReturn
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('UpdateNodalas','winlats.INI')
  WinResize.Resize
  ?NOD:U_NR{PROP:Alrt,255} = 734
  ?NOD:KODS{PROP:Alrt,255} = 734
  ?NOD:NOS_P{PROP:Alrt,255} = 734
  ?NOD:SVARS{PROP:Alrt,255} = 734
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, if it was opened by this procedure, the window is closed.
!|
!| Next, GlobalResponse is assigned a value to signal the calling procedure
!| what happened in this procedure.
!|
!| Next, we replace the BINDings that were in place when the procedure initialized
!| (and saved with PUSHBIND) using POPBIND.
!|
!| Finally, we return to the calling procedure.
!|
  IF FilesOpened
    NODALAS::Used -= 1
    IF NODALAS::Used = 0 THEN CLOSE(NODALAS).
  END
  IF WindowOpened
    INISaveWindow('UpdateNodalas','winlats.INI')
    CLOSE(QuickWindow)
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!---------------------------------------------------------------------------
InitializeWindow ROUTINE
!|
!| This routine is used to prepare any control templates for use. It should be called once
!| per procedure.
!|
  DO RefreshWindow
!---------------------------------------------------------------------------
RefreshWindow ROUTINE
!|
!| This routine is used to keep all displays and control templates current.
!|
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
!---------------------------------------------------------------------------
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?NOD:U_NR
      NOD:U_NR = History::NOD:Record.U_NR
    OF ?NOD:KODS
      NOD:KODS = History::NOD:Record.KODS
    OF ?NOD:NOS_P
      NOD:NOS_P = History::NOD:Record.NOS_P
    OF ?NOD:SVARS
      NOD:SVARS = History::NOD:Record.SVARS
  END
  DISPLAY()
!---------------------------------------------------------------
PrimeFields ROUTINE
!|
!| This routine is called whenever the procedure is called to insert a record.
!|
!| This procedure performs three functions. These functions are..
!|
!|   1. Prime the new record with initial values specified in the dictionary
!|      and under the Field priming on Insert button.
!|   2. Generates any Auto-Increment values needed.
!|   3. Saves a copy of the new record, as primed, for use in batch-adds.
!|
!| If an auto-increment value is generated, this routine will add the new record
!| at this point, keeping its place in the file.
!|
  NOD:Record = SAV::NOD:Record
  SAV::NOD:Record = NOD:Record
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    DO CancelAutoIncrement
  END

CancelAutoIncrement ROUTINE
  IF LocalResponse <> RequestCompleted
  END
FORM::AssignButtons ROUTINE
  ToolBarMode=FormMode
  DISABLE(TBarBrwFirst,TBarBrwLast)
  ENABLE(TBarBrwHistory)
  CASE OriginalRequest
  OF InsertRecord
    ENABLE(TBarBrwDown)
    ENABLE(TBarBrwInsert)
    TBarBrwDown{PROP:ToolTip}='Save record and add another'
    TBarBrwInsert{PROP:ToolTip}=TBarBrwDown{PROP:ToolTip}
  OF ChangeRecord
    ENABLE(TBarBrwBottom,TBarBrwUp)
    ENABLE(TBarBrwInsert)
    TBarBrwBottom{PROP:ToolTip}='Save changes and go to last record'
    TBarBrwTop{PROP:ToolTip}='Save changes and go to first record'
    TBarBrwPageDown{PROP:ToolTip}='Save changes and page down to record'
    TBarBrwPageUp{PROP:ToolTip}='Save changes and page up to record'
    TBarBrwDown{PROP:ToolTip}='Save changes and go to next record'
    TBarBrwUP{PROP:ToolTip}='Save changes and go to previous record'
    TBarBrwInsert{PROP:ToolTip}='Save this record and add a new one'
  END
  DISPLAY(TBarBrwFirst,TBarBrwLast)

BrowseNodalas PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
NOS_P                STRING(97)

BRW1::View:Browse    VIEW(NODALAS)
                       PROJECT(NOD:U_NR)
                       PROJECT(NOD:SVARS)
                       PROJECT(NOD:KODS)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::NOD:U_NR         LIKE(NOD:U_NR)             ! Queue Display field
BRW1::NOD:U_NR:NormalFG LONG                      ! Normal Foreground
BRW1::NOD:U_NR:NormalBG LONG                      ! Normal Background
BRW1::NOD:U_NR:SelectedFG LONG                    ! Selected Foreground
BRW1::NOD:U_NR:SelectedBG LONG                    ! Selected Background
BRW1::NOS_P            LIKE(NOS_P)                ! Queue Display field
BRW1::NOS_P:NormalFG LONG                         ! Normal Foreground
BRW1::NOS_P:NormalBG LONG                         ! Normal Background
BRW1::NOS_P:SelectedFG LONG                       ! Selected Foreground
BRW1::NOS_P:SelectedBG LONG                       ! Selected Background
BRW1::NOD:SVARS        LIKE(NOD:SVARS)            ! Queue Display field
BRW1::NOD:KODS         LIKE(NOD:KODS)             ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort2:KeyDistribution LIKE(NOD:U_NR),DIM(100)
BRW1::Sort2:LowValue LIKE(NOD:U_NR)               ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(NOD:U_NR)              ! Queue position of scroll thumb
BRW1::CurrentEvent   LONG                         !
BRW1::CurrentChoice  LONG                         !
BRW1::RecordCount    LONG                         !
BRW1::SortOrder      BYTE                         !
BRW1::LocateMode     BYTE                         !
BRW1::RefreshMode    BYTE                         !
BRW1::LastSortOrder  BYTE                         !
BRW1::FillDirection  BYTE                         !
BRW1::AddQueue       BYTE                         !
BRW1::Changed        BYTE                         !
BRW1::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW1::ItemsToFill    LONG                         ! Controls records retrieved
BRW1::MaxItemsInList LONG                         ! Retrieved after window opened
BRW1::HighlightedPosition STRING(512)             ! POSITION of located record
BRW1::NewSelectPosted BYTE                        ! Queue position of located record
BRW1::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
WinResize            WindowResizeType
QuickWindow          WINDOW('NODALAS.tps'),AT(,,361,278),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseNodalas'),SYSTEM,GRAY,RESIZE
                       LIST,AT(8,20,346,220),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('15C|M*~Nr~@S2@300L(2)|M*~Kods, Nosaukums~L(5)@s97@12L(1)|M~Svars~L(2)@N3@'),FROM(Queue:Browse:1)
                       BUTTON('Iz&vçlçties'),AT(217,262,45,14),USE(?Select:2),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                       SHEET,AT(4,4,353,256),USE(?CurrentTab)
                         TAB('Numuru secîba'),USE(?Tab:2)
                           BUTTON('&Ievadît'),AT(210,243,45,14),USE(?Insert:3)
                           BUTTON('&Mainît'),AT(259,243,45,14),USE(?Change:3),DEFAULT
                           BUTTON('&Dzçst'),AT(308,243,45,14),USE(?Delete:3)
                         END
                         TAB('Kodu secîba'),USE(?Tab:3)
                         END
                       END
                       BUTTON('&Beigt'),AT(314,263,45,14),USE(?Close)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  ACCEPT
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Browse:1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ToolBarMode=BrowseMode THEN
        DO SelectDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
    END
    CASE FIELD()
    OF ?Browse:1
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW1::NewSelection
      OF EVENT:ScrollUp
        DO BRW1::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW1::ProcessScroll
      OF EVENT:PageUp
        DO BRW1::ProcessScroll
      OF EVENT:PageDown
        DO BRW1::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW1::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW1::ProcessScroll
      OF EVENT:AlertKey
        DO BRW1::AlertKey
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?Select:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
      END
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?Insert:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Change:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF NODALAS::Used = 0
    CheckOpen(NODALAS,1)
  END
  NODALAS::Used += 1
  BIND(NOD:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseNodalas','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select:2{Prop:Hide} = True
    DISABLE(?Select:2)
  ELSE
  END
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,255} = InsertKey
  ?Browse:1{Prop:Alrt,254} = DeleteKey
  ?Browse:1{Prop:Alrt,253} = CtrlEnter
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, if it was opened by this procedure, the window is closed.
!|
!| Next, GlobalResponse is assigned a value to signal the calling procedure
!| what happened in this procedure.
!|
!| Next, we replace the BINDings that were in place when the procedure initialized
!| (and saved with PUSHBIND) using POPBIND.
!|
!| Finally, we return to the calling procedure.
!|
  IF FilesOpened
    NODALAS::Used -= 1
    IF NODALAS::Used = 0 THEN CLOSE(NODALAS).
  END
  IF WindowOpened
    INISaveWindow('BrowseNodalas','winlats.INI')
    CLOSE(QuickWindow)
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!---------------------------------------------------------------------------
InitializeWindow ROUTINE
!|
!| This routine is used to prepare any control templates for use. It should be called once
!| per procedure.
!|
  DO RefreshWindow
!---------------------------------------------------------------------------
RefreshWindow ROUTINE
!|
!| This routine is used to keep all displays and control templates current.
!|
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
  DO BRW1::SelectSort
  ?Browse:1{Prop:VScrollPos} = BRW1::CurrentScroll
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW1::GetRecord
!---------------------------------------------------------------------------

SelectDispatch ROUTINE
  IF ACCEPTED()=TBarBrwSelect THEN         !trap remote browse select control calls
    POST(EVENT:ACCEPTED,BrowseButtons.SelectButton)
  END

!----------------------------------------------------------------------
BRW1::SelectSort ROUTINE
!|
!| This routine is called during the RefreshWindow ROUTINE present in every window procedure.
!| The purpose of this routine is to make certain that the BrowseBox is always current with your
!| user's selections. This routine...
!|
!| 1. Checks to see if any of your specified sort-order conditions are met, and if so, changes the sort order.
!| 2. If no sort order change is necessary, this routine checks to see if any of your Reset Fields has changed.
!| 3. If the sort order has changed, or if a reset field has changed, or if the ForceRefresh flag is set...
!|    a. The current record is retrieved from the disk.
!|    b. If the BrowseBox is accessed for the first time, and the Browse has been called to select a record,
!|       the page containing the current record is loaded.
!|    c. If the BrowseBox is accessed for the first time, and the Browse has not been called to select a
!|       record, the first page of information is loaded.
!|    d. If the BrowseBox is not being accessed for the first time, and the Browse sort order has changed, the
!|       new "first" page of information is loaded.
!|    e. If the BrowseBox is not being accessed for the first time, and the Browse sort order hasn't changes,
!|       the page containing the current record is reloaded.
!|    f. The record buffer is refilled from the currently highlighted BrowseBox item.
!|    f. The BrowseBox is reinitialized (BRW1::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW1::LastSortOrder = BRW1::SortOrder
  BRW1::Changed = False
  IF CHOICE(?CurrentTab) = 2
    BRW1::SortOrder = 1
  ELSE
    BRW1::SortOrder = 2
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    DO BRW1::GetRecord
    DO BRW1::Reset
    IF BRW1::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      ELSE
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      END
    ELSE
      IF BRW1::Changed
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      ELSE
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      END
    END
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
    DO BRW1::InitializeBrowse
  ELSE
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW1::InitializeBrowse ROUTINE
!|
!| This routine initializes the BrowseBox control template. This routine is called when...
!|
!| The BrowseBox sort order has changed. This includes the first time the BrowseBox is accessed.
!| The BrowseBox returns from a record update.
!|
!| This routine performs two main functions.
!|   1. Computes all BrowseBox totals. All records that satisfy the current selection criteria
!|      are read, and totals computed. If no totals are present, this section is not generated,
!|      and may not be present in the code below.
!|   2. Calculates any runtime scrollbar positions. Again, if runtime scrollbars are not used,
!|      the code for runtime scrollbar computation will not be present.
!|
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NODALAS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:HighValue = NOD:U_NR
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NODALAS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:LowValue = NOD:U_NR
    SetupStringStops(BRW1::Sort2:LowValue,BRW1::Sort2:HighValue,SIZE(BRW1::Sort2:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort2:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  NOD:U_NR = BRW1::NOD:U_NR
  NOS_P = BRW1::NOS_P
  NOD:SVARS = BRW1::NOD:SVARS
  NOD:KODS = BRW1::NOD:KODS
!----------------------------------------------------------------------
BRW1::FillQueue ROUTINE
!|
!| This routine is used to fill the BrowseBox QUEUE from several sources.
!|
!| First, all Format Browse formulae are processed.
!|
!| Next, each field of the BrowseBox is processed. For each field...
!|
!|    The value of the field is placed in the BrowseBox queue.
!|
!|    If the field is colorized, the colors are computed and applied.
!|
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  NOS_P=CLIP(NOD:KODS)&' '&NOD:NOS_P
  BRW1::NOD:U_NR = NOD:U_NR
  IF (~NOD:U_NR[2])
    BRW1::NOD:U_NR:NormalFG = 255
    BRW1::NOD:U_NR:NormalBG = -1
    BRW1::NOD:U_NR:SelectedFG = 255
    BRW1::NOD:U_NR:SelectedBG = -1
  ELSE
    BRW1::NOD:U_NR:NormalFG = -1
    BRW1::NOD:U_NR:NormalBG = -1
    BRW1::NOD:U_NR:SelectedFG = -1
    BRW1::NOD:U_NR:SelectedBG = -1
  END
  BRW1::NOS_P = NOS_P
  IF (~NOD:U_NR[2])
    BRW1::NOS_P:NormalFG = 255
    BRW1::NOS_P:NormalBG = -1
    BRW1::NOS_P:SelectedFG = 255
    BRW1::NOS_P:SelectedBG = -1
  ELSE
    BRW1::NOS_P:NormalFG = -1
    BRW1::NOS_P:NormalBG = -1
    BRW1::NOS_P:SelectedFG = -1
    BRW1::NOS_P:SelectedBG = -1
  END
  BRW1::NOD:SVARS = NOD:SVARS
  BRW1::NOD:KODS = NOD:KODS
  BRW1::Position = POSITION(BRW1::View:Browse)
!----------------------------------------------------------------------
BRW1::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW1::NewSelectPosted
    BRW1::NewSelectPosted = True
    POST(Event:NewSelection,?Browse:1)
  END
!----------------------------------------------------------------------
BRW1::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW1::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW1::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW1::PopupText = ''
    IF BRW1::RecordCount
      IF LocalRequest = SelectRecord
        BRW1::PopupText = 'Iz&vçlçties'
      ELSE
        BRW1::PopupText = '~Iz&vçlçties'
      END
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
      BRW1::PopupText = '~Iz&vçlçties'
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Insert:3)
      POST(Event:Accepted,?Change:3)
      POST(Event:Accepted,?Delete:3)
      POST(Event:Accepted,?Select:2)
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF ?Browse:1{Prop:VScroll} = False
        ?Browse:1{Prop:VScroll} = True
      END
      CASE BRW1::SortOrder
      OF 1
      OF 2
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => UPPER(NOD:U_NR)
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:1{Prop:VScroll} = True
        ?Browse:1{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW1::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW1::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW1::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW1::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW1::RecordCount
    BRW1::CurrentEvent = EVENT()
    CASE BRW1::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW1::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW1::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW1::ScrollEnd
    END
    ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
    DO BRW1::PostNewSelection
  CASE BRW1::SortOrder
  OF 1
    BRW1::CurrentScroll = 50                      ! Move Thumb to center
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF BRW1::ItemsToFill
        IF BRW1::CurrentEvent = Event:ScrollUp
          BRW1::CurrentScroll = 0
        ELSE
          BRW1::CurrentScroll = 100
        END
      END
    ELSE
      BRW1::CurrentScroll = 0
    END
  END
  END
!----------------------------------------------------------------------
BRW1::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW1::FillRecord to retrieve one record in the direction required.
!|
  IF BRW1::CurrentEvent = Event:ScrollUp AND BRW1::CurrentChoice > 1
    BRW1::CurrentChoice -= 1
    EXIT
  ELSIF BRW1::CurrentEvent = Event:ScrollDown AND BRW1::CurrentChoice < BRW1::RecordCount
    BRW1::CurrentChoice += 1
    EXIT
  END
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = BRW1::CurrentEvent - 2
  DO BRW1::FillRecord
!----------------------------------------------------------------------
BRW1::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW1::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW1::FillRecord doesn't fill a page (BRW1::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  BRW1::FillDirection = BRW1::CurrentEvent - 4
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::ItemsToFill
    IF BRW1::CurrentEvent = Event:PageUp
      BRW1::CurrentChoice -= BRW1::ItemsToFill
      IF BRW1::CurrentChoice < 1
        BRW1::CurrentChoice = 1
      END
    ELSE
      BRW1::CurrentChoice += BRW1::ItemsToFill
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW1::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW1::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  DO BRW1::Reset
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::FillDirection = FillForward
  ELSE
    BRW1::FillDirection = FillBackward
  END
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::CurrentChoice = 1
  ELSE
    BRW1::CurrentChoice = BRW1::RecordCount
  END
!----------------------------------------------------------------------
BRW1::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW1::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW1::LocateRecord.
!|
  IF BRW1::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
      IF LocalRequest = SelectRecord
        POST(Event:Accepted,?Select:2)
        EXIT
      END
      POST(Event:Accepted,?Change:3)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    OF DeleteKey
      POST(Event:Accepted,?Delete:3)
    OF CtrlEnter
      POST(Event:Accepted,?Change:3)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          IF UPPER(SUB(NOD:KODS,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(NOD:KODS,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            NOD:KODS = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 2
        IF CHR(KEYCHAR())
          IF UPPER(SUB(NOD:U_NR,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(NOD:U_NR,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            NOD:U_NR = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      END
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    END
  END
  DO BRW1::PostNewSelection
!----------------------------------------------------------------------
BRW1::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW1::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW1::LocateRecord.
!|
  IF ?Browse:1{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:1)
  ELSIF ?Browse:1{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:1)
  ELSE
    CASE BRW1::SortOrder
    OF 2
      NOD:U_NR = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    END
  END
!----------------------------------------------------------------------
BRW1::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW1::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW1::ItemsToFill records. Normally, this will
!| result in BRW1::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW1::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW1::AddQueue is true, the queue is filled using the BRW1::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW1::AddQueue is false is when the BRW1::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW1::RecordCount
    IF BRW1::FillDirection = FillForward
      GET(Queue:Browse:1,BRW1::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:1,1)                       ! Get the first queue item
    END
    RESET(BRW1::View:Browse,BRW1::Position)       ! Reset for sequential processing
    BRW1::SkipFirst = TRUE
  ELSE
    BRW1::SkipFirst = FALSE
  END
  LOOP WHILE BRW1::ItemsToFill
    IF BRW1::FillDirection = FillForward
      NEXT(BRW1::View:Browse)
    ELSE
      PREVIOUS(BRW1::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'NODALAS')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW1::SkipFirst
       BRW1::SkipFirst = FALSE
       IF POSITION(BRW1::View:Browse)=BRW1::Position
          CYCLE
       END
    END
    IF BRW1::AddQueue
      IF BRW1::RecordCount = ?Browse:1{Prop:Items}
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse:1,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:1,BRW1::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:1)
        BRW1::RecordCount -= 1
      END
      DO BRW1::FillQueue
      IF BRW1::FillDirection = FillForward
        ADD(Queue:Browse:1)
      ELSE
        ADD(Queue:Browse:1,1)
      END
      BRW1::RecordCount += 1
    END
    BRW1::ItemsToFill -= 1
  END
  BRW1::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW1::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW1::LocateMode. These modes are...
!|
!|   LocateOnPosition (1) - This mode is still supported for 1.5 compatability. This mode
!|                          is the same as LocateOnEdit.
!|   LocateOnValue    (2) - The values of the current sort order key are used. This mode
!|                          used for Locators and when the BrowseBox is called to select
!|                          a record.
!|   LocateOnEdit     (3) - The current record of the VIEW is used. This mode assumes
!|                          that there is an active VIEW record. This mode is used when
!|                          the sort order of the BrowseBox has changed
!|
!| If an appropriate record has been located, the BRW1::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW1::LocateMode = LocateOnPosition
    BRW1::LocateMode = LocateOnEdit
  END
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(NOD:KODS_KEY)
      RESET(NOD:KODS_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(NOD:KODS_KEY,NOD:KODS_KEY)
    END
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(NOD:Nr_Key)
      RESET(NOD:Nr_Key,BRW1::HighlightedPosition)
    ELSE
      SET(NOD:Nr_Key,NOD:Nr_Key)
    END
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = FillForward               ! Fill with next read(s)
  BRW1::AddQueue = False
  DO BRW1::FillRecord                             ! Fill with next read(s)
  BRW1::AddQueue = True
  IF BRW1::ItemsToFill
    BRW1::RefreshMode = RefreshOnBottom
    DO BRW1::RefreshPage
  ELSE
    BRW1::RefreshMode = RefreshOnPosition
    DO BRW1::RefreshPage
  END
  DO BRW1::PostNewSelection
  BRW1::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW1::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW1::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse:1), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW1::RefreshMode = RefreshOnPosition
    BRW1::HighlightedPosition = POSITION(BRW1::View:Browse)
    RESET(BRW1::View:Browse,BRW1::HighlightedPosition)
    BRW1::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:1,RECORDS(Queue:Browse:1))
    END
    BRW1::HighlightedPosition = BRW1::Position
    GET(Queue:Browse:1,1)
    RESET(BRW1::View:Browse,BRW1::Position)
    BRW1::RefreshMode = RefreshOnCurrent
  ELSE
    BRW1::HighlightedPosition = ''
    DO BRW1::Reset
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::RefreshMode = RefreshOnBottom
    BRW1::FillDirection = FillBackward
  ELSE
    BRW1::FillDirection = FillForward
  END
  DO BRW1::FillRecord                             ! Fill with next read(s)
  IF BRW1::HighlightedPosition
    IF BRW1::ItemsToFill
      IF NOT BRW1::RecordCount
        DO BRW1::Reset
      END
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::FillDirection = FillForward
      ELSE
        BRW1::FillDirection = FillBackward
      END
      DO BRW1::FillRecord
    END
  END
  IF BRW1::RecordCount
    IF BRW1::HighlightedPosition
      LOOP BRW1::CurrentChoice = 1 TO BRW1::RecordCount
        GET(Queue:Browse:1,BRW1::CurrentChoice)
        IF BRW1::Position = BRW1::HighlightedPosition THEN BREAK.
      END
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    ELSE
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::CurrentChoice = RECORDS(Queue:Browse:1)
      ELSE
        BRW1::CurrentChoice = 1
      END
    END
    ?Browse:1{Prop:Selected} = BRW1::CurrentChoice
    DO BRW1::FillBuffer
    ?Change:3{Prop:Disable} = 0
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(NOD:Record)
    BRW1::CurrentChoice = 0
    ?Change:3{Prop:Disable} = 1
    ?Delete:3{Prop:Disable} = 1
  END
  SETCURSOR()
  BRW1::RefreshMode = 0
  EXIT
BRW1::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    SET(NOD:KODS_KEY)
  OF 2
    SET(NOD:Nr_Key)
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    WATCH(BRW1::View:Browse)
    REGET(BRW1::View:Browse,BRW1::Position)
  END
!----------------------------------------------------------------------
BRW1::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.SelectButton=?Select:2
  BrowseButtons.InsertButton=?Insert:3
  BrowseButtons.ChangeButton=?Change:3
  BrowseButtons.DeleteButton=?Delete:3
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
    IF BrowseButtons.SelectButton THEN
      TBarBrwSelect{PROP:DISABLE}=BrowseButtons.SelectButton{PROP:DISABLE}
    END
  IF BrowseButtons.InsertButton THEN
    TBarBrwInsert{PROP:DISABLE}=BrowseButtons.InsertButton{PROP:DISABLE}
  END
  IF BrowseButtons.ChangeButton THEN
    TBarBrwChange{PROP:DISABLE}=BrowseButtons.ChangeButton{PROP:DISABLE}
  END
  IF BrowseButtons.DeleteButton THEN
    TBarBrwDelete{PROP:DISABLE}=BrowseButtons.DeleteButton{PROP:DISABLE}
  END
  DISABLE(TBarBrwHistory)
  ToolBarMode=BrowseMode
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwBottom{PROP:ToolTip}='Go to the Last Page'
  TBarBrwTop{PROP:ToolTip}='Go to the First Page'
  TBarBrwPageDown{PROP:ToolTip}='Go to the Next Page'
  TBarBrwPageUp{PROP:ToolTip}='Go to the Prior Page'
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwUP{PROP:ToolTip}='Go to the Prior Record'
  TBarBrwInsert{PROP:ToolTip}='Insert a new Record'
  DISPLAY(TBarBrwFirst,TBarBrwLast)
!--------------------------------------------------------------------------
ListBoxDispatch ROUTINE
  DO DisplayBrowseToolbar
  IF ACCEPTED() THEN            !trap remote browse box control calls
    EXECUTE(ACCEPTED()-TBarBrwBottom+1)
      POST(EVENT:ScrollBottom,BrowseButtons.ListBox)
      POST(EVENT:ScrollTop,BrowseButtons.ListBox)
      POST(EVENT:PageDown,BrowseButtons.ListBox)
      POST(EVENT:PageUp,BrowseButtons.ListBox)
      POST(EVENT:ScrollDown,BrowseButtons.ListBox)
      POST(EVENT:ScrollUp,BrowseButtons.ListBox)
      POST(EVENT:Locate,BrowseButtons.ListBox)
      BEGIN                     !EXECUTE Place Holder - Ditto has no effect on a browse
      END
      PRESSKEY(F1Key)
    END
  END

UpdateDispatch ROUTINE
  DISABLE(TBarBrwDelete)
  DISABLE(TBarBrwChange)
  IF BrowseButtons.DeleteButton AND BrowseButtons.DeleteButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwDelete)
  END
  IF BrowseButtons.ChangeButton AND BrowseButtons.ChangeButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwChange)
  END
  IF INRANGE(ACCEPTED(),TBarBrwInsert,TBarBrwDelete) THEN         !trap remote browse update control calls
    EXECUTE(ACCEPTED()-TBarBrwInsert+1)
      POST(EVENT:ACCEPTED,BrowseButtons.InsertButton)
      POST(EVENT:ACCEPTED,BrowseButtons.ChangeButton)
      POST(EVENT:ACCEPTED,BrowseButtons.DeleteButton)
    END
  END
!----------------------------------------------------------------
BRW1::ButtonInsert ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to insert a new record.
!|
!| First, the primary file's record  buffer is cleared, as well as any memos
!| or BLOBs. Next, any range-limit values are restored so that the inserted
!| record defaults to being added to the current display set.
!|
!| Next, LocalRequest is set to InsertRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the insert is successful (GlobalRequest = RequestCompleted) then the newly added
!| record is displayed in the BrowseBox, at the top of the listbox.
!|
!| If the insert is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  GET(NODALAS,0)
  CLEAR(NOD:Record,0)
  LocalRequest = InsertRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonChange ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to change a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to ChangeRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the change is successful (GlobalRequest = RequestCompleted) then the newly changed
!| record is displayed in the BrowseBox.
!|
!| If the change is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = ChangeRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonDelete ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to delete a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to DeleteRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the delete is successful (GlobalRequest = RequestCompleted) then the deleted record is
!| removed from the queue.
!|
!| Next, the BrowseBox is refreshed, redisplaying the current page.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = DeleteRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    DELETE(Queue:Browse:1)
    BRW1::RecordCount -= 1
  END
  BRW1::RefreshMode = RefreshOnQueue
  DO BRW1::RefreshPage
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdateNodalas) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateNodalas
    LocalResponse = GlobalResponse
    CASE VCRRequest
    OF VCRNone
      BREAK
    OF VCRInsert
      IF LocalRequest=ChangeRecord THEN
        LocalRequest=InsertRecord
      END
    OROF VCRForward
      IF LocalRequest=InsertRecord THEN
        GET(NODALAS,0)
        CLEAR(NOD:Record,0)
      ELSE
        DO BRW1::PostVCREdit1
        BRW1::CurrentEvent=Event:ScrollDown
        DO BRW1::ScrollOne
        DO BRW1::PostVCREdit2
      END
    OF VCRBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollUp
      DO BRW1::ScrollOne
      DO BRW1::PostVCREdit2
    OF VCRPageForward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageDown
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRPageBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageUp
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRFirst
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollTop
      DO BRW1::ScrollEnd
      DO BRW1::PostVCREdit2
    OF VCRLast
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollBottom
      DO BRW1::ScrollEND
      DO BRW1::PostVCREdit2
    END
  END
  DO BRW1::Reset

BRW1::PostVCREdit1 ROUTINE
  DO BRW1::Reset
  BRW1::LocateMode=LocateOnEdit
  DO BRW1::LocateRecord
  DO RefreshWindow

BRW1::PostVCREdit2 ROUTINE
  ?Browse:1{PROP:SelStart}=BRW1::CurrentChoice
  DO BRW1::NewSelection
  REGET(BRW1::View:Browse,BRW1::Position)
  CLOSE(BRW1::View:Browse)


Main PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
CurrentTab           STRING(80)
FING                 STRING(35)
WinResize            WindowResizeType
AppFrame             APPLICATION(' '),AT(,,453,325),FONT('MS Sans Serif',9,,FONT:bold),ICON('CLARION.ICO'),SYSTEM,MAX,MAXIMIZE,RESIZE,IMM
                       MENUBAR
                         MENU('&1-Seanss'),USE(?Seanss)
                           ITEM('&1-Printera parametri'),USE(?PrintSetup),MSG('Windows printera parametri'),STD(STD:PrintSetup)
                           ITEM,SEPARATOR
                           ITEM('&2-Beigt darbu'),USE(?Exit),MSG('Beigt darbu ar ðo aplikâciju'),STD(STD:Close)
                           ITEM('&3-ParMani'),USE(?SeanssParMani),HIDE,MSG('Par mani')
                           ITEM('&4-FTP:WinLats lejuplâde no www.assako.lv'),USE(?1Seanss4FTP),HIDE
                         END
                         MENU('&2-Serviss'),USE(?Serviss)
                           ITEM('&1-Kalkulâtors'),USE(?ServissKalkulâtors),MSG('Kalkulâtors')
                         END
                         MENU('&3-Sistçmas dati'),USE(?System)
                           ITEM('&1-Globâlie dati'),USE(?Systemglob),DISABLE,MSG('Konkrçtâ gada datubâzes Globâlie dati')
                           ITEM('&2-Paroles'),USE(?SystemParoles),DISABLE,MSG('Paroles, tikai DB adminstratora pieeja')
                         END
                         MENU('&4-Faili'),USE(?Faili)
                           ITEM('&2-Kontu plâns'),USE(?BrowseKON_K),MSG('Browse KON_K')
                           ITEM('&3-Banku saraksts'),USE(?BrowseBANKAS_K),MSG('Browse BANKAS_K')
                           ITEM('&4-Valûtas un valstis'),USE(?BrowseVAL_K),MSG('Browse VAL_K')
                           ITEM('&5-Valûtu kursi'),USE(?BrowseKURSI_K),MSG('Browse KURSI_K')
                           ITEM('&6-Nodaïas'),USE(?4Faili6Nodaïas)
                           ITEM('&7-Projekti'),USE(?FailiProjekti)
                           ITEM('&8-Atzîmes Partneriem'),USE(?FailiAtzîmesPartneriem)
                           ITEM,SEPARATOR
                           MENU('&Z-Izziòas no failiem'),USE(?FailiIzziòasnofailiem2),LAST
                             ITEM('&1-Partneru saraksts'),USE(?4Faili9Izziòasnofailiem1Partnerusaraksts)
                             ITEM('&2-Kontu plâns'),USE(?IzziòasnoFailiemKontuplâns)
                             ITEM('&3-Banku saraksts'),USE(?4Faili9Izziòasnofailiem2Bankusaraksts)
                             ITEM('&4-Atlaiþu lapas'),USE(?FailiIzziòasnofailiemAtlaiþulapas)
                             ITEM('&5-Pieðíirtâs atlaides'),USE(?FailiIzziòasnofailiemPieðíirtâsatlaides)
                             ITEM('&6-Atlaides klientiem'),USE(?4Faili9Izziòasnofailiem6Atlaidesklientiem)
                             ITEM('&7-Atzîmes partneriem'),USE(?4FailiZIzz7AtzPartneriem)
                           END
                         END
                       END
                       TOOLBAR,AT(0,0,453,18),FONT(,9,,FONT:bold)
                         BUTTON,AT(4,2,16,14),USE(?TbarBrwTop,TBarBrwTop),DISABLE,TIP('Uz Pirmo lapu'),ICON('VCRFIRST.ICO')
                         BUTTON,AT(20,2,16,14),USE(?TbarBrwPageUp,TBarBrwPageUp),DISABLE,TIP('Go to the Prior Page'),ICON('VCRPRIOR.ICO')
                         BUTTON,AT(36,2,16,14),USE(?TbarBrwUp,TBarBrwUp),DISABLE,TIP('Go to the Prior Record'),ICON('VCRUP.ICO')
                         BUTTON,AT(52,2,16,14),USE(?TbarBrwLocate,TBarBrwLocate),DISABLE,TIP('Locate record'),ICON('FIND.ICO')
                         BUTTON,AT(68,2,16,14),USE(?TbarBrwDown,TBarBrwDown),DISABLE,TIP('Go to the Next Record'),ICON('VCRDOWN.ICO')
                         BUTTON,AT(84,2,16,14),USE(?TbarBrwPageDown,TBarBrwPageDown),DISABLE,TIP('Go to the Next Page'),ICON('VCRNEXT.ICO')
                         BUTTON,AT(100,2,16,14),USE(?TbarBrwBottom,TBarBrwBottom),DISABLE,TIP('Go to the Last Page'),ICON('VCRLAST.ICO')
                         BUTTON,AT(120,2,16,14),USE(?TbarBrwSelect,TBarBrwSelect),DISABLE,TIP('Select This Record'),ICON('MARK.ICO')
                         BUTTON,AT(136,2,16,14),USE(?TbarBrwInsert,TBarBrwInsert),DISABLE,TIP('Insert a New Record'),ICON('INSERT.ICO')
                         BUTTON,AT(152,2,16,14),USE(?TbarBrwChange,TBarBrwChange),DISABLE,TIP('Edit This Record'),ICON('EDIT.ICO')
                         BUTTON,AT(168,2,16,14),USE(?TbarBrwDelete,TBarBrwDelete),DISABLE,TIP('Delete This Record'),ICON('DELETE.ICO')
                         BUTTON,AT(188,2,16,14),USE(?TbarBrwHistory,TBarBrwHistory),DISABLE,TIP('Previous value'),ICON('DITTO.ICO')
                         BUTTON,AT(204,2,16,14),USE(?TbarBrwHelp,TBarBrwHelp),DISABLE,TIP('Get Help'),ICON('HELP.ICO')
                       END
                     END
AUTO::ATTEMPTS   BYTE
SUMMAKOPA        DECIMAL(12,2)
REKINANR_S       STRING(11)
soundfile        CSTRING(80)
WLDATUMS         LONG
FTPDATUMS        LONG
EXENAME          STRING(30)

FTP_Window WINDOW('Jaunâko versiju lejuplâde'),AT(,,318,102),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC), |
         CENTER,GRAY
       STRING('Labdien!'),AT(32,7),USE(?String1),FONT(,10,COLOR:Navy,FONT:bold,CHARSET:ANSI)
       STRING('Tikai garantijas vai pçcgarantijas noteikumu darbîbas laikâ:'),AT(26,20),USE(?String10)
       STRING('www.assako.lv'),AT(26,29),USE(?String2),FONT(,,COLOR:Navy,FONT:underline,CHARSET:ANSI)
       STRING(' ir pieejama WinLats versija 2.11 ar pçdçjâm izmaiòâm'),AT(69,29),USE(?String4)
       STRING(@D06.B),AT(246,29),USE(FTPDATUMS)
       STRING('Lai sekmîgi veiktu lejuplâdi un aizvietotu Jûsu winlats.exe  no'),AT(26,38),USE(?String5)
       STRING(@D06.B),AT(227,38),USE(WLDATUMS),CENTER
       STRING(','),AT(273,38),USE(?String11)
       STRING('visiem pârçjiem lietotâjiem nepiecieðams uz brîdi beigt darbu ar WinLatu.'),AT(26,48), |
           USE(?String6)
       STRING('Vecais exe fails tiks saglabâts kâ winlats_old.exe'),AT(26,58),USE(?String7)
       STRING('Pçc veiksmîgas atjaunoðanas WinLats bûs jâpalaiþ vçlreiz.'),AT(26,67),USE(?String12)
       BUTTON('Veikt lejuplâdi'),AT(251,78,62,14),USE(?OkButton),DEFAULT
       BUTTON('Citreiz'),AT(212,78,36,14),USE(?CancelButton)
     END
TNAME_B    STRING(70),STATIC
TFILE_B      FILE,NAME(TNAME_B),PRE(B),DRIVER('ASCII'),CREATE
RECORD          RECORD
STR           STRING(200)
                END
             END
 
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
    OPCIJA_NR=1
    GL_CONT(0)
    IF ~(GLOBALRESPONSE=REQUESTCOMPLETED)
       DO PROCEDURERETURN
    .
    OPCIJA_NR=0
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  !WinLats v2.09.
  CHECKOPEN(GLOBAL,1)
  IF ~GL:DB_GADS
     GL:DB_GADS=YEAR(TODAY())
     GL:DB_S_DAT=DATE(1,1,GL:DB_GADS)
     GL:DB_B_DAT=DATE(12,31,GL:DB_GADS)
     IF RIUPDATE:GLOBAL() THEN KLUDA(24,'GLOBAL').
  .
  GADS=GL:DB_GADS      !GLOBAL
  DB_GADS=GL:DB_GADS   !GLOBAL
  DB_S_DAT=GL:DB_S_DAT !GLOBAL
  DB_B_DAT=GL:DB_B_DAT !GLOBAL
  IF ~(YEAR(DB_S_DAT)=YEAR(DB_B_DAT)) !CITÂDS FINANSU GADS
     DB_FGK=12-MONTH(DB_S_DAT)+1
  .
  FING=GETFING(1,DB_GADS,DB_S_DAT,DB_B_DAT)
  CLOSE(GLOBAL) !IR JÂVER CIET, CITÂDI VISU LAIKU STÂV VAÏÂ
  
  IF GNET
    AppFrame{PROP:TEXT}='WinLats '&DB_GADS&'.g. Global Net Client.NET Nr:'&clip(gnet)&' Taka: '&CLIP(LONGpath())&'  '&CLIENT
  ELSE
    IF BAND(REG_BASE_ACC,00000010b) ! Budþets
      AppFrame{PROP:TEXT}='WinLats Budþets v3.02 '&DB_GADS&'.'&FING&' Local Net Client  Taka: '&CLIP(LONGpath())&'  '&CLIENT
    ELSE
      AppFrame{PROP:TEXT}='WinLats v3.02 '&DB_GADS&'.'&FING&' Local Net Client  Taka: '&CLIP(LONGpath())&'  '&CLIENT
    .
  .
  IF ATLAUTS[1]='1' !SUPERACC
     ENABLE(?SystemParoles)
     ENABLE(?Systemglob)
  .
  !*******USER LEVEL ACCESS CONTROL********
  IF BAND(REG_BASE_ACC,00000010b) ! Budþets
     ?FailiProjekti{PROP:TEXT}='&7-Klasifikâcijas,ekonomiskie kodi'
  .
  
  !****************sâkuma vârds failiem********
  DZFNAME='DZFILES' !DARBA ÞURNÂLS FAILIEM
  GGNAME ='GG01'
  GGKNAME='GGK01'
  PARNAME='PAR_K'   !08.10.07, PAGAIDÂM NETIEK IZMANTOTS
  NOMNAME='NOM_K'  !05.09.09, PAGAIDÂM IZMANTOTS TPSFIX-ATJAUNOÐANÂ
  
  !****************Globâlie nmainîgie**********
  !Elya 01/12/2013
  Val_uzsk=''
  IF GL:DB_GADS > 2013
     Val_uzsk=GETVAL_K('EUR',0)                       !01/03/2015
     IF ~Val_uzsk                                     !01/03/2015
        STOP('Failâ Valûtas nav atrodams EUR...')     !01/03/2015
        Val_uzsk='EUR'
     .                                                !01/03/2015
  END
  VAL_LV=GETVAL_K('Ls',0)
  IF ~VAL_LV
     VAL_LV=GETVAL_K('LVL',0)
     IF ~VAL_LV
  !      KLUDA(0,'Failâ Valûtas nav atrodams ne Ls, ne LVL...') MDI!!!
!        STOP('Failâ Valûtas nav atrodams ne Ls, ne LVL...')
        VAL_LV='Ls'
     .
  .
  VAL_NOS=VAL_LV

 CheckOpen(BANKAS_K,1)  !01/03/2015
 Close(BANKAS_K)        !01/03/2015

!  TNAME_B='C:\Winlats\WINLATSC.INI'
!  CHECKOPEN(TFILE_B,1)
!  CLOSE(TFILE_B)
!  OPEN(TFILE_B)
!  IF ERROR()
!     KLUDA(0,'Kïûda atverot '&CLIP(TNAME_B)&' '&ERROR())
!     DO PROCEDURERETURN
!  END
!  Val_uzsk=''
!  SET(TFILE_B)
!  LOOP
!     NEXT (TFILE_B)
!     IF ERROR() THEN BREAK.
!     IF B:STR[1:7] = 'valuta=' then
!        Val_uzsk = CLIP(B:STR[8:200])
!        BREAK
!     END
!  
!  END
  IF Val_uzsk=''
     Val_uzsk='Ls'
!     STOP('Nav atrasta uzskaites valuta. Val. = Ls')
  END
  !STOP('Val_uzsk='&Val_uzsk)
  
  ACCEPT
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF INRANGE(ACCEPTED(),TBarBrwFirst,TBarBrwLast) THEN            !Toolbar Browse box navigation control handler
        POST(EVENT:Accepted,ACCEPTED(),SYSTEM{Prop:Active})
        CYCLE
      END
    END
    CASE ACCEPTED()
    OF ?Exit
      !  soundfile='\WINLATS\BIN\Jungle Close.wav'
      !  sndPlaySound(soundfile,1)
    OF ?SeanssParMani
      Parmani 
    OF ?1Seanss4FTP
      WLDATUMS=DOS_CONT('\WINLATS\BIN\WINLATS.EXE',1) !PROGRAMMAS DATUMS
      FTPDATUMS=TODAY()
      KLU_DARBIBA=1
      IF WLDATUMS<DATE(08,26,2010)
         KLUDA(0,'Jûsu WinLata versija < 2.11, bûs jâkonvertç dati',5,1)
      ELSIF WLDATUMS=FTPDATUMS
         KLUDA(0,'Jûsu WinLata versija jau ir pati jaunâkâ',5,1)
      .
      IF KLU_DARBIBA=1
         OPEN(FTP_Window)
      !   EXENAME=LONGPATH()
      !   EXENAME=EXENAME[1:3]&'WINLATS\BIN\WINLATS1.EXE'
         DISPLAY
         ACCEPT
            CASE FIELD()
            OF ?OkButton
               IF EVENT()=Event:ACCEPTED
                  IF ~OPENANSI('TEMP.TXT',1)   !TEKOÐÂ FOLDERÎ
                     STOP('FTP')
                     BREAK
                  .
                  OUTA:LINE='assako'
                  ADD(OUTFILEANSI)
                  OUTA:LINE='GG5jd8l'
                  ADD(OUTFILEANSI)
                  OUTA:LINE='bin'
                  ADD(OUTFILEANSI)
                  OUTA:LINE='get WINLATS.ARJ'
                  ADD(OUTFILEANSI)
                  OUTA:LINE='bye'
                  ADD(OUTFILEANSI)
                  CLOSE(OUTFILEANSI)
                  RUN('c:\windows\system32\ftp.exe -s:TEMP.TXT www.assako.lv',1) !GAIDÎT COMPLETE
                  IF RUNCODE()
                     STOP('c:\windows\system32\ftp.exe '&ERROR())
                     BREAK
                  ELSE
                     FILENAME1=LONGPATH()
                     FILENAME1=FILENAME1[1:3]&'WINLATS\BIN'
                     COPY('WINLATS.ARJ',CLIP(FILENAME1)&'\WINLATS.ARJ')   !NO TEKOÐÂ UZ \BIN
                     IF ERROR()
                        STOP('COPY '&CLIP(LONGPATH())&'\WINLATS.ARJ uz '&FILENAME1&'\WINLATS.ARJ '&ERROR())
                        BREAK
                     .
                  .
                  PATH"=LONGPATH()
                  SETPATH(FILENAME1)
                  IF ERROR()
                     STOP(FILENAME1&' '&ERROR())
                     BREAK
                  .
                  COPY('WINLATS.EXE','winlats_old.exe')            !TAISAM KOPIJU \BIN-â
                  IF ERROR()
                     STOP('COPY: '&FILENAME1&'\WINLATS.EXE '&ERROR())
                     BREAK
                  .
      !            RUN('ARJ E WINLATS.ARJ')
                  RUN('ARJ E -y WINLATS.ARJ')
      !            RUN('ARJ E -F WINLATS.ARJ')
                  IF RUNCODE()
                     STOP('ARJ E WINLATS.ARJ '&ERROR())
                     BREAK
                  .
                  SETPATH(PATH")
                  REMOVE(OUTFILEANSI)
                  REMOVE('WINLATS.ARJ')
      !            KLUDA(0,'Atjaunoðana veiksmîga, beidzam darbu',,1) NEDRÎKST...
                  HALT
               .
            OF ?CancelButton
               IF EVENT()=Event:ACCEPTED
                  BREAK
               .
            .
         .
         REMOVE(OUTFILEANSI)
         CLOSE(FTP_Window)
      .
      
    OF ?ServissKalkulâtors
      START(kalkis,25000)
    OF ?Systemglob
      UpdateGlobal 
    OF ?SystemParoles
      Paroles 
    OF ?BrowseKON_K
      BrowseKON_K 
    OF ?BrowseBANKAS_K
      BrowseBANKAS_K 
    OF ?BrowseVAL_K
      BrowseVAL_K 
    OF ?BrowseKURSI_K
      BrowseKURSI_K 
    OF ?4Faili6Nodaïas
      BrowseNodalas 
    OF ?FailiProjekti
      BrowseProjekti 
    OF ?FailiAtzîmesPartneriem
      BrowsePAR_Z 
    OF ?4Faili9Izziòasnofailiem1Partnerusaraksts
       !ÐITEN MDI BÇRNUS NEDRÎKST SAUKT
       START(F_PrintPar_K,50000)
      
    OF ?IzziòasnoFailiemKontuplâns
       !ÐITEN MDI BÇRNUS NEDRÎKST SAUKT
       START(F_PrintKON_K,50000)
    OF ?4Faili9Izziòasnofailiem2Bankusaraksts
      START(F_BankasReport,50000)
       !ÐITEN MDI BÇRNUS NEDRÎKST SAUKT
    OF ?FailiIzziòasnofailiemAtlaiþulapas
       !ÐITEN MDI BÇRNUS NEDRÎKST SAUKT
       START(F_AtlaizuLapas,50000)
    OF ?FailiIzziòasnofailiemPieðíirtâsatlaides
       !ÐITEN MDI BÇRNUS NEDRÎKST SAUKT
       START(F_AtlaidesReport,50000)
    OF ?4Faili9Izziòasnofailiem6Atlaidesklientiem
       !ÐITEN MDI BÇRNUS NEDRÎKST SAUKT
       START(F_ATLAIDESKLIENTIEM,50000)
    OF ?4FailiZIzz7AtzPartneriem
       !OPCIJA='1'
       !IZZFILTF
       !IF GLOBALRESPONSE=REQUESTCOMPLETED
       !ÐITEN MDI BÇRNUS NEDRÎKST SAUKT
       START(F_ATZ_K,50000)
      
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  FilesOpened = True
  OPEN(AppFrame)
  WindowOpened=True
  WinResize.Initialize(AppStrat:Spread)
   IF ARJ
      IF INSTRING('RAR.',UPPER(ARJ),1)
         DATE#=DOS_CONT('WL*.RAR',1)
      ELSIF INSTRING('ZIP',UPPER(ARJ),1)
         DATE#=DOS_CONT('WL*.ZIP',1)
      ELSIF INSTRING('ARJ.',UPPER(ARJ),1)
         DATE#=DOS_CONT('WL*.ARJ',1)
      ELSE
         KLUDA(0,'Definçts neatïauts Arhivators '&ARJ)
      .
      IF ~DATE#
         KLUDA(102,'DATU BÂZEI - VISPÂR NAV ARHIVÇTI')
      ELSIF TODAY()-DATE# >= 5
         KLUDA(102,'DATU BÂZEI pirms '&clip(TODAY()-DATE#)&' dienâm')
      .
   ELSE
      KLUDA(0,'Nav definçta Arhivatora izsaukðana C:\WINLATS\WinLatsC.ini')
   .
   IF ~GL:FREE_N
      KLUDA(0,'Globâlajos datos nav norâdîts jûsu uzòçmuma reìistrâcijas datums')
   .
   START(SELECTJOB,25000)
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, if it was opened by this procedure, the window is closed.
!|
!| Next, GlobalResponse is assigned a value to signal the calling procedure
!| what happened in this procedure.
!|
!| Next, we replace the BINDings that were in place when the procedure initialized
!| (and saved with PUSHBIND) using POPBIND.
!|
!| Finally, we return to the calling procedure.
!|
  IF FilesOpened
  END
  IF WindowOpened
    CLOSE(AppFrame)
  END
   IF ACC_KODS_N
      CHECKOPEN(PAROLES,1)
      SEC:U_NR=ACC_KODS_N
      GET(PAROLES,SEC:NR_KEY)
      IF ~ERROR()
         SEC:DUP_ACC=0
         PUT(PAROLES)
      ELSE
         STOP('NEVAR ATRAST SEC:U_NR='&ACC_KODS_N)
      .
      CLOSE(PAROLES)
   .
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!---------------------------------------------------------------------------
InitializeWindow ROUTINE
!|
!| This routine is used to prepare any control templates for use. It should be called once
!| per procedure.
!|
  DO RefreshWindow
!---------------------------------------------------------------------------
RefreshWindow ROUTINE
!|
!| This routine is used to keep all displays and control templates current.
!|
  IF AppFrame{Prop:AcceptAll} THEN EXIT.
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
!---------------------------------------------------------------------------
