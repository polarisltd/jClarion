                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_IZZSAL             PROCEDURE                    ! Declare Procedure
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

NPK                  USHORT
PIEGAD               STRING(20)
NOSAUKUMS            STRING(30)
SUMMA_B              DECIMAL(14,2)
SUMMA_P              DECIMAL(14,2)
KOPA                 STRING(7)
BKK                  STRING(5)
SULS                 DECIMAL(14,2)
SU                   DECIMAL(14,2)
NOS                  STRING(3)
DAT                  LONG
LAI                  LONG
VIRSRAKSTS           STRING(100)
FILTRS_TEXT          STRING(100)

K_TABLE              QUEUE,PRE(K)
NOS                   STRING(3)
SUMMA                 DECIMAL(14,2)
                     .

B_TABLE              QUEUE,PRE(B)
BKK                   STRING(5)
SUMMA                 DECIMAL(14,2)
                     .
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
                       PROJECT(NOL:RS)
                     END

report REPORT,AT(146,1323,8000,9896),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(146,146,8000,1177),USE(?unnamed)
         STRING(@s45),AT(1792,42,4323,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(1146,271,5656,156),USE(VIRSRAKSTS),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(1156,500,5656,156),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,729,7760,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(521,729,0,469),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('NPK'),AT(135,781,365,208),USE(?String5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces piegâdâtâjs'),AT(552,781,1250,208),USE(?String5:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1854,781,469,208),USE(?String5:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(2375,781,1563,208),USE(?String5:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces nosaukums'),AT(3990,781,1563,208),USE(?String5:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(5615,781,625,208),USE(?String5:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Bilances'),AT(6281,781,573,208),USE(?String5:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba'),AT(6969,781,802,208),USE(?String5:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba  '),AT(6219,969,448,156),USE(?String5:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6604,969,271,156),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valûta'),AT(7042,969,740,156),USE(?String5:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1146,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(1823,729,0,469),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(2344,729,0,469),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(3958,729,0,469),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5573,729,0,469),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6875,729,0,469),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7865,729,0,469),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(104,729,0,469),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:4)
         STRING(@D05.),AT(1854,10,469,156),USE(NOL:DATUMS),LEFT
         LINE,AT(2344,10,0,198),USE(?Line11:4),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,198),USE(?Line11:5),COLOR(COLOR:Black)
         STRING(@S30),AT(3990,10,1563,156),USE(NOSAUKUMS),LEFT
         LINE,AT(5573,-10,0,198),USE(?Line11:6),COLOR(COLOR:Black)
         STRING(@N_12.3),AT(5604,10,573,156),USE(NOL:DAUDZUMS),RIGHT
         STRING(@N_14.2),AT(6229,10,625,156),USE(SUMMA_B),RIGHT
         LINE,AT(6875,-10,0,198),USE(?Line11:7),COLOR(COLOR:Black)
         STRING(@N_14.2),AT(6906,10,625,156),USE(SUMMA_P),RIGHT
         STRING(@S3),AT(7573,10,260,156),USE(NOL:VAL),LEFT
         LINE,AT(7865,-10,0,198),USE(?Line11:8),COLOR(COLOR:Black)
         STRING(@S21),AT(2375,10,1563,156),USE(NOL:NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1823,-10,0,198),USE(?Line11:3),COLOR(COLOR:Black)
         STRING(@S20),AT(552,10,1250,156),USE(PIEGAD),LEFT
         LINE,AT(521,-10,0,198),USE(?Line11:2),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line11),COLOR(COLOR:Black)
         STRING(@N_6),AT(135,10,365,156),USE(NPK),CENTER
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(104,52,7760,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,115),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(6875,-10,0,115),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(5573,-10,0,63),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,63),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(2344,-10,0,63),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(1823,-10,0,63),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,115),USE(?Line20),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(6875,-10,0,198),USE(?Line28:2),COLOR(COLOR:Black)
         STRING(@S7),AT(208,10,521,156),USE(KOPA),LEFT
         STRING(@S5),AT(833,10,396,156),USE(BKK),LEFT
         STRING(@N_14.2B),AT(5917,10,938,156),USE(SULS),RIGHT
         STRING(@N_14.2B),AT(6906,10,625,156),USE(SU),RIGHT
         STRING(@S3),AT(7583,10,260,156),USE(NOS),LEFT
         LINE,AT(7865,-10,0,198),USE(?Line28:3),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line28),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,260),USE(?unnamed:3)
         LINE,AT(104,-10,0,63),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line32),COLOR(COLOR:Black)
         STRING(@d06.),AT(6792,104),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7406,104,458,146),USE(lai),FONT(,7,,,CHARSET:ANSI)
         STRING('Sastâdîja:'),AT(104,104,417,146),USE(?String29),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(542,104,552,146),USE(ACC_kods),CENTER,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(7865,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(6875,-10,0,63),USE(?Line33),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,11188,8000,63)
         LINE,AT(104,0,7760,0),USE(?Line32:2),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Apturçt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(PAVAD,1)

  KOPA='Kopâ:'
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
  BIND(NOM:RECORD)
  BIND(PAR:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Izziòa SALDO rakstam'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow

      VIRSRAKSTS='Izziòa SALDO rakstam. Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      FILTRS_TEXT=GETFILTRS_TEXT('000001000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                 123456789

      CLEAR(nol:RECORD)
      NOL:U_NR=1
      SET(NOL:Nr_KEY,NOL:Nr_KEY)
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
          IF ~OPENANSI('IZZSAL.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='NPK'&CHR(9)&'Preces piegâdâtâjs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&|
             'Preces nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances'&CHR(9)&'Vçrtîba'
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'vçrtîba, Ls'&CHR(9)&'valûtâ'
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'vçrtîba, '&val_uzsk&CHR(9)&'valûtâ'
             ADD(OUTFILEANSI)
          ELSE
!             OUTA:LINE='NPK'&CHR(9)&'Preces piegâdâtâjs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&|
!             'Preces nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances vçrtîba, Ls'&CHR(9)&'Vçrtîba valûtâ'
             OUTA:LINE='NPK'&CHR(9)&'Preces piegâdâtâjs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&|
             'Preces nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances vçrtîba, '&val_uzsk&CHR(9)&'Vçrtîba valûtâ'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         IF NOM_TIPS7='PTAKRIV' OR INSTRING(GETNOM_K(NOL:NOMENKLAT,0,16),NOM_TIPS7)
            npk#+=1
            ?Progress:UserString{Prop:Text}=NPK#
            DISPLAY(?Progress:UserString)
            CLEAR(NOM:RECORD)
            NOM:NOMENKLAT=NOL:NOMENKLAT
   !?         NOM:MERVIEN=NOL:MERVIEN
            GET(NOM_K,NOM:NOM_KEY)
            IF ERROR()
               NOSAUKUMS=''
               NOM:BKK='21300'
            ELSE
               NOSAUKUMS=NOM:NOS_P
            .
   !!  PARTNERI
            CLEAR(PAR:RECORD)
            PAR:U_NR=NOL:PAR_NR
            GET(PAR_K,PAR:NR_KEY)
            IF ERROR()
              PIEGAD=''
            ELSE
              PIEGAD=PAR:NOS_S
            .
   !!    PARTNERI
            NPK+=1
            SUMMA_B=CALCSUM(1,2)
            SUMMA_P=CALCSUM(3,2)
            K:NOS=NOL:VAL
            GET(K_TABLE,K:NOS)
            IF ERROR()
               K:NOS=NOL:VAL
               K:SUMMA=SUMMA_P
               ADD(K_TABLE)
               SORT(K_TABLE,K:NOS)
            ELSE
               K:SUMMA+=SUMMA_P
               PUT(K_TABLE)
            .
            B:BKK=NOM:BKK
            IF NOM:BKK=''
               B:BKK='21300'
            .
            GET(B_TABLE,B:BKK)
            IF ERROR()
               B:SUMMA=SUMMA_B
               ADD(B_TABLE)
               SORT(B_TABLE,B:BKK)
            ELSE
               B:SUMMA+=SUMMA_B
               PUT(B_TABLE)
            .
            SULS+=SUMMA_B
            IF ~F:DTK
                IF F:DBF='W'
                    PRINT(RPT:DETAIL)
                ELSE
                    OUTA:LINE=NPK&CHR(9)&PIEGAD&CHR(9)&format(NOL:DATUMS,@D06.)&CHR(9)&NOL:NOMENKLAT&CHR(9)&|
                    NOSAUKUMS&CHR(9)&LEFT(FORMAT(NOL:DAUDZUMS,@N-_14.3))&CHR(9)&LEFT(FORMAT(SUMMA_B,@N-_14.2))&CHR(9)&|
                    LEFT(FORMAT(SUMMA_P,@N-_14.2))&CHR(9)&NOL:VAL
                    ADD(OUTFILEANSI)
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
  IF F:DBF='W'
      PRINT(RPT:RPT_FOOT1)
  .
  LOOP J# = 1 TO RECORDS(K_TABLE)
     GET(K_TABLE,J#)
     IF K:SUMMA>0
       SU  =K:SUMMA
       NOS =K:NOS
       BKK =''
       IF F:DBF='W'
           PRINT(RPT:RPT_FOOT2)
       ELSE
           OUTA:LINE=KOPA&CHR(9)&BKK&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SULS,@N-_14.2))&CHR(9)&|
           LEFT(FORMAT(SU,@N-_14.2))&CHR(9)&NOS
           ADD(OUTFILEANSI)
       END
       kopa=''
       SULS = 0
     .
  .
!********************* t.s. BKK ***************************
  LOOP J# = 1 TO RECORDS(B_TABLE)
     GET(B_TABLE,J#)
     IF B:SUMMA>0
       SULS =B:SUMMA
       SU = 0   !VALÛTU NERÇÍINÂM...
       NOS =''
       BKK =B:BKK
       kopa='t.s.'
       IF F:DBF='W'
           PRINT(RPT:RPT_FOOT2)
       ELSE
           OUTA:LINE=KOPA&CHR(9)&BKK&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SULS,@N-_14.2))&CHR(9)&|
           LEFT(FORMAT(SU,@N-_14.2B))&CHR(9)&NOS
           ADD(OUTFILEANSI)
       .
       kopa=''
     .
  .
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
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
  FREE(K_TABLE)
  FREE(B_TABLE)
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
  IF ERRORCODE() OR ~(NOL:U_NR=1)
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
N_RealDinG           PROCEDURE                    ! Declare Procedure
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
!-----------------------------------------------------------------------------
NR                   DECIMAL(4)
NOS_P                STRING(50)
RPT_NOMENKLAT        STRING(21)
DAUDZUMS1            DECIMAL(9,2)
DAUDZUMS2            DECIMAL(9,2)
DAUDZUMS3            DECIMAL(9,2)
DAUDZUMS4            DECIMAL(9,2)
DAUDZUMS5            DECIMAL(9,2)
DAUDZUMS6            DECIMAL(9,2)
DAUDZUMS7            DECIMAL(9,2)
DAUDZUMS8            DECIMAL(9,2)
DAUDZUMS9            DECIMAL(9,2)
DAUDZUMS10           DECIMAL(9,2)
DAUDZUMS11           DECIMAL(9,2)
DAUDZUMS12           DECIMAL(9,2)
DAUDZUMSK1           DECIMAL(9,2)
DAUDZUMSK2           DECIMAL(9,2)
DAUDZUMSK3           DECIMAL(9,2)
DAUDZUMSK4           DECIMAL(9,2)
DAUDZUMSK5           DECIMAL(9,2)
DAUDZUMSK6           DECIMAL(9,2)
DAUDZUMSK7           DECIMAL(9,2)
DAUDZUMSK8           DECIMAL(9,2)
DAUDZUMSK9           DECIMAL(9,2)
DAUDZUMSK10          DECIMAL(9,2)
DAUDZUMSK11          DECIMAL(9,2)
DAUDZUMSK12          DECIMAL(9,2)
DAT                  LONG
LAI                  TIME
MERVIEN              STRING(6)
CN                   STRING(10)
CP                   STRING(3)
N_TABLE              QUEUE,PRE(N)
NOMENKLAT              STRING(21)
DAUDZUMS               DECIMAL(11,3),DIM(12)
                     .
