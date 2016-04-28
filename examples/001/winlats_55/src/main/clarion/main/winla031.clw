                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_IeZak              PROCEDURE                    ! Declare Procedure
K_TABLE          QUEUE,PRE(K)
BPN                 STRING(14)                          !ATSLÇGA
BKK                 STRING(5)
PAR_NR              ULONG
NOS                 STRING(3)
SUMMA               DECIMAL(12,2)                       ! SÂkuma atlikums Ls
SUMMAV              DECIMAL(12,2)                       ! SÂkuma atlikums valûtâ
SUMMAP              DECIMAL(12,2)                       ! Apgrozîjums periodâ Ls
SUMMAVP             DECIMAL(12,2)                       ! Apgrozîjums periodâ valûtâ
                 .
IEZAKO              DECIMAL(12,2)                       ! GALA REZULTÂTA IEZAKS
SUMMA_C             REAL                                ! KONTROLE, VAI NAV MAINÎTS KURSS
SUMMA81             DECIMAL(12,2)                       ! IEÒÇMUMI
SUMMA82             DECIMAL(12,2)                       ! ZAUDÇJUMI
P_DAT               LONG
DAT                 LONG
LAI                 LONG
CG                  STRING(10)
IEZAK               ULONG,DIM(12)
BKK                 STRING(5)
PARNR               ULONG
SUMMA1              DECIMAL(12,2)
SUMMAV1             DECIMAL(12,2)
SUMMAP              DECIMAL(12,2)
SUMMAVP             DECIMAL(12,2)
SUMMAA              DECIMAL(12,2)
SUMMAVA             DECIMAL(12,2)
BANKURSS            DECIMAL(11,8)
NOS1                STRING(5)
SUMMAS              DECIMAL(12,2)
IEZA                DECIMAL(12,2)
SB_DAT              STRING(23)

!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------
Auto::Attempts       LONG,AUTO
Auto::Save:GG:U_NR   LIKE(GG:U_NR)

!-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
                       PROJECT(GGK:BAITS)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:KK)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:RS)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:VAL)
                     END
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
report REPORT,AT(198,146,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
RPT_HEADER DETAIL,AT(,,8000,1823)
         LINE,AT(7656,1042,0,781),USE(?Line4:15),COLOR(COLOR:Black)
         STRING('pârrçíina'),AT(6250,1563),USE(?String7:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa pçc'),AT(6250,1354),USE(?String7:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6198,1302,0,521),USE(?Line4:6),COLOR(COLOR:Black)
         STRING(@d06.),AT(5417,1563),USE(b_dat,,?b_dat:4),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Zaudçjumi'),AT(6927,1563,729,208),USE(?String7:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(63,1771,7594,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Ieòçmumi /'),AT(6927,1354,729,208),USE(?String7:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,1302,0,521),USE(?Line4:5),COLOR(COLOR:Black)
         STRING(@d06.),AT(4510,1354,677,177),USE(b_dat,,?b_dat:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kurss uz'),AT(5260,1354,938,208),USE(?String7:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums uz'),AT(3792,1354),USE(?String7:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(3115,1354),USE(b_dat,,?b_dat:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(2344,1354),USE(s_dat),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(' - '),AT(2969,1354),USE(?String14),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Valûtâ'),AT(1531,1563,760,208),USE(?String7:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Valûtâ'),AT(3010,1563,740,208),USE(?String7:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Valûtâ'),AT(4479,1563,729,208),USE(?String7:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums uz'),AT(875,1354),USE(?String7:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(1594,1354,677,208),USE(p_dat),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('P/N'),AT(490,1458,313,208),USE(?String7:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(3781,1563,667,208),USE(val_uzsk,,?val_uzsk:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(2302,1563,604,208),USE(val_uzsk,,?val_uzsk:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(854,1563,625,208),USE(val_uzsk),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1563,365,4896,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieòemumu/Zaudçjumu no kursu svârstîbâm aprçíins :'),AT(1021,698),USE(?String2),LEFT, |
             FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s23),AT(4990,698),USE(SB_DAT),LEFT(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1042,7604,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Rçíina tikai tâm kontu grupâm, ko pieprasîjis LIETOTÂJS Kontu Plânâ'),AT(104,1094,7552,208), |
             USE(?String6),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1302,7604,0),USE(?Line2),COLOR(COLOR:Black)
         STRING('BKK'),AT(73,1458,340,208),USE(?String7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(438,1302,0,521),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(833,1302,0,521),USE(?Line4:2),COLOR(COLOR:Black)
         LINE,AT(2292,1302,0,521),USE(?Line4:3),COLOR(COLOR:Black)
         LINE,AT(3750,1302,0,521),USE(?Line4:4),COLOR(COLOR:Black)
         LINE,AT(52,1042,0,781),USE(?Line3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:2)
         STRING(@s3),AT(5938,10,,156),USE(nos1),LEFT
         LINE,AT(2292,-10,0,198),USE(?Line4:10),COLOR(COLOR:Black)
         STRING(@n-_11.2),AT(2344,10,625,156),USE(SummaP),RIGHT
         STRING(@n-_13.2),AT(3021,10,729,156),USE(SummaVP),RIGHT
         LINE,AT(3750,-10,0,198),USE(?Line4:11),COLOR(COLOR:Black)
         STRING(@n-_11.2),AT(3802,10,625,156),USE(SummaA),RIGHT
         STRING(@n-_13.2),AT(4479,10,729,156),USE(SummaVA),RIGHT
         LINE,AT(5208,-10,0,198),USE(?Line4:12),COLOR(COLOR:Black)
         STRING(@n_10.8b),AT(5260,10,625,156),USE(bankurss),RIGHT
         LINE,AT(6198,-10,0,198),USE(?Line4:13),COLOR(COLOR:Black)
         STRING(@n-_11.2b),AT(6250,10,625,156),USE(SummaS),RIGHT
         STRING(@n-_11.2b),AT(6927,10,625,156),USE(IEZA),RIGHT
         LINE,AT(7656,-10,0,198),USE(?Line4:14),COLOR(COLOR:Black)
         STRING(@n-_11.2),AT(885,10,625,156),USE(Summa1),RIGHT
         STRING(@n-_13.2),AT(1563,10,729,156),USE(SummaV1),RIGHT
         LINE,AT(833,-10,0,198),USE(?Line4:9),COLOR(COLOR:Black)
         STRING(@n_5),AT(458,10,,156),USE(parnr),LEFT
         LINE,AT(438,-10,0,198),USE(?Line4:8),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line4:7),COLOR(COLOR:Black)
         STRING(@s5),AT(73,10,,156),USE(BKK),CENTER
       END
RPT_FOOTER DETAIL,AT(,,,698),USE(?unnamed)
         STRING('82500D'),AT(104,313),USE(?String37:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2b),AT(6667,313,885,208),USE(Summa82),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,521,7604,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('RS :'),AT(156,542),USE(?String41),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(365,542),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6573,542),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7198,542),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@n-_12.2b),AT(6667,104,885,208),USE(Summa81),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6198,-10,0,63),USE(?Line20:7),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,531),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(52,52,7604,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('81500K'),AT(104,104),USE(?String37),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,-10,0,63),USE(?Line20:6),COLOR(COLOR:Black)
         LINE,AT(3750,-10,0,63),USE(?Line20:5),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,63),USE(?Line20:4),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,63),USE(?Line20:3),COLOR(COLOR:Black)
         LINE,AT(438,-10,0,63),USE(?Line20:2),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,531),USE(?Line20),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,9000,8000,52)
         LINE,AT(52,0,7604,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!
!  Ieòçmumi/zaudçjumi no kursu starpîbâm
!
!
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  P_DAT=S_DAT-1 !IEPRIEKÐÇJÂ PERIODA BEIGAS

OMIT('MARIS')
  CASE men_NR
  OF 1
!     S_DAT=DATE(MEN_NR,1,gads)
     P_DAT=DATE(MEN_NR,1,gads)
!     B_DAT=DATE(MEN_NR+1,1,gads)-1
!      Periods20=MENESIS
  OF 2
  OROF 3
  OROF 4
  OROF 5
  OROF 6
  OROF 7
  OROF 8
  OROF 9
  OROF 10
  OROF 11
!     S_DAT=DATE(MEN_NR,1,gads)
     P_DAT=DATE(MEN_NR,1,gads)-1
!     B_DAT=DATE(MEN_NR+1,1,gads)-1
!     Periods20=MENESIS
  OF 12
!     S_DAT=DATE(MEN_NR,1,gads)
     P_DAT=DATE(MEN_NR,1,gads)-1
!     B_DAT=DATE(12,31,gads)
!     Periods20=MENESIS
  OF 13
!     S_DAT=DATE(1,1,gads)
     P_DAT=DATE(1,1,gads)
!     B_DAT=DATE(3,31,gads)
!     Periods20='1. ceturksnis'
  OF 14
!     S_DAT=DATE(4,1,gads)
     P_DAT=DATE(3,31,gads)
!     B_DAT=DATE(6,30,gads)
!     Periods20='2. ceturksnis'
  OF 15
!     S_DAT=DATE(7,1,gads)
     P_DAT=DATE(6,30,gads)
!     B_DAT=DATE(9,30,gads)
!     Periods20='3. ceturksnis'
  OF 16
!     S_DAT=DATE(10,1,gads)
     P_DAT=DATE(9,30,gads)
!     B_DAT=DATE(12,31,gads)
!     Periods20='4. ceturksnis'
  OF 17
!     S_DAT=DATE(1,1,gads)
     P_DAT=DATE(1,1,gads)
!     B_DAT=DATE(12,31,gads)
!     Periods20=clip(gads)&'. gads'
  ELSE
     STOP('NEGAIDÎTA KÏÛDA NR= '&MEN_NR)
  .
MARIS

  IF B_DAT > TODAY()
     B_DAT = TODAY()
  .
  SB_DAT=FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)
  DAT = TODAY()
  LAI = CLOCK()
  CLEAR(IEZAK)
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF GG::Used = 0           !DÇÏ GETGG
    CheckOpen(GG,1)
  END
  GG::USED+=1
  IF VAL_K::USED=0
     checkopen(val_k,1)
  .
  VAL_K::USED+=1
  IF KURSI_K::USED=0
     checkopen(kursi_k,1)
  .
  KURSI_K::USED+=1
  IF KON_K::USED=0
     checkopen(kon_k,1)
  .
  KON_K::USED+=1
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('gads',gads)
  BIND('CG',CG)
  BIND('CYCLEGGK',CYCLEGGK)
  FilesOpened = True

  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Ie/Za no Kursu svârstîbâm'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ggk:RECORD)
      GGK:BKK='1    '
