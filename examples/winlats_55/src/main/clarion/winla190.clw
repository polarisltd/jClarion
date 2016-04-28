                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_IzgPT              PROCEDURE                    ! Declare Procedure
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

NPK                  USHORT
SUMMA_P              DECIMAL(14,2)
SUMMA_PR             DECIMAL(14,2)
SUMMA_TA             DECIMAL(13,2)
SUMMA_PA             DECIMAL(13,2)
SUMMA_X              DECIMAL(14,2)
KOPA                 STRING(20)
SUMMA_PK             DECIMAL(14,2)
SUMMA_PRK            DECIMAL(14,2)
SUMMA_TAK            DECIMAL(14,2)
SUMMA_PAK            DECIMAL(14,2)
SUMMA_XK              DECIMAL(14,2)
VALK                 STRING(3)
DAT                  LONG
LAI                  TIME
CN                  STRING(10)
CP                  STRING(3)

K_TABLE              QUEUE,PRE(K)
VAL                   STRING(3)
SUMMA_P               DECIMAL(14,2)
                     .

VIRSRAKSTS           STRING(110)
FILTRS_TEXT          STRING(100)
TAB_4_TEXT            STRING(15) !SAÒÇMÇJS/PAMAT.
X_TEXT               STRING(20)
NOS_P                STRING(35) !PAR:NOS_P/PAV:PAMATOJUMS
DAUDZUMS_R           DECIMAL(12,2)
SUMMA_R              DECIMAL(12,2)

