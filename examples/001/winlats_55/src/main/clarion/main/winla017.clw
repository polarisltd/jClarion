                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateARM_K PROCEDURE


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
History::ARM:Record LIKE(ARM:Record),STATIC
SAV::ARM:Record      LIKE(ARM:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:ARM:LB       LIKE(ARM:LB)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the ARM_K File'),AT(,,315,135),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),IMM,HLP('UpdateARM_K'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(4,4,305,100),USE(?CurrentTab)
                         TAB(' '),USE(?Tab:1)
                           PROMPT('&Kods:'),AT(8,20),USE(?ARM:KODS:Prompt)
                           ENTRY(@N03B),AT(61,20,21,10),USE(ARM:KODS),RIGHT(1)
                           PROMPT('&LB:'),AT(8,34),USE(?ARM:LB:Prompt)
                           ENTRY(@N03B),AT(61,34,22,10),USE(ARM:LB),RIGHT(1)
                           PROMPT('&Nosaukums:'),AT(8,48),USE(?ARM:NOS_P:Prompt)
                           ENTRY(@S71),AT(61,48,241,10),USE(ARM:NOS_P)
                           PROMPT('&Apraksts:'),AT(8,62),USE(?ARM:SATURS1:Prompt)
                           ENTRY(@S70),AT(61,62,241,10),USE(ARM:SATURS1)
                           ENTRY(@S70),AT(61,76,241,10),USE(ARM:SATURS2)
                           ENTRY(@S70),AT(61,90,241,10),USE(ARM:SATURS3)
                         END
                       END
                       BUTTON('&OK'),AT(210,113,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(259,113,45,14),USE(?Cancel)
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
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Adding a ARM_K Record'
  OF ChangeRecord
    ActionMessage = 'Changing a ARM_K Record'
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
      SELECT(?ARM:KODS:Prompt)
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
        History::ARM:Record = ARM:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(ARM_K)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(ARM:KODS_KEY)
              IF StandardWarning(Warn:DuplicateKey,'ARM:KODS_KEY')
                SELECT(?ARM:KODS:Prompt)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?ARM:KODS:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::ARM:Record <> ARM:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:ARM_K(1)
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
              SELECT(?ARM:KODS:Prompt)
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
  IF ARM_K::Used = 0
    CheckOpen(ARM_K,1)
  END
  ARM_K::Used += 1
  BIND(ARM:RECORD)
  FilesOpened = True
  RISnap:ARM_K
  SAV::ARM:Record = ARM:Record
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
        IF RIDelete:ARM_K()
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
  INIRestoreWindow('UpdateARM_K','winlats.INI')
  WinResize.Resize
  ?ARM:KODS{PROP:Alrt,255} = 734
  ?ARM:LB{PROP:Alrt,255} = 734
  ?ARM:NOS_P{PROP:Alrt,255} = 734
  ?ARM:SATURS1{PROP:Alrt,255} = 734
  ?ARM:SATURS2{PROP:Alrt,255} = 734
  ?ARM:SATURS3{PROP:Alrt,255} = 734
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
    ARM_K::Used -= 1
    IF ARM_K::Used = 0 THEN CLOSE(ARM_K).
  END
  IF WindowOpened
    INISaveWindow('UpdateARM_K','winlats.INI')
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
    OF ?ARM:KODS
      ARM:KODS = History::ARM:Record.KODS
    OF ?ARM:LB
      ARM:LB = History::ARM:Record.LB
    OF ?ARM:NOS_P
      ARM:NOS_P = History::ARM:Record.NOS_P
    OF ?ARM:SATURS1
      ARM:SATURS1 = History::ARM:Record.SATURS1
    OF ?ARM:SATURS2
      ARM:SATURS2 = History::ARM:Record.SATURS2
    OF ?ARM:SATURS3
      ARM:SATURS3 = History::ARM:Record.SATURS3
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
  ARM:Record = SAV::ARM:Record
  SAV::ARM:Record = ARM:Record
  Auto::Attempts = 0
  LOOP
    SET(ARM:LB_KEY)
    PREVIOUS(ARM_K)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'ARM_K')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:ARM:LB = 1
    ELSE
      Auto::Save:ARM:LB = ARM:LB + 1
    END
    ARM:Record = SAV::ARM:Record
    ARM:LB = Auto::Save:ARM:LB
    SAV::ARM:Record = ARM:Record
    ADD(ARM_K)
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
        DELETE(ARM_K)
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

BrowseARM_K PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG

BRW1::View:Browse    VIEW(ARM_K)
                       PROJECT(ARM:KODS)
                       PROJECT(ARM:LB)
                       PROJECT(ARM:NOS_P)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::ARM:KODS         LIKE(ARM:KODS)             ! Queue Display field
BRW1::ARM:LB           LIKE(ARM:LB)               ! Queue Display field
BRW1::ARM:NOS_P        LIKE(ARM:NOS_P)            ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(ARM:LB),DIM(100)
BRW1::Sort1:LowValue LIKE(ARM:LB)                 ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(ARM:LB)                ! Queue position of scroll thumb
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort2:KeyDistribution LIKE(ARM:KODS),DIM(100)
BRW1::Sort2:LowValue LIKE(ARM:KODS)               ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(ARM:KODS)              ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Ârçjo maksâjumu kodi'),AT(,,312,331),FONT('MS Sans Serif',8,,FONT:bold,CHARSET:BALTIC),IMM,HLP('BrowseARM_K'),SYSTEM,GRAY,RESIZE
                       LIST,AT(8,20,296,265),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('28C|M~Kods~@N03B@25C|M~LB~@N03B@80L(1)|M~Apraksts~L(7)@S71@'),FROM(Queue:Browse:1)
                       BUTTON('&Ievadît'),AT(155,290,45,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(205,290,45,14),USE(?Change:2),DEFAULT
                       BUTTON('&Dzçst'),AT(254,290,45,14),USE(?Delete:2)
                       BUTTON('Iz&vçlçties'),AT(210,312,45,14),USE(?Select)
                       SHEET,AT(4,4,303,304),USE(?CurrentTab)
                         TAB('Kodu secîba'),USE(?Tab:2)
                           ENTRY(@N03B),AT(18,291,26,10),USE(ARM:KODS)
                           STRING('-pçc koda'),AT(48,291),USE(?String1)
                         END
                         TAB('LB secîba'),USE(?Tab:3)
                         END
                       END
                       BUTTON('&Beigt'),AT(261,311,45,14),USE(?Close)
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
  !        IF ~OPENANSI('ARMAKS_LB.TXT',2)
  !           STOP('ANSI:'&ERROR())
  !        .
  !        SET(OUTFILEANSI)
  !        LOOP
  !           NEXT(OUTFILEANSI)
  !           I#+=1
  !           IF ERROR()
  !              BREAK
  !           .
  !           IF NUMERIC(OUTA:LINE[1:3])
  !              IF R#
  !                 PUT(ARM_K)
  !              .
  !              CLEAR(ARM:RECORD)
  !              R#+=1
  !              I#=1
  !              ARM:LB=R#
  !              ADD(ARM_K)
  !           .
  !           EXECUTE I#
  !              ARM:KODS=OUTA:LINE[1:3]
  !              ARM:NOS_P=OUTA:LINE[1:71]
  !              ARM:SATURS1=OUTA:LINE[1:70]
  !              ARM:SATURS2=OUTA:LINE[1:70]
  !              ARM:SATURS3=OUTA:LINE[1:70]
  !           .
  !           IF ARM:KODS=11 !PÇDÇJAIS
  !              PUT(ARM_K)
  !           .
  !        .
  !        CLOSE(OUTFILEANSI)
  
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
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?Insert:2
      CASE EVENT()
      OF EVENT:Accepted
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
    OF ?ARM:KODS
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?ARM:KODS)
        IF ARM:KODS
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort2:LocatorValue = ARM:KODS
          BRW1::Sort2:LocatorLength = LEN(CLIP(ARM:KODS))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
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
  IF ARM_K::Used = 0
    CheckOpen(ARM_K,1)
  END
  ARM_K::Used += 1
  BIND(ARM:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseARM_K','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
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
    ARM_K::Used -= 1
    IF ARM_K::Used = 0 THEN CLOSE(ARM_K).
  END
  IF WindowOpened
    INISaveWindow('BrowseARM_K','winlats.INI')
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
  OF 2
    ARM:KODS = BRW1::Sort2:LocatorValue
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
  IF CHOICE(?CurrentTab) = 2
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
      ARM:KODS = BRW1::Sort2:LocatorValue
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
      StandardWarning(Warn:RecordFetchError,'ARM_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = ARM:LB
  OF 2
    BRW1::Sort2:HighValue = ARM:KODS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'ARM_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = ARM:LB
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  OF 2
    BRW1::Sort2:LowValue = ARM:KODS
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
  ARM:KODS = BRW1::ARM:KODS
  ARM:LB = BRW1::ARM:LB
  ARM:NOS_P = BRW1::ARM:NOS_P
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
  BRW1::ARM:KODS = ARM:KODS
  BRW1::ARM:LB = ARM:LB
  BRW1::ARM:NOS_P = ARM:NOS_P
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
      POST(Event:Accepted,?Change:2)
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => ARM:LB
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
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => ARM:KODS
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
      ARM:KODS = BRW1::Sort2:LocatorValue
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
      POST(Event:Accepted,?Change:2)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
    OF DeleteKey
      POST(Event:Accepted,?Delete:2)
    OF CtrlEnter
      POST(Event:Accepted,?Change:2)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          IF UPPER(SUB(ARM:LB,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(ARM:LB,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            ARM:LB = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            ARM:KODS = BRW1::Sort2:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          ARM:KODS = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          ARM:KODS = BRW1::Sort2:LocatorValue
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
      ARM:LB = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 2
      ARM:KODS = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'ARM_K')
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
      BRW1::HighlightedPosition = POSITION(ARM:LB_KEY)
      RESET(ARM:LB_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(ARM:LB_KEY,ARM:LB_KEY)
    END
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(ARM:KODS_KEY)
      RESET(ARM:KODS_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(ARM:KODS_KEY,ARM:KODS_KEY)
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
    OF 2; ?ARM:KODS{Prop:Disable} = 0
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
    ?Delete:2{Prop:Disable} = 0
  ELSE
    CLEAR(ARM:Record)
    CASE BRW1::SortOrder
    OF 2; ?ARM:KODS{Prop:Disable} = 1
    END
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
    SET(ARM:LB_KEY)
  OF 2
    SET(ARM:KODS_KEY)
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
  BrowseButtons.ChangeButton=?Change:2
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
  GET(ARM_K,0)
  CLEAR(ARM:Record,0)
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
!| (UpdateARM_K) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateARM_K
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
        GET(ARM_K,0)
        CLEAR(ARM:Record,0)
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


R_Brio_dbf           PROCEDURE                    ! Declare Procedure
LocalResponse         LONG
Auto::Attempts        LONG,AUTO
Auto::Save:G1:U_NR    LIKE(GG:U_NR)
DISKS                 CSTRING(60)
DISKETE               BYTE
MERKIS                STRING(1)
darbiba               STRING(30)
FAILS                 CSTRING(20)
GG_Dok_SENR           LIKE(GG:DOK_SENR)
DOK_SK                USHORT
KONT_SK               USHORT
DATUMS                LONG
SDATUMS               STRING(8)
SCLIENT               STRING(12) !+1 05.12.08
SREFERENCE            STRING(13)
PAR_FILEALE           STRING(1)
PAR_REG_NR            STRING(12) !D/S+1 05.12.08
PR_DEBET              STRING(5)
PR_KREDIT             STRING(5)
NODALA                STRING(2)
PR_NODALA             STRING(2)
ATT_DOK               LIKE(GG:ATT_DOK)
Dok_SENR              LIKE(GG:Dok_SENR)
GK1_KK                BYTE
PR_DUS                STRING(2)

ReadScreen WINDOW('Lasu apmaiòas failu'),AT(,,180,55),GRAY
       STRING(@s30),AT(24,20),USE(darbiba)
     END

PROVODKI            FILE,DRIVER('DBASE3'),NAME(DOSNAME),PRE(PR)
RECORD                RECORD
RTYPE                   REAL,NAME('RTYPE=N(1.0)')
DATE                    DATE
NUMBER                  STRING(13)
CLIENT                  STRING(40)
FILIAL                  STRING(4)     ! 22/11/05
DEBET                   STRING(6)
KREDIT                  STRING(6)
FUEL                    STRING(6)
QTY                     REAL,NAME('QTY=N(9.2)')
SUMM                    REAL,NAME('SUMM=N(9.2)')
DUS                     REAL,NAME('DUS=N(2.0)')
                      END
                    END

P_TABLE             QUEUE,PRE(P)
KEY                   STRING(37)  ! RTYPE 1+ SDATUMS 8+NUMBER 13+SCLIENT 12+FILEALE 1 + PR_DUS 2  !+1 05.12.08
P:BKK                 STRING(5),DIM(140)
P:NODALA              STRING(2),DIM(140)
P:REFERENCE           DECIMAL(10)
P:D_K                 STRING(1),DIM(140)
!P:SUMMA               DECIMAL(7,2),DIM(140)
P:SUMMA               DECIMAL(9,2),DIM(140)
ATT_DOK               LIKE(GG:ATT_DOK)
                    END

!KK_TABLE            QUEUE,PRE(K)
!NODALA                STRING(2)
!                    END

GK1_KK_TABLE        QUEUE,PRE(G)
NODALA                STRING(2)
INDEX                 BYTE
                    END
  CODE                                            ! Begin processed code
   FILENAME1=CLIP(PATH())&'\GGBR.TPS'
   FILENAME2=CLIP(PATH())&'\GGKBR.TPS'
   CHECKOPEN(G1,1)
   CLOSE(G1)
   OPEN(G1,18)
   EMPTY(G1)
   CHECKOPEN(GK1,1)
   CLOSE(GK1)
   OPEN(GK1,18)
   EMPTY(GK1)

   IF PAR_K::USED=0
      CHECKOPEN(PAR_K,1)
   .
   PAR_K::USED+=1
   TTAKA"=PATH()
   IF FILEDIALOG('...TIKAI PROVODKI.DBF FAILI !!!',DOSNAME,'DBF3|*.dbf',0)
      SETPATH(TTAKA")
      !17/04/2012Elya NODALA=DOSNAME[INSTRING('.',UPPER(DOSNAME))-1]
      n# = INSTRING('PROVOD',DOSNAME,1,INSTRING('.',UPPER(DOSNAME))-8)+6
      k# = INSTRING('.',UPPER(DOSNAME))-1
      NODALA = CLIP(DOSNAME[n#:k#])
!      STOP(INSTRING('.',UPPER(DOSNAME))&'  '&NODALA&' '&DOSNAME)
      IF DOSNAME[1]='A'
         LOOP I#=LEN(DOSNAME)-1 TO 1 BY -1
            IF DOSNAME[I#]='\'
               FAILS=DOSNAME[I#+1:LEN(DOSNAME)]
               FOUND#=1
               BREAK
            .
         .
         USERFOLDER=USERFOLDER&'\'
         COPY(PROVODKI,USERFOLDER)
         IF ERROR()
            KLUDA(3,DOSNAME&' uz A:\ '&error())
            DO PROCEDURERETURN
         .
         DOSNAME=USERFOLDER&FAILS
      .
      OPEN(ReadScreen)
      CONVERTDBF(DOSNAME)
      CHECKOPEN(PROVODKI,1)
      SET(PROVODKI)
      LOOP
        NEXT(PROVODKI)
        NPK#+=1
        DATUMS=PR:DATE
        DARBIBA='Lasu PROVODKI'&NPK#&' '&PR:SUMM&' '&FORMAT(DATUMS,@D06.)
        DISPLAY
        IF ERROR() THEN BREAK.
        !13/11/2015 IF PR:RTYPE=1 OR PR:RTYPE=2 OR PR:RTYPE=3 OR PR:RTYPE=4 OR PR:RTYPE=8
        IF PR:RTYPE=1 OR PR:RTYPE=2 OR PR:RTYPE=3 OR PR:RTYPE=4 OR PR:RTYPE=8 OR PR:RTYPE=6 OR PR:RTYPE=7 OR PR:RTYPE=5  !13/11/2015
           DO ADDTABLE
        .
      .

      KONT_SK=0
      DOK_SK=0
      LOOP P#=1 TO RECORDS(P_TABLE)
         GET(P_TABLE,P#)
         DO AUTONUMBER
         DARBIBA='Rakstu GGBR.tps '&P#
         DISPLAY
!         G1:Dok_se               = ''
!         GG_Dok_NR               = ''
!         PR:NUMBER               = P:KEY[10:22]
!         LOOP I#=1 TO 13
!            IF PR:NUMBER[I#] AND ~(INSTRING(PR:NUMBER[I#],'-.'))
!               IF NUMERIC(PR:NUMBER[I#])
!                  GG_Dok_nr      = CLIP(GG_DOK_NR)&PR:NUMBER[I#]
!               ELSE
!                  G1:Dok_se      = CLIP(G1:DOK_SE)&PR:NUMBER[I#]
!               .
!            .
!         .
!         G1:Dok_nr               = RIGHT(GG_Dok_nr)
         Dok_SENR             = P:KEY[10:22]
         IF DOK_SENR[4]=' ' !JAUNAIS NR
            G1:Dok_SENR=Dok_SENR
         ELSE
            FOUND#=FALSE
            J#=0
            LOOP I#=1 TO 12
               J#+=1
               IF I#=5 AND NUMERIC(DOK_SENR[I#])
                  G1:Dok_SENR[J#]=' '
                  J#+=1
                  FOUND#=TRUE
               ELSIF I#=6 AND NUMERIC(DOK_SENR[I#]) AND FOUND#=FALSE
                  G1:Dok_SENR[J#]=' '
                  J#+=1
               .
               G1:Dok_SENR[J#]=Dok_SENR[I#]
               IF I#=2 AND ~NUMERIC(DOK_SENR[I#])
                  J#+=1
                  G1:Dok_SENR[J#]='-'
               .
            .
         .
         DATUMS                  = P:KEY[2:9]
         G1:APMdat               = DATUMS
         G1:Dokdat               = DATUMS
         G1:Datums               = DATUMS
!         PAR_REG_NR              = P:KEY[23:33]
         PAR_REG_NR              = P:KEY[23:34] !12
         PAR_FILEALE             = P:KEY[35]
!         STOP(PAR_REG_NR&'='&P:KEY[23:33])
         CLEAR(PAR:RECORD)
         PAR:NMR_KODS=PAR_REG_NR
         PAR:NMR_PLUS=PAR_FILEALE
         GET(PAR_K,PAR:NMR_KEY)
         IF ~ERROR()
            G1:Noka              =  PAR:NOS_S
            G1:Par_nr            =  PAR:U_NR
         ELSE
!            G1:Noka              =  P:KEY[23:34]
            G1:Noka              =  P:KEY[23:35]
            G1:PAR_NR            =  0
         .
         G1:ATT_DOK              =  P:ATT_DOK
!         stop(g1:noka&'='&P:KEY[23:33])
         IF P:KEY[1]='8'
            G1:Saturs               =  'Imports no Brio, Rtype='&P:KEY[1]
         ELSE
            G1:Saturs               =  'Imports no Brio, Rtype='&P:KEY[1]&' N='&NODALA
         .
!         G1:Saturs2              =
!         G1:Saturs3              =
         !14/01/2014 <
         !G1:Val                  = 'Ls'
         if val_uzsk = 'EUR'
             G1:Val                  = 'EUR'
         else
             G1:Val                  = 'Ls'
         .
         !14/01/2014 >
         G1:ACC_KODS             = ACC_KODS
         G1:ACC_DATUMS           = TODAY()
         G1:U_NR=Auto::Save:G1:U_NR

         DO WRITEGGK

       !   G1:IMP_NR=CON_NR
         IF RIUPDATE:G1()
            KLUDA(24,'G1')
         .
         DOK_SK+=1
      .
   .
   CLOSE(ReadScreen)
   KLUDA(0,'KOPÂ: '&clip(DOK_SK)&' dokumenti '&clip(kont_sk)&' kontçjumi',,1)
   DO PROCEDURERETURN

!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ REÂLO GG
  Auto::Attempts = 0
  LOOP
    SET(G1:NR_KEY)
    PREVIOUS(G1)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'G1')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:G1:U_NR = 2
    ELSE
      Auto::Save:G1:U_NR = G1:U_NR + 1
    END
    clear(G1:Record)
    G1:DATUMS=TODAY()
    G1:U_NR = Auto::Save:G1:U_NR
    ADD(G1)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          DO PROCEDURERETURN
        END
      END
      CYCLE
    END
    BREAK
  END

!---------------------------------------------------------------------------------------------
PROCEDURERETURN    ROUTINE
  FREE(P_TABLE)
!  FREE(KK_TABLE)
  CLOSE(GK1)
  CLOSE(G1)
  CLOSE(PROVODKI)
  PAR_K::USED-=1
  IF PAR_K::USED=0
     CLOSE(PAR_K)
  .
  RETURN

!---------------------------------------------------------------------------------------------
AddTable ROUTINE

  DATUMS=PR:DATE
  IF PR:RTYPE=2 OR PR:RTYPE=3
     DATUMS=DATE(MONTH(DATUMS)+1,1,YEAR(DATUMS))-1 !JO PAR PERIODU
     ATT_DOK='0'
  ELSIF PR:RTYPE=8
     ATT_DOK='1'
  ELSIF PR:RTYPE=4 !Elya - kreditrekins (un atgriesana)
     ATT_DOK='4'
  ELSE
     ATT_DOK='1'
  .
  SDATUMS=DATUMS
  SCLIENT=''
  LOOP J#=1 TO 39
!     IF NUMERIC(PR:CLIENT[J#]) AND ~(INSTRING(PR:CLIENT[J#],'-.'))
     IF NUMERIC(PR:CLIENT[J#]) OR PR:CLIENT[J#]='-' !SITÂ GLÂBJAM F, NE C,N
        SCLIENT=CLIP(SCLIENT)&PR:CLIENT[J#]
     .
  .
  IF SCLIENT='00030728100' !BANKSERVISS, KUR NODAÏAS IR > 8
     PR_DUS=PR:DUS
  ELSE
     PR_DUS=''
  .
  P:KEY=PR:RTYPE&SDATUMS&PR:NUMBER&SCLIENT&PR:FILIAL[1]&PR_DUS
!  P:KEY=PR:RTYPE&SDATUMS&PR:NUMBER&SCLIENT&PR:FILIAL[1]   ! NOÒEMTS DÇÏ WINLAOLD.EXE
!  P:KEY=PR:RTYPE&SDATUMS&PR:NUMBER&SCLIENT
  GET(P_TABLE,P:KEY)
  IF ERROR()
     CLEAR(P:BKK)
     CLEAR(P:NODALA)
     CLEAR(P:SUMMA)
     CLEAR(P:D_K)
     ACTION#=1
  ELSE
     ACTION#=2
  .
  FOUND_D#=0
  FOUND_K#=0
!  IF PR:KREDIT[1:4]='6111'
!     PR_KREDIT='61120'
  IF PR:KREDIT[1:6]='611900'
       PR_KREDIT='63310'
  ELSIF PR:KREDIT[1:5]='61140'    !28/10/2015
       PR_KREDIT='61140'       !28/10/2015
!  ELSIF PR:KREDIT[1:5]='61149' !13/11/2015
!      PR_KREDIT='62171'        !13/11/2015
  ELSIF PR:KREDIT[1:5]='60000'  !13/11/2015
      PR_KREDIT='61141'         !13/11/2015

  ELSIF PR:KREDIT[1:4]='6113'
      PR_KREDIT='61191'
  ELSIF PR:KREDIT[1:4]='5721' OR PR:KREDIT[1:2]='62'
      PR_KREDIT=PR:KREDIT[1:5]
  ELSIF PR:KREDIT[1:4]='6119' OR PR:KREDIT[1:4]='5541'  !11/12/2014 Elya
     PR_KREDIT=PR:KREDIT[1:5]       !11/12/2014 Elya
  ELSE
     PR_KREDIT=PR:KREDIT[1:4]&'0'
  .
  !28/10/2015 <
!  IF PR:DEBET[1:4]='2131' THEN PR:DEBET='21320'.
!  IF PR:DEBET[1:3]='267' OR PR:DEBET[1:4]='5721'   !ÐITAM JÂSAGLABÂ VISAS 5 ZÎMES
  !13/11/2015 IF PR:DEBET[1:3]='267' OR PR:DEBET[1:4]='5721' OR PR:DEBET[1:3]='213'  !ÐITAM JÂSAGLABÂ VISAS 5 ZÎMES
  IF PR:DEBET[1:3]='267' OR PR:DEBET[1:4]='5721'   !13/11/2015
  !28/10/2015 >
     PR_DEBET=PR:DEBET[1:5]
  ELSIF PR:DEBET[1:5]='7121A'                      !ÐITAIS JÂSAGLABÂ KÂ IR
     PR_DEBET=PR:DEBET[1:5]
  ELSIF PR:DEBET[1:5]='21300'                      !ÐITAIS JÂSAGLABÂ KÂ IR
     PR_DEBET='21310'
  ELSE
     PR_DEBET=PR:DEBET[1:4]&'0'
  .
!  IF PR:RTYPE=8 AND PR:FUEL>'00000'
!      PR_KREDIT='61110'
!      PR_DEBET='23100'
!  .
!****************References atgrieztai precei*********************
  Sreference=''
  IF PR:DEBET[1:3]='531'
     LOOP J#=1 TO 13
        IF NUMERIC(PR:NUMBER[J#]) AND ~(INSTRING(PR:CLIENT[J#],'-.'))
           Sreference=CLIP(Sreference)&PR:NUMBER[J#]
        .
     .
  .
  p:reference=SREFERENCE
  LOOP J#=1 TO 140
     !17/07/2012 Elya IF PR:RTYPE=8
     IF PR:RTYPE=8 OR PR:RTYPE=7
        CASE PR:DUS
        OF 1
           PR_NODALA='P'
        OF 9
           PR_NODALA='B'
        OF 10
           PR_NODALA='1'
        OF 11
           PR_NODALA='F'
        OF 16
           PR_NODALA='G'
        OF 17
           PR_NODALA='H'
        OF 19
           PR_NODALA='J'
        OF 20
           PR_NODALA='2'
        OF 21
           PR_NODALA='L'
        OF 22
           PR_NODALA='M'
        OF 23
           PR_NODALA='N'
        OF 24
           PR_NODALA='Q'
        !17/07/2012 Elya
        OF 25
           PR_NODALA='05'
        OF 26
           PR_NODALA='06'
        OF 27
           PR_NODALA='07'
        OF 28
           PR_NODALA='08'
        OF 29
           PR_NODALA='09' !Elya 02/03/2014
        ELSE
!           IF INRANGE(PR:DUS,2,8)
              PR_NODALA=PR:DUS
!           ELSE
!              PR_NODALA='?'
!           .
        .
     ELSE
        PR_NODALA=NODALA
     .
     IF ~FOUND_D# AND (~P:BKK[J#] OR (P:BKK[J#]=PR_DEBET AND P:NODALA[J#]=PR_NODALA AND P:D_K[J#]='D'))
        P:BKK[J#]=PR_DEBET
        P:NODALA[J#]=PR_NODALA
        P:SUMMA[J#]+=PR:SUMM
        P:D_K[J#]='D'
        P:ATT_DOK=ATT_DOK
        FOUND_D#=1
     ELSIF ~FOUND_K# AND (~P:BKK[J#] OR (P:BKK[J#]=PR_KREDIT AND P:NODALA[J#]=PR_NODALA AND P:D_K[J#]='K'))
        P:BKK[J#]=PR_KREDIT
        P:NODALA[J#]=PR_NODALA
        P:SUMMA[J#]+=PR:SUMM
        P:D_K[J#]='K'
        P:ATT_DOK=ATT_DOK
        FOUND_K#=1
     .
!     K:NODALA=PR_NODALA
!     GET(KK_TABLE,K:NODALA)
!     IF ERROR()
!        K:NODALA=PR_NODALA
!        ADD(KK_TABLE)
!        SORT(KK_TABLE,K:NODALA)
!     .
  .
  EXECUTE ACTION#
     BEGIN
        ADD(P_TABLE)
        SORT(P_TABLE,P:KEY)
     .
     PUT(P_TABLE)
  .

!---------------------------------------------------------------------------------------------
WRITEGGK ROUTINE
   G1:SUMMA=0
   GK1_KK=0
   JAUBRIDINAJU#=FALSE
   FREE(GK1_KK_TABLE)
   LOOP J# = 1 TO 140
      IF P:BKK[J#]
         GK1:U_nr                = G1:U_NR
         GK1:Rs                  = ''
         GK1:Datums              = G1:datums
         GK1:Par_nr              = G1:par_nr
         GK1:Reference           = P:REFERENCE
         GK1:Bkk                 = P:BKK[J#]
         GK1:D_k                 = P:d_k[J#]
         GK1:Summa               = P:summa[J#]
         GK1:Summav              = P:SUMMA[J#]
         !14/01/2014 <
         !GK1:Val                 = 'Ls'
         if val_uzsk = 'EUR'
             GK1:Val                  = 'EUR'
         else
             GK1:Val                  = 'Ls'
         .
         !14/01/2014 >
         IF P:BKK[J#]='57213'
            IF YEAR(G1:DATUMS)>2010
               GK1:Pvn_proc      = 12
            ELSE
               GK1:Pvn_proc      = 10 !5
            .
         ELSIF P:BKK[J#]='57212'
            GK1:Pvn_proc         = 21 !18 !TAGAD JAUNS
         ELSE
            !17/07/2012Elya IF YEAR(G1:DATUMS)>2010
            IF G1:DATUMS>=DATE(6,1,2012)
               GK1:Pvn_proc         = 21
            ELSIF YEAR(G1:DATUMS)>2010
               GK1:Pvn_proc         = 22
            ELSE
               GK1:Pvn_proc         = 21 !18
            .
         .
         GK1:Pvn_tips            = '0'
         IF P:ATT_DOK='4' THEN GK1:PVN_TIPS='A'. !Elya atgriesana
         GK1:BAITS               = 0 ! IEZAKS
         GK1:Kk                  = 0
         GK1:NODALA              = P:NODALA[J#]
         G:NODALA=GK1:NODALA
         GET(GK1_KK_TABLE,G:NODALA)
         IF ~ERROR()
            GK1_KK=G:INDEX
         ELSE
            GK1_KK=RECORDS(GK1_KK_TABLE)+1
            G:NODALA=GK1:NODALA
            G:INDEX=GK1_KK
            ADD(GK1_KK_TABLE)
            SORT(GK1_KK_TABLE,G:NODALA)
         .
         IF (GK1:D_K='K' AND GK1:Bkk[1:3]='231') OR GK1:Bkk='7121A'
            GK1_KK+=4            !ZEMNIEKU DÎZELIS
         .
         IF INRANGE(GK1_KK,1,8)
            GK1:KK=2^(GK1_KK-1)  !KATRAI NODAÏAI SAVS TRENDS
         ELSE
            GK1:KK=0
            IF ~JAUBRIDINAJU#
               KLUDA(0,'NEVAR AIZPILDÎT KK '&G1:Dok_SENR)
               JAUBRIDINAJU#=TRUE
            .
         .
         GK1:OBJ_NR              = 0
         GK1:U_NR                = G1:U_NR
         IF GK1:D_K='D'
            G1:SUMMA+=GK1:SUMMA
         .
         ADD(GK1)
!         STOP(G1:DOK_SENR&' '&GK1:KK)
         IF ERROR()
            STOP(ERROR())
         ELSE
            KONT_SK+=1
         .
      ELSE
         BREAK
      .
   .

