                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_NPP2               PROCEDURE                    ! Declare Procedure
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

CG                   STRING(10)

R_TABLE     QUEUE,PRE(R)
KODS            USHORT
SUMMA           DECIMAL(13,2)
SUMMA0          DECIMAL(13,2)
            .

B_TABLE     QUEUE,PRE(B)
BKK_KODS        STRING(8)
SUMMA           DECIMAL(13,2)
            .
I_TABLE     QUEUE,PRE(I)
BKK             STRING(5)
DATUMS          LONG
SUMMA           DECIMAL(13,2)
            .
R_NOSAUKUMS          LIKE(KONR:NOSAUKUMS)
R_SUMMA              DECIMAL(13,2)
SR_SUMMA             STRING(15)
R_USER               BYTE
B_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
B_BKK                STRING(5)
I_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
PERIODS30            STRING(30)
KON_KOMENT           STRING(60)
DAT                  LONG
LAI                  LONG
CNTRL1               DECIMAL(13,2)
CNTRL2               DECIMAL(13,2)

E                    STRING(1)
TEX:DUF              STRING(100)
XMLFILENAME          CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

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

!-----------------------------------------------------------------------------
!!report REPORT,AT(100,200,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
report REPORT,AT(100,200,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
CEPURE DETAIL,AT(,,,1333),USE(?unnamed:7)
         STRING(@s45),AT(3146,104,3542,177),USE(client),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('E'),AT(7656,73),USE(?StringE),TRN,FONT(,22,,FONT:bold,CHARSET:ANSI)
         STRING(@s11),AT(3146,458,833,177),USE(GL:reg_nr),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzòçmuma reìistrâcijas numurs Nodokïu maksâtâju reìistrâ'),AT(104,479),USE(?String41)
         STRING('Taksâcijas periods'),AT(104,646),USE(?String41:3),TRN
         STRING(@s30),AT(3146,646,2240,180),USE(periods30),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçrvienîba: Ls'),AT(7031,646),USE(?String41:2),TRN
         STRING(@s60),AT(3146,281,4375,156),USE(GL:adrese),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Naudas plûsmas pârskats pçc netieðâs metodes (NPP2)'),AT(635,844,6510,260),USE(?String4), |
             CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1104,7656,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(5875,1104,0,230),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5500,1104,0,230),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(156,1104,0,230),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(6823,1104,0,230),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7813,1104,0,230),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Rindiòas nosaukums'),AT(1031,1146,3750,180),USE(?nosaukums),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Beigâs'),AT(5958,1146,781,177),USE(?client:4),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkumâ'),AT(6906,1146,833,177),USE(?client:5),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese'),AT(104,292,573,208),USE(?String10:6),LEFT
         STRING('Uzòçmuma (uzòçmçjsabiedrîbas) nosaukums'),AT(104,104,2448,208),USE(?String10:4),LEFT
       END
DETAILV DETAIL,AT(,,8000,177),USE(?unnamed)
         STRING(@s100),AT(188,10,5300,156),USE(R_NOSAUKUMS),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,-10,0,177),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,177),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2:10),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,167),USE(?unnamed:8)
         STRING(@N-_12.2B),AT(6917,10,854,156),USE(R:SUMMA0),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(5583,10,260,156),USE(R:KODS),LEFT,FONT(,9,,)
         STRING(@S15),AT(5927,10,854,156),USE(SR_SUMMA),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(156,-10,0,177),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,177),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@s100),AT(188,10,5300,156),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:2),LEFT(1)
       END
DETAILB DETAIL,AT(,,,167),USE(?unnamed:3)
         STRING(@N-_12.2B),AT(6917,10,,156),USE(R:SUMMA0,,?R:SUMMA0:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5583,10,260,156),USE(R:KODS,,?R:KODS:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S15),AT(5906,10,875,156),USE(SR_SUMMA,,?SR_SUMMA:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,-10,0,177),USE(?Line2K:11),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,177),USE(?Line2K:12),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2K:13),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2K:14),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2K:15),COLOR(COLOR:Black)
         STRING(@s100),AT(188,10,5300,156),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:3),LEFT(1),FONT(,,,FONT:bold,CHARSET:BALTIC)
       END
DETAILBKK DETAIL,AT(,,,167),USE(?unnamed:5)
         LINE,AT(156,-10,0,197),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@s60),AT(1042,10,4271,156),USE(B_NOSAUKUMS),LEFT
         STRING(@s5),AT(521,10,417,156),USE(B_BKK),LEFT
         LINE,AT(5500,-10,0,177),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2:20),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5927,10,,156),USE(B:SUMMA),RIGHT,FONT(,9,,)
       END
DETAILIZL DETAIL,AT(,,,167),USE(?unnamed:2)
         LINE,AT(156,-10,0,197),USE(?Line2I:16),COLOR(COLOR:Black)
         STRING(@s60),AT(1042,10,4271,156),USE(I_NOSAUKUMS),LEFT
         STRING(@s5),AT(521,10,417,156),USE(I:BKK),LEFT
         LINE,AT(5500,-10,0,177),USE(?Line2I:17),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2I:18),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2I:19),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2I:20),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5927,10,,156),USE(I:SUMMA),RIGHT,FONT(,9,,)
       END
SVITRA DETAIL,AT(,,,0),USE(?unnamed:9)
         LINE,AT(156,1,7656,0),USE(?Line1:2),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,,,354),USE(?unnamed:4)
         LINE,AT(156,-10,0,62),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,62),USE(?Line2:35),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,62),USE(?Line2:36),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,62),USE(?Line2:37),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,62),USE(?Line2:38),COLOR(COLOR:Black)
         LINE,AT(156,52,7656,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('RC :'),AT(156,73),USE(?String31),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(365,73,188,146),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6792,73,573,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7396,73,521,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@s25),AT(1146,208,1667,208),USE(SYS:AMATS1),TRN,RIGHT
         STRING('_{34}'),AT(2865,198,2240,156),USE(?String34),TRN
         STRING(@s25),AT(5063,208,1667,208),USE(SYS:PARAKSTS1),TRN,LEFT
       END
     END