!--------------------------------------------------------------------------
report REPORT,AT(1000,1719,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(1000,500,12000,1219),USE(?unnamed)
         STRING('FORMA IZ4 '),AT(8240,417,833,156),USE(?String7),RIGHT(1),FONT(,8,,,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(8500,573,573,156),PAGENO,USE(?PageCount),RIGHT(1),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s100),AT(406,563,7729,156),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,729,9010,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(365,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1042,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(1719,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(3854,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Dokum.'),AT(1073,781,625,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(1948,875,1365,208),USE(TAB_4_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa pçc'),AT(3875,781,1042,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(4979,990,1042,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(6073,990,1042,208),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(8260,990,781,208),USE(X_TEXT),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1198,9010,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(4948,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6042,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7135,729,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(8229,729,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(9063,729,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         STRING('Preèu'),AT(4979,781,1042,208),USE(?String10:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Taras'),AT(6073,781,1042,208),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârçjie'),AT(7188,885,938,208),USE(?String10:7),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa '),AT(8250,781,510,208),USE(?String10:14),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(8750,781,292,208),USE(val_uzsk),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(104,885),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(396,781,625,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(396,990,625,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(1073,990,625,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokumenta'),AT(3885,990,1042,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(2073,31,4375,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s110),AT(167,333,8219,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         STRING(@S14),AT(1073,10,610,160),USE(PAV:DOK_SENR),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(1719,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         STRING(@S35),AT(1771,10,2031,156),USE(NOS_P),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(3854,-10,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(3906,10,729,156),USE(SUMMA_P),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(4688,10,260,156),USE(PAV:VAL),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(4948,-10,0,198),USE(?Line12:6),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(5000,10,729,156),USE(SUMMA_PR),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(5781,10,260,156),USE(PAV:VAL,,?PAV:VAL:2),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6042,-10,0,198),USE(?Line12:7),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(6094,10,729,156),USE(SUMMA_TA),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(6875,10,260,156),USE(PAV:VAL,,?PAV:VAL:3),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7135,-10,0,198),USE(?Line12:8),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(7188,10,729,156),USE(SUMMA_PA),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(7969,10,260,156),USE(PAV:VAL,,?PAV:VAL:4),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@n-_13.2),AT(8281,10,729,156),USE(SUMMA_X),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(8229,-10,0,198),USE(?Line12:9),COLOR(COLOR:Black)
         LINE,AT(9063,-10,0,198),USE(?Line12:10),COLOR(COLOR:Black)
         LINE,AT(1042,-10,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         STRING(@D6),AT(417,10,573,156),USE(PAV:DATUMS),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(365,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         STRING(@n_4),AT(83,10,260,156),CNT,USE(NPK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(52,-10,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,63),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(1042,-10,0,63),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(1719,-10,0,63),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,115),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,115),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,115),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,115),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(8229,-10,0,115),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(9063,-10,0,115),USE(?Line29:2),COLOR(COLOR:Black)
         LINE,AT(52,52,9010,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,198),USE(?Line31),COLOR(COLOR:Black)
         STRING(@S20),AT(260,10,1719,156),USE(KOPA),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(3854,-10,0,198),USE(?Line31:2),COLOR(COLOR:Black)
         STRING(@n-_14.2B),AT(3906,10,729,156),USE(SUMMA_PK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(4948,-10,0,198),USE(?Line31:3),COLOR(COLOR:Black)
         STRING(@n-_14.2B),AT(5000,10,729,156),USE(SUMMA_PRK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6042,-10,0,198),USE(?Line31:4),COLOR(COLOR:Black)
         STRING(@n-_13.2B),AT(6094,10,729,156),USE(SUMMA_TAK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7135,-10,0,198),USE(?Line31:5),COLOR(COLOR:Black)
         STRING(@n-_13.2B),AT(7188,10,729,156),USE(SUMMA_PAK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(4688,10,260,156),USE(VALK),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(8229,-10,0,198),USE(?Line31:6),COLOR(COLOR:Black)
         STRING(@n-_13.2B),AT(8281,10,729,156),USE(SUMMA_XK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(9063,-10,0,198),USE(?Line31:7),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,250),USE(?unnamed:2)
         LINE,AT(52,-10,0,63),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,63),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,63),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,63),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,63),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(8229,-10,0,63),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(9063,-10,0,63),USE(?Line43:2),COLOR(COLOR:Black)
         LINE,AT(52,52,9010,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(94,83,458,146),USE(?String45),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(573,83,521,146),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1406,83,208,146),USE(?String45:2),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1615,83,208,146),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(8115,83,521,146),USE(DAT),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(8646,83,417,146),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
       END
       FOOTER,AT(1000,8000,12000,63)
         LINE,AT(52,0,9010,0),USE(?Line1:5),COLOR(COLOR:Black)
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

  D_K = 'K'
  DAT = TODAY()
  LAI = CLOCK()

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  CHECKOPEN(NOLIK,1)
!  CHECKOPEN(NOM_K,1)
!  CHECKOPEN(PAR_K,1)
!  CHECKOPEN(VAL_K,1)
!  BIND('S_DAT',S_DAT)
!  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOL',CYCLENOL)
  BIND(PAV:RECORD)
!  BIND(NOL:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Preèu/Taras atskaite'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'P10011'
      CP = 'P11'
      X_TEXT='pçc '&CLIP(NOKL_CP)&' cenas'
      VIRSRAKSTS='Izgâjuðâs P/Z-preèu/taras('&D_K&') no '&format(S_DAT,@d06.)&' lîdz '&|
      format(B_DAT,@d06.)&' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS

      CLEAR(PAV:RECORD)
      PAV:D_K=D_K
      PAV:DATUMS=S_DAT
      IF PAR_NR = 999999999 !VISI
         FILTRS_TEXT=GETFILTRS_TEXT('101100000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         TAB_4_TEXT='Saòçmçjs'
         SET(PAV:DAT_KEY,PAV:DAT_KEY)
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLEPAR_K(CP)'
      ELSE
         FILTRS_TEXT=GETFILTRS_TEXT('100000000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Saòçmçjs: '&GETPAR_K(PAR_NR,2,2)
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
         IF ~OPENANSI('IZGPT.TXT')
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
!            OUTA:LINE='Npk'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&TAB_4_TEXT&CHR(9)&'Summa pçc'&CHR(9)&CHR(9)&|
!            'Preèu'&CHR(9)&CHR(9)&'Taras'&CHR(9)&CHR(9)&'Pakalpojumu'&CHR(9)&CHR(9)&'Summa Ls'
            OUTA:LINE='Npk'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&TAB_4_TEXT&CHR(9)&'Summa pçc'&CHR(9)&CHR(9)&|
            'Preèu'&CHR(9)&CHR(9)&'Taras'&CHR(9)&CHR(9)&'Pakalpojumu'&CHR(9)&CHR(9)&'Summa '&val_uzsk
            ADD(OUTFILEANSI)
            OUTA:LINE=CHR(9)&'Datums'&CHR(9)&'SE-Numurs'&CHR(9)&CHR(9)&'dokumenta'&CHR(9)&CHR(9)&'summa'&CHR(9)&CHR(9)&|
            'summa'&CHR(9)&CHR(9)&'summa'&CHR(9)&CHR(9)&X_TEXT
            ADD(OUTFILEANSI)
         ELSE !WORD
!            OUTA:LINE='Npk'&CHR(9)&'Dokumenta Datums'&CHR(9)&'Dokumenta SE-Numurs'&CHR(9)&TAB_4_TEXT&CHR(9)&|
!            'Summa pçc dokumenta'&CHR(9)&CHR(9)&'Preèu summa'&CHR(9)&CHR(9)&'Taras summa'&CHR(9)&CHR(9)&|
!            'Pakalpojumu summa'&CHR(9)&CHR(9)&'Summa Ls '&X_TEXT
            OUTA:LINE='Npk'&CHR(9)&'Dokumenta Datums'&CHR(9)&'Dokumenta SE-Numurs'&CHR(9)&TAB_4_TEXT&CHR(9)&|
            'Summa pçc dokumenta'&CHR(9)&CHR(9)&'Preèu summa'&CHR(9)&CHR(9)&'Taras summa'&CHR(9)&CHR(9)&|
            'Pakalpojumu summa'&CHR(9)&CHR(9)&'Summa  '&val_uzsk&' '&X_TEXT
            ADD(OUTFILEANSI)
         .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         C#=GETPAR_K(PAV:PAR_NR,2,1)
         NPK += 1
         ?Progress:UserString{Prop:Text}=NPK
         DISPLAY(?Progress:UserString)
         SUMMA_P   = PAV:SUMMA
         SUMMA_PK  += SUMMA_P*BANKURS(PAV:VAL,PAV:DATUMS)
         GET(K_TABLE,0)
         K:VAL=PAV:VAL
         GET(K_TABLE,K:VAL)
         IF ERROR()
            K:VAL     = PAV:VAL
            K:SUMMA_P = SUMMA_P
            ADD(K_TABLE)
            SORT(K_TABLE,K:VAL)
         ELSE
            K:SUMMA_P += summa_p
            PUT(K_TABLE)
         .
         summa_PR = 0
         summa_TA = 0
         summa_PA = 0
         SUMMA_X  = 0

         clear(nol:record)
         nol:U_nr=pav:U_nr
         set(nol:nr_key,nol:nr_key)
         LOOP
            NEXT(NOLIK)
            IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
            case GETNOM_K(NOL:NOMENKLAT,0,16)
            of 'P'
               summa_PR+=calcsum(4,2)    !VALÛTÂ AR PVN - A
            of 'T'
               summa_TA+=calcsum(4,2)
            else
               summa_PA+=calcsum(4,2)
            .
            SUMMA_X+=GETNOM_K(NOL:NOMENKLAT,0,7)*NOL:DAUDZUMS
            IF NOL:DAUDZUMS<0  !ATGRIEZTA PRECE
                DAUDZUMS_R += NOL:DAUDZUMS
                SUMMA_R    += CALCSUM(16,2)  !Ls AR PVN-A
            .
         .
         IF PAR_NR=999999999 !VISI
            NOS_P=GETPAR_K(PAV:PAR_NR,2,2)
         ELSE
            NOS_P=PAV:PAMAT
         .
         summa_PRK += summa_PR*BANKURS(PAV:VAL,PAV:DATUMS)
         summa_TAK += summa_TA*BANKURS(PAV:VAL,PAV:DATUMS)
         summa_PAK += summa_PA*BANKURS(PAV:VAL,PAV:DATUMS)
         SUMMA_XK  += SUMMA_X
         IF ~F:DTK
            IF F:DBF='W'
               PRINT(RPT:DETAIL)
            ELSE
               OUTA:LINE=NPK&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&PAV:DOK_SENR&CHR(9)&NOS_P&CHR(9)&|
               LEFT(format(SUMMA_P,@N-_14.2))&CHR(9)&PAV:VAL&CHR(9)&LEFT(format(SUMMA_PR,@N-_14.2))&|
               CHR(9)&PAV:VAL&CHR(9)&LEFT(format(SUMMA_TA,@N-_13.2))&CHR(9)&PAV:VAL&CHR(9)&|
               LEFT(format(SUMMA_PA,@N-_13.2))&CHR(9)&PAV:VAL&CHR(9)&LEFT(format(SUMMA_X,@N-_13.2))
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
  IF SEND(PAVAD,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    .
!****************************DRUKÂJAM KOPÂ **************
    KOPA='Kopâ:'
    !VALK = 'Ls'
    VALK = val_uzsk
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(SUMMA_PK,@N-_14.2))&CHR(9)&VALK&CHR(9)&|
        LEFT(format(SUMMA_PRK,@N-_14.2B))&CHR(9)&CHR(9)&LEFT(format(SUMMA_TAK,@N-_13.2B))&CHR(9)&CHR(9)&|
        LEFT(format(SUMMA_PAK,@N-_13.2B))&CHR(9)&CHR(9)&LEFT(format(SUMMA_XK,@N-_13.2B))
        ADD(OUTFILEANSI)
     .
!****************************DRUKÂJAM PÇC valûtâm **************
    SUMMA_PK  = 0
    SUMMA_PRK = 0
    SUMMA_TAK = 0
    SUMMA_PAK = 0
    SUMMA_XK  = 0
!    KOPA = 't.s.'
!    GET(K_TABLE,0)
!    LOOP J# = 1 TO RECORDS(K_TABLE)
!       GET(K_TABLE,J#)
!       IF K:SUMMA_P <> 0
!         SUMMA_PK = K:SUMMA_P
!         VALK     = K:VAL
!!         SUMMAPrK =K:SUMMAprK
!!         SUMMAtaK =K:SUMMAtaK
!!         SUMMApaK =K:SUMMApaK
!         IF F:DBF='W'
!             PRINT(RPT:RPT_FOOT2)
!         ELSIF F:DBF='E'
!             OUTA:LINE=FORMAT(KOPA,@S20)&CHR(9)&'  '&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_PK,@N-_14.2)&CHR(9)&VALK&CHR(9)&format(SUMMA_PRK,@N-_14.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAK,@N-_13.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAK,@N-_13.2B)&CHR(9)&'   '&CHR(9)&format(SVARSK,@N-_13.2B)
!             ADD(OUTFILEANSI)
!         ELSE
!             OUTA:LINE=FORMAT(KOPA,@S20)&CHR(9)&'  '&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_PK,@N-_14.2)&CHR(9)&VALK&CHR(9)&format(SUMMA_PRK,@N-_14.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAK,@N-_13.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAK,@N-_13.2B)&CHR(9)&'   '&CHR(9)&format(SVARSK,@N-_13.2B)
!             ADD(OUTFILEANSI)
!         END
!         kopa=''
!       .
!    .
    IF DAUDZUMS_R <> 0
        KOPA = 't.s. Atgrieztâ prece'
        VALK = ''
        SUMMA_PK = SUMMA_R
        SUMMA_PRK = 0
         IF F:DBF='W'
             PRINT(RPT:RPT_FOOT2)
         ELSE
!             OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(SUMMA_PK,@N-_14.2B))&CHR(9)&'Ls'&CHR(9)&|
!             LEFT(format(SUMMA_PRK,@N-_14.2B))
             OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(SUMMA_PK,@N-_14.2B))&CHR(9)&'val_uzsk'&CHR(9)&|
             LEFT(format(SUMMA_PRK,@N-_14.2B))
             ADD(OUTFILEANSI)
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
  IF FilesOpened
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'. !PAGAIDÂM
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
N_IzgPTP             PROCEDURE                    ! Declare Procedure
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
                       PROJECT(PAV:PAR_NR)
                       PROJECT(PAV:U_NR)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:VAL)
                     END
!------------------------------------------------------------------------

NPK                  USHORT
DOK_NR               STRING(14)
NOS_P                STRING(22)
PROJEKTS             STRING(50)
RPT_NR               DECIMAL(4)
SUMMA_P              DECIMAL(14,2)
SUMMA_PR             DECIMAL(14,2)
SUMMA_TA             DECIMAL(13,2)
SUMMA_PA             DECIMAL(13,2)
KOPA                 STRING(20)
SUMMA_PK             DECIMAL(14,2)
SUMMA_PRK            DECIMAL(14,2)
SUMMA_TAK            DECIMAL(13,2)
SUMMA_PAK            DECIMAL(13,2)
DAT                  DATE
LAI                  TIME
CN                  STRING(10)
CP                  STRING(1)

K_TABLE              QUEUE,PRE(K)
VAL                   STRING(3)
SUMMA_P               DECIMAL(14,2)
!!SUMMAprK              DECIMAL(12,2)
!!SUMMAtaK              DECIMAL(12,2)
!!SUMMApaK              DECIMAL(12,2)
                     .
VALK                 STRING(3)

LINEH                STRING(190)
DAUDZUMS_R           DECIMAL(12,2)
SUMMA_R              DECIMAL(12,2)

!--------------------------------------------------------------------------
report REPORT,AT(1000,1719,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(1000,500,12000,1219),USE(?unnamed:2)
         STRING('Adrese :'),AT(573,469,677,208),USE(?String2:4),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IZ4P'),AT(6719,521,781,156),USE(?String7),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7552,521,677,156),PAGENO,USE(?PageCount),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(52,729,8333,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(417,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1094,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4010,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Pamatojums'),AT(1854,875,2135,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa pçc'),AT(4052,781,1042,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(5146,990,1042,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(6240,990,1042,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(7333,990,1042,208),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(1250,469,3438,208),USE(par:adrese),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(4896,52,3698,208),USE(PROJEKTS),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(2708,260,3021,208),USE(par:nos_p),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(5833,260,833,208),USE(s_dat),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(6667,260,104,208),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(6771,260,833,208),USE(b_dat),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1198,8333,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(5104,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6198,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7292,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(8385,729,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         STRING('Preèu'),AT(5146,781,1042,208),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Taras'),AT(6240,781,1042,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârçjie'),AT(7333,781,1042,208),USE(?String10:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(83,875,313,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(458,781,625,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(1135,781,677,208),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1823,729,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Datums'),AT(458,990,625,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(1135,990,677,208),USE(?String10:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokumenta'),AT(4052,990,1042,208),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(469,52,4427,208),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktava :'),AT(4688,469,833,208),USE(?String2:3),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Izgâjuðâs preces - Saòçmçjs :'),AT(417,260,2240,208),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(5521,469,313,208),USE(LOC_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         STRING(@S40),AT(1875,10,2135,156),USE(PAv:pamat),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(4010,-10,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(4063,10,729,156),USE(SUMMA_P),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(4844,10,260,156),USE(PAV:VAL),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5104,-10,0,198),USE(?Line12:6),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(5156,10,729,156),USE(SUMMA_PR),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(5938,10,260,156),USE(PAV:VAL,,?PAV:VAL:2),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6198,-10,0,198),USE(?Line12:7),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(6250,10,729,156),USE(SUMMA_TA),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(7031,10,260,156),USE(PAV:VAL,,?PAV:VAL:3),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7292,-10,0,198),USE(?Line12:8),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(7344,10,729,156),USE(SUMMA_PA),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(8125,10,260,156),USE(PAV:VAL,,?PAV:VAL:4),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(8385,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         STRING(@S14),AT(1115,10,690,156),USE(DOK_NR),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(1823,-10,0,198),USE(?Line12:9),COLOR(COLOR:Black)
         STRING(@D6),AT(469,10,573,156),USE(PAV:DATUMS),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(417,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         STRING(@n_4),AT(104,10,260,156),USE(npk),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(52,-10,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,63),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,63),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(4010,-10,0,115),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,115),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,115),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(7292,-10,0,115),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(1823,-10,0,63),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,115),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(52,52,8333,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,198),USE(?Line31),COLOR(COLOR:Black)
         STRING(@S20),AT(104,10,1563,156),USE(KOPA),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(4010,-10,0,198),USE(?Line31:2),COLOR(COLOR:Black)
         STRING(@n-_14.2B),AT(4063,10,729,156),USE(SUMMA_PK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5104,-10,0,198),USE(?Line31:3),COLOR(COLOR:Black)
         STRING(@n-_14.2B),AT(5156,10,729,156),USE(SUMMA_PRK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6198,-10,0,198),USE(?Line31:4),COLOR(COLOR:Black)
         STRING(@n-_13.2B),AT(6250,10,729,156),USE(SUMMA_TAK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7292,-10,0,198),USE(?Line31:5),COLOR(COLOR:Black)
         STRING(@n-_13.2B),AT(7344,10,729,156),USE(SUMMA_PAK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(4844,10,260,156),USE(VALK),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(8385,-10,0,198),USE(?Line31:6),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,417),USE(?unnamed)
         LINE,AT(52,-10,0,63),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(4010,-10,0,63),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,63),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,63),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(7292,-10,0,63),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,63),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(52,52,8333,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastadîja :'),AT(208,156,573,208),USE(?String45),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s8),AT(781,156,521,208),USE(ACC_kods),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1406,156,260,208),USE(?String45:2),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s1),AT(1667,156,208,208),USE(RS),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING(@D6),AT(6198,156),USE(DAT),FONT(,8,,,CHARSET:BALTIC)
         STRING(@T4),AT(7083,156),USE(LAI),FONT(,8,,,CHARSET:BALTIC)
       END
       FOOTER,AT(1000,8000,12000,63)
         LINE,AT(52,0,8333,0),USE(?Line1:5),COLOR(COLOR:Black)
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

  DAT = TODAY()
  LAI = CLOCK()
  D_K = 'K'

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  CHECKOPEN(NOLIK,1)
!!  CHECKOPEN(NOM_K,1)
!!  CHECKOPEN(PAR_K,1)
!!  CHECKOPEN(VAL_K,1)
  BIND(PAV:RECORD)
  BIND('CN',CN)
  BIND('CYCLENOL',CYCLENOL)

  FilesOpened = True
  RecordsToProcess = BYTES(PAVAD)
  RecordsPerCycle = 1000
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Preèu/Taras '&PAR:NOS_S
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'P10111'
      CLEAR(PAV:RECORD)
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
      PAV:PAR_NR=PAR_NR
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
          IF ~OPENANSI('IZGPTP.TXT')
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
              OUTA:LINE='IZGÂJUÐÂS PRECES (PTP) - Saòçmçjs: '&CLIP(PAR:NOS_P)&' '&format(S_DAT,@d10.)&' - '&format(B_DAT,@d10.)
              ADD(OUTFILEANSI)
          ELSE
              OUTA:LINE='IZGÂJUÐÂS PRECES (PTP) - Saòçmçjs: '&CLIP(PAR:NOS_P)&' '&format(S_DAT,@d6)&' - '&format(B_DAT,@d6)
              ADD(OUTFILEANSI)
          END
          OUTA:LINE='Adrese: '&CLIP(PAR:ADRESE)&' '&PROJEKTS
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
          OUTA:LINE=' Npk'&CHR(9)&'Dokumenta '&CHR(9)&'Dokumenta '&CHR(9)&'Pamatojums {30}'&CHR(9)&'Summa      pçc'&CHR(9)&CHR(9)&' {9}Preèu'&CHR(9)&CHR(9)&' {8}Taras'&CHR(9)&CHR(9)&'  Pakalpojumu'
          ADD(OUTFILEANSI)
          OUTA:LINE='    '&CHR(9)&'Datums    '&CHR(9)&'Numurs    '&CHR(9)&' {40}'&          CHR(9)&'     dokumenta'&CHR(9)&CHR(9)&' {9}summa'&CHR(9)&CHR(9)&' {8}summa'&CHR(9)&CHR(9)&'        summa'
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK+=1
        ?Progress:UserString{Prop:Text}=NPK
        DISPLAY(?Progress:UserString)
        SUMMA_P   = PAV:SUMMA
        SUMMA_PK += SUMMA_P*BANKURS(PAV:VAL,PAV:DATUMS)
        GET(K_TABLE,0)
        K:VAL=PAV:VAL
        GET(K_TABLE,K:VAL)
        IF ERROR()
           K:VAL     = PAV:VAL
           K:SUMMA_P = summa_P
           ADD(K_TABLE)
           SORT(K_TABLE,K:VAL)
        ELSE
           K:SUMMA_P += summa_P
           PUT(K_TABLE)
        .
        summa_PR = 0
        summa_TA = 0
        summa_PA = 0
        clear(nol:record)
        nol:U_nr=pav:U_nr
        set(nol:nr_key,nol:nr_key)
        LOOP
           NEXT(NOLIK)
           IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
            case GETNOM_K(NOL:NOMENKLAT,0,16)
            of 'P'
               summa_PR+=calcsum(4,2)    !VALÛTÂ AR PVN - A
            of 'T'
               summa_TA+=calcsum(4,2)
            else
               summa_PA+=calcsum(4,2)
            .
!            SUMMA_X=GETNOM_K(NOL:NOMENKLAT,0,7)*NOL:DAUDZUMS
            IF NOL:DAUDZUMS<0  !ATGRIEZTA PRECE
                DAUDZUMS_R += NOL:DAUDZUMS
                SUMMA_R    += CALCSUM(16,2)  !Ls AR PVN-A
            .
        .
        summa_PRK += summa_PR*BANKURS(PAV:VAL,PAV:DATUMS)
        summa_TAK += summa_TA*BANKURS(PAV:VAL,PAV:DATUMS)
        summa_PAK += summa_PA*BANKURS(PAV:VAL,PAV:DATUMS)
        DOK_NR=PAV:DOK_SENR
        IF ~F:DTK
          IF F:DBF='W'
            PRINT(RPT:DETAIL)
          ELSIF F:DBF='E'
            OUTA:LINE=format(NPK,@n_4)&CHR(9)&FORMAT(PAV:DATUMS,@D10.)&CHR(9)&format(DOK_NR,@s10)&CHR(9)&format(PAV:PAMAT,@s40)&CHR(9)&format(SUMMA_P,@N-_14.2)&CHR(9)&PAV:VAL&CHR(9)&format(SUMMA_PR,@N-_14.2)&CHR(9)&PAV:VAL&CHR(9)&format(SUMMA_TA,@N-_13.2)&CHR(9)&PAV:VAL&CHR(9)&format(SUMMA_PA,@N-_13.2)&CHR(9)&PAV:VAL
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE=format(NPK,@n_4)&CHR(9)&FORMAT(PAV:DATUMS,@D6)&CHR(9)&format(DOK_NR,@s10)&CHR(9)&format(PAV:PAMAT,@s40)&CHR(9)&format(SUMMA_P,@N-_14.2)&CHR(9)&PAV:VAL&CHR(9)&format(SUMMA_PR,@N-_14.2)&CHR(9)&PAV:VAL&CHR(9)&format(SUMMA_TA,@N-_13.2)&CHR(9)&PAV:VAL&CHR(9)&format(SUMMA_PA,@N-_13.2)&CHR(9)&PAV:VAL
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
        PRINT(RPT:RPT_FOOT1)
    ELSE
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
    END
!**************************** DRUKÂJAM KOPÂ Ls UN PÇC valûtâm **************
    KOPA='Kopâ:'
    VALK = 'Ls'
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSIF F:DBF='E'
        OUTA:LINE=format(KOPA,@S20)&CHR(9)&'  '&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_PK,@N-_14.2)&CHR(9)&VALK&CHR(9)&format(SUMMA_PRK,@N-_14.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAK,@N-_13.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAK,@N-_13.2)
        ADD(OUTFILEANSI)
    ELSE
        OUTA:LINE=format(KOPA,@S20)&CHR(9)&'  '&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_PK,@N-_14.2)&CHR(9)&VALK&CHR(9)&format(SUMMA_PRK,@N-_14.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAK,@N-_13.2)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAK,@N-_13.2)
        ADD(OUTFILEANSI)
    END
    SUMMA_PK  = 0
    summa_PRK = 0
    summa_TAK = 0
    summa_PAK = 0