!      GGK:DATUMS=DATE(1,1,GADS)
      GGK:DATUMS=DB_S_DAT
      SET(GGK:BKK_DAT,GGK:BKK_DAT)
      CG='K1100'
      Process:View{Prop:Filter} ='~CYCLEGGK(CG)'
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
      OPEN(report)
      report{Prop:Preview} = PrintPreviewImage
      PRINT(RPT:rpt_HEADER)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF GGK:BAITS=1 AND GGK:U_NR > 1 AND|   ! baits=1 JA TAS IR AGRÂK TAISÎTS
           inrange(GGK:DATUMS,s_dat,b_dat)     ! TAJÂ PAÐÂ periodâ
           IEZAK[MONTH(GGK:DATUMS)]=GGK:U_NR
        ELSE
           !02/03/2014 IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
           IF ~(GGK:VAL=val_uzsk)
!           IF GGK:BKK='26900'
!           STOP(GETKON_K(GGK:BKK,2,1)&KON:IEZAK&GGK:SUMMAV&GGK:VAL)
!           .
              IF GETKON_K(GGK:BKK,2,1) AND BAND(KON:BAITS,00000001B)   ! JÂRÇÍINA IEZAKS
                  SUMMA_C =GGK:SUMMAV*BANKURS(GGK:VAL,GGK:DATUMS)
                  IF ~INRANGE(GGK:SUMMA-SUMMA_C,-0.02,0.02)
                     KLUDA(10,FORMAT(GGK:DATUMS,@D6)&' UNR= '&GGK:U_NR)
                     DO PROCEDURERETURN
                  .
                  GET(K_TABLE,0)
                  CLEAR(K_TABLE)
                  IF ~(SUB(GGK:BKK,1,3)='219'  OR |    ! ÐITOS IR JÂDALA PA PARTNERIEM
                       SUB(GGK:BKK,1,3)='231'  OR |
                       SUB(GGK:BKK,1,3)='238'  OR |
                       SUB(GGK:BKK,1,4)='2399' OR |
                       SUB(GGK:BKK,1,5)='23910' OR |
                       SUB(GGK:BKK,1,3)='514'  OR |
                       SUB(GGK:BKK,1,3)='515'  OR |
                       SUB(GGK:BKK,1,3)='516'  OR |
                       SUB(GGK:BKK,1,3)='517'  OR |
                       SUB(GGK:BKK,1,3)='521'  OR |
                       SUB(GGK:BKK,1,3)='531'  OR |
                       SUB(GGK:BKK,1,3)='532'  OR |
                       SUB(GGK:BKK,1,3)='554')
                     GGK:PAR_NR=0
                  .
                  K:BPN = GGK:BKK&FORMAT(GGK:PAR_NR,@S6)&GGK:VAL
                  K:BKK = GGK:BKK
                  K:NOS = GGK:VAL
                  K:PAR_NR= GGK:PAR_NR
                  GET(K_TABLE,K:BPN)
                  IF ~ERROR()
                     IF GGK:DATUMS < P_DAT OR GGK:U_NR=1
                        IF GGK:D_K='D'
                          K:SUMMAV+= GGK:SUMMAV
                        ELSE
                          K:SUMMAV-= GGK:SUMMAV
                        .
                     ELSE
                        IF GGK:D_K='D'
                          K:SUMMAP +=GGK:SUMMA
                          K:SUMMAVP+=GGK:SUMMAV
                        ELSE
                          K:SUMMAP -=GGK:SUMMA
                          K:SUMMAVP-=GGK:SUMMAV
                        .
                     .
                     PUT(K_TABLE)
                     IF ERROR()
                        KLUDA(29,'K_TABLE')
                        FREE(K_TABLE)
                        RETURN
                     .
                  ELSE
                     K:BPN = GGK:BKK&FORMAT(GGK:PAR_NR,@S6)&GGK:VAL
                     K:BKK = GGK:BKK
                     K:PAR_NR= GGK:PAR_NR
                     K:NOS = GGK:VAL
                     IF GGK:DATUMS < P_DAT OR GGK:U_NR=1
                        IF GGK:D_K='D'
                          K:SUMMAV =GGK:SUMMAV
                        ELSE
                          K:SUMMAV=-GGK:SUMMAV
                        .
                     ELSE
                        IF GGK:D_K='D'
                          K:SUMMAP = GGK:SUMMA
                          K:SUMMAVP= GGK:SUMMAV
                        ELSE
                          K:SUMMAP =-GGK:SUMMA
                          K:SUMMAVP=-GGK:SUMMAV
                        .
                     .
                     ADD(K_TABLE)
                     IF ERROR()
                        KLUDA(29,'K_TABLE')
                        FREE(K_TABLE)
                        RETURN
                     .
                     SORT(K_TABLE,K:BPN)
                     IF ERROR()
                        KLUDA(29,'K_TABLE')
                        FREE(K_TABLE)
                        RETURN
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
  IF SEND(GGK,'QUICKSCAN=off').
  close(ProgressWindow)
  IF LocalResponse = RequestCompleted

