                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateATL_K PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
ATL_U_NR             USHORT
RAKSTI               USHORT

BRW2::View:Browse    VIEW(ATL_S)
                       PROJECT(ATS:NOMENKLAT)
                       PROJECT(ATS:ATL_PROC)
                       PROJECT(ATS:ACC_KODS)
                       PROJECT(ATS:ACC_DATUMS)
                       PROJECT(ATS:U_NR)
                     END

Queue:Browse:2       QUEUE,PRE()                  ! Browsing Queue
BRW2::ATS:NOMENKLAT    LIKE(ATS:NOMENKLAT)        ! Queue Display field
BRW2::ATS:ATL_PROC     LIKE(ATS:ATL_PROC)         ! Queue Display field
BRW2::ATS:ACC_KODS     LIKE(ATS:ACC_KODS)         ! Queue Display field
BRW2::ATS:ACC_DATUMS   LIKE(ATS:ACC_DATUMS)       ! Queue Display field
BRW2::ATS:U_NR         LIKE(ATS:U_NR)             ! Queue Display field
BRW2::Mark             BYTE                       ! Queue POSITION information
BRW2::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW2::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW2::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW2::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW2::Sort1:KeyDistribution LIKE(ATS:NOMENKLAT),DIM(100)
BRW2::Sort1:LowValue LIKE(ATS:NOMENKLAT)          ! Queue position of scroll thumb
BRW2::Sort1:HighValue LIKE(ATS:NOMENKLAT)         ! Queue position of scroll thumb
BRW2::Sort1:Reset:ATL:U_NR LIKE(ATL:U_NR)
BRW2::CurrentEvent   LONG                         !
BRW2::CurrentChoice  LONG                         !
BRW2::RecordCount    LONG                         !
BRW2::SortOrder      BYTE                         !
BRW2::LocateMode     BYTE                         !
BRW2::RefreshMode    BYTE                         !
BRW2::LastSortOrder  BYTE                         !
BRW2::FillDirection  BYTE                         !
BRW2::AddQueue       BYTE                         !
BRW2::Changed        BYTE                         !
BRW2::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW2::ItemsToFill    LONG                         ! Controls records retrieved
BRW2::MaxItemsInList LONG                         ! Retrieved after window opened
BRW2::HighlightedPosition STRING(512)             ! POSITION of located record
BRW2::NewSelectPosted BYTE                        ! Queue position of located record
BRW2::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
Update::Reloop  BYTE
Update::Error   BYTE
History::ATL:Record LIKE(ATL:Record),STATIC
SAV::ATL:Record      LIKE(ATL:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:ATL:U_NR     LIKE(ATL:U_NR)
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the ATL_K File'),AT(,,242,270),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateATL_K'),SYSTEM,GRAY,RESIZE
                       PROMPT('&Atlaides lapa Nr:'),AT(4,8),USE(?ATL:U_NR:Prompt)
                       ENTRY(@n6),AT(62,8,40,10),USE(ATL:U_NR),RIGHT(1)
                       BUTTON('Atslçgta'),AT(106,6,45,14),USE(?ATL_HIDDEN),HIDE
                       PROMPT('&Komentârs:'),AT(4,18),USE(?ATL:KOMENTARS:Prompt)
                       ENTRY(@s50),AT(4,30,147,10),USE(ATL:KOMENTARS)
                       STRING(@s7),AT(154,30),USE(ATL:NOS_A),LEFT
                       SHEET,AT(3,46,231,188),USE(?CurrentTab)
                         TAB('Atlaides lapas saturs'),USE(?Tab:1)
                           STRING(@n_5),AT(118,45),USE(RAKSTI),RIGHT(1)
                           STRING('raksti'),AT(144,45),USE(?String3)
                           LIST,AT(5,65,223,149),USE(?Browse:2),IMM,VSCROLL,FONT('Fixedsys',,,FONT:regular),MSG('Browsing Records'),FORMAT('101L(1)|M~Nomenklatûra~C(0)@s21@31R(3)|M~Atl. %~C(0)@n-_5.1@39C|M~ACC kods~@s8@4' &|
   '0L(1)|M~ACC dat.~@D06.@'),FROM(Queue:Browse:2)
                           BUTTON('&Ievadît'),AT(17,217,45,14),USE(?Insert:3)
                           BUTTON('&Mainît'),AT(68,217,45,14),USE(?Change:3),DEFAULT
                           BUTTON('&Dzçst'),AT(119,217,45,14),USE(?Delete:3)
                         END
                       END
                       PROMPT('Atlaide visâm &pârçjâm nomenklatûrâm:'),AT(4,237,127,10),USE(?ATL:ATL_PROC_PA:Prompt)
                       ENTRY(@n-5.1),AT(132,237,23,10),USE(ATL:ATL_PROC_PA),DECIMAL(12)
                       STRING('%'),AT(157,237,11,10),USE(?String1),CENTER
                       STRING(@s8),AT(0,252),USE(ATL:ACC_KODS),FONT(,,COLOR:Gray,)
                       STRING(@D06.),AT(36,252,43,10),USE(ATL:ACC_DATUMS),FONT(,,COLOR:Gray,)
                       BUTTON('Mainît Atl.% &visâm'),AT(81,250,67,14),USE(?MATLPROCV)
                       BUTTON('&OK'),AT(150,250,41,14),USE(?OK)
                       BUTTON('&Atlikt'),AT(193,250,45,14),USE(?Cancel)
                     END
AT_TABLE    QUEUE,PRE(AT)
U_NR          USHORT
NOMENKLAT     STRING(21)
ATL_PROC      DECIMAL(4,1)
            .
ATL_PROC_OLD  DECIMAL(4,1)
ATL_PROC_NEW  DECIMAL(4,1)

