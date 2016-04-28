                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_IEKOP              PROCEDURE                    ! Declare Procedure
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
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:PAR_NR)
                     END
!------------------------------------------------------------------------

DOK_SENR             STRING(14)
RPT_NPK              DECIMAL(4)
KOPA                 STRING(6)
SUMMAPK              DECIMAL(12,2)
NOSK                 STRING(3)
DAT                  DATE
LAI                  TIME
PAR_NOS_P            STRING(96) !NOS_S+ADRESE / PAV:PAMAT(S25)
NOLIKTAVA_TEXT       STRING(30)
V1                   STRING(1)
V2                   STRING(1)
CN                   STRING(10)
CP                   STRING(3)
VIRSRAKSTS           STRING(110)
FILTRS_TEXT          STRING(100)
PARADS_TEXT          STRING(50)
TAB_4_TEXT           STRING(12)
PAV_PAMAT            STRING(40)

K_TABLE              QUEUE,PRE(K)
NOS                    STRING(3)
SUMMAK                 DECIMAL(12,2)
                     .

!--------------------------------------------------------------------
report REPORT,AT(500,2010,8000,9000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(500,302,8000,1708),USE(?unnamed)
         LINE,AT(104,1667,6979,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Parâda summa'),AT(5760,1354,1302,208),USE(?String15:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(115,885,7042,167),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(1729,677,3833,146),USE(PARADS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1198,6979,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(573,1198,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1458,1198,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(2240,1198,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4948,1198,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5729,1198,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7083,1198,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('NPK'),AT(135,1354,417,208),USE(?String15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòemðanas'),AT(604,1250,833,208),USE(?String15:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(1490,1250,729,208),USE(?String15:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s12),AT(2344,1354,1802,208),USE(TAB_4_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Norçíinu'),AT(4979,1250,729,208),USE(?String15:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(604,1458,833,208),USE(?String15:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(1490,1458,729,208),USE(?String15:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(4979,1458,729,208),USE(?String15:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1198,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@P<<<#. lapaP),AT(6417,1031,625,156),PAGENO,USE(?PageCount),RIGHT(1)
         STRING(@s45),AT(1479,104,4375,260),USE(Client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(2229,313,2865,208),USE(NOLIKTAVA_TEXT),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@S100),AT(-52,521,7458,156),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line10),COLOR(COLOR:Black)
         STRING(@N4),AT(156,10,365,156),USE(RPT_NPK),RIGHT
         LINE,AT(573,-10,0,198),USE(?Line10:2),COLOR(COLOR:Black)
         STRING(@D06.),AT(625,10,729,156),USE(PAV:DATUMS),RIGHT
         LINE,AT(1458,-10,0,198),USE(?Line10:3),COLOR(COLOR:Black)
         STRING(@S14),AT(1510,10,677,156),USE(DOK_SENR),RIGHT
         LINE,AT(2240,-10,0,198),USE(?Line10:4),COLOR(COLOR:Black)
         STRING(@s40),AT(2302,10,2604,156),USE(PAV_PAMAT),LEFT
         LINE,AT(4948,-10,0,198),USE(?Line10:5),COLOR(COLOR:Black)
         STRING(@D06.),AT(5000,10,625,156),USE(PAV:C_DATUMS),RIGHT
         LINE,AT(5729,-10,0,198),USE(?Line10:6),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5781,10,885,156),USE(PAV:C_SUMMA),RIGHT
         STRING(@s3),AT(6719,10,281,156),USE(PAV:VAL),LEFT
         LINE,AT(7083,-10,0,198),USE(?Line10:7),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(104,-10,0,115),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(1458,-10,0,63),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(2240,-10,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(104,52,6979,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,115),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,115),USE(?Line23),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(5729,-10,0,198),USE(?Line10:9),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5781,10,885,156),USE(SUMMAPK),RIGHT
         STRING(@s3),AT(6719,10,281,156),USE(NOSK),LEFT
         LINE,AT(7083,-10,0,198),USE(?Line10:10),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line10:8),COLOR(COLOR:Black)
         STRING(@s6),AT(156,10,500,156),USE(KOPA),LEFT
       END
