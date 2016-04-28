                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_PasAN              PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:U_NR)
                     END
!------------------------------------------------------------------------
IESPEJAMS            DECIMAL(11,3)
nom_atlikums         DECIMAL(11,3)
nom_d_projekts       DECIMAL(11,3)
JAPASUTA             DECIMAL(11,3)
NOS_P                STRING(35)
SANEMEJS             STRING(30)
NOL_NOMENKLAT        STRING(15)
NOSAUKUMS            STRING(50)
DAUDZUMS             DECIMAL(12,3)
DAUDZUMSK            DECIMAL(12,3)
IESPEJAMSK           DECIMAL(11,3)
DAT                  DATE
LAI                  TIME
CN                   STRING(10)
FILTRS_TEXT          STRING(100)

N_TABLE              QUEUE,PRE(N)
NOMENKLAT              STRING(21)
IESPEJAMS              DECIMAL(12,3)
                     .
VIRSRAKSTS           STRING(80)

!-----------------------------------------------------------------------
report REPORT,AT(200,1720,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS                !1720=500+1220
       HEADER,AT(200,500,12000,1219),USE(?unnamed)
         STRING('FORMA A1'),AT(8594,521,677,156),USE(?String22),LEFT
         STRING(@P<<<#. lapaP),AT(9844,552,677,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s100),AT(1354,521,6500,208),USE(FILTRS_TEXT),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,729,10469,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1771,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2292,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(3906,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(6823,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7552,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(8281,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(9010,729,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(9781,729,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(10521,729,0,521),USE(?Line2:19),COLOR(COLOR:Black)
         STRING('Pasûtîtâjs'),AT(781,854,885,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1813,854,469,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(2531,854,1250,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(4427,854,1927,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('K-projekts'),AT(6865,854,677,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iespçjams'),AT(7594,760,677,208),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ir'),AT(8417,781,490,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('D-projekts'),AT(9042,854,729,208),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Jâpasûta'),AT(9823,854,646,208),USE(?String10:10),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('izpildît'),AT(7583,917,677,156),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('noliktavâ'),AT(8323,990,677,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc Iepr.P'),AT(7573,1052,677,156),USE(?String10:11),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1198,10469,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(52,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(2479,63,4375,198),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(1146,292,6906,198),USE(virsraksts),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(52,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@s30),AT(104,10,1667,156),USE(SANEMEJS),LEFT
         LINE,AT(1771,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@D05.),AT(1802,10,469,156),USE(NOL:DATUMS),CENTER
         LINE,AT(2292,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@s21),AT(2344,10,1563,156),USE(NOL_NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3906,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@s50),AT(3958,10,2865,156),USE(NOSAUKUMS),LEFT
         LINE,AT(6823,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@N_10.3),AT(6896,10,625,156),USE(DAUDZUMS),RIGHT
         LINE,AT(7552,-10,0,198),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N_10.3),AT(7625,10,625,156),USE(IESPEJAMS),RIGHT
         LINE,AT(8281,-10,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@N-_11.3),AT(8344,10,625,156),USE(NOM_ATLIKUMS),RIGHT
         LINE,AT(9010,-10,0,198),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(9781,-10,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N-_11.3),AT(9073,10,677,156),USE(NOM_D_PROJEKTS),RIGHT
         STRING(@N-_11.3),AT(9823,10,677,156),USE(japasuta),TRN,RIGHT
         LINE,AT(10521,-10,0,198),USE(?Line2:20),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,250)
         LINE,AT(52,-10,0,270),USE(?Line23),COLOR(COLOR:Black)
         STRING('Kopâ:'),AT(104,104,469,156),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.3B),AT(6667,104,833,156),USE(DAUDZUMSk),RIGHT
         STRING(@N_11.3),AT(7604,104,625,156),USE(IESPEJAMSk),RIGHT
         LINE,AT(52,52,10469,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,62),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,270),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(8281,-10,0,270),USE(?Line23:3),COLOR(COLOR:Black)
         LINE,AT(9010,-10,0,62),USE(?Line23:4),COLOR(COLOR:Black)
         LINE,AT(9781,-10,0,270),USE(?Line23:5),COLOR(COLOR:Black)
         LINE,AT(10521,-10,0,270),USE(?Line23:6),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,62),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,62),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(1771,-10,0,62),USE(?Line24),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,208),USE(?unnamed:3)
         LINE,AT(52,-10,0,62),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,62),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(8281,-10,0,62),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(9781,-10,0,62),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(10521,-10,0,62),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(52,52,10469,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(73,73,479,156),USE(?String39),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(573,73,552,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1656,73,219,156),USE(?String41),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1865,73,156,156),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(9469,73,615,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10083,73,458,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(200,8020,12000,63)
         LINE,AT(52,0,10469,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!****************  PASÛTÎJUMU ANALÎZE  ******************
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF NOLIK::USED=0
     CHECKOPEN(NOLIK,1)
     NOLIK::USED=1
  .
  IF NOM_K::USED=0
     CHECKOPEN(NOM_K,1)
     NOM_K::USED+=1
  .
  IF PAR_K::USED=0
     CHECKOPEN(PAR_K,1)
     PAR_K::USED=1
  .
  CHECKOPEN(PAVAD,1)
  CHECKOPEN(KOMPLEKT,1)

!  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)
  BIND('CN',CN)

  D_K = 'P'
  dat = today()
  LAI = CLOCK()
!
!  IF F:OBJ_NR THEN FILTRS_TEXT =CLIP(FILTRS_TEXT)&'Objekts:'&F:OBJ_NR.
!  IF PAR_TIPS THEN FILTRS_TEXT =CLIP(FILTRS_TEXT)&'ParTips:'&PAR_TIPS.
!  IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa:'&PAR_GRUPA.
  IF NOMENKLAT THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nomenklatûra:'&NOMENKLAT.
!  IF F:DIENA THEN FILTRS_TEX  T=CLIP(FILTRS_TEXT)&' Diena/nakts=:'&F:DIENA.
!
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Pasûtîjumu analîze'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'N100100'
!           123456
      VIRSRAKSTS='Pasûtîjumu analîze (datumu secîbâ): '&format(S_DAT,@d06.)&'-'&format(B_DAT,@d06.)&' Noliktava: '&LOC_NR
      CLEAR(nol:RECORD)
      NOL:DATUMS=S_DAT
      SET(NOL:DAT_KEY,NOL:DAT_KEY)
      Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT)'
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
          IF ~OPENANSI('PASAN.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Pasûtîtâjs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&'K-Projekts'&CHR(9)&|
          'Iespçjams izpildît'&CHR(9)&'Ir noliktavâ'&CHR(9)&'D-Projekts'&CHR(9)&'Jâpasûta'
          ADD(OUTFILEANSI)
!          OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Pçc iepr.P.'
!          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NK#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        G#=GETPAVADZ(NOL:U_NR) !DÇÏ GETPAR_K
        SANEMEJS=GETPAR_K(NOL:PAR_NR,2,5)
        IF GETNOM_K(NOL:NOMENKLAT,0,16)='R'  ! RAÞOJUMS
            CLEAR(KOM:RECORD)
            KOM:NOMENKLAT=NOL:NOMENKLAT
            SET(KOM:NOM_KEY,KOM:NOM_KEY)
            LOOP
               NEXT(KOMPLEKT)
               IF ERROR() OR ~(KOM:NOMENKLAT=NOL:NOMENKLAT) THEN BREAK.
               GET(N_TABLE,0)
               N:NOMENKLAT=KOM:NOM_SOURCE
               GET(N_TABLE,N:NOMENKLAT)
               IF ERROR()
                  N:NOMENKLAT=KOM:NOM_SOURCE
                  N:IESPEJAMS=GETNOM_A(KOM:NOM_SOURCE,1,0)
                  ACT#=1
               ELSE
                  ACT#=2
               .
               DAUDZUMS=NOL:DAUDZUMS*KOM:DAUDZUMS
               DO CALC_IESPEJAMS
               NOSAUKUMS=CLIP(NOL:NOMENKLAT)&':'&GETNOM_K(N:NOMENKLAT,2,2)
               NOM_ATLIKUMS=GETNOM_A(N:NOMENKLAT,1,0)
               NOM_D_PROJEKTS=GETNOM_A(N:NOMENKLAT,2,0)
               JAPASUTA=DAUDZUMS-IESPEJAMS-NOM_D_PROJEKTS
               IF JAPASUTA<0 THEN JAPASUTA=0.
               DAUDZUMSK+=DAUDZUMS
               iespejamsK+=IESPEJAMS
               NOL_NOMENKLAT=N:NOMENKLAT
               IF F:DBF='W'
                   PRINT(RPT:DETAIL)
               ELSE
                   OUTA:LINE=SANEMEJS&CHR(9)&FORMAT(NOL:Datums,@D06.)&CHR(9)&N:Nomenklat&CHR(9)&Nosaukums&CHR(9)&|
                   LEFT(FORMAT(NOL:DAUDZUMS,@N_10.3))&CHR(9)&LEFT(FORMAT(IespEjams,@N_10.3))&CHR(9)&|
                   LEFT(FORMAT(NOM_ATLIKUMS,@N-_11.3))&CHR(9)&LEFT(FORMAT(NOM_D_PROJEKTS,@N-_11.3))&CHR(9)&|
                   LEFT(FORMAT(JApasUta,@N-_11.3))
                   ADD(OUTFILEANSI)
               .
           .
        ELSE
           N:NOMENKLAT=NOL:NOMENKLAT
           GET(N_TABLE,N:NOMENKLAT)
           IF ERROR()
              N:NOMENKLAT=NOL:NOMENKLAT
              N:IESPEJAMS=GETNOM_A(NOL:NOMENKLAT,1,0)
              ACT#=1
           ELSE
              ACT#=2
           .
           DAUDZUMS=NOL:DAUDZUMS
           DO CALC_IESPEJAMS
           NOSAUKUMS=GETNOM_K(N:NOMENKLAT,2,2)
           NOM_ATLIKUMS=GETNOM_A(N:NOMENKLAT,1,0)
           NOM_D_PROJEKTS=GETNOM_A(N:NOMENKLAT,2,0)
           JAPASUTA=DAUDZUMS-IESPEJAMS-NOM_D_PROJEKTS
           IF JAPASUTA<0 THEN JAPASUTA=0.
           DAUDZUMSK+=NOL:DAUDZUMS
           iespejamsK+=IESPEJAMS
           NOL_NOMENKLAT=N:NOMENKLAT
           IF F:DBF='W'
               PRINT(RPT:DETAIL)
           ELSE
               OUTA:LINE=SANEMEJS&CHR(9)&FORMAT(NOL:Datums,@D06.)&CHR(9)&NOL:Nomenklat&CHR(9)&Nosaukums&CHR(9)&|
               LEFT(FORMAT(NOL:DAUDZUMS,@N_10.3))&CHR(9)&LEFT(FORMAT(IespEjams,@N_10.3))&CHR(9)&|
               LEFT(FORMAT(NOM_ATLIKUMS,@N-_11.3))&CHR(9)&LEFT(FORMAT(NOM_D_PROJEKTS,@N-_11.3))&CHR(9)&|
               LEFT(FORMAT(JApasUta,@N-_11.3))
               ADD(OUTFILEANSI)
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
  IF F:DBF='W'
    PRINT(RPT:RPT_FOOT1)
    PRINT(RPT:RPT_FOOT3)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N_12.3))&CHR(9)&LEFT(FORMAT(IespEjamsK,@N_11.3))
    ADD(OUTFILEANSI)
    OUTA:LINE=''
    ADD(OUTFILEANSI)
  END
  IF SEND(NOLIK,'QUICKSCAN=off').
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
  FREE(N_TABLE)
  IF FilesOpened
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  IF F:DBF<>'W' THEN F:DBF='W'.
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
  IF ERRORCODE() OR NOL:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLIK')
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
CALC_IESPEJAMS ROUTINE
  IF N:IESPEJAMS>=DAUDZUMS
    IESPEJAMS=DAUDZUMS
