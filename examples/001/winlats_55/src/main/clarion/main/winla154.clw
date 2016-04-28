                     MEMBER('winlats.clw')        ! This is a MEMBER module
BrowseNolikDarbi PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
CurrentTab           STRING(80)
RecordFiltered       LONG
Nosaukums            STRING(50)
D                    STRING(1)
CTRL                 DECIMAL(7,2)

BRW1::View:Browse    VIEW(NOLIK)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:U_NR)
                     END

Queue:Browse         QUEUE,PRE()                  ! Browsing Queue
BRW1::NOL:NOMENKLAT    LIKE(NOL:NOMENKLAT)        ! Queue Display field
BRW1::Nosaukums        LIKE(Nosaukums)            ! Queue Display field
BRW1::D                LIKE(D)                    ! Queue Display field
BRW1::NOL:DAUDZUMS     LIKE(NOL:DAUDZUMS)         ! Queue Display field
BRW1::CTRL             LIKE(CTRL)                 ! Queue Display field
BRW1::NOL:SUMMA        LIKE(NOL:SUMMA)            ! Queue Display field
BRW1::NOL:U_NR         LIKE(NOL:U_NR)             ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:Reset:APD:PAV_NR LIKE(APD:PAV_NR)
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
BrowseWindow         WINDOW('Browse Records'),AT(0,0,399,237),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),SYSTEM,GRAY,MDI
                       LIST,AT(5,5,388,211),USE(?List),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('84L(2)|M~NOMENKLAT~@s21@150L(2)|M~Nosaukums~@s50@6C|M~D~@s1@40R(2)|M~Daudzums~L@' &|
   'n_9.2@40L(2)|M~CTRL~@n-10.2@60L(2)|M~Summa~@n-9.2@'),FROM(Queue:Browse)
                       BUTTON('&Delete'),AT(4,219,40,12),USE(?Delete),DISABLE,HIDE,KEY(DeleteKey)
                       BUTTON('Iz&vçlçties'),AT(306,219,40,12),USE(?Select),FONT(,,COLOR:Navy,,CHARSET:ANSI),KEY(EnterKey)
                       BUTTON('Atlikt'),AT(348,219,40,12),USE(?Close)
                     END
D_TABLE     QUEUE,PRE(D)
NOMENKLAT_D    STRING(22) !NOMENKLATÛRA & DIENA(0)/NAKTS(1)
CTRL           DECIMAL(5,1)
            .
APD_POSITION    STRING(260)
SAV_APD_RECORD  LIKE(APD:RECORD)
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
  DO BUILDDTABLE
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?List)
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
    OF ?List
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
    OF ?Delete
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
        SUMMA=NOL:DAUDZUMS-CTRL
        IF BAND(NOL:BAITS,00000100b)
           F:DIENA='N'
        ELSE
           F:DIENA='D'
        .
        
        !~((F:DIENA='N' AND ~BAND(NOL:BAITS,00000100b)) OR (F:DIENA='D' AND BAND(NOL:BAITS,00000100b)))
        
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
  IF AUTODARBI::Used = 0
    CheckOpen(AUTODARBI,1)
  END
  AUTODARBI::Used += 1
  BIND(APD:RECORD)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  FilesOpened = True
  OPEN(BrowseWindow)
  WindowOpened=True
  INIRestoreWindow('BrowseNolikDarbi','winlats.INI')
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select{Prop:Hide} = True
    DISABLE(?Select)
  ELSE
  END
  ?List{Prop:Alrt,252} = MouseLeft2
  ?List{Prop:Alrt,252} = MouseLeft2
  ?List{Prop:Alrt,254} = DeleteKey
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
    AUTODARBI::Used -= 1
    IF AUTODARBI::Used = 0 THEN CLOSE(AUTODARBI).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF WindowOpened
    INISaveWindow('BrowseNolikDarbi','winlats.INI')
    CLOSE(BrowseWindow)
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
  IF BrowseWindow{Prop:AcceptAll} THEN EXIT.
  DO BRW1::SelectSort
  ?List{Prop:VScrollPos} = BRW1::CurrentScroll
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

BUILDDTABLE     ROUTINE

   FREE(D_TABLE)
   APD_POSITION=POSITION(APD:NR_KEY)
   SAV_APD_RECORD=APD:RECORD
   CLEAR(APD:RECORD)
   APD:PAV_NR=PAV:U_NR
   SET(APD:NR_KEY,APD:NR_KEY)
   LOOP
      NEXT(AUTODARBI)
      IF ERROR() OR ~(APD:PAV_NR=PAV:U_NR) THEN BREAK.
      D:NOMENKLAT_D=APD:NOMENKLAT&BAND(APD:BAITS,00000001b)
      GET(D_TABLE,D:NOMENKLAT_D)
      IF ERROR()
         D:CTRL=APD:LAIKS
         ADD(D_TABLE)
         SORT(D_TABLE,D:NOMENKLAT_D)
      ELSE
         D:CTRL+=APD:LAIKS
         PUT(D_TABLE)
      .
!      STOP(D:NOMENKLAT_D)
   .
   CLEAR(APD:RECORD)
   RESET(APD:NR_KEY,APD_POSITION)
   NEXT(AUTODARBI)
   APD:RECORD=SAV_APD_RECORD
