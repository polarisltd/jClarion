                     MEMBER('winlats.clw')        ! This is a MEMBER module
UPAL2 PROCEDURE


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
REZULTATS            DECIMAL(9,2)
Update::Reloop  BYTE
Update::Error   BYTE
History::ALG:Record LIKE(ALG:Record),STATIC
SAV::ALG:Record      LIKE(ALG:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the ALTAB2'),AT(,,151,79),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UPAL2'),SYSTEM,GRAY,RESIZE,MDI
                       PROMPT('REZULT�TS:'),AT(20,20,45,12),USE(?REZULTATS:Prompt)
                       ENTRY(@n-13.2),AT(70,20),USE(REZULTATS)
                       BUTTON('&OK'),AT(3,53,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(55,53,45,14),USE(?Cancel)
                       BUTTON('&Help'),AT(106,53,45,14),USE(?Help),STD(STD:Help)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  CLEAR(KAD:RECORD)
  KAD:ID = ALG:ID
  GET(KADRI,KAD:ID_KEY)
  IF ERROR()
  !?    KLUDA(59,ALG:ID)
  END
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  IF DAIKODS < 900
      LOOP I#=1 TO 20
          IF ALG:K[I#]=DAIKODS
              REZULTATS = ALG:R[I#]
              BREAK
          .
      .
  ELSE
      LOOP I#=1 TO 15
          IF ALG:I[I#] = DAIKODS
              REZULTATS = ALG:N[I#]
              BREAK
          .
      .
  .
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks main�ts'
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
      SELECT(?REZULTATS:Prompt)
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
        History::ALG:Record = ALG:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(ALGAS)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(ALG:ID_KEY)
              IF StandardWarning(Warn:DuplicateKey,'ALG:ID_KEY')
                SELECT(?REZULTATS:Prompt)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?REZULTATS:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::ALG:Record <> ALG:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:ALGAS(1)
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
              SELECT(?REZULTATS:Prompt)
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
        IF DAIKODS < 900
            ALG:R[I#] = REZULTATS
            ALG:L[I#] = 1
            CALCALGAS
        ELSE
            ALG:N[I#] = REZULTATS
            ALG:J[I#] = 1
            ALG:IZMAKSAT = SUM(11)
        END
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
    OF ?Help
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  FilesOpened = True
  RISnap:ALGAS
  SAV::ALG:Record = ALG:Record
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
        IF RIDelete:ALGAS()
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
  INIRestoreWindow('UPAL2','winlats.INI')
  WinResize.Resize
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
  END
  IF WindowOpened
    INISaveWindow('UPAL2','winlats.INI')
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
  ALG:Record = SAV::ALG:Record
  SAV::ALG:Record = ALG:Record
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
  TBarBrwHelp{PROP:Disable}=?Help{PROP:Disable}
  DISPLAY(TBarBrwFirst,TBarBrwLast)

CALCSTUNDAS          FUNCTION (YYYYMM,KAD_ID,ATV,SLI,RET) ! Declare Procedure
CAL_STUNDAS    STRING(1)
KALSTUNDAS     BYTE
KALDD          BYTE
KALXY          BYTE
KALDDSE        BYTE
KALDDSESV      BYTE
XSTUNDAS       BYTE
KSTUNDAS       BYTE
XDIENAS        BYTE
KDIENAS        BYTE
GRASTUNDAS     decimal(4,1)  !31/03/2015
GRA_STUNDAS    decimal(4,1)  !31/03/2015
GRA_KSTUNDAS   decimal(4,1)  !31/03/2015
GRA_XSTUNDAS   decimal(4,1)  !31/03/2015


X_TABLE  QUEUE,PRE(X)
DATUMS  LONG
PAZIME  STRING(1)
         .
  CODE                                            ! Begin processed code
!   ATV  1-NORAUJ NOST ATVA�IN�JUMA GABALU
!   SLI  1-NORAUJ NOST SLIM�BAS GABALU
!        2-NORAUJ NOST TIKAI B_LAPAS GABALU
!
!   RET  1- KALEND�R�S STUNDAS YYYYMM
!        2- ATGRIE� KALEND�RA DARBA DIENAS KALDD
!        3- ATGRIE� KALEND�RA DARBA DIENAS+SESTDIENAS KALDDSE
!        4- ATGRIE� NOSTR�D�T�S STUNDAS (KALEND�R�S STUNDAS-KADRU,SLILAPU,ATV STUNDAS)
!        5- ATGRIE� DDIENAS+SE P�RKL�JUMA APGABAL�[S_DAT:B_DAT]
!        6- ATGRIE� KALEND�R�S DIENAS KALDDSESV -KADRU DIENAS
!        7- ATGRIE� B_LAPAS DIENAS, KUR IR KADRU DIENAS
!        8- ATGRIE� KALEND�R�S DIENAS KALDDSESV
!        9- ATGRIE� KALEND�R�S DIENAS KALDDSESV -KADRU DIENAS -B_LAPAS DIENAS
!       10- ATGRIE� SV�TKU DIENAS (KALEND�R�S SV.D darba dien�s,JA BIJU�AS DARBA ATTIEC�BAS UN NAV SLIMOJIS)
!       11- ATGRIE� NOSTR�D�T�S STUNDAS PEC GRAFIKA (STUNDAS PEC GRAFIKA-KADRU,SLILAPU,ATV STUNDAS) PEC GRAFIKA
!
!
!       KAD_ID=0 NEAPGRAIZ�T P�C KADRU S_B
!

 CHECKOPEN(CAL,1)
 S# = DATE(MONTH(YYYYMM),1,YEAR(YYYYMM))
 B# = DATE(MONTH(YYYYMM)+1,1,YEAR(YYYYMM))-1

 IF KAD_ID                       ! VAJAG ANAL�ZI P�C KADRIEM
    IF ~GETKADRI(KAD_ID,2,1) THEN RETURN(0).
    IF ~KAD:D_GR_END THEN KAD:D_GR_END=109211.  ! 31/12/2099
!    CLEAR(RIK:RECORD) TAM 40/50 VIENALGA AR 0 VID�JO J�B�T ATVA�IN�JUMOS.....
!    RIK:ID=KAD_ID
!    LOOP
!       NEXT(KAD_RIK)
!       IF ERROR() OR ~(RIK:ID=KAD_ID) THEN BREAK.
!       IF RIK:Z_KODS=40 OR RIK:Z_KODS=50     !B�RNU,BEZALGAS ATVA�IN�JUMS
!          S4050=RIK:DATUMS
!       ELSIF RIK:Z_KODS=41 OR RIK:Z_KODS=51  !BEIDZAS B�RNU,BEZALGAS ATVA�IN�JUMS
!          B4050=RIK:DATUMS
!       .
!    .
!    IF S4050 AND ~B4050 THEN B4050=109211.  ! 31/12/2099
 .
 IF ATV OR SLI                   ! ANALIZ�T ATVA�IN�JUMUS UN (vai) SLILAPAS
    CHECKOPEN(PERNOS,1)
    CLEAR(PER:RECORD)
    PER:ID=KAD_ID
    SET(PER:ID_KEY,PER:ID_KEY)
    LOOP
       NEXT(PERNOS)
       IF ERROR() OR ~(PER:ID=KAD_ID) THEN BREAK.
       IF (SLI=1 AND PER:PAZIME='S') OR|
          (SLI=2 AND PER:PAZIME='S') OR|
          (ATV=1 AND PER:PAZIME='A')
          LOOP X# = PER:SAK_DAT TO PER:BEI_DAT
             IF SLI=2 AND PER:PAZIME='S' AND (X# < PER:SAK_DAT+per:A_DIENAS) THEN CYCLE. !SKAITAM TIKAI B_DIENAS
             IF INRANGE(X#,S#,B#)
                X:DATUMS=X#
                X:PAZIME=PER:PAZIME
                GET(X_TABLE,X:DATUMS)
                IF ERROR()
                   ADD(X_TABLE)
                   SORT(X_TABLE,X:DATUMS)
                .
             .
          .
       .
    .
 .
 LOOP I#= S# TO B#
!    IF INRANGE(I#,S4050,B4050) THEN CYCLE.
    KALDDSESV+=1
    Cal_stundas=GETCAL(I#)
    IF INSTRING(CAL_STUNDAS,'012345678')
       KALSTUNDAS+=CAL_STUNDAS
       KALDD+=1
       KALDDSE+=1
    .
    IF CAL_STUNDAS='S'
       KALDDSE+=1
    .

    IF KAD_ID
       !31/07/2015 <
       IF RET = 11
          GRA_STUNDAS = 0
          GRA_STUNDAS = GETGRA(I#, KAD_ID)
          GRASTUNDAS+=GRA_STUNDAS
       .
       !31/07/2015 >

       IF INRANGE(I#,KAD:DARBA_GR,KAD:D_GR_END)  ! VISP�R IR BIJU�AS DARBA ATTIEC�BAS
          IF INSTRING(CAL_STUNDAS,'X')  !SV�TKU DIENAS DARBA DIEN�S,KAD NAV SLIMOJIS
             X:DATUMS=I#
             X:PAZIME=''
             GET(X_TABLE,X:DATUMS)
             IF ~X:PAZIME='S'
                KALXY+=1
             .
          .
          IF ATV OR SLI
             X:DATUMS=I#
             GET(X_TABLE,X:DATUMS)
             IF ~ERROR()                             ! SLIMOJIS VAI BIJIS ATVA�IN�JUM� (4)
                IF INSTRING(CAL_STUNDAS,'012345678') ! VAI SLIMOJIS B_APGABAL� (7)
                   XSTUNDAS+=CAL_STUNDAS             ! VAI SLIMOJIS (10)
                .
                GRA_XSTUNDAS+= GRA_STUNDAS !31/07/2015
                XDIENAS+=1                           ! VISAS DIENAS, KAD SLI VAI ATV
             .
          .
       ELSE                                          ! NAV BIJIS PIE�EMTS VAI IR ATLAISTS
          IF INSTRING(CAL_STUNDAS,'012345678')
              KSTUNDAS+=CAL_STUNDAS
          .
          KDIENAS+=1                                 ! VISAS DIENAS KAD ~KADRS
       .
    .
    IF RET = 5
       IF INRANGE(I#,S_DAT,B_DAT)  ! IR P�RKL�JUMS UZ S_DAT,B_DAT
          IF INRANGE(CAL_STUNDAS,0,8) OR CAL_STUNDAS='S'
             XDIENAS+=1
          .
       .
    .
 .
 FREE(X_TABLE)
! STOP(ALG:INI&' '&KALSTUNDAS&'-'&XSTUNDAS&'-'&KSTUNDAS) !4
! STOP('R:'&RET&' '&KALDDSESV&'-'&KDIENAS&'-'&XDIENAS)
! STOP('R:'&RET&' '&GRASTUNDAS&'-'&GRA_XSTUNDAS)
 EXECUTE RET
    RETURN(KALSTUNDAS)
    RETURN(KALDD)
    RETURN(KALDDSE)
    RETURN(KALSTUNDAS-XSTUNDAS-KSTUNDAS) !4
    RETURN(XDIENAS)                      !5
    RETURN(KALDDSESV-KDIENAS)            !6
    RETURN(XDIENAS)                      !7
    RETURN(KALDDSESV)                    !8
    RETURN(KALDDSESV-KDIENAS-XDIENAS)    !9
    RETURN(KALXY)                        !10
    RETURN (GRASTUNDAS-GRA_XSTUNDAS)      !11
 .

CALCALGAS            PROCEDURE                    ! Declare Procedure
SAVE_RECORD     GROUP;BYTE,DIM(SIZE(ALG:RECORD)).
SAVE_POSITION   string(256)

AP_IEN          DECIMAL(6,2)                        ! apliekamais ie��mums
AP_IENN         DECIMAL(6,2)                        ! apliekamais ie��mums N�K.M.
AP_IENAN        DECIMAL(6,2)                        ! apliekamais ie�. AIZ N�K.M.
AP_ALI          DECIMAL(6,2)                        ! apliekamais priek� alim.
SO_IEN          DECIMAL(6,2)                        ! apliekamais priek� 1%
SO_IENN         DECIMAL(6,2)                        ! apliekamais priek� 1% NM
SO_IENAN        DECIMAL(6,2)                        ! apliekamais priek� 1% ANM
P16             DECIMAL(6,2)                        ! soci�lais
P16N            DECIMAL(6,2)                        ! soci�lais NM
P16AN           DECIMAL(6,2)                        ! soci�lais ANM
P17             DECIMAL(6,2)
P18             DECIMAL(6,2)
P19             DECIMAL(6,2)
SAM_NOD         DECIMAL(6,2)                        ! agr�k samak�tie nodok�i
SAM_SOC         DECIMAL(6,2)                        ! agr�k samaks�tais socnod.
MEN             SHORT
GADSN           SHORT
MIA             DECIMAL(8,2)
ATV_BER         DECIMAL(8,2)
ATV_INV         DECIMAL(8,2)
izmaksat        decimal(8,2)
NODOKLI         decimal(8,2)
IETUREJUMI_KOPA DECIMAL(8,2)
CIPARS          decimal(8,2)
OBJSUM          decimal(8,2)                        ! OBL.SOC. IEMAKSU OBJEKTS NO GADA S�KUMA
P_K             decimal(3)
P_D             decimal(3)
P_D0            decimal(3)
P_D1            decimal(3)
P_D2            decimal(3)
P_DS            decimal(3)
P_R             DECIMAL(8,2)
P_R0            DECIMAL(8,2)
P_R1            DECIMAL(8,2)
P_R2            DECIMAL(8,2)
P_RS            DECIMAL(8,2)
I_I             decimal(3)
I_C             DECIMAL(8,2)
I_N             DECIMAL(8,2)
A_DIENASN       BYTE
A_DIENASAN      BYTE
ARGSTUNDAS      DECIMAL(9,3)
SLODZE          DECIMAL(5,3)
SLODZEK         DECIMAL(4,2)
STUNDAS         DECIMAL(4,2)


P_TABLE QUEUE,PRE(P)
K         DECIMAL(3) !NEDR�KST LIKE ALG:...
UL        BYTE       !UZ�.L�GUMS
L         BYTE
S         DECIMAL(3)
D         DECIMAL(3)
A         DECIMAL(9,3)
R         DECIMAL(9,2)
        .

I_TABLE QUEUE,PRE(I)
I         DECIMAL(3)
J         BYTE
C         DECIMAL(9,2)
N         DECIMAL(9,2)
        .


STUNDAS_NOSK   USHORT
SUMMA_VIDK     DECIMAL(8,2)
SUM_M          DECIMAL(7,2)

SAV_ID         USHORT
SAV_YYYYMM     LONG
  CODE                                            ! Begin processed code
!
!*********************P�RR��INA PIESKAIT�JUMUS, KAS IERAKST�TI ALGU FAIL�*****************************
!
   IF ALP:STAT=3 THEN RETURN. !DIVIDENDES

   LOOP I#=1 TO 20
      IF ALG:K[I#]
         P:K=ALG:K[I#]
         IF BAND(ALG:BAITS,00000001b)    !U_L�GUMS
            P:UL=1
         .
         P:L=ALG:L[I#]
         P:S=ALG:S[I#]
         P:D=ALG:D[I#]
         P:A=ALG:A[I#]
         P:R=ALG:R[I#]
         ADD(P_TABLE)
      .
   .
   SORT(P_TABLE,P:K)
   ARGSTUNDAS=0
   LOOP I#= 1 TO RECORDS(P_TABLE)
      GET(P_TABLE,I#)
      IF ~INRANGE(P:K,840,842) AND ~INRANGE(P:K,850,852) ! ~ATVA�IN�JUMS UN ~SLILAPA
         IF ~GETDAIEV(P:K,2,1)
            CYCLE
         ELSIF DAI:IENAK_VEIDS=1008 !UZ�.L�GUMS  09.06.2011
            P:UL=1
         .
         CASE DAI:F
         OF 'CAL'                    !FUNKCIJA NO DLK
            IF ~P:L                  !~LOCKED
               P:S =CALCSTUNDAS(ALG:YYYYMM,ALG:ID,1,1,4) !ALG:YYYYMM,ALG:ID-pie�/atl/R40R50,1-atva�,1-slilapa,4-nostr.stundas
               SLODZE=GETKADRI(ALG:ID,0,19,P:K)
               P:S =P:S*SLODZE
!               STOP(P:S&' '&SLODZE)
               P:D =P:S /8
               SLODZEK+=SLODZE !DIVAS 1/2 SLODZES?
!           STOP(SLODZEK&'+='&SLODZE)
            .
            IF ~(DAI:TARL=0) !�IT� IR NEPIE�AUJAMA??? ��MIJA TIPA "LATS STUND�" NO CAL...
              P:R =DAI:TARL*P:S 
            ELSE
              P:R =DAI:ALGA*P:S /CALCSTUNDAS(ALG:YYYYMM,ALG:ID,0,0,1) !1-ATGRIE� KALEND�RU
            .
         !04/08/2015
         OF 'GRA'                    !FUNKCIJA NO DLK
            IF ~P:L                  !~LOCKED
               STUNDAS =CALCSTUNDAS(ALG:YYYYMM,ALG:ID,1,1,11) !ALG:YYYYMM,ALG:ID-pie�/atl/R40R50,1-atva�,1-slilapa,4-nostr.stundas
               P:S =ROUND(STUNDAS,1)
               ARGSTUNDAS =P:S 
               P:D =CALCSTUNDAS(ALG:YYYYMM,ALG:ID,1,1,4) /8
            .
            IF ~(DAI:TARL=0) !�IT� IR NEPIE�AUJAMA??? ��MIJA TIPA "LATS STUND�" NO CAL...
              P:R =DAI:TARL*P:S 
            ELSE
              P:R =DAI:ALGA*P:S /CALCSTUNDAS(ALG:YYYYMM,ALG:ID,0,0,1) !1-ATGRIE� KALEND�RU
            .
         OF 'NAV'                    !CIETA UN NEATKAR�GA
            IF ~P:L 
!               P:S =0
!               P:D =0
               P:S =CALCSTUNDAS(ALG:YYYYMM,ALG:ID,1,1,4) !ALG:YYYYMM,ALG:ID-pie�/atl/R40R50,1-atva�,1-slilapa,4-nostr.stundas
               SLODZE=GETKADRI(ALG:ID,0,19,P:K)
!               STOP(ALG:ID&' S='&SLODZE)
               P:S =P:S*SLODZE
               P:D =P:S /8
               SLODZEK+=SLODZE
               P:R =DAI:ALGA
            .
         OF 'UZR'                    !UZ ROKAS
            IF ~P:L 
               P:S =0
               P:D =0
!               P:S =CALCSTUNDAS(ALG:YYYYMM,ALG:ID,1,1,4) !ALG:YYYYMM,ALG:ID-pie�/atl/R40R50,1-atva�,1-slilapa,4-nostr.stundas
               SLODZE=GETKADRI(ALG:ID,0,19,P:K)
               P:S =P:S*SLODZE
               P:D =P:S /8
               SLODZEK+=SLODZE
!              ALG:R[I#]=DAI:ALGA
               ATV_BER=ALP:APGADSUM*ALG:APGAD_SK
               EXECUTE ALG:INV_P
                  ATV_INV=ALP:AT_INV1
                  ATV_INV=ALP:AT_INV2
                  ATV_INV=ALP:AT_INV3
                  ATV_INV=ALP:AT_POLR
               .
               MIA=CALCNEA(1,0,0)
               P:R =(DAI:ALGA-ALP:PR_PAM/100*(ATV_INV+ATV_BER+MIA))/|
                         (1-ALG:PR1/100-ALP:PR_PAM/100*(1-ALG:PR1/100))
            .
         OF 'ARG'                    !F-JA NO PAPILDUS ARGUMENTA
            P:S =0
            P:D =0
!!            P:S =CALCSTUNDAS(ALG:YYYYMM,ALG:ID,1,1,4) !ALG:YYYYMM,ALG:ID-pie�/atl/R40R50,1-atva�,1-slilapa,4-nostr.stundas
!            SLODZE=GETKADRI(ALG:ID,0,19,P:K)
!            P:S =P:S*SLODZE
!            P:D =P:S /8
!            SLODZEK+=SLODZE
            P:R =DAI:TARL*P:A
            IF UPPER(DAI:ARG_NOS)='STUNDAS' !N_STUNDAS B�S J�SKAITA K� ARGUMENTI
               ARGSTUNDAS+=P:A
!               P:S =ARGSTUNDAS
               P:S =P:A
            .
         OF 'NOS'                    !F-JA NO PAPILDUS ARGUMENTA*STUNDAS.V�RT.
            P:A =0
            P:D =P:S /8
            P:R =DAI:ALGA*(P:S /CALCSTUNDAS(ALG:YYYYMM,ALG:ID,0,0,1))*DAI:TARL
            SLODZEK=1
         OF 'CIP'                    !F-JA NO CITU PIESK. CIPARA
            IF ~P:L 
               CIPARS=0
               P:S =0
               P:D =0
               LOOP K#=1 TO 10        ! CAURI VISAI DAIEKODULISTEI DAIFAIL�
                  LOOP J#=1 TO I#-1   ! CAURI VISAI JAU APSTR�D�TAJAI
                     GET(P_TABLE,J#)  ! DAI LISTEI ALG�S
                     IF DAI:F_DAIEREZ[K#]=P:K
                        CIPARS+=P:A   ! SKAITAM KOP� ARGUMENTUS
                                      ! (LIETOT�JA IEBAKST�TIE CIPARI)
                     .
                  .
               .
               GET(P_TABLE,I#)        !NOLIEKAM VIET�
               P:A =CIPARS
               IF ~(DAI:TARL=0)
                   P:R =CIPARS*DAI:TARL
               ELSE
                   P:R =CIPARS*DAI:PROC/100
               .
               SLODZEK=1
            .
         OF 'REZ'                    !F-JA NO CITU PIESK. REZULT�TA
            IF ~P:L 
               P:S =0
               P:D =0
               CIPARS=0
               LOOP K#=1 TO 10       ! CAURI VISAI DAICIPARULISTEI DAIFAIL�
                  LOOP J#=1 TO I#-1  ! CAURI VISAI JAU APSTR�D�TAJAI
                     GET(P_TABLE,J#) ! DAI LISTEI ALG�S
                     IF DAI:F_DAIEREZ[K#]=P:K OR DAI:F_DAIEREZ[K#]=999
                        CIPARS+=P:R  ! SKAITAM KOP� REZULT�TUS
                                     ! (ALGA PAR DAI POZ�CIJU)
                     .
                  .
               .
               GET(P_TABLE,I#)        !NOLIEKAM VIET�
               P:A =CIPARS
               IF ~(DAI:TARL=0)
                   P:R =CIPARS*DAI:TARL
               ELSE
                   P:R =CIPARS*DAI:PROC/100
               .
               SLODZEK=1
            .
         .
         PUT(P_TABLE)
      .
   .
!
!******************* SAR��INA 840,841,842 ATVA�IN�JUMAM,KO MAKS� �AJ� M�NES�
!*************************** N�KO�AJOS M�NE�OS NEB�S NEK�.....
!

  P_D0 =0
  P_R0 =0
  P_D1 =0
  P_R1 =0
  P_D2 =0
  P_R2 =0
  P_DS =0
  P_RS =0
  CHECKOPEN(PERNOS,1)
  CLEAR(PER:RECORD)
  GET(PERNOS,0)
  PER:ID       =ALG:ID
  PER:PAZIME   ='A'
  PER:YYYYMM   =ALG:YYYYMM
  SET(PER:ID_KEY,PER:ID_KEY)
  LOOP
     NEXT(PERNOS)
     IF ERROR() OR ~(PER:ID=ALG:ID AND PER:PAZIME='A' AND PER:YYYYMM=ALG:YYYYMM) THEN BREAK.
     !atva�in�jumu izmaks� �aj� m�nes�
!     IF ALG:ID=29 THEN STOP(PER:SUMMA0).
     P_D0 +=PER:DIENAS0
     P_R0 +=PER:SUMMA0
     !ATV. N�KO�AJ� M�NES�
     P_D1 +=PER:DIENAS1
     P_R1 +=PER:SUMMA1
     A_DIENASN+=PER:DIENAS1C !KALEND�R�S DIENAS N�K.M�NES�
     !ATV. AIZN�KO�AJ� M�NES�
     P_D2 +=PER:DIENAS2+PER:DIENASX
     P_R2 +=PER:SUMMA2+PER:SUMMAX
     A_DIENASAN+=PER:DIENAS2C+PER:DIENASXC
     !APMAKSA PAR SV�TKU DIEN�M
     P_DS +=PER:DIENASS
     P_RS +=PER:SUMMAS
  .
  P_K=840            !atva�in�jumu izmaks� �aj� m�nes�
  P_D=P_D0
  P_R=P_R0
  DO PERFORMP
  P_K=841            !ATV. N�KO�AJ� M�NES�
  P_D=P_D1
  P_R=P_R1
  DO PERFORMP
  P_K=842            !ATV. AIZN�KO�AJ� M�NES�
  P_D=P_D2
  P_R=P_R2
  DO PERFORMP
  P_K=880            !APMAKSA PAR SV�TKU DIEN�M
  P_D=P_DS
  P_R=P_RS
  DO PERFORMP

!
!************************ SAR��INA 850,851,852 SLILAPAS,KO MAKS� �AJ� M�NES�*******************
!
  P_D0 =0
  P_R0 =0
  P_D1 =0
  P_R1 =0
  P_D2 =0
  P_R2 =0
  P_DS =0
  P_RS =0
!  A_DIENASN=0 KALEND�R�S DIENAS N�K.M�NES� GAN ATV GAN SLILAPAI
!  A_DIENASAN=0
  CLEAR(PER:RECORD)
  GET(PERNOS,0)
  PER:ID     =ALG:ID
  PER:PAZIME='S'
  PER:YYYYMM   =ALG:YYYYMM
  SET(PER:ID_KEY,PER:ID_KEY)
  LOOP 
      NEXT(PERNOS)
      IF ERROR() OR ~(PER:ID=ALG:ID AND PER:PAZIME='S' AND PER:YYYYMM=ALG:YYYYMM) THEN BREAK.
      IF PER:SUMMA0         !SLIMOJIS �AJ� M�NES�
         P_D0 +=PER:DIENAS0
         P_R0 +=PER:SUMMA0
      .
      IF PER:SUMMA1         !SLIMOJIS PAG�JU�AJ� M�NES�
         P_D1 +=PER:DIENAS1
         P_R1 +=PER:SUMMA1
      .
      IF PER:SUMMA2         !SLIMOJIS N�KO�AJ� M�NES�
         P_D2 +=PER:DIENAS2
         P_R2 +=PER:SUMMA2
         A_DIENASN=PER:DIENAS2C !KALEND�R�S DIENAS N�K.M�NES�
      .
      IF PER:SUMMAX         !SLIMOJIS AIZ...UTT..PAG�JU�AJ� M�NES�
         P_D1 +=PER:DIENASX
         P_R1 +=PER:SUMMAX
      .
  .
  P_K=850
  P_D =P_D0
  P_R =P_R0
  DO PERFORMP
  P_K=851
  P_D =P_D1
  P_R =P_R1
  DO PERFORMP
  P_K=852
  P_D =P_D2
  P_R =P_R2
  DO PERFORMP

!
!************************ SAR��INA 880 Sv�tku dienu apmaksa*******************
!
  IF ~(ALG:YYYYMM<DATE(6,1,2002))
     P_D=CALCSTUNDAS(ALG:YYYYMM,ALG:ID,0,1,10) !sv�tku dienas darba dien�s,KAD BIJU�AS DARBA ATTIEC�BAS UN NAV SLIMOJIS
     IF P_D
        DO VID
        P_K=880
!        P_S=P_D*8
        P_R=(SUMMA_VIDK/STUNDAS_NOSK)*8*P_D*GETDAIEV(880,0,5)
        DO PERFORMP
     .
  .

!*********************************************************************
!*******************IETUR�JUMI****************************************
!*******************NODOK�I*******************************************
!*********************************************************************

   LOOP I#=1 TO 15
      IF ALG:I[I#]
         I:I=ALG:I[I#]
         I:J=ALG:J[I#]
         I:C=ALG:C[I#]
         I:N=ALG:N[I#]
         ADD(I_TABLE)
      .
   .
   SORT(I_TABLE,I:I)


   LOOP I#= 1 TO RECORDS(P_TABLE)
      GET(P_TABLE,I#)
      IF ~GETDAIEV(P:K,2,1)
         CYCLE
      .
      IF DAI:SOCYN='Y'               !APLIEK AR SOC 1%
         CASE P:K
         OF 841                      !ATV.N�KO�AJ� M�NES� -IZN�K, KA NO DARBINIEKA TIEK IETUR�TS VISS UZREIZ...
            SO_IENN+=P:R
         OF 842                      !ATVA�IN�JUMS AIZN�K.M     
            SO_IENAN+=P:R
         OF 852                      !SLILAPA N�KO�AJ� M�NES�
            SO_IENN+=P:R
         ELSE
            SO_IEN+=P:R
         .
      .
      IF DAI:IENYN='Y'               !APLIEK AR IEN-NOD
         CASE P:K
         OF 841                      !ATV.N�KO�AJ� M�NES�
            AP_IENN+=P:R
         OF 842                      !ATVA�IN�JUMS AIZN�K.M
            AP_IENAN+=P:R            
         OF 852                      !SLILAPA N�KO�AJ� M�NES�
            AP_IENN+=P:R
         ELSE
            AP_IEN+=P:R
         .
      .
   .
!   STOP(KAD:VAR&' APLIEK.IEN�KUMS 1 ='&AP_IEN)

!***************************** Teko�ais m�nesis ********************

   IF ALG:YYYYMM<DATE(7,1,2000)          !NEAPA�OJAM NO...
      P16=ROUND(SO_IEN*ALG:PR1/100,.01)  !DARBA ��M�JA SOCI�LAIS
   ELSE
      IF SYS:PZ_NR                       !IR DEFIN�TS OBJEKTS (2007.g.Ls23800)
         DO SUMSOCOBJ                    !SASKAITAM OBLIG�TO IEMAKSU OBJEKTU NO GADA S�KUMA
         IF SYS:PZ_NR-(OBJSUM+SO_IEN)<0  !MKN 193
            KLUDA(0,'Ir sasniegts oblig�to iemaksu objekta MAX apm�rs '&CLIP(GETKADRI(ALG:ID,0,1)),,1)
            SO_IEN=SYS:PZ_NR-OBJSUM
            IF SO_IEN<0 THEN SO_IEN=0.
         .
      .
      P16=SO_IEN*ALG:PR1/100             !DARBA ��M�JA SOCI�LAIS
      IF ~BAND(ALG:IIN_LOCK,00000010b)   !NAV LOCK
         ALG:PPF=SO_IEN*GETKADRI(ALG:ID,0,6)/100  !IEMAKSAS Priv.PF
      .
      IF ~BAND(ALG:IIN_LOCK,00010000b)   !NAV LOCK
         ALG:DZIVAP=SO_IEN*GETKADRI(ALG:ID,0,20)/100  !DZ�V�BAS APDRO�IN��ANA
      .
   .
   DO PAG_MEN                !SAMAKS�TIE NODOK�I PAG�JU�AJ� M�NES�
   DO AIZPAG_MEN             !SAMAKS�TIE NODOK�I AIZPAG�JU�AJ� M�NES�
   IF AP_IEN > 0
      AP_IEN-=P16            !-SOCI�LAIS
      AP_IEN-=ALG:PPF        !-PPF
      AP_IEN-=ALG:DZIVAP     !-DZ�V.AP
      AP_IEN-=ALG:IZDEV      !-ATT.IZDEV 21.08.2010
      AP_IEN-=CALCNEA(1,0,0) !-MIA
      AP_IEN-=CALCNEA(2,0,0) !-BERNI
      AP_IEN-=CALCNEA(3,0,0) !-INV_P
      AP_IEN-=SAM_SOC        !-JAU SAMAKS�TO SOC. NODOKLI
      IF ALG:YYYYMM<DATE(7,1,2000)    !NEAPA�OJAM NO...
         AP_IEN =ROUND(AP_IEN,1)
      .
      IF AP_IEN > 0
         P17=AP_IEN*ALP:PR_PAM/100     !PAMATLIKME
         IF AP_IEN-20*ALP:MIA > 0
!            STOP(AP_IEN&'-'&20*ALP:MIA)
            P18=(AP_IEN-20*ALP:MIA)*ALP:PR_PAP/100   !PAPILDLIKME
         ELSE
            P18=0
         .
         P17-=SAM_NOD     ! AT�EMAM JAU SAMAKS�TO IEN. NODOKLI
      ELSE
         P17=0
         P18=0
      .
   ELSE
      P17=0
      P18=0
   .
!   STOP(KAD:VAR&' NOD 2 ='&P17)
   I_I=901          ! PAMATLIKME
   I_C=AP_IEN
   I_N=P17
   DO PERFORMI
   I_I=902          ! PAPILDLIKME
   I_C=AP_IEN-20*ALP:MIA
   I_N=P18
   DO PERFORMI
   I_I=903          ! Soci�lais par �o m�nesi
   I_C=SO_IEN
   I_N=P16
   DO PERFORMI

!***************************** n�ko�ais m�nesis ********************

   IF ALG:YYYYMM<DATE(7,1,2000)    !NEAPA�OJAM NO...
      P16N=ROUND(SO_IENN*ALG:PR1/100,.01)
   ELSE
      P16N=SO_IENN*ALG:PR1/100     !SOCI�LAIS PAR N�KO�O M�NESI
   .
   IF AP_IENN > 0
      AP_IENN-=P16N
      AP_IENN-=CALCNEA(4,0,A_DIENASN)
      AP_IENN-=CALCNEA(5,0,A_DIENASN)
      AP_IENN-=CALCNEA(6,0,A_DIENASN)
      IF ALG:YYYYMM<DATE(7,1,2000)    !NEAPA�OJAM NO...
         AP_IENN =ROUND(AP_IENN,1)
      .
      IF AP_IENN > 0
         P17=AP_IENN*ALP:PR_PAM/100
         IF AP_IENN-20*ALP:MIA > 0
            P18=(AP_IENN-20*ALP:MIA)*ALP:PR_PAP/100
         ELSE
            P18=0
         .
      ELSE
         P17=0
         P18=0
      .
   ELSE
      P17=0
      P18=0
   .
   I_I=908          ! PAMATLIKME+PAPLIKME N�KO�AJ� M�NES�
   I_C=AP_IENN
   I_N=P17+P18
   DO PERFORMI
   I_I=910          ! Soci�lais par N�KO�O m�nesi
   I_C=SO_IENN
   I_N=P16N
   DO PERFORMI

!***************************** AIZn�ko�ais m�nesis ********************

   IF ALG:YYYYMM<DATE(7,1,2000)    !NEAPA�OJAM NO...
      P16AN=ROUND(SO_IENAN*ALG:PR1/100,.01)
   ELSE
      P16AN=SO_IENAN*ALG:PR1/100
   .
   IF AP_IENAN > 0
      AP_IENAN-=P16AN
      AP_IENAN-=CALCNEA(7,0,A_DIENASAN)
      AP_IENAN-=CALCNEA(8,0,A_DIENASAN)
      AP_IENAN-=CALCNEA(9,0,A_DIENASAN)
      IF ALG:YYYYMM<DATE(7,1,2000)    !NEAPA�OJAM NO...
         AP_IENAN =ROUND(AP_IENAN,1)
      .
      IF AP_IENAN > 0
         P17=AP_IENAN*ALP:PR_PAM/100
         IF AP_IENAN-20*ALP:MIA > 0
            P18=(AP_IENAN-20*ALP:MIA)*ALP:PR_PAP/100
         ELSE
            P18=0
         .
      ELSE
         P17=0
         P18=0
      .
   ELSE
      P17=0
      P18=0
   .
   I_I=909          ! PAMATLIKME+PAPLIKME AIZN�KO�AJ� M�NES�
   I_C=AP_IENN
   I_N=P17+P18
   DO PERFORMI
   I_I=911          ! Soci�lais par AIZN�KO�O m�nesi
   I_C=SO_IENAN
   I_N=P16AN
   DO PERFORMI
!
!*********************P�RR��INA IETUR�JUMUS, KAS IERAKST�TI ALGU FAIL�*****************************
!
    IETUREJUMI_KOPA=0
    LOOP I#=1 TO RECORDS(I_TABLE)
       GET(I_TABLE,I#)
       IF INRANGE(I:I,901,911)
          IETUREJUMI_KOPA+=I:N
          CYCLE !�ITOS VAIR�K NEP�RR��INAM
       .
       CIPARS=0
       IF ~GETDAIEV(I:I,2,1)
          CYCLE
       .
       CASE DAI:F
       OF 'NAV'                           !CIETS UN NEATKAR�GS
          IF ~I:J
             I:N=DAI:ALGA
          .
       OF 'REZ'                           !F-JA NO CITU PIESK. REZULT�TA
          IF ~I:J                         ! nav locked
            LOOP K#=1 TO 10               ! CAURI VISAI DAICIPARULISTEI DAIFAIL�
              LOOP J#=1 TO RECORDS(P_TABLE)  ! CAURI VISAI PIESKAIT�JUMU LISTEI ALG�S
                GET(P_TABLE,J#)
                IF DAI:F_DAIEREZ[K#]>0
                  IF DAI:F_DAIEREZ[K#]=P:K OR |
                  (DAI:F_DAIEREZ[K#]=997 AND ~INRANGE(P:K,850,869)) or |! -SLILAPAS & SOCI�LIE
                  (DAI:F_DAIEREZ[K#]=998 AND ~INRANGE(P:K,850,859)) or |! -SLILAPAS
                  DAI:F_DAIEREZ[K#]=999
                      CIPARS+=P:R            ! SKAITAM KOP� REZULT�TUS
                                             ! (ALGA PAR DAI POZ�CIJU)
                  .
                ELSE                         !IZ�EMOT
                  IF ABS(DAI:F_DAIEREZ[K#])=P:K
                     CIPARS-=P:R
                  .
                .
              .
            .
            IF CIPARS<0
               KLUDA(0,'NEPAREIZI DEFIN�TI IETUR�JUMI.KODS='&ALG:I[I#])
               I:C=0
               I:N=0
            ELSE
               I:C=CIPARS
               IF ~(DAI:TARL=0)
                   I:N=ROUND(CIPARS*DAI:TARL,.01)
               ELSE
                   I:N=ROUND(CIPARS*DAI:PROC/100,.01)
               .
            .
          .
       OF 'PNO'                    !F-JA NO CITU PIESK. REZULT�TA P�C NODOK�IEM
       OROF 'PIE'                  !F-JA NO CITU PIESK. REZULT�TA P�C NODOK�IEM UN P�R�JIEM IETUR�JUMIEM
          IF ~I:J                  ! nav locked
            LOOP K#=1 TO 10        ! CAURI VISAI DAICIPARULISTEI DAIFAIL�
              LOOP J#=1 TO RECORDS(P_TABLE)  ! CAURI VISAI PIESKAIT�JUMU LISTEI ALG�S
                GET(P_TABLE,J#)
                IF DAI:F_DAIEREZ[K#]>0
                  IF DAI:F_DAIEREZ[K#]=P:K OR |
                  (DAI:F_DAIEREZ[K#]=997 AND ~INRANGE(P:K,850,869)) or |! -SLILAPAS & SOCI�LIE
                  (DAI:F_DAIEREZ[K#]=998 AND ~INRANGE(P:K,850,859)) or |! -SLILAPAS
                  DAI:F_DAIEREZ[K#]=999 
                         CIPARS+=P:R         ! SKAITAM KOP� REZULT�TUS
                                             ! (ALGA PAR DAI POZ�CIJU)
                  .
                ELSE               !IZ�EMOT
                  IF ABS(DAI:F_DAIEREZ[K#])=P:K
                     CIPARS-=P:R
                  .
                .
              .
            .
            IF CIPARS<0
               KLUDA(0,'NEPAREIZI DEFIN�TI IETUR�JUMI.KODS='&ALG:I[I#])
               I:C=0
            ELSE
               IF (DAI:F='PIE')
                  CIPARS-=IETUREJUMI_KOPA !AT�EMAM VISUS IETUR�JUMUS,KAM MAZ�KS KODS
               ELSE
                  CIPARS-=NODOKLI           !AT�EMAM IEN�KUMA UN SOCI�LO
               .
               IF CIPARS > 0
                  I:C=CIPARS
                  IF ~(DAI:TARL=0)
                      I:N=ROUND(CIPARS*DAI:TARL,.01)
                  ELSE
                      I:N=ROUND(CIPARS*DAI:PROC/100,.01)
                  .
               ELSE
                  I:C=0
                  I:N=0
               .
            .
          .
       .
       IETUREJUMI_KOPA+=I:N
       PUT(I_TABLE)
    .
!
!*******************PAR�DI NO PAG�JU�� M�NE�A*******************************************
!

  SAVE_RECORD=ALG:RECORD
  save_position=POsition(ALGAS)
  ALG:YYYYMM=DATE(MONTH(alg:YYYYMM)+11,1,YEAR(ALG:YYYYMM)-1)  ! SAV�CAM PAR�DUS NO PAG. M�N.

  GET(ALGAS,ALG:ID_KEY)
  IF ~ERROR()
     IF ALG:IZMAKSAT < 0              !PALICIS PAR�D�
        IZMAKSAT = ABS(ALG:IZMAKSAT)
     .
  .
  RESET(ALGAS,SAVE_POSITION)
  NEXT(ALGAS)
  ALG:RECORD=SAVE_RECORD

  I_I=905          !905-P�RMAKSA/PAR�DS
  I_C=0
  I_N=IZMAKSAT
  DO PERFORMI

!********************Sarakstam fail�**********************************

   IF RECORDS(P_TABLE)>20
      STOP('Pieskait�jumi vair�k k� 20...')
   .
   CLEAR(ALG:K)
   CLEAR(ALG:L)
   CLEAR(ALG:S)
   CLEAR(ALG:D)
   CLEAR(ALG:A)
   CLEAR(ALG:R)
   LOOP I#=1 TO RECORDS(P_TABLE)
      IF I#=21 THEN BREAK.
      GET(P_TABLE,I#)
      ALG:K[I#]=P:K
      ALG:L[I#]=P:L
      ALG:S[I#]=P:S
      ALG:D[I#]=P:D
      ALG:A[I#]=P:A
      ALG:R[I#]=P:R
      IF P:UL    !U_L�GUMS  09.06.2011
         IF ~BAND(ALG:BAITS,00000001b)    !U_L�GUMS
            ALG:BAITS+=1
         .
      .
   .
   FREE(P_TABLE)

   IF RECORDS(I_TABLE)>15
      STOP('Ietur�jumi vair�k k� 15...')
   .
   CLEAR(ALG:I)
   CLEAR(ALG:J)
   CLEAR(ALG:C)
   CLEAR(ALG:N)
   LOOP I#=1 TO RECORDS(I_TABLE)
      IF I#=16 THEN BREAK.
      GET(I_TABLE,I#)
      ALG:I[I#]=I:I
      ALG:J[I#]=I:J
      ALG:C[I#]=I:C
      ALG:N[I#]=I:N
   .
   FREE(I_TABLE)

   ALG:PARSKAITIT=SUM(56)
   ALG:IZMAKSAT=SUM(11)
   IF ~BAND(ALG:IIN_LOCK,00000100b) !NAV LOCK nostr�d�t�s stundas
      IF ARGSTUNDAS  !STUNDAS IR TIKU�AS SKAIT�TAS K� ARGUMENTU SUMMA
         ALG:N_STUNDAS=ARGSTUNDAS
      ELSE
         ALG:N_STUNDAS=CALCSTUNDAS(ALG:YYYYMM,ALG:ID,1,1,4) !YYYYMM,ALG:ID-pie�/atl,1-atv,1-sli,4-nostr.stundas
         IF SLODZEK AND SLODZEK<1
            ALG:N_STUNDAS=ALG:N_STUNDAS*SLODZEK
         .
      .
   .
!   STOP(ALG:ID&' ST='&ALG:N_STUNDAS&'ARGS='&ARGSTUNDAS&'SLODZE='&SLODZEK)
!-----------------------------------------------------------------------------------
PERFORMP          ROUTINE

      GET(P_TABLE,0)
      P:K=P_K
      GET(P_TABLE,P:K)
      IF ERROR() AND P_R
         P:K =P_K
         P:L =0
         P:D =P_D
         P:S =0
         P:A =0
         P:R =P_R
         ADD(P_TABLE)
         SORT(P_TABLE,P:K)
      ELSIF ~P:L
         IF P_R
            P:K =P_K
            P:L =0
            P:D =P_D
            P:S =0
            P:A =0
            P:R =P_R
            PUT(P_TABLE)
         ELSE
            DELETE(P_TABLE)
            SORT(P_TABLE,P:K)
         .
      .
!-----------------------------------------------------------------------------------
PERFORMI          ROUTINE

      GET(I_TABLE,0)
      I:I=I_I
      GET(I_TABLE,I:I)
      IF ERROR() AND I_N
         I:I=I_I
         I:J=0
         I:C=I_C
         I:N=I_N
         ADD(I_TABLE)
         SORT(I_TABLE,I:I)
      ELSIF ~I:J
         IF I_N
            I:I=I_I
            I:J=0
            I:C=I_C
            I:N=I_N
            PUT(I_TABLE)
         ELSE
            DELETE(I_TABLE)
            SORT(I_TABLE,I:I)
         .
      .
      IF INRANGE(I_I,901,903) !Nodok�i un soci�lais
         NODOKLI+=I_N
      .
!-----------------------------------------------------------------------------------
PAG_MEN            ROUTINE

  SAVE_RECORD=ALG:RECORD
  save_position=POsition(ALGAS)
  ALG:YYYYMM=DATE(MONTH(ALG:YYYYMM)+11,1,YEAR(ALG:YYYYMM)-1)
!  STOP('PAG.M�N='&FORMAT(ALG:YYYYMM,@D6))
  GET(ALGAS,ALG:ID_KEY)
  IF ~ERROR()
     LOOP N#=1 TO 20
        IF ALG:K[N#]=841
           AP_IEN+=ALG:R[N#]
        .
     .
     LOOP N#=1 TO 15
        IF ALG:I[N#]=908                   ! IENNOD PAR N�KO�O M�NESI
           SAM_NOD+=ALG:N[N#]
        .
        IF ALG:I[N#]=910                   ! SOCNOD PAR N�KO�O M�NESI
           SAM_SOC+=ALG:N[N#]
        .
     .
  .
  RESET(ALGAS,SAVE_POSITION)
  NEXT(ALGAS)
  ALG:RECORD=SAVE_RECORD

!-----------------------------------------------------------------------------------
AIZPAG_MEN         ROUTINE

  SAVE_RECORD=ALG:RECORD
  save_position=POsition(ALGAS)
  ALG:YYYYMM=DATE(MONTH(ALG:YYYYMM)+10,1,YEAR(ALG:YYYYMM)-1)
!  STOP('AIZPAG.M�N='&FORMAT(ALG:YYYYMM,@D6))
  GET(ALGAS,ALG:ID_KEY)
  IF ~ERROR()
     LOOP N#=1 TO 20
        IF ALG:K[N#]=842
           AP_IEN+=ALG:R[N#]
        .
     .
     LOOP N#=1 TO 15
        IF ALG:I[N#]=909                     ! IENNOD PAR AIZN�KO�O M�NESI
           SAM_NOD+=ALG:N[N#]
        .
        IF ALG:I[N#]=911                     ! SOCNOD PAR AIZN�KO�O M�NESI
           SAM_SOC+=ALG:N[N#]
        .
     .
  .
  RESET(ALGAS,SAVE_POSITION)
  NEXT(ALGAS)
  ALG:RECORD=SAVE_RECORD

!-----------------------------------------------------------------------------------------
VID         ROUTINE

 SAVE_RECORD=ALG:RECORD
 save_position=POsition(ALGAS)
 STUNDAS_NOSK=0
 SUMMA_VIDK  =0
 SAV_ID=ALG:ID
 SAV_YYYYMM=ALG:YYYYMM
 ALG:YYYYMM=DATE(MONTH(ALG:YYYYMM)+6,1,YEAR(ALG:YYYYMM)-1) !P�D�JIE 6 M�NE�I PIRMS yyyymm
 SET(ALG:ID_DAT,ALG:ID_DAT)
 LOOP
    NEXT(ALGAS)
!    STOP(ALG:ID&'='&PER:ID&' '&FORMAT(ALG:YYYYMM,@D6)&' '&FORMAT(per:YYYYMM,@D6)&ERROR())
    IF ERROR() OR ~(ALG:ID=SAV_ID AND ALG:YYYYMM < SAV_YYYYMM) THEN BREAK.
    SUM_M = 0
    LOOP I#= 1 TO 20
       IF ALG:K[I#]
          IF GETDAIEV(ALG:K[I#],2,1) AND DAI:VIDYN='Y'   !Pie�emam, ka vid�jo visur r��ina vien�di
             SUM_M+=ALG:R[I#]
          .
       .
    .
    STUNDAS_NOSK+=ALG:N_STUNDAS
    SUMMA_VIDK  +=SUM_M
 .
 RESET(ALGAS,SAVE_POSITION)
 NEXT(ALGAS)
 ALG:RECORD=SAVE_RECORD

!-----------------------------------------------------------------------------------------
SUMSOCOBJ   ROUTINE

 SAVE_RECORD=ALG:RECORD
 save_position=POsition(ALGAS)
 SAV_YYYYMM=ALG:YYYYMM
 OBJSUM = 0
 ALG:YYYYMM=DATE(1,1,YEAR(ALG:YYYYMM)) !NO GADA S�KUMA
 SET(ALG:ID_DAT,ALG:ID_DAT)
 LOOP
    NEXT(ALGAS)
!    STOP(ALG:ID&'='&PER:ID&' '&FORMAT(ALG:YYYYMM,@D6)&' '&FORMAT(per:YYYYMM,@D6)&ERROR())
    IF ERROR() OR (ALG:YYYYMM = SAV_YYYYMM) THEN BREAK.
    LOOP I#= 1 TO 15
       IF ALG:I[I#]=903 OR| !DARBA ��M�JA SOCI�LAIS
          ALG:I[I#]=910 OR| !DARBA ��M�JA SOCI�LAIS PAR N�K.M.
          ALG:I[I#]=911     !DARBA ��M�JA SOCI�LAIS PAR AIZN�K.M.
          OBJSUM+=ALG:C[I#] !SKAITAM ARGUMENTUS
       .
    .
 .
! RESET(ALGAS,SAVE_POSITION)
! NEXT(ALGAS)
 ALG:RECORD=SAVE_RECORD