!DBFFILE           FILE,PRE(DBF),DRIVER('dBase3'),CREATE,NAME(FILENAME1)
!RECORD              RECORD
!nomenklat             STRING(15)
!MERVIEN               STRING(7)
!NOS_P                 STRING(30)
!daudzums1             STRING(@N-_11.3)
!daudzums2             STRING(@N-_11.3)
!daudzums3             STRING(@N-_11.3)
!daudzums4             STRING(@N-_11.3)
!daudzums5             STRING(@N-_11.3)
!daudzums6             STRING(@N-_11.3)
!daudzums7             STRING(@N-_11.3)
!daudzums8             STRING(@N-_11.3)
!daudzums9             STRING(@N-_11.3)
!daudzums10            STRING(@N-_11.3)
!daudzums11            STRING(@N-_11.3)
!daudzums12            STRING(@N-_11.3)
!                  . .
LINEH                STRING(190)
!-----------------------------------------------------------------------------
report REPORT,AT(104,1617,8000,9698),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,200,8000,1417)
         LINE,AT(6615,1146,0,260),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(7240,1146,0,260),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(5990,1146,0,260),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(5365,1146,0,260),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(4740,1146,0,260),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(4115,1146,0,260),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(3490,1146,0,260),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(2865,1146,0,260),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(2240,1146,0,260),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(1615,1146,0,260),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@D6),AT(3802,573),USE(S_DAT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(4635,573,156,260),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(4792,573),USE(B_DAT),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6927,729,625,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(52,885,7865,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(365,885,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4792,885,0,260),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(7917,885,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('NPK'),AT(104,938,260,208),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu saòçmçjs   Grupa :'),AT(417,938,1563,208),USE(?String8:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra :'),AT(2500,938,938,208),USE(?String8:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(3438,938,1354,208),USE(nomenklat),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,1146,7552,0),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(990,1146,0,260),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('augusts'),AT(4792,1198,573,208),USE(?String8:11),CENTER
         STRING('septembris'),AT(5417,1198,573,208),USE(?String8:12),CENTER
         STRING('oktobris'),AT(6042,1198,573,208),USE(?String8:13),CENTER
         STRING('novembris'),AT(6667,1198,573,208),USE(?String8:14),CENTER
         STRING('decembris'),AT(7292,1198,625,208),USE(?String8:15),CENTER
         LINE,AT(52,1406,7865,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('janvâris'),AT(417,1198,573,208),USE(?String8:4),CENTER
         STRING('februâris'),AT(1042,1198,573,208),USE(?String8:5),CENTER
         STRING('marts'),AT(1667,1198,573,208),USE(?String8:6),CENTER
         STRING('aprîlis'),AT(2292,1198,573,208),USE(?String8:7),CENTER
         STRING('Forma IZ8V'),AT(6302,729,729,156),USE(?String2:3),LEFT
         STRING('maijs'),AT(2917,1198,573,208),USE(?String8:8),CENTER
         STRING('jûnijs'),AT(3542,1198,573,208),USE(?String8:9),CENTER
         STRING('jûlijs'),AT(4167,1198,573,208),USE(?String8:10),CENTER
         STRING(@s5),AT(1979,938),USE(PAR_grupa),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,885,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(1771,52,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktavas :'),AT(3073,313,885,260),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(4010,313,260,260),USE(LOC_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Realizâcijas dinamika pa nomenklatûrâm'),AT(417,573,3385,260),USE(?STRING),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,406)
         LINE,AT(52,-10,0,427),USE(?Line2:28),COLOR(COLOR:Black)
         STRING(@N4B),AT(104,52,260,156),USE(NR),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,-10,0,427),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@S50),AT(1927,52,3490,156),USE(NOS_P),LEFT
         STRING(@s21),AT(469,52,1406,156),USE(RPT_nomenklat),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_9.2B),AT(1042,240,573,156),USE(DAUDZUMS2),RIGHT
         STRING(@N-_9.2B),AT(1667,240,573,156),USE(DAUDZUMS3),RIGHT
         STRING(@N-_9.2B),AT(2292,240,573,156),USE(DAUDZUMS4),RIGHT
         STRING(@N-_9.2B),AT(2917,240,573,156),USE(DAUDZUMS5),RIGHT
         STRING(@N-_9.2B),AT(3542,240,573,156),USE(DAUDZUMS6),RIGHT
         STRING(@N-_9.2B),AT(4167,240,573,156),USE(DAUDZUMS7),RIGHT
         STRING(@N-_9.2B),AT(4792,240,573,156),USE(DAUDZUMS8),RIGHT
         STRING(@N-_9.2B),AT(5417,240,573,156),USE(DAUDZUMS9),RIGHT
         STRING(@N-_9.2B),AT(6042,240,573,156),USE(DAUDZUMS10),RIGHT
         STRING(@N-_9.2B),AT(6667,240,573,156),USE(DAUDZUMS11),RIGHT
         STRING(@N-_9.2B),AT(7292,240,573,156),USE(DAUDZUMS12),RIGHT
         LINE,AT(52,0,7865,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,427),USE(?Line78),COLOR(COLOR:Black)
         LINE,AT(365,208,7552,0),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(990,208,0,208),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(1615,208,0,208),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(2240,208,0,208),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(2865,208,0,208),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(3490,208,0,208),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(4115,208,0,208),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(4740,208,0,208),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(5365,208,0,208),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(5990,208,0,208),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(6615,208,0,208),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(7240,208,0,208),USE(?Line2:27),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(417,240,573,156),USE(DAUDZUMS1),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,,,52)
         LINE,AT(52,-10,0,73),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,73),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(990,-10,0,73),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,73),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(2240,-10,0,73),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(2865,-10,0,73),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(52,21,7865,0),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,73),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,73),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,73),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(6615,-10,0,73),USE(?Line46),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,73),USE(?Line45),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,73),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,73),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,73),USE(?Line42),COLOR(COLOR:Black)
       END
