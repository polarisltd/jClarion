                     MEMBER('winlats.clw')        ! This is a MEMBER module
GetKad_Rik           FUNCTION (RIK_NR,RET)        ! Declare Procedure
  CODE                                            ! Begin processed code
!
! RIK_NR- RIK:U_NR vai KAD:ID
! 1-ATGRIEÞ NR & DATUMU
! 2-IR KAC
! 3-IR I
! 4-IR B
!
 IF RIK_NR
    IF KAD_RIK::USED=0
       CHECKOPEN(KAD_RIK,1)
    .
    KAD_RIK::USED+=1
    CASE RET
    OF 1
       RIK:U_NR=RIK_NR
       GET(KAD_RIK,RIK:NR_KEY)
       IF ~ERROR()
          RET#=1
       .
    OF 2
    OROF 3
    OROF 4
       CLEAR(RIK:RECORD)
       RIK:DATUMS=DATE(1,1,2020)
       RIK:ID=RIK_NR
       SET(RIK:ID_KEY,RIK:ID_KEY)  !DESC
       LOOP
          NEXT(KAD_RIK)
!          STOP(RIK:ID&''&RIK:TIPS)
          IF ERROR() OR ~(RIK:ID=RIK_NR) THEN BREAK.
          IF (INSTRING(RIK:TIPS,'KAC') AND RET=2) OR |
             (RIK:TIPS='I' AND RET=3) OR |
             (RIK:TIPS='B' AND RET=4)
             RET#=2
