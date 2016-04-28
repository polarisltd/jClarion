                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateGG PROCEDURE


CurrentTab           STRING(80)
FORCEDPARCHANGE      BYTE
FORCEDatlaideCHANGE  BYTE
FORCEDPVNCHANGE18    BYTE
FORCEDPVNCHANGE5     BYTE
ForcedNodalaChange   BYTE
ForcedProjektsChange BYTE
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
gg_summa             DECIMAL(11,2)
gg_summav            DECIMAL(11,2)
K_summa18            DECIMAL(11,2)
K_SUMMA5             DECIMAL(11,2)
COUNT_PVNSUMMA18     DECIMAL(11,2)
COUNT_PVNSUMMA5      DECIMAL(11,2)
CALC_PVNSUMMA18      DECIMAL(11,2)
calc_pvnsumma5       DECIMAL(11,2)
KKSTRING             STRING(8)
MULTIVAL             BYTE
FIRSTVAL             STRING(3)
stringbyte           STRING(8)
OK                   BYTE
atlaide              DECIMAL(3,1)
gg_atlaide           DECIMAL(3,1)
diena_v              STRING(11)
LIST:ATT_DOK         QUEUE,PRE()
ATT_DOK              STRING(23)
                     END
FOUND_BANKA          BYTE
FOUND_KASE           BYTE
CHECK_DAT            DECIMAL(3)
BILANCE_VAL          DECIMAL(11,2)
summaB          DECIMAL(11,2)
summAA          DECIMAL(11,2)
sav_rs          decimal(1)
DARBIBA         STRING(7)
avansieris      STRING(15)
KKS             DECIMAL(11,2),DIM(8)
KK_SUMMA        DECIMAL(11,2)
NOKL_DC         LONG
CHECK_ES        STRING(3)
Nodala          STRING(2)
Projekts        USHORT
NODtext         STRING(25)
PROtext         STRING(25)
CHECK_PAR_NR    STRING(1)
PVN5            BYTE
PVN18           BYTE
PAR_L_SUMMA1    LIKE(PAR:L_SUMMA1)

B_TABLE     QUEUE,PRE(B)
K_D             STRING(1)
BKK             STRING(5)
SUMMA           DECIMAL(11,2)
            .

G_TABLE     QUEUE,PRE(G)
G:U_NR          LIKE(GG:U_NR)
G:RS            LIKE(GGK:RS)
G:DATUMS        LIKE(GGK:DATUMS)
G:PAR_NR        LIKE(GGK:PAR_NR)
G:D_K           LIKE(GGK:D_K)
G:BKK           LIKE(GGK:BKK)
G:SUMMA         LIKE(GGK:SUMMA)
G:SUMMAV        LIKE(GGK:SUMMAV)
G:VAL           LIKE(GGK:VAL)
G:PVN_TIPS      LIKE(GGK:PVN_TIPS)
G:PVN_PROC      LIKE(GGK:PVN_PROC)
G:BAITS         LIKE(GGK:BAITS)
G:KK            LIKE(GGK:KK)
G:NODALA        LIKE(GGK:NODALA)
G:OBJ_NR        LIKE(GGK:OBJ_NR)
            .

INIFILE                 FILE,DRIVER('ASCII'),NAME('WINLATS.INI'),PRE(INI),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
LINE                        STRING(80)
                         END
                       END

AtlWindow WINDOW(' '),AT(,,164,69),GRAY
       STRING('Mainît atlaidi no '),AT(27,29),USE(?String1)
       STRING(@n-5.1),AT(84,29),USE(GG_Atlaide)
       STRING('uz'),AT(106,29),USE(?String3)
       ENTRY(@n-5.1),AT(118,27),USE(GG:Atlaide)
       BUTTON('&OK'),AT(87,50,35,14),USE(?OkButtonA),DEFAULT
       BUTTON('&Atlikt'),AT(124,50,36,14),USE(?CancelButtonA)
     END

NodWindow WINDOW(' '),AT(,,154,75),CENTER,GRAY
       STRING('Mainît Nodaïu visam kontçjumam uz'),AT(10,13),USE(?StringMAINITNODALU)
       BUTTON('Nodaïas'),AT(67,26,54,14),USE(?ButtonNodala)
       ENTRY(@s2),AT(126,27),USE(Nodala)
       STRING(@s25),AT(42,41),USE(NODTEXT),CENTER
       BUTTON('&OK'),AT(70,54,35,14),USE(?OkButtonN),DEFAULT
       BUTTON('&Atlikt'),AT(107,54,36,14),USE(?CancelButtonN)
     END

PROWindow WINDOW(' '),AT(,,199,76),CENTER,GRAY
       STRING('Mainît Projektu(objektu) visam kontçjumam uz'),AT(27,13),USE(?StringMainitProjektu)
       BUTTON('Projekti'),AT(64,26,75,14),USE(?ButtonProjekts)
       ENTRY(@N6),AT(143,27),USE(Projekts)
       STRING(@s25),AT(85,41),USE(PROTEXT),CENTER
       BUTTON('&OK'),AT(116,54,35,14),USE(?OkButtonP),DEFAULT
       BUTTON('&Atlikt'),AT(153,54,36,14),USE(?CancelButtonP)
     END

BRW2::View:Browse    VIEW(GGK)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:NODALA)
                       PROJECT(GGK:OBJ_NR)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:PVN_PROC)
                       PROJECT(GGK:VAL)
                       PROJECT(GGK:REFERENCE)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:U_NR)
                     END

Queue:Browse:2       QUEUE,PRE()                  ! Browsing Queue
BRW2::GGK:D_K          LIKE(GGK:D_K)              ! Queue Display field
BRW2::GGK:BKK          LIKE(GGK:BKK)              ! Queue Display field
BRW2::GGK:NODALA       LIKE(GGK:NODALA)           ! Queue Display field
BRW2::GGK:OBJ_NR       LIKE(GGK:OBJ_NR)           ! Queue Display field
BRW2::GGK:SUMMA        LIKE(GGK:SUMMA)            ! Queue Display field
BRW2::GGK:SUMMAV       LIKE(GGK:SUMMAV)           ! Queue Display field
BRW2::GGK:PVN_PROC     LIKE(GGK:PVN_PROC)         ! Queue Display field
BRW2::GGK:VAL          LIKE(GGK:VAL)              ! Queue Display field
BRW2::GGK:REFERENCE    LIKE(GGK:REFERENCE)        ! Queue Display field
BRW2::GGK:PAR_NR       LIKE(GGK:PAR_NR)           ! Queue Display field
BRW2::KKSTRING         LIKE(KKSTRING)             ! Queue Display field
BRW2::ATLAUTS          LIKE(ATLAUTS)              ! Queue Display field
BRW2::GGK:U_NR         LIKE(GGK:U_NR)             ! Queue Display field
BRW2::Mark             BYTE                       ! Queue POSITION information
BRW2::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW2::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW2::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW2::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW2::Sort1:KeyDistribution LIKE(GGK:BKK),DIM(100)
BRW2::Sort1:LowValue LIKE(GGK:BKK)                ! Queue position of scroll thumb
BRW2::Sort1:HighValue LIKE(GGK:BKK)               ! Queue position of scroll thumb
BRW2::Sort1:Reset:GG:U_NR LIKE(GG:U_NR)
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
History::GG:Record LIKE(GG:Record),STATIC
SAV::GG:Record       LIKE(GG:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:GG:U_NR      LIKE(GG:U_NR)
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Dokumenta Update (GG)'),AT(1,0,449,297),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateGG'),GRAY,RESIZE,MDI
                       BUTTON('&Y-Raksta statuss'),AT(92,12,61,14),USE(?Rakstastatuss)
                       IMAGE('CANCEL4.ICO'),AT(158,5,19,20),USE(?Image1),HIDE
                       STRING('UNr:'),AT(13,0),USE(?String8),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       STRING(@n_7.0),AT(30,0),USE(GG:U_NR),RIGHT,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       STRING('ES:'),AT(13,10),USE(?String10)
                       STRING(@n1),AT(51,10),USE(GG:ES),RIGHT
                       STRING('ImpAvots:'),AT(13,19),USE(?String12)
                       STRING(@n3),AT(46,19),USE(GG:IMP_NR),RIGHT
                       PROMPT('Attais&n. Dokuments:'),AT(13,31,73,10),USE(?GG:ATT_DOK:Prompt)
                       LIST,AT(89,28,90,12),USE(ATT_DOK),FORMAT('40L@s25@'),DROP(11),FROM(LIST:ATT_DOK)
                       PROMPT('Apmaksât &lîdz ...'),AT(21,63,62,10),USE(?GG:APMDAT:Prompt)
                       BUTTON('+0'),AT(88,59,27,12),USE(?ButtonApmLidz)
                       ENTRY(@d06.B),AT(117,59,52,13),USE(GG:APMDAT),FONT(,10,,)
                       BUTTON('Ð'),AT(101,74,13,14),USE(?Sodiena)
                       PROMPT('&Grâmatojuma datums:'),AT(21,91,73,10),USE(?GG:DATUMS:Prompt)
                       SPIN(@d06.B),AT(117,89,61,13),USE(GG:DATUMS),FONT(,10,,),REQ,RANGE(4,109211),STEP(1)
                       STRING(@n-4B),AT(179,91,14,10),USE(CHECK_DAT),FONT(,,COLOR:Red,FONT:bold,CHARSET:ANSI)
                       PROMPT('Dokumenta Sç&rija-Nr:'),AT(12,46,73,10),USE(?GG:DOK_NR:Prompt)
                       ENTRY(@s14),AT(89,43,80,12),USE(GG:DOK_SENR),RIGHT(1)
                       PROMPT('Do&kumenta datums:'),AT(21,78,70,10),USE(?GG:DOKDAT:Prompt)
                       SPIN(@d06.B),AT(117,74,61,13),USE(GG:DOKDAT),FONT(,10,,),REQ,RANGE(4,109211),STEP(1)
                       BUTTON('='),AT(101,88,13,14),USE(?Lidzinas)
                       STRING(@s11),AT(117,104,56,10),USE(diena_v),CENTER
                       BUTTON('&Partneris'),AT(24,115,45,14),USE(?PARTNERIS)
                       ENTRY(@s15),AT(73,115,69,12),USE(GG:NOKA)
                       STRING(@n_9),AT(144,118),USE(GG:PAR_NR),CENTER
                       STRING(@S1),AT(185,118,9,10),USE(CHECK_PAR_NR),CENTER,FONT(,,COLOR:Red,FONT:bold,CHARSET:ANSI)
                       BUTTON('=>ggk'),AT(153,128,25,13),USE(?ggkparchange)
                       BUTTON('&Tekstu plâns'),AT(24,142,45,14),USE(?TekstuPlans)
                       BUTTON('&5-Uzbûvçt pçcgarantijas Rçíinu'),AT(71,142,119,14),USE(?UzbRekASSAKO),HIDE
                       ENTRY(@s47),AT(2,160,190,12),USE(GG:SATURS),TIP('Labâ pele: mainît CASE'),OVR
                       ENTRY(@s47),AT(2,174,190,12),USE(GG:SATURS2),TIP('Labâ pele: mainît CASE'),OVR
                       ENTRY(@s47),AT(2,188,190,12),USE(GG:SATURS3),TIP('Labâ pele: mainît CASE'),OVR
                       BUTTON('&6-Uzbûvçt viòu apmaksu pçc mûsu Rçíina'),AT(6,218,150,14),USE(?Apmaksano231),MSG('Âtrais kontçjums : D26200-K231...'),TIP('Âtrais kontçjums : D26200-K231...')
                       BUTTON('&7-Uzbûvçt mûsu apmaksu pçc viòu Rçíina'),AT(6,234,150,14),USE(?Apmaksauz531),MSG('Âtrais kontçjums : K26200-D531...-K23990-D57210'),TIP('Âtrais kontçjums : K26200-D531...-K23990-D57210')
                       SHEET,AT(194,0,255,271),USE(?CurrentTab)
                         TAB('&0-Dokumenta kontçjums (GGK)'),USE(?Tab:3)
                           LIST,AT(198,18,248,189),USE(?Browse:2),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('10C|M@s1@21L|M~BKK~L(2)@s5@10C|M~N~@s2@23R(1)|M~P~C(0)@N_6B@46D(12)|M~Summa~C(0)' &|
   '@n-15.2@48D(12)|M~Summa valutâ~C(0)@n-15.2@10R(1)|M~%~C(0)@n2@15C|M~VAL~@s3@40R|' &|
   'M~Refer.~C@s14@29R(1)|M~Par.Nr.~C(0)@n_7.0@30L(1)|M~KontuKor~L(0)@s8@'),FROM(Queue:Browse:2)
                           STRING('KK Kïûda'),AT(411,2),USE(?KKKluda),HIDE,FONT(,,COLOR:Red,)
                           STRING('Summa :'),AT(242,211),USE(?String4)
                           STRING(@n-15.2),AT(278,211),USE(GG:SUMMA),RIGHT(2)
                           STRING(@s3),AT(342,211,17,10),USE(GG:VAL)
                           STRING('Bilance:'),AT(242,221),USE(?String5)
                           STRING(@n-15.2),AT(278,221),USE(bilance),RIGHT(2)
                           STRING(@s3),AT(342,221,14,10),USE(Val_uzsk)
                           BUTTON('PVN:ar'),AT(358,216,31,14),USE(?PVN),FONT('MS Sans Serif',,,,CHARSET:BALTIC),TIP('Sarçíinâs un pârrakstîs PVN,ja kursors uz summas ar PVN ')
                           BUTTON('PVN:Kr-Sum:bez'),AT(390,216,57,14),USE(?PVN:2),FONT('MS Sans Serif',,,,CHARSET:BALTIC),TIP('Sarçíinâs un pârrakstîs PVN,  no visu K summas')
                           BUTTON('Maks.&uzdevums'),AT(198,233,64,14),USE(?MU)
                           BUTTON('Ka&ses orderis'),AT(264,233,50,14),USE(?ko)
                           BUTTON('KO &bez pasakòa'),AT(316,233,63,14),USE(?ko:2)
                           BUTTON('I&zlîdzinât summu'),AT(381,233,65,14),USE(?Izlidzinat)
                           BUTTON('&Elektroniskâ maks.sag.'),AT(198,251,81,14),USE(?elmaks)
                           BUTTON('Kopçt'),AT(280,252,22,13),USE(?Kopet)
                           BUTTON('&Ievadît'),AT(303,251,45,14),USE(?Insert:3)
                           BUTTON('&Mainît'),AT(351,251,45,14),USE(?Change:3),DEFAULT
                           BUTTON('&Dzçst'),AT(399,251,45,14),USE(?Delete:3)
                         END
                       END
                       BUTTON('Nodaïa'),AT(261,276,31,14),USE(?BUTTON:Nodala)
                       BUTTON('Projekts(Objekts)'),AT(293,276,58,14),USE(?BUTTON:Projekts)
                       BUTTON('&OK'),AT(357,276,45,14),USE(?OK)
                       BUTTON('&Atlikt'),AT(404,276,45,14),USE(?Cancel)
                       BUTTON('Pierakstît P&VN'),AT(6,203,58,14),USE(?PierPVN)
                       BUTTON('&8-Tieðais Imports no Noliktavas'),AT(7,249,149,14),USE(?TiesaisImportsNoNoliktavas)
                       BUTTON('&9-Uzbûvçt Ieskaitu'),AT(6,265,150,14),USE(?IESKAITS),MSG('Âtrais kontçjums : D26200-K231...'),TIP('Âtrais kontçjums : D26200-K231...')
                       STRING(@s8),AT(7,285),USE(GG:ACC_KODS),DISABLE
                       STRING(@d06.B),AT(42,285),USE(GG:ACC_DATUMS),DISABLE
                       PROMPT('Se&cîba:'),AT(89,284),USE(?GG:SECIBA:Prompt)
                       ENTRY(@T4),AT(118,283,38,10),USE(GG:SECIBA),CENTER
                       BUTTON('= Plkst.'),AT(160,281,32,14),USE(?clock)
                       BUTTON('Atlaide:'),AT(195,276,35,14),USE(?Atlaide),DISABLE
                       STRING(@n-5.1),AT(231,279),USE(GG:Atlaide,,GG:ATLAIDE:2)
                       STRING('%'),AT(252,279),USE(?String14)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  CHECKOPEN(GGK,1)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  IF ATLAUTS[18]='1' OR GG:U_NR=1 !SALDO vai AIZLIEGTI NEAPSTIPRINÂTIE
     HIDE(?Rakstastatuss)
  ELSE
     IF gg:rs
        UNHIDE(?IMAGE1)
     ELSE
        HIDE(?IMAGE1)
     .
  .
  IF GG:U_NR=1 !SALDO
     HIDE(?GG:APMDAT)
     HIDE(?ButtonApmLidz)
     HIDE(?GG:APMDAT:Prompt)
     HIDE(?ATT_DOK)
     HIDE(?GG:ATT_DOK:Prompt)
  .
  CHECKOPEN(SYSTEM,1)
!  IF LOCALREQUEST=1 THEN NOKL_DC=SYS:NOKL_DC. !CITÂDI NOMAITÂ LABOÐANU, JA ATSTÂTA NULLE
  NOKL_DC=SYS:NOKL_DC 
  ?ButtonApmLidz{PROP:TEXT}='+'&nokl_dc
  ActionMessage='Aplûkoðanas reþîms'
  EXECUTE GG:DATUMS%7+1
     DIENA_V='Svçtdiena'
     DIENA_V='Pirmdiena'
     DIENA_V='Otrdiena'
     DIENA_V='Treðdiena'
     DIENA_V='Ceturtdiena'
     DIENA_V='Piektdiena'
     DIENA_V='Sestdiena'
  .
  display(?diena_v)

