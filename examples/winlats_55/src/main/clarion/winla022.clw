                     MEMBER('winlats.clw')        ! This is a MEMBER module
BrowsePAM_P PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG

BRW1::View:Browse    VIEW(PAM_P)
                       PROJECT(PAP:U_NR)
                       PROJECT(PAP:VIETA)
                       PROJECT(PAP:KOMENTARS)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::PAP:U_NR         LIKE(PAP:U_NR)             ! Queue Display field
BRW1::PAP:VIETA        LIKE(PAP:VIETA)            ! Queue Display field
BRW1::PAP:KOMENTARS    LIKE(PAP:KOMENTARS)        ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(PAP:U_NR),DIM(100)
BRW1::Sort1:LowValue LIKE(PAP:U_NR)               ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(PAP:U_NR)              ! Queue position of scroll thumb
BRW1::Sort1:Reset:PAM:U_NR LIKE(PAM:U_NR)
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
QuickWindow          WINDOW('Browse the PAM_P File'),AT(,,248,188),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),IMM,HLP('BrowsePAM_P'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,232,138),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('34R(2)|M~U NR~C(0)@N_6@104L(2)|M~Vieta~@S25@80L(2)|M~Komentârs~@S25@'),FROM(Queue:Browse:1)
                       BUTTON('&Ievadît'),AT(49,170,45,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(98,170,45,14),USE(?Change:2),DEFAULT
                       BUTTON('&Dzçst'),AT(146,170,45,14),USE(?Delete:2)
                       SHEET,AT(4,4,240,162),USE(?CurrentTab)
                         TAB('PAP:NR_KEY'),USE(?Tab:2)
                         END
                       END
                       BUTTON('Beigt'),AT(195,170,45,14),USE(?Close)
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
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  BIND(PAM:RECORD)
  IF PAM_P::Used = 0
    CheckOpen(PAM_P,1)
  END
  PAM_P::Used += 1
  BIND(PAP:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowsePAM_P','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
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
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
    PAM_P::Used -= 1
    IF PAM_P::Used = 0 THEN CLOSE(PAM_P).
  END
  IF WindowOpened
    INISaveWindow('BrowsePAM_P','winlats.INI')
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
  IF BRW1::SortOrder = 0
    BRW1::SortOrder = 1
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    OF 1
      IF BRW1::Sort1:Reset:PAM:U_NR <> PAM:U_NR
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:PAM:U_NR = PAM:U_NR
    END
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
      StandardWarning(Warn:RecordFetchError,'PAM_P')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = PAP:U_NR
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAM_P')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = PAP:U_NR
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  PAP:U_NR = BRW1::PAP:U_NR
  PAP:VIETA = BRW1::PAP:VIETA
  PAP:KOMENTARS = BRW1::PAP:KOMENTARS
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
  BRW1::PAP:U_NR = PAP:U_NR
  BRW1::PAP:VIETA = PAP:VIETA
  BRW1::PAP:KOMENTARS = PAP:KOMENTARS
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
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
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
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => PAP:U_NR
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
      POST(Event:Accepted,?Change:2)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
    OF DeleteKey
      POST(Event:Accepted,?Delete:2)
    OF CtrlEnter
      POST(Event:Accepted,?Change:2)
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
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
    OF 1
      PAP:U_NR = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'PAM_P')
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
      BRW1::HighlightedPosition = POSITION(PAP:NR_KEY)
      RESET(PAP:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      PAP:U_NR = PAM:U_NR
      SET(PAP:NR_KEY,PAP:NR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'PAP:U_NR = PAM:U_NR'
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
    CLEAR(PAP:Record)
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
    PAP:U_NR = PAM:U_NR
    SET(PAP:NR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'PAP:U_NR = PAM:U_NR'
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
  CASE BRW1::SortOrder
  OF 1
    PAM:U_NR = BRW1::Sort1:Reset:PAM:U_NR
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.InsertButton=?Insert:2
  BrowseButtons.ChangeButton=?Change:2
  BrowseButtons.DeleteButton=?Delete:2
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
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
  GET(PAM_P,0)
  CLEAR(PAP:Record,0)
  CASE BRW1::SortOrder
  OF 1
    PAP:U_NR = BRW1::Sort1:Reset:PAM:U_NR
  END
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
!| (UpdatePAM_P) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdatePAM_P
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
        GET(PAM_P,0)
        CLEAR(PAP:Record,0)
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


UpdatePAMAMORT PROCEDURE


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
Uzsk_V_LI            DECIMAL(9,2)
Uzsk_V_LIMB          DECIMAL(9,2)
SAK_V_LIMB           DECIMAL(9,2)
NOL_U_LIMB           DECIMAL(9,3)
NOL_Uzsk_LIMB        DECIMAL(9,3)
Nol_Uzsk_LI          DECIMAL(9,3)
IEGADATS             DECIMAL(9,3)
IEGADATS_TEXT        STRING(30)
Update::Reloop  BYTE
Update::Error   BYTE
History::AMO:Record LIKE(AMO:Record),STATIC
SAV::AMO:Record      LIKE(AMO:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:AMO:U_NR     LIKE(AMO:U_NR)
Auto::Save:AMO:YYYYMM   LIKE(AMO:YYYYMM)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the PAMAM File'),AT(1,1,221,267),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdatePAMAMORT'),SYSTEM,GRAY,DOUBLE,MDI
                       SHEET,AT(7,6,206,241),USE(?CurrentTab)
                         TAB('Lineârâ metode'),USE(?Tab:1)
                           GROUP('Mçneða sâkumâ :'),AT(17,20,185,64),USE(?Group1),BOXED
                           END
                           STRING('Uzskaites vçrtîba :'),AT(21,32),USE(?String7)
                           STRING(@n11.2),AT(144,33),USE(Uzsk_V_LI),RIGHT(1)
                           STRING('Uzskaites nolietojums(+u.n.1994):'),AT(21,51),USE(?String14:3)
                           STRING(@n12.3),AT(144,51),USE(Nol_Uzsk_LI),RIGHT(1)
                           STRING(@n11.2),AT(144,42),USE(AMO:SAK_V_LI),RIGHT(1)
                           STRING('Sâkotnçjâ v. aprçíinam:'),AT(21,42),USE(?String7:2)
                           PROMPT('&Nodaïa, kurâ atrodas ð.m. :'),AT(19,97),USE(?AMO:NODALA:Prompt)
                           ENTRY(@s2),AT(184,96,17,10),USE(AMO:NODALA),RIGHT(1)
                           PROMPT('&Skaits ðajâ mçnesî :'),AT(19,108),USE(?AMO:SKAITS:Prompt)
                           ENTRY(@n-4.0),AT(172,107,29,10),USE(AMO:SKAITS),RIGHT(1)
                           PROMPT('&Likme :'),AT(19,118),USE(?AMO:LIN_G_PR:Prompt)
                           ENTRY(@n-7.3),AT(172,118,29,10),USE(AMO:LIN_G_PR),RIGHT(1)
                           PROMPT('&Kapitâlâ rem. vai rek. summa (LIN,GD) :'),AT(19,129,134,10),USE(?AMO:KAPREM:Prompt)
                           ENTRY(@n-13.2),AT(155,129,46,10),USE(AMO:KAPREM),IMM,RIGHT(1)
                           PROMPT('&Pârcenoðanas summa (LIN un GD) :'),AT(19,140,129,10),USE(?AMO:parcen:Prompt)
                           ENTRY(@n-13.2),AT(155,140,46,10),USE(AMO:PARCEN),IMM,RIGHT(1)
                           PROMPT('Pâ&rcenoðanas summa (tikai LIN) :'),AT(19,152,129,10),USE(?AMO:parcenLI:Prompt)
                           ENTRY(@n-13.2),AT(155,152,46,10),USE(AMO:PARCENLI),IMM,RIGHT(1)
                           STRING('Noòemts no uzskaites :'),AT(19,164),USE(?String21)
                           STRING(@n-13.2),AT(151,165),USE(AMO:IZSLEGTS)
                           PROMPT('Nolie&tojums :'),AT(19,176),USE(?AMO:nol_lin:Prompt)
                           ENTRY(@n-12.3),AT(161,176,40,10),USE(AMO:NOL_LIN),RIGHT(1)
                           BUTTON('Lock'),AT(106,175,26,13),USE(?Lock_LI),RIGHT
                           IMAGE('CHECK3.ICO'),AT(135,171,15,18),USE(?Image1),HIDE
                           GROUP('Mçneða beigâs :'),AT(17,188,183,55),USE(?Group2),BOXED
                           END
                           STRING('Uzsk. vçrt. mçn. beigâs :'),AT(21,200),USE(?String7:3)
                           STRING(@n11.2),AT(142,202),USE(Uzsk_V_LIMB),RIGHT(1)
                           STRING('Uzskaites nolietojums(+u.n.1994):'),AT(21,219),USE(?String14:4)
                           STRING(@n12.3),AT(142,219),USE(NOL_Uzsk_LIMB),RIGHT(1)
                           STRING('Sâk.vçrtîba mçn. beigâs :'),AT(21,209),USE(?String7:4)
                           STRING(@n11.2),AT(142,210),USE(SAK_V_LIMB),RIGHT(1)
                           STRING('Uzkrâtais nolietojums:'),AT(21,228),USE(?String14)
                           STRING(@n12.3),AT(142,228),USE(NOL_U_LIMB),RIGHT(1)
                           STRING(@N12.3),AT(144,60),USE(AMO:NOL_U_LI),RIGHT(1)
                           STRING('Uzkrâtais nol.no gada sâk.'),AT(21,70),USE(?String14:5),HIDE
                           STRING(@n12.3),AT(144,70),USE(AMO:NOL_G_LI),HIDE,RIGHT(1)
                           STRING(@s30),AT(54,86),USE(IEGADATS_TEXT)
                           STRING('Uzkrâtais nolietojums:'),AT(21,60),USE(?String14:2)
                         END
                       END
                       STRING(@n_7),AT(178,4),USE(AMO:U_NR)
                       BUTTON('&OK'),AT(122,250,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(170,250,45,14),USE(?Cancel)
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
  Uzsk_V_LI=AMO:SAK_V_LI+PAM:nol_v     !+1994
  Nol_Uzsk_LI=AMO:NOL_U_LI+PAM:NOL_V   !+1994
  START_LI#=DATE(MONTH(PAM:DATUMS),1,YEAR(PAM:DATUMS))       
  IF START_LI#<DATE(1,1,1995) THEN START_LI#=DATE(12,1,1994).
  IF AMO:YYYYMM   =START_LI#           !1. IERAKSTS
     IEGADATS     =PAM:BIL_V
     IEGADATS_TEXT='Iegâdâts '&format(PAM:DATUMS,@D6)&' '&IEGADATS
  ELSE
     IEGADATS     =0
     IEGADATS_TEXT=''
  .
  IF AMO:LOCK_LIN
     UNHIDE(?IMAGE1)
     DISABLE(?AMO:NOL_LIN)
  .
  ?TAB:1{PROP:TEXT}='Lineârâ metode : '&format(AMO:YYYYMM,@d16)
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
    Uzsk_V_LIMB=IEGADATS+Uzsk_V_LI   +AMO:KAPREM+AMO:PARCEN-AMO:IZSLEGTS
    SAK_V_LIMB =IEGADATS+AMO:SAK_V_LI+AMO:KAPREM+AMO:PARCEN-AMO:IZSLEGTS
    Nol_Uzsk_LIMB=Nol_Uzsk_LI+AMO:NOL_LIN              !UZSKAITES NOLIETOJUMS MÇNEÐA BEIGÂS(+u.n.1994)
    NOL_U_LIMB=AMO:NOL_U_LI+AMO:NOL_LIN                !UZKRÂTAIS NOLIETOJUMS MÇNEÐA BEIGÂS
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
      SELECT(?String7)
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
        History::AMO:Record = AMO:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(PAMAM)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(AMO:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'AMO:NR_KEY')
                SELECT(?String7)
                VCRRequest = VCRNone
                CYCLE
              END
            END
            IF DUPLICATE(AMO:YYYYMM_KEY)
              IF StandardWarning(Warn:DuplicateKey,'AMO:YYYYMM_KEY')
                SELECT(?String7)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?String7)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::AMO:Record <> AMO:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:PAMAM(1)
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
              SELECT(?String7)
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
    OF ?AMO:NODALA
      CASE EVENT()
      OF EVENT:Accepted
        F:NODALA=AMO:NODALA
      END
    OF ?Lock_LI
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF AMO:LOCK_LIN
           AMO:LOCK_LIN=FALSE
           HIDE(?IMAGE1)
           ENABLE(?AMO:NOL_LIN)
        ELSE
           AMO:LOCK_LIN=TRUE
           UNHIDE(?IMAGE1)
           DISABLE(?AMO:NOL_LIN)
        .
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
         F:NODALA=''
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(AMO:RECORD)
  FilesOpened = True
  RISnap:PAMAM
  SAV::AMO:Record = AMO:Record
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
        IF RIDelete:PAMAM()
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
  INIRestoreWindow('UpdatePAMAMORT','winlats.INI')
  WinResize.Resize
  ?AMO:SAK_V_LI{PROP:Alrt,255} = 734
  ?AMO:NODALA{PROP:Alrt,255} = 734
  ?AMO:SKAITS{PROP:Alrt,255} = 734
  ?AMO:LIN_G_PR{PROP:Alrt,255} = 734
  ?AMO:KAPREM{PROP:Alrt,255} = 734
  ?AMO:PARCEN{PROP:Alrt,255} = 734
  ?AMO:PARCENLI{PROP:Alrt,255} = 734
  ?AMO:IZSLEGTS{PROP:Alrt,255} = 734
  ?AMO:NOL_LIN{PROP:Alrt,255} = 734
  ?AMO:NOL_U_LI{PROP:Alrt,255} = 734
  ?AMO:NOL_G_LI{PROP:Alrt,255} = 734
  ?AMO:U_NR{PROP:Alrt,255} = 734
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
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
  END
  IF WindowOpened
    INISaveWindow('UpdatePAMAMORT','winlats.INI')
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
    OF ?AMO:SAK_V_LI
      AMO:SAK_V_LI = History::AMO:Record.SAK_V_LI
    OF ?AMO:NODALA
      AMO:NODALA = History::AMO:Record.NODALA
    OF ?AMO:SKAITS
      AMO:SKAITS = History::AMO:Record.SKAITS
    OF ?AMO:LIN_G_PR
      AMO:LIN_G_PR = History::AMO:Record.LIN_G_PR
    OF ?AMO:KAPREM
      AMO:KAPREM = History::AMO:Record.KAPREM
    OF ?AMO:PARCEN
      AMO:PARCEN = History::AMO:Record.PARCEN
    OF ?AMO:PARCENLI
      AMO:PARCENLI = History::AMO:Record.PARCENLI
    OF ?AMO:IZSLEGTS
      AMO:IZSLEGTS = History::AMO:Record.IZSLEGTS
    OF ?AMO:NOL_LIN
      AMO:NOL_LIN = History::AMO:Record.NOL_LIN
    OF ?AMO:NOL_U_LI
      AMO:NOL_U_LI = History::AMO:Record.NOL_U_LI
    OF ?AMO:NOL_G_LI
      AMO:NOL_G_LI = History::AMO:Record.NOL_G_LI
    OF ?AMO:U_NR
      AMO:U_NR = History::AMO:Record.U_NR
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
  AMO:Record = SAV::AMO:Record
  SAV::AMO:Record = AMO:Record
  Auto::Attempts = 0
  LOOP
    Auto::Save:AMO:U_NR = AMO:U_NR
    CLEAR(AMO:YYYYMM,1)
    SET(AMO:NR_KEY,AMO:NR_KEY)
    PREVIOUS(PAMAM)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAMAM')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE() |
    OR Auto::Save:AMO:U_NR <> AMO:U_NR
      Auto::Save:AMO:YYYYMM = 1
    ELSE
      Auto::Save:AMO:YYYYMM = AMO:YYYYMM + 1
    END
    AMO:Record = SAV::AMO:Record
    AMO:YYYYMM = Auto::Save:AMO:YYYYMM
    SAV::AMO:Record = AMO:Record
    ADD(PAMAM)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    DO CancelAutoIncrement
  END

CancelAutoIncrement ROUTINE
  IF LocalResponse <> RequestCompleted
    IF OriginalRequest = InsertRecord
      IF LocalResponse = RequestCancelled
        DELETE(PAMAM)
      END
    END
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

UpdateGGK PROCEDURE 


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
par_nos_s            STRING(15)
KON_KOMENT           STRING(50)
kon_atlikums         DECIMAL(7,2)
ProText              STRING(25)
NodText              STRING(25)
bits3                BYTE
d_k_old    string(1)
bkk_old    string(5)
summa_old  decimal(12,2)
Update::Reloop  BYTE
Update::Error   BYTE
History::GGK:Record LIKE(GGK:Record),STATIC
SAV::GGK:Record      LIKE(GGK:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
FLD6::View           VIEW(VAL_K)
                       PROJECT(VAL:VAL)
                     END
Queue:FileDrop       QUEUE,PRE
FLD6::VAL:VAL          LIKE(VAL:VAL)
FLD6::GGK:VAL          LIKE(GGK:VAL)
                     END
FLD6::LoopIndex      LONG,AUTO
QuickWindow          WINDOW('Update the GGK File'),AT(0,0,201,348),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateGGK'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(1,1,198,315),USE(?CurrentTab)
                         TAB('Konts'),USE(?Tab:1)
                           STRING('RS:'),AT(131,1),USE(?StringRS),HIDE
                           ENTRY(@s1),AT(145,0,11,10),USE(GGK:RS),HIDE
                           BUTTON('&Nodaïa'),AT(7,19,59,12),USE(?Nodala)
                           BUTTON('C'),AT(67,20,11,12),USE(?ButtonCN)
                           STRING(@s25),AT(79,22,103,10),USE(NodText),LEFT(1)
                           STRING(@s2),AT(182,21),USE(GGK:NODALA),CENTER
                           BUTTON('Projekts (Obj.)'),AT(7,32,59,12),USE(?Projekts)
                           BUTTON('C'),AT(67,32,11,12),USE(?ButtonCP)
                           STRING(@s25),AT(79,33,89,10),USE(ProText),LEFT(1)
                           STRING(@n_6b),AT(169,33),USE(GGK:OBJ_NR)
                           PROMPT('&Reference'),AT(68,45,23,10),USE(?GGK:REFERENCE:Prompt),DISABLE,HIDE
                           ENTRY(@S14),AT(95,45,82,10),USE(GGK:REFERENCE),RIGHT(1)
                           BUTTON('&Reference'),AT(7,44,59,12),USE(?FindRef)
                           BUTTON('&Partneris/Avansieris'),AT(6,56,71,14),USE(?PartnerisAvansieris)
                           STRING(@s15),AT(81,57,66,10),USE(par_nos_s),LEFT(1)
                           STRING(@n_7.0),AT(149,57),USE(GGK:PAR_NR),CENTER
                           BUTTON('&Konts'),AT(9,70,45,14),USE(?KONTS)
                           ENTRY(@s5),AT(57,72,34,10),USE(GGK:BKK),IMM,CENTER(2),REQ,OVR,UPR
                           OPTION('D_K'),AT(96,67,81,18),USE(GGK:D_K),BOXED
                             RADIO('D'),AT(120,73),USE(?GGK:D_K:Radio1)
                             RADIO('K'),AT(146,73),USE(?GGK:D_K:Radio2)
                           END
                           STRING(@s50),AT(7,86,190,10),USE(KON_KOMENT)
                           STRING('Atlikums :'),AT(12,97),USE(?String6)
                           STRING(@n-_11.2),AT(46,97),USE(kon_atlikums),RIGHT(1)
                           PROMPT('&Summa :'),AT(12,107),USE(?GGK:SUMMAV:Prompt)
                           ENTRY(@n-15.2),AT(62,107,68,10),USE(GGK:SUMMAV),RIGHT(2)
                           LIST,AT(135,107,36,10),USE(GGK:VAL),FORMAT('10C@s3@'),DROP(10),FROM(Queue:FileDrop)
                           BUTTON('PVN   %'),AT(7,118,39,11),USE(?ButtonPVN)
                           STRING(@n-15.2),AT(71,120,60,10),USE(GGK:SUMMA),RIGHT(2)
                           STRING(@s3),AT(142,120,19,10),USE(Val_uzsk)
                           ENTRY(@n2),AT(48,119,13,10),USE(GGK:PVN_PROC),CENTER(1),OVR
                           OPTION('PVN tips :'),AT(7,129,184,166),USE(GGK:PVN_TIPS),BOXED
                             RADIO('0-Iekðzemç (arî ES) saòemtais(samaksâtais)'),AT(18,139,164,10),USE(?GGK:PVN_TIPS:Radio1),VALUE('0')
                             RADIO('1-norçíini ar budþetu'),AT(18,147),USE(?GGK:PVN_TIPS:Radio2),VALUE('1')
                             RADIO('2-par importa neES preèu piegâdçm'),AT(18,155),USE(?GGK:PVN_TIPS:Radio3),VALUE('2')
                             RADIO('3-kokmateriâlu iegâde (vairumtirdzniecîba)'),AT(18,163),USE(?GGK:PVN_TIPS:Radio4),VALUE('3')
                             RADIO('4-kokmateriâlu iegâde (mazumtirdzniecîba)'),AT(18,171),USE(?GGK:PVN_TIPS:Radio5),VALUE('4')
                             RADIO('5-kokmateriâlu realizâcija (vairumtirdzniecîba)'),AT(18,179),USE(?GGK:PVN_TIPS:Radio6),VALUE('5')
                             RADIO('6-kokmateriâlu realizâcija (mazumtirdzniecîba)'),AT(18,187),USE(?GGK:PVN_TIPS:Radio7),VALUE('6')
                             RADIO('7-PVN pârkontçðana '),AT(18,195),USE(?GGK:PVN_TIPS:Radio8),VALUE('7')
                             RADIO('8-kokmateriâlu pakalpojumu iegâde '),AT(18,203),USE(?GGK:PVN_TIPS:Radio9),VALUE('8')
                             RADIO('9-kokmateriâlu pakalpojumu realizâcija'),AT(18,211),USE(?GGK:PVN_TIPS:Radio10),VALUE('9')
                             RADIO('N-iekðzemç nesamaksâtais PVN'),AT(18,219),USE(?GGK:PVN_TIPS:Radio11),VALUE('N')
                             RADIO('I-par importa (arî ES) pakalpojumiem'),AT(18,227),USE(?GGK:PVN_TIPS:Radio12),VALUE('I')
                             RADIO('A-atgriezta prece'),AT(18,235),USE(?GGK:PVN_TIPS:Radio13),VALUE('A')
                             RADIO('Z-zaudçts parâds'),AT(18,243),USE(?GGK:PVN_TIPS:Radio14),VALUE('Z')
                             RADIO('R2-darîjumi ar metâllûþòiem'),AT(18,259),USE(?GGK:PVN_TIPS:Radio14:2),VALUE('M')
                             RADIO('R1-darîjumi ar kokmateriâliem'),AT(18,251),USE(?GGK:PVN_TIPS:Radio19),VALUE('K')
                             RADIO('R3-bûvniecîbas pakalpojumi'),AT(18,267),USE(?GGK:PVN_TIPS:Radio14:3),VALUE('B')
                             RADIO('E- Neapliekâmai realizâcijai'),AT(18,275),USE(?GGK:PVN_TIPS:Radio14:4),VALUE('E')
                             RADIO('R- Proporcijas aprçíinam'),AT(18,283),USE(?GGK:PVN_TIPS:Radio14:5),VALUE('R')
                           END
                           OPTION('Spec:'),AT(7,296,184,17),USE(bits3),BOXED
                             RADIO('0'),AT(36,302,18,10),USE(?BITS3:Radio1),VALUE('0')
                             RADIO('1-neiekïaut NPP2'),AT(53,302),USE(?BITS3:Radio2),VALUE('1')
                           END
                         END
                       END
                       BUTTON('&OK'),AT(101,333,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(151,333,45,14),USE(?Cancel)
                       STRING('Kontu korespodence:'),AT(2,319),USE(?String8)
                       BUTTON(' '),AT(78,319,13,11),USE(?kk1)
                       BUTTON(' '),AT(93,319,13,11),USE(?kk2)
                       BUTTON(' '),AT(108,319,13,11),USE(?kk3)
                       BUTTON(' '),AT(123,319,13,11),USE(?kk4)
                       BUTTON(' '),AT(138,319,13,11),USE(?kk5)
                       BUTTON(' '),AT(153,319,13,11),USE(?kk6)
                       BUTTON(' '),AT(168,319,13,11),USE(?kk7)
                       BUTTON(' '),AT(183,319,13,11),USE(?kk8)
                       BUTTON('Pievienot P/L'),AT(6,333,58,14),USE(?ButtonPL),HIDE
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
  PAR_NOS_S=GETPAR_K(GGK:PAR_NR,0,1)
  PROTEXT=GETPROJEKTI(GGK:OBJ_NR,1)
  NODTEXT=GETNODALAS(GGK:NODALA,1)
  KON_KOMENT=GETKON_K(GGK:BKK,0,2)
  KON_ATLIKUMS=GETKON_K(GGK:BKK,0,3)
  val:val    =ggk:val
  d_k_old    =ggk:d_k
  bkk_old    =ggk:bkk
  summa_old  =ggk:summa
  IF GGK:U_NR=1 AND ~(ATLAUTS[18]='1') !ATÏAUTI NEAPSTIPRINÂTIE / SALDO
     UNHIDE(?STRINGRS)
     UNHIDE(?GGK:RS)
  .
  IF DB_GADS >= 2003
     DISABLE(?GGK:PVN_TIPS:Radio11)
  .
  IF BAND(GGK:KK,10000000b) THEN ?KK1{PROP:TEXT}='*'.
  IF BAND(GGK:KK,01000000b) THEN ?KK2{PROP:TEXT}='*'.
  IF BAND(GGK:KK,00100000b) THEN ?KK3{PROP:TEXT}='*'.
  IF BAND(GGK:KK,00010000b) THEN ?KK4{PROP:TEXT}='*'.
  IF BAND(GGK:KK,00001000b) THEN ?KK5{PROP:TEXT}='*'.
  IF BAND(GGK:KK,00000100b) THEN ?KK6{PROP:TEXT}='*'.
  IF BAND(GGK:KK,00000010b) THEN ?KK7{PROP:TEXT}='*'.
  IF BAND(GGK:KK,00000001b) THEN ?KK8{PROP:TEXT}='*'.
  IF BAND(ggk:BAITS,00000010b)    !AR PVN NEAPLIEKAMS
     ?BUTTONPVN{PROP:TEXT}='PVN neapl.'
  .
  IF BAND(ggk:BAITS,00000100b) THEN BITS3=1. !IGNORÇT NPP2
  IF BROWSEPAR_K::USED=TRUE
     DISABLE(?PARTNERISAVANSIERIS)
  .
  !*******USER LEVEL ACCESS CONTROL********
  IF BAND(REG_BASE_ACC,00000010b) ! Budþets
     ?Projekts{PROP:TEXT}='Klasif.kods'
  .
  
  !select(?GGK:BKK)  ÐEIT NESTRÂDÂ
!  STOP(PAMAM::Used)
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
    !PVN,P/L KONTS
       IF ggk:bkk[1:4]='5721'
          ENABLE(?GGK:PVN_TIPS)
!       ELSIF ggk:D_K = 'K' AND ggk:PVN_PROC = 0 AND INRANGE(ggk:bkk[1:2],'59','99')
!          ENABLE(?GGK:PVN_TIPS)
       ELSIF ggk:bkk[1:3]='112' OR ggk:bkk[1:2]='12'
          UNHIDE(?BUTTONPL)
       ELSE
          GGK:PVN_TIPS=0
          DISABLE(?GGK:PVN_TIPS)
          HIDE(?BUTTONPL)
       .
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
      DO FLD6::FillList
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?StringRS)
      EXECUTE LOCALREQUEST
         SELECT(?ggk:bkk)
         SELECT(?ggk:summav)
      .
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
        History::GGK:Record = GGK:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(GGK)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?StringRS)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::GGK:Record <> GGK:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:GGK(1)
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
              SELECT(?StringRS)
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
    OF ?Nodala
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNodalas 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           GGK:NODALA=NOD:U_NR
           NODTEXT=NOD:NOS_P
        END
      END
    OF ?ButtonCN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GGK:NODALA=''
        NodText=''
        DISPLAY
      END
    OF ?Projekts
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseProjekti 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           GGK:OBJ_NR=PRO:U_NR
           PROTEXT=PRO:NOS_P
        END
      END
    OF ?ButtonCP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GGK:OBJ_NR=0
        ProText=''
        DISPLAY
      END
    OF ?FindRef
      CASE EVENT()
      OF EVENT:Accepted
          KKK=GGK:BKK
          D_K=GGK:D_K
          KKK1=''    !jânotîra dçï ieskaita
          D_K1=''
        
        DO SyncWindow
        PerformShortcutForRef 
        LocalRequest = OriginalRequest
        DO RefreshWindow
      END
    OF ?PartnerisAvansieris
      CASE EVENT()
      OF EVENT:Accepted
        Apskatit231531=FALSE    !AIZLIEGTS ATVÇRT N231,N531 NO PAR_K
        
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           par_nos_s=PAR:NOS_S
           GGK:PAR_NR=PAR:U_NR
        .
        DISPLAY(?par_nos_s)
        DISPLAY(?GGK:PAR_NR)
        Apskatit231531=TRUE
      END
    OF ?KONTS
      CASE EVENT()
      OF EVENT:Accepted
        KKK=GGK:BKK
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseKON_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           kon_koment=KON:NOSAUKUMS
           GGK:BKK=KON:BKK
           KON_ATLIKUMS=kon:atlikums[loc_nr]
           IF ~GGK:VAL THEN GGK:VAL=GETKON_K(GGK:BKK,2,8). !KON:VAL vai VAL_NOS-PÇDÇJO LIETOTO vai VAL_LV
           IF ~GGK:SUMMAV THEN GGK:SUMMAV=GGK:SUMMA/BANKURS(GGK:VAL,GGK:DATUMS).
           SELECT(?GGK:D_K)
           DISPLAY
        .
        
      END
    OF ?GGK:BKK
      CASE EVENT()
      OF EVENT:Accepted
        ggk:bkk=GETKON_K(ggk:bkk,1,1)
        kon_koment=KON:NOSAUKUMS
        KON_ATLIKUMS=kon:atlikums[loc_nr]
!        STOP(VAL_LV)
        IF ~GGK:VAL THEN GGK:VAL=GETKON_K(GGK:BKK,2,8). !KON:VAL vai VAL_LV vai VAL_NOS-PÇDÇJO LIETOTOTÂ
        IF ~GGK:SUMMAV THEN GGK:SUMMAV=GGK:SUMMA/BANKURS(GGK:VAL,GGK:DATUMS).  !?
        SELECT(?GGK:D_K)
        DISPLAY
      END
    OF ?GGK:SUMMAV
      CASE EVENT()
      OF EVENT:Accepted
        GGK:SUMMA=GGK:SUMMAV*BANKURS(GGK:VAL,GGK:DATUMS)
        DO FILLGLVAR
        DISPLAY(?GGK:SUMMA)
      END
    OF ?GGK:VAL
      CASE EVENT()
      OF EVENT:Accepted
        GET(Queue:FileDrop,CHOICE())
        GGK:VAL = FLD6::VAL:VAL
        GGK:SUMMA=GGK:SUMMAV*BANKURS(GGK:VAL,GGK:DATUMS)
        DO FILLGLVAR
        DISPLAY(?GGK:SUMMA)
      END
    OF ?ButtonPVN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(ggk:BAITS,00000010b)    !AR PVN NEAPLIEKAMS
           GGK:BAITS-=2
           ?BUTTONPVN{PROP:TEXT}='PVN  %'
           ENABLE(?GGK:PVN_PROC)
        ELSE
           GGK:BAITS+=2
           GGK:PVN_PROC=0
           ?BUTTONPVN{PROP:TEXT}='PVN neapl.'
           DISABLE(?GGK:PVN_PROC)
        .
        DISPLAY
      END
    OF ?bits3
      CASE EVENT()
      OF EVENT:Accepted
          IF BITS3 AND ~BAND(ggk:BAITS,00000100b)    !IGNORÇT NPP2
             GGK:BAITS+=4
          ELSIF ~BITS3 AND BAND(ggk:BAITS,00000100b) !~IGNORÇT NPP2
             GGK:BAITS-=4
          .
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        IF LOCALREQUEST=1 AND GGK:U_NR <> 1 AND ~GG:DOK_SENR
        CASE GGK:BKK[1:3]
           OF '261' ! KASE
              CASE GGK:D_K
              OF 'D'
                 GG:DOK_SENR=PERFORMGL(2)
              OF 'K'
                 GG:DOK_SENR=PERFORMGL(3)
              .
        !   OF '262' ! Izejoðais MU
        !      CASE GGK:D_K
        !       OF 'K'
        !         GG:DOK_NR=PERFORMGL(1)
        !      .
           .
        .
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
    OF ?kk1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(GGK:KK,10000000b) !JA IR DEFINÇTA KK
           GGK:KK-=2^7
           ?KK1{PROP:TEXT}=''
        ELSE
           GGK:KK+=2^7
           ?KK1{PROP:TEXT}='*'
        .
        display(?KK1)
      END
    OF ?kk2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(GGK:KK,01000000b) !JA IR DEFINÇTA KK
           GGK:KK-=2^6
           ?KK2{PROP:TEXT}=''
        ELSE
           GGK:KK+=2^6
           ?KK2{PROP:TEXT}='*'
        .
        display(?KK2)
      END
    OF ?kk3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(GGK:KK,00100000b) !JA IR DEFINÇTA KK
           GGK:KK-=2^5
           ?KK3{PROP:TEXT}=''
        ELSE
           GGK:KK+=2^5
           ?KK3{PROP:TEXT}='*'
        .
        display(?KK3)
      END
    OF ?kk4
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(GGK:KK,00010000b) !JA IR DEFINÇTA KK
           GGK:KK-=2^4
           ?KK4{PROP:TEXT}=''
        ELSE
           GGK:KK+=2^4
           ?KK4{PROP:TEXT}='*'
        .
        display(?KK4)
      END
    OF ?kk5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(GGK:KK,00001000b) !JA IR DEFINÇTA KK
           GGK:KK-=2^3
           ?KK5{PROP:TEXT}=''
        ELSE
           GGK:KK+=2^3
           ?KK5{PROP:TEXT}='*'
        .
        display(?KK5)
      END
    OF ?kk6
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(GGK:KK,00000100b) !JA IR DEFINÇTA KK
           GGK:KK-=2^2
           ?KK6{PROP:TEXT}=''
        ELSE
           GGK:KK+=2^2
           ?KK6{PROP:TEXT}='*'
        .
        display(?KK6)
      END
    OF ?kk7
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(GGK:KK,00000010b) !JA IR DEFINÇTA KK
           GGK:KK-=2^1
           ?KK7{PROP:TEXT}=''
        ELSE
           GGK:KK+=2^1
           ?KK7{PROP:TEXT}='*'
        .
        display(?KK7)
      END
    OF ?kk8
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(GGK:KK,00000001b) !JA IR DEFINÇTA KK
           GGK:KK-=2^0
           ?KK8{PROP:TEXT}=''
        ELSE
           GGK:KK+=2^0
           ?KK8{PROP:TEXT}='*'
        .
        display(?KK8)
      END
    OF ?ButtonPL
      CASE EVENT()
      OF EVENT:Accepted
        GG::U_NR=GG:U_NR
        CLOSE(PAMAT)
        CLOSE(PAMAM)
        PAMATNAME='PAMAT01'
        PAMAMNAME='PAMAM01'
        CLEAR(PAM:RECORD)
        DO SyncWindow
        GlobalRequest = InsertRecord
        UpdatePamat 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        GG::U_NR=0
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  IF KON_K::Used = 0
    CheckOpen(KON_K,1)
  END
  KON_K::Used += 1
  BIND(KON:RECORD)
  IF VAL_K::Used = 0
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  BIND(VAL:RECORD)
  FilesOpened = True
  RISnap:GGK
  SAV::GGK:Record = GGK:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    GGK:DATUMS=GG:DATUMS
    IF ~(COPYREQUEST = 1)    !19/11/2015
    GGK:PAR_NR=GG:PAR_NR
    IF ~PVN_PROC
       CHECKOPEN(SYSTEM,1)
       PVN_PROC=SYS:NOKL_PVN
    .
    GGK:PVN_PROC=PVN_PROC
    GGK:PVN_TIPS='0'
    IF ~VAL_NOS THEN VAL_NOS=VAL_LV.
    GGK:VAL=''       !PAGAIDÎSIM,KAMÇR ZINÂSIM, KAS PAR KONTU
    IF BILANCE>0
       D_K='K'
    ELSE
       D_K='D'
    .
    GGK:D_K=D_K
    GGK:SUMMA=ABS(BILANCE)
    ELSE                 !19/11/2015
       COPYREQUEST = 0   !19/11/2015
    .                    !19/11/2015
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:GGK()
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
  INIRestoreWindow('UpdateGGK','winlats.INI')
  WinResize.Resize
  ?GGK:RS{PROP:Alrt,255} = 734
  ?GGK:NODALA{PROP:Alrt,255} = 734
  ?GGK:OBJ_NR{PROP:Alrt,255} = 734
  ?GGK:REFERENCE{PROP:Alrt,255} = 734
  ?GGK:PAR_NR{PROP:Alrt,255} = 734
  ?GGK:BKK{PROP:Alrt,255} = 734
  ?GGK:D_K{PROP:Alrt,255} = 734
  ?GGK:SUMMAV{PROP:Alrt,255} = 734
  ?GGK:VAL{PROP:Alrt,255} = 734
  ?GGK:SUMMA{PROP:Alrt,255} = 734
  ?GGK:PVN_PROC{PROP:Alrt,255} = 734
  ?GGK:PVN_TIPS{PROP:Alrt,255} = 734
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
     IF LocalResponse = RequestCompleted
        AtlikumiB(ggk:d_k,ggk:bkk,ggk:summa,d_k_old,bkk_old,summa_old)
     .
!     STOP(PAMAM::Used)
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
  END
  IF WindowOpened
    INISaveWindow('UpdateGGK','winlats.INI')
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
!************  PIEÐÍIRAM GLOB_MAINÎGOS *********
FILLGLVAR   ROUTINE
    val_nos = GGK:VAL                           !ATCERAMIES TÂLÂKAI APSTR.
    IF GGK:U_NR=1 OR GGK:BKK='57210'
       D_K = GGK:D_K                            !ATCERAMIES TÂLÂKAI APSTR.
    ELSIF GGK:D_K = 'D'
       D_K = 'K'                                !ATCERAMIES TÂLÂKAI APSTR.
    ELSE
       D_K = 'D'                                !ATCERAMIES TÂLÂKAI APSTR.
    .
    PVN_PROC  = GGK:PVN_PROC                    !ATCERAMIES TÂLÂKAI APSTR.
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?GGK:RS
      GGK:RS = History::GGK:Record.RS
    OF ?GGK:NODALA
      GGK:NODALA = History::GGK:Record.NODALA
    OF ?GGK:OBJ_NR
      GGK:OBJ_NR = History::GGK:Record.OBJ_NR
    OF ?GGK:REFERENCE
      GGK:REFERENCE = History::GGK:Record.REFERENCE
    OF ?GGK:PAR_NR
      GGK:PAR_NR = History::GGK:Record.PAR_NR
    OF ?GGK:BKK
      GGK:BKK = History::GGK:Record.BKK
    OF ?GGK:D_K
      GGK:D_K = History::GGK:Record.D_K
    OF ?GGK:SUMMAV
      GGK:SUMMAV = History::GGK:Record.SUMMAV
    OF ?GGK:VAL
      GGK:VAL = History::GGK:Record.VAL
    OF ?GGK:SUMMA
      GGK:SUMMA = History::GGK:Record.SUMMA
    OF ?GGK:PVN_PROC
      GGK:PVN_PROC = History::GGK:Record.PVN_PROC
    OF ?GGK:PVN_TIPS
      GGK:PVN_TIPS = History::GGK:Record.PVN_TIPS
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
  GGK:Record = SAV::GGK:Record
  GGK:D_K = 'D'
  GGK:VAL = 'Ls'
  !19/11/2015 <
  GGK:VAL = val_uzsk
  IF COPYREQUEST = 1
     GGK:D_K = SAV::GGK:Record.D_K
  .
  !19/11/2015 >
  SAV::GGK:Record = GGK:Record
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


!----------------------------------------------------
FLD6::FillList ROUTINE
!|
!| This routine is used to fill the queue that is used by the FileDrop (FD)
!| control template.
!|
!| First, the queue used by the FD (Queue:FileDrop) is FREEd, in case this routine is
!| called by EMBED code and when the window gains focus.
!|
!| Next, the VIEW used by the FD is setup and opened. In a loop, each record of the
!| view is retrieved and, if applicable, added to the FD queue. The view is then closed.
!|
!| Finally, the queue is sorted, and the necessary record retrieved.
!|
  FREE(Queue:FileDrop)
  SET(VAL:NOS_KEY)
  FLD6::View{Prop:Filter} = ''
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(FLD6::View)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  LOOP
    NEXT(FLD6::View)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'VAL_K')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    FLD6::VAL:VAL = VAL:VAL
    FLD6::GGK:VAL = GGK:VAL
    ADD(Queue:FileDrop)
  END
  CLOSE(FLD6::View)
  IF RECORDS(Queue:FileDrop)
    IF GGK:VAL
      LOOP FLD6::LoopIndex = 1 TO RECORDS(Queue:FileDrop)
        GET(Queue:FileDrop,FLD6::LoopIndex)
        IF GGK:VAL = FLD6::VAL:VAL THEN BREAK.
      END
      ?GGK:VAL{Prop:Selected} = FLD6::LoopIndex
    END
  ELSE
    CLEAR(GGK:VAL)
  END
