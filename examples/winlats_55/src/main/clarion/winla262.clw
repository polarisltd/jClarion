                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateAU_TEX PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
CurrentTab           STRING(80)
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
Update::Reloop  BYTE
Update::Error   BYTE
History::AUX:Record LIKE(AUX:Record),STATIC
SAV::AUX:Record      LIKE(AUX:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
FormWindow           WINDOW('Update Records...'),AT(18,5,289,159),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),CENTER,SYSTEM,GRAY,MDI
                       BUTTON('&OK'),AT(191,138,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('&Atlikt'),AT(236,138,40,12),USE(?Cancel)
                       STRING(@S40),AT(76,2),USE(ActionMessage)
                       STRING(@s10),AT(111,15),USE(AUX:AUT_TEXT),FONT(,10,,FONT:bold,CHARSET:ANSI)
                       PROMPT('Datums:'),AT(29,35),USE(?AUB:DATUMS:Prompt)
                       ENTRY(@D06.),AT(79,33,40,10),USE(AUX:DATUMS),RIGHT(1)
                       PROMPT('Partneris'),AT(29,46),USE(?AUX:PAR_NOS_P:Prompt)
                       ENTRY(@S35),AT(79,44,121,10),USE(AUX:PAR_NOS_P)
                       PROMPT('Telefons:'),AT(29,57),USE(?AUX:PAR_TEL:Prompt)
                       ENTRY(@s25),AT(79,55,60,10),USE(AUX:PAR_TEL)
                       PROMPT('Auto:'),AT(29,68),USE(?AUX:PAR_AUT0:Prompt)
                       ENTRY(@s30),AT(79,66,118,10),USE(AUX:PAR_AUT0)
                       ENTRY(@s45),AT(79,78,195,10),USE(AUX:SATURS1)
                       ENTRY(@s45),AT(79,89,195,10),USE(AUX:SATURS2)
                       BUTTON('Defekti'),AT(29,79,40,12),USE(?Button3)
                       ENTRY(@s45),AT(79,101,195,10),USE(AUX:SATURS3)
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
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  OF DeleteRecord
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
    OF EVENT:OpenWindow
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?OK)
      SELECT(?AUX:SATURS1)
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
    ELSE
      IF ACCEPTED() = TbarBrwHistory
        DO HistoryField
      END
      IF EVENT() = Event:Completed
        History::AUX:Record = AUX:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(AU_TEX)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?OK)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::AUX:Record <> AUX:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:AU_TEX(1)
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
              SELECT(?OK)
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
    OF ?Button3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BROWSETEK_SER 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GLOBALRESPONSE=REQUESTCOMPLETED
            TEKSTS=LEFT(CLIP(AUX:SATURS1)&' '&CLIP(AUX:SATURS2)&' '&CLIP(AUX:SATURS3)&' '&CLIP(TES:TEKSTS))
            FORMAT_TEKSTS(45,'WINDOW',0,'')
            AUX:SATURS1=F_TEKSTS[1]
            AUX:SATURS2=F_TEKSTS[2]
            AUX:SATURS3=F_TEKSTS[3]
         .
         DISPLAY
        
        
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF AU_TEX::Used = 0
    CheckOpen(AU_TEX,1)
  END
  AU_TEX::Used += 1
  BIND(AUX:RECORD)
  FilesOpened = True
  RISnap:AU_TEX
  SAV::AUX:Record = AUX:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    CLEAR(AUX:RECORD)
    AUX:DATUMS=AUB:DATUMS
    AUX:AUT_TEXT=AUB:AUT_TEXT[VIETA_NR]
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:AU_TEX()
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
  OPEN(FormWindow)
  WindowOpened=True
  INIRestoreWindow('UpdateAU_TEX','winlats.INI')
  ?AUX:AUT_TEXT{PROP:Alrt,255} = 734
  ?AUX:DATUMS{PROP:Alrt,255} = 734
  ?AUX:PAR_NOS_P{PROP:Alrt,255} = 734
  ?AUX:PAR_TEL{PROP:Alrt,255} = 734
  ?AUX:PAR_AUT0{PROP:Alrt,255} = 734
  ?AUX:SATURS1{PROP:Alrt,255} = 734
  ?AUX:SATURS2{PROP:Alrt,255} = 734
  ?AUX:SATURS3{PROP:Alrt,255} = 734
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
    AU_TEX::Used -= 1
    IF AU_TEX::Used = 0 THEN CLOSE(AU_TEX).
  END
  IF WindowOpened
    INISaveWindow('UpdateAU_TEX','winlats.INI')
    CLOSE(FormWindow)
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
  IF FormWindow{Prop:AcceptAll} THEN EXIT.
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
    OF ?AUX:AUT_TEXT
      AUX:AUT_TEXT = History::AUX:Record.AUT_TEXT
    OF ?AUX:DATUMS
      AUX:DATUMS = History::AUX:Record.DATUMS
    OF ?AUX:PAR_NOS_P
      AUX:PAR_NOS_P = History::AUX:Record.PAR_NOS_P
    OF ?AUX:PAR_TEL
      AUX:PAR_TEL = History::AUX:Record.PAR_TEL
    OF ?AUX:PAR_AUT0
      AUX:PAR_AUT0 = History::AUX:Record.PAR_AUT0
    OF ?AUX:SATURS1
      AUX:SATURS1 = History::AUX:Record.SATURS1
    OF ?AUX:SATURS2
      AUX:SATURS2 = History::AUX:Record.SATURS2
    OF ?AUX:SATURS3
      AUX:SATURS3 = History::AUX:Record.SATURS3
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
  AUX:Record = SAV::AUX:Record
  SAV::AUX:Record = AUX:Record
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    RecordChanged = False
    IF LocalRequest = InsertRecord OR LocalRequest = ChangeRecord
      IF SAV::AUX:Record <> AUX:Record
        RecordChanged = True
      END
    END
    IF RecordChanged
      CASE StandardWarning(Warn:SaveOnCancel)
      OF Button:Yes
        POST(Event:Accepted,?OK)
        Update::Reloop = 1
        EXIT
      OF Button:No
      OF BUTTON:Cancel
        SELECT(?OK)
        Update::Reloop = 1
        EXIT
      END
    END
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

F_ParID              PROCEDURE                    ! Declare Procedure
RejectRecord         LONG
LocalRequest         LONG
LocalResponse        LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
FilesOpened          LONG

PAR_LIGUMS           STRING(45)
LICENCES_IZ_DATUMS   DATE
!LICENCES_DATUMS      DATE,DIM(3,6) !RINDAS,MODUÏI
LICENCES_DATUMS      STRING(12),DIM(3,6) !RINDAS,MODUÏI
CODE39P              STRING(30),DIM(3,6) !RINDAS,MODUÏI
LICENCES_DAT         DATE,DIM(3)
MAKS_DATUMS          DATE,DIM(3)