!  IF YEAR(DB_S_DAT)>2009
  IF DB_GADS>2009
     ATT_DOK=' ' !NAV
     ADD(LIST:ATT_DOK)
     ATT_DOK='1-nodokïa rçíins'
     ADD(LIST:ATT_DOK)
     ATT_DOK='2-kases èeks vai kvîts'
     ADD(LIST:ATT_DOK)
     ATT_DOK='3-bezskaidras naudas MD'
     ADD(LIST:ATT_DOK)
     ATT_DOK='4-kredîtrçíins'
     ADD(LIST:ATT_DOK)
     ATT_DOK='5-cits'
     ADD(LIST:ATT_DOK)
     ATT_DOK='6-muitas deklarâcija'
     ADD(LIST:ATT_DOK)
     ATT_DOK='X-atseviðíi neuzrâdâmie darîjumi'
     ADD(LIST:ATT_DOK)
     IF INRANGE(GG:ATT_DOK,1,6)
        NR#=GG:ATT_DOK
     ELSIF GG:ATT_DOK='X'
        NR#=7
     ELSE
        NR#=0
     .
  ELSE
     ATT_DOK=' ' !NAV
     ADD(LIST:ATT_DOK)
     ATT_DOK='1-Cits'
     ADD(LIST:ATT_DOK)
     ATT_DOK='2-PPR'
     ADD(LIST:ATT_DOK)
     ATT_DOK='3-Maks.dok'
     ADD(LIST:ATT_DOK)
     ATT_DOK='4-EKA èeks'
     ADD(LIST:ATT_DOK)
     ATT_DOK='5-Lîgums'
     ADD(LIST:ATT_DOK)
     ATT_DOK='6-Faktûrrçíins'
     ADD(LIST:ATT_DOK)
     ATT_DOK='7-Kredîtrçíins'
     ADD(LIST:ATT_DOK)
     ATT_DOK='8-Akts'
     ADD(LIST:ATT_DOK)
     ATT_DOK='9-Protokols'
     ADD(LIST:ATT_DOK)
     ATT_DOK='0-Muitas dekl.'
     ADD(LIST:ATT_DOK)
     IF GG:ATT_DOK='0'
        NR#=GG:ATT_DOK+10
     ELSE
        NR#=GG:ATT_DOK
     .
  .
  GET(LIST:ATT_DOK,NR#+1) !STRINGU NEÒEM
  
  IF ACC_KODS_N=0  !ASSAKO
     UNHIDE(?UzbRekASSAKO)
     IF GG:U_NR=1  !SALDO
        ?UzbRekASSAKO{PROP:TEXT}='Saspiest 231.. 1 partnerim'
     .
  .
  IF BROWSEPAR_K::USED=TRUE
     DISABLE(?PARTNERIS)
     DISABLE(?UzbRekASSAKO)
     DISABLE(?TekstuPlans)
  .
  IF BAND(REG_BASE_ACC,00000010b) ! Budþets
     ?BUTTON:Projekts{PROP:TEXT}='Klasif.kods'
  .
  
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
!    if MULTIVAL
!       gg:summa=gg_summa_ls
!       gg:val='Ls'
!!       ksumma=ksumma_ls18+KSUMMA_LS5
!    else
!       gg:summa=gg_summa_val
!       gg:val=val_nos
!       ksumma=ksumma_val
!    .
!    BILANCE=gg:summa-ksumma
    CHECK_DAT=GG:DATUMS-TODAY()
    display
    CASE LOCALREQUEST
    OF 1
       IF RECORDS(Queue:Browse:2)
          DISABLE(?CANCEL)
          ALIAS(EscKey,0) ! Novâcam EscKey
       ELSIF RECORDS(Queue:Browse:2)=0
          ENABLE(?CANCEL)
          ALIAS
       .
    OF 2
       IF BILANCE
          DISABLE(?CANCEL)
          ALIAS(EscKey,0) ! Novâcam EscKey
       ELSE
          ENABLE(?CANCEL)
          ALIAS
       .
    .
    IF RECORDS(Queue:Browse:2)
       DISABLE(?Apmaksano231)
       DISABLE(?Apmaksauz531)
       DISABLE(?TiesaisImportsNoNoliktavas)
       DISABLE(?IESKAITS)
       ENABLE(?ATLAIDE)
    .
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE()=MouseRight
         CASE FOCUS()
         OF ?GG:SATURS
            UPDATE(?GG:SATURS)
            GG:SATURS=INIGEN(GG:SATURS,LEN(CLIP(GG:SATURS)),3)
         OF ?GG:SATURS2
            UPDATE(?GG:SATURS2)
            GG:SATURS2=INIGEN(GG:SATURS2,LEN(CLIP(GG:SATURS2)),3)
         OF ?GG:SATURS3
            UPDATE(?GG:SATURS3)
            GG:SATURS3=INIGEN(GG:SATURS3,LEN(CLIP(GG:SATURS3)),3)
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
      DO BRW2::AssignButtons
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Rakstastatuss)
      IF LOCALREQUEST=2
         SELECT(?Browse:2)
      ELSIF LOCALREQUEST=1
         SELECT(?GG:DOK_SENR)
      ELSIF LOCALREQUEST=3
         quickwindow{prop:color}=color:activeborder
         disable(1,?STRING14)
         enable(?Tab:3)
         ENable(?OK)
         ENable(?cancel)
         SELECT(?cancel)
      ELSE
         quickwindow{prop:color}=color:activeborder
         disable(1,?STRING14)
         enable(?Tab:3)
         ENable(?cancel)
         SELECT(?cancel)
      .
    OF EVENT:GainFocus
      OMIT('ForceRefresh = True')
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
        History::GG:Record = GG:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(GG)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(GG:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'GG:NR_KEY')
                SELECT(?Rakstastatuss)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?Rakstastatuss)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::GG:Record <> GG:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:GG(1)
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
              SELECT(?Rakstastatuss)
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
            IF RIDelete:GG()
              SETCURSOR()
              CASE StandardWarning(Warn:DeleteError)
              OF Button:Yes
                CYCLE
              OF Button:No
                POST(Event:CloseWindow)
                BREAK
              OF Button:Cancel
                DISPLAY
                SELECT(?Rakstastatuss)
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
    OF ?Rakstastatuss
      CASE EVENT()
      OF EVENT:Accepted
        IF gg:rs
           gg:rs=''
           HIDE(?IMAGE1)
        ELSE
           gg:rs='1'
           UNHIDE(?IMAGE1)
         .
        !forcedstatchange=1       ! pagaidâm RS_GGK=RS_GG
        DO BRW2::InitializeBrowse
        DO BRW2::RefreshPage
        !forcedstatchange=0
        display
        DO SyncWindow
      END
    OF ?ATT_DOK
      CASE EVENT()
      OF EVENT:Accepted
        GG:ATT_DOK=ATT_DOK[1]
      END
    OF ?ButtonApmLidz
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GG:APMDAT=GG:DOKDAT+NOKL_DC
        DISPLAY
      END
    OF ?Sodiena
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        gg:dokdat=TODAY()
        DISPLAY
      END
    OF ?GG:DATUMS
      CASE EVENT()
      OF EVENT:Accepted
        IF GG:DATUMS < SYS:GIL_SHOW  ! SLÇGTS APGABALS
            KLUDA(27,'DATUMS, Datu bloks ir slçgts...lîdz '&FORMAT(SYS:GIL_SHOW,@D06.))
            SELECT(?GG:DATUMS)
        ELSE
           SAV_datums=gg:datums
           EXECUTE GG:DATUMS%7+1
              DIENA_V='Svçtdiena'
              DIENA_V='Pirmdiena'
              DIENA_V='Otrdiena'
              DIENA_V='Treðdiena'
              DIENA_V='Ceturtdiena'
              DIENA_V='Piektdiena'
              DIENA_V='Sestdiena'
           .
           display(?diena_v)
           DO BRW2::InitializeBrowse   ! Lai nomaina GGK, ja mainâs datums
           DO BRW2::RefreshPage
        .
        GG:DATUMS=GETFING(3,GG:DATUMS) !3-AR FING KONTROLI
        SELECT(?PARTNERIS)
      END
    OF ?Lidzinas
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        gg:datums=gg:dokdat
        IF GG:DATUMS < SYS:GIL_SHOW  ! SLÇGTS APGABALS
            KLUDA(27,'DATUMS, Datu bloks ir slçgts...')
            SELECT(?GG:DATUMS)
        ELSE
           SAV_datums=gg:datums
           EXECUTE GG:DATUMS%7+1
              DIENA_V='Svçtdiena'
              DIENA_V='Pirmdiena'
              DIENA_V='Otrdiena'
              DIENA_V='Treðdiena'
              DIENA_V='Ceturtdiena'
              DIENA_V='Piektdiena'
              DIENA_V='Sestdiena'
           .
           display(?diena_v)
           DO BRW2::InitializeBrowse   ! Lai nomaina GGK, ja mainâs datums
           DO BRW2::RefreshPage
           display(?gg:datums)
           select(?partneris)
        .
      END
    OF ?PARTNERIS
      CASE EVENT()
      OF EVENT:Accepted
        IF GG:PAR_NR
           PAR_NR=GG:PAR_NR
        .
        GG::U_NR=GG:U_NR !LAI ZINÂTU, KA IZSAIKTS NO UPDATEGG
        
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           GG::U_NR=0 !LAI ZINÂTU, KA IZSAIKTS NO UPDATEGG
           GG:NOKA=PAR:NOS_S
           GG:PAR_NR=PAR:U_NR
           PAR_NR=PAR:U_NR
           IF PAR:NOKL_DC_TIPS='2' !Nenorâdît apmaksas termiòu
              NOKL_DC=0
           ELSIF PAR:NOKL_DC
              IF PAR:NOKL_DC_TIPS='1' !Bankas dienas
                 SESV#=0
                 LOOP I#=GG:DATUMS TO GG:DATUMS+PAR:NOKL_DC
                    IF I#%7=0 OR I#%7=6
                       SESV#+=1
                    .
                 .
                 NOKL_DC=PAR:NOKL_DC+SESV#
              ELSE 
                 NOKL_DC=PAR:NOKL_DC
              .
           ELSE
              NOKL_DC=SYS:NOKL_DC
           .
           ?ButtonApmLidz{PROP:TEXT}='+'&nokl_dc
           DO BRW2::InitializeBrowse
           DO BRW2::RefreshPage
           DISPLAY
        .
        DISPLAY(?GG:NOKA)
        DISPLAY(?GG:PAR_NR)
        SELECT(?TekstuPlans)
        
      END
    OF ?ggkparchange
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        forcedparchange=1
        DO BRW2::InitializeBrowse
        DO BRW2::RefreshPage
        forcedparchange=0
      END
    OF ?TekstuPlans
      CASE EVENT()
      OF EVENT:Accepted
        IF GG:SATURS
           TEK_INI=INIGEN(GG:SATURS,10,1)
        .
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseTEK_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
           IF GLOBALRESPONSE=REQUESTCOMPLETED
              IF GETKON_K(TEK:BKK_1,0,5) AND ~(KON:VAL='Ls' OR KON:VAL='LVL') THEN VAL_NOS=KON:VAL.
              IF GETKON_K(TEK:BKK_2,0,5) AND ~(KON:VAL='Ls' OR KON:VAL='LVL') THEN VAL_NOS=KON:VAL.
              IF GETKON_K(TEK:BKK_3,0,5) AND ~(KON:VAL='Ls' OR KON:VAL='LVL') THEN VAL_NOS=KON:VAL.
              IF GETKON_K(TEK:BKK_4,0,5) AND ~(KON:VAL='Ls' OR KON:VAL='LVL') THEN VAL_NOS=KON:VAL.
              IF GETKON_K(TEK:BKK_5,0,5) AND ~(KON:VAL='Ls' OR KON:VAL='LVL') THEN VAL_NOS=KON:VAL.
              IF GETKON_K(TEK:BKK_6,0,5) AND ~(KON:VAL='Ls' OR KON:VAL='LVL') THEN VAL_NOS=KON:VAL.
              PERFORMTEK_K
              TEK_INI=TEK:INI
        !      GG:ATT_DOK=TEK:ATT_DOK    ?
              IF YEAR(DB_B_DAT)>2009
                 IF INRANGE(GG:ATT_DOK,1,6)
                    NR#=GG:ATT_DOK
                 ELSIF GG:ATT_DOK='X'
                    NR#=7
                 ELSE
                    NR#=0
                 .
              ELSE
                 IF GG:ATT_DOK='0'
                    NR#=GG:ATT_DOK+10
                 ELSE
                    NR#=GG:ATT_DOK
                 .
              .
              GET(LIST:ATT_DOK,NR#+1) !STRINGU NEÒEM
           .
           DO BRW2::InitializeBrowse
           DO BRW2::RefreshPage
           IF RECORDS(Queue:Browse:2) AND LOCALREQUEST=1
              DISABLE(?CANCEL)
           ELSE
              ENABLE(?CANCEL)
           .
        !   SELECT(?GG:SATURS,LEN(CLIP(GG:SATURS)),LEN(CLIP(GG:SATURS)))
           SELECT(?GG:SATURS)
        !   PRESSKEY(RIGHTKEY) !ÐITAIS NOKAUJ KURSORU.....
        
        !   ?Change:3{PROP:DEFAULT}=''  KÂDS ÐITO PRASÎJA,BET CITI BIJA PRET
        !   ?OK{PROP:DEFAULT}=1
           DISPLAY
      END
    OF ?UzbRekASSAKO
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         SUMMA=0
         SAV_DATUMS=0
         IF GG:U_NR=1  !SALDO Saspiest 231.. 1 partnerim
           GLOBALREQUEST=SELECTRECORD
           BROWSEPAR_K
           IF GLOBALRESPONSE=REQUESTCOMPLETED
              CLEAR(GGK:RECORD)
              GGK:U_NR=1
              GGK:BKK='23100'
              SET(GGK:NR_KEY,GGK:NR_KEY)
              LOOP
                 NEXT(GGK)
                 IF ERROR() OR ~(GGK:U_NR=1) THEN BREAK.
                 IF GGK:BKK='23100' AND GGK:PAR_NR=PAR:U_NR
                    IF GGK:D_K='D'
                       SUMMA+=GGK:SUMMA
                    ELSE
                       SUMMA-=GGK:SUMMA
                    .
                    SAV_DATUMS=GGK:DATUMS
                    GGK:SUMMA=0
        !            PUT(GGK)
                    DELETE(GGK)
                 .
              .
              CLEAR(GGK:RECORD)
              GGK:U_NR=1
              GGK:DATUMS=GG:DATUMS
              GGK:PAR_NR=PAR:U_NR
              GGK:REFERENCE='SALDO'
              GGK:BKK='23100'
              IF SUMMA>0
                 GGK:D_K='D'
              ELSE
                 GGK:D_K='K'
              .
              GGK:SUMMA=SUMMA
              GGK:SUMMAV=SUMMA
              GGK:VAL=GG:VAL
              ADD(GGK)
              DO BRW2::InitializeBrowse
              DO BRW2::RefreshPage
           .
         ELSE
           OPCIJA='1112'
        !          1234
           IZZFILTGMC
           IF GLOBALRESPONSE=REQUESTCOMPLETED
        !     MEN_NR-VIRTUÂLAIS MÇNESIS 1-19
              MEN_NR=MONTH(S_DAT)
              KOR#=0
              IF PAR:L_CDATUMS > S_DAT
        !         PAR_L_SUMMA1=DEFORMAT(GETPAR_LIGUMI(PAR:U_NR,1,0,4),@N_7.2)    !MEKLÇJAM IEPRIEKÐÇJO
                 PAR_L_SUMMA1=GETPAR_LIGUMI(PAR:U_NR,1,0,4)    !MEKLÇJAM IEPRIEKÐÇJO
        !         STOP(PAR_L_SUMMA1)
                 LOOP MN# = MEN_NR TO MEN_NR+(MENESU_SKAITS-1)
                    KOR#+=1
                    IF PAR:L_CDATUMS <= DATE(MN#+1,1,YEAR(S_DAT))
                       IF ~PAR_L_SUMMA1
                          MENESU_SKAITS-=KOR#
                          KLUDA(0,MENESU_SKAITS&' mçneði',,1)
                          MEN_NR+=KOR#
                          SUMMA=PAR:L_SUMMA1*MENESU_SKAITS
                       ELSE
                          SUMMA=PAR_L_SUMMA1*KOR# + PAR:L_SUMMA1*(MENESU_SKAITS-KOR#)
                       .
                       BREAK
                    .
                 .
                 IF ~SUMMA
                    IF PAR_L_SUMMA1 ! SPÇKÂ TIKAI IEPRIEKÐÇJAIS LÎGUMS
                       SUMMA=PAR_L_SUMMA1*MENESU_SKAITS
                       SAV_DATUMS=GETPAR_LIGUMI(PAR:U_NR,1,0,5)      !IEPRIEKÐÇJÂ DATUMS
                    ELSE
                       KLUDA(0,'Jâmaksâ tikai no '&FORMAT(PAR:L_CDATUMS,@D06.))
                       CYCLE
                    .
                 .
              ELSE
                 SUMMA=PAR:L_SUMMA1*MENESU_SKAITS
              .
              val_nos = val_uzsk !11/02/2014
              PerformASSAKO1
              DO BRW2::InitializeBrowse
              DO BRW2::RefreshPage
              IF RECORDS(Queue:Browse:2) AND LOCALREQUEST=1
                 DISABLE(?CANCEL)
              ELSE
                 ENABLE(?CANCEL)
              .
              SELECT(?GG:SATURS)
              DISPLAY
           .
         .
      END
    OF ?Apmaksano231
      CASE EVENT()
      OF EVENT:Accepted
          KKK='231'
          D_K='K'    !mums maksâjuði
          KKK1=''    !jânotîra dçï ieskaita
          D_K1=''
        DO SyncWindow
        GlobalRequest = SelectRecord
        PerformShortcut 
        LocalRequest = OriginalRequest
        DO RefreshWindow
              DO BRW2::InitializeBrowse
              DO BRW2::RefreshPage
              IF RECORDS(Queue:Browse:2) AND LOCALREQUEST=1
                 DISABLE(?CANCEL)
              ELSE
                 ENABLE(?CANCEL)
              .
              GG:ATT_DOK='3'
              GET(LIST:ATT_DOK,3+1)
              SELECT(?GG:SATURS)
        !      PRESSKEY(ENDKEY)
        !      PRESSKEY(RIGHTKEY)
              DISPLAY
      END
    OF ?Apmaksauz531
      CASE EVENT()
      OF EVENT:Accepted
          KKK='531'
          D_K='D'    !mçs maksâjâm
          KKK1=''    !jânotîra dçï ieskaita
          D_K1=''
        DO SyncWindow
        PerformShortcut 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        !  IF GLOBALRESPONSE=REQUESTACCEPTED
              DO BRW2::InitializeBrowse
              DO BRW2::RefreshPage
              IF RECORDS(Queue:Browse:2) AND LOCALREQUEST=1
                 DISABLE(?CANCEL)
              ELSE
                 ENABLE(?CANCEL)
              .
              GG:ATT_DOK='3'
              GET(LIST:ATT_DOK,3+1)
              SELECT(?GG:SATURS)
        !      PRESSKEY(ENDKEY)
        !      PRESSKEY(RIGHTKEY)
              DISPLAY
        !  END
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
    OF ?PVN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           IF ~(GGK:PVN_PROC=18 OR GGK:PVN_PROC=5 OR GGK:PVN_PROC=21 OR GGK:PVN_PROC=10 OR GGK:PVN_PROC=22 OR GGK:PVN_PROC=12)
              KLUDA(0,'Nepareizi vai nav norâdîts PVN % '&GGK:BKK&' kontam')
           .
           IF GGK:PVN_PROC=18 OR GGK:PVN_PROC=21 OR GGK:PVN_PROC=22
              Calc_PVNSUMMA18=ROUND(GGK:SUMMA*(1-1/(1+GGK:PVN_PROC/100)),.01)
              PVN18=GGK:PVN_PROC
              FORCEDPVNCHANGE18=TRUE
           ELSIF GGK:PVN_PROC=5 OR GGK:PVN_PROC=10 OR GGK:PVN_PROC=12
              Calc_PVNSUMMA5 =ROUND(GGK:SUMMA*(1-1/(1+GGK:PVN_PROC/100)),.01)
              PVN5=GGK:PVN_PROC
              FORCEDPVNCHANGE5=TRUE
           .
        
           DO BRW2::InitializeBrowse    !RÇÍINA PÇC Calc_PVNSUMMAXX
           DO BRW2::RefreshPage
        
           IF forcedPVNchange18         !18/21/22% PVN KONTS NAV ATRASTS
              GGK:U_NR=GG:U_NR
              GGK:DATUMS=GG:DATUMS
              GGK:PAR_NR=GG:PAR_NR
              GGK:BKK=SYS:K_PVN
              GGK:D_K=INVDK(GGK:D_K)
              GGK:VAL=VAL_NOS
              !11/03/2014 IF ~GGK:VAL THEN GGK:VAL=VAL_LV.
              IF ~GGK:VAL THEN GGK:VAL=val_uzsk.   !11/03/2014 
              GGK:PVN_PROC=PVN18
              GGK:PVN_TIPS='0'
              GGK:SUMMAV=CALC_PVNSUMMA18/BANKURS(GGK:VAL,GGK:DATUMS)
              GGK:SUMMA =CALC_PVNSUMMA18
              ADD(GGK)
              IF ERROR()
                 KLUDA(24,'GGK')
              .
              forcedPVNchange18=FALSE
              Calc_PVNSUMMA18=0
           .
           IF forcedPVNchange5         !5/10/12% PVN KONTS NAV ATRASTS
              GGK:U_NR=GG:U_NR
              GGK:DATUMS=GG:DATUMS
              GGK:PAR_NR=GG:PAR_NR
              GGK:BKK=SYS:K_PVN
              GGK:D_K=INVDK(GGK:D_K)
              GGK:VAL=VAL_NOS
              !11/03/2014 IF ~GGK:VAL THEN GGK:VAL=VAL_LV.
              IF ~GGK:VAL THEN GGK:VAL=val_uzsk.   !11/03/2014 
              GGK:PVN_PROC=PVN5
              GGK:PVN_TIPS='0'
              GGK:SUMMAV=CALC_PVNSUMMA5/BANKURS(GGK:VAL,GGK:DATUMS)
              GGK:SUMMA =CALC_PVNSUMMA5
              ADD(GGK)
              IF ERROR()
                 KLUDA(24,'GGK')
              .
              forcedPVNchange5=FALSE
              Calc_PVNSUMMA5=0
           .
           DO BRW2::InitializeBrowse
           DO BRW2::RefreshPage
           SELECT(?Browse:2)
           DISABLE(?CANCEL)
           DISPLAY
      END
    OF ?PVN:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           D_K='K'                                   ! Taisam no kredîtu summas kredîtu
           Calc_PVNSUMMA18=ROUND(K_SUMMA18*PVN18/100,.01) !PVN-s no 18/21/22% Kredîtu ~5721 summas bez PVN
           Calc_PVNSUMMA5 =ROUND(K_SUMMA5*PVN5/100,.01)  !PVN-s no  5/10/12% Kredîtu ~5721 summas bez PVN
           IF Calc_PVNSUMMA18 THEN FORCEDPVNCHANGE18=TRUE.
           IF Calc_PVNSUMMA5  THEN FORCEDPVNCHANGE5 =TRUE.
        
           DO BRW2::InitializeBrowse    !RÇÍINA PÇC CALC_PVNSUMMAXX
           DO BRW2::RefreshPage
        
           IF forcedPVNchange18         !18/21/22% PVN KONTS NAV ATRASTS
              GGK:U_NR=GG:U_NR
              GGK:DATUMS=GG:DATUMS
              GGK:PAR_NR=GG:PAR_NR
              GGK:BKK=SYS:K_PVN
              GGK:D_K=D_K
              GGK:VAL=VAL_NOS
              !11/03/2014 IF ~GGK:VAL THEN GGK:VAL=VAL_LV.
              IF ~GGK:VAL THEN GGK:VAL=val_uzsk.   !11/03/2014 
              GGK:PVN_PROC=PVN18
              GGK:PVN_TIPS='0'
              GGK:SUMMAV=Calc_PVNSUMMA18/BANKURS(GGK:VAL,GGK:DATUMS)
              GGK:SUMMA =Calc_PVNSUMMA18
              ADD(GGK)
              IF ERROR()
                 KLUDA(24,'GGK')
              ELSE
                 DISABLE(?CANCEL)
              .
              forcedPVNchange18=FALSE
              Calc_PVNSUMMA18=0
              DO BRW2::InitializeBrowse
              DO BRW2::RefreshPage
           .
           IF forcedPVNchange5         !5/10/12% PVN KONTS NAV ATRASTS
              GGK:U_NR=GG:U_NR
              GGK:DATUMS=GG:DATUMS
              GGK:PAR_NR=GG:PAR_NR
              GGK:BKK=SYS:K_PVN
              GGK:D_K=D_K
              GGK:VAL=VAL_NOS
              !11/03/2014 IF ~GGK:VAL THEN GGK:VAL=VAL_LV.
              IF ~GGK:VAL THEN GGK:VAL=val_uzsk.   !11/03/2014 
              GGK:PVN_PROC=PVN5
              GGK:PVN_TIPS='0'
              GGK:SUMMAV=Calc_PVNSUMMA5/BANKURS(GGK:VAL,GGK:DATUMS)
              GGK:SUMMA =Calc_PVNSUMMA5
              ADD(GGK)
              IF ERROR()
                 KLUDA(24,'GGK')
              ELSE
                 DISABLE(?CANCEL)
              .
              forcedPVNchange5=FALSE
              Calc_PVNSUMMA5=0
              DO BRW2::InitializeBrowse
              DO BRW2::RefreshPage
           .
           SELECT(?Browse:2)
           DISPLAY(?bilance)
           DISPLAY(?gg:summa)
      END
    OF ?MU
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPCIJA='0'
        IZZFILTF
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           DO CHECKBANKA
           IF FOUND_BANKA=TRUE
              B_MAKRIK
           ELSE
              KLUDA(104,' K262.. Kontam')
           .
           LocalResponse=RequestCompleted
           SELECT(?Browse:2)
        .
      END
    OF ?ko
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPCIJA='0'
        IZZFILTF
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           GETMYBANK(ggk:bkk)              ! MANA BANKA
           FOUND_KASE=FALSE
           CHECKOPEN(INIFILE,1)
           SET(INIFILE)
           LOOP
              NEXT(INIFILE)
              IF ERROR() THEN BREAK.
              IF INI:LINE[1:5]='KASE='
                 IF INI:LINE[6:10]=GGK:BKK
                    FOUND_KASE=TRUE
                 .
              .
           .
           CLOSE(INIFILE)
           IF GGK:D_K='D' AND (SUB(GGK:BKK,1,3)='261' OR FOUND_KASE=TRUE)
              IF ~GG:DOK_SENR
                 GG:DOK_SENR=PERFORMGL(2)   !PIEÐÍIRAM IEN ORD NR
                 IF K_SUMMA18 AND K_SUMMA5
                    IF GGK:PVN_PROC=22 THEN GG:DOK_SENR=CLIP(GG:DOK_SENR)&'-22'.
                    IF GGK:PVN_PROC=21 THEN GG:DOK_SENR=CLIP(GG:DOK_SENR)&'-21'.
                    IF GGK:PVN_PROC=12  THEN GG:DOK_SENR=CLIP(GG:DOK_SENR)&'-12'.
                    IF GGK:PVN_PROC=10  THEN GG:DOK_SENR=CLIP(GG:DOK_SENR)&'-10'.
                    IF GGK:PVN_PROC=18 THEN GG:DOK_SENR=CLIP(GG:DOK_SENR)&'-18'.
                    IF GGK:PVN_PROC=5  THEN GG:DOK_SENR=CLIP(GG:DOK_SENR)&'-5'.
                 .
              .
              PUT(GG)
              F:DTK='1'
              B_IENORD(0)
              LocalResponse=RequestCompleted
           ELSIF GGK:D_K='K' AND (SUB(GGK:BKK,1,3)='261' OR FOUND_KASE=TRUE)
              IF ~GG:DOK_SENR
                 GG:DOK_SENR=PERFORMGL(3)   !PIEÐÍIRAM IZD ORD NR
              .
              PUT(GG)
              B_IZDORD(0) !STARTU AR PARAMETRIEM NEVAR LAIST
              LocalResponse=RequestCompleted
           ELSE
              KLUDA(104,' 261.. Kontam')
           .
           DISPLAY
           SELECT(?Browse:2)
        .
      END
    OF ?ko:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPCIJA='0'
        IZZFILTF
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           GETMYBANK(ggk:bkk)              ! MANA BANKA
           FOUND_KASE=FALSE
           CHECKOPEN(INIFILE,1)
           SET(INIFILE)
           LOOP
              NEXT(INIFILE)
              IF ERROR() THEN BREAK.
              IF INI:LINE[1:5]='KASE='
                 IF INI:LINE[6:10]=GGK:BKK
                    FOUND_KASE=TRUE
                 .
              .
           .
           CLOSE(INIFILE)
           IF GGK:D_K='D' AND (SUB(GGK:BKK,1,3)='261' OR FOUND_KASE=TRUE)
              IF ~GG:DOK_SENR
                 GG:DOK_SENR=PERFORMGL(2)   !PIEÐÍIRAM IEN ORD NR
              .
              PUT(GG)
              F:DTK=''
              B_IENORD(0) !STARTU AR PARAMETRIEM NEVAR LAIST
              LocalResponse=RequestCompleted
           ELSIF GGK:D_K='K' AND (SUB(GGK:BKK,1,3)='261' OR FOUND_KASE=TRUE)
              IF ~GG:DOK_SENR
                 GG:DOK_SENR=PERFORMGL(3)   !PIEÐÍIRAM IZD ORD NR
              .
              PUT(GG)
              B_IZDORD(0) !STARTU AR PARAMETRIEM NEVAR LAIST
              LocalResponse=RequestCompleted
           ELSE
              KLUDA(104,' 261.. Kontam')
           .
           DISPLAY
           SELECT(?Browse:2)
        .
      END
    OF ?Izlidzinat
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF bilance                     ! D vai K PÂRPALIKUMS Ls,vienalga
           IF GGK:D_K='D'
              BILANCE=-BILANCE
           .
           !IF BILANCE_VAL
              GGK:SUMMAV+=bilance/BANKURS(GGK:VAL,GGK:DATUMS)
           !.
           GGK:SUMMA+=bilance
           IF GGK:SUMMA < 0
              GGK:SUMMA =ABS(GGK:SUMMA)
              GGK:SUMMAV=ABS(GGK:SUMMAV)
              GGK:D_K   =INVDK(GGK:BKK)
           .
           PUT(GGK)
           BILANCE=0
           BILANCE_VAL=0
           DO BRW2::InitializeBrowse
           DO BRW2::RefreshPage
           SELECT(?Browse:2)
           DISPLAY(?bilance)
!           DISPLAY(?bilance_VAL)
           DISPLAY(?gg:summa)
        .
      END
    OF ?elmaks
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO CHECKBANKA
        IF FOUND_BANKA=TRUE
           IF TODAY()-GG:DATUMS>10
              KLUDA(0,'Maksâjuma datums vecâks par 10 dienâm')
           ELSE
              ELMAKS
           .
        ELSE
           KLUDA(104,' K262.. Kontam')
        .
        SELECT(?Browse:2)
      END
    OF ?Kopet
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         COPYREQUEST=1
         DO BRW2::ButtonInsert
        
      END
    OF ?Insert:3
      CASE EVENT()
      OF EVENT:Accepted
        COPYREQUEST=0 !18/11/2015
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
    OF ?BUTTON:Nodala
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          NODALA=''
          open(NodWindow)
          ACCEPT
            CASE FIELD()
            OF ?BUTTONNODALA
              CASE EVENT()
              OF EVENT:Accepted
                 GLOBALREQUEST=SELECTRECORD
                 BROWSENODALAS
                 IF GLOBALRESPONSE=REQUESTCOMPLETED
                    NODALA=NOD:U_NR
                    NODTEXT=NOD:NOS_P
                 .
                 DISPLAY
                 SELECT(?OkButtonN)
             .
            OF ?NODALA
              CASE EVENT()
              OF EVENT:Accepted
                 NODTEXT=GETNODALAS(NODALA,1)
                 DISPLAY
              .
            OF ?OkButtonN
              CASE EVENT()
              OF EVENT:Accepted
                forcedNODALAchange=TRUE
                 BREAK
              END
            OF ?CancelButtonN
              CASE EVENT()
              OF EVENT:Accepted
                 BREAK
              END
            END
          END
          CLOSE(NodWindow)
          IF forcedNODALAchange=TRUE
            DO BRW2::InitializeBrowse
            DO BRW2::RefreshPage
            forcedNODALAChange=FALSE
            disable(?cancel)
          .
      END
    OF ?BUTTON:Projekts
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          PROJEKTS=0
          open(ProWindow)
          IF BAND(REG_BASE_ACC,00000010b) ! Budþets
             ?StringMainitProjektu{PROP:TEXT}='Mainît Klasifikâcijas kodu visam kontçjumam uz'
             ?BUTTONProjektS{PROP:TEXT}='Klasifikâcijas kodi'
          .
          DISPLAY
          ACCEPT
            CASE FIELD()
            OF ?BUTTONPROJEKTS
              CASE EVENT()
              OF EVENT:Accepted
                 GLOBALREQUEST=SELECTRECORD
                 BROWSEPROJEKTI
                 IF GLOBALRESPONSE=REQUESTCOMPLETED
                    PROJEKTS=PRO:U_NR
                    PROTEXT=PRO:NOS_P
                 .
                 DISPLAY
                 SELECT(?OkButtonP)
              .
            OF ?PROJEKTS
              CASE EVENT()
              OF EVENT:Accepted
                 PROTEXT=GETPROJEKTI(PROJEKTS,1)
                 DISPLAY
              .
            OF ?OkButtonP
              CASE EVENT()
              OF EVENT:Accepted
                forcedPROJEKTSchange=TRUE
                 BREAK
              END
            OF ?CancelButtonN
              CASE EVENT()
              OF EVENT:Accepted
                 BREAK
              END
            END
          END
          CLOSE(PROWindow)
          IF forcedPROJEKTSchange=TRUE
            DO BRW2::InitializeBrowse
            DO BRW2::RefreshPage
            forcedPROJEKTSChange=FALSE
            disable(?cancel)
          .
      END
    OF ?OK
       if bilance
!          kluda(28,gg:val&' '&bilance)
          kluda(28,'Ls '&bilance)
          SELECT(?CURRENTTAB)
          CYCLE
       .
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
        ! IF CHECKES AND ~(CHECKES='111')   KAD BÛS ÎSTI SKAIDRS, KÂ JÂKONTÇ, TAD LIKSIM
        !    KLUDA(0,'Aizdomîgs kontçjums ar ES partneri....')
        ! .
         IF LOCALREQUEST=3
           IF SYS:PZ_NR=GETDOK_SENR(2,GG:DOK_SENR,,GG:ATT_DOK)
              SYS:PZ_NR-=1
              PUT(SYSTEM)
           .
         ELSE
           gg:acc_kods=acc_kods
           gg:acc_datums=today()
           IF ~GG:SECIBA
              gg:seciba=clock()
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
    OF ?PierPVN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
     DO SyncWindow
     IF ~(GGK:D_K='K' AND GGK:BKK[1:2]='26')
        KLUDA(104,' 26.. Kredîtam')
        SELECT(?Browse:2)
     ELSE
        IF ~(COUNT_PVNSUMMA18+COUNT_PVNSUMMA5) !5721. KONTU NEMAZ NAV
            IF ~(GGK:PVN_PROC=18 OR GGK:PVN_PROC=5 OR GGK:PVN_PROC=21 OR GGK:PVN_PROC=10 OR GGK:PVN_PROC=22 OR GGK:PVN_PROC=12)
               KLUDA(0,'Nepareizi vai nav norâdîts PVN % '&GGK:BKK&' kontam')
            ELSE
               IF GGK:PVN_PROC=18 OR GGK:PVN_PROC=21 OR GGK:PVN_PROC=22
                  COUNT_PVNSUMMA18=GGK:SUMMA-ROUND(GGK:SUMMA/(1+GGK:PVN_PROC/100),.01)
               ELSIF GGK:PVN_PROC=5 OR GGK:PVN_PROC=10 OR GGK:PVN_PROC=12
                  COUNT_PVNSUMMA5=GGK:SUMMA-ROUND(GGK:SUMMA/(1+GGK:PVN_PROC/100),.01)
               .
            .
        .
        TEKSTS=CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
        IF COUNT_PVNSUMMA18
           TEKSTS=CLIP(TEKSTS)&' Summa='&clip(ggK:summa-COUNT_pvnsumma18)&' PVN '&GGK:PVN_PROC&'%='&clip(COUNT_pvnsumma18)
        .
        IF COUNT_PVNSUMMA5
           TEKSTS=CLIP(TEKSTS)&' Summa='&clip(ggK:summa-COUNT_pvnsumma5)&' PVN '&GGK:PVN_PROC&'%='&clip(COUNT_pvnsumma5)
        .
        FORMAT_TEKSTS(45,'WINDOW',0,'')
        GG:SATURS2=F_TEKSTS[1]
        GG:SATURS3=F_TEKSTS[2]
        DISPLAY
     .
      END
    OF ?TiesaisImportsNoNoliktavas
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           PAR_NR=GG:PAR_NR
           BrowsePavadApv(2)
           IF GLOBALRESPONSE=REQUESTCOMPLETED
              GG:ATT_DOK='2'
              DO BRW2::InitializeBrowse
              DO BRW2::RefreshPage
              IF RECORDS(Queue:Browse:2) AND LOCALREQUEST=1
                 DISABLE(?CANCEL)
              ELSE
                 ENABLE(?CANCEL)
              .
              SELECT(?GG:SATURS,LEN(CLIP(GG:SATURS)))
              DISPLAY
           END
      END
    OF ?IESKAITS
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
              KKK='231'
              D_K='K'  !MUMS MAKSÂJA
              KKK1='531'
              D_K1='D' !MÇS MAKSÂJÂM
              PerformShortcutIesk
              DO BRW2::InitializeBrowse
              DO BRW2::RefreshPage
              IF RECORDS(Queue:Browse:2) AND LOCALREQUEST=1
                 DISABLE(?CANCEL)
              ELSE
                 ENABLE(?CANCEL)
              .
              GG:ATT_DOK='8'
              GET(LIST:ATT_DOK,3+1)
              SELECT(?GG:SATURS)
        !      PRESSKEY(ENDKEY)
        !      PRESSKEY(RIGHTKEY)
              DISPLAY
      END
    OF ?clock
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        gg:seciba=clock()
        display(?gg:seciba)
      END
    OF ?Atlaide
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          gg_atlaide=gg:atlaide
          ATLAIDE#=0
          open(AtlWindow)
          ACCEPT
            CASE FIELD()
            OF ?OkButtonA
              CASE EVENT()
              OF EVENT:Accepted
                 ATLAIDE#=1
                 BREAK
              END
            OF ?CancelButtonA
              CASE EVENT()
              OF EVENT:Accepted
                 BREAK
              END
            END
          END
          CLOSE(AtlWindow)
          IF ATLAIDE#
            forcedatlaidechange=1
            DO BRW2::InitializeBrowse
            DO BRW2::RefreshPage
            forcedAtlaideChange=0
            display(?gg:atlaide)
            disable(?cancel)
          .
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF GG::Used = 0
    CheckOpen(GG,1)
  END
  GG::Used += 1
  BIND(GG:RECORD)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  IF TEK_K::Used = 0
    CheckOpen(TEK_K,1)
  END
  TEK_K::Used += 1
  BIND(TEK:RECORD)
  IF VAL_K::Used = 0
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  BIND(VAL:RECORD)
  FilesOpened = True
  IF LOCALREQUEST=DELETERECORD
     CLEAR(GGK:RECORD)
     GGK:U_NR=GG:U_NR
     SET(GGK:NR_KEY,GGK:NR_KEY)
     LOOP
        NEXT(GGK)
        IF ERROR() OR ~(GGK:U_NR=GG:U_NR) THEN BREAK.
        IF GGK:D_K='D'                     !APGRIEÞAM OTRÂDI DÇÏ ATLIKUMIB()
          B:K_D='K'
        ELSE
          B:K_D='D'
        .
        B:BKK=GGK:BKK
        B:SUMMA=GGK:SUMMA
        ADD(B_TABLE)
        IF ERROR() THEN STOP('RAKSTOT B_TABLE:'&ERROR()).
     .
  .
  RISnap:GG
  SAV::GG:Record = GG:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
      gg:acc_kods=acc_kods
      gg:acc_datums=today()
      gg:seciba=clock()
      GG:DATUMS=GETFING(3,GG:DATUMS) !3-AR FING KONTROLI
!      IF ~(YEAR(gg:DATUMS)=DB_GADS)
!         KLUDA(23,DB_GADS&'. gadu')
!      .
      IF COPYREQUEST=1
         CLEAR(GGK:RECORD)
         GGK:U_NR=GG::U_NR
         SET(GGK:NR_KEY,GGK:NR_KEY)
         LOOP
            NEXT(GGK)
            IF ERROR() OR ~(GGK:U_NR=GG::U_NR) THEN BREAK.
            G:U_NR=GG:U_NR !
            G:RS=GGK:RS
            G:DATUMS=GG:DATUMS !
            G:PAR_NR=GGK:PAR_NR
            G:D_K=GGK:D_K
            G:BKK=GGK:BKK
            G:SUMMA=GGK:SUMMA
            G:SUMMAV=GGK:SUMMAV
            G:VAL=GGK:VAL
            G:PVN_TIPS=GGK:PVN_TIPS
            G:PVN_PROC=GGK:PVN_PROC
            G:BAITS=GGK:BAITS
            G:KK=GGK:KK
            G:NODALA=GGK:NODALA
            G:OBJ_NR=GGK:OBJ_NR
            ADD(G_TABLE)
         .
         LOOP I#=1 TO RECORDS(G_TABLE)
            GET(G_TABLE,I#)
            CLEAR(GGK:RECORD)
            GGK:U_NR    =G:U_NR
            GGK:RS      =G:RS
            GGK:DATUMS  =G:DATUMS
            GGK:PAR_NR  =G:PAR_NR
            GGK:D_K     =G:D_K
            GGK:BKK     =G:BKK
            GGK:SUMMA   =G:SUMMA
            GGK:SUMMAV  =G:SUMMAV
            GGK:VAL     =G:VAL
            GGK:PVN_TIPS=G:PVN_TIPS
            GGK:PVN_PROC=G:PVN_PROC
            GGK:BAITS   =G:BAITS
            GGK:KK      =G:KK
            GGK:NODALA  =G:NODALA
            GGK:OBJ_NR  =G:OBJ_NR
            ADD(GGK)
         .
         FREE(G_TABLE)
      .
  END
  OPEN(QuickWindow)
  WindowOpened=True
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('UpdateGG','winlats.INI')
  WinResize.Resize
  BRW2::AddQueue = True
  BRW2::RecordCount = 0
  BIND('ATLAUTS',ATLAUTS)
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?Browse:2{Prop:Alrt,255} = InsertKey
  ?Browse:2{Prop:Alrt,254} = DeleteKey
  ?Browse:2{Prop:Alrt,253} = CtrlEnter
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?GG:U_NR{PROP:Alrt,255} = 734
  ?GG:ES{PROP:Alrt,255} = 734
  ?GG:IMP_NR{PROP:Alrt,255} = 734
  ?GG:APMDAT{PROP:Alrt,255} = 734
  ?GG:DATUMS{PROP:Alrt,255} = 734
  ?GG:DOK_SENR{PROP:Alrt,255} = 734
  ?GG:DOKDAT{PROP:Alrt,255} = 734
  ?GG:NOKA{PROP:Alrt,255} = 734
  ?GG:PAR_NR{PROP:Alrt,255} = 734
  ?GG:SATURS{PROP:Alrt,255} = 734
  ?GG:SATURS2{PROP:Alrt,255} = 734
  ?GG:SATURS3{PROP:Alrt,255} = 734
  ?GG:SUMMA{PROP:Alrt,255} = 734
  ?GG:VAL{PROP:Alrt,255} = 734
  ?GG:ACC_KODS{PROP:Alrt,255} = 734
  ?GG:ACC_DATUMS{PROP:Alrt,255} = 734
  ?GG:SECIBA{PROP:Alrt,255} = 734
  GG:ATLAIDE:2{PROP:Alrt,255} = 734
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
    IF LOCALREQUEST=DELETERECORD AND LOCALRESPONSE=REQUESTCOMPLETED
       LOOP I#= 1 TO RECORDS(B_TABLE)
          GET(B_TABLE,I#)
          ATLIKUMIB(B:K_D,B:BKK,B:SUMMA,'','',0)
       .
    .
    FREE(B_TABLE)
    ALIAS
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    TEK_K::Used -= 1
    IF TEK_K::Used = 0 THEN CLOSE(TEK_K).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
  END
  IF WindowOpened
    INISaveWindow('UpdateGG','winlats.INI')
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
CHECKBANKA  ROUTINE
   FOUND_BANKA=FALSE
   IF GGK:D_K='K' AND SUB(GGK:BKK,1,3)='262'
      FOUND_BANKA=TRUE
   ELSE
      CHECKOPEN(INIFILE,1)
      SET(INIFILE)
      LOOP
         NEXT(INIFILE)
         IF ERROR() THEN BREAK.
         IF INI:LINE[1:6]='BANKA=' AND INI:LINE[7:11]=GGK:BKK
            FOUND_BANKA=TRUE
            BREAK
         .
      .
      CLOSE(INIFILE)
   .
   IF FOUND_BANKA=TRUE AND ~GG:DOK_SENR
      GG:DOK_SENR=PERFORMGL(1)   !PIEÐÍIRAM MU NR
      DISPLAY
   .
   PUT(GG)  !VAJAG !!!

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
      IF BRW2::Sort1:Reset:GG:U_NR <> GG:U_NR
        BRW2::Changed = True
      END
    END
  ELSE
  END
  IF BRW2::SortOrder <> BRW2::LastSortOrder OR BRW2::Changed OR ForceRefresh
    CASE BRW2::SortOrder
    OF 1
      BRW2::Sort1:Reset:GG:U_NR = GG:U_NR
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
  GG_SUMMAV       =0
  GG_SUMMA        =0
  BILANCE         =0
  BILANCE_VAL     =0
  COUNT_PVNSUMMA18=0    !PVN KONTU SUMMA,KUR PVN=18 vai 5
  COUNT_PVNSUMMA5 =0    !
  K_SUMMA18       =0    !KREDÎTA KONTU SUMMA ,~5721
  K_SUMMA5        =0    !KREDÎTA KONTU SUMMA ,~5721
  MULTIVAL        =0
  FIRSTVAL        =''
  STRINGBYTE      =''
  CHECK_ES        =''   !PÂRBAUDAM KONTÇJUMUS UZ ES
  GG:TIPS         =0    !K/B/A..
  KK_SUMMA        =0
  CLEAR(KKS)
  CHECK_PAR_NR    =''   !DAÞÂDI PARTNERI GG/GGK UN ~DAÞÂDI GGK
  LOOP
    NEXT(BRW2::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW2::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'GGK')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW2::FillQueue
    IF GG:U_NR=GGK:U_NR !TOTÂLÂ KONTROLE SPECGADÎJUMÂ, JA NOBRUCIS BROWSIS
       !************fixçjam multivalûtas*************
       IF ~FIRSTVAL
          FIRSTVAL=GGK:VAL
          val_nos=ggk:val
       .
       IF ~(FIRSTVAL=GGK:VAL)
          MULTIVAL=TRUE
          !11/03/2014 val_nos=VAL_LV
          val_nos=val_uzsk  !11/03/2014 
       .
       !***********fixçjam kasi/banku/AV/231/531*******
       IF GGK:BKK[1:3]='261'     ! KASE
          STRINGBYTE[8]='1'
       ELSIF GGK:BKK[1:3]='262'  ! BANKA
          STRINGBYTE[7]='1'
       ELSIF GGK:BKK[1:3]='238'  ! AVANSIERI
          STRINGBYTE[6]='1'
       ELSIF GGK:BKK[1:3]='231'  ! 231..
          STRINGBYTE[5]='1'
          IF ~GG:APMDAT AND NOKL_DC THEN GG:APMDAT=GG:DOKDAT+NOKL_DC.
       ELSIF GGK:BKK[1:3]='531'  ! 531..
          STRINGBYTE[4]='1'
          IF ~GG:APMDAT AND NOKL_DC THEN GG:APMDAT=GG:DOKDAT+NOKL_DC.
          IF GETPAR_K(GG:PAR_NR,0,20)='C' THEN CHECK_ES[1]='1'.
       ELSIF GGK:BKK[1:3]='219'  ! 219..
          IF GETPAR_K(GG:PAR_NR,0,20)='C' THEN CHECK_ES[1]='1'. !PRIEKÐAPMAKSU VAR KONTÇT ARÎ ÐITÂ
       .
       !***********datumu kontrole**********
       IF ~(GGK:DATUMS=GG:DATUMS)
          GGK:DATUMS=GG:DATUMS
          ggk:summa=ggk:summav*BANKURS(GGK:VAL,GGK:DATUMS)
          IF RIUPDATE:GGK()
             KLUDA(24,'GGK')
          ELSE
             DISABLE(?CANCEL)
          .
       .
       !***********raksta statusa kontrole**********
       IF ~(GGK:rs=GG:rs) AND GGK:U_NR>1 !Lai SALDO VARÇTU IEBÂZT NEAPSTIPRINÂTOS
          GGK:rs=GG:rs
          IF RIUPDATE:GGK()
             KLUDA(24,'GGK')
          ELSE
             DISABLE(?CANCEL)
          .
       .
       !***********partneru piespiedu kontrole**********
       if forcedparchange
          IF ~(GGK:par_nr=GG:par_nr)
             GGK:par_nr=GG:par_nr
             IF RIUPDATE:GGK()
                KLUDA(24,'GGK')
             ELSE
                DISABLE(?CANCEL)
             .
          .
       .
       IF ~(GGK:par_nr=GG:par_nr) THEN CHECK_PAR_NR='>'.
       !***********Nodaïas piespiedu kontrole**********
       if forcedNodalaChange
          IF ~(GGK:NODALA=Nodala)
             GGK:Nodala=Nodala
             IF RIUPDATE:GGK()
                KLUDA(24,'GGK')
             ELSE
    !            DISABLE(?CANCEL)
             .
          .
       .
       !***********PROJEKTA piespiedu kontrole**********
       if forcedPROJEKTSChange
          IF ~(GGK:OBJ_NR=PROJEKTS)
             GGK:OBJ_NR=PROJEKTS
             IF RIUPDATE:GGK()
                KLUDA(24,'GGK')
             ELSE
    !            DISABLE(?CANCEL)
             .
          .
       .
       !***********atlaides pârrçíins**********
       if forcedAtlaideChange
          GGK:SUMMAV=ggk:summav/(1-gg_atlaide/100)  !atjaunojam summu bez atlaides
          ggk:summav=ggk:summav*(1-gg:atlaide/100)  !un izrçíinam ar jauno atlaidi
          GGK:SUMMA=GGK:SUMMAV*BANKURS(GGK:VAL,GGK:DATUMS)
          IF RIUPDATE:GGK()
             KLUDA(24,'GGK')
          ELSE
             DISABLE(?CANCEL)
          .
       .
       !***********PVN piespiedu pârrçíins pçc CALC_PVNSUMMA_s **********
       IF forcedPVNchange18 AND GGK:BKK[1:4]='5721' AND (GGK:PVN_PROC=18 OR GGK:PVN_PROC=21 OR GGK:PVN_PROC=22) !18/21/22% PVN KONTS
          GGK:SUMMAV=CALC_PVNSUMMA18/BANKURS(GGK:VAL,GGK:DATUMS)
          GGK:SUMMA =CALC_PVNSUMMA18
          IF RIUPDATE:GGK()
             KLUDA(24,'GGK')
          ELSE
             DISABLE(?CANCEL)
          .
          forcedPVNchange18=FALSE
          CALC_PVNSUMMA18=0
       .
       IF forcedPVNchange5 AND GGK:BKK[1:4]='5721' AND (GGK:PVN_PROC=5 OR GGK:PVN_PROC=10 OR GGK:PVN_PROC=12) !5/10/12% PVN KONTS
          GGK:D_K=D_K
          GGK:SUMMAV=CALC_PVNSUMMA5/BANKURS(GGK:VAL,GGK:DATUMS)
          GGK:SUMMA =CALC_PVNSUMMA5
          IF RIUPDATE:GGK()
             KLUDA(24,'GGK')
          ELSE
             DISABLE(?CANCEL)
          .
          forcedPVNchange5=FALSE
          CALC_PVNSUMMA5=0
       .
       !***********fixçjam PVN SUMMU, ES*************
       IF GGK:BKK[1:4]='5721'
          IF GGK:PVN_PROC=18 OR GGK:PVN_PROC=21 OR GGK:PVN_PROC=22   !18/21/22% PVN KONTS
             COUNT_PVNSUMMA18+=GGK:SUMMA
             PVN18=GGK:PVN_PROC
          ELSIF GGK:PVN_PROC=5 OR GGK:PVN_PROC=10 OR GGK:PVN_PROC=12 !5/10/12% PVN KONTS
             COUNT_PVNSUMMA5 +=GGK:SUMMA
             PVN5=GGK:PVN_PROC
          .
          IF GETPAR_K(GG:PAR_NR,0,20)='C' AND GGK:D_K='D' THEN CHECK_ES[2]='1'.
          IF GETPAR_K(GG:PAR_NR,0,20)='C' AND GGK:D_K='K' THEN CHECK_ES[3]='1'.
       .
       !***********fixçjam D-GG:SUMMU,K-18&5% SUMMAS ~PVN,BILANCI*************
       IF GGK:D_K='D'
          GG_SUMMAV+=GGK:SUMMAV
          GG_SUMMA +=GGK:SUMMA
          BILANCE+=GGK:SUMMA
          BILANCE_VAL+=GGK:SUMMAV
       ELSE
          BILANCE-=GGK:SUMMA
          BILANCE_VAL-=GGK:SUMMAV
          IF ~(GGK:BKK[1:4]='5721')
             IF GGK:PVN_PROC=18 OR GGK:PVN_PROC=21 OR GGK:PVN_PROC=22
                K_SUMMA18+=GGK:SUMMA
             ELSIF GGK:PVN_PROC=5 OR GGK:PVN_PROC=10 OR GGK:PVN_PROC=12
                K_SUMMA5 +=GGK:SUMMA
             .
          .
       .
       !***********KK kontrole*******************
       IF GGK:KK
          IF GGK:D_K='K'
             KK_SUMMA=-GGK:SUMMA
          ELSE
             KK_SUMMA=GGK:SUMMA
          .
          IF BAND(GGK:KK,00000001b) THEN KKS[1]+=KK_SUMMA.
          IF BAND(GGK:KK,00000010b) THEN KKS[2]+=KK_SUMMA.
          IF BAND(GGK:KK,00000100b) THEN KKS[3]+=KK_SUMMA.
          IF BAND(GGK:KK,00001000b) THEN KKS[4]+=KK_SUMMA.
          IF BAND(GGK:KK,00010000b) THEN KKS[5]+=KK_SUMMA.
          IF BAND(GGK:KK,00100000b) THEN KKS[6]+=KK_SUMMA.
          IF BAND(GGK:KK,01000000b) THEN KKS[7]+=KK_SUMMA.
          IF BAND(GGK:KK,10000000b) THEN KKS[8]+=KK_SUMMA.
       .
    .
    ! STOP('BTLOOP')
  END
  HIDE(?KKKLUDA)
  LOOP B#=1 TO 8
    IF STRINGBYTE[9-B#]     !KASE/BANKA/...
       GG:TIPS+=2^(B#-1)
    .
    IF KKS[B#]              !KK Kontrole
       UNHIDE(?KKKLUDA)
    .
  .
  IF MULTIVAL=TRUE
     GG:SUMMA = GG_SUMMA
  ELSE
     GG:SUMMA = GG_SUMMAV
  .
  !Elya 27/11/2013 GG:VAL=val_nos
  !stop('val_nos '&val_nos)
  !Elya 01/07/2014 GG:VAL=val_uzsk
  GG:VAL=val_nos !Elya 01/07/2014 
  SETCURSOR()
  DO BRW2::Reset
  PREVIOUS(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GGK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 1
    BRW2::Sort1:HighValue = GGK:BKK
  END
  DO BRW2::Reset
  NEXT(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GGK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 1
    BRW2::Sort1:LowValue = GGK:BKK
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
  GGK:D_K = BRW2::GGK:D_K
  GGK:BKK = BRW2::GGK:BKK
  GGK:NODALA = BRW2::GGK:NODALA
  GGK:OBJ_NR = BRW2::GGK:OBJ_NR
  GGK:SUMMA = BRW2::GGK:SUMMA
  GGK:SUMMAV = BRW2::GGK:SUMMAV
  GGK:PVN_PROC = BRW2::GGK:PVN_PROC
  GGK:VAL = BRW2::GGK:VAL
  GGK:REFERENCE = BRW2::GGK:REFERENCE
  GGK:PAR_NR = BRW2::GGK:PAR_NR
  KKSTRING = BRW2::KKSTRING
  ATLAUTS = BRW2::ATLAUTS
  GGK:U_NR = BRW2::GGK:U_NR
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
  KKSTRING = CALCKK(GGK:KK)
  BRW2::GGK:D_K = GGK:D_K
  BRW2::GGK:BKK = GGK:BKK
  BRW2::GGK:NODALA = GGK:NODALA
  BRW2::GGK:OBJ_NR = GGK:OBJ_NR
  BRW2::GGK:SUMMA = GGK:SUMMA
  BRW2::GGK:SUMMAV = GGK:SUMMAV
  BRW2::GGK:PVN_PROC = GGK:PVN_PROC
  BRW2::GGK:VAL = GGK:VAL
  BRW2::GGK:REFERENCE = GGK:REFERENCE
  BRW2::GGK:PAR_NR = GGK:PAR_NR
  BRW2::KKSTRING = KKSTRING
  BRW2::ATLAUTS = ATLAUTS
  BRW2::GGK:U_NR = GGK:U_NR
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
          IF BRW2::Sort1:KeyDistribution[BRW2::CurrentScroll] => UPPER(GGK:BKK)
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
      GGK:BKK = BRW2::Sort1:KeyDistribution[?Browse:2{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'GGK')
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
      BRW2::HighlightedPosition = POSITION(GGK:NR_KEY)
      RESET(GGK:NR_KEY,BRW2::HighlightedPosition)
    ELSE
      GGK:U_NR = GG:U_NR
      SET(GGK:NR_KEY,GGK:NR_KEY)
    END
    BRW2::View:Browse{Prop:Filter} = |
    'GGK:U_NR = GG:U_NR'
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
    CLEAR(GGK:Record)
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
    GGK:U_NR = GG:U_NR
    SET(GGK:NR_KEY)
    BRW2::View:Browse{Prop:Filter} = |
    'GGK:U_NR = GG:U_NR'
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
    GG:U_NR = BRW2::Sort1:Reset:GG:U_NR
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
  GET(GGK,0)
  CLEAR(GGK:Record,0)
  CASE BRW2::SortOrder
  OF 1
    GGK:U_NR = BRW2::Sort1:Reset:GG:U_NR
  END
  LocalRequest = InsertRecord
   IF COPYREQUEST=1
       DO SYNCWINDOW
       GGK:U_NR=0
!       GGK:D_K=BRW2::GGK:D_K
!       GGK:BKK=BRW2::GGK:BKK
       GGK:REFERENCE=''
!       GGK:PVN_PROC=BRW2::GGK:PVN_PROC
   .

  DO BRW2::CallUpdate
  !stop('GGK:PVN_PROC'&GGK:PVN_PROC)
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
!| (UpdateGGK) is called.
!|
!| Upon return from the update, the routine BRW2::Reset is called to reset the VIEW
!| and reopen it.
!|
  ALERT
  CLOSE(BRW2::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateGGK
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
        GET(GGK,0)
        CLEAR(GGK:Record,0)
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
    OF ?GG:U_NR
      GG:U_NR = History::GG:Record.U_NR
    OF ?GG:ES
      GG:ES = History::GG:Record.ES
    OF ?GG:IMP_NR
      GG:IMP_NR = History::GG:Record.IMP_NR
    OF ?GG:APMDAT
      GG:APMDAT = History::GG:Record.APMDAT
    OF ?GG:DATUMS
      GG:DATUMS = History::GG:Record.DATUMS
    OF ?GG:DOK_SENR
      GG:DOK_SENR = History::GG:Record.DOK_SENR
    OF ?GG:DOKDAT
      GG:DOKDAT = History::GG:Record.DOKDAT
    OF ?GG:NOKA
      GG:NOKA = History::GG:Record.NOKA
    OF ?GG:PAR_NR
      GG:PAR_NR = History::GG:Record.PAR_NR
    OF ?GG:SATURS
      GG:SATURS = History::GG:Record.SATURS
    OF ?GG:SATURS2
      GG:SATURS2 = History::GG:Record.SATURS2
    OF ?GG:SATURS3
      GG:SATURS3 = History::GG:Record.SATURS3
    OF ?GG:SUMMA
      GG:SUMMA = History::GG:Record.SUMMA
    OF ?GG:VAL
      GG:VAL = History::GG:Record.VAL
    OF ?GG:ACC_KODS
      GG:ACC_KODS = History::GG:Record.ACC_KODS
    OF ?GG:ACC_DATUMS
      GG:ACC_DATUMS = History::GG:Record.ACC_DATUMS
    OF ?GG:SECIBA
      GG:SECIBA = History::GG:Record.SECIBA
    OF GG:ATLAIDE:2
      GG:Atlaide = History::GG:Record.Atlaide
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
  GG:Record = SAV::GG:Record
  GG:DOKDAT = SAV_DATUMS
  GG:DATUMS = SAV_datums
  !stop('!!!!')
  SAV::GG:Record = GG:Record
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
    GG:Record = SAV::GG:Record
    GG:U_NR = Auto::Save:GG:U_NR
    SAV::GG:Record = GG:Record
    !stop('!!!!')
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
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    DO CancelAutoIncrement
  END

CancelAutoIncrement ROUTINE
  IF LocalResponse <> RequestCompleted
    IF OriginalRequest = InsertRecord
      IF LocalResponse = RequestCancelled
        DELETE(GG)
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

PerformASSAKO1       PROCEDURE                    ! Declare Procedure
MENESI      CSTRING(100)
PAR_LIGUMS  LIKE(PAR:LIGUMS)
CET_NR      BYTE
S_GADS      USHORT
B_GADS      USHORT
GG_SUMMA    LIKE(GG:SUMMA)

  CODE                                            ! Begin processed code
!****************** BÛS rçíins VIÒiem *****************

!    OPCIJA='1202'
!!           1234
!    IZZFILTGMC
!    IF GLOBALRESPONSE=REQUESTCOMPLETED
      S_GADS=YEAR(S_DAT)
      B_GADS=YEAR(B_DAT)
!     No izsaucçja saòeman modificçtus MEN_NR un MENESU_SKAITS UN SUMMA(KOPÂ MENESU_SKAITâ)
!      MEN_NR=MONTH(S_DAT) !NO MEN_NR 1-19 UZTAISAM 1-12
      PAR_LIGUMS=PAR:LIGUMS !???
!      SUMMA=PAR:L_SUMMA1    !BEZ PVN MÇNESÎ
      IF PAR:L_CDATUMS > S_DAT
         KLUDA(0,CLIP(PAR:NOS_S)&' Karte='&CLIP(PAR:KARTE)&' ðíiet,jâmaksâ tikai no '&format(PAR:L_CDATUMS,@D06.)&|
         ',pameklçðu iepriekðçjo')
      .
      IF PAR:ATLAIDE  !?????????????????????????
         SUMMA=SUMMA*(1-PAR:ATLAIDE/100)
         GG:ATLAIDE=PAR:ATLAIDE
      .
!      SUMMA=SUMMA*menesu_skaits

      IF SUMMA
         MENESI=''
         gg:apmdat=date(MEN_NR+menesu_skaits,1,YEAR(B_DAT))-1 !LAI BÛTU PAREIZI, UZ PERIODA PÇD. DATUMU.
         IF GG:APMDAT<TODAY()+7       !Dodam tomçr nedçïu laika
            gg:apmdat=TODAY()+7
         .
         IF S_GADS=B_GADS
            CET_NR=INT((MEN_NR-1)/3)+1   !TAGAD MEN_NR-SÂKUMA MÇNESIS
            IF menesu_skaits <=3
               GG:DOK_SENR=CLIP(PAR:KARTE)&'-'&CET_NR&B_GADS
            ELSIF menesu_skaits <=6
               GG:DOK_SENR=CLIP(PAR:KARTE)&'-'&CET_NR&CET_NR+1&B_GADS
            ELSIF menesu_skaits <=9
               GG:DOK_SENR=CLIP(PAR:KARTE)&'-'&CET_NR&CET_NR+1&CET_NR+2&B_GADS
            ELSE
               GG:DOK_SENR=CLIP(PAR:KARTE)&'-'&CET_NR&CET_NR+1&CET_NR+2&CET_NR+3&B_GADS
            .
            LOOP M#=MEN_NR TO MEN_NR+menesu_skaits-1  !TAGAD MEN_NR-SÂKUMA MÇNESIS
               IF menesu_skaits<=7                    !VÂRDOS VAIRÂK NAV VIETAS
                  MENESI=CLIP(MENESI)&','&CLIP(MENVAR(M#,1,1))
               ELSE
                  MENESI='.'&CLIP(MEN_NR)&'-'&CLIP(M#)&'m.'
               .
            .
         ELSIF S_GADS<B_GADS
            KLUDA(0,'Rçíins par 2 gadiem...',,1)
            GG:DOK_SENR=CLIP(PAR:KARTE)&'-M'&B_GADS
            LOOP M#=MEN_NR TO MEN_NR+menesu_skaits-1  !TAGAD MEN_NR-SÂKUMA MÇNESIS
               IF menesu_skaits<=7                    !VÂRDOS VAIRÂK NAV VIETAS
                  MENESI=CLIP(MENESI)&','&CLIP(MENVAR(M#-NY#,1,1))
               ELSE
                  MENESI='.'&CLIP(MEN_NR)&'-12m.'&S_GADS&'.g.,'&'1-'&MEN_NR+menesu_skaits-12-1&'m.'
                  BREAK
               .
               IF M#=12 !NÂKOÐAIS BÛS JAUNS GADS
                  MENESI=CLIP(MENESI)&' '&S_GADS&'.g.,'
                  NY#=12
               .
            .
         ELSE
            GG:DOK_SENR=CLIP(PAR:KARTE)&'-M'&B_GADS
            MENESI=FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&S_GADS&','
         .
         MENESI[1]=' '
         IF ~SAV_DATUMS THEN SAV_DATUMS=PAR:L_DATUMS.
         IF PAR:KARTE>999  !WINLATS
            TEKSTS='Pçcgarantijas apkalpoðana saskaòâ ar Licenci Nr '&PAR:KARTE&' no '&FORMAT(SAV_DATUMS,@D06.)&|
            MENESI&' '&B_GADS&'.gads'
         ELSE
            TEKSTS='Pçcgarantijas apkalpoðana saskaòâ ar Lîgumu Nr '&PAR:KARTE&' no '&FORMAT(SAV_DATUMS,@D06.)&|
            MENESI&' '&B_GADS&'.gads'
         .
         FORMAT_TEKSTS(47,'WINDOW',0,'',)
         gg:saturs =F_TEKSTS[1]
         gg:saturs2=F_TEKSTS[2]
         gg:saturs3=F_TEKSTS[3]

         IF GETPAR_K(GG:PAR_NR,0,29,,'14')    !PIEKRÎT e-R
            IF GETPAR_K(GG:PAR_NR,0,29,,'37') !LIELA Diþíibeles atlaide-pagaidâm
               gg:atlaide=20
               summa-=(summa/100)*20
            ELSIF GETPAR_K(GG:PAR_NR,0,29,,'39') !ÏOTI LIELA Diþíibeles atlaide-pagaidâm
               gg:atlaide=30
               summa-=(summa/100)*30
            ELSIF GETPAR_K(GG:PAR_NR,0,29,,'41') !50% Diþíibeles atlaide-pagaidâm
               gg:atlaide=50
               summa-=(summa/100)*50
            ELSE
               gg:atlaide=10                  !Diþíibeles atlaide-pagaidâm
               summa-=summa/10
            .
         .
         CHECKOPEN(GGK,1)
         CHECKOPEN(KON_K,1)
         IF val_nos=''
            !11/03/2014 GGK:val='Ls'
            !11/03/2014 GG:val='Ls'
            GGK:val=val_uzsk !11/03/2014 
            GG:val=val_uzsk !11/03/2014 
         ELSE
            GGK:val=val_nos
            GG:val=val_nos
         .
         GGK:U_NR=GG:U_NR
         ggk:rs=gg:rs
         GGK:DATUMS=GG:DATUMS
         GGK:PVN_PROC=sys:nokl_pvn
         GGK:PVN_TIPS=0
         GGK:REFERENCE=0
         GGK:PAR_NR=GG:PAR_NR
         !12/03/2014 <
         CHECKOPEN(GLOBAL,1)
         IF GL:VID_NR=''
            GGK:SUMMAV= Summa
            ggk:bkk='23100'
            ggk:D_K='D'
            GGK:BAITS = 2
            GGK:PVN_PROC=0
            DO ADDGGK
            GG_SUMMA=GGK:SUMMAV
            ggk:D_K='K'
            !12/03/2014 ggk:bkk='61M00'
            ggk:bkk='61103' !12/03/2014 
            GGK:SUMMAV=summa
            GGK:BAITS = 2
            GGK:PVN_PROC=0
            DO ADDGGK
         ELSE
         !12/03/2014 >
            GGK:SUMMAV= Summa*(1+sys:nokl_pvn/100)
            ggk:bkk='23100'
            ggk:D_K='D'
            DO ADDGGK
            GG_SUMMA=GGK:SUMMAV

            ggk:D_K='K'
            ggk:bkk='57210'
            GGK:SUMMAV=summa*(sys:nokl_pvn/100)
            DO ADDGGK

            ggk:D_K='K'
            !12/03/2014 ggk:bkk='61M00'
            ggk:bkk='61103' !12/03/2014 
            GGK:SUMMAV=summa
            DO ADDGGK
         .  !12/03/2014
      ELSE
         STOP(CLIP(PAR:NOS_S)&' NULLES SUMMA ...')
      .
      SUMMA=GG_SUMMA !23100 SUMMA AR PVN
!    .
     DO PROCEDURERETURN !15/03/2014
!--------------------------------------------------------------------------
ADDGGK    ROUTINE
        GGK:SUMMA=GGK:SUMMAV*BANKURS(GGK:VAL,GGK:DATUMS)
        ADD(GGK)
        IF ~ERROR()
           CASE GGK:D_K
           OF 'D'
              CONTROL$+=GGK:SUMMA
           OF 'K'
              CONTROL$-=GGK:SUMMA
           .
           ATLIKUMIB(GGK:D_K,GGK:BKK,GGK:SUMMA,GGK:D_K,GGK:BKK,0)
        ELSE
           STOP('Rakstot ggk:'&ERROR())
           DO PROCEDURERETURN
        .
!--------------------------------------------------------------------------
PROCEDURERETURN    ROUTINE     !15/03/2014
!  CLOSE(GGK)
!  CLOSE(KON_K)
  CLOSE(GLOBAL)
  RETURN
UpdatePamat PROCEDURE


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
VERT_S               DECIMAL(9,2)
KAT                  STRING(3)
GA                   USHORT,DIM(40)
VERT_IZM             DECIMAL(9,2)
gadi_procenti        STRING(4)
CHANGEPOINT          LONG
FORCEDNODALACHANGE   BYTE
PROTEXT              STRING(25)
LIN_END_DAT          ULONG
LIN_GADI             DECIMAL(6,3)
PAM_ATB_NOS          STRING(20)
KON_NOSAUKUMS        STRING(20)
PAM_VIETA            STRING(25)

BRW2::View:Browse    VIEW(PAMAM)
                       PROJECT(AMO:YYYYMM)
                       PROJECT(AMO:LIN_G_PR)
                       PROJECT(AMO:NODALA)
                       PROJECT(AMO:SAK_V_LI)
                       PROJECT(AMO:NOL_U_LI)
                       PROJECT(AMO:NOL_LIN)
                       PROJECT(AMO:LOCK_LIN)
                       PROJECT(AMO:U_NR)
                     END

Queue:Browse:2       QUEUE,PRE()                  ! Browsing Queue
BRW2::AMO:YYYYMM       LIKE(AMO:YYYYMM)           ! Queue Display field
BRW2::KAT              LIKE(KAT)                  ! Queue Display field
BRW2::AMO:LIN_G_PR     LIKE(AMO:LIN_G_PR)         ! Queue Display field
BRW2::AMO:NODALA       LIKE(AMO:NODALA)           ! Queue Display field
BRW2::AMO:SAK_V_LI     LIKE(AMO:SAK_V_LI)         ! Queue Display field
BRW2::VERT_IZM         LIKE(VERT_IZM)             ! Queue Display field
BRW2::AMO:NOL_U_LI     LIKE(AMO:NOL_U_LI)         ! Queue Display field
BRW2::AMO:NOL_LIN      LIKE(AMO:NOL_LIN)          ! Queue Display field
BRW2::AMO:LOCK_LIN     LIKE(AMO:LOCK_LIN)         ! Queue Display field
BRW2::AMO:U_NR         LIKE(AMO:U_NR)             ! Queue Display field
BRW2::Mark             BYTE                       ! Queue POSITION information
BRW2::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW2::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW2::Sort1:Reset:PAM:U_NR LIKE(PAM:U_NR)
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
History::PAM:Record LIKE(PAM:Record),STATIC
SAV::PAM:Record      LIKE(PAM:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:PAM:U_NR     LIKE(PAM:U_NR)
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Pamatlîdzekïa kartiòa'),AT(,,584,352),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,VSCROLL,HLP('UpdatePamat'),SYSTEM,GRAY,MDI
                       BUTTON('Atvçrt U_Nr'),AT(11,2,45,14),USE(?Buttonu_Nr),DISABLE
                       ENTRY(@n_7B),AT(60,3,26,12),USE(PAM:U_NR),DISABLE
                       BUTTON('Atbildîgais'),AT(10,17,45,14),USE(?Atbildigais)
                       STRING(@s30),AT(60,21),USE(PAM_ATB_NOS),LEFT
                       PROMPT('Izgatavoð.gads:'),AT(91,6,52,12),USE(?PAM:IZG_GAD:Prompt)
                       ENTRY(@n_4B),AT(145,4,31,12),USE(PAM:IZG_GAD),RIGHT(1),REQ
                       PROMPT('Iegâdes datums:'),AT(3,37,57,10),USE(?PAM:DATUMS:Prompt)
                       ENTRY(@D06.B),AT(62,35,44,12),USE(PAM:DATUMS),CENTER,REQ,OVR
                       PROMPT('Dok.Nr:'),AT(108,38),USE(?PAM:DOK_NR:Prompt)
                       PROMPT('Ekspl.n. dat:'),AT(3,49,43,10),USE(?PAM:expl_datums:Prompt)
                       BUTTON('&='),AT(46,47,14,14),USE(?Button22)
                       ENTRY(@D06.B),AT(62,48,44,12),USE(PAM:EXPL_DATUMS),CENTER,REQ
                       STRING('(no nâk.mçneða sâk'),AT(108,49,75,10),USE(?String40),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       ENTRY(@s14),AT(134,35,52,12),USE(PAM:DOK_SENR)
                       PROMPT('Pilns nosaukums:'),AT(6,60,69,10),USE(?PAM:NOS_P:Prompt)
                       STRING('rçíinât LIN )'),AT(113,58,51,10),USE(?String40:2),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       ENTRY(@s35),AT(6,70,159,12),USE(PAM:NOS_P)
                       PROMPT('Saîsinâtais Nos:'),AT(6,86,57,10),USE(?PAM:NOS_S:Prompt)
                       ENTRY(@s15),AT(66,85,64,12),USE(PAM:NOS_S)
                       STRING(@s5),AT(143,86),USE(PAM:NOS_A),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       BUTTON('Uzskaites konts'),AT(4,101,63,14),USE(?UzskKonts)
                       ENTRY(@s5),AT(70,101,26,12),USE(PAM:BKK),REQ
                       STRING(@s20),AT(100,104),USE(KON_NOSAUKUMS),LEFT,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       BUTTON('Noliet.uzsk.konts'),AT(4,117,63,14),USE(?UzskKonts:2)
                       ENTRY(@s5),AT(70,117,26,12),USE(PAM:BKKN),REQ
                       BUTTON('7-grupa'),AT(99,116,35,14),USE(?UzskKonts7)
                       ENTRY(@s5),AT(138,118,26,12),USE(PAM:OKK7)
                       PROMPT('Iegâdes vçrtîba:'),AT(6,135,66,10),USE(?PAM:IEP_V:Prompt)
                       ENTRY(@n-15.2),AT(81,133,47,12),USE(PAM:IEP_V),RIGHT(2)
                       PROMPT('Vçrtîbas izmaiòas:'),AT(6,147,68,10),USE(?PAM:KAP_V:Prompt)
                       ENTRY(@n-15.2),AT(81,147,47,12),USE(PAM:KAP_V),RIGHT(2)
                       STRING('(uz 31.12.1994)'),AT(130,147),USE(?StringVertIzm)
                       PROMPT('Uzkrâtais nolietojums:'),AT(6,161,73,10),USE(?PAM:NOL_V:Prompt)
                       ENTRY(@n-15.2),AT(81,161,47,12),USE(PAM:NOL_V),RIGHT(2)
                       STRING('(uz 31.12.1994)'),AT(130,161),USE(?String6)
                       STRING('Uzskaites v. nol. apr.:'),AT(6,176),USE(?String4)
                       STRING(@n-13.2),AT(78,176),USE(PAM:BIL_V),RIGHT(2)
                       GROUP('Sâkuma nosacîjumi uz iegâdes brîdi:'),AT(3,190,182,126),USE(?Group1),BOXED
                         BUTTON('Kategorija'),AT(3,201,45,14),USE(?BUTTONkategorija)
                         STRING(@p#-##p),AT(49,205),USE(PAM:KAT[1],,?PAM:KAT_NR_1:2)
                         STRING(@s35),AT(68,205,115,10),USE(KAT:NOSAUKUMS),LEFT(1),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                         STRING('Likme GD %'),AT(13,216),USE(?String15)
                         STRING(@n2),AT(54,216),USE(PAM:GD_PR[1],,?PAM:GD_PR_1:2),RIGHT(1)
                         ENTRY(@N_6B),AT(54,280),USE(PAM:OBJ_NR),LEFT
                         STRING(@s25),AT(89,282,94,10),USE(PROTEXT),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                         BUTTON('Atraðanâs vieta'),AT(4,297,63,14),USE(?Button38)
                         STRING(@s25),AT(68,300,106,10),USE(PAM_VIETA),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                         PROMPT('Skaits:'),AT(13,246),USE(?PAM:SKAITS:Prompt)
                         ENTRY(@n-4.0),AT(39,244,25,12),USE(PAM:SKAITS),RIGHT(1)
                         PROMPT('GD  koeficients:'),AT(74,251,63,10),USE(?PAM:GDPLUS_KOEF:Promp),RIGHT
                         ENTRY(@n-6.3),AT(138,249,34,12),USE(PAM:GD_KOEF[1],,?PAM:GDPLUS_KOEF_1:2),CENTER
                         BUTTON('&Nodaïa'),AT(10,262,49,14),USE(?BN)
                         STRING(@s2),AT(61,265,10,10),USE(PAM:NODALA)
                         PROMPT('Nol.likme LIN:'),AT(73,216,48,10),USE(?PAM:LIN_G_PR:Prompt)
                         ENTRY(@n-7.3),AT(122,215,40,12),USE(PAM:LIN_G_PR),DECIMAL(16)
                         STRING(@s4),AT(163,216,17,10),USE(gadi_procenti),LEFT(1)
                         BUTTON('Neatkarîgi no vçrt.izmaiòâm'),AT(73,229,95,14),USE(?BUTTONNVI)
                         STRING('0 vert.'),AT(5,232,23,10),USE(?String56),CENTER
                         IMAGE('CHECK3.ICO'),AT(169,226,14,19),USE(?ImageNVI),HIDE
                         STRING(@D06.B),AT(26,232,47,10),USE(LIN_END_DAT),CENTER
                         BUTTON('Izmanto raþoðanâ'),AT(118,265,63,14),USE(?ButtonRaz)
                         BUTTON('&Projekts(Obj.)'),AT(4,279,49,14),USE(?Button:projekts)
                       END
                       PROMPT('Noòemts no uzskaites:'),AT(22,322,76,10),USE(?PAM:END_DATE:Prompt)
                       ENTRY(@D06.B),AT(99,320,48,12),USE(PAM:END_DATE),RIGHT(1)
                       SHEET,AT(189,0,392,327),USE(?CurrentTab)
                         TAB('&0-P/L Kartiòa LIN metode'),USE(?Tab:1)
                           LIST,AT(195,14,382,287),USE(?Browse:2),IMM,MSG('Browsing Records'),FORMAT('33L(1)|M~Mçn.Gads~C(0)@D014.@18C|M~Kat~@P#-##P@26R(1)|M~LIN~C(0)@n_6.3@10R(1)|M~' &|
   'N~C(0)@s2@37R(1)|M~Sâk.vçrt~C(0)@n_10.2B@32R(1)|M~Vçrt.izm.~C(0)@n-_11.2B@37R(1)' &|
   '|M~Uzkr.nol.~C(0)@n_10.2B@38L(1)|M~Nolietojums~C(0)@n_10.3B@12L(1)|M~L~C(0)@n1b@'),FROM(Queue:Browse:2)
                           BUTTON('&Ievadît'),AT(307,305,45,14),USE(?Insert:3),HIDE
                           BUTTON('&Mainît'),AT(355,305,45,14),USE(?Change:3),DEFAULT
                           BUTTON('&Dzçst'),AT(403,305,45,14),USE(?Delete:3)
                         END
                         TAB('1-&Gada vçrtîbas un GD nolietojums'),USE(?Tab:2)
                           STRING('neòemot vçrâ korekcijas'),AT(295,9),USE(?String53)
                           STRING('Kateg.'),AT(209,21),USE(?String11)
                           STRING('Lik.%'),AT(231,21),USE(?String12)
                           STRING('GD Koef'),AT(249,21),USE(?String13)
                           STRING('Sâk.v.'),AT(287,21),USE(?String13:2)
                           STRING('Nolietojums'),AT(323,21),USE(?String14)
                           STRING(@n4),AT(189,34,21,10),USE(GA[1],,?GA1),RIGHT(1)
                           STRING(@p#-##p),AT(211,34,21,10),USE(PAM:KAT[1]),CENTER
                           STRING(@n2),AT(232,34,13,10),USE(PAM:GD_PR[1]),RIGHT(1)
                           STRING(@n-6.3),AT(244,34,28,10),USE(PAM:GD_KOEF[1]),RIGHT(1)
                           STRING(@n11.2B),AT(272,35,46,10),USE(PAM:SAK_V_GD[1])
                           ENTRY(@n13.2),AT(318,33,41,13),USE(PAM:NOL_GD[1]),RIGHT(1)
                           BUTTON('Lk'),AT(360,33,13,14),USE(?Lock1)
                           IMAGE('CHECK3.ICO'),AT(374,32,14,14),USE(?Image1),HIDE,CENTERED
                           STRING(@n4),AT(189,48,21,10),USE(GA[2],,?GA2),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,48,47,10),USE(PAM:SAK_V_GD[2])
                           ENTRY(@p#-##p),AT(211,45,21,13),USE(PAM:KAT[2]),HIDE,CENTER
                           ENTRY(@n2),AT(233,45,14,13),USE(PAM:GD_PR[2]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,45,23,13),USE(PAM:GD_KOEF[2]),HIDE,RIGHT(1)
                           ENTRY(@n13.2),AT(318,46,41,13),USE(PAM:NOL_GD[2]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,46,13,14),USE(?Lock2),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,46,14,14),USE(?Image2),HIDE,CENTERED
                           ENTRY(@s3),AT(408,33,21,13),USE(PAM:KAT[21]),HIDE,CENTER
                           ENTRY(@n2),AT(430,33,14,13),USE(PAM:GD_PR[21]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,33,23,13),USE(PAM:GD_KOEF[21]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,33,36,13),USE(PAM:NOL_GD[21]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(551,33,13,13),USE(?Lock21),HIDE
                           STRING(@n4),AT(189,62,21,10),USE(GA[3],,?GA3),HIDE,RIGHT(1)
                           IMAGE('CHECK3.ICO'),AT(565,32,14,14),USE(?Image21),HIDE,CENTERED
                           STRING(@n11.2B),AT(272,63,47,10),USE(PAM:SAK_V_GD[3])
                           ENTRY(@p#-##p),AT(211,57,21,13),USE(PAM:KAT[3]),HIDE,CENTER
                           ENTRY(@n2),AT(233,57,14,13),USE(PAM:GD_PR[3]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,57,23,13),USE(PAM:GD_KOEF[3]),HIDE,RIGHT(1)
                           ENTRY(@n13.2),AT(318,61,41,13),USE(PAM:NOL_GD[3]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,61,13,13),USE(?Lock3),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,61,14,14),USE(?Image3),HIDE,CENTERED
                           ENTRY(@s3),AT(408,46,21,13),USE(PAM:KAT[22]),HIDE,CENTER
                           ENTRY(@n2),AT(430,46,14,13),USE(PAM:GD_PR[22]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,46,23,13),USE(PAM:GD_KOEF[22]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,46,36,13),USE(PAM:NOL_GD[22]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(551,46,13,13),USE(?Lock22),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,46,14,14),USE(?Image22),HIDE,CENTERED
                           STRING(@n4),AT(386,48,21,10),USE(GA[22],,?GA22),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(468,49,46,10),USE(PAM:SAK_V_GD[22])
                           ENTRY(@s3),AT(408,299,21,13),USE(PAM:KAT[40]),HIDE,CENTER
                           ENTRY(@n2),AT(430,299,14,13),USE(PAM:GD_PR[40]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,299,23,13),USE(PAM:GD_KOEF[40]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,285,21,13),USE(PAM:KAT[39]),HIDE,CENTER
                           ENTRY(@n2),AT(430,285,14,13),USE(PAM:GD_PR[39]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,285,23,13),USE(PAM:GD_KOEF[39]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,270,21,13),USE(PAM:KAT[38]),HIDE,CENTER
                           ENTRY(@n2),AT(430,270,14,13),USE(PAM:GD_PR[38]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,270,23,13),USE(PAM:GD_KOEF[38]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,257,21,13),USE(PAM:KAT[37]),HIDE,CENTER
                           ENTRY(@n2),AT(430,257,14,13),USE(PAM:GD_PR[37]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,257,23,13),USE(PAM:GD_KOEF[37]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,243,21,13),USE(PAM:KAT[36]),HIDE,CENTER
                           ENTRY(@n2),AT(430,243,14,13),USE(PAM:GD_PR[36]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,243,23,13),USE(PAM:GD_KOEF[36]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,229,21,13),USE(PAM:KAT[35]),HIDE,CENTER
                           ENTRY(@n2),AT(430,229,14,13),USE(PAM:GD_PR[35]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,229,23,13),USE(PAM:GD_KOEF[35]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,214,21,13),USE(PAM:KAT[34]),HIDE,CENTER
                           ENTRY(@n2),AT(430,214,14,13),USE(PAM:GD_PR[34]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,214,23,13),USE(PAM:GD_KOEF[34]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,201,21,13),USE(PAM:KAT[33]),HIDE,CENTER
                           ENTRY(@n2),AT(430,201,14,13),USE(PAM:GD_PR[33]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,201,23,13),USE(PAM:GD_KOEF[33]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,187,21,13),USE(PAM:KAT[32]),HIDE,CENTER
                           ENTRY(@n2),AT(430,187,14,13),USE(PAM:GD_PR[32]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,187,23,13),USE(PAM:GD_KOEF[32]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,173,21,13),USE(PAM:KAT[31]),HIDE,CENTER
                           ENTRY(@n2),AT(430,173,14,13),USE(PAM:GD_PR[31]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,173,23,13),USE(PAM:GD_KOEF[31]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,158,21,13),USE(PAM:KAT[30]),HIDE,CENTER
                           ENTRY(@n2),AT(430,158,14,13),USE(PAM:GD_PR[30]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,158,23,13),USE(PAM:GD_KOEF[30]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,145,21,13),USE(PAM:KAT[29]),HIDE,CENTER
                           ENTRY(@n2),AT(430,145,14,13),USE(PAM:GD_PR[29]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,145,23,13),USE(PAM:GD_KOEF[29]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,131,21,13),USE(PAM:KAT[28]),HIDE,CENTER
                           ENTRY(@n2),AT(430,131,14,13),USE(PAM:GD_PR[28]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,131,23,13),USE(PAM:GD_KOEF[28]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,117,21,13),USE(PAM:KAT[27]),HIDE,CENTER
                           ENTRY(@n2),AT(430,117,14,13),USE(PAM:GD_PR[27]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,117,23,13),USE(PAM:GD_KOEF[27]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,102,21,13),USE(PAM:KAT[26]),HIDE,CENTER
                           ENTRY(@n2),AT(430,102,14,13),USE(PAM:GD_PR[26]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,102,23,13),USE(PAM:GD_KOEF[26]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,89,21,13),USE(PAM:KAT[25]),HIDE,CENTER
                           ENTRY(@n2),AT(430,89,14,13),USE(PAM:GD_PR[25]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,89,23,13),USE(PAM:GD_KOEF[25]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,75,21,13),USE(PAM:KAT[24]),HIDE,CENTER
                           BUTTON('Lk'),AT(551,299,13,13),USE(?Lock40),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,298,14,14),USE(?Image40),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,285,13,13),USE(?Lock39),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,285,14,14),USE(?Image39),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,270,13,13),USE(?Lock38),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,270,14,14),USE(?Image38),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,257,13,13),USE(?Lock37),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,256,14,14),USE(?Image37),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,243,13,13),USE(?Lock36),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,242,14,14),USE(?Image36),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,229,13,13),USE(?Lock35),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,229,14,14),USE(?Image35),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,214,13,13),USE(?Lock34),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,214,14,14),USE(?Image34),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,201,13,13),USE(?Lock33),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,200,14,14),USE(?Image33),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,187,13,13),USE(?Lock32),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,186,14,14),USE(?Image32),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,173,13,13),USE(?Lock31),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,173,14,14),USE(?Image31),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,158,13,13),USE(?Lock30),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,158,14,14),USE(?Image30),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,145,13,13),USE(?Lock29),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,144,14,14),USE(?Image29),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,133,13,13),USE(?Lock28),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,130,14,14),USE(?Image28),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,117,13,13),USE(?Lock27),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,117,14,14),USE(?Image27),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,102,13,13),USE(?Lock26),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,102,14,14),USE(?Image26),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,89,13,13),USE(?Lock25),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,88,14,14),USE(?Image25),HIDE,CENTERED
                           BUTTON('Lk'),AT(551,75,13,13),USE(?Lock24),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,74,14,14),USE(?Image24),HIDE,CENTERED
                           ENTRY(@n2),AT(430,75,14,13),USE(PAM:GD_PR[24]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,75,23,13),USE(PAM:GD_KOEF[24]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,75,36,13),USE(PAM:NOL_GD[24]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,299,36,13),USE(PAM:NOL_GD[40]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,285,36,13),USE(PAM:NOL_GD[39]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,270,36,13),USE(PAM:NOL_GD[38]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,257,36,13),USE(PAM:NOL_GD[37]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,243,36,13),USE(PAM:NOL_GD[36]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,229,36,13),USE(PAM:NOL_GD[35]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,214,36,13),USE(PAM:NOL_GD[34]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,201,36,13),USE(PAM:NOL_GD[33]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,187,36,13),USE(PAM:NOL_GD[32]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,173,36,13),USE(PAM:NOL_GD[31]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,158,36,13),USE(PAM:NOL_GD[30]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,145,36,13),USE(PAM:NOL_GD[29]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,131,36,13),USE(PAM:NOL_GD[28]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,117,36,13),USE(PAM:NOL_GD[27]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,102,36,13),USE(PAM:NOL_GD[26]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,89,36,13),USE(PAM:NOL_GD[25]),HIDE,RIGHT(1)
                           ENTRY(@s3),AT(408,61,21,13),USE(PAM:KAT[23]),HIDE,CENTER
                           ENTRY(@n2),AT(430,61,14,13),USE(PAM:GD_PR[23]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(446,61,23,13),USE(PAM:GD_KOEF[23]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(468,63,46,10),USE(PAM:SAK_V_GD[23])
                           STRING(@n4),AT(386,33,21,10),USE(GA[21],,?GA21),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(468,37,46,10),USE(PAM:SAK_V_GD[21])
                           STRING(@n4),AT(189,77,21,10),USE(GA[4],,?GA4),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,78,47,10),USE(PAM:SAK_V_GD[4])
                           ENTRY(@p#-##p),AT(211,72,21,13),USE(PAM:KAT[4]),HIDE,CENTER
                           ENTRY(@n2),AT(233,72,14,13),USE(PAM:GD_PR[4]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,72,23,13),USE(PAM:GD_KOEF[4]),HIDE,RIGHT(1)
                           ENTRY(@n13.2),AT(318,75,41,13),USE(PAM:NOL_GD[4]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,75,13,13),USE(?Lock4),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,73,14,14),USE(?Image4),HIDE,CENTERED
                           STRING(@n11.2B),AT(468,78,46,10),USE(PAM:SAK_V_GD[24])
                           STRING(@n11.2B),AT(468,302,46,10),USE(PAM:SAK_V_GD[40])
                           STRING(@n11.2B),AT(468,287,46,10),USE(PAM:SAK_V_GD[39])
                           STRING(@n11.2B),AT(468,273,46,10),USE(PAM:SAK_V_GD[38])
                           STRING(@n11.2B),AT(468,175,46,10),USE(PAM:SAK_V_GD[31])
                           STRING(@n11.2B),AT(468,261,46,10),USE(PAM:SAK_V_GD[37])
                           STRING(@n11.2B),AT(468,246,46,10),USE(PAM:SAK_V_GD[36])
                           STRING(@n11.2B),AT(468,231,46,10),USE(PAM:SAK_V_GD[35])
                           STRING(@n11.2B),AT(468,217,46,10),USE(PAM:SAK_V_GD[34])
                           STRING(@n11.2B),AT(468,205,46,10),USE(PAM:SAK_V_GD[33])
                           STRING(@n11.2B),AT(468,190,46,10),USE(PAM:SAK_V_GD[32])
                           STRING(@n11.2B),AT(468,161,46,10),USE(PAM:SAK_V_GD[30])
                           STRING(@n11.2B),AT(468,149,46,10),USE(PAM:SAK_V_GD[29])
                           STRING(@n11.2B),AT(468,134,46,10),USE(PAM:SAK_V_GD[28])
                           STRING(@n11.2B),AT(468,119,46,10),USE(PAM:SAK_V_GD[27])
                           STRING(@n11.2B),AT(468,105,46,10),USE(PAM:SAK_V_GD[26])
                           STRING(@n11.2B),AT(468,93,46,10),USE(PAM:SAK_V_GD[25])
                           STRING(@n4),AT(189,89,21,10),USE(GA[5],,?GA5),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,91,47,10),USE(PAM:SAK_V_GD[5])
                           ENTRY(@p#-##p),AT(211,86,21,13),USE(PAM:KAT[5]),HIDE,CENTER
                           ENTRY(@n2),AT(233,86,14,13),USE(PAM:GD_PR[5]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,86,23,13),USE(PAM:GD_KOEF[5]),HIDE,RIGHT(1)
                           ENTRY(@n13.2),AT(318,89,41,13),USE(PAM:NOL_GD[5]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,89,13,13),USE(?Lock5),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,88,14,14),USE(?Image5),HIDE,CENTERED
                           STRING(@n4),AT(189,104,21,10),USE(GA[6],,?GA6),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,101,21,13),USE(PAM:KAT[6]),HIDE,CENTER
                           ENTRY(@n2),AT(233,101,14,13),USE(PAM:GD_PR[6]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,101,23,14),USE(PAM:GD_KOEF[6]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,104,47,10),USE(PAM:SAK_V_GD[6])
                           ENTRY(@n13.2),AT(318,102,41,13),USE(PAM:NOL_GD[6]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,102,13,14),USE(?Lock6),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,102,14,14),USE(?Image6),HIDE,CENTERED
                           STRING(@n4),AT(189,118,21,10),USE(GA[7],,?GA7),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,119,47,10),USE(PAM:SAK_V_GD[7])
                           ENTRY(@p#-##p),AT(211,113,21,13),USE(PAM:KAT[7]),HIDE,CENTER
                           ENTRY(@n2),AT(233,113,14,13),USE(PAM:GD_PR[7]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,113,23,13),USE(PAM:GD_KOEF[7]),HIDE,RIGHT(1)
                           ENTRY(@n13.2),AT(318,117,41,13),USE(PAM:NOL_GD[7]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,118,13,13),USE(?Lock7),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,117,14,14),USE(?Image7),HIDE,CENTERED
                           STRING(@n4),AT(189,133,21,10),USE(GA[8],,?GA8),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,128,21,13),USE(PAM:KAT[8]),HIDE,CENTER
                           ENTRY(@n2),AT(233,129,14,13),USE(PAM:GD_PR[8]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,129,23,13),USE(PAM:GD_KOEF[8]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,134,47,10),USE(PAM:SAK_V_GD[8])
                           ENTRY(@n13.2),AT(318,131,41,13),USE(PAM:NOL_GD[8]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,133,13,13),USE(?Lock8),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,129,14,14),USE(?Image8),HIDE,CENTERED
                           STRING(@n4),AT(189,145,21,10),USE(GA[9],,?GA9),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,147,47,10),USE(PAM:SAK_V_GD[9])
                           ENTRY(@p#-##p),AT(211,142,21,13),USE(PAM:KAT[9]),HIDE,CENTER
                           ENTRY(@n2),AT(233,142,14,13),USE(PAM:GD_PR[9]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,142,23,13),USE(PAM:GD_KOEF[9]),HIDE,RIGHT(1)
                           ENTRY(@n13.2),AT(318,145,41,13),USE(PAM:NOL_GD[9]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,145,13,13),USE(?Lock9),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,144,14,14),USE(?Image9),HIDE,CENTERED
                           STRING(@n4),AT(189,160,21,10),USE(GA[10],,?GA10),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,160,47,10),USE(PAM:SAK_V_GD[10])
                           ENTRY(@p#-##p),AT(211,157,21,13),USE(PAM:KAT[10]),HIDE,CENTER
                           ENTRY(@n2),AT(233,157,14,13),USE(PAM:GD_PR[10]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,157,23,14),USE(PAM:GD_KOEF[10]),HIDE,RIGHT(1)
                           ENTRY(@n13.2),AT(318,158,41,13),USE(PAM:NOL_GD[10]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,158,13,14),USE(?Lock10),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,158,14,14),USE(?Image10),HIDE,CENTERED
                           STRING(@n4),AT(386,77,21,10),USE(GA[24],,?GA24),HIDE,RIGHT(1)
                           STRING(@n4),AT(386,62,21,10),USE(GA[23],,?GA23),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(515,61,36,13),USE(PAM:NOL_GD[23]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(551,61,13,13),USE(?Lock23),HIDE
                           IMAGE('CHECK3.ICO'),AT(565,61,14,14),USE(?Image23),HIDE,CENTERED
                           STRING(@n4),AT(189,174,21,10),USE(GA[11],,?GA11),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,169,21,13),USE(PAM:KAT[11]),HIDE,CENTER
                           ENTRY(@n2),AT(233,173,14,13),USE(PAM:GD_PR[11]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,173,23,13),USE(PAM:GD_KOEF[11]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,175,47,10),USE(PAM:SAK_V_GD[11])
                           ENTRY(@n13.2),AT(318,173,41,13),USE(PAM:NOL_GD[11]),HIDE,RIGHT(1)
                           STRING(@n4),AT(386,89,21,10),USE(GA[25],,?GA25),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,173,13,13),USE(?Lock11),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,173,14,14),USE(?Image11),HIDE,CENTERED
                           STRING(@n4),AT(189,189,21,10),USE(GA[12],,?GA12),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,184,21,13),USE(PAM:KAT[12]),HIDE,CENTER
                           ENTRY(@n2),AT(233,185,14,13),USE(PAM:GD_PR[12]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,185,23,13),USE(PAM:GD_KOEF[12]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,190,47,10),USE(PAM:SAK_V_GD[12])
                           ENTRY(@n13.2),AT(318,187,41,13),USE(PAM:NOL_GD[12]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,187,13,13),USE(?Lock12),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,185,14,14),USE(?Image12),HIDE,CENTERED
                           STRING(@n4),AT(189,201,21,10),USE(GA[13],,?GA13),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,198,21,13),USE(PAM:KAT[13]),HIDE,CENTER
                           ENTRY(@n2),AT(233,200,14,13),USE(PAM:GD_PR[13]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,200,23,13),USE(PAM:GD_KOEF[13]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,203,47,10),USE(PAM:SAK_V_GD[13])
                           STRING(@n4),AT(386,118,21,10),USE(GA[27],,?GA27),HIDE,RIGHT(1)
                           STRING(@n4),AT(386,104,21,10),USE(GA[26],,?GA26),HIDE,RIGHT(1)
                           ENTRY(@n13.2),AT(318,201,41,13),USE(PAM:NOL_GD[13]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,201,13,13),USE(?Lock13),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,200,14,14),USE(?Image13),HIDE,CENTERED
                           STRING(@n4),AT(189,216,21,10),USE(GA[14],,?GA14),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,213,21,13),USE(PAM:KAT[14]),HIDE,CENTER
                           ENTRY(@n2),AT(233,214,14,13),USE(PAM:GD_PR[14]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,214,23,14),USE(PAM:GD_KOEF[14]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,216,47,10),USE(PAM:SAK_V_GD[14])
                           ENTRY(@n13.2),AT(318,214,41,13),USE(PAM:NOL_GD[14]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,214,13,14),USE(?Lock14),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,214,14,14),USE(?Image14),HIDE,CENTERED
                           STRING(@n4),AT(189,230,21,10),USE(GA[15],,?GA15),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,229,21,13),USE(PAM:KAT[15]),HIDE,CENTER
                           ENTRY(@n2),AT(233,229,14,13),USE(PAM:GD_PR[15]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,229,23,13),USE(PAM:GD_KOEF[15]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,231,47,10),USE(PAM:SAK_V_GD[15])
                           ENTRY(@n13.2),AT(318,229,41,13),USE(PAM:NOL_GD[15]),HIDE,RIGHT(1)
                           STRING(@n4),AT(386,133,21,10),USE(GA[28],,?GA28),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,229,13,13),USE(?Lock15),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,229,14,14),USE(?Image15),HIDE,CENTERED
                           STRING(@n4),AT(189,245,21,10),USE(GA[16],,?GA16),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,243,21,13),USE(PAM:KAT[16]),HIDE,CENTER
                           STRING(@n4),AT(386,257,21,10),USE(GA[37],,?GA37),HIDE,RIGHT(1)
                           STRING(@n4),AT(386,145,21,10),USE(GA[29],,?GA29),HIDE,RIGHT(1)
                           ENTRY(@n2),AT(233,241,14,13),USE(PAM:GD_PR[16]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,241,23,13),USE(PAM:GD_KOEF[16]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,246,47,10),USE(PAM:SAK_V_GD[16])
                           ENTRY(@n-15.2),AT(318,243,41,13),USE(PAM:NOL_GD[16]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,243,13,13),USE(?Lock16),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,241,14,14),USE(?Image16),HIDE,CENTERED
                           STRING(@n4),AT(189,257,21,10),USE(GA[17],,?GA17),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,257,21,13),USE(PAM:KAT[17]),HIDE,CENTER
                           ENTRY(@n2),AT(233,257,14,13),USE(PAM:GD_PR[17]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,257,23,13),USE(PAM:GD_KOEF[17]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,259,47,10),USE(PAM:SAK_V_GD[17])
                           ENTRY(@n-15.2),AT(318,257,41,13),USE(PAM:NOL_GD[17]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,257,13,13),USE(?Lock17),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,256,14,14),USE(?Image17),HIDE,CENTERED
                           STRING(@n4),AT(386,160,21,10),USE(GA[30],,?GA30),HIDE,RIGHT(1)
                           STRING(@n4),AT(386,230,21,10),USE(GA[35],,?GA35),HIDE,RIGHT(1)
                           STRING(@n4),AT(189,272,21,10),USE(GA[18],,?GA18),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,270,21,13),USE(PAM:KAT[18]),HIDE,CENTER
                           ENTRY(@n2),AT(233,270,14,13),USE(PAM:GD_PR[18]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,270,23,14),USE(PAM:GD_KOEF[18]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,272,47,10),USE(PAM:SAK_V_GD[18])
                           ENTRY(@n-15.2),AT(318,270,41,13),USE(PAM:NOL_GD[18]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,270,13,14),USE(?Lock18),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,270,14,14),USE(?Image18),HIDE,CENTERED
                           STRING(@n4),AT(386,286,21,10),USE(GA[39],,?GA39),HIDE,RIGHT(1)
                           STRING(@n4),AT(386,174,21,10),USE(GA[31],,?GA31),HIDE,RIGHT(1)
                           STRING(@n4),AT(189,286,21,10),USE(GA[19],,?GA19),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,285,21,13),USE(PAM:KAT[19]),HIDE,CENTER
                           ENTRY(@n2),AT(233,285,14,13),USE(PAM:GD_PR[19]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,285,23,13),USE(PAM:GD_KOEF[19]),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,287,47,10),USE(PAM:SAK_V_GD[19])
                           ENTRY(@n-15.2),AT(318,285,41,13),USE(PAM:NOL_GD[19]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,285,13,13),USE(?Lock19),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,285,14,14),USE(?Image19),HIDE,CENTERED
                           STRING(@n4),AT(386,189,21,10),USE(GA[32],,?GA32),HIDE,RIGHT(1)
                           ENTRY(@p#-##p),AT(211,299,21,13),USE(PAM:KAT[20]),HIDE,CENTER
                           STRING(@n4),AT(386,201,21,10),USE(GA[33],,?GA33),HIDE,RIGHT(1)
                           ENTRY(@n2),AT(233,299,14,13),USE(PAM:GD_PR[20]),HIDE,RIGHT(1)
                           ENTRY(@n-6.3),AT(248,299,23,13),USE(PAM:GD_KOEF[20]),HIDE,RIGHT(1)
                           ENTRY(@n-15.2),AT(318,299,41,13),USE(PAM:NOL_GD[20]),HIDE,RIGHT(1)
                           BUTTON('Lk'),AT(360,299,13,13),USE(?Lock20),HIDE
                           IMAGE('CHECK3.ICO'),AT(374,297,14,14),USE(?Image20),HIDE,CENTERED
                           STRING(@n4),AT(386,301,21,10),USE(GA[40],,?GA40),HIDE,RIGHT(1)
                           STRING(@n4),AT(386,272,21,10),USE(GA[38],,?GA38),HIDE,RIGHT(1)
                           STRING(@n4),AT(386,216,21,10),USE(GA[34],,?GA34),HIDE,RIGHT(1)
                           STRING(@n4),AT(386,245,21,10),USE(GA[36],,?GA36),HIDE,RIGHT(1)
                           STRING(@n4),AT(189,301,21,10),USE(GA[20],,?GA20),HIDE,RIGHT(1)
                           STRING(@n11.2B),AT(272,302,46,10),USE(PAM:SAK_V_GD[20])
                         END
                       END
                       BUTTON('Pârrçíinât nolietojumu'),AT(163,329,117,14),USE(?SarekNoliet)
                       BUTTON('Nodzçst nolietojumu'),AT(281,329,77,14),USE(?DzestNol)
                       BUTTON('&OK'),AT(361,329,45,14),USE(?OK)
                       BUTTON('&Atlikt'),AT(408,329,45,14),USE(?Cancel)
                       STRING(@s8),AT(3,336),USE(PAM:ACC_KODS),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       STRING(@D06.B),AT(42,336),USE(PAM:ACC_DATUMS),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                     END
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
PercentProgress      BYTE
Progress:Thermometer BYTE
PAM_EXPL_DATUMS      LIKE(PAM:EXPL_DATUMS)

ProgressWindow WINDOW('Progress...'),AT(,,142,45),CENTER,TIMER(1),GRAY,DOUBLE
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
   FORCEDNODALACHANGE=FALSE
   CHANGEPOINT=0
   F:NODALA=0
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  I#=GetKat_k(PAM:KAT[1],0,2,'')
  DO PREPAREWINDOW
  PAM_ATB_NOS=CLIP(PAM:ATB_NR)&' '&PAM:ATB_NOS
  PROTEXT=GETPROJEKTI(PAM:OBJ_NR,1)
  PAM_VIETA=GETPAM_ADRESE(PAM:U_NR) !IR DEFINÇTA VIETA
  IF ~PAM_VIETA THEN PAM_VIETA=SYS:ADRESE.
  KON_NOSAUKUMS=GETKON_K(PAM:BKK,0,2)
  IF BAND(PAM:BAITS,00000001B)
     UNHIDE(?IMAGENVI)
  .
  IF LOCALREQUEST=2
     SELECT(?Browse:2)
  .
  ActionMessage='Aplûkoðanas reþîms'   !ja ir localrequest, sistçma pati pârrakstîs pâri
  IF GG::U_NR  !TIEK SAUKTS NO BASEs
    DISABLE(?DzestNol)
    DISABLE(?SarekNoliet)
    DISABLE(?TAB:1)
    DISABLE(?TAB:2)
  .
!  STOP(PAMAM::Used)
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
    ActionMessage = 'Ieraksts tiks dzçsts'
  END
  QuickWindow{Prop:Text} = ActionMessage
  CASE LocalRequest
  OF ChangeRecord OROF DeleteRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (' & CLIP(PAM:NOS_P) & ')'
  OF InsertRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (New)'
  END
  ENABLE(TBarBrwHistory)
  ACCEPT
    IF RECORDS(Queue:Browse:2) AND LOCALREQUEST=1
       DISABLE(?CANCEL)
       DISABLE(?PAM:DATUMS)
       DISABLE(?PAM:EXPL_DATUMS)
    ELSIF RECORDS(Queue:Browse:2)=0 AND LOCALREQUEST=1
       ENABLE(?CANCEL)
       ENABLE(?PAM:DATUMS)
       ENABLE(?PAM:EXPL_DATUMS)
    .
    IF RECORDS(Queue:Browse:2)
       DISABLE(?ButtonU_Nr)
    ELSE
       ENABLE(?ButtonU_Nr)
    .
    PAM:BIL_V=PAM:IEP_V+PAM:KAP_V-PAM:NOL_V
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
      DO BRW2::AssignButtons
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Buttonu_Nr)
      IF LOCALREQUEST=2
         SELECT(?Browse:2)
      ELSIF LOCALREQUEST=1
         SELECT(?PAM:IZG_GAD)
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
        History::PAM:Record = PAM:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(PAMAT)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(PAM:DAT_KEY)
              IF StandardWarning(Warn:DuplicateKey,'PAM:DAT_KEY')
                SELECT(?Buttonu_Nr)
                VCRRequest = VCRNone
                CYCLE
              END
            END
            IF DUPLICATE(PAM:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'PAM:NR_KEY')
                SELECT(?Buttonu_Nr)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?Buttonu_Nr)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::PAM:Record <> PAM:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:PAMAT(1)
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
              SELECT(?Buttonu_Nr)
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
            IF RIDelete:PAMAT()
              SETCURSOR()
              CASE StandardWarning(Warn:DeleteError)
              OF Button:Yes
                CYCLE
              OF Button:No
                POST(Event:CloseWindow)
                BREAK
              OF Button:Cancel
                DISPLAY
                SELECT(?Buttonu_Nr)
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
    OF ?Buttonu_Nr
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        ENABLE(?PAM:U_NR)
        SELECT(?PAM:U_NR)
      END
    OF ?PAM:U_NR
      CASE EVENT()
      OF EVENT:Accepted
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
           IF ~RECORDS(Queue:Browse:2)
        !      SELECT()-NEDRÎKST
              PAM:U_NR=CONTENTS(?PAM:U_NR)
              IF RIUPDATE:PAMAT()
                 KLUDA(24,'PAMAT')
              .
           .
        .
      END
    OF ?Atbildigais
      CASE EVENT()
      OF EVENT:Accepted
        PAR_NR=PAM:ATB_NR
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PAM:ATB_NOS=PAR:NOS_S
           PAM:ATB_NR=PAR:U_NR
           PAM_ATB_NOS=CLIP(PAM:ATB_NR)&' '&PAM:ATB_NOS
        .
        DISPLAY(?PAM_ATB_NOS)
      END
    OF ?PAM:DATUMS
      CASE EVENT()
      OF EVENT:Accepted
