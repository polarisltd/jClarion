                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_IENMAT             PROCEDURE                    ! Declare Procedure
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
NOSAUKUMS            STRING(28)
SUMMA_B              DECIMAL(12,2)
SUMMA_BK             DECIMAL(12,2)
SUMMA_P              DECIMAL(12,2)
SUMMA_PK             DECIMAL(13,2)
SUMMA_PVN            DECIMAL(12,2)
SUMMA_PVNK           DECIMAL(12,2)
DAUDZUMSK            DECIMAL(14,3)
KOPA                 STRING(20)
ITOGO                DECIMAL(14,2)
MUIK                 DECIMAL(10,2)
AKCIZK               DECIMAL(10,2)
CITASK               DECIMAL(10,2)
ITOGOK               DECIMAL(14,2)
TRANSK               DECIMAL(10,2)
VALK                 STRING(3)
KOPAA                STRING(7)
BKK                  STRING(5)
SB                   DECIMAL(13,2)
NOS_P                STRING(11)
DAT                  DATE
LAI                  TIME

CN                   STRING(10)
CP                   STRING(10)

MUITAS_KODS          STRING(11)
DAUDZUMS_R           DECIMAL(14,3)
SUMMA_RB             DECIMAL(12,2)
SUMMA_R              DECIMAL(12,2)

N_TABLE              QUEUE,PRE(N)
KEY                     STRING(26) !5+21
U_NR                    ULONG
DAUDZUMS                DECIMAL(12,3)
SUMMA_B                 DECIMAL(12,2)
SUMMA_PVN               DECIMAL(11,2)
SUMMA_P                 DECIMAL(12,2)
VAL                     STRING(3)
T_SUMMA                 DECIMAL(9,2)
MUITA                   DECIMAL(9,2)
AKCIZE                  DECIMAL(9,2)
CITAS                   DECIMAL(9,2)
                     .
NOM_NOSAUKUMS           STRING(50)
N_DATUMS                LONG
N_NOMENKLAT             LIKE(NOL:NOMENKLAT)
SAV_NOMENKLAT           LIKE(NOL:NOMENKLAT)
SAV_U_NR                LIKE(NOL:U_NR)

K_TABLE                 QUEUE,PRE(K)
VAL                      STRING(3)
SUMMA_P                  DECIMAL(12,2)
                        .
B_TABLE                 QUEUE,PRE(B)
BKK                      STRING(5)
SUMMA                    DECIMAL(12,2)
                        .
MER                     STRING(7)
VIRSRAKSTS              STRING(90)
FILTRS_TEXT             STRING(100)
SECIBA                  STRING(30)
NOM_KAT                 STRING(17)
NOM_MERVIENIBA          STRING(7)

