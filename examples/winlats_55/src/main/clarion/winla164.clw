                     MEMBER('winlats.clw')        ! This is a MEMBER module
K_B_FIFO             PROCEDURE                    ! Declare Procedure
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

!---------------------------------------------------------------------------
Process:View         VIEW(NOL_KOPS)
                       PROJECT(KOPS:NOMENKLAT)
                       PROJECT(KOPS:KATALOGA_NR)
                       PROJECT(KOPS:U_NR)
                       PROJECT(KOPS:NOS_S)
                       PROJECT(KOPS:STATUSS)
                     END
!---------------------------------------------------------------------------

RAZTABLE             QUEUE,PRE(R)
RAZ                    STRING(3)
DAUDZUMS               DECIMAL(13,3)
BILVERT                DECIMAL(13,3)
                     .

B_TABLE              QUEUE,PRE(B)
BKK                    STRING(5)
SUMMA1                 REAL
SUMMAD                 REAL
SUMMAK                 REAL
SUMMA2                 REAL
                     .

FIFO                 QUEUE,PRE(F)
KEY                    STRING(10)
DATUMS                 LONG
D_K                    string(2)
NOL_NR                 BYTE
DAUDZUMS               DECIMAL(11,3)
SUMMA                  DECIMAL(11,2)
                     .

C_DAT                LONG
NR                   DECIMAL(4)
NOSAUKUMS            STRING(29)
ERR                  STRING(8)
VID                  REAL
CTRL_I               DECIMAL(13,3)
REALIZETS            DECIMAL(13,3)
ATLIKUMS_N           DECIMAL(13,3),DIM(25)
DAUDZUMS_N           DECIMAL(13,3),DIM(25)
DAUDZUMS             DECIMAL(13,3)
DAUDZUMS_nol         DECIMAL(13,3)
SUMMA_K              DECIMAL(13,2)
FMI_K                DECIMAL(13,2)
FMI_TS               DECIMAL(13,2)
REA_TS               DECIMAL(13,3)
BILVERT              DECIMAL(14,2)
BILVERT1             DECIMAL(14,2)
BILVERTD             DECIMAL(14,2)
BILVERTK             DECIMAL(14,2)
BILVERT2             DECIMAL(14,2)
DAU1                 DECIMAL(13,3)
DAUD                 DECIMAL(13,3)
DAUK                 DECIMAL(13,3)
DAU2                 DECIMAL(13,3)
BILVERT1_BKK         DECIMAL(14,2)
BILVERTD_BKK         DECIMAL(14,2)
BILVERTK_BKK         DECIMAL(14,2)
BILVERT2_BKK         DECIMAL(14,2)
BILVERT1_K           DECIMAL(14,2)
BILVERTD_K           DECIMAL(14,2)
BILVERTK_K           DECIMAL(14,2)
BILVERT2_K           DECIMAL(14,2)
BILVERT_N            DECIMAL(14,2),DIM(25)
BILVERT_NOL          DECIMAL(14,2)
TS                   STRING(4)
BKK                  STRING(5)
DAT                  DATE
LAI                  TIME
NOS_P                STRING(35)
DAUDZUMS_R           DECIMAL(14,3)
SUMMA_R              DECIMAL(12,2)
SUMMA_RD             DECIMAL(12,2)
SUMMA_RK             DECIMAL(12,2)

VS_DAUDZUMS          DECIMAL(13,3),DIM(2)
VS_SUMMA             DECIMAL(13,3),DIM(2)
VS_FIFO_TEXT         STRING(60)

SAV_JOB_NR           LIKE(JOB_NR)
ATGR_TEXT            STRING(80)
ATGR_TEXT2           STRING(120)
KOPA                 STRING(120)
VMIS                 STRING(1),DIM(25,2)
ERRK                 USHORT
BRIK                 USHORT
ERRORTEXT            STRING(100)

!---------------------------------------------------------------------------
report REPORT,AT(100,1652,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,100,8000,1552),USE(?unnamed:4)
         LINE,AT(104,1510,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Nosaukums'),AT(2083,1198,1250,208),USE(?String10:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(3646,1198,938,208),USE(?String10:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Ienâcis'),AT(4635,1198,1042,208),USE(?String10:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Izgâjis'),AT(5729,1198,1042,208),USE(?String10:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(6823,1198,1042,208),USE(?String10:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1760,156,4635,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Bilances atskaite'),AT(313,208),USE(?String45),TRN,FONT(,8,,FONT:bold,CHARSET:ANSI)
         STRING('Preèu apgrozîjums pçc bilances vçrtîbas'),AT(2031,469,4115,260),USE(?String4),CENTER, |
             FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1083,708,6021,208),USE(VS_FIFO_TEXT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7219,875,625,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(104,1042,7760,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1719,1042,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3594,1042,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4583,1042,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5677,1042,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6771,1042,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7865,1042,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(365,1094,1146,208),USE(?String10),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(135,1271,1563,208),USE(nomenklat),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1042,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,323),USE(?unnamed:5)
         LINE,AT(104,-10,0,324),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@s21),AT(156,10,1573,156),USE(kops:nomenklat),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(1719,0,0,324),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@s35),AT(1760,10,1823,156),USE(nos_p),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(3594,-10,0,324),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(3646,10,854,156),USE(BILVERT1),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(4583,-10,0,324),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(4740,10,854,156),USE(BILVERTD),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(5677,-10,0,324),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5833,10,854,156),USE(BILVERTK),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(6771,-10,0,324),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(6927,10,854,156),USE(BILVERT2),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s8),AT(2938,146,615,156),USE(ERR),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(7865,-10,0,324),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@N-_12.3),AT(3708,146,854,156),USE(DAU1),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.3),AT(4802,146,854,156),USE(DAUD),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.3),AT(5896,146,854,156),USE(DAUK),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.3),AT(6990,146,854,156),USE(DAU2),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s8),AT(1813,146,615,156),USE(nom:mervien),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(104,313,7760,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
RPT_FOOTKOPA DETAIL,AT(,,,250)
         LINE,AT(104,-10,0,270),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(1719,0,0,270),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(3594,-10,0,270),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(4583,-10,0,270),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(5677,-10,0,270),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,270),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,270),USE(?Line2:21),COLOR(COLOR:Black)
         STRING('Kopâ :'),AT(156,42,417,156),USE(?String33),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(3646,42,854,156),USE(BILVERT1_K),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(4740,42,854,156),USE(BILVERTD_K),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(5833,42,854,156),USE(BILVERTK_K),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(6927,42,854,156),USE(BILVERT2_K),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOTBKK DETAIL,AT(,,,188)
         LINE,AT(104,0,0,200),USE(?Line17),COLOR(COLOR:Black)
         STRING(@s4),AT(260,21,344,156),USE(TS),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s5),AT(729,21,417,156),USE(BKK),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(1719,0,0,200),USE(?Line17:2),COLOR(COLOR:Black)
         LINE,AT(3594,0,0,200),USE(?Line17:3),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(3646,21,854,156),USE(BILVERT1_BKK),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(4583,0,0,200),USE(?Line17:4),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(4740,21,854,156),USE(BILVERTD_BKK),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(5677,0,0,200),USE(?Line17:5),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5833,21,854,156),USE(BILVERTK_BKK),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(6771,0,0,200),USE(?Line17:6),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(6927,21,854,156),USE(BILVERT2_BKK),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(7865,0,0,200),USE(?Line17:7),COLOR(COLOR:Black)
       END
RPT_RETURN DETAIL,AT(,,,188),USE(?unnamed:3)
         LINE,AT(104,0,0,200),USE(?Line717),COLOR(COLOR:Black)
         LINE,AT(1719,0,0,200),USE(?Line717:2),COLOR(COLOR:Black)
         LINE,AT(3594,0,0,200),USE(?Line17:30),COLOR(COLOR:Black)
         LINE,AT(4583,0,0,200),USE(?Line17:40),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5833,21,854,156),USE(SUMMA_R,,?SUMMA_R:2),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(4740,21,854,156),USE(SUMMA_R),TRN,RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(5677,0,0,200),USE(?Line17:50),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,200),USE(?Line17:60),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,200),USE(?Line17:70),COLOR(COLOR:Black)
         STRING('Mçs atgriezâm par summu'),AT(146,0,1573,156),USE(?STRING999),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
RPT_PAVISAM DETAIL,AT(,,,188),USE(?PAVISAM)
         LINE,AT(104,0,0,200),USE(?Line717P),COLOR(COLOR:Black)
         LINE,AT(1719,0,0,200),USE(?Line717:2P),COLOR(COLOR:Black)
         LINE,AT(3594,0,0,200),USE(?Line17:30P),COLOR(COLOR:Black)
         LINE,AT(4583,0,0,200),USE(?Line17:40P),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5833,21,854,156),USE(SUMMA_RK),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5677,0,0,200),USE(?Line17:50P),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,200),USE(?Line17:60P),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,200),USE(?Line17:70P),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(4740,21,854,156),USE(SUMMA_RD),TRN,RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Pavisam :'),AT(146,0,1406,156),USE(?STRING999:2),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOTEND DETAIL,AT(,,,271),USE(?unnamed)
         LINE,AT(104,0,0,62),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(1719,0,0,62),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(3594,0,0,62),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(4583,0,0,62),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(5677,0,0,62),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,62),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,62),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(208,73,521,156),USE(?String38),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(688,73,573,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1344,73,229,156),USE(?String38:2),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1563,73,156,156),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6708,73,625,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7354,73,594,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@s100),AT(2000,104,4531,156),USE(ERRORTEXT),TRN,CENTER
       END