!          N:IESPEJAMS=GETNOM_A(NOL:NOMENKLAT,1,0)-NOL:DAUDZUMS
    N:IESPEJAMS-=DAUDZUMS
  ELSIF N:IESPEJAMS>0
    IESPEJAMS=N:IESPEJAMS
    N:IESPEJAMS=0
  ELSE
    IESPEJAMS=0
    N:IESPEJAMS=0
  .
  CASE ACT#
  OF 1
    ADD(N_TABLE)
    SORT(N_TABLE,N:NOMENKLAT)
  OF 2
    PUT(N_TABLE)
  .


!**************************************************************************
OMIT('MARIS')
NEXT_RECORD ROUTINE                              !GET NEXT RECORD
  LOOP UNTIL EOF(nolik)                          !  READ UNTIL END OF FILE
    NEXT(nolik)                                  !    READ NEXT RECORD
    I# += 1
    SHOW(15,32,I#,@N_5)
!   IF ~(nol:pazime=DK AND NOL:DATUMS<=B_DAT AND S_DAT<=NOL:DATUMS)
    IF ~(nol:pazime=D_K)
        BREAK
    .
!   IF CYCLENOM(NOL:NOMENKLAT) THEN CYCLE.          !FILTRS PÇC NOMENKLATÛTAS
    IF NOL:U_NR=1 THEN CYCLE.                         !SALDO
    GETPAR_K(NOL:PAR_NR)                            !POZICIONÇ PAR_K
!   IF ~GRP() THEN CYCLE.                           !FILTRS PÇC PARTNERA GRUPAS
    GETPAVADZ(NOL:U_NR)                               !POZICIONÇ PAVADZÎMES
!   IF ~RST() THEN CYCLE.
!   IF TIPS AND ~(PAV:TIPS=TIPS) THEN CYCLE.        !FILTRS PÇC TIPA
    EXIT                                         !    EXIT THE ROUTINE
  .                                              !
  DONE# = 1                                      !  ON EOF, SET DONE FLAG
MARIS
N_PasAN1             PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END
!------------------------------------------------------------------------
NOS_P                STRING(35)
nom_atlikums         DECIMAL(11,3)
JAPASUTA             DECIMAL(11,3)
nom_d_projekts       DECIMAL(11,3)
NOSAUKUMS            STRING(50)
IESPEJAMS            DECIMAL(10,3)
DAUDZUMS             DECIMAL(12,3)
DAUDZUMSK            DECIMAL(12,3)
IESPEJAMSK           DECIMAL(11,3)
DAT                  DATE
LAI                  TIME
CN                   STRING(10)
FILTRS_TEXT          STRING(100)

N_TABLE              QUEUE,PRE(N)
NOMENKLAT              STRING(21)
DAUDZUMS               DECIMAL(12,3)
CENA                   DECIMAL(12,3)
                     .
ITOGO                DECIMAL(12,3)
ITOGOK               DECIMAL(12,3)
VIRSRAKSTS           STRING(80)

!-----------------------------------------------------------------------
report REPORT,AT(200,1740,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(200,500,12000,1240),USE(?unnamed)
         STRING(@s100),AT(1510,573,6646,156),USE(FILTRS_TEXT),TRN,CENTER
         STRING('FORMA A2'),AT(8698,521,844,156),USE(?String22),LEFT
         STRING(@P<<<#. lapaP),AT(9531,521,625,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(52,729,10260,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1771,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5000,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5729,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6458,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7188,729,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7969,729,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(10313,729,0,521),USE(?Line2:19),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(156,885,1563,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PIC'),AT(8781,885,729,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(9563,792,729,208),USE(?String10:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(1875,885,3073,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('K-projekts'),AT(5042,885,677,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iespçjams'),AT(5771,781,677,208),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ir'),AT(6500,781,677,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9531,729,0,521),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(8750,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('Jâpasûta'),AT(8010,885,729,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('D-projekts'),AT(7229,885,729,208),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('izpildît'),AT(5771,990,677,208),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('noliktavâ'),AT(6500,990,677,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ls bez PVN'),AT(9542,990,770,208),USE(?String10:14),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1198,10260,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(52,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(2625,52,4427,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(1240,292,7219,260),USE(VIRSRAKSTS),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(52,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@s21),AT(135,10,1615,156),USE(N:NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1771,0,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@s50),AT(1823,10,3177,156),USE(NOSAUKUMS),LEFT
         LINE,AT(5000,0,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@N_10.3),AT(5052,10,625,156),USE(N:DAUDZUMS),RIGHT
         LINE,AT(5729,0,0,198),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N_10.3),AT(5781,10,625,156),USE(IESPEJAMS),RIGHT
         LINE,AT(6458,0,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@N-_11.3),AT(6510,10,625,156),USE(NOM_ATLIKUMS),RIGHT
         LINE,AT(7188,0,0,198),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(7969,0,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N-_11.3),AT(7240,10,677,156),USE(NOM_D_PROJEKTS),RIGHT
         STRING(@N-_11.3),AT(8021,10,677,156),USE(japasuta),RIGHT
         STRING(@N-_11.3),AT(8802,10,677,156),USE(N:CENA),RIGHT
         LINE,AT(9531,0,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@N-_11.3),AT(9583,10,677,156),USE(ITOGO),RIGHT
         LINE,AT(8750,0,0,198),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(10313,0,0,198),USE(?Line2:20),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,250),USE(?unnamed:3)
         LINE,AT(52,-10,0,270),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(1771,0,0,62),USE(?Line27:2),COLOR(COLOR:Black)
         STRING('Kopâ:'),AT(104,104,469,156),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.3B),AT(4844,104,833,156),USE(DAUDZUMSk),RIGHT
         STRING(@N_11.3),AT(5781,104,625,156),USE(IESPEJAMSk),RIGHT
         STRING(@N-_11.3),AT(9583,104,677,156),USE(ITOGOK),RIGHT
         LINE,AT(52,52,10260,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7969,0,0,62),USE(?Line23:4),COLOR(COLOR:Black)
         LINE,AT(8750,0,0,62),USE(?Line23:7),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,62),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(5729,0,0,270),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(6458,0,0,270),USE(?Line23:3),COLOR(COLOR:Black)
         LINE,AT(7188,0,0,62),USE(?Line23:424),COLOR(COLOR:Black)
         LINE,AT(9531,0,0,270),USE(?Line23:5),COLOR(COLOR:Black)
         LINE,AT(10313,0,0,270),USE(?Line23:6),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,198),USE(?unnamed:4)
         LINE,AT(52,-10,0,62),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(5729,0,0,62),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(6458,0,0,62),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(9531,0,0,62),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(10313,0,0,62),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(52,52,10260,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(63,73,469,146),USE(?String39),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(531,73),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1625,73,208,146),USE(?String41),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1833,73,156,146),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(9229,73,594,146),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(9844,73,458,146),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(200,7800,12000,63)
         LINE,AT(52,0,10260,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!****************  PASÛTÎJUMU ANALÎZE  ******************
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF NOLIK::USED=0
     CHECKOPEN(NOLIK,1)
     NOLIK::USED=1
  .
  IF NOM_K::USED=0
     CHECKOPEN(NOM_K,1)
     NOM_K::USED+=1
  .
  IF PAR_K::USED=0
     CHECKOPEN(PAR_K,1)
     PAR_K::USED=1
  .
  CHECKOPEN(KOMPLEKT,1)
  CHECKOPEN(PAVAD,1)

!  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)
  BIND('CN',CN)

  D_K = 'P'
  dat = today()
  LAI = CLOCK()
