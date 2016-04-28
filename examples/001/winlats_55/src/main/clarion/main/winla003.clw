                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateKON_K PROCEDURE


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
LIST1:QUEUE          QUEUE,PRE()
NR                   STRING(3)
                     END
LIST11:QUEUE         QUEUE,PRE()
NR1                  USHORT
                     END
LIST2:QUEUE          QUEUE,PRE()
NR2                  DECIMAL(2)
                     END
UGP                  STRING(1)
PZB_nosaukums        STRING(100),DIM(4)
NPP_NOSAUKUMS        STRING(100),DIM(4)
PKIP_NOSAUKUMS       STRING(100),DIM(2)
SAV_BKK              STRING(5)
MyPVND1              STRING(3)
Update::Reloop  BYTE
Update::Error   BYTE
History::KON:Record LIKE(KON:Record),STATIC
SAV::KON:Record      LIKE(KON:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
FLD5::View           VIEW(VAL_K)
                       PROJECT(VAL:VAL)
                     END
Queue:FileDropCombo  QUEUE,PRE
FLD5::VAL:VAL          LIKE(VAL:VAL)
                     END
FLD5::LoopIndex      LONG,AUTO
QuickWindow          WINDOW('Update the KON_K File'),AT(,,454,310),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateKON_K'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(2,2,451,306),USE(?CurrentTab)
                         TAB(' '),USE(?Tab:1)
                           PROMPT('&Konta kods:'),AT(13,21,41,10),USE(?KON:BKK:Prompt)
                           ENTRY(@s5),AT(54,19,33,14),USE(KON:BKK),FONT(,10,,)
                           PROMPT('No&saukums:'),AT(13,40),USE(?KON:NOSAUKUMS:Prompt)
                           ENTRY(@s95),AT(54,39,397,12),USE(KON:NOSAUKUMS)
                           PROMPT('An&gliski:'),AT(22,55),USE(?KON:KOMENT1:Prompt)
                           ENTRY(@s95),AT(54,54,397,12),USE(KON:NOSAUKUMSA)
                           PROMPT('Noklusçtâ &valûta:'),AT(98,21,59,10),USE(?KON:VAL:Prompt)
                           COMBO(@s3),AT(158,19,34,14),USE(KON:VAL),FORMAT('12L@s3@'),DROP(7),FROM(Queue:FileDropCombo)
                           OPTION('&Jârçíina IE/ZA no KS'),AT(285,18,163,16),USE(KON:BAITS),BOXED
                             RADIO('Nç'),AT(365,23),USE(?KON:IEZAK:Radio1),VALUE('0')
                             RADIO('Jâ'),AT(393,23),USE(?KON:IEZAK:Radio2),VALUE('1')
                           END
                           PROMPT('Alt.k.kods:'),AT(201,21,38,10),USE(?KON:ALT_BKK:Prompt)
                           ENTRY(@s6),AT(238,19,33,14),USE(KON:ALT_BKK)
                           PROMPT('&PVN deklarâcijas rindas neapliekamiem darîjumiem :'),AT(14,77,170,10),USE(?PromptPVN_DEK)
                           LIST,AT(185,74,32,14),USE(MyPVND1),FORMAT('10C~P1~L@s3@'),DROP(13),FROM(List1:Queue)
                           STRING('[ rindas44,45 (K6grupa)  63,65,72(D21,D7grupa)'),AT(230,87),USE(?String1),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           PROMPT('P&VN pielikums kokmateriâliem, rindas :'),AT(230,77,164,10),USE(?PromptKOKI)
                           LIST,AT(185,90,32,14),USE(KON:PVND[2],,?KON:PVND_2),FORMAT('10L@n3B@'),DROP(10),FROM(List11:Queue)
                           LIST,AT(406,74,32,14),USE(KON:PVNK[1]),FORMAT('L@n2B@'),DROP(6),FROM(List2:Queue)
                           LIST,AT(406,90,32,14),USE(KON:PVNK[2],,?PVNK),FORMAT('8L@n2B@'),DROP(6),FROM(List2:Queue)
                           STRING('per. beigâs, bez Paðu kapitâla'),AT(8,273,104,10),USE(?StringBSK_PKIP:2),FONT(,,COLOR:Green,,CHARSET:ANSI)
                           STRING(@s8),AT(9,290),USE(KON:ACC_KODS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           STRING(@D06.),AT(46,290),USE(KON:ACC_DATUMS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                         END
                       END
                       GROUP('Rindu kodi Uzòçmuma gada pârskata dokumentiem saskaòâ ar EDS UGP_UZ_2004_DUF_A (' &|
   'www.vid.gov.lv)'),AT(6,105,443,180),USE(?Group:1),BOXED,FONT(,,COLOR:Green,,CHARSET:ANSI)
                         PROMPT('&Bilancei vai Peïòas /zaud. aprçíinam:'),AT(10,123,127,10),USE(?KON:PZB:Prompt)
                         STRING('BEZ starpsummu kodiem'),AT(10,131),USE(?StringBSK_PZB)
                         ENTRY(@n3B),AT(152,119,29,14),USE(KON:PZB[1]),RIGHT(1)
                         ENTRY(@n3B),AT(152,135,29,14),USE(KON:PZB[2]),RIGHT(1)
                         ENTRY(@n3B),AT(152,151,29,14),USE(KON:PZB[3]),RIGHT(1)
                         ENTRY(@n3B),AT(152,167,29,14),USE(KON:PZB[4]),RIGHT(1)
                         STRING(@s100),AT(184,123,262,10),USE(PZB_nosaukums[1])
                         STRING(@s100),AT(184,139,262,10),USE(PZB_nosaukums[2])
                         STRING(@s100),AT(184,155,262,10),USE(PZB_nosaukums[3])
                         STRING(@s100),AT(184,169,262,10),USE(PZB_nosaukums[4])
                         PROMPT('Pârskatam par &Naudas plûsmu:'),AT(10,188,102,10),USE(?KON:NPP2:PROMPT)
                         STRING(' BEZ starpsummu kodiem ,'),AT(10,199),USE(?StringBSK_NPP2)
                         STRING('AR 420,440,450 '),AT(27,209,66,10),USE(?StringBSK_NPP2:2)
                         STRING(@s100),AT(184,188,262,10),USE(NPP_NOSAUKUMS[1])
                         STRING(@s100),AT(184,204,262,10),USE(NPP_NOSAUKUMS[2])
                         STRING(@s100),AT(184,220,262,10),USE(NPP_NOSAUKUMS[3])
                         STRING(@s100),AT(184,235,262,10),USE(NPP_NOSAUKUMS[4])
                         BUTTON('D-K(A)'),AT(113,187,36,14),USE(?ButtonNPP2:1)
                         BUTTON('D-K(A)'),AT(113,203,36,14),USE(?ButtonNPP2:2)
                         BUTTON('D-K(A)'),AT(113,219,36,14),USE(?ButtonNPP2:3)
                         BUTTON('D-K(A)'),AT(113,235,36,14),USE(?ButtonNPP2:4)
                         ENTRY(@n3B),AT(152,187,29,14),USE(KON:NPP2[1]),RIGHT(1)
                         ENTRY(@n3B),AT(152,203,29,14),USE(KON:NPP2[2]),RIGHT(1)
                         ENTRY(@n3B),AT(152,219,29,14),USE(KON:NPP2[3]),RIGHT(1)
                         ENTRY(@n3B),AT(152,235,29,14),USE(KON:NPP2[4]),RIGHT(1)
                         PROMPT('&Paðu kapitâla izmaiòu pârskats:'),AT(8,252,104,10),USE(?KON:PKIP:Prompt_PKIP)
                         STRING('BEZ pieaug/sam. un summâm'),AT(8,263,104,10),USE(?StringBSK_PKIP)
                         STRING(@s100),AT(184,252,262,10),USE(PKIP_NOSAUKUMS[1])
                         STRING(@s100),AT(184,268,262,10),USE(PKIP_NOSAUKUMS[2])
                         BUTTON('K-D(B)'),AT(113,251,36,14),USE(?ButtonPKIP:1)
                         BUTTON('K-D(B)'),AT(113,267,36,14),USE(?ButtonPKIP:2)
                         ENTRY(@n4B),AT(152,251,29,14),USE(KON:PKIP[1]),RIGHT(1)
                         ENTRY(@n4B),AT(152,267,29,14),USE(KON:PKIP[2]),RIGHT(1)
                       END
                       BUTTON('&OK'),AT(355,287,45,17),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(403,287,45,17),USE(?Cancel),LEFT,ICON('EXITS.ICO')
                     END
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
Progress:Thermometer BYTE

KON_PVND             DECIMAL(3)

ProgressWindow WINDOW('Progress...'),AT(,,142,46),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
!  LOOP I#=1 TO 12
!  LOOP I#=1 TO 10
!  LOOP I#=1 TO 11
  LOOP I#=1 TO 13

!    NR=SUB('000304050643444546474849',I#*2-1,2)    !LÎDZ 2004.G.
!    NR=SUB('000043044045046047048481482049',I#*3-2,3)
    NR=SUB('   41143 44 45 45S45C46 47 48 48148249 ',I#*3-2,3) !01.10.2011
!    NR=SUB('000411043044045046047048481482049',I#*3-2,3) !01.10.2011
    ADD(LIST1:QUEUE)
  .
  LOOP I#=1 TO 13
    NR1=SUB('000411043044045046047048481482049',I#*3-2,3) !01.10.2011
    ADD(LIST11:QUEUE)
  .
  LOOP I#=1 TO 6
    NR2=SUB('004445636472',I#*2-1,2)
    ADD(LIST2:QUEUE)
  .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  ActionMessage='Aplûkoðanas reþîms'   !ja ir localrequest, sistçma pati pârrakstîs pâri
  IF ~KON:BKK[5] !KONTU GRUPA
     DISABLE(?KON:VAL:Prompt,?GROUP:1)
  .
  IF INRANGE(KON:BKK[1],1,5)    !BILANCE
     UGP='B'
     ?KON:PZB:PROMPT{PROP:TEXT}='&Bilancei:'
     LOOP I#=1 TO 4
        PZB_nosaukums[I#]=GETKON_R(UGP,KON:PZB[I#],0,1)
     .
  ELSIF INRANGE(KON:BKK[1],6,8) !PZA
     UGP='P'
     ?KON:PZB:PROMPT{PROP:TEXT}='&Peïòas /zaudçjumu aprçíinam:'
     HIDE(?KON:PZB_4)
     LOOP I#=1 TO 3
        PZB_nosaukums[I#]=GETKON_R(UGP,KON:PZB[I#],0,1)
     .
  .
  LOOP I#=1 TO 4                 !NPP2
     NPP_nosaukums[I#]=GETKON_R('N',KON:NPP2[I#],0,1)
     IF KON:NPPF[I#]='B'
        EXECUTE I#
           ?ButtonNPP2:1{PROP:TEXT}='K-D(B)'
           ?ButtonNPP2:2{PROP:TEXT}='K-D(B)'
           ?ButtonNPP2:3{PROP:TEXT}='K-D(B)'
           ?ButtonNPP2:4{PROP:TEXT}='K-D(B)'
        .
     .
     IF KON:NPPF[I#]='S'
        EXECUTE I#
           ?ButtonNPP2:1{PROP:TEXT}='SALDO'
           ?ButtonNPP2:2{PROP:TEXT}='SALDO'
           ?ButtonNPP2:3{PROP:TEXT}='SALDO'
           ?ButtonNPP2:4{PROP:TEXT}='SALDO'
        .
     .
     IF KON:NPPF[I#]='D'
        EXECUTE I#
           ?ButtonNPP2:1{PROP:TEXT}='D'
           ?ButtonNPP2:2{PROP:TEXT}='D'
           ?ButtonNPP2:3{PROP:TEXT}='D'
           ?ButtonNPP2:4{PROP:TEXT}='D'
        .
     .
     IF KON:NPPF[I#]='E'
        EXECUTE I#
           ?ButtonNPP2:1{PROP:TEXT}='-D(E)'
           ?ButtonNPP2:2{PROP:TEXT}='-D(E)'
           ?ButtonNPP2:3{PROP:TEXT}='-D(E)'
           ?ButtonNPP2:4{PROP:TEXT}='-D(E)'
        .
     .
     IF KON:NPPF[I#]='K'
        EXECUTE I#
           ?ButtonNPP2:1{PROP:TEXT}='K'
           ?ButtonNPP2:2{PROP:TEXT}='K'
           ?ButtonNPP2:3{PROP:TEXT}='K'
           ?ButtonNPP2:4{PROP:TEXT}='K'
        .
     .
     IF KON:NPPF[I#]='L'
        EXECUTE I#
           ?ButtonNPP2:1{PROP:TEXT}='-K(L)'
           ?ButtonNPP2:2{PROP:TEXT}='-K(L)'
           ?ButtonNPP2:3{PROP:TEXT}='-K(L)'
           ?ButtonNPP2:4{PROP:TEXT}='-K(L)'
        .
     .
  .
  LOOP I#=1 TO 2                  !PKIP
     PKIP_nosaukums[I#]=GETKON_R('K',KON:PKIP[I#],0,1)
     IF KON:PKIF[I#]='S'
        EXECUTE I#
           ?ButtonPKIP:1{PROP:TEXT}='SaldoK'
           ?ButtonPKIP:2{PROP:TEXT}='SaldoK'
        .
     .
     IF KON:PKIF[I#]='A'
        EXECUTE I#
           ?ButtonPKIP:1{PROP:TEXT}='D-K(A)'
           ?ButtonPKIP:2{PROP:TEXT}='D-K(A)'
        .
     .
  .
  
  IF localrequest=2
     SAV_BKK=KON:BKK
     IF Browse::SelectRecord=TRUE THEN DISABLE(?KON:BKK).
  .
  
    !*******USER LEVEL ACCESS CONTROL********
    IF ~BAND(REG_BASE_ACC,00000001b) ! ALT KONTU PLÂNS
       DISABLE(?KON:ALT_BKK)
       DISABLE(?KON:ALT_BKK:Prompt)
    .
    IF BAND(REG_BASE_ACC,00000010b) ! Budþets
       HIDE(?KON:KOMENT1:Prompt)
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
      DO FLD5::FillList
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?KON:BKK:Prompt)
      IF KON:PVND[1] = 458
         MyPVND1 = '45S'
      ELSIF KON:PVND[1] = 450
         MyPVND1 = '45C'
      ELSE
         MyPVND1 = KON:PVND[1]
      .
!      stop ('*'&MyPVND1&'*')
      IF LOCALREQUEST=2
         SELECT(?KON:NOSAUKUMS)
      ELSIF LOCALREQUEST=3
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-2)
         enable(?Tab:1)  !ATVÇRT CURRENTTAB NEDRÎKST
         SELECT(?cancel)
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
        History::KON:Record = KON:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(KON_K)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(KON:BKK_KEY)
              IF StandardWarning(Warn:DuplicateKey,'KON:BKK_KEY')
                SELECT(?KON:BKK:Prompt)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?KON:BKK:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::KON:Record <> KON:Record
              RecordChanged = True
            END
!            stop('***')
            IF RecordChanged THEN
              Update::Error = RIUpdate:KON_K(1)
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
              SELECT(?KON:BKK:Prompt)
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
    OF ?KON:VAL
      CASE EVENT()
      OF EVENT:Accepted
        IF KON:VAL AND ~ACCEPTED#
        FLD5::VAL:VAL = KON:VAL
        GET(Queue:FileDropCombo,FLD5::VAL:VAL)
        IF ERRORCODE() THEN
          SELECT(?KON:VAL)
        END
        END
        KON:VAL = GetVAL_K(KON:VAL,0)
        IF KON:VAL
           ACCEPTED#=1
        .
        DISPLAY()
      END
    OF ?KON:PZB_1
      CASE EVENT()
      OF EVENT:Accepted
        PZB_nosaukums[1]=GETKON_R(UGP,KON:PZB[1],0,1)
      END
    OF ?KON:PZB_2
      CASE EVENT()
      OF EVENT:Accepted
        PZB_nosaukums[2]=GETKON_R(UGP,KON:PZB[2],0,1)
      END
    OF ?KON:PZB_3
      CASE EVENT()
      OF EVENT:Accepted
        PZB_nosaukums[3]=GETKON_R(UGP,KON:PZB[3],0,1)
      END
    OF ?KON:PZB_4
      CASE EVENT()
      OF EVENT:Accepted
        PZB_nosaukums[4]=GETKON_R(UGP,KON:PZB[4],0,1)
      END
    OF ?ButtonNPP2:1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF KON:NPPF[1]='A'
           KON:NPPF[1]='B'
           ?ButtonNPP2:1{PROP:TEXT}='K-D(B)'
        ELSIF KON:NPPF[1]='B'
           KON:NPPF[1]='S'
           ?ButtonNPP2:1{PROP:TEXT}='SALDO'
        ELSIF KON:NPPF[1]='S'
           KON:NPPF[1]='D'
           ?ButtonNPP2:1{PROP:TEXT}='D'
        ELSIF KON:NPPF[1]='D'
           KON:NPPF[1]='E'
           ?ButtonNPP2:1{PROP:TEXT}='-D(E)'
        ELSIF KON:NPPF[1]='E'
           KON:NPPF[1]='K'
           ?ButtonNPP2:1{PROP:TEXT}='K'
        ELSIF KON:NPPF[1]='K'
           KON:NPPF[1]='L'
           ?ButtonNPP2:1{PROP:TEXT}='-K(L)'
        ELSE
           KON:NPPF[1]='A'
           ?ButtonNPP2:1{PROP:TEXT}='D-K(A)'
        .
        DISPLAY
      END
    OF ?ButtonNPP2:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF KON:NPPF[2]='A'
           KON:NPPF[2]='B'
           ?ButtonNPP2:2{PROP:TEXT}='K-D(B)'
        ELSIF KON:NPPF[2]='B'
           KON:NPPF[2]='S'
           ?ButtonNPP2:2{PROP:TEXT}='SALDO'
        ELSIF KON:NPPF[2]='S'
           KON:NPPF[2]='D'
           ?ButtonNPP2:2{PROP:TEXT}='D'
        ELSIF KON:NPPF[2]='D'
           KON:NPPF[2]='E'
           ?ButtonNPP2:2{PROP:TEXT}='-D(E)'
        ELSIF KON:NPPF[2]='E'
           KON:NPPF[2]='K'
           ?ButtonNPP2:2{PROP:TEXT}='K'
        ELSIF KON:NPPF[2]='K'
           KON:NPPF[2]='L'
           ?ButtonNPP2:2{PROP:TEXT}='-K(L)'
        ELSE
           KON:NPPF[2]='A'
           ?ButtonNPP2:2{PROP:TEXT}='D-K(A)'
        .
        DISPLAY
      END
    OF ?ButtonNPP2:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF KON:NPPF[3]='A'
           KON:NPPF[3]='B'
           ?ButtonNPP2:3{PROP:TEXT}='K-D(B)'
        ELSIF KON:NPPF[3]='B'
           KON:NPPF[3]='S'
           ?ButtonNPP2:3{PROP:TEXT}='SALDO'
        ELSIF KON:NPPF[3]='S'
           KON:NPPF[3]='D'
           ?ButtonNPP2:3{PROP:TEXT}='D'
        ELSIF KON:NPPF[3]='D'
           KON:NPPF[3]='E'
           ?ButtonNPP2:3{PROP:TEXT}='-D(E)'
        ELSIF KON:NPPF[3]='E'
           KON:NPPF[3]='K'
           ?ButtonNPP2:3{PROP:TEXT}='K'
        ELSIF KON:NPPF[3]='K'
           KON:NPPF[3]='L'
           ?ButtonNPP2:3{PROP:TEXT}='-K(L)'
        ELSE
           KON:NPPF[3]='A'
           ?ButtonNPP2:3{PROP:TEXT}='D-K(A)'
        .
      END
    OF ?ButtonNPP2:4
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF KON:NPPF[4]='A'
           KON:NPPF[4]='B'
           ?ButtonNPP2:4{PROP:TEXT}='K-D(B)'
        ELSIF KON:NPPF[4]='B'
           KON:NPPF[4]='S'
           ?ButtonNPP2:4{PROP:TEXT}='SALDO'
        ELSIF KON:NPPF[4]='S'
           KON:NPPF[4]='D'
           ?ButtonNPP2:4{PROP:TEXT}='D'
        ELSIF KON:NPPF[4]='D'
           KON:NPPF[4]='E'
           ?ButtonNPP2:4{PROP:TEXT}='-D(E)'
        ELSIF KON:NPPF[4]='E'
           KON:NPPF[4]='K'
           ?ButtonNPP2:4{PROP:TEXT}='K'
        ELSIF KON:NPPF[4]='K'
           KON:NPPF[4]='L'
           ?ButtonNPP2:4{PROP:TEXT}='-K(L)'
        ELSE
           KON:NPPF[4]='A'
           ?ButtonNPP2:4{PROP:TEXT}='D-K(A)'
        .
      END
    OF ?KON:NPP2_1
      CASE EVENT()
      OF EVENT:Accepted
        NPP_nosaukums[1]=GETKON_R('N',KON:NPP2[1],0,1)
      END
    OF ?KON:NPP2_2
      CASE EVENT()
      OF EVENT:Accepted
        NPP_nosaukums[2]=GETKON_R('N',KON:NPP2[2],0,1)
      END
    OF ?KON:NPP2_3
      CASE EVENT()
      OF EVENT:Accepted
        NPP_nosaukums[3]=GETKON_R('N',KON:NPP2[3],0,1)
      END
    OF ?KON:NPP2_4
      CASE EVENT()
      OF EVENT:Accepted
        NPP_nosaukums[4]=GETKON_R('N',KON:NPP2[4],0,1)
      END
    OF ?ButtonPKIP:1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF KON:PKIF[1]='B'
           KON:PKIF[1]='S'
           ?ButtonPKIP:1{PROP:TEXT}='SaldoK'
        ELSIF KON:PKIF[1]='S'
           KON:PKIF[1]='A'
           ?ButtonPKIP:1{PROP:TEXT}='D-K(A)'
        ELSE
           KON:PKIF[1]='B'
           ?ButtonPKIP:1{PROP:TEXT}='K-D(B)'
        .
      END
    OF ?ButtonPKIP:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF KON:PKIF[2]='B'
           KON:PKIF[2]='S'
           ?ButtonPKIP:2{PROP:TEXT}='SaldoK'
        ELSIF KON:PKIF[2]='S'
           KON:PKIF[2]='A'
           ?ButtonPKIP:2{PROP:TEXT}='D-K(A)'
        ELSE
           KON:PKIF[2]='B'
           ?ButtonPKIP:2{PROP:TEXT}='K-D(B)'
        .
      END
    OF ?KON:PKIP_1
      CASE EVENT()
      OF EVENT:Accepted
        PKIP_nosaukums[1]=GETKON_R('K',KON:PKIP[1],0,1)
      END
    OF ?KON:PKIP_2
      CASE EVENT()
      OF EVENT:Accepted
        PKIP_nosaukums[2]=GETKON_R('K',KON:PKIP[2],0,1)
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
        IF MyPVND1 = '45S'
           KON:PVND[1] = 458
        ELSIF MyPVND1 = '45C'
           KON:PVND[1] = 450
        ELSE
           KON:PVND[1] = MyPVND1
        .
!        Stop('^^^'&KON:PVND[1])
        IF KON:PVND[1] AND KON:PVND[1]=KON:PVND[2]
           KLUDA(0,'Atkârtojas PVN deklarâcijas rindu kodi')
           POST(EVENT:GainFocus)
           VCRRequest = VCRNone
           SELECT(?KON:PVND_2)
           CYCLE
        .
        IF KON:PVNK[1] AND KON:PVNK[1]=KON:PVNK[2]
           KLUDA(0,'Atkârtojas PVN pielik. par kokmater. rindu kodi')
           POST(EVENT:GainFocus)
           VCRRequest = VCRNone
           SELECT(?PVNK)
           CYCLE
        .
        LOOP I#=1 TO 4
           IF KON:NPP2[I#] AND ~KON:NPPF[I#]
              KON:NPPF[I#]='A'
           ELSIF ~KON:NPP2[I#]
              KON:NPPF[I#]=''
           .
        .
        LOOP I#=1 TO 2
           IF KON:PKIP[I#] AND ~INSTRING(KON:PKIF[I#],'SAB')
              KON:PKIF[I#]='B'
           ELSIF ~KON:PKIP[I#]
              KON:PKIF[I#]=''
           .
        .
        
        !***********************BKK MAIÒA********************************************
        IF LOCALREQUEST=CHANGERECORD AND ~(SAV_BKK=KON:BKK)
           IF GNET  !GLOBÂLÂ TÎKLÂ BKK MAINÎT AIZLIEGTS
              KLUDA(121,'mainît KONTA KODU')
              BKKNOTOK#=TRUE
           ELSE
              IF DUPLICATE(KON:BKK_KEY)
                 KLUDA(0,'Ðâds konts jau ir definçts, vai vçlaties tos apvienot ?',2)
                 IF KLU_DARBIBA
                    APVIENOT#=TRUE
                 ELSE
                    BKKNOTOK#=TRUE
                 .
              .
           .
           IF ~BKKNOTOK#
              LOOP T#=1 TO BASE_sk
                 CLOSE(GGK)
                 GGKNAME='GGK'&FORMAT(T#,@N02)
                 IF DOS_CONT(CLIP(GGKNAME)&'.TPS',2)
                    OPEN(GGK,12h)
                    IF ERROR()
                       TAKA"=PATH()
                       KLUDA(1,CLIP(TAKA")&'\'&GGKNAME)
                       BKKNOTOK#=TRUE
                       BREAK
                    .
                 .
              .
              CLOSE(GGK)
              GGKNAME='GGK'&FORMAT(LOC_NR,@N02)      !Noliekam, ko paòçmâm
           .
           IF ~BKKNOTOK#
              KLUDA(51,SAV_BKK&'->'&KON:BKK)
              IF KLU_DARBIBA
                 OPEN(ProgressWindow)
                 LOOP T#=1 TO BASE_sk
                    CLOSE(GGK)
                    GGKNAME='GGK'&FORMAT(T#,@N02)
                    IF DOS_CONT(CLIP(GGKNAME)&'.TPS',2)
                       OPEN(GGK,12h)
                       IF ERROR()
                          TAKA"=PATH()
                          KLUDA(1,CLIP(TAKA")&'\'&GGKNAME)
                       ELSE
                          Progress:Thermometer = 0
                          ?Progress:PctText{Prop:Text} = '0% Izpildîti'
                          ProgressWindow{Prop:Text} = 'Konvertçjam GGK'
                          ?Progress:UserString{Prop:Text}=''
                          RecordsToProcess=records(GGK)
                          RecordsProcessed = 0
                          RecordsThisCycle = 0
                          SET(GGK)
                          LOOP
                             NEXT(GGK)
                             IF ERROR() THEN BREAK.
                             DO PROGRESSBAR
                             IF GGK:BKK=SAV_BKK
                                GGK:BKK=KON:BKK
                                IF RIUPDATE:GGK()
                                   KLUDA(24,'RAKSTOT GGK:'&ERROR())
                                .
                             .
                          .
                       .
                    .
                 .
                 CLOSE(GGK)
                 GGKNAME='GGK'&FORMAT(LOC_NR,@N02)   !Noliekam, ko paòçmâm
        !                 CHECKOPEN(GGK,1)
        
                 LOOP T#=1 TO PAM_sk
                    CLOSE(PAMAT)
                    PAMATNAME='PAMAT'&FORMAT(T#,@N02)
                    IF DOS_CONT(CLIP(PAMATNAME)&'.TPS',2)
                       OPEN(PAMAT,12h)
                       IF ERROR()
                          TAKA"=PATH()
                          KLUDA(1,CLIP(TAKA")&'\'&PAMATNAME)
                       ELSE
                          Progress:Thermometer = 0
                          ?Progress:PctText{Prop:Text} = '0% Izpildîti'
                          ProgressWindow{Prop:Text} = 'Konvertçjam PAMAT'
                          ?Progress:UserString{Prop:Text}=''
                          RecordsToProcess=records(PAMAT)
                          RecordsProcessed = 0
                          RecordsThisCycle = 0
                          SET(PAMAT)
                          LOOP
                             NEXT(PAMAT)
                             IF ERROR() THEN BREAK.
                             DO PROGRESSBAR
                             JARAKSTA#=FALSE
                             IF PAM:BKK=SAV_BKK
                                PAM:BKK=KON:BKK
                                JARAKSTA#=TRUE
                             .
                             IF PAM:BKKN=SAV_BKK
                                PAM:BKKN=KON:BKK
                                JARAKSTA#=TRUE
                             .
                             IF PAM:OKK7=SAV_BKK
                                PAM:OKK7=KON:BKK
                                JARAKSTA#=TRUE
                             .
                             IF JARAKSTA#=TRUE
                                IF RIUPDATE:PAMAT()
                                   KLUDA(24,'RAKSTOT PAMAT:'&ERROR())
                                .
                             .
                          .
                       .
                    .
                 .
                 CLOSE(GGK)
                 GGKNAME='GGK'&FORMAT(LOC_NR,@N02)   !Noliekam, ko paòçmâm
        !                 CHECKOPEN(GGK,1)
        
                 CLOSE(TEK_K)
                 OPEN(TEK_K,12h)
                 IF ERROR()
                    TAKA"=PATH()
                    KLUDA(1,CLIP(TAKA")&'\TEK_K')
                 ELSE
                    Progress:Thermometer = 0
                    ?Progress:PctText{Prop:Text} = '0% Izpildîti'
                    ProgressWindow{Prop:Text} = 'Konvertçjam TEK_K'
                    ?Progress:UserString{Prop:Text}=''
                    RecordsToProcess=records(TEK_K)
                    RecordsProcessed = 0
                    RecordsThisCycle = 0
                    SET(TEK_K)
                    LOOP
                       NEXT(TEK_K)
                       IF ERROR() THEN BREAK.
                       DO PROGRESSBAR
                       JARAKSTA#=FALSE
                       IF TEK:BKK_1=SAV_BKK
                          TEK:BKK_1=KON:BKK
                          JARAKSTA#=TRUE
                       .
                       IF TEK:BKK_2=SAV_BKK
                          TEK:BKK_2=KON:BKK
                          JARAKSTA#=TRUE
                       .
                       IF TEK:BKK_3=SAV_BKK
                          TEK:BKK_3=KON:BKK
                          JARAKSTA#=TRUE
                       .
                       IF TEK:BKK_4=SAV_BKK
                          TEK:BKK_4=KON:BKK
                          JARAKSTA#=TRUE
                       .
                       IF TEK:BKK_5=SAV_BKK
                          TEK:BKK_5=KON:BKK
                          JARAKSTA#=TRUE
                       .
                       IF TEK:BKK_6=SAV_BKK
                          TEK:BKK_6=KON:BKK
                          JARAKSTA#=TRUE
                       .
                       IF JARAKSTA#=TRUE
                          IF RIUPDATE:TEK_K()
                             KLUDA(24,'RAKSTOT TEK_K:'&ERROR())
                          .
                       .
                    .
                 .
                 CLOSE(TEK_K)
                 CHECKOPEN(TEK_K,1)
        
                 close(ProgressWindow)
                 IF APVIENOT#=TRUE
                    LOOP
                      LocalResponse = RequestCancelled
                      SETCURSOR(Cursor:Wait)
                      IF RIDelete:KON_K()
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
                        SET(KON:BKK_KEY,KON:BKK_KEY)
                        NEXT(KON_K)
                      END
                      BREAK
                    END
                    DO ProcedureReturn
                 .
              ELSE
                 BKKNOTOK#=TRUE
              .
           .
           IF BKKNOTOK#=TRUE
              KON:BKK=SAV_BKK
        !              POST(EVENT:GainFocus)   !NESTRÂDÂ......
        !              VCRRequest = VCRNone
              SELECT(?KON:BKK)
        !              CYCLE
           .
        .
        
        KON:ACC_KODS=ACC_kods
        KON:ACC_DATUMS=today()
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
  IF KON_K::Used = 0
    CheckOpen(KON_K,1)
  END
  KON_K::Used += 1
  BIND(KON:RECORD)
  IF KON_R::Used = 0
    CheckOpen(KON_R,1)
  END
  KON_R::Used += 1
  BIND(KONR:RECORD)
  IF VAL_K::Used = 0
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  BIND(VAL:RECORD)
  FilesOpened = True
  RISnap:KON_K
  SAV::KON:Record = KON:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
      CLEAR(KON:ATLIKUMS)
      KON:ACC_KODS=ACC_kods
      KON:ACC_DATUMS=today()
    END ! BEIDZAS LocalRequest = 1
    
    !  IF NOM:NOMENKLAT='' AND LOCALREQUEST=3  !NESAPROTAMA CLARA KÏÛDA
    !     LocalResponse = RequestCancelled
    !     DO PROCEDURERETURN
    !  .
      IF GNET !GLOBÂLAIS TÎKLS
         CASE LOCALREQUEST
         OF 1
            KON:GNET_FLAG[1]=1
            KON:GNET_FLAG[2]=''
         OF 2
            IF KON:GNET_FLAG[1]=1     !JA STÂV ADD1 (NEKUR CITUR VÇL NAV IERAKSTÎTS)
            ELSIF KON:GNET_FLAG[1]=4  !JA STÂV ADD4 (NE VISUR IR IERAKSTÎTS)
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSIF KON:GNET_FLAG[1]=2  !JA STÂV PUT2 (NEKUR CITUR VÇL NAV NOMAINÎTS)
            ELSIF KON:GNET_FLAG[1]=5  !JA STÂV PUT5 (NE VISUR IR NOMAINÎTS)
               KON:GNET_FLAG[1]=2
               KON:GNET_FLAG[2]=''    !MAINAM VISUR
            ELSIF KON:GNET_FLAG[1]=3 OR KON:GNET_FLAG[1]=6  !JA STÂV DEL 
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSE
               KON:GNET_FLAG[1]=2
               KON:GNET_FLAG[2]=''
            .
            SAV::KON:Record = KON:Record ! LAI NERAKSTA, JA NEKAS NAV MAINÎTS
         OF 3
    !        STOP(KON:GNET_FLAG)
            IF KON:GNET_FLAG[1]=1     !JA STÂV ADD1 (NEKUR CITUR VÇL NAV IERAKSTÎTS)
               KON:GNET_FLAG=''
            ELSIF KON:GNET_FLAG[1]=4  !JA STÂV ADD4 (NE VISUR IR IERAKSTÎTS)
               KLUDA(121,'dzçst, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSIF KON:GNET_FLAG[1]=2  !JA STÂV PUT2 (NEKUR CITUR VÇL NAV NOMAINÎTS)
               KON:GNET_FLAG[1]=3
               LOCALREQUEST=4
            ELSIF KON:GNET_FLAG[1]=5  !JA STÂV PUT5 (NE VISUR IR NOMAINÎTS)
               KON:GNET_FLAG[1]=3     !DZÇÐAM VISUR
               KON:GNET_FLAG[2]=''
               LOCALREQUEST=4
            ELSIF KON:GNET_FLAG[1]=3 OR KON:GNET_FLAG[1]=6  !JA STÂV DEL
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSE
               KON:GNET_FLAG[1]=3
               KON:GNET_FLAG[2]=''
               LOCALREQUEST=4
            .
         .
      .
      IF LocalRequest = 4 ! DeleteRecord GNET
        IF StandardWarning(Warn:StandardDelete) = Button:OK
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            KON:NOSAUKUMS='WAITING FOR DELETE'
            IF RIUPDATE:KON_K()
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
        IF RIDelete:KON_K()
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
  ?KON:BKK{PROP:Alrt,255} = 734
  ?KON:NOSAUKUMS{PROP:Alrt,255} = 734
  ?KON:NOSAUKUMSA{PROP:Alrt,255} = 734
  ?KON:VAL{PROP:Alrt,255} = 734
  ?KON:BAITS{PROP:Alrt,255} = 734
  ?KON:ALT_BKK{PROP:Alrt,255} = 734
  ?KON:ACC_KODS{PROP:Alrt,255} = 734
  ?KON:ACC_DATUMS{PROP:Alrt,255} = 734
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
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
    KON_R::Used -= 1
    IF KON_R::Used = 0 THEN CLOSE(KON_R).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
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
PROGRESSBAR       ROUTINE
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
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?KON:BKK
      KON:BKK = History::KON:Record.BKK
    OF ?KON:NOSAUKUMS
      KON:NOSAUKUMS = History::KON:Record.NOSAUKUMS
    OF ?KON:NOSAUKUMSA
      KON:NOSAUKUMSA = History::KON:Record.NOSAUKUMSA
    OF ?KON:VAL
      KON:VAL = History::KON:Record.VAL
    OF ?KON:BAITS
      KON:BAITS = History::KON:Record.BAITS
    OF ?KON:ALT_BKK
      KON:ALT_BKK = History::KON:Record.ALT_BKK
    OF ?KON:ACC_KODS
      KON:ACC_KODS = History::KON:Record.ACC_KODS
    OF ?KON:ACC_DATUMS
      KON:ACC_DATUMS = History::KON:Record.ACC_DATUMS
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
  KON:Record = SAV::KON:Record
  SAV::KON:Record = KON:Record
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
  FLD5::VAL:VAL = KON:VAL
  SET(VAL_K)
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
    ADD(Queue:FileDropCombo)
  END
  CLOSE(FLD5::View)
  IF RECORDS(Queue:FileDropCombo)
    SORT(Queue:FileDropCombo,FLD5::VAL:VAL)
    IF KON:VAL
      LOOP FLD5::LoopIndex = 1 TO RECORDS(Queue:FileDropCombo)
        GET(Queue:FileDropCombo,FLD5::LoopIndex)
        IF KON:VAL = FLD5::VAL:VAL THEN BREAK.
      END
      ?KON:VAL{Prop:Selected} = FLD5::LoopIndex
    END
  ELSE
    CLEAR(KON:VAL)
  END
BrowseKON_K PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
KON_ATLIKUMS         DECIMAL(11,2)

BRW1::View:Browse    VIEW(KON_K)
                       PROJECT(KON:BKK)
                       PROJECT(KON:NOSAUKUMS)
                       PROJECT(KON:VAL)
                       PROJECT(KON:BAITS)
                       PROJECT(KON:ATLIKUMS)
                       PROJECT(KON:NPPF)
                       PROJECT(KON:PKIF)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::KON:BKK          LIKE(KON:BKK)              ! Queue Display field
BRW1::KON:BKK:NormalFG LONG                       ! Normal Foreground
BRW1::KON:BKK:NormalBG LONG                       ! Normal Background
BRW1::KON:BKK:SelectedFG LONG                     ! Selected Foreground
BRW1::KON:BKK:SelectedBG LONG                     ! Selected Background
BRW1::KON:NOSAUKUMS    LIKE(KON:NOSAUKUMS)        ! Queue Display field
BRW1::KON:NOSAUKUMS:NormalFG LONG                 ! Normal Foreground
BRW1::KON:NOSAUKUMS:NormalBG LONG                 ! Normal Background
BRW1::KON:NOSAUKUMS:SelectedFG LONG               ! Selected Foreground
BRW1::KON:NOSAUKUMS:SelectedBG LONG               ! Selected Background
BRW1::KON:VAL          LIKE(KON:VAL)              ! Queue Display field
BRW1::KON:VAL:NormalFG LONG                       ! Normal Foreground
BRW1::KON:VAL:NormalBG LONG                       ! Normal Background
BRW1::KON:VAL:SelectedFG LONG                     ! Selected Foreground
BRW1::KON:VAL:SelectedBG LONG                     ! Selected Background
BRW1::KON:BAITS        LIKE(KON:BAITS)            ! Queue Display field
BRW1::KON:BAITS:NormalFG LONG                     ! Normal Foreground
BRW1::KON:BAITS:NormalBG LONG                     ! Normal Background
BRW1::KON:BAITS:SelectedFG LONG                   ! Selected Foreground
BRW1::KON:BAITS:SelectedBG LONG                   ! Selected Background
BRW1::KON_ATLIKUMS     LIKE(KON_ATLIKUMS)         ! Queue Display field
BRW1::KON_ATLIKUMS:NormalFG LONG                  ! Normal Foreground
BRW1::KON_ATLIKUMS:NormalBG LONG                  ! Normal Background
BRW1::KON_ATLIKUMS:SelectedFG LONG                ! Selected Foreground
BRW1::KON_ATLIKUMS:SelectedBG LONG                ! Selected Background
BRW1::KON:PVND_1_      LIKE(KON:PVND[1])          ! Queue Display field
BRW1::KON:PVND_2_      LIKE(KON:PVND[2])          ! Queue Display field
BRW1::KON:PVNK_1_      LIKE(KON:PVNK[1])          ! Queue Display field
BRW1::KON:PVNK_2_      LIKE(KON:PVNK[2])          ! Queue Display field
BRW1::KON:PZB_1_       LIKE(KON:PZB[1])           ! Queue Display field
BRW1::KON:PZB_2_       LIKE(KON:PZB[2])           ! Queue Display field
BRW1::KON:PZB_3_       LIKE(KON:PZB[3])           ! Queue Display field
BRW1::KON:PZB_4_       LIKE(KON:PZB[4])           ! Queue Display field
BRW1::KON:NPPF         LIKE(KON:NPPF)             ! Queue Display field
BRW1::KON:NPP2_1_      LIKE(KON:NPP2[1])          ! Queue Display field
BRW1::KON:NPP2_2_      LIKE(KON:NPP2[2])          ! Queue Display field
BRW1::KON:NPP2_3_      LIKE(KON:NPP2[3])          ! Queue Display field
BRW1::KON:NPP2_4_      LIKE(KON:NPP2[4])          ! Queue Display field
BRW1::KON:PKIF         LIKE(KON:PKIF)             ! Queue Display field
BRW1::KON:PKIP_1_      LIKE(KON:PKIP[1])          ! Queue Display field
BRW1::KON:PKIP_2_      LIKE(KON:PKIP[2])          ! Queue Display field
BRW1::KKK              LIKE(KKK)                  ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(KON:BKK),DIM(100)
BRW1::Sort1:LowValue LIKE(KON:BKK)                ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(KON:BKK)               ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Kontu plâns'),AT(,,450,328),FONT('MS Sans Serif',9,,FONT:bold),IMM,VSCROLL,HLP('BrowseKON_K'),SYSTEM,GRAY,RESIZE
                       LIST,AT(8,20,434,260),USE(?Browse:1),IMM,HVSCROLL,FONT(,9,,FONT:bold),MSG('Browsing Records'),FORMAT('24L|M*~Konts~L(2)@s5@250L|M*~Nosaukums~L(2)@s95@16C|M*~Val~@s3@12C|M*~B~@N1B@42R' &|
   '(1)|M*~Atlikums~C(0)@n-15.2B@12L|M~P1~C@n3B@12L|M~P2~C@n3B@11C|M~K1~@n2B@12C|M~K' &|
   '2~@n2B@17C|M~PB1~@n3B@17C|M~PB2~@n3B@17C|M~PB3~@n3B@17C|M~PB4~@n3B@18C|M~F~L@s4@' &|
   '17C|M~NP1~@n3B@16C|M~NP2~@n3B@17C|M~NP3~@n3B@16L(1)|M~NP4~L(0)@n3B@20C|M~F~@s5@1' &|
   '6C|M~PK1~@n4B@16C|M~PK2~@n4B@'),FROM(Queue:Browse:1)
                       BUTTON('&Ievadît'),AT(295,284,45,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(342,284,45,14),USE(?Change),DEFAULT
                       BUTTON('&Dzçst'),AT(389,284,45,14),USE(?Delete:2)
                       BUTTON('Þurnâls'),AT(8,307,45,14),USE(?ButtonZurnals),HIDE
                       BUTTON('Iz&vçlçties'),AT(356,307),USE(?Select),FONT(,,COLOR:Navy,,CHARSET:ANSI),KEY(EnterKey)
                       SHEET,AT(4,4,442,299),USE(?CurrentTab)
                         TAB('KON:BKK_KEY'),USE(?Tab:2)
                           STRING(@n2B),AT(430,4,12,10),USE(LOC_NR),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           ENTRY(@s5),AT(10,285),USE(KON:BKK)
                           STRING('- âtrâ meklçðana pçc konta'),AT(42,285),USE(?String1)
                           BUTTON('&C-Kopçt'),AT(249,284,45,14),USE(?Kopet)
                         END
                       END
                       BUTTON('&Beigt'),AT(400,307,45,14),USE(?Close)
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
  ?BROWSE:1{PROP:FORMAT}=GETINI('BrowseKON_K','?BROWSE:1 Format',?BROWSE:1{PROP:FORMAT},'WinLats.ini')
  IF LOCALREQUEST=SELECTRECORD
     ?Change{PROP:DEFAULT}=''
     ?Select{PROP:DEFAULT}='1'
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
      IF KKK
         CLEAR(KON:RECORD)
         KON:BKK=KKK
         SET(KON:BKK_KEY,KON:BKK_KEY)
         NEXT(KON_K)
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
      !   DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         DO RefreshWindow
      .
      IF INRANGE(JOB_NR,1,15)
         UNHIDE(?BUTTONZURNALS)
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
    OF ?ButtonZurnals
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        rs = 'Apstiprinâtie'
        PAR_NR=999999999
        PAR_TIPS  ='EFCNIR'
        F:NOT_GRUPA=''
        F:DTK=''
        F:PVN_T=''
        F:PVN_P=0
        F:OBJ_NR=0
        F:NODALA=''
        F:X=0
        F:VALODA='0'
        F:DBF='W'
        KKK=KON:BKK
        IF ~(S_DAT=DATE(1,1,DB_GADS)) THEN S_DAT=DATE(1,1,DB_GADS).
        IF INSTRING(' ',KKK,1,1)
           START(B_ZurnalsVKVP,50000)
        ELSE
           START(B_Zurnals1KVP,50000)
        .
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
    OF ?KON:BKK
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?KON:BKK)
        IF KON:BKK
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = KON:BKK
          BRW1::Sort1:LocatorLength = LEN(CLIP(KON:BKK))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?Kopet
      CASE EVENT()
      OF EVENT:Accepted
            COPYREQUEST=1
            DO BRW1::ButtonInsert
        DO SyncWindow
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
  IF KON_K::Used = 0
    CheckOpen(KON_K,1)
  END
  KON_K::Used += 1
  BIND(KON:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowseKON_K','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select{Prop:Hide} = True
    DISABLE(?Select)
  ELSE
    Browse::SelectRecord=TRUE
  END
  BIND('KKK',KKK)
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
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
  END
  PUTINI('BrowseKON_K','?BROWSE:1 Format',?BROWSE:1{PROP:FORMAT},'WinLats.ini')
  IF WindowOpened
    INISaveWindow('BrowseKON_K','winlats.INI')
    CLOSE(QuickWindow)
  END
   Browse::SelectRecord=FALSE
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
    KON:BKK = BRW1::Sort1:LocatorValue
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
      KON:BKK = BRW1::Sort1:LocatorValue
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
  IF SEND(KON_K,'QUICKSCAN=on').
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'KON_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = KON:BKK
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'KON_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = KON:BKK
    SetupStringStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue,SIZE(BRW1::Sort1:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  END
  IF SEND(KON_K,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  KON:BKK = BRW1::KON:BKK
  KON:NOSAUKUMS = BRW1::KON:NOSAUKUMS
  KON:VAL = BRW1::KON:VAL
  KON:BAITS = BRW1::KON:BAITS
  KON_ATLIKUMS = BRW1::KON_ATLIKUMS
  KON:PVND[1] = BRW1::KON:PVND_1_
  KON:PVND[2] = BRW1::KON:PVND_2_
  KON:PVNK[1] = BRW1::KON:PVNK_1_
  KON:PVNK[2] = BRW1::KON:PVNK_2_
  KON:PZB[1] = BRW1::KON:PZB_1_
  KON:PZB[2] = BRW1::KON:PZB_2_
  KON:PZB[3] = BRW1::KON:PZB_3_
  KON:PZB[4] = BRW1::KON:PZB_4_
  KON:NPPF = BRW1::KON:NPPF
  KON:NPP2[1] = BRW1::KON:NPP2_1_
  KON:NPP2[2] = BRW1::KON:NPP2_2_
  KON:NPP2[3] = BRW1::KON:NPP2_3_
  KON:NPP2[4] = BRW1::KON:NPP2_4_
  KON:PKIF = BRW1::KON:PKIF
  KON:PKIP[1] = BRW1::KON:PKIP_1_
  KON:PKIP[2] = BRW1::KON:PKIP_2_
  KKK = BRW1::KKK
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
  IF INRANGE(JOB_NR,1,15)   !TIKAI BASE
     KON_ATLIKUMS=KON:ATLIKUMS[LOC_NR]
  ELSE
     KON_ATLIKUMS=0
  .
  
  BRW1::KON:BKK = KON:BKK
  IF (~KON:BKK[5])
    BRW1::KON:BKK:NormalFG = 255
    BRW1::KON:BKK:NormalBG = -1
    BRW1::KON:BKK:SelectedFG = 255
    BRW1::KON:BKK:SelectedBG = -1
  ELSE
    BRW1::KON:BKK:NormalFG = -1
    BRW1::KON:BKK:NormalBG = -1
    BRW1::KON:BKK:SelectedFG = -1
    BRW1::KON:BKK:SelectedBG = -1
  END
  BRW1::KON:NOSAUKUMS = KON:NOSAUKUMS
  IF (~KON:BKK[5])
    BRW1::KON:NOSAUKUMS:NormalFG = 255
    BRW1::KON:NOSAUKUMS:NormalBG = -1
    BRW1::KON:NOSAUKUMS:SelectedFG = 255
    BRW1::KON:NOSAUKUMS:SelectedBG = -1
  ELSE
    BRW1::KON:NOSAUKUMS:NormalFG = -1
    BRW1::KON:NOSAUKUMS:NormalBG = -1
    BRW1::KON:NOSAUKUMS:SelectedFG = -1
    BRW1::KON:NOSAUKUMS:SelectedBG = -1
  END
  BRW1::KON:VAL = KON:VAL
    BRW1::KON:VAL:NormalFG = -1
    BRW1::KON:VAL:NormalBG = -1
    BRW1::KON:VAL:SelectedFG = -1
    BRW1::KON:VAL:SelectedBG = -1
  BRW1::KON:BAITS = KON:BAITS
    BRW1::KON:BAITS:NormalFG = -1
    BRW1::KON:BAITS:NormalBG = -1
    BRW1::KON:BAITS:SelectedFG = -1
    BRW1::KON:BAITS:SelectedBG = -1
  BRW1::KON_ATLIKUMS = KON_ATLIKUMS
    BRW1::KON_ATLIKUMS:NormalFG = -1
    BRW1::KON_ATLIKUMS:NormalBG = -1
    BRW1::KON_ATLIKUMS:SelectedFG = -1
    BRW1::KON_ATLIKUMS:SelectedBG = -1
  BRW1::KON:PVND_1_ = KON:PVND[1]
  BRW1::KON:PVND_2_ = KON:PVND[2]
  BRW1::KON:PVNK_1_ = KON:PVNK[1]
  BRW1::KON:PVNK_2_ = KON:PVNK[2]
  BRW1::KON:PZB_1_ = KON:PZB[1]
  BRW1::KON:PZB_2_ = KON:PZB[2]
  BRW1::KON:PZB_3_ = KON:PZB[3]
  BRW1::KON:PZB_4_ = KON:PZB[4]
  BRW1::KON:NPPF = KON:NPPF
  BRW1::KON:NPP2_1_ = KON:NPP2[1]
  BRW1::KON:NPP2_2_ = KON:NPP2[2]
  BRW1::KON:NPP2_3_ = KON:NPP2[3]
  BRW1::KON:NPP2_4_ = KON:NPP2[4]
  BRW1::KON:PKIF = KON:PKIF
  BRW1::KON:PKIP_1_ = KON:PKIP[1]
  BRW1::KON:PKIP_2_ = KON:PKIP[2]
  BRW1::KKK = KKK
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
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => UPPER(KON:BKK)
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
      KON:BKK = BRW1::Sort1:LocatorValue
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
            KON:BKK = BRW1::Sort1:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          KON:BKK = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          KON:BKK = BRW1::Sort1:LocatorValue
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
      KON:BKK = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
    IF SEND(KON_K,'QUICKSCAN=on').
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
        StandardWarning(Warn:RecordFetchError,'KON_K')
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
    IF SEND(KON_K,'QUICKSCAN=off').
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
      BRW1::HighlightedPosition = POSITION(KON:BKK_KEY)
      RESET(KON:BKK_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(KON:BKK_KEY,KON:BKK_KEY)
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
    OF 1; ?KON:BKK{Prop:Disable} = 0
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
    CLEAR(KON:Record)
    CASE BRW1::SortOrder
    OF 1; ?KON:BKK{Prop:Disable} = 1
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
    SET(KON:BKK_KEY)
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
  GET(KON_K,0)
  CLEAR(KON:Record,0)
  LocalRequest = InsertRecord
  IF COPYREQUEST=1
     DO SYNCWINDOW
     LOOP
        I#+=1
        KON:BKK[5]=CHR(VAL(KON:BKK[5])+I#)
        IF ~DUPLICATE(KON_K)
           BREAK
        ELSIF I#>5
           STOP('MEKLÇJOT SUBKONTU')
           BREAK
        .
     .
  .
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
!| (UpdateKON_K) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[3])
     EXIT
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateKON_K
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
        GET(KON_K,0)
        CLEAR(KON:Record,0)
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
  CopyRequest=0

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


UpdateKURSI_K PROCEDURE


CurrentTab           STRING(80)
ECBKURSS             DECIMAL(12,7)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
RecordFiltered       LONG
TKURSS               DECIMAL(14,10)
KKURSS               DECIMAL(14,10)
Update::Reloop  BYTE
Update::Error   BYTE
History::KUR:Record LIKE(KUR:Record),STATIC
SAV::KUR:Record      LIKE(KUR:Record)
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
QuickWindow          WINDOW('Update the KURSI_K File'),AT(0,0,155,254),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateKURSI_K'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(5,4,143,228),USE(?CurrentTab)
                         TAB('Valûtas kurss'),USE(?Tab:1)
                           LIST,AT(63,20,44,14),USE(KUR:VAL),FORMAT('12L~VAL~@s3@'),DROP(10),FROM(Queue:FileDrop)
                           PROMPT('&Valûta:'),AT(9,24),USE(?Prompt:kur:val)
                           PROMPT('&Datums:'),AT(9,39),USE(?KUR:DATUMS:Prompt)
                           ENTRY(@d06.B),AT(62,37,60,14),USE(KUR:DATUMS),RIGHT(1)
                           ENTRY(@n-15.7),AT(62,56,68,14),USE(ECBKURSS),RIGHT
                           PROMPT('&ECB Kurss:'),AT(9,58,39,10),USE(?KUR:KURSS:Prompt:2)
                           PROMPT('&Kurss:'),AT(9,73),USE(?KUR:KURSS:Prompt)
                           ENTRY(@n-15.7),AT(62,73,68,14),USE(KUR:KURSS),RIGHT(1),REQ
                           OPTION('Kursa &tips :'),AT(9,89,131,74),USE(KUR:TIPS),BOXED
                             RADIO('1 - Val./naudas vienîbu'),AT(27,100),USE(?kur:tips:Radio1)
                             RADIO('2 - Val./100 naudas vienîbâm'),AT(27,113),USE(?KUR:tips:Radio2)
                             RADIO('3 - Val./1000 naudas vienîbâm'),AT(27,124,111,10),USE(?KUR:tips:Radio3)
                             RADIO('4 - Naudas vienîbas/Val.'),AT(27,137),USE(?KUR:tips:Radio4)
                           END
                           STRING('Val=LVL; Pçc 31.12.2013 Val=EUR'),AT(20,151,119,11),USE(?String3)
                           OPTION('&Bankas kurss :'),AT(9,167,133,49),USE(KUR:LB),BOXED
                             RADIO('0 - Latvijas bankas kurss'),AT(27,183),USE(?kur:LB:Radio1)
                             RADIO('1 - Nepârbaudîts kurss'),AT(27,193),USE(?KUR:LB:Radio2)
                           END
                           STRING(@s8),AT(10,219),USE(KUR:ACC_KODS),CENTER,FONT(,,COLOR:Gray,)
                           STRING(@D06.B),AT(49,219),USE(KUR:ACC_DATUMS),FONT(,,COLOR:Gray,)
                         END
                       END
                       BUTTON('&OK'),AT(54,237,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(103,237,45,14),USE(?Cancel)
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
  ActionMessage='Aplûkoðanas reþîms'   !ja ir localrequest, sistçma pati pârrakstîs pâri
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
      SELECT(?KUR:VAL)
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
        History::KUR:Record = KUR:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(KURSI_K)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(KUR:NOS_KEY)
              IF StandardWarning(Warn:DuplicateKey,'KUR:NOS_KEY')
                SELECT(?KUR:VAL)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?KUR:VAL)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::KUR:Record <> KUR:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:KURSI_K(1)
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
              SELECT(?KUR:VAL)
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
    OF ?ECBKURSS
      CASE EVENT()
      OF EVENT:Accepted
        KUR:KURSS = 1/ECBKURSS
      END
    OF ?KUR:KURSS
      CASE EVENT()
      OF EVENT:Accepted
        ECBKURSS = 1/KUR:KURSS
        
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
        TKURSS=BANKURS(KUR:VAL,KUR:DATUMS,,1)                      !TESTAKURSS
        IF TKURSS
           CASE KUR:TIPS
           OF '1'                                         ! Ls/NV
              KKURSS=KUR:KURSS
           OF '2'                                         ! Ls/100NV
              KKURSS=KUR:KURSS/100
           OF '3'                                         ! Ls/1000NV
              KKURSS=KUR:KURSS/1000
           OF '4'                                         ! NV/LS
              KKURSS=1/KUR:KURSS
           .
           IF ~INRANGE(KKURSS,TKURSS-TKURSS/5,TKURSS+TKURSS/5) !+-20%
              KLUDA(122,'valûtas kurss '&INT((Kkurss-Tkurss)/Tkurss*100)&'% atðíirîba pret Testa kursu')
           .
        .
        KUR:acc_kods=acc_kods
        KUR:acc_datums=today()
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
  IF KURSI_K::Used = 0
    CheckOpen(KURSI_K,1)
  END
  KURSI_K::Used += 1
  BIND(KUR:RECORD)
  IF VAL_K::Used = 0
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  BIND(VAL:RECORD)
  FilesOpened = True
  RISnap:KURSI_K
  SAV::KUR:Record = KUR:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    if ~KUR:TIPS
       kur:TIPS=VAL:TIPS
    .
    IF LOCALREQUEST=1 AND KUR:VAL='EUR' AND KUR:DATUMS>DATE(1,1,2005)
       KUR:KURSS=0.702804
    .
    kur:LB='0'
    END ! BEIDZAS LocalRequest = 1
    !  IF KUR:NOMENKLAT='' AND LOCALREQUEST=3  !NESAPROTAMA CLARA KÏÛDA
    !     LocalResponse = RequestCancelled
    !     DO PROCEDURERETURN
    !  .
      IF GNET !GLOBÂLAIS TÎKLS
         CASE LOCALREQUEST
         OF 1
            KUR:GNET_FLAG[1]=1
            KUR:GNET_FLAG[2]=''
         OF 2
            IF KUR:GNET_FLAG[1]=1     !JA STÂV ADD1 (NEKUR CITUR VÇL NAV IERAKSTÎTS)
            ELSIF KUR:GNET_FLAG[1]=4  !JA STÂV ADD4 (NE VISUR IR IERAKSTÎTS)
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSIF KUR:GNET_FLAG[1]=2  !JA STÂV PUT2 (NEKUR CITUR VÇL NAV NOMAINÎTS)
            ELSIF KUR:GNET_FLAG[1]=5  !JA STÂV PUT5 (NE VISUR IR NOMAINÎTS)
               KUR:GNET_FLAG[1]=2
               KUR:GNET_FLAG[2]=''    !MAINAM VISUR
            ELSIF KUR:GNET_FLAG[1]=3 OR KUR:GNET_FLAG[1]=6  !JA STÂV DEL 
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSE
               KUR:GNET_FLAG[1]=2
               KUR:GNET_FLAG[2]=''
            .
            SAV::KUR:Record = KUR:Record ! LAI NERAKSTA, JA NEKAS NAV MAINÎTS
         OF 3
    !        STOP(KUR:GNET_FLAG)
            IF KUR:GNET_FLAG[1]=1     !JA STÂV ADD1 (NEKUR CITUR VÇL NAV IERAKSTÎTS)
               KUR:GNET_FLAG=''
            ELSIF KUR:GNET_FLAG[1]=4  !JA STÂV ADD4 (NE VISUR IR IERAKSTÎTS)
               KLUDA(121,'dzçst, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSIF KUR:GNET_FLAG[1]=2  !JA STÂV PUT2 (NEKUR CITUR VÇL NAV NOMAINÎTS)
               KUR:GNET_FLAG[1]=3
               LOCALREQUEST=4
            ELSIF KUR:GNET_FLAG[1]=5  !JA STÂV PUT5 (NE VISUR IR NOMAINÎTS)
               KUR:GNET_FLAG[1]=3     !DZÇÐAM VISUR
               KUR:GNET_FLAG[2]=''
               LOCALREQUEST=4
            ELSIF KUR:GNET_FLAG[1]=3 OR KUR:GNET_FLAG[1]=6  !JA STÂV DEL
               KLUDA(121,'I/O, kamçr nav pabeigta tîklu sinhronizâcija')
               LOCALREQUEST=0
            ELSE
               KUR:GNET_FLAG[1]=3
               KUR:GNET_FLAG[2]=''
               LOCALREQUEST=4
            .
         .
      .
      IF LocalRequest = 4 ! DeleteRecord GNET
        IF StandardWarning(Warn:StandardDelete) = Button:OK
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            IF RIUPDATE:KURSI_K()
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
        IF RIDelete:KURSI_K()
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
  ECBKURSS = 1/KUR:KURSS
  
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('UpdateKURSI_K','winlats.INI')
  WinResize.Resize
  ?KUR:VAL{PROP:Alrt,255} = 734
  ?KUR:DATUMS{PROP:Alrt,255} = 734
  ?KUR:KURSS{PROP:Alrt,255} = 734
  ?KUR:TIPS{PROP:Alrt,255} = 734
  ?KUR:LB{PROP:Alrt,255} = 734
  ?KUR:ACC_KODS{PROP:Alrt,255} = 734
  ?KUR:ACC_DATUMS{PROP:Alrt,255} = 734
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
    KURSI_K::Used -= 1
    IF KURSI_K::Used = 0 THEN CLOSE(KURSI_K).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
  END
  IF WindowOpened
    INISaveWindow('UpdateKURSI_K','winlats.INI')
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
    OF ?KUR:VAL
      KUR:VAL = History::KUR:Record.VAL
    OF ?KUR:DATUMS
      KUR:DATUMS = History::KUR:Record.DATUMS
    OF ?KUR:KURSS
      KUR:KURSS = History::KUR:Record.KURSS
    OF ?KUR:TIPS
      KUR:TIPS = History::KUR:Record.TIPS
    OF ?KUR:LB
      KUR:LB = History::KUR:Record.LB
    OF ?KUR:ACC_KODS
      KUR:ACC_KODS = History::KUR:Record.ACC_KODS
    OF ?KUR:ACC_DATUMS
      KUR:ACC_DATUMS = History::KUR:Record.ACC_DATUMS
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
  KUR:Record = SAV::KUR:Record
  SAV::KUR:Record = KUR:Record
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
  SET(VAL_K)
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
    SORT(Queue:FileDrop,FLD5::VAL:VAL)
    IF KUR:VAL
      LOOP FLD5::LoopIndex = 1 TO RECORDS(Queue:FileDrop)
        GET(Queue:FileDrop,FLD5::LoopIndex)
        IF KUR:VAL = FLD5::VAL:VAL THEN BREAK.
      END
      ?KUR:VAL{Prop:Selected} = FLD5::LoopIndex
    END
  ELSE
    CLEAR(KUR:VAL)
  END
