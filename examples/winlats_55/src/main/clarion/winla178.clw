                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_LielPPAtsk         PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(PAR_K)
                       PROJECT(NOS_S)
                       PROJECT(TIPS)
                       PROJECT(U_NR)
                       PROJECT(PVN)
                       PROJECT(PASE)
                       PROJECT(GRUPA)
                       PROJECT(ADRESE)
                     END
!------------------------------------------------------------------------
NPK                     USHORT
NOS_P                   STRING(50) !PAR:NOS_P/DOK_SENR
DOK_SENR                STRING(50)
KOPA                    STRING(6)

P_TABLE              QUEUE,PRE(P)
VAL                     STRING(3)
SUMMA1                  DECIMAL(12,2)
SUMMA2                  DECIMAL(12,2)
SUMMA3                  DECIMAL(12,2)
                     .

SUMMA1                  DECIMAL(12,2)
SUMMA2                  DECIMAL(12,2)
SUMMA3                  DECIMAL(12,2)
SUMMA1P                 DECIMAL(12,2)
SUMMA2P                 DECIMAL(12,2)
SUMMA3P                 DECIMAL(12,2)
SUMMA1K                 DECIMAL(12,2)
SUMMA2K                 DECIMAL(12,2)
SUMMA3K                 DECIMAL(12,2)
DAT                     DATE
LAI                     TIME
NOLIKTAVA_TEXT          STRING(30)
VIRSRAKSTS              STRING(66)
FORMA                   STRING(10)
FILTRS_TEXT             STRING(100)
TAB_2_TEXT              STRING(15)
CP                      STRING(10)
CN                      STRING(10)

