                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_IENPT              PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(PAVAD)
                       PROJECT(PAV:U_NR)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:VAL)
                     END
!------------------------------------------------------------------------
DOK_SENR             STRING(14)
RPT_NR               DECIMAL(4)
PAR_NOS_P            LIKE(PAR:NOS_P)
SUMMA_P              DECIMAL(12,2)
SUMMA_PR             DECIMAL(12,2)
SUMMA_TA             DECIMAL(12,2)
SUMMA_PA             DECIMAL(12,2)
KOPA                 STRING(6)
SUMMA_PK             DECIMAL(12,2)
SUMMA_PRK            DECIMAL(12,2)
SUMMA_TAK            DECIMAL(12,2)
SUMMA_PAK            DECIMAL(12,2)
VALK                 STRING(3)
DAT                  DATE
LAI                  TIME
CN                   STRING(10)
CP                   STRING(3)
SVARS                DECIMAL(12,2)
SVARSK               DECIMAL(12,2)

K_TABLE              QUEUE,PRE(K)
VAL                    STRING(3)
SUMMA_P                DECIMAL(12,2)
!SUMMAPRK               DECIMAL(12,2)
!SUMMATAK               DECIMAL(12,2)
!SUMMAPAK               DECIMAL(12,2)
                     .
TARA                 DECIMAL(12,2)
PAKALPOJUMI          DECIMAL(12,2)
PRECE                DECIMAL(12,2)
VIRSRAKSTS           STRING(110)
FILTRS_TEXT          STRING(100)
TAB_4_TEXT           STRING(12)

