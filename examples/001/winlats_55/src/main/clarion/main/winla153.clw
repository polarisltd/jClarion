                     MEMBER('winlats.clw')        ! This is a MEMBER module
BrowseAutoVesture PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
M_TABLE              QUEUE,PRE()
M:DATUMS             LONG
M:SERVISS            STRING(15)
M:NOBRAUKUMS         DECIMAL(7)
M:TEKSTS             STRING(50)
M:TAKA               STRING(80)
M:LOC_NR             BYTE
M:PAV_NR             ULONG
                     END
OPC                  BYTE
DAT                 LONG
LAI                 LONG
SAV_PATH            STRING(80)
SAV_JOB_NR          BYTE
SAV_AAPKNAME        LIKE(AAPKNAME)
SAV_ATEXNAME        LIKE(ATEXNAME)
SAV_ADARBINAME      LIKE(ADARBINAME)
SAV_PAVADNAME       LIKE(PAVADNAME)
SAV_NOLIKNAME       LIKE(NOLIKNAME)
SOURCE_LOC_NR       BYTE
SOURCE_PATH         STRING(80)
AVOTS               STRING(15)

INIFILE                 FILE,DRIVER('ASCII'),NAME('WINLATS.INI'),PRE(INI),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
LINE                        STRING(80)
                         END
                       END

P_TABLE        QUEUE,PRE(P)
PATH              STRING(80)
               .

