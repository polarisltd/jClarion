                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdatePavPas PROCEDURE


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
FORCEDPARCHANGE      BYTE
Forcedatlchange      BYTE
NPK                  BYTE
NOM_NOSAUKUMS        STRING(20)
forcedparadschange   BYTE
DIENA_V              STRING(11)
protext              STRING(15)
FORMATNPK            BYTE
NOS_CENA             DECIMAL(8,2)
CANCEL_OFF  LONG

BRW2::View:Browse    VIEW(NOLPAS)
                       PROJECT(NOS:RS)
                       PROJECT(NOS:KEKSIS)
                       PROJECT(NOS:NOMENKLAT)
                       PROJECT(NOS:KATALOGA_NR)
                       PROJECT(NOS:NOS_S)
                       PROJECT(NOS:DAUDZUMS)
                       PROJECT(NOS:SUMMAV)
                       PROJECT(NOS:SAN_NOS)
                       PROJECT(NOS:ACC_KODS)
                       PROJECT(NOS:PAR_NR)
                       PROJECT(NOS:DOK_NR)
                       PROJECT(NOS:U_NR)
                     END

Queue:Browse:2       QUEUE,PRE()                  ! Browsing Queue
BRW2::NOS:RS           LIKE(NOS:RS)               ! Queue Display field
BRW2::NOS:KEKSIS       LIKE(NOS:KEKSIS)           ! Queue Display field
BRW2::NOS:NOMENKLAT    LIKE(NOS:NOMENKLAT)        ! Queue Display field
BRW2::NOS:KATALOGA_NR  LIKE(NOS:KATALOGA_NR)      ! Queue Display field
BRW2::NOS:NOS_S        LIKE(NOS:NOS_S)            ! Queue Display field
BRW2::NOS:DAUDZUMS     LIKE(NOS:DAUDZUMS)         ! Queue Display field
BRW2::NOS_CENA         LIKE(NOS_CENA)             ! Queue Display field
BRW2::NOS:SUMMAV       LIKE(NOS:SUMMAV)           ! Queue Display field
BRW2::NOS:SAN_NOS      LIKE(NOS:SAN_NOS)          ! Queue Display field
BRW2::NOS:ACC_KODS     LIKE(NOS:ACC_KODS)         ! Queue Display field
BRW2::NOS:PAR_NR       LIKE(NOS:PAR_NR)           ! Queue Display field
BRW2::NOS:DOK_NR       LIKE(NOS:DOK_NR)           ! Queue Display field
BRW2::NOS:U_NR         LIKE(NOS:U_NR)             ! Queue Display field
BRW2::Mark             BYTE                       ! Queue POSITION information
BRW2::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW2::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW2::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW2::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW2::Sort1:Reset:PAS:PAR_NR LIKE(PAS:PAR_NR)
BRW2::Sort2:KeyDistribution LIKE(NOS:NOMENKLAT),DIM(100)
BRW2::Sort2:LowValue LIKE(NOS:NOMENKLAT)          ! Queue position of scroll thumb
BRW2::Sort2:HighValue LIKE(NOS:NOMENKLAT)         ! Queue position of scroll thumb
BRW2::Sort2:Reset:PAS:U_NR LIKE(PAS:U_NR)
BRW2::QuickScan      BYTE                         ! Flag for Range/Filter test
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
BRW2::NPK:Cnt:Value  LONG                         ! Queue position of scroll thumb
BRW2::NPK:Cnt:Temp   LONG                         ! Queue position of scroll thumb
BRW2::PAS:SUMMA:Sum:Value REAL                    ! Queue position of scroll thumb
BRW2::PAS:SUMMA:Sum:Temp REAL                     ! Queue position of scroll thumb
BRW2::PAS:SUMMAV:Sum:Value REAL                   ! Queue position of scroll thumb
BRW2::PAS:SUMMAV:Sum:Temp REAL                    ! Queue position of scroll thumb
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
History::PAS:Record LIKE(PAS:Record),STATIC
SAV::PAS:Record      LIKE(PAS:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:PAS:U_NR     LIKE(PAS:U_NR)
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
FLD7::View           VIEW(VAL_K)
                       PROJECT(VAL:VAL)
                     END
Queue:FileDrop       QUEUE,PRE
FLD7::VAL:VAL          LIKE(VAL:VAL)
                     END
FLD7::LoopIndex      LONG,AUTO
QuickWindow          WINDOW('Pasûtîjumi'),AT(0,0,458,292),FONT('MS Sans Serif',8,,FONT:bold),IMM,HLP('UpdatePAVAD'),GRAY,RESIZE,MDI
                       BUTTON('Slçgts'),AT(3,2,41,14),USE(?ButtonSlegts)
                       IMAGE('CHECK3.ICO'),AT(46,0,17,22),USE(?Imagers),HIDE
                       OPTION('TIPS'),AT(65,1,50,20),USE(PAS:TIPS),BOXED
                         RADIO('L'),AT(69,9),USE(?PAS:TIPS:Radio1)
                         RADIO('K'),AT(89,9),USE(?PAS:TIPS:Radio2)
                       END
                       PROMPT('Dok. &Nr'),AT(116,4,29,10),USE(?PAS:DOK_NR:Prompt)
                       ENTRY(@n_8),AT(147,2),USE(PAS:DOK_NR)
                       PROMPT('Do&k. datums'),AT(192,4,44,10),USE(?PAS:datums:Prompt)
                       SPIN(@D6),AT(236,1,50,15),USE(PAS:DATUMS)
                       BUTTON('&Piegâdâtâjs'),AT(303,2,49,14),USE(?Partneris),FONT(,9,,FONT:bold)
                       STRING(@n_11),AT(355,4),USE(PAS:PAR_NR)
                       STRING(@s15),AT(303,17),USE(PAS:NOKA)
                       PROMPT('&Valûta'),AT(372,17),USE(?PAV:val:Prompt)
                       LIST,AT(399,15,48,14),USE(PAS:val),FORMAT('12L~VAL~@s3@'),DROP(5),FROM(Queue:FileDrop)
                       ENTRY(@s20),AT(197,19),USE(PAS:KOMENT)
                       LIST,AT(10,43,440,217),USE(?Browse:2),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('10R(1)|M~S~C(0)@s1@10C|M~Iz~@n1B@87L(1)|M~Nomenklatûra~C(0)@s21@71L(1)|M~Raþotâj' &|
   'a kods~C(0)@s17@68L(1)|M~Nosaukums~C(0)@s16@44R(1)|M~Daudzums~C(0)@n_11@39R(1)|M' &|
   '~Cena~C(0)@n_10.2@45R(1)|M~Summa Val~C(0)@n_11.2@60R(1)|M~Pasûtîtâjs~C(0)@s15@32' &|
   'L(1)|M~ACC Kods~C(0)@s8@'),FROM(Queue:Browse:2)
                       SHEET,AT(5,23,449,252),USE(?CurrentTab)
                         TAB('&1-Dokumenta saturs'),USE(?Tab:1)
                         END
                         TAB('&2-Raþotâju kodu secîbâ'),USE(?Tab:2)
                         END
                       END
                       STRING('Summa kopâ:'),AT(304,263),USE(?String5),FONT(,9,,FONT:bold)
                       STRING(@n-_11.2),AT(349,263),USE(PAS:SUMMAV)
                       STRING(@n_11.2),AT(394,262),USE(PAS:SUMMA )
                       STRING('Ierakstu skaits:'),AT(166,263,53,10),USE(?String13)
                       STRING(@n3),AT(218,263),USE(NPK)
                       BUTTON('&Ievadît'),AT(205,277,45,14),USE(?Insert:3),FONT(,9,,FONT:bold)
                       BUTTON('&Mainît'),AT(253,277,45,14),USE(?Change:3),FONT(,9,,FONT:bold),DEFAULT
                       BUTTON('&Dzçst'),AT(301,277,45,14),USE(?Delete:3),FONT(,9,,FONT:bold)
                       PROMPT('Komentârs'),AT(160,20),USE(?Prompt4)
                       STRING(@s8),AT(9,279),USE(PAS:ACC_KODS),RIGHT(1),FONT(,,COLOR:Gray,)
                       STRING(@D6),AT(47,279),USE(PAS:ACC_DATUMS),FONT(,,COLOR:Gray,)
                       BUTTON('&OK'),AT(349,277,45,14),USE(?OK),FONT(,9,,FONT:bold)
                       BUTTON('&Atlikt'),AT(402,277,45,14),USE(?Cancel),FONT(,9,,FONT:bold)
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
  IF PAS:RS   !SLÇGTS
     UNHIDE(?IMAGERS)
  ELSE
     HIDE(?IMAGERS)
  .
  DO MODIFYSCREEN
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
    ActionMessage = 'Ieraksts tiks dzçsts'
  END
  QuickWindow{Prop:Text} = ActionMessage
  ENABLE(TBarBrwHistory)
  ACCEPT
    DO MODIFYSCREEN
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
      DO FLD7::FillList
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?ButtonSlegts)
      IF LOCALREQUEST=2
         SELECT(?Browse:2)
      ELSIF LOCALREQUEST=1
         SELECT(?PAS:DOK_NR)
      ELSIF LOCALREQUEST=3
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-2)
         enable(?Tab:1)
         SELECT(?cancel)
      ELSE
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
        History::PAS:Record = PAS:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(PAVPAS)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(PAS:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'PAS:NR_KEY')
                SELECT(?ButtonSlegts)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?ButtonSlegts)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::PAS:Record <> PAS:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:PAVPAS(1)
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
              SELECT(?ButtonSlegts)
              VCRRequest = VCRNone
            ELSE
              IF RecordChanged OR VCRRequest = VCRNone THEN
                LocalResponse = RequestCompleted
              END
              POST(Event:CloseWindow)
            END
            BREAK
          END
        OF DeleteRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            IF RIDelete:PAVPAS()
              SETCURSOR()
              CASE StandardWarning(Warn:DeleteError)
              OF Button:Yes
                CYCLE
              OF Button:No
                POST(Event:CloseWindow)
                BREAK
              OF Button:Cancel
                DISPLAY
                SELECT(?ButtonSlegts)
                VCRRequest = VCRNone
                BREAK
              END
            ELSE
              SETCURSOR()
              LocalResponse = RequestCompleted
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
    OF ?ButtonSlegts
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF pas:rs
           pas:rs=''
           HIDE(?IMAGERS)
        ELSE
           pas:rs='S'    !SLÇDZAM PASÛTÎJUMU
           UNHIDE(?IMAGERS)
        .
        DO BRW2::InitializeBrowse
        DO BRW2::RefreshPage
        display
      END
    OF ?PAS:DOK_NR
      CASE EVENT()
      OF EVENT:Accepted
        DO BRW2::InitializeBrowse   ! Lai nomaina NOLPAS, ja mainâs DOK_NR
        DO BRW2::RefreshPage
      END
    OF ?PAS:DATUMS
      CASE EVENT()
      OF EVENT:Accepted
        !SAV_datums=PAS:datums
        EXECUTE PAS:DATUMS%7+1
           DIENA_V='Svçtdiena'
           DIENA_V='Pirmdiena'
           DIENA_V='Otrdiena'
           DIENA_V='Treðdiena'
           DIENA_V='Ceturtdiena'
           DIENA_V='Piektdiena'
           DIENA_V='Sestdiena'
        .
        !display(?diena_v)
        DO BRW2::InitializeBrowse   ! Lai nomaina NOLPAS, ja mainâs datums
        DO BRW2::RefreshPage
      END
    OF ?Partneris
      CASE EVENT()
      OF EVENT:Accepted
        PAR_NR=PAS:PAR_NR
        
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GlobalResponse=RequestCompleted
           IF ~PAR:NOS_U
              KLUDA(87,'Raþotâja kods')
           ELSE
              paS:par_nr=PAR:U_nr
              paS:noka=PAR:NOS_S
              DISPLAY(?PAS:NOKA)
           .
        .
        DO BRW2::InitializeBrowse   ! Lai nomaina NOLPAS, ja mainâs Piegâdâtâjs ?????????????
        DO BRW2::RefreshPage
      END
    OF ?PAS:val
      CASE EVENT()
      OF EVENT:Accepted
        DO BRW2::InitializeBrowse  !Lai nomaina NOLPAS, ja mainîta valûta
        DO BRW2::RefreshPage
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
          OF 5
          OF 6
          OF 7
            DO BRW2::AssignButtons
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
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
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
         PAS:ACC_KODS=ACC_kods
         PAS:ACC_DATUMS=today()
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
  IF NOLPAS::Used = 0
    CheckOpen(NOLPAS,1)
  END
  NOLPAS::Used += 1
  BIND(NOS:RECORD)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  IF PAVPAS::Used = 0
    CheckOpen(PAVPAS,1)
  END
  PAVPAS::Used += 1
  BIND(PAS:RECORD)
  IF VAL_K::Used = 0
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  BIND(VAL:RECORD)
  FilesOpened = True
  RISnap:PAVPAS
  SAV::PAS:Record = PAS:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    PAS:DATUMS=TODAY()
    PAS:ACC_KODS=ACC_kods
    PAS:ACC_DATUMS=today()
    PAS:TIPS='L'
    IF PAR_NR     !IZSAUKTS NO STATISTIKAS
       PAS:NOKA=GETPAR_K(PAR_NR,2,1)
       PAS:PAR_NR=PAR_NR
    .
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('UpdatePavPas','winlats.INI')
  WinResize.Resize
  BRW2::AddQueue = True
  BRW2::RecordCount = 0
  BIND('BRW2::Sort2:Reset:PAS:U_NR',BRW2::Sort2:Reset:PAS:U_NR)
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?Browse:2{Prop:Alrt,255} = InsertKey
  ?Browse:2{Prop:Alrt,254} = DeleteKey
  ?Browse:2{Prop:Alrt,253} = CtrlEnter
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?PAS:TIPS{PROP:Alrt,255} = 734
  ?PAS:DOK_NR{PROP:Alrt,255} = 734
  ?PAS:DATUMS{PROP:Alrt,255} = 734
  ?PAS:PAR_NR{PROP:Alrt,255} = 734
  ?PAS:NOKA{PROP:Alrt,255} = 734
  ?PAS:val{PROP:Alrt,255} = 734
  ?PAS:KOMENT{PROP:Alrt,255} = 734
  ?PAS:SUMMAV{PROP:Alrt,255} = 734
  ?PAS:ACC_KODS{PROP:Alrt,255} = 734
  ?PAS:ACC_DATUMS{PROP:Alrt,255} = 734
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
    NOLPAS::Used -= 1
    IF NOLPAS::Used = 0 THEN CLOSE(NOLPAS).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    PAVPAS::Used -= 1
    IF PAVPAS::Used = 0 THEN CLOSE(PAVPAS).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
  END
  IF WindowOpened
    INISaveWindow('UpdatePavPas','winlats.INI')
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
MODIFYSCREEN  ROUTINE
 IF LOCALREQUEST
    CASE LOCALREQUEST
    OF 1
       IF RECORDS(Queue:Browse:2)
          DISABLE(?CANCEL)
          ALIAS(EscKey,0) ! Novâcam EscKey
       ELSE
          ENABLE(?CANCEL)
          ALIAS
       .
    OF 2
       IF CANCEL_OFF
          DISABLE(?CANCEL)
          ALIAS(EscKey,0) ! Novâcam EscKey
       ELSE
          ENABLE(?CANCEL)
          ALIAS
       .
    .
 .
