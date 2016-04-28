                     MEMBER('winlats.clw')        ! This is a MEMBER module
BROWSETEK_SER PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG

BRW1::View:Browse    VIEW(TEK_SER)
                       PROJECT(TES:U_NR)
                       PROJECT(TES:TEKSTS)
                       PROJECT(TES:TEK_A)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::TES:U_NR         LIKE(TES:U_NR)             ! Queue Display field
BRW1::TES:TEKSTS       LIKE(TES:TEKSTS)           ! Queue Display field
BRW1::TES:TEK_A        LIKE(TES:TEK_A)            ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(TES:U_NR),DIM(100)
BRW1::Sort1:LowValue LIKE(TES:U_NR)               ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(TES:U_NR)              ! Queue position of scroll thumb
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort2:KeyDistribution LIKE(TES:TEK_A),DIM(100)
BRW1::Sort2:LowValue LIKE(TES:TEK_A)              ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(TES:TEK_A)             ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Browse the TEK_SER File'),AT(,,429,255),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BROWSETEK_SER'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,408,190),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('38R(2)|M~U NR~C(0)@n_8@80L(2)|M~TEKSTS~@s110@'),FROM(Queue:Browse:1)
                       BUTTON('&C-Kopçt'),AT(111,236,45,14),USE(?Kopet)
                       BUTTON('Iz&vçlçties'),AT(168,236,45,14),USE(?Select),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                       BUTTON('&Ievadît'),AT(217,236,45,14),USE(?Insert:3)
                       BUTTON('&Mainît'),AT(266,236,45,14),USE(?Change),DEFAULT
                       BUTTON('&Dzçst'),AT(315,236,45,14),USE(?Delete:3)
                       SHEET,AT(4,4,416,228),USE(?CurrentTab)
                         TAB('TES:NOS_KEY'),USE(?Tab:2)
                           ENTRY(@s7),AT(14,214),USE(TES:TEK_A)
                         END
                         TAB('TES:NR_KEY'),USE(?Tab:3)
                           ENTRY(@n13),AT(13,213),USE(TES:U_NR)
                         END
                       END
                       BUTTON('&Beigt'),AT(365,236,45,14),USE(?Close)
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
     ?Change {PROP:DEFAULT}=''
     ?Select{PROP:DEFAULT}='1'
     QUICKWINDOW{PROP:TEXT}='Izvçlaties tekstu'
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
    OF ?Kopet
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         COPYREQUEST=1
         DO BRW1::ButtonInsert
      END
    OF ?Select
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
      END
    OF ?Insert:3
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
    OF ?Delete:3
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
    OF ?TES:TEK_A
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?TES:TEK_A)
        IF TES:TEK_A
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort2:LocatorValue = TES:TEK_A
          BRW1::Sort2:LocatorLength = LEN(CLIP(TES:TEK_A))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?TES:U_NR
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?TES:U_NR)
        IF TES:U_NR
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = TES:U_NR
          BRW1::Sort1:LocatorLength = LEN(CLIP(TES:U_NR))
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
  IF TEK_SER::Used = 0
    CheckOpen(TEK_SER,1)
  END
  TEK_SER::Used += 1
  BIND(TES:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BROWSETEK_SER','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select{Prop:Hide} = True
    DISABLE(?Select)
  ELSE
  END
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
    TEK_SER::Used -= 1
    IF TEK_SER::Used = 0 THEN CLOSE(TEK_SER).
  END
  IF WindowOpened
    INISaveWindow('BROWSETEK_SER','winlats.INI')
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
    TES:U_NR = BRW1::Sort1:LocatorValue
  OF 2
    TES:TEK_A = BRW1::Sort2:LocatorValue
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
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    END
  ELSE
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:LocatorValue = ''
      BRW1::Sort1:LocatorLength = 0
      TES:U_NR = BRW1::Sort1:LocatorValue
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      TES:TEK_A = BRW1::Sort2:LocatorValue
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
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'TEK_SER')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = TES:U_NR
  OF 2
    BRW1::Sort2:HighValue = TES:TEK_A
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'TEK_SER')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = TES:U_NR
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  OF 2
    BRW1::Sort2:LowValue = TES:TEK_A
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
  TES:U_NR = BRW1::TES:U_NR
  TES:TEKSTS = BRW1::TES:TEKSTS
  TES:TEK_A = BRW1::TES:TEK_A
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
  BRW1::TES:U_NR = TES:U_NR
  BRW1::TES:TEKSTS = TES:TEKSTS
  BRW1::TES:TEK_A = TES:TEK_A
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
      POST(Event:Accepted,?Change)
      POST(Event:Accepted,?Delete:3)
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => TES:U_NR
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
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => UPPER(TES:TEK_A)
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
      BRW1::Sort1:LocatorValue = ''
      BRW1::Sort1:LocatorLength = 0
      TES:U_NR = BRW1::Sort1:LocatorValue
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      TES:TEK_A = BRW1::Sort2:LocatorValue
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
      POST(Event:Accepted,?Insert:3)
    OF DeleteKey
      POST(Event:Accepted,?Delete:3)
    OF CtrlEnter
      POST(Event:Accepted,?Change)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF KEYCODE() = BSKey
          IF BRW1::Sort1:LocatorLength
            BRW1::Sort1:LocatorLength -= 1
            BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength)
            TES:U_NR = BRW1::Sort1:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          TES:U_NR = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          TES:U_NR = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            TES:TEK_A = BRW1::Sort2:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          TES:TEK_A = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          TES:TEK_A = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
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
    OF 1
      TES:U_NR = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 2
      TES:TEK_A = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'TEK_SER')
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
      BRW1::HighlightedPosition = POSITION(TES:NR_KEY)
      RESET(TES:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(TES:NR_KEY,TES:NR_KEY)
    END
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(TES:NOS_KEY)
      RESET(TES:NOS_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(TES:NOS_KEY,TES:NOS_KEY)
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
    OF 1; ?TES:U_NR{Prop:Disable} = 0
    OF 2; ?TES:TEK_A{Prop:Disable} = 0
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
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(TES:Record)
    CASE BRW1::SortOrder
    OF 1; ?TES:U_NR{Prop:Disable} = 1
    OF 2; ?TES:TEK_A{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    ?Change{Prop:Disable} = 1
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
    SET(TES:NR_KEY)
  OF 2
    SET(TES:NOS_KEY)
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
  BrowseButtons.InsertButton=?Insert:3
  BrowseButtons.ChangeButton=?Change
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
  GET(TEK_SER,0)
  CLEAR(TES:Record,0)
  LocalRequest = InsertRecord
   IF COPYREQUEST=1
      DO SYNCWINDOW
      TES:U_NR=0
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
!| (UpdateTEK_SER) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateTEK_SER
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
        GET(TEK_SER,0)
        CLEAR(TES:Record,0)
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


UpdateAUTOTEX PROCEDURE


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
History::APX:Record LIKE(APX:Record),STATIC
SAV::APX:Record      LIKE(APX:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the AUTOTEX File'),AT(,,348,148),FONT('MS Sans Serif',8,,FONT:bold),IMM,HLP('UpdateAUTOTEX'),SYSTEM,GRAY,RESIZE,MDI
                       STRING(@n13),AT(262,4),USE(APX:PAV_NR)
                       SHEET,AT(4,10,337,111),USE(?CurrentTab)
                         TAB('Klienta sûdzîbas u.c.'),USE(?Tab:1)
                           OPTION,AT(61,27,95,64),USE(APX:PAZIME),BOXED
                             RADIO('Klienta sûdzîbas'),AT(65,34),USE(?APX:PAZIME:Radio1),VALUE('K')
                             RADIO('Papildus darbi'),AT(65,44),USE(?APX:PAZIME:Radio2),VALUE('P')
                             RADIO('Paliekoðie defekti'),AT(65,55),USE(?APX:PAZIME:Radio3),VALUE('N')
                             RADIO('Diagnostika'),AT(65,67),USE(?APX:PAZIME:Radio4:2),DISABLE
                             RADIO('Apkope'),AT(65,78),USE(?APX:PAZIME:Radio5),DISABLE
                           END
                           ENTRY(@s110),AT(14,97,319,10),USE(APX:TEKSTS)
                           BUTTON('no Faila'),AT(13,79,45,14),USE(?ButtonNom_k)
                         END
                       END
                       BUTTON('&OK'),AT(236,128,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(285,128,45,14),USE(?Cancel)
                       STRING(@s8),AT(7,128),USE(APX:ACC_KODS),FONT(,,COLOR:Gray,)
                       STRING(@D06.),AT(49,128),USE(APX:ACC_DATUMS),FONT(,,COLOR:Gray,)
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
    ActionMessage = 'Ieraksts tiksmainîts'
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
      SELECT(?APX:PAV_NR)
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
        History::APX:Record = APX:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(AUTOTEX)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?APX:PAV_NR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::APX:Record <> APX:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:AUTOTEX(1)
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
              SELECT(?APX:PAV_NR)
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
    OF ?ButtonNom_k
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BROWSETEK_SER 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GLOBALRESPONSE=REQUESTCOMPLETED
           APX:TEKSTS=tes:teksts
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
  IF AUTOTEX::Used = 0
    CheckOpen(AUTOTEX,1)
  END
  AUTOTEX::Used += 1
  BIND(APX:RECORD)
  FilesOpened = True
  RISnap:AUTOTEX
  SAV::APX:Record = APX:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    APX:PAV_NR=PAV:U_NR
    APX:PAZIME='K'
    APX:ACC_KODS=ACC_kods
    APX:ACC_DATUMS=today()
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:AUTOTEX()
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
  INIRestoreWindow('UpdateAUTOTEX','winlats.INI')
  WinResize.Resize
  ?APX:PAV_NR{PROP:Alrt,255} = 734
  ?APX:PAZIME{PROP:Alrt,255} = 734
  ?APX:TEKSTS{PROP:Alrt,255} = 734
  ?APX:ACC_KODS{PROP:Alrt,255} = 734
  ?APX:ACC_DATUMS{PROP:Alrt,255} = 734
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
    AUTOTEX::Used -= 1
    IF AUTOTEX::Used = 0 THEN CLOSE(AUTOTEX).
  END
  IF WindowOpened
    INISaveWindow('UpdateAUTOTEX','winlats.INI')
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
    OF ?APX:PAV_NR
      APX:PAV_NR = History::APX:Record.PAV_NR
    OF ?APX:PAZIME
      APX:PAZIME = History::APX:Record.PAZIME
    OF ?APX:TEKSTS
      APX:TEKSTS = History::APX:Record.TEKSTS
    OF ?APX:ACC_KODS
      APX:ACC_KODS = History::APX:Record.ACC_KODS
    OF ?APX:ACC_DATUMS
      APX:ACC_DATUMS = History::APX:Record.ACC_DATUMS
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
  APX:Record = SAV::APX:Record
  SAV::APX:Record = APX:Record
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

UpdateAuto PROCEDURE


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
AUT_START_U_NR       ULONG
Update::Reloop  BYTE
Update::Error   BYTE
History::AUT:Record LIKE(AUT:Record),STATIC
SAV::AUT:Record      LIKE(AUT:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:AUT:U_NR     LIKE(AUT:U_NR)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the AUTO File'),AT(,,273,177),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateAuto'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(5,6,265,147),USE(?CurrentTab)
                         TAB('&Pamatdati'),USE(?Tab:1)
                           STRING(@n13),AT(9,20),USE(AUT:U_NR)
                           PROMPT('Valsts Nr:'),AT(9,41),USE(?AUT:AUTO:Prompt)
                           ENTRY(@s12),AT(62,41,64,10),USE(AUT:V_Nr),UPR
                           ENTRY(@s7),AT(130,41,47,10),USE(AUT:V_Nr2),UPR
                           BUTTON('&Marka'),AT(10,52,45,14),USE(?ButtonMarka)
                           STRING(@s30),AT(62,56,134,10),USE(AUT:MARKA),LEFT(1)
                           BUTTON('Î&paðnieks'),AT(10,68,45,14),USE(?ButtonIpasnieks)
                           ENTRY(@s15),AT(62,71,47,10),USE(AUT:Par_nos)
                           STRING(@n13),AT(110,71),USE(AUT:Par_Nr)
                           PROMPT('&Vadîtâjs:'),AT(9,87),USE(?AUT:VU:Prompt)
                           ENTRY(@s35),AT(62,86,144,10),USE(AUT:Vaditajs)
                           PROMPT('Personas &kods:'),AT(9,99),USE(?AUT:PERSKODS:Prompt)
                           ENTRY(@P######-#####P),AT(62,99,52,10),USE(AUT:PERSKODS)
                           PROMPT('&Telefons'),AT(119,100),USE(?AUT:telefons:Prompt )
                           ENTRY(@s20),AT(153,98,47,10),USE(AUT:Telefons)
                         END
                         TAB('Papildus &Dati'),USE(?Tab:2)
                           PROMPT('&Izg. MM.gads:'),AT(11,27,46,10),USE(?AUT:GADS:Prompt )
                           ENTRY(@D014.B),AT(68,26,41,10),USE(AUT:MMYYYY),CENTER
                           PROMPT('&Virsbûves Nr:'),AT(10,38,48,10),USE(?AUT:Virsb_Nr:Prompt )
                           ENTRY(@s20),AT(68,38,99,10),USE(AUT:Virsb_Nr),UPR
                           PROMPT('D&zinçjs:'),AT(11,51,37,10),USE(?AUT:Dzinejs:Prompt)
                           ENTRY(@s20),AT(68,50,100,10),USE(AUT:Dzinejs),UPR
                           PROMPT('Dzinçja kods:'),AT(11,63,54,10),USE(?AUT:Dzineja_K:Prompt)
                           ENTRY(@s20),AT(68,62,89,10),USE(AUT:Dzineja_K),UPR
                           BUTTON('Krâsa'),AT(10,72,45,14),USE(?ButtonKrasa)
                           ENTRY(@s20),AT(68,74,77,10),USE(AUT:Krasa)
                           PROMPT('Pârdoðanas &datums:'),AT(11,89,69,10),USE(?AUT:PAR_DAT:Prompt)
                           ENTRY(@D06.B),AT(80,86),USE(AUT:PAR_DAT)
                           PROMPT('&Garantija lîdz:'),AT(11,100,51,10),USE(?AUT:GAR_DAT:Prompt)
                           ENTRY(@D06.B),AT(80,99),USE(AUT:GAR_DAT)
                           PROMPT('Garantija k&m:'),AT(137,100,48,10),USE(?AUT:Gar_km:Prompt)
                           ENTRY(@n13),AT(187,99),USE(AUT:Gar_km)
                           PROMPT('&Piezîmes:'),AT(11,113,36,10),USE(?AUT:piezimes:Prompt:2)
                           ENTRY(@s40),AT(58,113,206,10),USE(AUT:Piezimes)
                           PROMPT('Servisa grâmatiòa:'),AT(12,126,66,10)
                           ENTRY(@s8),AT(80,124,47,10),USE(AUT:SERVISAGRAM)
                           PROMPT('Izsn. datums:'),AT(137,126,47,10),USE(?AUT:SEGR_DAT:Prompt)
                           ENTRY(@D06.B),AT(187,124,47,10),USE(AUT:SEGR_DAT),RIGHT(1)
                           PROMPT('Patçriòð (l/100km):'),AT(13,138),USE(?AUT:PATERINS:Prompt)
                           ENTRY(@n-6.1),AT(80,136,31,10),USE(AUT:PATERINS),DECIMAL(12)
                         END
                       END
                       BUTTON('&OK'),AT(176,159,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(225,159,45,14),USE(?Cancel)
                       STRING(@s8),AT(7,162),USE(AUT:ACC_KODS),FONT(,,COLOR:Gray,)
                       STRING(@D06.B),AT(46,162),USE(AUT:ACC_DATUMS),FONT(,,COLOR:Gray,)
                     END
SAV_RECORD    LIKE(AUT:RECORD)
AUT_V_NR      LIKE(AUT:V_NR)
SAV_POSITION  STRING(260)
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
  ActionMessage='Aplûkoðanas reþîms'   !ja ir localrequest, sistçma pati pârrakstîs pâri
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
      SELECT(?AUT:U_NR)
      IF LOCALREQUEST=3
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-2)
      ELSIF LOCALREQUEST=0
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-1)
         ENABLE(?CurrentTab)
         ENABLE(?Tab:1)
         ENABLE(?Tab:2)
         SELECT(?cancel)
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
        History::AUT:Record = AUT:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(AUTO)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(AUT:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'AUT:NR_KEY')
                SELECT(?AUT:U_NR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?AUT:U_NR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::AUT:Record <> AUT:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:AUTO(1)
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
              SELECT(?AUT:U_NR)
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
    OF ?AUT:V_Nr
      CASE EVENT()
      OF EVENT:Accepted
        IF ~(AUT_V_NR=AUT:V_NR)  !MAIN'ITS VAI JAUNS NR
           SAV_RECORD=AUT:RECORD
           AUT_V_NR=AUT:V_NR
           SAV_POSITION=POSITION(AUTO)
           CLEAR(AUT:RECORD)
           AUT:V_NR=AUT_V_NR
           GET(AUTO,AUT:V_NR_KEY)
           IF ~ERROR()
              KLUDA(99,'vçl 1 a/m ar sâdu Valsts Nr. Ievadit vçlreiz ?')
              IF ~KLU_DARBIBA
                 SELECT(?AUT:V_NR)
              .
           .
           RESET(AUTO,SAV_POSITION)
           NEXT(AUTO)
           AUT:RECORD=SAV_RECORD
        .
      OF EVENT:Selected
        AUT_V_NR=AUT:V_NR
      END
    OF ?ButtonMarka
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseAutoMarkas 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GlobalResponse=RequestCompleted
            AUT:marka=AMA:MARKA
            DISPLAY
         .
      END
    OF ?ButtonIpasnieks
      CASE EVENT()
      OF EVENT:Accepted
        IF AUT:PAR_NR
           PAR_NR=AUT:PAR_NR
        .
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GlobalResponse=RequestCompleted
            AUT:par_nr=par:U_nr
            par_nr=par:U_nr
            AUT:PAR_NOS=PAR:NOS_S
            DISPLAY
         .
      END
    OF ?AUT:PERSKODS
      CASE EVENT()
      OF EVENT:Accepted
        CHECKKODS(aut:PERSKODS)
      END
    OF ?ButtonKrasa
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseAutoKra 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           AUT:Krasa=KRA:KRASA
           DISPLAY
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
           AUT:ACC_DATUMS=TODAY()
           AUT:ACC_KODS=ACC_KODS
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
  IF AUTO::Used = 0
    CheckOpen(AUTO,1)
  END
  AUTO::Used += 1
  BIND(AUT:RECORD)
  IF CONFIG::Used = 0
    CheckOpen(CONFIG,1)
  END
  CONFIG::Used += 1
  BIND(CON:RECORD)
  FilesOpened = True
  RISnap:AUTO
  SAV::AUT:Record = AUT:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
       AUT:ACC_DATUMS=TODAY()
       AUT:ACC_KODS=ACC_KODS
       if pav::u_nr  !TIEK SAUKTS NO P/Z
          AUT:PAR_NR=PAV:PAR_NR
          AUT:Par_nos=PAV:NOKA
       .
    END ! BEIDZAS LocalRequest = 1
    
    !  IF NOM:NOMENKLAT='' AND LOCALREQUEST=3  !NESAPROTAMA CLARA KÏÛDA
    !     LocalResponse = RequestCancelled
    !     DO PROCEDURERETURN
    !  .
    
      IF GNET !GLOBÂLAIS TÎKLS
         CASE LOCALREQUEST
         OF 1
            AUT:GNET_FLAG[1]=1
            AUT:GNET_FLAG[2]=''
         OF 2
            IF AUT:GNET_FLAG[1]=1     !JA STÂV ADD1 (NEKUR CITUR VÇL NAV IERAKSTÎTS)
            ELSIF AUT:GNET_FLAG[1]=4  !JA STÂV ADD4 (NE VISUR IR IERAKSTÎTS)
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSIF AUT:GNET_FLAG[1]=2  !JA STÂV PUT2 (NEKUR CITUR VÇL NAV NOMAINÎTS)
            ELSIF AUT:GNET_FLAG[1]=5  !JA STÂV PUT5 (NE VISUR IR NOMAINÎTS)
               AUT:GNET_FLAG[1]=2
               AUT:GNET_FLAG[2]=''    !MAINAM VISUR
            ELSIF AUT:GNET_FLAG[1]=3 OR AUT:GNET_FLAG[1]=6  !JA STÂV DEL 
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSE
               AUT:GNET_FLAG[1]=2
               AUT:GNET_FLAG[2]=''
            .
            SAV::AUT:Record = AUT:Record ! LAI NERAKSTA, JA NEKAS NAV MAINÎTS
         OF 3
    !        STOP(AUT:GNET_FLAG)
            IF AUT:GNET_FLAG[1]=1     !JA STÂV ADD1 (NEKUR CITUR VÇL NAV IERAKSTÎTS)
               AUT:GNET_FLAG=''
            ELSIF AUT:GNET_FLAG[1]=4  !JA STÂV ADD4 (NE VISUR IR IERAKSTÎTS)
               KLUDA(121,'dzçst, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSIF AUT:GNET_FLAG[1]=2  !JA STÂV PUT2 (NEKUR CITUR VÇL NAV NOMAINÎTS)
               AUT:GNET_FLAG[1]=3
               LOCALREQUEST=4
            ELSIF AUT:GNET_FLAG[1]=5  !JA STÂV PUT5 (NE VISUR IR NOMAINÎTS)
               AUT:GNET_FLAG[1]=3     !DZÇÐAM VISUR
               AUT:GNET_FLAG[2]=''
               LOCALREQUEST=4
            ELSIF AUT:GNET_FLAG[1]=3 OR AUT:GNET_FLAG[1]=6  !JA STÂV DEL
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSE
               AUT:GNET_FLAG[1]=3
               AUT:GNET_FLAG[2]=''
               LOCALREQUEST=4
            .
         .
      .
      IF LocalRequest = 4 ! DeleteRecord GNET
        IF StandardWarning(Warn:StandardDelete) = Button:OK
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            AUT:V_NR='WAIT FOR DEL'
            AUT:MARKA='WAIT FOR DEL'
            IF RIUPDATE:BANKAS_K()
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
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:AUTO()
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
  INIRestoreWindow('UpdateAuto','winlats.INI')
  WinResize.Resize
  ?AUT:U_NR{PROP:Alrt,255} = 734
  ?AUT:V_Nr{PROP:Alrt,255} = 734
  ?AUT:V_Nr2{PROP:Alrt,255} = 734
  ?AUT:MARKA{PROP:Alrt,255} = 734
  ?AUT:Par_nos{PROP:Alrt,255} = 734
  ?AUT:Par_Nr{PROP:Alrt,255} = 734
  ?AUT:Vaditajs{PROP:Alrt,255} = 734
  ?AUT:PERSKODS{PROP:Alrt,255} = 734
  ?AUT:Telefons{PROP:Alrt,255} = 734
  ?AUT:MMYYYY{PROP:Alrt,255} = 734
  ?AUT:Virsb_Nr{PROP:Alrt,255} = 734
  ?AUT:Dzinejs{PROP:Alrt,255} = 734
  ?AUT:Dzineja_K{PROP:Alrt,255} = 734
  ?AUT:Krasa{PROP:Alrt,255} = 734
  ?AUT:PAR_DAT{PROP:Alrt,255} = 734
  ?AUT:GAR_DAT{PROP:Alrt,255} = 734
  ?AUT:Gar_km{PROP:Alrt,255} = 734
  ?AUT:Piezimes{PROP:Alrt,255} = 734
  ?AUT:SERVISAGRAM{PROP:Alrt,255} = 734
  ?AUT:SEGR_DAT{PROP:Alrt,255} = 734
  ?AUT:PATERINS{PROP:Alrt,255} = 734
  ?AUT:ACC_KODS{PROP:Alrt,255} = 734
  ?AUT:ACC_DATUMS{PROP:Alrt,255} = 734
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
    AUTO::Used -= 1
    IF AUTO::Used = 0 THEN CLOSE(AUTO).
    CONFIG::Used -= 1
    IF CONFIG::Used = 0 THEN CLOSE(CONFIG).
  END
  IF WindowOpened
    INISaveWindow('UpdateAuto','winlats.INI')
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
    OF ?AUT:U_NR
      AUT:U_NR = History::AUT:Record.U_NR
    OF ?AUT:V_Nr
      AUT:V_Nr = History::AUT:Record.V_Nr
    OF ?AUT:V_Nr2
      AUT:V_Nr2 = History::AUT:Record.V_Nr2
    OF ?AUT:MARKA
      AUT:MARKA = History::AUT:Record.MARKA
    OF ?AUT:Par_nos
      AUT:Par_nos = History::AUT:Record.Par_nos
    OF ?AUT:Par_Nr
      AUT:Par_Nr = History::AUT:Record.Par_Nr
    OF ?AUT:Vaditajs
      AUT:Vaditajs = History::AUT:Record.Vaditajs
    OF ?AUT:PERSKODS
      AUT:PERSKODS = History::AUT:Record.PERSKODS
    OF ?AUT:Telefons
      AUT:Telefons = History::AUT:Record.Telefons
    OF ?AUT:MMYYYY
      AUT:MMYYYY = History::AUT:Record.MMYYYY
    OF ?AUT:Virsb_Nr
      AUT:Virsb_Nr = History::AUT:Record.Virsb_Nr
    OF ?AUT:Dzinejs
      AUT:Dzinejs = History::AUT:Record.Dzinejs
    OF ?AUT:Dzineja_K
      AUT:Dzineja_K = History::AUT:Record.Dzineja_K
    OF ?AUT:Krasa
      AUT:Krasa = History::AUT:Record.Krasa
    OF ?AUT:PAR_DAT
      AUT:PAR_DAT = History::AUT:Record.PAR_DAT
    OF ?AUT:GAR_DAT
      AUT:GAR_DAT = History::AUT:Record.GAR_DAT
    OF ?AUT:Gar_km
      AUT:Gar_km = History::AUT:Record.Gar_km
    OF ?AUT:Piezimes
      AUT:Piezimes = History::AUT:Record.Piezimes
    OF ?AUT:SERVISAGRAM
      AUT:SERVISAGRAM = History::AUT:Record.SERVISAGRAM
    OF ?AUT:SEGR_DAT
      AUT:SEGR_DAT = History::AUT:Record.SEGR_DAT
    OF ?AUT:PATERINS
      AUT:PATERINS = History::AUT:Record.PATERINS
    OF ?AUT:ACC_KODS
      AUT:ACC_KODS = History::AUT:Record.ACC_KODS
    OF ?AUT:ACC_DATUMS
      AUT:ACC_DATUMS = History::AUT:Record.ACC_DATUMS
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
  AUT:Record = SAV::AUT:Record
    AUT:Record = SAV::AUT:Record
    AUT_START_U_NR=0
    CLEAR(CON:RECORD)
    IF GNET
       CON:NR=GNET  !REÌISTRÂCIJÂ JÂNORÂDA LOC_NET U_NR
       GET(CONFIG,CON:NR_KEY)
       IF ERROR()
          KLUDA(120,'Ieraksts \winlats\bin\config.tps ar Nr :'&GNET)
       ELSIF ~CON:AUT_END_U_NR
          KLUDA(87,'PAR_K autonumerâcijas apgabals \winlats\bin\config.tps')
       ELSE
          AUT_START_U_NR=CON:AUT_END_U_NR-1000
          IF AUT_START_U_NR<0
             KLUDA(27,'AUTO autonumerâcijas apgabals \winlats\bin\config.tps')
          .
       .
    .
    SAV::AUT:Record = AUT:Record
    Auto::Attempts = 0
    LOOP
      IF CON:AUT_END_U_NR
         GET(AUTO,0)
         AUT:U_NR=CON:AUT_END_U_NR
         SET(AUT:NR_KEY,AUT:NR_KEY)
         PREVIOUS(AUTO)
         IF AUT:U_NR < AUT_START_U_NR
            AUT:U_NR=AUT_START_U_NR
         ELSIF AUT:U_NR=CON:AUT_END_U_NR
            KLUDA(45,'AUTO autonumerâcijas apgabals aizpildîts, nav vietas jauniem ierakstiem')
            POST(Event:CloseWindow)
            EXIT
         .
      ELSE
         SET(AUT:NR_KEY)
         PREVIOUS(AUTO)
      .
      IF ERRORCODE() AND ERRORCODE() <> BadRecErr
        StandardWarning(Warn:RecordFetchError,'AUTO')
        POST(Event:CloseWindow)
        EXIT
      END
      IF ERRORCODE()
        Auto::Save:AUT:U_NR = 1
      ELSE
        Auto::Save:AUT:U_NR = AUT:U_NR + 1
      END
      AUT:Record = SAV::AUT:Record
      AUT:U_NR = Auto::Save:AUT:U_NR
      SAV::AUT:Record = AUT:Record
      ADD(AUTO)
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
      IF INRANGE(CON:AUT_END_U_NR-AUT:U_NR,1,10)
         KLUDA(45,'PAR_K autonumerâcijas apgabalâ atlikuði '&CON:AUT_END_U_NR-AUT:U_NR&' brîvi ieraksti')
      .
      BREAK
    END
    EXIT
  SAV::AUT:Record = AUT:Record
  Auto::Attempts = 0
  LOOP
    SET(AUT:NR_KEY)
    PREVIOUS(AUTO)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'AUTO')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:AUT:U_NR = 1
    ELSE
      Auto::Save:AUT:U_NR = AUT:U_NR + 1
    END
    AUT:Record = SAV::AUT:Record
    AUT:U_NR = Auto::Save:AUT:U_NR
    SAV::AUT:Record = AUT:Record
      AUT:Record = SAV::AUT:Record
      AUT_START_U_NR=0
      CLEAR(CON:RECORD)
      IF GNET
         CON:NR=GNET  !REÌISTRÂCIJÂ JÂNORÂDA LOC_NET U_NR
         GET(CONFIG,CON:NR_KEY)
         IF ERROR()
            KLUDA(120,'Ieraksts \winlats\bin\config.tps ar Nr :'&GNET)
         ELSIF ~CON:AUT_END_U_NR
            KLUDA(87,'PAR_K autonumerâcijas apgabals \winlats\bin\config.tps')
         ELSE
            AUT_START_U_NR=CON:AUT_END_U_NR-1000
            IF AUT_START_U_NR<0
               KLUDA(27,'AUTO autonumerâcijas apgabals \winlats\bin\config.tps')
            .
         .
      .
      SAV::AUT:Record = AUT:Record
      Auto::Attempts = 0
      LOOP
        IF CON:AUT_END_U_NR
           GET(AUTO,0)
           AUT:U_NR=CON:AUT_END_U_NR
           SET(AUT:NR_KEY,AUT:NR_KEY)
           PREVIOUS(AUTO)
           IF AUT:U_NR < AUT_START_U_NR
              AUT:U_NR=AUT_START_U_NR
           ELSIF AUT:U_NR=CON:AUT_END_U_NR
              KLUDA(45,'AUTO autonumerâcijas apgabals aizpildîts, nav vietas jauniem ierakstiem')
              POST(Event:CloseWindow)
              EXIT
           .
        ELSE
           SET(AUT:NR_KEY)
           PREVIOUS(AUTO)
        .
        IF ERRORCODE() AND ERRORCODE() <> BadRecErr
          StandardWarning(Warn:RecordFetchError,'AUTO')
          POST(Event:CloseWindow)
          EXIT
        END
        IF ERRORCODE()
          Auto::Save:AUT:U_NR = 1
        ELSE
          Auto::Save:AUT:U_NR = AUT:U_NR + 1
        END
        AUT:Record = SAV::AUT:Record
        AUT:U_NR = Auto::Save:AUT:U_NR
        SAV::AUT:Record = AUT:Record
        ADD(AUTO)
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
        IF INRANGE(CON:AUT_END_U_NR-AUT:U_NR,1,10)
           KLUDA(45,'PAR_K autonumerâcijas apgabalâ atlikuði '&CON:AUT_END_U_NR-AUT:U_NR&' brîvi ieraksti')
        .
        BREAK
      END
      EXIT
    ADD(AUTO)
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
        DELETE(AUTO)
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

