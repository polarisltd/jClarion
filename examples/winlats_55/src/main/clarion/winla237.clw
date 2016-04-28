                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_IenIzgPZKOPS       PROCEDURE                    ! Declare Procedure
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

DAT                 LONG
LAI                 LONG
NPK                 DECIMAL(5)
D_SUMMAK            DECIMAL(14,2)
D_TARAK             DECIMAL(11,2)
K_SUMMAK            DECIMAL(14,2)
K_TARAK             DECIMAL(11,2)
TARA                DECIMAL(11,2)
D_SKNAUDA           DECIMAL(14,2)
D_SKTARA            DECIMAL(11,2)
K_SKNAUDA           DECIMAL(14,2)
K_SKTARA            DECIMAL(11,2)
XCENA               STRING(20)
YCENA               STRING(20)
CN                  STRING(10)

D_TABLE          QUEUE,PRE(D)
DATUMS            LONG
DOK_NR            STRING(14)
PAR               STRING(25)
SUMMA             DECIMAL(14,2)
TARA              DECIMAL(11,2)
                 END

K_TABLE          QUEUE,PRE(K)
DATUMS            LONG
DOK_NR            STRING(14)
PAR               STRING(25)
SUMMA             DECIMAL(14,2)
TARA              DECIMAL(11,2)
                 END

END_DTABLE          BYTE
END_KTABLE          BYTE