gov_reg              STRING(11)
PVN_reg              STRING(11)
banka1               string(55)
BAN_NOS_P            STRING(31)
PASTA_adrese         string(50)
Padrese2             string(50)
SYS_PARAKSTS         STRING(25)
SYS_TEL              STRING(27)  !10+17
OPC                  BYTE

SUMMAKOPA            DECIMAL(11,2),DIM(3)
SUMMAKOPAarPVN       DECIMAL(11,2),DIM(3)
SUMMAMEN             DECIMAL(11,2),DIM(3)
SUMMAMENarPVN        DECIMAL(11,2),DIM(3)

!DSL_BASE             DECIMAL(2),DIM(3)
DSL_BASE             STRING(2),DIM(3)
PAPL_BASE            STRING(25),DIM(3)
DSL_NOLIK            STRING(2),DIM(3)
PAPL_NOLIK           STRING(100),DIM(3)
DSL_FP               STRING(2),DIM(3)
DSL_ALGA             STRING(2),DIM(3)
DSL_LA               STRING(2),DIM(3)
DSL_PL               STRING(2),DIM(3)

WLC                  STRING(26)
WLCG                 GROUP,PRE(),OVER(WLC)
WLC0102              STRING(2)
WLC3                 STRING(1) !B
WLC4                 STRING(1)
WLC5                 STRING(1)
WLC0607              STRING(2)
WLC8                 STRING(1) !A
WLC0910              STRING(2)
WLC11                STRING(1) !N
WLC12                STRING(1)
WLC13                STRING(1)
WLC14                STRING(1)
WLC15                STRING(1)
WLC16                STRING(1)
WLC17                STRING(1)
WLC1819              STRING(2)
WLC20                STRING(1) !P
WLC2122              STRING(2)
WLC23                STRING(1) !LA
WLC2425              STRING(2)
WLC26                STRING(1) !FP
                     END

GADS1                DECIMAL(1)
DATUMS1              DECIMAL(2)
MENESIS_V            STRING(10)
ATVERTA              STRING(7)
ATVERTA_TEXT         STRING(100)
PAR_ZIM_VUT          STRING(40)
PAR_KONTAKTS         STRING(40)
PAR_BAN              STRING(80)
CODE39               STRING(30)

P_TABLE         QUEUE,PRE(P)
L_DATUMS            LIKE(PAR:L_DATUMS)
LIGUMS              LIKE(PAR:LIGUMS)
L_CDATUMS           LIKE(PAR:L_CDATUMS)
L_SUMMA             LIKE(PAR:L_SUMMA)
L_SUMMA1            LIKE(PAR:L_SUMMA1)
                .
VARDS               STRING(30)