!-------------------------------------------------------------
report REPORT,AT(198,1750,8000,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,198,8000,1552),USE(?unnamed:2)
         STRING(@s10),AT(6635,677,677,156),USE(FORMA),RIGHT(1),FONT(,8,,)
         STRING(@s100),AT(375,823,6354,208),USE(FILTRS_TEXT),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6688,844,625,156),PAGENO,USE(?PageCount),RIGHT(1),FONT(,8,,)
         LINE,AT(260,1042,6979,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(677,1042,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3750,1042,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('NPK'),AT(292,1198,365,208),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(979,1198,1823,208),USE(TAB_2_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu summa'),AT(3792,1094,938,208),USE(?String11:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu summa'),AT(4781,1094,1250,208),USE(?String11:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6042,1042,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4740,1042,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('t.s. Atlaide'),AT(6083,1188,1146,208),USE(?String11:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7240,1042,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(260,1510,6979,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(260,1042,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(1260,94,4583,198),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(2292,302,2552,167),USE(NOLIKTAVA_TEXT),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(542,521,6042,167),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(3792,1302,938,208),USE(?String11:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN'),AT(4781,1302,1250,208),USE(?String11:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(260,-10,0,198),USE(?Line8),COLOR(COLOR:Black)
         STRING(@N_4B),AT(313,10,313,156),USE(NPK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(677,-10,0,198),USE(?Line8:2),COLOR(COLOR:Black)
         STRING(@s50),AT(729,0,2969,156),USE(NOS_P,,?NOS_P:2),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(5729,0,260,156),USE(P:VAL),CENTER,FONT(,8,,,CHARSET:ANSI)
         LINE,AT(3750,-10,0,198),USE(?Line8:3),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(6458,10,729,156),USE(P:SUMMA3),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4740,-10,0,198),USE(?Line8:4),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(4854,10,781,156),USE(P:Summa2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7240,-10,0,198),USE(?Line8:13),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,198),USE(?Line8:11),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(3854,10,781,156),USE(P:Summa1),RIGHT,FONT(,8,,,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(260,-10,0,115),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,63),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(3750,-10,0,115),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,115),USE(?Line17:4),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,115),USE(?Line17:486),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,115),USE(?Line171),COLOR(COLOR:Black)
         LINE,AT(260,52,6979,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(7240,-10,0,198),USE(?Line48:13),COLOR(COLOR:Black)
         LINE,AT(3750,-10,0,198),USE(?Line8:8),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(3823,10,,156),USE(SUMMA1K),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(260,-10,0,198),USE(?Line8:6),COLOR(COLOR:Black)
         STRING(@s6),AT(521,10,521,156),USE(KOPA),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4740,-10,0,198),USE(?Line8:10),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(4854,10,781,156),USE(Summa2K),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6042,-10,0,198),USE(?Line8:14),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(6354,10,813,156),USE(SUMMA3K),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(5729,0,260,156),USE(val_uzsk),TRN,CENTER,FONT(,8,,,CHARSET:ANSI)
       END
RPT_FOOT3 DETAIL,AT(,,,260),USE(?unnamed)
         LINE,AT(260,-10,0,63),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(3750,-10,0,63),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,63),USE(?Line291),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,63),USE(?Line929:3),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,63),USE(?Line929:386),COLOR(COLOR:Black)
         LINE,AT(260,52,6979,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(260,83,479,156),USE(?String32),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(833,83,500,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1927,83,208,156),USE(?String34),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(2135,83,208,156),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@d06.),AT(6083,83,625,156),USE(dat),RIGHT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@t4),AT(6667,83,521,156),USE(lai),RIGHT,FONT(,7,,,CHARSET:BALTIC)
       END
       FOOTER,AT(198,11050,8000,63)
         LINE,AT(260,0,6979,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!** Pircçju atskaite par visiem

  PUSHBIND
  BIND('PAR_NR',PAR_NR)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CP',CP)
  KOPA='Kopâ '

  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  CheckOpen(PAVAD,1)
  BIND(PAR:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAR_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = FORMA
  ?Progress:UserString{Prop:Text}=''
  SEND(PAR_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      NOLIKTAVA_TEXT='Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      IF D_K='K'
         VIRSRAKSTS='Atskaite par lielâkajiem preèu saòçmçjiem '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
         FORMA='FORMA IZ8'
         TAB_2_TEXT='Saòçmçjs'
      ELSE
         VIRSRAKSTS='Atskaite par lielâkajiem preèu piegâdâtâjiem '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
         FORMA='FORMA IE7'
         TAB_2_TEXT='Piegâdâtâjs'
      .
      IF F:LIELMAZ='M' !NORÂDIET MAZÂKO S, KAS....
         !18/12/2013 FILTRS_TEXT = 'Summas, kas >= Ls '&CLIP(MINMAXSUMMA)
         FILTRS_TEXT = 'Summas, kas >= '&val_uzsk&' '&CLIP(MINMAXSUMMA)
      ELSE
         IF F:IEKLAUTPK
            !18/12/2013 FILTRS_TEXT = 'Summas, kas <= Ls '&CLIP(MINMAXSUMMA)&' arî,kas nav Noliktavâ'
            FILTRS_TEXT = 'Summas, kas <= '&val_uzsk&' '&CLIP(MINMAXSUMMA)&' arî,kas nav Noliktavâ'
         ELSE
            !18/12/2013 FILTRS_TEXT = 'Summas, kas <= Ls '&CLIP(MINMAXSUMMA)&' tikai,kas ir Noliktavâ'
            FILTRS_TEXT = 'Summas, kas <= '&val_uzsk&' '&CLIP(MINMAXSUMMA)&' tikai,kas ir Noliktavâ'
         .
      .
      IF PAR_NR = 999999999 !VISI
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' '&GETFILTRS_TEXT('101100000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                                          123456789
      ELSE                  !KONKRÇTS
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' '&GETFILTRS_TEXT('100000000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                                          123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Partneris: '&CLIP(GETPAR_K(PAR_NR,2,2))&' '&GETPAR_K(PAR_NR,0,24)
         TAB_2_TEXT='Pamatojums'
      .
      CP ='R11'    !PAR_K-GRUPA-TIPS
!          123
      CN ='N10011' !P/N,RS,DvK,INRANGE(SB),=D_K,OBJEKTS
!          123456

      CLEAR(PAR:RECORD)
      SET(PAR:NOS_KEY,PAR:NOS_KEY)
      Process:View{Prop:Filter} = '~CYCLEPAR_K(CP)'
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
      ELSE !WORD/EXCEL
        IF ~OPENANSI('PIRAT.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=NOLIKTAVA_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=VIRSRAKSTS
        ADD(OUTFILEANSI)
        OUTA:LINE=FILTRS_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        IF F:dbf='E'
           OUTA:LINE='NPK'&CHR(9)&TAB_2_TEXT&CHR(9)&'Preèu summa'&CHR(9)&'Preèu summa'&CHR(9)&CHR(9)&'t.s. Atlaide'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&'bez PVN'&CHR(9)&'ar PVN'
           ADD(OUTFILEANSI)
        ELSE   !WORD
           OUTA:LINE='NPK'&CHR(9)&TAB_2_TEXT&CHR(9)&'Preèu summa bez PVN'&CHR(9)&'Preèu summa ar PVN'&CHR(9)&CHR(9)&|
           't.s. Atlaide'
           ADD(OUTFILEANSI)
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        FOUND#=FALSE
        SUMMA1P=0
        SUMMA2P=0
        SUMMA3P=0
        REC#+=1
        ?Progress:UserString{Prop:Text}=REC#
        DISPLAY(?Progress:UserString)
        CLEAR(NOL:RECORD)
        IF F:LIELMAZ='M'   !?
           NOL:DATUMS=S_DAT
        .
        NOL:PAR_NR=PAR:U_NR
        SET(NOL:PAR_KEY,NOL:PAR_KEY)
        LOOP
          NEXT(NOLIK)
          IF ERROR() OR ~(NOL:PAR_NR=PAR:U_NR AND NOL:DATUMS<=B_DAT) THEN BREAK.
          IF NOL:U_NR=1 THEN CYCLE.    !SALDO IGNORÇJAM
          IF CYCLENOL(CN) THEN CYCLE.
          FOUND#=TRUE
          SUMMA1 =0
          SUMMA2 =0
          SUMMA3 =0
          IF INRANGE(NOL:DATUMS,S_DAT,B_DAT)
             IF CYCLENOM(NOL:NOMENKLAT) THEN CYCLE.
             SUMMA1=CALCSUM(3,2)
             SUMMA2=CALCSUM(4,2)
             SUMMA3=CALCSUM(8,2)
             SUMMA1P+=CALCSUM(15,2) !Ls
             SUMMA2P+=CALCSUM(16,2) !Ls
             SUMMA3P+=CALCSUM(7,2)  !Ls
             GET(P_TABLE,0)
             P:VAL=NOL:VAL
             GET(P_TABLE,P:VAL)
             IF ERROR()
                P:VAL=NOL:VAL
                P:SUMMA1=SUMMA1
                P:SUMMA2=SUMMA2
                P:SUMMA3=SUMMA3
                ADD(P_TABLE)
                SORT(P_TABLE,P:VAL)
             ELSE
                P:SUMMA1+=SUMMA1
                P:SUMMA2+=SUMMA2
                P:SUMMA3+=SUMMA3
                PUT(P_TABLE)
             .
          .
        .
        DO WRDETAIL
        FREE(P_TABLE)
!        DOK_SENR=''
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
  IF SEND(PAR_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    END
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
!        OUTA:LINE=KOPA&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA1K,@N-_13.2))&CHR(9)&LEFT(FORMAT(SUMMA2K,@N-_13.2))&CHR(9)&|
!        'Ls'&CHR(9)&LEFT(FORMAT(SUMMA3K,@N-_13.2))
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA1K,@N-_13.2))&CHR(9)&LEFT(FORMAT(SUMMA2K,@N-_13.2))&CHR(9)&|
        val_uzsk&CHR(9)&LEFT(FORMAT(SUMMA3K,@N-_13.2))
        ADD(OUTFILEANSI)
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT3)
        ENDPAGE(report)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    .
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'. !PAGAIDÂM
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
      StandardWarning(Warn:RecordFetchError,'PAR_K')
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
WRDETAIL    ROUTINE
  PRINT#=FALSE
  IF F:LIELMAZ='M'
     IF SUMMA2P>=MINMAXSUMMA AND FOUND#=TRUE THEN PRINT#=TRUE.
  ELSE
     IF SUMMA2P<=MINMAXSUMMA AND (FOUND#=TRUE OR F:IEKLAUTPK) THEN PRINT#=TRUE.
  .
  IF PRINT#=TRUE
     NPK#+=1
     NPK=NPK#
!     IF PAR_NR = 999999999 !VISI
        NOS_P=PAR:NOS_P
!     ELSE
!        NOS_P=DOK_SENR
!     .
     IF RECORDS(P_TABLE) !DAÞÂDAS VALÛTAS 1 PARTNERIM
        LOOP I#=1 TO RECORDS(P_TABLE)
           GET(P_TABLE,I#)
           IF I#>1
              NPK=0
              NOS_P=''
           .
           DO PRDETAIL
        .
     ELSE
        P:VAL=''
        P:SUMMA1=0
        P:SUMMA2=0
        P:SUMMA3=0
        DO PRDETAIL
     .
     SUMMA1K+=SUMMA1P
     SUMMA2K+=SUMMA2P
     SUMMA3K+=SUMMA3P

  .

!-----------------------------------------------------------------------------
PRDETAIL    ROUTINE

   IF F:DBF='W'  !WMF
       PRINT(RPT:DETAIL)
   ELSE          !WORD/EXCEL
       OUTA:LINE=LEFT(format(NPK,@N_4B))&CHR(9)&NOS_P&CHR(9)&LEFT(format(P:SUMMA1,@N-_13.2))&CHR(9)&|
       LEFT(format(P:SUMMA2,@N-_13.2))&CHR(9)&P:VAL&CHR(9)&LEFT(format(P:SUMMA3,@N-_13.2))
       ADD(OUTFILEANSI)
   .
N_Izg_SPar           PROCEDURE                    ! Declare Procedure
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

NPK                 DECIMAL(4)
U_NR                ULONG
PAR_NOS_P           STRING(45)
DAUDZUMS            DECIMAL(12,3)
DAUDZUMSK           DECIMAL(14,3)
MERVIEN             STRING(7)
SUMMA_B             DECIMAL(14,2)
SUMMA_BK            DECIMAL(14,2)
SUMMA_P             DECIMAL(14,2)
SUMMA_PK            DECIMAL(14,2)
SUMMA_PVN           DECIMAL(12,2)
SUMMA_PVNK          DECIMAL(12,2)
NOS                 STRING(3)
VALK                STRING(3)
KOPA                STRING(20)
DAT                 LONG
LAI                 LONG
CN                  STRING(10)
CP                  STRING(5)

P_TABLE             QUEUE,PRE(P)
NRKEY                STRING(9)
NOS_A                STRING(12)
U_NR                 ULONG
MERVIEN              STRING(7)
DAUDZUMS             DECIMAL(12,3)
SUMMA_B              DECIMAL(14,2)
SUMMA_P              DECIMAL(14,2)
PVN                  DECIMAL(12,2)
VAL                  STRING(3)
                    .

K_TABLE             QUEUE,PRE(K)
VAL                 STRING(3)
SUMMA_P             DECIMAL(14,2)
                    .

MER                 STRING(7)
VIRSRAKSTS          STRING(110)
FILTRS_TEXT         STRING(100)


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
report REPORT,AT(198,1698,8000,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,302,8000,1396),USE(?unnamed:2)
         STRING('Summa'),AT(6594,938,1094,208),USE(?String18:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, '),AT(5865,938,677,208),USE(?String18:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5865,1146,677,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,885,0,521),USE(?Line2:15),COLOR(COLOR:Black)
         STRING('bez PVN, '),AT(4958,1146,594,208),USE(?String18:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5521,1146,302,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(6594,1146,1094,208),USE(?String18:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1354,7552,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Summa'),AT(4979,938,833,208),USE(?String18:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(3729,938,1198,208),USE(?String18:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4948,885,0,521),USE(?Line2:13),COLOR(COLOR:Black)
         STRING('Nr'),AT(552,938,417,208),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pilns nosaukums'),AT(1042,938,1615,208),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA  IZ9V'),AT(6990,531,729,167),USE(?String16),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7146,688),PAGENO,USE(?PageCount),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s100),AT(875,594,6094,208),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,885,7552,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(521,885,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(990,885,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(3698,885,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5833,885,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6563,885,0,521),USE(?Line2:12),COLOR(COLOR:Black)
         STRING('Npk'),AT(188,938,313,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,885,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(1760,52,4323,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s110),AT(156,323,7552,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(990,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@s45),AT(1031,10,2656,156),USE(PAR_NOS_P),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(3698,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@N-_12.3B),AT(3958,10,781,156),USE(DAUDZUMS),RIGHT(2),FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_14.2),AT(5000,10,781,156),USE(SUMMA_B),RIGHT(2),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5833,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6615,10,781,156),USE(SUMMA_P),RIGHT(2),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(7448,10,,156),USE(NOS),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4948,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5885,10,625,156),USE(SUMMA_PVN),RIGHT(2),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7708,-10,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@N_4),AT(208,10,260,156),USE(NPK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(521,-10,0,198),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@N_6),AT(573,10,365,156),USE(U_NR),RIGHT,FONT(,8,,,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(156,-10,0,114),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(156,52,7552,0),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,114),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,114),USE(?Line15:2),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,114),USE(?Line15:3),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,114),USE(?Line15:4),COLOR(COLOR:Black)
         LINE,AT(990,-10,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,114),USE(?Line119:2),COLOR(COLOR:Black)
         LINE,AT(3698,-10,0,114),USE(?Line119:22),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,63),USE(?Line17),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(5833,-10,0,198),USE(?Line22:2),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6615,10,781,156),USE(SUMMA_PK),RIGHT(2),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(7448,10,,156),USE(VALK),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7708,-10,0,198),USE(?Line232:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5885,10,625,156),USE(SUMMA_PVNK),RIGHT(2),FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_14.2B),AT(5000,10,781,156),USE(SUMMA_BK),RIGHT(2),FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_14.3B),AT(3854,10,885,156),USE(DAUDZUMSk),RIGHT(2),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6563,-10,0,198),USE(?Line222:3),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(3698,-10,0,198),USE(?Line22:3),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,198),USE(?Line122:4),COLOR(COLOR:Black)
         STRING(@s20),AT(260,10,1354,156),USE(KOPA),LEFT,FONT(,8,,,CHARSET:BALTIC)
       END
