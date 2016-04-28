                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_NPP22008           PROCEDURE                    ! Declare Procedure
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
SUMMAR          DECIMAL(11)
SUMMA0          DECIMAL(11)
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
CNTRL1R              DECIMAL(13,2)
CNTRL2R              DECIMAL(13,2)
R440                 DECIMAL(11)

E                    STRING(1)
EE                   STRING(15)
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
report REPORT,AT(100,300,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
CEPURE DETAIL,AT(,,,1333),USE(?unnamed:7)
         STRING(@s45),AT(3146,104,3542,177),USE(client),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6552,458,198,344),USE(E),TRN,CENTER,FONT(,22,,FONT:bold,CHARSET:ANSI)
         STRING(@s11),AT(3146,458,833,177),USE(GL:reg_nr),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzòçmuma reìistrâcijas numurs Nodokïu maksâtâju reìistrâ'),AT(104,479),USE(?String41)
         STRING(@S15),AT(6760,625,1000,156),USE(EE),TRN,LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING('Taksâcijas periods'),AT(104,646),USE(?String41:3),TRN
         STRING(@s30),AT(3146,646,2240,180),USE(periods30),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçrvienîba: Ls'),AT(6938,896,844,177),USE(?String41:2),TRN,RIGHT
         STRING(@s60),AT(3146,281,4375,156),USE(GL:adrese),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Naudas plûsmas pârskats pçc netieðâs metodes (NPP2)'),AT(719,844,5615,260),USE(?String4), |
             CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1104,7656,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(5875,1104,0,230),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5500,1104,0,230),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(156,1104,0,230),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(6823,1104,0,230),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7813,1104,0,230),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Râdîtâja nosaukums'),AT(1031,1146,3750,180),USE(?nosaukums),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
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
DETAILK DETAIL,AT(,,8000,177),USE(?unnamed:K)
         STRING(@s100),AT(188,10,5300,156),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:4),LEFT,FONT(,9,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(156,-10,0,177),USE(?Line2:6K),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,177),USE(?Line2:7K),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2:8K),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2:9K),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2:10K),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,167),USE(?unnamed:8)
         STRING(@N-11B),AT(6896,10,854,156),USE(R:SUMMA0),RIGHT,FONT(,9,,,CHARSET:BALTIC)
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
         STRING(@N-11B),AT(6896,10,854,156),USE(R:SUMMA0,,?R:SUMMA0:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
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
     KLUDA(0,'Nav atrodams(tukðs) fails '&CLIP(LONGPATH())&'\'&KONRNAME)
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
     R:SUMMAR=0
     ADD(R_TABLE)
  .
  SORT(R_TABLE,R:KODS)
  periods30='no '&FORMAT(S_DAT,@D06.)&' lîdz '&FORMAT(B_DAT,@D06.)
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
  ProgressWindow{Prop:Text} = 'NPP2'
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
        XMLFILENAME=USERFOLDER&'\NPP22008.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           E='E'
           EE='(NPP22008.XML)'
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
           XML:LINE=' Npp2>'
           ADD(OUTFILEXML)
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
                         R:SUMMA+=R_SUMMA !APAÏOSIM, KAD VISS BÛS SASKAITÎTS
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
  DO FILLR_TABLE   !AIZPILDA VISAS STARPSUMMAS UN NOAPAÏO
  GET(R_TABLE,0)
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     V#=INSTRING(FORMAT(R:KODS,@N03),'020250350',3) !PIRMS ÐITIEM VAJAG LIELO VIRSRAKSTU
     IF V#
        EXECUTE(V#)  !VIRSRAKSTI
           R_NOSAUKUMS='I. Pamatdarbîbas naudas plûsma'
           R_NOSAUKUMS='II. Ieguldîðanas darbîbas naudas plûsma'
           R_NOSAUKUMS='III. Finansçðanas darbîbas naudas plûsma'
        .
        PRINT(RPT:DETAILV)
        PRINT(RPT:SVITRA)
     .
     V#=INSTRING(FORMAT(R:KODS,@N03),'040150',3) !PIRMS ÐITIEM VAJAG KOREKCIJAS
     IF V#
        EXECUTE(V#)  !VIRSRAKSTI
           R_NOSAUKUMS='   Korekcijas: jâòem nost(-) vai jâskaita klât(+),kas jau pieskaitîts(noòemts) 20.rindâ'
           R_NOSAUKUMS='   Korekcijas: jâòem nost(-) vai jâskaita klât(+),kas jau pieskaitîts(noòemts) 130.rindâ'
        .
        PRINT(RPT:DETAILK)
        PRINT(RPT:SVITRA)
     .
     R_NOSAUKUMS=GETKON_R('N',R:KODS,0,1)
     R_USER=GETKON_R('N',R:KODS,0,3)
     IF F:NOA
        SR_SUMMA=FORMAT(R:SUMMAR,@N-15)
     ELSE
        SR_SUMMA=FORMAT(R:SUMMA,@N-15.2)
     .
     IF (R:KODS=130 OR R:KODS=180 OR R:KODS=210)    !MAZIE PAMATDARBÎBAS VIRSRAKSTI UN STARPSUMMAS
        PRINT(RPT:DETAIL)
        PRINT(RPT:SVITRA)
     ELSIF (R:KODS=230 OR R:KODS=330 OR R:KODS=410) !LIELÂS SADAÏU KOPSUMMAS
        PRINT(RPT:DETAILB)
        PRINT(RPT:SVITRA)
     ELSIF(R:KODS=420)                              !IEZAKS
        PRINT(RPT:DETAILB)
        PRINT(RPT:SVITRA)
     ELSIF(R:KODS=430)                              !PG NETO NAUDAS PLÛSMA
        PRINT(RPT:DETAILB)
        PRINT(RPT:SVITRA)
     ELSIF(R:KODS=440)                              !NAUDA SÂKUMÂ
        R440=R:SUMMA                                !PAGAIDÂM TÂDA LÂPÎÐANÂS...
        R:SUMMA0=R440
        PRINT(RPT:DETAILB)
        PRINT(RPT:SVITRA)
     ELSIF(R:KODS=450)                              !NAUDA BEIGÂS
        R:SUMMA0=R440
        PRINT(RPT:DETAILB)
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
     IF F:XML_OK#=TRUE
        IF R:SUMMA
           XML:LINE='<R'&CLIP(R:KODS)&'>'
           ADD(OUTFILEXML)
           IF R:KODS=440 OR R:KODS=450
              XML:LINE=' VertSak>'&CLIP(R:SUMMA0)&'</VertSak>'
              ADD(OUTFILEXML)
           .
           XML:LINE=' VertBeig>'&CLIP(R:SUMMAR)&'</VertBeig>'
           ADD(OUTFILEXML)
           IF R_USER
              XML:LINE=' Teksts>'&CLIP(R_NOSAUKUMS)&'</Teksts>'
              ADD(OUTFILEXML)
           .
           XML:LINE='</R'&CLIP(R:KODS)&'>'
           ADD(OUTFILEXML)
        .
     .
  .
  IF F:DTK and RECORDS(I_TABLE)  !
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
     XML:LINE='</Npp2>'
     ADD(OUTFILEXML)
     SET(OUTFILEXML)
     LOOP
        NEXT(OUTFILEXML)
        IF ERROR() THEN BREAK.
        IF ~XML:LINE[1]
           XML:LINE[1]='<'
           PUT(OUTFILEXML)
        .
     .
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
     R:SUMMAR=ROUND(R:SUMMA,1)
     IF (R:KODS=100)                                !I.Pamat.Darb. KOREKCIJAS:JÂBÛT+,EDS vienalga atòems priekð R130)
        CNTRL1-=R:SUMMA                             !ATÒEMAM, LAI PAREIZA MÛSU STARPSUMMA
        CNTRL1R-=R:SUMMAR                           !DOMÂJU, KA ÐITÂ IR EDS KÏÛDA
     ELSIF (R:KODS=380 OR R:KODS=390 OR R:KODS=400)    !III.Fin.Darb. NP(IZDEVUMI:JÂBÛT+,EDS vienalga atòems priekð R410)
        CNTRL1-=R:SUMMA                             !ATÒEMAM, LAI PAREIZA MÛSU STARPSUMMA
        CNTRL1R-=R:SUMMAR
     ELSE
        CNTRL1+=R:SUMMA
        CNTRL1R+=R:SUMMAR
     .
     IF (R:KODS=130 OR R:KODS=180 OR R:KODS=210)    !MAZIE PAMATDARBÎBAS VIRSRAKSTI UN STARPSUMMAS
        R:SUMMA=CNTRL1
        R:SUMMAR=CNTRL1R
     ELSIF (R:KODS=230 OR R:KODS=330 OR R:KODS=410) !LIELÂS SADAÏU KOPSUMMAS
        R:SUMMA=CNTRL1
        R:SUMMAR=CNTRL1R
        CNTRL2+=CNTRL1       !SKAITAM KOPÂ PRIEKÐ PG NETO NAUDAS PLÛSMAS
        CNTRL2R+=CNTRL1      !SKAITAM KOPÂ PRIEKÐ PG NETO NAUDAS PLÛSMAS
        CNTRL1=0             !NULLÇJAM LIELÂS SADAÏAS KOPSUMMU
        CNTRL1R=0
     ELSIF(R:KODS=430)                              !PG NETO NAUDAS PLÛSMA
        R:SUMMA=CNTRL2
        R:SUMMAR=CNTRL2R
     ELSIF(R:KODS=440)                              !NAUDA SÂKUMÂ
        CNTRL2+=R:SUMMA      !CTRL2 TAGAD IZMANTOJAM KÂ KONTROLSUMMU
        CNTRL2R+=R:SUMMA     !CTRL2 TAGAD IZMANTOJAM KÂ KONTROLSUMMU
     ELSIF(R:KODS=450)                              !NAUDA BEIGÂS
        CNTRL2-=R:SUMMA      !CTRL2 TAGAD JÂBÛT 0-EI
        CNTRL2R-=R:SUMMA     !CTRL2 TAGAD JÂBÛT 0-EI
     .
     PUT(R_TABLE)
  .

!KONTROLE PÇC VISÂM APAÏOÐANÂM IR VAJADZÎGA !!!

OMIT('MARIS')
!------------------------------------------------------------------------
FILL_R_TABLE ROUTINE
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     IF R:KODS=30 OR R:KODS=120 OR R:KODS=150 OR R:KODS=180 !STARPSUMMAS
        R:SUMMA =CNTRL1
        R:SUMMAR=CNTRL1R
     ELSE
        R:SUMMAR=ROUND(R:SUMMA,1)
        CNTRL1 +=R:SUMMA
        CNTRL1R+=R:SUMMAR
     .
     PUT(R_TABLE)
  .
  IF F:NOA AND R:KODS=180
     DELTA#=R:SUMMAR-ROUND(R:SUMMA,1)
     IF DELTA#
        KLUDA(0,'Summçjot pçc noapaïoðanas 180R='&CLIP(R:SUMMAR)&',jâbût '&CLIP(ROUND(R:SUMMA,1))&' izlîdzinu uz 160R',2,1)
        IF KLU_DARBIBA
           R:SUMMAR-=DELTA#
           PUT(R_TABLE)
           LOOP I#=1 TO RECORDS(R_TABLE)
              GET(R_TABLE,I#)
              IF R:KODS=160 !UIN
                 R:SUMMAR-=DELTA#
                 PUT(R_TABLE)
                 BREAK
              .
           .
        .
     .
  .

MARIS
B_PKIP2008           PROCEDURE                    ! Declare Procedure
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
SUMMAR          DECIMAL(11)
SUMMA0R         DECIMAL(11)
            .
B_TABLE     QUEUE,PRE(B)
BKK_KODS        STRING(9) !5+4
SUMMA           DECIMAL(13,2)
            .
R_NOSAUKUMS          LIKE(KONR:NOSAUKUMS)
R_USER               BYTE
R_SUMMA              DECIMAL(13,2)
R_SUMMA0             DECIMAL(13,2)
B_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
B_BKK                STRING(5)
I_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
PERIODS30            STRING(30)
KON_KOMENT           STRING(60)
DAT                  LONG
LAI                  LONG
SPB                  DECIMAL(13,2)         !SUMMA SADAÏAI PERIODA BEIGÂS
SPBR                 DECIMAL(11)
PS                   DECIMAL(13,2),DIM(6)  !PIEAUGUMS/SAMAZINÂJUMS NO LIETOTÂJA RINDÂM
PSR                  DECIMAL(13,2),DIM(6)  !PIEAUGUMS/SAMAZINÂJUMS NO LIETOTÂJA RINDÂM
IPGB                 DECIMAL(13,2),DIM(7)  !IEPRIEKÐÇJÂ PÂRSK.GADA BEIGÂS-MURGS
PK                   DECIMAL(13,2),DIM(3)  !PAÐU KAPITÂLS
PKR                  DECIMAL(11),DIM(3)

E                    STRING(1)
EE                   STRING(10)
TEX:DUF              STRING(100)
XMLFILENAME          CSTRING(200),STATIC
SADALA               STRING(100)
DRUKAT               BYTE
S_SUMMA              STRING(15)
S_SUMMA0             STRING(15)
E_SUMMA              STRING(15)

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
!report REPORT,AT(100,200,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
report REPORT,AT(100,600,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
CEPURE DETAIL,AT(,,,1563),USE(?unnamed:7)
         STRING(@s45),AT(2656,104,3542,208),USE(client),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(6281,594,167,385),USE(E),TRN,FONT(,22,,FONT:bold,CHARSET:ANSI)
         STRING(@s11),AT(3177,510,833,208),USE(GL:reg_nr),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@S10),AT(6500,719,854,156),USE(EE),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Uzòçmuma reìistrâcijas numurs Nodokïu maksâtâju reìistrâ'),AT(104,510),USE(?String41)
         STRING('Taksâcijas periods'),AT(104,698),USE(?String41:2),TRN
         STRING(@s30),AT(2656,698,2240,208),USE(periods30),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçrvienîba: Ls'),AT(7083,969),USE(?String41:3),TRN
         STRING(@s60),AT(2656,313,4531,208),USE(GL:adrese),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Paðu kapitâla izmaiòu pârskats (PKIP)'),AT(469,875,6510,260),USE(?String4),CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5500,1177,0,396),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(156,1167,7656,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(156,1177,0,396),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(5875,1177,0,396),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6823,1177,0,396),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7813,1167,0,396),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Rindiòas nosaukums'),AT(1031,1219,3750,180),USE(?nosaukums),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârskata'),AT(5958,1188,781,177),USE(?t1),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Iepr.pârskata'),AT(6854,1188,938,177),USE(?client:5),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('gada beigâs'),AT(6854,1375,938,177),USE(?client:2),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('gada beigâs'),AT(5896,1375,938,177),USE(?client:3),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese'),AT(104,313,573,208),USE(?String10:6),LEFT
         STRING('Uzòçmuma (uzòçmçjsabiedrîbas) nosaukums'),AT(104,104,2448,208),USE(?String10:4),LEFT
       END
DETAILV DETAIL,AT(,,8000,177),USE(?unnamed)
         STRING(@s100),AT(188,21,5300,156),USE(SADALA),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,-10,0,177),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,177),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2:10),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,177),USE(?unnamed:8)
         STRING(@s4),AT(5563,10,280,156),USE(R:KODS),LEFT,FONT(,9,,)
         STRING(@S15),AT(5927,10,854,156),USE(S_SUMMA,,?S_SUMMA:3),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@S15),AT(6906,10,854,156),USE(S_SUMMA0),TRN,RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s100),AT(188,10,5300,156),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:2),LEFT(1)
         LINE,AT(156,-10,0,177),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,177),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2:15),COLOR(COLOR:Black)
       END
