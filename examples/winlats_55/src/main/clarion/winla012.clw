                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateGrupa1 PROCEDURE


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
SAV_PROC          LIKE(GR1:PROC)
NOM_PROC5         LIKE(NOM:PROC5)
forceduzcenhange  BYTE

PROGRESSWINDOW WINDOW('...rakstu apakðgrupas un NOM_K'),AT(,,151,37),GRAY
       STRING(@N_5),AT(55,16),USE(NPK#)
     END


BRW2::View:Browse    VIEW(GRUPA2)
                       PROJECT(GR2:GRUPA1)
                       PROJECT(GR2:GRUPA2)
                       PROJECT(GR2:PROC)
                       PROJECT(GR2:NOSAUKUMS)
                     END

Queue:Browse:2       QUEUE,PRE()                  ! Browsing Queue
BRW2::GR2:GRUPA1       LIKE(GR2:GRUPA1)           ! Queue Display field
BRW2::GR2:GRUPA2       LIKE(GR2:GRUPA2)           ! Queue Display field
BRW2::GR2:PROC         LIKE(GR2:PROC)             ! Queue Display field
BRW2::GR2:NOSAUKUMS    LIKE(GR2:NOSAUKUMS)        ! Queue Display field
BRW2::Mark             BYTE                       ! Queue POSITION information
BRW2::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW2::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW2::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW2::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW2::Sort1:KeyDistribution LIKE(GR2:GRUPA2),DIM(100)
BRW2::Sort1:LowValue LIKE(GR2:GRUPA2)             ! Queue position of scroll thumb
BRW2::Sort1:HighValue LIKE(GR2:GRUPA2)            ! Queue position of scroll thumb
BRW2::Sort1:Reset:GR1:GRUPA1 LIKE(GR1:GRUPA1)
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
History::GR1:Record LIKE(GR1:Record),STATIC
SAV::GR1:Record      LIKE(GR1:Record)
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Nomenklatûras grupa un apakðgrupa'),AT(,,290,215),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateGrupas1'),SYSTEM,GRAY,RESIZE
                       PROMPT('&Grupa:'),AT(7,6,43,10),USE(?GR1:GRUPA1:Prompt)
                       ENTRY(@S3),AT(50,6,25,10),USE(GR1:GRUPA1),REQ,UPR
                       STRING('(Izmantojiet visas 3 zîmes !!!)'),AT(82,6),USE(?String1)
                       PROMPT('&Nosaukums:'),AT(7,17,43,10),USE(?GR1:NOSAUKUMS:Prompt)
                       ENTRY(@S50),AT(50,17,227,10),USE(GR1:NOSAUKUMS)
                       PROMPT('&Uzc. 5.c.:'),AT(7,29,40,10),USE(?GR1:PROC:Prompt)
                       ENTRY(@n-4.0),AT(50,29,23,10),USE(GR1:PROC)
                       STRING('%'),AT(75,29),USE(?String2)
                       SHEET,AT(8,42,277,147),USE(?CurrentTab)
                         TAB('Apakðgrupas'),USE(?Tab:2)
                           LIST,AT(13,58,267,110),USE(?Browse:2),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('23R(1)|M~Grupa~C(0)@S3@10C|M~A~@s1@16C|M~%5C~@n-4.0@80L(2)|M~Nosaukums~@S50@'),FROM(Queue:Browse:2)
                           BUTTON('&Ievadît'),AT(64,170,45,14),USE(?Insert:3)
                           BUTTON('&Mainît'),AT(111,170,45,14),USE(?Change:3)
                           BUTTON('&Dzçst'),AT(159,170,45,14),USE(?Delete:3)
                           BUTTON('Iz&vçlçties'),AT(209,170,45,14),USE(?Select:2),FONT(,,0A00000H,,CHARSET:ANSI)
                         END
                       END
                       BUTTON('&OK'),AT(190,192,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(238,192,45,14),USE(?Cancel)
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
     DISABLE(?GR1:GRUPA1)
     DISABLE(?GR1:NOSAUKUMS)
     HIDE(?OK)
  .
  SAV_PROC=GR1:PROC
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
      DO BRW2::AssignButtons
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?GR1:GRUPA1:Prompt)
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
      IF ToolBarMode=BrowseMode THEN
        DO SelectDispatch
      END
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
        History::GR1:Record = GR1:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(GRUPA1)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(GR1:GR1_KEY)
              IF StandardWarning(Warn:DuplicateKey,'GR1:GR1_KEY')
                SELECT(?GR1:GRUPA1:Prompt)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?GR1:GRUPA1:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::GR1:Record <> GR1:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:GRUPA1(1)
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
              SELECT(?GR1:GRUPA1:Prompt)
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
    CASE LOCALREQUEST
    OF 1
       IF RECORDS(Queue:Browse:2)
          DISABLE(?GR1:GRUPA1)
          DISABLE(?CANCEL)
          ALIAS(EscKey,0) ! Novâcam EscKey
       ELSIF RECORDS(Queue:Browse:2)=0
          ENABLE(?GR1:GRUPA1)
          ENABLE(?CANCEL)
          ALIAS
       .
    .
    CASE FIELD()
    OF ?GR1:GRUPA1
      CASE EVENT()
      OF EVENT:Accepted
        IF LOCALREQUEST=1
           GR1:GRUPA1=INIGEN(GR1:GRUPA1,3,1)
           GR1:GRUPA1=UPPER(GR1:GRUPA1)
           DISPLAY
           LOOP L#=1 TO 3
              IF INSTRING(GR1:GRUPA1[L#],' ,;:*"/()',1)  !' .,;:*"/()',1)
                 IF GR1:GRUPA1[L#]=' '
                    KLUDA(0,'Grupâ neatïauts TUKÐUMS')
                 ELSE
                    KLUDA(0,'Grupai neatïauts simbols '&GR1:GRUPA1[L#])
                 .
                 SELECT(?GR1:GRUPA1)
              .
           .
           DO RefreshWindow
        .
      END
    OF ?GR1:PROC
      CASE EVENT()
      OF EVENT:Accepted
        IF ~(SAV_PROC=GR1:PROC)
           KLUDA(51,'Uzsenojuma % 5 cenai no '&clip(SAV_PROC)&' uz '&CLIP(GR1:PROC))
           IF KLU_DARBIBA
              NPK#=0
              OPEN(PROGRESSWINDOW)
              forceduzcenhange=TRUE
              DO BRW2::InitializeBrowse
              CLOSE(PROGRESSWINDOW)
              DO BRW2::RefreshPage
              forceduzcenhange=FALSE
           .
           SAV_PROC=GR1:PROC
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
        IF ~GR1:GRUPA1
           KLUDA(0,'Nav norâdîta Grupa')
           SELECT(?GR1:GRUPA1)
           CYCLE
        .
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
    OF ?Select:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
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
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  FilesOpened = True
  RISnap:GRUPA1
  SAV::GR1:Record = GR1:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:GRUPA1()
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
  BRW2::AddQueue = True
  BRW2::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select:2{Prop:Hide} = True
    DISABLE(?Select:2)
  ELSE
  END
  BIND('BRW2::Sort1:Reset:GR1:GRUPA1',BRW2::Sort1:Reset:GR1:GRUPA1)
  IF WindowPosInit THEN
    SETPOSITION(0,WindowXPos,WindowYPos)
  ELSE
    GETPOSITION(0,WindowXPos,WindowYPos)
    WindowPosInit=True
  END
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?Browse:2{Prop:Alrt,255} = InsertKey
  ?Browse:2{Prop:Alrt,254} = DeleteKey
  ?Browse:2{Prop:Alrt,253} = CtrlEnter
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?GR1:GRUPA1{PROP:Alrt,255} = 734
  ?GR1:NOSAUKUMS{PROP:Alrt,255} = 734
  ?GR1:PROC{PROP:Alrt,255} = 734
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
    GRUPA1::Used -= 1
    IF GRUPA1::Used = 0 THEN CLOSE(GRUPA1).
    GRUPA2::Used -= 1
    IF GRUPA2::Used = 0 THEN CLOSE(GRUPA2).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
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

SelectDispatch ROUTINE
  IF ACCEPTED()=TBarBrwSelect THEN         !trap remote browse select control calls
    POST(EVENT:ACCEPTED,BrowseButtons.SelectButton)
  END

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
      IF BRW2::Sort1:Reset:GR1:GRUPA1 <> GR1:GRUPA1
        BRW2::Changed = True
      END
    END
  ELSE
  END
  IF BRW2::SortOrder <> BRW2::LastSortOrder OR BRW2::Changed OR ForceRefresh
    CASE BRW2::SortOrder
    OF 1
      BRW2::Sort1:Reset:GR1:GRUPA1 = GR1:GRUPA1
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
  LOOP
    NEXT(BRW2::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW2::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'GRUPA2')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW2::FillQueue
    IF GR1:GRUPA1=GR2:GRUPA1 !TOTÂLÂ KONTROLE SPECGADÎJUMÂ, JA NOBRUCIS BROWSIS
       !***********uzcenojuma pârrçíins**********
       IF forceduzcenhange=TRUE
          IF GR2:PROC=SAV_PROC
             GR2:PROC=GR1:PROC
             IF RIUPDATE:GRUPA2()
                KLUDA(24,'GRUPA2')
             ELSE
                DISABLE(?CANCEL)
             .
             CLEAR(NOM:RECORD)
             NOM:NOMENKLAT[1:3]=GR2:GRUPA1
             NOM:NOMENKLAT[4]=GR2:GRUPA2
             SET(NOM:NOM_KEY,NOM:NOM_KEY)
             LOOP
                NEXT(NOM_K)
                NPK#+=1
                DISPLAY
                IF ERROR() OR ~(NOM:NOMENKLAT[1:4]=GR2:GRUPA1&GR2:GRUPA2) THEN BREAK.
                NOM_PROC5=NOM:PROC5
                NOM:PROC5=GR2:PROC
                NOM:REALIZ[5]=NOM:REALIZ[5]/(1+NOM_PROC5/100)*(1+NOM:PROC5/100)
                IF RIUPDATE:NOM_K()
                   KLUDA(24,'NOM_K')
                .
             .
          .
       .
    .
    ! STOP('BTLOOP')
  END
  SETCURSOR()
  DO BRW2::Reset
  PREVIOUS(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GRUPA2')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 1
    BRW2::Sort1:HighValue = GR2:GRUPA2
  END
  DO BRW2::Reset
  NEXT(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GRUPA2')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 1
    BRW2::Sort1:LowValue = GR2:GRUPA2
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
  GR2:GRUPA1 = BRW2::GR2:GRUPA1
  GR2:GRUPA2 = BRW2::GR2:GRUPA2
  GR2:PROC = BRW2::GR2:PROC
  GR2:NOSAUKUMS = BRW2::GR2:NOSAUKUMS
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
  BRW2::GR2:GRUPA1 = GR2:GRUPA1
  BRW2::GR2:GRUPA2 = GR2:GRUPA2
  BRW2::GR2:PROC = GR2:PROC
  BRW2::GR2:NOSAUKUMS = GR2:NOSAUKUMS
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
      IF LocalRequest = SelectRecord
        BRW2::PopupText = 'Iz&vçlçties'
      ELSE
        BRW2::PopupText = '~Iz&vçlçties'
      END
      IF BRW2::PopupText
        BRW2::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW2::PopupText
      ELSE
        BRW2::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
      BRW2::PopupText = '~Iz&vçlçties'
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
      POST(Event:Accepted,?Select:2)
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
          IF BRW2::Sort1:KeyDistribution[BRW2::CurrentScroll] => UPPER(GR2:GRUPA2)
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
      IF LocalRequest = SelectRecord
        POST(Event:Accepted,?Select:2)
        EXIT
      END
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
      GR2:GRUPA2 = BRW2::Sort1:KeyDistribution[?Browse:2{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'GRUPA2')
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
      BRW2::HighlightedPosition = POSITION(GR2:GR1_KEY)
      RESET(GR2:GR1_KEY,BRW2::HighlightedPosition)
    ELSE
      GR2:GRUPA1 = GR1:GRUPA1
      SET(GR2:GR1_KEY,GR2:GR1_KEY)
    END
    BRW2::View:Browse{Prop:Filter} = |
    'UPPER(GR2:GRUPA1) = UPPER(BRW2::Sort1:Reset:GR1:GRUPA1)'
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
    CLEAR(GR2:Record)
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
    GR2:GRUPA1 = GR1:GRUPA1
    SET(GR2:GR1_KEY)
    BRW2::View:Browse{Prop:Filter} = |
    'UPPER(GR2:GRUPA1) = UPPER(BRW2::Sort1:Reset:GR1:GRUPA1)'
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
    GR1:GRUPA1 = BRW2::Sort1:Reset:GR1:GRUPA1
  END
BRW2::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:2
  BrowseButtons.SelectButton=?Select:2
  BrowseButtons.InsertButton=?Insert:3
  BrowseButtons.ChangeButton=?Change:3
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
  GET(GRUPA2,0)
  CLEAR(GR2:Record,0)
  CASE BRW2::SortOrder
  OF 1
    GR2:GRUPA1 = BRW2::Sort1:Reset:GR1:GRUPA1
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
!| (UpdateGRUPA2) is called.
!|
!| Upon return from the update, the routine BRW2::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW2::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateGRUPA2
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
        GET(GRUPA2,0)
        CLEAR(GR2:Record,0)
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
    OF ?GR1:GRUPA1
      GR1:GRUPA1 = History::GR1:Record.GRUPA1
    OF ?GR1:NOSAUKUMS
      GR1:NOSAUKUMS = History::GR1:Record.NOSAUKUMS
    OF ?GR1:PROC
      GR1:PROC = History::GR1:Record.PROC
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
  GR1:Record = SAV::GR1:Record
  SAV::GR1:Record = GR1:Record
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

UpdateATL_S PROCEDURE


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
W_ATLAIDE            STRING(5)
Update::Reloop  BYTE
Update::Error   BYTE
History::ATS:Record LIKE(ATS:Record),STATIC
SAV::ATS:Record      LIKE(ATS:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the ATL_S File'),AT(,,258,142),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateATL_S'),SYSTEM,GRAY,RESIZE,MASK
                       SHEET,AT(4,6,253,113),USE(?CurrentTab)
                         TAB('Definçjam atlaidi Nomenklatûrai (Nom grupai)'),USE(?Tab:1)
                           STRING(@n6),AT(7,18),USE(ATS:U_NR),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           BUTTON('&Grupa'),AT(16,27,45,14),USE(?ButtonGrupa)
                           BUTTON('Apa&kðgrupa'),AT(71,27,45,14),USE(?ButtonApaksgrupa)
                           BUTTON('&Raþotâjs'),AT(126,27,45,14),USE(?ButtonRazotajs)
                           ENTRY(@S21),AT(82,44,100,14),USE(ATS:NOMENKLAT),IMM,FONT('Fixedsys',9,,FONT:regular,CHARSET:BALTIC),OVR,UPR
                           STRING('123456789012345678901'),AT(84,59),USE(?String2),FONT('Fixedsys',9,COLOR:Gray,FONT:regular)
                           STRING('pozîcija 1:* tiek definçta Preèu grupa (DG)'),AT(43,69),USE(?String2:2),FONT('Fixedsys',9,COLOR:Gray,FONT:regular)
                           STRING('pozîcija 2:cipars1-9 (DG cipars Nom_K)'),AT(48,78),USE(?String2:3),FONT('Fixedsys',9,COLOR:Gray,FONT:regular)
                           PROMPT('&Nomenklatûra:'),AT(19,48),USE(?ATS:NOMENKLAT:Prompt)
                           PROMPT('Atlaides &procents:'),AT(19,95,61,10),USE(?ATS:ATL_PROC:Prompt)
                           ENTRY(@n-5.1),AT(82,95,23,10),USE(ATS:ATL_PROC),DECIMAL(12),INS
                           STRING('%'),AT(107,95,11,10),USE(?String1),CENTER
                           STRING(@s5),AT(119,95),USE(W_ATLAIDE),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                         END
                       END
                       STRING(@s8),AT(5,122,33,10),USE(ATS:ACC_KODS),LEFT,FONT(,,COLOR:Gray,)
                       BUTTON('&OK'),AT(162,121,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(210,121,45,14),USE(?Cancel)
                       STRING(@D06.),AT(40,122),USE(ATS:ACC_DATUMS),FONT(,,COLOR:Gray,)
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
  ?ATS:NOMENKLAT{PROP:INS}=''
  ?ATS:NOMENKLAT{PROP:OVR}='1'
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
      SELECT(?ATS:U_NR)
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
        History::ATS:Record = ATS:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(ATL_S)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?ATS:U_NR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::ATS:Record <> ATS:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:ATL_S(1)
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
              SELECT(?ATS:U_NR)
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
    OF ?ButtonGrupa
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         GlobalRequest = SelectRecord             ! Set Action for Lookup
         BrowseGrupas                             ! Call the Lookup Procedure
         LocalResponse = GlobalResponse           ! Save Action for evaluation
         GlobalResponse = RequestCancelled        ! Clear Action
         IF LocalResponse = RequestCompleted      ! IF Lookup completed
           ATS:NOMENKLAT[1:3]=GR1:GRUPA1;DISPLAY  ! Source on Completion
         END                                      ! END (IF Lookup completed)
         LocalResponse = RequestCancelled
      END
    OF ?ButtonApaksgrupa
      CASE EVENT()
      OF EVENT:Accepted
        IF ~getgrupa(ATS:NOMENKLAT[1:3],1,1)
           CYCLE
        .
        DO SyncWindow
        GlobalRequest = SelectRecord
        UpdateGrupa1 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           ATS:NOMENKLAT[4]=GR2:GRUPA2
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
           ATS:NOMENKLAT[19:21]=PAR:NOS_U;DISPLAY ! Source on Completion
         END                                      ! END (IF Lookup completed)
         LocalResponse = RequestCancelled
      END
    OF ?ATS:NOMENKLAT
      CASE EVENT()
      OF EVENT:Accepted
           IF (CL_NR=1102 OR|         !ADREM
           CL_NR=1464 OR|          !AUTO ÎLE
           ACC_KODS_N=0) AND INRANGE(ATS:U_NR,109,118) !SPEC.ATLAIDE UZ NOM:PUNKTI
        !      VW_DG#=GETNOM_K(MASKA,0,26)
              VW_DG#=ATS:NOMENKLAT[2]
              IF ATS:NOMENKLAT[1]='*' AND INRANGE(VW_DG#,1,8)
                 EXECUTE VW_DG#
                    W_ATLAIDE=53.5
                    W_ATLAIDE=46
                    W_ATLAIDE=39.5
                    W_ATLAIDE=35
                    W_ATLAIDE=29
                    W_ATLAIDE=27
                    W_ATLAIDE=29
                    W_ATLAIDE=36
                 .
                 DISPLAY(?W_ATLAIDE)
              .
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
        ATS:ACC_KODS = ACC_KODS
        ATS:ACC_DATUMS = TODAY()
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
  IF ATL_S::Used = 0
    CheckOpen(ATL_S,1)
  END
  ATL_S::Used += 1
  BIND(ATS:RECORD)
  FilesOpened = True
  RISnap:ATL_S
  SAV::ATS:Record = ATS:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    ATS:ACC_KODS = ACC_KODS
    ATS:ACC_DATUMS = TODAY()
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:ATL_S()
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
  ?ATS:U_NR{PROP:Alrt,255} = 734
  ?ATS:NOMENKLAT{PROP:Alrt,255} = 734
  ?ATS:ATL_PROC{PROP:Alrt,255} = 734
  ?ATS:ACC_KODS{PROP:Alrt,255} = 734
  ?ATS:ACC_DATUMS{PROP:Alrt,255} = 734
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
    ATL_S::Used -= 1
    IF ATL_S::Used = 0 THEN CLOSE(ATL_S).
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
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?ATS:U_NR
      ATS:U_NR = History::ATS:Record.U_NR
    OF ?ATS:NOMENKLAT
      ATS:NOMENKLAT = History::ATS:Record.NOMENKLAT
    OF ?ATS:ATL_PROC
      ATS:ATL_PROC = History::ATS:Record.ATL_PROC
    OF ?ATS:ACC_KODS
      ATS:ACC_KODS = History::ATS:Record.ACC_KODS
    OF ?ATS:ACC_DATUMS
      ATS:ACC_DATUMS = History::ATS:Record.ACC_DATUMS
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
  ATS:Record = SAV::ATS:Record
  SAV::ATS:Record = ATS:Record
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

BrowseGrupas PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG

BRW1::View:Browse    VIEW(GRUPA1)
                       PROJECT(GR1:GRUPA1)
                       PROJECT(GR1:NOSAUKUMS)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::GR1:GRUPA1       LIKE(GR1:GRUPA1)           ! Queue Display field
BRW1::GR1:NOSAUKUMS    LIKE(GR1:NOSAUKUMS)        ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(GR1:GRUPA1),DIM(100)
BRW1::Sort1:LowValue LIKE(GR1:GRUPA1)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(GR1:GRUPA1)            ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Nomenklatûru grupas (grupa1.tps)'),AT(,,302,229),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseGrupas'),SYSTEM,GRAY,RESIZE
                       LIST,AT(7,21,287,183),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('32L(2)|M~Grupa~@S3@80L(2)|M~Nosaukums~@S50@'),FROM(Queue:Browse:1)
                       SHEET,AT(4,5,296,222),USE(?CurrentTab)
                         TAB('Grupas'),USE(?Tab:2)
                           BUTTON('&Ievadît'),AT(17,208,45,14),USE(?Insert:3)
                           BUTTON('&Mainît'),AT(66,208,45,14),USE(?Change),DEFAULT
                           BUTTON('&Dzçst'),AT(114,208,45,14),USE(?Delete:3)
                           BUTTON('Iz&vçlçties'),AT(198,208,45,14),USE(?Select),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                           BUTTON('&Beigt'),AT(246,208,45,14),USE(?Close)
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
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  IF LOCALREQUEST=SELECTRECORD
     ?Change {PROP:DEFAULT}=''
     ?Select{PROP:DEFAULT}='1'
     QUICKWINDOW{PROP:TEXT}='Izvçlaties grupu'
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
    OF ?Select
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
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
  IF GRUPA1::Used = 0
    CheckOpen(GRUPA1,1)
  END
  GRUPA1::Used += 1
  BIND(GR1:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select{Prop:Hide} = True
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
    GRUPA1::Used -= 1
    IF GRUPA1::Used = 0 THEN CLOSE(GRUPA1).
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
      StandardWarning(Warn:RecordFetchError,'GRUPA1')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = GR1:GRUPA1
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GRUPA1')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = GR1:GRUPA1
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
  GR1:GRUPA1 = BRW1::GR1:GRUPA1
  GR1:NOSAUKUMS = BRW1::GR1:NOSAUKUMS
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
  BRW1::GR1:GRUPA1 = GR1:GRUPA1
  BRW1::GR1:NOSAUKUMS = GR1:NOSAUKUMS
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => UPPER(GR1:GRUPA1)
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
        IF CHR(KEYCHAR())
          IF UPPER(SUB(GR1:GRUPA1,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(GR1:GRUPA1,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            GR1:GRUPA1 = CHR(KEYCHAR())
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
      GR1:GRUPA1 = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'GRUPA1')
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
      BRW1::HighlightedPosition = POSITION(GR1:GR1_KEY)
      RESET(GR1:GR1_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(GR1:GR1_KEY,GR1:GR1_KEY)
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
    ?Change{Prop:Disable} = 0
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(GR1:Record)
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
    SET(GR1:GR1_KEY)
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
  GET(GRUPA1,0)
  CLEAR(GR1:Record,0)
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
!| (UpdateGrupa1) is called.
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
    UpdateGrupa1
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
        GET(GRUPA1,0)
        CLEAR(GR1:Record,0)
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


