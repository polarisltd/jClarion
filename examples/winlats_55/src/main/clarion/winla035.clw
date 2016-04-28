                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_KonATL             PROCEDURE                    ! Declare Procedure
DAT                  DATE
LAI                  TIME
SUMMA_C              DECIMAL(12,2)
SUMMA_P              DECIMAL(12,2)
KON_KOMENT           STRING(50)
CG                   STRING(10)

!-----------------------------------------------------------------------------
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
Process:View         VIEW(KON_K)
                       PROJECT(KON:BKK)
                       PROJECT(KON:NOSAUKUMS)
                     END
!-----------------------------------------------------------------------------
report REPORT,AT(200,1340,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,100,8000,1240)
         STRING(@s45),AT(1719,156,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Kontu atlikumi uz '),AT(2552,521,1354,260),USE(?String2),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(3958,521,917,260),USE(b_dat),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('(ieskaitot)'),AT(4896,521,833,260),USE(?String4),FONT(,11,,FONT:bold,CHARSET:BALTIC) !         STRING(@N3),AT(6563,573),USE(PA),RIGHT
         STRING(@P<<<#. lapaP),AT(6667,625,625,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(156,833,7396,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Konts'),AT(260,938),USE(?String7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Konta nosaukums'),AT(2240,938),USE(?String8),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums  '),AT(6094,938,1031,208),USE(?String9),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7167,938,365,208),USE(val_uzsk),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1198,7396,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(7552,833,0,417),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5990,833,0,417),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(156,833,0,417),USE(?Line2),COLOR(COLOR:Black)
       END
BIL_HEAD DETAIL,AT(,,,344),USE(?unnamed:4)
         LINE,AT(7552,-10,0,364),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,364),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('BILANCES  KONTI'),AT(2344,104,1406,208),USE(?String10),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,-10,0,364),USE(?Line2:4),COLOR(COLOR:Black)
       END
OPE_HEAD DETAIL,AT(,,,427)
         LINE,AT(156,-10,0,447),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('OPERÂCIJU  KONTI'),AT(2344,156,1406,208),USE(?String10:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5990,-10,0,447),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,447),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(167,52,7385,0),USE(?Line15),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,292),USE(?unnamed:3)
         LINE,AT(156,-10,0,114),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,114),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,114),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(167,104,7385,0),USE(?Line15:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(198,125),USE(?String15),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(656,125),USE(ACC_KODS),FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6490,125),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7104,125),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
