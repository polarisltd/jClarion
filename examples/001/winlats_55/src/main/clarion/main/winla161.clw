                     MEMBER('winlats.clw')        ! This is a MEMBER module
BrowseCrossref PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG

BRW1::View:Browse    VIEW(CROSSREF)
                       PROJECT(CRO:KATALOGA_NR)
                       PROJECT(CRO:RAZ_K)
                       PROJECT(CRO:NOS_S)
                       PROJECT(CRO:NOMENKLAT)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::CRO:KATALOGA_NR  LIKE(CRO:KATALOGA_NR)      ! Queue Display field
BRW1::CRO:RAZ_K        LIKE(CRO:RAZ_K)            ! Queue Display field
BRW1::CRO:NOS_S        LIKE(CRO:NOS_S)            ! Queue Display field
BRW1::CRO:NOMENKLAT    LIKE(CRO:NOMENKLAT)        ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:KeyDistribution LIKE(CRO:KATALOGA_NR),DIM(100)
BRW1::Sort2:LowValue LIKE(CRO:KATALOGA_NR)        ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(CRO:KATALOGA_NR)       ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Browse the CROSSREF File'),AT(,,257,275),FONT('MS Sans Serif',9,,FONT:bold),IMM,VSCROLL,HLP('BrowseCrossref'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,241,209),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('80L(2)|M~Kataloga Nr~@S21@17L(2)|M~RAZ~C(0)@S3@68L(2)|M~Nosaukums~@S16@80L(2)|M~' &|
   'Nomenklatûra~@S21@'),FROM(Queue:Browse:1)
                       BUTTON('Iz&vçlçties'),AT(6,255),USE(?Select),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                       BUTTON('&Ievadît'),AT(51,255,45,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(99,255,45,14),USE(?Change ),DEFAULT
                       BUTTON('&Dzçst'),AT(149,255,45,14),USE(?Delete:2)
                       SHEET,AT(4,4,251,246),USE(?CurrentTab)
                         TAB('Kataloga Nr secîba'),USE(?Tab:2)
                           ENTRY(@S21),AT(9,234),USE(CRO:KATALOGA_NR)
                           STRING('- pçc kataloga Nr'),AT(106,236),USE(?String1)
                         END
                         TAB('Nomenklatûru secîba'),USE(?Tab2)
                           ENTRY(@S21),AT(9,233),USE(CRO:NOMENKLAT)
                           STRING('- pçc nomenklatûras '),AT(105,236),USE(?String2)
                         END
                       END
                       BUTTON('&Beigt'),AT(197,255,45,14),USE(?Close)
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
  IF LOCALREQUEST=SELECTRECORD
     ?Change{PROP:DEFAULT}=''
     ?Select{PROP:DEFAULT}='1'
  .
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
      IF NOMENKLAT
         CLEAR(CRO:RECORD)
         CRO:KATALOGA_NR=NOMENKLAT
         SET(CRO:KAT_KEY,CRO:KAT_KEY)
         NEXT(CROSSREF)
      !   DO BRW1::Reset
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
      !   DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         DO RefreshWindow
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
    OF ?Select
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
        NOMENKLAT=CRO:NOMENKLAT
      END
    OF ?Insert:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Change 
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
    OF ?CRO:KATALOGA_NR
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?CRO:KATALOGA_NR)
        IF CRO:KATALOGA_NR
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?CRO:NOMENKLAT
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?CRO:NOMENKLAT)
        IF CRO:NOMENKLAT
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
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
  IF CROSSREF::Used = 0
    CheckOpen(CROSSREF,1)
  END
  CROSSREF::Used += 1
  BIND(CRO:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseCrossref','winlats.INI')
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
    CROSSREF::Used -= 1
    IF CROSSREF::Used = 0 THEN CLOSE(CROSSREF).
  END
  IF WindowOpened
    INISaveWindow('BrowseCrossref','winlats.INI')
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
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LocatorValue = CRO:NOMENKLAT
    CLEAR(CRO:NOMENKLAT)
  OF 2
    BRW1::Sort2:LocatorValue = CRO:KATALOGA_NR
    CLEAR(CRO:KATALOGA_NR)
  END
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
      StandardWarning(Warn:RecordFetchError,'CROSSREF')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:HighValue = CRO:KATALOGA_NR
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'CROSSREF')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:LowValue = CRO:KATALOGA_NR
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
  CRO:KATALOGA_NR = BRW1::CRO:KATALOGA_NR
  CRO:RAZ_K = BRW1::CRO:RAZ_K
  CRO:NOS_S = BRW1::CRO:NOS_S
  CRO:NOMENKLAT = BRW1::CRO:NOMENKLAT
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
  BRW1::CRO:KATALOGA_NR = CRO:KATALOGA_NR
  BRW1::CRO:RAZ_K = CRO:RAZ_K
  BRW1::CRO:NOS_S = CRO:NOS_S
  BRW1::CRO:NOMENKLAT = CRO:NOMENKLAT
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
      POST(Event:Accepted,?Change )
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
      OF 2
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => UPPER(CRO:KATALOGA_NR)
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
        POST(Event:Accepted,?Select)
        EXIT
      END
      POST(Event:Accepted,?Change )
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
    OF DeleteKey
      POST(Event:Accepted,?Delete:2)
    OF CtrlEnter
      POST(Event:Accepted,?Change )
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          SELECT(?CRO:NOMENKLAT)
          PRESS(CHR(KEYCHAR()))
        END
      OF 2
        IF CHR(KEYCHAR())
          SELECT(?CRO:KATALOGA_NR)
          PRESS(CHR(KEYCHAR()))
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
    OF 2
      CRO:KATALOGA_NR = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'CROSSREF')
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
      BRW1::HighlightedPosition = POSITION(CRO:NOM_KEY)
      RESET(CRO:NOM_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(CRO:NOM_KEY,CRO:NOM_KEY)
    END
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(CRO:KAT_Key)
      RESET(CRO:KAT_Key,BRW1::HighlightedPosition)
    ELSE
      SET(CRO:KAT_Key,CRO:KAT_Key)
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
    CASE BRW1::SortOrder
    OF 1; ?CRO:NOMENKLAT{Prop:Disable} = 0
    OF 2; ?CRO:KATALOGA_NR{Prop:Disable} = 0
    END
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
    ?Change {Prop:Disable} = 0
    ?Delete:2{Prop:Disable} = 0
  ELSE
    CLEAR(CRO:Record)
    CASE BRW1::SortOrder
    OF 1; ?CRO:NOMENKLAT{Prop:Disable} = 1
    OF 2; ?CRO:KATALOGA_NR{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    ?Change {Prop:Disable} = 1
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
    SET(CRO:NOM_KEY)
  OF 2
    SET(CRO:KAT_Key)
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
  BrowseButtons.ChangeButton=?Change 
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
  GET(CROSSREF,0)
  CLEAR(CRO:Record,0)
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
!| (UpdateCrossref) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateCrossref
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
        GET(CROSSREF,0)
        CLEAR(CRO:Record,0)
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


BrowseNOM_K PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
Pieejams             DECIMAL(11,3)
Atlikums             DECIMAL(11,3)
D_projekts           DECIMAL(11,3)
K_projekts           DECIMAL(11,3)
cena                 DECIMAL(9,2)
KRIT_DAU             DECIMAL(7,2)
PIEMS                DECIMAL(11,3),DIM(25)
ARBYTE               STRING(1)
STATUSS              STRING(1)
F:REDZAMIBA          BYTE
SAV:REDZAMIBA        BYTE
F_REDZAMS            CSTRING(50)
SAV:ATBILDIGAIS      BYTE
F:N                  BYTE
SAV:N                STRING(1)
F_ATBILDIGAIS        STRING(20)
CENA_NR              BYTE
CENA_TO              BYTE
PLUSPROC             DECIMAL(4,1)
ZIMES                BYTE(2)
SELECT_ENTER         BYTE
M_KLUDA              BYTE
N                    STRING(1)
LOCAL_PATH     CSTRING(60)
raksti         long
izlaisti       long
MAINITI        long
keska          CSTRING(21)
SAV_CENA       LIKE(NOM:REALIZ[1])
NOM_REALIZ     LIKE(NOM:REALIZ)
PIEKTA         REAL
MC             CSTRING(60)

NOM_NOMENKLAT   LIKE(NOM:NOMENKLAT)
NOM_KODS        LIKE(NOM:KODS)
NOM_KATALOGA_NR LIKE(NOM:KATALOGA_NR)

SPIEDIET       STRING(40)
NEW_statuss    STRING(1)
OLD_statuss    STRING(1)
STRINGBYTE     STRING(8)
SAV_DAUDZUMS   LIKE(NOL:DAUDZUMS)
SAV_SUMMA      LIKE(NOL:SUMMA)
UPDATETEXT     CSTRING(15)

N_TABLE        QUEUE,PRE(N)
NOMENKLAT       STRING(21)
               .

OLD_PVN        BYTE
NEW_PVN        BYTE
PROCLS         BYTE
SEARCHMODE     BYTE
new_PVNlikme   DECIMAL(2)
PVNlikme       DECIMAL(2)
REALIZ         DECIMAL(20,6)
REALIZ_0cip    DECIMAL(20)
REALIZ_1cip    DECIMAL(20,1)
REALIZ_2cip    DECIMAL(20,2)
REALIZ_3cip    DECIMAL(20,3)
REALIZ_4cip    DECIMAL(20,4)
Order_         DECIMAL(6,4)
Plus           DECIMAL(7,5)
Multiply       DECIMAL(6)
OLD_PVN_1      BYTE
NEW_PVN_1      BYTE

CiparuSk       Decimal(1)
Noapolot       Decimal(1)

NOM_K2             FILE,DRIVER('DBASE3'),NAME(FILENAME1),CREATE,PRE(NOM2),OEM
RECORD                RECORD
NOM                     STRING(21)
TIPS                    STRING(1)
KATALOGA_NR             STRING(22)
EAN_TEST                STRING(1)
EAN                     STRING(13)
BKK                     STRING(5)
PVNLIKME                STRING(2)
NOS_P                   STRING(50)
NOS_S                   STRING(16)
CENA_L                  STRING(1)
REDZAMS                 STRING(1)
                   .  .

A:NOMENKLAT    LIKE(NOM:NOMENKLAT)
A:KODS         LIKE(NOM:KODS)
A:MUITAS_KODS  LIKE(NOM:MUITAS_KODS)
A:IZC_V_KODS   LIKE(NOM:IZC_V_KODS)
A:KATALOGA_NR  LIKE(NOM:KATALOGA_NR)
A:NOS_P        LIKE(NOM:NOS_P)
A:NOS_S        LIKE(NOM:NOS_S) 
A:NOS_A        LIKE(NOM:NOS_A)
A:SVARSKG      LIKE(NOM:SVARSKG)
A:MERVIEN      LIKE(NOM:MERVIEN)
A:PVN_PROC     LIKE(NOM:PVN_PROC)
A:REALIZ       DECIMAL(11,4)
A:NOM_BKK      LIKE(NOM:BKK)

NOM_KX            FILE,PRE(NOMX),DRIVER('ASCII'),NAME(FILENAME1),CREATE
RECORD               RECORD
LINE                   STRING(200)
                  .  .


NOM_CHECK         FILE,NAME('NOM_CHECKER.TXT'),PRE(N),DRIVER('ASCII'),CREATE
                     RECORD
LINE                   STRING(80)
                  .  .


showscreen WINDOW('Datu imports'),AT(,,185,91),CENTER,GRAY
       STRING('Uzbûvçti D un K nomenklatûras maiòas dokumenti '),AT(9,13),USE(?StringDKPZ),HIDE
       STRING('Ierakstîti:'),AT(56,34),USE(?StringIER)
       STRING(@n7B),AT(96,34),USE(raksti)
       STRING('Izlaisti:'),AT(62,43),USE(?StringIZL)
       STRING(@n7B),AT(96,43),USE(izlaisti)
       STRING('Mainîti:'),AT(62,52),USE(?Stringm)
       STRING(@n7B),AT(96,52),USE(mainiti)
       STRING('...bûvçju atslçgas, gaidiet'),AT(49,61),USE(?buveju_a),HIDE
       STRING(@s40),AT(27,71),USE(SPIEDIET)
       STRING(@s21),AT(48,24),USE(nom:nomenklat,,?nom:nomenklat:1)
     END

INETscreen WINDOW('Interneta faila sagatavoðana'),AT(,,273,115),CENTER,GRAY
       STRING('Tiks izveidots FTP fails '),AT(9,13),USE(?Stringftp)
       STRING(@s50),AT(87,12,178,10),USE(ANSIFILENAME),LEFT(2)
       STRING('bûvçðanas laikâ bûs monopolreþîms, nevarçs mainît NOM-atlikumus (Pavadzîmi) '),AT(2,21), |
           USE(?String:7)
       ENTRY(@s21),AT(120,38,60,10),USE(NOMENKLAT),LEFT
       STRING('Cena :'),AT(188,38),USE(?String10)
       ENTRY(@n1),AT(213,38,12,10),USE(NOKL_CP),CENTER,REQ
       STRING('(1-4)'),AT(227,38),USE(?String11)
       PROMPT('Filtrs pçc nomenklatûras :'),AT(33,38),USE(?Prompt1)
       STRING('Ierakstîti:'),AT(64,61),USE(?StringIERI)
       STRING(@n7B),AT(104,61),USE(raksti,,?RAKSTII)
       STRING('Izlaisti:'),AT(70,70),USE(?StringIZLI)
       STRING(@n7B),AT(104,70),USE(izlaisti,,?IZLAISTII)
       STRING(@s40),AT(35,83),USE(SPIEDIET,,?SPIEDIETI)
       STRING(@s21),AT(56,51),USE(nom:nomenklat,,?nom:nomenklat:1I),HIDE
       BUTTON('&OK'),AT(161,94,43,14),USE(?Ok:I),DEFAULT
       BUTTON('&Atlikt'),AT(207,94,43,14),USE(?Cancel:I),DEFAULT
     END

FiltrsScreen WINDOW('Nomenklatûru saraksta redzamîbas Filtri'),AT(,,210,116),GRAY
       GROUP('Pçc Redazmîbas'),AT(10,6,93,58),USE(?Group1),BOXED
       END
       CHECK('Aktîvâs'),AT(18,18,52,10),USE(STRINGBYTE[8]),VALUE('1','')
       CHECK('Arhîva'),AT(18,29,52,10),USE(STRINGBYTE[7]),VALUE('1','')
       CHECK('Nâkotnes'),AT(18,40,52,10),USE(STRINGBYTE[6]),VALUE('1','')
       CHECK('Likvidçjamâs'),AT(18,50),USE(STRINGBYTE[5]),VALUE('1','')
       OPTION('Pçc Atbildîgâ'),AT(105,6,94,41),USE(F:ATBILDIGAIS),BOXED
         RADIO('Atbildîbâ esoðâs'),AT(114,19),USE(?F:ATBILDIGAIS:Radio1),VALUE('1')
         RADIO('Visas nomenklatûras'),AT(114,30),USE(?F:ATBILDIGAIS:Radio2),VALUE('0')
       END
       BUTTON('&OK'),AT(145,93,43,14),USE(?Ok:F),DEFAULT
       OPTION('Pçc Redzamîbas ðajâ noliktavâ'),AT(11,66,116,41),USE(F:N,,?F:N:2),BOXED
         RADIO('Râdît neredzamâs'),AT(20,79),USE(?F:N:Radio1),VALUE('1')
         RADIO('Nerâdît'),AT(20,90),USE(?F:N:Radio2),VALUE('0')
       END
     END
            
CenaScreen WINDOW('Mainît cenu'),AT(,,189,130),GRAY
       STRING(@N7B),AT(75,6),USE(CHANGED#)
       STRING('Cena_nr:'),AT(36,22),USE(?String111)
       ENTRY(@n1),AT(71,21),USE(cena_nr)
       STRING('Saglabât kâ cenu Nr:'),AT(91,23),USE(?String4)
       ENTRY(@N1),AT(160,21),USE(CENA_TO)
       STRING('Nomenklatûra(Grupa):'),AT(10,37),USE(?String112)
       ENTRY(@s21),AT(83,36),USE(nomenklat,,?NOMENKLAT:C)
       STRING('Cenas pieaugums(samazinâjums) '),AT(14,55),USE(?String113)
       ENTRY(@n-_7.3),AT(150,53,28,12),USE(plusproc),RIGHT(2)
       OPTION,AT(128,47,20,28),USE(PROCLS),BOXED
         RADIO('%'),AT(130,54,13,10),USE(?PROCLS:Radio1),VALUE('0')
         RADIO('Ls'),AT(130,63,16,10),USE(?PROCLS:Radio2),VALUE('1')
       END
       OPTION('Zîmes aiz komata'),AT(37,66,72,23),USE(zimes),BOXED
         RADIO('2'),AT(46,76),USE(?zimes:Radio1),VALUE('2')
         RADIO('3'),AT(63,76),USE(?zimes:Radio2),VALUE('3')
         RADIO('4'),AT(81,76),USE(?zimes:Radio3),VALUE('4')
       END
       BUTTON('Noapaïot uz augðu, ja pieaugums << Ls 0.005'),AT(7,91,153,14),USE(?Button:P)
       IMAGE('CHECK3.ICO'),AT(162,91,15,15),USE(?Image:P),HIDE
       BUTTON('&OK'),AT(90,108,43,14),USE(?Ok:C),DEFAULT
       BUTTON('&Atlikt'),AT(136,108,43,14),USE(?Cancel:C),DEFAULT
     END

EURscreen WINDOW('Mainît cenu uz EUR'),AT(,,184,91),GRAY
       STRING(@N7B),AT(75,6),USE(CHANGED#,,?CHANGEDE)
       STRING('Cena_nr:'),AT(36,22),USE(?String111E)
       ENTRY(@n1),AT(71,21),USE(cena_nr,,?CENA_NRE)
       STRING('Saglabât kâ cenu Nr:'),AT(91,23),USE(?String4E)
       ENTRY(@N1),AT(160,21),USE(CENA_TO,,?CENA_TOE)
       STRING('Nomenklatûra(Grupa):'),AT(10,37),USE(?String112E)
       ENTRY(@s21),AT(83,36),USE(nomenklat,,?NOMENKLAT:E)
       OPTION('Zîmes aiz komata'),AT(37,50,72,23),USE(zimes,,?ZIMESE),BOXED
         RADIO('2'),AT(46,60),USE(?zimesE:Radio1),VALUE('2')
         RADIO('3'),AT(63,60),USE(?zimesE:Radio2),VALUE('3')
         RADIO('4'),AT(81,60),USE(?zimesE:Radio3),VALUE('4')
       END
       BUTTON('&OK'),AT(90,75,43,14),USE(?Ok:EUR),DEFAULT
       BUTTON('&Atlikt'),AT(136,75,43,14),USE(?Cancel:EUR),DEFAULT
     END

ProcScreen WINDOW('Mainît uzcenojuma % 5.cenai'),AT(,,187,71),GRAY
       STRING('Nomenklatûra (Grupa):'),AT(4,16),USE(?String112:1)
       ENTRY(@s21),AT(80,14),USE(nomenklat,,?NOMENKLAT:1),REQ
       STRING('Uzcenojuma  %'),AT(27,31),USE(?String113:1)
       ENTRY(@n-6.1),AT(81,29,22,12),USE(plusproc,,?PLUSPROC:1),RIGHT(2)
       STRING(@N5B),AT(103,31),USE(NONEMTI#)
       BUTTON('&OK'),AT(89,49,43,14),USE(?Ok:P),DEFAULT
       BUTTON('&Atlikt'),AT(135,49,43,14),USE(?Cancel:P),DEFAULT
     END

KESKAwindow WINDOW('Izvçles logs'),AT(,,197,73),GRAY
       STRING('Meklçjamais fragments:'),AT(9,25),USE(?String221)
       ENTRY(@s20),AT(94,24),USE(keska)
       BUTTON('&OK'),AT(116,45,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(154,45,36,14),USE(?CancelButton)
     END

STATUSSCREEN WINDOW('KA Statusa maiòa'),AT(,,130,181),GRAY
       STRING(@N6B),AT(40,5),USE(JB#)
       ENTRY(@s21),AT(9,26),USE(NOMENKLAT,,?NOMENKLAT:S),UPR
       STRING('Filtrs pçc nomenklatûras'),AT(8,15),USE(?String1)
       OPTION('&Mainît statusu no ....'),AT(9,40,112,58),USE(OLD_STATUSS),BOXED
         RADIO('0-jâsûta uz KA'),AT(16,49),VALUE('0')
         RADIO('1-jâpârraksta KA'),AT(16,57),VALUE('1')
         RADIO('2-jâdzçð KA'),AT(16,65),VALUE('2')
         RADIO('3-viss OK'),AT(16,73),VALUE('3')
         RADIO('N-Neredzama ðajâ noliktavâ'),AT(16,81,103,10),VALUE('N')
       END
       OPTION('&Uz statusu'),AT(9,99,112,58),USE(NEW_STATUSS),BOXED
         RADIO('0-jâsûta uz KA'),AT(16,108),USE(?NEW_STATUSS:Radio1),VALUE('0')
         RADIO('1-jâpârraksta KA'),AT(16,116),USE(?NEW_STATUSS:Radio2),VALUE('1')
         RADIO('2-jâdzçð KA'),AT(16,124),USE(?NEW_STATUSS:Radio3),VALUE('2')
         RADIO('3-viss OK'),AT(16,132),USE(?NEW_STATUSS:Radio4),VALUE('3')
         RADIO('N-Neredzama ðajâ noliktavâ'),AT(16,140,103,10),USE(?NEW_STATUSS:Radio5),VALUE('N')
       END
       BUTTON('&OK'),AT(47,161,35,14),USE(?Ok:S),DEFAULT
       BUTTON('&Atlikt'),AT(86,161,36,14),USE(?Cancel:S)
     END

PR      BYTE
PVNSCREEN WINDOW('PVN % maiòa'),AT(,,175,190),GRAY
       STRING(@N6B),AT(40,5),USE(JP#)
       ENTRY(@s21),AT(9,26),USE(NOMENKLAT,,?NOMENKLAT:P),UPR
       STRING('Filtrs pçc nomenklatûras'),AT(8,15),USE(?String1:111)
       OPTION('&Meklçt'),AT(9,40,82,84),USE(old_pvn),BOXED
         RADIO('PVN_neapliekams'),AT(16,49,71,10),USE(?old_pvn:Radio1:2),VALUE('1')
         RADIO('0% PVN'),AT(16,57),USE(?old_pvn:Radio2:2),VALUE('0')
         RADIO('5% PVN'),AT(16,65),USE(?old_pvn:Radio3:2),VALUE('5')
         RADIO('9% PVN'),AT(16,73),USE(?old_pvn:Radio4:2),VALUE('9')
         RADIO('18% PVN'),AT(16,81),USE(?old_pvn:Radio5),VALUE('18')
         RADIO('21% PVN'),AT(16,90),USE(?old_pvn:Radio6),VALUE('21')
         RADIO('10% PVN'),AT(16,99),USE(?old_pvn:Radio7),VALUE('10')
       END
       OPTION('Mainît &Uz'),AT(92,40,83,54),USE(new_pvn),BOXED
         RADIO('PVN_neapliekams'),AT(99,49,73,10),USE(?new_pvn:Radio1),VALUE('1')
         RADIO('0% PVN'),AT(99,57),USE(?new_pvn:Radio2),VALUE('0')
         RADIO('12% PVN'),AT(99,65),USE(?new_pvn:Radio3),VALUE('12')
         RADIO('9% PVN'),AT(99,73),USE(?new_pvn:Radio4),VALUE('9')
         RADIO('22% PVN'),AT(99,81),USE(?new_pvn:Radio8),VALUE('22')
       END
       BUTTON('Pârrçíinât visas cenas, kas "ar PVN"'),AT(20,132,130,14),USE(?Button:PR)
       STRING('Piemçram, ja cena ar 21% PVN=121,-'),AT(21,151),USE(?StringPiem:1),FONT(,,COLOR:Green,,CHARSET:BALTIC)
       STRING('pârrçíinâs uz ar 22% PVN=122,- utt.'),AT(22,160),USE(?StringPIEM:2),FONT(,,COLOR:Green,,CHARSET:BALTIC)
       IMAGE('CHECK3.ICO'),AT(151,129,15,17),USE(?Image:PR),HIDE
       BUTTON('&OK'),AT(98,171,35,14),USE(?Ok:PVN),DEFAULT
       BUTTON('&Atlikt'),AT(137,171,36,14),USE(?Cancel:PVN)
     END

PVNSCREEN1 WINDOW('PVN % maiòa'),AT(,,175,195),GRAY
       ENTRY(@s21),AT(9,26),USE(NOMENKLAT,,?NOMENKLAT:P),UPR
       OPTION('&Meklçt'),AT(9,40,82,48),USE(old_pvn_1,,?old_pvn_1:P),BOXED
         RADIO('PVN neapliekams'),AT(16,49,71,10),USE(?old_pvn_1:Radio1:2),VALUE('1')
         RADIO('PVN likme'),AT(16,58),USE(?old_pvn_1:Radio2:2),VALUE('0')
       END
       ENTRY(@N2),AT(37,69,20,14),USE(PVNlikme,,?PVNlikme:P)
       OPTION('Mainît &Uz'),AT(92,40,83,48),USE(new_pvn_1,,?new_pvn_1:P),BOXED
         RADIO('PVN_neapliekams'),AT(99,49,73,10),USE(?new_pvn_1:Radio1),VALUE('1')
         RADIO('PVN likme'),AT(99,58),USE(?new_pvn_1:Radio2),VALUE('0')
       END
       ENTRY(@N2),AT(121,69,20,14),USE(new_PVNlikme,,?new_PVNlikme:P)
       BUTTON('Pârrçíinât visas cenas, kas "ar PVN"'),AT(20,90,130,14),USE(?Button:PR_1)
       ENTRY(@N1),AT(72,126,12,12),USE(CiparuSk,,?CiparuSk:P),HIDE
       OPTION('Noapoïot'),AT(21,141,131,33),USE(Noapolot),BOXED,HIDE
         RADIO('pçc matematîkas noteikumiem'),AT(29,150,121,10),USE(?Noapolot:Radio1),HIDE,VALUE('0')
         RADIO('vienmçr lîdz lielâkai vçrtîbai '),AT(29,161,113,10),USE(?Noapolot:Radio2),HIDE,VALUE('1')
       END
       BUTTON('&OK'),AT(98,178,35,14),USE(?OK:PVN_1),DEFAULT
       BUTTON('&Atlikt'),AT(137,178,36,14),USE(?Cancel:PVN_1)
       STRING('Noapaïot cenu lîdz '),AT(5,128,64,10),USE(?NoapCipari),HIDE
       STRING('Filtrs pçc nomenklatûras'),AT(8,15),USE(?String1:111)
       STRING('Piemçram, ja cena ar 21% PVN=121,-'),AT(21,105),USE(?StringPiem:1),FONT(,,COLOR:Green,,CHARSET:BALTIC)
       STRING('pârrçíinâs uz ar 22% PVN=122,- utt.'),AT(21,114),USE(?StringPIEM:2),FONT(,,COLOR:Green,,CHARSET:BALTIC)
       STRING(@N6B),AT(40,5),USE(JP#)
       STRING('(0 - 4) cipariem aiz komata'),AT(86,128,89,10),USE(?NoapCapari_),HIDE
       IMAGE('CHECK3.ICO'),AT(151,88,15,17),USE(?Image:PR_1),HIDE
     END

SLIQUIDscreen WINDOW('Redzamîbas mainîðana'),AT(,,251,90),CENTER,GRAY
       STRING('Tiks mainîta redzamîba uz "Likvidçjama" visâm nomenklatûrâm,'),AT(9,13),USE(?StringSL1)
       STRING('kurâm ðjâ datu bâzç netisk konstatçti ne atlikumi, ne kâdas darbîbas'),AT(4,21),USE(?StringSL2)
       STRING('Mainîtas:'),AT(89,43),USE(?StringIERSL)
       STRING(@n7B),AT(122,43),USE(raksti,,?RAKSTSL)
       STRING(@n7b),AT(162,32),USE(npk#)
       STRING(@s40),AT(53,56),USE(SPIEDIET,,?SPIEDIETSL)
       STRING(@s21),AT(75,32),USE(nom:nomenklat,,?nom:nomenklat:1SL),HIDE
       BUTTON('&OK'),AT(150,69,43,14),USE(?Ok:SL),DEFAULT
       BUTTON('&Atlikt'),AT(196,69,43,14),USE(?Cancel:SL),DEFAULT
     END

LIQUIDscreen WINDOW('Nomenklatûru dzçðana'),AT(,,251,90),CENTER,GRAY
       STRING('Tiks dzçstas visas nomenklatûras, kam redzamîba ir "Likvidçjama"'),AT(9,4),USE(?StringL1)
       STRING('un kurâm ðjâ datu bâzç netisk konstatçti ne atlikumi, ne kâdas darbîbas'),AT(4,12),USE(?StringL2)
       STRING('Izdzçstas:'),AT(82,34),USE(?StringIERL)
       STRING(@n7B),AT(122,34),USE(raksti,,?RAKSTL)
       STRING('Izlaistias:'),AT(84,43),USE(?StringIZLL)
       STRING(@n7B),AT(122,43),USE(izlaisti,,?IZLAISTIL)
       STRING(@n7b),AT(162,23),USE(npk#,,?npk:2)
       STRING(@s40),AT(53,56),USE(SPIEDIET,,?SPIEDIETL)
       STRING(@s21),AT(75,23),USE(nom:nomenklat,,?nom:nomenklat:1L),HIDE
       BUTTON('&OK'),AT(150,69,43,14),USE(?Ok:L),DEFAULT
       BUTTON('&Atlikt'),AT(196,69,43,14),USE(?Cancel:L),DEFAULT
     END

!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------
Auto::Attempts       LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)



BRW1::View:Browse    VIEW(NOM_K)
                       PROJECT(NOM:BAITS2)
                       PROJECT(NOM:NOMENKLAT)
                       PROJECT(NOM:KODS)
                       PROJECT(NOM:KODS_PLUS)
                       PROJECT(NOM:NOS_P)
                       PROJECT(NOM:ANALOGS)
                       PROJECT(NOM:KATALOGA_NR)
                       PROJECT(NOM:PVN_PROC)
                       PROJECT(NOM:SKAITS_I)
                       PROJECT(NOM:NOS_A)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::NOM:BAITS2       LIKE(NOM:BAITS2)           ! Queue Display field
BRW1::NOM:NOMENKLAT    LIKE(NOM:NOMENKLAT)        ! Queue Display field
BRW1::NOM:KODS         LIKE(NOM:KODS)             ! Queue Display field
BRW1::NOM:KODS:NormalFG LONG                      ! Normal Foreground
BRW1::NOM:KODS:NormalBG LONG                      ! Normal Background
BRW1::NOM:KODS:SelectedFG LONG                    ! Selected Foreground
BRW1::NOM:KODS:SelectedBG LONG                    ! Selected Background
BRW1::NOM:KODS_PLUS    LIKE(NOM:KODS_PLUS)        ! Queue Display field
BRW1::NOM:KODS_PLUS:NormalFG LONG                 ! Normal Foreground
BRW1::NOM:KODS_PLUS:NormalBG LONG                 ! Normal Background
BRW1::NOM:KODS_PLUS:SelectedFG LONG               ! Selected Foreground
BRW1::NOM:KODS_PLUS:SelectedBG LONG               ! Selected Background
BRW1::NOM:NOS_P        LIKE(NOM:NOS_P)            ! Queue Display field
BRW1::NOM:NOS_P:NormalFG LONG                     ! Normal Foreground
BRW1::NOM:NOS_P:NormalBG LONG                     ! Normal Background
BRW1::NOM:NOS_P:SelectedFG LONG                   ! Selected Foreground
BRW1::NOM:NOS_P:SelectedBG LONG                   ! Selected Background
BRW1::NOM:ANALOGS      LIKE(NOM:ANALOGS)          ! Queue Display field
BRW1::NOM:KATALOGA_NR  LIKE(NOM:KATALOGA_NR)      ! Queue Display field
BRW1::cena             LIKE(cena)                 ! Queue Display field
BRW1::ARBYTE           LIKE(ARBYTE)               ! Queue Display field
BRW1::ARBYTE:NormalFG LONG                        ! Normal Foreground
BRW1::ARBYTE:NormalBG LONG                        ! Normal Background
BRW1::ARBYTE:SelectedFG LONG                      ! Selected Foreground
BRW1::ARBYTE:SelectedBG LONG                      ! Selected Background
BRW1::NOM:PVN_PROC     LIKE(NOM:PVN_PROC)         ! Queue Display field
BRW1::NOM:PVN_PROC:NormalFG LONG                  ! Normal Foreground
BRW1::NOM:PVN_PROC:NormalBG LONG                  ! Normal Background
BRW1::NOM:PVN_PROC:SelectedFG LONG                ! Selected Foreground
BRW1::NOM:PVN_PROC:SelectedBG LONG                ! Selected Background
BRW1::Pieejams         LIKE(Pieejams)             ! Queue Display field
BRW1::Atlikums         LIKE(Atlikums)             ! Queue Display field
BRW1::KRIT_DAU         LIKE(KRIT_DAU)             ! Queue Display field
BRW1::D_projekts       LIKE(D_projekts)           ! Queue Display field
BRW1::K_projekts       LIKE(K_projekts)           ! Queue Display field
BRW1::STATUSS          LIKE(STATUSS)              ! Queue Display field
BRW1::NOM:SKAITS_I     LIKE(NOM:SKAITS_I)         ! Queue Display field
BRW1::F:REDZAMIBA      LIKE(F:REDZAMIBA)          ! Queue Display field
BRW1::F:ATBILDIGAIS    LIKE(F:ATBILDIGAIS)        ! Queue Display field
BRW1::ACC_KODS_N       LIKE(ACC_KODS_N)           ! Queue Display field
BRW1::F:N              LIKE(F:N)                  ! Queue Display field
BRW1::LOC_NR           LIKE(LOC_NR)               ! Queue Display field
BRW1::N                LIKE(N)                    ! Queue Display field
BRW1::NOM:NOS_A        LIKE(NOM:NOS_A)            ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(NOM:KODS),DIM(100)
BRW1::Sort1:LowValue LIKE(NOM:KODS)               ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(NOM:KODS)              ! Queue position of scroll thumb
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort2:KeyDistribution LIKE(NOM:NOS_A),DIM(100)
BRW1::Sort2:LowValue LIKE(NOM:NOS_A)              ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(NOM:NOS_A)             ! Queue position of scroll thumb
BRW1::Sort3:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort3:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort4:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort4:KeyDistribution LIKE(NOM:KATALOGA_NR),DIM(100)
BRW1::Sort4:LowValue LIKE(NOM:KATALOGA_NR)        ! Queue position of scroll thumb
BRW1::Sort4:HighValue LIKE(NOM:KATALOGA_NR)       ! Queue position of scroll thumb
BRW1::Sort5:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort5:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort5:KeyDistribution LIKE(NOM:NOMENKLAT),DIM(100)
BRW1::Sort5:LowValue LIKE(NOM:NOMENKLAT)          ! Queue position of scroll thumb
BRW1::Sort5:HighValue LIKE(NOM:NOMENKLAT)         ! Queue position of scroll thumb
BRW1::QuickScan      BYTE                         ! Flag for Range/Filter test
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
QuickWindow          WINDOW('Browse the NOM_K File'),AT(-1,-1,462,295),FONT('MS Sans Serif',9,,FONT:bold),IMM,VSCROLL,HLP('BrowseNOM_K'),SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&5-Speciâlâs funkcijas'),USE(?Speciâlâsfunkcijas)
                           ITEM('&1-Atrast Cross-referenci'),USE(?AtrastCrossreferenci)
                           ITEM('&2-Atrast Nomenkl.,artikula fragmentu uz leju no izvçlçtâ ieraksta'),USE(?SpeciâlâsfunkcijasAtrastKESKU1),KEY(-6282)
                           ITEM('&3-Atrast pilnâ,saîsinâtâ nosaukuma fragmentu uz leju no izvçlçtâ ieraksta'),USE(?5Speciâlâsfunkcijas3AtrastKESKU2)
                           ITEM('&4-Atrast cenu'),USE(?5Speciâlâsfunkcijas3Atrastcenu)
                           ITEM('&5-Mainît ðî saraksta redzamîbas filtra nosacîjumus'),USE(?SpeciâlâsfunkcijasMainîtfiltranosacîjumus)
                           ITEM('&6-Nomenklatûru imports no citas DB (WinLats)'),USE(?impDB),DISABLE
                           ITEM('&7-Nomenklatûru imports no dbf'),USE(?5Speciâlâsfunkcijas5NomenklatûtuimportsnoWinLatsImpExpnomk2dbf)
                           ITEM('&8-Pârbûvçt NOM_K atslçgas'),USE(?PARBNOMK),DISABLE
                           ITEM('&9-Drukât svîtru kodu uzlîmes'),USE(?SpeciâlâsfunkcijasDrukâtsvîtrukoduuzlîmes)
                           ITEM('&A-Manît cenu'),USE(?Mcenu),DISABLE
                           ITEM('&B-Mainît uzcenojuma % 5.cenai'),USE(?5Speciâlâsfunkcijas8Mainîtuzcenojuma5cenai)
                           ITEM('&C-Mainît Stausu pret KA/Redzamîbu'),USE(?5Speciâlâsfunkcijas9MainîtStausupretKA)
                           ITEM('&D-Mainît PVN % un cenu'),USE(?5Speciâlâsfunkcijas0MainîtPVN)
                           ITEM('&E-Uzbûvçt i-neta failu'),USE(?5SpecialasfunkcijasINET),DISABLE
                           ITEM('&F-Mainît redzamîbu uz Likvidçjams visâm bez kustîbas un atlikuma'),USE(?SLIQUID),DISABLE
                           ITEM('&G-Pârbaudît un NODZEST likvidçjamâs'),USE(?LIQUID),DISABLE
                           ITEM('&H-Nomenklatûru imports no nom_k3.txt(tab)'),USE(?5SpeciâlâsfunkcijasHNomenklatûruimportsnotxt)
                           ITEM('&I-Pârrçíinât cenu uz EUR'),USE(?5SpeciâlâsfunkcijasIPârrçíinâtcenuuzEUR)
                           ITEM('&J-Noòemt "akcijas prece"'),USE(?NONEMTAKP),DISABLE
                           ITEM('&K-Nodzçst kritiskos un max atlikumus'),USE(?NODZESTKRMAXA),DISABLE
                         END
                         MENU('&2-Serviss'),USE(?2Serviss)
                           ITEM,SEPARATOR
                           ITEM('&2-DUP_KEY Checker (NOM_CHECKER.TXT)'),USE(?2Serviss3DUPKEYChecker),DISABLE
                         END
                       END
                       LIST,AT(6,21,450,238),USE(?Browse:1),IMM,VSCROLL,FONT('MS Sans Serif',9,,FONT:bold),MSG('Browsing Records'),FORMAT('12C|M~X~@n1B@87L(2)|M~Nomenklatûra~C(0)@s21@55R(1)M*~Kods~C(0)@n_13@6C|M*@s1@112' &|
   'L(1)|M*~Nosaukums~C(0)@s50@14L(1)|M~Alg~C(0)@s7@71L(1)|M~Artikuls(Kat.Nr)~C(0)@s' &|
   '22@33R(1)|M~Cena~C(0)@n-_9.2@10CM*@s1@10R(1)|M*~%~L(0)@n2@45R(1)|M~Pieejams~C@n-' &|
   '_11.3b@38R(1)|M~Atlikums~C@n-_11.3B@40R(1)|M~Krit.daudz.~C@n-10.2@39R(1)|M~D pro' &|
   'jekts~C@n-_11.3B@52R(1)|M~K projekts~C@n-_11.3B@10C|M~S~@s1@40L(1)|M~Sk.Iep.~@n-' &|
   '10.2@'),FROM(Queue:Browse:1)
                       BUTTON('&Ievadît'),AT(154,275,45,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(202,275,45,14),USE(?Change),DEFAULT
                       BUTTON('&Dzçst'),AT(250,275,45,14),USE(?Delete:2)
                       BUTTON('&X'),AT(6,260,14,13),USE(?ButtonX)
                       BUTTON('Apskatît ka&rtiòu'),AT(338,260,102,12),USE(?ButtonKartina)
                       BUTTON('&C-Kopçt'),AT(107,275,45,14),USE(?ButtonKopet)
                       BUTTON('In&formâcija'),AT(298,275,49,14),USE(?ButtonInformacija)
                       BUTTON('Iz&vçlçties'),AT(350,275,45,14),USE(?Select),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                       SHEET,AT(2,4,456,270),USE(?CurrentTab),COLOR(,COLOR:Lime)
                         TAB('&Nomenklatûru secîba'),USE(?Tab:1)
                           ENTRY(@S21),AT(22,260,86,12),USE(NOM:NOMENKLAT),FONT(,,,FONT:bold),OVR,UPR
                           STRING('-  pçc nomenklatûras'),AT(112,262),USE(?StringPecNom)
                           BUTTON('&Grupa'),AT(183,260,45,12),USE(?ButtonGrupa)
                           BUTTON('&ApakðGrupa'),AT(231,260,58,12),USE(?ButtonGrupa:2)
                         END
                         TAB('&Kodu secîba'),USE(?Tab:2)
                           ENTRY(@N_13B),AT(104,261,63,12),USE(NOM:KODS)
                           STRING('-pçc koda'),AT(168,262),USE(?String3)
                         END
                         TAB('No&saukumu secîba'),USE(?Tab:3)
                           ENTRY(@s8),AT(151,260,55,12),USE(NOM:NOS_A)
                           STRING('-pçc nosaukuma'),AT(213,262),USE(?String2)
                         END
                         TAB('Analogu(A&LG) secîba'),USE(?Tab:4)
                           STRING('Analogs:'),AT(222,262),USE(?StringAnalogs)
                           ENTRY(@s7),AT(257,260,46,12),USE(NOM:ANALOGS)
                         END
                         TAB('Ka&taloga Nr secîba'),USE(?Tab:5)
                           ENTRY(@s22),AT(175,260,83,12),USE(NOM:KATALOGA_NR),UPR,MSG('(RAZOTAJA KODS)')
                           STRING('-pçc kataloga Nr'),AT(267,263),USE(?StringKAT)
                         END
                       END
                       BUTTON('&Beigt'),AT(398,275,45,14),USE(?Close)
                       BUTTON('&Pasûtît'),AT(3,275,45,14),USE(?ButtonPasutit),HIDE
                       BUTTON('Piev. st&atistikai'),AT(50,275,55,14),USE(?ButtonPievStat),HIDE
                     END
  CODE
  PUSHBIND
  BIND('CONVERTREDZ',CONVERTREDZ)
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  FILENAME1='NOM_K.TPS'                !LAI TAS MUÏÍIS NELAMÂJAS
  checkopen(system,1)                  !Obligâti jâpârlasa
  IF ~F:REDZAMIBA THEN F:REDZAMIBA=13.  !1+4+8 AKTÎVAS + NÂKOTNES + LIKVIDÇJAMÂS
  IF BAND(F:REDZAMIBA,00000001B) THEN STRINGBYTE[8]='1'.
  IF BAND(F:REDZAMIBA,00000010B) THEN STRINGBYTE[7]='1'.
  IF BAND(F:REDZAMIBA,00000100B) THEN STRINGBYTE[6]='1'.
  IF BAND(F:REDZAMIBA,00001000B) THEN STRINGBYTE[5]='1'.
  F:N=0 !NERÂDÎT NEREDZAMÂS ÐAJÂ NOLIKTAVÂ
  N='N'
  IF ATLAUTS[1]='1' !SUPERACC
     ENABLE(?LIQUID)
  .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  ?BROWSE:1{PROP:FORMAT}=GETINI('BrowseNOM_K','?BROWSE:1 Format',?BROWSE:1{PROP:FORMAT},'WinLats.ini')
  IF ATLAUTS[1]='1' !SUPERACC
     ENABLE(?MCenu)
  !   ENABLE(?PARBNOMK)
     ENABLE(?IMPDB)
     ENABLE(?SLIQUID)
     ENABLE(?LIQUID)
     ENABLE(?NONEMTAKP)
     ENABLE(?NODZESTKRMAXA)
  .
  IF LOCALREQUEST=SELECTRECORD
     ?Change{PROP:DEFAULT}=''
     ?Select{PROP:DEFAULT}='1'
  .
  EXECUTE Last_nom_tab
     SELECT(?TAB:1)
     SELECT(?TAB:2)
     SELECT(?TAB:3)
     SELECT(?TAB:4)
     SELECT(?TAB:5)
  .
  !*******USER LEVEL ACCESS CONTROL********
  IF BAND(REG_NOL_ACC,01000000b) OR| !I-NETS
     ACC_KODS_N=0
     ENABLE(?5SpecialasfunkcijasINET)
  .
  ACCEPT
    F_REDZAMS='Redzamas:'
    IF BAND(F:REDZAMIBA,00000001B) THEN F_REDZAMS=F_REDZAMS&' Aktîvâs'.
    IF BAND(F:REDZAMIBA,00000010B) THEN F_REDZAMS=F_REDZAMS&' Arhîva'.
    IF BAND(F:REDZAMIBA,00000100B) THEN F_REDZAMS=F_REDZAMS&' Nâkotnes'.
    IF BAND(F:REDZAMIBA,00001000B) THEN F_REDZAMS=F_REDZAMS&' Likvidçjamâs'.
    IF F:N THEN F_REDZAMS=F_REDZAMS&' Neredzamâs'.
    IF F:ATBILDIGAIS
       F_ATBILDIGAIS=ACC_KODS
    ELSE
       F_ATBILDIGAIS='Nav'
    .
    QUICKWINDOW{PROP:TEXT}='Nomenklatûru saraksts. '&CLIP(RECORDS(nom_k))&' raksti. '&F_REDZAMS&'. Atbildîgais: '&F_ATBILDIGAIS
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
      IF NOMENKLAT
         CLEAR(NOM:RECORD)
         NOM:NOMENKLAT=NOMENKLAT
         SET(NOM:NOM_KEY,NOM:NOM_KEY)
         NEXT(NOM_K)
      !   DO BRW1::Reset
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
      !   DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         IF LAST_NOM_TAB=2 !KODU SECÎBA
            SELECT(?NOM:KODS)
         ELSE
            SELECT(?Browse:1)
         .
         DO RefreshWindow
      .
      IF LOC_NR
         UNHIDE(?ButtonPievStat)
         UNHIDE(?ButtonPASUTIT)
      .
      ?Browse:1{PROPLIST:HEADER,8}=CLIP(NOKL_CP)&'/'&CLIP(NOKL_CA)&'.Cena'
      IF LOC_NR
         ?Browse:1{PROPLIST:HEADER,11}='Pieejams('&clip(loc_nr)&')'
      ELSE
         ?Browse:1{PROPLIST:HEADER,11}='Pieejams(V)'
      .
      ?5SpecialasfunkcijasINET{PROP:TEXT}='&E-Uzbûvçt '&CLIP(LONGPATH())&'\INET\NOM_K.TXT'
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
    CASE ACCEPTED()
    OF ?AtrastCrossreferenci
      DO SyncWindow
      GlobalRequest = SelectRecord
      BrowseCrossref 
      LocalRequest = OriginalRequest
      DO RefreshWindow
      IF GLOBALRESPONSE=REQUESTCOMPLETED
         NOM:NOMENKLAT=NOMENKLAT
         GET(NOM_K,NOM:NOM_KEY)
         LocalRequest = OriginalRequest
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         DO BRW1::RefreshPage
      .
    OF ?SpeciâlâsfunkcijasAtrastKESKU1
      DO SyncWindow
      SEARCHMODE=1
      DO SEARCHKESKA
    OF ?5Speciâlâsfunkcijas3AtrastKESKU2
      DO SyncWindow
      SEARCHMODE=2
      DO SEARCHKESKA
    OF ?5Speciâlâsfunkcijas3Atrastcenu
      DO SyncWindow
       SUMMA_W(2)
       IF GLOBALRESPONSE=REQUESTCOMPLETED
         DO SyncWindow
         SET(NOM:NOM_KEY,NOM:NOM_KEY)
         FOUND#=0
      !   S_SUMMA=SUMMA
         LOOP
            NEXT(NOM_K)
            IF ERROR() THEN BREAK.
      !      IF GG:RS='1' AND ATLAUTS[18]='1' THEN CYCLE.                        !REDZAMÎBAS FILTRS
      !      STOP(NOM:REALIZ[NOKL_CP]&'='&SUMMA&' '&NOM:VAL[NOKL_CP]&'='&VAL_NOS)
      !      IF NOM:REALIZ[NOKL_CP]=SUMMA AND NOM:VAL[NOKL_CP]=VAL_NOS            !ATRAST TEKOÐO CENU
            IF NOM:REALIZ[NOKL_CP]=SUMMA                                          !ATRAST TEKOÐO CENU
               GLOBALREQUEST=0
               UPDATENOM_K
               FOUND#=1
               BREAK
            .
         .
         IF ~FOUND#
            KLUDA(34,SUMMA)
         ELSE
            LocalRequest = OriginalRequest
            BRW1::LocateMode = LocateOnEdit
            DO BRW1::LocateRecord
            DO BRW1::InitializeBrowse
            DO BRW1::PostNewSelection
            DO BRW1::RefreshPage
         .
       .
      
    OF ?SpeciâlâsfunkcijasMainîtfiltranosacîjumus
      DO SyncWindow
      SAV:REDZAMIBA=F:REDZAMIBA
      SAV:atbildigais=F:atbildigais
      SAV:N=F:N
      open(filtrsscreen)
      display
      accept
         case field()
         OF ?OK:F
            case event()
            of event:accepted
               IF ~STRINGBYTE 
                  BEEP
                  CYCLE
               ELSE
                  break
               .
            .
         .
      .
      F:REDZAMIBA=0
      LOOP B#=1 TO 8
         IF STRINGBYTE[9-B#]
            F:REDZAMIBA+=2^(B#-1)
         .
      .
      close(filtrsscreen)
      IF ~(SAV:REDZAMIBA=F:REDZAMIBA AND SAV:atbildigais=F:atbildigais AND SAV:N=F:N)
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
      
    OF ?impDB
      DO SyncWindow
           KLUDA(0,'tiks importçtas visas nomenklatûras, kas neveido dubultas atslçgas no izvçlçtâs DB')
           LOCAL_path=PATH()
           Filename1=''
           SPIEDIET=''
           izlaisti=0
           raksti=0
           IF FILEDIALOG('Izvçlaties failu',FileName1,'Nomenklatûras|NOM_K.TPS',0)
              setpath(local_path)
              open(showscreen)
              CLOSE(nom_K1)
              CHECKOPEN(nom_K1,1)
              CLOSE(NOM_K)
              OPEN(NOM_K,12h)
              IF ERROR()
                 KLUDA(1,'NOM_K')
                 CHECKOPEN(NOM_K,1)
              ELSE
                 WriteZurnals(2,0,'Nomenklatûru imports no '&FILENAME1)
                 set(nom_K1)
                 loop
                    next(nom_K1)
                    if error() then break.
                    NOM:RECORD=NOM1:RECORD
                    if duplicate(NOM_K)
                      izlaisti+=1
                      WriteZurnals(2,0,'Izlaiþu rakstu NOM_K '&CHR(9)&CLIP(NOM:NOMENKLAT)&CHR(9)&NOM:KODS&CHR(9)&CLIP(NOM:NOS_P))
                    else
                      ADD(nom_K)
                      raksti+=1
                    .
                    display
                 .
                 build(NOM_K)
                 CLOSE(NOM_K)
                 CHECKOPEN(NOM_K,1)
                 SPIEDIET='Spiediet jebkuru taustiòu, lai turpinâtu'
                 display
                 ask
                 WriteZurnals(2,0,'Kopâ ierakstîtas '&raksti&' jaunas Nomenklatûras')
                 close(showscreen)
               !  IF GlobalResponse = RequestCompleted
                   BRW1::LocateMode = LocateOnEdit
                   DO BRW1::LocateRecord
               !  ELSE
               !   BRW1::RefreshMode = RefreshOnQueue
                  DO BRW1::RefreshPage
                  DO BRW1::InitializeBrowse
                  DO BRW1::PostNewSelection
                  SELECT(?Browse:1)
                  LocalRequest = OriginalRequest
                  LocalResponse = RequestCancelled
                  DO RefreshWindow
              .
           END
    OF ?5Speciâlâsfunkcijas5NomenklatûtuimportsnoWinLatsImpExpnomk2dbf
      DO SyncWindow
        KLUDA(0,'...tiks importçtas visas nomenklatûras no ...\ImpExp\nom_k2.dbf')
        Filename1=CLIP(PATH())&'\ImpExp\nom_k2.dbf'
        mainiti=0
        izlaisti=0
        raksti=0
        DKRAKSTI#   =0
        AUTONUMBERD#=FALSE
        AUTONUMBERK#=FALSE
        open(showscreen)
        display
        CLOSE(nom_K2)
        OPEN(nom_K2)
        IF ERROR()
           KLUDA(0,'FAILS '&FILENAME1&' NAV ATRASTS')
           close(showscreen)
        ELSE
           CLOSE(NOM_K)
           OPEN(NOM_K,12h)
           IF ERROR()
              KLUDA(1,'NOM_K')
              CHECKOPEN(NOM_K,1)
           ELSE
              WriteZurnals(2,0,'Nomenklatûru imports no '&FILENAME1)
              set(nom_K2)
              loop
      !           JJ#+=1
                 next(nom_K2)
      !           if error() OR JJ#>5 then break.
                 if error() then break.
                 JAUNA_NOMENKLATURA#=FALSE
                 JAUNS_KODS#=FALSE
                 SAV_DAUDZUMS=0
                 UPDATETEXT=''
                 CLEAR(NOM:RECORD)
                 NOM:NOMENKLAT=NOM2:NOM
                 GET(NOM_K,NOM:NOM_KEY)
                 IF ERROR()     !JAUNA NOMENKLATÛRA
                    JAUNA_NOMENKLATURA#=TRUE
                 .
                 CLEAR(NOM:RECORD)
                 NOM:KODS=NOM2:EAN
                 GET(NOM_K,NOM:KOD_KEY)
                 IF ERROR()     !JAUNS KODS
                    JAUNS_KODS#=TRUE
                 .
                 IF JAUNA_NOMENKLATURA#=TRUE AND JAUNS_KODS#=TRUE
                    ACTION#=1
                 ELSIF JAUNA_NOMENKLATURA#=TRUE AND JAUNS_KODS#=FALSE
                    NOM:KODS=0  !NULLÇJAM VAIRS NEVAJADZÎGÂS NOMENKLATÛRAS KODU
                    IF RIUPDATE:NOM_K()
                       UPDATETEXT='nullçjot EAN'
                       KLUDA(24,'NOM_K:'&NOM:NOMENKLAT&' F:'&UPDATETEXT)
                    .
                    ACTION#=1
                    IF CL_NR=1026   !MEDEX
                       SAV_DAUDZUMS=GETNOM_A('POZICIONÇTS',1,0) !ATLIKUMS
                       IF SAV_DAUDZUMS !IR ATLIKUMS
                          IF AUTONUMBERD#=FALSE
                             DO AUTONUMBER
                             AUTONUMBERD#=TRUE
                             PAV:DOKDAT=TODAY()
                             PAV:D_K='D'
                             PAV:NODALA=SYS:NODALA
                             PAV:PAR_NR=26 !RAÞOÐANA
                             PAV:NOKA='Raþoðana'
                             PAV:PAMAT='Nomenklatûras maiòa'
                             PAV:SUMMA=0
                          .
                          CLEAR(NOL:RECORD)
                          NOL:U_NR=PAV:U_NR
                          NOL:DATUMS=PAV:DATUMS
                          NOL:NOMENKLAT=NOM2:NOM  !JAUNÂ NOMENKLATÛRA
                          NOL:PAR_NR=PAV:PAR_NR
                          NOL:D_K=PAV:D_K
                          NOL:RS=PAV:RS
                          NOL:DAUDZUMS=SAV_DAUDZUMS
                          NOL:SUMMA=NOL:DAUDZUMS*NOM:PIC
                          SAV_DAUDZUMS=NOL:DAUDZUMS
                          SAV_SUMMA=NOL:SUMMA
                          NOL:SUMMAV=NOL:SUMMA
                          PAV:SUMMA+=NOL:SUMMA
                          NOL:VAL='Ls'
                          ADD(NOLIK)
                          IF ERROR()
                             STOP('ADD NOLIK:'&ERROR())
                          ELSE
                             AtlikumiN('D',NOM:NOMENKLAT,SAV_DAUDZUMS,'','',0) !UZBÛVÇS NOM_A
                             KopsN(NOM:NOMENKLAT,TODAY(),'D')
                          .
                          PUT(PAVAD)
      
                          IF AUTONUMBERK#=FALSE
                             DO AUTONUMBER
                             AUTONUMBERK#=TRUE
                             PAV:D_K='K'
                             PAV:DOKDAT=TODAY()
                             PAV:PAR_NR=26 !RAÞOÐANA
                             PAV:NODALA=SYS:NODALA
                             PAV:NOKA='Raþoðana'
                             PAV:PAMAT='Nomenklatûras maiòa'
                             PAV:SUMMA=0
                          .
                          NOL:U_NR=PAV:U_NR
                          NOL:DATUMS=PAV:DATUMS
                          NOL:NOMENKLAT=NOM:NOMENKLAT !VECÂ NOMENKLATÛRA
                          NOL:PAR_NR=PAV:PAR_NR
                          NOL:D_K=PAV:D_K
                          NOL:RS=PAV:RS
                          NOL:DAUDZUMS=SAV_DAUDZUMS
                          NOL:SUMMA=SAV_SUMMA
                          NOL:SUMMAV=NOL:SUMMA
                          PAV:SUMMA+=NOL:SUMMA
                          NOL:VAL='Ls'
                          ADD(NOLIK)
                          IF ERROR()
                             STOP('ADD NOLIK:'&ERROR())
                          ELSE
                             AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
                             KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
                          .
                          PUT(PAVAD)
                          DKRAKSTI#+=1
                       .
                    .
                 ELSIF JAUNA_NOMENKLATURA#=FALSE AND JAUNS_KODS#=TRUE
                    CLEAR(NOM:RECORD)
                    NOM:NOMENKLAT=NOM2:NOM
                    GET(NOM_K,NOM:NOM_KEY)
                    ACTION#=2
                    UPDATETEXT='mainu EAN'
                 ELSE
                    UPDATETEXT='mainu ~KEY laukus'
                    IF NOM:KATALOGA_NR=NOM2:KATALOGA_NR AND|
                       NOM:EAN        =NOM2:EAN_TEST AND|
                       NOM:KODS       =NOM2:EAN AND|
                       NOM:TIPS       =NOM2:TIPS AND|
                       NOM:BKK        =NOM2:BKK AND|
                       NOM:PVN_PROC   =NOM2:PVNLIKME AND|
                       NOM:NOS_P      =NOM2:NOS_P AND|
                       NOM:NOS_S      =NOM2:NOS_S AND|
                       NOM:REDZAMIBA  =NOM2:REDZAMS
                       izlaisti+=1
                       ACTION#=0
                    ELSE
                       ACTION#=2
                    .
                 .
                 NOM:NOMENKLAT  =NOM2:NOM
                 NOM:KODS       =NOM2:EAN
                 NOM:KATALOGA_NR=NOM2:KATALOGA_NR
                 NOM:EAN        =NOM2:EAN_TEST
                 NOM:KODS       =NOM2:EAN
                 NOM:TIPS       =NOM2:TIPS
                 NOM:BKK        =NOM2:BKK
                 NOM:PVN_PROC   =NOM2:PVNLIKME
                 NOM:NOS_P      =NOM2:NOS_P
                 NOM:NOS_S      =NOM2:NOS_S
                 NOM:NOS_A      =INIGEN(NOM:NOS_P,8,1)
                 NOM:REDZAMIBA  =NOM2:REDZAMS
                 NOM:ACC_KODS   =ACC_KODS
                 NOM:ACC_DATUMS =TODAY()
                 CASE ACTION#
                 OF 1
                    NOM:MERVIEN    ='gab.'
                    IF NOM2:CENA_L
                       NOM:BAITS1=4
                    .
                    NOM:ARPVNBYTE=31 !VISAS AR PVN
                    NOM:STATUSS='0{25}'
                    ADD(nom_K)
                    IF ERROR()
                       KLUDA(0,'Kïûda rakstot '&nom:nomenklat&' '&ERROR())
                    .
      !              I#=GETNOM_A(NOM:NOMENKLAT,9,1) !IEVADÎÐANA
                    raksti+=1
                    WriteZurnals(2,0,'Ievadu rakstu NOM_K '&CHR(9)&CLIP(NOM:NOMENKLAT)&CHR(9)&NOM:KODS&CHR(9)&CLIP(NOM:NOS_P))
                 OF 2
                    IF RIUPDATE:NOM_K()
                       KLUDA(24,'NOM_K:'&NOM:NOMENKLAT&' F:'&UPDATETEXT)
                    .
                    WriteZurnals(2,0,'Mainu NOM_K '&CHR(9)&CLIP(NOM:NOMENKLAT)&CHR(9)&NOM:KODS&CHR(9)&CLIP(NOM:NOS_P))
                    MAINITI+=1
                 .
                 display
              .
      !        UNHIDE(?BUVEJU_A)
      !        DISPLAY
      !        build(NOM_K)
              CLOSE(NOM_K)
              CHECKOPEN(NOM_K,1)
              CLOSE(NOM_K2)
              REMOVE(NOM_K2)
              SPIEDIET='Spiediet jebkuru taustiòu, lai turpinâtu'
              IF DKRAKSTI#
                 UNHIDE(?StringDKPZ)
              .
              display
              ask
              WriteZurnals(2,0,'Kopâ ierakstîtas '&raksti&' jaunas Nomenklatûras')
              close(showscreen)
            !  IF GlobalResponse = RequestCompleted
                BRW1::LocateMode = LocateOnEdit
                DO BRW1::LocateRecord
            !  ELSE
            !   BRW1::RefreshMode = RefreshOnQueue
               DO BRW1::RefreshPage
               DO BRW1::InitializeBrowse
               DO BRW1::PostNewSelection
               SELECT(?Browse:1)
               LocalRequest = OriginalRequest
               LocalResponse = RequestCancelled
               DO RefreshWindow
            .
        .
    OF ?PARBNOMK
      DO SyncWindow
    OF ?SpeciâlâsfunkcijasDrukâtsvîtrukoduuzlîmes
      DO SyncWindow
      AI_SK_WRITE(ROUND(ATLIKUMS,1))
    OF ?Mcenu
      DO SyncWindow
      open(cenascreen)
      cena_nr=NOKL_CP
      IF ~INRANGE(CENA_NR,1,5)
         CENA_NR=1
      .
      CENA_TO=CENA_NR
      PROCLS=0
      CHANGED#=0
      F:DTK=''
      display
      accept
         case field()
         OF ?BUTTON:P !NOAPAÏOT UZ AUGÐU
            case event()
            of event:accepted
               IF F:DTK
                  F:DTK=''
                  HIDE(?IMAGE:P)
               ELSE
                  F:DTK='1'
                  UNHIDE(?IMAGE:P)
               .
               DISPLAY
            .
         OF ?OK:C
            case event()
            of event:accepted
               IF ~INRANGE(CENA_NR,1,6)
                  SELECT(?CENA_NR)
                  CYCLE
               .
               IF ~INRANGE(CENA_TO,1,6)
                  SELECT(?CENA_TO)
                  CYCLE
               .
               !IF NOMENKLAT
                  !IF PLUSPROC OR ~(CENA_NR=CENA_TO) !LAI VAR PÂRRAKSTÎT NO VIENAS UZ OTRU
                     JB#=1
                     CLEAR(NOM:RECORD)
                     !NOM:NOMENKLAT=NOMENKLAT
                     IF NOMENKLAT
                        NOM:NOMENKLAT=NOMENKLAT
                     .

                     SET(NOM:NOM_KEY,NOM:NOM_KEY)
                     LOOP
                        NEXT(NOM_K)
                        IF ERROR() OR CYCLENOM(NOM:NOMENKLAT)=2 THEN BREAK.
                        IF CYCLENOM(NOM:NOMENKLAT)=1 THEN CYCLE.
                        IF CENA_NR=6
                           SAV_CENA=NOM:PIC
                        ELSE
                           SAV_CENA=NOM:REALIZ[CENA_NR]
                        .
                        IF ~PROCLS !%
                           IF CENA_TO=6           !PIC
                              EXECUTE ZIMES-1
                                 BEGIN
                                    NOM:PIC=ROUND(SAV_CENA*(1+PLUSPROC/100),.01)
                                    IF NOM:PIC=SAV_CENA AND F:DTK  !NOAPAÏOT UZ AUGÐU, JA SANÂK 0
                                       IF PLUSPROC > 0
                                          NOM:PIC+=0.01
                                       ELSE
                                          NOM:PIC-=0.01
                                       .
                                    .
                                 .
                                 NOM:PIC=ROUND(SAV_CENA*(1+PLUSPROC/100),.001)
                                 NOM:PIC=ROUND(SAV_CENA*(1+PLUSPROC/100),.0001)
                              .
                           ELSE
                              EXECUTE ZIMES-1
                                 BEGIN
                                    NOM:REALIZ[CENA_TO]=ROUND(SAV_CENA*(1+PLUSPROC/100),.01)
                                    IF NOM:REALIZ[CENA_TO]=SAV_CENA AND F:DTK  !NOAPAÏOT UZ AUGÐU, JA SANÂK 0
                                       IF PLUSPROC > 0
                                          NOM:REALIZ[CENA_TO]+=0.01
                                       ELSE
                                          NOM:REALIZ[CENA_TO]-=0.01
                                       .
                                    .
                                 .
                                 NOM:REALIZ[CENA_TO]=ROUND(SAV_CENA*(1+PLUSPROC/100),.001)
                                 NOM:REALIZ[CENA_TO]=ROUND(SAV_CENA*(1+PLUSPROC/100),.0001)
                              .
                           .
                        ELSE
                           NOM:REALIZ[CENA_TO]=SAV_CENA+PLUSPROC
                        .
                        IF RIUPDATE:NOM_K()
                           KLUDA(24,'NOM_K: '&NOM:NOMENKLAT)
                        ELSE
                           CHANGED#+=1
                           DISPLAY
                           IF CENA_TO=6           !PIC
                              MC=CHR(9)&'Cena'&CLIP(CENA_TO)&CHR(9)&'no'&CHR(9)&SAV_CENA&CHR(9)&'uz'&CHR(9)&NOM:PIC
                           ELSE
                              MC=CHR(9)&'Cena'&CLIP(CENA_TO)&CHR(9)&'no'&CHR(9)&SAV_CENA&CHR(9)&'uz'&CHR(9)&|
                              NOM:REALIZ[CENA_TO]
                           .
                           WriteZurnals(2,2,'NOM_K '&CHR(9)&CLIP(NOM:NOMENKLAT)&CHR(9)&CLIP(NOM:NOS_S)&MC)
                        .
                     .
!                  .
!               ELSE
!                  KLUDA(0,'Nav norâdîts filtrs pçc NOMENKLATÛRAS...')
!                  SELECT(?NOMENKLAT)
!                  CYCLE
!               .
               BREAK
            .
         OF ?CANCEL:C
            case event()
            of event:accepted
               BREAK
            .
         .
      .
      close(CENAscreen)
      IF JB#=1
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
    OF ?5Speciâlâsfunkcijas8Mainîtuzcenojuma5cenai
      DO SyncWindow
      open(procscreen)
      F:DTK=''
      display
      accept
         case field()
         OF ?OK:P
            case event()
            of event:accepted
               IF NOMENKLAT
                  JB#=1
                  CLEAR(NOM:RECORD)
                  SET(NOM:NOM_KEY,NOM:NOM_KEY)
                  NOM:NOMENKLAT=NOMENKLAT
                  SET(NOM:NOM_KEY,NOM:NOM_KEY)
                  LOOP
                     NEXT(NOM_K)
                     IF ERROR() OR CYCLENOM(NOM:NOMENKLAT)=2 THEN BREAK.
                     IF CYCLENOM(NOM:NOMENKLAT)=1 THEN CYCLE.
      
      !               IF CL_NR=1000     !AIGAS NAMS - JÂSAGLABÂ Ls PÇC TESTA KURSA BEZ PVN * PROC5
      !                  PIEKTA=NOM:REALIZ[5]/(1+NOM:PROC5/100)
      !                  NOM:REALIZ[5]=PIEKTA*(1+PLUSPROC/100)
      !               .
      
                     NOM:PROC5=PLUSPROC
                     IF RIUPDATE:NOM_K()
                        KLUDA(24,'NOM_K')
                     .
                  .
                  BREAK
               ELSE
                  SELECT(?NOMENKLAT)
                  CYCLE
               .
            .
         OF ?CANCEL:P
            case event()
            of event:accepted
               BREAK
            .
         .
      .
      close(PROCscreen)
      IF JB#=1
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
    OF ?5Speciâlâsfunkcijas9MainîtStausupretKA
      DO SyncWindow
      OPEN(STATUSSCREEN)
      JB#=0
      DISPLAY
      ACCEPT
         case field()
         OF ?OK:S
            case event()
            of event:accepted
               JB#=0
               CLEAR(NOM:RECORD)
               SET(NOM:NOM_KEY,NOM:NOM_KEY)
               NOM:NOMENKLAT=NOMENKLAT
               SET(NOM:NOM_KEY,NOM:NOM_KEY)
               LOOP
                  NEXT(NOM_K)
                  IF ERROR() OR CYCLENOM(NOM:NOMENKLAT)=2 THEN BREAK.
                  IF CYCLENOM(NOM:NOMENKLAT)=1 THEN CYCLE.
                  IF ~(NOM:STATUSS[LOC_NR]=OLD_STATUSS) THEN CYCLE.
                  JB#+=1
                  DISPLAY(?JB#)
                  NOM:STATUSS[LOC_NR]=NEW_STATUSS
                  IF RIUPDATE:NOM_K()
                     KLUDA(24,'NOM_K')
                  .
               .
               BREAK
            .
         OF ?CANCEL:S
            case event()
            of event:accepted
               BREAK
            .
         .
      .
      close(STATUSSCREEN)
      IF JB#
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
    OF ?5Speciâlâsfunkcijas0MainîtPVN
      DO SyncWindow
!      OPEN(PVNSCREEN)
!      JP#=0
!      PR=0
!      DISPLAY
!      ACCEPT
!         case field()
!      
!      
!         OF ?BUTTON:PR
!            case event()
!            of event:accepted
!               IF PR
!                  PR = 0
!                  HIDE(?IMAGE:PR)
!               ELSE
!                  PR = 1
!                  UNHIDE(?IMAGE:PR)
!               END
!               DISPLAY
!         .
!         OF ?OK:PVN
!            case event()
!            of event:accepted
!               IF OLD_PVN=NEW_PVN
!                  BEEP
!                  CYCLE
!               .
!               CLEAR(NOM:RECORD)
!               SET(NOM:NOM_KEY,NOM:NOM_KEY)
!               NOM:NOMENKLAT=NOMENKLAT
!               SET(NOM:NOM_KEY,NOM:NOM_KEY)
!               LOOP
!                  NEXT(NOM_K)
!                  IF ERROR() OR CYCLENOM(NOM:NOMENKLAT)=2 THEN BREAK.
!                  IF CYCLENOM(NOM:NOMENKLAT)=1 THEN CYCLE.
!                  IF OLD_PVN=1 AND BAND(NOM:BAITS1,00000010b)    !AR PVN NEAPLIEKAMS
!                     NOM:BAITS1-=2
!                     NOM:PVN_PROC=NEW_PVN
!                     JP#+=1
!                     DISPLAY(?JP#)
!                     IF RIUPDATE:NOM_K()
!                        KLUDA(24,'NOM_K')
!                     .
!                  ELSIF NOM:PVN_PROC=OLD_PVN
!                     IF NEW_PVN=1 !AR PVN NEAPLIEKAMS
!                        IF ~BAND(NOM:BAITS1,00000010b)    !~AR PVN NEAPLIEKAMS
!                           NOM:BAITS1+=2
!                           NOM:PVN_PROC=0
!                        .
!                     ELSE
!                        IF PR !JÂPÂRRÇÍINA CENA
!                           IF BAND(NOM:ARPVNBYTE,00000001b)
!                              NOM:REALIZ[1]=NOM:REALIZ[1]/(1+NOM:PVN_PROC/100)
!                              NOM:REALIZ[1]=ROUND(NOM:REALIZ[1]*(1+NEW_PVN/100),.01)
!                           .
!                           IF BAND(NOM:ARPVNBYTE,00000010b)
!                              NOM:REALIZ[2]=NOM:REALIZ[2]/(1+NOM:PVN_PROC/100)
!                              NOM:REALIZ[2]=ROUND(NOM:REALIZ[2]*(1+NEW_PVN/100),.01)
!                           .
!                           IF BAND(NOM:ARPVNBYTE,00000100b)
!                              NOM:REALIZ[3]=NOM:REALIZ[3]/(1+NOM:PVN_PROC/100)
!                              NOM:REALIZ[3]=ROUND(NOM:REALIZ[3]*(1+NEW_PVN/100),.01)
!                           .
!                           IF BAND(NOM:ARPVNBYTE,00001000b)
!                              NOM:REALIZ[4]=NOM:REALIZ[4]/(1+NOM:PVN_PROC/100)
!                              NOM:REALIZ[4]=ROUND(NOM:REALIZ[4]*(1+NEW_PVN/100),.01)
!                           .
!                           IF BAND(NOM:ARPVNBYTE,00010000b)
!                              NOM:REALIZ[5]=NOM:REALIZ[5]/(1+NOM:PVN_PROC/100)
!                              NOM:REALIZ[5]=ROUND(NOM:REALIZ[5]*(1+NEW_PVN/100),.01)
!                           .
!                        .
!                        NOM:PVN_PROC=NEW_PVN
!                     .
!                     JP#+=1
!                     DISPLAY(?JP#)
!                     IF RIUPDATE:NOM_K()
!                        KLUDA(24,'NOM_K')
!                     .
!                  .
!               .
!               KLUDA(0,'mainîtas '&JP#&' nomenklatûras',,1)
!               BREAK
!            .
!         OF ?CANCEL:PVN
!            case event()
!            of event:accepted
!               BREAK
!            .
!         .
!      .
!      close(PVNSCREEN)
!Elya 17/06/2012 <
      CiparuSk = 4
      OPEN(PVNSCREEN1)
      JP#=0
      PR=0
      DISPLAY
      ACCEPT
         case field()
      
      
         OF ?BUTTON:PR_1
            case event()
            of event:accepted
               IF PR
                  PR = 0
                  HIDE(?IMAGE:PR_1)
                  HIDE(?NoapCipari)
                  HIDE(?NoapCapari_)
                  HIDE(?Noapolot)
                  HIDE(?Noapolot:Radio1)
                  HIDE(?Noapolot:Radio2)
                  HIDE(?CiparuSk:P)
               ELSE
                  PR = 1
                  UNHIDE(?CiparuSk:P)
                  UNHIDE(?IMAGE:PR_1)
                  UNHIDE(?NoapCipari)
                  UNHIDE(?NoapCapari_)
                  UNHIDE(?Noapolot)
                  UNHIDE(?Noapolot:Radio1)
                  UNHIDE(?Noapolot:Radio2)
               END
               DISPLAY
         .
         OF ?old_pvn_1:P
            case event()
            of event:accepted
               IF old_pvn_1 = 1
                  HIDE(?PVNlikme:P)
               ELSE
                  UNHIDE(?PVNlikme:P)
               END
               DISPLAY
            .
         OF ?new_pvn_1:P
            case event()
            of event:accepted
               IF new_pvn_1 = 1
                  HIDE(?new_PVNlikme:P)
               ELSE
                  UNHIDE(?new_PVNlikme:P)
               END
               DISPLAY
            .
         OF ?OK:PVN_1
            case event()
            of event:accepted
               IF (OLD_PVN_1=NEW_PVN_1 AND OLD_PVN_1 =1) OR (OLD_PVN_1=NEW_PVN_1 AND ~OLD_PVN_1 =1 AND new_PVNlikme = PVNlikme)
                  BEEP
                  CYCLE
               .
               CLEAR(NOM:RECORD)
               SET(NOM:NOM_KEY,NOM:NOM_KEY)
               NOM:NOMENKLAT=NOMENKLAT
               SET(NOM:NOM_KEY,NOM:NOM_KEY)
               LOOP
                  NEXT(NOM_K)
                  IF ERROR() OR CYCLENOM(NOM:NOMENKLAT)=2 THEN BREAK.
                  IF CYCLENOM(NOM:NOMENKLAT)=1 THEN CYCLE.
                  IF OLD_PVN_1=1 AND BAND(NOM:BAITS1,00000010b)    !AR PVN NEAPLIEKAMS
                     NOM:BAITS1-=2
                     NOM:PVN_PROC=new_PVNlikme
                     JP#+=1
                     DISPLAY(?JP#)
                     IF RIUPDATE:NOM_K()
                        KLUDA(24,'NOM_K')
                     .
                  ELSIF NOM:PVN_PROC=PVNlikme
                     IF NEW_PVN_1=1 !AR PVN NEAPLIEKAMS
                        IF ~BAND(NOM:BAITS1,00000010b)    !~AR PVN NEAPLIEKAMS
                           NOM:BAITS1+=2
                           NOM:PVN_PROC=0
                        .
                     ELSE
                        IF PR !JÂPÂRRÇÍINA CENA
                           IF CiparuSk = 0
                              Order_ = 1
                              Plus = 0.9
                              Multiply = 1
                           ELSIF CiparuSk = 1
                              Order_ = 0.1
                              Plus = 0.09
                              Multiply = 10
                           ELSIF CiparuSk = 2
                              Order_ = 0.01
                              Plus = 0.009
                              Multiply = 100
                           ELSIF CiparuSk = 3
                              Order_ = 0.001
                              Plus = 0.0009
                              Multiply = 1000
                           ELSIF CiparuSk = 4
                              Order_ = 0.0001
                              Plus = 0.00009
                              Multiply = 10000
                           END
                           IF BAND(NOM:ARPVNBYTE,00000001b)
                              REALIZ=NOM:REALIZ[1]/(1+NOM:PVN_PROC/100)
                              IF Noapolot = 0
                                NOM:REALIZ[1]=ROUND(REALIZ*(1+new_PVNlikme/100),Order_)
                              ELSE
                                NOM:REALIZ[1]=INT((REALIZ*(1+new_PVNlikme/100)+ Plus)*Multiply)/Multiply
                              END
                           .
                           IF BAND(NOM:ARPVNBYTE,00000010b)
                              REALIZ=NOM:REALIZ[2]/(1+NOM:PVN_PROC/100)
                              IF Noapolot = 0
                                 NOM:REALIZ[2]=ROUND(REALIZ*(1+new_PVNlikme/100),Order_)
                              ELSE
                                 NOM:REALIZ[2]=INT((REALIZ*(1+new_PVNlikme/100)+ Plus)*Multiply)/Multiply
                              END
                           .
                           IF BAND(NOM:ARPVNBYTE,00000100b)
                              REALIZ=NOM:REALIZ[3]/(1+NOM:PVN_PROC/100)
                              IF Noapolot = 0
                                 NOM:REALIZ[3]=ROUND(REALIZ*(1+new_PVNlikme/100),Order_)
                              ELSE
                                 NOM:REALIZ[3]=INT((REALIZ*(1+new_PVNlikme/100)+ Plus)*Multiply)/Multiply
                              END
                           .
                           IF BAND(NOM:ARPVNBYTE,00001000b)
                              REALIZ=NOM:REALIZ[4]/(1+NOM:PVN_PROC/100)
                              IF Noapolot = 0
                                 NOM:REALIZ[4]=ROUND(REALIZ*(1+new_PVNlikme/100),Order_)
                              ELSE
                                 NOM:REALIZ[4]=INT((REALIZ*(1+new_PVNlikme/100)+ Plus)*Multiply)/Multiply
                              END
                           .
                           IF BAND(NOM:ARPVNBYTE,00010000b)
                              REALIZ=NOM:REALIZ[5]/(1+NOM:PVN_PROC/100)
                              IF Noapolot = 0
                                 NOM:REALIZ[5]=ROUND(REALIZ*(1+new_PVNlikme/100),Order_)
                              ELSE
                                 NOM:REALIZ[5]=INT((REALIZ*(1+new_PVNlikme/100)+ Plus)*Multiply)/Multiply
                              END
                           .
                        .
                        NOM:PVN_PROC=NEW_PVNLikme
                     .
                     JP#+=1
                     DISPLAY(?JP#)
                     IF RIUPDATE:NOM_K()
                        KLUDA(24,'NOM_K')
                     .
                  .
               .
               KLUDA(0,'mainîtas '&JP#&' nomenklatûras',,1)
               close(PVNSCREEN1)
               BREAK
            .
         OF ?CANCEL:PVN_1
            case event()
            of event:accepted
               close(PVNSCREEN1)
               BREAK
            .
         .
      .


!Elya 17/06/2012 >


      IF JP#
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
    OF ?5SpecialasfunkcijasINET
      DO SyncWindow
      !&E-Uzbûvçt i-neta failu
      IZLAISTI=0
      SPIEDIET=''
      KLU_DARBIBA=0 !OTRÂDI-PÂRBÛVÇT
      ANSIFILENAME=CLIP(LONGPATH())&'\INET\NOM_K.TXT'
      DATE#=DOS_CONT(ANSIFILENAME,1)
      IF DATE#
         KLUDA(0,'fails '&clip(ANSIFILENAME)&' jau ir izveidots '&FORMAT(DATE#,@D06.),12,1)
         RAKSTI=1 !VISMAZ 1 JAU IR...
      .
      IF ~KLU_DARBIBA
         RAKSTI=0
         NOKL_CP=1
         OPEN(INETSCREEN)
         DISPLAY
         ACCEPT
            case field()
            OF ?NOKL_CP
               case event()
               of event:accepted
                  IF ~INRANGE(NOKL_CP,1,4)
                     KLUDA(0,'Neatïauta cena')
                     NOKL_CP=1
                     SELECT(?NOKL_CP)
                     DISPLAY
                  .
               .
            OF ?OK:I
               case event()
               of event:accepted
                  HIDE(?OK:I)
                  HIDE(?CANCEL:I)
                  UNHIDE(?nom:nomenklat:1I)
                  IF ~OPENANSI(ANSIFILENAME,1) !12H
                     POST(Event:CloseWindow)
                     CYCLE
                  .
                  CLEAR(NOM:RECORD)
         !         STREAM(NOM_K)
                  SET(NOM:NOM_KEY)
                  LOOP
                     NEXT(NOM_K)
                     IF ERROR() THEN BREAK.
                     DISPLAY
                     IF ~W_INET(2,NOM:NOMENKLAT)
                        IZLAISTI+=1
                     ELSE
                        RAKSTI+=1
                     .
                  .
                  CLOSE(OUTFILEANSI)
                  SPIEDIET='Spiediet jebkuru taustiòu, lai turpinâtu'
                  display
                  ask
                  BREAK
               .
            OF ?CANCEL:I
               case event()
               of event:accepted
                  BREAK
               .
            .
         .
         close(INETSCREEN)
      .
      IF RAKSTI
         F:DBF='E'   !APSKATAM KOPIJU EXCELÎ
         CLOSE(OUTFILEANSI)
         COPY(OUTFILEANSI,CLIP(LONGPATH())&'\INET\NOM_K_COPY.TXT')
         ANSIFILENAME=CLIP(LONGPATH())&'\INET\NOM_K_COPY.TXT'
         ANSIJOB
      .
    OF ?SLIQUID
      DO SyncWindow
      RAKSTI=0
      IZLAISTI=0
      SPIEDIET=''
      NPK#=0
      OPEN(SLIQUIDSCREEN)
      DISPLAY
      ACCEPT
         case field()
         OF ?OK:SL
            case event()
            of event:accepted
               HIDE(?OK:SL)
               HIDE(?CANCEL:SL)
               UNHIDE(?nom:nomenklat:1SL)
               CLEAR(NOM:RECORD)
               SET(NOM_K)
               LOOP
                  NEXT(NOM_K)
                  IF ERROR() THEN BREAK.
                  NPK#+=1
                  DISPLAY
                  IF NOM:REDZAMIBA=3 THEN CYCLE.
                  ATRASTS#=FALSE
                  LOOP I#= 1 TO NOL_SK
                     CLOSE(NOLIK)
                     NOLIKNAME='NOLIK'&FORMAT(I#,@N02)
                     CHECKOpen(NOLIK,1)
                     CLEAR(NOL:RECORD)
                     NOL:NOMENKLAT=NOM:NOMENKLAT
                     SET(NOL:NOM_KEY,NOL:NOM_KEY)
                     NEXT(NOLIK)
                     IF ~ERROR() AND NOL:NOMENKLAT=NOM:NOMENKLAT
                        ATRASTS#=TRUE
                        BREAK
                     .
                  .
                  IF ~ATRASTS#
                     NOM:REDZAMIBA=3
                     IF RIUPDATE:NOM_K()
                        KLUDA(24,'NOM_K')
                     ELSE
                        RAKSTI+=1
      
                     .
                  .
               .
               CLOSE(NOLIK)
               NOLIKNAME='NOLIK'&FORMAT(LOC_NR,@N02)
               CHECKOpen(NOLIK,1)
               SPIEDIET='Spiediet jebkuru taustiòu, lai turpinâtu'
               display
               ask
               BREAK
            .
         OF ?CANCEL:SL
            case event()
            of event:accepted
               BREAK
            .
         .
      .
      close(SLIQUIDSCREEN)
      IF RAKSTI
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
    OF ?LIQUID
      DO SyncWindow
      RAKSTI=0
      IZLAISTI=0
      SPIEDIET=''
      npk#=0
      OPEN(LIQUIDSCREEN)
      DISPLAY
      ACCEPT
         case field()
         OF ?OK:L
            case event()
            of event:accepted
               HIDE(?OK:L)
               HIDE(?CANCEL:L)
               UNHIDE(?nom:nomenklat:1L)
               CLEAR(NOM:RECORD)
               SET(NOM_K)
               LOOP
                  NEXT(NOM_K)
                  IF ERROR() THEN BREAK.
                  IF ~(NOM:REDZAMIBA=3) THEN CYCLE.
                  npk#+=1
                  DISPLAY
                  ATRASTS#=FALSE
                  LOOP I#= 1 TO NOL_SK
                     CLOSE(NOLIK)
                     NOLIKNAME='NOLIK'&FORMAT(I#,@N02)
                     CHECKOpen(NOLIK,1)
                     CLEAR(NOL:RECORD)
                     NOL:NOMENKLAT=NOM:NOMENKLAT
                     SET(NOL:NOM_KEY,NOL:NOM_KEY)
                     NEXT(NOLIK)
                     IF ~ERROR() AND NOL:NOMENKLAT=NOM:NOMENKLAT
                        ATRASTS#=TRUE
                        BREAK
                     .
                  .
                  IF ~ATRASTS#
                     IF RIDELETE:NOM_K()
                        KLUDA(26,'NOM_K')
                        IZLAISTI+=1
                     ELSE
                        RAKSTI+=1
      
                     .
                  ELSE
                     IZLAISTI+=1
                  .
               .
               CLOSE(NOLIK)
               NOLIKNAME='NOLIK'&FORMAT(LOC_NR,@N02)
               CHECKOpen(NOLIK,1)
               SPIEDIET='Spiediet jebkuru taustiòu, lai turpinâtu'
               display
               ask
               BREAK
            .
         OF ?CANCEL:L
            case event()
            of event:accepted
               BREAK
            .
         .
      .
      close(LIQUIDSCREEN)
      IF RAKSTI
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
    OF ?5SpeciâlâsfunkcijasHNomenklatûruimportsnotxt
      DO SyncWindow
        KLUDA(0,'...tiks importçtas visas nomenklatûras no '&CLIP(LONGPATH())&'\ImpExp\nom_k3.txt',2,1)
        IF KLU_DARBIBA
           Filename1=CLIP(LONGPATH())&'\ImpExp\nom_k3.txt'
           mainiti=0
           izlaisti=0
           raksti=0
           DKRAKSTI#   =0
           open(showscreen)
           display
           CLOSE(nom_KX)
           OPEN(nom_KX)
           IF ERROR()
              KLUDA(0,'FAILS '&FILENAME1&' NAV ATRASTS')
              close(showscreen)
           ELSE
              SEND(NOM_KX,'TAB=-100')
              CLOSE(NOM_K)
              OPEN(NOM_K,12h)
              IF ERROR()
                 KLUDA(1,'NOM_K')
                 CHECKOPEN(NOM_K,1)
              ELSE
                 WriteZurnals(2,0,'Nomenklatûru imports no '&FILENAME1)
                 set(nom_KX)
                 next(nom_KX)  !virsrakstu izlaiþam
                 LOOP
                    next(nom_KX)
                    if error() then break.
                    JAUNA_NOMENKLATURA#=FALSE
                    JAUNS_KN#=FALSE
                    UPDATETEXT=''
         !versija priekð BAUMAX 30.08.2009.
         !versija priekð SANTEKO 14.09.2009.
         !versija NILA 16.12.2009.
         !versija Tolikam 06.08.2010.
         !versija PORTUNAM 09.11.2010.
                    DO FILLGROUPA
                    CLEAR(NOM:RECORD)
      !              NOM:NOMENKLAT=A:NOMENKLAT
                    NOM:KATALOGA_NR=A:KATALOGA_NR
      !              GET(NOM_K,NOM:NOM_KEY)
                    GET(NOM_K,NOM:KAT_KEY)
                    IF ERROR()     !JAUNA NOMENKLATÛRA
                       ACTION#=1
                    ELSE
                       ACTION#=2
                    .
                    NOM:NOMENKLAT  =A:NOMENKLAT
      !              NOM:NOMENKLAT  ='ELE '&A:KATALOGA_NR
                    NOM:NOS_P      =A:NOS_P
                    NOM:NOS_S      =A:NOS_P
                    NOM:NOS_A      =INIGEN(NOM:NOS_P,8,1)
                    NOM:REALIZ[1]  =A:REALIZ
                    NOM:VAL[1]     ='Ls'
                    NOM:ARPVNBYTE  =31 !VISAS AR PVN
                    NOM:MERVIEN    =A:MERVIEN
                    IF ~NOM:MERVIEN THEN NOM:MERVIEN='gab.'.
                    NOM:KATALOGA_NR=A:KATALOGA_NR
                    NOM:KODS       =A:KODS
                    NOM:MUITAS_KODS=A:MUITAS_KODS
                    NOM:SVARSKG    =A:SVARSKG
                    NOM:BKK        =A:NOM_BKK
                    NOM:IZC_V_KODS =A:IZC_V_KODS
                    NOM:TIPS       ='P'
                    NOM:PVN_PROC   =A:PVN_PROC
                    IF NOM:PVN_PROC=4 THEN NOM:PVN_PROC=21.
                    NOM:STATUSS    ='0{25}'
                    NOM:ACC_KODS   =ACC_KODS
                    NOM:ACC_DATUMS =TODAY()
                    CASE ACTION#
                    OF 1
                       ADD(nom_K)
                       IF ERROR()
                          KLUDA(0,'Kïûda rakstot '&nom:nomenklat&' '&ERROR())
                       .
                       I#=GETNOM_A(NOM:NOMENKLAT,9,1) !IEVADÎÐANA
                       raksti+=1
      !                 WriteZurnals(2,0,'Ievadu rakstu NOM_K '&CHR(9)&CLIP(NOM:NOMENKLAT)&CHR(9)&NOM:KODS&CHR(9)&CLIP(NOM:NOS_P))
                    OF 2
                       IF RIUPDATE:NOM_K()
                          KLUDA(24,'NOM_K:'&NOM:NOMENKLAT&' F:'&UPDATETEXT)
                       .
      !                 WriteZurnals(2,0,'Mainu NOM_K '&CHR(9)&CLIP(NOM:NOMENKLAT)&CHR(9)&NOM:KODS&CHR(9)&CLIP(NOM:NOS_P))
                       MAINITI+=1
                    .
                    display
                 .
                 CLOSE(NOM_K)
                 CHECKOPEN(NOM_K,1)
                 CLOSE(NOM_KX)
                 REMOVE(NOM_KX)
                 SPIEDIET='Spiediet jebkuru taustiòu, lai turpinâtu'
                 IF DKRAKSTI#
                    UNHIDE(?StringDKPZ)
                 .
                 display
                 ask
                 WriteZurnals(2,0,'Kopâ ierakstîtas '&raksti&' jaunas Nomenklatûras')
                 close(showscreen)
                 BRW1::LocateMode = LocateOnEdit
                 DO BRW1::LocateRecord
                 DO BRW1::RefreshPage
                 DO BRW1::InitializeBrowse
                 DO BRW1::PostNewSelection
                 SELECT(?Browse:1)
                 LocalRequest = OriginalRequest
                 LocalResponse = RequestCancelled
                 DO RefreshWindow
              .
           .
        .
    OF ?5SpeciâlâsfunkcijasIPârrçíinâtcenuuzEUR
      DO SyncWindow
      open(EURscreen)
      cena_nr=NOKL_CP
      IF ~INRANGE(CENA_NR,1,5)
         CENA_NR=1
      .
      CENA_TO=CENA_NR+1
      PROCLS=0
      CHANGED#=0
      F:DTK=''
      display
      ACCEPT
         case field()
         OF ?OK:EUR
            case event()
            of event:accepted
               IF ~INRANGE(CENA_NR,1,6)
                  SELECT(?CENA_NR)
                  CYCLE
               .
               IF ~INRANGE(CENA_TO,1,6)
                  SELECT(?CENA_TO)
                  CYCLE
               .
               !IF NOMENKLAT
                  !IF ~(CENA_NR=CENA_TO) !VAR PÂRRAKSTÎT TIKAI NO VIENAS UZ OTRU
                     JB#=1
                     CLEAR(NOM:RECORD)
                     IF NOMENKLAT
                        NOM:NOMENKLAT=NOMENKLAT
                     .
                     SET(NOM:NOM_KEY,NOM:NOM_KEY)
                     LOOP
                        NEXT(NOM_K)
                        IF ERROR() OR CYCLENOM(NOM:NOMENKLAT)=2 THEN BREAK.
                        IF CYCLENOM(NOM:NOMENKLAT)=1 THEN CYCLE.
                        IF ~NOM:VAL[CENA_NR]='Ls' AND ~NOM:VAL[CENA_NR]='LVL' THEN CYCLE. !13/12/2013
                        IF NOM:VAL[CENA_NR]='EUR'
                           EXECUTE ZIMES-1
                              NOM:REALIZ[CENA_TO]=ROUND(NOM:REALIZ[CENA_NR],.01)
                              NOM:REALIZ[CENA_TO]=ROUND(NOM:REALIZ[CENA_NR],.001)
                              NOM:REALIZ[CENA_TO]=ROUND(NOM:REALIZ[CENA_NR],.0001)
                           .
                        ELSE
                           EXECUTE ZIMES-1
                              NOM:REALIZ[CENA_TO]=ROUND(NOM:REALIZ[CENA_NR]/BANKURS('EUR',TODAY()),.01)
                              NOM:REALIZ[CENA_TO]=ROUND(NOM:REALIZ[CENA_NR]/BANKURS('EUR',TODAY()),.001)
                              NOM:REALIZ[CENA_TO]=ROUND(NOM:REALIZ[CENA_NR]/BANKURS('EUR',TODAY()),.0001)
                           .
                        .
                        NOM:VAL[CENA_TO]='EUR'
                        IF RIUPDATE:NOM_K()
                           KLUDA(24,'NOM_K: '&NOM:NOMENKLAT)
                        ELSE
                           CHANGED#+=1
                           DISPLAY
                           MC=CHR(9)&'Cena'&CLIP(CENA_TO)&CHR(9)&'no'&CHR(9)&SAV_CENA&CHR(9)&'uz'&CHR(9)&NOM:REALIZ[CENA_TO]&' EUR'
                           WriteZurnals(2,2,'NOM_K '&CHR(9)&CLIP(NOM:NOMENKLAT)&CHR(9)&CLIP(NOM:NOS_S)&MC)
                        .
                     .
                  !.
!               ELSE
!                  KLUDA(0,'Nav norâdîts filtrs pçc NOMENKLATÛRAS...')
!                  SELECT(?NOMENKLAT)
!                  CYCLE
!               .
               BREAK
            .
         OF ?CANCEL:EUR
            case event()
            of event:accepted
               BREAK
            .
         .
      .
      close(EURscreen)
      IF JB#=1
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
    OF ?NONEMTAKP
      DO SyncWindow
      open(procscreen)
      ?String113:1{PROP:TEXT}='Noòemt "akcijas prece"'
      HIDE(?PLUSPROC:1)
      display
      accept
         case field()
         OF ?OK:P
            case event()
            of event:accepted
               CLEAR(NOM:RECORD)
               NOM:NOMENKLAT=NOMENKLAT
               SET(NOM:NOM_KEY,NOM:NOM_KEY)
               LOOP
                  NEXT(NOM_K)
                  IF ERROR() OR CYCLENOM(NOM:NOMENKLAT)=2 THEN BREAK.
                  IF CYCLENOM(NOM:NOMENKLAT)=1 THEN CYCLE.
                  IF ~BAND(NOM:NEATL,00000010b) THEN CYCLE.
      !            STOP(NOMENKLAT&'-'&NOM:NOMENKLAT&'-'&CYCLENOM(NOM:NOMENKLAT))
                  NOM:NEATL-=2
                  IF RIUPDATE:NOM_K()
                     KLUDA(24,'NOM_K')
                  .
                  NONEMTI#+=1
                  DISPLAY
               .
               BREAK
            .
         OF ?CANCEL:P
            case event()
            of event:accepted
               BREAK
            .
         .
      .
      close(PROCscreen)
      KLUDA(0,'Mainîtas '&CLIP(NONEMTI#)&' nomenklatûras',,1)
      NONEMTI#=0
      BRW1::LocateMode = LocateOnEdit
      DO BRW1::LocateRecord
      DO BRW1::RefreshPage
      DO BRW1::InitializeBrowse
      DO BRW1::PostNewSelection
      SELECT(?Browse:1)
      LocalRequest = OriginalRequest
      LocalResponse = RequestCancelled
      DO RefreshWindow
      
    OF ?NODZESTKRMAXA
      DO SyncWindow
      open(procscreen)
      ?String113:1{PROP:TEXT}='Nodzçst "kritiskos,max atlikumus"'
      HIDE(?PLUSPROC:1)
      display
      accept
         case field()
         OF ?OK:P
            case event()
            of event:accepted
               CLEAR(NOM:RECORD)
               NOM:NOMENKLAT=NOMENKLAT
               SET(NOM:NOM_KEY,NOM:NOM_KEY)
               LOOP
                  NEXT(NOM_K)
                  IF ERROR() OR CYCLENOM(NOM:NOMENKLAT)=2 THEN BREAK.
                  IF CYCLENOM(NOM:NOMENKLAT)=1 THEN CYCLE.
                  IF ~(NOM:krit_dau[LOC_NR]+NOM:MAX_DAU[LOC_NR]) THEN CYCLE.
      !            STOP(NOMENKLAT&'-'&NOM:NOMENKLAT&'-'&CYCLENOM(NOM:NOMENKLAT))
                  NOM:krit_dau[LOC_NR]=0
                  NOM:MAX_DAU[LOC_NR]=0
                  IF RIUPDATE:NOM_K()
                     KLUDA(24,'NOM_K')
                  .
                  NONEMTI#+=1
                  DISPLAY
               .
               BREAK
            .
         OF ?CANCEL:P
            case event()
            of event:accepted
               BREAK
            .
         .
      .
      close(PROCscreen)
      KLUDA(0,'Mainîtas '&CLIP(NONEMTI#)&' nomenklatûras',,1)
      NONEMTI#=0
      BRW1::LocateMode = LocateOnEdit
      DO BRW1::LocateRecord
      DO BRW1::RefreshPage
      DO BRW1::InitializeBrowse
      DO BRW1::PostNewSelection
      SELECT(?Browse:1)
      LocalRequest = OriginalRequest
      LocalResponse = RequestCancelled
      DO RefreshWindow
      
    OF ?2Serviss3DUPKEYChecker
      DO SyncWindow
      CHECKOPEN(NOM_CHECK,1)
      CLOSE(NOM_CHECK)
      OPEN(NOM_CHECK,18)
      EMPTY(NOM_CHECK)
      SET(NOM_K)
      OPEN (ShowScreen)
      ShowScreen{PROP:TEXT}='Meklçju dubultas atslçgas...'
      ?StringIER{PROP:TEXT}='Nolasîti:'
      ?StringIZL{PROP:TEXT}=''
      raksti=0
      DISPLAY
      LOOP
         NEXT(NOM_K)
         IF ERROR() THEN BREAK.
         N:NOMENKLAT=NOM:NOMENKLAT
         GET(N_TABLE,N:NOMENKLAT)
         raksti+=1
         DISPLAY
         IF ~ERROR() 
            KLUDA(99,'dubultas nomenklatûras: '&CLIP(nom:nomenklat)&' DZÇST ? ')
            N:LINE=NOM:NOMENKLAT&' '&NOM:KODS&' '&NOM:NOS_P&' '&NOM:REALIZ[1]
            ADD(NOM_CHECK)
            IF KLU_DARBIBA
               DELETE(NOM_K)
            .
      !      LOOP I#=1 TO 21
      !         IF NOM:NOMENKLAT[I#]=' '
      !            LOOP J#=1 TO 9
      !               NOM:NOMENKLAT[I#]=J#
      !               IF ~DUPLICATE(NOM:NOM_KEY)
      !                  PUT(NOM_K)
      !                  IF ~ERROR()
      !                      N:NOMENKLAT=NOM:NOMENKLAT
      !                      ADD(N_TABLE)
      !                      SORT(N_TABLE,N:NOMENKLAT)
      !                  .
      !                  BREAK
      !               .
      !            .
      !            BREAK
      !         .
      !      .
         ELSE
            ADD(N_TABLE)
            SORT(N_TABLE,N:NOMENKLAT)
         .
      .
      CLOSE(showscreen)
      FREE(N_TABLE)
      CLOSE(NOM_CHECK)
      
      
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
    OF ?Change
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
    OF ?ButtonX
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           EXECUTE NOM:BAITS2+1
              NOM:BAITS2=1
              NOM:BAITS2=2
              NOM:BAITS2=3
              NOM:BAITS2=4
              NOM:BAITS2=0
           .
           IF RIUPDATE:NOM_K()
              KLUDA(24,'NOM_K')
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
    OF ?ButtonKartina
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
              NOMENKLAT = NOM:NOMENKLAT
              OPCIJA='0011300370000000000001'
        !             1234567890123456789012
              IZZFILTN
              IF GlobalResponse=RequestCompleted
                 START(N_KARTDRU,50000)
              .
              SELECT(?BROWSE:1)
      END
    OF ?ButtonKopet
      CASE EVENT()
      OF EVENT:Accepted
            COPYREQUEST=1
            DO BRW1::ButtonInsert
        DO SyncWindow
      END
    OF ?ButtonInformacija
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         SHOWNOMA(NOM:NOMENKLAT)
      END
    OF ?Select
      CASE EVENT()
      OF EVENT:Accepted
        IF M_KLUDA=TRUE
           SELECT(?BROWSE:1)
           CYCLE
        .
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
        IF NOM:NOMENKLAT[1:4]='!!!!'
           KLUDA(0,'Neatïauta nomenklatûra :'&nom:nomenklat)
           SELECT(?BROWSE:1)
           CYCLE
        .
        IF SELECT_ENTER=TRUE
           CLOSE(QuickWindow)
           DO PROCEDURERETURN
        .
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
    OF ?NOM:NOMENKLAT
      CASE EVENT()
      OF EVENT:Accepted
        nomenklat=nom:nomenklat
        NOM_NOMENKLAT=NOM:NOMENKLAT
        UPDATE(?NOM:NOMENKLAT)
        IF NOM:NOMENKLAT
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort5:LocatorValue = NOM:NOMENKLAT
          BRW1::Sort5:LocatorLength = LEN(CLIP(NOM:NOMENKLAT))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
      IF KEYCODE()=ENTERKEY
         SELECT_ENTER=TRUE
         DO SYNCWINDOW
         IF ~(NOM_NOMENKLAT=NOM:NOMENKLAT)
            KLUDA(0,'Nomenklatûra nav atrasta:'&NOM_NOMENKLAT&'='&NOM:NOMENKLAT)
            M_KLUDA=TRUE
         ELSE
            M_KLUDA=FALSE
         .
      ELSE
         SELECT_ENTER=FALSE
      .
    OF ?ButtonGrupa
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseGrupas
        LocalResponse = GlobalResponse
        GlobalResponse = RequestCancelled
        IF LocalResponse = RequestCompleted
           SELECT(?NOM:NOMENKLAT)
           nom:nomenklat=''
           nom:NOMENKLAT[1:3]=GR1:GRUPA1
           PRESS(NOM:NOMENKLAT)
           PRESSKEY(TabKey)
           DISPLAY
        END
      END
    OF ?ButtonGrupa:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        IF ~getgrupa(nom:NOMENKLAT[1:3],1,1)  !pozicionç grupas
           CYCLE
        .
        UpdateGrupa1
        LocalResponse = GlobalResponse
        GlobalResponse = RequestCancelled
        IF LocalResponse = RequestCompleted
           SELECT(?NOM:NOMENKLAT)
           nom:NOMENKLAT[4]=GR2:GRUPA2
           nom:nomenklat[5:21]=''
           PRESS(NOM:NOMENKLAT)
           PRESSKEY(TabKey)
           DISPLAY
        END
      END
    OF ?NOM:KODS
      CASE EVENT()
      OF EVENT:Accepted
        NOM_KODS=NOM:KODS
        UPDATE(?NOM:KODS)
        IF NOM:KODS
          CLEAR(NOM:KODS_PLUS)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      OF EVENT:Selected
        CLEAR(NOM:KODS)
      END
  IF KEYCODE()=ENTERKEY
     SELECT_ENTER=TRUE
     DO SYNCWINDOW
     IF ~(NOM_KODS=NOM:KODS)
        KLUDA(0,'Kods nav atrasts:'&NOM_KODS&'='&NOM:KODS)
        M_KLUDA=TRUE
     ELSE
        M_KLUDA=FALSE
     .
  ELSE
     SELECT_ENTER=FALSE
  .
    OF ?NOM:NOS_A
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?NOM:NOS_A)
        IF NOM:NOS_A
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort2:LocatorValue = NOM:NOS_A
          BRW1::Sort2:LocatorLength = LEN(CLIP(NOM:NOS_A))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?NOM:ANALOGS
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?NOM:ANALOGS)
        IF NOM:ANALOGS
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort3:LocatorValue = NOM:ANALOGS
          BRW1::Sort3:LocatorLength = LEN(CLIP(NOM:ANALOGS))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?NOM:KATALOGA_NR
      CASE EVENT()
      OF EVENT:Accepted
        NOMENKLAT=NOM:NOMENKLAT
        NOM_KATALOGA_NR=NOM:KATALOGA_NR
        UPDATE(?NOM:KATALOGA_NR)
        IF NOM:KATALOGA_NR
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
        IF KEYCODE()=ENTERKEY
           SELECT_ENTER=TRUE
           DO SYNCWINDOW
           IF ~(NOM_KATALOGA_NR=NOM:KATALOGA_NR)
              KLUDA(0,'KATALOGA_NR nav atrasts:'&NOM_KATALOGA_NR&'='&NOM:KATALOGA_NR)
              M_KLUDA=TRUE
           ELSE
              M_KLUDA=FALSE
           .
        ELSE
           SELECT_ENTER=FALSE
        .
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?ButtonPasutit
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        BrowseCENUVEST 
        LocalRequest = OriginalRequest
        DO RefreshWindow
      END
    OF ?ButtonPievStat
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = InsertRecord
        UpdateNOM_N 
        LocalRequest = OriginalRequest
        DO RefreshWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF NOM_A::Used = 0
    CheckOpen(NOM_A,1)
  END
  NOM_A::Used += 1
  BIND(NOA:RECORD)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  IF NOM_K1::Used = 0
    CheckOpen(NOM_K1,1)
  END
  NOM_K1::Used += 1
  BIND(NOM1:RECORD)
  IF NOM_P::Used = 0
    CheckOpen(NOM_P,1)
  END
  NOM_P::Used += 1
  BIND(NOP:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowseNOM_K','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    DISABLE(?Select)
  ELSE
  END
  BIND('F:REDZAMIBA',F:REDZAMIBA)
  BIND('F:ATBILDIGAIS',F:ATBILDIGAIS)
  BIND('ACC_KODS_N',ACC_KODS_N)
  BIND('F:N',F:N)
  BIND('LOC_NR',LOC_NR)
  BIND('N',N)
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,250} = BSKey
  ?Browse:1{Prop:Alrt,250} = SpaceKey
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
    !STOP('E '&NOM:KODS)
    NOM_A::Used -= 1
    IF NOM_A::Used = 0 THEN CLOSE(NOM_A).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    NOM_K1::Used -= 1
    IF NOM_K1::Used = 0 THEN CLOSE(NOM_K1).
    NOM_P::Used -= 1
    IF NOM_P::Used = 0 THEN CLOSE(NOM_P).
  END
  PUTINI('BrowseNOM_K','?BROWSE:1 Format',?BROWSE:1{PROP:FORMAT},'WinLats.ini')
  Last_nom_tab=CHOICE(?CurrentTab)
  
  IF WindowOpened
    INISaveWindow('BrowseNOM_K','winlats.INI')
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
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LocatorValue = NOM:KODS
    CLEAR(NOM:KODS)
  OF 2
    NOM:NOS_A = BRW1::Sort2:LocatorValue
  OF 3
    NOM:ANALOGS = BRW1::Sort3:LocatorValue
  OF 4
    BRW1::Sort4:LocatorValue = NOM:KATALOGA_NR
    CLEAR(NOM:KATALOGA_NR)
  OF 5
    NOM:NOMENKLAT = BRW1::Sort5:LocatorValue
  END
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

!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! BÛVÇJAM P/Z
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
          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END

!---------------------------------------------------------------------------------------------
SEARCHKESKA     ROUTINE
 OPEN(KESKAWINDOW)
 ACCEPT
   CASE FIELD()
   OF ?OKButton
     BREAK
   OF ?CancelButton
     KESKA=''
     BREAK
  .
 .
 CLOSE(KESKAWINDOW)
 IF KESKA
   DO SyncWindow
   SET(NOM:NOM_KEY,NOM:NOM_KEY)
   FOUND#=0
   LOOP
      NEXT(NOM_K)
      IF ERROR() THEN BREAK.

      IF (SEARCHMODE=1 AND (INSTRING(KESKA,NOM:NOMENKLAT,1) OR INSTRING(KESKA,NOM:KATALOGA_NR,1))) OR |
         (SEARCHMODE=1 AND (INSTRING(UPPER(KESKA),NOM:NOMENKLAT,1) OR INSTRING(UPPER(KESKA),UPPER(NOM:KATALOGA_NR),1))) OR |
         (SEARCHMODE=2 AND (INSTRING(UPPER(INIGEN(KESKA,LEN(KESKA),2)),UPPER(INIGEN(NOM:NOS_S,LEN(CLIP(NOM:NOS_S)),2)),1) OR |
         INSTRING(UPPER(INIGEN(KESKA,LEN(KESKA),2)),UPPER(INIGEN(NOM:NOS_P,LEN(CLIP(NOM:NOS_P)),2)),1)))
         GLOBALREQUEST=0
         UPDATENOM_K
         FOUND#=1
         BREAK
      .
   .
   IF ~FOUND#
      KLUDA(0,'Fragments '&clip(KESKA)&' nav atrasts...')
   ELSE
      LocalRequest = OriginalRequest
      BRW1::LocateMode = LocateOnEdit
      DO BRW1::LocateRecord
      DO BRW1::InitializeBrowse
      DO BRW1::PostNewSelection
      DO BRW1::RefreshPage
   .
 .

!---------------------------------------------------------------------------------------------
FILLGROUPA  ROUTINE
!versija priekð BAUMAX 30.08.2009.
!versija priekð SANTEKO 14.09.2009.
!versija NILA 16.12.2009.
!versija Toïikam 06.08.2010.
!versija PORTUNAM 09.11.2010.
  START#=0
  END#=-1
  ITEM#=0
  L#=LEN(CLIP(NOMX:LINE))
  LOOP I#= 1 TO 200
!     STOP(I#&'='&VAL(NOMX:LINE[I#]))
     IF NOMX:LINE[I#]=CHR(9) OR I#=L#+1 !LAI PÇDÇJAM NENOCIRSTU PÇDÇJO BAITU
        ITEM#+=1
        START#=END#+2
        END#=I#-1
!        STOP(START#&' '&END#&' '&ITEM#)
!        EXECUTE ITEM#
!           NEVAJAG#=TRUE                           !1
!           A:NOS_P       = NOM3:LINE[START#:END#]  !2
!           NEVAJAG#=TRUE                           !3
!           A:NOMENKLAT   = NOM3:LINE[START#:END#]  !4
!           NEVAJAG#=TRUE                           !5
!           NEVAJAG#=TRUE                           !6
!           NEVAJAG#=TRUE                           !7
!           NEVAJAG#=TRUE                           !8
!           A:REALIZ      = NOM3:LINE[START#:END#]  !9
!           NEVAJAG#=TRUE                           !10
!           A:MUITAS_KODS = NOM3:LINE[START#:END#]  !11
!           A:KODS        = NOM3:LINE[START#:END#]  !12
!           A:SVARSKG     = NOM3:LINE[START#:END#]  !13
!           A:IZC_V_KODS  = NOM3:LINE[START#:END#]  !14
!        .
!SANTEKO
        EXECUTE ITEM#
           A:NOMENKLAT   = NOMX:LINE[START#:END#]  !1
           A:NOS_P       = NOMX:LINE[START#:END#]  !2
           A:NOS_A       = NOMX:LINE[START#:END#]  !3
           A:REALIZ      = NOMX:LINE[START#:END#]  !4
           A:MERVIEN     = NOMX:LINE[START#:END#]  !5
           A:KATALOGA_NR = NOMX:LINE[START#:END#]  !6
           A:KODS        = NOMX:LINE[START#:END#]  !7
           A:MUITAS_KODS = NOMX:LINE[START#:END#]  !8
           A:SVARSKG     = NOMX:LINE[START#:END#]  !9
           A:NOM_BKK     = NOMX:LINE[START#:END#]  !10
           A:IZC_V_KODS  = NOMX:LINE[START#:END#]  !11
        .
        IF ITEM#=11 THEN BREAK.
!NILS1
!        EXECUTE ITEM#
!           A:NOMENKLAT   = NOM3:LINE[START#:END#]  !1
!           A:NOS_P       = NOM3:LINE[START#:END#]  !2
!           A:REALIZ      = NOM3:LINE[START#:END#]  !4
!        .
!        IF ITEM#=3 THEN BREAK.
!NILS2
!        EXECUTE ITEM#
!           A:NOMENKLAT   = NOM3:LINE[START#:END#]  !1
!           A:NOS_P       = NOM3:LINE[START#:END#]  !2
!           A:KODS        = NOM3:LINE[START#:END#]  !3
!        .
!        IF ITEM#=3 THEN BREAK.
!     .
!  .
!  A:KATALOGA_NR = NOM3:LINE[START#:END#]                 !RAÞOTÂJA KODS
!  A:NOMENKLAT='SI'&A:KATALOGA_NR
!  A:NOS_S       = NOM3:LINE[START#:END#]
!  A:MERVIEN     = NOM3:LINE[START#:END#]

!Toïiks 06.08.2010
!        EXECUTE ITEM#
!           A:KATALOGA_NR = NOMX:LINE[START#:END#]  !1
!           A:KODS        = NOMX:LINE[START#:END#]  !2
!           A:NOS_P       = NOMX:LINE[START#:END#]  !3
!           A:SVARSKG     = NOMX:LINE[START#:END#]  !4
!           A:MERVIEN     = NOMX:LINE[START#:END#]  !5
!           NEVAJAG#=TRUE                           !6
!           A:REALIZ      = NOMX:LINE[START#:END#]  !7
!           A:MUITAS_KODS = NOMX:LINE[START#:END#]  !8
!           A:IZC_V_KODS  = NOMX:LINE[START#:END#]  !9
!        .
!        IF ITEM#=9 THEN BREAK.
!     .
!  .
!PORTUNS 09.11.2010
!        EXECUTE ITEM#
!           A:NOMENKLAT   = NOMX:LINE[START#:END#]  !1
!           A:NOS_P       = NOMX:LINE[START#:END#]  !2
!           A:KATALOGA_NR = NOMX:LINE[START#:END#]  !3
!           A:REALIZ      = NOMX:LINE[START#:END#]  !4
!           A:PVN_PROC    = NOMX:LINE[START#:END#]  !5
!           A:KODS        = NOMX:LINE[START#:END#]  !6
!           A:NOS_S       = NOMX:LINE[START#:END#]  !7
!           A:NOMENKLAT   = NOMX:LINE[START#:END#]&'-'&A:NOMENKLAT  !8
!        .
!        IF ITEM#=8 THEN BREAK.
     .
  .



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
  ELSIF CHOICE(?CurrentTab) = 4
    BRW1::SortOrder = 3
  ELSIF CHOICE(?CurrentTab) = 5
    BRW1::SortOrder = 4
  ELSE
    BRW1::SortOrder = 5
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    END
  ELSE
    CASE BRW1::SortOrder
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      NOM:NOS_A = BRW1::Sort2:LocatorValue
    OF 3
      BRW1::Sort3:LocatorValue = ''
      BRW1::Sort3:LocatorLength = 0
      NOM:ANALOGS = BRW1::Sort3:LocatorValue
    OF 5
      BRW1::Sort5:LocatorValue = ''
      BRW1::Sort5:LocatorLength = 0
      NOM:NOMENKLAT = BRW1::Sort5:LocatorValue
    END
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
  IF SEND(NOM_K,'QUICKSCAN=on').
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NOM_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = NOM:KODS
  OF 2
    BRW1::Sort2:HighValue = NOM:NOS_A
  OF 4
    BRW1::Sort4:HighValue = NOM:KATALOGA_NR
  OF 5
    BRW1::Sort5:HighValue = NOM:NOMENKLAT
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NOM_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = NOM:KODS
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  OF 2
    BRW1::Sort2:LowValue = NOM:NOS_A
    SetupStringStops(BRW1::Sort2:LowValue,BRW1::Sort2:HighValue,SIZE(BRW1::Sort2:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort2:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  OF 4
    BRW1::Sort4:LowValue = NOM:KATALOGA_NR
    SetupStringStops(BRW1::Sort4:LowValue,BRW1::Sort4:HighValue,SIZE(BRW1::Sort4:LowValue),ScrollSort:AllowAlpha+ScrollSort:AllowNumeric)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort4:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  OF 5
    BRW1::Sort5:LowValue = NOM:NOMENKLAT
    SetupStringStops(BRW1::Sort5:LowValue,BRW1::Sort5:HighValue,SIZE(BRW1::Sort5:LowValue),ScrollSort:AllowAlpha+ScrollSort:AllowNumeric)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort5:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  END
  IF SEND(NOM_K,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  NOM:BAITS2 = BRW1::NOM:BAITS2
  NOM:NOMENKLAT = BRW1::NOM:NOMENKLAT
  NOM:KODS = BRW1::NOM:KODS
  NOM:KODS_PLUS = BRW1::NOM:KODS_PLUS
  NOM:NOS_P = BRW1::NOM:NOS_P
  NOM:ANALOGS = BRW1::NOM:ANALOGS
  NOM:KATALOGA_NR = BRW1::NOM:KATALOGA_NR
  cena = BRW1::cena
  ARBYTE = BRW1::ARBYTE
  NOM:PVN_PROC = BRW1::NOM:PVN_PROC
  Pieejams = BRW1::Pieejams
  Atlikums = BRW1::Atlikums
  KRIT_DAU = BRW1::KRIT_DAU
  D_projekts = BRW1::D_projekts
  K_projekts = BRW1::K_projekts
  STATUSS = BRW1::STATUSS
  NOM:SKAITS_I = BRW1::NOM:SKAITS_I
  F:REDZAMIBA = BRW1::F:REDZAMIBA
  F:ATBILDIGAIS = BRW1::F:ATBILDIGAIS
  ACC_KODS_N = BRW1::ACC_KODS_N
  F:N = BRW1::F:N
  LOC_NR = BRW1::LOC_NR
  N = BRW1::N
  NOM:NOS_A = BRW1::NOM:NOS_A
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
  CENA=GETNOM_K('POZICIONÇTS',0,7)
  ARBYTE=GETNOM_K('POZICIONÇTS',0,10)
  IF INRANGE(LOC_NR,1,25) !SAUC NO NOLIKTAVAS
     ATLIKUMS=GETNOM_A(NOM:NOMENKLAT,1,0)
     D_PROJEKTS=GETNOM_A('POZICIONÇTS',2,0)
     K_PROJEKTS=GETNOM_A('POZICIONÇTS',4,0)
  ELSE                     !SAUC NO PASÛTÎJUMIEM
     ATLIKUMS=GETNOM_A(NOM:NOMENKLAT,5,0)
     D_PROJEKTS=GETNOM_A('POZICIONÇTS',6,0)
     K_PROJEKTS=GETNOM_A('POZICIONÇTS',8,0)
  .
  PIEEJAMS=ATLIKUMS-K_PROJEKTS
  KRIT_DAU=NOM:KRIT_DAU[LOC_NR]
  STATUSS = NOM:STATUSS[LOC_NR]
  BRW1::NOM:BAITS2 = NOM:BAITS2
  BRW1::NOM:NOMENKLAT = NOM:NOMENKLAT
  BRW1::NOM:KODS = NOM:KODS
  IF (nom:redzamiba=3)
    BRW1::NOM:KODS:NormalFG = 8421504
    BRW1::NOM:KODS:NormalBG = -1
    BRW1::NOM:KODS:SelectedFG = -1
    BRW1::NOM:KODS:SelectedBG = -1
  ELSE
    BRW1::NOM:KODS:NormalFG = -1
    BRW1::NOM:KODS:NormalBG = -1
    BRW1::NOM:KODS:SelectedFG = -1
    BRW1::NOM:KODS:SelectedBG = -1
  END
  BRW1::NOM:KODS_PLUS = NOM:KODS_PLUS
  IF (nom:redzamiba=3)
    BRW1::NOM:KODS_PLUS:NormalFG = 8421504
    BRW1::NOM:KODS_PLUS:NormalBG = -1
    BRW1::NOM:KODS_PLUS:SelectedFG = -1
    BRW1::NOM:KODS_PLUS:SelectedBG = -1
  ELSE
    BRW1::NOM:KODS_PLUS:NormalFG = -1
    BRW1::NOM:KODS_PLUS:NormalBG = -1
    BRW1::NOM:KODS_PLUS:SelectedFG = -1
    BRW1::NOM:KODS_PLUS:SelectedBG = -1
  END
  BRW1::NOM:NOS_P = NOM:NOS_P
  IF (nom:redzamiba=3)
    BRW1::NOM:NOS_P:NormalFG = 8421504
    BRW1::NOM:NOS_P:NormalBG = -1
    BRW1::NOM:NOS_P:SelectedFG = -1
    BRW1::NOM:NOS_P:SelectedBG = -1
  ELSE
    BRW1::NOM:NOS_P:NormalFG = -1
    BRW1::NOM:NOS_P:NormalBG = -1
    BRW1::NOM:NOS_P:SelectedFG = -1
    BRW1::NOM:NOS_P:SelectedBG = -1
  END
  BRW1::NOM:ANALOGS = NOM:ANALOGS
  BRW1::NOM:KATALOGA_NR = NOM:KATALOGA_NR
  BRW1::cena = cena
  BRW1::ARBYTE = ARBYTE
  IF (nom:redzamiba=3)
    BRW1::ARBYTE:NormalFG = 8421504
    BRW1::ARBYTE:NormalBG = -1
    BRW1::ARBYTE:SelectedFG = -1
    BRW1::ARBYTE:SelectedBG = -1
  ELSE
    BRW1::ARBYTE:NormalFG = -1
    BRW1::ARBYTE:NormalBG = -1
    BRW1::ARBYTE:SelectedFG = -1
    BRW1::ARBYTE:SelectedBG = -1
  END
  BRW1::NOM:PVN_PROC = NOM:PVN_PROC
  IF (nom:redzamiba=3)
    BRW1::NOM:PVN_PROC:NormalFG = 8421504
    BRW1::NOM:PVN_PROC:NormalBG = -1
    BRW1::NOM:PVN_PROC:SelectedFG = -1
    BRW1::NOM:PVN_PROC:SelectedBG = -1
  ELSE
    BRW1::NOM:PVN_PROC:NormalFG = -1
    BRW1::NOM:PVN_PROC:NormalBG = -1
    BRW1::NOM:PVN_PROC:SelectedFG = -1
    BRW1::NOM:PVN_PROC:SelectedBG = -1
  END
  BRW1::Pieejams = Pieejams
  BRW1::Atlikums = Atlikums
  BRW1::KRIT_DAU = KRIT_DAU
  BRW1::D_projekts = D_projekts
  BRW1::K_projekts = K_projekts
  BRW1::STATUSS = STATUSS
  BRW1::NOM:SKAITS_I = NOM:SKAITS_I
  BRW1::F:REDZAMIBA = F:REDZAMIBA
  BRW1::F:ATBILDIGAIS = F:ATBILDIGAIS
  BRW1::ACC_KODS_N = ACC_KODS_N
  BRW1::F:N = F:N
  BRW1::LOC_NR = LOC_NR
  BRW1::N = N
  BRW1::NOM:NOS_A = NOM:NOS_A
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
      POST(Event:Accepted,?Change)
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => NOM:KODS
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 2
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => UPPER(NOM:NOS_A)
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 3
      OF 4
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort4:KeyDistribution[BRW1::CurrentScroll] => UPPER(NOM:KATALOGA_NR)
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 5
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort5:KeyDistribution[BRW1::CurrentScroll] => UPPER(NOM:NOMENKLAT)
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
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      NOM:NOS_A = BRW1::Sort2:LocatorValue
    OF 3
      BRW1::Sort3:LocatorValue = ''
      BRW1::Sort3:LocatorLength = 0
      NOM:ANALOGS = BRW1::Sort3:LocatorValue
    OF 5
      BRW1::Sort5:LocatorValue = ''
      BRW1::Sort5:LocatorLength = 0
      NOM:NOMENKLAT = BRW1::Sort5:LocatorValue
    END
  CASE BRW1::SortOrder
  OF 3
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
        POST(Event:Accepted,?Select)
        EXIT
      END
      POST(Event:Accepted,?Change)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
    OF DeleteKey
      POST(Event:Accepted,?Delete:2)
    OF CtrlEnter
      POST(Event:Accepted,?Change)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          SELECT(?NOM:KODS)
          PRESS(CHR(KEYCHAR()))
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            NOM:NOS_A = BRW1::Sort2:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          NOM:NOS_A = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          NOM:NOS_A = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 3
        IF KEYCODE() = BSKey
          IF BRW1::Sort3:LocatorLength
            BRW1::Sort3:LocatorLength -= 1
            BRW1::Sort3:LocatorValue = SUB(BRW1::Sort3:LocatorValue,1,BRW1::Sort3:LocatorLength)
            NOM:ANALOGS = BRW1::Sort3:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort3:LocatorValue = SUB(BRW1::Sort3:LocatorValue,1,BRW1::Sort3:LocatorLength) & ' '
          BRW1::Sort3:LocatorLength += 1
          NOM:ANALOGS = BRW1::Sort3:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort3:LocatorValue = SUB(BRW1::Sort3:LocatorValue,1,BRW1::Sort3:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort3:LocatorLength += 1
          NOM:ANALOGS = BRW1::Sort3:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 4
        IF CHR(KEYCHAR())
          SELECT(?NOM:KATALOGA_NR)
          PRESS(CHR(KEYCHAR()))
        END
      OF 5
        IF KEYCODE() = BSKey
          IF BRW1::Sort5:LocatorLength
            BRW1::Sort5:LocatorLength -= 1
            BRW1::Sort5:LocatorValue = SUB(BRW1::Sort5:LocatorValue,1,BRW1::Sort5:LocatorLength)
            NOM:NOMENKLAT = BRW1::Sort5:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort5:LocatorValue = SUB(BRW1::Sort5:LocatorValue,1,BRW1::Sort5:LocatorLength) & ' '
          BRW1::Sort5:LocatorLength += 1
          NOM:NOMENKLAT = BRW1::Sort5:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort5:LocatorValue = SUB(BRW1::Sort5:LocatorValue,1,BRW1::Sort5:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort5:LocatorLength += 1
          NOM:NOMENKLAT = BRW1::Sort5:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
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
      NOM:KODS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 2
      NOM:NOS_A = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 4
      NOM:KATALOGA_NR = BRW1::Sort4:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 5
      NOM:NOMENKLAT = BRW1::Sort5:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
  IF BRW1::ItemsToFill > 1
    IF SEND(NOM_K,'QUICKSCAN=on').
    BRW1::QuickScan = True
  END
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
        StandardWarning(Warn:RecordFetchError,'NOM_K')
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
  IF BRW1::QuickScan
    IF SEND(NOM_K,'QUICKSCAN=off').
    BRW1::QuickScan = False
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
      BRW1::HighlightedPosition = POSITION(NOM:KOD_KEY)
      RESET(NOM:KOD_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(NOM:KOD_KEY,NOM:KOD_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '((~F:ATBILDIGAIS OR  NOM:ATBILDIGAIS=ACC_KODS_N)  AND BAND(F:REDZAMIBA' & |
    ',CONVERTREDZ(NOM:REDZAMIBA)) AND (F:N OR ~(NOM:STATUSS[LOC_NR] = N)))'
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(NOM:NOS_KEY)
      RESET(NOM:NOS_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(NOM:NOS_KEY,NOM:NOS_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '((~F:ATBILDIGAIS OR  NOM:ATBILDIGAIS=ACC_KODS_N)  AND BAND(F:REDZAMIBA' & |
    ',CONVERTREDZ(NOM:REDZAMIBA)) AND (F:N OR ~(NOM:STATUSS[LOC_NR] = N)))'
  OF 3
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(NOM:ANAL_KEY)
      RESET(NOM:ANAL_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(NOM:ANAL_KEY,NOM:ANAL_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '((~F:ATBILDIGAIS OR  NOM:ATBILDIGAIS=ACC_KODS_N)  AND BAND(F:REDZAMIBA' & |
    ',CONVERTREDZ(NOM:REDZAMIBA)) AND (F:N OR ~(NOM:STATUSS[LOC_NR] = N)))'
  OF 4
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(NOM:KAT_KEY)
      RESET(NOM:KAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(NOM:KAT_KEY,NOM:KAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '((~F:ATBILDIGAIS OR  NOM:ATBILDIGAIS=ACC_KODS_N)  AND BAND(F:REDZAMIBA' & |
    ',CONVERTREDZ(NOM:REDZAMIBA)) AND (F:N OR ~(NOM:STATUSS[LOC_NR] = N)))'
  OF 5
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(NOM:NOM_KEY)
      RESET(NOM:NOM_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(NOM:NOM_KEY,NOM:NOM_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '((~F:ATBILDIGAIS OR  NOM:ATBILDIGAIS=ACC_KODS_N)  AND BAND(F:REDZAMIBA' & |
    ',CONVERTREDZ(NOM:REDZAMIBA)) AND (F:N OR ~(NOM:STATUSS[LOC_NR] = N)))'
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
    CASE BRW1::SortOrder
    OF 1; ?NOM:KODS{Prop:Disable} = 0
    OF 2; ?NOM:NOS_A{Prop:Disable} = 0
    OF 3; ?NOM:ANALOGS{Prop:Disable} = 0
    OF 4; ?NOM:KATALOGA_NR{Prop:Disable} = 0
    OF 5; ?NOM:NOMENKLAT{Prop:Disable} = 0
    END
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
    ?Change{Prop:Disable} = 0
    ?Delete:2{Prop:Disable} = 0
  ELSE
    CLEAR(NOM:Record)
    CASE BRW1::SortOrder
    OF 1; ?NOM:KODS{Prop:Disable} = 1
    OF 2; ?NOM:NOS_A{Prop:Disable} = 1
    OF 3; ?NOM:ANALOGS{Prop:Disable} = 1
    OF 4; ?NOM:KATALOGA_NR{Prop:Disable} = 1
    OF 5; ?NOM:NOMENKLAT{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    ?Change{Prop:Disable} = 1
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
    SET(NOM:KOD_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '((~F:ATBILDIGAIS OR  NOM:ATBILDIGAIS=ACC_KODS_N)  AND BAND(F:REDZAMIBA' & |
    ',CONVERTREDZ(NOM:REDZAMIBA)) AND (F:N OR ~(NOM:STATUSS[LOC_NR] = N)))'
  OF 2
    SET(NOM:NOS_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '((~F:ATBILDIGAIS OR  NOM:ATBILDIGAIS=ACC_KODS_N)  AND BAND(F:REDZAMIBA' & |
    ',CONVERTREDZ(NOM:REDZAMIBA)) AND (F:N OR ~(NOM:STATUSS[LOC_NR] = N)))'
  OF 3
    SET(NOM:ANAL_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '((~F:ATBILDIGAIS OR  NOM:ATBILDIGAIS=ACC_KODS_N)  AND BAND(F:REDZAMIBA' & |
    ',CONVERTREDZ(NOM:REDZAMIBA)) AND (F:N OR ~(NOM:STATUSS[LOC_NR] = N)))'
  OF 4
    SET(NOM:KAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '((~F:ATBILDIGAIS OR  NOM:ATBILDIGAIS=ACC_KODS_N)  AND BAND(F:REDZAMIBA' & |
    ',CONVERTREDZ(NOM:REDZAMIBA)) AND (F:N OR ~(NOM:STATUSS[LOC_NR] = N)))'
  OF 5
    SET(NOM:NOM_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '((~F:ATBILDIGAIS OR  NOM:ATBILDIGAIS=ACC_KODS_N)  AND BAND(F:REDZAMIBA' & |
    ',CONVERTREDZ(NOM:REDZAMIBA)) AND (F:N OR ~(NOM:STATUSS[LOC_NR] = N)))'
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
  BrowseButtons.ChangeButton=?Change
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
  GET(NOM_K,0)
  CLEAR(NOM:Record,0)
  LocalRequest = InsertRecord
  IF COPYREQUEST=1             !kopçðana
     DO SYNCWINDOW
     IF DUP_NOM_KODS=FALSE
        NOM:KODS=0
        NOM:KODS_PLUS=''
     .
     NOM:STATUSS='0'
     NOM:GNET_FLAG=''
     IF NOM:TIPS='R'  !RAÞOJUMS
        NOMENKLAT=NOM:NOMENKLAT
     ELSE
        NOMENKLAT=''
     .
     NOM:ACC_KODS=ACC_KODS
     NOM:ACC_DATUMS=TODAY()
  .
  
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    WriteZurnals(2,1,'NOM_K '&CHR(9)&CLIP(NOM:NOMENKLAT)&CHR(9)&CLIP(NOM:NOS_S))
  .
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
  IF NOM:NOMENKLAT[1:4]='!!!!'
     KLUDA(0,'Neatïauta nomenklatûra :'&nom:nomenklat)
  .
  LOOP I#= 1 TO 5
     NOM_REALIZ[I#]=NOM:REALIZ[I#]
  .
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    MC=''
    LOOP I#=1 TO 5
       IF ~(NOM_REALIZ[I#] = NOM:REALIZ[I#])
          MC = CLIP(MC) &CHR(9)&'C'&CLIP(I#)&':'&CHR(9)&NOM_REALIZ[I#]&CHR(9)&CHR(9)&NOM:REALIZ[I#]
       .
    .
    IF MC THEN MC=CLIP(MC)&CHR(9)&'A:'&CHR(9)&GETNOM_A(NOM:NOMENKLAT,1,0).
    WriteZurnals(2,2,'NOM_K '&CHR(9)&CLIP(NOM:NOMENKLAT)&CHR(9)&CLIP(NOM:NOS_S)&MC)
  .
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
    WriteZurnals(2,3,'NOM_K '&CHR(9)&CLIP(NOM:NOMENKLAT)&CHR(9)&CLIP(NOM:NOS_S))
  .
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
!| (UpdateNOM_K) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
   EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[6])
     EXIT
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
   .
   IF LOCALREQUEST=DELETERECORD
      IF GETNOM_A(NOM:NOMENKLAT,5,0)
         KLUDA(40,'sk. Informâcija, Kopâ:'&GETNOM_A(NOM:NOMENKLAT,5,0))
         EXIT
      .
   .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateNOM_K
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
        GET(NOM_K,0)
        CLEAR(NOM:Record,0)
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
  copyrequest=0

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


UpdateKOMPLEKT PROCEDURE


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
NOM_NOSAUKUMS        STRING(50)
SAV_NOMENKLAT  LIKE(NOMENKLAT)
SAV_DAUDZUMS   LIKE(KOM:DAUDZUMS)
Update::Reloop  BYTE
Update::Error   BYTE
History::KOM:Record LIKE(KOM:Record),STATIC
SAV::KOM:Record      LIKE(KOM:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the KOMPLEKT File'),AT(,,181,93),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateKOMPLEKT'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,4,173,63),USE(?CurrentTab)
                         TAB('Sastâvdaïa :'),USE(?Tab:1)
                           PROMPT('Daudzums:'),AT(21,51),USE(?Prompt1)
                           ENTRY(@n_11.3),AT(61,49,47,12),USE(KOM:DAUDZUMS),DECIMAL(20),REQ
                           BUTTON('Nomenklatûra'),AT(10,23,49,14),USE(?ButtonNomenklatura)
                           STRING(@s21),AT(61,27),USE(KOM:NOM_SOURCE)
                           STRING(@s50),AT(10,38),USE(NOM_NOSAUKUMS)
                         END
                       END
                       BUTTON('&OK'),AT(59,73,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(108,73,45,14),USE(?Cancel)
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
  SAV_NOMENKLAT=KOM:NOM_SOURCE
  SAV_DAUDZUMS =KOM:DAUDZUMS
  NOM_NOSAUKUMS=GETNOM_K(KOM:NOM_SOURCE,0,2)
  SELECT(?KOM:DAUDZUMS)
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
      SELECT(?Prompt1)
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
        History::KOM:Record = KOM:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(KOMPLEKT)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(KOM:NOM_KEY)
              IF StandardWarning(Warn:DuplicateKey,'KOM:NOM_KEY')
                SELECT(?Prompt1)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?Prompt1)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::KOM:Record <> KOM:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:KOMPLEKT(1)
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
              SELECT(?Prompt1)
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
    OF ?ButtonNomenklatura
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNOM_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF NOM:TIPS='R'
           KLUDA(0,'Neatïauta sastâvdaïa: Raþojums')
        ELSE
           KOM:NOM_SOURCE=NOM:NOMENKLAT
           NOM_NOSAUKUMS=NOM:NOS_P
           SELECT(?KOM:DAUDZUMS)
        .
        DISPLAY
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
        IF ~KOM:NOM_SOURCE
           BEEP
           CYCLE
        .
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
  IF KOMPLEKT::Used = 0
    CheckOpen(KOMPLEKT,1)
  END
  KOMPLEKT::Used += 1
  BIND(KOM:RECORD)
  FilesOpened = True
  RISnap:KOMPLEKT
  SAV::KOM:Record = KOM:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    NOMENKLAT=KOM:NOM_SOURCE
    GLOBALREQUEST=SELECTRECORD
    BROWSENOM_K
    IF GLOBALRESPONSE=REQUESTCOMPLETED
       KOM:NOM_SOURCE=NOM:NOMENKLAT
       NOM_NOSAUKUMS=NOM:NOS_P
    ELSE
       DO PROCEDURERETURN
    .
    SELECT(?KOM:DAUDZUMS)
    DISPLAY
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:KOMPLEKT()
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
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('UpdateKOMPLEKT','winlats.INI')
  WinResize.Resize
  ?KOM:DAUDZUMS{PROP:Alrt,255} = 734
  ?KOM:NOM_SOURCE{PROP:Alrt,255} = 734
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
     IF LocalRequest=1  !IEVADÎÐANA
        AtlikumiN('P',KOM:NOM_SOURCE,KOM:DAUDZUMS*MINMAXSUMMA,'','',0)
     ELSIF LocalRequest=2  !MAINÎÐANA
        AtlikumiN('P',KOM:NOM_SOURCE,KOM:DAUDZUMS*MINMAXSUMMA,'P',SAV_NOMENKLAT,SAV_DAUDZUMS*MINMAXSUMMA)
     ELSIF LocalRequest = DeleteRecord !DZÇÐANA
        AtlikumiN('','',0,'P',KOM:NOM_SOURCE,KOM:DAUDZUMS*MINMAXSUMMA)
     .
    KOMPLEKT::Used -= 1
    IF KOMPLEKT::Used = 0 THEN CLOSE(KOMPLEKT).
  END
  IF WindowOpened
    INISaveWindow('UpdateKOMPLEKT','winlats.INI')
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
    OF ?KOM:DAUDZUMS
      KOM:DAUDZUMS = History::KOM:Record.DAUDZUMS
    OF ?KOM:NOM_SOURCE
      KOM:NOM_SOURCE = History::KOM:Record.NOM_SOURCE
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
  KOM:Record = SAV::KOM:Record
  SAV::KOM:Record = KOM:Record
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