!    KOPA = 't.s.'
!    GET(K_TABLE,0)
!    LOOP J# = 1 TO RECORDS(K_TABLE)
!       GET(K_TABLE,J#)
!       IF K:SUMMA_P <> 0
!         SUMMA_PK = K:SUMMA_P
!         VALK=K:VAL
!         IF F:DBF='W'
!             PRINT(RPT:RPT_FOOT2)
!         ELSIF F:DBF='E'
!             OUTA:LINE=format(KOPA,@S20)&CHR(9)&'  '&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_PK,@N-_14.2)&CHR(9)&VALK&CHR(9)&format(SUMMA_PRK,@N-_14.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAK,@N-_13.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAK,@N-_13.2B)
!             ADD(OUTFILEANSI)
!         ELSE
!             OUTA:LINE=format(KOPA,@S20)&CHR(9)&'  '&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_PK,@N-_14.2)&CHR(9)&VALK&CHR(9)&format(SUMMA_PRK,@N-_14.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAK,@N-_13.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAK,@N-_13.2B)
!             ADD(OUTFILEANSI)
!         END
!         kopa=''
!       .
!    .
    IF DAUDZUMS_R
         VALK      = 'Ls'
         SUMMA_PK  = SUMMA_R
         KOPA      = 't.s. Atgrieztâ prece'
         SUMMA_PRK = 0
         IF F:DBF='W'
             PRINT(RPT:RPT_FOOT2)
         ELSIF F:DBF='E'
             OUTA:LINE=format(KOPA,@S20)&CHR(9)&'  '&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_PK,@N-_14.2)&CHR(9)&VALK&CHR(9)&format(SUMMA_PRK,@N-_14.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAK,@N-_13.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAK,@N-_13.2B)
             ADD(OUTFILEANSI)
         ELSE
             OUTA:LINE=format(KOPA,@S20)&CHR(9)&'  '&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_PK,@N-_14.2)&CHR(9)&VALK&CHR(9)&format(SUMMA_PRK,@N-_14.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_TAK,@N-_13.2B)&CHR(9)&'   '&CHR(9)&format(SUMMA_PAK,@N-_13.2B)
             ADD(OUTFILEANSI)
         END
    END
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT3)
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
  IF ERRORCODE() OR ~(PAV:PAR_NR=PAR_NR)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
    END
    LocalResponse = RequestCancelled
    EXIT
  ELSE
    LocalResponse = RequestCompleted
  END
  RecordsProcessed += BYTES(PAVAD)
  RecordsThisCycle += BYTES(PAVAD)
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
N_IzgKons            PROCEDURE                    ! Declare Procedure
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
DOK_NR               STRING(10)
NOS_P                STRING(60)
TIP                  STRING(5)
NOL_TEX              STRING(40)
PROJEKTS             STRING(50)
NR                   DECIMAL(4)
RPT_NR               DECIMAL(4)
NOS                  STRING(3)
KOPA                 STRING(7)
SUMMAK               DECIMAL(14,2)
SUMMA_R              DECIMAL(14,2)
NOSK                 STRING(3)
DAT                  DATE
LAI                  TIME
V1                   STRING(1)
V2                   STRING(1)
CN                   STRING(10)
CP                   STRING(3)
SAV_PAR_NR           ULONG
K_TABLE              QUEUE,PRE(K)
NOS                    STRING(3)
SUMMA                  DECIMAL(14,2)
                     .

