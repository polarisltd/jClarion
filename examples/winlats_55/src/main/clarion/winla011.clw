                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateVesture PROCEDURE


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
VUT                  STRING(25)
Update::Reloop  BYTE
Update::Error   BYTE
History::VES:Record LIKE(VES:Record),STATIC
SAV::VES:Record      LIKE(VES:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
FLD5::View           VIEW(PAROLES)
                       PROJECT(SEC:U_NR)
                       PROJECT(SEC:VUT)
                     END
Queue:FileDropCombo  QUEUE,PRE
FLD5::SEC:U_NR         LIKE(SEC:U_NR)
FLD5::SEC:VUT          LIKE(SEC:VUT)
                     END
FLD5::LoopIndex      LONG,AUTO
QuickWindow          WINDOW('Update the VESTURE File'),AT(,,282,259),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateVesture'),GRAY,RESIZE,MDI
                       SHEET,AT(3,4,273,230),USE(?CurrentTab),FONT(,9,,FONT:bold)
                         TAB('Norçíini par konkrçtu dokumentu vai vienkârði piezîmes/darbi'),USE(?Tab:1)
                           BUTTON('Y-Raksta statuss'),AT(9,22,63,14),USE(?Rakstastatuss)
                           IMAGE('CANCEL4.ICO'),AT(75,16,16,20),USE(?ImageRS),HIDE
                           PROMPT('CRM:'),AT(8,41),USE(?VES:CRM:Prompt)
                           ENTRY(@n3B),AT(64,39,28,10),USE(VES:CRM)
                           STRING('hierarhijas lîmenis aktuâlo darbu sarakstâ (0-neiekïaut)'),AT(96,39),USE(?String5),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           PROMPT('Nodot:'),AT(9,53),USE(?VES:KAM:Prompt),HIDE
                           PROMPT('Dokumenta Nr'),AT(8,65,54,10),USE(?VES:DOK_SE:Prompt)
                           ENTRY(@s14),AT(64,65,59,10),USE(VES:DOK_SENR)
                           COMBO(@n6b),AT(64,52,83,11),USE(VES:KAM),DISABLE,FORMAT('24R(1)|M~U Nr~R(2)@n_5@100L(2)|M~Vârds~L(1)@s25@'),DROP(5),FROM(Queue:FileDropCombo),MSG('ACC_KODS_N')
                           STRING(@s25),AT(150,52),USE(VUT),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           PROMPT('Samaksât lîdz...'),AT(8,78),USE(?VES:APMDAT:Prompt)
                           ENTRY(@D06.B),AT(64,78,41,10),USE(VES:APMDAT,,?VES:APMDAT:2),CENTER
                           PROMPT('Dok.datums'),AT(8,89),USE(?VES:DOKDAT:Prompt)
                           ENTRY(@D06.B),AT(64,90,41,10),USE(VES:DOKDAT),CENTER(1)
                           ENTRY(@T1),AT(108,102,27,10),USE(VES:SECIBA)
                           PROMPT('Datums:'),AT(8,102),USE(?VES:DATUMS:Prompt)
                           ENTRY(@D06.B),AT(64,102,41,10),USE(VES:DATUMS),CENTER(1)
                           BUTTON('Saturs/piezîmes'),AT(8,115,54,14),USE(?ButtonTEKSTI)
                           ENTRY(@s47),AT(64,116,184,10),USE(VES:SATURS),FONT('MS Sans Serif',,,,CHARSET:BALTIC),TIP('Labâ pele: mainît CASE')
                           ENTRY(@s47),AT(64,128,184,10),USE(VES:SATURS2),TIP('Labâ pele: mainît CASE')
                           ENTRY(@s47),AT(64,140,184,10),USE(VES:SATURS3),TIP('Labâ pele: mainît CASE')
                           PROMPT('Summa'),AT(8,157),USE(?VES:SUMMA:Prompt)
                           ENTRY(@n-15.2b),AT(64,157,43,10),USE(VES:SUMMA),DECIMAL(12)
                           ENTRY(@s3),AT(111,157,16,10),USE(VES:VAL)
                           PROMPT('t.s.atlaide:'),AT(8,169),USE(?VES:Atlaide:Prompt)
                           ENTRY(@n-5.1b),AT(64,169,23,10),USE(VES:Atlaide),DECIMAL(12)
                           STRING('%'),AT(88,170),USE(?String4)
                           PROMPT('231/531 konts'),AT(8,183),USE(?VES:D_K_KONTS:Prompt)
                           ENTRY(@s5),AT(64,183,31,10),USE(VES:D_K_KONTS)
                           PROMPT('Samaksâts:'),AT(8,197,48,10),USE(?VES:Samaksats:Prompt)
                           ENTRY(@n-15.2B),AT(64,197,43,10),USE(VES:Samaksats),DECIMAL(12)
                           ENTRY(@s3),AT(111,197,16,10),USE(VES:SAM_VAL)
                           PROMPT('Sam. datums:'),AT(8,211,54,10),USE(?VES:Sam_datums:Prompt)
                           ENTRY(@D06.B),AT(64,211,41,10),USE(VES:Sam_datums),CENTER
                         END
                       END
                       BUTTON('&OK'),AT(179,239,45,14),USE(?OK),DEFAULT
                       BUTTON('Atlikt'),AT(229,239,45,14),USE(?Cancel)
                       STRING(@d06.),AT(3,242),USE(VES:ACC_DATUMS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       STRING(@s8),AT(49,242),USE(VES:ACC_KODS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
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
  IF ATLAUTS[18]='1'  !AIZLIEGTI NEAPSTIPRINÂTIE
     HIDE(?Rakstastatuss)
     DISABLE(?Rakstastatuss)
  ELSE
     IF VES:RS
        UNHIDE(?IMAGERS)
     ELSE
        HIDE(?IMAGERS)
     .
  .
  IF VES:CRM
     VUT=GETPARAKSTI(5,1,VES:KAM) !VUT NO LOGINA(ves:kam)
     UNHIDE(?VES:KAM:Prompt)
     ENABLE(?VES:KAM)
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
      IF KEYCODE()=MouseRight
      !   STOP('ALERTTEST'&FOCUS()&CONTENTS(FOCUS()))
         CASE FOCUS()
         OF ?VES:SATURS
            UPDATE(?VES:SATURS)
            VES:SATURS=INIGEN(VES:SATURS,LEN(CLIP(VES:SATURS)),3)
         OF ?VES:SATURS2
            UPDATE(?VES:SATURS2)
            VES:SATURS2=INIGEN(VES:SATURS2,LEN(CLIP(VES:SATURS2)),3)
         OF ?VES:SATURS3
            UPDATE(?VES:SATURS3)
            VES:SATURS3=INIGEN(VES:SATURS3,LEN(CLIP(VES:SATURS3)),3)
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
      
      DO FORM::AssignButtons
      DO FLD5::FillList
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Rakstastatuss)
      CASE LOCALREQUEST
      OF 1
         SELECT(?VES:SATURS)
      OF 2
         SELECT(?VES:SATURS)
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
        History::VES:Record = VES:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(VESTURE)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
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
            IF SAV::VES:Record <> VES:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:VESTURE(1)
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
    OF ?Rakstastatuss
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF VES:RS
           VES:RS=''
           HIDE(?IMAGERS)
        ELSE
           VES:RS='1'
           UNHIDE(?IMAGERS)
        .
        display
      END
    OF ?VES:CRM
      CASE EVENT()
      OF EVENT:Accepted
        IF VES:CRM
           UNHIDE(?VES:KAM:Prompt)
           ENABLE(?VES:KAM)
        ELSE
           HIDE(?VES:KAM:Prompt)
           DISABLE(?VES:KAM)
        .
      END
    OF ?VES:KAM
      CASE EVENT()
      OF EVENT:Accepted
        FLD5::SEC:U_NR = VES:KAM
        GET(Queue:FileDropCombo,FLD5::SEC:U_NR)
        IF ERRORCODE() THEN
          SELECT(?VES:KAM)
        ELSE
          VES:KAM = FLD5::SEC:U_NR
        END
         VES:PROCESS=1
         VUT=GETPARAKSTI(5,1,VES:KAM) !VUT NO LOGINA(ves:kam)
         display
      END
    OF ?ButtonTEKSTI
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseTex 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           VES:SATURS=TEX:TEKSTS1
           VES:SATURS2=TEX:TEKSTS2
           VES:SATURS3=TEX:TEKSTS3
           VES:CRM=TEX:BAITS
        .
        DISPLAY
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        VES:ACC_KODS=ACC_kods
        VES:ACC_DATUMS=today()
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
  IF PAROLES::Used = 0
    CheckOpen(PAROLES,1)
  END
  PAROLES::Used += 1
  BIND(SEC:RECORD)
  IF TEKSTI::Used = 0
    CheckOpen(TEKSTI,1)
  END
  TEKSTI::Used += 1
  BIND(TEX:RECORD)
  IF VESTURE::Used = 0
    CheckOpen(VESTURE,1)
  END
  VESTURE::Used += 1
  BIND(VES:RECORD)
  FilesOpened = True
  RISnap:VESTURE
  SAV::VES:Record = VES:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    VES:DATUMS    =TODAY()
    VES:SECIBA    =CLOCK()
    VES:ACC_KODS  =ACC_kods
    VES:ACC_DATUMS=today()
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:VESTURE()
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
  INIRestoreWindow('UpdateVesture','winlats.INI')
  WinResize.Resize
  IF VES:SATURS[1:7]='PVN Dek'
     ?VES:Samaksats:Prompt{PROP:TEXT}='Precizçtâ:'
     ?VES:Sam_datums:Prompt{PROP:TEXT}='Prec.datums:'
     DISABLE(?VES:CRM:Prompt,?VES:SATURS3)
     DISABLE(?VES:Atlaide:Prompt,?VES:D_K_KONTS)
  .
  ?VES:CRM{PROP:Alrt,255} = 734
  ?VES:DOK_SENR{PROP:Alrt,255} = 734
  ?VES:KAM{PROP:Alrt,255} = 734
  ?VES:APMDAT:2{PROP:Alrt,255} = 734
  ?VES:DOKDAT{PROP:Alrt,255} = 734
  ?VES:SECIBA{PROP:Alrt,255} = 734
  ?VES:DATUMS{PROP:Alrt,255} = 734
  ?VES:SATURS{PROP:Alrt,255} = 734
  ?VES:SATURS2{PROP:Alrt,255} = 734
  ?VES:SATURS3{PROP:Alrt,255} = 734
  ?VES:SUMMA{PROP:Alrt,255} = 734
  ?VES:VAL{PROP:Alrt,255} = 734
  ?VES:Atlaide{PROP:Alrt,255} = 734
  ?VES:D_K_KONTS{PROP:Alrt,255} = 734
  ?VES:Samaksats{PROP:Alrt,255} = 734
  ?VES:SAM_VAL{PROP:Alrt,255} = 734
  ?VES:Sam_datums{PROP:Alrt,255} = 734
  ?VES:ACC_DATUMS{PROP:Alrt,255} = 734
  ?VES:ACC_KODS{PROP:Alrt,255} = 734
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
    PAROLES::Used -= 1
    IF PAROLES::Used = 0 THEN CLOSE(PAROLES).
    TEKSTI::Used -= 1
    IF TEKSTI::Used = 0 THEN CLOSE(TEKSTI).
    VESTURE::Used -= 1
    IF VESTURE::Used = 0 THEN CLOSE(VESTURE).
  END
  IF WindowOpened
    INISaveWindow('UpdateVesture','winlats.INI')
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
    OF ?VES:CRM
      VES:CRM = History::VES:Record.CRM
    OF ?VES:DOK_SENR
      VES:DOK_SENR = History::VES:Record.DOK_SENR
    OF ?VES:KAM
      VES:KAM = History::VES:Record.KAM
    OF ?VES:APMDAT:2
      VES:APMDAT = History::VES:Record.APMDAT
    OF ?VES:DOKDAT
      VES:DOKDAT = History::VES:Record.DOKDAT
    OF ?VES:SECIBA
      VES:SECIBA = History::VES:Record.SECIBA
    OF ?VES:DATUMS
      VES:DATUMS = History::VES:Record.DATUMS
    OF ?VES:SATURS
      VES:SATURS = History::VES:Record.SATURS
    OF ?VES:SATURS2
      VES:SATURS2 = History::VES:Record.SATURS2
    OF ?VES:SATURS3
      VES:SATURS3 = History::VES:Record.SATURS3
    OF ?VES:SUMMA
      VES:SUMMA = History::VES:Record.SUMMA
    OF ?VES:VAL
      VES:VAL = History::VES:Record.VAL
    OF ?VES:Atlaide
      VES:Atlaide = History::VES:Record.Atlaide
    OF ?VES:D_K_KONTS
      VES:D_K_KONTS = History::VES:Record.D_K_KONTS
    OF ?VES:Samaksats
      VES:Samaksats = History::VES:Record.Samaksats
    OF ?VES:SAM_VAL
      VES:SAM_VAL = History::VES:Record.SAM_VAL
    OF ?VES:Sam_datums
      VES:Sam_datums = History::VES:Record.Sam_datums
    OF ?VES:ACC_DATUMS
      VES:ACC_DATUMS = History::VES:Record.ACC_DATUMS
    OF ?VES:ACC_KODS
      VES:ACC_KODS = History::VES:Record.ACC_KODS
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
  VES:Record = SAV::VES:Record
  VES:DATUMS = SAV_datums
  SAV::VES:Record = VES:Record
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
  FLD5::SEC:U_NR = VES:KAM
  SET(PAROLES)
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
        StandardWarning(Warn:RecordFetchError,'PAROLES')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    FLD5::SEC:U_NR = SEC:U_NR
    FLD5::SEC:VUT = SEC:VUT
    ADD(Queue:FileDropCombo)
  END
  CLOSE(FLD5::View)
  IF RECORDS(Queue:FileDropCombo)
    SORT(Queue:FileDropCombo,FLD5::SEC:U_NR)
    IF VES:KAM
      LOOP FLD5::LoopIndex = 1 TO RECORDS(Queue:FileDropCombo)
        GET(Queue:FileDropCombo,FLD5::LoopIndex)
        IF VES:KAM = FLD5::SEC:U_NR THEN BREAK.
      END
      ?VES:KAM{Prop:Selected} = FLD5::LoopIndex
    END
  ELSE
    CLEAR(VES:KAM)
  END
    FLD5::SEC:U_NR = 0
    FLD5::SEC:VUT = 'visiem'
    ADD(Queue:FileDropCombo)

BrowseVesture PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
KOPA231              DECIMAL(7,2)
KOPA531              DECIMAL(7,2)
PAR_NOS_S            STRING(15)

BRW1::View:Browse    VIEW(VESTURE)
                       PROJECT(VES:DATUMS)
                       PROJECT(VES:RS)
                       PROJECT(VES:DOK_SENR)
                       PROJECT(VES:CRM)
                       PROJECT(VES:KAM)
                       PROJECT(VES:SATURS)
                       PROJECT(VES:APMDAT)
                       PROJECT(VES:D_K_KONTS)
                       PROJECT(VES:SUMMA)
                       PROJECT(VES:VAL)
                       PROJECT(VES:Samaksats)
                       PROJECT(VES:SAM_VAL)
                       PROJECT(VES:Sam_datums)
                       PROJECT(VES:SECIBA)
                       PROJECT(VES:PAR_NR)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::VES:DATUMS       LIKE(VES:DATUMS)           ! Queue Display field
BRW1::VES:RS           LIKE(VES:RS)               ! Queue Display field
BRW1::VES:DOK_SENR     LIKE(VES:DOK_SENR)         ! Queue Display field
BRW1::VES:CRM          LIKE(VES:CRM)              ! Queue Display field
BRW1::VES:KAM          LIKE(VES:KAM)              ! Queue Display field
BRW1::VES:SATURS       LIKE(VES:SATURS)           ! Queue Display field
BRW1::VES:APMDAT       LIKE(VES:APMDAT)           ! Queue Display field
BRW1::VES:D_K_KONTS    LIKE(VES:D_K_KONTS)        ! Queue Display field
BRW1::VES:SUMMA        LIKE(VES:SUMMA)            ! Queue Display field
BRW1::VES:VAL          LIKE(VES:VAL)              ! Queue Display field
BRW1::VES:Samaksats    LIKE(VES:Samaksats)        ! Queue Display field
BRW1::VES:SAM_VAL      LIKE(VES:SAM_VAL)          ! Queue Display field
BRW1::VES:Sam_datums   LIKE(VES:Sam_datums)       ! Queue Display field
BRW1::VES:SECIBA       LIKE(VES:SECIBA)           ! Queue Display field
BRW1::VES:PAR_NR       LIKE(VES:PAR_NR)           ! Queue Display field
BRW1::PAR_NR           LIKE(PAR_NR)               ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(VES:DATUMS),DIM(100)
BRW1::Sort1:LowValue LIKE(VES:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(VES:DATUMS)            ! Queue position of scroll thumb
BRW1::Sort1:Reset:PAR_NR LIKE(PAR_NR)
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
QuickWindow          WINDOW('VESTURE.tps'),AT(-1,-1,453,264),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseVesture'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(1,2,451,260),USE(?CurrentTab)
                         TAB('Norçíini un piezîmes'),USE(?Tab:2)
                           LIST,AT(3,20,446,217),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('45R(2)|M~Datums~C(0)@D06.B@10C|M~Y~@s1@56R(1)|M~Dok. Nr.~C(0)@s14@12C|M~H~@n3b@1' &|
   '8C|M~KAM~@n_3b@171L(2)|M~Saturs~C(0)@s47@44R(2)|M~ApmLîdz~C(0)@D06.B@24R(2)|M~BK' &|
   'K~C(0)@s5@38D(12)|M~Summa~C(0)@n-15.2B@14C|M~Val.~@s3@37D(12)|M~Samaksâts~C(0)@n' &|
   '-15.2B@12C|M~Val.~@s3@40L(1)|M~Apm.datums~C(0)@D06.B@20C|M~Secîba~@T1@'),FROM(Queue:Browse:1)
                           BUTTON('I&zdruka'),AT(7,243,45,14),USE(?Button5)
                           STRING('231..'),AT(241,240,117,10),USE(?StringKOPA231),RIGHT
                           STRING(@n-10.2),AT(359,240),USE(KOPA231 )
                           STRING('531..'),AT(284,249,73,10),USE(?StringKOPA531),RIGHT
                           STRING(@n-10.2),AT(359,249),USE(KOPA531)
                         END
                       END
                       BUTTON('&Ievadît'),AT(94,243,45,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(142,243,45,14),USE(?Change:2),DEFAULT
                       BUTTON('&Dzçst'),AT(189,243,45,14),USE(?Delete:2)
                       BUTTON('&Beigt'),AT(403,243,45,14),USE(?Close)
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
  ACCEPT
    !QUICKWINDOW{PROP:TEXT}='Vçsture: '&CLIP(PAR:NOS_P)
    !IF VES:SATURS[1:7]='PVN Dek'
    !   ?Browse:1{PROPLIST:HEADER,10}='Precizçtâ'
    !   ?Browse:1{PROPLIST:HEADER,12}='Prec.dat.'
    !   ?StringKOPA531{PROP:TEXT}='pçc precizçðanas'
    !   ?StringKOPA231{PROP:TEXT}='sâkotnçjâs PVN d'
    !.
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
      QUICKWINDOW{PROP:TEXT}='Vçsture: '&CLIP(PAR:NOS_P)
      IF VES:SATURS[1:7]='PVN Dek'
         ?Browse:1{PROPLIST:HEADER,4}=''
         ?Browse:1{PROPLIST:HEADER,5}=''
         ?Browse:1{PROPLIST:HEADER,7}=''
         ?Browse:1{PROPLIST:HEADER,8}=''
         ?Browse:1{PROPLIST:HEADER,9}='Sâkotnçjâ'
         ?Browse:1{PROPLIST:HEADER,11}='Precizçtâ'
         ?Browse:1{PROPLIST:HEADER,13}='Prec.dat.'
         ?StringKOPA531{PROP:TEXT}='pçc precizçðanas'
         ?StringKOPA231{PROP:TEXT}='Sâkotnçjâs PVND '&FORMAT(DB_S_DAT,@D06.)&'-'&FORMAT(DB_B_DAT,@D06.)
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
    END
    CASE FIELD()
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
    OF ?Button5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !!IZZFILTB('01101000000')
        !!IF GlobalResponse = RequestCompleted
            START(F_PrintVesture,50000)
        !!END
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
  IF VESTURE::Used = 0
    CheckOpen(VESTURE,1)
  END
  VESTURE::Used += 1
  BIND(VES:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseVesture','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('PAR_NR',PAR_NR)
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
    VESTURE::Used -= 1
    IF VESTURE::Used = 0 THEN CLOSE(VESTURE).
  END
  IF WindowOpened
    INISaveWindow('BrowseVesture','winlats.INI')
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
  SETCURSOR(Cursor:Wait)
  DO BRW1::Reset
  KOPA231=0
  KOPA531=0
  LOOP
    NEXT(BRW1::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'VESTURE')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW1::FillQueue
    IF VES:SATURS[1:7]='PVN Dek' AND INRANGE(VES:DATUMS,DB_S_DAT,DB_B_DAT)
       KOPA231+=VES:SUMMA
       IF VES:SAMAKSATS
          KOPA531+=VES:SAMAKSATS !precizçtâs PVN dekl.
       ELSE
          KOPA531+=VES:SUMMA !sâkotnçjâs+precizçtâs PVN dekl.
       .
    ELSE
       IF VES:D_K_KONTS[1:3]='231'
          KOPA231+=VES:SAMAKSATS
       ELSE
          KOPA531+=VES:SAMAKSATS
       .
    .
  END
  SETCURSOR()
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'VESTURE')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = VES:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'VESTURE')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = VES:DATUMS
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
  VES:DATUMS = BRW1::VES:DATUMS
  VES:RS = BRW1::VES:RS
  VES:DOK_SENR = BRW1::VES:DOK_SENR
  VES:CRM = BRW1::VES:CRM
  VES:KAM = BRW1::VES:KAM
  VES:SATURS = BRW1::VES:SATURS
  VES:APMDAT = BRW1::VES:APMDAT
  VES:D_K_KONTS = BRW1::VES:D_K_KONTS
  VES:SUMMA = BRW1::VES:SUMMA
  VES:VAL = BRW1::VES:VAL
  VES:Samaksats = BRW1::VES:Samaksats
  VES:SAM_VAL = BRW1::VES:SAM_VAL
  VES:Sam_datums = BRW1::VES:Sam_datums
  VES:SECIBA = BRW1::VES:SECIBA
  VES:PAR_NR = BRW1::VES:PAR_NR
  PAR_NR = BRW1::PAR_NR
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
  BRW1::VES:DATUMS = VES:DATUMS
  BRW1::VES:RS = VES:RS
  BRW1::VES:DOK_SENR = VES:DOK_SENR
  BRW1::VES:CRM = VES:CRM
  BRW1::VES:KAM = VES:KAM
  BRW1::VES:SATURS = VES:SATURS
  BRW1::VES:APMDAT = VES:APMDAT
  BRW1::VES:D_K_KONTS = VES:D_K_KONTS
  BRW1::VES:SUMMA = VES:SUMMA
  BRW1::VES:VAL = VES:VAL
  BRW1::VES:Samaksats = VES:Samaksats
  BRW1::VES:SAM_VAL = VES:SAM_VAL
  BRW1::VES:Sam_datums = VES:Sam_datums
  BRW1::VES:SECIBA = VES:SECIBA
  BRW1::VES:PAR_NR = VES:PAR_NR
  BRW1::PAR_NR = PAR_NR
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => VES:DATUMS
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
      VES:DATUMS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'VESTURE')
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
      BRW1::HighlightedPosition = POSITION(VES:DAT_KEY)
      RESET(VES:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      VES:PAR_NR = PAR_NR
      SET(VES:DAT_KEY,VES:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'VES:PAR_NR = PAR_NR'
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
    CLEAR(VES:Record)
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
    VES:PAR_NR = PAR_NR
    SET(VES:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'VES:PAR_NR = PAR_NR'
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
  GET(VESTURE,0)
  CLEAR(VES:Record,0)
  CASE BRW1::SortOrder
  OF 1
    VES:PAR_NR = BRW1::Sort1:Reset:PAR_NR
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
!| (UpdateVesture) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateVesture
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
        GET(VESTURE,0)
        CLEAR(VES:Record,0)
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


UpdateGRUPA2 PROCEDURE


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
SAV_PROC  LIKE(GR2:PROC)
NOM_PROC5 LIKE(NOM:PROC5)

Update::Reloop  BYTE
Update::Error   BYTE
History::GR2:Record LIKE(GR2:Record),STATIC
SAV::GR2:Record      LIKE(GR2:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Nomenklatûras apakðgrupa (grupa2.tps)'),AT(,,276,105),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateGRUPA2'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(4,4,268,75),USE(?CurrentTab)
                         TAB('Apakðgrupas'),USE(?Tab:1)
                           PROMPT('&Grupa:'),AT(8,22,42,10),USE(?Prompt3)
                           STRING(@S3),AT(51,22),USE(GR2:GRUPA1),LEFT
                           PROMPT('A&pakðgrupa:'),AT(8,35,42,10),USE(?GR2:GRUPA2:Prompt)
                           ENTRY(@s1),AT(51,35,13,10),USE(GR2:GRUPA2),UPR
                           PROMPT('&Nosaukums:'),AT(8,48,42,10),USE(?GR2:NOSAUKUMS:Prompt)
                           ENTRY(@S50),AT(51,48,204,10),USE(GR2:NOSAUKUMS)
                           PROMPT('&Uzcenojuma % 5. cenai:'),AT(9,63),USE(?GR2:PROC:Prompt)
                           ENTRY(@n-4.0),AT(91,61,18,10),USE(GR2:PROC)
                           STRING('%'),AT(111,61),USE(?String2)
                         END
                       END
                       BUTTON('&OK'),AT(178,85,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(226,85,45,14),USE(?Cancel)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SAV_PROC=GR2:PROC
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
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
      SELECT(?Prompt3)
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
        History::GR2:Record = GR2:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(GRUPA2)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(GR2:GR1_KEY)
              IF StandardWarning(Warn:DuplicateKey,'GR2:GR1_KEY')
                SELECT(?Prompt3)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?Prompt3)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::GR2:Record <> GR2:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:GRUPA2(1)
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
              SELECT(?Prompt3)
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
    OF ?GR2:GRUPA2
      CASE EVENT()
      OF EVENT:Accepted
        IF LOCALREQUEST=1
           GR2:GRUPA2=INIGEN(GR2:GRUPA2,1,1)
           GR2:GRUPA2=UPPER(GR2:GRUPA2)
           IF DUPLICATE(GR2:GR1_KEY)
              KLUDA(0,'Veidojas dubultas atslçgas ar ðo grupu+apakðgrupu...')
              SELECT(?GR2:GRUPA2)
           .
           IF INSTRING(GR2:GRUPA2,' ,;:*"/()',1)  !' .,;:*"/()',1)
              IF GR2:GRUPA2=' '
                 KLUDA(0,'Apakðgrupâ neatïauts TUKÐUMS')
              ELSE
                 KLUDA(0,'Apakðrupai neatïauts simbols '&GR2:GRUPA2)
              .
              SELECT(?GR2:GRUPA2)
           .
           DISPLAY
        .
      END
    OF ?GR2:PROC
      CASE EVENT()
      OF EVENT:Accepted
        IF ~(SAV_PROC=GR2:PROC)
           KLUDA(51,'Uzsenojuma % 5 cenai no '&clip(SAV_PROC)&' uz '&CLIP(GR2:PROC))
           IF KLU_DARBIBA
              CLEAR(NOM:RECORD)
              NOM:NOMENKLAT[1:3]=GR2:GRUPA1
              NOM:NOMENKLAT[4]=GR2:GRUPA2
              SET(NOM:NOM_KEY,NOM:NOM_KEY)
              LOOP
                 NEXT(NOM_K)
                 IF ERROR() OR ~(NOM:NOMENKLAT[1:4]=GR2:GRUPA1&GR2:GRUPA2) THEN BREAK.
                 NOM_PROC5=NOM:PROC5
                 NOM:PROC5=GR2:PROC
                 NOM:REALIZ[5]=NOM:REALIZ[5]/(1+NOM_PROC5/100)*(1+NOM:PROC5/100)
                 IF RIUPDATE:NOM_K()
                    KLUDA(24,'NOM_K')
                 .
              .
              SAV_PROC=GR2:PROC
           .
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
  IF GRUPA2::Used = 0
    CheckOpen(GRUPA2,1)
  END
  GRUPA2::Used += 1
  BIND(GR2:RECORD)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  FilesOpened = True
  RISnap:GRUPA2
  SAV::GR2:Record = GR2:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    !GR2:GRUPA1=GR1:GRUPA1
    GR2:PROC=GR1:PROC
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:GRUPA2()
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
  IF WindowPosInit THEN
    SETPOSITION(0,WindowXPos,WindowYPos)
  ELSE
    GETPOSITION(0,WindowXPos,WindowYPos)
    WindowPosInit=True
  END
  ?GR2:GRUPA1{PROP:Alrt,255} = 734
  ?GR2:GRUPA2{PROP:Alrt,255} = 734
  ?GR2:NOSAUKUMS{PROP:Alrt,255} = 734
  ?GR2:PROC{PROP:Alrt,255} = 734
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
    GRUPA2::Used -= 1
    IF GRUPA2::Used = 0 THEN CLOSE(GRUPA2).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
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
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?GR2:GRUPA1
      GR2:GRUPA1 = History::GR2:Record.GRUPA1
    OF ?GR2:GRUPA2
      GR2:GRUPA2 = History::GR2:Record.GRUPA2
    OF ?GR2:NOSAUKUMS
      GR2:NOSAUKUMS = History::GR2:Record.NOSAUKUMS
    OF ?GR2:PROC
      GR2:PROC = History::GR2:Record.PROC
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
  GR2:Record = SAV::GR2:Record
  SAV::GR2:Record = GR2:Record
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