!***** NODZÇÐAM VECOS IEZAKUS
      LOOP I#=1 TO 12
         IF IEZAK[I#]
            IF GETGG(IEZAK[I#])
               KLUDA(108,FORMAT(GG:DATUMS,@D06.))
               IF RIDELETE:GG()
                  KLUDA(26,'GG')
               .
            ELSE
               STOP('KLÛDA MEKLÇJOT GG U_NR:'&GG:U_NR)
            .
         .
      .
      SOLIS# =0
      IEZA=0
      IEZAKO=0
      DO AUTONUMBER
      FOUND_IEZA#=0
      LOOP I#=1 TO RECORDS(K_TABLE)
         GET(K_TABLE,I#)
         IF K:SUMMAV
            K:SUMMA=ROUND(K:SUMMAV*BANKURS(K:NOS,P_DAT),.01)
         ELSE
            K:SUMMA=0
         .
         bankurss= BANKURS(K:NOS,B_DAT)
         NOS1    = K:NOS
         BKK     = K:BKK
         PARNR   = K:PAR_NR
         SUMMA1  = K:SUMMA
         SUMMAV1 = K:SUMMAV
         SUMMAP  = K:SUMMAP
         SUMMAVP = K:SUMMAVP
         SUMMAA  = K:SUMMA+K:SUMMAP
         SUMMAVA = K:SUMMAV+K:SUMMAVP
         SUMMAS  = ROUND(SUMMAVA*BANKURSS,.01)
         IEZA    = SUMMAS-SUMMAA
         IEZAKO += IEZA
         IF ~(SUMMAA = 0)
            print(RPT:detail)
         .
         IF ~(IEZA = 0)
            CLEAR(GGK:RECORD)
            GGK:U_NR=GG:U_NR
            GGK:DATUMS=B_DAT
            GGK:BKK=K:BKK
            GGK:PAR_NR=K:PAR_NR
            GGK:SUMMA=ABS(IEZA)
            GGK:SUMMAV=ABS(IEZA)
            !02/03/2013 GGK:VAL='Ls '
            GGK:VAL=val_uzsk
            GGK:PVN_PROC=0
            GGK:PVN_TIPS=0
            GGK:BAITS=1
            IF IEZA > 0      ! IEÒÇMUMI, KONTAM JÂLIEK KLÂT Ls, LAI NOBALANSÇTU
               SUMMA81+=IEZA
               GGK:D_K='D'
               GGK:KK=1      ! TRENDS KONTU KORESPODENCEI
            ELSE             ! ZAUDÇJUMI, NO KONTA JÂÒAM NOST Ls, LAI NOBALANSÇTU
               SUMMA82+=ABS(IEZA)
               GGK:D_K='K'
               GGK:KK=2      ! TRENDS KONTU KORESPODENCEI
            .
            ADD(GGK)
            FOUND_IEZA#=1
         .
      .
      FREE(K_TABLE)
      GG:DOK_SENR=''
      GG:DATUMS=B_DAT
      GG:DOKDAT=B_DAT
      GG:SATURS='Ieò./Z no k/s: '&MENESISunG
      GG:ACC_DATUMS=TODAY()
      GG:ACC_KODS=ACC_KODS
      GG:SUMMA=ABS(IEZAKO)
      !02/03/2014 GG:VAL='Ls'
      GG:VAL=val_uzsk
      PUT(GG)
      CLEAR(GGK:RECORD)
      IF ~(IEZAKO = 0)
        GGK:U_NR=GG:U_NR
        GGK:DATUMS=B_DAT
        !02/03/2014 GGK:VAL='Ls '
        GGK:VAL=val_uzsk
        GGK:PVN_PROC=0
        GGK:PVN_TIPS=0
        GGK:BAITS=1
                                        ! VALÛTAS
        IF SUMMA81 > 0                  ! IEÒÇMUMS NO KURSU PAAUGSTINÂÐANÂS
           GGK:BKK='81500'
           GGK:D_K='K'
           GGK:SUMMA=SUMMA81
           GGK:SUMMAV=SUMMA81
           GGK:KK=1
           ADD(GGK)
        .
        IF SUMMA82 > 0                  ! ZAUDÇJUMS KURSU SAMAZINÂÐANÂS
           GGK:BKK='82500'
           GGK:D_K='D'
           GGK:SUMMA=SUMMA82
           GGK:SUMMAV=SUMMA82
           GGK:KK=2
           ADD(GGK)
        .
      .
    PRINT(RPT:rpt_footER)
    ENDPAGE(report)
    CLOSE(ProgressWindow)
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
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  DO ProcedureReturn

!-----------------------------------------------------------
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
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    val_k::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
    KURSI_K::Used -= 1
    IF KURSI_K::Used = 0 THEN CLOSE(KURSI_K).
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
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

!-------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR GGK:BKK[1] > '5'
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GGK')
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
      ?Progress:PctText{Prop:Text} = 'analizçti '&FORMAT(PercentProgress,@N3) & '% no DB'
      DISPLAY()
    END
  END
!-----------------------------------------------------------------------------
Autonumber ROUTINE
  Auto::Attempts = 0
  LOOP
    SET(GG:NR_KEY)
    PREVIOUS(GG)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GG')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:GG:U_NR = 1
    ELSE
      Auto::Save:GG:U_NR = GG:U_NR + 1
    END
    clear(GG:Record)
    GG:DATUMS=b_dat
    GG:U_NR = Auto::Save:GG:U_NR
    ADD(GG)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END
IZZFILTB PROCEDURE 


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
PAR_FI               STRING(1)
SAV_PARFI            STRING(1)
LKKK                 STRING(3)
par_nos_s            STRING(15)
window               WINDOW('Filtrs izziòâm'),AT(,,305,225),CENTER,IMM,SYSTEM,GRAY,RESIZE,MDI
                       OPTION('&RS'),AT(29,2,81,41),USE(RS),BOXED,HIDE
                         RADIO('Apstiprinâtie'),AT(37,12),USE(?rs:Radio1)
                         RADIO('Visi'),AT(37,21),USE(?rs:Radio2)
                         RADIO('Neapstiprinâtie'),AT(37,29),USE(?rs:Radio3)
                       END
                       OPTION('Konti'),AT(168,3,64,51),USE(LKKK),BOXED,HIDE
                         RADIO('&231'),AT(172,12),USE(?LKKK:Radio1),HIDE
                         RADIO('&531'),AT(172,25),USE(?LKKK:Radio2),HIDE
                       END
                       ENTRY(@s5),AT(193,12,30,10),USE(KKK,,?KKK:2),HIDE
                       ENTRY(@s5),AT(193,26,30,10),USE(KKK1),HIDE
                       ENTRY(@s5),AT(193,40,30,10),USE(KKK2),HIDE
                       OPTION,AT(222,6,60,17),USE(d_k,,?d_k:2),BOXED,HIDE
                         RADIO('D'),AT(226,11,15,10),USE(?D_K:Radio1:2),VALUE('D')
                         RADIO('K'),AT(242,11,15,10),USE(?D_K:Radio1:3),VALUE('K')
                         RADIO('DK'),AT(258,11,20,10),USE(?D_K:Radio1:4),VALUE('S')
                       END
                       OPTION,AT(234,21,60,17),USE(D_K1),BOXED,HIDE
                         RADIO('D'),AT(238,26,15,10),USE(?D_K1:Radio1:2),VALUE('D')
                         RADIO('K'),AT(254,26,15,10),USE(?D_K1:Radio1:3),VALUE('K')
                         RADIO('DK'),AT(270,26,20,10),USE(?D_K1:Radio1:4),VALUE('S')
                       END
                       OPTION,AT(234,36,60,17),USE(D_K2),BOXED,HIDE
                         RADIO('D'),AT(238,41,15,10),USE(?D_K2:Radio1),VALUE('D')
                         RADIO('K'),AT(254,41,15,10),USE(?D_K2:Radio2),VALUE('K')
                         RADIO('DK'),AT(269,41,20,10),USE(?D_K2:Radio3),VALUE('S')
                       END
                       STRING('Sastâdît izziòu'),AT(9,45,,10),USE(?IzzinuPar1),HIDE,LEFT
                       PROMPT('&No'),AT(60,45,,10),USE(?Prompt:NO),HIDE
                       SPIN(@D06.B),AT(76,45,48,10),USE(S_DAT),HIDE
                       BUTTON('+1m'),AT(125,41,19,14),USE(?ButtonNM),HIDE
                       BUTTON('-1m'),AT(145,41,19,14),USE(?ButtonNM:2),HIDE
                       STRING('Sastâdît izziòu'),AT(9,57,,10),USE(?IzzinuPar2),HIDE,LEFT
                       PROMPT('&Lîdz'),AT(60,57,,10),USE(?Prompt:LIDZ),HIDE
                       SPIN(@D06.B),AT(76,57,48,10),USE(B_DAT),HIDE
                       BUTTON('+1m'),AT(125,55,19,14),USE(?ButtonLM),HIDE
                       OPTION('&Valoda'),AT(28,68,117,26),USE(F:VALODA),BOXED,HIDE
                         RADIO('Latvieðu'),AT(37,78),USE(?F:VALODA:Radio1),VALUE('0')
                         RADIO('Angïu'),AT(86,78),USE(?F:VALODA:Radio2),VALUE('1')
                       END
                       BUTTON('F pçc No&daïas'),AT(168,55,62,14),USE(?Nodala),HIDE
                       BUTTON('-1m'),AT(145,55,19,14),USE(?ButtonLM:2),HIDE
                       ENTRY(@s2),AT(234,57,18,10),USE(F:NODALA),HIDE
                       BUTTON('Projekts (O&bjekts)'),AT(168,71,62,14),USE(?Projekts),HIDE
                       ENTRY(@n_6b),AT(234,73,36,10),USE(F:OBJ_NR),HIDE
                       STRING('Filtrs pçc'),AT(62,100,,10),USE(?FiltrsPec),HIDE
                       BUTTON('&Kontu PLÂNA'),AT(98,98,50,14),USE(?KontuPlans),HIDE
                       ENTRY(@s5),AT(154,100,27,10),USE(KKK),HIDE,CENTER,OVR
                       OPTION('&D/K'),AT(184,89,38,23),USE(d_k),BOXED,HIDE
                         RADIO('D'),AT(188,97,15,10),USE(?D_K:Radio1)
                         RADIO('K'),AT(204,97,16,10),USE(?D_K:Radio2)
                       END
                       PROMPT('PVN tips:'),AT(224,92,,10),USE(?Prompt:F:PVN_T),HIDE
                       ENTRY(@s1),AT(256,92,11,10),USE(F:PVN_T),HIDE,UPR
                       PROMPT('PVN %:'),AT(224,103,,10),USE(?Prompt:F:PVN_P),HIDE
                       ENTRY(@n2B),AT(256,103,11,10),USE(F:PVN_P),HIDE,UPR
                       OPTION('Filtrs pçc darîjuma &Partnera'),AT(22,113,141,55),USE(PAR_FI),BOXED,HIDE
                         RADIO('Visi'),AT(30,124,23,10),USE(?par_fi:Radio1),VALUE('V')
                         RADIO('1'),AT(31,155,13,10),USE(?par_fi:Radio2),VALUE('1')
                       END
                       STRING('tips:'),AT(60,124,16,10),USE(?StringParTips),HIDE
                       STRING(@s6),AT(76,124),USE(PAR_TIPS),HIDE
                       BUTTON('Mainît &Tipu'),AT(105,122,54,13),USE(?BUTTON:MainitParT),HIDE
                       STRING('grupa:'),AT(30,136,37,10),USE(?StringParGrupa),HIDE,RIGHT
                       ENTRY(@s7),AT(68,136,34,10),USE(PAR_GRUPA),HIDE,FONT('Fixedsys',9,,,CHARSET:BALTIC),OVR,UPR
                       BUTTON('&Grupa jâiekïauj'),AT(105,136,54,13),USE(?Button:Not_grupa),HIDE
                       STRING(@s15),AT(53,156,64,10),USE(par_nos_s),HIDE,LEFT(2)
                       BUTTON('&Partneris'),AT(118,152,41,13),USE(?Partneris),HIDE
                       BUTTON('&Nedrukât tukðas rindas'),AT(172,146,106,14),USE(?BUTTON:CEN),HIDE
                       IMAGE('CHECK3.ICO'),AT(280,146,15,14),USE(?Image:CEN),HIDE
                       ENTRY(@n1B),AT(124,196,12,10),USE(F:X),HIDE
                       PROMPT('Kur &X='),AT(100,196,24,10),USE(?PromptF:X),HIDE,RIGHT
                       BUTTON('Drukât tikai kop&summas'),AT(172,114,106,14),USE(?BUTTON:DTK),HIDE
                       IMAGE('CHECK3.ICO'),AT(280,130,15,14),USE(?Image:NOA),HIDE
                       STRING('1234567'),AT(70,147),USE(?String1234567),HIDE,FONT('Fixedsys',9,COLOR:Gray,,CHARSET:BALTIC)
                       BUTTON('&Noapaïot lîdz &veseliem Ls'),AT(172,130,106,14),USE(?BUTTON:NOA),HIDE
                       IMAGE('CHECK3.ICO'),AT(280,114,15,14),USE(?Image:DTK),HIDE
                       OPTION('Izdrukas &Formâts'),AT(22,168,65,39),USE(F:DBF),BOXED,HIDE
                         RADIO('WMF'),AT(26,177,28,10),USE(?F:DBF:WMF),VALUE('W')
                         RADIO('Word'),AT(26,185,30,10),USE(?F:DBF:Word),VALUE('A')
                         RADIO('Excel'),AT(26,194,28,10),USE(?F:DBF:EXCEL),VALUE('E')
                       END
                       BUTTON('D&rukas parametri'),AT(220,176,78,14),USE(?ButtonDruka),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
                       BUTTON('&OK'),AT(221,193,43,13),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(265,193,33,13),USE(?CancelButton)
                       BUTTON('Uzbûvçt XML'),AT(0,208,283,13),USE(?BUTTONXML),HIDE
                       IMAGE('CHECK3.ICO'),AT(286,207,15,14),USE(?ImageXML),HIDE
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  rs = 'Apstiprinâtie'
  par_fi = 'V'
  IF par_nr=0 THEN PAR_NR=999999999.
  SAV_PARFI = PAR_FI
  !PAR_GRUPA=''
  PAR_TIPS  ='EFCNIR'
  F:NOT_GRUPA=''
  F:DTK=''
  F:PVN_T=''
  F:PVN_P=0
  F:OBJ_NR=0
  F:NODALA=''
  F:X=0
  IF ~D_K THEN D_K='D'.
  IF ~D_K1 THEN D_K1='D'.
  IF ~D_K2 THEN D_K2='D'.
  IF ~F:VALODA THEN F:VALODA='0'.
  IF ~INSTRING('-',SYS:PZ_SERIJA)
     F:IDP='A'
  ELSE
     F:IDP='S'
  .
  F:XML=''
  IF ~(OPCIJA[12]>'1') THEN F:DBF='W'.
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  S_DAT_OPENED#=FALSE
  LOOP I#=1 TO 19 !MAX19
     IF OPCIJA[I#] > '0'
        EXECUTE I#
           UNHIDE(?D_K)                            !  1
           BEGIN                                   !  2  S_DAT
              UNHIDE(?S_DAT)
              S_DAT_OPENED#=TRUE
              UNHIDE(?BUTTONNM)
              UNHIDE(?BUTTONNM:2)
              UNHIDE(?PROMPT:NO)
              UNHIDE(?IzzinuPar1)
           .
           BEGIN                                   !  3  B_DAT
              UNHIDE(?B_DAT)
              UNHIDE(?BUTTONLM)
              UNHIDE(?BUTTONLM:2)
              UNHIDE(?PROMPT:LIDZ)
              IF OPCIJA[I#]='2'
                 ?Prompt:LIDZ{PROP:TEXT}='&Uz'
              .
              IF OPCIJA[I#-1]='0'
                 UNHIDE(?IzzinuPar2)
              .
           .
           BEGIN                                   !  4  Filtrs pçc konta
              UNHIDE(?FiltrsPec)
              UNHIDE(?KONTUPLANS)
              UNHIDE(?KKK)
           .
           BEGIN                                   ! 5  Filtrs pçc partnera/Darbinieku skaits Bilancei
              IF OPCIJA[I#]='5'                    ! Vieta, kur var labi ietûcît kâdu ciparu....
                  UNHIDE(?PAR_GRUPA)
                  UNHIDE(?StringParGrupa)
                  ?StringParGrupa{PROP:TEXT}='Darbin.sk.'
                  PAR_GRUPA=SYS:D_TA
              ELSE
                 UNHIDE(?PAR_FI)
                 UNHIDE(?PAR_NOS_S)
                 UNHIDE(?StringParGrupa)
                 UNHIDE(?PAR_GRUPA)
                 UNHIDE(?STRING1234567)
                 UNHIDE(?StringParTips)
                 UNHIDE(?PAR_TIPS)
                 UNHIDE(?BUTTON:MAINITPART)
                 par_fi = 'V'
                 IF ~(par_nr=999999999)
                    PAR_NOS_S=GETPAR_K(PAR_NR,0,1)
                    par_fi = '1'
                 .
              .
              IF OPCIJA[I#]='2'                    ! TIKAI KONKRÇTS
                  par_fi = '1'
                  UNHIDE(?PARTNERIS)
                  HIDE(?PAR_GRUPA)
                  HIDE(?PAR_TIPS)
                  HIDE(?BUTTON:MAINITPART)
                  HIDE(?PAR_FI:RADIO1) !VISI
                  HIDE(?StringParTips)
                  HIDE(?StringParGrupa)
                  HIDE(?STRING1234567)
                  HIDE(?Button:Not_grupa)
              ELSIF OPCIJA[I#]='3'                 ! TIKAI VISI(un GRUPA)
                  par_fi = 'V'
                  par_nr=999999999
                  HIDE(?PAR_FI:RADIO2) !KONKRÇTS
                  HIDE(?PAR_NOS_S)
              ELSIF OPCIJA[I#]='4'                 ! OPC1 UN IZLAIST GRUPU
                  UNHIDE(?BUTTON:not_grupa)
              .
              SAV_PARFI = PAR_FI
           .
           BEGIN                                   !6 Drukât tikai kopsummas/NESAM/Izv.erstâ v./drukât pasakòus/tukðus
              UNHIDE(?BUTTON:DTK)                  !  /~SHOW_U_NR/KOPS KONTUGR/MEKLÇT D231/tikai, ja parâds
              IF OPCIJA[I#]='2'
                 ?BUTTON:DTK{Prop:Text}='Drukât &tikai nesamaksâtâs'
              ELSIF OPCIJA[I#]='3'
                 ?BUTTON:DTK{Prop:Text}='Izvçrstâ veidâ'
              ELSIF OPCIJA[I#]='4'
                 ?BUTTON:DTK{Prop:Text}='Drukât &pasakòus'
                 F:DTK='1'
                 KKK=26100
              ELSIF OPCIJA[I#]='5'
                 ?BUTTON:DTK{Prop:Text}='Drukât arî &tukðus'
              ELSIF OPCIJA[I#]='6'
                 ?BUTTON:DTK{Prop:Text}='Nerâdît iekðçjos Nr'
              ELSIF OPCIJA[I#]='7'
                 ?BUTTON:DTK{Prop:Text}='arî kopsummas kontu grupâm'
              ELSIF OPCIJA[I#]='8'
                 ?BUTTON:DTK{Prop:Text}='sameklçt pçdçjo D231..'
              ELSIF OPCIJA[I#]='9'
                 ?BUTTON:DTK{Prop:Text}='Drukât &tikai, ja parâds'
              .
              IF F:DTK
                 UNHIDE(?IMAGE:DTK)
              .
           .
           BEGIN                                   !7 Noapaïot Ls/IZVÇRSUMS/PASTA ADRESE/~U_NR/KATRU UZ SAVAS LAPAS/VADÎBAS
              UNHIDE(?BUTTON:NOA)                  !  NERÂDÎT ARHÎVU
              IF OPCIJA[I#]='2'
                 ?BUTTON:NOA{Prop:Text}='Drukât nodaïu izvçrsumu'
  !            ELSIF OPCIJA[I#]='3'
  !               ?BUTTON:NOA{Prop:Text}='Drukât pasta adresi'
              ELSIF OPCIJA[I#]='4'
                 ?BUTTON:NOA{Prop:Text}='Nerâdît iekðçjos Nr'
              ELSIF OPCIJA[I#]='5'
                 ?BUTTON:NOA{Prop:Text}='Katru uz savas lapas'
              ELSIF OPCIJA[I#]='6'
                 ?BUTTON:NOA{Prop:Text}='Vadîbas(saîsinâtâ) atskaite'
              ELSIF OPCIJA[I#]='7'
                 ?BUTTON:NOA{Prop:Text}='Nerâdît arhîvu'
              .
              IF F:NOA
                 UNHIDE(?IMAGE:NOA)
              .
           .
           BEGIN                                   !  8  LKK KASTE un 3 konti &D/K/S
              UNHIDE(?LKKK)
  !            KKK = '00000'
  !            D_K ='D'
              UNHIDE(?KKK:2)
              UNHIDE(?d_k:2)
              UNHIDE(?D_K:RADIO1:2)
              UNHIDE(?D_K:RADIO1:3)
              UNHIDE(?D_K:RADIO1:4)
  !            KKK1 = '00000'
  !            D_K1 ='D'
              UNHIDE(?KKK1)
              UNHIDE(?D_K1)
              UNHIDE(?D_K1:RADIO1:2)
              UNHIDE(?D_K1:RADIO1:3)
              UNHIDE(?D_K1:RADIO1:4)
  !            KKK2 = '00000'
  !            D_K2 ='D'
              UNHIDE(?KKK2)
              UNHIDE(?D_K2)
              UNHIDE(?D_K2:RADIO1)
              UNHIDE(?D_K2:RADIO2)
              UNHIDE(?D_K2:RADIO3)
           .
           BEGIN                                   !  9  LKKK un 231&531
              UNHIDE(?LKKK)
              LKKK = '231'
              UNHIDE(?LKKK:RADIO1)
              UNHIDE(?LKKK:RADIO2)
              UNHIDE(?KKK:2)
              UNHIDE(?KKK1)
  !!!            KKK='231'
  !!!            KKK1='531'
              KKK = '00'
              KKK1 = '00'
           .
           BEGIN                                   !  10  26 & 238
              UNHIDE(?LKKK)
  !            UNHIDE(?PromptKN)
  !            UNHIDE(?P26)
  !            UNHIDE(?P238)
  !            UNHIDE(?SUBKONTS)
  !            UNHIDE(?SUBKONTS1)
              UNHIDE(?KKK:2)
              UNHIDE(?KKK1)
              CASE OPCIJA[I#]
              OF '1'
  !                ?PromptKN{Prop:Text}='Konta numuri'
  !                ?P26{PROP:TEXT}='26'
  !                ?P238{PROP:TEXT}='238'
                 KKK ='26100'
                 KKK1='23800'
              OF '2'
  !                ?PromptKN{Prop:Text}='Debeta konti'
  !                ?P26{Prop:Text}='219'
  !                ?P238{Prop:Text}='53'
                 ?LKKK{Prop:Text}='Debeta konti'
                 KKK ='21900'
                 KKK1='53100'
              OF '3'
  !                ?PromptKN{Prop:Text}='Debeta konti'
  !                ?P26{Prop:Text}='231'
  !                ?P238{Prop:Text}='52'
                 ?LKKK{Prop:Text}='Debeta konti'
                 KKK ='23100'
                 KKK1='52100'
              OF '4'
  !                ?PromptKN{Prop:Text}='Konta numurs'
  !                ?P26{Prop:Text}='26'
  !                HIDE(?P238)
  !                HIDE(?SUBKONTS1)
                 KKK='26100'
                 HIDE(?KKK1)
              OF '5'
  !                ?PromptKN{Prop:Text}='Konta numurs'
  !                ?P26{Prop:Text}='238'
  !                HIDE(?P238)
  !                HIDE(?SUBKONTS1)
                 KKK='23800'
                 HIDE(?KKK1)
              OF '6'
                 KKK ='23100'
                 KKK1='53100'
              END                                  
           .
           BEGIN                                   !  11  Filtrs pçc projekta
              UNHIDE(?PROJEKTS)
              UNHIDE(?F:OBJ_NR)
           .
           BEGIN                                   !  12  WMF/Word/Excel
              UNHIDE(?F:DBF)
              CASE OPCIJA[I#]
              OF '1'                               !  WMF/WORD
                 HIDE(?F:DBF:EXCEL)
                 F:DBF='W'
                 IF F:DBF='E' THEN F:DBF='W'.
              OF '2'                               !  WMF/EXCEL
                 HIDE(?F:DBF:WORD)
                 IF F:DBF='A' THEN F:DBF='W'.
              OF '3'                               !  WMF/TXT/EXCEL
                 IF ~INSTRING(F:DBF,'WAE') THEN F:DBF='W'.
              ELSE
                 KLUDA(0,'WMF/WORD/EXCEL izsaukums: '&OPCIJA[I#])
              .
           .
           BEGIN                                   !  13 Nodaïa
              UNHIDE(?NODALA)
              UNHIDE(?F:NODALA)
           .
           BEGIN
              UNHIDE(?F:VALODA)                    !  14 Valoda
           .
           BEGIN                                   !  15 1-vispâr var bût neapstiprinâtie
              IF ATLAUTS[1]='1' OR ~(ATLAUTS[18]='1')
                 UNHIDE(?RS)
              .
           .
           BEGIN                                   !  16 F:X (ÍEKSIS)                    
              UNHIDE(?F:X)
              UNHIDE(?PromptF:X)
           .
           HIDE(?ButtonDruka)                      !  17-NEVAJAG DRUKAS PARAMETRUS
           BEGIN                                   !  18 F:XML
              IF INRANGE(JOB_NR,1,15)              !TIKAI NO IZVÇLÇTAS GRÂMATVEDÎBAS
                 UNHIDE(?BUTTONXML)
                 IF OPCIJA[I#]='1'
                    ?BUTTONXML{PROP:TEXT}='Uzbûvçt '&USERFOLDER&'\PN_IZLIETOJUMS.DUF'
                 ELSIF OPCIJA[I#]='2'
                    ?BUTTONXML{PROP:TEXT}='Analizçt iepr.sadarbîbu pçc vçstures un salîdzinât ar tek.stâvokli'
                 ELSIF OPCIJA[I#]='3'
                    IF GADS >= 2008
                       ?BUTTONXML{PROP:TEXT}='Sag. UGP datus '&USERFOLDER&'\PZA22008.XML(iesn. kopâ ar Bilanci)'
                    ELSE
                       ?BUTTONXML{PROP:TEXT}='Sag. UGP datus '&USERFOLDER&'\UGP_UZ_2006_PZA2.XML(iesn. kopâ ar Bilanci)'
                    .
                 ELSIF OPCIJA[I#]='4'
                    IF GADS >= 2008
                       ?BUTTONXML{PROP:TEXT}='Apvienot PZA2,NPP2,PKIP.XML un Uzbûvçt '&USERFOLDER&'\UGP2008.XML'
                    ELSE
                       ?BUTTONXML{PROP:TEXT}='Apvienot PZA2,NPP2,PKIP.XML un Uzbûvçt '&USERFOLDER&'\UGP_UZ_2006.DUF'
                    .
                 ELSIF OPCIJA[I#]='5'
                    IF GADS >= 2008
                       ?BUTTONXML{PROP:TEXT}='Sag. UGP datus '&USERFOLDER&'\NPP22008.XML(iesn. kopâ ar Bilanci)'
                    ELSE
                       ?BUTTONXML{PROP:TEXT}='Sag. UGP datus '&USERFOLDER&'\UGP_UZ_2006_NPP2.XML(iesn. kopâ ar Bilanci)'
                    .
                 ELSIF OPCIJA[I#]='6'
                    IF GADS >= 2008
                       ?BUTTONXML{PROP:TEXT}='Sag. UGP datus '&USERFOLDER&'\PKIP2008.XML(iesn. kopâ ar Bilanci)'
                    ELSE
                       ?BUTTONXML{PROP:TEXT}='Sag. UGP datus '&USERFOLDER&'\UGP_UZ_2006_PKIP.XML(iesn. kopâ ar Bilanci)'
                    .
                 .
              .
           .
           BEGIN                                     !  19-BASE:BILANCE-Nedrukât tukðas rindas
              F:CEN=''
              UNHIDE(?BUTTON:CEN)                    
           .
        .
     .
  .
  IF S_DAT_OPENED#=FALSE
     S_DAT=DB_S_DAT
  .
  
  ACCEPT
    IF ~(SAV_PARFI=PAR_FI)
        CASE PAR_FI
        OF 'V'
            PAR_NR = 999999999
            HIDE(?PAR_NOS_S)
            UNHIDE(?BUTTON:MainitPART)
    !        UNHIDE(?BUTTON:Not_grupa) !pagaidâm unhidçjam tikai setupâ
            UNHIDE(?PAR_GRUPA)
        OF '1'
            UNHIDE(?PAR_NOS_S)
            PAR_GRUPA=''
            DISPLAY(?PAR_GRUPA)
            HIDE(?PAR_GRUPA)
            PAR_TIPS='EFCNIR'
            HIDE(?BUTTON:MainitPART)
    !        HIDE(?BUTTON:Not_grupa)
            GlobalRequest = SelectRecord
            BrowsePAR_K
            IF GlobalResponse = RequestCompleted
              PAR_NR=PAR:U_NR
              PAR_NOS_S=PAR:NOS_S
            ELSE
              PAR_NR=999999999
              PAR_NOS_S=''
            END
            GlobalResponse = RequestCancelled
            LocalResponse = RequestCancelled
        END
        SAV_PARFI = PAR_FI
    .
    IF KKK[1:4]='5721' AND OPCIJA[4]='2' !TIKAI ÞURNÂLAM
       UNHIDE(?Prompt:F:PVN_T)
       UNHIDE(?F:PVN_T)
       UNHIDE(?Prompt:F:PVN_P)
       UNHIDE(?F:PVN_P)
    ELSIF KKK[1:3]='261' AND OPCIJA[4]='2' !TIKAI ÞURNÂLAM
       UNHIDE(?Prompt:F:PVN_P)
       UNHIDE(?F:PVN_P)                 !PAGAIDÂM NOSTRÂDÂS TIKAI 5 un 18%
    ELSE
       F:PVN_T=''
       HIDE(?Prompt:F:PVN_T)
       HIDE(?F:PVN_T)
       F:PVN_P=0
       HIDE(?Prompt:F:PVN_P)
       HIDE(?F:PVN_P)
    .
    
    IF OPCIJA[10] <> 0
        CASE FIELD()
        OF ?KKK:2
            CASE EVENT()
            OF EVENT:Selected
               SELECT(?KKK:2,3,5)
            .
        OF ?KKK1
            CASE EVENT()
            OF EVENT:Selected
               SELECT(?KKK1,4,5)
            .
        END
    ELSIF OPCIJA[8] <> 0
        CASE FIELD()
        OF ?KKK:2
            CASE EVENT()
            OF EVENT:Selected
               SELECT(?KKK:2,1,5)
            .
        OF ?KKK1
            CASE EVENT()
            OF EVENT:Selected
                SELECT(?KKK1,1,5)
            .
        END
    !ELSIF OPCIJA[4] <> 0
    !    CASE FIELD()
    !    OF ?KKK
    !        CASE EVENT()
    !        OF EVENT:Selected
    !            IF KKK[5]
    !               SELECT(?KKK,3,5)
    !            .
    !        .
    !    END
    END
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?rs:Radio1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?LKKK:Radio1
      CASE EVENT()
      OF EVENT:Accepted
        !!KKK='231'
        !!UNHIDE(?KKK:2)
        !!SELECT(?KKK:2,4,5)
      END
    OF ?ButtonNM
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        S_DAT=DATE(MONTH(S_DAT)+1,DAY(S_DAT),YEAR(S_DAT))
        DISPLAY
      END
    OF ?ButtonNM:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        S_DAT=DATE(MONTH(S_DAT)-1,DAY(S_DAT),YEAR(S_DAT))
        DISPLAY
      END
    OF ?ButtonLM
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !IF MONTH(B_DAT)=2 AND (DAY(B_DAT)=28 OR DAY(B_DAT)=29)
        !   B_DAT=DATE(3,31,YEAR(B_DAT))
        !ELSIF MONTH(B_DAT)=12 AND DAY(B_DAT)=31
        !   B_DAT=DATE(1,31,YEAR(B_DAT)+1)
        !ELSIF DAY(B_DAT)=30 OR DAY(B_DAT)=31
        !   M#=MONTH(B_DAT)+1
        !   B_DAT=DATE(MONTH(B_DAT)+1,DAY(B_DAT)+1,YEAR(B_DAT))
        !   LOOP I#= 0 TO 5
        !      IF M#=MONTH(B_DAT-I#)
        !        B_DAT-=I#
        !        BREAK
        !      .
        !   .
        !ELSE
        !   B_DAT=DATE(MONTH(B_DAT)+1,DAY(B_DAT),YEAR(B_DAT))
        !.
        IF DAY(B_DAT)<28
           B_DAT=DATE(MONTH(B_DAT)+1,DAY(B_DAT),YEAR(B_DAT))
        ELSE
           B_DAT=DATE(MONTH(B_DAT)+2,1,YEAR(B_DAT))-1
        .
        DISPLAY
      END
    OF ?Nodala
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNodalas 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        if GlobalResponse=RequestCompleted
           F:NODALA = NOD:U_NR
        .
        display
      END
    OF ?ButtonLM:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF DAY(B_DAT)<28
           B_DAT=DATE(MONTH(B_DAT)-1,DAY(B_DAT),YEAR(B_DAT))
        ELSE
           B_DAT=DATE(MONTH(B_DAT),1,YEAR(B_DAT))-1
        .
        DISPLAY
      END
    OF ?Projekts
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseProjekti 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        if GlobalResponse=RequestCompleted
           F:OBJ_NR = PRO:U_NR
        .
        display
      END
    OF ?KontuPlans
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseKON_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        if globalresponse=requestcompleted
           kkk=kon:bkk
        .
        display
      END
    OF ?BUTTON:MainitParT
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         SEL_PAR_TIPS5
         DISPLAY(?PAR_TIPS)
      END
    OF ?Button:Not_grupa
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:NOT_GRUPA
           F:NOT_GRUPA = ''
           ?BUTTON:NOT_GRUPA{Prop:Text}='&Grupa jâiekïauj'
        ELSE
           F:NOT_GRUPA = '1'
           ?BUTTON:NOT_GRUPA{Prop:Text}='&Grupa jâizlaiþ'
        END
        DISPLAY
      END
    OF ?Partneris
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          GlobalRequest = SelectRecord
          BrowsePAR_K
          LocalResponse = GlobalResponse
          GlobalResponse = RequestCancelled
          IF LocalResponse = RequestCompleted
            PAR_NR=PAR:U_NR
            PAR_NOS_S=PAR:NOS_S
          ELSE
            LocalResponse = RequestCancelled
            DO procedurereturn
          END
      END
    OF ?BUTTON:CEN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:CEN
           F:CEN = ''
           HIDE(?IMAGE:CEN)
        ELSE
           F:CEN = '1'
           UNHIDE(?IMAGE:CEN)
        END
        DISPLAY
      END
    OF ?BUTTON:DTK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:DTK
           F:DTK = ''
           HIDE(?IMAGE:DTK)
        ELSE
           F:DTK = '1'
           UNHIDE(?IMAGE:DTK)
        END
        DISPLAY
      END
    OF ?BUTTON:NOA
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:NOA
           F:NOA = ''
           HIDE(?IMAGE:NOA)
        ELSE
           F:NOA = '1'
           UNHIDE(?IMAGE:NOA)
        END
        DISPLAY
      END
    OF ?ButtonDruka
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        SELECT(1)
        SELECT
        IF S_DAT>B_DAT
           KLUDA(0,'Sâkuma datums lielâks par beigu datumu')
           LocalResponse = RequestCancelled
           BREAK
        .
        CASE CHOICE(?LKKK)
        OF 1
           KKK = '231'&CLIP(KKK)
        OF 2
           KKK = '531'&CLIP(KKK1)
        END
        IF OPCIJA[5]='5'                    ! Vieta, kur var labi ietûcît kâdu ciparu....
           IF ~(SYS:D_TA=PAR_GRUPA)
              SYS:D_TA=PAR_GRUPA
              PUT(SYSTEM)
           .
        .
        LocalResponse = RequestCompleted
        BREAK
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        BREAK
      END
    OF ?BUTTONXML
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:XML
           F:XML = ''
           HIDE(?IMAGEXML)
        ELSE
           F:XML = '1'
           UNHIDE(?IMAGeXML)
        END
        DISPLAY
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('IZZFILTB','winlats.INI')
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
    INISaveWindow('IZZFILTB','winlats.INI')
    CLOSE(window)
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
  IF window{Prop:AcceptAll} THEN EXIT.
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
!---------------------------------------------------------------------------
B_Izzkont            PROCEDURE                    ! Declare Procedure
VIRSRAKSTS               STRING(50)
FILTRS_TEXT          STRING(100)
DEBKRE               STRING(11)
NGG                  DECIMAL(5)
DOK_NR               STRING(14)
SATURS               STRING(260) !80->260 25.02.2008 DÇÏ WORD-A
SATURS1              STRING(80)
DEB                  DECIMAL(14,2)
ATL                  DECIMAL(15,2)
KON_NOS              STRING(3)
TS0                  STRING(4)
DEBV                 DECIMAL(14,2)
ATLV                 DECIMAL(15,2)
NOS                  STRING(3)
KDEBP                DECIMAL(15,2)
KAPGP                DECIMAL(15,2)
KDEB                 DECIMAL(15,2)
KAPG                 DECIMAL(15,2)
a_DAT                LONG
ST                   STRING(7)
KATL                 DECIMAL(15,2)
TS                   STRING(12)
KATLV                DECIMAL(15,2)
KNOS                 STRING(3)
TSP                  STRING(12)
KDEBV                DECIMAL(15,2)
KAPRV                DECIMAL(15,2)
KNOSP                STRING(3)
LDEB                 DECIMAL(15,2)
LATL                 DECIMAL(15,2)
DAT                  LONG
LAI                  LONG
KAPR                 DECIMAL(15,2)
K_TABLE              QUEUE,PRE(K)
NOS                  STRING(3)
DEB1                 DECIMAL(12,2)       ! ATLIKUMS UZ GADA SÂKUMU
DEB                  DECIMAL(12,2)       ! IENÂCIS NO GADA SÂKUMA
DEBP                 DECIMAL(12,2)       ! IENÂCIS NO PER. SÂKUMA
                     .
CG                   STRING(10)
CP                   STRING(3)
DEBS                STRING(12)
APGS                STRING(12)
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
Process:View         VIEW(GGK)
                       PROJECT(GGK:BAITS)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:KK)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:PVN_PROC)
                       PROJECT(GGK:PVN_TIPS)
                       PROJECT(GGK:REFERENCE)
                       PROJECT(GGK:RS)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:VAL)
                     END

report REPORT,AT(100,1877,8000,9000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,200,8000,1677),USE(?unnamed)
         STRING(@s45),AT(1385,104,4531,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(1281,635,4917,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Izziòa kontam'),AT(3313,365),USE(?String67),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(104,885,7083,208),USE(FILTRS_TEXT),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7240,885,573,208),PAGENO,USE(?PAGECOUNT),RIGHT
         LINE,AT(156,1198,7656,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Nr'),AT(208,1250,313,208),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('GG'),AT(208,1458,313,208),USE(?String12:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(573,1458,885,208),USE(?String12:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(5885,1354,729,208),USE(DEBKRE),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('gada sâkuma'),AT(6719,1458,1094,208),USE(?String12:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1667,7656,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Summa no'),AT(6719,1250,1094,208),USE(?String12:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieraksta saturs'),AT(2448,1354,2063,208),USE(?String12:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1917,1354,469,208),USE(?String12:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konts'),AT(1490,1354,365,208),USE(?String12:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(573,1250,885,208),USE(?String12:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,1198,0,469),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1458,1198,0,469),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(1875,1198,0,469),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(2396,1198,0,469),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(5833,1198,0,469),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(6667,1198,0,469),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(7813,1198,0,469),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(156,1198,0,469),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         STRING(@S14),AT(573,10,885,156),USE(DOK_NR),RIGHT
         LINE,AT(1458,-10,0,198),USE(?Line2:26),COLOR(COLOR:Black)
         STRING(@S5),AT(1510,10,365,156),USE(GGK:BKK),LEFT
         LINE,AT(1875,-10,0,198),USE(?Line2:27),COLOR(COLOR:Black)
         STRING(@D05.),AT(1927,10,469,156),USE(GG:DATUMS),LEFT
         LINE,AT(2396,-10,0,198),USE(?Line2:28),COLOR(COLOR:Black)
         STRING(@S80),AT(2448,10,3385,156),USE(SATURS),LEFT
         LINE,AT(5833,-10,0,198),USE(?Line2:30),COLOR(COLOR:Black)
         STRING(@N-14.2B),AT(5885,10,781,156),USE(DEB),RIGHT
         LINE,AT(6667,-10,0,198),USE(?Line2:29),COLOR(COLOR:Black)
         STRING(@N-15.2B),AT(6719,10,781,156),USE(ATL),RIGHT
         STRING(@S3),AT(7552,10,240,156),USE(KON_NOS),LEFT
         LINE,AT(7813,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,198),USE(?Line2:25),COLOR(COLOR:Black)
         STRING(@N_5B),AT(208,10,313,156),USE(NGG),RIGHT
         LINE,AT(156,-10,0,198),USE(?Line2:3),COLOR(COLOR:Black)
       END
detailV DETAIL,AT(,,,177)
         LINE,AT(1458,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,198),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(2396,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@S80),AT(2448,10,3385,156),USE(SATURS1),LEFT
         LINE,AT(5833,-10,0,198),USE(?Line2:32),COLOR(COLOR:Black)
         STRING(@N-14.2B),AT(5885,10,781,156),USE(DEBV),RIGHT
         LINE,AT(6667,-10,0,198),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@N-15.2B),AT(6719,10,781,156),USE(ATLV),RIGHT
         STRING(@S3),AT(7552,10,240,156),USE(NOS),LEFT
         LINE,AT(7813,-10,0,198),USE(?Line222:13),COLOR(COLOR:Black)
         STRING(@S4),AT(1510,10,365,156),USE(TS0),LEFT
         LINE,AT(521,-10,0,198),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line222:3),COLOR(COLOR:Black)
       END
PER_APGR DETAIL,AT(,,,250)
         LINE,AT(156,-10,0,270),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,62),USE(?Line2:40),COLOR(COLOR:Black)
         LINE,AT(1458,-10,0,62),USE(?Line2:41),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,62),USE(?Line2:42),COLOR(COLOR:Black)
         LINE,AT(2396,-10,0,62),USE(?Line2:43),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,270),USE(?Line2:34),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,270),USE(?Line2:33),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,270),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(156,52,7656,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Apgrozîjums periodâ :'),AT(260,104,1146,156),USE(?String37),LEFT
         STRING(@D06.),AT(1458,104,,156),USE(S_DAT,,?S_DAT:2),LEFT
         STRING('-'),AT(2083,104,156,156),USE(?String37:2),CENTER
         STRING(@D06.),AT(2240,104,,156),USE(B_DAT,,?B_DAT:2),RIGHT
         STRING(@N-15.2B),AT(5885,104,781,156),USE(KDEBP),RIGHT
         STRING(@N-15.2B),AT(6719,104,781,156),USE(KAPGP),RIGHT
         STRING(@s3),AT(7552,104,229,156),USE(val_uzsk),LEFT
       END
GAD_APGR DETAIL,AT(,,,177)
         LINE,AT(5833,-10,0,198),USE(?Line2:36),COLOR(COLOR:Black)
         STRING(@N-14.2B),AT(5885,10,781,156),USE(KDEB),RIGHT
         LINE,AT(6667,-10,0,198),USE(?Line2:35),COLOR(COLOR:Black)
         STRING(@N-15.2B),AT(6719,10,781,156),USE(KAPG),RIGHT
         LINE,AT(7813,-10,0,198),USE(?Line222),COLOR(COLOR:Black)
         STRING('Apgrozîjums no gada sâkuma :'),AT(260,10,1823,156),USE(?String37:5),LEFT
         STRING(@s3),AT(7552,10,229,156),USE(val_uzsk,,?val_uzsk:2),LEFT
         LINE,AT(156,-10,0,198),USE(?Line212:3),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,177)
         LINE,AT(5833,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,198),USE(?Line2:37),COLOR(COLOR:Black)
         STRING(@N-15.2B),AT(6719,10,781,156),USE(KATL),RIGHT
         LINE,AT(7813,-10,0,198),USE(?Line232:13),COLOR(COLOR:Black)
         STRING('Konta'),AT(260,10,313,156),USE(?String37:6),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7552,10,229,156),USE(val_uzsk,,?val_uzsk:3),LEFT
         STRING('summa uz'),AT(833,10,,156),USE(?String69),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(635,10,,156),USE(D_K),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@S7),AT(2292,10,625,156),USE(ST),LEFT
         STRING(':'),AT(1823,10,156,156),USE(?String37:7),LEFT
         STRING(@D06.),AT(1510,10,,156),USE(A_DAT),LEFT
         LINE,AT(156,-10,0,198),USE(?Line242:3),COLOR(COLOR:Black)
       END
ATL_FOOT DETAIL,AT(,,,10),USE(?unnamed:2)
         LINE,AT(156,0,7656,0),USE(?Line1:6),COLOR(COLOR:Black)
       END
SAL_FOOT DETAIL,AT(,,,94)
         LINE,AT(156,52,7656,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,114),USE(?Line152),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,114),USE(?Line51:2),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,114),USE(?Line50:3),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,114),USE(?Line145),COLOR(COLOR:Black)
       END
RPT_VAL DETAIL,AT(,,,177)
         LINE,AT(5833,-10,0,198),USE(?Line2:39),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,198),USE(?Line2:38),COLOR(COLOR:Black)
         STRING(@N-15.2B),AT(6719,10,781,156),USE(KATLV),RIGHT
         LINE,AT(7813,-10,0,198),USE(?Line322:13),COLOR(COLOR:Black)
         STRING(@S3),AT(7552,10,240,156),USE(KNOS),LEFT
         STRING(@S12),AT(260,10,990,156),USE(TS),LEFT
         LINE,AT(156,-10,0,198),USE(?Line332:3),COLOR(COLOR:Black)
       END
APGR_VAL DETAIL,AT(,,,177)
         LINE,AT(5833,-10,0,198),USE(?Line2:44),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@N-15.2B),AT(6719,10,781,156),USE(KAPR),RIGHT
         LINE,AT(7813,-10,0,198),USE(?Line2:123),COLOR(COLOR:Black)
         STRING(@S3),AT(7552,10,240,156),USE(KNOSP),LEFT
         STRING(@N-14.2B),AT(5885,10,781,156),USE(KDEBV),RIGHT
         STRING(@S12),AT(260,10,1094,156),USE(TSP),LEFT
         LINE,AT(156,-10,0,198),USE(?Line2:133),COLOR(COLOR:Black)
       END
PER_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(156,52,7656,0),USE(?Line111:4),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,114),USE(?Line252),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,114),USE(?Line51:3),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,114),USE(?Line50:4),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,114),USE(?Line345),COLOR(COLOR:Black)
       END
RPT_FOOT0 DETAIL,AT(,,,94)
         LINE,AT(156,52,7656,0),USE(?Line331:4),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,114),USE(?Line652),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,114),USE(?Line51:4),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,114),USE(?Line50:5),COLOR(COLOR:Black)
         LINE,AT(2396,-10,0,62),USE(?Line49),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,62),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(1458,0,0,62),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,62),USE(?Line46),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,114),USE(?Line745),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,219),USE(?unnamed:4)
         LINE,AT(156,52,7656,0),USE(?Line651:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(333,73,479,135),USE(?String61),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@S8),AT(823,73,625,135),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6573,73,625,135),USE(dat),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7198,73,521,135),USE(lai),LEFT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(7813,-10,0,62),USE(?Line752),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,62),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,62),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,62),USE(?Line845),COLOR(COLOR:Black)
       END
PAGE_FOOT DETAIL,AT(,,,250),USE(?unnamed:3)
         LINE,AT(156,-10,0,270),USE(?Line222:17),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,62),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(1458,-10,0,62),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,62),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(2396,-10,0,62),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,270),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,270),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,270),USE(?Line222:24),COLOR(COLOR:Black)
         LINE,AT(156,52,7656,0),USE(?Line221:3),COLOR(COLOR:Black)
         STRING('Kopâ pa lapu :'),AT(260,104,1146,156),USE(?String37:8),LEFT
         STRING(@N-15.2B),AT(5885,104,781,156),USE(LDEB),RIGHT
         STRING(@N-15.2B),AT(6719,104,781,156),USE(LATL),RIGHT
         STRING(@s3),AT(7552,104,250,156),USE(val_uzsk,,?val_uzsk:4),LEFT
       END
       FOOTER,AT(100,10800,8000,52)
         LINE,AT(156,0,7656,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  CHECKOPEN(GG,1)
  CHECKOPEN(GGK,1)
  CHECKOPEN(KON_K,1)
  CHECKOPEN(PAR_K,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('PAR_NR',PAR_NR)
  BIND('D_K',D_K)
  BIND('CG',CG)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('KKK',KKK)
  BIND('CYCLEBKK',CYCLEBKK)
  BIND('GADS',GADS)
  IF KKK=''
     VIRSRAKSTS = 'Visi konti '&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)
  ELSIF INSTRING(' ',KKK)
     VIRSRAKSTS=KKK&' '&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)
  ELSE
     VIRSRAKSTS=KKK&': '&GETKON_K(KKK,2,2)&' '&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)
  .
