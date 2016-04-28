                     MEMBER('winlats.clw')        ! This is a MEMBER module
BrowsePAR_K PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
SAV_ATZIME           BYTE
FIRSTLOCATE          BYTE
local_path           CSTRING(100)
par_atzime1          STRING(40)
SAV:ATZIME           BYTE
bridinajums          STRING(400)
CP                   STRING(5)
PAR_K_POSITION  STRING(256)
GG_POSITION     STRING(256)
KESKA           CSTRING(21)
SEARCHMODE      BYTE
GG_DOK_SENR     LIKE(gg:dok_SENr)
GG_DOKDAT       LIKE(gg:dokdat)
SAMSUMMA        DECIMAL(12,2)
SAMDAT          LONG
PAR_EMAIL       STRING(71) !MAX VAR BÛT 2*35+1
PAR_NOS_P       LIKE(PAR:NOS_P)

KESKAwindow WINDOW('Izvçles logs'),AT(,,197,73),GRAY
       STRING('Meklçjamais fragments:'),AT(9,18),USE(?String221)
       ENTRY(@s20),AT(94,17),USE(keska)
       STRING('(ar latvieðu burtiem)'),AT(95,31),USE(?String2),FONT(,,COLOR:Gray,,CHARSET:ANSI)
       BUTTON('&OK'),AT(116,45,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(154,45,36,14),USE(?CancelButton)
     .

RAKSTI         ULONG
Izlaisti       ULONG
SPIEDIET       STRING(40)

INETscreen WINDOW('Interneta faila sagatavoðana'),AT(,,280,88),CENTER,GRAY
       STRING('Tiks izveidots FTP fails '),AT(9,11),USE(?Stringftp)
       STRING(@s50),AT(87,10,185,10),USE(ANSIFILENAME),LEFT(2)
       STRING('kur Par:Grupa beidzas ar K vai I'),AT(69,21),USE(?String9)
       STRING('Ierakstîti:'),AT(56,42),USE(?StringIERI)
       STRING(@n7B),AT(96,42),USE(raksti,,?RAKSTII)
       STRING('Izlaisti:'),AT(62,51),USE(?StringIZLI)
       STRING(@n7B),AT(96,51),USE(izlaisti,,?IZLAISTII)
       STRING(@s40),AT(27,64),USE(SPIEDIET,,?SPIEDIETI)
       STRING(@s45),AT(48,32),USE(par:nos_p,,?par:nos_pi),HIDE
       BUTTON('&OK'),AT(184,69,43,14),USE(?Ok:I),DEFAULT
       BUTTON('&Atlikt'),AT(230,69,43,14),USE(?Cancel:I),DEFAULT
     .
IRNAV       BYTE
F:ATZIME_T  STRING(40)

FiltrsScreen WINDOW('Partneru saraksta redzamîbas Filtri'),AT(,,255,66),GRAY
       GROUP('Pçc Atzîmes:'),AT(4,5,245,37),USE(?Group1),BOXED
         STRING('atzîme :'),AT(58,17),USE(?String1)
         ENTRY(@N3B),AT(85,17,21,10),USE(F:ATZIME)
         OPTION(' '),AT(13,12,44,27),USE(IRNAV),BOXED
           RADIO('kam ir'),AT(15,17,32,10),USE(?Option1:Radio1),VALUE('1')
           RADIO('kam nav'),AT(15,26,35,10),USE(?Option1:Radio2),VALUE('2')
         END
         STRING(@s40),AT(107,18),USE(F:ATZIME_T)
         STRING('tukðums-noòemt filtru'),AT(85,28),USE(?String3),FONT(,,COLOR:Gray,,CHARSET:ANSI)
       END
       BUTTON('&OK'),AT(194,45,43,14),USE(?Ok:F),DEFAULT
     END

RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
PercentProgress      BYTE

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Apturçt'),AT(45,37,50,15),USE(?Progress:Cancel)
     .


BRW1::View:Browse    VIEW(PAR_K)
                       PROJECT(PAR:BAITS)
                       PROJECT(PAR:U_NR)
                       PROJECT(PAR:KARTE)
                       PROJECT(PAR:TIPS)
                       PROJECT(PAR:GRUPA)
                       PROJECT(PAR:NOS_S)
                       PROJECT(PAR:NOS_P)
                       PROJECT(PAR:NMR_KODS)
                       PROJECT(PAR:NMR_PLUS)
                       PROJECT(PAR:ATZIME1)
                       PROJECT(PAR:ATZIME2)
                       PROJECT(PAR:NOS_U)
                       PROJECT(PAR:KRED_LIM)
                       PROJECT(PAR:ADRESE)
                       PROJECT(PAR:NOS_A)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::PAR:BAITS        LIKE(PAR:BAITS)            ! Queue Display field
BRW1::PAR:U_NR         LIKE(PAR:U_NR)             ! Queue Display field
BRW1::PAR:KARTE        LIKE(PAR:KARTE)            ! Queue Display field
BRW1::PAR:TIPS         LIKE(PAR:TIPS)             ! Queue Display field
BRW1::PAR:GRUPA        LIKE(PAR:GRUPA)            ! Queue Display field
BRW1::PAR:NOS_S        LIKE(PAR:NOS_S)            ! Queue Display field
BRW1::PAR:NOS_P        LIKE(PAR:NOS_P)            ! Queue Display field
BRW1::PAR:NMR_KODS     LIKE(PAR:NMR_KODS)         ! Queue Display field
BRW1::PAR:NMR_PLUS     LIKE(PAR:NMR_PLUS)         ! Queue Display field
BRW1::PAR:ATZIME1      LIKE(PAR:ATZIME1)          ! Queue Display field
BRW1::PAR:ATZIME1:NormalFG LONG                   ! Normal Foreground
BRW1::PAR:ATZIME1:NormalBG LONG                   ! Normal Background
BRW1::PAR:ATZIME1:SelectedFG LONG                 ! Selected Foreground
BRW1::PAR:ATZIME1:SelectedBG LONG                 ! Selected Background
BRW1::par_atzime1      LIKE(par_atzime1)          ! Queue Display field
BRW1::par_atzime1:NormalFG LONG                   ! Normal Foreground
BRW1::par_atzime1:NormalBG LONG                   ! Normal Background
BRW1::par_atzime1:SelectedFG LONG                 ! Selected Foreground
BRW1::par_atzime1:SelectedBG LONG                 ! Selected Background
BRW1::PAR:ATZIME2      LIKE(PAR:ATZIME2)          ! Queue Display field
BRW1::PAR:ATZIME2:NormalFG LONG                   ! Normal Foreground
BRW1::PAR:ATZIME2:NormalBG LONG                   ! Normal Background
BRW1::PAR:ATZIME2:SelectedFG LONG                 ! Selected Foreground
BRW1::PAR:ATZIME2:SelectedBG LONG                 ! Selected Background
BRW1::PAR:NOS_U        LIKE(PAR:NOS_U)            ! Queue Display field
BRW1::PAR:NOS_U:NormalFG LONG                     ! Normal Foreground
BRW1::PAR:NOS_U:NormalBG LONG                     ! Normal Background
BRW1::PAR:NOS_U:SelectedFG LONG                   ! Selected Foreground
BRW1::PAR:NOS_U:SelectedBG LONG                   ! Selected Background
BRW1::PAR:KRED_LIM     LIKE(PAR:KRED_LIM)         ! Queue Display field
BRW1::PAR:ADRESE       LIKE(PAR:ADRESE)           ! Queue Display field
BRW1::F:ATZIME         LIKE(F:ATZIME)             ! Queue Display field
BRW1::CP               LIKE(CP)                   ! Queue Display field
BRW1::PAR:NOS_A        LIKE(PAR:NOS_A)            ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(PAR:KARTE),DIM(100)
BRW1::Sort1:LowValue LIKE(PAR:KARTE)              ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(PAR:KARTE)             ! Queue position of scroll thumb
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort2:KeyDistribution LIKE(PAR:NMR_KODS),DIM(100)
BRW1::Sort2:LowValue LIKE(PAR:NMR_KODS)           ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(PAR:NMR_KODS)          ! Queue position of scroll thumb
BRW1::Sort3:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort3:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort3:KeyDistribution LIKE(PAR:U_NR),DIM(100)
BRW1::Sort3:LowValue LIKE(PAR:U_NR)               ! Queue position of scroll thumb
BRW1::Sort3:HighValue LIKE(PAR:U_NR)              ! Queue position of scroll thumb
BRW1::Sort4:KeyDistribution LIKE(PAR:NOS_U),DIM(100)
BRW1::Sort4:LowValue LIKE(PAR:NOS_U)              ! Queue position of scroll thumb
BRW1::Sort4:HighValue LIKE(PAR:NOS_U)             ! Queue position of scroll thumb
BRW1::Sort5:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort5:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort6:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort6:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort6:KeyDistribution LIKE(PAR:NOS_A),DIM(100)
BRW1::Sort6:LowValue LIKE(PAR:NOS_A)              ! Queue position of scroll thumb
BRW1::Sort6:HighValue LIKE(PAR:NOS_A)             ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Partneru saraksts'),AT(-1,-1,457,301),FONT('MS Sans Serif',9,,FONT:bold),IMM,VSCROLL,ICON('CHECK1.ICO'),HLP('BrowsePAR_K'),SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&5-Speciâlâs funkcijas'),USE(?5Speciâlâsfunkcijas)
                           ITEM('&1-Atrast adreses fragmentu uz leju no tekoðâ raksta'),USE(?1Atrastadresi)
                           ITEM('&2-Atrast kontaktpersonu uz leju no tekoðâ raksta'),USE(?5SpecF2Atrastkontaktpersonu)
                           ITEM('&3-Atrast e-maili uz leju no tekoðâ raksta'),USE(?5SpecF3Atrastemail)
                           ITEM('&4-Uzbûvçt i-neta failu'),USE(?5SpecialasfunkcijasINET),DISABLE
                           ITEM('&5-Mainît ðî saraksta redzamîbas filtra nosacîjumus'),USE(?5SpeciâlâsfunkcijasItem5)
                           ITEM('&6-Salîdzinât ar citu DB'),USE(?5SpecF6SCDB)
                         END
                       END
                       LIST,AT(8,21,436,231),USE(?Browse:1),IMM,HVSCROLL,FONT(,9,,FONT:bold),MSG('Browsing Records'),FORMAT('10C|M~X~@n1B@27R(2)|M~U NR~C(0)@n_7@23R(2)|M~Karte~C(0)@n_6@10C|M~T~@s1@32L(1)|M' &|
   '~Grupa~C(0)@s7@60L(1)|M~Saîsinâtais nos.~C(0)@s15@69L(1)|M~Pilns nosaukums~L(2)@' &|
   's35@50L(1)M~NMR~C(0)@S12@10C|M~F~L(1)@s1@14C|M*~A1~@n_3b@85L(1)|M*~Atzîme (1)~@s' &|
   '40@14C|M*~A2~@n3B@15L(1)|M*~Raz~C(0)@s3@39R(1)|M~Kred.lim.~C(0)@n_10.2B@160L(1)|' &|
   'M~Adrese~C(0)@s40@'),FROM(Queue:Browse:1),DROPID('''NO PAR_K1''')
                       BUTTON('&Ievadît'),AT(281,256,45,14),USE(?Insert:3)
                       BUTTON('Iz&vçlçties'),AT(286,278,44,14),USE(?Select),FONT(,,COLOR:Navy,,CHARSET:ANSI),KEY(EnterKey)
                       BUTTON('&E-mail'),AT(345,278,30,14),USE(?ButtonEmail)
                       BUTTON('&Mainît'),AT(329,256,45,14),USE(?Change),DEFAULT
                       BUTTON('&Beigt'),AT(413,278,39,14),USE(?Close)
                       BUTTON('Rekvizîti'),AT(377,278,34,14),USE(?ButtonRekviziti)
                       BUTTON('&Dzçst'),AT(381,256,45,14),USE(?Delete:3)
                       BUTTON('&X'),AT(6,278,14,14),USE(?ButtonX)
                       BUTTON('Vçst&ure'),AT(169,278,40,14),USE(?Vesture),HIDE
                       BUTTON('Vçstule/&Adrese'),AT(224,278,60,14),USE(?Vestule),HIDE
                       BUTTON('Norçíini &par 231...'),AT(25,278,73,14),USE(?Nor231),HIDE
                       BUTTON('Norçíini par &531..'),AT(100,278,68,14),USE(?nor531),HIDE
                       BUTTON('Paòemt no citas DB'),AT(150,256,77,14),USE(?panemt)
                       BUTTON('&C-Kopçt'),AT(233,256,45,14),USE(?KOPET)
                       SHEET,AT(-1,4,454,271),USE(?CurrentTab)
                         TAB('&Nosaukumu secîbâ'),USE(?Tab:1)
                           ENTRY(@s12),AT(4,257,74,12),USE(PAR:NOS_A)
                           STRING('- pçc nosaukuma '),AT(81,260),USE(?String4)
                         END
                         TAB('&Karðu Nr secîbâ'),USE(?Tab:2)
                           ENTRY(@n-7.0B),AT(7,258,35,12),USE(PAR:KARTE)
                           STRING('- pçc klienta kartes Nr'),AT(47,260),USE(?String3)
                         END
                         TAB('&Reìistrâcijas Nr.sec.'),USE(?Tab:3)
                           ENTRY(@S22),AT(5,257,74,12),USE(PAR:NMR_KODS)
                           STRING('- pçc NMR'),AT(84,260),USE(?String2:3)
                         END
                         TAB('Iekðçjo &U Nr secîbâ'),USE(?Tab:4)
                           ENTRY(@n13B),AT(28,257,35,12),USE(PAR:U_NR)
                           STRING('- pçc iekðçjâ Nr'),AT(66,258),USE(?String:IEKSNR)
                         END
                         TAB('Raþotâju kodu &secîba (arî A)'),USE(?Tab:5)
                         END
                         TAB('Ar&hîvs'),USE(?Tab:6)
                           ENTRY(@s12),AT(9,258,69,12),USE(PAR:NOS_A,,?PAR:NOS_A:2)
                           STRING('-pçc nosaukuma'),AT(83,260),USE(?String5)
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
  BROWSEPAR_K::USED=TRUE
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  ?BROWSE:1{PROP:FORMAT}=GETINI('BrowsePar_k','?BROWSE:1 Format',?BROWSE:1{PROP:FORMAT},'WinLats.ini')
  IF LOCALREQUEST=SELECTRECORD
     ?Change {PROP:DEFAULT}=''
     ?Select{PROP:DEFAULT}='1'
  !   QUICKWINDOW{PROP:TEXT}='Izvçlaties partneri'
  ELSE 
  !   ?Change {PROP:COLOR}=COLOR:Navy
  .
  EXECUTE Last_PAR_tab
     SELECT(?TAB:1)
     SELECT(?TAB:2)
     SELECT(?TAB:3)
     SELECT(?TAB:4)
  .
  IRNAV=0
  SAV:ATZIME=F:ATZIME
  F:ATZIME_T=GetPar_Atzime(F:ATZIME,1)
  CP='B000'
  !   1234
  !STOP(F:ATZIME)
  
  !*******USER LEVEL ACCESS CONTROL********
  IF BAND(REG_NOL_ACC,01000000b) OR| !I-NETS
     ACC_KODS_N=0
     ENABLE(?5SpecialasfunkcijasINET)
  .
  ACCEPT
    IF F:ATZIME_T
       QUICKWINDOW{PROP:TEXT}='Partneru saraksts(par_k.tps). '&CLIP(RECORDS(PAR_K))&' raksti. Filtrs pçc atzîmes: '&F:ATZIME_T
    ELSE
       QUICKWINDOW{PROP:TEXT}='Partneru saraksts(par_k.tps). '&CLIP(RECORDS(PAR_K))&' raksti.'
    .
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
      IF PAR_NR and ~(PAR_NR=999999999)
         CLEAR(PAR:RECORD)
         PAR:U_NR=PAR_NR
         SET(PAR:NR_KEY,PAR:NR_KEY)
         NEXT(PAR_K)
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
      !   DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         DO RefreshWindow
         ?Browse:1{PROPLIST:HEADER,1}='X' !Lai piespiestu pârlasît ekrânu
      .
      IF GGNAME AND GGKNAME AND Apskatit231531=TRUE
         UNHIDE(?NOR231)
         UNHIDE(?NOR531)
         UNHIDE(?Vesture)
         UNHIDE(?Vestule)
      .
      ?5SpecialasfunkcijasINET{PROP:TEXT}='&4-Uzbûvçt '&CLIP(LONGPATH())&'\INET\PAR_K.TXT'
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
    OF ?1Atrastadresi
      DO SyncWindow
      SEARCHMODE=1
      DO SEARCHKESKA
    OF ?5SpecF2Atrastkontaktpersonu
      DO SyncWindow
      SEARCHMODE=2
      DO SEARCHKESKA
    OF ?5SpecF3Atrastemail
      DO SyncWindow
      SEARCHMODE=3
      DO SEARCHKESKA
    OF ?5SpecialasfunkcijasINET
      DO SyncWindow
      RAKSTI=0
      IZLAISTI=0
      SPIEDIET=''
      KLU_DARBIBA=0 !OTRÂDI-PÂRBÛVÇT
      ANSIFILENAME=CLIP(LONGPATH())&'\INET\PAR_K.TXT'
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
                  UNHIDE(?PAR:NOS_PI)
                  DISPLAY
                  IF ~OPENANSI(ANSIFILENAME,1)
                     POST(Event:CloseWindow)
                     CYCLE
                  .
         !         IF CL_NR=1493 !RÎGAS BÛVMATERIÂLI
         !         ELSIF CL_NR=1479 OR| !SANTEKO
         !               CL_NR=1033 OR| !SAIMNIEKS-SERVISS
         !               CL_NR=1734     !INSBERGS
         !         ELSE                 !AUTO ÎLE
         !         .
                  OUTA:LINE='Karte'&CHR(9)&'U_nr'&CHR(9)&'Nosaukums'&CHR(9)&'Atzîme' &CHR(9)&|
                  'NMR/PK'&CHR(9)&'Grupa'&CHR(9)&'Kredîtlimits'&CHR(9)&'Atlaide'
                  ADD(OUTFILEANSI)
                  CLEAR(PAR:RECORD)
         !         STREAM(PAR_K)
                  SET(PAR:NOS_KEY)
                  LOOP
                     NEXT(PAR_K)
                     DISPLAY
                     IF ERROR() THEN BREAK.
                     IF ~(PAR:grupa[7]='K' OR PAR:grupa[7]='I')
                        IZLAISTI+=1
                        CYCLE
                     .
                     OUTA:LINE=CLIP(PAR:KARTE)&CHR(9)&CLIP(PAR:U_NR)&CHR(9)&CLIP(PAR:NOS_P)&CHR(9)&CLIP(PAR:ATZIME1)&|
                     CHR(9)&PAR:NMR_KODS&CHR(9)&PAR:grupa&CHR(9)&LEFT(FORMAT(PAR:KRED_LIM,@N_11.2B))&CHR(9)&|
                     LEFT(FORMAT(PAR:ATLAIDE,@N_5.1B))
                     ADD(OUTFILEANSI)
                     RAKSTI+=1
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
    OF ?5SpeciâlâsfunkcijasItem5
      DO SyncWindow
      open(filtrsscreen)
      IRNAV=1
      display
      accept
         case field()
         OF ?F:atzime
            case event()
            of event:accepted
               F:ATZIME_T=GetPar_Atzime(F:ATZIME,1)
               DISPLAY
            .
         OF ?OK:F
            case event()
            of event:accepted
               IF ~F:ATZIME THEN IRNAV=0.
               break
            .
         .
      .
      close(filtrsscreen)
      IF ~(F:ATZIME=SAV:ATZIME)
         CP='B00'&IRNAV
         SAV:ATZIME=F:ATZIME
         IF ERROR() THEN STOP(ERROR()).
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
    OF ?5SpecF6SCDB
      DO SyncWindow
        LOCAL_path=PATH()
        Filename1=''
        IF FILEDIALOG('Izvçlaties failu',FileName1,'Visi PAR_K.TPS|PAR_K.TPS',0)
           setpath(local_path)
           CHECKOPEN(PAR_K1)
           IF OPENANSI('COMPAREPARK.TXT')
              RecordsToProcess = RECORDS(PAR_K)
              RecordsProcessed = 0
              PercentProgress = 0
              OPEN(ProgressWindow)
              Progress:Thermometer = 0
              ?Progress:PctText{Prop:Text} = '0%'
      !        SEND(PAR_K,'QUICKSCAN=on')
              OUTA:LINE=format(TODAY(),@D06.)&': Salîdzinu PAR_K.tps DB: '&CLIP(path())&' ar '&CLIP(FILENAME1)
              ADD(OUTFILEANSI)
              OUTA:LINE=''
              ADD(OUTFILEANSI)
              OUTA:LINE='U_NR'&CHR(9)&'KÏÛDA'&CHR(9)&'NMR ÐEIT'&CHR(9)&'NOSAUKUMS'&CHR(9)&'NMR TUR'&CHR(9)&'NOSAUKUMS'
                    ADD(OUTFILEANSI)
              CLEAR(PAR:RECORD)
              SET(PAR:NR_KEY)
              LOOP
                 NEXT(PAR_K)
                 IF ERROR() THEN BREAK.
                 RecordsProcessed += 1
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
                 PAR1:U_NR=PAR:U_NR
                 GET(PAR_K1,PAR1:NR_KEY)
                 IF ERROR()
                    OUTA:LINE=PAR:U_NR&CHR(9)&'NAV ATRASTS       '&CHR(9)&PAR:NMR_KODS&CHR(9)&PAR:NOS_P
                    ADD(OUTFILEANSI)
                 ELSIF ~(PAR:NMR_KODS=PAR1:NMR_KODS)
                    OUTA:LINE=PAR:U_NR&CHR(9)&'NESAKRÎT NM REÌ.NR'&CHR(9)&PAR:NMR_KODS&CHR(9)&PAR:NOS_P&CHR(9)&PAR1:NMR_KODS&CHR(9)&PAR1:NOS_P
                    ADD(OUTFILEANSI)
                 .
              .
              close(ProgressWindow)
              CLOSE(OUTFILEANSI)
              CLOSE(PAR_K1)
              F:DBF='E'
              ANSIJOB
           .
        .
        setpath(local_path)
      
      
      
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
      OF EVENT:Drop
        ! CLEAR(PAR:RECORD)
         PAR1:U_NR=DROPID()
        ! STOP(PAR1:U_NR)
         GET(PAR_K1,PAR1:NR_KEY)
         PAR:U_NR=PAR1:U_NR
         GET(PAR_K,PAR:NR_KEY)
         IF ERROR()
        !    KLUDA(0,PAR:U_NR&' NAV ATRASTS,ADD')
            PAR:RECORD=PAR1:RECORD
            DO CHECKKEYS
            ADD(PAR_K)
         ELSE
            KLUDA(0,PAR:U_NR&' U_NR DB jau eksistç :'&CLIP(PAR:NOS_P),8)
            IF KLU_DARBIBA
               COPYREQUEST=2
               DO BRW1::ButtonInsert !pieðíire jâtaisa pçc viòa CLEARALL darbîbâm
            .
         .
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?Insert:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Select
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
        CASE GETPAR_ATZIME(PAR:ATZIME1,2)
        OF 1
           KLUDA(68,ATZ:TEKSTS,,1)
        OF 2
        OROF 3
           KLUDA(68,ATZ:TEKSTS)
        .
        CASE GETPAR_ATZIME(PAR:ATZIME2,2)
        OF 1
           KLUDA(68,ATZ:TEKSTS,,1)
        OF 2
        OROF 3
           KLUDA(68,ATZ:TEKSTS)
        .
      END
    OF ?ButtonEmail
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAR:EMAIL
           IF OUTLOOK !WINLATSC.INI DEFINÇTA KÂDA PASTA PROGRAMMA
              GG_POSITION=POSITION(GG:DAT_KEY)
              KKK='231'
              D_K='K'
              IMAGE#=PerfAtable(1,'','','',PAR:U_NR,'',0,0,'',0) !UZBUVÇ APMAKSAS ÐITAM PARTNERIM
              NESAMAKSA#=0
              BRIDINAJUMS='' !e-mailî
              TEKSTS='e: Atgâdinâjums- jûs neesat apmaksâjuði rçíinus' !VÇSTURÇ
              clear(ggk:record)
              ggk:PAR_NR=PAR:U_NR
              SET(GGK:PAR_KEY,GGK:PAR_KEY)
              LOOP
                NEXT(GGK)
                IF ERROR() THEN BREAK.
                IF ~(ggk:PAR_NR=PAR:U_NR) THEN BREAK.
                IF GGK:BKK[1:3]='231'
                   I#=getgg(ggk:u_nr)
                   IF GGK:D_K='D'
                      IF GG:APMDAT < TODAY() !JAU BIJA JÂBÛT SAMAKSÂTAM ÐOBRÎD
                         IF GGK:U_NR=1
                            SAMSUMMA=PerfAtable(2,GGK:REFERENCE,'','',GGK:PAR_NR,'',0,0,'',0)
                         ELSE
                            SAMSUMMA=PerfAtable(2,GG:DOK_SENR,'','',GG:PAR_NR,'',0,0,'',0)
                         .
                         SamDat=PERIODS    !PÇDÇJÂ MAKSÂJUMA DATUMS (Ðíiet periodu izmanto tikai noliktava)
                         IF GGK:SUMMA>Samsumma AND ~INRANGE(GGK:SUMMA-Samsumma,-.02,.02)
                            NESAMAKSA#+=1
                            IF NESAMAKSA#>1
                               bridinajums=CLIP(bridinajums)&CHR(0DH)&CHR(0AH)
                               TEKSTS=CLIP(TEKSTS)&','
                            .
                            IF GGK:U_NR=1
                               GG_DOK_SENR=GGK:REFERENCE
                               GG_DOKDAT=GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,5)
                            ELSE
                               GG_DOK_SENR=gg:dok_SENr
                               GG_DOKDAT=gg:dokdat
                            .
                            IF ~SAMSUMMA !NEKAS PAR ÐO RÇÍINU NAV MAKSÂTS
                               bridinajums=CLIP(bridinajums)&'Atgâdinâjums: jûs neesat apmaksâjuði rçíinu Nr '&CLIP(gg_dok_SENr)&|
                               ' no '&FORMAT(gg_dokdat,@D06.)&' par summu '&val_uzsk&' '&LEFT(FORMAT((ggk:summa),@N_9.2))
                               TEKSTS=CLIP(TEKSTS)&' Nr '&CLIP(gg_dok_SENr)&' '&val_uzsk&' '&LEFT(FORMAT((ggk:summa),@N_9.2))
                            ELSE
                               bridinajums=CLIP(bridinajums)&'Atgâdinâjums: jûs neesat pilnîbâ apmaksâjuði rçíinu Nr '&CLIP(gg_dok_SENr)&|
                               ' no '&FORMAT(gg_dokdat,@D06.)&' summa '&val_uzsk&' '&clip(LEFT(FORMAT((ggk:summa),@N_9.2)))&|
                               ' parâds '&val_uzsk&' '&LEFT(FORMAT((ggk:summa-samsumma),@N_9.2))
                               TEKSTS=CLIP(TEKSTS)&' Nr '&CLIP(gg_dok_SENr)&' parâds '&val_uzsk&' '&|
                               LEFT(FORMAT((ggk:summa-samsumma),@N_9.2))
                            .
                         .
                      .
                   .
                .
              .
              RESET(GG,GG_POSITION)
              NEXT(GG)
              PAR_EMAIL=GETPAR_eMAIL(PAR:U_NR,0,1,0)
              PAR_NOS_P=INIGEN(PAR:NOS_P,45,8)
              IF INSTRING('OOK.',UPPER(OUTLOOK),1)!Outlook
                 RUN(OUTLOOK&' /c ipm.note /m '&CLIP(PAR_EMAIL),1)  !ðitam vairâk par 1 parametru iedot nevar...
              ELSIF INSTRING('IMN.',UPPER(OUTLOOK),1) !Outlook Express
                 RUN(OUTLOOK&' /mailurl:mailto:'&CLIP(PAR_EMAIL)&'?Subject='&CLIP(PAR_NOS_P)&|
                 '&Body=Labdien!'&CHR(0DH)&CHR(0AH)&CLIP(bridinajums)&CHR(0DH)&CHR(0AH)&|
                 '________________________________________________________________'&CHR(0DH)&CHR(0AH)&|
                 'Dokuments sagatavots un nosûtîts, izmantojot programmatûru WinLats',1)
              ELSIF INSTRING('AIL.',UPPER(OUTLOOK),1) !WINMAIL
                 RUN(OUTLOOK&' /mailurl:mailto:'&CLIP(PAR_EMAIL)&'?Subject='&CLIP(PAR_NOS_P)&|
                 '&Body=Labdien!'&CHR(0DH)&CHR(0AH)&CLIP(bridinajums)&CHR(0DH)&CHR(0AH)&|
                 '________________________________________________________________'&CHR(0DH)&CHR(0AH)&|
                 'Dokuments sagatavots un nosûtîts, izmantojot programmatûru WinLats',1)
              ELSE
                 KLUDA(0,'Definçta neatïauta E-pasta programma '&OUTLOOK)    
              .
              IF RUNCODE()=-4
                 KLUDA(88,'prog-a '&OUTLOOK)
              ELSE
                  IF VESTURE::USED=0
                     CHECKOPEN(VESTURE,1)
                  .
                  VESTURE::USED+=1
                  CLEAR(VES:RECORD)
                  VES:DOKDAT=TODAY()
                  VES:DATUMS=TODAY()
                  VES:SECIBA=CLOCK()
                  VES:PAR_NR=PAR:U_NR
                  VES:CRM   =0
                  IF BRIDINAJUMS
                     FORMAT_TEKSTS(47,'WINDOW',8,'')
                     VES:SATURS  = F_TEKSTS[1]
                     VES:SATURS2 = F_TEKSTS[2]
                     VES:SATURS3 = F_TEKSTS[3]
                  ELSE
                     VES:SATURS='e-Mail'
                  .
                  VES:D_K_KONTS=''
                  VES:ACC_DATUMS=today()
                  VES:ACC_KODS=ACC_kods
                  ADD(vesture)
                  VESTURE::USED-=1
                  IF VESTURE::USED=0
                     CLOSE(VESTURE)
                  .
              .
           ELSE
              KLUDA(0,'Nav definçta Outlook izsaukðana C:\WINLATS\WinLatsC.ini')
           .
        ELSE
           KLUDA(0,CLIP(PAR:NOS_P)&' nav definçta e-pasta adrese')
        .
        IF GG::U_NR !IZSAUKTS NO UPDATEGG
           LocalResponse = RequestCancelled
           POST(Event:CloseWindow)
        ELSE
           SELECT(?Browse:1)
        .
        
        !Type '"C:\Program Files\Windows Mail\WinMail" /mailurl:%' (Windows Mail) or '"C:\Program Files\Outlook Express\msimn"
        !/mailurl:' (Outlook Express).
        !Use the mailto URL encoder to construct a mailto: URL containing the desired default values.
        !For a message sent To: "recipient@example.com" by default with a Subject: of "Hello" and a body of "Hi there", the URL would be "mailto:recipient@example.com?subject=Hello&body=Hi%20there", for example.
        !Copy and paste the URL to the command line, appending it immediately after "mailurl:".
        !Enter a quotation mark '"' between "mailto:" and the email address of the default recipient.
        !The full command line using the above example is '"C:\Program Files\Outlook Express\msimn" /mailurl:mailto:"
        !recipient@example.com?subject=Hello&body=Hi%20there' (again including the inner but not including the outermost quotation marks).
        !Note
      END
    OF ?Change
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?ButtonRekviziti
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         DO SYNCWINDOW
         F_ParID
         IF GG::U_NR !IZSAUKTS NO UPDATEGG
            SELECT(?CLOSE)
         ELSE
            SELECT(?Browse:1)
         .
        
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
      END
    OF ?ButtonX
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           EXECUTE PAR:BAITS+1
              PAR:BAITS=1
              PAR:BAITS=2
              PAR:BAITS=3
              PAR:BAITS=4
              PAR:BAITS=5
              PAR:BAITS=0
           .
           IF RIUPDATE:PAR_K()
              KLUDA(24,'PAR_K')
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
    OF ?Vesture
      CASE EVENT()
      OF EVENT:Accepted
         DO SYNCWINDOW
         par_nr=par:u_nr
        DO SyncWindow
        BrowseVesture 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GG::U_NR !IZSAUKTS NO UPDATEGG
            SELECT(?Close)
         ELSE
            SELECT(?Browse:1)
         .
      END
    OF ?Vestule
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B_VestuleKlientam 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         T_POSITION=POSITION(GG:DAT_KEY)  !???
         IF F:IDP='1' !MAINÎTA ATZÎME-DRAUDU VÇSTULE
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
         .
         IF GG::U_NR !IZSAUKTS NO UPDATEGG
            SELECT(?CLOSE)
         ELSE
            SELECT(?Browse:1)
         .
      END
    OF ?Nor231
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         kkk='231'
         d_k='K'
         KKK1=''    !jânotîra dçï ieskaita
         D_K1=''
         par_nr=par:u_nr
         refergg
         IF GG::U_NR !IZSAUKTS NO UPDATEGG
            SELECT(?CLOSE)
         ELSE
            SELECT(?Browse:1)
         .
      END
    OF ?nor531
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        ELSE
           kkk='531'
           d_k='D'
           KKK1=''    !jânotîra dçï ieskaita
           D_K1=''
           par_nr=par:u_nr
           refergg
           IF GG::U_NR !IZSAUKTS NO UPDATEGG
              SELECT(?CLOSE)
           ELSE
              SELECT(?Browse:1)
           .
      END
    OF ?panemt
      CASE EVENT()
      OF EVENT:Accepted
          LOCAL_path=PATH()
        !  setpath(local_path[1:3]&'\winlats')
          Filename1=''
          IF FILEDIALOG('Izvçlaties failu',FileName1,'Visi PAR_K.TPS|PAR_K.TPS',0)
             setpath(local_path)
        !     GLOBALREQUEST=SELECTRECORD
             CHECKOPEN(PAR_K1,1)
             THREAD#=START(BROWSEPAR_K1,50000)
        !     BROWSEPAR_K1
        !     IF GLOBALRESPONSE=REQUESTCOMPLETED
        !        COPYREQUEST=2
        !        DO BRW1::ButtonInsert
        !     .
          .
          setpath(local_path)
                 
        DO SyncWindow
      END
    OF ?KOPET
      CASE EVENT()
      OF EVENT:Accepted
         COPYREQUEST=1
         DO BRW1::ButtonInsert
        DO SyncWindow
      END
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
        !SELECT(?BROWSE:1)  NESTRÂDÂ
        TABCHANGED#=TRUE
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?PAR:NOS_A
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?PAR:NOS_A)
        IF PAR:NOS_A
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort5:LocatorValue = PAR:NOS_A
          BRW1::Sort5:LocatorLength = LEN(CLIP(PAR:NOS_A))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      OF EVENT:Selected
        IF TABCHANGED#=TRUE
           SELECT(?BROWSE:1)
           TABCHANGED#=FALSE
        .
      END
    OF ?PAR:KARTE
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?PAR:KARTE)
        IF PAR:KARTE
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = PAR:KARTE
          BRW1::Sort1:LocatorLength = LEN(CLIP(PAR:KARTE))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      OF EVENT:Selected
        IF TABCHANGED#=TRUE
           SELECT(?BROWSE:1)
           TABCHANGED#=FALSE
        .
      END
    OF ?PAR:NMR_KODS
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?PAR:NMR_KODS)
        IF PAR:NMR_KODS
          CLEAR(PAR:NMR_PLUS)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort2:LocatorValue = PAR:NMR_KODS
          BRW1::Sort2:LocatorLength = LEN(CLIP(PAR:NMR_KODS))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      OF EVENT:Selected
        IF TABCHANGED#=TRUE
           SELECT(?BROWSE:1)
           TABCHANGED#=FALSE
        .
      END
    OF ?PAR:U_NR
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?PAR:U_NR)
        IF PAR:U_NR
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort3:LocatorValue = PAR:U_NR
          BRW1::Sort3:LocatorLength = LEN(CLIP(PAR:U_NR))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      OF EVENT:Selected
        IF TABCHANGED#=TRUE
           SELECT(?BROWSE:1)
           TABCHANGED#=FALSE
        .
      END
    OF ?PAR:NOS_A:2
      CASE EVENT()
      OF EVENT:Selected
        IF TABCHANGED#=TRUE
           SELECT(?BROWSE:1)
           TABCHANGED#=FALSE
        .
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  IF PAR_Z::Used = 0
    CheckOpen(PAR_Z,1)
  END
  PAR_Z::Used += 1
  BIND(ATZ:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowsePAR_K','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select{Prop:Hide} = True
    DISABLE(?Select)
  ELSE
    Browse::SelectRecord=TRUE
  END
  BIND('F:ATZIME',F:ATZIME)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAR_Z::Used -= 1
    IF PAR_Z::Used = 0 THEN CLOSE(PAR_Z).
  END
  PUTINI('BrowsePar_k','?BROWSE:1 Format',?BROWSE:1{PROP:FORMAT},'WinLats.ini')
  Last_PAR_tab=CHOICE(?CURRENTTAB)
  
  IF WindowOpened
    INISaveWindow('BrowsePAR_K','winlats.INI')
    CLOSE(QuickWindow)
  END
  BROWSEPAR_K::USED=FALSE      !NEÏAUJ IEIET CIKLÂ NO POGAS GG::NOR231
  Browse::SelectRecord=FALSE   !neïauj mainît PAR:U_NR, ja SELECT
  CLOSE(PAR_K1)
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
    PAR:KARTE = BRW1::Sort1:LocatorValue
  OF 2
    PAR:NMR_KODS = BRW1::Sort2:LocatorValue
  OF 3
    PAR:U_NR = BRW1::Sort3:LocatorValue
  OF 5
    PAR:NOS_A = BRW1::Sort5:LocatorValue
  OF 6
    PAR:NOS_A = BRW1::Sort6:LocatorValue
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

!---------------------------------------------------------------------------------------------
SEARCHKESKA     ROUTINE
 OPEN(KESKAWINDOW)
 ACCEPT
   CASE FIELD()
   OF ?OKButton
     BREAK
   OF ?CancelButton
     KESKA=''
     BREAK
  .
 .
 CLOSE(KESKAWINDOW)
 IF KESKA
   DO SyncWindow
   SET(PAR:NOS_KEY,PAR:NOS_KEY)
   FOUND#=0
   KESKA=UPPER(INIGEN(KESKA,LEN(KESKA),2))
   LOOP
      NEXT(PAR_K)

      IF ERROR() THEN BREAK.
!  STOP(KESKA&'='&UPPER(INIGEN(PAR:KONTAKTS,LEN(CLIP(PAR:KONTAKTS)),2)))
      IF (SEARCHMODE=1 AND INSTRING(KESKA,UPPER(INIGEN(PAR:ADRESE,LEN(CLIP(PAR:ADRESE)),2)),1)) OR|
         (SEARCHMODE=2 AND INSTRING(KESKA,UPPER(INIGEN(PAR:KONTAKTS,LEN(CLIP(PAR:KONTAKTS)),2)),1)) OR|
         (SEARCHMODE=3 AND INSTRING(KESKA,UPPER(INIGEN(PAR:EMAIL,LEN(CLIP(PAR:EMAIL)),2)),1))
         GLOBALREQUEST=0
         UPDATEPAR_K
         FOUND#=1
         BREAK
      .
   .
   IF ~FOUND#
      KLUDA(0,'Fragments '&clip(KESKA)&' nav atrasts...')
   ELSE
      LocalRequest = OriginalRequest
      BRW1::LocateMode = LocateOnEdit
      DO BRW1::LocateRecord
      DO BRW1::InitializeBrowse
      DO BRW1::PostNewSelection
      DO BRW1::RefreshPage
   .
 .

!---------------------------------------------------------------------------------------------
CHECKKEYS     ROUTINE
     IF DUPLICATE(PAR:NR_KEY)
        PAR:U_NR=0
     .
     IF DUPLICATE(PAR:KARTE_KEY)
        PAR:KARTE=0
     .
     IF DUPLICATE(PAR:NOS_U_KEY)
        PAR:NOS_U=''
     .
     IF DUPLICATE(PAR:NMR_KEY)
        IF PAR:NMR_KODS AND ~PAR:NMR_PLUS
           PAR:NMR_PLUS='A'
        ELSIF PAR:NMR_KODS
           NMR#=0
           LOOP
              PAR:NMR_PLUS=CHR(VAL(PAR:NMR_PLUS)+1)
              IF ~DUPLICATE(PAR:NMR_KEY)
                 BREAK
              .
              NMR#+=1
              IF NMR#>10
                 PAR:NMR_KODS=''
                 PAR:NMR_PLUS=''
                 BREAK
              .
           .
        ELSE
           PAR:NMR_KODS=''
           PAR:NMR_PLUS=''
        .
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
  ELSIF CHOICE(?CurrentTab) = 6
    BRW1::SortOrder = 5
  ELSE
    BRW1::SortOrder = 6
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    END
  ELSE
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:LocatorValue = ''
      BRW1::Sort1:LocatorLength = 0
      PAR:KARTE = BRW1::Sort1:LocatorValue
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      PAR:NMR_KODS = BRW1::Sort2:LocatorValue
    OF 3
      BRW1::Sort3:LocatorValue = ''
      BRW1::Sort3:LocatorLength = 0
      PAR:U_NR = BRW1::Sort3:LocatorValue
    OF 5
      BRW1::Sort5:LocatorValue = ''
      BRW1::Sort5:LocatorLength = 0
      PAR:NOS_A = BRW1::Sort5:LocatorValue
    OF 6
      BRW1::Sort6:LocatorValue = ''
      BRW1::Sort6:LocatorLength = 0
      PAR:NOS_A = BRW1::Sort6:LocatorValue
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
  IF SEND(PAR_K,'QUICKSCAN=on').
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAR_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = PAR:KARTE
  OF 2
    BRW1::Sort2:HighValue = PAR:NMR_KODS
  OF 3
    BRW1::Sort3:HighValue = PAR:U_NR
  OF 4
    BRW1::Sort4:HighValue = PAR:NOS_U
  OF 6
    BRW1::Sort6:HighValue = PAR:NOS_A
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAR_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = PAR:KARTE
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  OF 2
    BRW1::Sort2:LowValue = PAR:NMR_KODS
    SetupStringStops(BRW1::Sort2:LowValue,BRW1::Sort2:HighValue,SIZE(BRW1::Sort2:LowValue),ScrollSort:AllowNumeric)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort2:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  OF 3
    BRW1::Sort3:LowValue = PAR:U_NR
    SetupRealStops(BRW1::Sort3:LowValue,BRW1::Sort3:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort3:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  OF 4
    BRW1::Sort4:LowValue = PAR:NOS_U
    SetupStringStops(BRW1::Sort4:LowValue,BRW1::Sort4:HighValue,SIZE(BRW1::Sort4:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort4:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  OF 6
    BRW1::Sort6:LowValue = PAR:NOS_A
    SetupStringStops(BRW1::Sort6:LowValue,BRW1::Sort6:HighValue,SIZE(BRW1::Sort6:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort6:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  END
  IF SEND(PAR_K,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  PAR:BAITS = BRW1::PAR:BAITS
  PAR:U_NR = BRW1::PAR:U_NR
  PAR:KARTE = BRW1::PAR:KARTE
  PAR:TIPS = BRW1::PAR:TIPS
  PAR:GRUPA = BRW1::PAR:GRUPA
  PAR:NOS_S = BRW1::PAR:NOS_S
  PAR:NOS_P = BRW1::PAR:NOS_P
  PAR:NMR_KODS = BRW1::PAR:NMR_KODS
  PAR:NMR_PLUS = BRW1::PAR:NMR_PLUS
  PAR:ATZIME1 = BRW1::PAR:ATZIME1
  par_atzime1 = BRW1::par_atzime1
  PAR:ATZIME2 = BRW1::PAR:ATZIME2
  PAR:NOS_U = BRW1::PAR:NOS_U
  PAR:KRED_LIM = BRW1::PAR:KRED_LIM
  PAR:ADRESE = BRW1::PAR:ADRESE
  F:ATZIME = BRW1::F:ATZIME
  CP = BRW1::CP
  PAR:NOS_A = BRW1::PAR:NOS_A
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
  par_atzime1=GetPar_Atzime(par:atzime1,1)
  BRW1::PAR:BAITS = PAR:BAITS
  BRW1::PAR:U_NR = PAR:U_NR
  BRW1::PAR:KARTE = PAR:KARTE
  BRW1::PAR:TIPS = PAR:TIPS
  BRW1::PAR:GRUPA = PAR:GRUPA
  BRW1::PAR:NOS_S = PAR:NOS_S
  BRW1::PAR:NOS_P = PAR:NOS_P
  BRW1::PAR:NMR_KODS = PAR:NMR_KODS
  BRW1::PAR:NMR_PLUS = PAR:NMR_PLUS
  BRW1::PAR:ATZIME1 = PAR:ATZIME1
  IF (GETPAR_ATZIME(PAR:ATZIME1,2)='1')
    BRW1::PAR:ATZIME1:NormalFG = 65280
    BRW1::PAR:ATZIME1:NormalBG = -1
    BRW1::PAR:ATZIME1:SelectedFG = 65280
    BRW1::PAR:ATZIME1:SelectedBG = 16777215
  ELSIF (GETPAR_ATZIME(PAR:ATZIME1,2)='2')
    BRW1::PAR:ATZIME1:NormalFG = 255
    BRW1::PAR:ATZIME1:NormalBG = -1
    BRW1::PAR:ATZIME1:SelectedFG = 255
    BRW1::PAR:ATZIME1:SelectedBG = 16777215
  ELSIF (GETPAR_ATZIME(PAR:ATZIME1,2)='3')
    BRW1::PAR:ATZIME1:NormalFG = 16711680
    BRW1::PAR:ATZIME1:NormalBG = -1
    BRW1::PAR:ATZIME1:SelectedFG = 16711680
    BRW1::PAR:ATZIME1:SelectedBG = 16777215
  ELSIF (GETPAR_ATZIME(PAR:ATZIME1,2)='4')
    BRW1::PAR:ATZIME1:NormalFG = 4227327
    BRW1::PAR:ATZIME1:NormalBG = -1
    BRW1::PAR:ATZIME1:SelectedFG = 4227327
    BRW1::PAR:ATZIME1:SelectedBG = -1
  ELSIF (GETPAR_ATZIME(PAR:ATZIME2,2)='2')
    BRW1::PAR:ATZIME1:NormalFG = 255
    BRW1::PAR:ATZIME1:NormalBG = -1
    BRW1::PAR:ATZIME1:SelectedFG = 16777215
    BRW1::PAR:ATZIME1:SelectedBG = -1
  ELSE
    BRW1::PAR:ATZIME1:NormalFG = -1
    BRW1::PAR:ATZIME1:NormalBG = -1
    BRW1::PAR:ATZIME1:SelectedFG = -1
    BRW1::PAR:ATZIME1:SelectedBG = -1
  END
  BRW1::par_atzime1 = par_atzime1
    BRW1::par_atzime1:NormalFG = -1
    BRW1::par_atzime1:NormalBG = -1
    BRW1::par_atzime1:SelectedFG = -1
    BRW1::par_atzime1:SelectedBG = -1
  BRW1::PAR:ATZIME2 = PAR:ATZIME2
  IF (GETPAR_ATZIME(PAR:ATZIME2,2)='2')
    BRW1::PAR:ATZIME2:NormalFG = 255
    BRW1::PAR:ATZIME2:NormalBG = -1
    BRW1::PAR:ATZIME2:SelectedFG = 255
    BRW1::PAR:ATZIME2:SelectedBG = 16777215
  ELSIF (GETPAR_ATZIME(PAR:ATZIME2,2)='1')
    BRW1::PAR:ATZIME2:NormalFG = 65280
    BRW1::PAR:ATZIME2:NormalBG = -1
    BRW1::PAR:ATZIME2:SelectedFG = 65280
    BRW1::PAR:ATZIME2:SelectedBG = 16777215
  ELSIF (GETPAR_ATZIME(PAR:ATZIME2,2)='3')
    BRW1::PAR:ATZIME2:NormalFG = 16711680
    BRW1::PAR:ATZIME2:NormalBG = -1
    BRW1::PAR:ATZIME2:SelectedFG = 16711680
    BRW1::PAR:ATZIME2:SelectedBG = 16777215
  ELSE
    BRW1::PAR:ATZIME2:NormalFG = -1
    BRW1::PAR:ATZIME2:NormalBG = -1
    BRW1::PAR:ATZIME2:SelectedFG = -1
    BRW1::PAR:ATZIME2:SelectedBG = -1
  END
  BRW1::PAR:NOS_U = PAR:NOS_U
  IF (PAR:REDZAMIBA='A')
    BRW1::PAR:NOS_U:NormalFG = 255
    BRW1::PAR:NOS_U:NormalBG = -1
    BRW1::PAR:NOS_U:SelectedFG = 255
    BRW1::PAR:NOS_U:SelectedBG = 16777215
  ELSE
    BRW1::PAR:NOS_U:NormalFG = -1
    BRW1::PAR:NOS_U:NormalBG = -1
    BRW1::PAR:NOS_U:SelectedFG = -1
    BRW1::PAR:NOS_U:SelectedBG = -1
  END
  BRW1::PAR:KRED_LIM = PAR:KRED_LIM
  BRW1::PAR:ADRESE = PAR:ADRESE
  BRW1::F:ATZIME = F:ATZIME
  BRW1::CP = CP
  BRW1::PAR:NOS_A = PAR:NOS_A
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => PAR:KARTE
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
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => UPPER(PAR:NMR_KODS)
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 3
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort3:KeyDistribution[BRW1::CurrentScroll] => PAR:U_NR
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
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort4:KeyDistribution[BRW1::CurrentScroll] => UPPER(PAR:NOS_U)
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 5
      OF 6
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort6:KeyDistribution[BRW1::CurrentScroll] => UPPER(PAR:NOS_A)
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
      PAR:KARTE = BRW1::Sort1:LocatorValue
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      PAR:NMR_KODS = BRW1::Sort2:LocatorValue
    OF 3
      BRW1::Sort3:LocatorValue = ''
      BRW1::Sort3:LocatorLength = 0
      PAR:U_NR = BRW1::Sort3:LocatorValue
    OF 5
      BRW1::Sort5:LocatorValue = ''
      BRW1::Sort5:LocatorLength = 0
      PAR:NOS_A = BRW1::Sort5:LocatorValue
    OF 6
      BRW1::Sort6:LocatorValue = ''
      BRW1::Sort6:LocatorLength = 0
      PAR:NOS_A = BRW1::Sort6:LocatorValue
    END
  CASE BRW1::SortOrder
  OF 5
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
            PAR:KARTE = BRW1::Sort1:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          PAR:KARTE = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          PAR:KARTE = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            PAR:NMR_KODS = BRW1::Sort2:LocatorValue
            CLEAR(PAR:NMR_PLUS)
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          PAR:NMR_KODS = BRW1::Sort2:LocatorValue
          CLEAR(PAR:NMR_PLUS)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          PAR:NMR_KODS = BRW1::Sort2:LocatorValue
          CLEAR(PAR:NMR_PLUS)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 3
        IF KEYCODE() = BSKey
          IF BRW1::Sort3:LocatorLength
            BRW1::Sort3:LocatorLength -= 1
            BRW1::Sort3:LocatorValue = SUB(BRW1::Sort3:LocatorValue,1,BRW1::Sort3:LocatorLength)
            PAR:U_NR = BRW1::Sort3:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort3:LocatorValue = SUB(BRW1::Sort3:LocatorValue,1,BRW1::Sort3:LocatorLength) & ' '
          BRW1::Sort3:LocatorLength += 1
          PAR:U_NR = BRW1::Sort3:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort3:LocatorValue = SUB(BRW1::Sort3:LocatorValue,1,BRW1::Sort3:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort3:LocatorLength += 1
          PAR:U_NR = BRW1::Sort3:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 4
        IF CHR(KEYCHAR())
          IF UPPER(SUB(PAR:NOS_U,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(PAR:NOS_U,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            PAR:NOS_U = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 5
        IF KEYCODE() = BSKey
          IF BRW1::Sort5:LocatorLength
            BRW1::Sort5:LocatorLength -= 1
            BRW1::Sort5:LocatorValue = SUB(BRW1::Sort5:LocatorValue,1,BRW1::Sort5:LocatorLength)
            PAR:NOS_A = BRW1::Sort5:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort5:LocatorValue = SUB(BRW1::Sort5:LocatorValue,1,BRW1::Sort5:LocatorLength) & ' '
          BRW1::Sort5:LocatorLength += 1
          PAR:NOS_A = BRW1::Sort5:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort5:LocatorValue = SUB(BRW1::Sort5:LocatorValue,1,BRW1::Sort5:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort5:LocatorLength += 1
          PAR:NOS_A = BRW1::Sort5:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 6
        IF KEYCODE() = BSKey
          IF BRW1::Sort6:LocatorLength
            BRW1::Sort6:LocatorLength -= 1
            BRW1::Sort6:LocatorValue = SUB(BRW1::Sort6:LocatorValue,1,BRW1::Sort6:LocatorLength)
            PAR:NOS_A = BRW1::Sort6:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort6:LocatorValue = SUB(BRW1::Sort6:LocatorValue,1,BRW1::Sort6:LocatorLength) & ' '
          BRW1::Sort6:LocatorLength += 1
          PAR:NOS_A = BRW1::Sort6:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort6:LocatorValue = SUB(BRW1::Sort6:LocatorValue,1,BRW1::Sort6:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort6:LocatorLength += 1
          PAR:NOS_A = BRW1::Sort6:LocatorValue
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
      PAR:KARTE = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 2
      PAR:NMR_KODS = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 3
      PAR:U_NR = BRW1::Sort3:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 4
      PAR:NOS_U = BRW1::Sort4:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 6
      PAR:NOS_A = BRW1::Sort6:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
    IF SEND(PAR_K,'QUICKSCAN=on').
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
        StandardWarning(Warn:RecordFetchError,'PAR_K')
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
    IF SEND(PAR_K,'QUICKSCAN=off').
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
      BRW1::HighlightedPosition = POSITION(PAR:KARTE_KEY)
      RESET(PAR:KARTE_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PAR:KARTE_KEY,PAR:KARTE_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~CYCLEPAR_K(CP)  AND ~(PAR:REDZAMIBA=''A''))'
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAR:NMR_KEY)
      RESET(PAR:NMR_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PAR:NMR_KEY,PAR:NMR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~CYCLEPAR_K(CP)  AND ~(PAR:REDZAMIBA=''A'') )'
  OF 3
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAR:NR_KEY)
      RESET(PAR:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PAR:NR_KEY,PAR:NR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~CYCLEPAR_K(CP)  AND ~(PAR:REDZAMIBA=''A''))'
  OF 4
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAR:NOS_U_KEY)
      RESET(PAR:NOS_U_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PAR:NOS_U_KEY,PAR:NOS_U_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~CYCLEPAR_K(CP) )'
  OF 5
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAR:NOS_KEY)
      RESET(PAR:NOS_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PAR:NOS_KEY,PAR:NOS_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(PAR:REDZAMIBA=''A'' )'
  OF 6
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAR:NOS_KEY)
      RESET(PAR:NOS_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PAR:NOS_KEY,PAR:NOS_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~CYCLEPAR_K(CP)  AND ~(PAR:REDZAMIBA=''A''))'
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
    OF 1; ?PAR:KARTE{Prop:Disable} = 0
    OF 2; ?PAR:NMR_KODS{Prop:Disable} = 0
    OF 3; ?PAR:U_NR{Prop:Disable} = 0
    OF 5; ?PAR:NOS_A{Prop:Disable} = 0
    OF 6; ?PAR:NOS_A{Prop:Disable} = 0
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
    CLEAR(PAR:Record)
    CASE BRW1::SortOrder
    OF 1; ?PAR:KARTE{Prop:Disable} = 1
    OF 2; ?PAR:NMR_KODS{Prop:Disable} = 1
    OF 3; ?PAR:U_NR{Prop:Disable} = 1
    OF 5; ?PAR:NOS_A{Prop:Disable} = 1
    OF 6; ?PAR:NOS_A{Prop:Disable} = 1
    END
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
  !IF FIRSTLOCATE=TRUE
  !  RESET(PAR_K,PAR_K_POSITION)
  !  NEXT(PAR_K)
  !  FIRSTLOCATE=FALSE
  !.
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    SET(PAR:KARTE_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~CYCLEPAR_K(CP)  AND ~(PAR:REDZAMIBA=''A''))'
  OF 2
    SET(PAR:NMR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~CYCLEPAR_K(CP)  AND ~(PAR:REDZAMIBA=''A'') )'
  OF 3
    SET(PAR:NR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~CYCLEPAR_K(CP)  AND ~(PAR:REDZAMIBA=''A''))'
  OF 4
    SET(PAR:NOS_U_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~CYCLEPAR_K(CP) )'
  OF 5
    SET(PAR:NOS_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(PAR:REDZAMIBA=''A'' )'
  OF 6
    SET(PAR:NOS_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~CYCLEPAR_K(CP)  AND ~(PAR:REDZAMIBA=''A''))'
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
  GET(PAR_K,0)
  CLEAR(PAR:Record,0)
  LocalRequest = InsertRecord
  IF COPYREQUEST=1
     DO SYNCWINDOW
     PAR:U_NR=0
     IF PAR:KARTE
        PAR:KARTE+=1
     .
     IF PAR:NOS_U
        NOSU#=0
        LOOP
           PAR:NOS_U=PAR:NOS_U[1:2]&CHR(VAL(PAR:NOS_U[3])+1)
           IF ~DUPLICATE(PAR:NOS_U_KEY)
              BREAK
           .
           NOSU#+=1
           IF NOSU#>10
              PAR:NOS_U=''
              BREAK
           .
        .
     .
     IF PAR:NMR_KODS AND ~PAR:NMR_PLUS
        PAR:NMR_PLUS='A'
     ELSIF PAR:NMR_KODS
        NMR#=0
        LOOP
           PAR:NMR_PLUS=CHR(VAL(PAR:NMR_PLUS)+1)
           IF ~DUPLICATE(PAR:NMR_KEY)
              BREAK
           .
           NMR#+=1
           IF NMR#>10
              PAR:NMR_KODS=''
              PAR:NMR_PLUS=''
              BREAK
           .
        .
     ELSE
        PAR:NMR_KODS=''
        PAR:NMR_PLUS=''
     .
     IF DUPLICATE(PAR:KARTE_KEY)
        PAR:KARTE=0
     .
  ELSIF COPYREQUEST=2     !Paòemt no citas DB DRAG&DROP
     PAR:RECORD=PAR1:RECORD
     PAR:U_NR=0
     DO CHECKKEYS
  .
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    WriteZurnals(2,1,'PAR_K '&CLIP(PAR:U_NR)&' '&CLIP(PAR:NOS_P))
  .
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
    WriteZurnals(2,2,'PAR_K '&CLIP(PAR:U_NR)&' '&CLIP(PAR:NOS_P))
  .
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
    WriteZurnals(2,3,'PAR_K '&CLIP(PAR:U_NR)&' '&CLIP(PAR:NOS_P))
  .
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
!| (UpdatePAR_K) is called.
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
    UpdatePAR_K
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
        GET(PAR_K,0)
        CLEAR(PAR:Record,0)
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
  COPYREQUEST=0

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


UpdateTex PROCEDURE


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
Update::Reloop  BYTE
Update::Error   BYTE
History::TEX:Record LIKE(TEX:Record),STATIC
SAV::TEX:Record      LIKE(TEX:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:TEX:NR       LIKE(TEX:NR)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('TEKSTI.File'),AT(,,299,131),FONT('MS Sans Serif',8,,FONT:bold),CENTER,IMM,HLP('UpdateTex'),SYSTEM,GRAY,MDI
                       SHEET,AT(4,4,287,100),USE(?CurrentTab)
                         TAB,USE(?Tab:1)
                           STRING(@n13),AT(8,21),USE(TEX:NR)
                           PROMPT('Teksts:'),AT(8,34),USE(?TEX:TEKSTS:Prompt)
                           ENTRY(@s60),AT(41,34,244,10),USE(TEX:TEKSTS1)
                           ENTRY(@s60),AT(41,46,244,10),USE(TEX:TEKSTS2)
                           ENTRY(@s60),AT(41,58,244,10),USE(TEX:TEKSTS3)
                           OPTION('Rîkojuma tips:'),AT(42,71,121,21),USE(TEX:RIK_TIPS),BOXED,HIDE
                             RADIO('Kadri'),AT(46,79),USE(?RIK_TIPS:Radio1)
                             RADIO('Atvaïinâjumi'),AT(78,79),USE(?RIK_TIPS:Radio2)
                             RADIO('Citi'),AT(134,79),USE(?RIK_TIPS:Radio3)
                           END
                           PROMPT('CRM'),AT(174,78),USE(?TEX:BAITS:Prompt),HIDE
                           ENTRY(@n3B),AT(195,78,9,10),USE(TEX:BAITS),HIDE
                         END
                       END
                       BUTTON('&OK'),AT(192,107,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(241,107,45,14),USE(?Cancel)
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
  IF INRANGE(JOB_NR,1,15)  ! Base
     UNHIDE(?TEX:BAITS:PROMPT)
     UNHIDE(?TEX:BAITS)
  .
  IF INRANGE(JOB_NR,16,65) ! Noliktava,Pos
  .
  IF INRANGE(JOB_NR,66,80) ! Alga
     TEX:RIK_TIPS=RIK:TIPS
     IF ~INSTRING(TEX:RIK_TIPS,'IBKAC') THEN TEX:RIK_TIPS='C'.
     IF INSTRING(TEX:RIK_TIPS,'KAC') THEN UNHIDE(?TEX:RIK_TIPS).
     DISABLE(?TEX:RIK_TIPS)
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
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?TEX:NR)
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
        History::TEX:Record = TEX:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(TEKSTI)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(TEX:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'TEX:NR_KEY')
                SELECT(?TEX:NR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?TEX:NR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::TEX:Record <> TEX:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:TEKSTI(1)
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
              SELECT(?TEX:NR)
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
    OF ?TEX:TEKSTS1
      CASE EVENT()
      OF EVENT:Accepted
        TEX:TEX_A=inigen(TEX:TEKSTS1,5,1)
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
        IF INRANGE(JOB_NR,66,80) ! Alga
           !TEX:RIK_TIPS
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
  IF TEKSTI::Used = 0
    CheckOpen(TEKSTI,1)
  END
  TEKSTI::Used += 1
  BIND(TEX:RECORD)
  FilesOpened = True
  RISnap:TEKSTI
  SAV::TEX:Record = TEX:Record
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
        IF RIDelete:TEKSTI()
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
  INIRestoreWindow('UpdateTex','winlats.INI')
  WinResize.Resize
  ?TEX:NR{PROP:Alrt,255} = 734
  ?TEX:TEKSTS1{PROP:Alrt,255} = 734
  ?TEX:TEKSTS2{PROP:Alrt,255} = 734
  ?TEX:TEKSTS3{PROP:Alrt,255} = 734
  ?TEX:RIK_TIPS{PROP:Alrt,255} = 734
  ?TEX:BAITS{PROP:Alrt,255} = 734
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
    TEKSTI::Used -= 1
    IF TEKSTI::Used = 0 THEN CLOSE(TEKSTI).
  END
  IF WindowOpened
    INISaveWindow('UpdateTex','winlats.INI')
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
    OF ?TEX:NR
      TEX:NR = History::TEX:Record.NR
    OF ?TEX:TEKSTS1
      TEX:TEKSTS1 = History::TEX:Record.TEKSTS1
    OF ?TEX:TEKSTS2
      TEX:TEKSTS2 = History::TEX:Record.TEKSTS2
    OF ?TEX:TEKSTS3
      TEX:TEKSTS3 = History::TEX:Record.TEKSTS3
    OF ?TEX:RIK_TIPS
      TEX:RIK_TIPS = History::TEX:Record.RIK_TIPS
    OF ?TEX:BAITS
      TEX:BAITS = History::TEX:Record.BAITS
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
  TEX:Record = SAV::TEX:Record
  SAV::TEX:Record = TEX:Record
  Auto::Attempts = 0
  LOOP
    SET(TEX:NR_KEY)
    PREVIOUS(TEKSTI)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'TEKSTI')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:TEX:NR = 1
    ELSE
      Auto::Save:TEX:NR = TEX:NR + 1
    END
    TEX:Record = SAV::TEX:Record
    TEX:NR = Auto::Save:TEX:NR
    SAV::TEX:Record = TEX:Record
    ADD(TEKSTI)
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
        DELETE(TEKSTI)
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

BrowseTex PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
LOCAL_PATH           CSTRING(100)

BRW1::View:Browse    VIEW(TEKSTI)
                       PROJECT(TEX:NR)
                       PROJECT(TEX:TEKSTS1)
                       PROJECT(TEX:RIK_TIPS)
                       PROJECT(TEX:TEX_A)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::TEX:NR           LIKE(TEX:NR)               ! Queue Display field
BRW1::TEX:TEKSTS1      LIKE(TEX:TEKSTS1)          ! Queue Display field
BRW1::TEX:RIK_TIPS     LIKE(TEX:RIK_TIPS)         ! Queue Display field
BRW1::RIK:TIPS         LIKE(RIK:TIPS)             ! Queue Display field
BRW1::TEX:TEX_A        LIKE(TEX:TEX_A)            ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort2:KeyDistribution LIKE(TEX:TEX_A),DIM(100)
BRW1::Sort2:LowValue LIKE(TEX:TEX_A)              ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(TEX:TEX_A)             ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Tekstu sagataves'),AT(0,0,323,282),FONT('MS Sans Serif',8,,FONT:bold),IMM,HLP('BrowseTEK'),SYSTEM,GRAY,MDI
                       LIST,AT(8,20,297,210),USE(?Browse:1),IMM,VSCROLL,FONT(,8,,),MSG('Browsing Records'),FORMAT('31R(1)|~Nr~C(0)@n_7@100L(1)|~Teksts~@s60@'),FROM(Queue:Browse:1),DROPID('''no TEX1''')
                       BUTTON('Paòemt no citas DB'),AT(50,255,74,14),USE(?ButtonPanemt)
                       SHEET,AT(2,2,310,250),USE(?CurrentTab)
                         TAB('Nosaukumu secîba'),USE(?Tab1)
                         END
                         TAB('Nr secîba'),USE(?Tab2)
                         END
                       END
                       BUTTON('&C-Kopçt'),AT(127,255,45,14),USE(?Kopet)
                       BUTTON('Iz&vçlçties'),AT(175,255),USE(?Select),FONT(,9,COLOR:Navy,FONT:bold),KEY(EnterKey)
                       BUTTON('&Ievadît'),AT(158,234,45,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(208,234,45,14),USE(?Change ),DEFAULT
                       BUTTON('&Dzçst'),AT(256,234,45,14),USE(?Delete:2)
                       BUTTON('&Beigt'),AT(266,257,45,14),USE(?Close)
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
  QuickWindow{PROP:TEXT}='Tekstu plâns '&TEXNAME
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
      OF EVENT:Drop
         TEX1:NR=DROPID()
         GET(TEKSTI1,TEX1:NR_KEY)
         TEX:NR=TEX1:NR
         GET(TEKSTI,TEX:NR_KEY)
         IF ERROR()
            TEX:RECORD=TEX1:RECORD
        !    DO CHECKKEYS
            ADD(TEKSTI)
         ELSE
            KLUDA(0,' U_NR '&TEX:NR&' DB jau eksistç :'&CLIP(TEX:TEKSTS1),8)
            IF KLU_DARBIBA
               COPYREQUEST=2
               DO BRW1::ButtonInsert
            .
         .
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?ButtonPanemt
      CASE EVENT()
      OF EVENT:Accepted
          LOCAL_path=PATH()
          Filename1=''
          IF FILEDIALOG('Izvçlaties failu',FileName1,'Visi TEX_NOL.TPS|TEX_NOL*.TPS',0)
             setpath(local_path)
             CHECKOPEN(TEKSTI1,1)
             THREAD#=START(BROWSETEX1,50000)
          .
          setpath(local_path)
                 
        DO SyncWindow
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
    OF ?Kopet
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
  IF KAD_RIK::Used = 0
    CheckOpen(KAD_RIK,1)
  END
  KAD_RIK::Used += 1
  BIND(RIK:RECORD)
  IF TEKSTI::Used = 0
    CheckOpen(TEKSTI,1)
  END
  TEKSTI::Used += 1
  BIND(TEX:RECORD)
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
    KAD_RIK::Used -= 1
    IF KAD_RIK::Used = 0 THEN CLOSE(KAD_RIK).
    TEKSTI::Used -= 1
    IF TEKSTI::Used = 0 THEN CLOSE(TEKSTI).
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
  IF CHOICE(?CURRENTTAB)=2
    BRW1::SortOrder = 1
  ELSE
    BRW1::SortOrder = 2
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    END
  ELSE
    CASE BRW1::SortOrder
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      TEX:TEX_A = BRW1::Sort2:LocatorValue
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
      StandardWarning(Warn:RecordFetchError,'TEKSTI')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:HighValue = TEX:TEX_A
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'TEKSTI')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:LowValue = TEX:TEX_A
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
  TEX:NR = BRW1::TEX:NR
  TEX:TEKSTS1 = BRW1::TEX:TEKSTS1
  TEX:RIK_TIPS = BRW1::TEX:RIK_TIPS
  RIK:TIPS = BRW1::RIK:TIPS
  TEX:TEX_A = BRW1::TEX:TEX_A
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
  BRW1::TEX:NR = TEX:NR
  BRW1::TEX:TEKSTS1 = TEX:TEKSTS1
  BRW1::TEX:RIK_TIPS = TEX:RIK_TIPS
  BRW1::RIK:TIPS = RIK:TIPS
  BRW1::TEX:TEX_A = TEX:TEX_A
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
      POST(Event:Accepted,?Change )
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
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => UPPER(TEX:TEX_A)
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
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      TEX:TEX_A = BRW1::Sort2:LocatorValue
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
      POST(Event:Accepted,?Change )
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
    OF DeleteKey
      POST(Event:Accepted,?Delete:2)
    OF CtrlEnter
      POST(Event:Accepted,?Change )
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          IF UPPER(SUB(TEX:NR,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(TEX:NR,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            TEX:NR = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            TEX:TEX_A = BRW1::Sort2:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          TEX:TEX_A = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          TEX:TEX_A = BRW1::Sort2:LocatorValue
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
      TEX:TEX_A = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'TEKSTI')
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
      BRW1::HighlightedPosition = POSITION(TEX:NR_KEY)
      RESET(TEX:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(TEX:NR_KEY,TEX:NR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = ''
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(TEX:TEX_KEY)
      RESET(TEX:TEX_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(TEX:TEX_KEY,TEX:TEX_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~TEX:RIK_TIPS OR (TEX:RIK_TIPS =RIK:TIPS))'
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
    ?Change {Prop:Disable} = 0
    ?Delete:2{Prop:Disable} = 0
  ELSE
    CLEAR(TEX:Record)
    BRW1::CurrentChoice = 0
    ?Change {Prop:Disable} = 1
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
    SET(TEX:NR_KEY)
    BRW1::View:Browse{Prop:Filter} = ''
  OF 2
    SET(TEX:TEX_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~TEX:RIK_TIPS OR (TEX:RIK_TIPS =RIK:TIPS))'
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
  GET(TEKSTI,0)
  CLEAR(TEX:Record,0)
  LocalRequest = InsertRecord
  IF Copyrequest=1
     DO SYNCWINDOW
     TEX:NR=0
  .
  IF Copyrequest=2
     TEX:RECORD=TEX1:RECORD
     TEX:NR=0
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
!| (UpdateTex) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateTex
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
        GET(TEKSTI,0)
        CLEAR(TEX:Record,0)
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