!-----------------------------------------------------------------------------
Report REPORT,AT(400,500,7990,11500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
detailR DETAIL,AT(,,,5115),USE(?REKVIZITI)
         STRING(@n_4B),AT(2208,927),USE(PAR:KARTE,,?PAR:KARTE:2),TRN,FONT(,20,,FONT:bold,CHARSET:ANSI)
         STRING('Klienta Nr:'),AT(552,1031),USE(?String69),TRN
         STRING(@s45),AT(1771,1333,4396,188),USE(par:nos_p,,?par:nos_p:2),TRN,LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums:'),AT(552,1344),USE(?String69:9),TRN
         STRING(@s60),AT(1781,1854,4552,156),USE(PASTA_ADRESE,,?PASTA_ADRESE:2),TRN,LEFT
         STRING('Pasta adrese:'),AT(552,1844),USE(?String69:2),TRN
         STRING(@s60),AT(1781,1615,4552,156),USE(Par:ADRESE,,?Par:ADRESE:2),LEFT
         STRING('Juridiskâ adrese:'),AT(552,1604),USE(?String69:8),TRN
         STRING(@S22),AT(2250,2125,1802,156),USE(PAR:NMR_KODS,,?PAR:NMR_KODS:2),LEFT
         STRING(@S22),AT(2250,2385,1729,156),USE(PAR:PVN,,?PAR:PVN:2),TRN,LEFT
         STRING('PVN reìistrâcijas Nr:'),AT(552,2375),USE(?String69:4),TRN
         STRING('Norçíinu rekvizîti:'),AT(542,2635,1063,208),USE(?String69:5),TRN
         STRING('Vienotais reìistrâcijas Nr:'),AT(542,2115),USE(?String69:3),TRN
         STRING(@S80),AT(1646,2625,5875,156),USE(PAR_BAN,,?PAR_BAN:2),LEFT(1)
         STRING('e-pasts:'),AT(552,2896,760,208),USE(?String69:6),TRN
         STRING(@s35),AT(1646,2875,2646,156),USE(PAR:EMAIL,,?PAR:EMAIL:3),LEFT
         STRING('Kontaktpersona:'),AT(552,3146,1052,208),USE(?String69:7),TRN
         STRING(@s40),AT(1646,3135,3031,156),USE(PAR_KONTAKTS,,?PAR_KONTAKTS:2),TRN,LEFT
       END
LAPA1BL DETAIL,AT(,,,5115),USE(?LAPA1BL)
         STRING(@n_4B),AT(5167,750),USE(PAR:KARTE),TRN,FONT(,20,,FONT:bold,CHARSET:ANSI)
         STRING(@S7),AT(5969,750),USE(ATVERTA,,?ATVERTA:2),TRN,LEFT,FONT(,20,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(615,1990,4396,188),USE(par:nos_p),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1271,2500,4552,156),USE(PASTA_ADRESE),TRN,LEFT
         STRING(@s60),AT(1458,2271,4552,156),USE(Par:ADRESE),TRN,LEFT
         STRING(@S22),AT(1510,2781,1802,156),USE(PAR:NMR_KODS),TRN,CENTER
         STRING(@S22),AT(5292,2781,1708,156),USE(PAR:PVN),TRN,LEFT
         STRING(@S80),AT(1646,3042,5875,156),USE(PAR_BAN),TRN,LEFT(1)
         STRING(@s35),AT(1427,3292,2563,156),USE(PAR:EMAIL,,?PAR:EMAIL:2),TRN,LEFT
         STRING(@s40),AT(2594,3552,3031,156),USE(PAR_KONTAKTS),TRN,LEFT
       END
LAPA1A4 DETAIL,AT(,,,5115),USE(?LAPA1A4)
         STRING(@n_4B),AT(5135,667),USE(PAR:KARTE,,?PAR:KARTE:A),TRN,FONT(,20,,FONT:bold,CHARSET:ANSI)
         STRING(@S7),AT(5938,667),USE(ATVERTA),TRN,LEFT,FONT(,20,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(615,1990,4396,188),USE(par:nos_p,,?par:nos_p:A),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1271,2500,4552,156),USE(PASTA_ADRESE,,?PASTA_ADRESE:A),TRN,LEFT
         STRING(@s60),AT(1458,2271,4552,156),USE(Par:ADRESE,,?Par:ADRESE:A),TRN,LEFT
         STRING(@S22),AT(1510,2781,1802,156),USE(PAR:NMR_KODS,,?PAR:NMR_KODS:A),TRN,CENTER
         STRING(@S22),AT(5292,2781,1708,156),USE(PAR:PVN,,?PAR:PVN:A),TRN,LEFT
         STRING(@S80),AT(1646,3042,5875,156),USE(PAR_BAN,,?PAR_BAN:A),TRN,LEFT(1)
         STRING(@s35),AT(1427,3292,2563,156),USE(PAR:EMAIL,,?PAR:EMAIL:A),TRN,LEFT
         STRING(@s40),AT(2594,3552,3031,156),USE(PAR_KONTAKTS,,?PAR_KONTAKTS:A),TRN,LEFT
       END
LAPA2BL DETAIL,PAGEBEFORE(-1),AT(,,,10594),USE(?LAPA2BL)
         STRING(@d06.B),AT(802,844,781,208),USE(MAKS_DATUMS[1]),TRN,LEFT
         STRING(@n-_11.2B),AT(2000,844,781,208),USE(SummaKopa[1]),TRN,RIGHT
         STRING(@n-_11.2B),AT(3313,844,781,208),USE(SummaKopaarPVN[1]),TRN,RIGHT,FONT(,,,,CHARSET:BALTIC)
         STRING(@n-_11.2B),AT(4531,854,781,208),USE(SummaMEN[1]),TRN,RIGHT,FONT(,,,,CHARSET:BALTIC)
         STRING(@n-_11.2B),AT(5833,854,781,208),USE(SummaMENarPVN[1]),TRN,RIGHT,FONT(,,,,CHARSET:BALTIC)
         STRING(@d06.B),AT(802,1083,781,208),USE(MAKS_DATUMS[2]),TRN,LEFT
         STRING(@n-_11.2B),AT(2000,1083,781,208),USE(SummaKopa[2]),TRN,RIGHT
         STRING(@n-_11.2B),AT(3313,1083,781,208),USE(SummaKopaarPVN[2]),TRN,RIGHT
         STRING(@n-_11.2B),AT(4531,1094,781,208),USE(SummaMEN[2]),TRN,RIGHT
         STRING(@n-_11.2B),AT(5833,1094,781,208),USE(SummaMENarPVN[2]),TRN,RIGHT,FONT(,,,,CHARSET:BALTIC)
         STRING(@d06.B),AT(802,1333,781,208),USE(MAKS_DATUMS[3],,?MAKS_DATUMS_3:2),TRN,LEFT
         STRING(@n-_11.2B),AT(2000,1333,781,208),USE(SummaKopa[3]),TRN,RIGHT
         STRING(@n-_11.2B),AT(3313,1333,781,208),USE(SummaKopaarPVN[3]),TRN,RIGHT
         STRING(@n-_11.2B),AT(4531,1344,781,208),USE(SummaMEN[3]),TRN,RIGHT
         STRING(@n-_11.2B),AT(5833,1344,781,208),USE(SummaMENarPVN[3]),TRN,RIGHT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S100),AT(333,4708,4885,208),USE(PAPL_NOLIK[1]),TRN,LEFT
         STRING(@S2),AT(5031,6302),USE(DSL_FP[1]),TRN,LEFT
         STRING(@S12),AT(5385,6302,896,208),USE(LICENCES_DATUMS[1,6]),TRN,LEFT
         STRING(@S30),AT(1333,6292,1177,198),USE(CODE39P[1,4],,?CODE39P_1_4:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3802,6750,1177,198),USE(CODE39P[3,5],,?CODE39P_3_5:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S30),AT(6313,6750,1177,198),USE(CODE39P[3,6],,?CODE39P_3_6:3),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S2),AT(2552,6302),USE(DSL_LA[1],,?DSL_LA_1:2),TRN,LEFT
         STRING(@S2),AT(5052,3083),USE(DSL_ALGA[1]),TRN
         STRING(@S12),AT(5385,3083,896,208),USE(LICENCES_DATUMS[1,2]),TRN,LEFT
         STRING(@S30),AT(6323,3073,1177,198),USE(CODE39P[1,2],,?CODE39P_1_2:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3688,3063,1177,198),USE(CODE39P[1,1],,?CODE39P_1_1:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S25),AT(396,3073,1854,208),USE(PAPL_BASE[1]),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(52,6302),USE(DSL_PL[1],,?DSL_PL_1:2),TRN,LEFT
         STRING(@S12),AT(417,6302,896,208),USE(LICENCES_DATUMS[1,4],,?LICENCES_DATUMS_1:2),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(5031,6531),USE(DSL_FP[2]),TRN,LEFT
         STRING(@S12),AT(5385,6531,896,208),USE(LICENCES_DATUMS[2,6]),TRN,LEFT
         STRING(@S30),AT(1333,6521,1177,198),USE(CODE39P[2,4]),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S2),AT(2552,6531),USE(DSL_LA[2],,?DSL_LA_2),TRN,LEFT
         STRING(@S2),AT(5052,3333),USE(DSL_ALGA[2]),TRN
         STRING(@S12),AT(5385,3333,896,208),USE(LICENCES_DATUMS[2,2]),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S30),AT(6333,3323,1177,198),USE(CODE39P[2,2],,?CODE39P_2_2:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3688,3323,1177,198),USE(CODE39P[2,1],,?CODE39P_2_1:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S25),AT(396,3333,1854,208),USE(PAPL_BASE[2]),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(52,6531),USE(DSL_PL[2],,?DSL_PL_2:2),TRN,LEFT
         STRING(@S12),AT(417,6531,896,208),USE(LICENCES_DATUMS[2,4],,?LICENCES_DATUMS_2:4),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(5031,6760),USE(DSL_FP[3],,?DSL_FP_3:2),TRN,LEFT
         STRING(@S30),AT(1333,6781,1177,198),USE(CODE39P[3,4]),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S12),AT(5385,6760,896,208),USE(LICENCES_DATUMS[3,6],,?LICENCES_DATUMS_3_6:2),TRN,LEFT
         STRING(@s75),AT(1052,7333,5615,208),USE(ATVERTA_TEXT,,?ATVERTA_TEXT:2),TRN,LEFT(1)
         STRING(@s40),AT(2177,7760,2833,208),USE(PAR_ZIM_VUT),TRN,RIGHT(1)
         STRING(@S2),AT(2552,6760),USE(DSL_LA[3],,?DSL_LA_3:2),TRN,LEFT
         STRING(@s20),AT(4896,8656),USE(sys_paraksts),TRN
         STRING(@D06.B),AT(6427,8656,781,208),USE(LICENCES_IZ_DATUMS,,?LICENCES_IZ_DATUMS:2),TRN,LEFT
         STRING(@s30),AT(583,9656,3688,313),USE(CODE39,,?CODE39:2),TRN,LEFT(1),FONT('Code 3 de 9',20,,,CHARSET:SYMBOL)
         STRING(@s45),AT(1625,9969,2885,188),USE(par:nos_p,,?par:nos_p:3),TRN,LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('Licences îpaðnieks :'),AT(573,9969,1063,188),USE(?LICENCE:2),TRN,LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S2),AT(5052,3594),USE(DSL_ALGA[3]),TRN
         STRING(@S12),AT(5385,3594,896,208),USE(LICENCES_DATUMS[3,2],,?LICENCES_DATUMS_3_2:2),TRN,LEFT, |
             FONT(,,,,CHARSET:BALTIC)
         STRING(@S30),AT(6333,3583,1177,198),USE(CODE39P[3,2],,?CODE39P_3_2:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3688,3583,1177,198),USE(CODE39P[3,1],,?CODE39P_3_1:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S25),AT(396,3594,1854,208),USE(PAPL_BASE[3]),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(52,6760),USE(DSL_PL[3],,?DSL_PL_3:2),TRN,LEFT
         STRING(@S12),AT(427,6760,896,208),USE(LICENCES_DATUMS[3,4],,?LICENCES_DATUMS_3:2),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(63,3073),USE(DSL_BASE[1],,?DSL_BASE_1:2),TRN,LEFT
         STRING(@S12),AT(2302,3073,896,208),USE(LICENCES_DATUMS[1,1]),TRN,LEFT
         STRING(@S2),AT(73,4708),USE(DSL_NOLIK[1]),TRN,LEFT
         STRING(@S12),AT(5385,4708,896,208),USE(LICENCES_DATUMS[1,3]),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S30),AT(6313,4698,1177,198),USE(CODE39P[1,3],,?CODE39P_1_3:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S2),AT(63,3333),USE(DSL_BASE[2]),TRN,LEFT
         STRING(@S12),AT(2302,3333,896,208),USE(LICENCES_DATUMS[2,1]),TRN,LEFT
         STRING(@S2),AT(73,4969),USE(DSL_NOLIK[2]),TRN,LEFT
         STRING(@S100),AT(344,4958,4885,208),USE(PAPL_NOLIK[2]),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S12),AT(5385,4969,896,208),USE(LICENCES_DATUMS[2,3],,?LICENCES_DATUMS_2_3:2),TRN,LEFT, |
             FONT(,,,,CHARSET:BALTIC)
         STRING(@S30),AT(6313,4958,1177,198),USE(CODE39P[2,3],,?CODE39P_2_3:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S2),AT(63,3594),USE(DSL_BASE[3]),TRN,LEFT
         STRING(@S12),AT(2302,3594,896,208),USE(LICENCES_DATUMS[3,1]),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(73,5219),USE(DSL_NOLIK[3]),TRN,LEFT
         STRING(@S100),AT(333,5208,4885,208),USE(PAPL_NOLIK[3],,?PAPL_NOLIK_3:2),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S12),AT(5385,5229,896,208),USE(LICENCES_DATUMS[3,3],,?LICENCES_DATUMS_3_3:2),TRN,LEFT, |
             FONT(,,,,CHARSET:BALTIC)
         STRING(@S30),AT(6313,5219,1177,198),USE(CODE39P[3,3],,?CODE39P_3_3:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3802,6302,1177,198),USE(CODE39P[1,5],,?CODE39P_1_5:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S30),AT(6313,6292,1177,198),USE(CODE39P[1,6],,?CODE39P_1_6:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3802,6521,1177,198),USE(CODE39P[2,5],,?CODE39P_2_5:2),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S30),AT(6313,6521,1177,198),USE(CODE39P[2,6],,?CODE39P_2_6:3),TRN,LEFT,FONT('Code 3 de 9',12,,,CHARSET:SYMBOL)
         STRING(@S12),AT(2875,6302,896,208),USE(LICENCES_DATUMS[1,5],,?LICENCES_DATUMS_1:5),TRN,LEFT, |
             FONT(,,,FONT:regular,CHARSET:BALTIC)
         STRING(@S12),AT(2875,6531,896,208),USE(LICENCES_DATUMS[2,5],,?LICENCES_DATU5MS_2:5),TRN,LEFT, |
             FONT(,,,FONT:regular,CHARSET:BALTIC)
         STRING(@S12),AT(2875,6760,896,208),USE(LICENCES_DATUMS[3,5],,?LICENCES_DATUMS_3:5),TRN,LEFT, |
             FONT(,,,FONT:regular,CHARSET:BALTIC)
       END
