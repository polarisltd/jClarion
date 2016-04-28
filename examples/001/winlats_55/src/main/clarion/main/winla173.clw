                     MEMBER('winlats.clw')        ! This is a MEMBER module
BrowseAU_BILDE PROCEDURE


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
AUB_DATUMS           STRING(11)
sav_position         STRING(256)
LIST                 BYTE
C                    BYTE
AUT_TEXT             STRING(10),DIM(11)
DATUMS        ULONG
PLKST         STRING(5)
PLKST1        STRING(5)
AUB_AUT_TEXT  STRING(10)
SAV_AUT_TEXT  STRING(10)
!AUB_AUT_TEXT2 STRING(20)
AUB_STATUSS   BYTE
AUB_PAV_NR    ULONG

KESKA         CSTRING(11)
SEARCHMODE    BYTE
SOLI          BYTE

NEW_VIETA_NR  LIKE(VIETA_NR)
NEW_DATUMS    LONG
NEW_PLKST_P   ULONG

PRO_NOS_P     STRING(10),DIM(22)

KESKAwindow WINDOW('Izvçles logs'),AT(,,179,63),GRAY
       STRING('Meklçjamâs a/m numura fragments:'),AT(1,25,124,10),USE(?StringMEKL),RIGHT(1)
       ENTRY(@s8),AT(128,24),USE(keska)
       BUTTON('&OK'),AT(98,42,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(136,42,36,14),USE(?CancelButton)
     END

MOVEHwindow WINDOW('Izvçles logs'),AT(,,179,63),GRAY
       STRING('Pârvietot uz Darba vietu Nr:'),AT(18,25,98,10),USE(?StringPARV),RIGHT(1)
       ENTRY(@N2),AT(123,22),USE(KESKA,,?keska:2)
       BUTTON('&OK'),AT(98,42,35,14),USE(?OkButtonMOVEH),DEFAULT
       BUTTON('&Atlikt'),AT(136,42,36,14),USE(?CancelButtonMOVEH)
     END

MOVEVwindow WINDOW('Izvçles logs'),AT(,,174,57),GRAY
       STRING('Pârvietot uz Datumu :'),AT(38,12,79,10),USE(?StringPARVdat),RIGHT(1)
       ENTRY(@D06.),AT(123,10,42,12),USE(NEW_DATUMS),CENTER
       STRING('Plkst :'),AT(93,26,25,10),USE(?StringPARVplkst),RIGHT(1)
       ENTRY(@T1),AT(123,24,27,10),USE(NEW_PLKST_P)
       BUTTON('&OK'),AT(98,42,35,14),USE(?OkButtonMOVEV),DEFAULT
       BUTTON('&Atlikt'),AT(136,42,36,14),USE(?CancelButtonMOVEV)
     END

SHOWSCREEN1 WINDOW('Bûvçju .....'),AT(,,106,35),CENTER,GRAY
       STRING(@N_2),AT(43,3),USE(DIENA#)
       STRING(@d06.),AT(22,13),USE(AUB:DATUMS,,?AUB:DATUMS:S)
       STRING(@T1),AT(68,13),USE(AUB:PLKST_P)
     END


BRW1::View:Browse    VIEW(AU_BILDE)
                       PROJECT(AUB:DATUMS)
                       PROJECT(AUB:PLKST_P)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::AUB_DATUMS       LIKE(AUB_DATUMS)           ! Queue Display field
BRW1::AUB_DATUMS:NormalFG LONG                    ! Normal Foreground
BRW1::AUB_DATUMS:NormalBG LONG                    ! Normal Background
BRW1::AUB_DATUMS:SelectedFG LONG                  ! Selected Foreground
BRW1::AUB_DATUMS:SelectedBG LONG                  ! Selected Background
BRW1::AUB:PLKST_P      LIKE(AUB:PLKST_P)          ! Queue Display field
BRW1::AUB:PLKST_P:NormalFG LONG                   ! Normal Foreground
BRW1::AUB:PLKST_P:NormalBG LONG                   ! Normal Background
BRW1::AUB:PLKST_P:SelectedFG LONG                 ! Selected Foreground
BRW1::AUB:PLKST_P:SelectedBG LONG                 ! Selected Background
BRW1::AUT_TEXT_1_      LIKE(AUT_TEXT[1])          ! Queue Display field
BRW1::AUT_TEXT_1_:NormalFG LONG                   ! Normal Foreground
BRW1::AUT_TEXT_1_:NormalBG LONG                   ! Normal Background
BRW1::AUT_TEXT_1_:SelectedFG LONG                 ! Selected Foreground
BRW1::AUT_TEXT_1_:SelectedBG LONG                 ! Selected Background
BRW1::AUT_TEXT_2_      LIKE(AUT_TEXT[2])          ! Queue Display field
BRW1::AUT_TEXT_2_:NormalFG LONG                   ! Normal Foreground
BRW1::AUT_TEXT_2_:NormalBG LONG                   ! Normal Background
BRW1::AUT_TEXT_2_:SelectedFG LONG                 ! Selected Foreground
BRW1::AUT_TEXT_2_:SelectedBG LONG                 ! Selected Background
BRW1::AUT_TEXT_3_      LIKE(AUT_TEXT[3])          ! Queue Display field
BRW1::AUT_TEXT_3_:NormalFG LONG                   ! Normal Foreground
BRW1::AUT_TEXT_3_:NormalBG LONG                   ! Normal Background
BRW1::AUT_TEXT_3_:SelectedFG LONG                 ! Selected Foreground
BRW1::AUT_TEXT_3_:SelectedBG LONG                 ! Selected Background
BRW1::AUT_TEXT_4_      LIKE(AUT_TEXT[4])          ! Queue Display field
BRW1::AUT_TEXT_4_:NormalFG LONG                   ! Normal Foreground
BRW1::AUT_TEXT_4_:NormalBG LONG                   ! Normal Background
BRW1::AUT_TEXT_4_:SelectedFG LONG                 ! Selected Foreground
BRW1::AUT_TEXT_4_:SelectedBG LONG                 ! Selected Background
BRW1::AUT_TEXT_5_      LIKE(AUT_TEXT[5])          ! Queue Display field
BRW1::AUT_TEXT_5_:NormalFG LONG                   ! Normal Foreground
BRW1::AUT_TEXT_5_:NormalBG LONG                   ! Normal Background
BRW1::AUT_TEXT_5_:SelectedFG LONG                 ! Selected Foreground
BRW1::AUT_TEXT_5_:SelectedBG LONG                 ! Selected Background
BRW1::AUT_TEXT_6_      LIKE(AUT_TEXT[6])          ! Queue Display field
BRW1::AUT_TEXT_6_:NormalFG LONG                   ! Normal Foreground
BRW1::AUT_TEXT_6_:NormalBG LONG                   ! Normal Background
BRW1::AUT_TEXT_6_:SelectedFG LONG                 ! Selected Foreground
BRW1::AUT_TEXT_6_:SelectedBG LONG                 ! Selected Background
BRW1::AUT_TEXT_7_      LIKE(AUT_TEXT[7])          ! Queue Display field
BRW1::AUT_TEXT_7_:NormalFG LONG                   ! Normal Foreground
BRW1::AUT_TEXT_7_:NormalBG LONG                   ! Normal Background
BRW1::AUT_TEXT_7_:SelectedFG LONG                 ! Selected Foreground
BRW1::AUT_TEXT_7_:SelectedBG LONG                 ! Selected Background
BRW1::AUT_TEXT_8_      LIKE(AUT_TEXT[8])          ! Queue Display field
BRW1::AUT_TEXT_8_:NormalFG LONG                   ! Normal Foreground
BRW1::AUT_TEXT_8_:NormalBG LONG                   ! Normal Background
BRW1::AUT_TEXT_8_:SelectedFG LONG                 ! Selected Foreground
BRW1::AUT_TEXT_8_:SelectedBG LONG                 ! Selected Background
BRW1::AUT_TEXT_9_      LIKE(AUT_TEXT[9])          ! Queue Display field
BRW1::AUT_TEXT_9_:NormalFG LONG                   ! Normal Foreground
BRW1::AUT_TEXT_9_:NormalBG LONG                   ! Normal Background
BRW1::AUT_TEXT_9_:SelectedFG LONG                 ! Selected Foreground
BRW1::AUT_TEXT_9_:SelectedBG LONG                 ! Selected Background
BRW1::AUT_TEXT_10_     LIKE(AUT_TEXT[10])         ! Queue Display field
BRW1::AUT_TEXT_10_:NormalFG LONG                  ! Normal Foreground
BRW1::AUT_TEXT_10_:NormalBG LONG                  ! Normal Background
BRW1::AUT_TEXT_10_:SelectedFG LONG                ! Selected Foreground
BRW1::AUT_TEXT_10_:SelectedBG LONG                ! Selected Background
BRW1::AUT_TEXT_11_     LIKE(AUT_TEXT[11])         ! Queue Display field
BRW1::AUT_TEXT_11_:NormalFG LONG                  ! Normal Foreground
BRW1::AUT_TEXT_11_:NormalBG LONG                  ! Normal Background
BRW1::AUT_TEXT_11_:SelectedFG LONG                ! Selected Foreground
BRW1::AUT_TEXT_11_:SelectedBG LONG                ! Selected Background
BRW1::AUB:DATUMS       LIKE(AUB:DATUMS)           ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(AUB:DATUMS),DIM(100)
BRW1::Sort1:LowValue LIKE(AUB:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(AUB:DATUMS)            ! Queue position of scroll thumb
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
QuickWindow          WINDOW('aubixx.tps'),AT(0,0,580,380),FONT('MS Sans Serif',8,,FONT:bold,CHARSET:BALTIC),IMM,SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&5-Speciâlâs funkcijas'),USE(?5Speciâlâsfunkcijas)
                           ITEM('&0-Pârbaudît tekoðo mçnesi'),USE(?5Speciâlâsfunkcijas0Pârbaudîttekoðomçnesi)
                           ITEM('&1-Uzbûvçt nâkoðo mçnesi'),USE(?5SF1UzbNM)
                           ITEM('&2-Atrast a/m uz leju no tekoðâ raksta'),USE(?ItemAtrastAM)
                           ITEM('&3-Atrast P/Z U_Nr uz leju no tekoðâ raksta'),USE(?5Speciâlâsfunkcijas3AtrastPZUNruzlejunotekoðâra)
                           ITEM('&4-Pârbîdît Horizontâli'),USE(?5Speciâlâsfunkcijas4PârbîdîtHorizontâli)
                           ITEM('&5-Pârbîdît Vertikâli'),USE(?5Speciâlâsfunkcijas5PârbîdîtVertikâli)
                         END
                       END
                       OPTION('tekoðâ darba vieta'),AT(89,1,486,30),USE(VIETA_NR),BOXED
                         RADIO,AT(93,12,22,17),USE(?VIETA_NR:Radio:1),ICON(ICON:New),VALUE(' ')
                         RADIO,AT(138,13,22,17),USE(?VIETA_NR:Radio:2),ICON(ICON:New)
                         RADIO,AT(185,13,22,17),USE(?VIETA_NR:Radio:3),ICON(ICON:New),VALUE(' ')
                         RADIO,AT(230,12,22,17),USE(?VIETA_NR:Radio:4),ICON(ICON:New),VALUE(' ')
                         RADIO,AT(273,12,22,17),USE(?VIETA_NR:Radio:5),ICON(ICON:New)
                         RADIO,AT(321,13,22,17),USE(?VIETA_NR:Radio:6),ICON(ICON:New)
                         RADIO,AT(366,13,22,17),USE(?VIETA_NR:Radio:7),ICON(ICON:New)
                         RADIO,AT(413,13,22,17),USE(?VIETA_NR:Radio:8),ICON(ICON:New)
                         RADIO,AT(457,12,22,17),USE(?VIETA_NR:Radio:9),ICON(ICON:New)
                         RADIO,AT(503,12,22,17),USE(?VIETA_NR:Radio:10),ICON(ICON:New)
                         RADIO,AT(543,12,22,17),USE(?VIETA_NR:Radio:11),ICON(ICON:New)
                       END
                       LIST,AT(3,31,572,321),USE(?Browse:1),IMM,VSCROLL,FONT('MS Sans Serif',11,,FONT:bold,CHARSET:BALTIC),MSG('Browsing Records'),FORMAT('44CM*~Datums~@s11@23C|M*~Plkst.~@T1B@45C|M*~1~@s10@45C|M*~2~@s10@45C|M*~3~@s10@4' &|
   '5C|M*~4~@s10@45C|M*~5~@s10@45C|M*~6~@s10@45C|M*~7~@s10@45C|M*~8~@s10@45C|M*~9~@s' &|
   '10@45C|M*~10~@s10@45C|M*~11~@s10@'),FROM(Queue:Browse:1)
                       SHEET,AT(-4,17,579,338),USE(?CurrentTab)
                         TAB('   Plânotâjs(1-11)'),USE(?Tab1),COLOR(,COLOR:Red)
                         END
                         TAB('(12-22)'),USE(?Tab2),COLOR(,COLOR:Red)
                         END
                       END
                       ENTRY(@D06.b),AT(10,360,60,13),USE(AUB:DATUMS)
                       BUTTON('&Mainît(Aizpildît)  Grafiku'),AT(98,360,93,14),USE(?Change:2),DEFAULT
                       BUTTON('&Ievadît '),AT(413,360,47,14),USE(?Insert:3)
                       BUTTON('&Dzçst '),AT(461,360,47,14),USE(?Delete:3)
                       BUTTON('&Atvçrt(Mainît) P(R)ojektu'),AT(194,360,92,14),USE(?ButtonOpenPRojekts)
                       BUTTON('&Servisa L/P/A'),AT(289,360,70,14),USE(?ButtonSPA)
                       BUTTON('&Beigt'),AT(518,360,45,14),USE(?Close)
                       STRING('-ddmm'),AT(75,364),USE(?String1)
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
  PRO:NOS_A='DV:'
  SET(PRO:NOS_KEY,PRO:NOS_KEY)
  LOOP
     NEXT(PROJEKTI)
     IF ERROR() OR ~(PRO:NOS_P[1:3]='DV:') THEN BREAK.
     VN#=PRO:NOS_P[4:5]
     LOC_NR#=PRO:NOS_P[6:7]
     IF INRANGE(VN#,1,22) AND LOC_NR#=LOC_NR
        PRO_NOS_P[VN#]=PRO:NOS_P[8:17]          !aizpildam DV vârdus
     .
  .
  IF RECORDS(AU_bilde)=0
     OPEN(SHOWSCREEN1)
     LOOP DIENA#=1 TO 31
        DATUMS=DATE(MONTH(TODAY()),DIENA#,YEAR(TODAY()))
        IF MONTH(DATUMS)>MONTH(TODAY()) THEN BREAK.  !UZBÛVÇJAM TEKOÐO MÇNESI
  !      DATUMS=TODAY()
        DO FILLDAY
     .
     CLOSE(SHOWSCREEN1)
  .
  IF ~VIETA_NR THEN VIETA_NR=1.
  IF ~LIST THEN LIST=1.
  LOOP VN#=1 TO 11  !11 VIETAS UZ 1 EKRÂNA
     IF PRO_NOS_P[VN#]
        ?Browse:1{PROPLIST:HEADER,VN#+2}=PRO_NOS_P[VN#]
     ELSE
        ?Browse:1{PROPLIST:HEADER,VN#+2}=VN#
     .
  .
  IF PAV::U_NR   !TIEK SAUKTS NO P/Z
     DISABLE(?BUTTONOpenPRojekts)
  .
  ACCEPT
    ?vieta_nr:Radio:1{PROP:COLOR}=COLOR:NONE
    ?vieta_nr:Radio:2{PROP:COLOR}=COLOR:NONE
    ?vieta_nr:Radio:3{PROP:COLOR}=COLOR:NONE
    ?vieta_nr:Radio:4{PROP:COLOR}=COLOR:NONE
    ?vieta_nr:Radio:5{PROP:COLOR}=COLOR:NONE
    ?vieta_nr:Radio:6{PROP:COLOR}=COLOR:NONE
    ?vieta_nr:Radio:7{PROP:COLOR}=COLOR:NONE
    ?vieta_nr:Radio:8{PROP:COLOR}=COLOR:NONE
    ?vieta_nr:Radio:9{PROP:COLOR}=COLOR:NONE
    ?vieta_nr:Radio:10{PROP:COLOR}=COLOR:NONE
    ?vieta_nr:Radio:11{PROP:COLOR}=COLOR:NONE
    EXECUTE VIETA_NR-C
       ?vieta_nr:Radio:1{PROP:COLOR}=COLOR:RED
       ?vieta_nr:Radio:2{PROP:COLOR}=COLOR:RED
       ?vieta_nr:Radio:3{PROP:COLOR}=COLOR:RED
       ?vieta_nr:Radio:4{PROP:COLOR}=COLOR:RED
       ?vieta_nr:Radio:5{PROP:COLOR}=COLOR:RED
       ?vieta_nr:Radio:6{PROP:COLOR}=COLOR:RED
       ?vieta_nr:Radio:7{PROP:COLOR}=COLOR:RED
       ?vieta_nr:Radio:8{PROP:COLOR}=COLOR:RED
       ?vieta_nr:Radio:9{PROP:COLOR}=COLOR:RED
       ?vieta_nr:Radio:10{PROP:COLOR}=COLOR:RED
       ?vieta_nr:Radio:11{PROP:COLOR}=COLOR:RED
    .
    CASE EVENT()
    OF EVENT:AlertKey
!      IF KEYCODE()=AltMouseLeft
!         STOP(FIELD())
!      .
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      QuickWindow{PROP:TEXT}=CLIP(AUBNAME)&'.tps'
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?VIETA_NR:Radio:1)
         CLEAR(AUB:RECORD)
         FOUND#=FALSE
         IF PAV::U_NR  !TIEK SAUKTS NO P/Z
            AUB:DATUMS=PAV:DATUMS
            SET(AUB:DAT_KEY,AUB:DAT_KEY)
            LOOP
               NEXT(AU_BILDE)
               IF ERROR() OR ~INRANGE(AUB:DATUMS,PAV:DATUMS,PAV:DATUMS+1) THEN BREAK.
               LOOP I#=1 TO 11  !11 DARBA VIETAS UZ 1 EKRÂNA
                  IF AUB:PAV_NR[I#]=PAV::U_NR
                     VIETA_NR=I#
                     FOUND#=TRUE
                     BREAK
                  .
               .
               IF FOUND#=TRUE THEN BREAK.
            .
            IF FOUND#=FALSE
               KLUDA(0,FORMAT(PAV:DATUMS,@D06.)&' U_Nr='&PAV::U_NR&' nav atrasts')
            .
         ELSE
            AUB:DATUMS=TODAY()
            PLKST=FORMAT(CLOCK(),@T1)         !LAI KURSORS NOSTÂTOS UZ TUVÂKÂ IESPÇJAMÂ PULKSTEÒA
            H#=PLKST[1:2]
             IF H#>UDL_B
                AUB:PLKST_P=UDL_B
             ELSIF H#<UDL_S
                AUB:PLKST_P=UDL_S
             ELSE
      !      IF H#>15 AND AUB:DATUMS%7+1 = 7   !SESTDIENA
      !         PLKST='15:30'
      !      ELSIF H#<9 AND AUB:DATUMS%7+1 = 1 !SVÇTDIENA
      !         PLKST='09:00'
      !      ELSIF H#>19
      !         PLKST='19:30'
      !      ELSIF H#<8
      !         PLKST='08:00'
      !      ELSE
               I#=PLKST[4:5]
               IF I#<30
                  PLKST[4:5]='00'
               ELSE
                  PLKST[4:5]='30'
               .
               AUB:PLKST_P=DEFORMAT(PLKST,@T1)
            .
            SET(AUB:DAT_KEY,AUB:DAT_KEY)
            NEXT(AU_BILDE)    !TO AUB:DATUMS VIÒÐ ATCERAS, PAT JA NAV ATRASTS.....
            IF ERROR() OR ~(AUB:DATUMS=TODAY())
                KLUDA(0,FORMAT(TODAY(),@D06.)&' '&PLKST&' grafiks vçl nab bûvçts')
            .
         .
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
      !   DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         DO RefreshWindow
         ?Browse:1{PROPLIST:HEADER,1}='Datums' !Lai piespiestu pârlasît ekrânu
      
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
    CASE ACCEPTED()
    OF ?5Speciâlâsfunkcijas0Pârbaudîttekoðomçnesi
      DO SyncWindow
      MEN_NR=MONTH(AUB:DATUMS)
      GADS=YEAR(AUB:DATUMS)
      OPEN(SHOWSCREEN1)
      LOOP DIENA#=1 TO 31
         DATUMS=DATE(MEN_NR,DIENA#,GADS)
         IF MONTH(DATUMS)>MEN_NR THEN BREAK.
         DO FILLDAY
         IF LOCALRESPONSE=REQUESTCANCELLED THEN BREAK.
      .
      CLOSE(SHOWSCREEN1)
      BRW1::LocateMode = LocateOnEdit
      DO BRW1::LocateRecord
      DO BRW1::RefreshPage
      DO BRW1::InitializeBrowse
      DO BRW1::PostNewSelection
      SELECT(?Browse:1)
      LocalRequest = OriginalRequest
      LocalResponse = RequestCancelled
      DO RefreshWindow
    OF ?5SF1UzbNM
      DO SyncWindow
      !CLEAR(AUB:RECORD)
      SET(AUB:DAT_KEY)
      PREVIOUS(AU_BILDE)
      MEN_NR=MONTH(AUB:DATUMS)+1
      GADS=YEAR(AUB:DATUMS)
      OPEN(SHOWSCREEN1)
      LOOP DIENA#=1 TO 31
         DATUMS=DATE(MEN_NR,DIENA#,GADS)
         IF MONTH(DATUMS)>MEN_NR THEN BREAK.
         DO FILLDAY
         IF LOCALRESPONSE=REQUESTCANCELLED THEN BREAK.
      .
      CLOSE(SHOWSCREEN1)
      BRW1::LocateMode = LocateOnEdit
      DO BRW1::LocateRecord
      DO BRW1::RefreshPage
      DO BRW1::InitializeBrowse
      DO BRW1::PostNewSelection
      SELECT(?Browse:1)
      LocalRequest = OriginalRequest
      LocalResponse = RequestCancelled
      DO RefreshWindow
    OF ?ItemAtrastAM
      DO SyncWindow
      SEARCHMODE=1
      DO SEARCHKESKA
    OF ?5Speciâlâsfunkcijas3AtrastPZUNruzlejunotekoðâra
      SEARCHMODE=2
      DO SEARCHKESKA
      DO SyncWindow
    OF ?5Speciâlâsfunkcijas4PârbîdîtHorizontâli
      DO SyncWindow
      KESKA=VIETA_NR
      DO MOVEBLOCKH
    OF ?5Speciâlâsfunkcijas5PârbîdîtVertikâli
      DO SyncWindow
      NEW_DATUMS=TODAY()
      NEW_PLKST_P=DEFORMAT('09:00',@T1)
      DO MOVEBLOCKV
    END
    CASE FIELD()
    OF ?VIETA_NR:Radio:1
      CASE EVENT()
      END
        VIETA_NR=1+C
        CLOSE(BRW1::View:Browse)
        DO BRW1::Reset
      !  IF GlobalResponse = RequestCompleted
      !    BRW1::LocateMode = LocateOnEdit
      !    DO BRW1::LocateRecord
      !  ELSE
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
      !  END
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
    OF ?VIETA_NR:Radio:2
      CASE EVENT()
      END
        VIETA_NR=2+C
        CLOSE(BRW1::View:Browse)
        DO BRW1::Reset
      !  IF GlobalResponse = RequestCompleted
      !    BRW1::LocateMode = LocateOnEdit
      !    DO BRW1::LocateRecord
      !  ELSE
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
      !  END
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
    OF ?VIETA_NR:Radio:3
      CASE EVENT()
      END
        VIETA_NR=3+C
        CLOSE(BRW1::View:Browse)
        DO BRW1::Reset
      !  IF GlobalResponse = RequestCompleted
      !    BRW1::LocateMode = LocateOnEdit
      !    DO BRW1::LocateRecord
      !  ELSE
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
      !  END
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
    OF ?VIETA_NR:Radio:4
      CASE EVENT()
      END
        VIETA_NR=4+C
        CLOSE(BRW1::View:Browse)
        DO BRW1::Reset
      !  IF GlobalResponse = RequestCompleted
      !    BRW1::LocateMode = LocateOnEdit
      !    DO BRW1::LocateRecord
      !  ELSE
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
      !  END
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
    OF ?VIETA_NR:Radio:5
      CASE EVENT()
      END
        VIETA_NR=5+C
        CLOSE(BRW1::View:Browse)
        DO BRW1::Reset
      !  IF GlobalResponse = RequestCompleted
      !    BRW1::LocateMode = LocateOnEdit
      !    DO BRW1::LocateRecord
      !  ELSE
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
      !  END
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
    OF ?VIETA_NR:Radio:6
      CASE EVENT()
      END
        VIETA_NR=6+C
        CLOSE(BRW1::View:Browse)
        DO BRW1::Reset
      !  IF GlobalResponse = RequestCompleted
      !    BRW1::LocateMode = LocateOnEdit
      !    DO BRW1::LocateRecord
      !  ELSE
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
      !  END
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
    OF ?VIETA_NR:Radio:7
      CASE EVENT()
      END
        VIETA_NR=7+C
        CLOSE(BRW1::View:Browse)
        DO BRW1::Reset
      !  IF GlobalResponse = RequestCompleted
      !    BRW1::LocateMode = LocateOnEdit
      !    DO BRW1::LocateRecord
      !  ELSE
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
      !  END
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
    OF ?VIETA_NR:Radio:8
      CASE EVENT()
      END
        VIETA_NR=8+C
        CLOSE(BRW1::View:Browse)
        DO BRW1::Reset
      !  IF GlobalResponse = RequestCompleted
      !    BRW1::LocateMode = LocateOnEdit
      !    DO BRW1::LocateRecord
      !  ELSE
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
      !  END
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
    OF ?VIETA_NR:Radio:9
      CASE EVENT()
      END
        VIETA_NR=9+C
        CLOSE(BRW1::View:Browse)
        DO BRW1::Reset
      !  IF GlobalResponse = RequestCompleted
      !    BRW1::LocateMode = LocateOnEdit
      !    DO BRW1::LocateRecord
      !  ELSE
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
      !  END
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
    OF ?VIETA_NR:Radio:10
      CASE EVENT()
      END
        VIETA_NR=10+C
        CLOSE(BRW1::View:Browse)
        DO BRW1::Reset
      !  IF GlobalResponse = RequestCompleted
      !    BRW1::LocateMode = LocateOnEdit
      !    DO BRW1::LocateRecord
      !  ELSE
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
      !  END
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
    OF ?VIETA_NR:Radio:11
      CASE EVENT()
      END
        VIETA_NR=11+C
        CLOSE(BRW1::View:Browse)
        DO BRW1::Reset
      !  IF GlobalResponse = RequestCompleted
      !    BRW1::LocateMode = LocateOnEdit
      !    DO BRW1::LocateRecord
      !  ELSE
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
      !  END
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
        DO RefreshWindow
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
          EXECUTE LIST
             BEGIN
                VIETA_NR=12
                DO LIST2
             .
             BEGIN
                VIETA_NR=1
                DO LIST1
             .
          .
          CLOSE(BRW1::View:Browse)
          DO BRW1::Reset
          BRW1::RefreshMode = RefreshOnQueue
          DO BRW1::RefreshPage
          DO BRW1::InitializeBrowse
          DO BRW1::PostNewSelection
          SELECT(?Browse:1)
          LocalRequest = OriginalRequest
          LocalResponse = RequestCancelled
          DO RefreshWindow
          DISPLAY
        
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?AUB:DATUMS
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?AUB:DATUMS)
        IF AUB:DATUMS
          CLEAR(AUB:PLKST_P)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?Change:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Insert:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = InsertRecord
        UpdateAU_BILDE 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GlobalResponse = RequestCompleted
           BRW1::LocateMode = LocateOnEdit
           DO BRW1::LocateRecord
           !DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
        .
        
        
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
         KLUDA(0,'Jûs esat izvçlçjies dzçst izgaismoto ierakstu, apdomâjiet, pirms apstipriniet')
        DO SyncWindow
        GlobalRequest = DeleteRecord
        UpdateAU_BILDE 
        LocalRequest = OriginalRequest
        DO RefreshWindow
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
        
        
      END
    OF ?ButtonOpenPRojekts
      CASE EVENT()
      OF EVENT:Accepted
        DO SYNCWINDOW
        DO SyncWindow
           DO PERFORMPAVAD
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
           DISPLAY
      END
    OF ?ButtonSPA
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !DO SYNCWINDOW
        IF AUB:STATUSS[VIETA_NR]=9 !DIENAS VIRSRAKSTS
           KLUDA(0,'Nolieciet kursoru uz pasûtîjuma, norâdiet darba vietu')
           CYCLE
        .
        !IF ~AUB:PAV_NR[VIETA_NR] AND ~PAV::U_NR  !TIEK SAUKTS NO FAILIEM
        IF ~AUB:PAV_NR[VIETA_NR]
           KLUDA(0,'Vieta '&clip(vieta_nr)&' plkst.'&format(AUB:PLKST_P,@T1)&' Vçl nav atvçrts P(R)ojekts...')
           CYCLE
        ELSE
           CLEAR(PAV:RECORD)
           PAV:U_NR=AUB:PAV_NR[VIETA_NR]
           GET(PAVAD,PAV:NR_KEY)
           IF ERROR()
              KLUDA(0,'P(R)ojekts '&CLIP(PAV:U_NR)&' nav atrasts...')
              CYCLE
           ELSE
              selpz
           .
        .
        SELECT(?Browse:1)
        LocalRequest = OriginalRequest
        LocalResponse = RequestCancelled
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
  IF AU_BILDE::Used = 0
    CheckOpen(AU_BILDE,1)
  END
  AU_BILDE::Used += 1
  BIND(AUB:RECORD)
  IF PROJEKTI::Used = 0
    CheckOpen(PROJEKTI,1)
  END
  PROJEKTI::Used += 1
  BIND(PRO:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowseAU_BILDE','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  ALERT(AltMouseLeft)
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
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
    AU_BILDE::Used -= 1
    IF AU_BILDE::Used = 0 THEN CLOSE(AU_BILDE).
    PROJEKTI::Used -= 1
    IF PROJEKTI::Used = 0 THEN CLOSE(PROJEKTI).
  END
  IF WindowOpened
    INISaveWindow('BrowseAU_BILDE','winlats.INI')
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
    BRW1::Sort1:LocatorValue = AUB:DATUMS
    CLEAR(AUB:DATUMS)
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
FILLDAY  ROUTINE
 LOCALRESPONSE=REQUESTCOMPLETED
 SHOWSCREEN1{PROP:TEXT}='Bûvçju '&AUBNAME&' ...'
 GETUDL(DATUMS) !ATRODAM UZÒÇMUMA(DARBINIEKA) DARBA LAIKU
 STEP#=DEFORMAT('00:30',@T1)
 CLEAR(AUB:RECORD)
 AUB:DATUMS=DATUMS
 IF AUB:DATUMS%7+1 = 1            ! SVÇTDIENA
 ELSIF AUB:DATUMS%7+1 = 7         ! SESTDIENA
 ELSE                             ! DARBADIENA
    IF ~(UDL_S OR UDL_B)
       KLUDA(0,'Nav norâdîts uzòçmuma darba laiks Lokâlajos datos...')
       LOCALRESPONSE=REQUESTCANCELLED
       EXIT
    .
 .
 AUB_STATUSS=9                    ! DIENAS VIRSRAKSTS
 LOOP J#=1 TO 22
    AUB:STATUSS[J#]=AUB_STATUSS
 .
 IF ~DUPLICATE(AUB:DAT_KEY)
    ADD(AU_BILDE)
 .

 AUB_STATUSS=0                    ! 30MIN. DIENAS IZVÇRSUMS
 LOOP I#=UDL_S TO UDL_B BY STEP#
    AUB:PLKST_P=I#
    LOOP J#=1 TO 22
       AUB:STATUSS[J#]=AUB_STATUSS
    .
    IF ~DUPLICATE(AUB:DAT_KEY)
       ADD(AU_BILDE)
    .
    DISPLAY()
 .


!---------------------------------------------------------------------------------------------
SEARCHKESKA     ROUTINE
 OPEN(KESKAWINDOW)
 IF SEARCHMODE=2
    ?StringMEKL{PROP:TEXT}='P/Z U_Nr='
 .
 ACCEPT
   CASE FIELD()
   OF ?OKButton
     KESKA=UPPER(INIGEN(KESKA,LEN(KESKA),2))
     BREAK
   OF ?CancelButton
     KESKA=''
     BREAK
  .
 .
 CLOSE(KESKAWINDOW)
 IF KESKA
   DO SyncWindow
   SET(AUB:DAT_KEY,AUB:DAT_KEY)
   FOUND#=0
   LOOP
      NEXT(AU_BILDE)
! stop(FORMAT(aub:datums,@D06.)&' '&KESKA&' '&UPPER(INIGEN(AUB:AUT_TEXT[I#],LEN(CLIP(AUB:AUT_TEXT[I#])),2)))
      IF ERROR() THEN BREAK.
      LOOP I#=1 TO 22
         IF SEARCHMODE=1 AND INSTRING(KESKA,UPPER(INIGEN(AUB:AUT_TEXT[I#],LEN(CLIP(AUB:AUT_TEXT[I#])),2)),1) OR|
         SEARCHMODE=2 AND KESKA=AUB:PAV_NR[I#]
            FOUND#=1
            VIETA_NR=I#
            BREAK
         .
      .
      IF FOUND# THEN BREAK.
   .
   IF ~FOUND#
      KLUDA(0,'A/M '&clip(KESKA)&' nav atrasta...')
   ELSE
      IF INRANGE(VIETA_NR,1,11) AND LIST=2
         SELECT(?TAB1)
         DO LIST1
      ELSIF INRANGE(VIETA_NR,12,20) AND LIST=1
         SELECT(?TAB2)
         DO LIST2
      .
      LocalRequest = OriginalRequest
      BRW1::LocateMode = LocateOnEdit
      DO BRW1::LocateRecord
      DO BRW1::InitializeBrowse
      DO BRW1::PostNewSelection
      DO BRW1::RefreshPage
      ?Browse:1{PROPLIST:HEADER,1}='Datums' !Lai piespiestu pârlasît ekrânu
   .
 .

!---------------------------------------------------------------------------------------------
MOVEBLOCKH     ROUTINE
 DO SyncWindow
 IF ~AUB:AUT_TEXT[VIETA_NR]
    KLUDA(0,FORMAT(AUB:DATUMS,@D06.)&' '&FORMAT(AUB:PLKST_P,@T1)&' Vieta Nr '&VIETA_NR&' nekas nav definçts...')
    EXIT
 .
 OPEN(MOVEHWINDOW)
 ACCEPT
   CASE FIELD()
   OF ?OKButtonMOVEH
     BREAK
   OF ?CancelButtonMOVEH
     KESKA=''
     BREAK
  .
 .
 CLOSE(MOVEHWINDOW)
 IF KESKA
   SAV_POSITION=POSITION(AUB:DAT_KEY)
   NEW_VIETA_NR=KESKA
   IF ~INRANGE(NEW_VIETA_NR,1,22) OR NEW_VIETA_NR=VIETA_NR
       KLUDA(0,'Neatïauts Darba vietas Nr...')
       EXIT
   .
   SAV_AUT_TEXT=AUB:AUT_TEXT[VIETA_NR]
   SET(AUB:DAT_KEY,AUB:DAT_KEY)
   LOOP
      NEXT(AU_BILDE)
      IF AUB:STATUSS[VIETA_NR]=9 THEN CYCLE. !VIRSRAKSTS/BRÎVDIENA
      IF ERROR() OR ~(AUB:AUT_TEXT[VIETA_NR]=SAV_AUT_TEXT) THEN BREAK.
      AUB:AUT_TEXT[NEW_VIETA_NR]=AUB:AUT_TEXT[VIETA_NR]
      AUB:PAV_NR[NEW_VIETA_NR]=AUB:PAV_NR[VIETA_NR]
      AUB:STATUSS[NEW_VIETA_NR]=AUB:STATUSS[VIETA_NR]
      AUB:AUT_TEXT[VIETA_NR]=''
      AUB:PAV_NR[VIETA_NR]=0
      AUB:STATUSS[VIETA_NR]=0
      IF RIUPDATE:AU_BILDE()
         KLUDA(24,'AU_BILDE')
      .
   .
   RESET(AUB:DAT_KEY,SAV_POSITION)
   NEXT(AU_BILDE)
   VIETA_NR=NEW_VIETA_NR
   LocalRequest = OriginalRequest
   BRW1::LocateMode = LocateOnEdit
   DO BRW1::LocateRecord
   DO BRW1::InitializeBrowse
   DO BRW1::PostNewSelection
   DO BRW1::RefreshPage
   ?Browse:1{PROPLIST:HEADER,1}='Datums' !Lai piespiestu pârlasît ekrânu
 .

!---------------------------------------------------------------------------------------------
MOVEBLOCKV     ROUTINE
 DO SyncWindow
 IF ~AUB:AUT_TEXT[VIETA_NR]
    KLUDA(0,FORMAT(AUB:DATUMS,@D06.)&' '&FORMAT(AUB:PLKST_P,@T1)&' Vieta Nr '&VIETA_NR&' nekas nav definçts...')
    EXIT
 .
 OPEN(MOVEVWINDOW)
 ACCEPT
   CASE FIELD()
   OF ?OKButtonMOVEV
     BREAK
   OF ?CancelButtonMOVEV
     NEW_DATUMS=0
     NEW_PLKST_P=0
     BREAK
  .
 .
 CLOSE(MOVEVWINDOW)
 IF NEW_DATUMS AND NEW_PLKST_P
   SOLI=0
   IF AUB:DATUMS=NEW_DATUMS AND FORMAT(AUB:PLKST_P,@T1)=FORMAT(NEW_PLKST_P,@T1)
      KLUDA(0,'Neatïauts Datums un Plkst...')
      EXIT
   .
   SAV_AUT_TEXT=AUB:AUT_TEXT[VIETA_NR]
   AUB_PAV_NR=AUB:PAV_NR[VIETA_NR]
   AUB_STATUSS=AUB:STATUSS[VIETA_NR]
   SET(AUB:DAT_KEY,AUB:DAT_KEY)
   LOOP
      NEXT(AU_BILDE)
      IF AUB:STATUSS[VIETA_NR]=9 THEN CYCLE. !VIRSRAKSTS/BRÎVDIENA
      IF ERROR() OR ~(AUB:AUT_TEXT[VIETA_NR]=SAV_AUT_TEXT) THEN BREAK.
      AUB:AUT_TEXT[VIETA_NR]=''
      AUB:PAV_NR[VIETA_NR]=0
      AUB:STATUSS[VIETA_NR]=0
      IF RIUPDATE:AU_BILDE()
         KLUDA(24,'AU_BILDE')
      .
      SOLI+=1
   .
   IF SOLI
      FIRST#=TRUE
      CLEAR(AUB:RECORD)
      AUB:DATUMS=NEW_DATUMS
      AUB:PLKST_P=NEW_PLKST_P
      SET(AUB:DAT_KEY,AUB:DAT_KEY)
      LOOP SOLI TIMES
         NEXT(AU_BILDE)
         IF AUB:STATUSS[VIETA_NR]=9 !VIRSRAKSTS/BRÎVDIENA
            KLUDA(0,'Bûs nepiecieðama vçl viena diena: '&format(aub:datums,@D06.))
            SOLI+=1
            CYCLE
         .
         IF AUB:AUT_TEXT[VIETA_NR]
            KLUDA(0,'Datums '&format(aub:datums,@D06.)&' Plkst '&FORMAT(AUB:PLKST_P,@T1)&' AIZÒEMTS:'&AUB:AUT_TEXT[VIETA_NR],3)
            IF ~KLU_DARBIBA THEN CYCLE.
         .
         AUB:AUT_TEXT[VIETA_NR]=SAV_AUT_TEXT
         AUB:PAV_NR[VIETA_NR]=AUB_PAV_NR
         AUB:STATUSS[VIETA_NR]=AUB_STATUSS
         IF RIUPDATE:AU_BILDE()
            KLUDA(24,'AU_BILDE')
         .
         IF FIRST#=TRUE
            SAV_POSITION=POSITION(AUB:DAT_KEY)
            FIRST#=FALSE
         .
      .
   .
   RESET(AUB:DAT_KEY,SAV_POSITION)
   NEXT(AU_BILDE)
   LocalRequest = OriginalRequest
   BRW1::LocateMode = LocateOnEdit
   DO BRW1::LocateRecord
   DO BRW1::InitializeBrowse
   DO BRW1::PostNewSelection
   DO BRW1::RefreshPage
   ?Browse:1{PROPLIST:HEADER,1}='Datums' !Lai piespiestu pârlasît ekrânu
 .

!---------------------------------------------------------------------------------------------
PERFORMPAVAD     ROUTINE
 IF AUB:STATUSS[VIETA_NR]=9 !DIENAS VIRSRAKSTS
    KLUDA(0,'Nolieciet kursoru uz pasûtîjuma ,norâdiet darba vietu')
    EXIT
 .
 !AUB_BILDE::USED !TRUE-PÇC ÐITÂ PAZÎS, KA SAUC NO FAILIEM
 IF ~AUB:PAV_NR[VIETA_NR]  !VÇL NAV BÛVÇTS
    KLUDA(0,'Vieta '&clip(vieta_nr)&' plkst.'&format(AUB:PLKST_P,@T1)&' Vçl nav atvçrts P(R)ojekts...')
    GLOBALREQUEST=INSERTRECORD
    CLEAR(PAV:RECORD)
    UPDATEPAVAD
    IF GLOBALRESPONSE=REQUESTCOMPLETED
       AUB:PAV_NR[VIETA_NR]=PAV:U_NR
       IF ~AUB:STATUSS[VIETA_NR] THEN AUB:STATUSS[VIETA_NR]=1.
       IF ~AUB:AUT_TEXT[VIETA_NR] THEN AUB:AUT_TEXT[VIETA_NR]=GETAUTO(PAV:VED_NR,9).
       IF ~AUB:AUT_TEXT[VIETA_NR] THEN AUB:AUT_TEXT[VIETA_NR]=PAV:NOKA.
       IF RIUPDATE:AU_BILDE()
          KLUDA(24,'GRAFIKS')
       ELSE
          SAV_AUT_TEXT=AUB:AUT_TEXT[VIETA_NR]
          SAV_POSITION=POSITION(AUB:DAT_KEY)
          LOOP
             NEXT(AU_BILDE)
             IF ERROR() OR ~AUB:AUT_TEXT[VIETA_NR] OR ~(AUB:AUT_TEXT[VIETA_NR]=SAV_AUT_TEXT) THEN BREAK.
             AUB:PAV_NR[VIETA_NR]=PAV:U_NR
             IF RIUPDATE:AU_BILDE()
                KLUDA(24,'GRAFIKS')
             .
          .
          RESET(AUB:DAT_KEY,SAV_POSITION)
          NEXT(AU_BILDE)
       .
    .
 ELSE   !IR JAU UZBÛVÇTS
    PAV:U_NR=AUB:PAV_NR[VIETA_NR]
    GET(PAVAD,PAV:NR_KEY)
    IF ERROR()
       KLUDA(88,'P/Z ar U_NR='&AUB:PAV_NR[VIETA_NR])
    ELSE
       GLOBALREQUEST=CHANGERECORD
       UPDATEPAVAD
    .
 .

!---------------------------------------------------------------------------------------------
LIST2     ROUTINE
 LIST=2
 C=11  !NOBÎDE 2-AM LIST-AM
! C1=10 !21 KOLONNÂ ATKÂRTOJAM 20-TO
! C2=9  !22 KOLONNÂ ATKÂRTOJAM 20-TO
 LOOP VN#=12 TO 22  !22 VIETAS DIM
    IF PRO_NOS_P[VN#]
       ?Browse:1{PROPLIST:HEADER,VN#-11+2}=PRO_NOS_P[VN#]
    ELSE
       ?Browse:1{PROPLIST:HEADER,VN#-11+2}=VN#
    .
 .
! ?Browse:1{PROPLIST:HEADER,10+2}=''
! ?Browse:1{PROPLIST:HEADER,11+2}=''
! HIDE(?VIETA_NR:Radio:10,?VIETA_NR:Radio:11)

!---------------------------------------------------------------------------------------------
LIST1     ROUTINE
 LIST=1
 C=0
! C1=0
! C2=0
 LOOP VN#=1 TO 11  !11 VIETAS UZ 1 EKRÂNA
    IF PRO_NOS_P[VN#]
       ?Browse:1{PROPLIST:HEADER,VN#+2}=PRO_NOS_P[VN#]
    ELSE
       ?Browse:1{PROPLIST:HEADER,VN#+2}=VN#
    .
 .
! UNHIDE(?VIETA_NR:Radio:10,?VIETA_NR:Radio:11)

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
  IF SEND(AU_BILDE,'QUICKSCAN=on').
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'AU_BILDE')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = AUB:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'AU_BILDE')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = AUB:DATUMS
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
  IF SEND(AU_BILDE,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  AUB_DATUMS = BRW1::AUB_DATUMS
  AUB:PLKST_P = BRW1::AUB:PLKST_P
  AUT_TEXT[1] = BRW1::AUT_TEXT_1_
  AUT_TEXT[2] = BRW1::AUT_TEXT_2_
  AUT_TEXT[3] = BRW1::AUT_TEXT_3_
  AUT_TEXT[4] = BRW1::AUT_TEXT_4_
  AUT_TEXT[5] = BRW1::AUT_TEXT_5_
  AUT_TEXT[6] = BRW1::AUT_TEXT_6_
  AUT_TEXT[7] = BRW1::AUT_TEXT_7_
  AUT_TEXT[8] = BRW1::AUT_TEXT_8_
  AUT_TEXT[9] = BRW1::AUT_TEXT_9_
  AUT_TEXT[10] = BRW1::AUT_TEXT_10_
  AUT_TEXT[11] = BRW1::AUT_TEXT_11_
  AUB:DATUMS = BRW1::AUB:DATUMS
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
  IF ~AUB:PLKST_P
     EXECUTE AUB:DATUMS%7+1
        AUB_DATUMS='Svçtdiena'
        AUB_DATUMS='Pirmdiena'
        AUB_DATUMS='Otrdiena'
        AUB_DATUMS='Treðdiena'
        AUB_DATUMS='Ceturtdiena'
        AUB_DATUMS='Piektdiena'
        AUB_DATUMS='Sestdiena'
     .
  ELSE
     AUB_DATUMS=FORMAT(AUB:DATUMS,@D06.)
     LOOP I#=1 TO 11
        J#=I#+C
        IF J#>22 THEN BREAK.
        AUT_TEXT[I#]=AUB:AUT_TEXT[J#]
     .
  .
  BRW1::AUB_DATUMS = AUB_DATUMS
  IF (~AUB:PLKST_P)
    BRW1::AUB_DATUMS:NormalFG = -1
    BRW1::AUB_DATUMS:NormalBG = 65535
    BRW1::AUB_DATUMS:SelectedFG = 65535
    BRW1::AUB_DATUMS:SelectedBG = -1
  ELSE
    BRW1::AUB_DATUMS:NormalFG = -1
    BRW1::AUB_DATUMS:NormalBG = -1
    BRW1::AUB_DATUMS:SelectedFG = -1
    BRW1::AUB_DATUMS:SelectedBG = -1
  END
  BRW1::AUB:PLKST_P = AUB:PLKST_P
  IF (~AUB:PLKST_P)
    BRW1::AUB:PLKST_P:NormalFG = -1
    BRW1::AUB:PLKST_P:NormalBG = 65535
    BRW1::AUB:PLKST_P:SelectedFG = 65535
    BRW1::AUB:PLKST_P:SelectedBG = -1
  ELSE
    BRW1::AUB:PLKST_P:NormalFG = -1
    BRW1::AUB:PLKST_P:NormalBG = -1
    BRW1::AUB:PLKST_P:SelectedFG = -1
    BRW1::AUB:PLKST_P:SelectedBG = -1
  END
  BRW1::AUT_TEXT_1_ = AUT_TEXT[1]
  IF (AUB:STATUSS[1+C]=1)
    BRW1::AUT_TEXT_1_:NormalFG = -1
    BRW1::AUT_TEXT_1_:NormalBG = 65280
    BRW1::AUT_TEXT_1_:SelectedFG = 65280
    BRW1::AUT_TEXT_1_:SelectedBG = -1
  ELSIF (AUB:STATUSS[1+C]=4)
    BRW1::AUT_TEXT_1_:NormalFG = -1
    BRW1::AUT_TEXT_1_:NormalBG = 255
    BRW1::AUT_TEXT_1_:SelectedFG = 255
    BRW1::AUT_TEXT_1_:SelectedBG = -1
  ELSIF (AUB:STATUSS[1+C]=5)
    BRW1::AUT_TEXT_1_:NormalFG = -1
    BRW1::AUT_TEXT_1_:NormalBG = 33023
    BRW1::AUT_TEXT_1_:SelectedFG = 33023
    BRW1::AUT_TEXT_1_:SelectedBG = -1
  ELSIF (AUB:STATUSS[1+C]=6)
    BRW1::AUT_TEXT_1_:NormalFG = -1
    BRW1::AUT_TEXT_1_:NormalBG = 16776960
    BRW1::AUT_TEXT_1_:SelectedFG = 16776960
    BRW1::AUT_TEXT_1_:SelectedBG = -1
  ELSIF (AUB:STATUSS[1+C]=2)
    BRW1::AUT_TEXT_1_:NormalFG = -1
    BRW1::AUT_TEXT_1_:NormalBG = 8421504
    BRW1::AUT_TEXT_1_:SelectedFG = 8421504
    BRW1::AUT_TEXT_1_:SelectedBG = -1
  ELSIF (AUB:STATUSS[1+C]=9)
    BRW1::AUT_TEXT_1_:NormalFG = -1
    BRW1::AUT_TEXT_1_:NormalBG = 65535
    BRW1::AUT_TEXT_1_:SelectedFG = 65535
    BRW1::AUT_TEXT_1_:SelectedBG = -1
  ELSIF (~AUB:STATUSS[1+C] AND (VIETA_NR=1+C))
    BRW1::AUT_TEXT_1_:NormalFG = -1
    BRW1::AUT_TEXT_1_:NormalBG = 12632256
    BRW1::AUT_TEXT_1_:SelectedFG = -1
    BRW1::AUT_TEXT_1_:SelectedBG = -1
  ELSE
    BRW1::AUT_TEXT_1_:NormalFG = -1
    BRW1::AUT_TEXT_1_:NormalBG = -1
    BRW1::AUT_TEXT_1_:SelectedFG = -1
    BRW1::AUT_TEXT_1_:SelectedBG = -1
  END
  BRW1::AUT_TEXT_2_ = AUT_TEXT[2]
  IF (AUB:STATUSS[2+C]=1)
    BRW1::AUT_TEXT_2_:NormalFG = -1
    BRW1::AUT_TEXT_2_:NormalBG = 65280
    BRW1::AUT_TEXT_2_:SelectedFG = 65280
    BRW1::AUT_TEXT_2_:SelectedBG = -1
  ELSIF (AUB:STATUSS[2+C]=4)
    BRW1::AUT_TEXT_2_:NormalFG = -1
    BRW1::AUT_TEXT_2_:NormalBG = 255
    BRW1::AUT_TEXT_2_:SelectedFG = 255
    BRW1::AUT_TEXT_2_:SelectedBG = -1
  ELSIF (AUB:STATUSS[2+C]=5)
    BRW1::AUT_TEXT_2_:NormalFG = -1
    BRW1::AUT_TEXT_2_:NormalBG = 33023
    BRW1::AUT_TEXT_2_:SelectedFG = 33023
    BRW1::AUT_TEXT_2_:SelectedBG = -1
  ELSIF (AUB:STATUSS[2+C]=6)
    BRW1::AUT_TEXT_2_:NormalFG = -1
    BRW1::AUT_TEXT_2_:NormalBG = 16776960
    BRW1::AUT_TEXT_2_:SelectedFG = 16776960
    BRW1::AUT_TEXT_2_:SelectedBG = -1
  ELSIF (AUB:STATUSS[2+C]=2)
    BRW1::AUT_TEXT_2_:NormalFG = -1
    BRW1::AUT_TEXT_2_:NormalBG = 8421504
    BRW1::AUT_TEXT_2_:SelectedFG = 8421504
    BRW1::AUT_TEXT_2_:SelectedBG = -1
  ELSIF (AUB:STATUSS[2+C]=9)
    BRW1::AUT_TEXT_2_:NormalFG = -1
    BRW1::AUT_TEXT_2_:NormalBG = 65535
    BRW1::AUT_TEXT_2_:SelectedFG = 65535
    BRW1::AUT_TEXT_2_:SelectedBG = -1
  ELSIF (~AUB:STATUSS[2+C] AND (VIETA_NR=2+C))
    BRW1::AUT_TEXT_2_:NormalFG = -1
    BRW1::AUT_TEXT_2_:NormalBG = 12632256
    BRW1::AUT_TEXT_2_:SelectedFG = -1
    BRW1::AUT_TEXT_2_:SelectedBG = -1
  ELSE
    BRW1::AUT_TEXT_2_:NormalFG = -1
    BRW1::AUT_TEXT_2_:NormalBG = -1
    BRW1::AUT_TEXT_2_:SelectedFG = -1
    BRW1::AUT_TEXT_2_:SelectedBG = -1
  END
  BRW1::AUT_TEXT_3_ = AUT_TEXT[3]
  IF (AUB:STATUSS[3+C]=1)
    BRW1::AUT_TEXT_3_:NormalFG = -1
    BRW1::AUT_TEXT_3_:NormalBG = 65280
    BRW1::AUT_TEXT_3_:SelectedFG = 65280
    BRW1::AUT_TEXT_3_:SelectedBG = -1
  ELSIF (AUB:STATUSS[3+C]=4)
    BRW1::AUT_TEXT_3_:NormalFG = -1
    BRW1::AUT_TEXT_3_:NormalBG = 255
    BRW1::AUT_TEXT_3_:SelectedFG = 255
    BRW1::AUT_TEXT_3_:SelectedBG = -1
  ELSIF (AUB:STATUSS[3+C]=5)
    BRW1::AUT_TEXT_3_:NormalFG = -1
    BRW1::AUT_TEXT_3_:NormalBG = 33023
    BRW1::AUT_TEXT_3_:SelectedFG = 33023
    BRW1::AUT_TEXT_3_:SelectedBG = -1
  ELSIF (AUB:STATUSS[3+C]=6)
    BRW1::AUT_TEXT_3_:NormalFG = -1
    BRW1::AUT_TEXT_3_:NormalBG = 16776960
    BRW1::AUT_TEXT_3_:SelectedFG = 16776960
    BRW1::AUT_TEXT_3_:SelectedBG = -1
  ELSIF (AUB:STATUSS[3+C]=2)
    BRW1::AUT_TEXT_3_:NormalFG = -1
    BRW1::AUT_TEXT_3_:NormalBG = 8421504
    BRW1::AUT_TEXT_3_:SelectedFG = 8421504
    BRW1::AUT_TEXT_3_:SelectedBG = -1
  ELSIF (AUB:STATUSS[3+C]=9)
    BRW1::AUT_TEXT_3_:NormalFG = -1
    BRW1::AUT_TEXT_3_:NormalBG = 65535
    BRW1::AUT_TEXT_3_:SelectedFG = 65535
    BRW1::AUT_TEXT_3_:SelectedBG = -1
  ELSIF (~AUB:STATUSS[3+C] AND (VIETA_NR=3+C))
    BRW1::AUT_TEXT_3_:NormalFG = -1
    BRW1::AUT_TEXT_3_:NormalBG = 12632256
    BRW1::AUT_TEXT_3_:SelectedFG = -1
    BRW1::AUT_TEXT_3_:SelectedBG = -1
  ELSE
    BRW1::AUT_TEXT_3_:NormalFG = -1
    BRW1::AUT_TEXT_3_:NormalBG = -1
    BRW1::AUT_TEXT_3_:SelectedFG = -1
    BRW1::AUT_TEXT_3_:SelectedBG = -1
  END
  BRW1::AUT_TEXT_4_ = AUT_TEXT[4]
  IF (AUB:STATUSS[4+C]=1)
    BRW1::AUT_TEXT_4_:NormalFG = -1
    BRW1::AUT_TEXT_4_:NormalBG = 65280
    BRW1::AUT_TEXT_4_:SelectedFG = 65280
    BRW1::AUT_TEXT_4_:SelectedBG = -1
  ELSIF (AUB:STATUSS[4+C]=4)
    BRW1::AUT_TEXT_4_:NormalFG = -1
    BRW1::AUT_TEXT_4_:NormalBG = 255
    BRW1::AUT_TEXT_4_:SelectedFG = 255
    BRW1::AUT_TEXT_4_:SelectedBG = -1
  ELSIF (AUB:STATUSS[4+C]=5)
    BRW1::AUT_TEXT_4_:NormalFG = -1
    BRW1::AUT_TEXT_4_:NormalBG = 33023
    BRW1::AUT_TEXT_4_:SelectedFG = 33023
    BRW1::AUT_TEXT_4_:SelectedBG = -1
  ELSIF (AUB:STATUSS[4+C]=6)
    BRW1::AUT_TEXT_4_:NormalFG = -1
    BRW1::AUT_TEXT_4_:NormalBG = 16776960
    BRW1::AUT_TEXT_4_:SelectedFG = 16776960
    BRW1::AUT_TEXT_4_:SelectedBG = -1
  ELSIF (AUB:STATUSS[4+C]=2)
    BRW1::AUT_TEXT_4_:NormalFG = -1
    BRW1::AUT_TEXT_4_:NormalBG = 8421504
    BRW1::AUT_TEXT_4_:SelectedFG = 8421504
    BRW1::AUT_TEXT_4_:SelectedBG = -1
  ELSIF (AUB:STATUSS[4+C]=9)
    BRW1::AUT_TEXT_4_:NormalFG = -1
    BRW1::AUT_TEXT_4_:NormalBG = 65535
    BRW1::AUT_TEXT_4_:SelectedFG = 65535
    BRW1::AUT_TEXT_4_:SelectedBG = -1
  ELSIF (~AUB:STATUSS[4+C] AND (VIETA_NR=4+C))
    BRW1::AUT_TEXT_4_:NormalFG = -1
    BRW1::AUT_TEXT_4_:NormalBG = 12632256
    BRW1::AUT_TEXT_4_:SelectedFG = -1
    BRW1::AUT_TEXT_4_:SelectedBG = -1
  ELSE
    BRW1::AUT_TEXT_4_:NormalFG = -1
    BRW1::AUT_TEXT_4_:NormalBG = -1
    BRW1::AUT_TEXT_4_:SelectedFG = -1
    BRW1::AUT_TEXT_4_:SelectedBG = -1
  END
  BRW1::AUT_TEXT_5_ = AUT_TEXT[5]
  IF (AUB:STATUSS[5+C]=1)
    BRW1::AUT_TEXT_5_:NormalFG = -1
    BRW1::AUT_TEXT_5_:NormalBG = 65280
    BRW1::AUT_TEXT_5_:SelectedFG = 65280
    BRW1::AUT_TEXT_5_:SelectedBG = -1
  ELSIF (AUB:STATUSS[5+C]=4)
    BRW1::AUT_TEXT_5_:NormalFG = -1
    BRW1::AUT_TEXT_5_:NormalBG = 255
    BRW1::AUT_TEXT_5_:SelectedFG = 255
    BRW1::AUT_TEXT_5_:SelectedBG = -1
  ELSIF (AUB:STATUSS[5+C]=5)
    BRW1::AUT_TEXT_5_:NormalFG = -1
    BRW1::AUT_TEXT_5_:NormalBG = 33023
    BRW1::AUT_TEXT_5_:SelectedFG = 33023
    BRW1::AUT_TEXT_5_:SelectedBG = -1
  ELSIF (AUB:STATUSS[5+C]=6)
    BRW1::AUT_TEXT_5_:NormalFG = -1
    BRW1::AUT_TEXT_5_:NormalBG = 16776960
    BRW1::AUT_TEXT_5_:SelectedFG = 16776960
    BRW1::AUT_TEXT_5_:SelectedBG = -1
  ELSIF (AUB:STATUSS[5+C]=2)
    BRW1::AUT_TEXT_5_:NormalFG = -1
    BRW1::AUT_TEXT_5_:NormalBG = 8421504
    BRW1::AUT_TEXT_5_:SelectedFG = 8421504
    BRW1::AUT_TEXT_5_:SelectedBG = -1
  ELSIF (AUB:STATUSS[5+C]=9)
    BRW1::AUT_TEXT_5_:NormalFG = -1
    BRW1::AUT_TEXT_5_:NormalBG = 65535
    BRW1::AUT_TEXT_5_:SelectedFG = 65535
    BRW1::AUT_TEXT_5_:SelectedBG = -1
  ELSIF (~AUB:STATUSS[5+C] AND (VIETA_NR=5+C))
    BRW1::AUT_TEXT_5_:NormalFG = -1
    BRW1::AUT_TEXT_5_:NormalBG = 12632256
    BRW1::AUT_TEXT_5_:SelectedFG = -1
    BRW1::AUT_TEXT_5_:SelectedBG = -1
  ELSE
    BRW1::AUT_TEXT_5_:NormalFG = -1
    BRW1::AUT_TEXT_5_:NormalBG = -1
    BRW1::AUT_TEXT_5_:SelectedFG = -1
    BRW1::AUT_TEXT_5_:SelectedBG = -1
  END
  BRW1::AUT_TEXT_6_ = AUT_TEXT[6]
  IF (AUB:STATUSS[6+C]=1)
    BRW1::AUT_TEXT_6_:NormalFG = -1
    BRW1::AUT_TEXT_6_:NormalBG = 65280
    BRW1::AUT_TEXT_6_:SelectedFG = 65280
    BRW1::AUT_TEXT_6_:SelectedBG = -1
  ELSIF (AUB:STATUSS[6+C]=4)
    BRW1::AUT_TEXT_6_:NormalFG = -1
    BRW1::AUT_TEXT_6_:NormalBG = 255
    BRW1::AUT_TEXT_6_:SelectedFG = 255
    BRW1::AUT_TEXT_6_:SelectedBG = -1
  ELSIF (AUB:STATUSS[6+C]=5)
    BRW1::AUT_TEXT_6_:NormalFG = -1
    BRW1::AUT_TEXT_6_:NormalBG = 33023
    BRW1::AUT_TEXT_6_:SelectedFG = 33023
    BRW1::AUT_TEXT_6_:SelectedBG = -1
  ELSIF (AUB:STATUSS[6+C]=6)
    BRW1::AUT_TEXT_6_:NormalFG = -1
    BRW1::AUT_TEXT_6_:NormalBG = 16776960
    BRW1::AUT_TEXT_6_:SelectedFG = 16776960
    BRW1::AUT_TEXT_6_:SelectedBG = -1
  ELSIF (AUB:STATUSS[6+C]=2)
    BRW1::AUT_TEXT_6_:NormalFG = -1
    BRW1::AUT_TEXT_6_:NormalBG = 8421504
    BRW1::AUT_TEXT_6_:SelectedFG = 8421504
    BRW1::AUT_TEXT_6_:SelectedBG = -1
  ELSIF (AUB:STATUSS[6+C]=9)
    BRW1::AUT_TEXT_6_:NormalFG = -1
    BRW1::AUT_TEXT_6_:NormalBG = 65535
    BRW1::AUT_TEXT_6_:SelectedFG = 65535
    BRW1::AUT_TEXT_6_:SelectedBG = -1
  ELSIF (~AUB:STATUSS[6+C] AND (VIETA_NR=6+C))
    BRW1::AUT_TEXT_6_:NormalFG = -1
    BRW1::AUT_TEXT_6_:NormalBG = 12632256
    BRW1::AUT_TEXT_6_:SelectedFG = -1
    BRW1::AUT_TEXT_6_:SelectedBG = -1
  ELSE
    BRW1::AUT_TEXT_6_:NormalFG = -1
    BRW1::AUT_TEXT_6_:NormalBG = -1
    BRW1::AUT_TEXT_6_:SelectedFG = -1
    BRW1::AUT_TEXT_6_:SelectedBG = -1
  END
  BRW1::AUT_TEXT_7_ = AUT_TEXT[7]
  IF (AUB:STATUSS[7+C]=1)
    BRW1::AUT_TEXT_7_:NormalFG = -1
    BRW1::AUT_TEXT_7_:NormalBG = 65280
    BRW1::AUT_TEXT_7_:SelectedFG = 65280
    BRW1::AUT_TEXT_7_:SelectedBG = -1
  ELSIF (AUB:STATUSS[7+C]=4)
    BRW1::AUT_TEXT_7_:NormalFG = -1
    BRW1::AUT_TEXT_7_:NormalBG = 255
    BRW1::AUT_TEXT_7_:SelectedFG = 255
    BRW1::AUT_TEXT_7_:SelectedBG = -1
  ELSIF (AUB:STATUSS[7+C]=5)
    BRW1::AUT_TEXT_7_:NormalFG = -1
    BRW1::AUT_TEXT_7_:NormalBG = 33023
    BRW1::AUT_TEXT_7_:SelectedFG = 33023
    BRW1::AUT_TEXT_7_:SelectedBG = -1
  ELSIF (AUB:STATUSS[7+C]=6)
    BRW1::AUT_TEXT_7_:NormalFG = -1
    BRW1::AUT_TEXT_7_:NormalBG = 16776960
    BRW1::AUT_TEXT_7_:SelectedFG = 16776960
    BRW1::AUT_TEXT_7_:SelectedBG = -1
  ELSIF (AUB:STATUSS[7+C]=2)
    BRW1::AUT_TEXT_7_:NormalFG = -1
    BRW1::AUT_TEXT_7_:NormalBG = 8421504
    BRW1::AUT_TEXT_7_:SelectedFG = 8421504
    BRW1::AUT_TEXT_7_:SelectedBG = -1
  ELSIF (AUB:STATUSS[7+C]=9)
    BRW1::AUT_TEXT_7_:NormalFG = -1
    BRW1::AUT_TEXT_7_:NormalBG = 65535
    BRW1::AUT_TEXT_7_:SelectedFG = 65535
    BRW1::AUT_TEXT_7_:SelectedBG = -1
  ELSIF (~AUB:STATUSS[7+C] AND (VIETA_NR=7+C))
    BRW1::AUT_TEXT_7_:NormalFG = -1
    BRW1::AUT_TEXT_7_:NormalBG = 12632256
    BRW1::AUT_TEXT_7_:SelectedFG = -1
    BRW1::AUT_TEXT_7_:SelectedBG = -1
  ELSE
    BRW1::AUT_TEXT_7_:NormalFG = -1
    BRW1::AUT_TEXT_7_:NormalBG = -1
    BRW1::AUT_TEXT_7_:SelectedFG = -1
    BRW1::AUT_TEXT_7_:SelectedBG = -1
  END
  BRW1::AUT_TEXT_8_ = AUT_TEXT[8]
  IF (AUB:STATUSS[8+C]=1)
    BRW1::AUT_TEXT_8_:NormalFG = -1
    BRW1::AUT_TEXT_8_:NormalBG = 65280
    BRW1::AUT_TEXT_8_:SelectedFG = 65280
    BRW1::AUT_TEXT_8_:SelectedBG = -1
  ELSIF (AUB:STATUSS[8+C]=4)
    BRW1::AUT_TEXT_8_:NormalFG = -1
    BRW1::AUT_TEXT_8_:NormalBG = 255
    BRW1::AUT_TEXT_8_:SelectedFG = 255
    BRW1::AUT_TEXT_8_:SelectedBG = -1
  ELSIF (AUB:STATUSS[8+C]=5)
    BRW1::AUT_TEXT_8_:NormalFG = -1
    BRW1::AUT_TEXT_8_:NormalBG = 33023
    BRW1::AUT_TEXT_8_:SelectedFG = 33023
    BRW1::AUT_TEXT_8_:SelectedBG = -1
  ELSIF (AUB:STATUSS[8+C]=6)
    BRW1::AUT_TEXT_8_:NormalFG = -1
    BRW1::AUT_TEXT_8_:NormalBG = 16776960
    BRW1::AUT_TEXT_8_:SelectedFG = 16776960
    BRW1::AUT_TEXT_8_:SelectedBG = -1
  ELSIF (AUB:STATUSS[8+C]=2)
    BRW1::AUT_TEXT_8_:NormalFG = -1
    BRW1::AUT_TEXT_8_:NormalBG = 8421504
    BRW1::AUT_TEXT_8_:SelectedFG = 8421504
    BRW1::AUT_TEXT_8_:SelectedBG = -1
  ELSIF (AUB:STATUSS[8+C]=9)
    BRW1::AUT_TEXT_8_:NormalFG = -1
    BRW1::AUT_TEXT_8_:NormalBG = 65535
    BRW1::AUT_TEXT_8_:SelectedFG = 65535
    BRW1::AUT_TEXT_8_:SelectedBG = -1
  ELSIF (~AUB:STATUSS[8+C] AND (VIETA_NR=8+C))
    BRW1::AUT_TEXT_8_:NormalFG = -1
    BRW1::AUT_TEXT_8_:NormalBG = 12632256
    BRW1::AUT_TEXT_8_:SelectedFG = -1
    BRW1::AUT_TEXT_8_:SelectedBG = -1
  ELSE
    BRW1::AUT_TEXT_8_:NormalFG = -1
    BRW1::AUT_TEXT_8_:NormalBG = -1
    BRW1::AUT_TEXT_8_:SelectedFG = -1
    BRW1::AUT_TEXT_8_:SelectedBG = -1
  END
  BRW1::AUT_TEXT_9_ = AUT_TEXT[9]
  IF (AUB:STATUSS[9+C]=1)
    BRW1::AUT_TEXT_9_:NormalFG = -1
    BRW1::AUT_TEXT_9_:NormalBG = 65280
    BRW1::AUT_TEXT_9_:SelectedFG = 65280
    BRW1::AUT_TEXT_9_:SelectedBG = -1
  ELSIF (AUB:STATUSS[9+C]=4)
    BRW1::AUT_TEXT_9_:NormalFG = -1
    BRW1::AUT_TEXT_9_:NormalBG = 255
    BRW1::AUT_TEXT_9_:SelectedFG = 255
    BRW1::AUT_TEXT_9_:SelectedBG = -1
  ELSIF (AUB:STATUSS[9+C]=5)
    BRW1::AUT_TEXT_9_:NormalFG = -1
    BRW1::AUT_TEXT_9_:NormalBG = 33023
    BRW1::AUT_TEXT_9_:SelectedFG = 33023
    BRW1::AUT_TEXT_9_:SelectedBG = -1
  ELSIF (AUB:STATUSS[9+C]=6)
    BRW1::AUT_TEXT_9_:NormalFG = -1
    BRW1::AUT_TEXT_9_:NormalBG = 16776960
    BRW1::AUT_TEXT_9_:SelectedFG = 16776960
    BRW1::AUT_TEXT_9_:SelectedBG = -1
  ELSIF (AUB:STATUSS[9+C]=2)
    BRW1::AUT_TEXT_9_:NormalFG = -1
    BRW1::AUT_TEXT_9_:NormalBG = 8421504
    BRW1::AUT_TEXT_9_:SelectedFG = 8421504
    BRW1::AUT_TEXT_9_:SelectedBG = -1
  ELSIF (AUB:STATUSS[9+C]=9)
    BRW1::AUT_TEXT_9_:NormalFG = -1
    BRW1::AUT_TEXT_9_:NormalBG = 65535
    BRW1::AUT_TEXT_9_:SelectedFG = 65535
    BRW1::AUT_TEXT_9_:SelectedBG = -1
  ELSIF (~AUB:STATUSS[9+C] AND (VIETA_NR=9+C))
    BRW1::AUT_TEXT_9_:NormalFG = -1
    BRW1::AUT_TEXT_9_:NormalBG = 12632256
    BRW1::AUT_TEXT_9_:SelectedFG = -1
    BRW1::AUT_TEXT_9_:SelectedBG = -1
  ELSE
    BRW1::AUT_TEXT_9_:NormalFG = -1
    BRW1::AUT_TEXT_9_:NormalBG = -1
    BRW1::AUT_TEXT_9_:SelectedFG = -1
    BRW1::AUT_TEXT_9_:SelectedBG = -1
  END
  BRW1::AUT_TEXT_10_ = AUT_TEXT[10]
  IF (AUB:STATUSS[10+C]=1)
    BRW1::AUT_TEXT_10_:NormalFG = -1
    BRW1::AUT_TEXT_10_:NormalBG = 65280
    BRW1::AUT_TEXT_10_:SelectedFG = 65280
    BRW1::AUT_TEXT_10_:SelectedBG = -1
  ELSIF (AUB:STATUSS[10+C]=4)
    BRW1::AUT_TEXT_10_:NormalFG = -1
    BRW1::AUT_TEXT_10_:NormalBG = 255
    BRW1::AUT_TEXT_10_:SelectedFG = 255
    BRW1::AUT_TEXT_10_:SelectedBG = -1
  ELSIF (AUB:STATUSS[10+C]=5)
    BRW1::AUT_TEXT_10_:NormalFG = -1
    BRW1::AUT_TEXT_10_:NormalBG = 33023
    BRW1::AUT_TEXT_10_:SelectedFG = 33023
    BRW1::AUT_TEXT_10_:SelectedBG = -1
  ELSIF (AUB:STATUSS[10+C]=6)
    BRW1::AUT_TEXT_10_:NormalFG = -1
    BRW1::AUT_TEXT_10_:NormalBG = 16776960
    BRW1::AUT_TEXT_10_:SelectedFG = 16776960
    BRW1::AUT_TEXT_10_:SelectedBG = -1
  ELSIF (AUB:STATUSS[10+C]=2)
    BRW1::AUT_TEXT_10_:NormalFG = -1
    BRW1::AUT_TEXT_10_:NormalBG = 8421504
    BRW1::AUT_TEXT_10_:SelectedFG = 8421504
    BRW1::AUT_TEXT_10_:SelectedBG = -1
  ELSIF (AUB:STATUSS[10+C]=9)
    BRW1::AUT_TEXT_10_:NormalFG = -1
    BRW1::AUT_TEXT_10_:NormalBG = 65535
    BRW1::AUT_TEXT_10_:SelectedFG = 65535
    BRW1::AUT_TEXT_10_:SelectedBG = -1
  ELSIF (~AUB:STATUSS[10+C] AND (VIETA_NR=10+C))
    BRW1::AUT_TEXT_10_:NormalFG = -1
    BRW1::AUT_TEXT_10_:NormalBG = 12632256
    BRW1::AUT_TEXT_10_:SelectedFG = -1
    BRW1::AUT_TEXT_10_:SelectedBG = -1
  ELSE
    BRW1::AUT_TEXT_10_:NormalFG = -1
    BRW1::AUT_TEXT_10_:NormalBG = -1
    BRW1::AUT_TEXT_10_:SelectedFG = -1
    BRW1::AUT_TEXT_10_:SelectedBG = -1
  END
  BRW1::AUT_TEXT_11_ = AUT_TEXT[11]
  IF (AUB:STATUSS[11+C]=1)
    BRW1::AUT_TEXT_11_:NormalFG = -1
    BRW1::AUT_TEXT_11_:NormalBG = 65280
    BRW1::AUT_TEXT_11_:SelectedFG = 65280
    BRW1::AUT_TEXT_11_:SelectedBG = -1
  ELSIF (AUB:STATUSS[11+C]=4)
    BRW1::AUT_TEXT_11_:NormalFG = -1
    BRW1::AUT_TEXT_11_:NormalBG = 255
    BRW1::AUT_TEXT_11_:SelectedFG = 255
    BRW1::AUT_TEXT_11_:SelectedBG = -1
  ELSIF (AUB:STATUSS[11+C]=5)
    BRW1::AUT_TEXT_11_:NormalFG = -1
    BRW1::AUT_TEXT_11_:NormalBG = 33023
    BRW1::AUT_TEXT_11_:SelectedFG = 33023
    BRW1::AUT_TEXT_11_:SelectedBG = -1
  ELSIF (AUB:STATUSS[11+C]=6)
    BRW1::AUT_TEXT_11_:NormalFG = -1
    BRW1::AUT_TEXT_11_:NormalBG = 16776960
    BRW1::AUT_TEXT_11_:SelectedFG = 16776960
    BRW1::AUT_TEXT_11_:SelectedBG = -1
  ELSIF (AUB:STATUSS[11+C]=2)
    BRW1::AUT_TEXT_11_:NormalFG = -1
    BRW1::AUT_TEXT_11_:NormalBG = 8421504
    BRW1::AUT_TEXT_11_:SelectedFG = 8421504
    BRW1::AUT_TEXT_11_:SelectedBG = -1
  ELSIF (AUB:STATUSS[11+C]=9)
    BRW1::AUT_TEXT_11_:NormalFG = -1
    BRW1::AUT_TEXT_11_:NormalBG = 65535
    BRW1::AUT_TEXT_11_:SelectedFG = 65535
    BRW1::AUT_TEXT_11_:SelectedBG = -1
  ELSIF (~AUB:STATUSS[11+C] AND (VIETA_NR=11+C))
    BRW1::AUT_TEXT_11_:NormalFG = -1
    BRW1::AUT_TEXT_11_:NormalBG = 12632256
    BRW1::AUT_TEXT_11_:SelectedFG = -1
    BRW1::AUT_TEXT_11_:SelectedBG = -1
  ELSE
    BRW1::AUT_TEXT_11_:NormalFG = -1
    BRW1::AUT_TEXT_11_:NormalBG = -1
    BRW1::AUT_TEXT_11_:SelectedFG = -1
    BRW1::AUT_TEXT_11_:SelectedBG = -1
  END
  BRW1::AUB:DATUMS = AUB:DATUMS
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
        BRW1::PopupText = '&Mainît(Aizpildît)  Grafiku|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Mainît(Aizpildît)  Grafiku'
      END
    ELSE
      IF BRW1::PopupText
        BRW1::PopupText = '~&Mainît(Aizpildît)  Grafiku|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '~&Mainît(Aizpildît)  Grafiku'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Change:2)
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => AUB:DATUMS
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
      POST(Event:Accepted,?Change:2)
      DO BRW1::FillBuffer
    OF CtrlEnter
      POST(Event:Accepted,?Change:2)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          SELECT(?AUB:DATUMS)
          PRESS(CHR(KEYCHAR()))
        END
      END
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
      AUB:DATUMS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
    IF SEND(AU_BILDE,'QUICKSCAN=on').
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
        StandardWarning(Warn:RecordFetchError,'AU_BILDE')
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
    IF SEND(AU_BILDE,'QUICKSCAN=off').
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
      BRW1::HighlightedPosition = POSITION(AUB:DAT_KEY)
      RESET(AUB:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(AUB:DAT_KEY,AUB:DAT_KEY)
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
    OF 1; ?AUB:DATUMS{Prop:Disable} = 0
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
  ELSE
    CLEAR(AUB:Record)
    CASE BRW1::SortOrder
    OF 1; ?AUB:DATUMS{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    ?Change:2{Prop:Disable} = 1
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
    SET(AUB:DAT_KEY)
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
  BrowseButtons.InsertButton=0
  BrowseButtons.ChangeButton=?Change:2
  BrowseButtons.DeleteButton=0
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
BRW1::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdateAU_BILDE) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateAU_BILDE
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
        GET(AU_BILDE,0)
        CLEAR(AUB:Record,0)
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


S_TTSN               PROCEDURE                    ! Declare Procedure
RejectRecord         LONG
LocalRequest         LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
!-----------------------------------------------------------------------------
Process:View         VIEW(AUTOAPK)
                       PROJECT(APK:ACC_DATUMS)
                       PROJECT(APK:ACC_KODS)
                       PROJECT(APK:AUT_NR)
                       PROJECT(APK:CTRL_DATUMS)
                       PROJECT(APK:DATUMS)
                       PROJECT(APK:Nobraukums)
                       PROJECT(APK:PAR_NR)
                       PROJECT(APK:PAV_NR)
                       PROJECT(APK:SAVIRZE_A)
                       PROJECT(APK:SAVIRZE_P)
                       PROJECT(APK:TEKSTS)
                     END
!-----------------------------------------------------------------------------
VUT                 STRING(25)
DATUMS              LONG
KLIENTS             STRING(25)
!-----------------------------------------------------------------------------
report REPORT,AT(198,1460,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
       HEADER,AT(200,200,8000,1260)
         STRING(@s45),AT(1823,52,4427,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6458,52,698,135),PAGENO,USE(?PageCount),RIGHT,FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         STRING('Transportlîdzekïa tehniskâ stâvokïa novçrtçjums'),AT(1927,313,4219,208),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts reì. Nr.:'),AT(208,573,990,208),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Dzinçja tilpums:'),AT(3021,781,1094,208),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(4167,781),USE(AUT:DZINEJS),LEFT
         STRING(@s25),AT(1042,781),USE(AUT:VIRSB_NR),LEFT
         STRING(@s12),AT(1250,573),USE(AUT:V_NR),LEFT
         STRING('Marka/modelis:'),AT(2240,573,1094,208),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(3333,573),USE(AUT:MARKA),LEFT
         STRING('Izl.gads:'),AT(5313,573,625,208),USE(?String181),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D13.),AT(5990,573),USE(AUT:MMYYYY),LEFT
         STRING('Ðasijas Nr.:'),AT(208,781,781,208),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,8000,7729)
         STRING('2.Savirze: pr.'),AT(2135,104,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-6.2),AT(2917,104,310,156),USE(APK:SAVIRZE_P) 
         STRING('aizm.'),AT(4063,260,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-6.2),AT(2917,260,310,156),USE(APK:SAVIRZE_A) 
         STRING('3.Amortizatori: pr.'),AT(3333,104,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-4.0),AT(4427,104,310,156),USE(APK:AMORT_P[1]) 
         STRING(@n-4.0),AT(4740,104,310,156),USE(APK:AMORT_P[2]) 
         STRING('aizm.'),AT(2552,260,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-4.0),AT(4427,260,310,156),USE(APK:AMORT_A[1]) 
         STRING(@n-4.0),AT(4740,260,310,156),USE(APK:AMORT_A[2]) 
         STRING('4.Bremzes: pr.'),AT(5156,104,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-5.1),AT(6042,104,310,156),USE(APK:BREMZES_P[1]) 
         STRING(@n-5.1),AT(6354,104,310,156),USE(APK:BREMZES_P[2]) 
         STRING('1. Kontrolbrauciens:'),AT(625,104,,156),USE(?String103),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('aizm.'),AT(5677,260,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-5.1),AT(6042,260,310,156),USE(APK:BREMZES_A[1]) 
         STRING(@n-5.1),AT(6354,260,310,156),USE(APK:BREMZES_A[2]) 
         LINE,AT(208,417,7292,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('5. Ritoðâs D.pârbaude:'),AT(625,521,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(2552,521,208,156),USE(APK:KAROGI[1]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.1. Pr.tilts'),AT(625,677,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2500,417,0,6563),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@s1),AT(2552,677,208,156),USE(APK:KAROGI[2]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.1.1. Pr.Râmja bukse'),AT(625,833,,156) 
         STRING(@s1),AT(2552,833,208,156),USE(APK:KAROGI[3]),CENTER 
         STRING('5.1.2. Sviras,lodbalsti,stab.-atsaite'),AT(625,990,,156) 
         STRING(@s1),AT(2552,990,208,156),USE(APK:KAROGI[4]),CENTER 
         LINE,AT(208,52,0,6927),USE(?Line3),COLOR(COLOR:Black)
         STRING('5.1.3. Rumbas gultòi'),AT(625,1146,,156) 
         STRING(@s1),AT(2552,1146,208,156),USE(APK:KAROGI[5]),CENTER 
         STRING('5.1.4. Pusas put.sargi'),AT(625,1302,,156) 
         STRING(@s1),AT(2552,1302,208,156),USE(APK:KAROGI[6]),CENTER 
         STRING('5.1.5. Pr.amort.atbalstbukses'),AT(625,1458,,156) 
         STRING(@s1),AT(2552,1458,208,156),USE(APK:KAROGI[7]),CENTER 
         STRING('5.1.6. Pr.amort.put.sargi'),AT(625,1615,,156) 
         STRING(@s1),AT(2552,1615,208,156),USE(APK:KAROGI[8]),CENTER 
         STRING('5.2. Stûres iekârta'),AT(625,1771,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(2552,1771,208,156),USE(APK:KAROGI[9]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.2.1. Stûres ðarnîri'),AT(625,1927,,156) 
         STRING(@s1),AT(2552,1927,208,156),USE(APK:KAROGI[10]),CENTER 
         STRING('5.2.2. Stûres meh.'),AT(625,2083,,156) 
         STRING(@s1),AT(2552,2083,208,156),USE(APK:KAROGI[11]),CENTER 
         STRING('5.2.3. St.Meh.Put.sargi'),AT(625,2240,,156) 
         STRING(@s1),AT(2552,2240,208,156),USE(APK:KAROGI[12]),CENTER 
         STRING('5.2.4. St.statnis,krustiòð'),AT(625,2396,,156) 
         STRING(@s1),AT(2552,2396,208,156),USE(APK:KAROGI[13]),CENTER 
         STRING('5.3. Pr.Bremþu iekârta'),AT(625,2552,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(2552,2552,208,156),USE(APK:KAROGI[14]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.3.1. Pr.br.Ðïauciòas'),AT(625,2708,,156) 
         STRING(@s1),AT(2552,2708,208,156),USE(APK:KAROGI[15]),CENTER 
         STRING('5.3.2. Pr.br.uzlikas'),AT(625,2865,,156) 
         STRING(@s1),AT(2552,2865,208,156),USE(APK:KAROGI[16]),CENTER 
         STRING('5.3.3. Pr.br.diski'),AT(625,3021,,156) 
         STRING(@s1),AT(2552,3021,208,156),USE(APK:KAROGI[17]),CENTER 
         STRING('5.3.4. Pr.br.devçji'),AT(625,3177,,156) 
         STRING(@s1),AT(2552,3177,208,156),USE(APK:KAROGI[18]),CENTER 
         STRING('5.3.5. Pr.br.suporti'),AT(625,3333,,156) 
         STRING(@s1),AT(2552,3333,208,156),USE(APK:KAROGI[19]),CENTER 
         STRING('5.4. Transmisija'),AT(625,3490,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(2552,3490,208,156),USE(APK:KAROGI[20]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.4.1. Dzinçja,kârbas spilveni'),AT(625,3646,,156) 
         STRING(@s1),AT(2552,3646,208,156),USE(APK:KAROGI[21]),CENTER 
         STRING('5.4.2. Kardâna krust.,piekares gultnis'),AT(625,3802,,156) 
         STRING(@s1),AT(2552,3802,208,156),USE(APK:KAROGI[22]),CENTER 
         STRING('5.4.3. Reduktors,spilvens,bukses'),AT(625,3958,,156) 
         STRING(@s1),AT(2552,3958,208,156),USE(APK:KAROGI[23]),CENTER 
         STRING('5.5. Aizm.tilts'),AT(625,4115,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(2552,4115,208,156),USE(APK:KAROGI[24]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.5.1. Aizm.tilta,râmja bukses'),AT(625,4271,,156) 
         STRING(@s1),AT(2552,4271,208,156),USE(APK:KAROGI[25]),CENTER 
         STRING('5.5.2. Sviras,lodbalsti,stab.-atsaite'),AT(625,4427,,156) 
         STRING(@s1),AT(2552,4427,208,156),USE(APK:KAROGI[26]),CENTER 
         STRING('5.5.3. Rumbas gultòi'),AT(625,4583,,156) 
         STRING(@s1),AT(2552,4583,208,156),USE(APK:KAROGI[27]),CENTER 
         STRING('5.5.4. Pusas put.sargi'),AT(625,4740,,156) 
         STRING(@s1),AT(2552,4740,208,156),USE(APK:KAROGI[28]),CENTER 
         STRING('5.5.5. Aizm.amort.atbalstbukses'),AT(625,4896,,156) 
         STRING(@s1),AT(2552,4896,208,156),USE(APK:KAROGI[29]),CENTER 
         STRING('5.5.6. Aizm.amort.put.sargi'),AT(625,5052,,156) 
         STRING(@s1),AT(2552,5052,208,156),USE(APK:KAROGI[30]),CENTER 
         STRING('5.6. Aizm.br.iekârta'),AT(625,5208,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(2552,5208,208,156),USE(APK:KAROGI[31]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.6.1. Aizm.br.Ðïauciòas'),AT(625,5365,,156) 
         STRING(@s1),AT(2552,5365,208,156),USE(APK:KAROGI[32]),CENTER 
         STRING('5.6.2. Aizm.br.uzlikas'),AT(625,5521,,156) 
         STRING(@s1),AT(2552,5521,208,156),USE(APK:KAROGI[33]),CENTER 
         STRING('5.6.3. Aizm.br.diski,trumuïi'),AT(625,5677,,156) 
         STRING(@s1),AT(2552,5677,208,156),USE(APK:KAROGI[34]),CENTER 
         STRING('5.6.4. Aizm.br.devçji'),AT(625,5833,,156) 
         STRING(@s1),AT(2552,5833,208,156),USE(APK:KAROGI[35]),CENTER 
         STRING('5.6.5. Aizm.br.suporti'),AT(625,5990,,156) 
         STRING(@s1),AT(2552,5990,208,156),USE(APK:KAROGI[36]),CENTER 
         STRING('5.6.6. Stâvbremze'),AT(625,6146,,156) 
         STRING(@s1),AT(2552,6146,208,156),USE(APK:KAROGI[37]),CENTER 
         STRING('6. Izplûdes sist.'),AT(625,6302,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(2552,6302,208,156),USE(APK:KAROGI[38]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6.1. Izplûdes sist.korozija'),AT(625,6458,,156) 
         STRING(@s1),AT(2552,6458,208,156),USE(APK:KAROGI[39]),CENTER 
         STRING('Diagnostiku veica:'),AT(625,7083),USE(?String173:4)
         STRING('Datums:'),AT(625,7292),USE(?String173:2)
         STRING('Laiks:'),AT(625,7500),USE(?String173:3)
         STRING('6.2. Stiprinâjumi,bojâjumi'),AT(625,6615,,156),USE(?String42) 
         STRING(@s1),AT(2552,6615,208,156),USE(APK:KAROGI[40]),CENTER 
         STRING('7. Mehâniski bojâjumi,korozija'),AT(625,6771,,156),USE(?String43),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(2552,6771,208,156),USE(APK:KAROGI[41]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,6979,7292,0),USE(?Line9),COLOR(COLOR:Black)
         STRING('Klients:'),AT(4635,7083),USE(?String173)
         STRING(@s25),AT(5156,7083),USE(KLIENTS),LEFT
         STRING(@s25),AT(1771,7083),USE(VUT),LEFT
         STRING(@D6),AT(1146,7292),USE(DATUMS),RIGHT
         STRING('8. Eïïu noplûde'),AT(4635,521,,156),USE(?String44),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,521,208,156),USE(APK:KAROGI[42]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6615,417,0,6563),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(2760,417,0,6563),USE(?Line3:3),COLOR(COLOR:Black)
         LINE,AT(6354,417,0,6563),USE(?Line3:4),COLOR(COLOR:Black)
         STRING('8.1. Dzinçjs'),AT(4635,677,,156),USE(?String45) 
         STRING(@s1),AT(6406,677,208,156),USE(APK:KAROGI[43]),CENTER 
         LINE,AT(7500,52,0,6927),USE(?Line3:6),COLOR(COLOR:Black)
         STRING('8.2. Kârba,sad.kârba'),AT(4635,833,,156),USE(?String46) 
         STRING(@s1),AT(6406,833,208,156),USE(APK:KAROGI[44]),CENTER 
         STRING('8.3. Reduktors'),AT(4635,990,,156),USE(?String47) 
         STRING(@s1),AT(6406,990,208,156),USE(APK:KAROGI[45]),CENTER 
         STRING('9. Siksnas'),AT(4635,1146,,156),USE(?String48),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,1146,208,156),USE(APK:KAROGI[46]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,52,7292,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('9.1. Ìeneratora siksna'),AT(4635,1302,,156),USE(?String49) 
         STRING(@s1),AT(6406,1302,208,156),USE(APK:KAROGI[47]),CENTER 
         STRING('9.2. Agregâtsiksnas'),AT(4635,1458,,156),USE(?String50) 
         STRING(@s1),AT(6406,1458,208,156),USE(APK:KAROGI[48]),CENTER 
         STRING('10. Riepas'),AT(4635,1615,,156),USE(?String51),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,1615,208,156),USE(APK:KAROGI[49]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('10.1. Protektors'),AT(4635,1771,,156),USE(?String52) 
         STRING(@s1),AT(6406,1771,208,156),USE(APK:KAROGI[50]),CENTER 
         STRING('10.2. Bojâjumi'),AT(4635,1927,,156),USE(?String53) 
         STRING(@s1),AT(6406,1927,208,156),USE(APK:KAROGI[51]),CENTER 
         STRING('11. Gaismas ierîces'),AT(4635,2083,,156),USE(?String54),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,2083,208,156),USE(APK:KAROGI[52]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('11.1. Gabarîti'),AT(4635,2240,,156),USE(?String55) 
         STRING(@s1),AT(6406,2240,208,156),USE(APK:KAROGI[53]),CENTER 
         STRING('11.2. Tuvie'),AT(4635,2396,,156),USE(?String56) 
         STRING(@s1),AT(6406,2396,208,156),USE(APK:KAROGI[54]),CENTER 
         STRING('11.3. Tâlie'),AT(4635,2552,,156),USE(?String57) 
         STRING(@s1),AT(6406,2552,208,156),USE(APK:KAROGI[55]),CENTER 
         STRING('11.4. Pr.miglas'),AT(4635,2708,,156),USE(?String58) 
         STRING(@s1),AT(6406,2708,208,156),USE(APK:KAROGI[56]),CENTER 
         STRING('11.5. Virzienrâdîtâji'),AT(4635,2865,,156),USE(?String59) 
         STRING(@s1),AT(6406,2865,208,156),USE(APK:KAROGI[57]),CENTER 
         STRING('11.6. Br.signâli'),AT(4635,3021,,156),USE(?String60) 
         STRING(@s1),AT(6406,3021,208,156),USE(APK:KAROGI[58]),CENTER 
         STRING('11.7. Atpakaïgaita'),AT(4635,3177,,156),USE(?String61) 
         STRING(@s1),AT(6406,3177,208,156),USE(APK:KAROGI[59]),CENTER 
         STRING('11.8. Aizm.miglas'),AT(4635,3333,,156),USE(?String62) 
         STRING(@s1),AT(6406,3333,208,156),USE(APK:KAROGI[60]),CENTER 
         STRING('11.9. Nummurapg.'),AT(4635,3490,,156),USE(?String63) 
         STRING(@s1),AT(6406,3490,208,156),USE(APK:KAROGI[61]),CENTER 
         STRING('12. Aprîkojums'),AT(4635,3646,,156),USE(?String64),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,3646,208,156),USE(APK:KAROGI[62]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('12.1. Vçjstiklu tîrîtâji'),AT(4635,3802,,156),USE(?String65) 
         STRING(@s1),AT(6406,3802,208,156),USE(APK:KAROGI[63]),CENTER 
         STRING('12.2. Skaòas signâli'),AT(4635,3958,,156),USE(?String66) 
         STRING(@s1),AT(6406,3958,208,156),USE(APK:KAROGI[64]),CENTER 
         STRING('12.3. Atpakaïgaitas spogulis'),AT(4635,4115,,156),USE(?String67) 
         STRING(@s1),AT(6406,4115,208,156),USE(APK:KAROGI[65]),CENTER 
         STRING('13. Atgâzes,dûmainîba'),AT(4635,4271,,156),USE(?String68),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,4271,208,156),USE(APK:KAROGI[66]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('14. Akumolators'),AT(4635,4427,,156),USE(?String69),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,4427,208,156),USE(APK:KAROGI[67]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('15. Dzesçðanas ðíidrums'),AT(4635,4583,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,4583,208,156),USE(APK:KAROGI[68]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('16. Logu ðíidrums'),AT(4635,4740,,156),USE(?String71),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,4740,208,156),USE(APK:KAROGI[69]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('17. Bremþu ðí.'),AT(4635,4896,,156),USE(?String72),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,4896,208,156),USE(APK:KAROGI[70]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('18. Lukturu lîmenis'),AT(4635,5052,,156),USE(?String73),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,5052,208,156),USE(APK:KAROGI[71]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('19. Vizuâlais apskats'),AT(4635,5208,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,5208,208,156),USE(APK:KAROGI[72]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('20. Akumolatora stirpinâjums'),AT(4635,5365,,156),USE(?String75),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6406,5365,208,156),USE(APK:KAROGI[73]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('21. Piezîmes'),AT(4635,5521,,156),USE(?String76),FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
       FOOTER,AT(200,9000,8000,219)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(AUTO,1)
  CHECKOPEN(AUTODARBI,1)
  CHECKOPEN(AUTOTEX,1)
  KLIENTS = GETAUTO(PAV:VED_NR,1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  BIND(APK:RECORD)
  BIND(PAV:RECORD)
  BIND(AUT:RECORD)
  BIND(APD:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(AUTOAPK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Completed'
  ProgressWindow{Prop:Text} = 'Generating Report'
  ?Progress:UserString{Prop:Text}=''
  SEND(AUTOAPK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(APK:RECORD)
      APK:PAV_NR=PAV:U_NR
      SET(APK:PAV_KEY,APK:PAV_KEY)
      Process:View{Prop:Filter} = 'APK:PAV_NR=PAV:U_NR'
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      END
      OPEN(Process:View)
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      END
      LOOP
        DO GetNextRecord
        DO ValidateRecord
        CASE RecordStatus
          OF Record:Ok
            BREAK
          OF Record:OutOfRange
            LocalResponse = RequestCancelled
            BREAK
        END
      END
      IF LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
        CYCLE
      END
      OPEN(report)
      report{Prop:Preview} = PrintPreviewImage
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        I#=GETPAVADZ(APK:PAV_NR)
        DATUMS = PAV:DATUMS
        CLEAR(APD:RECORD)
        APD:PAV_NR=PAV:U_NR
        VUT=GETKADRI(APD:ID,0,1)
        PRINT(RPT:detail)
        LOOP
          DO GetNextRecord
          DO ValidateRecord
          CASE RecordStatus
            OF Record:OutOfRange
              LocalResponse = RequestCancelled
              BREAK
            OF Record:OK
              BREAK
          END
        END
        IF LocalResponse = RequestCancelled
          LocalResponse = RequestCompleted
          BREAK
        END
        LocalResponse = RequestCancelled
      END
      IF LocalResponse = RequestCompleted
        CLOSE(ProgressWindow)
        BREAK
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
  IF SEND(AUTOAPK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    ENDPAGE(report)
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
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  DO ProcedureReturn
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
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
    AUTOAPK::Used -= 1
    IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!-----------------------------------------------------------------------------
ValidateRecord       ROUTINE
!|
!| This routine is used to provide for complex record filtering and range limiting. This
!| routine is only generated if you've included your own code in the EMBED points provided in
!| this routine.
!|
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'AUTOAPK')
    END
    LocalResponse = RequestCancelled
    EXIT
  ELSE
    LocalResponse = RequestCompleted
  END
  RecordsProcessed += 1
  RecordsThisCycle += 1
  IF PercentProgress < 100
    PercentProgress = (RecordsProcessed / RecordsToProcess)*100
    IF PercentProgress > 100
      PercentProgress = 100
    END
    IF PercentProgress <> Progress:Thermometer THEN
      Progress:Thermometer = PercentProgress
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
S_MARSRUTI PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
M_TABLE              QUEUE,PRE()
M:NPK                USHORT
M:GRUPA              STRING(6)
M:PiegAdrese         STRING(30)
M:NOS_P              STRING(30)
M:SUMMAP             DECIMAL(12,2),DIM(20)
M:DLaiks             STRING(25)
M:TEL                STRING(15)
M:KontPers           STRING(25)
M:Vestule            STRING(25)
M:KEY                STRING(8)
                     END
DATUMS              LONG
MA_NR               STRING(1)  !PAV:DOK_SENR[1]
VUT                 STRING(25) !SEC:VUT

M_SUMMAP            DECIMAL(12,2)
M_DLAIKS            STRING(15)
M_DLAIKS2            STRING(15)

PZSkaits            DECIMAL(10)
SummaPK             DECIMAL(12,2)
DAT                 LONG
LAI                 LONG


report REPORT,AT(198,2104,12000,5698),PAPER(9),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),LANDSCAPE,THOUS
       HEADER,AT(198,198,12000,1906)
         STRING(@s45),AT(3698,104,4479,260),FONT(,12,,FONT:bold,CHARSET:BALTIC),USE(CLIENT),CENTER
         STRING('MARÐRUTA LAPA'),AT(1250,104,1354,208),FONT(,11,,FONT:bold,CHARSET:BALTIC),USE(?String2),LEFT
         LINE,AT(1250,313,1354,0),USE(?Line1),COLOR(00H)
         STRING(@D6),AT(1771,365),FONT(,,,FONT:bold,CHARSET:BALTIC),USE(S_DAT),RIGHT
         STRING('Datums'),AT(1250,365,521,208),FONT(,,,FONT:bold,CHARSET:BALTIC),USE(?String3)
         STRING('Marðruta nr.'),AT(1250,573,833,208),FONT(,,,FONT:bold,CHARSET:BALTIC),USE(?String3:2)
         STRING(@S1),AT(2083,573,781,208),FONT(,,,FONT:bold,CHARSET:BALTIC),USE(MA_NR),LEFT
         STRING('Ekspeditors'),AT(1250,781,833,208),FONT(,,,FONT:bold,CHARSET:BALTIC),USE(?String3:3)
         STRING(@P<<<#.lapaP),AT(10052,781),FONT('Arial',8,,),PAGENO,USE(?PageNo),RIGHT
         STRING(@s25),AT(2083,781),USE(VUT)
         LINE,AT(208,1042,11094,0),USE(?Line2),COLOR(00H)
         STRING('Npk'),AT(250,1354,365,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8),CENTER
         STRING('Reìiona,'),AT(656,1094,521,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:2),CENTER
         LINE,AT(6979,1042,0,885),USE(?Line3:7),COLOR(00H)
         LINE,AT(5938,1042,0,885),USE(?Line3:6),COLOR(00H)
         LINE,AT(3958,1042,0,885),USE(?Line3:5),COLOR(00H)
         LINE,AT(3125,1042,0,885),USE(?Line3:4),COLOR(00H)
         LINE,AT(1198,1042,0,885),USE(?Line3:3),COLOR(00H)
         STRING('pils.,'),AT(656,1250,521,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:3),CENTER
         LINE,AT(9688,1042,0,885),USE(?Line3:10),COLOR(00H)
         LINE,AT(11302,1042,0,885),USE(?Line3:9),COLOR(00H)
         LINE,AT(8021,1042,0,885),USE(?Line3:8),COLOR(00H)
         STRING('Klienta nosaukums'),AT(1229,1354,1875,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:7),CENTER
         STRING('P/Z summa'),AT(3156,1354,781,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:8),CENTER
         STRING('Piegâdes adrese'),AT(3990,1354,1927,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:9),CENTER
         STRING('Darba laiks'),AT(5969,1354,990,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:10),CENTER
         STRING('Tâlrunis'),AT(7010,1354,990,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:11),CENTER
         STRING('Kontaktpersonas'),AT(8052,1354,1615,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:12),CENTER
         STRING('rajona,'),AT(656,1406,521,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:4),CENTER
         STRING('Vçstule'),AT(9719,1354,1563,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:13),CENTER
         STRING('menedþ.'),AT(656,1563,521,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:5),CENTER
         STRING('kods'),AT(656,1719,521,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:6),CENTER
         LINE,AT(208,1875,11094,0),USE(?Line2:2),COLOR(00H)
         LINE,AT(625,1042,0,885),USE(?Line3:2),COLOR(00H)
         LINE,AT(208,1042,0,885),USE(?Line3),COLOR(00H)
       END
detail DETAIL,AT(,-10,,177)
         LINE,AT(208,0,0,198),USE(?Line14),COLOR(00H)
         STRING(@n_5),AT(260,10,313,156) ,USE(M:NPK),RIGHT
         STRING(@s30),AT(1240,10,1875,156) ,USE(M:Nos_P),LEFT
         STRING(@n-_12.2B),AT(3177,10,729,156) ,USE(M_SummaP,,?M_SummaP:2),RIGHT
         STRING(@s30),AT(4000,10,1927,156) ,USE(M:PiegAdrese),LEFT
         STRING(@s15),AT(5979,10,990,156) ,USE(M_DLaiks,,?M_DLaiks:2),LEFT
         STRING(@s15),AT(7021,10,990,156) ,USE(M:Tel,,?M:Tel:2),LEFT
         STRING(@s25),AT(8063,10,1615,156) ,USE(M:KontPers,,?M:KontPers:2),LEFT
         STRING(@s25),AT(9729,10,1563,156) ,USE(M:Vestule),LEFT
         STRING(@s6),AT(729,10,417,156) ,USE(M:GRUPA),LEFT
         LINE,AT(625,0,0,198),USE(?Line14:2),COLOR(00H)
         LINE,AT(1198,0,0,198),USE(?Line14:22),COLOR(00H)
         LINE,AT(3125,0,0,198),USE(?Line14:3),COLOR(00H)
         LINE,AT(3958,0,0,198),USE(?Line14:7),COLOR(00H)
         LINE,AT(5938,0,0,198),USE(?Line14:6),COLOR(00H)
         LINE,AT(6979,0,0,198),USE(?Line14:8),COLOR(00H)
         LINE,AT(8021,0,0,198),USE(?Line14:4),COLOR(00H)
         LINE,AT(9688,0,0,198),USE(?Line14:9),COLOR(00H)
         LINE,AT(11302,0,0,198),USE(?Line14:5),COLOR(00H)
       END
detail1 DETAIL,AT(,-10,,177)
         LINE,AT(208,0,0,198),USE(?Line114),COLOR(00H)
         STRING(@n-_12.2B),AT(3177,10,729,156) ,USE(M_SummaP),RIGHT
         STRING(@s15),AT(5979,10,990,156) ,USE(M_DLaiks2),LEFT
         LINE,AT(625,0,0,198),USE(?Line114:2),COLOR(00H)
         LINE,AT(1198,0,0,198),USE(?Line114:22),COLOR(00H)
         LINE,AT(3125,0,0,198),USE(?Line114:3),COLOR(00H)
         LINE,AT(3958,0,0,198),USE(?Line114:7),COLOR(00H)
         LINE,AT(5938,0,0,198),USE(?Line114:6),COLOR(00H)
         LINE,AT(6979,0,0,198),USE(?Line114:8),COLOR(00H)
         LINE,AT(8021,0,0,198),USE(?Line114:4),COLOR(00H)
         LINE,AT(9688,0,0,198),USE(?Line114:9),COLOR(00H)
         LINE,AT(11302,0,0,198),USE(?Line114:5),COLOR(00H)
       END
Rep_Foot DETAIL,AT(,-10,,594)
         LINE,AT(208,52,11094,0),USE(?Line2:3),COLOR(00H)
         STRING('Kopâ P/Z skaits:'),AT(1615,104,938,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:14),LEFT
         STRING(@n_10),AT(2656,104,677,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(PZSkaits),RIGHT
         STRING(@D6),AT(10344,104) ,USE(DAT)
         STRING(@T1),AT(10958,104) ,USE(LAI)
         LINE,AT(1563,260,990,0),USE(?Line35),COLOR(00H)
         STRING('Kopâ P/Z summa:'),AT(1510,313,1042,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String8:15),LEFT
         STRING(@n-_12.2B),AT(2604,313,729,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(SummaPK),RIGHT
         LINE,AT(1510,469,1042,0),USE(?Line35:2),COLOR(00H)
         LINE,AT(208,0,0,62),USE(?Line25),COLOR(00H)
         LINE,AT(625,0,0,62),USE(?Line225),COLOR(00H)
         LINE,AT(1198,0,0,62),USE(?Line235),COLOR(00H)
         LINE,AT(3125,0,0,62),USE(?Line25:4),COLOR(00H)
         LINE,AT(3958,0,0,62),USE(?Line25:8),COLOR(00H)
         LINE,AT(5938,0,0,62),USE(?Line25:3),COLOR(00H)
         LINE,AT(6979,0,0,62),USE(?Line25:5),COLOR(00H)
         LINE,AT(8021,0,0,62),USE(?Line25:7),COLOR(00H)
         LINE,AT(9688,0,0,62),USE(?Line25:6),COLOR(00H)
         LINE,AT(11302,0,0,62),USE(?Line25:2),COLOR(00H)
       END
       FOOTER,AT(198,7800,12000,52)
         LINE,AT(208,0,10573,0),USE(?Line2:4),COLOR(00H)
       END
     END

P_TABLE           QUEUE,PRE(P)
KODS                STRING(22)
NOMENKLAT           STRING(21)
SKAITS              DECIMAL(12)
                  .
NPK                 USHORT
NOSAUKUMS           STRING(30)
KASTES              DECIMAL(12)
GAB                 DECIMAL(15)

!-------------------------------------------------------------------------------
report1 REPORT,AT(198,1802,8000,9500),PAPER(9),PRE(RPT),FONT('Arial Baltic',10,,FONT:bold,CHARSET:BALTIC),THOUS
       HEADER,AT(198,198,8000,1604)
         STRING(@s35),AT(2240,52,3542,260),FONT(,12,,FONT:bold,CHARSET:BALTIC),USE(CLIENT,,?CLIENT1),CENTER
         STRING('MARÐRUTA PREÈU LAPA'),AT(1458,365,1979,208),FONT(,11,,FONT:bold,CHARSET:BALTIC),USE(?String92)
         LINE,AT(1406,573,2031,0),USE(?Line91),COLOR(00H)
         STRING('Datums'),AT(1458,625),FONT(,,,FONT:bold,CHARSET:BALTIC),USE(?String93)
         STRING(@D6),AT(1979,625),FONT(,10,,FONT:bold,CHARSET:BALTIC),USE(S_DAT,,S_DAT2),RIGHT
         STRING('Marðruta nr.'),AT(1458,833),FONT(,,,FONT:bold,CHARSET:BALTIC),USE(?String93:2)
         STRING(@S1),AT(2344,833,781,208),FONT(,10,,FONT:bold,CHARSET:BALTIC),USE(MA_NR,,?MA_NR2),LEFT
         STRING('Ekspeditors'),AT(1458,1042),FONT(,,,FONT:bold,CHARSET:BALTIC),USE(?String5)
         STRING(@P<<<#.lapaP),AT(6719,1042) ,PAGENO,USE(?PageNo2)
         STRING(@s25),AT(2292,1042),FONT(,,,FONT:bold,CHARSET:BALTIC),USE(VUT,,?VUT2)
         LINE,AT(208,1302,7083,0),USE(?Line299),COLOR(00H)
         STRING('Npk'),AT(240,1354,365,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String6),CENTER
         STRING('Kods'),AT(885,1354,833,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String6:2),CENTER
         STRING('Skaits gab.'),AT(2115,1354,781,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String6:3),CENTER
         STRING('Nosaukums'),AT(2958,1344,2552,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String6:4),CENTER
         STRING('Kastes'),AT(5563,1354,833,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String6:5),CENTER
         STRING('Gab.'),AT(6448,1354,833,208),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String6:6),CENTER
         LINE,AT(208,1563,7083,0),USE(?Line92:2),COLOR(00H)
         LINE,AT(7292,1302,0,313),USE(?Line93:7),COLOR(00H)
         LINE,AT(6406,1302,0,313),USE(?Line93:6),COLOR(00H)
         LINE,AT(5521,1302,0,313),USE(?Line93:5),COLOR(00H)
         LINE,AT(2917,1302,0,313),USE(?Line93:4),COLOR(00H)
         LINE,AT(2083,1302,0,313),USE(?Line93:3),COLOR(00H)
         LINE,AT(604,1302,0,313),USE(?Line93:2),COLOR(00H)
         LINE,AT(208,1302,0,313),USE(?Line93),COLOR(00H)
       END
detail2 DETAIL,AT(,-10,,177)
         LINE,AT(208,0,0,198),USE(?Line11),COLOR(00H)
         STRING(@n_5),AT(250,10,313,156) ,USE(NPK),RIGHT
         STRING(@N_10),AT(2208,10,,156) ,USE(P:SKAITS),CENTER
         STRING(@s40),AT(2958,10,2552,156) ,USE(NOSAUKUMS)
         STRING(@N_12b),AT(5573,10,781,156) ,USE(KASTES),RIGHT
         STRING(@N_12b),AT(6458,10,,156) ,USE(GAB),RIGHT
         LINE,AT(604,0,0,198),USE(?Line11:6),COLOR(00H)
         STRING(@s22),AT(646,21,,156) ,USE(P:KODS)
         LINE,AT(2083,0,0,198),USE(?Line11:7),COLOR(00H)
         LINE,AT(2917,0,0,198),USE(?Line11:2),COLOR(00H)
         LINE,AT(5521,0,0,198),USE(?Line11:4),COLOR(00H)
         LINE,AT(6406,0,0,198),USE(?Line11:5),COLOR(00H)
         LINE,AT(7292,0,0,198),USE(?Line11:3),COLOR(00H)
       END
Rep_Foot2 DETAIL,AT(,-10,,604)
         LINE,AT(208,52,7083,0),USE(?Line29:3),COLOR(00H)
         STRING('Kopâ P/Z skaits:'),AT(1302,156,938,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String6:7),RIGHT
         STRING(@N_10),AT(2344,156,677,156),FONT('Arial',8,,FONT:bold,CHARSET:BALTIC),USE(PZSKAITS,,?PZSKAITS2),RIGHT
         LINE,AT(1302,313,938,0),USE(?Line26),COLOR(00H)
         STRING('Kopâ P/Z summa:'),AT(1198,365,1042,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String6:8),RIGHT
         STRING(@N-_12.2B),AT(2292,365,729,156),FONT('Arial',8,,FONT:bold,CHARSET:BALTIC),USE(SUMMAPK,,?SUMMAPK2),RIGHT
         LINE,AT(1250,521,990,0),USE(?Line26:2),COLOR(00H)
         LINE,AT(208,0,0,62),USE(?Line19:3),COLOR(00H)
         LINE,AT(604,0,0,62),USE(?Line19),COLOR(00H)
         LINE,AT(2083,0,0,62),USE(?Line19:5),COLOR(00H)
         LINE,AT(2917,0,0,62),USE(?Line199),COLOR(00H)
         LINE,AT(5521,0,0,62),USE(?Line199:3),COLOR(00H)
         LINE,AT(6406,0,0,62),USE(?Line19:4),COLOR(00H)
         LINE,AT(7292,0,0,62),USE(?Line19:2),COLOR(00H)
       END
       FOOTER,AT(198,11300,8000,52)
         LINE,AT(729,0,6563,0),USE(?Line27:4),COLOR(00H)
       END
     END
!-------------------------------------------------------------------------------
windowMS             WINDOW('Marðruta sastâdîðana'),AT(,,325,196),FONT(,9,,FONT:bold),GRAY
                       LIST,AT(2,3,319,174),USE(?List1),FORMAT('18R(1)|~NPK~L(0)@n_3@24L|~Kods~C@s6@122L|~Piegâdes adrese~@s30@120L|~Klients~@s3' &|
   '0@'),FROM(M_TABLE)
                       BUTTON('&OK'),AT(287,179,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Uz Augðu'),AT(18,179,48,14),USE(?ButtonUP)
                       BUTTON('Uz &Leju'),AT(68,179,48,14),USE(?Buttondown)
                       BUTTON('&Atlikt'),AT(247,179,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
   !stâvam uz vajadziga PPR
    MA_NR=PAV:DOK_SENR[1]
    VUT  =GETPAROLES(ACC_KODS_N,2)
    S_DAT=PAV:DATUMS
    B_DAT=PAV:DATUMS
  
    CHECKOPEN(GLOBAL,1)
    CHECKOPEN(SYSTEM,1)
    DAT = TODAY()
    LAI = CLOCK()
    CLEAR(PAV:RECORD)
    PAV:D_K='K'
    PAV:DATUMS=S_DAT
    SET(PAV:DAT_KEY,PAV:DAT_KEY)
    LOOP
      PREVIOUS(PAVAD)
      IF ERROR() OR PAV:DATUMS>B_DAT THEN BREAK.
      IF PAV:D_K='K' AND PAV:DOK_SENR[1]=MA_NR  !VACAM KOPA AR VIENADIEM NR
         PZSkaits  += 1
         M:KEY=FORMAT(PAV:PAR_NR,@N_7)&PAV:PAR_ADR_NR
         GET(M_TABLE,M:KEY)
         IF ERROR()
            IF ~PAV:PAR_NR
               M:NOS_P=PAV:NOKA
               M:KontPers = ''
               M:GRUPA=''
            ELSE
               M:NOS_P=GETPAR_K(PAV:PAR_NR,2,2)
               M:KontPers = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,4)
               M:GRUPA=GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,3)
            .
            M:PiegAdrese = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
            M:DLaiks     = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,1)
            M:TEL        = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,2)
            M:Vestule    = GETPAR_ATZIME(PAR:ATZIME1,1)
            M:SummaP[1]  = PAV:SUMMA
            ADD(M_TABLE)
         ELSE
            LOOP I#= 1 TO 20
               IF ~M:SummaP[I#]
                  M:SummaP[I#]  = PAV:SUMMA
                  PUT(M_TABLE)
                  BREAK
               .
            .
         .
         SummaPK     += PAV:SUMMA
         CLEAR(NOL:RECORD)
         NOL:U_NR=PAV:U_NR
         SET(NOL:NR_KEY,NOL:NR_KEY)
         LOOP
            NEXT(NOLIK)
            IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
            P:KODS=GETNOM_K(NOL:NOMENKLAT,0,14) !kataloga nr
            P:NOMENKLAT=NOL:NOMENKLAT
            GET(P_TABLE,P:KODS)
            IF ERROR()
               P:SKAITS=NOL:DAUDZUMS
               ADD(P_TABLE)
               SORT(P_TABLE,P:KODS)
            ELSE
               P:SKAITS+=NOL:DAUDZUMS
               PUT(P_TABLE)
            .
         .
      .
      SORT(M_TABLE,M:GRUPA)
      GET(M_TABLE,0)
      LOOP I#= 1 TO RECORDS(M_TABLE)
         GET(M_TABLE,I#)
         M:NPK=I#
         PUT(M_TABLE)
      .
    .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  SELECT(?LIST1,1)
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?List1)
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
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
        GET(M_TABLE,0)
        LOOP I#= 1 TO RECORDS(M_TABLE)
           GET(M_TABLE,I#)
           TEKSTS=M:DLAIKS
           FORMAT_TEKSTS(22,'Arial',8,'')
           M_DLAIKS = F_TEKSTS[1]
           M_DLAIKS2= F_TEKSTS[2]
           LOOP J#= 1 TO 20
              IF M:SUMMAP[J#] OR M_DLAIKS2
                 M_SUMMAP=M:SUMMAP[J#]
                 IF J#=1
                    PRINT(RPT:DETAIL)
                 ELSE
                    PRINT(RPT:DETAIL1)
                    M_DLAIKS2=''
                 .
              .
           .
        .
        PRINT(RPT:REP_FOOT)
        ENDPAGE(report)
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
      
        OPEN(report1)
        report1{Prop:Preview} = PrintPreviewImage
        GET(P_TABLE,0)
        LOOP I#= 1 TO RECORDS(P_TABLE)
           GET(P_TABLE,I#)
           NPK+=1
           NOSAUKUMS=GETNOM_K(P:NOMENKLAT,0,2)
           IF NOM:SKAITS_I AND P:SKAITS>=NOM:SKAITS_I
              KASTES=INT(P:SKAITS/NOM:SKAITS_I)
              GAB=P:SKAITS-KASTES*NOM:SKAITS_I
           ELSE
              KASTES=0
              GAB=P:SKAITS
           .
           PRINT(RPT:DETAIL2)
        .
        PRINT(RPT:REP_FOOT2)
        ENDPAGE(report1)
        RP
        IF Globalresponse = RequestCompleted
           loop J#=1 to PR:SKAITS
              report1{Prop:FlushPreview} = True
              IF ~(J#=PR:SKAITS)
                 loop I#= 1 to RECORDS(PrintPreviewQueue1)
                    GET(PrintPreviewQueue1,I#)
                    PrintPreviewImage=PrintPreviewImage1
                    add(PrintPreviewQueue)
                 .
              .
           .
        END
        CLOSE(report1)
        FREE(PrintPreviewQueue)
        FREE(PrintPreviewQueue1)
        BREAK
      
    OF ?ButtonUP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF CHOICE(?LIST1) > 1
           GET(M_TABLE,CHOICE(?LIST1))
           M:NPK-=1
           PUT(M_TABLE)
           GET(M_TABLE,CHOICE(?LIST1)-1)
           M:NPK+=1
           PUT(M_TABLE)
           SORT(M_TABLE,M:NPK)
           SELECT(?LIST1,CHOICE(?LIST1)-1)
        ELSE
           SELECT(?LIST1,CHOICE(?LIST1))
        .
        DISPLAY
      END
    OF ?Buttondown
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF CHOICE(?LIST1) < RECORDS(M_TABLE)
           GET(M_TABLE,CHOICE(?LIST1))
           M:NPK+=1
           PUT(M_TABLE)
           GET(M_TABLE,CHOICE(?LIST1)+1)
           M:NPK-=1
           PUT(M_TABLE)
           SORT(M_TABLE,M:NPK)
           SELECT(?LIST1,CHOICE(?LIST1)+1)
        ELSE
           SELECT(?LIST1,CHOICE(?LIST1))
        .
        DISPLAY
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        BREAK
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  FilesOpened = True
  OPEN(windowMS)
  WindowOpened=True
  INIRestoreWindow('S_MARSRUTI','winlats.INI')
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
    FREE(M_TABLE)
  END
  IF WindowOpened
    INISaveWindow('S_MARSRUTI','winlats.INI')
    CLOSE(windowMS)
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
  IF windowMS{Prop:AcceptAll} THEN EXIT.
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