RPT_FOOTLS DETAIL,AT(,,,177)
         LINE,AT(6615,-10,0,198),USE(?Line2:41),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(6667,10,573,156),USE(DAUDZUMSK11),RIGHT
         LINE,AT(7240,-10,0,198),USE(?Line2:42),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(7292,10,573,156),USE(DAUDZUMSK12),RIGHT
         LINE,AT(7917,-10,0,198),USE(?Line2:43),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,198),USE(?Line2:40),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(6042,10,573,156),USE(DAUDZUMSK10),RIGHT
         LINE,AT(5365,-10,0,198),USE(?Line2:39),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(5417,10,573,156),USE(DAUDZUMSK9),RIGHT
         LINE,AT(4740,-10,0,198),USE(?Line2:38),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(4792,10,573,156),USE(DAUDZUMSK8),RIGHT
         LINE,AT(4115,-10,0,198),USE(?Line2:37),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(4167,10,573,156),USE(DAUDZUMSK7),RIGHT
         LINE,AT(3490,-10,0,198),USE(?Line2:36),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(3542,10,573,156),USE(DAUDZUMSK6),RIGHT
         LINE,AT(2865,-10,0,198),USE(?Line2:35),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(2917,10,573,156),USE(DAUDZUMSK5),RIGHT
         LINE,AT(2240,-10,0,198),USE(?Line2:34),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(2292,10,573,156),USE(DAUDZUMSK4),RIGHT
         LINE,AT(1615,-10,0,198),USE(?Line2:33),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(1667,10,573,156),USE(DAUDZUMSK3),RIGHT
         LINE,AT(990,-10,0,198),USE(?Line2:32),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(1042,10,573,156),USE(DAUDZUMSK2),RIGHT
         LINE,AT(365,-10,0,198),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@N-_9.2B),AT(417,10,573,156),USE(DAUDZUMSk1),RIGHT
         LINE,AT(52,-10,0,198),USE(?Line2:30),COLOR(COLOR:Black)
         STRING('kopâ'),AT(104,10,260,156),USE(?String8:16),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT3 DETAIL,AT(,,,417)
         LINE,AT(52,-10,0,63),USE(?Line63),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,63),USE(?Line64),COLOR(COLOR:Black)
         LINE,AT(990,-10,0,63),USE(?Line65),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,63),USE(?Line66),COLOR(COLOR:Black)
         LINE,AT(2240,-10,0,63),USE(?Line67),COLOR(COLOR:Black)
         LINE,AT(2865,-10,0,63),USE(?Line68),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,63),USE(?Line69),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,63),USE(?Line70),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,63),USE(?Line71),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,63),USE(?Line72),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,63),USE(?Line73),COLOR(COLOR:Black)
         LINE,AT(6615,-10,0,63),USE(?Line74),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,63),USE(?Line75),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,63),USE(?Line76),COLOR(COLOR:Black)
         LINE,AT(52,52,7865,0),USE(?Line77),COLOR(COLOR:Black)
         STRING('Sastadîja :'),AT(156,156),USE(?String53)
         STRING(@s8),AT(677,156),USE(ACC_kods),LEFT
         STRING('RS :'),AT(1354,156),USE(?String53:2)
         STRING(@s1),AT(1563,156),USE(RS),CENTER
         STRING(@d6),AT(6094,156),USE(dat)
         STRING(@T4),AT(7083,156),USE(lai)
       END
       FOOTER,AT(104,11200,8000,63)
         LINE,AT(52,0,7865,0),USE(?Line77:2),COLOR(COLOR:Black)
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
!  PAR VISIEM PARTNERIEM
!
!******************* izziòa par VISU partneru piegâdâtâm precçm
!                    saspiesta pçc nomenklatûrâm
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(PAVAD,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)
  S_DAT = DATE(1,1,GADS)
  B_DAT = DATE(12,31,GADS)