!Elya        IF ~INRANGE(YEAR(PAM:DATUMS),1900,2012)
!           BEEP
!           SELECT(?PAM:DATUMS)
!        .
        DO PREPAREWINDOW
      END
    OF ?Button22
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        PAM:EXPL_DATUMS=PAM:DATUMS
        display(?PAM:EXPL_DATUMS)
      END
    OF ?PAM:EXPL_DATUMS
      CASE EVENT()
      OF EVENT:Accepted
        PAM:EXPL_DATUMS=GETFING(6,PAM:EXPL_DATUMS) !3-AR FING BEIGU KONTROLI
        IF PAM:EXPL_DATUMS < DATE(12,1,1994)
           KLUDA(0,'Nolietojumu rçíinâsim no 01.01.2005')
        .
        DO PREPAREWINDOW
        DISPLAY
      END
    OF ?PAM:NOS_P
      CASE EVENT()
      OF EVENT:Accepted
        IF ~PAM:NOS_S
           PAM:NOS_S=PAM:NOS_P[1:15]
        .
        PAM:NOS_A=INIGEN(PAM:NOS_S,5,1)
        DISPLAY
      END
    OF ?PAM:NOS_S
      CASE EVENT()
      OF EVENT:Accepted
        PAM:NOS_A=INIGEN(PAM:NOS_S,5,1)
        DISPLAY
      END
    OF ?UzskKonts
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseKON_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PAM:BKK=KON:BKK
           DISPLAY(?PAM:BKK)
           IF ~PAM:BKKN
              PAM:BKKN=PAM:BKK
              PAM:BKKN[4]='9'
           .
           KON_NOSAUKUMS=GETKON_K(PAM:BKK,0,2)
           DISPLAY
        .
      END
    OF ?PAM:BKK
      CASE EVENT()
      OF EVENT:Accepted
        IF ~PAM:BKKN
           PAM:BKKN=PAM:BKK
           PAM:BKKN[4]='9'
        .
        KON_NOSAUKUMS=GETKON_K(PAM:BKK,0,2)
        DISPLAY
      END
    OF ?UzskKonts:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseKON_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PAM:BKKN=KON:BKK
           DISPLAY(?PAM:BKKN)
        .
      END
    OF ?UzskKonts7
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseKON_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PAM:okk7=KON:BKK
           DISPLAY(?PAM:okk7)
        .
      END
    OF ?BUTTONkategorija
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseKAT_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        PAM:KAT[1]  =KAT:KAT     !(DIM 15)
        IF SUB(PAM:KAT[1],1,1)='1'
           PAM:LIN_G_PR=ROUND(100/KAT:GADI,.001)
        ELSE
           PAM:LIN_G_PR=KAT:GADI
        .
        PAM:GD_PR[1]=KAT:LIKME   !(DIM 15)
        !IF SUB(PAM:KAT[1],1,1)='1'     !1.KATEGORIJA
        !   gadi_procenti='%'
        !ELSE
        !   gadi_procenti='gadi'
        !.
        DO PREPAREWINDOW
        display
      END
    OF ?Button38
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAM_P 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PAM_VIETA=PAP:VIETA !IR DEFINÇTA VIETA
           DISPLAY
        .
      END
    OF ?BN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNodalas 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PAM:NODALA=NOD:U_NR
        !!   NODTEXT=NOD:NOS_P
           FORCEDNODALACHANGE=TRUE
           DO BRW2::InitializeBrowse   ! Lai nomaina PAMAM, ja mainâs nodaïa
           DO BRW2::RefreshPage
        END
      END
    OF ?PAM:LIN_G_PR
      CASE EVENT()
      OF EVENT:Accepted
        DO PREPAREWINDOW
        DISPLAY
      END
    OF ?BUTTONNVI
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(PAM:BAITS,00000001B)
           PAM:BAITS-=1
           HIDE(?IMAGENVI)
        ELSE
           PAM:BAITS+=1
           UNHIDE(?IMAGENVI)
        .
        DISPLAY
      END
    OF ?ButtonRaz
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:NERAZ=0    !IZMANTO
           PAM:NERAZ=1
           ?ButtonRaz{PROP:TEXT}='Neizmanto Raþ.'
        ELSE
           PAM:NERAZ=0
           ?ButtonRaz{PROP:TEXT}='Izmanto raþoðanâ'
        .
      END
    OF ?Button:projekts
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseProjekti 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PAM:obj_nr=PRO:U_NR
           PROTEXT=PRO:NOS_P
           DISPLAY
        !!   FORCEDNODALACHANGE=TRUE
        !!   DO BRW2::InitializeBrowse   ! Lai nomaina PAMAM, ja mainâs nodaïa
        !!   DO BRW2::RefreshPage
        END
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
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           SAV_DATUMS=AMO:YYYYMM
           calcamort(0)
           SAV_DATUMS=0
           DO BRW2::InitializeBrowse
           DO BRW2::RefreshPage
        .
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW2::ButtonDelete
      END
    OF ?Lock1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[1]
           PAM:LOCK_GD[1]=0
           HIDE(?Image1)
           ENABLE(?PAM:NOL_GD_1)
        ELSE
           PAM:LOCK_GD[1]=1
           UNHIDE(?Image1)
           DISABLE(?PAM:NOL_GD_1)
        .
      END
    OF ?PAM:KAT_2
      CASE EVENT()
      OF EVENT:Accepted
        DO BRW2::InitializeBrowse
        DO BRW2::RefreshPage
      END
    OF ?Lock2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[2]
           PAM:LOCK_GD[2]=0
           HIDE(?Image2)
           ENABLE(?PAM:NOL_GD_2)
        ELSE
           PAM:LOCK_GD[2]=1
           UNHIDE(?Image2)
           DISABLE(?PAM:NOL_GD_2)
        .
      END
    OF ?Lock21
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[21]
                   PAM:LOCK_GD[21]=0
                   HIDE(?Image21)
                   ENABLE(?PAM:NOL_GD_21)
                ELSE
                   PAM:LOCK_GD[21]=1
                   UNHIDE(?Image21)
                   DISABLE(?PAM:NOL_GD_21)
                .
      END
    OF ?Lock3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[3]
           PAM:LOCK_GD[3]=0
           HIDE(?Image3)
           ENABLE(?PAM:NOL_GD_3)
        ELSE
           PAM:LOCK_GD[3]=1
           UNHIDE(?Image3)
           DISABLE(?PAM:NOL_GD_3)
        .
      END
    OF ?Lock22
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[22]
                   PAM:LOCK_GD[22]=0
                   HIDE(?Image22)
                   ENABLE(?PAM:NOL_GD_22)
                ELSE
                   PAM:LOCK_GD[22]=1
                   UNHIDE(?Image22)
                   DISABLE(?PAM:NOL_GD_22)
                .
      END
    OF ?Lock40
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[40]
                   PAM:LOCK_GD[40]=0
                   HIDE(?Image40)
                   ENABLE(?PAM:NOL_GD_40)
                ELSE
                   PAM:LOCK_GD[40]=1
                   UNHIDE(?Image40)
                   DISABLE(?PAM:NOL_GD_40)
                .
      END
    OF ?Lock39
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[39]
                   PAM:LOCK_GD[39]=0
                   HIDE(?Image39)
                   ENABLE(?PAM:NOL_GD_39)
                ELSE
                   PAM:LOCK_GD[39]=1
                   UNHIDE(?Image39)
                   DISABLE(?PAM:NOL_GD_39)
                .
      END
    OF ?Lock38
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[38]
                   PAM:LOCK_GD[38]=0
                   HIDE(?Image38)
                   ENABLE(?PAM:NOL_GD_38)
                ELSE
                   PAM:LOCK_GD[38]=1
                   UNHIDE(?Image38)
                   DISABLE(?PAM:NOL_GD_38)
                .
      END
    OF ?Lock37
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[37]
                   PAM:LOCK_GD[37]=0
                   HIDE(?Image37)
                   ENABLE(?PAM:NOL_GD_37)
                ELSE
                   PAM:LOCK_GD[37]=1
                   UNHIDE(?Image37)
                   DISABLE(?PAM:NOL_GD_37)
                .
      END
    OF ?Lock36
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[36]
                   PAM:LOCK_GD[36]=0
                   HIDE(?Image36)
                   ENABLE(?PAM:NOL_GD_36)
                ELSE
                   PAM:LOCK_GD[36]=1
                   UNHIDE(?Image36)
                   DISABLE(?PAM:NOL_GD_36)
                .
      END
    OF ?Lock35
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[35]
                   PAM:LOCK_GD[35]=0
                   HIDE(?Image35)
                   ENABLE(?PAM:NOL_GD_35)
                ELSE
                   PAM:LOCK_GD[35]=1
                   UNHIDE(?Image35)
                   DISABLE(?PAM:NOL_GD_35)
                .
      END
    OF ?Lock34
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[34]
                   PAM:LOCK_GD[34]=0
                   HIDE(?Image34)
                   ENABLE(?PAM:NOL_GD_34)
                ELSE
                   PAM:LOCK_GD[34]=1
                   UNHIDE(?Image34)
                   DISABLE(?PAM:NOL_GD_34)
                .
      END
    OF ?Lock33
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[33]
                   PAM:LOCK_GD[33]=0
                   HIDE(?Image33)
                   ENABLE(?PAM:NOL_GD_33)
                ELSE
                   PAM:LOCK_GD[33]=1
                   UNHIDE(?Image33)
                   DISABLE(?PAM:NOL_GD_33)
                .
      END
    OF ?Lock32
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[32]
                   PAM:LOCK_GD[32]=0
                   HIDE(?Image32)
                   ENABLE(?PAM:NOL_GD_32)
                ELSE
                   PAM:LOCK_GD[32]=1
                   UNHIDE(?Image32)
                   DISABLE(?PAM:NOL_GD_32)
                .
      END
    OF ?Lock31
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[31]
                   PAM:LOCK_GD[31]=0
                   HIDE(?Image31)
                   ENABLE(?PAM:NOL_GD_31)
                ELSE
                   PAM:LOCK_GD[31]=1
                   UNHIDE(?Image31)
                   DISABLE(?PAM:NOL_GD_31)
                .
      END
    OF ?Lock30
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[30]
                   PAM:LOCK_GD[30]=0
                   HIDE(?Image30)
                   ENABLE(?PAM:NOL_GD_30)
                ELSE
                   PAM:LOCK_GD[30]=1
                   UNHIDE(?Image30)
                   DISABLE(?PAM:NOL_GD_30)
                .
      END
    OF ?Lock29
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[29]
                   PAM:LOCK_GD[29]=0
                   HIDE(?Image29)
                   ENABLE(?PAM:NOL_GD_29)
                ELSE
                   PAM:LOCK_GD[29]=1
                   UNHIDE(?Image29)
                   DISABLE(?PAM:NOL_GD_29)
                .
      END
    OF ?Lock28
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[28]
                   PAM:LOCK_GD[28]=0
                   HIDE(?Image28)
                   ENABLE(?PAM:NOL_GD_28)
                ELSE
                   PAM:LOCK_GD[28]=1
                   UNHIDE(?Image28)
                   DISABLE(?PAM:NOL_GD_28)
                .
      END
    OF ?Lock27
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[27]
                   PAM:LOCK_GD[27]=0
                   HIDE(?Image27)
                   ENABLE(?PAM:NOL_GD_27)
                ELSE
                   PAM:LOCK_GD[27]=1
                   UNHIDE(?Image27)
                   DISABLE(?PAM:NOL_GD_27)
                .
      END
    OF ?Lock26
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[26]
                   PAM:LOCK_GD[26]=0
                   HIDE(?Image26)
                   ENABLE(?PAM:NOL_GD_26)
                ELSE
                   PAM:LOCK_GD[26]=1
                   UNHIDE(?Image26)
                   DISABLE(?PAM:NOL_GD_26)
                .
      END
    OF ?Lock25
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[25]
                   PAM:LOCK_GD[25]=0
                   HIDE(?Image25)
                   ENABLE(?PAM:NOL_GD_25)
                ELSE
                   PAM:LOCK_GD[25]=1
                   UNHIDE(?Image25)
                   DISABLE(?PAM:NOL_GD_25)
                .
      END
    OF ?Lock24
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[24]
                   PAM:LOCK_GD[24]=0
                   HIDE(?Image24)
                   ENABLE(?PAM:NOL_GD_24)
                ELSE
                   PAM:LOCK_GD[24]=1
                   UNHIDE(?Image24)
                   DISABLE(?PAM:NOL_GD_24)
                .
      END
    OF ?Lock4
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[4]
           PAM:LOCK_GD[4]=0
           HIDE(?Image4)
           ENABLE(?PAM:NOL_GD_4)
        ELSE
           PAM:LOCK_GD[4]=1
           UNHIDE(?Image4)
           DISABLE(?PAM:NOL_GD_4)
        .
      END
    OF ?Lock5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[5]
           PAM:LOCK_GD[5]=0
           HIDE(?Image5)
           ENABLE(?PAM:NOL_GD_5)
        ELSE
           PAM:LOCK_GD[5]=1
           UNHIDE(?Image5)
           DISABLE(?PAM:NOL_GD_5)
        .
      END
    OF ?Lock6
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[6]
           PAM:LOCK_GD[6]=0
           HIDE(?Image6)
           ENABLE(?PAM:NOL_GD_6)
        ELSE
           PAM:LOCK_GD[6]=1
           UNHIDE(?Image6)
           DISABLE(?PAM:NOL_GD_6)
        .
      END
    OF ?Lock7
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[7]
           PAM:LOCK_GD[7]=0
           HIDE(?Image7)
           ENABLE(?PAM:NOL_GD_7)
        ELSE
           PAM:LOCK_GD[7]=1
           UNHIDE(?Image7)
           DISABLE(?PAM:NOL_GD_7)
        .
      END
    OF ?Lock8
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[8]
           PAM:LOCK_GD[8]=0
           HIDE(?Image8)
           ENABLE(?PAM:NOL_GD_8)
        ELSE
           PAM:LOCK_GD[8]=1
           UNHIDE(?Image8)
           DISABLE(?PAM:NOL_GD_8)
        .
      END
    OF ?Lock9
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[9]
           PAM:LOCK_GD[9]=0
           HIDE(?Image9)
           ENABLE(?PAM:NOL_GD_9)
        ELSE
           PAM:LOCK_GD[9]=1
           UNHIDE(?Image9)
           DISABLE(?PAM:NOL_GD_9)
        .
      END
    OF ?Lock10
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[10]
           PAM:LOCK_GD[10]=0
           HIDE(?Image10)
           ENABLE(?PAM:NOL_GD_10)
        ELSE
           PAM:LOCK_GD[10]=1
           UNHIDE(?Image10)
           DISABLE(?PAM:NOL_GD_10)
        .
      END
    OF ?Lock23
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
                IF PAM:LOCK_GD[23]
                   PAM:LOCK_GD[23]=0
                   HIDE(?Image23)
                   ENABLE(?PAM:NOL_GD_23)
                ELSE
                   PAM:LOCK_GD[23]=1
                   UNHIDE(?Image23)
                   DISABLE(?PAM:NOL_GD_23)
                .
      END
    OF ?Lock11
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[11]
           PAM:LOCK_GD[11]=0
           HIDE(?Image11)
           ENABLE(?PAM:NOL_GD_11)
        ELSE
           PAM:LOCK_GD[11]=1
           UNHIDE(?Image11)
           DISABLE(?PAM:NOL_GD_11)
        .
      END
    OF ?Lock12
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[12]
           PAM:LOCK_GD[12]=0
           HIDE(?Image12)
           ENABLE(?PAM:NOL_GD_12)
        ELSE
           PAM:LOCK_GD[12]=1
           UNHIDE(?Image12)
           DISABLE(?PAM:NOL_GD_12)
        .
      END
    OF ?Lock13
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[13]
           PAM:LOCK_GD[13]=0
           HIDE(?Image13)
           ENABLE(?PAM:NOL_GD_13)
        ELSE
           PAM:LOCK_GD[13]=1
           UNHIDE(?Image13)
           DISABLE(?PAM:NOL_GD_13)
        .
      END
    OF ?Lock14
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[14]
           PAM:LOCK_GD[14]=0
           HIDE(?Image14)
           ENABLE(?PAM:NOL_GD_14)
        ELSE
           PAM:LOCK_GD[14]=1
           UNHIDE(?Image14)
           DISABLE(?PAM:NOL_GD_14)
        .
      END
    OF ?Lock15
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[15]
           PAM:LOCK_GD[15]=0
           HIDE(?Image15)
           ENABLE(?PAM:NOL_GD_15)
        ELSE
           PAM:LOCK_GD[15]=1
           UNHIDE(?Image15)
           DISABLE(?PAM:NOL_GD_15)
        .
      END
    OF ?Lock16
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[16]
           PAM:LOCK_GD[16]=0
           HIDE(?Image16)
           ENABLE(?PAM:NOL_GD_16)
        ELSE
           PAM:LOCK_GD[16]=1
           UNHIDE(?Image16)
           DISABLE(?PAM:NOL_GD_16)
        .
      END
    OF ?Lock17
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[17]
           PAM:LOCK_GD[17]=0
           HIDE(?Image17)
           ENABLE(?PAM:NOL_GD_17)
        ELSE
           PAM:LOCK_GD[17]=1
           UNHIDE(?Image17)
           DISABLE(?PAM:NOL_GD_17)
        .
      END
    OF ?Lock18
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[18]
           PAM:LOCK_GD[18]=0
           HIDE(?Image18)
           ENABLE(?PAM:NOL_GD_18)
        ELSE
           PAM:LOCK_GD[18]=1
           UNHIDE(?Image18)
           DISABLE(?PAM:NOL_GD_18)
        .
      END
    OF ?Lock19
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[19]
           PAM:LOCK_GD[19]=0
           HIDE(?Image19)
           ENABLE(?PAM:NOL_GD_19)
        ELSE
           PAM:LOCK_GD[19]=1
           UNHIDE(?Image19)
           DISABLE(?PAM:NOL_GD_19)
        .
      END
    OF ?Lock20
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAM:LOCK_GD[20]
           PAM:LOCK_GD[20]=0
           HIDE(?Image20)
           ENABLE(?PAM:NOL_GD_20)
        ELSE
           PAM:LOCK_GD[20]=1
           UNHIDE(?Image20)
           DISABLE(?PAM:NOL_GD_20)
        .
        
      END
    OF ?SarekNoliet
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPCIJA='0300'
        !       1234
        !MAXG#=2014 !MAX uz DIM20
        IZZFILTGMC() !gmc vairs nekontrolç maxg
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           calcamort(0)
           DO BRW2::InitializeBrowse
           DO BRW2::RefreshPage
           SELECT(?Tab:1)
           DISPLAY
        .
      END
    OF ?DzestNol
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        KLUDA(0,'Tiks dzçsti visi nolietojuma aprçíini ðim pamatlîdzeklim',9)
        IF ~KLU_DARBIBA  !otrâdi
        !   AMO_YYYYMM#=AMO:YYYYMM
           RecordsToProcess = (today()-PAM:EXPL_DATUMS)/30
           RecordsProcessed = 0
           PercentProgress = 0
           Progress:Thermometer = 0
           OPEN(ProgressWindow)
           ?Progress:PctText{Prop:Text} = '0%'
           ProgressWindow{Prop:Text} = 'Dzçðam nolietojumu'
           ?Progress:UserString{Prop:Text}=PAM:NOS_P
           DISPLAY
           CLEAR(PAM:NERAZ)
           CLEAR(PAM:NOL_GD)
           CLEAR(PAM:LOCK_GD)
           LOOP I#=2 TO 40
              PAM:GD_PR[I#]=0
              PAM:GD_KOEF[I#]=0
              PAM:SAK_V_GD[I#]=0
           .
           CLEAR(AMO:RECORD)
           AMO:U_NR=PAM:U_NR
           SET(PAMAM,AMO:NR_KEY)
           LOOP
              NEXT(PAMAM)
              IF ERROR() OR ~(PAM:U_NR=AMO:U_NR)
                 BREAK
              .
              DELETE(PAMAM)
              RecordsProcessed += 1
              IF PercentProgress < 100
                 PercentProgress = (RecordsProcessed / RecordsToProcess)*100
                 IF PercentProgress > 100
                   PercentProgress = 100
                 END
                 IF PercentProgress <> Progress:Thermometer THEN
                   Progress:Thermometer = PercentProgress
                   ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
                   DISPLAY
                 END
              END
           .
           CLOSE(ProgressWindow)
           DO BRW2::InitializeBrowse
           DO BRW2::RefreshPage
           DISPLAY
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
        IF ~PAM:BKK
           KLUDA(44,'P/L uzskaites konts')
        .
        IF ~PAM:BKKN
           KLUDA(44,'nolietojuma uzskaites konts')
        .
        PAM:ACC_KODS=ACC_KODS
        PAM:ACC_DATUMS=TODAY()
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
  IF KAT_K::Used = 0
    CheckOpen(KAT_K,1)
  END
  KAT_K::Used += 1
  BIND(KAT:RECORD)
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(AMO:RECORD)
  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  BIND(PAM:RECORD)
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  FilesOpened = True
  RISnap:PAMAT
  SAV::PAM:Record = PAM:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    PAM:IZG_GAD=year(today())
    PAM:SKAITS=1
    PAM:GD_KOEF[1]=2
    IF GG::U_NR  !TIEK SAUKTS NO BASE_S
       PAM:DATUMS=GG:DATUMS
       PAM:IZG_GAD=year(PAM:DATUMS)
       PAM:EXPL_DATUMS=PAM:DATUMS
       PAM:DOK_SENR=GG:DOK_SENR
       PAM:NOS_P=GG:SATURS[1:35]
       PAM:BKK=GGK:BKK
       PAM:BKKN=GGK:BKK
       PAM:BKKN[4]='9'
       PAM:IEP_V=GGK:SUMMA
       PAM:BIL_V=GGK:SUMMA
    ELSE
       PAM:DATUMS=TODAY()
    !   PAM:EXPL_DATUMS=PAM:DATUMS
       PAM:EXPL_DATUMS=GETFING(6,PAM:DATUMS) !3-AR FING BEIGU KONTROLI
    .
    IF ~COPYREQUEST
       PAM:OKK7='74200'
    .
    PAM:ACC_KODS=ACC_KODS
    PAM:ACC_DATUMS=TODAY()
    
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('UpdatePamat','winlats.INI')
  WinResize.Resize
  BRW2::AddQueue = True
  BRW2::RecordCount = 0
  BIND('BRW2::Sort1:Reset:PAM:U_NR',BRW2::Sort1:Reset:PAM:U_NR)
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?Browse:2{Prop:Alrt,255} = InsertKey
  ?Browse:2{Prop:Alrt,254} = DeleteKey
  ?Browse:2{Prop:Alrt,253} = CtrlEnter
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?PAM:U_NR{PROP:Alrt,255} = 734
  ?PAM_ATB_NOS{PROP:Alrt,255} = 734
  ?PAM:IZG_GAD{PROP:Alrt,255} = 734
  ?PAM:DATUMS{PROP:Alrt,255} = 734
  ?PAM:EXPL_DATUMS{PROP:Alrt,255} = 734
  ?PAM:DOK_SENR{PROP:Alrt,255} = 734
  ?PAM:NOS_P{PROP:Alrt,255} = 734
  ?PAM:NOS_S{PROP:Alrt,255} = 734
  ?PAM:NOS_A{PROP:Alrt,255} = 734
  ?PAM:BKK{PROP:Alrt,255} = 734
  ?PAM:BKKN{PROP:Alrt,255} = 734
  ?PAM:OKK7{PROP:Alrt,255} = 734
  ?PAM:IEP_V{PROP:Alrt,255} = 734
  ?PAM:KAP_V{PROP:Alrt,255} = 734
  ?PAM:NOL_V{PROP:Alrt,255} = 734
  ?PAM:BIL_V{PROP:Alrt,255} = 734
  ?PAM:OBJ_NR{PROP:Alrt,255} = 734
  ?PAM:SKAITS{PROP:Alrt,255} = 734
  ?PAM:NODALA{PROP:Alrt,255} = 734
  ?PAM:LIN_G_PR{PROP:Alrt,255} = 734
  ?PAM:END_DATE{PROP:Alrt,255} = 734
  ?PAM:ACC_KODS{PROP:Alrt,255} = 734
  ?PAM:ACC_DATUMS{PROP:Alrt,255} = 734
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
    KAT_K::Used -= 1
    IF KAT_K::Used = 0 THEN CLOSE(KAT_K).
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
  END
  IF WindowOpened
    INISaveWindow('UpdatePamat','winlats.INI')
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
PREPAREWINDOW    ROUTINE
!   stop(SUB(PAM:KAT_NR[1],1,1)&'='&pam:kat_nr[1]&'='&format(pam:kat_nr[1],@s3))
   IF SUB(PAM:KAT[1],1,1)='1'     !1.KATEGORIJA
      GADI_procenti='%'
      MENESI#=(100/PAM:LIN_G_PR)*12
   ELSE
      gadi_procenti='gadi'
      MENESI#=PAM:LIN_G_PR*12
   .
   LIN_END_DAT=DATE(MONTH(PAM:EXPL_DATUMS)+1+MENESI#,1,YEAR(PAM:EXPL_DATUMS))
   IF PAM:EXPL_DATUMS>=DATE(1,1,1995)
      START_GD#=YEAR(PAM:EXPL_DATUMS)
      PAM:KAP_V=0
      PAM:NOL_V=0
      DISABLE(?PAM:KAP_V)
      DISABLE(?PAM:NOL_V)
   ELSE
      START_GD#=1995
      ENABLE(?PAM:KAP_V)
      ENABLE(?PAM:NOL_V)
   .
   IF PAM:NERAZ=1
      ?ButtonRaz{PROP:TEXT}='Neizmanto Raþ.'
   .
   IF PAM:END_DATE
      END_GD#=YEAR(PAM:END_DATE)
   ELSE
      IF DB_GADS>YEAR(TODAY())
         KLUDA(0,'DB gads globâlajos datos = '&DB_GADS&' ???')
      .
      END_GD#=DB_GADS
   .
   I#=0
   CLEAR(GA)
   LOOP G#=START_GD# TO END_GD#
      I#+=1
      !Elya 30/04/2015 IF I#>20 !13.05.2010
      IF I#>40 !13.05.2010
         KLUDA(0,'Masîvu indeksu pârpilde')
         BREAK
      ELSE
         GA[I#]=G#
      .
   .
   !Elya 30/04/2015 LOOP I#=1 TO 20 !GA DIM(20) 13.05.2010
   LOOP I#=1 TO 40 !GA DIM(20) 13.05.2010
      IF GA[I#]
         EXECUTE I#
           UNHIDE(?GA1,?LOCK1)
           UNHIDE(?GA2,?LOCK2)
           BEGIN
              UNHIDE(?GA3)
              UNHIDE(?PAM:KAT_3)
              UNHIDE(?PAM:GD_PR_3)
              UNHIDE(?PAM:GD_KOEF_3)
              UNHIDE(?PAM:NOL_GD_3)
              UNHIDE(?LOCK3)
           END
           BEGIN
              UNHIDE(?GA4)
              UNHIDE(?PAM:KAT_4)
              UNHIDE(?PAM:GD_PR_4)
              UNHIDE(?PAM:GD_KOEF_4)
              UNHIDE(?PAM:NOL_GD_4)
              UNHIDE(?LOCK4)
           END
           BEGIN
              UNHIDE(?GA5)
              UNHIDE(?PAM:KAT_5)
              UNHIDE(?PAM:GD_PR_5)
              UNHIDE(?PAM:GD_KOEF_5)
              UNHIDE(?PAM:NOL_GD_5)
              UNHIDE(?LOCK5)
           END
           BEGIN
              UNHIDE(?GA6)
              UNHIDE(?PAM:KAT_6)
              UNHIDE(?PAM:GD_PR_6)
              UNHIDE(?PAM:GD_KOEF_6)
              UNHIDE(?PAM:NOL_GD_6)
              UNHIDE(?LOCK6)
           END
           BEGIN
              UNHIDE(?GA7)
              UNHIDE(?PAM:KAT_7)
              UNHIDE(?PAM:GD_PR_7)
              UNHIDE(?PAM:GD_KOEF_7)
              UNHIDE(?PAM:NOL_GD_7)
              UNHIDE(?LOCK7)
           END
           BEGIN
              UNHIDE(?GA8)
              UNHIDE(?PAM:KAT_8)
              UNHIDE(?PAM:GD_PR_8)
              UNHIDE(?PAM:GD_KOEF_8)
              UNHIDE(?PAM:NOL_GD_8)
              UNHIDE(?LOCK8)
           END
           BEGIN
              UNHIDE(?GA9)
              UNHIDE(?PAM:KAT_9)
              UNHIDE(?PAM:GD_PR_9)
              UNHIDE(?PAM:GD_KOEF_9)
              UNHIDE(?PAM:NOL_GD_9)
              UNHIDE(?LOCK9)
           END
           BEGIN
              UNHIDE(?GA10)
              UNHIDE(?PAM:KAT_10)
              UNHIDE(?PAM:GD_PR_10)
              UNHIDE(?PAM:GD_KOEF_10)
              UNHIDE(?PAM:NOL_GD_10)
              UNHIDE(?LOCK10)
           END
           BEGIN
              UNHIDE(?GA11)
              UNHIDE(?PAM:KAT_11)
              UNHIDE(?PAM:GD_PR_11)
              UNHIDE(?PAM:GD_KOEF_11)
              UNHIDE(?PAM:NOL_GD_11)
              UNHIDE(?LOCK11)
           END
           BEGIN
              UNHIDE(?GA12)
              UNHIDE(?PAM:KAT_12)
              UNHIDE(?PAM:GD_PR_12)
              UNHIDE(?PAM:GD_KOEF_12)
              UNHIDE(?PAM:NOL_GD_12)
              UNHIDE(?LOCK12)
           END
           BEGIN
              UNHIDE(?GA13)
              UNHIDE(?PAM:KAT_13)
              UNHIDE(?PAM:GD_PR_13)
              UNHIDE(?PAM:GD_KOEF_13)
              UNHIDE(?PAM:NOL_GD_13)
              UNHIDE(?LOCK13)
           END
           BEGIN
              UNHIDE(?GA14)
              UNHIDE(?PAM:KAT_14)
              UNHIDE(?PAM:GD_PR_14)
              UNHIDE(?PAM:GD_KOEF_14)
              UNHIDE(?PAM:NOL_GD_14)
              UNHIDE(?LOCK14)
           END
           BEGIN
              UNHIDE(?GA15)
              UNHIDE(?PAM:KAT_15)
              UNHIDE(?PAM:GD_PR_15)
              UNHIDE(?PAM:GD_KOEF_15)
              UNHIDE(?PAM:NOL_GD_15)
              UNHIDE(?LOCK15)
           END
           BEGIN
              UNHIDE(?GA16)
              UNHIDE(?PAM:KAT_16)
              UNHIDE(?PAM:GD_PR_16)
              UNHIDE(?PAM:GD_KOEF_16)
              UNHIDE(?PAM:NOL_GD_16)
              UNHIDE(?LOCK16)
           END
           BEGIN
              UNHIDE(?GA17)
              UNHIDE(?PAM:KAT_17)
              UNHIDE(?PAM:GD_PR_17)
              UNHIDE(?PAM:GD_KOEF_17)
              UNHIDE(?PAM:NOL_GD_17)
              UNHIDE(?LOCK17)
           END
           BEGIN
              UNHIDE(?GA18)
              UNHIDE(?PAM:KAT_18)
              UNHIDE(?PAM:GD_PR_18)
              UNHIDE(?PAM:GD_KOEF_18)
              UNHIDE(?PAM:NOL_GD_18)
              UNHIDE(?LOCK18)
           END
           BEGIN
              UNHIDE(?GA19)
              UNHIDE(?PAM:KAT_19)
              UNHIDE(?PAM:GD_PR_19)
              UNHIDE(?PAM:GD_KOEF_19)
              UNHIDE(?PAM:NOL_GD_19)
              UNHIDE(?LOCK19)
           END
           BEGIN
              UNHIDE(?GA20)
              UNHIDE(?PAM:KAT_20)
              UNHIDE(?PAM:GD_PR_20)
              UNHIDE(?PAM:GD_KOEF_20)
              UNHIDE(?PAM:NOL_GD_20)
              UNHIDE(?LOCK20)
           END
           BEGIN
              UNHIDE(?GA21)
              UNHIDE(?PAM:KAT_21)
              UNHIDE(?PAM:GD_PR_21)
              UNHIDE(?PAM:GD_KOEF_21)
              UNHIDE(?PAM:NOL_GD_21)
              UNHIDE(?LOCK21)
           END
           BEGIN
              UNHIDE(?GA22)
              UNHIDE(?PAM:KAT_22)
              UNHIDE(?PAM:GD_PR_22)
              UNHIDE(?PAM:GD_KOEF_22)
              UNHIDE(?PAM:NOL_GD_22)
              UNHIDE(?LOCK22)
           END
           BEGIN
              UNHIDE(?GA23)
              UNHIDE(?PAM:KAT_23)
              UNHIDE(?PAM:GD_PR_23)
              UNHIDE(?PAM:GD_KOEF_23)
              UNHIDE(?PAM:NOL_GD_23)
              UNHIDE(?LOCK23)
           END
           BEGIN
              UNHIDE(?GA24)
              UNHIDE(?PAM:KAT_24)
              UNHIDE(?PAM:GD_PR_24)
              UNHIDE(?PAM:GD_KOEF_24)
              UNHIDE(?PAM:NOL_GD_24)
              UNHIDE(?LOCK24)
           END
           BEGIN
              UNHIDE(?GA25)
              UNHIDE(?PAM:KAT_25)
              UNHIDE(?PAM:GD_PR_25)
              UNHIDE(?PAM:GD_KOEF_25)
              UNHIDE(?PAM:NOL_GD_25)
              UNHIDE(?LOCK25)
           END
           BEGIN
              UNHIDE(?GA26)
              UNHIDE(?PAM:KAT_26)
              UNHIDE(?PAM:GD_PR_26)
              UNHIDE(?PAM:GD_KOEF_26)
              UNHIDE(?PAM:NOL_GD_26)
              UNHIDE(?LOCK26)
           END
           BEGIN
              UNHIDE(?GA27)
              UNHIDE(?PAM:KAT_27)
              UNHIDE(?PAM:GD_PR_27)
              UNHIDE(?PAM:GD_KOEF_27)
              UNHIDE(?PAM:NOL_GD_27)
              UNHIDE(?LOCK27)
           END
           BEGIN
              UNHIDE(?GA28)
              UNHIDE(?PAM:KAT_28)
              UNHIDE(?PAM:GD_PR_28)
              UNHIDE(?PAM:GD_KOEF_28)
              UNHIDE(?PAM:NOL_GD_28)
              UNHIDE(?LOCK28)
           END
           BEGIN
              UNHIDE(?GA29)
              UNHIDE(?PAM:KAT_29)
              UNHIDE(?PAM:GD_PR_29)
              UNHIDE(?PAM:GD_KOEF_29)
              UNHIDE(?PAM:NOL_GD_29)
              UNHIDE(?LOCK29)
           END
           BEGIN
              UNHIDE(?GA30)
              UNHIDE(?PAM:KAT_30)
              UNHIDE(?PAM:GD_PR_30)
              UNHIDE(?PAM:GD_KOEF_30)
              UNHIDE(?PAM:NOL_GD_30)
              UNHIDE(?LOCK30)
           END
           BEGIN
              UNHIDE(?GA31)
              UNHIDE(?PAM:KAT_31)
              UNHIDE(?PAM:GD_PR_31)
              UNHIDE(?PAM:GD_KOEF_31)
              UNHIDE(?PAM:NOL_GD_31)
              UNHIDE(?LOCK31)
           END
           BEGIN
              UNHIDE(?GA32)
              UNHIDE(?PAM:KAT_32)
              UNHIDE(?PAM:GD_PR_32)
              UNHIDE(?PAM:GD_KOEF_32)
              UNHIDE(?PAM:NOL_GD_32)
              UNHIDE(?LOCK32)
           END
           BEGIN
              UNHIDE(?GA33)
              UNHIDE(?PAM:KAT_33)
              UNHIDE(?PAM:GD_PR_33)
              UNHIDE(?PAM:GD_KOEF_33)
              UNHIDE(?PAM:NOL_GD_33)
              UNHIDE(?LOCK33)
           END
           BEGIN
              UNHIDE(?GA34)
              UNHIDE(?PAM:KAT_34)
              UNHIDE(?PAM:GD_PR_34)
              UNHIDE(?PAM:GD_KOEF_34)
              UNHIDE(?PAM:NOL_GD_34)
              UNHIDE(?LOCK34)
           END
           BEGIN
              UNHIDE(?GA35)
              UNHIDE(?PAM:KAT_35)
              UNHIDE(?PAM:GD_PR_35)
              UNHIDE(?PAM:GD_KOEF_35)
              UNHIDE(?PAM:NOL_GD_35)
              UNHIDE(?LOCK35)
           END
           BEGIN
              UNHIDE(?GA36)
              UNHIDE(?PAM:KAT_36)
              UNHIDE(?PAM:GD_PR_36)
              UNHIDE(?PAM:GD_KOEF_36)
              UNHIDE(?PAM:NOL_GD_36)
              UNHIDE(?LOCK36)
           END
           BEGIN
              UNHIDE(?GA37)
              UNHIDE(?PAM:KAT_37)
              UNHIDE(?PAM:GD_PR_37)
              UNHIDE(?PAM:GD_KOEF_37)
              UNHIDE(?PAM:NOL_GD_37)
              UNHIDE(?LOCK37)
           END
           BEGIN
              UNHIDE(?GA38)
              UNHIDE(?PAM:KAT_38)
              UNHIDE(?PAM:GD_PR_38)
              UNHIDE(?PAM:GD_KOEF_38)
              UNHIDE(?PAM:NOL_GD_38)
              UNHIDE(?LOCK38)
           END
           BEGIN
              UNHIDE(?GA39)
              UNHIDE(?PAM:KAT_39)
              UNHIDE(?PAM:GD_PR_39)
              UNHIDE(?PAM:GD_KOEF_39)
              UNHIDE(?PAM:NOL_GD_39)
              UNHIDE(?LOCK39)
           END
           BEGIN
              UNHIDE(?GA40)
              UNHIDE(?PAM:KAT_40)
              UNHIDE(?PAM:GD_PR_40)
              UNHIDE(?PAM:GD_KOEF_40)
              UNHIDE(?PAM:NOL_GD_40)
              UNHIDE(?LOCK40)
           END
         .
         IF PAM:LOCK_GD[I#]
            EXECUTE I#
              DISABLE(?PAM:NOL_GD_1)
              DISABLE(?PAM:NOL_GD_2)
              DISABLE(?PAM:NOL_GD_3)
              DISABLE(?PAM:NOL_GD_4)
              DISABLE(?PAM:NOL_GD_5)
              DISABLE(?PAM:NOL_GD_6)
              DISABLE(?PAM:NOL_GD_7)
              DISABLE(?PAM:NOL_GD_8)
              DISABLE(?PAM:NOL_GD_9)
              DISABLE(?PAM:NOL_GD_10)
              DISABLE(?PAM:NOL_GD_11)
              DISABLE(?PAM:NOL_GD_12)
              DISABLE(?PAM:NOL_GD_13)
              DISABLE(?PAM:NOL_GD_14)
              DISABLE(?PAM:NOL_GD_15)
              DISABLE(?PAM:NOL_GD_16)
              DISABLE(?PAM:NOL_GD_17)
              DISABLE(?PAM:NOL_GD_18)
              DISABLE(?PAM:NOL_GD_19)
              DISABLE(?PAM:NOL_GD_20)
              DISABLE(?PAM:NOL_GD_21)
              DISABLE(?PAM:NOL_GD_22)
              DISABLE(?PAM:NOL_GD_23)
              DISABLE(?PAM:NOL_GD_24)
              DISABLE(?PAM:NOL_GD_25)
              DISABLE(?PAM:NOL_GD_26)
              DISABLE(?PAM:NOL_GD_27)
              DISABLE(?PAM:NOL_GD_28)
              DISABLE(?PAM:NOL_GD_29)
              DISABLE(?PAM:NOL_GD_30)
              DISABLE(?PAM:NOL_GD_31)
              DISABLE(?PAM:NOL_GD_32)
              DISABLE(?PAM:NOL_GD_33)
              DISABLE(?PAM:NOL_GD_34)
              DISABLE(?PAM:NOL_GD_35)
              DISABLE(?PAM:NOL_GD_36)
              DISABLE(?PAM:NOL_GD_37)
              DISABLE(?PAM:NOL_GD_38)
              DISABLE(?PAM:NOL_GD_39)
              DISABLE(?PAM:NOL_GD_40)
            .
            EXECUTE I#
              UNHIDE(?Image1)
              UNHIDE(?Image2)
              UNHIDE(?Image3)
              UNHIDE(?Image4)
              UNHIDE(?Image5)
              UNHIDE(?Image6)
              UNHIDE(?Image7)
              UNHIDE(?Image8)
              UNHIDE(?Image9)
              UNHIDE(?Image10)
              UNHIDE(?Image11)
              UNHIDE(?Image12)
              UNHIDE(?Image13)
              UNHIDE(?Image14)
              UNHIDE(?Image15)
              UNHIDE(?Image16)
              UNHIDE(?Image17)
              UNHIDE(?Image18)
              UNHIDE(?Image19)
              UNHIDE(?Image20)
              UNHIDE(?Image21)
              UNHIDE(?Image22)
              UNHIDE(?Image23)
              UNHIDE(?Image24)
              UNHIDE(?Image25)
              UNHIDE(?Image26)
              UNHIDE(?Image27)
              UNHIDE(?Image28)
              UNHIDE(?Image29)
              UNHIDE(?Image30)
              UNHIDE(?Image31)
              UNHIDE(?Image32)
              UNHIDE(?Image33)
              UNHIDE(?Image34)
              UNHIDE(?Image35)
              UNHIDE(?Image36)
              UNHIDE(?Image37)
              UNHIDE(?Image38)
              UNHIDE(?Image39)
              UNHIDE(?Image40)
            .
         .
      ELSE
         BREAK
      .
   .
   DISPLAY
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
      IF BRW2::Sort1:Reset:PAM:U_NR <> PAM:U_NR
        BRW2::Changed = True
      END
    END
  ELSE
  END
  IF BRW2::SortOrder <> BRW2::LastSortOrder OR BRW2::Changed OR ForceRefresh
    CASE BRW2::SortOrder
    OF 1
      BRW2::Sort1:Reset:PAM:U_NR = PAM:U_NR
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
        StandardWarning(Warn:RecordFetchError,'PAMAM')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW2::FillQueue
    IF AMO:U_NR=PAM:U_NR         !SUPERKONTROLE
       IF FORCEDNODALACHANGE=TRUE
          IF CHANGEPOINT AND F:NODALA !IR MAINÎTS IEKÐ UPDATEPAMAM
             IF AMO:YYYYMM > CHANGEPOINT !MAINAM UZ LEJU NO TEKOÐÂ
                IF ~(AMO:NODALA=F:NODALA)
                    AMO:NODALA=F:NODALA
                    IF RIUPDATE:PAMAM()
                       KLUDA(24,'PAMAM')
                    .
                .
             .
          ELSE !MAINÎTS PAMAT CEPURÇ
             IF ~(AMO:NODALA=PAM:NODALA)
                AMO:NODALA=PAM:NODALA
                IF RIUPDATE:PAMAM()
                   KLUDA(24,'PAMAM')
                .
             .
          .
       .
    END
  END
    FORCEDNODALACHANGE=FALSE
    CHANGEPOINT=0
    F:NODALA=0
  SETCURSOR()
!----------------------------------------------------------------------
BRW2::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  AMO:YYYYMM = BRW2::AMO:YYYYMM
  KAT = BRW2::KAT
  AMO:LIN_G_PR = BRW2::AMO:LIN_G_PR
  AMO:NODALA = BRW2::AMO:NODALA
  AMO:SAK_V_LI = BRW2::AMO:SAK_V_LI
  VERT_IZM = BRW2::VERT_IZM
  AMO:NOL_U_LI = BRW2::AMO:NOL_U_LI
  AMO:NOL_LIN = BRW2::AMO:NOL_LIN
  AMO:LOCK_LIN = BRW2::AMO:LOCK_LIN
  AMO:U_NR = BRW2::AMO:U_NR
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
  IF YEAR(PAM:EXPL_DATUMS) < 1995
     PAM_EXPL_DATUMS=DATE(1,1,1995) !1=1995,15=2009(GD: 1994 iekð PAMAT un uz EKRÂNA NERÂDAM...)
  ELSE
     PAM_EXPL_DATUMS=PAM:EXPL_DATUMS
  .
  INDEX#=YEAR(AMO:YYYYMM)-YEAR(PAM_EXPL_DATUMS)+1  ! PÂRINDEKSÂCIJA iekð PAMAT:GD[] MAX=15
  IF INDEX#<1 THEN INDEX#=1. !DÇÏ AMO:199412
  KAT=PAM:KAT[INDEX#]
!  IF YEAR(AMO:YYYYMM)<1995
!     KAT=PAM:KAT[1]
!  ELSE
!     IF YEAR(PAM:EXPL_DATUMS)<1995
!        KAT=PAM:KAT[1]
!     ELSE
!        IF YEAR(AMO:YYYYMM)-YEAR(PAM:EXPL_DATUMS)+1 < 15 !droðîbas pçc
!           KAT=PAM:KAT[YEAR(AMO:YYYYMM)-YEAR(PAM:EXPL_DATUMS)+1]
!        .
!     .
!  .
  VERT_IZM = AMO:KAPREM + AMO:PARCEN + AMO:PARCENLI - AMO:IZSLEGTS
  BRW2::AMO:YYYYMM = AMO:YYYYMM
  BRW2::KAT = KAT
  BRW2::AMO:LIN_G_PR = AMO:LIN_G_PR
  BRW2::AMO:NODALA = AMO:NODALA
  BRW2::AMO:SAK_V_LI = AMO:SAK_V_LI
  BRW2::VERT_IZM = VERT_IZM
  BRW2::AMO:NOL_U_LI = AMO:NOL_U_LI
  BRW2::AMO:NOL_LIN = AMO:NOL_LIN
  BRW2::AMO:LOCK_LIN = AMO:LOCK_LIN
  BRW2::AMO:U_NR = AMO:U_NR
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
        StandardWarning(Warn:RecordFetchError,'PAMAM')
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
      BRW2::HighlightedPosition = POSITION(AMO:NR_KEY)
      RESET(AMO:NR_KEY,BRW2::HighlightedPosition)
    ELSE
      AMO:U_NR = PAM:U_NR
      SET(AMO:NR_KEY,AMO:NR_KEY)
    END
    BRW2::View:Browse{Prop:Filter} = |
    'AMO:U_NR = BRW2::Sort1:Reset:PAM:U_NR'
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
    CLEAR(AMO:Record)
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
    AMO:U_NR = PAM:U_NR
    SET(AMO:NR_KEY)
    BRW2::View:Browse{Prop:Filter} = |
    'AMO:U_NR = BRW2::Sort1:Reset:PAM:U_NR'
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
    PAM:U_NR = BRW2::Sort1:Reset:PAM:U_NR
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
  GET(PAMAM,0)
  CLEAR(AMO:Record,0)
  CASE BRW2::SortOrder
  OF 1
    AMO:U_NR = BRW2::Sort1:Reset:PAM:U_NR
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
!| (UpdatePAMAMORT) is called.
!|
!| Upon return from the update, the routine BRW2::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW2::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdatePAMAMORT
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
        GET(PAMAM,0)
        CLEAR(AMO:Record,0)
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
  IF GLOBALRESPONSE=REQUESTCOMPLETED AND F:NODALA
     CHANGEPOINT=AMO:YYYYMM
     FORCEDNODALACHANGE=TRUE
     DO BRW2::InitializeBrowse   ! Lai nomaina PAMAM, ja mainâs nodaïa
     DO BRW2::RefreshPage
  .

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
    OF ?PAM:U_NR
      PAM:U_NR = History::PAM:Record.U_NR
    OF ?PAM_ATB_NOS
      PAM_ATB_NOS = History::PAM:Record.ATB_NOS
    OF ?PAM:IZG_GAD
      PAM:IZG_GAD = History::PAM:Record.IZG_GAD
    OF ?PAM:DATUMS
      PAM:DATUMS = History::PAM:Record.DATUMS
    OF ?PAM:EXPL_DATUMS
      PAM:EXPL_DATUMS = History::PAM:Record.EXPL_DATUMS
    OF ?PAM:DOK_SENR
      PAM:DOK_SENR = History::PAM:Record.DOK_SENR
    OF ?PAM:NOS_P
      PAM:NOS_P = History::PAM:Record.NOS_P
    OF ?PAM:NOS_S
      PAM:NOS_S = History::PAM:Record.NOS_S
    OF ?PAM:NOS_A
      PAM:NOS_A = History::PAM:Record.NOS_A
    OF ?PAM:BKK
      PAM:BKK = History::PAM:Record.BKK
    OF ?PAM:BKKN
      PAM:BKKN = History::PAM:Record.BKKN
    OF ?PAM:OKK7
      PAM:OKK7 = History::PAM:Record.OKK7
    OF ?PAM:IEP_V
      PAM:IEP_V = History::PAM:Record.IEP_V
    OF ?PAM:KAP_V
      PAM:KAP_V = History::PAM:Record.KAP_V
    OF ?PAM:NOL_V
      PAM:NOL_V = History::PAM:Record.NOL_V
    OF ?PAM:BIL_V
      PAM:BIL_V = History::PAM:Record.BIL_V
    OF ?PAM:OBJ_NR
      PAM:OBJ_NR = History::PAM:Record.OBJ_NR
    OF ?PAM:SKAITS
      PAM:SKAITS = History::PAM:Record.SKAITS
    OF ?PAM:NODALA
      PAM:NODALA = History::PAM:Record.NODALA
    OF ?PAM:LIN_G_PR
      PAM:LIN_G_PR = History::PAM:Record.LIN_G_PR
    OF ?PAM:END_DATE
      PAM:END_DATE = History::PAM:Record.END_DATE
    OF ?PAM:ACC_KODS
      PAM:ACC_KODS = History::PAM:Record.ACC_KODS
    OF ?PAM:ACC_DATUMS
      PAM:ACC_DATUMS = History::PAM:Record.ACC_DATUMS
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
  PAM:Record = SAV::PAM:Record
  SAV::PAM:Record = PAM:Record
  Auto::Attempts = 0
  LOOP
    SET(PAM:NR_KEY)
    PREVIOUS(PAMAT)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAMAT')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAM:U_NR = 1
    ELSE
      Auto::Save:PAM:U_NR = PAM:U_NR + 1
    END
    PAM:Record = SAV::PAM:Record
    PAM:U_NR = Auto::Save:PAM:U_NR
    SAV::PAM:Record = PAM:Record
    ADD(PAMAT)
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
        DELETE(PAMAT)
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