RPT_FOOT3 DETAIL,AT(,,,240),USE(?unnamed)
         LINE,AT(156,-10,0,63),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(3698,-10,0,63),USE(?Line26:3),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,63),USE(?Line27:2),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,63),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,63),USE(?Line126),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,63),USE(?Line26:2),COLOR(COLOR:Black)
         STRING(@T4),AT(7302,73,417,167),USE(LAI),RIGHT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1729,73,125,167),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(6750,73,521,167),USE(DAT),RIGHT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1521,73,198,167),USE(?String42:2),FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(156,52,7552,0),USE(?Line16:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(167,73),USE(?String42),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(688,73,458,167),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
       END
       FOOTER,AT(198,11000,8000,52)
         LINE,AT(156,0,7552,0),USE(?Line16:3),COLOR(COLOR:Black)
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
!  PAR V/K PARTNERIEM S_PAR
!
!
  PUSHBIND
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(PAVAD,1)
  CHECKOPEN(NOM_K,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOL',CYCLENOL)
  BIND('CYCLENOM',CYCLENOM)
  DAT = TODAY()
  LAI = CLOCK()

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
  ProgressWindow{Prop:Text} = 'Izgâjuðâs preces, S_PAR'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow

      VIRSRAKSTS='Izziòa par izgâjuðajâm ('&D_K&') precçm (S_Pircçjiem) no '&format(S_DAT,@d06.)&' lîdz '&|
      format(B_DAT,@d06.)&' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      IF PAR_NR = 999999999 !VISI
         FILTRS_TEXT=GETFILTRS_TEXT('101110000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
       ELSE   !KONKRÇTS
         FILTRS_TEXT=GETFILTRS_TEXT('100010000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Saòçmçjs: '&GETPAR_K(PAR_NR,2,2)
      .

      CN = 'N10011'
!           123456
      CP = 'N11'
      CLEAR(nol:RECORD)
      NOL:DATUMS = s_dat
      NOL:D_K = D_K
      SET(nol:DAT_KEY,NOL:DAT_KEY)
      Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT) AND ~CYCLEPAR_K(CP)'
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
          IF ~OPENANSI('IZGSPAR.TXT')
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
          IF F:DBF='E'
!             OUTA:LINE='Npk'&CHR(9)&'U_Nr'&CHR(9)&'Pilns nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez'&CHR(9)&'PVN,Ls'&|
!             CHR(9)&'Summa ar'
             OUTA:LINE='Npk'&CHR(9)&'U_Nr'&CHR(9)&'Pilns nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez'&CHR(9)&'PVN,'&val_uzsk&|
             CHR(9)&'Summa ar'
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PVN, Ls'&CHR(9)&CHR(9)&'PVN, valûtâ'
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PVN, '&val_uzsk&CHR(9)&CHR(9)&'PVN, valûtâ'
             ADD(OUTFILEANSI)
          ELSE
!             OUTA:LINE='Npk'&CHR(9)&'U_Nr'&CHR(9)&'Pilns nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez PVN, Ls'&CHR(9)&|
!             'PVN,Ls'&CHR(9)&'Summa ar PVN, valûtâ'
             OUTA:LINE='Npk'&CHR(9)&'U_Nr'&CHR(9)&'Pilns nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez PVN, '&val_uzsk&CHR(9)&|
             'PVN,'&val_uzsk&CHR(9)&'Summa ar PVN, valûtâ'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
       NK#+=1
       ?Progress:UserString{Prop:Text}=NK#
       DISPLAY(?Progress:UserString)
       C#=GETPAR_K(NOL:PAR_NR,2,1)
       G#=GETPAVADZ(NOL:U_NR)
       SUMMA_PVNK += CALCSUM(17,2)
       SUMMA_PK   += calcsum(16,2)
       SUMMA_BK   += CALCSUM(15,2)
!**************************SADALAM PÇC PARTNERIEM ********
       GET(P_TABLE,0)
       P:NRKEY=FORMAT(NOL:PAR_NR,@N_6)&NOL:VAL
       GET(P_TABLE,P:NRKEY)
       IF ERROR()
         P:NRKEY=FORMAT(NOL:PAR_NR,@N_6)&NOL:VAL
         P:NOS_A=GETPAR_K(NOL:PAR_NR,0,14)
         P:U_NR     =NOL:PAR_NR
         P:DAUDZUMS =NOL:DAUDZUMS
         P:SUMMA_B  =CALCSUM(15,2)
         P:SUMMA_P  =CALCSUM(4,2)
         P:PVN      =CALCSUM(17,2)
         P:VAL      =NOL:VAL
         ADD(P_TABLE)
         SORT(P_TABLE,P:NRKEY)
       ELSE
         P:U_NR     =NOL:PAR_NR
         P:DAUDZUMS+=NOL:DAUDZUMS
         P:SUMMA_B +=CALCSUM(15,2)
         P:SUMMA_P +=CALCSUM(4,2)
         P:PVN     +=CALCSUM(17,2)
         P:VAL      =NOL:VAL
         PUT(P_TABLE)
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
    SORT(P_TABLE,P:NOS_A)
    GET(P_TABLE,0)
    LOOP N#=1 TO RECORDS(P_TABLE)
      GET(P_TABLE,N#)
!      PAR_NOS_P = GETPAR_K(P:NR,2,1) !NOS_S
      PAR_NOS_P = GETPAR_K(P:U_NR,2,2) !NOS_P 01.02.2007
      NPK+=1
      U_NR      = P:U_NR
      DAUDZUMS  = P:DAUDZUMS
      SUMMA_B   = P:SUMMA_B
      SUMMA_P   = P:SUMMA_P
      SUMMA_PVN = P:PVN
      NOS       = P:VAL
      IF ~F:DTK
        IF F:DBF='W'
            PRINT(RPT:DETAIL)
        ELSE
            OUTA:LINE=NPK&CHR(9)&U_NR&CHR(9)&PAR_NOS_P&CHR(9)&LEFT(FORMAT(DAUDZUMS,@N-_14.3))&CHR(9)&|
            LEFT(FORMAT(SUMMA_B,@N-_14.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVN,@N_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_P,@N-_14.2))&|
            CHR(9)&NOS
            ADD(OUTFILEANSI)
        .
      .
!!     IF DBF
!!        DBF:NR       =P:NR
!!        DBF:NOS_P   = PAR:NOS_P
!!        DBF:DAUDZUMS= P:DAUDZUMS
!!        DBF:SUMMA_B = P:SUMMA_B
!!        DBF:SUMMA_P = P:SUMMA_P
!!        DBF:NOS     = P:NOS
!!        ADD(DBFFILE)
!!     .
      GET(K_TABLE,0)
      K:VAL=P:VAL
      GET(K_TABLE,K:VAL)
      IF ERROR()
        K:SUMMA_P = P:SUMMA_P
        ADD(K_TABLE,K:VAL)
        SORT(K_TABLE,K:VAL)
      ELSE
        K:SUMMA_P += P:SUMMA_P
        PUT(K_TABLE)
      .
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    .
!****************************DRUKÂJAM PÇC valûtâm **************
    KOPA = 'Kopâ:'
    !VALK = 'Ls'
    VALK = val_uzsk
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3B))&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_14.2B))&|
        CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N_12.2B))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_14.2))&CHR(9)&VALK
        ADD(OUTFILEANSI)
    .
    DAUDZUMSK  = 0
    SUMMA_BK   = 0
    SUMMA_PVNK = 0
    SUMMA_PK   = 0
    KOPA='t.s.'
    GET(K_TABLE,0)
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      IF K:SUMMA_P <>0
        SUMMA_PK = K:SUMMA_P
        VALK     = K:VAL
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3B))&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_14.2B))&|
            CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N_12.2B))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_14.2))&CHR(9)&VALK
            ADD(OUTFILEANSI)
        .
        KOPA = ''
      .
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT3)
        ENDPAGE(report)
    .
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
        .
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
  FREE(K_TABLE)
  FREE(P_TABLE)
  IF FilesOpened
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'. !PAGAIDÂM
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
N_MatNol             PROCEDURE                    ! Declare Procedure
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

