                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PRETVI             PROCEDURE                    ! Declare Procedure
LI                   SHORT
PA                   SHORT
NPK               DECIMAL(4)
PKONTSK           DECIMAL(12,2)
KKONTS1           DECIMAL(12,2)
KKONTS2           DECIMAL(12,2)
KKONTS3           DECIMAL(12,2)
KKONTS4           DECIMAL(12,2)
DKKONTS1          DECIMAL(12,2)
DKKONTS2          DECIMAL(12,2)
DKKONTS3          DECIMAL(12,2)
DKKONTS4          DECIMAL(12,2)
KKKONTS1          DECIMAL(12,2)
KKKONTS2          DECIMAL(12,2)
KKKONTS3          DECIMAL(12,2)
KKKONTS4          DECIMAL(12,2)
KVKONTS1          DECIMAL(12,2)
KVKONTS2          DECIMAL(12,2)
KVKONTS3          DECIMAL(12,2)
KVKONTS4          DECIMAL(12,2)
LKONTS1           DECIMAL(12,2)
LKONTS2           DECIMAL(12,2)
LKONTS3           DECIMAL(12,2)
LKONTS4           DECIMAL(12,2)
KVNOS             STRING(3)
TS                STRING(12)
DAT               DATE
LAI               TIME

!R_TABLE           QUEUE,PRE(R)
!NOS               STRING(3)
!Pkonts1           DECIMAL(12,2)
!Pkonts2           DECIMAL(12,2)
!Pkonts3           DECIMAL(12,2)
!                  .
P_TABLE           QUEUE,PRE(P)
PAR_NR            ULONG
PAR_NOS_P         STRING(45)
Pkonts1           DECIMAL(12,2)
Pkonts2           DECIMAL(12,2)
Pkonts3           DECIMAL(12,2)
                  .
BKK               STRING(5)
RINDA             STRING(20)
VALUTA            BYTE
VALUTAP           BYTE
CG                STRING(10)
LINEH             STRING(190)

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

report REPORT,AT(200,1294,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,200,8000,1094),USE(?unnamed:2)
         STRING(@s1),AT(4531,833),USE(D_K1),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(3594,833),USE(D_K),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1042,7500,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(3490,781,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4427,781,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5365,781,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6302,781,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7552,781,0,313),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(417,781,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         STRING(@s45),AT(917,156,4531,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6823,573,625,156),PAGENO,USE(?PageCount),RIGHT
         STRING('Norçíini ar partneriem par pretstatîtiem kontiem'),AT(479,521,3646,208),USE(?String2), |
             CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(4167,521,740,208),USE(s_dat),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(4917,521,125,208),USE(?String4),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(5052,521,833,208),USE(b_dat),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,781,7500,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Npk'),AT(104,833),USE(?String7),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PARTNERIS  (Norçíinu persona)'),AT(521,833,2917,208),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(3854,833),USE(KKK),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(4802,833),USE(KKK1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(5458,823),USE(D_K2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(5760,833),USE(KKK2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ'),AT(6406,833),USE(?Stringkopa),TRN,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,781,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
DETAIL_LS DETAIL,AT(,,8000,177)
         LINE,AT(6302,-10,0,197),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,197),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@n4),AT(104,10,260,156),USE(NPK),RIGHT
         STRING(@N_5),AT(458,10,417,156),USE(P:PAR_NR),RIGHT
         STRING(@s45),AT(927,10,2552,156),USE(P:PAR_NOS_P)
         STRING(@n-_13.2b),AT(3542,10,833,156),USE(P:PKONTS1),RIGHT
         STRING(@n-_13.2b),AT(4479,10,833,156),USE(P:PKONTS2),RIGHT
         STRING(@n-_13.2b),AT(5417,10,833,156),USE(P:PKONTS3),RIGHT
         STRING(@n-_13.2b),AT(6354,10,833,156),USE(PKONTSK),RIGHT
         LINE,AT(5365,-10,0,197),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,197),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,197),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,197),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line2:8),COLOR(COLOR:Black)
       END
PER_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(52,-10,0,114),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,114),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,114),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,114),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,114),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,114),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,114),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(52,52,7500,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,615),USE(?unnamed)
         LINE,AT(7552,-10,0,635),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(52,52,7500,0),USE(?Line32),COLOR(COLOR:Black)
         STRING('KOPÂ :'),AT(177,104,,156),USE(?String20)
         STRING('D :'),AT(406,260,,156),USE(?String20:2)
         STRING(@n-_13.2b),AT(3542,104,833,156),USE(KKONTS1),RIGHT
         STRING('K :'),AT(406,417,,156),USE(?String20:3)
         STRING(@n-_13.2b),AT(3542,417,833,156),USE(KKKONTS1),RIGHT
         STRING(@n-_13.2b),AT(4469,417,833,156),USE(KKKONTS2),RIGHT
         STRING(@n-_13.2b),AT(5406,417,833,156),USE(KKKONTS3),RIGHT
         LINE,AT(3490,573,4063,0),USE(?Line33),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(5406,260,833,156),USE(DKKONTS3),RIGHT
         STRING(@n-_13.2b),AT(5406,104,833,156),USE(KKONTS3),RIGHT
         STRING(@n-_13.2b),AT(4469,260,833,156),USE(DKKONTS2),RIGHT
         STRING(@n-_13.2b),AT(4469,104,833,156),USE(KKONTS2),RIGHT
         STRING(@n-_13.2b),AT(3542,260,833,156),USE(DKKONTS1),RIGHT
         LINE,AT(6302,-10,0,635),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,635),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,635),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,635),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,635),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,62),USE(?Line26),COLOR(COLOR:Black)
       END
RPT_FOOTV DETAIL,AT(,,,177)
         LINE,AT(3490,-10,0,197),USE(?Line34:2),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,197),USE(?Line34:3),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,197),USE(?Line34:4),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,197),USE(?Line34:5),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,197),USE(?Line34:6),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line34),COLOR(COLOR:Black)
         STRING(@s12),AT(365,10,,156),USE(TS)
         STRING(@n-_13.2b),AT(3542,10,833,156),USE(KVKONTS1),RIGHT
         STRING(@n-_13.2b),AT(4479,10,833,156),USE(KVKONTS2),RIGHT
         STRING(@n-_13.2b),AT(5417,10,833,156),USE(KVKONTS3),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,,,219),USE(?unnamed:3)
         LINE,AT(52,-10,0,62),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,62),USE(?Line41:2),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,62),USE(?Line42:2),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,62),USE(?Line43:2),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,62),USE(?Line44:2),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,62),USE(?Line45:2),COLOR(COLOR:Black)
         LINE,AT(52,42,7500,0),USE(?Line46:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(94,63),USE(?String41),LEFT
         STRING(@s8),AT(635,63,625,177),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6396,63,604,177),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7021,63,490,177),USE(lai),FONT(,7,,,CHARSET:ANSI)
       END