!---------------------------------------------------
  IF PAR_NR=999999999
     FILTRS_TEXT='Visi partneri'
  ELSE
     FILTRS_TEXT=GETPAR_K(PAR_NR,2,2)
  .
  IF ~(PAR_TIPS='EFCNIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Tips: '&par_Tips.
  IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa: '&par_grupa.
  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nodaïa Nr: '&F:NODALA&' '&GetNodalas(F:nodala,1).
!---------------------------------------------------
  IF D_K='D'
     DEBKRE='Debets'
  ELSE
     DEBKRE='Kredîts'
  .
  PRSALDO#=1
  PRSAKAT#=1
  PRTEXT#=0
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Izziòa kontam'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
!      GGK:DATUMS = DATE(1,1,GADS)
      GGK:DATUMS = DATE(1,1,YEAR(S_DAT))
      SET(GGK:DAT_KEY,GGK:DAT_KEY)
      CG='K103011'
      CP='K11'
      Process:View{Prop:Filter} = '~CYCLEBKK(GGK:BKK,KKK) AND ~CYCLEPAR_K(CP) AND ~CYCLEGGK(CG)'
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
          IF ~OPENANSI('IZZKONT.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='IZZIÒA KONTAM'
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(VIRSRAKSTS)
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(FILTRS_TEXT)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
            OUTA:LINE='Nr.'&CHR(9)&'Dokumenta'&CHR(9)&'Konts'&CHR(9)&'Datums'&CHR(9)&'Ieraksta'&CHR(9)&CLIP(debkre)&|
            CHR(9)&'Summa no'
            ADD(OUTFILEANSI)
            OUTA:LINE='GG '&CHR(9)&'Numurs'&CHR(9)&CHR(9)&CHR(9)&'saturs'&CHR(9)&CHR(9)&'gada sâkuma'
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE='Nr.GG'&CHR(9)&'Dokumenta Numurs'&CHR(9)&'Konts'&CHR(9)&'Datums'&CHR(9)&|
            'Ieraksta saturs'&CHR(9)&CLIP(debkre)&CHR(9)&'Summa no gada sâkuma'
            ADD(OUTFILEANSI)
          END
                .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        npk#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        DO CHECKSALDO
        DO CHECKSAKAT
!!!        IF ~GGK:P3             ! ..TAI SKAITÂ IEZAKUS NERÂDA
        IF ~BAND(GGK:BAITS,00000001b)
          !El IF ~(GGK:val = 'LVL' or GGK:val = 'Ls')
          IF ~(GGK:val = val_uzsk)
            VALUTA#=TRUE
          .
          GET(K_TABLE,0)
          K:NOS=GGK:val
          GET(K_TABLE,K:NOS)
          IF ERROR()
            K:NOS=GGK:val
            K:DEB = 0
            K:DEBP = 0
            K:DEB1 = 0
            K:DEB = GGK:SUMMAV
            IF GGK:DATUMS >= S_DAT AND ~(GGK:u_NR=1)
               K:DEBP = GGK:SUMMAV
            .
            IF GGK:U_NR = 1
               K:DEB1 = GGK:SUMMAV
            .
            ADD(K_TABLE)
            SORT(K_TABLE,K:NOS)
          ELSE
            K:DEB += GGK:SUMMAV
            IF GGK:DATUMS >= S_DAT AND ~(GGK:U_NR=1)
               K:DEBP += GGK:SUMMAV
            .
            IF GGK:U_NR = 1
               K:DEB1 += GGK:SUMMAV
            .
            PUT(K_TABLE)
          .
          IF GGK:U_NR>1
            KDEB+=GGK:SUMMA
          .
          ATL+=GGK:SUMMA
          DO CHECKTEXT
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
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    DO CHECKSALDO
    DO CHECKSAKAT
    dat = today()
    lai = clock()
    KAPGP=KDEBP
    IF F:DBF='W'
        PRINT(RPT:PER_APGR)
    ELSE
        OUTA:LINE='Apgrozîjums periodâ:'&CHR(9)&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)&CHR(9)&CHR(9)&CHR(9)&|
        CHR(9)&LEFT(FORMAT(KDEBP,@N-_14.2B))&CHR(9)&LEFT(FORMAT(KAPGP,@N-_15.2B))&CHR(9)&val_uzsk
        !El CHR(9)&LEFT(FORMAT(KDEBP,@N-_14.2B))&CHR(9)&LEFT(FORMAT(KAPGP,@N-_15.2B))&CHR(9)&'Ls'
        ADD(OUTFILEANSI)
    END
    IF VALUTA#
      TSP ='Tai skaitâ:'
      GET(K_TABLE,0)
      LOOP N# = 1 TO RECORDS(K_TABLE)
        GET(K_TABLE,N#)
        IF K:DEBP > 0
           KDEBV = K:DEBP
           KAPRV  = KDEBV
           KNOSP = K:NOS
           IF F:DBF='W'
             PRINT(RPT:APGR_VAL)
           ELSE
             OUTA:LINE=CLIP(TSP)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KDEBV,@N-_14.2B))&CHR(9)&|
             LEFT(FORMAT(KAPR,@N-_15.2))&CHR(9)&KNOSP
             ADD(OUTFILEANSI)
           END
           tsp= ''
        .
      .
    .
    IF F:DBF='W'
        PRINT(RPT:PER_FOOT1)
    ELSE
