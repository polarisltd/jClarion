                     MEMBER('winlats.clw')        ! This is a MEMBER module
Paroles PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
Super_sk             BYTE

BRW1::View:Browse    VIEW(PAROLES)
                       PROJECT(SEC:U_NR)
                       PROJECT(SEC:SECURE)
                       PROJECT(SEC:PUBLISH)
                       PROJECT(SEC:SUPER_ACC)
                       PROJECT(SEC:START_NR)
                       PROJECT(SEC:FILES_ACC)
                       PROJECT(SEC:BASE_ACC)
                       PROJECT(SEC:NOL_ACC)
                       PROJECT(SEC:FP_ACC)
                       PROJECT(SEC:ALGA_ACC)
                       PROJECT(SEC:PAM_ACC)
                       PROJECT(SEC:LM_ACC)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::SEC:U_NR         LIKE(SEC:U_NR)             ! Queue Display field
BRW1::SEC:SECURE       LIKE(SEC:SECURE)           ! Queue Display field
BRW1::SEC:PUBLISH      LIKE(SEC:PUBLISH)          ! Queue Display field
BRW1::SEC:SUPER_ACC    LIKE(SEC:SUPER_ACC)        ! Queue Display field
BRW1::SEC:START_NR     LIKE(SEC:START_NR)         ! Queue Display field
BRW1::SEC:FILES_ACC    LIKE(SEC:FILES_ACC)        ! Queue Display field
BRW1::SEC:BASE_ACC     LIKE(SEC:BASE_ACC)         ! Queue Display field
BRW1::SEC:NOL_ACC      LIKE(SEC:NOL_ACC)          ! Queue Display field
BRW1::SEC:FP_ACC       LIKE(SEC:FP_ACC)           ! Queue Display field
BRW1::SEC:ALGA_ACC     LIKE(SEC:ALGA_ACC)         ! Queue Display field
BRW1::SEC:PAM_ACC      LIKE(SEC:PAM_ACC)          ! Queue Display field
BRW1::SEC:LM_ACC       LIKE(SEC:LM_ACC)           ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
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
QuickWindow          WINDOW('PAROLES.TPS'),AT(0,0,458,293),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('Paroles'),SYSTEM,GRAY
                       LIST,AT(8,20,442,242),USE(?Browse:1),IMM,HSCROLL,FONT('MS Sans Serif',8,,),MSG('Browsing Records'),FORMAT('14R(2)|M~Nr~C(0)@n_5@32L|M~Secure~C@s8@32L|M~Publish~C@s8@8C|M~S~@n1B@8C|M~1~@n2' &|
   '@31L|M~Faili~C@s8@41L|M~Bâze~C@s15@79L|M~Noliktavas~C@s25@76L|M~Fiskâlâ druka~C@' &|
   's25@35L|M~Algas~C@s15@35L|M~P/L~C@s15@35L|M~Laika-u~C@s25@'),FROM(Queue:Browse:1)
                       BUTTON('&C-Kopçt'),AT(127,271,45,14),USE(?Button6)
                       BUTTON('&Ievadît'),AT(235,271,45,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(284,271,45,14),USE(?Change:2),DEFAULT
                       BUTTON('&Dzçst'),AT(333,271,45,14),USE(?Delete:2)
                       SHEET,AT(4,4,450,263),USE(?CurrentTab)
                         TAB('Se&cure_key'),USE(?Tab:2)
                         END
                         TAB('Iekðçjo &Nr secîba'),USE(?Tab:3)
                         END
                         TAB('&Public_key'),USE(?Tab:4)
                         END
                       END
                       BUTTON('&Beigt'),AT(393,271,45,14),USE(?Close)
                       BUTTON('Iz&vçlçties'),AT(181,271),USE(?Select)
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
    IF ~(ATLAUTS[1]='1') !SUPERACC
       DISABLE(?change:2)
       DISABLE(?delete:2)
       DISABLE(?Insert:2)
    .
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
      END
    OF ?Button6
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        COPYREQUEST=1
        DO BRW1::ButtonInsert
      END
    OF ?Insert:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Change:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Delete:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
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
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?Select
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF PAROLES::Used = 0
    CheckOpen(PAROLES,1)
  END
  PAROLES::Used += 1
  BIND(SEC:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('Paroles','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    DISABLE(?Select)
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
    PAROLES::Used -= 1
    IF PAROLES::Used = 0 THEN CLOSE(PAROLES).
  END
  IF WindowOpened
    INISaveWindow('Paroles','winlats.INI')
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
  ELSIF CHOICE(?CurrentTab) = 3
    BRW1::SortOrder = 2
  ELSE
    BRW1::SortOrder = 3
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
  SETCURSOR(Cursor:Wait)
  DO BRW1::Reset
  Super_sk=0
  LOOP
    NEXT(BRW1::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'PAROLES')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW1::FillQueue
    Super_sk+=sec:super_acc
  END
  IF Super_sk=0
     KLUDA(88,'neviena Supervizora parole, OBLIGÂTI atjaunojiet...')
  .
  SETCURSOR()
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  SEC:U_NR = BRW1::SEC:U_NR
  SEC:SECURE = BRW1::SEC:SECURE
  SEC:PUBLISH = BRW1::SEC:PUBLISH
  SEC:SUPER_ACC = BRW1::SEC:SUPER_ACC
  SEC:START_NR = BRW1::SEC:START_NR
  SEC:FILES_ACC = BRW1::SEC:FILES_ACC
  SEC:BASE_ACC = BRW1::SEC:BASE_ACC
  SEC:NOL_ACC = BRW1::SEC:NOL_ACC
  SEC:FP_ACC = BRW1::SEC:FP_ACC
  SEC:ALGA_ACC = BRW1::SEC:ALGA_ACC
  SEC:PAM_ACC = BRW1::SEC:PAM_ACC
  SEC:LM_ACC = BRW1::SEC:LM_ACC
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
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  IF ~(ATLAUTS[1]='1') !SUPERACC
     SEC:SECURE=''
  .
  BRW1::SEC:U_NR = SEC:U_NR
  BRW1::SEC:SECURE = SEC:SECURE
  BRW1::SEC:PUBLISH = SEC:PUBLISH
  BRW1::SEC:SUPER_ACC = SEC:SUPER_ACC
  BRW1::SEC:START_NR = SEC:START_NR
  BRW1::SEC:FILES_ACC = SEC:FILES_ACC
  BRW1::SEC:BASE_ACC = SEC:BASE_ACC
  BRW1::SEC:NOL_ACC = SEC:NOL_ACC
  BRW1::SEC:FP_ACC = SEC:FP_ACC
  BRW1::SEC:ALGA_ACC = SEC:ALGA_ACC
  BRW1::SEC:PAM_ACC = SEC:PAM_ACC
  BRW1::SEC:LM_ACC = SEC:LM_ACC
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
      POST(Event:Accepted,?Insert:2)
      POST(Event:Accepted,?Change:2)
      POST(Event:Accepted,?Delete:2)
      POST(Event:Accepted,?Select)
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
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
        POST(Event:Accepted,?Select)
        EXIT
      END
      POST(Event:Accepted,?Change:2)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
    OF DeleteKey
      POST(Event:Accepted,?Delete:2)
    OF CtrlEnter
      POST(Event:Accepted,?Change:2)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          IF UPPER(SUB(SEC:U_NR,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(SEC:U_NR,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            SEC:U_NR = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 2
        IF CHR(KEYCHAR())
          IF UPPER(SUB(SEC:PUBLISH,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(SEC:PUBLISH,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            SEC:PUBLISH = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 3
        IF CHR(KEYCHAR())
          IF UPPER(SUB(SEC:SECURE,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(SEC:SECURE,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            SEC:SECURE = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      END
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
    END
  END
  DO BRW1::PostNewSelection
!----------------------------------------------------------------------
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
        StandardWarning(Warn:RecordFetchError,'PAROLES')
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
      BRW1::HighlightedPosition = POSITION(SEC:NR_KEY)
      RESET(SEC:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(SEC:NR_KEY,SEC:NR_KEY)
    END
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(SEC:PUB_KEY)
      RESET(SEC:PUB_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(SEC:PUB_KEY,SEC:PUB_KEY)
    END
  OF 3
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(SEC:SECURE_KEY)
      RESET(SEC:SECURE_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(SEC:SECURE_KEY,SEC:SECURE_KEY)
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
    ?Change:2{Prop:Disable} = 0
    ?Delete:2{Prop:Disable} = 0
  ELSE
    CLEAR(SEC:Record)
    BRW1::CurrentChoice = 0
    ?Change:2{Prop:Disable} = 1
    ?Delete:2{Prop:Disable} = 1
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
    SET(SEC:NR_KEY)
  OF 2
    SET(SEC:PUB_KEY)
  OF 3
    SET(SEC:SECURE_KEY)
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
  BrowseButtons.SelectButton=?Select
  BrowseButtons.InsertButton=?Insert:2
  BrowseButtons.ChangeButton=?Change:2
  BrowseButtons.DeleteButton=?Delete:2
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
  GET(PAROLES,0)
  CLEAR(SEC:Record,0)
  LocalRequest = InsertRecord
  IF COPYREQUEST=1
     DO SYNCWINDOW
     SEC:SECURE=CLOCK()
     SEC:PUBLISH=SEC:SECURE
  .
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
!| (UpdateParoles) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  IF ~(ATLAUTS[1]='1') !SUPERACC
     EXIT
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateParoles
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
        GET(PAROLES,0)
        CLEAR(SEC:Record,0)
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
  COPYREQUEST=0

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


UpdateGlobal PROCEDURE


CurrentTab           STRING(80)
PAROLE               STRING(6)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
laiks                TIME
BAN_NOS_P            STRING(31),DIM(10)
MENESI               STRING(10)
DB_MENESI            BYTE
SAV_DB_S             LONG
SAV_DB_B             LONG
Update::Reloop  BYTE
Update::Error   BYTE
History::GL:Record LIKE(GL:Record),STATIC
SAV::GL:Record       LIKE(GL:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the GLOBAL File'),AT(,,413,343),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('PAROLES'),SYSTEM,GRAY,NOFRAME
                       SHEET,AT(-4,4,410,315),USE(?CurrentTab)
                         TAB('Sistçmas GLOBÂLIE dati'),USE(?Tab2)
                           STRING('Pçdçjie dokumentu Nr (9999999 - nenumurçt):'),AT(254,5),USE(?String10),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           PROMPT('DB Gads(vârds) :'),AT(18,24),USE(?GL:DB_GADS:Prompt)
                           PROMPT('Reìistrâcijas &Nr:'),AT(13,58,77,10),USE(?GL:REG_NR:Prompt)
                           ENTRY(@s11),AT(110,57,57,12),USE(GL:REG_NR)
                           PROMPT('&Datums:'),AT(174,58),USE(?GL:FREE_N:Prompt)
                           ENTRY(@D06.B),AT(204,57,41,12),USE(GL:FREE_N)
                           PROMPT('&PVN reìistrâcijas Nr:'),AT(13,74,91,10),USE(?GL:VID_NR:Prompt)
                           ENTRY(@s13),AT(110,71,57,12),USE(GL:VID_NR)
                           PROMPT('&VID teritoriâlâ nodaïa:'),AT(13,87,91,10),USE(?GL:VID_NOS:Prompt)
                           ENTRY(@s25),AT(110,86,100,12),USE(GL:VID_NOS)
                           PROMPT('&Sociâlâs apdroðinâðanas Nr:'),AT(13,100,94,10),USE(?GL:SOC_NR:Prompt)
                           ENTRY(@s7),AT(110,100,33,12),USE(GL:SOC_NR)
                           PROMPT('VID lietas Nr'),AT(218,88,48,10),USE(?GL:VID_LNR:Prompt)
                           ENTRY(@s6),AT(268,86,36,12),USE(GL:VID_LNR)
                           PROMPT('Pamatdarbîbas veids NACE:'),AT(13,115,97,10),USE(?GL:NACE:Prompt)
                           ENTRY(@N_4B),AT(111,114,36,12),USE(GL:NACE),RIGHT(1),MSG('Pamatdarbîbas veids'),TIP('Pamatdarbîbas veids')
                           PROMPT('VK-PVN U_Nr WinLatâ (Partneros):'),AT(149,116),USE(?GL:VIDPVN_U_NR:Prompt)
                           ENTRY(@n_6B),AT(268,114,36,12),USE(GL:VIDPVN_U_NR)
                           PROMPT('Mûsu U_Nr WinLatâ (Partneros):'),AT(156,101,110,10),USE(?GL:CLIENT_U_NR:Prompt)
                           ENTRY(@n_6B),AT(268,100,36,12),USE(GL:CLIENT_U_NR)
                           PROMPT('&Juridiskâ adrese:'),AT(13,129,57,10),USE(?GL:ADRESE:Prompt)
                           ENTRY(@s60),AT(76,128,205,12),USE(GL:ADRESE)
                           PROMPT('&Rîkojums:'),AT(331,137,34,10),USE(?GL:RIK_NR:Prompt),RIGHT
                           PROMPT('Invoice:'),AT(338,81),USE(?GL:INVOICE_NR:Prompt),RIGHT
                           ENTRY(@n_7),AT(367,80,36,12),USE(GL:INVOICE_NR),RIGHT(1)
                           PROMPT('Garantijas akts:'),AT(307,124,58,10),USE(?GL:GARANT_NR:Prompt),RIGHT
                           ENTRY(@n_10),AT(367,122,36,12),USE(GL:GARANT_NR),RIGHT(1)
                           PROMPT('&Maksâjuma Uzdevums:'),AT(283,24,82,10),USE(?GL:MAU_NR:Prompt),RIGHT
                           ENTRY(@n_7),AT(367,24,36,12),USE(GL:MAU_NR),RIGHT(1)
                           BUTTON('-M'),AT(30,38,19,14),USE(?ButtonSM),DISABLE
                           STRING(@d06.),AT(51,41),USE(GL:DB_S_DAT)
                           BUTTON('+M'),AT(95,38,19,14),USE(?ButtonSV),DISABLE
                           STRING('-'),AT(119,41),USE(?String7)
                           BUTTON('-M'),AT(127,38,19,14),USE(?ButtonBM),DISABLE
                           BUTTON('Mainît finansu Gadu'),AT(110,22,78,14),USE(?ButtonDBGADS),DISABLE
                           STRING(@N_4),AT(78,22),USE(GL:DB_GADS),FONT(,12,,FONT:bold,CHARSET:ANSI)
                           PROMPT('Kases i&eòçmumu orderis:'),AT(279,38,86,10),USE(?GL:KIE_NR:Prompt),RIGHT
                           ENTRY(@n_7),AT(367,38,36,12),USE(GL:KIE_NR),RIGHT(1)
                           STRING(@d06.),AT(147,41),USE(GL:DB_B_DAT)
                           STRING(@n2),AT(193,24),USE(DB_MENESI),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           BUTTON('+M'),AT(190,38,19,14),USE(?ButtonBV),DISABLE
                           PROMPT('Kases i&zdevumu orderis:'),AT(282,53,83,10),USE(?GL:KIZ_NR:Prompt),RIGHT
                           ENTRY(@n_7),AT(367,51,36,12),USE(GL:KIZ_NR),RIGHT(1)
                           PROMPT('&Rçíins:'),AT(331,66,34,10),USE(?GL:REK_NR:Prompt),RIGHT
                           ENTRY(@n_7),AT(367,66,36,12),USE(GL:REK_NR),RIGHT(1)
                           PROMPT('Pi&lnvara:'),AT(330,95,35,10),USE(?GL:PIL_NR:Prompt),RIGHT
                           ENTRY(@n_7.0),AT(367,94,36,12),USE(GL:PIL_NR),RIGHT(1)
                           PROMPT('Ieskaits:'),AT(337,110),USE(?GL:IESKAITA_NR:Prompt),RIGHT
                           ENTRY(@n13),AT(367,108,36,12),USE(GL:IESK_NR),RIGHT(1)
                           OPTION('Paðizmaksas apr.'),AT(13,142,70,22),USE(GL:FMI_TIPS),BOXED
                             RADIO('VS'),AT(25,153),USE(?GL:FMI_TIPS:Radio1)
                             RADIO('FIFO'),AT(46,153),USE(?GL:FMI_TIPS:Radio2)
                           END
                           OPTION('Svîtrkodu autonumerâciju veikt no:'),AT(86,142,137,24),USE(?Option2),BOXED
                           END
                           ENTRY(@n_13),AT(91,153,71,9),USE(GL:EAN_NR)
                           STRING('(0 - nenumurçt)'),AT(164,153),USE(?String1:2),FONT(,,COLOR:Gray,)
                           BUTTON('Ìenetçt 13.zîmi'),AT(225,150,77,14),USE(?Button13z)
                           IMAGE('CHECK3.ICO'),AT(305,147,16,17),USE(?Image13z),HIDE
                           ENTRY(@n13),AT(367,137,36,12),USE(GL:RIK_NR),RIGHT(1)
                           PROMPT('Bankas kods:'),AT(22,165,49,9),USE(?GL:KODS:Prompt)
                           PROMPT('IBAN kods'),AT(257,165,43,9),USE(?GL:REK:Prompt)
                           PROMPT('Koresp/rçí.Nr :'),AT(307,165,48,9),USE(?GL:KOR:Prompt)
                           PROMPT('262..konts:'),AT(358,165,42,9),USE(?GL:BKK:Prompt),LEFT
                           ENTRY(@s15),AT(19,174,55,12),USE(GL:BKODS[1])
                           TEXT,AT(77,174,131,12),USE(BAN_NOS_P[1]),READONLY
                           ENTRY(@s34),AT(210,174,95,12),USE(GL:REK[1])
                           ENTRY(@s11),AT(308,174,47,12),USE(GL:KOR[1])
                           ENTRY(@s5),AT(358,174),USE(GL:BKK[1])
                           ENTRY(@s15),AT(19,187,55,12),USE(GL:BKODS[2])
                           TEXT,AT(77,187,131,12),USE(BAN_NOS_P[2]),READONLY
                           ENTRY(@S34),AT(210,187,95,12),USE(GL:REK[2])
                           ENTRY(@s11),AT(308,187,47,12),USE(GL:KOR[2])
                           ENTRY(@s5),AT(358,187),USE(GL:BKK[2])
                           ENTRY(@s15),AT(19,203,55,12),USE(GL:BKODS[3])
                           TEXT,AT(77,203,131,12),USE(BAN_NOS_P[3]),READONLY
                           ENTRY(@S34),AT(210,203,95,12),USE(GL:REK[3])
                           ENTRY(@s11),AT(308,203,47,12),USE(GL:KOR[3])
                           ENTRY(@s5),AT(358,203),USE(GL:BKK[3])
                           ENTRY(@s15),AT(19,217,55,12),USE(GL:BKODS[4])
                           TEXT,AT(77,217,131,12),USE(BAN_NOS_P[4]),READONLY
                           ENTRY(@S34),AT(210,217,95,12),USE(GL:REK[4])
                           ENTRY(@s11),AT(308,217,47,12),USE(GL:KOR[4])
                           ENTRY(@s5),AT(358,217),USE(GL:BKK[4])
                           ENTRY(@s15),AT(19,232,55,12),USE(GL:BKODS[5])
                           TEXT,AT(77,232,131,12),USE(BAN_NOS_P[5]),READONLY
                           ENTRY(@S34),AT(210,232,95,12),USE(GL:REK[5])
                           ENTRY(@s11),AT(308,232,47,12),USE(GL:KOR[5])
                           ENTRY(@s5),AT(358,232),USE(GL:BKK[5])
                           ENTRY(@s15),AT(19,246,55,12),USE(GL:BKODS[6])
                           TEXT,AT(77,246,131,12),USE(BAN_NOS_P[6]),READONLY
                           ENTRY(@S34),AT(210,246,95,12),USE(GL:REK[6])
                           ENTRY(@s11),AT(308,246,47,12),USE(GL:KOR[6])
                           ENTRY(@s5),AT(358,246),USE(GL:BKK[6])
                           ENTRY(@s15),AT(19,259,55,12),USE(GL:BKODS[7])
                           TEXT,AT(77,259,131,12),USE(BAN_NOS_P[7]),READONLY
                           ENTRY(@S34),AT(210,259,95,12),USE(GL:REK[7])
                           ENTRY(@s11),AT(308,259,47,12),USE(GL:KOR[7])
                           ENTRY(@s5),AT(358,259,28,12),USE(GL:BKK[7])
                           ENTRY(@s15),AT(19,273,55,12),USE(GL:BKODS[8])
                           TEXT,AT(77,273,131,12),USE(BAN_NOS_P[8]),READONLY
                           ENTRY(@S34),AT(210,273,95,12),USE(GL:REK[8])
                           ENTRY(@s11),AT(308,273,47,12),USE(GL:KOR[8])
                           ENTRY(@s5),AT(358,273,28,12),USE(GL:BKK[8])
                           ENTRY(@s15),AT(19,286,55,12),USE(GL:BKODS[9])
                           TEXT,AT(77,286,131,12),USE(BAN_NOS_P[9]),READONLY
                           ENTRY(@S34),AT(210,286,95,12),USE(GL:REK[9])
                           ENTRY(@s11),AT(308,286,47,12),USE(GL:KOR[9])
                           ENTRY(@s5),AT(358,286,28,12),USE(GL:BKK[9])
                           ENTRY(@s15),AT(19,302,55,12),USE(GL:BKODS[10])
                           TEXT,AT(77,302,131,12),USE(BAN_NOS_P[10]),READONLY
                           ENTRY(@S34),AT(210,302,95,12),USE(GL:REK[10])
                           ENTRY(@s11),AT(308,302,47,12),USE(GL:KOR[10])
                           ENTRY(@s5),AT(358,302,28,12),USE(GL:BKK[10])
                         END
                       END
                       STRING(@s8),AT(14,323),USE(GL:ACC_KODS),FONT(,,COLOR:Gray,FONT:bold)
                       STRING(@D06.),AT(50,323),USE(GL:ACC_DATUMS),FONT(,,COLOR:Gray,)
                       BUTTON('OK'),AT(257,321,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(304,321,45,14),USE(?Cancel)
                       BUTTON('Palîdzîba'),AT(351,321,45,14),USE(?Help),HIDE,STD(STD:Help)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
    LocalRequest = CHANGERECORD
    OriginalRequest = CHANGERECORD
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
    CHECKOPEN(GLOBAL,1)
!  FING=GETFING(1,DB_GADS,DB_S_DAT,DB_B_DAT)
!    IF ~GL:DB_GADS THEN GL:DB_GADS=YEAR(TODAY()).
!    IF ~GL:DB_S_DAT THEN GL:DB_S_DAT=DATE(1,1,GL:DB_GADS).
!    IF ~GL:DB_B_DAT THEN GL:DB_B_DAT=DATE(12,31,GL:DB_GADS).
    MENESI=AGE(GL:DB_S_DAT,GL:DB_B_DAT+1) !VIÒÐ RÇÍINA, NEIESKAITOT
    DB_MENESI=MENESI[1:2]
    CHECKOPEN(BANKAS_K,1)
    LOOP I#=1 TO 10
       IF GL:BKODS[I#]
          CLEAR(BAN:RECORD)
          BAN:KODS=GL:BKODS[I#]
          GET(BANKAS_K,BAN:KOD_KEY)
          IF ERROR()
             KLUDA(67,'BANKAS KODS:'&GL:BKODS[I#])
             BREAK
          .
          BAN_NOS_P[I#]=BAN:NOS_P
       ELSE
          BAN_NOS_P[I#]=''
       .
    .
    IF BAND(GL:BAITS,00000001b)  !ÌENERÇT SV_KODA 13 ZÎMI
       UNHIDE(?IMAGE13Z)
    .
    IF ATLAUTS[1]='1'              !SUPERACCESS
       ENABLE(?ButtonDBGADS)
    .
  CASE LocalRequest
  OF InsertRecord
    IF StandardWarning(Warn:InsertDisabled)
      DO ProcedureReturn
    END
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
     IF StandardWarning(Warn:DeleteDisabled)
      DO ProcedureReturn
    END
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
      SELECT(?String10)
      SELECT(?GL:BKODS_1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Moved
      GETPOSITION(0,WindowXPos,WindowYPos)
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
        History::GL:Record = GL:Record
        CASE LocalRequest
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::GL:Record <> GL:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:GLOBAL(1)
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
              SELECT(?String10)
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
          OF 2
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?ButtonSM
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF MONTH(GL:DB_S_DAT)=1
           GL:DB_S_DAT=DATE(12,1,YEAR(GL:DB_S_DAT)-1)
        ELSE
           GL:DB_S_DAT=DATE(MONTH(GL:DB_S_DAT)-1,1,YEAR(GL:DB_S_DAT))
        .
        MENESI=AGE(GL:DB_S_DAT,GL:DB_B_DAT+1) !VIÒÐ RÇÍINA, NEIESKAITOT
        DB_MENESI=0
        IF INSTRING('MOS',MENESI,1)
           DB_MENESI=MENESI[1:2]
        .
        DISPLAY
        IF ~INRANGE(DB_MENESI,6,18)
           KLUDA(0,'Neatïauts finansu gads: '&DB_MENESI&' mçneði')
           HIDE(?OK)
        ELSE
           UNHIDE(?OK)
        .
        DISPLAY(?OK)
      END
    OF ?ButtonSV
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !IF MONTH(GL:DB_S_DAT)=1
        !   GL:DB_S_DAT=DATE(12,1,YEAR(GL:DB_S_DAT)-1)
        !ELSE
           GL:DB_S_DAT=DATE(MONTH(GL:DB_S_DAT)+1,1,YEAR(GL:DB_S_DAT))
        !.
        MENESI=AGE(GL:DB_S_DAT,GL:DB_B_DAT+1) !VIÒÐ RÇÍINA, NEIESKAITOT
        DB_MENESI=0
        IF INSTRING('MOS',MENESI,1)
           DB_MENESI=MENESI[1:2]
        .
        DISPLAY()
        IF ~INRANGE(DB_MENESI,6,18)
           KLUDA(0,'Neatïauts finansu gads: '&DB_MENESI&' mçneði')
           HIDE(?OK)
        ELSE
           UNHIDE(?OK)
        .
        DISPLAY(?OK)
      END
    OF ?ButtonBM
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !IF MONTH(GL:DB_B_DAT)=1
        !   GL:DB_B_DAT=DATE(12,31,YEAR(GL:DB_B_DAT)-1)
        !ELSE
           GL:DB_B_DAT=DATE(MONTH(GL:DB_B_DAT),1,YEAR(GL:DB_B_DAT))-1
           GL:DB_GADS=YEAR(GL:DB_B_DAT)
        !.
        MENESI=AGE(GL:DB_S_DAT,GL:DB_B_DAT+1) !VIÒÐ RÇÍINA, NEIESKAITOT
        DB_MENESI=0
        IF INSTRING('MOS',MENESI,1)
           DB_MENESI=MENESI[1:2]
        .
        DISPLAY()
        IF ~INRANGE(DB_MENESI,6,18)
           KLUDA(0,'Neatïauts finansu gads: '&DB_MENESI&' mçneði')
           HIDE(?OK)
        ELSE
           UNHIDE(?OK)
        .
        DISPLAY(?OK)
      END
    OF ?ButtonDBGADS
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         KLUDA(0,'tagad norâdîtais periods bûs pamats visam UGP, tieðâm mainîsim?',11,1)
         IF ~KLU_DARBIBA !OTRÂDI
            SAV_DB_S=GL:DB_S_DAT
            SAV_DB_B=GL:DB_B_DAT
            ENABLE(?ButtonSM)
            ENABLE(?ButtonSV)
            ENABLE(?ButtonBM)
            ENABLE(?ButtonBV)
            DISPLAY
         .
      END
    OF ?ButtonBV
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !IF MONTH(GL:DB_S_DAT)=1
        !   GL:DB_S_DAT=DATE(12,1,YEAR(GL:DB_S_DAT)-1)
        !ELSE
           GL:DB_B_DAT=DATE(MONTH(GL:DB_B_DAT)+2,1,YEAR(GL:DB_B_DAT))-1
           GL:DB_GADS=YEAR(GL:DB_B_DAT)
        !.
        MENESI=AGE(GL:DB_S_DAT,GL:DB_B_DAT+1) !VIÒÐ RÇÍINA, NEIESKAITOT
        DB_MENESI=0
        IF INSTRING('MOS',MENESI,1)
           DB_MENESI=MENESI[1:2]
        .
        DISPLAY()
        IF ~INRANGE(DB_MENESI,6,18)
           KLUDA(0,'Neatïauts finansu gads: '&DB_MENESI&' mçneði')
           HIDE(?OK)
        ELSE
           UNHIDE(?OK)
        .
        DISPLAY(?OK)
      END
    OF ?Button13z
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(GL:BAITS,00000001b)
           GL:BAITS-=1
           HIDE(?IMAGE13Z)
        ELSE
           IF INRANGE(GL:EAN_NR,200000000000,209999999998)
              GL:BAITS+=1
              UNHIDE(?IMAGE13Z)
           ELSE
              KLUDA(0,'Svîtrkodam jâbût apgabalâ 200000000000-209999999998 (12 zîmes)')
           .
        .
        DISPLAY
      END
    OF ?GL:BKODS_1
      CASE EVENT()
      OF EVENT:Accepted
        BAN_NOS_P[1]=Getbankas_k(GL:BKODS[1],0,1)
        !GL:KODS[1]=BAN:KODS
        display
      END
    OF ?GL:REK_1
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(GL:REK[1],GL:KOR[1])
      END
    OF ?GL:BKK_1
      CASE EVENT()
      OF EVENT:Accepted
        GL:BKK[1]=GETKON_K(GL:BKK[1],1,1)
        DISPLAY
      END
    OF ?GL:BKODS_2
      CASE EVENT()
      OF EVENT:Accepted
        BAN_NOS_P[2]=Getbankas_k(GL:BKODS[2],0,1)
        !GL:KODS[2]=BAN:KODS
        display
      END
    OF ?GL:REK_2
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(GL:REK[2],GL:KOR[2])
      END
    OF ?GL:BKK_2
      CASE EVENT()
      OF EVENT:Accepted
        GL:BKK[2]=GETKON_K(GL:BKK[2],1,1)
        DISPLAY
      END
    OF ?GL:BKODS_3
      CASE EVENT()
      OF EVENT:Accepted
        BAN_NOS_P[3]=Getbankas_k(GL:BKODS[3],0,1)
        !GL:KODS[3]=BAN:KODS
        display
      END
    OF ?GL:REK_3
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(GL:REK[3],GL:KOR[3])
      END
    OF ?GL:BKK_3
      CASE EVENT()
      OF EVENT:Accepted
        GL:BKK[3]=GETKON_K(GL:BKK[3],1,1)
        DISPLAY
      END
    OF ?GL:BKODS_4
      CASE EVENT()
      OF EVENT:Accepted
        BAN_NOS_P[4]=Getbankas_k(GL:BKODS[4],0,1)
        !GL:KODS[4]=BAN:KODS
        display
      END
    OF ?GL:REK_4
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(GL:REK[4],GL:KOR[4])
      END
    OF ?GL:BKK_4
      CASE EVENT()
      OF EVENT:Accepted
        GL:BKK[4]=GETKON_K(GL:BKK[4],1,1)
        DISPLAY
      END
    OF ?GL:BKODS_5
      CASE EVENT()
      OF EVENT:Accepted
        BAN_NOS_P[5]=Getbankas_k(GL:BKODS[5],0,1)
        !GL:KODS[5]=BAN:KODS
        display
      END
    OF ?GL:REK_5
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(GL:REK[5],GL:KOR[5])
      END
    OF ?GL:BKK_5
      CASE EVENT()
      OF EVENT:Accepted
        GL:BKK[5]=GETKON_K(GL:BKK[5],1,1)
        DISPLAY
      END
    OF ?GL:BKODS_6
      CASE EVENT()
      OF EVENT:Accepted
        BAN_NOS_P[6]=Getbankas_k(GL:BKODS[6],0,1)
        display
      END
    OF ?GL:REK_6
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(GL:REK[6],GL:KOR[6])
      END
    OF ?GL:BKK_6
      CASE EVENT()
      OF EVENT:Accepted
        GL:BKK[6]=GETKON_K(GL:BKK[6],1,1)
        DISPLAY
      END
    OF ?GL:BKODS_7
      CASE EVENT()
      OF EVENT:Accepted
        BAN_NOS_P[7]=Getbankas_k(GL:BKODS[7],0,1)
        display
      END
    OF ?GL:REK_7
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(GL:REK[7],GL:KOR[7])
      END
    OF ?GL:BKK_7
      CASE EVENT()
      OF EVENT:Accepted
        GL:BKK[7]=GETKON_K(GL:BKK[7],1,1)
        DISPLAY
      END
    OF ?GL:BKODS_8
      CASE EVENT()
      OF EVENT:Accepted
        BAN_NOS_P[8]=Getbankas_k(GL:BKODS[8],0,1)
        display
      END
    OF ?GL:REK_8
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(GL:REK[8],GL:KOR[8])
      END
    OF ?GL:BKK_8
      CASE EVENT()
      OF EVENT:Accepted
        GL:BKK[8]=GETKON_K(GL:BKK[8],1,1)
        DISPLAY
      END
    OF ?GL:BKODS_9
      CASE EVENT()
      OF EVENT:Accepted
        BAN_NOS_P[9]=Getbankas_k(GL:BKODS[9],0,1)
        display
      END
    OF ?GL:REK_9
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(GL:REK[9],GL:KOR[9])
      END
    OF ?GL:BKK_9
      CASE EVENT()
      OF EVENT:Accepted
        GL:BKK[9]=GETKON_K(GL:BKK[9],1,1)
        DISPLAY
      END
    OF ?GL:BKODS_10
      CASE EVENT()
      OF EVENT:Accepted
        BAN_NOS_P[10]=Getbankas_k(GL:BKODS[10],0,1)
        display
      END
    OF ?GL:REK_10
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(GL:REK[10],GL:KOR[10])
      END
    OF ?GL:BKK_10
      CASE EVENT()
      OF EVENT:Accepted
        GL:BKK[10]=GETKON_K(GL:BKK[10],1,1)
        DISPLAY
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
          gads=GL:DB_gads
          S_DAT=GL:DB_S_DAT  !ANYWAY
          DB_gads=GL:DB_gads
          DB_S_DAT=GL:DB_S_DAT
          DB_B_DAT=GL:DB_B_DAT
          IF ~(YEAR(DB_S_DAT)=YEAR(DB_B_DAT))  !CITÂDS FINANSU GADS
             DB_FGK=12-MONTH(DB_S_DAT)+1
          .
          IF TODAY() < DB_B_DAT
             B_DAT=TODAY()
             SAV_DATUMS=TODAY()
          ELSE
             B_DAT=DB_B_DAT
             SAV_DATUMS=DB_B_DAT
          .
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
        GL:ACC_KODS=ACC_kods
        GL:ACC_DATUMS=today()
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    OF ?Help
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF GLOBAL::Used = 0
    CheckOpen(GLOBAL,1)
  END
  GLOBAL::Used += 1
  BIND(GL:RECORD)
  FilesOpened = True
  RISnap:GLOBAL
  SAV::GL:Record = GL:Record
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  IF WindowPosInit THEN
    SETPOSITION(0,WindowXPos,WindowYPos)
  ELSE
    GETPOSITION(0,WindowXPos,WindowYPos)
    WindowPosInit=True
  END
  ?GL:REG_NR{PROP:Alrt,255} = 734
  ?GL:FREE_N{PROP:Alrt,255} = 734
  ?GL:VID_NR{PROP:Alrt,255} = 734
  ?GL:VID_NOS{PROP:Alrt,255} = 734
  ?GL:SOC_NR{PROP:Alrt,255} = 734
  ?GL:VID_LNR{PROP:Alrt,255} = 734
  ?GL:NACE{PROP:Alrt,255} = 734
  ?GL:VIDPVN_U_NR{PROP:Alrt,255} = 734
  ?GL:CLIENT_U_NR{PROP:Alrt,255} = 734
  ?GL:ADRESE{PROP:Alrt,255} = 734
  ?GL:INVOICE_NR{PROP:Alrt,255} = 734
  ?GL:GARANT_NR{PROP:Alrt,255} = 734
  ?GL:MAU_NR{PROP:Alrt,255} = 734
  ?GL:DB_S_DAT{PROP:Alrt,255} = 734
  ?GL:DB_GADS{PROP:Alrt,255} = 734
  ?GL:KIE_NR{PROP:Alrt,255} = 734
  ?GL:DB_B_DAT{PROP:Alrt,255} = 734
  ?GL:KIZ_NR{PROP:Alrt,255} = 734
  ?GL:REK_NR{PROP:Alrt,255} = 734
  ?GL:PIL_NR{PROP:Alrt,255} = 734
  ?GL:IESK_NR{PROP:Alrt,255} = 734
  ?GL:FMI_TIPS{PROP:Alrt,255} = 734
  ?GL:EAN_NR{PROP:Alrt,255} = 734
  ?GL:RIK_NR{PROP:Alrt,255} = 734
  ?GL:ACC_KODS{PROP:Alrt,255} = 734
  ?GL:ACC_DATUMS{PROP:Alrt,255} = 734
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
    GLOBAL::Used -= 1
    IF GLOBAL::Used = 0 THEN CLOSE(GLOBAL).
  END
  IF WindowOpened
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
    OF ?GL:REG_NR
      GL:REG_NR = History::GL:Record.REG_NR
    OF ?GL:FREE_N
      GL:FREE_N = History::GL:Record.FREE_N
    OF ?GL:VID_NR
      GL:VID_NR = History::GL:Record.VID_NR
    OF ?GL:VID_NOS
      GL:VID_NOS = History::GL:Record.VID_NOS
    OF ?GL:SOC_NR
      GL:SOC_NR = History::GL:Record.SOC_NR
    OF ?GL:VID_LNR
      GL:VID_LNR = History::GL:Record.VID_LNR
    OF ?GL:NACE
      GL:NACE = History::GL:Record.NACE
    OF ?GL:VIDPVN_U_NR
      GL:VIDPVN_U_NR = History::GL:Record.VIDPVN_U_NR
    OF ?GL:CLIENT_U_NR
      GL:CLIENT_U_NR = History::GL:Record.CLIENT_U_NR
    OF ?GL:ADRESE
      GL:ADRESE = History::GL:Record.ADRESE
    OF ?GL:INVOICE_NR
      GL:INVOICE_NR = History::GL:Record.INVOICE_NR
    OF ?GL:GARANT_NR
      GL:GARANT_NR = History::GL:Record.GARANT_NR
    OF ?GL:MAU_NR
      GL:MAU_NR = History::GL:Record.MAU_NR
    OF ?GL:DB_S_DAT
      GL:DB_S_DAT = History::GL:Record.DB_S_DAT
    OF ?GL:DB_GADS
      GL:DB_GADS = History::GL:Record.DB_GADS
    OF ?GL:KIE_NR
      GL:KIE_NR = History::GL:Record.KIE_NR
    OF ?GL:DB_B_DAT
      GL:DB_B_DAT = History::GL:Record.DB_B_DAT
    OF ?GL:KIZ_NR
      GL:KIZ_NR = History::GL:Record.KIZ_NR
    OF ?GL:REK_NR
      GL:REK_NR = History::GL:Record.REK_NR
    OF ?GL:PIL_NR
      GL:PIL_NR = History::GL:Record.PIL_NR
    OF ?GL:IESK_NR
      GL:IESK_NR = History::GL:Record.IESK_NR
    OF ?GL:FMI_TIPS
      GL:FMI_TIPS = History::GL:Record.FMI_TIPS
    OF ?GL:EAN_NR
      GL:EAN_NR = History::GL:Record.EAN_NR
    OF ?GL:RIK_NR
      GL:RIK_NR = History::GL:Record.RIK_NR
    OF ?GL:ACC_KODS
      GL:ACC_KODS = History::GL:Record.ACC_KODS
    OF ?GL:ACC_DATUMS
      GL:ACC_DATUMS = History::GL:Record.ACC_DATUMS
  END
  DISPLAY()
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
  TBarBrwHelp{PROP:Disable}=?Help{PROP:Disable}
  DISPLAY(TBarBrwFirst,TBarBrwLast)

SUMVAR               FUNCTION (v_summa,v_nos,OPC) ! Declare Procedure
CIPARI       STRING(9)
CIPARS       DECIMAL(1),DIM(9)
RUBLI        DECIMAL(9)
KAPIKI       DECIMAL(2)
DZIMTE       STRING(1)
KK           STRING(25),DIM(9)
ST           STRING(1)
CC           STRING(1)
RINDA        STRING(130)
char_kapiki  string(2)
  CODE                                            ! Begin processed code
IF OPC=1 !ANGLISKI
  RINDA = ''
  CC    = ''
  RUBLI = INT(V_SUMMA)
  KAPIKI = (V_SUMMA - RUBLI) * 100
  CHAR_KAPIKI=FORMAT(KAPIKI,@N02)
  CIPARI = FORMAT(RUBLI,@S9)
  CIPARI = RIGHT(CIPARI)
  LOOP I# = 1 TO 9
    CIPARS[I#] = DEFORMAT(SUB(CIPARI,10-I#,1))
    IF 0 < CIPARS[I#]
       J# = I#
    .
  .
  checkopen(val_k,1)
  GET(VAL_K,0)
  VAL:VAL=V_NOS
  GET(VAL_K,VAL:NOS_KEY)
!  IF VAL:VAL='Ls' OR VAL:VAL='LVL'
!     RINDA='lats ' & FORMAT(KAPIKI,@N02) & ' santims.'
!  ELSIF VAL:VAL='EUR'
!     RINDA='euros ' & FORMAT(KAPIKI,@N02) & ' cents.'
!  ELSE
!     RINDA=CLIP(VAL:NOSAUKUMS) & ' ' & FORMAT(KAPIKI,@N02) & ' ' & CLIP(VAL:KAPIKI) & '.'
!  .
  IF ~VAL:RUBLI_A OR ~VAL:KAPIKI_A
     KLUDA(44,'valûtas nosaukums angliski Valûtâs un Valstîs')
     RINDA=CLIP(VAL:RUBLI) & ' ' & FORMAT(KAPIKI,@N02) & ' ' & CLIP(VAL:KAPIKI) & '.'
  ELSE
     RINDA=CLIP(VAL:RUBLI_A) & ' ' & FORMAT(KAPIKI,@N02) & ' ' & CLIP(VAL:KAPIKI_A) & '.'
  .
  IF RUBLI=0
    RINDA=LEFT('Zero '& CLIP(rinda))
    BEEP
    RETURN(RINDA)
  .
  LOOP I# = 1 TO J#
    EXECUTE I#
      DO VIENE
      DO DESME
      DO SIMTE
      DO TUKSE
      DO DESME
      DO SIMTE
      DO MILJE
      DO DESME
      DO SIMTE
    .
  .
  LOOP I# = 1 TO J#
    IF KK[I#] <> ''
       rinda = CLIP(KK[I#]) & ' ' & rinda
    .
  .
  rinda = left(rinda)
  RINDA[1] = UPPER(RINDA[1])
!  STOP('SV:'&RINDA)
  RETURN(RINDA)
ELSE  !LATVISKI
  RINDA = ''
  CC    = ''
  RUBLI = INT(V_SUMMA)
  KAPIKI = (V_SUMMA - RUBLI) * 100
  CHAR_KAPIKI=FORMAT(KAPIKI,@N02)
  CIPARI = FORMAT(RUBLI,@S9)
  CIPARI = RIGHT(CIPARI)
  LOOP I# = 1 TO 9
    CIPARS[I#] = DEFORMAT(SUB(CIPARI,10-I#,1))
    IF 0 < CIPARS[I#]
       J# = I#
    .
  .
  checkopen(val_k)
  GET(VAL_K,0)
  VAL:VAL=V_NOS
  GET(VAL_K,VAL:NOS_KEY)
  IF ERROR()
     IF V_NOS='Ls' THEN VAL:VAL='LVL'.
     IF V_NOS='LVL' THEN VAL:VAL='Ls'.
     GET(VAL_K,VAL:NOS_KEY)
  .
  DZIMTE=VAL:DZIMTE
!09/04/2013  IF DZIMTE='V' AND CIPARS[1]=1 AND ~CIPARS[2]=1 AND ~(UPPER(VAL:RUBLI)='EIRO')
  IF DZIMTE='V' AND CIPARS[1]=1 AND ~CIPARS[2]=1 AND ~(UPPER(VAL:RUBLI)='EIRO') AND ~(UPPER(VAL:RUBLI)='EURO')
     LOOP F#=20 TO 1 BY -1
        CC=SUB(VAL:RUBLI,F#,1)
        IF CC <> ''
           VAL:RUBLI=SUB(VAL:RUBLI,1,F#-1)&'s'
           BREAK
        .
     .
  ELSIF DZIMTE='S' AND CIPARS[1]=1 AND ~CIPARS[2]=1
     LOOP F#=20 TO 1 BY -1
        CC=SUB(VAL:RUBLI,F#,1)
        IF CC <> ''
           VAL:RUBLI=SUB(VAL:RUBLI,1,F#-1)
           BREAK
        .
     .
  .
! Pagaidâm cirvis
  IF (VAL:VAL='Ls' OR VAL:VAL='LVL') AND CHAR_KAPIKI[2]='1' AND ~(CHAR_KAPIKI[1]='1')
     RINDA=CLIP(VAL:RUBLI) & ' ' & FORMAT(KAPIKI,@N02) & ' santîms.'
  ELSE
     RINDA=CLIP(VAL:RUBLI) & ' ' & FORMAT(KAPIKI,@N02) & ' ' & CLIP(VAL:KAPIKI) & '.'
  .
  IF RUBLI=0
    RINDA=LEFT('Nulle '& CLIP(rinda))
    BEEP
    RETURN(RINDA)
  .
  LOOP I# = 1 TO J#
    EXECUTE I#
      DO VIEN0
      DO DESM
      DO SIMT
      DO TUKS
      DO DESM
      DO SIMT
      DO MILJ
      DO DESM
      DO SIMT
    .
  .
  LOOP I# = 1 TO J#
    IF KK[I#] <> ''
       rinda = CLIP(KK[I#]) & ' ' & rinda
    .
  .
  rinda = left(rinda)
  ST = SUB(rinda,1,1)
  K# = INSTRING(ST,'vdtèpsa',1)
  ST = SUB('VDTÈPSA',K#,1)
  RINDA = ST & SUB(RINDA,2,129)
  RETURN(RINDA)
.

VIEN0        ROUTINE
  IF DZIMTE='S'
    EXECUTE CIPARS[I#]+1
      KK[I#] = ''
      KK[I#] = 'viena  '
      KK[I#] = 'divas  '
      KK[I#] = 'trîs   '
      KK[I#] = 'èetras '
      KK[I#] = 'piecas '
      KK[I#] = 'seðas  '
      KK[I#] = 'septiòas'
      KK[I#] = 'astoòas'
      KK[I#] = 'deviòas'
    .
  ELSE
    EXECUTE CIPARS[I#]+1
      KK[I#] = ''
      KK[I#] = 'viens  '
      KK[I#] = 'divi   '
      KK[I#] = 'trîs   '
      KK[I#] = 'èetri  '
      KK[I#] = 'pieci  '
      KK[I#] = 'seði   '
      KK[I#] = 'septiòi'
      KK[I#] = 'astoòi '
      KK[I#] = 'deviòi '
    .
  .
VIEN         ROUTINE
    EXECUTE CIPARS[I#]+1
      KK[I#] = ''
      KK[I#] = 'viens  '
      KK[I#] = 'divi   '
      KK[I#] = 'trîs   '
      KK[I#] = 'èetri  '
      KK[I#] = 'pieci  '
      KK[I#] = 'seði   '
      KK[I#] = 'septiòi'
      KK[I#] = 'astoòi '
      KK[I#] = 'deviòi '
    .
DESM         ROUTINE
    EXECUTE CIPARS[I#]+1
      KK[I#] = ''
      DO PADS
      KK[I#] = 'divdesmit '
      KK[I#] = 'trîsdesmit'
      KK[I#] = 'èetrdesmit'
      KK[I#] = 'piecdesmit'
      KK[I#] = 'seðdesmit '
      KK[I#] = 'septiòdesmit'
      KK[I#] = 'astoòdesmit'
      KK[I#] = 'deviòdesmit'
    .
PADS         ROUTINE
    EXECUTE CIPARS[I#-1]+1
      KK[I#] = 'desmit    '
      KK[I#] = 'vienpadsmit'
      KK[I#] = 'divpadsmit'
      KK[I#] = 'trîspadsmit'
      KK[I#] = 'èetrpadsmit'
      KK[I#] = 'piecpadsmit '
      KK[I#] = 'seðpadsmit  '
      KK[I#] = 'septiòpadsmit'
      KK[I#] = 'astoòpadsmit '
      KK[I#] = 'deviòpadsmit '
    .
    KK[I#-1] = ''
    IF I# = 5                              ! Desmit vai padsmit tûkstoði
      KK[I#] = CLIP(KK[I#])&' tûkstoði'
    .
    IF I# = 8                              ! Desmit vai padsmit miljoni
      KK[I#] = CLIP(KK[I#])&' miljoni'
    .
SIMT         ROUTINE
    DO VIEN
    IF CIPARS[I#] = 1
      KK[I#] = CLIP(KK[I#])&' simts'
    ELSIF 1 < CIPARS[I#]
      KK[I#] = CLIP(KK[I#])&' simti'
    .
TUKS         ROUTINE
    DO VIEN
    IF CIPARS[I#] = 1
      KK[I#] = CLIP(KK[I#])&' tûkstotis'
    ELSIF 1 < CIPARS[I#]
      KK[I#] = CLIP(KK[I#])&' tûkstoði'
    ELSIF 0 < CIPARS[5] OR 0 < CIPARS[6]
      KK[I#] = CLIP(KK[I#])&'tûkstoði'
    .
MILJ         ROUTINE
    DO VIEN
    IF CIPARS[I#] = 1
      KK[I#] = CLIP(KK[I#])&' miljons'
    ELSIF 1 < CIPARS[I#]
      KK[I#] = CLIP(KK[I#])&' miljoni'
    ELSIF CIPARS[8]>0 OR CIPARS[9]>0
      KK[I#] = CLIP(KK[I#])&'miljoni'
    .

VIENE         ROUTINE
    EXECUTE CIPARS[I#]+1
      KK[I#] = ''
      KK[I#] = 'one   '
      KK[I#] = 'two   '
      KK[I#] = 'three '
      KK[I#] = 'four  '
      KK[I#] = 'five  '
      KK[I#] = 'six   '
      KK[I#] = 'seven '
      KK[I#] = 'eight '
      KK[I#] = 'nine  '
    .
DESME         ROUTINE
    EXECUTE CIPARS[I#]+1
      KK[I#] = ''
      DO PADSE
      KK[I#] = 'twenty    '
      KK[I#] = 'thirty    '
      KK[I#] = 'fourty    '
      KK[I#] = 'fifty     '
      KK[I#] = 'sixty     '
      KK[I#] = 'seventy   '
      KK[I#] = 'eighty    '
      KK[I#] = 'ninety    '
    .
PADSE         ROUTINE
    EXECUTE CIPARS[I#-1]+1
      KK[I#] = 'ten        '
      KK[I#] = 'eleven'
      KK[I#] = 'twelve'
      KK[I#] = 'thirteen'
      KK[I#] = 'fourteen'
      KK[I#] = 'fifteen '
      KK[I#] = 'sixteen  '
      KK[I#] = 'seventeen'
      KK[I#] = 'eighteen '
      KK[I#] = 'nineteen'
    .
    KK[I#-1] = ''
    IF I# = 5                              ! Desmit vai padsmit tûkstoði
      KK[I#] = CLIP(KK[I#])&' thousand'
    .
    IF I# = 8                              ! Desmit vai padsmit miljoni
      KK[I#] = CLIP(KK[I#])&' million'
    .
SIMTE         ROUTINE
    DO VIENE
    IF CIPARS[I#] = 1
      KK[I#] = CLIP(KK[I#])&' hundred'
    ELSIF 1 < CIPARS[I#]
      KK[I#] = CLIP(KK[I#])&' hundred'
    .
TUKSE         ROUTINE
    DO VIENE
    IF CIPARS[I#] = 1
      KK[I#] = CLIP(KK[I#])&' thousand'
    ELSIF 1 < CIPARS[I#]
      KK[I#] = CLIP(KK[I#])&' thousand'
    ELSIF 0 < CIPARS[5] OR 0 < CIPARS[6]
      KK[I#] = CLIP(KK[I#])&'thousand'
    .
MILJE         ROUTINE
    DO VIENE
    IF CIPARS[I#] = 1
      KK[I#] = CLIP(KK[I#])&' million'
    ELSIF 1 < CIPARS[I#]
      KK[I#] = CLIP(KK[I#])&' million'
    ELSIF CIPARS[8]>0 OR CIPARS[9]>0
      KK[I#] = CLIP(KK[I#])&'million'
    .
