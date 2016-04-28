                     MEMBER('winlats.clw')        ! This is a MEMBER module
BROWSEGG1_MU PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
DOK_SK               USHORT
KONT_SK              USHORT
LIST1:QUEUE          QUEUE,PRE()
AVOTS1               STRING(20)
                     END
LIST2:QUEUE          QUEUE,PRE()
AVOTS2               STRING(20)
                     END
MAINFOLDER           STRING(30)
MAINFILE             STRING(20)
STRINGBYTE           STRING(8)
SAV_PAR_NR           ULONG
MODE                 BYTE(1)
!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------

Auto::Attempts       LONG,AUTO
Auto::Save:GG:U_NR   LIKE(GG:U_NR)

ES                   DECIMAL(1)
Process              STRING(35)
DELTA                DECIMAL(11,2)
DELTAV               DECIMAL(11,2)
DOKSUMMA             DECIMAL(11,2)
JAAEXP               BYTE
BKK                  STRING(5)
NODALA               STRING(2)
OBJ_NR               USHORT
KK                   BYTE
SAV_VAL              STRING(3)

Askscreen WINDOW('Bankas izraksta imports'),AT(,,159,99),CENTER,GRAY
       STRING('Importçt visus dokumentus'),AT(10,12),USE(?String1)
       SPIN(@D06.B),AT(24,26,48,12),USE(s_dat),IMM
       SPIN(@d06.B),AT(94,26,48,12),USE(B_DAT),IMM
       STRING('kam ES='),AT(17,44),USE(?String4)
       ENTRY(@n1B),AT(47,43),USE(ES),CENTER
       STRING('un Y='),AT(69,44),USE(?string:RS),HIDE
       ENTRY(@S1),AT(91,43),USE(RS),HIDE,CENTER
       STRING(@s35),AT(11,60),USE(process)
       STRING('lîdz'),AT(78,27),USE(?String3)
       STRING('no'),AT(11,28),USE(?String2)
       BUTTON('&OK'),AT(71,76,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(113,76,36,14),USE(?CancelButton)
     END

PROGRESSS  BYTE
ProcessScreen WINDOW(' '),AT(,,150,38),CENTER,GRAY
       STRING('Bûvçju bankas dokumenti...'),AT(8,11),USE(?String1111),FONT(,,,FONT:bold)
       STRING(@s35),AT(8,19),USE(process,,?PROCESS:A),LEFT
     END




BRW1::View:Browse    VIEW(G1)
                       PROJECT(G1:RS)
                       PROJECT(G1:ES)
                       PROJECT(G1:DOK_SENR)
                       PROJECT(G1:ATT_DOK)
                       PROJECT(G1:DATUMS)
                       PROJECT(G1:NOKA)
                       PROJECT(G1:SATURS)
                       PROJECT(G1:SATURS2)
                       PROJECT(G1:SUMMA)
                       PROJECT(G1:VAL)
                       PROJECT(G1:U_NR)
                       PROJECT(G1:PAR_NR)
                       PROJECT(G1:SECIBA)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::G1:RS            LIKE(G1:RS)                ! Queue Display field
BRW1::G1:ES            LIKE(G1:ES)                ! Queue Display field
BRW1::G1:DOK_SENR      LIKE(G1:DOK_SENR)          ! Queue Display field
BRW1::G1:ATT_DOK       LIKE(G1:ATT_DOK)           ! Queue Display field
BRW1::G1:DATUMS        LIKE(G1:DATUMS)            ! Queue Display field
BRW1::G1:NOKA          LIKE(G1:NOKA)              ! Queue Display field
BRW1::G1:SATURS        LIKE(G1:SATURS)            ! Queue Display field
BRW1::G1:SATURS2       LIKE(G1:SATURS2)           ! Queue Display field
BRW1::G1:SUMMA         LIKE(G1:SUMMA)             ! Queue Display field
BRW1::G1:VAL           LIKE(G1:VAL)               ! Queue Display field
BRW1::G1:U_NR          LIKE(G1:U_NR)              ! Queue Display field
BRW1::SAV_PAR_NR       LIKE(SAV_PAR_NR)           ! Queue Display field
BRW1::G1:PAR_NR        LIKE(G1:PAR_NR)            ! Queue Display field
BRW1::ATLAUTS          LIKE(ATLAUTS)              ! Queue Display field
BRW1::G1:SECIBA        LIKE(G1:SECIBA)            ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort2:KeyDistribution LIKE(G1:DATUMS),DIM(100)
BRW1::Sort2:LowValue LIKE(G1:DATUMS)              ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(G1:DATUMS)             ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Bankas izrakstu imports'),AT(0,0,441,288),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BROWSEGG1'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(9,21,422,246),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('10C|M~Y~@n1B@12C|M~ES~@n1B@48C|M~Dok. Nr.~@s14@10C|M~A~@S1@43R(1)|M~Datums~C(0)@' &|
   'D06.@61L(1)|M~Partneris~@s15@128L(1)|M~Saturs~@s45@188L(1)|M~SATURS2~@s47@52D(12' &|
   ')M~Summa~C(0)@n-15.2@12L(1)|M~Val~@s3@28R(1)|M~U NR~L@n_7.0@'),FROM(Queue:Browse:1)
                       SHEET,AT(4,-2,435,290),USE(?CurrentTab)
                         TAB('Bankas izraksts'),USE(?Tab:2)
                           BUTTON('&ES'),AT(19,270,17,14),USE(?ButtonES)
                           BUTTON('&Kontçjums'),AT(41,270,45,14),USE(?kontejums)
                         END
                         TAB('Partneris'),USE(?Tab2)
                           BUTTON('&Partneris'),AT(89,270,45,14),USE(?ButtonPARTNERIS)
                         END
                       END
                       BUTTON('I&mportçt apgabalu'),AT(140,270,73,14),USE(?ImpApgabalu)
                       BUTTON('Importçt izvçlçto &rakstu'),AT(217,270,86,14),USE(?impRakstu)
                       BUTTON('&Beigt'),AT(363,270,45,14),USE(?Close)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  FILENAME1=CLIP(LONGPATH())&'\GGBANKA.TPS'
  FILENAME2=CLIP(LONGPATH())&'\GGKBANKA.TPS'
  F:DTK=''
  !STOP(FILENAME1)
  !STOP(FILENAME2)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  quickWindow{PROP:TEXT}='Datu avots :'&filename1
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
      sav_par_nr=g1:par_nr  !TIKAI KONKRÇTO TAB_U NEVAR PÂRÍERT
    OF ?ButtonES
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           EXECUTE G1:ES+1
              G1:ES=1
              G1:ES=2
              G1:ES=0
           .
           IF RIUPDATE:G1()
              KLUDA(24,'G1')
           .
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
      END
    OF ?kontejums
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        BROWSEGGK1 
        LocalRequest = OriginalRequest
        DO RefreshWindow
      END
    OF ?ButtonPARTNERIS
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           sav_par_nr=PAR:U_NR
           BRW1::LocateMode = LocateOnEdit
           DO BRW1::LocateRecord
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
        .
      END
    OF ?ImpApgabalu
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPEN(ASKSCREEN)
        IF ATLAUTS[1]
           UNHIDE(?String:RS)
           UNHIDE(?RS)
        END
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF ?OkButton
              CASE EVENT()
              OF EVENT:Accepted
                 DO SyncWindow
                 DOK_SK=0
                 KONT_SK=0
                 FIRST#=1
                 PROCESS='Nav atrasts neviens dokuments...'
                 display(?process)
                 CLEAR(G1:RECORD)
                 G1:DATUMS=B_DAT
                 G1:SECIBA=999999999
                 SET(G1:DAT_KEY,G1:DAT_KEY)
                 LOOP
                    NEXT(G1)
                    IF ERROR() OR G1:DATUMS < S_DAT THEN BREAK.
                    IF G1:U_NR=1 THEN CYCLE.
                    IF ~(ES=G1:ES) THEN CYCLE.
                    IF ~(RS=G1:RS) THEN CYCLE.
                    DO AUTONUMBER
                    GG:RECORD=G1:RECORD
                    GG:U_NR=Auto::Save:GG:U_NR
                    GG:SECIBA=CLOCK()
                    CLEAR(GK1:RECORD)
                    GK1:U_NR=G1:U_NR
                    SET(GK1:NR_KEY,GK1:NR_KEY)
                    STRINGBYTE=''
                    DO WRITEGGK
                 !   GG:IMP_NR=CON_NR
                    GG:TIPS=0
                    LOOP B#=1 TO 8
                      IF STRINGBYTE[9-B#]
                         GG:TIPS+=2^(B#-1)
                      .
                    .
                    IF RIUPDATE:GG()
                       KLUDA(24,'GG')
                    ELSE
                       DOK_SK+=1
                       PROCESS='Kopâ: '&CLIP(DOK_SK)&' dokumenti '&clip(kont_sk)&' kontçjumi'
                       display(?process)
                       G1:ES=1
                       IF RIUPDATE:G1()
                          KLUDA(24,'G1')
                       .
                    .
                 .
                 ?CancelButton{prop:text}='Beigt'
                 HIDE(?OKBUTTON)
                 DISPLAY
              .
           OF ?CancelButton
              CASE EVENT()
              OF EVENT:Accepted
                 IF DOK_SK
                    LOCALRESPONSE=REQUESTCOMPLETED
                 ELSE
                    LOCALRESPONSE=REQUESTCANCELLED
                 .
                 break
              END
           END
        .
        CLOSE(ASKSCREEN)
        BRW1::RefreshMode = RefreshOnQueue
        DO BRW1::RefreshPage
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
      END
    OF ?impRakstu
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        ! importçt izvçlçto rakstu
        
        DO AUTONUMBER
        GG:RECORD=G1:RECORD
        GG:U_NR=Auto::Save:GG:U_NR
        GG:SECIBA=CLOCK()
        KONT_SK=0
        CLEAR(GK1:RECORD)
        GK1:U_NR=G1:U_NR
        SET(GK1:NR_KEY,GK1:NR_KEY)
        DO WRITEGGK
        PUT(GG)
        IF ERROR()
           STOP('GG: '&ERROR())
        ELSE
           DOK_SK=1
           KLUDA(7,CLIP(DOK_SK)&' dokuments '&clip(kont_sk)&' kontçjumi',,1)
           G1:ES=1
           PUT(G1)
        .
        
        BRW1::RefreshMode = RefreshOnQueue
        DO BRW1::RefreshPage
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
        IF DOK_SK
           LOCALRESPONSE=REQUESTCOMPLETED
        .
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF DAIEV::Used = 0
    CheckOpen(DAIEV,1)
  END
  DAIEV::Used += 1
  BIND(DAI:RECORD)
  IF G1::Used = 0
    CheckOpen(G1,1)
  END
  G1::Used += 1
  BIND(G1:RECORD)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  IF GK1::Used = 0
    CheckOpen(GK1,1)
  END
  GK1::Used += 1
  BIND(GK1:RECORD)
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  BIND(KAD:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BROWSEGG1_MU','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('SAV_PAR_NR',SAV_PAR_NR)
  BIND('ATLAUTS',ATLAUTS)
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
    DAIEV::Used -= 1
    IF DAIEV::Used = 0 THEN CLOSE(DAIEV).
    G1::Used -= 1
    IF G1::Used = 0 THEN CLOSE(G1).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    GK1::Used -= 1
    IF GK1::Used = 0 THEN CLOSE(GK1).
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
  END
  IF WindowOpened
    INISaveWindow('BROWSEGG1_MU','winlats.INI')
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
!-----------------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ REÂLO GG
  Auto::Attempts = 0
  LOOP
    SET(GG:NR_KEY)
    PREVIOUS(GG)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GG')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:GG:U_NR = 1
    ELSE
      Auto::Save:GG:U_NR = GG:U_NR + 1
    END
    clear(GG:Record)
    GG:DATUMS=b_dat
    GG:U_NR = Auto::Save:GG:U_NR
    ADD(GG)
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


!-----------------------------------------------------------------------------------------------------
WRITEGGK ROUTINE   !LASOT IMPINT UZ REÂLO GGK

   GG:SUMMA=0
   LOOP
      NEXT(GK1)
!      STOP(GK1:BKK&'-'&GK1:U_NR&'='&G1:U_NR&ERROR())
      IF ERROR() OR ~(GK1:U_NR=G1:U_NR)
         BREAK
      .
      GGK:RECORD=GK1:RECORD
      GGK:U_NR=GG:U_NR
      IF GGK:D_K='D'
         GG:SUMMA+=GGK:SUMMA
      .
      ADD(GGK)
!      STOP(GK1:KK&'='&GGK:KK)
      IF ERROR()
         STOP('ADD GGK:'&ERROR())
      ELSE
         KONT_SK+=1
         !***********SASKAITAM kasi/banku/AV/231/531*******
         IF GGK:BKK[1:3]='261'     ! KASE
           STRINGBYTE[8]='1'
         ELSIF GGK:BKK[1:3]='262'  ! BANKA
           STRINGBYTE[7]='1'
         ELSIF GGK:BKK[1:3]='238'  ! AVANSIERI
           STRINGBYTE[6]='1'
         ELSIF GGK:BKK[1:3]='231'  ! 231..
           STRINGBYTE[5]='1'
         ELSIF GGK:BKK[1:3]='531'  ! 531..
           STRINGBYTE[4]='1'
         .
         IF PROGRESSS=TRUE  !ATVÇRTS PROGRESSSCREEN
            ?String1111{PROP:TEXT}='GGK : '&kont_sk
            DISPLAY
         .
      .
   .

!-----------------------------------------------------------------------------------------------------
BUILDNOLIK ROUTINE   ! BÛVÇJAM NOLIKTAVAS GG(G1) UN GGK(GK1)

 DONE#=0
 close(G1)
 OPEN(G1,18)
 IF ERROR()
   kluda(1,FILENAME1)
   CHECKOPEN(G1,1)
   EXIT
 .
 EMPTY(g1)
 IF ERROR() THEN STOP('EMPTY G1 '&ERROR()).
 close(GK1)
 OPEN(GK1,18)
 IF ERROR()
   kluda(1,FILENAME2)
   CHECKOPEN(GK1,1)
   EXIT
 .
 EMPTY(GK1)
 IF ERROR() THEN STOP('EMPTY GK1 '&ERROR()).

 CLEAR(PAV:RECORD)
 PAV:DATUMS=B_DAT  !LAI NOSTÂJAS UZ PIRMO(AUGSTÂKO IERAKSTU)
 PAV:D_K='W'
 SET(PAV:DAT_KEY,PAV:DAT_KEY)
 LOOP
    NEXT(PAVAD)
    IF ERROR() OR PAV:DATUMS<S_DAT THEN BREAK.
    IF ~INSTRING(PAV:D_K,'DK') THEN CYCLE.
    IF PAV:U_NR=1 THEN CYCLE.                 !SALDO NEEKSPORTÇ
    IF INRANGE(PAV:PAR_NR,1,25) THEN CYCLE.   !INTERNÂLU KUSTÎBU NEEKSPORTÇ
    IF INRANGE(PAV:PAR_NR,26,50) THEN CYCLE.  !RAÞOÐANU NEEKSPORTÇ
    PAV#+=1
    JAAEXP=TRUE          ! BÛVÇT
    IF PAV:EXP=1         ! RAKSTS JAU IR EXPORTÇTS
       KLUDA(118,FORMAT(PAV:DATUMS,@D06.1)&' Nr='&CLIP(PAV:DOK_SENR)&' S='&PAV:SUMMA&' '&PAV:VAL,,1)
       IF ~KLU_DARBIBA
          JAAEXP=FALSE   ! IZLAIST ÐO
       .
    .
    IF JAAEXP
       IF PAV:EXP=0
          PAV:EXP=1
          IF RIUPDATE:PAVAD()
             KLUDA(24,'PAVAD')
          .
       .
       IF PAV:MAK_NR
          PAR_NR=PAV:MAK_NR
       ELSE
          PAR_NR=PAV:PAR_NR
       .
       DELTA=0

!---------------------------------------
       BuildGGKTable(1)
!---------------------------------------
       CLEAR(G1:RECORD)
       G1:ES=1
       G1:RS=PAV:RS
       G1:IMP_NR=LOC_NR
       G1:U_NR=PAV:U_NR           !IZMANTOJAM P/Z U_NR
       G1:DOK_SENR=PAV:DOK_SENR
       IF GADS>2009
          G1:ATT_DOK='1'  !NODOKÏA RÇÍINS
       ELSE
          IF UPPER(G1:DOK_SENR[1:3])='REK' !RÇÍINS
             G1:ATT_DOK='6'
          ELSE                             !P/Z
             G1:ATT_DOK='2'
          .
       .
       G1:DATUMS=PAV:DATUMS
       G1:DOKDAT=PAV:DOKDAT
       IF PAV:C_DATUMS            !16/11/99
          G1:APMDAT=PAV:C_DATUMS  !10/05/99
       ELSE
          G1:APMDAT=PAV:DATUMS
       .
       G1:NOKA=PAV:NOKA
       G1:PAR_NR=PAR_NR
       CASE PAV:D_K
       OF 'D'
          IF PAV:SUMMA >= 0
             G1:SATURS='Saòemts  -'&CLIP(SYS:AVOTS) &': '& PAV:PAMAT
          ELSE
             G1:SATURS='Atgriezta prece -'&CLIP(SYS:AVOTS)
          .
       OF 'K'
          IF PAV:D_K='R'
             G1:SATURS='Norakstîts -'&CLIP(SYS:AVOTS) &': '& PAV:PAMAT
          ELSE
             IF PAV:SUMMA >= 0
                G1:SATURS='Realizçts -'&CLIP(SYS:AVOTS) &': '& PAV:PAMAT
             ELSE
                G1:SATURS='Atgriezts -'&CLIP(SYS:AVOTS)
             .
          .
       OF 'I' !???
          G1:SATURS='Inventar.-'&CLIP(SYS:AVOTS) &': '& PAV:PAMAT
       .
       G1:summa =ABS(PAV:summa)
       G1:VAL   =PAV:VAL
       G1:ACC_DATUMS =TODAY()
       G1:ACC_KODS=ACC_KODS
       ADD(G1)
       IF ERROR()
          KLUDA(24,G1:U_NR&FILENAME1)
       ELSE
          DO WRITEGK1
       .
    .
 .
 close(g1)
 close(gk1)
 checkopen(g1,1)
 checkopen(gk1,1)

!-----------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------
WRITEGK1 ROUTINE

    DELTA_P#=0
    DELTA=0
    DELTAV=0
    DOKSUMMA=0
    MULTIVALUTAS#=FALSE
    LOOP J#=1 TO RECORDS(ggK_TABLE)   
       GET(GGK_TABLE,J#)
       IF J#=1
          SAV_VAL=GGT:VAL
       ELSIF ~(SAV_VAL=GGT:VAL)
          MULTIVALUTAS#=TRUE          !DAÞÂDAS VALÛTAS
       .
       GGT:SUMMA=ROUND(GGT:SUMMA,.01)
       GGT:SUMMAV=ROUND(GGT:SUMMAV,.01)
       IF GGT:BKK[1:2]='21' OR GGT:BKK[1]='6' OR GGT:BKK[1:2]='74' !UZ ÐITIEM VAR NOGRÛST MAZU DELTU
          DELTA_P#=J#
       .
       CASE GGT:D_K
       OF 'D'
          DELTA+=GGT:SUMMA
          DELTAV+=GGT:SUMMAV
       ELSE
          DELTA-=GGT:SUMMA
          DELTAV-=GGT:SUMMAV
       .
    .
    LOOP J#=1 TO RECORDS(ggK_TABLE)
       GET(GGK_TABLE,J#)
       GGT:SUMMA=ROUND(GGT:SUMMA,.01)
       GGT:SUMMAV=ROUND(GGT:SUMMAV,.01)
       IF MULTIVALUTAS#=FALSE AND INRANGE(DELTAV,-0.03,0.03) AND J#=DELTA_P# !TIEKAM VAÏÂ NO DELTAS
          CASE GGT:D_K
          OF 'D'
             GGT:SUMMA-=DELTA
             GGT:SUMMAV-=DELTAV
          ELSE
             GGT:SUMMA+=DELTA
             GGT:SUMMAV+=DELTAV
          .
          DELTA_P#=0
          DELTA=0
          DELTAV=0
       ELSIF MULTIVALUTAS#=TRUE AND INRANGE(DELTA,-0.03,0.03) AND J#=DELTA_P# !TIEKAM VAÏÂ NO DELTAS
          CASE GGT:D_K
          OF 'D'
             GGT:SUMMA-=DELTA
             GGT:SUMMAV=GGT:SUMMA    !TIE VIENMÇR BÛS Ls
          ELSE
             GGT:SUMMA+=DELTA
             GGT:SUMMAV=GGT:SUMMA    !TIE VIENMÇR BÛS Ls
          .
          DELTA_P#=0
          DELTA=0
          DELTAV=0  
       .
       CLEAR(gk1:RECORD)
       gk1:U_NR     = G1:U_NR
       gk1:RS       = G1:RS
       gk1:DATUMS   = G1:DATUMS
       IF INRANGE(JOB_NR,66,95) !ALGAS,PL
          gk1:PAR_NR= 0
       ELSE
          gk1:PAR_NR= PAR_NR
       .
       GK1:REFERENCE= GGT:REFERENCE
       GK1:NODALA   = GGT:NODALA
       GK1:OBJ_NR   = GGT:OBJ_NR
       gk1:SUMMA    = GGT:SUMMA
       gk1:SUMMAV   = GGT:SUMMAV
       gk1:BKK      = GGT:BKK
       gk1:D_K      = GGT:D_K
       gk1:VAL      = GGT:VAL
       gk1:KK       = GGT:KK
       gk1:PVN_PROC = GGT:PVN_PROC
       gk1:PVN_TIPS = GGT:PVN_TIPS  !PVN TIPS
       ADD(GK1)
       IF GK1:D_K='D'
          DOKSUMMA+=GK1:SUMMA
       .
    .
    IF DELTA
       CLEAR(GK1:RECORD)
       gk1:U_NR   = G1:U_NR
       gk1:RS     = G1:RS
       gk1:DATUMS = G1:DATUMS
       gk1:PAR_NR = 0
       gk1:SUMMA  = ABS(DELTA)
       IF MULTIVALUTAS#=FALSE
          gk1:SUMMAV = ABS(DELTAV)
       ELSE
          gk1:SUMMAV = ABS(DELTA)
       .
       gk1:BKK    = 'DELTA'
       IF DELTA>0
          gk1:D_K = 'K'
       ELSE
          gk1:D_K = 'D'
       .
       GK1:VAL    = GGT:VAL
       ADD(gK1)
       IF ERROR() THEN STOP(ERROR()).
    .
    FREE(GGK_TABLE)

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
  IF CHOICE(?CURRENTTAB)=2
    BRW1::SortOrder = 1
  ELSE
    BRW1::SortOrder = 2
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
      StandardWarning(Warn:RecordFetchError,'G1')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:HighValue = G1:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'G1')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:LowValue = G1:DATUMS
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
  G1:RS = BRW1::G1:RS
  G1:ES = BRW1::G1:ES
  G1:DOK_SENR = BRW1::G1:DOK_SENR
  G1:ATT_DOK = BRW1::G1:ATT_DOK
  G1:DATUMS = BRW1::G1:DATUMS
  G1:NOKA = BRW1::G1:NOKA
  G1:SATURS = BRW1::G1:SATURS
  G1:SATURS2 = BRW1::G1:SATURS2
  G1:SUMMA = BRW1::G1:SUMMA
  G1:VAL = BRW1::G1:VAL
  G1:U_NR = BRW1::G1:U_NR
  SAV_PAR_NR = BRW1::SAV_PAR_NR
  G1:PAR_NR = BRW1::G1:PAR_NR
  ATLAUTS = BRW1::ATLAUTS
  G1:SECIBA = BRW1::G1:SECIBA
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
  BRW1::G1:RS = G1:RS
  BRW1::G1:ES = G1:ES
  BRW1::G1:DOK_SENR = G1:DOK_SENR
  BRW1::G1:ATT_DOK = G1:ATT_DOK
  BRW1::G1:DATUMS = G1:DATUMS
  BRW1::G1:NOKA = G1:NOKA
  BRW1::G1:SATURS = G1:SATURS
  BRW1::G1:SATURS2 = G1:SATURS2
  BRW1::G1:SUMMA = G1:SUMMA
  BRW1::G1:VAL = G1:VAL
  BRW1::G1:U_NR = G1:U_NR
  BRW1::SAV_PAR_NR = SAV_PAR_NR
  BRW1::G1:PAR_NR = G1:PAR_NR
  BRW1::ATLAUTS = ATLAUTS
  BRW1::G1:SECIBA = G1:SECIBA
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
      CASE BRW1::SortOrder
      OF 1
      OF 2
        LOOP BRW1::CurrentScroll = 100 TO 1 BY -1
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => G1:DATUMS
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
    CASE BRW1::SortOrder
    OF 2
      G1:DATUMS = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'G1')
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
      BRW1::HighlightedPosition = POSITION(G1:DAT_KEY)
      RESET(G1:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(G1:DAT_KEY,G1:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(g1:par_nr=sav_par_nr AND ~(G1:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(G1:DAT_KEY)
      RESET(G1:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(G1:DAT_KEY,G1:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~(G1:RS=''1''  AND  ATLAUTS[18]=''1''))'
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
    CLEAR(G1:Record)
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
    SET(G1:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(g1:par_nr=sav_par_nr AND ~(G1:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 2
    SET(G1:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~(G1:RS=''1''  AND  ATLAUTS[18]=''1''))'
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