!!        OUTA:LINE=''
!!        ADD(OUTFILEANSI)
    END
    KAPG=KDEB
    IF F:DBF='W'
        PRINT(RPT:GAD_APGR)
    ELSE
        OUTA:LINE='Apgrozîjums no gada sâkuma:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KDEB,@N-_14.2B))&|
        CHR(9)&LEFT(FORMAT(KAPG,@N-_15.2))&CHR(9)&val_uzsk
        !El CHR(9)&LEFT(FORMAT(KAPG,@N-_15.2))&CHR(9)&'Ls'
        ADD(OUTFILEANSI)
    END
    IF VALUTA#
      TSP ='Tai skaitâ:'
      GET(K_TABLE,0)
      LOOP N# = 1 TO RECORDS(K_TABLE)
        GET(K_TABLE,N#)
        IF K:DEB > 0
           KDEBV  = K:DEB
           KAPRV  = KDEBV
           KNOSP = K:NOS
           IF F:DBF = 'W'
             PRINT(RPT:APGR_VAL)
           ELSE
             OUTA:LINE=CLIP(TSP)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KDEBV,@N-_14.2B))&CHR(9)&|
             LEFT(FORMAT(KAPR,@N-_15.2))&CHR(9)&KNOSP
             ADD(OUTFILEANSI)
           END
           tsp= ''
        .
      .
    .
    IF F:DBF='W'
        PRINT(RPT:PER_FOOT1)
    ELSE