DETAIL DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(156,-10,0,197),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,197),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,197),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@s5),AT(260,10,417,156),USE(KON:BKK)
         STRING(@s50),AT(1042,10,3802,156),USE(KON_KOMENT)
         STRING(@N-14.2),AT(6146,10,1042,156),USE(SUMMA_P),RIGHT
       END
       FOOTER,AT(198,10800,8000,52),USE(?unnamed)
         LINE,AT(156,0,7396,0),USE(?Line15:2),COLOR(COLOR:Black)
       END
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
  OP#=0
  BI#=0
  SUMMA_P=0
  dat = today()
  lai = clock()
  CG='K110000'
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF KON_K::Used = 0
    CheckOpen(KON_K,1)
  END
  KON_K::Used += 1
  IF GGK::USED=0
     CHECKOPEN(GGK,1)
  .
  GGK::USED+=1
  IF GG::USED=0
     CHECKOPEN(GG,1)
  .
  GG::USED+=1
  IF PAR_K::USED=0
     CHECKOPEN(PAR_K,1)
  .
  PAR_K::USED+=1
  BIND(KON_K:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEGGK',CYCLEGGK)

  FilesOpened = True
  RecordsToProcess = RECORDS(kon:bkk_key)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Kontu atlikumi'
  ?Progress:UserString{Prop:Text}=''
  SEND(KON_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KON:RECORD)                              !MAKE SURE RECORD CLEARED
      GGK:DATUMS = S_DAT
      SET(KON:bkk_KEY)
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
          IF ~OPENANSI('KONATL.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='KONTU ATLIKUMI UZ '&FORMAT(S_DAT,@D06.)&' (ieskaitot)'
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          !OUTA:LINE='Konts'&CHR(9)&'Konta nosaukums'&CHR(9)&'Atlikums Ls'
          OUTA:LINE='Konts'&CHR(9)&'Konta nosaukums'&CHR(9)&'Atlikums '&val_uzsk
          ADD(OUTFILEANSI)
      .
      OF Event:Timer
      LOOP RecordsPerCycle TIMES
          nk#+=1
          ?Progress:UserString{Prop:Text}=NK#
          DISPLAY(?Progress:UserString)
          CLEAR(GGK:RECORD)
          GGK:BKK=KON:BKK
          IF GGK:BKK[1] > '0' AND ~BI#
             IF F:DBF = 'W'
                PRINT(RPT:BIL_head)
             ELSE
                OUTA:LINE=CHR(9)&'BILANCES KONTI'&CHR(9)
                ADD(OUTFILEANSI)
             END
             BI#=1
          .
          IF GGK:BKK[1] > '5' AND ~OP#
             IF F:DBF = 'W'
                PRINT(RPT:ope_head)
             ELSE
                OUTA:LINE=CHR(9)&'OPERÂCIJU KONTI'&CHR(9)
                ADD(OUTFILEANSI)
             END
             OP#=1
          .
          SET(GGK:BKK_DAT,GGK:BKK_DAT)
          LOOP
             NEXT(GGK)
             IF ~(GGK:BKK=KON:BKK) OR GGK:DATUMS>B_DAT OR ERROR() THEN BREAK.
             IF CYCLEGGK(CG) THEN CYCLE.
             SUMMA_C = GGK:SUMMAV*BANKURS(GGK:VAL,GGK:DATUMS)
             IF ~INRANGE(GGK:SUMMA-SUMMA_C,-0.03,0.03)
                KLUDA(10,' Valûta : '&ggk:val&' Nr GG = '&GGK:u_nr)
                IF ~klu_darbiba
                   DO PROCEDURERETURN
                ELSE
                   GGK:SUMMA=SUMMA_C
                   IF RIUPDATE:GGK()
                      KLUDA(24,'GGK')
                   .
                .
             .
             CASE GGK:D_K
             OF 'D'
               SUMMA_P+=GGK:SUMMA
             ELSE
               SUMMA_P-=GGK:SUMMA
             .
         .                                              !
         IF ~(KON:ATLIKUMS[SYS:AVOTA_NR]=SUMMA_P) AND B_DAT>=TODAY()
            KON:ATLIKUMS[SYS:AVOTA_NR]=SUMMA_P
            IF RIUPDATE:KON_K()
               KLUDA(26,'KON_K ')
            .
         .
         IF SUMMA_P
           IF F:VALODA='1'
              KON_koment = KON:NOSAUKUMSA   !ANGLISKI
           ELSE
              KON_koment = KON:NOSAUKUMS
           .
           IF F:DBF = 'W'
                PRINT(RPT:DETAIL)
           ELSE
                OUTA:LINE=KON:BKK&CHR(9)&KON_KOMENT&CHR(9)&LEFT(FORMAT(SUMMA_P,@N-_14.2))
                ADD(OUTFILEANSI)
           END
           SUMMA_P=0
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
  IF SEND(KON_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT)
        ENDPAGE(report)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Operators: '&CHR(9)&ACC_KODS&CHR(9)&FORMAT(DAT,@D06.)&CHR(9)&FORMAT(LAI,@T4)
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
  ELSE           !Word,EXCEL
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
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
B_APGR               PROCEDURE                    ! Declare Procedure
KON_KOMENT           STRING(95)
DSUMMA1              DECIMAL(12,2)
KSUMMA1              DECIMAL(12,2)
DSUMMA2              DECIMAL(12,2)
KSUMMA2              DECIMAL(12,2)
DSUMMA3              DECIMAL(12,2)
KSUMMA3              DECIMAL(12,2)
DSUMMA3N             DECIMAL(12,2)
KSUMMA3N             DECIMAL(12,2)
DSUMMA1K             DECIMAL(12,2)
KSUMMA1K             DECIMAL(12,2)
DSUMMA2K             DECIMAL(12,2)
KSUMMA2K             DECIMAL(12,2)
DSUMMA3K             DECIMAL(12,2)
KSUMMA3K             DECIMAL(12,2)
KOPA1                DECIMAL(12,2)
KOPA2                DECIMAL(12,2)
KOPA3                DECIMAL(12,2)
KOPA1N               DECIMAL(12,2)
KOPA2N               DECIMAL(12,2)
KOPA3N               DECIMAL(12,2)
KOPA1K               DECIMAL(12,2)
KOPA2K               DECIMAL(12,2)
KOPA3K               DECIMAL(12,2)
DAT                  DATE
LAI                  TIME
SUMMA_C              DECIMAL(12,2)
CG                   STRING(10)
SAV_BKK              STRING(5)
LINEH                STRING(190)
FILTRS_TEXT          STRING(100)
NODALA_TEXT          STRING(50)

N_TABLE         QUEUE,PRE(N)
NODALA               STRING(2)
DSUMMA1              DECIMAL(12,2)
KSUMMA1              DECIMAL(12,2)
DSUMMA2              DECIMAL(12,2)
KSUMMA2              DECIMAL(12,2)
                .
K_TABLE         QUEUE,PRE(K)
KONTUGRUPA           STRING(4)
DSUMMA1              DECIMAL(12,2)
KSUMMA1              DECIMAL(12,2)
DSUMMA2              DECIMAL(12,2)
KSUMMA2              DECIMAL(12,2)
                .

VIRSRAKSTS           STRING(55)
KONTUGRUPA_TEXT      STRING(100)

!-----------------------------------------------------------------------------
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

!-----------------------------------------------------------------------------
report REPORT,AT(198,1488,12000,6500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,300,12000,1188),USE(?unnamed)
         STRING(@s45),AT(3271,104,4740,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(2677,521,6229,188),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s55),AT(3177,313,4948,208),USE(virsraksts),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(9219,469),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(52,729,0,469),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(4167,729,0,469),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(6458,729,0,469),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(8750,729,0,469),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(11042,729,0,469),USE(?Line3),COLOR(COLOR:Black)
         STRING('Atlikums uz perioda sâkumu'),AT(4219,781,2240,156),USE(?String9:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Apgrozîjums atskaites periodâ'),AT(6510,781,2240,156),USE(?String9:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums uz perioda beigâm'),AT(8802,781,2240,156),USE(?String9:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konts'),AT(104,865,469,208),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konta nosaukums'),AT(708,865,2760,208),USE(?String9:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4167,938,6875,0),USE(?Line13),COLOR(COLOR:Black)
         STRING('Kopâ'),AT(5833,990,417,156),USE(?String9:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ'),AT(8125,990,417,156),USE(?String9:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Debets'),AT(4375,990,417,156),USE(?String9:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kredîts'),AT(5104,990,417,156),USE(?String9:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Debets'),AT(6667,990,417,156),USE(?String9:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kredîts'),AT(7396,990,417,156),USE(?String9:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Debets'),AT(8958,990,417,156),USE(?String9:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kredîts'),AT(9688,990,417,156),USE(?String9:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ'),AT(10417,990,417,156),USE(?String9:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1146,10990,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(52,729,10990,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,12000,177)
         LINE,AT(4167,-10,0,198),USE(?Line5:2),COLOR(COLOR:Black)
         LINE,AT(6458,-10,0,198),USE(?Line5:3),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(8000,10,729,156),USE(Kopa2),RIGHT
         LINE,AT(8750,-10,0,198),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,198),USE(?Line6),COLOR(COLOR:Black)
         STRING(@s5),AT(104,10,313,156),USE(SAV_BKK),LEFT
         STRING(@s95),AT(448,10,3698,156),USE(KON_koment),LEFT
         STRING(@n-_13.2),AT(4198,10,729,156),USE(DSumma1),RIGHT
         STRING(@n-_13.2),AT(4948,10,729,156),USE(KSumma1),RIGHT
         STRING(@n-_13.2),AT(5708,10,729,156),USE(Kopa1,,?Kopa1:2),RIGHT
         STRING(@n-_13.2),AT(6479,10,729,156),USE(DSumma2),RIGHT
         STRING(@n-_13.2),AT(7240,10,729,156),USE(KSumma2),RIGHT
         STRING(@n-_13.2),AT(8771,10,729,156),USE(DSumma3),RIGHT
         STRING(@n-_13.2),AT(9531,10,729,156),USE(KSumma3),RIGHT
         STRING(@n-_13.2),AT(10292,10,729,156),USE(Kopa3),RIGHT
       END
detailN DETAIL,AT(,,12000,177)
         LINE,AT(4167,-10,0,198),USE(?Line95:2),COLOR(COLOR:Black)
         LINE,AT(6458,-10,0,198),USE(?Line95:3),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(8000,10,729,156),USE(Kopa2N),RIGHT
         LINE,AT(8750,-10,0,198),USE(?Line55:4),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line95),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,198),USE(?Line96),COLOR(COLOR:Black)
         STRING(@s50),AT(448,10,3698,156),USE(NODALA_TEXT),LEFT
         STRING(@n-_13.2),AT(4198,10,729,156),USE(N:DSumma1),RIGHT
         STRING(@n-_13.2),AT(4948,10,729,156),USE(N:KSumma1),RIGHT
         STRING(@n-_13.2),AT(5708,10,729,156),USE(Kopa1N),RIGHT
         STRING(@n-_13.2),AT(6479,10,729,156),USE(N:DSumma2),RIGHT
         STRING(@n-_13.2),AT(7240,10,729,156),USE(N:KSumma2),RIGHT
         STRING(@n-_13.2),AT(8771,10,729,156),USE(DSumma3N),RIGHT
         STRING(@n-_13.2),AT(9531,10,729,156),USE(KSumma3N),RIGHT
         STRING(@n-_13.2),AT(10292,10,729,156),USE(Kopa3N),RIGHT
       END