!----------------------------------------------------------------------
BRW1::ValidateRecord ROUTINE
!|
!| This routine is used to provide for complex record filtering and range limiting. This
!| routine is only generated if you've included your own code in the EMBED points provided in
!| this routine.
!|
  BRW1::RecordStatus = Record:OutOfRange
  BRW1::RecordStatus = Record:Filtered
  IF ~(GETNOM_K(NOL:NOMENKLAT,0,16)='A')
     EXIT
  .
  BRW1::RecordStatus = Record:OK
  EXIT
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
      IF BRW1::Sort1:Reset:APD:PAV_NR <> APD:PAV_NR
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:APD:PAV_NR = APD:PAV_NR
    END
    DO BRW1::GetRecord
    DO BRW1::Reset
    IF BRW1::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      ELSE
        FREE(Queue:Browse)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      END
    ELSE
      IF BRW1::Changed
        FREE(Queue:Browse)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      ELSE
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      END
    END
    IF BRW1::RecordCount
      GET(Queue:Browse,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
    DO BRW1::InitializeBrowse
  ELSE
    IF BRW1::RecordCount
      GET(Queue:Browse,BRW1::CurrentChoice)
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
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  NOL:NOMENKLAT = BRW1::NOL:NOMENKLAT
  Nosaukums = BRW1::Nosaukums
  D = BRW1::D
  NOL:DAUDZUMS = BRW1::NOL:DAUDZUMS
  CTRL = BRW1::CTRL
  NOL:SUMMA = BRW1::NOL:SUMMA
  NOL:U_NR = BRW1::NOL:U_NR
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
  Nosaukums=GETNOM_K(NOL:NOMENKLAT,0,2)
  GET(D_TABLE,0)
  IF BAND(NOL:BAITS,00000100b)
     D:NOMENKLAT_D=NOL:NOMENKLAT&'1'
     D='N'
  ELSE
     D:NOMENKLAT_D=NOL:NOMENKLAT&'0'
     D='D'
  .
  GET(D_TABLE,D:NOMENKLAT_D)
  IF ERROR()
     CTRL=0
  ELSE
     CTRL=D:CTRL
  .
  BRW1::NOL:NOMENKLAT = NOL:NOMENKLAT
  BRW1::Nosaukums = Nosaukums
  BRW1::D = D
  BRW1::NOL:DAUDZUMS = NOL:DAUDZUMS
  BRW1::CTRL = CTRL
  BRW1::NOL:SUMMA = NOL:SUMMA
  BRW1::NOL:U_NR = NOL:U_NR
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
    POST(Event:NewSelection,?List)
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
        BRW1::PopupText = '&Delete|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Delete'
      END
    ELSE
      BRW1::PopupText = '~Iz&vçlçties'
      IF BRW1::PopupText
        BRW1::PopupText = '~&Delete|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '~&Delete'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Delete)
      POST(Event:Accepted,?Select)
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?List)
    GET(Queue:Browse,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
    IF BRW1::RecordCount = ?List{Prop:Items}
      IF ?List{Prop:VScroll} = False
        ?List{Prop:VScroll} = True
      END
    ELSE
      IF ?List{Prop:VScroll} = True
        ?List{Prop:VScroll} = False
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
    ?List{Prop:SelStart} = BRW1::CurrentChoice
    DO BRW1::PostNewSelection
  CASE BRW1::SortOrder
  OF 1
    BRW1::CurrentScroll = 50                      ! Move Thumb to center
    IF BRW1::RecordCount = ?List{Prop:Items}
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
  BRW1::ItemsToFill = ?List{Prop:Items}
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
  FREE(Queue:Browse)
  BRW1::RecordCount = 0
  DO BRW1::Reset
  BRW1::ItemsToFill = ?List{Prop:Items}
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
    OF DeleteKey
      POST(Event:Accepted,?Delete)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          IF UPPER(SUB(NOL:NOMENKLAT,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(NOL:NOMENKLAT,1,1)) = UPPER(CHR(KEYCHAR()))
            ?List{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            NOL:NOMENKLAT = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      END
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
  IF ?List{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?List)
  ELSIF ?List{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?List)
  ELSE
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
      GET(Queue:Browse,BRW1::RecordCount)         ! Get the first queue item
    ELSE
      GET(Queue:Browse,1)                         ! Get the first queue item
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
        StandardWarning(Warn:RecordFetchError,'NOLIK')
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
    DO BRW1::ValidateRecord
    EXECUTE(BRW1::RecordStatus)
      BEGIN
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse,BRW1::RecordCount)     ! Get the first queue item
        ELSE
          GET(Queue:Browse,1)                     ! Get the first queue item
        END
        DO BRW1::FillBuffer
        BREAK
      END
      CYCLE
    END
    IF BRW1::AddQueue
      IF BRW1::RecordCount = ?List{Prop:Items}
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse,1)                     ! Get the first queue item
        ELSE
          GET(Queue:Browse,BRW1::RecordCount)     ! Get the first queue item
        END
        DELETE(Queue:Browse)
        BRW1::RecordCount -= 1
      END
      DO BRW1::FillQueue
      IF BRW1::FillDirection = FillForward
        ADD(Queue:Browse)
      ELSE
        ADD(Queue:Browse,1)
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
      BRW1::HighlightedPosition = POSITION(NOL:NR_KEY)
      RESET(NOL:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      NOL:U_NR = APD:PAV_NR
      SET(NOL:NR_KEY,NOL:NR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'NOL:U_NR = APD:PAV_NR'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse)
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
!| records in the browse queue (Queue:Browse), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW1::RefreshMode = RefreshOnPosition
    BRW1::HighlightedPosition = POSITION(BRW1::View:Browse)
    RESET(BRW1::View:Browse,BRW1::HighlightedPosition)
    BRW1::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse)
    GET(Queue:Browse,BRW1::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse,RECORDS(Queue:Browse))
    END
    BRW1::HighlightedPosition = BRW1::Position
    GET(Queue:Browse,1)
    RESET(BRW1::View:Browse,BRW1::Position)
    BRW1::RefreshMode = RefreshOnCurrent
  ELSE
    BRW1::HighlightedPosition = ''
    DO BRW1::Reset
  END
  FREE(Queue:Browse)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = ?List{Prop:Items}
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
        GET(Queue:Browse,BRW1::CurrentChoice)
        IF BRW1::Position = BRW1::HighlightedPosition THEN BREAK.
      END
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    ELSE
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::CurrentChoice = RECORDS(Queue:Browse)
      ELSE
        BRW1::CurrentChoice = 1
      END
    END
    ?List{Prop:Selected} = BRW1::CurrentChoice
    DO BRW1::FillBuffer
    ?Delete{Prop:Disable} = 0
  ELSE
    CLEAR(NOL:Record)
    BRW1::CurrentChoice = 0
    KLUDA(0,'P/Z vçl nav ievadîti darbi...')
    do procedurereturn
    
    ?Delete{Prop:Disable} = 1
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
    NOL:U_NR = APD:PAV_NR
    SET(NOL:NR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'NOL:U_NR = APD:PAV_NR'
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
    BRW1::CurrentChoice = CHOICE(?List)
    GET(Queue:Browse,BRW1::CurrentChoice)
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
    APD:PAV_NR = BRW1::Sort1:Reset:APD:PAV_NR
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?List
  BrowseButtons.SelectButton=?Select
  BrowseButtons.InsertButton=0
  BrowseButtons.ChangeButton=0
  BrowseButtons.DeleteButton=?Delete
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
    DELETE(Queue:Browse)
    BRW1::RecordCount -= 1
  END
  BRW1::RefreshMode = RefreshOnQueue
  DO BRW1::RefreshPage
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?List)
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
!| () is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    
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
        GET(NOLIK,0)
        CLEAR(NOL:Record,0)
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
  ?List{PROP:SelStart}=BRW1::CurrentChoice
  DO BRW1::NewSelection
  REGET(BRW1::View:Browse,BRW1::Position)
  CLOSE(BRW1::View:Browse)


UpdateAUTODARBI PROCEDURE


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
VUT                  STRING(30)
NOM                  STRING(50)
Update::Reloop  BYTE
Update::Error   BYTE
History::APD:Record LIKE(APD:Record),STATIC
SAV::APD:Record      LIKE(APD:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the AUTODARBI File'),AT(,,231,126),FONT('MS Sans Serif',8,,FONT:bold),IMM,HLP('UpdateAUTODARBI'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,4,222,100),USE(?CurrentTab)
                         TAB('Meistara darbu un laika uzskaite'),USE(?Tab:1)
                           STRING(@D06.),AT(14,20),USE(APD:DATUMS)
                           STRING(@n13),AT(159,20),USE(APD:PAV_NR)
                           BUTTON('Meistars'),AT(13,32,45,14),USE(?ButtonMeistars)
                           ENTRY(@n6),AT(63,34,27,10),USE(APD:ID),REQ
                           STRING(@s30),AT(93,33),USE(VUT)
                           BUTTON('Darbi'),AT(13,47,45,14),USE(?ButtonDarbi)
                           PROMPT('&Patçrçtais laiks:'),AT(8,75,54,10),USE(?APD:LAIKS:Prompt)
                           ENTRY(@n-10.2),AT(63,75,27,10),USE(APD:LAIKS),REQ
                           STRING('max'),AT(97,76),USE(?StringMAX)
                           STRING(@n-7.2B),AT(112,76),USE(summa)
                           PROMPT('&Garantija:'),AT(8,89),USE(?APD:GARANTIJA:Prompt)
                           ENTRY(@D06.),AT(63,89,48,10),USE(APD:GARANTIJA)
                           ENTRY(@s21),AT(63,48),USE(APD:NOMENKLAT),REQ
                           STRING('Diena'),AT(163,50),USE(?DIENA)
                           STRING(@s50),AT(63,62),USE(NOM)
                         END
                       END
                       STRING(@s8),AT(11,110),USE(APD:ACC_KODS),FONT(,,COLOR:Gray,)
                       STRING(@D06.),AT(53,110),USE(APD:ACC_DATUMS),FONT(,,COLOR:Gray,)
                       BUTTON('&OK'),AT(117,108,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(166,108,45,14),USE(?Cancel)
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
  VUT=GETKADRI(APD:ID,0,1)
  NOM=GETNOM_K(APD:NOMENKLAT,0,2)
  IF BAND(APD:BAITS,00000001b)
     ?DIENA{PROP:TEXT}='Nakts'
  ELSE
     ?DIENA{PROP:TEXT}='Diena'
  .
  SUMMA=0
  IF LOCALREQUEST=2
     CLEAR(NOL:RECORD)
     NOL:U_NR=APD:PAV_NR
     SET(NOL:NR_KEY,NOL:NR_KEY)
     LOOP
        NEXT(NOLIK)
        IF ERROR() OR ~(NOL:U_NR=APD:PAV_NR) THEN BREAK.
        IF ~(NOL:NOMENKLAT=APD:NOMENKLAT) THEN CYCLE.
        IF (BAND(APD:BAITS,00000001b) AND BAND(NOL:BAITS,00000100b)) OR| !NAKTS
           (~BAND(APD:BAITS,00000001b) AND ~BAND(NOL:BAITS,00000100b))   !DIENA
           SUMMA+=NOL:DAUDZUMS
        .
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
      SELECT(?APD:DATUMS)
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
        History::APD:Record = APD:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(AUTODARBI)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?APD:DATUMS)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::APD:Record <> APD:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:AUTODARBI(1)
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
              SELECT(?APD:DATUMS)
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
    OF ?ButtonMeistars
      CASE EVENT()
      OF EVENT:Accepted
        F:NODALA=PAV:NODALA
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseKadri 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           apd:id=kad:id
           VUT=GETKADRI(APD:ID,0,1)
           DISPLAY
        .
      END
    OF ?APD:ID
      CASE EVENT()
      OF EVENT:Accepted
        VUT=GETKADRI(APD:ID,0,1)
      END
    OF ?ButtonDarbi
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNolikDarbi 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GLOBALRESPONSE=REQUESTCOMPLETED
           apd:NOMENKLAT=NOL:NOMENKLAT
           NOM=GETNOM_K(APD:NOMENKLAT,0,2)
           IF F:DIENA='N' AND ~BAND(APD:BAITS,00000001b)
              APD:BAITS+=1
              ?DIENA{PROP:TEXT}='Nakts'
           ELSIF F:DIENA='D' AND BAND(APD:BAITS,00000001b)
              APD:BAITS-=1
              ?DIENA{PROP:TEXT}='Diena'
           .
           IF LOCALREQUEST=2 THEN SUMMA+=APD:LAIKS.
           SELECT(?APD:LAIKS)
           DISPLAY
         .
      END
    OF ?APD:LAIKS
      CASE EVENT()
      OF EVENT:Accepted
        IF APD:LAIKS>SUMMA
           KLUDA(0,'Pârsniegts P/Z norâdîtais laiks...'&APD:LAIKS&'>'&SUMMA)
           SELECT(?APD:LAIKS)
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
        APD:ACC_KODS=ACC_kods
        APD:ACC_DATUMS=today()
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
  IF AUTODARBI::Used = 0
    CheckOpen(AUTODARBI,1)
  END
  AUTODARBI::Used += 1
  BIND(APD:RECORD)
  FilesOpened = True
  RISnap:AUTODARBI
  SAV::APD:Record = APD:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    APD:PAV_NR=PAV:U_NR
    APD:DATUMS=PAV:DATUMS
    APD:GARANTIJA=date(month(today()),day(today()),year(today())+1)
    APD:ACC_KODS=ACC_kods
    APD:ACC_DATUMS=today()
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:AUTODARBI()
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
  INIRestoreWindow('UpdateAUTODARBI','winlats.INI')
  WinResize.Resize
  ?APD:DATUMS{PROP:Alrt,255} = 734
  ?APD:PAV_NR{PROP:Alrt,255} = 734
  ?APD:ID{PROP:Alrt,255} = 734
  ?APD:LAIKS{PROP:Alrt,255} = 734
  ?APD:GARANTIJA{PROP:Alrt,255} = 734
  ?APD:NOMENKLAT{PROP:Alrt,255} = 734
  ?APD:ACC_KODS{PROP:Alrt,255} = 734
  ?APD:ACC_DATUMS{PROP:Alrt,255} = 734
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
    AUTODARBI::Used -= 1
    IF AUTODARBI::Used = 0 THEN CLOSE(AUTODARBI).
  END
  IF WindowOpened
    INISaveWindow('UpdateAUTODARBI','winlats.INI')
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
    OF ?APD:DATUMS
      APD:DATUMS = History::APD:Record.DATUMS
    OF ?APD:PAV_NR
      APD:PAV_NR = History::APD:Record.PAV_NR
    OF ?APD:ID
      APD:ID = History::APD:Record.ID
    OF ?APD:LAIKS
      APD:LAIKS = History::APD:Record.LAIKS
    OF ?APD:GARANTIJA
      APD:GARANTIJA = History::APD:Record.GARANTIJA
    OF ?APD:NOMENKLAT
      APD:NOMENKLAT = History::APD:Record.NOMENKLAT
    OF ?APD:ACC_KODS
      APD:ACC_KODS = History::APD:Record.ACC_KODS
    OF ?APD:ACC_DATUMS
      APD:ACC_DATUMS = History::APD:Record.ACC_DATUMS
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
  APD:Record = SAV::APD:Record
  SAV::APD:Record = APD:Record
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

UpdateKADRI PROCEDURE


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
DAIEVTEX             STRING(35),DIM(35)
CONTFIELD            DECIMAL(3)
PAR_NOS_P            STRING(35)
BAN_NOS              STRING(31)
nodtext              STRING(25)
PROTEXT              STRING(35)
JPG_NAME             STRING(10)
JPG_NOLD             STRING(10)
VVKD                 GROUP,PRE()
KAD_V_VAL            STRING(34)
KAD_KA_DA            STRING(6)
                     END
RIK_SAK_FAILS        STRING(12)
RIK_END_FAILS        STRING(12)
VVKD                 GROUP,PRE(),OVER(KAD:V_VAL)
KAD_V_VAL            STRING(34)
KAD_KA_DA            STRING(6)
                     END
RIK_U_NR             LIKE(RIK:U_NR)
SAV_NEDAR_DAT        LIKE(KAD:NEDAR_DAT)


Update::Reloop  BYTE
Update::Error   BYTE
History::KAD:Record LIKE(KAD:Record),STATIC
SAV::KAD:Record      LIKE(KAD:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:KAD:ID       LIKE(KAD:ID)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
FLD5::View           VIEW(BANKAS_K)
                       PROJECT(BAN:KODS)
                     END
Queue:FileDropCombo  QUEUE,PRE
FLD5::BAN:KODS         LIKE(BAN:KODS)
                     END
FLD5::LoopIndex      LONG,AUTO
QuickWindow          WINDOW('Update the KADRI File'),AT(,,380,337),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('UpdateKADRI'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(2,6,378,308),USE(?CurrentTab)
                         TAB('&5-Pamattdati'),USE(?Tab:1)
                           OPTION('Dzimums'),AT(15,24,77,20),USE(KAD:DZIM),BOXED
                             RADIO('S'),AT(19,32),USE(?kad:dzim:Radio1),VALUE('S')
                             RADIO('V'),AT(63,32),USE(?kad:dzim:Radio2),VALUE('V')
                           END
                           PROMPT('&ID (tabeles Nr) :'),AT(127,24,49,10),USE(?KAD:ID:Prompt)
                           ENTRY(@n4),AT(178,24,31,10),USE(KAD:ID),DISABLE
                           BUTTON('Mainît ID'),AT(215,23,35,12),USE(?ButtonID)
                           IMAGE,AT(298,23,75,100),USE(?ImageKADRI)
                           PROMPT('Uzvârds :'),AT(127,36,30,10),USE(?KAD:UZV:Prompt)
                           ENTRY(@s20),AT(178,36,81,10),USE(KAD:UZV)
                           PROMPT('Vârds :'),AT(127,48,22,10),USE(?KAD:VAR:Prompt)
                           ENTRY(@s15),AT(178,48,64,10),USE(KAD:VAR)
                           PROMPT('Tçva vards :'),AT(127,60,40,10),USE(?KAD:TEV:Prompt)
                           ENTRY(@s15),AT(178,60,64,10),USE(KAD:TEV)
                           PROMPT('Valsts kods:'),AT(128,77),USE(?KAD:V_KODS:Prompt)
                           ENTRY(@s2),AT(178,75,17,10),USE(KAD:V_KODS)
                           PROMPT('Valsts valodas prasmes lîmenis,pakâpe:'),AT(9,90,133,10),USE(?KAD:V_VAL:Prompt)
                           ENTRY(@s34),AT(141,89,155,10),USE(KAD_V_VAL)
                           IMAGE('C:\WINLATS\WLULDIS1\CHECK3.ICO'),AT(115,97,15,16),USE(?ImageMIK),HIDE
                           BUTTON('Mâcîbu iestâdes, kursi'),AT(20,100,91,12),USE(?ButtonMIK)
                           OPTION('Izglîtîba'),AT(15,43,110,44),USE(KAD:IZGLITIBA),BOXED
                             RADIO('Nav datu'),AT(19,54),USE(?kad:izglitiba:Radio1),VALUE('N')
                             RADIO('R-Arodskola'),AT(70,54,50,10),USE(?Option7:Radio13)
                             RADIO('Vidçjâ'),AT(19,74),USE(?kad:izglitiba:Radio2),VALUE('V')
                             RADIO('Koledþa'),AT(70,64),USE(?kad:izglitiba:Radio3),VALUE('K')
                             RADIO('Pamatskola'),AT(19,64,51,10),USE(?kad:izglitiba:Radio1:2),VALUE('N')
                             RADIO('Augstâkâ'),AT(70,74),USE(?kad:izglitiba:Radio4),VALUE('A')
                           END
                           PROMPT('Personas &Kods :'),AT(9,114,51,10),USE(?KAD:PERSKOD:Prompt)
                           ENTRY(@p######-#####p),AT(69,114,64,10),USE(KAD:PERSKOD),REQ,OVR
                           PROMPT('Dzimðanas vieta, pilsonîba:'),AT(9,126,91,10),USE(?KAD:DZV_P:Prompt)
                           ENTRY(@s30),AT(102,126,144,10),USE(KAD:DZV_PILS)
                           STRING(@s10),AT(314,124),USE(JPG_NAME),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           PROMPT('&Personu apliecinoðs dokuments:'),AT(9,140,107,10),USE(?KAD:PASE:Prompt)
                           ENTRY(@s60),AT(116,139,162,10),USE(KAD:PASE)
                           PROMPT('Derîgs lîdz:'),AT(279,140,40,10),USE(?KAD:PASE_END:Prompt),RIGHT
                           ENTRY(@D06.B),AT(319,139,42,10),USE(KAD:PASE_END),RIGHT(1)
                           PROMPT('Pieraksta &adrese :'),AT(9,153,57,10),USE(?KAD:PIERADR:Prompt)
                           ENTRY(@s60),AT(77,152,192,10),USE(KAD:PIERADR)
                           PROMPT('&Teritorijas kods:'),AT(273,153,57,10),USE(?KAD:TERKOD:Prompt),RIGHT
                           ENTRY(@n06),AT(331,152,31,10),USE(KAD:TERKOD),RIGHT,REQ
                           PROMPT('&Grâm/Lîguma Nr :'),AT(9,178),USE(?KAD:KARTNR:Prompt)
                           ENTRY(@s12),AT(78,178,47,10),USE(KAD:KARTNR)
                           PROMPT('Reìistrâcijas Nr :'),AT(9,190,53,10),USE(?KAD:REGNR:Prompt)
                           ENTRY(@s12),AT(78,190,47,10),USE(KAD:REGNR)
                           PROMPT('Nor.Rçíina &Nr :'),AT(9,166),USE(?KAD:REK_NR:Prompt)
                           ENTRY(@s21),AT(70,165,92,10),USE(KAD:REK_NR1),UPR
                           COMBO(@s11),AT(167,165,65,10),USE(KAD:BKODS1),FORMAT('44L~KODS~@s11@'),DROP(10),FROM(Queue:FileDropCombo)
                           STRING(@s31),AT(234,165),USE(BAN_NOS),LEFT
                           BUTTON('I&zd. VID'),AT(129,177,58,12),USE(?IzdVid)
                           STRING(@s35),AT(189,179,148,10),USE(PAR_NOS_P),LEFT
                           BUTTON('A&mats'),AT(6,203,58,12),USE(?amats)
                           ENTRY(@s25),AT(69,204,89,10),USE(KAD:AMATS)
                           OPTION('Statuss'),AT(15,247,133,63),USE(KAD:STATUSS),BOXED
                             RADIO('1 - Administrâcija (ar n. gr.)'),AT(19,254,107,10),USE(?kad:statuss:Radio1),VALUE('1')
                             RADIO('2 - Administrâcija (ar n. karti)'),AT(19,262,107,10),USE(?kad:statuss:Radio2),VALUE('2')
                             RADIO('3 - Strâdnieks (ar n. gr.)'),AT(19,271,107,10),USE(?kad:statuss:Radio3),VALUE('3')
                             RADIO('4 - Strâdnieks (ar n. karti)'),AT(19,279,107,10),USE(?kad:statuss:Radio4),VALUE('4')
                             RADIO('5 - Valdes loceklis(nesaòem algu)'),AT(19,287,126,10),USE(?kad:statuss:Radio4:2),VALUE('5')
                             RADIO('7 - Arhîvs'),AT(19,297,107,10),USE(?kad:statuss:Radio5),VALUE('7')
                           END
                           GROUP('----- Ziòas par darba òçmçju-------Z Kods'),AT(210,190,165,121),USE(?Group1),BOXED
                             PROMPT('Pieòemts:'),AT(228,207),USE(?KAD:DARBA_GR:Prompt)
                             ENTRY(@d06.B),AT(261,205,47,12),USE(KAD:DARBA_GR)
                             ENTRY(@n3B),AT(317,205,21,12),USE(KAD:Z_KODS)
                             PROMPT('ar darba &Lîgumu Nr :'),AT(213,220,67,10),USE(?KAD:LIG_PRO_NR:Prompt)
                             ENTRY(@S8),AT(281,220,37,10),USE(KAD:DAR_LIG)
                             STRING('no'),AT(320,220),USE(?String52)
                             ENTRY(@D06.B),AT(331,220,41,10),USE(KAD:DAR_DAT)
                             BUTTON('Rîkojums par pieòemðanu'),AT(215,232,94,12),USE(?ButtonSAK)
                             STRING(@s12),AT(311,234,50,10),USE(RIK_SAK_FAILS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                             BUTTON('Citi rîkojumi'),AT(226,250,58,12),USE(?ButtonRikojumi)
                             IMAGE('C:\WINLATS\WLULDIS1\CHECK3.ICO'),AT(288,246,15,16),USE(?ImageRikojumi),HIDE
                             PROMPT(' Atlaists :'),AT(229,267),USE(?KAD:DARBA_GR_end:Prompt)
                             ENTRY(@d06.B),AT(261,265,47,12),USE(KAD:D_GR_END)
                             ENTRY(@n3B),AT(317,265,21,12),USE(KAD:Z_KODS_END)
                             PROMPT('ar pavçli Nr :'),AT(237,281),USE(?KAD:LIG_PRO_NR:Prompt:2)
                             ENTRY(@s8),AT(282,281,37,10),USE(KAD:neDAR_LIG )
                             STRING('no'),AT(321,281),USE(?String52:2)
                             ENTRY(@D06.b),AT(331,281,41,10),USE(KAD:NEDAR_DAT)
                             BUTTON('Rîkojums par atlaiðanu'),AT(215,293,94,12),USE(?ButtonSAK:2)
                             STRING(@s12),AT(311,294,50,10),USE(RIK_END_FAILS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           END
                           BUTTON('&Nodaïa'),AT(6,217,58,12),USE(?BN)
                           ENTRY(@s2),AT(69,219,20,10),USE(KAD:NODALA)
                           STRING(@s25),AT(92,220,105,10),USE(nodtext)
                           BUTTON('Projekts(Obj)'),AT(6,231,52,14),USE(?ButtonObj)
                           ENTRY(@n_6b),AT(61,234,31,10),USE(KAD:OBJ_NR)
                           STRING(@s35),AT(94,234,113,10),USE(PROTEXT)
                         END
                         TAB('&6-Papildus Dati'),USE(?Tab:2)
                           OPTION('&Papildus atvieglojumi'),AT(26,27,122,101),USE(KAD:INV_P),BOXED
                             RADIO('0 - nav'),AT(37,42),USE(?KAD:INV_P:Radio1),VALUE('0')
                             RADIO('1 - 1. gr. invaliditâte'),AT(37,54),USE(?KAD:INV_P:Radio2),VALUE('1')
                             RADIO('2 - 2. gr. invaliditâte'),AT(37,65),USE(?KAD:INV_P:Radio3),VALUE('2')
                             RADIO('3 - 3. gr. invaliditâte'),AT(37,76),USE(?KAD:INV_P:Radio4),VALUE('3')
                             RADIO('4 - politiski represçta persona'),AT(37,87,109,10),USE(?KAD:INV_P:Radio5),VALUE('4')
                             RADIO('5 - PRP, nesaòem pensiju'),AT(37,98),USE(?KAD:INV_P:Radio6),VALUE('5')
                             RADIO('6 - pensionârs'),AT(37,110),USE(?KAD:INV_P:Radio7),VALUE('6')
                           END
                           GROUP('Attaisnotie izdevumi'),AT(151,27,157,73),USE(?Group2),BOXED
                             STRING('___iemaksas veic Darba òçmçjs:_{12}'),AT(152,51),USE(?String54)
                             PROMPT('Iemaksa Privâtajâ pensiju fondâ:'),AT(155,64,109,10),USE(?KAD:PPF_PROC:Prompt)
                             ENTRY(@n-6.2),AT(268,63,29,10),USE(KAD:PPF_PROC),RIGHT
                             STRING('%'),AT(300,64,5,10),USE(?String8:2)
                             PROMPT('Dzîvîbas apdroðinâðanas prçm:'),AT(157,76,107,10),USE(?KAD:DZIVAP_PROC:Prompt)
                             ENTRY(@n-6.2),AT(268,76,29,10),USE(KAD:DZIVAP_PROC),DECIMAL(12)
                             STRING('%'),AT(299,76,5,10),USE(?String8:3)
                           END
                           PROMPT('Darba devçja sociâlie maksâjumi:'),AT(155,108,111,10),USE(?KAD:PR37:Prompt)
                           ENTRY(@n5.2),AT(268,108,29,10),USE(KAD:PR37),RIGHT
                           STRING('%'),AT(300,108,5,10),USE(?String7)
                           PROMPT('Darba òçmçja sociâlie maksâjumi:'),AT(155,37,113,10),USE(?KAD:PR37:Prompt:2)
                           ENTRY(@n5.2),AT(268,37,29,10),USE(KAD:PR1),RIGHT
                           STRING('%'),AT(300,37,5,10),USE(?String8)
                           OPTION('Valst sociâlâs apdroðinâðanas statuss'),AT(25,133,324,84),USE(KAD:SOC_V),BOXED
                             RADIO('1-DN, kurð apdroðinâms atbilstoði visiem VSA veidiem'),AT(37,146),USE(?KAD:SOC_V:Radio:1),VALUE('1')
                             RADIO('2-DN, izdienas pensijas saòçmçji vai invalîdi- valsts speciâlâs pensijas saòçmçj' &|
   'i'),AT(37,158),USE(?KAD:SOC_V:Radio:2),VALUE('2')
                             RADIO('3-Valsts vecuma pensija, pieðíirta vecuma pensija ar atvieglotiem noteikumiem'),AT(37,170),USE(?KAD:SOC_V:Radio:3),VALUE('3')
                             RADIO('5-DN, kurð tiek nodarbinâts brîvîbas atòemðanas soda izcieðanas laikâ'),AT(37,192),USE(?KAD:SOC_V:Radio:5),VALUE('5')
                             RADIO('6-DN-pensionârs, kurð tiek nodarbinâts brîvîbas atòemðanas soda izcieðanas laikâ'),AT(37,203,294,10),USE(?KAD:SOC_V:Radio:6),VALUE('6')
                             RADIO('4-Persona, kura nav obligâti sociâli apdroðinâma'),AT(37,181),USE(?KAD:SOC_V:Radio:4),VALUE('4')
                           END
                           IMAGE('C:\WINLATS\WLULDIS1\CHECK3.ICO'),AT(190,217,15,16),USE(?ImageBerni),HIDE
                           PROMPT('Apgâdâjamo skaits:'),AT(33,222,67,10),USE(?KAD:APGAD:Prompt)
                           ENTRY(@n1),AT(103,222,15,10),USE(KAD:APGAD_SK),RIGHT(1)
                           BUTTON('Bçrni (lîdz 18 g.v.)'),AT(121,220,66,12),USE(?ButtonBerni)
                           PROMPT('Avanss:'),AT(33,235),USE(?KAD:AVANSS:Prompt)
                           ENTRY(@n_8.2),AT(102,235,48,10),USE(KAD:AVANSS),RIGHT(1)
                           STRING('Ls'),AT(152,235,9,10),USE(?String10)
                           PROMPT('Kapitâla daïas:'),AT(33,248,64,10),USE(?KAD_KA_DA:Prompt)
                           ENTRY(@N6.2),AT(102,248,48,10),USE(KAD_KA_DA),RIGHT(1)
                           STRING('%'),AT(152,248,9,10),USE(?String10:2),CENTER
                         END
                         TAB('&7-Pieskaitîjumi / ieturçjumi'),USE(?Tab:3)
                           STRING('Slodze'),AT(189,46),USE(?String53)
                           PROMPT('&Pieskaitîjumi'),AT(21,46,53,10),USE(?Prompt23)
                           ENTRY(@n3),AT(17,59,19,10),USE(KAD:PIESKLIST[1]),RIGHT
                           ENTRY(@n3),AT(17,71,19,10),USE(KAD:PIESKLIST[2]),RIGHT
                           STRING(@s35),AT(38,71,143,10),USE(DAIEVTEX[2]),LEFT
                           BUTTON('Pilna'),AT(181,69,35,12),USE(?ButtonSLODZE2),HIDE
                           ENTRY(@n3),AT(17,83,19,10),USE(KAD:PIESKLIST[3]),RIGHT
                           STRING(@s35),AT(38,83,143,10),USE(DAIEVTEX[3]),LEFT
                           BUTTON('Pilna'),AT(181,81,35,12),USE(?ButtonSLODZE3),HIDE
                           STRING(@s35),AT(38,59,143,10),USE(DAIEVTEX[1]),LEFT
                           BUTTON('Pilna'),AT(181,57,35,12),USE(?ButtonSLODZE1),HIDE
                           ENTRY(@n3),AT(17,94,19,10),USE(KAD:PIESKLIST[4]),RIGHT
                           STRING(@s35),AT(38,94,143,10),USE(DAIEVTEX[4]),LEFT
                           ENTRY(@n3),AT(17,106,19,10),USE(KAD:PIESKLIST[5]),RIGHT
                           STRING(@s35),AT(38,106,143,10),USE(DAIEVTEX[5]),LEFT
                           BUTTON('Pilna'),AT(181,104,35,12),USE(?ButtonSLODZE5),HIDE
                           ENTRY(@n3),AT(17,118,19,10),USE(KAD:PIESKLIST[6]),RIGHT
                           STRING(@s35),AT(38,118,143,10),USE(DAIEVTEX[6]),LEFT
                           BUTTON('Pilna'),AT(181,115,35,12),USE(?ButtonSLODZE6),HIDE
                           ENTRY(@n3),AT(17,130,19,10),USE(KAD:PIESKLIST[7]),RIGHT
                           STRING(@s35),AT(38,130,143,10),USE(DAIEVTEX[7]),LEFT
                           BUTTON('Pilna'),AT(181,127,35,12),USE(?ButtonSLODZE7),HIDE
                           ENTRY(@n3),AT(17,141,19,10),USE(KAD:PIESKLIST[8]),RIGHT
                           STRING(@s35),AT(38,141,143,10),USE(DAIEVTEX[8]),LEFT
                           BUTTON('Pilna'),AT(181,139,35,12),USE(?ButtonSLODZE8),HIDE
                           ENTRY(@n3),AT(17,152,19,10),USE(KAD:PIESKLIST[9]),RIGHT
                           STRING(@s35),AT(38,152,143,10),USE(DAIEVTEX[9]),LEFT
                           BUTTON('Pilna'),AT(181,151,35,12),USE(?ButtonSLODZE9),HIDE
                           ENTRY(@n3),AT(17,163,19,10),USE(KAD:PIESKLIST[10]),RIGHT
                           STRING(@s35),AT(38,163,143,10),USE(DAIEVTEX[10]),LEFT
                           ENTRY(@n3),AT(17,176,19,10),USE(KAD:PIESKLIST[11]),RIGHT
                           STRING(@s35),AT(38,176,143,10),USE(DAIEVTEX[11]),LEFT
                           BUTTON('Pilna'),AT(181,175,35,12),USE(?ButtonSLODZE11),HIDE
                           ENTRY(@n3),AT(17,187,19,10),USE(KAD:PIESKLIST[12]),RIGHT
                           STRING(@s35),AT(38,187,143,10),USE(DAIEVTEX[12]),LEFT
                           BUTTON('Pilna'),AT(181,187,35,12),USE(?ButtonSLODZE12),HIDE
                           ENTRY(@n3),AT(17,199,19,10),USE(KAD:PIESKLIST[13]),RIGHT
                           ENTRY(@n3),AT(17,211,19,10),USE(KAD:PIESKLIST[14]),RIGHT
                           ENTRY(@n3),AT(17,224,19,10),USE(KAD:PIESKLIST[15]),RIGHT
                           ENTRY(@n3),AT(17,236,19,10),USE(KAD:PIESKLIST[16]),RIGHT
                           ENTRY(@n3),AT(17,249,19,10),USE(KAD:PIESKLIST[17]),RIGHT
                           STRING(@s35),AT(38,249,143,10),USE(DAIEVTEX[17]),LEFT
                           ENTRY(@n3),AT(17,260,19,10),USE(KAD:PIESKLIST[18]),RIGHT
                           STRING(@s35),AT(38,260,143,10),USE(DAIEVTEX[18]),LEFT
                           ENTRY(@n3),AT(17,272,19,10),USE(KAD:PIESKLIST[19]),RIGHT
                           STRING(@s35),AT(38,272,143,10),USE(DAIEVTEX[19]),LEFT
                           BUTTON('Pilna'),AT(181,259,35,12),USE(?ButtonSLODZE18),HIDE
                           ENTRY(@n3),AT(17,285,19,10),USE(KAD:PIESKLIST[20]),RIGHT
                           STRING(@s35),AT(38,284,143,10),USE(DAIEVTEX[20]),LEFT
                           BUTTON('Pilna'),AT(181,271,35,12),USE(?ButtonSLODZE19),HIDE
                           BUTTON('Pilna'),AT(181,283,35,12),USE(?ButtonSLODZE20),HIDE
                           PROMPT('&Ieturçjumi'),AT(263,46,53,10),USE(?Prompt23:2)
                           STRING('901 Ienâkuma nodokïa pamatlikme'),AT(234,60,121,10),USE(?String13)
                           STRING('902 Ienâkuma nodokïa papildlikme'),AT(234,71,121,10),USE(?String13:2)
                           STRING('903 Darba òçmçja sociâlais nodoklis'),AT(234,83,121,10),USE(?String13:3)
                           ENTRY(@n3),AT(230,94,19,10),USE(KAD:IETLIST[1]),RIGHT
                           STRING(@s35),AT(252,94,143,10),USE(DAIEVTEX[21]),LEFT
                           BUTTON('Pilna'),AT(181,93,35,12),USE(?ButtonSLODZE4),HIDE
                           ENTRY(@n3),AT(230,106,19,10),USE(KAD:IETLIST[2]),RIGHT
                           STRING(@s35),AT(252,106,143,10),USE(DAIEVTEX[22]),LEFT
                           ENTRY(@n3),AT(230,118,19,10),USE(KAD:IETLIST[3]),RIGHT
                           STRING(@s35),AT(252,118,143,10),USE(DAIEVTEX[23]),LEFT
                           STRING(@s35),AT(252,130,143,10),USE(DAIEVTEX[24]),LEFT
                           ENTRY(@n3),AT(230,130,19,10),USE(KAD:IETLIST[4]),RIGHT
                           STRING(@s35),AT(252,141,143,10),USE(DAIEVTEX[25]),LEFT
                           ENTRY(@n3),AT(230,141,19,10),USE(KAD:IETLIST[5]),RIGHT
                           ENTRY(@n3),AT(230,152,19,10),USE(KAD:IETLIST[6]),RIGHT
                           STRING(@s35),AT(252,152,143,10),USE(DAIEVTEX[26]),LEFT
                           ENTRY(@n3),AT(230,163,19,10),USE(KAD:IETLIST[7]),RIGHT
                           STRING(@s35),AT(252,163,143,10),USE(DAIEVTEX[27]),LEFT
                           BUTTON('Pilna'),AT(181,163,35,12),USE(?ButtonSLODZE10),HIDE
                           ENTRY(@n3),AT(230,175,19,10),USE(KAD:IETLIST[8]),RIGHT
                           STRING(@s35),AT(252,175,143,10),USE(DAIEVTEX[28]),LEFT
                           ENTRY(@n3),AT(230,187,19,10),USE(KAD:IETLIST[9]),RIGHT
                           STRING(@s35),AT(252,187,143,10),USE(DAIEVTEX[29]),LEFT
                           ENTRY(@n3),AT(230,198,19,10),USE(KAD:IETLIST[10]),RIGHT
                           STRING(@s35),AT(252,198,143,10),USE(DAIEVTEX[30]),LEFT
                           BUTTON('Pilna'),AT(181,199,35,12),USE(?ButtonSLODZE13),HIDE
                           STRING(@s35),AT(252,210,143,10),USE(DAIEVTEX[31]),LEFT
                           BUTTON('Pilna'),AT(181,211,35,12),USE(?ButtonSLODZE14),HIDE
                           STRING(@s35),AT(38,199,143,10),USE(DAIEVTEX[13]),LEFT
                           ENTRY(@n3),AT(230,210,19,10),USE(KAD:IETLIST[11]),RIGHT
                           STRING(@s35),AT(38,211,143,10),USE(DAIEVTEX[14]),LEFT
                           ENTRY(@n3),AT(230,221,19,10),USE(KAD:IETLIST[12]),RIGHT
                           STRING(@s35),AT(252,221,143,10),USE(DAIEVTEX[32]),LEFT
                           BUTTON('Pilna'),AT(181,223,35,12),USE(?ButtonSLODZE15),HIDE
                           STRING(@s35),AT(38,224,143,10),USE(DAIEVTEX[15]),LEFT
                           ENTRY(@n3),AT(230,232,19,10),USE(KAD:IETLIST[13]),RIGHT
                           STRING(@s35),AT(252,232,143,10),USE(DAIEVTEX[33]),LEFT
                           BUTTON('Pilna'),AT(181,235,35,12),USE(?ButtonSLODZE16),HIDE
                           STRING(@s35),AT(38,236,143,10),USE(DAIEVTEX[16]),LEFT
                           ENTRY(@n3),AT(230,244,19,10),USE(KAD:IETLIST[14]),RIGHT
                           STRING(@s35),AT(252,244,143,10),USE(DAIEVTEX[34]),LEFT
                           BUTTON('Pilna'),AT(181,247,35,12),USE(?ButtonSLODZE17),HIDE
                           ENTRY(@n3),AT(230,255,19,10),USE(KAD:IETLIST[15]),RIGHT
                           STRING(@s35),AT(252,255,143,10),USE(DAIEVTEX[35]),LEFT
                         END
                       END
                       STRING(@s8),AT(10,319),USE(KAD:ACC_KODS),FONT(,,COLOR:Gray,)
                       BUTTON('&OK'),AT(283,317,45,16),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(333,317,45,16),USE(?Cancel)
                       STRING(@D06.B),AT(47,319),USE(KAD:ACC_DATUMS),FONT(,,COLOR:Gray,)
                     END
P_TABLE     QUEUE,PRE(P)
KODS          DECIMAL(3)
            END

IMAGEFILE   CSTRING(100) !PILNS VÂRDS
SLODZE_TEXT STRING(10)
SAV_ID      LIKE(KAD:ID)
NEW_ID      LIKE(KAD:ID)

RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
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
  NODTEXT =GETNODALAS(KAD:NODALA,1)
  PROTEXT =GETPROJEKTI(kad:OBJ_NR,1)
  JPG_NOLD='K'&CLIP(KAD:ID)&'.jpg' 
  JPG_NAME=FORMAT(KAD:ID,@N04)&'-K.jpg'
  COPY(JPG_NOLD,JPG_NAME)
  IF ~ERROR()
     ANSIFILENAME = DOCFOLDERK&'\'&JPG_NAME
     IF ~(DOS_CONT(ANSIFILENAME,1))
        RENAME(JPG_NAME,ANSIFILENAME)
     .
  .
  SAV_NEDAR_DAT=KAD:NEDAR_DAT
  RIK_SAK_FAILS = FORMAT(KAD:ID,@N04)&'-SAK.doc'
  RIK_END_FAILS = FORMAT(KAD:ID,@N04)&'-END.doc'
  
  IF GETKAD_RIK(KAD:ID,2) THEN UNHIDE(?ImageRikojumi). !IR RÎKOJUMI T='K,A,C'
  IF GETKAD_RIK(KAD:ID,3) THEN UNHIDE(?ImageMIK).      !IR MÂCÎBU IESTÂDES T='I'
  IF GETKAD_RIK(KAD:ID,4) THEN UNHIDE(?ImageBERNI).    !IR BERNI T='B'
  IF LocalRequest = InsertRecord
      PAR:NOS_P = ''
      kad:dzim = 'S'
      kad:statuss = '1'
      kad:V_KODS  = 'LV'
      KAD:IZGLITIBA = 'N'
      KAD:INV_P='0'
      KAD:SOC_V='1'
      KAD:NODALA=''
      KAD:DARBA_GR=TODAY()
      KAD:PR37=23.59
      KAD:PR1=10.5
  ELSE
      PAR_NOS_P=GETPAR_K(KAD:VID_U_Nr,0,2)
      SAV_ID=KAD:ID
  .
  LOOP I#=1 TO 20
      DAIEVTEX[I#]=CLIP(GETDAIEV(KAD:PIESKLIST[I#],0,1))&' '&GETDAIEV(KAD:PIESKLIST[I#],0,8) !+IVK
  .
  LOOP I#=1 TO 15
      DAIEVTEX[I#+20]=GETDAIEV(KAD:IETLIST[I#],0,1)
  .
  ActionMessage='Aplûkoðanas reþîms'   !ja ir localrequest, sistçma pati pârrakstîs pâri
  
  SETTARGET(QuickWindow)
  IMAGEFILE=DOCFOLDER&'\KADRI\'&JPG_NAME
  ?ImageKADRI{PROP:TEXT}=IMAGEFILE
  LOOP B#=1 TO 20
     IF KAD:SLODZE[B#]>0
        DO MODIFYSLODZE
     .
  .
  IF GETDAIEV(KAD:PIESKLIST[1],0,10)='CAL' THEN UNHIDE(?ButtonSLODZE1).
  IF GETDAIEV(KAD:PIESKLIST[2],0,10)='CAL' THEN UNHIDE(?ButtonSLODZE2).
  IF GETDAIEV(KAD:PIESKLIST[3],0,10)='CAL' THEN UNHIDE(?ButtonSLODZE3).
  IF GETDAIEV(KAD:PIESKLIST[4],0,10)='CAL' THEN UNHIDE(?ButtonSLODZE4).
  IF GETDAIEV(KAD:PIESKLIST[5],0,10)='CAL' THEN UNHIDE(?ButtonSLODZE5).
  IF GETDAIEV(KAD:PIESKLIST[6],0,10)='CAL' THEN UNHIDE(?ButtonSLODZE6).
  IF GETDAIEV(KAD:PIESKLIST[7],0,10)='CAL' THEN UNHIDE(?ButtonSLODZE7).
  IF GETDAIEV(KAD:PIESKLIST[8],0,10)='CAL' THEN UNHIDE(?ButtonSLODZE8).
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
      DO FLD5::FillList
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?kad:dzim:Radio1)
      IF LOCALREQUEST=3
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-2)
         enable(?Tab:1)  !ATVÇRT CURRENTTAB NEDRÎKST
         SELECT(?cancel)
      ELSIF LOCALREQUEST=0
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-1)
         enable(?Tab:1)
         SELECT(?cancel)
      ELSE
          SELECT(?kad:dzim)
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
        History::KAD:Record = KAD:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(KADRI)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(KAD:ID_Key)
              IF StandardWarning(Warn:DuplicateKey,'KAD:ID_Key')
                SELECT(?kad:dzim:Radio1)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?kad:dzim:Radio1)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::KAD:Record <> KAD:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:KADRI(1)
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
              SELECT(?kad:dzim:Radio1)
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
          OF 3
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?KAD:ID
      CASE EVENT()
      OF EVENT:Accepted
        IF ~(KAD:ID=SAV_ID)
           PUT(KADRI)
           NEW_ID=KAD:ID
           CHECKOPEN(ALGAS,1)
           CHECKOPEN(KAD_RIK,1)
           CHECKOPEN(PERNOS,1)
           RecordsToProcess = RECORDS(ALGAS)+RECORDS(KAD_RIK)+RECORDS(PERNOS)
           Progress:Thermometer = 0
           RecordsProcessed = 0
           PercentProgress = 0
           OPEN(ProgressWindow)
           ?Progress:PctText{Prop:Text} = '0%'
           ProgressWindow{Prop:Text} = 'Mainam ID DB'
           ?Progress:UserString{Prop:Text}=''
           DISPLAY
           SET(ALGAS)
           LOOP
              NEXT(ALGAS)
              IF ERROR() THEN BREAK.
              DO PROCESS
              IF ALG:ID=SAV_ID
                 ALG:ID=NEW_ID
                 IF RIUPDATE:ALGAS()
                    KLUDA(24,'ALGAS: '&KAD:UZV)
                 .
              .
           .
           SET(KAD_RIK)
           LOOP
              NEXT(KAD_RIK)
              IF ERROR() THEN BREAK.
              DO PROCESS
              IF RIK:ID=SAV_ID
                 RIK:ID=NEW_ID
                 IF RIUPDATE:KAD_RIK()
                    KLUDA(24,'KAD_RIK: '&KAD:UZV)
                 .
              .
           .
           SET(PERNOS)
           LOOP
              NEXT(PERNOS)
              IF ERROR() THEN BREAK.
              DO PROCESS
              IF PER:ID=SAV_ID
                 PER:ID=NEW_ID
                 IF RIUPDATE:PERNOS()
                    KLUDA(24,'PERNOS: '&KAD:UZV)
                 .
              .
           .
           IF DOS_CONT(DOCFOLDERK&'\'&FORMAT(SAV_ID,@N04)&'*.*',3,NEW_ID) !3-MAINÎT FAILA VÂRDU
              KLUDA(0,'Kïûda mainot faila vârdu')
           .
           CLOSE(ProgressWindow)
           JPG_NAME=FORMAT(KAD:ID,@N04)&'-K.jpg'
           RIK_SAK_FAILS = FORMAT(KAD:ID,@N04)&'-SAK.doc'
           RIK_END_FAILS = FORMAT(KAD:ID,@N04)&'-END.doc'
           DISPLAY
           DISABLE(?KAD:ID)
        .
      END
    OF ?ButtonID
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        KLUDA(0,'Tiks mainîts personas ID visâ DB',2)
        IF KLU_DARBIBA
           ENABLE(?KAD:ID)
           SELECT(?KAD:ID)
           DISPLAY
        .
      END
    OF ?KAD:UZV
      CASE EVENT()
      OF EVENT:Accepted
        KAD:INI = INIGEN(KAD:UZV,7,1)
      END
    OF ?KAD:TEV
      CASE EVENT()
      OF EVENT:Accepted
        !KAD:INIC = CLIP(KAD:UZV)&' '&SUB(KAD:VAR,1,1)&'.'&SUB(KAD:TEV,1,1)&'.'
        !DISPLAY(?KAD:INIC)
      END
    OF ?ButtonMIK
      CASE EVENT()
      OF EVENT:Accepted
        OPCIJA_NR=2
        DO SyncWindow
        BrowseKAD_RIK 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GETKAD_RIK(KAD:ID,3) !IR RÎKOJUMI T=I
        ! STOP('IR')
            UNHIDE(?ImageMIK)
         ELSE
            HIDE(?ImageMIK)
         .
         opcija_nr=0
         DISPLAY
      END
    OF ?KAD:PERSKOD
      CASE EVENT()
      OF EVENT:Accepted
        IF KAD:V_KODS='LV'
           CHECKKODS(KAD:PERSKOD)
        .
      END
    OF ?KAD:REK_NR1
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(KAD:REK_NR1,'')
        IF ~KAD:BKODS1 AND KAD:REK_NR1
           LOOP FLD5::LoopIndex = 1 TO RECORDS(Queue:FileDropCombo)
             GET(Queue:FileDropCombo,FLD5::LoopIndex)
             IF KAD:REK_NR1[5:8]&KAD:REK_NR1[1:2] = FLD5::BAN:KODS[1:6]
                KAD:BKODS1 = FLD5::BAN:KODS
                BAN_NOS = Getbankas_k(KAD:BKODS1,0,1)
                ACCEPTED#=1
                DISPLAY
                BREAK
             .
           END
           KAD:BKODS1{Prop:Selected} = FLD5::LoopIndex
        .
        
      END
    OF ?KAD:BKODS1
      CASE EVENT()
      OF EVENT:Accepted
        IF KAD:BKODS1 AND ~ACCEPTED#
        FLD5::BAN:KODS = KAD:BKODS1
        GET(Queue:FileDropCombo,FLD5::BAN:KODS)
        IF ERRORCODE() THEN
          SELECT(?KAD:BKODS1)
        END
        END
        BAN_NOS=GETBANKAS_K(KAD:BKODS1,0,1)
        IF BAN_NOS
            ACCEPTED#=1
        END
        KAD:BKODS1=BAN:KODS
        DISPLAY
      END
    OF ?IzdVid
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest=SelectRecord
        BrowsePAR_K
        IF GlobalResponse=RequestCompleted
            KAD:VID_U_Nr=PAR:U_NR
            PAR_NOS_P=PAR:NOS_P
!            DISPLAY(?KAD:VID_U_Nr)
            DISPLAY(?PAR_NOS_P)
        .
      END
    OF ?amats
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseAmati 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           KAD:AMATS=AMS:AMATS
           IF ~KAD:NODALA THEN KAD:NODALA=AMS:NODALA.
           DISPLAY
        END
      END
    OF ?ButtonSAK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           IF OPENANSI(RIK_SAK_FAILS,3)  !ARÎ FULL OUTFILENAME
        !      F:DBF='A'
              BYTES#=BYTES(OUTFILEANSI)
              IF ~BYTES#
                 OUTA:LINE=CLIENT
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=GL:VID_NR
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=GL:ADRESE
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=GL:REK[1]
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE='Pavçle Nr '&KAD:DAR_LIG
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE='Rîga, '&FORMAT(KAD:DAR_DAT,@D06.)
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE='Pieòemt darbâ '
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
        !         ADRESE"=GETKADRI(RIK:ID,0,18)
                 ADRESE"=KAD:PIERADR
                 IF ADRESE"
        !            OUTA:LINE=GETKADRI(RIK:ID,0,1)&' personas kods '&GETKADRI(RIK:ID,0,14)&' dzîvojoðs '&ADRESE"
                    OUTA:LINE=clip(kad:var)&' '&clip(kad:uzv)&' personas kods '&KAD:PERSKOD&' dzîvojoðs '&ADRESE"
                 ELSE
        !            OUTA:LINE=GETKADRI(RIK:ID,0,1)&' personas kods '&GETKADRI(RIK:ID,0,14)
                    OUTA:LINE=clip(kad:var)&' '&clip(kad:uzv)&' personas kods '&KAD:PERSKOD
                 .
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE=CLIP(RIK:SATURS1)&' no '&FORMAT(KAD:DARBA_GR,@D06.)
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE='Ziòas kods '&KAD:Z_KODS
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 LOOP I#=1 TO 4
                    OUTA:LINE=FILL_ZINA(KAD:Z_KODS,I#)
                    IF OUTA:LINE
                       ADD(OUTFILEANSI)
                       RAKSTI#+=1
                    .
                 .
                 LOOP I#=1 TO 3
                    OUTA:LINE=''
                    ADD(OUTFILEANSI)
                    RAKSTI#+=1
                 .
                 OUTA:LINE=SYS:AMATS1&'________________________'&SYS:PARAKSTS1
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 KLUDA(0,'Pievienoti '&raksti#&' raksti',,1)
              .
              CLOSE(OUTFILEANSI)
           !   STOP('ANSIJOB'&ANSIFILENAME)
           .
           ANSIJOB
      END
    OF ?ButtonRikojumi
      CASE EVENT()
      OF EVENT:Accepted
        OPCIJA_NR=1
        DO SyncWindow
        BrowseKAD_RIK 
        LocalRequest = OriginalRequest
        DO RefreshWindow
 IF GETKAD_RIK(KAD:ID,2) !IR RÎKOJUMI T=K,A,C
    UNHIDE(?ImageRikojumi)
 ELSE
    HIDE(?ImageRikojumi)
 .
 opcija_nr=0

      END
    OF ?KAD:Z_KODS_END
      CASE EVENT()
      OF EVENT:Accepted
        IF KAD:Z_KODS_END AND ~INRANGE(KAD:Z_KODS_END,20,29)
           KLUDA(0,KAD:Z_KODS_END&' NAV atlaiðanas kods,ievadiet kâ kadru rîkojumu')
           SELECT(?KAD:Z_KODS_END)
        .
      END
    OF ?ButtonSAK:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           IF OPENANSI(RIK_END_FAILS,3)  !ARÎ FULL OUTFILENAME
        !      F:DBF='A'
              BYTES#=BYTES(OUTFILEANSI)
              IF ~BYTES#
                 OUTA:LINE=CLIENT
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=GL:VID_NR
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=GL:ADRESE
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=GL:REK[1]
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE='Pavçle Nr '&KAD:NEDAR_LIG
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE='Rîga, '&FORMAT(KAD:NEDAR_DAT,@D06.)
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE='Atlaist no darba '
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
        !         ADRESE"=GETKADRI(RIK:ID,0,18)
                 ADRESE"=KAD:PIERADR
                 IF ADRESE"
        !            OUTA:LINE=GETKADRI(RIK:ID,0,1)&' personas kods '&GETKADRI(RIK:ID,0,14)&' dzîvojoðs '&ADRESE"
                    OUTA:LINE=clip(kad:var)&' '&clip(kad:uzv)&' personas kods '&KAD:PERSKOD&' dzîvojoðs '&ADRESE"
                 ELSE
        !            OUTA:LINE=GETKADRI(RIK:ID,0,1)&' personas kods '&GETKADRI(RIK:ID,0,14)
                    OUTA:LINE=clip(kad:var)&' '&clip(kad:uzv)&' personas kods '&KAD:PERSKOD
                 .
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE=CLIP(RIK:SATURS1)&' no '&FORMAT(KAD:D_GR_END,@D06.)
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE='Ziòas kods '&KAD:Z_KODS_END
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 LOOP I#=1 TO 4
                    OUTA:LINE=FILL_ZINA(KAD:Z_KODS_END,I#)
                    IF OUTA:LINE
                       ADD(OUTFILEANSI)
                       RAKSTI#+=1
                    .
                 .
                 LOOP I#=1 TO 3
                    OUTA:LINE=''
                    ADD(OUTFILEANSI)
                    RAKSTI#+=1
                 .
                 OUTA:LINE=SYS:AMATS1&'________________________'&SYS:PARAKSTS1
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 KLUDA(0,'Pievienoti '&raksti#&' raksti',,1)
              .
              CLOSE(OUTFILEANSI)
           !   STOP('ANSIJOB'&ANSIFILENAME)
           .
           ANSIJOB
      END
    OF ?BN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNodalas 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           KAD:NODALA=NOD:U_NR
           NODTEXT=NOD:NOS_P
           DISPLAY
        END
      END
    OF ?KAD:NODALA
      CASE EVENT()
      OF EVENT:Accepted
        NODTEXT = GETNODALAS(KAD:NODALA,1)
        DISPLAY
      END
    OF ?ButtonObj
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseProjekti 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           KAD:OBJ_NR=PRO:U_NR
           PROTEXT=PRO:NOS_P
           DISPLAY
        END
      END
    OF ?KAD:OBJ_NR
      CASE EVENT()
      OF EVENT:Accepted
        PROTEXT=GETPROJEKTI(kad:OBJ_NR,1)
        DISPLAY
      END
    OF ?KAD:INV_P
      CASE EVENT()
      OF EVENT:Accepted
         IF ~INRANGE(KAD:INV_P,0,6)
           SELECT(?KAD:INV_P)
         END
      END
    OF ?KAD:PPF_PROC
      CASE EVENT()
      OF EVENT:Accepted
        IF ~INRANGE(KAD:PPF_PROC,0,10)
           BEEP
           SELECT(?KAD:PPF_PROC)
        .
      END
    OF ?ButtonBerni
      CASE EVENT()
      OF EVENT:Accepted
        OPCIJA_NR=3
        DO SyncWindow
        BrowseKAD_RIK 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GETKAD_RIK(KAD:ID,4) !IR RÎKOJUMI T='B'
            UNHIDE(?ImageBerni)
         ELSE
            HIDE(?ImageBerni)
         .
         opcija_nr=0
        
      END
    OF ?KAD:PIESKLIST_1
      CASE EVENT()
      OF EVENT:Accepted
        I#=1
        DO FILLDAIEVTEX
        IF GETDAIEV(KAD:PIESKLIST[1],0,10)='CAL'
           UNHIDE(?ButtonSLODZE1)
        ELSE
           HIDE(?ButtonSLODZE1)
        .
      END
    OF ?KAD:PIESKLIST_2
      CASE EVENT()
      OF EVENT:Accepted
        I#=2
        DO FILLDAIEVTEX
        IF GETDAIEV(KAD:PIESKLIST[2],0,10)='CAL'
           UNHIDE(?ButtonSLODZE2)
        ELSE
           HIDE(?ButtonSLODZE2)
        .
      END
    OF ?ButtonSLODZE2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=2
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:PIESKLIST_3
      CASE EVENT()
      OF EVENT:Accepted
        I#=3
        DO FILLDAIEVTEX
        IF GETDAIEV(KAD:PIESKLIST[3],0,10)='CAL'
           UNHIDE(?ButtonSLODZE3)
        ELSE
           HIDE(?ButtonSLODZE3)
        .
      END
    OF ?ButtonSLODZE3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=3
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?ButtonSLODZE1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=1
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:PIESKLIST_4
      CASE EVENT()
      OF EVENT:Accepted
        I#=4
        DO FILLDAIEVTEX
        IF GETDAIEV(KAD:PIESKLIST[4],0,10)='CAL'
           UNHIDE(?ButtonSLODZE4)
        ELSE
           HIDE(?ButtonSLODZE4)
        .
      END
    OF ?KAD:PIESKLIST_5
      CASE EVENT()
      OF EVENT:Accepted
        I#=5
        DO FILLDAIEVTEX
        IF GETDAIEV(KAD:PIESKLIST[5],0,10)='CAL'
           UNHIDE(?ButtonSLODZE5)
        ELSE
           HIDE(?ButtonSLODZE5)
        .
      END
    OF ?ButtonSLODZE5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=5
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:PIESKLIST_6
      CASE EVENT()
      OF EVENT:Accepted
        I#=6
        DO FILLDAIEVTEX
        IF GETDAIEV(KAD:PIESKLIST[6],0,10)='CAL'
           UNHIDE(?ButtonSLODZE6)
        ELSE
           HIDE(?ButtonSLODZE6)
        .
      END
    OF ?ButtonSLODZE6
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=6
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:PIESKLIST_7
      CASE EVENT()
      OF EVENT:Accepted
        I#=7
        DO FILLDAIEVTEX
        IF GETDAIEV(KAD:PIESKLIST[7],0,10)='CAL'
           UNHIDE(?ButtonSLODZE7)
        ELSE
           HIDE(?ButtonSLODZE7)
        .
      END
    OF ?ButtonSLODZE7
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=7
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:PIESKLIST_8
      CASE EVENT()
      OF EVENT:Accepted
        I#=8
        DO FILLDAIEVTEX
        IF GETDAIEV(KAD:PIESKLIST[8],0,10)='CAL'
           UNHIDE(?ButtonSLODZE8)
        ELSE
           HIDE(?ButtonSLODZE8)
        .
      END
    OF ?ButtonSLODZE8
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=8
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:PIESKLIST_9
      CASE EVENT()
      OF EVENT:Accepted
        I#=9
        DO FILLDAIEVTEX
      END
    OF ?ButtonSLODZE9
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=9
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:PIESKLIST_10
      CASE EVENT()
      OF EVENT:Accepted
        I#=10
        DO FILLDAIEVTEX
      END
    OF ?KAD:PIESKLIST_11
      CASE EVENT()
      OF EVENT:Accepted
        I#=11
        DO FILLDAIEVTEX
      END
    OF ?ButtonSLODZE11
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=11
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:PIESKLIST_12
      CASE EVENT()
      OF EVENT:Accepted
        I#=12
        DO FILLDAIEVTEX
      END
    OF ?ButtonSLODZE12
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=12
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:PIESKLIST_13
      CASE EVENT()
      OF EVENT:Accepted
        I#=13
        DO FILLDAIEVTEX
      END
    OF ?KAD:PIESKLIST_14
      CASE EVENT()
      OF EVENT:Accepted
        I#=14
        DO FILLDAIEVTEX
      END
    OF ?KAD:PIESKLIST_15
      CASE EVENT()
      OF EVENT:Accepted
        I#=15
        DO FILLDAIEVTEX
      END
    OF ?KAD:PIESKLIST_16
      CASE EVENT()
      OF EVENT:Accepted
        I#=16
        DO FILLDAIEVTEX
      END
    OF ?KAD:PIESKLIST_17
      CASE EVENT()
      OF EVENT:Accepted
        I#=17
        DO FILLDAIEVTEX
      END
    OF ?KAD:PIESKLIST_18
      CASE EVENT()
      OF EVENT:Accepted
        I#=18
        DO FILLDAIEVTEX
      END
    OF ?KAD:PIESKLIST_19
      CASE EVENT()
      OF EVENT:Accepted
        I#=19
        DO FILLDAIEVTEX
      END
    OF ?ButtonSLODZE18
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=18
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:PIESKLIST_20
      CASE EVENT()
      OF EVENT:Accepted
        I#=20
        DO FILLDAIEVTEX
      END
    OF ?ButtonSLODZE19
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=19
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?ButtonSLODZE20
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=20
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:IETLIST_1
      CASE EVENT()
      OF EVENT:Accepted
        I#=21
        DO FILLDAIEVTEX
      END
    OF ?ButtonSLODZE4
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=4
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:IETLIST_2
      CASE EVENT()
      OF EVENT:Accepted
        I#=22
        DO FILLDAIEVTEX
      END
    OF ?KAD:IETLIST_3
      CASE EVENT()
      OF EVENT:Accepted
        I#=23
        DO FILLDAIEVTEX
      END
    OF ?KAD:IETLIST_4
      CASE EVENT()
      OF EVENT:Accepted
        I#=24
        DO FILLDAIEVTEX
      END
    OF ?KAD:IETLIST_5
      CASE EVENT()
      OF EVENT:Accepted
        I#=25
        DO FILLDAIEVTEX
      END
    OF ?KAD:IETLIST_6
      CASE EVENT()
      OF EVENT:Accepted
        I#=26
        DO FILLDAIEVTEX
      END
    OF ?KAD:IETLIST_7
      CASE EVENT()
      OF EVENT:Accepted
        I#=27
        DO FILLDAIEVTEX
      END
    OF ?ButtonSLODZE10
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=10
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:IETLIST_8
      CASE EVENT()
      OF EVENT:Accepted
        I#=28
        DO FILLDAIEVTEX
      END
    OF ?KAD:IETLIST_9
      CASE EVENT()
      OF EVENT:Accepted
        I#=29
        DO FILLDAIEVTEX
      END
    OF ?KAD:IETLIST_10
      CASE EVENT()
      OF EVENT:Accepted
        I#=30
        DO FILLDAIEVTEX
      END
    OF ?ButtonSLODZE13
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=13
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?ButtonSLODZE14
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=14
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:IETLIST_11
      CASE EVENT()
      OF EVENT:Accepted
        I#=31
        DO FILLDAIEVTEX
      END
    OF ?KAD:IETLIST_12
      CASE EVENT()
      OF EVENT:Accepted
        I#=32
        DO FILLDAIEVTEX
      END
    OF ?ButtonSLODZE15
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=15
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:IETLIST_13
      CASE EVENT()
      OF EVENT:Accepted
        I#=33
        DO FILLDAIEVTEX
      END
    OF ?ButtonSLODZE16
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=16
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:IETLIST_14
      CASE EVENT()
      OF EVENT:Accepted
        I#=34
        DO FILLDAIEVTEX
      END
    OF ?ButtonSLODZE17
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B#=17
        KAD:SLODZE[B#]+=1
        IF KAD:SLODZE[B#]=4 THEN KAD:SLODZE[B#]=0.
        DO MODIFYSLODZE
        
      END
    OF ?KAD:IETLIST_15
      CASE EVENT()
      OF EVENT:Accepted
        I#=35
        DO FILLDAIEVTEX
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
          ok#=TRUE
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
        KAD:ACC_KODS=ACC_kods
        KAD:ACC_DATUMS=today()
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
  IF BANKAS_K::Used = 0
    CheckOpen(BANKAS_K,1)
  END
  BANKAS_K::Used += 1
  BIND(BAN:RECORD)
  IF DAIEV::Used = 0
    CheckOpen(DAIEV,1)
  END
  DAIEV::Used += 1
  BIND(DAI:RECORD)
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  BIND(KAD:RECORD)
  IF KAD_RIK::Used = 0
    CheckOpen(KAD_RIK,1)
  END
  KAD_RIK::Used += 1
  BIND(RIK:RECORD)
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  FilesOpened = True
  RISnap:KADRI
  SAV::KAD:Record = KAD:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    KAD:V_KODS='LV'
    KAD:ACC_KODS=ACC_kods
    KAD:ACC_DATUMS=today()
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:KADRI()
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
  INIRestoreWindow('UpdateKADRI','winlats.INI')
  WinResize.Resize
  ?KAD:DZIM{PROP:Alrt,255} = 734
  ?KAD:ID{PROP:Alrt,255} = 734
  ?KAD:UZV{PROP:Alrt,255} = 734
  ?KAD:VAR{PROP:Alrt,255} = 734
  ?KAD:TEV{PROP:Alrt,255} = 734
  ?KAD:V_KODS{PROP:Alrt,255} = 734
  ?KAD_V_VAL{PROP:Alrt,255} = 734
  ?KAD:IZGLITIBA{PROP:Alrt,255} = 734
  ?KAD:PERSKOD{PROP:Alrt,255} = 734
  ?KAD:DZV_PILS{PROP:Alrt,255} = 734
  ?KAD:PASE{PROP:Alrt,255} = 734
  ?KAD:PASE_END{PROP:Alrt,255} = 734
  ?KAD:PIERADR{PROP:Alrt,255} = 734
  ?KAD:TERKOD{PROP:Alrt,255} = 734
  ?KAD:KARTNR{PROP:Alrt,255} = 734
  ?KAD:REGNR{PROP:Alrt,255} = 734
  ?KAD:REK_NR1{PROP:Alrt,255} = 734
  ?KAD:BKODS1{PROP:Alrt,255} = 734
  ?KAD:AMATS{PROP:Alrt,255} = 734
  ?KAD:STATUSS{PROP:Alrt,255} = 734
  ?KAD:DARBA_GR{PROP:Alrt,255} = 734
  ?KAD:Z_KODS{PROP:Alrt,255} = 734
  ?KAD:DAR_LIG{PROP:Alrt,255} = 734
  ?KAD:DAR_DAT{PROP:Alrt,255} = 734
  ?KAD:D_GR_END{PROP:Alrt,255} = 734
  ?KAD:Z_KODS_END{PROP:Alrt,255} = 734
  ?KAD:NEDAR_DAT{PROP:Alrt,255} = 734
  ?KAD:NODALA{PROP:Alrt,255} = 734
  ?KAD:OBJ_NR{PROP:Alrt,255} = 734
  ?KAD:INV_P{PROP:Alrt,255} = 734
  ?KAD:PPF_PROC{PROP:Alrt,255} = 734
  ?KAD:DZIVAP_PROC{PROP:Alrt,255} = 734
  ?KAD:PR37{PROP:Alrt,255} = 734
  ?KAD:PR1{PROP:Alrt,255} = 734
  ?KAD:SOC_V{PROP:Alrt,255} = 734
  ?KAD:APGAD_SK{PROP:Alrt,255} = 734
  ?KAD:AVANSS{PROP:Alrt,255} = 734
  ?KAD:ACC_KODS{PROP:Alrt,255} = 734
  ?KAD:ACC_DATUMS{PROP:Alrt,255} = 734
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
      IF LOCALREQUEST=1
         IF KAD:DAR_DAT>=GL:FREE_N  !REÌ.DAT
            CLEAR(RIK:RECORD)
            RIK:ID=KAD:ID
            RIK:DATUMS=KAD:DAR_DAT
            GET(KAD_RIK,RIK:ID_KEY)
            IF ERROR()
               DO AUTONUMBERRIK
               IF RIK_U_NR
                  RIK:U_NR=RIK_U_NR
                  RIK:ID=KAD:ID
                  RIK:DATUMS=KAD:DAR_DAT
                  IF KAD:DAR_LIG
                     RIK:DOK_NR=KAD:DAR_LIG
                  ELSE
                     RIK:DOK_NR=PERFORMGL(11)   !PIEÐÍIRAM RIK. NR
                     KAD:DAR_LIG=RIK:DOK_NR
                     PUT(KADRI)
                  .
                  RIK:DATUMS1=KAD:DARBA_GR
                  RIK:TIPS='K'
                  RIK:Z_KODS=KAD:Z_KODS
                  RIK:SATURS='Pieòemt darbâ no '&FORMAT(KAD:DARBA_GR,@D06.)&', amats- '&kad:amats
                  RIK:R_FAILS = FORMAT(RIK:ID,@N04)&'-SAK.doc'
                  RIK:ACC_KODS=ACC_kods
                  RIK:ACC_DATUMS=today()
                  PUT(KAD_RIK)
               .
            .
         .
      .
      IF KAD:NEDAR_DAT>SAV_NEDAR_DAT
         IF KAD:NEDAR_DAT>=GL:FREE_N  !REÌ.DAT
            RIK_U_NR=0
            CLEAR(RIK:RECORD)
            RIK:ID=KAD:ID
            RIK:DATUMS=KAD:NEDAR_DAT
            GET(KAD_RIK,RIK:ID_KEY)
            IF ERROR()
               DO AUTONUMBERRIK
               IF RIK_U_NR
                  RIK:U_NR=RIK_U_NR
                  RIK:ID=KAD:ID
                  RIK:DATUMS=KAD:NEDAR_DAT
                  IF KAD:NEDAR_LIG
                     RIK:DOK_NR=KAD:NEDAR_LIG
                  ELSE
                     RIK:DOK_NR=PERFORMGL(11)   !PIEÐÍIRAM RIK. NR
                     KAD:NEDAR_LIG=RIK:DOK_NR
                     PUT(KADRI)
                  .
                  RIK:DATUMS1=KAD:D_GR_END
                  RIK:TIPS='K'
                  RIK:Z_KODS=KAD:Z_KODS_END
                  RIK:SATURS='Atlaist no darba '&FORMAT(KAD:D_GR_END,@D06.)
                  RIK:R_FAILS = FORMAT(RIK:ID,@N04)&'-END.doc'
                  RIK:ACC_KODS=ACC_kods
                  RIK:ACC_DATUMS=today()
                  PUT(KAD_RIK)
               .
            .
         .
      .
    BANKAS_K::Used -= 1
    IF BANKAS_K::Used = 0 THEN CLOSE(BANKAS_K).
    DAIEV::Used -= 1
    IF DAIEV::Used = 0 THEN CLOSE(DAIEV).
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
    KAD_RIK::Used -= 1
    IF KAD_RIK::Used = 0 THEN CLOSE(KAD_RIK).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
  END
  IF WindowOpened
    INISaveWindow('UpdateKADRI','winlats.INI')
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
FILLDAIEVTEX       ROUTINE
 CONTFIELD=CONTENTS(FIELD())
 IF CONTFIELD=0
    DAIEVTEX[I#]=''
 ELSIF CONTFIELD=901 OR CONTFIELD=902 OR CONTFIELD=903
    DAIEVTEX[I#]=''
    BEEP
    IF I#<21
       KAD:PIESKLIST[I#]=0
    ELSE
       KAD:IETLIST[I#-20]=0
    .
    SELECT(?)
 ELSE           !DEFINÇTS DAIEV KODS
    IF I#<=20 AND CONTFIELD>899 THEN CONTFIELD=0.
    IF I#>=21 AND CONTFIELD<900 THEN CONTFIELD=0.
    DAIEVTEX[I#]=GETDAIEV(CONTFIELD,0,1)
    IF ~DAIEVTEX[I#]
       GLOBALREQUEST = SELECTRECORD
       IF I#<21
         F:IDP='P'
         IF OK#=TRUE
            KLUDA(0,'Nepazîstams pieskaitîjumu kods: '&contfield)
         .
         BROWSEDAIEV
         F:IDP=''
         IF GLOBALRESPONSE=REQUESTCOMPLETED AND ~INRANGE(DAI:KODS,840,842) AND ~INRANGE(DAI:KODS,850,851)
            KAD:PIESKLIST[I#]=DAI:KODS
            DAIEVTEX[I#]=DAI:NOSAUKUMS
         ELSE
            KAD:PIESKLIST[I#]=0
         .
       ELSE
         F:IDP='I'
         IF OK#=TRUE
            KLUDA(0,'Nepazîstams ieturçjumu kods: '&contfield)
         .
         BROWSEDAIEV
         F:IDP=''
         IF GLOBALRESPONSE=REQUESTCOMPLETED AND ~INRANGE(DAI:KODS,901,903)
            KAD:IETLIST[I#-20]=DAI:KODS
            DAIEVTEX[I#]=DAI:NOSAUKUMS
         ELSE
            KAD:IETLIST[I#-20]=0
         .
       .
    .
 .
 DISPLAY()

MODIFYSLODZE  ROUTINE
 EXECUTE KAD:SLODZE[B#]+1
    SLODZE_TEXT='Pilna'
    SLODZE_TEXT='1/2 slodze'
    SLODZE_TEXT='1/3 slodze'
    SLODZE_TEXT='1/4 slodze'
 .
 EXECUTE B#
    ?ButtonSLODZE1{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE2{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE3{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE4{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE5{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE6{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE7{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE8{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE9{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE10{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE11{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE12{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE13{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE14{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE15{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE16{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE17{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE18{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE19{PROP:TEXT}=SLODZE_TEXT
    ?ButtonSLODZE20{PROP:TEXT}=SLODZE_TEXT
 .

PROCESS  ROUTINE
      RecordsProcessed += 1
      IF PercentProgress < 100
        PercentProgress = (RecordsProcessed / RecordsToProcess)*100
        IF PercentProgress > 100
          PercentProgress = 100
        END
        IF PercentProgress <> Progress:Thermometer THEN
          Progress:Thermometer = PercentProgress
          ?Progress:PctText{Prop:Text} = 'analizçti '&FORMAT(PercentProgress,@N3) & '% no DB'
          DISPLAY()
        END
      END

!--------------------------------------------------------------------------------------------------------
AUTONUMBERRIK        ROUTINE
  LOOP
    CLEAR(RIK:RECORD)
    SET(RIK:NR_KEY)
    PREVIOUS(KAD_RIK)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'KAD_RIK')
!      POST(Event:CloseWindow)
      RIK_U_NR = 0
      EXIT
    END
    IF ERRORCODE()
      RIK_U_NR = 1
    ELSE
      RIK_U_NR = RIK:U_NR+1
    END
    CLEAR(RIK:RECORD)
    RIK:U_NR=RIK_U_NR
    ADD(KAD_RIK)
    IF ERRORCODE()
      STOP(KAD:ID&ERROR()&' KAD_RIK')
      RIK:U_NR = 0
      EXIT
    .
    BREAK
  .
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?KAD:DZIM
      KAD:DZIM = History::KAD:Record.DZIM
    OF ?KAD:ID
      KAD:ID = History::KAD:Record.ID
    OF ?KAD:UZV
      KAD:UZV = History::KAD:Record.UZV
    OF ?KAD:VAR
      KAD:VAR = History::KAD:Record.VAR
    OF ?KAD:TEV
      KAD:TEV = History::KAD:Record.TEV
    OF ?KAD:V_KODS
      KAD:V_KODS = History::KAD:Record.V_KODS
    OF ?KAD_V_VAL
      KAD_V_VAL = History::KAD:Record.V_VAL
    OF ?KAD:IZGLITIBA
      KAD:IZGLITIBA = History::KAD:Record.IZGLITIBA
    OF ?KAD:PERSKOD
      KAD:PERSKOD = History::KAD:Record.PERSKOD
    OF ?KAD:DZV_PILS
      KAD:DZV_PILS = History::KAD:Record.DZV_PILS
    OF ?KAD:PASE
      KAD:PASE = History::KAD:Record.PASE
    OF ?KAD:PASE_END
      KAD:PASE_END = History::KAD:Record.PASE_END
    OF ?KAD:PIERADR
      KAD:PIERADR = History::KAD:Record.PIERADR
    OF ?KAD:TERKOD
      KAD:TERKOD = History::KAD:Record.TERKOD
    OF ?KAD:KARTNR
      KAD:KARTNR = History::KAD:Record.KARTNR
    OF ?KAD:REGNR
      KAD:REGNR = History::KAD:Record.REGNR
    OF ?KAD:REK_NR1
      KAD:REK_NR1 = History::KAD:Record.REK_NR1
    OF ?KAD:BKODS1
      KAD:BKODS1 = History::KAD:Record.BKODS1
    OF ?KAD:AMATS
      KAD:AMATS = History::KAD:Record.AMATS
    OF ?KAD:STATUSS
      KAD:STATUSS = History::KAD:Record.STATUSS
    OF ?KAD:DARBA_GR
      KAD:DARBA_GR = History::KAD:Record.DARBA_GR
    OF ?KAD:Z_KODS
      KAD:Z_KODS = History::KAD:Record.Z_KODS
    OF ?KAD:DAR_LIG
      KAD:DAR_LIG = History::KAD:Record.DAR_LIG
    OF ?KAD:DAR_DAT
      KAD:DAR_DAT = History::KAD:Record.DAR_DAT
    OF ?KAD:D_GR_END
      KAD:D_GR_END = History::KAD:Record.D_GR_END
    OF ?KAD:Z_KODS_END
      KAD:Z_KODS_END = History::KAD:Record.Z_KODS_END
    OF ?KAD:NEDAR_DAT
      KAD:NEDAR_DAT = History::KAD:Record.NEDAR_DAT
    OF ?KAD:NODALA
      KAD:NODALA = History::KAD:Record.NODALA
    OF ?KAD:OBJ_NR
      KAD:OBJ_NR = History::KAD:Record.OBJ_NR
    OF ?KAD:INV_P
      KAD:INV_P = History::KAD:Record.INV_P
    OF ?KAD:PPF_PROC
      KAD:PPF_PROC = History::KAD:Record.PPF_PROC
    OF ?KAD:DZIVAP_PROC
      KAD:DZIVAP_PROC = History::KAD:Record.DZIVAP_PROC
    OF ?KAD:PR37
      KAD:PR37 = History::KAD:Record.PR37
    OF ?KAD:PR1
      KAD:PR1 = History::KAD:Record.PR1
    OF ?KAD:SOC_V
      KAD:SOC_V = History::KAD:Record.SOC_V
    OF ?KAD:APGAD_SK
      KAD:APGAD_SK = History::KAD:Record.APGAD_SK
    OF ?KAD:AVANSS
      KAD:AVANSS = History::KAD:Record.AVANSS
    OF ?KAD:ACC_KODS
      KAD:ACC_KODS = History::KAD:Record.ACC_KODS
    OF ?KAD:ACC_DATUMS
      KAD:ACC_DATUMS = History::KAD:Record.ACC_DATUMS
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
  KAD:Record = SAV::KAD:Record
  SAV::KAD:Record = KAD:Record
  Auto::Attempts = 0
  LOOP
    SET(KAD:ID_Key)
    PREVIOUS(KADRI)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'KADRI')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:KAD:ID = 1
    ELSE
      Auto::Save:KAD:ID = KAD:ID + 1
    END
    KAD:Record = SAV::KAD:Record
    KAD:ID = Auto::Save:KAD:ID
    SAV::KAD:Record = KAD:Record
    ADD(KADRI)
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
        DELETE(KADRI)
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

!--------------------------------------------------------
FLD5::FillList ROUTINE
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
  FLD5::BAN:KODS = KAD:BKODS1
  SET(BANKAS_K)
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
        StandardWarning(Warn:RecordFetchError,'BANKAS_K')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    FLD5::BAN:KODS = BAN:KODS
    ADD(Queue:FileDropCombo)
  END
  CLOSE(FLD5::View)
  IF RECORDS(Queue:FileDropCombo)
    SORT(Queue:FileDropCombo,FLD5::BAN:KODS)
    IF KAD:BKODS1
      LOOP FLD5::LoopIndex = 1 TO RECORDS(Queue:FileDropCombo)
        GET(Queue:FileDropCombo,FLD5::LoopIndex)
        IF KAD:BKODS1 = FLD5::BAN:KODS THEN BREAK.
      END
      ?KAD:BKODS1{Prop:Selected} = FLD5::LoopIndex
    END
  ELSE
    CLEAR(KAD:BKODS1)
  END