VIRSRAKSTS          STRING(100)
FILTRS_TEXT          STRING(100)
LINEH                STRING(190)
!-----------------------------------------------------------------------
report REPORT,AT(198,1750,8000,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,198,8000,1552),USE(?unnamed:2)
         STRING(@s100),AT(135,729,6927,260),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IZ5'),AT(7063,688,656,198),USE(?String8),RIGHT(1),FONT(,8,,,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7146,854,573,156),PAGENO,USE(?PageCount),RIGHT(1),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(156,1042,7604,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(573,1042,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(5052,1042,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('NPK'),AT(198,1094,365,208),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu saòçmçjs'),AT(1406,1094,1719,208),USE(?String11:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Realizçts'),AT(5094,1094,729,208),USE(?String11:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6615,1042,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Jâapmaksâ'),AT(5875,1094,729,208),USE(?String11:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Norçíinu'),AT(6656,1094,1094,208),USE(?String11:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7760,1042,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         STRING('Dok. Nr'),AT(615,1094,729,208),USE(?String11:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1354,1042,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('summa'),AT(6656,1302,1094,208),USE(?String11:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Tips:'),AT(4167,1094,365,208),USE(?String11:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(3646,1094,417,208),USE(PAR_grupa),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5833,1042,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(156,1510,7604,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Grupa :'),AT(3177,1094,417,208),USE(?String11:3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1042,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s110),AT(156,417,6927,260),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(4531,1094,417,208),USE(PAR_TIPS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1365,104,4427,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         STRING(@N_4),AT(208,10,313,156),USE(RPT_NR),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(573,-10,0,198),USE(?Line9),COLOR(COLOR:Black)
         STRING(@s60),AT(1458,10,3594,156),USE(NOS_P),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5052,-10,0,198),USE(?Line9:2),COLOR(COLOR:Black)
         STRING(@D06.),AT(5156,10,,156),USE(PAV:DATUMS),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@D06.),AT(5938,10,,156),USE(PAV:C_DATUMS),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(7500,10,260,156),USE(NOS),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7760,-10,0,198),USE(?Line9:7),COLOR(COLOR:Black)
         STRING(@s10),AT(625,10,677,156),USE(DOK_NR),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(1354,-10,0,198),USE(?Line9:5),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6667,10,781,156),USE(PAV:C_SUMMA),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6615,-10,0,198),USE(?Line9:3),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,198),USE(?Line9:4),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line8),COLOR(COLOR:Black)
       END