RPT_KOPA DETAIL,AT(,,,156),USE(?unnamed:2)
         STRING(@s120),AT(125,0,7708,156),USE(KOPA),TRN,LEFT
       END
       FOOTER,AT(100,11450,8000,63)
         LINE,AT(104,0,7760,0),USE(?Line1:6),COLOR(COLOR:Black)
       END
     END


Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(65,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  CHECKOPEN(GLOBAL,1)

  dat=today()
  lai=clock()
  SAV_JOB_NR=JOB_NR
  LOOP I#= 1 TO NOL_SK
     JOB_NR=I#+15
     CHECKOPEN(SYSTEM,1)
     IF BAND(SYS:BAITS1,00000100B) !Vairumtirdzniecîba
        VMIS[I#,1]='V'
     ELSE
        VMIS[I#,1]='M'
     .
  .
  JOB_NR=SAV_JOB_NR
  CHECKOPEN(SYSTEM,1)
  CASE GL:FMI_TIPS
  OF 'VS'
     VS_FIFO_TEXT=CLIP(MENESISunG)&' VS metode'
  ELSE
     VS_FIFO_TEXT=CLIP(MENESISunG)&' FIFO metode'
  .
  IF BAND(REG_NOL_ACC,00010000b) ! ATÏAUTA KOMPLEKTÂCIJA
     KOPA='Raþojumi tiek ignorçti, paðizmaksu rçíinam pçc R norakstîtajâm sastâvdaïâm'
  .

  IF NOL_KOPS::USED=0
     CHECKOPEN(NOL_KOPS,1)
  .
  NOL_KOPS::USED+=1
  IF NOL_FIFO::USED=0
     CHECKOPEN(NOL_FIFO,1)
  .
  NOL_FIFO::USED+=1
  BIND(KOPS:RECORD)

  FilesOpened=TRUE
  RecordsToProcess = RECORDS(NOL_KOPS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Preèu apgrozîjums pçc bilances vçrtîbas '&GL:FMI_TIPS
  ?Progress:UserString{Prop:Text}=''
  SEND(NOL_KOPS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KOPS:RECORD)
      kops:nomenklat=nomenklat
      SET(KOPS:NOM_KEY,KOPS:NOM_KEY)
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
          IF ~OPENANSI('KBFIFO.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='Bilances atskaite'
          ADD(OUTFILEANSI)
          OUTA:LINE=VS_FIFO_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='NPK'&CHR(9)&'Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&'Atlikums'&CHR(9)&'Ienâcis'&CHR(9)&|
             'Izgâjis'&CHR(9)&'Atlikums'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&NOMENKLAT
             ADD(OUTFILEANSI)
          ELSE
             OUTA:LINE='NPK'&CHR(9)&'Nomenklatûra '&NOMENKLAT&CHR(9)&'Nosaukums'&CHR(9)&'Atlikums'&CHR(9)&'Ienâcis'&CHR(9)&|
             'Izgâjis'&CHR(9)&'Atlikums'
             ADD(OUTFILEANSI)
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
      .
!      STOP(FORMAT(S_DAT,@D6))

    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(KOPS:NOMENKLAT)
        IF ~(BAND(REG_NOL_ACC,00010000b) AND GETNOM_K(KOPS:NOMENKLAT,0,16)='R')! ~(ATÏAUTA KOMPLEKTÂCIJA UN RAÞOJUMS)
           nk#+=1
           ?Progress:UserString{Prop:Text}=NK#
           DISPLAY(?Progress:UserString)
           CHECKKOPS('POZICIONÇTS',0,0) !UZ REQ=0 PÂRBÛVÇJAM, JA MAINÎTS
           NR+=1
           CLEAR(ATLIKUMS_N)
           ERR=''
           CTRL_I=0
           BILVERTD=0
           BILVERTK=0
           DAU1=0
           DAUD=0
           DAUK=0
           DAU2=0
           CLEAR(VS_DAUDZUMS)
           CLEAR(VS_SUMMA)

           LOOP X#=1 TO 2
              EXECUTE X#
                 C_DAT=S_DAT-1 !UZ S_DAT(RÎTS)
                 C_DAT=B_DAT   !UZ B_DAT
              .
!----------PIRMAJÂ PIEGÂJIENÂ SAMEKLÂJAM MÛSU ATGRIEZTO PRECI, SASKAITAM REALIZÂCIJU UN ATLIKUMUS NOLIKTAVÂS------

              REALIZETS=0
              BILVERT=0
              DAUDZUMS=0
              CLEAR(FIFO:RECORD)
              FIFO:U_NR=KOPS:U_NR
!              FIFO:DATUMS=DATE(1,1,DB_GADS)
              FIFO:DATUMS=DB_S_DAT
              SET(FIFO:NR_KEY,FIFO:NR_KEY)  !U_NR,DATUMS,D_K
              LOOP
                 NEXT(NOL_FIFO)
!                 IF ERROR() OR ~(FIFO:U_NR=KOPS:U_NR AND (FIFO:DATUMS<=C_DAT OR FIFO:D_K='A')) THEN BREAK.
                 IF ERROR() OR ~(FIFO:U_NR=KOPS:U_NR) OR FIFO:DATUMS>C_DAT+1 THEN BREAK.
                 IF  ~(FIFO:DATUMS<=C_DAT OR FIFO:D_K='A') THEN CYCLE.  !A&K 01.01.YYYY
                 F:KEY     =FIFO:DATUMS&FIFO:D_K
                 F:DATUMS  =FIFO:DATUMS
                 F:NOL_NR  =FIFO:NOL_NR
                 F:D_K     =FIFO:D_K
                 F:DAUDZUMS=FIFO:DAUDZUMS
                 F:SUMMA   =FIFO:SUMMA
                 ADD(FIFO)
                 CASE FIFO:D_K
                 OF 'A '
                    IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU
                       REALIZETS+=ABS(FIFO:DAUDZUMS)
                    ELSE
                       VS_DAUDZUMS[X#]+=FIFO:DAUDZUMS
                       VS_SUMMA[X#]+=FIFO:SUMMA
                       IF X#=2 !UZ B_DAT
                          DAU1+=FIFO:DAUDZUMS  !ATLIKUMS
                          DAU2+=FIFO:DAUDZUMS
                       .
                    .
                 OF 'D '
                 OROF 'DR'
                    IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU (VARBÛT NE?)
                       REALIZETS+=ABS(FIFO:DAUDZUMS)
                       IF X#=2   !UZ B_DAT
                          IF INRANGE(FIFO:DATUMS,S_DAT,B_DAT)
                             SUMMA_R+=ABS(FIFO:SUMMA)
                             DAUK-=FIFO:DAUDZUMS
                          .
                          DAU2+=FIFO:DAUDZUMS
                       .
                    ELSE
                       VS_DAUDZUMS[X#]+=FIFO:DAUDZUMS
                       VS_SUMMA[X#]+=FIFO:SUMMA
                       IF X#=2
                          IF INRANGE(FIFO:DATUMS,S_DAT,B_DAT)
                             BILVERTD+=FIFO:SUMMA
                             DAUD+=FIFO:DAUDZUMS
                             DAU2+=FIFO:DAUDZUMS
                          ELSE
                             DAU1+=FIFO:DAUDZUMS
                             DAU2+=FIFO:DAUDZUMS
                          .
                       .
                    .
                 OF 'DI'
                    CTRL_I+=FIFO:DAUDZUMS
                 OF 'K '
                       REALIZETS+=FIFO:DAUDZUMS   !JA - ,LAI SAMAZINA REALIZÂCIJU,JA PIEPRASÎTS STORNÇT
                       IF X#=2
                          IF INRANGE(FIFO:DATUMS,S_DAT,B_DAT)
                             DAUK+=FIFO:DAUDZUMS
                             DAU2-=FIFO:DAUDZUMS
                          ELSE
                             DAU1-=FIFO:DAUDZUMS
                             DAU2-=FIFO:DAUDZUMS
                          .
                       .
!                    .
                 OF 'KR' !PERIODA BEIGÂS UZ RAÞOÐANU NEDRÎKST BÛT ATLIKUMI....???
                    REALIZETS+=FIFO:DAUDZUMS
                    IF X#=2
                       IF INRANGE(FIFO:DATUMS,S_DAT,B_DAT)
                          DAUK+=FIFO:DAUDZUMS
                          DAU2-=FIFO:DAUDZUMS
                       ELSE
                          DAU1-=FIFO:DAUDZUMS
                          DAU2-=FIFO:DAUDZUMS
                       .
                    .
                 OF 'KI'
                    CTRL_I-=FIFO:DAUDZUMS
                 .
              .
              IF CTRL_I
                 ERR='IP KÏÛDA'
              .
              CASE GL:FMI_TIPS
              OF 'FIFO'
   !---------------------RÇÍINAM REÂLÂS FIFO TABULAS------------------
              SORT(FIFO,F:KEY)
              GET(FIFO,0)
              LOOP F#=1 TO RECORDS(FIFO)
                GET(FIFO,F#)
                IF ~INSTRING(F:D_K,'A D DR',2) THEN CYCLE.
                IF F:DAUDZUMS<0  THEN CYCLE.   !MÇS ESAM ATGRIEZUÐI, JAU PIESKAITÎJÂM REALIZÂCIJAI
                                               !VADÎBAS ATSKAITEI VIENKÂRÐI IGNORÇJAM
!         stop('1='&x#&KOPS:NOMENKLAT&realizets&' '&F:SUMMA&' '&F:DAUDZUMS)
                IF REALIZETS > F:DAUDZUMS
                   REALIZETS-=F:DAUDZUMS
                ELSIF REALIZETS
                   BILVERT=(F:SUMMA/F:DAUDZUMS)*(F:DAUDZUMS-REALIZETS)
                   DAUDZUMS=F:DAUDZUMS-REALIZETS
                   REALIZETS=0
                ELSE                           !atlikums,nav realizçts
                   BILVERT+=F:SUMMA
                   DAUDZUMS+=F:DAUDZUMS
                .
!         stop('2='&x#&KOPS:NOMENKLAT&realizets&' '&F:SUMMA&' '&F:DAUDZUMS)
              .
              IF REALIZETS <0    !ATGRIEZTA PRECE, KURAI NAV NE D NE S
                 DAUDZUMS=ABS(REALIZETS)
                 BILVERT=GETNOM_K(KOPS:NOMENKLAT,0,7,6)*DAUDZUMS  !PIC
                 ERR='PIC'
              ELSIF REALIZETS >0    !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT
                 ERR='RE KÏÛDA'
              .
              FREE(FIFO)
              EXECUTE X#
                 BILVERT1=BILVERT  !ATLIKUMS UZ PERIODA SÂKUMU
                 BILVERT2=BILVERT
              .
              ELSE
!---------------------RÇÍINAM VS------------------
                 IF REALIZETS > VS_DAUDZUMS[X#] !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT
                    ERR='RE KÏÛDA'
                 .
!                 STOP(X#&' '&VS_SUMMA[X#]&'/'&VS_DAUDZUMS[X#]&'*'&DAU1)
                 IF X#=2
                    BILVERT1=VS_SUMMA[1]/VS_DAUDZUMS[1]*DAU1
                    BILVERT2=VS_SUMMA[2]/VS_DAUDZUMS[2]*DAU2
                 .
              .
           .
           BILVERT1_K+=BILVERT1
           BILVERT2_K+=BILVERT2
           BILVERTK=BILVERT1+BILVERTD-BILVERT2   !KREDÎTU RÇÍINAM ANALÎTISKI
           BILVERTD_K+=BILVERTD                  !KOPSUMMAS
           BILVERTK_K+=BILVERTK

!---------------------DRUKÂJAM ÂRÂ------------------

           IF BILVERT1 OR BILVERTD OR BILVERT2 OR ERR
              IF ERR AND ERR='PIC'
                 BRIK+=1
              ELSIF ERR
                 ERRK+=1
              .
              IF ~F:IDP OR (F:IDP AND ERR)
                 NOS_P=GETNOM_K(KOPS:NOMENKLAT,0,2)
                 IF F:DBF = 'W'
                   PRINT(RPT:DETAIL)
                 ELSE
                   OUTA:LINE=NR&CHR(9)&KOPS:NOMENKLAT&CHR(9)&NOS_P&CHR(9)&LEFT(FORMAT(BILVERT1,@N-_12.2))&CHR(9)&|
                   LEFT(FORMAT(BILVERTD,@N-_12.2))&CHR(9)&LEFT(FORMAT(BILVERTK,@N-_12.2))&CHR(9)&|
                   LEFT(FORMAT(BILVERT2,@N-_12.2))
                   ADD(OUTFILEANSI)
                   OUTA:LINE=CHR(9)&NOM:MERVIEN&CHR(9)&ERR&CHR(9)&LEFT(FORMAT(DAU1,@N-_12.3))&CHR(9)&|
                   LEFT(FORMAT(DAUD,@N-_12.3))&CHR(9)&LEFT(FORMAT(DAUK,@N-_12.3))&CHR(9)&LEFT(FORMAT(DAU2,@N-_12.3))
                   ADD(OUTFILEANSI)
                 .
              END
              DO PERFORMB_TABLE
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
        POST(Event:CloseWindow)
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
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOTKOPA)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE='KOPÂ:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(BILVERT1_K,@N-_12.2))&CHR(9)&LEFT(FORMAT(BILVERTD_K,@N-_12.2))&|
    CHR(9)&LEFT(FORMAT(BILVERTK_K,@N-_12.2))&CHR(9)&LEFT(FORMAT(BILVERT2_K,@N-_12.2))
    ADD(OUTFILEANSI)
  .
  TS='t.s.'
  LOOP I#= 1 TO RECORDS(B_TABLE)   !PÇC BKK
     GET(B_TABLE,I#)
     BKK=B:BKK
     BILVERT1_BKK=B:SUMMA1
     BILVERTD_BKK=B:SUMMAD
     BILVERTK_BKK=B:SUMMAK
     BILVERT2_BKK=B:SUMMA2
     IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOTBKK)
     ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=TS&CHR(9)&BKK&CHR(9)&CHR(9)&LEFT(FORMAT(BILVERT1_BKK,@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(BILVERTD_BKK,@N-_12.2))&CHR(9)&LEFT(FORMAT(BILVERTK_BKK,@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(BILVERT2_BKK,@N-_12.2))
        ADD(OUTFILEANSI)
     END
  .
  IF SUMMA_R
     SUMMA_RD=BILVERTD_K-SUMMA_R !Mûsu -D ir klât pie D
     SUMMA_RK=BILVERTK_K-SUMMA_R !Mûsu -D ir klât pie K
     IF F:DBF = 'W'
        PRINT(RPT:RPT_RETURN)
        PRINT(RPT:RPT_PAVISAM)
     ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Atgriezts par summu'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_R,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_R,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Pavisam'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_RD,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_RK,@N-_12.2))
        ADD(OUTFILEANSI)
     .
  .
  IF ERRK
     ERRORTEXT=CLIP(ERRK)&' kïûdas'
  .
  IF BRIK
     ERRORTEXT=CLIP(ERRORTEXT)&' '&CLIP(BRIK)&' brîdinâjumi'
  .
!  IF ERRK OR BRIK
!     ERRORTEXT=CLIP(ERRORTEXT)&' '&'sk. '&clip(FILENAME1)
!  .
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOTEND)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE='Sastâdîja '&ACC_KODS&' '&CLIP(ERRORTEXT)&' '&FORMAT(DAT,@D06.)&' '&FORMAT(LAI,@T4)
    ADD(OUTFILEANSI)
    OUTA:LINE=''
    ADD(OUTFILEANSI)
  END
  IF KOPA
     IF F:DBF = 'W'
        PRINT(RPT:RPT_KOPA)
     ELSE
        OUTA:LINE=KOPA
        ADD(OUTFILEANSI)
     END
  .
  LOOP I#= 1 TO NOL_SK
     KOPA='NOL'&CLIP(I#)
     IF VMIS[I#,1]='V'
        KOPA=CLIP(KOPA)&' Vairumtirdzniecîba'
     ELSE
        KOPA=CLIP(KOPA)&' Mazumtirdzniecîba'
     .
     IF F:DBF = 'W'
        PRINT(RPT:RPT_KOPA)
     ELSE
        OUTA:LINE=KOPA
        ADD(OUTFILEANSI)
     END
  .
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!!     report{Prop:Preview} = PrintPreviewImage
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
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE
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
  NOL_KOPS::USED-=1
  IF NOL_KOPS::USED=0
     CLOSE(NOL_KOPS)
  .
  NOL_FIFO::USED-=1
  IF NOL_FIFO::USED=0
     CLOSE(NOL_FIFO)
  .
  FREE(B_TABLE)
  FREE(RAZTABLE)
  POPBIND
  F:DBF='W' !TURPMÂKAM
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
  IF ERRORCODE() OR (CYCLENOM(KOPS:NOMENKLAT)=2)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOL_KOPS')
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
PERFORMB_TABLE ROUTINE

  B:BKK=GETNOM_K(KOPS:NOMENKLAT,0,6)
  IF ~B:BKK THEN B:BKK='21300'.
  GET(B_TABLE,B:BKK)
  IF ERROR()
     B:SUMMA1=BILVERT1
     B:SUMMAD=BILVERTD
     B:SUMMAK=BILVERTK
     B:SUMMA2=BILVERT2
     ADD(B_TABLE)
     SORT(B_TABLE,B:BKK)
  ELSE
     B:SUMMA1+=BILVERT1
     B:SUMMAD+=BILVERTD
     B:SUMMAK+=BILVERTK
     B:SUMMA2+=BILVERT2
     PUT(B_TABLE)
  .
                                                                            
P_AKTS               PROCEDURE                    ! Declare Procedure
!DAT                  LONG
!LAI                  LONG
ADRESE               STRING(55)
RAZOSANA             STRING(25)
!DATUMS               BYTE
perskods             STRING(20)
VUT                  STRING(30)
KOM1                 STRING(30)
KOM2                 STRING(30)
KOM3                 STRING(30)
AKTS_NR              ULONG

DOKDATUMS            string(25)



!report REPORT,AT(200,1000,8000,8000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
!         THOUS

report REPORT,AT(146,1000,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
HEAD   DETAIL,AT(,,,1000),USE(?unnamed:2)
       END
detail DETAIL,AT(,,,7167),USE(?unnamed)
         STRING(@s45),AT(469,333,4323,208),USE(client),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('"APSTIPRINU"'),AT(5052,313,1354,260),USE(?String4),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(469,573,3802,208),USE(gl:adrese),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(469,813,1146,208),USE(gl:vid_nr),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4635,1094,2396,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('/'),AT(4948,1146),USE(?String5),LEFT,FONT(,12,,,CHARSET:BALTIC)
         STRING(@s21),AT(5052,1146,1719,208),USE(SYS:PARAKSTS1),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('/'),AT(6792,1146),USE(?String5:2),RIGHT,FONT(,12,,,CHARSET:BALTIC)
         STRING(@s25),AT(5104,1313),USE(DOKDATUMS),CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING('AKTS PAR PAMATLÎDZEKÏA PIEÒEMÐANU - NODOÐANU Nr'),AT(1250,1875,5000,260),USE(?String4:2), |
             CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_6B),AT(6250,1875,729,260),USE(AKTS_NR),TRN,LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('1. Pamatlîdzekïa nosaukums :'),AT(438,2521,2083,208),USE(?String9),FONT(,11,,,CHARSET:BALTIC)
         STRING(@s35),AT(3073,2521,3125,208),USE(PAM:NOS_P),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('2. Skaits :'),AT(438,2740,1823,208),USE(?String9:2),FONT(,11,,,CHARSET:BALTIC)
         STRING(@N_4),AT(3073,2729,365,208),USE(PAM:SKAITS),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('3. Atraðanâs vieta :'),AT(438,2958,1823,208),USE(?String9:15),FONT(,11,,,CHARSET:BALTIC)
         STRING(@s55),AT(3073,2969,4563,208),USE(adrese),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('4. Pamatlîdzekïa izgatavoðanas gads :'),AT(438,3177,2604,208),USE(?String9:3),FONT(,11,,,CHARSET:BALTIC)
         STRING(@N4),AT(3073,3177,365,208),USE(PAM:izg_gad),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('5. Inventâra numurs :'),AT(438,3385,1771,208),USE(?String9:4),FONT(,11,,,CHARSET:BALTIC)
         STRING(@N_6),AT(3073,3385,625,208),USE(PAM:U_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('6. Uzskaites vçrtîba :'),AT(438,3594,1469,208),USE(?String9:10),FONT(,11,,,CHARSET:BALTIC)
         STRING(@s3),AT(1906,3594,438,208),USE(val_uzsk),FONT(,11,,,CHARSET:BALTIC)
         STRING(@N_11.2),AT(3073,3594,990,208),USE(PAM:BIL_V),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('7. Lietoðanas laiks :'),AT(438,3802,1406,208),USE(?String9:12),FONT(,11,,,CHARSET:BALTIC)
         STRING(@N4),AT(3073,3802,365,208),USE(PAM:LIN_G_PR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('gadi'),AT(3458,3802,365,208),USE(?String9:14),FONT(,11,,,CHARSET:BALTIC)
         STRING('%'),AT(3458,4010,125,208),USE(?String42)
         STRING('8. Amortizâcijas norma nodokïiem :'),AT(438,4010,2344,208),USE(?stringa),FONT(,11,,,CHARSET:BALTIC)
         STRING(@N2),AT(3073,4010,260,208),USE(pam:gd_pr[1]),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('9. Objekta saimnieciskâ nozîme :'),AT(438,4219,2344,229),USE(?stringo),FONT(,11,,,CHARSET:BALTIC)
         STRING(@s20),AT(3073,4219),USE(razosana),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Komisija:'),AT(469,4583,729,208),USE(?String9:13),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(3177,4740,2292,208),USE(KOM1),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,4948,3125,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@s30),AT(3188,5021,2292,208),USE(KOM2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,5240,3125,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING(@s30),AT(3188,5313,2292,208),USE(KOM3),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,5531,3125,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Pamatlîdzeklis nodots ekspluatâcijâ :'),AT(469,5646,2500,208),USE(?String9:6),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds, uzvârds :'),AT(469,5990,1250,208),USE(?String9:7),FONT(,,,,CHARSET:BALTIC)
         STRING(@s30),AT(1771,5990,2292,208),USE(VUT),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Personas kods :'),AT(469,6167,1250,208),USE(?String9:8)
         STRING(@s20),AT(1771,6167,1250,208),USE(PERSKODS),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Atbildîgâs personas paraksts :'),AT(469,6615,1927,208),USE(?String9:9),FONT(,,,,CHARSET:BALTIC)
         LINE,AT(2448,6802,2396,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING(@s25),AT(2823,6844),USE(DOKDATUMS,,?DOKDATUMS:2),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atcelt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END

KOM  WINDOW('Komisijas sastâvs'),AT(,,170,135),CENTER,GRAY,DOUBLE
       STRING('Akts Nr :'),AT(53,9),USE(?String1)
       ENTRY(@N_6B),AT(81,8,27,10),USE(AKTS_NR,,?AKTS_NR:1)
       ENTRY(@s30),AT(11,27),USE(KOM1,,?KOM1:1)
       ENTRY(@s30),AT(11,41),USE(KOM2,,?KOM2:1)
       ENTRY(@s30),AT(11,54),USE(KOM3,,?KOM3:1)
       STRING('Atraðanâs vieta :'),AT(10,70),USE(?String111)
       ENTRY(@s45),AT(11,81,152,10),USE(ADRESE,,?adrese:1)
       BUTTON('D&rukas parametri'),AT(79,96,78,14),USE(?Button:DRUKA),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
       BUTTON('OK'),AT(124,111,33,15),USE(?OK)
     END
  CODE                                            ! Begin processed code
 PUSHBIND
 CHECKOPEN(GLOBAL,1)
 CHECKOPEN(SYSTEM,1)

 AKTS_NR  =PAM:U_NR
 VUT      =GETPAR_K(PAM:ATB_NR,0,2)
 DOKDATUMS=GETDOKDATUMS(PAM:DATUMS)
 PERSKODS =GETPAR_K(PAM:ATB_NR,0,12)
 KOM1     =SYS:PARAKSTS1
 KOM2     =SYS:PARAKSTS2
 KOM3     =VUT
! IF PAM:NODALA
!    ADRESE=PAM:NODALA&' nodaïa '&getnodalas(PAM:NODALA,1)
 ADRESE=GETPAM_ADRESE(PAM:U_NR) !IR DEFINÇTA VIETA
 IF ~ADRESE THEN ADRESE=SYS:ADRESE.

 OPEN(KOM)
 DISPLAY
 ACCEPT
    DISPLAY
    CASE FIELD()
    OF ?OK
       CASE EVENT()
       OF EVENT:ACCEPTED
          BREAK
       .
    .
 .
 CLOSE(KOM)

 OPEN(REPORT)
 REPORT{Prop:Preview} = PrintPreviewImage
 SETTARGET(REPORT)
 IMAGE(188,281,2083,521,'USER.BMP')
 PRINT(rpt:HEAD)
! DAT = PAM:DATUMS
! LAI = CLOCK()
! GADS=YEAR(DAT)
! DATUMS=DAY(DAT)
! MENESIS=MENVAR(DAT,2,2)
 IF PAM:NERAZ
    RAZOSANA='neizmanto raþoðanâ'
 ELSE
    RAZOSANA='izmanto raþoðanâ'
 .
 PRINT(rpt:DETAIL)
 ENDPAGE(report)
!  IF F:DBF='W'
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
!  ELSE
!      CLOSE(OUTFILEANSI)
!      RUN('WORDPAD '&ANSIFILENAME)
!      IF RUNCODE()=-4
!          KLUDA(88,'Wordpad.exe')
!      .
!  .
!  IF F:DBF='W'
      CLOSE(report)
      FREE(PrintPreviewQueue)
      FREE(PrintPreviewQueue1)
!  ELSE
!      ANSIFILENAME=''
!  END
 POPBIND
BrowsePAMAT PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
SAK_GIL              LONG
BEI_GIL              LONG
KAT                  STRING(3)
PAM_ATB_NOS          STRING(30)

BRW1::View:Browse    VIEW(PAMAT)
                       PROJECT(PAM:U_NR)
                       PROJECT(PAM:NODALA)
                       PROJECT(PAM:OBJ_NR)
                       PROJECT(PAM:DATUMS)
                       PROJECT(PAM:IEP_V)
                       PROJECT(PAM:NOS_P)
                       PROJECT(PAM:END_DATE)
                       PROJECT(PAM:ATB_NOS)
                       PROJECT(PAM:BKK)
                       PROJECT(PAM:BKKN)
                       PROJECT(PAM:NOS_A)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::PAM:U_NR         LIKE(PAM:U_NR)             ! Queue Display field
BRW1::PAM:NODALA       LIKE(PAM:NODALA)           ! Queue Display field
BRW1::PAM:OBJ_NR       LIKE(PAM:OBJ_NR)           ! Queue Display field
BRW1::KAT              LIKE(KAT)                  ! Queue Display field
BRW1::PAM:DATUMS       LIKE(PAM:DATUMS)           ! Queue Display field
BRW1::PAM:IEP_V        LIKE(PAM:IEP_V)            ! Queue Display field
BRW1::PAM:NOS_P        LIKE(PAM:NOS_P)            ! Queue Display field
BRW1::PAM:END_DATE     LIKE(PAM:END_DATE)         ! Queue Display field
BRW1::PAM_ATB_NOS      LIKE(PAM_ATB_NOS)          ! Queue Display field
BRW1::PAM:BKK          LIKE(PAM:BKK)              ! Queue Display field
BRW1::PAM:BKKN         LIKE(PAM:BKKN)             ! Queue Display field
BRW1::PAM:NOS_A        LIKE(PAM:NOS_A)            ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort3:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort3:KeyDistribution LIKE(PAM:DATUMS),DIM(100)
BRW1::Sort3:LowValue LIKE(PAM:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort3:HighValue LIKE(PAM:DATUMS)            ! Queue position of scroll thumb
BRW1::QuickScan      BYTE                         ! Flag for Range/Filter test
BRW1::CurrentEvent   LONG                         !
BRW1::CurrentChoice  LONG                         !
BRW1::RecordCount    LONG                         !
BRW1::SortOrder      BYTE                         !
BRW1::LocateMode     BYTE                         !
BRW1::RefreshMode    BYTE                         !
BRW1::LastSortOrder  BYTE                         !
BRW1::FillDirection  BYTE                         !
BRW1::AddQueue       BYTE                         !
BRW1::Changed        BYTE                         !
BRW1::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW1::ItemsToFill    LONG                         ! Controls records retrieved
BRW1::MaxItemsInList LONG                         ! Retrieved after window opened
BRW1::HighlightedPosition STRING(512)             ! POSITION of located record
BRW1::NewSelectPosted BYTE                        ! Queue position of located record
BRW1::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
WinResize            WindowResizeType
QuickWindow          WINDOW('Browse the PAMAT File'),AT(-1,-1,459,326),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowsePAMAT'),SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&2-Serviss'),USE(?2Serviss)
                           ITEM,SEPARATOR
                           ITEM('&3-Importa interfeiss'),USE(?2Serviss3Importainterfeiss)
                         END
                         MENU('&4-Faili'),USE(?Faili)
                           ITEM('&1-Partneru saraksts'),USE(?4Faili1Partnerusaraksts),FIRST
                           ITEM('1&0-Kategorijas'),USE(?FailiKategorijas)
                           ITEM('&B-Nodokïu aprçíina karte'),USE(?4FailiBNodokïuaprçíinakarte)
                         END
                         MENU('&5-Izziòas no DB'),USE(?IzziòasnoDB)
                           MENU('&1-Lineârâ metode'),USE(?IzziòasnoDBLineârâmetode)
                             ITEM('&1-Nolietojuma aprçíins '),USE(?NolaprGads)
                             ITEM('&2-Nolietojuma aprçíins (mçnesis)'),USE(?IzziòasnoDBLineârâmetodeNolietojumaaprçíinsmçnesis),DISABLE
                             ITEM('&3-Kopsavilkums pa ceturkðòiem un nodaïâm'),USE(?IzziòasnoDBLineârâmetodenolaprlg)
                             ITEM('&4-Vienai nodaïai'),USE(?nolaprlm),DISABLE
                             ITEM('&5-Ilgtermiòa ieguldîjumu kustîbas pârskats'),USE(?IzziòasnoDBLineârâmetodeIlgtermiòaieguldîjumukustîba)
                             ITEM('&6-Ilgtermiòa ieguldîjumu KP (izvçrstâ veidâ)'),USE(?IzziòasnoDBLineârâmetodeIIKPIV)
                             ITEM('&7-Gada vidçjâ bilances vçrtîba'),USE(?IzziòasnoDBLineârâmetodeGadavidçjâbilancesvçrtîba)
                             ITEM('&8-P/L inventarizâcijas akts'),USE(?5IzziòasnoDB1Lineârâmetode8IlgtermiòaieguldîjumuPLinvakts)
                             ITEM('&9-P/L norakstîðanas akts'),USE(?5IzziòasnoDB1Lineârâmetode9PLnorakstîðanasakts)
                           END
                           MENU('&2-Ìeometriski degresîvâ metode'),USE(?IzziòasnoDBÌeometriskidegresîvâmetode)
                             ITEM('&1-Nolietojuma aprçíins (gads)'),USE(?IzziòasnoDBÌeometriskidegresîvâmetodeNolietojumaaprçíinsgads)
                             ITEM('&2-P/L analîtiskâs uzskaites un nolietojuma aprçíina karte kategorijai'),USE(?5IzziòasnoDB2Ìeometriskidegresîvâmetode2PLanalî)
                             ITEM('&3-Pam.noliet. un nemat.ieg.vçrt.aprçíina kopsav.karte'),USE(?IzziòasnoDBÌeometriskidegresîvâmetodePNNIVAKK)
                           END
                           ITEM('&3-Pamatlîdzekïu kustîba'),USE(?5IzziòasnoDB3PLK)
                           ITEM('&4-Pamatlîdzekïu saraksts'),USE(?5IzziòasnoDB4PLS)
                         END
                         MENU('&3-Sistçmas dati'),USE(?System)
                           ITEM('&3-Lokâlie Dati'),USE(?LokâlieDatiLokâlieDati)
                         END
                         MENU('&6-Speciâlâs funkcijas'),USE(?Speciâlâsfunkcijas)
                           ITEM('&1-Sarçíinât amortizâciju visiem,kas nav slçgti'),USE(?SarekinatAmort)
                           ITEM('&2-Pârrçíinât  amortizâciju visiem'),USE(?ParrekinatVisu),DISABLE
                         END
                       END
                       LIST,AT(5,23,443,255),USE(?Browse:1),IMM,VSCROLL,FONT('MS Sans Serif',10,,FONT:bold),MSG('Browsing Records'),FORMAT('36R(2)|M~Nr~C(0)@n_8@10C|M~N~@s2@25R|M~P~C@N_6B@20C|M~Kat.~@P#-##P@47R(1)|M~Ieg.' &|
   'datums~C(0)@d06.@49D(12)|M~Ieg. vçrt.~C(0)@n-13.2@143L(2)|M~Nosaukums~@s35@46R(1' &|
   ')|M~Noòemts~C(0)@D06.B@100L(1)|M~Atbildîgais~C(0)@s30@23C|M~BKK~@s5@20L(1)|M~Nol' &|
   'iet.~@s5@'),FROM(Queue:Browse:1)
                       BUTTON('&C-Kopçt'),AT(265,282,41,14),USE(?Kopet)
                       BUTTON('&Ievadît'),AT(312,281,41,14),USE(?Insert:2)
                       BUTTON('&Mainît'),AT(355,281,41,14),USE(?Change:2),DEFAULT
                       BUTTON('&Dzçst'),AT(397,281,39,14),USE(?Delete:2)
                       SHEET,AT(2,6,451,295),USE(?CurrentTab),FULL
                         TAB('Dat&umu secîba'),USE(?Tab:1)
                           ENTRY(@D6),AT(8,282,55,12),USE(PAM:DATUMS)
                         END
                         TAB('&Nr augoða secîba'),USE(?Tab:2)
                           ENTRY(@n13),AT(12,283,41,12),USE(PAM:U_NR)
                           STRING('meklçðana pçc Nr'),AT(59,285),USE(?String1)
                         END
                         TAB('N&osaukumu augoða secîba'),USE(?Tab:3)
                           ENTRY(@s5),AT(8,284,47,12),USE(PAM:NOS_A)
                           STRING('meklçðana pçc nosaukuma'),AT(63,285),USE(?String2)
                         END
                       END
                       BUTTON('&Beigt'),AT(407,304,45,14),USE(?Close)
                       BUTTON('&P/LK(LG)'),AT(70,304,43,14),USE(?PamKarteL:2)
                       BUTTON('P/L kartiòa (&GD)'),AT(115,304,61,14),USE(?PamKarteG)
                       BUTTON('&Objekta(P) kopsavilkuma kartiòa (LIN)'),AT(178,304,130,14),USE(?OBJKarteL)
                       BUTTON('P/L kartiòa (&LIN)'),AT(4,304,64,14),USE(?PamKarteL)
                       BUTTON('Pieò./nod. &Akts'),AT(316,304,61,14),USE(?PienNodAkc)
                     END
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
!----------------------------------------
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  ! PIRMS CLARIS RAUJ VAÏÂ FAILUS
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
!  IF ~INRANGE(GL:DB_GADS,1995,2010)
!     GL:DB_GADS=YEAR(TODAY())
!     PUT(GLOBAL)
!  .
  gads=GL:DB_GADS
  DB_gads=GL:DB_GADS
  VAL_nos='Ls'
  S_DAT=DATE(1,1,GL:DB_GADS)
  IF GL:DB_GADS=YEAR(TODAY())
     B_DAT=TODAY()
     SAV_DATUMS=TODAY()
  ELSE
     B_DAT=DATE(12,31,GL:DB_GADS)
     SAV_DATUMS=DATE(12,31,GL:DB_GADS)
  .
  MAINIT231531=FALSE   ! AIZLIEDZAM MAINÎT GG-RAKSTUS CAUR BRPAR_K-REFERGG
  ACCEPT
    QUICKWINDOW{PROP:TEXT}='Pamatlîdzekïi '&CLIP(LONGpath())&'\PAMAT'&CLIP(LOC_NR)
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Browse:1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
    END
    CASE ACCEPTED()
    OF ?2Serviss3Importainterfeiss
      DO SyncWindow
      BROWSEGG1 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4Faili1Partnerusaraksts
      DO SyncWindow
      BrowsePAR_K 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?FailiKategorijas
      DO SyncWindow
      BrowseKAT_K 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4FailiBNodokïuaprçíinakarte
      DO SyncWindow
      GlobalRequest = ChangeRecord
      UpdatePamKat 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?NolaprGads
      DO SyncWindow
        OPCIJA='1400'
      !         1234
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='011310'
      !            123456
           IZZFILTPAM
           IF GlobalResponse = RequestCompleted
              START(P_NOLAPRLIN,50000)
           .
        END
    OF ?IzziòasnoDBLineârâmetodeNolietojumaaprçíinsmçnesis
      DO SyncWindow
        OPCIJA='111'
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           START(P_NOLAPR1,50000)
        END
    OF ?IzziòasnoDBLineârâmetodenolaprlg
      DO SyncWindow
        OPCIJA='100300'
      !         123456
        IZZFILTPAM
        IF GlobalResponse = RequestCompleted
           START(P_NOLAPRG,50000)
        END
    OF ?nolaprlm
      DO SyncWindow
      START(P_NolAprM,25000)
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?IzziòasnoDBLineârâmetodeIlgtermiòaieguldîjumukustîba
      DO SyncWindow
      !  OPCIJA='100'
      !  IZZFILTGMC
        OPCIJA='100300'
      !         123456  !1GADS-text,2KAT,3NOD,4:1WA/2WE/3WAE,OBJ.Atbild.
        IZZFILTPAM
        IF GlobalResponse = RequestCompleted
           START(P_IIKP,50000)
        END
    OF ?IzziòasnoDBLineârâmetodeIIKPIV
       F:DTK=''
      DO SyncWindow
      !  OPCIJA='100'
      !  IZZFILTGMC
        OPCIJA='100300'
      !         123456  !1GADS-text,2KAT,3NOD,4:1WA/2WE/3WAE,OBJ.Atbild.
        IZZFILTPAM
        IF GlobalResponse = RequestCompleted
           START(P_IIVIV,50000)
        END
    OF ?IzziòasnoDBLineârâmetodeGadavidçjâbilancesvçrtîba
      DO SyncWindow
      !  OPCIJA='100'
      !  IZZFILTGMC
      !  IF GlobalResponse = RequestCompleted
           OPCIJA='100300'
      !            123456  !1:GADA TEKSTS,2KAT,3NOD,4:1WA/2WE/3WAE,OBJ.Atbild.
           IZZFILTPAM
           IF GlobalResponse = RequestCompleted
              START(P_VIDBILVERT,50000)
           .
      !  END
      
    OF ?5IzziòasnoDB1Lineârâmetode8IlgtermiòaieguldîjumuPLinvakts
      DO SyncWindow
        OPCIJA='040'
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='011311'
      !            123456
           IZZFILTPAM
           IF GlobalResponse = RequestCompleted
              START(P_INVLIN,50000)
           .
        END
    OF ?5IzziòasnoDB1Lineârâmetode9PLnorakstîðanasakts
      DO SyncWindow
           B_DAT=PAM:END_DATE
           OPCIJA='0003001'
      !            1234567
           IZZFILTPAM
           IF GlobalResponse = RequestCompleted
              START(P_NORLIN,50000)
           .
    OF ?IzziòasnoDBÌeometriskidegresîvâmetodeNolietojumaaprçíinsgads
      DO SyncWindow
           OPCIJA='1000'
           IZZFILTPAM
           IF GlobalResponse = RequestCompleted
              START(P_NOLAPRGD,50000)
           .
    OF ?5IzziòasnoDB2Ìeometriskidegresîvâmetode2PLanalî
      DO SyncWindow
        OPCIJA='120300'
      !         123456
      
        IZZFILTPAM
        IF GlobalResponse = RequestCompleted
           START(P_Pamkar3p,50000)
        .
    OF ?IzziòasnoDBÌeometriskidegresîvâmetodePNNIVAKK
      DO SyncWindow
           OPCIJA='100300'
      !            123456
           IZZFILTPAM
           IF GlobalResponse = RequestCompleted
              START(P_PNNIVAKK,50000)
           .
    OF ?5IzziòasnoDB3PLK
      DO SyncWindow
        OPCIJA='110'
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='011300'
      !            123456
           IZZFILTPAM
           IF GlobalResponse = RequestCompleted
              START(P_PLKUSTIBA,50000)
           .
        .
    OF ?5IzziòasnoDB4PLS
      DO SyncWindow
        OPCIJA='211310'
      !         123456 G/B_DAT,KAT,N,WE/3WAE,Ob,Atb.
        IZZFILTPAM
        IF GlobalResponse = RequestCompleted
           START(P_PLSARAKSTS,50000)
        .
    OF ?LokâlieDatiLokâlieDati
      DO SyncWindow
      GlobalRequest = ChangeRecord
      UpdateSystem 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?SarekinatAmort
      DO SyncWindow
  OPCIJA='0300'
!         1234
!MAXG#=2014 !MAX uz DIM20
  IZZFILTGMC() !gmc vairs nekontrolç maxg
  IF GLOBALRESPONSE=REQUESTCOMPLETED
    RecordsToProcess = RECORDS(PAMAT)
    RecordsPerCycle = 25
    RecordsProcessed = 0
    PercentProgress = 0
    OPEN(ProgressWindow)
    Progress:Thermometer = 0
    ?Progress:PctText{Prop:Text} = '0%'
    ProgressWindow{Prop:Text} = 'Nolietojuma aprçíins '&gads
    ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
    CLEAR(PAM:RECORD)
    SET(PAM:NR_KEY,PAM:NR_KEY)
    LOOP
       NEXT(PAMAT)
       IF ERROR() THEN BREAK.
       calcamort(0)
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
    .
    CLOSE(PROGRESSWINDOW)
    DO BRW1::InitializeBrowse
    DO BRW1::RefreshPage
    SELECT(?Tab:1)
    DISPLAY
  .

    OF ?ParrekinatVisu
      DO SyncWindow
    END
    CASE FIELD()
    OF ?Browse:1
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW1::NewSelection
      OF EVENT:ScrollUp
        DO BRW1::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW1::ProcessScroll
      OF EVENT:PageUp
        DO BRW1::ProcessScroll
      OF EVENT:PageDown
        DO BRW1::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW1::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW1::ProcessScroll
      OF EVENT:AlertKey
        DO BRW1::AlertKey
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?Kopet
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         COPYREQUEST=1
         DO BRW1::ButtonInsert
      END
    OF ?Insert:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Change:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Delete:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
      END
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        DO RefreshWindow
      OF EVENT:TabChanging
        TABCHANGED#=TRUE
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?PAM:DATUMS
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?PAM:DATUMS)
        IF PAM:DATUMS
          CLEAR(PAM:U_NR,1)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      OF EVENT:Selected
                IF TABCHANGED#=TRUE
                   SELECT(?BROWSE:1)
                   TABCHANGED#=FALSE
                .
      END
    OF ?PAM:U_NR
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?PAM:U_NR)
        IF PAM:U_NR
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      OF EVENT:Selected
                IF TABCHANGED#=TRUE
                   SELECT(?BROWSE:1)
                   TABCHANGED#=FALSE
                .
      END
    OF ?PAM:NOS_A
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?PAM:NOS_A)
        IF PAM:NOS_A
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort2:LocatorValue = PAM:NOS_A
          BRW1::Sort2:LocatorLength = LEN(CLIP(PAM:NOS_A))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      OF EVENT:Selected
                IF TABCHANGED#=TRUE
                   SELECT(?BROWSE:1)
                   TABCHANGED#=FALSE
                .
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?PamKarteL:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SYNCWINDOW
        OPCIJA='130'
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='000100'
        !          123456
           IZZFILTPAM
           IF GlobalResponse = RequestCompleted
              F:DTK='1'!SASPIESTS PA GADU
              P_KARLI
           .
        .
        DO SyncWindow
      END
    OF ?PamKarteG
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        P_KARGD 
        LocalRequest = OriginalRequest
        DO RefreshWindow
      END
    OF ?OBJKarteL
      CASE EVENT()
      OF EVENT:Accepted
        DO SYNCWINDOW
        OPCIJA='140'
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
          F:OBJ_NR=PAM:OBJ_NR
          P_KARLI_OBJ
        .
        DO SyncWindow
      END
    OF ?PamKarteL
      CASE EVENT()
      OF EVENT:Accepted
        DO SYNCWINDOW
        OPCIJA='140'
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           OPCIJA='000100'
        !          123456
           IZZFILTPAM
           IF GlobalResponse = RequestCompleted
              F:DTK=''!~SASPIESTS PA GADU
              P_KARLI
           .
        .
        DO SyncWindow
      END
    OF ?PienNodAkc
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        P_AKTS 
        LocalRequest = OriginalRequest
        DO RefreshWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(AMO:RECORD)
  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  BIND(PAM:RECORD)
  IF PAM_P::Used = 0
    CheckOpen(PAM_P,1)
  END
  PAM_P::Used += 1
  BIND(PAP:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowsePAMAT','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,250} = BSKey
  ?Browse:1{Prop:Alrt,250} = SpaceKey
  ?Browse:1{Prop:Alrt,255} = InsertKey
  ?Browse:1{Prop:Alrt,254} = DeleteKey
  ?Browse:1{Prop:Alrt,253} = CtrlEnter
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, if it was opened by this procedure, the window is closed.
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
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
    PAM_P::Used -= 1
    IF PAM_P::Used = 0 THEN CLOSE(PAM_P).
  END
  IF WindowOpened
    INISaveWindow('BrowsePAMAT','winlats.INI')
    CLOSE(QuickWindow)
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!---------------------------------------------------------------------------
InitializeWindow ROUTINE
!|
!| This routine is used to prepare any control templates for use. It should be called once
!| per procedure.
!|
  DO RefreshWindow
!---------------------------------------------------------------------------
RefreshWindow ROUTINE
!|
!| This routine is used to keep all displays and control templates current.
!|
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
  DO BRW1::SelectSort
  ?Browse:1{Prop:VScrollPos} = BRW1::CurrentScroll
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LocatorValue = PAM:U_NR
    CLEAR(PAM:U_NR)
  OF 2
    PAM:NOS_A = BRW1::Sort2:LocatorValue
  OF 3
    BRW1::Sort3:LocatorValue = PAM:DATUMS
    CLEAR(PAM:DATUMS)
  END
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW1::GetRecord
!---------------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::SelectSort ROUTINE
!|
!| This routine is called during the RefreshWindow ROUTINE present in every window procedure.
!| The purpose of this routine is to make certain that the BrowseBox is always current with your
!| user's selections. This routine...
!|
!| 1. Checks to see if any of your specified sort-order conditions are met, and if so, changes the sort order.
!| 2. If no sort order change is necessary, this routine checks to see if any of your Reset Fields has changed.
!| 3. If the sort order has changed, or if a reset field has changed, or if the ForceRefresh flag is set...
!|    a. The current record is retrieved from the disk.
!|    b. If the BrowseBox is accessed for the first time, and the Browse has been called to select a record,
!|       the page containing the current record is loaded.
!|    c. If the BrowseBox is accessed for the first time, and the Browse has not been called to select a
!|       record, the first page of information is loaded.
!|    d. If the BrowseBox is not being accessed for the first time, and the Browse sort order has changed, the
!|       new "first" page of information is loaded.
!|    e. If the BrowseBox is not being accessed for the first time, and the Browse sort order hasn't changes,
!|       the page containing the current record is reloaded.
!|    f. The record buffer is refilled from the currently highlighted BrowseBox item.
!|    f. The BrowseBox is reinitialized (BRW1::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW1::LastSortOrder = BRW1::SortOrder
  BRW1::Changed = False
  IF choice(?currenttab)=2
    BRW1::SortOrder = 1
  ELSIF choice(?currenttab)=3
    BRW1::SortOrder = 2
  ELSE
    BRW1::SortOrder = 3
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    END
  ELSE
    CASE BRW1::SortOrder
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      PAM:NOS_A = BRW1::Sort2:LocatorValue
    END
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    DO BRW1::GetRecord
    DO BRW1::Reset
    IF BRW1::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      ELSE
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      END
    ELSE
      IF BRW1::Changed
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      ELSE
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      END
    END
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
    DO BRW1::InitializeBrowse
  ELSE
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW1::InitializeBrowse ROUTINE
!|
!| This routine initializes the BrowseBox control template. This routine is called when...
!|
!| The BrowseBox sort order has changed. This includes the first time the BrowseBox is accessed.
!| The BrowseBox returns from a record update.
!|
!| This routine performs two main functions.
!|   1. Computes all BrowseBox totals. All records that satisfy the current selection criteria
!|      are read, and totals computed. If no totals are present, this section is not generated,
!|      and may not be present in the code below.
!|   2. Calculates any runtime scrollbar positions. Again, if runtime scrollbars are not used,
!|      the code for runtime scrollbar computation will not be present.
!|
  IF SEND(PAMAT,'QUICKSCAN=on').
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAMAT')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 3
    BRW1::Sort3:HighValue = PAM:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAMAT')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 3
    BRW1::Sort3:LowValue = PAM:DATUMS
    SetupRealStops(BRW1::Sort3:LowValue,BRW1::Sort3:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort3:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
  IF SEND(PAMAT,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  PAM:U_NR = BRW1::PAM:U_NR
  PAM:NODALA = BRW1::PAM:NODALA
  PAM:OBJ_NR = BRW1::PAM:OBJ_NR
  KAT = BRW1::KAT
  PAM:DATUMS = BRW1::PAM:DATUMS
  PAM:IEP_V = BRW1::PAM:IEP_V
  PAM:NOS_P = BRW1::PAM:NOS_P
  PAM:END_DATE = BRW1::PAM:END_DATE
  PAM_ATB_NOS = BRW1::PAM_ATB_NOS
  PAM:BKK = BRW1::PAM:BKK
  PAM:BKKN = BRW1::PAM:BKKN
  PAM:NOS_A = BRW1::PAM:NOS_A
!----------------------------------------------------------------------
BRW1::FillQueue ROUTINE
!|
!| This routine is used to fill the BrowseBox QUEUE from several sources.
!|
!| First, all Format Browse formulae are processed.
!|
!| Next, each field of the BrowseBox is processed. For each field...
!|
!|    The value of the field is placed in the BrowseBox queue.
!|
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  LOOP I#=15 TO 1 BY -1
     KAT=PAM:KAT[I#]
     IF KAT THEN BREAK.
  .
  IF PAM:ATB_NR
     PAM_ATB_NOS=CLIP(PAM:ATB_NR)&' '&PAM:ATB_NOS
  ELSE
     PAM_ATB_NOS=''
  .
  BRW1::PAM:U_NR = PAM:U_NR
  BRW1::PAM:NODALA = PAM:NODALA
  BRW1::PAM:OBJ_NR = PAM:OBJ_NR
  BRW1::KAT = KAT
  BRW1::PAM:DATUMS = PAM:DATUMS
  BRW1::PAM:IEP_V = PAM:IEP_V
  BRW1::PAM:NOS_P = PAM:NOS_P
  BRW1::PAM:END_DATE = PAM:END_DATE
  BRW1::PAM_ATB_NOS = PAM_ATB_NOS
  BRW1::PAM:BKK = PAM:BKK
  BRW1::PAM:BKKN = PAM:BKKN
  BRW1::PAM:NOS_A = PAM:NOS_A
  BRW1::Position = POSITION(BRW1::View:Browse)
!----------------------------------------------------------------------
BRW1::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW1::NewSelectPosted
    BRW1::NewSelectPosted = True
    POST(Event:NewSelection,?Browse:1)
  END
!----------------------------------------------------------------------
BRW1::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW1::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW1::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW1::PopupText = ''
    IF BRW1::RecordCount
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Insert:2)
      POST(Event:Accepted,?Change:2)
      POST(Event:Accepted,?Delete:2)
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF ?Browse:1{Prop:VScroll} = False
        ?Browse:1{Prop:VScroll} = True
      END
      CASE BRW1::SortOrder
      OF 1
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF Sort:Alpha:Array[BRW1::CurrentScroll] => UPPER(PAM:U_NR)
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 2
      OF 3
        LOOP BRW1::CurrentScroll = 100 TO 1 BY -1
          IF BRW1::Sort3:KeyDistribution[BRW1::CurrentScroll] => PAM:DATUMS
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:1{Prop:VScroll} = True
        ?Browse:1{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW1::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW1::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW1::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW1::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW1::RecordCount
    BRW1::CurrentEvent = EVENT()
    CASE BRW1::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW1::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW1::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW1::ScrollEnd
    END
    ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
    DO BRW1::PostNewSelection
    CASE BRW1::SortOrder
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      PAM:NOS_A = BRW1::Sort2:LocatorValue
    END
  CASE BRW1::SortOrder
  OF 2
    BRW1::CurrentScroll = 50                      ! Move Thumb to center
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF BRW1::ItemsToFill
        IF BRW1::CurrentEvent = Event:ScrollUp
          BRW1::CurrentScroll = 0
        ELSE
          BRW1::CurrentScroll = 100
        END
      END
    ELSE
      BRW1::CurrentScroll = 0
    END
  END
  END
!----------------------------------------------------------------------
BRW1::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW1::FillRecord to retrieve one record in the direction required.
!|
  IF BRW1::CurrentEvent = Event:ScrollUp AND BRW1::CurrentChoice > 1
    BRW1::CurrentChoice -= 1
    EXIT
  ELSIF BRW1::CurrentEvent = Event:ScrollDown AND BRW1::CurrentChoice < BRW1::RecordCount
    BRW1::CurrentChoice += 1
    EXIT
  END
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = BRW1::CurrentEvent - 2
  DO BRW1::FillRecord
!----------------------------------------------------------------------
BRW1::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW1::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW1::FillRecord doesn't fill a page (BRW1::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  BRW1::FillDirection = BRW1::CurrentEvent - 4
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::ItemsToFill
    IF BRW1::CurrentEvent = Event:PageUp
      BRW1::CurrentChoice -= BRW1::ItemsToFill
      IF BRW1::CurrentChoice < 1
        BRW1::CurrentChoice = 1
      END
    ELSE
      BRW1::CurrentChoice += BRW1::ItemsToFill
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW1::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW1::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  DO BRW1::Reset
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::FillDirection = FillForward
  ELSE
    BRW1::FillDirection = FillBackward
  END
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::CurrentChoice = 1
  ELSE
    BRW1::CurrentChoice = BRW1::RecordCount
  END
!----------------------------------------------------------------------
BRW1::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW1::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW1::LocateRecord.
!|
  IF BRW1::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
      POST(Event:Accepted,?Change:2)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
    OF DeleteKey
      POST(Event:Accepted,?Delete:2)
    OF CtrlEnter
      POST(Event:Accepted,?Change:2)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          SELECT(?PAM:U_NR)
          PRESS(CHR(KEYCHAR()))
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            PAM:NOS_A = BRW1::Sort2:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          PAM:NOS_A = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          PAM:NOS_A = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 3
        IF CHR(KEYCHAR())
          SELECT(?PAM:DATUMS)
          PRESS(CHR(KEYCHAR()))
        END
      END
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
    END
  END
  DO BRW1::PostNewSelection
!----------------------------------------------------------------------
BRW1::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW1::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW1::LocateRecord.
!|
  IF ?Browse:1{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:1)
  ELSIF ?Browse:1{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:1)
  ELSE
    CASE BRW1::SortOrder
    OF 1
      PAM:U_NR = Sort:Alpha:Array[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 3
      PAM:DATUMS = BRW1::Sort3:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    END
  END
!----------------------------------------------------------------------
BRW1::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW1::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW1::ItemsToFill records. Normally, this will
!| result in BRW1::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW1::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW1::AddQueue is true, the queue is filled using the BRW1::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW1::AddQueue is false is when the BRW1::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW1::ItemsToFill > 1
    IF SEND(PAMAT,'QUICKSCAN=on').
    BRW1::QuickScan = True
  END
  IF BRW1::RecordCount
    IF BRW1::FillDirection = FillForward
      GET(Queue:Browse:1,BRW1::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:1,1)                       ! Get the first queue item
    END
    RESET(BRW1::View:Browse,BRW1::Position)       ! Reset for sequential processing
    BRW1::SkipFirst = TRUE
  ELSE
    BRW1::SkipFirst = FALSE
  END
  LOOP WHILE BRW1::ItemsToFill
    IF BRW1::FillDirection = FillForward
      NEXT(BRW1::View:Browse)
    ELSE
      PREVIOUS(BRW1::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'PAMAT')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW1::SkipFirst
       BRW1::SkipFirst = FALSE
       IF POSITION(BRW1::View:Browse)=BRW1::Position
          CYCLE
       END
    END
    IF BRW1::AddQueue
      IF BRW1::RecordCount = ?Browse:1{Prop:Items}
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse:1,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:1,BRW1::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:1)
        BRW1::RecordCount -= 1
      END
      DO BRW1::FillQueue
      IF BRW1::FillDirection = FillForward
        ADD(Queue:Browse:1)
      ELSE
        ADD(Queue:Browse:1,1)
      END
      BRW1::RecordCount += 1
    END
    BRW1::ItemsToFill -= 1
  END
  IF BRW1::QuickScan
    IF SEND(PAMAT,'QUICKSCAN=off').
    BRW1::QuickScan = False
  END
  BRW1::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW1::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW1::LocateMode. These modes are...
!|
!|   LocateOnPosition (1) - This mode is still supported for 1.5 compatability. This mode
!|                          is the same as LocateOnEdit.
!|   LocateOnValue    (2) - The values of the current sort order key are used. This mode
!|                          used for Locators and when the BrowseBox is called to select
!|                          a record.
!|   LocateOnEdit     (3) - The current record of the VIEW is used. This mode assumes
!|                          that there is an active VIEW record. This mode is used when
!|                          the sort order of the BrowseBox has changed
!|
!| If an appropriate record has been located, the BRW1::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW1::LocateMode = LocateOnPosition
    BRW1::LocateMode = LocateOnEdit
  END
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAM:NR_KEY)
      RESET(PAM:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PAM:NR_KEY,PAM:NR_KEY)
    END
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAM:NOS_KEY)
      RESET(PAM:NOS_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PAM:NOS_KEY,PAM:NOS_KEY)
    END
  OF 3
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAM:DAT_KEY)
      RESET(PAM:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PAM:DAT_KEY,PAM:DAT_KEY)
    END
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = FillForward               ! Fill with next read(s)
  BRW1::AddQueue = False
  DO BRW1::FillRecord                             ! Fill with next read(s)
  BRW1::AddQueue = True
  IF BRW1::ItemsToFill
    BRW1::RefreshMode = RefreshOnBottom
    DO BRW1::RefreshPage
  ELSE
    BRW1::RefreshMode = RefreshOnPosition
    DO BRW1::RefreshPage
  END
  DO BRW1::PostNewSelection
  BRW1::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW1::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW1::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse:1), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW1::RefreshMode = RefreshOnPosition
    BRW1::HighlightedPosition = POSITION(BRW1::View:Browse)
    RESET(BRW1::View:Browse,BRW1::HighlightedPosition)
    BRW1::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:1,RECORDS(Queue:Browse:1))
    END
    BRW1::HighlightedPosition = BRW1::Position
    GET(Queue:Browse:1,1)
    RESET(BRW1::View:Browse,BRW1::Position)
    BRW1::RefreshMode = RefreshOnCurrent
  ELSE
    BRW1::HighlightedPosition = ''
    DO BRW1::Reset
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::RefreshMode = RefreshOnBottom
    BRW1::FillDirection = FillBackward
  ELSE
    BRW1::FillDirection = FillForward
  END
  DO BRW1::FillRecord                             ! Fill with next read(s)
  IF BRW1::HighlightedPosition
    IF BRW1::ItemsToFill
      IF NOT BRW1::RecordCount
        DO BRW1::Reset
      END
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::FillDirection = FillForward
      ELSE
        BRW1::FillDirection = FillBackward
      END
      DO BRW1::FillRecord
    END
  END
  IF BRW1::RecordCount
    CASE BRW1::SortOrder
    OF 1; ?PAM:U_NR{Prop:Disable} = 0
    OF 2; ?PAM:NOS_A{Prop:Disable} = 0
    OF 3; ?PAM:DATUMS{Prop:Disable} = 0
    END
    IF BRW1::HighlightedPosition
      LOOP BRW1::CurrentChoice = 1 TO BRW1::RecordCount
        GET(Queue:Browse:1,BRW1::CurrentChoice)
        IF BRW1::Position = BRW1::HighlightedPosition THEN BREAK.
      END
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    ELSE
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::CurrentChoice = RECORDS(Queue:Browse:1)
      ELSE
        BRW1::CurrentChoice = 1
      END
    END
    ?Browse:1{Prop:Selected} = BRW1::CurrentChoice
    DO BRW1::FillBuffer
    ?Change:2{Prop:Disable} = 0
    ?Delete:2{Prop:Disable} = 0
  ELSE
    CLEAR(PAM:Record)
    CASE BRW1::SortOrder
    OF 1; ?PAM:U_NR{Prop:Disable} = 1
    OF 2; ?PAM:NOS_A{Prop:Disable} = 1
    OF 3; ?PAM:DATUMS{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    ?Change:2{Prop:Disable} = 1
    ?Delete:2{Prop:Disable} = 1
  END
  SETCURSOR()
  BRW1::RefreshMode = 0
  EXIT
BRW1::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    SET(PAM:NR_KEY)
  OF 2
    SET(PAM:NOS_KEY)
  OF 3
    SET(PAM:DAT_KEY)
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    WATCH(BRW1::View:Browse)
    REGET(BRW1::View:Browse,BRW1::Position)
  END
!----------------------------------------------------------------------
BRW1::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.InsertButton=?Insert:2
  BrowseButtons.ChangeButton=?Change:2
  BrowseButtons.DeleteButton=?Delete:2
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
  IF BrowseButtons.InsertButton THEN
    TBarBrwInsert{PROP:DISABLE}=BrowseButtons.InsertButton{PROP:DISABLE}
  END
  IF BrowseButtons.ChangeButton THEN
    TBarBrwChange{PROP:DISABLE}=BrowseButtons.ChangeButton{PROP:DISABLE}
  END
  IF BrowseButtons.DeleteButton THEN
    TBarBrwDelete{PROP:DISABLE}=BrowseButtons.DeleteButton{PROP:DISABLE}
  END
  DISABLE(TBarBrwHistory)
  ToolBarMode=BrowseMode
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwBottom{PROP:ToolTip}='Go to the Last Page'
  TBarBrwTop{PROP:ToolTip}='Go to the First Page'
  TBarBrwPageDown{PROP:ToolTip}='Go to the Next Page'
  TBarBrwPageUp{PROP:ToolTip}='Go to the Prior Page'
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwUP{PROP:ToolTip}='Go to the Prior Record'
  TBarBrwInsert{PROP:ToolTip}='Insert a new Record'
  DISPLAY(TBarBrwFirst,TBarBrwLast)
!--------------------------------------------------------------------------
ListBoxDispatch ROUTINE
  DO DisplayBrowseToolbar
  IF ACCEPTED() THEN            !trap remote browse box control calls
    EXECUTE(ACCEPTED()-TBarBrwBottom+1)
      POST(EVENT:ScrollBottom,BrowseButtons.ListBox)
      POST(EVENT:ScrollTop,BrowseButtons.ListBox)
      POST(EVENT:PageDown,BrowseButtons.ListBox)
      POST(EVENT:PageUp,BrowseButtons.ListBox)
      POST(EVENT:ScrollDown,BrowseButtons.ListBox)
      POST(EVENT:ScrollUp,BrowseButtons.ListBox)
      POST(EVENT:Locate,BrowseButtons.ListBox)
      BEGIN                     !EXECUTE Place Holder - Ditto has no effect on a browse
      END
      PRESSKEY(F1Key)
    END
  END

UpdateDispatch ROUTINE
  DISABLE(TBarBrwDelete)
  DISABLE(TBarBrwChange)
  IF BrowseButtons.DeleteButton AND BrowseButtons.DeleteButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwDelete)
  END
  IF BrowseButtons.ChangeButton AND BrowseButtons.ChangeButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwChange)
  END
  IF INRANGE(ACCEPTED(),TBarBrwInsert,TBarBrwDelete) THEN         !trap remote browse update control calls
    EXECUTE(ACCEPTED()-TBarBrwInsert+1)
      POST(EVENT:ACCEPTED,BrowseButtons.InsertButton)
      POST(EVENT:ACCEPTED,BrowseButtons.ChangeButton)
      POST(EVENT:ACCEPTED,BrowseButtons.DeleteButton)
    END
  END
!----------------------------------------------------------------
BRW1::ButtonInsert ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to insert a new record.
!|
!| First, the primary file's record  buffer is cleared, as well as any memos
!| or BLOBs. Next, any range-limit values are restored so that the inserted
!| record defaults to being added to the current display set.
!|
!| Next, LocalRequest is set to InsertRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the insert is successful (GlobalRequest = RequestCompleted) then the newly added
!| record is displayed in the BrowseBox, at the top of the listbox.
!|
!| If the insert is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  GET(PAMAT,0)
  CLEAR(PAM:Record,0)
  LocalRequest = InsertRecord
  IF COPYREQUEST=1
     DO SYNCWINDOW
     PAM:U_NR=0
  .
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonChange ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to change a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to ChangeRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the change is successful (GlobalRequest = RequestCompleted) then the newly changed
!| record is displayed in the BrowseBox.
!|
!| If the change is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = ChangeRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonDelete ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to delete a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to DeleteRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the delete is successful (GlobalRequest = RequestCompleted) then the deleted record is
!| removed from the queue.
!|
!| Next, the BrowseBox is refreshed, redisplaying the current page.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = DeleteRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    DELETE(Queue:Browse:1)
    BRW1::RecordCount -= 1
  END
  BRW1::RefreshMode = RefreshOnQueue
  DO BRW1::RefreshPage
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdatePamat) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[JOB_NR+39])
     BEGIN
        GlobalResponse = RequestCancelled
        EXIT
     .
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdatePamat
    LocalResponse = GlobalResponse
    CASE VCRRequest
    OF VCRNone
      BREAK
    OF VCRInsert
      IF LocalRequest=ChangeRecord THEN
        LocalRequest=InsertRecord
      END
    OROF VCRForward
      IF LocalRequest=InsertRecord THEN
        GET(PAMAT,0)
        CLEAR(PAM:Record,0)
      ELSE
        DO BRW1::PostVCREdit1
        BRW1::CurrentEvent=Event:ScrollDown
        DO BRW1::ScrollOne
        DO BRW1::PostVCREdit2
      END
    OF VCRBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollUp
      DO BRW1::ScrollOne
      DO BRW1::PostVCREdit2
    OF VCRPageForward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageDown
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRPageBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageUp
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRFirst
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollTop
      DO BRW1::ScrollEnd
      DO BRW1::PostVCREdit2
    OF VCRLast
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollBottom
      DO BRW1::ScrollEND
      DO BRW1::PostVCREdit2
    END
  END
  DO BRW1::Reset
  COPYREQUEST=0

BRW1::PostVCREdit1 ROUTINE
  DO BRW1::Reset
  BRW1::LocateMode=LocateOnEdit
  DO BRW1::LocateRecord
  DO RefreshWindow

BRW1::PostVCREdit2 ROUTINE
  ?Browse:1{PROP:SelStart}=BRW1::CurrentChoice
  DO BRW1::NewSelection
  REGET(BRW1::View:Browse,BRW1::Position)
  CLOSE(BRW1::View:Browse)