RPT_FOOT3 DETAIL,AT(,,,250),USE(?unnamed:2)
         LINE,AT(104,-10,0,63),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,63),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,63),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(104,52,6979,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(125,83,469,146),USE(?String34),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(594,83,573,146),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1427,83,208,146),USE(?String36),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1688,83,156,146),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6031,83,625,146),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(6625,83),USE(lai),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(500,11000,8000,63)
         LINE,AT(104,0,6979,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!
!  V/K tikai, kur pav:c_datums inrange s_dat,b_dat
!
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  BIND('D_K',D_K)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('V1',V1)  !pçcapmaksa
  BIND('V2',V2)  !realizâcijai
  BIND('CYCLENOL',CYCLENOL)
  BIND('CYCLEPAR_K',CYCLEPAR_K)

  KOPA='Kopâ :'
  DAT = TODAY()
  LAI = CLOCK()
  D_K = 'D'
  V1 = '2'
  V2 = '3'
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  BIND(PAR:RECORD)
  BIND(NOL:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Pçcapmaksas/realizâcijas P/Z'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      NOLIKTAVA_TEXT='Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      VIRSRAKSTS='Jânorçíinâs par D pçcapmaksas/realiz. P/Z periodâ: '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
      PARADS_TEXT=GETFILTRS_TEXT('000000010')
      CLEAR(PAV:RECORD)
!      PAV:DATUMS=S_DAT VAJAG NO GADA SÂKUMA
      PAV:D_K='D'
      IF PAR_NR = 999999999 !VISI
         CN = 'P11011'
         CP = 'P11'
         FILTRS_TEXT=GETFILTRS_TEXT('101100000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         TAB_4_TEXT='Piegâdâtâjs'
         SET(PAV:DAT_KEY,PAV:DAT_KEY)
!         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLEPAR_K(CP)'
         Process:View{Prop:Filter} = '(PAV:APM_V=V1 OR PAV:APM_V=V2) AND ~CYCLENOL(CN) AND ~CYCLEPAR_K(CP) AND '&|
         'INRANGE(PAV:C_DATUMS,S_DAT,B_DAT)'
      ELSE                  !KONKRÇTS
         CN = 'P10011'
         FILTRS_TEXT=GETFILTRS_TEXT('100000000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Piegâdâtâjs: '&CLIP(GETPAR_K(PAR_NR,2,2))&' '&GETPAR_K(PAR_NR,0,24)
!         FILTRS_TEXT='Piegâdâtâjs: '&CLIP(GETPAR_K(PAR_NR,0,1))&' '&GETPAR_K(PAR_NR,0,24)
         TAB_4_TEXT='Pamatojums'
         PAV:PAR_NR=PAR_NR
         SET(PAV:PAR_KEY,PAV:PAR_KEY)
!         Process:View{Prop:Filter} ='~CYCLENOL(CN)'
         Process:View{Prop:Filter} = '(PAV:APM_V=V1 OR PAV:APM_V=V2) AND ~CYCLENOL(CN) AND '&|
         'INRANGE(PAV:C_DATUMS,S_DAT,B_DAT)'
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
          IF ~OPENANSI('IEKOP.TXT')
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
          IF F:DBF='E'
             OUTA:LINE='Npk'&CHR(9)&'Saòemðanas'&CHR(9)&'Dokumenta'&CHR(9)&'Pamatojums'&CHR(9)&'Norçíinu'&CHR(9)&|
             'Parâda summa'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&'datums'&CHR(9)&'numurs'&CHR(9)&CHR(9)&'datums'
             ADD(OUTFILEANSI)
          ELSE  |WORD
             OUTA:LINE='Npk'&CHR(9)&'Saòemðanas datums'&CHR(9)&'Dokumenta numurs'&CHR(9)&'Pamatojums'&CHR(9)&|
             'Norçíinu datums'&CHR(9)&'Parâda summa'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF F:ATL[2]='1' OR PAV:C_summa !ATL[2]-DRUKÂT ARÎ 0
           RPT_NPK+=1
           ?Progress:UserString{Prop:Text}=rpt_npk
           DISPLAY(?Progress:UserString)
           DOK_SENR=PAV:DOK_SENR
           IF PAR_NR = 999999999 !VISI
              IF PAV:PAR_ADR_NR
                 PAV_PAMAT=CLIP(GETPAR_K(PAV:PAR_NR,2,1))&','&GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
              ELSE
                 PAV_PAMAT=CLIP(GETPAR_K(PAV:PAR_NR,2,1))&','&GETPAR_K(PAV:PAR_NR,2,24)
              .
           ELSE
              PAV_PAMAT=PAV:PAMAT
           .
           IF ~F:DTK
               IF F:DBF='W'
                   PRINT(RPT:DETAIL)
               ELSE
                   OUTA:LINE=RPT_NPK&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&DOK_SENR&CHR(9)&PAV:PAMAT&CHR(9)&|
                   FORMAT(PAV:C_DATUMS,@D06.)&CHR(9)&LEFT(FORMAT(PAV:C_SUMMA,@N-_13.2))&CHR(9)&PAV:VAL
                   ADD(OUTFILEANSI)
               END
           END
           GET(K_TABLE,0)
           K:NOS=PAV:VAL
           GET(K_TABLE,K:NOS)
           IF ERROR()
             K:NOS=PAV:VAL
             K:SUMMAK= PAV:C_summa
             ADD(K_TABLE)
             SORT(K_TABLE,K:NOS)
           ELSE
             K:SUMMAK+= PAV:C_summa
             PUT(K_TABLE)
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
!***********************DRUKÂJAM PA VALÛTÂM
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    ELSE
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
    END
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      IF F:ATL[2]='1' OR K:SUMMAK
        SUMMAPK =K:SUMMAK
        NOSK=K:NOS
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMAPK,@N-_13.2))&CHR(9)&NOSK
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
  ELSE           !RTF,EXCEL
     CLOSE(OUTFILEANSI)
     ANSIFILENAME=''
  .
  DO ProcedureReturn

!|----------------------------------------------------------------------------------------
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
  POPBIND
  IF F:DBF='E' THEN F:DBF='W'.
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
     IF ERRORCODE() OR ~(PAV:PAR_NR=PAR_NR) THEN VISS#=TRUE.
  ELSE
     PREVIOUS(Process:View)
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
N_IZGMAT             PROCEDURE                    ! Declare Procedure
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

SUMMA_B                 DECIMAL(12,2)
SUMMA_BK                DECIMAL(12,2)
SUMMA_PVN               DECIMAL(12,2)
SUMMA_PVNK              DECIMAL(12,2)
SUMMA_P                 DECIMAL(14,2)
SUMMA_PK                DECIMAL(14,2)
ITOGO                   DECIMAL(14,2)
ITOGOK                  DECIMAL(14,2)
TRANSK                  DECIMAL(10,2)
NPK                     DECIMAL(4)
DAUDZUMSK               DECIMAL(14,3)
KOPA                    STRING(5)
TIPS                    STRING(15)
VALK                    STRING(3)
PARKOP                  DECIMAL(12,2)
DAT                     LONG
LAI                     LONG

CN                      STRING(10)
CP                      STRING(10)


K_TABLE                 QUEUE,PRE(K)
VAL                        STRING(3)
SUMMA_P                    DECIMAL(14,2)
                        .

T_TABLE                 QUEUE,PRE(T)
TIPS                       STRING(1)
DAUDZUMS                   DECIMAL(12,3)
SUMMA_P                    DECIMAL(14,2)
                        .

N_TABLE              QUEUE,PRE(N)
KEY                     STRING(26) !5+21
U_NR                    ULONG
DAUDZUMS                DECIMAL(12,3)
SUMMA_B                 DECIMAL(12,2)
SUMMA_PVN               DECIMAL(11,2)
SUMMA_P                 DECIMAL(14,2)
VAL                     STRING(3)
T_SUMMA                 DECIMAL(9,2)
                     .

NOM_NOSAUKUMS           STRING(35)
N_DATUMS                LONG
N_NOMENKLAT             LIKE(NOL:NOMENKLAT)
SAV_NOMENKLAT           LIKE(NOL:NOMENKLAT)
SAV_U_NR                LIKE(NOL:U_NR)
MER                     STRING(7)
NOM_KAT                 STRING(17)
SECIBA                  STRING(30)

VIRSRAKSTS              STRING(110)
FILTRS_TEXT             STRING(100)
DAU_PAP_MER             DECIMAL(12,3)
PUNKTI                  DECIMAL(12,3)
DAU_PAP_MERK            DECIMAL(12,3)
PUNKTIK                 DECIMAL(12,3)
DAUDZUMS_R              DECIMAL(12,3)
SUMMA_R                 DECIMAL(12,2)
SUMMA_RB                DECIMAL(12,2)
NOM_MERVIENIBA          STRING(7)
SAN_DOK_TEXT            STRING(15)
SAN_DOK                 STRING(15)

!--------------------------------------------------------------------------
!    A4 LANDSCAPE REPORTA Y+H OPTIMÂLAIS=8000
!    REPORTA Y= HEADERA Y+H
!    FOOTERA Y= REPORTA Y+H
report REPORT,AT(250,1720,11500,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS                !1720=500+1220
       HEADER,AT(250,500,11500,1219),USE(?unnamed)
         STRING(@s100),AT(1531,510,7521,208),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IZ1'),AT(10000,375,646,156),USE(?String14),RIGHT(1),FONT(,8,,)
         STRING(@P<<<#. lapaP),AT(10073,521,573,156),PAGENO,USE(?PageCount),RIGHT(1),FONT(,8,,)
         LINE,AT(52,729,11042,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(417,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1458,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(2135,938,0,292),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('NPK'),AT(104,885,313,208),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(448,885,990,208),USE(SAN_DOK_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(1615,781,1927,156),USE(SECIBA),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7031,729,0,521),USE(?Line2:13),COLOR(COLOR:Black)
         STRING('Datums'),AT(1510,958,625,208),USE(?String17:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(2188,990,1563,208),USE(?String17:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(3854,885,1875,208),USE(?String17:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(5823,885,677,208),USE(?String17:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, '),AT(7906,792,573,208),USE(?String17:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7917,990,573,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pçc pavadzîmes'),AT(8563,781,990,208),USE(?String17:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(7104,781,729,208),USE(?String17:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Transports'),AT(9646,781,625,208),USE(?String17:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçrv.'),AT(6615,885,365,208),USE(?String17:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ, '),AT(10385,781,677,208),USE(?String17:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(10396,979,677,208),USE(val_uzsk,,?val_uzsk:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1458,938,2292,0),USE(?Line56),COLOR(COLOR:Black)
         STRING('bez PVN, '),AT(7052,990,521,208),USE(?String17:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7542,990,313,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(8563,990,990,208),USE(?String17:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(P/Z, val.)'),AT(9646,990,625,208),USE(?String17:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1198,11042,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(3750,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5781,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6510,729,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(7865,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(8521,729,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(9583,729,0,521),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(10313,729,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(11094,729,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(52,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(3042,42,4479,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s110),AT(1198,292,8198,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(52,-10,0,198),USE(?Line11),COLOR(COLOR:Black)
         STRING(@n_4),AT(104,10,260,156),USE(npk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(417,-10,0,198),USE(?Line11:2),COLOR(COLOR:Black)
         STRING(@s15),AT(458,10,990,156),USE(SAN_DOK),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(1458,-10,0,198),USE(?Line11:3),COLOR(COLOR:Black)
         STRING(@D06.),AT(1510,10,573,156),USE(N_DATUMS),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(2135,-10,0,198),USE(?Line11:4),COLOR(COLOR:Black)
         STRING(@S21),AT(2188,10,1563,156),USE(N_NOMENKLAT),LEFT(1),FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3750,-10,0,198),USE(?Line11:5),COLOR(COLOR:Black)
         STRING(@s35),AT(3802,10,1979,156),USE(NOM_NOSAUKUMS),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.2),AT(10333,10,729,156),USE(ITOGO),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s7),AT(6563,10,469,156),USE(NOM_MERVIENIBA),TRN,LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7031,-10,0,198),USE(?Line11:13),COLOR(COLOR:Black)
         LINE,AT(10313,-10,0,198),USE(?Line11:11),COLOR(COLOR:Black)
         STRING(@n-_10.2),AT(7917,10,573,156),USE(N:SUMMA_Pvn),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5781,-10,0,198),USE(?Line11:6),COLOR(COLOR:Black)
         STRING(@n-_12.3),AT(5833,10,625,156),USE(N:DAUDZUMS),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7865,-10,0,198),USE(?Line11:7),COLOR(COLOR:Black)
         LINE,AT(9583,-10,0,198),USE(?Line11:12),COLOR(COLOR:Black)
         STRING(@n-_10.2),AT(9688,10,573,156),USE(N:T_SUMMA),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_12.2),AT(7083,10,729,156),USE(N:SUMMA_B),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6510,-10,0,198),USE(?Line11:10),COLOR(COLOR:Black)
         LINE,AT(8521,-10,0,198),USE(?Line11:8),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(8542,10,729,156),USE(N:SUMMA_P),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(9323,10,260,156),USE(N:VAL),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(11094,-10,0,198),USE(?Line11:9),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(52,0,0,114),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(52,52,11042,0),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(6510,0,0,114),USE(?Line28:3),COLOR(COLOR:Black)
         LINE,AT(7031,0,0,114),USE(?Line28:7),COLOR(COLOR:Black)
         LINE,AT(8521,0,0,114),USE(?Line28:4),COLOR(COLOR:Black)
         LINE,AT(9583,0,0,114),USE(?Line28:6),COLOR(COLOR:Black)
         LINE,AT(10313,0,0,114),USE(?Line28:5),COLOR(COLOR:Black)
         LINE,AT(11094,0,0,114),USE(?Line28:2),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,114),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(5781,0,0,63),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(3750,0,0,63),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(2135,0,0,63),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(1458,0,0,63),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(417,0,0,63),USE(?Line23),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(7865,-10,0,198),USE(?Line21:3),COLOR(COLOR:Black)
         LINE,AT(11094,-10,0,198),USE(?Line21:4),COLOR(COLOR:Black)
         STRING(@n-_14.3b),AT(5469,10,990,156),USE(DAUDZUMSk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_12.2B),AT(7083,10,729,156),USE(SUMMA_BK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_10.2B),AT(7917,10,573,156),USE(SUMMA_PvnK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_10.2B),AT(9688,10,573,156),USE(TRANSK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.2B),AT(10333,10,729,156),USE(ITOGOK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s15),AT(1406,10,1146,156),USE(TIPS),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6510,-10,0,198),USE(?Line21:8),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,198),USE(?Line21:9),COLOR(COLOR:Black)
         LINE,AT(10313,-10,0,198),USE(?Line21:6),COLOR(COLOR:Black)
         LINE,AT(9583,-10,0,198),USE(?Line21:7),COLOR(COLOR:Black)
         LINE,AT(8521,-10,0,198),USE(?Line21:5),COLOR(COLOR:Black)
         STRING(@n-_14.2B),AT(8542,10,729,156),USE(SUMMA_PK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(9313,10,260,156),USE(VALK),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s15),AT(260,10,1094,156),USE(KOPA),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(52,-10,0,198),USE(?Line21:2),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,240),USE(?unnamed:3)
         LINE,AT(52,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,63),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(11094,-10,0,63),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,63),USE(?Line35:2),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,63),USE(?Line35:3),COLOR(COLOR:Black)
         LINE,AT(52,52,11042,0),USE(?Line22:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(313,83,500,167),USE(?String50),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(823,83,458,167),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1615,83,260,167),USE(?String52),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1844,83),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(10083,83,521,167),USE(dat),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(10656,83,417,167),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(9583,-10,0,63),USE(?Line235),COLOR(COLOR:Black)
         LINE,AT(10313,-10,0,63),USE(?Line335),COLOR(COLOR:Black)
         LINE,AT(8521,-10,0,63),USE(?Line535),COLOR(COLOR:Black)
       END
       FOOTER,AT(250,7980,11500,63),USE(?unnamed:2) !8020=1720+6300
         LINE,AT(52,0,11042,0),USE(?Line22:3),COLOR(COLOR:Black)
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
!
!****************REALIZÇTS V/K
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)

  KOPA='t.s.  '
  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAVAD::Used = 0        !DÇÏ GETPAVAD
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1          
  IF NOM_K::Used = 0        !DÇÏ GETNOM_K
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1          
  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  IF VAL_K::Used = 0        !DÇÏ BANKURS
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  IF KURSI_K::Used = 0      !DÇÏ BANKURS
    CheckOpen(KURSI_K,1)
  END
  KURSI_K::Used += 1
  IF NOLIK::Used = 0        !DÇÏ VIEWA
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
  ProgressWindow{Prop:Text} = 'Izgâjuðâs preces'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='Izziòa izgâjuðâm ('&D_K&') precçm no '&format(S_DAT,@d06.)&' lîdz '&format(B_DAT,@d06.)&|
      ' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      IF PAR_NR = 999999999 !VISI
         FILTRS_TEXT=GETFILTRS_TEXT('111111100') !1-OB,2-NOD,3-PT,4-PG,5-NOM,6-NT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         SAN_DOK_TEXT='Saòçmçjs'
      ELSE
         FILTRS_TEXT=GETFILTRS_TEXT('110011100') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Saòçmçjs:'&CLIP(GETPAR_K(PAR_NR,2,2))&' '&GETPAR_ADRESE(PAR_NR,ADR_NR,0,0)
         SAN_DOK_TEXT='Dokumenta Nr'
      .
      CP = 'N11'
      CLEAR(nol:RECORD)
      IF ~(PAR_NR = 999999999) !KONKRÇTS PARTNERIS
         CN = 'N1011111'  !N/P,RS,DK,SB_DAT,D_K,OBJ,NOD,ADR_NR
         !     12345678
         NOL:PAR_NR = PAR_NR
         NOL:DATUMS = s_dat
         NOL:D_K = D_K
         SET(nol:PAR_KEY,NOL:PAR_KEY)
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT)'
      ELSE !VISI
         CP = 'N11'
         CN = 'N101111'
         !     1234567
         IF F:SECIBA='N'
            NOL:NOMENKLAT=NOMENKLAT
            SET(nol:NOM_KEY,nol:NOM_KEY)
         ELSE
            NOL:DATUMS = s_dat
            NOL:D_K = D_K
            SET(nol:DAT_KEY,nol:DAT_KEY)
            Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT) AND ~CYCLEPAR_K(CP)'
         .
      .
      IF F:SECIBA='N'    !VIENALGA VISU RAKSTÎS TABULÂ...
         SECIBA='Secîba:Nomenklat-Datums'
      ELSE
         SECIBA='Secîba:Datums-Nomenklat'
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
      ELSE
          IF ~OPENANSI('IZGMAT.TXT')
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
          OUTA:LINE=seciba
          ADD(OUTFILEANSI)
          IF F:DBF='E'
