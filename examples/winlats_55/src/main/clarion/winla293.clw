                     MEMBER('winlats.clw')        ! This is a MEMBER module
ReferFixGG_NoKont PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
local_path           STRING(40)
records_open_all     STRING(25)
dat1_key_nr          LONG
summa_ggkk           DECIMAL(11,2)
summa_s              DECIMAL(11,2)
summa_sk             DECIMAL(11,2)
parads_s             DECIMAL(11,2)
summa_t              DECIMAL(11,2)
summa_tk             DECIMAL(11,2)
parads_t             DECIMAL(11,2)
summa_tot            DECIMAL(11,2)
summa_bezR           STRING(20)
i_d_k                STRING(1)
DOK_NR               STRING(14)
GG_APMDAT            LONG
F:NESAMAKSATAS       STRING(1)
SAVE_POSITION   STRING(256)
SAV_POSITION    STRING(256)
GG_RECORD       LIKE(GG:RECORD)
gg_datums_NEW   LIKE(GG:DATUMS)  !GRÂMATOJUMA DATUMS

BRW1::View:Browse    VIEW(GGK)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:VAL)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:U_NR)
                       JOIN(GG:NR_KEY,GGK:U_NR)
                         PROJECT(GG:KEKSIS)
                         PROJECT(GG:RS)
                         PROJECT(GG:DOKDAT)
                         PROJECT(GG:APMDAT)
                         PROJECT(GG:SATURS)
                         PROJECT(GG:U_NR)
                       END
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::GG:KEKSIS        LIKE(GG:KEKSIS)            ! Queue Display field
BRW1::GG:RS            LIKE(GG:RS)                ! Queue Display field
BRW1::DOK_NR           LIKE(DOK_NR)               ! Queue Display field
BRW1::GG:DOKDAT        LIKE(GG:DOKDAT)            ! Queue Display field
BRW1::GG_APMDAT        LIKE(GG_APMDAT)            ! Queue Display field
BRW1::GG:SATURS        LIKE(GG:SATURS)            ! Queue Display field
BRW1::GGK:SUMMAV       LIKE(GGK:SUMMAV)           ! Queue Display field
BRW1::GGK:VAL          LIKE(GGK:VAL)              ! Queue Display field
BRW1::summa_s          LIKE(summa_s)              ! Queue Display field
BRW1::val_nos          LIKE(val_nos)              ! Queue Display field
BRW1::KKK              LIKE(KKK)                  ! Queue Display field
BRW1::i_d_k            LIKE(i_d_k)                ! Queue Display field
BRW1::ATLAUTS          LIKE(ATLAUTS)              ! Queue Display field
BRW1::GGK:PAR_NR       LIKE(GGK:PAR_NR)           ! Queue Display field
BRW1::GGK:DATUMS       LIKE(GGK:DATUMS)           ! Queue Display field
BRW1::GGK:U_NR         LIKE(GGK:U_NR)             ! Queue Display field
BRW1::GG:U_NR          LIKE(GG:U_NR)              ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(GGK:DATUMS),DIM(100)
BRW1::Sort1:LowValue LIKE(GGK:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(GGK:DATUMS)            ! Queue position of scroll thumb
BRW1::Sort1:Reset:PAR_NR LIKE(PAR_NR)
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
WinResize            WindowResizeType
QuickWindow          WINDOW(' '),AT(0,0,473,270),FONT('MS Sans Serif',9,,FONT:bold),IMM,VSCROLL,HLP(' '),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(5,18,463,213),USE(?Browse:1),IMM,VSCROLL,FONT(,9,,),MSG('Browsing Records'),FORMAT('10C|M~X~@n1B@10C|M~Y~@n1B@57R(1)|M~Dok.Nr~C(0)@S14@44R(1)|M~Dok.Datums~C(0)@d06.' &|
   '@44R(1)|M~Jâmaksâ~C(0)@D06.@140L(1)|M~Dokumenta saturs~C(0)@s45@55D(12)M~Summa~C' &|
   '(0)@n-15.2@14L|M@s3@55D(12)M~Iepriekð~C(0)@n-15.2@14L|M@s3@'),FROM(Queue:Browse:1)
                       SHEET,AT(2,2,470,268),USE(?CurrentTab)
                         TAB('Atrastie Debitoru/Kreditoru dokumenti'),USE(?Tab:2)
                           BUTTON('&Noòemt apm.'),AT(85,233,56,15),USE(?NonApm),DISABLE,HIDE
                           BUTTON('&Fiksçt apm.'),AT(29,233,54,15),USE(?FixApm),DISABLE,HIDE
                           BUTTON('&X'),AT(6,233,12,15),USE(?KeksisX)
                           STRING(@n-15.2),AT(410,235,57,10),USE(summa_tk),RIGHT(1),FONT(,,,FONT:bold)
                           STRING(@n-15.2),AT(349,235),USE(summa_sk),RIGHT(1)
                           STRING('Kopâ :'),AT(258,235),USE(?String4:2)
                           STRING(@n-15.2),AT(286,235),USE(summa_ggkk),RIGHT(1)
                           BUTTON('Fiksçt &savâdâku apm.'),AT(143,233,79,15),USE(?FixSavApm),DISABLE,HIDE
                           BUTTON('&OK Akceptçt'),AT(119,250,51,15),USE(?OKAkceptet),DEFAULT
                           BUTTON('&Atteikties'),AT(172,250,50,15),USE(?Cancel)
                           STRING('Parâds kopâ :'),AT(303,255),USE(?String5)
                           STRING(@n-15.2),AT(349,254),USE(parads_s),RIGHT(1)
                           STRING(@n-15.2),AT(410,253,57,10),USE(parads_t),RIGHT(1)
                           STRING('Atrastas apmaksas bez Ref. :'),AT(254,245),USE(?String4)
                           STRING(@n-15.2B),AT(350,244),USE(summa_bezR),RIGHT(1),FONT(,,COLOR:Red,,CHARSET:ANSI)
                           BUTTON('&Tikai nesamaksâtâs'),AT(19,250,73,15),USE(?ButtonFNesam)
                           IMAGE('CHECK2.ICO'),AT(95,249,17,18),USE(?ImageFNES),HIDE
                         END
                       END
                     END
  CODE
  PUSHBIND
  BIND('CycleApmaksa',CycleApmaksa)
  BIND('F:NESAMAKSATAS',F:NESAMAKSATAS)
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  CHECKOPEN(SYSTEM,1)
  SAVE_POSITION=POSITION(GG)
  GG_RECORD=GG:RECORD
  SAV_DATUMS=GG:DATUMS
  GG_DATUMS_NEW=GG:DATUMS
  IF D_K='D'
     I_D_K='K'
  ELSIF D_K='K'
     I_D_K='D'
  ELSE
     STOP('D_K='&D_K)
  .
  IF ATLAUTS[18]='1'  !AIZLIEGTI NEAPSTIPRINÂTIE
     RS='A'
  ELSE
     RS='V'
  .
  SUMMA_TOT=PerfAtable_NoKont(1,'','',RS,PAR_NR,'',0,0,'',0)     ! Uzbûvç apmaksu A-table,atgrieþ total_apm summu
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  quickwindow{prop:text}='Norçíini ar: '&CLIP(gg:noka)&' Konti: '&i_d_k&kkk
  
  ACCEPT
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
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
    OF ?NonApm
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
!        DO SyncWindow
!        SUMMA=0
!        val_nos=''
!        I#=PerfAtable(5,DOK_NR,GGK:BKK,'',PAR_NR,'',0,0,'',0)  !5-noòemt apmaksu
!        !DO BRW1::InitializeBrowse
!        summa_tk-=summa_t
!        parads_t=parads_s-summa_tk
!        !
!        DO BRW1::RefreshPage
!        SELECT(?Browse:1)
!        DISPLAY
        
      END
    OF ?FixApm
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
!        DO SyncWindow
!        SUMMA=GGK:SUMMAV
!        val_nos=GGK:VAL
!        I#=PerfAtable(4,DOK_NR,GGK:BKK,'',PAR_NR,GGK:NODALA,GGK:OBJ_NR,GGK:U_NR,'',GGK:PVN_PROC)
!        
!        !IF ACC_KODS_N=0 AND GG_DATUMS_NEW AND KKK[1:3]='231'  !ASSAKO, MAINÂM GRÂMATOJUMA DATUMU RÇÍINIEM
!        !   GG:DATUMS=GG_DATUMS_NEW
!        !   GG:SECIBA=CLOCK()
!        !   IF RIUPDATE:GG()
!        !     KLUDA(24,'GG')
!        !   ELSE
!        !      CLEAR(GGK:RECORD)
!        !      GGK:U_NR=GG:U_NR
!        !      SET(GGK:NR_KEY,GG:NR_KEY)
!        !      LOOP
!        !         NEXT(GGK)
!        !         IF ERROR() OR ~(GGK:U_NR=GG:U_NR) THEN BREAK.
!        !         GGK:DATUMS=GG:DATUMS
!        !         IF RIUPDATE:GGK()
!        !            KLUDA(24,'GGK')
!        !         .
!        !      .
!        !   .
!        !.
!        !
!        !DO BRW1::InitializeBrowse
!        
!        summa_tk+=SUMMA
!        parads_t=parads_s-summa_tk
!        !
!        DO BRW1::RefreshPage
!        SELECT(?Browse:1)
!        DISPLAY
      END
    OF ?KeksisX
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        EXECUTE GG:KEKSIS+1
           gg:keksis=1
           GG:KEKSIS=2
           GG:KEKSIS=0
        .
        IF RIUPDATE:GG()
           KLUDA(24,'GG')
        .
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        SELECT(?Browse:1)
      END
    OF ?FixSavApm
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
!        DO SyncWindow
!        SUMMA=GGK:SUMMAV-SUMMA_S
!        val_nos=GGK:VAL
!        I#=PerfAtable(6,DOK_NR,GGK:BKK,'',PAR_NR,GGK:NODALA,GGK:OBJ_NR,GGK:U_NR,'',GGK:PVN_PROC) !IZSAUC SUMMA_W
!        !DO BRW1::InitializeBrowse
!        summa_tk+=SUMMA
!        parads_t=parads_s-summa_tk
!        !
!        DO BRW1::RefreshPage
!        SELECT(?Browse:1)
!        DISPLAY
        
      END
    OF ?OKAkceptet
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
!        IF summa_tk=0
!           DO SyncWindow
!           SUMMA=GGK:SUMMA
!           val_nos=GGK:VAL
!           I#=PerfAtable(4,DOK_NR,GGK:BKK,'',PAR_NR,GGK:NODALA,GGK:OBJ_NR,GGK:U_NR,'',GGK:PVN_PROC)

!        .
        free(A_TABLE)
        A:REFERENCE=DOK_NR
        A:PAR_NR=GGK:PAR_NR
        A:SUMMAV=GGK:SUMMAV
        A:SUMMA =GGK:SUMMA
        A:VAL=GGK:VAL
        A:SUMMAV_T=0            !TEKOÐÂ APMAKSA
        A:VAL_T=''
        A:DATUMS=GGK:DATUMS
        A:BKK=GGK:BKK           !20.06.2007 DÇÏ IESKAITA
        A:NODALA=GGK:NODALA     !LIELAS JÇGAS NO
        A:OBJ_NR=GGK:OBJ_NR     !ÐITÂ NAV....
        A:U_NR=0                !14.11.2006
        A:PVN_PROC=GGK:PVN_PROC !15.12.2008
        ADD(A_TABLE)
        IF ERROR() THEN STOP('Rakstot A-table (ATMIÒA?)'&ERROR()).
!        summa=summa_tk
        val_nos=GGK:VAL
        localresponse=requestcompleted
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?ButtonFNesam
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:NESAMAKSATAS  !TIKAI NESAMAKSÂTÂS
           F:NESAMAKSATAS=''
           HIDE(?IMAGEFNES)
        ELSE
           F:NESAMAKSATAS='1'
           UNHIDE(?IMAGEFNES)
        .
        DO BRW1::InitializeBrowse
        DO BRW1::RefreshPage
        SELECT(?Browse:1)
        DISPLAY
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
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('ReferFixGG_NoKont','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('KKK',KKK)
  BIND('i_d_k',i_d_k)
  BIND('ATLAUTS',ATLAUTS)
  BIND('PAR_NR',PAR_NR)
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
    RESET(GG,SAVE_POSITION)
    NEXT(GG)
    GG:RECORD=GG_RECORD
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
  END
  IF WindowOpened
    INISaveWindow('ReferFixGG_NoKont','winlats.INI')
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
      IF BRW1::Sort1:Reset:PAR_NR <> PAR_NR
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:PAR_NR = PAR_NR
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
  
  IF SEND(GGK,'QUICKSCAN=on').
  SETCURSOR(Cursor:Wait)
  DO BRW1::Reset
  summa_tk=0
  summa_sk=0
  summa_ggkk=0
  LOOP
    NEXT(BRW1::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'GGK')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW1::FillQueue
    !summa_tk+=summa_t
    summa_sk+=summa_s
    summa_ggkk+=ggk:summaV
  END
  IF F:NeSAMAKSATAS
     summa_bezR=0     !to kas ir bez references , zaudçjam
     parads_s=summa_ggkk-summa_sk
  ELSE
     summa_bezR=summa_tot-summa_sk
     parads_s=summa_ggkk-summa_tot
  .
  parads_t=parads_s-summa_tk
  SETCURSOR()
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GGK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = GGK:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GGK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = GGK:DATUMS
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
  IF SEND(GGK,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  GG:KEKSIS = BRW1::GG:KEKSIS
  GG:RS = BRW1::GG:RS
  DOK_NR = BRW1::DOK_NR
  GG:DOKDAT = BRW1::GG:DOKDAT
  GG_APMDAT = BRW1::GG_APMDAT
  GG:SATURS = BRW1::GG:SATURS
  GGK:SUMMAV = BRW1::GGK:SUMMAV
  GGK:VAL = BRW1::GGK:VAL
  summa_s = BRW1::summa_s
  val_nos = BRW1::val_nos
  KKK = BRW1::KKK
  i_d_k = BRW1::i_d_k
  ATLAUTS = BRW1::ATLAUTS
  GGK:PAR_NR = BRW1::GGK:PAR_NR
  GGK:DATUMS = BRW1::GGK:DATUMS
  GGK:U_NR = BRW1::GGK:U_NR
  GG:U_NR = BRW1::GG:U_NR
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
  IF GGK:U_NR=1
     DOK_NR=GGK:REFERENCE
     GG_APMDAT=GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,1)
  ELSE
     DOK_NR=GG:DOK_SENR
     GG_APMDAT=GG:APMDAT
  .
  IF ~DOK_NR
     IF GG:U_NR=1
        KLUDA(0,'SALDO raksta kontçjumâ Nav Dok. Nr.(REFERENCES)')
     ELSE
        KLUDA(0,FORMAT(GG:DATUMS,@D06.)&' dokumentam U_NR='&GG:U_NR&' nav Dok. Numura')
        DO PROCEDURERETURN
     .
  .
  VAL_NOS=GGK:VAL
  SUMMA_S=PerfAtable_NoKont(2,DOK_NR,' ',RS,PAR_NR,'',0,0,'',0)


! VAL_NOS='Ls', JA DAÞÂDAS
  IF GGK:U_NR=1 AND SUMMA_S<GGK:SUMMA !ÐITAIS FORMATS TIEK SAUKTS n-KÂRTÎGI
     IF ~SAV_POSITION THEN SAV_POSITION=POSITION(GGK).
     IF POSITION(GGK)=SAV_POSITION
        SUMMA_S+=BILANCE
     .
  .
!  SUMMA_T=PerfAtable(3,DOK_NR,' ',RS,PAR_NR,'',0,0,'',0)
  
  
  BRW1::GG:KEKSIS = GG:KEKSIS
  BRW1::GG:RS = GG:RS
  BRW1::DOK_NR = DOK_NR
  BRW1::GG:DOKDAT = GG:DOKDAT
  BRW1::GG_APMDAT = GG_APMDAT
  BRW1::GG:SATURS = GG:SATURS
  BRW1::GGK:SUMMAV = GGK:SUMMAV
  BRW1::GGK:VAL = GGK:VAL
  BRW1::summa_s = summa_s
  BRW1::val_nos = val_nos
  BRW1::KKK = KKK
  BRW1::i_d_k = i_d_k
  BRW1::ATLAUTS = ATLAUTS
  BRW1::GGK:PAR_NR = GGK:PAR_NR
  BRW1::GGK:DATUMS = GGK:DATUMS
  BRW1::GGK:U_NR = GGK:U_NR
  BRW1::GG:U_NR = GG:U_NR
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
        LOOP BRW1::CurrentScroll = 100 TO 1 BY -1
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => GGK:DATUMS
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
      GGK:DATUMS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
    
    IF SEND(GGK,'QUICKSCAN=on').
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
        StandardWarning(Warn:RecordFetchError,'GGK')
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
    IF SEND(GGK,'QUICKSCAN=off').
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
      BRW1::HighlightedPosition = POSITION(GGK:PARDAT_KEY)
      RESET(GGK:PARDAT_KEY,BRW1::HighlightedPosition)
    ELSE
      GGK:PAR_NR = PAR_NR
      SET(GGK:PARDAT_KEY,GGK:PARDAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'GGK:PAR_NR = PAR_NR AND (ggk:bkk[1:5]=KKK and ggk:d_k=I_D_K and ~Cycle' & |
    'Apmaksa(F:NESAMAKSATAS) and ~(GGK:RS=''1''  AND  ATLAUTS[18]=''1''))'
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
    CLEAR(GGK:Record)
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
    GGK:PAR_NR = PAR_NR
    SET(GGK:PARDAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'GGK:PAR_NR = PAR_NR AND (ggk:bkk[1:5]=KKK and ggk:d_k=I_D_K and ~Cycle' & |
    'Apmaksa(F:NESAMAKSATAS) and ~(GGK:RS=''1''  AND  ATLAUTS[18]=''1''))'
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
    PAR_NR = BRW1::Sort1:Reset:PAR_NR
  END

