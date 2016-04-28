                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_IzzDAIEV           PROCEDURE                    ! Declare Procedure
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
dat                  DATE
lai                  TIME
Process:View         VIEW(DAIEV)
                       PROJECT(DAI:ALGA)
                       PROJECT(DAI:ARG_NOS)
                       PROJECT(DAI:DKK)
                       PROJECT(DAI:F)
                       PROJECT(DAI:KKK)
                       PROJECT(DAI:KODS)
                       PROJECT(DAI:NOSAUKUMS)
                       PROJECT(DAI:PROC)
                       PROJECT(DAI:TARL)
                     END

report REPORT,AT(104,1219,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,250,8000,969)
         STRING(@s45),AT(906,52,6000,219),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('DARBA APMAKSAS UN IETURÇJUMU VEIDI'),AT(906,365,6000,219),USE(?String33),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7344,500,573,156),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(52,677,7865,0),USE(?Line18),COLOR(COLOR:Black)
         STRING('Kods'),AT(104,729,,208),USE(?String5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(469,729,1771,208),USE(?String6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('F'),AT(2292,729,260,208),USE(?String7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2552,677,0,313),USE(?Line19:2),COLOR(COLOR:Black)
         STRING('Arg/nos.'),AT(2604,729,677,208),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3281,677,0,313),USE(?Line19:3),COLOR(COLOR:Black)
         STRING('Tar./likme'),AT(3333,729,625,208),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3958,677,0,313),USE(?Line19:4),COLOR(COLOR:Black)
         STRING('Alga'),AT(4010,729,573,208),USE(?String13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4583,677,0,313),USE(?Line19:5),COLOR(COLOR:Black)
         STRING('%'),AT(4635,729,417,208),USE(?String15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saistoðie darba apmaksas veidi'),AT(5104,729,2083,208),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Deb. Kred.'),AT(7240,729,677,208),USE(?String20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,938,7865,0),USE(?Line11),COLOR(COLOR:Black)
         LINE,AT(7188,677,0,313),USE(?Line9),COLOR(COLOR:Black)
         LINE,AT(7917,677,0,313),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(5052,677,0,313),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(2240,677,0,313),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(417,677,0,313),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(52,677,0,313),USE(?Line16),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,198),COLOR(COLOR:Black)
         STRING(@n4.1b),AT(4688,10,260,156),USE(DAI:PROC),RIGHT(8)
         STRING(@n_9.2b),AT(3990,10,570,156),USE(DAI:ALGA),RIGHT(12)
         LINE,AT(4583,-10,0,198),USE(?Line27:4),COLOR(COLOR:Black)
         STRING(@n_10.4b),AT(3333,10,625,156),USE(DAI:TARL),RIGHT(20)
         STRING(@s10),AT(2604,10,,156),USE(DAI:ARG_NOS),LEFT
         LINE,AT(3281,-10,0,198),USE(?Line27:2),COLOR(COLOR:Black)
         STRING(@s4),AT(2292,10,260,156),USE(DAI:F),LEFT
         STRING(@n3b),AT(5104,10,208,156),USE(DAI:F_DAIEREZ[1]),RIGHT(1)
         STRING(@n3b),AT(5313,10,208,156),USE(DAI:F_DAIEREZ[2]),RIGHT(1)
         STRING(@n3b),AT(5521,10,208,156),USE(DAI:F_DAIEREZ[3]),RIGHT(1)
         STRING(@n3b),AT(5729,10,208,156),USE(DAI:F_DAIEREZ[4]),RIGHT(1)
         STRING(@n3b),AT(5938,10,208,156),USE(DAI:F_DAIEREZ[5]),RIGHT(1)
         STRING(@n3b),AT(6146,10,208,156),USE(DAI:F_DAIEREZ[6]),RIGHT(1)
         STRING(@n3b),AT(6354,10,208,156),USE(DAI:F_DAIEREZ[7]),RIGHT(1)
         STRING(@n3b),AT(6563,10,208,156),USE(DAI:F_DAIEREZ[8]),RIGHT(1)
         STRING(@n3b),AT(6771,10,208,156),USE(DAI:F_DAIEREZ[9]),RIGHT(1)
         STRING(@n3b),AT(6979,10,208,156),USE(DAI:F_DAIEREZ[10]),RIGHT(1)
         STRING(@s5),AT(7240,10,313,156),USE(DAI:DKK),RIGHT
         STRING(@s5),AT(7604,10,313,156),USE(DAI:KKK),RIGHT
         LINE,AT(3958,-10,0,198),USE(?Line27:3),COLOR(COLOR:Black)
         LINE,AT(2552,-10,0,198),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,198),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,198),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(2240,-10,0,198),COLOR(COLOR:Black)
         STRING(@s35),AT(469,10,1771,156),USE(DAI:NOSAUKUMS),LEFT
         STRING(@n3),AT(104,10,208,156),USE(DAI:KODS),RIGHT(1)
       END