DAT                  DATE
LAI                  TIME
DAUDZUMS             DECIMAL(15,3)
DAUDZUMSN            DECIMAL(15,3)
K_PROJEKTS           DECIMAL(15,3)
K_PROJEKTSN          DECIMAL(15,3)
CENA                 DECIMAL(15,4)
CENAarPVN            DECIMAL(15,4)
DAUDZUMSK            DECIMAL(15,3)
K_PROJEKTSK          DECIMAL(15,3)
NOM_VAL              STRING(3)
VALK                 STRING(3)
KOPA                 STRING(10)
MER                  STRING(7)
SUMMA_K              DECIMAL(12,2)
PLAUKTS              STRING(30)
NOLIKTAVA            STRING(50)
FORMAPN1             STRING(10)
Stringplaukts        STRING(10)

K_TABLE              QUEUE,PRE(K)
VAL                   STRING(3)
SUMMA                 DECIMAL(14,2)
                     .

VIRSRAKSTS           STRING(80)
FILTRS_TEXT          STRING(100)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOM_K)
                       PROJECT(NOM:NOMENKLAT)
                       PROJECT(NOM:EAN)
                       PROJECT(NOM:KODS)
                       PROJECT(NOM:BKK)
                       PROJECT(NOM:NOS_P)
                       PROJECT(NOM:NOS_S)
                       PROJECT(NOM:NOS_A)
                       PROJECT(NOM:PVN_PROC)
                       PROJECT(NOM:SVARSKG)
                       PROJECT(NOM:SKAITS_I)
                       PROJECT(NOM:TIPS)
                       PROJECT(NOM:KRIT_DAU)
                       PROJECT(NOM:MERVIEN)
                     END


