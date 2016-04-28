                     MEMBER('winlats.clw')        ! This is a MEMBER module
X   STRING(20)
UpdateNOL_STAT PROCEDURE


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
N_TABLE              QUEUE,PRE()
N:S_GADS             DECIMAL(4)
N:DAUDZUMI1          LONG
N:DAUDZUMI2          LONG
N:DAUDZUMI3          LONG
N:DAUDZUMI4          LONG
N:DAUDZUMI5          LONG
N:DAUDZUMI6          LONG
N:DAUDZUMI7          LONG
N:DAUDZUMI8          LONG
N:DAUDZUMI9          LONG
N:DAUDZUMI10         LONG
N:DAUDZUMI11         LONG
N:DAUDZUMI12         LONG
N:DKOPA              LONG
                     END
N_DKOPA              LONG
RecordFiltered       LONG
DisplayString        STRING(255)
SECTEXT              STRING(8)
Update::Reloop  BYTE
Update::Error   BYTE
History::STAT:Record LIKE(STAT:Record),STATIC
SAV::STAT:Record     LIKE(STAT:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the NOL_STAT File'),AT(,,442,259),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateNOL_STAT'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(2,4,439,233),USE(?CurrentTab)
                         TAB('General'),USE(?Tab:1)
                           PROMPT('&Nomenklatûra:'),AT(8,23,50,10),USE(?Prompt5)
                           STRING(@s21),AT(72,23,88,10),USE(STAT:NOMENKLAT),LEFT
                           PROMPT('&Kataloga Numurs:'),AT(8,40,62,10),USE(?STAT:KATALOGA_NR:Prompt)
                           ENTRY(@s17),AT(72,40,72,10),USE(STAT:KATALOGA_NR),RIGHT
                           PROMPT('No&saukums:'),AT(162,23),USE(?STAT:NOS_S:Prompt)
                           ENTRY(@s16),AT(208,23,72,10),USE(STAT:NOS_S),LEFT
                           OPTION('&Redzamîba'),AT(299,23,135,30),USE(STAT:REDZAMIBA),BOXED
                             RADIO('Aktîva'),AT(302,35),USE(?STAT:REDZAMIBA:Radio1),VALUE('0')
                             RADIO('Arhîvs'),AT(346,35),USE(?STAT:REDZAMIBA:Radio2),VALUE('1')
                             RADIO('Nâkotnes'),AT(388,35),USE(?STAT:REDZAMIBA:Radio3),VALUE('2')
                           END
                           STRING(@s8),AT(251,40),USE(SECTEXT),LEFT
                           BUTTON('At&bildîgais'),AT(147,38,71,14),USE(?Atbildigais)
                           STRING(@n_6),AT(222,40),USE(STAT:ATBILDIGAIS),LEFT
                           LIST,AT(5,57,432,171),USE(?List1),FORMAT('24L|~GADS~C@n4@30R(1)|~Janvâris~C(0)@n-_6b@32R(1)|~Februâris~C(0)@n-_6b@28R(1)|~' &|
   'Marts~C(0)@n-_6b@28R(1)|~Aprîlis~C(0)@n-_6b@28R(1)|~Maijs~C(0)@n-_6b@28R(1)|~Jûn' &|
   'ijs~C(0)@n-_6b@28R(1)|~Jûlijs~C(0)@n-_6b@30R(1)|~Augusts~C(0)@n-_6b@36R(1)|~Sept' &|
   'embris~C(0)@n-_6b@30R(1)|~Oktobris~C(0)@n-_6b@37R(1)|~Novembris~C(0)@n-_6b@36R(1' &|
   ')|~Decembris~C(0)@n-_6b@36R(1)|~Kopâ~C(0)@n-_8b@'),FROM(N_TABLE)
                         END
                       END
                       BUTTON('&OK'),AT(324,241,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(373,241,45,14),USE(?Cancel)
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
  SECTEXT=GETPAROLES(STAT:ATBILDIGAIS,1)
  DO FILLDATI
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
      SELECT(?Prompt5)
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
        History::STAT:Record = STAT:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(NOL_STAT)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?Prompt5)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::STAT:Record <> STAT:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:NOL_STAT(1)
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
              SELECT(?Prompt5)
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
    OF ?Atbildigais
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        Paroles 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           STAT:ATBILDIGAIS=SEC:U_NR
           SECTEXT=SEC:PUBLISH
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
  IF NOL_STAT::Used = 0
    CheckOpen(NOL_STAT,1)
  END
  NOL_STAT::Used += 1
  BIND(STAT:RECORD)
  FilesOpened = True
  RISnap:NOL_STAT
  SAV::STAT:Record = STAT:Record
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
        IF RIDelete:NOL_STAT()
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
  INIRestoreWindow('UpdateNOL_STAT','winlats.INI')
  WinResize.Resize
  ?STAT:NOMENKLAT{PROP:Alrt,255} = 734
  ?STAT:KATALOGA_NR{PROP:Alrt,255} = 734
  ?STAT:NOS_S{PROP:Alrt,255} = 734
  ?STAT:REDZAMIBA{PROP:Alrt,255} = 734
  ?STAT:ATBILDIGAIS{PROP:Alrt,255} = 734
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
    INISaveWindow('UpdateNOL_STAT','winlats.INI')
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
!---------------------------------------------------------------------------------------------------------------
FILLDATI     ROUTINE
          FREE(N_TABLE)
          LOOP G#=1 TO 15         !15 GADI SABÂZTI STATISTIKÂ
             N_DKOPA=0
             LOOP M#= 1 TO 12     !12 MÇNEÐI SABÂZTI STATISTIKÂ
                N_DKOPA+=STAT:DAUDZUMS[M#,G#]
             .
             IF N_DKOPA          !Par ðo gadu vispâr kaut kas ir
                GET(N_TABLE,0)
                N:S_GADS=G#+1995  !PASAULES RADÎÐANA 1996.GADÂ
                GET(N_TABLE,N:S_GADS)
                IF ERROR()
                   N:DAUDZUMI1=STAT:DAUDZUMS[1,G#]
                   N:DAUDZUMI2=STAT:DAUDZUMS[2,G#]
                   N:DAUDZUMI3=STAT:DAUDZUMS[3,G#]
                   N:DAUDZUMI4=STAT:DAUDZUMS[4,G#]
                   N:DAUDZUMI5=STAT:DAUDZUMS[5,G#]
                   N:DAUDZUMI6=STAT:DAUDZUMS[6,G#]
                   N:DAUDZUMI7=STAT:DAUDZUMS[7,G#]
                   N:DAUDZUMI8=STAT:DAUDZUMS[8,G#]
                   N:DAUDZUMI9=STAT:DAUDZUMS[9,G#]
                   N:DAUDZUMI10=STAT:DAUDZUMS[10,G#]
                   N:DAUDZUMI11=STAT:DAUDZUMS[11,G#]
                   N:DAUDZUMI12=STAT:DAUDZUMS[12,G#]
                   N:DKOPA=N_DKOPA   
                   ADD(N_TABLE)
                   SORT(N_TABLE,N:S_GADS)
                ELSE
                   N:DAUDZUMI1+=STAT:DAUDZUMS[1,G#]
                   N:DAUDZUMI2+=STAT:DAUDZUMS[2,G#]
                   N:DAUDZUMI3+=STAT:DAUDZUMS[3,G#]
                   N:DAUDZUMI4+=STAT:DAUDZUMS[4,G#]
                   N:DAUDZUMI5+=STAT:DAUDZUMS[5,G#]
                   N:DAUDZUMI6+=STAT:DAUDZUMS[6,G#]
                   N:DAUDZUMI7+=STAT:DAUDZUMS[7,G#]
                   N:DAUDZUMI8+=STAT:DAUDZUMS[8,G#]
                   N:DAUDZUMI9+=STAT:DAUDZUMS[9,G#]
                   N:DAUDZUMI10+=STAT:DAUDZUMS[10,G#]
                   N:DAUDZUMI11+=STAT:DAUDZUMS[11,G#]
                   N:DAUDZUMI12+=STAT:DAUDZUMS[12,G#]
                   N:DKOPA+=N_DKOPA
                   PUT(N_TABLE)
                .
             .
          .
          SORT(N_TABLE,-N:S_GADS)
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?STAT:NOMENKLAT
      STAT:NOMENKLAT = History::STAT:Record.NOMENKLAT
    OF ?STAT:KATALOGA_NR
      STAT:KATALOGA_NR = History::STAT:Record.KATALOGA_NR
    OF ?STAT:NOS_S
      STAT:NOS_S = History::STAT:Record.NOS_S
    OF ?STAT:REDZAMIBA
      STAT:REDZAMIBA = History::STAT:Record.REDZAMIBA
    OF ?STAT:ATBILDIGAIS
      STAT:ATBILDIGAIS = History::STAT:Record.ATBILDIGAIS
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
  STAT:Record = SAV::STAT:Record
  SAV::STAT:Record = STAT:Record
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

TPSfix PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
OPC                  BYTE,DIM(16)
GL_DB_GADS           DECIMAL(4)
ERR                  BYTE
ERRK                 USHORT
TTAKA                CSTRING(60)
TEXT                 STRING(60)
TEXT1                STRING(60)
NOL_NR_25            STRING(25)
SAV_FILENAME1        LIKE(FILENAME1)
FILENAME_S           LIKE(FILENAME1)
FILENAME_D           LIKE(FILENAME1)

RejectRecord         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
Progress:Thermometer BYTE

P_TABLE           QUEUE,PRE(P)
NMR_KODSPLUS         STRING(12) !11+1
                  .
U_TABLE           QUEUE,PRE(U)
U_NR                 ULONG
                  .
K_TABLE           QUEUE,PRE(K)
KARTE                ULONG
                  .
N_TABLE           QUEUE,PRE(N)
NOMENKLAT            STRING(21)
                  .
D_TABLE           QUEUE,PRE(D)
DOK_SENR             STRING(14)
                  .
E_TABLE           QUEUE,PRE(E)
KP                   STRING(14) !13+1
                  .

DOSFILES    QUEUE,PRE(A)
NAME   STRING(13)
DATE   LONG
TIME   LONG
SIZE   LONG
ATTRIB BYTE
       .
window               WINDOW('Datu bâzes avârijas atjaunoðana'),AT(,,428,330),FONT('MS Sans Serif',9,,FONT:bold),CENTER,GRAY,MAXIMIZE
                       STRING('Datu bâze :'),AT(81,12),USE(?String1:2)
                       STRING(@s60),AT(121,12,260,10),USE(TTAKA)
                       STRING(@s60),AT(104,24,312,10),USE(TEXT),LEFT,FONT(,12,,FONT:bold,CHARSET:ANSI)
                       STRING(@s60),AT(104,36,245,10),USE(TEXT1),LEFT
                       OPTION('Atjaunot &kopçjos failus :'),AT(29,48,390,83),USE(?Option1),BOXED
                       END
                       CHECK('  Sistçmas datus ,Paroles,Nodaïas,Projektus'),AT(38,59,316,10),USE(OPC[1]),DISABLE,VALUE('1','')
                       CHECK('  Partnerus (PAR_K)'),AT(38,69,137,10),USE(OPC[2]),VALUE('1','')
                       CHECK('  Kadrus un saistîtos failus'),AT(38,79),USE(OPC[3]),DISABLE,VALUE('1','')
                       CHECK('  Kontu plânu un saistîtos failus'),AT(38,89),USE(OPC[4],,?opcija_4:2),DISABLE,VALUE('1','')
                       CHECK('  Bankas'),AT(38,99),USE(OPC[5],,?opcija_5:2),DISABLE,VALUE('1','')
                       CHECK('  Valûtas un Valstis'),AT(38,109),USE(OPC[6]),DISABLE,VALUE('1','')
                       CHECK('  Valûtu kursus'),AT(38,119),USE(OPC[7],,?opcija_7:2),DISABLE,VALUE('1','')
                       OPTION('Atjaunot &Bâzes failus'),AT(29,132,390,44),USE(?Option2),BOXED
                       END
                       CHECK('  Tekstu plânu'),AT(38,142),USE(OPC[8],,?opcija_8:2),DISABLE,VALUE('1','')
                       CHECK(' Grâmatvedîbu ( GGxx un GGKxx)'),AT(38,152),USE(OPC[9],,?opcija_9:4),VALUE('1','')
                       CHECK('  Vçsturi un CRM'),AT(38,162),USE(OPC[10]),DISABLE,VALUE('1','')
                       OPTION('Atjaunot &Noliktavas failus '),AT(29,178,391,68),USE(?Option3),BOXED
                       END
                       CHECK('  Nomenklatûras (NOM_K)'),AT(38,190),USE(OPC[11]),VALUE('1','')
                       STRING(@S25),AT(177,228),USE(NOL_NR_25),LEFT
                       CHECK('  Atlaiþu lapas,Sastâvdaïas'),AT(38,200),USE(OPC[12]),VALUE('1','')
                       CHECK('  Statistiku, Cenu vçsturi, Auto, Automarkas'),AT(38,210),USE(OPC[13],,?opcija_13:2),DISABLE,VALUE('1','')
                       STRING('1234567890123456789012345'),AT(177,219),USE(?String6),LEFT,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       CHECK('  Pavadzîmes (PAVADxx un NOLIKxx)'),AT(38,228),USE(OPC[14]  ),VALUE('1','')
                       OPTION('Atjaunot &Algas'),AT(28,250,392,23),USE(?Option4),BOXED
                       END
                       CHECK('   Algu sarakstu,Amatus,DL Kalendâru,Darba apm. un iet. veidus,Atvaïin. un Slila' &|
   'pas'),AT(38,260,376,10),USE(OPC[15],,?opcija_15:2),DISABLE,VALUE('1','')
                       OPTION('Atjaunot &Pamatlîdzekïus'),AT(28,275,393,27),USE(?Option5),BOXED
                       END
                       CHECK('  Pamatlîdzekïu sarakstu, Nolietojumu,Kategorijas'),AT(38,285),USE(OPC[16]),DISABLE,VALUE('1','')
                       BUTTON('Atzîmçt visu'),AT(276,307,58,14),USE(?ButtonAtzimetVisu),DISABLE
                       BUTTON('&OK'),AT(342,307,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(383,307,36,14),USE(?CancelButton)
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
   TTAKA=LONGPATH()
   TEXT='Neviens cits ar WinLatu ðobrîd nedrîkst strâdât...'
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?String1:2)
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
    END
    CASE FIELD()
    OF ?OPC_14  
      CASE EVENT()
      OF EVENT:Accepted
        IF OPC[14]
           SEL_NOL_NR25
           LOOP I#=1 TO 25
              NOL_NR_25[I#]=NOL_NR25[I#]
           .
        ELSE
           NOL_NR_25=''
        .
        DISPLAY
      END
    OF ?ButtonAtzimetVisu
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LOOP I#=1 TO 16
          OPC[I#]=TRUE
        .
        DISPLAY
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           IF ARJ
              IF INSTRING('RAR.',UPPER(ARJ),1)
                 DATE#=DOS_CONT('WL*.RAR',1)
              ELSIF INSTRING('ZIP',UPPER(ARJ),1)
                 DATE#=DOS_CONT('WL*.ZIP',1)
              ELSIF INSTRING('ARJ.',UPPER(ARJ),1)
                 DATE#=DOS_CONT('WL*.ARJ',1)
              ELSE
                 KLUDA(0,'Definçts neatïauts Arhivators '&ARJ)
        !         DO PROCEDURERETURN
              .
              IF ~(TODAY()=DATE#)
                 KLUDA(0,'Pirms avârijas atjaunoðanas jâveic DATU BÂZES arhivçðana...')
                 DO PROCEDURERETURN
              .
           ELSE
              KLUDA(0,'Nav definçta arhivatora izsaukðana C:\WINLATS\WinLatsC.ini')
              DO PROCEDURERETURN
           .
           IF ~OPENANSI('TPSFIXERRORS.TXT')
             KLUDA(0,'Nevar atvçrt failu TPSFIXERRORS.TXT')
           .
        
           F:DBF='E'
           OUTA:LINE=''
           ADD(OUTFILEANSI)
           OUTA:LINE=CLIENT
           ADD(OUTFILEANSI)
           OUTA:LINE='Avârijas atjainoðana DB: '&TTAKA
           ADD(OUTFILEANSI)
        
           SELECT(1)
           SELECT
           !  SECURITY_ATT.nLength=Len(SECURITY_ATT)
           !  SECURITY_ATT.lpSecurityDescriptor=0
           !  SECURITY_ATT.bInheritHandle=1
           !  I#=CreateDirectoryA(FILENAME1,SECURITY_ATT)
           LOOP X#=1 TO 16
              IF OPC[X#]
                 EXECUTE X#
                   BEGIN                        !1
                   .
           !-----------------------------------------
                   BEGIN                        !2
        !              *******PAR_K
                       FAILI#+=1
                       NPK#=0
                       OUTA:LINE='Atjaunoju PAR_K.TPS'
                       ADD(OUTFILEANSI)
                       CLOSE(PAR_K)
                       PARNAME=USERFOLDER&'\PAR_K_X.TPS'
                       TEXT='1.solis. Bûvçju EXAMPLE: '&PARNAME
                       TEXT1=''
                       DISPLAY
                       REMOVE(PAR_K)
                       IF ERROR() AND ~(ERRORCODE()=2) !F~FOUND
                          STOP('REMOVE: '&PARNAME&' '&ERROR())
                       .
                       CHECKOPEN(PAR_K,1) !TUKÐS EXAMPLE FAILS
                       CLOSE(PAR_K)
                       PARNAME='PAR_K.TPS'
                       OPEN(PAR_K,18) !PÂRBAUDAM PAR_K STRUKTÛRU&MONOPOLU
                       IF ERROR()
                          KLUDA(0,'PAR_K: '&ERROR())
                          DO PROCEDURERETURN
                       .
                       CLOSE(PAR_K)
                       TEXT='2.solis. TPSFIX '&PARNAME
                       TEXT1='...TPSFIX turpina darbu, pat, ja (NOT RESPONDING)'
                       DISPLAY
                       RUN('\WINLATS\BIN\TPSFIX.EXE PAR_K.TPS /E:'&USERFOLDER&'\PAR_K_X.TPS /A /H /T:TPSFIXERRORS.TXT',1)
                       IF RUNCODE()
                            KLUDA(120,'\WINLATS\BIN\TPSFIX.EXE ')
                            DO PROCEDURERETURN
                       .
                       OPEN(PAR_K,12h)
                       IF ERRORCODE()
                          KLUDA(1,PARNAME&' atslçgu kontrole pârtraukta')
                       ELSE
        !
        !                  GET(PAR_K,4)
        !                  APPEND(PAR_K)
        !
                          TEXT='3.solis. Bûvçju atslçgas '&PARNAME
                          TEXT1=''
                          DISPLAY
                          LOOP
                             BUILD(PAR_K)
                             IF ERRORCODE()=40
                                KLUDA(0,'Dubultas atslçgas: '&PARNAME) !40-DUPKEY
                                SET(PAR:NR_KEY)
                                PREVIOUS(PAR_K)
                                LAST_U_NR#=PAR:U_NR
                                SET(PAR_K)
                                LOOP
                                   NEXT(PAR_K)
                                   IF ERROR() then BREAK.
                                   NPK#+=1
                                   NPKK#+=1
                                   UPDATE#=FALSE
                                   IF ~PAR:NMR_KODS AND PAR:NMR_PLUS
                                      PAR:NMR_PLUS=''
                                      UPDATE#=TRUE
                                   .
                                   TEXT1='Pârbaudu '&NPK#&': '&PAR:NOS_S
                                   DISPLAY(?text1)
                                   IF PAR:NMR_KODS  !NMR
                                      P:NMR_KODSPLUS=PAR:NMR_KODS&PAR:NMR_PLUS
                                      GET(P_TABLE,P:NMR_KODSPLUS)
                                      IF ~ERROR()
                                         DUP#+=1
                                         LOOP I#= 1 TO 9
                                            P:NMR_KODSPLUS[12]=I# 
                                            GET(P_TABLE,P:NMR_KODSPLUS)
                                            IF ERROR()
                                               PAR:NMR_PLUS=I#
                                               IF ~DUPLICATE(PAR:NMR_KEY)
                                                  BREAK
                                               .
                                            .
                                         .
                                         OUTA:LINE=CLIP(NPK#)&'.DUPLICATE:NMR '&PAR:NOS_S&CHR(9)&|
                                         'saglabâju kâ'&CHR(9)&PAR:NMR_KODS&' '&CHR(9)&PAR:NMR_PLUS
                                         ADD(OUTFILEANSI)
                                         UPDATE#=TRUE
                                      .
                                      ADD(P_TABLE,P:NMR_KODSPLUS)
                                      IF ERROR() THEN STOP('ADD P_TABLE '&ERROR()).
                                   .
                                   U:U_NR=PAR:U_NR  !U_NR
                                   GET(U_TABLE,U:U_NR)
                                   IF ~ERROR()
                                      DUP#+=1
                                      LOOP I#= LAST_U_NR#+1 TO LAST_U_NR#+100
                                         U:U_NR=I# 
                                         GET(U_TABLE,U:U_NR)
                                         IF ERROR()
                                            PAR:U_NR=I#
                                            IF ~DUPLICATE(PAR:NR_KEY)
                                               BREAK
                                            .
                                         .
                                      .
                                      OUTA:LINE=CLIP(NPK#)&'.DUPLICATE:U_NR '&PAR:NOS_S&CHR(9)&|
                                      'saglabâju kâ'&CHR(9)&PAR:U_NR
                                      ADD(OUTFILEANSI)
                                      UPDATE#=TRUE
                                   .
                                   ADD(U_TABLE,U:U_NR)
                                   IF ERROR() THEN STOP('ADD U_TABLE '&ERROR()).
                                   IF PAR:KARTE     !KARTE
                                      K:KARTE=PAR:KARTE
                                      GET(K_TABLE,K:KARTE)
                                      IF ~ERROR()
                                         DUP#+=1
                                         K:KARTE=0
                                         OUTA:LINE=CLIP(NPK#)&'.DUPLICATE:KARTE '&PAR:NOS_S&CHR(9)&CLIP(PAR:KARTE)&CHR(9)&|
                                         'nullçju'
                                         ADD(OUTFILEANSI)
                                         PAR:KARTE=0
                                         UPDATE#=TRUE
                                      ELSE
                                         ADD(K_TABLE,K:KARTE)
                                         IF ERROR() THEN STOP('ADD K_TABLE '&ERROR()).
                                      .
                                   .
                                   IF UPDATE#=TRUE
                                      IF RIUPDATE:PAR_K()
                                         KLUDA(24,PARNAME)
                                         OUTA:LINE='KÏÛDA SAGLABÂJOT '&PAR:NOS_S
                                         ADD(OUTFILEANSI)
                                      .
                                   .
                                .
                                FREE(P_TABLE)
                                FREE(U_TABLE)
                                FREE(K_TABLE)
                             ELSE
                                BREAK
                             .
                          .
                       .
                       CLOSE(PAR_K)
        
        !              *******Atzîmes,Fileâles
                       TEXT1=''
        
                   .
           !-----------------------------------------
                   BEGIN                        !3
                       FAILI#+=1
                   .
                   BEGIN                        !4
                       FAILI#+=1
                   .
                   BEGIN                        !5
                       FAILI#+=1
                   .
                   BEGIN                        !6
                       FAILI#+=1
                   .
                   BEGIN                        !7
                       FAILI#+=1
                   .
                   BEGIN                        !8
                       FAILI#+=1
                   .
           !-----------------------------------------
                   BEGIN                        !9  GG,GGK
        !             *******GG
                      CLOSE(GG)
                      GGNAME=USERFOLDER&'\GG_X.TPS'
                      TEXT='1.solis. Bûvçju EXAMPLE: '&GGNAME
                      TEXT1=''
                      DISPLAY
                      REMOVE(GG)
                      IF ERROR() AND ~(ERRORCODE()=2) !F~FOUND
                         STOP('REMOVE: '&GGNAME&' '&ERROR())
                      .
                      CHECKOPEN(GG,1) !TUKÐS EXAMPLE FAILS
                      CLOSE(GG)
                      LOOP N# = 1 TO BASE_SK
                         GGNAME='GG'&FORMAT(N#,@N02)&'.TPS'
                         OPEN(GG,18) !PÂRBAUDAM GG STRUKTÛRU & MONOPOLU
                         IF ERRORCODE()=2 !F~FOUND
                            TEXT =''
                            TEXT1=''
                            DISPLAY
                            KLUDA(120,GGNAME)
                            CYCLE
                         ELSIF ERROR()
                            KLUDA(0,CLIP(GGNAME)&': '&ERROR())
                            DO PROCEDURERETURN
                         ELSE
                            OUTA:LINE='Atjaunoju '&GGNAME
                            ADD(OUTFILEANSI)
                            FAILI#+=1
                         .
                         CLOSE(GG)
                         TEXT='2.solis. TPSFIX '&GGNAME
                         TEXT1='...TPSFIX turpina darbu, pat, ja (NOT RESPONDING)'
                         DISPLAY
                         RUN('\WINLATS\BIN\TPSFIX.EXE '&GGNAME&' /E:'&USERFOLDER&'\GG_X.TPS /A /H /K /T:TPSFIXERRORS.TXT',1)
                         IF RUNCODE()
                            KLUDA(120,'\WINLATS\BIN\TPSFIX.EXE ')
                            DO PROCEDURERETURN
                         .
                         CLOSE(GG)
                      .
        !             *******GGK
                      CLOSE(GGK)
                      GGKNAME=USERFOLDER&'\GGK_X.TPS'
                      TEXT='1.solis. Bûvçju EXAMPLE: '&GGKNAME
                      TEXT1=''
                      DISPLAY
                      REMOVE(GGK)
                      IF ERROR() AND ~(ERRORCODE()=2) !F~FOUND
                         STOP('REMOVE: '&GGKNAME&' '&ERROR())
                      .
                      CHECKOPEN(GGK,1) !TUKÐS EXAMPLE FAILS
                      CLOSE(GGK)
                      LOOP N# = 1 TO BASE_SK
                         GGKNAME='GGK'&FORMAT(N#,@N02)&'.TPS'
                         OPEN(GGK,18) !PÂRBAUDAM GGK STRUKTÛRU & MONOPOLU
                         IF ERRORCODE()=2 !F~FOUND
                            TEXT =''
                            TEXT1=''
                            DISPLAY
                            KLUDA(120,GGKNAME)
                            CYCLE
                         ELSIF ERROR()
                            KLUDA(0,CLIP(GGKNAME)&': '&ERROR())
                            DO PROCEDURERETURN
                         ELSE
                            OUTA:LINE='Atjaunoju '&GGKNAME
                            ADD(OUTFILEANSI)
                            FAILI#+=1
                         .
                         CLOSE(GGK)
                         TEXT='2.solis. TPSFIX '&GGKNAME
                         TEXT1='...TPSFIX turpina darbu, pat, ja (NOT RESPONDING)'
                         DISPLAY
                         RUN('\WINLATS\BIN\TPSFIX.EXE '&GGKNAME&' /E:'&USERFOLDER&'\GGK_X.TPS /A /H /K /T:TPSFIXERRORS.TXT',1)
                         IF RUNCODE()
                            KLUDA(120,'\WINLATS\BIN\TPSFIX.EXE ')
                            DO PROCEDURERETURN
                         .
                         CLOSE(GGK)
                      .
                   .
           !-----------------------------------------
                   BEGIN                         !10
                      FAILI#+=1
                   .
           !-----------------------------------------
                   BEGIN                        !11
        !              *******NOM_K
                       FAILI#+=1
                       NPK#=0
                       OUTA:LINE='Atjaunoju NOM_K.TPS'
                       ADD(OUTFILEANSI)
                       CLOSE(NOM_K)
                       NOMNAME=USERFOLDER&'\NOM_K_X.TPS'
                       TEXT='1.solis. Bûvçju EXAMPLE: '&NOMNAME
                       TEXT1=''
                       DISPLAY
                       REMOVE(NOM_K)
                       IF ERROR() AND ~(ERRORCODE()=2) !F~FOUND
                          STOP('REMOVE: '&NOMNAME&' '&ERROR())
                       .
                       CHECKOPEN(NOM_K,1) !TUKÐS EXAMPLE FAILS
                       CLOSE(NOM_K)
                       NOMNAME='NOM_K.TPS'
                       OPEN(NOM_K,18) !PÂRBAUDAM NOM_K STRUKTÛRU & MONOPOLU
                       IF ERROR()
                          KLUDA(0,'NOM_K: '&ERROR())
                          DO PROCEDURERETURN
                       .
                       CLOSE(NOM_K)
                       TEXT='2.solis. TPSFIX'
                       TEXT1='...TPSFIX turpina darbu, pat, ja (NOT RESPONDING)'
                       DISPLAY
                       RUN('\WINLATS\BIN\TPSFIX.EXE NOM_K.TPS /E:'&USERFOLDER&'\NOM_K_X.TPS /A /H /T:TPSFIXERRORS.TXT',1)
                       IF RUNCODE()
                            KLUDA(120,'\WINLATS\BIN\TPSFIX.EXE ')
                            DO PROCEDURERETURN
                       .
                       OPEN(nom_k,12h)
                       IF ERRORCODE()
                          KLUDA(1,NOMNAME&' atslçgu bûvçðana pârtraukta')
                       ELSE
                          TEXT='3.solis. Bûvçju atslçgas '&NOMNAME
                          TEXT1=''
                          DISPLAY
                          LOOP
                             BUILD(NOM_K)
                             IF ERRORCODE()=40
                                KLUDA(0,'Dubultas atslçgas: '&NOMNAME) !40-DUPKEY
                                SET(NOM_K)
                                NPK#=0
                                LOOP
                                   NEXT(NOM_K)
                                   IF ERROR() then BREAK.
                                   NPK#+=1
                                   NPKK#+=1
                                   UPDATE#=FALSE
                                   TEXT1='Pârbaudu '&NPK#&': '&NOM:nomenklat&' '&NOM:NOS_P
                                   DISPLAY(?text1)
                                   N:NOMENKLAT=INIGEN(NOM:NOMENKLAT,21,1)
                                   N:NOMENKLAT=UPPER(N:NOMENKLAT)
                                   IF ~(N:NOMENKLAT=NOM:NOMENKLAT)
                                      OUTA:LINE=CLIP(NPK#)&'.INVALID:NOMENKLAT '&NOM:NOMENKLAT&CHR(9)&|
                                      'saglabâju kâ'&CHR(9)&N:NOMENKLAT
                                      ADD(OUTFILEANSI)
                                      UPDATE#=TRUE
                                      NOM:NOMENKLAT=N:NOMENKLAT
                                   .
                                   GET(N_TABLE,N:NOMENKLAT)
                                   IF ~ERROR() !TÂDA ATSLÇGA JAU IR
                                      LOOP I#= 1 TO 5
                                         N:NOMENKLAT[I#]='?'
                                         GET(N_TABLE,N:NOMENKLAT)
                                         IF ERROR() THEN BREAK.
                                      .
                                      OUTA:LINE=CLIP(NPK#)&'.DUPLICATE:NOMENKLAT '&NOM:NOMENKLAT&CHR(9)&|
                                      'saglabâju kâ'&CHR(9)&N:NOMENKLAT
                                      ADD(OUTFILEANSI)
                                      UPDATE#=TRUE
                                      NOM:NOMENKLAT=N:NOMENKLAT
                                   .
                                   ADD(N_TABLE,N:NOMENKLAT)
                                   IF ERROR() THEN STOP('ADD N_TABLE '&ERROR()).
        !                           SORT(N_TABLE,N:NOMENKLAT) !PÇKÐÒI KÏÛST BAIGI LÇNS...
                                   IF NOM:KODS
                                      E:KP=NOM:KODS&NOM:KODS_PLUS
                                      GET(E_TABLE,E:KP)
                                      IF ~ERROR() !TÂDA ATSLÇGA JAU IR
                                         LOOP I#= 1 TO 9
                                            E:KP=NOM:KODS&I#
                                            GET(E_TABLE,E:KP)
                                            IF ERROR()
                                               NOM:KODS_PLUS=I#
                                               IF ~DUPLICATE(NOM:KOD_KEY)
                                                  BREAK
                                               .
                                            .
                                         .
                                         OUTA:LINE=CLIP(NPK#)&'.DUPLICATE:KODS '&NOM:KODS&CHR(9)&|
                                         'saglabâju kâ+ '&CHR(9)&NOM:KODS_PLUS
                                         ADD(OUTFILEANSI)
                                         UPDATE#=TRUE
                                      .
                                      ADD(E_TABLE,E:KP)
                                      IF ERROR() THEN STOP('ADD E_TABLE '&ERROR()).
           !                           SORT(N_TABLE,N:NOMENKLAT) !PÇKÐÒI KÏÛST BAIGI LÇNS...
                                   ELSIF NOM:KODS_PLUS
                                      NOM:KODS_PLUS=''
                                      UPDATE#=TRUE
                                   .
                                   IF UPDATE#=TRUE
                                      IF RIUPDATE:NOM_K()
                                         KLUDA(24,NOMNAME)
                                      .
                                      DUP#+=1
                                   .
                                .
                                FREE(N_TABLE)
                                FREE(E_TABLE)
                             ELSE
                                BREAK
                             .
                          .
                       .
                       CLOSE(NOM_K)
        
        !              *******Grupas,Apakðgrupas,Sastâvdaïas,Atlikumus,Plauktus,Meklçjumu vçsturi,Mçrvienibas
                       TEXT1=''
        !              FILENAME_S='CAR.BMP'
        !              FILENAME_D=FILENAME1&'\CAR.BMP'
        !              IF ~CopyFileA(FILENAME_S,FILENAME_D,0)
        !!                 KLUDA(3,FILENAME_S&' uz '&FILENAME_D)  CAR.BMP VAR ARÎ NEBÛT...
        !              .
        
                   .
           !-----------------------------------------
                   BEGIN                        !12  ATLAIDES,KOMPLEKT
                       FAILI#+=1
                       TEXT='1.solis. Bûvçju EXAMPLE: '&USERFOLDER&'\KOMPLEKT_X.TPS'
                       TEXT1=''
                       DISPLAY
                       RENAME(KOMPLEKT,'KOMPLEKT.BAK') !SASTÂVDAÏAS
                       CHECKOPEN(KOMPLEKT,1)
                       CLOSE(KOMPLEKT)
                       RENAME(KOMPLEKT,USERFOLDER&'\KOMPLEKT_X.TPS')
                       RENAME('KOMPLEKT.BAK','KOMPLEKT.TPS')
                       OPEN(KOMPLEKT,18) !PÂRBAUDAM KOMPLEKT STRUKTÛRU & MONOPOLU
                       IF ERROR()
                          KLUDA(0,'KOMPLEKT: '&ERROR())
                          DO PROCEDURERETURN
                       .
                       CLOSE(KOMPLEKT)
                       TEXT='2.solis. TPSFIX'
                       TEXT1='...TPSFIX turpina darbu, pat, ja (NOT RESPONDING)'
                       DISPLAY
                       RUN('\WINLATS\BIN\TPSFIX.EXE KOMPLEKT.TPS /E:'&USERFOLDER&'\KOMPLEKT_X.TPS /A /H /K /T:TPSFIXERRORS.TXT',1)
                       IF RUNCODE()
                            KLUDA(120,'\WINLATS\BIN\TPSFIX.EXE ')
                            DO PROCEDURERETURN
                       .
                       FAILI#+=1
                       TEXT='1.solis. Bûvçju EXAMPLE: '&USERFOLDER&'\ATL_K_X.TPS'
                       TEXT1=''
                       DISPLAY
                       RENAME(ATL_K,'ATL_K.BAK') !ATLAIÞU LAPAS
                       CHECKOPEN(ATL_K,1)
                       CLOSE(ATL_K)
                       RENAME(ATL_K,USERFOLDER&'\ATL_K_X.TPS')
                       RENAME('ATL_K.BAK','ATL_K.TPS')
                       OPEN(ATL_K,18) !PÂRBAUDAM KOMPLEKT STRUKTÛRU & MONOPOLU
                       IF ERROR()
                          KLUDA(0,'ATL_K: '&ERROR())
                          DO PROCEDURERETURN
                       .
                       CLOSE(ATL_K)
                       TEXT='2.solis. TPSFIX'
                       TEXT1='...TPSFIX turpina darbu, pat, ja (NOT RESPONDING)'
                       DISPLAY
                       RUN('\WINLATS\BIN\TPSFIX.EXE ATL_K.TPS /E:'&USERFOLDER&'\ATL_K_X.TPS /A /H /K /T:TPSFIXERRORS.TXT',1)
                       IF RUNCODE()
                            KLUDA(120,'\WINLATS\BIN\TPSFIX.EXE ')
                            DO PROCEDURERETURN
                       .
                       FAILI#+=1
                       TEXT='1.solis. Bûvçju EXAMPLE: '&USERFOLDER&'\ATL_S_X.TPS'
                       TEXT1=''
                       DISPLAY
                       RENAME(ATL_S,'ATL_S.BAK') !ATLAIÞU LAPAS
                       CHECKOPEN(ATL_S,1)
                       CLOSE(ATL_S)
                       RENAME(ATL_S,USERFOLDER&'\ATL_S_X.TPS')
                       RENAME('ATL_S.BAK','ATL_S.TPS')
                       TEXT='2.solis. TPSFIX'
                       TEXT1='...TPSFIX turpina darbu, pat, ja (NOT RESPONDING)'
                       DISPLAY
                       RUN('\WINLATS\BIN\TPSFIX.EXE ATL_S.TPS /E:'&USERFOLDER&'\ATL_S_X.TPS /A /H /K /T:TPSFIXERRORS.TXT',1)
                       IF RUNCODE()
                            KLUDA(120,'\WINLATS\BIN\TPSFIX.EXE ')
                            DO PROCEDURERETURN
                       .
                   .
           !-----------------------------------------
                   BEGIN                        !13
                       FAILI#+=1
        !              LOOP N# = 1 TO NOL_SK
        !                 ATEXNAME=FILENAME1&'\ATEX'&FORMAT(N#,@N02)
        !                 COPY(AUTOTEX,FILENAME1)
        !              .
        !              COPY(TEK_SER,FILENAME1)
        !              TEXNAME='TEX_NOL'
        !              COPY(TEKSTI,FILENAME1)
                   .
           !-----------------------------------------
                   BEGIN                          !14 PAVAD,NOLIK
        !             *******PAVAD
                      CLOSE(PAVAD)
                      PAVADNAME=USERFOLDER&'\PAVAD_X.TPS'
                      TEXT='1.solis. Bûvçju EXAMPLE: '&PAVADNAME
                      TEXT1=''
                      DISPLAY
                      REMOVE(PAVAD)
                      IF ERROR() AND ~(ERRORCODE()=2) !F~FOUND
                         STOP('REMOVE: '&PAVADNAME&' '&ERROR())
                      .
                      CHECKOPEN(PAVAD,1) !TUKÐS EXAMPLE FAILS
                      CLOSE(PAVAD)
                      LOOP N# = 1 TO NOL_SK
                         IF ~NOL_NR25[N#] THEN CYCLE.
                         NPK#=0
                         PAVADNAME='PAVAD'&FORMAT(N#,@N02)&'.TPS'
                         OPEN(PAVAD,18) !PÂRBAUDAM PAVAD STRUKTÛRU & MONOPOLU
                         IF ERRORCODE()=2 !F~FOUND
                            TEXT =''
                            TEXT1=''
                            DISPLAY
                            KLUDA(120,PAVADNAME)
                            CYCLE
                         ELSIF ERROR()
                            KLUDA(0,CLIP(PAVADNAME)&': '&ERROR())
                            DO PROCEDURERETURN
                         ELSE
                            OUTA:LINE='Atjaunoju '&PAVADNAME
                            ADD(OUTFILEANSI)
                            FAILI#+=1
                         .
                         CLOSE(PAVAD)
                         TEXT='2.solis. TPSFIX '&PAVADNAME
                         TEXT1='...TPSFIX turpina darbu, pat, ja (NOT RESPONDING)'
                         DISPLAY
                         RUN('\WINLATS\BIN\TPSFIX.EXE '&PAVADNAME&' /E:'&USERFOLDER&'\PAVAD_X.TPS /A /H /T:TPSFIXERRORS.TXT',1)
                         IF RUNCODE()
                            KLUDA(120,'\WINLATS\BIN\TPSFIX.EXE ')
                            DO PROCEDURERETURN
                         .
                         OPEN(PAVAD,12h)
                         IF ERRORCODE()
                            KLUDA(1,PAVADNAME&' atslçgu bûvçðana pârtraukta')
                         ELSE
                            TEXT='3.solis. Bûvçju atslçgas '&PAVADNAME
                            TEXT1=''
                            DISPLAY
                            LOOP
                               BUILD(PAVAD)
                               IF ERRORCODE()=40
                                  KLUDA(0,'Dubultas atslçgas: '&PAVADNAME) !40-DUPKEY
                                  DUP#=0
                                  NPK#=0
                                  SET(PAVAD)
                                  LOOP
                                     NEXT(PAVAD)
                                     IF ERROR() then BREAK.
                                     NPK#+=1
                                     NPKK#+=1
                                     IF ~PAV:DOK_SENR THEN CYCLE.
                                     TEXT1='Pârbaudu '&NPK#&': '&PAV:DOK_SENR
                                     DISPLAY(?text1)
                                     D:DOK_SENR=PAV:DOK_SENR
                                     GET(D_TABLE,D:DOK_SENR)
                                     IF ~ERROR()
                                        DUP#+=1
                                        LOOP I#= 1 TO 5
                                           D:DOK_SENR[I#]='?'
                                           GET(D_TABLE,D:DOK_SENR)
                                           IF ERROR() THEN BREAK.
                                        .
                                        KLUDA(0,CLIP(DUP#)&'.DUPLICATE: '&CLIP(PAV:DOK_SENR)&' saglabâju kâ '&D:DOK_SENR)
                                        PAV:DOK_SENR=D:DOK_SENR
                                        IF RIUPDATE:PAVAD()
                                           KLUDA(24,PAVADNAME)
                                        .
                                     .
                                     ADD(D_TABLE,D:DOK_SENR)
                                     IF ERROR() THEN STOP('ADD D_TABLE '&ERROR()).
                                  .
                                  FREE(D_TABLE)
                               ELSE
                                  BREAK
                               .
                            .
                         .
                         CLOSE(PAVAD)
                      .
        !             *******NOLIK
                      CLOSE(NOLIK)
                      NOLIKNAME=USERFOLDER&'\NOLIK_X.TPS'
                      TEXT='1.solis. Bûvçju EXAMPLE: '&NOLIKNAME
                      TEXT1=''
                      DISPLAY
                      REMOVE(NOLIK)
                      IF ERROR() AND ~(ERRORCODE()=2) !F~FOUND
                         STOP('REMOVE: '&NOLIKNAME&' '&ERROR())
                      .
                      CHECKOPEN(NOLIK,1) !TUKÐS EXAMPLE FAILS
                      CLOSE(NOLIK)
                      LOOP N# = 1 TO NOL_SK
                         IF ~NOL_NR25[N#] THEN CYCLE.
                         NOLIKNAME='NOLIK'&FORMAT(N#,@N02)&'.TPS'
                         OPEN(NOLIK,18) !PÂRBAUDAM NOLIK STRUKTÛRU & MONOPOLU
                         IF ERRORCODE()=2 !F~FOUND
                            TEXT =''
                            TEXT1=''
                            DISPLAY
                            KLUDA(120,NOLIKNAME)
                            CYCLE
                         ELSIF ERROR()
                            KLUDA(0,CLIP(NOLIKNAME)&': '&ERROR())
                            DO PROCEDURERETURN
                         ELSE
                            OUTA:LINE='Atjaunoju '&NOLIKNAME
                            ADD(OUTFILEANSI)
                            FAILI#+=1
                         .
                         CLOSE(NOLIK)
                         TEXT='2.solis. TPSFIX '&NOLIKNAME
                         TEXT1='...TPSFIX turpina darbu, pat, ja (NOT RESPONDING)'
                         DISPLAY
                         RUN('\WINLATS\BIN\TPSFIX.EXE '&NOLIKNAME&' /E:'&USERFOLDER&'\NOLIK_X.TPS /A /H /K /T:TPSFIXERRORS.TXT',1)
                         IF RUNCODE()
                            KLUDA(120,'\WINLATS\BIN\TPSFIX.EXE ')
                            DO PROCEDURERETURN
                         .
                         CLOSE(NOLIK)
                      .
                   .
           !-----------------------------------------
                   BEGIN                        !15 ALGAS
                       FAILI#+=1
                   .
           !-----------------------------------------
                   BEGIN                        !16 P/L
                       FAILI#+=1
                   .
                 .
              .
           .
           IF FAILI#
              IF NPKK# !TIKA ANALIZÇTAS DUP-ATSLÇGAS
                 KLUDA(0,'Atjaunoti '&FAILI#&' faili, papildus analizçti '&NPKK#&' raksti, atrastas '&DUP#&' kïûdas',,1)
                 IF DUP# !TIKA ATRASTI DUP RAKSTI
                    ANSIJOB
                 .
              ELSE
                 KLUDA(0,'Atjaunoti '&FAILI#&' faili, dubultas atslçgas netika konstatçtas',,1)
              .
           .
           CLOSE(OUTFILEANSI)
           ANSIFILENAME=''
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
  IF GLOBAL::Used = 0
    CheckOpen(GLOBAL,1)
  END
  GLOBAL::Used += 1
  BIND(GL:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('TPSfix','winlats.INI')
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
    GLOBAL::Used -= 1
    IF GLOBAL::Used = 0 THEN CLOSE(GLOBAL).
  END
  IF WindowOpened
    INISaveWindow('TPSfix','winlats.INI')
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
SelftestNoliekK      PROCEDURE                    ! Declare Procedure
D_TABLE      QUEUE,PRE(D)
KEY          STRING(21)      !2+5+14
NOLIKTAVA    BYTE
MERKIS       BYTE
PAZIME       STRING(1)
DOK_SENR     STRING(14)
DATUMS       LONG
DAUDZUMS     DECIMAL(12,3)
SUMMA        DECIMAL(12,2)
CRC          REAL
STATUSS      BYTE
             .
K_TABLE      QUEUE,PRE(K)
KEY          STRING(21)      !2+5+14
NOLIKTAVA    BYTE
MERKIS       BYTE
PAZIME       STRING(1)
DOK_SENR     STRING(14)
DATUMS       LONG
DAUDZUMS     DECIMAL(12,3)
SUMMA        DECIMAL(12,2)
CRC          REAL
STATUSS      BYTE
             .
CRC          REAL
STATUSS      BYTE
SAV_NR       BYTE
NPK          ULONG

KOMENT               STRING(90)
DAT                  DATE
LAI                  TIME

!----------------------------------------
LocalRequest         LONG
LocalResponse        LONG
rakstsggk            byte
FilesOpened          LONG
WindowOpened         LONG
RecordsToProcess     LONG
RecordsLeft          LONG,DIM(25)
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
!----------------------------------------
report REPORT,AT(200,105,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
header DETAIL,AT(,,,948)
         STRING(@s45),AT(1156,135,4552,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('"WinLats":  paðtests  -  Noliktavu iekðçjâs kustîbas kontrole'),AT(1250,573),USE(?String2), |
             LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,885,7760,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         STRING(@s100),AT(302,21,6615,156),USE(KOMENT),LEFT,FONT(,8,,,CHARSET:BALTIC)
       END
footer DETAIL,AT(,,,250),USE(?unnamed)
         LINE,AT(104,52,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@t4),AT(7260,83),USE(lai),FONT(,7,,,CHARSET:ANSI)
         STRING('Sastâdîja :'),AT(135,83),USE(?String5),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(635,83),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6625,83),USE(dat),FONT(,7,,,CHARSET:ANSI)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,145,63),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,114,10),USE(?Progress:UserString),CENTER
       STRING(@N_5),AT(118,3),USE(NPK),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Apturçt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  dat=today()
  lai=clock()
  FilesOpened = True
  RecordsToProcess=0
  LOOP T#=1 TO nol_sk
     CLOSE(NOLIK)
     NOLIKNAME='NOLIK'&FORMAT(T#,@N02)
     CHECKOpen(NOLIK,1)
     RecordsToProcess += RECORDS(NOLIK)
     RecordsLeft[T#] = RecordsToProcess
!     STOP(RecordsLeft[T#])
  .
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Selftest (Paðtests)'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  DISPLAY()
  OPEN(report)
  report{Prop:Preview} = PrintPreviewImage
  PRINT(rpt:header)
  LOOP T#=1 TO nol_sk
     NPK=0
     ?Progress:UserString{Prop:Text}=CLIP(T#)&'. noliktava'
     DISPLAY()
     CLOSE(PAVAD)
     PAVADNAME='PAVAD'&FORMAT(T#,@N02)
     CHECKOpen(PAVAD,1)
     CLOSE(NOLIK)
     NOLIKNAME='NOLIK'&FORMAT(T#,@N02)
     CHECKOpen(NOLIK,1)
     CLEAR(NOL:RECORD)
     NOL:PAR_NR=1
     SET(NOL:PAR_KEY,NOL:PAR_KEY)
     LOOP
        NEXT(NOLIK)
        NPK+=1
        DISPLAY(?NPK)
        IF ERROR() OR NOL:PAR_NR>NOL_SK THEN BREAK.
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
        G#=GETPAVADZ(NOL:U_NR)
        CRC=0
        LOOP I#= 1 TO 21
           CRC+=VAL(NOL:NOMENKLAT[I#])
        .
        IF NOL:D_K='D'
           GET(D_TABLE,0)
           D:KEY=FORMAT(T#,@N02)&NOL:DATUMS&LEFT(PAV:DOK_SENR)
           GET(D_TABLE,D:KEY)
           IF ERROR()
              D:NOLIKTAVA=T#
              D:MERKIS =NOL:PAR_NR
              D:DOK_SENR=LEFT(PAV:DOK_SENR)
              D:DATUMS =NOL:DATUMS
              D:DAUDZUMS=NOL:DAUDZUMS
              D:SUMMA=CALCSUM(16,2)
              D:CRC=CRC
              D:STATUSS=0
              ADD(D_TABLE)
              IF ERROR() THEN STOP('ADD D-TABLE'&ERROR()).
              SORT(D_TABLE,D:KEY)
           ELSE
              D:DAUDZUMS+=NOL:DAUDZUMS
              D:SUMMA+=CALCSUM(16,2)
              D:CRC+=CRC
              PUT(D_TABLE)
              IF ERROR() THEN STOP('PUT D-TABLE'&ERROR()).
           .
        ELSIF NOL:D_K='K'
           GET(K_TABLE,0)
           K:KEY=FORMAT(T#,@N02)&NOL:DATUMS&LEFT(PAV:DOK_SENR)
           GET(K_TABLE,K:KEY)
           IF ERROR()
              K:NOLIKTAVA=T#
              K:MERKIS =NOL:PAR_NR
              K:DOK_SENR=LEFT(PAV:DOK_SENR)
              K:DATUMS =NOL:DATUMS
              K:DAUDZUMS=NOL:DAUDZUMS
              K:SUMMA=CALCSUM(16,2)
              K:CRC=CRC
              K:STATUSS=0
              ADD(K_TABLE)
              IF ERROR() THEN STOP('ADD K-TABLE'&ERROR()).
              SORT(K_TABLE,K:KEY)
           ELSE
              K:DAUDZUMS+=NOL:DAUDZUMS
              K:SUMMA+=CALCSUM(16,2)
              K:CRC+=CRC
              PUT(K_TABLE)
              IF ERROR() THEN STOP('PUT K-TABLE'&ERROR()).
           .
        .
     .
     RecordsProcessed = RecordsLeft[T#]
  .

!************************************ 2.solis *********************************
  LOOP I#=1 TO RECORDS(K_TABLE)
     GET(K_TABLE,I#)
     GET(D_TABLE,0)
     LOOP J#=1 TO RECORDS(D_TABLE)
        GET(D_TABLE,J#)
        IF K:MERKIS=D:NOLIKTAVA AND K:DOK_SENR=D:DOK_SENR AND K:DATUMS=D:DATUMS
           STATUSS=0
           IF ~(K:DAUDZUMS=D:DAUDZUMS)
              STATUSS+=1
           .
           IF ~(K:SUMMA=D:SUMMA)
              STATUSS+=2
           .
           IF ~INRANGE(K:CRC-D:CRC,-.01,.01)
              STATUSS+=4
           .
           IF ~STATUSS
              D:STATUSS=8
              K:STATUSS=8
           ELSE
              D:STATUSS=STATUSS
              K:STATUSS=STATUSS
           .
           PUT(K_TABLE)
           PUT(D_TABLE)
           BREAK
        .
     .
  .
  KOMENT='******** IZEJOÐÂS P/Z ***************'
  PRINT(RPT:DETAIL)
  LOOP I#=1 TO RECORDS(K_TABLE)
     GET(K_TABLE,I#)
     IF INRANGE(K:STATUSS,0,7)
        EXECUTE K:STATUSS+1
           KOMENT='Nol Nr:'&K:NOLIKTAVA&' '&FORMAT(K:DATUMS,@D06.)&' P/Z: '&CLIP(K:DOK_SENR)&' Nav fiksçta saòemðana Nol Nr='&K:MERKIS
           KOMENT='Nol Nr:'&K:NOLIKTAVA&' '&FORMAT(K:DATUMS,@D06.)&' P/Z: '&CLIP(K:DOK_SENR)&' Nesakrît pârvietotie daudzumi uz Nol Nr='&K:merkis
           KOMENT='Nol Nr:'&K:NOLIKTAVA&' '&FORMAT(K:DATUMS,@D06.)&' P/Z: '&CLIP(K:DOK_SENR)&' Nesakrît pârvietotâs summas uz Nol Nr='&K:merkis
           KOMENT='Nol Nr:'&K:NOLIKTAVA&' '&FORMAT(K:DATUMS,@D06.)&' P/Z: '&CLIP(K:DOK_SENR)&' Nesakrît pârvietotie daudzumi un summas uz Nol Nr='&K:merkis
           KOMENT='Nol Nr:'&K:NOLIKTAVA&' '&FORMAT(K:DATUMS,@D06.)&' P/Z: '&CLIP(K:DOK_SENR)&' Nesakrît pârvietotâs nomenklatûras uz Nol Nr='&K:merkis
           KOMENT='Nol Nr:'&K:NOLIKTAVA&' '&FORMAT(K:DATUMS,@D06.)&' P/Z: '&CLIP(K:DOK_SENR)&' Nesakrît pârvietotie daudzumi un nomenklatûras uz Nol Nr='&K:merkis
           KOMENT='Nol Nr:'&K:NOLIKTAVA&' '&FORMAT(K:DATUMS,@D06.)&' P/Z: '&CLIP(K:DOK_SENR)&' Nesakrît pârvietâs summas un nomenklatûras uz Nol Nr='&K:merkis
           KOMENT='Nol Nr:'&K:NOLIKTAVA&' '&FORMAT(K:DATUMS,@D06.)&' P/Z: '&CLIP(K:DOK_SENR)&' Nesakrît pârvietie daudzumi,summas un nomenklatûras uz Nol Nr='&K:merkis
        .
     ELSE
        CYCLE
     .
     PRINT(RPT:DETAIL)
  .
  FREE(K_TABLE)
  KOMENT='******** IENÂKOÐÂS P/Z **************'
  PRINT(RPT:DETAIL)
  LOOP I#=1 TO RECORDS(D_TABLE)
     GET(D_TABLE,I#)
     IF INRANGE(D:STATUSS,0,7)
        EXECUTE D:STATUSS+1
           KOMENT='Nol Nr:'&D:NOLIKTAVA&' '&FORMAT(D:DATUMS,@D06.)&' P/Z :'&CLIP(D:DOK_SENR)&' Nav fiksçta izieðana no Nol Nr='&D:MERKIS
           KOMENT='Nol Nr:'&D:NOLIKTAVA&' '&FORMAT(D:DATUMS,@D06.)&' P/Z :'&CLIP(D:DOK_SENR)&' Nesakrît pârvietotie daudzumi no Nol Nr='&D:merkis
           KOMENT='Nol Nr:'&D:NOLIKTAVA&' '&FORMAT(D:DATUMS,@D06.)&' P/Z :'&CLIP(D:DOK_SENR)&' Nesakrît pârvietotâs summas no Nol Nr='&D:merkis
           KOMENT='Nol Nr:'&D:NOLIKTAVA&' '&FORMAT(D:DATUMS,@D06.)&' P/Z :'&CLIP(D:DOK_SENR)&' Nesakrît pârvietotie daudzumi un summas no Nol Nr='&D:merkis
           KOMENT='Nol Nr:'&D:NOLIKTAVA&' '&FORMAT(D:DATUMS,@D06.)&' P/Z :'&CLIP(D:DOK_SENR)&' Nesakrît pârvietotâs nomenklatûras no Nol Nr='&D:merkis
           KOMENT='Nol Nr:'&D:NOLIKTAVA&' '&FORMAT(D:DATUMS,@D06.)&' P/Z :'&CLIP(D:DOK_SENR)&' Nesakrît pârvietotie daudzumi un nomenklatûras no Nol Nr='&D:merkis
           KOMENT='Nol Nr:'&D:NOLIKTAVA&' '&FORMAT(D:DATUMS,@D06.)&' P/Z :'&CLIP(D:DOK_SENR)&' Nesakrît pârvietotie daudzumi un nomenklatûras no Nol Nr='&D:merkis
           KOMENT='Nol Nr:'&D:NOLIKTAVA&' '&FORMAT(D:DATUMS,@D06.)&' P/Z :'&CLIP(D:DOK_SENR)&' Nesakrît pârvietie daudzumi,summas un nomenklatûras no Nol Nr='&D:merkis
        .
     ELSE
        CYCLE
     .
     PRINT(RPT:DETAIL)
  .
  FREE(D_TABLE)
  PRINT(RPT:footer)
  ENDPAGE(report)
  pr:skaits=1
  CLOSE(ProgressWindow)
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
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  CLOSE(PAVAD)
  CLOSE(NOLIK)
  RETURN