PAGE_FOOT DETAIL,AT(,,,333)
         LINE,AT(5365,-10,0,270),USE(?Line49:3),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,270),USE(?Line49:4),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,270),USE(?Line49:5),COLOR(COLOR:Black)
         LINE,AT(52,52,7500,0),USE(?Line54),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(3542,104,833,156),USE(LKONTS1),RIGHT
         STRING(@n-_13.2b),AT(4479,104,833,156),USE(LKONTS2),RIGHT
         STRING(@n-_13.2b),AT(5417,104,833,156),USE(LKONTS3),RIGHT
         LINE,AT(52,260,7500,0),USE(?Line55),COLOR(COLOR:Black)
         STRING('KOPÂ pa lapu : '),AT(156,104,,156),USE(?String48),LEFT
         LINE,AT(4427,-10,0,270),USE(?Line49:2),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,270),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,62),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,270),USE(?Line49),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,10700,8000,52)
         LINE,AT(52,0,7500,0),USE(?Line56:22),COLOR(COLOR:Black)
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
  CHECKOPEN(GGK,1)
  CHECKOPEN(GG,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(KON_K,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('KKK',KKK)
  BIND('KKK1',KKK1)
  BIND('CYCLEBKK',CYCLEBKK)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND('D_K',D_K)
  BIND('D_K1',D_K1)
  VALUTA =0
  VALUTAP=0
  V# =0
  JJ#=0
!*************************** 1.solis ********************************
!  CHECKOPEN(VAL_K)
!  CLEAR(VAL:RECORD)
!  SET(VAL:NOS_KEY)
!  LOOP
!    NEXT(VAL_K)
!    IF ERROR() THEN BREAK.
!    R:NOS=VAL:VAL
!    R:PKONTS1 = 0
!    R:PKONTS2 = 0
!    R:PKONTS3 = 0
!    ADD(R_TABLE)
!  .
!  SORT(R_TABLE,R:NOS)
!*************************** 2.solis ********************************
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
  ProgressWindow{Prop:Text} = 'Norçíini par pretstatîtiem kontiem'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ggk:RECORD)
      GGK:DATUMS = S_DAT
      SET(GGK:DAT_KEY,GGK:DAT_KEY)
      CG='K100000'
      Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !W,E
        IF ~OPENANSI('PRETVI.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Norçíini ar partneriem par pretstâtîtiem kontiem '&format(S_DAT,@D06.)&' - '&format(B_DAT,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='NPK'&CHR(9)&'Partneris (Norçíinu persona)'&CHR(9)&CHR(9)&D_K&' '&KKK&CHR(9)&D_K1&' '&KKK1&CHR(9)&|
        D_K2&' '&KKK2&CHR(9)&'Kopâ'
        ADD(OUTFILEANSI)
      .
      GET(P_TABLE,0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)

!*************** SKAITAM Ls NO PERIODA SÂKUMA *****************
        IF (~CYCLEBKK(GGK:BKK,KKK) AND (GGK:D_K=D_K OR D_K='S') AND KKK) OR |
           (~CYCLEBKK(GGK:BKK,KKK1) AND (GGK:D_K=D_K1 OR D_K1='S') AND KKK1) OR |
           (~CYCLEBKK(GGK:BKK,KKK2) AND (GGK:D_K=D_K2 OR D_K2='S') AND KKK2)
           IF GGK:D_K='K'
              GGK:SUMMA=-GGK:SUMMA
           .
           GET(P_TABLE,0)
           P:PAR_NR=GGK:PAR_NR
           GET(P_TABLE,P:PAR_NR)
           IF ERROR()
              IF P:PAR_NR=0
                 P:PAR_NOS_P='Þ{45}'
              ELSE
                 P:PAR_NOS_P=GETPAR_K(P:PAR_NR,0,1)
              .
              P:PKONTS1=0
              P:PKONTS2=0
              P:PKONTS3=0
              ADD(P_TABLE)
              SORT(P_TABLE,P:PAR_NR)
              P:PAR_NR=GGK:PAR_NR
              GET(P_TABLE,P:PAR_NR)
           .
           IF KKK AND ~CYCLEBKK(GGK:BKK,KKK) AND (GGK:D_K=D_K OR D_K='S')
              P:PKONTS1 += ggk:summa
           .
           IF KKK1 AND ~CYCLEBKK(GGK:BKK,KKK1) AND (GGK:D_K=D_K1 OR D_K1='S')
              P:PKONTS2 += ggk:summa
           .
           IF KKK2 AND ~CYCLEBKK(GGK:BKK,KKK2) AND (GGK:D_K=D_K2 OR D_K2='S')
              P:PKONTS3 += ggk:summa
           .
           PUT(P_TABLE)
        .

OMIT('MARIS')
!********************* SKAITAM VAL NO PERIODA SÂKUMA *****************
        !El IF GGK:VAL <> 'Ls' OR GGK:VAL <> 'LVL'
        IF GGK:VAL <> val_uzsk
          VALUTA = 1
        .
        IF GGK:BAITS <> 1                               ! NAV IEZAKS
          GET(R_TABLE,0)
          R:NOS=GGK:VAL
          GET(R_TABLE,R:NOS)
          IF ERROR()
            KLUDA('16',GGK:u_NR)
            FREE(R_TABLE)
            FREE(P_TABLE)
            RETURN
          .
          CASE GGK:BKK
          OF KONTS1
            R:pKONTS1 += ggk:summav
          OF KONTS2
            R:pKONTS2 += ggk:summav
          OF KONTS3
            R:pKONTS3 += ggk:summav
          OF KONTS4
            R:pKONTS4 += ggk:summav
          .
          PUT(R_TABLE)
        .
 MARIS

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
!
    CASE FIELD()
    OF ?Progress:Cancel
      CASE Event()
      OF Event:Accepted
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  END

  SORT(P_TABLE,P:PAR_NOS_P)
  LOOP J# = 1 TO RECORDS(P_TABLE)
    GET(P_TABLE,J#)
    IF P:PKONTS1 OR P:PKONTS2 OR P:PKONTS3
        NPK+=1
        IF P:PAR_NOS_P='Þ{45}'
           P:PAR_NOS_P='Pârçjie'
           IF F:DBF = 'W'
               PRINT(RPT:PER_FOOT1)
           ELSE
           END
        .
        pKONTSK=P:pKONTS1+P:pKONTS2+P:pKONTS3
        IF P:PKONTS1 > 0
          DKKONTS1+=P:PKONTS1
        ELSE
          KKKONTS1+=ABS(P:PKONTS1)
        .
        IF P:PKONTS2 > 0
          DKKONTS2+=P:PKONTS2
        ELSE
          KKKONTS2+=ABS(P:PKONTS2)
        .
        IF P:PKONTS3 > 0
          DKKONTS3+=P:PKONTS3
        ELSE
          KKKONTS3+=ABS(P:PKONTS3)
        .
        IF ~F:DTK
            IF F:DBF = 'W'
                PRINT(RPT:DETAIL_LS)
            ELSE
                OUTA:LINE=FORMAT(NPK,@N4)&CHR(9)&FORMAT(P:PAR_NR,@N_5)&CHR(9)&CLIP(P:PAR_NOS_P)&CHR(9)&|
                LEFT(FORMAT(P:PKONTS1,@N-_13.2B))&CHR(9)&LEFT(FORMAT(P:PKONTS2,@N-_13.2B))&CHR(9)&|
                LEFT(FORMAT(P:PKONTS3,@N-_13.2B))&CHR(9)&LEFT(FORMAT(PKONTSK,@N-_13.2B))
                ADD(OUTFILEANSI)
            END
        END
    .
  .
  dat = today()
  lai = clock()

OMIT('MARIS')
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT)
  ELSIF F:DBF='E'
    OUTA:LINE=LINEH
    ADD(OUTFILEANSI)
    OUTA:LINE='Kopâ: {25}'&CHR(9)&CHR(9)&CHR(9)&FORMAT(KKONTS1,@N-_13.2)&CHR(9)&FORMAT(KKONTS2,@N-_13.2)&CHR(9)&|
    FORMAT(KKONTS3,@N-_13.2)&CHR(9)&FORMAT(KKONTS4,@N-_13.2)&CHR(9)&val_uzsk
    !El FORMAT(KKONTS3,@N-_13.2)&CHR(9)&FORMAT(KKONTS4,@N-_13.2)&CHR(9)&'Ls'
    ADD(OUTFILEANSI)
    OUTA:LINE='D {30}'&CHR(9)&CHR(9)&CHR(9)&FORMAT(DKKONTS1,@N-_13.2)&CHR(9)&FORMAT(DKKONTS2,@N-_13.2)&CHR(9)&|
    FORMAT(DKKONTS3,@N-_13.2)&CHR(9)&FORMAT(DKKONTS4,@N-_13.2)&CHR(9)&val_uzsk
    !El FORMAT(DKKONTS3,@N-_13.2)&CHR(9)&FORMAT(DKKONTS4,@N-_13.2)&CHR(9)&'Ls'
    ADD(OUTFILEANSI)
    OUTA:LINE='K {30}'&CHR(9)&CHR(9)&CHR(9)&FORMAT(KKKONTS1,@N-_13.2)&CHR(9)&FORMAT(KKKONTS2,@N-_13.2)&CHR(9)&|
    FORMAT(KKKONTS3,@N-_13.2)&CHR(9)&FORMAT(KKKONTS4,@N-_13.2)&CHR(9)&val_uzsk
    !El FORMAT(KKKONTS3,@N-_13.2)&CHR(9)&FORMAT(KKKONTS4,@N-_13.2)&CHR(9)&'Ls'
    ADD(OUTFILEANSI)
  ELSE
    OUTA:LINE=LINEH
    ADD(OUTFILEANSI)
    OUTA:LINE='Kopâ: {25}'&CHR(9)&CHR(9)&CHR(9)&FORMAT(KKONTS1,@N-_13.2B)&CHR(9)&FORMAT(KKONTS2,@N-_13.2B)&CHR(9)&|
    FORMAT(KKONTS3,@N-_13.2B)&CHR(9)&FORMAT(KKONTS4,@N-_13.2B)&CHR(9)&val_uzsk
    !El FORMAT(KKONTS3,@N-_13.2B)&CHR(9)&FORMAT(KKONTS4,@N-_13.2B)&CHR(9)&'Ls'
    ADD(OUTFILEANSI)
    OUTA:LINE='D {30}'&CHR(9)&CHR(9)&CHR(9)&FORMAT(DKKONTS1,@N-_13.2B)&CHR(9)&FORMAT(DKKONTS2,@N-_13.2B)&CHR(9)&|
    FORMAT(DKKONTS3,@N-_13.2B)&CHR(9)&FORMAT(DKKONTS4,@N-_13.2B)&CHR(9)&val_uzsk
    !El FORMAT(DKKONTS3,@N-_13.2B)&CHR(9)&FORMAT(DKKONTS4,@N-_13.2B)&CHR(9)&'Ls'
    ADD(OUTFILEANSI)
    OUTA:LINE='K {30}'&CHR(9)&CHR(9)&CHR(9)&FORMAT(KKKONTS1,@N-_13.2B)&CHR(9)&FORMAT(KKKONTS2,@N-_13.2B)&CHR(9)&|
    FORMAT(KKKONTS3,@N-_13.2B)&CHR(9)&FORMAT(KKKONTS4,@N-_13.2B)&CHR(9)&val_uzsk
    !El FORMAT(KKKONTS3,@N-_13.2B)&CHR(9)&FORMAT(KKKONTS4,@N-_13.2B)&CHR(9)&'Ls'
    ADD(OUTFILEANSI)
  END
  IF VALUTA
     TS ='Tai skaitâ :'
     GET(R_TABLE,0)
     LOOP J# = 1 TO RECORDS(R_TABLE)
        GET(R_TABLE,J#)
        IF R:PKONTS1+R:PKONTS2+R:PKONTS3+R:PKONTS4 <> 0
          kvKONTS1 = R:PKONTS1
          kvKONTS2 = R:PKONTS2
          kvKONTS3 = R:PKONTS3
          kvKONTS4 = R:PKONTS4
          kvnos  = R:nos
          IF F:DBF = 'W'
            PRINT(RPT:RPT_FOOTV)
            LI+=1
          ELSIF F:DBF='E'
            OUTA:LINE=LINEH
            ADD(OUTFILEANSI)
            OUTA:LINE=FORMAT(TS,@S12)&CHR(9)&CHR(9)&CHR(9)&FORMAT(KVKONTS1,@N-_13.2)&CHR(9)&FORMAT(KVKONTS2,@N-_13.2)&|
            CHR(9)&FORMAT(KVKONTS3,@N-_13.2)&CHR(9)&FORMAT(KVKONTS4,@N-_13.2)&CHR(9)&KVNOS
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE=LINEH
            ADD(OUTFILEANSI)
            OUTA:LINE=FORMAT(TS,@S12)&CHR(9)&CHR(9)&CHR(9)&FORMAT(KVKONTS1,@N-_13.2B)&CHR(9)&FORMAT(KVKONTS2,@N-_13.2B)&|
            CHR(9)&FORMAT(KVKONTS3,@N-_13.2B)&CHR(9)&FORMAT(KVKONTS4,@N-_13.2B)&CHR(9)&KVNOS
            ADD(OUTFILEANSI)
          END
!          DO CHECK_PAGE
          ts = ''
        .
     .
  .
MARIS

  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT)
    PRINT(RPT:RPT_FOOT1)
    ENDPAGE(report)
  ELSE
    OUTA:LINE=CHR(9)&'Kopâ:'&CHR(9)&CHR(9)&LEFT(FORMAT(KKONTS1,@N-_13.2B))&CHR(9)&LEFT(FORMAT(KKONTS2,@N-_13.2B))&|
    CHR(9)&LEFT(FORMAT(KKONTS3,@N-_13.2B))
    ADD(OUTFILEANSI)
    OUTA:LINE=CHR(9)&'D:'&CHR(9)&CHR(9)&LEFT(FORMAT(DKKONTS1,@N-_13.2B))&CHR(9)&LEFT(FORMAT(DKKONTS2,@N-_13.2B))&|
    CHR(9)&LEFT(FORMAT(DKKONTS3,@N-_13.2B))
    ADD(OUTFILEANSI)
    OUTA:LINE=CHR(9)&'K:'&CHR(9)&CHR(9)&LEFT(FORMAT(KKKONTS1,@N-_13.2B))&CHR(9)&LEFT(FORMAT(KKKONTS2,@N-_13.2B))&|
    CHR(9)&LEFT(FORMAT(KKKONTS3,@N-_13.2B))
    ADD(OUTFILEANSI)
  END
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
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
!  FREE(R_TABLE)
  FREE(P_TABLE)
  IF FilesOpened
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
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
B_Partner1           PROCEDURE                    ! Declare Procedure
LI                   SHORT
PA                   SHORT
!SUMMA               DECIMAL(13,2)
SUMMAV               DECIMAL(15,2)
SUMMAK               DECIMAL(15,2)
NGG                  DECIMAL(5)
DOK_NR               STRING(14)
DATUMS               DATE
DAT                  DATE
LAI                  TIME
SATURS               STRING(50)
NOS                  STRING(3)
CG                   STRING(10)
RejectRecord         LONG
ggk_u_nr             LONG
Rakstsggk            byte
LINEH                STRING(190)
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
report REPORT,AT(200,1119,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,150,8000,969)
         STRING(@s45),AT(1302,104,4427,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7135,469),PAGENO,USE(?PageCount),RIGHT
         STRING('Norçíini ar :'),AT(1615,417),USE(?String29),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(2500,417,2656,208),USE(par:nos_p),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,677,0,313),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(469,677,0,313),USE(?Line5:3),COLOR(COLOR:Black)
         LINE,AT(1406,677,0,313),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(1927,677,0,313),USE(?Line5:7),COLOR(COLOR:Black)
         LINE,AT(4219,677,0,313),USE(?Line5:10),COLOR(COLOR:Black)
         LINE,AT(5052,677,0,313),USE(?Line5:11),COLOR(COLOR:Black)
         LINE,AT(6563,677,0,313),USE(?Line5:13),COLOR(COLOR:Black)
         LINE,AT(7813,677,0,313),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(52,677,7760,0),USE(?Line4:2),COLOR(COLOR:Black)
         STRING('Nr. GG'),AT(104,729),USE(?String3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta Nr.'),AT(521,729,885,208),USE(?String4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1458,729,469,208),USE(?String5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieraksta saturs'),AT(1979,729,2240,208),USE(?String6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dok.summa'),AT(4271,729,781,208),USE(?String7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('BKK  D/K'),AT(5104,729,573,208),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(5677,729,531,208),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6240,729,323,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa Valutâ'),AT(6615,729,1198,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,938,7760,0),USE(?Line4),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,198),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,198),USE(?Line5:2),COLOR(COLOR:Black)
         LINE,AT(1406,-10,0,198),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,198),USE(?Line5:6),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,198),USE(?Line5:8),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line5:9),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,198),USE(?Line5:14),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,198),USE(?Line5:12),COLOR(COLOR:Black)
         STRING(@N_5B),AT(104,10,,156),USE(NGG),LEFT
         STRING(@s14),AT(521,10,885,156),USE(DOK_NR),RIGHT
         STRING(@D5B),AT(1458,10,469,156),USE(DATUMS)
         STRING(@s40),AT(1979,10,2240,156),USE(SATURS)
         STRING(@N-_13.2B),AT(4271,10,729,156),USE(SUMMA),RIGHT
         STRING(@S5),AT(5104,10,365,156),USE(GGK:BKK)
         STRING(@s1),AT(5521,10,156,156),USE(GGK:D_K),CENTER
         STRING(@N-_15.2B),AT(5677,10,885,156),USE(GGK:SUMMA),RIGHT
         STRING(@N-_15.2B),AT(6615,10,885,156),USE(SUMMAV),RIGHT
         STRING(@s3),AT(7552,10,240,156),USE(val_NOS),LEFT
       END
