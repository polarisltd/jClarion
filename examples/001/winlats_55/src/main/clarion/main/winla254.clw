                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PKIP               PROCEDURE                    ! Declare Procedure
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

CG                   STRING(10)

R_TABLE     QUEUE,PRE(R)
KODS            USHORT
SUMMA           DECIMAL(13,2)
SUMMAR          DECIMAL(11)
            .
B_TABLE     QUEUE,PRE(B)
BKK_KODS        STRING(9) !5+4
SUMMA           DECIMAL(13,2)
            .
R_NOSAUKUMS          LIKE(KONR:NOSAUKUMS)
R_USER               BYTE
R_SUMMA              DECIMAL(13,2)
B_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
B_BKK                STRING(5)
I_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
PERIODS30            STRING(30)
KON_KOMENT           STRING(60)
DAT                  LONG
LAI                  LONG
CNTRL1               DECIMAL(13,2)
CNTRL1R              DECIMAL(11)
CNTRL2               DECIMAL(13,2)
CNTRL2R              DECIMAL(11)
R_KOPA               DECIMAL(13,2),DIM(14)
R_KOPAR              DECIMAL(11),DIM(14)
R_SS                 DECIMAL(13,2),DIM(11)
R_SSR                DECIMAL(11),DIM(11)

E                    STRING(1)
TEX:DUF              STRING(100)
XMLFILENAME          CSTRING(200),STATIC
SADALA               BYTE,DIM(12)
DRUKAT               BYTE
S_SUMMA              STRING(15)
E_SUMMA              STRING(15)

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

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
report REPORT,AT(100,200,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
CEPURE DETAIL,AT(,,,1438),USE(?unnamed:7)
         STRING(@s45),AT(2656,104,3542,208),USE(client),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('E'),AT(7594,73),USE(?StringE),TRN,FONT(,22,,FONT:bold,CHARSET:ANSI)
         STRING(@s11),AT(3177,510,833,208),USE(GL:reg_nr),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzòçmuma reìistrâcijas numurs Nodokïu maksâtâju reìistrâ'),AT(104,510),USE(?String41)
         STRING('Taksâcijas periods'),AT(104,698),USE(?String41:2),TRN
         STRING(@s30),AT(2656,698,2240,208),USE(periods30),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçrvienîba: Ls'),AT(7031,698),USE(?String41:3),TRN
         STRING(@s60),AT(2656,313,4531,208),USE(GL:adrese),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Paðu kapitâla izmaiòu pârskats (PKIP)'),AT(469,885,6510,260),USE(?String4),CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5500,1177,0,260),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(156,1167,7656,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(156,1177,0,260),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(5875,1177,0,260),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6823,1177,0,260),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7813,1167,0,260),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Rindiòas nosaukums'),AT(1031,1219,3750,180),USE(?nosaukums),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Beigâs'),AT(5958,1219,781,177),USE(?client:4),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkumâ'),AT(6906,1219,833,177),USE(?client:5),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese'),AT(104,313,573,208),USE(?String10:6),LEFT
         STRING('Uzòçmuma (uzòçmçjsabiedrîbas) nosaukums'),AT(104,104,2448,208),USE(?String10:4),LEFT
       END
DETAILV DETAIL,AT(,,8000,177),USE(?unnamed)
         STRING(@s100),AT(188,21,5300,156),USE(R_NOSAUKUMS),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,-10,0,177),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,177),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2:10),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,177),USE(?unnamed:8)
         STRING(@s4),AT(5563,10,280,156),USE(R:KODS),LEFT,FONT(,9,,)
         STRING(@S15),AT(5927,10,854,156),USE(S_SUMMA),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s100),AT(188,10,5300,156),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:2),LEFT(1)
         LINE,AT(156,-10,0,177),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,177),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2:15),COLOR(COLOR:Black)
       END
