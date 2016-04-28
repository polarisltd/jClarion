                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_IENIZGNOL          PROCEDURE                    ! Declare Procedure
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
CENA                 DECIMAL(8,2)
APGROZIJUMS          DECIMAL(14,3)
ATLIKUMSB            DECIMAL(14,3)
IENACISK             DECIMAL(14,3)
IZGAJISK             DECIMAL(14,3)
APGROZIJUMSK         DECIMAL(14,3)
ATLIKUMSSK           DECIMAL(14,3)
ATLIKUMSBK           DECIMAL(14,3)
KOPA                 STRING(10)
DAT                  DATE
LAI                  TIME
NOL_TEX              STRING(80)
CN                   STRING(10)

AP_TABLE          QUEUE,PRE(A)
NOMENKLAT            STRING(21)
ATLIKUMSS            DECIMAL(14,3)
IENACIS              DECIMAL(14,3)
IZGAJIS              DECIMAL(14,3)
                  END
NOLIKTAVA_TEXT       STRING(30)
FILTRS_TEXT          STRING(100)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:ARBYTE)
                     END

report REPORT,AT(146,1833,8000,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(146,160,8000,1698),USE(?unnamed:2)
         STRING('Atlikums uz'),AT(6854,1250,781,208),USE(?String4:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Apgroz�jums'),AT(6073,1250,729,208),USE(?String4:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izg�jis'),AT(5396,1250,625,208),USE(?String4:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ien�cis'),AT(4719,1250,625,208),USE(?String4:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4688,1198,0,521),USE(?Line2:16),COLOR(COLOR:Black)
         STRING('(r�ts)'),AT(4406,1458,260,208),USE(?String4:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d05.),AT(6854,1458),USE(b_dat),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(vak.)'),AT(7323,1458,313,208),USE(?String4:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums uz'),AT(3885,1250,781,208),USE(?String4:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1625,156,4479,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(2396,365,2969,208),USE(NOLIKTAVA_TEXT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Pre�u apgroz�juma re�istr�cijas �urn�ls'),AT(2250,688,3229,208),USE(?String4),CENTER, |
             FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(2625,1000),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:ANSI)
         STRING('FORMA PNVI2'),AT(5990,1042,885,156),USE(?String4:2),LEFT
         STRING(@P<<<#. lapaP),AT(6823,1042,677,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(104,1198,7552,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1771,1198,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Nomenklat�ra'),AT(135,1250,1615,208),USE(?String4:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(1802,1250,1510,208),USE(?String4:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('.Cena'),AT(3469,1250,365,208),USE(?String4:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(156,1458,1615,208),USE(nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1667,7552,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@S1),AT(3365,1250,156,208),USE(SYS:nokl_cp),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(3365,1458,469,208),USE(?String4:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d05.),AT(3885,1458),USE(s_dat),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3333,1198,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(3854,1198,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5365,1198,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6042,1198,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6823,1198,0,521),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(7656,1198,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(104,1198,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,8000,177),USE(?unnamed:3)
         LINE,AT(1771,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@N-_13.3),AT(4719,10,625,156),USE(A:ienacis),RIGHT
         LINE,AT(5365,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@N-_13.3),AT(5396,10,625,156),USE(A:izgajis),RIGHT
         LINE,AT(6042,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N-_13.3),AT(6094,10,677,156),USE(apgrozijums),RIGHT
         LINE,AT(6823,-10,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N-_13.3),AT(6875,10,729,156),USE(atlikumsB),RIGHT
         LINE,AT(7656,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@s21),AT(156,10,1615,156),USE(NOM:NOMENKLAT),FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(1802,10,1510,156),USE(NOM:NOS_P),FONT(,,,,CHARSET:BALTIC)
         LINE,AT(3333,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(3365,10,469,156),USE(CENA),RIGHT
         LINE,AT(3854,-10,0,198),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N-_13.3),AT(3958,10,677,156),USE(A:atlikumsS),RIGHT
       END
detail1 DETAIL,AT(,,,94)
         LINE,AT(104,52,7552,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,115),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,115),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,115),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,115),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,115),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,115),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,115),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(1771,-10,0,63),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,115),USE(?Line34),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,8000,177)
         STRING(@N-_14.3B),AT(6875,10,729,156),USE(atlikumsBK),RIGHT
         STRING(@N-_14.3B),AT(6094,10,677,156),USE(apgrozijumsK),RIGHT
         STRING(@N-_14.3B),AT(5396,10,625,156),USE(izgajisK),RIGHT
         STRING(@N-_14.3B),AT(4719,10,625,156),USE(ienacisK),RIGHT
         STRING(@N-_14.3B),AT(3906,10,729,156),USE(atlikumsSK),RIGHT
         LINE,AT(7656,-10,0,198),USE(?Line33),COLOR(COLOR:Black)
         STRING(@s10),AT(208,10,729,156),USE(kopa),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5365,-10,0,198),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,198),USE(?Line33:3),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,198),USE(?Line31:2),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,198),USE(?Line31:3),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,198),USE(?Line31:4),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,250),USE(?unnamed)
         LINE,AT(104,-10,0,62),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,62),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,62),USE(?Line45),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,62),USE(?Line46),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,62),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,62),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,62),USE(?Line49),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,62),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(104,52,7552,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sast�d�ja :'),AT(115,73,469,146),USE(?String30),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(604,73,625,146),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1260,73,208,146),USE(?String30:2),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1458,73,188,146),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6625,73,625,146),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7198,73),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(146,11150,8000,63)
         LINE,AT(104,0,7552,0),USE(?Line1:4),COLOR(COLOR:Black)
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
  CHECKOPEN(PAVAD,1)
  BIND(NOM:RECORD)
  BIND(NOL:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('NOMENKLAT',NOMENKLAT)
  BIND('F:KRI',F:KRI)
  BIND('CN',CN)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)
  dat = today()
  lai = clock()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Pre�u apgroz�juma re�istr�cijas �urn�ls'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(NOL:RECORD)
      NOL:DATUMS = DATE(1,1,GADS)
      SET(NOL:DAT_KEY,NOL:DAT_KEY)
      CN = 'N1100'
      NOLIKTAVA_TEXT='Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      FILTRS_TEXT='' !NAV VAJADZ�GS
      Process:View{Prop:Filter} = '~CYCLENOM(NOL:NOMENKLAT) AND ~CYCLENOL(CN)'
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
      IF F:DBF='W'      !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE
        IF ~OPENANSI('APGROZ.TXT')
          POST(Event:CloseWindow)
          CYCLE
        .
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=NOLIKTAVA_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE='Pre�u apgroz�juma re�istr�cijas �urn�ls'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='NOMENKLAT�RA'&CHR(9)&'NOSAUKUMS'&CHR(9)&'('&NOKL_CP&') Cena'&CHR(9)&'Atlikums  uz'&CHR(9)&'Ien�cis'&CHR(9)&'Izg�jis'&CHR(9)&'Apgroz�jums'&CHR(9)&'Atlikums uz'
        ADD(OUTFILEANSI)
        OUTA:LINE=NOMENKLAT&CHR(9)&CHR(9)&'bez PVN'&CHR(9)&format(S_DAT,@d06.)&'(r�ts)'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&format(B_DAT,@d06.)&'(vakars)'
        ADD(OUTFILEANSI)
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        npk#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        GET(AP_TABLE,0)
        A:NOMENKLAT=NOL:NOMENKLAT
        GET(AP_TABLE,A:NOMENKLAT)
        IF ERROR()
           A:ATLIKUMSS=0
           A:IENACIS=0
           A:IZGAJIS=0
           IF NOL:DATUMS < S_DAT
              IF NOL:D_K='D'
                 A:ATLIKUMSS += NOL:DAUDZUMS
              ELSIF NOL:D_K='K'
                 A:ATLIKUMSS -= NOL:DAUDZUMS
              .
           ELSE
              IF NOL:D_K='D'
                 A:IENACIS=NOL:DAUDZUMS
              ELSIF NOL:D_K='K'
                 A:IZGAJIS=NOL:DAUDZUMS
              .
           .
           ADD(AP_TABLE)
           SORT(AP_TABLE,A:NOMENKLAT)
        ELSE
           IF NOL:DATUMS < S_DAT
              IF NOL:D_K='D'
                 A:ATLIKUMSS+=NOL:DAUDZUMS
              ELSIF NOL:D_K='K'
                 A:ATLIKUMSS-=NOL:DAUDZUMS
              .
           ELSE
              IF NOL:D_K='D'
                 A:IENACIS+=NOL:DAUDZUMS
              ELSIF NOL:D_K='K'
                 A:IZGAJIS+=NOL:DAUDZUMS
              .
           .
           PUT(AP_TABLE)
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
  npk#=0
  LOOP I#=1 TO RECORDS(AP_TABLE)
     npk#+=1
     ?Progress:UserString{Prop:Text}='Rakstu : '&NPK#&' no '&RECORDS(AP_TABLE)
     DISPLAY(?Progress:UserString)
     GET(AP_TABLE,I#)
     CENA = GETNOM_K(A:NOMENKLAT,0,7)    !PIE REIZES AR� POZICION�
     IF NOM:TIPS='A' THEN CYCLE.
     APGROZIJUMS=A:IENACIS-A:IZGAJIS
     ATLIKUMSB=A:ATLIKUMSS+A:IENACIS-A:IZGAJIS
     IF ~(A:IENACIS= 0 AND A:IZGAJIS=0 AND F:KRI) ! F:KRI = '1' -tikai, kam ir apgroz�jums
       IF F:DBF='W'       !WMF
         PRINT(RPT:DETAIL)
       ELSE               !WORD,EXCEL
         OUTA:LINE=NOM:NOMENKLAT&CHR(9)&NOM:NOS_P&CHR(9)&FORMAT(CENA,@N_8.2)&CHR(9)&LEFT(FORMAT(A:ATLIKUMSS,@N-_14.3))&CHR(9)&LEFT(FORMAT(A:IENACIS,@N-_14.3))&CHR(9)&LEFT(FORMAT(A:IZGAJIS,@N-_14.3))&CHR(9)&LEFT(FORMAT(APGROZIJUMS,@N-_14.3))&CHR(9)&LEFT(FORMAT(ATLIKUMSB,@N-_14.3))
         ADD(OUTFILEANSI)
       .
       ATLIKUMSSK  +=A:ATLIKUMSS
       IENACISK    +=A:IENACIS
       IZGAJISK    +=A:IZGAJIS
       APGROZIJUMSK+=APGROZIJUMS
       ATLIKUMSBK  +=ATLIKUMSB
     .
  .
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    KOPA='Kop� :'
    IF F:DBF='W'    !WMF
        PRINT(RPT:DETAIL1)
    ELSE            !TXT
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT3)
    ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&LEFT(FORMAT(ATLIKUMSSK,@N-_14.3))&CHR(9)&LEFT(FORMAT(IENACISK,@N-_14.3))&CHR(9)&LEFT(FORMAT(IZGAJISK,@N-_14.3))&CHR(9)&LEFT(FORMAT(APGROZIJUMSK,@N-_14.3))&CHR(9)&LEFT(FORMAT(ATLIKUMSBK,@N-_14.3))
        ADD(OUTFILEANSI)
    .
    IF F:DBF='W'
        PRINT(RPT:DETAIL2)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    .
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
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
  END
  FREE(AP_TABLE)
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'. !PAGAID�M
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
N_InvAkts            PROCEDURE                    ! Declare Procedure
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
MER                  STRING(7)
NOS                  STRING(3)
NOMEN                STRING(21)
DAUDZUMS             DECIMAL(12,3)
CENA                 DECIMAL(12,3)
KOPA                 STRING(10)
DAUDZUMSK            DECIMAL(14,3)
SUMMAK               DECIMAL(14,2)
DAT                  DATE
LAI                  TIME
NOL                  STRING(1)
KodsKatNos_text      STRING(35)
KodsKatNos           STRING(90)
KodsKatNos_NR        BYTE
CENAX                STRING(7)

K_TABLE              QUEUE,PRE(K)
NOS                   STRING(3)
SUMMA                 DECIMAL(14,2)
                     .
DOKDATUMS            STRING(25)
AKTS_NR              DECIMAL(3)

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

report REPORT,AT(198,390,8000,10802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,255,8000,135),USE(?unnamed)
         STRING(@P<<<#. lapaP),AT(7135,0,573,140),PAGENO,USE(?PageCount),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(104,135,7604,0),USE(?Line1:10),COLOR(COLOR:Black)
       END
PAGE_HEAD0 DETAIL,AT(,,,3010),USE(?unnamed:3)
         STRING(@s45),AT(260,177,4323,200),USE(CLIENT),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('_{32}'),AT(5625,854,1875,260),USE(?String2:14),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(5521,458,2031,260),USE(DOKDATUMS,,?DOKDATUMS:1),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Inventariz�cijas akts  Nr'),AT(260,625,1979,198),USE(?String2:2),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3B),AT(2240,625,365,198),USE(AKTS_NR),TRN,FONT(,12,,FONT:bold,CHARSET:ANSI)
         STRING('Komisijas locek�i'),AT(573,1667,1667,260),USE(?String2:7),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2240,1927,2031,260),USE(?String2:8),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2240,2188,2031,260),USE(?String2:9),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('un konstat�ja sekojo�o :'),AT(573,2708,1667,260),USE(?String2:11),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2240,2448,2031,260),USE(?String2:10),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(208,885,677,198),USE(B_DAT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('veikta pre�u kr�jumu un naudas l�dzek�u inventariz�cija.'),AT(938,885,3802,198),USE(?String2:4), |
             LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Izveidota komisija sekojo�� sast�v� :'),AT(208,1146,2552,198),USE(?String2:5),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('"APSTIPRINU"'),AT(5625,188,1458,260),USE(?String2:12),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktava:'),AT(260,396,833,198),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(1146,396,260,198),USE(LOC_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Komisijas priek�s�d�t�js'),AT(573,1406,1667,260),USE(?String2:6),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2240,1406,2031,260),USE(?String2:30),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2240,1667,2031,260),USE(?String2:31),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
PAGE_HEAD DETAIL,AT(,,,500),USE(?unnamed:5)
         LINE,AT(4688,0,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5469,0,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6240,0,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6906,10,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(104,0,7604,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Nomenklat�ra'),AT(156,52,1563,208),USE(?String19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(1823,156,2813,208),USE(KodsKatNos_text),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudz. p�c'),AT(4792,52,625,208),USE(?String19:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s7),AT(5615,52,521,208),USE(CENAX),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(6260,52,594,208),USE(?String19:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(6990,52,625,208),USE(?String19:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(156,260,1563,208),USE(nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING('fin. dok.'),AT(4792,260,625,208),USE(?String19:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5490,260,281,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(5771,260,469,208),USE(?String19:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6260,260,510,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('p�c fakta'),AT(6990,260,625,208),USE(?String19:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,469,7604,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(104,0,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:6)
         STRING(@n-_12.3),AT(4740,10,677,156),USE(daudzums),RIGHT
         LINE,AT(5469,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@n_11.3),AT(5490,10,729,156),USE(cena),RIGHT
         LINE,AT(6240,-10,0,198),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(6260,10,625,156),USE(summa),RIGHT
         STRING(@s7),AT(7198,10),USE(nom:mervien),TRN,RIGHT
         LINE,AT(6906,-10,0,198),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@s90),AT(1740,10,2917,156),USE(KodsKatNos),LEFT
         LINE,AT(4688,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@s21),AT(135,10,1563,156),USE(nom:nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,,,94),USE(?unnamed:8)
         LINE,AT(104,52,7604,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,115),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(6906,-10,0,115),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(6240,-10,0,115),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(5469,-10,0,115),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,63),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,115),USE(?Line22),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,354),USE(?unnamed:2)
         LINE,AT(7708,-10,0,218),USE(?Line32:5),COLOR(COLOR:Black)
         LINE,AT(6906,-10,0,218),USE(?Line32:4),COLOR(COLOR:Black)
         LINE,AT(6240,-10,0,218),USE(?Line32:3),COLOR(COLOR:Black)
         LINE,AT(5469,-10,0,218),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,218),USE(?Line32),COLOR(COLOR:Black)
         STRING(@s10),AT(156,10,729,156),USE(kopa),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_14.3),AT(4688,10,729,156),USE(daudzumsk),RIGHT
         STRING(@n-_14.2),AT(6260,10,625,156),USE(summaK),RIGHT
         LINE,AT(104,208,7604,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,3896),USE(?unnamed:4)
         STRING('_{25}'),AT(2083,3333,2031,208),USE(?String2:27),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Sast�d�ja:'),AT(385,3698),USE(?String60),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(833,3698),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('/ amats, v�rds, uzv�rds, paraksts /'),AT(2188,3542,2031,208),USE(?String2:28),LEFT,FONT(,9,,FONT:regular,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2188,2656,2031,208),USE(?String2:24),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('/ amats, v�rds, uzv�rds, paraksts /'),AT(2188,2865,2031,208),USE(?String2:25),LEFT,FONT(,9,,FONT:regular,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2188,2240,2031,208),USE(?String2:22),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('/ amats, v�rds, uzv�rds, paraksts /'),AT(2188,2448,2031,208),USE(?String2:23),LEFT,FONT(,9,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(208,573,6719,0),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(208,781,6719,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(208,990,6719,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING('Komisijas priek�s�d�t�js - _{25}'),AT(521,1042,3802,156),USE(?String2:16),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2188,1823,2031,208),USE(?String2:20),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('/ amats, v�rds, uzv�rds, paraksts /'),AT(2188,2031,2031,208),USE(?String2:21),LEFT,FONT(,9,,FONT:regular,CHARSET:BALTIC)
         STRING('/ amats, v�rds, uzv�rds, paraksts /'),AT(2188,1198,2031,208),USE(?String2:17),LEFT,FONT(,9,,FONT:regular,CHARSET:BALTIC)
         STRING('Sl�dziens :'),AT(260,156,990,260),USE(?String2:15),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Komisijas locek�i {13}- _{25}'),AT(521,1406,3802,208),USE(?String2:18),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('�� inventariz�cijas akta datus un apr��inus p�rbaud�ju'),AT(521,3073,3646,260),USE(?String2:26), |
             LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('/ amats, v�rds, uzv�rds, paraksts /'),AT(2188,1615,2031,208),USE(?String2:19),LEFT,FONT(,9,,FONT:regular,CHARSET:BALTIC)
         STRING('RS:'),AT(1615,3698),USE(?String59),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1802,3698),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@s25),AT(146,3333,2021,260),USE(DOKDATUMS),RIGHT(1),FONT(,10,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(1250,365,5677,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,11100,8000,63),USE(?unnamed:7) 
         LINE,AT(104,0,7604,0),USE(?Line1:9),COLOR(COLOR:Black)
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

Virsraksts_w WINDOW(' '),AT(,,140,115),FONT('MS Sans Serif',10,,FONT:bold,CHARSET:BALTIC),GRAY
       STRING('Inventariz�cijas Akts Nr :'),AT(12,15),USE(?String1)
       ENTRY(@n4),AT(92,14,20,10),USE(AKTS_NR,,?AKTS_NR:V)
       OPTION('Preces nosaukums :'),AT(8,31,126,61),USE(KodsKatNos_NR),BOXED
         RADIO('Kods,Pilns nosaukums'),AT(17,44),USE(?KodsKatNos_NR:Radio1),VALUE('1')
         RADIO('Kods,Sa�sin�tais nosaukums'),AT(17,54,102,10),USE(?KodsKatNos_NR:Radio12),VALUE('2')
         RADIO('Pilns nosaukums'),AT(17,64),USE(?KodsKatNos_NR:Radio3),VALUE('3')
         RADIO('Kataloga Nr,Pilns nosaukums'),AT(17,74,101,10),USE(?KodsKatNos_NR:Radio4),VALUE('4')
       END
       BUTTON('OK'),AT(100,95,35,14),USE(?Ok_V),DEFAULT
     END
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
  BIND('B_DAT',B_DAT)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)
  BIND('NOMENKLAT',NOMENKLAT)
  BIND('F:SECIBA',F:SECIBA)
  BIND('F:KRI',F:KRI)
  BIND('F:DBF',F:DBF)
  BIND('NOMEN',NOMEN)

  KodsKatNos_NR=1
  OPEN(VIRSRAKSTS_W)
  DISPLAY
  ACCEPT
     CASE FIELD()
     OF ?OK_V
        BREAK
     .
  .
  CLOSE(VIRSRAKSTS_W)

  IF F:IDP='1' !J�b�v� INVENT fails
    IF LOC_NR < 9
       NOL=LOC_NR
    ELSE
       NOL=CHR(LOC_NR+55)
    .
    INVNAME='I'&NOL&FORMAT(B_DAT,@D11)&'.TPS'