window               WINDOW('a/m pilna servisa vçsture'),AT(,,326,197),FONT('MS Sans Serif',9,,FONT:bold),GRAY
                       LIST,AT(2,3,319,174),USE(?List1),FORMAT('40L|~Datums~C@D6@60L|~Serviss~C@s15@45R|~Nobraukums~C@n9@200L|~Darbu saturs~C@s5' &|
   '0@'),FROM(M_TABLE)
                       BUTTON('Servisa &Pien. Akts'),AT(8,180,68,14),USE(?ButtonSPA)
                       BUTTON('&OK'),AT(287,179,35,14),USE(?OkButton),DEFAULT
                       BUTTON('Servisa Nod. &Akts'),AT(85,180,68,14),USE(?ButtonSNA)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
   !IR POZICIONÇTS AUTO
    S_DAT=PAV:DATUMS
    B_DAT=PAV:DATUMS
    CHECKOPEN(GLOBAL,1)
    CHECKOPEN(SYSTEM,1)
    DAT = TODAY()
    LAI = CLOCK()
  
    CHECKOPEN(INIFILE,1)
    SET(INIFILE)
    LOOP
       NEXT(INIFILE)
       IF ERROR() THEN BREAK.
       IF INI:LINE[1:12]='AUTOSERVISS='  !SERVISA VÇSTURE
          P:PATH=INI:LINE[13:80]
          ADD(P_TABLE)
       .
    .
    CLOSE(INIFILE)
    IF RECORDS(P_TABLE)=0
       KLUDA(87,'WinLats.ini , kur meklçt Servisa vçsturi')
    ELSE
       SAV_PATH=PATH()
       SAV_JOB_NR=JOB_NR
       SAV_AAPKNAME=AAPKNAME
       LOOP J#= 1 TO RECORDS(P_TABLE)
          GET(P_TABLE,J#)
          CLOSE(AUTOAPK)
          AAPKNAME=P:PATH
          OPEN(AUTOAPK)
          IF ERROR()
             KLUDA(120,'datu folderis '&p:path)
             CYCLE
          .
          LOOP I#=LEN(P:PATH) TO 2 BY -1
             IF UPPER(P:PATH[I#-1:I#])='PK'
                SOURCE_LOC_NR=P:PATH[I#+1:I#+2]
             .
             IF UPPER(P:PATH[I#])='\'
                SOURCE_PATH=P:PATH[1:I#-1]
                BREAK
             .
          .
          SETPATH(SOURCE_PATH)
          JOB_NR=SOURCE_LOC_NR+15
          CLOSE(SYSTEM)
          CHECKOPEN(SYSTEM)
          IF ERROR()
             AVOTS=SOURCE_LOC_NR
          ELSE
             AVOTS=SYS:ADRESE
          .
  
  !        STOP(JOB_NR&' '&CLIP(SOURCE_PATH)&' '&P:PATH)
  
          CLEAR(APK:RECORD)
          APK:AUT_NR=AUT:U_NR
          SET(APK:AUT_KEY,APK:AUT_KEY)
          LOOP
             PREVIOUS(AUTOAPK)
             IF ERROR() OR ~(APK:AUT_NR=AUT:U_NR) THEN BREAK.
             M:DATUMS=APK:DATUMS
             M:SERVISS=AVOTS
             M:NOBRAUKUMS=APK:NOBRAUKUMS
             M:TEKSTS=APK:TEKSTS
             M:TAKA=SOURCE_PATH
             M:LOC_NR=SOURCE_LOC_NR
             M:PAV_NR=APK:PAV_NR
             ADD(M_TABLE)
  
     !       CLEAR(NOL:RECORD)
     !       NOL:U_NR=PAV:U_NR
     !       SET(NOL:NR_KEY,NOL:NR_KEY)
     !       LOOP
     !          NEXT(NOLIK)
     !          IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
     !          P:KODS=NOL:NOMENKLAT
     !          GET(P_TABLE,P:KODS)
     !          IF ERROR()
     !             P:SKAITS=NOL:DAUDZUMS
     !             ADD(P_TABLE)
     !             SORT(P_TABLE,P:KODS)
     !          ELSE
     !             P:SKAITS+=NOL:DAUDZUMS
     !             PUT(P_TABLE)
     !          .
     !       .
     !    .
  
          .
       .
       SORT(M_TABLE,-M:DATUMS)
       SETPATH(SAV_PATH)
       SAV_JOB_NR=JOB_NR
       CLOSE(AUTOAPK)
       AAPKNAME=SAV_AAPKNAME
       CHECKOPEN(AUTOAPK,1)
       CLOSE(SYSTEM)
       JOB_NR=SAV_JOB_NR
       CHECKOPEN(SYSTEM,1)
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
    OF ?ButtonSPA
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPC=1
        DO PRINTSAKC
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
        BREAK
    OF ?ButtonSNA
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPC=2
        DO PRINTSAKC
                      
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('BrowseAutoVesture','winlats.INI')
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
    FREE(P_TABLE)
    FREE(M_TABLE)
  END
  IF WindowOpened
    INISaveWindow('BrowseAutoVesture','winlats.INI')
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
PRINTSAKC  ROUTINE

 CLOSE(PAVAD)
 CLOSE(NOLIK)
 CLOSE(AUTOAPK)
 CLOSE(AUTOTEX)
 CLOSE(AUTODARBI)
 SAV_PAVADNAME =PAVADNAME
 SAV_NOLIKNAME =NOLIKNAME
 SAV_AAPKNAME  =AAPKNAME
 SAV_ATEXNAME  =ATEXNAME
 SAV_ADARBINAME=ADARBINAME
 GET(M_TABLE,CHOICE(?LIST1))
 PAVADNAME =CLIP(M:TAKA)&'\PAVAD'&FORMAT(M:LOC_NR,@N02)
 NOLIKNAME =CLIP(M:TAKA)&'\NOLIK'&FORMAT(M:LOC_NR,@N02)
 AAPKNAME  =CLIP(M:TAKA)&'\AAPK'&FORMAT(M:LOC_NR,@N02)
 ATEXNAME  =CLIP(M:TAKA)&'\ATEX'&FORMAT(M:LOC_NR,@N02)
 ADARBINAME=CLIP(M:TAKA)&'\ADARBI'&FORMAT(M:LOC_NR,@N02)
 !STOP(PAVADNAME)
 CHECKOPEN(PAVAD)
 CHECKOPEN(NOLIK)
 CHECKOPEN(AUTOAPK)
 CHECKOPEN(AUTOTEX)
 CHECKOPEN(AUTODARBI)
 IF ~GETPAVADZ(M:PAV_NR)
    KLUDA(88,'P/Z U_NR='&M:PAV_NR)
 ELSE
    IF OPC=1
       SPZ_ServApgLapa('010') !SPA
    ELSE
       SPZ_ServApgLapa('110') !SNA
    .
 .
 CLOSE(PAVAD)
 CLOSE(NOLIK)
 CLOSE(AUTOAPK)
 CLOSE(AUTOTEX)
 CLOSE(AUTODARBI)
 PAVADNAME =SAV_PAVADNAME
 NOLIKNAME =SAV_NOLIKNAME
 AAPKNAME  =SAV_AAPKNAME
 ATEXNAME  =SAV_ATEXNAME
 ADARBINAME=SAV_ADARBINAME
 CHECKOPEN(PAVAD)
 CHECKOPEN(NOLIK)
 CHECKOPEN(AUTOAPK)
 CHECKOPEN(AUTOTEX)
 CHECKOPEN(AUTODARBI)
BrowseAutoApk PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG

BRW1::View:Browse    VIEW(AUTOAPK)
                       PROJECT(APK:DATUMS)
                       PROJECT(APK:Nobraukums)
                       PROJECT(APK:TEKSTS)
                       PROJECT(APK:AUT_NR)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::APK:DATUMS       LIKE(APK:DATUMS)           ! Queue Display field
BRW1::APK:Nobraukums   LIKE(APK:Nobraukums)       ! Queue Display field
BRW1::APK:TEKSTS       LIKE(APK:TEKSTS)           ! Queue Display field
BRW1::APK:AUT_NR       LIKE(APK:AUT_NR)           ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(APK:DATUMS),DIM(100)
BRW1::Sort1:LowValue LIKE(APK:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(APK:DATUMS)            ! Queue position of scroll thumb
BRW1::Sort1:Reset:AUT:U_NR LIKE(AUT:U_NR)
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
QuickWindow          WINDOW('Servisa vçsture'),AT(,,357,250),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('BrowseAutoSe'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,341,206),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('46R(2)|M~Datums~C(0)@D6@48R(2)|M~Nobraukums~C(0)@n-10.0@200L(2)|M~Darbu saturs~C' &|
   '(0)@s50@'),FROM(Queue:Browse:1)
                       BUTTON('&Ievadît'),AT(179,230,41,14),USE(?Insert:2),HIDE
                       BUTTON('&Mainît'),AT(221,230,38,14),USE(?Change:2),DEFAULT
                       BUTTON('&Dzçst'),AT(261,230,39,14),USE(?Delete:2)
                       SHEET,AT(4,4,350,244),USE(?CurrentTab)
                         TAB('&Veiktâs apkopes ðogad pie mums'),USE(?Tab:2)
                           BUTTON('&Servisa vçsture'),AT(8,230,60,14),USE(?ButtonVVA)
                           BUTTON('Serv &Pien.Akts'),AT(73,230,51,14),USE(?ButtonSPA)
                           BUTTON('Serv Nod.&Akts'),AT(125,230,52,14),USE(?ButtonSNA)
                         END
                       END
                       BUTTON('&Beigt'),AT(303,230,45,14),USE(?Close)
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
  IF PAV::U_NR                 !TIEK SAUKTS NO P/Z
     HIDE(?CHANGE:2)
     HIDE(?DELETE:2)
     HIDE(?ButtonSPA)
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      QUICKWINDOW{PROP:TEXT}='Servisa vçsture.Nol Nr='&loc_nr&' '&path()
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
        if ~PAV::U_NR
           KLUDA(0,'Apkope nav piesaistîta Pavadzîmei...')
        .
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
    OF ?ButtonVVA
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        BrowseAutoVesture 
        LocalRequest = OriginalRequest
        DO RefreshWindow
      END
    OF ?ButtonSPA
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF ~GETPAVADZ(APK:PAV_NR)
           KLUDA(88,'P/Z U_NR='&APK:PAV_NR)
        ELSE
           SPZ_ServApgLapa('000')
        .
      END
    OF ?ButtonSNA
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF ~GETPAVADZ(APK:PAV_NR)
           KLUDA(88,'P/Z U_NR='&APK:PAV_NR)
        ELSE
           SPZ_ServApgLapa('101')
        .
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
  IF AUTO::Used = 0
    CheckOpen(AUTO,1)
  END
  AUTO::Used += 1
  BIND(AUT:RECORD)
  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  BIND(APK:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseAutoApk','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
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
    AUTO::Used -= 1
    IF AUTO::Used = 0 THEN CLOSE(AUTO).
    AUTOAPK::Used -= 1
    IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
  END
  IF WindowOpened
    INISaveWindow('BrowseAutoApk','winlats.INI')
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
      IF BRW1::Sort1:Reset:AUT:U_NR <> AUT:U_NR
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:AUT:U_NR = AUT:U_NR
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
      StandardWarning(Warn:RecordFetchError,'AUTOAPK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = APK:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'AUTOAPK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = APK:DATUMS
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  APK:DATUMS = BRW1::APK:DATUMS
  APK:Nobraukums = BRW1::APK:Nobraukums
  APK:TEKSTS = BRW1::APK:TEKSTS
  APK:AUT_NR = BRW1::APK:AUT_NR
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
  BRW1::APK:DATUMS = APK:DATUMS
  BRW1::APK:Nobraukums = APK:Nobraukums
  BRW1::APK:TEKSTS = APK:TEKSTS
  BRW1::APK:AUT_NR = APK:AUT_NR
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
        LOOP BRW1::CurrentScroll = 100 TO 1 BY -1
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => APK:DATUMS
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
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
    OF DeleteKey
      POST(Event:Accepted,?Delete:2)
    OF CtrlEnter
      POST(Event:Accepted,?Change:2)
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
      APK:DATUMS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'AUTOAPK')
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
      BRW1::HighlightedPosition = POSITION(APK:AUT_KEY)
      RESET(APK:AUT_KEY,BRW1::HighlightedPosition)
    ELSE
      APK:AUT_NR = AUT:U_NR
      SET(APK:AUT_KEY,APK:AUT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'APK:AUT_NR = AUT:U_NR'
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
    ?Change:2{Prop:Disable} = 0
    ?Delete:2{Prop:Disable} = 0
  ELSE
    CLEAR(APK:Record)
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
    APK:AUT_NR = AUT:U_NR
    SET(APK:AUT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'APK:AUT_NR = AUT:U_NR'
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
    AUT:U_NR = BRW1::Sort1:Reset:AUT:U_NR
  END
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
  GET(AUTOAPK,0)
  CLEAR(APK:Record,0)
  CASE BRW1::SortOrder
  OF 1
    APK:AUT_NR = BRW1::Sort1:Reset:AUT:U_NR
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
!| (UpdateAUTOAPK) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  IF (PAV:DATUMS < SYS:GIL_SHOW OR PAV:BAITS1=1) and (LOCALREQUEST=3 OR LOCALREQUEST=2) ! SLÇGTS APGABALS VAI RAKSTS
     LOCALREQUEST=0
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateAUTOAPK
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
        GET(AUTOAPK,0)
        CLEAR(APK:Record,0)
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


UpdateAUTOAPK PROCEDURE


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
VUT                  STRING(35)
Vedejs               STRING(45)
ved_auto             STRING(40)
D                    STRING(1)
SAV_RECORD     LIKE(APK:RECORD)
SAV_POSITION   STRING(260)

BRW2::View:Browse    VIEW(AUTODARBI)
                       PROJECT(APD:ID)
                       PROJECT(APD:NOMENKLAT)
                       PROJECT(APD:LAIKS)
                       PROJECT(APD:GARANTIJA)
                       PROJECT(APD:PAV_NR)
                     END

Queue:Browse:2       QUEUE,PRE()                  ! Browsing Queue
BRW2::APD:ID           LIKE(APD:ID)               ! Queue Display field
BRW2::VUT              LIKE(VUT)                  ! Queue Display field
BRW2::APD:NOMENKLAT    LIKE(APD:NOMENKLAT)        ! Queue Display field
BRW2::D                LIKE(D)                    ! Queue Display field
BRW2::APD:LAIKS        LIKE(APD:LAIKS)            ! Queue Display field
BRW2::APD:GARANTIJA    LIKE(APD:GARANTIJA)        ! Queue Display field
BRW2::APD:PAV_NR       LIKE(APD:PAV_NR)           ! Queue Display field
BRW2::Mark             BYTE                       ! Queue POSITION information
BRW2::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW2::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW2::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW2::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW2::Sort1:KeyDistribution LIKE(APD:PAV_NR),DIM(100)
BRW2::Sort1:LowValue LIKE(APD:PAV_NR)             ! Queue position of scroll thumb
BRW2::Sort1:HighValue LIKE(APD:PAV_NR)            ! Queue position of scroll thumb
BRW2::Sort1:Reset:APK:PAV_NR LIKE(APK:PAV_NR)
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

BRW4::View:Browse    VIEW(AUTOTEX)
                       PROJECT(APX:PAZIME)
                       PROJECT(APX:TEKSTS)
                       PROJECT(APX:PAV_NR)
                     END

Queue:Browse:4       QUEUE,PRE()                  ! Browsing Queue
BRW4::APX:PAZIME       LIKE(APX:PAZIME)           ! Queue Display field
BRW4::APX:TEKSTS       LIKE(APX:TEKSTS)           ! Queue Display field
BRW4::APX:PAV_NR       LIKE(APX:PAV_NR)           ! Queue Display field
BRW4::Mark             BYTE                       ! Queue POSITION information
BRW4::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW4::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW4::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW4::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW4::Sort1:KeyDistribution LIKE(APX:PAV_NR),DIM(100)
BRW4::Sort1:LowValue LIKE(APX:PAV_NR)             ! Queue position of scroll thumb
BRW4::Sort1:HighValue LIKE(APX:PAV_NR)            ! Queue position of scroll thumb
BRW4::Sort1:Reset:APK:PAV_NR LIKE(APK:PAV_NR)
BRW4::CurrentEvent   LONG                         !
BRW4::CurrentChoice  LONG                         !
BRW4::RecordCount    LONG                         !
BRW4::SortOrder      BYTE                         !
BRW4::LocateMode     BYTE                         !
BRW4::RefreshMode    BYTE                         !
BRW4::LastSortOrder  BYTE                         !
BRW4::FillDirection  BYTE                         !
BRW4::AddQueue       BYTE                         !
BRW4::Changed        BYTE                         !
BRW4::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW4::ItemsToFill    LONG                         ! Controls records retrieved
BRW4::MaxItemsInList LONG                         ! Retrieved after window opened
BRW4::HighlightedPosition STRING(512)             ! POSITION of located record
BRW4::NewSelectPosted BYTE                        ! Queue position of located record
BRW4::PopupText      STRING(128)                  !
Update::Reloop  BYTE
Update::Error   BYTE
History::APK:Record LIKE(APK:Record),STATIC
SAV::APK:Record      LIKE(APK:Record)
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the AUTOAPK File'),AT(,,407,285),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateAUTOAPK'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(3,7,397,255),USE(?CurrentTab)
                         TAB('&Pamatdati'),USE(?Tab:1)
                           STRING(@n13),AT(341,28),USE(APK:PAV_NR)
                           BUTTON('A&uto'),AT(64,62,45,14),USE(?ButtonAuto)
                           STRING(@s45),AT(127,61,189,10),USE(Vedejs)
                           STRING(@s40),AT(127,71),USE(ved_auto)
                           STRING('P/Z datums:'),AT(66,90),USE(?String80)
                           STRING(@D06.),AT(128,90),USE(APK:DATUMS)
                           PROMPT('&Pieòemðanas datums:'),AT(56,104),USE(?APK:PIEN_DA:Prompt)
                           ENTRY(@D06.),AT(128,103,47,12),USE(APK:PIEN_DAT),RIGHT(1)
                           PROMPT('&Laiks:'),AT(183,104),USE(?APK:PLKST:Prompt)
                           ENTRY(@T1),AT(206,102),USE(APK:PLKST)
                           PROMPT('&Nobraukums:'),AT(64,120),USE(?APK:Nobraukums:Prompt)
                           ENTRY(@n-10.0),AT(128,119,47,12),USE(APK:Nobraukums)
                           PROMPT('&Teksts:'),AT(64,135),USE(?APK:TEKSTS:Prompt)
                           ENTRY(@s50),AT(128,134,204,12),USE(APK:TEKSTS)
                           PROMPT('Kont&roles datums:'),AT(64,150),USE(?APK:CTRL_DATUMS:Prompt)
                           ENTRY(@D6),AT(128,148,47,12),USE(APK:CTRL_DATUMS)
                         END
                         TAB('&Meistari un darbi'),USE(?Tab:2)
                           LIST,AT(7,21,359,213),USE(?Browse:2),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('28R(2)|M~ID~C(0)@n6@144L(1)|M~Vârds Uzvârds~C(0)@s35@80L(2)|M~Nomenklatûra~L(1)@' &|
   's21@8C|M~D~@s1@25R(1)|M~Laiks~C(0)@n6.2@80R(2)|M~Garantija~C(0)@D6@'),FROM(Queue:Browse:2)
                           BUTTON('&Ievadît'),AT(223,240,45,14),USE(?Insert:3)
                           BUTTON('&Mainît'),AT(271,240,45,14),USE(?Change:3)
                           BUTTON('&Dzçst'),AT(319,240,45,14),USE(?Delete:3)
                         END
                         TAB('&Klienta sûdzîbas/Paliekoðie defekti'),USE(?Tab:3)
                           LIST,AT(7,21,358,214),USE(?Browse:4),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('13C|M@s1@273L(2)|M~Teksts~@s80@'),FROM(Queue:Browse:4)
                           BUTTON('&Ievadît'),AT(220,241,45,14),USE(?Insert:5)
                           BUTTON('&Mainît'),AT(268,241,45,14),USE(?Change:5)
                           BUTTON('&Dzçst'),AT(316,241,45,14),USE(?Delete:5)
                         END
                         TAB('D&iagnostika1'),USE(?Tab:4)
                           PROMPT('2.Savirze: pr.'),AT(37,23),USE(?APK:SAVIRZE_P:Prompt)
                           ENTRY(@n-6.2),AT(84,23,31,10),USE(APK:SAVIRZE_P)
                           PROMPT('aizm.'),AT(64,34),USE(?APK:SAVIRZE_A:Prompt)
                           ENTRY(@n-6.2),AT(84,34,31,10),USE(APK:SAVIRZE_A)
                           PROMPT('3.Amortizatori: pr.'),AT(122,23),USE(?APK:AMORT_P:Prompt)
                           ENTRY(@n-4.0),AT(183,23,24,10),USE(APK:AMORT_P[1])
                           ENTRY(@n-4.0),AT(211,23,24,10),USE(APK:AMORT_P[2])
                           PROMPT('aizm.'),AT(163,34),USE(?APK:AMORT_P:Prompt:2)
                           ENTRY(@n-4.0),AT(183,34,24,10),USE(APK:AMORT_A[1])
                           ENTRY(@n-4.0),AT(211,34,24,10),USE(APK:AMORT_A[2])
                           PROMPT('4.Bremzes: pr.'),AT(241,23),USE(?APK:BREMZES_P:Prompt)
                           ENTRY(@n-5.1),AT(293,23,24,10),USE(APK:BREMZES_P[1])
                           ENTRY(@n-5.1),AT(321,23,24,10),USE(APK:BREMZES_P[2])
                           PROMPT('aizm.'),AT(271,34),USE(?APK:BREMZES_A:Prompt)
                           ENTRY(@n-5.1),AT(293,34,24,10),USE(APK:BREMZES_A[1])
                           ENTRY(@n-5.1),AT(321,34,24,10),USE(APK:BREMZES_A[2])
                           STRING('5. Ritoðâs D.pârbaude:'),AT(9,50),USE(?String3),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(124,50,12,10),USE(APK:KAROGI[1])
                           STRING('5.1. Pr.tilts'),AT(9,61),USE(?String4),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(124,61,12,10),USE(APK:KAROGI[2])
                           STRING('5.1.1. Pr.Râmja bukse'),AT(9,72),USE(?String5)
                           ENTRY(@s1),AT(124,72,12,10),USE(APK:KAROGI[3])
                           STRING('5.1.2. Sviras,lodbalsti,stab.-atsaite'),AT(9,83),USE(?String6)
                           ENTRY(@s1),AT(124,83,12,10),USE(APK:KAROGI[4])
                           STRING('5.1.3. Rumbas gultòi'),AT(9,94),USE(?String7)
                           ENTRY(@s1),AT(124,94,12,10),USE(APK:KAROGI[5])
                           STRING('5.1.4. Pusas put.sargi'),AT(9,105),USE(?String8)
                           ENTRY(@s1),AT(124,105,12,10),USE(APK:KAROGI[6])
                           STRING('5.1.5. Pr.amort.atbalstbukses'),AT(9,116),USE(?String9)
                           ENTRY(@s1),AT(124,116,12,10),USE(APK:KAROGI[7])
                           STRING('5.1.6. Pr.amort.put.sargi'),AT(9,127),USE(?String10)
                           ENTRY(@s1),AT(124,127,12,10),USE(APK:KAROGI[8])
                           STRING('5.2. Stûres iekârta'),AT(9,138),USE(?String11),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(124,138,12,10),USE(APK:KAROGI[9])
                           STRING('5.2.1. Stûres ðarnîri'),AT(9,149),USE(?String12)
                           ENTRY(@s1),AT(124,149,12,10),USE(APK:KAROGI[10])
                           STRING('5.2.2. Stûres meh.'),AT(9,160),USE(?String13)
                           ENTRY(@s1),AT(124,160,12,10),USE(APK:KAROGI[11])
                           STRING('5.2.3. St.Meh.Put.sargi'),AT(9,171),USE(?String14)
                           ENTRY(@s1),AT(124,171,12,10),USE(APK:KAROGI[12])
                           STRING('5.2.4. St.statnis,krustiòð'),AT(9,182),USE(?String15)
                           ENTRY(@s1),AT(124,182,12,10),USE(APK:KAROGI[13])
                           STRING('5.3. Pr.Bremþu iekârta'),AT(9,193),USE(?String16),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(124,193,12,10),USE(APK:KAROGI[14])
                           STRING('5.3.1. Pr.br.Ðïauciòas'),AT(9,204),USE(?String17)
                           ENTRY(@s1),AT(124,204,12,10),USE(APK:KAROGI[15])
                           STRING('5.3.2. Pr.br.uzlikas'),AT(9,215),USE(?String18)
                           ENTRY(@s1),AT(124,215,12,10),USE(APK:KAROGI[16])
                           STRING('5.3.3. Pr.br.diski'),AT(9,226),USE(?String19)
                           ENTRY(@s1),AT(124,226,12,10),USE(APK:KAROGI[17])
                           STRING('5.3.4. Pr.br.devçji'),AT(9,239),USE(?String20)
                           ENTRY(@s1),AT(124,239,12,10),USE(APK:KAROGI[18])
                           STRING('5.3.5. Pr.br.suporti'),AT(141,50),USE(?String21)
                           ENTRY(@s1),AT(264,50,12,10),USE(APK:KAROGI[19])
                           STRING('5.4. Transmisija'),AT(141,61),USE(?String22),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(264,61,12,10),USE(APK:KAROGI[20])
                           STRING('5.4.1. Dzinçja,kârbas spilveni'),AT(141,72),USE(?String23)
                           ENTRY(@s1),AT(264,72,12,10),USE(APK:KAROGI[21])
                           STRING('5.4.2. Kardâna krust.,piekares gultnis'),AT(141,83),USE(?String24)
                           ENTRY(@s1),AT(264,83,12,10),USE(APK:KAROGI[22])
                           STRING('5.4.3. Reduktors,spilvens,bukses'),AT(141,94),USE(?String25)
                           ENTRY(@s1),AT(264,94,12,10),USE(APK:KAROGI[23])
                           STRING('5.5. Aizm.tilts'),AT(141,105),USE(?String26),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(264,105,12,10),USE(APK:KAROGI[24])
                           STRING('5.5.1. Aizm.tilta,râmja bukses'),AT(141,116),USE(?String27)
                           ENTRY(@s1),AT(264,116,12,10),USE(APK:KAROGI[25])
                           STRING('5.5.2. Sviras,lodbalsti,stab.-atsaite'),AT(141,127),USE(?String28)
                           ENTRY(@s1),AT(264,127,12,10),USE(APK:KAROGI[26])
                           STRING('5.5.3. Rumbas gultòi'),AT(141,138),USE(?String29)
                           ENTRY(@s1),AT(264,138,12,10),USE(APK:KAROGI[27])
                           STRING('5.5.4. Pusas put.sargi'),AT(141,149),USE(?String30)
                           ENTRY(@s1),AT(264,149,12,10),USE(APK:KAROGI[28])
                           STRING('5.5.5. Aizm.amort.atbalstbukses'),AT(141,160),USE(?String31)
                           ENTRY(@s1),AT(264,160,12,10),USE(APK:KAROGI[29])
                           STRING('5.5.6. Aizm.amort.put.sargi'),AT(141,171),USE(?String32)
                           ENTRY(@s1),AT(264,171,12,10),USE(APK:KAROGI[30])
                           STRING('5.6. Aizm.br.iekârta'),AT(141,182),USE(?String33),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(264,182,12,10),USE(APK:KAROGI[31])
                           STRING('5.6.1. Aizm.br.Ðïauciòas'),AT(141,193),USE(?String34)
                           ENTRY(@s1),AT(264,193,12,10),USE(APK:KAROGI[32])
                           STRING('5.6.2. Aizm.br.uzlikas'),AT(141,204),USE(?String35)
                           ENTRY(@s1),AT(264,204,12,10),USE(APK:KAROGI[33])
                           STRING('5.6.3. Aizm.br.diski,trumuïi'),AT(141,215),USE(?String36)
                           ENTRY(@s1),AT(264,215,12,10),USE(APK:KAROGI[34])
                           STRING('5.6.4. Aizm.br.devçji'),AT(141,226),USE(?String37)
                           ENTRY(@s1),AT(264,226,12,10),USE(APK:KAROGI[35])
                           STRING('5.6.5. Aizm.br.suporti'),AT(141,239),USE(?String38)
                           ENTRY(@s1),AT(264,239,12,10),USE(APK:KAROGI[36])
                           STRING('5.6.6. Stâvbremze'),AT(279,50),USE(?String39)
                           ENTRY(@s1),AT(381,50,12,10),USE(APK:KAROGI[37])
                           STRING('6. Izplûdes sist.'),AT(279,62),USE(?String40),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(381,62,12,10),USE(APK:KAROGI[38])
                           STRING('6.1. Izplûdes sist.korozija'),AT(279,73),USE(?String41)
                           ENTRY(@s1),AT(381,73,12,10),USE(APK:KAROGI[39])
                           STRING('6.2. Stiprinâjumi,bojâjumi'),AT(279,85),USE(?String42)
                           ENTRY(@s1),AT(381,84,12,10),USE(APK:KAROGI[40])
                           STRING('7. Mehâniski bojâjumi,korozija'),AT(279,95),USE(?String43),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(381,95,12,10),USE(APK:KAROGI[41])
                           STRING('8. Eïïu noplûde'),AT(279,106),USE(?String44),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(381,106,12,10),USE(APK:KAROGI[42])
                           STRING('8.1. Dzinçjs'),AT(279,117),USE(?String45)
                           ENTRY(@s1),AT(381,117,12,10),USE(APK:KAROGI[43])
                           STRING('8.2. Kârba,sad.kârba'),AT(279,128),USE(?String46)
                           ENTRY(@s1),AT(381,128,12,10),USE(APK:KAROGI[44])
                           STRING('8.3. Reduktors'),AT(279,140),USE(?String47)
                           ENTRY(@s1),AT(381,139,12,10),USE(APK:KAROGI[45])
                           STRING('9. Siksnas'),AT(279,150),USE(?String48),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(381,150,12,10),USE(APK:KAROGI[46])
                           STRING('9.1. Ìeneratora siksna'),AT(279,161),USE(?String49)
                           ENTRY(@s1),AT(381,161,12,10),USE(APK:KAROGI[47])
                           STRING('9.2. Agregâtsiksnas'),AT(279,173),USE(?String50)
                           ENTRY(@s1),AT(381,172,12,10),USE(APK:KAROGI[48])
                           STRING('10. Riepas'),AT(279,183),USE(?String51),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(381,183,12,10),USE(APK:KAROGI[49])
                           STRING('10.1. Protektors'),AT(279,194),USE(?String52)
                           ENTRY(@s1),AT(381,194,12,10),USE(APK:KAROGI[50])
                           STRING('10.2. Bojâjumi'),AT(279,205),USE(?String53)
                           ENTRY(@s1),AT(381,205,12,10),USE(APK:KAROGI[51])
                           STRING('11. Gaismas ierîces'),AT(279,216),USE(?String54),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(381,216,12,10),USE(APK:KAROGI[52])
                           STRING('11.1. Gabarîti'),AT(279,228),USE(?String55)
                           ENTRY(@s1),AT(381,227,12,10),USE(APK:KAROGI[53])
                           STRING('11.2. Tuvie'),AT(279,239),USE(?String56)
                           ENTRY(@s1),AT(381,239,12,10),USE(APK:KAROGI[54])
                         END
                         TAB('Di&agnostika2'),USE(?Tab:5)
                           STRING('11.3. Tâlie'),AT(11,28),USE(?String57)
                           ENTRY(@s1),AT(111,28,12,10),USE(APK:KAROGI[55])
                           STRING('11.4. Pr.miglas'),AT(11,40),USE(?String58)
                           ENTRY(@s1),AT(111,40,12,10),USE(APK:KAROGI[56])
                           STRING('11.5. Virzienrâdîtâji'),AT(11,52),USE(?String59)
                           ENTRY(@s1),AT(111,52,12,10),USE(APK:KAROGI[57])
                           STRING('11.6. Br.signâli'),AT(11,65),USE(?String60)
                           ENTRY(@s1),AT(111,65,12,10),USE(APK:KAROGI[58])
                           STRING('11.7. Atpakaïgaita'),AT(11,77),USE(?String61)
                           ENTRY(@s1),AT(111,77,12,10),USE(APK:KAROGI[59])
                           STRING('11.8. Aizm.miglas'),AT(11,89),USE(?String62)
                           ENTRY(@s1),AT(111,89,12,10),USE(APK:KAROGI[60])
                           STRING('11.9. Nummurapg.'),AT(11,101),USE(?String63)
                           ENTRY(@s1),AT(111,101,12,10),USE(APK:KAROGI[61])
                           STRING('12. Aprîkojums'),AT(11,114),USE(?String64),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(111,114,12,10),USE(APK:KAROGI[62])
                           STRING('12.1. Vçjstiklu tîrîtâji'),AT(11,127),USE(?String65)
                           ENTRY(@s1),AT(111,127,12,10),USE(APK:KAROGI[63])
                           STRING('12.2. Skaòas signâli'),AT(11,138),USE(?String66)
                           ENTRY(@s1),AT(111,138,12,10),USE(APK:KAROGI[64])
                           STRING('12.3. Atpakaïgaitas spogulis'),AT(10,150),USE(?String67)
                           ENTRY(@s1),AT(111,150,12,10),USE(APK:KAROGI[65])
                           STRING('13. Atgâzes,dûmainîba'),AT(131,28),USE(?String68),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(229,28,12,10),USE(APK:KAROGI[66])
                           STRING('14. Akumolators'),AT(131,40),USE(?String69),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(229,40,12,10),USE(APK:KAROGI[67])
                           STRING('15. Dzesçðanas ðíidrums'),AT(131,52),USE(?String70),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(229,52,12,10),USE(APK:KAROGI[68])
                           STRING('16. Logu ðíidrums'),AT(131,65),USE(?String71),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(229,65,12,10),USE(APK:KAROGI[69])
                           STRING('17. Bremþu ðí.'),AT(131,77),USE(?String72),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(229,77,12,10),USE(APK:KAROGI[70])
                           STRING('18. Lukturu lîmenis'),AT(131,89),USE(?String73),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(229,89,12,10),USE(APK:KAROGI[71])
                           STRING('19. Vizuâlais apskats'),AT(131,101),USE(?String74),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(229,101,12,10),USE(APK:KAROGI[72])
                           STRING('20. Akumolatora stirpinâjums'),AT(131,114),USE(?String75),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s1),AT(229,114,12,10),USE(APK:KAROGI[73])
                           STRING('21. Piezîmes'),AT(131,127),USE(?String76),FONT(,,,FONT:bold+FONT:italic)
                           ENTRY(@s50),AT(177,126,221,12),USE(APK:Diag_TEX)
                         END
                       END
                       BUTTON('&OK'),AT(300,265,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(351,265,45,14),USE(?Cancel)
                       STRING(@s8),AT(6,268),USE(APK:ACC_KODS),FONT(,,COLOR:Gray,)
                       STRING(@D06.),AT(45,268),USE(APK:ACC_DATUMS),FONT(,,COLOR:Gray,)
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
  vedejs=Getauto(APK:AUT_nr,3)
  ved_auto=Getauto(APK:AUT_nr,5)
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
    CASE LOCALREQUEST
    OF 1
       IF RECORDS(Queue:Browse:2) OR RECORDS(Queue:Browse:4)
          DISABLE(?CANCEL)
          ALIAS(EscKey,0) ! Novâcam EscKey
       ELSIF RECORDS(Queue:Browse:2)=0 AND RECORDS(Queue:Browse:4)=0
          ENABLE(?CANCEL)
          ALIAS
       .
    .
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
      SELECT(?APK:PAV_NR)
      IF LOCALREQUEST=3
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-2)
         enable(?Tab:1)  
         SELECT(?cancel)
      ELSIF LOCALREQUEST=0
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-1)
         enable(?CurrentTab)
         enable(?Tab:1)
         enable(?Tab:2)
         enable(?tab:3)
         enable(?Tab:4)
         enable(?tab:5)
         hide(?Change:3)
         hide(?Delete:3)
         hide(?Change:5)
         hide(?Delete:5)
         SELECT(?cancel)
      .
      IF SEC:SPEC_ACC[11]='2' AND ~(ACC_KODS_N=0) !AIZLIEGTA PIEEJA MEISTARIEM UN DARBIEM
         disable(?Tab:2)
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
        History::APK:Record = APK:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(AUTOAPK)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?APK:PAV_NR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::APK:Record <> APK:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:AUTOAPK(1)
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
              SELECT(?APK:PAV_NR)
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
            DO BRW2::AssignButtons
          OF 3
            DO BRW4::AssignButtons
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?ButtonAuto
      CASE EVENT()
      OF EVENT:Accepted
        AUT_NR=APK:AUT_NR      !LAI POZICIONÇ AUTO
        SAV_RECORD=APK:RECORD
        SAV_POSITION=POSITION(AUTOAPK)
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseAuto 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        RESET(AUTOAPK,SAV_POSITION)
        NEXT(AUTOAPK)
        APK:RECORD=SAV_RECORD
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           APK:AUT_NR=AUT:U_NR
           PAV:VED_NR=AUT:U_NR
           vedejs=Getauto(APK:AUT_nr,3)
           ved_auto=Getauto(APK:AUT_nr,5)
        ELSIF globalresponse=7 !NOÒEMT
           vedejs=''
           ved_auto=''
           APK:AUT_NR=0
           PAV:VED_NR=0
        .
        AUT_NR=0
        DISPLAY
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
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW2::ButtonDelete
      END
    OF ?Browse:4
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW4::NewSelection
      OF EVENT:ScrollUp
        DO BRW4::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW4::ProcessScroll
      OF EVENT:PageUp
        DO BRW4::ProcessScroll
      OF EVENT:PageDown
        DO BRW4::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW4::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW4::ProcessScroll
      OF EVENT:AlertKey
        DO BRW4::AlertKey
      OF EVENT:ScrollDrag
        DO BRW4::ScrollDrag
      END
    OF ?Insert:5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW4::ButtonInsert
      END
    OF ?Change:5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW4::ButtonChange
      END
    OF ?Delete:5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW4::ButtonDelete
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
  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  BIND(APK:RECORD)
  IF AUTODARBI::Used = 0
    CheckOpen(AUTODARBI,1)
  END
  AUTODARBI::Used += 1
  BIND(APD:RECORD)
  IF AUTOTEX::Used = 0
    CheckOpen(AUTOTEX,1)
  END
  AUTOTEX::Used += 1
  BIND(APX:RECORD)
  FilesOpened = True
  RISnap:AUTOAPK
  SAV::APK:Record = APK:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    APK:PAV_NR=PAV:U_NR
    APK:PAR_NR=PAV:PAR_NR
    APK:AUT_NR=PAV:VED_NR
    APK:DATUMS=PAV:datums
    APK:PIEN_DAT=PAV:DATUMS
    APK:PLKST =CLOCK()
    APK:ACC_KODS=ACC_KODS
    APK:ACC_DATUMS=TODAY()
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:AUTOAPK()
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
  INIRestoreWindow('UpdateAUTOAPK','winlats.INI')
  WinResize.Resize
  BRW2::AddQueue = True
  BRW2::RecordCount = 0
  BIND('BRW2::Sort1:Reset:APK:PAV_NR',BRW2::Sort1:Reset:APK:PAV_NR)
  BRW4::AddQueue = True
  BRW4::RecordCount = 0
  BIND('BRW4::Sort1:Reset:APK:PAV_NR',BRW4::Sort1:Reset:APK:PAV_NR)
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?Browse:2{Prop:Alrt,255} = InsertKey
  ?Browse:2{Prop:Alrt,254} = DeleteKey
  ?Browse:2{Prop:Alrt,253} = CtrlEnter
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?Browse:4{Prop:Alrt,252} = MouseLeft2
  ?Browse:4{Prop:Alrt,255} = InsertKey
  ?Browse:4{Prop:Alrt,254} = DeleteKey
  ?Browse:4{Prop:Alrt,253} = CtrlEnter
  ?Browse:4{Prop:Alrt,252} = MouseLeft2
  ?APK:PAV_NR{PROP:Alrt,255} = 734
  ?APK:DATUMS{PROP:Alrt,255} = 734
  ?APK:PIEN_DAT{PROP:Alrt,255} = 734
  ?APK:PLKST{PROP:Alrt,255} = 734
  ?APK:Nobraukums{PROP:Alrt,255} = 734
  ?APK:TEKSTS{PROP:Alrt,255} = 734
  ?APK:CTRL_DATUMS{PROP:Alrt,255} = 734
  ?APK:SAVIRZE_P{PROP:Alrt,255} = 734
  ?APK:SAVIRZE_A{PROP:Alrt,255} = 734
  ?APK:Diag_TEX{PROP:Alrt,255} = 734
  ?APK:ACC_KODS{PROP:Alrt,255} = 734
  ?APK:ACC_DATUMS{PROP:Alrt,255} = 734
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
    AUTOAPK::Used -= 1
    IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
    AUTODARBI::Used -= 1
    IF AUTODARBI::Used = 0 THEN CLOSE(AUTODARBI).
    AUTOTEX::Used -= 1
    IF AUTOTEX::Used = 0 THEN CLOSE(AUTOTEX).
  END
  IF WindowOpened
    INISaveWindow('UpdateAUTOAPK','winlats.INI')
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
  DO BRW4::SelectSort
  ?Browse:2{Prop:VScrollPos} = BRW2::CurrentScroll
  ?Browse:4{Prop:VScrollPos} = BRW4::CurrentScroll
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
  DO BRW4::GetRecord
!---------------------------------------------------------------------------
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
      IF BRW2::Sort1:Reset:APK:PAV_NR <> APK:PAV_NR
        BRW2::Changed = True
      END
    END
  ELSE
  END
  IF BRW2::SortOrder <> BRW2::LastSortOrder OR BRW2::Changed OR ForceRefresh
    CASE BRW2::SortOrder
    OF 1
      BRW2::Sort1:Reset:APK:PAV_NR = APK:PAV_NR
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
  MINMAXSUMMA=0
  LOOP
    NEXT(BRW2::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW2::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'AUTODARBI')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW2::FillQueue
    MINMAXSUMMA+=APD:LAIKS
  END
  SETCURSOR()
  DO BRW2::Reset
  PREVIOUS(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'AUTODARBI')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 1
    BRW2::Sort1:HighValue = APD:PAV_NR
  END
  DO BRW2::Reset
  NEXT(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'AUTODARBI')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 1
    BRW2::Sort1:LowValue = APD:PAV_NR
    SetupRealStops(BRW2::Sort1:LowValue,BRW2::Sort1:HighValue)
    LOOP BRW2::ScrollRecordCount = 1 TO 100
      BRW2::Sort1:KeyDistribution[BRW2::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW2::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  APD:ID = BRW2::APD:ID
  VUT = BRW2::VUT
  APD:NOMENKLAT = BRW2::APD:NOMENKLAT
  D = BRW2::D
  APD:LAIKS = BRW2::APD:LAIKS
  APD:GARANTIJA = BRW2::APD:GARANTIJA
  APD:PAV_NR = BRW2::APD:PAV_NR
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
  VUT=GETKADRI(APD:ID,0,1)
  IF BAND(APD:BAITS,00000001b)
     D='N'
  ELSE
     D='D'
  .
  
  
  BRW2::APD:ID = APD:ID
  BRW2::VUT = VUT
  BRW2::APD:NOMENKLAT = APD:NOMENKLAT
  BRW2::D = D
  BRW2::APD:LAIKS = APD:LAIKS
  BRW2::APD:GARANTIJA = APD:GARANTIJA
  BRW2::APD:PAV_NR = APD:PAV_NR
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
          IF BRW2::Sort1:KeyDistribution[BRW2::CurrentScroll] => APD:PAV_NR
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
      APD:PAV_NR = BRW2::Sort1:KeyDistribution[?Browse:2{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'AUTODARBI')
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
      BRW2::HighlightedPosition = POSITION(APD:NR_KEY)
      RESET(APD:NR_KEY,BRW2::HighlightedPosition)
    ELSE
      APD:PAV_NR = APK:PAV_NR
      SET(APD:NR_KEY,APD:NR_KEY)
    END
    BRW2::View:Browse{Prop:Filter} = |
    'APD:PAV_NR = BRW2::Sort1:Reset:APK:PAV_NR'
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
    CLEAR(APD:Record)
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
    APD:PAV_NR = APK:PAV_NR
    SET(APD:NR_KEY)
    BRW2::View:Browse{Prop:Filter} = |
    'APD:PAV_NR = BRW2::Sort1:Reset:APK:PAV_NR'
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
    APK:PAV_NR = BRW2::Sort1:Reset:APK:PAV_NR
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
  GET(AUTODARBI,0)
  CLEAR(APD:Record,0)
  CASE BRW2::SortOrder
  OF 1
    APD:PAV_NR = BRW2::Sort1:Reset:APK:PAV_NR
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
!| (UpdateAUTODARBI) is called.
!|
!| Upon return from the update, the routine BRW2::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW2::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateAUTODARBI
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
        GET(AUTODARBI,0)
        CLEAR(APD:Record,0)
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

!----------------------------------------------------------------------
BRW4::SelectSort ROUTINE
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
!|    f. The BrowseBox is reinitialized (BRW4::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW4::LastSortOrder = BRW4::SortOrder
  BRW4::Changed = False
  IF BRW4::SortOrder = 0
    BRW4::SortOrder = 1
  END
  IF BRW4::SortOrder = BRW4::LastSortOrder
    CASE BRW4::SortOrder
    OF 1
      IF BRW4::Sort1:Reset:APK:PAV_NR <> APK:PAV_NR
        BRW4::Changed = True
      END
    END
  ELSE
  END
  IF BRW4::SortOrder <> BRW4::LastSortOrder OR BRW4::Changed OR ForceRefresh
    CASE BRW4::SortOrder
    OF 1
      BRW4::Sort1:Reset:APK:PAV_NR = APK:PAV_NR
    END
    DO BRW4::GetRecord
    DO BRW4::Reset
    IF BRW4::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW4::LocateMode = LocateOnValue
        DO BRW4::LocateRecord
      ELSE
        FREE(Queue:Browse:4)
        BRW4::RefreshMode = RefreshOnTop
        DO BRW4::RefreshPage
        DO BRW4::PostNewSelection
      END
    ELSE
      IF BRW4::Changed
        FREE(Queue:Browse:4)
        BRW4::RefreshMode = RefreshOnTop
        DO BRW4::RefreshPage
        DO BRW4::PostNewSelection
      ELSE
        BRW4::LocateMode = LocateOnValue
        DO BRW4::LocateRecord
      END
    END
    IF BRW4::RecordCount
      GET(Queue:Browse:4,BRW4::CurrentChoice)
      DO BRW4::FillBuffer
    END
    DO BRW4::InitializeBrowse
  ELSE
    IF BRW4::RecordCount
      GET(Queue:Browse:4,BRW4::CurrentChoice)
      DO BRW4::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW4::InitializeBrowse ROUTINE
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
  DO BRW4::Reset
  PREVIOUS(BRW4::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW4::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'AUTOTEX')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW4::SortOrder
  OF 1
    BRW4::Sort1:HighValue = APX:PAV_NR
  END
  DO BRW4::Reset
  NEXT(BRW4::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW4::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'AUTOTEX')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW4::SortOrder
  OF 1
    BRW4::Sort1:LowValue = APX:PAV_NR
    SetupRealStops(BRW4::Sort1:LowValue,BRW4::Sort1:HighValue)
    LOOP BRW4::ScrollRecordCount = 1 TO 100
      BRW4::Sort1:KeyDistribution[BRW4::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW4::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  APX:PAZIME = BRW4::APX:PAZIME
  APX:TEKSTS = BRW4::APX:TEKSTS
  APX:PAV_NR = BRW4::APX:PAV_NR
!----------------------------------------------------------------------
BRW4::FillQueue ROUTINE
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
  BRW4::APX:PAZIME = APX:PAZIME
  BRW4::APX:TEKSTS = APX:TEKSTS
  BRW4::APX:PAV_NR = APX:PAV_NR
  BRW4::Position = POSITION(BRW4::View:Browse)
!----------------------------------------------------------------------
BRW4::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW4::NewSelectPosted
    BRW4::NewSelectPosted = True
    POST(Event:NewSelection,?Browse:4)
  END
!----------------------------------------------------------------------
BRW4::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW4::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW4::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW4::PopupText = ''
    IF BRW4::RecordCount
      IF BRW4::PopupText
        BRW4::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW4::PopupText
      ELSE
        BRW4::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
      IF BRW4::PopupText
        BRW4::PopupText = '&Ievadît|~&Mainît|~&Dzçst|-|' & BRW4::PopupText
      ELSE
        BRW4::PopupText = '&Ievadît|~&Mainît|~&Dzçst'
      END
    END
    EXECUTE(POPUP(BRW4::PopupText))
      POST(Event:Accepted,?Insert:5)
      POST(Event:Accepted,?Change:5)
      POST(Event:Accepted,?Delete:5)
    END
  ELSIF BRW4::RecordCount
    BRW4::CurrentChoice = CHOICE(?Browse:4)
    GET(Queue:Browse:4,BRW4::CurrentChoice)
    DO BRW4::FillBuffer
    IF BRW4::RecordCount = ?Browse:4{Prop:Items}
      IF ?Browse:4{Prop:VScroll} = False
        ?Browse:4{Prop:VScroll} = True
      END
      CASE BRW4::SortOrder
      OF 1
        LOOP BRW4::CurrentScroll = 1 TO 100
          IF BRW4::Sort1:KeyDistribution[BRW4::CurrentScroll] => APX:PAV_NR
            IF BRW4::CurrentScroll <= 1
              BRW4::CurrentScroll = 0
            ELSIF BRW4::CurrentScroll = 100
              BRW4::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:4{Prop:VScroll} = True
        ?Browse:4{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW4::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW4::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW4::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW4::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW4::RecordCount
    BRW4::CurrentEvent = EVENT()
    CASE BRW4::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW4::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW4::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW4::ScrollEnd
    END
    ?Browse:4{Prop:SelStart} = BRW4::CurrentChoice
    DO BRW4::PostNewSelection
  END
!----------------------------------------------------------------------
BRW4::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW4::FillRecord to retrieve one record in the direction required.
!|
  IF BRW4::CurrentEvent = Event:ScrollUp AND BRW4::CurrentChoice > 1
    BRW4::CurrentChoice -= 1
    EXIT
  ELSIF BRW4::CurrentEvent = Event:ScrollDown AND BRW4::CurrentChoice < BRW4::RecordCount
    BRW4::CurrentChoice += 1
    EXIT
  END
  BRW4::ItemsToFill = 1
  BRW4::FillDirection = BRW4::CurrentEvent - 2
  DO BRW4::FillRecord
!----------------------------------------------------------------------
BRW4::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW4::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW4::FillRecord doesn't fill a page (BRW4::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW4::ItemsToFill = ?Browse:4{Prop:Items}
  BRW4::FillDirection = BRW4::CurrentEvent - 4
  DO BRW4::FillRecord                           ! Fill with next read(s)
  IF BRW4::ItemsToFill
    IF BRW4::CurrentEvent = Event:PageUp
      BRW4::CurrentChoice -= BRW4::ItemsToFill
      IF BRW4::CurrentChoice < 1
        BRW4::CurrentChoice = 1
      END
    ELSE
      BRW4::CurrentChoice += BRW4::ItemsToFill
      IF BRW4::CurrentChoice > BRW4::RecordCount
        BRW4::CurrentChoice = BRW4::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW4::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW4::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse:4)
  BRW4::RecordCount = 0
  DO BRW4::Reset
  BRW4::ItemsToFill = ?Browse:4{Prop:Items}
  IF BRW4::CurrentEvent = Event:ScrollTop
    BRW4::FillDirection = FillForward
  ELSE
    BRW4::FillDirection = FillBackward
  END
  DO BRW4::FillRecord                           ! Fill with next read(s)
  IF BRW4::CurrentEvent = Event:ScrollTop
    BRW4::CurrentChoice = 1
  ELSE
    BRW4::CurrentChoice = BRW4::RecordCount
  END
!----------------------------------------------------------------------
BRW4::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW4::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW4::LocateRecord.
!|
  IF BRW4::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
      POST(Event:Accepted,?Change:5)
      DO BRW4::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:5)
    OF DeleteKey
      POST(Event:Accepted,?Delete:5)
    OF CtrlEnter
      POST(Event:Accepted,?Change:5)
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert:5)
    END
  END
  DO BRW4::PostNewSelection
!----------------------------------------------------------------------
BRW4::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW4::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW4::LocateRecord.
!|
  IF ?Browse:4{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:4)
  ELSIF ?Browse:4{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:4)
  ELSE
    CASE BRW4::SortOrder
    OF 1
      APX:PAV_NR = BRW4::Sort1:KeyDistribution[?Browse:4{Prop:VScrollPos}]
      BRW4::LocateMode = LocateOnValue
      DO BRW4::LocateRecord
    END
  END
!----------------------------------------------------------------------
BRW4::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW4::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW4::ItemsToFill records. Normally, this will
!| result in BRW4::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW4::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW4::AddQueue is true, the queue is filled using the BRW4::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW4::AddQueue is false is when the BRW4::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW4::RecordCount
    IF BRW4::FillDirection = FillForward
      GET(Queue:Browse:4,BRW4::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:4,1)                       ! Get the first queue item
    END
    RESET(BRW4::View:Browse,BRW4::Position)       ! Reset for sequential processing
    BRW4::SkipFirst = TRUE
  ELSE
    BRW4::SkipFirst = FALSE
  END
  LOOP WHILE BRW4::ItemsToFill
    IF BRW4::FillDirection = FillForward
      NEXT(BRW4::View:Browse)
    ELSE
      PREVIOUS(BRW4::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW4::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'AUTOTEX')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW4::SkipFirst
       BRW4::SkipFirst = FALSE
       IF POSITION(BRW4::View:Browse)=BRW4::Position
          CYCLE
       END
    END
    IF BRW4::AddQueue
      IF BRW4::RecordCount = ?Browse:4{Prop:Items}
        IF BRW4::FillDirection = FillForward
          GET(Queue:Browse:4,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:4,BRW4::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:4)
        BRW4::RecordCount -= 1
      END
      DO BRW4::FillQueue
      IF BRW4::FillDirection = FillForward
        ADD(Queue:Browse:4)
      ELSE
        ADD(Queue:Browse:4,1)
      END
      BRW4::RecordCount += 1
    END
    BRW4::ItemsToFill -= 1
  END
  BRW4::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW4::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW4::LocateMode. These modes are...
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
!| If an appropriate record has been located, the BRW4::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW4::LocateMode = LocateOnPosition
    BRW4::LocateMode = LocateOnEdit
  END
  CLOSE(BRW4::View:Browse)
  CASE BRW4::SortOrder
  OF 1
    IF BRW4::LocateMode = LocateOnEdit
      BRW4::HighlightedPosition = POSITION(APX:NR_KEY)
      RESET(APX:NR_KEY,BRW4::HighlightedPosition)
    ELSE
      APX:PAV_NR = APK:PAV_NR
      SET(APX:NR_KEY,APX:NR_KEY)
    END
    BRW4::View:Browse{Prop:Filter} = |
    'APX:PAV_NR = BRW4::Sort1:Reset:APK:PAV_NR'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW4::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:4)
  BRW4::RecordCount = 0
  BRW4::ItemsToFill = 1
  BRW4::FillDirection = FillForward               ! Fill with next read(s)
  BRW4::AddQueue = False
  DO BRW4::FillRecord                             ! Fill with next read(s)
  BRW4::AddQueue = True
  IF BRW4::ItemsToFill
    BRW4::RefreshMode = RefreshOnBottom
    DO BRW4::RefreshPage
  ELSE
    BRW4::RefreshMode = RefreshOnPosition
    DO BRW4::RefreshPage
  END
  DO BRW4::PostNewSelection
  BRW4::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW4::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW4::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse:4), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW4::RefreshMode = RefreshOnPosition
    BRW4::HighlightedPosition = POSITION(BRW4::View:Browse)
    RESET(BRW4::View:Browse,BRW4::HighlightedPosition)
    BRW4::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:4)
    GET(Queue:Browse:4,BRW4::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:4,RECORDS(Queue:Browse:4))
    END
    BRW4::HighlightedPosition = BRW4::Position
    GET(Queue:Browse:4,1)
    RESET(BRW4::View:Browse,BRW4::Position)
    BRW4::RefreshMode = RefreshOnCurrent
  ELSE
    BRW4::HighlightedPosition = ''
    DO BRW4::Reset
  END
  FREE(Queue:Browse:4)
  BRW4::RecordCount = 0
  BRW4::ItemsToFill = ?Browse:4{Prop:Items}
  IF BRW4::RefreshMode = RefreshOnBottom
    BRW4::FillDirection = FillBackward
  ELSE
    BRW4::FillDirection = FillForward
  END
  DO BRW4::FillRecord                             ! Fill with next read(s)
  IF BRW4::HighlightedPosition
    IF BRW4::ItemsToFill
      IF NOT BRW4::RecordCount
        DO BRW4::Reset
      END
      IF BRW4::RefreshMode = RefreshOnBottom
        BRW4::FillDirection = FillForward
      ELSE
        BRW4::FillDirection = FillBackward
      END
      DO BRW4::FillRecord
    END
  END
  IF BRW4::RecordCount
    IF BRW4::HighlightedPosition
      LOOP BRW4::CurrentChoice = 1 TO BRW4::RecordCount
        GET(Queue:Browse:4,BRW4::CurrentChoice)
        IF BRW4::Position = BRW4::HighlightedPosition THEN BREAK.
      END
      IF BRW4::CurrentChoice > BRW4::RecordCount
        BRW4::CurrentChoice = BRW4::RecordCount
      END
    ELSE
      IF BRW4::RefreshMode = RefreshOnBottom
        BRW4::CurrentChoice = RECORDS(Queue:Browse:4)
      ELSE
        BRW4::CurrentChoice = 1
      END
    END
    ?Browse:4{Prop:Selected} = BRW4::CurrentChoice
    DO BRW4::FillBuffer
    ?Change:5{Prop:Disable} = 0
    ?Delete:5{Prop:Disable} = 0
  ELSE
    CLEAR(APX:Record)
    BRW4::CurrentChoice = 0
    ?Change:5{Prop:Disable} = 1
    ?Delete:5{Prop:Disable} = 1
  END
  SETCURSOR()
  BRW4::RefreshMode = 0
  EXIT
BRW4::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW4::View:Browse)
  CASE BRW4::SortOrder
  OF 1
    APX:PAV_NR = APK:PAV_NR
    SET(APX:NR_KEY)
    BRW4::View:Browse{Prop:Filter} = |
    'APX:PAV_NR = BRW4::Sort1:Reset:APK:PAV_NR'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW4::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW4::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW4::RecordCount
    BRW4::CurrentChoice = CHOICE(?Browse:4)
    GET(Queue:Browse:4,BRW4::CurrentChoice)
    WATCH(BRW4::View:Browse)
    REGET(BRW4::View:Browse,BRW4::Position)
  END
!----------------------------------------------------------------------
BRW4::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
  CASE BRW4::SortOrder
  OF 1
    APK:PAV_NR = BRW4::Sort1:Reset:APK:PAV_NR
  END
BRW4::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:4
  BrowseButtons.InsertButton=?Insert:5
  BrowseButtons.ChangeButton=?Change:5
  BrowseButtons.DeleteButton=?Delete:5
  DO DisplayBrowseToolbar

!----------------------------------------------------------------
BRW4::ButtonInsert ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to insert a new record.
!|
!| First, the primary file's record  buffer is cleared, as well as any memos
!| or BLOBs. Next, any range-limit values are restored so that the inserted
!| record defaults to being added to the current display set.
!|
!| Next, LocalRequest is set to InsertRecord, and the BRW4::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the insert is successful (GlobalRequest = RequestCompleted) then the newly added
!| record is displayed in the BrowseBox, at the top of the listbox.
!|
!| If the insert is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  GET(AUTOTEX,0)
  CLEAR(APX:Record,0)
  CASE BRW4::SortOrder
  OF 1
    APX:PAV_NR = BRW4::Sort1:Reset:APK:PAV_NR
  END
  LocalRequest = InsertRecord
  DO BRW4::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW4::LocateMode = LocateOnEdit
    DO BRW4::LocateRecord
  ELSE
    BRW4::RefreshMode = RefreshOnQueue
    DO BRW4::RefreshPage
  END
  DO BRW4::InitializeBrowse
  DO BRW4::PostNewSelection
  SELECT(?Browse:4)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW4::ButtonChange ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to change a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW4::GetRecord routine.
!|
!| First, LocalRequest is set to ChangeRecord, and the BRW4::CallRecord routine
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
  DO BRW4::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW4::LocateMode = LocateOnEdit
    DO BRW4::LocateRecord
  ELSE
    BRW4::RefreshMode = RefreshOnQueue
    DO BRW4::RefreshPage
  END
  DO BRW4::InitializeBrowse
  DO BRW4::PostNewSelection
  SELECT(?Browse:4)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW4::ButtonDelete ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to delete a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW4::GetRecord routine.
!|
!| First, LocalRequest is set to DeleteRecord, and the BRW4::CallRecord routine
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
  DO BRW4::CallUpdate
  IF GlobalResponse = RequestCompleted
    DELETE(Queue:Browse:4)
    BRW4::RecordCount -= 1
  END
  BRW4::RefreshMode = RefreshOnQueue
  DO BRW4::RefreshPage
  DO BRW4::InitializeBrowse
  DO BRW4::PostNewSelection
  SELECT(?Browse:4)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW4::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdateAUTOTEX) is called.
!|
!| Upon return from the update, the routine BRW4::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW4::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateAUTOTEX
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
        GET(AUTOTEX,0)
        CLEAR(APX:Record,0)
      ELSE
        DO BRW4::PostVCREdit1
        BRW4::CurrentEvent=Event:ScrollDown
        DO BRW4::ScrollOne
        DO BRW4::PostVCREdit2
      END
    OF VCRBackward
      DO BRW4::PostVCREdit1
      BRW4::CurrentEvent=Event:ScrollUp
      DO BRW4::ScrollOne
      DO BRW4::PostVCREdit2
    OF VCRPageForward
      DO BRW4::PostVCREdit1
      BRW4::CurrentEvent=Event:PageDown
      DO BRW4::ScrollPage
      DO BRW4::PostVCREdit2
    OF VCRPageBackward
      DO BRW4::PostVCREdit1
      BRW4::CurrentEvent=Event:PageUp
      DO BRW4::ScrollPage
      DO BRW4::PostVCREdit2
    OF VCRFirst
      DO BRW4::PostVCREdit1
      BRW4::CurrentEvent=Event:ScrollTop
      DO BRW4::ScrollEnd
      DO BRW4::PostVCREdit2
    OF VCRLast
      DO BRW4::PostVCREdit1
      BRW4::CurrentEvent=Event:ScrollBottom
      DO BRW4::ScrollEND
      DO BRW4::PostVCREdit2
    END
  END
  DO BRW4::Reset

BRW4::PostVCREdit1 ROUTINE
  DO BRW4::Reset
  BRW4::LocateMode=LocateOnEdit
  DO BRW4::LocateRecord
  DO RefreshWindow

BRW4::PostVCREdit2 ROUTINE
  ?Browse:4{PROP:SelStart}=BRW4::CurrentChoice
  DO BRW4::NewSelection
  REGET(BRW4::View:Browse,BRW4::Position)
  CLOSE(BRW4::View:Browse)

!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?APK:PAV_NR
      APK:PAV_NR = History::APK:Record.PAV_NR
    OF ?APK:DATUMS
      APK:DATUMS = History::APK:Record.DATUMS
    OF ?APK:PIEN_DAT
      APK:PIEN_DAT = History::APK:Record.PIEN_DAT
    OF ?APK:PLKST
      APK:PLKST = History::APK:Record.PLKST
    OF ?APK:Nobraukums
      APK:Nobraukums = History::APK:Record.Nobraukums
    OF ?APK:TEKSTS
      APK:TEKSTS = History::APK:Record.TEKSTS
    OF ?APK:CTRL_DATUMS
      APK:CTRL_DATUMS = History::APK:Record.CTRL_DATUMS
    OF ?APK:SAVIRZE_P
      APK:SAVIRZE_P = History::APK:Record.SAVIRZE_P
    OF ?APK:SAVIRZE_A
      APK:SAVIRZE_A = History::APK:Record.SAVIRZE_A
    OF ?APK:Diag_TEX
      APK:Diag_TEX = History::APK:Record.Diag_TEX
    OF ?APK:ACC_KODS
      APK:ACC_KODS = History::APK:Record.ACC_KODS
    OF ?APK:ACC_DATUMS
      APK:ACC_DATUMS = History::APK:Record.ACC_DATUMS
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
  APK:Record = SAV::APK:Record
  SAV::APK:Record = APK:Record
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

