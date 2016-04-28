                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateCENUVEST PROCEDURE


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
Cena_Ls              DECIMAL(7,2)
Update::Reloop  BYTE
Update::Error   BYTE
History::CEN:Record LIKE(CEN:Record),STATIC
SAV::CEN:Record      LIKE(CEN:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
FLD5::View           VIEW(VAL_K)
                       PROJECT(VAL:VAL)
                     END
Queue:FileDrop       QUEUE,PRE
FLD5::VAL:VAL          LIKE(VAL:VAL)
                     END
FLD5::LoopIndex      LONG,AUTO
QuickWindow          WINDOW('Update the CENUVEST File'),AT(,,193,179),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateCENUVEST'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,4,185,151),USE(?CurrentTab)
                         TAB('General'),USE(?Tab:1)
                           PROMPT('Piegâdâtâja kods:'),AT(8,30),USE(?CEN:KATALOGA_NR:Prompt)
                           ENTRY(@s17),AT(69,30,72,12),USE(CEN:KATALOGA_NR),REQ
                           PROMPT('Raþotâjs:'),AT(8,44),USE(?CEN:NOS_U:Prompt )
                           ENTRY(@s3),AT(69,44,25,12),USE(CEN:NOS_U),REQ
                           PROMPT('Skaits:'),AT(8,58),USE(?CEN:SKAITS:Prompt)
                           ENTRY(@n6),AT(69,58,40,12),USE(CEN:SKAITS),RIGHT(1)
                           PROMPT('Cena:'),AT(8,72),USE(?CEN:CENA:Prompt)
                           ENTRY(@n-13.2),AT(69,72,60,12),USE(CEN:CENA),RIGHT(1)
                           LIST,AT(132,72,39,12),USE(CEN:VALUTA,,?cen:valuta:2),FORMAT('12L~Val~@s3@'),DROP(7),FROM(Queue:FileDrop)
                           STRING('Cena Ls:'),AT(8,86),USE(?String2)
                           STRING(@n-10.2),AT(71,86),USE(Cena_Ls)
                           PROMPT('V-Cena:'),AT(9,102),USE(?CEN:CENA1:Prompt)
                           ENTRY(@n-10.2),AT(69,100),USE(CEN:CENA1)
                           PROMPT('M-Cena:'),AT(8,115),USE(?CEN:CENA2:Prompt)
                           ENTRY(@n-10.2),AT(69,115),USE(CEN:CENA2)
                           PROMPT('Datums:'),AT(8,130),USE(?CEN:DATUMS:Prompt)
                           ENTRY(@D6),AT(69,130,45,12),USE(CEN:DATUMS),RIGHT(1)
                         END
                       END
                       BUTTON('&OK'),AT(95,162,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(146,162,45,14),USE(?Cancel)
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
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
  END
  QuickWindow{Prop:Text} = ActionMessage
  ENABLE(TBarBrwHistory)
  ACCEPT
    Cena_Ls=cen:cena*bankurs(cen:VALUTA,cen:datums,,1)  !TESTA KURSS
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
      DO FLD5::FillList
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?CEN:KATALOGA_NR:Prompt)
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
        History::CEN:Record = CEN:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(CENUVEST)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?CEN:KATALOGA_NR:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::CEN:Record <> CEN:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:CENUVEST(1)
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
              SELECT(?CEN:KATALOGA_NR:Prompt)
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
  IF CENUVEST::Used = 0
    CheckOpen(CENUVEST,1)
  END
  CENUVEST::Used += 1
  BIND(CEN:RECORD)
  IF VAL_K::Used = 0
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  BIND(VAL:RECORD)
  FilesOpened = True
  RISnap:CENUVEST
  SAV::CEN:Record = CEN:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    CEN:SKAITS=1
    CEN:VALUTA='EUR'
    CEN:DATUMS=TODAY()
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:CENUVEST()
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
  INIRestoreWindow('UpdateCENUVEST','winlats.INI')
  WinResize.Resize
  ?CEN:KATALOGA_NR{PROP:Alrt,255} = 734
  ?CEN:NOS_U{PROP:Alrt,255} = 734
  ?CEN:SKAITS{PROP:Alrt,255} = 734
  ?CEN:CENA{PROP:Alrt,255} = 734
  ?cen:valuta:2{PROP:Alrt,255} = 734
  ?CEN:CENA1{PROP:Alrt,255} = 734
  ?CEN:CENA2{PROP:Alrt,255} = 734
  ?CEN:DATUMS{PROP:Alrt,255} = 734
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
    CENUVEST::Used -= 1
    IF CENUVEST::Used = 0 THEN CLOSE(CENUVEST).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
  END
  IF WindowOpened
    INISaveWindow('UpdateCENUVEST','winlats.INI')
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
    OF ?CEN:KATALOGA_NR
      CEN:KATALOGA_NR = History::CEN:Record.KATALOGA_NR
    OF ?CEN:NOS_U
      CEN:NOS_U = History::CEN:Record.NOS_U
    OF ?CEN:SKAITS
      CEN:SKAITS = History::CEN:Record.SKAITS
    OF ?CEN:CENA
      CEN:CENA = History::CEN:Record.CENA
    OF ?cen:valuta:2
      CEN:VALUTA = History::CEN:Record.VALUTA
    OF ?CEN:CENA1
      CEN:CENA1 = History::CEN:Record.CENA1
    OF ?CEN:CENA2
      CEN:CENA2 = History::CEN:Record.CENA2
    OF ?CEN:DATUMS
      CEN:DATUMS = History::CEN:Record.DATUMS
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
  CEN:Record = SAV::CEN:Record
  SAV::CEN:Record = CEN:Record
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


!----------------------------------------------------
FLD5::FillList ROUTINE
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
    FLD5::VAL:VAL = VAL:VAL
    ADD(Queue:FileDrop)
  END
  CLOSE(FLD5::View)
  IF RECORDS(Queue:FileDrop)
    IF CEN:VALUTA
      LOOP FLD5::LoopIndex = 1 TO RECORDS(Queue:FileDrop)
        GET(Queue:FileDrop,FLD5::LoopIndex)
        IF CEN:VALUTA = FLD5::VAL:VAL THEN BREAK.
      END
      ?cen:valuta:2{Prop:Selected} = FLD5::LoopIndex
    END
  ELSE
    CLEAR(CEN:VALUTA)
  END
BrowseCENUVEST PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
NOS_U                STRING(3)
actionstring         STRING(30)
CEN_CENA             DECIMAL(9,2)
DAUDZUMS    DECIMAL(5)
CENA        DECIMAL(9,2)
CENA1       DECIMAL(9,2)
CENA2       DECIMAL(9,2)
LIGUMCENA   DECIMAL(9,2)
NOSAUKUMS   STRING(50)
NOS_S       STRING(16)
SAN_NR      ULONG
SAN_NOS     STRING(15)
PAS_U_NR    ULONG
PAS_SUMMA   DECIMAL(9,2)
PAS_SUMMAV  DECIMAL(9,2)

!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------
Auto::Attempts       LONG,AUTO
Auto::Save:PAS:U_NR   LIKE(PAS:U_NR)

PasWindow WINDOW('Âtrâ pasûtîjuma veidoðana'),AT(,,318,212),CENTER,GRAY,MDI
       STRING(@s50),AT(73,17),USE(NOSAUKUMS)
       STRING('Nomenklatûra :'),AT(56,27,58,10),USE(?String1),RIGHT(1)
       STRING(@s21),AT(120,27),USE(nomenklat)
       STRING('Kataloga_nr :'),AT(58,36,56,10),USE(?String3),RIGHT(1)
       STRING(@s17),AT(120,36),USE(CEN:kataloga_nr,,?CEN:kataloga_nr:1)
       ENTRY(@s16),AT(120,48),USE(NOS_S)
       STRING('Saîsinâtais nosaukums :'),AT(31,49,82,10),USE(?String233),RIGHT(1)
       STRING('Raþotâja kods :'),AT(56,65,58,10),USE(?String5),RIGHT(1)
       STRING(@s3),AT(120,65),USE(CEN:nos_u)
       STRING('Skaits :'),AT(89,81),USE(?String16)
       ENTRY(@n_5),AT(122,79),USE(Daudzums),RIGHT(1),REQ
       STRING('Pçdçjâ iepirkuma cena :'),AT(35,93),USE(?String7)
       STRING(@n_10.2),AT(121,93),USE(cen:cena)
       STRING(@s3),AT(164,92),USE(cen:valuta)
       STRING(@n_10.2),AT(121,106),USE(cena1)
       STRING('Ls'),AT(165,105),USE(?String11)
       BUTTON('Vairumcena'),AT(58,103,55,14),USE(?ButtonV)
       STRING(@n_10.2),AT(121,119),USE(cena2)
       STRING('Ls'),AT(165,118),USE(?String21)
       BUTTON('Mazumcena'),AT(58,117,55,14),USE(?ButtonM)
       STRING('Lîgumcena :'),AT(73,141),USE(?String17)
       ENTRY(@n_10.2),AT(121,140),USE(ligumcena),RIGHT(1),REQ
       BUTTON('Pasûtîtâjs'),AT(70,161,42,14),USE(?PARTNERIS)
       ENTRY(@s15),AT(117,162),USE(SAN_NOS)
       STRING(@N_6),AT(188,163),USE(SAN_NR)
       BUTTON('&OK- Pievienot Pasûtîjumiem'),AT(172,192,102,14),USE(?OkAP),DEFAULT
       BUTTON('&Atlikt'),AT(276,192,36,14),USE(?CancelAP)
     END

RAZwindow WINDOW('Caption'),AT(,,191,64),GRAY
       STRING(@s30),AT(33,12),USE(actionstring)
       STRING('Nodzçst visas cenas, kur raþotâjs ir :'),AT(12,25),USE(?StringRAZ)
       ENTRY(@s3),AT(139,23),USE(nos_u),LEFT(1)
       BUTTON('&OK'),AT(105,45,35,14),USE(?Ok),DEFAULT
       BUTTON('Atlikt'),AT(142,45,36,14),USE(?Cancel)
     END

RejectRecord         LONG
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


BRW1::View:Browse    VIEW(CENUVEST)
                       PROJECT(CEN:KATALOGA_NR)
                       PROJECT(CEN:NOS_U)
                       PROJECT(CEN:SKAITS)
                       PROJECT(CEN:CENA)
                       PROJECT(CEN:CENA1)
                       PROJECT(CEN:CENA2)
                       PROJECT(CEN:VALUTA)
                       PROJECT(CEN:DATUMS)
                       PROJECT(CEN:KEKSIS)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::CEN:KATALOGA_NR  LIKE(CEN:KATALOGA_NR)      ! Queue Display field
BRW1::CEN:NOS_U        LIKE(CEN:NOS_U)            ! Queue Display field
BRW1::CEN:SKAITS       LIKE(CEN:SKAITS)           ! Queue Display field
BRW1::CEN_CENA         LIKE(CEN_CENA)             ! Queue Display field
BRW1::CEN:CENA1        LIKE(CEN:CENA1)            ! Queue Display field
BRW1::CEN:CENA2        LIKE(CEN:CENA2)            ! Queue Display field
BRW1::CEN:VALUTA       LIKE(CEN:VALUTA)           ! Queue Display field
BRW1::CEN:DATUMS       LIKE(CEN:DATUMS)           ! Queue Display field
BRW1::CEN:KEKSIS       LIKE(CEN:KEKSIS)           ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(CEN:KATALOGA_NR),DIM(100)
BRW1::Sort1:LowValue LIKE(CEN:KATALOGA_NR)        ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(CEN:KATALOGA_NR)       ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Browse the CENUVEST File'),AT(,,358,234),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseCVesture'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(9,21,338,163),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('72L(2)|M~Kataloga Nr~C@s17@16L(1)|M~RAZ~C(0)@s3@28R(2)|M~Skaits~C(0)@n6@47R(2)|M' &|
   '~Cena~C(0)@n-13.2@40R(1)|M~V-Cena~C(0)@n-10.2@40R(1)|M~M-Cena~C(0)@n-10.2@18R(1)' &|
   '|M~VAL~C(0)@s3@49R(2)|M~Datums~C(0)@D6@28L(2)|M~X~L(1)@s1@'),FROM(Queue:Browse:1)
                       BUTTON('&Ievadît'),AT(177,191,45,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(227,191,45,14),USE(?Change:2),DEFAULT
                       BUTTON('&Dzçst'),AT(276,191,45,14),USE(?Delete:2)
                       BUTTON('Nodzçst visas konkrçta RAZ cenas'),AT(5,216,124,14),USE(?ButtonDzestRaz),DISABLE
                       BUTTON('I&mportçt PIC no Nom_k'),AT(132,216,86,14),USE(?ImportetNOM_K),DISABLE
                       BUTTON('I&mportçt no citas DB'),AT(220,216,86,14),USE(?Importet),DISABLE
                       SHEET,AT(4,2,350,207),USE(?CurrentTab)
                         TAB('Kataloga Nr secîba'),USE(?Tab:2)
                           ENTRY(@s17),AT(11,190),USE(CEN:KATALOGA_NR)
                           BUTTON('Âtrais &Pasûtîjums'),AT(99,191,74,14),USE(?ButtonAtraisPas)
                         END
                       END
                       BUTTON('&Beigt'),AT(308,216,45,14),USE(?Close)
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
  IF ATLAUTS[1]    !SUPERACCESS
     ENABLE(?ButtonDzestRaz)
     ENABLE(?Importet)
     ENABLE(?ImportetNom_k)
  .
  ACCEPT
     QUICKWINDOW{PROP:TEXT}='Raþotâju cenas  '&CLIP(RECORDS(cenuvest))&' raksti '
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
      IF NOM:kataloga_nr      !TEK SAUKTS NO NOM_K-PASÛTÎJUMI
         CLEAR(CEN:RECORD)
         CEN:KATALOGA_NR=NOM:KATALOGA_NR
         CEN:NOS_U=NOM:NOMENKLAT[19:21]
         SET(CEN:KAT_KEY,CEN:KAT_KEY)
         NEXT(CENUVEST)
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         SELECT(?Browse:1)
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
    OF ?ButtonDzestRaz
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPEN(RAZWINDOW) 
        DISPLAY
        ACCEPT
            CASE FIELD()
            OF ?OK
              CASE Event()
              OF Event:Accepted
                SET(CENUVEST)
                LOOP
                   NEXT(CENUVEST)
                   IF ERROR() THEN BREAK.
                   I#+=1
                   IF CEN:NOS_U=NOS_U
                      J#+=1
                      DELETE(CENUVEST)
                   .
                   ACTIONSTRING='Nolasîti: '&i#&' nodzçsti: '&j#
                   display(?actionstring)
                .
                BREAK
              .
            OF ?CANCEL
              CASE Event()
              OF Event:Accepted
                BREAK
              .
            .
        .
        CLOSE(RAZWINDOW)
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
      END
    OF ?ImportetNOM_K
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPEN(RAZWINDOW)
        ?StringRAZ{Prop:Text}='Importçt visas cenas, kur raþotâjs ir:'
        DISPLAY
        ACCEPT
            CASE FIELD()
            OF ?OK
              CASE Event()
              OF Event:Accepted
                SET(NOM_K)
                LOOP
                  NEXT(NOM_K)
                  IF ERROR() THEN BREAK.
                  IF NOS_U=NOM:NOMENKLAT[19:21]
                    IF ~NOM:KATALOGA_NR
                       KLUDA(0,'Nav definçts kataloga NR '&nom:nomenklat)
                    ELSE
                      CLEAR(cen:RECORD)
                      CEN:kataloga_nr=NOM:KATALOGA_NR
                      CEN:NOS_U=NOM:NOMENKLAT[19:21]
                      CEN:DATUMS=NOM:PIC_DATUMS
                      GET(CENUVEST,CEN:KAT_KEY)
                      IF ERROR()
                         ACTION#=1
                      ELSE
                         ACTION#=2
                      .
          !            CEN:SKAITS=KOI:MIN_IEP
                      CEN:CENA=NOM:PIC
                      CEN:VALUTA='Ls'
                      CEN:CENA1=NOM:REALIZ[2]
                      CEN:CENA2=NOM:REALIZ[1]
          !            CEN:DATUMS=KOI:DATUMS
                      CEN:KEKSIS=''
                      EXECUTE ACTION#
                         ADD(CENUVEST)
                         PUT(CENUVEST)
                      .
                      J#+=1
                    .
                  .
                  ACTIONSTRING='Nolasîti: '&i#&' pârrakstîti: '&j#
                  display(?actionstring)
                .
                BREAK
              .
            OF ?CANCEL
              CASE Event()
              OF Event:Accepted
                BREAK
              .
            .
        .
        CLOSE(RAZWINDOW)
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
        
        
        OMIT('MARIS')
          SET(NOM_K)
          RecordsToProcess = RECORDS(NOM_K)
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
                 NEXT(NOM_K)
                 RAKSTI#+=1
                 ?Progress:UserString{Prop:Text}=RAKSTI#
                 IF ERROR()
                    POST(Event:CloseWindow)
                    break
                 .
                 IF NOM:KATALOGA_NR
                    CLEAR(cen:RECORD)
                    CEN:kataloga_nr=NOM:KATALOGA_NR
                    CEN:NOS_U=NOM:NOMENKLAT[19:21]
                    CEN:DATUMS=NOM:PIC_DATUMS
                    GET(CENUVEST,CEN:KAT_KEY)
                    IF ERROR()
                       ACTION#=1
                    ELSE
                       ACTION#=2
                    .
        !            CEN:SKAITS=KOI:MIN_IEP
                    CEN:CENA=NOM:PIC
                    CEN:VALUTA='Ls'
                    CEN:CENA1=NOM:REALIZ[2]
                    CEN:CENA2=NOM:REALIZ[1]
        !            CEN:DATUMS=KOI:DATUMS
                    CEN:KEKSIS=''
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
         MARIS
      END
    OF ?Importet
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          BrowseKOIVUNEN
          LocalRequest = OriginalRequest
          BRW1::LocateMode = LocateOnEdit
          DO BRW1::LocateRecord
          DO BRW1::InitializeBrowse
          DO BRW1::PostNewSelection
          DO BRW1::RefreshPage
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
    OF ?CEN:KATALOGA_NR
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?CEN:KATALOGA_NR)
        IF CEN:KATALOGA_NR
          CLEAR(CEN:NOS_U)
          CLEAR(CEN:DATUMS)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = CEN:KATALOGA_NR
          BRW1::Sort1:LocatorLength = LEN(CLIP(CEN:KATALOGA_NR))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?ButtonAtraisPas
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        open(PasWindow)
        nomenklat=''
        NOSAUKUMS=''
        LIGUMCENA=0
        PAS_U_NR=0
        NEW#=FALSE
        clear(nom:record)
        nom:KATALOGA_NR=cen:kataloga_nr
        SET(NOM:KAT_KEY,NOM:KAT_KEY)
        LOOP
           NEXT(NOM_K)
        !   STOP(NOM:KATALOGA_NR&'='&CEN:KATALOGA_NR)
           IF ERROR() OR NOM:KATALOGA_NR[1:6] > CEN:KATALOGA_NR[1:6] THEN BREAK.
           IF NOM:KATALOGA_NR=CEN:KATALOGA_NR AND NOM:NOMENKLAT[19:21]=CEN:NOS_U
              nomenklat=NOM:NOMENKLAT
              NOSAUKUMS=NOM:NOS_P
              BREAK
           .
        .
        IF ~(ATLAUTS[1]='1') THEN HIDE(?cen:cena).
        cena1=CEN:CENA1*BANKURS(CEN:VALUTA,0,,1)   !TESTA KURSS
        cena2=CEN:CENA2*BANKURS(CEN:VALUTA,0,,1)   !TESTA KURSS
        SAN_nr=0
        SAN_NOS=''
        DAUDZUMS=1
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF ?CANCELAP
             IF EVENT()=EVENT:ACCEPTED
                BREAK
             .
           OF ?ButtonV
             IF EVENT()=EVENT:ACCEPTED
                LIGUMCENA=CENA1*DAUDZUMS
             .
           OF ?ButtonM
             IF EVENT()=EVENT:ACCEPTED
                LIGUMCENA=CENA2*DAUDZUMS
             .
           OF ?Partneris
             IF EVENT()=EVENT:ACCEPTED
                globalrequest=selectrecord
                BROWSEPAR_K
                IF GlobalResponse=RequestCompleted
                   IF ~(GETPAR_ATZIME(PAR:ATZIME1,2) ='2') AND| !NAV AIZLIEGUMA KAUT KO PÂRDOT
                      ~(GETPAR_ATZIME(PAR:ATZIME2,2) ='2')      !NAV AIZLIEGUMA KAUT KO PÂRDOT
                      SAN_nr=par:U_nr
                      SAN_NOS=PAR:NOS_S
                   .
                .
             .
           OF ?OkAP
             IF EVENT()=EVENT:ACCEPTED
                IF DAUDZUMS
                   PAS_U_NR=0
                   CHECKOPEN(PAR_K,1)
                   CLEAR(PAR:RECORD)
                   PAR:NOS_U=CEN:NOS_U
                   GET(PAR_K,PAR:NOS_U_KEY)
                   IF ERROR()
                      KLUDA(120,'Partneris ar raþotâja kodu: '&CEN:nos_u)
                      BREAK
                   ELSE
                      PAR_NR=PAR:U_NR
                   .
                   IF NOLPAS::USED=0
                      CHECKOPEN(NOLPAS,1)
                   .
                   NOLPAS::USED+=1
                   IF PAVPAS::USED=0
                      CHECKOPEN(PAVPAS,1)
                   .
                   PAVPAS::USED+=1
                   CLEAR(PAS:RECORD)
                   PAS:PAR_NR=PAR_NR
                   SET(PAS:PAR_KEY,PAS:PAR_KEY)
                   LOOP
                      NEXT(PAVPAS)
                      IF ERROR() OR ~(PAS:PAR_NR=PAR_NR) THEN BREAK.
                      IF PAS:RS='S'  THEN CYCLE.     !TIKAI, KAS VÇL NAV SLÇGTI
                      IF PAS:TIPS='L'  THEN CYCLE.   !TIKAI AR TIPU K
                      PAS_U_NR=PAS:U_NR
                   .
                   IF ~PAS_U_NR                    !IEVADAM JAUNU
                       KLUDA(0,'Nav atrasts neviens atvçrts pasûtîjums')
                       BREAK
        !              DO AUTONUMBER
        !              IF Localresponse=REQUESTCOMPLETED
        !                 PAS_U_NR=PAS:U_NR
        !              .
        !              NEW#=TRUE
                   ELSE
                      CLEAR(PAS:RECORD)
                      PAS:U_NR=PAS_U_NR
                      GET(PAVPAS,PAS:NR_KEY)
                      PAS_SUMMA =PAS:SUMMA
                      PAS_SUMMAV=PAS:SUMMAV
                   .
                   IF PAS_U_NR
                      IF ~PAS:VAL  !VÇL NAV DEFINÇTA P/Z VALÛTA
                         CENA=CEN:CENA
                         PAS:VAL=CEN:VALUTA
                      ELSIF PAS:VAL AND ~(PAS:VAL=CEN:VALUTA) !IR DEFINÇTA PASÛTÎJUMA VALÛTA UN ATÐÍIRÂS NO CENAS VALÛTAS
                         KLUDA(76,'ignorçju cenu: '&CEN:cena&' '&cen:valUTA)
                         CENA=0
                      ELSE
                         CENA=CEN:CENA
                         PAS:VAL=CEN:VALUTA
                      .
                      CLEAR(NOS:RECORD)
                      NOS:U_NR=PAS_U_NR
                      NOS:DOK_NR=PAS:DOK_NR
                      NOS:DATUMS=PAS:DATUMS
                      NOS:PAR_NR=PAS:PAR_NR
                      NOS:NOL_NR=14                        !PIEÐÛTS GAG
                      NOS:NOMENKLAT=nomenklat
                      NOS:NOS_S=NOS_S
                      NOS:kataloga_nr=CEN:kataloga_nr
                      NOS:DAUDZUMS=DAUDZUMS
                      IF NOMENKLAT
                         NOS:PVN_PROC=NOM:PVN_PROC
                      ELSE
                         NOS:PVN_PROC=SYS:NOKL_PVN
                      .
                      NOS:SUMMAV=NOS:DAUDZUMS*CENA
                      NOS:VAL=PAS:VAL
                      NOS:SUMMA=NOS:SUMMAV*BANKURS(NOS:VAL,NOS:DATUMS,,1) ! TESTA KURSS
                      NOS:LIGUMCENA=LIGUMCENA
                      NOS:SAN_NR=SAN_NR
                      NOS:SAN_NOS=SAN_NOS
                      NOS:ACC_KODS=ACC_KODS
                      NOS:ACC_DATUMS=TODAY()
                      ADD(NOLPAS)
                      IF ERROR()
                         KLUDA(24,'NOLPAS (ADD)')
                      ELSE
        !                 IF NEW#                 !JAUNS PASÛTÎJUMS
        !                    KLUDA(0,'Izveidots jauns pasûtîjums un tam pievienots '& NOS:kataloga_nr)
        !                 ELSE
                            KLUDA(0,'Atrasts atvçrts pasûtîjums no '&FORMAT(PAS:DATUMS,@D6)&' un tam pievienots '& NOS:kataloga_nr)
        !                 .
                      .
                      PAS_SUMMA+=NOS:SUMMA
                      PAS_SUMMAV+=NOS:SUMMAV
                      PAS:SUMMA =PAS_SUMMA
                      PAS:SUMMAV=PAS_SUMMAV
                      IF RIUPDATE:PAVPAS()
                         KLUDA(24,'PAVPAS')
                      .
                   ELSE
                      STOP('PASÛTÎJUMS NAV IZVEIDOTS....')
                   .
                ELSE
                   KLUDA(87,'DAUDZUMS...')
                END
                PAR_NR=0
                NOLPAS::USED-=1
                IF NOLPAS::USED=0
                   CLOSE(NOLPAS)
                .
                PAVPAS::USED-=1
                IF PAVPAS::USED=0
                   CLOSE(PAVPAS)
                .
                BREAK
             .
           .
           DISPLAY
        .
        CLOSE(PASWINDOW)
        SELECT(?BROWSE:1)
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
  IF CENUVEST::Used = 0
    CheckOpen(CENUVEST,1)
  END
  CENUVEST::Used += 1
  BIND(CEN:RECORD)
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
  INIRestoreWindow('BrowseCENUVEST','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
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
    CENUVEST::Used -= 1
    IF CENUVEST::Used = 0 THEN CLOSE(CENUVEST).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
  END
  IF WindowOpened
    INISaveWindow('BrowseCENUVEST','winlats.INI')
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
    CEN:KATALOGA_NR = BRW1::Sort1:LocatorValue
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
!---------------------------------------------------------------
AUTONUMBER ROUTINE
  LocalResponse = RequestCompleted
  CLEAR(PAS:Record)
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
    CLEAR(PAS:RECORD)
    PAS:U_NR = Auto::Save:PAS:U_NR
    PAS:DATUMS=TODAY()
    PAS:RS=''
    PAS:VAL=''
    PAS:PAR_NR=PAR:U_NR
    PAS:NOKA=PAR:NOS_S
    PAS:KEKSIS=0
    PAS:ACC_KODS=ACC_KODS
    PAS:ACC_DATUMS=TODAY()
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
      CEN:KATALOGA_NR = BRW1::Sort1:LocatorValue
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
      StandardWarning(Warn:RecordFetchError,'CENUVEST')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = CEN:KATALOGA_NR
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'CENUVEST')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = CEN:KATALOGA_NR
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
  CEN:KATALOGA_NR = BRW1::CEN:KATALOGA_NR
  CEN:NOS_U = BRW1::CEN:NOS_U
  CEN:SKAITS = BRW1::CEN:SKAITS
  CEN_CENA = BRW1::CEN_CENA
  CEN:CENA1 = BRW1::CEN:CENA1
  CEN:CENA2 = BRW1::CEN:CENA2
  CEN:VALUTA = BRW1::CEN:VALUTA
  CEN:DATUMS = BRW1::CEN:DATUMS
  CEN:KEKSIS = BRW1::CEN:KEKSIS
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
  IF ATLAUTS[15]='1' !AIZLIEGTA PIEEJA PASÛTÎJUMIEM
     CEN_CENA=0
  ELSE
     CEN_CENA=CEN:CENA
  .
  BRW1::CEN:KATALOGA_NR = CEN:KATALOGA_NR
  BRW1::CEN:NOS_U = CEN:NOS_U
  BRW1::CEN:SKAITS = CEN:SKAITS
  BRW1::CEN_CENA = CEN_CENA
  BRW1::CEN:CENA1 = CEN:CENA1
  BRW1::CEN:CENA2 = CEN:CENA2
  BRW1::CEN:VALUTA = CEN:VALUTA
  BRW1::CEN:DATUMS = CEN:DATUMS
  BRW1::CEN:KEKSIS = CEN:KEKSIS
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
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => UPPER(CEN:KATALOGA_NR)
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
      CEN:KATALOGA_NR = BRW1::Sort1:LocatorValue
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
        IF KEYCODE() = BSKey
          IF BRW1::Sort1:LocatorLength
            BRW1::Sort1:LocatorLength -= 1
            BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength)
            CEN:KATALOGA_NR = BRW1::Sort1:LocatorValue
            CLEAR(CEN:NOS_U)
            CLEAR(CEN:DATUMS)
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          CEN:KATALOGA_NR = BRW1::Sort1:LocatorValue
          CLEAR(CEN:NOS_U)
          CLEAR(CEN:DATUMS)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          CEN:KATALOGA_NR = BRW1::Sort1:LocatorValue
          CLEAR(CEN:NOS_U)
          CLEAR(CEN:DATUMS)
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
      CEN:KATALOGA_NR = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'CENUVEST')
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
      BRW1::HighlightedPosition = POSITION(CEN:KAT_KEY)
      RESET(CEN:KAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(CEN:KAT_KEY,CEN:KAT_KEY)
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
    OF 1; ?CEN:KATALOGA_NR{Prop:Disable} = 0
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
    CLEAR(CEN:Record)
    CASE BRW1::SortOrder
    OF 1; ?CEN:KATALOGA_NR{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
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
    SET(CEN:KAT_KEY)
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
  GET(CENUVEST,0)
  CLEAR(CEN:Record,0)
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
!| (UpdateCENUVEST) is called.
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
    UpdateCENUVEST
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
        GET(CENUVEST,0)
        CLEAR(CEN:Record,0)
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


BrowseNol_Stat PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
N_TABLE     QUEUE,PRE(N)
NOMENKLAT     STRING(21)
DAUDZUMS      LONG,DIM(12)
SUMMA         DECIMAL(9,2),DIM(12)
            .
SAV_NOLIKNAME LIKE(NOLIKNAME)

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
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO

BRW1::View:Browse    VIEW(NOL_STAT)
                       PROJECT(STAT:NOMENKLAT)
                       PROJECT(STAT:KATALOGA_NR)
                       PROJECT(STAT:REDZAMIBA)
                       PROJECT(STAT:ATBILDIGAIS)
                       PROJECT(STAT:NOS_S)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::STAT:NOMENKLAT   LIKE(STAT:NOMENKLAT)       ! Queue Display field
BRW1::STAT:KATALOGA_NR LIKE(STAT:KATALOGA_NR)     ! Queue Display field
BRW1::STAT:REDZAMIBA   LIKE(STAT:REDZAMIBA)       ! Queue Display field
BRW1::STAT:ATBILDIGAIS LIKE(STAT:ATBILDIGAIS)     ! Queue Display field
BRW1::STAT:NOS_S       LIKE(STAT:NOS_S)           ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(STAT:NOMENKLAT),DIM(100)
BRW1::Sort1:LowValue LIKE(STAT:NOMENKLAT)         ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(STAT:NOMENKLAT)        ! Queue position of scroll thumb
BRW1::Sort1:Reset:ACC_KODS_N LIKE(ACC_KODS_N)
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort2:KeyDistribution LIKE(STAT:NOMENKLAT),DIM(100)
BRW1::Sort2:LowValue LIKE(STAT:NOMENKLAT)         ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(STAT:NOMENKLAT)        ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Browse the NOL_STAT File'),AT(,,429,277),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseNol_Stat'),SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&2-Serviss'),USE(?Serviss)
                           ITEM('Pârrçíinât statistiku'),USE(?ServissPârrçíinâtstatistiku)
                         END
                         MENU('&4-Faili'),USE(?Faili)
                           ITEM('1&0-Cenu vçsture'),USE(?FailiCenuvçsture)
                         END
                       END
                       LIST,AT(8,20,413,222),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('80L(2)|M~Nomenklatûra~C@s21@72L(2)|M~Kataloga Numurs~C@s17@40R(2)|M~Redzamîba~C(' &|
   '0)@n3@43R(2)|M~Atbildîgais~C(0)@n6@68L(2)|M~Nosaukums~C@s16@'),FROM(Queue:Browse:1)
                       ENTRY(@s21),AT(29,256),USE(STAT:NOMENKLAT),UPR
                       BUTTON('Iz&vçlçties'),AT(162,255,45,14),USE(?Select:2),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                       BUTTON('&Ievadît'),AT(213,255,45,14),USE(?Insert:3),DISABLE
                       BUTTON('&Mainît'),AT(265,255,45,14),USE(?Change:3),DEFAULT
                       BUTTON('&Dzçst'),AT(317,255,45,14),USE(?Delete:3)
                       SHEET,AT(4,4,421,244),USE(?CurrentTab)
                         TAB('Visas &Nomenklatûras'),USE(?Tab:2)
                         END
                         TAB('&Tikai atbildîbâ esoðâs'),USE(?Tab:3)
                         END
                       END
                       BUTTON('&Beigt'),AT(371,255,45,14),USE(?Close)
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
         CLEAR(STAT:RECORD)
         STAT:NOMENKLAT=NOMENKLAT
         SET(STAT:NOM_KEY,STAT:NOM_KEY)
         NEXT(NOL_STAT)
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
    CASE ACCEPTED()
    OF ?ServissPârrçíinâtstatistiku
      DO SyncWindow
        DO PARREKSTAT
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
    OF ?FailiCenuvçsture
      DO SyncWindow
      START(BrowseCENUVEST,25000)
      LocalRequest = OriginalRequest
      DO RefreshWindow
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
    OF ?STAT:NOMENKLAT
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?STAT:NOMENKLAT)
        IF STAT:NOMENKLAT
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = STAT:NOMENKLAT
          BRW1::Sort1:LocatorLength = LEN(CLIP(STAT:NOMENKLAT))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?Select:2
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
    OF ?Tab:2
      CASE EVENT()
      END
      F:ATBILDIGAIS=0
    OF ?Tab:3
      CASE EVENT()
      END
      F:ATBILDIGAIS=1
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
  IF NOL_STAT::Used = 0
    CheckOpen(NOL_STAT,1)
  END
  NOL_STAT::Used += 1
  BIND(STAT:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowseNol_Stat','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select:2{Prop:Hide} = True
    DISABLE(?Select:2)
  ELSE
  END
  BIND('ACC_KODS_N',ACC_KODS_N)
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
    NOL_STAT::Used -= 1
    IF NOL_STAT::Used = 0 THEN CLOSE(NOL_STAT).
  END
  IF WindowOpened
    INISaveWindow('BrowseNol_Stat','winlats.INI')
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
    STAT:NOMENKLAT = BRW1::Sort1:LocatorValue
  OF 2
    STAT:NOMENKLAT = BRW1::Sort2:LocatorValue
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

!-----------------------------------------------------------------------------------------------
PARREKSTAT      ROUTINE
  OPCIJA='020'
  IZZFILTGMC
  IF ~(GLOBALRESPONSE=REQUESTCOMPLETED)
     EXIT
  .
  SEL_NOL_NR25
  IF ~(GLOBALRESPONSE=REQUESTCOMPLETED)
     EXIT
  .
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(NOM_K,1)
  NOM_K::USED+=1
  RECS#=0
  END#=0
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Statistikas pârrçíins par '&clip(GL:DB_GADS)&'.g. no '&format(s_dat,@d6)
  ?Progress:UserString{Prop:Text}='Pârlasam Nom_k'
  DISPLAY()
!*************************************** 1 UZBÛVÇJAM N_TABLE ***********************************************************
  SET(NOM:NOM_KEY)
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    IF END# THEN BREAK.
    CASE EVENT()
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         NEXT(NOM_K)
         IF ERROR()
            END#=1
            BREAK
         .
         IF NOM:TIPS='A' THEN CYCLE. !Pakalpojumus izlaiþam
         RECS#+=1
         N:NOMENKLAT=NOM:NOMENKLAT
         ADD(N_TABLE)
         IF ERROR() THEN STOP(RECS#&' RAKSTI '&RECS#*(21+4+6)&' BAITI ATMIÒAS TABULÂ '&ERROR()).
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
           END
         ?Progress:UserString{Prop:Text}='Pârlasam Nom_k '&recs#
         DISPLAY()
         END
      END
    END
    CASE FIELD()
    OF ?Progress:Cancel
      CASE Event()
      OF Event:Accepted
        LocalResponse = RequestCancelled
        DO PROCEDURERETURNR
        EXIT
      END
    END
  END
!*************************************** 2 LASAM NOLIKTAVAS ***********************************************************
 SAV_NOLIKNAME=NOLIKNAME
 CLOSE(NOLIK)
 LOOP I#= 1 TO NOL_SK
    IF ~NOL_NR25[I#] THEN CYCLE.
    RECS#=0
    END#=0
    NOLIKNAME='NOLIK'&FORMAT(I#,@N02)
    CHECKOpen(NOLIK,1)
    CLEAR(NOL:RECORD)
    RecordsToProcess = RECORDS(NOLIK)
    RecordsProcessed = 0
    PercentProgress = 0
    Progress:Thermometer = 0
    ?Progress:PctText{Prop:Text} = '0% izpildîti'
    ?Progress:UserString{Prop:Text}='Lasam '&NOLIKNAME
    DISPLAY()
  !  STOP(1)
    NOL:DATUMS=S_DAT
    NOL:D_K='K'
    SET(NOL:DAT_KEY,NOL:DAT_KEY)
    SEND(NOLIK,'QUICKSCAN=on')
    ACCEPT
      IF END# THEN BREAK.
      CASE EVENT()
      OF Event:Timer
        LOOP RecordsPerCycle TIMES
           NEXT(NOLIK)
           IF ERROR()
              END#=1
              BREAK
           .
           RECS#+=1
           IF ~INRANGE(NOL:PAR_NR,1,50) !NAV IEKÐÇJA PÂRVIETOÐANA VAI RAÞOÐANA
              CASE NOL:D_K
              OF 'K'
                 IF ~(N:NOMENKLAT=NOL:NOMENKLAT)
                    GET(N_TABLE,0)
                    N:NOMENKLAT=NOL:NOMENKLAT
                    GET(N_TABLE,N:NOMENKLAT)
                 .
                 N:DAUDZUMS[MONTH(NOL:DATUMS)]+=NOL:DAUDZUMS
                 N:SUMMA[MONTH(NOL:DATUMS)]+=CALCSUM(15,2)  !BEZ PVN LATOS -ATLAIDE
                 PUT(N_TABLE)
                 DAUDZUMS#+=NOL:DAUDZUMS
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
               ?Progress:PctText{Prop:Text} = 'analizçti '&FORMAT(PercentProgress,@N3) & '% no DB'
             END
             ?Progress:UserString{Prop:Text}='Lasam '&NOLIKNAME&' '&RECS#
             DISPLAY()
           END
        END
      END
      CASE FIELD()
      OF ?Progress:Cancel
        CASE Event()
        OF Event:Accepted
          LocalResponse = RequestCancelled
          DO PROCEDURERETURNR
          EXIT
        END
      END
    END
  !  stop('ENDDONOLIK:'&DAUDZUMS#)
    SEND(NOLIK,'QUICKSCAN=off')
    CLOSE(NOLIK)
 END
!*************************************** 3 RAKSTAM STATISTIKU ***********************************************************
  RecordsToProcess = RECORDS(N_TABLE)
  RecordsProcessed = 0
  PercentProgress = 0
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ?Progress:UserString{Prop:Text}='Rakstam Nol_Stat'
  DISPLAY()
  G#=GL:DB_GADS-1995  !PIEÐÛTS STATISTIKAI NO 1996.G.
  I#=0
  ACCEPT
    CASE EVENT()
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         I#+=1
         IF I#> RECORDS(N_TABLE)
            POST(Event:CloseWindow)
            BREAK
         .
         GET(N_TABLE,I#)
         CLEAR(STAT:RECORD)
         STAT:NOMENKLAT=N:NOMENKLAT
         GET(NOL_STAT,STAT:NOM_KEY)
         IF ERROR()
            STAT:NOMENKLAT=N:NOMENKLAT
            LOOP M#= 1 TO 12
               STAT:DAUDZUMS[M#,G#] = N:DAUDZUMS[M#]
            .
            STAT:NOS_S=GETNOM_K(STAT:NOMENKLAT,0,3)
            STAT:KATALOGA_NR=NOM:KATALOGA_NR
            STAT:REDZAMIBA=NOM:REDZAMIBA
            STAT:ATBILDIGAIS=NOM:ATBILDIGAIS
            ADD(NOL_STAT)
         ELSE
            IF ~(STAT:KATALOGA_NR=GETNOM_K(N:NOMENKLAT,2,14)) !MAINÎTS KATALOGA NR, MAINAM PASÛTÎJUMUS
               IF NOM:KATALOGA_NR
                  STAT:KATALOGA_NR=NOM:KATALOGA_NR
                  CHECKOPEN(NOLPAS,1)
                  NOS:NOMENKLAT=NOM:NOMENKLAT
                  SET(NOS:NOM_KEY,NOS:NOM_KEY)
                  LOOP
                     NEXT(NOLPAS)
                     IF ERROR() OR ~(NOS:NOMENKLAT=NOM:NOMENKLAT) THEN BREAK.
                     IF ~(NOS:KATALOGA_NR=NOM:KATALOGA_NR)
                        NOS:KATALOGA_NR=NOM:KATALOGA_NR
                        IF RIUPDATE:NOLPAS()
                           KLUDA(24,'NOLPAS')
                        .
                     .
                  .
               .
            .
            STAT:REDZAMIBA=NOM:REDZAMIBA  !JA MAINÎTS
            STAT:ATBILDIGAIS=NOM:ATBILDIGAIS
            LOOP M#= MEN_NR TO 12
               STAT:DAUDZUMS[M#,G#] = N:DAUDZUMS[M#]
            .
            IF RIUPDATE:NOL_STAT()
               KLUDA(24,'NOL_STAT')
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
           END
           ?Progress:UserString{Prop:Text}='Rakstam Nol_Stat '&I#
           DISPLAY()
         END
      END
    END
    CASE FIELD()
    OF ?Progress:Cancel
      CASE Event()
      OF Event:Accepted
        LocalResponse = RequestCancelled
        DO PROCEDURERETURNR
        EXIT
      END
    END
  END
  DO PROCEDURERETURNR
!--------------------------------------------------------------------------------------------------------
PROCEDURERETURNR     ROUTINE
  NOM_K::USED-=1
  IF NOM_K::USED=0 THEN CLOSE(NOM_K).
  FREE(N_TABLE)
  NOLIKNAME=SAV_NOLIKNAME
  CLOSE(ProgressWindow)
  POPBIND
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
    OF 1
      IF BRW1::Sort1:Reset:ACC_KODS_N <> ACC_KODS_N
        BRW1::Changed = True
      END
    END
  ELSE
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:LocatorValue = ''
      BRW1::Sort1:LocatorLength = 0
      STAT:NOMENKLAT = BRW1::Sort1:LocatorValue
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      STAT:NOMENKLAT = BRW1::Sort2:LocatorValue
    END
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:ACC_KODS_N = ACC_KODS_N
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
      StandardWarning(Warn:RecordFetchError,'NOL_STAT')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = STAT:NOMENKLAT
  OF 2
    BRW1::Sort2:HighValue = STAT:NOMENKLAT
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NOL_STAT')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = STAT:NOMENKLAT
    SetupStringStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue,SIZE(BRW1::Sort1:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  OF 2
    BRW1::Sort2:LowValue = STAT:NOMENKLAT
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
  STAT:NOMENKLAT = BRW1::STAT:NOMENKLAT
  STAT:KATALOGA_NR = BRW1::STAT:KATALOGA_NR
  STAT:REDZAMIBA = BRW1::STAT:REDZAMIBA
  STAT:ATBILDIGAIS = BRW1::STAT:ATBILDIGAIS
  STAT:NOS_S = BRW1::STAT:NOS_S
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
  BRW1::STAT:NOMENKLAT = STAT:NOMENKLAT
  BRW1::STAT:KATALOGA_NR = STAT:KATALOGA_NR
  BRW1::STAT:REDZAMIBA = STAT:REDZAMIBA
  BRW1::STAT:ATBILDIGAIS = STAT:ATBILDIGAIS
  BRW1::STAT:NOS_S = STAT:NOS_S
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => UPPER(STAT:NOMENKLAT)
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
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => UPPER(STAT:NOMENKLAT)
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
      STAT:NOMENKLAT = BRW1::Sort1:LocatorValue
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      STAT:NOMENKLAT = BRW1::Sort2:LocatorValue
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
        IF KEYCODE() = BSKey
          IF BRW1::Sort1:LocatorLength
            BRW1::Sort1:LocatorLength -= 1
            BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength)
            STAT:NOMENKLAT = BRW1::Sort1:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          STAT:NOMENKLAT = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          STAT:NOMENKLAT = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            STAT:NOMENKLAT = BRW1::Sort2:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          STAT:NOMENKLAT = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          STAT:NOMENKLAT = BRW1::Sort2:LocatorValue
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
      STAT:NOMENKLAT = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 2
      STAT:NOMENKLAT = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'NOL_STAT')
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
      BRW1::HighlightedPosition = POSITION(STAT:ATB_KEY)
      RESET(STAT:ATB_KEY,BRW1::HighlightedPosition)
    ELSE
      STAT:ATBILDIGAIS = ACC_KODS_N
      SET(STAT:ATB_KEY,STAT:ATB_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'STAT:ATBILDIGAIS = ACC_KODS_N'
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(STAT:NOM_key)
      RESET(STAT:NOM_key,BRW1::HighlightedPosition)
    ELSE
      SET(STAT:NOM_key,STAT:NOM_key)
    END
    BRW1::View:Browse{Prop:Filter} = ''
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
    OF 1; ?STAT:NOMENKLAT{Prop:Disable} = 0
    OF 2; ?STAT:NOMENKLAT{Prop:Disable} = 0
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
    ?Change:3{Prop:Disable} = 0
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(STAT:Record)
    CASE BRW1::SortOrder
    OF 1; ?STAT:NOMENKLAT{Prop:Disable} = 1
    OF 2; ?STAT:NOMENKLAT{Prop:Disable} = 1
    END
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
    STAT:ATBILDIGAIS = ACC_KODS_N
    SET(STAT:ATB_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'STAT:ATBILDIGAIS = ACC_KODS_N'
  OF 2
    SET(STAT:NOM_key)
    BRW1::View:Browse{Prop:Filter} = ''
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
    ACC_KODS_N = BRW1::Sort1:Reset:ACC_KODS_N
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
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
  GET(NOL_STAT,0)
  CLEAR(STAT:Record,0)
  CASE BRW1::SortOrder
  OF 1
    STAT:ATBILDIGAIS = BRW1::Sort1:Reset:ACC_KODS_N
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
!| (UpdateNOL_STAT) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateNOL_STAT
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
        GET(NOL_STAT,0)
        CLEAR(STAT:Record,0)
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