!-----------------------------------------------------------------------------
Process:View         VIEW(PAVAD)
                       PROJECT(PAV:ACC_DATUMS)
                       PROJECT(PAV:ACC_KODS)
                       PROJECT(PAV:AKCIZE)
                       PROJECT(PAV:BAITS1)
                       PROJECT(PAV:BAITS2)
                       PROJECT(PAV:CITAS)
                       PROJECT(PAV:C_DATUMS)
                       PROJECT(PAV:C_SUMMA)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:DEK_NR)
                       PROJECT(PAV:DOK_SENR)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:EXP)
                       PROJECT(PAV:GG_U_NR)
                       PROJECT(PAV:KEKSIS)
                       PROJECT(PAV:KIE_NR)
                       PROJECT(PAV:MUITA)
                       PROJECT(PAV:NODALA)
                       PROJECT(PAV:NOKA)
                       PROJECT(PAV:OBJ_NR)
                       PROJECT(PAV:PAMAT)
                       PROJECT(PAV:PAR_ADR_NR)
                       PROJECT(PAV:PAR_NR)
                       PROJECT(PAV:PIELIK)
                       PROJECT(PAV:REK_NR)
                       PROJECT(PAV:RS)
                       PROJECT(PAV:SUMMA)
                       PROJECT(PAV:SUMMA_A)
                       PROJECT(PAV:SUMMA_B)
                       PROJECT(PAV:TEKSTS_NR)
                       PROJECT(PAV:T_PVN)
                       PROJECT(PAV:T_SUMMA)
                       PROJECT(PAV:U_NR)
                       PROJECT(PAV:VED_NR)
                       PROJECT(PAV:apm_k)
                       PROJECT(PAV:apm_v)
                       PROJECT(PAV:val)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(198,1740,12000,6000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,198,12000,1542),USE(?unnamed)
         STRING(@s45),AT(3781,104,4427,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(3979,1302,900,208),USE(xcena),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1198,1250,0,313),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(104,990,0,573),COLOR(COLOR:Black)
         LINE,AT(521,990,0,573),COLOR(COLOR:Black)
         LINE,AT(2500,990,0,573),COLOR(COLOR:Black)
         STRING('NPK'),AT(135,1146,365,167),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokuments'),AT(604,1042,1823,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokuments'),AT(5708,1042,1927,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(552,1302,625,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(5698,1302,625,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6354,1250,0,313),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(7656,990,0,573),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(5677,990,0,573),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(5625,990,0,573),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(4896,990,0,573),USE(?Line13),COLOR(COLOR:Black)
         STRING('Numurs'),AT(1500,1302,677,208),USE(?unnamed:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5677,1250,1979,0),USE(?Line16),COLOR(COLOR:Black)
         STRING('Numurs'),AT(6719,1302,677,208),USE(?unnamed:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4917,1302,690,208),USE(Ycena),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1510,10677,0),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(10052,990,0,573),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(10781,990,0,573),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(9115,990,0,573),USE(?Line20),COLOR(COLOR:Black)
         STRING('IENÂKUÐO / IZGÂJUÐO P/Z KOPSAVILKUMS'),AT(3906,417,4167,208),USE(?String56),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3958,990,0,573),USE(?Line12),COLOR(COLOR:Black)
         STRING(@P<<<#. lapaP),AT(9740,781,698,135),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,FONT:regular)
         STRING('no'),AT(4740,677,260,260),USE(?String57),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(5052,677),USE(S_DAT),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('lîdz'),AT(6042,677,313,260),USE(?String59),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(6406,677),USE(B_DAT),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,990,10677,0),USE(?Line8),COLOR(COLOR:Black)
         STRING('no kâ saòemts'),AT(2531,1146,1406,208),USE(?unnamed:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kam realizçts'),AT(7677,1146,1406,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('prece'),AT(3990,1146,885,156),USE(?unnamed:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('prece'),AT(9146,1146,885,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,1250,1979,0),USE(?Line9),COLOR(COLOR:Black)
         STRING('tara'),AT(4938,1146,677,156),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('tara'),AT(10083,1146,677,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,12000,177)
         LINE,AT(104,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,198),COLOR(COLOR:Black)
         STRING(@n_5),AT(156,10,313,156),USE(NPK),RIGHT(1)
         LINE,AT(10781,-10,0,198),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(10052,-10,0,198),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(9115,-10,0,198),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,198),USE(?Line30),COLOR(COLOR:Black)
         STRING(@s14),AT(6573,10,969,156),USE(K:DOK_NR),RIGHT
         LINE,AT(7656,-10,0,198),USE(?Line32),COLOR(COLOR:Black)
         STRING(@S14),AT(1396,10,979,156),USE(D:DOK_NR),RIGHT
         LINE,AT(2500,-10,0,198),USE(?Line26),COLOR(COLOR:Black)
         STRING(@D06.b),AT(573,10,573,156),USE(D:DATUMS),RIGHT(1)
         LINE,AT(1198,-10,0,198),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(5625,-10,0,198),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(5677,-10,0,198),USE(?Line29),COLOR(COLOR:Black)
         STRING(@s25),AT(7708,10,1396,156),USE(K:PAR),LEFT
         STRING(@n-_14.2B),AT(9167,10,833,156),USE(K:SUMMA),RIGHT(12)
         STRING(@n-_14.2B),AT(4010,10,833,156),USE(D:SUMMA),RIGHT(12)
         LINE,AT(4896,-10,0,198),USE(?Line27),COLOR(COLOR:Black)
         STRING(@n-_11.2B),AT(4948,10,625,156),USE(D:TARA),RIGHT
         STRING(@n-_11.2B),AT(10104,10,625,156),USE(K:TARA),RIGHT
         STRING(@s25),AT(2552,10,1396,156),USE(D:PAR),LEFT
         STRING(@D06.B),AT(5729,10,573,156),USE(K:DATUMS),RIGHT(1)
       END
