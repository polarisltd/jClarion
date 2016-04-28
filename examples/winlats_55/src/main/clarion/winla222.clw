                     MEMBER('winlats.clw')        ! This is a MEMBER module
GetProjekti          FUNCTION (PROJEKTS,OPC)      ! Declare Procedure
  CODE                                            ! Begin processed code
!
! ATGRIEÞ PROJEKTA NOSAUKUMU,KODU
!
 IF PROJEKTS
    IF PROJEKTI::USED=0
       CHECKOPEN(PROJEKTI,1)
    .
    PROJEKTI::USED+=1
    CLEAR(PRO:RECORD)
    PRO:U_NR=PROJEKTS
    GET(PROJEKTI,PRO:NR_KEY)
    IF ERROR()
       RETURN('')
    .
    PROJEKTI::USED-=1
    IF PROJEKTI::USED=0
       CLOSE(PROJEKTI)
    .
 ELSE
   RETURN('')
 .
 EXECUTE OPC
   RETURN(PRO:NOS_P)
   RETURN(PRO:KODS)
 .
BrowseKOIVUNEN PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
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


BRW1::View:Browse    VIEW(KOIVUNEN)
                       PROJECT(KOI:PIEG)
                       PROJECT(KOI:PIEG_KODS)
                       PROJECT(KOI:MIN_IEP)
                       PROJECT(KOI:CENA)
                       PROJECT(KOI:VCENA)
                       PROJECT(KOI:MCENA)
                       PROJECT(KOI:VALUTA)
                       PROJECT(KOI:DATUMS)
                       PROJECT(KOI:KEKSIS)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::KOI:PIEG         LIKE(KOI:PIEG)             ! Queue Display field
