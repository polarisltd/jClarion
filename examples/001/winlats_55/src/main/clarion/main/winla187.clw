                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_IenNomR            PROCEDURE                    ! Declare Procedure
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
NR                  DECIMAL(4)
RPT_NOMENKLAT       STRING(21)
RPT_KODS            DECIMAL(13)
NOSAUKUMS           STRING(40)
DAUDZUMS            DECIMAL(12,3)
DAUDZUMSK           DECIMAL(14,3)
SUMMA_B             DECIMAL(12,2)
SUMMA_BK            DECIMAL(12,2)
SUMMA_PVN           DECIMAL(10,2)
SUMMA_PVNK          DECIMAL(10,2)
SUMMA_P             DECIMAL(13,2)
SUMMA_PK            DECIMAL(14,2)
SUMMA_X             DECIMAL(13,2)
SUMMA_XK            DECIMAL(14,2)
MER                  STRING(7)
MERVIEN              STRING(7)
CENA                 DECIMAL(12,2)
NOS                  STRING(3)
KOPA                 STRING(7)
VALK                 STRING(3)
NOS_P                STRING(11)
DAT                  DATE
LAI                  TIME
CN                   STRING(10)
CP                   STRING(3)

N_TABLE              QUEUE,PRE(N)
NOMENKLAT              STRING(21)
DAUDZUMS               DECIMAL(12,3)
CENA                   DECIMAL(12,2)
SUMMA_P                DECIMAL(13,2)
SUMMA_B                DECIMAL(12,2)
SUMMA_X                DECIMAL(13,2)
PVN                    DECIMAL(12,2)
VAL                    STRING(3)
                     .
K_TABLE              QUEUE,PRE(K)
VAL                    STRING(3)
SUMMA_P                DECIMAL(13,2)
                     .
ATLIKUMS             DECIMAL(12,3)
VIRSRAKSTS           STRING(110)
FILTRS_TEXT          STRING(100)