RptFoot DETAIL,AT(,,,229),USE(?unnamed)
         LINE,AT(52,-10,0,63),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(2240,-10,0,63),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(2552,-10,0,63),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(3281,-10,0,63),USE(?Line22:3),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,63),USE(?Line22:4),COLOR(COLOR:Black)
         LINE,AT(4583,-10,0,63),USE(?Line22:5),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,63),USE(?Line22:6),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,63),USE(?Line22:7),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,63),USE(?Line22:8),COLOR(COLOR:Black)
         LINE,AT(52,52,7865,0),USE(?Line26),COLOR(COLOR:Black)
         STRING(@d06.),AT(6792,83,625,156),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7427,83,490,156),USE(lai),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(104,10900,8000,52),USE(?unnamed:2)
         LINE,AT(52,0,7865,0),USE(?Line26:2),COLOR(COLOR:Black)
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
  DAT=TODAY()
  LAI=CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF DAIEV::Used = 0
    CheckOpen(DAIEV,1)
  END
  DAIEV::Used += 1
  BIND(DAI:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(DAIEV)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Izziòa par DAIEV'
  ?Progress:UserString{Prop:Text}=''
  SEND(DAIEV,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(DAI:KOD_KEY)
      Process:View{Prop:Filter} = ''
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
  IF SEND(DAIEV,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    CLOSE(ProgressWindow)
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPTFOOT)
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
    ELSE
       ANSIJOB
    .
  .
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE           !RTF,EXCEL
     CLOSE(OUTFILEANSI)
     ANSIFILENAME=''
  .
  DO ProcedureReturn

!-----------------------------------------------------------------------------
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
    DAIEV::Used -= 1
    IF DAIEV::Used = 0 THEN CLOSE(DAIEV).
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

!-----------------------------------------------------------------------------
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
      StandardWarning(Warn:RecordFetchError,'DAIEV')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
UpdateALPA PROCEDURE


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
DELETETEXT           STRING(100)
MINA                 STRING(47)
MINS                 STRING(47)
NESPEL               STRING(50)
Update::Reloop  BYTE
Update::Error   BYTE
History::ALP:Record LIKE(ALP:Record),STATIC
SAV::ALP:Record      LIKE(ALP:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the ALGPA File'),AT(,,305,210),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateALPA'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(2,4,302,188),USE(?CurrentTab)
                         TAB('Sâkuma nosacîjumi'),USE(?Tab:1)
                           PROMPT('&Neapliekamais minimums:'),AT(19,26),USE(?ALP:MIA:Prompt)
                           ENTRY(@n6.2),AT(146,26,40,10),USE(ALP:MIA),MSG('neapliekamais min.')
                           PROMPT('&Pamatlikmes %:'),AT(19,39),USE(?ALP:PR_PAM:Prompt)
                           ENTRY(@n2),AT(146,39,40,10),USE(ALP:PR_PAM)
                           PROMPT('Papil&dlikmes %:'),AT(19,52),USE(?ALP:PR_PAP:Prompt)
                           ENTRY(@n2),AT(146,52,40,10),USE(ALP:PR_PAP)
                           PROMPT('At&vieglojums par katro apgâdâjamo:'),AT(19,65),USE(?ALP:APGADSUM:Prompt)
                           ENTRY(@n6.2),AT(146,65,40,10),USE(ALP:APGADSUM)
                           PROMPT('Atvieglojums 1. &gr. inv.:'),AT(19,78,86,10),USE(?ALP:AT_INV1:Prompt)
                           ENTRY(@n6.2),AT(146,78,40,10),USE(ALP:AT_INV1)
                           PROMPT('Atvieglojums 2. gr. &inv.:'),AT(19,91,86,10),USE(?ALP:AT_INV2:Prompt)
                           ENTRY(@n-7.2),AT(146,91,40,10),USE(ALP:AT_INV2)
                           PROMPT('Atvieglo&jums 3. gr. inv.:'),AT(19,104,86,10),USE(?ALP:AT_INV3:Prompt)
                           ENTRY(@n6.2),AT(146,104,40,10),USE(ALP:AT_INV3)
                           PROMPT('Atvieg&lojums politiski repr. pers.:'),AT(19,117,124,10),USE(?ALP:AT_POLR:Prompt)
                           ENTRY(@n6.2),AT(146,117,40,10),USE(ALP:AT_POLR)
                           PROMPT('Atv. P&RP, kas nesaòem pensiju:'),AT(19,130,115,10),USE(?ALP:AT_POLRNP:Prompt)
                           ENTRY(@n6.2),AT(146,130,40,10),USE(ALP:AT_POLRNP)
                           PROMPT('&Minimâlâ alga:'),AT(19,143,93,10),USE(?ALP:MINA:Prompt)
                           ENTRY(@n-9.2),AT(146,141,40,10),USE(ALP:MINA),MSG('min Alga'),TIP('min Alga')
                           PROMPT('Minimâlâ stundas likme:'),AT(19,154),USE(?ALP:MINS:Prompt)
                           ENTRY(@n-7.3),AT(146,152,40,10),USE(ALP:MINS),MSG('min Stundas l.'),TIP('min Stundas l.')
                           STRING(@s100),AT(19,174,275,10),USE(DELETETEXT),FONT(,,COLOR:Red,,CHARSET:ANSI)
                           STRING(@s50),AT(19,164,201,10),USE(NESPEL)
                         END
                       END
                       BUTTON('&OK'),AT(215,195,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(263,195,45,14),USE(?Cancel)
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
    ActionMessage='Aplûkoðanas reþîms'
    IF ALP:YYYYMM < DATE(1,1,2009)
       HIDE(?ALP:MINA)          !'Minimâlâ mçneðalga
       HIDE(?ALP:MINS)          !'Minimâlâ stundas likme
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
  CASE LocalRequest
  OF ChangeRecord OROF DeleteRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (' & CLIP(FORMAT(ALP:YYYYMM,@D014.B)) & ')'
  OF InsertRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (New)'
  END
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
      SELECT(?ALP:MIA:Prompt)
      IF ALP:STAT=3
         NESPEL='Nesadalîtâ peïòa = '&ALP:PARSKAITIT
      .
      IF LOCALREQUEST=2
      !   SELECT(?Browse:2)
      ELSIF LOCALREQUEST=1
      !   SELECT(?GG:DOK_SENR)
      ELSIF LOCALREQUEST=3
         quickwindow{prop:color}=color:activeborder
         disable(?ALP:MIA:Prompt,?ALP:AT_POLRNP)
         IF ALP:STAT=3   !DIVIDENDES
            DELETETEXT='...tiks dzçsts Dividenþu saraksts '&FORMAT(ALP:YYYYMM,@D05.)&' (visi darbinieki)'
         ELSE
            DELETETEXT='...tiks dzçsts Algu saraksts par '&FORMAT(ALP:YYYYMM,@D014.)&' (visi darbinieki)'
         .
         SELECT(?cancel)
      ELSE
         quickwindow{prop:color}=color:activeborder
         disable(?ALP:MIA:Prompt,?OK)
      !   enable(?Tab:3)
      !   ENable(?cancel)
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
        History::ALP:Record = ALP:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(ALGPA)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?ALP:MIA:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::ALP:Record <> ALP:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:ALGPA(1)
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
              SELECT(?ALP:MIA:Prompt)
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
            IF RIDelete:ALGPA()
              SETCURSOR()
              CASE StandardWarning(Warn:DeleteError)
              OF Button:Yes
                CYCLE
              OF Button:No
                POST(Event:CloseWindow)
                BREAK
              OF Button:Cancel
                DISPLAY
                SELECT(?ALP:MIA:Prompt)
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
  IF ALGPA::Used = 0
    CheckOpen(ALGPA,1)
  END
  ALGPA::Used += 1
  BIND(ALP:RECORD)
  FilesOpened = True
  RISnap:ALGPA
  SAV::ALP:Record = ALP:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('UpdateALPA','winlats.INI')
  WinResize.Resize
  ?ALP:MIA{PROP:Alrt,255} = 734
  ?ALP:PR_PAM{PROP:Alrt,255} = 734
  ?ALP:PR_PAP{PROP:Alrt,255} = 734
  ?ALP:APGADSUM{PROP:Alrt,255} = 734
  ?ALP:AT_INV1{PROP:Alrt,255} = 734
  ?ALP:AT_INV2{PROP:Alrt,255} = 734
  ?ALP:AT_INV3{PROP:Alrt,255} = 734
  ?ALP:AT_POLR{PROP:Alrt,255} = 734
  ?ALP:AT_POLRNP{PROP:Alrt,255} = 734
  ?ALP:MINA{PROP:Alrt,255} = 734
  ?ALP:MINS{PROP:Alrt,255} = 734
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
    ALGPA::Used -= 1
    IF ALGPA::Used = 0 THEN CLOSE(ALGPA).
  END
  IF WindowOpened
    INISaveWindow('UpdateALPA','winlats.INI')
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
    OF ?ALP:MIA
      ALP:MIA = History::ALP:Record.MIA
    OF ?ALP:PR_PAM
      ALP:PR_PAM = History::ALP:Record.PR_PAM
    OF ?ALP:PR_PAP
      ALP:PR_PAP = History::ALP:Record.PR_PAP
    OF ?ALP:APGADSUM
      ALP:APGADSUM = History::ALP:Record.APGADSUM
    OF ?ALP:AT_INV1
      ALP:AT_INV1 = History::ALP:Record.AT_INV1
    OF ?ALP:AT_INV2
      ALP:AT_INV2 = History::ALP:Record.AT_INV2
    OF ?ALP:AT_INV3
      ALP:AT_INV3 = History::ALP:Record.AT_INV3
    OF ?ALP:AT_POLR
      ALP:AT_POLR = History::ALP:Record.AT_POLR
    OF ?ALP:AT_POLRNP
      ALP:AT_POLRNP = History::ALP:Record.AT_POLRNP
    OF ?ALP:MINA
      ALP:MINA = History::ALP:Record.MINA
    OF ?ALP:MINS
      ALP:MINS = History::ALP:Record.MINS
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
  ALP:Record = SAV::ALP:Record
  SAV::ALP:Record = ALP:Record
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

A_SarakstsM          PROCEDURE                    ! Declare Procedure
!------------------------------------------------------------------------
NODALA               STRING(2)     ! Tekoðais sektors
SAV_NODALA           STRING(2)
nrsektori            SHORT            ! Izdrukâtais cilv. skaits. tek. sektorâ.
vajag_head           BYTE
KOPA_IZMAKSAT        DECIMAL(12,2)
SUMMA_VARDIEM        DECIMAL(12,2)
YYMM                 STRING(6)
RPT_GADS             DECIMAL(4)
GADS0                DECIMAL(4)
NUMURS               DECIMAL(3)
IZMAKS               DECIMAL(9,2)
PARADS               STRING(6)
SEIZMAKS             DECIMAL(9,2)
SEPARADS             DECIMAL(10,2)
SUMMA_V1             STRING(56)
SUMMA_V2             STRING(56)
VUT                  STRING(35)
MENESIS              STRING(10)

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
Process:View         VIEW(ALGAS)
                       PROJECT(ALG:APGAD_SK)
                       PROJECT(ALG:ID)
                       PROJECT(ALG:INI)
                       PROJECT(ALG:INV_P)
                       PROJECT(ALG:IZMAKSAT)
                       PROJECT(ALG:LBER)
                       PROJECT(ALG:LINV)
                       PROJECT(ALG:LMIA)
                       PROJECT(ALG:N_STUNDAS)
                       PROJECT(ALG:PR1)
                       PROJECT(ALG:PR37)
                       PROJECT(ALG:NODALA)
                       PROJECT(ALG:STATUSS)
                       PROJECT(ALG:YYYYMM)
                     END
!---------------------------------------------------------------------------

!report REPORT,AT(146,1680,8021,9396),PAPER(9),PRE(RPT),FONT('Arial Baltic',10,,),THOUS
!       HEADER,AT(146,104,8000,1552)


report REPORT,AT(150,1877,8000,9302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
       HEADER,AT(150,200,8000,1656)
         STRING(@P<<<#. lapaP),AT(7083,1198),PAGENO,USE(?PageCount)
         STRING(@s45),AT(2031,52,3906,260),USE(client),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Kases izdevumu orderis Nr'),AT(990,365,1823,208),USE(?String1),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Vadîtâjs :'),AT(4427,365,677,208),USE(?String3:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2813,521,833,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(5104,521,2188,0),USE(?Line23),COLOR(COLOR:Black)
         STRING(@n4),AT(990,573),USE(RPT_gads),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada "___"_{24}'),AT(1406,573,2969,208),USE(?String3),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Galvenais grâmatvedis :'),AT(4427,573,1667,208),USE(?String3:3),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6094,729,1198,0),USE(?Line23:2),COLOR(COLOR:Black)
         STRING('Kasei samaksât termiòâ no ____g._{12} lîdz ____g._{12}'),AT(1458,833,4844,208),USE(?String1:2), |
             LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Algu saraksts Nr _____'),AT(1719,1094,1927,260),USE(?String1:3),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@n4),AT(3750,1094),USE(gads0),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(4219,1094,521,260),USE(?String1:4),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(4792,1094,1094,260),USE(menesis),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,1406,0,260),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(729,1406,0,260),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(4167,1406,0,260),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(6302,1406,0,260),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(7656,1406,0,260),USE(?Line3:26),COLOR(COLOR:Black)
         STRING('Nr'),AT(417,1458,260,208),USE(?String12),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds, Uzvârds'),AT(781,1458,3385,208),USE(?String12:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Izmaksât / parâds'),AT(4219,1458,2083,208),USE(?String12:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Paraksts'),AT(6354,1458,1302,208),USE(?String12:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,1667,7292,0),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(365,1406,7292,0),USE(?Line2),COLOR(COLOR:Black)
       END
GRP_HEAD1 DETAIL,AT(,,,208)
         STRING(@S2),AT(1135,0,208,156),USE(alg:NODALA),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4167,-10,0,228),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,228),USE(?Line241),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,228),USE(?Line24:2),COLOR(COLOR:Black)
         STRING('nodaïa'),AT(1396,0,521,156),USE(?String12:5),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,156,7292,0),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,228),USE(?Line242),COLOR(COLOR:Black)
         LINE,AT(729,-10,0,228),USE(?Line243),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,208)
         LINE,AT(365,-10,0,228),USE(?Line3:9),COLOR(COLOR:Black)
         STRING(@s6),AT(6771,10,677,156),USE(parads),LEFT 
         LINE,AT(7656,-10,0,228),USE(?Line3:27),COLOR(COLOR:Black)
         LINE,AT(365,208,7292,0),USE(?Line33:3),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,228),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,228),USE(?Line3:6),COLOR(COLOR:Black)
         STRING(@n-_10.2b),AT(4792,10,885,156),USE(IZMAKS),RIGHT 
         STRING(@s35),AT(938,10,2344,156),USE(VUT),LEFT 
         LINE,AT(729,-10,0,228),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@n3),AT(417,10,,156),USE(numurs),RIGHT 
       END