!  STOP('GADS '&GADS)
!  STOP('S_DAT '&FORMAT(S_DAT,@D6))
!  STOP('B_DAT '&FORMAT(B_DAT,@D6))
  D_K = 'K'
  I# = 0
  V#=0
!?  IF DBF
!?     FILENAME1=SUB(REPORTNAME,1,INSTRING('.',REPORTNAME,1,1))&'DBF'
!?     CHECKOPEN(DBFFILE)
!?     CLOSE(DBFFILE)
!?     OPEN(DBFFILE,18)
!?     EMPTY(DBFFILE)
!?  .
  NR=0
  DAT = TODAY()
  LAI = CLOCK()
!!  NOL_TEX = FORMAT_NOLTEX25()
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
  ?Progress:PctText{Prop:Text} = '0% Completed'
  ProgressWindow{Prop:Text} = 'Generating Report'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
      CN = 'N1101'
      CP = 'N11'
      CLEAR(nol:RECORD)                              !MAKE SURE RECORD CLEARED
      NOL:DATUMS = S_DAT
      NOL:D_K = D_K
      SET(nol:DAT_KEY,NOL:DAT_KEY)                   !  POINT TO FIRST RECORD
      Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT) AND ~CYCLEPAR_K(CP)'
      IF ERRORCODE()
        STOP(ERROR())
        StandardWarning(Warn:ViewOpenError)
      END
      OPEN(Process:View)
      IF ERRORCODE()
        STOP(ERROR())
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
          IF ~OPENANSI('NOMDIN.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(CLIENT)&' NOLIKTAVA: '&LOC_NR
          ADD(OUTFILEANSI)
          IF F:DBF='E'
              OUTA:LINE='REALIZÂCIJAS DINAMIKA PA NOMENKLATÛRÂM '&format(S_DAT,@d10.)&' LÎDZ '&format(B_DAT,@d10.)&' forma IZ8V'
              ADD(OUTFILEANSI)
          ELSE
              OUTA:LINE='REALIZÂCIJAS DINAMIKA PA NOMENKLATÛRÂM '&format(S_DAT,@d6)&' LÎDZ '&format(B_DAT,@d6)&' forma IZ8V'
              ADD(OUTFILEANSI)
          END
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
          OUTA:LINE='  Npk'&CHR(9)&'Grupa '&PAR_GRUPA&CHR(9)&'Nomenklatûra:'&CHR(9)&NOMENKLAT&CHR(9)&'Preèu saòçmçjs'
          ADD(OUTFILEANSI)
          OUTA:LINE='  JANVÂRIS'&CHR(9)&' FEBRUÂRIS'&CHR(9)&'     MARTS'&CHR(9)&'   APRÎLIS'&CHR(9)&'     MAIJS'&CHR(9)&'    JÛNIJS'&CHR(9)&'    JÛLIJS'&CHR(9)&'   AUGUSTS'&CHR(9)&'SEPTEMBRIS'&CHR(9)&'  OKTOBRIS'&CHR(9)&' NOVEMBRIS'&CHR(9)&' DECEMBRIS'
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
!**************************SADALAM PÇC NOMENKLATÛRÂM ********
        C#=GETPAR_K(NOL:PAR_NR,2,1)                 !POZICIONÇ PAR_K
        G#=GETPAVADZ(NOL:U_NR)                  !POZICIONÇ PAVADZÎMES
        GET(N_TABLE,0)
        N:NOMENKLAT=NOL:NOMENKLAT
        GET(N_TABLE,N:NOMENKLAT)
        IF ERROR()
          N:NOMENKLAT=NOL:NOMENKLAT
          CLEAR(N:DAUDZUMS)
          N:DAUDZUMS[MONTH(NOL:DATUMS)] =NOL:DAUDZUMS
          ADD(N_TABLE)
          SORT(N_TABLE,N:NOMENKLAT)
        ELSE
          N:DAUDZUMS[MONTH(NOL:DATUMS)]+=NOL:DAUDZUMS
          PUT(N_TABLE)
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
    LOOP N#=1 TO RECORDS(N_TABLE)
      GET(N_TABLE,N#)
      GET(NOM_K,0)
      CLEAR(NOM:RECORD)
      NOM:NOMENKLAT=N:NOMENKLAT
      GET(NOM_K,NOM:NOM_key)
      IF ERROR()
        NOS_P='Nav atrasts'
        ELSE
        NOS_P=NOM:NOS_P
      .
      NR+=1
      RPT_NOMENKLAT= N:NOMENKLAT
      MERVIEN  = NOM:MERVIEN
      DAUDZUMS1 = N:DAUDZUMS[1]
      DAUDZUMS2 = N:DAUDZUMS[2]
      DAUDZUMS3 = N:DAUDZUMS[3]
      DAUDZUMS4 = N:DAUDZUMS[4]
      DAUDZUMS5 = N:DAUDZUMS[5]
      DAUDZUMS6 = N:DAUDZUMS[6]
      DAUDZUMS7 = N:DAUDZUMS[7]
      DAUDZUMS8 = N:DAUDZUMS[8]
      DAUDZUMS9 = N:DAUDZUMS[9]
      DAUDZUMS10 = N:DAUDZUMS[10]
      DAUDZUMS11 = N:DAUDZUMS[11]
      DAUDZUMS12 = N:DAUDZUMS[12]
      DAUDZUMSK1  += DAUDZUMS1
      DAUDZUMSK2  += DAUDZUMS2
      DAUDZUMSK3  += DAUDZUMS3
      DAUDZUMSK4  += DAUDZUMS4
      DAUDZUMSK5  += DAUDZUMS5
      DAUDZUMSK6  += DAUDZUMS6
      DAUDZUMSK7  += DAUDZUMS7
      DAUDZUMSK8  += DAUDZUMS8
      DAUDZUMSK9  += DAUDZUMS9
      DAUDZUMSK10 += DAUDZUMS10
      DAUDZUMSK11 += DAUDZUMS11
      DAUDZUMSK12 += DAUDZUMS12
      IF F:DBF='W'
            PRINT(RPT:DETAIL)                               !  PRINT DETAIL LINES
      ELSIF F:DBF='E'
            OUTA:LINE=FORMAT(NR,@N_5B)&CHR(9)&FORMAT(RPT_NOMENKLAT,@S21)&CHR(9)&FORMAT(NOS_P,@S50)
            ADD(OUTFILEANSI)
            OUTA:LINE='     '&CHR(9)&FORMAT(DAUDZUMS1,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS2,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS3,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS4,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS5,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS6,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS7,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS8,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS9,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS10,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS11,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS12,@N_10.2)
            ADD(OUTFILEANSI)
      ELSE
            OUTA:LINE=FORMAT(NR,@N_5)&CHR(9)&FORMAT(RPT_NOMENKLAT,@S21)&CHR(9)&FORMAT(NOS_P,@S50)
            ADD(OUTFILEANSI)
            OUTA:LINE='     '&CHR(9)&FORMAT(DAUDZUMS1,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS2,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS3,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS4,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS5,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS6,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS7,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS8,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS9,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS10,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS11,@N_10.2)&CHR(9)&FORMAT(DAUDZUMS12,@N_10.2)
            ADD(OUTFILEANSI)
      END
!?    IF DBF
!?      DBF:NOMENKLAT=N:NOMENKLAT
!?      DBF:MERVIEN = NOM:MERVIEN
!?      DBF:NOS_P   = RPT:NOS_P
!?      DBF:DAUDZUMS1 = N:DAUDZUMS[1]
!?      DBF:DAUDZUMS2 = N:DAUDZUMS[2]
!?      DBF:DAUDZUMS3 = N:DAUDZUMS[3]
!?      DBF:DAUDZUMS4 = N:DAUDZUMS[4]
!?      DBF:DAUDZUMS5 = N:DAUDZUMS[5]
!?      DBF:DAUDZUMS6 = N:DAUDZUMS[6]
!?      DBF:DAUDZUMS7 = N:DAUDZUMS[7]
!?      DBF:DAUDZUMS8 = N:DAUDZUMS[8]
!?      DBF:DAUDZUMS9 = N:DAUDZUMS[9]
!?      DBF:DAUDZUMS10 = N:DAUDZUMS[10]
!?      DBF:DAUDZUMS11 = N:DAUDZUMS[11]
!?      DBF:DAUDZUMS12 = N:DAUDZUMS[12]
!?      ADD(DBFFILE)
!?    .
    .
    IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT1)                           !PRINT GRAND TOTALS
        PRINT(RPT:RPT_FOOTLS)
        PRINT(RPT:RPT_FOOT3)                           !PRINT GRAND TOTALS
        ENDPAGE(report)
    ELSE
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ:'&CHR(9)&FORMAT(DAUDZUMSk1,@N_10.2)&CHR(9)&FORMAT(DAUDZUMSk2,@N_10.2)&CHR(9)&FORMAT(DAUDZUMSk3,@N_10.2)&CHR(9)&FORMAT(DAUDZUMSk4,@N_10.2)&CHR(9)&FORMAT(DAUDZUMSk5,@N_10.2)&CHR(9)&FORMAT(DAUDZUMSk6,@N_10.2)&CHR(9)&FORMAT(DAUDZUMSk7,@N_10.2)&CHR(9)&FORMAT(DAUDZUMSk8,@N_10.2)&CHR(9)&FORMAT(DAUDZUMSk9,@N_10.2)&CHR(9)&FORMAT(DAUDZUMSk10,@N_10.2)&CHR(9)&FORMAT(DAUDZUMSk11,@N_10.2)&CHR(9)&FORMAT(DAUDZUMSk12,@N_10.2)
        ADD(OUTFILEANSI)
        OUTA:LINE=LINEH
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
    ELSIF F:DBF='E'
         CLOSE(OUTFILEANSI)
         RUN('C:\PROGRA~1\MICROS~1\OFFICE\EXCEL.EXE '&ANSIFILENAME)
         IF RUNCODE()=-4
            RUN('EXCEL.EXE '&ANSIFILENAME)
            IF RUNCODE()=-4
                KLUDA(88,'Excel.exe')
            .
         .
    ELSE
        CLOSE(OUTFILEANSI)
        RUN('WORDPAD '&ANSIFILENAME)
        IF RUNCODE()=-4
            KLUDA(88,'Wordpad.exe')
        .
    .
  END
  IF F:DBF='W'
      CLOSE(report)
      FREE(PrintPreviewQueue)
      FREE(PrintPreviewQueue1)
  ELSE
      ANSIFILENAME=''
  END
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
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(N_TABLE)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
!*********************************************************************
OMIT('DIANA')
NEXT_RECORD ROUTINE                              !GET NEXT RECORD
  LOOP UNTIL EOF(nolik)                          !  READ UNTIL END OF FILE
    NEXT(nolik)                                  !    READ NEXT RECORD
    IF ~(NOL:PAZIME=D_K AND NOL:DATUMS<=B_DAT AND NOL:DATUMS>=s_dat)
       BREAK
    .
    I# += 1
    SHOW(15,32,I#,@N_5)
    IF CYCLENOM(NOL:NOMENKLAT) THEN CYCLE.          !FILTRS PðC NOMENKLATÞTAS
    IF NOL:NR=1 THEN CYCLE.                         !SALDO
    GETPAR_K(NOL:PAR_NR)                            !POZICIONð PAR_K
    IF ~GRP() THEN CYCLE.                           !FILTRS PðC PARTNERA GRUPAS
    GETPAVADZ(NOL:NR)                               !POZICIONð PAVADZ×MES
    IF ~RST() THEN CYCLE.
!   IF TIPS AND ~(PAV:TIPS=TIPS) THEN CYCLE.        !FILTRS PðC TIPA
    EXIT                                         !    EXIT THE ROUTINE
  .                                              !
  DONE# = 1                                      !  ON EOF, SET DONE FLAG
DIANA
N_RealDinPG          PROCEDURE                    ! Declare Procedure
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

NR                   DECIMAL(4)
RPT_NR               DECIMAL(4)
NOS_S                STRING(50)
SUMMA1               DECIMAL(9,2) !ATBILSTÎBA:: @N-_11.2B
SUMMA2               DECIMAL(9,2)
SUMMA3               DECIMAL(9,2)
SUMMA4               DECIMAL(9,2)
SUMMA5               DECIMAL(9,2)
SUMMA6               DECIMAL(9,2)
SUMMA7               DECIMAL(9,2)
SUMMA8               DECIMAL(9,2)
SUMMA9               DECIMAL(9,2)
SUMMA10              DECIMAL(9,2)
SUMMA11              DECIMAL(9,2)
SUMMA12              DECIMAL(9,2)
SUMMAG               DECIMAL(9,2)
SUMMAK1              DECIMAL(9,2)
SUMMAK2              DECIMAL(9,2)
SUMMAK3              DECIMAL(9,2)
SUMMAK4              DECIMAL(9,2)
SUMMAK5              DECIMAL(9,2)
SUMMAK6              DECIMAL(9,2)
SUMMAK7              DECIMAL(9,2)
SUMMAK8              DECIMAL(9,2)
SUMMAK9              DECIMAL(9,2)
SUMMAK10             DECIMAL(9,2)
SUMMAK11             DECIMAL(9,2)
SUMMAK12             DECIMAL(9,2)
SUMMAKG              DECIMAL(9,2)
DAT                  DATE
LAI                  TIME
CP                   STRING(3)
SUMMAMAS             DECIMAL(12,2),DIM(12)
FILTRS_TEXT          STRING(100)
NOLIKTAVA_TEXT       STRING(30)

!-----------------------------------------------------------------------------
Process:View         VIEW(PAR_K)
                       PROJECT(NOS_S)
                       PROJECT(TIPS)
                       PROJECT(U_NR)
                       PROJECT(GRUPA)
                       PROJECT(PVN)
                       PROJECT(PASE)
                       PROJECT(ADRESE)
                     END
!-----------------------------------------------------------------------------
report REPORT,AT(500,1527,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(500,300,12000,1229),USE(?unnamed:2)
         LINE,AT(7813,938,0,260),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(8542,938,0,260),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(9271,938,0,260),USE(?Line2:45),COLOR(COLOR:Black)
         LINE,AT(7083,938,0,260),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(6354,938,0,260),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(5625,938,0,260),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(4896,938,0,260),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(4167,938,0,260),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(3438,938,0,260),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(2708,938,0,260),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(1979,938,0,260),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@D06.),AT(5677,365,833,229),USE(S_DAT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(6510,365,156,229),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(6667,365),USE(B_DAT),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(9375,510,,156),PAGENO,USE(?PAGECOUNT),RIGHT
         LINE,AT(52,677,9948,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(469,677,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(10000,677,0,573),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('NPK'),AT(104,729,365,208),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(625,719,8698,208),USE(FILTRS_TEXT),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma IZ8V'),AT(8698,510,677,156),USE(?String60:2),LEFT
         LINE,AT(469,938,9531,0),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(1250,938,0,260),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('augusts'),AT(5677,990,677,208),USE(?String8:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('septembris'),AT(6406,990,677,208),USE(?String8:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('oktobris'),AT(7135,990,677,208),USE(?String8:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('novembris'),AT(7865,990,677,208),USE(?String8:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('decembris'),AT(8583,990,677,208),USE(?String8:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kopâ'),AT(9323,990,573,208),USE(?String8:15),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1198,9948,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('janvâris'),AT(521,990,677,208),USE(?String8:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('februâris'),AT(1302,990,677,208),USE(?String8:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('marts'),AT(2031,990,677,208),USE(?String8:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('aprîlis'),AT(2760,990,677,208),USE(?String8:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('maijs'),AT(3490,990,677,208),USE(?String8:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('jûnijs'),AT(4219,990,677,208),USE(?String8:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('jûlijs'),AT(4948,990,677,208),USE(?String8:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,677,0,573),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(990,104,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(5521,104,2604,260),USE(NOLIKTAVA_TEXT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Realizâcijas dinamika lielâkajiem preèu saòçmçjiem'),AT(1302,365,4323,260),USE(?STRING), |
             CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,406),USE(?unnamed)
         LINE,AT(52,-10,0,427),USE(?Line2:3),COLOR(COLOR:Black)
         STRING(@N4B),AT(156,52,260,156),USE(RPT_NR),LEFT
         LINE,AT(469,-10,0,427),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@S50),AT(781,52,3229,156),USE(NOS_S),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(1281,240,677,156),USE(SUMMA2),RIGHT
         STRING(@N-_11.2B),AT(2010,240,677,156),USE(SUMMA3),RIGHT
         STRING(@N-_11.2B),AT(2740,240,677,156),USE(SUMMA4),RIGHT
         STRING(@N-_11.2B),AT(3469,240,677,156),USE(SUMMA5),RIGHT
         STRING(@N-_11.2B),AT(4198,240,677,156),USE(SUMMA6),RIGHT
         STRING(@N-_11.2B),AT(4927,240,677,156),USE(SUMMA7),RIGHT
         STRING(@N-_11.2B),AT(5656,240,677,156),USE(SUMMA8),RIGHT
         STRING(@N-_11.2B),AT(6385,240,677,156),USE(SUMMA9),RIGHT
         STRING(@N-_11.2B),AT(7115,240,677,156),USE(SUMMA10),RIGHT
         STRING(@N-_11.2B),AT(7844,240,677,156),USE(SUMMA11),RIGHT
         STRING(@N-_11.2B),AT(8573,240,677,156),USE(SUMMA12,,?SUMMA12:2),RIGHT
         STRING(@N-_11.2B),AT(9302,240,677,156),USE(SUMMAG),TRN,RIGHT
         LINE,AT(52,0,9948,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(10000,0,0,427),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(469,208,9531,0),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(1250,208,0,208),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(1979,208,0,208),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(2708,208,0,208),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(3438,208,0,208),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(4167,208,0,208),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(4896,208,0,208),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(5625,208,0,208),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(6354,208,0,208),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(7083,208,0,208),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(7813,208,0,208),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(8542,208,0,208),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(9271,208,0,208),USE(?Line2:28),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(542,240,677,156),USE(SUMMA1),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,,,94),USE(?unnamed:4)
         LINE,AT(52,-10,0,115),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,115),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(1250,-10,0,115),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(1979,-10,0,115),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(2708,-10,0,115),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,115),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,115),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(9271,-10,0,115),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(10000,0,0,115),USE(?Line48:2),COLOR(COLOR:Black)
         LINE,AT(8542,-10,0,115),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(52,52,9948,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,115),USE(?Line46),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,115),USE(?Line45),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,115),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(5625,-10,0,115),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(4896,-10,0,115),USE(?Line42),COLOR(COLOR:Black)
       END
RPT_FOOTLS DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(7813,-10,0,198),USE(?Line2:41),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(7844,10,677,156),USE(SUMMAK11),RIGHT
         LINE,AT(8542,-10,0,198),USE(?Line2:42),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(8573,10,677,156),USE(SUMMAK12),RIGHT
         STRING(@N-_11.2B),AT(9302,10,677,156),USE(SUMMAKG),TRN,RIGHT
         LINE,AT(9271,-10,0,198),USE(?Line2:43),COLOR(COLOR:Black)
         LINE,AT(10000,0,0,198),USE(?Line2:44),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,198),USE(?Line2:40),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(7115,10,677,156),USE(SUMMAK10),RIGHT
         LINE,AT(6354,-10,0,198),USE(?Line2:39),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(6385,10,677,156),USE(SUMMAK9),RIGHT
         LINE,AT(5625,-10,0,198),USE(?Line2:38),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(5656,10,677,156),USE(SUMMAK8),RIGHT
         LINE,AT(4896,-10,0,198),USE(?Line2:37),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(4927,10,677,156),USE(SUMMAK7),RIGHT
         LINE,AT(4167,-10,0,198),USE(?Line2:36),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(4198,10,677,156),USE(SUMMAK6),RIGHT
         LINE,AT(3438,-10,0,198),USE(?Line2:35),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(3469,10,677,156),USE(SUMMAK5),RIGHT
         LINE,AT(2708,-10,0,198),USE(?Line2:34),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(2740,10,677,156),USE(SUMMAK4),RIGHT
         LINE,AT(1979,-10,0,198),USE(?Line2:33),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(2010,10,677,156),USE(SUMMAK3),RIGHT
         LINE,AT(1250,-10,0,198),USE(?Line2:32),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(1281,10,677,156),USE(SUMMAK2),RIGHT
         LINE,AT(469,-10,0,198),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(552,10,677,156),USE(SUMMAk1),RIGHT
         LINE,AT(52,-10,0,198),USE(?Line2:30),COLOR(COLOR:Black)
         STRING('kopâ'),AT(104,10,365,156),USE(?String8:16),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT3 DETAIL,AT(,,,260),USE(?unnamed:3)
         LINE,AT(52,-10,0,63),USE(?Line63),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,63),USE(?Line64),COLOR(COLOR:Black)
         LINE,AT(1250,-10,0,63),USE(?Line65),COLOR(COLOR:Black)
         LINE,AT(1979,-10,0,63),USE(?Line66),COLOR(COLOR:Black)
         LINE,AT(2708,-10,0,63),USE(?Line67),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,63),USE(?Line68),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,63),USE(?Line69),COLOR(COLOR:Black)
         LINE,AT(4896,-10,0,63),USE(?Line70),COLOR(COLOR:Black)
         LINE,AT(5625,-10,0,63),USE(?Line71),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,63),USE(?Line72),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,63),USE(?Line73),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,63),USE(?Line74),COLOR(COLOR:Black)
         LINE,AT(8542,-10,0,63),USE(?Line75),COLOR(COLOR:Black)
         LINE,AT(9271,-10,0,63),USE(?Line76),COLOR(COLOR:Black)
         LINE,AT(10000,0,0,63),USE(?Line76:2),COLOR(COLOR:Black)
         LINE,AT(52,52,9948,0),USE(?Line77),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(135,73,438,146),USE(?String53),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(594,73,573,146),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1385,73,177,146),USE(?String53:2),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1573,73,156,146),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(8917,73,615,146),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(9542,73),USE(lai),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(500,7800,12000,63)
         LINE,AT(52,0,9948,0),USE(?Line77:2),COLOR(COLOR:Black)
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
!** Pircçju DINAMIKA par visiem
!*************************************************************************
!*************************************************************************