!------------------------------------------------------------------
report REPORT,AT(300,1635,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(300,500,12000,1135),USE(?unnamed)
         STRING(@s45),AT(2729,10,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s110),AT(740,240,8375,188),USE(VIRSRAKSTS),CENTER,FONT('Arial',10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(885,438,8104,177),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IE5'),AT(9167,417,781,156),USE(?String14),LEFT
         STRING(@P<<<#. lapaP),AT(9948,417,677,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(52,625,10625,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(365,625,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2031,625,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4427,625,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5365,625,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7031,625,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(10677,625,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('NPK'),AT(104,677,260,208),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(417,677,1615,208),USE(?String17:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces nosaukums'),AT(2083,677,2344,208),USE(?String17:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(4479,677,885,208),USE(?String17:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(6250,677,781,208),USE(?String17:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6198,625,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         STRING('Cena  ('),AT(5573,677,417,208),USE(?String17:6),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(5990,677,104,208),USE(nokl_cp),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(')'),AT(6094,677,104,208),USE(?String17:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba'),AT(7083,677,781,208),USE(?String17:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN,'),AT(7917,677,781,208),USE(?String17:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7896,885,781,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba'),AT(8750,677,1042,208),USE(?String17:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba pçc'),AT(9844,677,833,208),USE(?String17:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9792,625,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(8698,625,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(7865,625,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@s21),AT(417,885,1615,208),USE(nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN,'),AT(7052,885,500,208),USE(?String17:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7563,885,302,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(8750,885,1042,208),USE(?String17:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('('),AT(9844,885,52,208),USE(?String17:11),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(9896,885,104,208),USE(nokl_cp,,?nokl_cp:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(') cenas, val.'),AT(10000,885,677,208),USE(?String17:17),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1094,10625,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(52,625,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(7031,-10,0,197),USE(?Line10:6),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,197),USE(?Line10:9),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(7917,10,729,156),USE(SUMMA_PVN),RIGHT
         LINE,AT(8698,-10,0,197),USE(?Line10:7),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(8750,10,729,156),USE(SUMMA_P),RIGHT
         STRING(@N-_12.2B),AT(7083,10,729,156),USE(SUMMA_B),RIGHT
         STRING(@s3),AT(9521,10,260,156),USE(NOS),LEFT
         LINE,AT(9792,-10,0,197),USE(?Line10:10),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(9896,10,729,156),USE(SUMMA_X),RIGHT
         LINE,AT(10677,-10,0,197),USE(?Line110:7),COLOR(COLOR:Black)
         STRING(@N_12.2),AT(5417,10,729,156),USE(CENA),RIGHT
         STRING(@N-_12.3B),AT(6250,10,729,156),USE(DAUDZUMS),RIGHT
         LINE,AT(6198,-10,0,197),USE(?Line10:8),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,197),USE(?Line10:5),COLOR(COLOR:Black)
         STRING(@N_13),AT(4479,10,833,156),USE(NOM:KODS),RIGHT
         LINE,AT(4427,-10,0,197),USE(?Line10:4),COLOR(COLOR:Black)
         STRING(@s40),AT(2063,10,2344,156),USE(noSAUKUMS),LEFT,FONT(,,,,CHARSET:BALTIC)
         LINE,AT(2031,-10,0,197),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,197),USE(?Line10:2),COLOR(COLOR:Black)
         STRING(@s21),AT(396,10,1615,156),USE(rpt_nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,-10,0,197),USE(?Line10),COLOR(COLOR:Black)
         STRING(@N_4),AT(83,10,260,156),USE(NR),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(52,0,0,114),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(365,0,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,63),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(4427,0,0,63),USE(?Line20:2),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(7031,0,0,114),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(8698,0,0,114),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(9792,0,0,114),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(10677,0,0,114),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(52,52,10625,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,114),USE(?Line123:2),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(8698,-10,0,197),USE(?Line25:2),COLOR(COLOR:Black)
         LINE,AT(9792,-10,0,197),USE(?Line25:4),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(9844,10,781,156),USE(SUMMA_XK),RIGHT
         LINE,AT(52,-10,0,197),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,197),USE(?Line25:5),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(7083,10,729,156),USE(SUMMA_BK),RIGHT
         STRING(@s7),AT(313,10,521,156),USE(KOPA),LEFT
         LINE,AT(7865,-10,0,197),USE(?Line125:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(7917,10,729,156),USE(SUMMA_PVNK),RIGHT
         STRING(@N-_13.2B),AT(8750,10,729,156),USE(SUMMA_PK),RIGHT
         STRING(@s3),AT(9531,10,260,156),USE(VALK),LEFT
         LINE,AT(10677,-10,0,197),USE(?Line25:3),COLOR(COLOR:Black)
         STRING(@N-_14.3B),AT(6094,10,885,156),USE(DAUDZUMSK),RIGHT
       END
RPT_FOOT3 DETAIL,AT(,,,250),USE(?unnamed:2)
         LINE,AT(52,-10,0,63),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,63),USE(?Line29:2),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,63),USE(?Line129),COLOR(COLOR:Black)
         LINE,AT(8698,-10,0,63),USE(?Line219),COLOR(COLOR:Black)
         LINE,AT(9792,-10,0,63),USE(?Line219:2),COLOR(COLOR:Black)
         LINE,AT(10677,-10,0,63),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(52,52,10625,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(63,94,573,146),USE(?String43),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(635,94,677,146),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1625,94,260,146),USE(?String45),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1885,94,156,146),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(9563,94),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10208,94),USE(lai),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(300,7880,12000,63)
         LINE,AT(52,0,10625,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!******************* izziòa par V/K piegâdâtâm precçm RC
  PUSHBIND

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(PAVAD,1)
!!  CHECKOPEN(TEK_K,1)
  CHECKOPEN(BANKAS_K,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)

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
  BIND(PAV:RECORD)
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
  ProgressWindow{Prop:Text} = 'Ienâkuðâs RC'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='Izziòa par ienâkuðâm ('&D_K&',S-nomenkl.) precçm RC no '&format(S_DAT,@d06.)&' lîdz '&format(B_DAT,@d06.)&|
      ' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      IF PAR_NR = 999999999 !VISI
         FILTRS_TEXT=GETFILTRS_TEXT('001110000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
      ELSE
         FILTRS_TEXT=GETFILTRS_TEXT('000010000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' '&GETPAR_K(PAR_NR,2,2)
      .
      IF ~(PAR_NR = 999999999) !KONKRÇTS PARTNERIS
         CN = 'N1001'
         CLEAR(nol:RECORD)                              
         NOL:PAR_NR = PAR_NR
         NOL:DATUMS = s_dat
         NOL:D_K = D_K
         SET(nol:PAR_KEY,NOL:PAR_KEY)
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT)'
      ELSE
         CN = 'N1001'
         CP = 'N11'
         CLEAR(nol:RECORD)
         NOL:DATUMS = s_dat
         NOL:D_K    = D_K
         SET(nol:DAT_KEY,NOL:DAT_KEY)
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT) AND ~CYCLEPAR_K(CP)'
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
          IF ~OPENANSI('IENNOMR.TXT')
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
!             OUTA:LINE='Npk '&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Kods'&CHR(9)&'Cena('&nokl_cp&')'&|
!             CHR(9)&'Daudzums'&CHR(9)&'Vçrtîba bez'&CHR(9)&'PVN, Ls'&CHR(9)&'Pçc pavadzîmes'&CHR(9)&CHR(9)&|
!             'Vçrtîba pçc'&CHR(9)&'Atlikums'
             OUTA:LINE='Npk '&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Kods'&CHR(9)&'Cena('&nokl_cp&')'&|
             CHR(9)&'Daudzums'&CHR(9)&'Vçrtîba bez'&CHR(9)&'PVN, EUR'&CHR(9)&'Pçc pavadzîmes'&CHR(9)&CHR(9)&|
             'Vçrtîba pçc'&CHR(9)&'Atlikums'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&NOMENKLAT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PVN, EUR'&CHR(9)&CHR(9)&'ar PVN, valûtâ'&|
             CHR(9)&CHR(9)&NOKL_CP&'. cenas bez PVN'
             ADD(OUTFILEANSI)
          ELSE
!             OUTA:LINE='Npk '&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Kods'&CHR(9)&'Cena('&nokl_cp&')'&|
!             CHR(9)&'Daudzums'&CHR(9)&'Vçrtîba bez PVN, Ls'&CHR(9)&'PVN, Ls'&CHR(9)&'Pçc pavadzîmes,ar PVN, valûtâ'&CHR(9)&CHR(9)&|
!             'Vçrtîba pçc'&NOKL_CP&'. cenas bez PVN'&CHR(9)&'Atlikums'
             OUTA:LINE='Npk '&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Kods'&CHR(9)&'Cena('&nokl_cp&')'&|
             CHR(9)&'Daudzums'&CHR(9)&'Vçrtîba bez PVN, EUR'&CHR(9)&'PVN, EUR'&CHR(9)&'Pçc pavadzîmes,ar PVN, valûtâ'&CHR(9)&CHR(9)&|
             'Vçrtîba pçc'&NOKL_CP&'. cenas bez PVN'&CHR(9)&'Atlikums'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        npk#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        C#=GETPAR_K(NOL:PAR_NR,2,1)
        G#=GETPAVADZ(NOL:U_NR)
        C#=GETNOM_K(NOL:NOMENKLAT,2,1)
        EXECUTE NOKL_CP         !!!SYS:NOKL_CP <-> NOKL_CP
          CENA = NOM:REALIZ[1]
          CENA = NOM:REALIZ[2]
          CENA = NOM:REALIZ[3]
          CENA = NOM:REALIZ[4]
          CENA = NOM:REALIZ[5]
          CENA = NOM:PIC
        .
!!        stop('Cena = '&cena)
        EXECUTE NOKL_CP         !!!SYS:NOKL_CP <->NOKL_CP
          NOS = NOM:VAL[1]
          NOS = NOM:VAL[2]
          NOS = NOM:VAL[3]
          NOS = NOM:VAL[4]
          NOS = NOM:VAL[5]
          !18/12/2013 NOS = 'Ls'
          NOS = val_uzsk
        .
!!        STOP('NOS = '&NOS)
        !18/12/2013 IF ~NOS THEN NOS = 'Ls'.
        IF ~NOS THEN NOS = val_uzsk.
!!        IF ~(NOS='Ls' OR NOS='LS')
        SUMMA_PK   += CALCSUM(16,2)         ! AR PVN Ls
        SUMMA_BK   += CALCSUM(15,2)         ! BEZ PVN Ls
        SUMMA_PVNK += CALCSUM(17,2)         ! PVN Ls
        SUMMA_XK   += NOL:DAUDZUMS*CENA*BANKURS(CLIP(NOS),TODAY())
!!        ELSE
!!          SUMMA_PK += CENA*nol:daudzums
!!        .
        GET(K_TABLE,0)
        K:VAL=NOS
        GET(K_TABLE,K:VAL)
        IF ERROR()
          K:VAL     = NOS
          K:SUMMA_P = CALCSUM(4,2)
          ADD(K_TABLE,K:VAL)
          SORT(K_TABLE,K:VAL)
        ELSE
          K:SUMMA_P += CALCSUM(4,2)
          PUT(K_TABLE)
        .
!*************************SADALAM PÇC NOMENKLATÛRÂM ********
        GET(N_TABLE,0)
        N:NOMENKLAT=NOL:NOMENKLAT
        GET(N_TABLE,N:NOMENKLAT)
        IF ERROR()
          N:NOMENKLAT = NOL:NOMENKLAT
          N:DAUDZUMS  = NOL:DAUDZUMS
          N:CENA      = CENA
          N:SUMMA_P   = CALCSUM(4,2)
          N:SUMMA_B   = CALCSUM(15,2)
          N:SUMMA_X   = NOL:DAUDZUMS*CENA
          N:PVN       = CALCSUM(17,2)
          N:VAL       = NOS
          ADD(N_TABLE)
          SORT(N_TABLE,N:NOMENKLAT)
        ELSE
          N:DAUDZUMS += NOL:DAUDZUMS
          N:SUMMA_P  += CALCSUM(4,2)
          N:SUMMA_B  += CALCSUM(15,2)
          N:SUMMA_X  += NOL:DAUDZUMS*CENA
          N:PVN      += CALCSUM(17,2)
          PUT(N_TABLE)
        .
        COUNT# += 1
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
      NOSAUKUMS     = GETNOM_K(N:NOMENKLAT,2,2)
      MERVIEN       = NOM:MERVIEN
      NR           += 1
      RPT_NOMENKLAT = N:NOMENKLAT
      DAUDZUMS      = N:DAUDZUMS
      CENA          = N:CENA
      SUMMA_P       = N:SUMMA_P
      SUMMA_B       = N:SUMMA_B
      SUMMA_X       = N:SUMMA_X
      SUMMA_PVN     = N:PVN
      DAUDZUMSK    += DAUDZUMS
      IF ~F:DTK
        ATLIKUMS=GETNOM_A(N:NOMENKLAT,1,0)

        IF F:CEN  !NEDRUKÂT IEPIRKUMA CENAS
           SUMMA_P   =0
           SUMMA_PK  =0
           SUMMA_B   =0
           SUMMA_BK  =0
           SUMMA_PVN =0
           SUMMA_PVNK=0
        .
        IF F:DBF='W'
          PRINT(RPT:DETAIL)
        ELSE
          OUTA:LINE=NR&CHR(9)&RPT_NOMENKLAT&CHR(9)&NOSAUKUMS&CHR(9)&NOM:KODS&CHR(9)&|
          LEFT(format(CENA,@N-_12.2))&CHR(9)&LEFT(format(DAUDZUMS,@N-_12.3))&CHR(9)&LEFT(format(SUMMA_B,@N-_12.2))&|
          CHR(9)&LEFT(format(SUMMA_PVN,@N-_12.2))&CHR(9)&LEFT(format(SUMMA_P,@N-_13.2))&CHR(9)&NOS&CHR(9)&|
          LEFT(format(SUMMA_X,@N-_13.2))&CHR(9)&LEFT(format(ATLIKUMS,@N-_12.3))
          ADD(OUTFILEANSI)
        .
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
        OUTA:LINE=format(KOPA,@s7)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DAUDZUMSk,@N-_14.3))&CHR(9)&|
        LEFT(format(SUMMA_Bk,@N-_12.2))&CHR(9)&LEFT(format(SUMMA_PVNk,@N-_12.2))&CHR(9)&LEFT(format(SUMMA_Pk,@N-_13.2))&|
        CHR(9)&VALK&CHR(9)&LEFT(format(SUMMA_Xk,@N-_13.2))
        ADD(OUTFILEANSI)
    .
    DAUDZUMSK  = 0
    SUMMA_BK   = 0
    SUMMA_PVNK = 0
    SUMMA_XK   = 0
    KOPA='t.s.'
    IF ~F:CEN  !~NEDRUKÂT IEPIRKUMA CENAS
       GET(K_TABLE,0)
       LOOP J# = 1 TO RECORDS(K_TABLE)
         GET(K_TABLE,J#)
         IF K:SUMMA_P <>0
           SUMMA_PK = K:SUMMA_P
           VALK     = K:VAL
           IF F:DBF='W'
               PRINT(RPT:RPT_FOOT2)
           ELSE
               OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DAUDZUMSk,@N-_14.3))&CHR(9)&|
               LEFT(format(SUMMA_Bk,@N-_12.2))&CHR(9)&LEFT(format(SUMMA_PVNk,@N-_12.2))&CHR(9)&|
               LEFT(format(SUMMA_Pk,@N-_13.2))&CHR(9)&VALK&CHR(9)&LEFT(format(SUMMA_Xk,@N-_13.2))
               ADD(OUTFILEANSI)
           .
           kopa=''
         .
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
  NEXT(Process:View)
  IF ~(PAR_NR=999999999)                 !KONKRÇTS PARTNERIS
     IF ~(NOL:PAR_NR=PAR_NR) THEN VISS#=TRUE.
  .
  IF ERRORCODE() OR NOL:DATUMS>B_DAT THEN VISS#=TRUE.
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
N_IenNomRP           PROCEDURE                    ! Declare Procedure
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
NR                   DECIMAL(4)
RPT_NOMENKLAT        STRING(21)
NOSAUKUMS            STRING(20)
DAUDZUMS             DECIMAL(12,3)
DAUDZUMSK            DECIMAL(14,3)
CENA                 DECIMAL(12,2)
SUMMA_P              DECIMAL(13,2)
SUMMA_PK             DECIMAL(13,2)
SUMMA_B              DECIMAL(12,2)
SUMMA_BK             DECIMAL(12,2)
SUMMA_PVN            DECIMAL(10,2)
SUMMA_PVNK           DECIMAL(10,2)
SUMMA_X              DECIMAL(13,2)
SUMMA_XK             DECIMAL(13,2)
NOS                  STRING(3)
MER                  STRING(7)
MERVIEN              STRING(7)
KOPA                 STRING(8)
VALK                 STRING(3)
NOS_P                STRING(35)
DAT                  DATE
LAI                  TIME
CN                   STRING(10)
CP                   STRING(1)
N_TABLE              QUEUE,PRE(N)
NOMENKLAT              STRING(21)
DAUDZUMS               DECIMAL(12,3)
CENA                   DECIMAL(12,2)
SUMMA_P                DECIMAL(13,2)
SUMMA_B                DECIMAL(12,2)
SUMMA_X                DECIMAL(13,2)
PVN                    DECIMAL(10,2)
VAL                    STRING(3)
                     .