!    INVNAME='I'&FORMAT(LOC_NR,@N02)&CLIP(NOKL_CP)&'-'&FORMAT(B_DAT,@D11)&'.TPS'  ! LFN NEIET !!!
    CHECKOPEN(INVENT,1)
    CLOSE(INVENT)
    OPEN(INVENT,18)
    EMPTY(INVENT)
  .

  CLEAR(PAR:RECORD)
  PAR:U_NR=SYS:AVOTS
  GET(PAR_K,PAR:NR_KEY)


  DOKDATUMS=GETDOKDATUMS(B_DAT)
  dat = today()
  lai = clock()

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
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Inventariz�cijas Akts'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CENAX='Cena('&NOKL_CP&')'
      CLEAR(nom:RECORD)
      EXECUTE KodsKatNos_Nr
         KodsKatNos_text='Kods,Nosaukums'
         KodsKatNos_text='Kods,Nosaukums(sa�sin.)'
         KodsKatNos_text='Nosaukums'
         KodsKatNos_text='Kataloga Nr,Nosaukums'
      .

      CASE F:SECIBA
      OF 'N'
        NOM:nomenklat=NOMENKLAT
        SET(nom:NOM_key,nom:nom_key)
      ELSE
        SET(nom:KOD_key,NOM:KOD_KEY)
      .
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
          PRINT(RPT:PAGE_HEAD0)
          PRINT(RPT:PAGE_HEAD)
      ELSE
          IF ~OPENANSI('INVAKTS.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT&' {10}APSTIPRINU'
          ADD(OUTFILEANSI)
          OUTA:LINE='Noliktava: '&CLIP(LOC_NR)&' {40}'&DOKDATUMS
          ADD(OUTFILEANSI)
          OUTA:LINE=' '
          ADD(OUTFILEANSI)
          OUTA:LINE='INVENTARIZ�CIJAS AKTS Nr '&FORMAT(AKTS_NR,@N3B)&' {20}________________________________'
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
!             OUTA:LINE='Nomenklat�ra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'M�rv.'&CHR(9)&|
!             'Daudzums p�c'&CHR(9)&'Cena ('&nokl_cp&'), Ls'&CHR(9)&'Summa,Ls'&CHR(9)&'Daudzums'
             OUTA:LINE='Nomenklat�ra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'M�rv.'&CHR(9)&|
             'Daudzums p�c'&CHR(9)&'Cena ('&nokl_cp&'), '&val_uzsk&CHR(9)&'Summa,'&val_uzsk&CHR(9)&'Daudzums'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'fin.dokum.'&CHR(9)&'bez PVN'&CHR(9)&CHR(9)&'p�c fakta'
             ADD(OUTFILEANSI)
          ELSE
!             OUTA:LINE='Nomenklat�ra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'M�rv.'&CHR(9)&|
!             'Daudzums p�c fin.dokum.'&CHR(9)&'Cena ('&nokl_cp&'), Ls bez PVN'&CHR(9)&'Summa,Ls'&CHR(9)&|
!             'Daudzums p�c fakta'
             OUTA:LINE='Nomenklat�ra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'M�rv.'&CHR(9)&|
             'Daudzums p�c fin.dokum.'&CHR(9)&'Cena ('&nokl_cp&'), '&val_uzsk&' bez PVN'&CHR(9)&'Summa,'&val_uzsk&CHR(9)&|
             'Daudzums p�c fakta'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nr#+=1
        ?Progress:UserString{Prop:Text}=NR#
        IF ~cyclenom(nom:nomenklat) AND ~(NOM:TIPS='A')
           DISPLAY(?Progress:UserString)
           DAUDZUMS=LOOKATL(3)
           CENA=GETNOM_K('POZICION�TS',0,7)
           NOS=GETNOM_K('POZICION�TS',0,13)
           SUMMA=CENA*DAUDZUMS
           SUMMAK+=SUMMA
           DAUDZUMSK+=DAUDZUMS
           IF DAUDZUMS OR ~F:KRI !J�DRUK� AR� NULLES
             IF F:IDP='1'        !J�b�v� INVENT fails
               INV:NOMENKLAT   = NOM:NOMENKLAT
               INV:NOSAUKUMS   = NOM:NOS_P
               INV:NOS_A       = NOM:NOS_A
               INV:KODS        = NOM:KODS
               INV:KATALOGA_NR = NOM:KATALOGA_NR
               INV:CENA        = CENA
               INV:ATLIKUMS    = DAUDZUMS
               INV:ACC_KODS    = ACC_KODS
               INV:ACC_DATUMS  = TODAY()
               ADD(INVENT)
             END
             IF F:DBF='W'
               EXECUTE KodsKatNos_Nr
                  KodsKatNos=FORMAT(NOM:KODS,@N013)&' '&CLIP(NOM:NOS_P)
                  KodsKatNos=FORMAT(NOM:KODS,@N013)&' '&CLIP(NOM:NOS_S)
                  KodsKatNos=CLIP(NOM:NOS_P)
                  KodsKatNos=CLIP(NOM:KATALOGA_NR)&' '&CLIP(NOM:NOS_P)
               .
               PRINT(RPT:DETAIL)
             ELSE !EXCEL,WORD
               OUTA:LINE=NOM:NOMENKLAT&CHR(9)&NOM:KATALOGA_NR&CHR(9)&LEFT(FORMAT(NOM:KODS,@N_13))&CHR(9)&NOM:NOS_P&|
               CHR(9)&NOM:MERVIEN&CHR(9)&LEFT(FORMAT(DAUDZUMS,@N-_14.3))&CHR(9)&LEFT(FORMAT(CENA,@N_12.3))&|
               CHR(9)&LEFT(FORMAT(SUMMA,@N-_14.2))
               ADD(OUTFILEANSI)
             END
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
    IF F:DBF='W'
       PRINT(RPT:RPT_FOOT1)
    .
    KOPA='Kop� :'
    IF F:DBF='W'
       PRINT(RPT:RPT_FOOT2)
    ELSE   !EXCEL,WORD
       OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&CHR(9)&|
       LEFT(FORMAT(SUMMAK,@N-_14.2))
       ADD(OUTFILEANSI)
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
ProcedureReturn       ROUTINE
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
  free(k_table)
  IF F:DBF='E' THEN F:DBF='W'. !PAGAID�M
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
  IF ERRORCODE() OR (CYCLENOM(NOM:NOMENKLAT)=2 AND F:SECIBA='N')
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
N_KARTDRU            PROCEDURE                    ! Declare Procedure
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

DS1                  DECIMAL(12,3)
SS1                  DECIMAL(11,3)
ID1                  DECIMAL(12,3)
IS1                  DECIMAL(11,3)
AD1                  DECIMAL(13,3)
DOK_NR               STRING(10)
DOK_SE               STRING(7)
DS0                  DECIMAL(12,3)
SS0                  DECIMAL(11,3)
ID0                  DECIMAL(12,3)
IS0                  DECIMAL(11,3)
AD0                  DECIMAL(12,3)
DSK                  DECIMAL(12,3)
SSK                  DECIMAL(11,3)
IDK                  DECIMAL(12,3)
ISK                  DECIMAL(11,3)
ADK                  DECIMAL(12,3)
DAT                  DATE
LAI                  TIME
NOL_TEX              STRING(40)
CN                   STRING(10)
PAR_NOS_P            STRING(45)
PAR_NOS_S            STRING(40)
PAR_u_Nr             ULONG

                     GROUP,PRE(SAV),BINDABLE
nomenklat              STRING(15)
mervien                STRING(7)
                     .

D_DAT                LONG               ! R��IN�M� DOK.DATUMS
DAUDZUMS             DECIMAL(12,3)
NSUMMA               DECIMAL(14,4)
VIRSRAKSTS           STRING(100)
Noliktava            STRING(60)
Atlikums_uz          STRING(12)
Atlikums_TEXT        STRING(9)
PARTIPS              LIKE(PAR:TIPS)

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

report REPORT,AT(140,2230,8000,8969),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS                          !Portretam optim�lais lapas garums 2230+8970=11200
       HEADER,AT(140,150,8000,2073),USE(?unnamed) !Nav Reports, visu skaita no lapas s�kuma
         STRING(@s45),AT(1979,104,4010,260),USE(CLIENT),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktava :'),AT(573,729,833,208),USE(?String2),LEFT,FONT(,9,,)
         STRING(@s60),AT(1719,740,4490,208),USE(NOLIKTAVA),TRN,LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(615,406,6719,260),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums:'),AT(573,990,1094,208),USE(?String2:3),LEFT,FONT(,9,,)
         STRING(@s50),AT(1719,990,4156,208),USE(NOM:NOS_P),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma PN2'),AT(6479,1406,625,156),USE(?String52)
         LINE,AT(104,1563,7708,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2031,1563,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3802,1563,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5417,1563,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7031,1563,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7813,1563,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('Datums'),AT(135,1677,521,208),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(740,1563,0,521),USE(?Line2:19),COLOR(COLOR:Black)
         STRING('Dokumenta'),AT(771,1615,1198,208),USE(?String12:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Partnera'),AT(2083,1615,1615,208),USE(?String12:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ien�cis'),AT(3854,1615,1458,208),USE(?String12:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izg�jis'),AT(5469,1615,1458,208),USE(?String12:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s9),AT(7083,1615,677,208),USE(Atlikums_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('T     Nr        Nosaukums'),AT(2094,1823,1615,208),USE(?String12:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums  Cena (bez PVN)'),AT(3833,1823,1563,208),USE(?String12:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums  Cena (bez PVN)'),AT(5448,1823,1563,208),USE(?String12:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(7083,1823,677,208),USE(?String12:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('s�rija un Numurs'),AT(781,1813,1198,208),USE(?String12:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,2031,7708,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(104,1563,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING('Nomenklat�ra:'),AT(573,1250,990,208),USE(?String2:4),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Kataloga Nr:'),AT(3542,1250,833,208),USE(?String2:5),LEFT,FONT(,9,,)
         STRING(@S21),AT(4427,1250,1667,208),USE(nom:kataloga_Nr),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(1719,1250,1667,208),USE(nomenklat),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7156,1406,,156),PAGENO,USE(?PageCount),RIGHT
       END
detail0 DETAIL,AT(,,,177),USE(?unnamed:2)
         STRING(@N-_12.3B),AT(3854,0,729,156),USE(DS1),RIGHT
         STRING(@N-_11.3B),AT(4635,0,729,156),USE(SS1),RIGHT
         STRING(@N-_12.3B),AT(5469,10,729,156),USE(ID1),RIGHT
         STRING(@N-_11.3B),AT(6250,0,729,156),USE(IS1),RIGHT
         LINE,AT(7031,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N-_12.3B),AT(7083,10,677,156),USE(AD1),RIGHT
         LINE,AT(7813,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(740,-10,0,198),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@s12),AT(781,0,990,156),USE(Atlikums_uz),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2031,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@d06.),AT(2188,10,635,156),USE(nol:datums)
         LINE,AT(3802,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@D06.b),AT(156,0,573,156),USE(nol:datums,,?nol:datums:2)
         LINE,AT(2031,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@s1),AT(2073,10,156,156),USE(PARTIPS),CENTER
         STRING(@N_6),AT(2229,10,417,156),USE(NOL:PAR_NR),RIGHT
         STRING(@s20),AT(2688,10,1094,156),USE(PAR_NOS_S),LEFT
         LINE,AT(3802,-10,0,198),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N-_12.3B),AT(3854,10,729,156),USE(DS0),RIGHT
         STRING(@N-_11.3B),AT(4635,10,729,156),USE(SS0),RIGHT
         LINE,AT(5417,-10,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@N-_12.3B),AT(5469,10,729,156),USE(ID0),RIGHT
         STRING(@N-_11.3B),AT(6250,10,729,156),USE(IS0),RIGHT
         LINE,AT(7031,-10,0,198),USE(?Line2:17),COLOR(COLOR:Black)
         STRING(@N-_12.3B),AT(7083,10,677,156),USE(AD0),RIGHT
         LINE,AT(7813,-10,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(740,-10,0,198),USE(?Line2:21),COLOR(COLOR:Black)
         STRING(@s14),AT(781,0,1198,156),USE(PAV:DOK_SENR),LEFT
       END
RPT_FOOT DETAIL,AT(,,,448),USE(?unnamed:3)
         STRING('RS :'),AT(1667,292,208,125),USE(?String45:2),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1875,292,104,125),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6781,292,573,125),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7385,292,458,125),USE(lai),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(104,-10,0,270),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(3802,-10,0,62),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,62),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,62),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,270),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(740,-10,0,62),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(2031,-10,0,62),USE(?Line24:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7708,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('KOP� / Vid�ji  no gada s�kuma :'),AT(156,104,2031,156),USE(?String12:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.3),AT(3854,104,729,156),USE(DSK),RIGHT
         STRING(@N-_11.3),AT(4635,104,729,156),USE(SSK),RIGHT
         STRING(@N-_12.3),AT(5469,104,729,156),USE(IDK),RIGHT
         STRING(@N-_11.3),AT(6250,104,729,156),USE(ISK),RIGHT
         STRING(@N-_12.3),AT(7083,104,677,156),USE(ADK),RIGHT
         LINE,AT(104,260,7708,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sast�d�ja :'),AT(208,292,490,125),USE(?String45),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(719,292,521,125),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(140,11200,8000,63)     !Nav Reports, visu skaita no lapas s�kuma
         LINE,AT(104,0,7760,0),USE(?Line32:2),COLOR(COLOR:Black)
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

!       FOOTER,AT(144,11400,8000,63)
!         LINE,AT(104,0,7708,0),USE(?Line1:5),COLOR(COLOR:Black)
!       END
  CODE                                            ! Begin processed code
!
! J�B�T POZICION�TAM NOM_K
!
!

  PUSHBIND

  DAT=TODAY()
  lai=CLOCK()
  IF ~(PAR_NR=999999999)
      PAR_NOS_P=GETPAR_K(PAR_NR,0,2)
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(PAVAD,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('NOMENKLAT',NOMENKLAT)
  BIND('CYCLENOL',CYCLENOL)
  BIND('CN',CN)
  BIND(NOL:RECORD)
  BIND(PAV:RECORD)

  FilesOpened = True
  RecordsToProcess =RECords(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Pre�u uzskaites karti�a'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='Pre�u un materi�lu daudzuma un summas uzskaites kart�te uz '&format(B_DAT,@D06.)
      Noliktava=clip(loc_nr)&' '&SYS:AVOTS
      IF F:DTK !F:DTK=7 D,K,P
         Atlikums_uz='Pieejams uz'
         Atlikums_TEXT='Pieejams'
         CN = 'N1220'
      ELSE
         Atlikums_uz='Atlikums uz'
         Atlikums_TEXT='Atlikums'
         CN = 'N1120'
      .

      CLEAR(nol:RECORD)
      nol:nomenklat=nomenklat
      SET(nol:NOM_key,nol:NOM_KEY)
      Process:View{Prop:Filter} = '~CYCLENOL(CN)'
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
          IF ~OPENANSI('KARTDRU.TXT')
              POST(Event:CloseWindow)
              CYCLE
          END
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=Noliktava
          ADD(OUTFILEANSI)
          OUTA:LINE='Nosaukums '&NOM:NOS_P
          ADD(OUTFILEANSI)
          OUTA:LINE='Nomenklat�ra '&NOM:NOMENKLAT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='Datums'&CHR(9)&'Dokumenta'&CHR(9)&'Partnera'&CHR(9)&'Ien�cis'&CHR(9)&CHR(9)&'Izg�jis'&|
             CHR(9)&CHR(9)&'Atlikums'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&'S�rija un Nr'&CHR(9)&'T,Nr,Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Cena bez PVN'&CHR(9)&|
             'Daudzums'&CHR(9)&'Cena bez PVN'&CHR(9)&'Daudzums'
             ADD(OUTFILEANSI)
          ELSE
             OUTA:LINE='Datums'&CHR(9)&'Dokumenta S�rija un Nr'&CHR(9)&'Partnera T,Nr,Nosaukums'&CHR(9)&'Ien�cis daudzums'&|
             CHR(9)&'Cena bez PVN'&CHR(9)&'Izg�jis daudzums'&CHR(9)&'Cena bez PVN'&CHR(9)&'Atlikums daudzums'
             ADD(OUTFILEANSI)
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        npk#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        IF NOL:PAR_NR=PAR_NR OR PAR_NR=999999999
           G#=GETPAVADZ(NOL:U_NR)
           IF NOL:DATUMS >= S_DAT AND ATLIK#
             atlik#=0
             ad1 = ad0
             SS1=SS1/DS1
             IS1=IS1/ID1
             IF F:DBF='W'
                 PRINT(RPT:DETAIL0)
             ELSE
                 OUTA:LINE='Atlikums uz'&CHR(9)&format(NOL:DATUMS,@d06.)&CHR(9)&CHR(9)&LEFT(format(DS1,@N-_12.3))&CHR(9)&|
                 LEFT(FORMAT(SS1,@N-_11.3))&CHR(9)&LEFT(FORMAT(ID1,@N-_12.3))&CHR(9)&LEFT(FORMAT(IS1,@N_11.3))&CHR(9)&|
                 LEFT(FORMAT(AD1,@N-_12.3))
                 ADD(OUTFILEANSI)
             .
           .
           CASE NOL:D_K
           OF 'D'
             ID0=0
             IS0=0
             IF NOL:DATUMS>=S_DAT
               DS0=NOL:DAUDZUMS
               SS0=CALCSUM(15,2)/nol:daudzums
             ELSE
               ATLIK#=1
               DS1+=NOL:DAUDZUMS
               SS1+=CALCSUM(15,2)
             .
             ad0+= nol:daudzums
             ssk+= CALCSUM(15,2)
             dsk+= nol:daudzums
           OF 'K'
           OROF 'P' !F:DTK=7, AR� PROJEKTI
             DS0=0
             SS0=0
             IF NOL:DATUMS>=S_DAT
               ID0=NOL:DAUDZUMS
               IS0=CALCSUM(15,2)/nol:daudzums
             ELSE
               ATLIK#=1
               ID1+=NOL:DAUDZUMS
               IS1+=CALCSUM(15,2)
             .
             ad0-= nol:daudzums
             isk+= CALCSUM(15,2)
             idk+= nol:daudzums
           .
           IF NOL:DATUMS>=S_DAT
             IF NOL:PAR_NR
                IF ~PAV:PAR_NR
                   PAR_NOS_S=GetPar_k(NOL:par_nr,2,25)  !Visdr�z�k no kases...
                   PARTIPS=PAR:TIPS
                ELSIF ~(NOL:PAR_NR=PAV:PAR_NR)
                   KLUDA(27,'Partnera Nr P/Z saturam '&CLIP(PAV:DOK_SENR)&' '&FORMAT(PAV:DATUMS,@D06.))
                   PAR_NOS_S=PAV:NOKA
                   PARTIPS='E'
                ELSE
                   PAR_NOS_S=GetPar_k(NOL:par_nr,2,1)
                   PARTIPS=PAR:TIPS
                .
             ELSE
                PAR_NOS_S=PAV:NOKA
                PARTIPS='E'
             .
             IF PAV:MAK_NR THEN PAR_NOS_S=CLIP(PAR_NOS_S)&'/'&getpar_k(pav:MAK_NR,0,1).
             IF ATLAUTS[11]='1' THEN SS0=0. !AIZLIEGTS APSKAT�T D P/Z UN JEBKURU PIEEJU IEP CEN�M
             IF F:DBF='W'
                 PRINT(RPT:DETAIL)
             ELSE
                 OUTA:LINE=format(NOL:DATUMS,@d06.)&CHR(9)&PAV:DOK_SENR&CHR(9)&PARTIPS&','&NOL:PAR_NR&|
                 ','&PAR_NOS_S&CHR(9)&LEFT(format(DS0,@N-_12.3))&CHR(9)&LEFT(FORMAT(SS0,@N-_12.3))&CHR(9)&|
                 LEFT(FORMAT(ID0,@N-_12.3))&CHR(9)&LEFT(FORMAT(IS0,@N_12.3))&CHR(9)&LEFT(FORMAT(AD0,@N-_12.3))
                 ADD(OUTFILEANSI)
             .
           .
        .
        LOOP
          RW#+=1
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
    adk = ad0
    SSK=SSK/DSK
    isk=ISK/IDK
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT)
        ENDPAGE(report)
    ELSE
        OUTA:LINE='KOP�/Vid�ji no gada s�kuma:'&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DSk,@N-_12.3))&CHR(9)&|
        LEFT(FORMAT(SSk,@N-_12.3))&CHR(9)&LEFT(FORMAT(IDk,@N-_12.3))&CHR(9)&LEFT(FORMAT(ISk,@N_12.3))&CHR(9)&|
        LEFT(FORMAT(ADk,@N-_12.3))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Sast�d�ja: '&ACC_KODS&' '&FORMAT(dat,@D06.)&' '&FORMAT(LAI,@T4)
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
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'. !PAGAID�M
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
  IF ERRORCODE() OR ~(NOL:nomenklat=nomenklat)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Izpild�ti'
      DISPLAY()
    END
  END