!
!  IF F:OBJ_NR THEN FILTRS_TEXT =CLIP(FILTRS_TEXT)&'Objekts:'&F:OBJ_NR.
!  IF PAR_TIPS THEN FILTRS_TEXT =CLIP(FILTRS_TEXT)&'ParTips:'&PAR_TIPS.
!  IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa:'&PAR_GRUPA.
  IF NOMENKLAT THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nomenklatûra:'&NOMENKLAT.
!  IF F:DIENA THEN FILTRS_TEX  T=CLIP(FILTRS_TEXT)&' Diena/nakts=:'&F:DIENA.
!
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Pasûtîjumu kopsavilkums'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'N100100'
!           123456
      VIRSRAKSTS='Pasûtîjumu analîze (NOM secîbâ): '&format(S_DAT,@d06.)&'-'&format(B_DAT,@d06.)&' Noliktava: '&LOC_NR
      CLEAR(nol:RECORD)
      NOL:DATUMS=S_DAT
      SET(NOL:DAT_KEY,NOL:DAT_KEY)
      Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT)'
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
          IF ~OPENANSI('PASAN1.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&'K-Projekts'&CHR(9)&'Iespçjams izpildît'&CHR(9)&'Ir noliktavâ'&CHR(9)&'D-Projekts'&CHR(9)&'Jâpasûta'&CHR(9)&'Cena'&CHR(9)&'Summa'
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NK#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF GETNOM_K(NOL:NOMENKLAT,0,16)='R'  ! RAÞOJUMS
            CLEAR(KOM:RECORD)
            KOM:NOMENKLAT=NOL:NOMENKLAT
            SET(KOM:NOM_KEY,KOM:NOM_KEY)
            LOOP
               NEXT(KOMPLEKT)
               IF ERROR() OR ~(KOM:NOMENKLAT=NOL:NOMENKLAT) THEN BREAK.
               GET(N_TABLE,0)
               N:NOMENKLAT=KOM:NOM_SOURCE
               GET(N_TABLE,N:NOMENKLAT)
               IF ERROR()
                  N:NOMENKLAT=KOM:NOM_SOURCE
                  N:DAUDZUMS=NOL:DAUDZUMS*KOM:DAUDZUMS
                  IF ~(ATLAUTS[11]='1') !~AIZLIEGTS APSKATÎT D P/Z UN JEBKURU PIEEJU IEP CENÂM
                     N:CENA=GETNOM_K(KOM:NOM_SOURCE,0,7,6)
                  .
                  ADD(N_TABLE)
                  SORT(N_TABLE,N:NOMENKLAT)
               ELSE
                  N:DAUDZUMS+=NOL:DAUDZUMS*KOM:DAUDZUMS
                  PUT(N_TABLE)
               .
           .
        ELSE
           N:NOMENKLAT=NOL:NOMENKLAT
           GET(N_TABLE,N:NOMENKLAT)
           IF ERROR()
             N:NOMENKLAT=NOL:NOMENKLAT
             N:DAUDZUMS=NOL:DAUDZUMS
             IF ~(ATLAUTS[11]='1') !~AIZLIEGTS APSKATÎT D P/Z UN JEBKURU PIEEJU IEP CENÂM
                N:CENA=NOM:PIC
             .
             ADD(N_TABLE)
             SORT(N_TABLE,N:NOMENKLAT)
           ELSE
             N:DAUDZUMS+=NOL:DAUDZUMS
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     LOOP I#= 1 TO RECORDS(N_TABLE)
       GET(N_TABLE,I#)
!       G#=GETPAVADZ(NOL:U_NR)
       NOSAUKUMS=GETNOM_K(N:NOMENKLAT,2,2)
       IESPEJAMS=GETNOM_A(N:NOMENKLAT,1,0)
       NOM_ATLIKUMS=GETNOM_A(N:NOMENKLAT,1,0)
       NOM_D_PROJEKTS=GETNOM_A(N:NOMENKLAT,2,0)
       JAPASUTA=N:DAUDZUMS-IESPEJAMS-NOM_D_PROJEKTS
       IF JAPASUTA<0 THEN JAPASUTA=0.
       IF IESPEJAMS<0 THEN IESPEJAMS=0.
       ITOGO = JAPASUTA*N:CENA
       IF F:DBF='W'
            PRINT(RPT:DETAIL)
       ELSE
            OUTA:LINE=N:NOMENKLAT&CHR(9)&NOSAUKUMS&CHR(9)&LEFT(FORMAT(N:DAUDZUMS,@N_10.3))&CHR(9)&|
            LEFT(FORMAT(IESPEJAMS,@N_10.3))&CHR(9)&LEFT(FORMAT(NOM_ATLIKUMS,@N-_11.3))&CHR(9)&|
            LEFT(FORMAT(NOM_D_PROJEKTS,@N-_11.3))&CHR(9)&LEFT(FORMAT(JAPASUTA,@N-_11.3))&CHR(9)&|
            LEFT(FORMAT(N:Cena,@N-_11.3))&CHR(9)&LEFT(FORMAT(ITOGO,@N-_11.3))
            ADD(OUTFILEANSI)
       END
       DAUDZUMSK+=N:DAUDZUMS
       IESPEJAMSK+=IESPEJAMS
       ITOGOK += ITOGO
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
        PRINT(RPT:RPT_FOOT3)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ:'&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N_10.3))&CHR(9)&LEFT(FORMAT(IESPEJAMSK,@N_10.3))&CHR(9)&|
        CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_11.3))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
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
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  IF F:DBF<>'W' THEN F:DBF='W'.
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
  IF ERRORCODE() OR NOL:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLIK')
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
!**************************************************************************
!****************PASÛTÎJUMU ANALÎZE
! IF DBF
!    FILENAME1=SUB(REPORTNAME,1,INSTRING('.',REPORTNAME,1,1))&'DBF'
!    CHECKOPEN(DBFFILE)
!    CLOSE(DBFFILE)
!    OPEN(DBFFILE,18)
!    EMPTY(DBFFILE)
! .
omit('Maris')
NEXT_RECORD ROUTINE                              !GET NEXT RECORD
  LOOP UNTIL EOF(nolik)                          !  READ UNTIL END OF FILE
    NEXT(nolik)                                  !    READ NEXT RECORD
    I# += 1
    SHOW(15,32,I#,@N_5)
!   IF ~(nol:pazime=DK AND NOL:DATUMS<=B_DAT AND S_DAT<=NOL:DATUMS)
    IF ~(nol:pazime=D_K)
        CYCLE
    .
!   IF CYCLENOM(NOL:NOMENKLAT) THEN CYCLE.          !FILTRS PðC NOMENKLATÞTAS
    IF NOL:NR=1 THEN CYCLE.                         !SALDO
!   GETPAR_K(NOL:PAR_NR)                            !POZICIONð PAR_K
!   IF ~GRP() THEN CYCLE.                           !FILTRS PðC PARTNERA GRUPAS
    GETPAVADZ(NOL:NR)                               !POZICIONð PAVADZ×MES
!   IF ~RST() THEN CYCLE.
!   IF TIPS AND ~(PAV:TIPS=TIPS) THEN CYCLE.        !FILTRS PðC TIPA
    EXIT                                         !    EXIT THE ROUTINE
  .                                              !
  DONE# = 1                                      !  ON EOF, SET DONE FLAG
Maris
N_RealAn             PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(NOM_K)
                       PROJECT(NOM:NOMENKLAT)
                     END
!------------------------------------------------------------------------
NR                   DECIMAL(5)
RPT_NR               DECIMAL(5)
NOS_P                STRING(50)
SUMMA2               DECIMAL(9,2)
SUMMA3               DECIMAL(9,2)
SUMMA4               DECIMAL(9,2)
SUMMA5               DECIMAL(6,2)
SUMMA6               DECIMAL(9,2)
SUMMA7               DECIMAL(6,2)
SUMMA8               DECIMAL(9,2)
SUMMA9               DECIMAL(6,2)
SUMMA10              DECIMAL(9,2)
SUMMA11              DECIMAL(6,2)
SUMMA12              DECIMAL(6,2)
SUMMA2k               DECIMAL(9,2)
SUMMA3k               DECIMAL(9,2)
SUMMA4k               DECIMAL(9,2)
SUMMA5k               DECIMAL(6,2)
SUMMA6k               DECIMAL(9,2)
SUMMA7k               DECIMAL(6,2)
SUMMA8k               DECIMAL(9,2)
SUMMA9k               DECIMAL(6,2)
SUMMA10k              DECIMAL(9,2)
SUMMA11k              DECIMAL(6,2)
SUMMA12k              DECIMAL(6,2)
DAT                  DATE
LAI                  TIME
SUMMALS              DECIMAL(12,2)
!SUMMA                DECIMAL(12,2),DIM(12)
!BLUE              FILE,PRE(B),DRIVER('dBase3'),NAME(FILENAME1)
!RECORD              RECORD
!INV                   STRING(@N_10)
!NET                   STRING(@N_3)
!PLU                   STRING(14)
!DEPT                  STRING(@N_3)
!PRICE                 STRING(@N_10.2)
!QTY                   STRING(@N_10.3)
!SUMM                  STRING(@N_12.2)
!DISC                  STRING(@N_12.2)
!DISCPCN               STRING(@N_5.2)
!CRC                   STRING(8)
!                  . .
!**
N_TABLE              QUEUE,PRE(N)
NOMENKLAT            STRING(15)
KODS                 DECIMAL(12)
REALPIC              DECIMAL(8,2)
REALFAKT             DECIMAL(8,2)
C                    DECIMAL(8,2)
D                    DECIMAL(5,2)
VIDATL               DECIMAL(11,3)
F                    DECIMAL(5,2)
G                    DECIMAL(8,2)
H                    DECIMAL(5,2)
REALSKAIC            DECIMAL(5)
K                    DECIMAL(5,2)
J                    DECIMAL(7,3)
                     .
SKAITS               DECIMAL(11,3)
LASTCEKS             DECIMAL(10)
MAXD                 DECIMAL(8,2)
ATLIKUMS             DECIMAL(11,3)
!ATLIKUMSK           DECIMAL(11,3)
!ATLIKUMAD           DECIMAL(3)
SV                   DECIMAL(11,3)
LASTDATE             LONG
LASTATLI             DECIMAL(11,3)
MAXF                 DECIMAL(11,3)
MAXH                 DECIMAL(8,2)
MAXR                 DECIMAL(8,2)
!DBFFILE           FILE,PRE(DBF),DRIVER('dBase3'),CREATE,NAME(FILENAME1)
!RECORD              RECORD
!NOMENKLAT             STRING(15)
!SUMMA1                STRING(@N-_12.2)
!SUMMA2                STRING(@N-_12.2)
!SUMMA3                STRING(@N-_12.2)
!SUMMA4                STRING(@N-_12.2)
!SUMMA5                STRING(@N-_12.2)
!SUMMA6                STRING(@N-_12.2)
!SUMMA7                STRING(@N-_12.2)
!SUMMA8                STRING(@N-_12.2)
!SUMMA9                STRING(@N-_12.2)
!SUMMA10               STRING(@N-_12.2)
!SUMMA11               STRING(@N-_12.3)
!                  . .
!-----------------------------------------------------
report REPORT,AT(200,2000,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),LANDSCAPE,THOUS
       HEADER,AT(200,500,12000,1500)
         LINE,AT(11042,729,0,781),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(52,1458,10990,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('summâs'),AT(4406,1292,729,156),USE(?String11:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(5198,1250,729,208),USE(?String11:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('peïòa'),AT(5979,1250,625,208),USE(?String11:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('relat. %'),AT(6656,1250,521,208),USE(?String11:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('noliktavâ'),AT(7229,1250,625,208),USE(?String11:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('relat. %'),AT(7906,1250,521,208),USE(?String11:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('koeficients'),AT(8479,1250,729,208),USE(?String11:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('relat. %'),AT(9260,1250,521,208),USE(?String11:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('skaits'),AT(9833,1250,625,208),USE(?String11:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('%'),AT(10510,1250,521,208),USE(?String11:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Realizâcijas analîze'),AT(2031,469,1667,260),USE(?String2:2),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(3750,469),USE(S_DAT),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(4844,469),USE(B_DAT),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA AN3'),AT(9375,521,885,156),USE(?String9:2),LEFT 
         STRING(@P<<<#. lapaP),AT(10260,521,,156),PAGENO,USE(?PageCount),RIGHT 
         LINE,AT(52,729,11000,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(521,729,0,781),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Nomenklatûras filtrs :'),AT(729,781,1302,208),USE(?String11:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(2083,781,1406,208),USE(NOMENKLAT),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(104,781,417,208),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,990,10521,0),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(4375,990,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5156,990,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5938,990,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6615,990,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7188,990,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7865,990,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(8438,990,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(9219,990,0,521),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(9792,990,0,521),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(10469,990,0,521),USE(?Line28),COLOR(COLOR:Black)
         STRING('Realizâciju'),AT(9833,1042,625,208),USE(?String11:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Reitings'),AT(10510,1042,521,208),USE(?String11:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Realizâcija'),AT(4417,1000,729,156),USE(?String11:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces nosaukums'),AT(781,1042,3594,208),USE(?String11:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iepirkuma'),AT(4406,1146,729,156),USE(?String11:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Realizâcijas'),AT(5198,1042,729,208),USE(?String11:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosacîtâ'),AT(5979,1042,625,208),USE(?String11:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Peïòas'),AT(6656,1042,521,208),USE(?String11:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vid. atlik.'),AT(7229,1042,625,208),USE(?String11:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlik.'),AT(7906,1042,521,208),USE(?String11:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Apgroz.'),AT(8479,1042,729,208),USE(?String11:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Apgroz.'),AT(9260,1042,521,208),USE(?String11:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,729,0,781),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(1302,156,4323,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktavas :'),AT(5677,156,938,260),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(6615,156,313,260),USE(LOC_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(4688,469,156,260),USE(?String2:3),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(4375,-10,0,197),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,197),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,197),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(6615,-10,0,197),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,197),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,197),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(8438,-10,0,197),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(9219,-10,0,197),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(9792,-10,0,197),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(10469,-10,0,197),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,197),USE(?Line2:22),COLOR(COLOR:Black)
         STRING(@n_5),AT(104,10,365,156),USE(RPT_NR),RIGHT 
         LINE,AT(521,-10,0,197),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@s50),AT(729,10,3438,156),USE(NOS_p),LEFT 
         STRING(@N_9.2B),AT(4531,10,573,156),USE(SUMMA2),RIGHT 
         STRING(@N_9.2B),AT(5313,10,573,156),USE(SUMMA3),RIGHT 
         STRING(@N_9.2B),AT(5990,10,573,156),USE(SUMMA4),RIGHT 
         STRING(@N_6.2B),AT(6771,10,365,156),USE(SUMMA5),RIGHT 
         STRING(@N_9.2B),AT(7240,10,573,156),USE(SUMMA6),RIGHT 
         STRING(@N_6.2B),AT(8021,10,365,156),USE(SUMMA7),RIGHT 
         STRING(@N_9.2B),AT(8594,10,573,156),USE(SUMMA8),RIGHT 
         STRING(@N_6.2B),AT(9375,10,365,156),USE(SUMMA9),RIGHT 
         STRING(@N_9.2B),AT(9844,10,573,156),USE(SUMMA10),RIGHT 
         STRING(@N_6.2B),AT(10625,10,365,156),USE(SUMMA11),RIGHT 
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(52,-10,0,114),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,62),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,114),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,114),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,114),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(6615,-10,0,114),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(52,52,11000,0),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,114),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(10469,-10,0,114),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(9792,-10,0,114),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(8438,-10,0,114),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(9219,-10,0,114),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,114),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,114),USE(?Line37),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,417)
         LINE,AT(52,-10,0,62),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,62),USE(?Line45),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,62),USE(?Line46),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,62),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,62),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(6615,-10,0,62),USE(?Line49),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,62),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,62),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(8438,-10,0,62),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(9219,-10,0,62),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(9792,-10,0,62),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(10469,-10,0,62),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,62),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(52,52,11000,0),USE(?Line57),COLOR(COLOR:Black)
         STRING('Sastadîja :'),AT(260,156,677,208),USE(?String47),LEFT 
         STRING(@s8),AT(938,156),USE(ACC_kods),LEFT 
         STRING('RS :'),AT(1771,156,313,208),USE(?String47:2),LEFT 
         STRING(@s1),AT(2083,156),USE(RS),CENTER 
         STRING(@d6),AT(9323,156),USE(dat) 
         STRING(@t4),AT(10260,156),USE(lai) 
       END
       FOOTER,AT(200,7800,12000,63)
         LINE,AT(52,0,11000,0),USE(?Line58),COLOR(COLOR:Black)
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
!*************************************************************************
!** Realizâcijas analîze
!*************************************************************************
!*************************************************************************
!** POLYPLASTAM NO BLUEBRIDGE
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  CHECKOPEN(PAR_K,1)
  BIND('CYCLENOM',CYCLENOM)
