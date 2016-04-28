                     MEMBER('winlats.clw')        ! This is a MEMBER module
P_VIDBILVERT         PROCEDURE                    ! Declare Procedure
B_TABLE              QUEUE,PRE(B)
KOEF                   DECIMAL(3,1)
SUMMAS                 DECIMAL(10,2)
SUMMA1                 DECIMAL(10,2)
SUMMA2                 DECIMAL(10,2)
SUMMA3                 DECIMAL(10,2)
SUMMAB                 DECIMAL(10,2)
SUMMAV                 DECIMAL(10,2)
SUMMAA                 DECIMAL(10,2)
                     .
N_TABLE              QUEUE,PRE(N)
NODALA                 STRING(2)
SUMMAS                 DECIMAL(10,2)
SUMMA1                 DECIMAL(10,2)
SUMMA2                 DECIMAL(10,2)
SUMMA3                 DECIMAL(10,2)
SUMMAB                 DECIMAL(10,2)
SUMMAV                 DECIMAL(10,2)
SUMMAA                 DECIMAL(10,2)
                     .
NODALA               STRING(2)
VERT_S               DECIMAL(11,2)
VERT_1               DECIMAL(11,2)
VERT_2               DECIMAL(11,2)
VERT_3               DECIMAL(11,2)
VERT_B               DECIMAL(11,2)
VERT_V               DECIMAL(11,2)
VERT_A               DECIMAL(11,2)
VERT_SK              DECIMAL(11,2)
VERT_1K              DECIMAL(11,2)
VERT_2K              DECIMAL(11,2)
VERT_3K              DECIMAL(11,2)
VERT_BK              DECIMAL(11,2)
VERT_VK              DECIMAL(11,2)
VERT_AK              DECIMAL(11,2)
StringKatNod         STRING(30)
GADS2                BYTE
GADS_B2              BYTE
KOPA                 STRING(6)
KOEF                 DECIMAL(3,1)
DAT                  LONG
LAI                  LONG
NodText              string(25)
VIRSRAKSTS           STRING(100)
C                    ULONG,DIM(4,2)
ATL_DATUMS1          LONG
ATL_DATUMS2          LONG
ATL_DATUMS3          LONG
ATL_DATUMS4          LONG
ATL_DATUMS5          LONG

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
Process:View         VIEW(PAMAT)
                       PROJECT(PAM:BIL_V)
                       PROJECT(PAM:BKK)
                       PROJECT(PAM:BKKN)
                       PROJECT(PAM:DATUMS)
                       PROJECT(PAM:DOK_SENR)
                       PROJECT(PAM:END_DATE)
                       PROJECT(PAM:IEP_V)
                       PROJECT(PAM:IZG_GAD)
                       PROJECT(PAM:KAP_V)
                       PROJECT(PAM:KAT)
                       PROJECT(PAM:LIN_G_PR)
                       PROJECT(PAM:NODALA)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:NOS_A)
                       PROJECT(PAM:NOS_P)
                       PROJECT(PAM:NOS_S)
                       PROJECT(PAM:U_NR)
                       PROJECT(PAM:ATB_NR)
                       PROJECT(PAM:SKAITS)
                     END

report REPORT,AT(146,1452,8021,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(146,150,8000,1302),USE(?unnamed)
         STRING(@s45),AT(1781,156,4375,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(229,469,7531,229),USE(VIRSRAKSTS),CENTER(4),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7188,729,531,177),PAGENO,USE(?PageCount),RIGHT
         STRING(@s30),AT(3021,729,1927,177),USE(StringKatNod),CENTER
         LINE,AT(104,1250,7760,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2552,990,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3281,990,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4010,990,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4740,990,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5469,990,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6198,990,0,313),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6927,990,0,313),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7135,990,0,313),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(7865,990,0,313),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@D06.),AT(2573,1042,698,208),USE(ATL_DATUMS1),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nr'),AT(156,1042,365,208),USE(?String9:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(469,1042,2083,208),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vid. bil. vçr.'),AT(6250,1042,677,208),USE(?String9:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('AK.'),AT(6979,1042,156,208),USE(?String9:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Apl. îp. vçrt.'),AT(7188,1042,677,208),USE(?String9:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(3323,1042,698,208),USE(ATL_DATUMS2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(4031,1042,698,208),USE(ATL_DATUMS3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(5490,1042,698,208),USE(ATL_DATUMS5),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(4760,1042,698,208),USE(ATL_DATUMS4),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,990,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(104,990,0,313),USE(?Line2),COLOR(COLOR:Black)
         STRING('Forma PL3'),AT(6354,729),USE(?String7),LEFT
       END
detail DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,197),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@N_6),AT(156,10,365,156),USE(PAM:U_NR),RIGHT
         STRING(@s32),AT(573,10,1927,156),USE(PAM:NOS_P),LEFT
         LINE,AT(2552,-10,0,197),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(2594,10,677,156),USE(VERT_S),RIGHT
         LINE,AT(3281,-10,0,197),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(3323,10,677,156),USE(VERT_1),RIGHT
         LINE,AT(4010,-10,0,197),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(4052,10,677,156),USE(VERT_2),RIGHT
         LINE,AT(4740,-10,0,197),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(4781,10,677,156),USE(VERT_3),RIGHT
         LINE,AT(5469,-10,0,197),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(5510,10,677,156),USE(VERT_B),RIGHT
         LINE,AT(6198,-10,0,197),USE(?Line2:17),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(6240,10,677,156),USE(VERT_V),RIGHT
         LINE,AT(6927,-10,0,197),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N3.1),AT(6969,10,156,156),USE(KAT:APLKOEF),RIGHT
         LINE,AT(7135,-10,0,197),USE(?Line2:19),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(7177,10,677,156),USE(VERT_A),RIGHT
         LINE,AT(7865,-10,0,197),USE(?Line2:20),COLOR(COLOR:Black)
       END