ATLSCREEN WINDOW('Atlaiþu % maiòa'),AT(,,157,75),GRAY
       STRING(@N6B),AT(59,7),USE(JB#)
       STRING('Mainît Atlaides %  no'),AT(6,26),USE(?String12)
       ENTRY(@N_5.1),AT(77,25,26,12),USE(ATL_PROC_OLD),CENTER
       STRING('uz'),AT(106,26),USE(?String23)
       ENTRY(@N_5.1),AT(118,25,26,12),USE(ATL_PROC_NEW),CENTER
       BUTTON('&OK'),AT(70,53,35,14),USE(?Ok:A),DEFAULT
       BUTTON('&Atlikt'),AT(109,53,36,14),USE(?Cancel:A)
     END

  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF COPYREQUEST=1
     ATL_U_NR=ATL:U_NR
     ATL:U_NR=0
  .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  IF ATL:U_NR=101
     DISABLE(?ATL:U_NR)
     DISABLE(?ATL:KOMENTARS)
     UNHIDE(?ATL_HIDDEN)
     IF ATL:HIDDEN
        ?ATL_HIDDEN{PROP:TEXT}='Aktîva'
     .
  .
  IF COPYREQUEST=1
     CLEAR(ATS:RECORD)
     ATS:U_NR=ATL_U_NR
     SET(ATS:NR_KEY,ATS:NR_KEY)
     LOOP
        NEXT(ATL_S)
        IF ERROR() OR ~(ATS:U_NR=ATL_U_NR) THEN BREAK.
        AT:U_NR     =ATL:U_NR
        AT:NOMENKLAT=ATS:NOMENKLAT
        AT:ATL_PROC =ATS:ATL_PROC
        ADD(AT_TABLE)
     .
     CLEAR(ATS:RECORD)
     GET(AT_TABLE,0)
     LOOP I#= 1 TO RECORDS(AT_TABLE)
        GET(AT_TABLE,I#)
        ATS:U_NR=AT:U_NR
        ATS:NOMENKLAT=AT:NOMENKLAT
        ATS:ATL_PROC =AT:ATL_PROC
        ATS:ACC_KODS =ACC_KODS
        ATS:ACC_DATUMS=TODAY()
        ADD(ATL_S)
     .
     FREE(AT_TABLE)
  .
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
  END
  QuickWindow{Prop:Text} = ActionMessage
  CASE LocalRequest
  OF ChangeRecord OROF DeleteRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (' & CLIP(ATL:U_NR) & ')'
  OF InsertRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (New)'
  END
  ENABLE(TBarBrwHistory)
  ACCEPT
    CASE LOCALREQUEST
    OF 1
       IF RECORDS(Queue:Browse:2)
          DISABLE(?CANCEL)
          ALIAS(EscKey,0) ! Novâcam EscKey
       ELSIF RECORDS(Queue:Browse:2)=0
          ENABLE(?CANCEL)
          ALIAS
       .
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
      DO BRW2::AssignButtons
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?ATL:U_NR:Prompt)
      IF LOCALREQUEST=3
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-2)
         enable(?Tab:1)  !ATVÇRT CURRENTTAB NEDRÎKST
         SELECT(?cancel)
      ELSIF LOCALREQUEST=2
         SELECT(?Browse:2)
      ELSIF LOCALREQUEST=0
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-1)
         enable(?Tab:1)
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
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
      IF ACCEPTED() = TbarBrwHistory
        DO HistoryField
      END
      IF EVENT() = Event:Completed
        History::ATL:Record = ATL:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(ATL_K)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(ATL:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'ATL:NR_KEY')
                SELECT(?ATL:U_NR:Prompt)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?ATL:U_NR:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::ATL:Record <> ATL:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:ATL_K(1)
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
              SELECT(?ATL:U_NR:Prompt)
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
    OF ?ATL:U_NR
      CASE EVENT()
      OF EVENT:Accepted
        IF ATL:U_NR < 101
          IF StandardWarning(Warn:OutOfRangeLow,'ATL:U_NR','101')
            SELECT(?ATL:U_NR)
            QuickWindow{Prop:AcceptAll} = False
            CYCLE
          END
        END
      END
    OF ?ATL_HIDDEN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         IF ATL:HIDDEN
            ATL:HIDDEN = 0
            ?ATL_HIDDEN{PROP:TEXT}='Atslçgta'
         ELSE
            ATL:HIDDEN = 1
            ?ATL_HIDDEN{PROP:TEXT}='Aktîva'
         .
         DISPLAY
      END
    OF ?ATL:KOMENTARS
      CASE EVENT()
      OF EVENT:Accepted
        ATL:NOS_A=INIGEN(ATL:KOMENTARS,7,1)
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
            DO BRW2::AssignButtons
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?Browse:2
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW2::NewSelection
      OF EVENT:ScrollUp
        DO BRW2::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW2::ProcessScroll
      OF EVENT:PageUp
        DO BRW2::ProcessScroll
      OF EVENT:PageDown
        DO BRW2::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW2::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW2::ProcessScroll
      OF EVENT:AlertKey
        DO BRW2::AlertKey
      OF EVENT:ScrollDrag
        DO BRW2::ScrollDrag
      END
    OF ?Insert:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW2::ButtonInsert
      END
    OF ?Change:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW2::ButtonChange
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW2::ButtonDelete
      END
    OF ?MATLPROCV
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPEN(ATLSCREEN)
        JB#=0
        ATL_PROC_OLD=ATS:ATL_PROC
        DISPLAY
        ACCEPT
           case field()
           OF ?OK:A
              case event()
              of event:accepted
                 CLEAR(ATS:RECORD)
                 ATS:U_NR=ATL:U_NR
                 SET(ATS:NR_KEY,ATS:NR_KEY)
                 LOOP
                    NEXT(ATL_S)
                    IF ERROR() OR ~(ATS:U_NR=ATL:U_NR) THEN BREAK.
                    IF ~(ATS:ATL_PROC=ATL_PROC_OLD) THEN CYCLE.
                    JB#+=1
                    DISPLAY(?JB#)
                    ATS:ATL_PROC=ATL_PROC_NEW
                    IF RIUPDATE:ATL_S()
                       KLUDA(24,'ALT_S')
                    .
                 .
                 BREAK
              .
           OF ?CANCEL:A
              case event()
              of event:accepted
                 BREAK
              .
           .
        .
        close(ATLSCREEN)
        IF JB#
           KLUDA(0,'Atrasti un mainîti '&CLIP(JB#)&' ieraksti',,1)
           BRW2::LocateMode = LocateOnEdit
           DO BRW2::LocateRecord
           DO BRW2::RefreshPage
           DO BRW2::InitializeBrowse
           DO BRW2::PostNewSelection
           SELECT(?Browse:2)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
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
        ATL:ACC_KODS = ACC_KODS
        ATL:ACC_DATUMS = TODAY()
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
  IF ATL_K::Used = 0
    CheckOpen(ATL_K,1)
  END
  ATL_K::Used += 1
  BIND(ATL:RECORD)
  IF ATL_S::Used = 0
    CheckOpen(ATL_S,1)
  END
  ATL_S::Used += 1
  BIND(ATS:RECORD)
  FilesOpened = True
  RISnap:ATL_K
  SAV::ATL:Record = ATL:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    ATL:ACC_KODS = ACC_KODS
    ATL:ACC_DATUMS = TODAY()
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:ATL_K()
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
  INIRestoreWindow('UpdateATL_K','winlats.INI')
  WinResize.Resize
  BRW2::AddQueue = True
  BRW2::RecordCount = 0
  BIND('BRW2::Sort1:Reset:ATL:U_NR',BRW2::Sort1:Reset:ATL:U_NR)
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?Browse:2{Prop:Alrt,255} = InsertKey
  ?Browse:2{Prop:Alrt,254} = DeleteKey
  ?Browse:2{Prop:Alrt,253} = CtrlEnter
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?ATL:U_NR{PROP:Alrt,255} = 734
  ?ATL:KOMENTARS{PROP:Alrt,255} = 734
  ?ATL:NOS_A{PROP:Alrt,255} = 734
  ?ATL:ATL_PROC_PA{PROP:Alrt,255} = 734
  ?ATL:ACC_KODS{PROP:Alrt,255} = 734
  ?ATL:ACC_DATUMS{PROP:Alrt,255} = 734
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
    ATL_K::Used -= 1
    IF ATL_K::Used = 0 THEN CLOSE(ATL_K).
    ATL_S::Used -= 1
    IF ATL_S::Used = 0 THEN CLOSE(ATL_S).
  END
  IF WindowOpened
    INISaveWindow('UpdateATL_K','winlats.INI')
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
  DO BRW2::SelectSort
  ?Browse:2{Prop:VScrollPos} = BRW2::CurrentScroll
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW2::GetRecord
!---------------------------------------------------------------------------
!----------------------------------------------------------------------
BRW2::SelectSort ROUTINE
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
!|    f. The BrowseBox is reinitialized (BRW2::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW2::LastSortOrder = BRW2::SortOrder
  BRW2::Changed = False
  IF BRW2::SortOrder = 0
    BRW2::SortOrder = 1
  END
  IF BRW2::SortOrder = BRW2::LastSortOrder
    CASE BRW2::SortOrder
    OF 1
      IF BRW2::Sort1:Reset:ATL:U_NR <> ATL:U_NR
        BRW2::Changed = True
      END
    END
  ELSE
  END
  IF BRW2::SortOrder <> BRW2::LastSortOrder OR BRW2::Changed OR ForceRefresh
    CASE BRW2::SortOrder
    OF 1
      BRW2::Sort1:Reset:ATL:U_NR = ATL:U_NR
    END
    DO BRW2::GetRecord
    DO BRW2::Reset
    IF BRW2::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW2::LocateMode = LocateOnValue
        DO BRW2::LocateRecord
      ELSE
        FREE(Queue:Browse:2)
        BRW2::RefreshMode = RefreshOnTop
        DO BRW2::RefreshPage
        DO BRW2::PostNewSelection
      END
    ELSE
      IF BRW2::Changed
        FREE(Queue:Browse:2)
        BRW2::RefreshMode = RefreshOnTop
        DO BRW2::RefreshPage
        DO BRW2::PostNewSelection
      ELSE
        BRW2::LocateMode = LocateOnValue
        DO BRW2::LocateRecord
      END
    END
    IF BRW2::RecordCount
      GET(Queue:Browse:2,BRW2::CurrentChoice)
      DO BRW2::FillBuffer
    END
    DO BRW2::InitializeBrowse
  ELSE
    IF BRW2::RecordCount
      GET(Queue:Browse:2,BRW2::CurrentChoice)
      DO BRW2::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW2::InitializeBrowse ROUTINE
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
  DO BRW2::Reset
  RAKSTI=0
  LOOP
    NEXT(BRW2::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW2::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'ATL_S')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW2::FillQueue
    RAKSTI+=1
  END
  SETCURSOR()
  DO BRW2::Reset
  PREVIOUS(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'ATL_S')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 1
    BRW2::Sort1:HighValue = ATS:NOMENKLAT
  END
  DO BRW2::Reset
  NEXT(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'ATL_S')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 1
    BRW2::Sort1:LowValue = ATS:NOMENKLAT
    SetupStringStops(BRW2::Sort1:LowValue,BRW2::Sort1:HighValue,SIZE(BRW2::Sort1:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW2::ScrollRecordCount = 1 TO 100
      BRW2::Sort1:KeyDistribution[BRW2::ScrollRecordCount] = NextStringStop()
    END
  END
!----------------------------------------------------------------------
BRW2::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  ATS:NOMENKLAT = BRW2::ATS:NOMENKLAT
  ATS:ATL_PROC = BRW2::ATS:ATL_PROC
  ATS:ACC_KODS = BRW2::ATS:ACC_KODS
  ATS:ACC_DATUMS = BRW2::ATS:ACC_DATUMS
  ATS:U_NR = BRW2::ATS:U_NR
!----------------------------------------------------------------------
BRW2::FillQueue ROUTINE
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
  BRW2::ATS:NOMENKLAT = ATS:NOMENKLAT
  BRW2::ATS:ATL_PROC = ATS:ATL_PROC
  BRW2::ATS:ACC_KODS = ATS:ACC_KODS
  BRW2::ATS:ACC_DATUMS = ATS:ACC_DATUMS
  BRW2::ATS:U_NR = ATS:U_NR
  BRW2::Position = POSITION(BRW2::View:Browse)
!----------------------------------------------------------------------
BRW2::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW2::NewSelectPosted
    BRW2::NewSelectPosted = True
    POST(Event:NewSelection,?Browse:2)
  END
!----------------------------------------------------------------------
BRW2::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW2::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW2::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW2::PopupText = ''
    IF BRW2::RecordCount
      IF BRW2::PopupText
        BRW2::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW2::PopupText
      ELSE
        BRW2::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
      IF BRW2::PopupText
        BRW2::PopupText = '&Ievadît|~&Mainît|~&Dzçst|-|' & BRW2::PopupText
      ELSE
        BRW2::PopupText = '&Ievadît|~&Mainît|~&Dzçst'
      END
    END
    EXECUTE(POPUP(BRW2::PopupText))
      POST(Event:Accepted,?Insert:3)
      POST(Event:Accepted,?Change:3)
      POST(Event:Accepted,?Delete:3)
    END
  ELSIF BRW2::RecordCount
    BRW2::CurrentChoice = CHOICE(?Browse:2)
    GET(Queue:Browse:2,BRW2::CurrentChoice)
    DO BRW2::FillBuffer
    IF BRW2::RecordCount = ?Browse:2{Prop:Items}
      IF ?Browse:2{Prop:VScroll} = False
        ?Browse:2{Prop:VScroll} = True
      END
      CASE BRW2::SortOrder
      OF 1
        LOOP BRW2::CurrentScroll = 1 TO 100
          IF BRW2::Sort1:KeyDistribution[BRW2::CurrentScroll] => UPPER(ATS:NOMENKLAT)
            IF BRW2::CurrentScroll <= 1
              BRW2::CurrentScroll = 0
            ELSIF BRW2::CurrentScroll = 100
              BRW2::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:2{Prop:VScroll} = True
        ?Browse:2{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW2::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW2::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW2::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW2::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW2::RecordCount
    BRW2::CurrentEvent = EVENT()
    CASE BRW2::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW2::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW2::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW2::ScrollEnd
    END
    ?Browse:2{Prop:SelStart} = BRW2::CurrentChoice
    DO BRW2::PostNewSelection
  END
!----------------------------------------------------------------------
BRW2::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW2::FillRecord to retrieve one record in the direction required.
!|
  IF BRW2::CurrentEvent = Event:ScrollUp AND BRW2::CurrentChoice > 1
    BRW2::CurrentChoice -= 1
    EXIT
  ELSIF BRW2::CurrentEvent = Event:ScrollDown AND BRW2::CurrentChoice < BRW2::RecordCount
    BRW2::CurrentChoice += 1
    EXIT
  END
  BRW2::ItemsToFill = 1
  BRW2::FillDirection = BRW2::CurrentEvent - 2
  DO BRW2::FillRecord
!----------------------------------------------------------------------
BRW2::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW2::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW2::FillRecord doesn't fill a page (BRW2::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW2::ItemsToFill = ?Browse:2{Prop:Items}
  BRW2::FillDirection = BRW2::CurrentEvent - 4
  DO BRW2::FillRecord                           ! Fill with next read(s)
  IF BRW2::ItemsToFill
    IF BRW2::CurrentEvent = Event:PageUp
      BRW2::CurrentChoice -= BRW2::ItemsToFill
      IF BRW2::CurrentChoice < 1
        BRW2::CurrentChoice = 1
      END
    ELSE
      BRW2::CurrentChoice += BRW2::ItemsToFill
      IF BRW2::CurrentChoice > BRW2::RecordCount
        BRW2::CurrentChoice = BRW2::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW2::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW2::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse:2)
  BRW2::RecordCount = 0
  DO BRW2::Reset
  BRW2::ItemsToFill = ?Browse:2{Prop:Items}
  IF BRW2::CurrentEvent = Event:ScrollTop
    BRW2::FillDirection = FillForward
  ELSE
    BRW2::FillDirection = FillBackward
  END
  DO BRW2::FillRecord                           ! Fill with next read(s)
  IF BRW2::CurrentEvent = Event:ScrollTop
    BRW2::CurrentChoice = 1
  ELSE
    BRW2::CurrentChoice = BRW2::RecordCount
  END
!----------------------------------------------------------------------
BRW2::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW2::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW2::LocateRecord.
!|
  IF BRW2::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
      POST(Event:Accepted,?Change:3)
      DO BRW2::FillBuffer
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
  DO BRW2::PostNewSelection
!----------------------------------------------------------------------
BRW2::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW2::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW2::LocateRecord.
!|
  IF ?Browse:2{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:2)
  ELSIF ?Browse:2{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:2)
  ELSE
    CASE BRW2::SortOrder
    OF 1
      ATS:NOMENKLAT = BRW2::Sort1:KeyDistribution[?Browse:2{Prop:VScrollPos}]
      BRW2::LocateMode = LocateOnValue
      DO BRW2::LocateRecord
    END
  END
!----------------------------------------------------------------------
BRW2::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW2::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW2::ItemsToFill records. Normally, this will
!| result in BRW2::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW2::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW2::AddQueue is true, the queue is filled using the BRW2::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW2::AddQueue is false is when the BRW2::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW2::RecordCount
    IF BRW2::FillDirection = FillForward
      GET(Queue:Browse:2,BRW2::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:2,1)                       ! Get the first queue item
    END
    RESET(BRW2::View:Browse,BRW2::Position)       ! Reset for sequential processing
    BRW2::SkipFirst = TRUE
  ELSE
    BRW2::SkipFirst = FALSE
  END
  LOOP WHILE BRW2::ItemsToFill
    IF BRW2::FillDirection = FillForward
      NEXT(BRW2::View:Browse)
    ELSE
      PREVIOUS(BRW2::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW2::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'ATL_S')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW2::SkipFirst
       BRW2::SkipFirst = FALSE
       IF POSITION(BRW2::View:Browse)=BRW2::Position
          CYCLE
       END
    END
    IF BRW2::AddQueue
      IF BRW2::RecordCount = ?Browse:2{Prop:Items}
        IF BRW2::FillDirection = FillForward
          GET(Queue:Browse:2,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:2,BRW2::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:2)
        BRW2::RecordCount -= 1
      END
      DO BRW2::FillQueue
      IF BRW2::FillDirection = FillForward
        ADD(Queue:Browse:2)
      ELSE
        ADD(Queue:Browse:2,1)
      END
      BRW2::RecordCount += 1
    END
    BRW2::ItemsToFill -= 1
  END
  BRW2::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW2::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW2::LocateMode. These modes are...
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
!| If an appropriate record has been located, the BRW2::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW2::LocateMode = LocateOnPosition
    BRW2::LocateMode = LocateOnEdit
  END
  CLOSE(BRW2::View:Browse)
  CASE BRW2::SortOrder
  OF 1
    IF BRW2::LocateMode = LocateOnEdit
      BRW2::HighlightedPosition = POSITION(ATS:NR_KEY)
      RESET(ATS:NR_KEY,BRW2::HighlightedPosition)
    ELSE
      ATS:U_NR = ATL:U_NR
      SET(ATS:NR_KEY,ATS:NR_KEY)
    END
    BRW2::View:Browse{Prop:Filter} = |
    'ATS:U_NR = BRW2::Sort1:Reset:ATL:U_NR'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW2::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:2)
  BRW2::RecordCount = 0
  BRW2::ItemsToFill = 1
  BRW2::FillDirection = FillForward               ! Fill with next read(s)
  BRW2::AddQueue = False
  DO BRW2::FillRecord                             ! Fill with next read(s)
  BRW2::AddQueue = True
  IF BRW2::ItemsToFill
    BRW2::RefreshMode = RefreshOnBottom
    DO BRW2::RefreshPage
  ELSE
    BRW2::RefreshMode = RefreshOnPosition
    DO BRW2::RefreshPage
  END
  DO BRW2::PostNewSelection
  BRW2::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW2::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW2::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse:2), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW2::RefreshMode = RefreshOnPosition
    BRW2::HighlightedPosition = POSITION(BRW2::View:Browse)
    RESET(BRW2::View:Browse,BRW2::HighlightedPosition)
    BRW2::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:2)
    GET(Queue:Browse:2,BRW2::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:2,RECORDS(Queue:Browse:2))
    END
    BRW2::HighlightedPosition = BRW2::Position
    GET(Queue:Browse:2,1)
    RESET(BRW2::View:Browse,BRW2::Position)
    BRW2::RefreshMode = RefreshOnCurrent
  ELSE
    BRW2::HighlightedPosition = ''
    DO BRW2::Reset
  END
  FREE(Queue:Browse:2)
  BRW2::RecordCount = 0
  BRW2::ItemsToFill = ?Browse:2{Prop:Items}
  IF BRW2::RefreshMode = RefreshOnBottom
    BRW2::FillDirection = FillBackward
  ELSE
    BRW2::FillDirection = FillForward
  END
  DO BRW2::FillRecord                             ! Fill with next read(s)
  IF BRW2::HighlightedPosition
    IF BRW2::ItemsToFill
      IF NOT BRW2::RecordCount
        DO BRW2::Reset
      END
      IF BRW2::RefreshMode = RefreshOnBottom
        BRW2::FillDirection = FillForward
      ELSE
        BRW2::FillDirection = FillBackward
      END
      DO BRW2::FillRecord
    END
  END
  IF BRW2::RecordCount
    IF BRW2::HighlightedPosition
      LOOP BRW2::CurrentChoice = 1 TO BRW2::RecordCount
        GET(Queue:Browse:2,BRW2::CurrentChoice)
        IF BRW2::Position = BRW2::HighlightedPosition THEN BREAK.
      END
      IF BRW2::CurrentChoice > BRW2::RecordCount
        BRW2::CurrentChoice = BRW2::RecordCount
      END
    ELSE
      IF BRW2::RefreshMode = RefreshOnBottom
        BRW2::CurrentChoice = RECORDS(Queue:Browse:2)
      ELSE
        BRW2::CurrentChoice = 1
      END
    END
    ?Browse:2{Prop:Selected} = BRW2::CurrentChoice
    DO BRW2::FillBuffer
    ?Change:3{Prop:Disable} = 0
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(ATS:Record)
    BRW2::CurrentChoice = 0
    ?Change:3{Prop:Disable} = 1
    ?Delete:3{Prop:Disable} = 1
  END
  SETCURSOR()
  BRW2::RefreshMode = 0
  EXIT
BRW2::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW2::View:Browse)
  CASE BRW2::SortOrder
  OF 1
    ATS:U_NR = ATL:U_NR
    SET(ATS:NR_KEY)
    BRW2::View:Browse{Prop:Filter} = |
    'ATS:U_NR = BRW2::Sort1:Reset:ATL:U_NR'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW2::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW2::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW2::RecordCount
    BRW2::CurrentChoice = CHOICE(?Browse:2)
    GET(Queue:Browse:2,BRW2::CurrentChoice)
    WATCH(BRW2::View:Browse)
    REGET(BRW2::View:Browse,BRW2::Position)
  END
!----------------------------------------------------------------------
BRW2::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
  CASE BRW2::SortOrder
  OF 1
    ATL:U_NR = BRW2::Sort1:Reset:ATL:U_NR
  END
BRW2::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:2
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
  IF FOCUS() <> BrowseButtons.ListBox THEN  ! List box must have focus when on update form
    EXIT
  END
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
  IF FOCUS() <> BrowseButtons.ListBox THEN  ! List box must have focus when on update form
    EXIT
  END
  IF INRANGE(ACCEPTED(),TBarBrwInsert,TBarBrwDelete) THEN         !trap remote browse update control calls
    EXECUTE(ACCEPTED()-TBarBrwInsert+1)
      POST(EVENT:ACCEPTED,BrowseButtons.InsertButton)
      POST(EVENT:ACCEPTED,BrowseButtons.ChangeButton)
      POST(EVENT:ACCEPTED,BrowseButtons.DeleteButton)
    END
  END
!----------------------------------------------------------------
BRW2::ButtonInsert ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to insert a new record.
!|
!| First, the primary file's record  buffer is cleared, as well as any memos
!| or BLOBs. Next, any range-limit values are restored so that the inserted
!| record defaults to being added to the current display set.
!|
!| Next, LocalRequest is set to InsertRecord, and the BRW2::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the insert is successful (GlobalRequest = RequestCompleted) then the newly added
!| record is displayed in the BrowseBox, at the top of the listbox.
!|
!| If the insert is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  GET(ATL_S,0)
  CLEAR(ATS:Record,0)
  CASE BRW2::SortOrder
  OF 1
    ATS:U_NR = BRW2::Sort1:Reset:ATL:U_NR
  END
  LocalRequest = InsertRecord
  DO BRW2::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW2::LocateMode = LocateOnEdit
    DO BRW2::LocateRecord
  ELSE
    BRW2::RefreshMode = RefreshOnQueue
    DO BRW2::RefreshPage
  END
  DO BRW2::InitializeBrowse
  DO BRW2::PostNewSelection
  SELECT(?Browse:2)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW2::ButtonChange ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to change a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW2::GetRecord routine.
!|
!| First, LocalRequest is set to ChangeRecord, and the BRW2::CallRecord routine
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
  DO BRW2::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW2::LocateMode = LocateOnEdit
    DO BRW2::LocateRecord
  ELSE
    BRW2::RefreshMode = RefreshOnQueue
    DO BRW2::RefreshPage
  END
  DO BRW2::InitializeBrowse
  DO BRW2::PostNewSelection
  SELECT(?Browse:2)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW2::ButtonDelete ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to delete a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW2::GetRecord routine.
!|
!| First, LocalRequest is set to DeleteRecord, and the BRW2::CallRecord routine
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
  DO BRW2::CallUpdate
  IF GlobalResponse = RequestCompleted
    DELETE(Queue:Browse:2)
    BRW2::RecordCount -= 1
  END
  BRW2::RefreshMode = RefreshOnQueue
  DO BRW2::RefreshPage
  DO BRW2::InitializeBrowse
  DO BRW2::PostNewSelection
  SELECT(?Browse:2)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW2::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdateATL_S) is called.
!|
!| Upon return from the update, the routine BRW2::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW2::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateATL_S
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
        GET(ATL_S,0)
        CLEAR(ATS:Record,0)
      ELSE
        DO BRW2::PostVCREdit1
        BRW2::CurrentEvent=Event:ScrollDown
        DO BRW2::ScrollOne
        DO BRW2::PostVCREdit2
      END
    OF VCRBackward
      DO BRW2::PostVCREdit1
      BRW2::CurrentEvent=Event:ScrollUp
      DO BRW2::ScrollOne
      DO BRW2::PostVCREdit2
    OF VCRPageForward
      DO BRW2::PostVCREdit1
      BRW2::CurrentEvent=Event:PageDown
      DO BRW2::ScrollPage
      DO BRW2::PostVCREdit2
    OF VCRPageBackward
      DO BRW2::PostVCREdit1
      BRW2::CurrentEvent=Event:PageUp
      DO BRW2::ScrollPage
      DO BRW2::PostVCREdit2
    OF VCRFirst
      DO BRW2::PostVCREdit1
      BRW2::CurrentEvent=Event:ScrollTop
      DO BRW2::ScrollEnd
      DO BRW2::PostVCREdit2
    OF VCRLast
      DO BRW2::PostVCREdit1
      BRW2::CurrentEvent=Event:ScrollBottom
      DO BRW2::ScrollEND
      DO BRW2::PostVCREdit2
    END
  END
  DO BRW2::Reset

BRW2::PostVCREdit1 ROUTINE
  DO BRW2::Reset
  BRW2::LocateMode=LocateOnEdit
  DO BRW2::LocateRecord
  DO RefreshWindow

BRW2::PostVCREdit2 ROUTINE
  ?Browse:2{PROP:SelStart}=BRW2::CurrentChoice
  DO BRW2::NewSelection
  REGET(BRW2::View:Browse,BRW2::Position)
  CLOSE(BRW2::View:Browse)

!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?ATL:U_NR
      ATL:U_NR = History::ATL:Record.U_NR
    OF ?ATL:KOMENTARS
      ATL:KOMENTARS = History::ATL:Record.KOMENTARS
    OF ?ATL:NOS_A
      ATL:NOS_A = History::ATL:Record.NOS_A
    OF ?ATL:ATL_PROC_PA
      ATL:ATL_PROC_PA = History::ATL:Record.ATL_PROC_PA
    OF ?ATL:ACC_KODS
      ATL:ACC_KODS = History::ATL:Record.ACC_KODS
    OF ?ATL:ACC_DATUMS
      ATL:ACC_DATUMS = History::ATL:Record.ACC_DATUMS
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
  ATL:Record = SAV::ATL:Record
  SAV::ATL:Record = ATL:Record
  Auto::Attempts = 0
  LOOP
    SET(ATL:NR_KEY)
    PREVIOUS(ATL_K)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'ATL_K')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:ATL:U_NR = 1
    ELSE
      Auto::Save:ATL:U_NR = ATL:U_NR + 1
    END
    ATL:Record = SAV::ATL:Record
    ATL:U_NR = Auto::Save:ATL:U_NR
    SAV::ATL:Record = ATL:Record
    ADD(ATL_K)
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
        DELETE(ATL_K)
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