!jâpârtaisa kârtîgi, jo ïaudis izmanto...... 28.09.07.


  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(PAVAD,1)
  CHECKOPEN(TEK_K,1)
  CHECKOPEN(BANKAS_K,1)

  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('PAR_TIPS',PAR_TIPS)
  BIND('PAR_GRUPA',PAR_GRUPA)
  BIND('PAR_NR',PAR_NR)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CP',CP)

  NOLIKTAVA_TEXT='Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
!  IF F:OBJ_NR THEN FILTRS_TEXT='Objekts:'&F:OBJ_NR&' '&GetPROJEKTI(F:OBJ_NR).
!  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala).
  IF ~(PAR_TIPS='EFCNIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' ParTips:'&PAR_TIPS.
  IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa:'&PAR_GRUPA.
  IF NOMENKLAT THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nomenklatûra:'&NOMENKLAT.
!  IF ~(NOM_TIPS7='PTAKRIV') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' NomTips:'&NOM_TIPS7.
!  IF F:DIENA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Diena/nakts=:'&F:DIENA.
!  IF F:ATL THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Pçc atlikumiem: '.
!  IF F:ATL[1]='1' THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'+A'.
!  IF F:ATL[2]='1' THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'0A'.
!  IF F:ATL[3]='1' THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'-A'.
  IF MINMAXSUMMA AND F:LIELMAZ='M' !M-MAZÂKÂ, KAS JÂRÂDA ATSKAITÇ
     FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Apgrozîjums:nav mazâks par Ls '&LEFT(FORMAT(MINMAXSUMMA,@N-_11.2))
  ELSIF MINMAXSUMMA AND F:LIELMAZ='L' !L-LIELÂKÂ, KAS JÂRÂDA ATSKAITÇ
     FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Apgrozîjums: nav lielâks par Ls '&LEFT(FORMAT(MINMAXSUMMA,@N-_11.2))
  .

  S_DAT = DATE(1,1,GADS)
  B_DAT = DATE(12,31,GADS)
  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  BIND(NOL:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAR_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Realizâcijas dinamika'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAR_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CP = 'R11'
      CLEAR(PAR:RECORD)
      SET(PAR:NOS_KEY,PAR:NOS_KEY)
      Process:View{Prop:Filter} ='~CYCLEPAR_K(CP)'
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
          IF ~OPENANSI('PIRDIN.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(CLIENT)&' '&NOLIKTAVA_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE='REALIZÂCIJAS DINAMIKA LIELÂKAJIEM PREÈU SAÒÇMÇJIEM no '&format(S_DAT,@d06.)&' lîdz '&format(B_DAT,@d06.)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='NPK'&CHR(9)&'Saòçmçja u_nr,Nosaukums'&CHR(9)&'JANVÂRIS'&CHR(9)&'FEBRUÂRIS'&CHR(9)&'MARTS'&CHR(9)&|
          'APRÎLIS'&CHR(9)&'MAIJS'&CHR(9)&'JÛNIJS'&CHR(9)&'JÛLIJS'&CHR(9)&'AUGUSTS'&CHR(9)&'SEPTEMBRIS'&CHR(9)&|
          'OKTOBRIS'&CHR(9)&'NOVEMBRIS'&CHR(9)&'DECEMBRIS'&CHR(9)&' KOPÂ'
          ADD(OUTFILEANSI)
!          OUTA:LINE=''
!          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        DONE# = 0
        CLEAR(SUMMAMAS)
        CLEAR(PAV:RECORD)
        PAV:PAR_NR=PAR:U_NR
        SET(PAV:PAR_KEY,PAV:PAR_KEY)
        DO NEXTPAV
        LOOP UNTIL DONE#
          IF NOMENKLAT
            CLEAR(NOL:RECORD)
            NOL:U_NR=PAV:U_NR
            SET(NOL:NR_KEY,NOL:NR_KEY)
            LOOP
              NEXT(NOLIK)
              IF ~(NOL:U_NR=PAV:U_NR) OR ERROR() THEN BREAK.
              IF CYCLENOM(NOL:NOMENKLAT) THEN CYCLE.
              SUMMAMAS[MONTH(PAV:DATUMS)]+=CALCSUM(4,2)*bankurs(PAV:VAL,PAV:DATUMS)
            .
          ELSE
            SUMMAMAS[MONTH(PAV:DATUMS)]+=PAV:SUMMA*bankurs(PAV:VAL,PAV:DATUMS)
          .
          DO NEXTPAV
        .
        DO WRDETAIL
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
    IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT1)
        PRINT(RPT:RPT_FOOTLS)
        PRINT(RPT:RPT_FOOT3)
        ENDPAGE(report)
    ELSE
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'KOPÂ:'&CHR(9)&LEFT(FORMAT(SUMMAK1,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMAK2,@N-_11.2))&CHR(9)&|
        LEFT(FORMAT(SUMMAK3,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMAK4,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMAK5,@N-_11.2))&|
        CHR(9)&LEFT(FORMAT(SUMMAK6,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMAK7,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMAK8,@N-_11.2))&|
        CHR(9)&LEFT(FORMAT(SUMMAK9,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMAK10,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMAK11,@N-_11.2))&|
        CHR(9)&LEFT(FORMAT(SUMMAK12,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMAKG,@N-_11.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
!  IF F:DBF='E' THEN F:DBF='W'. !PAGAIDÂM
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
NEXTPAV      ROUTINE
  LOOP UNTIL EOF(PAVAD)
    NEXT(PAVAD)
    IF ~(PAV:PAR_NR=PAR:U_NR) THEN BREAK.
    IF ~INRANGE(PAV:DATUMS,S_DAT,B_DAT) THEN CYCLE.
    IF ~(PAV:D_K='K') THEN CYCLE.
!    IF ~RST() THEN CYCLE.
    EXIT
 .
 DONE# = 1


!-----------------------------------------------------------------------------
WRDETAIL    ROUTINE
     SUMMAG=0
     LOOP I#=1 TO 12
        SUMMAG+=SUMMAMAS[I#]
     .
     IF SUMMAG=0 AND PAR:TIPS AND F:IEKLAUTPK
        NR#+=1
        RPT_NR=NR#
        NOS_S=PAR:U_NR&' '&PAR:NOS_S
        SUMMA1 =SUMMAMAS[1]
        SUMMA2 =SUMMAMAS[2]
        SUMMA3 =SUMMAMAS[3]
        SUMMA4 =SUMMAMAS[4]
        SUMMA5 =SUMMAMAS[5]
        SUMMA6 =SUMMAMAS[6]
        SUMMA7 =SUMMAMAS[7]
        SUMMA8 =SUMMAMAS[8]
        SUMMA9 =SUMMAMAS[9]
        SUMMA10=SUMMAMAS[10]
        SUMMA11=SUMMAMAS[11]
        SUMMA12=SUMMAMAS[12]
        IF F:DBF = 'W'
            PRINT(RPT:DETAIL)
        ELSE
            OUTA:LINE=CLIP(RPT_NR)&CHR(9)&PAR:U_NR&' '&PAR:NOS_S&CHR(9)&LEFT(FORMAT(SUMMA1,@N-_11.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA2,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA3,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA4,@N-_11.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA5,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA6,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA7,@N-_11.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA8,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA9,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA10,@N-_11.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA11,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA12,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMAG,@N-_11.2))
            ADD(OUTFILEANSI)
        .
        DO KOPSUMMA
     ELSIF (SUMMAG>=MINMAXSUMMA AND SUMMAG>0 AND F:LIELMAZ='M') OR|
     (SUMMAG<=MINMAXSUMMA AND F:LIELMAZ='L')
        NR#+=1
        RPT_NR=NR#
        NOS_S=PAR:U_NR&' '&PAR:NOS_S
        SUMMA1 =SUMMAMAS[1]
        SUMMA2 =SUMMAMAS[2]
        SUMMA3 =SUMMAMAS[3]
        SUMMA4 =SUMMAMAS[4]
        SUMMA5 =SUMMAMAS[5]
        SUMMA6 =SUMMAMAS[6]
        SUMMA7 =SUMMAMAS[7]
        SUMMA8 =SUMMAMAS[8]
        SUMMA9 =SUMMAMAS[9]
        SUMMA10=SUMMAMAS[10]
        SUMMA11=SUMMAMAS[11]
        SUMMA12=SUMMAMAS[12]
        IF F:DBF = 'W'
            PRINT(RPT:DETAIL)
        ELSE
            OUTA:LINE=FORMAT(RPT_NR)&CHR(9)&PAR:U_NR&' '&PAR:NOS_S&CHR(9)&LEFT(FORMAT(SUMMA1,@N-_11.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA2,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA3,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA4,@N-_11.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA5,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA6,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA7,@N-_11.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA8,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA9,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA10,@N-_11.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA11,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA12,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMAG,@N-_11.2))
            ADD(OUTFILEANSI)
        .
        DO KOPSUMMA
     .

!-----------------------------------------------------------------------------
KOPSUMMA ROUTINE
        SUMMAK1 +=SUMMA1
        SUMMAK2 +=SUMMA2
        SUMMAK3 +=SUMMA3
        SUMMAK4 +=SUMMA4
        SUMMAK5 +=SUMMA5
        SUMMAK6 +=SUMMA6
        SUMMAK7 +=SUMMA7
        SUMMAK8 +=SUMMA8
        SUMMAK9 +=SUMMA9
        SUMMAK10+=SUMMA10
        SUMMAK11+=SUMMA11
        SUMMAK12+=SUMMA12
        SUMMAKG +=SUMMAG