RepFoot2 DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(104,-10,0,197),USE(?Line7:11),COLOR(COLOR:Black)
         STRING(@s5),AT(177,10,313,156),USE(KOPA),LEFT
         STRING(@s2),AT(552,10,156,156),USE(NODALA),LEFT
         STRING(@N3.1),AT(2323,10,208,156),USE(KOEF),TRN,HIDE,RIGHT
         LINE,AT(2552,-10,0,197),USE(?Line7:12),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(2594,10,677,156),USE(VERT_SK),RIGHT
         LINE,AT(3281,-10,0,197),USE(?Line7:13),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(3323,10,677,156),USE(VERT_1K),RIGHT
         LINE,AT(4010,-10,0,197),USE(?Line7:14),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(4052,10,677,156),USE(VERT_2K),RIGHT
         LINE,AT(4740,-10,0,197),USE(?Line7:15),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(4781,10,677,156),USE(VERT_3K),RIGHT
         LINE,AT(5469,-10,0,197),USE(?Line7:16),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(5510,10,677,156),USE(VERT_BK),RIGHT
         LINE,AT(6198,-10,0,197),USE(?Line7:17),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(6240,10,677,156),USE(VERT_VK),RIGHT
         LINE,AT(6927,-10,0,197),USE(?Line7:18),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,197),USE(?Line7:19),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(7177,10,677,156),USE(VERT_AK),RIGHT
         LINE,AT(7865,-10,0,197),USE(?Line7:20),COLOR(COLOR:Black)
         STRING(@s25),AT(781,10,1719,156),USE(NodText),LEFT
       END