BrowseAtl_k PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
RAKSTI         ULONG
Izlaisti       ULONG
SPIEDIET       STRING(40)

INETscreen WINDOW('Interneta faila sagatavoðana'),AT(,,251,86),CENTER,GRAY
       STRING('Tiks izveidots FTP fails '),AT(9,13),USE(?Stringftp)
       STRING(@s50),AT(87,12,168,10),USE(ANSIFILENAME),LEFT(2)
       STRING('Ierakstîti:'),AT(56,34),USE(?StringIERI)
       STRING(@n7B),AT(96,34),USE(raksti,,?RAKSTII)
       STRING('Izlaisti:'),AT(62,43),USE(?StringIZLI)
       STRING(@n7B),AT(96,43),USE(izlaisti,,?IZLAISTII)
       STRING(@s40),AT(27,56),USE(SPIEDIET,,?SPIEDIETI)
       STRING(@s45),AT(48,24),USE(ATL:KOMENTARS),HIDE
       BUTTON('&OK'),AT(161,69,43,14),USE(?Ok:I),DEFAULT
       BUTTON('&Atlikt'),AT(207,69,43,14),USE(?Cancel:I),DEFAULT
     END


BRW1::View:Browse    VIEW(ATL_K)
                       PROJECT(ATL:HIDDEN)
                       PROJECT(ATL:U_NR)
                       PROJECT(ATL:KOMENTARS)
                       PROJECT(ATL:NOS_A)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::ATL:HIDDEN       LIKE(ATL:HIDDEN)           ! Queue Display field