RPT_KOPA DETAIL,AT(,,,260),USE(?RPT_KOPA)
         LINE,AT(4167,-10,0,271),USE(?Line14:2),COLOR(COLOR:Black)
         LINE,AT(6458,-10,0,271),USE(?Line14:3),COLOR(COLOR:Black)
         LINE,AT(8750,-10,0,271),USE(?Line14:4),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,271),USE(?Line14:5),COLOR(COLOR:Black)
         LINE,AT(52,52,10990,0),USE(?Line19),COLOR(COLOR:Black)
         STRING('Kopâ :'),AT(208,104,,156),USE(?String34),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_13.2),AT(4198,104,729,156),USE(DSumma1k),RIGHT
         STRING(@n-_13.2),AT(4948,104,729,156),USE(KSumma1K),RIGHT
         STRING(@n-_13.2),AT(5698,104,729,156),USE(Kopa1K),RIGHT
         STRING(@n-_13.2),AT(6479,104,729,156),USE(DSumma2K),RIGHT
         STRING(@n-_13.2),AT(7240,104,729,156),USE(KSumma2K),RIGHT
         STRING(@n-_13.2),AT(8000,104,729,156),USE(Kopa2K),RIGHT
         STRING(@n-_13.2),AT(8771,104,729,156),USE(DSumma3K),RIGHT
         STRING(@n-_13.2),AT(9531,104,729,156),USE(KSumma3K),RIGHT
         STRING(@n-_13.2),AT(10292,104,729,156),USE(Kopa3K),RIGHT
         LINE,AT(52,-10,0,271),USE(?Line14),COLOR(COLOR:Black)
       END
detailK DETAIL,AT(,,12000,177),USE(?unnamed:4)
         LINE,AT(4167,-10,0,198),USE(?LineK95:2),COLOR(COLOR:Black)
         LINE,AT(6458,-10,0,198),USE(?LineK95:3),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(8000,10,729,156),USE(Kopa2N,,?KOPA2N:K),RIGHT
         LINE,AT(8750,-10,0,198),USE(?LineK55:4),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?LineK95),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,198),USE(?LineK96),COLOR(COLOR:Black)
         STRING(@s100),AT(104,0,4010,156),USE(KONTUGRUPA_TEXT),LEFT
         STRING(@n-_13.2),AT(4198,10,729,156),USE(K:DSumma1),RIGHT
         STRING(@n-_13.2),AT(4948,10,729,156),USE(K:KSumma1),RIGHT
         STRING(@n-_13.2),AT(5708,10,729,156),USE(Kopa1N,,?KOPA1N:K),RIGHT
         STRING(@n-_13.2),AT(6479,10,729,156),USE(K:DSumma2),RIGHT
         STRING(@n-_13.2),AT(7240,10,729,156),USE(K:KSumma2),RIGHT
         STRING(@n-_13.2),AT(8771,10,729,156),USE(DSumma3N,,?DSUMMA3N:K),RIGHT
         STRING(@n-_13.2),AT(9531,10,729,156),USE(KSumma3N,,?KSUMMA3N:K),RIGHT
         STRING(@n-_13.2),AT(10292,10,729,156),USE(Kopa3N,,?KOPA3N:K),RIGHT
       END