RPT_line DETAIL,AT(,,,52)
         LINE,AT(156,0,0,50),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(573,0,0,50),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(1354,0,0,50),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(5052,0,0,50),USE(?Line215),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,50),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(6615,0,0,50),USE(?Line16:2),COLOR(COLOR:Black)
         LINE,AT(7760,0,0,50),USE(?Line17:2),COLOR(COLOR:Black)
         LINE,AT(156,25,7604,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed)
         LINE,AT(156,-10,0,198),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(6615,-10,0,198),USE(?Line20:2),COLOR(COLOR:Black)
         STRING(@s3),AT(7500,10,260,156),USE(NOSK,,?NOSK:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s7),AT(625,21,521,156),USE(KOPA,,?KOPA:2),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7760,-10,0,198),USE(?Line20:3),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,198),USE(?Line20:5),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,198),USE(?Line20:4),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6667,10,781,156),USE(SUMMA_R),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5052,-10,0,198),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,198),USE(?Line120:2),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,406),USE(?unnamed:3)
         LINE,AT(156,-10,0,218),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,218),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,218),USE(?Line24:3),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,218),USE(?Line24:2),COLOR(COLOR:Black)
         LINE,AT(6615,-10,0,218),USE(?Line125:2),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6667,10,781,156),USE(SUMMAK),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7500,10,260,156),USE(NOSK),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5833,-10,0,218),USE(?Line125),COLOR(COLOR:Black)
         LINE,AT(7760,-10,0,218),USE(?Line26:2),COLOR(COLOR:Black)
         LINE,AT(156,208,7604,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@s7),AT(625,10,521,156),USE(KOPA),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Sastâdîja :'),AT(260,229,490,167),USE(?String26),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(740,229,500,167),USE(ACC_kods),LEFT,FONT(,7,,)
         STRING('RS :'),AT(1563,229,229,167),USE(?String28),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1792,229,208,167),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@d06.),AT(6771,250),USE(dat),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(7323,250),USE(lai),FONT(,7,,,CHARSET:BALTIC)
       END
       FOOTER,AT(198,11050,8000,63)
         LINE,AT(156,0,7604,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!  Tikai tâs P/Z, kurâm konsignâcijas datums inrange s_dat,b_dat
!
!
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
  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('V1',V1)
  BIND('V2',V2)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOL',CYCLENOL)
  I# = 0
  C#=0
  DONE# = 0                                      !TURN OFF DONE FLAG
  NR#     = 0
  DAT = TODAY()
  LAI = CLOCK()
  D_K = 'K'
  V1='2'
  V2='3'
  FIRST#=1
  FP#=FALSE
!!  NOL_TEX = FORMAT_NOLTEX25()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(NOL:RECORD)
  BIND(PAV:RECORD)
  BIND(PAR:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Completed'
  ProgressWindow{Prop:Text} = 'Generating Report'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'P10011'
      CP = 'P11'
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
      LOOP I#=1 TO 25
         IF NOL_NR25[I#]
            IF ~FIRST_ONE#
               FIRST_ONE#=I#
            ELSE
               SECOND_ONE#=I#    !PIEPRASÎTA VAIRÂK KÂ 1 NOLIKTAVA
               BREAK
            .
         .
      .
      PAV:D_K=D_K
      SET(PAV:PAR_KEY)
      Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLEPAR_K(CP) AND (PAV:APM_V=V1 OR PAV:APM_V=V2) AND INRANGE(PAV:C_DATUMS,S_DAT,B_DAT)'
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
          IF ~OPENANSI('IZGKONS.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT&' NOLIKTAVA: '&LOC_NR
          ADD(OUTFILEANSI)
          OUTA:LINE='NORÇÍINU SUMMAS PAR IZGÂJUÐAJÂM KONSIGNÂCIJAS/PÇCAPMAKSAS PRECÇM'
          ADD(OUTFILEANSI)
          IF F:DBF='E'
              OUTA:LINE=format(S_DAT,@d10.)&' LÎDZ '&format(B_DAT,@d10.)&' '&PROJEKTS
              ADD(OUTFILEANSI)
          ELSE
              OUTA:LINE=format(S_DAT,@d6)&' LÎDZ '&format(B_DAT,@d6)&' '&PROJEKTS
              ADD(OUTFILEANSI)
          END
          OUTA:LINE='Grupa: '&PAR_GRUPA&' Tips: '&PAR_TIPS
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
          OUTA:LINE=' Npk'&CHR(9)&'Dok.Numurs'&CHR(9)&'Preèu saòçmçjs {46}'&CHR(9)&' Realizçts'&CHR(9)&' Jâapmaksâ'&CHR(9)&'Norçíinu summa'
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nr#+=1
        ?Progress:UserString{Prop:Text}=NR#
        DISPLAY(?Progress:UserString)
        IF FIRST#
          SAV_PAR_NR=PAV:PAR_NR
          FIRST#=0
        .
        IF ~(SAV_PAR_NR=PAV:PAR_NR)
          IF RECORDS(K_TABLE)
            IF F:DBF='W'
              PRINT(RPT:RPT_LINE)                           !
            ELSE
              OUTA:LINE=LINEH
              ADD(OUTFILEANSI)
            END
            KOPA = 'Kopâ'
            LOOP J#=1 TO RECORDS(K_TABLE)
              GET(K_TABLE,J#)
              IF K:SUMMA
                SUMMA_R = K:SUMMA
                NOSK  = K:NOS
                IF F:DBF='W'
                  PRINT(RPT:RPT_FOOT2)
                ELSIF F:DBF='E'
                  OUTA:LINE=' {4}'&CHR(9)&' {10}'&CHR(9)&' {60}'&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&format(SUMMA_R,@n-_14.2)&CHR(9)&NOSK
                  ADD(OUTFILEANSI)
                ELSE
                  OUTA:LINE=' {4}'&CHR(9)&' {10}'&CHR(9)&' {60}'&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&format(SUMMA_R,@n-_14.2)&CHR(9)&NOSK
                  ADD(OUTFILEANSI)
                END
                KOPA = ''
              .
            .
            IF F:DBF='W'
              PRINT(RPT:RPT_LINE)
            ELSE
              OUTA:LINE=LINEH
              ADD(OUTFILEANSI)
            END
            FREE(K_TABLE)
            RPT_NR = 0
            SUMMAK += SUMMA_R
            SUMMA_R = 0
          .
          SAV_PAR_NR = PAV:PAR_NR
          FP#=TRUE
        .
        IF INRANGE(PAV:C_DATUMS,S_DAT,B_DAT)
          IF F:ATL[2]='1' OR PAV:C_SUMMA             ! Iekïaut 0-es parâdus vai parâds~0
             NOS_P=GETPAR_K(PAV:PAR_NR,2,1)&' '&CLIP(PAR:ADRESE)
             RPT_NR += 1
             DOK_NR=PAV:DOK_SENR
             IF ~F:DTK
                 IF F:DBF='W'
                     PRINT(RPT:DETAIL)
                 ELSIF F:DBF='E'
                     OUTA:LINE=format(RPT_NR,@N_4)&CHR(9)&format(DOK_NR,@s10)&CHR(9)&format(NOS_P,@s60)&CHR(9)&FORMAT(PAV:DATUMS,@D10.)&CHR(9)&FORMAT(PAV:C_DATUMS,@D10.)&CHR(9)&format(PAV:C_SUMMA,@N-_14.2)&CHR(9)&NOS
                     ADD(OUTFILEANSI)
                 ELSE
                     OUTA:LINE=format(RPT_NR,@n_4)&CHR(9)&format(DOK_NR,@s10)&CHR(9)&format(NOS_P,@s60)&CHR(9)&FORMAT(PAV:DATUMS,@D6)&CHR(9)&FORMAT(PAV:C_DATUMS,@D6)&CHR(9)&format(PAV:C_SUMMA,@N-_14.2)&CHR(9)&NOS
                     ADD(OUTFILEANSI)
                 END
             END
             FP#=FALSE
             GET(K_TABLE,0)
             K:NOS=PAV:VAL
             GET(K_TABLE,K:NOS)
             IF ERROR()
               K:NOS=PAV:VAL
               K:SUMMA =PAV:C_SUMMA
               add(K_TABLE)
               SORT(K_TABLE,K:NOS)
             ELSE
               K:SUMMA += PAV:C_SUMMA
               PUT(K_TABLE)
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
    IF FP#=FALSE
      IF F:DBF='W'
        PRINT(RPT:RPT_line)
      ELSE
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
      END
      KOPA = 'Kopâ'
      LOOP J# = 1 TO RECORDS(K_TABLE)
        GET(K_TABLE,J#)
        IF K:SUMMA > 0
          SUMMA_R = K:SUMMA
          NOSK  = K:NOS
          IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)                      !PRINT GRAND TOTALS
          ELSIF F:DBF='E'
            OUTA:LINE=' {4}'&CHR(9)&' {10}'&CHR(9)&' {60}'&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&format(SUMMA_R,@n-_14.2)&CHR(9)&NOSK
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE=' {4}'&CHR(9)&' {10}'&CHR(9)&' {60}'&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&format(SUMMA_R,@n-_14.2)&CHR(9)&NOSK
            ADD(OUTFILEANSI)
          END
          kopa=''
        .
      .
      IF F:DBF='W'
        PRINT(RPT:RPT_line)
      ELSE
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
      END
      FREE(K_TABLE)
      RPT_NR = 0
      SUMMAK += SUMMA_R
      SUMMA_R = 0
    .
    IF F:DBF='W'
      KOPA = 'Pavisam'
      PRINT(RPT:RPT_FOOT3)
      ENDPAGE(report)
    ELSIF F:DBF='E'
      OUTA:LINE=LINEH
      ADD(OUTFILEANSI)
      OUTA:LINE=FORMAT(KOPA,@S6)&CHR(9)&'  '&CHR(9)&' {60}'&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&format(SUMMAK,@n-_14.2)&CHR(9)&NOSK
      ADD(OUTFILEANSI)
    ELSE
      OUTA:LINE=LINEH
      ADD(OUTFILEANSI)
      OUTA:LINE=FORMAT(KOPA,@S6)&CHR(9)&'  '&CHR(9)&' {60}'&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&format(SUMMAK,@n-_14.2)&CHR(9)&NOSK
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
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