!             OUTA:LINE='Npk'&CHR(9)&SAN_DOK_TEXT&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&'Kataloga Numurs'&|
!             CHR(9)&'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez'&CHR(9)&'PVN,Ls'&CHR(9)&'Pçc pavadzîmes'&|
!             CHR(9)&CHR(9)&'Transports'&CHR(9)&'Kopâ, Ls'&CHR(9)&'Daudzums pap.m'&CHR(9)&'Punkti'
             OUTA:LINE='Npk'&CHR(9)&SAN_DOK_TEXT&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&'Kataloga Numurs'&|
             CHR(9)&'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez'&CHR(9)&'PVN,'&val_uzsk&CHR(9)&'Pçc pavadzîmes'&|
             CHR(9)&CHR(9)&'Transports'&CHR(9)&'Kopâ, '&val_uzsk&CHR(9)&'Daudzums pap.m'&CHR(9)&'Punkti'
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PVN,Ls'&CHR(9)&CHR(9)&'ar PVN, valûtâ'&CHR(9)&|
!             CHR(9)&'(P/Z,val.)'
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PVN,'&val_uzsk&CHR(9)&CHR(9)&'ar PVN, valûtâ'&CHR(9)&|
             CHR(9)&'(P/Z,val.)'
             ADD(OUTFILEANSI)
          ELSE