GRP_FOOT1 DETAIL,AT(,,,10)
         LINE,AT(52,0,7760,0),USE(?Line4:5),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,563)
         LINE,AT(52,-10,0,271),USE(?Line5:26),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,63),USE(?Line5:27),COLOR(COLOR:Black)
         LINE,AT(1406,-10,0,63),USE(?Line5:22),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,63),USE(?Line5:15),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,63),USE(?Line5:16),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,271),USE(?Line5:19),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,271),USE(?Line5:23),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,271),USE(?Line5:17),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line4:4),COLOR(COLOR:Black)
         STRING('Apgrozîjums kopâ :'),AT(156,104,1083,156),USE(?String22),LEFT
         STRING(@n-_15.2),AT(4115,104,885,156),USE(SummaK),RIGHT
         LINE,AT(52,260,7760,0),USE(?Line4:3),COLOR(COLOR:Black)
         STRING('Sastadîja : '),AT(156,365,521,208),USE(?String25),LEFT
         STRING(@s8),AT(729,365,573,208),USE(ACC_kods),LEFT
         STRING(@d6),AT(6198,365,677,208),USE(dat)
         STRING(@t4),AT(7083,365),USE(lai)
         STRING(@s1),AT(1771,365,156,198),USE(RS),CENTER
         STRING('RS :'),AT(1510,365,240,198),USE(?String31)
       END