!      FOOTER,AT(100,11200,8000,146),USE(?unnamed:6)
!        LINE,AT(156,-10,7656,0),USE(?Line1:6),COLOR(COLOR:Black)
!        STRING(@P<<<#. lapaP),AT(7292,-10,573,156),PAGENO,USE(?PageCount),RIGHT
!      END
!AGE_FOOT DETAIL,AT(,,,115)
!        LINE,AT(156,52,7656,0),USE(?Line1:3),COLOR(COLOR:Black)
!        LINE,AT(7813,-10,0,62),USE(?Line2:29),COLOR(COLOR:Black)
!        LINE,AT(6823,-10,0,62),USE(?Line2:28),COLOR(COLOR:Black)
!        LINE,AT(5875,-10,0,62),USE(?Line2:27),COLOR(COLOR:Black)
!        LINE,AT(5500,-10,0,62),USE(?Line2:26),COLOR(COLOR:Black)
!        LINE,AT(156,-10,0,62),USE(?Line2:25),COLOR(COLOR:Black)
!      END
!       FOOTER,AT(100,11168,8000,198),USE(?unnamed:6)
!         STRING(@P<<<#. lapaP),AT(7240,21,573,156),PAGENO,USE(?PageCount),RIGHT
!       END


Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CheckOpen(SYSTEM,1)
  CheckOpen(KON_R,1)
  KON_R::Used += 1
  IF RECORDS(KON_R)=0
     KLUDA(0,'Nav atrodams fails '&CLIP(LONGPATH())&'\'&KONRNAME)
     DO PROCEDURERETURN
  .
  IF KON_K::Used = 0
    CheckOpen(KON_K,1)
  END
  KON_K::Used += 1
  CheckOpen(GGK,1)
  FilesOpened = True

  CLEAR(KONR:RECORD)
  KONR:UGP='N' !Naudas PLP
  SET(KONR:UGP_KEY,KONR:UGP_KEY)
  LOOP
     NEXT(KON_R)
     IF ERROR() OR ~(KONR:UGP='N') THEN BREAK.
     R:KODS=KONR:KODS
     R:SUMMA=0
     ADD(R_TABLE)
  .
  SORT(R_TABLE,R:KODS)
  periods30='no '&FORMAT(S_DAT,@D6.)&' lîdz '&FORMAT(B_DAT,@D6.)
  DAT=TODAY()
  LAI=CLOCK()
  CG = 'K100000'

  BIND(KON:RECORD)
  BIND(GGK:RECORD)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Pârskats par naudas plûsmu'
  ?Progress:UserString{Prop:Text}=''
  SEND(KON_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      SET(GGK:DAT_KEY)
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
      IF F:XML !EDS
        XMLFILENAME=USERFOLDER&'\UGP_UZ_2006_NPP2.DUF'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           E='E'
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLEGGK(CG)
          IF ~GETKON_K(ggk:BKK,2,1)
             DO PROCEDURERETURN
          .
          nk#+=1
          ?Progress:UserString{Prop:Text}=NK#
          DISPLAY(?Progress:UserString)
          ATRASTS#=0
          LOOP J# = 1 TO 4
             IF kon:NPP2[J#]
                R:KODS=kon:NPP2[J#]
                GET(R_TABLE,R:KODS)
                IF ERROR()
                   KLUDA(71,'www.vid.gov.lv KONTS='&kon:BKK&' R='&kon:NPP2[J#])
                   DO PROCEDURERETURN
                ELSE
                   IF BAND(GGK:BAITS,00000100B) !IZLAIST NPP2
                      I:BKK  =GGK:BKK
                      I:DATUMS=GGK:DATUMS
                      I:SUMMA=GGK:SUMMA
                      ADD(I_TABLE)
                   ELSE
                      R_SUMMA=0
                      IF  ~(GGK:U_NR=1) ! ~SALDO
                         CASE KON:NPPF[J#]
                         OF 'A' !D-K
                            IF GGK:D_K='D'
                               R_SUMMA=GGK:SUMMA
                            ELSE
                               R_SUMMA=-GGK:SUMMA
                            .
                         OF 'B' !K-D
                            IF GGK:D_K='D'
                               R_SUMMA=-GGK:SUMMA
                            ELSE
                               R_SUMMA=GGK:SUMMA
                            .
                         OF 'D' !D
                            IF GGK:D_K='D'
                               R_SUMMA=GGK:SUMMA
                            .
                         OF 'E' !-D
                            IF GGK:D_K='D'
                               R_SUMMA-=GGK:SUMMA
                            .
                         OF 'K' !K
                            IF GGK:D_K='K'
                               R_SUMMA=GGK:SUMMA
                            .
                         OF 'L' !-K
                            IF GGK:D_K='K'
                               R_SUMMA=-GGK:SUMMA
                            .
                         OF 'S' !SALDO DEBETS
                            !NONE
                         ELSE
                            KLUDA(17,' A-B-D-E-K-L kontam '&KON:BKK)
                            DO PROCEDURERETURN
                         .
                      ELSIF KON:NPPF[J#]='S' AND GGK:U_NR=1 ! SALDO
                         IF GGK:D_K='D'
                            R_SUMMA=GGK:SUMMA
                         ELSE
                            R_SUMMA=-GGK:SUMMA
                         .
                      .
                      IF R_SUMMA
                         R:SUMMA+=R_SUMMA
                         PUT(R_TABLE)
                         IF F:DTK  !IZVÇRSTÂ VEIDÂ
                            B:BKK_KODS=GGK:BKK&FORMAT(R:KODS,@N_3)
                            GET(B_TABLE,B:BKK_KODS)
                            IF ERROR()
                               B:SUMMA=R_SUMMA
                               ADD(B_TABLE)
                               SORT(B_TABLE,B:BKK_KODS)
                            ELSE
                               B:SUMMA+=R_SUMMA
                               PUT(B_TABLE)
                            .
                         .
                      .
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
!****************************** 2. SOLIS ********************************
  PRINT(RPT:CEPURE)
  PRINT(RPT:SVITRA)
  DO FILLR_TABLE   !AIZPILDA VISAS STARPSUMMAS
  GET(R_TABLE,0)
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     V#=INSTRING(FORMAT(R:KODS,@N03),'020250350',3) !PIRMS ÐITIEM VAJAG LIELO VIRSRAKSTU
     IF V#
        EXECUTE(V#)
           R_NOSAUKUMS='I. Pamatdarbîbas naudas plûsma'
           R_NOSAUKUMS='II. Ieguldîðanas darbîbas naudas plûsma'
           R_NOSAUKUMS='III. Finansçðanas darbîbas naudas plûsma'
        .
        PRINT(RPT:DETAILV)
        PRINT(RPT:SVITRA)
     .
!     CNTRL1+=R:SUMMA
     R_NOSAUKUMS=GETKON_R('N',R:KODS,0,1)
     R_USER=GETKON_R('N',R:KODS,0,3)
     IF F:NOA
        SR_SUMMA=FORMAT(R:SUMMA,@N-15)
     ELSE
        SR_SUMMA=FORMAT(R:SUMMA,@N-15.2)
     .
     IF (R:KODS=130 OR R:KODS=180 OR R:KODS=210)    !MAZIE PAMATDARBÎBAS VIRSRAKSTI UN STARPSUMMAS
!        R:SUMMA=CNTRL1
        PRINT(RPT:DETAIL)
        PRINT(RPT:SVITRA)
     ELSIF (R:KODS=230 OR R:KODS=330 OR R:KODS=410) !LIELÂS SADAÏU KOPSUMMAS
!        R:SUMMA=CNTRL1
        PRINT(RPT:DETAILB)
        PRINT(RPT:SVITRA)
!        CNTRL2+=CNTRL1       !SKAITAM KOPÂ PRIEKÐ PG NETO NAUDAS PLÛSMAS
!        CNTRL1=0             !NULLÇJAM LIELÂS SADAÏAS KOPSUMMU
     ELSIF(R:KODS=420)                              !IEZAKS
        PRINT(RPT:DETAILB)
        PRINT(RPT:SVITRA)
     ELSIF(R:KODS=430)                              !PG NETO NAUDAS PLÛSMA
!        R:SUMMA=CNTRL2
        PRINT(RPT:DETAILB)
        PRINT(RPT:SVITRA)
     ELSIF(R:KODS=440)                              !NAUDA SÂKUMÂ
        PRINT(RPT:DETAILB)
        PRINT(RPT:SVITRA)
!        CNTRL2+=R:SUMMA      !CTRL2 TAGAD IZMANTOJAM KÂ KONTROLSUMMU
     ELSIF(R:KODS=450)                              !NAUDA BEIGÂS
        PRINT(RPT:DETAILB)
!        CNTRL2-=R:SUMMA      !CTRL2 TAGAD JÂBÛT 0-EI
     ELSIF ~(R_USER AND ~R:SUMMA)
        PRINT(RPT:DETAIL)
        IF F:DTK  !IZVÇRSTÂ VEIDÂ
           LOOP J#= 1 TO RECORDS(B_TABLE)
              GET(B_TABLE,J#)
              IF B:BKK_KODS[6:8]=R:KODS
                 B_BKK=B:BKK_KODS[1:5]
                 B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 PRINT(RPT:DETAILBKK)
              .
           .
        .
        PRINT(RPT:SVITRA)
     .
     IF F:XML_OK#=TRUE AND ~(R_USER AND ~R:SUMMA)
        XML:LINE='<<Row>'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="tabula" value="npp" />'   !npp-NPP2
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="rinda" value="'&CLIP(R:KODS)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="iepr_vert" value="0" />'   !?
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="vertiba" value="'&CLIP(ROUND(R:SUMMA,1))&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<</Row>'
        ADD(OUTFILEXML)
     .
  .
  IF F:DTK and RECORDS(I_TABLE)  !IZVÇRSTÂ VEIDÂ
     R_NOSAUKUMS='Izlaistas summas '
     PRINT(RPT:SVITRA)
     PRINT(RPT:DETAILV)
     LOOP J#= 1 TO RECORDS(I_TABLE)
        GET(I_TABLE,J#)
        I_NOSAUKUMS=FORMAT(I:DATUMS,@D6.)&' '&GETKON_K(I:BKK,0,2)
        PRINT(RPT:DETAILIZL)
     .
     PRINT(RPT:SVITRA)
  .
  PRINT(RPT:FOOTER)

  IF ~CNTRL2                                    ! PNP2 OK.
     IF B_DAT=DATE(12,31,GADS)
        IF ~BAND(SYS:control_byte,00001000b)       ! nebija OK
           SYS:control_byte += 8
           PUT(SYSTEM)
        .
     .
  ELSE                                          ! PNP2 NAV OK.
     KLUDA(0,'Nesakrît kopsummas (430,440,450) par Ls '&CNTRL2)
     IF B_DAT=DATE(12,31,GADS)
        IF BAND(SYS:control_byte,000001000b)        ! bija OK
           SYS:control_byte -= 8
           PUT(SYSTEM)
        .
     .
  .

  IF F:XML_OK#=TRUE
     CLOSE(OUTFILEXML)
  .
  IF SEND(KON_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
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
  FREE(R_TABLE)
  FREE(B_TABLE)
  FREE(I_TABLE)
  KON_R::Used -= 1
  IF KON_R::Used = 0 THEN CLOSE(KON_R).
  IF FilesOpened
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
  .
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
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
  IF ERRORCODE() OR GGK:DATUMS > B_DAT
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
FILLR_TABLE         ROUTINE
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     CNTRL1+=R:SUMMA
     IF (R:KODS=130 OR R:KODS=180 OR R:KODS=210)    !MAZIE PAMATDARBÎBAS VIRSRAKSTI UN STARPSUMMAS
        R:SUMMA=CNTRL1
        PUT(R_TABLE)
     ELSIF (R:KODS=230 OR R:KODS=330 OR R:KODS=410) !LIELÂS SADAÏU KOPSUMMAS
        R:SUMMA=CNTRL1
        PUT(R_TABLE)
        CNTRL2+=CNTRL1       !SKAITAM KOPÂ PRIEKÐ PG NETO NAUDAS PLÛSMAS
        CNTRL1=0             !NULLÇJAM LIELÂS SADAÏAS KOPSUMMU
     ELSIF(R:KODS=430)                              !PG NETO NAUDAS PLÛSMA
        R:SUMMA=CNTRL2
        PUT(R_TABLE)
        PRINT(RPT:DETAILB)
        PRINT(RPT:SVITRA)
     ELSIF(R:KODS=440)                              !NAUDA SÂKUMÂ
        CNTRL2+=R:SUMMA      !CTRL2 TAGAD IZMANTOJAM KÂ KONTROLSUMMU
     ELSIF(R:KODS=450)                              !NAUDA BEIGÂS
        PRINT(RPT:DETAILB)
        CNTRL2-=R:SUMMA      !CTRL2 TAGAD JÂBÛT 0-EI
     .
  .
K_INTRASTAT          PROCEDURE (OPC)              ! Declare Procedure
N_TABLE         QUEUE,PRE(N)
KEY                 STRING(18)
F_SUMMA             DECIMAL(8)
NETOMASA            DECIMAL(6)
DAUDZUMS            DECIMAL(8)
CITAS               DECIMAL(8)
                .
CN                  STRING(10)
CP                  STRING(3)
FORMA               STRING(30)
NPK                 DECIMAL(3)
ESKN                DECIMAL(8)
F_SUMMA             DECIMAL(9)
NETO                DECIMAL(10)
DAUDZUMS            DECIMAL(10)
NVKODS              STRING(2)
IVKODS              STRING(2)
Dar_V_KODS          BYTE
DAT                 LONG
LAI                 LONG
RINDUSK             LONG
NOL_TEXT            STRING(45)
StatVertiba         DECIMAL(7)
PIEG_N_kods         STRING(3)
TR_V_kods           BYTE
ND_K                LIKE(D_K)
MENESIS             STRING(10)

FilesOpened          LONG


! optimâlais Portrait garums: 11000
!------------------------------------------------------------------------
report REPORT,AT(198,198,8010,10896),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,200,8000,104)
       END
RPT_HEADER DETAIL,AT(,,,3656)
         STRING('Latvijas Republikas Centrâlâ statistiska pârvalde'),AT(2031,52),USE(?String1),CENTER, |
             FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,365,7604,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(7760,365,0,677),USE(?Line3:2),COLOR(COLOR:Black)
         STRING('Pârskats par tirdzniecîbu ar Eiropas'),AT(198,469,3750,260),USE(?String1:2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(4000,469,3750,260),USE(FORMA),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_4),AT(4885,729),USE(GADS),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(5354,729),USE(?String5),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(5885,729),USE(menesis),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('savienîbas dalîbvalstîm'),AT(198,729,3750,260),USE(?String1:3),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3958,365,0,677),USE(?Line3:3),COLOR(COLOR:Black)
         LINE,AT(156,1042,7604,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Kopçjais aizpildîto rindu skaits pârskata veidlapâ'),AT(4104,1146,3281,208),USE(?String9), |
             FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n3),AT(7438,1146),USE(RinduSk),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1406,7604,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(3958,1406,0,2188),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(7760,1406,0,2188),USE(?Line3:6),COLOR(COLOR:Black)
         STRING('Respondents'),AT(198,1448,3750,260),USE(?String1:4),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Respondenta pilnvarotais parstavis'),AT(4000,1448,3750,260),USE(?String1:5),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1719,7604,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Nodokïu maksâtâja reìistra kods'),AT(4010,1771,1979,260),USE(?String1:6),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S13),AT(2208,1771,885,260),USE(GL:VID_NR),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodokïu maksâtâja reìistra kods'),AT(208,1771,1979,260),USE(?String1:13),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(208,2031,781,260),USE(?String1:36),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(4010,2031,1719,260),USE(?String1:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S45),AT(990,2031,2917,260),USE(CLIENT),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pasta adrese'),AT(208,2292,781,260),USE(?String1:37),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pasta adrese'),AT(4010,2292,1719,260),USE(?String1:8),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S45),AT(990,2292,2917,260),USE(GL:ADRESE,,?GL:ADRESE:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Biroja adrese'),AT(208,2552,781,260),USE(?String1:38),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S45),AT(990,2552,2865,260),USE(GL:ADRESE),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Biroja adrese'),AT(4010,2552,1719,260),USE(?String1:9),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Veidlapas aizpilditâjs'),AT(208,2813,1719,260),USE(?String1:40),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S25),AT(2031,2813,1667,260),USE(SYS:PARAKSTS1),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Veidlapas aizpilditâjs'),AT(4010,2813,1719,260),USE(?String1:10),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Tâlrunis'),AT(208,3073,781,260),USE(?String1:39),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S15),AT(990,3073,990,260),USE(SYS:TEL),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Tâlrunis'),AT(4010,3073,1719,260),USE(?String1:11),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('e-pasts'),AT(208,3333,781,260),USE(?String1:12),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('e-pasts'),AT(4010,3333,1719,260),USE(?String1:120),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S35),AT(990,3333,2344,260),USE(SYS:E_MAIL),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,3594,7604,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(156,1406,0,2198),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(156,365,0,677),USE(?Line3),COLOR(COLOR:Black)
       END
PAGE_HEADER1A DETAIL,AT(,,,667)
         LINE,AT(156,52,7656,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('Npk'),AT(208,104,313,208),USE(?String1:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces KN kods'),AT(573,104,990,156),USE(?String1:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Faktûrrçíinâ '),AT(1615,104,1146,156),USE(?String1:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Neto masa, kg'),AT(2813,104,885,156),USE(?String1:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums papild-'),AT(3750,104,1094,156),USE(?String1:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosutîtâj-'),AT(4875,104,938,156),USE(?String1:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izcelsmes'),AT(5865,104,938,156),USE(?String1:25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma veida'),AT(6854,104,938,156),USE(?String1:27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7813,52,0,625),USE(?Line13:9),COLOR(COLOR:Black)
         LINE,AT(6823,52,0,625),USE(?Line13:8),COLOR(COLOR:Black)
         LINE,AT(5833,52,0,625),USE(?Line13:7),COLOR(COLOR:Black)
         LINE,AT(4844,52,0,625),USE(?Line13:6),COLOR(COLOR:Black)
         LINE,AT(3698,52,0,625),USE(?Line13:5),COLOR(COLOR:Black)
         LINE,AT(2760,52,0,625),USE(?Line13:4),COLOR(COLOR:Black)
         LINE,AT(1563,52,0,625),USE(?Line13:3),COLOR(COLOR:Black)
         STRING('A'),AT(552,458,990,156),USE(?String1:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('B'),AT(1594,458,1146,156),USE(?String1:29),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('norâdîtâ summa'),AT(1594,260,1146,156),USE(?String1:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('C'),AT(2792,458,885,156),USE(?String1:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('D'),AT(3729,458,1094,156),USE(?String1:30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('E'),AT(4875,458,938,156),USE(?String1:31),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('F'),AT(5865,458,938,156),USE(?String1:32),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('G'),AT(6854,458,938,156),USE(?String1:33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,625,7656,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING('mçrvienibâ'),AT(3729,260,1094,156),USE(?String1:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts kods'),AT(4875,260,938,156),USE(?String1:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts kods'),AT(5865,260,938,156),USE(?String1:26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kods'),AT(6854,260,938,156),USE(?String1:28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,417,7656,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(521,52,0,625),USE(?Line13:2),COLOR(COLOR:Black)
         LINE,AT(156,52,0,625),USE(?Line13),COLOR(COLOR:Black)
       END
detail1A DETAIL,AT(,,,177)
         LINE,AT(156,-10,0,197),USE(?Line24),COLOR(COLOR:Black)
         STRING(@N3),AT(208,10,,156),USE(NPK),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,-10,0,197),USE(?Line24:2),COLOR(COLOR:Black)
         STRING(@N_8B),AT(729,10,,156),USE(ESKN),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1563,-10,0,197),USE(?Line24:3),COLOR(COLOR:Black)
         STRING(@N_9),AT(1823,10,,156),USE(N:F_Summa),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2760,-10,0,197),USE(?Line24:4),COLOR(COLOR:Black)
         STRING(@N_10),AT(2813,10,,156),USE(N:NetoMasa),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3698,-10,0,197),USE(?Line24:5),COLOR(COLOR:Black)
         STRING(@N_10B),AT(3865,10,,156),USE(N:Daudzums),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4844,-10,0,197),USE(?Line24:6),COLOR(COLOR:Black)
         STRING(@S2),AT(5281,10,,156),USE(NVkods),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5833,-10,0,197),USE(?Line24:7),COLOR(COLOR:Black)
         STRING(@S2),AT(6271,10,,156),USE(IVkods),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(7188,10,,156),USE(DAR_V_kods),RIGHT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7813,-10,0,197),USE(?Line24:9),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,197),USE(?Line24:8),COLOR(COLOR:Black)
       END
FOOTER1A DETAIL,AT(,-10,,104)
         LINE,AT(156,52,7656,0),USE(?Line1:9),COLOR(COLOR:Black)
         LINE,AT(156,0,0,52),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(521,0,0,52),USE(?Line34:11),COLOR(COLOR:Black)
         LINE,AT(1563,0,0,52),USE(?Line34:12),COLOR(COLOR:Black)
         LINE,AT(2760,0,0,52),USE(?Line34:13),COLOR(COLOR:Black)
         LINE,AT(3698,0,0,52),USE(?Line34:14),COLOR(COLOR:Black)
         LINE,AT(4844,0,0,52),USE(?Line34:15),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,52),USE(?Line34:16),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,52),USE(?Line34:17),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,52),USE(?Line34:2),COLOR(COLOR:Black)
       END