!!        OUTA:LINE=' '
!!        ADD(OUTFILEANSI)
    END
    KATL = ATL
    A_DAT= B_DAT
    IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT)
    ELSE
        DEBS = 0
        APGS = KATL
        OUTA:LINE='Konta '&D_K&' summa uz '&format(A_DAT,@D06.)&CHR(9)&CLIP(ST)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
        LEFT(FORMAT(KATL,@N-_15.2))&CHR(9)&val_uzsk
        !El LEFT(FORMAT(KATL,@N-_15.2))&CHR(9)&'Ls'
        ADD(OUTFILEANSI)
    END
    IF VALUTA#
      TS ='Tai skaitâ:'
      GET(K_TABLE,0)
      LOOP N# = 1 TO RECORDS(K_TABLE)
        GET(K_TABLE,N#)
        IF K:DEB <> 0
          KATLV = K:DEB
          KNOS  = K:NOS
          IF F:DBF = 'W'
            PRINT(RPT:RPT_VAL)
          ELSE
            !El OUTA:LINE=CLIP(TS)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KATLV,@N-_15.2))&CHR(9)&'Ls'
            OUTA:LINE=CLIP(TS)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KATLV,@N-_15.2))&CHR(9)&val_uzsk
            ADD(OUTFILEANSI)
          END
          ts = ''
        .
      .
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
        ENDPAGE(report)
    ELSE