report REPORT,AT(400,1375,12000,6500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(400,198,12000,1177),USE(?unnamed)
         STRING(@s45),AT(2760,52,4583,156),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(2063,260,5979,156),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(9302,469,833,156),USE(FORMAPN1),CENTER
         STRING(@P<<<#. lapaP),AT(10188,469,,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s100),AT(1240,469,7667,156),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,,CHARSET:ANSI)
         LINE,AT(104,677,10677,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1771,677,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(135,729,1615,208),USE(?String4:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(1802,823,833,208),USE(?String4:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2708,823,1667,208),USE(?String4:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(6021,823,885,208),USE(?String4:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena'),AT(8073,729,365,208),USE(?String4:4),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba'),AT(9688,729,1094,208),USE(?String4:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(135,938,1615,208),USE(nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(7917,938,833,208),USE(?String34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN'),AT(9688,938,1094,208),USE(?String4:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN'),AT(8802,938,833,208),USE(?String34:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1146,10677,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@S1),AT(8438,729,156,208),USE(nokl_cp),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena'),AT(8958,729,365,208),USE(?String4:11),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(9323,729,156,208),USE(nokl_cp,,?nokl_cp:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('K - Projekts'),AT(6979,833,885,208),USE(?String4:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(5031,833,938,208),USE(Stringplaukts),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8750,677,0,521),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(9635,677,0,521),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(2656,677,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5990,677,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(6927,677,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7865,677,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(10781,677,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(104,677,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,12000,146),USE(?unnamed:5)
         LINE,AT(1771,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(2656,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(6927,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N-_14.4),AT(7896,10,833,156),USE(CENA),RIGHT
         STRING(@N-_14.4),AT(8781,0,833,156),USE(CENAarPVN),RIGHT
         LINE,AT(8750,-10,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(9635,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@s21),AT(135,10,1615,156),USE(NOM:NOMENKLAT),FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_13),AT(1792,10,833,156),USE(NOM:KODS),RIGHT
         STRING(@s50),AT(2708,10,2292,156),USE(NOM:NOS_P),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_14.3),AT(6042,10,833,156),USE(DAUDZUMS),RIGHT
         STRING(@N-_14.2),AT(9688,10,781,156),USE(SUMMA),RIGHT
         STRING(@s3),AT(10521,10,260,156),USE(NOM_VAL),LEFT
         STRING(@s15),AT(5031,10,938,156),USE(PLAUKTS),LEFT(1)
         LINE,AT(10781,-10,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N-_14.3),AT(6979,10,833,156),USE(K_PROJEKTS),RIGHT
       END
detailN DETAIL,AT(,,12000,146),USE(?unnamed:2)
         LINE,AT(1771,-10,0,198),USE(?Line22:9),COLOR(COLOR:Black)
         LINE,AT(2656,-10,0,198),USE(?Line22:10),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,198),USE(?Line22:11),COLOR(COLOR:Black)
         LINE,AT(6927,-10,0,198),USE(?Line22:12),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line22:13),COLOR(COLOR:Black)
         LINE,AT(8750,-10,0,198),USE(?Line22:16),COLOR(COLOR:Black)
         LINE,AT(9635,-10,0,198),USE(?Line22:14),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line22:8),COLOR(COLOR:Black)
         STRING(@s15),AT(5031,10,938,156),USE(NOLIKTAVA),LEFT
         STRING(@N-_14.3),AT(6042,10,833,156),USE(DAUDZUMSN),RIGHT
         LINE,AT(10781,-10,0,198),USE(?Line22:18),COLOR(COLOR:Black)
         STRING(@N-_14.3),AT(6979,0,833,156),USE(K_PROJEKTSN),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,-10,12000,94)
         LINE,AT(104,0,0,115),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(1771,0,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(2656,0,0,63),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(5990,0,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(6927,0,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,115),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(8750,0,0,115),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(104,52,10677,0),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(9635,0,0,115),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(10781,0,0,115),USE(?Line23:2),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,12000,177),USE(?unnamed:3)
         LINE,AT(6927,-10,0,198),USE(?Line25:2),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line25:3),COLOR(COLOR:Black)
         STRING(@N-_15.3),AT(6979,10,833,156),USE(K_PROJEKTSK),RIGHT
         LINE,AT(8750,-10,0,198),USE(?Line25:5),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(9688,10,781,156),USE(SUMMA_K),RIGHT
         LINE,AT(9635,-10,0,198),USE(?Line25:4),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line25),COLOR(COLOR:Black)
         STRING(@s10),AT(156,10,677,156),USE(KOPA),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_15.3B),AT(5990,10,885,156),USE(DAUDZUMSK),RIGHT
         STRING(@s3),AT(10500,10,260,156),USE(VALK),LEFT
         LINE,AT(10781,-10,0,198),USE(?Line25:6),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,12000,271),USE(?unnamed:4)
         LINE,AT(104,52,10677,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(156,83),USE(?String30),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1667,83),USE(?String30:2),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1927,83),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(9625,83),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10354,83),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(688,83),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(9635,-10,0,63),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(10781,-10,0,63),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,63),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(8750,-10,0,63),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(6927,-10,0,63),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,63),USE(?Line30),COLOR(COLOR:Black)
       END
       FOOTER,AT(400,7850,12000,63)
         LINE,AT(104,0,10677,0),USE(?Line1:4),COLOR(COLOR:Black)
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
! TIEK SAUKTS NO N_IZZIÒÂM UN FAILIEM UN MultiN_IZZIÒÂM
!
  PUSHBIND

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(GLOBAL,1)
  IF NOLIK::Used = 0        
    CheckOpen(NOLIK,1)
  END
  NOLIK::USED+=1
  CHECKOPEN(SYSTEM,1)
  IF NOM_K::USED=0
     CheckOpen(NOM_K,1)
  .
  NOM_K::Used += 1
  BIND(NOM:RECORD)

  dat = today()
  lai = clock()

  FilesOpened = True
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Preèu atlikumi noliktavâ'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow

      IF F:NOA      !sauc no Failiem vai M-atskaitçm
         B_DAT=TODAY()
         Stringplaukts='Noliktava'
         FORMAPN1='FORMA FPN1'
         VIRSRAKSTS='Preèu atlikumi uz '&FORMAT(B_DAT,@D06.)&' visas noliktavas'
     ELSE          !SAUC NO NOL_IZZIÒÂM
         IF CL_NR=1671 !LATLADA
            Stringplaukts='Krâsa'
         ELSE
            Stringplaukts='Plaukts'
         .
         FORMAPN1='FORMA PN1'
         VIRSRAKSTS='Preèu atlikumi uz '&FORMAT(B_DAT,@D06.)&' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      .
      FILTRS_TEXT=GETFILTRS_TEXT('000011000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                 123456789
      IF F:ATL THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Pçc atlikumiem: '.
      IF F:ATL[1]='1' THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'+A'.
      IF F:ATL[2]='1' THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'0A'.
      IF F:ATL[3]='1' THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'-A'.

      CLEAR(nom:RECORD)
      NOM:nomenklat=nomenklat
      SET(nom:NOM_key,nom:nom_key)
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('PRATNOL.TXT')
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
        IF F:DBF='E'
           OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Numurs'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'Atlikums'&CHR(9)&|
           'K-Projekts'&CHR(9)&'Cena('&nokl_cp&')'&CHR(9)&'Cena('&nokl_cp&')'&CHR(9)&'Vçrtîba ar PVN'&CHR(9)&|
           CHR(9)&'Plaukts'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'bez PVN'&CHR(9)&'ar PVN'
           ADD(OUTFILEANSI)
        ELSE   !WORD
           OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Numurs'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'Atlikums'&CHR(9)&|
           'K-Projekts'&CHR(9)&'Cena('&nokl_cp&') bez PVN'&CHR(9)&'Cena('&nokl_cp&') bez PVN'&CHR(9)&'Vçrtîba ar PVN'&|
           CHR(9)&CHR(9)&'Plaukts'
           ADD(OUTFILEANSI)
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(NOM:NOMENKLAT) AND INSTRING(NOM:TIPS,NOM_TIPS7) 
           npk#+=1
           ?Progress:UserString{Prop:Text}=NPK#
           DISPLAY(?Progress:UserString)
!           DAUDZUMS=GETNOM_A(NOM:NOMENKLAT,1,2)     ! PÂRRÇÍINA ATLIKUMUS KONKRÇTÂ NOLIKTAVÂ
!           DAUDZUMS=LOOKATL(2)
           IF F:NOA              !VISAS NOLIKTAVAS NO FAILIEM
              DAUDZUMS=GETNOM_A(NOM:NOMENKLAT,5,0)
              K_PROJEKTS=GETNOM_A(NOM:NOMENKLAT,8,0)   !K-Projekts
           ELSE
!              IF (B_DAT=TODAY() OR B_DAT=DATE(12,31,DB_GADS)) AND RS='A' !NAV JÇGAS PÂRRÇÍINÂT  16.07.2007.-IR JÇGA
!                 DAUDZUMS=GETNOM_A(NOM:NOMENKLAT,1,0)
!                 K_PROJEKTS=GETNOM_A(NOM:NOMENKLAT,4,0)
!                 IF  CL_NR=1033 THEN  K_PROJEKTS=NOA:K_PROJEKTS[1]+NOA:K_PROJEKTS[2].   !ÍÎPSALA
!              ELSE
                 DAUDZUMS=LOOKATL(3) !KÂ F-JA NO RST
                 K_PROJEKTS=SUMMA
!              .
           .
           IF ~(NOM:REDZAMIBA=1 AND DAUDZUMS=0) !~ARHÎVS AR ATLIKUMU
              IF (DAUDZUMS>0 AND F:ATL[1]='1') OR (DAUDZUMS=0 AND F:ATL[2]='1') OR (DAUDZUMS<0 AND F:ATL[3]='1')
                EXECUTE NOKL_CP
                   CP#=00000001B
                   CP#=00000010B
                   CP#=00000100B
                   CP#=00001000B
                   CP#=00010000B
                .
                IF BAND(NOM:ARPVNBYTE,CP#) ! AR PVN
                   CenaArPvn = GETNOM_K(NOM:NOMENKLAT,0,7)
                   CENA = CenaArPVN/(1+NOM:PVN_PROC/100)
                ELSE                       ! BEZ PVN
                   CENA = GETNOM_K(NOM:NOMENKLAT,0,7)
                   CenaArPVN = CENA*(1+NOM:PVN_PROC/100)
                .
                IF ~F:NOA THEN PLAUKTS=GETNOM_ADRESE(NOM:NOMENKLAT,0).
                IF CL_NR=1671 THEN PLAUKTS=GETNOM_K(NOM:NOMENKLAT,0,25). !RINDA2PZ   Colour LATLADA

                NOM_VAL= GETNOM_K(NOM:NOMENKLAT,0,13)
                SUMMA = DAUDZUMS*CENAarPVN
                GET(K_TABLE,0)
                K:VAL=NOM_VAL
                GET(K_TABLE,K:VAL)
                IF ERROR()
                  K:VAL=NOM_VAL
                  K:SUMMA=SUMMA
                  ADD(K_TABLE)
                  IF ERROR()
                    kluda(29,'Valûtas-'&k:VAL)
                    FREE(K_TABLE)
                    RETURN
                  .
                  SORT(K_TABLE,K:VAL)
                ELSE
                  K:SUMMA+=SUMMA
                  PUT(K_TABLE)
                .
                DAUDZUMSK += DAUDZUMS
                K_PROJEKTSK += K_PROJEKTS
                SUMMA_K+=SUMMA*BANKURS(NOM_VAL,B_DAT,' Nomenklatûrai:'&NOM:NOMENKLAT)
                IF ~F:DTK
                   IF F:DBF='W'              !tikai WMF t.s. noliktavas
                      IF F:NOA               !VISAS NOLIKTAVAS
                         VAIRAK_KA_1#=0
                         LOOP N#= 1 TO NOL_SK
                             IF GETNOM_A('POZICIONÇTS',1,0,N#)
                                VAIRAK_KA_1#+=1
                                FOUND#=N#
                             .
                         .
                         IF VAIRAK_KA_1#>1
                            PLAUKTS=''
                            PRINT(RPT:DETAIL)
                            LOOP N#= 1 TO NOL_SK
                                DAUDZUMSN=GETNOM_A(NOM:NOMENKLAT,1,0,N#)
                                IF DAUDZUMSN AND ~(CL_NR=1033)     !ÍÎPSALA
                                   K_PROJEKTSN=GETNOM_A(NOM:NOMENKLAT,4,0,N#)
                                   NOLIKTAVA='t.s.  N '&CLIP(N#)
                                   PRINT(RPT:DETAILN)
                                .
                            .
                         ELSE
                            PLAUKTS='N '&CLIP(FOUND#)
                            PRINT(RPT:DETAIL)
                         .
                      ELSE
                         PRINT(RPT:DETAIL)
                      .
                   ELSE                      !EXCEL NE+NN
                      OUTA:LINE=NOM:NOMENKLAT&CHR(9)&NOM:KATALOGA_NR&CHR(9)&LEFT(FORMAT(NOM:KODS,@N_13B)&'=')&CHR(9)&|
                      NOM:NOS_P&CHR(9)&LEFT(FORMAT(DAUDZUMS,@N-_15.3))&CHR(9)&LEFT(FORMAT(K_PROJEKTS,@N-_15.3))&CHR(9)&|
                      LEFT(FORMAT(CENA,@N_13.2))&CHR(9)&LEFT(FORMAT(CENAARPVN,@N_13.2))&CHR(9)&LEFT(FORMAT(SUMMA,@N-_14.2))&|
                      CHR(9)&NOM_VAL&CHR(9)&PLAUKTS
                      ADD(OUTFILEANSI)
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
  IF SEND(NOM_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT1)
    .
    KOPA='Kopâ :'
    !VALK='Ls'
    VALK=val_uzsk
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT2)
    ELSE
       OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_15.3))&CHR(9)&|
       LEFT(FORMAT(K_PROJEKTSK,@N-_15.3))&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_K,@N-_14.2))&CHR(9)&VALK
       ADD(OUTFILEANSI)
    .
    KOPA=' t.s.'
    DAUDZUMSK   = 0
    K_PROJEKTSK = 0
    !IF ~(RECORDS(K_TABLE)=1 AND K:VAL='Ls')
    IF ~(RECORDS(K_TABLE)=1 AND (((K:VAL='Ls' OR K:VAL='LVL') AND GL:DB_GADS <= 2013) OR (GL:DB_GADS > 2013 AND K:VAL=val_uzsk)))
      GET(K_TABLE,0)
      LOOP J# = 1 TO RECORDS(K_TABLE)
        GET(K_TABLE,J#)
        IF ~(K:SUMMA = 0)
          SUMMA_K = K:SUMMA
          VALK    = K:VAL
          IF F:DBF='W'   !WMF
             PRINT(RPT:RPT_FOOT2)
          ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_K,@N-_14.2))&|
            CHR(9)&VALK
            ADD(OUTFILEANSI)
          .
        .
      .
    .
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT3)
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
  free(k_table)
  IF FilesOpened
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    NOLIK::USED-=1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'. !PAGAIDÂM
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
  IF ERRORCODE() OR CYCLENOM(NOM:NOMENKLAT)=2
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
