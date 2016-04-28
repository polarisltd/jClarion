                     MEMBER('winlats.clw')        ! This is a MEMBER module
BROWSEGG1 PROCEDURE


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

Askscreen WINDOW('Datu imports'),AT(,,159,99),CENTER,GRAY
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

BUILDscreen WINDOW('Uzbûvçt importa interfeisu :'),AT(,,168,76),CENTER,GRAY
       SPIN(@d06.B),AT(24,11,48,12),USE(s_dat,,?s_dat:1)
       SPIN(@d06.B),AT(94,11,48,12),USE(B_DAT,,?b_dat:1)
       STRING('kam Y='),AT(10,29,27,10),USE(?string:RS:1),HIDE
       ENTRY(@S1),AT(39,28),USE(RS,,?rs:1),HIDE,CENTER
       BUTTON('Uzbûvçt DBF'),AT(63,27,57,14),USE(?Buttondbf)
       IMAGE('CHECK3.ICO'),AT(126,26,16,17),USE(?ImageDBF),HIDE
       STRING(@s35),AT(11,43),USE(process,,?process2)
       STRING('lîdz'),AT(78,12),USE(?String13)
       STRING('no'),AT(11,13),USE(?String12)
       BUTTON('&OK'),AT(77,54,35,14),USE(?OkButton2),DEFAULT
       BUTTON('Atlikt'),AT(119,54,36,14),USE(?CancelButton2)
     END

SourceScreen WINDOW('Norâdiet datu avotu'),AT(,,185,79),GRAY
       LIST,AT(22,15),USE(avots1),VSCROLL,DROP(10),FROM(List1:Queue)
       LIST,AT(101,15),USE(avots2),VSCROLL,DROP(10),FROM(List2:Queue)
       ENTRY(@s20),AT(22,32,66,12),USE(AVOTS1,,?AVOTS1:2),HIDE
       STRING(@s40),AT(22,47),USE(FILENAME1)
       BUTTON('&OK'),AT(106,60,35,14),USE(?Ok1),DEFAULT
       BUTTON('Atlikt'),AT(145,60,36,14),USE(?Cancel1)
     END

MODE_SCREEN WINDOW('Uzbûvçt importa interfeisu :'),AT(,,160,70),CENTER,GRAY
       OPTION('Darba veids'),AT(7,5,144,36),USE(MODE),BOXED
         RADIO('1-Nolietojums'),AT(12,14),USE(?MODE:1),VALUE('1')
         RADIO('2-Noòemðana'),AT(12,25,56,10),USE(?MODE:2),VALUE('2')
       END
       STRING('Datums:'),AT(69,25),USE(?Stringb_dat),HIDE !       SPIN(@d06.B),AT(98,22,48,12),USE(B_DAT,,?b_dat:4),HIDE
       SPIN(@d06.B),AT(98,24,48,12),USE(B_DAT),HIDE
       BUTTON('&OK'),AT(73,47,35,14),USE(?OkButton4),DEFAULT
       BUTTON('Atlikt'),AT(115,47,36,14),USE(?CancelButton4)
     END

PROGRESSS  BYTE
ProcessScreen WINDOW(' '),AT(,,150,38),CENTER,GRAY
       STRING('Bûvçju importa interfeisu...'),AT(8,11),USE(?String1111),FONT(,,,FONT:bold)
       STRING(@s35),AT(8,19),USE(process,,?PROCESS:A),LEFT
     END


GD                      FILE,DRIVER('DBASE3'),NAME(FPPAVADNAME),PRE(GD),CREATE
Record                    RECORD,PRE()
U_NR                        STRING(@N_10)
RS                          STRING(1)
ES                          STRING(1)
DOK_SENR                    STRING(14)
ATT_DOK                     STRING(1)
APMDAT                      STRING(@D12)
DOKDAT                      STRING(@D12)
DATUMS                      STRING(@D12)
NOKA                        STRING(15)
PARREGNR                    STRING(@N_11)
SATURS                      STRING(45)
SUMMA                       STRING(@N_11.2)
VAL                         STRING(3)
ACC_KODS                    STRING(8)
ACC_DAT                     STRING(@D12)
                         END
                       END

GKD                    FILE,DRIVER('DBASE3'),NAME(FPNOLIKNAME),PRE(GKD),CREATE
Record                   RECORD,PRE()
U_NR                        STRING(@N_10)
BKK                         STRING(5)
D_K                         STRING(1)
SUMMA                       STRING(@N_11.2)
SUMMAV                      STRING(@N_11.2)
VAL                         STRING(3)
PVN_PROC                    STRING(2)
PVN_TIPS                    STRING(1)
NODALA                      STRING(2)
Obj_nr                      STRING(@N_6)
                         END
                      END