Line   DETAIL,AT(,,,0),USE(?unnamed:5)
         LINE,AT(104,0,7760,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RepFoot3 DETAIL,AT(,-10,,281),USE(?unnamed:2)
         LINE,AT(104,0,0,52),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(2552,0,0,52),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(3281,0,0,52),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,52),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,52),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(5469,0,0,52),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,52),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(6927,0,0,52),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,52),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,52),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(94,52,7760,0),USE(?Line111:3),COLOR(COLOR:Black)
         STRING(@D06.),AT(6875,83),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T1),AT(7510,83),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(146,10900,8000,73),USE(?unnamed:3)
         LINE,AT(104,0,7760,0),USE(?Line48:3),COLOR(COLOR:Black)
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

  DAT = TODAY()
  LAI = CLOCK()
  IF F:KAT_NR>'000' THEN StringKatNod='Kategorija: '&F:KAT_NR[1]&'-'&F:KAT_NR[2:3].
  IF F:NODALA THEN StringKatNod=clip(StringKatNod)&' Nodaïa: '&F:NODALA.
  VIRSRAKSTS = 'Ilgtermiòa ieguldîjumu  gada vidçjâs bilances vçrtîbas aprçíins '&FORMAT(S_DAT,@D06.)&|
  '-'&FORMAT(B_DAT,@D06.)&' (LIN.metode)'
  M#=MONTH(B_DAT)+1
  Y#=YEAR(B_DAT)
  B#=B_DAT
  LOOP C#=4 TO 1 BY -1
     C[C#,2]=B#
     M#-=3
     IF M#<=0
        M#+=12
        Y#-=1
     .
     C[C#,1]=DATE(M#,1,Y#)
     IF C[C#,1]<=S_DAT
        C[C#,1]=S_DAT
        BREAK
     .
     B#=C[C#,1]-1
     IF B#<=S_DAT THEN B#=S_DAT.
  .
  ATL_DATUMS1=C[1,1]
  ATL_DATUMS2=C[2,1]
  ATL_DATUMS3=C[3,1]
  ATL_DATUMS4=C[4,1]
  ATL_DATUMS5=C[4,2]+1

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF KAT_K::Used = 0
    CheckOpen(KAT_K,1)
  END
  KAT_K::Used += 1
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  BIND(PAM:RECORD)
  BIND('S_DAT',S_DAT)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Gada vidçjâ bilances vçrtîba'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAT,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(PAM:RECORD)
      SET(PAM:NR_KEY,PAM:NR_KEY)
      Process:View{Prop:Filter} = '~INRANGE(PAM:END_DATE,DATE(1,1,1900),S_DAT-1)' !NAV NOÒEMTS IEPR.G-OS
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
          IF ~OPENANSI('VIDBILVERT.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Nr'&CHR(9)&'Nosaukums'&CHR(9)&FORMAT(ATL_DATUMS1,@D06.)&CHR(9)&FORMAT(ATL_DATUMS2,@D06.)&CHR(9)&|
          FORMAT(ATL_DATUMS3,@D06.)&CHR(9)&FORMAT(ATL_DATUMS4,@D06.)&CHR(9)&FORMAT(ATL_DATUMS5,@D06.)&CHR(9)&|
          'Vid.bil.vçr.'&CHR(9)&'AK'&CHR(9)&'Apl.îp.vçrt.'
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF PAM:EXPL_DATUMS>=DATE(1,1,1995)
           START_GD#=YEAR(PAM:EXPL_DATUMS)
        ELSE
           START_GD#=1995
        .
        I#=0
        LOOP G#=START_GD# TO GADS
          I#+=1
        .
        IF I#
           VERT_S = 0
           VERT_1 = 0
           VERT_2 = 0
           VERT_3 = 0
           VERT_B = 0
           NODALA = ''
           IF ~CYCLEKAT(PAM:KAT[I#])
!           IF ~(F:KAT_NR>'000' AND ~(FORMAT(F:KAT_NR,@P#-##P)=PAM:KAT_NR[I#]))
              CLEAR(AMO:RECORD)
              AMO:U_NR=PAM:U_NR
              AMO:YYYYMM=ATL_DATUMS1
              GET(PAMAM,AMO:NR_KEY)
              IF ~ERROR() !NAV NOÒEMTS
                 VERT_S = AMO:SAK_V_LI-AMO:NOL_U_LI
                 NODALA = AMO:NODALA
              .
              AMO:YYYYMM=ATL_DATUMS2
              GET(PAMAM,AMO:NR_KEY)
              IF ~ERROR()
                 VERT_1 = AMO:SAK_V_LI-AMO:NOL_U_LI
                 NODALA = AMO:NODALA
              .
              AMO:YYYYMM=ATL_DATUMS3
              GET(PAMAM,AMO:NR_KEY)
              IF ~ERROR()
                 VERT_2 = AMO:SAK_V_LI-AMO:NOL_U_LI
                 NODALA = AMO:NODALA
              .
              AMO:YYYYMM=ATL_DATUMS4
              GET(PAMAM,AMO:NR_KEY)
              IF ~ERROR()
                 VERT_3 = AMO:SAK_V_LI-AMO:NOL_U_LI
                 NODALA = AMO:NODALA
              .
!              AMO:YYYYMM=DATE(12,1,GADS)
              AMO:YYYYMM=DATE(MONTH(B_DAT),1,YEAR(B_DAT))
              PED_MEN#=DATE(MONTH(B_DAT),1,YEAR(B_DAT))
              GET(PAMAM,AMO:NR_KEY)
              IF ~ERROR()
                 IF ~INRANGE(PAM:END_DATE,DPED_MEN#,B_DAT)     !NOÒEMTS PÇD.M.
                    IF INRANGE(PAM:EXPL_DATUMS,PED_MEN#,B_DAT) !IEGÂDÂTS PÇD.M.,NAV SÂK.V.
                       VERT_B = PAM:BIL_V   +AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI
                    ELSE
                       VERT_B = AMO:SAK_V_LI+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI-AMO:NOL_U_LI-AMO:NOL_LIN
                    .
                    NODALA = AMO:NODALA
                 .
              .
              CLEAR(KAT:RECORD)
              KAT:KAT=PAM:KAT[I#]
              GET(KAT_K,KAT:NR_KEY)
              IF ERROR() THEN KLUDA(88,'KATEGORIJA:'&FORMAT(PAM:KAT[I#],@P#-##P)&' '&PAM:NOS_P).
              DISPLAY
              VERT_V=((VERT_S+VERT_B)/2+VERT_1+VERT_2+VERT_3)/4
              VERT_A=VERT_V*KAT:APLKOEF
              IF F:DBF='W'
                PRINT(RPT:DETAIL)
              ELSE
                OUTA:LINE=FORMAT(PAM:U_NR,@N_6)&CHR(9)&PAM:NOS_P&CHR(9)&LEFT(FORMAT(VERT_S,@N_11.2))&CHR(9)&|
                LEFT(FORMAT(VERT_1,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_2,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_3,@N_11.2))&|
                CHR(9)&LEFT(FORMAT(VERT_B,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_V,@N_11.2))&CHR(9)&|
                LEFT(FORMAT(KAT:APLKOEF,@N_3.1))&CHR(9)&LEFT(FORMAT(VERT_A,@N_11.2))
                ADD(OUTFILEANSI)
              END
              VERT_SK += VERT_S
              VERT_1K += VERT_1
              VERT_2K += VERT_2
              VERT_3K += VERT_3
              VERT_BK += VERT_B
              VERT_VK += VERT_V
              VERT_AK += VERT_A

              B:KOEF =KAT:APLKOEF
              GET(B_TABLE,B:KOEF)
              IF ERROR()
                B:KOEF  =KAT:APLKOEF
                B:SUMMAS=VERT_S
                B:SUMMA1=VERT_1
                B:SUMMA2=VERT_2
                B:SUMMA3=VERT_3
                B:SUMMAB=VERT_B
                B:SUMMAV=VERT_V
                B:SUMMAA=VERT_A
                ADD(B_TABLE)
                SORT(B_TABLE,B:KOEF)
              ELSE
                B:SUMMAS+=VERT_S
                B:SUMMA1+=VERT_1
                B:SUMMA2+=VERT_2
                B:SUMMA3+=VERT_3
                B:SUMMAB+=VERT_B
                B:SUMMAV+=VERT_V
                B:SUMMAA+=VERT_A
                PUT(B_TABLE)
              .
              DO WRITENODALA !PAGAIDÂM REDUCÇJAM VISU UZ PÇDÇJO ATRASTO
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
  IF SEND(PAMAT,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:LINE)
    ELSE
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
    END
    KOPA='Kopâ:'
    NODALA=''
    KOEF= 0
    IF F:DBF='W'
        PRINT(RPT:REPFOOT2)
    ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_Sk,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_1k,@N_11.2))&CHR(9)&|
        LEFT(FORMAT(VERT_2k,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_3k,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_Bk,@N_11.2))&CHR(9)&|
        LEFT(FORMAT(VERT_Vk,@N_11.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_Ak,@N_11.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    KOPA='t.s. '
    loop i#= 1 to records(b_table)
      get(b_table,i#)
      KOEF =B:KOEF
      VERT_SK = B:summaS
      VERT_1K = B:summa1
      VERT_2K = B:summa2
      VERT_3K = B:summa3
      VERT_BK = B:summaB
      VERT_VK = B:SUMMAV
      VERT_AK = B:SUMMAA
      IF F:DBF='W'
          NodText = KOEF
          PRINT(RPT:REPFOOT2)
      ELSE
          OUTA:LINE=KOPA&LEFT(FORMAT(koef,@N_3.1))&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_Sk,@N_11.2))&CHR(9)&|
          LEFT(FORMAT(VERT_1k,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_2k,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_3k,@N_11.2))&CHR(9)&|
          LEFT(FORMAT(VERT_Bk,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_Vk,@N_11.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_Ak,@N_11.2))
          ADD(OUTFILEANSI)
      END
      KOPA=''
    .
    OUTA:LINE=''
    ADD(OUTFILEANSI)

    KOPA='t.s. '
    KOEF= 0
    loop i#= 1 to records(N_table)
      get(N_table,i#)
      NODALA  = N:NODALA
      VERT_SK = N:summaS
      VERT_1K = N:summa1
      VERT_2K = N:summa2
      VERT_3K = N:summa3
      VERT_BK = N:summaB
      VERT_VK = N:SUMMAV
      VERT_AK = N:SUMMAA
      IF NODALA
        NodText = GetNodalas(NODALA,1)
      ELSE
        NodText = 'Bez nodaïas'
      END
      IF F:DBF='W'
          PRINT(RPT:REPFOOT2)
      ELSE
          OUTA:LINE=KOPA&nodala&NodText&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_Sk,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_1k,@N_11.2))&|
          CHR(9)&LEFT(FORMAT(VERT_2k,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_3k,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_Bk,@N_11.2))&|
          CHR(9)&LEFT(FORMAT(VERT_Vk,@N_11.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_Ak,@N_11.2))
          ADD(OUTFILEANSI)
      END
      KOPA=''
    .
    IF F:DBF='W'
        PRINT(RPT:REPFOOT3)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    CLOSE(ProgressWindow)
    ENDPAGE(REPORT)
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
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
    KAT_K::Used -= 1
    IF KAT_K::Used = 0 THEN CLOSE(KAT_K).
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(B_TABLE)
  FREE(N_TABLE)
  IF F:DBF<>'W' THEN F:DBF='W'.
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
!  STOP(PAM:NOS_P&ERROR())
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAMAT')
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
WRITENODALA ROUTINE
     N:NODALA =AMO:NODALA
     GET(N_TABLE,N:NODALA)
     IF ERROR()
        N:NODALA =AMO:NODALA
!       EXECUTE N#
          N:SUMMAS=VERT_S
          N:SUMMA1=VERT_1
          N:SUMMA2=VERT_2
          N:SUMMA3=VERT_3
          N:SUMMAB=VERT_B
          N:SUMMAV=VERT_V
          N:SUMMAA=VERT_A
          ADD(N_TABLE)
          SORT(N_TABLE,N:NODALA)
!       .
     ELSE
          N:SUMMAS+=VERT_S
          N:SUMMA1+=VERT_1
          N:SUMMA2+=VERT_2
          N:SUMMA3+=VERT_3
          N:SUMMAB+=VERT_B
          N:SUMMAV+=VERT_V
          N:SUMMAA+=VERT_A
          PUT(N_TABLE)
     .
P_PNNIVAKK           PROCEDURE                    ! Declare Procedure
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

DAT                  LONG
LAI                  LONG
SAK_VK               DECIMAL(12,2),DIM(6)
ATL_VK               DECIMAL(12,2),DIM(6)
NOLIETOJUMS          DECIMAL(12,2),DIM(6)
U_NOLIETOJUMS        DECIMAL(12,2),DIM(6)
ATL_VKN              DECIMAL(12,2),DIM(6)
K1                   DECIMAL(12,2)
K2                   DECIMAL(12,2)
K3                   DECIMAL(12,2)
K4                   DECIMAL(12,2)
K5                   DECIMAL(12,2)
A_periods            string(60)

report REPORT,AT(198,5300,8000,8000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,1000,8000,4302),USE(?unnamed)
         STRING('Nodokïiem'),AT(6406,2240,1302,260),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('4. pielikums'),AT(6354,1667,,156),USE(?String85),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('VID 2000. gada 3. augusta'),AT(6354,1823,,156),USE(?String86)
         STRING('rîkojumam Nr. 586'),AT(6354,1979,,156),USE(?String87)
         STRING(@s40),AT(2031,1406,2969,208),USE(SYS:e_mail),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,2500,0,-313),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(6354,2500,1354,0),USE(?Line25),COLOR(COLOR:Black)
         STRING('Uzòçmuma (uzòçmçjsabiedrîbas) nosaukums'),AT(469,156),USE(?String3)
         STRING(@s45),AT(2906,135,3542,208),USE(CLIENT),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2188,417,0,260),USE(?Line27:2),COLOR(COLOR:Black)
         LINE,AT(2969,417,0,260),USE(?Line27:3),COLOR(COLOR:Black)
         LINE,AT(2188,417,781,0),USE(?Line32:2),COLOR(COLOR:Black)
         STRING('Reìistrâcijas Nr. UR'),AT(469,469),USE(?String75)
         STRING(@s9),AT(2240,469),USE(GL:REG_NR),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2188,677,781,0),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(2188,729,1094,0),USE(?Line36:2),COLOR(COLOR:Black)
         STRING('Nodokïu maksâtâja reì. Nr.'),AT(469,781),USE(?String77)
         STRING(@s13),AT(2240,781),USE(GL:VID_NR),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s12),AT(1042,1406,938,208),USE(SYS:TEL),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2188,990,1094,0),USE(?Line36),COLOR(COLOR:Black)
         STRING(@s40),AT(1042,1094,2969,208),USE(GL:ADRESE),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese'),AT(469,1094),USE(?String79)
         LINE,AT(2188,729,0,260),USE(?Line27:4),COLOR(COLOR:Black)
         LINE,AT(3281,729,0,260),USE(?Line27:5),COLOR(COLOR:Black)
         LINE,AT(6354,2188,0,313),USE(?Line27),COLOR(COLOR:Black)
         STRING('Tâlrunis'),AT(469,1406),USE(?String81)
         LINE,AT(6354,2188,1354,0),USE(?Line26),COLOR(COLOR:Black)
         STRING('PAMATLÎDZEKÏU  NOLIETOJUMA  UN  NEMATERIÂLO  IEGULDÎJUMU  VÇRTÎBAS'),AT(625,2604),USE(?String5), |
             CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('APRÇÍINA  KOPSAVILKUMA  KARTE'),AT(2396,2865),USE(?String6),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1375,3115,5031,188),USE(A_periods),CENTER,FONT(,9,,,CHARSET:ANSI)
         STRING('(EUR)'),AT(7083,3125,313,208),USE(?String7:2)
         LINE,AT(104,3333,7396,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Kategorija'),AT(135,3385,833,208),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kategorijas'),AT(1021,3385,1146,156),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikusî vçrtîba,'),AT(2240,3385,1146,156),USE(?String9:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojuma summa'),AT(3521,3385,1354,208),USE(?String8:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzkrâtais'),AT(4927,3385,833,208),USE(?String8:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikusî vçrtîba pçc'),AT(5813,3385,1667,208),USE(?String9:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7500,3333,0,990),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(5781,3333,0,990),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(4896,3333,0,990),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(3438,3333,0,990),USE(?Line3:3),COLOR(COLOR:Black)
         LINE,AT(2188,3333,0,990),USE(?Line3:2),COLOR(COLOR:Black)
         STRING('koriìçtâ vçrtîba'),AT(1021,3542,1146,156),USE(?String9:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no kuras aprçíina'),AT(2240,3542,1146,156),USE(?String9:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas periodâ'),AT(3521,3594,1354,208),USE(?String8:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietojums'),AT(4927,3594,833,208),USE(?String8:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas perioda'),AT(5813,3594,1667,208),USE(?String8:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas perioda'),AT(1021,3698,1146,156),USE(?String9:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas perioda'),AT(2240,3698,1146,156),USE(?String9:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('beigâs'),AT(1021,3854,1146,156),USE(?String9:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietojumu'),AT(2240,3844,1146,156),USE(?String9:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,4010,7396,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('1'),AT(135,4063,833,208),USE(?String8:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(1021,4063,1146,208),USE(?String9:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2229,4063,1146,208),USE(?String9:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(3521,4063,1354,208),USE(?String9:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(4927,4063,833,208),USE(?String8:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(5813,4063,1667,208),USE(?String8:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,4271,7396,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('nodokïiem'),AT(4927,3802,833,208),USE(?String8:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietojuma atskaitîðanas'),AT(5813,3802,1667,208),USE(?String8:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(990,3333,0,990),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(104,3333,0,990),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,3531),USE(?unnamed:2)
         LINE,AT(104,0,0,1875),USE(?Line11),COLOR(COLOR:Black)
         STRING('Pirmâ'),AT(208,0,469,208),USE(?String31),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,208,7396,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(1198,260),USE(SAK_VK[2]),RIGHT
         STRING(@N-_12.2),AT(2396,260),USE(ATL_VK[2]),RIGHT
         STRING(@N-_12.2),AT(3698,260),USE(NOLIETOJUMS[2]),RIGHT
         STRING(@N-_12.2),AT(4948,260),USE(U_NOLIETOJUMS[2]),RIGHT
         STRING('Otrâ'),AT(208,260,469,208),USE(?String31:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(6094,260),USE(ATL_VKN[2]),RIGHT
         LINE,AT(990,0,0,1875),USE(?Line11:2),COLOR(COLOR:Black)
         LINE,AT(2188,0,0,1875),USE(?Line11:6),COLOR(COLOR:Black)
         LINE,AT(3438,0,0,1875),USE(?Line11:3),COLOR(COLOR:Black)
         LINE,AT(4896,0,0,1875),USE(?Line11:7),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(4948,0),USE(U_NOLIETOJUMS[1]),RIGHT
         LINE,AT(5781,0,0,1875),USE(?Line11:4),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,1875),USE(?Line11:5),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(6094,0),USE(ATL_VKN[1]),RIGHT
         STRING(@N-_12.2),AT(3698,0),USE(NOLIETOJUMS[1]),RIGHT
         STRING(@N-_12.2),AT(2396,0),USE(ATL_VK[1]),RIGHT
         LINE,AT(104,469,7396,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('Treðâ'),AT(208,521,469,208),USE(?String31:3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(1198,521),USE(SAK_VK[3]),RIGHT
         STRING(@N-_12.2),AT(2396,521),USE(ATL_VK[3]),RIGHT
         STRING(@N-_12.2),AT(3698,521),USE(NOLIETOJUMS[3]),RIGHT
         STRING(@N-_12.2),AT(4948,521),USE(U_NOLIETOJUMS[3]),RIGHT
         STRING(@N-_12.2),AT(6094,521),USE(ATL_VKN[3]),RIGHT
         STRING(@N-_12.2),AT(1198,0),USE(SAK_VK[1]),RIGHT
         LINE,AT(104,729,7396,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('Ceturtâ'),AT(208,781,469,208),USE(?String31:4),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(1198,781),USE(SAK_VK[4]),RIGHT
         STRING(@N-_12.2),AT(2396,781),USE(ATL_VK[4]),RIGHT
         STRING(@N-_12.2),AT(3698,781),USE(NOLIETOJUMS[4]),RIGHT
         STRING(@N-_12.2),AT(4948,781),USE(U_NOLIETOJUMS[4]),RIGHT
         STRING(@N-_12.2),AT(6094,781),USE(ATL_VKN[4]),RIGHT
         LINE,AT(104,990,7396,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('Piektâ'),AT(208,1042,469,208),USE(?String31:5),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(1198,1042),USE(SAK_VK[5]),RIGHT
         STRING(@N-_12.2),AT(2396,1042),USE(ATL_VK[5]),RIGHT
         STRING(@N-_12.2),AT(3698,1042),USE(NOLIETOJUMS[5]),RIGHT
         STRING(@N-_12.2),AT(4948,1042),USE(U_NOLIETOJUMS[5]),RIGHT
         STRING(@N-_12.2),AT(6094,1042),USE(ATL_VKN[5]),RIGHT
         LINE,AT(104,1250,7396,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING('Nemateriâlie'),AT(208,1302,781,156),USE(?String31:6),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('X'),AT(1042,1354,1146,208),USE(?String9:13),CENTER
         STRING('X'),AT(2240,1354,1198,208),USE(?String9:14),CENTER
         STRING(@N-_12.2),AT(3698,1354),USE(NOLIETOJUMS[6]),RIGHT
         STRING(@N-_12.2),AT(4948,1354),USE(U_NOLIETOJUMS[6]),RIGHT
         STRING(@N-_12.2),AT(6094,1354),USE(ATL_VKN[6]),RIGHT
         STRING('ieguldîjumi'),AT(208,1458,781,156),USE(?String31:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1615,7396,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('KOPÂ'),AT(208,1667,469,208),USE(?String31:8),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(1198,1667),USE(K1),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(2396,1667),USE(K2),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(3698,1667),USE(K3),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(4948,1667),USE(K4),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(6094,1667),USE(K5),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1875,7396,0),USE(?Line1:10),COLOR(COLOR:Black)
         STRING(@D06.),AT(6438,1906),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7031,1906),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING('"X" - ailes netiek aizpildîtas.'),AT(208,1979,1458,156),USE(?String9:15),LEFT
         STRING('Vadîtâjs (îpaðnieks):'),AT(260,2396,1250,208),USE(?String31:9),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1510,2604,2292,0),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(3854,2604,2292,0),USE(?Line37:2),COLOR(COLOR:Black)
         STRING('paraksts'),AT(2240,2656,729,208),USE(?String92),CENTER
         STRING('paraksta atðifrçjums'),AT(4271,2656,1406,208),USE(?String92:2),CENTER
         STRING('Kopsavilkuma sastâdîtâjs:'),AT(2240,2969,1615,208),USE(?String31:10),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3854,3177,2292,0),USE(?Line37:3),COLOR(COLOR:Black)
         STRING('paraksts, paraksta atðifrçjums'),AT(4063,3229,1927,208),USE(?String92:3),CENTER
         STRING(@s30),AT(3906,2396),USE(sys:paraksts1),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
     END
Progress:Thermometer    BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
!  CHECKOPEN(SYSTEM,1)
!  CHECKOPEN(GLOBAL,1)
  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CheckOpen(PAMAT,1)
  CheckOpen(PAMKAT,1)
  CHECKOPEN(PAMAM,1)
  BIND(PAM:RECORD)
  BIND('GADS',GADS)

  A_PERIODS='Taksâcijas periods '&FORMAT(S_DAT,@D06.)&' '&FORMAT(B_DAT,@D06.)

  FilesOpened = True
  RecordsToProcess = 1
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Kopsavilkuma karte(GD)'
  ?Progress:UserString{Prop:Text}=''
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(PAMKAT)
      NEXT(PAMKAT)
      IF ERROR()
        KLUDA(0,'Nav uzbûvçta P/L vçrtîbas aprçíina karte...')
        POST(Event:CloseWindow)
        CYCLE
      END
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('PNNIVAKK.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Uzòçmuma (uzòçmçjsadarbîbas) nosaukums'&chr(9)&CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='Reìistrâcijas Nr. UR'&CHR(9)&GL:REG_NR
          ADD(OUTFILEANSI)
          OUTA:LINE='Nodokïu maksâtâja reì. Nr.'&CHR(9)&GL:VID_NR
          ADD(OUTFILEANSI)
          OUTA:LINE='Adrese'&CHR(9)&GL:ADRESE
          ADD(OUTFILEANSI)
          OUTA:LINE='Tâlrunis'&CHR(9)&SYS:TEL&CHR(9)&SYS:E_MAIL
          ADD(OUTFILEANSI)
          OUTA:LINE='PAMATLÎDZEKÏU NOLIETOJUMA UN NEMATERIÂLO IEGULDÎJUMU VÇRTÎBAS'
          ADD(OUTFILEANSI)
          OUTA:LINE='APRÇÍINA KOPSAVILKUMA KARTE'
          ADD(OUTFILEANSI)
          OUTA:LINE=A_PERIODS
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='Kategorija'&CHR(9)&'Kategorijas'&CHR(9)&'Atlikusî vçrtîba,'&CHR(9)&'Nolietojuma summa'&CHR(9)&|
             'Uzkrâtais'&CHR(9)&'Atlikusî vçrtîba pçc'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&'koriìçtâ vçrtîba'&CHR(9)&'no kuras aprçíina'&CHR(9)&'taksâcijas periodâ'&CHR(9)&|
             'nolietojums'&CHR(9)&'taksâcijas perioda'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&'taksâcijas perioda'&CHR(9)&'taksâcijas perioda'&CHR(9)&CHR(9)&'nodokïiem'&CHR(9)&|
             'nolietojuma atskaitîðanas'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&'beigâs'&CHR(9)&'nolietojumu'
             ADD(OUTFILEANSI)
             OUTA:LINE='1'&CHR(9)&'2'&CHR(9)&'3'&CHR(9)&'4'&CHR(9)&'5'&CHR(9)&'6'
             ADD(OUTFILEANSI)
          ELSE !WORD
             OUTA:LINE='Kategorija'&CHR(9)&'Kategorijas koriìçtâ vçrtîba taksâcijas perioda beigâs'&CHR(9)&|
             'Atlikusi vçrtîba, no kuras aprçíina taksâcijas perioda nolietojumu'&CHR(9)&|
             'Nolietojuma summa taksâcijas periodâ'&CHR(9)&'Uzkrâtais nolietojums nodokïiem'&CHR(9)&|
             'Atlikusi vçrtîba pçc taksâcijas perioda nolietojuma atskaitîðanas'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
        GADS=YEAR(B_DAT)
        IF ~INRANGE(GADS,1995,2014) THEN GADS=YEAR(TODAY()).  !2009-max
        Y#=GADS-1995+1    !GADA INDEKSS PAM: MASÎVÂ
        LOOP I#=1 TO 6
           IF ~PAK:SAK_V[I#,Y#]
              KLUDA(0,'Nav definçta '&I#&' kategorijas sâkotnçjâ vçrt. P/L vçrt. aprçíina kartç par '&GADS&'.gadu')
           .
           SAK_VK[I#]=PAK:SAK_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
           ATL_VK[I#]=PAK:ATL_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
           NOLIETOJUMS[I#]=PAK:NOLIETOJUMS[I#,Y#]
           U_NOLIETOJUMS[I#]=PAK:U_NOLIETOJUMS[I#,Y#]
           ATL_VKN[I#]=PAK:ATL_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]-PAK:NOLIETOJUMS[I#,Y#]
           K1+=SAK_VK[I#]
           K2+=ATL_VK[I#]
           K3+=NOLIETOJUMS[I#]
           K4+=U_NOLIETOJUMS[I#]
           K5+=ATL_VKN[I#]
        .
        LocalResponse = RequestCompleted
        CLOSE(ProgressWindow)
        BREAK
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
  IF SEND(PAMAT,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:DETAIL)
    ELSE
        OUTA:LINE='Pirmâ'&CHR(9)&LEFT(FORMAT(SAK_VK[1],@N-_12.2))&CHR(9)&LEFT(FORMAT(ATL_VK[1],@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(NOLIETOJUMS[1],@N-_12.2))&CHR(9)&LEFT(FORMAT(U_NOLIETOJUMS[1],@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(ATL_VKN[1],@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Otrâ'&CHR(9)&LEFT(FORMAT(SAK_VK[2],@N-_12.2))&CHR(9)&LEFT(FORMAT(ATL_VK[2],@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(NOLIETOJUMS[2],@N-_12.2))&CHR(9)&LEFT(FORMAT(U_NOLIETOJUMS[2],@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(ATL_VKN[2],@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Treðâ'&CHR(9)&LEFT(FORMAT(SAK_VK[3],@N-_12.2))&CHR(9)&LEFT(FORMAT(ATL_VK[3],@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(NOLIETOJUMS[3],@N-_12.2))&CHR(9)&LEFT(FORMAT(U_NOLIETOJUMS[3],@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(ATL_VKN[3],@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Ceturtâ'&CHR(9)&LEFT(FORMAT(SAK_VK[4],@N-_12.2))&CHR(9)&LEFT(FORMAT(ATL_VK[4],@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(NOLIETOJUMS[4],@N-_12.2))&CHR(9)&LEFT(FORMAT(U_NOLIETOJUMS[4],@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(ATL_VKN[4],@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Piektâ'&CHR(9)&LEFT(FORMAT(SAK_VK[5],@N-_12.2))&CHR(9)&LEFT(FORMAT(ATL_VK[5],@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(NOLIETOJUMS[5],@N-_12.2))&CHR(9)&LEFT(FORMAT(U_NOLIETOJUMS[5],@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(ATL_VKN[5],@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Nemat.ieg.'&CHR(9)&'X'&CHR(9)&'X'&CHR(9)&LEFT(FORMAT(NOLIETOJUMS[6],@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(U_NOLIETOJUMS[6],@N-_12.2))&CHR(9)&LEFT(FORMAT(ATL_VKN[6],@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ'&CHR(9)&LEFT(FORMAT(K1,@N-_12.2))&CHR(9)&LEFT(FORMAT(K2,@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(K3,@N-_12.2))&CHR(9)&LEFT(FORMAT(K4,@N-_12.2))&CHR(9)&LEFT(FORMAT(K5,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=' {60}'&format(dat,@D06.)&' '&Format(lai,@T4)
        ADD(OUTFILEANSI)
        OUTA:LINE='"X" - ailes netiek aizpildîtas.'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' Vadîtâjs (îpaðnieks):________________________'&SYS:PARAKSTS1
        ADD(OUTFILEANSI)
        OUTA:LINE=' {25}'&'paraksts'&' {12}'&'paraksta atðifrçjums'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' Kopsavilkuma sastâdîtâjs:_______________________________________'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {30}'&'paraksts'&' {10}'&'paraksta atðifrçjums'
        ADD(OUTFILEANSI)
    END
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
  ELSE           !WORD,EXCEL
     CLOSE(OUTFILEANSI)
     ANSIFILENAME=''
  .
  DO ProcedureReturn

!-----------------------------------------------------------------------------
ProcedureReturn ROUTINE
  POPBIND
  IF F:DBF<>'W' THEN F:DBF='W'.
  RETURN
P_NOLAPRGD           PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(PAMAT)
                       PROJECT(PAM:U_NR)
                       PROJECT(PAM:DATUMS)
                       PROJECT(PAM:NOS_P)
                       PROJECT(PAM:KAT)
                       PROJECT(PAM:NERAZ)
                       PROJECT(PAM:SAK_V_GD)
                       PROJECT(PAM:NOL_GD)
                       PROJECT(PAM:END_DATE)
                     END
VERT_S               DECIMAL(12,2)
VERT_SB              DECIMAL(12,2)
VERT_Nol_G           DECIMAL(12,2)
VERT_NOL_U           DECIMAL(12,2)
VERT_NON             DECIMAL(12,2)
VERT_B               DECIMAL(12,2)
KOPA                 STRING(15)
BKK                  STRING(5)
RAZ                  STRING(2)
VERT_SK              DECIMAL(12,2),DIM(3)
VERT_SBK             DECIMAL(12,2),DIM(3)
VERT_NOL_GK          DECIMAL(12,2),DIM(3)
VERT_NOL_UK          DECIMAL(12,2),DIM(3)
VERT_NONK            DECIMAL(12,2),DIM(3)
VERT_BK              DECIMAL(12,2),DIM(3)
KAT_NR               STRING(3)
DAT                  LONG
LAI                  LONG
VIRSRAKSTS           STRING(100)

report REPORT,AT(198,1698,8000,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,302,8000,1396),USE(?unnamed)
         STRING('nodokïu'),AT(3177,896,677,156),USE(?String13:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no gada'),AT(3958,938,729,208),USE(?String13:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietojums'),AT(5469,885,729,156),USE(?String13:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(6250,938,156,208),USE(?String13:3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D05.),AT(6406,938,469,208),USE(b_dat),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc sâk.'),AT(4740,938,677,208),USE(?String13:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(7031,938,156,208),USE(?String13:14),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d05.),AT(7188,938),USE(b_dat,,?b_dat:2),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('sâkuma'),AT(3958,1146,729,208),USE(?String13:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîbas'),AT(4740,1146,677,208),USE(?String13:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('+1994'),AT(5469,1198,729,156),USE(?String13:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('+1994'),AT(6250,1198,729,156),USE(?String13:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(5500,1031,156,156),USE(?String13:12),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d05.),AT(5656,1031,490,156),USE(b_dat,,?b_dat:3),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíinam'),AT(3156,1063,729,156),USE(?String13:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kat.'),AT(573,729,313,208),USE(?String13:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1354,7708,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s45),AT(1573,104,4375,198),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(52,292,7688,198),USE(VIRSRAKSTS),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('(ÌD metode)'),AT(3260,469,1010,198),USE(?String3:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma GD1'),AT(6250,469,677,156),USE(?String11),CENTER
         STRING(@P<<<#. lapaP),AT(6927,469,625,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(52,677,7708,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2813,677,0,729),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3906,677,0,729),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4688,677,0,729),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5417,677,0,729),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6198,677,0,729),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7760,677,0,729),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Uzsk. vçrt.'),AT(6250,729,729,208),USE(?String13:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. vçrtîba'),AT(3177,729,729,156),USE(?String13:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3125,677,0,729),USE(?Line2:21),COLOR(COLOR:Black)
         STRING('Nr'),AT(104,729,417,208),USE(?String13:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,677,0,729),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(885,677,0,729),USE(?Line2:22),COLOR(COLOR:Black)
         STRING('Nosaukums'),AT(938,729,1875,208),USE(?String13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('RA'),AT(2865,729,260,208),USE(?String13:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums'),AT(3958,729,729,208),USE(?String13:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6979,677,0,729),USE(?Line2:26),COLOR(COLOR:Black)
         STRING('Uzkrâtais'),AT(5469,729,729,156),USE(?String13:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Noòemts'),AT(4740,729,677,208),USE(?String13:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. vçrtîba'),AT(7031,729,729,208),USE(?String13:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,677,0,729),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N_6),AT(104,10,417,156),USE(PAM:U_NR),RIGHT
         LINE,AT(521,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@p#-##p),AT(573,10,,156),USE(KAT_NR),RIGHT
         LINE,AT(885,-10,0,198),USE(?Line2:24),COLOR(COLOR:Black)
         STRING(@S29),AT(938,10,,156),USE(PAM:NOS_P),LEFT
         LINE,AT(2813,-10,0,198),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(6250,10,677,156),USE(VERT_S),RIGHT(1)
         LINE,AT(6198,-10,0,198),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(3125,-10,0,198),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(4010,10,625,156),USE(VERT_NOL_G),RIGHT
         LINE,AT(6979,-10,0,198),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(5469,10,677,156),USE(VERT_NOL_U),RIGHT
         LINE,AT(7760,-10,0,198),USE(?Line2:20),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(4740,10,625,156),USE(VERT_NON),RIGHT
         STRING(@N-_13.2),AT(7031,10,677,156),USE(VERT_B),RIGHT
         STRING(@s2),AT(2896,10,156,156),USE(RAZ),CENTER
         STRING(@N-_13.2),AT(3177,10,677,156),USE(VERT_SB),RIGHT(1)
       END
detail1 DETAIL,AT(,,,94)
         LINE,AT(52,52,7708,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,115),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,63),USE(?Line50:1),COLOR(COLOR:Black)
         LINE,AT(885,-10,0,63),USE(?Line50:4),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,115),USE(?Line50:2),COLOR(COLOR:Black)
         LINE,AT(3125,-10,0,115),USE(?Line50:3),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,115),USE(?Line50:11),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,115),USE(?Line50:5),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,115),USE(?Line50:6),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,115),USE(?Line50:7),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,115),USE(?Line50:12),COLOR(COLOR:Black)
         LINE,AT(7760,-10,0,115),USE(?Line50:8),COLOR(COLOR:Black)
       END
RepFoot1 DETAIL,AT(,,,458)
         LINE,AT(52,-10,0,478),USE(?Line3:10),COLOR(COLOR:Black)
         STRING(@S15),AT(156,10,,156),USE(KOPA),LEFT
         STRING('izmanto raþoðanâ :'),AT(156,156,1250,156),USE(?BKK),LEFT(1)
         LINE,AT(2813,-10,0,478),USE(?Line3:11),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(6250,10,677,156),USE(VERT_SK[1]),RIGHT(1)
         LINE,AT(3125,-10,0,478),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,478),USE(?Line3:22),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,478),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,478),USE(?Line3:14),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(4010,10,625,156),USE(VERT_NOL_GK[1]),RIGHT
         LINE,AT(6198,-10,0,478),USE(?Line3:15),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,478),USE(?Line3:19),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(5469,10,677,156),USE(VERT_NOL_UK[1]),RIGHT
         LINE,AT(7760,-10,0,478),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(4740,10,625,156),USE(VERT_NONK[1]),RIGHT
         STRING(@N-_13.2),AT(7031,10,677,156),USE(VERT_BK[1]),RIGHT
         STRING(@N-_13.2),AT(3177,156,677,156),USE(VERT_SBK[2]),RIGHT(1)
         STRING(@N-_13.2),AT(4010,156,625,156),USE(VERT_NOL_GK[2]),RIGHT
         STRING(@N-_13.2),AT(7031,156,677,156),USE(VERT_BK[2]),RIGHT
         STRING(@N-_13.2),AT(6250,156,677,156),USE(VERT_SK[2]),RIGHT(1)
         STRING(@N-_13.2),AT(5469,156,677,156),USE(VERT_NOL_UK[2]),RIGHT
         STRING(@N-_13.2),AT(4740,156,625,156),USE(VERT_NONK[2]),RIGHT
         STRING('neizmanto raþoðanâ :'),AT(156,313,1250,156),USE(?BKK:2),LEFT(1)
         STRING(@N-_13.2),AT(3177,313,677,156),USE(VERT_SBK[3]),RIGHT(1)
         STRING(@N-_13.2),AT(6250,313,677,156),USE(VERT_SK[3]),RIGHT(1)
         STRING(@N-_13.2),AT(5469,313,677,156),USE(VERT_NOL_UK[3]),RIGHT
         STRING(@N-_13.2),AT(4740,313,625,156),USE(VERT_NONK[3]),RIGHT
         STRING(@N-_13.2),AT(7031,313,677,156),USE(VERT_BK[3]),RIGHT
         STRING(@N-_13.2),AT(4010,313,625,156),USE(VERT_NOL_GK[3]),RIGHT
         STRING(@N-_13.2),AT(3177,10,677,156),USE(VERT_SBK[1]),RIGHT(1)
       END
RepFoot3 DETAIL,AT(,,,240),USE(?unnamed:2)
         LINE,AT(52,-10,0,63),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,63),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(3125,-10,0,63),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,63),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,63),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,63),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,63),USE(?Line36:2),COLOR(COLOR:Black)
         LINE,AT(7760,-10,0,63),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(52,52,7708,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(94,83),USE(?String54),FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(552,83),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6677,83),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7281,83),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(198,11000,8000,52)
         LINE,AT(52,0,7708,0),USE(?Line1:4),COLOR(COLOR:Black)
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
  DAT = TODAY()
  LAI = CLOCK()
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  BIND('S_DAT',S_DAT)
  BIND('PAM:END_DATE',PAM:END_DATE)

  VIRSRAKSTS='Nosacîtais nolietojuma aprçíins,neòemot vçrâ kategorijas izmaiòas '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAM)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Nolietojums (ÌD)'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAM,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(PAM:RECORD)
      SET(PAM:NR_KEY,PAM:NR_KEY)
      Process:View{Prop:Filter} = '~INRANGE(PAM:END_DATE,DATE(1,1,1900),S_DAT-1)' !NAV NOÒEMTS IEPR.G-OS
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
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        GADS=YEAR(B_DAT)
        IF YEAR(PAM:DATUMS)<1995
           Y#=GADS-1995+1       !INDEKSS PAM:NOL_GD
        ELSE
           Y#=GADS-YEAR(PAM:DATUMS)+1
        .
        VERT_NOL_G=PAM:NOL_GD[Y#]
        VERT_NOL_U=PAM:NOL_V
        LOOP I#=1 TO Y#
           VERT_NOL_U+=PAM:NOL_GD[I#]
        .
        IF INRANGE(PAM:END_DATE,S_DAT,B_DAT) !NOÒEMTS ÐAJÂ GADÂ
           VERT_SB   =0
           VERT_NON  =VERT_SB+VERT_NOL_U-VERT_NOL_G
           VERT_S    =0
           VERT_NOL_U=0
        ELSE
           VERT_SB   =PAM:SAK_V_GD[Y#]
           VERT_S    =VERT_SB+VERT_NOL_U-VERT_NOL_G
           VERT_NON  =0
        .
        VERT_B    =VERT_S-VERT_NOL_U
        KAT_NR    =PAM:KAT[Y#]
        IF PAM:NERAZ
           RAZ='nç'
           VERT_SBK[3]   +=VERT_SB
           VERT_NOL_GK[3]+=VERT_NOL_G
           VERT_NONK[3]  +=VERT_NON
           VERT_NOL_UK[3]+=VERT_NOL_U
           VERT_SK[3]    +=VERT_S
           VERT_BK[3]    +=VERT_B
        ELSE
           RAZ='jâ'
           VERT_SBK[2]   +=VERT_SB
           VERT_NOL_GK[2]+=VERT_NOL_G
           VERT_NONK[2]  +=VERT_NON
           VERT_NOL_UK[2]+=VERT_NOL_U
           VERT_SK[2]    +=VERT_S
           VERT_BK[2]    +=VERT_B
        .
        PRINT(RPT:DETAIL)
        VERT_SBK[1]   +=VERT_SB
        VERT_NOL_GK[1]+=VERT_NOL_G
        VERT_NONK[1]  +=VERT_NON
        VERT_NOL_UK[1]+=VERT_NOL_U
        VERT_SK[1]    +=VERT_S
        VERT_BK[1]    +=VERT_B
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
  IF SEND(PAMAT,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:DETAIL1)
    PRINT(RPT:REPFOOT1)
    PRINT(RPT:REPFOOT3)
    ENDPAGE(REPORT)
!    IF F:DBF='W'
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
!    ELSE
!        CLOSE(OUTFILEANSI)
!        RUN('WORDPAD '&ANSIFILENAME)
!        IF RUNCODE()=-4
!            KLUDA(88,'Wordpad.exe')
!        .
!    .
  END
!  IF F:DBF='W'
      CLOSE(report)
      FREE(PrintPreviewQueue)
      FREE(PrintPreviewQueue1)
!  ELSE
!      ANSIFILENAME=''
!  END
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
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
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
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAMAT')
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