DETAILBKK DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(156,-10,0,197),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@s60),AT(1042,10,4271,156),USE(B_NOSAUKUMS),LEFT
         STRING(@s5),AT(521,10,417,156),USE(B_BKK),LEFT
         STRING(@N-_12.2B),AT(5927,10,,156),USE(B:SUMMA),RIGHT,FONT(,9,,)
         LINE,AT(5500,-10,0,177),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,177),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,177),USE(?Line2:20),COLOR(COLOR:Black)
       END
SVITRA DETAIL,AT(,,,0)
         LINE,AT(156,0,7656,0),USE(?Line1:2),COLOR(COLOR:Black)
       END
PAGE_FOOT DETAIL,AT(,,,73),USE(?unnamed:2)
         LINE,AT(156,52,7656,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,62),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,62),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,62),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,62),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,62),USE(?Line2:25),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,,,344),USE(?unnamed:4)
         LINE,AT(156,-10,0,62),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(5500,-10,0,62),USE(?Line2:35),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,62),USE(?Line2:36),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,62),USE(?Line2:37),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,62),USE(?Line2:38),COLOR(COLOR:Black)
         LINE,AT(156,52,7656,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('RC :'),AT(156,83),USE(?String31),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(365,83,188,177),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6698,83,573,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7302,83,521,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@s25),AT(1115,188,1667,208),USE(SYS:AMATS1),TRN,RIGHT
         STRING('_{34}'),AT(2802,177,2240,156),USE(?String34),TRN
         STRING(@s25),AT(5000,188,1667,208),USE(SYS:PARAKSTS1),TRN,LEFT
       END
       FOOTER,AT(100,11168,8000,125),USE(?unnamed:6)
         STRING(@P<<<#. lapaP),AT(7240,-10,573,156),PAGENO,USE(?PageCount),RIGHT
       END
     END

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

  CheckOpen(KON_R,1)
  KON_R::Used += 1
  IF RECORDS(KON_R)=0
     KLUDA(0,'Nav atrodams(tukðs) fails '&CLIP(LONGPATH())&'\'&KONRNAME)
     DO PROCEDURERETURN
  .
  IF KON_K::Used = 0
    CheckOpen(KON_K,1)
  END
  KON_K::Used += 1
  CheckOpen(GGK,1)
  FilesOpened = True

  CLEAR(KONR:RECORD)
  KONR:UGP='K' !PKIP
  SET(KONR:UGP_KEY,KONR:UGP_KEY)
  LOOP
     NEXT(KON_R)
     IF ERROR() OR ~(KONR:UGP='K') THEN BREAK.
     R:KODS=KONR:KODS
     R:SUMMA=0
     R:SUMMAR=0
     ADD(R_TABLE)
  .
  SORT(R_TABLE,R:KODS)
  periods30='no '&FORMAT(S_DAT,@D06.)&' lîdz '&FORMAT(B_DAT,@D6.)
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
  ProgressWindow{Prop:Text} = 'PKIP'
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
        XMLFILENAME=USERFOLDER&'\PKIP2008.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           E='E'
           EE='(PKIP2008)'
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
           XML:LINE=' Pkip>'
           ADD(OUTFILEXML)
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
          LOOP J# = 1 TO 2
             IF KON:PKIP[J#]
                R:KODS=KON:PKIP[J#]
!                STOP(R:KODS&' '&GGK:SUMMA&' '&GGK:BKK&GGK:D_K)
                GET(R_TABLE,R:KODS)
                IF ERROR()
                   KLUDA(71,'www.vid.gov.lv KONTS='&kon:BKK&' R='&KON:PKIP[J#])
                   DO PROCEDURERETURN
                ELSE
                   R_SUMMA=0
                   IF  KON:PKIF[J#]='B' AND ~(GGK:U_NR=1) ! K-D,~SALDO
                      IF GGK:D_K='D'
                         R_SUMMA=-GGK:SUMMA
                      ELSE
                         R_SUMMA=GGK:SUMMA
                      .
                   ELSIF KON:PKIF[J#]='S' AND GGK:U_NR=1 ! SALDOK-SALDOD
                      IF GGK:D_K='D'
                         R_SUMMA=-GGK:SUMMA
                      ELSE
                         R_SUMMA=GGK:SUMMA
                      .
                   ELSIF KON:PKIF[J#]='A' AND ~(GGK:U_NR=1) ! D-K,~SALDO
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
                         B:BKK_KODS=GGK:BKK&FORMAT(R:KODS,@N_4)
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
!---------------
  DO FILL_R_TABLE
!---------------
  GET(R_TABLE,0)
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     V#=INSTRING(FORMAT(R:KODS,@N04),'0010010001900280037004601000',4) !PIRMS ÐITIEM VAJAG VIRSRAKSTU
     IF V#
        EXECUTE(V#)
           SADALA='1. Akciju vai daïu kapitâls(pamatkapitâls)'
           SADALA='2. Akciju(daïu) emisijas uzcenojums'
           SADALA='3. Ilgtermiòa ieguldîjumu pârvçrtçðanas rezerves'
           SADALA='4. Finanðu instrumentu pârvçrtçðana'
           SADALA='5. Rezerves'
           SADALA='6. Nesadalîtâ peïòa'
           SADALA='7. Paðu kapitâls'
        .
        PRINT(RPT:DETAILV)
        PRINT(RPT:SVITRA)
     .
     R_NOSAUKUMS=GETKON_R('K',R:KODS,0,1)
     R_USER=GETKON_R('K',R:KODS,0,3)
     IF ~(R_USER AND ~R:SUMMA) !~LIETOTÂJA DEFINÇTÂ SADAÏA un TUKÐS ~TUKÐA LIETOTÂJA RINDA
        IF F:NOA
           S_SUMMA=FORMAT(R:SUMMAR,@N-15)
           S_SUMMA0=FORMAT(R:SUMMA0R,@N-15)
        ELSE
           S_SUMMA=FORMAT(R:SUMMA,@N-15.2)
           S_SUMMA0=FORMAT(R:SUMMA0,@N-15.2)
        .
        PRINT(RPT:DETAIL)
        IF F:DTK  !IZVÇRSTÂ VEIDÂ
           LOOP J#= 1 TO RECORDS(B_TABLE)
              GET(B_TABLE,J#)
              IF B:BKK_KODS[6:9]=R:KODS
                 B_BKK=B:BKK_KODS[1:5]
                 B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 PRINT(RPT:DETAILBKK)
              .
           .
        .
        PRINT(RPT:SVITRA)
     .
     IF F:XML_OK#=TRUE
        IF R:SUMMA
           XML:LINE='<R'&CLIP(R:KODS)&'>'
           ADD(OUTFILEXML)
           XML:LINE=' VertSak>'&CLIP(R:SUMMA0R)&'</VertSak>'
           ADD(OUTFILEXML)
           XML:LINE=' VertBeig>'&CLIP(R:SUMMAR)&'</VertBeig>'
           ADD(OUTFILEXML)
           IF R_USER
              XML:LINE=' Teksts>'&CLIP(R_NOSAUKUMS)&'</Teksts>'
              ADD(OUTFILEXML)
           .
           XML:LINE='</R'&CLIP(R:KODS)&'>'
           ADD(OUTFILEXML)
        .
     .
  .
  PRINT(RPT:FOOTER)
  IF F:XML_OK#=TRUE
     XML:LINE='</Pkip>'
     ADD(OUTFILEXML)
     SET(OUTFILEXML)
     LOOP
        NEXT(OUTFILEXML)
        IF ERROR() THEN BREAK.
        IF ~XML:LINE[1]
           XML:LINE[1]='<'
           PUT(OUTFILEXML)
        .
     .
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
FILL_R_TABLE ROUTINE
  K1#=40
  K2#=80
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     R:SUMMAR=ROUND(R:SUMMA,1)        !   !   !   !   !   !
     V#=INSTRING(FORMAT(R:KODS,@N04),'001001000190028003700460',4) !6 IEPR.G.BILANCES SUMMA
     IF V#
        T#=V#
        SPB      =R:SUMMA
        SPBR     =R:SUMMAR
        IPGB[V#] =R:SUMMA           !25.03.09.
        R:SUMMA0 =IPGB[V#]          !25.03.09. IEPR.PARSK.G.SÂKUMA-MURGS
        R:SUMMA0R=ROUND(IPGB[V#],1) !25.03.09. IEPR.PARSK.G.SÂKUMÂ-MURGS
        PK[1]   +=R:SUMMA            !25.03.09.
        PKR[1]  +=R:SUMMAR           !25.03.09.
!     .                                !   !   !   !   !   !
!     V#=INSTRING(FORMAT(R:KODS,@N04),'002001100200029003800470',4) !6 IEPR.G.SUMMAS LABOJUMS
!     IF V#
!        SPB  +=R:SUMMA
!        SPBR +=R:SUMMAR
!        PK[2] +=R:SUMMA      !25.03.09.
!        PKR[2]+=R:SUMMAR     !25.03.09.
!     .
     ELSIF INRANGE(R:KODS,K1#,K2#) !LIETOTÂJA DEFINÇTIE,NO ÐITIEM TAISA PIEAUGUMU/SAMAZINÂJUMU
        PS[T#] +=R:SUMMA
        PSR[T#]+=R:SUMMAR
        SPB  +=R:SUMMA
        SPBR +=R:SUMMAR
     ELSE                          !VISS LÎDZ STARPSUMMAI
        SPB  +=R:SUMMA
        SPBR +=R:SUMMAR
     .                                !   !   !   !   !   !
     V#=INSTRING(FORMAT(R:KODS,@N04),'009001800270036004500540',4) !6 STARPSUMMAS:BEIGAS PÂRSKATA PERIODA GADÂ
     IF V#                   !FIKSÇJAM MAZÂS STARPSUMMAS,SKAITAM ATLIKUMU KOPÂ
        R:SUMMA  =SPB
        R:SUMMAR =SPBR
        PK[3]   +=R:SUMMA            !25.03.09. PAÐU KAPITÂLS BEIGÂS
        PKR[3]  +=R:SUMMAR           !25.03.09.
        R:SUMMA0 =IPGB[V#]         !25.03.09. IEPR.PARSK.G.BEIGÂS-MURGS
        R:SUMMA0R=ROUND(IPGB[V#],1) !25.03.09. IEPR.PARSK.G.BEIGÂS-MURGS
        SPB   =0
        SPBR  =0
        EXECUTE V#
           K1#=130 !2 LIETOTÂJA DEFINÇTIE KODI
           K1#=220
           K1#=310
           K1#=400
           K1#=490 !6
        .
        EXECUTE V#
           K2#=170 !2
           K2#=260
           K2#=350
           K2#=440
           K2#=530 !6
        .
     .                                !   !   !
     V#=INSTRING(FORMAT(R:KODS,@N04),'100010101130',4) !GALA SUMMA-PAÐU KAPITÂLS
     IF V#
        R:SUMMA =PK[V#]        !25.03.09.
        R:SUMMAR=PKR[V#]       !25.03.09.
        CASE V#                !MURGS RÇÏ IEPR.PÂRSK.G.BEIGÂM UN IEPRIEKÐIEPRIEKÐÇJÂ
        OF 1
           R:SUMMA0 =R:SUMMA
           R:SUMMA0R=R:SUMMAR
           SPB =R:SUMMA
           SPBR=R:SUMMAR
        OF 3
           R:SUMMA0 =SPB
           R:SUMMA0R=SPBR
        .
     .
     PUT(R_TABLE)
  .
  LOOP I#=1 TO RECORDS(R_TABLE) !TAGAD AIZPILDAM PIEAUGUMU/SAMAZINÂJUMU
     GET(R_TABLE,I#)                  !   !   !   !   !   !
     V#=INSTRING(FORMAT(R:KODS,@N04),'003001200210030003900480',4) !6 PIEAUGUMI/SAMAZINÂJUMI
     IF V#                   !
        R:SUMMA  =PS[V#]
        R:SUMMAR =PSR[V#]
        PUT(R_TABLE)
     .
  .
F_KON_R              PROCEDURE                    ! Declare Procedure
DAT                 LONG
LAI                 LONG
FILE_DAT            LONG
F:SADALA            STRING(1)
R_NOSAUKUMS         STRING(100)
R_NOSAUKUMSA        STRING(100)
SAV_UGP             STRING(1)

!-----------------------------------------------------------------------------
Process:View         VIEW(KON_R)
                       PROJECT(UGP)
                       PROJECT(KODS)
                       PROJECT(USER)
                       PROJECT(NOSAUKUMS)
                       PROJECT(NOSAUKUMSA)
                     END
!-----------------------------------------------------------------------------
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
report REPORT,AT(146,1229,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(146,198,8000,1031),USE(?unnamed)
         STRING(@s45),AT(1688,104,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7271,469),PAGENO,USE(?PageCount),RIGHT
         STRING('UGP rindu kodi uz'),AT(2667,417),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(4198,417),USE(file_dat),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,729,7708,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(604,729,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(823,729,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(7865,729,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Kods'),AT(177,771,417,208),USE(?String4:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(1792,781,1094,208),USE(?String4:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4292,729,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('Nosaukums angliski'),AT(4813,781,1615,208),USE(?String4:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,990,7708,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(156,729,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,146),USE(?unnamed:4)
         LINE,AT(604,-10,0,167),USE(?Line8:2),COLOR(COLOR:Black)
         STRING(@N_4B),AT(250,10,292,146),USE(KONR:KODS),RIGHT
         LINE,AT(823,-10,0,167),USE(?Line8:3),COLOR(COLOR:Black)
         STRING(@s60),AT(854,0,3406,146),USE(KONR:NOSAUKUMS),LEFT
         STRING(@s60),AT(4323,0,3521,146),USE(KONR:NOSAUKUMSA),LEFT
         LINE,AT(7865,-10,0,167),USE(?Line8:5),COLOR(COLOR:Black)
         LINE,AT(4292,-10,0,167),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,167),USE(?Line8),COLOR(COLOR:Black)
       END
detailB DETAIL,AT(,,,146),USE(?unnamed:4D)
         LINE,AT(604,-10,0,167),USE(?Line8:2D),COLOR(COLOR:Black)
         STRING(@N_4B),AT(250,10,292,146),USE(KONR:KODS,,?KONR:KODSD),RIGHT
         LINE,AT(823,-10,0,167),USE(?Line8:3D),COLOR(COLOR:Black)
         STRING(@s60),AT(854,0,3406,146),USE(KONR:NOSAUKUMS,,?KONR:NOSAUKUMSD),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(4323,0,3521,146),USE(KONR:NOSAUKUMSA,,?KONR:NOSAUKUMSAD),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7865,-10,0,167),USE(?Line8:5D),COLOR(COLOR:Black)
         LINE,AT(4292,-10,0,167),USE(?Line8:6D),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,167),USE(?Line8D),COLOR(COLOR:Black)
       END
VIRSRAKSTSB DETAIL,AT(,,,146),USE(?unnamed:4B)
         LINE,AT(604,-10,0,167),USE(?Line8:2B),COLOR(COLOR:Black)
         LINE,AT(823,-10,0,167),USE(?Line8:3B),COLOR(COLOR:Black)
         STRING(@s60),AT(854,0,3406,146),USE(R_NOSAUKUMS),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(4323,0,3521,146),USE(R_NOSAUKUMSA),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7865,-10,0,167),USE(?Line8:5B),COLOR(COLOR:Black)
         LINE,AT(4292,-10,0,167),USE(?Line8:6B),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,167),USE(?Line8B),COLOR(COLOR:Black)
       END
VIRSRAKSTSBB DETAIL,AT(,,,146),USE(?unnamed:4BB)
         LINE,AT(604,-10,0,167),USE(?Line8:2BB),COLOR(COLOR:Black)
         LINE,AT(823,-10,0,167),USE(?Line8:3BB),COLOR(COLOR:Black)
         STRING(@s60),AT(854,0,3406,146),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(4323,0,3521,146),USE(R_NOSAUKUMSA,,?R_NOSAUKUMSA:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7865,-10,0,167),USE(?Line8:5BB),COLOR(COLOR:Black)
         LINE,AT(4292,-10,0,167),USE(?Line8:6BB),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,167),USE(?Line8BB),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,156),USE(?unnamed:3)
         LINE,AT(156,0,7708,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(167,21),USE(?String18),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(625,21),USE(acc_kods),FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(6854,21),USE(DAT,,?DATUMS:2),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7448,21),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(146,10896,8000,52)
         LINE,AT(156,0,7708,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,62),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO

window WINDOW('Papildus Filtrs'),AT(,,155,105),GRAY
       OPTION('Sadaïa:'),AT(15,9,130,69),USE(F:SADALA),BOXED
         RADIO('Visas'),AT(26,19,111,10),USE(?F:SADALA:Radio1),VALUE(' ')
         RADIO('Bilance'),AT(26,29,111,10),USE(?F:SADALA:Radio2),VALUE('B')
         RADIO('Peïòas/zaudçjumu aprçíins'),AT(26,39,111,10),USE(?F:SADALA:Radio3),VALUE('P')
         RADIO('Naudas plûsmas pârskats'),AT(26,49,111,10),USE(?F:SADALA:Radio4),VALUE('N')
         RADIO('Paðu kapitâla izmaiòu pârskats'),AT(26,59,111,10),USE(?F:SADALA:Radio5),VALUE('K')
       END
       BUTTON('&OK'),AT(70,81,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(109,81,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND

  OPEN(window)
  F:SADALA=''
  ACCEPT
    CASE FIELD()
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
          LocalResponse = RequestCompleted
          BREAK
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        LocalResponse = RequestCancelled
        close(window)
        DO ProcedureReturn
      END
    END
  END
  close(window)

  FILE_dat=today()
  dat=today()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CheckOpen(KON_R,1)
  KON_R::Used += 1
  IF RECORDS(KON_R)=0
     KLUDA(0,'Nav atrodams(tukðs) fails '&CLIP(LONGPATH())&'\'&KONRNAME)
     DO PROCEDURERETURN
  .
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  FilesOpened = True

  RecordsToProcess = RECORDS(KON_R)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'UGP rindu kodi'
  ?Progress:UserString{Prop:Text}=''
  SEND(KON_R,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KONR:RECORD)
      KONR:UGP=F:SADALA
      SET(KONR:UGP_KEY,KONR:UGP_KEY)
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
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('UGP.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='UGP rindu kodi uz '&format(FILE_DAT,@D06.)&' '&GADS
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Kods'&CHR(9)&'L'&CHR(9)&'Nosaukums'&CHR(9)&'Nosaukums A'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~F:SADALA OR F:SADALA=KONR:UGP
            npk#+=1
            ?Progress:UserString{Prop:Text}=NPK#
            bold#=FALSE
            IF ~(SAV_UGP=KONR:UGP)
               CASE KONR:UGP
               OF 'B'
                  R_NOSAUKUMS='***** BILANCE *****'
                  R_NOSAUKUMSA='***** BALANCE *****'
               OF 'P'
                  R_NOSAUKUMS='*** PEÏÒAS vai ZAUDÇJUMU APRÇÍINS ***'
                  R_NOSAUKUMSA=''
               OF 'N'
                  R_NOSAUKUMS='**** NAUDAS PLÛSMAS PÂRSKATS ****'
                  R_NOSAUKUMSA=''
               OF 'K'
                  R_NOSAUKUMS='**** PAÐU KAPITÂLA IZMAIÒU PÂRSKATS ****'
                  R_NOSAUKUMSA=''
               .
               IF F:DBF = 'W'
                  PRINT(RPT:VIRSRAKSTSBB)
               ELSE
                  OUTA:LINE=CHR(9)&CHR(9)&R_NOSAUKUMS&CHR(9)&R_NOSAUKUMSA
                  ADD(OUTFILEANSI)
                  ADD(OUTFILEANSI)
               .
               SAV_UGP=KONR:UGP
            .
            DISPLAY(?Progress:UserString)
            IF KONR:UGP='B'
               V#=INSTRING(FORMAT(KONR:KODS,@N03),'010210430540580',3)  !PIRMS ÐITIEM LIELAIS VIRSRAKSTS
               IF V#
                  EXECUTE V#
                     R_NOSAUKUMSA='1.LONG-TERM INVESTMENTS'
                     R_NOSAUKUMSA='2.CURRENT ASSETS'
                     R_NOSAUKUMSA='1.EQUITY CAPITAL'
                     R_NOSAUKUMSA='2.STOCKPILES'
                     R_NOSAUKUMSA='3.CREDITORS'
                  .
                  EXECUTE V#
                     R_NOSAUKUMS='1. Ilgtermiòa ieguldîjumi'
                     R_NOSAUKUMS='2. Apgrozâmie lîdzekïi'
                     R_NOSAUKUMS='1. Paðu kapitâls'
                     R_NOSAUKUMS='2. Uzkrâjumi'
                     R_NOSAUKUMS='3. Kreditori'
                  .
                  IF F:DBF = 'W'
                     PRINT(RPT:VIRSRAKSTSBB)
                  ELSE
                     OUTA:LINE=CHR(9)&CHR(9)&R_NOSAUKUMS&CHR(9)&R_NOSAUKUMSA
                     ADD(OUTFILEANSI)
                     ADD(OUTFILEANSI)
                  .
               .
               V#=INSTRING(FORMAT(KONR:KODS,@N03),'010060103109115210272280360460510580650',3)  !PIRMS ÐITIEM MAZAIS VIRSRAKSTS
               IF V#
                  EXECUTE V#
                     R_NOSAUKUMSA='I.INTANGIBLE INVESTMENTS'
                     R_NOSAUKUMSA='II.FIXED ASSETS'
                     R_NOSAUKUMSA='III'
                     R_NOSAUKUMSA='IV'
                     R_NOSAUKUMSA='V.LONG=TERM FINANCIAL INVESTMENTS'
                     R_NOSAUKUMSA='I.STOCKS'
                     R_NOSAUKUMSA='II.'
                     R_NOSAUKUMSA='III.DEBTORS'
                     R_NOSAUKUMSA='IV.SECURITIES AND PARTICIPATION IN CAPITALS'
                     R_NOSAUKUMSA='5.Reserves'
                     R_NOSAUKUMSA='9.'
                     R_NOSAUKUMSA='I.LONG-TERM DEBTS'
                     R_NOSAUKUMSA='II.SHORT-TERM DEBTS'
                  .
                  EXECUTE V#
                     R_NOSAUKUMS='I Nemateriâlie ieguldîjumi'
                     R_NOSAUKUMS='II Pamatlîdzekïi'
                     R_NOSAUKUMS='III Ieguldîjuma îpaðumi'
                     R_NOSAUKUMS='IV Bioloìiskie aktîvi'
                     R_NOSAUKUMS='V Ilgtermiòa finansu ieguldîjumi'
                     R_NOSAUKUMS='I Krâjumi'
                     R_NOSAUKUMS='II Pârdoðanai turçti ilgtermiòa ieguldîjumi'
                     R_NOSAUKUMS='III Debitori'
                     R_NOSAUKUMS='IV Îstermiòa finansu ieguldîjumi'
                     R_NOSAUKUMS='5.Rezerves'
                     R_NOSAUKUMS='9.Nesadalîtâ peïòa'
                     R_NOSAUKUMS='I Ilgtermiòa kreditori'
                     R_NOSAUKUMS='II Îstermiòa kreditori'
                  .
                  IF F:DBF = 'W'
                     PRINT(RPT:VIRSRAKSTSB)
                  ELSE
                     OUTA:LINE=CHR(9)&CHR(9)&R_NOSAUKUMS&CHR(9)&R_NOSAUKUMSA
                     ADD(OUTFILEANSI)
                  .
               .
            ELSIF KONR:UGP='N'  !NAUDAS PLÛSMA
               IF (KONR:KODS=230 OR KONR:KODS=330 OR KONR:KODS=410)    !LIELÂS SADAÏU KOPSUMMAS
                  BOLD#=TRUE
               ELSIF(KONR:KODS=420)                              !IEZAKS
                  BOLD#=TRUE
               ELSIF(KONR:KODS=430)                              !PG NETO NAUDAS PLÛSMA
                  BOLD#=TRUE
               ELSIF(KONR:KODS=440)                              !NAUDA SÂKUMÂ
                  BOLD#=TRUE
               ELSIF(KONR:KODS=450)                              !NAUDA BEIGÂS
                  BOLD#=TRUE
               .
            ELSIF KONR:UGP='K'  !PAÐU KAPITÂLS
               V#=INSTRING(FORMAT(KONR:KODS,@N04),'0010010001900280037004601000',4) !PIRMS ÐITIEM VAJAG VIRSRAKSTU
               IF V#
                  EXECUTE(V#)
                     R_NOSAUKUMS='1. Akciju vai daïu kapitâls(pamatkapitâls)'
                     R_NOSAUKUMS='2. Akciju(daïu) emisijas uzcenojums'
                     R_NOSAUKUMS='3. Ilgtermiòa ieguldîjumu pârvçrtçðanas rezerves'
                     R_NOSAUKUMS='4. Finanðu instrumentu pârvçrtçðana'
                     R_NOSAUKUMS='5. Rezerves'
                     R_NOSAUKUMS='6. Nesadalîtâ peïòa'
                     R_NOSAUKUMS='7. Paðu kapitâls'
                  .
                  R_NOSAUKUMSA=''
                  IF F:DBF = 'W'
                     PRINT(RPT:VIRSRAKSTSB)
                  ELSE
                     OUTA:LINE=CHR(9)&CHR(9)&R_NOSAUKUMS&CHR(9)&R_NOSAUKUMSA
                     ADD(OUTFILEANSI)
                  .
               .
            .
            IF F:DBF='W'
               IF BOLD#=TRUE
                  PRINT(RPT:DETAILB)
               ELSE
                  PRINT(RPT:DETAIL)
               .
            ELSIF F:DBF='E'
               OUTA:LINE=KONR:KODS&CHR(9)&KONR:USER&CHR(9)&KONR:NOSAUKUMS&CHR(9)&KONR:NOSAUKUMSA
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
  IF SEND(KON_R,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT)
       ENDPAGE(report)
    ELSE !WORD,EXCEL
       OUTA:LINE=''
       ADD(OUTFILEANSI)
    .
    CLOSE(ProgressWindow)
    IF F:DBF='W'   !WMF
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
  IF FilesOpened
    KON_R::Used -= 1
    IF KON_R::Used = 0 THEN CLOSE(KON_R).
  END
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
  IF ERRORCODE() OR (F:SADALA AND ~(F:SADALA=KONR:UGP))
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'KON_R')
    END
    LocalResponse = RequestCancelled
    EXIT
  ELSE
    LocalResponse = RequestCompleted
  .
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