!          STOP(RET#&''&RIK:ID&''&RIK:TIPS)
             BREAK
          .
       .
    .
    KAD_RIK::USED-=1
    IF KAD_RIK::USED=0
       CLOSE(KAD_RIK)
    .
 .
 EXECUTE RET#+1
   RETURN('')
   RETURN(CLIP(RIK:DOK_NR)&' '&FORMAT(RIK:DATUMS,@D06.))
   RETURN(TRUE)
 .


GetProj_P            FUNCTION (PROJEKTS,OPC)      ! Declare Procedure
  CODE                                            ! Begin processed code
!
! ATGRIEÞ TRUE, JA PROJEKTAM IR PLÂNS
!
 IF PROJEKTS
    IF PROJ_P::USED=0
       CHECKOPEN(PROJ_P,1)
    .
    PROJ_P::USED+=1
    IF RECORDS(PROJ_P)
       CLEAR(PRP:RECORD)
       PRP:U_NR=PROJEKTS
       PRP:DATUMS=TODAY()+360
       SET(PROJ_P,PRP:NR_KEY)
       NEXT(PROJ_P)
       IF ERROR() OR ~(PRP:U_NR=PROJEKTS)
          RET#=1
       ELSE
          RET#=2
       .
    ELSE
       RET#=1
    .
    PROJ_P::USED-=1
    IF PROJ_P::USED=0
       CLOSE(PROJ_P)
    .
 ELSE
    RET#=1
 .
 EXECUTE RET#
   RETURN('')
   RETURN(TRUE)
 .
B_Men_PPI            PROCEDURE                    ! Declare Procedure
K_TABLE           QUEUE,PRE(K)
KEY                ULONG
SUMMA_G            DECIMAL(12,2)
SUMMA_M            DECIMAL(12,2)
                  .
N_TABLE           QUEUE,PRE(N)
KEY                STRING(2)
SUMMA_G            DECIMAL(12,2)
SUMMA_M            DECIMAL(12,2)
                  .

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

PLANS                DECIMAL(12,2)
IZPILDE              DECIMAL(5,1)
KODS                 STRING(8)
NOSAUKUMS            STRING(105)

!-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
                       PROJECT(GGK:BAITS)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:KK)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:PVN_PROC)
                       PROJECT(GGK:PVN_TIPS)
                       PROJECT(GGK:REFERENCE)
                       PROJECT(GGK:RS)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:VAL)
                     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(PROJ_P,1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Paðvaldîbu pamatbudþeta izpilde'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ggk:RECORD)
      GGK:BKK='238'
      SET(GGK:BKK_DAT)
      OPEN(Process:View)
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      .
      LOOP
        DO GetNextRecord
        DO ValidateRecord
        CASE RecordStatus
          OF Record:Ok
            BREAK
          OF Record:OutOfRange
            LocalResponse = RequestCancelled
            BREAK
        .
      .
      IF LocalResponse = RequestCancelled
         POST(Event:CloseWindow)
         CYCLE
      .
      IF ~OPENANSI('MenPPI.TXT')
         POST(Event:CloseWindow)
         CYCLE
      .
      OUTA:LINE=''
      ADD(OUTFILEANSI)
      OUTA:LINE=CLIENT
      ADD(OUTFILEANSI)
      OUTA:LINE='Mçneða pârskats par paðvaldîbas pamatbudþeta izpildi uz '&format(B_DAT,@d06.)
      ADD(OUTFILEANSI)
      OUTA:LINE=''
      ADD(OUTFILEANSI)
      OUTA:LINE='Klasifikâcijas'&CHR(9)&'Râdîtâja nosaukums'&CHR(9)&'Gada plâns'&CHR(9)&'Izpilde no'&CHR(9)&'Izpilde %'&CHR(9)&'Pârskata mçneða'
      ADD(OUTFILEANSI)
      OUTA:LINE='kods'&CHR(9)&CHR(9)&CHR(9)&'gada sâkuma'&CHR(9)&'pret gada plânu'&CHR(9)&'izpilde'
      ADD(OUTFILEANSI)
      OUTA:LINE=''
      ADD(OUTFILEANSI)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF GGK:BKK[1:2]='26' or ggk:bkk[1:3]='238'
            nk#+=1
            ?Progress:UserString{Prop:Text}=NK#
            DISPLAY(?Progress:UserString)
            IF GGK:OBJ_NR
               K:KEY=GGK:OBJ_NR
               GET(K_TABLE,K:KEY)
               IF ERROR()
                  IF INRANGE(GGK:DATUMS,DATE(MONTH(B_DAT),1,YEAR(B_DAT)),B_DAT)
                     K:SUMMA_M=GGK:SUMMA
                  .
                  K:SUMMA_G=GGK:SUMMA
                  ADD(K_TABLE)
                  SORT(K_TABLE,K:KEY)
               ELSE
                  IF INRANGE(GGK:DATUMS,DATE(MONTH(B_DAT),1,YEAR(B_DAT)),B_DAT)
                     K:SUMMA_M+=GGK:SUMMA
                  .
                  K:SUMMA_G+=GGK:SUMMA
                  PUT(K_TABLE)
               .
            .
            IF GGK:NODALA
               N:KEY=GGK:NODALA
               GET(N_TABLE,N:KEY)
               IF ERROR()
                  IF INRANGE(GGK:DATUMS,DATE(MONTH(B_DAT),1,YEAR(B_DAT)),B_DAT)
                     N:SUMMA_M=GGK:SUMMA
                  .
                  N:SUMMA_G=GGK:SUMMA
                  ADD(N_TABLE)
                  SORT(N_TABLE,N:KEY)
               ELSE
                  IF INRANGE(GGK:DATUMS,DATE(MONTH(B_DAT),1,YEAR(B_DAT)),B_DAT)
                     N:SUMMA_M+=GGK:SUMMA
                  .
                  N:SUMMA_G+=GGK:SUMMA
                  PUT(N_TABLE)
               .
            .
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
!--------------------------
  GET(K_TABLE,0)
  LOOP K#= 1 TO RECORDS(K_TABLE)
     GET(K_TABLE,K#)
     IF K:KEY>'31000' AND PRINTNODALAS#=FALSE !JÂIEBÂÞ PA VIDU NODAÏAS
        LOOP N#= 1 TO RECORDS(N_TABLE)
           GET(N_TABLE,N#)
           KODS=GETNODALAS(N:KEY,2)&'.' !DRAÒÍA EXCELS
           NOSAUKUMS=GETNODALAS(N:KEY,1)
           PLANS=0 !??
           IZPILDE=0 !??
           OUTA:LINE=KODS&CHR(9)&NOSAUKUMS&CHR(9)&FORMAT(PLANS,@N-_12.2)&CHR(9)&FORMAT(N:SUMMA_G,@N-_12.2)&CHR(9)&FORMAT(IZPILDE,@N-_5.1)&CHR(9)&FORMAT(N:SUMMA_M,@N-_12.2)
           ADD(OUTFILEANSI)
        .
        PRINTNODALAS#=TRUE
     .
     CLEAR(PRP:RECORD)
     PRP:U_NR=K:KEY
     SET(PRP:NR_KEY,PRP:NR_KEY)
     NEXT(PROJ_P)
     IF PRP:U_NR=K:KEY
        PLANS=PRP:PLANS
     ELSE
        PLANS=0
     .
     IF PLANS
        IZPILDE=(K:SUMMA_G/PLANS)*100
     ELSE
        IZPILDE=0
     .
     KODS=GETPROJEKTI(K:KEY,2)
     NOSAUKUMS=GETPROJEKTI(K:KEY,1)
     OUTA:LINE=KODS&CHR(9)&NOSAUKUMS&CHR(9)&FORMAT(PLANS,@N-_12.2)&CHR(9)&FORMAT(K:SUMMA_G,@N-_12.2)&CHR(9)&FORMAT(IZPILDE,@N-_5.1)&CHR(9)&FORMAT(K:SUMMA_M,@N-_12.2)
     ADD(OUTFILEANSI)
  .
  IF PRINTNODALAS#=FALSE !JÂIZDRUKÂ NODAÏAS
     LOOP N#= 1 TO RECORDS(N_TABLE)
        GET(N_TABLE,N#)
        KODS=GETNODALAS(N:KEY,2)&'.' !DRAÒÍA EXCELS
        NOSAUKUMS=GETNODALAS(N:KEY,1)
        PLANS=0 !??
        IZPILDE=0 !??
        OUTA:LINE=KODS&CHR(9)&NOSAUKUMS&CHR(9)&FORMAT(PLANS,@N-_12.2)&CHR(9)&FORMAT(N:SUMMA_G,@N-_12.2)&CHR(9)&FORMAT(IZPILDE,@N-_5.1)&CHR(9)&FORMAT(N:SUMMA_M,@N-_12.2)
        ADD(OUTFILEANSI)
     .
     PRINTNODALAS#=TRUE
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     CLOSE(ProgressWindow)
     CLOSE(OUTFILEANSI)
     RUN('C:\PROGRA~1\MICROS~1\OFFICE\EXCEL.EXE '&ANSIFILENAME)
     IF RUNCODE()=-4
        RUN('EXCEL.EXE '&ANSIFILENAME)
        IF RUNCODE()=-4
            KLUDA(88,'Excel.exe')
        .
     .
  .
  ANSIFILENAME=''
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(K_TABLE)
  FREE(N_TABLE)
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
  IF ERRORCODE() OR GGK:BKK[1:2]>'26'
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GGK')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END