LAPA2A4 DETAIL,PAGEBEFORE(-1),AT(,,,10594),USE(?LAPA2A4)
         STRING(@d06.B),AT(802,823,781,208),USE(MAKS_DATUMS[1],,?MAKS_DATUMS:A),TRN,LEFT
         STRING(@n-_11.2B),AT(2000,823,781,208),USE(SummaKopa[1],,?SummaKopa:A),TRN,RIGHT
         STRING(@n-_11.2B),AT(3250,823,781,208),USE(SummaKopaarPVN[1],,?SummaKopaarPVN:A),TRN,RIGHT,FONT(,,,,CHARSET:BALTIC)
         STRING(@n-_11.2B),AT(4469,833,781,208),USE(SummaMEN[1],,?SummaMEN:A),TRN,RIGHT,FONT(,,,,CHARSET:BALTIC)
         STRING(@n-_11.2B),AT(5771,833,781,208),USE(SummaMENarPVN[1],,?SummaMENarPVN:A),TRN,RIGHT,FONT(,,,,CHARSET:BALTIC)
         STRING(@d06.B),AT(802,1063,781,208),USE(MAKS_DATUMS[2],,?MAKS_DATUMS2:A),TRN,LEFT
         STRING(@n-_11.2B),AT(2000,1063,781,208),USE(SummaKopa[2],,?SummaKopa2:A),TRN,RIGHT
         STRING(@n-_11.2B),AT(3250,1063,781,208),USE(SummaKopaarPVN[2],,?SummaKopaarPVN2:A),TRN,RIGHT
         STRING(@n-_11.2B),AT(4469,1073,781,208),USE(SummaMEN[2],,?SummaMEN2:A),TRN,RIGHT
         STRING(@n-_11.2B),AT(5771,1073,781,208),USE(SummaMENarPVN[2],,?SummaMENarPVN2:A),TRN,RIGHT,FONT(,,,,CHARSET:BALTIC)
         STRING(@d06.B),AT(802,1313,781,208),USE(MAKS_DATUMS[3],,?MAKS_DATUMS3:A),TRN,LEFT
         STRING(@n-_11.2B),AT(2000,1313,781,208),USE(SummaKopa[3],,?SummaKopa3:A),TRN,RIGHT
         STRING(@n-_11.2B),AT(3250,1313,781,208),USE(SummaKopaarPVN[3],,?SummaKopaarPVN3:A),TRN,RIGHT
         STRING(@n-_11.2B),AT(4469,1323,781,208),USE(SummaMEN[3],,?SummaMEN3:A),TRN,RIGHT
         STRING(@n-_11.2B),AT(5771,1323,781,208),USE(SummaMENarPVN[3],,?SummaMENarPVN3:A),TRN,RIGHT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S100),AT(354,4708,4885,208),USE(PAPL_NOLIK[1],,?PAPL_NOLIK:A),TRN,LEFT
         STRING(@S2),AT(5104,6354),USE(DSL_FP[1],,?DSL_FP:A),TRN,LEFT
         STRING(@S12),AT(5458,6354,896,208),USE(LICENCES_DATUMS[1,6],,?LICENCES_DATUMS16:A),TRN,LEFT
         STRING(@S30),AT(1344,6396,1156,135),USE(CODE39P[1,4]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3927,6854,1177,135),USE(CODE39P[3,5]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S30),AT(6469,6854,1313,135),USE(CODE39P[3,6]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S2),AT(2521,6354),USE(DSL_LA[1],,?DSL_LA_1),TRN,LEFT
         STRING(@S2),AT(5042,3063),USE(DSL_ALGA[1],,?DSL_ALGA:A),TRN
         STRING(@S12),AT(5458,3063,896,208),USE(LICENCES_DATUMS[1,2],,?LICENCES_DATUMS12:A),TRN,LEFT
         STRING(@S30),AT(6469,3104,1313,135),USE(CODE39P[1,2],,?CODE39P_1_2:B2),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3760,3094,1313,135),USE(CODE39P[1,1]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S25),AT(354,3052,1854,208),USE(PAPL_BASE[1],,?PAPL_BASE:A),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(21,6354),USE(DSL_PL[1]),TRN,LEFT
         STRING(@S12),AT(396,6354,896,208),USE(LICENCES_DATUMS[1,4],,?LICENCES_DATUMS_1:B2),TRN,LEFT, |
             FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(5104,6583),USE(DSL_FP[2],,?DSL_FP2:A),TRN,LEFT
         STRING(@S12),AT(5458,6583,896,208),USE(LICENCES_DATUMS[2,6],,?LICENCES_DATUMS26:A),TRN,LEFT
         STRING(@S30),AT(1344,6625,1156,135),USE(CODE39P[2,4],,?CODE39P_2_4:2),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S2),AT(2521,6583),USE(DSL_LA[2],,?DSL_LA_2A),TRN,LEFT
         STRING(@S2),AT(5042,3313),USE(DSL_ALGA[2],,?DSL_ALGA2:A),TRN
         STRING(@S12),AT(5458,3313,896,208),USE(LICENCES_DATUMS[2,2],,?LICENCES_DATUMS22:A),TRN,LEFT, |
             FONT(,,,,CHARSET:BALTIC)
         STRING(@S30),AT(6479,3354,1313,135),USE(CODE39P[2,2]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3760,3354,1313,135),USE(CODE39P[2,1]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S25),AT(354,3313,1854,208),USE(PAPL_BASE[2],,?PAPL_BASE2:A),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(21,6583),USE(DSL_PL[2]),TRN,LEFT
         STRING(@S12),AT(396,6583,896,208),USE(LICENCES_DATUMS[2,4],,?LICENCES_DATUMS_2:B4),TRN,LEFT, |
             FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(5104,6813),USE(DSL_FP[3]),TRN,LEFT
         STRING(@S30),AT(1344,6854,1156,135),USE(CODE39P[3,4],,?CODE39P_3_4:2),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S12),AT(5458,6813,896,208),USE(LICENCES_DATUMS[3,6]),TRN,LEFT
         STRING(@s75),AT(1021,7427,5615,208),USE(ATVERTA_TEXT),TRN,FONT(,,,,CHARSET:BALTIC)
         STRING(@s40),AT(2552,7823,2833,208),USE(PAR_ZIM_VUT,,?PAR_ZIM_VUT:3),TRN,RIGHT
         STRING(@S2),AT(2521,6813),USE(DSL_LA[3],,?DSL_LA_3),TRN,LEFT
         STRING(@s20),AT(4896,8781),USE(sys_paraksts,,?sys_paraksts:A),TRN,FONT(,,,,CHARSET:BALTIC)
         STRING(@D06.B),AT(6417,8781,781,208),USE(LICENCES_IZ_DATUMS),TRN,LEFT
         STRING(@s30),AT(583,9865,3688,313),USE(CODE39),TRN,LEFT(1),FONT('Code 3 de 9',20,,,CHARSET:SYMBOL)
         STRING(@s45),AT(1625,10177,2885,188),USE(par:nos_p,,?par:Bnos_p:3),TRN,LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('Licences îpaðnieks :'),AT(573,10177,1063,188),USE(?LICENCE),TRN,LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S2),AT(5042,3573),USE(DSL_ALGA[3],,?DSL_ALGA3:A),TRN
         STRING(@S12),AT(5458,3573,896,208),USE(LICENCES_DATUMS[3,2]),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S30),AT(6479,3615,1313,135),USE(CODE39P[3,2]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3760,3615,1313,135),USE(CODE39P[3,1]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S25),AT(354,3573,1854,208),USE(PAPL_BASE[3],,?PAPL_BASE3:A),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(21,6813),USE(DSL_PL[3],,?DSL_PL3:A),TRN,LEFT
         STRING(@S12),AT(406,6813,896,208),USE(LICENCES_DATUMS[3,4],,?LICENCES_DATUMS_3:B2),TRN,LEFT, |
             FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(21,3052),USE(DSL_BASE[1]),TRN,LEFT
         STRING(@S12),AT(2240,3052,896,208),USE(LICENCES_DATUMS[1,1],,?LICENCES_DATUMS11:A),TRN,LEFT
         STRING(@S2),AT(21,4708),USE(DSL_NOLIK[1],,?DSL_NOLIK:A),TRN,LEFT
         STRING(@S12),AT(5458,4708,896,208),USE(LICENCES_DATUMS[1,3],,?LICENCES_DATUMS13:A),TRN,LEFT, |
             FONT(,,,,CHARSET:BALTIC)
         STRING(@S30),AT(6479,4750,1313,135),USE(CODE39P[1,3],,?CODE39P_1_3:B2),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S2),AT(21,3313),USE(DSL_BASE[2],,?DSL_BASE2:A),TRN,LEFT
         STRING(@S12),AT(2240,3313,896,208),USE(LICENCES_DATUMS[2,1],,?LICENCES_DATUMS21:A),TRN,LEFT
         STRING(@S2),AT(21,4969),USE(DSL_NOLIK[2],,?DSL_NOLIK2:A),TRN,LEFT
         STRING(@S100),AT(354,4958,4885,208),USE(PAPL_NOLIK[2],,?PAPL_NOLIK2:A),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S12),AT(5458,4969,896,208),USE(LICENCES_DATUMS[2,3]),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S30),AT(6479,5010,1313,135),USE(CODE39P[2,3]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S2),AT(21,3573),USE(DSL_BASE[3],,?DSL_BASE3:A),TRN,LEFT
         STRING(@S12),AT(2240,3573,896,208),USE(LICENCES_DATUMS[3,1],,?LICENCES_DATUMS31:A),TRN,LEFT, |
             FONT(,,,,CHARSET:BALTIC)
         STRING(@S2),AT(21,5219),USE(DSL_NOLIK[3],,?DSL_NOLIK3:A),TRN,LEFT
         STRING(@S100),AT(354,5208,4885,208),USE(PAPL_NOLIK[3]),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S12),AT(5458,5229,896,208),USE(LICENCES_DATUMS[3,3]),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S30),AT(6479,5271,1313,135),USE(CODE39P[3,3]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3927,6396,1177,135),USE(CODE39P[1,5]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S30),AT(6469,6396,1313,135),USE(CODE39P[1,6]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S30),AT(3927,6625,1177,135),USE(CODE39P[2,5]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S30),AT(6469,6625,1313,135),USE(CODE39P[2,6]),TRN,LEFT,FONT('Code 3 de 9',8,,,CHARSET:SYMBOL)
         STRING(@S12),AT(2875,6354,896,208),USE(LICENCES_DATUMS[1,5],,?LICENCES_DATUMS_1:B5),TRN,LEFT, |
             FONT(,,,FONT:regular,CHARSET:BALTIC)
         STRING(@S12),AT(2875,6583,896,208),USE(LICENCES_DATUMS[2,5],,?LICENCES_DATU5MS_2:B5),TRN,LEFT, |
             FONT(,,,FONT:regular,CHARSET:BALTIC)
         STRING(@S12),AT(2875,6813,896,208),USE(LICENCES_DATUMS[3,5],,?LICENCES_DATUMS_3:B5),TRN,LEFT, |
             FONT(,,,FONT:regular,CHARSET:BALTIC)
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

