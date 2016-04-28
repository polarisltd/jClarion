                     MEMBER('winlats.clw')        ! This is a MEMBER module
BrowsePAR_E PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
EMA_EMAIL            STRING(35)

BRW1::View:Browse    VIEW(PAR_E)
                       PROJECT(EMA:EMA_NR)
                       PROJECT(EMA:EMAIL)
                       PROJECT(EMA:AMATS)
                       PROJECT(EMA:KONTAKTS)
                       PROJECT(EMA:PAR_NR)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::EMA:EMA_NR       LIKE(EMA:EMA_NR)           ! Queue Display field
BRW1::EMA_EMAIL        LIKE(EMA_EMAIL)            ! Queue Display field
BRW1::EMA:AMATS        LIKE(EMA:AMATS)            ! Queue Display field
BRW1::EMA:KONTAKTS     LIKE(EMA:KONTAKTS)         ! Queue Display field
BRW1::EMA:PAR_NR       LIKE(EMA:PAR_NR)           ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(EMA:EMA_NR),DIM(100)
BRW1::Sort1:LowValue LIKE(EMA:EMA_NR)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(EMA:EMA_NR)            ! Queue position of scroll thumb
BRW1::Sort1:Reset:PAR:U_NR LIKE(PAR:U_NR)
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
WinResize            WindowResizeType
QuickWindow          WINDOW('Browse the PAR_E File'),AT(,,314,188),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('BrowseADR_K'),SYSTEM,GRAY,RESIZE
                       LIST,AT(8,25,301,124),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('10L(2)|M@n3@140L(2)|M~Email~@s35@81L(2)|M~Piezîmes~L(1)@s20@100L(2)|M~Kontaktper' &|
   'sona~@s20@'),FROM(Queue:Browse:1)
                       BUTTON('Iz&vçlçties citu  '),AT(120,174,95,14),USE(?Select:2),DEFAULT
                       BUTTON('&Ievadît'),AT(141,153,45,14),USE(?Insert:3)
                       BUTTON('&Mainît'),AT(190,153,45,14),USE(?Change:3),DEFAULT
                       BUTTON('&Dzçst'),AT(239,153,45,14),USE(?Delete:3)
                       BUTTON('Izvçlçties &Abus'),AT(38,174,79,14),USE(?Abas),HIDE,DEFAULT
                       SHEET,AT(4,9,309,162),USE(?CurrentTab)
                         TAB('CitI e-pasti'),USE(?Tab:2)
                           STRING('Norçíinu e-pasts:'),AT(56,9),USE(?String1)
                           STRING(@s40),AT(115,9),USE(PAR:EMAIL)
                         END
                       END
                       BUTTON('&Beigt'),AT(217,174,82,14),USE(?Close)
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
     ?Change:3{PROP:DEFAULT}=''
     ?Select:2{PROP:DEFAULT}=''
     ?Select:2{PROP:TEXT}='Iz&vçlçties citu kâ ardesâtu'
     ?Close{PROP:TEXT}='&Atstât norçíinu e-M'
     UNHIDE(?Abas)
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      QuickWindow{PROP:TEXT}=PAR:NOS_P
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
        ADR_NR=EMA:EMA_NR
        F:X=1
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
    OF ?Abas
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        ADR_NR=EMA:EMA_NR
        F:X=3
        LOCALRESPONSE=REQUESTCOMPLETED
        BREAK
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
        ADR_NR=0
        F:X=2
        LOCALRESPONSE=REQUESTCOMPLETED
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF PAR_E::Used = 0
    CheckOpen(PAR_E,1)
  END
  PAR_E::Used += 1
  BIND(EMA:RECORD)
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowsePAR_E','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select:2{Prop:Hide} = True
    DISABLE(?Select:2)
  ELSE
    UNHIDE(?Select:2)
    ?Select:2{Prop:Default} = True
    ENABLE(?Select:2)
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
    PAR_E::Used -= 1
    IF PAR_E::Used = 0 THEN CLOSE(PAR_E).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
  END
  IF WindowOpened
    INISaveWindow('BrowsePAR_E','winlats.INI')
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
      IF BRW1::Sort1:Reset:PAR:U_NR <> PAR:U_NR
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:PAR:U_NR = PAR:U_NR
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
      StandardWarning(Warn:RecordFetchError,'PAR_E')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = EMA:EMA_NR
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAR_E')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = EMA:EMA_NR
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
  EMA:EMA_NR = BRW1::EMA:EMA_NR
  EMA_EMAIL = BRW1::EMA_EMAIL
  EMA:AMATS = BRW1::EMA:AMATS
  EMA:KONTAKTS = BRW1::EMA:KONTAKTS
  EMA:PAR_NR = BRW1::EMA:PAR_NR
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
  EMA_EMAIL=EMA:EMAIL&EMA:KONTAKTS[21:25]
  BRW1::EMA:EMA_NR = EMA:EMA_NR
  BRW1::EMA_EMAIL = EMA_EMAIL
  BRW1::EMA:AMATS = EMA:AMATS
  BRW1::EMA:KONTAKTS = EMA:KONTAKTS
  BRW1::EMA:PAR_NR = EMA:PAR_NR
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
        BRW1::PopupText = 'Iz&vçlçties citu  '
      ELSE
        BRW1::PopupText = '~Iz&vçlçties citu  '
      END
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
      BRW1::PopupText = '~Iz&vçlçties citu  '
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
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => EMA:EMA_NR
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
          IF UPPER(SUB(EMA:EMA_NR,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(EMA:EMA_NR,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            EMA:EMA_NR = CHR(KEYCHAR())
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
    OF 1
      EMA:EMA_NR = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'PAR_E')
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
      BRW1::HighlightedPosition = POSITION(EMA:NR_KEY)
      RESET(EMA:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      EMA:PAR_NR = PAR:U_NR
      SET(EMA:NR_KEY,EMA:NR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'EMA:PAR_NR = PAR:U_NR'
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
    CLEAR(EMA:Record)
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
    EMA:PAR_NR = PAR:U_NR
    SET(EMA:NR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'EMA:PAR_NR = PAR:U_NR'
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
    PAR:U_NR = BRW1::Sort1:Reset:PAR:U_NR
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
  GET(PAR_E,0)
  CLEAR(EMA:Record,0)
  CASE BRW1::SortOrder
  OF 1
    EMA:PAR_NR = BRW1::Sort1:Reset:PAR:U_NR
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
!| (UpdatePAR_E) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[2])
     EXIT
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdatePAR_E
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
        GET(PAR_E,0)
        CLEAR(EMA:Record,0)
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


BrowseGG PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
SAK_GIL              LONG
BEI_GIL              LONG
SAV_PAR_NR           ULONG
GG_DOK_SENR          STRING(14)
S_SUMMA              CSTRING(15)
X                    BYTE
Process              STRING(35)
Process1             STRING(35)
Process2             STRING(35)
Auto::Attempts       LONG
Auto::Save:GG:U_NR   LIKE(GG:U_NR)

FILENAME_S           LIKE(FILENAME1)
FILENAME_D           LIKE(FILENAME1)

!GG_DOK_SENR          LIKE(GG:DOK_SENR)
GG_DOKDAT            LIKE(GG:DOKDAT)
GG_VAL               LIKE(GG:VAL)
GGK_SUMMAV           LIKE(GGK:SUMMAV)
K_D_K                STRING(1)
REGNR                DECIMAL(11)
KURSS                REAL
NOKL_DC              LONG
PAR_EMAIL            STRING(71) ! 2*35+1
PAR_NOS_P            LIKE(PAR:NOS_P)

K_TABLE     QUEUE,PRE(K)
KEY            STRING(6)
BKK            STRING(5)
D_K            STRING(1)
SUMMAV         LIKE(GGK:SUMMAV)
            .


Askscreen WINDOW('Datu dzçðana'),AT(,,159,128),CENTER,GRAY
       STRING('Dzçst visus dokumentus'),AT(21,23),USE(?StringDZEST)
       SPIN(@d06.B),AT(24,40,48,12),USE(s_dat)
       SPIN(@d06.B),AT(94,40,48,12),USE(B_DAT)
       STRING('kam X='),AT(20,58),USE(?String4)
       ENTRY(@n1B),AT(47,57),USE(X),CENTER
       STRING('un Y='),AT(70,58),USE(?string:RS),HIDE
       ENTRY(@S1),AT(91,57),USE(RS),HIDE,CENTER
       STRING(@s35),AT(11,74),USE(process)
       STRING(@s35),AT(11,82),USE(process1)
       STRING(@s35),AT(11,90),USE(process2)
       STRING('lîdz'),AT(78,41),USE(?String93)
       STRING('no'),AT(11,42),USE(?String92)
       BUTTON('&OK'),AT(74,104,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(116,104,36,14),USE(?CancelButton)
     END

KESKA           STRING(14)

KESKAwindow WINDOW('Izvçles logs'),AT(,,197,73),CENTER,GRAY
       CHECK('&Meklçt tieði tâdu Nr'),AT(94,11),USE(F:DTK),VALUE('1','')
       STRING('Meklçjamais fragments:'),AT(9,25),USE(?String221)
       ENTRY(@s14),AT(94,24),USE(keska)
       BUTTON('&OK'),AT(116,45,35,14),USE(?Ok:KESKA),DEFAULT
       BUTTON('&Atlikt'),AT(154,45,36,14),USE(?Cancel:KESKA)
     END

SELREKWINDOW WINDOW('Izvçles logs'),AT(,,100,73),CENTER,GRAY
       OPTION('Rçíins'),AT(17,8,67,41),USE(F:dtk,,?f:dtk:SR),BOXED
         RADIO('Speciâlais'),AT(26,22),USE(?F:dtk:Radio1),VALUE('S')
         RADIO('Parastais'),AT(26,31),USE(?F:dtk:Radio2),VALUE(' ')
       END
       BUTTON('&OK'),AT(19,54,35,14),USE(?Ok:SELREK),DEFAULT
       BUTTON('&Atlikt'),AT(57,54,36,14),USE(?Cancel:SELREK)
     END


BRW1::View:Browse    VIEW(GG)
                       PROJECT(GG:KEKSIS)
                       PROJECT(GG:RS)
                       PROJECT(GG:DATUMS)
                       PROJECT(GG:DOK_SENR)
                       PROJECT(GG:ATT_DOK)
                       PROJECT(GG:NOKA)
                       PROJECT(GG:SATURS)
                       PROJECT(GG:SUMMA)
                       PROJECT(GG:VAL)
                       PROJECT(GG:U_NR)
                       PROJECT(GG:SECIBA)
                       PROJECT(GG:PAR_NR)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::GG:KEKSIS        LIKE(GG:KEKSIS)            ! Queue Display field
BRW1::GG:KEKSIS:NormalFG LONG                     ! Normal Foreground
BRW1::GG:KEKSIS:NormalBG LONG                     ! Normal Background
BRW1::GG:KEKSIS:SelectedFG LONG                   ! Selected Foreground
BRW1::GG:KEKSIS:SelectedBG LONG                   ! Selected Background
BRW1::GG:RS            LIKE(GG:RS)                ! Queue Display field
BRW1::GG:RS:NormalFG LONG                         ! Normal Foreground
BRW1::GG:RS:NormalBG LONG                         ! Normal Background
BRW1::GG:RS:SelectedFG LONG                       ! Selected Foreground
BRW1::GG:RS:SelectedBG LONG                       ! Selected Background
BRW1::GG:DATUMS        LIKE(GG:DATUMS)            ! Queue Display field
BRW1::GG:DATUMS:NormalFG LONG                     ! Normal Foreground
BRW1::GG:DATUMS:NormalBG LONG                     ! Normal Background
BRW1::GG:DATUMS:SelectedFG LONG                   ! Selected Foreground
BRW1::GG:DATUMS:SelectedBG LONG                   ! Selected Background
BRW1::GG:DOK_SENR      LIKE(GG:DOK_SENR)          ! Queue Display field
BRW1::GG:DOK_SENR:NormalFG LONG                   ! Normal Foreground
BRW1::GG:DOK_SENR:NormalBG LONG                   ! Normal Background
BRW1::GG:DOK_SENR:SelectedFG LONG                 ! Selected Foreground
BRW1::GG:DOK_SENR:SelectedBG LONG                 ! Selected Background
BRW1::GG:ATT_DOK       LIKE(GG:ATT_DOK)           ! Queue Display field
BRW1::GG:ATT_DOK:NormalFG LONG                    ! Normal Foreground
BRW1::GG:ATT_DOK:NormalBG LONG                    ! Normal Background
BRW1::GG:ATT_DOK:SelectedFG LONG                  ! Selected Foreground
BRW1::GG:ATT_DOK:SelectedBG LONG                  ! Selected Background
BRW1::GG:NOKA          LIKE(GG:NOKA)              ! Queue Display field
BRW1::GG:NOKA:NormalFG LONG                       ! Normal Foreground
BRW1::GG:NOKA:NormalBG LONG                       ! Normal Background
BRW1::GG:NOKA:SelectedFG LONG                     ! Selected Foreground
BRW1::GG:NOKA:SelectedBG LONG                     ! Selected Background
BRW1::GG:SATURS        LIKE(GG:SATURS)            ! Queue Display field
BRW1::GG:SATURS:NormalFG LONG                     ! Normal Foreground
BRW1::GG:SATURS:NormalBG LONG                     ! Normal Background
BRW1::GG:SATURS:SelectedFG LONG                   ! Selected Foreground
BRW1::GG:SATURS:SelectedBG LONG                   ! Selected Background
BRW1::GG:SUMMA         LIKE(GG:SUMMA)             ! Queue Display field
BRW1::GG:SUMMA:NormalFG LONG                      ! Normal Foreground
BRW1::GG:SUMMA:NormalBG LONG                      ! Normal Background
BRW1::GG:SUMMA:SelectedFG LONG                    ! Selected Foreground
BRW1::GG:SUMMA:SelectedBG LONG                    ! Selected Background
BRW1::GG:VAL           LIKE(GG:VAL)               ! Queue Display field
BRW1::GG:VAL:NormalFG LONG                        ! Normal Foreground
BRW1::GG:VAL:NormalBG LONG                        ! Normal Background
BRW1::GG:VAL:SelectedFG LONG                      ! Selected Foreground
BRW1::GG:VAL:SelectedBG LONG                      ! Selected Background
BRW1::GG:U_NR          LIKE(GG:U_NR)              ! Queue Display field
BRW1::GG:U_NR:NormalFG LONG                       ! Normal Foreground
BRW1::GG:U_NR:NormalBG LONG                       ! Normal Background
BRW1::GG:U_NR:SelectedFG LONG                     ! Selected Foreground
BRW1::GG:U_NR:SelectedBG LONG                     ! Selected Background
BRW1::GG:SECIBA        LIKE(GG:SECIBA)            ! Queue Display field
BRW1::GG:SECIBA:NormalFG LONG                     ! Normal Foreground
BRW1::GG:SECIBA:NormalBG LONG                     ! Normal Background
BRW1::GG:SECIBA:SelectedFG LONG                   ! Selected Foreground
BRW1::GG:SECIBA:SelectedBG LONG                   ! Selected Background
BRW1::SAK_GIL          LIKE(SAK_GIL)              ! Queue Display field
BRW1::BEI_GIL          LIKE(BEI_GIL)              ! Queue Display field
BRW1::GG:PAR_NR        LIKE(GG:PAR_NR)            ! Queue Display field
BRW1::SAV_PAR_NR       LIKE(SAV_PAR_NR)           ! Queue Display field
BRW1::ATLAUTS          LIKE(ATLAUTS)              ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(GG:DATUMS),DIM(100)
BRW1::Sort1:LowValue LIKE(GG:DATUMS)              ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(GG:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort7:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort7:KeyDistribution LIKE(GG:DATUMS),DIM(100)
BRW1::Sort7:LowValue LIKE(GG:DATUMS)              ! Queue position of scroll thumb
BRW1::Sort7:HighValue LIKE(GG:DATUMS)             ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Browse the GG File'),AT(-1,-1,455,298),FONT('MS Sans Serif',9,,FONT:bold),IMM,VSCROLL,HLP('BrowseGG'),SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&1-Seanss'),USE(?Seanss)
                           ITEM,SEPARATOR
                           ITEM('&4-Darba þurnâls'),USE(?SeanssDarbaþurnâls)
                         END
                         MENU('&3-Sistçmas dati'),USE(?System)
                           ITEM,SEPARATOR
                           ITEM('&3-Lokâlie Dati'),USE(?SystemLokalieDati)
                         END
                         MENU('&2-Serviss'),USE(?Serviss)
                           ITEM('&2-Importa interfeiss (WinLats)'),USE(?ServissImportainterfeissWL)
                           ITEM('&3-Importa interfeiss (Lats2000)'),USE(?ServissImportainterfeissLats2000),DISABLE
                           ITEM('&4-Self - test'),USE(?ServissSelftest)
                           ITEM,SEPARATOR
                           ITEM('&5-Uzbûvçt (pârbûvçt) 231..,531.. vçsturi'),USE(?vesturebuilder)
                           ITEM('&6-Bankas izraksta imports (no faila ''SWIFT''+''B''.xml)'),USE(?2ServissItem85)
                         END
                         MENU('&4-Faili'),USE(?Faili)
                           ITEM('&1-Partneru saraksts'),USE(?4Faili1Partnerusaraksts),FIRST
                           ITEM('&9-CRM:Aktuâlie darbi'),USE(?4Faili9CRMAktuâliedarbi)
                           ITEM('&A-Tekstu plâns'),USE(?BâzesfailiTekstuplâns)
                           ITEM('&B-UGP rindu kodi'),USE(?4FailiBUGPrindukodi)
                           ITEM('&C-Ârçjo maksâjumu kodi'),USE(?4FailiCÂrçjomaksâjumukodi)
                           ITEM('&D-Rîkojumi'),USE(?4FailiDRîkojumi)
                           ITEM,SEPARATOR
                           MENU('&Z-Izziòas no failiem'),USE(?4FailiZIzziòasnofailiem)
                             ITEM('&8-UGP rindas'),USE(?4FailiUGPrindas)
                             ITEM('&9-Rîkojumu saraksts'),USE(?4FailiZIzziòasnofailiem8Rîkojumusaraksts)
                           END
                         END
                         MENU('&5-Izziòas no DB'),USE(?IzziòasnoDB)
                           ITEM('&1-Þurnâli'),USE(?IzziòasnoDBÞurnâli)
                           ITEM('&2-Izziòa kontam'),USE(?IzziòasnoDBIzziòakontam)
                           ITEM('&3-Norçíini ar piegâdâtâjiem / saòçmçjiem'),USE(?IzziòasnoDBNorçíiniarpiegâdâtâjiemsaòçmçjiem)
                           ITEM('&Piegâdâtâju / saòçmçju kopsavilkums'),USE(?5IzziòasnoDBPiegâdâtâjusaòçmçjukopsavilkums)
                           ITEM('&4-Norçíini par pretstatîtiem kontiem'),USE(?IzziòasnoDBNorçíiniparpretstâtîtiemkontiem)
                           ITEM('&5-Norçíini ar partneriem'),USE(?IzziòasnoDBNorçíiniarpartneriem)
                           ITEM('&6-Norçíini ar DEB/KRE dokumentu lîmenî'),USE(?IzziòasnoDBNorçíiniarDEBKREdokumentulîmenî)
                           ITEM('&7-Debitoru apmaksas koeficients'),USE(?IzziòasnoDBDebitoruapmaksaskoeficients)
                           ITEM('&8-Debitoru apm. koef. (S pa grupâm)'),USE(?5IzziòasnoDBApmaksaskoeficientspçcgrupâm)
                           ITEM('&9-Pircçja uzskaites kartiòa'),USE(?IzziòasnoDBPircejauzskaiteskartiòa)
                           ITEM('1&0-Iepirkumu uzskaites kartiòa'),USE(?IzziòasnoDBIeprikumuuzskaiteskartiòa)
                           ITEM('&A-Avansa Norçíins'),USE(?IzziòasnoDBAvansaNorçíins)
                           ITEM('&B-Avansieru Pârskats'),USE(?IzziòasnoDBAvansieruPârskats)
                           ITEM('&C-Kontu korespondence (1 - datumu secîbâ)'),USE(?IzziòasnoDBKontukorespondence1datumusecîbâ)
                           ITEM('&D-Kontu korespondence (2 - pa partneriem 1 kontam)'),USE(?IzziòasnoDBKontukorespondence2partnerusecîbâ)
                           ITEM('&E-Kontu Atlikumi'),USE(?IzziòasnoDBKontuAtlikumi)
                           ITEM('&F-Apgrozîjuma Pârskats'),USE(?IzziòasnoDBApgrozîjumaPârskats)
                           ITEM('&G-Kases Grâmata'),USE(?IzziòasnoDBKasesGrâmata)
                           ITEM('&H-Ârvalstu valûtas apgr. pârsk.'),USE(?IzziòasnoDBÂrvalstuvalûtasapgrpârsk)
                           ITEM('&I-Virsgrâmata'),USE(?IzziòasnoDBGG)
                           ITEM('&J-Skaidras Naudas Deklarâcija'),USE(?IzziòasnoDBSkaidrasND)
                           ITEM('&K-Apgrozîjums BILANCES kontos'),USE(?IzziòasnoDBApgrBILANCESkontos)
                           ITEM('&L-Apgrozîjums OPERÂCIJU kontos'),USE(?IzziòasnoDBApgrOPERkontos)
                           ITEM('&M-Parâdu kopsavilkums'),USE(?5IzziòasnoDBMParkopsavilkums)
                           ITEM('&N-Ieò./Izm. nodaïu kopsavilkums '),USE(?5IzziòasnoDBNIenIzmKopsavilkumspanod)
                           ITEM('&O-Ieò./Izm. projektu(Obj.) kopsavilkums '),USE(?5IzziòasnoDBNIenIzmKopsavilkumspaproj)
                           ITEM('&R-PVN Dekl. kopsavilkums'),USE(?5IzziòasnoDBPPVNDEKLkopsavilkums)
                           ITEM('&S-Kases orderu þurnâls'),USE(?IzzinasnoDBKaseszurnals)
                         END
                         MENU('&6-Atskaites'),USE(?ATSKAITES)
                           ITEM('&C-PVN Deklarâcija '),USE(?AtskaitesPVNDeklarâcijaMKN29)
                           ITEM('&D-PVN1 Pârskats par priekðnodokïa un nodokïa summâm PVND'),USE(?6AtskaitesPIE29)
                           ITEM('&E-Pârskats par preèu piegâdçm un sniegtajiem pakalpojumiem ES'),USE(?6AtskaitesPIE229)
                           ITEM('&3-PVN4 Deklarâcija (gads)'),USE(?AtskaitesPVNDeklarâcija3pielikums)
                           ITEM('&K-PVN6 Pielikums par Kokmateriâlu piegâdçm I daïa'),USE(?6AtskaitesKPVN61)
                           ITEM('&L-PVN6 Pielikums par Kokmateriâlu piegâdçm II daïa'),USE(?6AtskaitesLPVN62)
                           ITEM('&5-Kokmateriâlu realizâcijas reìistrs (1P)'),USE(?ATSKAITESKokmateriâlurealizâcijasreìistrs1P)
                           ITEM('&6-Iegâdâto kokmateriâlu reìistrs (2P)'),USE(?ATSKAITESIegâdâtokokmateriâlureìistrs2P)
                           ITEM('&7-Peïòas / Zaudçjumu aprçíins PZA2'),USE(?ATSKAITESPeïòasZaudçjumuaprçíins)
                           ITEM('&8-Bilance'),USE(?ATSKAITESBILANCE)
                           ITEM('&A-Naudas plûsmas pârskats NPP2'),USE(?ATSKAITESNPP2)
                           ITEM('&I-Paðu kapitâla izmaiòu pârskats PKIP'),USE(?6AtskaitesIPaðukapitâlaizmaiòupârskatsPKIP)
                           ITEM('&B-Akts par savstarpçjo norçíinu salîdzinâðnu'),USE(?AtskaitesAktsparsavstarpçjonorçíinusalîdzinâðnu)
                           ITEM('&F-Izrakstîto P/Z Reìistrs'),USE(?6AtskaitesCIzrakstîtoPZregistrs)
                           ITEM('&G-Saòemto P/Z Reìistrs'),USE(?6AtskaitesDSanemtoPZregistrs)
                           ITEM('&H-Pârskats par PPR/PN izlietojumu'),USE(?6AtskaitesHParskatsparPZizlietojumu)
                           ITEM('&J-Mçneða pârskats par paðvaldîbas pamatbudþeta izpildI'),USE(?6AtskaitesI)
                           ITEM,SEPARATOR
                           ITEM('&1-PVN Deklarâcija'),USE(?ATSKAITESPVNDeklarâcija)
                           ITEM('&2-Pârskats par priekðnodokïa summâm, kas iekïautas PVND'),USE(?ATSKAITESPVNPielikums)
                           ITEM('&4-PVN Pielikums par Kokmateriâlu piegâdçm (lîdz 2007.g.)'),USE(?ATSKAITESPVNPielikumsparKokmateriâlupiegâdçm)
                         END
                         MENU('&7-Datu apmaiòa'),USE(?7Datuapmaiòa)
                           ITEM('&1-Datu imports no Brio-nafta'),USE(?7DatuapmaiòaDatuimportsnoBrionafta)
                           ITEM('&2-Datu imports no export.dat'),USE(?7Datuapmaiòa2Datuimportsnoexportdat)
                           ITEM('&3-Datu imports no import.txt'),USE(?7Datuapmaiòa3Datuimportsnoimpyymmddtxt)
                           ITEM('&4-Datu eksports uz export.txt'),USE(?7Datuapmaiòa4Datueksportsuzimporttxt)
                         END
                         MENU('&8-Speciâlâs funkcijas'),USE(?Speciâlâsfunkcijas)
                           ITEM('&1-Ieòçmumi/Zaudçjumi no kursu svârstîbâm'),USE(?DarbîbasarDBIeòçmumiZaudçjuminokursusvârstîba)
                           ITEM('&2-Þurnâls konkrçtam kontam'),USE(?DarbîbasarDBÞurnâls)
                           ITEM('&3-Atrast summu uz leju no tekoðâ Dokumenta'),USE(?SpeciâlâsfunkcijasAtrastsummu)
                           ITEM('&4-Atrast Dok.Nr fragmentu uz leju no tekoðâ Dokumenta'),USE(?SpeciâlâsFAtrastNr)
                           ITEM('&5-Atrast U_Nr uz leju no tekoðâ dokumenta'),USE(?8SpeciâlâsfunkcijasAtrastUNr)
                           ITEM('&6-Atvçrt (aizvçrt) datu bloku'),USE(?AtAizDatubloku),DISABLE
                           ITEM('&7-Dokumentu renumerçðana'),USE(?DokumentuRenum)
                           ITEM('&8-Kases orderu drukâðana'),USE(?8Speciâlâsfunkcijas7Kasesorderudrukâðana)
                           ITEM('&9-Nodzçst lielu datu bloku'),USE(?Nodzestlieludatubloku),DISABLE
                           ITEM('&A-Rçíinu bûvçðana'),USE(?8SpecFunkcijasItemA),DISABLE
                           ITEM('&B-Rçíinu drukâðana'),USE(?8SpeciâlâsfunkcijasItemB),DISABLE
                         END
                         MENU('&9-Analîze'),USE(?9Analîze)
                           ITEM('&1-Peïòa/zaudçjumi'),USE(?9Analîze1Peïòazaudçjumi)
                         END
                       END
                       LIST,AT(5,18,441,254),USE(?Browse:1),IMM,HVSCROLL,FONT('MS Sans Serif',10,,FONT:bold),MSG('Browsing Records'),FORMAT('10C(1)|M*~X~C(0)@n1B@10C|M*~Y~@s1@45R(1)|M*~Datums~C(0)@d06.B@56R(1)|M*~Dok. Nr.' &|
   '~C(0)@s14@10C|M*~A~@s1@78L(1)|M*~Partneris~C(0)@s15@203L(1)|M*~Saturs~C(0)@s47@4' &|
   '7R(1)M*~Summa~R(2)@n-_15.2@17L|M*@s3@28R(1)|M*~U NR~C(0)@n_7.0@29C|M*~Secîba~@T4' &|
   '@'),FROM(Queue:Browse:1)
                       BUTTON('&X'),AT(0,280,13,11),USE(?ButtonX),RIGHT,FONT(,,,FONT:bold)
                       STRING('dd.mm.'),AT(49,280,21,10),USE(?String1)
                       BUTTON('&e-mail'),AT(263,278,31,14),USE(?ButtonEmail)
                       BUTTON('&C-Kopçt'),AT(114,278,34,14),USE(?ButtonCopy)
                       ENTRY(@d06.B),AT(14,279,34,12),USE(GG:DATUMS)
                       BUTTON('&Rçíins'),AT(232,278,29,14),USE(?rekins),TIP('Rçíins pçc kontçjuma K6..,K521.,K7.. grupas kontiem (D521-avanss)')
                       BUTTON('P/&Z'),AT(295,278,21,14),USE(?PZ),TIP('Numurçtâ P/Z pçc kontçjuma 6.. grupas kontiem')
                       BUTTON('K&-PRN'),AT(149,278,31,14),USE(?KPRN)
                       BUTTON('Ieskaita PN&A'),AT(181,278,50,14),USE(?Ieskaits),FONT('MS Sans Serif',,,FONT:bold,CHARSET:BALTIC),TIP('Ieskaits pçc kontçjuma K231,D531 kontiem ')
                       BUTTON('&Ievadît'),AT(317,278,35,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(353,278,34,14),USE(?Change:2),DEFAULT
                       BUTTON('&Dzçst'),AT(388,278,31,14),USE(?Delete:2)
                       BUTTON('&Beigt'),AT(420,278,31,14),USE(?Close)
                       SHEET,AT(2,2,448,274),USE(?CurrentTab)
                         TAB('&Visi dokumenti'),USE(?Tab:2),COLOR(,,040FF00H)
                         END
                         TAB('&Kase'),USE(?Tab:3)
                         END
                         TAB('B&anka'),USE(?Tab:4)
                         END
                         TAB('Avansi&eri'),USE(?Tab:5)
                         END
                         TAB('&Nor. par 231...'),USE(?Tab:6)
                         END
                         TAB('N&or. par 531...'),USE(?Tab:7)
                         END
                         TAB('&Partneris'),USE(?Tab:8)
                           BUTTON('Partneris'),AT(72,278,42,14),USE(?ButtonPartneris)
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
  ! PIRMS CLARIS ATRAUJ VAÏÂ FAILUS
    VAL_nos=VAL_LV
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
   ?BROWSE:1{PROP:FORMAT}=GETINI('BrowseGG','?BROWSE:1 Format',?BROWSE:1{PROP:FORMAT},'WinLats.ini')
   gads=GL:DB_gads
   SAV_DATUMS=B_DAT  !????
   IF ATLAUTS[1]='1' !SUPERACC
     ENABLE(?AtAizDatubloku)
     ENABLE(?Nodzestlieludatubloku)
     ENABLE(?DokumentuRenum)
   .
   IF ATLAUTS[10]='1' !AIZLIEGTA DATU APMAIÒA UN IMPINT
     DISABLE(?ServissImportaInterfeissWL)
     DISABLE(?ServissImportaInterfeissLATS2000)
     DISABLE(?VestureBuilder)
   .
   IF ATLAUTS[17]='1' !AIZLIEGTS SELFTESTS  (9+8)
     DISABLE(?ServissSelftest)
   .
   IF INRANGE(ATLAUTS[JOB_NR+39],0,1)
      MAINIT231531=TRUE !JA ÐAJÂ BASE MODULÎ ATÏAUTS MAINÎT,ATÏAUJAM ARÎ CAUR PAR_K N231 N531
  .
   IF ACC_KODS_N=0  !ASSAKO
     ENABLE(?8SpecFunkcijasItemA) !RÇÍINU DRUKÂÐANA
   .
   IF CL_NR=1235 !ASTARTE
     ENABLE(?ServissImportainterfeissLats2000)
   .
   !*******USER LEVEL ACCESS CONTROL********
   IF ~BAND(REG_BASE_ACC,00000010b) ! Budþets
      DISABLE(?6AtskaitesI)
   .
  ACCEPT
    IF sys:gil_show
       QUICKWINDOW{PROP:TEXT}='Grâmatvedîbas dokumenti  '&CLIP(RECORDS(GG))&' raksti '&CLIP(LONGpath())&'\BASE'&|
       CLIP(JOB_NR)&' Atvçrts no '&format(sys:gil_show,@D06.B)
    ELSE
       QUICKWINDOW{PROP:TEXT}='Grâmatvedîbas dokumenti  '&CLIP(RECORDS(GG))&' raksti '&CLIP(LONGpath())&'\BASE'&|
       CLIP(JOB_NR)&' Atvçrts no gada sâkuma'
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
        DO ListBoxDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
    END
    CASE ACCEPTED()
    OF ?SeanssDarbaþurnâls
      DO SyncWindow
      START(DarbaZurnals,50000)
      LocalRequest = OriginalRequest
      DO RefreshWindow
      !IF GlobalResponse=RequestCompleted
      !    START(DarbaZurnals,50000)
      !END
    OF ?SystemLokalieDati
      DO SyncWindow
      GlobalRequest = ChangeRecord
      UpdateSystem 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?ServissImportainterfeissWL
      OPCIJA_NR=0
      F:DTK='' ! JA 1, SAPROT, KA JÂLASA BRIO
      DO SyncWindow
      BROWSEGG1 
      LocalRequest = OriginalRequest
      DO RefreshWindow
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
    OF ?ServissImportainterfeissLats2000
      DO SyncWindow
      Browsegg2 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?ServissSelftest
      DO SyncWindow
        OPCIJA='1110'
        IZZFILTSF
        IF GlobalResponse=RequestCompleted
          START(SelftestBase,50000)
        END
    OF ?vesturebuilder
      DO SyncWindow
      VestureBuilder 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?2ServissItem85
      DO SyncWindow
      R_EMAKS_ 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4Faili1Partnerusaraksts
      DO SyncWindow
      BrowsePAR_K 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4Faili9CRMAktuâliedarbi
      DO SyncWindow
      BrowseVestureA 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?BâzesfailiTekstuplâns
      DO SyncWindow
      BrowseTEK_K 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4FailiBUGPrindukodi
      DO SyncWindow
      BrowseKON_R 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4FailiCÂrçjomaksâjumukodi
      DO SyncWindow
      BrowseARM_K 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4FailiDRîkojumi
      OPCIJA_NR=0 !LAI ATVER K-A-C-I-B
      DO SyncWindow
      BrowseKAD_RIK 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4FailiUGPrindas
      DO SyncWindow
      !OPCIJA='20'
      OPCIJA='00'
      !       12
      IZZFILTF
      IF GlobalResponse=RequestCompleted
          START(F_KON_R,50000)
      END
    OF ?4FailiZIzziòasnofailiem8Rîkojumusaraksts
      DO SyncWindow
      !      ID = KAD:ID
      ! OPCIJA='010000000'
        OPCIJA='230000000'
      !         123456789  6-3WEA
        IZZFILTA
        IF GlobalResponse = RequestCompleted
               START(A_RIKOJUMI,50000)
        .
        SELECT(?BROWSE:1)
    OF ?IzziòasnoDBÞurnâli
      DO SyncWindow
       OPCIJA='01121000001310100000'
      !        12345678901234567890
       izzfiltB
       if GlobalResponse=RequestCompleted
          if instring(' ',kkk,1,1)            !kontu grupa
             if par_nr=999999999              !visi partneri
                START(B_ZurnalsVKVP,50000)
             else
                START(B_ZurnalsVK1P,50000)
             .
          else                                !1 konts
             if par_nr=999999999              !visi partneri
                START(B_Zurnals1KVP,50000)
             else
                START(B_Zurnals1K1P,50000)
             .
          .
       .
    OF ?IzziòasnoDBIzziòakontam
      DO SyncWindow
       OPCIJA='11111100001310100000'
      !        12345678901234567890
       IZZFILTB
       IF GlobalResponse = RequestCompleted
          START(B_IZZKONT,50000)
       END
    OF ?IzziòasnoDBNorçíiniarpiegâdâtâjiemsaòçmçjiem
      DO SyncWindow
       OPCIJA='01101970000300100000'
      !        12345678901234567890
       IZZFILTB
       IF GlobalResponse = RequestCompleted
         IF PAR_NR = 999999999
           START(B_DEKRVI,50000)
         ELSE
           START(B_DEKR,50000)
         END
       END
    OF ?5IzziòasnoDBPiegâdâtâjusaòçmçjukopsavilkums
      DO SyncWindow
       OPCIJA='01100900000300100000'
      !        12345678901234567890
       IZZFILTB
       IF GlobalResponse = RequestCompleted
      !   IF PAR_NR = 999999999
           START(B_DEKRKOPS,50000)
      !   ELSE
      !     START(B_DEKR,50000)
      !   END
       END
    OF ?IzziòasnoDBNorçíiniparpretstâtîtiemkontiem
      DO SyncWindow
        KKK = ''
        KKK1 = ''
        OPCIJA='01100101000300100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          start(B_PRETVI,50000)
        END
    OF ?IzziòasnoDBNorçíiniarpartneriem
      DO SyncWindow
        OPCIJA='01102100000300100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_PARTNER1,50000)
        END
    OF ?IzziòasnoDBNorçíiniarDEBKREdokumentulîmenî
      DO SyncWindow
        OPCIJA='01104260100310100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
           IF F:NOA   !VADÎBAS-ADMICULUM
              START(B_NorDokLimA,50000)
           ELSE
              START(B_NorDokLim,50000)
           .
        END
    OF ?IzziòasnoDBDebitoruapmaksaskoeficients
      DO SyncWindow
       OPCIJA='01101000000300100000'
      !        12345678901234567890
       IZZFILTB
       IF GlobalResponse = RequestCompleted
          START(B_DAK231,50000)
       END
    OF ?5IzziòasnoDBApmaksaskoeficientspçcgrupâm
      DO SyncWindow
       OPCIJA='01103000000300100000'
      !        12345678901234567890
       IZZFILTB
       IF GlobalResponse = RequestCompleted
           F:DTK=2
           START(B_DAK231,50000)
       END
    OF ?IzziòasnoDBPircejauzskaiteskartiòa
      DO SyncWindow
       OPCIJA='01102100030300100000'
      !        12345678901234567890
       izzfiltB
       IF GlobalResponse = RequestCompleted
          START(B_PUK,50000)
       END
    OF ?IzziòasnoDBIeprikumuuzskaiteskartiòa
      DO SyncWindow
       OPCIJA='01102100020300100000'
      !        12345678901234567890
       izzfiltB
       IF GlobalResponse = RequestCompleted
          START(B_PIK,50000)
       END
    OF ?IzziòasnoDBAvansaNorçíins
      DO SyncWindow
        KKK = '23800'
        OPCIJA='01112620001310100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_AVANSIERI,50000)
        END
    OF ?IzziòasnoDBAvansieruPârskats
      DO SyncWindow
        KKK = '23800'
        OPCIJA='01110000001310100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_AVANSAR,50000)
        END
    OF ?IzziòasnoDBKontukorespondence1datumusecîbâ
      DO SyncWindow
        OPCIJA='01110100000300100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_SAHS,50000)
        END
    OF ?IzziòasnoDBKontukorespondence2partnerusecîbâ
      DO SyncWindow
        OPCIJA='01110100001310100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
           IF ~KKK[5]
              KLUDA(87,'korekts konta numurs: '&KKK)
           ELSE
              START(B_SAHS2,50000)
           .
        END
    OF ?IzziòasnoDBKontuAtlikumi
      DO SyncWindow
        OPCIJA='00200010000301100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_KONATL,50000)
        END
    OF ?IzziòasnoDBApgrozîjumaPârskats
      DO SyncWindow
        OPCIJA='01110720001311100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_APGR,50000)
        END
    OF ?IzziòasnoDBKasesGrâmata
      DO SyncWindow
        OPCIJA='01100140040300100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_KASELS,50000)
        END
    OF ?IzziòasnoDBÂrvalstuvalûtasapgrpârsk
      DO SyncWindow
        OPCIJA='01100100040300100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_KASEVAL,50000)
        END
    OF ?IzziòasnoDBGG
      DO SyncWindow
        OPCIJA='01100000000300100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_GG,50000)
        END
    OF ?IzziòasnoDBSkaidrasND
      DO SyncWindow
        OPCIJA='00000000010000100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
           OPCIJA='111'
           IZZFILTGMC
           IF GlobalResponse = RequestCompleted
              OPCIJA='200'
              IZZFILTPVN
              IF GlobalResponse = RequestCompleted
                 START(B_SnDekl,50000)
              .
           .
        .
    OF ?IzziòasnoDBApgrBILANCESkontos
      DO SyncWindow
        OPCIJA='01100000000300100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_BILFORM,50000)
        END
    OF ?IzziòasnoDBApgrOPERkontos
      DO SyncWindow
        OPCIJA='01100000000300100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_OPEFORM,50000)
        END
    OF ?5IzziòasnoDBMParkopsavilkums
      DO SyncWindow
        OPCIJA='00201000100310100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_ParKops,50000)
        END
    OF ?5IzziòasnoDBNIenIzmKopsavilkumspanod
      DO SyncWindow
        OPCIJA='01101000000300100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_NodKops,50000)
        END
    OF ?5IzziòasnoDBNIenIzmKopsavilkumspaproj
      DO SyncWindow
        OPCIJA='01100000001310100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_OBJKops,50000)
        END
    OF ?5IzziòasnoDBPPVNDEKLkopsavilkums
      DO SyncWindow
        OPCIJA='13110'
      !         12340
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='112'
      !            123
           IZZFILTPVN  !AIZPILDA KKK UN MINMAXSUMMA
           IF GlobalResponse = RequestCompleted
              START(B_PVN_DEK_KOPS,50000)
           .
        .
    OF ?IzzinasnoDBKaseszurnals
        OPCIJA='01100140040300100000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse = RequestCompleted
          START(B_KASESZURNALS,50000)
        END
      
      DO SyncWindow
    OF ?AtskaitesPVNDeklarâcijaMKN29
      DO SyncWindow
        OPCIJA='1111'
      !         1234
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='123201'
      !            123456
           IZZFILTPVN  !AIZPILDA KKK UN MINMAXSUMMA UN F:XML UN PVN-A-01(no 2009)
           IF GlobalResponse = RequestCompleted
              IF GADS>2012  !Elya 10.02.2013
                START(B_PVN_DEK_2013,100000)
!              IF S_DAT>=DATE(10,1,2011) OR B_DAT>=DATE(10,1,2011)
              ELSIF S_DAT>=DATE(10,1,2011) OR B_DAT>=DATE(10,1,2011)
      !             STOP ('WWWWW')
                 START(B_PVN_DEK_2011,100000)
              ELSIF GADS>2009
                 START(B_PVN_DEK_2010,100000)
              ELSIF GADS=2009
                 START(B_PVN_DEK_2009,100000)
              ELSE
                 START(B_PVN_DEK_MKN29,100000)
              .
           .
        END
    OF ?6AtskaitesPIE29
      DO SyncWindow
        OPCIJA='111'
      !         123
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='223111'
      !            123456
           IZZFILTPVN
           IF GlobalResponse = RequestCompleted
      !             IF GADS>2009
               IF S_DAT>=DATE(10,1,2011) OR B_DAT>=DATE(10,1,2011)
!              STOP ('WWWWW')
                 START(B_PVN_PIE_2011,50000)
              ELSIF GADS>2009
                 START(B_PVN_PIE_2010,50000)
              ELSE
                 START(B_PVN_PIE_MKN29,50000)
              .
           .
        END
      
    OF ?6AtskaitesPIE229
      DO SyncWindow
        OPCIJA='111'
      !         123
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='00340'
      !            12345
           IZZFILTPVN
           IF GlobalResponse = RequestCompleted
              IF GADS>2009
                 START(B_PVN_PIE2_2010,50000)
              ELSE
                 START(B_PVN_PIE2_MKN29,50000)
              .
           .
        END
    OF ?AtskaitesPVNDeklarâcija3pielikums
      DO SyncWindow
        OPCIJA='13110'
      !         12340
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
      !     OPCIJA='113'
           OPCIJA='113001'
      !            123456
           IZZFILTPVN  !AIZPILDA KKK UN MINMAXSUMMA
           IF GlobalResponse = RequestCompleted
              IF DB_GADS < 2002
                 START(B_PVN_DEK01,50000)
              ELSIF DB_GADS < 2009
                 START(B_PVN_DEK03,50000)
              ELSE
                 START(B_PVN_03_2009,50000)
              .
           .
        .
    OF ?6AtskaitesKPVN61
      DO SyncWindow
        OPCIJA='111'
      !         123
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='0100001'
      !            1234567
           IZZFILTPVN
           IF GlobalResponse = RequestCompleted
              F:DTK='1' !PIRMÂ DAÏA
              START(B_PVN_PIEK_MKN1028,50000)
           .
        END
    OF ?6AtskaitesLPVN62
      DO SyncWindow
        OPCIJA='111'
      !         123
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='0103001'
      !            1234567
           IZZFILTPVN
           IF GlobalResponse = RequestCompleted
              F:DTK='2' !OTRÂ DAÏA
              START(B_PVN_PIEK_MKN1028,50000)
           .
        END
    OF ?ATSKAITESKokmateriâlurealizâcijasreìistrs1P
      DO SyncWindow
        OPCIJA='111'
      !         123
        IZZFILTGMC
        IF GlobalResponse=RequestCompleted
           OPCIJA='01100'
      !            12345
           IZZFILTPVN
           IF GlobalResponse=RequestCompleted
              START(B_KOKU_R_REG,50000)
           .
        END
    OF ?ATSKAITESIegâdâtokokmateriâlureìistrs2P
      DO SyncWindow
        OPCIJA='111'
        IZZFILTGMC
        IF GlobalResponse=RequestCompleted
           OPCIJA='01100'
      !            12345
           IZZFILTPVN
           IF GlobalResponse=RequestCompleted
              START(B_KOKU_I_REG,50000)
           .
        END
    OF ?ATSKAITESPeïòasZaudçjumuaprçíins
      DO SyncWindow
        S_DAT=DB_S_DAT
        OPCIJA='01100310001311100300'
      !         12345678901234567890
        IZZFILTB
        IF GlobalResponse=RequestCompleted
           IF GADS>=2008
      !        IF F:XML
      !           KLUDA(0,'EDS v.5.12 XML interfeiss ir izstrâdes procesâ...',,1)
      !           F:XML=''
      !        .
              START(B_PZA2008,50000)
           ELSE
              START(B_PZA,50000)
           .
        END
    OF ?ATSKAITESBILANCE
      DO SyncWindow
        S_DAT=DB_S_DAT
        OPCIJA='01105310000301100410'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse=RequestCompleted
           IF GADS>=2008
              START(B_BILANCE2008,50000)
           ELSE
              START(B_BILANCE,50000)
           .
        END
    OF ?ATSKAITESNPP2
      DO SyncWindow
        OPCIJA='01100310000000100500'
      !         12345678901234567890
        S_DAT=DB_S_DAT
        IZZFILTB
        IF GlobalResponse=RequestCompleted
           IF GADS>=2008
      !        IF F:XML
      !           KLUDA(0,'EDS v.5.12 XML interfeiss ir izstrâdes procesâ...',,1)
      !           F:XML=''
      !        .
              START(B_NPP22008,50000)
           ELSE
              START(B_NPP2,50000)
           .
        END
    OF ?6AtskaitesIPaðukapitâlaizmaiòupârskatsPKIP
      DO SyncWindow
        OPCIJA='01100310000000100600'
      !         12345678901234567890
        S_DAT=DB_S_DAT
        IZZFILTB
        IF GlobalResponse=RequestCompleted
           IF GADS>=2008
      !        IF F:XML
      !           KLUDA(0,'EDS v.5.12 XML interfeiss ir izstrâdes procesâ...',,1)
      !           F:XML=''
      !        .
              START(B_PKIP2008,50000)
           ELSE
              START(B_PKIP,50000)
           .
        .
    OF ?AtskaitesAktsparsavstarpçjonorçíinusalîdzinâðnu
      DO SyncWindow
        OPCIJA='00201500060000000000'
      !         12345678901234567890
        izzfiltB
        IF GlobalResponse=RequestCompleted
          START(B_SALAKTS,50000)
        END
    OF ?6AtskaitesCIzrakstîtoPZregistrs
      DO SyncWindow
       OPCIJA='01100000000300000000'
      !        12345678901234567890
       izzfiltB
       if GlobalResponse=RequestCompleted
          D_K='K' !APGRIEÞAM OTRÂDI 15/05/06
          B_PAVREG
       .
    OF ?6AtskaitesDSanemtoPZregistrs
      DO SyncWindow
       OPCIJA='01100000000300000000'
      !        12345678901234567890
       izzfiltB
       if GlobalResponse=RequestCompleted
          D_K='D' !APGRIEÞAM OTRÂDI 15/05/06
          B_PAVREG
       .
    OF ?6AtskaitesHParskatsparPZizlietojumu
      DO SyncWindow
       OPCIJA='01100000000300001101'
      !        12345678901234567890
       izzfiltB
       if GlobalResponse=RequestCompleted
          B_PAVIZLATSK
       .
    OF ?6AtskaitesI
      DO SyncWindow
      !FILENAME_S='C:\WINLATS\BUDZETS\PASV_PAMBUDIZP_M.TPL'
      !FILENAME_D='C:\WINLATS\BUDZETS\PASV_PAMBUDIZP_M.XLT'
      !IF ~CopyFileA(FILENAME_S,FILENAME_D,0)
      !   KLUDA(3,FILENAME_S&' uz '&FILENAME_D)
      !.
      OPCIJA='111'
      IZZFILTGMC
      IF GlobalResponse = RequestCompleted
         B_MEN_PPI
      !   RUN('EXCEL C:\WINLATS\BUDZETS\PASV_PAMBUDIZP_M.XLT')
      .
    OF ?ATSKAITESPVNDeklarâcija
      DO SyncWindow
        OPCIJA='111'
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='112'
           IZZFILTPVN  !AIZPILDA KKK UN MINMAXSUMMA
           IF GlobalResponse = RequestCompleted
!              IF DB_GADS < 2003
!                 START(B_PVN_DEK,50000)
!              ELSE
                 START(B_PVN_DEK_NEW,50000)
!              .
           .
        .
    OF ?ATSKAITESPVNPielikums
      DO SyncWindow
        OPCIJA='111'
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='212'
           IZZFILTPVN
           IF GlobalResponse = RequestCompleted
              START(B_PVN_PIE,50000)
           .
        END
    OF ?ATSKAITESPVNPielikumsparKokmateriâlupiegâdçm
      DO SyncWindow
        OPCIJA='111'
      !         123
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='0110001'
      !            1234567
           IZZFILTPVN
           IF GlobalResponse = RequestCompleted
              START(B_PVN_PIEK,50000)  !vecais, vçl paglabâjam
           .
        END
    OF ?7DatuapmaiòaDatuimportsnoBrionafta
      F:DTK='1' ! JA 1, SAPROT, KA JÂLASA BRIO
      DO SyncWindow
      R_Brio_dbf 
      LocalRequest = OriginalRequest
      DO RefreshWindow
        BROWSEGG1
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
    OF ?7Datuapmaiòa2Datuimportsnoexportdat
      DO SyncWindow
      ANSIFILENAME='EXPORT.DAT'
      DOKS#=0
      RINDA#=0
      OPEN(OUTFILEANSI)
      IF ERROR()
         KLUDA(0,'Kïûda atverot EXPORT.DAT '&ERROR())
      ELSE
         SET(OUTFILEANSI)
         LOOP
            NEXT(OUTFILEANSI)
            IF ERROR() THEN BREAK.
            IF ~OUTA:LINE[1] !BREIKS
               DO AUTONUMBER
               DO MAKEFILES
               FREE(K_TABLE)
               DOKS#+=1
               RINDA#=0
               CYCLE
            .
            RINDA#+=1
            IF INRANGE(RINDA#,1,5)
               EXECUTE RINDA#
                  GG_DOK_SENR=OUTA:LINE[1:14]
                  GG_DOKDAT=DEFORMAT(OUTA:LINE[1:10],@D6.)
                  REGNR=OUTA:LINE[1:11]
                  GG_VAL=OUTA:LINE[1:3]
                  KURSS=OUTA:LINE[1:10]
               .
            ELSE
               GGK_SUMMAV=OUTA:LINE[17:27]
               LOOP I#=1 TO 2
                  J#=(I#-1)*8+1
                  IF J#=1
                     K_D_K='D'
                  ELSE
                     K_D_K='K'
                  .
                  K:KEY=K_D_K&OUTA:LINE[J#:J#+4]
                  GET(K_TABLE,K:KEY)
                  IF ERROR()
                     K:BKK=OUTA:LINE[J#:J#+4]
                     K:D_K=K_D_K
                     K:SUMMAV=GGK_SUMMAV
                     ADD(K_TABLE)
                     SORT(K_TABLE,K:KEY)
                  ELSE
                     K:SUMMAV+=GGK_SUMMAV
                     PUT(K_TABLE)
                  .
               .
            .
         .
         KLUDA(0,'Kopâ nolasîti '&clip(doks#)&' dokumenti')
         LocalRequest = OriginalRequest
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         DO BRW1::RefreshPage
      .
      CLOSE(OUTFILEANSI)
    OF ?7Datuapmaiòa3Datuimportsnoimpyymmddtxt
      DO SyncWindow
        RW_IMP_TXT(2) !IMPORTA INTERFEISÂ IELASAM IMP*****.TXT
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           F:DTK='2'  !BÂZÇ LASAM APMAIÒAS TXT
           BROWSEGG1  !STANDARTA IMPORTA INTERFEISS
           LocalRequest = OriginalRequest
           BRW1::LocateMode = LocateOnEdit
           DO BRW1::LocateRecord
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           DO BRW1::RefreshPage
        .
    OF ?7Datuapmaiòa4Datueksportsuzimporttxt
      DO SyncWindow
         RW_IMP_TXT(1)
         DO BRW1::InitializeBrowse
         DO BRW1::RefreshPage
         DISPLAY
    OF ?DarbîbasarDBIeòçmumiZaudçjuminokursusvârstîba
      DO SyncWindow
        OPCIJA='111'
        IZZFILTGMC
        IF GlobalResponse=RequestCompleted
          START(B_IEZAK,50000)
        END
    OF ?DarbîbasarDBÞurnâls
      DO SyncWindow
      START(BrowseGGK,25000)
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?SpeciâlâsfunkcijasAtrastsummu
      DO SyncWindow
      OPCIJA#=2
      DO FOUNDIT
    OF ?SpeciâlâsFAtrastNr
      DO SyncWindow
      OPCIJA#=4
      DO FOUNDIT
    OF ?8SpeciâlâsfunkcijasAtrastUNr
      DO SyncWindow
      OPCIJA#=8
      DO FOUNDIT
    OF ?AtAizDatubloku
      DO SyncWindow
      EnterGIL_Show 
      LocalRequest = OriginalRequest
      DO RefreshWindow
      if GLOBALRESPONSE=requestcompleted
         checkopen(system,1)
         DO BRW1::InitializeBrowse
         DO BRW1::RefreshPage
         QUICKWINDOW{PROP:TEXT}='Grâmatvedîbas dokumenti  '&CLIP(RECORDS(GG))&' raksti '&CLIP(LONGpath())&'\BASE'&|
         CLIP(JOB_NR)&' Atvçrts no '&format(sys:gil_show,@d06.B)
         DISPLAY
      .
    OF ?DokumentuRenum
      DO SyncWindow
      OPCIJA='11110000000010000000'
      !        12345678901234567890
       izzfiltB
      if GlobalResponse=RequestCompleted
         gg_dok_SEnr=''
         checkopen(ggk,1)
         clear(ggk:record)
         ggk:bkk=kkk
         set(ggk:bkk_dat,ggk:bkk_dat)
         LOOP
            next(ggk)
            if ERROR() OR cyclebkk(ggk:bkk,kkk)=2 then break.
            if ggk:U_NR=1 then cycle.
            if ggk:datums>b_dat THEN cycle.
            if cyclebkk(ggk:bkk,kkk) then cycle.
            IF CYCLEGGK('K113001') THEN CYCLE.
            if ggk:datums>=s_dat
               IF GETGG(ggk:U_nr)
                  gg_dok_SENR+=1
                  gg:dok_SEnr=gg_dok_SEnr
                  IF RIUPDATE:GG()
                     KLUDA(24,'GG')
                  .
               ELSE
                  stop('meklçjot gg nummuru : '&ggk:u_nr)
               .
            else
               IF getgg(ggK:U_NR)
                  gg_dok_SEnr=gg:dok_SEnr
               ELSE
                  stop('meklçjot gg nummuru : '&ggk:u_nr)
               .
            .
         .
         LocalRequest = OriginalRequest
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         DO BRW1::RefreshPage
      .
    OF ?8Speciâlâsfunkcijas7Kasesorderudrukâðana
      DO SyncWindow
      OPCIJA='11110450000010'
      !       12345678901234
      izzfiltB
      IF GlobalResponse=RequestCompleted
         IF D_K='D'
            B_IENORD(1)
         ELSE
            B_IZDORD(1)
         .
         BRW1::RefreshMode = RefreshOnQueue
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
    OF ?Nodzestlieludatubloku
      DO SyncWindow
      OPEN(ASKSCREEN)
      IF ATLAUTS[1]='1' OR ~(ATLAUTS[18]='1')
         UNHIDE(?String:RS)
         UNHIDE(?RS)
      END
      RS=''
      DOK_SK#=0
      IER_SK#=0
      PROCESS=''
      PROCESS1=''
      PROCESS2=''
      DISPLAY
      ACCEPT
         CASE FIELD()
         OF ?OkButton
            CASE EVENT()
            OF EVENT:Accepted
               DO SyncWindow
               CLOSE(GG)
               OPEN(GG,12h)
               IF ERROR()
                  KLUDA(1,'GG')
                  CHECKOPEN(GG,1)
                  CYCLE
               .
               CLOSE(GGK)
               OPEN(GGK,12h)
               IF ERROR()
                  KLUDA(1,'GGK')
                  CHECKOPEN(GG,1)
                  CYCLE
               .
               CLEAR(GG:RECORD)
               GG:DATUMS=B_DAT
               GG:SECIBA=999999999
               SET(GG:DAT_KEY,GG:DAT_KEY)
               HIDE(?CancelButton)
               HIDE(?OKBUTTON)
               LOOP
                  NEXT(GG)
      !            STOP(PAV:U_NR)
                  IF ERROR() OR GG:DATUMS < S_DAT THEN BREAK.
                  IF GG:U_NR=1 THEN CYCLE.     !SALDO IGNORÇJAM ANYWAY
                  IF ~(X=GG:KEKSIS) THEN CYCLE.
                  IF ~(RS=GG:RS) THEN CYCLE.
                  IF RIDELETE:GG()  !PÂRÂK LÇNI, DZÇÐ ARÎ GGK
                     KLUDA(26,'GG U_NR='&GG:U_NR)
                  .
                  DOK_SK#+=1
                  PROCESS='Kopâ: '&CLIP(DOK_SK#)&' Dokumenti '
                  display(?process)
               .
               CLOSE(GG)
               CHECKOPEN(GG,1)
               CLOSE(GGK)
               CHECKOPEN(GGK,1)
               UNHIDE(?CancelButton)
               ?CancelButton{prop:text}='Beigt'
               DISPLAY
            .
         OF ?CancelButton
            CASE EVENT()
            OF EVENT:Accepted
               break
            END
         END
      .
      CLOSE(ASKSCREEN)
      IF DOK_SK#
         WriteZurnals(1,3,'GG DATU BLOKS '&CHR(9)&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&CHR(9)&CLIP(DOK_SK#)&|
         CHR(9)&' Dokumenti')
         BRW1::RefreshMode = RefreshOnQueue
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
    OF ?8SpecFunkcijasItemA
      DO SyncWindow
        OPCIJA='1111'
      !         1234
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='11'
      !            12
           izzfiltF                     !NO MAINa NEDRÎKST SAUKT....
           IF GlobalResponse=RequestCompleted
              START(BuildRekini,50000)
              LocalRequest = OriginalRequest
              BRW1::LocateMode = LocateOnEdit
              DO BRW1::LocateRecord
              DO BRW1::InitializeBrowse
              DO BRW1::PostNewSelection
              DO BRW1::RefreshPage
           .
        .
    OF ?8SpeciâlâsfunkcijasItemB
      DO SyncWindow
      RUN('C:\Users\MARIS\AppData\Local\Apps\2.0\V3YQC1HX.QPO\A80BBM3Y.OKR\post..edoc_2e6198e0349e32b5_0002.0000_none_d5bbb6293ee5b1ce\PostCSP.eDoc.exe',1)
    OF ?9Analîze1Peïòazaudçjumi
      DO SyncWindow
        OPCIJA='00000010001010001000'
      !         12345678901234567890
        IZZFILTB
        IF GlobalResponse=RequestCompleted
          START(G_PELNA,50000)
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
    OF ?ButtonX
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           EXECUTE GG:KEKSIS+1
              gg:keksis=1
              GG:KEKSIS=2
              GG:KEKSIS=0
           .
           IF RIUPDATE:GG()
              KLUDA(24,'GG')
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
    OF ?ButtonEmail
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF GG:PAR_NR
        !STOP(GG:PAR_NR)
           PAR:U_NR=GG:PAR_NR
           GET(PAR_K,PAR:NR_KEY)
           IF ~ERROR()
              IF PAR:EMAIL
                 IF OUTLOOK
                    PAR_EMAIL=GETPAR_eMAIL(PAR:U_NR,0,1,0) !Ja nav citu,atgrieþ PAR:EMAIL,JA IR IZSAUC BROWSI
                    PAR_NOS_P=INIGEN(PAR:NOS_P,45,8)
                    IF INSTRING('OOK.',UPPER(OUTLOOK),1)
                       RUN(OUTLOOK&' /c ipm.note /m '&CLIP(PAR_EMAIL),1)  !ðitam vairâk par 1 parametru iedot nevar..?
        !               RUN(OUTLOOK&' /c ipm.note /m '&CLIP(PAR_EMAIL)&' /a C:\autoexec.bat',1) !a/ NEIET...
        !               RUN(OUTLOOK&' /a C:\autoexec.bat',1) !a/ IET...
                       !Creates an item with the specified file as an attachment.
                       !Outlook /a "C:\My Documents\labels.doc"
                    ELSIF INSTRING('IMN.',UPPER(OUTLOOK),1) !Outlook Express
                       RUN(OUTLOOK&' /mailurl:mailto:'&CLIP(PAR_EMAIL)&' ?Subject='&CLIP(PAR_NOS_P)&|
                       '&Body=Labdien!'&CHR(0DH)&CHR(0AH)&'Nosûtam Jums rçíinu '&CLIP(GG:DOK_SENR)&CHR(0DH)&CHR(0AH)&|
                       '________________________________________________________________'&|
                       CHR(0DH)&CHR(0AH)&'Dokuments sagatavots un nosûtîts, izmantojot programmatûru WinLats'&|
                       CHR(0DH)&CHR(0AH)&|
                       CHR(0DH)&CHR(0AH)&'Jauno versiju lejupielâde http://www.assakosmart.lv/lejupielades'&|
                       CHR(0DH)&CHR(0AH)&|
                       CHR(0DH)&CHR(0AH)&'http://www.youtube.com/channel/UC0HgM0ErZIb9ygTqDTNRNkQ'&|
                       CHR(0DH)&CHR(0AH)&|
                       CHR(0DH)&CHR(0AH)&'https://www.facebook.com/pages/Winlats/618673728171124?ref=hl'&|
                       CHR(0DH)&CHR(0AH)&|
                       CHR(0DH)&CHR(0AH)&'http://www.linkedin.com/company/3628913?trk=tyah&trkInfo=tas%3Aassako%2Cidx%3A1-1-1',1)
                    ELSIF INSTRING('AIL.',UPPER(OUTLOOK),1) !WINMAIL
                       RUN(OUTLOOK&' /mailurl:mailto:'&CLIP(PAR_EMAIL)&'?Subject='&CLIP(PAR_NOS_P)&|
                       '&Body=Labdien!'&CHR(0DH)&CHR(0AH)&'Nosûtam Jums rçíinu '&CLIP(GG:DOK_SENR)&CHR(0DH)&CHR(0AH)&|
                       '________________________________________________________________'&|
                       CHR(0DH)&CHR(0AH)&'Dokuments sagatavots un nosûtîts, izmantojot programmatûru WinLats'&|
                       CHR(0DH)&CHR(0AH)&|
                       CHR(0DH)&CHR(0AH)&'Jauno versiju lejupielâde http://www.assakosmart.lv/lejupielades'&|
                       CHR(0DH)&CHR(0AH)&|
                       CHR(0DH)&CHR(0AH)&'http://www.youtube.com/channel/UC0HgM0ErZIb9ygTqDTNRNkQ'&|
                       CHR(0DH)&CHR(0AH)&|
                       CHR(0DH)&CHR(0AH)&'https://www.facebook.com/pages/Winlats/618673728171124?ref=hl'&|
                       CHR(0DH)&CHR(0AH)&|
                       CHR(0DH)&CHR(0AH)&'http://www.linkedin.com/company/3628913?trk=tyah&trkInfo=tas%3Aassako%2Cidx%3A1-1-1',1)
        !               CHR(0DH)&CHR(0AH)&'Dokuments sagatavots un nosûtîts, izmantojot programmatûru WinLats&attach=C:\autoexec.bat',1)
                    ELSE
                       KLUDA(0,'Definçta neatïauta e-pasta programma '&OUTLOOK)   
                    .
                    IF RUNCODE()=-4
                       KLUDA(88,'prog-a '&OUTLOOK)
                    ELSE                                                                      
                       IF VESTURE::USED=0
                          CHECKOPEN(VESTURE,1)
                       .
                       VESTURE::USED+=1
                       CLEAR(VES:RECORD)
                       VES:DOK_SENR=GG:DOK_SENR
                       VES:RS=GG:RS
                       VES:APMDAT=GG:APMDAT
                       VES:DOKDAT=GG:DOKDAT
                       VES:DATUMS=TODAY()
                       VES:SECIBA=CLOCK()
                       VES:PAR_NR=PAR:U_NR
                       VES:CRM   =0
                       TEKSTS='e: '&CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
        !            STOP(TEKSTS[1:47])
                       FORMAT_TEKSTS(47,'WINDOW',8,'')
                       VES:SATURS  = F_TEKSTS[1]
        !            STOP(VES:SATURS&' '&LEN(F_TEKSTS[1]))
                       VES:SATURS2 = F_TEKSTS[2]
                       VES:SATURS3 = F_TEKSTS[3]
                       VES:SUMMA=GG:SUMMA
                       VES:ATLAIDE=GG:ATLAIDE
                       VES:VAL='Ls'
                       VES:D_K_KONTS=''
                       VES:ACC_DATUMS=today()
                       VES:ACC_KODS=ACC_kods
                       ADD(vesture)
                       VESTURE::USED-=1
                       IF VESTURE::USED=0
                          CLOSE(VESTURE)
                       .
                    .
                 ELSE
                    KLUDA(0,'Nav definçta Outlook izsaukðana C:\WINLATS\WinLatsC.ini')
                 .
              ELSE
                 KLUDA(0,CLIP(PAR:NOS_P)&' nav definçta e-pasta adrese')
              .
           ELSE
              KLUDA(0,'PARTNERIS NAV ATRASTS')
           .
        .
        SELECT(?Browse:1)
        
      END
    OF ?ButtonCopy
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         COPYREQUEST=1
         DO BRW1::ButtonInsert
      END
    OF ?GG:DATUMS
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?GG:DATUMS)
        IF GG:DATUMS
          CLEAR(GG:SECIBA,1)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?rekins
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF ~(GG:U_NR=1)
           IF ~GG:DOK_SENR
              GG:DOK_SENR=PERFORMGL(5)
              I#=RIUPDATE:GG()
           .
           IF CL_NR=1308 OR | !LASOTRA
              CL_NR=1309 OR | !TFC
              CL_NR=1371 OR | !LATIO VKV
              CL_NR=1342      !PÇTERMÂJA
              F:DTK='S'       !bûs speciâlais îres rçíins
              OPEN(SELREKWINDOW)
              ACCEPT
                CASE FIELD()
                OF ?OK:SELREK
                   GLOBALRESPONSE=REQUESTCOMPLETED
                   BREAK
                OF ?Cancel:SELREK
                   GLOBALRESPONSE=REQUESTCANCELLED
                   BREAK
                .
              .
              CLOSE(SELREKWINDOW)
              IF GLOBALRESPONSE=REQUESTCOMPLETED
                 IF F:DTK='S'
                    IF CL_NR=1308 OR|    !LASOTRA
                       CL_NR=1309        !TFC
                       B_LASOTRA
                    ELSIF CL_NR=1342 OR| !PÇTERMÂJA
                       CL_NR=1371        !LATIO
                       B_rekinsGG
                    .
                 ELSE
                    B_rekinsGG
                 .
              .
           ELSE
              F:DTK=''
              B_rekinsGG
           .
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
        .
      END
    OF ?PZ
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B_Pavad 
        LocalRequest = OriginalRequest
        DO RefreshWindow
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
      END
    OF ?KPRN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B_KontDru 
        LocalRequest = OriginalRequest
        DO RefreshWindow
           SELECT(?Browse:1)
      END
    OF ?Ieskaits
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF ~(GG:U_NR=1)
           IF ~GG:DOK_SENR
              GG:DOK_SENR=PERFORMGL(4)
              I#=RIUPDATE:GG()
           .
           OPCIJA='3'
        !          1
           izzfiltF
           IF GlobalResponse = RequestCompleted
              B_Ieskaits
              BRW1::RefreshMode = RefreshOnQueue
              DO BRW1::RefreshPage
              DO BRW1::InitializeBrowse
              DO BRW1::PostNewSelection
              SELECT(?Browse:1)
              LocalRequest = OriginalRequest
              LocalResponse = RequestCancelled
              DO RefreshWindow
           .
        .
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
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
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
      sav_par_nr=gg:par_nr  !TIKAI KONKRÇTO TAB_U NEVAR PÂRÍERT
    OF ?ButtonPartneris
      CASE EVENT()
      OF EVENT:Accepted
        PAR_NR=GG:PAR_NR !LAI TABULA NOSTÂJAS UZ ÐITO
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           sav_par_nr=PAR:U_NR
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
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF GG::Used = 0
    CheckOpen(GG,1)
  END
  GG::Used += 1
  BIND(GG:RECORD)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseGG','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('SAK_GIL',SAK_GIL)
  BIND('BEI_GIL',BEI_GIL)
  BIND('SAV_PAR_NR',SAV_PAR_NR)
  BIND('ATLAUTS',ATLAUTS)
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
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
    MAINIT231531=FALSE
  END
  PUTINI('BrowseGG','?BROWSE:1 Format',?BROWSE:1{PROP:FORMAT},'WinLats.ini')
  IF WindowOpened
    INISaveWindow('BrowseGG','winlats.INI')
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
  OF 7
    BRW1::Sort7:LocatorValue = GG:DATUMS
    CLEAR(GG:DATUMS)
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
FOUNDIT     ROUTINE
 IF OPCIJA#=4
    OPEN(KESKAWINDOW)
    ACCEPT
      CASE FIELD()
      OF ?OK:KESKA
         GLOBALRESPONSE=REQUESTCOMPLETED
         BREAK
      OF ?Cancel:KESKA
         GLOBALRESPONSE=REQUESTCANCELLED
         BREAK
      .
    .
    CLOSE(KESKAWINDOW)
 ELSE
    SUMMA_W(OPCIJA#)
 .
 IF GLOBALRESPONSE=REQUESTCOMPLETED
   DO SyncWindow
   FOUND#=0
   S_SUMMA=SUMMA
   SET(GG:DAT_KEY,GG:DAT_KEY) !VAJAG RESETOT
   LOOP
      NEXT(GG)
      IF ERROR() THEN BREAK.
      IF GG:RS='1' AND ATLAUTS[18]='1' THEN CYCLE.                         !AIZLIEGTI NEAPSTIPRINÂTIE
      IF (OPCIJA#=4 AND CLIP(KESKA)=CLIP(GG:DOK_SENR)) OR|                 !ATRAST DOK.NR
      (OPCIJA#=4 AND ~F:DTK AND INSTRING(CLIP(KESKA),GG:DOK_SENR,1,1)) OR| !ATRAST DOK.NR FRAGMENTU
      (OPCIJA#=8 AND SUMMA=GG:U_NR) OR|                                    !ATRAST U_NR
      (OPCIJA#=2 AND GG:SUMMA=SUMMA AND GG:VAL=VAL_NOS)                    !ATRAST SUMMU
         GLOBALREQUEST=CHANGERECORD
         IF GG:DATUMS < SYS:GIL_SHOW  ! SLÇGTS APGABALS
            GLOBALREQUEST=0
         .
         EXECUTE CHECKACCESS(GLOBALREQUEST,ATLAUTS[JOB_NR+39])
            BREAK
            GLOBALREQUEST=0
            GLOBALREQUEST=GLOBALREQUEST
         .
         UPDATEGG
         FOUND#=1
         BREAK
      .
   .
   IF ~FOUND#
      IF OPCIJA#=8 THEN OPCIJA#=4.
      CASE OPCIJA#
      OF 2
         KLUDA(34,VAL_NOS&' '&LEFT(SUMMA))
      OF 4
         KLUDA(0,'Dokumenta Nr(fragments) nav atrasts... '&LEFT(KESKA))
      OF 8
         KLUDA(0,'Unikâlais Nr nav atrasts... '&LEFT(SUMMA))
      .
   ELSE
      LocalRequest = OriginalRequest
      BRW1::LocateMode = LocateOnEdit
      DO BRW1::LocateRecord
      DO BRW1::InitializeBrowse
      DO BRW1::PostNewSelection
      DO BRW1::RefreshPage
   .
 .

AUTONUMBER ROUTINE
  Auto::Attempts = 0
  LOOP
    SET(GG:NR_KEY)
    PREVIOUS(GG)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GG')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:GG:U_NR = 1
    ELSE
      Auto::Save:GG:U_NR = GG:U_NR + 1
    END
    CLEAR(GG:RECORD)
    GG:U_NR = Auto::Save:GG:U_NR
    GG:DATUMS = TODAY()
    ADD(GG)
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

MAKEFILES   ROUTINE  !Ðitais ir imports no DIAMEDICA, vajadzçtu aizvâkt savâ modulî
  GG:DOK_SENR=GG_DOK_SENR
  GG:DOKDAT=GG_DOKDAT
  GG:VAL=GG_VAL
  GG:DATUMS=GG:DOKDAT
  CLEAR(PAR:RECORD)
  PAR:NMR_KODS=REGNR
  GET(PAR_K,PAR:NMR_KEY)
  IF ERROR()
     KLUDA(17,'Partneris NMR='&REGNR&' rakstam Nr='&CLIP(GG:U_NR)&' '&FORMAT(GG:DATUMS,@D6))
     GG:PAR_NR=0
  ELSE
     GG:PAR_NR=PAR:U_NR
     GG:NOKA=PAR:NOS_S
  .
  GG:ACC_KODS=ACC_KODS
  GG:ACC_DATUMS=TODAY()
  KONT#=0
  LOOP K#=1 TO RECORDS(K_TABLE)
     GET(K_TABLE,K#)
     CLEAR(GGK:RECORD)
     IF K:SUMMAV
        GGK:U_NR=GG:U_NR
        GGK:PAR_NR=GG:PAR_NR
        GGK:DATUMS=GG:DATUMS
        GGK:VAL=GG:VAL
        GGK:BKK=K:BKK
        GGK:D_K=K:D_K
        GGK:PVN_PROC=5 !TÂ VIÒIEM VIENMÇR
        GGK:PVN_TIPS='0'
        GGK:SUMMA=K:SUMMAV*KURSS
        GGK:SUMMAV=K:SUMMAV
        KONT#+=1
        ADD(GGK)
        IF GGK:D_K='D' THEN GG:SUMMA+=GGK:SUMMA.
     .
  .
  IF KONT#
     IF RIUPDATE:GG()
        KLUDA(24,'GG')
     .
  ELSE
     IF RIDELETE:GG()
        KLUDA(26,'GG')
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
  ELSIF CHOICE(?CurrentTab) = 6
    BRW1::SortOrder = 5
  ELSIF CHOICE(?CurrentTab) = 7
    BRW1::SortOrder = 6
  ELSE
    BRW1::SortOrder = 7
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
  IF SEND(GG,'QUICKSCAN=on').
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GG')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = GG:DATUMS
  OF 7
    BRW1::Sort7:HighValue = GG:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GG')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = GG:DATUMS
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  OF 7
    BRW1::Sort7:LowValue = GG:DATUMS
    SetupRealStops(BRW1::Sort7:LowValue,BRW1::Sort7:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort7:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
  IF SEND(GG,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  GG:KEKSIS = BRW1::GG:KEKSIS
  GG:RS = BRW1::GG:RS
  GG:DATUMS = BRW1::GG:DATUMS
  GG:DOK_SENR = BRW1::GG:DOK_SENR
  GG:ATT_DOK = BRW1::GG:ATT_DOK
  GG:NOKA = BRW1::GG:NOKA
  GG:SATURS = BRW1::GG:SATURS
  GG:SUMMA = BRW1::GG:SUMMA
  GG:VAL = BRW1::GG:VAL
  GG:U_NR = BRW1::GG:U_NR
  GG:SECIBA = BRW1::GG:SECIBA
  SAK_GIL = BRW1::SAK_GIL
  BEI_GIL = BRW1::BEI_GIL
  GG:PAR_NR = BRW1::GG:PAR_NR
  SAV_PAR_NR = BRW1::SAV_PAR_NR
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
!|    If the field is colorized, the colors are computed and applied.
!|
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  BRW1::GG:KEKSIS = GG:KEKSIS
  IF (GG:DATUMS<SYS:GIL_SHOW OR GG:RS)
    BRW1::GG:KEKSIS:NormalFG = 8421504
    BRW1::GG:KEKSIS:NormalBG = -1
    BRW1::GG:KEKSIS:SelectedFG = -1
    BRW1::GG:KEKSIS:SelectedBG = 12632256
  ELSE
    BRW1::GG:KEKSIS:NormalFG = -1
    BRW1::GG:KEKSIS:NormalBG = -1
    BRW1::GG:KEKSIS:SelectedFG = -1
    BRW1::GG:KEKSIS:SelectedBG = -1
  END
  BRW1::GG:RS = GG:RS
  IF (GG:DATUMS<SYS:GIL_SHOW OR GG:RS)
    BRW1::GG:RS:NormalFG = 8421504
    BRW1::GG:RS:NormalBG = -1
    BRW1::GG:RS:SelectedFG = -1
    BRW1::GG:RS:SelectedBG = 12632256
  ELSE
    BRW1::GG:RS:NormalFG = -1
    BRW1::GG:RS:NormalBG = -1
    BRW1::GG:RS:SelectedFG = -1
    BRW1::GG:RS:SelectedBG = -1
  END
  BRW1::GG:DATUMS = GG:DATUMS
  IF (GG:DATUMS<SYS:GIL_SHOW OR GG:RS)
    BRW1::GG:DATUMS:NormalFG = 8421504
    BRW1::GG:DATUMS:NormalBG = -1
    BRW1::GG:DATUMS:SelectedFG = -1
    BRW1::GG:DATUMS:SelectedBG = 12632256
  ELSE
    BRW1::GG:DATUMS:NormalFG = -1
    BRW1::GG:DATUMS:NormalBG = -1
    BRW1::GG:DATUMS:SelectedFG = -1
    BRW1::GG:DATUMS:SelectedBG = -1
  END
  BRW1::GG:DOK_SENR = GG:DOK_SENR
  IF (GG:DATUMS<SYS:GIL_SHOW OR GG:RS)
    BRW1::GG:DOK_SENR:NormalFG = 8421504
    BRW1::GG:DOK_SENR:NormalBG = -1
    BRW1::GG:DOK_SENR:SelectedFG = -1
    BRW1::GG:DOK_SENR:SelectedBG = 12632256
  ELSE
    BRW1::GG:DOK_SENR:NormalFG = -1
    BRW1::GG:DOK_SENR:NormalBG = -1
    BRW1::GG:DOK_SENR:SelectedFG = -1
    BRW1::GG:DOK_SENR:SelectedBG = -1
  END
  BRW1::GG:ATT_DOK = GG:ATT_DOK
  IF (GG:DATUMS<SYS:GIL_SHOW OR GG:RS)
    BRW1::GG:ATT_DOK:NormalFG = 8421504
    BRW1::GG:ATT_DOK:NormalBG = -1
    BRW1::GG:ATT_DOK:SelectedFG = -1
    BRW1::GG:ATT_DOK:SelectedBG = 12632256
  ELSE
    BRW1::GG:ATT_DOK:NormalFG = -1
    BRW1::GG:ATT_DOK:NormalBG = -1
    BRW1::GG:ATT_DOK:SelectedFG = -1
    BRW1::GG:ATT_DOK:SelectedBG = -1
  END
  BRW1::GG:NOKA = GG:NOKA
  IF (GG:DATUMS<SYS:GIL_SHOW OR GG:RS)
    BRW1::GG:NOKA:NormalFG = 8421504
    BRW1::GG:NOKA:NormalBG = -1
    BRW1::GG:NOKA:SelectedFG = -1
    BRW1::GG:NOKA:SelectedBG = 12632256
  ELSE
    BRW1::GG:NOKA:NormalFG = -1
    BRW1::GG:NOKA:NormalBG = -1
    BRW1::GG:NOKA:SelectedFG = -1
    BRW1::GG:NOKA:SelectedBG = -1
  END
  BRW1::GG:SATURS = GG:SATURS
  IF (GG:DATUMS<SYS:GIL_SHOW OR GG:RS)
    BRW1::GG:SATURS:NormalFG = 8421504
    BRW1::GG:SATURS:NormalBG = -1
    BRW1::GG:SATURS:SelectedFG = -1
    BRW1::GG:SATURS:SelectedBG = 12632256
  ELSE
    BRW1::GG:SATURS:NormalFG = -1
    BRW1::GG:SATURS:NormalBG = -1
    BRW1::GG:SATURS:SelectedFG = -1
    BRW1::GG:SATURS:SelectedBG = -1
  END
  BRW1::GG:SUMMA = GG:SUMMA
  IF (GG:DATUMS<SYS:GIL_SHOW OR GG:RS)
    BRW1::GG:SUMMA:NormalFG = 8421504
    BRW1::GG:SUMMA:NormalBG = -1
    BRW1::GG:SUMMA:SelectedFG = -1
    BRW1::GG:SUMMA:SelectedBG = 12632256
  ELSE
    BRW1::GG:SUMMA:NormalFG = -1
    BRW1::GG:SUMMA:NormalBG = -1
    BRW1::GG:SUMMA:SelectedFG = -1
    BRW1::GG:SUMMA:SelectedBG = -1
  END
  BRW1::GG:VAL = GG:VAL
  IF (GG:DATUMS<SYS:GIL_SHOW OR GG:RS)
    BRW1::GG:VAL:NormalFG = 8421504
    BRW1::GG:VAL:NormalBG = -1
    BRW1::GG:VAL:SelectedFG = -1
    BRW1::GG:VAL:SelectedBG = 12632256
  ELSE
    BRW1::GG:VAL:NormalFG = -1
    BRW1::GG:VAL:NormalBG = -1
    BRW1::GG:VAL:SelectedFG = -1
    BRW1::GG:VAL:SelectedBG = -1
  END
  BRW1::GG:U_NR = GG:U_NR
  IF (GG:DATUMS<SYS:GIL_SHOW OR GG:RS)
    BRW1::GG:U_NR:NormalFG = 8421504
    BRW1::GG:U_NR:NormalBG = -1
    BRW1::GG:U_NR:SelectedFG = -1
    BRW1::GG:U_NR:SelectedBG = 12632256
  ELSE
    BRW1::GG:U_NR:NormalFG = -1
    BRW1::GG:U_NR:NormalBG = -1
    BRW1::GG:U_NR:SelectedFG = -1
    BRW1::GG:U_NR:SelectedBG = -1
  END
  BRW1::GG:SECIBA = GG:SECIBA
  IF (GG:DATUMS<SYS:GIL_SHOW OR GG:RS)
    BRW1::GG:SECIBA:NormalFG = 8421504
    BRW1::GG:SECIBA:NormalBG = -1
    BRW1::GG:SECIBA:SelectedFG = -1
    BRW1::GG:SECIBA:SelectedBG = 12632256
  ELSE
    BRW1::GG:SECIBA:NormalFG = -1
    BRW1::GG:SECIBA:NormalBG = -1
    BRW1::GG:SECIBA:SelectedFG = -1
    BRW1::GG:SECIBA:SelectedBG = -1
  END
  BRW1::SAK_GIL = SAK_GIL
  BRW1::BEI_GIL = BEI_GIL
  BRW1::GG:PAR_NR = GG:PAR_NR
  BRW1::SAV_PAR_NR = SAV_PAR_NR
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
        LOOP BRW1::CurrentScroll = 100 TO 1 BY -1
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => GG:DATUMS
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
      OF 3
      OF 4
      OF 5
      OF 6
      OF 7
        LOOP BRW1::CurrentScroll = 100 TO 1 BY -1
          IF BRW1::Sort7:KeyDistribution[BRW1::CurrentScroll] => GG:DATUMS
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
  OROF 3
  OROF 4
  OROF 5
  OROF 6
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
      OF 2
      OF 3
        IF CHR(KEYCHAR())
          IF UPPER(SUB(GG:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(GG:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            GG:DATUMS = CHR(KEYCHAR())
            CLEAR(GG:SECIBA,1)
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 4
        IF CHR(KEYCHAR())
          IF UPPER(SUB(GG:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(GG:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            GG:DATUMS = CHR(KEYCHAR())
            CLEAR(GG:SECIBA,1)
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 5
        IF CHR(KEYCHAR())
          IF UPPER(SUB(GG:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(GG:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            GG:DATUMS = CHR(KEYCHAR())
            CLEAR(GG:SECIBA,1)
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 6
      OF 7
        IF CHR(KEYCHAR())
          SELECT(?GG:DATUMS)
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
    OF 1
      GG:DATUMS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 7
      GG:DATUMS = BRW1::Sort7:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
    IF SEND(GG,'QUICKSCAN=on').
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
        StandardWarning(Warn:RecordFetchError,'GG')
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
    IF SEND(GG,'QUICKSCAN=off').
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
      BRW1::HighlightedPosition = POSITION(GG:DAT_KEY)
      RESET(GG:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(GG:DAT_KEY,GG:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(BAND(gg:tips,00000001b) and ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(GG:DAT_KEY)
      RESET(GG:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(GG:DAT_KEY,GG:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(BAND(gg:tips,00000010b) AND ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 3
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(GG:DAT_KEY)
      RESET(GG:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(GG:DAT_KEY,GG:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(BAND(gg:tips,00000100b) AND ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 4
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(GG:DAT_KEY)
      RESET(GG:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(GG:DAT_KEY,GG:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(BAND(gg:tips,00001000b) AND ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 5
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(GG:DAT_KEY)
      RESET(GG:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(GG:DAT_KEY,GG:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(BAND(gg:tips,00010000b) AND ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 6
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(GG:DAT_KEY)
      RESET(GG:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(GG:DAT_KEY,GG:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(gg:par_nr=sav_par_nr AND ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 7
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(GG:DAT_KEY)
      RESET(GG:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(GG:DAT_KEY,GG:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
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
    OF 7; ?GG:DATUMS{Prop:Disable} = 0
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
    ?Change:2{Prop:Disable} = 0
    ?Delete:2{Prop:Disable} = 0
  ELSE
    CLEAR(GG:Record)
    CASE BRW1::SortOrder
    OF 7; ?GG:DATUMS{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    IF RECORDS(GG)=0
       CLEAR(GG:Record,0)
       GG:U_NR   =1
!       GG:DATUMS =DATE(1,1,gads)
       GG:DATUMS =DB_S_DAT
       GG:SATURS='SALDO uz '&format(GG:datums,@d06.)
       add(GG)
       if error() then stop('ADD GG, u_nr='&GG:u_nr&' '&error()).
!       DO BRW1::REFRESHPAGE  ... SAUC PATS SEVI???
    ELSE
       KLUDA(110,FORMAT(SAK_GIL,@D06.B)&'-'&FORMAT(BEI_GIL,@D06.B))
    .
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
    SET(GG:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(BAND(gg:tips,00000001b) and ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 2
    SET(GG:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(BAND(gg:tips,00000010b) AND ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 3
    SET(GG:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(BAND(gg:tips,00000100b) AND ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 4
    SET(GG:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(BAND(gg:tips,00001000b) AND ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 5
    SET(GG:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(BAND(gg:tips,00010000b) AND ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 6
    SET(GG:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(gg:par_nr=sav_par_nr AND ~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 7
    SET(GG:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~(GG:RS=''1''  AND  ATLAUTS[18]=''1''))'
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
  GET(GG,0)
  CLEAR(GG:Record,0)
  LocalRequest = InsertRecord
   IF COPYREQUEST=1
       DO SYNCWINDOW
       GG::U_NR=GG:U_NR
       GG:U_NR=0
       GG:DOKDAT=TODAY()
       GG:DATUMS=TODAY()
   .
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    WriteZurnals(1,1,'GG U_Nr='&CLIP(GG:U_NR)&CHR(9)&FORMAT(GG:DATUMS,@D06.)&CHR(9)&CLIP(GG:SUMMA)&CHR(9)&CLIP(GG:NOKA)&|
    CHR(9)&CLIP(GG:SATURS))
    GG::U_NR=0
  
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
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    WriteZurnals(1,2,'GG U_Nr='&CLIP(GG:U_NR)&CHR(9)&FORMAT(GG:DATUMS,@D06.)&CHR(9)&CLIP(GG:SUMMA)&CHR(9)&CLIP(GG:NOKA)&|
    CHR(9)&CLIP(GG:SATURS))
    IF BRW1::GG:DATUMS=GG:DATUMS AND BRW1::GG:SECIBA=GG:SECIBA
       GlobalResponse = RequestCancelled
    .
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
    WriteZurnals(1,3,'GG U_Nr='&CLIP(GG:U_NR)&CHR(9)&FORMAT(GG:DATUMS,@D06.)&CHR(9)&CLIP(GG:SUMMA)&CHR(9)&CLIP(GG:NOKA)&|
    CHR(9)&CLIP(GG:SATURS))
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
!| (UpdateGG) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  IF GG:DATUMS < SYS:GIL_SHOW and (LOCALREQUEST=3 OR LOCALREQUEST=2) ! SLÇGTS APGABALS
  !  STOP(GG:DATUMS&' '&SYS:GIL_SHOW)
     LOCALREQUEST=0
  .
  EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[JOB_NR+39])
     BEGIN
        GlobalResponse = RequestCancelled
        EXIT
     .
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
  .
  IF GG:U_NR=1 AND LOCALREQUEST=3      !SALDO DZÇÐANA
     KLUDA(98,'',9)            !9-ATLIKT/OK
     IF KLU_DARBIBA THEN EXIT. !OTRÂDI
     CHECKOPEN(GGK,1)
     CLEAR(GGK:RECORD)
     GGK:U_NR=1
     SET(GGK:NR_KEY,GGK:NR_KEY)
     LOOP
        NEXT(GGK)
        IF ERROR() OR ~(GGK:U_NR=1) THEN BREAK.
        DELETE(GGK)
        IF ERROR() THEN STOP('Dzçðot ggk '&ERROR()).
     .
     GG:SUMMA=0
     I#=RIUPDATE:GG()
     EXIT
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateGG
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
        GET(GG,0)
        CLEAR(GG:Record,0)
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


UpdateVestureA PROCEDURE


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
PAR_NOS_S            STRING(15)
VUT                  STRING(25)
Update::Reloop  BYTE
Update::Error   BYTE
History::VES:Record LIKE(VES:Record),STATIC
SAV::VES:Record      LIKE(VES:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('VESTURE.tps'),AT(,,262,227),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateVesture'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,4,255,200),USE(?CurrentTab),FONT(,9,,FONT:bold)
                         TAB('Aktuâlie darbi'),USE(?Tab:1)
                           BUTTON('Partneris'),AT(12,27,45,14),USE(?ButtonPartneris)
                           STRING(@n_7.0),AT(62,31),USE(VES:PAR_NR)
                           STRING(@s15),AT(95,31),USE(PAR_NOS_S)
                           STRING('Atbildîgais:'),AT(18,43),USE(?String8)
                           ENTRY(@n_3B),AT(59,43,18,10),USE(VES:KAM),DISABLE,MSG('ACC_KODS_N')
                           PROMPT('Hierarhija:'),AT(8,57,54,10),USE(?VES:DOK_SE:Prompt)
                           ENTRY(@s3b),AT(64,57,18,10),USE(VES:CRM)
                           STRING('0- noòemt no saraksta'),AT(86,57),USE(?String5),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           OPTION('Process:'),AT(64,68,70,64),USE(VES:PROCESS),BOXED
                             RADIO(' '),AT(72,78),USE(?VES:PROCESS:Radio1),VALUE('0')
                             RADIO('Nodots'),AT(72,87),USE(?VES:PROCESS:Radio2),VALUE('1')
                             RADIO('Apskatîts'),AT(72,97),USE(?VES:PROCESS:Radio3),VALUE('2')
                             RADIO('Tiek pildîts'),AT(72,107),USE(?VES:PROCESS:Radio4),VALUE('3')
                             RADIO('Izpildîts'),AT(72,117),USE(?VES:PROCESS:Radio5),VALUE('4')
                           END
                           STRING(@s25),AT(79,43,107,10),USE(VUT),LEFT(1)
                           PROMPT('Datums:'),AT(8,138),USE(?VES:DATUMS:Prompt)
                           ENTRY(@D06.B),AT(64,138,41,10),USE(VES:DATUMS),CENTER(1)
                           ENTRY(@T1),AT(107,138,27,10),USE(VES:SECIBA)
                           PROMPT('Piezîmes:'),AT(8,152),USE(?VES:SATURS:Prompt)
                           ENTRY(@s45),AT(64,152,184,10),USE(VES:SATURS),TIP('Labâ pele: mainît CASE')
                           ENTRY(@s45),AT(64,164,184,10),USE(VES:SATURS2),TIP('Labâ pele: mainît CASE')
                           ENTRY(@s45),AT(64,176,184,10),USE(VES:SATURS3),TIP('Labâ pele: mainît CASE')
                         END
                       END
                       BUTTON('&OK'),AT(165,209,45,14),USE(?OK),DEFAULT
                       BUTTON('Atlikt'),AT(215,209,45,14),USE(?Cancel)
                       STRING(@d06.),AT(3,213),USE(VES:ACC_DATUMS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       STRING(@s8),AT(49,213),USE(VES:ACC_KODS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                     END
SAV_POSITION       STRING(250)
VES_RECORD         LIKE(VES:RECORD)
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
  PAR_NOS_S=GETPAR_K(VES:PAR_NR,0,1)
  VUT=GETPARAKSTI(5,1,VES:KAM) !VUT NO LOGINA
  IF ACC_KODS_N=0 !MANA PAROLE
     ENABLE(?VES:KAM)
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
      IF KEYCODE()=MouseRight
      !   STOP('ALERTTEST'&FOCUS()&CONTENTS(FOCUS()))
         CASE FOCUS()
         OF ?VES:SATURS
            UPDATE(?VES:SATURS)
            VES:SATURS=INIGEN(VES:SATURS,LEN(CLIP(VES:SATURS)),3)
         OF ?VES:SATURS2
            UPDATE(?VES:SATURS2)
            VES:SATURS2=INIGEN(VES:SATURS2,LEN(CLIP(VES:SATURS2)),3)
         OF ?VES:SATURS3
            UPDATE(?VES:SATURS3)
            VES:SATURS3=INIGEN(VES:SATURS3,LEN(CLIP(VES:SATURS3)),3)
         .
         DISPLAY
      .
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
      ALERT(MouseRight)
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?ButtonPartneris)
      CASE LOCALREQUEST
      OF 1
         SELECT(?VES:SATURS)
      OF 2
         SELECT(?VES:SATURS)
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
        History::VES:Record = VES:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(VESTURE)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?ButtonPartneris)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::VES:Record <> VES:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:VESTURE(1)
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
              SELECT(?ButtonPartneris)
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
    OF ?ButtonPartneris
      CASE EVENT()
      OF EVENT:Accepted
        PAR_NR=VES:PAR_NR
        !stop(par_nr)
        SAV_POSITION=POSITION(VES:CRM_KEY)
        VES_RECORD=VES:RECORD
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        RESET(VES:CRM_KEY,SAV_POSITION)
        NEXT(VESTURE)
        VES:RECORD=VES_RECORD
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           VES:PAR_NR=PAR:U_NR
           PAR_NOS_S=PAR:NOS_S
        .
        DISPLAY
        
      END
    OF ?VES:KAM
      CASE EVENT()
      OF EVENT:Accepted
        VUT=GETPARAKSTI(5,1,VES:KAM) !VUT NO LOGINA
        DISPLAY
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        VES:ACC_KODS=ACC_kods
        VES:ACC_DATUMS=today()
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
  IF VESTURE::Used = 0
    CheckOpen(VESTURE,1)
  END
  VESTURE::Used += 1
  BIND(VES:RECORD)
  FilesOpened = True
  RISnap:VESTURE
  SAV::VES:Record = VES:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    CLEAR(ves:record) !JA BROWSÎ PAÒEM SYNCWINDOW, KO VAJAG DÇÏ PAR_NR, AIZPILDA VISUS LAUKUS
    VES:DATUMS    =TODAY()
    VES:SECIBA    =CLOCK()
    VES:ACC_KODS  =ACC_kods
    VES:ACC_DATUMS=today()
    VES:PAR_NR    =PAR_NR
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:VESTURE()
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
  INIRestoreWindow('UpdateVestureA','winlats.INI')
  WinResize.Resize
  ?VES:PAR_NR{PROP:Alrt,255} = 734
  ?VES:KAM{PROP:Alrt,255} = 734
  ?VES:CRM{PROP:Alrt,255} = 734
  ?VES:PROCESS{PROP:Alrt,255} = 734
  ?VES:DATUMS{PROP:Alrt,255} = 734
  ?VES:SECIBA{PROP:Alrt,255} = 734
  ?VES:SATURS{PROP:Alrt,255} = 734
  ?VES:SATURS2{PROP:Alrt,255} = 734
  ?VES:SATURS3{PROP:Alrt,255} = 734
  ?VES:ACC_DATUMS{PROP:Alrt,255} = 734
  ?VES:ACC_KODS{PROP:Alrt,255} = 734
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
    VESTURE::Used -= 1
    IF VESTURE::Used = 0 THEN CLOSE(VESTURE).
  END
  IF WindowOpened
    INISaveWindow('UpdateVestureA','winlats.INI')
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
    OF ?VES:PAR_NR
      VES:PAR_NR = History::VES:Record.PAR_NR
    OF ?VES:KAM
      VES:KAM = History::VES:Record.KAM
    OF ?VES:CRM
      VES:CRM = History::VES:Record.CRM
    OF ?VES:PROCESS
      VES:PROCESS = History::VES:Record.PROCESS
    OF ?VES:DATUMS
      VES:DATUMS = History::VES:Record.DATUMS
    OF ?VES:SECIBA
      VES:SECIBA = History::VES:Record.SECIBA
    OF ?VES:SATURS
      VES:SATURS = History::VES:Record.SATURS
    OF ?VES:SATURS2
      VES:SATURS2 = History::VES:Record.SATURS2
    OF ?VES:SATURS3
      VES:SATURS3 = History::VES:Record.SATURS3
    OF ?VES:ACC_DATUMS
      VES:ACC_DATUMS = History::VES:Record.ACC_DATUMS
    OF ?VES:ACC_KODS
      VES:ACC_KODS = History::VES:Record.ACC_KODS
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
  VES:Record = SAV::VES:Record
  VES:DATUMS = SAV_datums
  SAV::VES:Record = VES:Record
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