DETAILB DETAIL,AT(,,,177),USE(?unnamed:3)
         STRING(@s4),AT(5563,10,280,156),USE(R:KODS,,?R:KODS:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S15),AT(5938,0,833,156),USE(S_SUMMA,,?S_SUMMA:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(188,10,5300,156),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:3),LEFT(1),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,-10,0,177),USE(?Line2K:11),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,177),USE(?Line2K:12),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2K:13),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2K:14),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2K:15),COLOR(COLOR:Black)
       END
DETAILBKK DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(156,-10,0,197),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@s60),AT(1042,10,4271,156),USE(B_NOSAUKUMS),LEFT
         STRING(@s5),AT(521,10,417,156),USE(B_BKK),LEFT
         STRING(@N-_12.2B),AT(5927,10,,156),USE(B:SUMMA),RIGHT,FONT(,9,,)
         LINE,AT(5500,-10,0,177),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2:20),COLOR(COLOR:Black)
       END
SVITRA DETAIL,AT(,,,0)
         LINE,AT(156,0,7656,0),USE(?Line1:2),COLOR(COLOR:Black)
       END
PAGE_FOOT DETAIL,AT(,,,73),USE(?unnamed:2)
         LINE,AT(156,52,7656,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,62),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,62),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,62),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,62),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,62),USE(?Line2:25),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,,,344),USE(?unnamed:4)
         LINE,AT(156,-10,0,62),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,62),USE(?Line2:35),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,62),USE(?Line2:36),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,62),USE(?Line2:37),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,62),USE(?Line2:38),COLOR(COLOR:Black)
         LINE,AT(156,52,7656,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('RC :'),AT(156,83),USE(?String31),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(365,83,188,177),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6698,83,573,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7302,83,521,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@s25),AT(1115,188,1667,208),USE(SYS:AMATS1),TRN,RIGHT
         STRING('_{34}'),AT(2802,177,2240,156),USE(?String34),TRN
         STRING(@s25),AT(5000,188,1667,208),USE(SYS:PARAKSTS1),TRN,LEFT
       END
       FOOTER,AT(100,11168,8000,125),USE(?unnamed:6)
         STRING(@P<<<#. lapaP),AT(7240,-10,573,156),PAGENO,USE(?PageCount),RIGHT
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CheckOpen(KON_R,1)
  KON_R::Used += 1
  IF RECORDS(KON_R)=0
     KLUDA(0,'Nav atrodams fails '&CLIP(LONGPATH())&'\'&KONRNAME)
     DO PROCEDURERETURN
  .
  IF KON_K::Used = 0
    CheckOpen(KON_K,1)
  END
  KON_K::Used += 1
  CheckOpen(GGK,1)
  FilesOpened = True

  CLEAR(KONR:RECORD)
  KONR:UGP='K' !PKIP
  SET(KONR:UGP_KEY,KONR:UGP_KEY)
  LOOP
     NEXT(KON_R)
     IF ERROR() OR ~(KONR:UGP='K') THEN BREAK.
     R:KODS=KONR:KODS
     R:SUMMA=0
     R:SUMMAR=0
     ADD(R_TABLE)
  .
  SORT(R_TABLE,R:KODS)
  periods30='no '&FORMAT(S_DAT,@D06.)&' lîdz '&FORMAT(B_DAT,@D6.)
  DAT=TODAY()
  LAI=CLOCK()
  CG = 'K100000'

  BIND(KON:RECORD)
  BIND(GGK:RECORD)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PKIP'
  ?Progress:UserString{Prop:Text}=''
  SEND(KON_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      SET(GGK:DAT_KEY)
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
      IF F:XML !EDS
        XMLFILENAME=USERFOLDER&'\UGP_UZ_2006_PKIP.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           E='E'
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLEGGK(CG)
          IF ~GETKON_K(ggk:BKK,2,1)
             DO PROCEDURERETURN
          .
          nk#+=1
          ?Progress:UserString{Prop:Text}=NK#
          DISPLAY(?Progress:UserString)
          ATRASTS#=0
          LOOP J# = 1 TO 2
             IF KON:PKIP[J#]
                R:KODS=KON:PKIP[J#]
!                STOP(R:KODS&' '&GGK:SUMMA&' '&GGK:BKK&GGK:D_K)
                GET(R_TABLE,R:KODS)
                IF ERROR()
                   KLUDA(71,'www.vid.gov.lv KONTS='&kon:BKK&' R='&KON:PKIP[J#])
                   DO PROCEDURERETURN
                ELSE
                   R_SUMMA=0
                   IF  KON:PKIF[J#]='B' AND ~(GGK:U_NR=1) ! K-D,~SALDO
                      IF GGK:D_K='D'
                         R_SUMMA=-GGK:SUMMA
                      ELSE
                         R_SUMMA=GGK:SUMMA
                      .
                   ELSIF KON:PKIF[J#]='S' AND GGK:U_NR=1 ! SALDOK-SALDOD
                      IF GGK:D_K='D'
                         R_SUMMA=-GGK:SUMMA
                      ELSE
                         R_SUMMA=GGK:SUMMA
                      .
                   ELSIF KON:PKIF[J#]='A' AND ~(GGK:U_NR=1) ! D-K,~SALDO
                      IF GGK:D_K='D'
                         R_SUMMA=GGK:SUMMA
                      ELSE
                         R_SUMMA=-GGK:SUMMA
                      .
                   .
                   IF R_SUMMA
                      R:SUMMA+=R_SUMMA
                      PUT(R_TABLE)
                      IF INRANGE(R:KODS,550,640-1) THEN SADALA[7]=TRUE.  !LIETOTÂJA DEFINÇTS 1
                      IF INRANGE(R:KODS,640,730-1) THEN SADALA[8]=TRUE.  !LIETOTÂJA DEFINÇTS 2
                      IF INRANGE(R:KODS,730,820-1) THEN SADALA[9]=TRUE.  !LIETOTÂJA DEFINÇTS 3
                      IF INRANGE(R:KODS,820,910-1) THEN SADALA[10]=TRUE. !LIETOTÂJA DEFINÇTS 4
                      IF INRANGE(R:KODS,910,1000-1) THEN SADALA[11]=TRUE.!LIETOTÂJA DEFINÇTS 5
                      IF F:DTK  !IZVÇRSTÂ VEIDÂ
                         B:BKK_KODS=GGK:BKK&FORMAT(R:KODS,@N_4)
                         GET(B_TABLE,B:BKK_KODS)
                         IF ERROR()
                            B:SUMMA=R_SUMMA
                            ADD(B_TABLE)
                            SORT(B_TABLE,B:BKK_KODS)
                         ELSE
                            B:SUMMA+=R_SUMMA
                            PUT(B_TABLE)
                         .
                      .
                   .
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
!****************************** 2. SOLIS ********************************
  PRINT(RPT:CEPURE)
  PRINT(RPT:SVITRA)
!---------------
  DO FILL_R_TABLE
!---------------
  GET(R_TABLE,0)
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     V#=INSTRING(FORMAT(R:KODS,@N04),'001001000190028003700460055006400730082009101000',4) !PIRMS ÐITIEM VAJAG VIRSRAKSTU
     IF V#
        EXECUTE(V#)
           R_NOSAUKUMS='Akciju vai daïu kapitâls(pamatkapitâls)'
           R_NOSAUKUMS='Akciju(daïu) emisijas uzcenojums'
           R_NOSAUKUMS='Ilgtermiòa ieguldîjumu pârvçrtçðanas rezerves'
           R_NOSAUKUMS='Finanðu instrumentu pârvçrtçðana'
           R_NOSAUKUMS='Rezerves'
           R_NOSAUKUMS='Nesadalîtâ peïòa'
           R_NOSAUKUMS='Lietotâja definçts 1' !7
           R_NOSAUKUMS='Lietotâja definçts 2'
           R_NOSAUKUMS='Lietotâja definçts 3'
           R_NOSAUKUMS='Lietotâja definçts 4'
           R_NOSAUKUMS='Lietotâja definçts 5' !11
           R_NOSAUKUMS='Kopâ'
        .
        DRUKAT=TRUE                            !SADAÏA JÂDRUKÂ
        IF INRANGE(V#,7,11) AND ~SADALA[V#]    !LIETOTÂJA DEFINÇTS un TUKÐS
           DRUKAT=FALSE                        !SADAÏA NAV JÂDRUKÂ
        ELSE
           PRINT(RPT:DETAILV)
           PRINT(RPT:SVITRA)
        .
     .
     R_NOSAUKUMS=GETKON_R('K',R:KODS,0,1)
     R_USER=GETKON_R('K',R:KODS,0,3)
     IF DRUKAT=TRUE AND ~(R_USER AND ~R:SUMMA) !~LIETOTÂJA DEFINÇTÂ SADAÏA un TUKÐS ~TUKÐA LIETOTÂJA RINDA
        IF F:NOA
           S_SUMMA=FORMAT(R:SUMMAR,@N-15)
        ELSE
           S_SUMMA=FORMAT(R:SUMMA,@N-15.2)
        .
        PRINT(RPT:DETAIL)
        IF F:DTK  !IZVÇRSTÂ VEIDÂ
           LOOP J#= 1 TO RECORDS(B_TABLE)
              GET(B_TABLE,J#)
              IF B:BKK_KODS[6:9]=R:KODS
                 B_BKK=B:BKK_KODS[1:5]
                 B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 PRINT(RPT:DETAILBKK)
              .
           .
        .
        PRINT(RPT:SVITRA)
     .
     IF F:XML_OK#=TRUE AND ~(R_USER AND ~R:SUMMA)
        XML:LINE='<<Row>'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="tabula" value="pkip" />'   !PKIP
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="rinda" value="'&CLIP(R:KODS)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="iepr_vert" value="0" />'   !?
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="vertiba" value="'&CLIP(R:SUMMAR)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<</Row>'
        ADD(OUTFILEXML)
     .
  .
  PRINT(RPT:FOOTER)

  IF SEND(KON_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    ENDPAGE(report)
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
    END
  END
  CLOSE(report)
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
  FREE(R_TABLE)
  FREE(B_TABLE)
  KON_R::Used -= 1
  IF KON_R::Used = 0 THEN CLOSE(KON_R).
  IF FilesOpened
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
  .
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
  IF ERRORCODE() OR GGK:DATUMS > B_DAT
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
FILL_R_TABLE ROUTINE
  K1#=40
  K2#=80
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     R:SUMMAR=ROUND(R:SUMMA,1)
     V#=INSTRING(FORMAT(R:KODS,@N04),'00100100019002800370046005500640073008200910',4) !11 IEPR.G
     IF V#
        CNTRL2 +=R:SUMMA
        CNTRL2R+=R:SUMMAR
        R_KOPA[1] +=R:SUMMA
        R_KOPAR[1]+=R:SUMMAR
     .
     V#=INSTRING(FORMAT(R:KODS,@N04),'00200110020002900380047005600650074008300920',4) !11 IEPR.G.LABOJUMS
     IF V#
        CNTRL2 +=R:SUMMA
        CNTRL2R+=R:SUMMAR
        R_KOPA[2] +=R:SUMMA
        R_KOPAR[2]+=R:SUMMAR
     .
     IF INRANGE(R:KODS,K1#,K2#) !LIETOTÂJA DEFINÇTIE
!        IF V#=6 THEN STOP(R:KODS&' '&R:SUMMA).
        CNTRL1 +=R:SUMMA
        CNTRL1R+=R:SUMMAR
     .
     V#=INSTRING(FORMAT(R:KODS,@N04),'00900180027003600450054006300720081009000990',4) !11 STARPSUMMAS:ATLIKUMS PÂRSKATA PERIODA GADÂ
     IF V#                   !FIKSÇJAM MAZÂS STARPSUMMAS,SKAITAM ATLIKUMU KOPÂ
        R_SS[V#] =CNTRL1
        R_SSR[V#]=CNTRL1R
        R:SUMMA  =CNTRL1+CNTRL2
        R:SUMMAR =CNTRL1R+CNTRL2R
        R_KOPA[14] +=R:SUMMA    !KOPÂ
        R_KOPAR[14]+=R:SUMMAR
        CNTRL1 =0
        CNTRL1R=0
        CNTRL2 =0
        CNTRL2R=0
        EXECUTE V#
           K1#=130 !2
           K1#=220
           K1#=310
           K1#=400
           K1#=490 !6
           K1#=580
           K1#=670
           K1#=760
           K1#=850
           K1#=940
        .
        EXECUTE V#
           K2#=170 !2
           K2#=260
           K2#=350
           K2#=440
           K2#=530 !6
           K2#=620
           K2#=710
           K2#=800
           K2#=890
           K2#=980
        .
     .
     PUT(R_TABLE)
  .
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     V#=INSTRING(FORMAT(R:KODS,@N04),'00300120021003000390048005700660075008400930',4) !11 MAZÂS STARPSUMMAS (P/S)
     IF V#
        R:SUMMA =R_SS[V#]     !SARAKSTAM MAZÂS STARPSUMMAS
        R:SUMMAR=R_SSR[V#]
        PUT(R_TABLE)
        R_KOPA[V#+2] =R:SUMMA !AIZPILDAM 3:13-1020:1120)
        R_KOPAR[V#+2]=R:SUMMAR
     .
     IF R:KODS>=1000                                                          !KOPA
        V#=(R:KODS-1000)/10+1
        IF INRANGE(V#,1,14)
           R:SUMMA =R_KOPA[V#]
           R:SUMMAR=R_KOPAR[V#]
           PUT(R_TABLE)
        ELSE
           stop('INDEKSS= '&v#)
        .
     .
  .
INVDK                FUNCTION (DK)                ! Declare Procedure
kods0          STRING(13)
kC             STRING(4)
REZULTATS      DECIMAL(13)
  CODE                                            ! Begin processed code
 IF DK='D'
    RETURN('K')
 ELSE
    RETURN('D')
 .
N_ObjKops            PROCEDURE                    ! Declare Procedure
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
NGGK                STRING(1)
NOSAUKUMS           STRING(50)
DEB                 DECIMAL(14,2)
KRE                 DECIMAL(14,2)
ATL                 DECIMAL(15,2)
PROC                DECIMAL(7,1)
DEBk                DECIMAL(14,2)
KREk                DECIMAL(14,2)
ATLk                DECIMAL(15,2)
PROCK               DECIMAL(7,1)
LAI                 LONG
DAT                 LONG
BANKURSS            REAL
X_DAT               LONG
nr                  ushort

N_TABLE             QUEUE,PRE(N)
DEB                     DECIMAL(14,2)
KRE                     DECIMAL(14,2)
OBJ_NR                  ULONG
NOSAUKUMS               STRING(50)
                    END

CG                  STRING(10)
VIRSRAKSTS          STRING(80)
FILTRS_TEXT         STRING(80)

!-----------------------------------------------------------------------------
Process:View         VIEW(PAVAD)
                       PROJECT(PAV:U_NR)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:PAR_NR)
                       PROJECT(PAV:SUMMA)
                       PROJECT(PAV:SUMMA_B)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(104,1469,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,198,8000,1271),USE(?unnamed)
         STRING(@s45),AT(1688,104,4583,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(635,490,6667,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7125,813,729,156),PAGENO,USE(?PAGECOUNT),RIGHT
         STRING(@s60),AT(1656,771,4740,208),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma A7'),AT(6698,792),USE(?String26),TRN
         LINE,AT(625,990,7240,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Nr'),AT(708,1031,313,208),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('K (bez PVN)'),AT(5188,1031,1094,208),USE(?String12:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Rezultâts'),AT(6333,1031,1094,208),USE(?String69),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('%'),AT(7500,1031,313,208),USE(?String12:5),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7448,990,0,313),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7865,990,0,313),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(625,1250,7240,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('D (bez PVN)'),AT(4042,1031,1094,208),USE(?String12:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Projekts (Objekts)'),AT(1125,1031,2865,208),USE(?String12:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1094,990,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4010,990,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5156,990,0,313),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(6302,990,0,313),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(625,990,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:3)
         STRING(@S50),AT(1146,0,2813,156),USE(NOSAUKUMS),LEFT
         STRING(@N-_6.1B),AT(7521,10,313,156),USE(PROC,,?PROC:2),TRN,RIGHT
         LINE,AT(7865,0,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(5260,10,885,156),USE(N:KRE),RIGHT
         LINE,AT(4010,-10,0,198),USE(?Line2:4),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(4115,10,885,156),USE(N:DEB),RIGHT
         LINE,AT(6302,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@N-_15.2B),AT(6406,10,938,156),USE(ATL),RIGHT
         LINE,AT(7448,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,198),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@N_8),AT(656,0,417,156),USE(N:OBJ_NR),RIGHT
         LINE,AT(625,-10,0,198),USE(?Line2:3),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,427),USE(?unnamed:2)
         LINE,AT(625,260,7240,0),USE(?Line651:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(625,281,490,146),USE(?String61),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@S8),AT(1115,281,625,146),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6750,281,625,146),USE(dat),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7354,281,521,146),USE(lai),LEFT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(5156,0,0,260),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(625,52,7240,0),USE(?Line651:34),COLOR(COLOR:Black)
         LINE,AT(7865,10,0,260),USE(?Line23:3),COLOR(COLOR:Black)
         STRING('Kopâ:'),AT(729,83,521,156),USE(?String21),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_14.2B),AT(4115,83,885,156),USE(DEBk),RIGHT
         STRING(@N-_14.2B),AT(5260,83,885,156),USE(KREk),RIGHT
         STRING(@N-_15.2B),AT(6406,83,938,156),USE(ATLk),RIGHT
         STRING(@N-_6.1B),AT(7521,83,313,156),USE(PROCK),TRN,RIGHT
         LINE,AT(7448,0,0,260),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,260),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,260),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(1094,0,0,63),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(625,0,0,260),USE(?Line845),COLOR(COLOR:Black)
       END
       FOOTER,AT(104,11000,8000,52),USE(?unnamed:4)
         LINE,AT(625,10,7240,0),USE(?Line1:3),COLOR(COLOR:Black)
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

  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)

  DAT = TODAY()
  LAI = CLOCK()
  VIRSRAKSTS='D/K PPR projektu(Obj.) kopsavilkums '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
  IF F:DTK
    FILTRS_TEXT='K PPR '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(TODAY(),@D06.)
    X_DAT=TODAY()
  ELSE
    FILTRS_TEXT=''
    X_DAT=B_DAT
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(pavad,1)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Projektu(Obj.) kopsavilkums'
  ?Progress:UserString{Prop:Text}=''
  SEND(pavad,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
!      CG = 'K11'
      CLEAR(PAV:RECORD)
      PAV:DATUMS=S_DAT
      SET(PAV:DAT_KEY,PAV:DAT_KEY)
!      Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
!      IF ERRORCODE()
!        StandardWarning(Warn:ViewOpenError)
!      END
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
          IF ~OPENANSI('N_OBJKOPS.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='D/K PPR projektu(Obj.) kopsavilkums'
          ADD(OUTFILEANSI)
          OUTA:LINE=format(S_DAT,@d06.)&' - '&format(B_DAT,@d06.)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='NR'&CHR(9)&'Projekts (Obj.)'&CHR(9)&'  D'&CHR(9)&'  K'&CHR(9)&'Rezultâts' &CHR(9)&' Uzc.%'
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        np#+=1
        ?Progress:UserString{Prop:Text}=NP#
        DISPLAY(?Progress:UserString)
        IF PAV:OBJ_NR AND INRANGE(PAV:DATUMS,S_DAT,X_DAT)
            BANKURSS=BANKURS(PAV:VAL,PAV:DATUMS)
            NR+=1
            ?Progress:UserString{Prop:Text}=NR
            DISPLAY(?Progress:UserString)
            GET(N_TABLE,0)
            N:OBJ_NR=PAV:OBJ_NR
            GET(N_TABLE,N:OBJ_NR)
            IF ERROR()
                N:OBJ_NR=PAV:OBJ_NR
                N:NOSAUKUMS=PAV:NOKA
                IF PAV:D_K='D' AND PAV:DATUMS <= B_DAT
                    N:DEB = PAV:SUMMA_b*BANKURSS
                    N:KRE = 0
                ELSIF PAV:D_K='K'
                    N:DEB = 0
                    N:KRE = PAV:SUMMA_b*BANKURSS
                END
                ADD(N_TABLE)
                SORT(N_TABLE,N:OBJ_NR)
            ELSE
                IF PAV:D_K='D' AND PAV:DATUMS <= B_DAT
                    N:DEB += PAV:SUMMA_b*BANKURSS
                    N:NOSAUKUMS=CLIP(N:NOSAUKUMS)&'+'&PAV:NOKA
                ELSIF PAV:D_K='K'
                    N:KRE += PAV:SUMMA_b*BANKURSS
                    N:NOSAUKUMS=CLIP(N:NOSAUKUMS)&'-'&PAV:NOKA
                END
                PUT(N_TABLE)
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
    LOOP N#=1 TO RECORDS(N_TABLE)
       GET(N_TABLE,N#)
       NOSAUKUMS = CLIP(GETPROJEKTI(N:OBJ_NR,1))&' '&N:NOSAUKUMS
       ATL = N:KRE - N:DEB
       IF N:KRE AND N:DEB
          PROC= (N:KRE/N:DEB)*100-100  !UZCENOJUMA %
       ELSE
          PROC= 0
       .
       DEBk += N:DEB
       KREk += N:KRE
       IF F:DBF='W'
          PRINT(RPT:DETAIL)
       ELSE
          OUTA:LINE=N:OBJ_NR&CHR(9)&NosaukumS&CHR(9)&LEFT(FORMAT(N:DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(N:KRE,@N-_14.2))&|
          CHR(9)&LEFT(FORMAT(ATL,@N-_15.2))&CHR(9)&LEFT(FORMAT(PROC,@N-_7.1))
          ADD(OUTFILEANSI)
       .
    .
    ATLk = KREk-DEBk
    IF KREK AND DEBK
       PROCK= (KREK/DEBK)*100-100  !UZCENOJUMA %
    ELSE
       PROCK= 0
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    ELSE
        OUTA:LINE='KOPÂ:'&CHR(9)&CHR(9)&LEFT(FORMAT(DEBk,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREk,@N-_14.2))&CHR(9)&|
        LEFT(FORMAT(ATLk,@N-_15.2))&CHR(9)&LEFT(FORMAT(PROCk,@N-_7.1))
        ADD(OUTFILEANSI)
    .
    ENDPAGE(report)
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
      .
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
!  IF FilesOpened
!    GGK::Used -= 1
!    IF GGK::Used = 0 THEN CLOSE(GGK).
!  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'.
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
  PREVIOUS(Process:View)
  IF ERRORCODE() OR PAV:DATUMS>X_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
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