! stop('accloop')
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
  IF CHOICE(?CurrentTab) = 2
    BRW2::SortOrder = 1
  ELSE
    BRW2::SortOrder = 2
  END
  IF BRW2::SortOrder = BRW2::LastSortOrder
    CASE BRW2::SortOrder
    OF 1
      IF BRW2::Sort1:Reset:PAS:PAR_NR <> PAS:PAR_NR
        BRW2::Changed = True
      END
    OF 2
      IF BRW2::Sort2:Reset:PAS:U_NR <> PAS:U_NR
        BRW2::Changed = True
      END
    END
  ELSE
  END
  IF BRW2::SortOrder <> BRW2::LastSortOrder OR BRW2::Changed OR ForceRefresh
    CASE BRW2::SortOrder
    OF 1
      BRW2::Sort1:Reset:PAS:PAR_NR = PAS:PAR_NR
    OF 2
      BRW2::Sort2:Reset:PAS:U_NR = PAS:U_NR
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
  IF SEND(NOLPAS,'QUICKSCAN=on').
  SETCURSOR(Cursor:Wait)
  DO BRW2::Reset
  BRW2::NPK:Cnt:Value = 0
  BRW2::PAS:SUMMA:Sum:Value = 0
  BRW2::PAS:SUMMAV:Sum:Value = 0
  LOOP
    NEXT(BRW2::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW2::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'NOLPAS')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW2::FillQueue
    BRW2::NPK:Cnt:Value += 1
    BRW2::PAS:SUMMA:Sum:Value += NOS:SUMMA
    BRW2::PAS:SUMMAV:Sum:Value += NOS:SUMMAV
    !***********DOK_NR kontrole**********
    IF ~(NOS:DOK_NR=PAS:DOK_NR)
       NOS:DOK_NR=PAS:DOK_NR
       IF RIUPDATE:NOLPAS()
         KLUDA(24,'NOLPAS')
       .
       CANCEL_OFF=TRUE
    .
    !***********valûtas un valûtas pârrçíinu kontrole**********
    IF ~(NOS:VAL=PAS:VAL)
       NOS:VAL=PAS:VAL
       NOS:SUMMA=NOS:SUMMAV*BANKURS(NOS:VAL,NOS:DATUMS,,1)  !testa kurss
       IF RIUPDATE:NOLPAS()
         KLUDA(24,'NOLPAS')
       .
       CANCEL_OFF=TRUE
    .
    !***********datumu (un valûtas pârrçíinu) kontrole**********
    IF ~(NOS:DATUMS=PAS:DATUMS)
       NOS:DATUMS=PAS:DATUMS
       NOS:SUMMA=NOS:SUMMAV*BANKURS(NOS:VAL,NOS:DATUMS,,1)   !testa kurss
       IF RIUPDATE:NOLPAS()
         KLUDA(24,'NOLPAS')
       .
       CANCEL_OFF=TRUE
    .
    !***********raksta statusa kontrole (PASÛTÎJUMS ATVÇRTS/SLÇGTS)**********
    IF ~(NOS:rs=PAS:rs)
       NOS:rs=PAS:rs
       IF RIUPDATE:NOLPAS()
         KLUDA(24,'NOLPAS')
       .
       CANCEL_OFF=TRUE
    .
    !***********partneru kontrole**********
    IF ~(NOS:par_nr=PAS:par_nr)
       NOS:par_nr=PAS:par_nr
       IF RIUPDATE:NOLPAS()
         KLUDA(24,'NOLPAS')
       .
       CANCEL_OFF=TRUE
    .
  END
  NPK = BRW2::NPK:Cnt:Value
  PAS:SUMMA = BRW2::PAS:SUMMA:Sum:Value
  PAS:SUMMAV = BRW2::PAS:SUMMAV:Sum:Value
  SETCURSOR()
  DO BRW2::Reset
  PREVIOUS(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NOLPAS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 2
    BRW2::Sort2:HighValue = NOS:NOMENKLAT
  END
  DO BRW2::Reset
  NEXT(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NOLPAS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 2
    BRW2::Sort2:LowValue = NOS:NOMENKLAT
    SetupStringStops(BRW2::Sort2:LowValue,BRW2::Sort2:HighValue,SIZE(BRW2::Sort2:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW2::ScrollRecordCount = 1 TO 100
      BRW2::Sort2:KeyDistribution[BRW2::ScrollRecordCount] = NextStringStop()
    END
  END
  IF SEND(NOLPAS,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW2::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  NOS:RS = BRW2::NOS:RS
  NOS:KEKSIS = BRW2::NOS:KEKSIS
  NOS:NOMENKLAT = BRW2::NOS:NOMENKLAT
  NOS:KATALOGA_NR = BRW2::NOS:KATALOGA_NR
  NOS:NOS_S = BRW2::NOS:NOS_S
  NOS:DAUDZUMS = BRW2::NOS:DAUDZUMS
  NOS_CENA = BRW2::NOS_CENA
  NOS:SUMMAV = BRW2::NOS:SUMMAV
  NOS:SAN_NOS = BRW2::NOS:SAN_NOS
  NOS:ACC_KODS = BRW2::NOS:ACC_KODS
  NOS:PAR_NR = BRW2::NOS:PAR_NR
  NOS:DOK_NR = BRW2::NOS:DOK_NR
  NOS:U_NR = BRW2::NOS:U_NR
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
   nom_nosaukums=getnom_k(nos:nomenklat,0,2)
   nos_cena=nos:summav/nos:daudzums
  BRW2::NOS:RS = NOS:RS
  BRW2::NOS:KEKSIS = NOS:KEKSIS
  BRW2::NOS:NOMENKLAT = NOS:NOMENKLAT
  BRW2::NOS:KATALOGA_NR = NOS:KATALOGA_NR
  BRW2::NOS:NOS_S = NOS:NOS_S
  BRW2::NOS:DAUDZUMS = NOS:DAUDZUMS
  BRW2::NOS_CENA = NOS_CENA
  BRW2::NOS:SUMMAV = NOS:SUMMAV
  BRW2::NOS:SAN_NOS = NOS:SAN_NOS
  BRW2::NOS:ACC_KODS = NOS:ACC_KODS
  BRW2::NOS:PAR_NR = NOS:PAR_NR
  BRW2::NOS:DOK_NR = NOS:DOK_NR
  BRW2::NOS:U_NR = NOS:U_NR
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
      OF 2
        LOOP BRW2::CurrentScroll = 1 TO 100
          IF BRW2::Sort2:KeyDistribution[BRW2::CurrentScroll] => UPPER(NOS:NOMENKLAT)
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
  CASE BRW2::SortOrder
  OF 1
    BRW2::CurrentScroll = 50                      ! Move Thumb to center
    IF BRW2::RecordCount = ?Browse:2{Prop:Items}
      IF BRW2::ItemsToFill
        IF BRW2::CurrentEvent = Event:ScrollUp
          BRW2::CurrentScroll = 0
        ELSE
          BRW2::CurrentScroll = 100
        END
      END
    ELSE
      BRW2::CurrentScroll = 0
    END
  END
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
    OF 2
      NOS:NOMENKLAT = BRW2::Sort2:KeyDistribution[?Browse:2{Prop:VScrollPos}]
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
  IF BRW2::ItemsToFill > 1
    IF SEND(NOLPAS,'QUICKSCAN=on').
    BRW2::QuickScan = True
  END
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
        StandardWarning(Warn:RecordFetchError,'NOLPAS')
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
  IF BRW2::QuickScan
    IF SEND(NOLPAS,'QUICKSCAN=off').
    BRW2::QuickScan = False
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
      BRW2::HighlightedPosition = POSITION(NOS:PAR_KEY)
      RESET(NOS:PAR_KEY,BRW2::HighlightedPosition)
    ELSE
      NOS:PAR_NR = PAS:PAR_NR
      SET(NOS:PAR_KEY,NOS:PAR_KEY)
    END
    BRW2::View:Browse{Prop:Filter} = |
    'NOS:PAR_NR = PAS:PAR_NR AND (NOS:DOK_NR=PAS:DOK_NR)'
  OF 2
    IF BRW2::LocateMode = LocateOnEdit
      BRW2::HighlightedPosition = POSITION(NOS:NR_KEY)
      RESET(NOS:NR_KEY,BRW2::HighlightedPosition)
    ELSE
      NOS:U_NR = PAS:U_NR
      SET(NOS:NR_KEY,NOS:NR_KEY)
    END
    BRW2::View:Browse{Prop:Filter} = |
    'NOS:U_NR = BRW2::Sort2:Reset:PAS:U_NR'
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
    CLEAR(NOS:Record)
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
    NOS:PAR_NR = PAS:PAR_NR
    SET(NOS:PAR_KEY)
    BRW2::View:Browse{Prop:Filter} = |
    'NOS:PAR_NR = PAS:PAR_NR AND (NOS:DOK_NR=PAS:DOK_NR)'
  OF 2
    NOS:U_NR = PAS:U_NR
    SET(NOS:NR_KEY)
    BRW2::View:Browse{Prop:Filter} = |
    'NOS:U_NR = BRW2::Sort2:Reset:PAS:U_NR'
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
    PAS:PAR_NR = BRW2::Sort1:Reset:PAS:PAR_NR
  OF 2
    PAS:U_NR = BRW2::Sort2:Reset:PAS:U_NR
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
  GET(NOLPAS,0)
  CLEAR(NOS:Record,0)
  CASE BRW2::SortOrder
  OF 1
    NOS:PAR_NR = BRW2::Sort1:Reset:PAS:PAR_NR
  OF 2
    NOS:U_NR = BRW2::Sort2:Reset:PAS:U_NR
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
!| (UpdateNolPas) is called.
!|
!| Upon return from the update, the routine BRW2::Reset is called to reset the VIEW
!| and reopen it.
!|
  IF pas:rs='S'    !SLÇGTS PASÛTÎJUMS
     KLUDA(0,'SLÇGTS PASÛTÎJUMS')
     GLOBALREQUEST=0
  .
  CLOSE(BRW2::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateNolPas
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
        GET(NOLPAS,0)
        CLEAR(NOS:Record,0)
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
    OF ?PAS:TIPS
      PAS:TIPS = History::PAS:Record.TIPS
    OF ?PAS:DOK_NR
      PAS:DOK_NR = History::PAS:Record.DOK_NR
    OF ?PAS:DATUMS
      PAS:DATUMS = History::PAS:Record.DATUMS
    OF ?PAS:PAR_NR
      PAS:PAR_NR = History::PAS:Record.PAR_NR
    OF ?PAS:NOKA
      PAS:NOKA = History::PAS:Record.NOKA
    OF ?PAS:val
      PAS:val = History::PAS:Record.val
    OF ?PAS:KOMENT
      PAS:KOMENT = History::PAS:Record.KOMENT
    OF ?PAS:SUMMAV
      PAS:SUMMAV = History::PAS:Record.SUMMAV
    OF ?PAS:ACC_KODS
      PAS:ACC_KODS = History::PAS:Record.ACC_KODS
    OF ?PAS:ACC_DATUMS
      PAS:ACC_DATUMS = History::PAS:Record.ACC_DATUMS
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
  PAS:Record = SAV::PAS:Record
  PAS:DATUMS = SAV_DATUMS
  SAV::PAS:Record = PAS:Record
  Auto::Attempts = 0
  LOOP
    SET(PAS:NR_KEY)
    PREVIOUS(PAVPAS)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVPAS')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAS:U_NR = 1
    ELSE
      Auto::Save:PAS:U_NR = PAS:U_NR + 1
    END
    PAS:Record = SAV::PAS:Record
    PAS:U_NR = Auto::Save:PAS:U_NR
    SAV::PAS:Record = PAS:Record
    ADD(PAVPAS)
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
        DELETE(PAVPAS)
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
    FLD7::VAL:VAL = VAL:VAL
    ADD(Queue:FileDrop)
  END
  CLOSE(FLD7::View)
  IF RECORDS(Queue:FileDrop)
    IF PAS:val
      LOOP FLD7::LoopIndex = 1 TO RECORDS(Queue:FileDrop)
        GET(Queue:FileDrop,FLD7::LoopIndex)
        IF PAS:val = FLD7::VAL:VAL THEN BREAK.
      END
      ?PAS:val{Prop:Selected} = FLD7::LoopIndex
    END
  ELSE
    CLEAR(PAS:val)
  END
UpdateNolPas PROCEDURE


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
statuss              STRING(1)
NOM_ATLIKUMS         DECIMAL(11,3)
NOM_PIEEJAMS         DECIMAL(11,3)
SUMMA_KOPA           DECIMAL(13,3)
SUMMA_A              DECIMAL(7,2)
summa_apm            DECIMAL(13,3)
PIEKTA               DECIMAL(12,3)
PIC                  DECIMAL(9,3)
VAL5                 STRING(3)
ARPVN                STRING(7),DIM(5)
DKSTRING             STRING(30)
SAV_NOMENKLAT        STRING(2115)
SAV_D_K              STRING(1)
SAV_DAUDZUMS         DECIMAL(11,3)
NEW_DAUDZUMS         DECIMAL(11,3)
SAV_SUMMA            DECIMAL(11,2)
NOL_SUMMA            DECIMAL(11,2)
ProText              STRING(15)
Pasutitajs           STRING(15)
CENA                 DECIMAL(10,3)
CEN_VAL              STRING(3)
auto_text            STRING(30)
Update::Reloop  BYTE
Update::Error   BYTE
History::NOS:Record LIKE(NOS:Record),STATIC
SAV::NOS:Record      LIKE(NOS:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the NOLIK File'),AT(,,434,178),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('UpdateNOLIK'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(2,7,186,148),USE(?Sheet2)
                         TAB('Dati no NOM_k'),USE(?Tab2)
                           STRING(@s30),AT(63,7),USE(DKSTRING),CENTER,FONT(,,,FONT:bold)
                           BUTTON('&Mainît Nomenklatûru'),AT(7,26,80,14),USE(?nomen),FONT(,9,,FONT:bold)
                           STRING(@s30),AT(30,43),USE(NOM:NOS_P)
                           STRING('Kataloga Nr:'),AT(20,53),USE(?String21)
                           STRING(@s17),AT(66,53),USE(NOS:KATALOGA_NR)
                           STRING(@s21),AT(91,30),USE(NOS:NOMENKLAT)
                           PROMPT('Svîtru Kods:'),AT(14,63,47,10),USE(?Prompt17),RIGHT
                           STRING(@n_13),AT(66,63),USE(NOM:KODS),LEFT
                           STRING('Atlikums:'),AT(38,74),USE(?String36),HIDE
                           STRING(@n-_12.3),AT(74,74,52,10),USE(NOM_ATLIKUMS),HIDE,RIGHT
                           STRING(@s7),AT(130,74),USE(NOM:MERVIEN),HIDE
                           STRING('Pieejams:'),AT(38,83),USE(?String36:2),HIDE
                           STRING(@n-_12.3),AT(74,83,52,10),USE(NOM_PIEEJAMS),HIDE,RIGHT
                           BUTTON('&Uzbûvçt Nomenklatûru'),AT(8,135,80,14),USE(?UzbuvetNom ),HIDE,FONT(,9,,FONT:bold)
                           STRING('EsKn kods:'),AT(21,94),USE(?String221:2)
                           STRING(@n_8),AT(55,94),USE(NOM:MUITAS_KODS)
                           STRING('Izc v.kods:'),AT(21,104),USE(?String321:2)
                           STRING(@s2),AT(80,104),USE(NOM:IZC_V_KODS)
                           STRING('Svars:'),AT(21,114),USE(?String421:2)
                           STRING(@n_7.3),AT(59,114),USE(NOM:SVARSKG)
                         END
                       END
                       SHEET,AT(192,6,227,148),USE(?CurrentTab)
                         TAB('&1-Pasûtîjuma saturs'),USE(?Tab:1)
                           STRING(@n_9),AT(374,22),USE(NOS:PAR_NR),FONT(,,COLOR:Gray,)
                           PROMPT('&Daudzums:'),AT(209,36),USE(?NOL:DAUDZUMS:Prompt)
                           ENTRY(@n-15.3),AT(251,33),USE(NOS:DAUDZUMS)
                           STRING(@n_9),AT(374,31),USE(NOS:DOK_NR),FONT(,,COLOR:Gray,)
                           STRING(@n_11.3),AT(321,36),USE(CENA)
                           ENTRY(@n-15.2),AT(251,49),USE(NOS:SUMMAV)
                           STRING(@s3),AT(319,52),USE(NOS:val)
                           PROMPT('&Summa:'),AT(210,52),USE(?NOL:SUMMAV:Prompt)
                           STRING('Ls'),AT(319,65),USE(?String3)
                           STRING('Noliktava:'),AT(245,78),USE(?String16)
                           ENTRY(@n3),AT(287,78),USE(NOS:NOL_NR)
                           STRING(@n-15.2),AT(256,65),USE(NOS:SUMMA),RIGHT(1)
                           BUTTON('&Preces Pasûtîtâjs'),AT(211,92,69,14),USE(?ButtonPasûtîtâjs)
                           ENTRY(@s15),AT(287,92),USE(NOS:SAN_NOS)
                           STRING(@n13),AT(358,92),USE(NOS:SAN_NR)
                           PROMPT('&Lîgumcena:'),AT(243,108),USE(?NOS:LIGUMCENA:Prompt)
                           ENTRY(@n-15.2),AT(287,105,45,12),USE(NOS:LIGUMCENA)
                           STRING('Ls ar PVN'),AT(335,108),USE(?String3:2)
                           PROMPT('&Komentârs:'),AT(243,121),USE(?NOS:KOMENTARS:Prompt)
                           BUTTON('Auto'),AT(212,135,69,14),USE(?ButtonPasûtîtâjs:2)
                           STRING(@s30),AT(287,136),USE(auto_text)
                           ENTRY(@s25),AT(287,118),USE(NOS:KOMENTARS)
                         END
                         TAB('&2-Izpildîts'),USE(?Tab3)
                           STRING(@n13),AT(364,22),USE(NOS:PAR_KE)
                           PROMPT('Pçc tekoðâ invoisa:'),AT(222,30),USE(?NOS:T_DAUDZUMS:Prompt)
                           ENTRY(@n-15.3),AT(293,30),USE(NOS:T_DAUDZUMS)
                           PROMPT('Iepriekð izpildîts :'),AT(227,46,62,10),USE(?NOS:I_DAUDZUMS:Prompt),LEFT
                           ENTRY(@n-15.3),AT(293,44),USE(NOS:I_DAUDZUMS)
                           OPTION('Iz - Izpildîðanas statuss:'),AT(201,62,213,60),USE(NOS:KEKSIS),BOXED
                             RADIO('  -jâiekïauj tekoðajâ importa plûsmâ '),AT(207,73),USE(?NOS:KEKSIS:Radio1),VALUE('0')
                             RADIO('1 -nav jâiekïauj tekoðajâ importa plûsmâ'),AT(207,84),USE(?NOS:KEKSIS:Radio2),VALUE('1')
                             RADIO('2 -iepriekð daïçji piegâdâts, nav jâiekïauj'),AT(207,92),USE(?NOS:KEKSIS:Radio3),VALUE('2')
                             RADIO('3 -iepriekð pilnîgi piegâdâts, nav jâiekïauj, nav jâpiedâvâ'),AT(207,100),USE(?NOS:KEKSIS:Radio4),VALUE('3')
                             RADIO('4 -iepriekð nepilnîgi piegâdâts, nav jâiekïauj, nav jâpiedâvâ'),AT(207,110),USE(?NOS:KEKSIS:Radio5),VALUE('4')
                           END
                         END
                       END
                       BUTTON('&OK'),AT(319,159,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(371,159,45,14),USE(?Cancel)
                       STRING(@s8),AT(6,162),USE(NOS:ACC_KODS),RIGHT(1),FONT(,,COLOR:Gray,)
                       STRING(@D6),AT(45,162),USE(NOS:ACC_DATUMS),FONT(,,COLOR:Gray,)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  ! PIRMS CLARIS ATRAUJ FAILUS
  IF ~CENA
     CENA=NOS:SUMMAV/NOS:DAUDZUMS
  .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
   IF LOCALREQUEST=2
      IF ~GETNOM_K(NOS:NOMENKLAT,2,1)
         UNHIDE(?UZBUVETNOM)
      .
      AUTO_TEXT=GETAUTO(NOS:AUT_NR,5)
   .
   SELECT(?NOS:DAUDZUMS)
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Pievienot pasûtîjumu'
  OF ChangeRecord
    ActionMessage = 'Mainît pasûtîjumu'
  OF DeleteRecord
    ActionMessage = 'Dzçst pasûtîjumu'
  END
  QuickWindow{Prop:Text} = ActionMessage
  ENABLE(TBarBrwHistory)
  ACCEPT
     noS:summa=noS:summav*bankurs(noS:VAL,noS:datums,,1)  !TESTA KURSS
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
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?DKSTRING)
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
        History::NOS:Record = NOS:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(NOLPAS)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?DKSTRING)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::NOS:Record <> NOS:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:NOLPAS(1)
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
              SELECT(?DKSTRING)
              VCRRequest = VCRNone
            ELSE
              IF RecordChanged OR VCRRequest = VCRNone THEN
                LocalResponse = RequestCompleted
              END
              POST(Event:CloseWindow)
            END
            BREAK
          END
        OF DeleteRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            IF RIDelete:NOLPAS()
              SETCURSOR()
              CASE StandardWarning(Warn:DeleteError)
              OF Button:Yes
                CYCLE
              OF Button:No
                POST(Event:CloseWindow)
                BREAK
              OF Button:Cancel
                DISPLAY
                SELECT(?DKSTRING)
                VCRRequest = VCRNone
                BREAK
              END
            ELSE
              SETCURSOR()
              LocalResponse = RequestCompleted
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
    OF ?nomen
      CASE EVENT()
      OF EVENT:Accepted
        NOMENKLAT=NOS:NOMENKLAT
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNOM_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           DO NOMTONOL
           SELECT(?NOS:DAUDZUMS)
        .
      END
    OF ?UzbuvetNom 
      CASE EVENT()
      OF EVENT:Accepted
        NOM:KATALOGA_NR=NOS:KATALOGA_NR
        DO SyncWindow
        GlobalRequest = InsertRecord
        UpdateNOM_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           DO NOMTONOL
           SELECT(?NOS:DAUDZUMS)
        .
                                 
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
    OF ?NOS:DAUDZUMS
      CASE EVENT()
      OF EVENT:Accepted
        DO SUMMAS
      END
    OF ?NOS:SUMMAV
      CASE EVENT()
      OF EVENT:Accepted
        CENA=NOS:SUMMAV/NOS:DAUDZUMS
        DO SUMMAS
      END
    OF ?ButtonPasûtîtâjs
      CASE EVENT()
      OF EVENT:Accepted
        PAR_NR=NOS:SAN_nr
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GlobalResponse=RequestCompleted
            nos:SAN_nr=PAR:U_nr
            nos:SAN_nos=PAR:NOS_S
            DISPLAY
         .
      END
    OF ?ButtonPasûtîtâjs:2
      CASE EVENT()
      OF EVENT:Accepted
        AUT_NR=NOS:AUT_NR
        PAV::U_NR=999999999    !LAI UZLIEK PAR_FILTRU
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseAuto 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GlobalResponse=RequestCompleted
            nos:AUT_nr=AUT:U_nr
            AUTO_TEXT=GETAUTO(NOS:AUT_NR,5)
            DISPLAY
         .
      END
    OF ?NOS:KEKSIS
      CASE EVENT()
      OF EVENT:Accepted
        IF INRANGE(nos:keksis,3,4)
           NOS:PAR_KE=0
        ELSE
           NOS:PAR_KE=NOS:PAR_NR
        .
        DISPLAY
        
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        NOMENKLAT=NOS:NOMENKLAT   !LAI ATCERÂS TABULAI PIE NÂKOÐÂS IZVÇLES
        NOS:ACC_KODS=ACC_KODS
        NOS:ACC_DATUMS=TODAY()
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
  IF KOMPLEKT::Used = 0
    CheckOpen(KOMPLEKT,1)
  END
  KOMPLEKT::Used += 1
  BIND(KOM:RECORD)
  IF NOLPAS::Used = 0
    CheckOpen(NOLPAS,1)
  END
  NOLPAS::Used += 1
  BIND(NOS:RECORD)
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
  IF PAVPAS::Used = 0
    CheckOpen(PAVPAS,1)
  END
  PAVPAS::Used += 1
  BIND(PAS:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  RISnap:NOLPAS
  SAV::NOS:Record = NOS:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
     NOS:NOMENKLAT=getnom_k('OBLIGÂTI JÂIZSAUC',1,1)
     NOS:KATALOGA_NR=NOM:KATALOGA_NR
     IF GLOBALRESPONSE=REQUESTCOMPLETED
        NOS:ACC_KODS=ACC_KODS
        NOS:ACC_DATUMS=TODAY()
        CHECKOPEN(CENUVEST,1)
        CLEAR(CEN:RECORD)
        CENA=0
        CEN_VAL=''
        CEN:KATALOGA_NR=NOS:KATALOGA_NR
        CEN:NOS_U=NOS:NOMENKLAT[19:21]
        SET(CEN:KAT_KEY,CEN:KAT_KEY)
        LOOP
           NEXT(CENUVEST)
           IF ERROR() OR ~(CEN:KATALOGA_NR=NOS:KATALOGA_NR AND CEN:NOS_U=NOS:NOMENKLAT[19:21]) THEN BREAK.
           CENA=CEN:CENA
           CEN_VAL=CEN:VALUTA
        .
        IF ~PAS:VAL AND CEN_VAL      !VÇL NAV DEFINÇTA P/Z VALÛTA
           PAS:VAL=CEN_VAL
        ELSIF ~PAS:VAL AND ~CEN_VAL  !VÇL NAV DEFINÇTA P/Z VALÛTA UN NAV ATRASTA PÇDÇJÂ CENA
           GLOBALREQUEST=SELECTRECORD
           BROWSEVAL_K
           IF GLOBALRESPONSE=REQUESTCOMPLETED
              PAS:VAL=VAL:VAL
           ELSE
              PAS:VAL='EUR'
           .
        ELSIF ~(PAS:VAL=CEN_VAL AND CEN_VAL)
           KLUDA(76,'ignorçju cenu: '&cena&' '&cen_val)
           CENA=0
        .
        CLEAR(NOS:RECORD)
        NOS:U_NR=PAS:U_NR
        NOS:DATUMS=PAS:DATUMS
        NOS:DOK_NR=PAS:DOK_NR
        NOS:NOMENKLAT=NOM:nomenklat
        NOS:KATALOGA_NR=NOM:KATALOGA_NR
        NOS:PAR_NR=PAS:PAR_NR
        NOS:PAR_KE=PAS:PAR_NR
        IF CL_NR=1237
           NOS:NOL_NR=14              !PIEÐÛTS GAG
        ELSE
           NOS:NOL_NR=LOC_NR
        .
        NOS:VAL=PAS:VAL
        DO NOMTONOL
     ELSE
       DO PROCEDURERETURN
     .
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  IF WindowPosInit THEN
    SETPOSITION(0,WindowXPos,WindowYPos)
  ELSE
    GETPOSITION(0,WindowXPos,WindowYPos)
    WindowPosInit=True
  END
  ?NOS:KATALOGA_NR{PROP:Alrt,255} = 734
  ?NOS:NOMENKLAT{PROP:Alrt,255} = 734
  ?NOS:PAR_NR{PROP:Alrt,255} = 734
  ?NOS:DAUDZUMS{PROP:Alrt,255} = 734
  ?NOS:DOK_NR{PROP:Alrt,255} = 734
  ?NOS:SUMMAV{PROP:Alrt,255} = 734
  ?NOS:val{PROP:Alrt,255} = 734
  ?NOS:NOL_NR{PROP:Alrt,255} = 734
  ?NOS:SUMMA{PROP:Alrt,255} = 734
  ?NOS:SAN_NOS{PROP:Alrt,255} = 734
  ?NOS:SAN_NR{PROP:Alrt,255} = 734
  ?NOS:LIGUMCENA{PROP:Alrt,255} = 734
  ?NOS:KOMENTARS{PROP:Alrt,255} = 734
  ?NOS:PAR_KE{PROP:Alrt,255} = 734
  ?NOS:T_DAUDZUMS{PROP:Alrt,255} = 734
  ?NOS:I_DAUDZUMS{PROP:Alrt,255} = 734
  ?NOS:KEKSIS{PROP:Alrt,255} = 734
  ?NOS:ACC_KODS{PROP:Alrt,255} = 734
  ?NOS:ACC_DATUMS{PROP:Alrt,255} = 734
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
    KOMPLEKT::Used -= 1
    IF KOMPLEKT::Used = 0 THEN CLOSE(KOMPLEKT).
    NOLPAS::Used -= 1
    IF NOLPAS::Used = 0 THEN CLOSE(NOLPAS).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAVPAS::Used -= 1
    IF PAVPAS::Used = 0 THEN CLOSE(PAVPAS).
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
   ! IZSAUC, JA PIEPRASA PÂRRÇÍINÂT
!   NOL:SUMMAV = GETNOM_K(NOL:NOMENKLAT,2,7)*NOL:DAUDZUMS
!   nol:summa  =nol:summav*bankurs(nol:VAL,nol:datums)
!   DO ARBYTE
!   SUMMA_KOPA =CALCSUM(12,2)
!   SUMMA_A    =CALCSUM(8,3)   !ATLAIDE
!   SUMMA_APM  =CALCSUM(4,4)

NOMTONOL  ROUTINE
   ! IZSAUC, JA MAINA NOMENKLATÛRU(KATALOGA Nr), VAI IEVADA JAUNU
   NOS:NOMENKLAT=NOM:NOMENKLAT
   NOS:kataloga_nr=NOM:kataloga_nr
   NOS:PVN_PROC=NOM:PVN_PROC
   NOS:NOS_S=NOM:NOS_S
   NOM_ATLIKUMS=GETNOM_A(NOS:NOMENKLAT,1,0)
   NOM_PIEEJAMS=NOM_ATLIKUMS-GETNOM_A(NOS:NOMENKLAT,4,0)
   DISPLAY

SUMMAS    ROUTINE
   IF ~NOS:SUMMAV
      CHECKOPEN(CENUVEST,1)
      CLEAR(CEN:RECORD)
      CENA=0
      CEN_VAL=''
      CEN:KATALOGA_NR=NOS:KATALOGA_NR
      CEN:NOS_U=NOS:NOMENKLAT[19:21]
      SET(CEN:KAT_KEY,CEN:KAT_KEY)
      LOOP
         NEXT(CENUVEST)
         IF ERROR() OR ~(CEN:KATALOGA_NR=NOS:KATALOGA_NR AND CEN:NOS_U=NOS:NOMENKLAT[19:21]) THEN BREAK.
         CENA=CEN:CENA
         CEN_VAL=CEN:VALUTA
      .
   .
   NOS:SUMMAV=NOS:DAUDZUMS*CENA
   NOS:SUMMA=NOS:SUMMAV*BANKURS(NOS:VAL,NOS:DATUMS,,1) ! TESTA KURSS
   DISPLAY
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?NOS:KATALOGA_NR
      NOS:KATALOGA_NR = History::NOS:Record.KATALOGA_NR
    OF ?NOS:NOMENKLAT
      NOS:NOMENKLAT = History::NOS:Record.NOMENKLAT
    OF ?NOS:PAR_NR
      NOS:PAR_NR = History::NOS:Record.PAR_NR
    OF ?NOS:DAUDZUMS
      NOS:DAUDZUMS = History::NOS:Record.DAUDZUMS
    OF ?NOS:DOK_NR
      NOS:DOK_NR = History::NOS:Record.DOK_NR
    OF ?NOS:SUMMAV
      NOS:SUMMAV = History::NOS:Record.SUMMAV
    OF ?NOS:val
      NOS:val = History::NOS:Record.val
    OF ?NOS:NOL_NR
      NOS:NOL_NR = History::NOS:Record.NOL_NR
    OF ?NOS:SUMMA
      NOS:SUMMA = History::NOS:Record.SUMMA
    OF ?NOS:SAN_NOS
      NOS:SAN_NOS = History::NOS:Record.SAN_NOS
    OF ?NOS:SAN_NR
      NOS:SAN_NR = History::NOS:Record.SAN_NR
    OF ?NOS:LIGUMCENA
      NOS:LIGUMCENA = History::NOS:Record.LIGUMCENA
    OF ?NOS:KOMENTARS
      NOS:KOMENTARS = History::NOS:Record.KOMENTARS
    OF ?NOS:PAR_KE
      NOS:PAR_KE = History::NOS:Record.PAR_KE
    OF ?NOS:T_DAUDZUMS
      NOS:T_DAUDZUMS = History::NOS:Record.T_DAUDZUMS
    OF ?NOS:I_DAUDZUMS
      NOS:I_DAUDZUMS = History::NOS:Record.I_DAUDZUMS
    OF ?NOS:KEKSIS
      NOS:KEKSIS = History::NOS:Record.KEKSIS
    OF ?NOS:ACC_KODS
      NOS:ACC_KODS = History::NOS:Record.ACC_KODS
    OF ?NOS:ACC_DATUMS
      NOS:ACC_DATUMS = History::NOS:Record.ACC_DATUMS
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
  NOS:Record = SAV::NOS:Record
  SAV::NOS:Record = NOS:Record
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

BrowseAuto PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
L_par_nr             ULONG
H_Par_Nr             ULONG
PAV_NOKA             STRING(15)
PAV_PAR_NR           ULONG
MODE                 BYTE
VIENS                BYTE(1)
DIVI                 BYTE(2)
SAV_POSITION  STRING(256)
MARKA         STRING(30)
KRASA         STRING(20)
NPK           ULONG

Progresswindow WINDOW('Meklçju auto'),AT(,,137,45),GRAY
       STRING(@s30),AT(6,7),USE(marka)
       STRING(@s20),AT(24,16),USE(krasa)
       STRING(@n8),AT(52,26),USE(npk)
     END


BRW1::View:Browse    VIEW(AUTO)
                       PROJECT(AUT:V_Nr)
                       PROJECT(AUT:Virsb_Nr)
                       PROJECT(AUT:MARKA)
                       PROJECT(AUT:Par_nos)
                       PROJECT(AUT:Vaditajs)
                       PROJECT(AUT:Telefons)
                       PROJECT(AUT:U_NR)
                       PROJECT(AUT:Par_Nr)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::AUT:V_Nr         LIKE(AUT:V_Nr)             ! Queue Display field
BRW1::AUT:Virsb_Nr     LIKE(AUT:Virsb_Nr)         ! Queue Display field
BRW1::AUT:MARKA        LIKE(AUT:MARKA)            ! Queue Display field
BRW1::AUT:Par_nos      LIKE(AUT:Par_nos)          ! Queue Display field
BRW1::AUT:Vaditajs     LIKE(AUT:Vaditajs)         ! Queue Display field
BRW1::AUT:Telefons     LIKE(AUT:Telefons)         ! Queue Display field
BRW1::AUT:U_NR         LIKE(AUT:U_NR)             ! Queue Display field
BRW1::PAR_NR           LIKE(PAR_NR)               ! Queue Display field
BRW1::MODE             LIKE(MODE)                 ! Queue Display field
BRW1::VIENS            LIKE(VIENS)                ! Queue Display field
BRW1::DIVI             LIKE(DIVI)                 ! Queue Display field
BRW1::AUT:Par_Nr       LIKE(AUT:Par_Nr)           ! Queue Display field
BRW1::GL:CLIENT_U_NR   LIKE(GL:CLIENT_U_NR)       ! Queue Display field
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
BRW1::Sort3:KeyDistribution LIKE(AUT:U_NR),DIM(100)
BRW1::Sort3:LowValue LIKE(AUT:U_NR)               ! Queue position of scroll thumb
BRW1::Sort3:HighValue LIKE(AUT:U_NR)              ! Queue position of scroll thumb
BRW1::Sort4:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort4:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort5:KeyDistribution LIKE(AUT:Par_Nr),DIM(100)
BRW1::Sort5:LowValue LIKE(AUT:Par_Nr)             ! Queue position of scroll thumb
BRW1::Sort5:HighValue LIKE(AUT:Par_Nr)            ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Automaðînu saraksts'),AT(,,436,317),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseAuto'),SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&6-Speciâlâs funkcijas'),USE(?6Speciâlâsfunkcijas),DISABLE
                           ITEM('&1-Atrast auto pçc markas un krâsas'),USE(?6Speciâlâsfunkcijas1Atrastautopçcmarkasunkrâsas)
                           ITEM('&2-Atrast nâkoðo ( Ctrl N )'),USE(?6Speciâlâsfunkcijas2AtrastnâkoðoCtrlN),KEY(CtrlN)
                         END
                       END
                       SHEET,AT(4,4,428,288),USE(?CurrentTab)
                         TAB('&5-Îpaðnieku secîba'),USE(?Tab:2),COLOR(,080FFH)
                           BUTTON('&Partneris'),AT(20,275,45,14),USE(?ButtonPartneris)
                         END
                         TAB('&6-Valsts Nr secîba'),USE(?Tab:3),COLOR(,,COLOR:White)
                           ENTRY(@s12),AT(11,276),USE(AUT:V_Nr)
                           STRING('- pçc Valsts Nr'),AT(74,279),USE(?String1)
                         END
                         TAB('&7-Marku secîba'),USE(?Tab:4),COLOR(,,COLOR:White)
                           ENTRY(@s30),AT(10,276,104,13),USE(AUT:MARKA),LEFT
                           STRING('- pçc automarkas'),AT(114,278,56,11),USE(?String3)
                         END
                         TAB('&8-Iekðçjo Nr secîba'),USE(?Tab:5),COLOR(,,COLOR:White)
                         END
                         TAB('&9-Virsbûves Nr secîba'),USE(?Tab:6),COLOR(,,COLOR:White)
                           ENTRY(@s20),AT(9,276),USE(AUT:Virsb_Nr)
                           STRING('- pçc virsbûves Nr'),AT(106,277),USE(?String2)
                         END
                       END
                       LIST,AT(9,21,417,252),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('32L(1)|M~Valsts N~L(2)@s7@80L(2)|M~Virsbûves Nr~@s20@104L(2)|M~Marka~@s25@64L(2)' &|
   '|M~Îpaðnieks~@s15@80L(2)|M~Vadîtâjs~@s35@80L(2)|M~Telefons~@s20@32L(1)|M~U Nr~C(' &|
   '0)@n_7@'),FROM(Queue:Browse:1)
                       BUTTON('Iz&vçlçties'),AT(221,275,45,14),USE(?Select),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                       BUTTON('&Ievadît'),AT(268,275,45,14),USE(?Insert:3)
                       BUTTON('&Mainît'),AT(316,275,45,14),USE(?Change),DEFAULT
                       BUTTON('&Dzçst'),AT(363,275,45,14),USE(?Delete:3)
                       OPTION(' '),AT(10,292,142,20),USE(MODE),BOXED
                         RADIO('mums piesaistîtâs a/m'),AT(14,299),USE(?MODE:Radio1),VALUE('1')
                         RADIO('visas a/m'),AT(101,299),USE(?MODE:Radio2),VALUE('2')
                       END
                       BUTTON('&Atteikties no a/m'),AT(325,297,60,14),USE(?Buttonatteikties),HIDE
                       BUTTON('&Beigt'),AT(387,297,45,14),USE(?Close)
                       BUTTON('&Veiktâ&s apkopes'),AT(259,298,60,14),USE(?ButtonServisaVesture)
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
     QUICKWINDOW{PROP:TEXT}='Izvçlaties a/m'
  .
  IF ~PAV::U_NR                 !NETIEK SAUKTS NO P/Z
     UNHIDE(?BUTTONPARTNERIS)
  ELSIF PAV::U_NR=999999999     !NO PASÛTÎJUMIEM
     UNHIDE(?Buttonatteikties)
     PAV_PAR_NR=NOS:SAN_NR
     PAV_NOKA=GETPAR_K(NOS:SAN_NR,0,1)
  ELSE                          !NO P/Z
     IF ~CHECKSERVISS(PAV:U_NR) !NAV UZBÛVÇTS SERVISS
        UNHIDE(?Buttonatteikties)
     .
     PAV_PAR_NR=PAV:PAR_NR
     PAV_NOKA=GETPAR_K(PAV:PAR_NR,0,1)
  .
  IF ATLAUTS[20]='1'  ! AIZLIEGTS SERVISS
     HIDE(?ButtonServisaVesture)
  .
  MODE=2 !VISAS A/M
  AUT:PAR_NR=GL:CLIENT_U_NR
  GET(AUT:PAR_KEY,AUT:PAR_NR)
  
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
      SELECT(?ButtonPartneris)
      IF PAV::U_NR AND AUT_NR !TIEK SAUKTS NO P/Z VAI PASÛTÎJUMIEM UN IR JAU FIKSÇTA A/M
         CLEAR(AUT:RECORD)
         AUT:U_NR=AUT_NR
         SET(AUT:NR_KEY,AUT:NR_KEY)
         NEXT(AUTO)
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
      !   DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         DO RefreshWindow
         ?tab:4{prop:text}='&7-'&pav_noka
      ELSIF PAV::U_NR AND|  !TIEK SAUKTS NO P/Z VAI PASÛTÎJUMIEM
         CL_NR=1102 OR|     !ADREM
         CL_NR=1464         !AUTO ÎLE
         SELECT(?CurrentTab,2)
      ELSIF PAV::U_NR         !TIEK SAUKTS NO P/Z VAI PASÛTÎJUMIEM
         CLEAR(AUT:RECORD)
         AUT:PAR_NR=PAV_PAR_NR
         GET(AUTO,AUT:PAR_KEY)
         IF ERROR()
            KLUDA(0,CLIP(PAV_NOKA)&' nav piesaistîta neviena a/m')
            MODE=2
         ELSE
            SET(AUT:PAR_KEY,AUT:PAR_KEY)
            NEXT(AUTO)
            BRW1::LocateMode = LocateOnEdit
            DO BRW1::LocateRecord
         !   DO BRW1::InitializeBrowse
            DO BRW1::PostNewSelection
            SELECT(?Browse:1)
            DO RefreshWindow
         .
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
    CASE ACCEPTED()
    OF ?6Speciâlâsfunkcijas1Atrastautopçcmarkasunkrâsas
      DO SyncWindow
       GLOBALREQUEST=SELECTRECORD
       BROWSEAUTOMARKAS
       IF GLOBALRESPONSE=REQUESTCOMPLETED
          MARKA=AMA:MARKA
          GLOBALREQUEST=SELECTRECORD
          BROWSEAUTOKRA
          IF GLOBALRESPONSE=REQUESTCOMPLETED
             KRASA=KRA:KRASA
             OPC#=1
             DO FOUNDIT
          .
       .
    OF ?6Speciâlâsfunkcijas2AtrastnâkoðoCtrlN
      DO SyncWindow
       IF MARKA AND KRASA
          OPC#=2
          DO FOUNDIT
       ELSE
          KLUDA(0,'Nav norâdîta marka/krâsa')
       .
    END
    CASE FIELD()
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
            SELECT(?BROWSE:1)
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?ButtonPartneris
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           CLEAR(AUT:RECORD)
           AUT:PAR_NR=PAR:U_NR
           GET(AUTO,AUT:PAR_KEY)
           IF ERROR()
              KLUDA(88,'neviena '&CLIP(PAR:NOS_S)&' piederoða a/m')
           ELSE
              MODE=2 !VISAS A/M
              LocalRequest = OriginalRequest
              BRW1::LocateMode = LocateOnEdit
              DO BRW1::LocateRecord
              DO BRW1::InitializeBrowse
              DO BRW1::PostNewSelection
              DO BRW1::RefreshPage
           .
        .
        SELECT(?Browse:1)
      END
    OF ?AUT:V_Nr
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?AUT:V_Nr)
        IF AUT:V_Nr
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = AUT:V_Nr
          BRW1::Sort1:LocatorLength = LEN(CLIP(AUT:V_Nr))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
        SELECT(?Browse:1)
      END
    OF ?AUT:MARKA
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?AUT:MARKA)
        IF AUT:MARKA
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort2:LocatorValue = AUT:MARKA
          BRW1::Sort2:LocatorLength = LEN(CLIP(AUT:MARKA))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
        SELECT(?Browse:1)
      END
    OF ?AUT:Virsb_Nr
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?AUT:Virsb_Nr)
        IF AUT:Virsb_Nr
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort4:LocatorValue = AUT:Virsb_Nr
          BRW1::Sort4:LocatorLength = LEN(CLIP(AUT:Virsb_Nr))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
        SELECT(?Browse:1)
      END
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
    OF ?MODE
      CASE EVENT()
      OF EVENT:Accepted
            LocalRequest = OriginalRequest
            BRW1::LocateMode = LocateOnEdit
            DO BRW1::LocateRecord
            DO BRW1::InitializeBrowse
            DO BRW1::PostNewSelection
            DO BRW1::RefreshPage
            SELECT(?BROWSE:1)
      END
    OF ?Buttonatteikties
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LOCALRESPONSE=7 !ATTEIKTIES NO A/M
        BREAK
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?ButtonServisaVesture
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        BrowseAutoApk 
        LocalRequest = OriginalRequest
        DO RefreshWindow
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
  IF GLOBAL::Used = 0
    CheckOpen(GLOBAL,1)
  END
  GLOBAL::Used += 1
  BIND(GL:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowseAuto','winlats.INI')
  WinResize.Resize
  SELECT(?Browse:1)
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select{Prop:Hide} = True
    DISABLE(?Select)
  ELSE
  END
  BIND('PAR_NR',PAR_NR)
  BIND('MODE',MODE)
  BIND('VIENS',VIENS)
  BIND('DIVI',DIVI)
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
    AUTO::Used -= 1
    IF AUTO::Used = 0 THEN CLOSE(AUTO).
    GLOBAL::Used -= 1
    IF GLOBAL::Used = 0 THEN CLOSE(GLOBAL).
  END
  IF WindowOpened
    INISaveWindow('BrowseAuto','winlats.INI')
    CLOSE(QuickWindow)
  END
   PAV::U_NR=0
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
    AUT:V_Nr = BRW1::Sort1:LocatorValue
  OF 2
    AUT:MARKA = BRW1::Sort2:LocatorValue
  OF 4
    AUT:Virsb_Nr = BRW1::Sort4:LocatorValue
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

FOUNDIT     ROUTINE
 DO SYNCWINDOW
 SAV_POSITION=POSITION(AUTO)
 EXECUTE CHOICE(?CurrentTab)
    SET(AUT:PAR_KEY,AUT:PAR_KEY)
    SET(AUT:NR_KEY,AUT:NR_KEY)
    SET(AUT:V_NR_KEY,AUT:V_NR_KEY)
    SET(AUT:VIRSB_KEY,AUT:VIRSB_KEY)
 .
 NEXT(AUTO)
 OPEN(PROGRESSWINDOW)
 FOUND#=0
 NPK=0
 LOOP
    NEXT(AUTO)
    NPK+=1
    DISPLAY
    IF ERROR() THEN BREAK.
    IF AUT:KRASA=KRASA AND AUT:MARKA=MARKA
       CLOSE(PROGRESSWINDOW)
!       GLOBALREQUEST=CHANGERECORD
!       EXECUTE CHECKACCESS(GLOBALREQUEST,ATLAUTS[8])
!          BREAK
!          GLOBALREQUEST=0
!          GLOBALREQUEST=GLOBALREQUEST
!       .
!       UPDATEAUTO
       FOUND#=1
       BREAK
    .
 .
 IF ~FOUND#
    CLOSE(PROGRESSWINDOW)
    KLUDA(0,'Marka '&CLIP(MARKA)&' krâsa '&KRASA&' nav atrodama')
    RESET(AUTO,SAV_POSITION)
    NEXT(AUTO)
 ELSE
    LocalRequest = OriginalRequest
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
    DO BRW1::InitializeBrowse
    DO BRW1::PostNewSelection
    DO BRW1::RefreshPage
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
    OF 1
      BRW1::Sort1:LocatorValue = ''
      BRW1::Sort1:LocatorLength = 0
      AUT:V_Nr = BRW1::Sort1:LocatorValue
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      AUT:MARKA = BRW1::Sort2:LocatorValue
    OF 4
      BRW1::Sort4:LocatorValue = ''
      BRW1::Sort4:LocatorLength = 0
      AUT:Virsb_Nr = BRW1::Sort4:LocatorValue
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
      StandardWarning(Warn:RecordFetchError,'AUTO')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 3
    BRW1::Sort3:HighValue = AUT:U_NR
  OF 5
    BRW1::Sort5:HighValue = AUT:Par_Nr
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'AUTO')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 3
    BRW1::Sort3:LowValue = AUT:U_NR
    SetupRealStops(BRW1::Sort3:LowValue,BRW1::Sort3:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort3:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  OF 5
    BRW1::Sort5:LowValue = AUT:Par_Nr
    SetupRealStops(BRW1::Sort5:LowValue,BRW1::Sort5:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort5:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  AUT:V_Nr = BRW1::AUT:V_Nr
  AUT:Virsb_Nr = BRW1::AUT:Virsb_Nr
  AUT:MARKA = BRW1::AUT:MARKA
  AUT:Par_nos = BRW1::AUT:Par_nos
  AUT:Vaditajs = BRW1::AUT:Vaditajs
  AUT:Telefons = BRW1::AUT:Telefons
  AUT:U_NR = BRW1::AUT:U_NR
  PAR_NR = BRW1::PAR_NR
  MODE = BRW1::MODE
  VIENS = BRW1::VIENS
  DIVI = BRW1::DIVI
  AUT:Par_Nr = BRW1::AUT:Par_Nr
  GL:CLIENT_U_NR = BRW1::GL:CLIENT_U_NR
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
  BRW1::AUT:V_Nr = AUT:V_Nr
  BRW1::AUT:Virsb_Nr = AUT:Virsb_Nr
  BRW1::AUT:MARKA = AUT:MARKA
  BRW1::AUT:Par_nos = AUT:Par_nos
  BRW1::AUT:Vaditajs = AUT:Vaditajs
  BRW1::AUT:Telefons = AUT:Telefons
  BRW1::AUT:U_NR = AUT:U_NR
  BRW1::PAR_NR = PAR_NR
  BRW1::MODE = MODE
  BRW1::VIENS = VIENS
  BRW1::DIVI = DIVI
  BRW1::AUT:Par_Nr = AUT:Par_Nr
  BRW1::GL:CLIENT_U_NR = GL:CLIENT_U_NR
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
      OF 2
      OF 3
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort3:KeyDistribution[BRW1::CurrentScroll] => AUT:U_NR
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 4
      OF 5
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort5:KeyDistribution[BRW1::CurrentScroll] => AUT:Par_Nr
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
      AUT:V_Nr = BRW1::Sort1:LocatorValue
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      AUT:MARKA = BRW1::Sort2:LocatorValue
    OF 4
      BRW1::Sort4:LocatorValue = ''
      BRW1::Sort4:LocatorLength = 0
      AUT:Virsb_Nr = BRW1::Sort4:LocatorValue
    END
  CASE BRW1::SortOrder
  OF 1
  OROF 2
  OROF 4
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
            AUT:V_Nr = BRW1::Sort1:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          AUT:V_Nr = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          AUT:V_Nr = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            AUT:MARKA = BRW1::Sort2:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          AUT:MARKA = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          AUT:MARKA = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 3
      OF 4
        IF KEYCODE() = BSKey
          IF BRW1::Sort4:LocatorLength
            BRW1::Sort4:LocatorLength -= 1
            BRW1::Sort4:LocatorValue = SUB(BRW1::Sort4:LocatorValue,1,BRW1::Sort4:LocatorLength)
            AUT:Virsb_Nr = BRW1::Sort4:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort4:LocatorValue = SUB(BRW1::Sort4:LocatorValue,1,BRW1::Sort4:LocatorLength) & ' '
          BRW1::Sort4:LocatorLength += 1
          AUT:Virsb_Nr = BRW1::Sort4:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort4:LocatorValue = SUB(BRW1::Sort4:LocatorValue,1,BRW1::Sort4:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort4:LocatorLength += 1
          AUT:Virsb_Nr = BRW1::Sort4:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 5
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
    OF 3
      AUT:U_NR = BRW1::Sort3:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 5
      AUT:Par_Nr = BRW1::Sort5:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'AUTO')
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
      BRW1::HighlightedPosition = POSITION(AUT:V_Nr_key)
      RESET(AUT:V_Nr_key,BRW1::HighlightedPosition)
    ELSE
      SET(AUT:V_Nr_key,AUT:V_Nr_key)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '((MODE=VIENS AND AUT:Par_Nr=GL:CLIENT_U_NR) OR MODE=DIVI)'
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(AUT:MARK_KEY)
      RESET(AUT:MARK_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(AUT:MARK_KEY,AUT:MARK_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '((MODE=VIENS AND AUT:Par_Nr=GL:CLIENT_U_NR) OR MODE=DIVI)'
  OF 3
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(AUT:NR_KEY)
      RESET(AUT:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(AUT:NR_KEY,AUT:NR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '((MODE=VIENS AND AUT:Par_Nr=GL:CLIENT_U_NR) OR MODE=DIVI)'
  OF 4
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(AUT:Virsb_key)
      RESET(AUT:Virsb_key,BRW1::HighlightedPosition)
    ELSE
      SET(AUT:Virsb_key,AUT:Virsb_key)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '((MODE=VIENS AND AUT:Par_Nr=GL:CLIENT_U_NR) OR MODE=DIVI)'
  OF 5
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(AUT:Par_key)
      RESET(AUT:Par_key,BRW1::HighlightedPosition)
    ELSE
      SET(AUT:Par_key,AUT:Par_key)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '((MODE=VIENS AND AUT:Par_Nr=GL:CLIENT_U_NR) OR MODE=DIVI)'
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
    OF 1; ?AUT:V_Nr{Prop:Disable} = 0
    OF 2; ?AUT:MARKA{Prop:Disable} = 0
    OF 4; ?AUT:Virsb_Nr{Prop:Disable} = 0
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
    CLEAR(AUT:Record)
    CASE BRW1::SortOrder
    OF 1; ?AUT:V_Nr{Prop:Disable} = 1
    OF 2; ?AUT:MARKA{Prop:Disable} = 1
    OF 4; ?AUT:Virsb_Nr{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    IF RECORDS(AUT:PAR_KEY)
       KLUDA(0,'mums nav piesaistîta neviena a/m')
       MODE=2 !VISAS A/M
       !LocalRequest = OriginalRequest
       BRW1::LocateMode = LocateOnEdit
       DO BRW1::LocateRecord
       DO BRW1::InitializeBrowse
       DO BRW1::PostNewSelection
       DO BRW1::RefreshPage
    .
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
    SET(AUT:V_Nr_key)
    BRW1::View:Browse{Prop:Filter} = |
    '((MODE=VIENS AND AUT:Par_Nr=GL:CLIENT_U_NR) OR MODE=DIVI)'
  OF 2
    SET(AUT:MARK_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '((MODE=VIENS AND AUT:Par_Nr=GL:CLIENT_U_NR) OR MODE=DIVI)'
  OF 3
    SET(AUT:NR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '((MODE=VIENS AND AUT:Par_Nr=GL:CLIENT_U_NR) OR MODE=DIVI)'
  OF 4
    SET(AUT:Virsb_key)
    BRW1::View:Browse{Prop:Filter} = |
    '((MODE=VIENS AND AUT:Par_Nr=GL:CLIENT_U_NR) OR MODE=DIVI)'
  OF 5
    SET(AUT:Par_key)
    BRW1::View:Browse{Prop:Filter} = |
    '((MODE=VIENS AND AUT:Par_Nr=GL:CLIENT_U_NR) OR MODE=DIVI)'
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
  GET(AUTO,0)
  CLEAR(AUT:Record,0)
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
!| (UpdateAuto) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[8])
     EXIT
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateAuto
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
        GET(AUTO,0)
        CLEAR(AUT:Record,0)
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