PAGE_FOOT DETAIL,AT(,,,104)
         LINE,AT(52,-10,0,63),USE(?Line5:35),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,63),USE(?Line5:36),COLOR(COLOR:Black)
         LINE,AT(1406,-10,0,63),USE(?Line5:25),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,63),USE(?Line5:24),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,63),USE(?Line5:20),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,63),USE(?Line5:21),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,63),USE(?Line5:31),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,63),USE(?Line5:18),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line4:6),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,11000,8000,52)
         LINE,AT(52,0,7760,0),USE(?Line4:7),COLOR(COLOR:Black)
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
  CHECKOPEN(GLOBAL)
  CHECKOPEN(SYSTEM)
  CHECKOPEN(GGK,1)
  CHECKOPEN(GG,1)
  CHECKOPEN(KON_K,1)
  dat = today()
  lai = clock()
  C#=0
  L#=0
  C#=GETPAR_K(PAR_NR,2,1)
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
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçju izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    BIND('S_DAT',S_DAT)
    BIND('B_DAT',B_DAT)
    BIND('PAR_NR',PAR_NR)
    BIND('CG',CG)
    BIND('CYCLEGGK',CYCLEGGK)
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ggk:RECORD)                              !MAKE SURE RECORD CLEARED
      GGK:PAR_NR=PAR_NR
      GGK:DATUMS=S_DAT
      SET(ggk:PAR_KEY,GGK:PAR_KEY)
      CG='K11'
