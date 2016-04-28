                     MEMBER('winlats.clw')        ! This is a MEMBER module
BrowseKomplekt PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
cena                 DECIMAL(7,2)
Nosaukums            STRING(20)
SummaKopa            REAL
WRITE_CENA           BYTE
NOKL_CW              BYTE
NOKL_CR              BYTE
SAV_NOKL_CP          BYTE
SAVEPOSITION     STRING(250)
SAVERECORD       LIKE(NOM:RECORD)
PROJEKTS         LIKE(NOM:MUITA)
ATLAIDE          LIKE(NOM:AKCIZE)

BRW1::View:Browse    VIEW(KOMPLEKT)
                       PROJECT(KOM:NOM_SOURCE)
                       PROJECT(KOM:DAUDZUMS)
                       PROJECT(KOM:NOMENKLAT)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::KOM:NOM_SOURCE   LIKE(KOM:NOM_SOURCE)       ! Queue Display field
BRW1::Nosaukums        LIKE(Nosaukums)            ! Queue Display field
BRW1::KOM:DAUDZUMS     LIKE(KOM:DAUDZUMS)         ! Queue Display field
BRW1::cena             LIKE(cena)                 ! Queue Display field
BRW1::KOM:NOMENKLAT    LIKE(KOM:NOMENKLAT)        ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(KOM:NOM_SOURCE),DIM(100)
BRW1::Sort1:LowValue LIKE(KOM:NOM_SOURCE)         ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(KOM:NOM_SOURCE)        ! Queue position of scroll thumb
BRW1::Sort1:Reset:NOMENKLAT LIKE(NOMENKLAT)
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
BRW1::bilance:Cnt:Value LONG                      ! Queue position of scroll thumb
BRW1::bilance:Cnt:Temp LONG                       ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Browse the KOMPLEKT File'),AT(,,288,208),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseKomplekt'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,18,270,126),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('80L(2)|M~Nomenklatûra~@s21@109L(2)|M~Nosaukums~@s40@37R(1)|M~Daudzums~C(0)@n-15.' &|
   '3@40R(1)|M~Cena~C(0)@n-10.2@'),FROM(Queue:Browse:1)
                       BUTTON('&Ievadît'),AT(88,187,45,14),USE(?Insert:3)
                       BUTTON('&Mainît'),AT(138,187,45,14),USE(?Change:3),DEFAULT
                       BUTTON('&Dzçst'),AT(186,187,45,14),USE(?Delete:3)
                       SHEET,AT(4,4,280,179),USE(?CurrentTab)
                         TAB('Sastâvdaïas'),USE(?Tab:2)
                           STRING('Rezervçjamais apjoms :'),AT(67,4),USE(?String1)
                           ENTRY(@n-12.3),AT(146,3,39,12),USE(PROJEKTS)
                           STRING(@s7),AT(187,4),USE(NOM:MERVIEN)
                           STRING('Rçíinât pçc'),AT(119,147),USE(?String9:2)
                           ENTRY(@N1),AT(161,146,13,12),USE(NOKL_CR)
                           STRING('cenas'),AT(176,147),USE(?String10:2)
                           STRING('Summa :'),AT(202,147),USE(?String3:2)
                           STRING(@n-10.2),AT(233,147),USE(summa),RIGHT(1)
                           STRING(@n_5),AT(11,147),USE(bilance)
                           STRING('sastâvdaïas'),AT(36,147),USE(?String9)
                           PROMPT('A&tlaide:'),AT(205,159),USE(?NOM:AKCIZE:Prompt)
                           ENTRY(@n-12.3),AT(234,158,36,12),USE(Atlaide)
                           STRING('%'),AT(273,159),USE(?String5)
                           IMAGE('CHECK3.ICO'),AT(167,162,16,18),USE(?ImageWC),HIDE
                           BUTTON('Pârrakstît uz Nom_K kâ  '),AT(34,165,94,14),USE(?ButtonWC)
                           ENTRY(@n1),AT(131,166,13,12),USE(NOKL_CW)
                           STRING('cenu'),AT(147,168),USE(?String10)
                           STRING('Summa kopâ:'),AT(186,171),USE(?String3)
                           STRING(@n-10.2),AT(233,171),USE(SummaKopa),RIGHT(1)
                         END
                       END
                       BUTTON('&OK'),AT(239,187,45,14),USE(?Close)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SAVEPOSITION=POSITION(NOM_K)
  SAVERECORD=NOM:RECORD
  F:VALODA='X'
  PROJEKTS=NOM:MUITA
  MinMaxsumma=PROJEKTS
  ATLAIDE=NOM:AKCIZE
  NOMENKLAT=NOM:NOMENKLAT
  CHILDCHANGED=FALSE
  NOKL_CW=6
  NOKL_CR=6
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  WRITE_CENA=FALSE
  ACCEPT
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
       QUICKWINDOW{PROP:TEXT}='Komplektâcija. '&CLIP(nom:nomenklat)&' '&CLIP(NOM:NOS_P)
      !?BUTTONWC{PROP:TEXT}='Pârrakstît uz Nom_K kâ '&clip(nokl_cp)&' cenu'
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
    OF ?PROJEKTS
      CASE EVENT()
      OF EVENT:Accepted
        IF ~(Minmaxsumma=PROJEKTS)
           CLEAR(KOM:RECORD)
           KOM:NOMENKLAT=NOMENKLAT
           SET(KOM:NOM_KEY,KOM:NOM_KEY)
           LOOP
              NEXT(KOMPLEKT)
              IF ERROR() OR ~(KOM:NOMENKLAT=NOMENKLAT) THEN BREAK.
              !MAINÎÐANA
              AtlikumiN('P',KOM:NOM_SOURCE,KOM:DAUDZUMS*PROJEKTS,'P',KOM:NOM_SOURCE,KOM:DAUDZUMS*MINMAXSUMMA)
           .
           MINMAXSUMMA=PROJEKTS
           CHILDCHANGED=TRUE
        .
      END
    OF ?NOKL_CR
      CASE EVENT()
      OF EVENT:Accepted
           BRW1::LocateMode = LocateOnEdit
           DO BRW1::LocateRecord
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
      END
    OF ?Atlaide
      CASE EVENT()
      OF EVENT:Accepted
        SUMMAKOPA=SUMMA*(1-ATLAIDE/100)
        DISPLAY
      END
    OF ?ButtonWC
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF WRITE_CENA
           WRITE_CENA=0
           HIDE(?IMAGEWC)
        ELSE
           WRITE_CENA=1
           UNHIDE(?IMAGEWC)
        .
        
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
  IF KOMPLEKT::Used = 0
    CheckOpen(KOMPLEKT,1)
  END
  KOMPLEKT::Used += 1
  BIND(KOM:RECORD)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseKomplekt','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('NOMENKLAT',NOMENKLAT)
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
    RESET(NOM_K,SAVEPOSITION)
    NEXT(NOM_K)
    NOM:RECORD=SAVERECORD
    NOM:MUITA=PROJEKTS
    NOM:AKCIZE=ATLAIDE
    F:VALODA=''
    IF WRITE_CENA AND INRANGE(NOKL_CW,1,6)
       EXECUTE NOKL_CW
          NOM:REALIZ[1]=SUMMAKOPA
          NOM:REALIZ[2]=SUMMAKOPA
          NOM:REALIZ[3]=SUMMAKOPA
          NOM:REALIZ[4]=SUMMAKOPA
          NOM:REALIZ[5]=SUMMAKOPA
          NOM:PIC=SUMMAKOPA
      .
    .
    
    
    KOMPLEKT::Used -= 1
    IF KOMPLEKT::Used = 0 THEN CLOSE(KOMPLEKT).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
  END
  IF WindowOpened
    INISaveWindow('BrowseKomplekt','winlats.INI')
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
      IF BRW1::Sort1:Reset:NOMENKLAT <> NOMENKLAT
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:NOMENKLAT = NOMENKLAT
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
  SETCURSOR(Cursor:Wait)
  DO BRW1::Reset
  BRW1::bilance:Cnt:Value = 0
  SUMMA=0
  LOOP
    NEXT(BRW1::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'KOMPLEKT')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW1::FillQueue
    BRW1::bilance:Cnt:Value += 1
    SUMMA+=CENA*KOM:DAUDZUMS
  END
  SUMMAKOPA=ROUND(SUMMA*(1-ATLAIDE/100),.01)
  DISPLAY
  bilance = BRW1::bilance:Cnt:Value
  SETCURSOR()
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'KOMPLEKT')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = KOM:NOM_SOURCE
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'KOMPLEKT')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = KOM:NOM_SOURCE
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
  KOM:NOM_SOURCE = BRW1::KOM:NOM_SOURCE
  Nosaukums = BRW1::Nosaukums
  KOM:DAUDZUMS = BRW1::KOM:DAUDZUMS
  cena = BRW1::cena
  KOM:NOMENKLAT = BRW1::KOM:NOMENKLAT
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
  SAV_NOKL_CP=NOKL_CP
  NOKL_CP=NOKL_CR
  CENA=GETNOM_K(kom:nom_SOURCE,0,7)
  NOKL_CP=SAV_NOKL_CP
  NOSAUKUMS=GETNOM_K(kom:nom_SOURCE,0,2)
  BRW1::KOM:NOM_SOURCE = KOM:NOM_SOURCE
  BRW1::Nosaukums = Nosaukums
  BRW1::KOM:DAUDZUMS = KOM:DAUDZUMS
  BRW1::cena = cena
  BRW1::KOM:NOMENKLAT = KOM:NOMENKLAT
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
      POST(Event:Accepted,?Insert:3)
      POST(Event:Accepted,?Change:3)
      POST(Event:Accepted,?Delete:3)
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => UPPER(KOM:NOM_SOURCE)
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
      POST(Event:Accepted,?Change:3)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    OF DeleteKey
      POST(Event:Accepted,?Delete:3)
    OF CtrlEnter
      POST(Event:Accepted,?Change:3)
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
      KOM:NOM_SOURCE = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'KOMPLEKT')
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
      BRW1::HighlightedPosition = POSITION(KOM:NOM_KEY)
      RESET(KOM:NOM_KEY,BRW1::HighlightedPosition)
    ELSE
      KOM:NOMENKLAT = NOMENKLAT
      SET(KOM:NOM_KEY,KOM:NOM_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'UPPER(KOM:NOMENKLAT) = UPPER(NOMENKLAT)'
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
    CLEAR(KOM:Record)
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
    KOM:NOMENKLAT = NOMENKLAT
    SET(KOM:NOM_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'UPPER(KOM:NOMENKLAT) = UPPER(NOMENKLAT)'
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
    NOMENKLAT = BRW1::Sort1:Reset:NOMENKLAT
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.InsertButton=?Insert:3
  BrowseButtons.ChangeButton=?Change:3
  BrowseButtons.DeleteButton=?Delete:3
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
  GET(KOMPLEKT,0)
  CLEAR(KOM:Record,0)
  CASE BRW1::SortOrder
  OF 1
    KOM:NOMENKLAT = BRW1::Sort1:Reset:NOMENKLAT
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
!| (UpdateKOMPLEKT) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateKOMPLEKT
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
        GET(KOMPLEKT,0)
        CLEAR(KOM:Record,0)
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
  IF GLOBALRESPONSE=REQUESTCOMPLETED
     CHILDCHANGED=TRUE
  .

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


UpdateNOLIK PROCEDURE


CurrentTab           STRING(80)
NOKL_CENA            BYTE
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
statuss              STRING(1)
NOM_ATLIKUMS         DECIMAL(11,3)
NOM_PIEEJAMS         DECIMAL(11,3)
SUMMA_KOPA           DECIMAL(13,3)
SUMMA_A              DECIMAL(7,2)
summa_apm            DECIMAL(13,3)
PIEKTA               DECIMAL(12,3)
CETURTA              DECIMAL(12,3)
PIC                  DECIMAL(9,3)
MINRC_AR_PVN         DECIMAL(11,4)
VAL5                 STRING(3)
ARPVN                STRING(7),DIM(5)
DKSTRING             STRING(30)
SAV_NOMENKLAT        STRING(21)
SAV_D_K              STRING(1)
SAV_DAUDZUMS         DECIMAL(11,3)
NEW_DAUDZUMS         DECIMAL(11,3)
SAV_SUMMA            DECIMAL(11,2)
NOL_SUMMA            DECIMAL(11,2)
ProText              STRING(15)
NOL_Partneris        STRING(35)
NOL_PROJEKTS         STRING(35)
PUTNOM_K             BYTE
NOM_SKAITS_I         STRING(25)
Update::Reloop  BYTE
Update::Error   BYTE
History::NOL:Record LIKE(NOL:Record),STATIC
SAV::NOL:Record      LIKE(NOL:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the NOLIK File'),AT(,,426,260),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('UpdateNOLIK'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,7,186,244),USE(?Sheet2)
                         TAB('Dati no NOM_k'),USE(?Tab2)
                           BUTTON('&Mainît Nomenklatûru'),AT(9,26,80,14),USE(?ButtonNomenklat),FONT(,9,,FONT:bold)
                           STRING(@s21),AT(90,29,98,11),USE(NOL:NOMENKLAT),FONT('Fixedsys',9,,FONT:regular)
                           STRING(@s45),AT(10,43,177,10),USE(NOM:NOS_P)
                           STRING(@s16),AT(10,53),USE(NOM:NOS_S)
                           PROMPT('Svîtru Kods:'),AT(20,63,45,10),USE(?Prompt17)
                           STRING(@n_13),AT(67,63),USE(NOM:KODS),LEFT
                           STRING('Statuss:'),AT(124,63),USE(?String32)
                           STRING(@s1),AT(156,63),USE(statuss)
                           STRING('Atlikums:'),AT(40,74),USE(?String36)
                           STRING(@n-_12.3),AT(76,74,52,10),USE(NOM_ATLIKUMS),RIGHT
                           STRING(@s7),AT(132,74),USE(NOM:MERVIEN)
                           STRING('Pieejams:'),AT(40,83),USE(?String36:2)
                           STRING(@n-_12.3),AT(76,83,52,10),USE(NOM_PIEEJAMS),RIGHT
                           PROMPT('Nok&lusçta cena:'),AT(24,96,55,10),USE(?Prompt16)
                           ENTRY(@n1),AT(80,96,14,10),USE(NOKL_CENA),CENTER
                           BUTTON('&Pârrçíinât Pavadzîmi --->'),AT(98,95,90,14),USE(?PaarrekPAV)
                           STRING(@s3),AT(129,113,17,10),USE(NOM:VAL[1]),RIGHT(1)
                           STRING('1'),AT(67,113,11,10),USE(?String52),RIGHT(1)
                           ENTRY(@n_12.4),AT(80,112,47,10),USE(NOM:REALIZ[1],,?NOM:REALIZ1),DISABLE,RIGHT
                           STRING(@s7),AT(148,114),USE(ARPVN[1])
                           BUTTON('Saglabât cenas'),AT(10,124,57,14),USE(?ButtonSC),DISABLE
                           BUTTON('Atvçrt cenas'),AT(11,109,56,14),USE(?ButtonAC),DISABLE
                           STRING('2'),AT(67,123,11,10),USE(?String52:2),RIGHT(1)
                           ENTRY(@n_12.4),AT(80,123,47,10),USE(NOM:REALIZ[2],,?NOM:REALIZ2),DISABLE,RIGHT
                           STRING(@s3),AT(129,124,17,10),USE(NOM:VAL[2]),RIGHT(1)
                           STRING(@s7),AT(148,124),USE(ARPVN[2])
                           STRING('3'),AT(67,134,11,10),USE(?String52:3),RIGHT(1)
                           ENTRY(@n_12.4),AT(80,134,47,10),USE(NOM:REALIZ[3],,?NOM:REALIZ3),DISABLE,RIGHT
                           STRING(@s3),AT(129,135,17,10),USE(NOM:VAL[3]),RIGHT(1)
                           STRING(@s7),AT(148,135),USE(ARPVN[3])
                           STRING('4'),AT(67,145,11,10),USE(?String52:4),RIGHT(1)
                           ENTRY(@n_12.4),AT(80,145,47,10),USE(NOM:REALIZ[4],,?NOM:REALIZ4),DISABLE,RIGHT
                           STRING(@s3),AT(129,146,17,10),USE(NOM:VAL[4]),RIGHT(1)
                           STRING(@s7),AT(148,146),USE(ARPVN[4])
                           STRING(@n-4),AT(41,156),USE(NOM:PROC5,,?NOM:PROC5:2),RIGHT(1)
                           STRING('%'),AT(60,156),USE(?String61)
                           STRING('5'),AT(67,156,11,10),USE(?String52:5),RIGHT(1)
                           STRING(@n_12.4),AT(79,156,49,10),USE(NOM:REALIZ[5],,?NOM:REALIZ5),RIGHT(1)
                           STRING(@s3),AT(129,156),USE(NOM:VAL[5]),RIGHT(1)
                           STRING(@s7),AT(148,156),USE(ARPVN[5])
                           STRING('PIC'),AT(12,166),USE(?String30)
                           STRING(@n_12.4),AT(73,166,54,10),USE(NOM:PIC),RIGHT
                           STRING(@s3),AT(128,167,17,10),USE(Val_uzsk),RIGHT
                           STRING('bez PVN'),AT(147,166),USE(?String22),LEFT(1)
                           STRING('Min. RC:'),AT(12,175),USE(?String30:2)
                           STRING(@n_12.4B),AT(73,175,54,10),USE(NOM:MINRC),RIGHT
                           STRING(@n_12.4B),AT(132,175,47,10),USE(MINRC_AR_PVN),LEFT
                           STRING(@D06.B),AT(28,166,46,10),USE(NOM:PIC_DATUMS),CENTER
                           BUTTON('Pârrçíinât Nomenklatûru pçc &FIFO --->'),AT(53,185,129,14),USE(?ButtonFIFO),HIDE
                           PROMPT('ES KN kods:'),AT(14,200,44,10),USE(?Prompt17:2)
                           STRING(@n_10),AT(57,200,47,10),USE(NOM:MUITAS_KODS),RIGHT(1)
                           PROMPT('Izc. v. kods:'),AT(14,209,44,10),USE(?PromptIVK)
                           STRING(@S2),AT(90,209,14,10),USE(NOM:IZC_V_KODS),RIGHT(1)
                           PROMPT('Svars:'),AT(14,218,44,10),USE(?Promptcena)
                           STRING(@n7.3),AT(68,219,36,10),USE(NOM:SVARSKG),RIGHT(1)
                           STRING(@D06.B),AT(141,240),USE(NOM:ACC_DATUMS),CENTER,FONT(,,COLOR:Gray,)
                         END
                       END
                       STRING(@s30),AT(295,7),USE(DKSTRING),CENTER,FONT(,,,FONT:bold)
                       SHEET,AT(190,7,231,228),USE(?CurrentTab)
                         TAB('P&/Z saturs'),USE(?Tab:1)
                           PROMPT('&Iepakojumu skaits:'),AT(197,39),USE(?NOL:IEPAK_D:Prompt)
                           ENTRY(@n_9.2),AT(260,39,37,10),USE(NOL:IEPAK_D),RIGHT(1)
                           STRING(@S25),AT(300,39),USE(NOM_SKAITS_I),LEFT,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           IMAGE('CANCEL4.ICO'),AT(313,48,17,20),USE(?ImageDaudzums),HIDE
                           PROMPT('&Daudzums:'),AT(197,53),USE(?NOL:DAUDZUMS:Prompt)
                           ENTRY(@n-_12.3),AT(260,53,51,10),USE(NOL:DAUDZUMS),RIGHT(1),REQ
                           PROMPT('&Summa:'),AT(197,74),USE(?NOL:SUMMAV:Prompt)
                           ENTRY(@n-_12.2),AT(262,74,49,10),USE(NOL:SUMMAV),RIGHT(1)
                           STRING(@s3),AT(314,75,17,10),USE(NOL:val,,?NOL:val:2)
                           STRING(@n-_12.2),AT(257,87,55,10),USE(NOL:SUMMA),RIGHT
                           STRING(@s3),AT(314,87),USE(Val_uzsk,,?Val_uzsk:2)
                           STRING('Summa kopâ:'),AT(197,101),USE(?String7:2)
                           STRING(@n-_13.2),AT(257,101),USE(SUMMA_KOPA),RIGHT
                           STRING('ES'),AT(314,101),USE(?StringES),HIDE
                           OPTION('Summa ir ....'),AT(333,62,86,35),USE(NOL:ARBYTE),BOXED
                             RADIO('ar'),AT(337,74,17,10),USE(?nol:arbyte:Radio1),VALUE('1')
                             RADIO('bez'),AT(337,86,23,10),USE(?nol:arbyte:Radio2),VALUE('0')
                           END
                           ENTRY(@n2),AT(356,73,19,10),USE(NOL:PVN_PROC),RIGHT(1)
                           BUTTON('%  PVN  '),AT(377,71,40,14),USE(?ButtonPVN)
                           PROMPT('A&tlaide:'),AT(197,112,26,10),USE(?NOL:ATLAIDE_PR:Prompt)
                           ENTRY(@n-5.1),AT(224,111,23,10),USE(NOL:ATLAIDE_PR),RIGHT(1)
                           STRING('% ='),AT(248,112,14,10),USE(?String6)
                           STRING(@n-10.2),AT(272,112),USE(SUMMA_A),RIGHT(1)
                           STRING('(no summas & PVN)'),AT(314,112,64,10),USE(?String39)
                           STRING('Summa apmaksai:'),AT(197,123),USE(?String7)
                           STRING(@n-_13.2),AT(258,123),USE(summa_apm),RIGHT
                           STRING(@s3),AT(315,123,17,10),USE(NOL:val,,?NOL:val:3)
                           GROUP('Dati nomenklatûru kodifikatoram'),AT(195,143,225,51),USE(?GroupFornom_K),BOXED,HIDE
                             BUTTON('...netiks pârrakstîts pçc OK'),AT(250,152,99,14),USE(?Button:ChangeNom_k)
                             IMAGE('CHECK3.ICO'),AT(401,165,16,20),USE(?Image5C),HIDE
                             PROMPT('5. &cena ar'),AT(201,171,39,10),USE(?Prompt:5C)
                             STRING('% uzcen. pçc tekoðâ D'),AT(254,171),USE(?String:UZCEN)
                             ENTRY(@n_10.3),AT(331,169,36,10),USE(PIEKTA)
                             STRING(@s3),AT(368,169),USE(VAL5)
                             BUTTON('L'),AT(385,168,15,14),USE(?Button5C)
                             ENTRY(@n-4.0),AT(237,170,17,10),USE(NOM:PROC5),DISABLE
                             STRING('Tekoðâ iepirkuma cena:'),AT(201,181),USE(?String:PIC)
                             STRING(@n_12.3),AT(279,181,50,10),USE(PIC),RIGHT(1)
                             STRING(@s3),AT(330,181,17,10),USE(Val_uzsk,,?Val_uzsk:3)
                             STRING('bez PVN'),AT(349,181),USE(?String:PICLs)
                           END
                         END
                         TAB('&5-Papildus dati'),USE(?Tab3)
                           STRING(@s35),AT(197,40),USE(NOL_Partneris)
                           STRING(@n_7B),AT(342,40),USE(NOL:PAR_NR)
                           BUTTON('Mainît nom. Projektu (Objektu)'),AT(199,52,170,14),USE(?ButtonMPROJEKTU)
                           STRING(@s35),AT(197,67),USE(NOL_PROJEKTS)
                           STRING(@n_7B),AT(342,67),USE(NOL:OBJ_NR)
                           BUTTON('Mainît nom. Partneri (tikai, ja P/Z par_Nr=0)'),AT(198,25,170,14),USE(?ButtonMPar_nr),DISABLE
                           BUTTON('&Samaksâts'),AT(198,215,49,14),USE(?ButtonKeksis)
                           BUTTON('Diena'),AT(291,214,41,14),USE(?ButtonDiena)
                           PROMPT('Izcelsmes v. kods:'),AT(334,217,65,10),USE(?NOL:IZC_V_KODS:Prompt)
                           ENTRY(@s2),AT(401,215),USE(NOL:IZC_V_KODS)
                           IMAGE('CHECK3.ICO'),AT(251,211,18,20),USE(?ImageSAMAKSATS)
                           IMAGE('CANCEL4.ICO'),AT(270,211,18,20),USE(?ImageNAVMAKSATS)
                           GROUP('Ârpuspavadzîmes izmaksas'),AT(198,82,210,87),USE(?GroupAPZIzmaksas),BOXED,HIDE
                             BUTTON('Lock (fiksçt konkrçtâs Nomenklat. izmaksas)'),AT(210,98,163,18),USE(?Lock1),HIDE
                             IMAGE('CHECK3.ICO'),AT(375,101,16,16),USE(?Image1),HIDE
                             PROMPT('&Muita:'),AT(206,122),USE(?NOL:MUITA:Prompt)
                             ENTRY(@n-_15.2),AT(274,122,67,10),USE(NOL:MUITA),RIGHT(1)
                             STRING(@s3),AT(346,122,17,10),USE(Val_uzsk,,?Val_uzsk:4)
                             PROMPT('A&kcîzes nodoklis:'),AT(206,135,66,10),USE(?NOL:AKCIZE:Prompt)
                             ENTRY(@n-_15.2),AT(274,135,67,10),USE(NOL:AKCIZE),RIGHT(1)
                             STRING(@s3),AT(346,135,17,10),USE(Val_uzsk,,?Val_uzsk:5)
                             PROMPT('&Citas:'),AT(206,149),USE(?NOL:CITAS:Prompt)
                             ENTRY(@n-_15.2),AT(274,149,67,10),USE(NOL:CITAS),RIGHT(1)
                             STRING(@s3),AT(346,149,17,10),USE(Val_uzsk,,?Val_uzsk:6)
                           END
                           GROUP('P/Z izmaksas'),AT(198,172,209,32),USE(?GroupPZIzmaksas),BOXED,HIDE
                             PROMPT('&Transports:'),AT(206,188),USE(?NOL:T_SUMMA:Prompt)
                             ENTRY(@n-_13.2),AT(274,188,67,10),USE(NOL:T_SUMMA),RIGHT(1)
                             STRING(@s3),AT(346,188,17,10),USE(NOL:val)
                           END
                         END
                       END
                       BUTTON('&OK'),AT(324,239,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(373,239,45,14),USE(?Cancel)
                     END
REALIZETS            DECIMAL(13,3)
ATLIKUMS             DECIMAL(13,3)
DAUDZUMS             DECIMAL(13,3)
NOL_DAUDZUMS         DECIMAL(13,3)
SAV_POSITION         STRING(260)
SAV_RECORD           LIKE(NOL:RECORD)
NOL_SUMMAV           LIKE(NOL:SUMMAV)
PROC5                LIKE(NOM:PROC5)
SAV_NOKL_CP          BYTE
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  ! PIRMS CLARIS ATRAUJ FAILUS
  ALIAS(PgDnKey,TabKey)
  ALIAS(PgUpKey,ShiftTab)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
   IF LOCALREQUEST=2
      NOL:NOMENKLAT=GETNOM_K(NOL:NOMENKLAT,2,1)
      IF BAND(NOM:NEATL,00000010b)
         KLUDA(0,'Akcijas prece...')
      .
      SAV_NOMENKLAT=NOL:NOMENKLAT
      SAV_DATUMS=NOL:DATUMS
      SAV_D_K=NOL:D_K
      SAV_DAUDZUMS=NOL:DAUDZUMS
      SAV_SUMMA=CALCSUM(16,2)
   .
   IF PAR:NOKL_CP AND INSTRING(PAV:D_K,'KPR')
      SAV_NOKL_CP=NOKL_CP
      NOKL_CP=PAR:NOKL_CP
   .
   DO NOMSHOW
   CASE NOL:D_K
   OF 'D'
     DKSTRING='D-Ienâkoðâ P/Z'
     UNHIDE(?GroupFornom_K)
     UNHIDE(?GROUPPZIzmaksas)
     UNHIDE(?GROUPAPZIzmaksas)
     UNHIDE(?Lock1)
     IF ~(PAV:PAR_NR=NOL:PAR_NR)
        NOL_PARTNERIS=GETPAR_K(NOL:PAR_NR,2,2)
     .
     IF ~(PAV:OBJ_NR=NOL:OBJ_NR)
        NOL_PROJEKTS=GETPROJEKTI(NOL:OBJ_NR,1)
     .
     IF GETPAR_K(PAV:PAR_NR,0,20)='C' ! ES
        UNHIDE(?STRINGES)
     .
     IF NOM:PIC_DATUMS<=PAV:DATUMS
        ENABLE(?NOM:PROC5)
     .
   OF '1'
     DKSTRING='1-Debeta projekts'
   OF '2'
     DKSTRING='2-Prece ceïâ'
   OF 'K'
     DKSTRING='K-Izejoðâ P/Z'
     IF PAV:PAR_NR=0
        ENABLE(?ButtonMPar_nr)
        IF NOL:PAR_NR THEN NOL_Partneris=GETPAR_K(NOL:PAR_NR,0,1).
     .
!     IF INRANGE(PAV:PAR_NR,26,50) AND (PAV:VAL='Ls' OR PAV:VAL='LVL') AND LOCALREQUEST=1 THEN UNHIDE(?BUTTONFIFO).
   OF 'P'
     DKSTRING='P-Kredîta projekts'
!     IF INRANGE(PAV:PAR_NR,26,50) AND (PAV:VAL='Ls' OR PAV:VAL='LVL') AND LOCALREQUEST=1 THEN UNHIDE(?BUTTONFIFO).
   .
   IF NOL:OBJ_NR THEN NOL_PROJEKTS=GETPROJEKTI(NOL:OBJ_NR,1).
   IF NOL:LOCK             !LOCK ârpuspavadzîmes izmaksas
     UNHIDE(?IMAGE1)
   .
   IF BAND(NOL:BAITS,00000001b)    !ir parâds
     HIDE(?IMAGESAMAKSATS)
     UNHIDE(?IMAGEnavMAKSATS)
   ELSE
     UNHIDE(?IMAGESAMAKSATS)
     HIDE(?IMAGEnavMAKSATS)
   .
   IF ATLAUTS[11]='1' !AIZLIEGTS APSKATÎT D P/Z UN JEBKURU PIEEJU IEP CENÂM
      HIDE(?NOM:PIC)
      HIDE(?NOM:REALIZ5)
      HIDE(?nom:proc5:2)
   .
   IF BAND(NOL:BAITS,00000010b)    !AR PVN NEAPLIEKAMS
      ?BUTTONPVN{PROP:TEXT}='PVN neapl.'
      DISABLE(?NOL:PVN_PROC)
   .
   IF BAND(NOL:BAITS,00000100b)    !0-DIENA 1-NAKTS
      ?BUTTONDIENA{PROP:TEXT}='Nakts'
   .
!   IF BAND(NOM:BAITS1,00000100b)  !~LOCK 5C '... UZ NOMSHOW
!      UNHIDE(?IMAGE5C)
!      PIEKTA=NOM:REALIZ[5]
!      CETURTA=NOM:REALIZ[4]
!   .
   IF ATLAUTS[6] < '2' !PILNA PIEEJA NOMENKLATÛRÂM VAI AIZLIEGTS TIKAI DZÇST
      ENABLE(?BUTTONAC)
      ENABLE(?BUTTONSC)
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
     IF NOL:D_K='D'
        IF NOL:DAUDZUMS>0 AND NOL:SUMMAV
           IF ~BAND(NOM:BAITS1,'00000100b') !~LOCK5
              IF NOM:PROC5=999 !ALGORITMS
                 PROC5=0
              ELSE
                 PROC5=NOM:PROC5
              .
              !IF NOM:VAL[5]='Ls' OR NOM:VAL[5]='LVL' OR ~(NOM:VAL[5]=NOL:VAL)  !jâsaglabâ Latos
              IF (GL:DB_GADS <= 2013 AND (NOM:VAL[5]='Ls' OR NOM:VAL[5]='LVL')) OR (GL:DB_GADS > 2013 AND NOM:VAL[5]=val_uzsk) OR ~(NOM:VAL[5]=NOL:VAL)  !jâsaglabâ Latos
                 PIEKTA=CALCSUM(15,3)
                 !VAL5='Ls'
                 VAL5=val_uzsk !Elya 15/12/2013
              ELSE
                 PIEKTA=CALCSUM(3,3)
                 VAL5=NOL:VAL
              .
              PIEKTA=PIEKTA/NOL:DAUDZUMS
              CETURTA=NOM:REALIZ[4]
              IF CL_NR=1316 AND NOL:PVN_PROC=5 !ELPA
                 IF PIEKTA<1
                    CETURTA=(PIEKTA*1.30)
                    PIEKTA=(PIEKTA*1.4+0.00)
                 ELSIF PIEKTA<2
                    CETURTA=(PIEKTA*1.25+0.05)
                    PIEKTA=(PIEKTA*1.35)
                 ELSIF PIEKTA<3
                    CETURTA=(PIEKTA*1.2+0.15)
                    PIEKTA=(PIEKTA*1.3)
                 ELSIF PIEKTA<5
                    CETURTA=(PIEKTA*1.17+0.30)
                    PIEKTA=(PIEKTA*1.25)
                 ELSIF PIEKTA<10
                    CETURTA=(PIEKTA*1.15+0.40)
                    PIEKTA=(PIEKTA*1.20)
                 ELSIF PIEKTA<15 AND NOL:NOMENKLAT[4]='K'
                    CETURTA=(PIEKTA*1.10+0.90)
                 ELSIF PIEKTA<20
                    CETURTA=(PIEKTA*1.07+1.35)
                    PIEKTA=(PIEKTA*1.15+0.60)
                 ELSE
                    CETURTA=(PIEKTA*1.05+1.75)
                    PIEKTA=(PIEKTA*1.10+1.50)
                 .
                 IF NOL:NOMENKLAT[4]='K'
                    PIEKTA=CETURTA
                    CETURTA=0
                 .
              ELSIF CL_NR=1316 AND NOL:PVN_PROC=18 !ELPA
                 PIEKTA=(PIEKTA*1.25)
              ELSIF NOM:PROC5=999 !ALGORITMS
                 IF PIEKTA<1
                    CETURTA=(PIEKTA*1.30)
!                    PIEKTA=(PIEKTA*1.4+0.01)
                    PIEKTA=(PIEKTA*1.4)
                 ELSIF PIEKTA<2
                    CETURTA=(PIEKTA*1.25+0.05)
!                    PIEKTA=(PIEKTA*1.35+0.06)
                    PIEKTA=(PIEKTA*1.35+0.05)
                 ELSIF PIEKTA<3
                    CETURTA=(PIEKTA*1.2+0.15)
!                    PIEKTA=(PIEKTA*1.3+0.16)
                    PIEKTA=(PIEKTA*1.3+0.15)
                 ELSIF PIEKTA<5
                    CETURTA=(PIEKTA*1.17+0.30)
!                    PIEKTA=(PIEKTA*1.25+0.31)
                    PIEKTA=(PIEKTA*1.25+0.30)
                 ELSIF PIEKTA<10
                    CETURTA=(PIEKTA*1.15+0.40)
!                    PIEKTA=(PIEKTA*1.20+0.56)
                    PIEKTA=(PIEKTA*1.20+0.55)
!                 ELSIF PIEKTA<15
!                    CETURTA=(PIEKTA*1.10+0.90)
!                    PIEKTA=(PIEKTA*1.15+1.06)
                 ELSIF PIEKTA<20
                    CETURTA=(PIEKTA*1.07+1.35)
!                    PIEKTA=(PIEKTA*1.15+1.06)
                    PIEKTA=(PIEKTA*1.15+1.05)
                 ELSE
                    CETURTA=(PIEKTA*1.05+1.75)
!                    PIEKTA=(PIEKTA*1.10+2.06)
                    PIEKTA=(PIEKTA*1.10+2.05)
                 .
              .
              IF BAND(NOM:ARPVNBYTE,'00010000b')  !Jâsaglabâ Ar PVN
                 PIEKTA=PIEKTA*(1+PROC5/100)*(1+NOM:PVN_PROC/100)
                 IF NOM:PROC5=999 !ALGORITMS
                    CETURTA=CETURTA*(1+NOM:PVN_PROC/100)*(1+PROC5/100)
                 .
              ELSE
                 PIEKTA=PIEKTA*(1+PROC5/100)
              .
           .
           PIC=round(CALCSUM(15,3)/NOL:DAUDZUMS,.001) ! Ls bez PVN -A
           DISPLAY
        .
     .
     nol:summa=nol:summav*bankurs(nol:VAL,nol:datums)
     SUMMA_KOPA=CALCSUM(12,2)
     SUMMA_A   =CALCSUM(8,2)   !ATLAIDE
     SUMMA_APM =CALCSUM(4,2)   !SUMMA APMAKSAI
    
     IF ATLAUTS[21]='1' AND NOL:D_K='K' AND ~INSTRING(NOM:TIPS,'TARV',1) AND ~(NOM:REALIZ[1]=0) !AIZLIEGTS MAINÎT SUMMU,ATLAIDI,NOKL_CENU
        DISABLE(?NOKL_CENA)
        DISABLE(?NOL:SUMMAV)
        DISABLE(?NOL:ARBYTE)
        DISABLE(?NOL:PVN_PROC)
        DISABLE(?NOL:ATLAIDE_PR)
     .  
    
    ! DISPLAY
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
      SELECT(?ButtonNomenklat)
         IF NOM:SKAITS_I
            SELECT(?NOL:IEPAK_D)
         ELSE
            SELECT(?NOL:DAUDZUMS)
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
        History::NOL:Record = NOL:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(NOLIK)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?ButtonNomenklat)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::NOL:Record <> NOL:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:NOLIK(1)
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
              SELECT(?ButtonNomenklat)
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
    OF ?Sheet2
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
    OF ?ButtonNomenklat
      CASE EVENT()
      OF EVENT:Accepted
        NOMENKLAT=NOL:NOMENKLAT  !LAI POZICIONÇ BROWSI
        ALIAS(PgDnKey,PgDnKey)
        ALIAS(PgUpKey,PgUpKey)
        
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNOM_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF ~(PAV:PAR_NR=PAR:U_NR)
           I#=GETPAR_K(PAV:PAR_NR,2,1)  !POZICIONÇJAM PAR_K, JA MAINOT NOMENKLATÛRU IR IZKUSTINÂTS
        .
        IF GLOBALRESPONSE=REQUESTCOMPLETED AND NOM:NOMENKLAT
           DO NOMTONOL
           DO NOMSHOW
           IF INSTRING(PAV:D_K,'KPR')
              NOL:ATLAIDE_PR=GETPAR_ATLAIDE(PAR:Atlaide,NOL:NOMENKLAT)
              IF (BAND(NOM:NEATL,00000001b) AND NOL:ATLAIDE_PR>0) OR| !NEDRÎKST DOT ATLAIDI
              BAND(NOM:NEATL,00000010b)                               !AKCIJAS PRECE
                 NOL:ATLAIDE_PR=0
              .
           .
           IF NOM:SKAITS_I
              SELECT(?NOL:IEPAK_D)
           ELSE
              SELECT(?NOL:DAUDZUMS)
           .
           DISPLAY
        .
        ALIAS(PgDnKey,TabKey)
        ALIAS(PgUpKey,ShiftTab)
      END
    OF ?NOKL_CENA
      CASE EVENT()
      OF EVENT:Accepted
           IF NOM:TIPS='A'
              NOKL_CA=NOKL_CENA
           ELSE
              NOKL_CP=NOKL_CENA     !VIÒA TIEK MAINÎTA, NEPIECIEÐAMS ATCERÇTIES ARÎ TURPMÂK
           .
      END
    OF ?PaarrekPAV
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO STARTSUMMA
        DISPLAY
      END
    OF ?ButtonSC
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF RIUPDATE:NOM_K()
           KLUDA(24,'NOM_K')
        .
      END
    OF ?ButtonAC
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        ENABLE(?NOM:REALIZ1)
        ENABLE(?NOM:REALIZ2)
        ENABLE(?NOM:REALIZ3)
        ENABLE(?NOM:REALIZ4)
        DISPLAY
      END
    OF ?ButtonFIFO
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           SAV_POSITION=POSITION(NOL:NR_KEY)
           SAV_RECORD=NOL:RECORD
!           NOL_SUMMAV=GETBIL_FIFO(NOL:NOMENKLAT,NOL:DATUMS,NOL:DAUDZUMS)
           RESET(NOL:NR_KEY,SAV_POSITION)
           NEXT(NOLIK)
           NOL:RECORD=SAV_RECORD
           NOL:SUMMAV=NOL_SUMMAV
           NOL:SUMMA=NOL:SUMMAV
           NOL:ARBYTE=0
           DISPLAY
      END
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
    OF ?NOL:IEPAK_D
      CASE EVENT()
      OF EVENT:Accepted
        IF NOL:IEPAK_D AND NOM:SKAITS_I AND ~NOL:DAUDZUMS
            NOL:DAUDZUMS=ROUND(NOM:SKAITS_I*NOL:IEPAK_D,.001) !NOL:DAUDZUMS(D11,3)
            DISPLAY
        END
        IF NOL:DAUDZUMS>NOM_ATLIKUMS AND PAV:D_K='K' AND ~INSTRING(NOM:TIPS,'TARV',1)
           unhide(?ImageDaudzums)
        ELSE
           hide(?ImageDaudzums)
        END
        IF ~NOL:SUMMA AND INSTRING(PAV:D_K,'KPR') AND OK#=FALSE
            DO STARTSUMMA
        END
      END
    OF ?NOL:DAUDZUMS
      CASE EVENT()
      OF EVENT:Accepted
        IF NOL:DAUDZUMS>NOM_ATLIKUMS AND PAV:D_K='K' AND ~INSTRING(NOM:TIPS,'TARV',1) AND LOCALREQUEST=1
           unhide(?ImageDaudzums)
           IF NOL:DAUDZUMS AND ATLAUTS[23]='1' !AIZLIEGTS TIRGOT AR MÎNUSATLIKUMIEM
              KLUDA(0,'Veidojas negatîvs atlikums')
              SELECT(?NOL:DAUDZUMS)
           .
        ELSE
           hide(?ImageDaudzums)
        END
        IF (~NOL:SUMMA AND INSTRING(PAV:D_K,'KPR') AND OK#=FALSE) OR| !LAI SELECTALL NENOMAITÂ 0-ES SUMMU
           (CL_NR=1304 AND INSTRING(PAV:D_K,'KPR') AND OK#=FALSE)     !EZERKAULIÒI MUÏÍI GRIB, LAI PÂRRÇÍINA
           IF INRANGE(NOL:PAR_NR,26,50) AND LOCALREQUEST=1  !RAÞOÐANA
!              SAV_POSITION=POSITION(NOL:NR_KEY)
!              SAV_RECORD=NOL:RECORD
!              SAV_DAUDZUMS=NOL:DAUDZUMS
!              NOL_SUMMAV=GETBIL_FIFO(NOL:NOMENKLAT,NOL:DATUMS,NOL:DAUDZUMS)
              NOL_SUMMAV=NOL:DAUDZUMS*NOM:PIC
!              RESET(NOL:NR_KEY,SAV_POSITION)
!              NEXT(NOLIK)
!              NOL:RECORD=SAV_RECORD
              NOL:SUMMAV=NOL_SUMMAV
              NOL:SUMMA=NOL:SUMMAV
              NOL:ARBYTE=0
           ELSE
              DO STARTSUMMA
           .
        END
        IF INSTRING(PAV:D_K,'KPR')
           SELECT(?OK)
        .
      END
    OF ?NOL:SUMMAV
      CASE EVENT()
      OF EVENT:Accepted
        IF NOL:DAUDZUMS<0
           NOL:SUMMAV=-ABS(NOL:SUMMAV)
        .
        NOL:SUMMA=NOL:SUMMAV*BANKURS(NOL:val,NOL:DATUMS)
        !IF nol:d_k='K' AND ~INRANGE(NOL:PAR_NR,1,50) AND NOM:PIC > round(CALCSUM(15,3)/NOL:DAUDZUMS,.001) ! Ls bez PVN -A
        !   KLUDA(0,'Realizâcijas cena mazâka par pçdçjo iepirkuma cenu...')
        !.
        IF CL_NR=1237 AND NOL:SUMMAV= 0 AND ~(NOL:NOMENKLAT[1:4]='IEP*')  !GAG
          SELECT(?NOL:SUMMAV)
          CYCLE
        .
        
        DISPLAY
      END
    OF ?NOL:PVN_PROC
      CASE EVENT()
      OF EVENT:Accepted
        IF NOL:PVN_PROC > 22
          IF StandardWarning(Warn:OutOfRangeHigh,'NOL:PVN_PROC','22')
            SELECT(?NOL:PVN_PROC)
            QuickWindow{Prop:AcceptAll} = False
            CYCLE
          END
        END
      END
    OF ?ButtonPVN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOL:BAITS,00000010b)    !AR PVN NEAPLIEKAMS
           NOL:BAITS-=2
           ?BUTTONPVN{PROP:TEXT}='% PVN'
           ENABLE(?NOL:PVN_PROC)
        ELSE
           NOL:BAITS+=2
           NOL:PVN_PROC=0
           ?BUTTONPVN{PROP:TEXT}='PVN neapl.'
           DISABLE(?NOL:PVN_PROC)
        .
        DISPLAY
      END
    OF ?NOL:ATLAIDE_PR
      CASE EVENT()
      OF EVENT:Accepted
           IF INSTRING(NOL:D_K,'KP') AND NOL:ATLAIDE_PR AND BAND(NOM:NEATL,00000001b) !NEDOT ATLAIDI
              KLUDA(0,'Nomenklatûrai dot atlaidi nav atïauts...')
              NOL:ATLAIDE_PR=0
           .
           SUMMA_A=CALCSUM(8,2)   !ATLAIDE
           display
      END
    OF ?Button:ChangeNom_k
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           IF PUTNom_K=FALSE
              PUTNom_K=TRUE
              ?BUTTON:CHANGENOM_K{PROP:TEXT}='...tiks pârrakstîts pçc OK '
           ELSE
              PUTNom_K=FALSE
              ?BUTTON:CHANGENOM_K{PROP:TEXT}='...netiks pârrakstîts pçc OK '
           .
           DISPLAY
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
        SELECT(?OK)
      END
    OF ?ButtonMPROJEKTU
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseProjekti 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           NOL:OBJ_NR=PRO:U_NR
           NOL_PROJEKTS=PRO:NOS_P
           DISPLAY
        .
      END
    OF ?ButtonMPar_nr
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           NOL:PAR_NR=PAR:U_NR
           NOL_Partneris=PAR:NOS_S
           DISPLAY
        .
      END
    OF ?ButtonKeksis
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOL:BAITS,00000001b)     !ir parâds
           nol:BAITS-=1
           UNHIDE(?IMAGESAMAKSATS)
           HIDE(?IMAGEnavMAKSATS)
        ELSE
           nol:BAITS+=1
           HIDE(?IMAGESAMAKSATS)
           UNHIDE(?IMAGEnavMAKSATS)
        .
        display
      END
    OF ?ButtonDiena
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(NOL:BAITS,00000100b)    !0-DIENA 1-NAKTS
           NOL:BAITS-=4
           ?BUTTONDIENA{PROP:TEXT}='Diena'
        ELSE
           NOL:BAITS+=4
           ?BUTTONDIENA{PROP:TEXT}='Nakts'
        .
        RAKSTI#=0
        CLEAR(APD:RECORD)
        APD:PAV_NR=NOL:U_NR
        SET(APD:NR_KEY,APD:NR_KEY)
        LOOP
           NEXT(AUTODARBI)
           IF ERROR() OR ~(APD:PAV_NR=NOL:U_NR) THEN BREAK.
           IF ~(NOL:NOMENKLAT=APD:NOMENKLAT) THEN CYCLE.
           IF ~BAND(APD:BAITS,00000001b) AND BAND(NOL:BAITS,00000100b)    !NOL:NAKTS
              APD:BAITS+=1
              PUT(AUTODARBI)
              RAKSTI#+=1
           ELSIF BAND(APD:BAITS,00000001b) AND ~BAND(NOL:BAITS,00000100b) !NOL:DIENA
              APD:BAITS-=1
              PUT(AUTODARBI)
              RAKSTI#+=1
           .
        .
        IF RAKSTI#
           KLUDA(0,'Mainîta D/N pazîme AUTODARBI failâ '&clip(raksti#)&' rakstiem')
        .
        DISPLAY
      END
    OF ?Lock1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF NOL:LOCK
           NOL:LOCK=0
           HIDE(?IMAGE1)
        ELSE
           NOL:LOCK=1
           UNHIDE(?IMAGE1)
        .
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        OK#=TRUE
        
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
        IF ~NOL:NOMENKLAT
           KLUDA(11,'Nav norâdîta Nomenklatûra ...')
           SELECT(?ButtonNomenklat)
           QuickWindow{Prop:AcceptAll} = False
           CYCLE
        ELSIF nol:d_k='K' AND ~INRANGE(NOL:PAR_NR,1,50) AND NOM:MINRC AND |
        NOM:MINRC > round(CALCSUM(15,3)/NOL:DAUDZUMS,.001) ! Ls bez PVN -A
           KLUDA(0,'Realizâcijas cena mazâka par MIN realizâcijas cenu...')
           IF ATLAUTS[24]='1' !AIZLIEGTS TIRGOT ZEM MIN RC
              SELECT(?NOL:SUMMAV)
              QuickWindow{Prop:AcceptAll} = False
              CYCLE
           .
        .
        IF NOL:DAUDZUMS>NOM_ATLIKUMS AND PAV:D_K='K' AND ~INSTRING(NOM:TIPS,'TARV') AND LOCALREQUEST=1
           KLUDA(11,'Pârbaudiet daudzumu ...')
        .
        IF nol:d_k='K' AND ~INRANGE(NOL:PAR_NR,1,50) AND ~(NOL:NOMENKLAT[1:4]='IEP*') AND |
        NOM:PIC > round(CALCSUM(15,3)/NOL:DAUDZUMS,.001) ! Ls bez PVN -A
           KLUDA(0,'Realizâcijas cena mazâka par pçdçjo iepirkuma cenu...')
        .
        NOMENKLAT=NOL:NOMENKLAT   !LAI ATCERÂS TABULAI PIE NÂKOÐÂS IZVÇLES
        PAV:C_SUMMA=PAV:SUMMA
        IF CL_NR=1502
            IF PAV:D_K = 'K'
                NOL:CITAS = NOM:REALIZ[NOKL_CENA]*100 !Elya 17/09/2012  SYS:NOKL_CP
            END
        END
        DISPLAY
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
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  IF NOL_FIFO::Used = 0
    CheckOpen(NOL_FIFO,1)
  END
  NOL_FIFO::Used += 1
  BIND(FIFO:RECORD)
  IF NOL_KOPS::Used = 0
    CheckOpen(NOL_KOPS,1)
  END
  NOL_KOPS::Used += 1
  BIND(KOPS:RECORD)
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
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  IF PROJEKTI::Used = 0
    CheckOpen(PROJEKTI,1)
  END
  PROJEKTI::Used += 1
  BIND(PRO:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  RISnap:NOLIK
  SAV::NOL:Record = NOL:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    ! NOMENKLAT=''  !LAI NEPÂRLASA BROWSI
     ALIAS(PgDnKey,PgDnKey)
     ALIAS(PgUpKey,PgUpKey)
     NOL:NOMENKLAT=getnom_k('OBLIGÂTI JÂIZSAUC',1,1)
     ALIAS(PgDnKey,TabKey)
     ALIAS(PgUpKey,ShiftTab)
     IF ~(PAV:PAR_NR=PAR:U_NR)
        I#=GETPAR_K(PAV:PAR_NR,2,1)  !POZICIONÇJAM PAR_K, JA MAINOT NOMENKLATÛRU IR IZKUSTINÂTS
     .
     IF GLOBALRESPONSE=REQUESTCOMPLETED
        NOL:U_NR=PAV:U_NR
        NOL:DATUMS=PAV:DATUMS
        NOL:PAR_NR=PAV:PAR_NR
        NOL:OBJ_NR=PAV:OBJ_NR
        NOL:D_K=PAV:D_K
        NOL:VAL=PAV:val
        IF INSTRING(PAV:APM_V,'23')  !APM_V PATIESÎBÂ IR APMAKSAS KÂRTÎBA
           NOL:BAITS=1 !PARÂDS
        ELSE
           NOL:BAITS=0
        .
        DO NOMTONOL
        IF INSTRING(PAV:D_K,'KPR')
           NOL:ATLAIDE_PR=GETPAR_ATLAIDE(PAR:Atlaide,NOL:NOMENKLAT)
           IF (BAND(NOM:NEATL,00000001b) AND NOL:ATLAIDE_PR>0) OR| !NEDRÎKST DOT ATLAIDI
           BAND(NOM:NEATL,00000010b)                               !AKCIJAS PRECE
              NOL:ATLAIDE_PR=0
           .
        .
    !    IF BAND(NOM:NEATL,00000010b)      ...UZ NOMSHOW
    !       KLUDA(0,'Akcijas prece...')
    !    .
     ELSE
       DO PROCEDURERETURN
     .
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:NOLIK()
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
  ?NOL:NOMENKLAT{PROP:Alrt,255} = 734
  ?NOL:IEPAK_D{PROP:Alrt,255} = 734
  ?NOL:DAUDZUMS{PROP:Alrt,255} = 734
  ?NOL:SUMMAV{PROP:Alrt,255} = 734
  ?NOL:val:2{PROP:Alrt,255} = 734
  ?NOL:SUMMA{PROP:Alrt,255} = 734
  ?NOL:ARBYTE{PROP:Alrt,255} = 734
  ?NOL:PVN_PROC{PROP:Alrt,255} = 734
  ?NOL:ATLAIDE_PR{PROP:Alrt,255} = 734
  ?NOL:val:3{PROP:Alrt,255} = 734
  ?NOL:PAR_NR{PROP:Alrt,255} = 734
  ?NOL:OBJ_NR{PROP:Alrt,255} = 734
  ?NOL:IZC_V_KODS{PROP:Alrt,255} = 734
  ?NOL:MUITA{PROP:Alrt,255} = 734
  ?NOL:AKCIZE{PROP:Alrt,255} = 734
  ?NOL:CITAS{PROP:Alrt,255} = 734
  ?NOL:T_SUMMA{PROP:Alrt,255} = 734
  ?NOL:val{PROP:Alrt,255} = 734
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
        IF PUTNOM_K=TRUE
!        IF NOM:PIC_DATUMS<=NOL:DATUMS AND NOL:D_K='D' AND (LocalRequest=1 OR LocalRequest=2)|
!        AND pav:rs=0 AND ~INRANGE(NOL:PAR_NR,1,50)
           IF PIEKTA THEN NOM:REALIZ[5]=PIEKTA.
           IF CETURTA THEN NOM:REALIZ[4]=CETURTA.
           NOM:VAL[5]=VAL5
!           NOM:VAL[5]='Ls'
           NOM:PIC_DATUMS=NOL:DATUMS
           NOM:PIC=PIC
           IF GNET
              NOM:GNET_FLAG[1]=2
              NOM:GNET_FLAG[2]=''
           .
           I#=RIUPDATE:NOM_K()
        .
        IF NOM:REDZAMIBA=2 !NÂKOTNES VAIRS NAV
           NOM:REDZAMIBA=0 !AKTÎVA
           I#=RIUPDATE:NOM_K()
        .
        IF LocalRequest=1  !IEVADÎÐANA
           AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
           KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
        ELSIF LocalRequest=2  !MAINÎÐANA
           NOL_SUMMA=CALCSUM(16,2)
           AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,SAV_D_K,SAV_NOMENKLAT,SAV_DAUDZUMS)
           IF ~(NOL:NOMENKLAT=SAV_NOMENKLAT AND NOL:DATUMS=SAV_DATUMS)
              KopsN(SAV_NOMENKLAT,SAV_DATUMS,NOL:D_K)
              KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
           ELSIF ~(NOL:DAUDZUMS=SAV_DAUDZUMS AND NOL_SUMMA=SAV_SUMMA)
              KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
           .
        ELSIF LocalRequest = DeleteRecord !DZÇÐANA
           AtlikumiN('','',0,NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS)
           KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
        .
     .
     IF SAV_NOKL_CP THEN NOKL_CP=SAV_NOKL_CP. !LAI PAR_K DEFINÇTÂ CENA NENOJAUC TÂLÂKUS RÇÍINUS.
     ALIAS(PgDnKey)
     ALIAS(PgUpKey)
    KOMPLEKT::Used -= 1
    IF KOMPLEKT::Used = 0 THEN CLOSE(KOMPLEKT).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
    NOL_FIFO::Used -= 1
    IF NOL_FIFO::Used = 0 THEN CLOSE(NOL_FIFO).
    NOL_KOPS::Used -= 1
    IF NOL_KOPS::Used = 0 THEN CLOSE(NOL_KOPS).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
    PROJEKTI::Used -= 1
    IF PROJEKTI::Used = 0 THEN CLOSE(PROJEKTI).
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
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
STARTSUMMA  ROUTINE
   ! IZSAUC, JA PIEPRASA PÂRRÇÍINÂT VAI MAINA DAUDZUMU UN SUMMAV=0
   DO ARBYTE
!  NOL:SUMMAV = GETNOM_K(NOL:NOMENKLAT,2,7)*NOL:DAUDZUMS
   NOL:SUMMAV = GETNOM_K('POZICIONÇTS',2,7)*NOL:DAUDZUMS
   nol:summa  =nol:summav*bankurs(nol:VAL,nol:datums)
   SUMMA_KOPA =CALCSUM(12,2)
   SUMMA_A    =CALCSUM(8,3)   !ATLAIDE
   SUMMA_APM  =CALCSUM(4,4)
   DISPLAY

NOMTONOL  ROUTINE
   ! IZSAUC, JA MAINA NOMENKLATÛRU, VAI IEVADA JAUNU
   NOL:NOMENKLAT=NOM:NOMENKLAT
   NOL:IZC_V_KODS=NOM:IZC_V_KODS
   IF BAND(NOM:BAITS1,00000010b) !PIEFIKSÇJAM NEAPLIEKAMÂS
      IF ~BAND(NOL:BAITS,00000010b)
         NOL:BAITS+=2
      .
   ELSE
      IF BAND(NOL:BAITS,00000010b)
         NOL:BAITS-=2
      .
   .
   IF INRANGE(NOL:PAR_NR,26,50) !RAÞOÐANA
      NOL:PVN_PROC=0
      NOL:ARBYTE=0  !NORAKSTAM BEZ PVN
   ELSIF GETPAR_K(NOL:PAR_NR,0,20)='C' !ES
      NOL:PVN_PROC=0
      NOL:ARBYTE=1  !PÂRDODAM AR 0% PVN
   ELSE
      NOL:PVN_PROC=NOM:PVN_PROC
      DO ARBYTE
   .
   DISPLAY

NOMSHOW  ROUTINE
   ! IZSAUC PREPAREWIN VAI, JA MAINA NOMENKLATÛRU, VAI IEVADA JAUNU
   NOM_ATLIKUMS=GETNOM_A(NOM:NOMENKLAT,1,0) !PÂRTAISÎTA GETNOM_A F-JA
   NOM_PIEEJAMS=NOM_ATLIKUMS-GETNOM_A(NOM:NOMENKLAT,4,0)
   MINRC_AR_PVN=nom:minrc*(1+nom:pvn_proc/100)
   IF NOM:TIPS='A'
      NOKL_CENA=NOKL_CA
   ELSE
      NOKL_CENA=NOKL_CP
   .
   IF BAND(NOM:ARPVNBYTE,00000001b) THEN ARPVN[1]='ar  PVN' ELSE ARPVN[1]='bez PVN'.
   IF BAND(NOM:ARPVNBYTE,00000010b) THEN ARPVN[2]='ar  PVN' ELSE ARPVN[2]='bez PVN'.
   IF BAND(NOM:ARPVNBYTE,00000100b) THEN ARPVN[3]='ar  PVN' ELSE ARPVN[3]='bez PVN'.
   IF BAND(NOM:ARPVNBYTE,00001000b) THEN ARPVN[4]='ar  PVN' ELSE ARPVN[4]='bez PVN'.
   IF BAND(NOM:ARPVNBYTE,00010000b) THEN ARPVN[5]='ar  PVN' ELSE ARPVN[5]='bez PVN'.

   IF BAND(NOM:BAITS1,00000100b)  !~LOCK 5C
      UNHIDE(?IMAGE5C)
      PIEKTA=NOM:REALIZ[5]
      CETURTA=NOM:REALIZ[4]
   .
   IF BAND(NOM:NEATL,00000010b)
       KLUDA(0,'Akcijas prece...')
   .

   IF NOM:SKAITS_I
      NOM_SKAITS_I=CLIP(NOM:SKAITS_I)&' '&CLIP(NOM:MERVIEN)&'/iepakojumâ'
   ELSE
      NOM_SKAITS_I=''
   .
!   IF NOM:PIC_DATUMS<=NOL:DATUMS AND NOL:D_K='D' AND NOL:DAUDZUMS>0 AND (LocalRequest=1 OR LocalRequest=2)|
   IF NOM:PIC_DATUMS<=NOL:DATUMS AND NOL:D_K='D' AND (LocalRequest=1 OR LocalRequest=2)|
   AND pav:rs=0 AND ~INRANGE(NOL:PAR_NR,1,50) AND ~(CL_NR=1033 AND LOC_NR=3) !ÍIPSALAS 3. NOL.
      PUTNom_K=TRUE
      ?BUTTON:CHANGENOM_K{PROP:TEXT}='...tiks pârrakstîts pçc OK '
   ELSE
      PUTNom_K=FALSE
      ?BUTTON:CHANGENOM_K{PROP:TEXT}='...netiks pârrakstîts pçc OK '
   .
   DISPLAY

ARBYTE  ROUTINE
   NOL:ARBYTE=0            !bez pvn
   IF INSTRING(NOL:D_K,'KPR')
!      IF GETNOM_K(NOL:NOMENKLAT,0,10)
      IF GETNOM_K('POZICIONÇTS',0,10)
         NOL:ARBYTE=1
!         STOP(NOM:ARPVNBYTE&'='&GETNOM_K('POZICIONÇTS',0,10))
      .
   .
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?NOL:NOMENKLAT
      NOL:NOMENKLAT = History::NOL:Record.NOMENKLAT
    OF ?NOL:IEPAK_D
      NOL:IEPAK_D = History::NOL:Record.IEPAK_D
    OF ?NOL:DAUDZUMS
      NOL:DAUDZUMS = History::NOL:Record.DAUDZUMS
    OF ?NOL:SUMMAV
      NOL:SUMMAV = History::NOL:Record.SUMMAV
    OF ?NOL:val:2
      NOL:val = History::NOL:Record.val
    OF ?NOL:SUMMA
      NOL:SUMMA = History::NOL:Record.SUMMA
    OF ?NOL:ARBYTE
      NOL:ARBYTE = History::NOL:Record.ARBYTE
    OF ?NOL:PVN_PROC
      NOL:PVN_PROC = History::NOL:Record.PVN_PROC
    OF ?NOL:ATLAIDE_PR
      NOL:ATLAIDE_PR = History::NOL:Record.ATLAIDE_PR
    OF ?NOL:val:3
      NOL:val = History::NOL:Record.val
    OF ?NOL:PAR_NR
      NOL:PAR_NR = History::NOL:Record.PAR_NR
    OF ?NOL:OBJ_NR
      NOL:OBJ_NR = History::NOL:Record.OBJ_NR
    OF ?NOL:IZC_V_KODS
      NOL:IZC_V_KODS = History::NOL:Record.IZC_V_KODS
    OF ?NOL:MUITA
      NOL:MUITA = History::NOL:Record.MUITA
    OF ?NOL:AKCIZE
      NOL:AKCIZE = History::NOL:Record.AKCIZE
    OF ?NOL:CITAS
      NOL:CITAS = History::NOL:Record.CITAS
    OF ?NOL:T_SUMMA
      NOL:T_SUMMA = History::NOL:Record.T_SUMMA
    OF ?NOL:val
      NOL:val = History::NOL:Record.val
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
  NOL:Record = SAV::NOL:Record
  SAV::NOL:Record = NOL:Record
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

K_A_FIFO             PROCEDURE                    ! Declare Procedure
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
!---------------------------------------------------------------------------
Process:View         VIEW(NOL_KOPS)
                       PROJECT(KOPS:NOMENKLAT)
                       PROJECT(KOPS:KATALOGA_NR)
                       PROJECT(KOPS:U_NR)
                       PROJECT(KOPS:NOS_S)
                       PROJECT(KOPS:STATUSS)
                     END
!---------------------------------------------------------------------------
RAZTABLE             QUEUE,PRE(R)
RAZ                    STRING(3)
DAUDZUMS               DECIMAL(13,3)
BILVERT                DECIMAL(13,3)
                     .

B_TABLE              QUEUE,PRE(B)
BKK                    STRING(5)
SUMMA                  REAL
                     .

FIFO                 QUEUE,PRE(F)
KEY                    STRING(10)
DATUMS                 LONG
D_K                    string(2)
NOL_NR                 BYTE
DAUDZUMS               DECIMAL(11,3)
SUMMA                  DECIMAL(11,2)
                     .

NOLLIST              STRING(45)
PA                   SHORT
NR                   DECIMAL(4)
NOSAUKUMS            STRING(29)
ERR                  STRING(8)
VID                  REAL
CTRL_I               DECIMAL(13,3)
REALIZETS            DECIMAL(13,3)
ATLIKUMS_N           DECIMAL(13,3),DIM(25)
DAUDZUMS_N           DECIMAL(13,3),DIM(25)
DAUDZUMS             DECIMAL(13,3)
DAUDZUMS_nol         DECIMAL(13,3)
SUMMA_K              DECIMAL(13,2)
FMI_K                DECIMAL(13,2)
FMI_TS               DECIMAL(13,2)
REA_TS               DECIMAL(13,3)
KOPA                 STRING(80)
BILVERT              DECIMAL(14,2)
BILVERT_N            DECIMAL(14,2),DIM(25)
BILVERT_NOL          DECIMAL(14,2)
BILVERT_K            DECIMAL(14,2)
DAT                  DATE
LAI                  TIME
VS_FIFO_TEXT         STRING(65)
VS_DAUDZUMS          DECIMAL(13,3)
VS_SUMMA             DECIMAL(13,2)

SAV_JOB_NR           LIKE(JOB_NR)
ATGR_TEXT            STRING(80)
ATGR_TEXT2           STRING(120)
KOMP_TEXT            STRING(120)
SY_VM                STRING(25)
SY_IS                STRING(25)
ERRK                 USHORT
BRIK                 USHORT
ERRORTEXT            STRING(100)

!---------------------------------------------------------------------------
report REPORT,AT(104,1300,8000,10100),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,100,8000,1200),USE(?HEADER)
         STRING(@s45),AT(1573,94,4583,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Bilances atskaite'),AT(365,104),USE(?String32),TRN,FONT(,8,,FONT:bold,CHARSET:ANSI)
         STRING(@s65),AT(1052,344,5615,260),USE(VS_FIFO_TEXT),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,729,6667,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(938,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3490,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(4167,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5260,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7188,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('NPK'),AT(563,781,365,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(979,781,1354,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2375,792,1094,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2344,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Vienas vienîbas'),AT(4219,781,990,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(5365,781,1750,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vidçjâ vçrtîba'),AT(4219,990,990,155),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(5365,990,833,156),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa Ls'),AT(6250,990,854,156),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(979,990,1354,156),USE(nomenklat),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:ANSI)
         LINE,AT(521,1198,6667,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(521,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@P<<<#. lapaP),AT(6625,563,573,156),PAGENO,USE(?PA),RIGHT
       END
detail DETAIL,AT(,,,155)
         LINE,AT(521,0,0,155),USE(?Line7),COLOR(COLOR:Black)
         STRING(@N_5),AT(573,0,313,130),USE(NR),RIGHT
         LINE,AT(938,0,0,155),USE(?Line7:2),COLOR(COLOR:Black)
         STRING(@s21),AT(979,0,1354,130),USE(kops:nomenklat),LEFT
         LINE,AT(2344,0,0,155),USE(?Line7:8),COLOR(COLOR:Black)
         STRING(@s16),AT(2396,0,1042,130),USE(kops:nos_s),LEFT
         LINE,AT(3490,0,0,155),USE(?Line7:6),COLOR(COLOR:Black)
         STRING(@s8),AT(3594,0,521,130),USE(ERR),CENTER
         LINE,AT(4167,0,0,155),USE(?Line7:3),COLOR(COLOR:Black)
         STRING(@N_11.4),AT(4375,0,,130),USE(VID),RIGHT
         LINE,AT(5260,0,0,155),USE(?Line7:5),COLOR(COLOR:Black)
         STRING(@N-_13.3),AT(5365,0,,130),USE(DAUDZUMS),RIGHT
         STRING(@N-_13.2),AT(6250,0,,130),USE(BILVERT),RIGHT
         LINE,AT(7188,0,0,155),USE(?Line7:4),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,115),USE(?unnamed:3)
         LINE,AT(521,0,0,115),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(938,0,0,63),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(2344,0,0,63),USE(?Line17:2),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,115),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(7188,0,0,115),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,63),USE(?Line17:3),COLOR(COLOR:Black)
         LINE,AT(4167,0,0,63),USE(?Line17:4),COLOR(COLOR:Black)
         LINE,AT(521,52,6667,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,155),USE(?unnamed:2)
         LINE,AT(521,0,0,155),USE(?Line7:7),COLOR(COLOR:Black)
         STRING(@s80),AT(625,0,4583,156),USE(KOPA),LEFT
         STRING(@N-_13.3B),AT(5365,0,,130),USE(daudzums_nol),RIGHT
         LINE,AT(5260,0,0,155),USE(?Line25),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6188,0,,130),USE(bilvert_nol),RIGHT
         LINE,AT(7188,0,0,155),USE(?Line25:2),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,667),USE(?unnamed:4)
         LINE,AT(521,0,0,323),USE(?Line25:3),COLOR(COLOR:Black)
         LINE,AT(521,52,6667,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('Summa :'),AT(625,104,521,208),USE(?String28),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5260,0,0,323),USE(?Line25:6),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6188,104),USE(BILVERT_K),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(1240,115,4010,156),USE(ERRORTEXT),TRN,CENTER
         LINE,AT(521,313,6667,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(531,333,469,156),USE(?String30),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(1010,333,573,156),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1781,333,250,156),USE(?String30:2),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(2000,333,156,156),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6146,333,615,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(6719,333,490,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@s120),AT(573,521,6615,156),USE(KOMP_TEXT),TRN,LEFT
         LINE,AT(7188,0,0,323),USE(?Line25:7),COLOR(COLOR:Black)
       END
LINE   DETAIL,AT(,,,1)
         LINE,AT(521,0,6667,0),USE(?Line11:7),COLOR(COLOR:Black)
       END
       FOOTER,AT(104,11400,8000,1)
         LINE,AT(521,0,6667,0),USE(?Line1:6),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(65,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SAV_JOB_NR=JOB_NR
  LOOP I#= 1 TO NOL_SK
     JOB_NR=I#+15
     CHECKOPEN(SYSTEM,1)
     IF BAND(SYS:BAITS1,00000100B) !Vairumtirdzniecîba
        SY_VM[I#]='V'
     ELSE
        SY_VM[I#]='M'
     .
!     IF BAND(SYS:BAITS1,10000000B) !-K Kontçt kâ ienâkoðo
!        SY_IS[I#]='I'
!     ELSE
!        SY_IS[I#]='S'
!     .
  .
  JOB_NR=SAV_JOB_NR
  CHECKOPEN(SYSTEM,1)
  dat=today()
  lai=clock()
  CHECKOPEN(GLOBAL,1)
  CASE GL:FMI_TIPS
  OF 'VS'
     VS_FIFO_TEXT='Preèu atlikumi pçc bilances vçrtîbas (VS metode) uz '&FORMAT(b_dat,@D06.)
  ELSE
     VS_FIFO_TEXT='Preèu atlikumi pçc bilances vçrtîbas (FIFO metode) uz '&FORMAT(b_dat,@D06.)
  .
  IF BAND(REG_NOL_ACC,00010000b) ! ATÏAUTA KOMPLEKTÂCIJA
!JÂDOMÂ     KOMP_TEXT='Raþojumi tiek ignorçti, paðizmaksu rçíinam pçc R norakstîtajâm sastâvdaïâm'
  .

  IF NOL_KOPS::USED=0
     CHECKOPEN(NOL_KOPS,1)
  .
  NOL_KOPS::USED+=1
  IF NOL_FIFO::USED=0
     CHECKOPEN(NOL_FIFO,1)
  .
  NOL_FIFO::USED+=1
  BIND(KOPS:RECORD)

  FilesOpened=TRUE
  RecordsToProcess = RECORDS(NOL_KOPS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Preèu atlikumi pçc bilances vçrtîbas '&GL:FMI_TIPS
  ?Progress:UserString{Prop:Text}=''
  SEND(NOL_KOPS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KOPS:RECORD)
      kops:nomenklat=nomenklat
      SET(KOPS:NOM_KEY,KOPS:NOM_KEY)
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
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('KAFIFO.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='Bilances atskaite'
          ADD(OUTFILEANSI)
          OUTA:LINE=VS_FIFO_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='NPK'&CHR(9)&'Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&CHR(9)&'Vienas vienîbas'&CHR(9)&'Atlikums'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'vidçja vçrtîba'&CHR(9)&'Daudzums'&CHR(9)&'Summa Ls'
             ADD(OUTFILEANSI)
          ELSE !Word
             OUTA:LINE='NPK'&CHR(9)&'Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&CHR(9)&'Vienas vienîbas vidçja vçrtîba'&|
             CHR(9)&'Atlikums daudzums'&CHR(9)&'Summa Ls'
             ADD(OUTFILEANSI)
          .
!          OUTA:LINE=''
!          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(KOPS:NOMENKLAT)
        IF ~(BAND(REG_NOL_ACC,00010000b) AND GETNOM_K(KOPS:NOMENKLAT,0,16)='R')! ~(ATÏAUTA KOMPLEKTÂCIJA UN RAÞOJUMS)
           nk#+=1
           ?Progress:UserString{Prop:Text}=NK#
           DISPLAY(?Progress:UserString)
           CHECKKOPS('POZICIONÇTS',0,0) !UZ REQ=0 PÂRRÇÍINAM MAINÎTOS
           NR+=1
           REALIZETS=0
           BILVERT=0
           DAUDZUMS=0
           CLEAR(ATLIKUMS_N)
           VS_DAUDZUMS=0
           VS_SUMMA=0
           ERR=''
           CTRL_I=0

!----------PIRMAJÂ PIEGÂJIENÂ SAMEKLÂJAM MÛSU ATGRIEZTO PRECI, SASKAITAM REALIZÂCIJU UN ATLIKUMUS NOLIKTAVÂS------

           CLEAR(FIFO:RECORD)
           FIFO:U_NR=KOPS:U_NR
!           FIFO:DATUMS=DATE(1,1,DB_GADS)
           FIFO:DATUMS=DB_S_DAT
           SET(FIFO:NR_KEY,FIFO:NR_KEY)
           LOOP
              NEXT(NOL_FIFO)
              IF ERROR() OR ~(FIFO:U_NR=KOPS:U_NR AND FIFO:DATUMS<=B_DAT) THEN BREAK.
              F:KEY     =FIFO:DATUMS&FIFO:D_K
              F:DATUMS  =FIFO:DATUMS
              F:NOL_NR  =FIFO:NOL_NR
              F:D_K     =FIFO:D_K
              F:DAUDZUMS=FIFO:DAUDZUMS
              F:SUMMA   =FIFO:SUMMA
              ADD(FIFO)

              CASE FIFO:D_K
              OF 'A '
                 IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU,jo nav jau zinâms, tieði no kuras PPR atgriezts
                    REALIZETS+=ABS(FIFO:DAUDZUMS)
                 ELSE
                    VS_DAUDZUMS+=FIFO:DAUDZUMS
                    VS_SUMMA+=FIFO:SUMMA
                 .
                 ATLIKUMS_N[FIFO:NOL_NR]+=FIFO:DAUDZUMS
              OF 'D '
              OROF 'DR'
                 IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU
                    REALIZETS+=ABS(FIFO:DAUDZUMS)
                 ELSE
                    VS_DAUDZUMS+=FIFO:DAUDZUMS
                    VS_SUMMA+=FIFO:SUMMA
                 .
                 ATLIKUMS_N[FIFO:NOL_NR]+=FIFO:DAUDZUMS
              OF 'DI'
                 ATLIKUMS_N[FIFO:NOL_NR]+=FIFO:DAUDZUMS
                 CTRL_I+=FIFO:DAUDZUMS
              OF 'K '
!                 IF FIFO:DAUDZUMS<0 AND SY_IS[FIFO:NOL_NR]='I' !PÇRKAM ?
!                    F:D_K     ='D'
!                    F:DAUDZUMS=ABS(FIFO:DAUDZUMS)
!                    F:SUMMA   =ABS(FIFO:SUMMA)
!                    PUT(FIFO)
!                    VS_DAUDZUMS+=FIFO:DAUDZUMS
!                    VS_SUMMA+=FIFO:SUMMA
!                 ELSE
                    REALIZETS+=FIFO:DAUDZUMS   !JA - ,LAI SAMAZINA REALIZÂCIJU,JA PIEPRASÎTS STORNÇT
!                 .
                 ATLIKUMS_N[FIFO:NOL_NR]-=FIFO:DAUDZUMS
              OF 'KR' !PERIODA BEIGÂS UZ RAÞOÐANU NEDRÎKST BÛT ATLIKUMI....???
                 REALIZETS+=FIFO:DAUDZUMS
                 ATLIKUMS_N[FIFO:NOL_NR]-=FIFO:DAUDZUMS
              OF 'KI'
                 ATLIKUMS_N[FIFO:NOL_NR]-=FIFO:DAUDZUMS
                 CTRL_I-=FIFO:DAUDZUMS
              .
           .
           IF CTRL_I
              ERR='IP KÏÛDA'
           .
           CASE GL:FMI_TIPS
           OF 'FIFO'
!---------------------RÇÍINAM REÂLÂS FIFO TABULAS------------------
              SORT(FIFO,F:KEY)
              GET(FIFO,0)
              LOOP F#=1 TO RECORDS(FIFO)
                GET(FIFO,F#)
                IF ~INSTRING(F:D_K,'A D DR',2) THEN CYCLE.
                IF F:DAUDZUMS<0  THEN CYCLE.   !MÇS ESAM ATGRIEZUÐI, JAU PIESKAITÎJÂM REALIZÂCIJAI
                                               !VADÎBAS ATSKAITEI VIENKÂRÐI IGNORÇJAM
                IF REALIZETS > F:DAUDZUMS
                   REALIZETS-=F:DAUDZUMS       !NO VISA,KAS REALIZÇTS,NOÒEMAM ÐITO IENÂKUÐO
                ELSIF REALIZETS
                   BILVERT=(F:SUMMA/F:DAUDZUMS)*(F:DAUDZUMS-REALIZETS)
                   DAUDZUMS=F:DAUDZUMS-REALIZETS
                   REALIZETS=0
                ELSE                           !atlikums,nav realizçts
                   BILVERT+=F:SUMMA
                   DAUDZUMS+=F:DAUDZUMS
                .
              .
              IF REALIZETS <0    !ATGRIEZTA PRECE, KURAI NAV NE D NE S
                 DAUDZUMS=ABS(REALIZETS)
                 BILVERT=GETNOM_K(KOPS:NOMENKLAT,0,7,6)*DAUDZUMS  !PIC
                 ERR='PIC'
              ELSIF REALIZETS >0    !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT
                 ERR='RE KÏÛDA'
              .
              FREE(FIFO)
           ELSE
!---------------------RÇÍINAM VS------------------
              IF REALIZETS > VS_DAUDZUMS !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT
                 ERR='RE KÏÛDA'
              ELSE
                 DAUDZUMS=VS_DAUDZUMS-REALIZETS
                 BILVERT=VS_SUMMA/VS_DAUDZUMS*DAUDZUMS
              .
           .
!-------------------------------------------------
           IF DAUDZUMS OR ERR     !IR ATLIKUMS VAI IR KÏÛDA
              IF DAUDZUMS         !IR (+)ATLIKUMS
                 VID=BILVERT/DAUDZUMS
                 BILVERT_K+=BILVERT
                 LOOP I#= 1 TO NOL_SK
                    DAUDZUMS_N[I#]+=ATLIKUMS_N[I#]
                    BILVERT_N[I#]+=ATLIKUMS_N[I#]*VID
                 .
              ELSE
                 VID=0
              .
              IF ERR AND ERR='PIC'
                 BRIK+=1
              ELSIF ERR
                 ERRK+=1
              .
              IF ~F:IDP OR (ERR AND F:IDP) !TIKAI KÏÛDAS
                 IF F:DBF = 'W'
                   PRINT(RPT:DETAIL)
                 ELSE
                   OUTA:LINE=NR&CHR(9)&KOPS:NOMENKLAT&CHR(9)&KOPS:NOS_S&CHR(9)&ERR&CHR(9)&LEFT(FORMAT(VID,@N_9.3))&|
                   CHR(9)&LEFT(FORMAT(DAUDZUMS,@N_11.3))&CHR(9)&LEFT(FORMAT(BILVERT,@N_10.2))
                   ADD(OUTFILEANSI)
                 .
              .
              DO PERFORMR_TABLE   !PÇC RAÞOTÂJU KODIEM
              DO PERFORMB_TABLE   !PÇC BKK
           .
        .
        .
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
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT1)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
  END
  LOOP I#= 1 TO NOL_SK
     KOPA='NOL'&CLIP(I#)&':'
     IF SY_VM[I#]='V'
        KOPA=CLIP(KOPA)&' Vairumtirdzniecîba'
     ELSE
        KOPA=CLIP(KOPA)&' Mazumtirdzniecîba'
     .
!     IF SY_IS[I#]='I'
!        KOPA=CLIP(KOPA)&' STORNO K pieprasîts uzskatît par D'
!     ELSE
!        KOPA=CLIP(KOPA)&' STORNO K pieprasîts stornçt'
!     .
     DAUDZUMS_NOL=DAUDZUMS_N[I#]
     BILVERT_NOL=BILVERT_N[I#]
     IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT2)
     ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMS_NOL,@N_11.3))&CHR(9)&|
        LEFT(FORMAT(BILVERT_NOL,@N_10.2))
        ADD(OUTFILEANSI)
     .
  .
!  LOOP I#= 1 TO NOL_SK
!     KOPA='NOL'&CLIP(I#)
!     DAUDZUMS_NOL=DAUDZUMS_N[I#]
!     BILVERT_NOL=BILVERT_N[I#]
!     IF F:DBF = 'W'
!        PRINT(RPT:RPT_FOOT2)
!     ELSE
!        OUTA:LINE=KOPA&' {40}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(DAUDZUMS_NOL,@N_11.3)&CHR(9)&FORMAT(BILVERT_NOL,@N_10.2)
!        ADD(OUTFILEANSI)
!     END
!  .
  IF F:DBF = 'W'
    PRINT(RPT:LINE)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
  END
  LOOP I#= 1 TO RECORDS(RAZTABLE)  !PÇC RAÞOTÂJU KODIEM
     GET(RAZTABLE,I#)
     KOPA='Raþotâjs: '&R:RAZ&' '&GETPAR_K(1,0,28,,R:RAZ)
     DAUDZUMS_NOL=R:DAUDZUMS
     BILVERT_NOL=R:BILVERT
     IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT2)
     ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMS_NOL,@N_11.3B))&CHR(9)&|
        LEFT(FORMAT(BILVERT_NOL,@N_10.2))
        ADD(OUTFILEANSI)
     .
  .
  IF F:DBF = 'W'
    PRINT(RPT:LINE)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
  END
  LOOP I#= 1 TO RECORDS(B_TABLE)   !PÇC BKK
     GET(B_TABLE,I#)
     KOPA='BKK: '&B:BKK
     DAUDZUMS_NOL=0
     BILVERT_NOL=B:SUMMA
     IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT2)
     ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMS_NOL,@N_11.3B))&CHR(9)&|
        LEFT(FORMAT(BILVERT_NOL,@N_10.2))
        ADD(OUTFILEANSI)
     .
  .
  IF ERRK
     ERRORTEXT=CLIP(ERRK)&' kïûdas'
  .
  IF BRIK
     ERRORTEXT=CLIP(ERRORTEXT)&' '&CLIP(BRIK)&' brîdinâjumi'
  .
!  IF ERRK OR BRIK
!     ERRORTEXT=CLIP(ERRORTEXT)&' '&'sk. '&clip(FILENAME1)
!  .
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT3)
  ELSE
    OUTA:LINE='SUMMA'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(BILVERT_K,@N_10.2))
    ADD(OUTFILEANSI)
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE='Sastâdîja '&ACC_KODS&' '&CLIP(ERRORTEXT)&' '&FORMAT(DAT,@D06.)&' '&FORMAT(LAI,@T4)
    ADD(OUTFILEANSI)
  .
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!!     report{Prop:Preview} = PrintPreviewImage
     ENDPAGE(report)
     CLOSE(ProgressWindow)
     IF F:DBF='W'
        RP
        IF Globalresponse = RequestCompleted
           loop J#=1 to PR:SKAITS
              report{Prop:FlushPreview} = True
              IF ~(J#=PR:SKAITS)
                 loop I#= 1 to RECORDS(PrintPreviewQueue1)
                    GET(PrintPreviewQueue1,I#)
                    PrintPreviewImage=PrintPreviewImage1
                    add(PrintPreviewQueue)
                 .
              .
           .
        END
     ELSE
        ANSIJOB
     .
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE
     CLOSE(OUTFILEANSI)
     ANSIFILENAME=''
  .
  DO ProcedureReturn

!-----------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, GlobalResponse is assigned a value to signal the calling procedure
!| what happened in this procedure.
!|
!| Next, we replace the BINDings that were in place when the procedure initialized
!| (and saved with PUSHBIND) using POPBIND.
!|
!| Finally, we return to the calling procedure.
!|
  NOL_KOPS::USED-=1
  IF NOL_KOPS::USED=0
     CLOSE(NOL_KOPS)
  .
  NOL_FIFO::USED-=1
  IF NOL_FIFO::USED=0
     CLOSE(NOL_FIFO)
  .
  FREE(B_TABLE)
  FREE(RAZTABLE)
!  CLOSE(ERRORFILE)
  POPBIND
  RETURN

!-----------------------------------------------------------------------------
ValidateRecord       ROUTINE
!|
!| This routine is used to provide for complex record filtering and range limiting. This
!| routine is only generated if you've included your own code in the EMBED points provided in
!| this routine.
!|
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR (CYCLENOM(KOPS:NOMENKLAT)=2)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOL_KOPS')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% '
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
PERFORMB_TABLE ROUTINE
  B:BKK=GETNOM_K(KOPS:NOMENKLAT,0,6)
  IF ~B:BKK THEN B:BKK='21300'.
  GET(B_TABLE,B:BKK)
  IF ERROR()
     B:SUMMA=BILVERT
     ADD(B_TABLE)
     SORT(B_TABLE,B:BKK)
  ELSE
     B:SUMMA+=BILVERT
     PUT(B_TABLE)
  .

!-----------------------------------------------------------------------------
PERFORMR_TABLE ROUTINE
  R:RAZ=KOPS:NOMENKLAT[19:21]  !PÇC RAÞOTÂJU KODIEM
  GET(RAZTABLE,R:RAZ)
  IF ERROR()
     R:DAUDZUMS=DAUDZUMS
     R:BILVERT=BILVERT
     ADD(RAZTABLE)
     SORT(RAZTABLE,R:RAZ)
  ELSE
     R:DAUDZUMS+=DAUDZUMS
     R:BILVERT+=BILVERT
     PUT(RAZTABLE)
  .