!             OUTA:LINE='Npk'&CHR(9)&SAN_DOK_TEXT&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&'Kataloga Numurs'&|
!             CHR(9)&'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez PVN,Ls'&CHR(9)&'PVN,Ls'&CHR(9)&|
!             'Pçc pavadzîmes ar PVN,valûtâ'&CHR(9)&CHR(9)&'Transports (P/Z,val.)'&CHR(9)&'Kopâ, Ls'&CHR(9)&'Daudzums pap.m'&CHR(9)&'Punkti'
             OUTA:LINE='Npk'&CHR(9)&SAN_DOK_TEXT&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&'Kataloga Numurs'&|
             CHR(9)&'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez PVN,'&val_uzsk&CHR(9)&'PVN,'&val_uzsk&CHR(9)&|
             'Pçc pavadzîmes ar PVN,valûtâ'&CHR(9)&CHR(9)&'Transports (P/Z,val.)'&CHR(9)&'Kopâ, '&val_uzsk&CHR(9)&'Daudzums pap.m'&CHR(9)&'Punkti'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        npk#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT) AND ~CYCLEPAR_K(CP) AND|                                 !?
           ~((F:DIENA='N' AND ~BAND(NOL:BAITS,00000100b)) OR (F:DIENA='D' AND BAND(NOL:BAITS,00000100b))) AND| !?
           (NOM_TIPS7='PTAKRIV' OR INSTRING(GETNOM_K(NOL:NOMENKLAT,0,16),NOM_TIPS7))                           !?
           IF F:SECIBA='N'              !NOMENKLATÛRU SECÎBA
              N:KEY[1:21]=NOL:NOMENKLAT
              N:KEY[22:26]=NOL:DATUMS
           ELSE
              N:KEY[1:5]=NOL:DATUMS
              N:KEY[6:26]=NOL:NOMENKLAT
           .
           N:U_NR     =NOL:U_NR
           N:DAUDZUMS =NOL:DAUDZUMS
           N:SUMMA_B  =calcsum(15,2)        ! Ls
           N:SUMMA_P  =CALCSUM(4,2)         ! VALÛTÂ AR PVN
           N:SUMMA_PVN=CALCSUM(17,2)        ! Ls
           N:VAL      =NOL:VAL
           N:T_SUMMA  =NOL:T_SUMMA
           ADD(N_TABLE)

           K:VAL=NOL:VAL
           GET(K_TABLE,K:VAL)
           IF ERROR()
             K:VAL=NOL:VAL
             K:SUMMA_P = CALCSUM(4,2)
             ADD(K_TABLE,K:VAL)
             SORT(K_TABLE,K:VAL)
           ELSE
             K:SUMMA_P += CALCSUM(4,2)
             PUT(K_TABLE)
           .
           IF NOL:DAUDZUMS<0  !ATGRIEZTA PRECE
             DAUDZUMS_R += NOL:DAUDZUMS
             SUMMA_R    += CALCSUM(15,2)+CALCSUM(17,2)
             SUMMA_RB   += CALCSUM(15,2)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     SORT(N_TABLE,N:KEY)
     LOOP I#=1 TO RECORDS(N_TABLE)
        GET(N_TABLE,I#)
        npk+=1
        IF F:SECIBA='N'              !NOMENKLATÛRU SECÎBA
           N_NOMENKLAT=N:KEY[1:21]
           N_DATUMS   =N:KEY[22:26]
        ELSE
           N_NOMENKLAT=N:KEY[6:26]
           N_DATUMS   =N:KEY[1:5]
        .
        IF ~(SAV_U_NR=N:U_NR)
           G#=GETPAVADZ(N:U_NR)                        !POZICIONÇ PAVADZÎMES
           SAV_U_NR=N:U_NR
        .
!        IF F:OBJ_NR AND ~(F:OBJ_NR=PAV:OBJ_NR) THEN CYCLE.               !F pçc objekta
!        IF F:NODALA AND ~(PAV:NODALA=F:NODALA OR (PAV:NODALA[1]=F:NODALA[1] AND F:NODALA[2]='') OR|
!           (PAV:NODALA[2]=F:NODALA[2] AND F:NODALA[1]='')) THEN CYCLE.   !F PÇC NODAÏAS
        IF ~(SAV_NOMENKLAT=N_NOMENKLAT)
           IF CL_NR=1493  !RÎGAS BÛVMATERIÂLI
              NOM_NOSAUKUMS=GETNOM_K(N_NOMENKLAT,2,3) !NOS_S
           ELSE
              NOM_NOSAUKUMS=GETNOM_K(N_NOMENKLAT,2,2) !NOSAUKUMS
           .
           NOM_KAT = NOM:KATALOGA_NR
           NOM_MERVIENIBA=NOM:MERVIEN
           SAV_NOMENKLAT=N_NOMENKLAT
           DAU_PAP_MER=N:DAUDZUMS*NOM:KOEF_ESKNPM
           PUNKTI=N:DAUDZUMS*NOM:PUNKTI
        .
!*******SADALAM PÇC NOM:TIPS PTAKRI*********************************
        T:TIPS=NOM:TIPS
        GET(T_TABLE,T:TIPS)
        IF ERROR()
          T:TIPS=NOM:TIPS
          T:DAUDZUMS = N:DAUDZUMS
          T:SUMMA_P  = N:SUMMA_B+N:SUMMA_PVN
          ADD(T_TABLE)
          SORT(T_TABLE,T:TIPS)
        ELSE
          T:DAUDZUMS += N:DAUDZUMS
          T:SUMMA_P  += N:SUMMA_B+N:SUMMA_PVN
          PUT(T_TABLE)
        .
!*******************************************************
        IF ~(PAR_NR = 999999999) !KONKRÇTS PARTNERIS
           SAN_DOK=PAV:DOK_SENR
        ELSE
           SAN_DOK=PAV:NOKA
        .
        ITOGO = N:SUMMA_B + N:SUMMA_PVN + N:T_SUMMA*BANKURS(N:VAL,N_DATUMS)  !LS
        DAUDZUMSK   += N:DAUDZUMS            ! SKAITA KOPÂ DAUDZUMUS, ANYWAY
        SUMMA_BK    += N:SUMMA_B             ! BEZ PVN LS
        SUMMA_PVNK  += N:SUMMA_PVN           ! PVN LS
        SUMMA_PK    += N:SUMMA_B+N:SUMMA_PVN ! AR PVN LS
        TRANSK      += N:T_SUMMA*BANKURS(N:VAL,N_DATUMS)  ! Ls
        ITOGOK      += ITOGO                 ! Ls
        DAU_PAP_MERK+= DAU_PAP_MER
        PUNKTIK     += PUNKTI
        IF ~F:DTK
          IF F:DBF='W'
             PRINT(RPT:DETAIL)
          ELSE
             OUTA:LINE=Npk&CHR(9)&SAN_DOK&CHR(9)&FORMAT(N_DATUMS,@D06.)&CHR(9)&N_NOMENKLAT&CHR(9)&NOM_KAT&CHR(0)&CHR(9)&|
             NOM_NOSAUKUMS&CHR(9)&LEFT(FORMAT(N:DAUDZUMS,@N-_14.3))&CHR(9)&LEFT(FORMAT(N:SUMMA_B,@N-_12.2))&CHR(9)&|
             LEFT(FORMAT(N:SUMMA_PVN,@N-_10.2))&CHR(9)&LEFT(FORMAT(N:SUMMA_P,@N-_14.2))&CHR(9)&N:VAL&CHR(9)&|
             LEFT(FORMAT(N:T_SUMMA,@N-_10.2))&CHR(9)&LEFT(FORMAT(ITOGO,@N-_14.2))&CHR(9)&|
             LEFT(FORMAT(DAU_PAP_MER,@N-_12.3))&CHR(9)&LEFT(FORMAT(PUNKTI,@N-_12.3))
             ADD(OUTFILEANSI)
          .
        .
     .
     FREE(N_TABLE)
     IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
     .
 !****************************DRUKÂJAM KOPÂ Ls**************
     KOPA='Kopâ:'
     !VALK = 'Ls'
     VALK = val_uzsk
     IF F:DBF='W'
         PRINT(RPT:RPT_FOOT2)
     ELSE
         OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&|
         LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_10.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_14.2))&|
         CHR(9)&VALK&CHR(9)&LEFT(FORMAT(TRANSK,@N-_10.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))&CHR(9)&|
         LEFT(FORMAT(DAU_PAP_MERK,@N-_12.3))&CHR(9)&LEFT(FORMAT(PUNKTIK,@N-_12.3))
         ADD(OUTFILEANSI)
     END
 !****************************DRUKÂJAM PÇC valûtâm **************
     DAUDZUMSK  = 0
     SUMMA_BK   = 0
     SUMMA_PVNK = 0
     SUMMA_PK   = 0
     TRANSK     = 0
     ITOGOK     = 0
     KOPA='t.s.'
     LOOP J# = 1 TO RECORDS(K_TABLE)
       GET(K_TABLE,J#)
       !IF RECORDS(K_TABLE)=1 AND (K:VAL='Ls' OR K:VAL='LVL') THEN BREAK.
       IF RECORDS(K_TABLE)=1 AND (((K:VAL='Ls' OR K:VAL='LVL') AND GL:DB_GADS <= 2013) OR (GL:DB_GADS > 2013 AND K:VAL=val_uzsk)) THEN BREAK.

       IF K:SUMMA_P
         SUMMA_PK = K:SUMMA_P
         VALK     = K:VAL
         IF F:DBF='W'
             PRINT(RPT:RPT_FOOT2)                      !PRINT GRAND TOTALS
         ELSIF F:DBF='E'
             OUTA:LINE=KOPA&' {103}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(SUMMA_PK,@N-_14.2)&CHR(9)&VALK
             ADD(OUTFILEANSI)
         ELSE
             OUTA:LINE=KOPA&' {103}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(SUMMA_PK,@N-_14.2)&CHR(9)&VALK
             ADD(OUTFILEANSI)
         END
         KOPA=''
       .
     .
 !****************************DRUKÂJAM PÇC NOM:TIPA **************
     IF RECORDS(K_TABLE) >1
        DAUDZUMSK  = 0
        SUMMA_BK   = 0
        SUMMA_PVNK = 0
        SUMMA_PK   = 0
        TRANSK     = 0
        SUMMA_PK   = 0
        VALK       = ''
        KOPA='t.s.'
        LOOP J# = 1 TO RECORDS(T_TABLE)
          GET(T_TABLE,J#)
          IF T:SUMMA_P
            DAUDZUMSK = T:DAUDZUMS
            ITOGOK    = T:SUMMA_P
            TIPS = '???'
            EXECUTE INSTRING(T:TIPS,'PTAKRI')
               TIPS = 'Prece'
               TIPS = 'Tara'
               TIPS = 'Pakalpojumi'
               TIPS = 'Kokmateriâli'
               TIPS = 'Raþojums'
               TIPS = 'Iepakojumii'
            .
            IF F:DBF='W'
                PRINT(RPT:RPT_FOOT2)
            ELSIF F:DBF='E'
                OUTA:LINE=KOPA&CHR(9)&TIPS&' {80}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(DAUDZUMSK,@N-_12.3)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(ITOGOK,@N-_14.2)
                ADD(OUTFILEANSI)
            ELSE
                OUTA:LINE=KOPA&CHR(9)&TIPS&' {80}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(DAUDZUMSK,@N-_12.2)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&' {36}'&CHR(9)&FORMAT(ITOGOK,@N-_14.2)
                ADD(OUTFILEANSI)
            END
            KOPA=''
          .
        .
     .
 !***************************** JA IR ATGRIEZTÂ PRECE *******************
    IF DAUDZUMS_R
         KOPA = ''
         TIPS = 'Atgrieztâ prece'
         DAUDZUMSK = DAUDZUMS_R
         ITOGOK    = SUMMA_R
         SUMMA_BK  = SUMMA_RB
         IF F:DBF='W'
             PRINT(RPT:RPT_FOOT2)
         ELSE
             OUTA:LINE=KOPA&CHR(9)&TIPS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_12.3))&CHR(9)&|
             LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
             ADD(OUTFILEANSI)
         .
    .
 !*****************************************
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
    KURSI_K::Used -= 1
    IF KURSI_K::Used = 0 THEN CLOSE(KURSI_K).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(K_TABLE)
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

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ~(PAR_NR=999999999)                 !KONKRÇTS PARTNERIS
     IF ~(NOL:PAR_NR=PAR_NR) THEN VISS#=TRUE.
  .
  IF F:SECIBA='N'                        !TIEK GRIEZTS NOMENKLATÛRU SECÎBÂ
    IF ERRORCODE() OR CYCLENOM(NOL:NOMENKLAT)=2 THEN VISS#=TRUE.
  ELSE
    IF ERRORCODE() OR NOL:DATUMS>B_DAT THEN VISS#=TRUE.
  .
  IF VISS#=TRUE
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
N_IZGMATP            PROCEDURE                    ! Declare Procedure
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
DOK_NR                  STRING(10)
SECIBA                  STRING(30)
NR                      DECIMAL(4)
SUMMA_B                 DECIMAL(13,2)
SUMMA_BK                DECIMAL(13,2)
SUMMA_P                 DECIMAL(14,2)
SUMMA_PK                DECIMAL(14,2)
SUMMA_PVN               DECIMAL(12,2)
SUMMA_PVNK              DECIMAL(12,2)
ITOGO                   DECIMAL(14,2)
ITOGOK                  DECIMAL(14,2)
TRANSK                  DECIMAL(10,2)
SANEMTS                 STRING(8)
DAUDZUMSK               DECIMAL(14,3)
VALK                    STRING(3)
DAT                     LONG
LAI                     LONG
NOS_P                   STRING(80)
CN                      STRING(10)
KOPA                    STRING(20)