K_TABLE              QUEUE,PRE(K)
VAL                    STRING(3)
SUMMA_P                DECIMAL(13,2)
                     .
!DBFFILE           FILE,PRE(DBF),DRIVER('dBase3'),CREATE,NAME(FILENAME1)
!RECORD              RECORD
!nomenklat             STRING(15)
!MERVIEN               STRING(7)
!NOS_P                 STRING(30)
!daudzums              STRING(@N-_11.3)
!CENA                  STRING(@N-_12.2)
!SUMMA                 STRING(@N-_12.2)
!NOS                   STRING(3)
!                  . .
LINEH               STRING(190)

!------------------------------------------------------------------
report REPORT,AT(300,1667,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(300,500,12000,1167),USE(?unnamed)
         STRING(@s45),AT(2469,156,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktava :'),AT(7000,156,885,260),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(7885,156,260,260),USE(LOC_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Izziòa par ienâkuðâm ('),AT(260,417,1667,260),USE(?String2:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(1927,417,156,260),USE(d_k),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(6146,417,781,260),USE(s_dat),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(6927,417,156,260),USE(?String2:4),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(7083,417,781,260),USE(b_dat),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IE5K'),AT(8854,313,781,156),USE(?String14),RIGHT
         STRING(@P<<<#. lapaP),AT(8958,469,677,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(52,677,9635,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(365,677,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2031,677,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(3385,677,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4323,677,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5990,677,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(9688,677,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('NPK'),AT(83,729,260,208),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(396,729,1615,208),USE(?String17:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces nosaukums'),AT(2063,729,1302,208),USE(?String17:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(3417,729,885,208),USE(?String17:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(5188,729,781,208),USE(?String17:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5156,677,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         STRING('Cena  ('),AT(4531,729,417,208),USE(?String17:6),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(4948,729,104,208),USE(nokl_cp),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(')'),AT(5052,729,104,208),USE(?String17:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba'),AT(6021,729,781,208),USE(?String17:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, Ls'),AT(6854,729,677,208),USE(?String17:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8646,677,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(7552,677,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(6823,677,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Vçrtîba'),AT(7583,729,1042,208),USE(?String17:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba'),AT(8677,729,990,208),USE(?String17:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(396,938,1615,208),USE(nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING('(saîsinâtais)'),AT(2063,938,1302,208),USE(?String17:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(7583,938,1042,208),USE(?String17:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc ('),AT(8750,938,313,208),USE(?String17:14),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(9063,938,104,208),USE(nokl_cp,,?nokl_cp:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(') cenas'),AT(9167,938,469,208),USE(?String17:16),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN, Ls'),AT(6021,938,781,208),USE(?String17:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1146,9635,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(52,677,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(') precçm RC :'),AT(2083,417,1094,260),USE(?String2:3),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(3177,417,3021,260),USE(NOS_P),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(5990,-10,0,197),USE(?Line10:6),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(7604,10,729,156),USE(SUMMA_P),RIGHT
         STRING(@s3),AT(8385,10,260,156),USE(NOS),LEFT
         LINE,AT(8646,-10,0,197),USE(?Line10:10),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,197),USE(?Line10:11),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,197),USE(?Line10:7),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(6042,10,729,156),USE(SUMMA_B),RIGHT
         LINE,AT(7552,-10,0,197),USE(?Line10:9),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(6875,10,625,156),USE(SUMMA_PVN),RIGHT
         LINE,AT(5156,-10,0,197),USE(?Line10:8),COLOR(COLOR:Black)
         STRING(@N_12.2),AT(4375,10,729,156),USE(CENA),RIGHT
         STRING(@N-_12.3B),AT(5208,10,729,156),USE(DAUDZUMS),RIGHT
         LINE,AT(4323,-10,0,197),USE(?Line10:5),COLOR(COLOR:Black)
         STRING(@N_13),AT(3438,10,833,156),USE(NOM:KODS),RIGHT
         STRING(@N-_13.2),AT(8750,10,781,156),USE(SUMMA_X),RIGHT
         LINE,AT(3385,-10,0,197),USE(?Line10:4),COLOR(COLOR:Black)
         STRING(@s20),AT(2104,10,1250,156),USE(nom:nos_s),LEFT,FONT(,,,,CHARSET:BALTIC)
         LINE,AT(2031,-10,0,197),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,197),USE(?Line10:2),COLOR(COLOR:Black)
         STRING(@s21),AT(417,10,1615,156),USE(rpt_nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,-10,0,197),USE(?Line10),COLOR(COLOR:Black)
         STRING(@N_4),AT(83,10,260,156),USE(NR),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(52,0,0,115),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(365,0,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,63),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(3385,0,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(4323,0,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(5156,0,0,63),USE(?Line21:2),COLOR(COLOR:Black)
         LINE,AT(5990,0,0,115),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,115),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(7552,0,0,115),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,115),USE(?Line213),COLOR(COLOR:Black)
         LINE,AT(9688,0,0,115),USE(?Line123),COLOR(COLOR:Black)
         LINE,AT(52,52,9635,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(5990,-10,0,197),USE(?Line25:2),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,197),USE(?Line25:4),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,197),USE(?Line25:3),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line25),COLOR(COLOR:Black)
         STRING(@s8),AT(104,10,573,156),USE(KOPA),LEFT
         STRING(@N-_12.2B),AT(6042,10,729,156),USE(SUMMA_BK),RIGHT
         STRING(@N-_10.2B),AT(6875,10,625,156),USE(SUMMA_PVNK),RIGHT
         STRING(@N-_13.2B),AT(7604,10,729,156),USE(SUMMA_PK),RIGHT
         STRING(@s3),AT(8385,10,260,156),USE(VALK),LEFT
         LINE,AT(8646,-10,0,197),USE(?Line125:3),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(8698,10,833,156),USE(SUMMA_XK),RIGHT
         LINE,AT(9688,-10,0,197),USE(?Line125:345),COLOR(COLOR:Black)
         STRING(@N-_14.3B),AT(5052,10,885,156),USE(DAUDZUMSk),RIGHT
       END