!!      IF F:DBF='E'
!!         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
!!            LINEH[I#]=CHR(151)
!!         .
!!      ELSE
!!         LOOP I#=1 TO 190
!!            LINEH[I#]='-'
!!         .
!!      .
      Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !RTF
        IF ~OPENANSI('PARTNER1.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Norçíini ar: '&CLIP(PAR:NOS_P)&' '&format(S_DAT,@D06.)&' - '&format(B_DAT,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Nr.GG'&CHR(9)&'Dokumenta  Nr.'&CHR(9)&'Datums'&CHR(9)&'Ieraksta saturs'&CHR(9)&'Dokumenta Summa'&CHR(9)&'Konts'&CHR(9)&'D/K'&CHR(9)&'Summa Ls'&CHR(9)&'Summa valûtâ'
        ADD(OUTFILEANSI)
      .
!!!      PRINT(RPT:PAGE_HEAD)
   OF Event:Timer
      LOOP RecordsPerCycle TIMES
         IF GGK_U_NR=ggk:U_nr
            nk#+=1
            ?Progress:UserString{Prop:Text}=NK#
            DISPLAY(?Progress:UserString)
            TEKSTS=CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
            FORMAT_TEKSTS(55,'Arial',8,'')
            CASE RAKSTSGGK
            OF 2
              NGG=0
              DOK_NR=''
              DATUMS=0
              SATURS = F_TEKSTS[2]
              summa=0
            OF 3
              SATURS = F_TEKSTS[3]
            ELSE
              saturs=''
            .
            RAKSTSGGK+=1
         ELSE GG:U_NR=GGK:U_NR
              GET(GG,gg:NR_KEY)
              NGG=POINTER(GG:DAT_KEY)
!              IF CHECKPZ(1)
!                 DOK_NR=RIGHT(FORMAT(GG:DOK_NR,@N06))
!              ELSE
!                 IF GG:DOK_NR
!                    DOK_NR=RIGHT(GG:DOK_NR)
!                 ELSE
!                    DOK_NR=''
!                 .
!              .
              DOK_NR=GG:DOK_SENR
              TEKSTS=CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
              FORMAT_TEKSTS(55,'Arial',8,'')
              SATURS = F_TEKSTS[1]
              datums = GG:DATUMS
              summa = GG:summa
              RAKSTSGGK=2
         .
         !El IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
         IF ~(GGK:VAL=val_uzsk)
            SUMMAV=GGK:SUMMAV
            VAL_NOS=GGK:VAL
         ELSE
            SUMMAV=0
            VAL_NOS=''
         .
         GGK_U_NR=ggk:U_nr
         IF ~F:DTK
            IF F:DBF = 'W'
                PRINT(RPT:DETAIL)                            !  PRINT DETAIL LINES
            ELSE
                OUTA:LINE = FORMAT(NGG,@N_5B)&CHR(9)&CLIP(DOK_NR)&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&CLIP(SATURS)&CHR(9)&LEFT(FORMAT(SUMMA,@N-_15.2B))&CHR(9)&CLIP(GGK:BKK)&CHR(9)&GGK:D_K&CHR(9)&LEFT(FORMAT(GGK:SUMMA,@N-_15.2B))&CHR(9)&LEFT(FORMAT(SUMMAV,@N-_15.2B))&CHR(9)&VAL_NOS
                ADD(OUTFILEANSI)
            END
         END
         SUMMAK += summa
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
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT)                            !PRINT GRAND TOTALS
  ELSE
    OUTA:LINE='Apgrozîjums kopâ:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMAK,@N-_15.2B))
    ADD(OUTFILEANSI)
  END
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
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
!------------------------------------------------------------------------------
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
  IF ERRORCODE() OR ~(GGK:PAR_NR=PAR_NR)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
!----------------------------------------------------------------------
B_NorDokLim          PROCEDURE                    ! Declare Procedure
P_TABLE           QUEUE,PRE(P)
NOS_KEY              STRING(19)  !5+8+6  NOS+U_NR+DOK_DAT
PAR_NR               ULONG
DOK_SENR             STRING(14)
DATUMS               LONG
NORDAT               LONG
SUMMA                DECIMAL(12,2)
SUMMAV               DECIMAL(12,2)
VAL                  STRING(3)
                  .
NPK                  DECIMAL(4)
NOS_P                STRING(25)
NOS_PX               STRING(25)
NOS_PN               STRING(50)
SAM_SUMMA            DECIMAL(11,2)
SAM_SUMMAV           DECIMAL(11,2)
JAU_SAM_SUMMA        DECIMAL(11,2)
JAU_SAM_SUMMAV       DECIMAL(11,2)
SAM_DATUMS           LONG
Pav_K_SUMMA          DECIMAL(11,2)
SAM_K_SUMMA          DECIMAL(11,2)
PaR_K_SUMMA          DECIMAL(11,2)
Pav_T_SUMMA          DECIMAL(11,2)
SAM_T_SUMMA          DECIMAL(11,2)
PAR_T_SUMMA          DECIMAL(11,2)
K_KS                 DECIMAL(11,2)
T_KS                 DECIMAL(11,2)
P_DOK_SENR           STRING(14)
P_DATUMS             LONG
P_SUMMA              DECIMAL(12,2)
P_SUMMAV             DECIMAL(12,2)
P_NORDAT             LONG
P_VAL                STRING(3)
P_C_SUMMA            DECIMAL(11,2)
P_C_SUMMAV           DECIMAL(11,2)

K_TABLE            QUEUE,PRE(K)
KP_VAL               STRING(3)
KP_SUMMAV            DECIMAL(12,2)
KSam_SUMMAV          DECIMAL(12,2)
KP_C_SUMMAV          DECIMAL(12,2)
                   .
A_VAL                STRING(3)
DAT                  LONG
LAI                  TIME
A_SUMMA              DECIMAL(12,2)
V_SUMMA              DECIMAL(12,2)
CHECKSUMMA           DECIMAL(12,2)
FILTRS_TEXT0         STRING(100)
FILTRS_TEXT          STRING(100)
SAV_PAR_NR           ULONG
ATSK_V               BYTE
ATSK_V_TEXT          STRING(80)
CG                   STRING(10)
CP                   STRING(3)
KAV                  SHORT
KAV_UZ_B_DAT         SHORT
VAL                  STRING(3)
KS                   DECIMAL(11,2)
KSK                  DECIMAL(11,2)
MAKSAJUMI            BYTE
T_MAKSAJUMS          BYTE
B_DATUMS             LONG

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

Atsk_V_window WINDOW,AT(,,185,92),CENTER,GRAY
       OPTION('Norâdiet atskaites veidu'),AT(13,13,165,44),USE(ATSK_V),BOXED
         RADIO('P/Z , kas izrakstîtas periodâ'),AT(22,28),USE(?ATSK_V:Radio1),VALUE('1')
         RADIO('P/Z, kas jâapmaksâ periodâ'),AT(22,38),USE(?ATSK_V:Radio2),VALUE('2')
       END
       STRING('Apmaksu meklçt lîdz :'),AT(18,59),USE(?String1)
       ENTRY(@D06.B),AT(91,58,50,10),USE(B_DATUMS),LEFT(1)
       BUTTON('&OK'),AT(105,74,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(144,74,36,14),USE(?CancelButton)
     END

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

report REPORT,AT(100,1815,8000,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,198,8000,1615),USE(?unnamed)
         LINE,AT(2396,885,0,729),USE(?Line21:2),COLOR(COLOR:Black)
         LINE,AT(3323,885,0,729),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(4271,885,0,729),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(4792,885,0,729),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5313,885,0,729),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(6302,885,0,729),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(365,885,0,729),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(52,1563,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Summa  '),AT(6885,1146,550,208),USE(?String8:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kursu'),AT(6323,1250,521,156),USE(?String8:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('d.ð.'),AT(7573,1250,200,208),USE(?String8:25),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokum.'),AT(5656,1344,640,208),USE(?String8:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(-) pârm.'),AT(6885,1354,550,208),USE(?String8:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('svârst.'),AT(6323,1396,521,156),USE(?String8:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7531,885,0,729),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(7800,885,0,729),USE(?Line2:11),COLOR(COLOR:Black)
         STRING('Summa'),AT(5656,938,640,208),USE(?String8:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6854,885,0,729),USE(?Line2:10),COLOR(COLOR:Black)
         STRING('Parâda'),AT(6896,938,550,208),USE(?String8:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Zaud. no'),AT(6323,1094,521,156),USE(?String8:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Samaks.'),AT(4823,1042,469,208),USE(?String8:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5625,885,0,729),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Dok.'),AT(1917,1042,450,208),USE(?String8:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(3417,1042,800,208),USE(?String8:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Norçí.'),AT(4302,1042,469,208),USE(?String8:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(2583,1250,600,208),USE(?String8:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dat.'),AT(1917,1250,450,208),USE(?String8:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc P/Z'),AT(3417,1250,800,208),USE(?String8:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(4302,1250,469,208),USE(?String8:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(4823,1250,469,208),USE(?String8:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('d.'),AT(5344,1250,260,208),USE(?String8:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc apm.'),AT(5656,1146,640,208),USE(?String8:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(2479,1042,800,208),USE(?String8:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1552,104,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Kav.'),AT(5344,1042,260,208),USE(?String8:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kav.'),AT(7552,1042,240,208),USE(?String8:24),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Norçíini par precçm (pakalpojumiem) konts :'),AT(2125,365),USE(?String2),RIGHT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(5135,365),USE(kkk),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieòem./'),AT(6323,938,521,156),USE(?String8:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(52,521,7552,208),USE(FILTRS_TEXT0),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7260,719,,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s100),AT(281,677,6990,208),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,885,7760,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Npk'),AT(104,1125),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòçmçjs (Pârdevçjs)'),AT(396,1135,1458,156),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1875,885,0,729),USE(?Line21:3),COLOR(COLOR:Black)
         LINE,AT(52,885,0,729),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:5)
         STRING(@n4B),AT(83,10,260,156),USE(npk),LEFT
         STRING(@S25),AT(417,10,1458,156),USE(NOS_P),LEFT
         STRING(@S14),AT(2427,10,885,156),USE(P_DOK_SENR),RIGHT
         STRING(@D05.B),AT(1927,10,469,156),USE(P_DATUMS)
         STRING(@N-_11.2B),AT(3354,10,625,156),USE(P_SUMMA),RIGHT
         STRING(@D05.B),AT(4302,10,469,156),USE(P_NORDAT)
         STRING(@D05.B),AT(4823,10,469,156),USE(SAM_DATUMS)
         STRING(@N-_11.2B),AT(5656,10,625,156),USE(Sam_SUMMA),RIGHT
         STRING(@N-_11.2B),AT(6885,10,625,156),USE(P_C_SUMMA),RIGHT
         STRING(@N-_4B),AT(7563,10,220,156),USE(KAV_UZ_B_DAT),TRN,RIGHT
         STRING(@s3),AT(4010,10,260,156),USE(val_uzsk),CENTER
         STRING(@N-_4B),AT(5344,10,260,156),USE(KAV),RIGHT
         STRING(@N-_8.2B),AT(6333,10,500,156),USE(KS),RIGHT
         LINE,AT(52,0,0,177),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(365,0,0,177),USE(?Line5:2),COLOR(COLOR:Black)
         LINE,AT(1875,0,0,177),USE(?Line5:3),COLOR(COLOR:Black)
         LINE,AT(2396,0,0,177),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(3323,0,0,177),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,177),USE(?Line5:7),COLOR(COLOR:Black)
         LINE,AT(4792,0,0,177),USE(?Line5:12),COLOR(COLOR:Black)
         LINE,AT(5313,0,0,177),USE(?Line5:11),COLOR(COLOR:Black)
         LINE,AT(5625,0,0,177),USE(?Line5:10),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,177),USE(?Line5:9),COLOR(COLOR:Black)
         LINE,AT(6854,0,0,177),USE(?Line5:8),COLOR(COLOR:Black)
         LINE,AT(7531,0,0,177),USE(?Line5:20),COLOR(COLOR:Black)
         LINE,AT(7800,0,0,177),USE(?Line5:21),COLOR(COLOR:Black)
       END
detailV DETAIL,AT(,,,177),USE(?unnamed:7)
         LINE,AT(52,0,0,177),USE(?Line5:15),COLOR(COLOR:Black)
         LINE,AT(365,0,0,177),USE(?Line5:25),COLOR(COLOR:Black)
         LINE,AT(1875,0,0,177),USE(?Line5:14),COLOR(COLOR:Black)
         LINE,AT(2396,0,0,177),USE(?Line5:16),COLOR(COLOR:Black)
         LINE,AT(3323,0,0,177),USE(?Line5:6),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,177),USE(?Line5:17),COLOR(COLOR:Black)
         LINE,AT(4792,0,0,177),USE(?Line5:75),COLOR(COLOR:Black)
         LINE,AT(5313,0,0,177),USE(?Line5:85),COLOR(COLOR:Black)
         LINE,AT(5625,0,0,177),USE(?Line5:95),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,177),USE(?Line5:105),COLOR(COLOR:Black)
         LINE,AT(6854,0,0,177),USE(?Line5:115),COLOR(COLOR:Black)
         LINE,AT(7531,0,0,177),USE(?Line5:116),COLOR(COLOR:Black)
         LINE,AT(7800,0,0,177),USE(?Line5:22),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(3354,10,625,156),USE(P_SUMMAV),RIGHT
         STRING(@s3),AT(4010,10,,156),USE(P_VAL),CENTER
         STRING('t.s.'),AT(1615,10,,156),USE(?String68)
         STRING(@N-_11.2B),AT(5656,10,625,156),USE(Sam_SUMMAV),RIGHT
         STRING(@N-_11.2B),AT(6885,10,625,156),USE(P_C_SUMMAV),RIGHT
       END
detailN DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(3323,0,0,177),USE(?Line55:3),COLOR(COLOR:Black)
         LINE,AT(365,0,0,177),USE(?Line55:2),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,177),USE(?Line55:7),COLOR(COLOR:Black)
         LINE,AT(4792,0,0,177),USE(?Line55:12),COLOR(COLOR:Black)
         LINE,AT(7800,0,0,177),USE(?Line55:4),COLOR(COLOR:Black)
         LINE,AT(5313,0,0,177),USE(?Line55:11),COLOR(COLOR:Black)
         LINE,AT(5625,0,0,177),USE(?Line55:10),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,177),USE(?Line55:9),COLOR(COLOR:Black)
         LINE,AT(6854,0,0,177),USE(?Line55:8),COLOR(COLOR:Black)
         LINE,AT(7531,0,0,177),USE(?Line55:20),COLOR(COLOR:Black)
         LINE,AT(52,0,0,177),USE(?Line55),COLOR(COLOR:Black)
         STRING(@S50),AT(417,10,2880,156),USE(NOS_PN),LEFT
         STRING(@N-_11.2B),AT(6885,10,625,156),USE(P_C_SUMMA,,?P_C_SUMMA:2),RIGHT
         STRING(@N-_11.2B),AT(5656,10,625,156),USE(Sam_SUMMA,,?Sam_SUMMA:2),RIGHT
         STRING(@D05.B),AT(4823,10,469,156),USE(SAM_DATUMS,,?SAM_DATUMS:2)
       END