N_TABLE              QUEUE,PRE(N)
KEY                     STRING(26) !5+21
U_NR                    ULONG
DAUDZUMS                DECIMAL(12,3)
SUMMA_B                 DECIMAL(13,2)
SUMMA_PVN               DECIMAL(12,2)
SUMMA_P                 DECIMAL(14,2)
VAL                     STRING(3)
T_SUMMA                 DECIMAL(10,2)
                     .
K_TABLE              QUEUE,PRE(K)
VAL                     STRING(3)
SUMMA_P                 DECIMAL(14,2)
                     .

NOM_NOSAUKUMS           STRING(35)
N_DATUMS                LONG
N_NOMENKLAT             STRING(21)
SAV_NOMENKLAT           STRING(21)
SAV_U_NR                ULONG
MER                     STRING(7)
DAUDZUMS                DECIMAL(13,2)
NOM_KAT                 STRING(17)
DAUDZUMS_R              DECIMAL(12,2)
SUMMA_R                 DECIMAL(12,2)
SUMMA_RB                DECIMAL(12,2)
LINEH                   STRING(190)
FILTRS_TEXT             STRING(100)

!--------------------------------------------------------------------------
report REPORT,AT(500,1719,12000,6104),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(500,500,12000,1219),USE(?unnamed)
         LINE,AT(6042,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@s80),AT(1583,417,6042,156),USE(nos_p),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(4948,229,781,208),USE(s_dat),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(5729,229,365,208),USE(?String4:4),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(6094,229,781,208),USE(b_dat),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IZ1K'),AT(8854,521,677,156),USE(?String14),LEFT,FONT(,8,,)
         STRING(@P<<<#. lapaP),AT(9583,521,521,156),PAGENO,USE(?PAGECOUNT),RIGHT,FONT(,8,,)
         STRING(@s100),AT(688,552,7865,156),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,729,10313,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(365,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('NPK'),AT(104,885,260,208),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(990,990,573,208),USE(?String17:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,729,0,521),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@s30),AT(990,781,2240,156),USE(SECIBA),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1563,938,0,260),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(1615,990,1615,208),USE(?String17:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(3281,885,2031,208),USE(?String17:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(5365,885,677,208),USE(?String17:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(6094,781,781,208),USE(?String17:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pçc pavadzîmes'),AT(7604,781,1042,208),USE(?String17:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ, Ls'),AT(9427,885,938,208),USE(?String17:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(417,990,521,208),USE(?String17:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,938,2292,0),USE(?Line58),COLOR(COLOR:Black)
         STRING('P/Z'),AT(417,781,521,208),USE(?String17:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10365,729,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         STRING('Transports'),AT(8698,781,677,208),USE(?String17:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8646,729,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         STRING('PVN, Ls'),AT(6927,885,625,208),USE(?String17:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN, Ls'),AT(6094,990,781,208),USE(?String17:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(7604,990,1042,208),USE(?String17:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(P/Z, val.)'),AT(8698,990,677,208),USE(?String17:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1198,10313,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(3229,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5313,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6875,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7552,729,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(9375,729,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(52,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(2448,21,4323,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktava :'),AT(8073,156,885,229),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(8979,156),USE(LOC_NR),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Izziòa par izgâjuðajâm ('),AT(2208,229,1771,208),USE(?String4),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(3990,229,156,208),USE(d_k),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(') precçm :'),AT(4146,229,781,208),USE(?String4:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(6042,-10,0,198),USE(?Line11:6),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line11),COLOR(COLOR:Black)
         STRING(@n_4),AT(104,10,260,156),USE(nr),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(365,-10,0,198),USE(?Line11:2),COLOR(COLOR:Black)
         STRING(@S10),AT(417,10,521,156),USE(DOK_nr),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(1563,-10,0,198),USE(?Line11:3),COLOR(COLOR:Black)
         STRING(@s21),AT(1615,10,1615,156),USE(N_NOMENKLAT),FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3229,-10,0,198),USE(?Line11:4),COLOR(COLOR:Black)
         STRING(@s35),AT(3281,10,2031,156),USE(NOM_NOSAUKUMS),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.2),AT(9427,10,885,156),USE(ITOGO),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(10365,-10,0,198),USE(?Line11:10),COLOR(COLOR:Black)
         LINE,AT(938,-10,0,198),USE(?Line11:11),COLOR(COLOR:Black)
         STRING(@D6),AT(990,10,573,156),USE(N_DATUMS),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(9375,-10,0,198),USE(?Line11:9),COLOR(COLOR:Black)
         STRING(@n-_10.2),AT(8698,10,625,156),USE(N:T_SUMMA),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_10.2),AT(6927,10,573,156),USE(N:SUMMA_PVN),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5313,-10,0,198),USE(?Line11:5),COLOR(COLOR:Black)
         STRING(@n-_12.3),AT(5365,10,625,156),USE(N:DAUDZUMS),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_13.2),AT(6094,10,729,156),USE(N:SUMMA_b),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6875,-10,0,198),USE(?Line11:7),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(7604,10,729,156),USE(N:SUMMA_P),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7552,-10,0,198),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,198),USE(?Line11:8),COLOR(COLOR:Black)
         STRING(@s3),AT(8385,10,260,156),USE(N:VAL),LEFT,FONT(,8,,,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(52,-10,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(52,52,10313,0),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(10365,-10,0,115),USE(?Line28:3),COLOR(COLOR:Black)
         LINE,AT(938,-10,0,63),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(3229,-10,0,63),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(5313,-10,0,63),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(9375,-10,0,115),USE(?Line28:2),COLOR(COLOR:Black)
         LINE,AT(6875,-10,0,115),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,115),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(1563,-10,0,63),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,63),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,115),USE(?Line29:2),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,115),USE(?Line29:286),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         STRING(@s3),AT(8385,10,260,156),USE(VALK),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7552,-10,0,198),USE(?Line21:4),COLOR(COLOR:Black)
         LINE,AT(6875,-10,0,198),USE(?Line21:5),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,198),USE(?Line21:6),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,198),USE(?Line21:3),COLOR(COLOR:Black)
         STRING(@s20),AT(573,10,1510,156),USE(KOPA),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(10365,-10,0,198),USE(?Line21:8),COLOR(COLOR:Black)
         STRING(@n-_14.3B),AT(5156,10,833,156),USE(DAUDZUMSK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_13.2B),AT(6094,10,729,156),USE(SUMMA_BK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_10.2B),AT(6927,10,573,156),USE(SUMMA_PVNK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_10.2B),AT(8698,10,625,156),USE(TRANSK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.2B),AT(9427,10,885,156),USE(ITOGOK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.2B),AT(7604,10,729,156),USE(SUMMA_PK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(9375,-10,0,198),USE(?Line21:2),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line21:92),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,427)
         LINE,AT(52,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,63),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,63),USE(?Line36:2),COLOR(COLOR:Black)
         LINE,AT(9375,-10,0,63),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(10365,-10,0,63),USE(?Line236),COLOR(COLOR:Black)
         LINE,AT(52,52,10313,0),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,63),USE(?Line43),COLOR(COLOR:Black)
         STRING('Sastadîja :'),AT(521,156,573,208),USE(?String50),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s8),AT(1094,156),USE(ACC_kods),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1823,156,260,208),USE(?String52),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s1),AT(2083,156),USE(RS),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING(@D6),AT(8385,156),USE(dat),FONT(,8,,,CHARSET:BALTIC)
         STRING(@T4),AT(9219,156),USE(LAI),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6875,-10,0,63),USE(?Line42),COLOR(COLOR:Black)
       END
       FOOTER,AT(500,7802,12000,63)
         LINE,AT(52,0,10313,0),USE(?Line22:3),COLOR(COLOR:Black)
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
!  1 PARTNERIM
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  NR    = 0
  DAT = TODAY()
  LAI = CLOCK()
  NOS_P=GETPAR_K(PAR_NR,2,2)
  IF ~(ADR_NR = 999999999)
     NOS_P=CLIP(NOS_P)&' '&GETPAR_ADRESE(PAR_NR,ADR_NR,0,0)
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  IF PAVAD::Used = 0        !DÇÏ GETPAVAD
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1          
  IF NOM_K::Used = 0        !DÇÏ GETNOM_K
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1          
  IF VAL_K::Used = 0        !DÇÏ BANKURS
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  IF KURSI_K::Used = 0      !DÇÏ BANKURS
    CheckOpen(KURSI_K,1)
  END
  KURSI_K::Used += 1
  BIND(NOL:RECORD)
  BIND('CN',CN)
  BIND('PAR_NR',PAR_NR)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'N10010'