RPT_FOOT3 DETAIL,AT(,,,427)
         LINE,AT(52,-10,0,63),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,63),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,63),USE(?Line30:2),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,63),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,63),USE(?Line310),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,63),USE(?Line130),COLOR(COLOR:Black)
         LINE,AT(52,52,9635,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastadîja :'),AT(313,156,573,208),USE(?String43)
         STRING(@s8),AT(885,156),USE(ACC_kods),LEFT
         STRING('RS :'),AT(1615,156,260,208),USE(?String45),LEFT
         STRING(@s1),AT(1875,156),USE(RS),CENTER
         STRING(@d6),AT(7083,156),USE(dat)
         STRING(@T4),AT(8021,156),USE(lai)
       END
       FOOTER,AT(300,7900,12000,63)
         LINE,AT(52,0,9635,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!********************izziòa par konkrçta partnera piegâdâtâm precçm
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
  BIND('PAR_NR',PAR_NR)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)
!?  IF DBF
!?     FILENAME1=SUB(REPORTNAME,1,INSTRING('.',REPORTNAME,1,1))&'DBF'
!?     CHECKOPEN(DBFFILE)
!?     CLOSE(DBFFILE)
!?     OPEN(DBFFILE,18)
!?     EMPTY(DBFFILE)
!?  .
  NR = 0
  DAT = TODAY()
  DAUDZUMSK=0
  LAI = CLOCK()
!!  nos_p=par:nos_p
  NOS_P = GETPAR_K(PAR_NR,2,2)
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
      CN = 'N1011'
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
      CLEAR(nol:RECORD)                              !MAKE SURE RECORD CLEARED
      NOL:DATUMS=S_DAT
      NOL:D_K = D_K
      NOL:PAR_NR = PAR_NR
      SET(nol:PAR_KEY,NOL:PAR_KEY)                   !  POINT TO FIRST RECORD
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
          IF ~OPENANSI('IENNOMRP.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT&' NOLIKTAVA: '&LOC_NR
          ADD(OUTFILEANSI)
          IF F:DBF='E'
            OUTA:LINE='IZZIÒA PAR IENÂKUÐÂM ('&D_K&') PRECÇM /'&NOKL_CP&'. CENU '&NOS_P&' '&format(S_DAT,@d10.)&' - '&format(B_DAT,@d10.)&' GRUPA: '&PAR_GRUPA
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE='IZZIÒA PAR IENÂKUÐÂM ('&D_K&') PRECÇM /'&NOKL_CP&'. CENU '&NOS_P&' '&format(S_DAT,@d6)&' - '&format(B_DAT,@d6)&' GRUPA: '&PAR_GRUPA
            ADD(OUTFILEANSI)
          END
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
          OUTA:LINE='Npk '&CHR(9)&'Nomenklatûra {9}'&CHR(9)&'Preces Nosaukums    '&CHR(9)&'Kods {9}'&CHR(9)&'  Cena ('&nokl_cp&')  '&CHR(9)&'  Daudzums    '&CHR(9)&'Vçrtîba bez '&CHR(9)&'  PVN, Ls   '&CHR(9)&'Pçc pavadzîmes'&CHR(9)&'Vçrtîba pçc'
          ADD(OUTFILEANSI)
          OUTA:LINE=   CHR(9)&format(NOMENKLAT,@s21)&CHR(9)&'                    '&CHR(9)&' {13}'   &CHR(9)&' {12}'                 &CHR(9)&'              '&CHR(9)&'PVN, Ls     '&CHR(9)&'            '&CHR(9)&'ar PVN, valûtâ'&CHR(9)&NOKL_CP&'. cenas bez PVN'
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        npk#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        G#=GETPAVADZ(NOL:U_NR)
        C#=GETNOM_K(NOL:NOMENKLAT,2,1)
        EXECUTE NOKL_CP         !!!SYS:NOKL_CP <-> NOKL_CP
          CENA = NOM:REALIZ[1]
          CENA = NOM:REALIZ[2]
          CENA = NOM:REALIZ[3]
          CENA = NOM:REALIZ[4]
          CENA = NOM:REALIZ[5]
          CENA = NOM:PIC
        .
!!        stop('Cena = '&cena)
        EXECUTE NOKL_CP         !!!SYS:NOKL_CP <->NOKL_CP
          NOS = NOM:VAL[1]
          NOS = NOM:VAL[2]
          NOS = NOM:VAL[3]
          NOS = NOM:VAL[4]
          NOS = NOM:VAL[5]
          NOS = 'Ls'
        .
!!        STOP('NOS = '&NOS)
        IF ~NOS THEN NOS = 'Ls'.
!!        IF ~(NOS='Ls' OR NOS='LS')
        SUMMA_PK   += CALCSUM(16,2)         ! AR PVN Ls
        SUMMA_BK   += CALCSUM(15,2)         ! BEZ PVN Ls
        SUMMA_PVNK += CALCSUM(17,2)         ! PVN Ls
        SUMMA_XK   += NOL:DAUDZUMS*CENA*BANKURS(CLIP(NOS),TODAY())
!!        ELSE
!!          SUMMA_PK += CENA*nol:daudzums
!!        .
        GET(K_TABLE,0)
        K:VAL=NOS
        GET(K_TABLE,K:VAL)
        IF ERROR()
          K:VAL     = NOS
          K:SUMMA_P = CALCSUM(4,2)
          ADD(K_TABLE,K:VAL)
          SORT(K_TABLE,K:VAL)
        ELSE
          K:SUMMA_P += CALCSUM(4,2)
          PUT(K_TABLE)
        .
!*************************SADALAM PÇC NOMENKLATÛRÂM ********
        GET(N_TABLE,0)
        N:NOMENKLAT=NOL:NOMENKLAT
        GET(N_TABLE,N:NOMENKLAT)
        IF ERROR()
          N:NOMENKLAT = NOL:NOMENKLAT
          N:DAUDZUMS  = NOL:DAUDZUMS
          N:CENA      = CENA
          N:SUMMA_P   = CALCSUM(4,2)
          N:SUMMA_B   = CALCSUM(15,2)
          N:SUMMA_X   = NOL:DAUDZUMS*CENA
          N:PVN       = CALCSUM(17,2)
          N:VAL       = NOS
          ADD(N_TABLE)
          SORT(N_TABLE,N:NOMENKLAT)
        ELSE
          N:DAUDZUMS += NOL:DAUDZUMS
          N:SUMMA_P  += CALCSUM(4,2)
          N:SUMMA_B  += CALCSUM(15,2)
          N:SUMMA_X  += NOL:DAUDZUMS*CENA
          N:PVN      += CALCSUM(17,2)
          PUT(N_TABLE)
        .
        COUNT# += 1
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
      NOSAUKUMS     = GETNOM_K(N:NOMENKLAT,2,2)
      MERVIEN       = NOM:MERVIEN
      NR           += 1
      RPT_NOMENKLAT = N:NOMENKLAT
      DAUDZUMS      = N:DAUDZUMS
      CENA          = N:CENA
      SUMMA_P       = N:SUMMA_P
      SUMMA_B       = N:SUMMA_B
      SUMMA_X       = N:SUMMA_X
      SUMMA_PVN     = N:PVN
      DAUDZUMSK    += DAUDZUMS
      IF ~F:DTK
        IF F:CEN  !NEDRUKÂT IEPIRKUMA CENAS
           SUMMA_P   =0
           SUMMA_PK  =0
           SUMMA_B   =0
           SUMMA_BK  =0
           SUMMA_PVN =0
           SUMMA_PVNK=0
        .
        IF F:DBF='W'
          PRINT(RPT:DETAIL)
        ELSIF F:DBF='E'
          OUTA:LINE=format(NR,@N_4)&CHR(9)&format(RPT_NOMENKLAT,@s21)&CHR(9)&format(NOM:NOS_S,@s20)&CHR(9)&format(NOM:KODS,@N_13)&CHR(9)&format(CENA,@N_12.2)&CHR(9)&format(DAUDZUMS,@N-_14.3)&CHR(9)&format(SUMMA_B,@N_12.2)&CHR(9)&format(SUMMA_PVN,@N_12.2)&CHR(9)&format(SUMMA_P,@N_13.2)&CHR(9)&NOS&CHR(9)&format(SUMMA_X,@N_13.2)
          ADD(OUTFILEANSI)
        ELSE
          OUTA:LINE=format(NR,@N_4)&CHR(9)&format(RPT_NOMENKLAT,@s21)&CHR(9)&format(NOM:NOS_S,@s20)&CHR(9)&format(NOM:KODS,@N_13)&CHR(9)&format(CENA,@N12.2)&CHR(9)&format(DAUDZUMS,@N-_14.3)&CHR(9)&format(SUMMA_B,@N12.2)&CHR(9)&format(SUMMA_PVN,@N12.2)&CHR(9)&format(SUMMA_P,@N13.2)&CHR(9)&NOS&CHR(9)&format(SUMMA_X,@N13.2)
          ADD(OUTFILEANSI)
        END
      END
!?     IF DBF
!?        DBF:NOMENKLAT=N:NOMENKLAT
!?        DBF:MERVIEN = NOM:MERVIEN
!?        DBF:NOS_P   = RPT:NOSAUKUMS
!?        DBF:DAUDZUMS= N:DAUDZUMS
!?        DBF:cena    = N:CENA
!?        DBF:SUMMA   = N:SUMMA
!?        DBF:NOS     = N:NOS
!?        ADD(DBFFILE)
!?     .
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)                           !PRINT GRAND TOTALS
    ELSE
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
    END
!****************************DRUKÂJAM PÇC valûtâm **************
    KOPA = 'Kopâ:'
    VALK = 'Ls'
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSIF F:DBF='E'
        OUTA:LINE=format(KOPA,@s7)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&format(DAUDZUMSk,@N-_14.3)&CHR(9)&format(SUMMA_Bk,@N_12.2)&CHR(9)&format(SUMMA_PVNk,@N_12.2)&CHR(9)&format(SUMMA_Pk,@N_13.2)&CHR(9)&valk&CHR(9)&format(SUMMA_Xk,@N_13.2)
        ADD(OUTFILEANSI)
    ELSE
        OUTA:LINE=format(KOPA,@s7)&CHR(9)&' {58}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&format(DAUDZUMSk,@N-_14.3)&CHR(9)&format(SUMMA_Bk,@N12.2)&CHR(9)&format(SUMMA_PVNk,@N12.2)&CHR(9)&format(SUMMA_Pk,@N13.2)&CHR(9)&valk&CHR(9)&format(SUMMA_Xk,@N13.2)
        ADD(OUTFILEANSI)
    END
    DAUDZUMSK  = 0
    SUMMA_BK   = 0
    SUMMA_PVNK = 0
    SUMMA_PK   = 0
    SUMMA_XK   = 0
    KOPA='t.s.'
    IF ~F:CEN  !~NEDRUKÂT IEPIRKUMA CENAS
       GET(K_TABLE,0)
       LOOP J# = 1 TO RECORDS(K_TABLE)
         GET(K_TABLE,J#)
         IF K:SUMMA_P <>0
           SUMMA_PK = K:SUMMA_P
           VALK     = K:VAL
           IF F:DBF='W'
               PRINT(RPT:RPT_FOOT2)
           ELSIF F:DBF='E'
               OUTA:LINE=format(KOPA,@s7)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&format(DAUDZUMSk,@N-_14.3)&CHR(9)&format(SUMMA_Bk,@N_12.2)&CHR(9)&format(SUMMA_PVNk,@N_12.2)&CHR(9)&format(SUMMA_Pk,@N_13.2)&CHR(9)&valk&CHR(9)&format(SUMMA_Xk,@N_13.2)
               ADD(OUTFILEANSI)
           ELSE
               OUTA:LINE=format(KOPA,@s7)&CHR(9)&' {58}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&format(DAUDZUMSk,@N-_14.3)&CHR(9)&format(SUMMA_Bk,@N12.2)&CHR(9)&format(SUMMA_PVNk,@N12.2)&CHR(9)&format(SUMMA_Pk,@N13.2)&CHR(9)&valk&CHR(9)&format(SUMMA_Xk,@N13.2)
               ADD(OUTFILEANSI)
           END
           kopa=''
         .
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
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR ~(NOL:PAR_NR=PAR_NR)
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
!***************************************************************************
OMIT('DIANA')
NEXT_RECORD ROUTINE                              !GET NEXT RECORD
  LOOP UNTIL EOF(nolik)                          !  READ UNTIL END OF FILE
    NEXT(nolik)                                  !    READ NEXT RECORD
    I# += 1
    SHOW(15,32,I#,@N_5)
    IF ~(NOL:PAR_NR=PAR_NR AND NOL:PAZIME=D_K)
       BREAK
    .
    IF NOL:NR=1 THEN CYCLE.                         !SALDO
    GETPAVADZ(NOL:NR)                               !POZICIONÇ PAVADZÎMES
    IF ~RST() THEN CYCLE.
    IF CYCLENOM(NOL:NOMENKLAT) THEN CYCLE.          !FILTRS PÇC NOMENKLATÛTAS
    IF ~INRANGE(NOL:DATUMS,S_DAT,B_DAT)
       CYCLE
    .
    EXIT                                         !    EXIT THE ROUTINE
  .                                              !
  DONE# = 1                                      !  ON EOF, SET DONE FLAG
DIANA
N_IEKO               PROCEDURE                    ! Declare Procedure
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
                       PROJECT(PAV:C_DATUMS)
                       PROJECT(PAV:PAR_NR)
                     END
!------------------------------------------------------------------------

DOK_NR               STRING(10)
NR                   DECIMAL(5)
RPT_NR               DECIMAL(5)
NOS_P                STRING(96)
TIP                  STRING(5)
NOS                  STRING(3)
KOPA                 STRING(10)
SUMMAK               DECIMAL(13,2)
NOLIKTAVA_TEXT       STRING(30)
FILTRS_TEXT          STRING(120)
DAT                  DATE
LAI                  TIME
V1                   BYTE
V2                   BYTE
CN                   STRING(10)
CP                   STRING(3)
SAV_PAR_NR           ULONG

K_TABLE              QUEUE,PRE(K) !DAÞÂDAS VALÛTAS 1 PARTNERIM
NOS                    STRING(3)
SUMMA                  DECIMAL(12,2)
                     .

!---------------------------------------------------------------------
report REPORT,AT(302,1802,8000,9302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(302,302,8000,1500),USE(?unnamed:3)
         STRING(@s45),AT(1417,104,4531,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(2323,313,2708,208),USE(NOLIKTAVA_TEXT),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(823,969,5573,208),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Norçíinu summas par saòemtajâm pçcapmaksas/realizâcijas P/Z'),AT(448,500,6510,208),USE(?String2:2), |
             CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(2729,729,917,208),USE(s_dat),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(3667,729,104,208),USE(?String2:3),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(3771,729,917,208),USE(b_dat),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IE6V'),AT(6406,781,781,156),USE(?String8),RIGHT
         STRING(@P<<<#. lapaP),AT(6458,990,677,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(156,1198,7083,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(573,1198,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1354,1198,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4427,1198,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(10000,1198,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Nr'),AT(208,1250,365,208),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dok. Nr'),AT(625,1250,729,208),USE(?String11:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu piegâdâtâjs'),AT(1406,1250,1354,208),USE(?String11:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Norçíinu summa'),AT(6042,1250,1198,208),USE(?String11:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1458,7083,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Ienâcis'),AT(4479,1250,729,208),USE(?String11:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Jâapmaksâ'),AT(5260,1250,729,208),USE(?String11:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,1198,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5990,1198,0,313),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7240,1198,0,313),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(156,1198,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         STRING(@N-_13.2),AT(6094,10,781,156),USE(PAV:C_SUMMA),RIGHT
         STRING(@s3),AT(6917,10,313,156),USE(PAV:VAL),LEFT
         LINE,AT(7240,-10,0,198),USE(?Line7:4),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,198),USE(?Line7:3),COLOR(COLOR:Black)
         STRING(@D06.),AT(4531,10,573,156),USE(PAV:DATUMS),RIGHT
         LINE,AT(5208,-10,0,198),USE(?Line7:6),COLOR(COLOR:Black)
         STRING(@D06.),AT(5313,10,573,156),USE(PAV:c_DATUMS),RIGHT
         LINE,AT(5990,-10,0,198),USE(?Line7:7),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,198),USE(?Line7:2),COLOR(COLOR:Black)
         STRING(@S10),AT(625,10,677,156),USE(DOK_NR),RIGHT
         LINE,AT(1354,-10,0,198),USE(?Line7:5),COLOR(COLOR:Black)
         STRING(@s60),AT(1406,10,3021,156),USE(NOS_P),LEFT
         LINE,AT(156,-10,0,198),USE(?Line7),COLOR(COLOR:Black)
         STRING(@N_5),AT(208,10,313,156),USE(RPT_NR),RIGHT
       END
LINE   DETAIL,AT(,,,94)
         LINE,AT(156,-10,0,115),USE(?Line11),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,115),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,115),USE(?Line13:2),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,115),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(5208,-10,0,115),USE(?Line131),COLOR(COLOR:Black)
         LINE,AT(156,52,7083,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,115),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,115),USE(?Line132),COLOR(COLOR:Black)
       END