PAGE_HEADER2A DETAIL,AT(,,,667)
         LINE,AT(729,52,6667,0),USE(?Line1B:6),COLOR(COLOR:Black)
         STRING('Npk'),AT(760,156,313,208),USE(?String1B:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces KN kods'),AT(1125,156,990,156),USE(?String1B:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Faktûrrçíinâ '),AT(2188,104,1146,156),USE(?String1B:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Neto masa, kg'),AT(3365,156,885,156),USE(?String1B:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums papild-'),AT(4323,104,1094,156),USE(?String1B:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòçmçj-'),AT(5469,104,938,156),USE(?String1B:42),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma veida'),AT(6458,104,938,156),USE(?String1B:27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7396,52,0,625),USE(?Line1B3:8),COLOR(COLOR:Black)
         LINE,AT(6406,52,0,625),USE(?Line1B3:7),COLOR(COLOR:Black)
         LINE,AT(5417,52,0,625),USE(?Line1B3:6),COLOR(COLOR:Black)
         LINE,AT(4271,52,0,625),USE(?Line1B3:5),COLOR(COLOR:Black)
         LINE,AT(3333,52,0,625),USE(?Line1B3:4),COLOR(COLOR:Black)
         LINE,AT(2135,52,0,625),USE(?Line1B3:3),COLOR(COLOR:Black)
         STRING('A'),AT(1146,469,990,156),USE(?String1B:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('B'),AT(2188,469,1146,156),USE(?String1B:29),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('norâdîtâ summa'),AT(2188,260,1146,156),USE(?String1B:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('C'),AT(3385,469,885,156),USE(?String1B:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('D'),AT(4323,469,1094,156),USE(?String1B:30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('E'),AT(5469,469,938,156),USE(?String1B:31),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('F'),AT(6458,469,938,156),USE(?String1B:43),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(729,625,6667,0),USE(?Line1B:8),COLOR(COLOR:Black)
         STRING('mçrvienibâ'),AT(4323,260,1094,156),USE(?String1B:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts kods'),AT(5469,260,938,156),USE(?String1B:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kods'),AT(6458,260,938,156),USE(?String1B:28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(729,417,6667,0),USE(?Line1B:7),COLOR(COLOR:Black)
         LINE,AT(1094,52,0,625),USE(?Line1B3:2),COLOR(COLOR:Black)
         LINE,AT(729,52,0,625),USE(?Line1B3),COLOR(COLOR:Black)
       END
detail2A DETAIL,AT(,,,177)
         LINE,AT(729,-10,0,197),USE(?Line2B4),COLOR(COLOR:Black)
         STRING(@N3),AT(781,10,,156),USE(NPK,,?NPK1B),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1094,-10,0,197),USE(?Line2B4:2),COLOR(COLOR:Black)
         STRING(@N_8B),AT(1365,10,,156),USE(ESKN,,?ESKN1B),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2135,-10,0,197),USE(?Line2B4:3),COLOR(COLOR:Black)
         STRING(@N_9),AT(2458,10,,156),USE(N:F_Summa,,?N:F_SUMMA1B),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3333,-10,0,197),USE(?Line2B4:4),COLOR(COLOR:Black)
         STRING(@N_10),AT(3490,10,,156),USE(N:NetoMasa,,?N:NETOMASA1B),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4271,-10,0,197),USE(?Line2B4:5),COLOR(COLOR:Black)
         STRING(@N_10B),AT(4531,10,,156),USE(N:Daudzums,,?N:DAUDZUMS1B),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5417,-10,0,197),USE(?Line2B4:6),COLOR(COLOR:Black)
         STRING(@S2),AT(5854,10,,156),USE(NVkods,,?NVKODS1B),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6406,-10,0,197),USE(?Line2B4:7),COLOR(COLOR:Black)
         STRING(@N2B),AT(6844,10,,156),USE(Dar_V_kods,,?DVkods:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7396,-10,0,197),USE(?Line24B:8),COLOR(COLOR:Black)
       END
FOOTER2A DETAIL,AT(,-10,,104)
         LINE,AT(729,52,6667,0),USE(?Line1B:9),COLOR(COLOR:Black)
         LINE,AT(729,0,0,52),USE(?Line3B4),COLOR(COLOR:Black)
         LINE,AT(1094,0,0,52),USE(?Line3B4:8),COLOR(COLOR:Black)
         LINE,AT(2135,0,0,52),USE(?Line3B4:7),COLOR(COLOR:Black)
         LINE,AT(3333,0,0,52),USE(?Line3B4:6),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,52),USE(?Line3B4:5),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,52),USE(?Line3B4:4),COLOR(COLOR:Black)
         LINE,AT(6406,0,0,52),USE(?Line3B4:3),COLOR(COLOR:Black)
         LINE,AT(7396,0,0,52),USE(?Line3B4:2),COLOR(COLOR:Black)
       END
PAGE_HEADER1B DETAIL,AT(,,,667)
         LINE,AT(52,52,7865,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('Npk'),AT(94,146,260,208),USE(?String1:70),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces'),AT(438,104,521,156),USE(?String1:42),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Faktûrrçíinâ '),AT(1031,104,885,156),USE(?String1:45),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Neto masa,'),AT(1958,104,625,156),USE(?String1:50),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudz.papild-'),AT(2635,104,833,156),USE(?String1:51),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosutîtâj-'),AT(3521,104,677,156),USE(?String1:54),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izcelsmes'),AT(4250,104,677,156),USE(?String101:54),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma'),AT(4979,104,625,156),USE(?String1:57),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Transporta'),AT(5656,104,625,156),USE(?String1:60),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Piegâdes nosa-'),AT(6344,104,885,156),USE(?String1:63),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Statistiskâ'),AT(7271,104,625,156),USE(?String1:66),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4948,52,0,625),USE(?Line13:20),COLOR(COLOR:Black)
         LINE,AT(7240,52,0,625),USE(?Line13:17),COLOR(COLOR:Black)
         LINE,AT(6302,52,0,625),USE(?Line13:16),COLOR(COLOR:Black)
         STRING('KN kods'),AT(438,260,521,156),USE(?String1:43),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7917,52,0,625),USE(?Line13:18),COLOR(COLOR:Black)
         LINE,AT(5625,52,0,625),USE(?Line13:15),COLOR(COLOR:Black)
         LINE,AT(4219,52,0,625),USE(?Line13:14),COLOR(COLOR:Black)
         LINE,AT(3490,52,0,625),USE(?Line13:13),COLOR(COLOR:Black)
         LINE,AT(2604,52,0,625),USE(?Line13:12),COLOR(COLOR:Black)
         LINE,AT(1927,52,0,625),USE(?Line13:11),COLOR(COLOR:Black)
         LINE,AT(1010,52,0,625),USE(?Line13:10),COLOR(COLOR:Black)
         STRING('A'),AT(396,458,521,156),USE(?String1:44),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('B'),AT(1063,458,833,156),USE(?String1:47),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nor. summa'),AT(1063,260,833,156),USE(?String1:46),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kg'),AT(1958,260,625,156),USE(?String1:48),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('C'),AT(1958,458,625,156),USE(?String1:49),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('D'),AT(2635,458,833,156),USE(?String1:53),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('E'),AT(3521,458,677,156),USE(?String1:56),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('F'),AT(4250,458,677,156),USE(?String1:59),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('G'),AT(4979,458,625,156),USE(?String1:62),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('H'),AT(5656,458,625,156),USE(?String1:65),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('I'),AT(6333,458,885,156),USE(?String1:68),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('J'),AT(7271,458,625,156),USE(?String1:71),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,625,7865,0),USE(?Line1:13),COLOR(COLOR:Black)
         STRING('mçrvienibâ'),AT(2635,260,833,156),USE(?String1:52),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts kods'),AT(3521,260,677,156),USE(?String1:55),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts kods'),AT(4250,260,677,156),USE(?String1:72),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('veida kods'),AT(4979,260,625,156),USE(?String1:58),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('veida kods'),AT(5667,260,625,156),USE(?String1:61),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('cîjumu kods'),AT(6344,260,885,156),USE(?String1:64),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(7271,260,625,156),USE(?String1:67),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,417,7865,0),USE(?Line1:12),COLOR(COLOR:Black)
         LINE,AT(365,52,0,625),USE(?Line13:19),COLOR(COLOR:Black)
         LINE,AT(52,52,0,625),USE(?Line131),COLOR(COLOR:Black)
       END
detail1B DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,197),USE(?Line241),COLOR(COLOR:Black)
         STRING(@N3),AT(104,10,208,156),USE(NPK,,?NPK:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,-10,0,197),USE(?Line24:18),COLOR(COLOR:Black)
         STRING(@N_8B),AT(406,10,573,156),USE(ESKN,,?ESKN:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1010,0,0,197),USE(?Line24:10),COLOR(COLOR:Black)
         STRING(@N_9),AT(1115,10,,156),USE(N:F_Summa,,?N:F_Summa:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1927,-10,0,197),USE(?Line24:11),COLOR(COLOR:Black)
         STRING(@N_7),AT(1979,0,573,156),USE(N:NetoMasa,,?N:NetoMasa:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2604,-10,0,197),USE(?Line24:12),COLOR(COLOR:Black)
         STRING(@N_10B),AT(2646,10,,156),USE(N:Daudzums,,?N:Daudzums:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3490,-10,0,197),USE(?Line24:13),COLOR(COLOR:Black)
         STRING(@S2),AT(3792,10,,156),USE(NVkods,,?NVkods:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4219,-10,0,197),USE(?Line24:14),COLOR(COLOR:Black)
         STRING(@S2),AT(4521,10,,156),USE(IVkods,,?IVkods:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2b),AT(5229,10,,156),USE(Dar_V_kods,,?DVkods:3),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7240,-10,0,197),USE(?Line24:17),COLOR(COLOR:Black)
         STRING(@n_7),AT(7302,10,,156),USE(StatVertiba),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6302,-10,0,197),USE(?Line24:16),COLOR(COLOR:Black)
         STRING(@S3),AT(6677,10,,156),USE(PIEG_N_kods),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7917,-10,0,197),USE(?Line24:19),COLOR(COLOR:Black)
         LINE,AT(5625,-10,0,197),USE(?Line24:15),COLOR(COLOR:Black)
         STRING(@n1),AT(5917,10,,156),USE(TR_V_kods),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4948,-10,0,197),USE(?Line24:21),COLOR(COLOR:Black)
       END
FOOTER1B DETAIL,AT(,-10,,104)
         LINE,AT(52,52,7865,0),USE(?Line1:14),COLOR(COLOR:Black)
         LINE,AT(5625,0,0,52),USE(?Line34:20),COLOR(COLOR:Black)
         LINE,AT(52,0,0,52),USE(?Line344),COLOR(COLOR:Black)
         LINE,AT(365,0,0,52),USE(?Line34:10),COLOR(COLOR:Black)
         LINE,AT(1010,0,0,52),USE(?Line34:3),COLOR(COLOR:Black)
         LINE,AT(1927,0,0,52),USE(?Line34:4),COLOR(COLOR:Black)
         LINE,AT(2604,0,0,52),USE(?Line34:5),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,52),USE(?Line34:6),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,52),USE(?Line34:169),COLOR(COLOR:Black)
         LINE,AT(4948,0,0,52),USE(?Line34:916),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,52),USE(?Line34:19),COLOR(COLOR:Black)
         LINE,AT(7240,0,0,52),USE(?Line34:9),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,52),USE(?Line34:18),COLOR(COLOR:Black)
       END