RPT_FOOT DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(52,0,10990,0),USE(?Line20:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(52,21),USE(?String35),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(625,21),USE(ACC_kods),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING('RS:'),AT(1302,21),USE(?String37),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1510,21),USE(rS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(9948,21),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(10583,21),USE(lai),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(198,7950,12000,52),USE(?unnamed:3)
         LINE,AT(52,0,10990,0),USE(?Line20:2),COLOR(COLOR:Black)
       END
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
  CHECKOPEN(GG,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(KON_K,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEBKK',CYCLEBKK)
  BIND('KKK',KKK)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  MUSTPRINT#=0
  VIRSRAKSTS='Apgrozîjuma Pârskats '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&' (ieskaitot)'
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).
!  IF ~(PAR_TIPS='EFCIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Tips: '&par_Tips.
!  IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa: '&par_grupa.
!  IF F:PVN_P THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' PVN %: '&F:PVN_P.
!  IF F:PVN_T THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'PVN tips: '&F:PVN_T.

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND(GG:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Apgrozîjuma pârskats'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:BKK=KKK
      SET(GGK:BKK_DAT,GGK:BKK_DAT)
      CG='K110011'
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
      Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
            SAV_BKK=GGK:BKK
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSIF F:DBF='E'            !EXCEL
        IF ~OPENANSI('APGR.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Apgrozîjumu pârskats'&' '&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)&' (ieskaitot)'
        ADD(OUTFILEANSI)
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
        OUTA:LINE='Konts'&CHR(9)&'Konta nosaukums'&CHR(9)&'Atlikums uz perioda sâkumu'&CHR(9)&CHR(9)&CHR(9)&'Apgrozîjums atskaites periodâ'&CHR(9)&CHR(9)&CHR(9)&'Atlikums uz perioda beigâm'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&' Debets'&CHR(9)&' Kredîts'&CHR(9)&' Kopâ'&CHR(9)&' Debets'&CHR(9)&' Kredîts'&CHR(9)&' Kopâ'&CHR(9)&' Debets'&CHR(9)&' Kredîts'&CHR(9)&' Kopâ'
        ADD(OUTFILEANSI)
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
      ELSE           !WORD
        IF ~OPENANSI('APGR.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Apgrozîjumu pârskats'&' '&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)&' (ieskaitot)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Konts'&CHR(9)&'Konta nosaukums'&CHR(9)&'Atlikums uz perioda sâkumu'&CHR(9)&CHR(9)&CHR(9)&'Apgrozîjums atskaites periodâ'&CHR(9)&CHR(9)&CHR(9)&'Atlikums uz perioda beigâm'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&' Debets'&CHR(9)&' Kredîts'&CHR(9)&' Kopâ'&CHR(9)&' Debets'&CHR(9)&' Kredîts'&CHR(9)&' Kopâ'&CHR(9)&' Debets'&CHR(9)&' Kredîts'&CHR(9)&' Kopâ'
        ADD(OUTFILEANSI)
      .
      SAV_BKK=''
      MUSTPRINT#=FALSE
      IF F:DTK !ARÎ KOPSUMMAS PA KONTU GRUPÂM
         CLEAR(KON:RECORD)
         SET(KON:BKK_KEY)
         LOOP
            NEXT(KON_K)
            IF ERROR() THEN BREAK.
            IF ~KON:BKK[5]
               K:KONTUGRUPA=KON:BKK
               ADD(K_TABLE)
            .
         .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLEBKK(GGK:BKK,KKK)
           MUSTPRINT#=TRUE !BÛS JÂDRUKÂ PÇC LOOP-A
           IF ~SAV_BKK THEN SAV_BKK=GGK:BKK.
           IF ~(SAV_BKK=GGK:BKK)
              DO PRINTDETAILS
           .
           SUMMA_C =GGK:SUMMAV*BANKURS(GGK:VAL,GGK:DATUMS)
           IF ~INRANGE(GGK:SUMMA-SUMMA_C,-0.03,0.03)
              KLUDA(10,format(ggk:datums,@d6)&' U_Nr = '&ggk:u_nr)
           .
           N:NODALA=GGK:NODALA
           GET(N_TABLE,N:NODALA)
           IF ERROR()
              N:DSUMMA1=0
              N:KSUMMA1=0
              N:DSUMMA2=0
              N:KSUMMA2=0
              ADD(N_TABLE)
              IF ERROR() THEN STOP('ADD N_TABLE '&ERROR()).
              SORT(N_TABLE,N:NODALA)
              IF ERROR() THEN STOP('SORT N_TABLE '&ERROR()).
              GET(N_TABLE,N:NODALA)
              IF ERROR() THEN STOP('GET N_TABLE '&ERROR()).
           .
           IF GGK:DATUMS < S_DAT OR GGK:U_NR=1      ! &SALDO
              CASE GGK:D_K
              OF 'D'
                 DSUMMA1+=GGK:SUMMA
                 N:DSUMMA1+=GGK:SUMMA
              ELSE
                 KSUMMA1+=GGK:SUMMA
                 N:KSUMMA1+=GGK:SUMMA
              .
           ELSIF INRANGE(GGK:DATUMS,S_DAT,B_DAT)
              CASE GGK:D_K
              OF 'D'
                 DSUMMA2+=GGK:SUMMA
                 N:DSUMMA2+=GGK:SUMMA
              ELSE
                 KSUMMA2+=GGK:SUMMA
                 N:KSUMMA2+=GGK:SUMMA
              .
           .
           PUT(N_TABLE)
           IF ERROR() THEN STOP('PUT N_TABLE '&ERROR()).

           IF F:DTK !ARÎ KOPSUMMAS PA KONTU GRUPÂM
              LOOP K#= 1 TO 4
                 K:KONTUGRUPA=GGK:BKK[1:K#]
                 GET(K_TABLE,K:KONTUGRUPA)
                 IF ~ERROR()
                    IF GGK:DATUMS < S_DAT OR GGK:U_NR=1      ! &SALDO
                       CASE GGK:D_K
                       OF 'D'
                          K:DSUMMA1+=GGK:SUMMA
                       ELSE
                          K:KSUMMA1+=GGK:SUMMA
                       .
                    ELSIF INRANGE(GGK:DATUMS,S_DAT,B_DAT)
                       CASE GGK:D_K
                       OF 'D'
                          K:DSUMMA2+=GGK:SUMMA
                       ELSE
                          K:KSUMMA2+=GGK:SUMMA
                       .
                    .
                    PUT(K_TABLE)
                    IF ERROR() THEN STOP('PUT K_TABLE '&ERROR()).
                 .
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
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF MUSTPRINT#=TRUE
       DO PRINTDETAILS
    .
    IF F:DBF = 'W'
        PRINT(RPT:RPT_KOPA)
    ELSE
!        OUTA:LINE=LINEH
!        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ:'&CHR(9)&CHR(9)&LEFT(FORMAT(DSUMMA1K,@N-_12.2))&CHR(9)&LEFT(FORMAT(KSUMMA1K,@N-_12.2))&|
        CHR(9)&LEFT(FORMAT(KOPA1K,@N-_12.2))&CHR(9)&LEFT(FORMAT(DSUMMA2K,@N-_12.2))&CHR(9)&LEFT(FORMAT(KSUMMA2K,@N-_12.2))&|
        CHR(9)&LEFT(FORMAT(KOPA2K,@N-_12.2))&CHR(9)&LEFT(FORMAT(DSUMMA3K,@N-_12.2))&CHR(9)&LEFT(FORMAT(KSUMMA3K,@N-_12.2))&|
        CHR(9)&LEFT(FORMAT(KOPA3K,@N-_12.2))
        ADD(OUTFILEANSI)
!        OUTA:LINE=LINEH
!        ADD(OUTFILEANSI)
    .
    IF F:DTK !DRUKÂT KOPSUMMAS PA KONTU GRUPÂM - ÐEIT VAR NEBÛT VISS, BET KAUT KAS VAR BÛT VAIRÂKAS REIZES
       LOOP K#=1 TO RECORDS(K_TABLE)
          GET(K_TABLE,K#)
          IF K:DSUMMA1 OR K:DSUMMA2 OR K:KSUMMA1 OR K:KSUMMA2
             KONTUGRUPA_TEXT=K:KONTUGRUPA&' '&GetKON_K(K:KONTUGRUPA,0,7)
             DSUMMA3N=K:DSUMMA1+K:DSUMMA2
             KSUMMA3N=K:KSUMMA1+K:KSUMMA2
             KOPA1N=K:DSUMMA1-K:KSUMMA1
             KOPA2N=K:DSUMMA2-K:KSUMMA2
             KOPA3N=DSUMMA3N-KSUMMA3N
             IF F:DBF = 'W'
                PRINT(RPT:DETAILK)
             ELSE
                OUTA:LINE=K:KONTUGRUPA&CHR(9)&GetKON_K(K:KONTUGRUPA,0,7)&CHR(9)&LEFT(FORMAT(K:DSUMMA1,@N-_12.2))&|
                CHR(9)&LEFT(FORMAT(K:KSUMMA1,@N-_12.2))&CHR(9)&LEFT(FORMAT(KOPA1N,@N-_12.2))&CHR(9)&|
                LEFT(FORMAT(K:DSUMMA2,@N-_12.2))&CHR(9)&LEFT(FORMAT(K:KSUMMA2,@N-_12.2))&CHR(9)&|
                LEFT(FORMAT(KOPA2N,@N-_12.2))&CHR(9)&LEFT(FORMAT(DSUMMA3N,@N-_12.2))&CHR(9)&LEFT(FORMAT(KSUMMA3N,@N-_12.2))&|
                CHR(9)&LEFT(FORMAT(KOPA3N,@N-_12.2))
                ADD(OUTFILEANSI)
             .
          .
       .
    .
    dat = today()
    lai = clock()
    IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT)
        ENDPAGE(report)
    .
    CLOSE(ProgressWindow)
    IF F:DBF='W'   !WMF
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'.
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
  IF ERRORCODE() OR CYCLEBKK(GGK:BKK,KKK)=2  !NAV UN VAIRÂK NEBÛS
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
PRINTDETAILS ROUTINE

  IF F:VALODA='1'
     KON_koment = GETKON_K(SAV_BKK,0,4) !ANGLISKI
  ELSE
     KON_koment = GETKON_K(SAV_BKK,0,2)
  .
  DSUMMA3=DSUMMA1+DSUMMA2
  KSUMMA3=KSUMMA1+KSUMMA2
  KOPA1=DSUMMA1-KSUMMA1
  KOPA2=DSUMMA2-KSUMMA2
  KOPA3=DSUMMA3-KSUMMA3
  IF CL_NR=1553 !KOPA
     IF KOPA1>0
        DSUMMA1=KOPA1
        KSUMMA1=0
     ELSE
        DSUMMA1=0
        KSUMMA1=ABS(KOPA1)
     .
     IF KOPA3>0
        DSUMMA3=KOPA3
        KSUMMA3=0
     ELSE
        DSUMMA3=0
        KSUMMA3=ABS(KOPA3)
     .
  .
  IF F:DBF = 'W'
     PRINT(RPT:DETAIL)
  ELSE
     OUTA:LINE=SAV_BKK&CHR(9)&KON_KOMENT&CHR(9)&LEFT(FORMAT(DSUMMA1,@N-_12.2))&CHR(9)&LEFT(FORMAT(KSUMMA1,@N-_12.2))&|
     CHR(9)&LEFT(FORMAT(KOPA1,@N-_12.2))&CHR(9)&LEFT(FORMAT(DSUMMA2,@N-_12.2))&CHR(9)&LEFT(FORMAT(KSUMMA2,@N-_12.2))&|
     CHR(9)&LEFT(FORMAT(KOPA2,@N-_12.2))&CHR(9)&LEFT(FORMAT(DSUMMA3,@N-_12.2))&CHR(9)&LEFT(FORMAT(KSUMMA3,@N-_12.2))&CHR(9)&|
     LEFT(FORMAT(KOPA3,@N-_12.2))
     ADD(OUTFILEANSI)
  END
  IF F:NOA !Drukât nodaïu izvçrsumu - PÇC KATRA KONTA
     LOOP N#=1 TO RECORDS(N_TABLE)
        GET(N_TABLE,N#)
        NodaLA_TEXT=N:NODALA&' '&GetNodalas(N:nodala,1)
        DSUMMA3N=N:DSUMMA1+N:DSUMMA2
        KSUMMA3N=N:KSUMMA1+N:KSUMMA2
        KOPA1N=N:DSUMMA1-N:KSUMMA1
        KOPA2N=N:DSUMMA2-N:KSUMMA2
        KOPA3N=DSUMMA3N-KSUMMA3N
        IF CL_NR=1553 !KOPA
           IF KOPA1N>0
              N:DSUMMA1=KOPA1N
              N:KSUMMA1=0
           ELSE
              N:DSUMMA1=0
              N:KSUMMA1=ABS(KOPA1N)
           .
           IF KOPA3N>0
              DSUMMA3N=KOPA3N
              KSUMMA3N=0
           ELSE
              DSUMMA3N=0
              KSUMMA3N=ABS(KOPA3N)
           .
        .
        IF F:DBF = 'W'
           PRINT(RPT:DETAILN)
        ELSE
           OUTA:LINE=CHR(9)&NodaLA_TEXT&CHR(9)&LEFT(FORMAT(N:DSUMMA1,@N-_12.2))&CHR(9)&LEFT(FORMAT(N:KSUMMA1,@N-_12.2))&|
           CHR(9)&LEFT(FORMAT(KOPA1N,@N-_12.2))&CHR(9)&LEFT(FORMAT(N:DSUMMA2,@N-_12.2))&CHR(9)&LEFT(FORMAT(N:KSUMMA2,@N-_12.2))&|
           CHR(9)&LEFT(FORMAT(KOPA2N,@N-_12.2))&CHR(9)&LEFT(FORMAT(DSUMMA3N,@N-_12.2))&CHR(9)&LEFT(FORMAT(KSUMMA3N,@N-_12.2))&|
           CHR(9)&LEFT(FORMAT(KOPA3N,@N-_12.2))
           ADD(OUTFILEANSI)
        END
     .
  .
  DSUMMA1K+=DSUMMA1
  KSUMMA1K+=KSUMMA1
  KOPA1K  +=KOPA1
  DSUMMA2K+=DSUMMA2
  KSUMMA2K+=KSUMMA2
  KOPA2K  +=KOPA2
  DSUMMA3K+=DSUMMA3
  KSUMMA3K+=KSUMMA3
  KOPA3K  +=KOPA3
  SAV_BKK=GGK:BKK
  DSUMMA1=0
  KSUMMA1=0
  KOPA1  =0
  DSUMMA2=0
  KSUMMA2=0
  KOPA2  =0
  DSUMMA3=0
  KSUMMA3=0
  KOPA3  =0
  FREE(N_TABLE)

B_KaseLs             PROCEDURE                    ! Declare Procedure
KOMENT               STRING(48)
ATL                  DECIMAL(15,2)
UNR                  STRING(3)
NGG                  DECIMAL(7)
DOK_NR               STRING(14)
DATUMS               DATE
SATURS               STRING(80)
SATURS2              STRING(80)
!KKK1                 STRING(5)
!KKK2                 STRING(5)
DEB                  DECIMAL(12,2)
KRE                  DECIMAL(12,2)
LDEB                 DECIMAL(12,2)
LKRE                 DECIMAL(12,2)
KAPGP                DECIMAL(15,2)
KATL                 DECIMAL(15,2)
KDEBP                DECIMAL(13,2)
KKREP                DECIMAL(13,2)
L                    STRING(1)
POS                  STRING(255)
LB                   BYTE
FORMA                STRING(30)
FORMAT               STRING(1)
CG                   STRING(10)
IEN_sk               USHORT
IZD_sk               USHORT
LINEH                STRING(190)
NPK                  LONG

!-----------------------------------------------------------------------------
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

!-----------------------------------------------------------------------------
report REPORT,AT(200,1517,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,100,8000,1417),USE(?unnamed:5)
         STRING(@s45),AT(1615,156,4688,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Konts - '),AT(500,656,552,208),USE(?String2),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s48),AT(1094,656,3594,208),USE(KOMENT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(4896,677,781,208),USE(S_DAT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(5677,677,156,208),USE(?String5),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(5833,677,729,208),USE(B_DAT),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('_________lapa'),AT(6896,729),USE(?String44)
         LINE,AT(104,938,7708,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@s3),AT(448,1094,313,208),USE(UNR),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kor.'),AT(5865,990,365,208),USE(?String14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Npk'),AT(135,1094,260,208),USE(?String8:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Debets'),AT(6281,1094,729,208),USE(?String16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kredîts'),AT(7063,1094,729,208),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1750,1094,469,208),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nr'),AT(813,1198,885,208),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('konts'),AT(5865,1198,365,208),USE(?String15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1406,7708,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(7813,938,0,469),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(417,938,0,469),USE(?Line2:33),COLOR(COLOR:Black)
         STRING('No kâ saòemts,  kam izsniegts,  pamatojums'),AT(2271,1094,3542,208),USE(?String13),CENTER, |
             FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2240,938,0,469),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5833,938,0,469),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(6250,938,0,469),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7031,938,0,469),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(1719,938,0,469),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('Dokumenta'),AT(813,990,885,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,938,0,469),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(104,938,0,469),USE(?Line2),COLOR(COLOR:Black)
       END
SAKATL DETAIL,AT(,,,354),USE(?unnamed:4)
         LINE,AT(2240,313,0,42),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(1719,313,0,42),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,374),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,374),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,374),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,374),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,374),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('Atlikums  uz  perioda  sâkumu  :'),AT(156,104,1979,156),USE(?String18),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_15.2),AT(4260,104,938,156),USE(ATL),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,313,7708,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(417,313,0,42),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(781,313,0,42),USE(?Line2:7),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,146),USE(?unnamed)
         LINE,AT(7813,-10,0,166),USE(?Line2:28),COLOR(COLOR:Black)
         STRING(@n_5b),AT(104,0,313,156),CNT,USE(NPk),TRN,RIGHT
         LINE,AT(7031,-10,0,166),USE(?Line2:23),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(7083,0,677,156),USE(KRE),RIGHT
         LINE,AT(417,-10,0,166),USE(?Line2:31),COLOR(COLOR:Black)
         LINE,AT(1719,-10,0,166),USE(?Line2:17),COLOR(COLOR:Black)
         STRING(@D5),AT(1750,0,469,156),USE(DATUMS),RIGHT
         LINE,AT(2240,-10,0,166),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@s80),AT(2271,0,3542,156),USE(SATURS),LEFT
         LINE,AT(5833,-10,0,166),USE(?Line2:19),COLOR(COLOR:Black)
         STRING(@s5),AT(5865,0,365,156),USE(KKK1),CENTER
         LINE,AT(6250,-10,0,166),USE(?Line2:21),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(6302,0,677,156),USE(DEB),RIGHT
         LINE,AT(781,-10,0,166),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@s14),AT(813,0,885,156),USE(DOK_NR),RIGHT
         LINE,AT(104,-10,0,166),USE(?Line2:29),COLOR(COLOR:Black)
         STRING(@n_5b),AT(458,0,313,156),USE(NGG),LEFT
       END
