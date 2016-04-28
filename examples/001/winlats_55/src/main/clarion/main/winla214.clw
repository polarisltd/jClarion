                     MEMBER('winlats.clw')        ! This is a MEMBER module
UPAL3 PROCEDURE


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
STUNDAS              DECIMAL(3)
Update::Reloop  BYTE
Update::Error   BYTE
History::ALG:Record LIKE(ALG:Record),STATIC
SAV::ALG:Record      LIKE(ALG:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW(' '),AT(,,146,52),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UPAL3'),SYSTEM,GRAY,RESIZE,MDI
                       PROMPT('STUNDAS:'),AT(35,15,37,11),USE(?STUNDAS:Prompt)
                       ENTRY(@n_3),AT(85,15,23,11),USE(STUNDAS)
                       BUTTON('&OK'),AT(50,38,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(99,38,45,14),USE(?Cancel)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  CLEAR(KAD:RECORD)
  KAD:ID = ALG:ID
  GET(KADRI,KAD:ID_KEY)
  IF ERROR()
      KLUDA(59,ALG:ID)
  END
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  LOOP I#=1 TO 20
      IF ALG:K[I#] = DAIKODS
          STUNDAS = ALG:S[I#]
          BREAK
      END
  END
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
      SELECT(?STUNDAS:Prompt)
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
        History::ALG:Record = ALG:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(ALGAS)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(ALG:ID_KEY)
              IF StandardWarning(Warn:DuplicateKey,'ALG:ID_KEY')
                SELECT(?STUNDAS:Prompt)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?STUNDAS:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::ALG:Record <> ALG:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:ALGAS(1)
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
              SELECT(?STUNDAS:Prompt)
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
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        ALG:S[I#] = STUNDAS
        ALG:L[I#] = 1           !LOCK
        CALCALGAS
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
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  BIND(KAD:RECORD)
  FilesOpened = True
  RISnap:ALGAS
  SAV::ALG:Record = ALG:Record
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
        IF RIDelete:ALGAS()
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
  INIRestoreWindow('UPAL3','winlats.INI')
  WinResize.Resize
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
  END
  IF WindowOpened
    INISaveWindow('UPAL3','winlats.INI')
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
  ALG:Record = SAV::ALG:Record
  SAV::ALG:Record = ALG:Record
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

CHECKKODS            PROCEDURE (perskods)         ! Declare Procedure
kods0          STRING(11)
kods1          STRING(1),dim(11),over(kods0)
  CODE                                            ! Begin processed code
 IF PERSKODS
     kods0=format(PERSKODS,@n_011)
     sum1#=kods1[1]+kods1[2]*6+kods1[3]*3+kods1[4]*7+kods1[5]*9+kods1[6]*10+ |
           kods1[7]*5+kods1[8]*8+kods1[9]*4+kods1[10]*2
     r#=sum1#-INT(sum1#/11)*11
     k#=1-r#
     IF K# > -1
        CHECKDIGIT#=K#
     ELSIF K#=-1
        STOP('ÐIS PERSONAS KODAM NAV SERIÂLA NUMURA')
     ELSE
        CHECKDIGIT#=11+K#
     .
     IF ~CHECKDIGIT#=KODS1[11]
        KLUDA(78,'')
     .
  ELSE
     KLUDA(87,'Personas kods')
  .
BuvetAlgas PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
BUVET            STRING(1)
SAV_APGADSUM     decimal(5,2)
SAV_MIA          decimal(5,2)
SAV_MINA         LIKE(ALP:MINA)
SAV_MINS         LIKE(ALP:MINS)
SAV_PR_PAM       decimal(2)
SAV_PR_PAP       decimal(2)
SAV_AT_INV1      decimal(5,2)
SAV_AT_INV2      decimal(5,2)
SAV_AT_INV3      decimal(5,2)
SAV_AT_POLR      decimal(5,2)
SAV_AT_POLRNP    decimal(5,2)
SAV_SOC_VISS     decimal(4,2)

RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO

KAD_KA_DA        decimal(5,2)

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO

DIVWindow WINDOW('Dividendes'),AT(,,185,92),FONT('MS Sans Serif',10,,FONT:bold,CHARSET:BALTIC),GRAY
       STRING('Dividenþu aprçíinâðanas diena:'),AT(10,13),USE(?String1)
       ENTRY(@D06.B),AT(114,13,40,10),USE(ALP:YYYYMM),REQ
       STRING('Nesadalîtâ peïòa:'),AT(12,33),USE(?String2D)
       ENTRY(@N9.2),AT(72,33,37,10),USE(ALP:PARSKAITIT),RIGHT(1)
       BUTTON('&OK'),AT(102,70,35,14),USE(?OkButtonDIV),DEFAULT
       BUTTON('&Atlikt'),AT(141,69,36,14),USE(?CancelButtonDIV)
     END
window               WINDOW('Algu rçíins'),AT(,,280,115),IMM,SYSTEM,GRAY
                       OPTION('&Norâdiet darba veidu :'),AT(12,8,260,77),USE(BUVET),BOXED
                         RADIO('1 - Sâkuma nosacîjumi'),AT(18,20),USE(?BUVET:Radio1),VALUE('1')
                         RADIO('2 - Uzbûvçt avansus'),AT(18,32,76,10),USE(?BUVET:Radio2),VALUE('2')
                         RADIO('3 - Uzbûvçt visu'),AT(18,44,76,10),USE(?BUVET:Radio3),VALUE('3')
                         RADIO('4 - Pârbûvçt visu'),AT(18,56,76,10),USE(?BUVET:Radio4),VALUE('4')
                         RADIO('5 - Dividendes {17}(uzbûvçs visiem, kam definçtas kapitâla daïas)'),AT(18,68,248,10),USE(?BUVET:Radio4:2),VALUE('5')
                       END
                       STRING('(neapliekamais minimums, atvieglojumi)'),AT(106,20),USE(?String1)
                       STRING('(uzbûvçs visiem, kam jâbût sarakstâ, bet to nav)'),AT(106,32),USE(?String2)
                       STRING('(uzbûvçs visiem, kam jâbût sarakstâ, bet to nav)'),AT(106,44),USE(?String3)
                       STRING('(pârrçíinâs visiem, saglabâjot ievadîtos datus)'),AT(106,56),USE(?String4)
                       BUTTON('&OK'),AT(190,92,35,14),USE(?Ok),DEFAULT
                       BUTTON('&Atlikt'),AT(236,92,36,14),USE(?CancelButton)
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
  BUVET = '3'
  clear(ALP:record)
  ALP:YYYYMM=S_DAT
  !STOP(FORMAT(ALP:YYYYMM,@D06.))
  GET(ALGPA,ALP:YYYYMM_KEY)
  IF ERROR()
     DISABLE(?BUVET:Radio4)
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?BUVET:Radio1)
      select(?ok)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?Ok
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        
        RecordsToProcess = RECORDS(Kadri)
        RecordsPerCycle = 25
        RecordsProcessed = 0
        PercentProgress = 0

        ALP:ACC_KODS=ACC_KODS
        ALP:ACC_DATUMS=TODAY()

        OPEN(ProgressWindow)
        Progress:Thermometer = 0
        ?Progress:PctText{Prop:Text} = '0%'
        ProgressWindow{Prop:Text} = 'Bûvçjam algu sarakstu'
        ?Progress:UserString{Prop:Text}=''
        
        DO SAKNOS ! UZBÛVÇ "Sâkuma nosacîjumus"
        
        CLEAR(KAD:RECORD)
        SET(KADRI)
        
        CASE BUVET
        OF '1'
        !  UZBÛVÇT TIKAI SÂKUMA NOSACÎJUMUS
        OF '2' !*************************** UZBÛVÇ "AVANSUS"*********************************
        
           IF ALP:STAT=2
              KLUDA(63,'')
              DO PROCEDURERETURN
           .
           LOOP
              NEXT(KADRI)
              IF ERROR() THEN BREAK.
              IF KAD:DARBA_GR>DATE(MONTH(ALP:YYYYMM)+1,1,YEAR(ALP:YYYYMM))-1 | !NAV BIJIS PIEÒEMTS
              OR (KAD:D_GR_END AND KAD:D_GR_END<ALP:YYYYMM) THEN CYCLE.        !IR JAU ATLAISTS
              IF KAD:STATUSS='7' THEN CYCLE.                                   !ARHÎVS
              npk#+=1
              ?Progress:UserString{Prop:Text}=CLIP(KAD:VAR)&' '&KAD:UZV
              DO SHOWNextRecord
              CLEAR(ALG:RECORD)
              GET(ALGAS,0)
              ALG:YYYYMM  = ALP:YYYYMM
              ALG:ID    = KAD:ID
              GET(ALGAS,alg:ID_KEY)
              IF ERROR()
                 DO FILLDATI
                 alg:N[3]=kad:avanss
                 alg:I[3]=904
                 ALG:IZMAKSAT=-kad:avanss
                 ALP:IZMAKSAT+=ALG:IZMAKSAT
!                 ALP:PARSKAITIT+= SUM(56)   KAD KÂDS PRASÎS, DOMÂSIM TÂLÂK...
                 ADD(ALGAS)
              .
           .
           ALP:STATUSS='Avanss : '&menesisunG
           ALP:ACC_KODS=ACC_KODS
           ALP:ACC_datums=today()
           ALP:stat=1
           IF RIUPDATE:ALGPA()
              KLUDA(24,'ALGPA')
           .
           WriteZurnals(1,0,'ALGAS:BÛVÇJU AVANSUS'&CHR(9)&CHR(9)&FORMAT(ALP:YYYYMM,@D014.)&|
           CHR(9)&ALP:ACC_KODS&CHR(9)&FORMAT(ALP:ACC_datums,@D06.))
        
        OF '3' !****************** UZBÛVÇ "VISU" JA NAV SARAKSTÂ, VAI BIJIS AVANSS*****************
        
           ALP:IZMAKSAT=0
           ALP:PARSKAITIT=0
           ALP:AprIIN=0
           LOOP
              NEXT(KADRI)
              IF ERROR() THEN BREAK.
              IF KAD:DARBA_GR>DATE(MONTH(ALP:YYYYMM)+1,1,YEAR(ALP:YYYYMM))-1 | !NAV BIJIS PIEÒEMTS
              OR (KAD:D_GR_END AND KAD:D_GR_END<ALP:YYYYMM) THEN CYCLE.        !IR JAU ATLAISTS
              IF KAD:STATUSS='7' THEN CYCLE.                                   !ARHÎVS
              ?Progress:UserString{Prop:Text}=CLIP(KAD:VAR)&' '&KAD:UZV
        !      STOP(FORMAT(KAD:D_GR_END,@D6)&FORMAT(ALP:YYYYMM,@D6))
              DO SHOWNextRecord
              CLEAR(ALG:RECORD)
              GET(ALGAS,0)
              ALG:YYYYMM  = ALP:YYYYMM
              ALG:ID    = KAD:ID
              OPCIJA#=0
              GET(ALGAS,alg:ID_KEY)
              IF ERROR()
                 OPCIJA#=1
              ELSIF ALP:STAT=1  ! AVANSS
                 OPCIJA#=2
              ELSE
                 ALP:IZMAKSAT+=ALG:IZMAKSAT
                 ALP:PARSKAITIT+= ALG:PARSKAITIT
                 ALP:AprIIN  +=SUM(5)
              .
              IF OPCIJA#
                 DO FILLDATI
                 LOOP I#=1 TO 20
                    IF KAD:PIESKLIST[I#]=0 THEN CYCLE.
                    LOOP J#= 1 TO 20
                       IF KAD:PIESKLIST[I#]=ALG:K[J#] THEN BREAK.
                       IF ALG:K[J#]=0
                          ALG:K[J#]=KAD:PIESKLIST[I#]
                          BREAK
                       .
                    .
                 .
                 LOOP I#=1 TO 10
                    IF KAD:IETLIST[I#]=0 THEN CYCLE.
                    LOOP J#= 1 TO 15
                       IF KAD:IETLIST[I#]=ALG:I[J#] THEN BREAK.
                       IF ALG:I[J#]=0
                          ALG:I[J#]=KAD:IETLIST[I#]
                          BREAK
                       .
                    .
                 .
                 CALCALGAS
                 EXECUTE OPCIJA#
                    ADD(ALGAS)
                    I#=RIUPDATE:ALGAS()
                 .
                 ALP:IZMAKSAT+=ALG:IZMAKSAT
                 ALP:PARSKAITIT+= ALG:PARSKAITIT
                 ALP:AprIIN  +=SUM(5)
              .
           .
           ALP:STATUSS='Pilns algu aprçíins : '&menesisunG
           ALP:STAT=2
           ALP:ACC_KODS=ACC_KODS
           ALP:ACC_datums=today()
           IF RIUPDATE:ALGPA()
              KLUDA(24,'ALGPA')
           .
           WriteZurnals(1,0,'ALGAS:BÛVÇJU SARAKSTU'&CHR(9)&CHR(9)&FORMAT(ALP:YYYYMM,@D014.)&|
           CHR(9)&ALP:ACC_KODS&CHR(9)&FORMAT(ALP:ACC_datums,@D06.))
        
        OF '4' !************************ PARBUVÇ "VISU", SAGLABÂJOT IEVADÎTOS DATUS *******************
        
           ALP:IZMAKSAT=0
           ALP:PARSKAITIT=0
           ALP:AprIIN=0
           LOOP
              NEXT(KADRI)
              IF ERROR() THEN BREAK.
              IF KAD:DARBA_GR>DATE(MONTH(ALP:YYYYMM)+1,1,YEAR(ALP:YYYYMM))-1 | !NAV BIJIS PIEÒEMTS
              OR (KAD:D_GR_END AND KAD:D_GR_END<ALP:YYYYMM) THEN CYCLE.        !IR JAU ATLAISTS
              IF KAD:STATUSS='7' THEN CYCLE.                                   !ARHÎVS
              ?Progress:UserString{Prop:Text}=CLIP(KAD:VAR)&' '&KAD:UZV
              DO SHOWNextRecord
              CLEAR(ALG:RECORD)
              GET(ALGAS,0)
              ALG:YYYYMM  = ALP:YYYYMM
              ALG:ID    = KAD:ID
              GET(ALGAS,alg:ID_KEY)
              IF ERROR()
                 OPCIJA#=1
              ELSIF ALP:STAT=1  ! AVANSS
                 OPCIJA#=2
              ELSE
                 OPCIJA#=3      ! JÂPÂRRÇÍINA PÇC NOKL & PAPILDUS DATIEM
              .
              DO FILLDATI
              CALCALGAS
              EXECUTE OPCIJA#
                 ADD(ALGAS)
                 PUT(ALGAS)
                 PUT(ALGAS)
              .
              ALP:IZMAKSAT+=ALG:IZMAKSAT
              ALP:PARSKAITIT+=ALG:PARSKAITIT
              ALP:AprIIN  +=SUM(5)
           .
           ALP:STATUSS='Pilns algu aprçíins : '&menesisunG
           ALP:STAT=2
           ALP:ACC_KODS=ACC_KODS
           ALP:ACC_datums=today()
           IF RIUPDATE:ALGPA()
              KLUDA(24,'ALGPA')
           .
           WriteZurnals(1,0,'ALGAS:PÂRBÛVÇJU SARAKSTU,SAGLABÂJOT IEVADÎTOS DATUS'&CHR(9)&FORMAT(ALP:YYYYMM,@D014.)&|
           CHR(9)&ALP:ACC_KODS&CHR(9)&FORMAT(ALP:ACC_datums,@D06.))

        OF '5' !****************** UZBÛVÇ DIVIDENDES, KAM KADROS DEFINÇTAS DAÏAS*****************

           OPEN(DIVWINDOW)
           DISPLAY
           ACCEPT
              CASE FIELD()
              OF ?ALP:YYYYMM
                 IF EVENT() = EVENT:Accepted
                    IF ALP:YYYYMM < DATE(1,1,2010) OR DAY(ALP:YYYYMM)=1
                       KLUDA(0,'Neatïauts datums',1)
                       SELECT(?ALP:YYYYMM)
                    .
                 .
              OF ?ALP:PARSKAITIT
                 IF EVENT() = EVENT:Accepted
                    IF ~ALP:PARSKAITIT
                       BEEP
                       SELECT(?ALP:PARSKAITIT)
                    .
                 .
              OF ?OkButtonDIV
                 IF EVENT() = EVENT:Accepted
                    LocalResponse = RequestCompleted
                    BREAK
                 .
              .
           .
           CLOSE(DIVWINDOW)
           ALP:IZMAKSAT=0
!           ALP:PARSKAITIT=0
           ALP:AprIIN=0
           LOOP
              NEXT(KADRI)
              IF ERROR() THEN BREAK.
              IF KAD:DARBA_GR>DATE(MONTH(ALP:YYYYMM)+1,1,YEAR(ALP:YYYYMM))-1 | !NAV BIJIS PIEÒEMTS
              OR (KAD:D_GR_END AND KAD:D_GR_END<ALP:YYYYMM) THEN CYCLE.        !IR JAU ATLAISTS
              IF KAD:STATUSS='7' THEN CYCLE.                                   !ARHÎVS
              KAD_KA_DA=DEFORMAT(KAD:V_VAL[35:40],@N6.2)
!              STOP(KAD_KA_DA)
              IF ~KAD_KA_DA THEN CYCLE.
              ?Progress:UserString{Prop:Text}=CLIP(KAD:VAR)&' '&KAD:UZV
        !      STOP(FORMAT(KAD:D_GR_END,@D6)&FORMAT(ALP:YYYYMM,@D6))
              DO SHOWNextRecord
              CLEAR(ALG:RECORD)
              GET(ALGAS,0)
              ALG:YYYYMM  = ALP:YYYYMM
              ALG:ID    = KAD:ID
              GET(ALGAS,alg:ID_KEY)
              IF ERROR()
                 OPCIJA#=1
              ELSE
                 OPCIJA#=2
              .
              ALG:K[1]=879
              ALG:R[1]=ALP:PARSKAITIT/100*KAD_KA_DA
              ALG:I[1]=901
              ALG:N[1]=ALG:R[1]/10 !10% IIN
              ALG:IZMAKSAT=ALG:R[1]-ALG:N[1]
              ALG:IIN_DATUMS=ALP:YYYYMM      !SAMAKSÂTS=APRÇÍINÂTS
              DO FILLDATI
              EXECUTE OPCIJA#
                 ADD(ALGAS)
                 PUT(ALGAS)
              .
              ALP:IZMAKSAT+=ALG:IZMAKSAT
              ALP:AprIIN+=ALG:N[1]
           .
           ALP:STATUSS='Dividenþu aprçíins : '&DAY(ALP:YYYYMM)&'.'&MENVAR(ALP:YYYYMM,2,2)&' '&YEAR(ALP:YYYYMM)&'.g.'
           ALP:STAT=3
           ALP:ACC_KODS=ACC_KODS
           ALP:ACC_datums=today()
           IF RIUPDATE:ALGPA()
              KLUDA(24,'ALGPA')
           .
           WriteZurnals(1,0,'DIVIDENDES:BÛVÇJU SARAKSTU'&CHR(9)&FORMAT(ALP:YYYYMM,@D06.)&|
           CHR(9)&ALP:ACC_KODS&CHR(9)&FORMAT(ALP:ACC_datums,@D06.))
        ELSE
           STOP('BUVET - '&BUVET)
        END
        CLOSE(ProgressWindow)
        
        LocalResponse = RequestCompleted
        BREAK
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        BREAK
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  IF ALGPA::Used = 0
    CheckOpen(ALGPA,1)
  END
  ALGPA::Used += 1
  BIND(ALP:RECORD)
  IF CAL::Used = 0
    CheckOpen(CAL,1)
  END
  CAL::Used += 1
  BIND(CAL:RECORD)
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
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('BuvetAlgas','winlats.INI')
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
    ALGPA::Used -= 1
    IF ALGPA::Used = 0 THEN CLOSE(ALGPA).
    CAL::Used -= 1
    IF CAL::Used = 0 THEN CLOSE(CAL).
    DAIEV::Used -= 1
    IF DAIEV::Used = 0 THEN CLOSE(DAIEV).
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
  END
  IF WindowOpened
    INISaveWindow('BuvetAlgas','winlats.INI')
    CLOSE(window)
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
  IF window{Prop:AcceptAll} THEN EXIT.
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
!-----------------------------------------------------------------------------------------
SAKNOS   ROUTINE
 clear(ALP:record)
 ALP:YYYYMM=S_DAT
 GET(ALGPA,ALP:YYYYMM_KEY)
 IF ERROR() OR (ALP:STAT<3 AND BUVET='5')
    SET(ALP:YYYYMM_KEY,ALP:YYYYMM_KEY)
    NEXT(ALGPA) !IEPRIEKÐÇJAIS MÇNESIS
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
       StandardWarning(Warn:RecordFetchError,'ALGPA')
       DO PROCEDURERETURN
    END
    IF ERRORCODE()
       SAV_MIA      =45
       SAV_MINA     =200
       SAV_MINS     =1.189
       SAV_PR_PAM   =25 !%
       SAV_PR_PAP   =0  !5
       SAV_APGADSUM =70
       SAV_AT_INV1  =108
       SAV_AT_INV2  =108
       SAV_AT_INV3  =84
       SAV_AT_POLR  =108
       SAV_AT_POLRNP=198
    ELSE
       SAV_MIA     =ALP:MIA
       SAV_MINA    =ALP:MINA
       SAV_MINS    =ALP:MINS
       SAV_PR_PAM  =ALP:PR_PAM
       SAV_PR_PAP  =ALP:PR_PAP
       SAV_APGADSUM=ALP:APGADSUM
       SAV_AT_INV1 =ALP:AT_INV1
       SAV_AT_INV2 =ALP:AT_INV2
       SAV_AT_INV3 =ALP:AT_INV3
       SAV_AT_POLR =ALP:AT_POLR
       SAV_AT_POLRNP=ALP:AT_POLRNP
    .
    clear(ALP:Record)
    IF BUVET < 5
       ALP:YYYYMM=S_DAT
    ELSE
       ALP:YYYYMM=S_DAT+1
    .
    ALP:STATUSS='Sâkuma nosacîjumi : '&menesisunG
    ALP:APGADSUM=SAV_APGADSUM
    ALP:MIA     =SAV_MIA
    ALP:MINA    =SAV_MINA
    ALP:MINS    =SAV_MINS
    ALP:PR_PAM  =SAV_PR_PAM
    ALP:PR_PAP  =SAV_PR_PAP
    ALP:AT_INV1 =SAV_AT_INV1
    ALP:AT_INV2 =SAV_AT_INV2
    ALP:AT_INV3 =SAV_AT_INV3
    ALP:AT_POLR = SAV_AT_POLR
    ALP:AT_POLRNP=SAV_AT_POLRNP
    ALP:ACC_KODS=ACC_KODS
    ALP:ACC_datums=today()
    ADD(ALGPA)
    IF ERRORCODE()
       KLUDA(24,'ALGPA')
       DO PROCEDURERETURN
    END
 ELSE
! Sâkuma nosacîjumi vai algu saraksts vai dividendes jau ir uzbûvçtas
 .

!-----------------------------------------------------------------------------------------
FILLDATI   ROUTINE
  ALG:INI    = KAD:INI
  ALG:NODALA = KAD:NODALA
  ALG:OBJ_NR = KAD:OBJ_NR
  ALG:STATUSS= KAD:STATUSS
  IF KAD:AMATS[1:2]='U.'      !UZÒÇMUMA LÎGUMNIEKS
     ALG:BAITS+=1
  .
  ALG:INV_P  = KAD:INV_P
  ALG:APGAD_SK  = KAD:APGAD_SK
  ALG:PR37   = KAD:PR37
  ALG:PR1    = KAD:PR1
  ALG:TERKOD = KAD:TERKOD
  ALG:SOC_V  = KAD:SOC_V
  ALG:ACC_KODS=ACC_kods
  ALG:ACC_DATUMS=today()

!-------------------------------------
SHOWNextRecord ROUTINE
  RecordsProcessed += 1
  RecordsThisCycle += 1
  IF PercentProgress < 100
    PercentProgress = (RecordsProcessed / RecordsToProcess)*100
    IF PercentProgress > 100
      PercentProgress = 100
    END
    IF PercentProgress <> Progress:Thermometer THEN
      Progress:Thermometer = PercentProgress
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END