PAGE_HEADER2B DETAIL,AT(,,,667)
         LINE,AT(156,52,7656,0),USE(?Line1:699),COLOR(COLOR:Black)
         STRING('Npk'),AT(208,104,313,208),USE(?String1:149),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces'),AT(573,104,573,156),USE(?String1:429),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Faktûrrçíinâ '),AT(1198,104,990,156),USE(?String1:459),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Neto masa,'),AT(2240,104,677,156),USE(?String1:501),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums papild-'),AT(2969,104,1042,156),USE(?String1:519),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Sanemej-'),AT(4063,104,677,156),USE(?String1:69),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma'),AT(4792,104,677,156),USE(?String1:576),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Transporta'),AT(5521,104,677,156),USE(?String1:605),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Piegâdes nosa-'),AT(6240,104,885,156),USE(?String1:73),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Statistiskâ'),AT(7188,104,625,156),USE(?String1:75),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7135,52,0,625),USE(?Line13:171),COLOR(COLOR:Black)
         LINE,AT(6198,52,0,625),USE(?Line13:161),COLOR(COLOR:Black)
         STRING('KN kods'),AT(573,260,573,156),USE(?String1:431),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7813,52,0,625),USE(?Line13:909),COLOR(COLOR:Black)
         LINE,AT(5469,52,0,625),USE(?Line13:125),COLOR(COLOR:Black)
         LINE,AT(4740,52,0,625),USE(?Line13:124),COLOR(COLOR:Black)
         LINE,AT(4010,52,0,625),USE(?Line13:123),COLOR(COLOR:Black)
         LINE,AT(2917,52,0,625),USE(?Line13:127),COLOR(COLOR:Black)
         LINE,AT(2188,52,0,625),USE(?Line13:111),COLOR(COLOR:Black)
         LINE,AT(1146,52,0,625),USE(?Line13:101),COLOR(COLOR:Black)
         STRING('A'),AT(573,469,573,156),USE(?String1:441),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('B'),AT(1198,469,990,156),USE(?String1:471),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('norâdîtâ summa'),AT(1198,260,990,156),USE(?String1:461),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kg'),AT(2240,260,677,156),USE(?String1:748),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('C'),AT(2240,469,677,156),USE(?String1:749),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('D'),AT(2969,469,1042,156),USE(?String1:753),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('E'),AT(4063,469,677,156),USE(?String1:756),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('F'),AT(4792,469,677,156),USE(?String1:759),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('G'),AT(5521,469,677,156),USE(?String1:762),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('H'),AT(6250,469,885,156),USE(?String1:675),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('I'),AT(7188,469,625,156),USE(?String1:678),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,625,7656,0),USE(?Line1:888),COLOR(COLOR:Black)
         STRING('mçrvienibâ'),AT(2969,260,1042,156),USE(?String1:555),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts kods'),AT(4063,260,677,156),USE(?String1:556),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('veida kods'),AT(4792,260,677,156),USE(?String1:586),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('veida kods'),AT(5521,260,677,156),USE(?String1:616),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('cîjumu kods'),AT(6240,260,885,156),USE(?String1:74),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(7177,260,625,156),USE(?String1:76),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,417,7656,0),USE(?Line1:777),COLOR(COLOR:Black)
         LINE,AT(521,52,0,625),USE(?Line13:222),COLOR(COLOR:Black)
         LINE,AT(156,52,0,625),USE(?Line136),COLOR(COLOR:Black)
       END
detail2B DETAIL,AT(,,,177)
         LINE,AT(156,-10,0,197),USE(?Line240),COLOR(COLOR:Black)
         STRING(@N3),AT(208,10,,156),USE(NPK,,?NPK:6),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,-10,0,197),USE(?Line24:20),COLOR(COLOR:Black)
         STRING(@N_8B),AT(552,0,573,156),USE(ESKN,,?ESKN:3),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1146,-10,0,197),USE(?Line24:104),COLOR(COLOR:Black)
         STRING(@N_9),AT(1333,10,,156),USE(N:F_Summa,,?N:F_Summa:3),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2188,-10,0,197),USE(?Line264:11),COLOR(COLOR:Black)
         STRING(@N_10),AT(2240,10,625,156),USE(N:NetoMasa,,?N:NetoMasa:9),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2917,-10,0,197),USE(?Line214:12),COLOR(COLOR:Black)
         STRING(@N_10B),AT(3094,10,,156),USE(N:Daudzums,,?N:Daudzums:3),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4010,-10,0,197),USE(?Line234:13),COLOR(COLOR:Black)
         STRING(@S2),AT(4313,10,,156),USE(NVkods,,?NVkods:9),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4740,-10,0,197),USE(?Line724:14),COLOR(COLOR:Black)
         STRING(@n2b),AT(5042,10,,156),USE(Dar_V_kods,,?DVkods:9),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7135,-10,0,197),USE(?Line724:17),COLOR(COLOR:Black)
         STRING(@n_7),AT(7208,10,,156),USE(StatVertiba,,?StatVertiba:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6198,-10,0,197),USE(?Line274:16),COLOR(COLOR:Black)
         STRING(@S3),AT(6573,10,,156),USE(PIEG_N_kods,,?PIEG_N_kods:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7813,-10,0,197),USE(?Line424:9),COLOR(COLOR:Black)
         LINE,AT(5469,-10,0,197),USE(?Line424:15),COLOR(COLOR:Black)
         STRING(@n1),AT(5781,10,,156),USE(TR_V_kods,,?TR_V_kods:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
FOOTER2B DETAIL,AT(,-10,,104)
         LINE,AT(156,52,7656,0),USE(?Line1:998),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,52),USE(?Line534:17),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,52),USE(?Line34:8),COLOR(COLOR:Black)
         LINE,AT(156,0,0,52),USE(?Line534),COLOR(COLOR:Black)
         LINE,AT(521,0,0,52),USE(?Line534:11),COLOR(COLOR:Black)
         LINE,AT(1146,0,0,52),USE(?Line534:3),COLOR(COLOR:Black)
         LINE,AT(2188,0,0,52),USE(?Line534:4),COLOR(COLOR:Black)
         LINE,AT(2917,0,0,52),USE(?Line534:5),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,52),USE(?Line534:6),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,52),USE(?Line34:7),COLOR(COLOR:Black)
         LINE,AT(5469,0,0,52),USE(?Line534:177),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,52),USE(?Line534:2),COLOR(COLOR:Black)
       END