detailK DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(52,0,0,177),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(365,0,0,177),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(2396,0,0,177),USE(?Line23:3),COLOR(COLOR:Black)
         LINE,AT(3323,0,0,177),USE(?Line23:4),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,177),USE(?Line23:6),COLOR(COLOR:Black)
         LINE,AT(4792,0,0,177),USE(?Line23:7),COLOR(COLOR:Black)
         LINE,AT(5313,0,0,177),USE(?Line23:8),COLOR(COLOR:Black)
         LINE,AT(5625,0,0,177),USE(?Line23:10),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,177),USE(?Line23:9),COLOR(COLOR:Black)
         LINE,AT(6854,0,0,177),USE(?Line23:12),COLOR(COLOR:Black)
         LINE,AT(7531,0,0,177),USE(?Line23:11),COLOR(COLOR:Black)
         LINE,AT(7800,0,0,177),USE(?Line23:13),COLOR(COLOR:Black)
         LINE,AT(1875,0,0,177),USE(?Line23:5),COLOR(COLOR:Black)
         STRING('Kopâ'),AT(469,10,281,156),USE(?String36),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(3354,10,625,156),USE(Pav_K_SUMMA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(5646,10,625,156),USE(Sam_K_SUMMA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_8.2B),AT(6333,10,469,156),USE(K_KS),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(6885,10,625,156),USE(PAR_K_SUMMA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4000,10,271,156),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detailKV DETAIL,AT(,,,177),USE(?unnamed:6)
         LINE,AT(52,0,0,177),USE(?Line5:515),COLOR(COLOR:Black)
         LINE,AT(365,0,0,177),USE(?Line5:525),COLOR(COLOR:Black)
         LINE,AT(1875,0,0,177),USE(?Line5:18),COLOR(COLOR:Black)
         LINE,AT(2396,0,0,177),USE(?Line5:19),COLOR(COLOR:Black)
         LINE,AT(3323,0,0,177),USE(?Line5:13),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,177),USE(?Line5:565),COLOR(COLOR:Black)
         LINE,AT(4792,0,0,177),USE(?Line5:575),COLOR(COLOR:Black)
         LINE,AT(5313,0,0,177),USE(?Line5:585),COLOR(COLOR:Black)
         LINE,AT(5625,0,0,177),USE(?Line5:595),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,177),USE(?Line5:5105),COLOR(COLOR:Black)
         LINE,AT(6854,0,0,177),USE(?Line5:5115),COLOR(COLOR:Black)
         LINE,AT(7531,0,0,177),USE(?Line5:5116),COLOR(COLOR:Black)
         LINE,AT(7800,0,0,177),USE(?Line5:23),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(3354,10,625,156),USE(K:KP_SUMMAV),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4010,10,,156),USE(K:KP_VAL),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(5646,10,625,156),USE(K:KSam_SUMMAV),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('t.s.'),AT(1615,10),USE(?String68:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(6885,10,625,156),USE(K:KP_C_SUMMAV),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
LINE   DETAIL,AT(,,,0),USE(?LINE)
         LINE,AT(52,0,7760,0),USE(?Line1:L),COLOR(COLOR:Black)
       END
REP_FOOT DETAIL,AT(,,,625),USE(?unnamed:2)
         LINE,AT(365,0,0,437),USE(?Line133:15),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,437),USE(?Line133:3),COLOR(COLOR:Black)
         LINE,AT(4792,0,0,437),USE(?Line133:4),COLOR(COLOR:Black)
         LINE,AT(5313,0,0,437),USE(?Line133:12),COLOR(COLOR:Black)
         LINE,AT(5625,0,0,437),USE(?Line133:17),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,437),USE(?Line133:13),COLOR(COLOR:Black)
         LINE,AT(6854,0,0,437),USE(?Line133:132),COLOR(COLOR:Black)
         LINE,AT(7531,0,0,437),USE(?Line133:14),COLOR(COLOR:Black)
         LINE,AT(7800,0,0,437),USE(?Line133:2),COLOR(COLOR:Black)
         STRING('Pavisam:'),AT(469,104,,156),USE(?String36:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(3354,104,625,156),USE(PAV_T_SUMMA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(6885,104,625,156),USE(PAR_T_SUMMA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,427,7760,0),USE(?Line43:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(52,438),USE(?String46),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(510,438),USE(ACC_kods),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING('RS:'),AT(1167,438),USE(?String96),FONT(,7,,,CHARSET:ANSI)
         STRING(@S1),AT(1333,438),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6646,438),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7292,438),USE(lai),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(2396,0,0,62),USE(?Line160),COLOR(COLOR:Black)
         LINE,AT(3323,0,0,62),USE(?Line159),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(5646,104,625,156),USE(Sam_T_SUMMA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_8.2B),AT(6333,104,469,156),USE(T_KS),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,52,7760,0),USE(?Line143),COLOR(COLOR:Black)
         LINE,AT(1875,0,0,62),USE(?Line160:2),COLOR(COLOR:Black)
         LINE,AT(52,0,0,437),USE(?Line133:16),COLOR(COLOR:Black)
       END
       FOOTER,AT(100,11160,8000,0)
         LINE,AT(52,0,7760,0),USE(?Line43:3),COLOR(COLOR:Black)
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
  B_DATUMS=B_DAT
  open(Atsk_V_window)
  ATSK_V=1
  ?ATSK_V:Radio1{prop:text}='P/Z, kas izrakstîtas '&format(s_dat,@d06.)&'-'&format(b_dat,@d06.)
  ?ATSK_V:Radio2{prop:text}='P/Z, kas jâapmaksâ '&format(s_dat,@d06.)&'-'&format(b_dat,@d06.)
  display
  ACCEPT
     CASE FIELD()
     OF ?OKBUTTON
        IF EVENT()=EVENT:ACCEPTED
           LocalResponse = RequestCompleted
           BREAK
        .
     OF ?CANCELBUTTON
        IF EVENT()=EVENT:ACCEPTED
           LocalResponse = RequestCancelled
           BREAK
        .
     .
  .
  CLOSE(Atsk_V_window)
  IF LocalResponse = RequestCancelled
     RETURN
  .
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF KKK[1] < '3'
     D_K='D'
  ELSE
     D_K='K'
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('CG',CG)
  BIND('KKK',KKK)
  BIND('CP',CP)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Norçíini ar Deb/Kred dokumentu lîmenî'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')

  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      EXECUTE ATSK_V
         FILTRS_TEXT0='Izrakstîtâs P/Z periodâ: '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&' uz '&FORMAT(B_DATUMS,@D06.)
         FILTRS_TEXT0='Jânorçíinâs par P/Z periodâ: '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&' uz '&FORMAT(B_DATUMS,@D06.)
      .
      FILTRS_TEXT=GETFILTRS_TEXT('011100000') !1-OBj,2-NOd,3-ParTips,4-ParGr,5-NOM,6-NTips,7-DN,8-(1:parâdi),9-ID
!                                 123456789
!      IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
      IF F:DTK THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Tikai nesamaksâtâs'.