detail1 DETAIL,AT(,,,1292),USE(?unnamed:4)
         LINE,AT(104,0,0,573),USE(?Line36:6),COLOR(COLOR:Black)
         LINE,AT(521,0,0,52),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(1198,0,0,52),USE(?Line37:111),COLOR(COLOR:Black)
         LINE,AT(2500,0,0,52),USE(?Line37:5),COLOR(COLOR:Black)
         LINE,AT(3958,0,0,573),USE(?Line36:4),COLOR(COLOR:Black)
         LINE,AT(4896,0,0,573),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(5625,0,0,573),USE(?Line36:7),COLOR(COLOR:Black)
         LINE,AT(5677,0,0,573),USE(?Line36:8),COLOR(COLOR:Black)
         LINE,AT(6354,0,0,52),USE(?Line37:2),COLOR(COLOR:Black)
         LINE,AT(7656,0,0,52),USE(?Line37:3),COLOR(COLOR:Black)
         LINE,AT(10052,0,0,573),USE(?Line36:2),COLOR(COLOR:Black)
         LINE,AT(10781,0,0,573),USE(?Line36:3),COLOR(COLOR:Black)
         LINE,AT(104,52,10677,0),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(9115,0,0,573),USE(?Line36:5),COLOR(COLOR:Black)
         STRING('KOPÂ SAÒEMTS:'),AT(2635,104,1302,208),USE(?String42),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_14.2B),AT(4010,104,833,156),USE(D_SUMMAK),RIGHT(12),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_11.2B),AT(4948,104,625,156),USE(D_TARAK),RIGHT(12),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('KOPÂ REALIZÇTS:'),AT(7813,104,1302,208),USE(?String42:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_14.2B),AT(9167,104,833,156),USE(K_SUMMAK),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_11.2B),AT(10104,104,625,156),USE(K_TARAK),RIGHT(12),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,313,10677,0),USE(?Line50:2),COLOR(COLOR:Black)
         STRING('t.s. skaidrâ naudâ'),AT(2635,365,1302,156),USE(?String42:3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_14.2B),AT(4010,365,833,156),USE(D_SKNAUDA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_11.2B),AT(4948,365,625,156),USE(D_SKTARA),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_14.2B),AT(9177,365,833,156),USE(K_SKNAUDA),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_11.2B),AT(10104,365,625,156),USE(K_SKTARA),TRN,RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,573,10677,0),USE(?Line50:3),COLOR(COLOR:Black)
         STRING('Materiâli atbildîgâs personas paraksts'),AT(781,781),USE(?String45)
         STRING('Galvenais (vecâkais) grâmatvedis'),AT(6042,781),USE(?String46)
         STRING(@d06.),AT(6813,958),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7417,958),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING('Sastâdîja :'),AT(73,979),USE(?String30),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(531,979),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1583,979),USE(?String30:2),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1792,979),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(3073,990,2865,0),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(8073,990,2865,0),USE(?Line55),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,7600,12000,52)
         LINE,AT(104,0,10677,0),USE(?Line50:4),COLOR(COLOR:Black)
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
  CHECKOPEN(PAR_K,1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1

  BIND(PAV:RECORD)
  BIND('CN',CN)

  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1

  IF NOKL_C1=0 !D PRECE IEPIRKUMA CENÂS
     XCENA='iep.cenâs'
  ELSE
     XCENA='pçc('&CLIP(NOKL_C1)&')cenas'
  .
  IF NOKL_C2=0 !D TARA IEPIRKUMA CENÂS
     YCENA='iep.cenâs'
  ELSE
     YCENA='pçc('&CLIP(NOKL_C2)&')cenas'
  .
  DAT= TODAY()
  LAI= CLOCK()

  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Ie/Iz PPR Kopsavilkums'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(PAV:RECORD)
      PAV:DATUMS=S_DAT
      SET(PAV:DAT_KEY,PAV:DAT_KEY)
!      Process:View{Prop:Filter} = ''
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
          IF ~OPENANSI('PZKOPS.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='IENÂKUÐO/IZGÂJUÐO P/Z KOPSAVILKUMS'
          ADD(OUTFILEANSI)
          OUTA:LINE='NO '&format(S_DAT,@d06.)&' LÎDZ '&format(B_DAT,@d06.)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta             '&CHR(9)&CHR(9)&'No kâ saòemts'&CHR(9)&'Prece'&CHR(9)&|
             'Tara'&CHR(9)&'Dokumenta            '&CHR(9)&CHR(9)&'Kam realizçts'&CHR(9)&'Prece'&CHR(9)&'Tara'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&'Datums'&CHR(9)&'Numurs'&CHR(9)&CHR(9)&XCENA&CHR(9)&YCENA&CHR(9)&'Datums'&|
             CHR(9)&'Numurs'&CHR(9)
             ADD(OUTFILEANSI)
          ELSE
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta datums'&CHR(9)&'Numurs'&CHR(9)&'No kâ saòemts'&CHR(9)&|
             'Prece '&XCENA&CHR(9)&'Tara '&YCENA&CHR(9)&'Dokumenta datums'&CHR(9)&'Numurs'&CHR(9)&|
             'Kam realizçts'&CHR(9)&'Prece'&CHR(9)&'Tara'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NR#+=1
        ?Progress:UserString{Prop:Text}=NR#
        DISPLAY(?Progress:UserString)
        CN='P1100000'   !MAX 10
!           12345678
        IF ~cycleNOL(CN)
           CASE PAV:D_K
           OF 'D'
               D:DATUMS=PAV:DATUMS
               GET(D_TABLE,D:DATUMS)
!               D:DOK_SE = GETDOK_SENR(1,PAV:DOK_SENR,,'2')
!               D:DOK_NR = GETDOK_SENR(2,PAV:DOK_SENR,,'2')
               D:DOK_NR = PAV:DOK_SENR
               IF ~PAV:PAR_NR
                  D:PAR=PAV:NOKA
               ELSE
                  D:PAR=SUB(GETPAR_K(PAV:PAR_NR,2,2),1,25) !45
               .
               DO PERFORMSUMMA
               ADD(D_TABLE)
               SORT(D_TABLE,D:DATUMS)
           OF 'K'
               K:DATUMS=PAV:DATUMS
               GET(K_TABLE,K:DATUMS)
!               K:DOK_SE = GETDOK_SENR(1,PAV:DOK_SENR,,'2')
!               K:DOK_NR = GETDOK_SENR(2,PAV:DOK_SENR,,'2')
               K:DOK_NR = PAV:DOK_SENR
               IF ~PAV:PAR_NR OR CL_NR=1316 !ELPA
                  K:PAR=PAV:NOKA  !15
               ELSE
                  K:PAR=SUB(GETPAR_K(PAV:PAR_NR,2,2),1,25) !45
               .
               DO PERFORMSUMMA
               ADD(K_TABLE)
               SORT(K_TABLE,K:DATUMS)
           END
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
      I#=0
      END_DTABLE=FALSE
      END_KTABLE=FALSE
      LOOP
        I#+=1
        GET(D_TABLE,I#)
        IF ERROR()
           END_DTABLE=TRUE
           D:DATUMS=0
!           D:DOK_SE=''
           D:DOK_NR=''
           D:PAR=''
           D:SUMMA=0
           D:TARA=0
        .
        GET(K_TABLE,I#)
        IF ERROR()
           END_KTABLE=TRUE
           K:DATUMS=0
!           K:DOK_SE=''
           K:DOK_NR=''
           K:PAR=''
           K:SUMMA=0
           K:TARA=0
        .
        IF END_DTABLE AND END_KTABLE
           BREAK
        ELSE
           NPK += 1
           D_SUMMAK += D:SUMMA
           D_TARAK  += D:TARA
           K_SUMMAK += K:SUMMA
           K_TARAK  += K:TARA
           IF F:DBF = 'W'
                PRINT(RPT:DETAIL)
           ELSE
                OUTA:LINE=NPK&CHR(9)&FORMAT(D:DATUMS,@D06.B)&CHR(9)&D:DOK_NR&CHR(9)&D:PAR&CHR(9)&|
                LEFT(FORMAT(D:SUMMA,@N-_14.2B))&CHR(9)&LEFT(FORMAT(D:TARA,@N-_11.2B))&CHR(9)&FORMAT(K:DATUMS,@D06.B)&|
                CHR(9)&K:DOK_NR&CHR(9)&K:PAR&CHR(9)&LEFT(FORMAT(K:SUMMA,@N-_14.2B))&CHR(9)&|
                LEFT(FORMAT(K:TARA,@N-_11.2B))
                ADD(OUTFILEANSI)
           END
        END
      END
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL1)
    ELSE
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'Kopâ saòemts:'&CHR(9)&LEFT(FORMAT(D_SUMMAK,@N-_14.2))&CHR(9)&|
        LEFT(FORMAT(D_TARAK,@N-_11.2))&CHR(9)&CHR(9)&CHR(9)&'Kopâ realizçts:'&CHR(9)&LEFT(FORMAT(K_SUMMAK,@N-_14.2))&|
        CHR(9)&LEFT(FORMAT(K_TARAK,@N-_11.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'t.s.skaidrâ naudâ'&CHR(9)&LEFT(FORMAT(D_SKNAUDA,@N-_14.2))&CHR(9)&|
        LEFT(FORMAT(D_SKTARA,@N-_11.2))&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(K_SKNAUDA,@N-_14.2))&CHR(9)&|
        LEFT(FORMAT(K_SKTARA,@N-_11.2))
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
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
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
  PREVIOUS(Process:View)
  IF ERRORCODE() OR PAV:DATUMS>B_DAT
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

!-----------------------------------------------------------------------------
PERFORMSUMMA   ROUTINE

  SUMMA=0
  TARA =0
  CLEAR(NOL:RECORD)
  NOL:U_NR=PAV:U_NR
  SET(NOL:NR_KEY,NOL:NR_KEY)
  LOOP
     NEXT(NOLIK)
!     STOP(ERROR())
     IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
     IF GETNOM_K(NOL:NOMENKLAT,0,16)='P'
        IF NOKL_C1=0 OR PAV:D_K='K'
           SUMMA += CALCSUM(16,2)
        ELSE
           SUMMA+=GETNOM_K(NOL:NOMENKLAT,0,7,NOKL_C1)*NOL:DAUDZUMS
        .
     ELSIF GETNOM_K(NOL:NOMENKLAT,0,16)='T'
        IF NOKL_C2=0 OR PAV:D_K='K'
           TARA += CALCSUM(16,2)
        ELSE
           TARA+=GETNOM_K(NOL:NOMENKLAT,0,7,NOKL_C2)*NOL:DAUDZUMS
        .
     .
  .
  CASE PAV:D_K
  OF 'D'
     IF NOKL_C1=0 AND INRANGE(PAV:SUMMA-(SUMMA+TARA),-0.04,0.04)  !KLÛDA APAÏOJOT
        SUMMA+=PAV:SUMMA-(SUMMA+TARA)
     .
     D:SUMMA = SUMMA
     D:TARA  = TARA
     IF PAV:apm_k='2' !SKAIDRÂ NAUDÂ
        D_SKNAUDA  += SUMMA
        D_SKTARA   += TARA
     .
  OF 'K'
     IF INRANGE(PAV:SUMMA-(SUMMA+TARA),-0.04,0.04)  !KLÛDA APAÏOJOT
        SUMMA+=PAV:SUMMA-(SUMMA+TARA)
     .
     K:SUMMA = SUMMA
     K:TARA  = TARA
     IF PAV:apm_k='2' !SKAIDRÂ NAUDÂ
        K_SKNAUDA  += SUMMA
        K_SKTARA   += TARA
     .
  .
ConvertREDZ          FUNCTION (NOM_REDZAMIBA)     ! Declare Procedure
  CODE                                            ! Begin processed code
EXECUTE NOM_REDZAMIBA+1
   RETURN(1)
   RETURN(2)
   RETURN(4)
   RETURN(8)
.
RETURN(1)
RenameFile           PROCEDURE (name_old,name_new) ! Declare Procedure
namefile         string(60),static
KAFILE           FILE,DRIVER('DOS'),NAME(NameFILE),PRE(KA)
RECORD              RECORD
G                     BYTE
                 . .
  CODE                                            ! Begin processed code
  namefile=name_old
  CLOSE(KAFILE)
  RENAME(KAFILE,NAME_NEW)
  IF ERROR()
     KLUDA(0,'Kïûda mainot faila vârdu: '&name_old&' uz '&name_new)
  .