RPT_FOOTER DETAIL,AT(,-10,,656)
         STRING('Aizpildîðanas datums :'),AT(260,208,1302,208),USE(?String1:34),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(1563,208),USE(dat),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Veidlapas aizpildîtâjs :'),AT(2344,208,1302,208),USE(?String1:35),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('_{24}'),AT(5323,208,1302,208),USE(?String1:41),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S25),AT(3646,208,1615,156),USE(SYS:AMATS1),RIGHT(2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S25),AT(5156,396,1667,156),USE(SYS:PARAKSTS1,,?SYS:PARAKSTS1:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
       FOOTER,AT(200,11000,8000,0)
         LINE,AT(156,0,7656,0),USE(?Line1:10),COLOR(COLOR:Black)
       END
     END

ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(EIROKODI,1)
  JOB_NR=1 !1.BÂZE
  CHECKOPEN(SYSTEM,1)
  JOB_NR=0
  DAT = TODAY()
  LAI = CLOCK()
  CN='N1100'
  CP='N01'
  PAR_TIPS='C'  !CITI-ES
  PAR_NR=999999999 !VISI
  EXECUTE OPC
     FORMA='Ievedums - Intrastat - 1A'
     FORMA='Ievedums - Intrastat - 1B'
     FORMA='Izvedums - Intrastat - 2A'
     FORMA='Izvedums - Intrastat - 2B'
  .
  EXECUTE OPC
     D_K='D'
     D_K='D'
     D_K='K'
     D_K='K'
  .
  EXECUTE OPC
     ND_K='K'
     ND_K='K'
     ND_K='D'
     ND_K='D'
  .
  MENESIS=MENVAR(B_DAT,2,2)
  LOOP I#= 1 TO NOL_SK
    IF NOL_NR25[I#]=TRUE
       NOL_TEXT = CLIP(NOL_TEXT)&CLIP(I#)&','
    .
  .
  NOL_TEXT[LEN(CLIP(NOL_TEXT))]=' '
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOM_K::Used = 0        !DÇÏ GETNOM_K
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1          
  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(NOL:RECORD)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLENOL',CYCLENOL)
  FilesOpened = True
  OPEN(ProgressWindow)
  ProgressWindow{Prop:Text} = 'IntraStat'
  ?Progress:UserString{Prop:Text}=''
  DISPLAY
  LOOP I#=1 TO NOL_SK
     IF NOL_NR25[I#]=TRUE
        CLOSE(PAVAD)
        CLOSE(NOLIK)
        PAVADNAME='PAVAD'&FORMAT(I#,@N02)
        NOLIKNAME='NOLIK'&FORMAT(I#,@N02)
        CHECKOPEN(NOLIK,1)
        CHECKOPEN(PAVAD,1)
        CLEAR(nol:RECORD)
        NOL:DATUMS = s_dat
        SET(nol:DAT_KEY,nol:DAT_KEY)
        IF ERRORCODE()
          StandardWarning(Warn:ViewOpenError)
        END
     ELSE
        CYCLE
     .
     LOOP
        NEXT(NOLIK)
        IF ERROR() OR NOL:DATUMS>B_DAT THEN BREAK.
        NPK#+=1
        ?Progress:UserString{Prop:Text}='Noliktava:'&clip(I#)&' '&NPK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLENOL(CN) AND ~CYCLEPAR_K(CP) AND ~(NOL:U_NR=1) |
        AND ((NOL:D_K=D_K AND NOL:DAUDZUMS>0) OR (NOL:D_K=ND_K AND NOL:DAUDZUMS<0))
           P#=GETPAVADZ(NOL:U_NR)                    !POZICIONÇJAM P/Z
           N:KEY[1:8]  =GETNOM_K(NOL:NOMENKLAT,0,21) !ES KN KODS 7-8z VAI TUKÐS
           IF F:VALODA AND ~N:KEY[1] THEN CYCLE.     !IZLAIST AR 0-ES ES KNK
           CLEAR(EIR:RECORD)
           EIR:KODS=N:KEY[1:8]
           GET(EIROKODI,EIR:KEYKODS)
           IF ERROR() THEN KLUDA(0,'Failâ eirokodi.tps nav atrodams kods: '&N:KEY[1:8]&' '&NOL:NOMENKLAT).
           N:KEY[9:10] =GETPAR_K(NOL:PAR_NR,0,19)    !PAR:V_KODS  ?
           IF OPC=3 OR OPC=4                         !Izvedums 2A,2B'
              N:KEY[11:12]=''
           ELSE
              IF NOL:IZC_V_KODS                      !IZCELSMES V_KODS
                 N:KEY[11:12]=NOL:IZC_V_KODS
              ELSE
                 N:KEY[11:12]=N:KEY[9:10]
              .
           .
           N:KEY[13:14]=FORMAT(PAV:DAR_V_KODS,@N2)   !DARÎJUMA VEIDA KODS
           IF OPC=2 OR OPC=4                         !Ievedums 1B Izvedums 2B'
              N:KEY[15]=PAV:TR_V_KODS                !TRANSPORTA VEIDA KODS
              N:KEY[16:18]=PAV:PIEG_N_KODS           !PIEGÂDES NOSACÎJUMU KODS
           ELSE
              N:KEY[15]=''
              N:KEY[16:18]=''
           .
           GET(N_TABLE,N:KEY)
           IF ERROR()
              N:F_SUMMA  =ABS(ROUND(calcsum(15,2),1))        ! Ls BEZ PVN-A
              N:NETOMASA =ROUND(GETNOM_K(NOL:NOMENKLAT,0,22)*ABS(NOL:DAUDZUMS),1)
              N:DAUDZUMS =ROUND(ABS(NOL:DAUDZUMS)*GETNOM_K(NOL:NOMENKLAT,0,24),1)
!              N:MUITA    =ROUND(NOL:MUITA,1)
!              N:AKCIZE   =ROUND(NOL:AKCIZE,1)
              N:CITAS    =ROUND(NOL:CITAS,1)
              ADD(N_TABLE)
              SORT(N_TABLE,N:KEY)
           ELSE
              N:F_SUMMA  +=ABS(ROUND(calcsum(15,2),1))        ! Ls BEZ PVN-A
              N:DAUDZUMS +=ROUND(ABS(NOL:DAUDZUMS)*GETNOM_K(NOL:NOMENKLAT,0,24),1)
              N:NETOMASA +=ROUND(GETNOM_K(NOL:NOMENKLAT,0,22)*ABS(NOL:DAUDZUMS),1)
!              N:MUITA    =ROUND(NOL:MUITA,1)
!              N:AKCIZE   =ROUND(NOL:AKCIZE,1)
              N:CITAS    +=ROUND(NOL:CITAS,1)
              PUT(N_TABLE)
           .
        .
     .
  .
  IF F:DBF='W'
      OPEN(report)
      report{Prop:Preview} = PrintPreviewImage
      RINDUSK=RECORDS(N_TABLE)
      PRINT(RPT:RPT_HEADER)
      EXECUTE OPC
         PRINT(RPT:PAGE_HEADER1A)
         PRINT(RPT:PAGE_HEADER1B)
         PRINT(RPT:PAGE_HEADER2A)
         PRINT(RPT:PAGE_HEADER2B)
      .
  ELSE
      IF ~OPENANSI('INTRASTA.TXT')
         DO PROCEDURERETURN
      .
      OUTA:LINE=''
      ADD(OUTFILEANSI)
      OUTA:LINE=CLIENT&CHR(9)&'NOLIKTAVAS: '&NOL_TEXT
      ADD(OUTFILEANSI)
      OUTA:LINE='INTRASTAT '&FORMA&' NO '&format(S_DAT,@d6)&' LÎDZ '&format(B_DAT,@d6)
      ADD(OUTFILEANSI)
      OUTA:LINE='-{230}'
      ADD(OUTFILEANSI)
!          OUTA:LINE='Nr'&CHR(9)&'Preces piegâdâtâjs'&CHR(9)&SECIBA&CHR(9)&CHR(9)&'Kataloga Numurs  '&CHR(9)&'Preces Nosaukums {30}'&CHR(9)&'Daudzums    '&CHR(9)&'Bilances    '&CHR(9)&'PVN, Ls    '&CHR(9)&'Vçrtîba    '&CHR(9)&CHR(9)&'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&CHR(9)&CHR(9)&CHR(9)&'Kopâ, Ls'
!          ADD(OUTFILEANSI)
!          OUTA:LINE=CHR(9)&'T: '&PAR_TIPS&' G: '&PAR_GRUPA&CHR(9)&'Datums    '&CHR(9)&'Nomenklatûra {9}'&CHR(9)&' {78}'&CHR(9)&CHR(9)&CHR(9)&'vçrtîba,  Ls'&CHR(9)&' {11}'&CHR(9)&'ar PVN,val.'&CHR(9)&CHR(9)&'(P/Z,val.)'&CHR(9)&'Muita     '&CHR(9)&'Akcîze    '&CHR(9)&'Citas     '
!          ADD(OUTFILEANSI)
!          OUTA:LINE='-{230}'
!          ADD(OUTFILEANSI)
  .
  LOOP I#=1 TO RECORDS(N_TABLE)
     GET(N_TABLE,I#)
     NPK+=1
     ESKN        =N:KEY[1:8]
     NVKODS      =N:KEY[9:10]
     IVKODS      =N:KEY[11:12]
     DAR_V_KODS  =N:KEY[13:14]
     TR_V_KODS   =N:KEY[15]
     PIEG_N_KODS =N:KEY[16:18]
     StatVertiba =N:F_SUMMA+N:CITAS
     IF F:DBF='W'
        EXECUTE OPC
           PRINT(RPT:DETAIL1A)
           PRINT(RPT:DETAIL1B)
           PRINT(RPT:DETAIL2A)
           PRINT(RPT:DETAIL2B)
        .
     ELSE
        OUTA:LINE=FORMAT(NPK,@N_4)&CHR(9)&FORMAT(ESKN,@N_8)&CHR(9)&FORMAT(N:F_SUMMA,@N_9)&CHR(9)&FORMAT(N:NETOMASA,@N_10)&CHR(9)&FORMAT(NVKODS,@S2)&CHR(9)&FORMAT(IVKODS,@S2)&CHR(9)&FORMAT(DAR_V_KODS,@S2)
        ADD(OUTFILEANSI)
     END
  END
  IF F:DBF='W'
      EXECUTE OPC
         PRINT(RPT:FOOTER1A)
         PRINT(RPT:FOOTER1B)
         PRINT(RPT:FOOTER2A)
         PRINT(RPT:FOOTER2B)
      .
      PRINT(RPT:RPT_FOOTER)
      ENDPAGE(report)
  ELSE
      OUTA:LINE='-{230}'
      ADD(OUTFILEANSI)
  END
  CLOSE(ProgressWindow)
!  IF LocalResponse = RequestCompleted
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
!  END
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
  IF FilesOpened
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    CLOSE(PAVAD)
    CLOSE(NOLIK)
  END
  POPBIND
  FREE(N_TABLE)
  RETURN
B_PVN_PIE_MKN29      PROCEDURE                    ! Declare Procedure
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

SAK_MEN              STRING(2)
BEI_MEN              STRING(2)
BEI_DAT              STRING(2)
PAR_NOS_P            STRING(35)
GGTEX                STRING(60)
GG_DOK_SE            STRING(7)
GG_DOK_NR            STRING(14)
GG_DOKDAT            LIKE(GG:DOKDAT)
PERS_KODS            STRING(22)
DOK_SUMMA            DECIMAL(12,2)
DOK_SUMMAV           DECIMAL(12,2)
DOK_VAL              STRING(3)
PVN_SUMMA            DECIMAL(12,2)
DOK_SUMMA_P          DECIMAL(12,2)
PVN_SUMMA_P          DECIMAL(12,2)
PVN_SUMMA_K          DECIMAL(12,2)
DOK_SUMMA_K          DECIMAL(12,2)
PVN_SUMMA_K2         DECIMAL(12,2)
DOK_SUMMA_K2         DECIMAL(12,2)
DATUMS               DATE
RMENESIEM            STRING(11)
MENESS               STRING(20)
NPK                  ULONG
CG                   STRING(10)
StringLimitSumma     string(30)

NOT0                 STRING(10)
NOT1                 STRING(45)
NOT2                 STRING(45)
NOT3                 STRING(45)

R_TABLE      QUEUE,PRE(R)
U_NR            ULONG
NOS_P           STRING(15)
PAR_TIPS        STRING(1)
DATUMS          LONG
PAR_NR          ULONG
PVNS            DECIMAL(12,2),DIM(7,2) !18/5/18I/5I/12/21/10  ES,Ls
VAL             STRING(3)
PVN_TIPS        STRING(1)
             .
PVNS                DECIMAL(12,2)
DOK_DAT             LONG
ATTDOK              STRING(30)
TEX:DUF             STRING(100)
KOPA_PVN            DECIMAL(12,2)
SUMMA_KOPA          DECIMAL(12,2)
DAR_SK              USHORT
PVN_KOPA            DECIMAL(12,2)
XMLFILENAME         CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

E               STRING(1)
EE1             STRING(15)
EE2             STRING(15)

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
!-----------------------------------------------------------------------------
report REPORT,AT(500,600,12000,7198),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(500,200,12000,302)
       END
RPT_Head DETAIL,AT(,10,,1073),USE(?unnamed:2)
         STRING(@s10),AT(9646,271,833,156),USE(NOT0),RIGHT
         STRING(@s45),AT(3427,552,3385,220),USE(client),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârskats par priekðnodokïa summâm, kas iekïautas pievienotâs vçrtîbas nodokïa de' &|
             'klarâcijâ par'),AT(1146,52,7031,208),USE(?String11:2),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('.gada'),AT(3542,260),USE(?String120),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N4),AT(3063,260),USE(GADS),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4063,260),USE(MENESS),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Apliekamâs personas nosaukums'),AT(667,542,2406,219),USE(?String1:6),FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(7563,719,2917,156),USE(NOT3),TRN,RIGHT(6)
         STRING(@s45),AT(7563,417,2917,156),USE(NOT1),TRN,RIGHT(6)
         STRING(@s45),AT(7563,563,2917,156),USE(NOT2),TRN,RIGHT(6)
         STRING('PVN 1 '),AT(9854,52,625,156),USE(?String107:2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Apliekamâs personas reìistrâcijas numurs'),AT(677,781,2719,198),USE(?String51:7),FONT(,10,,,CHARSET:BALTIC)
         STRING(@s13),AT(3427,781,1094,208),USE(gl:vid_nr,,?gl:vid_nr:2),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s6),AT(9979,875),USE(GL:VID_LNR),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
       END
D1_Head DETAIL,AT(,10,,1396),USE(?unnamed:4)
         STRING('I.Par iekðzemç iegâdâtajâm precçm un saòemtajiem pakalpojumiem'),AT(2052,125,5000,208), |
             USE(?String211:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(9135,135,313,313),USE(E,,?E:2),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(9479,250,958,208),USE(EE1,,?EE1:2),TRN,LEFT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('kuru kopçjâ vçrtîba bez PVN ir'),AT(2240,302,1875,208),USE(?String1:2),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(4167,302,2292,208),USE(StringLimitSumma),LEFT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7813,979,0,417),USE(?Line2:30),COLOR(COLOR:Black)
         STRING('Darîjuma partnera nosaukums'),AT(688,729,1979,208),USE(?String3:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera'),AT(2854,563,1146,156),USE(?String1:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN apliekamâs'),AT(2854,719,1146,156),USE(?String1:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pakalpojumu'),AT(4104,729,833,156),USE(?String1:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personas reì. nr.'),AT(2854,875,1146,156),USE(?String1:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN (Ls)'),AT(4104,1031,833,156),USE(?String1:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nosaukums'),AT(5875,1031,1875,156),USE(?String1:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('sçrija'),AT(7948,1031,365,156),USE(?String123:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(8417,1031,990,156),USE(?String134:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(9458,1031,990,156),USE(?String145:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9427,979,0,417),USE(?Line2:34),COLOR(COLOR:Black)
         LINE,AT(8385,979,0,417),USE(?Line2:33),COLOR(COLOR:Black)
         STRING('vçrtîba'),AT(4104,885,833,156),USE(?String1:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5833,979,4635,0),USE(?Line55:3),COLOR(COLOR:Black)
         LINE,AT(104,510,10365,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2771,510,0,885),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4083,510,0,885),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(104,1188,10365,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('1'),AT(156,1240,365,156),USE(?String3:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(573,1240,2146,156),USE(?String3:92),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2865,1240,1094,156),USE(?String3:93),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(4115,1240,781,156),USE(?String3:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(5000,1240,833,156),USE(?String3:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(5885,1240,1875,156),USE(?String3:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(7958,1240,365,156),USE(?String3:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(8438,1240,938,156),USE(?String93:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(9531,1240,938,156),USE(?String134:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Attaisnojuma dokumenta'),AT(5865,719,4583,156),USE(?String1:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(135,719,365,208),USE(?String1:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,510,0,885),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(5833,510,0,885),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(10469,510,0,885),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('PVN (Ls)'),AT(5010,719,760,156),USE(?String1:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4948,510,0,885),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Preèu vai'),AT(4104,573,833,156),USE(?String1:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,510,0,885),USE(?Line2),COLOR(COLOR:Black)
       END
D1_detail DETAIL,AT(,,,208)
         LINE,AT(4948,-10,0,229),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(4083,0,0,229),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(2771,-10,0,229),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,229),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,229),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@s35),AT(573,52,2188,156),USE(PAR_nos_p),LEFT
         LINE,AT(5833,-10,0,229),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(10469,-10,0,229),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(125,0,10365,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@s20),AT(2813,52,1250,156),USE(PERS_KODS),CENTER
         STRING(@n_4),AT(156,52,,156),CNT,USE(NPK),RIGHT
         LINE,AT(104,-10,0,229),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(4156,52,,156),USE(dok_summa),RIGHT
         STRING(@n-_11.2),AT(5104,52,677,156),USE(pvn_summa),RIGHT
         STRING(@s30),AT(5885,52,1875,156),USE(ATTDOK),LEFT
         STRING(@S7),AT(7885,52,469,156),USE(GG_DOK_SE),CENTER
         STRING(@S14),AT(8417,52,980,156),USE(GG_DOK_NR),CENTER
         STRING(@D06.),AT(9635,52,615,156),USE(GG_DOKDAT)
         LINE,AT(8385,-10,0,229),USE(?Line2:35),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,229),USE(?Line2:36),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,94)
         LINE,AT(10469,-10,0,115),USE(?Line72:21),COLOR(COLOR:Black)
         LINE,AT(104,52,10365,0),USE(?Line71:3),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,62),USE(?Line72:20),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,62),USE(?Line72:26),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,62),USE(?Line72:37),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,115),USE(?Line72:19),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,115),USE(?Line72:18),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,115),USE(?Line72:16),COLOR(COLOR:Black)
         LINE,AT(2771,-10,0,115),USE(?Line72:32),COLOR(COLOR:Black)
         LINE,AT(4083,-10,0,115),USE(?Line72:17),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,115),USE(?Line72:15),COLOR(COLOR:Black)
       END
D1_FOOTER DETAIL,AT(,-10,,552),USE(?unnamed:7)
         LINE,AT(104,365,10365,0),USE(?Line1:19),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(5000,208,781,156),USE(pvn_summa_k),RIGHT
         STRING(@n-_13.2),AT(4094,208,,156),USE(dok_summa_k),RIGHT
         STRING('Kopâ : '),AT(625,208,1146,156),USE(?String3:9),LEFT
         LINE,AT(10469,0,0,365),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(521,0,0,365),USE(?Line2:27),COLOR(COLOR:Black)
         STRING('Visi pârçjie darîjumi'),AT(625,0,1146,156),USE(?String3:8),LEFT
         STRING(@n-_12.2),AT(4156,0,,156),USE(dok_summa_p),RIGHT
         STRING(@n-_11.2),AT(5104,0,677,156),USE(pvn_summa_p),RIGHT
         LINE,AT(104,156,10365,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,365),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(4948,0,0,365),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(4083,0,0,365),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(2771,0,0,365),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(104,0,0,365),USE(?Line2:22),COLOR(COLOR:Black)
       END
PAGEBREAK DETAIL,PAGEAFTER(-1),AT(,,,10),USE(?PAGEBREAK)
       END