!!        OUTA:LINE=' '
!!        ADD(OUTFILEANSI)
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
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
  NEXT(Process:View)
  IF ERRORCODE() OR GGK:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GGK')
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
CHECKSALDO   ROUTINE
!   IF (GGK:NR>1 OR DONE#) AND PRSALDO#
!    IF (GGK:U_NR >1 OR GGK:DATUMS>DATE(1,1,GL:DB_gads)) AND PRSALDO#
    IF (GGK:U_NR >1 OR GGK:DATUMS>DATE(1,1,YEAR(S_DAT))) AND PRSALDO#
!       A_DAT=DATE(1,1,GADS)
       A_DAT= DATE(1,1,YEAR(S_DAT))
       ST='(Saldo)'
       KATL = ATL
       IF F:DBF = 'W'
           PRINT(RPT:RPT_FOOT)
       ELSE
           OUTA:LINE='Konta '&D_K&' summa uz '&format(A_DAT,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
           LEFT(FORMAT(KATL,@N-15.2))&CHR(9)&val_uzsk
           !El LEFT(FORMAT(KATL,@N-15.2))&CHR(9)&'Ls'
           ADD(OUTFILEANSI)
       END
       ST=''
       IF VALUTA#
          TS ='Tai skaitâ:'
          GET(K_TABLE,0)
          LOOP K# = 1 TO RECORDS(K_TABLE)
            GET(K_TABLE,K#)
            IF K:DEB <> 0
              KATLV = K:DEB1
              KNOS = K:NOS
              IF F:DBF = 'W'
                PRINT(RPT:RPT_VAL)
              ELSE
                !El OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KATLV,@N-15.2))&CHR(9)&'Ls'
                OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KATLV,@N-15.2))&CHR(9)&val_uzsk
                ADD(OUTFILEANSI)
              END
              ts= ''
            .
          .
       .
       PRSALDO#=0
       IF GGK:DATUMS>=S_DAT OR DONE#
          PRINT(RPT:ATL_FOOT)
          PRSAKAT#=0
       .
    .

