                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpIet PROCEDURE


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
DAIEVTEX             STRING(35),DIM(10)
Bridinajums          STRING(40)
Update::Reloop  BYTE
Update::Error   BYTE
History::DAI:Record LIKE(DAI:Record),STATIC
SAV::DAI:Record      LIKE(DAI:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the DAIEV File'),AT(,,296,323),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateDAIEV'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,5,289,296),USE(?CurrentTab)
                         TAB('Ieturçjumi'),USE(?Tab:1)
                           STRING('Kods:'),AT(14,26),USE(?StringKODS)
                           ENTRY(@n03),AT(35,26,23,10),USE(DAI:KODS),RIGHT(1)
                           PROMPT('&Nosaukums :'),AT(67,26,41,10),USE(?DAI:NOSAUKUMS:Prompt)
                           ENTRY(@s35),AT(114,26,144,10),USE(DAI:NOSAUKUMS),REQ
                           OPTION('&Funkcija'),AT(10,39,167,73),USE(DAI:F),BOXED
                             RADIO('NAV (nav funkcija)'),AT(15,47),USE(?dai:F:Radio1)
                             RADIO('REZ (ir funkcija no piesk. rezultâta)'),AT(15,58),USE(?dai:F:Radio2)
                             RADIO('PNO (ir f. no piesk. pçc nodokïiem)'),AT(15,69),USE(?dai:F:Radio3)
                             RADIO('PIE (ir f. no piesk. pçc visiem ieturçjumiem,'),AT(15,79),USE(?dai:F:Radio4)
                             RADIO('SYS (bûvç sistçma)'),AT(15,97),USE(?dai:F:Radio5)
                           END
                           STRING('kam kods mazâks kâ ðim)'),AT(39,87),USE(?String5)
                           OPTION('&Tips'),AT(179,39,105,89),USE(DAI:T),BOXED,MSG('TIPS')
                             RADIO('1 Citi ieturçjumi (1)'),AT(184,49,95,10),USE(?dai:T:Radio1)
                             RADIO('2 Izpildraksts'),AT(184,58,95,10),USE(?dai:T:Radio2)
                             RADIO('3 Ârkârtas izmaksas'),AT(184,69,95,10),USE(?dai:T:Radio3)
                             RADIO('4 Ienâkuma nodoklis'),AT(184,79,95,10),USE(?dai:T:Radio4)
                             RADIO('5 Sociâlais nodoklis'),AT(184,88,95,10),USE(?dai:T:Radio5)
                             RADIO('6 Citi ieturçjumi (2)'),AT(184,98,95,10),USE(?dai:T:Radio6)
                             RADIO('7 Pârskaitîjums uz karti'),AT(184,108,95,10),USE(?dai:T:Radio7)
                           END
                           PROMPT('K&oeficients :'),AT(26,122,39,10),USE(?DAI:TARL:Prompt)
                           ENTRY(@n_10.4),AT(79,122,56,10),USE(DAI:TARL),DECIMAL(20)
                           PROMPT('&Summa :'),AT(25,134,27,10),USE(?DAI:ALGA:Prompt)
                           ENTRY(@n_8.2),AT(79,134,48,10),USE(DAI:ALGA),DECIMAL(12)
                           PROMPT('&%'),AT(26,145,14,10),USE(?DAI:PROC:Prompt)
                           ENTRY(@n4.1),AT(79,145,40,10),USE(DAI:PROC),DECIMAL(8)
                           STRING('Ciparu, kas jâreizina ar koef. vai % iegûst ar sekojoðiem pieskaitîjumiem :'),AT(31,162),USE(?String1)
                           STRING('(999 - visi pieskait.; 998 - visi, izòemot slilapas; 997 - visi, izò. slilapas u' &|
   'n soc.)'),AT(25,173),USE(?String2)
                           ENTRY(@n3),AT(11,182,23,10),USE(DAI:F_DAIEREZ[1]),RIGHT(1)
                           ENTRY(@s35),AT(40,182,148,10),USE(DAIEVTEX[1])
                           ENTRY(@n3),AT(11,193,23,10),USE(DAI:F_DAIEREZ[2]),RIGHT(1)
                           ENTRY(@s35),AT(40,193,148,10),USE(DAIEVTEX[2])
                           ENTRY(@n3),AT(11,204,23,10),USE(DAI:F_DAIEREZ[3]),RIGHT(1)
                           ENTRY(@s35),AT(40,204,148,10),USE(DAIEVTEX[3])
                           ENTRY(@n3),AT(11,215,23,10),USE(DAI:F_DAIEREZ[4]),RIGHT(1)
                           ENTRY(@s35),AT(40,215,148,10),USE(DAIEVTEX[4])
                           ENTRY(@n3),AT(11,227,23,10),USE(DAI:F_DAIEREZ[5]),RIGHT(1)
                           ENTRY(@s35),AT(40,227,148,10),USE(DAIEVTEX[5])
                           ENTRY(@n3),AT(11,238,23,10),USE(DAI:F_DAIEREZ[6]),RIGHT(1)
                           ENTRY(@s35),AT(40,238,148,10),USE(DAIEVTEX[6])
                           ENTRY(@n3),AT(11,249,23,10),USE(DAI:F_DAIEREZ[7]),RIGHT(1)
                           ENTRY(@s35),AT(40,249,148,10),USE(DAIEVTEX[7])
                           STRING('***** -nekontçt'),AT(227,226),USE(?String4)
                           ENTRY(@n3),AT(11,262,23,10),USE(DAI:F_DAIEREZ[8]),RIGHT(1)
                           ENTRY(@s35),AT(40,262,148,10),USE(DAIEVTEX[8])
                           ENTRY(@n3),AT(11,273,23,10),USE(DAI:F_DAIEREZ[9]),RIGHT(1)
                           ENTRY(@s35),AT(40,273,148,10),USE(DAIEVTEX[9])
                           ENTRY(@n3),AT(11,284,23,10),USE(DAI:F_DAIEREZ[10]),RIGHT(1)
                           ENTRY(@s35),AT(40,284,148,10),USE(DAIEVTEX[10])
                           STRING('Autokontçjums :'),AT(197,188),USE(?String3)
                           PROMPT('&D - konts'),AT(197,201,35,10),USE(?Prompt8)
                           ENTRY(@s5),AT(233,201,40,10),USE(DAI:DKK)
                           PROMPT('&K - konts'),AT(197,213,35,10),USE(?Prompt9)
                           ENTRY(@s5),AT(233,212,40,10),USE(DAI:KKK)
                         END
                       END
                       BUTTON('&OK'),AT(198,305,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(248,305,45,14),USE(?Cancel)
                     END
SAV_F_DAIEREZ           DECIMAL(3),DIM(10)
CONTFIELD               DECIMAL(3)
SAV:SAVERECORD          LIKE(DAI:RECORD)
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
    IF INRANGE(DAI:KODS,901,911)
       DAI:F='SYS'
       IF DAI:KODS=901 THEN DAI:NOSAUKUMS='Ienâkuma nodokïa pamatlikme'.
       IF DAI:KODS=902 THEN DAI:NOSAUKUMS='Ienâkuma nodokïa papildlikme'.
       IF DAI:KODS=903 THEN DAI:NOSAUKUMS='Darba òçmçja sociâlais nodoklis'.
       IF DAI:KODS=904 THEN DAI:NOSAUKUMS='Avanss'.
       IF DAI:KODS=905 THEN DAI:NOSAUKUMS='Pârmaksa/parâds'.
       IF DAI:KODS=906 THEN DAI:NOSAUKUMS='Ienâkuma nod. par pagâjuðo mçnesi'.
       IF DAI:KODS=907 THEN DAI:NOSAUKUMS='Ienâkuma nod. par aizpagâjuðo mçnesi'.
       IF DAI:KODS=908 THEN DAI:NOSAUKUMS='Ienâkuma nod. par nâkoðo mçnesi'.
       IF DAI:KODS=909 THEN DAI:NOSAUKUMS='Ienâkuma nod. par aiznâkoðo mçnesi'.
       IF DAI:KODS=910 THEN DAI:NOSAUKUMS='Darba òçmçja soc. n. par nâkoðo mçnesi'.
       IF DAI:KODS=911 THEN DAI:NOSAUKUMS='Darba òçm. soc. n. par aiznâkoðo mçn.'.
       DISABLE(?StringKODS,?CANCEL-2)
       ENABLE(?DAI:DKK)
       ENABLE(?DAI:KKK)
    ELSE
       DISABLE(?dai:T:Radio4)
       DISABLE(?dai:T:Radio5)
       IF ~(LocalRequest=DeleteRecord)
          case DAI:F
          OF 'REZ'
          OROF 'PNO'
          OROF 'PIE'
             ENABLE(DAI:F_DAIEREZ[1])
             ENABLE(DAI:F_DAIEREZ[2])
             ENABLE(DAI:F_DAIEREZ[3])
             ENABLE(DAI:F_DAIEREZ[4])
             ENABLE(DAI:F_DAIEREZ[5])
             ENABLE(DAI:F_DAIEREZ[6])
             ENABLE(DAI:F_DAIEREZ[7])
             ENABLE(DAI:F_DAIEREZ[8])
             ENABLE(DAI:F_DAIEREZ[9])
             ENABLE(DAI:F_DAIEREZ[10])
             DISABLE(?DAI:ALGA)
             ENABLE(?DAI:TARL)
             ENABLE(?DAI:PROC)
          OF 'NAV'
             DISABLE(DAI:F_DAIEREZ[1])
             DISABLE(DAI:F_DAIEREZ[2])
             DISABLE(DAI:F_DAIEREZ[3])
             DISABLE(DAI:F_DAIEREZ[4])
             DISABLE(DAI:F_DAIEREZ[5])
             DISABLE(DAI:F_DAIEREZ[6])
             DISABLE(DAI:F_DAIEREZ[7])
             DISABLE(DAI:F_DAIEREZ[8])
             DISABLE(DAI:F_DAIEREZ[9])
             DISABLE(DAI:F_DAIEREZ[10])
             ENABLE(?DAI:ALGA)
             DISABLE(?DAI:TARL)
             DISABLE(?DAI:PROC)
          .
       .
    .
    IF INRANGE(DAI:KODS,906,909) OR INRANGE(DAI:KODS,901,902)
       DAI:T='4'
    ELSIF INRANGE(DAI:KODS,910,911)OR DAI:KODS=903
       DAI:T='5'
    .
    SAV:SAVERECORD=DAI:RECORD
    loop I#=1 TO 10
       SAV_F_DAIEREZ[I#]=DAI:F_DAIEREZ[I#]
    .
    loop I#=1 TO 10
      IF SAV_F_DAIEREZ[I#]=0
         DAIEVTEX[I#]=''
      ELSIF SAV_F_DAIEREZ[I#]=999
         DAIEVTEX[I#]='Visi pieskaitîjumi'
      ELSIF SAV_F_DAIEREZ[I#]=998
         DAIEVTEX[I#]='Visi piesk.,izò. 850-859'
      ELSIF SAV_F_DAIEREZ[I#]=997
         DAIEVTEX[I#]='Visi piesk.,izò. 850-869'
      ELSE
         CLEAR(DAI:RECORD)
         DAI:KODS=ABS(SAV_F_DAIEREZ[I#])
         GET(DAIEV,DAI:KOD_KEY)
         IF SAV_F_DAIEREZ[I#] > 0
            DAIEVTEX[I#]=DAI:NOSAUKUMS
         ELSE
            DAIEVTEX[I#]='Izòemot '&clip(DAI:NOSAUKUMS)
         .
      .
    .
    DAI:RECORD=SAV:SAVERECORD
    DISPLAY
  
  
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
      SELECT(?StringKODS)
      IF INRANGE(DAI:KODS,901,911)
        SELECT(?cancel)
      ELSE
        SELECT(?DAI:NOSAUKUMS)
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
        History::DAI:Record = DAI:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(DAIEV)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(DAI:KOD_KEY)
              IF StandardWarning(Warn:DuplicateKey,'DAI:KOD_KEY')
                SELECT(?StringKODS)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?StringKODS)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::DAI:Record <> DAI:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:DAIEV(1)
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
              SELECT(?StringKODS)
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
    OF ?DAI:KODS
      CASE EVENT()
      OF EVENT:Accepted
                IF DAI:KODS<900
                   BEEP
                   SELECT(?DAI:KODS)
                .
                IF INRANGE(DAI:KODS,906,909) OR INRANGE(DAI:KODS,901,902)
                   DAI:T='4'
                   DISABLE(?DAI:T)
                ELSIF INRANGE(DAI:KODS,910,911)OR DAI:KODS=903
                   DAI:T='5'
                   DISABLE(?DAI:T)
                ELSE
                   ENABLE(?DAI:T)
                .
                DISPLAY
      END
    OF ?DAI:F
      CASE EVENT()
      OF EVENT:Accepted
                 case DAI:F
                 OF 'REZ'
                 OROF 'PNO'
                 OROF 'PIE'
                    ENABLE(DAI:F_DAIEREZ[1])
                    ENABLE(DAI:F_DAIEREZ[2])
                    ENABLE(DAI:F_DAIEREZ[3])
                    ENABLE(DAI:F_DAIEREZ[4])
                    ENABLE(DAI:F_DAIEREZ[5])
                    ENABLE(DAI:F_DAIEREZ[6])
                    ENABLE(DAI:F_DAIEREZ[7])
                    ENABLE(DAI:F_DAIEREZ[8])
                    ENABLE(DAI:F_DAIEREZ[9])
                    ENABLE(DAI:F_DAIEREZ[10])
                    DISABLE(?DAI:ALGA)
                    ENABLE(?DAI:TARL)
                    ENABLE(?DAI:PROC)
                 OF 'NAV'
                    DISABLE(DAI:F_DAIEREZ[1])
                    DISABLE(DAI:F_DAIEREZ[2])
                    DISABLE(DAI:F_DAIEREZ[3])
                    DISABLE(DAI:F_DAIEREZ[4])
                    DISABLE(DAI:F_DAIEREZ[5])
                    DISABLE(DAI:F_DAIEREZ[6])
                    DISABLE(DAI:F_DAIEREZ[7])
                    DISABLE(DAI:F_DAIEREZ[8])
                    DISABLE(DAI:F_DAIEREZ[9])
                    DISABLE(DAI:F_DAIEREZ[10])
                    ENABLE(?DAI:ALGA)
                    DISABLE(?DAI:TARL)
                    DISABLE(?DAI:PROC)
                 .
      END
    OF ?DAI:F_DAIEREZ_1
      CASE EVENT()
      OF EVENT:Accepted
        I#=1
        DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_2
      CASE EVENT()
      OF EVENT:Accepted
        I#=2
        DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_3
      CASE EVENT()
      OF EVENT:Accepted
        I#=3
        DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_4
      CASE EVENT()
      OF EVENT:Accepted
        I#=4
        DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_5
      CASE EVENT()
      OF EVENT:Accepted
        I#=5
        DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_6
      CASE EVENT()
      OF EVENT:Accepted
        I#=6
        DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_7
      CASE EVENT()
      OF EVENT:Accepted
        I#=7
        DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_8
      CASE EVENT()
      OF EVENT:Accepted
        I#=8
        DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_9
      CASE EVENT()
      OF EVENT:Accepted
        I#=9
        DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_10
      CASE EVENT()
      OF EVENT:Accepted
        I#=10
        DO FILLDAIEVTEX
      END
    OF ?DAI:DKK
      CASE EVENT()
      OF EVENT:Accepted
        IF DAI:DKK AND ~(DAI:DKK='*****')
           KKK=DAI:DKK
           DAI:DKK=GETKON_K(DAI:DKK,1,1)
           DISPLAY
        .
      END
    OF ?DAI:KKK
      CASE EVENT()
      OF EVENT:Accepted
        IF DAI:KKK AND ~(DAI:KKK='*****')
           KKK=DAI:KKK
           DAI:KKK=GETKON_K(DAI:KKK,1,1)
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
  IF DAIEV::Used = 0
    CheckOpen(DAIEV,1)
  END
  DAIEV::Used += 1
  BIND(DAI:RECORD)
  FilesOpened = True
  RISnap:DAIEV
  SAV::DAI:Record = DAI:Record
  IF LocalRequest = InsertRecord
    DAI:KODS = 900
    DAI:T = 1
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
        IF RIDelete:DAIEV()
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
  INIRestoreWindow('UpIet','winlats.INI')
  WinResize.Resize
  ?DAI:KODS{PROP:Alrt,255} = 734
  ?DAI:NOSAUKUMS{PROP:Alrt,255} = 734
  ?DAI:F{PROP:Alrt,255} = 734
  ?DAI:T{PROP:Alrt,255} = 734
  ?DAI:TARL{PROP:Alrt,255} = 734
  ?DAI:ALGA{PROP:Alrt,255} = 734
  ?DAI:PROC{PROP:Alrt,255} = 734
  ?DAI:DKK{PROP:Alrt,255} = 734
  ?DAI:KKK{PROP:Alrt,255} = 734
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
  END
  IF WindowOpened
    INISaveWindow('UpIet','winlats.INI')
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
FILLDAIEVTEX       ROUTINE
 CONTFIELD=CONTENTS(FIELD())
 IF CONTFIELD=0
    DAIEVTEX[I#]=''
 ELSIF CONTFIELD = 999
    DAIEVTEX[I#]='Visi pieskaitîjumi'
 ELSIF CONTFIELD = 998
    DAIEVTEX[I#]='Visi piesk.,izò. 850-859'
 ELSIF CONTFIELD = 997
    DAIEVTEX[I#]='Visi piesk.,izò. 850-869'
 ELSE
    SAV:SAVERECORD=DAI:RECORD
    CLEAR(DAI:RECORD)
    DAI:KODS=abs(CONTFIELD)
    GET(DAIEV,DAI:KOD_KEY)
    IF ERROR()
       GlobalRequest=SelectRecord
       F:IDP='P'
       BROWSEDAIEV
       F:IDP=''
       IF GlobalResponse=RequestCompleted
          CONTFIELD=DAI:KODS
       ELSE
          CONTFIELD=0
          CLEAR(DAI:RECORD)
      .
    .
    IF CONTFIELD>0
       DAIEVTEX[I#]=DAI:NOSAUKUMS
    ELSE
       DAIEVTEX[I#]='Izòemot '&clip(DAI:NOSAUKUMS)
    .
    DAI:RECORD=SAV:SAVERECORD
    DAI:F_DAIEREZ[I#]=CONTFIELD
 .
 DISPLAY()
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?DAI:KODS
      DAI:KODS = History::DAI:Record.KODS
    OF ?DAI:NOSAUKUMS
      DAI:NOSAUKUMS = History::DAI:Record.NOSAUKUMS
    OF ?DAI:F
      DAI:F = History::DAI:Record.F
    OF ?DAI:T
      DAI:T = History::DAI:Record.T
    OF ?DAI:TARL
      DAI:TARL = History::DAI:Record.TARL
    OF ?DAI:ALGA
      DAI:ALGA = History::DAI:Record.ALGA
    OF ?DAI:PROC
      DAI:PROC = History::DAI:Record.PROC
    OF ?DAI:DKK
      DAI:DKK = History::DAI:Record.DKK
    OF ?DAI:KKK
      DAI:KKK = History::DAI:Record.KKK
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
  DAI:Record = SAV::DAI:Record
  SAV::DAI:Record = DAI:Record
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

A_DAIEVPROT2D        PROCEDURE                    ! Declare Procedure
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

D1                   STRING(30)
D2                   STRING(30)
RSUMMA               DECIMAL(10,2)
SUMMA_K              DECIMAL(10,2)
NPK                  DECIMAL(3)
dat                  DATE
LAI                  TIME
RPT_GADS             DECIMAL(4)
MENESIS              STRING(10)
VARUZV               STRING(30)

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
                       PROJECT(ALG:n_stundas)
                       PROJECT(ALG:PR1)
                       PROJECT(ALG:PR37)
                       PROJECT(ALG:NODALA)
                       PROJECT(ALG:STATUSS)
                       PROJECT(ALG:YYYYMM)
                     END
!--------------------------------------------------------------------------
report REPORT,AT(198,1729,8000,9198),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,240,8000,1490),USE(?unnamed)
         STRING(@s45),AT(1875,104,4427,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma DAIEV2K'),AT(6406,938,833,156),USE(?String9),LEFT
         STRING(@S30),AT(3021,990,2396,208),USE(VARUZV),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6667,1073,573,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(938,1250,6302,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1406,1250,0,260),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3958,1250,0,260),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7240,1250,0,260),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('NPK'),AT(990,1302,417,156),USE(?String2:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçnesis'),AT(1458,1302,2500,156),USE(?String2:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(4010,1302,3229,156),USE(?String2:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,1458,6302,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(938,1250,0,260),USE(?Line2),COLOR(COLOR:Black)
         STRING('Maksâjumi pçc DAIEV'),AT(2552,417,1615,260),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D14),AT(4219,417),USE(S_DAT),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(4896,417,156,260),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D14),AT(5104,417),USE(B_DAT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('DAIEV kods ='),AT(2188,729,938,260),USE(?String2:3),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(3125,729,302,260),USE(DAIKODS),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@S35),AT(3490,729,2604,260),USE(DAI:NOSAUKUMS),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         STRING(@N4),AT(1563,10,313,156),USE(rpt_gads),RIGHT
         STRING('. g.'),AT(1875,10,,156),USE(?String22),LEFT
         LINE,AT(938,-10,0,198),USE(?Line2:3),COLOR(COLOR:Black)
         STRING(@N3),AT(990,10,,156),USE(NPK),RIGHT
         LINE,AT(1406,-10,0,198),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(4948,10,1406,156),USE(RSUMMA),RIGHT
         LINE,AT(7240,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@s12),AT(2188,10,,156),USE(menesis),LEFT
       END
RPT_FOOT DETAIL,AT(,,,354)
         LINE,AT(938,-10,0,271),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(1406,-10,0,63),USE(?Line2:12),COLOR(COLOR:Black)
         STRING('Kopâ :'),AT(1042,104,573,156),USE(?String2:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(4948,104,1406,156),USE(SUMMA_k),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,260,6302,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(938,52,6302,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,271),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,271),USE(?Line2:11),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,10852,8000,167),USE(?unnamed:2)
         LINE,AT(938,0,6302,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@d06.),AT(6094,21,625,156),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(6740,21,521,156),USE(lai),FONT(,7,,,CHARSET:ANSI)
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

!
! KONKRÇTAM DAIEV
!
  PUSHBIND
  BIND('ID',ID)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
!  D1 = Y(YEAR(S_DAT),MONTH(S_DAT))
!  D2 = Y(YEAR(B_DAT),MONTH(B_DAT))
  DAT=TODAY()
  LAI=CLOCK()
  VARUZV = CLIP(KAD:Var)&' '&CLIP(KAD:Uzv)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(ALGAS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'DAIEV maksâjumu protokols'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      alg:id=id
!      ALG:YYMM=Y(YEAR(S_DAT),MONTH(S_DAT))
      SET(ALG:ID_DAT,ALG:ID_DAT)
      Process:View{Prop:Filter} = 'INRANGE(ALG:YYYYMM,S_DAT,B_DAT) AND (ALG:ID=ID)'
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
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('DAIEV2D.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='MAKSÂJUMI PÇC DAIEV'&CHR(9)&format(S_DAT,@d014.)&CHR(9)&format(B_DAT,@d014.)
          ADD(OUTFILEANSI)
          OUTA:LINE='DAIEV kods:'&CHR(9)&DAIKODS&CHR(9)&DAI:NOSAUKUMS
          ADD(OUTFILEANSI)
          OUTA:LINE=VARUZV
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Npk'&CHR(9)&'Mçnesis'&CHR(9)&'Summa'
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NNR#+=1
        ?Progress:UserString{Prop:Text}=NNR#
        DISPLAY(?Progress:UserString)
        IF DAIKODS<901
          LOOP I#= 1 TO 20
            IF ALG:K[I#]=DAIKODS
              RSUMMA+=ALG:R[I#]
            .
          .
        ELSE
          LOOP I#= 1 TO 15
            IF ALG:I[I#]=DAIKODS
              RSUMMA+=ALG:N[I#]
            .
          .
        .
        SUMMA_K+=RSUMMA
        RPT_GADS=YEAR(ALG:YYYYMM)
        MENESIS=MENVAR(ALG:YYYYMM,2,2)
        NPK+=1
        IF F:DBF = 'W'
            PRINT(RPT:DETAIL)
        ELSE
            OUTA:LINE=CLIP(NPK)&CHR(9)&RPT_GADS&'.gads '&menesis&CHR(9)&LEFT(FORMAT(RSUMMA,@N-_12.2))
            ADD(OUTFILEANSI)
        END
        RSUMMA=0
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
    IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT)
        ENDPAGE(report)
    ELSE
        OUTA:LINE='KOPÂ:'&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_K,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    CLOSE(ProgressWindow)
    IF F:DBF='W'
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
  ELSE           !WORD,EXCEL
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
A_DAIEVPROT2         PROCEDURE                    ! Declare Procedure
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

K_TABLE              QUEUE,PRE(K)
ID                     USHORT
STUNDAS                USHORT
SUMMA                  DECIMAL(9,2)
                     .
RSUMMA               DECIMAL(10,2)
SUMMA_K              DECIMAL(10,2)
NPK                  USHORT
DAT                  DATE
LAI                  TIME
D1                   STRING(30)
D2                   STRING(30)
VARUZV               STRING(25)
RPT_SEKT             STRING(4)
STUNDAS              DECIMAL(7)

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
!--------------------------------------------------------------------------
report REPORT,AT(198,1542,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,250,8000,1292),USE(?unnamed:2)
         STRING(@s45),AT(2083,104,4323,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Stundas'),AT(4010,1094,1094,156),USE(?String23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S4),AT(5990,417),USE(RPT_SEKT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5104,1042,0,260),USE(?Line18),COLOR(COLOR:Black)
         STRING('Forma DAIEV2V'),AT(6406,729,833,156),USE(?String9),LEFT
         STRING(@P<<<#. lapaP),AT(6646,865,573,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(938,1042,6302,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1406,1042,0,260),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3958,1042,0,260),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7240,1042,0,260),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('NPK'),AT(990,1094,417,156),USE(?String2:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds, uzvârds'),AT(1458,1094,2500,156),USE(?String2:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(5156,1094,2083,156),USE(?String2:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,1250,6302,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(938,1042,0,260),USE(?Line2),COLOR(COLOR:Black)
         STRING('Maksâjumi pçc DAIEV'),AT(2083,417,1615,260),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D14),AT(3750,417),USE(S_DAT),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(4375,417,156,260),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D14),AT(4531,417),USE(B_DAT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Sektors:'),AT(5313,417,677,260),USE(?String2:8),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('DAIEV kods ='),AT(2240,729,885,260),USE(?String2:3),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(3125,729,302,260),USE(DAI:KODS),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@S35),AT(3490,729,2604,260),USE(DAI:NOSAUKUMS),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(938,-10,0,198),USE(?Line2:3),COLOR(COLOR:Black)
         STRING(@N3),AT(1094,10,,156),USE(NPK),RIGHT
         LINE,AT(1406,-10,0,198),USE(?Line2:4),COLOR(COLOR:Black)
         STRING(@S30),AT(1510,10,2448,156),USE(VARUZV),LEFT
         LINE,AT(3958,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5469,10,1406,156),USE(RSUMMA),RIGHT
         LINE,AT(7240,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@N_7B),AT(4271,10,,156),USE(STUNDAS),RIGHT
         LINE,AT(5104,-10,0,198),USE(?Line19),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,271)
         LINE,AT(938,-10,0,271),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(1406,-10,0,63),USE(?Line2:12),COLOR(COLOR:Black)
         STRING('Kopâ :'),AT(1042,104,573,156),USE(?String2:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(5469,104,1406,156),USE(SUMMA_k),RIGHT
         LINE,AT(938,260,6302,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(938,52,6302,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,271),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,271),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,271),USE(?Line20),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,11050,8000,177),USE(?unnamed)
         LINE,AT(938,0,6302,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@d06.),AT(6115,21,625,156),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(6750,21,521,156),USE(lai),FONT(,7,,,CHARSET:ANSI)
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

!
! KONKRÇTAM DAIEV
!

  PUSHBIND
  CHECKOPEN(KADRI,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)
  DAT=TODAY()
  LAI=CLOCK()
  IF ~F:NODALA
     RPT_SEKT='Visi'
  else
     RPT_SEKT=F:NODALA
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(ALGAS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'DAIEV maksâjumu protokols'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      ALG:YYYYMM=S_DAT
      SET(ALG:ID_KEY,ALG:ID_KEY)
!!      Process:View{Prop:Filter} = 'INRANGE(ALG:YYYYMM,S_DAT,B_DAT) AND (ALG:SEKT=SEKT OR SEKT=0) AND (ALG:ID=ID OR ID=0)'
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
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('DAIEV2.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='MAKSÂJUMI PÇC DAIEV'&CHR(9)&format(S_DAT,@d014.)&CHR(9)&format(B_DAT,@d014.)
          ADD(OUTFILEANSI)
          OUTA:LINE='NODALA:'&CHR(9)&RPT_SEKT
          ADD(OUTFILEANSI)
          OUTA:LINE='DAIEV kods:'&CHR(9)&DAI:KODS&CHR(9)&DAI:NOSAUKUMS
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Npk'&CHR(9)&'Vârds, uzvârds'&CHR(9)&'Stundas'&CHR(9)&'Summa'
          ADD(OUTFILEANSI)
!          OUTA:LINE='-{60}'
!          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~F:NODALA OR ALG:NODALA=F:NODALA
            NNR#+=1
            ?Progress:UserString{Prop:Text}=NNR#
            DISPLAY(?Progress:UserString)
            IF DAI:KODS<901
              LOOP I#= 1 TO 20
                IF ALG:K[I#]=DAI:KODS
                  GET(K_TABLE,0)
                  K:ID=ALG:ID
                  GET(K_TABLE,K:ID)
                  IF ERROR()
                    K:SUMMA   = ALG:R[I#]
                    IF DAI:F='ARG' AND UPPER(DAI:ARG_NOS)='STUNDAS'
                       K:STUNDAS = ALG:A[I#]
                    ELSE
                       K:STUNDAS = ALG:S[I#]
                    .
                    ADD(K_TABLE)
                    SORT(K_TABLE,K:ID)
                  ELSE
                    K:SUMMA   += ALG:R[I#]
                    IF DAI:F='ARG' AND UPPER(DAI:ARG_NOS)='STUNDAS'
                       K:STUNDAS += ALG:A[I#]
                    ELSE
                       K:STUNDAS += ALG:S[I#]
                    .
                    PUT(K_TABLE)
                  .
                .
              .
            ELSE
              LOOP I#= 1 TO 15
                IF ALG:I[I#]=DAI:KODS
                  GET(K_TABLE,0)
                  K:ID=ALG:ID
                  GET(K_TABLE,K:ID)
                  IF ERROR()
                    K:SUMMA=ALG:N[I#]
                    ADD(K_TABLE)
                    SORT(K_TABLE,K:ID)
                  ELSE
                    K:SUMMA+=ALG:N[I#]
                    PUT(K_TABLE)
                  .
                .
              .
            .
        END
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
    LOOP I#=1 TO RECORDS(K_TABLE)
      GET(K_TABLE,I#)
!!      I#=GETKADRI(ALG:ID,2,1)
      CLEAR(KAD:RECORD)
      KAD:ID=K:ID
      GET(KADRI,KAD:ID_KEY)
      RSUMMA = K:SUMMA
      STUNDAS= K:STUNDAS
      NPK+=1
      VARUZV=CLIP(KAD:Var)&' '&CLIP(KAD:Uzv)
      IF F:DBF = 'W'
            PRINT(RPT:DETAIL)
      ELSE
            OUTA:LINE=Npk&CHR(9)&VARUZV&CHR(9)&STUNDAS&CHR(9)&LEFT(FORMAT(RSUMMA,@N-_12.2))
            ADD(OUTFILEANSI)
      END
      SUMMA_K+=K:SUMMA
    .
    IF F:DBF = 'W'
          PRINT(RPT:RPT_FOOT)
          ENDPAGE(report)
    ELSE
          OUTA:LINE='KOPÂ: {24}'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_K,@N-_12.2))
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
    END
    CLOSE(ProgressWindow)
    IF F:DBF='W'
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
  ELSE           !WORD,EXCEL
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
  FREE(K_TABLE)
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
  IF ERRORCODE() OR ALG:YYYYMM > B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
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