D2_Head DETAIL,AT(,10,,1396),USE(?unnamed:3)
         STRING(@s1),AT(9135,94,313,313),USE(E,,?E:3),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING('II. Par precçm, kas saòemtas no Eiropas Savienîbas dalîbvalstîm'),AT(2052,135,4948,208), |
             USE(?String2211:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(9479,208,958,208),USE(EE2),TRN,LEFT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7813,979,0,417),USE(?Line22:30),COLOR(COLOR:Black)
         STRING('Darîjuma partnera nosaukums'),AT(552,760,2240,208),USE(?String23:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('piegâdâtâjvalsts valûtâ'),AT(6125,781,2188,156),USE(?String21:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera'),AT(2969,646,1146,156),USE(?String21:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN apliekamâs'),AT(2969,802,1146,156),USE(?String21:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrt., no kuras'),AT(4271,729,885,156),USE(?String21:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personas reì. nr.'),AT(2969,958,1146,156),USE(?String21:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN (Ls)'),AT(4260,1031,833,156),USE(?String21:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(6094,1031,1667,156),USE(?String21:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('val.k.'),AT(7948,1031,365,156),USE(?String2123:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(8438,1031,990,156),USE(?String2134:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(9479,1031,990,156),USE(?String2145:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9427,979,0,417),USE(?Line22:34),COLOR(COLOR:Black)
         LINE,AT(8385,510,0,896),USE(?Line22:7),COLOR(COLOR:Black)
         STRING('aprçí. nodoklis'),AT(4271,885,885,156),USE(?String21:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5990,979,4479,0),USE(?Line255:3),COLOR(COLOR:Black)
         LINE,AT(104,510,10365,0),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(2813,510,0,885),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(4250,510,0,885),USE(?Line22:3),COLOR(COLOR:Black)
         LINE,AT(104,1188,10365,0),USE(?Line21:2),COLOR(COLOR:Black)
         STRING('1'),AT(156,1240,365,156),USE(?String23:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(573,1240,2146,156),USE(?String23:92),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2865,1240,1094,156),USE(?String23:93),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(4365,1250,625,156),USE(?String23:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(5323,1250,573,156),USE(?String23:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(6302,1250,1458,156),USE(?String23:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(7958,1240,365,156),USE(?String23:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(8438,1240,938,156),USE(?String293:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(9531,1240,938,156),USE(?String2134:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòemto preèu vçrtîba'),AT(6115,583,2188,156),USE(?String21:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('saòemtais rçíins'),AT(8490,781,1927,156),USE(?String121:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(146,760,365,208),USE(?String21:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,510,0,885),USE(?Line22:29),COLOR(COLOR:Black)
         LINE,AT(5990,510,0,885),USE(?Line22:6),COLOR(COLOR:Black)
         LINE,AT(10469,510,0,885),USE(?Line22:5),COLOR(COLOR:Black)
         STRING('PVN (Ls)'),AT(5250,792,677,156),USE(?String21:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5167,510,0,885),USE(?Line22:4),COLOR(COLOR:Black)
         STRING('Saòemto preèu'),AT(4271,573,885,156),USE(?String21:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('No darîjuma partnera'),AT(8490,573,1927,156),USE(?String221:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,510,0,885),USE(?Line22),COLOR(COLOR:Black)
       END
D2_detail DETAIL,AT(,,,208),USE(?unnamed)
         LINE,AT(5167,-10,0,229),USE(?Line22:11),COLOR(COLOR:Black)
         LINE,AT(4250,-10,0,229),USE(?Line22:10),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,229),USE(?Line22:8),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,229),USE(?Line22:14),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,229),USE(?Line22:31),COLOR(COLOR:Black)
         STRING(@s35),AT(563,52,2240,156),USE(PAR_nos_p,,?PAR_NOS_P2),LEFT
         LINE,AT(5990,-10,0,229),USE(?Line22:13),COLOR(COLOR:Black)
         LINE,AT(10469,-10,0,229),USE(?Line22:12),COLOR(COLOR:Black)
         LINE,AT(104,0,10365,0),USE(?Line21:3),COLOR(COLOR:Black)
         STRING(@s22),AT(2833,52,1406,156),USE(PERS_KODS,,?PERS_KODS2),CENTER
         STRING(@n_4),AT(156,52,,156),CNT,USE(NPK,,?NPK2),RIGHT
         LINE,AT(104,-10,0,229),USE(?Line22:9),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(4333,52,,156),USE(dok_summa,,?dok_summa:2),RIGHT
         STRING(@n-_11.2),AT(5260,52,677,156),USE(pvn_summa,,?PVN_SUMMA:2),RIGHT
         STRING(@n-_12.2),AT(6469,52,781,156),USE(dok_summav),RIGHT(1)
         STRING(@S3),AT(7875,52,469,156),USE(DOK_VAL),CENTER
         STRING(@S14),AT(8427,52,980,156),USE(GG_DOK_NR,,?GG_DOK_NR:2),CENTER
         STRING(@D06.),AT(9635,52,615,156),USE(GG_DOKDAT,,?GG_DOKDAT:2)
         LINE,AT(8385,-10,0,229),USE(?Line22:35),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,229),USE(?Line22:36),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,94)
         LINE,AT(10469,-10,0,115),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(104,52,10365,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,62),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,62),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,62),USE(?Line2:37),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,115),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(5167,-10,0,115),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,115),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,115),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(4250,-10,0,115),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,115),USE(?Line2:15),COLOR(COLOR:Black)
       END