!      IF PAR_NR=999999999 !VISI
!        IF PAR_GRUPA
!          IF F:NOT_GRUPA
!             FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Izòemot grupu: '&PAR_GRUPA
!          ELSE
!             FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa: '&PAR_GRUPA
!          .
!        .
!        IF ~(PAR_TIPS='EFCNIR')
!          FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Partnera tips: '&par_tips
!        .
!      ELSE
!        FILTRS_TEXT=CLIP(FILTRS_TEXT)&' '&getpar_k(par_nr,2,2)
!      .

      CLEAR(ggk:RECORD)
      GGK:BKK=KKK
      SET(GGK:BKK_DAT)
      CG='K103001'!GGK,RS,GGK:DATUMS,D_K,PVN_TIPS,OBJEKTS,NODAÏA
      !   1234567
      CP='K11'
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
          IF ~OPENANSI('NORDL.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='NORÇÍINI PAR PRECÇM (PAKALPOJUMIEM). KONTS '&KKK
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT0
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE=' Npk'&CHR(9)&'Saòçmçjs (Pârdevçjs)'&CHR(9)&' Dokumenta'&CHR(9)&' Dokumenta'&CHR(9)&'Summa pçc'&|
             CHR(9)&CHR(9)&'Norçíina'&CHR(9)&'Samaksas'&CHR(9)&'Kavçjums'&CHR(9)&' Summa pçc'&CHR(9)&'Ien./zaud.'&CHR(9)&|
             'Parâda summa, '&val_uzsk&CHR(9)&'Dienas uz '
             !El 'Parâda summa, Ls'&CHR(9)&'Dienas uz '
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&CHR(9)&' datums'&CHR(9)&' numurs'&CHR(9)&' P/Z, valûtâ'&CHR(9)&|
             CHR(9)&' datums'&CHR(9)&' datums'&CHR(9)&CHR(9)&'apm.dokumenta'&CHR(9)&'no kursu svâr.'&CHR(9)&'(-)pârmaksa'&|
             CHR(9)&FORMAT(B_DATUMS,@D06.)
             ADD(OUTFILEANSI)
             OUTA:LINE=''
             ADD(OUTFILEANSI)
          ELSE !WORDAM VIENÂ RINDÂ MAX 256
             OUTA:LINE=' Npk'&CHR(9)&'Saòçmçjs (Pârdevçjs)'&CHR(9)&'Dokumenta datums'&CHR(9)&'Dokumenta numurs'&CHR(9)&|
             'Summa pçc P/Z, valûtâ'&CHR(9)&CHR(9)&'Norçíina datums'&CHR(9)&'Samaksas datums'&CHR(9)&'Kavçjuma dienas'&|
             CHR(9)&'Summa pçc apm.dokum.'&CHR(9)&'Ieò./zaud. no kursu svârst.'&CHR(9)&'Parâda summa, '&val_uzsk&'(-pârmaksa)'&|
             CHR(9)&'Kavçjums uz '&FORMAT(B_DATUMS,@D06.)
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLEBKK(GGK:BKK,KKK) AND ~CYCLEGGK(CG) AND ~CYCLEPAR_K(CP) AND ~BAND(ggk:BAITS,00000001b) !&~IEZAKS
            IF ~GETGG(GGK:U_NR)
               KLUDA(5,'GGK:U_NR:'&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
            .
            IF GGK:REFERENCE AND GGK:SUMMA<0  !STORNO
               LOOP I#= 1 TO RECORDS(P_TABLE)
                  GET(P_TABLE,I#)
                  IF P:DOK_SENR=GGK:REFERENCE AND P:PAR_NR=GGK:PAR_NR
                     P:SUMMA+=GGK:SUMMA
                     P:SUMMAV+=GGK:SUMMAV
                     PUT(P_TABLE)
                     BREAK
                  .
               .
            ELSE                               !NORMÂLA P/Z(RÇÍINS)
               P:PAR_NR=GGK:PAR_NR
!               STOP(P:PAR_NR&' '&GGK:PAR_NR)
               P:NOS_KEY=SUB(GETPAR_K(GGK:PAR_NR,2,14),1,5)&FORMAT(P:PAR_NR,@N_8)&FORMAT(GGK:DATUMS,@D11)
!               STOP(P:NOS_KEY)
               IF GGK:U_NR=1                     !SALDO
                  P:DOK_SENR=GGK:REFERENCE
                  P:NORDAT=GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,1)
               ELSE
                  P:DOK_SENR=GG:DOK_SENR
                  P:NORDAT=GG:APMDAT
               .
               IF ~P:NORDAT THEN P:NORDAT=GG:DATUMS.
               P:DATUMS=GGK:DATUMS
               P:SUMMA=GGK:SUMMA
               P:SUMMAV=GGK:SUMMAV
               P:VAL=GGK:VAL
               ADD(P_TABLE)
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

!---------P_TABLÇ TAGAD IR VISAS P/Z PARTNERIM(GRUPAI) 231/531 KONTAM(KONTIEM)-----------------
  SORT(P_TABLE,P:NOS_KEY)
  SAV_PAR_NR=0
  IF KKK[1] < '3'
     D_K='K'      !APMAKSA A_TABLÇ UZ INVERSAJIEM
  ELSE
     D_K='D'
  .
  GET(P_TABLE,0)
  LOOP P#= 1 TO RECORDS(P_TABLE)
     GET(P_TABLE,P#)
     IF P#=1
        IRRAKSTI#=FALSE
        SAV_PAR_NR=P:PAR_NR
        IMAGE#=PerfAtable(1,'','',RS,P:PAR_NR,'',0,0,F:NODALA,0,B_DATUMS)  !Uzbûvç apmaksas ðitam partnerim
     .
     IF ~(P:PAR_NR=SAV_PAR_NR)     !MAINÎJIES PARTNERIS
        DO PRINTNESAMAKSA          !par ðito vçl ir jâdomâ
        DO PRINTCLIENT
        IRRAKSTI#=FALSE            !PAGAIDÂM VÇL NEVIENS RAKSTS PAR JAUNO PAR_NR NAV IZDRUKÂTS
        SAV_PAR_NR=P:PAR_NR
        IMAGE#=PerfAtable(1,'','',RS,P:PAR_NR,'',0,0,F:NODALA,0,B_DATUMS)  !Uzbûvç apmaksas
     .
     DO PRINTSAMAKSA
  .
  DO PRINTNESAMAKSA
  DO PRINTCLIENT
  dat = today()
  lai = clock()
  PAR_T_SUMMA=PAV_T_SUMMA-SAM_T_SUMMA-T_KS
  IF F:DBF='W'
      PRINT(RPT:REP_FOOT)
  ELSE
      OUTA:LINE=CHR(9)&'PAVISAM:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(PAV_T_SUMMA,@N-_11.2B))&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
      LEFT(FORMAT(SAM_T_SUMMA,@N-_11.2B))&CHR(9)&LEFT(FORMAT(T_KS,@N-_11.2B))&CHR(9)&LEFT(FORMAT(PAR_T_SUMMA,@N-_11.2B))
      ADD(OUTFILEANSI)
  END
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'   !WMF
       ENDPAGE(report)
    ELSE
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
  FREE(A_TABLE)
  FREE(P_TABLE)
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
  IF ERRORCODE() OR CYCLEBKK(GGK:BKK,KKK)=2
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

!-------------------------------------------------------------------------
PrintSamaksa ROUTINE
   IF (ATSK_V=1 AND INRANGE(P:DATUMS,S_DAT,B_DAT)) OR (ATSK_V=2 AND INRANGE(P:NORDAT,S_DAT,B_DAT))
   ! P/Z TRÂPA PIEPRASÎTAJÂ APGABALÂ
       JADRUKA#=TRUE
       SAM_SUMMA=0
       SAM_SUMMAV=0
       MAKSAJUMI=0
       GET(A_TABLE,0)
       LOOP I#= 1 TO RECORDS(A_TABLE)
          GET(A_TABLE,I#)
          IF ~(A:REFERENCE=P:DOK_SENR AND A:DATUMS<=B_DATUMS) THEN CYCLE.
          SAM_SUMMAV+=A:SUMMAV      !LAI UZZINÂTU, VAI PA VISIEM LÂGIEM IR SAMAKSÂTS KOPÂ VISS
          SAM_SUMMA +=A:SUMMA       !PRIEKÐ TOTALS
          MAKSAJUMI+=1              !LAI UZZINÂTU, CIK MAKSÂJUMU TRANZAKCIJAS IR BIJUÐAS ÐITAM DOKUMENTAM
       .
       IF P:SUMMAV=SAM_SUMMAV AND F:DTK !VISS SAMAKSÂTS,NEBÛS JÂDRUKÂ
          JADRUKA#=FALSE
          DO NULLA_TABLE
          DO TOTALS
          DO SAMTOTALS
       .
       IF JADRUKA#=TRUE
          FOUND#   =FALSE
          NPK#+=1
          NPK=NPK#
          P_DOK_SENR =P:DOK_SENR
          P_DATUMS =P:DATUMS
          P_SUMMA  =P:SUMMA
          P_SUMMAV =P:SUMMAV
          P_NORDAT =P:NORDAT
          P_VAL    =P:VAL
          NOS_P=SAV_PAR_NR&' '&GETPAR_K(SAV_PAR_NR,2,1)
          NOS_PX=SAV_PAR_NR&CHR(9)&GETPAR_K(SAV_PAR_NR,2,1)
          DO TOTALS
          SAM_SUMMA =0
          SAM_SUMMAV=0
          SAM_DATUMS=0
          KS=0
          KAV=B_DATUMS-P_NORDAT
          KAV_UZ_B_DAT=B_DATUMS-P_NORDAT
          T_MAKSAJUMS =0
          GET(A_TABLE,0)                       !MEKLÇJAM APMAKSAS
          LOOP I#= 1 TO RECORDS(A_TABLE)
             GET(A_TABLE,I#)
!             IF ~(A:REFERENCE=P:DOK_SENR) THEN CYCLE.
             IF ~(A:REFERENCE=P:DOK_SENR AND A:DATUMS<=B_DATUMS) THEN CYCLE.
             IF A:SUMMAV=0 THEN CYCLE.
             FOUND#=TRUE                       !VISMAZ KAUT KÂDA APMAKSA IR ATRASTA
             T_MAKSAJUMS+=1
             SAM_SUMMA =A:SUMMA
             SAM_SUMMAV=A:SUMMAV
             SAM_DATUMS=A:DATUMS
             KS=ROUND(A:SUMMAV*BANKURS(P:VAL,P:DATUMS),.01)-ROUND(A:SUMMAV*BANKURS(A:VAL,A:DATUMS),.01)  !IEZAKS
             JAU_SAM_SUMMA +=SAM_SUMMA+KS
             JAU_SAM_SUMMAV+=SAM_SUMMAV
             P_C_SUMMAV=P:SUMMAV-JAU_SAM_SUMMAV   !TEKOÐAIS PARÂDS UZ P/Z Valûtâ
             KAV=SAM_DATUMS-P:NORDAT
             KAV_UZ_B_DAT=0
             IF P_C_SUMMAV                        !KAUT KÂDS PARÂDS PALIEK ARÎ PÇC ÐÎ MAKSÂJUMA
                P_C_SUMMA=P:SUMMA-JAU_SAM_SUMMA   !TEKOÐAIS PARÂDS UZ P/Z Ls
                IF T_MAKSAJUMS=MAKSAJUMI          !TO CIPARU, CIKILGI TA MILAIS NEMAKSÂ, SPÎDINAM TIKAI PÇDÇJAM RAKSTAM
                   KAV_UZ_B_DAT=B_DATUMS-P:NORDAT
                .
                IF KAV_UZ_B_DAT<0 THEN KAV_UZ_B_DAT=0.
             ELSE
                P_C_SUMMA=0                       !TEKOÐAIS PARÂDS UZ P/Z Ls (CIRVIS)
             .
             DO SAMTOTALS
             DO PRINTDETAILS
             NOS_P=''                         !LAI NEATKÂRTO LÎDZ BEZGALÎBAI NOSAUKUMU
             NOS_PX=''
             A:SUMMA=0                        !NONULLÇJAM A_TABLI
             A:SUMMAV=0                       !NONULLÇJAM A_TABLI
             PUT(A_TABLE)
          .
       .
       IF FOUND#=FALSE            !NU VISPÂR NEKO NAV MAKSÂJIS BEZGODIS
          P_C_SUMMA =P:SUMMA
          P_C_SUMMAV=P:SUMMAV
          DO PRINTDETAILS
       .
       JAU_SAM_SUMMA =0
       JAU_SAM_SUMMAV=0
       P_C_SUMMA=0
    ELSE
    ! P/Z NETRÂPA PIEPRASÎTAJÂ APGABALÂ, BÛS JÂNONULLÇ A_TABLE
       DO NULLA_TABLE
    .

!-------------------------------------------------------------------------
TOTALS      ROUTINE
    PAV_K_SUMMA+=P:SUMMA
    PAV_T_SUMMA+=P:SUMMA

!-------------------------------------------------------------------------
SAMTOTALS      ROUTINE
    SAM_K_SUMMA+=SAM_SUMMA
    SAM_T_SUMMA+=SAM_SUMMA
    K_KS       +=KS
    T_KS       +=KS

!-------------------------------------------------------------------------
PRINTCLIENT    ROUTINE  !KOPÂ PAR KLIENTU
  IF IRRAKSTI#=TRUE     !KAUT VIENS DOKUMENTS PÇC VISIEM FILTRIEM IR IZDRUKÂTS
!     IF JADRUKA#=TRUE
        PAR_K_SUMMA=PAV_K_SUMMA-SAM_K_SUMMA-K_KS
   !    I#=GETPAR_K(SAV_PAR_NR,0,1)
        IF F:DBF='W'
            PRINT(RPT:DETAILK)
        ELSE
            OUTA:LINE=CHR(9)&'KOPÂ:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(PAV_K_SUMMA,@N-_11.2B))&CHR(9)&val_uzsk&' '&CHR(9)&CHR(9)&|
            CHR(9)&CHR(9)&LEFT(FORMAT(SAM_K_SUMMA,@N-_11.2B))&CHR(9)&LEFT(FORMAT(K_KS,@N-_11.2B))&CHR(9)&LEFT(FORMAT(PAR_K_SUMMA,@N-_11.2B))
            ADD(OUTFILEANSI)
        END
        IF RECORDS(K_TABLE)>1 OR VALUTAS#=TRUE
           LOOP I#=1 TO RECORDS(K_TABLE)
              GET(K_TABLE,I#)
              IF F:DBF='W'
                PRINT(RPT:DETAILKV)
              ELSE
                OUTA:LINE=CHR(9)&'t.s.'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(K:KP_SUMMAV,@N-_11.2B))&CHR(9)&K:KP_VAL&CHR(9)&CHR(9)&|
                CHR(9)&CHR(9)&LEFT(FORMAT(K:KSAM_SUMMAV,@N-_11.2B))&CHR(9)&CHR(9)&LEFT(FORMAT(K:KP_C_SUMMAV,@N-_11.2B))
                ADD(OUTFILEANSI)
              END
           .
        .
        PRINT(RPT:LINE)
        FREE(K_TABLE)
        VALUTAS#=FALSE
!     .
  .
  Pav_K_summa=0
  Sam_K_Summa=0
  PAR_K_SUMMA =0
  K_KS=0

!-------------------------------------------------------------------------
PRINTDETAILS      ROUTINE
    IF JADRUKA#=TRUE
       !El IF ~(P_VAL='Ls' OR P_VAL='LVL')
       IF ~(P_VAL=val_uzsk)
          VALUTAS#=TRUE
       .
       K:KP_VAL=P_VAL
       GET(K_TABLE,K:KP_VAL)
       IF ERROR()
          K:KP_SUMMAV=P_SUMMAV
          K:KSam_SUMMAV=Sam_SUMMAV
          K:KP_C_SUMMAV=P_SUMMAV-SAM_SUMMAV
          ADD(K_TABLE)
          SORT(K_TABLE,K:KP_VAL)
       ELSE
          K:KP_SUMMAV+=P_SUMMAV
          K:KSam_SUMMAV+=Sam_SUMMAV
          K:KP_C_SUMMAV+=(P_SUMMAV-SAM_SUMMAV)
          PUT(K_TABLE)
       .
       IF F:DBF='W'
          PRINT(RPT:DETAIL)
       ELSE
          OUTA:LINE=NPK&CHR(9)&NOS_P&CHR(9)&FORMAT(P_DATUMS,@D06.B)&CHR(9)&P_DOK_SENR&CHR(9)&|
          LEFT(FORMAT(P_SUMMA,@N-_11.2B))&CHR(9)&val_uzsk&CHR(9)&FORMAT(P_NORDAT,@D06.B)&CHR(9)&FORMAT(SAM_DATUMS,@D06.B)&|
          CHR(9)&FORMAT(KAV,@N-_4B)&CHR(9)&LEFT(FORMAT(SAM_SUMMA,@N-_11.2B))&CHR(9)&LEFT(FORMAT(KS,@N-_11.2B))&CHR(9)&|
          LEFT(FORMAT(P_C_SUMMA,@N-_11.2B))&CHR(9)&FORMAT(KAV_uz_b_dat,@N-_4B)
          ADD(OUTFILEANSI)
       END
       !El IF ~(P_VAL='Ls' OR P_VAL='LVL')
       IF ~(P_VAL=val_uzsk)
          IF F:DBF='W'
            PRINT(RPT:DETAILV)
          ELSE
            OUTA:LINE=CHR(9)&'t.s.'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(P_SUMMAV,@N-_11.2B))&CHR(9)&|
            P_VAL&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SAM_SUMMAV,@N-_11.2B))&CHR(9)&CHR(9)&|
            LEFT(FORMAT(P_C_SUMMAV,@N-_11.2B))
            ADD(OUTFILEANSI)
          END
       .
       IRRAKSTI#=TRUE
    .
    NPK=0
    P_DOK_SENR =''
    P_DATUMS =0
    P_SUMMA  =0
    P_SUMMAV =0
    P_NORDAT =0
!    P_VAL    =''

!-------------------------------------------------------------------------
PrintNESamaksa ROUTINE
  GET(A_TABLE,0)
  LOOP I#= 1 TO RECORDS(A_TABLE)       !NEPAZÎSTAMÂS APMAKSAS
     GET(A_TABLE,I#)
     IF A:SUMMA=0 THEN CYCLE.
     IF ~(A:DATUMS<=B_DATUMS) THEN CYCLE.
     !El NOS_PN=SAV_PAR_NR&' '&GETPAR_K(SAV_PAR_NR,2,1)&' Samaksa bez references Ls'
     NOS_PN=SAV_PAR_NR&' '&GETPAR_K(SAV_PAR_NR,2,1)&' Samaksa bez references '&val_uzsk
!     NOS_P=A:PAR_NR&' Samaksa bez references'
     NPK=0
     P_DOK_SENR=''
     P_DATUMS=0
     P_SUMMA=0
     P_NORDAT=0
     KAV=0
     KS=0
     SAM_SUMMA=A:SUMMA
     SAM_DATUMS=A:DATUMS
     P_C_SUMMA=-SAM_SUMMA
     IF F:DBF='W'
         PRINT(RPT:DETAILN)
     ELSE
         OUTA:LINE=CHR(9)&NOS_PN&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(SAM_DATUMS,@D06.B)&|
         CHR(9)&CHR(9)&LEFT(FORMAT(SAM_SUMMA,@N-_11.2B))&CHR(9)&CHR(9)&LEFT(FORMAT(P_C_SUMMA,@N-_11.2B))
         ADD(OUTFILEANSI)
     END
     DO SAMTOTALS
  .

!-------------------------------------------------------------------------
NULLA_TABLE     ROUTINE
       GET(A_TABLE,0)
       LOOP I#= 1 TO RECORDS(A_TABLE)
          GET(A_TABLE,I#)
          IF ~(A:REFERENCE=P:DOK_SENR) THEN CYCLE.
          A:SUMMA=0     !NONULLÇJAM A_TABLI
          A:SUMMAV=0    !NONULLÇJAM A_TABLI
          PUT(A_TABLE)
          IF ERROR() THEN STOP('NULLÇJOT A_TABLI:'&ERROR()).
       .
