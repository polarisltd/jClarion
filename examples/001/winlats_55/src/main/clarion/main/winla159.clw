                     MEMBER('winlats.clw')        ! This is a MEMBER module
BrowseAutoMarkas PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG

BRW1::View:Browse    VIEW(AUTOMARKAS)
                       PROJECT(AMA:MARKA)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::AMA:MARKA        LIKE(AMA:MARKA)            ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(AMA:MARKA),DIM(100)
BRW1::Sort1:LowValue LIKE(AMA:MARKA)              ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(AMA:MARKA)             ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Browse the AUTOMARKAS File'),AT(,,166,217),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseAutoMarkas'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,151,135),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('80L(2)|M~Automaðînu markas~@S30@'),FROM(Queue:Browse:1)
                       BUTTON('Iz&vçlçties'),AT(8,196,45,14),USE(?Select),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                       BUTTON('&Ievadît'),AT(8,180,45,14),USE(?Insert:3)
                       BUTTON('&Mainît'),AT(57,180,45,14),USE(?Change),DEFAULT
                       BUTTON('&Dzçst'),AT(106,180,45,14),USE(?Delete:3)
                       SHEET,AT(5,5,158,172),USE(?CurrentTab)
                         TAB('Marku secîba'),USE(?Tab:2)
                           ENTRY(@s30),AT(11,159,70,12),USE(AMA:MARKA)
                         END
                       END
                       BUTTON('&Beigt'),AT(106,198,45,14),USE(?Close)
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
     QUICKWINDOW{PROP:TEXT}='Izvçlaties a/m marku'
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
    OF ?AMA:MARKA
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?AMA:MARKA)
        IF AMA:MARKA
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = AMA:MARKA
          BRW1::Sort1:LocatorLength = LEN(CLIP(AMA:MARKA))
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
  IF AUTOMARKAS::Used = 0
    CheckOpen(AUTOMARKAS,1)
  END
  AUTOMARKAS::Used += 1
  BIND(AMA:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseAutoMarkas','winlats.INI')
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
    AUTOMARKAS::Used -= 1
    IF AUTOMARKAS::Used = 0 THEN CLOSE(AUTOMARKAS).
  END
  IF WindowOpened
    INISaveWindow('BrowseAutoMarkas','winlats.INI')
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
    AMA:MARKA = BRW1::Sort1:LocatorValue
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
  IF BRW1::SortOrder = 0
    BRW1::SortOrder = 1
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    END
  ELSE
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:LocatorValue = ''
      BRW1::Sort1:LocatorLength = 0
      AMA:MARKA = BRW1::Sort1:LocatorValue
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
  IF SEND(AUTOMARKAS,'QUICKSCAN=on').
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'AUTOMARKAS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = AMA:MARKA
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'AUTOMARKAS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = AMA:MARKA
    SetupStringStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue,SIZE(BRW1::Sort1:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  END
  IF SEND(AUTOMARKAS,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  AMA:MARKA = BRW1::AMA:MARKA
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
  BRW1::AMA:MARKA = AMA:MARKA
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => UPPER(AMA:MARKA)
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
      AMA:MARKA = BRW1::Sort1:LocatorValue
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
            AMA:MARKA = BRW1::Sort1:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          AMA:MARKA = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          AMA:MARKA = BRW1::Sort1:LocatorValue
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
      AMA:MARKA = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
    IF SEND(AUTOMARKAS,'QUICKSCAN=on').
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
        StandardWarning(Warn:RecordFetchError,'AUTOMARKAS')
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
    IF SEND(AUTOMARKAS,'QUICKSCAN=off').
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
      BRW1::HighlightedPosition = POSITION(AMA:KeyMARKA)
      RESET(AMA:KeyMARKA,BRW1::HighlightedPosition)
    ELSE
      SET(AMA:KeyMARKA,AMA:KeyMARKA)
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
    OF 1; ?AMA:MARKA{Prop:Disable} = 0
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
    CLEAR(AMA:Record)
    CASE BRW1::SortOrder
    OF 1; ?AMA:MARKA{Prop:Disable} = 1
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
    SET(AMA:KeyMARKA)
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
  GET(AUTOMARKAS,0)
  CLEAR(AMA:Record,0)
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
!| (UpdateAutoMarkas) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateAutoMarkas
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
        GET(AUTOMARKAS,0)
        CLEAR(AMA:Record,0)
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


UpdateNOM_K PROCEDURE


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
STATUSS              STRING(1)
SAV_NOMENKLAT        STRING(21)
DARBIBA              CSTRING(25)
RecordFiltered       LONG
SECTEXT              STRING(8)
NOM_NOMENKLAT        STRING(21)
NOM_GROUP            GROUP,PRE(),OVER(NOM_NOMENKLAT)
NOM_GRUPA            STRING(3)
NOM_AGRUPA           STRING(1)
NOM_ARTIKULS         STRING(12)
NOM_2B               STRING(2)
NOM_RAZ              STRING(3)
                     END
svara_vieniba        STRING(1)
X                    STRING(3)
MINRC_ar_PVN         DECIMAL(9,2)
KRIT_DAU             DECIMAL(7,2)
MAX_DAU              DECIMAL(7,2)
Update::Reloop  BYTE
Update::Error   BYTE
History::NOM:Record LIKE(NOM:Record),STATIC
SAV::NOM:Record      LIKE(NOM:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
FLD8::View           VIEW(MER_K)
                       PROJECT(MER:MERVIEN)
                     END
Queue:FileDropCombo  QUEUE,PRE
FLD8::MER:MERVIEN      LIKE(MER:MERVIEN)
                     END
FLD8::LoopIndex      LONG,AUTO
FLD5::View           VIEW(VAL_K)
                       PROJECT(VAL:V_KODS)
                       PROJECT(VAL:VALSTS)
                     END
Queue:FileDrop:2     QUEUE,PRE
FLD5::VAL:V_KODS       LIKE(VAL:V_KODS)
FLD5::VAL:VALSTS       LIKE(VAL:VALSTS)
                     END
FLD5::LoopIndex      LONG,AUTO
QuickWindow          WINDOW('Update the NOM_K File'),AT(,,376,286),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP(' '),CURSOR(CURSOR:None),GRAY,RESIZE,MDI
                       SHEET,AT(1,3,371,261),USE(?CurrentTab)
                         TAB('&Pamatdati'),USE(?Tab:1)
                           GROUP('&Nomenklatûra'),AT(9,24,176,60),USE(?Group1),BOXED
                             PROMPT('&Nomenklatûra:'),AT(19,48),USE(?NOM_GRUPA:Prompt)
                             ENTRY(@s3),AT(15,59,19,10),USE(NOM_GRUPA),IMM,LEFT,FONT('Fixedsys',,,FONT:regular),REQ,UPR
                             ENTRY(@s1),AT(34,59,9,10),USE(NOM_AGRUPA),IMM,CENTER,FONT('Fixedsys',,,FONT:regular,CHARSET:BALTIC),UPR
                             ENTRY(@s12),AT(44,59,59,10),USE(NOM_ARTIKULS),LEFT,FONT('Fixedsys',,,FONT:regular,CHARSET:BALTIC),UPR
                             ENTRY(@s2),AT(104,59,14,10),USE(NOM_2B),LEFT,FONT('Fixedsys',,,FONT:regular,CHARSET:BALTIC)
                             ENTRY(@s3),AT(119,59,19,10),USE(NOM_RAZ),IMM,LEFT,FONT('Fixedsys',,,FONT:regular),UPR
                             STRING('123-4-567890123456-78-901'),AT(18,72),USE(?String10),FONT('Fixedsys',9,COLOR:Gray,FONT:regular,CHARSET:BALTIC)
                             PROMPT('&Mçrvienîba:'),AT(139,48),USE(?Prompt24)
                             COMBO(@s7),AT(140,59,41,10),USE(NOM:MERVIEN),REQ,FORMAT('28L~MERVIEN~@s7@'),DROP(5),FROM(Queue:FileDropCombo)
                           END
                           BUTTON('&Grupa'),AT(14,33,45,14),USE(?ButtonGrupa)
                           BUTTON('Apak&ðgrupa'),AT(65,33,45,14),USE(?ButtonApaksgrupa)
                           BUTTON('Ra&þotâjs'),AT(117,33,45,14),USE(?ButtonRazotajs)
                           OPTION('&TIPS'),AT(187,24,107,89),USE(NOM:TIPS),BOXED
                             RADIO('Prece'),AT(191,35)
                             RADIO('Tara'),AT(191,44)
                             RADIO('A-Pakalpojumi'),AT(191,54),VALUE('A')
                             RADIO('Kokmateriâli'),AT(191,64)
                             RADIO('Raþojums'),AT(191,74),USE(?RAZOJUMS)
                             RADIO('Iepakojums'),AT(191,86),USE(?iepakojums),DISABLE
                             RADIO('Virtuâla (Avanss,Dâvanu k.)'),AT(191,98,102,10),USE(?NOM:TIPS:Radio14),TIP('Netiek rçíinâta bilances vçrtîba')
                           END
                           BUTTON('&Sastâvdaïas'),AT(235,73,53,14),USE(?SASTAVDALAS),DISABLE
                           OPTION('Statuss'),AT(294,24,75,64),USE(STATUSS),BOXED
                             RADIO('0-jâsûta uz KA'),AT(300,34),VALUE('0')
                             RADIO('1-jâpârraksta KA'),AT(300,43,67,10),VALUE('1')
                             RADIO('2-jâdzçð KA'),AT(300,54),VALUE('2')
                             RADIO('3-viss OK'),AT(300,64),VALUE('3')
                             RADIO('N-neredzama'),AT(300,73),USE(?STATUSS:Radio7),VALUE('N')
                           END
                           PROMPT('&Kataloga Nr:'),AT(14,84,53,10),USE(?NOM:KATALOGA_NR:Prompt)
                           ENTRY(@s22),AT(14,96,109,10),USE(NOM:KATALOGA_NR),FONT(,,,FONT:bold),MSG('(RAZOTAJA KODS)')
                           OPTION('EAN'),AT(14,107,69,35),USE(NOM:EAN,,?NOM:EAN:3),BOXED
                             RADIO('0 - NAV'),AT(18,120),USE(?nom:ean:Radio1),VALUE('0')
                             RADIO('1 - EAN13'),AT(18,131),USE(?nom:ean:radio2),VALUE('1')
                           END
                           PROMPT('EAN (Svît&ru Kods):'),AT(89,107,71,10),USE(?Prompt22)
                           ENTRY(@n-18.0),AT(86,120,74,10),USE(NOM:KODS),RIGHT(1)
                           ENTRY(@s1),AT(162,120,11,10),USE(NOM:KODS_PLUS)
                           BUTTON('Uzbuvçt kodu'),AT(176,118,53,12),USE(?ButtonUzbEAN)
                           PROMPT('&Bilances konts:'),AT(86,134,54,10),USE(?PromptBKK)
                           ENTRY(@s5),AT(142,134,25,10),USE(NOM:BKK)
                           PROMPT('61..... konts:'),AT(171,134,45,10),USE(?Prompt6KONTS)
                           ENTRY(@s5),AT(216,134,25,10),USE(NOM:OKK6)
                           BUTTON('PVN %'),AT(273,133,42,12),USE(?ButtonPVN)
                           ENTRY(@n2),AT(320,134,16,10),USE(NOM:PVN_PROC),RIGHT(1)
                           PROMPT('Analoga pa&zîme'),AT(241,119,54,10),USE(?NOM:ANALOGS:Prompt)
                           ENTRY(@s7),AT(298,119,36,10),USE(NOM:ANALOGS)
                           PROMPT('Nosauk&ums:'),AT(13,147),USE(?Prompt:Nosaukums)
                           ENTRY(@s50),AT(58,147,302,9),USE(NOM:NOS_P)
                           PROMPT('Saîs&inâtais nosaukums:'),AT(13,160),USE(?Prompt:NOS_S)
                           ENTRY(@s16),AT(94,159,111,9),USE(NOM:NOS_S)
                           STRING(@s8),AT(209,159),USE(NOM:NOS_A),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           PROMPT('Realizâcijas cena &1:'),AT(13,171,75,10),USE(?Prompt6)
                           ENTRY(@n-15.4),AT(94,171,55,10),USE(NOM:REALIZ[1]),RIGHT(1)
                           ENTRY(@s3),AT(150,171,23,10),USE(NOM:VAL[1])
                           BUTTON('bez PVN'),AT(182,171,42,12),USE(?arpvn1)
                           PROMPT('Realizâcijas cena &2:'),AT(13,184,74,10),USE(?Prompt6:2)
                           ENTRY(@n-15.4),AT(94,184,55,10),USE(NOM:REALIZ[2]),RIGHT(1)
                           ENTRY(@s3),AT(150,184,23,10),USE(NOM:VAL[2])
                           BUTTON('bez PVN'),AT(182,184,42,12),USE(?arpvn2)
                           PROMPT('Realizâcijas cena &3:'),AT(13,198,77,10),USE(?Prompt6:3)
                           ENTRY(@n-15.4),AT(94,197,55,10),USE(NOM:REALIZ[3]),RIGHT(1)
                           ENTRY(@s3),AT(150,197,23,10),USE(NOM:VAL[3])
                           BUTTON('bez PVN'),AT(182,197,42,12),USE(?arpvn3)
                           PROMPT('Realizâcijas cena &4:'),AT(13,210,74,10),USE(?Prompt6:4)
                           ENTRY(@n-15.4),AT(94,210,55,10),USE(NOM:REALIZ[4]),RIGHT(1)
                           ENTRY(@s3),AT(150,210,23,10),USE(NOM:VAL[4])
                           BUTTON('bez PVN'),AT(182,210,42,12),USE(?arpvn4)
                           PROMPT('Realiz. cena &5:'),AT(13,223,51,10),USE(?Prompt6:5)
                           ENTRY(@n-4.0),AT(65,223,17,10),USE(NOM:PROC5),RIGHT(1)
                           STRING('%'),AT(83,223,8,10),USE(?String20)
                           ENTRY(@n-15.4),AT(94,223,55,10),USE(NOM:REALIZ[5],,?NOM:REALIZ5),RIGHT(1)
                           ENTRY(@s3),AT(150,223,23,10),USE(NOM:VAL[5])
                           BUTTON('bez PVN'),AT(182,222,42,12),USE(?arpvn5)
                           BUTTON('L'),AT(225,222,13,12),USE(?Button5C)
                           IMAGE('CHECK3.ICO'),AT(240,217,16,18),USE(?Image5C),HIDE
                           PROMPT('Pçdçjâ iep. cena &6:'),AT(13,237,66,10),USE(?Prompt6:6)
                           ENTRY(@n-15.4),AT(94,236,55,10),USE(NOM:PIC),RIGHT(1)
                           STRING('bez PVN'),AT(168,237),USE(?String9)
                           ENTRY(@D06.B),AT(198,236,43,11),USE(NOM:PIC_DATUMS)
                           STRING(@s3),AT(150,237),USE(Val_uzsk)
                           PROMPT('MINRealizâcijas cena:'),AT(13,250,82,10),USE(?MINRC:PROMPT)
                           ENTRY(@n-15.4),AT(94,249,55,10),USE(NOM:MINRC),RIGHT(1)
                           STRING(@s3),AT(150,250),USE(Val_uzsk,,?val_uzsk:2)
                           STRING('bez PVN'),AT(167,249),USE(?String9:2)
                           STRING(@n_11.2b),AT(198,249),USE(MINRC_ar_PVN),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                         END
                         TAB('Papildus &dati'),USE(?Tab:2)
                           PROMPT('2.rinda P&Z/Atbilstîbas deklarâcija:'),AT(8,20,114,9),USE(?Prompt12)
                           ENTRY(@s50),AT(124,20,246,10),USE(NOM:RINDA2PZ),MSG('2.Rinda P/Z'),TIP('Atbildtîbas sertifikâts-standarts*Sert.Nr*der.term.')
                           PROMPT('C&its teksts:'),AT(9,32,39,10),USE(?Prompt12:2)
                           STRING(@s15),AT(49,32,65,10),USE(SYS:NOKL_TE)
                           ENTRY(@s21),AT(124,32,115,10),USE(NOM:CITS_TEKSTSPZ),MSG('Cits teksts P/Z')
                           PROMPT('ES K&N (muitas) kods:'),AT(17,48,73,10),USE(?NOM:MUITAS_KODS:Prompt)
                           ENTRY(@n_10B),AT(101,48,49,10),USE(NOM:MUITAS_KODS),RIGHT(1)
                           PROMPT('Izcelsmes VK:'),AT(157,48,50,10),USE(?VK:Prompt)
                           LIST,AT(208,44),USE(NOM:IZC_V_KODS),FORMAT('16L@s3@80L@s20@'),DROP(15),FROM(Queue:FileDrop:2)
                           PROMPT('Pârejas koef. uz ESKNPap.&Mçrvien.:'),AT(197,60,123,10),USE(?KOEF_ESKNPM:Prompt)
                           ENTRY(@n_8.3),AT(322,60,41,10),USE(NOM:KOEF_ESKNPM),RIGHT(1)
                           PROMPT('Muita:'),AT(17,62),USE(?NOM:MUITA:Prompt)
                           ENTRY(@n-12.3),AT(96,60,54,10),USE(NOM:MUITA),RIGHT(1)
                           PROMPT('Akcîze:'),AT(17,74),USE(?NOM:AKCIZE:Prompt)
                           ENTRY(@n-12.3),AT(96,72,54,10),USE(NOM:AKCIZE),RIGHT(1)
                           PROMPT('Derîguma &termiòð:'),AT(17,86,72,10),USE(?NOM:DER_TERM:Prompt:2)
                           ENTRY(@D6),AT(105,84,45,10),USE(NOM:DER_TERM),CENTER
                           PROMPT('&Svars (kg):'),AT(17,97),USE(?Prompt17)
                           ENTRY(@n_11.5),AT(100,97,50,10),USE(NOM:SVARSKG),RIGHT(1)
                           PROMPT('&Vienîbu sk. iepakojumâ:'),AT(17,111,81,10),USE(?Prompt18)
                           ENTRY(@N_11.4),AT(100,110,50,10),USE(NOM:SKAITS_I),RIGHT(1)
                           GROUP('Preèu daudzumi noliktavâ'),AT(12,122,203,34),USE(?GroupDAUDZUMI),BOXED
                           END
                           PROMPT('K&ritiskais:'),AT(28,138),USE(?Prompt16)
                           ENTRY(@n_7.2B),AT(63,138,45,10),USE(KRIT_DAU),RIGHT(1)
                           PROMPT('Maksimâlais:'),AT(112,138),USE(?NOM:MAX_DAU:Prompt)
                           ENTRY(@n_7.2b),AT(162,136,45,10),USE(MAX_DAU),RIGHT(1)
                           PROMPT('Preèu grupa (DG):'),AT(96,174,65,10),USE(?NOM:DG:Prompt)
                           ENTRY(@n1b),AT(160,174,21,10),USE(NOM:DG),MSG('Atlaides grupa'),TIP('Atlaides grupa')
                           BUTTON('At&bildîgais'),AT(147,189,65,17),USE(?Atbildigais)
                           ENTRY(@n_6B),AT(221,192,27,12),USE(NOM:ATBILDIGAIS)
                           STRING(@s8),AT(250,193,38,10),USE(SECTEXT),LEFT(1)
                           PROMPT('&Katrâm'),AT(17,162),USE(?Prompt26)
                           ENTRY(@n3),AT(47,162,27,10),USE(NOM:ETIKETES),RIGHT(1)
                           STRING('preces vienîbâm drukât 1 SvK uzlîmi'),AT(77,162),USE(?String12)
                           PROMPT('Punkti:'),AT(17,174),USE(?NOM:PUNKTI:Prompt)
                           ENTRY(@n_10.3),AT(47,174,46,10),USE(NOM:PUNKTI),RIGHT(1)
                           OPTION('&Redzamîba:'),AT(12,190,106,54),USE(NOM:REDZAMIBA),BOXED
                             RADIO('Aktîva'),AT(24,201),USE(?NOM:REDZAMIBA:Radio1),VALUE('0')
                             RADIO('Arhîvs'),AT(24,211),USE(?NOM:REDZAMIBA:Radio2),VALUE('1')
                             RADIO('Nâkotnes'),AT(24,220),USE(?NOM:REDZAMIBA:Radio3),VALUE('2')
                             RADIO('Likvidçjama'),AT(24,231),USE(?NOM:REDZAMIBA:Radio3:2),VALUE('3')
                           END
                           BUTTON('Ad&reses plauktâ'),AT(146,208,65,17),USE(?ButtonAdreses)
                           IMAGE('CHECK3.ICO'),AT(215,208,17,17),USE(?Imageadreses),HIDE
                           BUTTON('Nosaukums EN/RU'),AT(237,208,68,17),USE(?ButtonCYR)
                           IMAGE('CHECK3.ICO'),AT(308,208,17,17),USE(?ImageCYR),HIDE
                           BUTTON('Nedot at&laidi'),AT(146,228,65,17),USE(?ButtonNeAtl)
                           IMAGE('CHECK3.ICO'),AT(308,228,17,17),USE(?ImageAPR),HIDE
                           BUTTON('Akcijas &prece'),AT(237,228,68,17),USE(?ButtonAPR)
                           IMAGE('CHECK3.ICO'),AT(215,228,17,17),USE(?ImageNEAT),HIDE
                         END
                       END
                       STRING(@s8),AT(5,270),USE(NOM:ACC_KODS),RIGHT,FONT(,,COLOR:Gray,)
                       STRING(@D06.B),AT(43,270),USE(NOM:ACC_DATUMS),LEFT,FONT(,,COLOR:Gray,)
                       BUTTON('&OK'),AT(262,266,54,16),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(320,266,52,16),USE(?Cancel)
                     END
SAV_NOM              GROUP;BYTE,DIM(SIZE(NOM:RECORD)).
SAV_STATUSS          STRING(1)
SAV_NOS_S            LIKE(NOM:NOS_S)
SAV_KODS             LIKE(NOM:KODS)
SAV_REALIZ           LIKE(NOM:REALIZ)
ZINA                 STRING(20)

RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
Progress:Thermometer BYTE

ProgressWindow WINDOW('Progress...'),AT(,,142,46),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
     END

R_TABLE  QUEUE,PRE(R)
RECORD     LIKE(KOM:RECORD)
         .
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
  SAV_STATUSS = NOM:STATUSS[LOC_NR]
  SAV_NOMENKLAT = NOM:NOMENKLAT
  SAV_NOS_S   =  NOM:NOS_S
  SAV_KODS    =  NOM:KODS
  SAV_REALIZ :=: NOM:REALIZ
  CHILDCHANGED=FALSE
  
  
  LOOP I#=1 TO 5
    IF ~NOM:VAL[I#]
       NOM:VAL[I#]=val_uzsk
    .
  .
  
  STATUSS = NOM:STATUSS[LOC_NR]
  ?statuss{PROP:TEXT}='Statuss '&LOC_NR&' noliktavâ'
  KRIT_DAU = NOM:KRIT_DAU[LOC_NR]
  MAX_DAU  = NOM:MAX_DAU[LOC_NR]
  ?GroupDAUDZUMI{PROP:TEXT}='Preèu daudzumi '&LOC_NR&' noliktavâ'
  CASE NOM:TIPS
  OF 'A'
     NOM:BKK=''
     DISABLE(?NOM:BKK)
  OF 'R'
     IF ~(F:VALODA='X') !LAI NEAIZIET BEZGALÎGÂ CIKLÂ
        ENABLE(?SASTAVDALAS)
     .
     HIDE(?NOM:MUITA)
     HIDE(?NOM:MUITA:Prompt)
     HIDE(?NOM:AKCIZE)
     HIDE(?NOM:AKCIZE:PROMPT)
  .
  CLEAR(PAR:RECORD)
  IF LocalRequest=1 AND ~CTRLC#
     SELECT(?NOM:TIPS)
  ELSE
     SELECT(?NOM:NOS_P)
  END
  IF BAND(NOM:ARPVNBYTE,00000001b) THEN ?ARPVN1{PROP:TEXT}='ar  PVN'.
  IF BAND(NOM:ARPVNBYTE,00000010b) THEN ?ARPVN2{PROP:TEXT}='ar  PVN'.
  IF BAND(NOM:ARPVNBYTE,00000100b) THEN ?ARPVN3{PROP:TEXT}='ar  PVN'.
  IF BAND(NOM:ARPVNBYTE,00001000b) THEN ?ARPVN4{PROP:TEXT}='ar  PVN'.
  IF BAND(NOM:ARPVNBYTE,00010000b) THEN ?ARPVN5{PROP:TEXT}='ar  PVN'.
  
  IF     BAND(NOM:BAITS1,00001000B) AND ~BAND(NOM:BAITS1,00010000B) THEN svara_vieniba='1' !SVARS PAR 100 VIENÎBÂM
  ELSIF ~BAND(NOM:BAITS1,00001000B) AND  BAND(NOM:BAITS1,00010000B) THEN svara_vieniba='0' !SVARS PAR 0.01 VIENÎBU
  ELSE svara_vieniba='V'. !SVARS PAR 1 VIENÎBU
  
  MINRC_ar_PVN=nom:minrc*(1+nom:pvn_proc/100)
  SECTEXT=GETPAROLES(NOM:ATBILDIGAIS,1)
  IF BAND(NOM:NEATL,00000001b)
     UNHIDE(?IMAGENEAT)
  ELSE
     HIDE(?IMAGENEAT)
  .
  IF BAND(NOM:NEATL,00000010b)
     UNHIDE(?IMAGEAPR)
  ELSE
     HIDE(?IMAGEAPR)
  .
  NOM_NOMENKLAT :=: NOM:NOMENKLAT
  ActionMessage='Aplûkoðanas reþîms'   !ja ir localrequest, sistçma pati pârrakstîs pâri
  IF GETNOM_ADRESE(NOM:NOMENKLAT,0) !IR DEFINÇTA ADRESE(PLAUKTS)
     UNHIDE(?Imageadreses)
  .
  IF GETNOM_VALODA(NOM:NOMENKLAT,4) !IR DEFINÇTA CYR,ANG
     UNHIDE(?ImageCYR)
  .
  IF BAND(NOM:BAITS1,00000010b)    !AR PVN NEAPLIEKAMS
     ?BUTTONPVN{PROP:TEXT}='PVN neapl.'
     DISABLE(?NOM:PVN_PROC)
  .
  IF BAND(NOM:BAITS1,00000100b)
     UNHIDE(?IMAGE5C)
  .
  
  !*******USER LEVEL ACCESS CONTROL********
  IF ~BAND(REG_NOL_ACC,00010000b) ! KOMPLEKTÂCIJA
     DISABLE(?Sastavdalas)
     DISABLE(?RAZOJUMS)
  .
  !*******INI LEVEL ACCESS CONTROL********
  IF DUP_NOM_KODS=TRUE
     ENABLE(?NOM:KODS_PLUS)
  .
  !*******PAROL LEVEL ACCESS CONTROL********
  IF ATLAUTS[24]='1' !AIZLIEGTS TIRGOT ZEM MIN RC
     DISABLE(?NOM:MINRC)
  .
  !*************IEPAKOJUMI***********
  IF NOM:NOMENKLAT[1:4]='IEP*'
     DISABLE(?NOM_RAZ,?OK-1)
     ENABLE(?Prompt:Nosaukums)
     ENABLE(?NOM:NOS_P)
     ENABLE(?Prompt:Nos_s)
     ENABLE(?NOM:NOS_S)
     ENABLE(?Prompt6)
     ?Prompt6{PROP:TEXT}='Likme'
     ENABLE(?NOM:REALIZ_1)
     ENABLE(?Prompt6:2)
     ?Prompt6:2{PROP:TEXT}='Nodokïa atvieglojums'
     ENABLE(?NOM:REALIZ_2)
     NOM:VAL[2]='%'
     ENABLE(?TAB:2)
     ENABLE(?KOEF_ESKNPM:Prompt)
     ENABLE(?NOM:KOEF_ESKNPM)
     ENABLE(?VK:Prompt)
     ENABLE(?NOM:IZC_V_KODS)
     ENABLE(?NOM:MUITAS_KODS:Prompt)
     ENABLE(?NOM:MUITAS_KODS)
  .
  IF COPYREQUEST=1 AND NOMENKLAT !TIEK KOPÇTS RAÞOJUMS
     CLEAR(KOM:RECORD)
     KOM:NOMENKLAT=NOMENKLAT
     SET(KOM:NOM_KEY,KOM:NOM_KEY)
     LOOP
        NEXT(KOMPLEKT)
        IF ~(KOM:NOMENKLAT=NOMENKLAT) OR ERROR() THEN BREAK.
        R:RECORD=KOM:RECORD
        ADD(R_TABLE)
     .
     DISABLE(?SASTAVDALAS)
  .
  
  DISPLAY
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
    NOM_NOMENKLAT=INIGEN(NOM_NOMENKLAT,21,1)
    NOM_NOMENKLAT=UPPER(NOM_NOMENKLAT)
    DISPLAY
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
      DO FLD8::FillList
      DO FLD5::FillList
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?NOM_GRUPA:Prompt)
      IF LOCALREQUEST=3
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-2)
         enable(?Tab:1)  !ATVÇRT CURRENTTAB NEDRÎKST
         SELECT(?cancel)
      ELSIF LOCALREQUEST=0
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-1)
         enable(?Tab:1)
         enable(?Tab:2)
         ENABLE(?CURRENTTAB)
         ENABLE(?ButtonAdreses)
         hide(?nom:proc5)
         hide(?NOM:REALIZ5)
         hide(?nom:pic)
         SELECT(?cancel)
      ELSIF LOCALREQUEST=1
      !
      ELSE
         SELECT(?cancel)
      .
      IF ATLAUTS[11]='1' !AIZLIEGTS APSKATÎT D P/Z UN JEBKURU PIEEJU IEP CENÂM
         hide(?nom:proc5)
         hide(?NOM:REALIZ5)
         hide(?nom:pic)
      .
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
        History::NOM:Record = NOM:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(NOM_K)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(NOM:NOM_KEY)
              IF StandardWarning(Warn:DuplicateKey,'NOM:NOM_KEY')
                SELECT(?NOM_GRUPA:Prompt)
                VCRRequest = VCRNone
                CYCLE
              END
            END
            IF DUPLICATE(NOM:KOD_KEY)
              IF StandardWarning(Warn:DuplicateKey,'NOM:KOD_KEY')
                SELECT(?NOM_GRUPA:Prompt)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?NOM_GRUPA:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::NOM:Record <> NOM:Record
              RecordChanged = True
            END
            !PIRMS WWW
            IF RecordChanged THEN
              Update::Error = RIUpdate:NOM_K(1)
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
              SELECT(?NOM_GRUPA:Prompt)
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
    NOM:NOMENKLAT = NOM_NOMENKLAT
    IF DUPLICATE(NOM:NOM_KEY)
       KLUDA(0,'Veidojas dubultas atslçgas ar ðo Nomenklatûru...')
       SELECT(?NOM_ARTIKULS)
    .
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
          OF 3
          OF 4
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?NOM_GRUPA
      CASE EVENT()
      OF EVENT:NewSelection
        !TIKAI, JA IR IMM
        UPDATE(?NOM_GRUPA)
        IF LEN(CLIP(NOM_GRUPA)) = SIZE(NOM_GRUPA) AND KEYCODE()<> MouseLeft
          SELECT(?+1)
        END
      END
    OF ?NOM_AGRUPA
      CASE EVENT()
      OF EVENT:NewSelection
        UPDATE(?NOM_AGRUPA)
        UPDATE(?NOM_GRUPA)
        IF NOM_GRUPA='IEP' AND NOM_AGRUPA='*'
           DISABLE(?NOM_RAZ,?OK-1)
           ENABLE(?Prompt:Nosaukums)
           ENABLE(?NOM:NOS_P)
           ENABLE(?Prompt:Nos_s)
           ENABLE(?NOM:NOS_S)
           ENABLE(?Prompt6)
           ?Prompt6{PROP:TEXT}='Likme'
           ENABLE(?NOM:REALIZ_1)
           ENABLE(?Prompt6:2)
           ?Prompt6:2{PROP:TEXT}='Nodokïa atvieglojums'
           ENABLE(?NOM:REALIZ_2)
           NOM:VAL[2]='%'
           NOM:TIPS='I'
           NOM:MERVIEN='kg.'
           DISPLAY
        .
        IF LEN(CLIP(NOM_AGRUPA)) = SIZE(NOM_AGRUPA) AND KEYCODE()<> MouseLeft
          SELECT(?+1)
        END
      END
    OF ?NOM_ARTIKULS
      CASE EVENT()
      OF EVENT:Accepted
        !TIKAI, JA NAV IMM
        NOM:NOMENKLAT = NOM_NOMENKLAT
        IF DUPLICATE(NOM:NOM_KEY)
           KLUDA(0,'Veidojas dubultas atslçgas ar ðo Nomenklatûru...')
           SELECT(?NOM_ARTIKULS)
        .
        IF LOCALREQUEST=1
           LOOP L#=1 TO LEN(CLIP(NOM:NOMENKLAT))
              IF INSTRING(NOM:NOMENKLAT[L#],' ,;:*"/()',1)  !' .,;:*"/()',1)
                 IF NOM:NOMENKLAT[L#]=' ' AND (CL_NR=1464 OR CL_NR=1102)   !ÎLE&ADREM
                    KLUDA(0,'Nomenklatûrâ neatïauts TUKÐUMS')
                 ELSIF NOM:NOMENKLAT[L#]=' ' 
                    CYCLE
                 ELSE
                    KLUDA(0,'Nomenklatûrai neatïauts simbols '&NOM:NOMENKLAT[L#])
                 .
                 SELECT(?NOM_ARTIKULS)
              .
           .
        .
      END
    OF ?NOM_RAZ
      CASE EVENT()
      OF EVENT:NewSelection
        UPDATE(?NOM_RAZ)
        IF LEN(CLIP(NOM_RAZ)) = SIZE(NOM_RAZ) AND KEYCODE()<> MouseLeft
          SELECT(?+1)
        END
      END
    OF ?NOM:MERVIEN
      CASE EVENT()
      OF EVENT:Accepted
        IF NOM:MERVIEN AND ~ACCEPTED#
        FLD8::MER:MERVIEN = NOM:MERVIEN
        GET(Queue:FileDropCombo,FLD8::MER:MERVIEN)
        IF ERRORCODE() THEN
          SELECT(?NOM:MERVIEN)
        END
        END
        IF NOM:MERVIEN
           CHECKOPEN(MER_K,1)
           MER:MERVIEN = NOM:MERVIEN
           GET(MER_K,MER:MER_KEY)
           IF ERROR()
               GlobalRequest = SelectRecord
               BrowseMER_K
               IF GlobalResponse = RequestCompleted
                   NOM:MERVIEN = MER:MERVIEN
                   DISPLAY()
               ELSE
                   BEEP
                   SELECT(?)
               .
           .
           IF NOM:MERVIEN
              ACCEPTED#=1
           .
        .
      END
    OF ?ButtonGrupa
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         GlobalRequest = SelectRecord             ! Set Action for Lookup
         BrowseGrupas                             ! Call the Lookup Procedure
         LocalResponse = GlobalResponse           ! Save Action for evaluation
         GlobalResponse = RequestCancelled        ! Clear Action
         IF LocalResponse = RequestCompleted      ! IF Lookup completed
           nom_GRUPA=gr1:grupa1;display           ! Source on Completion
         END                                      ! END (IF Lookup completed)
         LocalResponse = RequestCancelled
      END
    OF ?ButtonApaksgrupa
      CASE EVENT()
      OF EVENT:Accepted
        IF ~getgrupa(NOM_GRUPA,1,1)
           CYCLE
        .
        DO SyncWindow
        GlobalRequest = SelectRecord
        UpdateGrupa1 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           NOM_AGRUPA=GR2:GRUPA2
           IF ~BAND(NOM:BAITS1,00000100b) !~LOCKED
              NOM:PROC5=GR2:PROC
           .
        .
        DISPLAY
      END
    OF ?ButtonRazotajs
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         GlobalRequest = SelectRecord             ! Set Action for Lookup
         BrowsePAR_K                              ! Call the Lookup Procedure
         LocalResponse = GlobalResponse           ! Save Action for evaluation
         GlobalResponse = RequestCancelled        ! Clear Action
         IF LocalResponse = RequestCompleted      ! IF Lookup completed
           NOM_RAZ=PAR:NOS_U;display              ! Source on Completion
         END                                      ! END (IF Lookup completed)
         LocalResponse = RequestCancelled
      END
    OF ?NOM:TIPS
      CASE EVENT()
      OF EVENT:Accepted
        ENABLE(?NOM:BKK)
        DISABLE(?SASTAVDALAS)
        UNHIDE(?NOM:MUITA)
        UNHIDE(?NOM:MUITA:Prompt)
        UNHIDE(?NOM:AKCIZE)
        UNHIDE(?NOM:AKCIZE:PROMPT)
        CASE NOM:TIPS
        OF 'A'
           NOM:BKK = ''
           DISABLE(?NOM:BKK)
        OF 'R'
           IF ~(F:VALODA='X') !LAI NEAIZIET BEZGALÎGÂ CIKLÂ
              ENABLE(?SASTAVDALAS)
           .
           HIDE(?NOM:MUITA)
           HIDE(?NOM:MUITA:Prompt)
           HIDE(?NOM:AKCIZE)
           HIDE(?NOM:AKCIZE:PROMPT)
        END
      END
    OF ?SASTAVDALAS
      CASE EVENT()
      OF EVENT:Accepted
        NOM:NOMENKLAT = NOM_NOMENKLAT
!        NOM:NOMENKLAT[1:3]  =NOM_GRUPA
!        NOM:NOMENKLAT[4]    =NOM_AGRUPA
!        NOM:NOMENKLAT[5:16] =NOM_ARTIKULS
!        NOM:NOMENKLAT[17:18]=NOM_2B
!        NOM:NOMENKLAT[19:21]=NOM_RAZ
!!        IF LOCALREQUEST=INSERTRECORD AND DUPLICATE(NOM:NOM_KEY)
        IF DUPLICATE(NOM:NOM_KEY)
           KLUDA(0,'Veidojas dubultas atslçgas ar ðo Nomenklatûru...')
           SELECT(?NOM_ARTIKULS)
           CYCLE
        .
        DO SyncWindow
        BrowseKomplekt 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF LOCALREQUEST=INSERTRECORD
           IF BILANCE !IR RAKSTI KOMPLEKT
              DISABLE(NOM_GRUPA)
              DISABLE(NOM_AGRUPA)
              DISABLE(NOM_ARTIKULS)
              DISABLE(NOM_2B)
              DISABLE(NOM_RAZ)
              DISABLE(?CANCEL)
              BILANCE=0
           ELSE
              ENABLE(NOM_GRUPA)
              ENABLE(NOM_AGRUPA)
              ENABLE(NOM_ARTIKULS)
              ENABLE(NOM_2B)
              ENABLE(NOM_RAZ)
              ENABLE(?CANCEL)
           .
        .
        IF CHILDCHANGED=TRUE
           DISABLE(?CANCEL)
        .
        DISPLAY
      END
    OF ?STATUSS
      CASE EVENT()
      OF EVENT:Accepted
        NOM:STATUSS[LOC_NR] = STATUSS
      END
    OF ?NOM:KODS
      CASE EVENT()
      OF EVENT:Accepted
        IF NOM:EAN = '1'
            NOM:KODS = CHECKEAN(NOM:KODS,1)
            DISPLAY(?NOM:KODS)
        END
        IF DUPLICATE(NOM:KOD_KEY)
           KLUDA(0,'Veidojas dubultas atslçgas ar ðo EAN KODU...')
           SELECT(?NOM:KODS)
        .
      END
    OF ?ButtonUzbEAN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOM:KODS=PERFORMGL(7)
        DISPLAY
      END
    OF ?NOM:BKK
      CASE EVENT()
      OF EVENT:Accepted
        NOM:BKK = GETKON_K(NOM:BKK,1,1)
        DISPLAY
      END
    OF ?NOM:OKK6
      CASE EVENT()
      OF EVENT:Accepted
        NOM:OKK6 = GETKON_K(NOM:OKK6,1,1)
        DISPLAY
      END
    OF ?ButtonPVN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOM:BAITS1,00000010b)    !AR PVN NEAPLIEKAMS
           NOM:BAITS1-=2
           ?BUTTONPVN{PROP:TEXT}='PVN %'
           ENABLE(?NOM:PVN_PROC)
        ELSE
           NOM:BAITS1+=2
           NOM:PVN_PROC=0
           ?BUTTONPVN{PROP:TEXT}='PVN neapl.'
           DISABLE(?NOM:PVN_PROC)
        .
        DISPLAY
      END
    OF ?NOM:PVN_PROC
      CASE EVENT()
      OF EVENT:Accepted
        IF NOM:PVN_PROC > 22
          IF StandardWarning(Warn:OutOfRangeHigh,'NOM:PVN_PROC','22')
            SELECT(?NOM:PVN_PROC)
            QuickWindow{Prop:AcceptAll} = False
            CYCLE
          END
        END
      END
    OF ?NOM:NOS_P
      CASE EVENT()
      OF EVENT:Accepted
        IF NOM:NOS_S = ''
            NOM:NOS_S = NOM:NOS_P[1:16]
            NOM:NOS_A = INIGEN(NOM:NOS_S,8,1)
            DISPLAY(?NOM:NOS_S)
            DISPLAY(?NOM:NOS_A)
        END
        
      END
    OF ?NOM:NOS_S
      CASE EVENT()
      OF EVENT:Accepted
         NOM:NOS_A = INIGEN(NOM:NOS_S,8,1)
         DISPLAY(?NOM:NOS_A)
      END
    OF ?NOM:VAL_1
      CASE EVENT()
      OF EVENT:Accepted
        !?NOM:VAL[1] = CHECKNOS(NOM:VAL[1])
      END
    OF ?arpvn1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOM:ARPVNBYTE,00000001b)
           ?ARPVN1{PROP:TEXT}='bez PVN'
           NOM:ARPVNBYTE-=1
        ELSE
           ?ARPVN1{PROP:TEXT}='ar  PVN'
           NOM:ARPVNBYTE+=1
        .
      END
    OF ?NOM:VAL_2
      CASE EVENT()
      OF EVENT:Accepted
        !?NOM:VAL[2] = CHECKNOS(NOM:VAL[2])
      END
    OF ?arpvn2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOM:ARPVNBYTE,00000010b)
           ?ARPVN2{PROP:TEXT}='bez PVN'
           NOM:ARPVNBYTE-=2
        ELSE
           ?ARPVN2{PROP:TEXT}='ar  PVN'
           NOM:ARPVNBYTE+=2
        .
      END
    OF ?NOM:VAL_3
      CASE EVENT()
      OF EVENT:Accepted
        !?NOM:VAL[3] = CHECKNOS(NOM:VAL[3])
      END
    OF ?arpvn3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOM:ARPVNBYTE,00000100b)
           ?ARPVN3{PROP:TEXT}='bez PVN'
           NOM:ARPVNBYTE-=4
        ELSE
           ?ARPVN3{PROP:TEXT}='ar  PVN'
           NOM:ARPVNBYTE+=4
        .
      END
    OF ?NOM:VAL_4
      CASE EVENT()
      OF EVENT:Accepted
        !?NOM:VAL[4] = CHECKNOS(NOM:VAL[4])
      END
    OF ?arpvn4
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOM:ARPVNBYTE,00001000b)
           ?ARPVN4{PROP:TEXT}='bez PVN'
           NOM:ARPVNBYTE-=8
        ELSE
           ?ARPVN4{PROP:TEXT}='ar  PVN'
           NOM:ARPVNBYTE+=8
        .
      END
    OF ?NOM:VAL_5
      CASE EVENT()
      OF EVENT:Accepted
        !?NOM:VAL[5] = CHECKNOS(NOM:VAL[5])
      END
    OF ?arpvn5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOM:ARPVNBYTE,00010000b)
           ?ARPVN5{PROP:TEXT}='bez PVN'
           NOM:ARPVNBYTE-=16
        ELSE
           ?ARPVN5{PROP:TEXT}='ar  PVN'
           NOM:ARPVNBYTE+=16
        .
      END
    OF ?Button5C
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOM:BAITS1,00000100b)
           NOM:BAITS1-=4
           HIDE(?IMAGE5C)
        ELSE
           NOM:BAITS1+=4
           UNHIDE(?IMAGE5C)
        .
        DISPLAY
      END
    OF ?NOM:MINRC
      CASE EVENT()
      OF EVENT:Accepted
        MINRC_ar_PVN=nom:minrc*(1+nom:pvn_proc/100)
        DISPLAY(?MINRC_ar_PVN)
      END
    OF ?NOM:IZC_V_KODS
      CASE EVENT()
      OF EVENT:Accepted
        GET(Queue:FileDrop:2,CHOICE())
        NOM:IZC_V_KODS = FLD5::VAL:V_KODS
      OF EVENT:Selected
          IF ~NULLKODS#
            FLD5::VAL:V_KODS = ''
            FLD5::VAL:VALSTS = 'Nav norâdîts'
            ADD(Queue:FileDrop:2)
            NULLKODS#=1
          .
      END
    OF ?Atbildigais
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        Paroles 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           NOM:ATBILDIGAIS=SEC:U_NR
           SECTEXT=SEC:PUBLISH
        .
      END
    OF ?ButtonAdreses
      CASE EVENT()
      OF EVENT:Accepted
        NOMENKLAT=NOM:NOMENKLAT  !IZMANTOJAM, LAI ZINÂTU, KA VAJADZÇS FILTRU
        DO SyncWindow
        BrowseNom_P 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GETNOM_ADRESE(NOM:NOMENKLAT,0) !IR DEFINÇTA ADRESE(plaukts)
           UNHIDE(?Imageadreses)
        ELSE
           HIDE(?Imageadreses)
        .
        NOMENKLAT=''
      END
    OF ?ButtonCYR
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        UpdateNOM_C 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GETNOM_VALODA(NOM:NOMENKLAT,4) !IR DEFINÇTS NOSAUKUMS CYR,ANG
           UNHIDE(?ImageCYR)
        .
        
      END
    OF ?ButtonNeAtl
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOM:NEATL,00000001b)
           NOM:NEATL-=1
           HIDE(?IMAGENEAT)
        ELSE
           NOM:NEATL+=1
           UNHIDE(?IMAGENEAT)
        .
        DISPLAY
      END
    OF ?ButtonAPR
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOM:NEATL,00000010b)
           NOM:NEATL-=2
           HIDE(?IMAGEAPR)
        ELSE
           NOM:NEATL+=2
           UNHIDE(?IMAGEAPR)
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
        NOM:NOMENKLAT = NOM_NOMENKLAT
        NOLNOTOK#=FALSE
        IF LOCALREQUEST=CHANGERECORD AND ~(SAV_NOMENKLAT=NOM:NOMENKLAT)
           IF GNET  !GLOBÂLÂ TÎKLÂ NOMENKLAT MAINÎT AIZLIEGTS
              KLUDA(121,'mainît NOMENKLATÛRU')
              NOLNOTOK#=TRUE
           ELSE
              LOOP T#=1 TO nol_sk
                 CLOSE(NOLIK)
                 NOLIKNAME='NOLIK'&FORMAT(T#,@N02)
                 IF DOS_CONT(CLIP(NOLIKNAME)&'.TPS',2)
                    OPEN(NOLIK,12h)
                    IF ERROR()
                       TAKA"=PATH()
                       KLUDA(1,CLIP(TAKA")&'\'&NOLIKNAME)
                       NOLNOTOK#=TRUE
                       BREAK
                    .
                 .
                 CLOSE(AUTODARBI)
                 ADARBINAME='ADARBI'&FORMAT(T#,@N02)
                 IF DOS_CONT(CLIP(ADARBINAME)&'.TPS',2)
                    OPEN(AUTODARBI,12h)
                    IF ERROR()
                       TAKA"=PATH()
                       KLUDA(1,CLIP(TAKA")&'\'&ADARBINAME)
                       NOLNOTOK#=TRUE
                       BREAK
                    .
                 .
              .
              CLOSE(NOLIK)
              NOLIKNAME='NOLIK'&FORMAT(LOC_NR,@N02)      !Noliekam, ko paòçmâm
              CLOSE(AUTODARBI)
              ADARBINAME='ADARBI'&FORMAT(LOC_NR,@N02)
           .
           IF NOLNOTOK#=FALSE
              KLUDA(51,SAV_NOMENKLAT&'->'&NOM:NOMENKLAT)
              IF KLU_DARBIBA
                 OPEN(ProgressWindow)
                 LOOP T#=1 TO nol_sk
                    CLOSE(NOLIK)
                    NOLIKNAME='NOLIK'&FORMAT(T#,@N02)
                    IF DOS_CONT(CLIP(NOLIKNAME)&'.TPS',2)
                       OPEN(NOLIK,12h)
                       IF ERROR()
                          TAKA"=PATH()
                          KLUDA(1,CLIP(TAKA")&'\'&NOLIKNAME)
                       ELSE
                          Progress:Thermometer = 0
                          ?Progress:PctText{Prop:Text} = '0%'
                          ProgressWindow{Prop:Text} = 'Konvertçjam NOLIKTAVAS'
                          ?Progress:UserString{Prop:Text}=''
                          RecordsToProcess=records(nolik)
                          RecordsProcessed = 0
                          RecordsThisCycle = 0
                          SET(NOLIK)
                          LOOP
                             NEXT(NOLIK)
                             IF ERROR() THEN BREAK.
                             DO PROGRESSBAR
                             IF NOL:NOMENKLAT=SAV_NOMENKLAT
                                NOL:NOMENKLAT=NOM:NOMENKLAT
                                IF RIUPDATE:NOLIK()
                                   KLUDA(24,'RAKSTOT NOLIK:'&ERROR())
                                .
                             .
                          .
        !                  BUILD(NOLIK)
                          I#=GETNOM_A(SAV_NOMENKLAT,9,4) !MAINÎT NOM_A
                       .
                    .
                    CLOSE(AUTODARBI)
                    ADARBINAME='ADARBI'&FORMAT(T#,@N02)
                    IF DOS_CONT(CLIP(ADARBINAME)&'.TPS',2)
                       OPEN(AUTODARBI,12h)
                       IF ERROR()
                          TAKA"=PATH()
                          KLUDA(1,CLIP(TAKA")&'\'&ADARBINAME)
                       ELSE
                          Progress:Thermometer = 0
                          ?Progress:PctText{Prop:Text} = '0% Izpildîti'
                          ProgressWindow{Prop:Text} = 'Konvertçjam AUTODARBUS'
                          ?Progress:UserString{Prop:Text}=''
                          RecordsToProcess=records(AUTODARBI)
                          RecordsProcessed = 0
                          RecordsThisCycle = 0
                          SET(AUTODARBI)
                          LOOP
                             NEXT(AUTODARBI)
                             IF ERROR() THEN BREAK.
                             DO PROGRESSBAR
                             IF APD:NOMENKLAT=SAV_NOMENKLAT
                                APD:NOMENKLAT=NOM:NOMENKLAT
                                IF RIUPDATE:AUTODARBI()
                                   KLUDA(24,'RAKSTOT AUTODARBI:'&ERROR())
                                .
                             .
                          .
                       .
                    .
                 .
                 CLOSE(KOMPLEKT)
                 OPEN(KOMPLEKT,12h)
                 IF ERROR()
                    TAKA"=PATH()
                    KLUDA(1,CLIP(TAKA")&'\KOMPLEKT')
                 ELSE
                    Progress:Thermometer = 0
                    ?Progress:PctText{Prop:Text} = '0%'
                    ProgressWindow{Prop:Text} = 'Konvertçjam KOMPLEKT'
                    ?Progress:UserString{Prop:Text}=''
                    RecordsToProcess=records(KOMPLEKT)
                    RecordsProcessed = 0
                    RecordsThisCycle = 0
                    SET(KOMPLEKT)
                    LOOP
                       NEXT(KOMPLEKT)
                       IF ERROR() THEN BREAK.
                       DO PROGRESSBAR
                       IF KOM:NOMENKLAT=SAV_NOMENKLAT
                          KOM:NOMENKLAT=NOM:NOMENKLAT
                          IF RIUPDATE:KOMPLEKT()
                             KLUDA(24,'RAKSTOT KOMPLEKT:'&ERROR())
                          .
                       .
                       IF KOM:NOM_SOURCE=SAV_NOMENKLAT
                          KOM:NOM_SOURCE=NOM:NOMENKLAT
                          IF RIUPDATE:KOMPLEKT()
                             KLUDA(24,'RAKSTOT KOMPLEKT:'&ERROR())
                          .
                       .
                    .
                 .
                 close(ProgressWindow)
                 CLOSE(NOLIK)
                 NOLIKNAME='NOLIK'&FORMAT(LOC_NR,@N02)   !Noliekam, ko paòçmâm
                 CHECKOPEN(NOLIK,1)
                 I#=GETNOM_ADRESE(SAV_NOMENKLAT,2)       !MAINÎT PLAUKTU
                 CLOSE(AUTODARBI)
                 ADARBINAME='ADARBI'&FORMAT(LOC_NR,@N02)
              .
           ELSE
              NOM:NOMENKLAT=SAV_NOMENKLAT ! NEDRÎKST MAINÎT, JO NEVAR MONOPOLIZÇT VISUS FAILUS
              NOM_NOMENKLAT :=: NOM:NOMENKLAT
              SELECT(?NOM_GRUPA)          !ÐITAS VISS NEZ KÂPÇC NEIET...
              POST(EVENT:Selected)
              VCRRequest = VCRNone
              DISPLAY
              CYCLE
           .
        .
        IF ~(SAV_NOS_S=NOM:NOS_S AND SAV_KODS=NOM:KODS AND SAV_REALIZ[1]=NOM:REALIZ[1] AND SAV_REALIZ[2]=NOM:REALIZ[2])
           NOM:STATUSS[LOC_NR]='0'
        ELSE
           NOM:STATUSS[LOC_NR]=STATUSS
        .
        NOM:KRIT_DAU[LOC_NR]=KRIT_DAU
        NOM:MAX_DAU[LOC_NR]=MAX_DAU
        NOM:ACC_KODS=ACC_kods
        NOM:ACC_DATUMS=today()
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
  IF GRUPA1::Used = 0
    CheckOpen(GRUPA1,1)
  END
  GRUPA1::Used += 1
  BIND(GR1:RECORD)
  IF GRUPA2::Used = 0
    CheckOpen(GRUPA2,1)
  END
  GRUPA2::Used += 1
  BIND(GR2:RECORD)
  IF KOMPLEKT::Used = 0
    CheckOpen(KOMPLEKT,1)
  END
  KOMPLEKT::Used += 1
  BIND(KOM:RECORD)
  IF MER_K::Used = 0
    CheckOpen(MER_K,1)
  END
  MER_K::Used += 1
  BIND(MER:RECORD)
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
  IF VAL_K::Used = 0
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  BIND(VAL:RECORD)
  FilesOpened = True
  RISnap:NOM_K
  SAV::NOM:Record = NOM:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
        IF ~COPYREQUEST
           NOM:EAN='0'
           NOM:TIPS='P'
           NOM:ARPVNBYTE=31 !VISAS AR PVN
    !       NOM:MERVIEN='gab.'
           NOM:PVN_PROC=SYS:NOKL_PVN
           NOM:STATUSS='0{25}'
        .
        IF COPYREQUEST=TRUE AND DUP_NOM_KODS=TRUE
           IF NOM:KODS
              NOM:KODS_PLUS=CHR(VAL(NOM:KODS_PLUS)+1)
           .
        ELSE
           NOM:KODS_PLUS=''
           NOM:KODS=PERFORMGL(7)
       .
        NOM:ATBILDIGAIS=ACC_KODS_N
        NOM:ACC_KODS=ACC_kods
        NOM:ACC_DATUMS=today()
    END ! BEIDZAS LocalRequest = 1
      IF NOM:NOMENKLAT='' AND LOCALREQUEST=3  !NESAPROTAMA CLARA KÏÛDA
         LocalResponse = RequestCancelled
         DO PROCEDURERETURN
      .
      IF GNET !GLOBÂLAIS TÎKLS
         CASE LOCALREQUEST
         OF 1
            NOM:GNET_FLAG[1]=1
            NOM:GNET_FLAG[2]=''
         OF 2
            IF NOM:GNET_FLAG[1]=1     !JA STÂV ADD1 (NEKUR CITUR VÇL NAV IERAKSTÎTS)
            ELSIF NOM:GNET_FLAG[1]=4  !JA STÂV ADD4 (NE VISUR IR IERAKSTÎTS)
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSIF NOM:GNET_FLAG[1]=2  !JA STÂV PUT2 (NEKUR CITUR VÇL NAV NOMAINÎTS)
            ELSIF NOM:GNET_FLAG[1]=5  !JA STÂV PUT5 (NE VISUR IR NOMAINÎTS)
               NOM:GNET_FLAG[1]=2
               NOM:GNET_FLAG[2]=''    !MAINAM VISUR
            ELSIF NOM:GNET_FLAG[1]=3 OR NOM:GNET_FLAG[1]=6  !JA STÂV DEL 
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSE
               NOM:GNET_FLAG[1]=2
               NOM:GNET_FLAG[2]=''
            .
            SAV::NOM:Record = NOM:Record ! LAI NERAKSTA, JA NEKAS NAV MAINÎTS
         OF 3
    !        STOP(NOM:GNET_FLAG)
            IF NOM:GNET_FLAG[1]=1     !JA STÂV ADD1 (NEKUR CITUR VÇL NAV IERAKSTÎTS)
               NOM:GNET_FLAG=''
            ELSIF NOM:GNET_FLAG[1]=4  !JA STÂV ADD4 (NE VISUR IR IERAKSTÎTS)
               KLUDA(121,'dzçst, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSIF NOM:GNET_FLAG[1]=2  !JA STÂV PUT2 (NEKUR CITUR VÇL NAV NOMAINÎTS)
               NOM:GNET_FLAG[1]=3
               LOCALREQUEST=4
            ELSIF NOM:GNET_FLAG[1]=5  !JA STÂV PUT5 (NE VISUR IR NOMAINÎTS)
               NOM:GNET_FLAG[1]=3     !DZÇÐAM VISUR
               NOM:GNET_FLAG[2]=''
               LOCALREQUEST=4
            ELSIF NOM:GNET_FLAG[1]=3 OR NOM:GNET_FLAG[1]=6  !JA STÂV DEL
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSE
               NOM:GNET_FLAG[1]=3
               NOM:GNET_FLAG[2]=''
               LOCALREQUEST=4
            .
         .
      .
      IF LocalRequest = 4 ! DeleteRecord GNET
        IF StandardWarning(Warn:StandardDelete) = Button:OK
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            NOM:NOS_S='WAITING FOR DEL.'
            NOM:NOS_A='W.F.DEL'
            IF RIUPDATE:NOM_K()
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
        IF RIDelete:NOM_K()
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
  IF WindowPosInit THEN
    SETPOSITION(0,WindowXPos,WindowYPos)
  ELSE
    GETPOSITION(0,WindowXPos,WindowYPos)
    WindowPosInit=True
  END
  ?NOM:MERVIEN{PROP:Alrt,255} = 734
  ?NOM:TIPS{PROP:Alrt,255} = 734
  ?NOM:KATALOGA_NR{PROP:Alrt,255} = 734
  ?NOM:EAN:3{PROP:Alrt,255} = 734
  ?NOM:KODS{PROP:Alrt,255} = 734
  ?NOM:KODS_PLUS{PROP:Alrt,255} = 734
  ?NOM:BKK{PROP:Alrt,255} = 734
  ?NOM:OKK6{PROP:Alrt,255} = 734
  ?NOM:PVN_PROC{PROP:Alrt,255} = 734
  ?NOM:ANALOGS{PROP:Alrt,255} = 734
  ?NOM:NOS_P{PROP:Alrt,255} = 734
  ?NOM:NOS_S{PROP:Alrt,255} = 734
  ?NOM:NOS_A{PROP:Alrt,255} = 734
  ?NOM:PROC5{PROP:Alrt,255} = 734
  ?NOM:PIC{PROP:Alrt,255} = 734
  ?NOM:PIC_DATUMS{PROP:Alrt,255} = 734
  ?NOM:MINRC{PROP:Alrt,255} = 734
  ?NOM:RINDA2PZ{PROP:Alrt,255} = 734
  ?NOM:CITS_TEKSTSPZ{PROP:Alrt,255} = 734
  ?NOM:MUITAS_KODS{PROP:Alrt,255} = 734
  ?NOM:IZC_V_KODS{PROP:Alrt,255} = 734
  ?NOM:KOEF_ESKNPM{PROP:Alrt,255} = 734
  ?NOM:MUITA{PROP:Alrt,255} = 734
  ?NOM:AKCIZE{PROP:Alrt,255} = 734
  ?NOM:DER_TERM{PROP:Alrt,255} = 734
  ?NOM:SVARSKG{PROP:Alrt,255} = 734
  ?NOM:SKAITS_I{PROP:Alrt,255} = 734
  ?NOM:DG{PROP:Alrt,255} = 734
  ?NOM:ATBILDIGAIS{PROP:Alrt,255} = 734
  ?NOM:ETIKETES{PROP:Alrt,255} = 734
  ?NOM:PUNKTI{PROP:Alrt,255} = 734
  ?NOM:REDZAMIBA{PROP:Alrt,255} = 734
  ?NOM:ACC_KODS{PROP:Alrt,255} = 734
  ?NOM:ACC_DATUMS{PROP:Alrt,255} = 734
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
        IF LocalRequest=1  !IEVADÎÐANA
    !       STOP('NOM_K:INS')
           I#=GETNOM_A(NOM:NOMENKLAT,9,1)
        ELSIF LocalRequest = DeleteRecord !DZÇÐANA
           I#=GETNOM_A(NOM:NOMENKLAT,9,3)
           KopsN(NOM:NOMENKLAT,TODAY(),'D',3)
        .
     .
     IF COPYREQUEST=1 AND NOMENKLAT !TIEK KOPÇTS RAÞOJUMS
       LOOP I#=1 TO RECORDS(R_TABLE)
          GET(R_TABLE,I#)
          KOM:RECORD=R:RECORD
          KOM:NOMENKLAT=NOM:NOMENKLAT
    !      STOP('RAKSTU KOMPLEKT'&KOM:NOMENKLAT)
          ADD(KOMPLEKT)
       .
       FREE(R_TABLE)
       COPYREQUEST=0
       NOMENKLAT=''
    .
    GRUPA1::Used -= 1
    IF GRUPA1::Used = 0 THEN CLOSE(GRUPA1).
    GRUPA2::Used -= 1
    IF GRUPA2::Used = 0 THEN CLOSE(GRUPA2).
    KOMPLEKT::Used -= 1
    IF KOMPLEKT::Used = 0 THEN CLOSE(KOMPLEKT).
    MER_K::Used -= 1
    IF MER_K::Used = 0 THEN CLOSE(MER_K).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
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
PROGRESSBAR       ROUTINE
    RecordsProcessed += 1
    RecordsThisCycle += 1
    IF PercentProgress < 100
      PercentProgress = (RecordsProcessed / RecordsToProcess)*100
      IF PercentProgress > 100
        PercentProgress = 100
      END
      IF PercentProgress <> Progress:Thermometer THEN
        Progress:Thermometer = PercentProgress
        ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
        DISPLAY()
      END
    END
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?NOM:MERVIEN
      NOM:MERVIEN = History::NOM:Record.MERVIEN
    OF ?NOM:TIPS
      NOM:TIPS = History::NOM:Record.TIPS
    OF ?NOM:KATALOGA_NR
      NOM:KATALOGA_NR = History::NOM:Record.KATALOGA_NR
    OF ?NOM:EAN:3
      NOM:EAN = History::NOM:Record.EAN
    OF ?NOM:KODS
      NOM:KODS = History::NOM:Record.KODS
    OF ?NOM:KODS_PLUS
      NOM:KODS_PLUS = History::NOM:Record.KODS_PLUS
    OF ?NOM:BKK
      NOM:BKK = History::NOM:Record.BKK
    OF ?NOM:OKK6
      NOM:OKK6 = History::NOM:Record.OKK6
    OF ?NOM:PVN_PROC
      NOM:PVN_PROC = History::NOM:Record.PVN_PROC
    OF ?NOM:ANALOGS
      NOM:ANALOGS = History::NOM:Record.ANALOGS
    OF ?NOM:NOS_P
      NOM:NOS_P = History::NOM:Record.NOS_P
    OF ?NOM:NOS_S
      NOM:NOS_S = History::NOM:Record.NOS_S
    OF ?NOM:NOS_A
      NOM:NOS_A = History::NOM:Record.NOS_A
    OF ?NOM:PROC5
      NOM:PROC5 = History::NOM:Record.PROC5
    OF ?NOM:PIC
      NOM:PIC = History::NOM:Record.PIC
    OF ?NOM:PIC_DATUMS
      NOM:PIC_DATUMS = History::NOM:Record.PIC_DATUMS
    OF ?NOM:MINRC
      NOM:MINRC = History::NOM:Record.MINRC
    OF ?NOM:RINDA2PZ
      NOM:RINDA2PZ = History::NOM:Record.RINDA2PZ
    OF ?NOM:CITS_TEKSTSPZ
      NOM:CITS_TEKSTSPZ = History::NOM:Record.CITS_TEKSTSPZ
    OF ?NOM:MUITAS_KODS
      NOM:MUITAS_KODS = History::NOM:Record.MUITAS_KODS
    OF ?NOM:IZC_V_KODS
      NOM:IZC_V_KODS = History::NOM:Record.IZC_V_KODS
    OF ?NOM:KOEF_ESKNPM
      NOM:KOEF_ESKNPM = History::NOM:Record.KOEF_ESKNPM
    OF ?NOM:MUITA
      NOM:MUITA = History::NOM:Record.MUITA
    OF ?NOM:AKCIZE
      NOM:AKCIZE = History::NOM:Record.AKCIZE
    OF ?NOM:DER_TERM
      NOM:DER_TERM = History::NOM:Record.DER_TERM
    OF ?NOM:SVARSKG
      NOM:SVARSKG = History::NOM:Record.SVARSKG
    OF ?NOM:SKAITS_I
      NOM:SKAITS_I = History::NOM:Record.SKAITS_I
    OF ?NOM:DG
      NOM:DG = History::NOM:Record.DG
    OF ?NOM:ATBILDIGAIS
      NOM:ATBILDIGAIS = History::NOM:Record.ATBILDIGAIS
    OF ?NOM:ETIKETES
      NOM:ETIKETES = History::NOM:Record.ETIKETES
    OF ?NOM:PUNKTI
      NOM:PUNKTI = History::NOM:Record.PUNKTI
    OF ?NOM:REDZAMIBA
      NOM:REDZAMIBA = History::NOM:Record.REDZAMIBA
    OF ?NOM:ACC_KODS
      NOM:ACC_KODS = History::NOM:Record.ACC_KODS
    OF ?NOM:ACC_DATUMS
      NOM:ACC_DATUMS = History::NOM:Record.ACC_DATUMS
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
  NOM:Record = SAV::NOM:Record
  NOM:ETIKETES = 1
  SAV::NOM:Record = NOM:Record
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

!--------------------------------------------------------
FLD8::FillList ROUTINE
!|
!| This routine is used to fill the queue that is used by the FileDropCombo (FDC)
!| control template.
!|
!| First, the queue used by the FDC (Queue:FileDropCombo) is FREEd, in case this routine is
!| called by EMBED code, when the window gains focus, and after the UpdateProcedure,
!| if any, is completed.
!|
!| Next, the VIEW used by the FDC is setup and opened. In a loop, each record of the
!| view is retrieved and, if applicable, added to the FDC queue. The view is then closed.
!|
!| Finally, the queue is sorted, and the necessary record retrieved.
!|
  FREE(Queue:FileDropCombo)
  FLD8::MER:MERVIEN = NOM:MERVIEN
  SET(MER:MER_KEY)
  FLD8::View{Prop:Filter} = ''
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(FLD8::View)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  LOOP
    NEXT(FLD8::View)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'MER_K')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    FLD8::MER:MERVIEN = MER:MERVIEN
    ADD(Queue:FileDropCombo)
  END
  CLOSE(FLD8::View)
  IF RECORDS(Queue:FileDropCombo)
    SORT(Queue:FileDropCombo,FLD8::MER:MERVIEN)
    IF NOM:MERVIEN
      LOOP FLD8::LoopIndex = 1 TO RECORDS(Queue:FileDropCombo)
        GET(Queue:FileDropCombo,FLD8::LoopIndex)
        IF NOM:MERVIEN = FLD8::MER:MERVIEN THEN BREAK.
      END
      ?NOM:MERVIEN{Prop:Selected} = FLD8::LoopIndex
    ELSE
      GET(Queue:FileDropCombo,1)
      NOM:MERVIEN = FLD8::MER:MERVIEN
      ?NOM:MERVIEN{Prop:Selected} = 1
    END
  ELSE
    CLEAR(NOM:MERVIEN)
  END

!----------------------------------------------------
FLD5::FillList ROUTINE
!|
!| This routine is used to fill the queue that is used by the FileDrop (FD)
!| control template.
!|
!| First, the queue used by the FD (Queue:FileDrop:2) is FREEd, in case this routine is
!| called by EMBED code and when the window gains focus.
!|
!| Next, the VIEW used by the FD is setup and opened. In a loop, each record of the
!| view is retrieved and, if applicable, added to the FD queue. The view is then closed.
!|
!| Finally, the queue is sorted, and the necessary record retrieved.
!|
  FREE(Queue:FileDrop:2)
  SET(VAL:KODS_KEY)
  FLD5::View{Prop:Filter} = ''
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(FLD5::View)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  LOOP
    NEXT(FLD5::View)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'VAL_K')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    FLD5::VAL:V_KODS = VAL:V_KODS
    FLD5::VAL:VALSTS = VAL:VALSTS
    ADD(Queue:FileDrop:2)
  END
  CLOSE(FLD5::View)
  IF RECORDS(Queue:FileDrop:2)
    IF NOM:IZC_V_KODS
      LOOP FLD5::LoopIndex = 1 TO RECORDS(Queue:FileDrop:2)
        GET(Queue:FileDrop:2,FLD5::LoopIndex)
        IF NOM:IZC_V_KODS = FLD5::VAL:V_KODS THEN BREAK.
      END
      ?NOM:IZC_V_KODS{Prop:Selected} = FLD5::LoopIndex
    END
  ELSE
    CLEAR(NOM:IZC_V_KODS)
  END
UpdateNOM_P PROCEDURE


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
History::NOP:Record LIKE(NOP:Record),STATIC
SAV::NOP:Record      LIKE(NOP:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the NOM_P File'),AT(,,196,127),FONT('MS Sans Serif',8,,FONT:bold),IMM,HLP('UpdateNOM_P'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(1,4,194,98),USE(?CurrentTab)
                         TAB('Atraðanâs orientieri konkrçtâ noliktavâ'),USE(?Tab:1)
                           PROMPT('&Nomenklatûra:'),AT(8,22),USE(?NOP:NOMENKLAT:Prompt)
                           ENTRY(@S21),AT(71,21),USE(NOP:NOMENKLAT),DISABLE
                           PROMPT('Noliktava:'),AT(8,36),USE(?NOP:NOL_NR:Prompt)
                           ENTRY(@n2),AT(71,35,18,12),USE(NOP:NOL_NR)
                           PROMPT('&Plaukts:'),AT(8,49),USE(?NOP:PLAUKTS:Prompt)
                           ENTRY(@S15),AT(71,49,64,10),USE(NOP:PLAUKTS)
                           PROMPT('Komentârs:'),AT(8,62,61,10),USE(?NOP:KOMENTARS:Prompt)
                           ENTRY(@S25),AT(71,62,104,10),USE(NOP:KOMENTARS)
                         END
                       END
                       BUTTON('&OK'),AT(102,111,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(151,111,45,14),USE(?Cancel)
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
  IF ~NOMENKLAT
     ENABLE(NOP:NOMENKLAT)
  ELSE
     NOP:NOMENKLAT=NOMENKLAT
  .
  IF ~NOP:NOL_NR
     IF NOP:KOMENTARS[2]=':'
        NOP:NOL_NR=NOP:KOMENTARS[1]
     ELSIF NOP:KOMENTARS[3]=':'
        NOP:NOL_NR=NOP:KOMENTARS[1:2]
     ELSE
        NOP:NOL_NR=LOC_NR
     .
  .
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
      SELECT(?NOP:NOMENKLAT:Prompt)
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
        History::NOP:Record = NOP:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(NOM_P)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?NOP:NOMENKLAT:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::NOP:Record <> NOP:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:NOM_P(1)
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
              SELECT(?NOP:NOMENKLAT:Prompt)
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
  IF NOM_P::Used = 0
    CheckOpen(NOM_P,1)
  END
  NOM_P::Used += 1
  BIND(NOP:RECORD)
  FilesOpened = True
  RISnap:NOM_P
  SAV::NOP:Record = NOP:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    !NOP:KOMENTARS=CLIP(LOC_NR)&': '
    NOP:NOL_NR=LOC_NR
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:NOM_P()
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
  INIRestoreWindow('UpdateNOM_P','winlats.INI')
  WinResize.Resize
  ?NOP:NOMENKLAT{PROP:Alrt,255} = 734
  ?NOP:NOL_NR{PROP:Alrt,255} = 734
  ?NOP:PLAUKTS{PROP:Alrt,255} = 734
  ?NOP:KOMENTARS{PROP:Alrt,255} = 734
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
    NOM_P::Used -= 1
    IF NOM_P::Used = 0 THEN CLOSE(NOM_P).
  END
  IF WindowOpened
    INISaveWindow('UpdateNOM_P','winlats.INI')
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
    OF ?NOP:NOMENKLAT
      NOP:NOMENKLAT = History::NOP:Record.NOMENKLAT
    OF ?NOP:NOL_NR
      NOP:NOL_NR = History::NOP:Record.NOL_NR
    OF ?NOP:PLAUKTS
      NOP:PLAUKTS = History::NOP:Record.PLAUKTS
    OF ?NOP:KOMENTARS
      NOP:KOMENTARS = History::NOP:Record.KOMENTARS
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
  NOP:Record = SAV::NOP:Record
  SAV::NOP:Record = NOP:Record
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