!!  BIND('S_DAT',S_DAT)
!!  BIND('B_DAT',B_DAT)
  I# = 0
  C#=0
!!  IF DBF
!!     FILENAME1=SUB(REPORTNAME,1,INSTRING('.',REPORTNAME,1,1))&'DBF'
!!     CHECKOPEN(DBFFILE)
!!     CLOSE(DBFFILE)
!!     OPEN(DBFFILE,18)
!!     EMPTY(DBFFILE)
!!  .
  DONE# = 0                                      !TURN OFF DONE FLAG
  NR#     = 0
  SUMMA2K  =0
  SUMMA3K  =0
  SUMMA10K =0
  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  BIND(NOL:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Completed'
  ProgressWindow{Prop:Text} = 'Generating Report'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      NOM:NOMENKLAT=NOMENKLAT
      SET(NOM:NOM_KEY,NOM:NOM_KEY)
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
        N#+=1
        N:NOMENKLAT =NOM:NOMENKLAT
        N:KODS      =INT(NOM:KODS/10)
        N:REALPIC   =0
        N:REALFAKT  =0
        N:C         =0
        N:D         =0
        N:VIDATL    =0
        N:F         =0
        N:G         =0
        N:H         =0
        N:REALSKAIC =0
        N:K         =0
        ATLIKUMS    =0
   !    ATLIKUMSK   =0
   !    ATLIKUMAD   =0
        MAXD        =0
        MAXF        =0
        MAXH        =0
        DONENOL#    =0
        SKAITS      =0
        SV          =0
        LASTDATE    =S_DAT
        LASTATLI    =0
        CLEAR(NOL:RECORD)
        NOL:NOMENKLAT=NOM:NOMENKLAT
        SET(NOL:NOM_KEY,NOL:NOM_KEY)
        DO NEXTNOL
        LOOP UNTIL DONENOL#
           IF NOL:D_K='D'
              ATLIKUMS+=NOL:DAUDZUMS
           ELSIF NOL:D_K='K'
              ATLIKUMS-=NOL:DAUDZUMS
           .
           IF INRANGE(NOL:DATUMS,S_DAT,B_DAT) AND NOL:D_K='K' AND ~INRANGE(NOL:PAR_NR,1,25)
              N:REALFAKT  +=CALCSUM(16,2) ! REALIZÂCIJAS SUMMA
              N:REALSKAIC += 1            ! CIK REIZES REALIZÇTS
              SKAITS      +=NOL:DAUDZUMS  ! CIK VIENÎBAS REALIZÇTAS
           .
           IF INRANGE(NOL:DATUMS,S_DAT,B_DAT)
              SV         +=(NOL:DATUMS-LASTDATE)*LASTATLI
              LASTDATE    =NOL:DATUMS
              LASTATLI    =ATLIKUMS
           ELSE
              LASTDATE    =S_DAT
              LASTATLI    =ATLIKUMS
           .
           DO NEXTNOL
        .
        SV += (B_DAT-LASTDATE+1)*LASTATLI
        N:VIDATL=(SV/(B_DAT-S_DAT+1))*NOM:PIC
   !    N:REALPIC   =NOM:PIC*SKAITS
        N:REALPIC   =NOM:PIC*SKAITS/(b_dat-s_dat+1)  ! 27/09/99
        N:REALFAKT  =N:REALFAKT/(B_DAT-S_DAT+1)      ! 27/09/99
        N:C=N:REALFAKT-N:REALPIC
   !    Apgrozîjuma koeficients var aiziet bezgalîbâ , tâpçc :
        IF N:VIDATL > 0
           NG$=N:REALPIC/N:VIDATL
        ELSE
           NG$=999999.99
        .
        IF NG$ > 999999.99
           N:G=999999.99
        ELSE
           N:G=NG$
        .
   !    ********************************************************
   !    IF ~(N:REALFAKT=0 AND N:VIDATL=0)
        IF N:REALFAKT>0 AND N:VIDATL>0          ! 22/07/99
           ADD(N_TABLE)
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
  IF SEND(NOM_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    SORT(N_TABLE,-N:C)                         ! relatîvâ peïòa
    LOOP I#=1 TO RECORDS(N_TABLE)
    GET(N_TABLE,I#)
        IF I#=1 THEN MAXD=N:C.
        N:D=N:C/MAXD*100
        IF N:D<0 THEN N:D=0.
        PUT(N_TABLE)
    .
    SORT(N_TABLE,-N:VIDATL)                    ! relatîvais atlikums
    LOOP I#=1 TO RECORDS(N_TABLE)
    GET(N_TABLE,I#)
        IF I#=1 THEN MAXF=N:VIDATL.
        N:F=100-(N:VIDATL/MAXF*100)
        IF N:F > 100 THEN N:F=100.
        PUT(N_TABLE)
    .
    SORT(N_TABLE,-N:G)                         ! apgrozîjuma koeficients
    LOOP I#=1 TO RECORDS(N_TABLE)
    GET(N_TABLE,I#)
        IF I#=1 THEN MAXH=N:G.
        N:H=N:G/MAXH*100
        PUT(N_TABLE)
    .
    SORT(N_TABLE,-N:REALSKAIC)                 ! realizâciju skaits
    LOOP I#=1 TO RECORDS(N_TABLE)
    GET(N_TABLE,I#)
        IF I#=1 THEN MAXR=N:REALSKAIC.
        N:K=N:REALSKAIC/MAXR*100
        PUT(N_TABLE)
    .
    LOOP I#=1 TO RECORDS(N_TABLE)              ! REITINGS
    GET(N_TABLE,I#)
        NJ$=(N:D*N:F*N:H*N:K)/1000000
        N:J=NJ$
        PUT(N_TABLE)
    .
    SORT(N_TABLE,-N:J)
    DO WRDETAIL
    PRINT(RPT:RPT_FOOT3)
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
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
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR CYCLENOM(NOM:NOMENKLAT)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOM_K')
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
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
NEXTNOL      ROUTINE
  LOOP UNTIL EOF(NOLIK)
    NEXT(NOLIK)
    IF ~(NOL:NOMENKLAT=NOM:NOMENKLAT) THEN BREAK.
    IF ~INSTRING(NOL:D_K,'DK') THEN CYCLE.
    IF ~(NOL:DATUMS<=B_DAT) THEN CYCLE.
    EXIT
 .
 DONENOL# = 1
WRDETAIL    ROUTINE
     LOOP I#=1 TO RECORDS(N_TABLE)
     GET(N_TABLE,I#)
        NR#+=1
        RPT_NR=NR#
        NOS_P  =N:NOMENKLAT
        SUMMA2 =N:REALPIC
        SUMMA3 =N:REALFAKT
        SUMMA4 =N:C
        SUMMA5 =N:D
        SUMMA6 =N:VIDATL
        SUMMA7 =N:F
        SUMMA8 =N:G
        SUMMA9 =N:H
        SUMMA10=N:REALSKAIC
        SUMMA11=N:K
        SUMMA12=N:J
        PRINT(RPT:DETAIL)
        SUMMA2K +=N:REALPIC
        SUMMA3K +=N:REALFAKT
        SUMMA10K+=N:REALSKAIC
        SUMMA4k +=N:C
        SUMMA6k +=N:VIDATL
!!??        DO WRITEDBF
!    ELSIF SUMMALS>=MAXSUMMA AND SUMMALS>0 AND LIELMAZ='M' OR|
!    SUMMALS<=MAXSUMMA AND LIELMAZ='L'
     .
OMIT('DIANA')
WRITEDBF ROUTINE
        IF DBF
           DBF:NOMENKLAT=N:NOMENKLAT
           DBF:SUMMA1  = N:REALPIC
           DBF:SUMMA2  = N:REALFAKT
           DBF:SUMMA3  = N:C
           DBF:SUMMA4  = N:D
           DBF:SUMMA5  = N:VIDATL
           DBF:SUMMA6  = N:F
           DBF:SUMMA7  = N:G
           DBF:SUMMA8  = N:H
           DBF:SUMMA9  = N:REALSKAIC
           DBF:SUMMA10 = N:K
           DBF:SUMMA11 = N:J
           ADD(DBFFILE)
        .
BLUE     ROUTINE
        SORT(N_TABLE,N:kods)                 ! kodu secîbâ
        LOOP I# = S_DAT TO B_DAT
           FILENAME1='\NETPOS\ARHIV\'&CLIP(FORMAT(I#,@D12))&'.TZB'
           OPEN(BLUE)
           IF ERROR()
              STOP('Nav atrodams '&filename1)
              cycle
           .
           set(blue)
           LOOP
              next(blue)
              if error() then break.
              IF ~((SYS:AVOTA_NR=6 AND B:NET=1) OR|
                   (SYS:AVOTA_NR=1 AND B:NET=2))
                 CYCLE
              .
              n:kods=b:plu
              get(n_table,n:kods)
              if error()
!                STOP(N:KODS)
                 cycle
              .
              if lastceks=b:inv then cycle.
              n:realSKAIC+=1
!             STOP(N:NOMENKLAT&' '&N:REALSKAIC)
              lastceks=b:inv
              put(n_table)
              if error() then stop(error()).
           .
           CLOSE(BLUE)
        .
NEXTNOM      ROUTINE
 LOOP UNTIL EOF(NOM_K)
    NEXT(NOM_K)
    IF CYCLENOM(NOM:NOMENKLAT) THEN CYCLE.
    EXIT
 .
 DONENOM# = 1
DIANA