detail0 DETAIL,AT(,-10,,94)
         LINE,AT(104,0,0,114),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(417,0,0,114),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(781,0,0,114),USE(?Line32:3),COLOR(COLOR:Black)
         LINE,AT(1719,0,0,114),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(2240,0,0,114),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,114),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(6250,0,0,114),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(7031,0,0,114),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,114),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(104,52,7708,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
DETAIL1 DETAIL,AT(,,,146),USE(?unnamed:2)
         LINE,AT(7813,-10,0,166),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,166),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(1719,-10,0,166),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(2240,-10,0,166),USE(?Line2:22),COLOR(COLOR:Black)
         STRING(@s80),AT(2271,0,3542,156),USE(SATURS2),LEFT
         LINE,AT(5833,-10,0,166),USE(?Line2:30),COLOR(COLOR:Black)
         STRING(@s5),AT(5865,0,365,156),USE(KKK2),CENTER
         LINE,AT(6250,-10,0,166),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,166),USE(?Line2:36),COLOR(COLOR:Black)
         LINE,AT(781,-10,0,166),USE(?Line2:34),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,166),USE(?Line2:15),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,1344),USE(?unnamed:3)
         LINE,AT(104,0,0,427),USE(?Line31:2),COLOR(COLOR:Black)
         LINE,AT(417,0,0,62),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(781,0,0,62),USE(?Line33:3),COLOR(COLOR:Black)
         LINE,AT(1719,0,0,62),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(2240,0,0,62),USE(?Line34:2),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,427),USE(?Line35:2),COLOR(COLOR:Black)
         LINE,AT(6250,0,0,427),USE(?Line36:2),COLOR(COLOR:Black)
         LINE,AT(7031,0,0,427),USE(?Line37:2),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,427),USE(?Line38:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7708,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(6302,104,677,156),USE(KDEBP),RIGHT
         STRING(@N-_13.2B),AT(7083,104,677,156),USE(KKREP),RIGHT
         STRING('Apgrozîjums periodâ'),AT(156,104,1198,156),USE(?String29:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums beigâs : '),AT(156,260,938,156),USE(?String29),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_15.2),AT(4260,260,938,156),USE(KATL),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,417,7708,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('Kopçjais kases orderu skaits : Ieòçmumu'),AT(135,479),USE(?String41)
         STRING(@n4),AT(2240,479,260,188),USE(ien_sk),LEFT
         STRING(@n4),AT(3052,479,260,188),USE(izd_sk),LEFT
         STRING('Izdevumu'),AT(2542,479,479,188),USE(?String41:2)
         STRING(@s25),AT(1354,781),USE(sys:amats2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(3302,979),USE(sys:paraksts2),CENTER
         STRING(@s25),AT(5948,979),USE(sys:paraksts3),CENTER
         STRING('Kasieris _{24}'),AT(5469,771,2396,208),USE(?String39:2),LEFT
         STRING('_{26}'),AT(3292,771,1885,208),USE(?String39),LEFT
         STRING(@d6),AT(1406,104,625,156),USE(s_dat,,?s_dat:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(' - '),AT(2031,104,,156),USE(?String31),CENTER
         STRING(@d6),AT(2135,104,625,156),USE(b_dat,,?b_dat:2),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(':'),AT(2813,104,,156),USE(?String33),CENTER
         STRING(@N-_15.2),AT(4260,104,938,156),USE(KAPGP),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
       FOOTER,AT(200,10900,8000,52)
         LINE,AT(104,0,7708,0),USE(?Line1:7),COLOR(COLOR:Black)
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

  CHECKOPEN(GLOBAL)
  CHECKOPEN(SYSTEM)
  CHECKOPEN(GGK)
  CHECKOPEN(GG)
  CHECKOPEN(PAR_K)
  CHECKOPEN(KON_K)

  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('KKK',KKK)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND(KON:RECORD)

  CLEAR(KON:RECORD)
  KON:BKK = KKK
  GET(KON_K,KON:BKK_KEY)
  KOMENT=KKK&': '&CLIP(KON:NOSAUKUMS)
  J# = 0
  DONE# = 0
  KDEBP = 0
  KKREP = 0
  KAPGP = 0
  LDEB = 0
  LKRE =0
  ATL = 0
  NPK = 0
  IF ~F:NOA THEN UNR='UNR'.

  CLEAR(GGK:RECORD)
  L=SUB(KKK,5,1)
  LB = VAL(L)
  LB += 1
  L = CHR(LB)
  GGK:BKK = SUB(KKK,1,4)&L

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
  RecordsToProcess = RECORDS(GGK:BKK_DAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Kases grâmata'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    BIND('KKK',KKK)
    BIND('S_DAT',S_DAT)
    BIND('B_DAT',B_DAT)
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:BKK = KKK
      SET(GGK:BKK_DAT,GGK:BKK_DAT)
      CG='K1100'
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
      Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
          IF ~OPENANSI('KASELS.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='KONTS - '&CLIP(KOMENT)&' '&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Npk'&CHR(9)&'Nr GG'&CHR(9)&'Dokumenta Num.'&CHR(9)&'Datums'&CHR(9)&'No kâ saòemts, kam izsniegts, pamatojums'&CHR(9)&'Konts'&CHR(9)&'Debets'&CHR(9)&'Kredîts'
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        DO CHECKSAKAT
        CASE GGK:D_K
           OF 'D'
             ATL += GGK:SUMMA
           OF 'K'
             ATL -= GGK:SUMMA
        END
        DO CHECKTEXT
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
  IF SEND(GGK,'QUICKSCAN=off').
  KAPGP = KDEBP - KKREP
  KATL = ATL
  IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT)
  ELSE
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Apgrozîjums periodâ: '&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)&' '&LEFT(FORMAT(KAPGP,@N-_15.2))&CHR(9)&|
                  CHR(9)&LEFT(FORMAT(KDEBP,@N-_13.2))&CHR(9)&LEFT(FORMAT(KKREP,@N-_13.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Atlikums beigâs: '&LEFT(FORMAT(KATL,@N-_15.2))
        ADD(OUTFILEANSI)
  END
  IF LocalResponse = RequestCompleted
    ENDPAGE(report)
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
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
  IF ERRORCODE() OR ~(GGK:BKK=KKK)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
!--------------------------------------------------------------
CHECKSAKAT ROUTINE
 IF GGK:DATUMS >= S_DAT AND ~PRSAKAT# AND ~(GGK:U_NR = 1)
    KATL = ATL
    IF F:DBF = 'W'
        PRINT(RPT:SAKATL)
    ELSE
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Atlikums uz perioda sâkumu: '&LEFT(FORMAT(ATL,@N-_15.2))
        ADD(OUTFILEANSI)
    END
    PRSAKAT# = 2
 .
!---------------------------------------------------------------
CHECKTEXT ROUTINE
 IF GGK:DATUMS >= S_DAT AND GGK:U_NR > 1
   GG:U_NR = GGK:U_NR
   GET(GG,GG:NR_KEY)
   BUILDKORMAS(2,0,0,0,0)
   KKK1 = KOR_KONTS[1]
   KKK2 = KOR_KONTS[2]
   IF ~F:NOA THEN NGG = GGK:U_NR.    !LABÂK TOMÇR ÐITÂ
!   NGG += 1
!   IF CHECKPZ(1)
!      DOK_NR=RIGHT(FORMAT(GG:DOK_NR,@N06))
!   ELSE
!      IF GG:DOK_NR
!         DOK_NR=RIGHT(GG:DOK_NR)
!      ELSE
!         DOK_NR=''
!      .
!   .
   DOK_NR = GG:DOK_SENR
   DATUMS = GG:DATUMS
   TEKSTS = CLIP(GG:NOKA)&'-'&CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
   !El IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
   IF ~(GGK:VAL=val_uzsk)
      TEKSTS=CLIP(TEKSTS)&' ('&CLIP(GGK:SUMMAV)&' '&CLIP(GGK:VAL)&')'
   .
   FORMAT_TEKSTS(90,'Arial',8,'')
   SATURS = F_TEKSTS[1]
   CASE GGK:D_K
   OF 'D'
      IEN_SK+=1
      DEB = GGK:SUMMA
      KRE = 0
   OF 'K'
      IZD_SK+=1
      KRE = GGK:SUMMA
      DEB = 0
   .
   IF PRSAKAT# = 1
   ELSE
      PRSAKAT# = 1
   .
   NPK+=1
   IF ~F:DTK
        IF F:DBF = 'W'
            PRINT(RPT:DETAIL)
        ELSE
            OUTA:LINE=FORMAT(NPK,@N_5B)&CHR(9)&FORMAT(NGG,@N_5B)&CHR(9)&CLIP(DOK_NR)&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&CLIP(SATURS)&CHR(9)&CLIP(KKK1)&CHR(9)&LEFT(FORMAT(DEB,@N-_13.2B))&CHR(9)&LEFT(FORMAT(KRE,@N-_13.2B))
            ADD(OUTFILEANSI)
        END
   END
   IF KKK2
      SATURS2 = F_TEKSTS[2]
      IF ~F:DTK
        IF F:DBF
            PRINT(RPT:DETAIL1)
        ELSE
            OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CLIP(SATURS2)&CHR(9)&CLIP(KKK2)
            ADD(OUTFILEANSI)
        END
      END
   .
   LDEB += DEB
   LKRE += KRE
   KDEBP += DEB
   KKREP += KRE
 .