D2_FOOTER DETAIL,PAGEAFTER(-1),AT(,-10,,760),USE(?unnamed:5)
         LINE,AT(104,208,10365,0),USE(?Line31:19),COLOR(COLOR:Black)
         STRING('RS: '),AT(10010,240,208,135),USE(?String37),RIGHT,FONT(,6,,,CHARSET:ANSI)
         STRING(@S1),AT(10229,240,208,135),USE(RS),CENTER,FONT(,6,,,CHARSET:ANSI)
         STRING(@n-_12.2),AT(5208,42,729,156),USE(pvn_summa_k2),RIGHT
         STRING(@n-_13.2),AT(4271,42,,156),USE(dok_summa_k2),RIGHT
         STRING('Kopâ : '),AT(625,42,1146,156),USE(?String33:9),LEFT
         LINE,AT(10469,0,0,208),USE(?Line32:28),COLOR(COLOR:Black)
         LINE,AT(521,0,0,208),USE(?Line32:27),COLOR(COLOR:Black)
         STRING(@d06.),AT(9385,240),USE(datums,,?datums:2),FONT(,6,,,CHARSET:ANSI)
         STRING('Atbildîgâ persona'),AT(208,448),USE(?sys:amats1:2),RIGHT(1)
         STRING('200___. gada____. _{29}'),AT(5781,448),USE(?sys:amats1),TRN,RIGHT(1)
         LINE,AT(1146,656,2865,0),USE(?Line55),COLOR(COLOR:Black)
         STRING(@s25),AT(4063,448),USE(SYS:PARAKSTS1),LEFT
         LINE,AT(104,10,10365,0),USE(?Line31:18),COLOR(COLOR:Black)
         LINE,AT(5990,10,0,208),USE(?Line32:25),COLOR(COLOR:Black)
         LINE,AT(5167,0,0,208),USE(?Line32:7),COLOR(COLOR:Black)
         LINE,AT(4250,0,0,208),USE(?Line32:24),COLOR(COLOR:Black)
         LINE,AT(2813,0,0,208),USE(?Line32:23),COLOR(COLOR:Black)
         LINE,AT(104,0,0,208),USE(?Line32:22),COLOR(COLOR:Black)
       END
       FOOTER,AT(500,7800,12000,260),USE(?unnamed:6)
         LINE,AT(104,0,10365,0),USE(?Line48:3),COLOR(COLOR:Black)
         STRING(@PLapa<<<#/______P),AT(9500,63),PAGENO,USE(?PageCount),RIGHT
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


 OMIT('MARIS')
detail3 DETAIL,PAGEAFTER(-1),AT(,,,1354)
         LINE,AT(104,260,10365,0),USE(?Line1:19),COLOR(00H)
         STRING('RS: '),AT(417,1094,271,208) ,USE(?String37),LEFT
         STRING(@S1),AT(729,1094,208,208) ,USE(RS),CENTER
         STRING(@n-_12.2),AT(5000,104,781,156) ,USE(pvn_summa_k),RIGHT
         STRING(@n-_13.2),AT(4063,104,,156) ,USE(dok_summa_k),RIGHT
         STRING('Kopâ : '),AT(625,104,1146,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String3:9),LEFT
         LINE,AT(10469,0,0,260),USE(?Line2:28),COLOR(00H)
         LINE,AT(521,0,0,260),USE(?Line2:27),COLOR(00H)
         STRING(@d6),AT(8802,521) ,USE(datums)
         STRING('Uzòçmuma vadîtâjs'),AT(260,521),USE(?String55:3)
         STRING('Grâmatvedis'),AT(4583,521),USE(?String55)
         LINE,AT(1458,729,2552,0),USE(?Line55),COLOR(00H)
         LINE,AT(5365,729,2552,0),USE(?Line55:2),COLOR(00H)
         STRING('(paraksts un tâ atðifrçjums)'),AT(1823,781),USE(?String55:2)
         STRING('(paraksts un tâ atðifrçjums)'),AT(5729,781),USE(?String55:4)
         LINE,AT(104,52,10365,0),USE(?Line1:18),COLOR(00H)
         LINE,AT(8385,0,0,260),USE(?Line2:38),COLOR(00H)
         LINE,AT(9427,0,0,260),USE(?Line2:39),COLOR(00H)
         LINE,AT(7813,0,0,260),USE(?Line2:7),COLOR(00H)
         LINE,AT(5833,0,0,260),USE(?Line2:26),COLOR(00H)
         LINE,AT(4948,0,0,260),USE(?Line2:25),COLOR(00H)
         LINE,AT(4010,0,0,260),USE(?Line2:24),COLOR(00H)
         LINE,AT(2813,0,0,260),USE(?Line2:23),COLOR(00H)
         LINE,AT(104,0,0,260),USE(?Line2:22),COLOR(00H)
       END
 MARIS
  CODE                                            ! Begin processed code
!
!R:DOKS[1] 231 Ls/Es 18%
!R:DOKS[2] 231 Ls/Es 5%
!R:DOKS[3] 231,PVN_TIPS=I IMPORTA PAKALPOJUMI 18/21%  ?
!R:DOKS[4] 231,PVN_TIPS=I IMPORTA PAKALPOJUMI  5/10%  ?
!R:DOKS[5] 231 Ls 12%
!R:DOKS[6] 231 Ls/ES 21%
!R:DOKS[7] 231 Ls/ES 10%
!
!R:PVNS[1] PVN Ls 18%
!R:PVNS[2] PVN Ls 5%
!R:PVNS[3] PVN_TIPS=I IMPORTA PAKALPOJUMI 18/21%  ?uldis apgalvo, ka vajag
!R:PVNS[4] PVN_TIPS=I IMPORTA PAKALPOJUMI  5/10%  ?
!R:PVNS[5] PVN Ls 12%
!R:PVNS[6] PVN Ls 21%
!R:PVNS[7] PVN Ls 10%
!
!
  PUSHBIND
  CHECKOPEN(system,1)
  CHECKOPEN(global,1)
  DATUMS=TODAY()
  MENESS=MENVAR(MEN_NR,1,3)
  IF BILANCE
     StringLimitSumma='no '&CLIP(MINMAXSUMMA)&' lîdz '&clip(bilance)&' (neieskaitot)'
  ELSE
     StringLimitSumma='Ls '&CLIP(MINMAXSUMMA)&' un vairâk'
  .

  IF S_DAT >= DATE(1,1,2006) !NOT 42
       NOT0=''
       NOT1=''
       NOT2=''
       NOT3=''
  ELSIF S_DAT >= DATE(7,1,2005) !VID RÎKOJUMS N1414
       NOT0='Pielikums'
       NOT1='ar Valsts ieòçmumu dienesta'
       NOT2='2005.gada 12.jûlija rîkojumu Nr.1414'
       NOT3='apstiprinâtajiem metodiskajiem norâdîjumiem'
  ELSE
       NOT0='Pielikums'
       NOT1='Ministru kabineta'
       NOT2='2004.g.13.janvâra'
       NOT3='noteikumiem Nr 29'
  .
  IF F:XML
     E='E'
     EE1='(PVN_PI.DUF)'
     EE2='(PVN_PII.DUF)'
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GG::Used = 0
    CHECKOPEN(GG,1)
  end
  GG::Used += 1
  IF PAR_K::Used = 0
    CHECKOPEN(PAR_K,1)
  end
  PAR_K::Used += 1
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('kkk',kkk)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND('CYCLEBKK',CYCLEBKK)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)

  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PVN pielikumi'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:DATUMS=S_DAT
      SET(GGK:DAT_key,GGK:DAT_KEY)
      CG = 'K101000'
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
        PRINT(RPT:RPT_HEAD)
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('PVN_PIE.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' {200}PVN 1'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {25}Pârskats par priekðnodokïa summâm, kas iekïautas Pievienotâs Vçrtîbas Nodokïa deklarâcijâ par'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {75}'&GL:DB_GADS&'. gada '&MENESS
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Ar pievienotâs vçrtîbas nodokli apliekamâs personas nosaukums: '&CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Juridiska adrese: '&GL:ADRESE
        ADD(OUTFILEANSI)
        OUTA:LINE='Ar pievienotâs vçrtîbas nodokli apliekamâs personas reìistrâcijas numurs: '&GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE='Tâlrunis: '&SYS:TEL
        ADD(OUTFILEANSI)
      .
      IF F:XML
        XMLFILENAME=USERFOLDER&'\PVN_PI.DUF'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
           XML:LINE='<<?xml version="1.0" encoding="windows-1257" ?>'
           ADD(OUTFILEXML)
!           XML:LINE='<<!DOCTYPE DeclarationFile SYSTEM "DUF.dtd">'
!           ADD(OUTFILEXML)
           XML:LINE='<<DeclarationFile type="pvn_p_dar_2006">'  !09.11.2006
           ADD(OUTFILEXML)
           XML:LINE='<<Declaration>'
           ADD(OUTFILEXML)
        .
      .
    OF Event:Timer

!************************ BÛVÇJAM R_TABLE ********

      LOOP RecordsPerCycle TIMES
         nk#+=1
         ?Progress:UserString{Prop:Text}=NK#
         DISPLAY(?Progress:UserString)
!         STOP('RPC='&RecordsPerCycle)
!--------------------- 57210Ls & 213Ls/ES --------
         IF INSTRING(GGK:PVN_TIPS,' 02NIPA') AND ~(GGK:U_NR=1) AND ~CYCLEGGK(CG) AND ~CYCLEBKK(GGK:BKK,KKK)
            R:U_NR=GGK:U_NR
            GET(R_TABLE,R:U_NR)
            IF ~ERROR()
               CASE GGK:PVN_PROC
               OF 5
                  IF GGK:PVN_TIPS='I'   !PVN_TIPS=I
                     R:PVNS[4,1]+=GGK:SUMMAV
                     R:PVNS[4,2]+=GGK:SUMMA
                  ELSE                  !PVN LS
                     R:PVNS[2,1]+=GGK:SUMMAV
                     R:PVNS[2,2]+=GGK:SUMMA
                  .
               OF 10
                  IF GGK:PVN_TIPS='I'  !IMPORTA PAKALPOJUMI
                     R:PVNS[4,1]+=GGK:SUMMAV
                     R:PVNS[4,2]+=GGK:SUMMA
                  ELSE                 !PVN Ls
                     R:PVNS[7,1]+=GGK:SUMMAV
                     R:PVNS[7,2]+=GGK:SUMMA
                  .
               OF 12
                  R:PVNS[5,1]+=GGK:SUMMAV !VAR BÛT TIKAI Ls&LR
                  R:PVNS[5,2]+=GGK:SUMMA  !VAR BÛT TIKAI Ls&LR
               OF 18
                  IF GGK:PVN_TIPS='I'  !IMPORTA PAKALPOJUMI
                    R:PVNS[3,1]+=GGK:SUMMAV
                    R:PVNS[3,2]+=GGK:SUMMA
                  ELSE
                    R:PVNS[1,1]+=GGK:SUMMAV
                    R:PVNS[1,2]+=GGK:SUMMA
                  .
               OF 21
                  IF GGK:PVN_TIPS='I'  !IMPORTA PAKALPOJUMI
                    R:PVNS[3,1]+=GGK:SUMMAV
                    R:PVNS[3,2]+=GGK:SUMMA
                  ELSE
                    R:PVNS[6,1]+=GGK:SUMMAV
                    R:PVNS[6,2]+=GGK:SUMMA
                  .
               ELSE
                  KLUDA(27,'PVN %='&GGK:PVN_PROC&' '&FORMAT(GGK:DATUMS,@D06.)&' UNR='&GGK:U_NR)
                  DO ProcedureReturn
               .
               PUT(R_TABLE)
            ELSE !U_NR NAV ATRASTS
               IF GGK:PVN_TIPS='I' AND ~(GETPAR_K(GGK:PAR_NR,0,20)='C') !PVN_TIPS=I IMPORTA PAKALPOJUMI
                  KLUDA(0,'NEPAREIZS PARTNERA TIPS IMPORTA PAKALPOJUMIEM...'&FORMAT(GGK:DATUMS,@D06.)&'U_NR='&GGK:U_NR)
               .
               R:NOS_P=GETPAR_K(GGK:PAR_NR,0,1)
               R:PAR_TIPS=GETPAR_K(GGK:PAR_NR,0,20) !LAI ZINÂTU, KA ES
               R:VAL=GGK:VAL
               R:PVN_TIPS=GGK:PVN_TIPS !VAJADZÎGS ATGRIEZTAI PRECEI
               CLEAR(R:PVNS)
               CASE GGK:PVN_PROC
               OF 5
                  IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI
                    R:PVNS[4,1]=GGK:SUMMAV
                    R:PVNS[4,2]=GGK:SUMMA
                  ELSE
                    R:PVNS[2,1]=GGK:SUMMAV
                    R:PVNS[2,2]=GGK:SUMMA
                  .
               OF 10
                  IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI
                    R:PVNS[4,1]=GGK:SUMMAV
                    R:PVNS[4,2]=GGK:SUMMA
                  ELSE
                    R:PVNS[7,1]=GGK:SUMMAV
                    R:PVNS[7,2]=GGK:SUMMA
                  .
               OF 12
                  R:PVNS[5,1]+=GGK:SUMMAV    !VAR BÛT TIKAI Ls&LR
                  R:PVNS[5,2]+=GGK:SUMMA    !VAR BÛT TIKAI Ls&LR

               OF 18
                  IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
                    R:PVNS[3,1]=GGK:SUMMAV
                    R:PVNS[3,2]=GGK:SUMMA
                  ELSE
                    R:PVNS[1,1]=GGK:SUMMAV
                    R:PVNS[1,2]=GGK:SUMMA
                  .
               OF 21
                  IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
                    R:PVNS[3,1]=GGK:SUMMAV
                    R:PVNS[3,2]=GGK:SUMMA
                  ELSE
                    R:PVNS[6,1]=GGK:SUMMAV
                    R:PVNS[6,2]=GGK:SUMMA
                  .
               ELSE
                  KLUDA(27,'PVN %='&GGK:PVN_PROC&' '&FORMAT(GGK:DATUMS,@D06.)&' UNR='&GGK:U_NR)
                  DO ProcedureReturn
               .
               R:DATUMS=GGK:DATUMS         !Ls pârrçíins  ?
               R:PAR_NR=GGK:PAR_NR
               ADD(R_TABLE)
               SORT(R_TABLE,R:U_NR)
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
  IF LocalResponse = RequestCompleted

!************* I.Par iekðzemç iegâdâtajâm precçm un saòemtajiem pakalpojumiem ********

    SORT(R_TABLE,R:NOS_P)
    IF F:DBF='W'   !WMF
       PRINT(RPT:D1_HEAD)
    ELSIF F:DBF='E'
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='          I.Par iekðzemç iegâdâtajâm precçm un saòemtajiem pakalpojumiem'
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera'&CHR(9)&'Preèu vai'&CHR(9)&'PVN, Ls'&|
       CHR(9)&'Attaisnojuma dokumenta'
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&'ar PVN apliekamâs'&CHR(9)&'pakalpojumu'&CHR(9)&CHR(9)&'Nosaukums'&CHR(9)&'Sçrija'&CHR(9)&|
       'Numurs'&CHR(9)&'Datums'
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&'personas reì. Nr'&CHR(9)&'vçrtîba'
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'bez PVN (Ls)'
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
    ELSE !WORD 
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='          I.Par iekðzemç iegâdâtajâm precçm un saòemtajiem pakalpojumiem'
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera ar PVN apliekamâs personas reì. Nr'&|
       CHR(9)&'Preèu vai pakalpojumu vçrtîba bez PVN (Ls)'&CHR(9)&'PVN, Ls'&|
       CHR(9)&'Attaisnojuma dokumenta Nosaukums'&CHR(9)&'Sçrija'&CHR(9)&'Numurs'&CHR(9)&'Datums'
       ADD(OUTFILEANSI)
    .
    IF F:XML_OK#=TRUE
       XML:LINE='<<DeclarationHeader>'
       ADD(OUTFILEXML)
       IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
       XML:LINE='<<Field name="nmr_kods" value="'&GL:REG_NR&'" />'
       ADD(OUTFILEXML)
       TEX:DUF=CLIENT
       DO CONVERT_TEX:DUF
       XML:LINE='<<Field name="isais_nosauk" value="'&CLIP(TEX:DUF)&'" />'
       ADD(OUTFILEXML)
       XML:LINE='<<Field name="taks_no" value="'&FORMAT(S_DAT,@D06.)&'" />'
       ADD(OUTFILEXML)
       IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods lîdz '&FORMAT(B_DAT,@D06.)).
       XML:LINE='<<Field name="taks_lidz" value="'&FORMAT(B_DAT,@D06.)&'" />'
       ADD(OUTFILEXML)
       XML:LINE='<<Field name="izpilditajs" value="'&CLIP(SYS:PARAKSTS2)&'" />'
       ADD(OUTFILEXML)
       XML:LINE='<<Field name="vaditajs" value="'&CLIP(SYS:PARAKSTS1)&'" />'
       ADD(OUTFILEXML)
       GET(R_TABLE,0)
       LOOP I#= 1 TO RECORDS(R_TABLE)
          GET(R_TABLE,I#)
!          IF ~(R:PAR_TIPS='C') OR R:PVNS[3] OR R:PVNS[4] ! +IMPORTA PAKALPOJUMI ES & ~ES
          IF ~(R:PAR_TIPS='C')
             KOPA_PVN += R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[5,2]+R:PVNS[6,2]+R:PVNS[7,2] !18+5+12+21+10%
          .
       .
       XML:LINE='<<Field name="kopa_pvn" value="'&CUT0(KOPA_PVN,2,2,1,1)&'" />'
       ADD(OUTFILEXML)
       XML:LINE='<</DeclarationHeader>'
       ADD(OUTFILEXML)
    .
    GET(R_TABLE,0)
    LOOP I#= 1 TO RECORDS(R_TABLE)
      GET(R_TABLE,I#)
      IF ~(R:PAR_TIPS='C') OR R:PVNS[3,2] OR R:PVNS[4,2] ! +IMPORTA PAKALPOJUMI LATVIJÂ 23.03.2009
!      IF ~(R:PAR_TIPS='C')
        IF R:PVN_TIPS='A'
           PAR_nos_p = '67:'&GETPAR_K(R:PAR_NR,0,2)
        ELSE
           PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
        .
        pers_kods = GETPAR_K(R:PAR_NR,0,8)
        X#=GETGG(R:U_NR)  !POZICIONÇJAM GG
        GG_DOKDAT = GG:DOKDAT
!        PVN_SUMMA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[5,2]+R:PVNS[6,2]+R:PVNS[7,2]     !18+5+12+21+10%   Ls
!        DOK_SUMMA = R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[5,2]/0.12+R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1
        PVN_SUMMA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[3,2]+R:PVNS[4,2]+R:PVNS[5,2]+R:PVNS[6,2]+R:PVNS[7,2] !18+5+12+21+10%   Ls
        DOK_SUMMA = R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[3,2]/0.21+R:PVNS[4,2]/0.1+R:PVNS[5,2]/0.12+R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1
        PVN_SUMMA_K+= PVN_SUMMA
        GG_DOK_SE=''
        GG_DOK_NR=GG:DOK_SENR
        KLUDA#=FALSE
        CASE GG:ATT_DOK
        OF '1'
           ATTDOK='' !CITS
        OF '2'
           GG_DOK_SE=GETDOK_SENR(1,GG:DOK_SENR,,'2')
           GG_DOK_NR=GETDOK_SENR(2,GG:DOK_SENR,,'2')
           ATTDOK='preèu pavadzîme-rçíins'
        OF '3'
           IF BAND(gg:tips,00000010b)
              ATTDOK='maksâjuma uzdevums'
           ELSIF BAND(gg:tips,00000001b)
              ATTDOK='kases orderis'
           ELSE
              ATTDOK='maksâjuma dokuments'
           .
        OF '4'
           ATTDOK='EKA èeks'
        OF '5'
           ATTDOK='Lîgums'
        OF '6'
           ATTDOK='Faktûrrçíins'
        OF '7'
           ATTDOK='Kredîtrçíins'
        OF '8'
           ATTDOK='Akts'
        OF '9'
           ATTDOK='Protokols'
        OF '0'
           ATTDOK='Muitas deklarâcija'
        ELSE
           KLUDA#=TRUE
        .
        DOK_SUMMA_K+=DOK_SUMMA
        IF (BILANCE AND ~INRANGE(DOK_SUMMA,MINMAXSUMMA,BILANCE-0.01)) OR|
           (~BILANCE AND ABS(DOK_SUMMA) < MINMAXSUMMA)
           DOK_SUMMA_P+=DOK_SUMMA
           PVN_SUMMA_P+=PVN_SUMMA
        ELSE
           NPK+=1
           IF KLUDA#=TRUE
              KLUDA(27,'attaisnojuma dok. kods: '&CLIP(GG:NOKA)&' '&FORMAT(GG:DATUMS,@D06.)&' UNR='&GG:U_NR)
           .
           IF F:DBF = 'W'
              PRINT(RPT:D1_DETAIL)
           ELSE
              OUTA:LINE=NPK&CHR(9)&PAR_NOS_P&CHR(9)&PERS_KODS&CHR(9)&LEFT(FORMAT(DOK_SUMMA,@N-_12.2))&CHR(9)&|
              LEFT(FORMAT(PVN_SUMMA,@N-_12.2))&CHR(9)&ATTDOK&CHR(9)&GG_DOK_SE&CHR(9)&GG_DOK_NR&CHR(9)&FORMAT(GG_DOKDAT,@D06.)
              ADD(OUTFILEANSI)
           .
           IF F:XML_OK#=TRUE
              XML:LINE='<<Row>'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="rindas_nr" value="'&NPK&'" />'
              ADD(OUTFILEXML)
              IF ~PERS_KODS[1:2] THEN KLUDA(87,CLIP(PAR_NOS_P)&' Valsts kods').
              XML:LINE='<<Field name="valsts_dp" value="'&PERS_KODS[1:2]&'" />'
              ADD(OUTFILEXML)
              IF ~CLIP(PERS_KODS[3:13]) THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods'). !dati:max=11z
              XML:LINE='<<Field name="nmr_kods_dp" value="'&CLIP(PERS_KODS[3:13])&'" />'
              ADD(OUTFILEXML)
              TEX:DUF=PAR_NOS_P
              DO CONVERT_TEX:DUF
              XML:LINE='<<Field name="isais_nosauk_dp" value="'&CLIP(TEX:DUF)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="summa" value="'&CUT0(DOK_SUMMA,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="summa_pvn" value="'&CUT0(PVN_SUMMA,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="attaisn_dok" value="'&GG:att_dok&'" />'
              ADD(OUTFILEXML)
              IF GG_DOK_SE
                 XML:LINE='<<Field name="attaisnd_ser" value="'&clip(GG_DOK_SE)&'" />'
                 ADD(OUTFILEXML)
              .
              IF ~GG_DOK_NR THEN KLUDA(87,'dokumenta Nr '&FORMAT(GG:DATUMS,@D06.)&' U_Nr: '&GG:U_NR).
              XML:LINE='<<Field name="attaisnd_nr" value="'&clip(GG_DOK_NR)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="datums_attaisnd" value="'&FORMAT(GG_DOKDAT,@D06.)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<</Row>'
              ADD(OUTFILEXML)
           .
        .
      .
    .
    NPK+=1
    IF F:DBF='W'   !WMF
       PRINT(RPT:DETAIL1)
       PRINT(RPT:D1_FOOTER)
    ELSE
       OUTA:LINE=CHR(9)&'Visi pârçjie darîjumi'&CHR(9)&CHR(9)&LEFT(FORMAT(DOK_SUMMA_P,@N-_12.2))&CHR(9)&|
       LEFT(FORMAT(PVN_SUMMA_P,@N-_12.2))
       ADD(OUTFILEANSI)
       OUTA:LINE='Kopâ:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DOK_SUMMA_K,@N-_12.2))&CHR(9)&LEFT(FORMAT(PVN_SUMMA_K,@N-_12.2))
       ADD(OUTFILEANSI)
    .
    IF F:XML_OK#=TRUE
       XML:LINE='<<Row>'
       ADD(OUTFILEXML)
       XML:LINE='<<Field name="rindas_nr" value="'&NPK&'" />'
       ADD(OUTFILEXML)
       XML:LINE='<<Field name="valsts_dp" value="LV" />'
       ADD(OUTFILEXML)
       IF MINMAXSUMMA<=100
          XML:LINE='<<Field name="isais_nosauk_dp" value="Darîjumi zem 100 Ls" />'
       ELSE
          XML:LINE='<<Field name="isais_nosauk_dp" value="Darîjumi zem 500 Ls" />'
       .
       ADD(OUTFILEXML)
       XML:LINE='<<Field name="summa" value="'&CUT0(DOK_SUMMA_P,2,2,1,1)&'" />'
       ADD(OUTFILEXML)
       XML:LINE='<<Field name="summa_pvn" value="'&CUT0(PVN_SUMMA_P,2,2,1,1)&'" />'
       ADD(OUTFILEXML)
       XML:LINE='<<Field name="attaisn_dok" value="1" />'
       ADD(OUTFILEXML)
       XML:LINE='<</Row>'
       ADD(OUTFILEXML)
       XML:LINE='<</Declaration>'
       ADD(OUTFILEXML)
       XML:LINE='<</DeclarationFile>'
       ADD(OUTFILEXML)
       CLOSE(OUTFILEXML)
    .

!************************II.D.SAÒEMTÂS ES PRECES(SAMAKSÂTS PAR PRECI)********

    NPK=0
    IF F:DBF='W'   !WMF
       IF F:DTK
           PRINT(RPT:PAGEBREAK)
       .
       PRINT(RPT:D2_HEAD)
    ELSIF F:DBF='E'   !EXCEL
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='          II. Par precçm, kas saòemtas no ES dalîbvalstîm'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera'&CHR(9)&'Saòemto preèu'&CHR(9)&|
        'PVN, Ls'&CHR(9)&'Saòemto preèu'&CHR(9)&'No darîjuma partnera'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&'ar PVN apliekamâs'&CHR(9)&'vçrtîba,no kuras'&CHR(9)&CHR(9)&'vçrtîba valûtâ'&CHR(9)&|
        'saòemtais rçíins'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&'personas reì. Nr'&CHR(9)&'aprçíinâts nodoklis'&CHR(9)&'Summa'&CHR(9)&'Val.k.'&CHR(9)&|
        'Numurs'&CHR(9)&'Datums'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'bez PVN (Ls)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    ELSE              !WORD
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='          II. Par precçm, kas saòemtas no ES dalîbvalstîm'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera ar PVN apliekamâs personas reì. Nr'&|
        CHR(9)&'Saòemto preèu vçrtîba,no kuras aprçíinâts nodoklis bez PVN (Ls)'&CHR(9)&|
        'PVN, Ls'&CHR(9)&'Saòemto preèu vçrtîba valûtâ'&CHR(9)&'Val.k.'&CHR(9)&|
        'No darîjuma partnera saòemtais rçíins Numurs'&CHR(9)&'Datums'
        ADD(OUTFILEANSI)
    .
    IF F:XML
        XMLFILENAME=USERFOLDER&'\PVN_PII.DUF'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
           F:XML_OK#=FALSE
        ELSE
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
           XML:LINE='<<?xml version="1.0" encoding="windows-1257" ?>'
           ADD(OUTFILEXML)
           XML:LINE='<<DeclarationFile type="pvn_es">'
           ADD(OUTFILEXML)
           XML:LINE='<<Declaration>'
           ADD(OUTFILEXML)
           XML:LINE='<<DeclarationHeader>'
           ADD(OUTFILEXML)
           IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
           XML:LINE='<<Field name="nmr_kods" value="'&GL:REG_NR&'" />'
           ADD(OUTFILEXML)
           TEX:DUF=CLIENT
           DO CONVERT_TEX:DUF
           XML:LINE='<<Field name="nosaukums" value="'&CLIP(TEX:DUF)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="taks_no" value="'&FORMAT(S_DAT,@D06.)&'" />'
           ADD(OUTFILEXML)
           IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods lîdz '&FORMAT(B_DAT,@D06.)).
           XML:LINE='<<Field name="taks_lidz" value="'&FORMAT(B_DAT,@D06.)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="izpilditajs" value="'&CLIP(SYS:PARAKSTS2)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="vaditajs" value="'&CLIP(SYS:PARAKSTS1)&'" />'
           ADD(OUTFILEXML)
           GET(R_TABLE,0)
           LOOP I#= 1 TO RECORDS(R_TABLE)
              GET(R_TABLE,I#)
              IF R:PAR_TIPS='C'   ! TIKAI ES PRECE
                 PVN_KOPA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[6,2]+R:PVNS[7,2]     !18+5+21+10%   ES
                 SUMMA_KOPA = R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1
              .
           .
           XML:LINE='<<Field name="summa_kopa" value="'&CUT0(SUMMA_KOPA,2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="pvn_kopa" value="'&CUT0(PVN_KOPA,2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="dar_sk" value="'&DAR_SK&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<</DeclarationHeader>'
           ADD(OUTFILEXML)
        .
    .
    GET(R_TABLE,0)
    LOOP I#= 1 TO RECORDS(R_TABLE)
      GET(R_TABLE,I#)
      IF R:PAR_TIPS='C'   ! TIKAI ES PRECE
        IF R:PVN_TIPS='A'
           PAR_nos_p = '67:'&GETPAR_K(R:PAR_NR,0,2)
        ELSE
           PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
        .
        pers_kods = GETPAR_K(R:PAR_NR,0,8)
        X#=GETGG(R:U_NR)  ! POZICIONÇJAM GG
        GG_DOKDAT = GG:DOKDAT
        PVN_SUMMA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[6,2]+R:PVNS[7,2] !Ls
        PVN_SUMMA_K2+= PVN_SUMMA
        DOK_SUMMAV=R:PVNS[1,1]/0.18+R:PVNS[2,1]/0.05+R:PVNS[6,1]/0.21+R:PVNS[7,1]/0.1 !ES
        DOK_SUMMA =R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1 !Ls
        DOK_VAL=R:VAL
        GG_DOK_NR=GG:DOK_SENR
        DOK_SUMMA_K2+=DOK_SUMMA
        IF DOK_SUMMA
           NPK+=1
           IF F:DBF = 'W'
                PRINT(RPT:D2_DETAIL)                                                                                                 
           ELSIF F:DBF='E'
                OUTA:LINE=NPK&CHR(9)&PAR_NOS_P&CHR(9)&PERS_KODS&CHR(9)&FORMAT(DOK_SUMMA,@N_12.2)&CHR(9)&FORMAT(PVN_SUMMA,@N_12.2)&CHR(9)&FORMAT(dok_summav,@N_12.2)&CHR(9)&FORMAT(DOK_VAL,@S3)&CHR(9)&GG:DOK_SENR&CHR(9)&FORMAT(GG_DOKDAT,@D10.)
                ADD(OUTFILEANSI)
           ELSE
                OUTA:LINE=NPK&CHR(9)&PAR_NOS_P&CHR(9)&PERS_KODS&CHR(9)&FORMAT(DOK_SUMMA,@N12.2)&CHR(9)&FORMAT(PVN_SUMMA,@N12.2)&CHR(9)&FORMAT(dok_summav,@N12.2)&CHR(9)&FORMAT(DOK_VAL,@S3)&CHR(9)&GG:DOK_SENR&CHR(9)&FORMAT(GG_DOKDAT,@D06)
                ADD(OUTFILEANSI)
           .
           IF F:XML_OK#=TRUE
              XML:LINE='<<Row>'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="npk" value="'&NPK&'" />'
              ADD(OUTFILEXML)
              TEX:DUF=PAR_NOS_P
              DO CONVERT_TEX:DUF
              XML:LINE='<<Field name="partneris" value="'&CLIP(TEX:DUF)&'" />'
              ADD(OUTFILEXML)
              IF ~PERS_KODS THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods').
              XML:LINE='<<Field name="valsts_num" value="'&CLIP(PERS_KODS[1:15])&'" />' !dati:max=15
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="summa_l" value="'&CUT0(DOK_SUMMA,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="pvn_l" value="'&CUT0(PVN_SUMMA,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="summa_v" value="'&CUT0(DOK_SUMMAV,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="valuta" value="'&DOK_VAL&'" />'
              ADD(OUTFILEXML)
              IF GG_DOK_NR
                 XML:LINE='<<Field name="rek_numurs" value="'&clip(GG_DOK_NR)&'" />'
                 ADD(OUTFILEXML)
              .
              XML:LINE='<<Field name="rek_datums" value="'&FORMAT(GG_DOKDAT,@D06.)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<</Row>'
              ADD(OUTFILEXML)
           .
        .
      .
    .
    IF F:DBF = 'W'
        PRINT(RPT:D2_FOOTER)
        ENDPAGE(report)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Kopâ:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DOK_SUMMA_K2,@N_12.2))&CHR(9)&LEFT(FORMAT(PVN_SUMMA_K2,@N_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Uzòçmuma vadîtâjs____________________'&CHR(9)&'Grâmatvedis____________________'
        ADD(OUTFILEANSI)
    .
    IF F:XML_OK#=TRUE
       XML:LINE='<</Declaration>'
       ADD(OUTFILEXML)
       XML:LINE='<</DeclarationFile>'
       ADD(OUTFILEXML)
       CLOSE(OUTFILEXML)
    .
    CLOSE(ProgressWindow)
    IF F:DBF='W'   !WMF
      RP

! STOP('RP')
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
  FREE(R_TABLE)
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE           !RTF
     ANSIFILENAME=''
  .
  IF FilesOpened
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
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
      ?Progress:PctText{Prop:Text} = 'analizçti '&FORMAT(PercentProgress,@N3) & '% no DB'
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
CONVERT_TEX:DUF  ROUTINE
  LOOP J#= 1 TO LEN(TEX:DUF)  !CSTRING NEVAR LIKT
     IF TEX:DUF[J#]='"'
        TEX:DUF=TEX:DUF[1:J#-1]&'&quot;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='<<'
        TEX:DUF=TEX:DUF[1:J#-1]&'&lt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='>'
        TEX:DUF=TEX:DUF[1:J#-1]&'&gt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='&'
        TEX:DUF=TEX:DUF[1:J#-1]&'&amp;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=''''
        TEX:DUF=TEX:DUF[1:J#-1]&'apos;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     .
  .