BRW1::View:Browse    VIEW(G1)
                       PROJECT(G1:RS)
                       PROJECT(G1:ES)
                       PROJECT(G1:DOK_SENR)
                       PROJECT(G1:ATT_DOK)
                       PROJECT(G1:DATUMS)
                       PROJECT(G1:NOKA)
                       PROJECT(G1:SATURS)
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
QuickWindow          WINDOW('Importa interfeiss'),AT(0,0,441,288),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BROWSEGG1'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(9,21,422,246),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('10C|M~Y~@n1B@12C|M~ES~@n1B@48C|M~Dok. Nr.~@s14@10C|M~A~@S1@43R(1)|M~Datums~C(0)@' &|
   'D06.@61L(1)|M~Partneris~@s15@128L(1)|M~Saturs~@s45@52D(12)M~Summa~C(0)@n-15.2@12' &|
   'L(1)|M~Val~@s3@28R(1)|M~U NR~L@n_7.0@'),FROM(Queue:Browse:1)
                       SHEET,AT(4,-2,435,290),USE(?CurrentTab)
                         TAB('Importa intrefeiss'),USE(?Tab:2)
                           BUTTON('&ES'),AT(19,270,17,14),USE(?ButtonES)
                           BUTTON('&Kontçjums'),AT(41,270,45,14),USE(?kontejums)
                           BUTTON('&Pârbûvçt'),AT(91,270,45,14),USE(?Parbuvet)
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
  IF INRANGE(JOB_NR,1,15) AND F:DTK='1'  !BÂZÇ LASAM BRIO
     FILENAME1=CLIP(LONGPATH())&'\GGBR.TPS'
     FILENAME2=CLIP(LONGPATH())&'\GGKBR.TPS'
  ELSIF INRANGE(JOB_NR,1,15) AND F:DTK='2' !BÂZÇ LASAM APMAIÒAS TXT
     FILENAME1=CLIP(LONGPATH())&'\GGTX.TPS'
     FILENAME2=CLIP(LONGPATH())&'\GGKTX.TPS'
  ELSIF INRANGE(JOB_NR,1,15)   !BÂZE
     MAINFOLDER=LONGPATH()
     I#=INSTRING('\',MAINFOLDER,1,9)+1
     J#=LEN(CLIP(MAINFOLDER))
     IF J#>I#
        avots1=MAINFOLDER[I#:J#]
        ADD(LIST1:QUEUE)
        MAINFOLDER=MAINFOLDER[1:I#-1] !AR \
     .
     avots1='WL200'&CLIP(DB_GADS-2000-1)
     ADD(LIST1:QUEUE)
     avots1='Cits'
     ADD(LIST1:QUEUE)
     IF CL_NR=1033 !KIPSALA
        avots1='WL200'&CLIP(DB_GADS-2000)&'MEZ'
        ADD(LIST1:QUEUE)
     .
     GET(LIST1:QUEUE,1) !Nostâjamies tekoðo MAPI
  
     LOOP I#= 1 TO BASE_SK
        AVOTS2='Bâze      '&FORMAT(I#,@N02)
        ADD(LIST2:QUEUE)
     .
     LOOP I#= 1 TO NOL_SK
        AVOTS2='Noliktava '&FORMAT(I#,@N02)
        ADD(LIST2:QUEUE)
     .
     LOOP I#= 1 TO ALGU_SK
        AVOTS2='Alga      '&FORMAT(I#,@N02)
        ADD(LIST2:QUEUE)
     .
     LOOP I#= 1 TO PAM_SK
        AVOTS2='Pamatlîdz.'&FORMAT(I#,@N02)
        ADD(LIST2:QUEUE)
     .
     GET(LIST2:QUEUE,BASE_SK+1) !Nostâjamies uz 1. Noliktavu/ALGU/PL
  
     IF AVOTS2[1]='B'
        MAINFILE='\GG'&AVOTS2[11:12]&'.TPS'
     ELSIF AVOTS2[1]='N'
        MAINFILE='\GG'&AVOTS2[11:12]+15&'.TPS'
     ELSIF AVOTS2[1]='A'
        MAINFILE='\GG'&AVOTS2[11:12]+65&'.TPS'
     ELSIF AVOTS2[1]='P'
        MAINFILE='\GG'&AVOTS2[11:12]+80&'.TPS'
     .
     FILENAME1=CLIP(MAINFOLDER)&CLIP(avots1)&CLIP(MAINFILE)
     OPEN(SourceScreen)
     display
     ACCEPT
        CASE FIELD()
        OF ?AVOTS1
           CASE EVENT()
           OF EVENT:ACCEPTED
              UNHIDE(?AVOTS2)
              CASE AVOTS1
              OF 'Cits'
                 HIDE(?AVOTS2)
                 TTAKA"=LONGPATH()
                 MAINFILE=''
                 FILENAME1=''
                 IF ~FILEDIALOG('...TIKAI GG...TPS FAILI !!!',FILENAME1,'Topspeed|GG*.tps',0)
                    DO PROCEDURERETURN
                 .
                 SETPATH(TTAKA")
              ELSE
                 FILENAME1=CLIP(MAINFOLDER)&CLIP(avots1)&CLIP(MAINFILE)
              .
              DISPLAY
           .
        OF ?AVOTS2
           CASE EVENT()
           OF EVENT:ACCEPTED
              IF AVOTS2[1]='B'
                 MAINFILE='\GG'&AVOTS2[11:12]&'.TPS'
              ELSIF AVOTS2[1]='N'
                 MAINFILE='\GG'&AVOTS2[11:12]+15&'.TPS'
              ELSIF AVOTS2[1]='A'
                 MAINFILE='\GG'&AVOTS2[11:12]+65&'.TPS'
              ELSIF AVOTS2[1]='P'
                 MAINFILE='\GG'&AVOTS2[11:12]+80&'.TPS'
              .
              FILENAME1=CLIP(MAINFOLDER)&CLIP(avots1)&CLIP(MAINFILE)
              DISPLAY
           .
        OF ?OK1
           CASE EVENT()
           OF EVENT:ACCEPTED
             SELECT(1)
             SELECT
             IF INSTRING('GGK',FILENAME1,1) OR INSTRING(CLIP(FILENAME1),CLIP(LONGPATH())&'\GG'&FORMAT(LOC_NR,@N02)&'.TPS',1)
                KLUDA(0,'Neatïauts datu avots...'&FILENAME1)
                DO PROCEDURERETURN
             .
             LOOP I#=LEN(FILENAME1)-1 TO 2 BY -1
                IF UPPER(FILENAME1[I#-1:I#])='GG'
                   FILENAME2=FILENAME1[1:I#]&'K'&FILENAME1[I#+1:LEN(FILENAME1)]
                   FOUND#=1
                   BREAK
                .
             .
             IF ~FOUND#
                KLUDA(27,FILENAME1)
                CYCLE
             .
             LOCALRESPONSE=REQUESTCOMPLETED
             BREAK
           .
        OF ?CANCEL1
           CASE EVENT()
           OF EVENT:ACCEPTED
             LOCALRESPONSE=REQUESTCANCELLED
             CLOSE(SourceScreen)
             DO PROCEDURERETURN
           .
        .
     .
     CLOSE(SourceScreen)
  ELSE      !Noliktava,ALGAS,PL
     FILENAME1=CLIP(LONGPATH())&'\GG'&FORMAT(JOB_NR,@N02)&'.TPS'
     FILENAME2=CLIP(LONGPATH())&'\GGK'&FORMAT(JOB_NR,@N02)&'.TPS'
     FPPAVADNAME=CLIP(LONGPATH())&'\GD'&FORMAT(JOB_NR,@N02)&'.DBF'
     FPNOLIKNAME=CLIP(LONGPATH())&'\GGD'&FORMAT(JOB_NR,@N02)&'.DBF'
  .
  F:DTK=''
  !STOP(FILENAME1)
  !STOP(FILENAME2)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  quickWindow{PROP:TEXT}='Datu avots :'&filename1
  IF INRANGE(JOB_NR,1,15)
     HIDE(?Parbuvet)
  ELSE
     HIDE(?ImpApgabalu)
     HIDE(?ImpRakstu)
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
    OF ?Parbuvet
      CASE EVENT()
      OF EVENT:Accepted
        IF INRANGE(JOB_NR,16,40) !NOLIKTAVA
           OPEN(BUILDSCREEN)
           IF ATLAUTS[1]
              UNHIDE(?String:RS)
              UNHIDE(?RS)
           END
           HIDE(?IMAGEDBF)
           DISPLAY
           ACCEPT
              CASE FIELD()
              OF ?BUTTONDBF
                 CASE EVENT()
                 OF EVENT:Accepted
                    IF F:DTK
                       F:DTK=''
                       HIDE(?IMAGEDBF)
                    ELSE
                       F:DTK='1'
                       UNHIDE(?IMAGEDBF)
                    .
                 .
              OF ?OkButton2
                 CASE EVENT()
                 OF EVENT:Accepted
                    LOCALRESPONSE=REQUESTCOMPLETED
                    break
                 END
              OF ?CancelButton2
                 CASE EVENT()
                 OF EVENT:Accepted
                    LocalRESPONSE=REQUESTCANCELLED
                    break
                 END
              END
           .
           IF LOCALRESPONSE=REQUESTCOMPLETED
              CLOSE(BRW1::View:Browse)   ! VIEWS SAGRÂBJ HAILAITÇTO IERAKSTU UN NEÏAUJ DZÇST
              DO BUILDNOLIK
              CLOSE(BUILDSCREEN)
              OPEN(BRW1::View:Browse)
              DO BRW1::InitializeBrowse
              DO BRW1::RefreshPage
              DISPLAY
           ELSE
              CLOSE(BUILDSCREEN)
           .
        ELSIF INRANGE(JOB_NR,66,80) !ALGAS
           MEN_NR=MONTH(ALP:YYYYMM)
           GADS  =YEAR(ALP:YYYYMM)
           OPCIJA='110'
           IZZFILTGMC
           IF GLOBALRESPONSE=REQUESTCOMPLETED
              CLOSE(BRW1::View:Browse)   ! VIEWS SAGRÂBJ HAILAITÇTO IERAKSTU UN NEÏAUJ DZÇST
              OPEN(ProcessScreen)
              DISPLAY
              DO BUILDALGAS
              CLOSE(ProcessScreen)
              OPEN(BRW1::View:Browse)
              DO BRW1::InitializeBrowse
              DO BRW1::RefreshPage
              DISPLAY
           .
        ELSIF INRANGE(JOB_NR,81,95) !PL
           OPEN(MODE_SCREEN)
           ACCEPT
              CASE FIELD()
              OF ?MODE
                 IF MODE=2
                    UNHIDE(?StringB_DAT)
                    UNHIDE(?B_DAT)
                 ELSE
                    HIDE(?StringB_DAT)
                    HIDE(?B_DAT)
                 .
              OF ?OkButton4
                 CASE EVENT()
                 OF EVENT:Accepted
                    LOCALRESPONSE=REQUESTCOMPLETED
                    break
                 END
              OF ?CancelButton4
                 CASE EVENT()
                 OF EVENT:Accepted
                    LocalRESPONSE=REQUESTCANCELLED
                    break
                 END
              END
           .
           CLOSE(MODE_SCREEN)
           IF LOCALRESPONSE=REQUESTCOMPLETED
              IF MODE=1  !NOLIETOJUMS
                 OPCIJA='110'
                 IZZFILTGMC
                 IF GLOBALRESPONSE=REQUESTCOMPLETED
                    CLOSE(BRW1::View:Browse)   ! VIEWS SAGRÂBJ HAILAITÇTO IERAKSTU UN NEÏAUJ DZÇST
                    OPEN(ProcessScreen)
                    DISPLAY
                    DO BUILDPL
                    CLOSE(ProcessScreen)
                    OPEN(BRW1::View:Browse)
                    DO BRW1::InitializeBrowse
                    DO BRW1::RefreshPage
                    DISPLAY
                 .
              ELSE  !NOÒEMÐANA
                 CLOSE(BRW1::View:Browse)   ! VIEWS SAGRÂBJ HAILAITÇTO IERAKSTU UN NEÏAUJ DZÇST
                 OPEN(ProcessScreen)
                 DISPLAY
                 DO BUILDPLNON
                 CLOSE(ProcessScreen)
                 OPEN(BRW1::View:Browse)
                 DO BRW1::InitializeBrowse
                 DO BRW1::RefreshPage
                 DISPLAY
              .
           .
        .
        DO SyncWindow
      END
    OF ?Tab2
      CASE EVENT()
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
        IF G1:U_NR=1            !SALDO
           KLUDA(18,'Eksistçjoðais SALDO ieraksts tiks aizvietots')
           IF KLU_DARBIBA   !AIZVIETOT
              OPEN(PROCESSSCREEN)
              PROGRESSS=TRUE
              IF GETGG(1)   !JA LIETOTÂJS VÇL NAV PASPÇJIS NODZÇST
                 IF RIDELETE:GG()
                    KLUDA(26,'GG')
                    DO PROCEDURERETURN
                 .
              .
              GG:RECORD=G1:RECORD
              ADD(GG)
              CLEAR(GK1:RECORD)
              GK1:U_NR=1
              SET(GK1:NR_KEY,GK1:NR_KEY)
              DO WRITEGGK
              CLOSE(PROCESSSCREEN)
              PROGRESSS=FALSE
           .
        ELSE       ! importçt izvçlçto rakstu
        
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
  INIRestoreWindow('BROWSEGG1','winlats.INI')
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
    INISaveWindow('BROWSEGG1','winlats.INI')
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
 IF F:DTK  !JÂBÛVÇ DBF
    CHECKOPEN(GD,1)
    close(GD)
    OPEN(GD,18)
    IF ERROR()
      kluda(1,FPPAVADNAME)
      CHECKOPEN(GD,1)
      EXIT
    .
    EMPTY(gD)
    IF ERROR() THEN STOP('EMPTY GD '&ERROR()).
    CHECKOPEN(GKD,1)
    close(GKD)
    OPEN(GKD,18)
    IF ERROR()
      kluda(1,FPNOLIKNAME)
      CHECKOPEN(GKD,1)
      EXIT
    .
    EMPTY(GKD)
    IF ERROR() THEN STOP('EMPTY GKD '&ERROR()).
 .

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
       IF F:DTK  !JÂBÛVÇ DBF
          CLEAR(GD:RECORD)
          GD:ES=1
          GD:RS=PAV:RS
!          GD:IMP_NR=LOC_NR
          GD:U_NR=PAV:U_NR           !IZMANTOJAM P/Z U_NR
          GD:DOK_SENR=PAV:DOK_SENR
          IF UPPER(GD:DOK_SENR[1:3])='REK' !RÇÍINS
             GD:ATT_DOK='6'
          ELSE                             !P/Z
             GD:ATT_DOK='2'
          .
          GD:DATUMS=PAV:DATUMS
          GD:DOKDAT=PAV:DOKDAT
          IF PAV:C_DATUMS            !16/11/99
             GD:APMDAT=PAV:C_DATUMS  !10/05/99
          ELSE
             GD:APMDAT=PAV:DATUMS
          .
          GD:NOKA=PAV:NOKA
          GD:PARREGNR=GETPAR_K(PAR_NR,0,12)
          CASE PAV:D_K
          OF 'D'
             GD:SATURS='Saòemts  -'&CLIP(SYS:AVOTS) &': '& PAV:PAMAT
          OF 'K'
             IF PAV:D_K='R'
                GD:SATURS='Norakstîts-'&CLIP(SYS:AVOTS) &': '& PAV:PAMAT
             ELSE
                IF PAV:SUMMA >= 0
                   GD:SATURS='Realizçts-'&CLIP(SYS:AVOTS) &': '& PAV:PAMAT
                ELSE
                   GD:SATURS='Atgriezts-'&CLIP(SYS:AVOTS) &': '& PAV:PAMAT
                .
             .
          OF 'I'  !???
             GD:SATURS='Inventar.-'&CLIP(SYS:AVOTS) &': '& PAV:PAMAT
          .
          GD:summa =PAV:summa
          GD:VAL   =PAV:VAL
          GD:ACC_DAT =TODAY()
          GD:ACC_KODS=ACC_KODS
          ADD(GD)
          IF ERROR()
             KLUDA(24,GD:U_NR&FILENAME1)
          ELSE
             DO WRITEGK1
          .
       .
    .
 .
 close(g1)
 close(gk1)
 close(gD)
 close(gKD)
 checkopen(g1,1)
 checkopen(gk1,1)

!-----------------------------------------------------------------------------------------------------
BUILDALGAS ROUTINE   ! BÛVÇJAM ALGU GG(G1) UN GGK(GK1)

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

 IF ALGAS::USED=0
    CHECKOPEN(ALGAS)
 .
 ALGAS::USED+=1
 DELTA=0
 CLEAR(ALP:RECORD)
 ALP:YYYYMM=B_DAT  !LAI NOSTÂJAS UZ PIRMO(AUGSTÂKO IERAKSTU)
 SET(ALP:YYYYMM_KEY,ALP:YYYYMM_KEY)
 LOOP
    NEXT(ALGPA)
    PROCESS=MENVAR(ALP:YYYYMM,2,2)&' '&YEAR(ALP:YYYYMM) ! ProcessScreen
    DISPLAY
    IF ERROR() OR ALP:YYYYMM<S_DAT THEN BREAK.

!---------------------------------------
       BuildGGKTable(2)
!---------------------------------------

!    PROCESS='rakstu '&MENVAR(ALP:YYYYMM,2,3) ! ProcessScreen
!    DISPLAY
    CLEAR(G1:RECORD)
    G1:ES=1
    G1:RS=''
    G1:IMP_NR=LOC_NR
    G1:U_NR=ALP:YYYYMM  !IZMANTOJAM ALP UNIKÂLO YYYYMM
    G1:DOK_SENR=MONTH(ALP:YYYYMM)
    G1:DATUMS=DATE(MONTH(ALP:YYYYMM)+1,1,YEAR(ALP:YYYYMM))-1
    G1:DOKDAT=G1:DATUMS
    G1:SATURS='Algu aprçíins par '&MENVAR(ALP:YYYYMM,2,3)
!    G1:SUMMA= DOKSUMMA
    !G1:VAL   ='Ls'
    G1:VAL   = val_uzsk !15/12/2013
    G1:ACC_DATUMS =TODAY()
    G1:ACC_KODS=ACC_KODS
    ADD(G1)
    IF ERROR()
       KLUDA(24,G1:U_NR&FILENAME1)
    ELSE
       DO WRITEGK1
    .
    G1:SUMMA= DOKSUMMA
    IF RIUPDATE:G1()
       KLUDA(24,'G1')
    .
 .
 close(g1)
 close(gk1)
 checkopen(g1,1)
 checkopen(gk1,1)
 ALGAS::USED-=1
 IF ALGAS::USED=0
    CLOSE(ALGAS)
 .

!-----------------------------------------------------------------------------------------------------
BUILDPL ROUTINE

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

 IF PAMAT::USED=0
    CHECKOPEN(PAMAT,1)
 .
 PAMAT::USED+=1
 IF PAMAM::USED=0
    CHECKOPEN(PAMAM,1)
 .
 PAMAM::USED+=1
 PROCESS='bûvçju tabulas....' ! ProcessScreen
 DISPLAY

!---------------------------------------
       BuildGGKTable(3)
!---------------------------------------

 PROCESS='rakstu....' ! ProcessScreen
 DISPLAY
 CLEAR(G1:RECORD)
 G1:ES=1
 G1:RS=''
 G1:IMP_NR=LOC_NR
 G1:U_NR=B_DAT
 G1:DOK_SENR=MONTH(B_DAT)
 G1:DATUMS=B_DAT
 G1:DOKDAT=G1:DATUMS
 G1:SATURS='P/L nolietojums '&FORMAT(s_dat,@D06.)&'-'&FORMAT(b_dat,@D06.)
! G1:SUMMA= DOKSUMMA
 !G1:VAL   ='Ls'
 G1:VAL   = val_uzsk !15/12/2013

 G1:ACC_DATUMS =TODAY()
 G1:ACC_KODS=ACC_KODS
 ADD(G1)
 IF ERROR()
    KLUDA(24,G1:U_NR&FILENAME1)
 ELSE
    DO WRITEGK1
 .
 G1:SUMMA= DOKSUMMA
 IF RIUPDATE:G1()
    KLUDA(24,'G1')
 .

 close(g1)
 close(gk1)
 checkopen(g1,1)
 checkopen(gk1,1)
 PAMAT::USED-=1
 IF PAMAT::USED=0
    CLOSE(PAMAT)
 .
 PAMAM::USED-=1
 IF PAMAM::USED=0
    CLOSE(PAMAM)
 .

!-----------------------------------------------------------------------------------------------------
BUILDPLNON ROUTINE

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

 IF PAMAT::USED=0
    CHECKOPEN(PAMAT,1)
 .
 PAMAT::USED+=1
 IF PAMAM::USED=0
    CHECKOPEN(PAMAM,1)
 .
 PAMAM::USED+=1
 PROCESS='bûvçju tabulas....' ! ProcessScreen
 DISPLAY

!---------------------------------------
       BuildGGKTable(4)
!---------------------------------------

 PROCESS='rakstu....' ! ProcessScreen
 DISPLAY
 CLEAR(G1:RECORD)
 G1:ES=1
 G1:RS=''
 G1:IMP_NR=LOC_NR
 G1:U_NR=B_DAT
 G1:DOK_SENR=MONTH(B_DAT)
 G1:DATUMS=B_DAT
 G1:DOKDAT=G1:DATUMS
 G1:SATURS='P/L noòemðana '&FORMAT(b_dat,@D06.)
! G1:SUMMA= DOKSUMMA
 !G1:VAL   ='Ls'
 G1:VAL   = val_uzsk !15/12/2013
 G1:ACC_DATUMS =TODAY()
 G1:ACC_KODS=ACC_KODS
 ADD(G1)
 IF ERROR()
    KLUDA(24,G1:U_NR&FILENAME1)
 ELSE
    DO WRITEGK1
 .
 G1:SUMMA= DOKSUMMA
 IF RIUPDATE:G1()
    KLUDA(24,'G1')
 .

 close(g1)
 close(gk1)
 checkopen(g1,1)
 checkopen(gk1,1)
 PAMAT::USED-=1
 IF PAMAT::USED=0
    CLOSE(PAMAT)
 .
 PAMAM::USED-=1
 IF PAMAM::USED=0
    CLOSE(PAMAM)
 .

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
       IF F:DTK  !JÂBÛVÇ DBF
          CLEAR(GKD:RECORD)
          GKD:U_NR     = G1:U_NR
!          GKD:RS       = G1:RS
!          GKD:DATUMS   = G1:DATUMS
!          IF INRANGE(JOB_NR,66,95) !ALGAS,PL
!             GKD:PAR_NR= 0
!          ELSE
!             GKD:PAR_NR= PAR_NR
!          .
          GKD:NODALA   = GGT:NODALA
          GKD:OBJ_NR   = GGT:OBJ_NR
          GKD:SUMMA    = GGT:SUMMA
          GKD:SUMMAV   = GGT:SUMMAV
          GKD:BKK      = GGT:BKK
          GKD:D_K      = GGT:D_K
          GKD:VAL      = GGT:VAL
!          GKD:KK       = GGT:KK
          GKD:PVN_PROC = GGT:PVN_PROC
          GKD:PVN_TIPS = GGT:PVN_TIPS  !PVN TIPS
          ADD(GKD)
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
       IF F:DTK  !JÂBÛVÇ DBF
          CLEAR(GKD:RECORD)
          GKD:U_NR   = GD:U_NR
!          GKD:RS     = G1:RS
!          GKD:DATUMS = G1:DATUMS
!          GKD:PAR_NR = 0
          GKD:SUMMA  = ABS(DELTA)
          IF MULTIVALUTAS#=FALSE
             GKD:SUMMAV = ABS(DELTAV)
          ELSE
             GKD:SUMMAV = ABS(DELTA)
          .
          GKD:BKK    = 'DELTA'
          IF DELTA>0
             GKD:D_K = 'K'
          ELSE
             GKD:D_K = 'D'
          .
!          GKD:VAL    = GGT:VAL
          ADD(GKD)
          IF ERROR() THEN STOP(ERROR()).
       .
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

BROWSEGGK1 PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG

BRW1::View:Browse    VIEW(GK1)
                       PROJECT(GK1:DATUMS)
                       PROJECT(GK1:PAR_NR)
                       PROJECT(GK1:D_K)
                       PROJECT(GK1:BKK)
                       PROJECT(GK1:NODALA)
                       PROJECT(GK1:Obj_nr)
                       PROJECT(GK1:PVN_PROC)
                       PROJECT(GK1:PVN_TIPS)
                       PROJECT(GK1:SUMMA)
                       PROJECT(GK1:SUMMAV)
                       PROJECT(GK1:VAL)
                       PROJECT(GK1:REFERENCE)
                       PROJECT(GK1:U_NR)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::GK1:DATUMS       LIKE(GK1:DATUMS)           ! Queue Display field
BRW1::GK1:PAR_NR       LIKE(GK1:PAR_NR)           ! Queue Display field
BRW1::GK1:D_K          LIKE(GK1:D_K)              ! Queue Display field
BRW1::GK1:BKK          LIKE(GK1:BKK)              ! Queue Display field
BRW1::GK1:NODALA       LIKE(GK1:NODALA)           ! Queue Display field
BRW1::GK1:Obj_nr       LIKE(GK1:Obj_nr)           ! Queue Display field
BRW1::GK1:PVN_PROC     LIKE(GK1:PVN_PROC)         ! Queue Display field
BRW1::GK1:PVN_TIPS     LIKE(GK1:PVN_TIPS)         ! Queue Display field
BRW1::GK1:SUMMA        LIKE(GK1:SUMMA)            ! Queue Display field
BRW1::GK1:SUMMAV       LIKE(GK1:SUMMAV)           ! Queue Display field
BRW1::GK1:VAL          LIKE(GK1:VAL)              ! Queue Display field
BRW1::GK1:REFERENCE    LIKE(GK1:REFERENCE)        ! Queue Display field
BRW1::GK1:U_NR         LIKE(GK1:U_NR)             ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(GK1:BKK),DIM(100)
BRW1::Sort1:LowValue LIKE(GK1:BKK)                ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(GK1:BKK)               ! Queue position of scroll thumb
BRW1::Sort1:Reset:G1:U_NR LIKE(G1:U_NR)
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
QuickWindow          WINDOW('Browse the GGK1 File'),AT(,,390,205),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,VSCROLL,HLP('BROWSEGGK1'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,17,374,159),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('46L(1)|M~Datums~C(0)@d06.@31R(2)|M~Par Nr~C(0)@n_7.0@10C(2)M@s1@24L(2)|M~BKK~@s5' &|
   '@10C|M~N~@s2@22R(1)|M~Obj~C(0)@n_5@13R(1)M~%~C(0)@n2@10C|M~T~@s1@49R(2)|M~Summa~' &|
   'C(0)@n-15.2@55R(2)|M~Summa valûtâ~C(0)@n-15.2@22C|M~Valûta~@s3@56L(1)|M~Referenc' &|
   'e~C(0)@s14@'),FROM(Queue:Browse:1)
                       SHEET,AT(0,1,384,181),USE(?CurrentTab)
                         TAB('Kontçjums'),USE(?Tab:2)
                         END
                       END
                       BUTTON('&Beigt'),AT(336,185,45,14),USE(?Close)
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
  QUICKWINDOW{PROP:TEXT}='Datu avots: '&filename2
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
  IF G1::Used = 0
    CheckOpen(G1,1)
  END
  G1::Used += 1
  BIND(G1:RECORD)
  IF GK1::Used = 0
    CheckOpen(GK1,1)
  END
  GK1::Used += 1
  BIND(GK1:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BROWSEGGK1','winlats.INI')
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
    G1::Used -= 1
    IF G1::Used = 0 THEN CLOSE(G1).
    GK1::Used -= 1
    IF GK1::Used = 0 THEN CLOSE(GK1).
  END
  IF WindowOpened
    INISaveWindow('BROWSEGGK1','winlats.INI')
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
      IF BRW1::Sort1:Reset:G1:U_NR <> G1:U_NR
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:G1:U_NR = G1:U_NR
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
      StandardWarning(Warn:RecordFetchError,'GK1')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = GK1:BKK
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GK1')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = GK1:BKK
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
  GK1:DATUMS = BRW1::GK1:DATUMS
  GK1:PAR_NR = BRW1::GK1:PAR_NR
  GK1:D_K = BRW1::GK1:D_K
  GK1:BKK = BRW1::GK1:BKK
  GK1:NODALA = BRW1::GK1:NODALA
  GK1:Obj_nr = BRW1::GK1:Obj_nr
  GK1:PVN_PROC = BRW1::GK1:PVN_PROC
  GK1:PVN_TIPS = BRW1::GK1:PVN_TIPS
  GK1:SUMMA = BRW1::GK1:SUMMA
  GK1:SUMMAV = BRW1::GK1:SUMMAV
  GK1:VAL = BRW1::GK1:VAL
  GK1:REFERENCE = BRW1::GK1:REFERENCE
  GK1:U_NR = BRW1::GK1:U_NR
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
  BRW1::GK1:DATUMS = GK1:DATUMS
  BRW1::GK1:PAR_NR = GK1:PAR_NR
  BRW1::GK1:D_K = GK1:D_K
  BRW1::GK1:BKK = GK1:BKK
  BRW1::GK1:NODALA = GK1:NODALA
  BRW1::GK1:Obj_nr = GK1:Obj_nr
  BRW1::GK1:PVN_PROC = GK1:PVN_PROC
  BRW1::GK1:PVN_TIPS = GK1:PVN_TIPS
  BRW1::GK1:SUMMA = GK1:SUMMA
  BRW1::GK1:SUMMAV = GK1:SUMMAV
  BRW1::GK1:VAL = GK1:VAL
  BRW1::GK1:REFERENCE = GK1:REFERENCE
  BRW1::GK1:U_NR = GK1:U_NR
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
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => UPPER(GK1:BKK)
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
    OF 1
      GK1:BKK = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'GK1')
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
      BRW1::HighlightedPosition = POSITION(GK1:NR_KEY)
      RESET(GK1:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      GK1:U_NR = G1:U_NR
      SET(GK1:NR_KEY,GK1:NR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'GK1:U_NR = G1:U_NR'
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
    CLEAR(GK1:Record)
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
    GK1:U_NR = G1:U_NR
    SET(GK1:NR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'GK1:U_NR = G1:U_NR'
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
    G1:U_NR = BRW1::Sort1:Reset:G1:U_NR
  END
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

UpdateSystem PROCEDURE


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
Nol_tips             STRING(20)
SVYN                 STRING(2)
SUP_A4               STRING(3)
NOA                  STRING(1)
LIST1:QUEUE          QUEUE,PRE()
KASES_AP             STRING(20)
                     END
LIST2:QUEUE          QUEUE,PRE()
U_Skaneris           STRING(20)
                     END
LIST3:QUEUE          QUEUE,PRE()
E_Svari              STRING(20)
                     END
LIST4:QUEUE          QUEUE,PRE()
SK_Druka             STRING(20)
                     END
PLKST                STRING(5)
TPB_NO         STRING(6)
TPB_LIDZ       STRING(6)
PAVADZIME      STRING(30)
SAK_NR         DECIMAL(7)
BEI_NR         DECIMAL(7)

report REPORT,AT(146,400,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
detailA4 DETAIL,PAGEAFTER(-1),AT(,,,1000)
         STRING(@s30),AT(2156,573,3594,260),USE(pavadzime),TRN,CENTER(1),FONT(,14,,FONT:bold,CHARSET:BALTIC)
       END
     END

NOLIDZ_SCREEN WINDOW('Norâdîet drukâjamo apgabalu :'),AT(,,185,92),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC), |
         CENTER,GRAY
       STRING(@s7),AT(28,33,33,12),USE(SYS:PZ_SERIJA,,?SYS:PZ_SERIJA:1),FONT(,10,,,CHARSET:ANSI)
       ENTRY(@N_6),AT(67,31,42,15),USE(SAK_NR),FONT(,10,,,CHARSET:ANSI)
       ENTRY(@N_6),AT(114,31,42,15),USE(BEI_NR),FONT(,10,,,CHARSET:ANSI)
       BUTTON('&OK'),AT(142,73,35,14),USE(?OkNOLIDZ),DEFAULT
       BUTTON('&Atlikt'),AT(101,74,36,14),USE(?CancelNOLIDZ)
     END

Update::Reloop  BYTE
Update::Error   BYTE
History::SYS:Record LIKE(SYS:Record),STATIC
SAV::SYS:Record      LIKE(SYS:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Mainam SYSTEM failu'),AT(,,313,272),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateSYSTEM'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(2,5,307,242),USE(?CurrentTab)
                         TAB('Moduïa &lokâlie dati'),USE(?Tab:1)
                           STRING('Avota Nr:'),AT(238,23),USE(?String4),FONT(,,COLOR:Gray,FONT:bold)
                           STRING(@n3),AT(274,23),USE(SYS:AVOTA_NR),FONT(,,COLOR:Gray,FONT:bold)
                           PROMPT('Objekta vârds:'),AT(11,39),USE(?SYS:AVOTS:Prompt)
                           ENTRY(@s17),AT(78,39,79,10),USE(SYS:AVOTS)
                           STRING(@n3),AT(274,34),USE(LOC_NR),FONT(,,COLOR:Gray,FONT:bold)
                           STRING('Moduïa Nr:'),AT(234,34),USE(?String4:2),FONT(,,COLOR:Gray,FONT:bold)
                           PROMPT('Adrese:'),AT(11,50),USE(?SYS:ADRESE:Prompt)
                           ENTRY(@s60),AT(78,50,208,10),USE(SYS:ADRESE)
                           PROMPT('Telefons:'),AT(11,63),USE(?SYS:TEL:Prompt)
                           ENTRY(@s17),AT(78,63,74,10),USE(SYS:TEL)
                           PROMPT('Fakss:'),AT(155,63),USE(?SYS:FAX:Prompt)
                           ENTRY(@s17),AT(180,63,74,10),USE(SYS:FAX)
                           PROMPT('Noklusçtais PVN % :'),AT(11,126),USE(?SYS:NOKL_PVN:Prompt)
                           ENTRY(@n2),AT(81,126,21,10),USE(SYS:NOKL_PVN),RIGHT(1)
                           PROMPT('Noklusçtâ partnera banka:'),AT(11,142,97,10),USE(?SYS:NOKL_PB:Prompt)
                           ENTRY(@n_1.0),AT(122,141,21,10),USE(SYS:NOKL_PB),RIGHT(1)
                           PROMPT('PVN konts :'),AT(105,126),USE(?SYS:K_PVN:Prompt)
                           ENTRY(@s5),AT(146,126,40,10),USE(SYS:K_PVN)
                           PROMPT('Noklusçtâ mûsu  banka:'),AT(11,155,94,10),USE(?SYS:NOKL_B:Prompt)
                           ENTRY(@N2),AT(122,155,21,10),USE(SYS:NOKL_B),RIGHT(1)
                           STRING(@s21),AT(146,153),USE(REK),FONT(,8,,FONT:bold)
                           PROMPT('Noklusçtâs atliktâ maks. dienas:'),AT(11,169,109,10),USE(?SYS:NOKL_dc:Prompt)
                           ENTRY(@n6),AT(122,169,21,10),USE(SYS:NOKL_DC),RIGHT(1)
                           STRING(@s31),AT(146,161),USE(BANKA)
                           PROMPT('1.Paraksts un amats'),AT(11,89),USE(?SYS:PARAKSTS1:Prompt)
                           ENTRY(@s25),AT(78,89,103,10),USE(SYS:PARAKSTS1)
                           ENTRY(@s25),AT(183,89,103,10),USE(SYS:AMATS1)
                           PROMPT('2.Paraksts un amats'),AT(11,101),USE(?SYS:PARAKSTS2:Prompt)
                           ENTRY(@s25),AT(78,101,103,10),USE(SYS:PARAKSTS2)
                           ENTRY(@s25),AT(183,101,103,10),USE(SYS:AMATS2)
                           PROMPT('3.Kasieris'),AT(11,112),USE(?PromptKASIERIS),HIDE
                           ENTRY(@s25),AT(78,112,103,10),USE(SYS:PARAKSTS3),HIDE
                           ENTRY(@s35),AT(78,74,147,10),USE(SYS:E_MAIL)
                           PROMPT('e_pasts'),AT(11,74),USE(?SYS:E_MAIL:Prompt)
                         END
                         TAB('Â&rçjâs iekârtas'),USE(?Tab:2)
                           STRING('Kases aparâts:'),AT(37,55),USE(?String7)
                           LIST,AT(118,53,95,14),USE(KASES_AP),FORMAT('80L~KASES AP~@s20@'),DROP(20),FROM(List1:Queue)
                           OPTION('&Savienojums:'),AT(222,45,57,38),USE(SYS:com_nr),BOXED
                             RADIO('1-Com1'),AT(233,55),USE(?SYS:com_nr:Radio1),VALUE('1')
                             RADIO('2-Com2'),AT(233,66),USE(?SYS:com_nr:Radio2),VALUE('2')
                           END
                           STRING('Uzkrâjoðais skaneris:'),AT(37,77),USE(?String7:2)
                           LIST,AT(118,74,95,14),USE(U_Skaneris),FORMAT('80L~U Skaneris~@s20@'),DROP(10),FROM(List2:Queue)
                           STRING('Elektroniskie svari:'),AT(37,103),USE(?String7:3)
                           LIST,AT(118,98,95,14),USE(E_Svari),FORMAT('80L~E Svari~@s20@'),DROP(10),FROM(List3:Queue)
                           STRING('Svîtru kodu drukâtâjs:'),AT(37,125),USE(?String7:4)
                           LIST,AT(118,122,95,14),USE(SK_Druka),FORMAT('80L~SK Druka~@s20@'),DROP(10),FROM(List4:Queue)
                         END
                         TAB('&1 Papildus dati'),USE(?Tab:3),DISABLE
                           PROMPT('Noklusçtâ &cena precei:'),AT(22,57,83,10),USE(?SYS:NOKL_cp:Prompt:2)
                           ENTRY(@n3),AT(134,56,21,12),USE(SYS:NOKL_CP,,?SYS:NOKL_CP:2),RIGHT(1)
                           PROMPT('Noklusçtâ &cena pakalpojumiem:'),AT(22,72,109,10),USE(?SYS:NOKL_cp:Prompt:3)
                           ENTRY(@n1),AT(134,71,21,12),USE(SYS:NOKL_CA,,?SYS:NOKL_CA:2),RIGHT(1)
                           PROMPT('Pçdçjâ èeka &Nr:'),AT(22,87,83,10),USE(?SYS:CEKA_NR:Prompt)
                           ENTRY(@n13),AT(125,86,30,12),USE(SYS:CEKA_NR),RIGHT(1)
                           ENTRY(@s3),AT(134,100,21,12),USE(SYS:kontrolcipars),RIGHT(1)
                           ENTRY(@n3),AT(134,115,21,12),USE(SYS:Tuksni),RIGHT(1)
                           PROMPT('&Referencçjoðâs Noliktavas Nr:'),AT(22,132,109,10),USE(?SYS:REF_AVOTS:Prompt)
                           ENTRY(@n3),AT(134,130),USE(SYS:REF_AVOTS),RIGHT(1)
                           PROMPT('&Tukðas rindas pçc èeka:'),AT(22,116,83,10),USE(?SYS:Tuksni:Prompt)
                           PROMPT('&Kontrolcipars:'),AT(22,100,83,10),USE(?SYS:kontrolcipars:Prompt)
                         END
                         TAB('&2 Papildus dati'),USE(?Tab:4),DISABLE
                           PROMPT('Noklusçtâ nodaïa:'),AT(22,23,90,10),USE(?SYS:NODALA:Prompt)
                           ENTRY(@S2),AT(126,22,21,10),USE(SYS:NODALA),RIGHT(1)
                           PROMPT('&MAX rindas P/Z :'),AT(23,35),USE(?SYS:Tuksni:Prompt:2)
                           ENTRY(@n2),AT(126,35,21,10),USE(SYS:Tuksni,,?SYS:Tuksni:2),RIGHT(1)
                           PROMPT('Noklusçtâ &cena precei:'),AT(22,48,96,10),USE(?SYS:NOKL_cp:Prompt)
                           ENTRY(@n1),AT(133,48,14,10),USE(SYS:NOKL_CP),RIGHT(1)
                           PROMPT('/ pa&kalpojumiem:'),AT(152,48,61,10),USE(?SYS:NOKL_cp:Prompt:4)
                           ENTRY(@n1),AT(213,48,14,10),USE(SYS:NOKL_CA),RIGHT(1)
                           OPTION('&Pavadzîmç jâatspoguïo :'),AT(22,69,144,58),USE(SYS:NOM_CIT),BOXED
                             RADIO('Nomenklatûra'),AT(34,79),USE(?SYS:NOM_CIT:Radio1),VALUE('N')
                             RADIO('Kods'),AT(34,90),USE(?SYS:NOM_CIT:Radio2),VALUE('K')
                             RADIO('Kataloga Nr (Artikuls)'),AT(34,101),USE(?SYS:NOM_CIT:Radio3),VALUE('A')
                             RADIO('Cits teksts -'),AT(34,111,49,10),USE(?SYS:NOM_CIT:Radio4),VALUE('C')
                           END
                           ENTRY(@s15),AT(85,112,69,10),USE(SYS:NOKL_TE)
                           OPTION('P/Z drukât svaru'),AT(10,151,63,30),USE(SVYN),BOXED
                             RADIO('Nç'),AT(34,159,21,10),USE(?SVYN:Radio1),VALUE('Nç')
                             RADIO('Jâ'),AT(34,168,20,10),USE(?SVYN:Radio2),VALUE('Jâ')
                           END
                           BUTTON('Nerçíinât proporciju'),AT(174,97,81,14),USE(?ButtonNerekinat),HIDE
                           BUTTON('Nemeklçt vçsturi'),AT(175,119,81,14),USE(?ButtonNemeklet),HIDE
                           PROMPT('Speciâlas atzîmes PZ :'),AT(28,135),USE(?SYS:ATLAUJA:Prompt)
                           ENTRY(@s45),AT(106,135,151,10),USE(SYS:ATLAUJA)
                           IMAGE('CANCEL4.ICO'),AT(259,92,20,23),USE(?ImageNerekinat),HIDE
                           IMAGE('CANCEL4.ICO'),AT(259,114,20,23),USE(?ImageNemeklet),HIDE
                           PROMPT('&Tekoðâ P/Z bloka SE-Nr'),AT(10,206,85,10),USE(?SYS:PZ_SERIJA:Prompt)
                           ENTRY(@s7),AT(97,206,36,10),USE(SYS:PZ_SERIJA),RIGHT(1),UPR
                           ENTRY(@N_06B),AT(135,206,43,10),USE(SYS:PZ_NR),RIGHT(1)
                           PROMPT('lîdz'),AT(180,206,16,10),USE(?lidz),CENTER
                           ENTRY(@n_06B),AT(197,206,43,10),USE(SYS:PZ_NR_END),RIGHT(1)
                           BUTTON('&Izdrukât A4 P/Z numurus un logo'),AT(86,249,126,17),USE(?ButtonA4Nr)
                           STRING('999999-nenumurçt'),AT(152,217),USE(?String999999),FONT(,,COLOR:Gray,)
                           BUTTON('Drukât Rçíinâ svîtru parakstu'),AT(138,230,113,14),USE(?ButtonMakaroni)
                           IMAGE('CHECK3.ICO'),AT(252,224,16,20),USE(?ImageMakaroni),HIDE
                           IMAGE('CHECK3.ICO'),AT(119,224,16,20),USE(?ImageDOKSAT),HIDE
                           BUTTON('Drukât Rçíinâ Dokumenta saturu'),AT(5,230,113,14),USE(?ButtonDOKSAT),HIDE
                           OPTION('K P/Z uzreiz piedâvât Nr'),AT(74,173,94,22),USE(SYS:SUP_A4_NR),BOXED
                             RADIO('Nç'),AT(79,182,21,10),USE(?SYS:SUP_A4_NR:RadioN),VALUE('0')
                             RADIO('Jâ'),AT(102,182,20,10),USE(?SYS:SUP_A4_NR:RadioY),VALUE('1')
                           END
                           OPTION('P/Z drukât kâ'),AT(74,151,94,22),USE(SUP_A4),BOXED
                             RADIO('SUP'),AT(80,160,26,10),USE(?SUP_A4:Radio1),VALUE('SUP')
                             RADIO('A4'),AT(108,160,33,10),USE(?SUP_A4:Radio2),VALUE('A4')
                           END
                           OPTION('P/Z noapaïot cenu'),AT(170,151,71,44),USE(NOA),BOXED
                             RADIO('Nç'),AT(178,160,21,10),USE(?NOA:Radio1),VALUE('N')
                             RADIO('Jâ (2 zîmes)'),AT(178,171,50,10),USE(?NOA:Radio2),VALUE('J')
                             RADIO('Jâ (3 zîmes)'),AT(178,182,49,10),USE(?NOA:Radio2:2),VALUE('3')
                           END
                           OPTION('P/Z ,R Izsniedza'),AT(244,151,62,73),USE(SYS:PARAKSTS_NR),BOXED
                             RADIO('Tukðs'),AT(248,160,43,10),USE(?SYS:PARAKSTS_NR:Radio0),VALUE('0')
                             RADIO('1.Paraksts'),AT(248,170,45,10),USE(?SYS:PARAKSTS_NR:Radio1),VALUE('1')
                             RADIO('2.Paraksts'),AT(248,180,44,10),USE(?SYS:PARAKSTS_NR:Radio2),VALUE('2')
                             RADIO('3.Paraksts'),AT(248,191,45,10),USE(?SYS:PARAKSTS_NR:Radio3),VALUE('3')
                             RADIO('LogIn'),AT(248,201,43,10),USE(?SYS:PARAKSTS_NR:Radio4),VALUE('4')
                             RADIO('e-me'),AT(248,211,43,10),USE(?SYS:PARAKSTS_NR:Radio5),DISABLE,VALUE('5')
                           END
                           OPTION('Noliktavas tips'),AT(174,60,114,30),USE(Nol_tips),BOXED
                             RADIO('Mazumtirdzniecîbas'),AT(180,71),USE(?Nol_tips:Radio1)
                             RADIO('Vairumtirdzniecîbas'),AT(180,79),USE(?Nol_tips:Radio2)
                           END
                         END
                         TAB('&3 Papildus dati'),USE(?Tab:5),DISABLE
                           STRING('Teritoriju kodi, par kuriem IIN jâieskaita paðvaldîbas budþetâ:'),AT(29,49),USE(?String11)
                           ENTRY(@N06),AT(52,66,32,14),USE(TPB_NO),FONT(,9,,FONT:bold)
                           ENTRY(@N06),AT(91,66,32,14),USE(TPB_LIDZ),FONT(,9,,FONT:bold)
                           STRING('( Rîgâ  010091-010096 )'),AT(128,68),USE(?String12)
                           STRING('Uzòçmçjdarbîbas riska valsts nodeva :'),AT(29,93),USE(?String13)
                           ENTRY(@N4.2),AT(159,92,21,10),USE(SYS:D_KO)
                           STRING('Obligâto iemaksu objekta max apmçrs :'),AT(29,106),USE(?String13:2)
                           ENTRY(@n_6),AT(159,106,31,10),USE(SYS:PZ_NR,,?SYS:PZ_NR:2),RIGHT
                           GROUP('Darba laiks (solis 30 min.)'),AT(24,119,146,58),USE(?Group1),BOXED
                             PROMPT('Pirmdiena-piektdiena'),AT(31,132),USE(?SYS:UDL_S:Prompt)
                             ENTRY(@T1),AT(102,132,28,10),USE(SYS:UDL_S),CENTER
                             ENTRY(@t1),AT(135,132,28,10),USE(SYS:UDL_B),CENTER
                             PROMPT('Sestdiena'),AT(31,144),USE(?SYS:UDL_6S:Prompt)
                             ENTRY(@t1),AT(102,145,28,10),USE(SYS:UDL_6S),CENTER
                             ENTRY(@t1),AT(135,145,28,10),USE(SYS:UDL_6B),CENTER
                             PROMPT('Svçtdiena'),AT(31,156),USE(?SYS:UDL_7S:Prompt)
                             ENTRY(@t1),AT(102,158,28,10),USE(SYS:UDL_7S),CENTER
                             ENTRY(@t1),AT(135,158,28,10),USE(SYS:UDL_7B),CENTER
                           END
                         END
                       END
                       BUTTON('&OK'),AT(216,249,45,17),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(264,249,45,17),USE(?Cancel)
                       STRING(@s8),AT(1,252),USE(SYS:ACC_KODS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       STRING(@D06.B),AT(38,252),USE(SYS:ACC_DATUMS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  kases_ap='0-Nav pieslçgts'
  ADD(LIST1:QUEUE)
  kases_ap='1-OMRON-3410'
  ADD(LIST1:QUEUE)
  kases_ap='2-OMRON-3420'
  ADD(LIST1:QUEUE)
  kases_ap='3-OMRON-3510'
  ADD(LIST1:QUEUE)
  kases_ap='4-OMRON-3510TDL'
  ADD(LIST1:QUEUE)
  kases_ap='5-VDM261'
  ADD(LIST1:QUEUE)
  kases_ap='6-KONIC-SR2000'
  ADD(LIST1:QUEUE)
  kases_ap='7-CHD-4010'
  ADD(LIST1:QUEUE)
  kases_ap='8-KONIC-SR2200'
  ADD(LIST1:QUEUE)
  kases_ap='9-FP-600'
  ADD(LIST1:QUEUE)
  kases_ap='10-TEC-MA-1650'
  ADD(LIST1:QUEUE)
  kases_ap='11-CHD-2010'
  ADD(LIST1:QUEUE)
  kases_ap='12-OMRON-2810'
  ADD(LIST1:QUEUE)
  kases_ap='13-BLUEBRIDGE'
  ADD(LIST1:QUEUE)
  kases_ap='14-UNIWELL UX43'
  ADD(LIST1:QUEUE)
  kases_ap='15-OPTIMA'
  ADD(LIST1:QUEUE)
  kases_ap='16-POSMAN'
  ADD(LIST1:QUEUE)
  kases_ap='17-CHD-5010'
  ADD(LIST1:QUEUE)
  kases_ap='18-CASIO FE300'
  ADD(LIST1:QUEUE)
  kases_ap='19-FP-600PLUS'
  ADD(LIST1:QUEUE)
  kases_ap='20-CHD-3010T FISCAL'
  ADD(LIST1:QUEUE)
  kases_ap='21-CHD-5010T FISCAL'
  ADD(LIST1:QUEUE)
  kases_ap='22-EPOS-3L FISCAL'
  ADD(LIST1:QUEUE)
  kases_ap='23-CHD-3010T'
  ADD(LIST1:QUEUE)
  kases_ap='24-OMRON-2810 FISCAL'
  ADD(LIST1:QUEUE)
  kases_ap='25-UNIWELL NX5400'
  ADD(LIST1:QUEUE)
  kases_ap='26-NEW VISION'
  ADD(LIST1:QUEUE)
  kases_ap='27-DATECS'
  ADD(LIST1:QUEUE)
  kases_ap='28-CHD-3550T FISCAL'
  ADD(LIST1:QUEUE)
  kases_ap='29-CHD-5510T FISCAL'
  ADD(LIST1:QUEUE)
  kases_ap='30-CHD-3510T'
  ADD(LIST1:QUEUE)
  kases_ap='31-CHD-5510T'
  ADD(LIST1:QUEUE)
  kases_ap='32-CHD-3320/5620' !Elya
  ADD(LIST1:QUEUE)
  GET(LIST1:QUEUE,sys:kases_ap+1)
  
  
  u_skaneris='0-Nav pieslçgts'
  ADD(LIST2:QUEUE)
  u_skaneris='1-BarMan Laser'
  ADD(LIST2:QUEUE)
  u_skaneris='2-M90'
  ADD(LIST2:QUEUE)
  u_skaneris='3-AXB'
  ADD(LIST2:QUEUE)
  u_skaneris='4-DATALOGIC'
  ADD(LIST2:QUEUE)
  u_skaneris='5-METROLOGIC'
  ADD(LIST2:QUEUE)
  u_skaneris='6-FORMULA WIZARD'
  ADD(LIST2:QUEUE)
  GET(LIST2:QUEUE,sys:u_skaneris+1)
  
  e_svari='0-Nav pieslçgti'
  ADD(LIST3:QUEUE)
  e_svari='1-CAS LP-1 600/200'
  ADD(LIST3:QUEUE)
  e_svari='2-DIGI 300'
  ADD(LIST3:QUEUE)
  GET(LIST3:QUEUE,sys:e_svari+1)
  
  sk_druka='0-Nav pieslçgta'
  ADD(LIST4:QUEUE)
  sk_druka='1-Intermec'
  ADD(LIST4:QUEUE)
  sk_druka='2-LP 2824'
  ADD(LIST4:QUEUE)
  sk_druka='3-BZB 2'
  ADD(LIST4:QUEUE)
  GET(LIST4:QUEUE,sys:sk_druka+1)
  
  CheckOpen(SYSTEM,1)
  
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  getMYbank()
  IF inrange(job_nr,1,15)     !**************Base
     UNHIDE(?PROMPTKASIERIS)
     UNHIDE(?SYS:PARAKSTS3)
     UNHIDE(?ButtonNerekinat)
     IF SYS:D_PR='N'
        UNHIDE(?ImageNerekinat)
     .
     UNHIDE(?ButtonNemeklet)
     IF SYS:D_PA='N'
        UNHIDE(?ImageNemeklet)
     .
     ENABLE(?Tab:4) ! NOLIKTAVA-PZ N
     HIDE(?SYS:NODALA:Prompt,?SVYN)
     HIDE(?Nol_tips)
     HIDE(?NOA)
     HIDE(?SYS:ATLAUJA:Prompt)
     HIDE(?SYS:ATLAUJA)
  !   HIDE(?SYS:PARAKSTS_NR)
     HIDE(?SYS:NOKL_TE)
     UNHIDE(?ButtonDOKSAT) !P/Z DRUKÂT DOK_SATURU
     IF BAND(SYS:BAITS,00000010B) !P/Z DRUKÂT DOK.SATURU
        UNHIDE(?ImageDOKSAT)
     ELSE
        HIDE(?ImageDOKSAT)
     .
  !   ?SYS:NOKL_TE{PROP:TEXT}='@S6'
  !   ?SYS:NOKL_TE{PROP:WIDTH}=30
     IF BAND(SYS:BAITS,00000001B) !MAKARONU PARAKSTS
        UNHIDE(?ImageMakaroni)
     ELSE
        HIDE(?ImageMakaroni)
     .
     IF BAND(SYS:BAITS1,00001000B) !A4 PZ
        SUP_A4='A4'
     ELSE
        SUP_A4='SUP'
     .
  ELSIF inrange(job_nr,16,40) !*******************Noliktava
     UNHIDE(?PromptKASIERIS)
     HIDE(?String999999)
     ?PromptKASIERIS{PROP:TEXT}='3. Paraksts'
     UNHIDE(?SYS:PARAKSTS3)
     ENABLE(?Tab:4) !-NOLIKTAVA
     IF BAND(SYS:BAITS1,00000100B) !Vairumtirdzniecîba
        NOL_TIPS='Vairumtirdzniecîbas'
     ELSE
        NOL_TIPS='Mazumtirdzniecîbas'
     .
     IF BAND(SYS:BAITS,00000001B) !MAKARONU PARAKSTS
        UNHIDE(?ImageMakaroni)
     ELSE
        HIDE(?ImageMakaroni)
     .
     IF BAND(SYS:BAITS1,00001000B) !A4 PZ
        SUP_A4='A4'
     ELSE
        SUP_A4='SUP'
     .
     IF BAND(SYS:BAITS1,00010000B) !DRUKÂT SVARU
        SVYN='Jâ'
     ELSE
        SVYN='Nç'
     .
     IF BAND(SYS:BAITS1,00100000B) !NOAPAÏOT CENU 2z
        NOA='Jâ (2 zîmes)'
     ELSIF BAND(SYS:BAITS1,01000000B) !NOAPAÏOT CENU 3z
        NOA='3-Jâ (3 zîmes)'
     ELSE
        NOA='Nç'
     .
     ENABLE(?Tab:5)  !ALGAS-UDL
     Hide(?STRING11,?SYS:PZ_NR:2)
  elsif inrange(job_nr,41,65) !********************Pos
     ENABLE(?Tab:4)
  elsif inrange(job_nr,66,80) !********************Alga
     DISABLE(?Tab:2) !ÂRÇJÂS IEKÂRTAS
     ENABLE(?Tab:5)  !ALGU DATI+UDL
     UNHIDE(?PROMPTKASIERIS)
     UNHIDE(?SYS:PARAKSTS3)
     Hide(?SYS:NOKL_PVN:Prompt)
     HIDE(?SYS:NOKL_PVN)
     HIDE(?SYS:K_PVN:Prompt)
     HIDE(?SYS:K_PVN)
     ?SYS:NOKL_dc:Prompt{PROP:TEXT}='Algas izmaksas &datums:'
     IF ~SYS:NOKL_TE[1:6]  THEN SYS:NOKL_TE[1:6] ='010091'.
     IF ~SYS:NOKL_TE[7:12] THEN SYS:NOKL_TE[7:12]='010096'.
     TPB_NO   = SYS:NOKL_TE[1:6]
     TPB_LIDZ = SYS:NOKL_TE[7:12]
  elsif inrange(job_nr,81,95) !**********************P/L
     DISABLE(?Tab:2) !ÂRÇJÂS IEKÂRTAS
     HIDE(?SYS:NOKL_dc:Prompt)
     HIDE(?SYS:NOKL_dc)
  elsif inrange(job_nr,96,120)!********************Laika maðîna
     DISABLE(?Tab:2) !ÂRÇJÂS IEKÂRTAS
     HIDE(?String11,?SYS:PZ_NR:2)
     ENABLE(?Tab:5)  !ALGAS-UDL
     Hide(?STRING11,?SYS:PZ_NR:2)
  ELSE
     STOP('JOB_NR='&JOB_NR)
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
       ! Elya
       IF sys:kases_ap = 32
          ?SYS:com_nr:Radio1{PROP:TEXT} = 'caur COM'
          ?SYS:com_nr:Radio2{PROP:TEXT} = 'caur IP'
       ELSE
          ?SYS:com_nr:Radio1{PROP:TEXT} = '1-Com1'
          ?SYS:com_nr:Radio2{PROP:TEXT} = '2-Com2'
      .
      
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?String4)
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
        History::SYS:Record = SYS:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(SYSTEM)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(SYS:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'SYS:NR_KEY')
                SELECT(?String4)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?String4)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::SYS:Record <> SYS:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:SYSTEM(1)
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
              SELECT(?String4)
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
          OF 5
          OF 6
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?SYS:NOKL_B
      CASE EVENT()
      OF EVENT:Accepted
        NOKL_B =SYS:NOKL_B !GETMYBANK() TÂPAT NOMAITÂ NOKL_B...
        GetMYbank()
        display
      END
    OF ?KASES_AP
      CASE EVENT()
      OF EVENT:Accepted
        IF NUMERIC(KASES_AP[2])
           sys:kases_ap=kases_ap[1:2]
        ELSE
           sys:kases_ap=kases_ap[1]
        .
        ! Elya
        IF sys:kases_ap = 32
            ?SYS:com_nr:Radio1{PROP:TEXT} = 'caur COM'
            ?SYS:com_nr:Radio2{PROP:TEXT} = 'caur IP'
        ELSE
            ?SYS:com_nr:Radio1{PROP:TEXT} = '1-Com1'
            ?SYS:com_nr:Radio2{PROP:TEXT} = '2-Com2'
        .
      END
    OF ?U_Skaneris
      CASE EVENT()
      OF EVENT:Accepted
        sys:u_skaneris=u_skaneris[1]
      END
    OF ?E_Svari
      CASE EVENT()
      OF EVENT:Accepted
        sys:e_svari=e_svari[1]
      END
    OF ?SK_Druka
      CASE EVENT()
      OF EVENT:Accepted
        sys:sk_druka=sk_druka[1]
      END
    OF ?SVYN
      CASE EVENT()
      OF EVENT:Accepted
          IF SVYN[1]='J' !DRUKÂT SVARU
             IF ~BAND(SYS:BAITS1,00010000B)
                SYS:BAITS1+=16
             .
          ELSE
             IF BAND(SYS:BAITS1,00010000B)
                SYS:BAITS1-=16
             .
          .
      END
    OF ?ButtonNerekinat
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF SYS:D_PR='N'
           SYS:D_PR=''
           HIDE(?ImageNerekinat)
        ELSE
           SYS:D_PR='N'
           UNHIDE(?ImageNerekinat)
        .
      END
    OF ?ButtonNemeklet
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF SYS:D_PA='N'
           SYS:D_PA=''
           HIDE(?ImageNemeklet)
        ELSE
           SYS:D_PA='N'
           UNHIDE(?ImageNemeklet)
        .
      END
    OF ?ButtonA4Nr
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         JADRUKA#=FALSE
         SAK_NR=SYS:PZ_NR
         BEI_NR=SYS:CEKA_NR
         OPEN(NOLIDZ_SCREEN)
         DISPLAY
         ACCEPT
            CASE FIELD()
            OF ?OKNOLIDZ
               IF EVENT()=EVENT:ACCEPTED
                  JADRUKA#=TRUE
                  BREAK
               .
            OF ?CANCELNOLIDZ
               IF EVENT()=EVENT:ACCEPTED
                  BREAK
               .
            .
         .
         CLOSE(NOLIDZ_SCREEN)
         IF JADRUKA#=TRUE
            OPEN(REPORT)
            report{Prop:Preview} = PrintPreviewImage
            LOOP I# = SAK_NR TO BEI_NR
               SETTARGET(REPORT)
               IMAGE(188,281,2083,521,'USER.BMP')
               pavadzime='pavadzîme '&CLIP(SYS:PZ_SERIJA)&' '&FORMAT(I#,@N06B)
               PRINT(RPT:DETAILA4)
            .
            ENDPAGE(report)
            RP
            IF GLOBALRESPONSE=REQUESTCOMPLETED
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
         .
      END
    OF ?ButtonMakaroni
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(SYS:BAITS,00000001B)
           SYS:BAITS-=1
           HIDE(?ImageMakaroni)
        ELSE
           SYS:BAITS+=1
           UNHIDE(?ImageMakaroni)
        .
      END
    OF ?ButtonDOKSAT
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(SYS:BAITS,00000010B)
           SYS:BAITS-=2
           HIDE(?ImageDOKSAT)
        ELSE
           SYS:BAITS+=2
           UNHIDE(?ImageDOKSAT)
        .
      END
    OF ?SUP_A4
      CASE EVENT()
      OF EVENT:Accepted
          IF SUP_A4[1]='S'
             IF BAND(SYS:BAITS1,00001000B)
                SYS:BAITS1-=8
             .
          ELSE
             IF ~BAND(SYS:BAITS1,00001000B)
                SYS:BAITS1+=8
             .
          .
      END
    OF ?NOA
      CASE EVENT()
      OF EVENT:Accepted
          IF NOA='J' !NOAPAÏOT CENU P/Z 2 zîmes
             IF ~BAND(SYS:BAITS1,00100000B)
                SYS:BAITS1+=32
             .
             IF BAND(SYS:BAITS1,01000000B)
                SYS:BAITS1-=64
             .
          ELSIF NOA='3' !NOAPAÏOT CENU P/Z 3 zîmes
             IF ~BAND(SYS:BAITS1,01000000B)
                SYS:BAITS1+=64
             .
             IF BAND(SYS:BAITS1,00100000B)
                SYS:BAITS1-=32
             .
          ELSE
             IF BAND(SYS:BAITS1,00100000B)
                SYS:BAITS1-=32
             .
             IF BAND(SYS:BAITS1,01000000B)
                SYS:BAITS1-=64
             .
          .
      END
    OF ?Nol_tips
      CASE EVENT()
      OF EVENT:Accepted
          IF NOL_TIPS[1]='M'
             IF BAND(SYS:BAITS1,00000100B)
                SYS:BAITS1-=4
             .
          ELSE
             IF ~BAND(SYS:BAITS1,00000100B)
                SYS:BAITS1+=4
             .
          .
      END
    OF ?SYS:UDL_S
      CASE EVENT()
      OF EVENT:Accepted
        PLKST=FORMAT(SYS:UDL_S,@T1)
        I#=PLKST[4:5]
        IF I#<30
           PLKST[4:5]='00'
        ELSE
           PLKST[4:5]='30'
        .
        SYS:UDL_S=DEFORMAT(PLKST,@T1)
        DISPLAY()
      END
    OF ?SYS:UDL_B
      CASE EVENT()
      OF EVENT:Accepted
        PLKST=FORMAT(SYS:UDL_B,@T1)
        I#=PLKST[4:5]
        IF I#<30
           PLKST[4:5]='00'
        ELSE
           PLKST[4:5]='30'
        .
        SYS:UDL_B=DEFORMAT(PLKST,@T1)
        DISPLAY()
      END
    OF ?SYS:UDL_6S
      CASE EVENT()
      OF EVENT:Accepted
        PLKST=FORMAT(SYS:UDL_6S,@T1)
        I#=PLKST[4:5]
        IF I#<30
           PLKST[4:5]='00'
        ELSE
           PLKST[4:5]='30'
        .
        SYS:UDL_6S=DEFORMAT(PLKST,@T1)
        DISPLAY()
      END
    OF ?SYS:UDL_6B
      CASE EVENT()
      OF EVENT:Accepted
        PLKST=FORMAT(SYS:UDL_6B,@T1)
        I#=PLKST[4:5]
        IF I#<30
           PLKST[4:5]='00'
        ELSE
           PLKST[4:5]='30'
        .
        SYS:UDL_6B=DEFORMAT(PLKST,@T1)
        DISPLAY()
      END
    OF ?SYS:UDL_7S
      CASE EVENT()
      OF EVENT:Accepted
        PLKST=FORMAT(SYS:UDL_7S,@T1)
        I#=PLKST[4:5]
        IF I#<30
           PLKST[4:5]='00'
        ELSE
           PLKST[4:5]='30'
        .
        SYS:UDL_7S=DEFORMAT(PLKST,@T1)
        DISPLAY()
      END
    OF ?SYS:UDL_7B
      CASE EVENT()
      OF EVENT:Accepted
        PLKST=FORMAT(SYS:UDL_7B,@T1)
        I#=PLKST[4:5]
        IF I#<30
           PLKST[4:5]='00'
        ELSE
           PLKST[4:5]='30'
        .
        SYS:UDL_7B=DEFORMAT(PLKST,@T1)
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
  NOKL_CP=SYS:NOKL_CP  !Noklusçtâ cena precei
  NOKL_CA=SYS:NOKL_CA  !Noklusçtâ cena pakalpojumiem
  NOKL_B =SYS:NOKL_B   !Noklusçtâ banka
  SYS_PARAKSTS_NR=SYS:PARAKSTS_NR !PARAKSTA NR
  IF inrange(job_nr,66,80) !Alga
     SYS:NOKL_TE[1:6] =TPB_NO
     SYS:NOKL_TE[7:12]=TPB_LIDZ
  .
  SYS:ACC_KODS=ACC_kods
  SYS:ACC_DATUMS=today()

!        IF inrange(job_nr,16,40)      !NOLIKTAVA
!           IF ~BAND(SYS:BAITS1,01000000B)
!              KLUDA(0,'Jums var bût virkne problçmu, ja kontçjumâ stornçsiet -D P/Z, sk.Autokontçjumi')
!           .
!           IF BAND(SYS:BAITS1,00000100B) !Vairumtirdzniecîba
!              IF ~BAND(SYS:BAITS1,10000000B)
!                 KLUDA(0,'Neaizmirstiet, ka Vairumtirdzniecîbâ apmaksâtu P/Z nedrîkst stornçt, sk.Autokontçjumi')
!              .
!           ELSE                          !Mazumtirdzniecîba
!              IF BAND(SYS:BAITS1,10000000B)
!                 KLUDA(0,'Kases STORNO èeku nedrîkst uzskatît par preèu iegâdes dokumentu, sk.Autokontçjumi')
!              .
!           .
!        .
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
  IF GLOBAL::Used = 0
    CheckOpen(GLOBAL,1)
  END
  GLOBAL::Used += 1
  BIND(GL:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  RISnap:SYSTEM
  SAV::SYS:Record = SYS:Record
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
        IF RIDelete:SYSTEM()
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
  INIRestoreWindow('UpdateSystem','winlats.INI')
  WinResize.Resize
  ?SYS:AVOTA_NR{PROP:Alrt,255} = 734
  ?SYS:AVOTS{PROP:Alrt,255} = 734
  ?SYS:ADRESE{PROP:Alrt,255} = 734
  ?SYS:TEL{PROP:Alrt,255} = 734
  ?SYS:FAX{PROP:Alrt,255} = 734
  ?SYS:NOKL_PVN{PROP:Alrt,255} = 734
  ?SYS:NOKL_PB{PROP:Alrt,255} = 734
  ?SYS:K_PVN{PROP:Alrt,255} = 734
  ?SYS:NOKL_B{PROP:Alrt,255} = 734
  ?SYS:NOKL_DC{PROP:Alrt,255} = 734
  ?SYS:PARAKSTS1{PROP:Alrt,255} = 734
  ?SYS:AMATS1{PROP:Alrt,255} = 734
  ?SYS:PARAKSTS2{PROP:Alrt,255} = 734
  ?SYS:AMATS2{PROP:Alrt,255} = 734
  ?SYS:PARAKSTS3{PROP:Alrt,255} = 734
  ?SYS:E_MAIL{PROP:Alrt,255} = 734
  ?SYS:com_nr{PROP:Alrt,255} = 734
  ?SYS:NOKL_CP:2{PROP:Alrt,255} = 734
  ?SYS:NOKL_CA:2{PROP:Alrt,255} = 734
  ?SYS:CEKA_NR{PROP:Alrt,255} = 734
  ?SYS:kontrolcipars{PROP:Alrt,255} = 734
  ?SYS:Tuksni{PROP:Alrt,255} = 734
  ?SYS:REF_AVOTS{PROP:Alrt,255} = 734
  ?SYS:NODALA{PROP:Alrt,255} = 734
  ?SYS:Tuksni:2{PROP:Alrt,255} = 734
  ?SYS:NOKL_CP{PROP:Alrt,255} = 734
  ?SYS:NOKL_CA{PROP:Alrt,255} = 734
  ?SYS:NOM_CIT{PROP:Alrt,255} = 734
  ?SYS:NOKL_TE{PROP:Alrt,255} = 734
  ?SYS:ATLAUJA{PROP:Alrt,255} = 734
  ?SYS:PZ_SERIJA{PROP:Alrt,255} = 734
  ?SYS:PZ_NR{PROP:Alrt,255} = 734
  ?SYS:PZ_NR_END{PROP:Alrt,255} = 734
  ?SYS:SUP_A4_NR{PROP:Alrt,255} = 734
  ?SYS:PARAKSTS_NR{PROP:Alrt,255} = 734
  ?SYS:D_KO{PROP:Alrt,255} = 734
  ?SYS:PZ_NR:2{PROP:Alrt,255} = 734
  ?SYS:UDL_S{PROP:Alrt,255} = 734
  ?SYS:UDL_B{PROP:Alrt,255} = 734
  ?SYS:UDL_6S{PROP:Alrt,255} = 734
  ?SYS:UDL_6B{PROP:Alrt,255} = 734
  ?SYS:UDL_7S{PROP:Alrt,255} = 734
  ?SYS:UDL_7B{PROP:Alrt,255} = 734
  ?SYS:ACC_KODS{PROP:Alrt,255} = 734
  ?SYS:ACC_DATUMS{PROP:Alrt,255} = 734
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
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
    INISaveWindow('UpdateSystem','winlats.INI')
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
    OF ?SYS:AVOTA_NR
      SYS:AVOTA_NR = History::SYS:Record.AVOTA_NR
    OF ?SYS:AVOTS
      SYS:AVOTS = History::SYS:Record.AVOTS
    OF ?SYS:ADRESE
      SYS:ADRESE = History::SYS:Record.ADRESE
    OF ?SYS:TEL
      SYS:TEL = History::SYS:Record.TEL
    OF ?SYS:FAX
      SYS:FAX = History::SYS:Record.FAX
    OF ?SYS:NOKL_PVN
      SYS:NOKL_PVN = History::SYS:Record.NOKL_PVN
    OF ?SYS:NOKL_PB
      SYS:NOKL_PB = History::SYS:Record.NOKL_PB
    OF ?SYS:K_PVN
      SYS:K_PVN = History::SYS:Record.K_PVN
    OF ?SYS:NOKL_B
      SYS:NOKL_B = History::SYS:Record.NOKL_B
    OF ?SYS:NOKL_DC
      SYS:NOKL_DC = History::SYS:Record.NOKL_DC
    OF ?SYS:PARAKSTS1
      SYS:PARAKSTS1 = History::SYS:Record.PARAKSTS1
    OF ?SYS:AMATS1
      SYS:AMATS1 = History::SYS:Record.AMATS1
    OF ?SYS:PARAKSTS2
      SYS:PARAKSTS2 = History::SYS:Record.PARAKSTS2
    OF ?SYS:AMATS2
      SYS:AMATS2 = History::SYS:Record.AMATS2
    OF ?SYS:PARAKSTS3
      SYS:PARAKSTS3 = History::SYS:Record.PARAKSTS3
    OF ?SYS:E_MAIL
      SYS:E_MAIL = History::SYS:Record.E_MAIL
    OF ?SYS:com_nr
      SYS:com_nr = History::SYS:Record.com_nr
    OF ?SYS:NOKL_CP:2
      SYS:NOKL_CP = History::SYS:Record.NOKL_CP
    OF ?SYS:NOKL_CA:2
      SYS:NOKL_CA = History::SYS:Record.NOKL_CA
    OF ?SYS:CEKA_NR
      SYS:CEKA_NR = History::SYS:Record.CEKA_NR
    OF ?SYS:kontrolcipars
      SYS:kontrolcipars = History::SYS:Record.kontrolcipars
    OF ?SYS:Tuksni
      SYS:Tuksni = History::SYS:Record.Tuksni
    OF ?SYS:REF_AVOTS
      SYS:REF_AVOTS = History::SYS:Record.REF_AVOTS
    OF ?SYS:NODALA
      SYS:NODALA = History::SYS:Record.NODALA
    OF ?SYS:Tuksni:2
      SYS:Tuksni = History::SYS:Record.Tuksni
    OF ?SYS:NOKL_CP
      SYS:NOKL_CP = History::SYS:Record.NOKL_CP
    OF ?SYS:NOKL_CA
      SYS:NOKL_CA = History::SYS:Record.NOKL_CA
    OF ?SYS:NOM_CIT
      SYS:NOM_CIT = History::SYS:Record.NOM_CIT
    OF ?SYS:NOKL_TE
      SYS:NOKL_TE = History::SYS:Record.NOKL_TE
    OF ?SYS:ATLAUJA
      SYS:ATLAUJA = History::SYS:Record.ATLAUJA
    OF ?SYS:PZ_SERIJA
      SYS:PZ_SERIJA = History::SYS:Record.PZ_SERIJA
    OF ?SYS:PZ_NR
      SYS:PZ_NR = History::SYS:Record.PZ_NR
    OF ?SYS:PZ_NR_END
      SYS:PZ_NR_END = History::SYS:Record.PZ_NR_END
    OF ?SYS:SUP_A4_NR
      SYS:SUP_A4_NR = History::SYS:Record.SUP_A4_NR
    OF ?SYS:PARAKSTS_NR
      SYS:PARAKSTS_NR = History::SYS:Record.PARAKSTS_NR
    OF ?SYS:D_KO
      SYS:D_KO = History::SYS:Record.D_KO
    OF ?SYS:PZ_NR:2
      SYS:PZ_NR = History::SYS:Record.PZ_NR
    OF ?SYS:UDL_S
      SYS:UDL_S = History::SYS:Record.UDL_S
    OF ?SYS:UDL_B
      SYS:UDL_B = History::SYS:Record.UDL_B
    OF ?SYS:UDL_6S
      SYS:UDL_6S = History::SYS:Record.UDL_6S
    OF ?SYS:UDL_6B
      SYS:UDL_6B = History::SYS:Record.UDL_6B
    OF ?SYS:UDL_7S
      SYS:UDL_7S = History::SYS:Record.UDL_7S
    OF ?SYS:UDL_7B
      SYS:UDL_7B = History::SYS:Record.UDL_7B
    OF ?SYS:ACC_KODS
      SYS:ACC_KODS = History::SYS:Record.ACC_KODS
    OF ?SYS:ACC_DATUMS
      SYS:ACC_DATUMS = History::SYS:Record.ACC_DATUMS
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
  SYS:Record = SAV::SYS:Record
  SAV::SYS:Record = SYS:Record
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