!-----------------------------------------------------------------------------
CHECKSAKAT   ROUTINE
    IF GGK:DATUMS>=S_DAT AND PRSAKAT# AND ~PRSALDO#
!   IF GGK:DATUMS>S_DAT AND PRSAKAT#
       A_DAT=S_DAT
       GET(K_TABLE,K#)
       KATL = ATL
       IF F:DBF = 'W'
         PRINT(RPT:SAL_FOOT)
       ELSE
         OUTA:LINE=''
         ADD(OUTFILEANSI)
       END
       IF F:DBF = 'W'
           PRINT(RPT:RPT_FOOT)
       ELSE
           OUTA:LINE='Konta '&D_K&' summa uz '&format(A_DAT,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
           LEFT(FORMAT(KATL,@N-15.2))&CHR(9)&val_uzsk
           !El LEFT(FORMAT(KATL,@N-15.2))&CHR(9)&'Ls'
           ADD(OUTFILEANSI)
       END
       IF VALUTA#
          TS ='Tai skaitâ:'
          LOOP N# = 1 TO RECORDS(K_TABLE)
            GET(K_TABLE,N#)
            IF K:DEB <> 0
              KATLV = K:DEB
              KNOS = K:NOS
              IF F:DBF = 'W'
                PRINT(RPT:RPT_VAL)
              ELSE
                !El OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KATLV,@N-15.2))&CHR(9)&'Ls'
                OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KATLV,@N-15.2))&CHR(9)&val_uzsk
                ADD(OUTFILEANSI)
              END
              ts= ''
            .
          .
       .
       PRSAKAT#=0
       IF F:DBF = 'W'
         PRINT(RPT:ATL_FOOT)
       ELSE
         OUTA:LINE=''
         ADD(OUTFILEANSI)
       END
    .

!-----------------------------------------------------------------------------
CHECKTEXT    ROUTINE
    IF GGK:DATUMS>=S_DAT AND GGK:U_NR>1
       gg:U_nr = ggk:U_nr
       GET(gg,gg:NR_key)
       IF ERROR()
          WRGG
       .
       ngg    = GG:U_NR
       DOK_NR=GG:DOK_SENR
!       IF PAR_NR=999999999 OR PAR_NR=0 OR ~(GG:NOKA=PAR:NOS_S)
       IF PAR_NR=999999999              !29.11.08
           IF GG:PAR_NR=GGK:PAR_NR
             teksts = CLIP(gg:noka)&' '&CLIP(gg:saturs)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
           ELSE
             C#=GETPAR_K(GGK:par_nr,2,1)
             TEKSTS = CLIP(PAR:NOS_S)&' '&CLIP(gg:saturs)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
           .
       ELSE
          TEKSTS = CLIP(gg:saturs)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
       .
       DEB=GGK:SUMMA
       DEBV = GGK:SUMMAV

       IF F:DBF='W' OR F:DBF='E' !WMF,EXCEL
          FORMAT_TEKSTS(88,'Arial',8,'')
          SATURS = F_TEKSTS[1]
       ELSE !A-WORD
          SATURS = TEKSTS  !DODAM VISU VIENÂ RINDÂ
          CLEAR(F_TEKSTS)
       .

       IF ~F:DTK
          IF F:DBF='W' !WMF
             PRINT(RPT:DETAIL)
          ELSE !WORD,EXCEL
             OUTA:LINE=FORMAT(NGG,@N_5B)&CHR(9)&DOK_NR&CHR(9)&GGK:BKK&CHR(9)&FORMAT(GG:DATUMS,@D06.)&CHR(9)&|
             SATURS&CHR(9)&LEFT(FORMAT(DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATL,@N-_15.2))&CHR(9)&KON_NOS
             ADD(OUTFILEANSI)
          .
       .

       saturs1= F_TEKSTS[2]
       !El IF ~(GGK:val='LVL' or ggk:val='Ls')
       IF ~(GGK:val=val_uzsk)
          ts0='t.s.'
          ATLV = DEBV
          NOS  = GGK:VAL
          IF ~F:DTK
             IF F:DBF='W'
                PRINT(RPT:DETAILV)
             ELSE
                OUTA:LINE=CHR(9)&CHR(9)&TS0&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2))&CHR(9)&|
                LEFT(FORMAT(ATLV,@N-_15.2))&CHR(9)&NOS
                ADD(OUTFILEANSI)
             .
          .
       ELSIF SATURS1
          IF ~F:DTK
             DEBV = 0
             ATLV = 0
             NOS  = ''
             IF F:DBF='W'
                PRINT(RPT:DETAILV)
             ELSE
                OUTA:LINE=CHR(9)&CHR(9)&TS0&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2))&CHR(9)&|
                LEFT(FORMAT(ATLV,@N-_15.2))&CHR(9)&NOS
                ADD(OUTFILEANSI)
             .
          .
       .
       ts0=''

       saturs1= F_TEKSTS[3]
       IF SATURS1
          DEBV = 0
          ATLV = 0
          NOS  = ''
          IF ~F:DTK
             IF F:DBF='W'
                PRINT(RPT:DETAILV)
             ELSE
                OUTA:LINE=CHR(9)&CHR(9)&TS0&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2))&CHR(9)&|
                LEFT(FORMAT(ATLV,@N-_15.2))&CHR(9)&NOS
                ADD(OUTFILEANSI)
             .
          .
       .
       LDEB += DEB
       KDEBP+= DEB
    .
    PRTEXT#=0