!------------------------------------------------------------------------
report REPORT,AT(250,1625,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(250,500,12000,1125),USE(?unnamed:3)
         STRING(@s45),AT(3229,0,4740,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IE1V'),AT(9740,417,885,156),USE(?String13),CENTER
         STRING(@P<<<#. lapaP),AT(10521,417,677,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(52,625,11094,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(3542,1146,0,-521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(9010,885,1563,0),USE(?Line81),COLOR(COLOR:Black)
         STRING('Ârpuspavadz. izmaksas'),AT(9063,677,1510,208),USE(?String16:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1094,11094,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(6875,625,0,521),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(5125,625,0,521),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(1406,1146,0,-521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(417,1146,0,-521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('NPK'),AT(104,781,313,208),USE(?String16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces pieg.'),AT(469,781,938,208),USE(?String16:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(1510,677,1875,156),USE(Seciba),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçrv.'),AT(5823,781,469,208),USE(?String16:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5844,625,0,521),USE(?Line10:4),COLOR(COLOR:Black)
         STRING('Datums'),AT(1458,885,469,208),USE(?String16:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(1979,885,1563,208),USE(?String16:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces nosaukums'),AT(3594,781,1510,208),USE(?String16:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(5167,781,677,208),USE(?String16:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Bilances'),AT(6250,646,625,208),USE(?String16:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, '),AT(6927,677,521,208),USE(?String16:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6990,885,344,167),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Transp.'),AT(8490,677,521,208),USE(?String16:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8438,625,0,521),USE(?Line18:2),COLOR(COLOR:Black)
         LINE,AT(7448,625,0,521),USE(?Line81:2),COLOR(COLOR:Black)
         STRING('Vçrtîba'),AT(7500,677,938,208),USE(?String16:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Muita'),AT(9063,917,469,156),USE(?String16:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Akcîze'),AT(9583,917,469,156),USE(?String16:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Citas'),AT(10104,917,469,156),USE(?String16:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ,'),AT(10677,677,417,208),USE(?String16:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1406,833,2135,0),USE(?Line82),COLOR(COLOR:Black)
         LINE,AT(11146,625,0,521),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(10052,885,0,260),USE(?Line28:2),COLOR(COLOR:Black)
         STRING(@s3),AT(10677,885,417,208),USE(val_uzsk,,?val_uzsk:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9531,885,0,260),USE(?Line82:2),COLOR(COLOR:Black)
         LINE,AT(9010,625,0,521),USE(?Line38:2),COLOR(COLOR:Black)
         LINE,AT(1927,833,0,313),USE(?Line83),COLOR(COLOR:Black)
         STRING(@s100),AT(1844,417,7500,208),USE(FILTRS_TEXT),CENTER,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba, '),AT(6333,792,490,167),USE(?String16:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6406,927,344,167),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(7500,885,938,208),USE(?String16:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(P/Z, val.)'),AT(8490,885,521,208),USE(?String16:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10573,625,0,521),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(6198,625,0,521),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(52,1146,0,-521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s90),AT(1990,208,7188,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         STRING(@N4),AT(104,10,260,156),USE(NR),RIGHT
         STRING(@S15),AT(448,10,938,156),USE(PAV:NOKA),LEFT
         LINE,AT(1406,-10,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         STRING(@D05.),AT(1438,10,469,156),USE(N_DATUMS),LEFT
         LINE,AT(1927,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         STRING(@S21),AT(1958,10,1563,156),USE(N_NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3542,-10,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@S50),AT(3563,10,1555,156),USE(NOM_NOSAUKUMS),LEFT
         LINE,AT(5125,-10,0,198),USE(?Line12:6),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,198),USE(?Line12:9),COLOR(COLOR:Black)
         STRING(@N-_12.3B),AT(5156,10,677,156),USE(N:DAUDZUMS),RIGHT
         LINE,AT(5844,-10,0,198),USE(?Line12:16),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(6240,10,625,156),USE(N:SUMMA_B),RIGHT
         LINE,AT(9010,-10,0,198),USE(?Line12:12),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(9042,10,469,156),USE(N:MUITA),RIGHT
         LINE,AT(9531,-10,0,198),USE(?Line12:13),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(9563,10,469,156),USE(N:AKCIZE),RIGHT
         LINE,AT(10052,-10,0,198),USE(?Line12:14),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(10083,10,469,156),USE(N:citas),RIGHT
         LINE,AT(6875,-10,0,198),USE(?Line12:7),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(6917,10,521,156),USE(N:SUMMA_PVN),RIGHT
         LINE,AT(7448,-10,0,198),USE(?Line12:10),COLOR(COLOR:Black)
         LINE,AT(8438,-10,0,198),USE(?Line12:11),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(7469,10,677,156),USE(N:SUMMA_P),RIGHT
         STRING(@S3),AT(8167,10,260,156),USE(N:VAL),TRN,LEFT
         STRING(@N_10.2),AT(8469,10,521,156),USE(N:T_SUMMA),RIGHT
         LINE,AT(10573,-10,0,198),USE(?Line12:8),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(10604,10,521,156),USE(itogo),RIGHT
         STRING(@s5),AT(5865,10,365,156),USE(NOM_MERVIENIBA),TRN,LEFT
         LINE,AT(11146,-10,0,198),USE(?Line12:15),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94),USE(?unnamed:6)
         LINE,AT(52,0,0,115),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(417,0,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(1406,0,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(1927,0,0,63),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(3542,0,0,63),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(5125,0,0,63),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,115),USE(?Line19:11),COLOR(COLOR:Black)
         LINE,AT(6875,0,0,115),USE(?Line119:11),COLOR(COLOR:Black)
         LINE,AT(7448,0,0,115),USE(?Line19:14),COLOR(COLOR:Black)
         LINE,AT(8438,0,0,115),USE(?Line19:3),COLOR(COLOR:Black)
         LINE,AT(9010,0,0,115),USE(?Line19:15),COLOR(COLOR:Black)
         LINE,AT(9531,0,0,115),USE(?Line19:16),COLOR(COLOR:Black)
         LINE,AT(10052,0,0,115),USE(?Line19:17),COLOR(COLOR:Black)
         LINE,AT(10573,0,0,115),USE(?Line19:18),COLOR(COLOR:Black)
         LINE,AT(11146,0,0,115),USE(?Line19:4),COLOR(COLOR:Black)
         LINE,AT(52,52,11094,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(5844,0,0,115),USE(?Line19:27),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(52,-10,0,198),USE(?Line19:5),COLOR(COLOR:Black)
         LINE,AT(5844,-10,0,198),USE(?Line19:28),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,198),USE(?Line19:12),COLOR(COLOR:Black)
         LINE,AT(6875,-10,0,198),USE(?Line19:19),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,198),USE(?Line19:6),COLOR(COLOR:Black)
         STRING(@s20),AT(573,10,1406,156),USE(KOPA),LEFT
         LINE,AT(9531,-10,0,198),USE(?Line19:21),COLOR(COLOR:Black)
         LINE,AT(10052,-10,0,198),USE(?Line191:21),COLOR(COLOR:Black)
         LINE,AT(10573,-10,0,198),USE(?Line19:22),COLOR(COLOR:Black)
         LINE,AT(8438,-10,0,198),USE(?Line19:26),COLOR(COLOR:Black)
         LINE,AT(9010,-10,0,198),USE(?Line19:20),COLOR(COLOR:Black)
         LINE,AT(11146,-10,0,198),USE(?Line19:7),COLOR(COLOR:Black)
         STRING(@N-_14.3B),AT(5000,10,833,156),USE(DAUDZUMSk),RIGHT
         STRING(@N-_13.2B),AT(6229,10,625,156),USE(Summa_BK),RIGHT
         STRING(@N-_11.2B),AT(6906,10,521,156),USE(SUMMA_PVNk),RIGHT
         STRING(@N-_13.2B),AT(7469,10,677,156),USE(Summa_PK),RIGHT
         STRING(@s3),AT(8167,10,260,156),USE(VALK),TRN,LEFT
         STRING(@N_10.2B),AT(8469,10,521,156),USE(TRANSk),RIGHT
         STRING(@N_10.2B),AT(9042,10,469,156),USE(muik),RIGHT
         STRING(@N_10.2B),AT(9563,10,469,156),USE(akcizk),RIGHT
         STRING(@N_10.2B),AT(10083,10,469,156),USE(citask),RIGHT
         STRING(@N-_14.2B),AT(10604,10,521,156),USE(itogok),RIGHT
       END
RPT_FOOT2A DETAIL,AT(,,,177),USE(?unnamed:4)
         STRING(@s5),AT(5469,10,365,156),USE(BKK),LEFT
         LINE,AT(8438,-10,0,198),USE(?Line19:13),COLOR(COLOR:Black)
         LINE,AT(9010,-10,0,198),USE(?Line19:24),COLOR(COLOR:Black)
         LINE,AT(9531,-10,0,198),USE(?Line192:24),COLOR(COLOR:Black)
         LINE,AT(10052,-10,0,198),USE(?Line19:25),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(6229,10,625,156),USE(SB),RIGHT
         LINE,AT(10573,-10,0,198),USE(?Line19:9),COLOR(COLOR:Black)
         LINE,AT(11146,-10,0,198),USE(?Line19:10),COLOR(COLOR:Black)
         STRING(@s7),AT(573,10,469,156),USE(KOPAA),LEFT
         LINE,AT(6875,-10,0,198),USE(?Line193:24),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,198),USE(?Line139:24),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,198),USE(?Line19:23),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line19:8),COLOR(COLOR:Black)
         LINE,AT(5844,-10,0,198),USE(?Line19:29),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,281),USE(?unnamed)
         LINE,AT(52,0,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(5844,0,0,63),USE(?Line35:6),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,63),USE(?Line35:5),COLOR(COLOR:Black)
         LINE,AT(6875,0,0,63),USE(?Line35:2),COLOR(COLOR:Black)
         LINE,AT(7448,0,0,63),USE(?Line35:4),COLOR(COLOR:Black)
         LINE,AT(8438,0,0,63),USE(?Line35:3),COLOR(COLOR:Black)
         LINE,AT(9010,0,0,63),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(9531,0,0,63),USE(?Line135),COLOR(COLOR:Black)
         LINE,AT(10052,0,0,63),USE(?Line315),COLOR(COLOR:Black)
         LINE,AT(10573,0,0,63),USE(?Line351),COLOR(COLOR:Black)
         LINE,AT(11146,0,0,63),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(52,52,11094,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(73,83,469,146),USE(?String52),FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(552,83,552,146),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1323,83,260,146),USE(?String54),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1521,83),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(10083,83),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10719,83),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(250,7900,12000,63),USE(?unnamed:2)
         LINE,AT(52,0,11094,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Bûvçjam Izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='Izziòa par ienâkuðâm ('&D_K&') precçm no '&format(S_DAT,@d06.)&' lîdz '&format(B_DAT,@d06.)&|
      ' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      FILTRS_TEXT=GETFILTRS_TEXT('001111000') !1-OB,2-NO,3-PT,4-PG,5-NOM,6-NT,7-DN,8-(1:parâdi),9-ID
!                                 123456789
      IF F:SECIBA='N'                       !PIEPRASÎTA NOMENKLATÛRU SECÎBA
         SECIBA='Secîba:Nomenklat-Datums'
      ELSE
         SECIBA='Secîba:Datums-Nomenklat'
      .
      CN='N1011'
      CP='N11'

      CLEAR(nol:RECORD)
      IF NOMENKLAT[1]                        !JÇGA GRIEZT NOMENKLATÛRU SECÎBÂ
         NOL:NOMENKLAT=NOMENKLAT
         SET(nol:NOM_KEY,nol:NOM_KEY)
      ELSE
         NOL:DATUMS = s_dat
         NOL:D_K = D_K
         SET(nol:DAT_KEY,nol:DAT_KEY)
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
          IF ~OPENANSI('IENMAT.TXT')
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
          OUTA:LINE=SECIBA
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
!             OUTA:LINE='Nr'&CHR(9)&'Preces piegâdâtâjs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&'Kataloga Numurs'&CHR(9)&|
!             'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances'&CHR(9)&'PVN, Ls'&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&|
!             'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&CHR(9)&CHR(9)&CHR(9)&'Kopâ, Ls'&CHR(9)&'Muitas Kods'
             OUTA:LINE='Nr'&CHR(9)&'Preces piegâdâtâjs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&'Kataloga Numurs'&CHR(9)&|
             'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances'&CHR(9)&'PVN, '&val_uzsk&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&|
             'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&CHR(9)&CHR(9)&CHR(9)&'Kopâ, '&val_uzsk&CHR(9)&'Muitas Kods'
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
!             CHR(9)&CHR(9)&'vçrtîba, Ls'&CHR(9)&CHR(9)&'ar PVN,val.'&CHR(9)&CHR(9)&'(P/Z,val.)'&CHR(9)&'Muita'&CHR(9)&|
!             'Akcîze'&CHR(9)&'Citas'
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
             CHR(9)&CHR(9)&'vçrtîba, '&val_uzsk&CHR(9)&CHR(9)&'ar PVN,val.'&CHR(9)&CHR(9)&'(P/Z,val.)'&CHR(9)&'Muita'&CHR(9)&|
             'Akcîze'&CHR(9)&'Citas'
          ELSE
!             OUTA:LINE='Nr'&CHR(9)&'Preces piegâdâtâjs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&'Kataloga Numurs'&CHR(9)&|
!             'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances vçrtîba, Ls'&CHR(9)&'PVN, Ls'&CHR(9)&'Vçrtîba ar PVN,Val.'&CHR(9)&|
!             'Transp. P/Z, Val.'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'&CHR(9)&'Kopâ, Ls'&CHR(9)&'Muitas Kods'
             OUTA:LINE='Nr'&CHR(9)&'Preces piegâdâtâjs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&'Kataloga Numurs'&CHR(9)&|
             'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances vçrtîba, '&val_uzsk&CHR(9)&'PVN, '&val_uzsk&CHR(9)&'Vçrtîba ar PVN,Val.'&CHR(9)&|
             'Transp. P/Z, Val.'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'&CHR(9)&'Kopâ, '&val_uzsk&CHR(9)&'Muitas Kods'
           .
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT) AND ~CYCLEPAR_K(CP) AND ~(NOL:U_NR=1)|
        AND (NOM_TIPS7='PTAKRIV' OR INSTRING(GETNOM_K(NOL:NOMENKLAT,0,16),NOM_TIPS7))
           IF F:SECIBA='N'              !NOMENKLATÛRU SECÎBA
              N:KEY[1:21]=NOL:NOMENKLAT
              N:KEY[22:26]=NOL:DATUMS
           ELSE
              N:KEY[1:5]=NOL:DATUMS
              N:KEY[6:26]=NOL:NOMENKLAT
           .
           N:U_NR     =NOL:U_NR
           N:DAUDZUMS =NOL:DAUDZUMS
           N:SUMMA_B  =calcsum(15,2)        ! Ls BEZ PVN-A
           N:SUMMA_P  =CALCSUM(4,2)         ! VALÛTÂ AR PVN-A
           N:SUMMA_PVN=CALCSUM(17,2)        ! PVN Ls-A
           N:VAL      =NOL:VAL
           N:T_SUMMA  =NOL:T_SUMMA
           N:MUITA    =NOL:MUITA
           N:AKCIZE   =NOL:AKCIZE
           N:CITAS    =NOL:CITAS
           ADD(N_TABLE)
           K:VAL=NOL:VAL
           GET(K_TABLE,K:VAL)
           IF ERROR()
             K:VAL     = NOL:VAL
             K:SUMMA_P = CALCSUM(4,2)
             ADD(K_TABLE)
             SORT(K_TABLE,K:VAL)
           ELSE
             K:SUMMA_P += CALCSUM(4,2)
             PUT(K_TABLE)
           .
           IF NOL:DAUDZUMS<0  !t.s.ATGRIEZTA PRECE
              DAUDZUMS_R += NOL:DAUDZUMS
              SUMMA_RB   += CALCSUM(15,2)
              SUMMA_R    += CALCSUM(15,2)+CALCSUM(17,2)
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
    SORT(N_TABLE,N:KEY)
    LOOP I#=1 TO RECORDS(N_TABLE)
        GET(N_TABLE,I#)
        nr+=1
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
        IF ~(SAV_NOMENKLAT=N_NOMENKLAT)                
           NOM_NOSAUKUMS =GETNOM_K(N_NOMENKLAT,2,2)    !POZICIONÇ NOM_K
           NOM_KAT       = NOM:KATALOGA_NR
           NOM_MERVIENIBA=NOM:MERVIEN
           SAV_NOMENKLAT=N_NOMENKLAT
           MUITAS_KODS=FORMAT(NOM:MUITAS_KODS,@N_11B)
        .
        ITOGO = N:MUITA + N:AKCIZE + N:CITAS + N:SUMMA_B + N:SUMMA_PVN + N:T_SUMMA*BANKURS(N:VAL,N_DATUMS)  !LS
        DAUDZUMSK   += N:DAUDZUMS            ! SKAITA KOPÂ DAUDZUMUS, ANYWAY
        SUMMA_BK    += N:SUMMA_B             ! BEZ PVN LS-A
        SUMMA_PVNK  += N:SUMMA_PVN           ! PVN LS-A
        SUMMA_PK    += N:SUMMA_B+N:SUMMA_PVN ! AR PVN -A Ls
        MUIK        += N:MUITA               ! Ls
        AKCIZK      += N:AKCIZE              ! Ls
        CITASK      += N:CITAS               ! Ls
        TRANSK      += N:T_SUMMA*BANKURS(N:VAL,N_DATUMS)  ! Ls
        ITOGOK      += ITOGO                 ! Ls
        IF F:DBF='W'
           PRINT(RPT:DETAIL)
        ELSE
           IF F:DBF='E' 
              OUTA:LINE=NR&CHR(9)&PAV:NOKA&CHR(9)&FORMAT(N_DATUMS,@D06.)&CHR(9)&N_NOMENKLAT&CHR(9)&NOM_KAT&CHR(9)&|
              NOM_NOSAUKUMS&CHR(9)&LEFT(FORMAT(N:DAUDZUMS,@N-_12.3))&CHR(9)&LEFT(FORMAT(N:SUMMA_B,@N-_12.2))&CHR(9)&|
              LEFT(FORMAT(N:SUMMA_PVN,@N-_11.2))&CHR(9)&LEFT(FORMAT(N:SUMMA_P,@N-_12.2))&CHR(9)&N:VAL&CHR(9)&|
              LEFT(FORMAT(N:T_SUMMA,@N-_9.2))&CHR(9)&LEFT(FORMAT(N:MUITA,@N-_9.2))&CHR(9)&LEFT(FORMAT(N:AKCIZE,@N-_9.2))&|
              CHR(9)&LEFT(FORMAT(N:CITAS,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGO,@N-_14.2))&CHR(9)&MUITAS_KODS
           ELSE !WORD
              OUTA:LINE=NR&CHR(9)&PAV:NOKA&CHR(9)&FORMAT(N_DATUMS,@D06.)&CHR(9)&N_NOMENKLAT&CHR(9)&NOM_KAT&CHR(9)&|
              NOM_NOSAUKUMS&CHR(9)&LEFT(FORMAT(N:DAUDZUMS,@N-_12.3))&CHR(9)&LEFT(FORMAT(N:SUMMA_B,@N-_12.2))&CHR(9)&|
              LEFT(FORMAT(N:SUMMA_PVN,@N-_11.2))&CHR(9)&CLIP(N:VAL)&' '&LEFT(FORMAT(N:SUMMA_P,@N-_12.2))&CHR(9)&|
              LEFT(FORMAT(N:T_SUMMA,@N-_9.2))&CHR(9)&LEFT(FORMAT(N:MUITA,@N-_9.2))&CHR(9)&LEFT(FORMAT(N:AKCIZE,@N-_9.2))&|
              CHR(9)&LEFT(FORMAT(N:CITAS,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGO,@N-_14.2))&CHR(9)&MUITAS_KODS
           .
           ADD(OUTFILEANSI)
        .
! *************************SADALAM PÇC BKK*******************
        IF NOM:BKK=''
          IF NOM:TIPS='P' OR NOM:TIPS=''
            BKK=SYS:D_PR
          ELSE
            BKK=SYS:D_TA
          .
        ELSE
          BKK=NOM:BKK
        .
        FOUND#=0
        LOOP J#=1 TO RECORDS(B_TABLE)
          GET(B_TABLE,J#)
          IF B:BKK=BKK
            B:SUMMA+=N:SUMMA_B
            PUT(B_TABLE)
            FOUND#=1
            BREAK
          .
        .
        IF ~FOUND#
          B:BKK=BKK
          B:SUMMA =N:SUMMA_B
          ADD(B_TABLE)
        .
    .
    FREE(N_TABLE)
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)                           !LINE
    ELSE
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
    END
!****************************DRUKÂJAM KOPÂ Ls **************
    KOPA='Kopâ:'
    !VALK = 'Ls'
    VALK = val_uzsk
    IF F:DBF='W'
       PRINT(RPT:RPT_FOOT2)
    ELSE
       IF F:DBF='E' 
          OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&|
          LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&|
          CHR(9)&VALK&CHR(9)&LEFT(FORMAT(TRANSK,@N-_9.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_9.2))&CHR(9)&|
          LEFT(FORMAT(AKCIZK,@N-_9.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
       ELSE !WORD
          OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&|
          LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_11.2))&CHR(9)&CLIP(VALK)&' '&|
          LEFT(FORMAT(SUMMA_PK,@N-_12.2))&CHR(9)&LEFT(FORMAT(TRANSK,@N-_9.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_9.2))&CHR(9)&|
          LEFT(FORMAT(AKCIZK,@N-_9.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
       .
       ADD(OUTFILEANSI)
    .
!****************************DRUKÂJAM PÇC valûtâm **************
    DAUDZUMSK  = 0
    SUMMA_BK   = 0
    SUMMA_PVNK = 0
    SUMMA_PK   = 0
    MUIK       = 0
    AKCIZK     = 0
    CITASK     = 0
    TRANSK     = 0
    ITOGOK     = 0
    KOPA = 't.s.'
    GET(K_TABLE,0)
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      IF RECORDS(K_TABLE)=1 AND (((K:VAL='Ls' OR K:VAL='LVL') AND GL:DB_GADS <= 2013) OR (GL:DB_GADS > 2013 AND K:VAL=val_uzsk)) THEN BREAK.
      IF K:SUMMA_P>0
        SUMMA_PK = K:SUMMA_P
        VALK     = K:VAL
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)                      
        ELSE
           IF F:DBF='E' 
              OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&|
              LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&|
              CHR(9)&VALK&CHR(9)&LEFT(FORMAT(TRANSK,@N-_9.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_9.2))&CHR(9)&|
              LEFT(FORMAT(AKCIZK,@N-_9.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
           ELSE !WORD
              OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&|
              LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_11.2))&CHR(9)&CLIP(VALK)&' '&|
              LEFT(FORMAT(SUMMA_PK,@N-_12.2))&CHR(9)&LEFT(FORMAT(TRANSK,@N-_9.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_9.2))&CHR(9)&|
              LEFT(FORMAT(AKCIZK,@N-_9.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
           .
           ADD(OUTFILEANSI)
        .
        kopa=''
      .
    .
!****************************DRUKÂJAM PÇC BKK*******************
    KOPAa='t.s.'
    GET(B_TABLE,0)
    LOOP J# = 1 TO RECORDS(B_TABLE)
      GET(B_TABLE,J#)
      IF B:SUMMA <> 0
        SB  =B:SUMMA
        BKK =B:BKK
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2A)
        ELSE
            OUTA:LINE=KOPAA&CHR(9)&BKK&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SB,@N-_12.2))
            ADD(OUTFILEANSI)
        END
        KOPAA=''
        SB=0
      .
    .
!***************************** JA IR ATGRIEZTA PRECE *******************
     IF DAUDZUMS_R
         KOPA        = 'Atgrieztâ prece'
         DAUDZUMSK   = DAUDZUMS_R
         SUMMA_BK    = SUMMA_RB
         SUMMA_PVNK  = 0
         SUMMA_PK    = 0
         VALK        = ''
         MUIK        = 0
         AKCIZK      = 0
         CITASK      = 0
         TRANSK      = 0  ! Ls
         ITOGOK      = SUMMA_R
         IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
         ELSE
           IF F:DBF='E' 
              OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&|
              LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&|
              CHR(9)&VALK&CHR(9)&LEFT(FORMAT(TRANSK,@N-_9.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_9.2))&CHR(9)&|
              LEFT(FORMAT(AKCIZK,@N-_9.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
           ELSE !WORD
              OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&|
              LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_11.2))&CHR(9)&CLIP(VALK)&' '&|
              LEFT(FORMAT(SUMMA_PK,@N-_12.2))&CHR(9)&LEFT(FORMAT(TRANSK,@N-_9.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_9.2))&CHR(9)&|
              LEFT(FORMAT(AKCIZK,@N-_9.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
           .
           ADD(OUTFILEANSI)
         END
     END
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
  IF F:DBF='E' THEN F:DBF='W'.
  POPBIND
  FREE(K_TABLE)
  FREE(B_TABLE)
  FREE(N_TABLE)
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
  IF NOMENKLAT[1]            !TIEK GRIEZTS NOMENKLATÛRU SECÎBÂ
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
N_IENMATP            PROCEDURE                    ! Declare Procedure
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
NR                   DECIMAL(4)
DOK_NR               STRING(10)
PIEGAD               STRING(20)
SUMMA_B              DECIMAL(12,2)
SUMMA_PVN            DECIMAL(12,2)
SUMMA_P              DECIMAL(12,2)
ITOGO                DECIMAL(14,2)
KOPA                 STRING(20)
KOPAA                STRING(8)
BKK                  STRING(5)
SB                   DECIMAL(13,2)
VIRSRAKSTS           STRING(110)
FILTRS_TEXT          STRING(100)
DAT                  DATE
LAI                  TIME
CN                   STRING(10)
DAUDZUMSK            DECIMAL(14,3)
SUMMA_BK             DECIMAL(13,2)
SUMMA_PVNK           DECIMAL(12,2)
SUMMA_PK             DECIMAL(13,2)
VALK                 STRING(3)
MUIK                 DECIMAL(10,2)
AKCIZK               DECIMAL(10,2)
CITASK               DECIMAL(10,2)
ITOGOK               DECIMAL(14,2)
TRANSK               DECIMAL(10,2)
SECIBA               STRING(30)
NOM_NOSAUKUMS        STRING(50)
N_DATUMS             LONG
N_NOMENKLAT          STRING(21)
SAV_NOMENKLAT        STRING(21)
SAV_U_NR             ULONG
NOM_KAT              STRING(17)

N_TABLE              QUEUE,PRE(N)
KEY                     STRING(26) !5+21
U_NR                    ULONG
DAUDZUMS                DECIMAL(12,3)
SUMMA_B                 DECIMAL(12,2)
SUMMA_PVN               DECIMAL(11,2)
SUMMA_P                 DECIMAL(12,2)
VAL                     STRING(3)
T_SUMMA                 DECIMAL(9,2)
MUITA                   DECIMAL(9,2)
AKCIZE                  DECIMAL(9,2)
CITAS                   DECIMAL(9,2)
                     .
K_TABLE              QUEUE,PRE(K)
VAL                     STRING(3)
SUMMA_P                 DECIMAL(12,2)
                     .
B_TABLE              QUEUE,PRE(B)
BKK                     STRING(5)
SUMMA                   DECIMAL(12,2)
                     .
DAUDZUMS_R          DECIMAL(12,2)
SUMMA_RB            DECIMAL(12,2)
SUMMA_R             DECIMAL(12,2)

!------------------------------------------------------------------------
report REPORT,AT(150,1625,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(150,500,12000,1125),USE(?unnamed)
         LINE,AT(5417,625,0,521),USE(?Line7:2),COLOR(COLOR:Black)
         STRING(@s45),AT(2906,21,4635,198),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8542,833,1875,0),USE(?Line71),COLOR(COLOR:Black)
         STRING(@s110),AT(865,240,8698,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IE1K'),AT(10000,417,729,156),USE(?String13),LEFT
         STRING(@P<<<#. lapaP),AT(10729,417,573,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s100),AT(1063,427,8323,188),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:ANSI)
         LINE,AT(52,625,11250,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(3125,1146,0,-521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(52,1094,11250,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(6198,625,0,521),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(4844,625,0,521),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(1510,1146,0,-313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(365,1146,0,-521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('NPK'),AT(104,760,260,208),USE(?String16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(938,885,573,208),USE(?String16:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(' Numurs'),AT(417,885,469,208),USE(?String16:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(885,625,0,521),USE(?Line39),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(1563,885,1563,208),USE(?String16:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces nosaukums'),AT(3177,760,1667,208),USE(?String16:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudz.'),AT(4896,760,521,208),USE(?String16:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Bilances'),AT(5469,677,729,208),USE(?String16:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(6344,688,365,208),USE(?String16:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6344,885,365,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Transp. '),AT(7969,677,573,208),USE(?String16:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ârpuspavadzîmes izmaksas'),AT(8594,677,1823,156),USE(?String64),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7917,625,0,521),USE(?Line82:2),COLOR(COLOR:Black)
         STRING('Vçrtîba'),AT(6875,677,1042,208),USE(?String16:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Muita'),AT(8594,885,573,208),USE(?String16:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Akcîze'),AT(9219,885,573,208),USE(?String116:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Citas'),AT(9844,885,573,208),USE(?String16:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ'),AT(10469,760,438,208),USE(?String16:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(10938,760,344,208),USE(val_uzsk,,?val_uzsk:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(885,833,2240,0),USE(?Line72),COLOR(COLOR:Black)
         LINE,AT(11302,625,0,521),USE(?Line10:5),COLOR(COLOR:Black)
         STRING('P/Z'),AT(417,677,417,208),USE(?String16:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(990,677,2135,156),USE(SECIBA),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10417,625,0,521),USE(?Line10:4),COLOR(COLOR:Black)
         LINE,AT(9792,833,0,313),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(9167,833,0,313),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(6823,625,0,521),USE(?Line18:2),COLOR(COLOR:Black)
         STRING('vçrtîba'),AT(5448,885,448,208),USE(?String16:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5865,885,333,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(6875,885,1042,208),USE(?String16:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(P/Z, val.)'),AT(7979,865,521,208),USE(?String16:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8542,625,0,521),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(52,1146,0,-521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(5417,-10,0,198),USE(?Line12:6),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         STRING(@N4),AT(104,10,260,156),USE(NR),RIGHT
         STRING(@D06.),AT(938,10,573,156),USE(N_DATUMS),LEFT
         STRING(@N-_10.2),AT(6250,10,573,156),USE(N:SUMMA_pvn),RIGHT
         LINE,AT(1510,-10,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         STRING(@S21),AT(1563,10,1563,156),USE(N_NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3125,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         STRING(@S50),AT(3177,10,1667,156),USE(NOM_NOSAUKUMS),LEFT,FONT(,,,,CHARSET:BALTIC)
         LINE,AT(4844,-10,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@N-_12.3B),AT(4896,10,521,156),USE(N:DAUDZUMS),RIGHT
         STRING(@N-_12.2),AT(5469,10,729,156),USE(N:SUMMA_B),RIGHT
         LINE,AT(6198,-10,0,198),USE(?Line12:7),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(6875,10,729,156),USE(N:SUMMA_P),RIGHT
         STRING(@S3),AT(7656,10,260,156),USE(N:VAL),LEFT
         LINE,AT(8542,-10,0,198),USE(?Line12:11),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(8594,10,573,156),USE(N:MUITA),RIGHT
         LINE,AT(9167,-10,0,198),USE(?Line12:12),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(9219,10,573,156),USE(N:akcize),RIGHT
         LINE,AT(9792,-10,0,198),USE(?Line12:13),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(9844,10,573,156),USE(N:citas),RIGHT
         LINE,AT(10417,-10,0,198),USE(?Line12:14),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(10469,10,781,156),USE(itogo),RIGHT
         LINE,AT(11302,-10,0,198),USE(?Line12:15),COLOR(COLOR:Black)
         STRING(@S10),AT(417,10,469,156),USE(DOK_NR),RIGHT
         LINE,AT(885,-10,0,198),USE(?Line12:9),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line12:8),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,198),USE(?Line12:10),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7969,10,573,156),USE(N:T_SUMMA),RIGHT
         LINE,AT(365,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(52,-10,0,115),USE(?Line19:5),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(885,-10,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(3125,-10,0,63),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(4844,-10,0,63),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,115),USE(?Line38:2),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,115),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,115),USE(?Line19:6),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,115),USE(?Line19:9),COLOR(COLOR:Black)
         LINE,AT(8542,-10,0,115),USE(?Line19:7),COLOR(COLOR:Black)
         LINE,AT(9167,-10,0,115),USE(?Line129:7),COLOR(COLOR:Black)
         LINE,AT(9792,-10,0,115),USE(?Line192:7),COLOR(COLOR:Black)
         LINE,AT(10417,-10,0,115),USE(?Line191:7),COLOR(COLOR:Black)
         LINE,AT(11302,-10,0,115),USE(?Line119:7),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,63),USE(?Line21:2),COLOR(COLOR:Black)
         LINE,AT(52,52,11250,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,198),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line19:3),COLOR(COLOR:Black)
         LINE,AT(8542,-10,0,198),USE(?Line19:4),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,198),USE(?Line19:8),COLOR(COLOR:Black)
         STRING(@s20),AT(104,10,1354,156),USE(KOPA),LEFT
         LINE,AT(11302,-10,0,198),USE(?Line19:15),COLOR(COLOR:Black)
         LINE,AT(10417,-10,0,198),USE(?Line19:14),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(10469,10,781,156),USE(itogok),RIGHT
         STRING(@N_10.2B),AT(9844,10,573,156),USE(citask),RIGHT
         LINE,AT(9792,-10,0,198),USE(?Line19:13),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(8594,10,573,156),USE(muik),RIGHT
         LINE,AT(9167,-10,0,198),USE(?Line19:12),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(9219,10,573,156),USE(akcizk),RIGHT
         STRING(@N-_14.3B),AT(4531,10,885,156),USE(DAUDZUMSk),RIGHT
         STRING(@N-_13.2B),AT(5469,10,729,156),USE(SUMMA_BK),RIGHT
         STRING(@N-_13.2B),AT(6875,10,729,156),USE(SUMMA_PK),RIGHT
         STRING(@S3),AT(7656,10,260,156),USE(VALK),LEFT
         LINE,AT(7917,-10,0,198),USE(?Line19:11),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(7969,10,573,156),USE(transk),RIGHT
         STRING(@N-_11.2B),AT(6250,10,573,156),USE(SUMMA_pvnk),RIGHT
         LINE,AT(6198,-10,0,198),USE(?Line19:10),COLOR(COLOR:Black)
       END
RPT_FOOT2A DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,198),USE(?Line119),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line119:3),COLOR(COLOR:Black)
         LINE,AT(8542,-10,0,198),USE(?Line119:4),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,198),USE(?Line119:8),COLOR(COLOR:Black)
         LINE,AT(11302,-10,0,198),USE(?Line119:15),COLOR(COLOR:Black)
         STRING(@s8),AT(104,10,573,156),USE(KOPAA),LEFT
         STRING(@s5),AT(5010,10,365,156),USE(BKK),LEFT
         STRING(@N-_13.2),AT(5458,10,719,156),USE(SB),RIGHT
         LINE,AT(10417,-10,0,198),USE(?Line119:14),COLOR(COLOR:Black)
         LINE,AT(9792,-10,0,198),USE(?Line119:13),COLOR(COLOR:Black)
         LINE,AT(9167,-10,0,198),USE(?Line119:12),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,198),USE(?Line119:11),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,198),USE(?Line119:10),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,260),USE(?unnamed:2)
         LINE,AT(52,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,63),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,63),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,63),USE(?Line323),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,63),USE(?Line233),COLOR(COLOR:Black)
         LINE,AT(8542,-10,0,63),USE(?Line331),COLOR(COLOR:Black)
         LINE,AT(9167,-10,0,63),USE(?Line313),COLOR(COLOR:Black)
         LINE,AT(10417,-10,0,63),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(11302,-10,0,63),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(52,52,11250,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(9792,-10,0,63),USE(?Line133),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(156,83,573,146),USE(?String52),FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(698,83,552,146),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1615,83,313,146),USE(?String54),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1927,83),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(10208,83,594,146),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10844,83,458,146),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(150,7900,12000,63)
         LINE,AT(52,0,11250,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!********************konkrçta partnera piegâdâtâs preces- vajadzçjqa apvienot ar N_IENMAT...
  PUSHBIND

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

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
  BIND(NOM:RECORD)
  BIND(PAV:RECORD)
  BIND(PAR:RECORD)
  BIND('CN',CN)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Izziòa IE1K'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      IF F:DTK !PÇC IZVÇLÇTÂS P/Z
         VIRSRAKSTS='Izziòa '&D_K&' P/Z: Noliktava:'&CLIP(LOC_NR)&' '&CLIP(PAV:DOK_SENR)&' '&GETPAR_K(PAR_NR,2,2)
      ELSE
         VIRSRAKSTS='Izziòa par ienâkuðâm ('&D_K&') precçm '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&|
         ' Noliktava:'&CLIP(LOC_NR)&' '&GETPAR_K(PAR_NR,2,2)
      .
      FILTRS_TEXT=GETFILTRS_TEXT('000011000') !1-OB,2-NO,3-PT,4-PG,5-NOM,6-NT,7-DN,8-(1:parâdi),9-ID
!                                 123456789
      IF F:SECIBA='N'              !PIEPRASÎTA NOMENKLATÛRU SECÎBA
         SECIBA='Secîba:Nomenklat-Datums'
      ELSIF F:SECIBA='I'           !IEVADÎÐANAS SECÎBA
         SECIBA='Secîba:Ievadîðanas'
      ELSE
         SECIBA='Secîba:Datums-Nomenklat'
      .
      CN = 'N10010'
!           123456
      CLEAR(nol:RECORD)
      NOL:D_K = D_K
      NOL:DATUMS = S_DAT
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
          IF ~OPENANSI('IENMATP.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT&' NOLIKTAVA: '&LOC_NR
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=SECIBA
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
!             OUTA:LINE='Npk '&CHR(9)&'P/Z Numurs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&'Kataloga Numurs'&CHR(9)&|
!             'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances'&CHR(9)&'PVN, Ls'&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&|
!             'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&CHR(9)&CHR(9)&CHR(9)&'Kopâ, Ls'
             OUTA:LINE='Npk '&CHR(9)&'P/Z Numurs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&CHR(9)&'Kataloga Numurs'&CHR(9)&|
             'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances'&CHR(9)&'PVN, '&val_uzsk&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&|
             'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&CHR(9)&CHR(9)&CHR(9)&'Kopâ, '&val_uzsk
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&NOMENKLAT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'vçrtîba, Ls'&CHR(9)&CHR(9)&'ar PVN, val.'&|
!             CHR(9)&CHR(9)&'(P/Z,val.)'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&NOMENKLAT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'vçrtîba, '&val_uzsk&CHR(9)&CHR(9)&'ar PVN, val.'&|
             CHR(9)&CHR(9)&'(P/Z,val.)'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'
          ELSE
!             OUTA:LINE='Npk '&CHR(9)&'P/Z Numurs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&NOMENKLAT&CHR(9)&'Kataloga Numurs'&CHR(9)&|
!             'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances vçrtîba, Ls'&CHR(9)&'PVN, Ls'&CHR(9)&'Vçrtîba ar PVN, val.'&CHR(9)&CHR(9)&|
!             'Transports (P/Z,valûtâ)'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'&CHR(9)&'Kopâ, Ls'
             OUTA:LINE='Npk '&CHR(9)&'P/Z Numurs'&CHR(9)&'Datums'&CHR(9)&'Nomenklatûra'&NOMENKLAT&CHR(9)&'Kataloga Numurs'&CHR(9)&|
             'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances vçrtîba, '&val_uzsk&CHR(9)&'PVN, '&val_uzsk&CHR(9)&'Vçrtîba ar PVN, val.'&CHR(9)&CHR(9)&|
             'Transports (P/Z,valûtâ)'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'&CHR(9)&'Kopâ, '&val_uzsk
          .
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NK#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~F:DTK OR (F:DTK AND NOL:U_NR=PAV::U_NR) !TIKAI PÇC IZVÇLÇTÂS P/Z
           IF ~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT)
              IF F:SECIBA='N'              !NOMENKLATÛRU SECÎBA TABULAI
                 N:KEY[1:21]=NOL:NOMENKLAT
                 N:KEY[22:26]=NOL:DATUMS
              ELSE
                 N:KEY[1:5]=NOL:DATUMS
                 N:KEY[6:26]=NOL:NOMENKLAT
              .
              N:U_NR     =NOL:U_NR
              N:DAUDZUMS =NOL:DAUDZUMS
              N:SUMMA_B  =calcsum(15,2)        ! Ls-A
              N:SUMMA_P  =CALCSUM(4,2)         ! VALÛTÂ -A
              N:SUMMA_PVN=CALCSUM(17,2)        ! PVN Ls-A
              N:VAL      =NOL:VAL
              N:T_SUMMA  =NOL:T_SUMMA
              N:MUITA    =NOL:MUITA
              N:AKCIZE   =NOL:AKCIZE
              N:CITAS    =NOL:CITAS
              ADD(N_TABLE)
              K:VAL=NOL:VAL
              GET(K_TABLE,K:VAL)
              IF ERROR()
                K:VAL     = NOL:VAL
                K:SUMMA_P = CALCSUM(4,2)
                ADD(K_TABLE)
                SORT(K_TABLE,K:VAL)
              ELSE
                K:SUMMA_P += CALCSUM(4,2)
                PUT(K_TABLE)
              .
              IF NOL:DAUDZUMS<0  !T.S.ATGRIEZTA PRECE
                    DAUDZUMS_R += NOL:DAUDZUMS
                    SUMMA_RB   += CALCSUM(15,2)
                    SUMMA_R    += CALCSUM(15,2)+CALCSUM(17,2)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     IF F:SECIBA='I'                 !IEVADÎÐANAS SECÎBA
                                     !NEVAJAG SORTÇT
     ELSE
        SORT(N_TABLE,N:KEY)
     .
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
        IF ~(SAV_NOMENKLAT=N_NOMENKLAT)
           NOM_NOSAUKUMS=GETNOM_K(N_NOMENKLAT,2,2)
           NOM_KAT = NOM:KATALOGA_NR
           SAV_NOMENKLAT=N_NOMENKLAT
        .
        DOK_NR=PAV:DOK_SENR
        NR +=1
        ITOGO = N:MUITA + N:AKCIZE + N:CITAS + N:SUMMA_B + N:SUMMA_PVN + N:T_SUMMA*BANKURS(N:VAL,N_DATUMS)  !LS
        DAUDZUMSK   += N:DAUDZUMS            ! SKAITA KOPÂ DAUDZUMUS, ANYWAY
        SUMMA_BK    += N:SUMMA_B             ! BEZ PVN LS
        SUMMA_PVNK  += N:SUMMA_PVN           ! PVN LS
        SUMMA_PK    += N:SUMMA_B+N:SUMMA_PVN ! AR PVN -A Ls
        MUIK        += N:MUITA               ! Ls
        AKCIZK      += N:AKCIZE              ! Ls
        CITASK      += N:CITAS               ! Ls
        TRANSK      += N:T_SUMMA*BANKURS(N:VAL,N_DATUMS)  ! Ls
        ITOGOK      += ITOGO                 ! Ls
!*************************SADALAM PÇC BKK*******************
        IF NOM:BKK=''
          IF NOM:TIPS='P' OR NOM:TIPS=''
            BKK=SYS:D_PR
          ELSE
            BKK=SYS:D_TA
          .
        ELSE
          BKK=NOM:BKK
        .
        FOUND#=0
        LOOP J#=1 TO RECORDS(B_TABLE)
          GET(B_TABLE,J#)
          IF B:BKK=BKK
            B:SUMMA+=N:SUMMA_B
            PUT(B_TABLE)
            FOUND#=1
            BREAK
          .
        .
        IF ~FOUND#
          B:BKK=BKK
          B:SUMMA =N:SUMMA_B
          ADD(B_TABLE)
        .
        IF F:DBF='W'
          PRINT(RPT:DETAIL)
        ELSE
          OUTA:LINE=FORMAT(NR,@N_4)&CHR(9)&DOK_NR&CHR(9)&FORMAT(N_DATUMS,@D06.)&CHR(9)&N_NOMENKLAT&CHR(9)&NOM_KAT&CHR(9)&|
          NOM_NOSAUKUMS&CHR(9)&LEFT(FORMAT(N:DAUDZUMS,@N-_12.3))&CHR(9)&LEFT(FORMAT(N:SUMMA_B,@N-_12.2))&CHR(9)&|
          LEFT(FORMAT(N:SUMMA_PVN,@N-_11.2))&CHR(9)&LEFT(FORMAT(N:SUMMA_P,@N-_12.2))&CHR(9)&N:VAL&CHR(9)&|
          LEFT(FORMAT(N:T_SUMMA,@N-_9.2))&CHR(9)&LEFT(FORMAT(N:MUITA,@N-_9.2))&CHR(9)&LEFT(FORMAT(N:AKCIZE,@N-_9.2))&|
          CHR(9)&LEFT(FORMAT(N:CITAS,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGO,@N-_14.2))
          ADD(OUTFILEANSI)
        .
     END
     IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
     .
!****************************DRUKÂJAM KOPÂ Ls **************
    KOPA='Kopâ:'
!    VALK = 'Ls'
    VALK = val_uzsk
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&|
        LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&|
        CHR(9)&VALK&CHR(9)&LEFT(FORMAT(TRANSK,@N-_9.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_9.2))&CHR(9)&|
        LEFT(FORMAT(AKCIZK,@N-_9.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
        ADD(OUTFILEANSI)
    .
!****************************DRUKÂJAM PÇC valûtâm **************
    DAUDZUMSK   = 0
    SUMMA_BK    = 0
    SUMMA_PVNK  = 0
    SUMMA_PK    = 0
    MUIK        = 0
    AKCIZK      = 0
    CITASK      = 0
    TRANSK      = 0
    ITOGOK      = 0
    KOPA    = 't.s.'
    GET(K_TABLE,0)
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      !IF RECORDS(K_TABLE)=1 AND (K:VAL='Ls' OR K:VAL='LVL') THEN BREAK.
      IF RECORDS(K_TABLE)=1 AND (((K:VAL='Ls' OR K:VAL='LVL') AND GL:DB_GADS <= 2013) OR (GL:DB_GADS > 2013 AND K:VAL=val_uzsk)) THEN BREAK. !16/12/2013
      IF K:SUMMA_P <> 0
        SUMMA_PK = K:SUMMA_P
        VALK     = K:VAL
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&|
            LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&|
            CHR(9)&VALK&CHR(9)&LEFT(FORMAT(TRANSK,@N-_9.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_9.2))&CHR(9)&|
            LEFT(FORMAT(AKCIZK,@N-_9.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
            ADD(OUTFILEANSI)
        .
        KOPA = ''
      .
    .
!****************************DRUKÂJAM PÇC BKK*******************
    KOPAa='t.s.'
    GET(B_TABLE,0)
    LOOP J# = 1 TO RECORDS(B_TABLE)
      GET(B_TABLE,J#)
      IF B:SUMMA <> 0
        SB  =B:SUMMA
        BKK =B:BKK
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2A)
        ELSE
            OUTA:LINE=KOPAA&CHR(9)&format(BKK,@S5)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SB,@N-_12.2))
            ADD(OUTFILEANSI)
        .
        KOPAA=''
        SB=0
      .
    .
!****************************JA IR ATGRIEZTA PRECE**************
    IF DAUDZUMS_R<0
        KOPA='Atgrieztâ prece'
        VALK = ''
        DAUDZUMSK   = DAUDZUMS_R
        SUMMA_BK    = SUMMA_RB
        SUMMA_PVNK  = 0
        SUMMA_PK    = 0
        MUIK        = 0
        AKCIZK      = 0
        CITASK      = 0
        TRANSK      = 0
        ITOGOK      = SUMMA_R
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&|
            LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&|
            CHR(9)&VALK&CHR(9)&LEFT(FORMAT(TRANSK,@N-_9.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_9.2))&CHR(9)&|
            LEFT(FORMAT(AKCIZK,@N-_9.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_9.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
            ADD(OUTFILEANSI)
        .
    END

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
    IF ERRORCODE() and ERRORCODE() <> BadRecErr
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
N_IenNom             PROCEDURE                    ! Declare Procedure
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
NR                      DECIMAL(4)
ITOGO                   DECIMAL(14,2)
DAUDZUMSK               DECIMAL(12,3)
SUMMA_BK                DECIMAL(12,2)
SUMMA_PK                DECIMAL(12,2)
MUIK                    DECIMAL(10,2)
AKCIZK                  DECIMAL(10,2)
CITASK                  DECIMAL(10,2)
TRANSK                  DECIMAL(10,2)
SUMMA_PVNK              DECIMAL(10,2)
SUMMA_CK                DECIMAL(13,2)
ITOGOK                  DECIMAL(14,2)
BKK                     STRING(5)
NOM_NOS_P               LIKE(NOM:NOS_P)

KOPA_TEXT               STRING(20)
TS_TEXT                 STRING(7)
VAL_VALK                STRING(3)
DAT                     DATE
LAI                     TIME

CN                      STRING(10)
CP                      STRING(5)

N_TABLE              QUEUE,PRE(N)
NOMKEY                 STRING(25)
NOMENKLAT              STRING(21)
MERVIEN                STRING(7)
DAUDZUMS               DECIMAL(12,3)
SUMMA_B                DECIMAL(12,2)
SUMMA_P                DECIMAL(12,2)
VAL                    STRING(3)
MUI                    DECIMAL(10,2)
AKCIZ                  DECIMAL(10,2)
CITAS                  DECIMAL(10,2)
TRANS                  DECIMAL(10,2)
SUMMA_PVN              DECIMAL(10,2)
SUMMA_C                DECIMAL(12,2)
                     .
K_TABLE              QUEUE,PRE(K)
VAL                    STRING(3)
SUMMA_P                DECIMAL(12,2)
                     .
B_TABLE              QUEUE,PRE(B)
BKK                    STRING(5)
SUMMA                  DECIMAL(12,2)
                     .

DAUDZUMS_R          DECIMAL(12,2)
SUMMA_RB            DECIMAL(12,2)
SUMMA_R             DECIMAL(12,2)

VIRSRAKSTS              STRING(110)
FILTRS_TEXT             STRING(100)

!------------------------------------------------------------------------
report REPORT,AT(198,1688,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,500,12000,1188),USE(?unnamed:3)
         STRING(@s45),AT(2854,63,4500,198),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Ârpuspavadzîmes izmaksas'),AT(8365,729,1823,156),USE(?String65),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IE2 '),AT(9479,469,813,156),USE(?String13),CENTER
         STRING(@P<<<#. lapaP),AT(10313,469,,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s100),AT(938,479,8333,177),USE(FILTRS_TEXT),TRN,CENTER
         LINE,AT(8333,885,1875,0),USE(?Line75),COLOR(COLOR:Black)
         LINE,AT(208,677,10833,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2135,1198,0,-521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(208,1146,10833,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(5208,677,0,521),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(3750,677,0,521),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(4479,677,0,521),USE(?Line18:2),COLOR(COLOR:Black)
         LINE,AT(521,1198,0,-521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('NPK'),AT(260,729,260,208),USE(?String16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(552,729,1563,208),USE(?String16:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces nosaukums'),AT(2167,729,1563,208),USE(?String16:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(3781,729,677,208),USE(?String16:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Bilances'),AT(4510,729,677,208),USE(?String16:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, '),AT(5240,729,625,208),USE(?String16:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5250,938,625,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Transp.'),AT(7750,729,573,208),USE(?String16:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6938,677,0,521),USE(?Line81:2),COLOR(COLOR:Black)
         LINE,AT(5885,677,0,521),USE(?Line28:2),COLOR(COLOR:Black)
         STRING('Vçrtîba ar PVN,'),AT(5927,729,990,208),USE(?String16:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Parâds'),AT(6969,729,729,208),USE(?String16:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,677,0,521),USE(?Line81:82),COLOR(COLOR:Black)
         STRING('Muita'),AT(8375,938,573,208),USE(?String16:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Akcîze'),AT(9000,938,573,208),USE(?String216:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Citas'),AT(9615,938,573,208),USE(?String16:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ, '),AT(10240,729,781,208),USE(?String16:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(10250,927,781,208),USE(val_uzsk,,?val_uzsk:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(11042,677,0,521),USE(?Line10:5),COLOR(COLOR:Black)
         LINE,AT(10208,677,0,521),USE(?Line10:4),COLOR(COLOR:Black)
         LINE,AT(9583,885,0,313),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(8958,885,0,313),USE(?Line10:2),COLOR(COLOR:Black)
         STRING(@s21),AT(552,938,1563,208),USE(nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba, '),AT(4510,844,677,208),USE(?String16:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4667,979,344,167),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valûtâ'),AT(5927,938,990,208),USE(?String16:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(P/Z, val.)'),AT(7750,938,573,208),USE(?String16:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8333,677,0,521),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(208,1198,0,-521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s110),AT(938,271,8333,177),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(208,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         STRING(@N4),AT(240,10,260,156),USE(NR),RIGHT
         STRING(@S21),AT(552,10,1563,156),USE(N:NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_14.2),AT(10240,10,781,156),USE(itogo),RIGHT
         STRING(@N_12.2),AT(6958,10,729,156),USE(N:SUMMA_C),RIGHT
         LINE,AT(11042,-10,0,198),USE(?Line12:13),COLOR(COLOR:Black)
         LINE,AT(2135,-10,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         STRING(@S50),AT(2167,10,1563,156),USE(NOM_NOS_P),LEFT
         LINE,AT(3750,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         STRING(@N-_12.3B),AT(3781,10,677,156),USE(N:DAUDZUMS),RIGHT
         LINE,AT(4479,-10,0,198),USE(?Line12:6),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(4510,10,677,156),USE(N:SUMMA_B),RIGHT
         LINE,AT(5208,-10,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(5240,10,625,156),USE(N:SUMMA_pvn),RIGHT
         LINE,AT(5885,-10,0,198),USE(?Line12:8),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5938,10,677,156),USE(N:SUMMA_P),RIGHT
         STRING(@S3),AT(6667,10,260,156),USE(N:VAL),LEFT
         LINE,AT(8333,-10,0,198),USE(?Line12:9),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(8365,10,573,156),USE(N:mui),RIGHT
         LINE,AT(8958,-10,0,198),USE(?Line12:10),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(8990,10,573,156),USE(N:akciz),RIGHT
         LINE,AT(9583,-10,0,198),USE(?Line12:11),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(9615,10,573,156),USE(N:citas),RIGHT
         LINE,AT(10208,-10,0,198),USE(?Line12:12),COLOR(COLOR:Black)
         LINE,AT(6938,-10,0,198),USE(?Line12:7),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line12:14),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(7740,10,573,156),USE(N:trans),RIGHT
         LINE,AT(521,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(208,0,0,115),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(521,0,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(2135,0,0,63),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(3750,0,0,63),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(4479,0,0,115),USE(?Line19:17),COLOR(COLOR:Black)
         LINE,AT(5208,0,0,115),USE(?Line19:11),COLOR(COLOR:Black)
         LINE,AT(6938,0,0,115),USE(?Line19:3),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,115),USE(?Line19:27),COLOR(COLOR:Black)
         LINE,AT(8333,0,0,115),USE(?Line19:15),COLOR(COLOR:Black)
         LINE,AT(8958,0,0,115),USE(?Line19:14),COLOR(COLOR:Black)
         LINE,AT(9583,0,0,115),USE(?Line19:13),COLOR(COLOR:Black)
         LINE,AT(10208,0,0,115),USE(?Line19:12),COLOR(COLOR:Black)
         LINE,AT(11042,0,0,115),USE(?Line19:4),COLOR(COLOR:Black)
         LINE,AT(208,52,10833,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(5885,0,0,115),USE(?Line19:16),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed)
         LINE,AT(208,-10,0,198),USE(?Line19:5),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,198),USE(?Line19:18),COLOR(COLOR:Black)
         STRING(@s20),AT(573,10,1458,156),USE(KOPA_TEXT),LEFT
         LINE,AT(8333,-10,0,198),USE(?Line19:19),COLOR(COLOR:Black)
         LINE,AT(8958,-10,0,198),USE(?Line119:19),COLOR(COLOR:Black)
         LINE,AT(9583,-10,0,198),USE(?Line191:19),COLOR(COLOR:Black)
         LINE,AT(10208,-10,0,198),USE(?Line19:31),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,198),USE(?Line19:20),COLOR(COLOR:Black)
         STRING(@N-_14.3B),AT(3573,10,885,156),USE(DAUDZUMSk),RIGHT
         STRING(@N-_13.2B),AT(4510,10,677,156),USE(SUMMA_BK),RIGHT
         STRING(@N-_11.2B),AT(5229,10,625,156),USE(SUMMA_pvnk),RIGHT
         STRING(@N_12.2B),AT(6958,10,729,156),USE(SUMMA_CK),RIGHT
         STRING(@N-_10.2B),AT(7740,10,573,156),USE(transk),RIGHT
         STRING(@N_10.2B),AT(8365,10,573,156),USE(muik),RIGHT
         STRING(@N_10.2B),AT(8990,10,573,156),USE(akcizk),RIGHT
         STRING(@N_10.2B),AT(9615,10,573,156),USE(citask),RIGHT
         STRING(@N-_14.2B),AT(10240,10,781,156),USE(itogok),RIGHT
         LINE,AT(5208,-10,0,198),USE(?Line19:6),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(5938,10,677,156),USE(SUMMA_PK),RIGHT
         STRING(@s3),AT(6667,10,260,156),USE(VAL_VALK),LEFT
         LINE,AT(5885,-10,0,198),USE(?Line19:7),COLOR(COLOR:Black)
         LINE,AT(6938,-10,0,198),USE(?Line19:23),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line19:28),COLOR(COLOR:Black)
       END
RPT_FOOT2A DETAIL,AT(,-10,,177)
         STRING(@s5),AT(3229,20,365,156),USE(B:BKK),RIGHT
         LINE,AT(4479,0,0,198),USE(?Line19:22),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(4531,21,677,156),USE(B:SUMMA),RIGHT
         LINE,AT(5208,0,0,198),USE(?Line19:9),COLOR(COLOR:Black)
         LINE,AT(5885,0,0,198),USE(?Line19:24),COLOR(COLOR:Black)
         LINE,AT(6938,0,0,198),USE(?Line19:21),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,198),USE(?Line19:29),COLOR(COLOR:Black)
         LINE,AT(8333,0,0,198),USE(?Line19:10),COLOR(COLOR:Black)
         LINE,AT(8958,0,0,198),USE(?Line19:26),COLOR(COLOR:Black)
         LINE,AT(9583,0,0,198),USE(?Line19:25),COLOR(COLOR:Black)
         LINE,AT(10208,0,0,198),USE(?Line19:32),COLOR(COLOR:Black)
         LINE,AT(11042,0,0,198),USE(?Line19:30),COLOR(COLOR:Black)
         STRING(@s7),AT(573,21,469,156),USE(TS_TEXT),LEFT
         LINE,AT(208,0,0,198),USE(?Line19:8),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,250),USE(?unnamed:2)
         LINE,AT(208,0,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(4479,0,0,63),USE(?Line35:2),COLOR(COLOR:Black)
         LINE,AT(5208,0,0,63),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(5885,0,0,63),USE(?Line36:2),COLOR(COLOR:Black)
         LINE,AT(6938,0,0,63),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,63),USE(?Line36:3),COLOR(COLOR:Black)
         LINE,AT(8333,0,0,63),USE(?Line136),COLOR(COLOR:Black)
         LINE,AT(8958,0,0,63),USE(?Line316),COLOR(COLOR:Black)
         LINE,AT(9583,0,0,63),USE(?Line361),COLOR(COLOR:Black)
         LINE,AT(10208,0,0,63),USE(?Line236),COLOR(COLOR:Black)
         LINE,AT(11042,0,0,63),USE(?Line326),COLOR(COLOR:Black)
         LINE,AT(208,52,10833,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(219,83,510,146),USE(?String52),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(792,83,552,146),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1667,83,208,146),USE(?String54),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1875,83),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(9948,83),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10573,83),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(198,7950,12000,63)
         LINE,AT(208,0,10833,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  BIND('S_DAT',S_DAT)
  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)
  BIND('CYCLEpar_k',CYCLEPAR_K)

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
  BIND(PAV:RECORD)
  BIND(PAR:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Forma IE2'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='Izziòa par ienâkuðâm ('&D_K&',S-nomenkl.) precçm no '&format(S_DAT,@d06.)&' lîdz '&format(B_DAT,@d06.)&|
      ' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      IF PAR_NR = 999999999 !VISI
         FILTRS_TEXT=GETFILTRS_TEXT('001110000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
      ELSE
         FILTRS_TEXT=GETFILTRS_TEXT('000010000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' '&GETPAR_K(PAR_NR,2,2)
      .
      CP = 'N11'
      CLEAR(nol:RECORD)
      IF ~(PAR_NR = 999999999) !KONKRÇTS PARTNERIS
         CN = 'N1011'
         CLEAR(nol:RECORD)                              
         NOL:PAR_NR = PAR_NR
         NOL:DATUMS = s_dat
         NOL:D_K = D_K
         SET(nol:PAR_KEY,NOL:PAR_KEY)
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT)'
      ELSIF NOMENKLAT[1]       !IR JÇGA FILTRÇT PÇC NOMENKLATÛRAS
         CN = 'N1011'
         NOL:NOMENKLAT=NOMENKLAT
         SET(nol:NOM_KEY,nol:NOM_KEY)
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT) AND ~CYCLEPAR_K(CP)'
      ELSE
         CN = 'N1001'
         NOL:DATUMS = s_dat
         NOL:D_K = D_K
         SET(nol:DAT_KEY,nol:DAT_KEY)
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
          IF ~OPENANSI('IENNOM.TXT')
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
!             OUTA:LINE='Npk '&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances'&CHR(9)&|
!             'PVN, Ls'&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&'Parâds'&CHR(9)&'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&|
!             CHR(9)&CHR(9)&CHR(9)&'Kopâ, Ls'
!             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&NOMENKLAT&CHR(9)&CHR(9)&CHR(9)&'vçrtîba,Ls'&CHR(9)&CHR(9)&'ar PVN,val.'&CHR(9)&CHR(9)&|
!             CHR(9)&'(P/Z,val.)'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'
             OUTA:LINE='Npk '&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances'&CHR(9)&|
             'PVN, '&val_uzsk&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&'Parâds'&CHR(9)&'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&|
             CHR(9)&CHR(9)&CHR(9)&'Kopâ, '&val_uzsk
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&NOMENKLAT&CHR(9)&CHR(9)&CHR(9)&'vçrtîba,'&val_uzsk&CHR(9)&CHR(9)&'ar PVN,val.'&CHR(9)&CHR(9)&|
             CHR(9)&'(P/Z,val.)'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'
             ADD(OUTFILEANSI)
          ELSE !WORD
!             OUTA:LINE='Npk '&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances vçrtîba,Ls'&CHR(9)&|
!             'PVN, Ls'&CHR(9)&'Vçrtîba ar PVN,val.'&CHR(9)&CHR(9)&'Parâds'&CHR(9)&'Transports (P/Z,val.)'&CHR(9)&|
!             'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'&CHR(9)&'Kopâ, Ls'
             OUTA:LINE='Npk '&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances vçrtîba,'&val_uzsk&CHR(9)&|
             'PVN, '&val_uzsk&CHR(9)&'Vçrtîba ar PVN,val.'&CHR(9)&CHR(9)&'Parâds'&CHR(9)&'Transports (P/Z,val.)'&CHR(9)&|
             'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'&CHR(9)&'Kopâ, Ls'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NNR#+=1
        ?Progress:UserString{Prop:Text}=NNR#
        DISPLAY(?Progress:UserString)
!        IF ~NOMENKLAT[1] OR (NOMENKLAT[1] AND ~CYCLENOM(NOL:NOMENKLAT) AND ~(NOL:U_NR=1)) !?
        IF ~(NOL:U_NR=1)
           K:VAL=NOL:VAL
           GET(K_TABLE,K:VAL)
           IF ERROR()
             K:VAL=NOL:VAL
             K:SUMMA_P = CALCSUM(4,2)
             ADD(K_TABLE,K:VAL)
             SORT(K_TABLE,K:VAL)
           ELSE
             K:SUMMA_P+=CALCSUM(4,2)
             PUT(K_TABLE)
           .
   !*************************SADALAM PÇC NOMENKLATÛRÂM ********
           GET(N_TABLE,0)
           N:NOMKEY=NOL:NOMENKLAT&NOL:VAL
           GET(N_TABLE,N:NOMKEY)
           IF ERROR()
             N:NOMKEY=NOL:NOMENKLAT&NOL:VAL
             N:NOMENKLAT=NOL:NOMENKLAT
             N:MERVIEN  =' '
             N:DAUDZUMS =NOL:DAUDZUMS
             N:SUMMA_B  =CALCSUM(15,2)
             N:SUMMA_P  =CALCSUM(4,2)  !VALÛTÂ AR PVN-A
             IF NOL:BAITS
               N:SUMMA_C = CALCSUM(4,2)
             ELSE
               N:SUMMA_C = 0
             .
             N:SUMMA_PVN=CALCSUM(17,2)
             N:VAL      =NOL:VAL
             N:MUI      =NOL:MUITA
             N:AKCIZ    =NOL:AKCIZE
             N:CITAS    =NOL:CITAS
             N:TRANS    =NOL:T_SUMMA
             ADD(N_TABLE)
             SORT(N_TABLE,N:NOMKEY)
           ELSE
             N:DAUDZUMS+=NOL:DAUDZUMS
             N:SUMMA_B +=CALCSUM(15,2)
             N:SUMMA_P +=CALCSUM(4,2)  !VALÛTÂ AR PVN -A
             IF NOL:BAITS
               N:SUMMA_C += CALCSUM(4,2)
             .
             N:SUMMA_PVN+= CALCSUM(17,2)
             N:MUI      += NOL:MUITA
             N:AKCIZ    += NOL:AKCIZE
             N:CITAS    += NOL:CITAS
             N:TRANS    += NOL:T_SUMMA*BANKURS(NOL:VAL,NOL:DATUMS)
             PUT(N_TABLE)
           .
           IF NOL:DAUDZUMS<0  !ATGRIEZTA PRECE
              DAUDZUMS_R += NOL:DAUDZUMS
              SUMMA_RB   += CALCSUM(15,2)
              SUMMA_R    += CALCSUM(15,2)+CALCSUM(17,2)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    LOOP N#=1 TO RECORDS(N_TABLE)
      GET(N_TABLE,N#)
      IF ~N:DAUDZUMS AND N:SUMMA_B
         KLUDA(0,'Pârbaudiet kartiòu : '&nom:nomenklat&' '&NOM:NOS_P)
      .
      NR+=1
!      MERVIEN  = N:MERVIEN
!      DAUDZUMS = N:DAUDZUMS
!      SUMMA_B  = N:SUMMA_B
!      SUMMA_P  = N:SUMMA_P !VALÛTÂ
!      SUMMA_PVN= N:SUMMA_PVN
!      SUMMA_C  = N:SUMMA_C
!      NOS      = N:NOS
!      MUI      = N:MUI
!      AKCIZ    = N:AKCIZ
!      CITAS    = N:CITAS
!      TRANS    = N:TRANS
      NOM_NOS_P   = GETNOM_K(N:NOMENKLAT,2,2)
      SUMMA_BK   += N:SUMMA_B
      SUMMA_PVNK += N:SUMMA_PVN
      SUMMA_PK   += N:SUMMA_B+N:SUMMA_PVN !LS
      DAUDZUMSK  += N:DAUDZUMS
      MUIK       += N:MUI
      AKCIZK     += N:AKCIZ
      CITASK     += N:CITAS
      TRANSK     += N:TRANS
      SUMMA_CK   += N:SUMMA_C
      ITOGO = N:SUMMA_B + N:SUMMA_PVN + N:MUI + N:AKCIZ + N:CITAS + N:TRANS
      ITOGOK += ITOGO
      IF ~F:DTK
        IF F:DBF='W'
          PRINT(RPT:DETAIL)
        ELSE !WORD,EXCEL
          OUTA:LINE=NR&CHR(9)&N:NOMENKLAT&CHR(9)&NOM_NOS_P&CHR(9)&LEFT(FORMAT(N:DAUDZUMS,@N-_12.3))&CHR(9)&|
          LEFT(FORMAT(N:SUMMA_B,@N-_12.2))&CHR(9)&LEFT(FORMAT(N:SUMMA_PVN,@N-_12.2))&CHR(9)&LEFT(FORMAT(N:SUMMA_P,@N-_12.2))&|
          CHR(9)&N:VAL&CHR(9)&LEFT(FORMAT(N:SUMMA_C,@N-_13.2))&CHR(9)&LEFT(FORMAT(N:TRANS,@N-_10.2))&CHR(9)&|
          LEFT(FORMAT(N:MUI,@N-_10.2))&CHR(9)&LEFT(FORMAT(N:AKCIZ,@N-_10.2))&CHR(9)&LEFT(FORMAT(N:CITAS,@N-_10.2))&|
          CHR(9)&LEFT(FORMAT(ITOGO,@N-_14.2))
          ADD(OUTFILEANSI)
        .
      .
!*************************SADALAM PÇC BKK*******************
      FOUND#=0
      BKK=GETNOM_K(N:NOMENKLAT,2,6)  !ATGRIEÞ BKK NO NOM_K VAI SYSTEM
      LOOP J#=1 TO RECORDS(B_TABLE)
         GET(B_TABLE,J#)
         IF B:BKK=BKK
            B:SUMMA+=N:SUMMA_B
            PUT(B_TABLE)
            FOUND#=1
            BREAK
         .
      .
      IF ~FOUND#
         B:BKK=BKK
         B:SUMMA =N:SUMMA_B
         ADD(B_TABLE)
      .
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    .
    KOPA_TEXT='Kopâ:'
    !VAL_VALK = 'Ls'
    VAL_VALK = val_uzsk
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
        OUTA:LINE=KOPA_TEXT&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_12.2))&|
        CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&CHR(9)&VAL_VALK&CHR(9)&|
        LEFT(FORMAT(SUMMA_CK,@N-_13.2))&CHR(9)&LEFT(FORMAT(TRANSK,@N-_10.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_10.2))&|
        CHR(9)&LEFT(FORMAT(AKCIZK,@N-_10.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_10.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
        ADD(OUTFILEANSI)
    .
!****************************DRUKÂJAM PÇC valûtâm **************
    DAUDZUMSK  = 0
    SUMMA_BK   = 0
    SUMMA_PVNK = 0
    SUMMA_PK   = 0
    SUMMA_CK   = 0
    MUIK       = 0
    AKCIZK     = 0
    CITASK     = 0
    TRANSK     = 0
    ITOGOK     = 0
    KOPA_TEXT='t.s.'
    GET(K_TABLE,0)
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      IF K:SUMMA_P>0
        SUMMA_PK = K:SUMMA_P
        VAL_VALK = K:VAL
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)                     
        ELSE
            OUTA:LINE=KOPA_TEXT&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3B))&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_12.2B))&|
            CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_12.2B))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&CHR(9)&VAL_VALK&CHR(9)&|
            LEFT(FORMAT(SUMMA_CK,@N-_13.2B))&CHR(9)&LEFT(FORMAT(TRANSK,@N-_10.2B))&CHR(9)&LEFT(FORMAT(MUIK,@N-_10.2B))&|
            CHR(9)&LEFT(FORMAT(AKCIZK,@N-_10.2B))&CHR(9)&LEFT(FORMAT(CITASK,@N-_10.2B))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2B))
            ADD(OUTFILEANSI)
        .
        kopa_TEXT=''
      .
    .
!****************************DRUKÂJAM PÇC BKK*******************
    TS_TEXT='t.s.'
    GET(B_TABLE,0)
    LOOP J# = 1 TO RECORDS(B_TABLE)
      GET(B_TABLE,J#)
      IF B:SUMMA <> 0
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2A)
        ELSE
            OUTA:LINE=TS_TEXT&CHR(9)&B:BKK&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(B:SUMMA,@N-_12.2))
            ADD(OUTFILEANSI)
        .
        TS_TEXT=''
      .
    .
!****************************Ja ir atgriezta prece*******************
    IF DAUDZUMS_R<0
        KOPA_TEXT ='Atgriezta prece'
        VAL_VALK  = ''
        DAUDZUMSK = DAUDZUMS_R
        SUMMA_BK  = SUMMA_RB
        SUMMA_PVNK= 0
        SUMMA_PK  = 0
        SUMMA_CK  = 0
        MUIK      = 0
        AKCIZK    = 0
        CITASK    = 0
        TRANSK    = 0
        ITOGOK    = SUMMA_R
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            OUTA:LINE=KOPA_TEXT&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_12.2))&|
            CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_12.2B))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2B))&CHR(9)&VAL_VALK&CHR(9)&|
            LEFT(FORMAT(SUMMA_CK,@N-_13.2B))&CHR(9)&LEFT(FORMAT(TRANSK,@N-_10.2B))&CHR(9)&LEFT(FORMAT(MUIK,@N-_10.2B))&|
            CHR(9)&LEFT(FORMAT(AKCIZK,@N-_10.2B))&CHR(9)&LEFT(FORMAT(CITASK,@N-_10.2B))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2B))
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
  IF FilesOpened
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(K_TABLE)
  FREE(B_TABLE)
  FREE(N_TABLE)
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
     IF ERRORCODE() OR ~(NOL:PAR_NR=PAR_NR) THEN VISS#=TRUE.
  ELSIF NOMENKLAT[1]                     !IR FILTRS PÇC NOMENKLATÛRAS
    IF ERRORCODE() OR CYCLENOM(NOL:NOMENKLAT)=2 THEN VISS#=TRUE.
  ELSE
    IF ERRORCODE() OR NOL:DATUMS > B_DAT THEN VISS#=TRUE.
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