GRP_FOOT DETAIL,AT(,,,1885)
         LINE,AT(4167,-10,0,218),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(729,-10,0,218),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,218),USE(?Line3:10),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(6458,10,833,156),USE(SEparads),RIGHT 
         LINE,AT(7656,-10,0,218),USE(?Line3:42),COLOR(COLOR:Black)
         STRING('Kopâ pa sektoru :'),AT(990,10,1198,156),USE(?String12:6),LEFT 
         LINE,AT(365,208,7292,0),USE(?Line33),COLOR(COLOR:Black)
         STRING('Summa :'),AT(521,260,573,208),USE(?String12:7),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s56),AT(1094,260,4167,208),USE(SUMMA_V1),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s56),AT(1094,469,4167,208),USE(SUMMA_V2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pçc esoðâ algu saraksta izmaksâts :_{45}' &|
             '_{75}'),AT(521,729,7083,208),USE(?String12:8),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Kasieris :_{22}'),AT(521,1458,2344,208),USE(?String12:10),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(3490,1458,1979,208),USE(sys:amats2),RIGHT(1)
         STRING('Deponçts :_{70}' &|
             '_{31}'),AT(521,990,7083,208),USE(?String12:9),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('_{22}'),AT(5521,1458,1719,208),USE(?String12:11),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(927,1667,1979,156),USE(sys:paraksts3),CENTER
         STRING(@s25),AT(5313,1667,2135,208),USE(sys:paraksts2),CENTER
         LINE,AT(6302,-10,0,218),USE(?Line3:40),COLOR(COLOR:Black)
         STRING(@n-_10.2b),AT(4792,10,885,156),USE(SEIZMAKS),RIGHT 
       END
       FOOTER,AT(100,9000,8000,52)
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
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  BIND(ALP:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(ALGAS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Mazais algu saraksts'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      ALG:YYYYMM=ALP:YYYYMM
      ALG:NODALA=F:NODALA
      SET(ALG:NOD_KEY,ALG:NOD_KEY)
      Process:View{Prop:Filter} = 'ALG:YYYYMM=ALP:YYYYMM AND ~(F:NODALA AND ~(ALG:NODALA=F:NODALA)) AND ~(ID AND ~(ALG:ID=ID))'
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
      SAV_NODALA = ALG:NODALA
      RPT_GADS=YEAR(ALP:YYYYMM)
      GADS0=YEAR(ALP:YYYYMM)
      MENESIS=MENVAR(ALP:YYYYMM,2,2)
      OPEN(report)
      report{Prop:Preview} = PrintPreviewImage
!!      PRINT(RPT:grp_head0)
      PRINT(RPT:grp_head1)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~(SAV_NODALA = ALG:NODALA)
          PRINT(RPT:grp_head1)
          SAV_NODALA = ALG:NODALA
        .
        izmaks   = ALG:izmaksat
        VUT=GETKADRI(ALG:ID,2,1)
        KOPA_IZMAKSAT+= ALG:izmaksat
        IF  IZMAKS>=0
          seizmaks +=  izmaks
          PARADS    = ''
        ELSE
          sePARADS +=  izmaks
          PARADS    = 'PARÂDS'
        .
        IF IZMAKS
           NUMURS += 1
           PRINT(RPT:DETAIL)
        .
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
  IF SEND(ALGAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!    summa_v1=sub(sumvar( seizmaks,'Ls',0),1,56)
!    summa_v2=sub(sumvar( seizmaks,'Ls',0),57,56)
    summa_v1=sub(sumvar( seizmaks,val_uzsk,0),1,56)
    summa_v2=sub(sumvar( seizmaks,val_uzsk,0),57,56)
    CLOSE(ProgressWindow)
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
       PRINT(RPT:GRP_FOOT)
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
    ELSE
       ANSIJOB
    .
  .
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE           !RTF,EXCEL
     CLOSE(OUTFILEANSI)
     ANSIFILENAME=''
  .
  DO ProcedureReturn

!-----------------------------------------------------------------------------
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
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
!-----------------------------------------------------------------------------
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
      StandardWarning(Warn:RecordFetchError,'ALGAS')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
!-----------------------------------------------------------------------------
PRT_BRK_HDRS ROUTINE                             !DO GROUP HEADERS
  IF BRK_FLAG# <= 1                              !CHECK BREAK LEVEL
      seizmaks   = 0
      sePARADS   = 0
     IF nrsektori>0
!      vajag_head = 1
!!!       PRINT(RPT:grp_head0)
       PRINT(RPT:grp_head1)
     .
  .
PRT_BRK_FTRS ROUTINE                             !DO GROUP FOOTERS
  GET(ALGAS,LAST_REC#)                           !REREAD PREVIOUS RECORD
  IF BRK_FLAG# <= 1                              !CHECK BREAK LEVEL
    IF nrsektori>0
       PRINT(RPT:GRP_FOOT)                              ! PRINT GROUP FOOTER
    .
  .
! SKIP(ALGAS,-1)                                 !BACKUP ONE RECORD
! NEXT(ALGAS)                                    !AND REREAD IT
