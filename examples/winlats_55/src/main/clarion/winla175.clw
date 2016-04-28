                     MEMBER('winlats.clw')        ! This is a MEMBER module
BrowseMER_K PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG

BRW1::View:Browse    VIEW(MER_K)
                       PROJECT(MER:MERVIEN)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::MER:MERVIEN      LIKE(MER:MERVIEN)          ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(MER:MERVIEN),DIM(100)
BRW1::Sort1:LowValue LIKE(MER:MERVIEN)            ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(MER:MERVIEN)           ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Browse the MER_K File'),AT(,,159,188),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseMER_K'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,143,124),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('32L(2)|M~MERVIEN~L(2)@s7@'),FROM(Queue:Browse:1)
                       BUTTON('I&evadît'),AT(8,148,45,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(57,148,45,14),USE(?Change:2),DEFAULT
                       BUTTON('&Dzçst'),AT(106,148,45,14),USE(?Delete:2)
                       BUTTON('Iz&vçlçties'),AT(10,169),USE(?Select),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                       SHEET,AT(4,4,151,162),USE(?CurrentTab)
                         TAB('MER:MER_KEY'),USE(?Tab:2)
                         END
                       END
                       BUTTON('&Beigt'),AT(57,170,45,14),USE(?Close)
                       BUTTON('&Help'),AT(106,170,45,14),USE(?Help),STD(STD:Help)
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
    OF ?Select
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
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
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
  IF MER_K::Used = 0
    CheckOpen(MER_K,1)
  END
  MER_K::Used += 1
  BIND(MER:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseMER_K','winlats.INI')
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
    MER_K::Used -= 1
    IF MER_K::Used = 0 THEN CLOSE(MER_K).
  END
  IF WindowOpened
    INISaveWindow('BrowseMER_K','winlats.INI')
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
  IF BRW1::SortOrder = 0
    BRW1::SortOrder = 1
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
      StandardWarning(Warn:RecordFetchError,'MER_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = MER:MERVIEN
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'MER_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = MER:MERVIEN
    SetupStringStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue,SIZE(BRW1::Sort1:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  MER:MERVIEN = BRW1::MER:MERVIEN
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
  BRW1::MER:MERVIEN = MER:MERVIEN
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
        BRW1::PopupText = 'I&evadît|&Mainît|&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = 'I&evadît|&Mainît|&Dzçst'
      END
    ELSE
      BRW1::PopupText = '~Iz&vçlçties'
      IF BRW1::PopupText
        BRW1::PopupText = 'I&evadît|~&Mainît|~&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = 'I&evadît|~&Mainît|~&Dzçst'
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
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF ?Browse:1{Prop:VScroll} = False
        ?Browse:1{Prop:VScroll} = True
      END
      CASE BRW1::SortOrder
      OF 1
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => UPPER(MER:MERVIEN)
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
          IF UPPER(SUB(MER:MERVIEN,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(MER:MERVIEN,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            MER:MERVIEN = CHR(KEYCHAR())
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
      MER:MERVIEN = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'MER_K')
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
      BRW1::HighlightedPosition = POSITION(MER:MER_KEY)
      RESET(MER:MER_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(MER:MER_KEY,MER:MER_KEY)
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
    CLEAR(MER:Record)
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
    SET(MER:MER_KEY)
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
  TBarBrwHelp{PROP:DISABLE}=?Help{PROP:DISABLE}
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
  GET(MER_K,0)
  CLEAR(MER:Record,0)
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
!| (UpdateMER_K) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[6])
     EXIT
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateMER_K
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
        GET(MER_K,0)
        CLEAR(MER:Record,0)
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


BrowsePava1 PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
DOK_SK               LONG
NOM_SK               LONG
Auto::Attempts        LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)
FOLDERIS              CSTRING(60)
FILENAME3             CSTRING(60)
FILENAME4             CSTRING(60)
D_K_TIPS              BYTE
SAV_RECORD            LIKE(NOL:RECORD)
NOL_SUMMAV            LIKE(NOL:SUMMAV)
PAV_SUMMA             LIKE(PAV:SUMMA)
ParrekRaz             BYTE
AVOTS                 STRING(2)
APK_SK                USHORT
APD_SK                USHORT


X                    BYTE
Process              STRING(45)
Process1             STRING(35)
Process2             STRING(35)

Askscreen WINDOW('Datu imports'),AT(,,189,138),CENTER,GRAY
       OPTION(' '),AT(114,1,51,37),USE(D_K_TIPS),BOXED
         RADIO('kâ ir'),AT(117,9),USE(?d_k_tips:1),VALUE('1')
         RADIO('kâ D'),AT(117,18),USE(?d_k_tips:2),VALUE('2')
         RADIO('kâ K'),AT(117,27),USE(?d_k_tips:3),VALUE('3')
       END
       STRING('Process...'),AT(46,28),USE(?StringProcess),HIDE
       STRING('Importçt visus dokumentus  '),AT(20,18),USE(?String1)
       SPIN(@d6),AT(28,40,48,12),USE(s_dat)
       SPIN(@d6),AT(98,40,48,12),USE(B_DAT)
       STRING('kam X='),AT(24,58),USE(?String4)
       ENTRY(@n1B),AT(51,57),USE(X),CENTER
       STRING('un Y='),AT(74,58),USE(?string:RS),HIDE
       ENTRY(@S1),AT(95,57),USE(RS),HIDE,CENTER
       BUTTON('Pârrçíinât K,P Raþoðanu (26-50) pçc 6.c'),AT(13,72,139,14),USE(?ButtonParrekRaz)
       IMAGE('CHECK3.ICO'),AT(154,70,17,17),USE(?ImageRaz),HIDE
       STRING(@s45),AT(0,90,188,10),USE(process),CENTER
       STRING(@s35),AT(24,98),USE(process1),CENTER
       STRING(@s35),AT(24,106),USE(process2),CENTER
       STRING('lîdz'),AT(82,42),USE(?String3)
       STRING('no'),AT(15,42),USE(?String2)
       BUTTON('&OK'),AT(105,119,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(147,119,36,14),USE(?CancelButton)
     END


BRW1::View:Browse    VIEW(PAVA1)
                       PROJECT(PA1:KEKSIS)
                       PROJECT(PA1:RS)
                       PROJECT(PA1:NODALA)
                       PROJECT(PA1:DATUMS)
                       PROJECT(PA1:D_K)
                       PROJECT(PA1:DOK_SENR)
                       PROJECT(PA1:NOKA)
                       PROJECT(PA1:SUMMA)
                       PROJECT(PA1:val)
                       PROJECT(PA1:U_NR)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::PA1:KEKSIS       LIKE(PA1:KEKSIS)           ! Queue Display field
BRW1::PA1:RS           LIKE(PA1:RS)               ! Queue Display field
BRW1::PA1:NODALA       LIKE(PA1:NODALA)           ! Queue Display field
BRW1::PA1:DATUMS       LIKE(PA1:DATUMS)           ! Queue Display field
BRW1::PA1:D_K          LIKE(PA1:D_K)              ! Queue Display field
BRW1::PA1:DOK_SENR     LIKE(PA1:DOK_SENR)         ! Queue Display field
BRW1::PA1:NOKA         LIKE(PA1:NOKA)             ! Queue Display field
BRW1::PA1:SUMMA        LIKE(PA1:SUMMA)            ! Queue Display field
BRW1::PA1:val          LIKE(PA1:val)              ! Queue Display field
BRW1::PA1:U_NR         LIKE(PA1:U_NR)             ! Queue Display field
BRW1::ATLAUTS          LIKE(ATLAUTS)              ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(PA1:DATUMS),DIM(100)
BRW1::Sort1:LowValue LIKE(PA1:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(PA1:DATUMS)            ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Browse the PAVA1 File'),AT(,,345,291),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('BrowsePava1'),SYSTEM,GRAY,DOUBLE,MDI
                       LIST,AT(8,20,329,246),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('12C|M~X~@n1B@10C(1)|M~Y~R@S1@10C|M~N~@s1@45R(2)|M~Datums~C(0)@D6@12C|M~DK~@s1@60' &|
   'R(2)|M~Sçrija-Nr~C(0)@s14@65L(1)|M~Partneris~C(0)@s15@56D(12)|M~Summa~C(0)@n-15.' &|
   '2@17C|M~Val~@s3@41R(2)|M~U NR~C(0)@n_8.0@'),FROM(Queue:Browse:1)
                       BUTTON('&Importçt'),AT(223,275,55,14),USE(?ButtonImportçt)
                       BUTTON('&Beigt'),AT(282,275,48,14),USE(?Cancel)
                       BUTTON('&X'),AT(6,275,25,14),USE(?ButtonX)
                       SHEET,AT(4,4,339,268),USE(?CurrentTab)
                         TAB('Datumu secîba'),USE(?Tab:2)
                         END
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
  ! PIRMS CLARIS RAUJ VAÏÂ FAILUS
  TTAKA"=PATH()
  FILENAME1=''
  IF COPYREQUEST=2 !BÛS JÂSTRÂDÂ AR APMAIÒAS FAILIEM
     SETPATH(USERFOLDER)
     IF ~FILEDIALOG('...TIKAI A_PAVA*.TPS FAILI !!!',FILENAME1,'Topspeed|A_PAVA*.tps',0)
        SETPATH(TTAKA")
        DO PROCEDURERETURN
     .
     SETPATH(TTAKA")
     LOOP I#=LEN(FILENAME1)-1 TO 6 BY -1
        IF UPPER(FILENAME1[I#-5:I#])='A_PAVA'
           FOLDERIS=FILENAME1[1:I#-6]
           AVOTS=FILENAME1[I#+1:I#+2]
           FOUND#=1
           BREAK
        .
     .
  !!   STOP('FOLDERIS: '&FOLDERIS)
     IF ~FOUND#
        KLUDA(120,FILENAME1)
        DO PROCEDURERETURN
     .
  !   IF FILENAME1[1]='E' !FLAÐÐ
  !      FILENAME4=USERFOLDER&'\A_PAVA'&AVOTS&'.TPS'
  !      IF ~CopyFileA(FILENAME1,FILENAME4,0)
  !         KLUDA(3,FILENAME1&' uz '&FILENAME4)
  !      .
  !      FILENAME2=FOLDERIS&'A_NOLI'&AVOTS&'.TPS'
  !      FILENAME4=USERFOLDER&'\A_NOLI'&AVOTS&'.TPS'
  !      IF ~CopyFileA(FILENAME2,FILENAME4,0)
  !         KLUDA(3,FILENAME2&' uz '&FILENAME4)
  !      .
  !      FILENAME3=FOLDERIS&'A_NOM_'&AVOTS&'.TPS'
  !      FILENAME4=USERFOLDER&'\A_NOM_'&AVOTS&'.TPS'
  !      IF ~CopyFileA(FILENAME3,FILENAME4,0)
  !         KLUDA(3,FILENAME3&' uz '&FILENAME4)
  !      .
  !      FILENAME3=FOLDERIS&'A_PAR_'&AVOTS&'.TPS'
  !      FILENAME4=USERFOLDER&'\A_PAR_'&AVOTS&'.TPS'
  !      IF ~CopyFileA(FILENAME3,FILENAME4,0)
  !         KLUDA(3,FILENAME3&' uz '&FILENAME4)
  !      .
  !      FILENAME3=FOLDERIS&'A_AAPK'&AVOTS&'.TPS'
  !      FILENAME4=USERFOLDER&'\A_AAPK'&AVOTS&'.TPS'
  !      IF ~CopyFileA(FILENAME3,FILENAME4,0)
  !         KLUDA(3,FILENAME3&' uz '&FILENAME4)
  !      .
  !      FILENAME3=FOLDERIS&'A_ADAR'&AVOTS&'.TPS'
  !      FILENAME4=USERFOLDER&'\A_ADAR'&AVOTS&'.TPS'
  !      IF ~CopyFileA(FILENAME3,FILENAME4,0)
  !         KLUDA(3,FILENAME3&' uz '&FILENAME4)
  !      .
  !      FOLDERIS=USERFOLDER&'\'
  !   .
     FILENAME2=FOLDERIS&'A_NOLI'&AVOTS&'.TPS'
     FILENAME1=FOLDERIS&'A_NOM_'&AVOTS&'.TPS'
     CHECKOPEN(NOM_K1,1)
     FILENAME1=FOLDERIS&'A_PAR_'&AVOTS&'.TPS'
     CHECKOPEN(PAR_K1,1)
  !   FILENAME1=FOLDERIS&'A_AAPK'&AVOTS&'.TPS'
  !   CHECKOPEN(AUTOAPK1,1)
  !   FILENAME1=FOLDERIS&'A_ADAR'&AVOTS&'.TPS'
  !   CHECKOPEN(AUTODARBI1,1)
     FILENAME1=FOLDERIS&'A_PAVA'&AVOTS&'.TPS'
  ELSE
     IF ~FILEDIALOG('...TIKAI PAVAD*...TPS FAILI !!!',FILENAME1,'Topspeed|PAVAD*.tps',0)
        RETURN
     .
     SETPATH(TTAKA")
     LOOP I#=LEN(FILENAME1)-1 TO 4 BY -1
        IF UPPER(FILENAME1[I#-4:I#])='PAVAD'
           FILENAME2=FILENAME1[1:I#-5]&'NOLIK'&FILENAME1[I#+1:LEN(FILENAME1)]
           FILENAME3=FILENAME1[1:I#-5]&'AAPK'&FILENAME1[I#+1:LEN(FILENAME1)]   !NAV GLOBÂLIE
           FILENAME4=FILENAME1[1:I#-5]&'ADARBI'&FILENAME1[I#+1:LEN(FILENAME1)] !NAV GLOBÂLIE
           FOUND#=1
           BREAK
        .
     .
     IF ~FOUND#
        KLUDA(27,FILENAME1)
        DO PROCEDURERETURN
     .
     FOLDERIS=FILENAME1
     FILENAME1=FILENAME3
     CHECKOPEN(AUTOAPK1,1)
     FILENAME1=FILENAME4
     CHECKOPEN(AUTODARBI1,1)
     FILENAME1=FOLDERIS
  .
  
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
      QUICKWINDOW{PROP:TEXT}='Fails: '&filename1
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
    OF ?ButtonImportçt
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPEN(ASKSCREEN)
        IF ATLAUTS[1]='1' OR ~(ATLAUTS[18]='1')
           UNHIDE(?String:RS)
           UNHIDE(?RS)
        END
        RS=''
        D_K_TIPS=1
        DOK_SK=0
        NOM_SK=0
        FIRST#=1
        NOM#=0
        PAR#=0
        PROCESS=''
        PROCESS1=''
        PROCESS2=''
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF ?ButtonParrekRaz
              CASE EVENT()
              OF EVENT:Accepted
                 IF PARREKRAZ
                    HIDE(?IMAGERAZ)
                    PARREKRAZ=0
                 ELSE
                    UNHIDE(?IMAGERAZ)
                    PARREKRAZ=1
                 .
              .
           OF ?OkButton
              CASE EVENT()
              OF EVENT:Accepted
                 DO SyncWindow
                 HIDE(1,?CancelButton)
                 UNHIDE(?STRINGPROCESS)
                 UNHIDE(?PROCESS)
                 UNHIDE(?PROCESS1)
                 UNHIDE(?PROCESS2)
                 NOM#=0
                 PAR#=0
                 DISPLAY
                 IF COPYREQUEST=2 ! JÂSTRÂDÂ AR APMAIÒAS FAILIEM, NAV IMPORTS NO CITAS DB
                    CLEAR(NOM1:RECORD)
                    SET(NOM_K1)
                    LOOP
                       NEXT(NOM_K1)
                       IF ERROR() THEN BREAK.
                       GET(NOM_K,0)
                       NOM:RECORD=NOM1:RECORD
                       IF ~DUPLICATE(NOM:NOM_KEY)
                          ADD(NOM_K)
                          IF ERROR()
                             KLUDA(0,'Kïûda rakstot NOM_K '&NOM:NOMENKLAT)
                          ELSE
                             I#=GETNOM_A(NOM:NOMENKLAT,9,1) !UZBÛVÇ JAUNU RAKSTU NOM_A
                             IF GNET !GLOBÂLAIS TÎKLS
                                NOM:GNET_FLAG[1]=1
                                NOM:GNET_FLAG[2]=''
                             .
                             NOM#+=1
                          .
                       .
                       PROCESS1='Kopâ: '&CLIP(NOM#)&' jaunas nomenklatûras'
                       display(?process1)
                    .
        
                    CLEAR(PAR1:RECORD)
                    SET(PAR_K1)
                    LOOP
                       NEXT(PAR_K1)
                       IF ERROR() THEN BREAK.
                       GET(PAR_K,0)
                       PAR:RECORD=PAR1:RECORD
                       IF ~DUPLICATE(PAR:NR_KEY)
                          ADD(PAR_K)
                          IF ERROR()
                             KLUDA(0,'Kïûda rakstot PAR_K '&PAR:U_NR&' '&PAR:NOS_S)
                          ELSE
                             ADD(PAR_K)
                             IF GNET !GLOBÂLAIS TÎKLS
                                PAR:GNET_FLAG[1]=1
                                PAR:GNET_FLAG[2]=''
                             .
                             PAR#+=1
                          .
                       .
                       PROCESS2='Kopâ: '&CLIP(PAR#)&' jauni partneri'
                       display(?process2)
                    .
                 .
                 CLEAR(PAVA1:RECORD)
                 PA1:DATUMS=B_DAT
                 PA1:D_K='W'
                 PA1:DOK_SENR='zzzzzzzzzzzzzz' !z- MAX ASCII kods
                 SET(PA1:DAT_KEY,PA1:DAT_KEY)
                 LOOP
                    NEXT(PAVA1)
        !            STOP(PA1:U_NR)
                    IF ERROR() OR PA1:DATUMS < S_DAT THEN BREAK.
                    IF ~(X=PA1:KEKSIS) THEN CYCLE.
                    IF ~(RS=PA1:RS) THEN CYCLE.
                    IF PA1:U_NR=1
                       KLUDA(18,'')
                       IF ~KLU_DARBIBA THEN CYCLE.
                       PAV:RECORD=PA1:RECORD
                    ELSE
                       DO AUTONUMBER
                       PAV:RECORD=PA1:RECORD
                       PAV:U_NR=Auto::Save:PAV:U_NR
                    .
                    EXECUTE D_K_TIPS
                       PAV:D_K=PA1:D_K
                       PAV:D_K='D'
                       PAV:D_K='K'
                    .
                    IF COPYREQUEST=2  ! JÂSTRÂDÂ AR APMAIÒAS FAILIEM, NAV IMPORTS NO CITAS DB
                       IF PA1:D_K='K' AND PAV:D_K='D' AND|
                       INRANGE(AVOTS,1,25) AND PA1:PAR_NR=LOC_NR !PÂRVIETOÐANA UZ ÐITO NOLIKTAVU
                          PAV:PAR_NR=AVOTS
                          PAV:NOKA=GETPAR_K(AVOTS,0,1)
                       .
                    .
                    IF DUPLICATE(PAV:SENR_KEY)
                       KLUDA(0,'Veidojas dubultas atslçgas ar '&CLIP(PAV:DOK_SEnr)&' '&FORMAT(PAV:DATUMS,@D06.)&' ...nullçju')
                       PAV:DOK_SENR=''
                    .
                    CLEAR(NO1:RECORD)
                    NO1:U_NR=PA1:U_NR
                    SET(NO1:NR_KEY,NO1:NR_KEY)
                    DO WRITENOLIK
                    IF RIUPDATE:PAVAD()
                       KLUDA(24,'PAVAD')
                    ELSE
                       DOK_SK+=1
                       PROCESS='Kopâ: '&CLIP(DOK_SK)&' P/Z '&clip(NOM_sk)&' raksti'
                       display(?process)
                    .
                    IF ~(COPYREQUEST=2)  ! IMPORTS NO CITAS DB, NAV ADA
                       CLEAR(APK1:RECORD)
                       APK1:PAV_NR=PA1:U_NR
                       GET(AUTOAPK1,APK1:PAV_KEY)
                       IF ~ERROR()
                          APK:RECORD=APK1:RECORD
                          APK:PAV_NR=PAV:U_NR
                          ADD(AUTOAPK)
                          APK_SK+=1
                          PROCESS='Kopâ: '&CLIP(DOK_SK)&' P/Z '&clip(NOM_sk)&' raksti ' &clip(APK_sk)&' servisi'
                          display(?process)
                       .
                       CLEAR(APD1:RECORD)
                       APD1:PAV_NR=PA1:U_NR
                       SET(APD1:NR_KEY,APD1:NR_KEY)
                       LOOP
                          NEXT(AUTODARBI1)
                          IF ERROR() OR ~(APD1:PAV_NR=PA1:U_NR) THEN BREAK.
                          APD:RECORD=APD1:RECORD
                          APD:PAV_NR=PAV:U_NR
                          ADD(AUTODARBI)
                          APD_SK+=1
                          PROCESS='Kopâ: '&CLIP(DOK_SK)&' P/Z '&clip(NOM_sk)&' raksti '&clip(APK_sk)&' servisi '&clip(APD_sk)&' darbi'
                          display(?process)
                       .
                    .
                 .
                 HIDE(?STRINGPROCESS)
                 IF APK_SK
                   PROCESS='Kopâ: '&CLIP(DOK_SK)&' P/Z '&clip(NOM_sk)&' raksti '&clip(APK_sk)&' servisi '&clip(APD_sk)&' darbi'
                 ELSE
                   PROCESS='Kopâ: '&CLIP(DOK_SK)&' P/Z '&clip(NOM_sk)&' raksti'
                 .
                 display(?process)
                 UNHIDE(?CancelButton)
                 ?CancelButton{prop:text}='Beigt'
                 DISPLAY
              .
           OF ?CancelButton
              CASE EVENT()
              OF EVENT:Accepted
                 IF DOK_SK
                    LOCALRESPONSE=REQUESTCOMPLETED
                 ELSE
                    LOCALRESPONSE=REQUESTCANCELLED
                 .
                 break
              END
           END
        .
        CLOSE(ASKSCREEN)
        
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?ButtonX
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           EXECUTE PA1:KEKSIS+1
              PA1:keksis=1
              PA1:KEKSIS=2
              PA1:KEKSIS=3
              PA1:KEKSIS=4
              PA1:KEKSIS=0
           .
           IF RIUPDATE:PAVA1()
              KLUDA(24,FILENAME1)
           .
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
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
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  BIND(APK:RECORD)
  IF AUTODARBI::Used = 0
    CheckOpen(AUTODARBI,1)
  END
  AUTODARBI::Used += 1
  BIND(APD:RECORD)
  IF NOLI1::Used = 0
    CheckOpen(NOLI1,1)
  END
  NOLI1::Used += 1
  BIND(NO1:RECORD)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  IF PAVA1::Used = 0
    CheckOpen(PAVA1,1)
  END
  PAVA1::Used += 1
  BIND(PA1:RECORD)
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowsePava1','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('ATLAUTS',ATLAUTS)
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
    AUTOAPK::Used -= 1
    IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
    AUTODARBI::Used -= 1
    IF AUTODARBI::Used = 0 THEN CLOSE(AUTODARBI).
    NOLI1::Used -= 1
    IF NOLI1::Used = 0 THEN CLOSE(NOLI1).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAVA1::Used -= 1
    IF PAVA1::Used = 0 THEN CLOSE(PAVA1).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
  END
  IF WindowOpened
    INISaveWindow('BrowsePava1','winlats.INI')
    CLOSE(QuickWindow)
  END
  IF COPYREQUEST=2 ! JÂSTRÂDÂ AR APMAIÒAS FAILIEM
     CLOSE(NOM_K1)
     CLOSE(PAR_K1)
     CLOSE(AUTOAPK1)
     CLOSE(AUTODARBI1)
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
!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ REÂLO PAVAD
  Auto::Attempts = 0
  LOOP
    SET(PAV:NR_KEY)
    PREVIOUS(PAVAD)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
      Auto::Save:PAV:U_NR = PAV:U_NR + 1
    END
    clear(PAV:Record)
    PAV:DATUMS=TODAY()
    PAV:U_NR = Auto::Save:PAV:U_NR
    ADD(PAVAD)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          DO PROCEDURERETURN
        END
      END
      CYCLE
    END
    BREAK
  END

!-----------------------------------------------------------------------------------------------------
WRITENOLIK ROUTINE   !LASOT UZ REÂLO NOLIK

   PAV_SUMMA=0
   LOOP
      NEXT(NOLI1)
      IF ERROR() OR ~(NO1:U_NR=PA1:U_NR) THEN BREAK.
      NOL:RECORD=NO1:RECORD
      NOL:U_NR=PAV:U_NR
      NOL:D_K=PAV:D_K
      NOL:PAR_NR=PAV:PAR_NR
      IF INSTRING(NOL:D_K,'KP') AND INRANGE(NOL:PAR_NR,26,50) AND ParrekRaz  !RAÞOÐANA UN PIEPRASÎTS PÂRRÇÍINÂT
!         SAV_RECORD=NOL:RECORD
!         NOL_SUMMAV=GETBIL_FIFO(NOL:NOMENKLAT,NOL:DATUMS,NOL:DAUDZUMS)
!         NOL:RECORD=SAV_RECORD
         NOL:SUMMAV=GETNOM_K(NOL:NOMENKLAT,0,7,6) !PIC
         NOL:SUMMA=NOL:SUMMAV
         NOL:VAL='Ls'
         NOL:ARBYTE=0
         NOL:PVN_PROC=0
         NOL:ATLAIDE_PR=0
         PAV_SUMMA+=NOL:SUMMAV !MAINÂS PAV:SUMMA
      END
      ADD(NOLIK)
      IF ERROR()
         STOP('ADD NOLIK:'&ERROR())
      ELSE
         AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
         KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
         NOM_SK+=1
         PROCESS='Kopâ: '&CLIP(DOK_SK)&' P/Z '&clip(NOM_sk)&' nomenklatûras'
         display(?process)
      .
   .
   IF PAV_SUMMA THEN PAV:SUMMA=PAV_SUMMA.

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
      StandardWarning(Warn:RecordFetchError,'PAVA1')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = PA1:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAVA1')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = PA1:DATUMS
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
  PA1:KEKSIS = BRW1::PA1:KEKSIS
  PA1:RS = BRW1::PA1:RS
  PA1:NODALA = BRW1::PA1:NODALA
  PA1:DATUMS = BRW1::PA1:DATUMS
  PA1:D_K = BRW1::PA1:D_K
  PA1:DOK_SENR = BRW1::PA1:DOK_SENR
  PA1:NOKA = BRW1::PA1:NOKA
  PA1:SUMMA = BRW1::PA1:SUMMA
  PA1:val = BRW1::PA1:val
  PA1:U_NR = BRW1::PA1:U_NR
  ATLAUTS = BRW1::ATLAUTS
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
  BRW1::PA1:KEKSIS = PA1:KEKSIS
  BRW1::PA1:RS = PA1:RS
  BRW1::PA1:NODALA = PA1:NODALA
  BRW1::PA1:DATUMS = PA1:DATUMS
  BRW1::PA1:D_K = PA1:D_K
  BRW1::PA1:DOK_SENR = PA1:DOK_SENR
  BRW1::PA1:NOKA = PA1:NOKA
  BRW1::PA1:SUMMA = PA1:SUMMA
  BRW1::PA1:val = PA1:val
  BRW1::PA1:U_NR = PA1:U_NR
  BRW1::ATLAUTS = ATLAUTS
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
    ELSE
    END
    EXECUTE(POPUP(BRW1::PopupText))
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
        LOOP BRW1::CurrentScroll = 100 TO 1 BY -1
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => PA1:DATUMS
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
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
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
      PA1:DATUMS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'PAVA1')
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
      BRW1::HighlightedPosition = POSITION(PA1:DAT_KEY)
      RESET(PA1:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PA1:DAT_KEY,PA1:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~(PA1:RS=''1''  AND  ATLAUTS[18]=''1''))'
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
  ELSE
    CLEAR(PA1:Record)
    BRW1::CurrentChoice = 0
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
    SET(PA1:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~(PA1:RS=''1''  AND  ATLAUTS[18]=''1''))'
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
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
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

AI_KA_READ           PROCEDURE                    ! Declare Procedure
!************** KONFIG FAILS CHD3010,4010,5010,TEC,CHD3510,5510 *****************************
KONFIG              FILE,PRE(KFG),DRIVER('DBASE3'),CREATE
RECORD                 RECORD
COM                      STRING(@N_1)
BAUD                     STRING(@N_6)
BASEADDR                 STRING(4)
IRQ                      STRING(@N_2)
PHONENUM                 STRING(42)
NOCOMTIME                STRING(@N_2)
DEBUG                    STRING(@N_1)
EANSET                   STRING(@N_1)
ECRADDR                  STRING(@N_2)
                    .  .
!************** KONFIG FAILS OMRON2810,3410,3510 ************************************
!************** KONFIG FAILS OMRON 3420 *********************************************
KOMANDA           FILE,PRE(KMD),DRIVER('dBase3'),CREATE
RECORD              RECORD
KOMANDA               STRING(@N2)
FAILS                 STRING(12)
KLUDA                 STRING(@N2)
PARAM                 STRING(25)
SK1                   STRING(@N_12)
SK2                   STRING(@N_12)
SK3                   STRING(@N_12)
                  . .
!!************** KONFIG FAILS OMRON 3420 ********************************************
!KOMANDAN          FILE,PRE(KMN),DRIVER('dBase3'),CREATE,NAME('KOMANDA.DBF')
!RECORD              RECORD
!KOMANDA               STRING(@N2)
!FAILS                 STRING(12)
!KLUDA                 STRING(@N2)
!PARAM                 STRING(25)
!SK1                   STRING(@N_12)
!SK2                   STRING(@N_12)
!SK3                   STRING(@N_12)
!SK4                   STRING(@N_12)
!                  . .
!************** INI FAILS CHD 3320/5620 Elya *******************************
ININAME    STRING(40),STATIC
INIFILE      FILE,NAME(ININAME),PRE(I),DRIVER('ASCII'),CREATE
RECORD          RECORD
STR             STRING(40)
             . .

!************** DATU FAILS CHD 3320/5620 Elya *******************************

TNAME_B    STRING(40),STATIC
TFILE_B      FILE,NAME(TNAME_B),PRE(B),DRIVER('BASIC'),CREATE
RECORD          RECORD
KODS             STRING(@N_13)           !PLU
NOSAUK           STRING(20)              !NOSAUKUMAM JÂBÛT "....."  20 + " + "
QNT              DECIMAL(10,3)        !DAUDZUMS (RIGHT)
SUMMA            DECIMAL(16,2)         !SUMMA (RIGHT), PÇDÇJIE 2 BAITI IR SANTÎMI
             . .

!************** DATU FAILS TEK,OMRON2810,3410,3420,3510 *******************************
DATI              FILE,PRE(DAT),DRIVER('dBase3'),CREATE,OEM
RECORD              RECORD
KODS                  STRING(@N_13)
NOSAUK                STRING(20)
ACM                   STRING(@N2)
PVN                   STRING(@N1)
LIMENIS               STRING(@N1)
ATLAIDE               STRING(@N1)
SVARS                 STRING(@N1)
TARA                  STRING(@N3)
NODALA                STRING(@N2)
CENA                  STRING(@N_9.2)
ID                    STRING(@N1)
SKAITS                STRING(@N_9.3)
SUMMA                 STRING(@N_11.2)
DATUMS                STRING(@D5)
LAIKS                 STRING(@T4)
KASEID                STRING(3)
REZIMS                STRING(1)
TIKLADR               STRING(@N2)
REZULT                STRING(@N1)
KLUDA                 STRING(@N1)
                  . .
!************** DATU FAILS CHD-4010,5010 *******************************
!Acm               FILE,PRE(ACM),DRIVER('dBase3'),CREATE,OEM  IESPÇJAMS,KA 4010 VAJAG OEM
Acm               FILE,PRE(ACM),DRIVER('dBase3'),CREATE,OEM
RECORD              RECORD
KODS                  STRING(@N_13)
NOSAUK                STRING(20)
PVN                   STRING(@N_1)
TARA                  STRING(@N_3)
NODALA                STRING(@N_2)
CENA                  STRING(@N_9.2)
SKAITS                STRING(@N_9.3)
SUMMA                 STRING(@N_11.2)
DATUMS                STRING(@D12)
LAIKS                 STRING(8)
REZIMS                STRING(1)
TIKLADR               STRING(@N_2)
                  . .
!************** DATU FAILS POSMAN ********************************************************
POSMAN              FILE,DRIVER('DBASE3'),NAME(FileName1),PRE(POS)
RECORD                RECORD
STATIONNR               STRING(4)
POSNR                   STRING(1)
DATE                    DATE
TIME                    STRING(8)
RECEIPTNR               REAL,NAME('RECEIPTNR=N(20.4)')
ROWNR                   REAL,NAME('ROWNR=N(20.4)')
PRODGROUP               STRING(4)
EANCODE                 STRING(14)
PRODNR                  STRING(4)
PRODNAME                STRING(14)
UNITPRICE               REAL,NAME('UNITPRICE=N(20.4)')
ROUNDING                REAL,NAME('ROUNDING=N(20.4)')
PAYMETHOD               STRING(1)
SHIFTNR                 REAL,NAME('SHIFTNR=N(20.4)')
RECEIPTROW              STRING(40)
AMOUNT                  REAL,NAME('AMOUNT=N(20.4)')
TOTAL                   REAL,NAME('TOTAL=N(20.4)')
NEGTOTAL                REAL,NAME('NEGTOTAL=N(20.4)')
BRUTTO                  REAL,NAME('BRUTTO=N(20.4)')
NETTO                   REAL,NAME('NETTO=N(20.4)')
VAT                     REAL,NAME('VAT=N(20.4)')
VATPERCENT              REAL,NAME('VATPERCENT=N(20.4)')
TAXCODE                 REAL,NAME('TAXCODE=N(20.4)')
DISCOUNT                REAL,NAME('DISCOUNT=N(20.4)')
CANCELED                STRING(1)
SELLERNR                REAL,NAME('SELLERNR=N(20.4)')
ZREPCTR                 REAL,NAME('ZREPCTR=N(20.4)')
                    . .
!************** DATU FAILI BLUEBRIDGE *******************************
PLUNAME               STRING(50),STATIC
!PROTNAME              STRING(50),STATIC
LOCKNAME              STRING(50)
PCUSEDNAME            STRING(50)
BLUESOURCE            BYTE

PlU               FILE,PRE(PLU),DRIVER('dBase3'),NAME(PLUNAME),CREATE,OEM
RECORD              RECORD
CODE                  STRING(14)
ART                   STRING(6)
DESCR                 STRING(35)
PRICE                 STRING(15)
PRICE1                STRING(15)
UNIT                  STRING(2)
DEC                   STRING(1)
TAX                   STRING(1)
TBLOCK                STRING(2)
DISC                  STRING(2)
DISC_A                STRING(2)
DEPT                  STRING(2)
QTY                   STRING(15)
AMT                   STRING(15)
STATUS                STRING(1)
STATUS1               STRING(1)
STATUS2               STRING(1)
BOTTLE                STRING(8)
ACTIVE                STRING(1)
DEL                   STRING(1)
LOAD                  STRING(1)
CRC                   STRING(8)
RC                    STRING(1)
                  . .

!************** DATU FAILS CASIO FE300 *******************************

ASCIINAME    STRING(40),STATIC
ASCIIFILE      FILE,NAME(ASCIINAME),PRE(ASC),DRIVER('ASCII'),CREATE
RECORD          RECORD
KODS             STRING(13)              !PLU
KOMATS1          STRING(1)               !KOMATS
SUMMA            STRING(12)              !SUMMA (RIGHT), PÇDÇJIE 2 BAITI IR SANTÎMI
KOMATS2          STRING(1)               !KOMATS
DAUDZUMS         STRING(@N_8.3)          !DAUDZUMS
KOMATS3          STRING(1)               !KOMATS
ATLIKUMS         STRING(@N-_9.3)         !ATLIKUMS
             . .

!************** DATU FAILS OPTIMA CR500 *******************************

OPTIMA    FILE,PRE(OPT),DRIVER('dBase3'),CREATE,NAME(FILENAME1),OEM
RECORD      RECORD
F1           STRING(@N_5)
F2           STRING(@N_13)  !EAN
F3           STRING(12)     !NOSAUKUMS
F4           STRING(@N_3)   !17.08.2010 DAUDZUMS ?
F5           STRING(@N_12)  !27.02.2009 17.08.2010 CENA SANTÎMOS ?
F6           STRING(@N_12)  !27.02.2009 SKAITS
F7           STRING(@N_12)  !27.02.2009 SUMMA
          . .

!************** DATU FAILS UNIWELL *******************************

UNIWELL   FILE,NAME(FILENAME1),PRE(UNI),DRIVER('ASCII'),CREATE
            RECORD
DRAZA        STRING(5)                  !DRAZA 5 NULLES
KODS_ACM     STRING(13)                 !ACM KODS 13 KONTROLES CIPARS JAPÂRBAUDA IEVADOT NO KLAVIERES PÇC ALGORITMA....
TAB1         STRING(6)
SUMMA        STRING(11)                 !2 CIP BEIGÂS PREÈU SUMMA
TAB2         STRING(5)
DAUDZUMS     STRING(10)                 !3 CIP AIZ KOM PÂRD PREÈU SKAITS
          . .


!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------
Auto::Attempts        LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)

N_TABLE    QUEUE,PRE(N)
MAK_NR       ULONG
KODS         DECIMAL(13)
PAR_NR       ULONG
OBJ_NR       ULONG
DAUDZUMS     DECIMAL(10,3)
ATLAIDE_PR   DECIMAL(10,3)
SUMMA        DECIMAL(11,2)
           .

MAK_NR                ULONG
OBJ_NR                ULONG
DAUDZUMS              DECIMAL(10,3)
FPN_SUMMA             LIKE(FPN:SUMMA)
soundfile             CSTRING(80)
PAV_PAMAT             STRING(25)
KODS                  DECIMAL(13)
NOSAUK                STRING(20)
PVN                   DECIMAL(1)
SUMMA_K               DECIMAL(11,2)
ATLAIDE_PR            DECIMAL(3,1)
SKAITS                DECIMAL(11,3)
IDE                   STRING(1)
RAKSTI                USHORT
DN                    STRING(1)
NODALA                STRING(2)
STATUSS1              STRING(60)
LOCALRESPONSE         LONG
IGNORE                BYTE
XZ                    STRING(1)
JAU_BRIDINATS         BYTE
Neparlasit            BYTE
NOM_OK                BYTE
POS_NR                STRING(2)
SKIPATLIKUMI          BYTE
DATUMS                LONG
FILENAME_D            LIKE(FILENAME1)
DIENA                 STRING(3)
FPASTE                STRING(12)
vers                  byte,dim(4)
version               long,over(vers)
WINDOWSVERS           string(20)
PAROLE                string(10)
IPAdrese              string(20)
COM_                  DECIMAL(2)
TCPPorts              DECIMAL(4)
ChangeINI             DECIMAL(1) !Elya 1 - vajag manit INI, 2 - jauns INI

Kon_screen WINDOW('CHD 3320/5620 Konfigurâcija '),AT(,,230,111),CENTER,GRAY
       PROMPT('&COM'),AT(27,26),USE(?Prompt:COM)
       ENTRY(@n2),AT(67,24,16,12),USE(COM_)
       STRING(@s20),AT(131,3,89,10),USE(windowsvers),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
       BUTTON('&Nepârlasît Kases aparâtu'),AT(28,38,99,14),USE(?ButtonNeparlasit_0)
       IMAGE('CHECK3.ICO'),AT(131,36,13,16),USE(?ImageNeparlasit_0),HIDE
       BUTTON('&Ignorçt nepazîstamus kodus'),AT(28,54,100,14),USE(?ButtonIgnore_0)
       IMAGE('CHECK3.ICO'),AT(131,52,13,16),USE(?ImageIgnore_0),HIDE
       BUTTON('Atskaites &Tips'),AT(28,70,100,14),USE(?ButtonXZ_0)
       STRING('X'),AT(131,69,13,15),USE(?xz_0),FONT(,22,,FONT:bold)
       BUTTON('&OK'),AT(133,91,35,14),USE(?OkButton_0),DEFAULT
       BUTTON('Atlikt'),AT(170,91,36,14),USE(?CANCELBUTTON_0)
     END

Kon1_screen WINDOW('CHD 3320/5620 Konfigurâcija '),AT(,,230,142),CENTER,GRAY
       STRING(@s20),AT(131,3,89,10),USE(windowsvers),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
       ENTRY(@s10),AT(67,57,60,10),USE(Parole),LEFT
       PROMPT('&Parole'),AT(29,57,36,10),USE(?Prompt:Parole)
       PROMPT('&IP Adrese'),AT(29,29,36,10),USE(?Prompt:IPAdrese)
       ENTRY(@n4),AT(67,43,46,10),USE(TCPPorts)
       PROMPT('&TCP ports'),AT(29,43,36,10),USE(?Prompt:TCPports)
       ENTRY(@s20),AT(67,29,60,10),USE(IPAdrese),LEFT
       BUTTON('&Nepârlasît Kases aparâtu'),AT(28,69,99,14),USE(?ButtonNeparlasit_1)
       IMAGE('CHECK3.ICO'),AT(131,67,13,16),USE(?ImageNeparlasit_1),HIDE
       BUTTON('&Ignorçt nepazîstamus kodus'),AT(28,85,100,14),USE(?ButtonIgnore_1)
       IMAGE('CHECK3.ICO'),AT(131,83,13,16),USE(?ImageIgnore_1),HIDE
       BUTTON('Atskaites &Tips'),AT(28,101,100,14),USE(?ButtonXZ_1)
       STRING('X'),AT(131,100,13,15),USE(?xz_1),FONT(,22,,FONT:bold)
       BUTTON('&OK'),AT(133,122,35,14),USE(?OkButton_1),DEFAULT
       BUTTON('Atlikt'),AT(170,122,36,14),USE(?CANCELBUTTON_1)
     END


Konfig_screen WINDOW('CHD4010,5010,TEC MA-1650,CHD3510,5510 Konfigurâcija '),AT(,,230,210),CENTER,GRAY
       PROMPT('&COM'),AT(27,10),USE(?Prompt:KFG:COM)
       ENTRY(@n1),AT(67,8),USE(KFG:COM)
       STRING(@s20),AT(131,11),USE(WINDOWSVERS),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
       PROMPT('&Baud'),AT(27,24),USE(?Prompt:Kfg:baud)
       ENTRY(@N_6),AT(67,22),USE(KFG:BAUD)
       PROMPT('BaseA&DDR'),AT(27,38),USE(?Prompt:Kfg:BASEADDR)
       ENTRY(@s4),AT(67,36),USE(Kfg:BASEADDR)
       ENTRY(@n_2),AT(67,50),USE(KFG:IRQ)
       PROMPT('IR&Q'),AT(27,53),USE(?Prompt:KFG:IRQ)
       ENTRY(@S42),AT(67,64),USE(KFG:PhoneNum)
       PROMPT('&PhoneNum'),AT(27,67),USE(?Prompt:KFG:PhoneNum)
       ENTRY(@n2),AT(67,78),USE(KFG:NocomTime)
       PROMPT('Nocom&Time'),AT(27,81),USE(?Prompt:KFG:NocomTime)
       ENTRY(@n1),AT(67,92),USE(Kfg:Debug)
       PROMPT('Debu&g'),AT(27,95),USE(?Prompt:Kfg:Debug)
       ENTRY(@n1),AT(67,106),USE(Kfg:EanSet)
       PROMPT('&KA Nr'),AT(27,109),USE(?Prompt:Kfg:EanSet)
       PROMPT('&EcrAddr'),AT(27,122),USE(?Prompt:Kfg:EcrAddr)
       ENTRY(@n_2),AT(67,120),USE(Kfg:EcrAddr)
       BUTTON('&Nepârlasît Kases aparâtu'),AT(28,134,99,14),USE(?ButtonNeparlasit)
       IMAGE('CHECK3.ICO'),AT(131,132,13,16),USE(?ImageNeparlasit),HIDE
       BUTTON('&Ignorçt nepazîstamus kodus'),AT(28,150,100,14),USE(?ButtonIgnore)
       IMAGE('CHECK3.ICO'),AT(131,148,13,16),USE(?ImageIgnore),HIDE
       BUTTON('Atskaites &Tips'),AT(28,166,100,14),USE(?ButtonXZ)
       STRING('X'),AT(131,165,13,15),USE(?xz),FONT(,22,,FONT:bold)
       BUTTON('&OK'),AT(133,187,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(170,187,36,14),USE(?CancelButton)
     END

Komanda_Screen WINDOW('OMRON komandu fails'),AT(,,236,148),CENTER,GRAY
       STRING('Komanda'),AT(28,18),USE(?String2)
       STRING(@s2),AT(65,18),USE(KMD:KOMANDA)
       STRING('Fails'),AT(28,28),USE(?String4)
       STRING(@s20),AT(66,28),USE(kmd:fails),LEFT
       PROMPT('&Parametri'),AT(28,52),USE(?Prompt:kmd:param)
       ENTRY(@s25),AT(66,51),USE(kmd:param)
       STRING('C1 Pârraide cuur COM1 portu'),AT(35,65),USE(?String5)
       STRING('C2 Pârraide cuur COM2 portu'),AT(35,76),USE(?String6)
       STRING('B1200(B2400,B9600) Datu pârraides âtrums'),AT(35,87),USE(?String7)
       STRING('D(S) Izvadît (Neizvadît) komunikâciju paziòojumus uz ekrâna '),AT(35,98),USE(?String8)
       ENTRY(@n2),AT(66,37),USE(nodala)
       PROMPT('&Nodaïa'),AT(28,39),USE(?Prompt:nodala)
       BUTTON('&OK'),AT(143,120,35,14),USE(?OkButton1),DEFAULT
       BUTTON('Atlikt'),AT(182,120,36,14),USE(?CancelButton1)
     END

!KomandaN_Screen WINDOW('OMRON 3420 komandu fails'),AT(,,236,148),CENTER,GRAY
!       STRING('Komanda'),AT(28,18),USE(?String2N)
!       STRING(@s2),AT(65,18),USE(KMN:KOMANDA)
!       STRING('Fails'),AT(28,28),USE(?String4N)
!       STRING(@s20),AT(66,28),USE(kmN:fails),LEFT
!       PROMPT('&Parametri'),AT(28,52),USE(?Prompt:kmN:param)
!       ENTRY(@s25),AT(66,51),USE(kmN:param)
!       STRING('C1 Pârraide cuur COM1 portu'),AT(35,65),USE(?String5N)
!       STRING('C2 Pârraide cuur COM2 portu'),AT(35,76),USE(?String6N)
!       STRING('B1200(B2400,B9600) Datu pârraides âtrums'),AT(35,87),USE(?String7N)
!       STRING('D(S) Izvadît (Neizvadît) komunikâciju paziòojumus uz ekrâna '),AT(35,98),USE(?String8N)
!       ENTRY(@n2),AT(66,37),USE(nodala,,NODALA:2)
!       PROMPT('&Nodaïa'),AT(28,39),USE(?Prompt:nodalaN)
!       BUTTON('&OK'),AT(143,120,35,14),USE(?OkButton1N),DEFAULT
!       BUTTON('Atlikt'),AT(182,120,36,14),USE(?CancelButton1N)
!     END

ReLoadScreen WINDOW('Kases aparâta lasîðana (K P/Z veidoðana)'),AT(,,353,80),GRAY
       STRING(@s80),AT(9,17,337,10),USE(ZUR:record),CENTER
       STRING(@S60),AT(50,29,252,10),USE(STATUSS1),CENTER
       BUTTON('Pârtraukt'),AT(248,51,92,14),USE(?Cancel),HIDE
       BUTTON('Turpinât'),AT(150,51,95,14),USE(?ok),HIDE
     END
  CODE                                            ! Begin processed code
  ! 1-OMRON-3410'       X
  ! 2-OMRON-3420'       X
  ! 3-OMRON-3510'       X
  ! 4-OMRON-3510TDL'
  ! 5-VDM261'
  ! 6-KONIC-SR2000'
  ! 7-CHD-4010'         X
  ! 8-KONIC-SR2200'
  ! 9-FP-600            X
  !10-TEC-MA-1650'      X
  !11-CHD-2010'
  !12-OMRON-2810'       X
  !13-BLUEBRIDGE'       X
  !14-UNIWELL UX43'     X
  !15-OPTIMA CR500'     X
  !16-POSMAN'           X
  !17-CHD-5010'         X
  !18-CASIO FE300       X
  !19-FP-600PLUS        X
  !20-CHD-3010T FISCAL  X
  !21-CHD-5010T FISCAL  X
  !22-EPOS-3L FISCAL    X
  !23-CHD-3010T         X
  !24-OMRON-2810 FISCAL X
  !25-UNIWELL NX5400'   X
  !26-NEW VISION        X
  !27-DATECS            X
  !28-CHD-3550T FISCAL  X
  !29-CHD-5510T FISCAL  X
  !29-CHD-3550T         X
  !30-CHD-5510T         X

  version=GetVersion()
!  stop(vers[1]&' '&vers[2]&' '&vers[3]&' '&vers[4])
  EXECUTE vers[1]
     WINDOWSVERS='WINDOWS v '&vers[1]&'.'&vers[2]
     WINDOWSVERS='WINDOWS v '&vers[1]&'.'&vers[2]
     WINDOWSVERS='WINDOWS v '&vers[1]&'.'&vers[2]
     WINDOWSVERS='WINDOWS ( '&vers[1]&'.'&vers[2]
     WINDOWSVERS='WINDOWS XP'
     WINDOWSVERS='WINDOWS VISTA'
     WINDOWSVERS='WINDOWS 7'
  .

  DZNAME='DZKA'&FORMAT(JOB_NR,@N02)
  CLOSE(ZURNALS)
  CHECKOPEN(ZURNALS,1)
  CLOSE(FPPAVAD)
  CLOSE(FPNOLIK)
!  FPPAVADNAME='FPPAV'&FORMAT(LOC_NR,@N02)
!  FPNOLIKNAME='FPNOL'&FORMAT(LOC_NR,@N02)
  checkopen(NOLIK,1)
  NOLIK::USED+=1
  checkopen(NOM_K,1)
  NOM_K::USED+=1
  IGNORE     = 0
  NEPARLASIT = FALSE
  SKIPATLIKUMI=0
  XZ         ='X'

  CONVERTDBF('KOMANDA.DBF')
  CONVERTDBF('KONFIG.DBF')
  CONVERTDBF('DATI.DBF')


  CASE SYS:KASES_AP

  OF '32'        ! Elya CHD-3320/5620
     NODALA=20
     ChangeINI = 0
     ININAME = 'SDRV.ini'
     TNAME_B = 'plu_Z1.txt'
     OPEN(INIFILE)
     ERR# = ERRORCODE()
     IF ERR# AND ~ERR# = 2
       kluda(1,'INIFILE')
       DO ProcedureReturn
     ELSIF ERR# = 2  !nav faila
        CREATE(INIFILE)
        CLOSE(INIFILE)
        ChangeINI = 2
     ELSE ! INI fails ir atverts
        SET(INIFILE)
        LOOP UNTIL EOF (INIFILE)
           NEXT (INIFILE)
           IF ERRORCODE() THEN
              kluda(1,'INIFILE')
              CLOSE(INIFILE)
              DO ProcedureReturn
           .
           PosEq# = INSTRING('=', I:STR)
           L# = LEN(I:STR)
           IF INSTRING('ComNumber', I:STR)
             COM_ = CLIP(SUB(I:STR, PosEq#+1, L#-PosEq#+1))
             IF SYS:COM_NR = 2 THEN
                ChangeINI = 1
             .
           ELSIF INSTRING('IpAddress', I:STR)
             IPAdrese = CLIP(SUB(I:STR, PosEq#+1, L#-PosEq#+1))
             IF SYS:COM_NR = 1 THEN
                ChangeINI = 1
             .
           ELSIF INSTRING('TcpPort', I:STR)
             TCPPorts = CLIP(SUB(I:STR, PosEq#+1, L#-PosEq#+1))
             IF SYS:COM_NR = 1 THEN
                ChangeINI = 1
             .
           ELSIF INSTRING('Password', I:STR)
             Parole = CLIP(SUB(I:STR, PosEq#+1, L#-PosEq#+1))
             IF SYS:COM_NR = 1 THEN
                ChangeINI = 1
             .
           .
        .
        CLOSE(INIFILE)
     .
     IF SYS:COM_NR = 1 THEN
        OPEN(Kon_screen)
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF COM_
              IF ~ChangeINI = 2 THEN ChangeINI = 1.
        OF ?ButtonNeparlasit_0
           IF EVENT()=EVENT:ACCEPTED
              IF ~NEPARLASIT
                 UNHIDE(?ImageNeparlasit_0)
                 Neparlasit=TRUE
                 HIDE(?BUTTONXZ_0)
                 HIDE(?XZ_0)
                 HIDE(?BUTTONIGNORE_0)
                 HIDE(?IMAGEIGNORE_0)
              ELSE
                 HIDE(?ImageNeparlasit_0)
                 Neparlasit=FALSE
                 IGNORE=0
                 UNHIDE(?BUTTONXZ_0)
                 UNHIDE(?BUTTONIGNORE_0)
                 UNHIDE(?XZ_0)
              .
              display
           .
        OF ?ButtonIgnore_0
           IF EVENT()=EVENT:ACCEPTED
              IF ~ignore
                 UNHIDE(?ImageIgnore_0)
                 IGNORE=1
              ELSE
                 HIDE(?ImageIgnore_0)
                 IGNORE=0
              .
              DISPLAY
           .
        OF ?ButtonXZ_0
           IF EVENT()=EVENT:ACCEPTED
              IF XZ='X'
                 ?XZ_0{PROP:TEXT}='Z'
                 XZ='Z'
              ELSE
                 ?XZ_0{PROP:TEXT}='X'
                 XZ='X'
              .
              DISPLAY
           .
           OF ?OkButton_0
             IF EVENT()=EVENT:ACCEPTED
                IF ChangeINI = 1 !vajag mainit
                   REMOVE(INIFILE)
                   IF ERRORCODE() THEN
                      kluda(1,'INIFILE')
                      CLOSE(INIFILE)
                      DO ProcedureReturn
                   .
                   CREATE(INIFILE)
                   CLOSE(INIFILE)
                .
                IF ChangeINI = 2 OR ChangeINI = 1 !jauns vai mainisanai
                   OPEN(INIFILE)
                   CLEAR(I:RECORD)
                   I:STR = '[ECR_1]'
                   ADD(INIFILE)
                   I:STR = 'ComNumber = '&COM_
                   ADD(INIFILE)
                .
                CLOSE(INIFILE)

                LOCALRESPONSE=REQUESTCOMPLETED
                BREAK
             .
           OF ?CANCELBUTTON_0
             IF EVENT()=EVENT:ACCEPTED
                LOCALRESPONSE=REQUESTCANCELLED
                BREAK
             .
           .
        .
        CLOSE(Kon_screen)
        IF LOCALRESPONSE=REQUESTCANCELLED
           DO PROCEDURERETURN
        .
     ELSE
        OPEN(Kon1_screen)
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF Parole
              IF ~ChangeINI = 2 THEN ChangeINI = 1. !ja nejauns
           OF IPAdrese
              IF ~ChangeINI = 2 THEN ChangeINI = 1.
           OF TCPPorts
              IF ~ChangeINI = 2 THEN ChangeINI = 1.
        OF ?ButtonNeparlasit_1
           IF EVENT()=EVENT:ACCEPTED
              IF ~NEPARLASIT
                 UNHIDE(?ImageNeparlasit_1)
                 Neparlasit=TRUE
                 HIDE(?BUTTONXZ_1)
                 HIDE(?XZ_1)
                 HIDE(?BUTTONIGNORE_1)
                 HIDE(?IMAGEIGNORE_1)
              ELSE
                 HIDE(?ImageNeparlasit_1)
                 Neparlasit=FALSE
                 IGNORE=0
                 UNHIDE(?BUTTONXZ_1)
                 UNHIDE(?BUTTONIGNORE_1)
                 UNHIDE(?XZ_1)
              .
              display
           .
        OF ?ButtonIgnore_1
           IF EVENT()=EVENT:ACCEPTED
              IF ~ignore
                 UNHIDE(?ImageIgnore_1)
                 IGNORE=1
              ELSE
                 HIDE(?ImageIgnore_1)
                 IGNORE=0
              .
              DISPLAY
           .
        OF ?ButtonXZ_1
           IF EVENT()=EVENT:ACCEPTED
              IF XZ='X'
                 ?XZ_1{PROP:TEXT}='Z'
                 XZ='Z'
              ELSE
                 ?XZ_1{PROP:TEXT}='X'
                 XZ='X'
              .
              DISPLAY
           .
           OF ?OkButton_1
             IF EVENT()=EVENT:ACCEPTED
                IF ChangeINI = 1 !vajag mainit
                   REMOVE(INIFILE)
                   IF ERRORCODE() THEN
                      kluda(1,'INIFILE')
                      CLOSE(INIFILE)
                      DO ProcedureReturn
                   .
                   CREATE(INIFILE)
                   CLOSE(INIFILE)
                .
                IF ChangeINI = 2 OR ChangeINI = 1 !jauns vai mainisanai
                   OPEN(INIFILE)
                   CLEAR(I:RECORD)
                   I:STR = '[ECR_1]'
                   ADD(INIFILE)
                   I:STR = 'IpAddress = '&CLIP(IPAdrese)
                   ADD(INIFILE)
                   I:STR = 'TcpPort = '&TcpPorts
                   ADD(INIFILE)
                   I:STR = 'Password = '&CLIP(Parole)
                   ADD(INIFILE)
                .
                CLOSE(INIFILE)

                LOCALRESPONSE=REQUESTCOMPLETED
                BREAK
             .
           OF ?CANCELBUTTON_1
             IF EVENT()=EVENT:ACCEPTED
                LOCALRESPONSE=REQUESTCANCELLED
                BREAK
             .
           .
        .
        CLOSE(Kon1_screen)
        IF LOCALRESPONSE=REQUESTCANCELLED
           DO PROCEDURERETURN
        .
     .

  OF  '10'         ! TEC
  OROF'7'          ! CHD-4010
  OROF'17'         ! CHD-5010
  OROF '30'        ! CHD-3510T
  OROF '23'        ! CHD-3010  14/05/2014
  OROF '31'        ! CHD-5510T
     NODALA=20
     CHECKOPEN(KONFIG,1)
     IF RECORDS(KONFIG)=0
        CLEAR(KFG:RECORD)
        KFG:COM=SYS:COM_NR
        KFG:BAUD=9600
        ADD(KONFIG)
     .
     SET(KONFIG)
     NEXT(KONFIG)
     OPEN(KONFIG_SCREEN)
     DISPLAY
     SELECT(?KFG:ECRADDR)
     ACCEPT
        CASE FIELD()
        OF ?ButtonNeparlasit
           IF EVENT()=EVENT:ACCEPTED
              IF ~NEPARLASIT
                 UNHIDE(?ImageNeparlasit)
                 Neparlasit=TRUE
                 HIDE(?BUTTONXZ)
                 HIDE(?XZ)
                 HIDE(?BUTTONIGNORE)
                 HIDE(?IMAGEIGNORE)
              ELSE
                 HIDE(?ImageNeparlasit)
                 Neparlasit=FALSE
                 IGNORE=0
                 UNHIDE(?BUTTONXZ)
                 UNHIDE(?BUTTONIGNORE)
                 UNHIDE(?XZ)
              .
              display
           .
        OF ?ButtonIgnore
           IF EVENT()=EVENT:ACCEPTED
              IF ~ignore
                 UNHIDE(?ImageIgnore)
                 IGNORE=1
              ELSE
                 HIDE(?ImageIgnore)
                 IGNORE=0
              .
              DISPLAY
           .
        OF ?ButtonXZ
           IF EVENT()=EVENT:ACCEPTED
              IF XZ='X'
                 ?XZ{PROP:TEXT}='Z'
                 XZ='Z'
              ELSE
                 ?XZ{PROP:TEXT}='X'
                 XZ='X'
              .
              DISPLAY
           .
        OF ?OkButton
           IF EVENT()=EVENT:ACCEPTED
              LOCALRESPONSE=REQUESTCOMPLETED
              BREAK
           .
        OF ?CANCELBUTTON
           IF EVENT()=EVENT:ACCEPTED
              LOCALRESPONSE=REQUESTCANCELLED
              BREAK
           .
        .
     .
     CLOSE(KONFIG_SCREEN)
     IF LOCALRESPONSE=REQUESTCANCELLED
        close(KONFIG)
        DO PROCEDURERETURN
     .
     PUT(KONFIG)
     close(KONFIG)
  OF   '1'         ! OMRON-3410'
!  OROF '2'         ! OMRON-3420' CITA STRUKTÛRA ?
  OROF '2'         ! OMRON-3420' 
  OROF '3'         ! OMRON-3510'
  OROF '12'        ! OMRON-2810'
     CHECKOPEN(KOMANDA,1)
     IF RECORDS(KOMANDA)=0
        CLEAR(KMD:RECORD)
        ADD(KOMANDA)
     .
     SET(KOMANDA)
     NEXT(KOMANDA)
     KMD:KOMANDA=11
     KMD:FAILS  ='DATI.DBF'
     KMD:KLUDA  =0
     KMD:SK2    =1
     NODALA     =1
     OPEN(KOMANDA_SCREEN)
  !   SELECT(?KFG:ECRADDR)
     DISPLAY
     ACCEPT
        CASE FIELD()
        OF ?OkButton1
           IF EVENT()=EVENT:ACCEPTED
              LOCALRESPONSE=REQUESTCOMPLETED
              BREAK
           .
        OF ?CANCELBUTTON1
           IF EVENT()=EVENT:ACCEPTED
              LOCALRESPONSE=REQUESTCANCELLED
              BREAK
           .
        .
     .
     CLOSE(KOMANDA_SCREEN)
     IF LOCALRESPONSE=REQUESTCANCELLED
        close(KOMANDA)
        DO PROCEDURERETURN
     .
     PUT(KOMANDA)
     close(KOMANDA)
!  OF '2'         ! OMRON-3420'
!     CHECKOPEN(KOMANDAN,1)
!     IF RECORDS(KOMANDAN)=0
!        CLEAR(KMN:RECORD)
!        ADD(KOMANDAN)
!     .
!     SET(KOMANDAN)
!     NEXT(KOMANDAN)
!     KMN:KOMANDA=11
!     KMN:FAILS  ='DATI.DBF'
!     KMN:KLUDA  =0
!     KMN:SK2    =1
!     NODALA     =1
!     OPEN(KOMANDAN_SCREEN)
!  !   SELECT(?KFG:ECRADDR)
!     DISPLAY
!     ACCEPT
!        CASE FIELD()
!        OF ?OkButton1N
!           IF EVENT()=EVENT:ACCEPTED
!              LOCALRESPONSE=REQUESTCOMPLETED
!              BREAK
!           .
!        OF ?CANCELBUTTON1N
!           IF EVENT()=EVENT:ACCEPTED
!              LOCALRESPONSE=REQUESTCANCELLED
!              BREAK
!           .
!        .
!     .
!     CLOSE(KOMANDAN_SCREEN)
!     IF LOCALRESPONSE=REQUESTCANCELLED
!        close(KOMANDAN)
!        DO PROCEDURERETURN
!     .
!     PUT(KOMANDAN)
!     close(KOMANDAN)
  OF '9'           ! FP-600
  OROF '19'        ! FP-600PLUS
  OROF '20'        ! CHD-3010T  FISCAL
  OROF '21'        ! CHD-5010T  FISCAL
  OROF '22'        ! EPOS-3L
  OROF '24'        ! OMRON-2810 FISCAL
  OROF '26'        ! NEW VISION
  OROF '27'        ! DATECS
  OROF '28'        ! CHD-3550T FISCAL
  OROF '29'        ! CHD-5510T FISCAL
     TTAKA"=PATH()
     NEPARLASIT=TRUE
     IF FILEDIALOG('...TIKAI FPPYYMMDDNN.TPS FAILI !!!',FPPAVADNAME,'Topspeed|FPP*.tps',0)
     !ÐITAIS ATGRIEÞ AR PILNU TAKU
        LOOP I#=LEN(FPPAVADNAME) TO 9 BY -1
           IF FPPAVADNAME[I#]='.'
              POS_NR=FPPAVADNAME[I#-2:I#-1]
              FPASTE=FPPAVADNAME[I#-8:I#+3]
              FPNOLIKNAME=CLIP(PATH())&'\FPN'&FPASTE
              BREAK
           .
        .
        IF ~FPNOLIKNAME
           LOCALRESPONSE=REQUESTCANCELLED
        .
     ELSE
        LOCALRESPONSE=REQUESTCANCELLED
     .
     SETPATH(TTAKA")
     IF LOCALRESPONSE=REQUESTCANCELLED
        KLUDA(0,'Kïûda atgrieþoties uz '&TTAKA")
        DO PROCEDURERETURN
     .
     FILENAME_D=CLIP(TTAKA")&'\FPDATA\FPP'&FPASTE   !OBLIGÂTI PÂRNESAM UZ \FPDATA ARHÎVU
     IF ~CopyFileA(FPPAVADNAME,FILENAME_D,0)
        KLUDA(3,FPPAVADNAME&' uz '&FILENAME_D)
        DO PROCEDURERETURN
     .
     FILENAME_D=CLIP(TTAKA")&'\FPDATA\FPN'&FPASTE
     IF ~CopyFileA(FPNOLIKNAME,FILENAME_D,0)
        KLUDA(3,FPNOLIKNAME&' uz '&FILENAME_D)
        DO PROCEDURERETURN
     .
  OF '13'           ! BLUEBRIDGE
     TTAKA"=PATH()
     FPNOLIKNAME=''
     NEPARLASIT=TRUE
     SETPATH('\\KASE1\MBOX')
     IF FILEDIALOG('...TIKAI ~PLxxxx.dbf FAILI !!!',PLUNAME,'DBF3|~pl*.dbf',0)
        CONVERTDBF(PLUNAME)
        LOCKNAME=PATH()&'\LOCK.ECR'
!        STOP(LOCKNAME)
!        POS_NR=PLUNAME[7]
        LP#=LEN(CLIP(PLUNAME))
        LOCALRESPONSE=REQUESTCOMPLETED
     ELSE
        LOCALRESPONSE=REQUESTCANCELLED
     .
     SETPATH(TTAKA")
     IF LOCALRESPONSE=REQUESTCANCELLED
        DO PROCEDURERETURN
     .
     IF DOS_CONT(LOCKNAME,2)
        KLUDA(0,'Kase aizòemta: Atrasts fails '&lockname)
        DO ProcedureReturn
     ELSE
!        PCUSEDNAME='\\KASE'&PLUNAME[7]&'\MBOX\LOCK.PC'
     .
  OF  '14'         ! UNIWELL
  OROF  '15'       ! OPTIMA
  OROF  '25'       ! UNIWELL NX5400
     OPEN(KONFIG_SCREEN)
     KONFIG_SCREEN{PROP:TEXT}='UNIWELL/OPTIMA CR500'
     HIDE(?Prompt:KFG:COM,?Kfg:EcrAddr)
     DISPLAY
     ACCEPT
        CASE FIELD()
        OF ?ButtonNeparlasit
           IF EVENT()=EVENT:ACCEPTED
              IF NEPARLASIT=FALSE
                 UNHIDE(?ImageNeparlasit)
                 Neparlasit=TRUE !KA NAV JÂPÂRLASA
                 HIDE(?BUTTONXZ)
                 HIDE(?XZ)
                 HIDE(?BUTTONIGNORE)
                 HIDE(?IMAGEIGNORE)
              ELSE
                 HIDE(?ImageNeparlasit)
                 Neparlasit=FALSE
                 IGNORE=0
                 UNHIDE(?BUTTONXZ)
                 UNHIDE(?BUTTONIGNORE)
                 UNHIDE(?XZ)
              .
              display
           .
        OF ?ButtonIgnore
           IF EVENT()=EVENT:ACCEPTED
              IF ~ignore
                 UNHIDE(?ImageIgnore)
                 IGNORE=1
              ELSE
                 HIDE(?ImageIgnore)
                 IGNORE=0
              .
              DISPLAY
           .
        OF ?ButtonXZ
           IF EVENT()=EVENT:ACCEPTED
              IF XZ='X'
                 ?XZ{PROP:TEXT}='Z'
                 XZ='Z'
              ELSE
                 ?XZ{PROP:TEXT}='X'
                 XZ='X'
              .
              DISPLAY
           .
        OF ?OkButton
           IF EVENT()=EVENT:ACCEPTED
              LOCALRESPONSE=REQUESTCOMPLETED
              BREAK
           .
        OF ?CANCELBUTTON
           IF EVENT()=EVENT:ACCEPTED
              LOCALRESPONSE=REQUESTCANCELLED
              BREAK
           .
        .
     .
     IF LOCALRESPONSE=REQUESTCANCELLED
        DO PROCEDURERETURN
     .
     IF SYS:KASES_AP = '14' OR SYS:KASES_AP = '25' ! UNIWELL
        FILENAME1='NOKASE.TXT'
     ELSIF SYS:KASES_AP = '15'                     ! OPTIMA
        FILENAME1='PAY.DBF'
     .
  OF '16'           ! POSMAN
     TTAKA"=PATH()
     FPNOLIKNAME=''
     NEPARLASIT=TRUE
     SETPATH('\WINLATS\CASE')
     IF FILEDIALOG('...TIKAI dDDMMp.dbf FAILI !!!',FILENAME1,'DBF3|d*.dbf',0)
     ELSE
        LOCALRESPONSE=REQUESTCANCELLED
     .
     SETPATH(TTAKA")
     IF LOCALRESPONSE=REQUESTCANCELLED
        DO PROCEDURERETURN
     .
  OF '18'           ! CASIO FE300
     NEPARLASIT=FALSE
     ASCIINAME='\FE300P\PRO\ATSKX.TXT'

  ELSE
     STOP('KOMUNIKÂCIJA NAV IZSTRÂDÂTA')
     DO PROCEDURERETURN
  .

  EXECUTE SYS:KASES_AP
     PAV_PAMAT='OMRON-3410 '&format(CLOCK(),@t1)&' '&XZ                 ! 1-OMRON-3410'
     PAV_PAMAT='OMRON-3420 '&format(CLOCK(),@t1)&' '&XZ                 ! 2-OMRON-3420'
     PAV_PAMAT='OMRON-3510 '&format(CLOCK(),@t1)&' '&XZ                 ! 3-OMRON-3510'
     PAV_PAMAT='OMRON-3510TDL '&format(CLOCK(),@t1)&' '&XZ              ! 4-OMRON-3510TDL'
     PAV_PAMAT='VDM261 '&format(CLOCK(),@t1)&' '&XZ                     ! 5-VDM261'
     PAV_PAMAT='KONIC-SR2000 '&format(CLOCK(),@t1)&' '&XZ               ! 6-KONIC-SR2000'
     PAV_PAMAT='CHD-4010 '&format(CLOCK(),@t1)&' '&XZ                   ! 7-CHD-4010'
     PAV_PAMAT='KONIC-SR2200 '&format(CLOCK(),@t1)&' '&XZ               ! 8-KONIC-SR2200'
     PAV_PAMAT='FP-600 '&format(CLOCK(),@t1)                            ! 9-FP-600
     PAV_PAMAT='TEC-MA-1650 '&format(CLOCK(),@t1)&' '&XZ                !10-TEC-MA-1650'
     PAV_PAMAT='CHD2010 '&format(CLOCK(),@t1)&' '&XZ                    !11-CHD-2010'
     PAV_PAMAT='OMRON-2810 '&format(CLOCK(),@t1)&' '&XZ                 !12-OMRON-2810'
     PAV_PAMAT='BB: '&format(CLOCK(),@t1)&' '&PLUNAME[LP#-11:LP#]       !13-BLUEBRIDGE'
     PAV_PAMAT='UNIWELL UX43 '&format(CLOCK(),@t1)&' '&XZ               !14-UNIWELL UX43'
     PAV_PAMAT='OPTIMA '&format(CLOCK(),@t1)&' '&XZ                     !15-OPTIMA'
     PAV_PAMAT='POSMAN '&format(CLOCK(),@t1)&' '&XZ                     !16-POSMAN'
     PAV_PAMAT='CHD-5010 '&format(CLOCK(),@t1)&' '&XZ                   !17-CHD-5010'
     PAV_PAMAT='CASIO FE300'                                            !18-CASIO FE300
     PAV_PAMAT='FP-600 PLUS '&format(CLOCK(),@t1)                       !19-FP-600PLUS
     PAV_PAMAT='CHD-3010TF '&format(CLOCK(),@t1)                        !20-CHD-3010T FISCAL
     PAV_PAMAT='CHD-5010TF '&format(CLOCK(),@t1)                        !21-CHD-5010T FISCAL
     PAV_PAMAT='EPOS-3L '&format(CLOCK(),@t1)                           !22-EPOS-3L
     PAV_PAMAT='CHD-3010T '&format(CLOCK(),@t1)&' '&XZ                  !23-CHD-3010T
     PAV_PAMAT='OMRON-2810 F '&format(CLOCK(),@t1)                      !24-OMRON-2810 FISCAL
     PAV_PAMAT='UNIWELL NX5400 '&format(CLOCK(),@t1)&' '&XZ             !25-UNIWELL NX5400
     PAV_PAMAT='NEW VISION '&format(CLOCK(),@t1)                        !26-NEW VISION 
     PAV_PAMAT='DATECS '&format(CLOCK(),@t1)                            !27-DATECS
     PAV_PAMAT='CHD-3550TF '&format(CLOCK(),@t1)                        !28-CHD-3010T FISCAL
     PAV_PAMAT='CHD-5510TF '&format(CLOCK(),@t1)                        !29-CHD-5010T FISCAL
     PAV_PAMAT='CHD-3550T '&format(CLOCK(),@t1)                         !30-CHD-3010T
     PAV_PAMAT='CHD-5510T '&format(CLOCK(),@t1)                         !31-CHD-5010T
     PAV_PAMAT='CHD-3320/5620 '&format(CLOCK(),@t1)                     !32-CHD-3320
  .

  OPEN(ReLoadSCREEN)
 
  IF Neparlasit=FALSE      !Kases aparâts IR jâpârlasa
     CASE SYS:KASES_AP
     OF   '10'         ! TEK
     OROF '1'          ! OMRON-3410'
     OROF '2'          ! OMRON-3420'
     OROF '3'          ! OMRON-3510'
     OROF '12'         ! OMRON-2810'
        CHECKOPEN(DATI,1)
        close(DATI)
        OPEN(DATI,18)
        IF ERROR()
          kluda(1,'DATI')
          DO ProcedureReturn
        .
        EMPTY(DATI)
        close(DATI)
     OF '7'           ! CHD-4010
     OROF '17'        ! CHD-5010
     OROF '23'        ! CHD-3010T
 
        CHECKOPEN(ACM,1)
        close(ACM)
 
        OPEN(ACM,18)
 
        IF ERROR()
          kluda(1,'ACM')
 
          DO ProcedureReturn
        .
        EMPTY(ACM)
        close(ACM)
     OF '14'          ! UNIWELL
     OROF '25'        ! UNIWELL NX5400
        CHECKOPEN(UNIWELL,1)
        close(UNIWELL)
        OPEN(UNIWELL,18)
        IF ERROR()
          kluda(1,'NOKASE.TXT')
          DO ProcedureReturn
        .
        EMPTY(UNIWELL)
        CLOSE(UNIWELL)
     OF '15'          ! OPTIMA CR500
        CHECKOPEN(OPTIMA,1)
        close(OPTIMA)
        OPEN(OPTIMA,18)
        IF ERROR()
          kluda(1,'PAY.DBF')
          DO ProcedureReturn
        .
        EMPTY(OPTIMA)
        CLOSE(OPTIMA)
     OF '18'          ! CASIO FE300
        CHECKOPEN(ASCIIFILE,1)
        close(ASCIIFILE)
        OPEN(ASCIIFILE,18)
        IF ERROR()
          kluda(1,'\FE300P\PRO\ATSKX.TXT')
          DO ProcedureReturn
        .
        EMPTY(ASCIIFILE)
        close(ASCIIFILE)
     OF '32'          ! Elya CHD-3320/5620
        CHECKOPEN(TFILE_B,1)
        close(TFILE_B)
        OPEN(TFILE_B,18)
        IF ERROR()
          kluda(1,'plu_Z1.txt')
          DO ProcedureReturn
        .
        EMPTY(TFILE_B)
        close(TFILE_B)
     .
     ZUR:RECORD='--------------SEANSS : '& format(TODAY(),@d5) &' '& format(CLOCK(),@t1) &' ----------------'
     ADD(ZURNALS)
     DISPLAY
     CASE SYS:KASES_AP
     OF '1'          ! OMRON-3410'
        run('\WINLATS\BIN\AI3410.exe KOMANDA.DBF')
     OF '2'          ! OMRON-3420'
!        run('\WINLATS\BIN\AI3420.exe KOMANDA.DBF')
        run('AI3420.BAT')
     OF '3'          ! OMRON-3510'
        run('\WINLATS\BIN\AI35.exe KOMANDA.DBF')
     OF '12'         ! OMRON-2810'
        run('\WINLATS\BIN\AI2810.exe KOMANDA.DBF')
     OF '10'         ! TEC
        CASE XZ
        OF 'X'
           run('\WINLATS\BIN\TEC1650.exe 11 DATI.DBF')
        ELSE
           run('\WINLATS\BIN\TEC1650.exe Z11 DATI.DBF')
        .
     OF '7'          ! CHD-4010
        CASE XZ
        OF 'X'
           run('\WINLATS\BIN\4010COMM.exe 11 ACM.DBF')
        ELSE
           run('\WINLATS\BIN\4010COMM.exe Z11 ACM.DBF')
        .
     OF '14'         ! UNIWELL
       CASE XZ
       OF 'X'
!          run('\WINLATS\BIN\uniwell.exe /rptxPLU nokase.txt')
          run('X43.BAT '&CLIP(LOC_NR))
       ELSE
!          run('\WINLATS\BIN\uniwell.exe /rptzPLU nokase.txt')
          run('Z43.BAT '&CLIP(LOC_NR))
       .
     OF '15'         ! OPTIMA CR500
        CASE XZ
        OF 'X'
!           run(COMMAND('COMSPEC',0) & ' /C ' & '\WINLATS\BIN\ATSK_X.BAT',1)
           run('\WINLATS\BIN\ATSK_X.BAT',1)
        ELSE
!           run(COMMAND('COMSPEC',0) & ' /C ' & '\WINLATS\BIN\ATSK_Z.BAT',1)
           run('\WINLATS\BIN\ATSK_Z.BAT',1)
        .
     OF '17'         ! CHD-5010
     OROF '23'       ! CHD-3010T
        CASE XZ
        OF 'X'
           IF vers[1]<7
              run('\WINLATS\BIN\CHD_DRV.exe 11 ACM.DBF')
           ELSE
              run('CHD_DRV.exe 11 ACM.DBF')
           .
        ELSE
           IF vers[1]<7
              run('\WINLATS\BIN\CHD_DRV.exe /Z 11 ACM.DBF')
           ELSE
              run('CHD_DRV.exe /Z 11 ACM.DBF')
           .
        .
        IF RUNCODE()
           IF vers[1]<7
              KLUDA(120,'\WINLATS\BIN\CHD_DRV.exe')
           ELSE
              KLUDA(120,CLIP(LONGPATH())&'\CHD_DRV.exe')
           .
        .
     OF '18'         ! CASIO FE300
        run('\FE300P\PRO\FE300.EXE')
     OF '25'         ! UNIWELL
       CASE XZ
       OF 'X'
          run('X40.BAT '&CLIP(LOC_NR))
       ELSE
          run('Z40.BAT '&CLIP(LOC_NR))
       .
     OF '32'         ! Elya CHD-3320/5620
       CASE XZ
       OF 'X'
          !run('SDRV.exe read 105 plu_Z1.txt')
          run('chd5620x.bat')
       ELSE
          !run('SDRV.exe read 106 plu_Z1.txt')
          !run('SDRV.exe clear 106')
          run('chd5620z.bat')
       .
     .
     IF RUNCODE()
        ZUR:RECORD='KÏÛDA IZSAUCOT APMAIÒAS PROGRAMMU: RC='&CLIP(RUNCODE())&' '&ERROR()
        ADD(ZURNALS)
        STATUSS1='Apmaiòas programmas kïûda ...'
     ELSE
        STATUSS1='DOS Atgrieðanâs kods normâls ...'
        UNHIDE(?ok)
     .
     UNHIDE(?CANCEL)
     DISPLAY
     soundfile='\WINLATS\BIN\Jungle Question.wav'
     sndPlaySoundA(soundfile,1)
     ACCEPT
        CASE FIELD()
        OF ?Ok
           IF EVENT()=EVENT:ACCEPTED
              LOCALRESPONSE=REQUESTCOMPLETED
              BREAK
           .
        OF ?CANCEL
           IF EVENT()=EVENT:ACCEPTED
              LOCALRESPONSE=REQUESTCANCELLED
              BREAK
           .
        .
     .
     IF LOCALRESPONSE=REQUESTCANCELLED
        DO PROCEDURERETURN
     .
  .
  CLEAR(ZUR:RECORD)
  CONVERTDBF('KOMANDA.DBF')
  CONVERTDBF('KONFIG.DBF')
  CONVERTDBF('DATI.DBF')
  CONVERTDBF('ACM.DBF')
  CONVERTDBF('PAY.DBF')
! STOP(PATH())

  DO AUTONUMBER     ! AIZÒEMAM 1. P/Z
  FILLPVN(0)
  MAK_NR=0
  CASE syS:KASES_AP
  OF   '10'         ! TEK
  OROF '1'          ! OMRON-3410'
  OROF '2'          ! OMRON-3420'
  OROF '3'          ! OMRON-3510'
  OROF '12'         ! OMRON-2810'
     CHECKOPEN(dati,1)
     SET(DATI)
     LOOP
        NEXT(DATI)
        IF ERROR() THEN BREAK.
        KODS=DAT:KODS
        SUMMA_K=DAT:SUMMA
        SKAITS=DAT:SKAITS
        NOSAUK=DAT:NOSAUK
        DO WRITENOM_K
        DO WRITENOLIK
        RAKSTI+=1
     .
     PAV:noka  =' Kase '&CLIP(POS_NR)
     PAV:APM_V ='4' ! UZREIZ
     PAV:APM_K ='2' ! SK.NAUDÂ
     DO WRITEPAVAD

  OF '7'            ! CHD-4010
  OROF '17'         ! CHD-5010
  OROF '23'         ! CHD-3010T
     CHECKOPEN(ACM,1)
     SET(ACM)
     LOOP
        NEXT(ACM)
        IF ERROR() THEN BREAK.
        KODS=ACM:KODS
        SUMMA_K=ACM:SUMMA
        SKAITS=ACM:SKAITS
        NOSAUK=ACM:NOSAUK
        DO WRITENOM_K
        DO WRITENOLIK
        RAKSTI+=1
     .
     PAV:noka  =' Kase '&CLIP(POS_NR)
     PAV:APM_V ='4' ! UZREIZ
     PAV:APM_K ='2' ! SK.NAUDÂ
     DO WRITEPAVAD

  OF '9'            ! FP-600
  OROF '19'         ! FP-600PLUS
  OROF '20'         ! CHD-3010T
  OROF '21'         ! CHD-5010T
  OROF '22'         ! EPOS-3L
  OROF '24'         ! OMRON-2810 F
  OROF '26'         ! NEW VISION
  OROF '27'         ! DATECS
  OROF '28'         ! CHD-3550T FISCAL
  OROF '29'         ! CHD-5510T FISCAL
     OPEN(FPPAVAD,18)
     IF ERROR()
        kluda(1,FPPAVADNAME)
        DO PROCEDURERETURN
     .
     OPEN(FPNOLIK,18)
     IF ERROR()
        kluda(1,FPNOLIKNAME)
        DO PROCEDURERETURN
     .
     SKIPATLIKUMI=TRUE           !FP ATLIKUMUS MAINA JAU PAÐÂ KASÇ
     FREE(N_TABLE)
     CLEAR(FPP:RECORD)
     SET(FPPAVAD)
     LOOP
        NEXT(FPPAVAD)
        IF ERROR() THEN BREAK.
        IF FPP:RT=2  !ÈEKS IZSISTS
           CEKI#+=1
           IF ~(FPP:NOL_NR=LOC_NR)
              IF ~JAU_BRIDINATS
                 KLUDA(119,'Noliktava N '&FPP:NOL_NR)
                 JAU_BRIDINATS=1
              .
              CYCLE
           .
           CLEAR(FPN:RECORD)
           FPN:U_NR=FPP:U_NR
           FPN:SECIBA=99999999 !UZ FAILA BEIGÂM
           SET(FPN:nr_key,FPN:NR_KEY)
           LOOP
              NEXT(FPNOLIK)
              IF ERROR() OR ~(FPN:U_NR=FPP:U_NR) THEN BREAK.
              DAUDZUMS=FPN:DAUDZUMS
              ATLAIDE_PR=FPN:ATLAIDE_PR
              FPN_SUMMA =FPN:SUMMA
              MAK_NR  =FPN:MAK_NR
              OBJ_NR  =FPN:OBJ_NR     !0/PÂRDEVÇJS
              IF MAK_NR   !IZRÇÍINAMIES AR MAKSÂTÂJU
                 PAR_NR    =MAK_NR
                 DAUDZUMS  =FPN:DAUDZUMS*(FPN:APD_SUMMA/FPN:SUMMA)  !30/06/05
                 ATLAIDE_PR=0                          !23/11/04
                 FPN_SUMMA =FPN:APD_SUMMA   !30/06/05
                 DO WRITE_N_TABLE
                 FPN_SUMMA =FPN:SUMMA-FPN_SUMMA
                 DAUDZUMS  =FPN:DAUDZUMS-DAUDZUMS
              .
              PAR_NR=FPP:PAR_NR
              IF DAUDZUMS     !IR VÇL KAUT KAS PALICIS PÇC APDROÐINÂTÂJA MAKSÂÐANAS
                 IF FPP:AV=1                    !KARTE-BANKSERVISS
                    MAK_NR=GETPAR_K(99999,3,18) !BANKSERVISAM JÂBÛT AR 99999 KARTI;3-BÛVÇT,JA NAV
                 ELSIF FPP:AV=2                 !DAÏÇJI KARTE
                    MAK_NR=GETPAR_K(99999,3,18) !BANKSERVISAM JÂBÛT AR 99999 KARTI;3-BÛVÇT,JA NAV
                    FPN_SUMMA=FPN:SUMMA*FPP:KAR_SUMMA/FPP:KSUMMA
                    DAUDZUMS=FPN:DAUDZUMS*FPP:KAR_SUMMA/FPP:KSUMMA
                    DO WRITE_N_TABLE
                    MAK_NR=0
                    DAUDZUMS=FPN:DAUDZUMS-DAUDZUMS
                    FPN_SUMMA=FPN:SUMMA-FPN_SUMMA
                 ELSIF FPP:AV=3                 !DÂVANU KARTE
                    MAK_NR=999999998            !VIRTUÂLS N 999999998 - NAV JÂBÛT DB
                    DAUDZUMS=FPN:SUMMA
                    DO WRITE_N_TABLE            !DATI D DOKUMENTAM
                    MAK_NR=0
                    FPN_SUMMA=FPN:SUMMA
                    DAUDZUMS=FPN:DAUDZUMS
                 ELSIF FPP:AV=4                 !DAÏÇJI DÂVANU KARTE
                    MAK_NR=999999998            !VIRTUÂLS N 999999998 - NAV JÂBÛT DB
                    FPN_SUMMA=FPN:SUMMA*FPP:KR2_SUMMA/FPP:KSUMMA
                    DAUDZUMS=FPN_SUMMA
                    DO WRITE_N_TABLE            !DATI D DOKUMENTAM
                    MAK_NR=0
                    FPN_SUMMA=FPN:SUMMA
                    DAUDZUMS=FPN:DAUDZUMS
                 ELSIF FPP:AV=5                 !DAÏÇJI KARTE,DAÏÇJI DÂVANU KARTE
                    MAK_NR=GETPAR_K(99999,3,18) !BANKSERVISAM JÂBÛT AR 99999 KARTI;3-BÛVÇT,JA NAV
                    FPN_SUMMA=FPN:SUMMA*FPP:KAR_SUMMA/FPP:KSUMMA
                    DAUDZUMS=FPN:DAUDZUMS*FPP:KAR_SUMMA/FPP:KSUMMA
                    DO WRITE_N_TABLE
                    MAK_NR=0
                    DAUDZUMS=FPN:DAUDZUMS-DAUDZUMS
                    FPN_SUMMA=FPN:SUMMA-FPN_SUMMA
                    MAK_NR=999999998            !VIRTUÂLS N 999999998 - NAV JÂBÛT DB
                    FPN_SUMMA=FPN:SUMMA*FPP:KR2_SUMMA/FPP:KSUMMA
                    DAUDZUMS=FPN_SUMMA
                    DO WRITE_N_TABLE            !DATI D DOKUMENTAM
                    MAK_NR=0
                    FPN_SUMMA=FPN:SUMMA
                    DAUDZUMS=FPN:DAUDZUMS
                 ELSE                           !FIXÇJAM CASH, JA IR
                    MAK_NR=0
                 .
                 DO WRITE_N_TABLE
              .

           .
        .
     .
     DATUMS=FPP:DATUMS  !ja nolasa citâ dienâ
     SORT(N_TABLE,N:MAK_NR)
     GET(N_TABLE,0)
     MAK_NR=999999999
     LOOP I#=1 TO RECORDS(N_TABLE)
        GET(N_TABLE,I#)
        IF ~(N:MAK_NR=MAK_NR)  !MAINÎJIES MAKSÂTÂJS
           IF ~(I#=1)
              DO WRITEPAVAD
              DO AUTONUMBER     !BÛS VAIRÂKAS P/Z
           .
           MAK_NR=N:MAK_NR
           IF MAK_NR=999999998            !VIRTUÂLS N 999999998 DÂVANU KARTE
              PAV:noka  ='Dâvanu karte K'&CLIP(POS_NR)
              PAV:APM_V ='5' !apmaksa nav paredzçta
              PAV:APM_K ='2' !SK.NAUDÂ
              PAV:D_K   ='D'
           ELSIF MAK_NR
              PAV:noka  ='K'&CLIP(POS_NR)&' '&GETPAR_K(MAK_NR,0,1)
              PAV:APM_V ='2' !PÇCAPMAKSA
              PAV:APM_K ='1' !PÂRSKAITÎJUMS
              PAV:D_K   ='K'
            ELSE
              PAV:noka  =' Kase '&CLIP(POS_NR)
              PAV:APM_V ='4' !UZREIZ
              PAV:APM_K ='2' !SK.NAUDÂ
              PAV:D_K   ='K'
           .
        .
        PAR_NR    =N:PAR_NR     !O/PREÈU SAÒÇMÇJS
        OBJ_NR    =N:OBJ_NR     !0/PÂRDEVÇJS
        KODS      =N:KODS
        SUMMA_K   =N:SUMMA
        ATLAIDE_PR=N:ATLAIDE_PR !ATLAIDE VAI NU REGULÂRA VAI KO MAKSÂ APDROÐINÂTÂJS
        SKAITS    =N:DAUDZUMS
        NOSAUK='????????????????'
        DO WRITENOM_K
        DO WRITENOLIK
        PAV:SUMMA_A+=ROUND(N:SUMMA*N:ATLAIDE_PR/100,.01)
        RAKSTI+=1
     .
     PAV_PAMAT=CLIP(PAV_PAMAT)&' '&CLIP(CEKI#)&' èeki'
     PAV:OBJ_NR=FPP:OBJ_NR
     DO WRITEPAVAD
     IF ~(JAU_BRIDINATS=1) !IR RAKSTI VAIRÂKÂM NOLIKTAVÂM
!        EMPTY(FPPAVAD)
!        EMPTY(FPNOLIK)
!        IF CL_NR=1026  !MEDEX
           CLOSE(FPPAVAD)
           REMOVE(FPPAVAD)
           CLOSE(FPNOLIK)
           REMOVE(FPNOLIK)
!        .
     .
  OF '13'           ! BLUEBRIDGE
!     LOCKNAME='\\KASE'&PLUNAME[7]&'\MBOX\LOCK.ECR'
!     RENAMEFILE(LOCKNAME,PCUSEDNAME)
     CHECKOPEN(PLU,1)
     SET(PLU)
     LOOP
        NEXT(PLU)
        IF ERROR() THEN BREAK.
!        DATUMS=TODAY()
        DATUMS=DOS_CONT(PLUNAME,1)
        KODS=PLU:CODE
        KODS=CHECKEAN(KODS,0)
        SUMMA_K=PLU:AMT
        SKAITS =PLU:QTY
        NOSAUK=''
        DO WRITENOM_K
        DO WRITENOLIK
        RAKSTI+=1
     .
!     RENAMEFILE(PCUSEDNAME,LOCKNAME)
     PAV:noka  =' Kase '&CLIP(POS_NR)
     PAV:APM_V ='4' !UZREIZ
     PAV:APM_K ='2' !SK.NAUDÂ
     DO WRITEPAVAD
  OF '14'           ! UNIWELL
  OROF '25'         ! UNIWELL 5400
     DATUMS=DOS_CONT(CLIP(PATH())&'\'&FILENAME1,1)
     CHECKOPEN(UNIWELL,1)
     SET(UNIWELL)
     LOOP
        NEXT(UNIWELL)
        IF ERROR() THEN BREAK.
!        KODS = checkean(A:KODS_ACM,0)
        KODS = checkean(UNI:KODS_ACM,0)
        NOSAUK=''
        SKAITS  =DEFORMAT(UNI:DAUDZUMS,@N010.3)
        SUMMA_K =DEFORMAT(UNI:SUMMA,@N011)/100
!   stop(SKAITS&'='&UNI:DAUDZUMS&'  '&SUMMA_K&'='&UNI:SUMMA/100)
        DO WRITENOM_K
        DO WRITENOLIK
        RAKSTI+=1
     .
     PAV:noka  =' Kase '&CLIP(POS_NR)
     PAV:APM_V ='4' !UZREIZ
     PAV:APM_K ='2' !SK.NAUDÂ
     DO WRITEPAVAD
  OF '15'           ! OPTIMA
     DATUMS=DOS_CONT(CLIP(PATH())&'\'&FILENAME1,1)
     CHECKOPEN(OPTIMA,1)
     SET(OPTIMA)
     LOOP
        NEXT(OPTIMA)
        IF ERROR() THEN BREAK.
        KODS=OPT:F2
!        KODS = checkean(OPT:F2,0)
        SUMMA_K=OPT:F7/100
        SKAITS=OPT:F6/1000
        NOSAUK=''
        DO WRITENOM_K
        DO WRITENOLIK
        RAKSTI+=1
     .
     PAV:noka  =' Kase '&CLIP(POS_NR)
     PAV:APM_V ='4' !UZREIZ
     PAV:APM_K ='2' !SK.NAUDÂ
     DO WRITEPAVAD
  OF '16'           ! POSMAN
     CHECKOPEN(POSMAN,1)
     SET(POSMAN)
     LOOP
        NEXT(POSMAN)
        IF ERROR() THEN BREAK.
        DATUMS=POS:DATE
        KODS=POS:EANCODE
        SUMMA_K=POS:TOTAL
        SKAITS=POS:AMOUNT
        NOSAUK=''
        DO WRITENOM_K
        DO WRITENOLIK
        RAKSTI+=1
     .
     PAV:noka  =' Kase '&CLIP(POS_NR)
     PAV:APM_V ='4' !UZREIZ
     PAV:APM_K ='2' !SK.NAUDÂ
     DO WRITEPAVAD
  OF '18'           ! CASIO FE300
     CHECKOPEN(ASCIIFILE,1)
     SET(ASCIIFILE)
     LOOP
        NEXT(ASCIIFILE)
        IF ERROR() THEN BREAK.
        DATUMS=TODAY()
        KODS=ASC:KODS
        SUMMA_K=ASC:SUMMA/100
        SKAITS=ASC:DAUDZUMS
        DO WRITENOM_K
        DO WRITENOLIK
        RAKSTI+=1
     .
     PAV:noka  =' Kase '&CLIP(POS_NR)
     PAV:APM_V ='4' !UZREIZ
     PAV:APM_K ='2' !SK.NAUDÂ
     DO WRITEPAVAD
  OF '32'           ! Elya CHD-3320/5620
     CHECKOPEN(TFILE_B,1)
     SET(TFILE_B)
     LOOP
        NEXT(TFILE_B)
        IF ERROR() THEN BREAK.
        DATUMS=TODAY()
        KODS=B:KODS
        !stop(KODS)
        SUMMA_K=B:SUMMA
        !stop(SUMMA_K)
        SKAITS=B:QNT
        !stop(SKAITS)
        NOSAUK = B:NOSAUK
        DO WRITENOM_K
        PAR_NR = 0 !06.05.2015
        DO WRITENOLIK
        RAKSTI+=1
     .
     !PAV:noka  =' Kase '&CLIP(POS_NR)
     PAV:noka  =' Kase '
     PAV:APM_V ='4' !UZREIZ
     PAV:APM_K ='2' !SK.NAUDÂ
     DO WRITEPAVAD
  .

  IF RAKSTI
     STATUSS1='Nolasîti '&clip(RAKSTI)&' ieraksti'
     UNHIDE(?ok)
  ELSE
     STATUSS1='Nav atrasts neviens ieraksts'
  .
  UNHIDE(?ok)
  ?OK{PROP:TEXT}=' OK '
  HIDE(?CANCEL)
  DISPLAY
  soundfile='\WINLATS\BIN\Jungle Question.wav'
  sndPlaySoundA(soundfile,1)
  ACCEPT
     CASE FIELD()
     OF ?Ok
        IF EVENT()=EVENT:ACCEPTED
           LOCALRESPONSE=REQUESTCOMPLETED
           BREAK
        .
     .
  .
  DO PROCEDURERETURN

!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ REÂLO PAVAD
  Auto::Attempts = 0
  LOOP
    SET(PAV:NR_KEY)
    PREVIOUS(PAVAD)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
      Auto::Save:PAV:U_NR = PAV:U_NR + 1
    END
    clear(PAV:Record)
    PAV:DATUMS=TODAY()
    PAV:DOKDAT=TODAY()
    PAV:U_NR = Auto::Save:PAV:U_NR
    ADD(PAVAD)
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


!-------------------------------------------------
WRITE_N_TABLE   ROUTINE
  ATRASTS#=FALSE
  LOOP J#= 1 TO RECORDS(N_TABLE)
     GET(N_TABLE,J#)
     IF N:MAK_NR=MAK_NR AND N:KODS=FPN:KODS AND|
     N:PAR_NR=PAR_NR AND N:ATLAIDE_PR=ATLAIDE_PR AND N:OBJ_NR=OBJ_NR
         IF FPP:RS=0  ! NAV STORNO
            N:DAUDZUMS +=DAUDZUMS
            N:SUMMA    +=FPN_SUMMA
         ELSE         ! STORNO
            N:DAUDZUMS-=DAUDZUMS
            N:SUMMA   -=FPN_SUMMA
         .
         PUT(N_TABLE)
         ATRASTS#=TRUE
         BREAK
     .
  .
  IF ATRASTS#=FALSE
     N:MAK_NR=MAK_NR
     N:KODS  =FPN:KODS
     N:PAR_NR=PAR_NR
     N:ATLAIDE_PR=ATLAIDE_PR
     N:OBJ_NR=OBJ_NR
     IF FPP:RS=0      ! NAV STORNO
        N:DAUDZUMS  =DAUDZUMS
        N:SUMMA     =FPN_SUMMA
     ELSE
        N:DAUDZUMS  =-DAUDZUMS
        N:SUMMA     =-FPN_SUMMA
     .
     ADD(N_TABLE)
  .

!-------------------------------------------------
WRITEPAVAD      ROUTINE
  PAV:D_K   ='K'
  IF DATUMS
     PAV:DATUMS=DATUMS
     PAV:DOKDAT=DATUMS
  .
  PAV:PAMAT =PAV_PAMAT
  PAV:NODALA=SYS:NODALA
!  PAV:noka  =' Kase '&CLIP(POS_NR)
!  PAV:APM_V ='4'
!  PAV:APM_K ='2'
  PAV:PAR_NR=0
  IF MAK_NR=999999998             !VIRTUÂLS N 999999998-DÂVANU KARTE
     PAV:D_K   ='D'
     PAV:MAK_NR=0
  ELSE
     PAV:MAK_NR=MAK_NR
  .
  PAV:SUMMA=ROUND(GETPVN(3),.01)+ROUND(getpvn(1),.01)
  PAV:SUMMA_B=ROUND(GETPVN(3),.01)
  PAV:VAL=val_uzsk !04/01/2014
  PAV:ACC_KODS=ACC_KODS
  PAV:ACC_DATUMS=TODAY()
  IF RIUPDATE:PAVAD()
     KLUDA(24,'PAVAD')
!     DO PROCEDURERETURN
  .
  FILLPVN(0)

!---------------------------------------------------------------------------------------------
WRITENOM_K    ROUTINE
  NOM_OK=TRUE
  IF MAK_NR=999999998             !VIRTUÂLS N 999999998-DÂVANU KARTE
     NOM:NOMENKLAT='DAVANUKARTE'
     IF ~GETNOM_K('DAVANUKARTE',2,1)
        NOM:NOMENKLAT='DAVANUKARTE'
        NOM:NOS_P    ='Dâvanu karte'
        NOM:NOS_s    ='Dâvanu karte'
        NOM:PVN_PROC =0
        NOM:TIPS='V'
        LOOP V#= 1 TO 5
           NOM:VAL[V#]=val_uzsk !04/01/2014
        .
        ADD(NOM_K)
        IF ERROR()
           KLUDA(24,'NOM_K (ADD)')
           ZUR:RECORD=CLIP(ZUR:RECORD)&' KÏÛDA RAKSTOT NOM_K (ADD)'
        .
     .
     AtlikumiN('D',NOM:NOMENKLAT,SKAITS,'','',0)
  ELSE
     IF GETNOM_K(KODS,2,8) >0 !TÂDS KODS IR
        ZUR:RECORD='L:'&FORMAT(TODAY(),@D6)&' KODS= '&KODS&' '&NOM:NOS_P &' Ls '&SUMMA_K&' '&XZ
        IF ~SKIPATLIKUMI
           AtlikumiN('K',NOM:NOMENKLAT,SKAITS,'','',0)
        .
        KopsN(NOM:NOMENKLAT,TODAY(),'K')
     ELSIF ~IGNORE
        ZUR:RECORD   ='L:'&FORMAT(TODAY(),@D06.)&' KÏÛDA: Nav atrasts KODS= '&KODS
        NOM:KODS     =KODS
        NOM:NOS_P    =NOSAUK
        NOM:NOMENKLAT='+'&CLIP(KODS)
!        STOP(NOM:NOMENKLAT)
        NOM:PVN_PROC =SYS:NOKL_PVN
        NOM:TIPS='P'
        LOOP V#= 1 TO 5
           NOM:VAL[V#]=val_uzsk !04/01/2014
        .
        ADD(NOM_K)
        IF ERROR()
           KLUDA(24,'NOM_K (ADD) '&NOM:NOMENKLAT)
           ZUR:RECORD=CLIP(ZUR:RECORD)&' KÏÛDA RAKSTOT NOM_K (ADD) '&NOM:NOMENKLAT
        .
        IF ~SKIPATLIKUMI
           AtlikumiN('K',NOM:NOMENKLAT,SKAITS,'','',0)
        .
     ELSE
        ZUR:RECORD='L:'&FORMAT(TODAY(),@D6)&' Izlaiþu nomenklatûru KODS= '&KODS &' '&NOSAUK &' Ls '&SUMMA&' '&XZ
        NOM_OK=FALSE
     .
     ADD(ZURNALS)
  .
  DISPLAY
!---------------------------------------------------------------------------------------------
WRITENOLIK    ROUTINE
     IF NOM_OK=TRUE
        NOL:U_NR=PAV:U_NR
        NOL:OBJ_NR=OBJ_NR
        IF DATUMS
           NOL:DATUMS=DATUMS
        ELSE
           NOL:DATUMS=TODAY()
        .
        NOL:NOMENKLAT=NOM:NOMENKLAT
        NOL:PAR_NR=PAR_NR
        IF PAV:D_K
           NOL:D_K=PAV:D_K
        ELSE
           NOL:D_K='K'
        .
        NOL:DAUDZUMS=SKAITS
        NOL:SUMMA=SUMMA_K
        NOL:SUMMAV=SUMMA_K
        NOL:VAL=val_uzsk !04/01/2014
        NOL:ATLAIDE_PR=ATLAIDE_PR
        NOL:PVN_PROC = NOM:PVN_PROC
        NOL:ARBYTE = 1                !AR PVN
        FILLPVN(1)
        ADD(nolik)
        IF ERROR()
           KLUDA(24,'NOLIK (ADD)')
           DO PROCEDURERETURN
        .
     .
!---------------------------------------------------------------------------------------------
PROCEDURERETURN    ROUTINE
  CASE SYS:KASES_AP
  OF '10'           ! TEC
  OROF '1'          ! OMRON-3410'
  OROF '2'          ! OMRON-3420'
  OROF '3'          ! OMRON-3510'
  OROF '12'         ! OMRON-2810'
     CLOSE(DATI)
  OF ' 7'           ! CHD-4010
  OROF '17'         ! CHD-5010
  OROF '23'         ! CHD-3010T
     CLOSE(ACM)
  OF '9'            ! FP-600
  OROF '19'         ! FP-600PLUS
  OROF '20'         ! CHD-3010T FISCAL
  OROF '21'         ! CHD-5010T FISCAL
  OROF '22'         ! EPOS-3L
  OROF '24'         ! OMRON-2810 F
  OROF '26'         ! NEW VISION
  OROF '27'         ! DATECS
  OROF '28'        ! CHD-3550T FISCAL
  OROF '29'        ! CHD-5510T FISCAL
     CLOSE(FPPAVAD)
     CLOSE(FPNOLIK)
  OF '13'           ! BLUEBRIDGE
     CLOSE(PLU)
  OF '15'           ! OPTIMA CR500
     CLOSE(OPTIMA)
  OF '16'           ! POSMAN
     CLOSE(POSMAN)
  OF '18'           ! CASIO FE300
     CLOSE(ASCIIFILE)
  .
  CLOSE(ZURNALS)
  DZNAME='DZ'&FORMAT(JOB_NR,@N02)
  CHECKOPEN(ZURNALS,1)
  NOLIK::USED-=1
  IF NOLIK::USED=0
     CLOSE(NOLIK)
  .
  NOM_K::USED-=1
  IF NOM_K::USED=0
     CLOSE(NOM_K)
  .
  CLOSE(ReLoadSCREEN)
  RETURN