!--------------------------------------------------------------------------
report REPORT,AT(1000,1625,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(1000,500,12000,1125),USE(?unnamed:2)
         STRING(@s110),AT(125,229,8229,188),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IE4V'),AT(8521,302,781,156),USE(?String7),RIGHT(1)
         STRING(@P<<<#. lapaP),AT(8625,417,677,156),PAGENO,USE(?PageCount),RIGHT(1)
         STRING(@s100),AT(302,417,7927,167),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,625,9271,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(406,625,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(938,625,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(1781,625,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4063,625,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Dokumenta'),AT(1010,677,729,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s12),AT(2146,802,979,208),USE(TAB_4_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa pçc'),AT(4104,677,1042,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(5208,875,1042,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(6292,875,1042,208),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(7385,875,1094,208),USE(?String10:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1094,9271,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(5156,625,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6250,625,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7344,625,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(8490,625,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(9323,625,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         STRING('Preèu'),AT(5198,677,1042,208),USE(?String10:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Taras'),AT(6292,677,1042,208),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pakalpojumu'),AT(7385,677,1094,208),USE(?String10:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Svars'),AT(8521,771,781,208),USE(?String10:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(83,771,310,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dok.'),AT(438,677,480,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(438,875,480,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(1031,865,677,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokumenta'),AT(4104,875,1042,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,625,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(2021,10,4427,208),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:3)
         STRING(@S14),AT(958,10,810,156),USE(DOK_SENR),RIGHT
         LINE,AT(1781,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         STRING(@S35),AT(1813,10,2240,156),USE(PAR_NOS_P),LEFT
         LINE,AT(4063,-10,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(4115,10,729,156),USE(SUMMA_P),RIGHT
         STRING(@S3),AT(4896,10,260,156),USE(PAV:VAL),LEFT
         LINE,AT(5156,-10,0,198),USE(?Line12:6),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(5208,10,729,156),USE(SUMMA_PR),RIGHT
         STRING(@S3),AT(5990,10,260,156),USE(PAV:VAL,,?PAV:NOS:2),LEFT
         LINE,AT(6250,-10,0,198),USE(?Line12:7),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(6302,10,729,156),USE(SUMMA_TA),RIGHT
         STRING(@S3),AT(7083,10,260,156),USE(PAV:VAL,,?PAV:NOS:3),LEFT
         LINE,AT(7344,-10,0,198),USE(?Line12:8),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(7396,10,729,156),USE(SUMMA_PA),RIGHT
         STRING(@S3),AT(8177,10,260,156),USE(PAV:VAL,,?PAV:NOS:4),LEFT
         LINE,AT(8490,-10,0,198),USE(?Line12:9),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(8542,10,729,156),USE(SVARS),RIGHT
         LINE,AT(9323,-10,0,198),USE(?Line12:10),COLOR(COLOR:Black)
         LINE,AT(938,-10,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         STRING(@D05.),AT(438,10,469,156),USE(PAV:DATUMS),RIGHT
         LINE,AT(406,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         STRING(@n4),AT(104,10,260,156),USE(RPT_NR),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(52,-10,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(406,-10,0,63),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(938,-10,0,63),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(1781,-10,0,63),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(4063,-10,0,115),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,115),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,115),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(7344,-10,0,115),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(8490,-10,0,115),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(9323,-10,0,115),USE(?Line29:2),COLOR(COLOR:Black)
         LINE,AT(52,52,9271,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(52,-10,0,198),USE(?Line31),COLOR(COLOR:Black)
         STRING(@S6),AT(104,10,469,156),USE(KOPA),LEFT
         LINE,AT(4063,-10,0,198),USE(?Line31:2),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(4115,10,729,156),USE(SUMMA_PK),RIGHT
         LINE,AT(5156,-10,0,198),USE(?Line31:3),COLOR(COLOR:Black)
         STRING(@n-_12.2B),AT(5208,10,729,156),USE(SUMMA_PRK),RIGHT
         LINE,AT(6250,-10,0,198),USE(?Line31:4),COLOR(COLOR:Black)
         STRING(@n-_12.2B),AT(6302,10,729,156),USE(SUMMA_TAK),RIGHT
         LINE,AT(7344,-10,0,198),USE(?Line31:5),COLOR(COLOR:Black)
         STRING(@n-_12.2B),AT(7396,10,729,156),USE(SUMMA_PAK),RIGHT
         STRING(@n-_12.2),AT(8542,10,729,156),USE(SVARSK),RIGHT
         STRING(@S3),AT(4896,10,260,156),USE(VALK),LEFT
         LINE,AT(8490,-10,0,198),USE(?Line31:6),COLOR(COLOR:Black)
         LINE,AT(9323,-10,0,198),USE(?Line31:7),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,219),USE(?unnamed)
         LINE,AT(52,-10,0,63),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(4063,-10,0,63),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,63),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,63),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(7344,-10,0,63),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(8490,-10,0,63),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(9323,-10,0,63),USE(?Line43:2),COLOR(COLOR:Black)
         LINE,AT(52,52,9271,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(63,73,469,156),USE(?String45),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(542,73,573,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1167,73,260,156),USE(?String45:2),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1427,73,208,156),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(8198,73,604,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(8833,73,458,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(1000,7900,12000,63)
         LINE,AT(52,0,9271,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(PAVAD,1)
  CHECKOPEN(BANKAS_K,1)
  BIND('S_DAT',S_DAT)
  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOL',CYCLENOL)

  DAT = TODAY()
  LAI = CLOCK()
  D_K = 'D'
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  BIND(NOL:RECORD)
  BIND(NOM:RECORD)
  BIND(PAR:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Ienâkuðâs P/Z(preèu/taras)'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'P10011'
      CP = 'P11'
      VIRSRAKSTS='Ienâkuðâs P/Z-preèu/taras('&D_K&') no '&format(S_DAT,@d06.)&' lîdz '&|
      format(B_DAT,@d06.)&' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS

      CLEAR(PAV:RECORD)
      PAV:D_K=D_K
      PAV:DATUMS=S_DAT
      IF PAR_NR = 999999999 !VISI
         FILTRS_TEXT=GETFILTRS_TEXT('101100000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         TAB_4_TEXT='Piegâdâtâjs'
         SET(PAV:DAT_KEY,PAV:DAT_KEY)
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLEPAR_K(CP)'
      ELSE
         FILTRS_TEXT=GETFILTRS_TEXT('100000000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Piegâdâtâjs: '&GETPAR_K(PAR_NR,2,2)
         TAB_4_TEXT='Pamatojums'
         PAV:PAR_NR=PAR_NR
         SET(PAV:PAR_KEY,PAV:PAR_KEY)
         Process:View{Prop:Filter} ='~CYCLENOL(CN)'
      .
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
          IF ~OPENANSI('IENPT.TXT')
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
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&TAB_4_TEXT&PAR_GRUPA&CHR(9)&'Summa pçc'&|
             CHR(9)&CHR(9)&'Preèu'&CHR(9)&CHR(9)&'Taras'&CHR(9)&CHR(9)&'Pakalpojumu'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&'Datums'&CHR(9)&'Numurs'&CHR(9)&CHR(9)&'dokumenta'&CHR(9)&CHR(9)&'summa'&CHR(9)&CHR(9)&|
             'summa'&CHR(9)&CHR(9)&'summa'
             ADD(OUTFILEANSI)
          ELSE !WORD
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta Datums'&CHR(9)&'Dokumenta Numurs'&CHR(9)&TAB_4_TEXT&PAR_GRUPA&CHR(9)&|
             'Summa pçc dokumenta'&CHR(9)&CHR(9)&'Preèu summa'&CHR(9)&CHR(9)&'Taras summa'&CHR(9)&CHR(9)&|
             'Pakalpojumu summa'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~(PAV:U_NR=1)  !SALDO IGNORÇJAM
           IF PAR_NR = 999999999 !VISI
              IF ~PAV:PAR_NR
                 PAR_NOS_P=PAV:NOKA
              ELSE
                 PAR_NOS_P=GETPAR_K(PAV:PAR_NR,0,2)
              .
           ELSE
              PAR_NOS_P=PAV:PAMAT
           .
           RPT_NR += 1
           ?Progress:UserString{Prop:Text}=RPT_NR
           DISPLAY(?Progress:UserString)
           SUMMA_P = PAV:SUMMA
           GET(K_TABLE,0)
           K:VAL=PAV:VAL
           GET(K_TABLE,K:VAL)
           IF ERROR()
             K:VAL     = PAV:VAL
             K:SUMMA_P = SUMMA_P
             ADD(K_TABLE)
             SORT(K_TABLE,K:VAL)
           ELSE
             K:SUMMA_P += SUMMA_P
             PUT(K_TABLE)
           .
           TARA=0
           PAKALPOJUMI=0
           PRECE=0
           clear(nol:record)
           NOL:U_NR=PAV:U_NR
           SET(nol:nr_key,nol:nr_key)
           LOOP
             NEXT(NOLIK)
             IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
             CASE GETNOM_K(NOL:NOMENKLAT,2,16)
             of 'T'
               TARA+=calcsum(4,2)
             of 'A'
               PAKALPOJUMI+=calcsum(4,2)
             else
               PRECE+=calcsum(4,2)
             .
           .
   !!        K:SUMMATAK+=TARA
   !!        K:SUMMAPAK+=PAKALPOJUMI
   !!        K:SUMMAPRK+=PRECE
   !!        PUT(K_TABLE)
   !!        IF ERROR() THEN STOP('K_TABLE '&ERROR()).
           summa_PR = PRECE
           summa_TA = TARA
           summa_PA = PAKALPOJUMI
           SUMMA_PK  += SUMMA_P*BANKURS(PAV:VAL,PAV:DATUMS)
           summa_PRK += PRECE*BANKURS(PAV:VAL,PAV:DATUMS)
           summa_TAK += TARA*BANKURS(PAV:VAL,PAV:DATUMS)
           summa_PAK += PAKALPOJUMI*BANKURS(PAV:VAL,PAV:DATUMS)
           DOK_SENR=PAV:DOK_SENR
           IF ~F:DTK
             IF F:DBF='W'
               PRINT(RPT:DETAIL)
             ELSE !WORD/EXCEL
               OUTA:LINE=RPT_NR&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&DOK_SENR&CHR(9)&PAR_NOS_P&CHR(9)&|
               LEFT(format(SUMMA_P,@N-_12.2))&CHR(9)&PAV:VAL&CHR(9)&LEFT(format(SUMMA_PR,@N-_12.2))&CHR(9)&PAV:VAL&|
               CHR(9)&LEFT(format(SUMMA_TA,@N-_12.2))&CHR(9)&PAV:VAL&CHR(9)&LEFT(format(SUMMA_PA,@N-_12.2))&CHR(9)&PAV:VAL
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
  IF SEND(PAVAD,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    END
!****************************DRUKÂJAM KOPÂ **************
    KOPA='Kopâ:'
    !VALK = 'Ls'
    VALK = val_uzsk
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(SUMMA_Pk,@N-_12.2))&CHR(9)&CHR(9)&|
        LEFT(format(SUMMA_PRk,@N-_12.2))&CHR(9)&CHR(9)&LEFT(format(SUMMA_TAk,@N-_12.2))&CHR(9)&CHR(9)&|
        LEFT(format(SUMMA_PAk,@N-_12.2))
        ADD(OUTFILEANSI)
    .
!****************************DRUKÂJAM PÇC valûtâm **************
    SUMMA_PK  = 0
    summa_PRK = 0
    summa_TAK = 0
    summa_PAK = 0
    KOPA = 't.s.'
    GET(K_TABLE,0)
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      IF K:SUMMA_P <> 0
        SUMMA_PK  = K:SUMMA_P
        VALK      = K:VAL
!!        SUMMAPRK =K:SUMMAPRK
!!        SUMMATAK =K:SUMMATAK
!!        SUMMAPAK =K:SUMMAPAK
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(SUMMA_Pk,@N-_12.2))&CHR(9)&CHR(9)&|
            LEFT(format(SUMMA_PRk,@N-_12.2))&CHR(9)&CHR(9)&LEFT(format(SUMMA_TAk,@N-_12.2))&CHR(9)&CHR(9)&|
            LEFT(format(SUMMA_PAk,@N-_12.2))
            ADD(OUTFILEANSI)
        .
        kopa=''
      .
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT3)
        ENDPAGE(report)
    ELSE
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
  FREE(K_TABLE)
  IF FilesOpened
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
  END
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
  IF ~(PAR_NR=999999999)                 !KONKRÇTS PARTNERIS
     NEXT(Process:View)
     IF ERRORCODE() OR ~(PAV:PAR_NR=PAR_NR) OR PAV:DATUMS>B_DAT THEN VISS#=TRUE.
  ELSE
     PREVIOUS(Process:View) !DESC.KEY
     IF ERRORCODE() OR PAV:DATUMS>B_DAT THEN VISS#=TRUE.
  .
  IF VISS#=TRUE
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
N_IENPTP             PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(PAVAD)
                       PROJECT(PAV:U_NR)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:VAL)
                     END
!------------------------------------------------------------------------
DOK_NR               STRING(14)
RPT_NR               USHORT
SUMMA_P              DECIMAL(12,2)
SUMMA_PR             DECIMAL(12,2)
SUMMA_TA             DECIMAL(12,2)
SUMMA_PA             DECIMAL(12,2)
KOPA                 STRING(6)
SUMMA_PK             DECIMAL(12,2)
SUMMA_PRK            DECIMAL(12,2)
SUMMA_TAK            DECIMAL(12,2)
SUMMA_PAK            DECIMAL(12,2)
VALK                 STRING(3)
DAT                  DATE
LAI                  TIME
PROJEKTS             STRING(50)
CN                   STRING(10)
CP                   STRING(1)
K_TABLE              QUEUE,PRE(K)
VAL                   STRING(3)
SUMMA_P               DECIMAL(12,2)
!SUMMAprK              DECIMAL(12,2)
!SUMMAtaK              DECIMAL(12,2)
!SUMMApaK              DECIMAL(12,2)
                     .
prece                DECIMAL(12,2)
tara                 DECIMAL(12,2)
pakalpojumi          DECIMAL(12,2)
LINEH                STRING(190)
!--------------------------------------------------------------------------
report REPORT,AT(1000,1792,12000,6104),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(1000,500,12000,1292),USE(?unnamed:3)
         STRING('Adrese :'),AT(1042,573,677,208),USE(?String2:4),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(7448,365,833,208),USE(b_dat),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IE4K'),AT(6875,625,729,156),USE(?String7),LEFT
         STRING(@P<<<#. lapaP),AT(7500,625,677,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(52,781,8177,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(365,781,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(865,781,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(1698,781,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(3885,781,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Dokumenta'),AT(958,833,677,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamatojums'),AT(1896,927,1563,177),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa pçc'),AT(3979,833,885,208),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(5063,1031,885,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(6125,1031,938,208),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(7229,1031,885,208),USE(?String10:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(1719,573,3438,208),USE(PAR:adrese),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(4688,104,4219,208),USE(PROJEKTS),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(3490,365,3021,208),USE(PAR:nos_p),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1250,8177,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(4948,781,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6042,781,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7135,781,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(8229,781,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Preèu'),AT(5031,833,938,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Taras'),AT(6125,833,938,208),USE(?String10:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pakalpojumu'),AT(7188,833,938,208),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(104,927),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(385,833,469,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(385,1031,469,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(969,1031,625,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokumenta'),AT(3969,1031,938,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,781,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(260,104,4375,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktava :'),AT(5156,573,833,208),USE(?String2:3),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Ienâkoðâs preces - Piegâdâtâjs :'),AT(1042,365,2448,208),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(5990,573,260,208),USE(LOC_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(6510,365,833,208),USE(s_dat),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(7344,365,104,208),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         STRING(@S14),AT(885,0,781,156),USE(DOK_NR),RIGHT
         LINE,AT(1698,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         STRING(@S40),AT(1729,0,2135,156),USE(PAv:pamat),LEFT,FONT(,,,,CHARSET:BALTIC)
         LINE,AT(3885,-10,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(3906,10,729,156),USE(SUMMA_P),RIGHT
         STRING(@S3),AT(4688,10,260,156),USE(PAV:VAL),LEFT
         LINE,AT(4948,-10,0,198),USE(?Line12:6),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(5000,10,729,156),USE(SUMMA_PR),RIGHT
         STRING(@S3),AT(5781,10,260,156),USE(PAV:VAL,,?PAV:NOS:2),LEFT
         LINE,AT(6042,-10,0,198),USE(?Line12:7),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(6094,10,729,156),USE(SUMMA_TA),RIGHT
         STRING(@S3),AT(6875,10,260,156),USE(PAV:VAL,,?PAV:NOS:3),LEFT
         LINE,AT(7135,-10,0,198),USE(?Line12:8),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(7188,10,729,156),USE(SUMMA_PA),RIGHT
         STRING(@S3),AT(7969,10,260,156),USE(PAV:VAL,,?PAV:NOS:4),LEFT
         LINE,AT(8229,-10,0,198),USE(?Line12:9),COLOR(COLOR:Black)
         LINE,AT(865,-10,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         STRING(@D05.),AT(385,10,469,156),USE(PAV:DATUMS),RIGHT
         LINE,AT(365,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         STRING(@n_4),AT(83,10,260,156),USE(RPT_NR),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,,,94),USE(?unnamed:2)
         LINE,AT(52,-10,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,63),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(865,0,0,63),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(1698,-10,0,63),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(3885,-10,0,115),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,115),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,115),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,115),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(8229,-10,0,115),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(52,52,8177,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(52,-10,0,198),USE(?Line31),COLOR(COLOR:Black)
         STRING(@S6),AT(260,10,469,156),USE(KOPA),LEFT
         LINE,AT(3885,-10,0,198),USE(?Line31:2),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(3906,10,729,156),USE(SUMMA_PK),RIGHT
         LINE,AT(4948,-10,0,198),USE(?Line31:3),COLOR(COLOR:Black)
         STRING(@n-_12.2B),AT(5000,10,729,156),USE(SUMMA_PRK),RIGHT
         LINE,AT(6042,-10,0,198),USE(?Line31:4),COLOR(COLOR:Black)
         STRING(@n-_12.2B),AT(6094,10,729,156),USE(SUMMA_TAK),RIGHT
         LINE,AT(7135,-10,0,198),USE(?Line31:5),COLOR(COLOR:Black)
         STRING(@n-_12.2B),AT(7188,10,729,156),USE(SUMMA_PAK),RIGHT
         STRING(@S3),AT(4688,10,260,156),USE(VALK),LEFT
         LINE,AT(8229,-10,0,198),USE(?Line31:6),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,271),USE(?unnamed)
         LINE,AT(52,-10,0,63),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(3885,-10,0,63),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,63),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,63),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,63),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(8229,-10,0,63),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(52,52,8177,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(94,73,521,156),USE(?String45),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(625,73,521,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1604,73,208,156),USE(?String45:2),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1813,73,208,156),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(7281,73,521,156),USE(DAT),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(7813,73,417,156),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
       END
       FOOTER,AT(1000,7850,12000,10),USE(?unnamed:5)
         LINE,AT(52,0,8177,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  BIND('CN',CN)
  BIND('CYCLENOL',CYCLENOL)
  I# = 0
  C#=0
  NR#     = 0
  DAT = TODAY()
  LAI = CLOCK()
!!  NOL_TEX = FORMAT_NOLTEX25()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  BIND(NOL:RECORD)
  BIND(PAR:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçju izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'P10111'
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
      CLEAR(PAV:RECORD)
      PAV:PAR_NR=PAR_NR
      D_K = 'D'
      PAV:D_K=D_K
      PAV:DATUMS=S_DAT
      SET(PAV:PAR_KEY,PAV:PAR_KEY)
      Process:View{Prop:Filter} ='~CYCLENOL(CN)'
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
      IF F:OBJ_NR
         PRSTR"=GetProjekti(F:OBJ_NR,1)
         PROJEKTS='Projekts (Objekts) Nr: '&F:OBJ_NR&' - '&PRSTR"
      END
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('IENPTP.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='NOLIKTAVA: '&LOC_NR
          ADD(OUTFILEANSI)
          IF F:DBF='E'
            OUTA:LINE='IENÂKOÐÂS PRECES (PTP) - Piegâdâtâjs: '&PAR:NOS_P&' '&format(S_DAT,@d10.)&' - '&format(B_DAT,@d10.)
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE='IENÂKOÐÂS PRECES (PTP) - Piegâdâtâjs: '&PAR:NOS_P&' '&format(S_DAT,@d6)&' - '&format(B_DAT,@d6)
            ADD(OUTFILEANSI)
          END
          OUTA:LINE='Adrese: '&PAR:ADRESE&' '&PROJEKTS
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
          OUTA:LINE='Npk '&CHR(9)&'Dokumenta '&CHR(9)&'Dokumenta '&CHR(9)&'Pamatojums {30}'&CHR(9)&'Summa pçc   '&CHR(9)&CHR(9)&'   Preèu    '&CHR(9)&CHR(9)&'   Taras    '&CHR(9)&CHR(9)&'Pakalpojumu'
          ADD(OUTFILEANSI)
          OUTA:LINE=       CHR(9)&'Datums    '&CHR(9)&'Numurs    '&CHR(9)&'           {25}'&CHR(9)&'dokumenta   '&CHR(9)&CHR(9)&'   summa    '&CHR(9)&CHR(9)&'   summa    '&CHR(9)&CHR(9)&'summa'
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NR#+=1
        RPT_NR=NR#
        ?Progress:UserString{Prop:Text}=NR#
        DISPLAY(?Progress:UserString)
   !    rpt:p_summa=PAV:SUMMA*(1-PAV:ATLAIDE/100)
   !    rpt:p_summa=PAV:SUMMA-PAV:summa_a
        SUMMA_P = PAV:SUMMA
        GET(K_TABLE,0)
        K:VAL = PAV:VAL
        GET(K_TABLE,K:VAL)
        IF ERROR()
           K:VAL     = PAV:VAL
           K:SUMMA_P = summa_p
           ADD(K_TABLE)
           SORT(K_TABLE,K:VAL)
        ELSE
           K:SUMMA_P += summa_P
           PUT(K_TABLE)
        .
        done1#=0
        prece=0
        tara=0
        pakalpojumi=0
        clear(nol:record)
        nol:U_nr=pav:U_nr
        set(nol:nr_key,nol:nr_key)
        do nextnol
        loop until done1#
           clear(nom:record)
           nom:nomenklat=nol:nomenklat
!!           nom:mervien  =nol:mervien
           get(nom_k,nom:nom_key)
           case nom:tips
           of 'T'
              TARA+=calcsum(4,2)
           of 'A'
              PAKALPOJUMI+=calcsum(4,2)
           else
              PRECE+=calcsum(4,2)
           .
           do nextnol
        .
!!        K:SUMMATAK+=TARA
!!        K:SUMMAPAK+=PAKALPOJUMI
!!        K:SUMMAPRK+=PRECE
!!        PUT(K_TABLE)
!!        IF ERROR() THEN STOP('K_TABLE '&ERROR()).
        summa_PR = PRECE
        summa_TA = TARA
        summa_PA = PAKALPOJUMI
        SUMMA_PK  += SUMMA_P*BANKURS(PAV:VAL,PAV:DATUMS)
        summa_PRK += PRECE*BANKURS(PAV:VAL,PAV:DATUMS)
        summa_TAK += TARA*BANKURS(PAV:VAL,PAV:DATUMS)
        summa_PAK += PAKALPOJUMI*BANKURS(PAV:VAL,PAV:DATUMS)
        DOK_NR=PAV:DOK_SENR
        IF ~F:DTK
          IF F:DBF='W'
            PRINT(RPT:DETAIL)
          ELSE
            OUTA:LINE=CLIP(RPT_NR)&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&DOK_NR&CHR(9)&PAV:PAMAT&CHR(9)&|
            LEFT(format(SUMMA_P,@N12.2))&CHR(9)&PAV:VAL&CHR(9)&LEFT(format(SUMMA_PR,@N12.2))&CHR(9)&PAV:VAL&CHR(9)&|
            LEFT(format(SUMMA_TA,@N12.2))&CHR(9)&PAV:VAL&CHR(9)&LEFT(format(SUMMA_PA,@N12.2))&CHR(9)&PAV:VAL
            ADD(OUTFILEANSI)
          END
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
  IF SEND(PAVAD,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)                           !PRINT GRAND TOTALS
    ELSE
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
    END
!****************************DRUKÂJAM PÇC valûtâm **************
    KOPA='Kopâ:'
    VALK = 'Ls'
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSIF F:DBF='E'
        OUTA:LINE=format(KOPA,@s6)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&format(SUMMA_Pk,@N_12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_PRk,@N_12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAk,@N_12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAk,@N_12.2)
        ADD(OUTFILEANSI)
    ELSE
        OUTA:LINE=format(KOPA,@s6)&CHR(9)&CHR(9)&CHR(9)&' {45}'&CHR(9)&format(SUMMA_Pk,@N12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_PRk,@N12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAk,@N12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAk,@N12.2)
        ADD(OUTFILEANSI)
    END
    SUMMA_PK  = 0
    summa_PRK = 0
    summa_TAK = 0
    summa_PAK = 0
    KOPA = 't.s.'
    GET(K_TABLE,0)
    LOOP J# = 1 TO RECORDS(K_TABLE)
       GET(K_TABLE,J#)
       IF K:SUMMA_P <> 0
         SUMMA_PK = K:SUMMA_P
         VALK     = K:VAL
!!         SUMMAPrK =K:SUMMAprK
!!         SUMMAtaK =K:SUMMAtaK
!!         SUMMApaK =K:SUMMApaK
         IF F:DBF='W'
             PRINT(RPT:RPT_FOOT2)                      !PRINT GRAND TOTALS
         ELSIF F:DBF='E'
             OUTA:LINE=format(KOPA,@s6)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&format(SUMMA_Pk,@N_12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_PRk,@N_12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAk,@N_12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAk,@N_12.2)
             ADD(OUTFILEANSI)
         ELSE
             OUTA:LINE=format(KOPA,@s6)&CHR(9)&CHR(9)&CHR(9)&' {45}'&CHR(9)&format(SUMMA_Pk,@N12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_PRk,@N12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAk,@N12.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAk,@N12.2)
             ADD(OUTFILEANSI)
         END
         kopa=''
       .
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT3)                           !PRINT GRAND TOTALS
        ENDPAGE(report)
    ELSE
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
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(K_TABLE)
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
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR ~(PAV:PAR_NR=PAR_NR)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
OMIT('DIANA')
NEXTPAV      ROUTINE
  LOOP UNTIL EOF(PAVAD)
    NEXT(PAVAD)
    IF ~(PAV:PAZIME='D' AND PAV:PAR_NR=PAR:NR AND PAV:DATUMS <= B_DAT)
      BREAK
    .
    C#+=1
    SHOW(15,35,C#,@N3)
    IF ~RST() THEN CYCLE.
    IF PAV:NPK=1             !SALDO
      CYCLE
    .
    EXIT
 .
 DONE# = 1
DIANA
NEXTNOL      ROUTINE
  LOOP UNTIL EOF(NOLIK)
    NEXT(NOLIK)
    IF ~(PAV:U_NR = NOL:U_NR)
      BREAK
    .
    EXIT
  .
  DONE1#=1
GETDOK_SENR          FUNCTION (RET,DOK_SENR,<NR>,<ATT_DOK>) ! Declare Procedure
PZ_DOK_SENR     STRING(14)
FAKT_ATT_DOK    STRING(1)
DOK_SE          STRING(14)
DOK_NR          STRING(14)

  CODE                                            ! Begin processed code
!
! SADALA DOK_NR SÇRIJÂ UN NR VAI apvieno DOK_SENR & NR
!     RET 1-SÇRIJA VAI '', JA ~(ATT_DOK='2')
!         2-NUMURS VAI VISS, JA ~(ATT_DOK='2')
!         3-FORMÇ SÇRIJA-NUMURS
!         4-SÇRIJA VAI VISS, JA ~(ATT_DOK='2')
!         5-NUMURS VAI '', JA ~(ATT_DOK='2')
!

   IF ~INRANGE(RET,1,5) OR  ~DOK_SENR
      RETURN('')
   .
   PZ_DOK_SENR=DOK_SENR !LAI GARANTÇTU 14 BAITUS
   IF ~(RET=3)
      IF ATT_DOK='2' !NOLIKTAVÂ BÛS 2, JA PIEPRASÎTS PIEÐÍIRT Nr
         LOOP I#= 1 TO 14
            IF INSTRING(PZ_DOK_SENR[I#],'0123456789',1,1)
               DOK_NR=CLIP(DOK_NR)&PZ_DOK_SENR[I#] !IZRAUJAM ÂRÂ VISUS CIPARUS
            ELSIF PZ_DOK_SENR[I#]
               DOK_SE=CLIP(DOK_SE)&PZ_DOK_SENR[I#] !IZRAUJAM ÂRÂ VISUS NECIPARUS
            .
         .
      ELSE
         EXECUTE RET
            DOK_SE=''
            DOK_NR=PZ_DOK_SENR
            !
            DOK_SE=PZ_DOK_SENR
            DOK_NR=''
         .
      .
   .
   EXECUTE RET
       RETURN(DOK_SE)
       RETURN(DOK_NR)
       RETURN(CLIP(PZ_DOK_SENR)&' '&FORMAT(NR,@N06))
       RETURN(DOK_SE)
       RETURN(DOK_NR)
    .