KOPA   DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(156,-10,0,198),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,198),USE(?Line16:5),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,198),USE(?Line16:4),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,198),USE(?Line16:2),COLOR(COLOR:Black)
         LINE,AT(5208,-10,0,198),USE(?Line16:21),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,198),USE(?Line16:22),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(6094,10,781,156),USE(K:SUMMA),RIGHT
         STRING(@s3),AT(6917,10,313,156),USE(K:NOS),LEFT
         LINE,AT(7240,-10,0,198),USE(?Line16:3),COLOR(COLOR:Black)
         STRING(@S10),AT(625,0,677,156),USE(kopa,,?kopa:2),TRN,CENTER
       END
RPT_FOOT DETAIL,AT(,,,396),USE(?unnamed)
         LINE,AT(156,-10,0,218),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,218),USE(?Line20:3),COLOR(COLOR:Black)
         LINE,AT(5208,-10,0,218),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,218),USE(?Line20:2),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(6094,10,781,156),USE(SUMMAK),RIGHT
         STRING('Ls'),AT(6927,10,313,156),USE(?NOSK,,?NOSK:2),LEFT
         LINE,AT(573,-10,0,218),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,218),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(156,208,7083,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@s10),AT(625,10,677,156),USE(KOPA),CENTER
         LINE,AT(1354,-10,0,218),USE(?Line19:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(177,229,469,208),USE(?String23),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(667,229,573,208),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1531,229,313,188),USE(?String25),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1844,229,156,188),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6135,229,615,188),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(6760,229),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(302,11000,8000,63)
         LINE,AT(156,0,7083,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  BIND('B_DAT',B_DAT)
  BIND('V1',V1)
  BIND('V2',V2)
  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLENOL',CYCLENOL)
  BIND('CYCLEpar_k',CYCLEPAR_K)
  I# = 0
  C#=0
  KOPA='Kopâ :'
  NR#     = 0
  DAT = TODAY()
  LAI = CLOCK()
!!  NOL_TEX = FORMAT_NOLTEX25()
  D_K = 'D'
  FIRST#=1
  V1 = 2
  V2 = 3
  RPT_NR = 0
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
  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'P11011'
      CP = 'P11'
      CLEAR(PAV:RECORD)
      PAV:D_K=D_K
      SET(PAV:PAR_KEY)
!?      FIRST# = 1
      Process:View{Prop:Filter} = '(PAV:APM_V=V1 OR PAV:APM_V=V2) AND ~CYCLENOL(CN) AND ~CYCLEPAR_K(CP)'
!!! AND INRANGE(PAV:C_DATUMS,S_DAT,B_DAT)
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
      NOLIKTAVA_TEXT='Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      FILTRS_TEXT=GETFILTRS_TEXT('10110001') !1-OB,2-NO,3-PT,4-PG,5-NOM,6-NT,7-DN,8-(1:parâdi)
!                                 12345678
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('IEKO.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=NOLIKTAVA_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE='NORÇÍINU SUMMAS PAR SAÒEMTAJÂM PÇCAPMAKSAS/REALIZÂCIJAS P/Z '
          ADD(OUTFILEANSI)
          OUTA:LINE=format(S_DAT,@d06.)&' LÎDZ '&format(B_DAT,@d06.)
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=' Npk '&CHR(9)&'Dok.Numurs'&CHR(9)&'Preèu piegâdâtâjs'&CHR(9)&'Ienâcis'&CHR(9)&'Jâapmaksâ'&CHR(9)&'Norçíinu summa'
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
                PRINT(RPT:LINE)
              ELSE
!                OUTA:LINE=''
!                ADD(OUTFILEANSI)
              END
              KOPA='Kopâ :'
              LOOP J# = 1 TO RECORDS(K_TABLE) !PA VISÂM VALÛTÂM
                GET(K_TABLE,J#)
                IF K:SUMMA
                  IF F:DBF='W'
                    PRINT(RPT:KOPA)
                  ELSE
                    OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(K:SUMMA,@N-_13.2))&CHR(9)&K:NOS
                    ADD(OUTFILEANSI)
                  END
                  kopa=''
                .
              .
              IF F:DBF='W'
                PRINT(RPT:LINE)
              ELSE
!                OUTA:LINE=''
!                ADD(OUTFILEANSI)
              END
              FREE(K_TABLE)
              RPT_NR = 0
           .
           SAV_PAR_NR=PAV:PAR_NR
        .
        IF INRANGE(PAV:C_DATUMS,S_DAT,B_DAT)
          IF F:ATL[2]='1' OR PAV:C_SUMMA
            IF PAV:PAR_ADR_NR
               NOS_P=CLIP(GETPAR_K(PAV:PAR_NR,2,1))&','&GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
            ELSE
               NOS_P=CLIP(GETPAR_K(PAV:PAR_NR,2,1))&','&GETPAR_K(PAV:PAR_NR,2,24)
            .
            RPT_NR += 1
            DOK_NR=PAV:DOK_SENR
            IF ~F:DTK
                IF F:DBF='W'
                    PRINT(RPT:DETAIL)
                ELSIF F:DBF='E'
                    OUTA:LINE=format(RPT_NR,@N_5)&CHR(9)&DOK_NR&CHR(9)&NOS_P&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&FORMAT(PAV:C_DATUMS,@D10.)&CHR(9)&LEFT(format(PAV:C_SUMMA,@N-_13.2))&CHR(9)&PAV:VAL
                    ADD(OUTFILEANSI)
                ELSE
                    OUTA:LINE=format(RPT_NR,@N_5)&CHR(9)&DOK_NR&CHR(9)&NOS_P&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&FORMAT(PAV:C_DATUMS,@D06.)&CHR(9)&LEFT(format(PAV:C_SUMMA,@N-_13.2))&CHR(9)&PAV:VAL
                    ADD(OUTFILEANSI)
                END
            END
            SUMMAK += PAV:C_SUMMA*BANKURS(PAV:VAL,PAV:DATUMS)
            GET(K_TABLE,0)
            K:NOS=PAV:VAL
            GET(K_TABLE,K:NOS)
            IF ERROR()
              K:NOS   = PAV:VAL
              K:SUMMA = PAV:C_SUMMA
              ADD(K_TABLE)
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
    IF RECORDS(K_TABLE)
      IF F:DBF='W'
        PRINT(RPT:LINE)
      ELSE
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
      END
      KOPA='Kopâ :'
      LOOP J# = 1 TO RECORDS(K_TABLE)
        GET(K_TABLE,J#)
        IF K:SUMMA
          IF F:DBF='W'
            PRINT(RPT:KOPA)
          ELSE
           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(K:SUMMA,@N-_13.2))&CHR(9)&K:NOS
           ADD(OUTFILEANSI)
          END
          kopa=''
        .
      .
      FREE(K_TABLE)
      IF F:DBF='W'
        PRINT(RPT:LINE)
      ELSE
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
      .
    .
    KOPA='Pavisam :'
    IF F:DBF='W'
      PRINT(RPT:RPT_FOOT)
      ENDPAGE(report)
    ELSE
      OUTA:LINE=CHR(9)&KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(SUMMAK,@N-_13.2))&CHR(9)&'Ls'
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