window WINDOW('Licences sagatavoðana'),AT(,,175,115),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC), |
         CENTER,GRAY
       OPTION('Paraksts:'),AT(14,11,59,67),USE(sys_paraksts_nr),BOXED
         RADIO('Nav'),AT(17,22,37,10),USE(?sys_paraksts_nr:OPTION0),VALUE('0')
         RADIO('1.paraksts'),AT(17,31,47,10),USE(?sys_paraksts_nr:OPTION1),VALUE('1')
         RADIO('2.paraksts'),AT(17,40,45,10),USE(?sys_paraksts_nr:OPTION2),VALUE('2')
         RADIO('3.paraksts'),AT(17,50,45,10),USE(?sys_paraksts_nr:OPTION3),VALUE('3')
         RADIO('Login'),AT(17,60,45,10),USE(?sys_paraksts_nr:OPTION4),VALUE('4')
       END
       OPTION('Izdrukas formâts:'),AT(81,11,68,49),USE(OPC),BOXED
         RADIO('Rekvizîti'),AT(86,22),USE(?Opc:Radio1),VALUE('1')
         RADIO('Licence'),AT(86,33),USE(?Opc:Radio2),DISABLE,VALUE('2')
         RADIO('Licence A4'),AT(86,44),USE(?Opc:Radio3),DISABLE,VALUE('3')
       END
       BUTTON('D&rukas parametri'),AT(88,67,78,14),USE(?Button:DRUKA),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
       BUTTON('&OK'),AT(88,86,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(130,86,36,14),USE(?CancelButton)
     END

!detail1OLD DETAIL,PAGEBEFORE(-1),AT(,,,10594),USE(?unnamed:2O)
!         STRING(@d06.B),AT(802,1531,781,208),USE(MAKS_DATUMS),LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
!         STRING(@n-_11.2),AT(2000,1531,781,208),USE(SummaKopa),RIGHT
!         STRING(@n-_11.2),AT(3219,1531,781,208),USE(SummaKopaarPVN),TRN,RIGHT
!         STRING(@n-_11.2),AT(4438,1531,781,208),USE(SummaMEN),TRN,RIGHT
!         STRING(@n-_11.2),AT(5563,1531,781,208),USE(SummaMENarPVN),TRN,RIGHT
!         STRING(@d06.B),AT(802,1740,781,208),USE(MAKSDATUMS2),LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
!         STRING(@n-_11.2B),AT(2000,1740,781,208),USE(SummaKopa2),RIGHT
!         STRING(@n-_11.2B),AT(3219,1740,781,208),USE(SummaKopaarPVN2),TRN,RIGHT
!         STRING(@n-_11.2B),AT(4438,1740,781,208),USE(SummaMEN2),TRN,RIGHT
!         STRING(@n-_11.2B),AT(5563,1740,781,208),USE(SummaMENarPVN2),TRN,RIGHT
!         STRING(@S47),AT(2635,3740,2250,208),USE(PAPL_NOLIK),TRN,LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
!         STRING(@N2B),AT(344,5240),USE(DSL_FP),TRN,FONT(,,,FONT:regular,CHARSET:ANSI)
!         STRING(@d06.B),AT(625,5240,781,208),USE(DATUMS_FP,,?DATUMS_FP:2),TRN,LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
!         STRING(@N2B),AT(2427,5240),USE(DSL_ALGA),TRN,FONT(,,,FONT:regular,CHARSET:ANSI)
!         STRING(@d06.B),AT(2698,5240,781,208),USE(DATUMS_ALGA),TRN,LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
!         STRING(@N2B),AT(4688,5240),USE(DSL_PL),TRN,FONT(,,,FONT:regular,CHARSET:ANSI)
!         STRING(@d06.B),AT(4969,5240,781,208),USE(DATUMS_PL),TRN,LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
!         STRING(@S100),AT(344,10010,7375,208),USE(atverta_text),TRN,LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
!         STRING(@N1B),AT(2573,8448),USE(GADS1),TRN,FONT(,,,FONT:regular,CHARSET:ANSI)
!         STRING(@N2B),AT(2917,8448),USE(DATUMS1),TRN,FONT(,,,FONT:regular,CHARSET:ANSI)
!         STRING(@S10),AT(3260,8458),USE(MENESIS_V),TRN,FONT(,,,FONT:regular,CHARSET:BALTIC)
!         STRING(@N2B),AT(354,3740),USE(DSL_BASE,,?DSL_BASE:2),TRN,FONT(,,,FONT:regular,CHARSET:ANSI)
!         STRING(@d06.B),AT(625,3740,781,208),USE(DATUMS_BASE,,?DATUMS_BASE:2),TRN,LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
!         STRING(@N2B),AT(2427,3740),USE(DSL_NOLIK),TRN,FONT(,,,FONT:regular,CHARSET:ANSI)
!         STRING(@d06.B),AT(4969,3740,781,208),USE(DATUMS_NOLIK),TRN,LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
!         STRING(@s25),AT(1365,8750),USE(SYS_PARAKSTS),TRN,LEFT
!       END

  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  checkopen(system,1)

  CHECKOPEN(GLOBAL,1)
  IF GGK::USED=0
     checkopen(ggk,1)
  .

  FilesOpened = True
  RecordsToProcess = 50
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0


!************************************** DATU LOGS*************
  OPEN(window) !paraksti&DRUKA&REKV/LICENCE
  WindowOpened=True
  IF ACC_KODS_N=0  !ASSAKO
     ENABLE(?Opc:Radio2)
     ENABLE(?Opc:Radio3)
     OPC=3
  ELSE
     OPC=1
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      DISPLAY()
      SELECT(?OkButton)
    OF EVENT:GainFocus
      DISPLAY()
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?SYS_PARAKSTS_NR  !AMATS,PARAKSTS
      CASE EVENT()
      OF EVENT:Accepted
         DO FILLPARAKSTI
         display()
      .
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
       LocalResponse = RequestCompleted
       BREAK
       END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
         DO PROCEDURERETURN
      END
    END
  END
  CLOSE(WINDOW)
  IF LocalResponse = RequestCompleted
    OPEN(Report)
    Report{Prop:Preview} = PrintPreviewImage
    IF PAR:KARTE
       VARDS=CLIP(PAR:KARTE)&'-L'
    ELSE
       VARDS=CLIP(INIGEN(PAR:NOS_S,8,1))&' '&CLIP(PAR:U_NR)
    .
    Report{Prop:Text} = CLIP(VARDS)&'XXXX'  ! DOCFOLDERP- PRIMO ATCERAS PÇDÇJO
    PASTA_ADRESE=GETPAR_ADRESE(PAR:U_NR,255,0,0) !Ja nav citu,atgrieþ par:adrese,JA IR IZSAUC BROWSI
    IF  PASTA_ADRESE=PAR:ADRESE THEN PASTA_ADRESE=''.
    PAR_BAN=CLIP(PAR:BAN_NR)&' '&Getbankas_k(PAR:BAN_KODS,0,1)
    DO FILLPARAKSTI !Sâkums...TIEKAM GALÂ AR PARAKSTU DATIEM
    PAR_KONTAKTS=CLIP(PAR:KONTAKTS)&' '&PAR:TEL
    CASE OPC
    OF 1
       PRINT(RPT:DETAILR)  !REKVIZÎTI
    ELSE                   !LICENCE
       IF PAR:GRUPA[2]='A'      !Atvçrtâ Licence
          ATVERTA='Atvçrtâ'
       .
       IF OPC=3            !A4 LAPA
          SETTARGET(REPORT,?LAPA1A4)
          IMAGE(-450,-550,8400,12000,'\WINLATS\BIN\LA.BMP')
          PRINT(RPT:LAPA1A4) !LICENCE-AVERSS
       ELSE
          PRINT(RPT:LAPA1BL) !LICENCE-AVERSS
       .
       CHECKOPEN(PAR_L,1)
       CLEAR(PAL:RECORD)
       PAL:PAR_NR=PAR:U_NR
       SET(PAL:NR_KEY,PAL:NR_KEY)
       LOOP
          NEXT(PAR_L)
          IF ERROR() OR ~(PAL:PAR_NR=PAR:U_NR) THEN BREAK.
          IF PAL:KOR THEN CYCLE. !NEKORESPONDÇ AR NOKLUSÇTO
          P:L_DATUMS =PAL:L_DATUMS
          P:LIGUMS   =PAL:LIGUMS
          P:L_CDATUMS=PAL:L_CDATUMS
          P:L_SUMMA  =PAL:L_SUMMA
          P:L_SUMMA1 =PAL:L_SUMMA1
          ADD(P_TABLE)
       .
       P:L_DATUMS =PAR:L_DATUMS
       P:LIGUMS   =PAR:LIGUMS
       P:L_CDATUMS=PAR:L_CDATUMS
       P:L_SUMMA  =PAR:L_SUMMA
       P:L_SUMMA1 =PAR:L_SUMMA1
       ADD(P_TABLE)
       SORT(P_TABLE,P:L_DATUMS)
       CTRL#=VAL(CODE39[1])+PAR:KARTE+VAL(PAR:NOS_S[1])
       CODE39=GETPARAKSTI(SYS_PARAKSTS_NR,3,CTRL#)
       LOOP L#=1 TO RECORDS(P_TABLE) !MAX 4 UZ BLANKAS
          GET(P_TABLE,L#)
          IF ~INRANGE(P:L_DATUMS,DATE(1,1,1990),DATE(1,1,2020)) THEN CYCLE. !NAV LICENCES RINDA
          WLC=CALCWL(P:L_DATUMS,P:LIGUMS,2)
          J#+=1  !DRUKÂJAMÂS RINDAS Nr
          IF J#>4
             KLUDA(0,'Licences rindu skaits > 4')
             BREAK
          .
          IF ~WLC THEN CYCLE.  !NEDRUKÂJAMA LICENCES RINDA
          IF SYS_PARAKSTS AND ~LICENCES_IZ_DATUMS
             LICENCES_IZ_DATUMS=P:L_DATUMS
          .
          LICENCES_DAT[J#]=P:L_DATUMS
          MAKS_DATUMS[J#]=P:L_CDATUMS !JÂSÂK MAKSÂT
          IF P:L_SUMMA
             SUMMAKOPA[J#]=P:L_SUMMA  !VAR BÛT CITÂDÂKA
          ELSE
             SUMMAKOPA[J#]=SUMMA   !NO CALCWL
          .
          IF PAR:GRUPA[2]='A'      !Atvçrtâ Licence
             ATVERTA_TEXT='Ar programmatûru atïauts sniegt grâmatvedîbas pakalpojumus.'
             PAR_ZIM_VUT='Paraksts un zîmogs: '&CLIP(sys_paraksts)
          ELSIF PAR:ATLAIDE<=100   !Pastâvîga atlaide
             ATVERTA_TEXT='Pastâvîga pçcgarantijas apkalpoðanas atlaide '&CLIP(PAR:ATLAIDE)&'% no 2011.g.II cet.'
          .
          IF P:L_SUMMA1
             SUMMAMEN[J#] = P:L_SUMMA1 !VAR BÛT CITÂDÂKA
          ELSE
             SUMMAMEN[J#] = SUMMAKOPA[J#]/100*2 !2%
          .
          SUMMAKOPAarPVN[J#] = SUMMAKOPA[J#]*(1+SYS:NOKL_PVN/100)
          SUMMAMENarPVN[J#] = SUMMAMEN[J#]*(1+SYS:NOKL_PVN/100)
!          DSL_BASE[J#]=DEFORMAT(WLC0102,@N02)
          DSL_BASE[J#]=WLC0102
          DSL_ALGA[J#]=WLC0607
          DSL_NOLIK[J#]=WLC0910
          DSL_PL[J#]=WLC1819
          DSL_LA[J#]=WLC2122
          DSL_FP[J#]=WLC2425

!**************************************DATUMI,PAPLAÐINÂJUMI,SUMMAS
          IF DSL_BASE[J#] !BÂZE
             LICENCES_DATUMS[J#,1]=FORMAT(LICENCES_DAT[J#],@D06.) !RINDA,MODULIS
             IF WLC4
                PAPL_BASE[J#]=CLIP(PAPL_BASE[J#])&'dienesta auto uzskaite,'
             .
             IF WLC5
                PAPL_BASE[J#]=CLIP(PAPL_BASE[J#])&'ALT kontu plâns,Budþets'
             .
             PAPL_BASE[J#]=CLIP(PAPL_BASE[J#])&'-{25}'
             CODE39P[J#,1]=CODE39
          ELSE
             DSL_BASE[J#]='--'
             LICENCES_DATUMS[J#,1]='-{12}'
             PAPL_BASE[J#]='-{25}'
          .
          IF DSL_ALGA[J#]  !ALGA
             LICENCES_DATUMS[J#,2]=FORMAT(LICENCES_DAT[J#],@D06.)
             CODE39P[J#,2]=CODE39
          ELSE
             DSL_ALGA[J#]='--'
             LICENCES_DATUMS[J#,2]='-{12}'
          .
          IF DSL_NOLIK[J#] !NOLIKTAVA
             LICENCES_DATUMS[J#,3]=FORMAT(LICENCES_DAT[J#],@D06.)
             IF WLC12
                PAPL_NOLIK[J#]=CLIP(PAPL_NOLIK[J#])&'kases aparâta Lasîðana/Rakstîðana,'
             .
             IF WLC13
                PAPL_NOLIK[J#]=CLIP(PAPL_NOLIK[J#])&'a-serviss,'
             .
             IF WLC14
                PAPL_NOLIK[J#]=CLIP(PAPL_NOLIK[J#])&'pasûtîjumi(stat.),'
             .
             IF WLC15
                PAPL_NOLIK[J#]=CLIP(PAPL_NOLIK[J#])&'aptieka,'
             .
             IF WLC16
                PAPL_NOLIK[J#]=CLIP(PAPL_NOLIK[J#])&'komplektâcija,'
             .
             IF WLC17
                PAPL_NOLIK[J#]=CLIP(PAPL_NOLIK[J#])&'i-veikals,'
             .
             PAPL_NOLIK[J#]=CLIP(PAPL_NOLIK[J#])&'-{100}'
             CODE39P[J#,3]=CODE39
          ELSE
             DSL_NOLIK[J#]='--'
             LICENCES_DATUMS[J#,3]='-{12}'
             PAPL_NOLIK[J#]='-{100}'
          .
          IF DSL_PL[J#]  !PAMATLÎDZEKÏI
             LICENCES_DATUMS[J#,4]=FORMAT(LICENCES_DAT[J#],@D06.)
             CODE39P[J#,4]=CODE39
          ELSE
             DSL_PL[J#]='--'
             LICENCES_DATUMS[J#,4]='-{12}'
          .
          IF DSL_LA[J#]  !LAIKA UZSKAITE
             LICENCES_DATUMS[J#,5]=FORMAT(LICENCES_DAT[J#],@D06.)
             CODE39P[J#,5]=CODE39
          ELSE
             DSL_LA[J#]='--'
             LICENCES_DATUMS[J#,5]='-{12}'
          .
          IF DSL_FP[J#] !FISKÂLÂ DRUKA
             LICENCES_DATUMS[J#,6]=FORMAT(LICENCES_DAT[J#],@D06.)
             CODE39P[J#,6]=CODE39
          ELSE
             DSL_FP[J#]='--'
             LICENCES_DATUMS[J#,6]='-{12}'
          .
       . !L#=4,3,2,1
       IF OPC=3            !A4 LAPA
          SETTARGET(REPORT,?LAPA2A4)
          IF PAR:GRUPA[2]='A'      !Atvçrtâ Licence
             IMAGE(-450,-550,8400,12000,'\WINLATS\BIN\LR2.BMP')
          ELSE
             IMAGE(-450,-550,8400,12000,'\WINLATS\BIN\LR1.BMP')
          .
          PRINT(RPT:LAPA2A4)
       ELSE
          PRINT(RPT:LAPA2BL)
       .
       IF ~PAR:L_SUMMA
          PAR:L_SUMMA=SUMMAMEN[J#] !PÇDÇJÂ RINDIÒA
          IF RIUPDATE:PAR_K()
             KLUDA(24,'PAR_K')
          .
       .
    .
    ENDPAGE(Report)
    PR:SKAITS=1
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
    .
  .
  CLOSE(Report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
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
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(P_TABLE)
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

FILLPARAKSTI ROUTINE        !SÂKUMS & BUTTON:MAKARONI & OK.
  SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)
  DISPLAY

IZZFILTF PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
par_filtrs           STRING(1)
SAV_PAR_FILTRS       STRING(1)
PAR_NOS_S            STRING(20)
GADS1                DECIMAL(4)
GADS2                DECIMAL(4)
List1:Queue          QUEUE,PRE()
Avots1               STRING(20)
                     END
List2:Queue          QUEUE,PRE()
Avots2               STRING(20)
                     END
window               WINDOW('Druka'),AT(,,220,70),CENTER,IMM,GRAY,MDI
                       BUTTON('&Ignorçt arhîvu un rezervçtos'),AT(90,7,103,14),USE(?ButtonIgnoret),HIDE
                       IMAGE('CHECK2.ICO'),AT(196,4,15,18),USE(?ImageIgnoret),HIDE
                       BUTTON('D&rukas parametri'),AT(132,26,79,14),USE(?ButtonDruka),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
                       OPTION('Izdrukas &Formâts'),AT(6,20,121,24),USE(F:DBF),BOXED,HIDE
                         RADIO('WMF'),AT(11,30,30,10),USE(?F:DBF:WMF)
                         RADIO('Word'),AT(41,30),USE(?F:DBF:A),VALUE('A')
                         RADIO('Excel'),AT(76,30),USE(?F:DBF:Excel),VALUE('E')
                       END
                       BUTTON('&OK'),AT(132,46,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(172,46,39,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  !IF ~F:DBF THEN F:DBF='W'.
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  F:DBF='W'
  LOOP I#=1 TO 2
     IF OPCIJA[I#] > '0'
        EXECUTE I#
           BEGIN
              CASE OPCIJA[I#]
              OF '1'              !WMF/WORD
                 UNHIDE(?F:DBF)
                 HIDE(?F:DBF:Excel)
                 IF ~INSTRING(F:DBF,'WA') THEN F:DBF='W'.
              OF '2'              !WMF/EXCEL
                 UNHIDE(?F:DBF)
                 HIDE(?F:DBF:A)
                 IF ~INSTRING(F:DBF,'WE') THEN F:DBF='W'.
              OF '3'              !WMF/WORD/EXCEL
                 UNHIDE(?F:DBF)
                 IF ~INSTRING(F:DBF,'WAE') THEN F:DBF='W'.
              .
           .
           BEGIN
              UNHIDE(?ButtonIgnoret)
              F:NOA='1'
              UNHIDE(?ImageIgnoret)
           .
        .
     .
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?ButtonIgnoret)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?ButtonIgnoret
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         IF F:NOA='1'
            F:NOA=''
            HIDE(?ImageIgnoret)
         ELSE
            F:NOA='1'
            UNHIDE(?ImageIgnoret)
         .
         DISPLAY
      END
    OF ?ButtonDruka
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        LocalResponse = RequestCompleted
        BREAK
        DO SyncWindow
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        LOCALRESPONSE = REQUESTCANCELLED
        BREAK
        DO SyncWindow
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
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
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
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
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