BRW1::ATL:U_NR         LIKE(ATL:U_NR)             ! Queue Display field
BRW1::ATL:KOMENTARS    LIKE(ATL:KOMENTARS)        ! Queue Display field
BRW1::ATL:NOS_A        LIKE(ATL:NOS_A)            ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort2:KeyDistribution LIKE(ATL:U_NR),DIM(100)
BRW1::Sort2:LowValue LIKE(ATL:U_NR)               ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(ATL:U_NR)              ! Queue position of scroll thumb
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
QuickWindow          WINDOW('ATL_K.TPS'),AT(,,235,275),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseATLAIDES'),SYSTEM,GRAY,RESIZE
                       MENUBAR
                         MENU('5-Speciâlâs funkcjas'),USE(?5Specialasfunkcjas)
                           ITEM('4-Uzbûvçt i-net failu'),USE(?5SpecialasfunkcijasINET),DISABLE
                           ITEM('Lasît ATL_K.TXT'),USE(?5Specialasfunkcjas5),DISABLE
                         END
                       END
                       LIST,AT(7,20,215,210),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('10R(2)|M~H~C(0)@n1b@25R(2)|M~Nr~C(0)@n6@80L(2)|M~Komentârs~@s50@'),FROM(Queue:Browse:1)
                       BUTTON('&Ievadît'),AT(81,234,45,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(129,234,45,14),USE(?Change),DEFAULT
                       BUTTON('&Dzçst'),AT(176,234,45,14),USE(?Delete:2)
                       BUTTON('&C-Kopçt'),AT(81,255,45,14),USE(?ButtonCopy)
                       BUTTON('Iz&vçlçties'),AT(129,255,45,14),USE(?Select),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                       SHEET,AT(4,4,223,247),USE(?CurrentTab)
                         TAB('Numuru secîbâ'),USE(?Tab2)
                           ENTRY(@n6),AT(10,234),USE(ATL:U_NR)
                           STRING('-pçc Nr'),AT(47,236,28,10),USE(?String1)
                         END
                         TAB('Nosaukumu secîbâ'),USE(?Tab3)
                           ENTRY(@s7),AT(8,234,37,12),USE(ATL:NOS_A)
                           STRING('- pçc Nos.'),AT(46,236),USE(?String2)
                         END
                       END
                       BUTTON('&Beigt'),AT(176,255,45,14),USE(?Close)
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
  !*******USER LEVEL ACCESS CONTROL********
  IF BAND(REG_NOL_ACC,01000000b) OR| !I-NETS
     ACC_KODS_N=0
     ENABLE(?5SpecialasfunkcijasINET)
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
      ?5SpecialasfunkcijasINET{PROP:TEXT}='&4-Uzbûvçt '&CLIP(LONGPATH())&'\INET\ATL_K.TXT'
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
    OF ?5SpecialasfunkcijasINET
      DO SyncWindow
            RAKSTI=0
            IZLAISTI=0
            SPIEDIET=''
            KLU_DARBIBA=0 !OTRÂDI-PÂRBÛVÇT
            ANSIFILENAME=CLIP(LONGPATH())&'\INET\ATL.TXT'
            DATE#=DOS_CONT(ANSIFILENAME,1)
            IF DATE#
               KLUDA(0,'fails '&clip(ANSIFILENAME)&' jau ir izveidots '&FORMAT(DATE#,@D06.),12,1)
            .
            IF ~KLU_DARBIBA
               OPEN(INETSCREEN)
               DISPLAY
               ACCEPT
                  CASE field()
                  OF ?OK:I
                     case event()
                     of event:accepted
                        HIDE(?OK:I)
                        HIDE(?CANCEL:I)
                        UNHIDE(?ATL:KOMENTARS)
                        DISPLAY
                        IF ~OPENANSI(ANSIFILENAME,1)
                           POST(Event:CloseWindow)
                           CYCLE
                        .
                        OUTA:LINE='Lapas Nr'&CHR(9)&'Nosaukums/Nomenklatûru filtri'&CHR(9)&'Atlaides %'
                        ADD(OUTFILEANSI)
                        CLEAR(ATL:RECORD)
               !         STREAM(ATL_K)
                        SET(ATL:NR_KEY)
                        LOOP
                           NEXT(ATL_K)
                           DISPLAY
                           IF ERROR() THEN BREAK.
                           OUTA:LINE=ATL:U_NR&CHR(9)&ATL:KOMENTARS&CHR(9)&LEFT(FORMAT(ATL:ATL_PROC_PA,@N_5.1))
                           ADD(OUTFILEANSI)
                           CLEAR(ATS:RECORD)
                           ATS:U_NR=ATL:U_NR
                           SET(ATS:NR_KEY,ATS:NR_KEY)
                           LOOP
                              NEXT(ATL_S)
                              IF ERROR() OR ~(ATS:U_NR=ATL:U_NR) THEN BREAK.
                              OUTA:LINE=CHR(9)&ATS:NOMENKLAT&CHR(9)&LEFT(FORMAT(ATS:ATL_PROC,@N_5.1))
                              ADD(OUTFILEANSI)
                              RAKSTI+=1
                           .
                        .
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
      !      IF RAKSTI
               F:DBF='E'   !APSKATAM EXCELÎ
               ANSIJOB
      !      .
    OF ?5Specialasfunkcjas5
      DO SyncWindow
      TTAKA"=PATH()
      ANSIFILENAME='C:\WINLATS\'&CLIP(ACC_KODS)
      SETPATH(ANSIFILENAME)
      IF FILEDIALOG('...TIKAI atl_k..txt FAILI !!!',ANSIFILENAME,'TXT|Atl_k*.txt',0)
          SETPATH(TTAKA")
          CHECKOPEN(OUTFILEANSI,1)
          RAKSTI#=0
          IF ATL_S::USED=0
             CHECKOPEN(ATL_S,1)
          .
          ATL_S::USED+=1
          SET(OUTFILEANSI)
          LOOP
             NEXT(OUTFILEANSI)
             IF ERROR() THEN BREAK.
             RAKSTI#+=1
!             ATL:U_NR=ATL_U_NR
!             ATL:KOMENTARS=ATL_KOMENTARS
!             ATL:ATL_PROC_PA=ATL_ATL_PROC_PA
             IF RAKSTI#=1
                ADD(ATL_K)
                IF ERROR()
                   KLUDA(24,'ATL_K '&ERROR())
                   BREAK
                .
             .
             ATS:U_NR=ATL:U_NR
!             ATS:NOMENKLAT=ATS_NOMENKLAT
!             ATS:ATL_PROC=ATS_ATL_PROC
             ADD(ATL_S)
          .
          KLUDA(99,'un pârrakstîtas '&CLIP(RAKSTI#)&' nomenklatûru definîcijas')
          ATL_S::USED-=1
          IF ATL_S::USED=0 THEN CLOSE(ATL_S).
          CLOSE(OUTFILEANSI)
          BRW1::LocateMode = LocateOnEdit
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          POST(Event:NewSelection)
       ELSE
          SETPATH(TTAKA")
       .
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
    OF ?ButtonCopy
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
    OF ?ATL:U_NR
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?ATL:U_NR)
        IF ATL:U_NR
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort2:LocatorValue = ATL:U_NR
          BRW1::Sort2:LocatorLength = LEN(CLIP(ATL:U_NR))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?ATL:NOS_A
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?ATL:NOS_A)
        IF ATL:NOS_A
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = ATL:NOS_A
          BRW1::Sort1:LocatorLength = LEN(CLIP(ATL:NOS_A))
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
  IF ATL_K::Used = 0
    CheckOpen(ATL_K,1)
  END
  ATL_K::Used += 1
  BIND(ATL:RECORD)
  IF ATL_S::Used = 0
    CheckOpen(ATL_S,1)
  END
  ATL_S::Used += 1
  BIND(ATS:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseAtl_k','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
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
    ATL_K::Used -= 1
    IF ATL_K::Used = 0 THEN CLOSE(ATL_K).
    ATL_S::Used -= 1
    IF ATL_S::Used = 0 THEN CLOSE(ATL_S).
  END
  IF WindowOpened
    INISaveWindow('BrowseAtl_k','winlats.INI')
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
    ATL:NOS_A = BRW1::Sort1:LocatorValue
  OF 2
    ATL:U_NR = BRW1::Sort2:LocatorValue
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
  IF CHOICE(?CurrentTab)=2
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
      ATL:NOS_A = BRW1::Sort1:LocatorValue
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      ATL:U_NR = BRW1::Sort2:LocatorValue
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
      StandardWarning(Warn:RecordFetchError,'ATL_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:HighValue = ATL:U_NR
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'ATL_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:LowValue = ATL:U_NR
    SetupRealStops(BRW1::Sort2:LowValue,BRW1::Sort2:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort2:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  ATL:HIDDEN = BRW1::ATL:HIDDEN
  ATL:U_NR = BRW1::ATL:U_NR
  ATL:KOMENTARS = BRW1::ATL:KOMENTARS
  ATL:NOS_A = BRW1::ATL:NOS_A
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
  BRW1::ATL:HIDDEN = ATL:HIDDEN
  BRW1::ATL:U_NR = ATL:U_NR
  BRW1::ATL:KOMENTARS = ATL:KOMENTARS
  BRW1::ATL:NOS_A = ATL:NOS_A
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
      OF 2
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => ATL:U_NR
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
      ATL:NOS_A = BRW1::Sort1:LocatorValue
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      ATL:U_NR = BRW1::Sort2:LocatorValue
    END
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
        IF KEYCODE() = BSKey
          IF BRW1::Sort1:LocatorLength
            BRW1::Sort1:LocatorLength -= 1
            BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength)
            ATL:NOS_A = BRW1::Sort1:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          ATL:NOS_A = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          ATL:NOS_A = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            ATL:U_NR = BRW1::Sort2:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          ATL:U_NR = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          ATL:U_NR = BRW1::Sort2:LocatorValue
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
    OF 2
      ATL:U_NR = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'ATL_K')
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
      BRW1::HighlightedPosition = POSITION(ATL:NOS_KEY)
      RESET(ATL:NOS_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(ATL:NOS_KEY,ATL:NOS_KEY)
    END
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(ATL:NR_KEY)
      RESET(ATL:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(ATL:NR_KEY,ATL:NR_KEY)
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
    OF 1; ?ATL:NOS_A{Prop:Disable} = 0
    OF 2; ?ATL:U_NR{Prop:Disable} = 0
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
    CLEAR(ATL:Record)
    CASE BRW1::SortOrder
    OF 1; ?ATL:NOS_A{Prop:Disable} = 1
    OF 2; ?ATL:U_NR{Prop:Disable} = 1
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
    SET(ATL:NOS_KEY)
  OF 2
    SET(ATL:NR_KEY)
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
  GET(ATL_K,0)
  CLEAR(ATL:Record,0)
  LocalRequest = InsertRecord
  IF COPYREQUEST=1
     DO SYNCWINDOW
  .
  DO BRW1::CallUpdate
  copyrequest=0
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
!| (UpdateATL_K) is called.
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
    UpdateATL_K
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
        GET(ATL_K,0)
        CLEAR(ATL:Record,0)
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


UpdatePAR_K PROCEDURE


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
BAN_NOS              STRING(31)
BAN_NOS2             STRING(31)
par_atzime1          STRING(40)
par_atzime2          STRING(40)
RecordFiltered       LONG
ATLAIDETEXT          STRING(50)
PAR_START_U_NR       LONG
PAR_END_U_NR         ULONG
WLC                  STRING(45)
PAR_EMAIL            STRING(37)
SAV_U_NR        LIKE(PAR:U_NR)
SAV_ATZIME1     LIKE(PAR:ATZIME1)
SAV_ATZIME2     LIKE(PAR:ATZIME2)
SAV_kred_lim    LIKE(PAR:KRED_LIM)
SAV_REDZAMIBA   LIKE(PAR:REDZAMIBA)
SAV_RECORD      LIKE(PAR:RECORD)
SAVEPOSITION    STRING(260)
EXIST:PZP       BYTE
EXT             STRING(3)

RecordsProcessed     LONG
ProgressWindow WINDOW('Progress...'),AT(,,142,46),CENTER,TIMER(1),GRAY,DOUBLE
       STRING(''),AT(0,9,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,22,141,10),USE(?Progress:PctText),CENTER
     END
Update::Reloop  BYTE
Update::Error   BYTE
History::PAR:Record LIKE(PAR:Record),STATIC
SAV::PAR:Record      LIKE(PAR:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:PAR:U_NR     LIKE(PAR:U_NR)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
FLD7::View           VIEW(VAL_K)
                       PROJECT(VAL:V_KODS)
                     END
Queue:FileDrop:2     QUEUE,PRE
FLD7::VAL:V_KODS       LIKE(VAL:V_KODS)
                     END
FLD7::LoopIndex      LONG,AUTO
FLD5::View           VIEW(BANKAS_K)
                       PROJECT(BAN:KODS)
                       PROJECT(BAN:NOS_S)
                     END
Queue:FileDropCombo  QUEUE,PRE
FLD5::BAN:KODS         LIKE(BAN:KODS)
FLD5::BAN:NOS_S        LIKE(BAN:NOS_S)
                     END
FLD5::LoopIndex      LONG,AUTO
QuickWindow          WINDOW('Update the PAR_K File'),AT(,,435,297),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdatePAR_K'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(1,6,427,267),USE(?CurrentTab)
                         TAB('Pamatdat&i'),USE(?Tab:1)
                           STRING('1234567'),AT(71,37),USE(?String1234567),FONT('Fixedsys',9,COLOR:Gray,FONT:regular,CHARSET:BALTIC)
                           PROMPT('&Grupa:'),AT(42,26),USE(?PAR:GRUPA:Prompt)
                           ENTRY(@s7),AT(69,26,37,10),USE(PAR:GRUPA),FONT('Fixedsys',9,,FONT:regular,CHARSET:BALTIC),OVR,UPR
                           PROMPT('&Karte:'),AT(123,26),USE(?PAR:KARTE:Prompt)
                           ENTRY(@n7B),AT(146,26,40,10),USE(PAR:KARTE),RIGHT(1)
                           OPTION('&Tips'),AT(24,44,227,50),USE(PAR:TIPS),BOXED
                             RADIO('Eksternâls (Rezidents)'),AT(28,55),USE(?PAR:TIPS:Radio1),DISABLE
                             RADIO('Fiziska persona'),AT(28,68),USE(?PAR:TIPS:Radio2),DISABLE
                             RADIO('Citas valsts (ES)'),AT(28,81),USE(?PAR:TIPS:Radio3),DISABLE
                             RADIO('N-Citas valsts (nav ES)'),AT(133,55),USE(?PAR:TIPS:Radio4),DISABLE,VALUE('N')
                             RADIO('Internâla noliktava (U_Nr 1-25)'),AT(133,68,115,10),USE(?PAR:TIPS:Radio5),DISABLE
                             RADIO('Raþoðana (U_Nr 26-50)'),AT(133,81),USE(?PAR:TIPS:Radio6),DISABLE
                           END
                           OPTION('Statuss'),AT(324,23,50,41),USE(PAR:REDZAMIBA),BOXED
                             RADIO('1-Aktîvs'),AT(327,36),USE(?PAR:REDZAMIBA:Radio1),VALUE('1')
                             RADIO('A-Arhîvs'),AT(327,47),USE(?PAR:REDZAMIBA:2:Radio1:2),VALUE('A')
                           END
                           PROMPT('&NMR kods:'),AT(12,98,55,10),USE(?PAR:KODS:Prompt)
                           ENTRY(@S22),AT(72,98,99,10),USE(PAR:NMR_KODS),LEFT(1),OVR
                           STRING('+'),AT(173,98,6,10),USE(?StringPlus)
                           BUTTON('P&VN'),AT(10,110,56,14),USE(?PVN)
                           ENTRY(@s22),AT(72,112,99,10),USE(PAR:PVN),LEFT(1)
                           STRING('tukðs-nav PVN maksâtâjs'),AT(174,112),USE(?String13),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           PROMPT('Pilnais &nosaukums:'),AT(12,127),USE(?PAR:NOS_P:Prompt)
                           ENTRY(@s45),AT(95,127,222,10),USE(PAR:NOS_P),FONT(,,,FONT:bold),TIP('Labâ pele: mainît CASE'),REQ
                           PROMPT('&Saîsinâtais nosaukums:'),AT(12,140,76,10),USE(?PAR:NOS_S:Prompt)
                           ENTRY(@s15),AT(95,140,76,10),USE(PAR:NOS_S),REQ
                           STRING(@s12),AT(173,140,57,10),USE(PAR:NOS_A)
                           PROMPT('&Juridiskâ adrese:'),AT(12,158,58,10),USE(?PAR:ADRESE:Prompt)
                           ENTRY(@s60),AT(69,158,249,10),USE(PAR:ADRESE),TIP('Labâ pele: mainît CASE')
                           STRING('Valsts kods'),AT(323,158),USE(?String9)
                           BUTTON('&Filiâles/ILN'),AT(10,173,56,14),USE(?ButtonAdreses)
                           IMAGE('CHECK3.ICO'),AT(69,172,14,17),USE(?Imageadreses),HIDE
                           PROMPT('Kont.&pers,amats:'),AT(12,195),USE(?PAR:KONTAKTS:Prompt)
                           ENTRY(@s30),AT(69,194,104,10),USE(PAR:KONTAKTS)
                           PROMPT('Piezîmes:'),AT(182,194,32,10),USE(?PAR:DARBALAIKS:Prompt)
                           ENTRY(@s25),AT(216,194,93,10),USE(PAR:PIEZIMES)
                           PROMPT('Te&lefons:'),AT(12,208),USE(?PAR:TELFAX:Prompt)
                           ENTRY(@s26),AT(69,208,104,10),USE(PAR:TEL)
                           PROMPT('Fakss:'),AT(183,208,26,10),USE(?PAR:FAX:Prompt)
                           ENTRY(@s15),AT(216,207,63,10),USE(PAR:FAX)
                           PROMPT('e-pasts(norçíini):'),AT(10,221),USE(?PAR:EMAIL:Prompt)
                           ENTRY(@s37),AT(69,222,155,10),USE(PAR_EMAIL)
                           BUTTON('&Citi e-pasti'),AT(10,236,56,14),USE(?Buttonepasti)
                           IMAGE('CHECK3.ICO'),AT(69,235,14,17),USE(?Imageepasti),HIDE
                           PROMPT('&Pamatdokuments,PVN reì.datums:'),AT(12,256,112,10),USE(?PAR:PASE:Prompt)
                           ENTRY(@s30),AT(126,256,123,10),USE(PAR:PASE),LEFT
                           ENTRY(@s1),AT(180,98,13,10),USE(PAR:NMR_PLUS),CENTER
                           BUTTON('Atvçrt U&-Nr-->'),AT(224,22,54,14),USE(?ButtonAtvertUNR)
                           ENTRY(@n13),AT(280,24,40,10),USE(PAR:U_NR),DISABLE,RIGHT(1)
                           LIST,AT(363,158,27,10),USE(PAR:V_KODS),FORMAT('12L|@s3@'),DROP(10),FROM(Queue:FileDrop:2)
                         END
                         TAB('Papild&us dati'),USE(?Tab:2)
                           GROUP('&Bankas'),AT(7,36,322,74),USE(?Group1),BOXED
                             PROMPT('&IBAN kods'),AT(16,47,41,12),USE(?PAR:BAN_NR1:Prompt)
                             PROMPT('Koresp.'),AT(283,48,24,10),USE(?PAR:BAN_KR:Prompt)
                             ENTRY(@s34),AT(12,59,135,12),USE(PAR:BAN_NR),UPR
                             BUTTON('Izveidot(mainît) rindus P/Z(Rçíinam)- max 7 rindas'),AT(127,243,198,14),USE(?Button:RZP)
                             ENTRY(@s34),AT(12,86,135,12),USE(PAR:BAN_NR2),UPR
                             STRING(@s31),AT(150,73,130,10),USE(BAN_NOS)
                             STRING(@s31),AT(150,99,130,10),USE(BAN_NOS2)
                           END
                           PROMPT('&Lîguma datums:'),AT(6,116,54,10),USE(?PAR:L_Datums:Prompt)
                           ENTRY(@D06.B),AT(63,116,40,10),USE(PAR:L_DATUMS)
                           ENTRY(@s30),AT(106,116,151,10),USE(PAR:LIGUMS)
                           PROMPT('&Summa:'),AT(259,116),USE(?PAR:SUMMA1:Prompt)
                           ENTRY(@n_11.2),AT(288,116,50,10),USE(PAR:L_SUMMA),RIGHT(1)
                           BUTTON('Citi lîgumi'),AT(6,133,43,14),USE(?ButtonLigumi)
                           PROMPT('CTRL datums:'),AT(167,130),USE(?PAR:L_CDATUMS:Prompt)
                           ENTRY(@D06.B),AT(217,130,40,10),USE(PAR:L_CDATUMS),RIGHT(1)
                           PROMPT('Summa:'),AT(259,130),USE(?PAR:L_SUMMA1:Prompt)
                           ENTRY(@n-14.2),AT(288,128,50,10),USE(PAR:L_SUMMA1),RIGHT(1)
                           IMAGE('CHECK3.ICO'),AT(51,129,16,19),USE(?ImageLigumi),HIDE
                           BUTTON('&Skatît Dokumentu'),AT(92,128,70,14),USE(?ButtonLL),DISABLE
                           ENTRY(@n-4.0),AT(50,166,32,10),USE(PAR:NOKL_DC),RIGHT(1)
                           PROMPT('Noklusçtâ cena:'),AT(353,231,56,10),USE(?PAR:NOKL_CP:Prompt)
                           ENTRY(@n1B),AT(411,231,13,10),USE(PAR:NOKL_CP),CENTER
                           OPTION('N&oklusçtais norçíinu termiòð:'),AT(29,157,276,24),USE(PAR:NOKL_DC_TIPS,,?PAR:NOKL_DC_TIPS:2),BOXED
                             RADIO('Dienas'),AT(89,167),USE(?Option2:Radio1)
                             RADIO('Bankas dienas'),AT(125,167),USE(?Option2:Radio1:2),VALUE('1')
                             RADIO('Nenorâdît apmaksas termiòu'),AT(187,167),USE(?Option2:Radio1:3),VALUE('2')
                           END
                           PROMPT('Atlaide'),AT(28,187),USE(?PAR:ATLAIDE:Prompt),RIGHT
                           BUTTON('La&pa'),AT(55,184,43,14),USE(?Alapa)
                           ENTRY(@N-_7.1),AT(101,186,29,10),USE(PAR:ATLAIDE),RIGHT(1)
                           STRING(@s50),AT(133,187,211,10),USE(ATLAIDETEXT)
                           BUTTON('At&zîme'),AT(55,199,43,14),USE(?BUTTONatzime1)
                           ENTRY(@n3b),AT(102,202,23,10),USE(PAR:ATZIME1),RIGHT(1)
                           STRING(@s40),AT(130,203,183,10),USE(par_atzime1)
                           BUTTON('Atzîme(2)'),AT(55,212,43,14),USE(?BUTTONatzime2)
                           ENTRY(@n3B),AT(102,215,22,10),USE(PAR:ATZIME2),RIGHT(1)
                           STRING(@s40),AT(130,216,183,10),USE(par_atzime2)
                           IMAGE('CHECK3.ICO'),AT(325,227,14,17),USE(?Image:PZP),HIDE
                           PROMPT('&Kredîtlimits :'),AT(16,231),USE(?PAR:KRED_LIM:Prompt)
                           ENTRY(@n13.2),AT(64,231,48,10),USE(PAR:KRED_LIM),RIGHT(1)
                           STRING(@s3),AT(112,231,14,10),USE(Val_uzsk)
                           BUTTON('Izveidot(mainît) papildus tekstu P/Z(Rçíinam)- max 3 rindas'),AT(126,229,198,14),USE(?Button:PZP)
                           PROMPT('&Raþotâja kods:'),AT(13,25,54,10),USE(?PAR:NOS_U:Prompt),LEFT
                           ENTRY(@s3),AT(69,25,29,10),USE(PAR:NOS_U),UPR
                           COMBO(@s15),AT(150,59,123,12),USE(PAR:BAN_KODS),VSCROLL,FORMAT('45L|@s11@60L@s15@'),DROP(14),FROM(Queue:FileDropCombo)
                           ENTRY(@s11),AT(275,59,48,12),USE(PAR:BAN_KR)
                           COMBO(@s15),AT(150,86,123,12),USE(PAR:BAN_KODS2),VSCROLL,FORMAT('45L|@s11@60L@s15@'),DROP(14),FROM(Queue:FileDropCombo)
                           ENTRY(@s11),AT(276,86,48,12),USE(PAR:BAN_KR2)
                           OPTION('Pievienot dok.pamatoj.'),AT(341,95,83,43),USE(PAR:LT),BOXED
                             RADIO('Zinâðanai'),AT(349,104),USE(?PAR:LT:Radio1),VALUE('0')
                             RADIO('MU'),AT(349,114),USE(?PAR:LT:Radio2),VALUE('1')
                             RADIO('MU,Ieskaitam'),AT(349,125),USE(?PAR:LT:Radio3),VALUE('2')
                           END
                         END
                       END
                       BUTTON('&OK'),AT(332,276,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(380,276,45,14),USE(?Cancel)
                       STRING(@s8),AT(4,281),USE(PAR:ACC_KODS),FONT(,,COLOR:Gray,)
                       STRING(@D06.),AT(40,281),USE(PAR:ACC_DATUMS),FONT(,,COLOR:Gray,)
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
  !
  !      PAR_END_U_NR=GETINIFILE('PAR_END_U_NR',0)
  !      IF PAR_END_U_NR
  !         PAR_START_U_NR=PAR_END_U_NR-1000
  !         IF PAR_START_U_NR<0
  !            KLUDA(27,'PAR_K autonumerâcijas apgabals '&CLIP(PATH())&'\WINLATS.INI '&CLIP(PAR_START_U_NR)&'-'&CLIP(PAR_END_U_NR))
  !
  !
  IF ~PAR:V_KODS
     PAR:V_KODS='LV'
  .
  BAN_NOS = Getbankas_k(PAR:BAN_KODS,0,1)
  BAN_NOS2 =Getbankas_k(PAR:BAN_KODS2,0,1)
  par_atzime1=GetPar_Atzime(par:atzime1,1)
  par_atzime2=GetPar_Atzime(par:atzime2,1)
  PAR_EMAIL=CLIP(PAR:EMAIL)&PAR:PASE[31:37]
  !06/07/2013 IF ~(PAR:ADRESE=GETPAR_ADRESE(PAR:U_NR,1,0,0)) !IR ARÎ CITAS ADRESES
  IF ~(PAR:ADRESE=GETPAR_ADRESE(PAR:U_NR,1,0,0)) OR ~(GETPAR_ADRESE(PAR:U_NR,254,0,1) = '') !IR ARÎ CITAS ADRESES
     UNHIDE(?Imageadreses)
  .
  IF ~(PAR:EMAIL=GETPAR_eMAIL(PAR:U_NR,1,0,1)) !IR ARÎ CITAS e-ADRESES
     UNHIDE(?Imageepasti)
  .
  IF ~(PAR:LIGUMS=GETPAR_LIGUMI(PAR:U_NR,1,0,1)) !IR ARÎ CITI LÎGUMI
     UNHIDE(?ImageLigumi)
  .
  IF PAR:ATLAIDE>100
     IF GETPAR_ATLAIDE(PAR:ATLAIDE,'CHECK')
        ATLAIDETEXT=ATL:KOMENTARS
     ELSE
        ATLAIDETEXT='???'
     .
  ELSE
     ATLAIDETEXT='%'
  .
  SAV_U_NR=PAR:U_NR
  SAV_ATZIME1=PAR:ATZIME1
  SAV_ATZIME2=PAR:ATZIME2
  SAV_kred_lim=PAR:KRED_LIM
  SAV_REDZAMIBA=PAR:REDZAMIBA
  IF localrequest=2
     IF Browse::SelectRecord=TRUE THEN DISABLE(?ButtonAtvertUNR).
  .
  
  ActionMessage='Aplûkoðanas reþîms'   !ja ir localrequest, sistçma pati pârrakstîs pâri
  IF ATLAUTS[16]='1'
     DISABLE(?PAR:GRUPA)
     DISABLE(?PAR:KARTE)
  .
  IF ATLAUTS[22]='1'
     DISABLE(?PAR:KRED_LIM)
     DISABLE(?PAR:ATZIME1)
     DISABLE(?PAR:ATZIME2)
     DISABLE(?BUTTONATZIME1)
     DISABLE(?BUTTONATZIME2)
  .
  
  IF ~PAR:U_NR AND LOCALREQUEST=2
     ENABLE(?PAR:TIPS:Radio1)
  ELSIF INRANGE(PAR:U_NR,1,25)
     ENABLE(?PAR:TIPS:Radio5)
  ELSIF INRANGE(PAR:U_NR,26,50)
     ENABLE(?PAR:TIPS:Radio6)
  ELSE
     ENABLE(?PAR:TIPS:Radio1,?PAR:TIPS:Radio4)
  .
  
  ANSIFILENAME='PZP'&CLIP(PAR:U_NR)&'.TXT'
  OPEN(OUTFILEANSI)
  IF ~ERROR()
     UNHIDE(?Image:PZP)
     EXIST:PZP=TRUE
  .
  CLOSE(OUTFILEANSI)
  
  IF LOCALREQUEST=1
     SELECT(?PAR:NMR_KODS)
  ELSE
     SELECT(?Cancel)
  .
  
  
  
  
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
  END
  QuickWindow{Prop:Text} = ActionMessage
  CASE LocalRequest
  OF ChangeRecord OROF DeleteRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (' & CLIP(PAR:NOS_S) & ')'
  OF InsertRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (New)'
  END
  ENABLE(TBarBrwHistory)
  ACCEPT
    IF PAR:TIPS='F'
       HIDE(?PAR:NMR_PLUS)
       HIDE(?StringPlus)
       ?PAR:KODS:Prompt{PROP:TEXT}='Perso&nas kods:'
       ?PAR:pase:Prompt{PROP:TEXT}='&Pase:'
    ELSE
       UNHIDE(?PAR:NMR_PLUS)
       UNHIDE(?StringPlus)
       ?PAR:KODS:Prompt{PROP:TEXT}='&NMR kods:'
       ?PAR:pase:Prompt{PROP:TEXT}='&Pamatdokuments,PVN reì.datums:'
    .
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE()=MouseRight
         CASE FOCUS()
         OF ?PAR:NOS_P
            UPDATE(?PAR:NOS_P)
            PAR:NOS_P=INIGEN(PAR:NOS_P,LEN(CLIP(PAR:NOS_P)),3)
         OF ?PAR:ADRESE
            UPDATE(?PAR:ADRESE)
            PAR:ADRESE=INIGEN(PAR:ADRESE,LEN(CLIP(PAR:ADRESE)),3)
         OF ?PAR:LIGUMS
            IF ACC_KODS_N=0 !ASSAKO
               UPDATE(?PAR:LIGUMS)
               WLC=CALCWL(PAR:L_DATUMS,PAR:LIGUMS,1)
               IF GLOBALRESPONSE=REQUESTCOMPLETED
                  PAR:LIGUMS=WLC
                  PAR:L_SUMMA=SUMMA
                  IF ~PAR:L_SUMMA1 THEN PAR:L_SUMMA1=SUMMA*0.02.  !MÇNEÐMAKSA
                  IF ~PAR:L_DATUMS THEN PAR:L_DATUMS=TODAY().
                  IF ~PAR:L_CDATUMS
                     PAR:L_CDATUMS=DATE(MONTH(PAR:L_DATUMS)+1,1,YEAR(PAR:L_DATUMS)+1)
                  .
               .
            .
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
      DO FLD7::FillList
      DO FLD5::FillList
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?String1234567)
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
         SELECT(?cancel)
      ELSIF LOCALREQUEST=1
         SELECT(?PAR:TIPS)
      ELSE
         SELECT(?cancel)
      .
      IF ACC_KODS=0
!         ENABLE(?Option3)
!         ENABLE(?Option4)
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
        History::PAR:Record = PAR:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(PAR_K)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(PAR:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'PAR:NR_KEY')
                SELECT(?String1234567)
                VCRRequest = VCRNone
                CYCLE
              END
            END
            IF DUPLICATE(PAR:NOS_U_KEY)
              IF StandardWarning(Warn:DuplicateKey,'PAR:NOS_U_KEY')
                SELECT(?String1234567)
                VCRRequest = VCRNone
                CYCLE
              END
            END
            IF DUPLICATE(PAR:KARTE_KEY)
              IF StandardWarning(Warn:DuplicateKey,'PAR:KARTE_KEY')
                SELECT(?String1234567)
                VCRRequest = VCRNone
                CYCLE
              END
            END
            IF DUPLICATE(PAR:NMR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'PAR:NMR_KEY')
                SELECT(?String1234567)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?String1234567)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::PAR:Record <> PAR:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:PAR_K(1)
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
              SELECT(?String1234567)
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
          OF 4
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?PAR:GRUPA
      CASE EVENT()
      OF EVENT:Accepted
        PAR:GRUPA=INIGEN(PAR:GRUPA,7,1)
        PAR:GRUPA=UPPER(PAR:GRUPA)
      END
    OF ?PAR:KARTE
      CASE EVENT()
      OF EVENT:Accepted
        IF DUPLICATE(PAR:KARTE_KEY)
           KLUDA(0,'Veidojas dubultas atslçgas ar ðo Kartes Nr...')
           SELECT(?PAR:KARTE)
        .
        IF INRANGE(PAR:KARTE,99991,99999)
           KLUDA(0,'Kartes Nr 99991-99999 ir paredzçti speciâlai lietoðanai...')
        .
      END
    OF ?PAR:NMR_KODS
      CASE EVENT()
      OF EVENT:Accepted
        IF PAR:TIPS='F' AND PAR:NMR_KODS
           !16/09/2015 CHECKKODS(DEFORMAT(PAR:NMR_KODS,@P######-#####P))
           IF INSTRING('-',PAR:NMR_KODS) = 0
              CHECKKODS(DEFORMAT(PAR:NMR_KODS))
           ELSE
              CHECKKODS(DEFORMAT(PAR:NMR_KODS,@P######-#####P))
           .
           IF DUPLICATE(PAR:NMR_KEY)
              KLUDA(0,'Veidojas dubultas atslçgas ar ðo PK...')
              SELECT(?PAR:NMR_KODS)
           .
        ELSE
           IF DUPLICATE(PAR:NMR_KEY)
              KLUDA(0,'Veidojas dubultas atslçgas ar ðo NMR Nr...')
              SELECT(?PAR:NMR_KODS)
           .
        .
        DISPLAY
      END
    OF ?PVN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAR:TIPS='E'
           PAR:PVN='LV'&CLIP(PAR:NMR_KODS)
        ELSIF PAR:TIPS='F'
           PAR:PVN='LV'&CLIP(PAR:NMR_KODS)
        ELSE
           IF ~NUMERIC(PAR:NMR_KODS[1:2])
              PAR:PVN=CLIP(PAR:NMR_KODS)
           ELSE
              PAR:PVN=CLIP(PAR:V_KODS)&CLIP(PAR:NMR_KODS)
           .
        .
        DISPLAY
      END
    OF ?PAR:NOS_P
      CASE EVENT()
      OF EVENT:Accepted
        IF ~PAR:NOS_S
           PAR:NOS_S=SUB(PAR:NOS_P,6,15)
           IF PAR:NOS_S[LEN(CLIP(PAR:NOS_S))]='"'
              PAR:NOS_S[LEN(CLIP(PAR:NOS_S))]=' '
           .
        .
        PAR:NOS_A=INIGEN(PAR:NOS_S,12,1)
        DISPLAY
      END
    OF ?PAR:NOS_S
      CASE EVENT()
      OF EVENT:Accepted
        PAR:NOS_A=INIGEN(PAR:NOS_S,12,1)
        DISPLAY
      END
    OF ?ButtonAdreses
      CASE EVENT()
      OF EVENT:Accepted
        EMA:PAR_NR = PAR:U_NR
        DO SyncWindow
        BrowsePAR_A 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        !06/07/2013 IF ~(PAR:ADRESE=GETPAR_ADRESE(PAR:U_NR,1,0,0)) !IR ARÎ CITAS ADRESES
        IF ~(PAR:ADRESE=GETPAR_ADRESE(PAR:U_NR,1,0,0)) OR ~(GETPAR_ADRESE(PAR:U_NR,254,0,1) = '') !IR ARÎ CITAS ADRESES
           UNHIDE(?Imageadreses)
        ELSE
           HIDE(?Imageadreses)
        .
        DISPLAY
      END
    OF ?Buttonepasti
      CASE EVENT()
      OF EVENT:Accepted
        eMA:PAR_NR = PAR:U_NR
        DO SyncWindow
        BrowsePAR_E 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF ~(PAR:EMAIL=GETPAR_eMAIL(PAR:U_NR,1,0,1)) !IR ARÎ CITI e-PASTI
           UNHIDE(?Imageepasti)
        ELSE
           HIDE(?Imageepasti)
        .
        DISPLAY
      END
    OF ?ButtonAtvertUNR
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          ENABLE(?PAR:U_NR)
          SELECT(?PAR:U_NR)
      END
    OF ?PAR:U_NR
      CASE EVENT()
      OF EVENT:Accepted
        IF LOCALREQUEST=CHANGERECORD AND ~(SAV_U_NR=PAR:U_NR)
           IF DUPLICATE(PAR:NR_KEY)
              KLUDA(0,'Ðis U_NR jau ir aizòemts...')
              SELECT(?PAR:U_NR)
           .
        .
      END
    OF ?PAR:V_KODS
      CASE EVENT()
      OF EVENT:Accepted
        GET(Queue:FileDrop:2,CHOICE())
        PAR:V_KODS = FLD7::VAL:V_KODS
      END
    OF ?PAR:BAN_NR
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(PAR:BAN_NR,PAR:BAN_KR)
        IF ~PAR:BAN_KODS AND PAR:BAN_NR
           LOOP FLD5::LoopIndex = 1 TO RECORDS(Queue:FileDropCombo)
             GET(Queue:FileDropCombo,FLD5::LoopIndex)
             IF PAR:BAN_NR[5:8]&PAR:BAN_NR[1:2] = FLD5::BAN:KODS[1:6]
                PAR:BAN_KODS = FLD5::BAN:KODS
                BAN_NOS = Getbankas_k(PAR:BAN_KODS,0,1)
                ACCEPTED#=1
                DISPLAY
                BREAK
             .
           END
           ?PAR:BAN_KODS{Prop:Selected} = FLD5::LoopIndex
        .
        
      END
    OF ?Button:RZP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        ANSIFILENAME='RZP'&CLIP(PAR:U_NR)&'.TXT'
        OPEN(OUTFILEANSI)
        IF ~ERROR()
           CLOSE(OUTFILEANSI)
        
           RUN('WORDPAD '&ANSIFILENAME)
           IF RUNCODE()=-4
              KLUDA(88,'Wordpad.exe')
           .
        ELSE
           CREATE(OUTFILEANSI)
           IF ~ERROR()
              RUN('WORDPAD '&ANSIFILENAME)
              IF RUNCODE()=-4
                 KLUDA(88,'Wordpad.exe')
              .
           .
        .
        
      END
    OF ?PAR:BAN_NR2
      CASE EVENT()
      OF EVENT:Accepted
        CHECKIBAN(PAR:BAN_NR2,PAR:BAN_KR2)
        IF ~PAR:BAN_KODS2 AND PAR:BAN_NR2
           LOOP FLD5::LoopIndex = 1 TO RECORDS(Queue:FileDropCombo)
             GET(Queue:FileDropCombo,FLD5::LoopIndex)
             IF PAR:BAN_NR2[5:8]&PAR:BAN_NR2[1:2] = FLD5::BAN:KODS[1:6]
                PAR:BAN_KODS2 = FLD5::BAN:KODS
                BAN_NOS2 = Getbankas_k(PAR:BAN_KODS2,0,1)
                ACCEPTED#=1
                DISPLAY
                BREAK
             .
           END
           ?PAR:BAN_KODS2{Prop:Selected} = FLD5::LoopIndex
        .
      END
    OF ?ButtonLigumi
      CASE EVENT()
      OF EVENT:Accepted
        PAL:PAR_NR = PAR:U_NR
        DO SyncWindow
        BrowsePAR_L 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        !IF ~(PAR:LIGUMS=GETPAR_LIGUMI(PAR:U_NR,1,0,1)) !IR ARÎ CITI Lîgumi
        IF GETPAR_LIGUMI(PAR:U_NR,1,0,1) !IR ARÎ CITI(S,1) Lîgumi
           UNHIDE(?ImageLigumi)
        ELSE
           HIDE(?ImageLigumi)
        .
        DISPLAY
      END
    OF ?ButtonLL
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           IF OPENANSI(CLIP(PAR:U_NR)&'-AKT.doc',3)  !ARÎ FULL OUTFILENAME
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
                 OUTA:LINE='Lîgums Nr '&PAR:LIGUMS
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE='Rîga, '&FORMAT(PAR:L_DATUMS,@D06.)
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE=PAR:ADRESE
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
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
    OF ?PAR:NOKL_CP
      CASE EVENT()
      OF EVENT:Accepted
        IF NOT INRANGE(PAR:NOKL_CP,0,5)
          IF StandardWarning(Warn:OutOfRange,'PAR:NOKL_CP','0 and 5')
            SELECT(?PAR:NOKL_CP)
            QuickWindow{Prop:AcceptAll} = False
            CYCLE
          END
        END
      END
    OF ?Alapa
      CASE EVENT()
      OF EVENT:Accepted
        SAVEPOSITION=POSITION(PAR_K)
        SAV_RECORD=PAR:RECORD
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseAtl_k 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        RESET(PAR_K,SAVEPOSITION)
        NEXT(PAR_K)
        PAR:RECORD=SAV_RECORD
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PAR:ATLAIDE=ATL:U_NR
           ATLAIDETEXT=ATL:KOMENTARS
        .
        DISPLAY
      END
    OF ?PAR:ATLAIDE
      CASE EVENT()
      OF EVENT:Accepted
        IF PAR:ATLAIDE > 100
           IF GETPAR_ATLAIDE(PAR:ATLAIDE,'CHECK')
              PAR:ATLAIDE=ATL:U_NR
              ATLAIDETEXT=ATL:KOMENTARS
           ELSE
              PAR:ATLAIDE=0
              ATLAIDETEXT='%'
           .
        ELSE
           ATLAIDETEXT='%'
        .
        DISPLAY
      END
    OF ?BUTTONatzime1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_Z 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           par:atzime1=atz:NR
           par_atzime1=atz:TEKSTS
           display
        .
      END
    OF ?PAR:ATZIME1
      CASE EVENT()
      OF EVENT:Accepted
        par_atzime1=GetPar_Atzime(par:atzime1,1)
        display
      END
    OF ?BUTTONatzime2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_Z 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           par:atzime2=atz:NR
           par_atzime2=atz:TEKSTS
           display
        .
      END
    OF ?PAR:ATZIME2
      CASE EVENT()
      OF EVENT:Accepted
        par_atzime2=GetPar_Atzime(par:atzime2,1)
        display
      END
    OF ?Button:PZP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         ANSIFILENAME='PZP'&CLIP(PAR:U_NR)&'.TXT'
         IF EXIST:PZP=FALSE
            CREATE(OUTFILEANSI)
            IF ~ERROR()
               UNHIDE(?Image:PZP)
               EXIST:PZP=TRUE
            .
         .
         IF EXIST:PZP=TRUE
            RUN('WORDPAD '&ANSIFILENAME)
            IF RUNCODE()=-4
               KLUDA(88,'Wordpad.exe')
            .
         .
      END
    OF ?PAR:NOS_U
      CASE EVENT()
      OF EVENT:Accepted
        PAR:NOS_U=INIGEN(PAR:NOS_U,3,1)
        PAR:NOS_U=UPPER(PAR:NOS_U)
        DISPLAY
      END
    OF ?PAR:BAN_KODS
      CASE EVENT()
      OF EVENT:Accepted
        IF PAR:BAN_KODS AND ~ACCEPTED#
        FLD5::BAN:KODS = PAR:BAN_KODS
        GET(Queue:FileDropCombo,FLD5::BAN:KODS)
        IF ERRORCODE() THEN
          SELECT(?PAR:BAN_KODS)
        END
        END
        BAN_NOS = Getbankas_k(PAR:BAN_KODS,0,1)
        IF BAN_NOS
           ACCEPTED#=1
        .
!        PAR:BAN_KODS=BAN:KODS   ?
        DISPLAY()
      END
    OF ?PAR:BAN_KODS2
      CASE EVENT()
      OF EVENT:Accepted
        IF PAR:BAN_KODS2
        END
        BAN_NOS2 = Getbankas_k(PAR:BAN_KODS2,0,1)
        !PAR:BAN_KODS2=BAN:KODS ?tikai noèakarç....
        DISPLAY()
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
        PAR:ACC_KODS=ACC_kods
        PAR:ACC_DATUMS=today()
        PAR:EMAIL=PAR_EMAIL[1:30]
        PAR:PASE[31:37]=PAR_EMAIL[31:37]
        IF LOCALREQUEST=CHANGERECORD AND ~(SAV_U_NR=PAR:U_NR)
           IF GNET  !GLOBÂLÂ TÎKLÂ BRÎDINAM
              KLUDA(51,SAV_U_NR&'->'&PAR:U_NR & ' Globâlâ tîklâ jâzina, ko dara !!!')
           ELSE
              KLUDA(51,SAV_U_NR&'->'&PAR:U_NR)
           .
           IF KLU_DARBIBA
              OPEN(ProgressWindow)
              ?Progress:PctText{Prop:Text} = ''
              ProgressWindow{Prop:Text} = 'Konvertçjam datu bâzi'
              LOOP T#=1 TO BASE_sk
                 CLOSE(GG)
                 GGNAME='GG'&FORMAT(T#,@N02)
                 CLOSE(GGK)
                 GGKNAME='GGK'&FORMAT(T#,@N02)
                 IF DOS_CONT(CLIP(GGKNAME)&'.TPS',2)
                    CHECKOPEN(GGK,1)
                    CHECKOPEN(GG,1)
                    IF ERROR()
                       TAKA"=PATH()
                       KLUDA(1,CLIP(TAKA")&'\'&GGKNAME)
                    ELSE
                       ?Progress:UserString{Prop:Text}=GGKNAME
        !                  RecordsProcessed = 0
                       LOOP
                          CLEAR(GGK:RECORD)
                          GGK:PAR_NR=SAV_U_NR
                          SET(GGK:PAR_KEY,GGK:PAR_KEY)
                          NEXT(GGK)
                          IF ERROR() OR ~(GGK:PAR_NR=SAV_U_NR) THEN BREAK.
                          RecordsProcessed += 1
                          ?Progress:PctText{Prop:Text} = RecordsProcessed & ' raksti '
                          DISPLAY()
                          IF GGK:PAR_NR=SAV_U_NR
                             GGK:PAR_NR=PAR:U_NR
                             IF RIUPDATE:GGK()
                                KLUDA(24,'RAKSTOT GGK:'&ERROR())
                             .
                          .
                          GG::USED+=1
                          IF ~GETGG(GGK:U_NR)
                             STOP('NEATRADU GG.. U_NR='&GGK:U_NR)
                          ELSIF GG:PAR_NR=SAV_U_NR
                             GG:PAR_NR=PAR:U_NR
                             IF RIUPDATE:GG()
                                KLUDA(24,'RAKSTOT GG:'&ERROR())
                             .
                          .
                          GG::USED-=1
                       .
                    .
                 .
              .
              CLOSE(GG)
              CLOSE(GGK)
              GGNAME='GG'&FORMAT(LOC_NR,@N02)        !Noliekam, ko paòçmâm
              GGKNAME='GGK'&FORMAT(LOC_NR,@N02)      !Noliekam, ko paòçmâm
        !-------------------------------------------------------------------------------------
              LOOP T#=1 TO NOL_sk
                 CLOSE(NOLIK)
                 NOLIKNAME='NOLIK'&FORMAT(T#,@N02)
                 CLOSE(PAVAD)
                 PAVADNAME='PAVAD'&FORMAT(T#,@N02)
                 IF DOS_CONT(CLIP(NOLIKNAME)&'.TPS',2)
                    CHECKOPEN(NOLIK,1)
                    CHECKOPEN(PAVAD,1)
                    IF ERROR()
                       TAKA"=PATH()
                       KLUDA(1,CLIP(TAKA")&'\'&PAVADNAME)
                    ELSE
                       ?Progress:UserString{Prop:Text}=NOLIKNAME
                       LOOP !ÐITÂ, JO MAINAM LASÎÐANAS ATSLÇGU
                          CLEAR(NOL:RECORD)
                          NOL:PAR_NR=SAV_U_NR
                          SET(NOL:PAR_KEY,NOL:PAR_KEY)
                          NEXT(NOLIK)
                          IF ERROR() OR ~(NOL:PAR_NR=SAV_U_NR) THEN BREAK.
                          RecordsProcessed += 1
                          ?Progress:PctText{Prop:Text} = RecordsProcessed & ' raksti '
                          DISPLAY()
                          IF NOL:PAR_NR=SAV_U_NR
                             NOL:PAR_NR=PAR:U_NR
                             IF RIUPDATE:NOLIK()
                                KLUDA(24,'RAKSTOT NOLIK:'&ERROR())
                             .
                          .
                          PAVAD::USED+=1
                          IF ~GETPAVADZ(NOL:U_NR)
                             STOP('NEATRADU PAVAD.. U_NR='&NOL:U_NR)
                          ELSIF PAV:PAR_NR=SAV_U_NR
                             PAV:PAR_NR=PAR:U_NR
                             IF RIUPDATE:PAVAD()
                                KLUDA(24,'RAKSTOT PAVAD:'&ERROR())
                             .
                          .
                          PAVAD::USED-=1
                       .
                    .
                 .
              .
              CLOSE(NOLIK)
              CLOSE(PAVAD)
              NOLIKNAME='NOLIK'&FORMAT(LOC_NR,@N02)      !Noliekam, ko paòçmâm
              PAVADNAME='PAVAD'&FORMAT(LOC_NR,@N02)      !Noliekam, ko paòçmâm
        !-------------------------------------------------------------------------------------
              CHECKOPEN(VESTURE,1)
              ?Progress:UserString{Prop:Text}='VESTURE.TPS'
              LOOP !ÐITÂ, JO MAINAM LASÎÐANAS ATSLÇGU
                 CLEAR(VES:RECORD)
                 VES:PAR_NR=SAV_U_NR
                 SET(VES:PAR_KEY,VES:PAR_KEY)
                 NEXT(VESTURE)
                 IF ERROR() OR ~(VES:PAR_NR=SAV_U_NR) THEN BREAK.
                 RecordsProcessed += 1
                 ?Progress:PctText{Prop:Text} = RecordsProcessed & ' raksti '
                 DISPLAY()
                 IF VES:PAR_NR=SAV_U_NR
                    VES:PAR_NR=PAR:U_NR
                    IF RIUPDATE:VESTURE()
                       KLUDA(24,'RAKSTOT VESTURE:'&ERROR())
                    .
                 .
              .
              CLOSE(VESTURE)
        
              close(ProgressWindow)
           ELSE
              PAR:U_NR=SAV_U_NR
        
           .
        .
        IF LOCALREQUEST=CHANGERECORD AND ~(SAV_REDZAMIBA=PAR:REDZAMIBA) AND PAR:REDZAMIBA='A' !UZ ARHÎVS
           IF VESTURE::USED=0
              CHECKOPEN(VESTURE,1)
           .
           VESTURE::USED+=1
           CLEAR(VES:RECORD)
           VES:DOKDAT=TODAY()
           VES:DATUMS=TODAY()
           VES:PAR_NR=PAR:U_NR
           VES:CRM   =0
           VES:SATURS='pârcelts uz arhîvu'
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
        IF LOCALREQUEST=CHANGERECORD AND ~(SAV_ATZIME1=PAR:ATZIME1)
           WriteZurnals(2,0,'PAR_K Mainîta atzîme no '&SAV_ATZIME1&' uz '&PAR:ATZIME1)
        .
        IF LOCALREQUEST=CHANGERECORD AND ~(SAV_ATZIME2=PAR:ATZIME2)
           WriteZurnals(2,0,'PAR_K Mainîta atzîme no '&SAV_ATZIME2&' uz '&PAR:ATZIME2)
        .
        IF LOCALREQUEST=CHANGERECORD AND ~(SAV_kred_lim=PAR:KRED_LIM)
           WriteZurnals(2,0,'PAR_K Mainîts kredîtlimits no '&SAV_kred_lim&' uz '&PAR:KRED_LIM)
        .
        IF LOCALREQUEST=1
           IF INRANGE(PAR:U_NR,1,25)
              KLUDA(0,CLIP(PAR:NOS_S)&' ievadîts  kâ internâla noliktava',,1)
           ELSIF INRANGE(PAR:U_NR,26,50)
              KLUDA(0,CLIP(PAR:NOS_S)&' ievadîts  kâ raþoðana',,1)
           .
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
  IF ATL_K::Used = 0
    CheckOpen(ATL_K,1)
  END
  ATL_K::Used += 1
  BIND(ATL:RECORD)
  IF BANKAS_K::Used = 0
    CheckOpen(BANKAS_K,1)
  END
  BANKAS_K::Used += 1
  BIND(BAN:RECORD)
  IF CONFIG::Used = 0
    CheckOpen(CONFIG,1)
  END
  CONFIG::Used += 1
  BIND(CON:RECORD)
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
  IF VAL_K::Used = 0
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  BIND(VAL:RECORD)
  FilesOpened = True
  RISnap:PAR_K
  SAV::PAR:Record = PAR:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
         IF ~COPYREQUEST
            PAR:TIPS='E'
            PAR:NOKL_DC_TIPS='D'
            PAR:REDZAMIBA='1'
            PAR:L_FAILS = 'L'&CLIP(LEFT(FORMAT(PAR:U_NR,@N_6B)))&'.doc'
         .
         PAR:ACC_KODS=ACC_kods
         PAR:ACC_DATUMS=today()
    END ! BEIDZAS LocalRequest = 1
    !  IF NOM:NOMENKLAT='' AND LOCALREQUEST=3  !NESAPROTAMA CLARA KÏÛDA
    !     LocalResponse = RequestCancelled
    !     DO PROCEDURERETURN
    !  .
      IF GNET !GLOBÂLAIS TÎKLS
         CASE LOCALREQUEST
         OF 1
            PAR:GNET_FLAG[1]=1
            PAR:GNET_FLAG[2]=''
         OF 2
            IF PAR:GNET_FLAG[1]=1     !JA STÂV ADD1 (NEKUR CITUR VÇL NAV IERAKSTÎTS)
            ELSIF PAR:GNET_FLAG[1]=4  !JA STÂV ADD4 (NE VISUR IR IERAKSTÎTS)
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSIF PAR:GNET_FLAG[1]=2  !JA STÂV PUT2 (NEKUR CITUR VÇL NAV NOMAINÎTS)
            ELSIF PAR:GNET_FLAG[1]=5  !JA STÂV PUT5 (NE VISUR IR NOMAINÎTS)
               PAR:GNET_FLAG[1]=2
               PAR:GNET_FLAG[2]=''    !MAINAM VISUR
            ELSIF PAR:GNET_FLAG[1]=3 OR PAR:GNET_FLAG[1]=6  !JA STÂV DEL 
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSE
               PAR:GNET_FLAG[1]=2
               PAR:GNET_FLAG[2]=''
            .
            SAV::PAR:Record = PAR:Record ! LAI NERAKSTA UZ OK, JA NEKAS NAV MAINÎTS
         OF 3
    !        STOP(PAR:GNET_FLAG)
            IF PAR:GNET_FLAG[1]=1     !JA STÂV ADD1 (NEKUR CITUR VÇL NAV IERAKSTÎTS)
               PAR:GNET_FLAG=''
            ELSIF PAR:GNET_FLAG[1]=4  !JA STÂV ADD4 (NE VISUR IR IERAKSTÎTS)
               KLUDA(121,'dzçst, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSIF PAR:GNET_FLAG[1]=2  !JA STÂV PUT2 (NEKUR CITUR VÇL NAV NOMAINÎTS)
               PAR:GNET_FLAG[1]=3
               LOCALREQUEST=4
            ELSIF PAR:GNET_FLAG[1]=5  !JA STÂV PUT5 (NE VISUR IR NOMAINÎTS)
               PAR:GNET_FLAG[1]=3     !DZÇÐAM VISUR
               PAR:GNET_FLAG[2]=''
               LOCALREQUEST=4
            ELSIF PAR:GNET_FLAG[1]=3 OR PAR:GNET_FLAG[1]=6  !JA STÂV DEL
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSE
               PAR:GNET_FLAG[1]=3
               PAR:GNET_FLAG[2]=''
               LOCALREQUEST=4
            .
         .
      .
      IF LocalRequest = 4 ! DeleteRecord GNET
        IF StandardWarning(Warn:StandardDelete) = Button:OK
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            PAR:NOS_S='WAITING FOR DEL.'
            PAR:NOS_A='W.F.DEL'
            IF RIUPDATE:PAR_K()
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
        IF RIDelete:PAR_K()
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
  INIRestoreWindow('UpdatePAR_K','winlats.INI')
  WinResize.Resize
  ?PAR:GRUPA{PROP:Alrt,255} = 734
  ?PAR:KARTE{PROP:Alrt,255} = 734
  ?PAR:TIPS{PROP:Alrt,255} = 734
  ?PAR:REDZAMIBA{PROP:Alrt,255} = 734
  ?PAR:NMR_KODS{PROP:Alrt,255} = 734
  ?PAR:PVN{PROP:Alrt,255} = 734
  ?PAR:NOS_P{PROP:Alrt,255} = 734
  ?PAR:NOS_S{PROP:Alrt,255} = 734
  ?PAR:NOS_A{PROP:Alrt,255} = 734
  ?PAR:ADRESE{PROP:Alrt,255} = 734
  ?PAR:KONTAKTS{PROP:Alrt,255} = 734
  ?PAR:PIEZIMES{PROP:Alrt,255} = 734
  ?PAR:TEL{PROP:Alrt,255} = 734
  ?PAR:FAX{PROP:Alrt,255} = 734
  ?PAR_EMAIL{PROP:Alrt,255} = 734
  ?PAR:PASE{PROP:Alrt,255} = 734
  ?PAR:NMR_PLUS{PROP:Alrt,255} = 734
  ?PAR:U_NR{PROP:Alrt,255} = 734
  ?PAR:V_KODS{PROP:Alrt,255} = 734
  ?PAR:BAN_NR{PROP:Alrt,255} = 734
  ?PAR:BAN_NR2{PROP:Alrt,255} = 734
  ?PAR:L_DATUMS{PROP:Alrt,255} = 734
  ?PAR:LIGUMS{PROP:Alrt,255} = 734
  ?PAR:L_SUMMA{PROP:Alrt,255} = 734
  ?PAR:L_CDATUMS{PROP:Alrt,255} = 734
  ?PAR:L_SUMMA1{PROP:Alrt,255} = 734
  ?PAR:NOKL_DC{PROP:Alrt,255} = 734
  ?PAR:NOKL_CP{PROP:Alrt,255} = 734
  ?PAR:NOKL_DC_TIPS:2{PROP:Alrt,255} = 734
  ?PAR:ATLAIDE{PROP:Alrt,255} = 734
  ?PAR:ATZIME1{PROP:Alrt,255} = 734
  ?par_atzime1{PROP:Alrt,255} = 734
  ?PAR:ATZIME2{PROP:Alrt,255} = 734
  ?par_atzime2{PROP:Alrt,255} = 734
  ?PAR:KRED_LIM{PROP:Alrt,255} = 734
  ?PAR:NOS_U{PROP:Alrt,255} = 734
  ?PAR:BAN_KODS{PROP:Alrt,255} = 734
  ?PAR:BAN_KR{PROP:Alrt,255} = 734
  ?PAR:BAN_KODS2{PROP:Alrt,255} = 734
  ?PAR:BAN_KR2{PROP:Alrt,255} = 734
  ?PAR:LT{PROP:Alrt,255} = 734
  ?PAR:ACC_KODS{PROP:Alrt,255} = 734
  ?PAR:ACC_DATUMS{PROP:Alrt,255} = 734
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
    ATL_K::Used -= 1
    IF ATL_K::Used = 0 THEN CLOSE(ATL_K).
    BANKAS_K::Used -= 1
    IF BANKAS_K::Used = 0 THEN CLOSE(BANKAS_K).
    CONFIG::Used -= 1
    IF CONFIG::Used = 0 THEN CLOSE(CONFIG).
    PAR_E::Used -= 1
    IF PAR_E::Used = 0 THEN CLOSE(PAR_E).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
     ANSIFILENAME=''
  END
  IF WindowOpened
    INISaveWindow('UpdatePAR_K','winlats.INI')
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
    OF ?PAR:GRUPA
      PAR:GRUPA = History::PAR:Record.GRUPA
    OF ?PAR:KARTE
      PAR:KARTE = History::PAR:Record.KARTE
    OF ?PAR:TIPS
      PAR:TIPS = History::PAR:Record.TIPS
    OF ?PAR:REDZAMIBA
      PAR:REDZAMIBA = History::PAR:Record.REDZAMIBA
    OF ?PAR:NMR_KODS
      PAR:NMR_KODS = History::PAR:Record.NMR_KODS
    OF ?PAR:PVN
      PAR:PVN = History::PAR:Record.PVN
    OF ?PAR:NOS_P
      PAR:NOS_P = History::PAR:Record.NOS_P
    OF ?PAR:NOS_S
      PAR:NOS_S = History::PAR:Record.NOS_S
    OF ?PAR:NOS_A
      PAR:NOS_A = History::PAR:Record.NOS_A
    OF ?PAR:ADRESE
      PAR:ADRESE = History::PAR:Record.ADRESE
    OF ?PAR:KONTAKTS
      PAR:KONTAKTS = History::PAR:Record.KONTAKTS
    OF ?PAR:PIEZIMES
      PAR:PIEZIMES = History::PAR:Record.PIEZIMES
    OF ?PAR:TEL
      PAR:TEL = History::PAR:Record.TEL
    OF ?PAR:FAX
      PAR:FAX = History::PAR:Record.FAX
    OF ?PAR_EMAIL
      PAR_EMAIL = History::PAR:Record.EMAIL
    OF ?PAR:PASE
      PAR:PASE = History::PAR:Record.PASE
    OF ?PAR:NMR_PLUS
      PAR:NMR_PLUS = History::PAR:Record.NMR_PLUS
    OF ?PAR:U_NR
      PAR:U_NR = History::PAR:Record.U_NR
    OF ?PAR:V_KODS
      PAR:V_KODS = History::PAR:Record.V_KODS
    OF ?PAR:BAN_NR
      PAR:BAN_NR = History::PAR:Record.BAN_NR
    OF ?PAR:BAN_NR2
      PAR:BAN_NR2 = History::PAR:Record.BAN_NR2
    OF ?PAR:L_DATUMS
      PAR:L_DATUMS = History::PAR:Record.L_DATUMS
    OF ?PAR:LIGUMS
      PAR:LIGUMS = History::PAR:Record.LIGUMS
    OF ?PAR:L_SUMMA
      PAR:L_SUMMA = History::PAR:Record.L_SUMMA
    OF ?PAR:L_CDATUMS
      PAR:L_CDATUMS = History::PAR:Record.L_CDATUMS
    OF ?PAR:L_SUMMA1
      PAR:L_SUMMA1 = History::PAR:Record.L_SUMMA1
    OF ?PAR:NOKL_DC
      PAR:NOKL_DC = History::PAR:Record.NOKL_DC
    OF ?PAR:NOKL_CP
      PAR:NOKL_CP = History::PAR:Record.NOKL_CP
    OF ?PAR:NOKL_DC_TIPS:2
      PAR:NOKL_DC_TIPS = History::PAR:Record.NOKL_DC_TIPS
    OF ?PAR:ATLAIDE
      PAR:ATLAIDE = History::PAR:Record.ATLAIDE
    OF ?PAR:ATZIME1
      PAR:ATZIME1 = History::PAR:Record.ATZIME1
    OF ?par_atzime1
      par_atzime1 = History::PAR:Record.ATZIME1
    OF ?PAR:ATZIME2
      PAR:ATZIME2 = History::PAR:Record.ATZIME2
    OF ?par_atzime2
      par_atzime2 = History::PAR:Record.ATZIME2
    OF ?PAR:KRED_LIM
      PAR:KRED_LIM = History::PAR:Record.KRED_LIM
    OF ?PAR:NOS_U
      PAR:NOS_U = History::PAR:Record.NOS_U
    OF ?PAR:BAN_KODS
      PAR:BAN_KODS = History::PAR:Record.BAN_KODS
    OF ?PAR:BAN_KR
      PAR:BAN_KR = History::PAR:Record.BAN_KR
    OF ?PAR:BAN_KODS2
      PAR:BAN_KODS2 = History::PAR:Record.BAN_KODS2
    OF ?PAR:BAN_KR2
      PAR:BAN_KR2 = History::PAR:Record.BAN_KR2
    OF ?PAR:LT
      PAR:LT = History::PAR:Record.LT
    OF ?PAR:ACC_KODS
      PAR:ACC_KODS = History::PAR:Record.ACC_KODS
    OF ?PAR:ACC_DATUMS
      PAR:ACC_DATUMS = History::PAR:Record.ACC_DATUMS
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
  PAR:Record = SAV::PAR:Record
    PAR:Record = SAV::PAR:Record
    PAR_START_U_NR=0
    PAR_END_U_NR=0
    PAR_END_U_NR=GETINIFILE('PAR_END_U_NR',0)
    IF PAR_END_U_NR
       PAR_START_U_NR=PAR_END_U_NR-1000
       IF PAR_START_U_NR<0
          KLUDA(27,'PAR_K autonumerâcijas apgabals '&CLIP(PATH())&'\WINLATS.INI '&CLIP(PAR_START_U_NR)&'-'&CLIP(PAR_END_U_NR))
          PAR_START_U_NR=51
       .
    .
    SAV::PAR:Record = PAR:Record
    Auto::Attempts = 0
    LOOP
  !    IF CON:PAR_END_U_NR
      IF PAR_END_U_NR
         GET(PAR_K,0)
  !       PAR:U_NR=CON:PAR_END_U_NR
         PAR:U_NR=PAR_END_U_NR
         SET(PAR:NR_KEY,PAR:NR_KEY)
         PREVIOUS(PAR_K)
         IF PAR:U_NR < PAR_START_U_NR
            PAR:U_NR=PAR_START_U_NR
  !       ELSIF PAR:U_NR=CON:PAR_END_U_NR
         ELSIF PAR:U_NR=PAR_END_U_NR
            KLUDA(45,'PAR_K autonumerâcijas apgabals aizpildîts, nav vietas jauniem ierakstiem')
            POST(Event:CloseWindow)
            EXIT
         .
      ELSE
         SET(PAR:NR_KEY)
         PREVIOUS(PAR_K)
      .
      IF ERRORCODE() AND ERRORCODE() <> BadRecErr
        StandardWarning(Warn:RecordFetchError,'PAR_K')
        POST(Event:CloseWindow)
        EXIT
      END
      IF ERRORCODE()
        Auto::Save:PAR:U_NR = 1
      ELSE
        Auto::Save:PAR:U_NR = PAR:U_NR + 1
      END
      PAR:Record = SAV::PAR:Record
      PAR:U_NR = Auto::Save:PAR:U_NR
      SAV::PAR:Record = PAR:Record
      ADD(PAR_K)
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
      IF INRANGE(PAR_END_U_NR-PAR:U_NR,1,10)
         KLUDA(45,'PAR_K autonumerâcijas apgabalâ atlikuði '&PAR_END_U_NR-PAR:U_NR&' brîvi ieraksti')
      .
      BREAK
    END
    EXIT
  SAV::PAR:Record = PAR:Record
  Auto::Attempts = 0
  LOOP
    SET(PAR:NR_KEY)
    PREVIOUS(PAR_K)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAR_K')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAR:U_NR = 1
    ELSE
      Auto::Save:PAR:U_NR = PAR:U_NR + 1
    END
    PAR:Record = SAV::PAR:Record
    PAR:U_NR = Auto::Save:PAR:U_NR
    SAV::PAR:Record = PAR:Record
      PAR:Record = SAV::PAR:Record
      PAR_START_U_NR=0
      PAR_END_U_NR=0
      PAR_END_U_NR=GETINIFILE('PAR_END_U_NR',0)
      IF PAR_END_U_NR
         PAR_START_U_NR=PAR_END_U_NR-1000
         IF PAR_START_U_NR<0
            KLUDA(27,'PAR_K autonumerâcijas apgabals '&CLIP(PATH())&'\WINLATS.INI '&CLIP(PAR_START_U_NR)&'-'&CLIP(PAR_END_U_NR))
            PAR_START_U_NR=51
         .
      .
      SAV::PAR:Record = PAR:Record
      Auto::Attempts = 0
      LOOP
    !    IF CON:PAR_END_U_NR
        IF PAR_END_U_NR
           GET(PAR_K,0)
    !       PAR:U_NR=CON:PAR_END_U_NR
           PAR:U_NR=PAR_END_U_NR
           SET(PAR:NR_KEY,PAR:NR_KEY)
           PREVIOUS(PAR_K)
           IF PAR:U_NR < PAR_START_U_NR
              PAR:U_NR=PAR_START_U_NR
    !       ELSIF PAR:U_NR=CON:PAR_END_U_NR
           ELSIF PAR:U_NR=PAR_END_U_NR
              KLUDA(45,'PAR_K autonumerâcijas apgabals aizpildîts, nav vietas jauniem ierakstiem')
              POST(Event:CloseWindow)
              EXIT
           .
        ELSE
           SET(PAR:NR_KEY)
           PREVIOUS(PAR_K)
        .
        IF ERRORCODE() AND ERRORCODE() <> BadRecErr
          StandardWarning(Warn:RecordFetchError,'PAR_K')
          POST(Event:CloseWindow)
          EXIT
        END
        IF ERRORCODE()
          Auto::Save:PAR:U_NR = 1
        ELSE
          Auto::Save:PAR:U_NR = PAR:U_NR + 1
        END
        PAR:Record = SAV::PAR:Record
        PAR:U_NR = Auto::Save:PAR:U_NR
        SAV::PAR:Record = PAR:Record
        ADD(PAR_K)
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
        IF INRANGE(PAR_END_U_NR-PAR:U_NR,1,10)
           KLUDA(45,'PAR_K autonumerâcijas apgabalâ atlikuði '&PAR_END_U_NR-PAR:U_NR&' brîvi ieraksti')
        .
        BREAK
      END
      EXIT
    ADD(PAR_K)
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
        DELETE(PAR_K)
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


!----------------------------------------------------
FLD7::FillList ROUTINE
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
  FLD7::View{Prop:Filter} = ''
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(FLD7::View)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  LOOP
    NEXT(FLD7::View)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'VAL_K')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    FLD7::VAL:V_KODS = VAL:V_KODS
    ADD(Queue:FileDrop:2)
  END
  CLOSE(FLD7::View)
  IF RECORDS(Queue:FileDrop:2)
    IF PAR:V_KODS
      LOOP FLD7::LoopIndex = 1 TO RECORDS(Queue:FileDrop:2)
        GET(Queue:FileDrop:2,FLD7::LoopIndex)
        IF PAR:V_KODS = FLD7::VAL:V_KODS THEN BREAK.
      END
      ?PAR:V_KODS{Prop:Selected} = FLD7::LoopIndex
    END
  ELSE
    CLEAR(PAR:V_KODS)
  END
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
  FLD5::BAN:KODS = PAR:BAN_KODS
  SET(BAN:KOD_KEY)
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
    FLD5::BAN:NOS_S = BAN:NOS_S
    ADD(Queue:FileDropCombo)
  END
  CLOSE(FLD5::View)
  IF RECORDS(Queue:FileDropCombo)
    SORT(Queue:FileDropCombo,FLD5::BAN:KODS)
    IF PAR:BAN_KODS
      LOOP FLD5::LoopIndex = 1 TO RECORDS(Queue:FileDropCombo)
        GET(Queue:FileDropCombo,FLD5::LoopIndex)
        IF PAR:BAN_KODS = FLD5::BAN:KODS THEN BREAK.
      END
      ?PAR:BAN_KODS{Prop:Selected} = FLD5::LoopIndex
    END
  ELSE
    CLEAR(PAR:BAN_KODS)
  END