!           123456
      IF F:SECIBA='N'                        !NOMENKLATÛRU SECÎBA
         SECIBA='Secîba:Nomenklat-Datums'
      ELSE
         SECIBA='Secîba:Datums-Nomenklat'
      .
!
      IF F:OBJ_NR THEN FILTRS_TEXT='Objekts:'&F:OBJ_NR.
      IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
      IF NOMENKLAT THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nomenklatûra:'&NOMENKLAT.
      IF F:DIENA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Diena/nakts=:'&F:DIENA.
!
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
      CLEAR(nol:RECORD)
      NOL:DATUMS = S_DAT
      NOL:D_K = D_K
      NOL:PAR_NR = PAR_NR
      SET(nol:PAR_KEY,NOL:PAR_KEY)
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
          IF ~OPENANSI('IZGMATP.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT&' NOLIKTAVA: '&LOC_NR
          ADD(OUTFILEANSI)
          IF F:DBF = 'E'
            OUTA:LINE='IZZIÒA PAR IZGÂJUÐÂM ('&D_K&') PRECÇM NO '&format(S_DAT,@d10.)&' LÎDZ '&format(B_DAT,@d10.)&' '&NOS_P
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE='IZZIÒA PAR IZGÂJUÐÂM ('&D_K&') PRECÇM NO '&format(S_DAT,@d6)&' LÎDZ '&format(B_DAT,@d6)&' '&NOS_P
            ADD(OUTFILEANSI)
          END
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
          OUTA:LINE=' Npk'&CHR(9)&'P/Z       '&CHR(9)&format(SECIBA,@s30)&CHR(9)&CHR(9)&'Nosaukums {20}'&CHR(9)&'Kataloga Numurs  '&CHR(9)&'      Daudzums'&CHR(9)&'Summa     bez'&CHR(9)&'PVN,    Ls'&CHR(9)&'Pçc pavadzîmes'&CHR(9)&CHR(9)&'Transports'&CHR(9)&'      Kopâ, Ls'
          ADD(OUTFILEANSI)
          OUTA:LINE=       CHR(9)&'Numurs    '&CHR(9)&'Datums    '&CHR(9)&'Nomenklatûra {9}'&CHR(9)&' {35}'&CHR(9)&' {17}'&CHR(9)&' {14}'&CHR(9)&'PVN,       Ls'&CHR(9)&'          '&CHR(9)&'ar PVN, valûtâ'&CHR(9)&CHR(9)&'(P/Z,val.)'
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NK#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT)  AND|
           ~((F:DIENA='N' AND ~BAND(NOL:BAITS,00000100b)) OR (F:DIENA='D' AND BAND(NOL:BAITS,00000100b)))
           IF F:SECIBA='N'              !NOMENKLATÛRU SECÎBA
              N:KEY[1:21]=NOL:NOMENKLAT
              N:KEY[22:26]=NOL:DATUMS
           ELSE
              N:KEY[1:5]=NOL:DATUMS
              N:KEY[6:26]=NOL:NOMENKLAT
           .
           N:U_NR     =NOL:U_NR
           N:DAUDZUMS =NOL:DAUDZUMS
           N:SUMMA_B  =calcsum(15,2)        ! Ls
           N:SUMMA_P  =CALCSUM(4,2)         ! VALÛTÂ
           N:SUMMA_PVN=CALCSUM(17,2)        ! Ls
           N:VAL      =NOL:VAL
           N:T_SUMMA  =NOL:T_SUMMA
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     SORT(N_TABLE,N:KEY)
     LOOP I#=1 TO RECORDS(N_TABLE)
        GET(N_TABLE,I#)
        IF F:SECIBA='N'              !NOMENKLATÛRU SECÎBA
           N_NOMENKLAT=N:KEY[1:21]
           N_DATUMS   =N:KEY[22:26]
        ELSE
           N_NOMENKLAT=N:KEY[6:26]
           N_DATUMS   =N:KEY[1:5]
        .
        IF ~(SAV_U_NR=N:U_NR)
           G#=GETPAVADZ(N:U_NR)                        !POZICIONÇ PAVADZÎMES
           SAV_U_NR=N:U_NR
        .
        IF F:OBJ_NR AND ~(F:OBJ_NR=PAV:OBJ_NR) THEN CYCLE.               !F pçc objekta
        IF F:NODALA AND ~(PAV:NODALA=F:NODALA OR (PAV:NODALA[1]=F:NODALA[1] AND F:NODALA[2]='') OR|
           (PAV:NODALA[2]=F:NODALA[2] AND F:NODALA[1]='')) THEN CYCLE.   !F PÇC NODAÏAS
        IF ~(ADR_NR=999999999 OR ADR_NR=PAV:PAR_ADR_NR) THEN CYCLE.
        IF ~(SAV_NOMENKLAT=N_NOMENKLAT)
           IF CL_NR=1493  !RÎGAS BÛVMATERIÂLI
              NOM_NOSAUKUMS=GETNOM_K(N_NOMENKLAT,2,3) !NOS_S
           ELSE
              NOM_NOSAUKUMS=GETNOM_K(N_NOMENKLAT,2,2) !NOSAUKUMS
           .
           NOM_KAT = NOM:KATALOGA_NR
           SAV_NOMENKLAT=N_NOMENKLAT
        .

        K:VAL = N:VAL
        GET(K_TABLE,K:VAL)
        IF ERROR()
          K:VAL     = N:VAL
          K:SUMMA_P = N:SUMMA_P
          ADD(K_TABLE,K:VAL)
          SORT(K_TABLE,K:VAL)
        ELSE
          K:SUMMA_P += N:SUMMA_P
          PUT(K_TABLE)
        .
        IF N:DAUDZUMS<0    ! ATGRIEZTÂ PRECE
          DAUDZUMS_R += N:DAUDZUMS
          SUMMA_R    += N:SUMMA_B+N:SUMMA_PVN
          SUMMA_RB   += N:SUMMA_B
        END
        ITOGO = N:SUMMA_B + N:SUMMA_PVN + N:T_SUMMA*BANKURS(N:VAL,N_DATUMS)  !LS
        DAUDZUMSK   += N:DAUDZUMS            ! SKAITA KOPÂ DAUDZUMUS, ANYWAY
        SUMMA_BK    += N:SUMMA_B             ! BEZ PVN LS
        SUMMA_PVNK  += N:SUMMA_PVN           ! PVN LS
        SUMMA_PK    += N:SUMMA_B+N:SUMMA_PVN ! AR PVN LS
        TRANSK      += N:T_SUMMA*BANKURS(N:VAL,N_DATUMS)  ! Ls
        ITOGOK      += ITOGO                 ! Ls
        DOK_NR=PAV:DOK_SENR
        NR +=1
        IF ~F:DTK
          IF F:DBF='W'
            PRINT(RPT:DETAIL)
          ELSIF F:DBF='E'
            OUTA:LINE=format(NR,@n_4)&CHR(9)&format(DOK_NR,@s10)&CHR(9)&FORMAT(N_DATUMS,@D10.)&CHR(9)&format(N_NOMENKLAT,@s21)&CHR(9)&format(NOM_NOSAUKUMS,@s35)&CHR(9)&format(NOM_KAT,@s17)&CHR(9)&FORMAT(N:DAUDZUMS,@N-_14.3)&CHR(9)&FORMAT(N:SUMMA_B,@N-_13.2)&CHR(9)&FORMAT(N:SUMMA_PVN,@N-_10.2)&CHR(9)&FORMAT(N:SUMMA_P,@N-_14.2)&CHR(9)&N:VAL&CHR(9)&FORMAT(N:T_SUMMA,@N-_10.2)&CHR(9)&FORMAT(ITOGO,@N-_14.2)
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE=format(NR,@n_4)&CHR(9)&format(DOK_NR,@s10)&CHR(9)&FORMAT(N_DATUMS,@D6)&CHR(9)&format(N_NOMENKLAT,@s21)&CHR(9)&format(NOM_NOSAUKUMS,@s35)&CHR(9)&format(NOM_KAT,@s17)&CHR(9)&FORMAT(N:DAUDZUMS,@N-_14.3)&CHR(9)&FORMAT(N:SUMMA_B,@N-_13.2)&CHR(9)&FORMAT(N:SUMMA_PVN,@N-_10.2)&CHR(9)&FORMAT(N:SUMMA_P,@N-_14.2)&CHR(9)&N:VAL&CHR(9)&FORMAT(N:T_SUMMA,@N-_10.2)&CHR(9)&FORMAT(ITOGO,@N-_14.2)
            ADD(OUTFILEANSI)
          END
        END
     END
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
         OUTA:LINE=KOPA&' {51}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(DAUDZUMSk,@N-_14.3)&CHR(9)&FORMAT(SUMMA_Bk,@N-_13.2)&CHR(9)&FORMAT(SUMMA_PVNk,@N-_10.2)&CHR(9)&FORMAT(SUMMA_Pk,@N-_14.2)&CHR(9)&VALk&CHR(9)&FORMAT(Transk,@N-_10.2)&CHR(9)&FORMAT(ITOGOk,@N-_14.2)
         ADD(OUTFILEANSI)
     ELSE
         OUTA:LINE=KOPA&' {51}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(DAUDZUMSk,@N-_14.3)&CHR(9)&FORMAT(SUMMA_Bk,@N-_13.2)&CHR(9)&FORMAT(SUMMA_PVNk,@N-_10.2)&CHR(9)&FORMAT(SUMMA_Pk,@N-_14.2)&CHR(9)&VALk&CHR(9)&FORMAT(Transk,@N-_10.2)&CHR(9)&FORMAT(ITOGOk,@N-_14.2)
         ADD(OUTFILEANSI)
     END
     DAUDZUMSK  = 0
     SUMMA_BK   = 0
     SUMMA_PK   = 0
     SUMMA_PVNK = 0
     TRANSK     = 0
     ITOGOK     = 0
     KOPA = 't.s.'
     GET(K_TABLE,0)
     LOOP J# = 1 TO RECORDS(K_TABLE)
        GET(K_TABLE,J#)
        IF K:SUMMA_P <> 0
         SUMMA_PK = K:SUMMA_P
         VALK     = K:VAL
         IF F:DBF='W'
             PRINT(RPT:RPT_FOOT2)                      !PRINT GRAND TOTALS
         ELSIF F:DBF='E'
             OUTA:LINE=KOPA&' {71}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(SUMMA_Pk,@N-_14.2)&CHR(9)&VALk
             ADD(OUTFILEANSI)
         ELSE
             OUTA:LINE=KOPA&' {71}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(SUMMA_Pk,@N-_14.2)&CHR(9)&VALk
             ADD(OUTFILEANSI)
         END
         KOPA = ''
        .
     .
 !********************** JA IR ATGRIEZTÂ PRECE ******************************
     DAUDZUMSK  = 0
     SUMMA_BK   = 0
     SUMMA_PK   = 0
     SUMMA_PVNK = 0
     TRANSK     = 0
     ITOGOK     = 0
     VALK = ''
     IF DAUDZUMS_R
        KOPA = 't.s. Atgrieztâ prece'
        DAUDZUMSK = DAUDZUMS_R
        SUMMA_BK  = SUMMA_RB
        ITOGOK = SUMMA_R
         IF F:DBF='W'
             PRINT(RPT:RPT_FOOT2)                      !PRINT GRAND TOTALS
         ELSIF F:DBF='E'
             OUTA:LINE=KOPA&' {48}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(DAUDZUMSK,@N-_14.2)&CHR(9)&FORMAT(SUMMA_BK,@N-_12.2)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&' {36}'&CHR(9)&FORMAT(ITOGOK,@N-_14.2)
             ADD(OUTFILEANSI)
         ELSE
             OUTA:LINE=KOPA&' {48}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(DAUDZUMSK,@N-_14.2)&CHR(9)&FORMAT(SUMMA_BK,@N-_12.2)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&' {36}'&CHR(9)&FORMAT(ITOGOK,@N-_14.2)
             ADD(OUTFILEANSI)
         END
     END
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
  .
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
  FREE(K_TABLE)
  FREE(N_TABLE)
  IF FilesOpened
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
    KURSI_K::Used -= 1
    IF KURSI_K::Used = 0 THEN CLOSE(KURSI_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'.
  ADR_NR = 0
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
  IF ERRORCODE() OR ~(NOL:PAR_NR=PAR_NR) OR ~(NOL:DATUMS<=B_DAT)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END