BRW1::KOI:PIEG_KODS    LIKE(KOI:PIEG_KODS)        ! Queue Display field
BRW1::KOI:MIN_IEP      LIKE(KOI:MIN_IEP)          ! Queue Display field
BRW1::KOI:CENA         LIKE(KOI:CENA)             ! Queue Display field
BRW1::KOI:VCENA        LIKE(KOI:VCENA)            ! Queue Display field
BRW1::KOI:MCENA        LIKE(KOI:MCENA)            ! Queue Display field
BRW1::KOI:VALUTA       LIKE(KOI:VALUTA)           ! Queue Display field
BRW1::KOI:DATUMS       LIKE(KOI:DATUMS)           ! Queue Display field
BRW1::KOI:KEKSIS       LIKE(KOI:KEKSIS)           ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Iepirkuma cenu apmaiòas fails'),AT(,,358,184),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseKOIVUNEN'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,342,136),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('21L(2)|M~Pieg~@s3@72L(2)|M~PIEG_KODS~@s17@40R(1)|M~Min.iep.~C(0)@n10.2@39R(1)|M~' &|
   'CENA~C(0)@n10.2@40R(1)|M~VCENA~C(0)@n10.2@40R(1)|M~MCENA~C(0)@n10.2@16R(1)|M~Val' &|
   '.~C(0)@s3@45R(2)|M~DATUMS~C(0)@d6@28L(1)|M~K~@s1@'),FROM(Queue:Browse:1)
                       SHEET,AT(4,4,350,162),USE(?CurrentTab)
                         TAB('Ierakstu fiziskâ secîba'),USE(?Tab:2)
                         END
                       END
                       BUTTON('&Beigt'),AT(310,169,45,14),USE(?Close)
                       BUTTON('Importçt'),AT(262,169,45,14),USE(?ButtonImportçt)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  TTAKA"=PATH()
  FILENAME1=''
  IF ~FILEDIALOG('...Norâdiet apmaiòas failu !!!',FILENAME1,'DBASE3|*.dbf',0)
      do ProcedureReturn
  .
  SETPATH(TTAKA")
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  ACCEPT
     QUICKWINDOW{PROP:TEXT}='Cenu importa fails '&CLIP(RECORDS(KOIVUNEN))&' raksti '&CLIP(FILENAME1)
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
    OF ?ButtonImportçt
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          SET(koivunen)
          RecordsToProcess = RECORDS(koivunen)
          RecordsPerCycle = 25
          RecordsProcessed = 0
          PercentProgress = 0
          OPEN(ProgressWindow)
          Progress:Thermometer = 0
          ?Progress:PctText{Prop:Text} = '0%'
          ProgressWindow{Prop:Text} = 'Cenu imports'
          ?Progress:UserString{Prop:Text}=''
          DISPLAY()
          ACCEPT
            CASE EVENT()
            OF Event:Timer
              LOOP RecordsPerCycle TIMES
                 NEXT(koivunen)
                 IF ERROR()
                    POST(Event:CloseWindow)
                    break
                 .
                 IF KOI:PIEG_KODS
                    CLEAR(cen:RECORD)
                    CEN:kataloga_nr=KOI:PIEG_KODS
                    CEN:NOS_U=KOI:PIEG
                    CEN:DATUMS=KOI:DATUMS
                    GET(CENUVEST,CEN:KAT_KEY)
                    IF ERROR()
                       ACTION#=1
                    ELSE
                       ACTION#=2
                    .
                    CEN:SKAITS=KOI:MIN_IEP
                    CEN:CENA=KOI:CENA
                    CEN:VALUTA=KOI:VALUTA
                    CEN:CENA1=KOI:VCENA
                    CEN:CENA2=KOI:MCENA
                    CEN:DATUMS=KOI:DATUMS
                    CEN:KEKSIS=KOI:KEKSIS
                    EXECUTE ACTION#
                       ADD(CENUVEST)
                       PUT(CENUVEST)
                    .
                 .
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
              END
            END
            CASE FIELD()
            OF ?Progress:Cancel
              CASE Event()
              OF Event:Accepted
                LocalResponse = RequestCancelled
                POST(Event:CloseWindow)
              END
            END
          END
          close(ProgressWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF KOIVUNEN::Used = 0
    CheckOpen(KOIVUNEN,1)
  END
  KOIVUNEN::Used += 1
  BIND(KOI:RECORD)
  BIND('KOI:MIN_IEP',KOI:MIN_IEP)
  BIND('KOI:CENA',KOI:CENA)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseKOIVUNEN','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
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
    KOIVUNEN::Used -= 1
    IF KOIVUNEN::Used = 0 THEN CLOSE(KOIVUNEN).
  END
  IF WindowOpened
    INISaveWindow('BrowseKOIVUNEN','winlats.INI')
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
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  KOI:PIEG = BRW1::KOI:PIEG
  KOI:PIEG_KODS = BRW1::KOI:PIEG_KODS
  KOI:MIN_IEP = BRW1::KOI:MIN_IEP
  KOI:CENA = BRW1::KOI:CENA
  KOI:VCENA = BRW1::KOI:VCENA
  KOI:MCENA = BRW1::KOI:MCENA
  KOI:VALUTA = BRW1::KOI:VALUTA
  KOI:DATUMS = BRW1::KOI:DATUMS
  KOI:KEKSIS = BRW1::KOI:KEKSIS
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
  BRW1::KOI:PIEG = KOI:PIEG
  BRW1::KOI:PIEG_KODS = KOI:PIEG_KODS
  BRW1::KOI:MIN_IEP = KOI:MIN_IEP
  BRW1::KOI:CENA = KOI:CENA
  BRW1::KOI:VCENA = KOI:VCENA
  BRW1::KOI:MCENA = KOI:MCENA
  BRW1::KOI:VALUTA = KOI:VALUTA
  BRW1::KOI:DATUMS = KOI:DATUMS
  BRW1::KOI:KEKSIS = KOI:KEKSIS
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
        StandardWarning(Warn:RecordFetchError,'KOIVUNEN')
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
      BRW1::HighlightedPosition = POSITION(KOIVUNEN)
      RESET(KOIVUNEN,BRW1::HighlightedPosition)
      BRW1::HighlightedPosition = ''
    ELSE
      IF POSITION(KOIVUNEN)
        RESET(KOIVUNEN,POSITION(KOIVUNEN))
      ELSE
        SET(KOIVUNEN)
      END
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
  ELSE
    CLEAR(KOI:Record)
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
    SET(KOIVUNEN)
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

SPZ_Pavad_OEM        PROCEDURE                    ! Declare Procedure
RejectRecord         LONG
LocalRequest         LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO

SUMMA_BS             STRING(15)
DAUDZUMS_S           STRING(15)
DAUDZUMS_S1          STRING(7)
DAUDZUMSK_S          STRING(15)
DAUDZUMSK_S1         STRING(7)
CENA_S               STRING(15)
CENA_S1              STRING(10)
LBKURSS              DECIMAL(14,6)
LSSUMMA              DECIMAL(12,2)
ATLAIDE              REAL
AN                   REAL
RPT_NPK              DECIMAL(3)
RPT_GADS             STRING(4)
DATUMS               STRING(2)
MENESIS              STRING(10)
gov_reg              STRING(40)
RPT_CLIENT           STRING(45)
RPT_BANKA            STRING(31)
RPT_REK              STRING(18)
KESKA                STRING(60)
REG_NR               STRING(11)
FIN_NR               STRING(13)
PAR_BAN_NR           STRING(21)
PAR_BAN_KODS         STRING(11)
JU_ADRESE            STRING(47)
ADRESE               STRING(52)
TEXTEKSTS            STRING(60)
NOS_P                STRING(45)
ADRESE1              STRING(40)
PAR_BANKA            STRING(31)
ATLAUJA              STRING(15)
CONS                 STRING(15)
CONS1                STRING(15)
NPK                  STRING(3)
NOMENK               STRING(21)
NOM_SER              STRING(21)
DAUDZUMS             DECIMAL(12,3)
DAUDZUMSK            DECIMAL(12,3)
CENA                 DECIMAL(16,5)
SUMMA_B              DECIMAL(16,4)
KOPA                 STRING(25)
IEPAK_DK             DECIMAL(3)
SUMK_B               DECIMAL(13,2)
SUMK_PVN             DECIMAL(13,2)
SUMK_APM             DECIMAL(13,2)
PAV_T_SUMMA          DECIMAL(12,2)
PAV_T_PVN            DECIMAL(12,2)
SVARS                DECIMAL(9,2)
SUMV                 STRING(112)
PLKST                TIME
ADRESEF              STRING(40)
PAV_AUTO             STRING(80)
DA                   STRING(8)
GGK_D_K              STRING(1),DIM(8)
GGK_BKK              STRING(5),DIM(8)
GGK_SUMMAV           DECIMAL(12,2),DIM(8)
PAV_PVN              string(2)
NOL_PVN_PROC         STRING(2)
RET                  BYTE
LINEH                STRING(116)
LINEV                STRING(1)
T                    STRING(CHR(9))
SYS_PARAKSTS         STRING(25)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END
!-----------------------------------------------------------------------------
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  RPT_gads=year(pav:datums)
  datums=day(pav:datums)
  menesis=MENVAR(pav:datums,2,2)
  plkst=clock()
  KESKA = RPT_GADS&'. gada '&datums&'. '&menesis
  GETMYBANK('')
  EXECUTE PAV:APM_V
    CONS1='Priekðapmaksa'
    CONS1='Pçcapmaksa'
    CONS1='Konsignâcija'
    CONS1='Apmaksa uzreiz'
  .
  EXECUTE PAV:APM_K
    CONS = 'Pârskaitîjums'
    CONS = 'Skaidrâ naudâ'
    CONS = 'Barters'
  .
  CASE sys:nom_cit
  OF 'A'
    nom_ser='Kataloga Nr'
    RET=5  !return from GETNOM_K
  OF 'K'
    nom_ser='Kods'
    RET=4
  OF 'C'  
    nom_ser=SYS:NOKL_TE
    RET=19
  ELSE
    nom_ser='Nomenklatûra'
    RET =1
  .
  PAV_AUTO=GETAUTO(PAV:VED_NR,2)
  PAR:NOS_P=GETPAR_K(PAV:PAR_NR,2,2)
  LOOP I#= 1 TO 116
!     LINEH=CLIP(LINEH)&CHR(151)
     LINEH[I#]='-'
  .
!  LINEV=CHR(124)
  LINEV='|'
  CASE PAV:D_K
  OF 'D'
    RPT_CLIENT=PAR:NOS_P
    ADRESE=PAR:ADRESE
    JU_ADRESE=PAR:ADRESE
    reg_nr=PAR:NMR_KODS
    BANKA=''
 !         RPT:BKODS=PAR:BAN_KODS
    REK  =PAR:BAN_NR
    ATLAUJA =''
    NOS_P=CLIENT
    gov_reg=gl:reg_nr
    ADRESE1=SYS:ADRESE
 !         RPT:NOLIKTAVA=''
  ELSE
    RPT_CLIENT=CLIENT
    JU_ADRESE=GL:ADRESE
    ADRESE=CLIP(SYS:ADRESE)&' '&clip(sys:tel)
    reg_nr=gl:reg_nr
    fin_nr=gl:VID_NR
    RPT_BANKA=BANKA
 !         RPT:BKODS=BKODS
    RPT_REK  =REK
    ATLAUJA =SYS:ATLAUJA
    NOS_P=GETPAR_K(PAV:PAR_NR,2,2)
    gov_reg=GETPAR_K(PAV:PAR_NR,0,21)
    ADRESE1=PAR:ADRESE
    ADRESEF = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
 !         RPT:NOLIKTAVA=SYS:AVOTS
    checkopen(bankas_k)
    clear(ban:record)
    IF F:PAK = '2'   !F:PAK NO SELPZ
      par_BAN_kods=par:ban_kods2
      par_ban_nr=par:ban_nr2
    ELSE
      par_BAN_kods=par:ban_kods
      par_ban_nr=par:ban_nr
    .
    par_banka=Getbankas_k(PAR_BAN_KODS,2,1)
  .
  SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND(PAV:RECORD)
  FilesOpened = True
  RecordsToProcess = 10
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Numurçtâ Pavadzîme OEM uz MATRIX'
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(nol:RECORD)
      NOL:U_NR=PAV:U_NR
      SET(nol:NR_KEY,NOL:NR_KEY)
      Process:View{Prop:Filter} = 'NOL:U_NR = PAV:U_NR'
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      END
      OPEN(Process:View)
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      END
      LOOP
        DO GetNextRecord
        DO ValidateRecord
        CASE RecordStatus
          OF Record:Ok
            BREAK
          OF Record:OutOfRange
            LocalResponse = RequestCancelled
            BREAK
        END
      END
      IF LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
        CYCLE
      END
!      ASCIIFILENAME='PAV'&CLIP(ACC_KODS_N)&'.R'&FORMAT(JOB_NR,@N02)
      ASCIIFILENAME=USERFOLDER&'\PAV.TXT'
      CHECKOPEN(OUTFILE,1)
      close(OUTFILE)
      OPEN(OUTFILE,18)
      IF ERROR()
         kluda(1,ASCIIFILENAME)
         DO ProcedureReturn
      ELSE
         EMPTY(OUTFILE)
      .
      LOOP I#=1 TO 6
         OUT:LINE=''
         ADD(OUTFILE)
      .
      OUT:LINE='                         '&CHR(27)&CHR(69)&KESKA&CHR(27)&CHR(70)&CHR(15)  !TREKNA_D,TREKNA_O,SAURA_D
      ADD(OUTFILE)
      OUT:LINE=''
      ADD(OUTFILE)
!      OUT:LINE='       01.Preèu nosutîtâjs   '&RPT_CLIENT&' {18}|-{39}|'
      OUT:LINE='       01.Preèu nosutîtâjs   '&RPT_CLIENT&' {8}|'&LINEH[1:40]&'|'
      ADD(OUTFILE)
      OUT:LINE='       02.Juridiskâ adrese   '&JU_ADRESE&' Kods |NMR:'&REG_NR&' PVN:'&FIN_NR&'       |'
      ADD(OUTFILE)
      OUT:LINE='          Izsniegðanas vieta '&ADRESE&' |'&LINEH[1:40]&'|'
      ADD(OUTFILE)
      OUT:LINE='       03.Norçíinu rekvizîti '&BANKA&' {16}Konts |'&REK&' Kods:'&BKODS&'  |'
      ADD(OUTFILE)
      OUT:LINE='      -{117}|'
      ADD(OUTFILE)
      OUT:LINE='       04.Preèu saòçmçjs     '&NOS_P&' {8}| {40}|'
      ADD(OUTFILE)
      OUT:LINE='       05.Adrese             '&ADRESE1&' {8}Kods |'&GOV_REG&'|'
      ADD(OUTFILE)
      OUT:LINE='          Izkrauðanas vieta  '&ADRESEF&' {13}|'&LINEH[1:40]&'|'
      ADD(OUTFILE)
      OUT:LINE='       06.Norçíinu rekvizîti '&PAR_BANKA&' {16}Konts |'&PAR_BAN_NR&' Kods:'&PAR_BAN_KODS&'  |'
      ADD(OUTFILE)
      OUT:LINE='      -{117}|'
      ADD(OUTFILE)
      DA=FORMAT(PAV:C_DATUMS,@D5B)
      OUT:LINE='       07.Samaksas veids     '&CONS&' '&DA&' {10}| 08.Speciâlâs atzîmes '&PAV:PAMAT
      ADD(OUTFILE)
      OUT:LINE='          Samaksas kârtîba   '&CONS1&' {19}| {22}'&ATLAUJA
      ADD(OUTFILE)
!      OUT:LINE=LINEH[1:80]&'|'
!      ADD(OUTFILE)
      LOOP I#=1 TO 3
         TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,I#)
         IF TEXTEKSTS
            OUT:LINE='       {65}|'&TEXTEKSTS
            ADD(OUTFILE)
         .
      .
      OUT:LINE='      |-{116}|'
      ADD(OUTFILE)
      OUT:LINE='      |Npk| {8}09.Preèu nosaukums {8}|'&NOM_SER&'|Iep|10.Mçrv|11.Dau.| 12.Cena  | {6}13.Summa {6}|PVN|'
      ADD(OUTFILE)
      OUT:LINE='      |-{116}|'
      ADD(OUTFILE)
      fillpvn(0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nomenk=GETNOM_K(NOL:NOMENKLAT,2,ret)
        SVARS+=GETNOM_K(NOL:NOMENKLAT,0,22)*nol:daudzums
        fillpvn(1)
        daudzums_s1 = nol:daudzums
        daudzums    = nol:daudzums
!        DAUDZUMS = ROUND(NOL:DAUDZUMS,.001)
!        DAUDZUMS_S=CUT0(DAUDZUMS,3,0)
!        DAUDZUMS_S1=DAUDZUMS_S[7:15]
        IF NOL:DAUDZUMS=0
          cena = calcsum(3,5)
        ELSE
          cena = ROUND(calcsum(3,1)/nol:daudzums,.00001)
        .
!        CENA_S = CUT0(CENA,5,2)
        IF ~NOL:ATLAIDE_PR AND INRANGE(GETNOM_K(NOL:NOMENKLAT,0,7)-CENA,-0.01,0.01)
           CENA=GETNOM_K(NOL:NOMENKLAT,0,7)
        .
        CENA_S1 = CENA
        SUMMA_B = calcsum(3,4)
        SUMMA_BS = CUT0(SUMMA_B,4,2)
        IF SUMMA_BS[15]='0'
           SUMMA_BS[15]=CHR(32)
           IF SUMMA_BS[14]='0'
              SUMMA_BS[14]=CHR(32)
           END
        END
        iepak_DK  += nol:iepak_d
        DAUDZUMSK += DAUDZUMS
        NPK+=1
        IF NPK<99
          RPT_NPK=FORMAT(NPK,@N2)&'.'
        ELSE
          RPT_NPK=FORMAT(NPK,@N3)
        .
        IF BAND(NOL:BAITS,00000010b) !NEAPLIEKAMS  *
           nol_pvn_proc='-'                        !*
        ELSE                                       !*
           nol_pvn_proc=NOL:PVN_PROC               !*
        .                                          !*
        OUT:LINE='      |'&NPK& '|' &NOM:NOS_P[1:34]& '|' &NOMENK& '|' &right(format(NOL:IEPAK_D,@N3B))& '|' &NOM:MERVIEN& '|' &right(DAUDZUMS_S1)& '|' &right(CENA_S1)& '| ' &SUMMA_BS&' '&NOL:VAL& '|' &format(NOL_PVN_PROC,@S2)&'%|'
        ADD(OUTFILE)
        LOOP
          DO GetNextRecord
          DO ValidateRecord              
          CASE RecordStatus
            OF Record:OutOfRange
              LocalResponse = RequestCancelled
              BREAK
            OF Record:OK
              BREAK
          END
        END
        IF LocalResponse = RequestCancelled
          LocalResponse = RequestCompleted
          BREAK
        END
        LocalResponse = RequestCancelled
      END
      IF LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
      END
    END
    CASE FIELD()
    OF ?Progress:Cancel
      CASE Event()
      OF Event:Accepted
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  END
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************************* KOPÂ & T.S.********
    DAUDZUMSK_S=CUT0(DAUDZUMSK,3,0)
    SUMK_B=ROUND(GETPVN(3),.01)
    kopa='Kopâ :'
    daudzumsk_s1 = daudzumsk
    OUT:LINE='      |-{116}|'
    ADD(OUTFILE)
    OUT:LINE='      |   | '&KOPA&' {8}| {21}|'&right(format(IEPAK_DK,@N3B))&'|'&' {7}|'&right(DAUDZUMSK_S1)&'| {10}|'&format(SUMK_B,@N14.2)&'   '&PAV:val&'|   |'
    ADD(OUTFILE)
    IEPAK_DK=0
    DAUDZUMSK_S=''
    IF GETPVN(14)
       SUMK_B=ROUND(GETPVN(14),.01)
       kopa='t.s. 18% PVN grupâ:'
       OUT:LINE='      |-{116}|'
       ADD(OUTFILE)
       OUT:LINE='      |   | '&KOPA&' {8}| {21}|   |'&' {7}|       | {10}|'&format(SUMK_B,@N14.2)&'   '&PAV:val&'|   |'
       ADD(OUTFILE)
    .
    IF GETPVN(16)
       SUMK_B=ROUND(GETPVN(16),.01)
       kopa='t.s.  9% PVN grupâ:'
       OUT:LINE='      |-{116}|'
       ADD(OUTFILE)
       OUT:LINE='      |   | '&KOPA&' {8}| {21}|   |'&' {7}|       | {10}|'&format(SUMK_B,@N14.2)&'   '&PAV:val&'|   |'
       ADD(OUTFILE)
    .
    IF GETPVN(19)                     !16/03/04
       SUMK_B=ROUND(GETPVN(19),.01)
       kopa='t.s.  5% PVN grupâ:'
       OUT:LINE='      |-{116}|'
       ADD(OUTFILE)
       OUT:LINE='      |   | '&KOPA&' {8}| {21}|   |'&' {7}|       | {10}|'&format(SUMK_B,@N14.2)&'   '&PAV:val&'|   |'
       ADD(OUTFILE)
    .
    IF GETPVN(12)
       SUMK_B=ROUND(GETPVN(12),.01)
       kopa='t.s.  0% PVN grupâ:'
       OUT:LINE='      |-{116}|'
       ADD(OUTFILE)
       OUT:LINE='      |   | '&KOPA&' {8}| {21}|   |'&' {7}|       | {10}|'&format(SUMK_B,@N14.2)&'   '&PAV:val&'|   |'
       ADD(OUTFILE)
    .
    IF GETPVN(17)                            !*
       SUMK_B=ROUND(GETPVN(17),.01)          !*
       kopa='t.s.   Neapliekami:'            !*
       OUT:LINE='      |-{116}|'
       ADD(OUTFILE)
       OUT:LINE='      |   | '&KOPA&' {8}| {21}|   |'&' {7}|       | {10}|'&format(SUMK_B,@N14.2)&'   '&PAV:val&'|   |'
       ADD(OUTFILE)
    .                                        !*
    IF GETPVN(20)  ! IR VAIRÂK PAR VIENU PREÈU TIPU
      LOOP I#=4 TO 9
        SUMK_B=ROUND(GETPVN(I#),.01)
        IF SUMK_B <> 0
          EXECUTE I#-3
            kopa='t.s. prece'
            kopa='t.s. tara '
            kopa='t.s. pakalpojumi'
            kopa='t.s. kokmateriâli'
            kopa='t.s. raþojumi'
            kopa='t.s. citi'
          .
          OUT:LINE='      |-{116}|'
          ADD(OUTFILE)
          OUT:LINE='      |   | '&KOPA&' {8}| {21}|   |'&' {7}|       | {10}|'&format(SUMK_B,@N-14.2)&'   '&PAV:val&'|   |'
!          OUT:LINE='      |   | '&KOPA&' {8}| {21}|'&right(format(IEPAK_DK,@s3))&'|'&' {7}|'&right(DAUDZUMSK_S1)&'| {10}|'&right(format(SUMK_B,@s12))&'0   '&PAV:val&'|   |'
          ADD(OUTFILE)
        .
      .
    .
!************************* ATLAIDE ***********
    IF PAV:SUMMA_A <= 0
       OUT:LINE='      |-{116}|'
       ADD(OUTFILE)
    ELSE
       OUT:LINE='      |-{116}|'
       ADD(OUTFILE)
       OUT:LINE='      '
       ADD(OUTFILE)
       OUT:LINE='       Visas cenas uzrâdîtas, òemot vçrâ pieðíirto atlaidi par kopçjo summu '&PAV:SUMMA_A&' '&PAV:VAL
       ADD(OUTFILE)
    .
!************************* SVARS ***********
    IF SVARS AND BAND(SYS:BAITS1,00010000B)
       OUT:LINE='       Preèu, taras svars '&SVARS&' kg.'
       ADD(OUTFILE)
    .
!************************* TRANSPORTS ***********
    IF pav:t_summa > 0
       PAV_T_PVN=ROUND(pav:t_summa*(1-1/(1+PAV:T_PVN/100)),.01)               !23/11/05
       PAV_T_SUMMA=PAV:T_SUMMA-PAV_T_PVN                                      !10/03/03
       OUT:LINE='       Transporta pakalpojumi               {50}'&FORMAT(PAV_T_SUMMA,@N_13.2)&' '&PAV:VAL
       ADD(OUTFILE)
    .
!************************* PVN ***********
    IF GETPVN(11)+PAV_T_PVN
       SUMK_PVN = ROUND(getpvn(11)+PAV_T_PVN,.01) !18%PVN + TRANSPORTA PVN(REQEST 18%...)
       OUT:LINE='       17.Pievienotâs vçrtîbas nodoklis 18% {50}'&FORMAT(SUMK_PVN,@N_13.2)&' '&PAV:VAL
       ADD(OUTFILE)
    .
    IF GETPVN(15)
       SUMK_PVN = ROUND(getpvn(15),.01)
       OUT:LINE='       17.Pievienotâs vçrtîbas nodoklis  9% {50}'&FORMAT(SUMK_PVN,@N_13.2)&' '&PAV:VAL
       ADD(OUTFILE)
    .
    IF GETPVN(12) ! IR SUMMA AR 0% PVN
       SUMK_PVN = 0
       OUT:LINE='       17.Pievienotâs vçrtîbas nodoklis  0% {50}'&FORMAT(SUMK_PVN,@N_13.2)&' '&PAV:VAL
       ADD(OUTFILE)
    .
    IF GETPVN(18)                          !16/03/04
       SUMK_PVN = ROUND(getpvn(18),.01)
       OUT:LINE='       17.Pievienotâs vçrtîbas nodoklis  5% {50}'&FORMAT(SUMK_PVN,@N_13.2)&' '&PAV:VAL
       ADD(OUTFILE)
    .
    IF GETPVN(17) ! IR SUMMA NEAPLIEKAMA AR PVN     !*
       SUMK_PVN = 0                                 !*
       OUT:LINE='       17.Pievienotâs vçrtîbas nodoklis  -% {50}'&FORMAT(SUMK_PVN,@N_13.2)&' '&PAV:VAL
       ADD(OUTFILE)
    .                                               !*
!************************* SUMMA VÂRDIEM ***********
!    IF ~INRANGE(PAV:SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)
    IF ~INRANGE(PAV:SUMMA-PAV:T_SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)   !10/03/03
      STOP('Nesakrît summas')
    .
    SUMK_B=ROUND(GETPVN(3),.01)              !JÂPÂRRÇÍINA
    SUMK_PVN=ROUND(GETPVN(1),.01)+PAV_T_PVN  !JÂPÂRRÇÍINA
    SUMK_APM = SUMK_B + SUMK_PVN + PAV_T_SUMMA
    SUMV = SUMVAR(SUMK_APM,PAV:VAL,0)
            OUT:LINE='       18.Pavisam apmaksai(ar cipariem) {54}'&FORMAT(SUMK_APM,@N_13.2)&' '&PAV:VAL
            ADD(OUTFILE)
            OUT:LINE='       (ar vârdiem) '&SUMv
            ADD(OUTFILE)
    IF PAV_AUTO OR PAV:PIELIK
            OUT:LINE='       a/m, vadîtâjs '&PAV_AUTO&' Pielikumâ '&PAV:PIELIK
            ADD(OUTFILE)
    END
    IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')     ! VALÛTAS P/Z SPECIÂLA RINDA
       LBKURSS=BANKURS(PAV:VAL,PAV:DATUMS,1)
       LSSUMMA = SUMK_APM*LBKURSS
       OUT:LINE='       Pçc Latvijas Bankas kursa '&LBKURSS&' Ls/'&PAV:VAL&' tas sastâda Ls '&LSSUMMA
       ADD(OUTFILE)
    .
!***************************PARAKSTI UN KONTÇJUMS********************
    IF F:KONTI = 'D'
        BUILDGGKTABLE(1)
        CLEAR(GGK_SUMMAV)
        CLEAR(GGK_D_K)
        CLEAR(GGK_BKK)
        LOOP J#=1 TO RECORDS(ggK_TABLE)
           IF J# <= 8
              GET(GGK_TABLE,J#)
              GGT:SUMMA=ROUND(GGT:SUMMA,.01)
              GGT:SUMMAV=ROUND(GGT:SUMMAV,.01)
              gGK_SUMMAV[J#] = GGT:SUMMAV
              gGK_BKK[J#]    = GGT:BKK
              gGK_D_K[J#]    = GGT:D_K
           .
        .
!        OUT:LINE= ''
!        ADD(OUTFILE)
        OUT:LINE='      -{117}'
        ADD(OUTFILE)
!        OUT:LINE='       {55}|'
!        ADD(OUTFILE)
        OUT:LINE='       19.Izsniedza: {41}| 20.Pieòçma: {25}'&GGK_D_K[1]&' '&GGK_BKK[1]&' '&FORMAT(GGK_SUMMAV[1],@N_13.2B)
        ADD(OUTFILE)
        OUT:LINE='       Vârds, uzvârds: '&SYS_PARAKSTS&' {13}| Vârds, uzvârds_{20}  '&GGK_D_K[2]&' '&GGK_BKK[2]&' '&FORMAT(GGK_SUMMAV[2],@N_13.2B)
        ADD(OUTFILE)
        DA=FORMAT(PLKST,@T4)
!        OUT:LINE='       {55}| {37}'&GGK_D_K[3]&' '&GGK_BKK[3]&' '&FORMAT(GGK_SUMMAV[3],@N_13.2B)
!        ADD(OUTFILE)
        OUT:LINE='       Preèu piegâdes vai pakalpojumu sniegðanas datums:'&' {5}|'&' {37}'&GGK_D_K[3]&' '&GGK_BKK[3]&' '&FORMAT(GGK_SUMMAV[3],@N_13.2B)
        ADD(OUTFILE)
        OUT:LINE='       '&RPT_GADS&'.gada "'&DATUMS&'" '&MENESIS&' '&DA&' {18}| ____.gada "__"__________ {12}'&GGK_D_K[4]&' '&GGK_BKK[4]&' '&FORMAT(GGK_SUMMAV[4],@N_13.2B)
        ADD(OUTFILE)
        OUT:LINE='       {55}| {37}'&GGK_D_K[5]&' '&GGK_BKK[5]&' '&FORMAT(GGK_SUMMAV[5],@N_13.2B)
        ADD(OUTFILE)
        OUT:LINE='       {55}| {37}'&GGK_D_K[6]&' '&GGK_BKK[6]&' '&FORMAT(GGK_SUMMAV[6],@N_13.2B)
        ADD(OUTFILE)
        OUT:LINE='       Paraksts_{30} {16}| Paraksts_{30}'
        ADD(OUTFILE)
        OUT:LINE='       {55}|'
        ADD(OUTFILE)
!        OUT:LINE='       {55}|'
!        ADD(OUTFILE)
        OUT:LINE='       {13}Z.V. {38}| {13}Z.V.'&CHR(18)&CHR(12) !SAURA_O,FF
        ADD(OUTFILE)
    ELSE
        OUT:LINE='      '
        ADD(OUTFILE)
        OUT:LINE='      -{117}'
        ADD(OUTFILE)
        OUT:LINE='       {55}|'
        ADD(OUTFILE)
        OUT:LINE='       19.Izsniedza: {41}| 20.Pieòçma:'
        ADD(OUTFILE)
        OUT:LINE='       Vârds, uzvârds: '&SYS_PARAKSTS&' {22}| Vârds, uzvârds_{20}  '
        ADD(OUTFILE)
!        OUT:LINE='       {55}| {37}'
!        ADD(OUTFILE)
        OUT:LINE='       '&RPT_GADS&'.gada "'&DATUMS&'" '&MENESIS&' '&DA&' {18}| ____.gada "__"__________ {12}'
        ADD(OUTFILE)
        OUT:LINE='       {55}| {37}'
        ADD(OUTFILE)
        OUT:LINE='       {55}| {37}'
        ADD(OUTFILE)
        OUT:LINE='       Paraksts_{20} {26}| Paraksts_{20}'
        ADD(OUTFILE)
        OUT:LINE='       {55}|'
        ADD(OUTFILE)
        OUT:LINE='       {55}|'
        ADD(OUTFILE)
        OUT:LINE='       {13}Z.V. {38}| {13}Z.V.'&CHR(18)&CHR(12) !SAURA_O,FF
        ADD(OUTFILE)
    END
    CLOSE(OUTFILE)
!    RUN('WORDPAD '&ANSIFILENAME)
!    IF RUNCODE()=-4
!       KLUDA(88,'prog-a Wordpad.exe')
!    .
     VIEWASCIIFILE
  END
  DO ProcedureReturn

!-----------------------------------------------------------------------------
ProcedureReturn ROUTINE
!:
!: This routine provides a common procedure exit point for all template
!: generated procedures.
!:
!: First, all of the files opened by this procedure are closed.
!:
!: Next, GlobalResponse is assigned a value to signal the calling procedure
!: what happened in this procedure.
!:
!: Next, we replace the BINDings that were in place when the procedure initialized
!: (and saved with PUSHBIND) using POPBIND.
!:
!: Finally, we return to the calling procedure.
!:
  IF FilesOpened
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN

!-----------------------------------------------------------------------------
ValidateRecord       ROUTINE
!:
!: This routine is used to provide for complex record filtering and range limiting. This
!: routine is only generated if you've included your own code in the EMBED points provided in
!: this routine.
!:
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!:
!: This routine is used to retrieve the next record from the VIEW.
!:
!: After the record has been retrieved, the PROGRESS control on the
!: Progress window is updated.
!:
  NEXT(Process:View)
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLIK')
    END
    LocalResponse = RequestCancelled
    EXIT
  ELSE
    LocalResponse = RequestCompleted
  END
  RecordsProcessed += 1
  RecordsThisCycle += 1
  IF PercentProgress < 100
    PercentProgress = (RecordsProcessed / RecordsToProcess)*100
    IF PercentProgress > 100
      PercentProgress = 100
    END
    IF PercentProgress <> Progress:Thermometer THEN
      Progress:Thermometer = PercentProgress
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
